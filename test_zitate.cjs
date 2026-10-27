// Testet die tatsächliche Auswahl- und Darstellungslogik ohne Browser/Netzwerk.
const fs = require('node:fs');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const path = require('node:path');
const source = fs.readFileSync(path.join(__dirname, 'vorlage.html'), 'utf8');
for (const s of source.matchAll(/<script(?:\s[^>]*)?>([\s\S]*?)<\/script>/g)) new vm.Script(s[1]);
const state = new Map();
const zitate = JSON.parse(fs.readFileSync(path.join(__dirname, 'zitate.json')));
const c = { ZITATE: zitate, db: { get: (k, d) => state.get(k) ?? d, set: (k, v) => state.set(k, v),
  objekt: p => Object.fromEntries([...state].filter(([k]) => k.startsWith(p)).map(([k, v]) => [k.slice(p.length), v])) },
  esc: s => String(s ?? '').replace(/[&<>\"]/g, x => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[x])),
  wählen: (xs, rnd) => xs[Math.floor(rnd() * xs.length)], heuteIso: () => '2026-10-27' };
vm.createContext(c);
vm.runInContext(source.slice(source.indexOf('function zufall('), source.indexOf('const wählen =')), c);
vm.runInContext(source.slice(source.indexOf('function richtungEinst()'), source.indexOf('function zitatEreignisse(')), c);
const datum = n => new Date(Date.UTC(2026, 9, 27 + n)).toISOString().slice(0, 10);
const ids = [];
for (let n = 0; n < zitate.length; n++) {
  const tag = datum(n), z = c.tagesZitat(tag);
  ids.push(z.id); assert.equal(c.tagesZitat(tag).id, z.id, 'Neuladen am selben Tag bleibt stabil');
}
assert.equal(new Set(ids).size, zitate.length, 'Kein Zitat wiederholt sich vor dem Ende der Sammlung');
assert.equal(c.tagesZitat(datum(zitate.length)).id, ids[0], 'Danach beginnt die Wiederholung mit dem am längsten nicht gezeigten Zitat');
const neu = { id: 'neuer-netzeintrag', text: 'Ein neuer Text.', autor: 'Neue Person', quelle: 'https://example.org/geheim', werk: 'Nur interner Beleg', original: 'Internal original' };
zitate.push(neu);
assert.equal(c.tagesZitat(datum(zitate.length)).id, neu.id, 'Nach einer Erweiterung kommen neue Zitate vor Wiederholungen');
assert.equal(c.tagesZitat(datum(0)).id, ids[0], 'Eine Erweiterung ändert das bereits angezeigte Tageszitat nicht');
state.set('einst:richtung', { favoriten: ['feynman-verstehen'], nurFavoriten: true });
assert.equal(c.tagesZitat('2028-01-01').id, 'feynman-verstehen');
assert.equal(c.tagesZitat('2028-01-02').id, 'feynman-verstehen');
state.set('einst:richtung', { favoriten: ['nicht-mehr-vorhanden'], nurFavoriten: true });
assert(c.tagesZitat('2028-01-03'), 'Leere Favoritenauswahl fällt auf die ganze Sammlung zurück');
const html = c.zitatHtml({ ...neu, text: '<script>Text</script>' });
assert(html.includes('&lt;script&gt;Text&lt;/script&gt;'));
assert(html.includes('Neue Person'));
for (const verborgen of ['https://example.org', 'Nur interner Beleg', 'Internal original', 'Quelle nachlesen', 'Originalwortlaut']) assert(!html.includes(verborgen));
console.log('OK: JavaScript-Syntax; Tagesstabilität; kompletter Umlauf ohne Wiederholung; Wachstum; Favoriten; sichere Anzeige nur mit Zitat und Name.');
