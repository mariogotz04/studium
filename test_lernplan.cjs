// Aufgabenplan (seit 11.11.2026): gleichmäßige Verteilung ohne Zeitbudget, 14 Tage Probephase,
// stabile laufende Woche, automatische Aufnahme neuer Aufgaben, Historie, Dateiname der Wochen-PDF.
const assert = require('node:assert/strict');
const L = require('./lernplan.js');

const katalog = (n, ok = new Set(), name = 'TM') => [{ name, pdf: 'x.pdf', sections: [1, 2, 3].map(k => ({ key: `lernpfad:${name}:${k}:0`, label: `Abschnitt ${k}.1`,
  items: Array.from({ length: n }, (_, i) => ({ id: `${name}-${k}-${i}`, title: `Aufgabe ${k}.${i}`, min: 15, ok: ok.has(`${name}-${k}-${i}`) })) })) }];
const exam = (date, modules = ['TM']) => ({ id: 'e-' + modules.join('+'), date, title: 'Klausur', modules, duration: 90 });

// Grundverteilung: alle Aufgaben vor der Probephase, gleichmäßig, Reihenfolge erhalten
const heute = '2026-11-11', klausur = exam('2027-01-26');
let p = L.create({}, katalog(10), [klausur], { today: heute, version: 'a' });
const auf = p.units.filter(u => u.type === 'aufgaben');
assert.equal(auf.length, 30);
const stoffEnde = L.add('2027-01-26', -14);
assert.ok(auf.every(u => u.week && u.week < stoffEnde), 'Alle Aufgaben liegen vor der Probephase');
for (let i = 1; i < auf.length; i++) assert.ok(auf[i - 1].week <= auf[i].week, 'Lernreihenfolge bleibt erhalten');
const proWoche = {};
for (const u of auf) proWoche[u.week] = (proWoche[u.week] || 0) + 1;
const voll = Object.entries(proWoche).filter(([w]) => w > L.week(heute)).map(([, n]) => n);
assert.ok(Math.max(...voll) - Math.min(...voll) <= 1, 'Volle Wochen sind gleich stark belegt: ' + JSON.stringify(proWoche));
assert.ok(proWoche[L.week(heute)] < Math.max(...voll), 'Angebrochene Woche zählt anteilig');
const probe = p.units.filter(u => u.type === 'probe');
assert.equal(probe.length, 2, 'Zwei Probeklausuren');
assert.ok(probe.every(u => u.notBefore >= stoffEnde && u.notBefore < '2027-01-26'));
assert.equal(p.units.filter(u => u.type === 'wiederholung').length, 2);
assert.equal(L.needsUpdate(p, katalog(10), [klausur], heute), '');

// Kein Zeitbudget mehr in der Konfiguration
assert.deepEqual(Object.keys(L.config({ weeklyMinutes: 900 })).sort(), ['exams', 'probe']);
assert.equal(L.config({}).probe, 14);

// Neue Aufgaben in derselben Woche: laufende Woche bleibt stabil, Neues ab nächster Woche
const mehr = katalog(12);
assert.equal(L.needsUpdate(p, mehr, [klausur], heute), 'inhalt');
const diese = p.units.filter(u => u.week === L.week(heute)).map(u => u.id).sort();
const q = L.create({}, mehr, [klausur], { old: p, today: '2026-11-13', version: 'b' });
assert.deepEqual(q.units.filter(u => u.week === L.week(heute)).map(u => u.id).sort(), diese, 'Laufende Woche unverändert');
assert.equal(q.added, 6);
assert.equal(q.units.filter(u => u.type === 'aufgaben').length, 36);
assert.ok(q.units.filter(u => u.type === 'aufgaben' && !p.units.some(x => x.id === u.id)).every(u => u.week > L.week(heute)), 'Neue Aufgaben ab nächster Woche');

// Wochenwechsel: Nicht Geschafftes wird auf die restlichen Wochen verteilt, Erledigtes bleibt Historie
const erledigt = new Set(q.units.filter(u => u.week === L.week(heute)).slice(0, 2).map(u => u.id));
const status = u => ({ done: erledigt.has(u.id) });
const naechste = '2026-11-16';
assert.equal(L.needsUpdate(q, mehr, [klausur], naechste), 'woche');
const okIds = new Set(q.units.filter(u => erledigt.has(u.id)).map(u => u.targets[0]));
const r = L.create({}, katalog(12, okIds), [klausur], { old: q, status, today: naechste, version: 'c' });
assert.ok(r.units.filter(u => erledigt.has(u.id)).every(u => u.week === L.week(heute)), 'Historie bleibt in ihrer Woche');
assert.ok(r.units.filter(u => u.type === 'aufgaben' && !erledigt.has(u.id)).every(u => u.week >= L.week(naechste)), 'Offenes wandert nach vorn');
assert.equal(r.units.filter(u => u.type === 'aufgaben').length, 36);

// Gemeinsame Klausur zweier Module und zwei Klausuren
const zwei = [...katalog(4, new Set(), 'Investitionsrechnung'), ...katalog(4, new Set(), 'Finanzierung'), ...katalog(4, new Set(), 'GET')];
const s = L.create({}, zwei, [exam('2027-01-28', ['Finanzierung', 'Investitionsrechnung']), exam('2027-02-02', ['GET'])], { today: heute });
for (const m of ['Investitionsrechnung', 'Finanzierung']) assert.ok(s.units.filter(u => u.module === m && u.type === 'aufgaben').every(u => u.week < L.add('2027-01-28', -14)));
assert.ok(s.units.filter(u => u.module === 'GET' && u.type === 'aufgaben').every(u => u.week < L.add('2027-02-02', -14)));
// Auswahl von Klausuren
const nurGet = L.create({ exams: ['e-GET'] }, zwei, [exam('2027-01-28', ['Finanzierung', 'Investitionsrechnung']), exam('2027-02-02', ['GET'])], { today: heute });
assert.deepEqual([...new Set(nurGet.units.map(u => u.module))], ['GET']);

// Klausur zu nah für eine Stoffphase: nichts geht verloren, Hinweis
const nah = L.create({}, katalog(3), [exam('2026-11-20')], { today: heute });
assert.equal(nah.units.filter(u => u.type === 'aufgaben' && u.week).length, 9);
assert.ok(nah.warnings.some(w => /keine Woche mehr/.test(w)));

// Status
const u0 = L.create({}, katalog(2), [klausur], { today: heute }).units.find(u => u.targets[0] === 'TM-1-0');
const cat = katalog(2, new Set(['TM-1-0']));
assert.equal(L.status(u0, cat).done, true);
assert.equal(L.status({ ...u0, targets: ['TM-1-1'] }, cat).done, false);
assert.equal(L.status({ ...u0, targets: ['TM-1-1'] }, cat, { manual: true }).done, true);
const pr = { module: 'TM', type: 'probe', notBefore: '2027-01-12', targets: ['probe'] };
assert.equal(L.status(pr, cat, { activities: [{ modul: 'TM', art: 'probe', fertig: true, tag: '2027-01-10' }] }).done, false);
assert.equal(L.status(pr, cat, { activities: [{ modul: 'TM', art: 'probe', fertig: true, tag: '2027-01-13' }] }).done, true);

// Kalenderwoche und Jahr für den Dateinamen
assert.equal(L.kw('2026-11-16'), 47);
assert.equal(L.kw('2027-01-11'), 2);
assert.equal(L.kwYear('2027-01-11'), 2027);
assert.equal(L.kwYear('2026-12-28'), 2026);
assert.equal(L.duration(90), '1 Std. 30 Min.');

// Verständnisfragen zählen im Plan pauschal 3 Minuten, Rechenaufgaben mit ihrer Schätzung
const gemischt = [{ name: 'TM', pdf: 'x.pdf', sections: [{ key: 'lernpfad:TM:1:0', label: 'Abschnitt 1.1', items: [
  { id: 'r', title: 'Rechnen', art: 'rechnen', min: 20, ok: false }, { id: 'v', title: 'Warum?', art: 'verstehen', min: 12, ok: false }] }] }];
const pg = L.create({}, gemischt, [klausur], { today: heute, version: 'g' });
const mins = Object.fromEntries(pg.units.filter(u => u.type === 'aufgaben').map(u => [u.targets[0], u.min]));
assert.deepEqual(mins, { r: 20, v: 3 });

console.log('OK: gleichmäßige Verteilung ohne Budget; Probephase; stabile Woche; neue Aufgaben automatisch; Wochenwechsel mit Historie; gemeinsame Klausur; Auswahl; nahe Klausur; Status; KW/Jahr; Verständnisfragen 3 Min.');
