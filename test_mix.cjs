// Rückkehr und Bewertungen einer Mix-Serie mit der tatsächlichen Seiten- und Routinglogik.
const fs = require('node:fs');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const path = require('node:path');
const source = fs.readFileSync(path.join(__dirname, 'vorlage.html'), 'utf8');
const state = new Map(), stand = new Map(), aktiv = [];
const clone = x => x == null ? x : JSON.parse(JSON.stringify(x));
const nodes = new Map();
const node = key => {
  if (!nodes.has(key)) nodes.set(key, { addEventListener(event, fn) { this[event] = fn; } });
  return nodes.get(key);
};
const view = {
  html: '',
  set innerHTML(s) { this.html = s; nodes.clear(); },
  get innerHTML() { return this.html; },
  querySelectorAll(selector) {
    if (selector !== '.bewerten button') return [];
    return [...this.html.matchAll(/<button[^>]*data-s="([^"]+)"[^>]*>/g)].map(([html, s], i) => {
      const b = node('bew-' + i);
      b.dataset = { s, id: (html.match(/data-id="([^"]+)"/) || [])[1] };
      return b;
    });
  },
};
const m = { name: 'Finanzierung', aufgaben: Array.from({ length: 7 }, (_, i) => ({
  id: 'a' + i, nr: i + 1, k: 'Kapitel ' + i, t: 'Aufgabe ' + i, art: 'rechnen', a: {}, erg: {}, s: [{}, {}],
})) };
const c = {
  LERNEN: [m], DECKS: [], lernView: view, location: { hash: '' },
  store: { get: (k, d) => clone(state.has(k) ? state.get(k) : d), set: (k, v) => state.set(k, clone(v)) },
  db: { get: (k, d) => stand.get(k) ?? d, set: (k, v) => stand.set(k, v) },
  aufgabeStand: a => stand.get(`aufgabe:${m.name}:${a.id}`),
  quizStand: () => null, kartenStand: () => ({}),
  lernAktivität: (...args) => aktiv.push(args),
  $: selector => node(selector), esc: String, kopf: () => {}, baustein: () => '<img>', quellenLink: () => '',
  heuteIso: () => '2026-10-28', iso: d => d.toISOString().slice(0, 10),
  lernImpuls: () => '', meldung: () => {}, richtungEinst: () => ({ impulse: false }),
  document: { body: { classList: { remove() {} } }, getElementById: () => ({}),
    querySelector: () => null, querySelectorAll: () => [] },
  window: { scrollTo() {}, scrollY: 0 }, pdfAnsicht: { hidden: true }, pomodoro: { tick() {} },
  setTimeout() {}, clearInterval() {}, sitzung: null, quizRunde: null,
  modulSeite: () => { view.innerHTML = 'Modulauswahl'; },
};
vm.createContext(c);
vm.runInContext(source.slice(source.indexOf('function kapitelSchlüssel('), source.indexOf('function vorschläge(')), c);
vm.runInContext(source.slice(source.indexOf('let offenAufgabe = null;'), source.indexOf('/* Quiz: Einfachauswahl')), c);
vm.runInContext(source.slice(source.indexOf('const VIEWS ='), source.indexOf('window.addEventListener("hashchange"')), c);
const zurück = '#lernen/Finanzierung/probe';
const ids = ['a5', 'a1', 'a4', 'a0', 'a3']; // absichtlich anders als im Modul; zwei Aufgaben gehören nicht zur Serie
const lauf = mix => ({ modul: m.name, ids, start: Date.UTC(2026, 9, 27, 20), ab: Date.UTC(2026, 9, 27, 21),
  dauer: 60, mix, bew: {}, erg: { a5: 1 }, tag: '2026-10-27' });
const gehen = ziel => { c.location.hash = ziel; c.route(); };
const bewerten = (id, s) => {
  const button = view.querySelectorAll('.bewerten button').find(b => b.dataset.s === s && (!id || b.dataset.id === id));
  assert(button, 'Bewertungsbutton vorhanden'); button.onclick();
};

state.set('probe:lauf', { ...lauf(true), ab: 0 });
gehen(zurück);
nodes.get('#pab').onclick({ target: node('#pab') });
assert.equal(node('#pab').textContent, 'Wirklich abgeben?');
assert.equal(state.get('probe:lauf').ab, 0, 'Erster Klick gibt noch nicht ab');
nodes.get('#pab').onclick({ target: node('#pab') });
assert(view.html.includes('Mix-Serie geschafft'));
assert(view.html.includes('Noch 5 offen.'));
assert(view.html.includes('Selbst gelöst mit Fehlern'));
assert.equal((view.html.match(/Lösung Schritt für Schritt<\/a>/g) || []).length, 5);
assert(view.html.includes(`${zurück}/aufgabe/a5`));
assert.equal(aktiv.length, 0, 'Abgeben allein schließt die Serie nicht ab');

state.set('probe:lauf', lauf(true));
state.set('lernen:filter', 'verstehen'); // der Modulfilter darf keine Mix-Aufgabe ausblenden
gehen(`${zurück}/aufgabe/a5`);
assert(view.html.includes('Zur Mix-Übersicht'));
assert(view.html.includes('1 / 5'));
assert(view.html.includes(`${zurück}/aufgabe/a1`));
assert(!view.html.includes('/aufgabe/a6'));
node('#weiter').click();
assert(view.html.includes('Schritt 1 von 2'));
assert(!view.html.includes('Schritt 2 von 2'));
gehen(zurück);
assert(view.html.includes('Noch 5 offen.'));
assert(view.html.includes('Ergebnis zum Vergleichen'), 'Aufgedecktes Ergebnis bleibt erhalten');
assert.deepEqual(state.get('probe:lauf').ids, ids);

bewerten('a5', 'hilfe');
assert(view.html.includes('Noch 4 offen.'));
assert(view.html.includes('hilfe gewählt'));
gehen(`${zurück}/aufgabe/a1`);
node('#alle').click();
bewerten(null, 'nein');
assert.equal(c.location.hash, zurück, 'Bewertung in der Lösung führt zur Serienübersicht');
c.route();
assert(view.html.includes('Noch 3 offen.'));
assert.equal(stand.get('aufgabe:Finanzierung:a1').n, 1, 'Bewertung nur einmal gespeichert');
assert.equal(aktiv.filter(([art]) => art === 'mix').length, 0);
for (const id of ids.slice(2)) bewerten(id, 'ok');
assert(view.html.includes('Alles bewertet'));
assert.equal(aktiv.filter(([art]) => art === 'mix').length, 1);
assert(aktiv.every(args => args[4] === '2026-10-27'), 'Bewertungen und Abschluss gehören zum Starttag');
assert.equal(stand.get(`probe:Finanzierung:${lauf(true).start}`).n, 5);
assert.equal(stand.get(`probe:Finanzierung:${lauf(true).start}`).ok, 3);

gehen(`${zurück}/aufgabe/a1`);
c.route(); // wie beim erneuten Öffnen: Kontext kommt aus Adresse und gespeichertem Versuch
assert(view.html.includes('Zur Mix-Übersicht'));
assert(view.html.includes('2 / 5'));
gehen(`${zurück}/aufgabe/a6`);
assert(view.html.includes('Mix-Serie geschafft'), 'Fremde Aufgabe führt zur Serienübersicht');
state.set('probe:lauf', lauf(false));
gehen(`${zurück}/aufgabe/a5`);
assert(view.html.includes('Zur Auswertung'), 'Auch Probeklausuren behalten ihren Kontext');
state.set('probe:lauf', null);
gehen(`${zurück}/aufgabe/a5`);
assert.equal(view.html, 'Modulauswahl', 'Ohne gespeicherten Versuch sichere Rückkehr zur Auswahl');
state.set('lernen:filter', 'alle');
gehen('#lernen/Finanzierung/aufgabe/a0');
assert(view.html.includes('1 / 7'));
assert(view.html.includes('href="#lernen/Finanzierung"'));
node('#alle').click();
bewerten(null, 'ok');
assert.equal(c.location.hash, '#lernen/Finanzierung/aufgabe/a1', 'Einzelaufgaben behalten ihre Navigation');
// Der Reihe nach: nicht gelöst → die Aufgabe bleibt; gelöst → nächste offene; offene Karten sperren das nächste Kapitel
stand.clear();
gehen('#lernen/Finanzierung/aufgabe/a0');
node('#alle').click();
bewerten(null, 'nein');
assert.equal(c.location.hash, '#lernen/Finanzierung/aufgabe/a0', 'Nicht geschaffte Aufgabe bleibt dran');
stand.set('aufgabe:Finanzierung:a1', { s: 'ok', n: 1 });
c.DECKS = [{ name: 'Finanzierung', cards: [{ id: 'k2', k: 'Kapitel 2', n: '2.1' }] }];
node('#alle').click();
bewerten(null, 'ok');
assert.equal(c.location.hash, '#lernen/Finanzierung/aufgabe/a2', 'Gelöste Aufgabe springt zur nächsten offenen');
gehen('#lernen/Finanzierung/aufgabe/a2');
node('#alle').click();
bewerten(null, 'ok');
assert.equal(c.location.hash, '#lernen/Finanzierung', 'Kapitel 3 erst, wenn die Karten aus Kapitel 2 gelernt sind');
assert.equal(c.lernreihe('Finanzierung').front.kurz, 'Kapitel 2');
c.kartenStand = () => ({ k2: { typ: 'wdh', lapses: 0 } });
assert.equal(c.lernreihe('Finanzierung').front.kurz, 'Kapitel 3');
console.log('OK: Abgabebestätigung; fünf Mix-Aufgaben; einzelne Lösungsschritte; Rückkehr mit Ergebnis/Bewertung; Serienabschluss erst nach allen Bewertungen; Starttag; Probeklausur; Einzelaufgaben.');
