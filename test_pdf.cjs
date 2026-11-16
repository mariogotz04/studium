// Echte Export-/Sicherungslogik mit iPad-User-Activation: der zweite Tipp muss
// dieselbe fertige Datei synchron ans Teilen-Menü übergeben, ohne neuen PDF-Build.
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const html = fs.readFileSync(path.join(__dirname, 'vorlage.html'), 'utf8');
const ui = fs.readFileSync(path.join(__dirname, 'lernplan-ui.js'), 'utf8');
function setup(app = true) {
  const stats = { builds: 0, fetches: 0, shared: [], revoked: [], downloads: [], opened: [], messages: [] };
  let serial = 0;
  const c = {
    APP: app, DATA: [], Blob, File, console, setTimeout() {},
    location: { pathname: '/studium/', origin: 'https://example.test' },
    URL: class extends URL {
      static createObjectURL() { return 'blob:test-' + ++serial; }
      static revokeObjectURL(href) { stats.revoked.push(href); }
    },
    navigator: {
      canShare: () => true,
      share: async ({ files }) => {
        if (!c.active) throw Object.assign(new Error('Erneut tippen'), { name: 'NotAllowedError' });
        stats.shared.push(files[0]);
      },
    },
    fetch: async () => { stats.fetches++; c.active = false; return { ok: true, blob: async () => new Blob(['%PDF-1.7']) }; },
    document: {
      body: { appendChild() {} }, addEventListener() {},
      createElement: () => ({ setAttribute() {}, click() { stats.downloads.push(this); }, remove() {} }),
    },
    pdfOeffnen: href => stats.opened.push(href), meldung: text => stats.messages.push(text),
    heuteIso: () => '2026-11-16', Lernplan: require('./lernplan.js'),
    lpDatei: null, lpExportWoche: '',
    lpPlan: () => ({}), lpKatalog: () => [],
    lpWochenEinheiten: () => [{ type: 'aufgaben', module: 'TM', targets: ['a'] }],
    LERNEN: [{ name: 'TM', ablatt: 'TM_Blatt.pdf', aufgaben: [{ id: 'a', s: [] }] }],
    lpAufgabe: () => ({}), lpHerkunft: () => 'Original', aufgabeMinuten: () => 15,
    lpStand: () => ({ done: false }),
    LernplanPDF: { wochenblatt: async () => { stats.builds++; c.active = false; return new Uint8Array([37, 80, 68, 70]); } },
  };
  c.window = c;
  vm.createContext(c);
  vm.runInContext(html.slice(html.indexOf('const pdfNamen ='), html.indexOf('// Jeder Quellenlink')), c);
  vm.runInContext(ui.slice(ui.indexOf('function lpBlattName(')), c);
  const button = () => ({ textContent: 'Aufgaben KW 47 als PDF', dataset: {}, disabled: false });
  return { c, stats, button };
}
(async () => {
  const { c, stats, button } = setup();
  const b = button();
  await c.lpBlattPdf('2026-11-16', b);
  assert.equal(b.textContent, 'Jetzt sichern');
  assert.equal(b.disabled, false);
  const href = c.lpDatei, fetches = stats.fetches;
  c.active = true;
  await c.lpBlattPdf('2026-11-16', b);
  assert.equal(stats.shared.length, 1, 'Zweiter Tipp öffnet das Teilen-Menü');
  assert.equal(stats.builds, 1, 'Keine erneute PDF-Erzeugung beim Sichern');
  assert.equal(stats.fetches, fetches, 'Kein asynchrones Nachladen beim zweiten Tipp');
  assert.equal(c.lpDatei, href);
  assert.equal(stats.revoked.length, 0, 'Fertige PDF bleibt gültig');
  assert.equal(stats.shared[0].name, 'Aufgaben KW 47.pdf');
  assert.equal(stats.shared[0].type, 'application/pdf');
  assert.equal(b.textContent, 'Aufgaben KW 47 als PDF');
  // Ein regulärer neuer Export erzeugt wieder den aktuellen Aufgabenstand.
  await c.lpBlattPdf('2026-11-16', b);
  assert.equal(stats.builds, 2);
  assert.deepEqual(stats.revoked, [href]);
  // Erneute Blockade bleibt sichtbar und die Datei bleibt zum Sichern bereit.
  await c.lpBlattPdf('2026-11-16', b);
  assert.equal(stats.builds, 2);
  assert.equal(b.textContent, 'Jetzt sichern');
  assert.ok(stats.messages.length, 'Blockierte Sicherung zeigt eine Rückmeldung');
  // Abbruch des Teilen-Menüs: Button zurücksetzen; nächster Export wieder frisch.
  c.navigator.share = async () => { throw Object.assign(new Error('Abgebrochen'), { name: 'AbortError' }); };
  await c.lpBlattPdf('2026-11-16', b);
  assert.equal(b.textContent, 'Aufgaben KW 47 als PDF');
  await c.lpBlattPdf('2026-11-16', b);
  assert.equal(stats.builds, 3);
  // Unerwartete Share-Fehler dürfen nicht lautlos verschwinden.
  c.navigator.share = async () => { throw new Error('Teilen fehlgeschlagen'); };
  await c.lpBlattPdf('2026-11-16', b);
  assert.ok(stats.opened.length, 'Vorschau als Ausweichmöglichkeit');
  assert.ok(stats.messages.some(t => /fehlgeschlagen|nicht.*geteilt/i.test(t)));
  // Ohne Datei-Teilen wird weiterhin die integrierte Vorschau geöffnet.
  const fallback = setup();
  fallback.c.navigator.canShare = () => false;
  await fallback.c.lpBlattPdf('2026-11-16', fallback.button());
  assert.equal(fallback.stats.opened.length, 1);
  // Browser-Download bleibt direkt verfügbar.
  const browser = setup(false);
  await browser.c.lpBlattPdf('2026-11-16', browser.button());
  assert.equal(browser.stats.downloads[0].download, 'Aufgaben KW 47.pdf');
  console.log('OK: iPad-PDF beim zweiten Tipp ohne Neuberechnung geteilt; frischer Folgeexport; Blockade; Abbruch; Fehler und Vorschau; Browser-Download.');
})().catch(e => { console.error(e); process.exitCode = 1; });
