// Zeichnen, Neuaufbau derselben Frage und Verwerfen beim Fragenwechsel ohne Browser-Speicher.
const fs = require('node:fs');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const path = require('node:path');
const source = fs.readFileSync(path.join(__dirname, 'vorlage.html'), 'utf8');
let beobachter = 0;
function element(tag = 'div') {
  const e = { tag, children: [], dataset: {}, clientWidth: 300, clientHeight: 400,
    classList: { add() {}, remove() {}, toggle() {} },
    appendChild(c) { if (c.parent) c.parent.children.splice(c.parent.children.indexOf(c), 1); this.children.push(c); c.parent = this; },
    append(...cs) { cs.forEach(c => this.appendChild(c)); },
    remove() { if (this.parent) this.parent.children.splice(this.parent.children.indexOf(this), 1); },
    get firstChild() { return this.children[0]; },
    addEventListener(art, fn) { this[art] = fn; }, focus() {}, setAttribute(k, v) { this[k] = v; },
    setPointerCapture() {}, releasePointerCapture() {}, hasPointerCapture() { return false; },
    getBoundingClientRect() { return { left: 0, top: 0, width: 300, height: 400 }; },
    getContext() { return new Proxy({}, { get: () => () => {} }); },
    querySelector(s) { return this.nodes[s]; },
    querySelectorAll() { return [this.nodes.stift, this.nodes.radierer]; },
    set innerHTML(html) {
      if (tag !== 'details') { this.children = []; return; }
      this.nodes = { canvas: element('canvas'), stift: element('button'), radierer: element('button'),
        '[data-notiz="zurueck"]': element('button'), '[data-notiz="leeren"]': element('button') };
      this.nodes.stift.dataset.werkzeug = 'stift'; this.nodes.radierer.dataset.werkzeug = 'radierer';
    },
  };
  return e;
}
const c = { document: { body: element(), createElement: element }, window: { innerWidth: 1180, devicePixelRatio: 2 },
  ResizeObserver: class { observe() { beobachter++; } disconnect() { beobachter--; } },
};
vm.createContext(c);
vm.runInContext(source.slice(source.indexOf('let notizZustand ='), source.indexOf('function quellenLink(')), c);
const zustand = () => vm.runInContext('notizZustand', c);
const bereich = element(), frage = {};
function aufbauen(k = frage) {
  bereich.innerHTML = '';
  c.notizenAnzeigen(bereich, k);
  const blatt = bereich.children[0].children[1];
  return { blatt, canvas: blatt.nodes.canvas };
}
const event = (type, x, y, pointerType = 'pen', pointerId = 1) => ({ type, clientX: x, clientY: y,
  pointerType, pointerId, button: 0, preventDefault() {} });
let { blatt, canvas } = aufbauen();
canvas.onpointerdown(event('pointerdown', 30, 40));
canvas.onpointermove(event('pointermove', 90, 120));
canvas.onpointerup(event('pointerup', 150, 200));
assert.equal(zustand().striche.length, 1);
assert.equal(zustand().striche[0].punkte.length, 3);
assert.equal(zustand().striche[0].punkte[0][0], .1);
({ blatt, canvas } = aufbauen());
assert.equal(beobachter, 1, 'Alter ResizeObserver wird freigegeben');
assert.equal(zustand().striche.length, 1, 'Lösung aufdecken erhält die Notizen');
blatt.nodes.radierer.onclick();
canvas.onpointerdown(event('pointerdown', 60, 80));
canvas.onpointerup(event('pointerup', 100, 100));
assert.equal(zustand().striche[1].werkzeug, 'radierer');
blatt.nodes['[data-notiz="zurueck"]'].onclick();
assert.equal(zustand().striche.length, 1, 'Radieren lässt sich rückgängig machen');
blatt.open = false; blatt.toggle();
({ blatt, canvas } = aufbauen());
assert.equal(blatt.open, false, 'Einklappen bleibt innerhalb derselben Frage erhalten');
assert.equal(zustand().striche.length, 1);
blatt.nodes['[data-notiz="leeren"]'].onclick();
assert.equal(zustand().striche.length, 0);
canvas.onpointerdown(event('pointerdown', 30, 40, 'touch'));
canvas.onpointerdown(event('pointerdown', 60, 80, 'pen', 2));
canvas.onpointerup(event('pointerup', 90, 100, 'pen', 2));
assert.equal(zustand().striche.length, 1, 'Stift erhält Vorrang vor einer aufliegenden Hand');
aufbauen({});
assert.equal(zustand().striche.length, 0, 'Nächste Frage erhält ein leeres Blatt');
c.notizenBeenden();
assert.equal(zustand(), null, 'Verlassen der Übung verwirft sämtliche Notizen');
assert.equal(beobachter, 0);
c.window.innerWidth = 390;
assert.equal(aufbauen({}).blatt.open, false, 'Auf kleinen Displays zunächst eingeklappt');
c.notizenBeenden();
console.log('OK: Notizen zeichnen, radieren, zurücknehmen, aufdecken, einklappen und beim Wechsel verwerfen.');
