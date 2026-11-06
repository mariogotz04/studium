// Lernreihenfolge gegen die tatsächlichen Auswahlfunktionen; optional zusätzlich mit veröffentlichten Moduldaten.
const fs = require('node:fs');
const vm = require('node:vm');
const path = require('node:path');
const assert = require('node:assert/strict');
const source = fs.readFileSync(path.join(__dirname, 'vorlage.html'), 'utf8');
const moduleNamen = ['FET', 'GET', 'Finanzierung', 'Investitionsrechnung', 'Konstruktion', 'Physik', 'technische Mechanik'];
const clone = x => JSON.parse(JSON.stringify(x));
function umgebung(lernen, decks) {
  const state = new Map(), settings = new Map(), meldungen = [];
  const c = { LERNEN: lernen, DECKS: decks, PLAN: { termine: [], tage: {} }, alleModule: lernen.map(m => m.name),
    document: { getElementById: () => ({}), addEventListener() {} }, location: { hash: '' },
    db: { get: (k, d) => state.get(k) ?? d, set: (k, v) => state.set(k, clone(v)),
      objekt: p => Object.fromEntries([...state].filter(([k, v]) => k.startsWith(p) && v != null).map(([k, v]) => [k.slice(p.length), clone(v)])) },
    store: { get: (k, d) => settings.get(k) ?? d, set: (k, v) => settings.set(k, clone(v)) },
    aufgabeStand: a => state.get(`aufgabe:${a.m.name}:${a.id}`), quizStand: f => state.get(`quiz:${f.m.name}:${f.id}`),
    heuteIso: () => '2026-11-06', tagPlus: (s, n) => new Date(Date.parse(s) + n * 864e5).toISOString().slice(0, 10),
    fristen: () => [], klausurInfo: () => ({ typ: 'transfer', dauer: 90 }), meldung: s => meldungen.push(s),
    esc: String, route() {}, kapitelVon: xs => [...new Set(xs.map(x => x.k).filter(Boolean))],
  };
  for (const m of lernen) for (const teil of ['aufgaben', 'quiz']) (m[teil] || []).forEach(x => x.m = m);
  for (const d of decks) d.cards.forEach(x => x.d = d);
  vm.createContext(c);
  vm.runInContext(source.slice(source.indexOf('function zufall('), source.indexOf('/* ───────────── Daten,')), c);
  vm.runInContext(source.slice(source.indexOf('function kapitelSchlüssel('), source.indexOf('/* Persönliche Richtung')), c);
  vm.runInContext(source.slice(source.indexOf('const TAG ='), source.indexOf('function zeigen()')), c);
  vm.runInContext(source.slice(source.indexOf('const aufgabeMinuten ='), source.indexOf('function probeEinstellungen(')), c);
  vm.runInContext(source.slice(source.indexOf('let quizRunde ='), source.indexOf('const normal =')), c);
  c.zeigen = () => {};
  return { c, state, settings, meldungen, queue: () => vm.runInContext('sitzung?.queue.map(c => c.id) || []', c),
    quiz: () => vm.runInContext('quizRunde?.fragen.map(x => x.f) || []', c) };
}
const item = (id, n, extra = {}) => ({ id, n, k: `Kapitel ${n.split('.')[0]}`, ...extra });
const lernen = moduleNamen.map(name => ({ name,
  aufgaben: [item('a1', '1.1', { t: 'Erste Aufgabe', art: 'rechnen', s: [{}] }), item('a2', '1.2', { t: 'Spätere Aufgabe', art: 'rechnen', s: [{}] })],
  quiz: [item('q1', '1.1'), item('q2', '1.2'), item('q3', '2.1')],
}));
const decks = moduleNamen.map(name => ({ name, cards: [item('c0', '1.0'), item('c1', '1.1'), item('c11', '1.1.1'),
  item('c2', '1.2'), item('c10', '1.10'), item('c3', '2.1')] }));
const u = umgebung(lernen, decks), { c, state, settings } = u;
const gelernt = { typ: 'wdh', due: 0, lapses: 0 };
for (const name of moduleNamen) {
  state.set(`karte:${name}:c0`, gelernt);
  state.set(`karte:${name}:c11`, { typ: 'lernen', due: 0, schritt: 1 });
  state.set(`karte:${name}:c2`, gelernt); // früher schon angeklickter späterer Stoff
  state.set(`karte:${name}:c3`, gelernt);
  const d = decks.find(d => d.name === name), m = lernen.find(m => m.name === name), r = c.lernreihe(name);
  assert.equal(r.schritt.kurz, 'Abschnitt 1.1', name);
  assert.equal(r.erreicht(d.cards.find(x => x.id === 'c2')), false);
  assert.deepEqual(Array.from(c.fälligeKarten(d, ''), x => x.id), ['c0', 'c11']);
  assert.equal(c.zählen(d).due, 2);
  assert.equal(c.zählen(d).neu, 1);
  for (const modus of ['plan', 'fällig', 'frei']) {
    c.starten(d, '', modus);
    assert(u.queue().length > 0);
    assert(u.queue().every(id => ['c0', 'c1', 'c11'].includes(id)), `${name}: ${modus}`);
  }
  c.starten(d, '', 'plan', ['c1', 'c2', 'c3']);
  assert.deepEqual(Array.from(u.queue()), ['c1'], 'Alte gespeicherte Karten-IDs werden erneut geprüft');
  c.starten(d, '', 'fällig', ['c1', 'c11', 'c2']);
  assert.deepEqual(Array.from(u.queue()), ['c11'], 'Nur fällige mischt keine neuen Karten hinein');
  c.quizStarten(m, { ids: ['q1', 'q2', 'q3'] });
  assert.deepEqual(Array.from(u.quiz(), f => f.id), ['q1']);
  c.quizStarten(m, { kapitel: '' });
  assert.deepEqual(Array.from(u.quiz(), f => f.id), ['q1'], 'Alle Kapitel hält die Grenze ein');
  c.probeStarten(m, true);
  assert.deepEqual(Array.from(settings.get('probe:lauf').ids), ['a1']);
}
c.quizStarten({ name: 'abschluss', abschluss: true, quiz: lernen.flatMap(m => m.quiz) }, { anzahl: 100 });
assert(u.quiz().every(f => f.id === 'q1'), 'Auch der Tagesabschluss berücksichtigt die Grenze jedes Ursprungsmoduls');
for (const v of c.vorschläge('2026-11-06')) {
  const geprüft = c.vorschlagPrüfen({ ...v, art: v.key.split(':')[0], kapitel: v.key.split(':').slice(2).join(':') });
  assert(geprüft, 'Neue Vorschläge liegen im Lernpfad');
}
const valid = { key: 'karten:GET:reihe', art: 'karten', modul: 'GET', kapitel: 'reihe', ids: ['c1'], titel: 'Gültige Auswahl', text: '1 Karte' };
const fertig = { key: 'karten:Physik:alt', art: 'karten', modul: 'Physik', ids: ['c3'], titel: 'Schon erledigt' };
state.set('erledigt:2026-11-06', { [fertig.key]: true });
state.set('tagesplan:2026-11-06', { v: 2, erstellt: 1, items: [
  { key: 'fällig:FET', art: 'fällig', modul: 'FET', ids: ['c2', 'c3'] }, valid, fertig,
  { key: 'quiz:Konstruktion:reihe', art: 'quiz', modul: 'Konstruktion', ids: ['q1', 'q2'], anzahl: 2 },
] });
const plan = c.tagesPlan();
assert.equal(plan.v, 3);
assert.equal(plan.items[0].modul, 'FET');
assert.equal(plan.items[0].art, 'aufgabe', 'Unzulässiger offener Vorschlag wird durch den aktuellen Schritt desselben Moduls ersetzt');
assert.deepEqual(plan.items[1], valid);
assert.deepEqual(plan.items[2], fertig, 'Fertige Tageshistorie bleibt unverändert');
assert.deepEqual(Array.from(plan.items[3].ids), ['q1']);
assert.equal(plan.items[3].anzahl, 1);
assert.equal(JSON.stringify(c.tagesPlan()), JSON.stringify(plan), 'Bereinigter Tagesplan bleibt stabil');
c.vorschlagStarten({ key: 'fällig:FET', art: 'fällig', modul: 'FET', ids: ['c0', 'c2'] });
assert.deepEqual(settings.get('karten:start'), { modul: 'FET', ids: ['c0'], modus: 'fällig' });
assert.deepEqual(state.get('karte:FET:c2'), gelernt, 'Spätere Bewertungen und Termine bleiben erhalten');
state.set('aufgabe:FET:a1', { s: 'ok' }); state.set('quiz:FET:q1', { ok: true });
state.set('karte:FET:c1', gelernt); state.set('karte:FET:c11', gelernt);
c.lernFortschritt('FET');
assert.equal(c.lernreihe('FET').schritt.kurz, 'Abschnitt 1.2');
state.set('quiz:FET:q1', { ok: false });
assert.equal(c.lernreihe('FET').schritt.kurz, 'Abschnitt 1.2', 'Ein Wiederholungsfehler setzt den Lernpfad nicht zurück');
assert(c.fälligeKarten(decks[0], '').some(x => x.id === 'c2'), 'Nach Freigabe kehrt die frühere Fälligkeit zurück');
assert(c.abschnittVergleich(item('x', '1.2'), item('y', '1.10')) < 0, 'Numerische Abschnittsreihenfolge');
assert(c.kapitelSchlüssel({ k: 'TM1 · Statik', n: '7.2' }) < c.kapitelSchlüssel({ k: 'TM2 · Dynamik', n: 'TM2 1.1' }), 'TM1 vor TM2');
assert.equal(c.kapitelSchlüssel({ k: 'Kapitel 7–12', n: '9.2' }), 1009, 'Sammelüberschriften nutzen die Quelle');

if (process.argv[2]) {
  const live = fs.readFileSync(process.argv[2], 'utf8');
  const daten = vm.createContext({});
  for (const key of ['LERNEN', 'DECKS']) vm.runInContext(live.match(new RegExp(`^const ${key} = .*;$`, 'm'))[0] + `\nglobalThis.${key.toLowerCase()} = ${key};`, daten);
  const echt = umgebung(daten.lernen, daten.decks);
  let abschnitte = 0;
  for (const m of daten.lernen) {
    let vorher = null;
    while (true) {
      const r = echt.c.lernreihe(m.name), s = r.schritt;
      if (!s) break;
      if (vorher) assert(vorher.s < s.s || (vorher.s === s.s && vorher.nr < s.nr), `${m.name}: Fortschritt ohne Sprünge rückwärts`);
      const d = daten.decks.find(d => d.name === m.name);
      if (d) {
        echt.c.starten(d, '', 'plan', d.cards.map(x => x.id));
        assert(echt.queue().every(id => r.erreicht(d.cards.find(x => x.id === id))), `${m.name}: echte Karten bleiben im erreichten Abschnitt`);
      }
      echt.c.quizStarten(m, { anzahl: 1000 });
      assert(echt.quiz().every(f => f.m !== m || r.erreicht(f)), `${m.name}: echte Quizfragen bleiben im Lernpfad`);
      for (const a of s.aufgaben) echt.state.set(`aufgabe:${m.name}:${a.id}`, { s: 'ok' });
      for (const f of s.quiz) echt.state.set(`quiz:${m.name}:${f.id}`, { ok: true });
      for (const k of s.karten) echt.state.set(`karte:${m.name}:${k.id}`, gelernt);
      echt.c.lernFortschritt(m.name);
      vorher = s; abschnitte++;
      assert(abschnitte < 2000, 'Lernpfad endet');
    }
  }
  console.log(`OK: Echte veröffentlichte Daten: ${daten.lernen.length} Module, ${abschnitte} Abschnitte vollständig der Reihe nach durchlaufen.`);
}
console.log('OK: Alle sieben Module; Abschnittsgrenzen; fällige/neue/freie Karten; gespeicherte IDs; Quiz; Tagesabschluss; Mix; Tagesplan-Migration; stabile Abschlüsse; Lernstanderhalt; TM1/TM2.');
