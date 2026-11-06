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
    captures: new Set(),
    setPointerCapture(id) { this.captures.add(id); },
    releasePointerCapture(id) { this.captures.delete(id); this.onlostpointercapture?.({ type: 'lostpointercapture', pointerId: id }); },
    hasPointerCapture(id) { return this.captures.has(id); },
    getBoundingClientRect() { return { left: 0, top: 0, width: 300, height: 400 }; },
    getContext() { return new Proxy({}, { get: () => () => {} }); },
    querySelector(s) { return this.nodes[s]; },
    querySelectorAll() { return [this.nodes.stift, this.nodes.radierer]; },
    set innerHTML(html) {
      if (tag !== 'details') { this.children = []; return; }
      this.nodes = { canvas: element('canvas'), stift: element('button'), radierer: element('button'),
        output: element('output') };
      for (const art of ['zurueck', 'leeren', 'zoom-aus', 'zoom-ein', 'ursprung', 'kleiner', 'größer']) {
        this.nodes[`[data-notiz="${art}"]`] = element('button');
      }
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
assert.equal(blatt.open, false, 'Auch auf dem iPad zunächst eingeklappt');
blatt.open = true; blatt.toggle();
const drücken = art => blatt.nodes[`[data-notiz="${art}"]`].onclick();
canvas.onpointerdown(event('pointerdown', 30, 40, 'touch', 10));
canvas.onpointermove(event('pointermove', 80, 90, 'touch', 10));
assert.equal(zustand().striche.length, 0, 'Handballen vor dem Pencil erzeugt keine Punkte');
canvas.onpointerup(event('pointerup', 80, 90, 'touch', 10));
canvas.onpointerdown(event('pointerdown', 30, 40, 'mouse'));
assert.equal(zustand().striche.length, 0, 'Nur der Stift schreibt');
canvas.onpointerdown(event('pointerdown', 30, 40));
canvas.onpointermove(event('pointermove', 90, 120));
canvas.onpointerup(event('pointerup', 150, 200));
assert.equal(zustand().striche.length, 1);
assert.equal(zustand().striche[0].punkte.length, 3);
assert.equal(zustand().striche[0].punkte[0][0], 30, 'Striche liegen in Weltkoordinaten');
const punkte = JSON.stringify(zustand().striche[0].punkte);
drücken('größer');
assert.equal(zustand().größe, 2);
assert.equal(blatt.nodes['[data-notiz="größer"]'].disabled, true);
assert.equal(JSON.stringify(zustand().striche[0].punkte), punkte, 'Blattgröße verzerrt keine Striche');
canvas.onpointerdown(event('pointerdown', 100, 100, 'touch', 10));
canvas.onpointerdown(event('pointerdown', 200, 100, 'touch', 11));
canvas.onpointermove(event('pointermove', 300, 100, 'touch', 11));
assert.equal(zustand().ansicht.zoom, 2, 'Pinch vergrößert um den Abstandsfaktor');
assert.equal(zustand().ansicht.x, -100, 'Der Mittelpunkt der Geste bleibt auf demselben Weltpunkt');
assert.equal(zustand().ansicht.y, -100);
canvas.onpointerup(event('pointerup', 100, 100, 'touch', 10));
canvas.onpointercancel(event('pointercancel', 300, 100, 'touch', 11));
canvas.onpointerdown(event('pointerdown', 100, 100));
canvas.onpointerup(event('pointerup', 120, 120));
assert.equal(zustand().striche[1].punkte[0][0], 100, 'Pencilposition wird durch den Zoom zurückgerechnet');
drücken('zurueck');
({ blatt, canvas } = aufbauen());
assert.equal(beobachter, 1, 'Alter ResizeObserver wird freigegeben');
assert.equal(zustand().striche.length, 1, 'Lösung aufdecken erhält die Notizen');
assert.equal(zustand().ansicht.zoom, 2, 'Aufdecken erhält den Bildausschnitt');
assert.equal(zustand().größe, 2, 'Aufdecken erhält die Blattgröße');
drücken('ursprung');
assert.equal(zustand().ansicht.zoom, 1);
assert.equal(zustand().ansicht.x, 0);
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
canvas.onpointerdown(event('pointerdown', 30, 40, 'touch', 10));
canvas.onpointerdown(event('pointerdown', 60, 80, 'pen', 2));
canvas.onpointerdown(event('pointerdown', 100, 100, 'touch', 11));
canvas.onpointermove(event('pointermove', 200, 200, 'touch', 11));
assert.equal(zustand().ansicht.zoom, 1, 'Handballen beim Schreiben verändert die Ansicht nicht');
canvas.onpointerup(event('pointerup', 90, 100, 'pen', 2));
assert.equal(zustand().striche.length, 1, 'Stift erhält Vorrang vor einer aufliegenden Hand');
canvas.onpointermove(event('pointermove', 250, 250, 'touch', 11));
assert.equal(zustand().ansicht.zoom, 1, 'Aufliegende Hand bleibt auch nach Abheben des Stifts gesperrt');
canvas.onpointerup(event('pointerup', 250, 250, 'touch', 11));
canvas.onpointerup(event('pointerup', 30, 40, 'touch', 10));
canvas.onpointerdown(event('pointerdown', 10, 10, 'touch', 10));
canvas.onpointerdown(event('pointerdown', 110, 10, 'touch', 11));
canvas.onpointermove(event('pointermove', 1010, 1010, 'touch', 10));
canvas.onpointermove(event('pointermove', 1110, 1010, 'touch', 11));
assert.equal(zustand().ansicht.zoom, 1);
assert.equal(zustand().ansicht.x, 1000, 'Unbegrenztes Verschieben ohne Seitenrand');
assert.equal(zustand().ansicht.y, 1000);
canvas.onpointerup(event('pointerup', 1010, 1010, 'touch', 10));
canvas.onpointerup(event('pointerup', 1110, 1010, 'touch', 11));
canvas.onpointerdown(event('pointerdown', 30, 40));
canvas.onpointercancel(event('pointercancel', 30, 40));
assert.equal(zustand().striche.at(-1).punkte[0][0], -970, 'Auch jenseits des ursprünglichen Blatts beschreibbar');
drücken('ursprung');
for (let i = 0; i < 20; i++) drücken('zoom-ein');
assert.equal(zustand().ansicht.zoom, 5);
for (let i = 0; i < 40; i++) drücken('zoom-aus');
assert(Math.abs(zustand().ansicht.zoom - .2) < 1e-9);
let verhindert = 0;
blatt.oncontextmenu({ preventDefault() { verhindert++; } });
blatt.onselectstart({ preventDefault() { verhindert++; } });
assert.equal(verhindert, 2, 'Kein Kontextmenü und keine Textauswahl auf dem Notizblatt');
aufbauen({});
assert.equal(zustand().striche.length, 0, 'Nächste Frage erhält ein leeres Blatt');
c.notizenBeenden();
assert.equal(zustand(), null, 'Verlassen der Übung verwirft sämtliche Notizen');
assert.equal(beobachter, 0);
c.window.innerWidth = 390;
assert.equal(aufbauen({}).blatt.open, false, 'Auf kleinen Displays zunächst eingeklappt');
c.notizenBeenden();
console.log('OK: Nur Pencil schreibt; Handballenschutz, Zwei-Finger-Zoom/Pan, unendliche Fläche, Blattgröße, Erhalt und Verwerfen.');
