// Claude-Arbeitsfassung: Bilder liegen im Unterordner abbildungen/. Keine Pakete erforderlich.
// Dieses gesamte Projekt in Typst hochladen; diese .typ-Datei als Hauptdatei öffnen.
#set document(title: "Fluid- und Energietechnik – Feynman-Lernskript, anschauliche Fassung", author: "Lernzusammenfassung")
#let navy = rgb("244f70")
#let teal = rgb("16746d")
#let ink = rgb("24323d")
#let muted = rgb("627380")
#let pale = rgb("eef4f8")
#let mint = rgb("eef7f2")
#let sand = rgb("fff6e5")
#let vartheta = sym.theta.alt
#let seitenfuss = context [
  #line(length: 100%, stroke: 0.45pt + rgb("d7e1e8"))
  #v(1.5mm)
  #text(size: 8pt, fill: muted)[Feynman-Lernskript · Stand 14.11.2026]
  #h(1fr)
  #text(size: 9pt, fill: navy)[Seite #counter(page).display("1") von #counter(page).final().first()]
]
#set page(paper: "a4", margin: (left: 20mm, right: 19mm, top: 19mm, bottom: 20mm),
 header: [#text(size: 8pt, fill: muted)[Fluid- und Energietechnik #h(1fr) Sehen · Verstehen · Erklären]], footer: seitenfuss)
#set text(font: "Libertinus Serif", size: 11pt, lang: "de", fill: ink, hyphenate: true)
#set par(justify: false, leading: 0.5em, spacing: 0.55em)
#set heading(numbering: none)
#set list(indent: 1.1em, body-indent: 0.5em, spacing: 0.35em)
#set enum(indent: 1.25em, body-indent: 0.5em, spacing: 0.55em)
#set math.equation(numbering: none)
#show heading.where(level: 1): it => block(above: 0.5em, below: 0.8em, sticky: true)[
 #text(size: 24pt, weight: "bold", fill: navy, it.body)
 #v(1.5mm) #line(length: 100%, stroke: 1pt + navy)
]
#show heading.where(level: 2): it => block(above: 1em, below: 0.6em, sticky: true)[
 #text(size: 15pt, weight: "bold", fill: navy, it.body)
]
#show heading.where(level: 3): it => block(above: 0.7em, below: 0.35em, sticky: true)[
 #text(size: 11.5pt, weight: "bold", fill: teal, it.body)
]
#show math.equation.where(block: true): it => block(above: 0.45em, below: 0.45em, breakable: false)[#it]
#let note(title, body, fill: mint) = block(width: 100%, fill: fill, inset: (x: 9pt, y: 7pt),
 above: 0.5em, below: 0.5em, breakable: false)[#text(fill: teal, weight: "bold", title) #parbreak() #body]
#let src(body) = block(above: 0.35em, below: 0.4em)[#text(size: 8pt, fill: muted)[*Grundlage:* #body]]
#let nachschlagen(body) = block(above: 0.25em, below: 0.3em, breakable: false)[#text(size: 8.5pt, fill: teal)[*Nachschlagen:* #body]]
// Verweis auf eine Stelle in DIESEM Lernskript mit automatischer Seitenzahl (für neue Lösungen).
// Überschrift mit Label versehen, z. B. === 2.12 Neues Thema <a-2-12>, dann #nachschlagen[Lernskript, #stelle(<a-2-12>)]
#let stelle(ziel) = context {
  let el = query(ziel).first()
  link(ziel)[Abschnitt #el.body, S. #counter(page).at(el.location()).first()]
}
#let form(body) = block(width: 100%, fill: pale, inset: (x: 7pt, y: 5pt), above: 0.5em, below: 0.5em, breakable: false)[#body]
#let tab(..args) = {
 set text(size: 9.6pt)
 set par(leading: 0.4em, spacing: 0.25em, justify: false)
 table(inset: 6pt, stroke: 0.35pt + rgb("cfdae2"), ..args)
}
#let th(..cells) = table.header(..cells.pos().map(c => table.cell(fill: pale)[#strong(c)]))

// ─── Überblick-Ebenen und Chunkmaps (in allen Modulen gleich) ─────────────────
// Ebene 0: Seite „Das Modul auf einen Blick“ nach dem Wegweiser (Label <ueberblick>).
// Ebene 1: unter jeder Kapitelüberschrift (Label <a-n>) #überblick mit #idee-Links und eine #karte oder ein #ablauf.
// Ebene 2: die Abschnitte; am Ende jedes Abschnitts #hoch(<a-n>, [Kapitelübersicht]).
// Die Kästen sind keine Überschriften: Inhaltsverzeichnis und PDF-Lesezeichen bleiben unverändert.
#let chunk(titel, begriffe, ziel: none, fill: pale, stroke: navy) = {
  let kasten = block(width: 100%, fill: fill, stroke: 0.6pt + stroke, radius: 4pt, inset: (x: 6pt, y: 5pt), breakable: false)[
    #set par(leading: 0.35em, spacing: 0.35em, justify: false)
    #set text(hyphenate: true)
    #text(size: 9pt, weight: "bold", fill: navy, titel)
    #if begriffe != none [#parbreak() #text(size: 7.8pt, fill: muted, begriffe)]
  ]
  if ziel == none { kasten } else { link(ziel, kasten) }
}
#let pfeil(beschriftung: none, zeichen: sym.arrow.r) = align(center + horizon, stack(dir: ttb, spacing: 2pt,
  ..(if beschriftung != none { (text(size: 6.8pt, fill: teal, beschriftung),) } else { () }),
  text(size: 13pt, fill: teal, zeichen)))
// Chunkmap als Raster: #karte((1fr, auto, 1fr), chunk(..), pfeil(..), chunk(..))
#let karte(spalten, ..zellen) = block(width: 100%, breakable: false, above: 0.7em, below: 0.7em,
  grid(columns: spalten, column-gutter: 3pt, row-gutter: 7pt, align: center + horizon, ..zellen))
// Flussdiagramm von oben nach unten: #ablauf(chunk(..), entscheidung(..), chunk(..))
#let ablauf(breite: 80%, ..schritte) = block(width: 100%, breakable: false, above: 0.7em, below: 0.7em, align(center,
  stack(dir: ttb, spacing: 2pt, ..schritte.pos().enumerate().map(((i, x)) =>
    (if i > 0 { (text(size: 12pt, fill: teal, sym.arrow.b),) } else { () }) + (block(width: breite, x),)).flatten())))
#let entscheidung(frage, ja, nein) = stack(dir: ttb, spacing: 3pt,
  chunk(frage, none, fill: sand, stroke: teal),
  grid(columns: (1fr, 1fr), column-gutter: 8pt,
    [#align(center, text(size: 8pt, fill: teal)[#sym.arrow.b *ja*]) #ja],
    [#align(center, text(size: 8pt, fill: teal)[#sym.arrow.b *nein*]) #nein]))
#let idee(ziel, kern, satz) = [#link(ziel)[#text(fill: teal, weight: "bold", kern)] #satz]
#let überblick(titel, ..ideen) = block(width: 100%, fill: pale, inset: (x: 9pt, y: 7pt), above: 0.6em, below: 0.6em, breakable: false)[
  #text(fill: navy, weight: "bold", titel)
  #set list(marker: text(fill: teal, sym.arrow.r), spacing: 0.45em)
  #list(..ideen.pos())
]
#let hoch(ziel, wort) = block(above: 0.4em, below: 0.4em, align(right, text(size: 8.5pt, fill: teal, link(ziel)[#sym.arrow.t #wort])))

#let abbildungen = (
  "uebung-2-2-waermeverlauf-variante": "abbildungen/uebung-2-2-waermeverlauf-variante.svg",
  "uebung-2-2-waermeverlauf": "abbildungen/uebung-2-2-waermeverlauf.svg",
  "uebung-7-9-hx-variante": "abbildungen/uebung-7-9-hx-variante.svg",
  "uebung-7-9-hx-original": "abbildungen/uebung-7-9-hx-original.svg",
  "uebung-7-8-hx-variante": "abbildungen/uebung-7-8-hx-variante.svg",
  "uebung-7-8-hx-original": "abbildungen/uebung-7-8-hx-original.svg",
  "uebung-7-7-hx-variante": "abbildungen/uebung-7-7-hx-variante.svg",
  "uebung-7-7-hx-original": "abbildungen/uebung-7-7-hx-original.svg",
  "uebung-7-6-hx-variante": "abbildungen/uebung-7-6-hx-variante.svg",
  "uebung-7-6-hx-original": "abbildungen/uebung-7-6-hx-original.svg",
  "uebung-7-5-hx-variante": "abbildungen/uebung-7-5-hx-variante.svg",
  "uebung-7-5-hx-original": "abbildungen/uebung-7-5-hx-original.svg",
  "uebung-7-4-hx-variante": "abbildungen/uebung-7-4-hx-variante.svg",
  "uebung-7-4-hx-original": "abbildungen/uebung-7-4-hx-original.svg",
  "uebung-7-3-hx-variante": "abbildungen/uebung-7-3-hx-variante.svg",
  "uebung-7-3-hx-original": "abbildungen/uebung-7-3-hx-original.svg",
  "td-kf-164-12-loesung": "abbildungen/td-kf-164-12-loesung.svg",
  "td-kf-164-07-loesung": "abbildungen/td-kf-164-07-loesung.svg",
  "td-kf-163-14-loesung": "abbildungen/td-kf-163-14-loesung.svg",
  "td-kf-162-14-loesung": "abbildungen/td-kf-162-14-loesung.svg",
  "td-kf-162-11-loesung": "abbildungen/td-kf-162-11-loesung.svg",
  "td-kf-161-15-loesung": "abbildungen/td-kf-161-15-loesung.svg",
  "td-kf-161-15-frage": "abbildungen/td-kf-161-15-frage.svg",
  "td-kf-161-14-frage": "abbildungen/td-kf-161-14-frage.svg",
  "td-kf-161-13-frage": "abbildungen/td-kf-161-13-frage.svg",
  "td-kf-161-12-frage": "abbildungen/td-kf-161-12-frage.svg",
  "td-kf-161-11-frage": "abbildungen/td-kf-161-11-frage.svg",
  "td-kf-161-10-loesung": "abbildungen/td-kf-161-10-loesung.svg",
  "td-kf-161-10-frage": "abbildungen/td-kf-161-10-frage.svg",
  "td-kf-161-03-loesung": "abbildungen/td-kf-161-03-loesung.svg",
  "td-kf-161-03-frage": "abbildungen/td-kf-161-03-frage.svg",
  "td-kf-161-01-frage": "abbildungen/td-kf-161-01-frage.svg",
  "td-kf-160-17-loesung": "abbildungen/td-kf-160-17-loesung.svg",
  "td-kf-160-17-frage": "abbildungen/td-kf-160-17-frage.svg",
  "td-kf-160-16-frage": "abbildungen/td-kf-160-16-frage.svg",
  "td-kf-160-15-frage": "abbildungen/td-kf-160-15-frage.svg",
  "td-kf-160-14-frage": "abbildungen/td-kf-160-14-frage.svg",
  "td-kf-160-13-loesung": "abbildungen/td-kf-160-13-loesung.svg",
  "td-kf-160-13-frage": "abbildungen/td-kf-160-13-frage.svg",
  "td-kf-160-08-frage": "abbildungen/td-kf-160-08-frage.svg",
  "td-kf-160-01-loesung": "abbildungen/td-kf-160-01-loesung.svg",
  "td-kf-160-01-frage": "abbildungen/td-kf-160-01-frage.svg",
  "td-kf-159-21-loesung": "abbildungen/td-kf-159-21-loesung.svg",
  "td-kf-159-21-frage": "abbildungen/td-kf-159-21-frage.svg",
  "td-kf-159-20-loesung": "abbildungen/td-kf-159-20-loesung.svg",
  "td-kf-159-20-frage": "abbildungen/td-kf-159-20-frage.svg",
  "td-kf-159-19-frage": "abbildungen/td-kf-159-19-frage.svg",
  "td-kf-159-18-frage": "abbildungen/td-kf-159-18-frage.svg",
  "td-kf-159-17-frage": "abbildungen/td-kf-159-17-frage.svg",
  "td-kf-159-16-frage": "abbildungen/td-kf-159-16-frage.svg",
  "td-kf-159-15-frage": "abbildungen/td-kf-159-15-frage.svg",
  "td-kf-159-14-loesung": "abbildungen/td-kf-159-14-loesung.svg",
  "td-kf-159-14-frage": "abbildungen/td-kf-159-14-frage.svg",
  "td-kf-159-09-frage": "abbildungen/td-kf-159-09-frage.svg",
  "td-kf-159-03-loesung": "abbildungen/td-kf-159-03-loesung.svg",
  "td-kf-159-03-frage": "abbildungen/td-kf-159-03-frage.svg",
  "td-kf-159-02-loesung": "abbildungen/td-kf-159-02-loesung.svg",
  "td-kf-159-02-frage": "abbildungen/td-kf-159-02-frage.svg",
  "td-kf-158-22-loesung": "abbildungen/td-kf-158-22-loesung.svg",
  "td-kf-158-22-frage": "abbildungen/td-kf-158-22-frage.svg",
  "td-kf-158-21-frage": "abbildungen/td-kf-158-21-frage.svg",
  "td-kf-158-20-frage": "abbildungen/td-kf-158-20-frage.svg",
  "td-kf-158-19-frage": "abbildungen/td-kf-158-19-frage.svg",
  "td-kf-158-18-loesung": "abbildungen/td-kf-158-18-loesung.svg",
  "td-kf-158-18-frage": "abbildungen/td-kf-158-18-frage.svg",
  "td-kf-158-17-frage": "abbildungen/td-kf-158-17-frage.svg",
  "td-kf-158-16-frage": "abbildungen/td-kf-158-16-frage.svg",
  "td-kf-158-15-frage": "abbildungen/td-kf-158-15-frage.svg",
  "td-kf-158-14-frage": "abbildungen/td-kf-158-14-frage.svg",
  "td-kf-158-13-loesung": "abbildungen/td-kf-158-13-loesung.svg",
  "td-kf-158-13-frage": "abbildungen/td-kf-158-13-frage.svg",
  "td-kf-158-12-frage": "abbildungen/td-kf-158-12-frage.svg",
  "td-kf-158-11-frage": "abbildungen/td-kf-158-11-frage.svg",
  "td-kf-158-08-frage": "abbildungen/td-kf-158-08-frage.svg",
  "td-kf-158-07-frage": "abbildungen/td-kf-158-07-frage.svg",
  "td-kf-158-03-loesung": "abbildungen/td-kf-158-03-loesung.svg",
  "td-kf-158-03-frage": "abbildungen/td-kf-158-03-frage.svg",
  "td-kf-157-22-loesung": "abbildungen/td-kf-157-22-loesung.svg",
  "td-kf-157-22-frage": "abbildungen/td-kf-157-22-frage.svg",
  "td-kf-157-21-frage": "abbildungen/td-kf-157-21-frage.svg",
  "td-kf-157-20-frage": "abbildungen/td-kf-157-20-frage.svg",
  "td-kf-157-19-frage": "abbildungen/td-kf-157-19-frage.svg",
  "td-kf-157-18-frage": "abbildungen/td-kf-157-18-frage.svg",
  "td-kf-157-17-frage": "abbildungen/td-kf-157-17-frage.svg",
  "td-kf-157-16-frage": "abbildungen/td-kf-157-16-frage.svg",
  "td-kf-157-15-frage": "abbildungen/td-kf-157-15-frage.svg",
  "td-kf-157-14-frage": "abbildungen/td-kf-157-14-frage.svg",
  "td-kf-157-13-frage": "abbildungen/td-kf-157-13-frage.svg",
  "td-kf-157-12-loesung": "abbildungen/td-kf-157-12-loesung.svg",
  "td-kf-157-12-frage": "abbildungen/td-kf-157-12-frage.svg",
  "td-kf-157-09-frage": "abbildungen/td-kf-157-09-frage.svg",
  "td-kf-157-06-frage": "abbildungen/td-kf-157-06-frage.svg",
  "td-kf-157-03-loesung": "abbildungen/td-kf-157-03-loesung.svg",
  "td-kf-157-03-frage": "abbildungen/td-kf-157-03-frage.svg",
  "td-kf-156-21-loesung": "abbildungen/td-kf-156-21-loesung.svg",
  "td-kf-156-21-frage": "abbildungen/td-kf-156-21-frage.svg",
  "td-kf-156-20-frage": "abbildungen/td-kf-156-20-frage.svg",
  "td-kf-156-19-frage": "abbildungen/td-kf-156-19-frage.svg",
  "td-kf-156-18-loesung": "abbildungen/td-kf-156-18-loesung.svg",
  "td-kf-156-18-frage": "abbildungen/td-kf-156-18-frage.svg",
  "td-kf-156-17-frage": "abbildungen/td-kf-156-17-frage.svg",
  "td-kf-156-16-frage": "abbildungen/td-kf-156-16-frage.svg",
  "td-kf-156-15-frage": "abbildungen/td-kf-156-15-frage.svg",
  "td-kf-156-14-frage": "abbildungen/td-kf-156-14-frage.svg",
  "td-kf-156-13-loesung": "abbildungen/td-kf-156-13-loesung.svg",
  "td-kf-156-13-frage": "abbildungen/td-kf-156-13-frage.svg",
  "td-kf-156-12-frage": "abbildungen/td-kf-156-12-frage.svg",
  "td-kf-156-09-frage": "abbildungen/td-kf-156-09-frage.svg",
  "td-kf-156-07-frage": "abbildungen/td-kf-156-07-frage.svg",
  "td-kf-156-03-loesung": "abbildungen/td-kf-156-03-loesung.svg",
  "td-kf-156-03-frage": "abbildungen/td-kf-156-03-frage.svg",
  "sm-kf-155-21-loesung": "abbildungen/sm-kf-155-21-loesung.svg",
  "sm-kf-155-21-frage": "abbildungen/sm-kf-155-21-frage.svg",
  "sm-kf-155-20-frage": "abbildungen/sm-kf-155-20-frage.svg",
  "sm-kf-155-19-frage": "abbildungen/sm-kf-155-19-frage.svg",
  "sm-kf-155-18-frage": "abbildungen/sm-kf-155-18-frage.svg",
  "sm-kf-155-17-frage": "abbildungen/sm-kf-155-17-frage.svg",
  "sm-kf-155-16-frage": "abbildungen/sm-kf-155-16-frage.svg",
  "sm-kf-155-15-frage": "abbildungen/sm-kf-155-15-frage.svg",
  "sm-kf-155-14-frage": "abbildungen/sm-kf-155-14-frage.svg",
  "sm-kf-155-13-loesung": "abbildungen/sm-kf-155-13-loesung.svg",
  "sm-kf-155-13-frage": "abbildungen/sm-kf-155-13-frage.svg",
  "sm-kf-155-12-frage": "abbildungen/sm-kf-155-12-frage.svg",
  "sm-kf-155-11-frage": "abbildungen/sm-kf-155-11-frage.svg",
  "sm-kf-155-10-frage": "abbildungen/sm-kf-155-10-frage.svg",
  "sm-kf-155-09-loesung": "abbildungen/sm-kf-155-09-loesung.svg",
  "sm-kf-155-09-frage": "abbildungen/sm-kf-155-09-frage.svg",
  "sm-kf-155-08-loesung": "abbildungen/sm-kf-155-08-loesung.svg",
  "sm-kf-155-08-frage": "abbildungen/sm-kf-155-08-frage.svg",
  "sm-kf-155-07-loesung": "abbildungen/sm-kf-155-07-loesung.svg",
  "sm-kf-155-07-frage": "abbildungen/sm-kf-155-07-frage.svg",
  "sm-kf-155-06-frage": "abbildungen/sm-kf-155-06-frage.svg",
  "sm-kf-155-05-frage": "abbildungen/sm-kf-155-05-frage.svg",
  "sm-kf-155-04-frage": "abbildungen/sm-kf-155-04-frage.svg",
  "sm-kf-155-03-loesung": "abbildungen/sm-kf-155-03-loesung.svg",
  "sm-kf-155-03-frage": "abbildungen/sm-kf-155-03-frage.svg",
  "sm-kf-155-02-frage": "abbildungen/sm-kf-155-02-frage.svg",
  "sm-kf-155-01-frage": "abbildungen/sm-kf-155-01-frage.svg",
  "sm-kf-154-21-loesung": "abbildungen/sm-kf-154-21-loesung.svg",
  "sm-kf-154-21-frage": "abbildungen/sm-kf-154-21-frage.svg",
  "sm-kf-154-20-frage": "abbildungen/sm-kf-154-20-frage.svg",
  "sm-kf-154-19-loesung": "abbildungen/sm-kf-154-19-loesung.svg",
  "sm-kf-154-19-frage": "abbildungen/sm-kf-154-19-frage.svg",
  "sm-kf-154-18-frage": "abbildungen/sm-kf-154-18-frage.svg",
  "sm-kf-154-17-frage": "abbildungen/sm-kf-154-17-frage.svg",
  "sm-kf-154-16-frage": "abbildungen/sm-kf-154-16-frage.svg",
  "sm-kf-154-15-frage": "abbildungen/sm-kf-154-15-frage.svg",
  "sm-kf-154-14-frage": "abbildungen/sm-kf-154-14-frage.svg",
  "sm-kf-154-13-loesung": "abbildungen/sm-kf-154-13-loesung.svg",
  "sm-kf-154-13-frage": "abbildungen/sm-kf-154-13-frage.svg",
  "sm-kf-154-12-frage": "abbildungen/sm-kf-154-12-frage.svg",
  "sm-kf-154-11-frage": "abbildungen/sm-kf-154-11-frage.svg",
  "sm-kf-154-10-frage": "abbildungen/sm-kf-154-10-frage.svg",
  "sm-kf-154-09-loesung": "abbildungen/sm-kf-154-09-loesung.svg",
  "sm-kf-154-09-frage": "abbildungen/sm-kf-154-09-frage.svg",
  "sm-kf-154-08-frage": "abbildungen/sm-kf-154-08-frage.svg",
  "sm-kf-154-07-loesung": "abbildungen/sm-kf-154-07-loesung.svg",
  "sm-kf-154-07-frage": "abbildungen/sm-kf-154-07-frage.svg",
  "sm-kf-154-06-frage": "abbildungen/sm-kf-154-06-frage.svg",
  "sm-kf-154-05-frage": "abbildungen/sm-kf-154-05-frage.svg",
  "sm-kf-154-04-frage": "abbildungen/sm-kf-154-04-frage.svg",
  "sm-kf-154-03-loesung": "abbildungen/sm-kf-154-03-loesung.svg",
  "sm-kf-154-03-frage": "abbildungen/sm-kf-154-03-frage.svg",
  "sm-kf-154-02-frage": "abbildungen/sm-kf-154-02-frage.svg",
  "sm-kf-154-01-frage": "abbildungen/sm-kf-154-01-frage.svg",
  "sm-kf-153-21-loesung": "abbildungen/sm-kf-153-21-loesung.svg",
  "sm-kf-153-21-frage": "abbildungen/sm-kf-153-21-frage.svg",
  "sm-kf-153-20-frage": "abbildungen/sm-kf-153-20-frage.svg",
  "sm-kf-153-19-frage": "abbildungen/sm-kf-153-19-frage.svg",
  "sm-kf-153-18-frage": "abbildungen/sm-kf-153-18-frage.svg",
  "sm-kf-153-17-frage": "abbildungen/sm-kf-153-17-frage.svg",
  "sm-kf-153-16-frage": "abbildungen/sm-kf-153-16-frage.svg",
  "sm-kf-153-15-frage": "abbildungen/sm-kf-153-15-frage.svg",
  "sm-kf-153-14-frage": "abbildungen/sm-kf-153-14-frage.svg",
  "sm-kf-153-13-loesung": "abbildungen/sm-kf-153-13-loesung.svg",
  "sm-kf-153-13-frage": "abbildungen/sm-kf-153-13-frage.svg",
  "sm-kf-153-12-frage": "abbildungen/sm-kf-153-12-frage.svg",
  "sm-kf-153-11-frage": "abbildungen/sm-kf-153-11-frage.svg",
  "sm-kf-153-10-frage": "abbildungen/sm-kf-153-10-frage.svg",
  "sm-kf-153-09-loesung": "abbildungen/sm-kf-153-09-loesung.svg",
  "sm-kf-153-09-frage": "abbildungen/sm-kf-153-09-frage.svg",
  "sm-kf-153-08-loesung": "abbildungen/sm-kf-153-08-loesung.svg",
  "sm-kf-153-08-frage": "abbildungen/sm-kf-153-08-frage.svg",
  "sm-kf-153-07-loesung": "abbildungen/sm-kf-153-07-loesung.svg",
  "sm-kf-153-07-frage": "abbildungen/sm-kf-153-07-frage.svg",
  "sm-kf-153-06-frage": "abbildungen/sm-kf-153-06-frage.svg",
  "sm-kf-153-05-frage": "abbildungen/sm-kf-153-05-frage.svg",
  "sm-kf-153-04-frage": "abbildungen/sm-kf-153-04-frage.svg",
  "sm-kf-153-03-loesung": "abbildungen/sm-kf-153-03-loesung.svg",
  "sm-kf-153-03-frage": "abbildungen/sm-kf-153-03-frage.svg",
  "sm-kf-153-02-frage": "abbildungen/sm-kf-153-02-frage.svg",
  "sm-kf-153-01-frage": "abbildungen/sm-kf-153-01-frage.svg",
  "sm-kf-152-24-loesung": "abbildungen/sm-kf-152-24-loesung.svg",
  "sm-kf-152-24-frage": "abbildungen/sm-kf-152-24-frage.svg",
  "sm-kf-152-23-frage": "abbildungen/sm-kf-152-23-frage.svg",
  "sm-kf-152-22-loesung": "abbildungen/sm-kf-152-22-loesung.svg",
  "sm-kf-152-22-frage": "abbildungen/sm-kf-152-22-frage.svg",
  "sm-kf-152-21-frage": "abbildungen/sm-kf-152-21-frage.svg",
  "sm-kf-152-20-frage": "abbildungen/sm-kf-152-20-frage.svg",
  "sm-kf-152-19-frage": "abbildungen/sm-kf-152-19-frage.svg",
  "sm-kf-152-18-frage": "abbildungen/sm-kf-152-18-frage.svg",
  "sm-kf-152-17-frage": "abbildungen/sm-kf-152-17-frage.svg",
  "sm-kf-152-16-loesung": "abbildungen/sm-kf-152-16-loesung.svg",
  "sm-kf-152-16-frage": "abbildungen/sm-kf-152-16-frage.svg",
  "sm-kf-152-15-frage": "abbildungen/sm-kf-152-15-frage.svg",
  "sm-kf-152-14-loesung": "abbildungen/sm-kf-152-14-loesung.svg",
  "sm-kf-152-14-frage": "abbildungen/sm-kf-152-14-frage.svg",
  "sm-kf-152-13-frage": "abbildungen/sm-kf-152-13-frage.svg",
  "sm-kf-152-12-frage": "abbildungen/sm-kf-152-12-frage.svg",
  "sm-kf-152-11-frage": "abbildungen/sm-kf-152-11-frage.svg",
  "sm-kf-152-10-frage": "abbildungen/sm-kf-152-10-frage.svg",
  "sm-kf-152-09-loesung": "abbildungen/sm-kf-152-09-loesung.svg",
  "sm-kf-152-09-frage": "abbildungen/sm-kf-152-09-frage.svg",
  "sm-kf-152-08-frage": "abbildungen/sm-kf-152-08-frage.svg",
  "sm-kf-152-07-frage": "abbildungen/sm-kf-152-07-frage.svg",
  "sm-kf-152-06-loesung": "abbildungen/sm-kf-152-06-loesung.svg",
  "sm-kf-152-06-frage": "abbildungen/sm-kf-152-06-frage.svg",
  "sm-kf-152-05-frage": "abbildungen/sm-kf-152-05-frage.svg",
  "sm-kf-152-04-frage": "abbildungen/sm-kf-152-04-frage.svg",
  "sm-kf-152-03-loesung": "abbildungen/sm-kf-152-03-loesung.svg",
  "sm-kf-152-03-frage": "abbildungen/sm-kf-152-03-frage.svg",
  "sm-kf-152-02-frage": "abbildungen/sm-kf-152-02-frage.svg",
  "sm-kf-152-01-frage": "abbildungen/sm-kf-152-01-frage.svg",
  "sm-kf-151-22-loesung": "abbildungen/sm-kf-151-22-loesung.svg",
  "sm-kf-151-22-frage": "abbildungen/sm-kf-151-22-frage.svg",
  "sm-kf-151-21-loesung": "abbildungen/sm-kf-151-21-loesung.svg",
  "sm-kf-151-21-frage": "abbildungen/sm-kf-151-21-frage.svg",
  "sm-kf-151-20-loesung": "abbildungen/sm-kf-151-20-loesung.svg",
  "sm-kf-151-20-frage": "abbildungen/sm-kf-151-20-frage.svg",
  "sm-kf-151-19-loesung": "abbildungen/sm-kf-151-19-loesung.svg",
  "sm-kf-151-19-frage": "abbildungen/sm-kf-151-19-frage.svg",
  "sm-kf-151-18-frage": "abbildungen/sm-kf-151-18-frage.svg",
  "sm-kf-151-17-frage": "abbildungen/sm-kf-151-17-frage.svg",
  "sm-kf-151-16-frage": "abbildungen/sm-kf-151-16-frage.svg",
  "sm-kf-151-15-frage": "abbildungen/sm-kf-151-15-frage.svg",
  "sm-kf-151-14-frage": "abbildungen/sm-kf-151-14-frage.svg",
  "sm-kf-151-13-frage": "abbildungen/sm-kf-151-13-frage.svg",
  "sm-kf-151-12-frage": "abbildungen/sm-kf-151-12-frage.svg",
  "sm-kf-151-11-frage": "abbildungen/sm-kf-151-11-frage.svg",
  "sm-kf-151-10-loesung": "abbildungen/sm-kf-151-10-loesung.svg",
  "sm-kf-151-10-frage": "abbildungen/sm-kf-151-10-frage.svg",
  "sm-kf-151-09-loesung": "abbildungen/sm-kf-151-09-loesung.svg",
  "sm-kf-151-09-frage": "abbildungen/sm-kf-151-09-frage.svg",
  "sm-kf-151-08-frage": "abbildungen/sm-kf-151-08-frage.svg",
  "sm-kf-151-07-frage": "abbildungen/sm-kf-151-07-frage.svg",
  "sm-kf-151-06-loesung": "abbildungen/sm-kf-151-06-loesung.svg",
  "sm-kf-151-06-frage": "abbildungen/sm-kf-151-06-frage.svg",
  "sm-kf-151-05-frage": "abbildungen/sm-kf-151-05-frage.svg",
  "sm-kf-151-04-frage": "abbildungen/sm-kf-151-04-frage.svg",
  "sm-kf-151-03-frage": "abbildungen/sm-kf-151-03-frage.svg",
  "sm-kf-151-02-frage": "abbildungen/sm-kf-151-02-frage.svg",
  "sm-kf-151-01-frage": "abbildungen/sm-kf-151-01-frage.svg",
  "sm-kf-150-21-frage": "abbildungen/sm-kf-150-21-frage.svg",
  "sm-kf-150-20-frage": "abbildungen/sm-kf-150-20-frage.svg",
  "sm-kf-150-19-frage": "abbildungen/sm-kf-150-19-frage.svg",
  "sm-kf-150-18-loesung": "abbildungen/sm-kf-150-18-loesung.svg",
  "sm-kf-150-18-frage": "abbildungen/sm-kf-150-18-frage.svg",
  "sm-kf-150-17-loesung": "abbildungen/sm-kf-150-17-loesung.svg",
  "sm-kf-150-17-frage": "abbildungen/sm-kf-150-17-frage.svg",
  "sm-kf-150-16-loesung": "abbildungen/sm-kf-150-16-loesung.svg",
  "sm-kf-150-16-frage": "abbildungen/sm-kf-150-16-frage.svg",
  "sm-kf-150-15-frage": "abbildungen/sm-kf-150-15-frage.svg",
  "sm-kf-150-14-frage": "abbildungen/sm-kf-150-14-frage.svg",
  "sm-kf-150-13-loesung": "abbildungen/sm-kf-150-13-loesung.svg",
  "sm-kf-150-13-frage": "abbildungen/sm-kf-150-13-frage.svg",
  "sm-kf-150-12-frage": "abbildungen/sm-kf-150-12-frage.svg",
  "sm-kf-150-11-frage": "abbildungen/sm-kf-150-11-frage.svg",
  "sm-kf-150-10-loesung": "abbildungen/sm-kf-150-10-loesung.svg",
  "sm-kf-150-10-frage": "abbildungen/sm-kf-150-10-frage.svg",
  "sm-kf-150-09-loesung": "abbildungen/sm-kf-150-09-loesung.svg",
  "sm-kf-150-09-frage": "abbildungen/sm-kf-150-09-frage.svg",
  "sm-kf-150-08-frage": "abbildungen/sm-kf-150-08-frage.svg",
  "sm-kf-150-07-frage": "abbildungen/sm-kf-150-07-frage.svg",
  "sm-kf-150-06-loesung": "abbildungen/sm-kf-150-06-loesung.svg",
  "sm-kf-150-06-frage": "abbildungen/sm-kf-150-06-frage.svg",
  "sm-kf-150-05-frage": "abbildungen/sm-kf-150-05-frage.svg",
  "sm-kf-150-04-frage": "abbildungen/sm-kf-150-04-frage.svg",
  "sm-kf-150-03-frage": "abbildungen/sm-kf-150-03-frage.svg",
  "sm-kf-150-02-frage": "abbildungen/sm-kf-150-02-frage.svg",
  "sm-kf-150-01-frage": "abbildungen/sm-kf-150-01-frage.svg",
  "sm-kf-148-16-loesung": "abbildungen/sm-kf-148-16-loesung.svg",
  "sm-kf-148-16-frage": "abbildungen/sm-kf-148-16-frage.svg",
  "sm-kf-148-15-loesung": "abbildungen/sm-kf-148-15-loesung.svg",
  "sm-kf-148-15-frage": "abbildungen/sm-kf-148-15-frage.svg",
  "sm-kf-148-14-loesung": "abbildungen/sm-kf-148-14-loesung.svg",
  "sm-kf-148-14-frage": "abbildungen/sm-kf-148-14-frage.svg",
  "sm-kf-148-13-frage": "abbildungen/sm-kf-148-13-frage.svg",
  "sm-kf-148-12-frage": "abbildungen/sm-kf-148-12-frage.svg",
  "sm-kf-148-11-frage": "abbildungen/sm-kf-148-11-frage.svg",
  "sm-kf-148-10-frage": "abbildungen/sm-kf-148-10-frage.svg",
  "sm-kf-148-09-loesung": "abbildungen/sm-kf-148-09-loesung.svg",
  "sm-kf-148-09-frage": "abbildungen/sm-kf-148-09-frage.svg",
  "sm-kf-148-08-frage": "abbildungen/sm-kf-148-08-frage.svg",
  "sm-kf-148-07-loesung": "abbildungen/sm-kf-148-07-loesung.svg",
  "sm-kf-148-07-frage": "abbildungen/sm-kf-148-07-frage.svg",
  "sm-kf-148-06-loesung": "abbildungen/sm-kf-148-06-loesung.svg",
  "sm-kf-148-06-frage": "abbildungen/sm-kf-148-06-frage.svg",
  "sm-kf-148-05-frage": "abbildungen/sm-kf-148-05-frage.svg",
  "sm-kf-148-04-frage": "abbildungen/sm-kf-148-04-frage.svg",
  "sm-kf-148-03-frage": "abbildungen/sm-kf-148-03-frage.svg",
  "sm-kf-148-02-frage": "abbildungen/sm-kf-148-02-frage.svg",
  "sm-kf-148-01-frage": "abbildungen/sm-kf-148-01-frage.svg",
  "sm-kf-146-20-loesung": "abbildungen/sm-kf-146-20-loesung.svg",
  "sm-kf-146-20-frage": "abbildungen/sm-kf-146-20-frage.svg",
  "sm-kf-146-19-frage": "abbildungen/sm-kf-146-19-frage.svg",
  "sm-kf-146-18-loesung": "abbildungen/sm-kf-146-18-loesung.svg",
  "sm-kf-146-18-frage": "abbildungen/sm-kf-146-18-frage.svg",
  "sm-kf-146-17-loesung": "abbildungen/sm-kf-146-17-loesung.svg",
  "sm-kf-146-17-frage": "abbildungen/sm-kf-146-17-frage.svg",
  "sm-kf-146-16-frage": "abbildungen/sm-kf-146-16-frage.svg",
  "sm-kf-146-15-frage": "abbildungen/sm-kf-146-15-frage.svg",
  "sm-kf-146-14-frage": "abbildungen/sm-kf-146-14-frage.svg",
  "sm-kf-146-13-frage": "abbildungen/sm-kf-146-13-frage.svg",
  "sm-kf-146-12-loesung": "abbildungen/sm-kf-146-12-loesung.svg",
  "sm-kf-146-12-frage": "abbildungen/sm-kf-146-12-frage.svg",
  "sm-kf-146-11-frage": "abbildungen/sm-kf-146-11-frage.svg",
  "sm-kf-146-10-frage": "abbildungen/sm-kf-146-10-frage.svg",
  "sm-kf-146-09-frage": "abbildungen/sm-kf-146-09-frage.svg",
  "sm-kf-146-08-frage": "abbildungen/sm-kf-146-08-frage.svg",
  "sm-kf-146-07-frage": "abbildungen/sm-kf-146-07-frage.svg",
  "sm-kf-146-06-frage": "abbildungen/sm-kf-146-06-frage.svg",
  "sm-kf-146-05-loesung": "abbildungen/sm-kf-146-05-loesung.svg",
  "sm-kf-146-05-frage": "abbildungen/sm-kf-146-05-frage.svg",
  "sm-kf-146-04-frage": "abbildungen/sm-kf-146-04-frage.svg",
  "sm-kf-146-03-loesung": "abbildungen/sm-kf-146-03-loesung.svg",
  "sm-kf-146-03-frage": "abbildungen/sm-kf-146-03-frage.svg",
  "sm-kf-146-02-frage": "abbildungen/sm-kf-146-02-frage.svg",
  "sm-kf-146-01-frage": "abbildungen/sm-kf-146-01-frage.svg",
  "sm-kf-145-22-loesung": "abbildungen/sm-kf-145-22-loesung.svg",
  "sm-kf-145-22-frage": "abbildungen/sm-kf-145-22-frage.svg",
  "sm-kf-145-21-frage": "abbildungen/sm-kf-145-21-frage.svg",
  "sm-kf-145-20-frage": "abbildungen/sm-kf-145-20-frage.svg",
  "sm-kf-145-19-loesung": "abbildungen/sm-kf-145-19-loesung.svg",
  "sm-kf-145-19-frage": "abbildungen/sm-kf-145-19-frage.svg",
  "sm-kf-145-18-loesung": "abbildungen/sm-kf-145-18-loesung.svg",
  "sm-kf-145-18-frage": "abbildungen/sm-kf-145-18-frage.svg",
  "sm-kf-145-17-frage": "abbildungen/sm-kf-145-17-frage.svg",
  "sm-kf-145-16-frage": "abbildungen/sm-kf-145-16-frage.svg",
  "sm-kf-145-15-loesung": "abbildungen/sm-kf-145-15-loesung.svg",
  "sm-kf-145-15-frage": "abbildungen/sm-kf-145-15-frage.svg",
  "sm-kf-145-14-loesung": "abbildungen/sm-kf-145-14-loesung.svg",
  "sm-kf-145-14-frage": "abbildungen/sm-kf-145-14-frage.svg",
  "sm-kf-145-13-frage": "abbildungen/sm-kf-145-13-frage.svg",
  "sm-kf-145-12-frage": "abbildungen/sm-kf-145-12-frage.svg",
  "sm-kf-145-11-frage": "abbildungen/sm-kf-145-11-frage.svg",
  "sm-kf-145-10-frage": "abbildungen/sm-kf-145-10-frage.svg",
  "sm-kf-145-09-frage": "abbildungen/sm-kf-145-09-frage.svg",
  "sm-kf-145-08-frage": "abbildungen/sm-kf-145-08-frage.svg",
  "sm-kf-145-07-frage": "abbildungen/sm-kf-145-07-frage.svg",
  "sm-kf-145-06-frage": "abbildungen/sm-kf-145-06-frage.svg",
  "sm-kf-145-05-frage": "abbildungen/sm-kf-145-05-frage.svg",
  "sm-kf-145-04-frage": "abbildungen/sm-kf-145-04-frage.svg",
  "sm-kf-145-03-loesung": "abbildungen/sm-kf-145-03-loesung.svg",
  "sm-kf-145-03-frage": "abbildungen/sm-kf-145-03-frage.svg",
  "sm-kf-145-02-frage": "abbildungen/sm-kf-145-02-frage.svg",
  "sm-kf-145-01-frage": "abbildungen/sm-kf-145-01-frage.svg",
  "sm-kf-144-23-loesung": "abbildungen/sm-kf-144-23-loesung.svg",
  "sm-kf-144-23-frage": "abbildungen/sm-kf-144-23-frage.svg",
  "sm-kf-144-22-frage": "abbildungen/sm-kf-144-22-frage.svg",
  "sm-kf-144-21-loesung": "abbildungen/sm-kf-144-21-loesung.svg",
  "sm-kf-144-21-frage": "abbildungen/sm-kf-144-21-frage.svg",
  "sm-kf-144-20-frage": "abbildungen/sm-kf-144-20-frage.svg",
  "sm-kf-144-19-loesung": "abbildungen/sm-kf-144-19-loesung.svg",
  "sm-kf-144-19-frage": "abbildungen/sm-kf-144-19-frage.svg",
  "sm-kf-144-18-frage": "abbildungen/sm-kf-144-18-frage.svg",
  "sm-kf-144-17-frage": "abbildungen/sm-kf-144-17-frage.svg",
  "sm-kf-144-16-frage": "abbildungen/sm-kf-144-16-frage.svg",
  "sm-kf-144-15-frage": "abbildungen/sm-kf-144-15-frage.svg",
  "sm-kf-144-14-frage": "abbildungen/sm-kf-144-14-frage.svg",
  "sm-kf-144-13-frage": "abbildungen/sm-kf-144-13-frage.svg",
  "sm-kf-144-12-loesung": "abbildungen/sm-kf-144-12-loesung.svg",
  "sm-kf-144-12-frage": "abbildungen/sm-kf-144-12-frage.svg",
  "sm-kf-144-11-frage": "abbildungen/sm-kf-144-11-frage.svg",
  "sm-kf-144-10-frage": "abbildungen/sm-kf-144-10-frage.svg",
  "sm-kf-144-09-loesung": "abbildungen/sm-kf-144-09-loesung.svg",
  "sm-kf-144-09-frage": "abbildungen/sm-kf-144-09-frage.svg",
  "sm-kf-144-08-frage": "abbildungen/sm-kf-144-08-frage.svg",
  "sm-kf-144-07-frage": "abbildungen/sm-kf-144-07-frage.svg",
  "sm-kf-144-06-frage": "abbildungen/sm-kf-144-06-frage.svg",
  "sm-kf-144-05-loesung": "abbildungen/sm-kf-144-05-loesung.svg",
  "sm-kf-144-05-frage": "abbildungen/sm-kf-144-05-frage.svg",
  "sm-kf-144-04-loesung": "abbildungen/sm-kf-144-04-loesung.svg",
  "sm-kf-144-04-frage": "abbildungen/sm-kf-144-04-frage.svg",
  "sm-kf-144-03-loesung": "abbildungen/sm-kf-144-03-loesung.svg",
  "sm-kf-144-03-frage": "abbildungen/sm-kf-144-03-frage.svg",
  "sm-kf-144-02-frage": "abbildungen/sm-kf-144-02-frage.svg",
  "sm-kf-144-01-frage": "abbildungen/sm-kf-144-01-frage.svg",
  "sm-kf-143-23-loesung": "abbildungen/sm-kf-143-23-loesung.svg",
  "sm-kf-143-23-frage": "abbildungen/sm-kf-143-23-frage.svg",
  "sm-kf-143-22-loesung": "abbildungen/sm-kf-143-22-loesung.svg",
  "sm-kf-143-22-frage": "abbildungen/sm-kf-143-22-frage.svg",
  "sm-kf-143-21-frage": "abbildungen/sm-kf-143-21-frage.svg",
  "sm-kf-143-20-frage": "abbildungen/sm-kf-143-20-frage.svg",
  "sm-kf-143-19-frage": "abbildungen/sm-kf-143-19-frage.svg",
  "sm-kf-143-18-frage": "abbildungen/sm-kf-143-18-frage.svg",
  "sm-kf-143-17-frage": "abbildungen/sm-kf-143-17-frage.svg",
  "sm-kf-143-16-frage": "abbildungen/sm-kf-143-16-frage.svg",
  "sm-kf-143-15-frage": "abbildungen/sm-kf-143-15-frage.svg",
  "sm-kf-143-14-frage": "abbildungen/sm-kf-143-14-frage.svg",
  "sm-kf-143-13-frage": "abbildungen/sm-kf-143-13-frage.svg",
  "sm-kf-143-12-frage": "abbildungen/sm-kf-143-12-frage.svg",
  "sm-kf-143-11-frage": "abbildungen/sm-kf-143-11-frage.svg",
  "sm-kf-143-10-frage": "abbildungen/sm-kf-143-10-frage.svg",
  "sm-kf-143-09-loesung": "abbildungen/sm-kf-143-09-loesung.svg",
  "sm-kf-143-09-frage": "abbildungen/sm-kf-143-09-frage.svg",
  "sm-kf-143-08-frage": "abbildungen/sm-kf-143-08-frage.svg",
  "sm-kf-143-07-frage": "abbildungen/sm-kf-143-07-frage.svg",
  "sm-kf-143-06-frage": "abbildungen/sm-kf-143-06-frage.svg",
  "sm-kf-143-05-frage": "abbildungen/sm-kf-143-05-frage.svg",
  "sm-kf-143-04-frage": "abbildungen/sm-kf-143-04-frage.svg",
  "sm-kf-143-03-frage": "abbildungen/sm-kf-143-03-frage.svg",
  "sm-kf-143-02-frage": "abbildungen/sm-kf-143-02-frage.svg",
  "sm-kf-143-01-frage": "abbildungen/sm-kf-143-01-frage.svg",
  "sm-kf-142-29-frage": "abbildungen/sm-kf-142-29-frage.svg",
  "sm-kf-142-28-frage": "abbildungen/sm-kf-142-28-frage.svg",
  "sm-kf-142-27-loesung": "abbildungen/sm-kf-142-27-loesung.svg",
  "sm-kf-142-27-frage": "abbildungen/sm-kf-142-27-frage.svg",
  "sm-kf-142-26-frage": "abbildungen/sm-kf-142-26-frage.svg",
  "sm-kf-142-25-frage": "abbildungen/sm-kf-142-25-frage.svg",
  "sm-kf-142-24-frage": "abbildungen/sm-kf-142-24-frage.svg",
  "sm-kf-142-23-frage": "abbildungen/sm-kf-142-23-frage.svg",
  "sm-kf-142-22-frage": "abbildungen/sm-kf-142-22-frage.svg",
  "sm-kf-142-21-loesung": "abbildungen/sm-kf-142-21-loesung.svg",
  "sm-kf-142-21-frage": "abbildungen/sm-kf-142-21-frage.svg",
  "sm-kf-142-20-frage": "abbildungen/sm-kf-142-20-frage.svg",
  "sm-kf-142-19-frage": "abbildungen/sm-kf-142-19-frage.svg",
  "sm-kf-142-18-loesung": "abbildungen/sm-kf-142-18-loesung.svg",
  "sm-kf-142-18-frage": "abbildungen/sm-kf-142-18-frage.svg",
  "sm-kf-142-17-frage": "abbildungen/sm-kf-142-17-frage.svg",
  "sm-kf-142-16-frage": "abbildungen/sm-kf-142-16-frage.svg",
  "sm-kf-142-15-frage": "abbildungen/sm-kf-142-15-frage.svg",
  "sm-kf-142-14-frage": "abbildungen/sm-kf-142-14-frage.svg",
  "sm-kf-142-13-frage": "abbildungen/sm-kf-142-13-frage.svg",
  "sm-kf-142-12-frage": "abbildungen/sm-kf-142-12-frage.svg",
  "sm-kf-142-11-frage": "abbildungen/sm-kf-142-11-frage.svg",
  "sm-kf-142-10-loesung": "abbildungen/sm-kf-142-10-loesung.svg",
  "sm-kf-142-10-frage": "abbildungen/sm-kf-142-10-frage.svg",
  "sm-kf-142-09-frage": "abbildungen/sm-kf-142-09-frage.svg",
  "sm-kf-142-08-frage": "abbildungen/sm-kf-142-08-frage.svg",
  "sm-kf-142-07-frage": "abbildungen/sm-kf-142-07-frage.svg",
  "sm-kf-142-06-frage": "abbildungen/sm-kf-142-06-frage.svg",
  "sm-kf-142-05-loesung": "abbildungen/sm-kf-142-05-loesung.svg",
  "sm-kf-142-05-frage": "abbildungen/sm-kf-142-05-frage.svg",
  "sm-kf-142-04-frage": "abbildungen/sm-kf-142-04-frage.svg",
  "sm-kf-142-03-frage": "abbildungen/sm-kf-142-03-frage.svg",
  "sm-kf-142-02-frage": "abbildungen/sm-kf-142-02-frage.svg",
  "sm-kf-142-01-frage": "abbildungen/sm-kf-142-01-frage.svg",
  "rinne-differentialkraft": "abbildungen/rinne-differentialkraft.svg",
  "pfws0506-steigkurve": "abbildungen/pfws0506-steigkurve.svg",
  "pfws0506-steigkurve-var": "abbildungen/pfws0506-steigkurve-var.svg",
  "pfws0506-staupunktkruemmer-original": "abbildungen/pfws0506-staupunktkruemmer-original.svg",
  "pfws0506-radialspalt-original": "abbildungen/pfws0506-radialspalt-original.svg",
  "pfws0506-flugpolare": "abbildungen/pfws0506-flugpolare.svg",
  "pfws0506-flugpolare-var": "abbildungen/pfws0506-flugpolare-var.svg",
  "pfws0506-duesenrohr-original": "abbildungen/pfws0506-duesenrohr-original.svg",
  "pfws0102-verteilduese-original": "abbildungen/pfws0102-verteilduese-original.svg",
  "pfws0102-rinne-original": "abbildungen/pfws0102-rinne-original.svg",
  "pfws0102-heizkoerper-original": "abbildungen/pfws0102-heizkoerper-original.svg",
  "pfss06-zweikreisnetz-original": "abbildungen/pfss06-zweikreisnetz-original.svg",
  "pfss06-wellendach-stromlinien-original": "abbildungen/pfss06-wellendach-stromlinien-original.svg",
  "pfss06-wellendach-original": "abbildungen/pfss06-wellendach-original.svg",
  "pfss06-schwimmstab-original": "abbildungen/pfss06-schwimmstab-original.svg",
  "pfss06-keilstrahl-original": "abbildungen/pfss06-keilstrahl-original.svg",
  "pfss06-flugzeug-original": "abbildungen/pfss06-flugzeug-original.svg",
  "pfss05-oelkuehler-original": "abbildungen/pfss05-oelkuehler-original.svg",
  "pfss05-heiznetz-original": "abbildungen/pfss05-heiznetz-original.svg",
  "pfss05-flussbiegung-original": "abbildungen/pfss05-flussbiegung-original.svg",
  "pfss05-aquarium-original": "abbildungen/pfss05-aquarium-original.svg",
  "pfss04-staudamm-original": "abbildungen/pfss04-staudamm-original.svg",
  "pfss04-startverlauf": "abbildungen/pfss04-startverlauf.svg",
  "pfss04-startverlauf-var": "abbildungen/pfss04-startverlauf-var.svg",
  "pfss04-ringduese-original": "abbildungen/pfss04-ringduese-original.svg",
  "pfss04-huegel-original": "abbildungen/pfss04-huegel-original.svg",
  "pfss03-verzweigung-original": "abbildungen/pfss03-verzweigung-original.svg",
  "pfss03-quellenprofil-original": "abbildungen/pfss03-quellenprofil-original.svg",
  "pfss03-do27-polare-original": "abbildungen/pfss03-do27-polare-original.svg",
  "pfss03-aquariumfenster-original": "abbildungen/pfss03-aquariumfenster-original.svg",
  "lnss05-rohrsystem-original": "abbildungen/lnss05-rohrsystem-original.svg",
  "lnss05-rohreinlauf-original": "abbildungen/lnss05-rohreinlauf-original.svg",
  "lnss05-quellenprofil-stromlinien": "abbildungen/lnss05-quellenprofil-stromlinien.svg",
  "lnss05-profilnase-original": "abbildungen/lnss05-profilnase-original.svg",
  "aquarium-luftstrom-hoehe": "abbildungen/aquarium-luftstrom-hoehe.svg",
  "kompressibler-gasausfluss": "abbildungen/kompressibler-gasausfluss.svg",
  "wasserbad-var-temperatur-leistung": "abbildungen/wasserbad-var-temperatur-leistung.svg",
  "wasserbad-temperatur-leistung": "abbildungen/wasserbad-temperatur-leistung.svg",
  "senkenduese-komponenten": "abbildungen/senkenduese-komponenten.svg",
  "pfws0304-senkenduese-original": "abbildungen/pfws0304-senkenduese-original.svg",
  "pfws0304-schleusentor-original": "abbildungen/pfws0304-schleusentor-original.svg",
  "pfws0304-luftbehaelter-original": "abbildungen/pfws0304-luftbehaelter-original.svg",
  "pfws0304-kuehlernetz-original": "abbildungen/pfws0304-kuehlernetz-original.svg",
  "pfws0203-spoiler-polare-original": "abbildungen/pfws0203-spoiler-polare-original.svg",
  "pfws0203-spoiler-kraefte": "abbildungen/pfws0203-spoiler-kraefte.svg",
  "pfws0203-spoiler-kraefte-var": "abbildungen/pfws0203-spoiler-kraefte-var.svg",
  "pfws0203-pumpe-duese-original": "abbildungen/pfws0203-pumpe-duese-original.svg",
  "pfws0203-pumpe-druck": "abbildungen/pfws0203-pumpe-druck.svg",
  "pfws0203-pumpe-druck-var": "abbildungen/pfws0203-pumpe-druck-var.svg",
  "pfws0203-prallschild-original": "abbildungen/pfws0203-prallschild-original.svg",
  "pfws0203-brause-original": "abbildungen/pfws0203-brause-original.svg",
  "pfss02-pumpenscheitel-original": "abbildungen/pfss02-pumpenscheitel-original.svg",
  "pfss02-abzweig-original": "abbildungen/pfss02-abzweig-original.svg",
  "pfss01-zweistrahl-original": "abbildungen/pfss01-zweistrahl-original.svg",
  "pfss01-wirbelduese-original": "abbildungen/pfss01-wirbelduese-original.svg",
  "glas-druck-kurven": "abbildungen/glas-druck-kurven.svg",
  "boiler-entnahme-mittelwert": "abbildungen/boiler-entnahme-mittelwert.svg",
  "bilanz-behaelter-schema": "abbildungen/bilanz-behaelter-schema.svg",
  "badewanne-systemskizze": "abbildungen/badewanne-systemskizze.svg",
  "vdw-kritische-isotherme": "abbildungen/vdw-kritische-isotherme.svg",
  "torricelli-heber-folie": "abbildungen/torricelli-heber-folie.svg",
  "druck-richtungsunabhaengigkeit": "abbildungen/druck-richtungsunabhaengigkeit.svg",
  "brennstoffzelle-elektroden-memory": "abbildungen/brennstoffzelle-elektroden-memory.svg",
  "klimazentrale-memory": "abbildungen/klimazentrale-memory.svg",
  "linde-claude-memory": "abbildungen/linde-claude-memory.svg",
  "philips-stirling-kaelte-memory": "abbildungen/philips-stirling-kaelte-memory.svg",
  "joule-kaeltemaschine-memory": "abbildungen/joule-kaeltemaschine-memory.svg",
  "lnss01-segelflug-polare": "abbildungen/lnss01-segelflug-polare.svg",
  "lnss01-fussboden-original": "abbildungen/lnss01-fussboden-original.svg",
  "lnss01-kruemmer-original": "abbildungen/lnss01-kruemmer-original.svg",
  "pf0102-sauna-0": "abbildungen/pf0102-sauna-0.svg",
  "pf0102-sauna-1": "abbildungen/pf0102-sauna-1.svg",
  "lnss01-wirbelkanal-original": "abbildungen/lnss01-wirbelkanal-original.svg",
  "vorlesung-rohrnetz-original": "abbildungen/vorlesung-rohrnetz-original.svg",
  "v05-isobaren-0": "abbildungen/v05-isobaren-0.svg",
  "v05-isobaren-1": "abbildungen/v05-isobaren-1.svg",
  "turbofan-folien-original": "abbildungen/turbofan-folien-original.svg",
  "hydrodynamisches-paradoxon": "abbildungen/hydrodynamisches-paradoxon.svg",
  "hydrostatisches-paradoxon": "abbildungen/hydrostatisches-paradoxon.svg",
  "luft-wasser-memory": "abbildungen/luft-wasser-memory.svg",
  "taupunktregler-memory": "abbildungen/taupunktregler-memory.svg",
  "mollier-memory-original": "abbildungen/mollier-memory-original.svg",
  "pf0304-tunnel-1": "abbildungen/pf0304-tunnel-1.svg",
  "pf0304-tunnel-0": "abbildungen/pf0304-tunnel-0.svg",
  "ln9900-kammer-1": "abbildungen/ln9900-kammer-1.svg",
  "ln9900-kammer-0": "abbildungen/ln9900-kammer-0.svg",
  "pf9900-dampfbad-1": "abbildungen/pf9900-dampfbad-1.svg",
  "pf9900-dampfbad-0": "abbildungen/pf9900-dampfbad-0.svg",
  "pf0506-schule-schema": "abbildungen/pf0506-schule-schema.svg",
  "pf0001-klima-0": "abbildungen/pf0001-klima-0.svg",
  "pf0001-klima-1": "abbildungen/pf0001-klima-1.svg",
  "ueb9900-buero-0": "abbildungen/ueb9900-buero-0.svg",
  "ueb9900-buero-1": "abbildungen/ueb9900-buero-1.svg",
  "pf0506-schwimmhalle-schema": "abbildungen/pf0506-schwimmhalle-schema.svg",
  "pf0405-winter-0": "abbildungen/pf0405-winter-0.svg",
  "pf0405-winter-1": "abbildungen/pf0405-winter-1.svg",
  "pf0203-optionen-1": "abbildungen/pf0203-optionen-1.svg",
  "pf0203-optionen-0": "abbildungen/pf0203-optionen-0.svg",
  "gleitflug-kraefte": "abbildungen/gleitflug-kraefte.svg",
  "koerperkraefte": "abbildungen/koerperkraefte.svg",
  "modell-aehnlichkeit": "abbildungen/modell-aehnlichkeit.svg",
  "potential-stromlinien": "abbildungen/potential-stromlinien.svg",
  "ws13-schiff-original": "abbildungen/ws13-schiff-original.svg",
  "ss13-rohrnetz-original": "abbildungen/ss13-rohrnetz-original.svg",
  "ss24-fontane-original": "abbildungen/ss24-fontane-original.svg",
  "ss24-presse-original": "abbildungen/ss24-presse-original.svg",
  "kugel-stratifikation-original": "abbildungen/kugel-stratifikation-original.svg",
  "rohrnetz-original": "abbildungen/rohrnetz-original.svg",
  "waermeleitung-fourier": "abbildungen/waermeleitung-fourier.svg",
  "brennstoffzelle-kennlinie": "abbildungen/brennstoffzelle-kennlinie.svg",
  "brennstoffzelle-schema": "abbildungen/brennstoffzelle-schema.svg",
  "uebung-1-11-realgasdiagramm": "abbildungen/uebung-1-11-realgasdiagramm.svg",
  "r134a-vollstaendiges-ph": "abbildungen/r134a-vollstaendiges-ph.svg",
  "map-stroemung": "abbildungen/map-stroemung.svg",
  "map-verbrennung": "abbildungen/map-verbrennung.svg",
  "map-feuchte": "abbildungen/map-feuchte.svg",
  "map-maschinen": "abbildungen/map-maschinen.svg",
  "map-idealesgas": "abbildungen/map-idealesgas.svg",
  "impuls-kontrollvolumen": "abbildungen/impuls-kontrollvolumen.svg",
  "moody-original": "abbildungen/moody-original.svg",
  "plank-unterkuehlung": "abbildungen/plank-unterkuehlung.svg",
  "rankine-zwischenueberhitzung": "abbildungen/rankine-zwischenueberhitzung.svg",
  "stirling-regeneration": "abbildungen/stirling-regeneration.svg",
  "joule-ideal-real": "abbildungen/joule-ideal-real.svg",
  "otto-diesel-seiliger": "abbildungen/otto-diesel-seiliger.svg",
  "gas-isolinien": "abbildungen/gas-isolinien.svg",
  "exergie-gasturbinevar": "abbildungen/exergie-gasturbinevar.svg",
  "exergie-gasturbine": "abbildungen/exergie-gasturbine.svg",
  "exergie-gasstromvar": "abbildungen/exergie-gasstromvar.svg",
  "exergie-gasstrom": "abbildungen/exergie-gasstrom.svg",
  "exergie-co2var": "abbildungen/exergie-co2var.svg",
  "exergie-co2": "abbildungen/exergie-co2.svg",
  "exergie-abgasvar": "abbildungen/exergie-abgasvar.svg",
  "exergie-abgas": "abbildungen/exergie-abgas.svg",
  "a415-pfade": "abbildungen/a415-pfade.svg",
  "a414-pfade": "abbildungen/a414-pfade.svg",
  "a414-original": "abbildungen/a414-original.svg",
  "map-exergie": "abbildungen/map-exergie.svg",
  "faulgas-angabe": "abbildungen/faulgas-angabe.svg",
  "exergie-weg": "abbildungen/exergie-weg.svg",
  "kreisprozess-flaechen": "abbildungen/kreisprozess-flaechen.svg",
  "hs-ts-vergleich": "abbildungen/hs-ts-vergleich.svg",
  "carnot-ts-rechteck": "abbildungen/carnot-ts-rechteck.svg",
  "r134a-angabe": "abbildungen/r134a-angabe.svg",
  "a420-angabe": "abbildungen/a420-angabe.svg",
  "map-diagramme": "abbildungen/map-diagramme.svg",
  "carnot-vorlesung": "abbildungen/carnot-vorlesung.svg",
  "plank-vorlesung": "abbildungen/plank-vorlesung.svg",
  "rankine-vorlesung": "abbildungen/rankine-vorlesung.svg",
  "ts-zustandsflaechen": "abbildungen/ts-zustandsflaechen.svg",
  "ts-prozessflaechen": "abbildungen/ts-prozessflaechen.svg",
  "kochtopf-phasen": "abbildungen/kochtopf-phasen.svg",
  "kochtopf-energie": "abbildungen/kochtopf-energie.svg",
  "turbine-hs-vergleich": "abbildungen/turbine-hs-vergleich.svg",
  "tripel-isochor": "abbildungen/tripel-isochor.svg",
  "dampftrommel-anteile": "abbildungen/dampftrommel-anteile.svg",
  "ueberhitzer-wege": "abbildungen/ueberhitzer-wege.svg",
  "waermekapazitaet-mittel": "abbildungen/waermekapazitaet-mittel.svg",
  "waermekapazitaet-kolben": "abbildungen/waermekapazitaet-kolben.svg",
  "kreisprozess-energie": "abbildungen/kreisprozess-energie.svg",
  "stroemung-duese-drossel": "abbildungen/stroemung-duese-drossel.svg",
  "lufterhitzer-grenzen": "abbildungen/lufterhitzer-grenzen.svg",
  "joule-prozess": "abbildungen/joule-prozess.svg",
  "entropie-bilanz": "abbildungen/entropie-bilanz.svg",
  "zustandsdiagramme-achsen": "abbildungen/zustandsdiagramme-achsen.svg",
  "map-tripel": "abbildungen/map-tripel.svg",
  "map-entropie": "abbildungen/map-entropie.svg",
  "map-waermekapazitaet": "abbildungen/map-waermekapazitaet.svg",

  "druckluftmotor-vergleich": "abbildungen/druckluftmotor-vergleich.svg",
  "kraftwerk-enthalpie": "abbildungen/kraftwerk-enthalpie.svg",
  "turbine-energie": "abbildungen/turbine-energie.svg",
  "arbeit-zwei-wege": "abbildungen/arbeit-zwei-wege.svg",
  "arbeit-nutzanteil": "abbildungen/arbeit-nutzanteil.svg",
  "arbeit-verschiebung": "abbildungen/arbeit-verschiebung.svg",
  "map-arbeit": "abbildungen/map-arbeit.svg",
  "map-waerme-enthalpie": "abbildungen/map-waerme-enthalpie.svg",
  "druckluftmotor-pv": "abbildungen/druckluftmotor-pv.svg",

  "map-fet": "abbildungen/map-fet.svg",
  "map-tabellenmodell": "abbildungen/map-tabellenmodell.svg",
  "interpolation-invers": "abbildungen/interpolation-invers.svg",
  "stickstoff-zustaende": "abbildungen/stickstoff-zustaende.svg",
  "stickstoff-pv": "abbildungen/stickstoff-pv.svg",
  "verdampfer-stroeme": "abbildungen/verdampfer-stroeme.svg",
  "anomaly": "abbildungen/anomaly.svg",
  "bath": "abbildungen/bath.svg",
  "bernoulli": "abbildungen/bernoulli.svg",
  "boiler": "abbildungen/boiler.svg",
  "boundary": "abbildungen/boundary.svg",
  "continuity": "abbildungen/continuity.svg",
  "cover": "abbildungen/cover.svg",
  "division": "abbildungen/division.svg",
  "drain-plot": "abbildungen/drain-plot.svg",
  "energy-parts": "abbildungen/energy-parts.svg",
  "expansion": "abbildungen/expansion.svg",
  "five-states": "abbildungen/five-states.svg",
  "heating-power": "abbildungen/heating-power.svg",
  "heating-temperature": "abbildungen/heating-temperature.svg",
  "heatpipe": "abbildungen/heatpipe.svg",
  "hose": "abbildungen/hose.svg",
  "isochoric": "abbildungen/isochoric.svg",
  "kelvin": "abbildungen/kelvin.svg",
  "lever": "abbildungen/lever.svg",
  "manometer": "abbildungen/manometer.svg",
  "map-balance": "abbildungen/map-balance.svg",
  "map-heat": "abbildungen/map-heat.svg",
  "map-path": "abbildungen/map-path.svg",
  "map-ptw": "abbildungen/map-ptw.svg",
  "map-quality": "abbildungen/map-quality.svg",
  "map-state": "abbildungen/map-state.svg",
  "map-system": "abbildungen/map-system.svg",
  "map-water": "abbildungen/map-water.svg",
  "mass-volume": "abbildungen/mass-volume.svg",
  "oxygen": "abbildungen/oxygen.svg",
  "path-work": "abbildungen/path-work.svg",
  "phase-dome": "abbildungen/phase-dome.svg",
  "piston": "abbildungen/piston.svg",
  "pv-isolines": "abbildungen/pv-isolines.svg",
  "pvt": "abbildungen/pvt.svg",
  "reversibility": "abbildungen/reversibility.svg",
  "states": "abbildungen/states.svg",
  "supercritical": "abbildungen/supercritical.svg",
  "transfers": "abbildungen/transfers.svg",
  "triple": "abbildungen/triple.svg",
  "turbine": "abbildungen/turbine.svg",
  "warming": "abbildungen/warming.svg",
  "mixing": "abbildungen/mixing.svg",
  "map-mix": "abbildungen/map-mix.svg",
  "hs-overview": "abbildungen/hs-overview.svg",
  "hs-open": "abbildungen/hs-open.svg",
  "hs-closed": "abbildungen/hs-closed.svg",
  "hs-special": "abbildungen/hs-special.svg",
  "map-firstlaw": "abbildungen/map-firstlaw.svg",
  "ball": "abbildungen/ball.svg",
)

#let bilddeutungen = (
  "uebung-2-2-waermeverlauf-variante": (titel: "Bild lesen", body: [Waagerecht wächst die zugeführte Wärme, senkrecht die Temperatur. Beim Schmelzen und Verdampfen bleibt die Temperatur konstant; die unterschiedlichen Plateaulängen zeigen den dominierenden Verdampfungsbedarf.]),
  "uebung-2-2-waermeverlauf": (titel: "Bild lesen", body: [Waagerecht wächst die zugeführte Wärme, senkrecht die Temperatur. Beim Schmelzen und Verdampfen bleibt die Temperatur konstant; die unterschiedlichen Plateaulängen zeigen den dominierenden Verdampfungsbedarf.]),
  "uebung-7-9-hx-variante": (titel: "Bild lesen", body: [Waagerecht steht die gesamte Wasserbeladung in Gramm je Kilogramm trockene Luft, senkrecht die Enthalpie je Kilogramm trockene Luft. Blaue Kurven sind Isothermen, grüne Kurven Linien gleicher relativer Feuchte; die kräftige grüne Kurve ist φ = 1. Orange Pfeile zeigen die berechneten Prozessschritte, gestrichelte Linien die Mischverbindung. Die beschrifteten Punkte verwenden die bereits nachgerechneten Zahlen dieser Aufgabe.]),
  "uebung-7-9-hx-original": (titel: "Bild lesen", body: [Waagerecht steht die gesamte Wasserbeladung in Gramm je Kilogramm trockene Luft, senkrecht die Enthalpie je Kilogramm trockene Luft. Blaue Kurven sind Isothermen, grüne Kurven Linien gleicher relativer Feuchte; die kräftige grüne Kurve ist φ = 1. Orange Pfeile zeigen die berechneten Prozessschritte, gestrichelte Linien die Mischverbindung. Die beschrifteten Punkte verwenden die bereits nachgerechneten Zahlen dieser Aufgabe.]),
  "uebung-7-8-hx-variante": (titel: "Bild lesen", body: [Waagerecht steht die gesamte Wasserbeladung in Gramm je Kilogramm trockene Luft, senkrecht die Enthalpie je Kilogramm trockene Luft. Blaue Kurven sind Isothermen, grüne Kurven Linien gleicher relativer Feuchte; die kräftige grüne Kurve ist φ = 1. Orange Pfeile zeigen die berechneten Prozessschritte, gestrichelte Linien die Mischverbindung. Die beschrifteten Punkte verwenden die bereits nachgerechneten Zahlen dieser Aufgabe.]),
  "uebung-7-8-hx-original": (titel: "Bild lesen", body: [Waagerecht steht die gesamte Wasserbeladung in Gramm je Kilogramm trockene Luft, senkrecht die Enthalpie je Kilogramm trockene Luft. Blaue Kurven sind Isothermen, grüne Kurven Linien gleicher relativer Feuchte; die kräftige grüne Kurve ist φ = 1. Orange Pfeile zeigen die berechneten Prozessschritte, gestrichelte Linien die Mischverbindung. Die beschrifteten Punkte verwenden die bereits nachgerechneten Zahlen dieser Aufgabe.]),
  "uebung-7-7-hx-variante": (titel: "Bild lesen", body: [Waagerecht steht die gesamte Wasserbeladung in Gramm je Kilogramm trockene Luft, senkrecht die Enthalpie je Kilogramm trockene Luft. Blaue Kurven sind Isothermen, grüne Kurven Linien gleicher relativer Feuchte; die kräftige grüne Kurve ist φ = 1. Orange Pfeile zeigen die berechneten Prozessschritte, gestrichelte Linien die Mischverbindung. Die beschrifteten Punkte verwenden die bereits nachgerechneten Zahlen dieser Aufgabe.]),
  "uebung-7-7-hx-original": (titel: "Bild lesen", body: [Waagerecht steht die gesamte Wasserbeladung in Gramm je Kilogramm trockene Luft, senkrecht die Enthalpie je Kilogramm trockene Luft. Blaue Kurven sind Isothermen, grüne Kurven Linien gleicher relativer Feuchte; die kräftige grüne Kurve ist φ = 1. Orange Pfeile zeigen die berechneten Prozessschritte, gestrichelte Linien die Mischverbindung. Die beschrifteten Punkte verwenden die bereits nachgerechneten Zahlen dieser Aufgabe.]),
  "uebung-7-6-hx-variante": (titel: "Bild lesen", body: [Waagerecht steht die gesamte Wasserbeladung in Gramm je Kilogramm trockene Luft, senkrecht die Enthalpie je Kilogramm trockene Luft. Blaue Kurven sind Isothermen, grüne Kurven Linien gleicher relativer Feuchte; die kräftige grüne Kurve ist φ = 1. Orange Pfeile zeigen die berechneten Prozessschritte, gestrichelte Linien die Mischverbindung. Die beschrifteten Punkte verwenden die bereits nachgerechneten Zahlen dieser Aufgabe.]),
  "uebung-7-6-hx-original": (titel: "Bild lesen", body: [Waagerecht steht die gesamte Wasserbeladung in Gramm je Kilogramm trockene Luft, senkrecht die Enthalpie je Kilogramm trockene Luft. Blaue Kurven sind Isothermen, grüne Kurven Linien gleicher relativer Feuchte; die kräftige grüne Kurve ist φ = 1. Orange Pfeile zeigen die berechneten Prozessschritte, gestrichelte Linien die Mischverbindung. Die beschrifteten Punkte verwenden die bereits nachgerechneten Zahlen dieser Aufgabe.]),
  "uebung-7-5-hx-variante": (titel: "Bild lesen", body: [Waagerecht steht die gesamte Wasserbeladung in Gramm je Kilogramm trockene Luft, senkrecht die Enthalpie je Kilogramm trockene Luft. Blaue Kurven sind Isothermen, grüne Kurven Linien gleicher relativer Feuchte; die kräftige grüne Kurve ist φ = 1. Orange Pfeile zeigen die berechneten Prozessschritte, gestrichelte Linien die Mischverbindung. Die beschrifteten Punkte verwenden die bereits nachgerechneten Zahlen dieser Aufgabe.]),
  "uebung-7-5-hx-original": (titel: "Bild lesen", body: [Waagerecht steht die gesamte Wasserbeladung in Gramm je Kilogramm trockene Luft, senkrecht die Enthalpie je Kilogramm trockene Luft. Blaue Kurven sind Isothermen, grüne Kurven Linien gleicher relativer Feuchte; die kräftige grüne Kurve ist φ = 1. Orange Pfeile zeigen die berechneten Prozessschritte, gestrichelte Linien die Mischverbindung. Die beschrifteten Punkte verwenden die bereits nachgerechneten Zahlen dieser Aufgabe.]),
  "uebung-7-4-hx-variante": (titel: "Bild lesen", body: [Waagerecht steht die gesamte Wasserbeladung in Gramm je Kilogramm trockene Luft, senkrecht die Enthalpie je Kilogramm trockene Luft. Blaue Kurven sind Isothermen, grüne Kurven Linien gleicher relativer Feuchte; die kräftige grüne Kurve ist φ = 1. Orange Pfeile zeigen die berechneten Prozessschritte, gestrichelte Linien die Mischverbindung. Die beschrifteten Punkte verwenden die bereits nachgerechneten Zahlen dieser Aufgabe.]),
  "uebung-7-4-hx-original": (titel: "Bild lesen", body: [Waagerecht steht die gesamte Wasserbeladung in Gramm je Kilogramm trockene Luft, senkrecht die Enthalpie je Kilogramm trockene Luft. Blaue Kurven sind Isothermen, grüne Kurven Linien gleicher relativer Feuchte; die kräftige grüne Kurve ist φ = 1. Orange Pfeile zeigen die berechneten Prozessschritte, gestrichelte Linien die Mischverbindung. Die beschrifteten Punkte verwenden die bereits nachgerechneten Zahlen dieser Aufgabe.]),
  "uebung-7-3-hx-variante": (titel: "Bild lesen", body: [Waagerecht steht die gesamte Wasserbeladung in Gramm je Kilogramm trockene Luft, senkrecht die Enthalpie je Kilogramm trockene Luft. Blaue Kurven sind Isothermen, grüne Kurven Linien gleicher relativer Feuchte; die kräftige grüne Kurve ist φ = 1. Orange Pfeile zeigen die berechneten Prozessschritte, gestrichelte Linien die Mischverbindung. Die beschrifteten Punkte verwenden die bereits nachgerechneten Zahlen dieser Aufgabe.]),
  "uebung-7-3-hx-original": (titel: "Bild lesen", body: [Waagerecht steht die gesamte Wasserbeladung in Gramm je Kilogramm trockene Luft, senkrecht die Enthalpie je Kilogramm trockene Luft. Blaue Kurven sind Isothermen, grüne Kurven Linien gleicher relativer Feuchte; die kräftige grüne Kurve ist φ = 1. Orange Pfeile zeigen die berechneten Prozessschritte, gestrichelte Linien die Mischverbindung. Die beschrifteten Punkte verwenden die bereits nachgerechneten Zahlen dieser Aufgabe.]),
  "td-kf-164-12-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-164-07-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-163-14-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-162-14-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-162-11-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-161-15-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-161-15-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-161-14-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-161-13-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-161-12-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-161-11-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-161-10-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-161-10-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-161-03-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-161-03-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-161-01-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-160-17-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-160-17-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-160-16-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-160-15-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-160-14-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-160-13-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-160-13-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-160-08-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-160-01-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-160-01-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-159-21-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-159-21-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-159-20-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-159-20-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-159-19-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-159-18-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-159-17-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-159-16-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-159-15-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-159-14-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-159-14-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-159-09-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-159-03-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-159-03-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-159-02-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-159-02-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-158-22-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-158-22-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-158-21-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-158-20-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-158-19-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-158-18-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-158-18-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-158-17-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-158-16-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-158-15-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-158-14-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-158-13-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-158-13-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-158-12-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-158-11-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-158-08-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-158-07-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-158-03-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-158-03-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-157-22-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-157-22-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-157-21-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-157-20-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-157-19-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-157-18-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-157-17-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-157-16-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-157-15-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-157-14-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-157-13-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-157-12-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-157-12-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-157-09-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-157-06-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-157-03-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-157-03-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-156-21-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-156-21-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-156-20-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-156-19-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-156-18-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-156-18-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-156-17-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-156-16-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-156-15-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-156-14-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-156-13-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-156-13-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-156-12-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-156-09-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-156-07-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-156-03-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "td-kf-156-03-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-21-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-21-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-20-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-19-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-18-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-17-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-16-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-15-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-14-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-13-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-13-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-12-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-11-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-10-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-09-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-09-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-08-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-08-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-07-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-07-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-06-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-05-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-04-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-03-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-03-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-02-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-155-01-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-21-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-21-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-20-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-19-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-19-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-18-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-17-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-16-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-15-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-14-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-13-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-13-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-12-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-11-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-10-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-09-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-09-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-08-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-07-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-07-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-06-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-05-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-04-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-03-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-03-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-02-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-154-01-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-21-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-21-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-20-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-19-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-18-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-17-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-16-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-15-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-14-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-13-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-13-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-12-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-11-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-10-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-09-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-09-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-08-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-08-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-07-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-07-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-06-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-05-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-04-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-03-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-03-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-02-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-153-01-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-24-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-24-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-23-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-22-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-22-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-21-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-20-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-19-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-18-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-17-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-16-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-16-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-15-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-14-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-14-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-13-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-12-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-11-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-10-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-09-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-09-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-08-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-07-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-06-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-06-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-05-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-04-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-03-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-03-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-02-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-152-01-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-22-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-22-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-21-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-21-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-20-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-20-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-19-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-19-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-18-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-17-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-16-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-15-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-14-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-13-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-12-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-11-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-10-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-10-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-09-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-09-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-08-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-07-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-06-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-06-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-05-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-04-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-03-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-02-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-151-01-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-21-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-20-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-19-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-18-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-18-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-17-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-17-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-16-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-16-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-15-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-14-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-13-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-13-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-12-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-11-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-10-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-10-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-09-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-09-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-08-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-07-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-06-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-06-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-05-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-04-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-03-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-02-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-150-01-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-148-16-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-148-16-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-148-15-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-148-15-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-148-14-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-148-14-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-148-13-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-148-12-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-148-11-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-148-10-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-148-09-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-148-09-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-148-08-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-148-07-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-148-07-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-148-06-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-148-06-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-148-05-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-148-04-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-148-03-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-148-02-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-148-01-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-20-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-20-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-19-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-18-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-18-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-17-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-17-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-16-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-15-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-14-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-13-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-12-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-12-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-11-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-10-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-09-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-08-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-07-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-06-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-05-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-05-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-04-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-03-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-03-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-02-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-146-01-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-22-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-22-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-21-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-20-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-19-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-19-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-18-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-18-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-17-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-16-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-15-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-15-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-14-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-14-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-13-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-12-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-11-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-10-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-09-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-08-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-07-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-06-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-05-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-04-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-03-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-03-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-02-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-145-01-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-23-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-23-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-22-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-21-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-21-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-20-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-19-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-19-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-18-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-17-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-16-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-15-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-14-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-13-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-12-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-12-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-11-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-10-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-09-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-09-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-08-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-07-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-06-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-05-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-05-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-04-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-04-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-03-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-03-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-02-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-144-01-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-23-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-23-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-22-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-22-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-21-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-20-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-19-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-18-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-17-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-16-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-15-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-14-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-13-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-12-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-11-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-10-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-09-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-09-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-08-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-07-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-06-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-05-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-04-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-03-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-02-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-143-01-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-29-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-28-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-27-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-27-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-26-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-25-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-24-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-23-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-22-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-21-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-21-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-20-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-19-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-18-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-18-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-17-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-16-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-15-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-14-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-13-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-12-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-11-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-10-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-10-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-09-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-08-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-07-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-06-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-05-loesung": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalmusterlösung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-05-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-04-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-03-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-02-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "sm-kf-142-01-frage": (titel: "Bild lesen", body: [Diese Abbildung dokumentiert die Originalaufgabenstellung der einzeln angegebenen historischen Kurzfrage. Vorgegebene Zahlen, Achsen, Winkel und Skizzen gehören zur Quelle. Die zugehörigen Textschritte erläutern das Prinzip und markieren gegebenenfalls Abweichungen oder Fehler des Originals.]),
  "rinne-differentialkraft": (titel: "Bild lesen", body: [Ein differentielles Element der umströmten Rinne lenkt den Impuls um. Richtung und Hebelarm der örtlichen Druckkraft folgen aus der Kontur; die Gesamtwirkung entsteht erst durch Integration.]),
  "pfws0506-steigkurve": (titel: "Bild lesen", body: [Waagerecht läuft die Zeit, senkrecht die Höhe im angegebenen vereinfachten Beschleunigungsmodell. Die Kurve beginnt mit waagerechter Tangente und wird steiler. Der Endwert und die Endsteigung stammen aus derselben konstanten vertikalen Beschleunigung.]),
  "pfws0506-steigkurve-var": (titel: "Bild lesen", body: [Waagerecht läuft die Zeit, senkrecht die Höhe im angegebenen vereinfachten Beschleunigungsmodell. Die Kurve beginnt mit waagerechter Tangente und wird steiler. Der Endwert und die Endsteigung stammen aus derselben konstanten vertikalen Beschleunigung.]),
  "pfws0506-staupunktkruemmer-original": (titel: "Bild lesen", body: [Der rechtwinklige Kanal wird durch eine äußere Stromlinie des Staupunktsfeldes begrenzt. Wand I und II liegen auf den Koordinatenachsen; der äußere Luftdruck wird von den inneren Wanddrücken abgezogen.]),
  "pfws0506-radialspalt-original": (titel: "Bild lesen", body: [Wasser strömt durch einen dünnen radialen Spalt. Nach innen verkleinert sich die Ringfläche, die Geschwindigkeit steigt und der statische Druck sinkt; am inneren Rand wird die Kavitationsgrenze geprüft.]),
  "pfws0506-flugpolare": (titel: "Bild lesen", body: [Die waagerechte Achse zeigt cW, die senkrechte cA. Die gekrümmte Polare verbindet die Betriebspunkte, eine Ursprungstangente markiert bestes Gleiten. Die unterschiedlichen Achsenmaßstäbe erlauben kein direktes Abmessen des physikalischen Gleitwinkels.]),
  "pfws0506-flugpolare-var": (titel: "Bild lesen", body: [Die waagerechte Achse zeigt cW, die senkrechte cA. Die gekrümmte Polare verbindet die Betriebspunkte, eine Ursprungstangente markiert bestes Gleiten. Die unterschiedlichen Achsenmaßstäbe erlauben kein direktes Abmessen des physikalischen Gleitwinkels.]),
  "pfws0506-duesenrohr-original": (titel: "Bild lesen", body: [Das Düsenrohr besitzt einen waagerechten und einen geneigten Auslauf. Die Einspannung trägt Kräfte und Moment. Die Lösung benennt ausdrücklich die geometrische Näherung für die Mündungshöhen und Hebelarme.]),
  "pfws0102-verteilduese-original": (titel: "Bild lesen", body: [Der Zulauf teilt sich auf verschieden gerichtete freie Strahlen auf. Die eingezeichneten Winkel bestimmen die Vorzeichen des Impulsstroms; eine zusätzliche Blinddeckelkraft darf nicht doppelt zur Gesamtlast addiert werden.]),
  "pfws0102-rinne-original": (titel: "Bild lesen", body: [Die Flüssigkeit wird von der bewegten Rinne aufgenommen und umgelenkt. Absolute und relative Geschwindigkeit müssen entsprechend der gewählten bewegten Systemgrenze getrennt bilanziert werden.]),
  "pfws0102-heizkoerper-original": (titel: "Bild lesen", body: [Ein gemeinsamer Heizkreis teilt sich in Rohrwege mit unterschiedlichen Widerständen. Der gewünschte Teilstrom legt die nötige Drosselung fest, gemeinsame Verluste gehören zum Gesamtstrom.]),
  "pfss06-zweikreisnetz-original": (titel: "Bild lesen", body: [Die Pumpe fördert durch den gemeinsamen Strang III von B nach A; von A nach B führen zwei parallele Wege mit verschiedenen Durchmessern und Höhen. Die eingezeichneten Bögen gehören zum jeweiligen Verlustweg.]),
  "pfss06-wellendach-stromlinien-original": (titel: "Bild lesen", body: [Durchgezogene Stromlinien und dazu orthogonale Potentiallinien zeigen die Beschleunigung über den Wellenbergen. Die tatsächliche Konturlinie des gegebenen Potentials stimmt nur näherungsweise mit der Sinuswand überein.]),
  "pfss06-wellendach-original": (titel: "Bild lesen", body: [Die sinusförmige Dachwand besitzt Berg 1 und Senke 2. A und C liegen auf gleicher Höhe H, C direkt über dem ersten Berg; die volle Wellenlänge 2πL ist eine andere Strecke als AC.]),
  "pfss06-schwimmstab-original": (titel: "Bild lesen", body: [Der untere schwere und der obere leichte Werkstoff besitzen denselben Querschnitt. LA und LB bestimmen das Gewicht, LC die verdrängte Flüssigkeitsmenge. Kleine Neigungen verlangen zusätzlich eine Momentenprüfung.]),
  "pfss06-keilstrahl-original": (titel: "Bild lesen", body: [Der in der Zeichnung nach unten laufende Strahl teilt sich am Keil. Die Winkel α und β sind zur Eintrittsrichtung gemessen: Sinusanteile wirken horizontal, Kosinusanteile vertikal. Die Haltekraft gleicht die Fluidlast aus.]),
  "pfss06-flugzeug-original": (titel: "Bild lesen", body: [Die Zeichnung trennt Rumpf, Flügel, Höhen- und Seitenleitwerk. Bei der benetzten Flügel- und Höhenleitwerksfläche wird der im Rumpf liegende Anteil abgezogen; die freien Platten zählen auf beiden Seiten.]),
  "pfss05-oelkuehler-original": (titel: "Bild lesen", body: [Zwei getrennte Stoffströme durchqueren den Kühler mit unterschiedlichen Anschlussrichtungen. Der Impulssatz wird für jede Richtung und jeden Strom bilanziert, bevor ihre Kräfte auf das Gehäuse addiert werden.]),
  "pfss05-heiznetz-original": (titel: "Bild lesen", body: [Das Heiznetz enthält parallele Wege und gemeinsame Leitungsabschnitte. Die Teilstromgeschwindigkeiten werden über gleiche Knotenverluste verbunden; der Druck an einer inneren Stelle verlangt den passenden Teilweg.]),
  "pfss05-flussbiegung-original": (titel: "Bild lesen", body: [Das äußere Potentialfeld eines Zylinders modelliert die Biegung. Die markierten Ufer liegen auf verschiedenen Stromlinien; ihre Stromfunktionsdifferenz ergibt den Durchfluss je Tiefe.]),
  "pfss05-aquarium-original": (titel: "Bild lesen", body: [Die eingeschlossene Luft liegt über einer Wassersäule, deren Höhe h über dem äußeren Teichspiegel gemessen wird. Die zusätzlich eingetauchte Geometrie darf nicht als weitere freie Säulenhöhe addiert werden.]),
  "pfss04-staudamm-original": (titel: "Bild lesen", body: [Der Wasserweg führt vom Stausee durch eine Leitung zu tieferem Auslauf. Höhengewinn, Auslaufgeschwindigkeit, Rohrreibung und Einzelverluste bestimmen gemeinsam den benötigten Durchmesser.]),
  "pfss04-startverlauf": (titel: "Bild lesen", body: [Waagerecht läuft die Zeit, senkrecht die Höhe im angegebenen vereinfachten Beschleunigungsmodell. Die Kurve beginnt mit waagerechter Tangente und wird steiler. Der Endwert und die Endsteigung stammen aus derselben konstanten vertikalen Beschleunigung.]),
  "pfss04-startverlauf-var": (titel: "Bild lesen", body: [Waagerecht läuft die Zeit, senkrecht die Höhe im angegebenen vereinfachten Beschleunigungsmodell. Die Kurve beginnt mit waagerechter Tangente und wird steiler. Der Endwert und die Endsteigung stammen aus derselben konstanten vertikalen Beschleunigung.]),
  "pfss04-ringduese-original": (titel: "Bild lesen", body: [Der Zulauf wird in einen umlaufenden radialen Ringstrahl umgelenkt. Die radialen Impulsanteile heben sich bei Rotationssymmetrie auf; für die axiale Last bleiben Zulaufimpuls und Druckkräfte.]),
  "pfss04-huegel-original": (titel: "Bild lesen", body: [Das Potentialfeld überlagert Parallelströmung und Dipol zur Hügelkontur. Geschwindigkeiten werden aus dem Feld abgeleitet und anschließend über Bernoulli in Druck umgerechnet; unphysikalische innere Feldpunkte sind gesondert zu prüfen.]),
  "pfss03-verzweigung-original": (titel: "Bild lesen", body: [Die Leitung verzweigt sich in mehrere Ausläufe. Die Knotenbilanz verbindet die Teilströme; Rohrdurchmesser und die Höhenlage jedes Auslaufs gehören in seine eigene Energiegleichung.]),
  "pfss03-quellenprofil-original": (titel: "Bild lesen", body: [Eine Quelle überlagert die horizontale Parallelströmung. Der obere und untere Ast der Trennstromlinie bilden das offene Profil; Staupunkt und asymptotische Breite folgen aus dem Quellenfeld.]),
  "pfss03-do27-polare-original": (titel: "Bild lesen", body: [Die Polaren zeigen Auftrieb und Widerstand für unterschiedliche Klappenstellungen und Betriebsfälle. Die gemessene Kraft wird zunächst in einen Beiwert übersetzt, bevor der passende Punkt oder Winkel abgelesen wird.]),
  "pfss03-aquariumfenster-original": (titel: "Bild lesen", body: [Das runde Bullauge und das Ersatzrechteck liegen unter dem freien Wasserspiegel. Gleiche resultierende Wandkraft verlangt das gleiche erste Flächenmoment bezüglich des Spiegels, nicht zwingend gleiche Fläche.]),
  "lnss05-rohrsystem-original": (titel: "Bild lesen", body: [Zwei Rohre mit unterschiedlichen Durchmessern liegen in Reihe. Die Querschnittsänderung legt das Geschwindigkeitsverhältnis fest; Krümmer, Eintritt und Rohrreibung erzeugen zusätzliche Verluste.]),
  "lnss05-rohreinlauf-original": (titel: "Bild lesen", body: [Vom großen Raum tritt Luft in das Rohr ein. Zwischen Eintritt und Messstelle wachsen die wandnahen Grenzschichten; der Unterdruck an der Messstelle wird mit dem ausgewiesenen Bernoulli-Modell in Geschwindigkeit übersetzt.]),
  "lnss05-quellenprofil-stromlinien": (titel: "Bild lesen", body: [Die Linien folgen der Überlagerung von Quelle und Parallelströmung. Die Trennstromlinie durch den Staupunkt bildet die idealisierte Vorderkante; innere Quellströmung und äußere Umströmung werden getrennt sichtbar.]),
  "lnss05-profilnase-original": (titel: "Bild lesen", body: [Die Parallelströmung und eine Quelle erzeugen eine Trennstromlinie als Profilkontur. Der markierte Punkt Q dient zum Einzeichnen des Geschwindigkeitsvektors. Winkel und Koordinaten legen die Zerlegung in kartesische und radiale Komponenten fest.]),
  "aquarium-luftstrom-hoehe": (titel: "Bild lesen", body: [Die waagerechte Größe ist die Wasserhöhe über dem äußeren Teichspiegel, mit ρg/p∞ normiert. Eine höhere Säule erzeugt niedrigeren Innendruck. Der Luftmassenstrom steigt zunächst mit der Höhe und bleibt oberhalb der kritischen Höhe konstant; beim tatsächlichen Absinken der Säule läuft der Prozess in Gegenrichtung.]),
  "kompressibler-gasausfluss": (titel: "Bild lesen", body: [Waagerecht steht der Nachdruck geteilt durch den Staudruck vor dem Ventil, senkrecht der normierte Massenstrom. Rechts bei gleichem Druck ist der Strom null. Mit wachsendem Druckgefälle nimmt er zu, bis das kritische Verhältnis erreicht ist; links davon bleibt er auf dem Maximum.]),
  "wasserbad-var-temperatur-leistung": (titel: "Bild lesen", body: [Oben ist die Temperatur über der Zeit gezeichnet: linearer Anstieg, knickfreier parabolischer Übergang und Halten. Unten steht die zugehörige Leistung pro Masse: zunächst konstant, dann linear auf null fallend. Der adiabate Modellfall benötigt beim Halten keine weitere Leistung.]),
  "wasserbad-temperatur-leistung": (titel: "Bild lesen", body: [Oben ist die Temperatur über der Zeit gezeichnet: linearer Anstieg, knickfreier parabolischer Übergang und Halten. Unten steht die zugehörige Leistung pro Masse: zunächst konstant, dann linear auf null fallend. Der adiabate Modellfall benötigt beim Halten keine weitere Leistung.]),
  "senkenduese-komponenten": (titel: "Bild lesen", body: [Am Punkt auf der oberen radialen Wand zeigt der Geschwindigkeitsvektor zur Senke. Die horizontalen und vertikalen Pfeile zerlegen denselben Vektor in u und v. Eine tangentiale Komponente tritt bei diesem reinen Senkenmodell nicht auf.]),
  "pfws0304-senkenduese-original": (titel: "Bild lesen", body: [Der Düsensektor liegt zwischen zwei Radien und zwei geraden Wänden mit vollem Öffnungswinkel α. Die Geschwindigkeit zeigt radial zur außerhalb liegenden Senke. Der äußere Radius ist der Druckbezug; nach innen steigt der Geschwindigkeitsbetrag und sinkt der statische Druck.]),
  "pfws0304-schleusentor-original": (titel: "Bild lesen", body: [Die beiden Torflügel stemmen sich symmetrisch gegen einander. Die Wassertiefen H und h liefern entgegengesetzte Dreiecksdrucklasten, der Winkel α legt die Breite eines einzelnen Flügels und die Richtung der Stemmkraft fest.]),
  "pfws0304-luftbehaelter-original": (titel: "Bild lesen", body: [Zwei geneigte bzw. waagerechte Einlässe speisen den stehenden Behälter, ein größerer Auslass führt nach unten. Die Lager nehmen getrennte horizontale und vertikale Anteile auf. Einlassimpulse und Einlassdruckkräfte haben dieselben geometrischen Richtungen.]),
  "pfws0304-kuehlernetz-original": (titel: "Bild lesen", body: [Der gemeinsame Gesamtstrom teilt sich in einen schmaleren Kühlerstrang und einen breiteren Bypass mit Ventil. Die Verzweigungs-/Vereinigungsbeiwerte beziehen sich auf den Gesamtstrom; Kühler und Ventil auf ihren jeweiligen Teilstrom.]),
  "pfws0203-spoiler-polare-original": (titel: "Bild lesen", body: [Die waagerechte Achse zeigt den Anstellwinkel α, die senkrechte den Auftriebsbeiwert cA. Ein negativer cA liefert Abtrieb. Der aus dem Modellversuch bestimmte Wert wird auf die Gerade übertragen; der Winkel bleibt ein Ablesewert der Originalpolare.]),
  "pfws0203-spoiler-kraefte": (titel: "Bild lesen", body: [Die Anströmung und der Widerstand zeigen nach hinten, die Fahrzeugbewegung in Gegenrichtung. Der negative Auftrieb zeigt nach unten. Widerstand und Abtrieb ergeben die fast senkrechte Gesamtkraft; der kleine Winkel zu deren Abtriebsrichtung ist vom Winkel gegen die horizontale Achse zu unterscheiden.]),
  "pfws0203-spoiler-kraefte-var": (titel: "Bild lesen", body: [Die Anströmung und der Widerstand zeigen nach hinten, die Fahrzeugbewegung in Gegenrichtung. Der negative Auftrieb zeigt nach unten. Widerstand und Abtrieb ergeben die fast senkrechte Gesamtkraft; der kleine Winkel zu deren Abtriebsrichtung ist vom Winkel gegen die horizontale Achse zu unterscheiden.]),
  "pfws0203-pumpe-duese-original": (titel: "Bild lesen", body: [Vom Tank durchläuft der Kraftstoff Eintritt, Ventil, Sieb, Saugleitung, Pumpe, Druckleitung und Einspritzdüse. Die Stationsnummern trennen die Verlustabschnitte. Unterschiedliche Durchmesser erzeugen unterschiedliche Geschwindigkeitsanteile an den Pumpenstutzen.]),
  "pfws0203-pumpe-druck": (titel: "Bild lesen", body: [Die waagerechte Richtung folgt den Stationen vom Tank zum Motor, senkrecht steht der statische Absolutdruck. Auf der Saugseite fällt er geringfügig, an der Pumpe steigt er stark und an der Düse fällt er bis zum Motorwert. Der Gesamtmaßstab macht die kleinen Saugverluste kaum sichtbar.]),
  "pfws0203-pumpe-druck-var": (titel: "Bild lesen", body: [Die waagerechte Richtung folgt den Stationen vom Tank zum Motor, senkrecht steht der statische Absolutdruck. Auf der Saugseite fällt er geringfügig, an der Pumpe steigt er stark und an der Düse fällt er bis zum Motorwert. Der Gesamtmaßstab macht die kleinen Saugverluste kaum sichtbar.]),
  "pfws0203-prallschild-original": (titel: "Bild lesen", body: [Der Prallschild wird vorn durch das Potentialfeld angeströmt und hinten über Schlitze mit dem dortigen Druck beaufschlagt. Die Nettokraft verwendet deshalb die Differenz zwischen der örtlichen Vorderseitenlast und dem konstanten Rückseitendruck.]),
  "pfws0203-brause-original": (titel: "Bild lesen", body: [Die Eintrittsrichtung des Brausekopfs ist gegen die waagerechte Achse geneigt, die Düsenströme zeigen nach unten. Der Winkel der Originalskizze legt die Vorzeichen der x-/y-Komponenten fest. Die gesuchte Haltekraft gleicht die Fluidkraft auf den Körper aus.]),
  "pfss02-pumpenscheitel-original": (titel: "Bild lesen", body: [Der Wasserweg führt vom ersten Becken über einen hoch liegenden Scheitel zum zweiten. Für den Scheiteldruck wird nur der Teilweg bis zum Scheitel bilanziert; Ventil- und Rohrverluste hinter diesem Punkt gehören erst in die Gesamtbilanz.]),
  "pfss02-abzweig-original": (titel: "Bild lesen", body: [Die Originalskizze zeigt einen Doppelkrümmer mit verschließbarem Abzweig. Offener und geschlossener Hahn verändern Durchsatzaufteilung und Druckkräfte. Ein angegebener Umgebungsdruck an der geschlossenen Außenseite ersetzt nicht automatisch den Innendruck des offenen Abzweigs.]),
  "pfss01-zweistrahl-original": (titel: "Bild lesen", body: [Ein Zulauf teilt sich in zwei freie Strahlen. Die eingezeichneten Richtungen gehören als Vektoren in die Impulsbilanz; bei einem Auslauf nach links ist die x-Komponente negativ. Die Fluidkraft auf das Rohr ist die Gegenkraft zur Wandkraft auf das Fluid.]),
  "pfss01-wirbelduese-original": (titel: "Bild lesen", body: [Die Originalskizze legt die Lage von Potentialwirbel, Düsenwänden und Austrittsöffnung fest. Die geometrischen Abstände bestimmen die Integrationsgrenzen des Stroms; die Geschwindigkeitsrichtung folgt dem angegebenen Vorzeichen der Zirkulation.]),
  "glas-druck-kurven": (titel: "Bild lesen", body: [Die senkrechte Koordinate ist die Tiefe ζ ab dem Glasrand, waagerecht steht Außen- minus Innendruck. Die leere Seitenwand erhält erst unter dem äußeren Wasserspiegel eine wachsende Druckdifferenz. Beim gefüllten Glas wächst sie zunächst und bleibt unter dem inneren Wasserspiegel konstant; die Höhen sind nur qualitativ angeordnet.]),
  "boiler-entnahme-mittelwert": (titel: "Bild lesen", body: [Waagerecht läuft die Zeit, senkrecht steht der entnommene Volumenstrom. Sechs Minuten mit zehn Litern je Minute und sonst keine Entnahme ergeben über sechzig Minuten einen Mittelwert von einem Liter je Minute. Die gestrichelte Linie ist der Zeitmittelwert, keine tatsächlich konstante Entnahme.]),
  "bilanz-behaelter-schema": (titel: "Bild lesen", body: [Die Grenze umfasst den gespeicherten Behälterinhalt. Zulauf und Ablauf überqueren sie an verschiedenen Stellen; ihre Differenz verändert die Masse. Bei konstantem Querschnitt übersetzt die Dichte die Masse in den Füllstand.]),
  "badewanne-systemskizze": (titel: "Bild lesen", body: [Hahn und Dusche führen Wasser zu, Bodenabfluss und Rostlöcher führen es ab. Der Überlauf wird erst bei voller Wanne wirksam. Aus den im Bild angegebenen Volumenströmen entsteht bei konstanter Dichte die Speicherbilanz.]),
  "vdw-kritische-isotherme": (titel: "Bild lesen", body: [Die Achsen zeigen Druck und spezifisches Volumen relativ zu den kritischen Modellwerten. Die grüne kritische Isotherme hat beim markierten Punkt eine waagerechte Wendestelle; die blaue wärmere Isotherme fällt dort weiter ab. Beide Kurven sind Modellverläufe und keine neuen Messdaten für einen realen Stoff.]),
  "torricelli-heber-folie": (titel: "Bild lesen", body: [Punkt 1 liegt an der freien Behälteroberfläche, Punkt 2 am tieferen freien Austritt. Die Höhe zwischen beiden liefert den Geschwindigkeitshöhenanteil. Der Scheitel liegt auf dem Weg dazwischen: Dort ist der Absolutdruck separat zu prüfen, obwohl die Austrittsgeschwindigkeit von den Endpunkten bestimmt wird.]),
  "druck-richtungsunabhaengigkeit": (titel: "Bild lesen", body: [Die drei unterschiedlich orientierten Flächen des kleinen Prismas tragen jeweils normal gerichtete Druckkräfte. Ihre Komponenten müssen im ruhenden Fluid im Gleichgewicht sein. Im Grenzfall eines sehr kleinen Prismas verschwindet der Einfluss des Eigengewichts gegenüber den Flächenkräften; alle Richtungsdrücke stimmen überein.]),
  "brennstoffzelle-elektroden-memory": (titel: "Bild lesen", body: [Die drei Spalten nennen Anodenreaktion, Kathodenreaktion und transportiertes Ion. Der Elektrolyt bestimmt, ob Protonen, Hydroxid-, Carbonat- oder Oxidionen wandern. Der Elektronenstrom nimmt den äußeren Weg; die Gesamtreaktion entsteht durch Addition beider Halbgleichungen.]),
  "klimazentrale-memory": (titel: "Bild lesen", body: [Außenluft ODA und Umluft RCA ergeben die Mischluft MIA. Aufbereitung und Ventilator erzeugen die Zuluft SUP. Erst nach Wärme-, Arbeits- und Wassereinträgen im Raum entsteht die Raumluft IDA; Abluft und Umluft sind entsprechend der gezeichneten Verzweigung zu trennen.]),
  "linde-claude-memory": (titel: "Bild lesen", body: [Links wird der gesamte Hochdruckstrom nach Vorkühlung gedrosselt und im Abscheider aufgeteilt. Rechts zweigt im Claude-Verfahren ein Teilstrom zur Expansionsmaschine ab. Die Pfeile der Rückströme zeigen, welcher Anteil den jeweiligen Gegenstrom-Wärmeübertrager tatsächlich durchläuft. Unten ordnet das T-s-Diagramm die dazugehörigen Stoffzustände und Entspannungswege ein.]),
  "philips-stirling-kaelte-memory": (titel: "Bild lesen", body: [Der linksläufige Stirling-Prozess tauscht Nutzkälte auf der unteren und Abwärme auf der oberen Isotherme. Die verbindenden Isochoren geben Wärme an den Regenerator ab und nehmen sie zurück. Rechts trennt die Konstruktion Arbeitskolben, Verdränger und Wärmeaustauscher.]),
  "joule-kaeltemaschine-memory": (titel: "Bild lesen", body: [Links stehen Druck und spezifisches Volumen, rechts Temperatur und Entropie. Der ideale Linkslauf enthält zwei Isentropen und zwei Isobaren. Die realen Verdichtungs- und Expansionswege erzeugen Entropie; ihre Endpunkte liegen gegenüber den Isentropen nach rechts versetzt.]),
  "lnss01-segelflug-polare": (titel: "Bild lesen", body: [Originalskizze aus SMLNSS01, Aufgabenblatt PDF-S.5–6. Komponenten, Zustände, Koordinaten und Polarenablesung sind im zugehörigen Aufgabentext erläutert.]),
  "lnss01-fussboden-original": (titel: "Bild lesen", body: [Originalskizze aus SMLNSS01, Aufgabenblatt PDF-S.5–6. Komponenten, Zustände, Koordinaten und Polarenablesung sind im zugehörigen Aufgabentext erläutert.]),
  "lnss01-kruemmer-original": (titel: "Bild lesen", body: [Originalskizze aus SMLNSS01, Aufgabenblatt PDF-S.5–6. Komponenten, Zustände, Koordinaten und Polarenablesung sind im zugehörigen Aufgabentext erläutert.]),
  "pf0102-sauna-0": (titel: "Bild lesen", body: [Eigene berechnete h-x-Darstellung der Saunaaufgabe aus PFWS01/02. Waagerecht Wasserbeladung, senkrecht Enthalpie, blau die Sättigung bei1bar. Die Mischungsgerade von heißer Saunaluft zur Umgebung schneidet die Sättigungskurve zweimal; dazwischen entsteht Nebel.]),
  "pf0102-sauna-1": (titel: "Bild lesen", body: [Eigene berechnete h-x-Darstellung der Saunaaufgabe aus PFWS01/02. Waagerecht Wasserbeladung, senkrecht Enthalpie, blau die Sättigung bei1bar. Die Mischungsgerade von heißer Saunaluft zur Umgebung schneidet die Sättigungskurve zweimal; dazwischen entsteht Nebel.]),
  "lnss01-wirbelkanal-original": (titel: "Bild lesen", body: [Originalskizze aus SMLNSS01, Aufgabenblatt PDF-S.5–6. Komponenten, Zustände, Koordinaten und Polarenablesung sind im zugehörigen Aufgabentext erläutert.]),
  "vorlesung-rohrnetz-original": (titel: "Bild lesen", body: [Originalnetz aus S23, PDF-S.27. Gemeinsamer Weg zwei Längenℓ, oberer Zweig eineℓ, rechter Zweig zweiℓ. Die Endbehälter liegen auf unterschiedlichen Höhen. Die T-Stückbeiwerte beziehen sich auf den ungetrennten Strom.]),
  "v05-isobaren-0": (titel: "Bild lesen", body: [Eigene berechnete Isobaren des idealen Luftmodells nachV05 PDF-S.14. Waagerecht steht die Entropie, senkrecht die Celsiustemperatur. Die farbigen Kurven gelten für feste Drücke. Bezug:1bar/0°C/s0; Rechenwerte und Einheiten stehen im zugehörigen Aufgabentext.]),
  "v05-isobaren-1": (titel: "Bild lesen", body: [Eigene berechnete Isobaren des idealen Luftmodells nachV05 PDF-S.14. Waagerecht steht die Entropie, senkrecht die Celsiustemperatur. Die farbigen Kurven gelten für feste Drücke. Bezug:1bar/0°C/s0; Rechenwerte und Einheiten stehen im zugehörigen Aufgabentext.]),
  "turbofan-folien-original": (titel: "Bild lesen", body: [Der Kernstrom läuft durch Verdichter, Brennkammer und Turbinen; der Fan fördert zusätzlich Nebenstrom. Eine Hochdruckturbine treibt den Hochdruckverdichter, eine Niederdruckturbine den Fan und Niederdruckverdichter über eine zweite Welle. Die Zahlen und der dargestellte Flugzeugtyp sind historische Folienbeispiele. QuelleV06 PDF-S.13.]),
  "hydrodynamisches-paradoxon": (titel: "Bild lesen", body: [Die Strömung verlässt den Spalt zwischen Rohr und Kreisplatte radial. Bei konstantem Spalt ist die Geschwindigkeit innen größer als außen; der statische Druck liegt dort unter dem Außendruck. Die Druckverteilung kann die Platte zum Rohr ziehen. Direkt im Umlenk-/Auftreffgebiet muss zusätzlich die Impulswirkung betrachtet werden. QuelleS23 PDF-S.6.]),
  "hydrostatisches-paradoxon": (titel: "Bild lesen", body: [Eigene schematische Darstellung nach BS, Aufgabe1.17, PDF-S.45, zum Thema vonS1 PDF-S.4. Alle Gefäße haben gleiche Bodenfläche und Füllhöhe; ihre Wassermassen unterscheiden sich. Die grünen Bodenkraftpfeile sind deshalb gleich. Schräge und abgestufte Wände tragen vertikale Kraftanteile. Die Skizze rekonstruiert keinen fehlenden Tafelanschrieb.]),
  "luft-wasser-memory": (titel: "Bild lesen", body: [Die Luftzustände L werden mit der gesättigten Grenzschicht über Wasser bei tG verglichen. Temperaturunterschied und Wasserdampfpartialdruck entscheiden über Wärme- und Stoffstrom; Verdunstung ist nicht automatisch identisch mit reiner Luftkühlung. G ist der zugehörige Sättigungszustand. Quelle MT PDF-S.25, BildM8-4.]),
  "taupunktregler-memory": (titel: "Bild lesen", body: [Außenluft ODA wird auf der zum Soll-Taupunkt TP gehörenden Enthalpie vorbereitet, im idealen Wäscher bis TP gesättigt und danach bei konstantem Wassergehalt zur Raumluft IDA erwärmt. Die Lage des maximalen Außenluftzustands ODAmax begrenzt dieses einfache Regelverfahren. Quelle MT PDF-S.25, BildM8-3a.]),
  "mollier-memory-original": (titel: "Bild lesen", body: [Im Mollier-Diagramm wächst x nach rechts; Enthalpien werden an der schiefen h-Achse bzw. ihren parallelen Linien gelesen. Der Mischzustand liegt auf der Verbindungslinie der Ausgangszustände. Die Kühlgerade erreicht zuerst den Taupunkt; bei tieferer Kühlfläche wird Wasser ausgeschieden. G markiert die Kühlgrenze, F die Kühlflächentemperatur. Quelle MT PDF-S.23, BildM8-1.]),
  "pf0304-tunnel-1": (titel: "Bild lesen", body: [Eigene berechnete h-x-Darstellung zur angegebenen Altklausur. Waagerecht Wasserbeladung in g/kg trockene Luft, senkrecht spezifische Enthalpie in kJ/kg trockene Luft. Blau zeigt Sättigung bei1bar, grün die Zustandsfolge, beschriftete Punkte die im Aufgabentext definierten Zustände. Beim Kühlen mit Kondensation folgt der reale Verlauf der Sättigungsgrenze; die Verbindungslinien sind eine schematische Übersicht.]),
  "pf0304-tunnel-0": (titel: "Bild lesen", body: [Eigene berechnete h-x-Darstellung zur angegebenen Altklausur. Waagerecht Wasserbeladung in g/kg trockene Luft, senkrecht spezifische Enthalpie in kJ/kg trockene Luft. Blau zeigt Sättigung bei1bar, grün die Zustandsfolge, beschriftete Punkte die im Aufgabentext definierten Zustände. Beim Kühlen mit Kondensation folgt der reale Verlauf der Sättigungsgrenze; die Verbindungslinien sind eine schematische Übersicht.]),
  "ln9900-kammer-1": (titel: "Bild lesen", body: [Eigene berechnete h-x-Darstellung zur angegebenen Altklausur. Waagerecht Wasserbeladung in g/kg trockene Luft, senkrecht spezifische Enthalpie in kJ/kg trockene Luft. Blau zeigt Sättigung bei1bar, grün die Zustandsfolge, beschriftete Punkte die im Aufgabentext definierten Zustände. Beim Kühlen mit Kondensation folgt der reale Verlauf der Sättigungsgrenze; die Verbindungslinien sind eine schematische Übersicht.]),
  "ln9900-kammer-0": (titel: "Bild lesen", body: [Eigene berechnete h-x-Darstellung zur angegebenen Altklausur. Waagerecht Wasserbeladung in g/kg trockene Luft, senkrecht spezifische Enthalpie in kJ/kg trockene Luft. Blau zeigt Sättigung bei1bar, grün die Zustandsfolge, beschriftete Punkte die im Aufgabentext definierten Zustände. Beim Kühlen mit Kondensation folgt der reale Verlauf der Sättigungsgrenze; die Verbindungslinien sind eine schematische Übersicht.]),
  "pf9900-dampfbad-1": (titel: "Bild lesen", body: [Eigene berechnete h-x-Darstellung zur angegebenen Altklausur. Waagerecht Wasserbeladung in g/kg trockene Luft, senkrecht spezifische Enthalpie in kJ/kg trockene Luft. Blau zeigt Sättigung bei1bar, grün die Zustandsfolge, beschriftete Punkte die im Aufgabentext definierten Zustände. Beim Kühlen mit Kondensation folgt der reale Verlauf der Sättigungsgrenze; die Verbindungslinien sind eine schematische Übersicht.]),
  "pf9900-dampfbad-0": (titel: "Bild lesen", body: [Eigene berechnete h-x-Darstellung zur angegebenen Altklausur. Waagerecht Wasserbeladung in g/kg trockene Luft, senkrecht spezifische Enthalpie in kJ/kg trockene Luft. Blau zeigt Sättigung bei1bar, grün die Zustandsfolge, beschriftete Punkte die im Aufgabentext definierten Zustände. Beim Kühlen mit Kondensation folgt der reale Verlauf der Sättigungsgrenze; die Verbindungslinien sind eine schematische Übersicht.]),
  "pf0506-schule-schema": (titel: "Bild lesen", body: [Originalskizze aus PF Thermodynamik WS05/06. Komponenten und Zustandsnummern werden im zugehörigen Aufgabentext erläutert. Die Bildunterschrift nennt die Quelle.]),
  "pf0001-klima-0": (titel: "Bild lesen", body: [Eigene berechnete h-x-Darstellung zur angegebenen Altklausur. Waagerecht Wasserbeladung in g/kg trockene Luft, senkrecht spezifische Enthalpie in kJ/kg trockene Luft. Blau zeigt Sättigung bei1bar, grün die Zustandsfolge, beschriftete Punkte die im Aufgabentext definierten Zustände. Beim Kühlen mit Kondensation folgt der reale Verlauf der Sättigungsgrenze; die Verbindungslinien sind eine schematische Übersicht.]),
  "pf0001-klima-1": (titel: "Bild lesen", body: [Eigene berechnete h-x-Darstellung zur angegebenen Altklausur. Waagerecht Wasserbeladung in g/kg trockene Luft, senkrecht spezifische Enthalpie in kJ/kg trockene Luft. Blau zeigt Sättigung bei1bar, grün die Zustandsfolge, beschriftete Punkte die im Aufgabentext definierten Zustände. Beim Kühlen mit Kondensation folgt der reale Verlauf der Sättigungsgrenze; die Verbindungslinien sind eine schematische Übersicht.]),
  "ueb9900-buero-0": (titel: "Bild lesen", body: [Eigene berechnete h-x-Darstellung zur angegebenen Altklausur. Waagerecht Wasserbeladung in g/kg trockene Luft, senkrecht spezifische Enthalpie in kJ/kg trockene Luft. Blau zeigt Sättigung bei1bar, grün die Zustandsfolge, beschriftete Punkte die im Aufgabentext definierten Zustände. Beim Kühlen mit Kondensation folgt der reale Verlauf der Sättigungsgrenze; die Verbindungslinien sind eine schematische Übersicht.]),
  "ueb9900-buero-1": (titel: "Bild lesen", body: [Eigene berechnete h-x-Darstellung zur angegebenen Altklausur. Waagerecht Wasserbeladung in g/kg trockene Luft, senkrecht spezifische Enthalpie in kJ/kg trockene Luft. Blau zeigt Sättigung bei1bar, grün die Zustandsfolge, beschriftete Punkte die im Aufgabentext definierten Zustände. Beim Kühlen mit Kondensation folgt der reale Verlauf der Sättigungsgrenze; die Verbindungslinien sind eine schematische Übersicht.]),
  "pf0506-schwimmhalle-schema": (titel: "Bild lesen", body: [Originalskizze aus PF Thermodynamik WS05/06. Komponenten und Zustandsnummern werden im zugehörigen Aufgabentext erläutert. Die Bildunterschrift nennt die Quelle.]),
  "pf0405-winter-0": (titel: "Bild lesen", body: [Eigene berechnete h-x-Darstellung zur angegebenen Altklausur. Waagerecht Wasserbeladung in g/kg trockene Luft, senkrecht spezifische Enthalpie in kJ/kg trockene Luft. Blau zeigt Sättigung bei1bar, grün die Zustandsfolge, beschriftete Punkte die im Aufgabentext definierten Zustände. Beim Kühlen mit Kondensation folgt der reale Verlauf der Sättigungsgrenze; die Verbindungslinien sind eine schematische Übersicht.]),
  "pf0405-winter-1": (titel: "Bild lesen", body: [Eigene berechnete h-x-Darstellung zur angegebenen Altklausur. Waagerecht Wasserbeladung in g/kg trockene Luft, senkrecht spezifische Enthalpie in kJ/kg trockene Luft. Blau zeigt Sättigung bei1bar, grün die Zustandsfolge, beschriftete Punkte die im Aufgabentext definierten Zustände. Beim Kühlen mit Kondensation folgt der reale Verlauf der Sättigungsgrenze; die Verbindungslinien sind eine schematische Übersicht.]),
  "pf0203-optionen-1": (titel: "Bild lesen", body: [Eigene berechnete h-x-Darstellung zur angegebenen Altklausur. Waagerecht Wasserbeladung in g/kg trockene Luft, senkrecht spezifische Enthalpie in kJ/kg trockene Luft. Blau zeigt Sättigung bei1bar, grün die Zustandsfolge, beschriftete Punkte die im Aufgabentext definierten Zustände. Beim Kühlen mit Kondensation folgt der reale Verlauf der Sättigungsgrenze; die Verbindungslinien sind eine schematische Übersicht.]),
  "pf0203-optionen-0": (titel: "Bild lesen", body: [Eigene berechnete h-x-Darstellung zur angegebenen Altklausur. Waagerecht Wasserbeladung in g/kg trockene Luft, senkrecht spezifische Enthalpie in kJ/kg trockene Luft. Blau zeigt Sättigung bei1bar, grün die Zustandsfolge, beschriftete Punkte die im Aufgabentext definierten Zustände. Beim Kühlen mit Kondensation folgt der reale Verlauf der Sättigungsgrenze; die Verbindungslinien sind eine schematische Übersicht.]),
  "gleitflug-kraefte": (titel: "Bild lesen", body: [Die Flugbahn fällt nach rechts ab. Auftrieb steht senkrecht zur relativen Anströmung, Widerstand entgegen der Bewegung, Gewicht senkrecht nach unten. Im stationären Gleitflug bilden die drei Kräfte ein geschlossenes Dreieck. Die beste Gleitzahl ist nicht automatisch die kleinste Sinkgeschwindigkeit. Eigene Darstellung nach BS PDF-S. 323–330.]),
  "koerperkraefte": (titel: "Bild lesen", body: [Die Kugel bewegt sich im Fall nach unten; Widerstand und statischer Auftrieb zeigen nach oben. Bei stationärer Endgeschwindigkeit ist die resultierende Kraft null. A ist bei der Kugel ihre Stirn- bzw. Schattenfläche, nicht die ganze Kugeloberfläche. Eigene Darstellung nach BS Widerstand/Fallgleichgewicht, PDF-S. 282–306.]),
  "modell-aehnlichkeit": (titel: "Bild lesen", body: [Die große und kleine Kugel sind geometrisch ähnlich. Unterschiedliche Fluide und Geschwindigkeiten können dieselbe Reynolds-Zahl ergeben. Dann bleiben bei gleicher relativer Rauigkeit die dimensionslosen Kraft-/Druckbeiwerte gleich, während absolute Kräfte mit Dichte, Geschwindigkeit und Fläche skalieren. Andere dominante Effekte benötigen zusätzliche Kennzahlen. Eigene Darstellung nach BS PDF-S. 199–204.]),
  "potential-stromlinien": (titel: "Bild lesen", body: [Die Anströmung läuft von links nach rechts. Grün ist die trennende Stromlinie der Überlagerung von Parallelströmung und Quelle; ihr vorderster Punkt ist ein Staupunkt. Blaue Stromlinien umströmen die grüne Kontur. Die geometrische Ähnlichkeit ist eine Modellhilfe; weder Reibungswiderstand noch Ablösung werden dargestellt. Eigene Auswertung der Potential-/Stromfunktion nach BS PDF-S. 161–163.]),
  "ws13-schiff-original": (titel: "Bild lesen", body: [Originalskizze aus Q140, PDF-S. 6; im Aufgabentext mit Herkunft und Größen erläutert.]),
  "ss13-rohrnetz-original": (titel: "Bild lesen", body: [Originalskizze aus Q141, PDF-S. 3; im Aufgabentext mit Herkunft und Größen erläutert.]),
  "ss24-fontane-original": (titel: "Bild lesen", body: [Originalskizze aus Q139, PDF-S. 2; im Aufgabentext mit Herkunft und Größen erläutert.]),
  "ss24-presse-original": (titel: "Bild lesen", body: [Originalskizze aus Q139, PDF-S. 3; im Aufgabentext mit Herkunft und Größen erläutert.]),
  "kugel-stratifikation-original": (titel: "Bild lesen", body: [Original-Kugel mit lokaler y-Koordinate ab Mittelpunkt und x nach unten ab Oberfläche. T ist die Tiefe der Kugeloberkante, xM die Mittelpunkttiefe. Quelle Zusatzblatt Auftrieb PDF-S. 1.]),
  "rohrnetz-original": (titel: "Bild lesen", body: [Original-Rohrnetz mit Knoten I/II, Bypass, Wärmeübertrager und gemeinsamem Strang 3. Quelle Zusatzblatt Rohrnetz PDF-S. 1; Höhen und Durchmesserbezeichnungen gehören zum Original. In Aufgaben.typ erläutert.]),
  "waermeleitung-fourier": (titel: "Bild lesen", body: [Die Vorzeichenbeziehung zeigt: Wärme fließt von höherer zu niedrigerer Temperatur. Links stehen die lokale Wärmestromdichte und rechts der Temperaturgradient. Je nach ebener, zylindrischer oder kugelförmiger Wand verändert sich die Fläche entlang des Wärmewegs. Quelle MT PDF-S. 38.]),
  "brennstoffzelle-kennlinie": (titel: "Bild lesen", body: [Waagerecht steht der elektrische Strom, senkrecht die Zellspannung. Die reale Spannung fällt unter die reversible Leerlaufspannung; das Rechteck U mal I ist der abgegebene Leistungsbetrag. Die Differenz zur energetischen Reaktionsspannung wird als Wärme abgeführt. Quelle MT PDF-S. 35.]),
  "brennstoffzelle-schema": (titel: "Bild lesen", body: [Links wird Wasserstoff an der Anode in Protonen und Elektronen getrennt. Die Elektronen fließen durch die äußere Last und leisten elektrische Arbeit; Protonen passieren den Elektrolyten. Rechts entstehen mit Sauerstoff Wasser und Wärme. Quelle MT PDF-S. 32, Wasserstoff-Sauerstoff-Zelle; Wege nicht mit einem thermischen Kreisprozess verwechseln.]),
  "uebung-1-11-realgasdiagramm": (titel: "Bild lesen", body: [Realgasfaktor über reduziertem Druck, Parameter reduzierte Temperatur. Original aus Ü 1.11, PDF-S. 8; nur in Aufgaben.typ genutzt.]),
  "r134a-vollstaendiges-ph": (titel: "Bild lesen", body: [Vollständiges R134a-Druck-Enthalpie-Diagramm aus BT A.12, PDF-S. 516, gedreht für h waagerecht. Logarithmische Druckachse, Sättigungsgrenzen und Isolinien. Nur in Aufgaben.typ als Originalquelle verwendet.]),
  "map-stroemung": (titel: "Bild lesen", body: [Die vier Äste ordnen das Kapitel vom Modell über die Rechenschritte bis zur Ergebnisprüfung. Die Verknüpfungen werden in den Abschnitten erläutert; eigene Darstellung.]),
  "map-verbrennung": (titel: "Bild lesen", body: [Die vier Äste ordnen das Kapitel vom Modell über die Rechenschritte bis zur Ergebnisprüfung. Die Verknüpfungen werden in den Abschnitten erläutert; eigene Darstellung.]),
  "map-feuchte": (titel: "Bild lesen", body: [Die vier Äste ordnen das Kapitel vom Modell über die Rechenschritte bis zur Ergebnisprüfung. Die Verknüpfungen werden in den Abschnitten erläutert; eigene Darstellung.]),
  "map-maschinen": (titel: "Bild lesen", body: [Die vier Äste ordnen das Kapitel vom Modell über die Rechenschritte bis zur Ergebnisprüfung. Die Verknüpfungen werden in den Abschnitten erläutert; eigene Darstellung.]),
  "map-idealesgas": (titel: "Bild lesen", body: [Die vier Äste ordnen das Kapitel vom Modell über die Rechenschritte bis zur Ergebnisprüfung. Die Verknüpfungen werden in den Abschnitten erläutert; eigene Darstellung.]),
  "impuls-kontrollvolumen": (titel: "Bild lesen", body: [Zuerst Geschwindigkeiten und Druckkräfte einzeichnen, dann die Komponenten des austretenden minus eintretenden Impulsstroms bilden. Die berechnete Wandkraft auf das Fluid wechselt beim Übergang zur Fluidkraft auf den Krümmer ihr Vorzeichen.]),
  "moody-original": (titel: "Bild lesen", body: [Die waagerechte Achse zeigt die Reynolds-Zahl, die senkrechte die Darcy-Rohrreibzahl. Rauigkeitskurven unterscheiden das Übergangsgebiet vom hydraulisch rauen Bereich. Abgelesene Werte sind Näherungen; keine Fanning-Reibzahl einsetzen.]),
  "plank-unterkuehlung": (titel: "Bild lesen", body: [Drosseln bleibt im h-Bild senkrecht, der Verdichter hebt h an. Unterkühlung senkt die Eintrittsenthalpie des Verdampfers; Saugüberhitzung und nützliche Verdampferüberhitzung müssen durch die Systemgrenze getrennt werden.]),
  "rankine-zwischenueberhitzung": (titel: "Bild lesen", body: [Links steht der einfache Dampfumlauf, rechts kommen Zwischenüberhitzung und ein entnommener Heizdampfstrom hinzu. Hinter einer Entnahme durchströmt nur der verbleibende Massenstrom die nächste Turbinenstufe.]),
  "stirling-regeneration": (titel: "Bild lesen", body: [Die Isothermen übertragen Arbeit und äußere Wärme; die Isochoren verschieben Wärme zwischen Gas und Regenerator. Erst bei idealer Regeneration müssen die isochoren Wärmen nicht von außen bereitgestellt werden.]),
  "joule-ideal-real": (titel: "Bild lesen", body: [Der reale Verdichter endet rechts und wärmer als der ideale; die reale Turbine rechts und wärmer als ihr idealer Austritt. Deshalb wächst die Verdichteraufnahme und sinkt die Turbinenabgabe. Nettoarbeit ist stets ihre Differenz.]),
  "otto-diesel-seiliger": (titel: "Bild lesen", body: [Die drei Vergleichsprozesse unterscheiden sich durch die Wärmezufuhr bei konstantem Volumen, konstantem Druck oder beidem. Die Isentropen schließen Verdichtung und Expansion ab. Die Tabellenwerte sind historische Beispiele, keine heutigen Motorzusagen.]),
  "gas-isolinien": (titel: "Bild lesen", body: [Waagerecht steht das Volumen bzw. die Entropie. Im p-v-Bild fällt die Isentrope steiler als die Isotherme; im T-s-Bild steigt die Isochore steiler als die Isobare. Die Gleichsetzung von Isenthalpe und Isotherme gilt hier nur für das ideale Gas.]),
  "exergie-gasturbinevar": (titel: "Bild lesen", body: [Eigene Darstellung: T-s-Bild links, p-v-Bild rechts; die Reihenfolge der farbigen Pfeile gibt den reversiblen Weg über die Umgebungsisotherme an. Modellwerte nach der jeweiligen Aufgabe. Nur in Aufgaben.typ verwendet.]),
  "exergie-gasturbine": (titel: "Bild lesen", body: [Eigene Darstellung: T-s-Bild links, p-v-Bild rechts; die Reihenfolge der farbigen Pfeile gibt den reversiblen Weg über die Umgebungsisotherme an. Modellwerte nach der jeweiligen Aufgabe. Nur in Aufgaben.typ verwendet.]),
  "exergie-gasstromvar": (titel: "Bild lesen", body: [Eigene Darstellung: T-s-Bild links, p-v-Bild rechts; die Reihenfolge der farbigen Pfeile gibt den reversiblen Weg über die Umgebungsisotherme an. Modellwerte nach der jeweiligen Aufgabe. Nur in Aufgaben.typ verwendet.]),
  "exergie-gasstrom": (titel: "Bild lesen", body: [Eigene Darstellung: T-s-Bild links, p-v-Bild rechts; die Reihenfolge der farbigen Pfeile gibt den reversiblen Weg über die Umgebungsisotherme an. Modellwerte nach der jeweiligen Aufgabe. Nur in Aufgaben.typ verwendet.]),
  "exergie-co2var": (titel: "Bild lesen", body: [Eigene Darstellung: T-s-Bild links, p-v-Bild rechts; die Reihenfolge der farbigen Pfeile gibt den reversiblen Weg über die Umgebungsisotherme an. Modellwerte nach der jeweiligen Aufgabe. Nur in Aufgaben.typ verwendet.]),
  "exergie-co2": (titel: "Bild lesen", body: [Eigene Darstellung: T-s-Bild links, p-v-Bild rechts; die Reihenfolge der farbigen Pfeile gibt den reversiblen Weg über die Umgebungsisotherme an. Modellwerte nach der jeweiligen Aufgabe. Nur in Aufgaben.typ verwendet.]),
  "exergie-abgasvar": (titel: "Bild lesen", body: [Eigene Darstellung: T-s-Bild links, p-v-Bild rechts; die Reihenfolge der farbigen Pfeile gibt den reversiblen Weg über die Umgebungsisotherme an. Modellwerte nach der jeweiligen Aufgabe. Nur in Aufgaben.typ verwendet.]),
  "exergie-abgas": (titel: "Bild lesen", body: [Eigene Darstellung: T-s-Bild links, p-v-Bild rechts; die Reihenfolge der farbigen Pfeile gibt den reversiblen Weg über die Umgebungsisotherme an. Modellwerte nach der jeweiligen Aufgabe. Nur in Aufgaben.typ verwendet.]),
  "a415-pfade": (titel: "Bild lesen", body: [Quellenausschnitt mit Originalangabe bzw. Lösungsskizze. Fundstelle und Einordnung stehen in der zugehörigen Aufgabe; nur dort verwendet.]),
  "a414-pfade": (titel: "Bild lesen", body: [Quellenausschnitt mit Originalangabe bzw. Lösungsskizze. Fundstelle und Einordnung stehen in der zugehörigen Aufgabe; nur dort verwendet.]),
  "a414-original": (titel: "Bild lesen", body: [Quellenausschnitt mit Originalangabe bzw. Lösungsskizze. Fundstelle und Einordnung stehen in der zugehörigen Aufgabe; nur dort verwendet.]),
  "map-exergie": (titel: "Bild lesen", body: [Die vier Äste führen von der Umgebung über die Systemart zum reversiblen Vergleich und zur Entropieerzeugung. Erst nach Wahl von System und Referenz ist eine Exergiezahl eindeutig.]),
  "faulgas-angabe": (titel: "Bild lesen", body: [Die Originalangabe zeigt Volumen, Druck, Temperatur, Tiefe und die Umgebung. Diese Abbildung wird nur in Aufgaben.typ als Aufgabenquelle verwendet.]),
  "exergie-weg": (titel: "Bild lesen", body: [Zuerst führt die Isentrope von 1 nach a zur Umgebungstemperatur, dann die Umgebungsisotherme nach ∞. Der Vergleich über die Drossel nach b erzeugt Entropie und liefert weniger Arbeit. Enddruck und Endtemperatur allein bestimmen noch keinen konkreten Prozessweg.]),
  "kreisprozess-flaechen": (titel: "Bild lesen", body: [Die linke Hälfte zeigt die Wärmekraftmaschine, die rechte Kältemaschine und Wärmepumpe. Die Umlaufrichtung kehrt die Nettozeichen um. Druckarbeit ist im p-v-Bild eine geschlossene Fläche; Wärme im T-s-Bild nur unter den angegebenen Reversibilitätsbedingungen.]),
  "hs-ts-vergleich": (titel: "Bild lesen", body: [Links bedeuten rote und blaue Flächen Wärme; rechts sind dieselben Enthalpiedifferenzen senkrechte Strecken. Der reale Turbinenaustritt 6 liegt rechts und höher als 6is: kleinere Arbeitsabgabe bei gleichem Enddruck.]),
  "carnot-ts-rechteck": (titel: "Bild lesen", body: [Die Temperatur steht senkrecht, die spezifische Entropie waagerecht. Der Weg 1→2→3→4→1 läuft rechtsherum; oben wird Wärme zugeführt, unten abgeführt. Weil beide Isothermen dieselbe Entropiebreite haben, bleibt ihre Flächendifferenz als Nettoarbeit.]),
  "r134a-angabe": (titel: "Bild lesen", body: [Der blaue Kreis markiert den gesuchten R134a-Zustand; die farbigen Beispiel-Isolinien laufen nicht sämtlich durch diesen Punkt. Die Abbildung gehört ausschließlich zu Aufgaben.typ.]),
  "a420-angabe": (titel: "Bild lesen", body: [Die Originalaufgabe enthält Zustandsvorgaben, Zielpunkte und Isolinien für die selbstständige Diagrammauswertung. Die Abbildung gehört ausschließlich zu Aufgaben.typ.]),
  "map-diagramme": (titel: "Bild lesen", body: [Vom Zentrum führen vier Äste zu Flächen, Gibbs, realen Bauteilkreisläufen und dem Carnot-Vergleich. Zuerst die Achsen lesen, dann den Weg und seine Voraussetzungen einordnen.]),
  "carnot-vorlesung": (titel: "Bild lesen", body: [Im T-s-Diagramm liegen die beiden Isothermen waagerecht und die beiden Isentropen senkrecht. Die rechteckige Umlauffläche ist die abgegebene Nettoarbeit; Wärmezufuhr und Wärmeabfuhr haben dieselbe Entropiebreite.]),
  "plank-vorlesung": (titel: "Bild lesen", body: [Drossel, Verdampfer, Verdichter und Verflüssiger bilden einen linksläufigen Prozess. Im lg(p)-h-Bild ist die Drossel senkrecht, weil h konstant bleibt. Der reale Verdichter endet bei größerer Enthalpie als der isentrope Vergleich.]),
  "rankine-vorlesung": (titel: "Bild lesen", body: [Links stehen Pumpe, Dampferzeuger, Turbine und Kondensator. Im T-s-Bild läuft der Weg rechtsherum. Die reale Expansion endet rechts vom isentropen Vergleich und liefert weniger Arbeit.]),
  "ts-zustandsflaechen": (titel: "Bild lesen", body: [Unter einer Isochore liefert die Fläche Δu, unter einer Isobare Δh. Die rote Sättigungsstrecke zeigt h″−h′. Für Energieflächen ist die Temperatur ab dem absoluten Nullpunkt in Kelvin zu zählen.]),
  "ts-prozessflaechen": (titel: "Bild lesen", body: [Waagerecht steht s, senkrecht T. Die Flächen zeigen Wärme plus Dissipation. Kühlung kann die Erzeugung übertreffen; die Entropie des Fluids sinkt dann trotz Reibung.]),
  "kochtopf-phasen": (titel: "Bild lesen", body: [Links sinkt der Flüssigkeitsspiegel im starren Gefäß. Der frei werdende Raum wird zum Dampfraum; ein kleiner Teil des gebildeten Dampfes bleibt deshalb im Topf. Rechts stehen Druck nach oben und spezifisches Volumen nach rechts. Bei gleichem Druck und gleicher Sättigungstemperatur wandert der Gemischzustand nach rechts: Die Masse sinkt bei festem Gesamtvolumen. Die Phasengrenzen sind schematisch.]),
  "kochtopf-energie": (titel: "Bild lesen", body: [Die linke Säule zeigt die zugeführte Wärmeleistung und darüber den Beitrag aus der abnehmenden Speicherenergie. Zusammen ergeben sie die rechte Säule des ausströmenden Energiestroms. Grau ist keine zusätzliche äußere Zufuhr: Die gesamte innere Energie im Topf nimmt ab. Alle Höhen zeigen Leistungen; Werte aus Ü 3.6, ungerundet nachgerechnet.]),
  "turbine-hs-vergleich": (titel: "Bild lesen", body: [Waagerecht steht die spezifische Entropie, senkrecht die Enthalpie. Von ① führt der isentrope Vergleich senkrecht zum niedrigsten verglichenen Enthalpiewert am Enddruck. Der reale Austritt liegt rechts und höher. Bei Blockade bleibt die Enthalpie gleich, die Entropie steigt stärker. Die graue Isobare verbindet Tabellenstützstellen bei 10 bar; die gestrichelten Verbindungen zeigen nur den Vergleich der Endzustände.]),
  "tripel-isochor": (titel: "Bild lesen", body: [Links stehen Druck und spezifisches Volumen, rechts Druck und Temperatur. Die Zustände ① und ② überlagern sich: Das Eis schmilzt bei gleichem Druck, gleicher Temperatur und gleichem Gesamtvolumen. Erst nach dem Verschwinden des Eises führt der Weg nach ③ zu höherem Druck und höherer Temperatur. Grau zeigt nur schematische Phasengrenzen.]),
  "dampftrommel-anteile": (titel: "Bild lesen", body: [Die beiden Kästen zeigen je 4 m³, aber unterschiedliche Stoffzustände. Weil das spezifische Flüssigkeitsvolumen viel kleiner ist als das Dampfvolumen je Kilogramm, steckt links deutlich mehr Masse. Die Gleichheit der geometrischen Volumina überträgt sich nicht auf die Massenanteile.]),
  "ueberhitzer-wege": (titel: "Bild lesen", body: [Waagerecht steht das spezifische Volumen, senkrecht der Druck. Grün und Orange markieren die zwei verschiedenen festen spezifischen Volumina. Beide Füllungen starten im Nassdampfgebiet und treffen beim Erwärmen die rechte Sattdampfgrenze an verschiedenen Stellen. Die schematische Glocke liefert keine abzulesenden Zahlen.]),
  "waermekapazitaet-mittel": (titel: "Bild lesen", body: [Waagerecht steht die Temperatur, senkrecht die wahre spezifische Wärmekapazität. Grün zeigt schematisch ihren Verlauf. Das gestrichelte Rechteck veranschaulicht einen Bereichsmittelwert: Seine Fläche steht für dieselbe Energieänderung wie die Fläche unter der Kurve. Die Skizze ist keine maßstäbliche Lufttabelle.]),
  "waermekapazitaet-kolben": (titel: "Bild lesen", body: [Links kann das Volumen nicht wachsen; die Wärmezufuhr erhöht im Idealmodell nur die innere Energie. Rechts gibt die Expansion Arbeit ab, während die gleiche Temperaturerhöhung erreicht wird. Die zusätzlich nötige Wärme erklärt $c_p>c_v$ für das ideale Gas.]),
  "kreisprozess-energie": (titel: "Bild lesen", body: [Das Arbeitsmittel durchläuft Pumpe, Kessel, Turbine und Kondensator und kehrt in den Anfangszustand zurück. Pumpe und Turbine übertragen Arbeit in entgegengesetzten Richtungen; Kessel und Kondensator übertragen Wärme. Die Arbeit ist als Nutzabgabe erst nach Abzug der Pumpenaufnahme bestimmt.]),
  "stroemung-duese-drossel": (titel: "Bild lesen", body: [Links führt der Enthalpieabfall bei gleicher Höhe zu höherer Strömungsgeschwindigkeit. Rechts wird die Geschwindigkeit vor und hinter der Drossel als etwa gleich angenommen; dann bleibt die Enthalpie trotz Druckabfall gleich. Die Drossel darf deshalb nicht mit einem reversiblen Vergleichsprozess gleichgesetzt werden.]),
  "lufterhitzer-grenzen": (titel: "Bild lesen", body: [Die braune gestrichelte Linie ist die äußere adiabate Gesamtgrenze. Der rote Wärmestrom zwischen Wasser und Luft überschreitet sie nicht, wohl aber die zugeführte Lüfterleistung. Für die beiden inneren Stoffgrenzen ist derselbe Wärmestrom Abgabe beziehungsweise Zufuhr.]),
  "joule-prozess": (titel: "Bild lesen", body: [Die Kette verbindet die Abnahme der Lageenergie des Gewichts mit Arbeitsübertragung und einer Zunahme der inneren Energie im Fluid. Energie wird erhalten. Dass das Fluid später abkühlen kann, stellt jedoch nicht den gemeinsamen Ausgangszustand von Fluid, Gewicht und Umgebung wieder her.]),
  "entropie-bilanz": (titel: "Bild lesen", body: [Links erreichen Entropiebeiträge aus Wärme und Stofftransport das System; rechts kann Entropie abgeführt werden. Im Inneren ist zusätzlich eine nichtnegative Erzeugung möglich. Eine Änderung des Speichers ist deshalb nicht einfach die Erzeugung; Transport muss mitgezählt werden.]),
  "zustandsdiagramme-achsen": (titel: "Bild lesen", body: [In jedem Feld stehen die Achsen ausdrücklich dabei. Eine konstante waagerechte Koordinate ergibt eine senkrechte Linie; eine konstante senkrechte Koordinate eine waagerechte. Grün und Blau zeigen ausgewählte sichere Beispiele, keine vollständigen Stoffdiagramme.]),
  "map-tripel": (titel: "Bild lesen", body: [Die vier Äste verknüpfen Phasen, Gleichgewicht, additive Gesamtgrößen und die starre Energiebilanz. Während drei Phasen vorhanden sind, kann Energiezufuhr die Zusammensetzung ändern, ohne Druck und Temperatur zu ändern.]),
  "map-entropie": (titel: "Bild lesen", body: [Die vier Äste trennen eine Zustandsgröße von ihren Transporten und von der Erzeugung. Der isentrope reversible adiabate Grenzfall hat keinen Wärme-Entropietransport und keine innere Erzeugung.]),
  "map-waermekapazitaet": (titel: "Bild lesen", body: [Die ersten beiden Äste erklären den physikalischen Unterschied zwischen isochorer und isobarer Wärmekapazität. Die anderen erinnern an den Mengenbezug und an den Temperaturbereich. Eine Zahl ohne diese Angaben reicht für eine Energieberechnung nicht aus.]),

  "druckluftmotor-vergleich": (titel: "Bild lesen", body: [Druck und Volumen sind auf die Anfangswerte bezogen; beide Wege beginnen bei ①. Grün fällt die reversible Adiabate steiler als die blaue Isotherme. Am selben orange markierten Enddruck endet sie bei kleinerem Volumen. Die graue Fülllinie oben und die orange Ausschiebelinie unten gehören zum idealisierten Gaswechsel. Gezeichnet sind die beiden Modellkurven mit dem Druckverhältnis des Vorlesungsbeispiels.]),
  "kraftwerk-enthalpie": (titel: "Bild lesen", body: [Von links nach rechts bleibt der Massenstrom gleich. Im Kessel steigt die Enthalpie durch Wärmezufuhr von 128 auf 3150 kJ/kg. In der adiabaten Turbine sinkt sie auf 2350 kJ/kg; diese Differenz wird im Modell als Wellenarbeit abgegeben. Das Schema zeigt eine offene Anlage, keinen geschlossenen Dampfkreislauf.]),
  "turbine-energie": (titel: "Bild lesen", body: [Links steht die mit dem Höhenunterschied verfügbare Leistung. Sie teilt sich rechts in abgegebene Wellenleistung und Zunahme der inneren Energie des Wassers. Die zweite Größe bleibt im austretenden Wasser; über die adiabate äußere Grenze fließt keine Wärme.]),
  "arbeit-zwei-wege": (titel: "Bild lesen", body: [Waagerecht steht das auf den Anfangswert bezogene Volumen, senkrecht der entsprechend bezogene Druck. Die Verdichtung läuft von rechts unten nach links oben. Grün folgt einer Isotherme; Orange erst einer Isobare, dann einer Isochore. Die Fläche unter dem jeweiligen Weg ist der Betrag der Volumenarbeit; das senkrechte Teilstück trägt keine bei.]),
  "arbeit-nutzanteil": (titel: "Bild lesen", body: [Waagerecht steht das Volumen, senkrecht der absolute Druck. Das Gas expandiert hier schematisch bei konstantem Druck. Der graue Flächenanteil unter dem Umgebungsdruck wird zum Verdrängen der Umgebung gebraucht. Nur die grüne Fläche darüber kann zusätzlich nach außen genutzt werden. Die Arbeitsbeträge sind positiv gezeichnet; als Zufuhrgrößen sind die abgegebenen Arbeiten negativ.]),
  "arbeit-verschiebung": (titel: "Bild lesen", body: [Der mittlere Kasten erfasst Ein- und Ausströmverschiebung mit ihren Vorzeichen. Zusammen mit der Volumenarbeit ergibt sich die Druckarbeit desselben Zustandswegs. Die Kästen sind Energiebeträge derselben Bezugsmasse, keine drei unabhängigen Wärme- oder Arbeitszufuhren.]),
  "map-arbeit": (titel: "Bild lesen", body: [Die vier Äste trennen die zur Systembeschreibung passenden Arbeitsanteile. Der Prozessweg legt das Integral fest. Die Umgebung nimmt bei einer Expansion einen Teil der abgegebenen Volumenarbeit in Anspruch; Verschiebearbeit verbindet die offene und die geschlossene Beschreibung.]),
  "map-waerme-enthalpie": (titel: "Bild lesen", body: [Die beiden oberen Äste trennen Übertragung und Speicherung. Links unten ergänzt die Enthalpie den Druck-Volumen-Anteil. Rechts unten entscheidet das Stoffmodell, wie Energieunterschiede berechnet werden. Eine Wärmemenge wird nicht als eigener Wärmebestand gespeichert.]),
  "druckluftmotor-pv": (titel: "Bild lesen", body: [Beide Diagramme haben Druck nach oben und Volumen nach rechts. Links fällt die reversible Adiabate steiler ab; rechts verläuft die rote Isotherme bis zum gleichen Enddruck und einem größeren Endvolumen. Die Rechtecke der Füllung bei $p_1$ und der Ausschiebung bei $p_2$ ergänzen die Expansionsarbeit zur Arbeit des Gaswechselzyklus. Die schraffierten Flächen veranschaulichen die Druckarbeit.]),

  "map-fet": (titel: "Die Mindmap lesen", body: [Die vier Äste bilden einen Rechenweg: Zuerst die Grenze festlegen, dann Ströme und Speicher bilanzieren, den Stoffzustand beschreiben und schließlich das Ergebnis prüfen. Dieselbe Kette verbindet Thermodynamik und die schon verwendeten Strömungsansätze.]),
  "map-tabellenmodell": (titel: "Die Mindmap lesen", body: [Vier Entscheidungen führen vom Zustand zur Rechnung. Erst die Phase erkennen, dann zwischen spezifischer Größe, Gesamtmenge und Strom unterscheiden. Der Tabellenwert verbindet anschließend das Stoffmodell mit der Bilanz; Einheiten und Bezugszustand müssen dazu passen.]),
  "interpolation-invers": (titel: "Die Achsenrolle wechseln", body: [Waagerecht steht das bekannte spezifische Volumen, senkrecht die gesuchte Temperatur bei festem Druck. Grün verbindet die zwei Tabellenpunkte geradlinig. Die orange Hilfslinie bei 0,02300 m³/kg trifft diese Gerade bei rund 106,11 °C. Die Gerade ist eine Näherung zwischen den Punkten.]),
  "stickstoff-zustaende": (titel: "Zwei verschiedene Wege", body: [Die Gefäßgröße bleibt in allen drei Bildern gleich; grün zeigt Flüssigkeit, hellblau den Dampfraum. Von ① nach ② wird geheizt, ohne Masse abzugeben. Von ② nach ③ verlassen 1 kg Flüssigkeit den Behälter; etwas Flüssigkeit verdampft und vergrößert den Dampfraum. Die Füllhöhen sind schematisch.]),
  "stickstoff-pv": (titel: "Großes V und kleines v auseinanderhalten", body: [Die senkrechte Achse zeigt Druck, die waagerechte das spezifische Volumen. Beim geschlossenen Vorheizen führt ①–② senkrecht nach oben. Während der isobaren Entnahme führt ②–③ nach rechts: Die Masse sinkt bei gleichem Gesamtvolumen. Die graue Dampfglocke dient nur der Orientierung.]),
  "verdampfer-stroeme": (titel: "Den Stoffstrom mitlesen", body: [Links tritt Flüssigkeit ein, rechts Nassdampf aus. Der Massenstrom ist gleich, während die Geschwindigkeit wegen des stark wachsenden spezifischen Volumens zunimmt. Der rote Pfeil führt Wärme zu. Aus x und der Sättigungstafel bestimmst du h, u und s; die Multiplikation mit dem Massenstrom liefert die Stromgrößen.]),
  "map-mix": (titel: "Die Mindmap lesen", body: [Die vier Äste verbinden die Gesamtmengen mit den Anteilen und den daraus berechneten Gemischgrößen. Entscheidend ist die Bezugsgröße: $xi$ gewichtet Massen, $psi$ Stoffmengen. Deshalb braucht die Umrechnung die Molmassen der Komponenten.]),
  "map-firstlaw": (titel: "Die Mindmap lesen", body: [Links oben steht die Energieerhaltung, rechts oben der offene und links unten der geschlossene Fall. Rechts unten erinnert das Vorzeichen an die Zufuhrkonvention. Druck- beziehungsweise Volumenarbeit sind dabei Beiträge zur gesamten Arbeit; weitere Beiträge und äußere Energieänderungen prüfst du vor dem Streichen.]),
  "mixing": (titel: "Vorher getrennt, nachher gemischt", body: [Oben liegen die Gase A und B getrennt nebeneinander, beide bei gleichem $p$ und $T$. Jedes nimmt sein Partialvolumen ein. Nach dem Entfernen der Membran füllt das Gemisch g das ganze Volumen $V_g=V_A+V_B$; Massen und Stoffmengen addieren sich.]),
  "hs-overview": (titel: "Örtlich oder zeitlich vorher", body: [Links strömt Stoff von ① nach ②: Die Zustände liegen an verschiedenen *Orten*. Rechts bleibt dieselbe Masse im Zylinder: ① und ② sind verschiedene *Zeitpunkte*. Die farbigen Pfeile über die gestrichelte Grenze sind die Prozessgrößen.]),
  "hs-open": (titel: "Was über die Grenze geht", body: [Grün und blau treten Enthalpiestrom und Massenstrom bei ① ein und bei ② aus, mit Höhen $z_1$ und $z_2$. Der schwarze Pfeil (Rad) ist die technische Arbeit $P$, der rote die Wärme $dot(Q)_12$. Die kleinen Kolben an Ein- und Austritt zeigen die Verschiebearbeit $p v$.]),
  "hs-closed": (titel: "Vom Zustand ① zum Zustand ②", body: [Von unten nach oben wird der Kolben verschoben: Bei jedem kleinen Schritt ändern sich $v$ um $dif v$ und die Lage um $dif z$, während $dif q$ und $dif w_g$ zugeführt werden. Die Summe aller Schritte ergibt den integrierten 1. HS.]),
  "hs-special": (titel: "Vier Grenzen, vier Fälle", body: [Oben Wirbel im Gas: Ein Teil der Arbeit wird dissipiert. Darunter reibfrei, nur Volumenarbeit und Wärme. Die schraffierte Wand bedeutet adiabat: nur noch $W_(v 12)$. Unten ganz umschlossen: abgeschlossenes System ohne jeden Austausch.]),
  "ball": (titel: "Drei Momentaufnahmen", body: [① Die Kugel hat Lage- und Bewegungsenergie. ② Im idealisierten Modell ruht sie am Boden: Die äußere Energie ist vollständig in ihre innere Energie übergegangen. ②\* ergänzt die reale Verformung. Sie ist ein innerer Vorgang und bedeutet nicht automatisch einen Energieverlust der Kugel; zusätzlich kann Energie an Boden und Umgebung übertragen werden.]),
  "boundary": (titel: "Die Grenze mitlesen", body: [Die gestrichelte Linie markiert den betrachteten Ausschnitt. Ein Energiepfeil gehört zur äußeren Bilanz, wenn er diese Linie kreuzt. Umschließt du beide Teilsysteme gemeinsam, liegt ihre gegenseitige Übertragung innerhalb der neuen Grenze. Was System 1 abgibt, nimmt System 2 auf; in der Gesamtbilanz heben sich diese Beiträge auf.]),
  "bath": (titel: "Von den Pfeilen zum Füllstand", body: [Die Pfeile stehen für Ströme, der Wanneninhalt für den gespeicherten Bestand. Gleiche Zu- und Abflüsse halten den Inhalt konstant, auch wenn ständig anderes Wasser hindurchfließt. Bei einem positiven Nettozufluss wächst der Inhalt. Der Überlauf wird erst relevant, sobald der Wasserstand seine Höhe erreicht.]),
  "transfers": (titel: "Drei Wege derselben Energie", body: [Links verschiebt ein Kolben die Grenze und überträgt dabei Arbeit. In der Mitte erreicht Energie das System wegen eines Temperaturunterschieds als Wärme. Rechts überschreitet die Masse selbst die Grenze und bringt Energie mit. Die Unterscheidung beschreibt den Grenzübertritt; sie bezeichnet keine verschiedenen gespeicherten „Energiearten“ im Wasser oder Gas.]),
  "expansion": (titel: "Was der gelbe Anteil bedeutet", body: [Die untere Länge ist die Ausgangslänge, die obere die erwärmte Länge. Gelb ist nur der Zuwachs $Delta L$, nicht die gesamte Endlänge. Bei gleichem Material und gleicher Temperaturänderung wächst ein doppelt so langer Stab ungefähr doppelt so stark. Deshalb steht $L_0$ als Faktor in der Formel.]),
  "heating-temperature": (titel: "Die Temperaturkurve lesen", body: [Waagerecht steht die Uhrzeit, senkrecht die Temperatur. Bis 01:36 Uhr bleibt das Bad bei 6 °C. Danach steigt die Temperatur mit konstanten 10 K/h. Ab 08:00 Uhr wird die Kurve zunehmend flacher; um 12:00 Uhr erreicht sie 90 °C mit Steigung null. „Knickfrei“ bedeutet am Übergang gleiche Temperatur und gleiche Steigung, nicht dieselbe Kurvenform.]),
  "heating-power": (titel: "Warum die Leistung sinkt", body: [Die senkrechte Achse zeigt Leistung je Kilogramm Wasser, nicht die gesamte Heizleistung. Eine konstante Temperatursteigung verlangt im Modell konstante Leistung. Im Parabelabschnitt sinkt die Steigung linear, also auch die Leistung. Die Fläche unter dieser Kurve entspricht der spezifischen Energiezufuhr; mit Stunden auf der Zeitachse ergibt sie zunächst Wh/kg.]),
  "division": (titel: "Der Teilungstest", body: [Denke dir den homogenen Inhalt in zwei gleiche Portionen geteilt. Jede Portion enthält die halbe Masse, das halbe Volumen und die halbe innere Energie. Temperatur und Dichte ändern sich durch diese gedankliche Aufteilung nicht. Auch $v=V/m$ bleibt gleich, weil Zähler und Nenner im selben Verhältnis kleiner werden.]),
  "continuity": (titel: "Was die Stromröhre zeigt", body: [Die Mantelfläche folgt den Stromlinien: Dort weist die Strömung entlang der Fläche und nicht durch sie hindurch. Im stationären Modell bleibt deshalb zwischen den beiden Querschnitten kein Netto-Massenstrom seitlich übrig. Durch jeden Querschnitt muss dieselbe Masse pro Sekunde treten, obwohl Fläche und Geschwindigkeit verschieden sein dürfen.]),
  "drain-plot": (titel: "Warum die Entleerung langsamer wird", body: [Waagerecht steht die Zeit, senkrecht die Füllhöhe. Anfangs ist die Kurve steil: Die große Druckhöhe treibt einen starken Ausfluss an. Beim Sinken des Spiegels nimmt die Ausflussgeschwindigkeit ab, und die Kurve flacht ab. Daher braucht die erste Volumenhälfte nur 15,77 Minuten; die zweite benötigt deutlich länger. Der Verlauf endet beim leeren Behälter.]),
  "states": (titel: "Momentaufnahme und Weg auseinanderhalten", body: [Links und rechts siehst du unterschiedliche Gaszustände. Aus den Bildern kannst du etwa die Änderung des Volumens erkennen. Du erfährst daraus aber noch nicht, wie viel Wärme und Arbeit während des Übergangs übertragen wurden. Dafür brauchst du den Prozessweg und die zugehörigen Randbedingungen.]),
  "pv-isolines": (titel: "Die Linien im p-v-Diagramm", body: [Waagerecht steht das spezifische Volumen, senkrecht der Druck. Die blaue Waagerechte hält $p$ fest; die orange Senkrechte hält $v$ fest. Auf der grünen Isotherme bleibt beim idealen Gas das Produkt $p v$ konstant: Größeres Volumen verlangt kleineren Druck. Ein Schnittpunkt bedeutet denselben Zustand; daraus folgt noch kein gemeinsamer Prozessweg.]),
  "kelvin": (titel: "Die Gerade richtig deuten", body: [Die Gerade verschiebt den Nullpunkt um 273,15, ohne die Schrittweite zu ändern. Darum sind Temperaturdifferenzen in Kelvin und Grad Celsius zahlenmäßig gleich. Verhältnisse ändern sich dagegen durch den verschobenen Nullpunkt: Von 20 auf 60 °C steigt die absolute Temperatur von 293,15 auf 333,15 K, also nur um etwa 14 Prozent.]),
  "path-work": (titel: "Gleiche Endpunkte, verschiedene Arbeitsbeträge", body: [Beide Wege führen von 2 bar und 1 m³ zu 1 bar und 2 m³. Links expandiert das Gas isotherm; rechts sinkt zuerst bei festem Volumen der Druck, danach expandiert es bei 1 bar. Links erfolgt die Expansion im Mittel gegen höheren Druck, daher ist die Fläche größer: etwa 138,6 statt 100 kJ. In der Zufuhrkonvention sind beide Arbeiten negativ.]),
  "reversibility": (titel: "Was die durchgestrichene Skizze aussagt", body: [Links kann Energie als Wärme zu- oder abgeführt werden. Rechts führt Rühren durch Dissipation zu einer Erwärmung. Die rote Durchstreichung zeigt die entscheidende Grenze: Durch bloßes Rückwärtsrühren entsteht keine Abkühlung, die dieselbe Energie vollständig als Arbeit zurückliefert. Energie bleibt erhalten, aber der Vorgang lässt sich nicht spurlos umkehren.]),
  "warming": (titel: "Warum die Kurve manchmal waagerecht bleibt", body: [Waagerecht steht bereits zugeführte Energie, senkrecht die Temperatur. Auf den ansteigenden Abschnitten wird eine einzelne Phase wärmer. Auf den Plateaus fließt weiterhin Energie zu; sie verändert bei konstantem Druck den Phasenanteil. Deshalb bedeutet eine waagerechte Kurve hier keine ausgeschaltete Heizung. Das lange Siedeplateau zeigt den großen Energiebedarf der Verdampfung.]),
  "energy-parts": (titel: "Die Balken sind einzelne Beiträge", body: [Jeder Balken zeigt die Energie eines eigenen Schritts für 1 kg Stoff. Es sind keine aufeinander aufaddierten Gesamtwerte. Die Summe aller fünf Balken beträgt etwa 3,24 MJ. Der Verdampfungsbalken ist besonders hoch: Das vollständig erwärmte flüssige Wasser ist energetisch noch weit vom vollständig verdampften Zustand entfernt.]),
  "oxygen": (titel: "Was die beiden Säulen vergleichen", body: [Beide Rechnungen starten bei 233 bar Absolutdruck und 300 K und kühlen auf 254,85 K ab. Im idealen Modell bestimmt das Temperaturverhältnis allein den Enddruck. Real ändert sich zusätzlich $Z$; das senkt hier den berechneten Enddruck auf 177,55 bar. Die Säulen vergleichen Modellvorhersagen, keine zwei direkt gemessenen Ergebnisse.]),
  "pvt": (titel: "Eine dreidimensionale Landkarte", body: [Jeder Punkt auf der Fläche steht für eine zulässige Kombination von $p,v,T$. Die kleineren Diagramme zeigen Projektionen auf jeweils zwei Achsen. Beim einphasigen idealen Gas bestimmen zwei unabhängige Angaben die dritte. Im Zweiphasengebiet gehören zu derselben Sättigung dagegen derselbe Druck und dieselbe Temperatur, während sich das spezifische Volumen mit dem Phasenanteil ändern kann.]),
  "phase-dome": (titel: "Die Dampfglocke lesen", body: [Die waagerechte Achse ist das spezifische Volumen, keine Zeitachse. Die grüne Begrenzung trennt die einphasigen Bereiche vom Gemisch. Entlang der blauen Isobare liegt Punkt 2 am Flüssigkeitsrand, Punkt 3 im Gemisch und Punkt 4 am Dampfrand. Zwischen 2 und 4 wachsen Dampfanteil und spezifisches Volumen, während Druck und Sättigungstemperatur gleich bleiben.]),
  "five-states": (titel: "Warum die Kolben nach oben wandern", body: [Die Skizzen vergleichen dieselbe Stoffmasse bei gleichem Druck. Beim Verdampfen wächst ihr Volumen stark, deshalb hebt der Stoff den Kolben. Zwischen den Zuständen 2 und 4 stammt die größere Ausdehnung aus dem wachsenden Dampfanteil, obwohl die Temperatur konstant bleibt. Erst nach vollständiger Verdampfung erhöht weiteres Heizen die Dampftemperatur.]),
  "supercritical": (titel: "Den Stoffstrom verfolgen", body: [Links erhöht die Pumpe den Druck der Flüssigkeit. Die beheizte Rohrschlange führt anschließend Energie zu; im beschriebenen Heizabschnitt liegt der Druck oberhalb des kritischen Drucks. Der Stoff passiert dabei keine gewöhnliche Flüssig-Dampf-Grenze. In der Turbine gibt er anschließend Wellenarbeit ab, die der Generator in elektrische Energie umwandelt.]),
  "isochoric": (titel: "Warum auch die Flüssigkeitsseite erreichbar ist", body: [Die beiden grünen Senkrechten halten unterschiedliche spezifische Volumina fest. Von 1b führt das Erwärmen rechts der kritischen Isochore zur Dampfseite. Von 1a links davon gelangt der Stoff zur Flüssigkeitsseite: Bei der höheren Sättigungstemperatur beansprucht die Flüssigkeit mehr Raum pro Kilogramm. Daher muss Wärmezufuhr hier nicht einfach den Dampfanteil vergrößern.]),
  "mass-volume": (titel: "Gleiche Balkenlänge, andere Bezugsgröße", body: [Beide Balken stellen jeweils 100 Prozent dar: oben die Gesamtmasse, unten das Gesamtvolumen. Grün bezeichnet in beiden Fällen Dampf. Sein winziger Massenanteil kann einen großen Volumenanteil besitzen, weil Dampf pro Kilogramm viel mehr Platz braucht. Deshalb darfst du aus „halb mit Dampf gefüllt“ nicht auf „halbe Masse als Dampf“ schließen.]),
  "lever": (titel: "Aus dem Abstand wird ein Anteil", body: [Vergleiche auf der horizontalen Zweiphasenlinie die Strecke vom Flüssigkeitsrand $v'$ zum Gemischwert $v$ mit der ganzen Strecke von $v'$ bis $v''$. Ihr Verhältnis ist $x$. In der Mitte beträgt der Dampfgehalt 0,5, unabhängig davon, wie ungleich die Teilvolumina sind. Für Zahlenrechnungen verwendest du die Stoffwerte; die Skizze ist nicht maßstäblich.]),
  "heatpipe": (titel: "Zwei Ströme halten den Kreislauf aufrecht", body: [Der Dampf transportiert Energie vom warmen zum kalten Ende. Dort kondensiert er und gibt Energie ab. Flüssigkeit kehrt in der Kapillarstruktur zurück. Durch die äußere Grenze fließt dabei keine Arbeitsfluidmasse, obwohl innen ständig Masse zirkuliert. Das veranschaulicht, warum „geschlossen“ und „ohne inneren Stofftransport“ verschiedene Aussagen sind.]),
  "triple": (titel: "Drei Phasen bei einer gemeinsamen Temperatur", body: [Die Farben unterscheiden Eis, flüssiges Wasser und Dampf; sie zeigen keine verschiedenen Temperaturen. Am Tripelpunkt besitzen alle drei Phasen im Gleichgewicht dieselbe Temperatur und denselben Druck. Bei gleicher Gesamtmasse führen andere Phasenanteile zu einem anderen Gesamtvolumen; die beiden Tripelpunktwerte bleiben dabei gleich.]),
  "anomaly": (titel: "Phasengrenzen statt Prozesskurven", body: [Waagerecht steht die Temperatur, senkrecht der Druck. Jede Linie zeigt Bedingungen, bei denen zwei Phasen koexistieren. Die Verdampfungsgrenze steigt nach rechts: Höhere Siedetemperatur gehört zu höherem Druck. Die Schmelzgrenze gewöhnlichen Eises fällt im gezeigten Bereich. Am Tripelpunkt treffen drei Grenzen zusammen; die Flüssig-Dampf-Grenze endet dagegen am kritischen Punkt.]),
)

#let bild(name, caption, height: 55mm) = block(width: 100%, breakable: false, above: 0.6em, below: 0.6em)[
 #align(center)[#image(abbildungen.at(name), format: "svg", width: 100%, height: height, fit: "contain")]
 #v(1.2mm)
 #align(center)[#text(size: 8.4pt, fill: muted, caption)]
 #let deutung = bilddeutungen.at(name, default: none)
 #if deutung != none [
  #v(2mm)
  #text(weight: "bold", fill: teal)[#deutung.titel.] #deutung.body
 ]
]

#align(center)[
#v(8mm)
#text(size: 11pt, tracking: 1pt, fill: teal)[VERSTEHEN · ERKLÄREN · ANWENDEN]
#v(6mm)
#text(size: 29pt, weight: "bold", fill: navy)[Fluid- und\ Energietechnik]
#v(4mm)
#text(size: 20pt, fill: navy)[Feynman-Lernskript]
#v(3mm)
#text(size: 12pt)[Zusammenhänge sehen. Grundlagen verstehen. Selbst erklären.]
#v(5mm)
#bild("cover", [Schematische Illustration der Bauteile und Energieübertragungen im Modul. Eigens erzeugt; nicht maßstäblich.], height: 68mm)
#v(4mm)
#text(size: 12pt, fill: teal)[Systemgrenze → Bilanz → Stoffmodell → Anwendung]
]

#note("Dein Feynman-Schritt", [Sieh dir die Abbildung an. Erkläre dann ohne Vorlage: *Was passiert? Warum? Wann gilt die Formel?* Erst anschließend vergleichst du deine Erklärung mit dem Text und den Formeln.])

Stand: *13.11.2026*. Ausbau des vollständigen Moduls nach der Sammlung „Unterlagen zur Vorlesung“ und den vollständigen Übungs-/Prüfungsquellen. Die Vorlesungsmarkierungen beschränken auf deinen ausdrücklichen Auftrag den Inhalt nicht mehr. Noch fehlende konkrete Tafelanschriebe werden später anhand deiner ausgefüllten Seiten ergänzt; der vollständige Aufgabenabgleich ist im Bearbeitungsprotokoll nachvollziehbar.

#pagebreak()
#heading(level: 1, outlined: false)[Wegweiser]
#block[
#set text(size: 9.5pt)
#set par(leading: 0.3em, spacing: 0.15em)
#outline(title: none, depth: 2, indent: auto)
]
#v(2mm)
#text(size: 8.5pt, fill: muted)[*Quellenkürzel:* V05 = „05 Ideales Gas.pdf“ (20 S.); V06 = „06 Thermische Maschinen.pdf“ (28 S.); M71 = „05_Ideales_Gas_ZAE_Tab_M7-1-.pdf“; MT = „thermodynamik_memory.pdf“ (45 S., eigene PDF-Zählung beachten); S1 = „Str 01 Kap1 Hydrostatik.pdf“ (20 S.); S23 = „Str 02 Kap2 und 3 Bernoulli Rohrstr.pdf“ (28 S.); S56 = „Str 05-6 Kap5-6 Impuls-Drall.pdf“ (7 S.); alle aus der vollständigen Sammlung „Unterlagen zur Vorlesung“. Ü = vollständige 65-seitige Aufgabensammlung mit 125 Originalaufgaben. T12 = „Tutorium 12.11.2026.pdf“ (6 PDF-Seiten); V04 = vollständiger Foliensatz „04 2-HS Diagramme.pdf“ (Import 12.11., 40 PDF-Seiten, Foliennummer = PDF-Seite); M4.n = jeweilige historische Musterlösung zu Ü 4.n aus dem Import 12.11.; N10 = „Skript FET VL 10.11.pdf“ (13 PDF-Seiten); N11 = „Skript FET VL11.11.pdf“ (2 PDF-Seiten); I12 = Import vom 12.11.2026 (Zuordnung in Unterlagen/Bestandsaufnahme/Import_2026-11-12.json); L = Lernskript 18.10.2026; N = Vorlesungsseiten 21.10.2026 mit deinen Notizen; N27 = „03 1. Hauptsatz.pdf“, Vorlesungsunterlagen 27.10.2026 mit Notizen; N28 = „Skript FET.pdf“, VL 28.10.; N03 = VL 3.11.; N04 = VL 4.11.; T29 = Tutorium 29.10.; R30 = Übungsrechnungen 30.10.; M13 = Musterlösung Ü 2.13 (5 Seiten); M32 = Musterlösung Ü 3.2 (1 Seite); M211 = Musterlösung Ü 2.11 (1 Seite); M36 = Musterlösung Ü 3.6 (3 Seiten); V = Vorlesungsskript; Ü = Übungsaufgaben; T = Tutorium 15.10.2026; W = WZF 16.10.2026; R = handschriftliche Übungsrechnungen; T22 = Tutorium 22.10.2026; W23 = WZF 23.10.2026; M1 = Musterlösung Ü 1.14 (3 Seiten); M2 = Musterlösung Ü 2.1 (8 Seiten); B = FET Big Picture, Dennis Lehner, V06; K = ältere Altklausurübersicht „Kurzfragen“, Stand 26.11.2010; BT = Thermodynamik für Ingenieure; BS = Technische Strömungslehre. „PDF-S.“ zählt ab der ersten PDF-Seite; bei N ist „S.“ ebenfalls die PDF-Seite. Bestehende Nachschlagestellen bis 20.10. nennen Seiten von L; neue verlinkte Verweise berechnen Abschnitt und Seite im aktuellen Lernskript automatisch.]

#pagebreak()
#heading(level: 1, outlined: false, bookmarked: false)[Das Modul auf einen Blick] <ueberblick>

Jeder Kasten führt zu seinem Kapitel. Die Pfeiltexte zeigen, wie die Kapitel zusammenhängen.

#karte((1fr, auto, 1fr),
  chunk([Kapitel 1 · Grundbegriffe], [Systemgrenze · Zustand · Masse · Ströme], ziel: <a-1>),
  pfeil(beschriftung: [benennt Größen für]),
  chunk([Kapitel 2 · Stoffeigenschaften], [Phasen · Stoffmodelle · Dampftafeln], ziel: <a-2>),
  chunk([Kapitel 3 · Erster Hauptsatz], [Energiebilanz · Arbeitsformen · Kreisprozess], ziel: <a-3>),
  pfeil(beschriftung: [wird geprüft durch]),
  chunk([Kapitel 4 · Zweiter Hauptsatz], [Richtung · Entropie · Diagramme · Exergie], ziel: <a-4>),
  chunk([Kapitel 5 · Ideales Gas], [Stoffmodell · Polytropen · Bilanzen], ziel: <a-5>), pfeil(), chunk([Kapitel 6 · Maschinen], [Motor · Gasturbine · Dampf · Kälte], ziel: <a-6>),
  chunk([Kapitel 7 · Feuchte Luft], [Feuchte · Luftbehandlung], ziel: <a-7>), pfeil(), chunk([Kapitel 8 · Verbrennung], [Reaktion · Luftbedarf · Abgas], ziel: <a-8>),
  chunk([Kapitel 9 · Strömungsmechanik], [Hydrostatik · Rohrnetz · Kräfte], ziel: <a-9>), pfeil(), chunk([Gemeinsame Prüfung], [Masse · Energie · Entropie · Impuls], ziel: <a-9-8>),
)

Die Systemgrenze legt fest, was Du betrachtest und was darüber übertragen wird. Kapitel 1 gibt die Größen und Bilanzbegriffe vor; Kapitel 2 liefert die Stoffzustände und Tabellenwerte. Kapitel 3 verbindet beides zur Energieerhaltung und zu den Arbeitsformen. Kapitel 4 ergänzt die mögliche Prozessrichtung: Entropie wird transportiert und im Inneren erzeugt. Zusammen prüfen Energie- und Entropiebilanz den physikalisch möglichen Ablauf; die Exergie bewertet zusätzlich die maximal nutzbare Arbeit gegenüber der Umgebung.

#src[Eigene Darstellung; Zusammenführung des bereits enthaltenen Stoffs und der Denkkette auf der Titelseite.]

#pagebreak()

#heading(level: 2, outlined: false)[FET als Zusammenhang]
Die Gesamtübersicht *Big Picture* verbindet Thermodynamik und Strömungsmechanik. Für den bisher behandelten Stoff ergibt sich dieselbe Denkkette: System wählen, Bilanz aufstellen, Zustand mit einem Stoffmodell beschreiben und das Ergebnis prüfen.
#bild("map-fet", [Zusammenhang des bisher behandelten Stoffes. Eigene Darstellung nach B, PDF-S. 2, 4–5, 8 und 18–20.], height: 43mm)
#tab(columns: (1fr, 2.2fr),
 th([Verbindung], [So nutzt du sie im Lernskript]),
 [Masse ↔ Volumenstrom], [$dot(m)=rho A c$ aus Kapitel 1 bleibt beim Verdampfen erhalten; $dot(V)$ ändert sich mit dem Stoffzustand in Kapitel 2.],
 [Stoffwert ↔ Energiebilanz], [$h=u+p v$ verbindet Kapitel 2 mit dem ersten Hauptsatz in Kapitel 3. Der Stickstoffbehälter zeigt zusätzlich eine offene, zeitabhängige Bilanz.],
 [Gesamtübersicht ↔ Vorlesungsstand], [Kreisprozesse sowie Entropie und Zustandsdiagramme sind jetzt durch N03/N04 belegt. Exergieberechnungen sind durch die Bestätigung zu V04, PDF-S. 30–39, ebenfalls behandelt. Die vollständigen Strömungsfolien werden unabhängig vom aktuellen Vorlesungsfortschritt in Kapitel 9 aufgearbeitet.],
)
#src[B, PDF-S. 2, 4–9 und 18–24; N03, PDF-S. 12–14; N04, PDF-S. 4–11. Zuordnung zum belegten Stand: eigene Darstellung.]

#heading(level: 2, outlined: false)[Ältere Altklausurübersicht · Thermodynamik]
Die Unterlage K ordnet Aufgaben aus alten Prüfungen zu. Ihr Stand ist *26.11.2010 (WS 10/11)*. Sie empfiehlt, bei den jüngeren Prüfungen dieser damaligen Auswahl zu beginnen. Die folgende Zuordnung übernimmt die Angaben vollständig; *PF* bedeutet Prüfung, *LN* Leistungsnachweis.
#note("Zeitlich einordnen", [Diese Liste dokumentiert die damalige Auswahl. Die Prüfungsform und der verbindliche Umfang für WS 2026/27 bleiben offen. Die hier genannten Originalprüfungen von 1999 bis 2006 liegen seit dem Import vom 12.11.2026 unter Altklausuren vor. Die historische Auswahl ersetzt keine aktuelle Prüfungsfreigabe.], fill: sand)
#tab(columns: (1.5fr, 1.5fr, 0.8fr),
 th([Prüfung laut K], [Kurzfragen laut K], [Rechnen]),
 [WS 05/06 PF], [1–12; 21], [A1],
 [WS 04/05 PF], [1–10; 22], [A1],
 [WS 03/04 PF], [1–11; 22], [A1],
 [WS 02/03 PF], [1–12; 20; 21], [A1],
 [WS 01/02 PF], [1–12; 17], [A1],
 [WS 00/01 PF], [1–9; 15], [A1],
 [WS 99/00 PF], [1–10; 14], [A1],
 [WS 99/00 LN], [1–9; 14], [A1],
 [WS 99/00 Übungsklausur], [1–11; 14], [A1],
)
#src[K, PDF-S. 1, Abschnitt a; Abgleich der vorhandenen Prüfungsdateien am 12.11.2026.]

#pagebreak()
#heading(level: 2, outlined: false)[Ältere Altklausurübersicht · Strömungsmechanik]
Auch diese Tabelle gibt die *historische* Auswahl aus K wieder. Die Nummern sind Aufgaben- und Fragennummern der jeweiligen alten Prüfung; sie sind keine Abschnittsnummern dieses Lernskripts. „Nicht verlangt“ bezeichnet ausschließlich die damaligen Angaben der Quelle.
#tab(columns: (0.95fr, 1.55fr, 0.6fr, 1.6fr),
 th([Prüfung], [Kurzfragen laut K], [Rechnen], [Damals nicht verlangt]),
 [SS 06 PF], [1¹; 2–7; 9–13; 15], [A1–3], [4: Potentialströmung; 5: Umströmung],
 [WS 05/06 PF], [1¹; 2–12], [A1–3], [4: Potentialströmung; 5: Tragflügel],
 [SS 05 PF], [1¹; 2–13], [A1–3], [4: Potentialströmung; 5: Grenzschicht],
 [SS 05 LN], [Keine Kurzfragen gestellt], [A2], [4: Potentialströmung; 5: Grenzschicht],
 [WS 04/05 PF], [Laut K nicht bereitgestellt], [–], [–],
 [SS 04 PF], [1¹; 2; 8–13], [A1–3], [4: Potentialströmung; 5: Tragflügel],
 [WS 03/04 PF], [1¹; 2–15; 18], [A1–3], [4: Potentialströmung; 5: Grenzschicht],
 [SS 03 PF], [1¹; 2–16], [A1–3], [4: Potentialströmung; 5: Tragflügel],
 [WS 02/03 PF], [1¹; 2–12; 18; 20], [A1–3], [4: Potentialströmung; 5: Tragflügel],
 [SS 02 PF], [1¹; 2; 6; 7; 10–13], [A1–3], [4: Potentialströmung; 5: Tragflügel],
 [WS 01/02 PF], [1¹; 2–8; 10–13], [A2–3], [1: Umströmung mit Reibung; 4: Potentialströmung; 5: Tragflügel],
 [SS 01 PF], [1¹; 3–8; 10–13; 15], [A2–3], [1: Umströmung mit Reibung; 4: Potentialströmung; 5: Grenzschicht],
 [SS 01 LN], [Gruppe 1–3; Gruppe 8; Lösungsvergleich „Böswirth“ laut K], [A2–3], [1: Umströmung mit Reibung; 4: Potentialströmung; 5: Grenzschicht],
 [WS 00/01 PF], [Laut K nicht bereitgestellt], [–], [–],
 [SS 00 PF], [1¹; 2–6], [A2–3], [1: Ähnlichkeit; 4: Potentialströmung; 5: Grenzschicht],
 [SS 00 LN], [1–8¹; 9–17; 21; 28], [A2–3], [1: Ähnlichkeit; 4: Potentialströmung; 5: Umströmung, $c_w$],
)
#text(size: 9pt, fill: muted)[¹ In K auf die damals „bekannten Kennzahlen“ eingeschränkt. Beim SS 00 LN gilt der Zusatz für 1–8. „–“ kennzeichnet hier eine fehlende Angabe, keine ausgeschlossene Aufgabe.]

#note("So nutzt du die Zuordnung", [Suche beim Vorliegen einer Originalprüfung zuerst die passende Zeile, lies dann die tatsächlich gestellte Aufgabe und ordne sie einem bereits behandelten Zusammenhang zu. Ohne die Originalaufgabe lässt sich aus einer Nummer allein kein Inhalt und keine Musterlösung ableiten. Die Verständnis- und Rechenaufgaben dieses Skripts folgen weiterhin dem belegten Vorlesungsstand.])
Der Abschnitt *c) Wärmeübertragung* ist in K nur als Überschrift vorhanden; dazu enthält die Datei keine Aufgabenliste.
#src[K, PDF-S. 1, Abschnitte b–c; Anwendungshinweis: ergänzte Einordnung.]

#pagebreak()
#pagebreak(weak: true)
= Kapitel 1 · Grundbegriffe <a-1>

#überblick([Kapitel 1 auf einen Blick],
  idee(<a-1-1>, [Die Grenze bestimmt die Bilanz.], [Offene und geschlossene Systeme unterscheiden sich durch den möglichen Stoffaustausch.]),
  idee(<a-1-2>, [Stationär und im Gleichgewicht sind verschiedene Aussagen.], [Ein zeitlich unveränderter Betrieb kann weiterhin Ströme enthalten.]),
  idee(<a-1-4>, [Die Bezugsgröße gehört zur Größe.], [Gesamtwerte, Werte je Masse und Werte je Stoffmenge dürfen nicht verwechselt werden.]),
  idee(<a-1-5>, [Ströme beschreiben Transport pro Zeit.], [Die Massenbilanz verbindet Dichte, Querschnitt und Geschwindigkeit.]),
  idee(<a-1-6>, [Zustand und Weg sind zu trennen.], [Zustandsgrößen beschreiben das System, Wärme und Arbeit seine Übertragungen.]),
  idee(<a-1-10>, [Ein Modell braucht Voraussetzungen.], [Reversibilität und Quasistatik sind unterschiedliche Idealisierungen.]),
)

#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Systemgrenze], [offen · geschlossen · Umgebung], ziel: <a-1-1>),
  pfeil(beschriftung: [ordnet Austausch zu]),
  chunk([Bilanzgrößen], [Masse · Energie · Ströme], ziel: <a-1-5>),
  pfeil(beschriftung: [unterscheidet Speicher und Weg]),
  chunk([Zustand und Prozess], [Zustandsgrößen · Wärme · Arbeit], ziel: <a-1-6>),
)
#karte((1fr, auto, 1fr),
  chunk([Bezugsgröße], [gesamt · spezifisch · molar], ziel: <a-1-4>),
  pfeil(beschriftung: [macht Aussagen vergleichbar im]),
  chunk([Passendes Modell], [stationär · Gleichgewicht · reversibel], ziel: <a-1-10>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])


Wir bauen eine wiederverwendbare Lösungsstrategie auf: zuerst den betrachteten Ausschnitt festlegen, dann Masse und Energie bilanzieren. Zustandsgrößen und Stoffgesetze übersetzen das Bilanzergebnis anschließend in Druck, Temperatur oder Volumen. Die Prozessbedingungen entscheiden, welche Vereinfachungen erlaubt sind.

== 1.0 Was ist Thermodynamik? <a-1-0>
Eine Fahrradpumpe erwärmt Luft durch Arbeit. Ein Wasserkocher erwärmt Wasser durch Energiezufuhr. Eine Turbine gewinnt Arbeit aus einem Stoffstrom. Wir verfolgen jeweils *Zustand, Masse und Energie*.

Ein *Fluid* ist eine Flüssigkeit oder ein Gas. Unter anhaltender Schubspannung fließt es; ein Festkörper kann eine statische Schubspannung tragen.

Wir beschreiben die Anlage von außen mit messbaren Größen, statt jedes Molekül einzeln zu verfolgen. Die Massenbilanz sagt, wie sich der Stoffbestand verändert. Die Energiebilanz sagt, welche Energieänderung zu den Übertragungen passt. Erst das Stoffmodell verknüpft diese Ergebnisse mit Druck, Temperatur und Volumen.
#hoch(<a-1>, [Kapitelübersicht])


== 1.1 Das thermodynamische System <a-1-1>
Das *System* ist der betrachtete Ausschnitt. Die reale oder gedachte Grenze trennt ihn von der *Umgebung*. Nur Übertragungen über diese Grenze gehören in seine äußere Bilanz.
#bild("boundary", [System und Umgebung; innere Übertragungen verschwinden in der gemeinsamen Gesamtbilanz. BT, PDF-S. 34.], height: 35mm)

*Beispiel Boiler:* Nur Wasser als System: Energie kommt vom Heizer als Wärme. Wasser *und* Heizer als System: Energie kommt über das Kabel als elektrische Arbeit. Die Grenze entscheidet über die Beschreibung.

#note("In eigenen Worten", [Eine Bilanz ist die Buchhaltung eines gewählten Ausschnitts. Ich muss zuerst wissen, *wo seine Grenze verläuft*.])
#src([L 1.0–1.1, PDF-S. 3–4; V PDF-S. 2–7.])

=== 1.1.1 Bilanzen
Eine Badewanne füllt sich, wenn mehr hinein- als hinausfließt. Eine *Rate* sagt, wie schnell sich der Bestand ändert; der *Bestand* sagt, wie viel gerade vorhanden ist.
#bild("bath", [Badewanne als anschauliche Bilanzhülle. Ausschnitt V, PDF-S. 8.], height: 47mm)
#form[$ (dif m_"Sys")/(dif t)=sum dot(m)_"ein"-sum dot(m)_"aus" $]
$m$: Masse in kg; $dot(m)$: Massenstrom in kg/s. Für die betrachteten Vorgänge wird keine Gesamtmasse erzeugt. Stationär ist die linke Seite null.

Aus der Rate wird der Bestand durch Aufsummieren über die Zeit:
$ m(t)=m_0+integral_0^t dot(m)_"netto" dif tau $
Die Anfangsmasse $m_0$ darf nicht fehlen. Bei konstanter Rate: $m=m_0+dot(m)_"netto"t$. Die orientierte Fläche unter der Netto-Stromkurve ist die Änderung der gespeicherten Masse.

*Energie, geschlossen:* Bei vernachlässigbarer Änderung von Bewegungs- und Lageenergie gilt in der Zufuhrkonvention:
$ Delta U=Q_12+W_12 $
Zufuhr zählt positiv. Beispiel: 100 J Wärme hinein und 40 J Arbeit hinaus ergeben $Delta U=60 thin "J"$. $W$ umfasst alle Arbeitsformen.

*Energie, stationär offen:* Ein Ein- und Austritt, gleicher Massenstrom:
$ dot(Q)+P_t=dot(m)[h_2-h_1+(c_2^2-c_1^2)/2+g(z_2-z_1)] $
$h$: Enthalpie je kg; $c$: Geschwindigkeit; $z$: Höhe; $P_t$: technische Zufuhrleistung. Nur vernachlässigbare Beiträge entfallen.
#bild("map-balance", [Mindmap: Wie Strom, Bestand und Erhaltung zusammenhängen. Eigene Darstellung.], height: 46mm)
#note("Fehler vermeiden", [*Joule* ist eine Energiemenge. *Watt* ist Energie pro Zeit: $1 thin "W"=1 thin "J/s"$. Stationär verschwinden die Speicheränderungen, nicht die Ströme.], fill: sand)
Die Bilanz ist zunächst eine Erhaltungsaussage, noch kein Stoffgesetz. Sie sagt beispielsweise, wie viel Energie im Wasser gespeichert wird. Um daraus die Temperaturänderung zu berechnen, brauchst du zusätzlich Masse und Wärmekapazität. Bei einem Gas können außerdem Volumenarbeit und eine andere Stoffbeziehung wichtig werden. Deshalb folgen auf die Bilanz immer Modellwahl und Zustandsbeschreibung.

#src([L 1.1.1, PDF-S. 4–6; V PDF-S. 8–9 und 17.])

=== 1.1.2 Wie Energie über die Systemgrenze kommt
#bild("transfers", [Arbeit durch Bewegung, Wärme wegen Temperaturunterschied und Energie mit strömender Masse. BT, PDF-S. 35.], height: 42mm)

*Wärme* ist Energieübertragung wegen eines Temperaturunterschieds. *Arbeit* umfasst etwa Kolben-, Wellen- und elektrische Übertragung. Beide sind Prozessgrößen; gespeichert wird beispielsweise innere Energie.

Ein Stoffstrom bringt innere Energie mit und muss gegen Druck in den Kontrollraum geschoben werden. Zusammen ergibt das *Enthalpie*:
$ H=U+p V quad quad h=u+p v quad quad dot(H)=dot(m)h $
$H$ in J, $h$ in J/kg. Die Schubarbeit $p v$ steckt bereits in $h$ und darf in der üblichen Strömungsbilanz nicht nochmals als Wellenarbeit addiert werden.

#tab(columns: (1fr, 2fr),
 th([Arbeitsform], [Ansatz und Voraussetzung]),
 [Volumenarbeit], [$W_v=-integral p dif V$; Systemdruck bei quasistatischer Grenzbewegung. Allgemein zählt der wirksame äußere Druck.],
 [Technische Arbeit], [$w_t=integral v dif p$; reversibel, Änderungen von Bewegungs- und Lageenergie vernachlässigt.],
)
*Innere Energie und Enthalpie einordnen.* Die innere Energie gehört zum Stoffzustand. Bei einem geschlossenen ruhenden Behälter betrachten wir ihre Änderung direkt. Bei einem durchströmten Kontrollraum erleichtert die Enthalpie das Rechnen, weil sie innere Energie und den zum Hinein- beziehungsweise Herausschieben gehörenden Druck-Volumen-Anteil zusammenfasst. Die Wahl ergibt sich aus dem Systemmodell.

#src([L 1.1.2, PDF-S. 6–7; V PDF-S. 10–11.])

=== 1.1.3 Arten von Systemen und Wahl der Systemgrenze
#bild("map-system", [Mindmap: Vier verschiedene Aussagen über die Systemgrenze. Eigene Darstellung.], height: 50mm)

Ein durchströmter Kompressor ist *offen*. Die eingeschlossene Luft bei geschlossenen Ventilen ist *geschlossen*. Eine bewegliche Grenze macht ein System also nicht automatisch offen.

*Starr* bedeutet geometrisch $dif V=0$: keine Volumenarbeit. Rührer oder elektrische Anschlüsse können trotzdem Arbeit übertragen. Die Begriffe „rigid/arbeitsdicht“ werden im vereinfachten Vorlesungsmodell enger verwendet; prüfe deshalb die tatsächlich erlaubten Übertragungen.

#note("Selbst erklären", [Kann ein geschlossenes, starres, adiabates Gefäß über einen Heizstab wärmer werden? Ja: Wenn der elektrische Anschluss zur Grenze gehört, führt er Arbeit zu.])
Die vier Eigenschaften in der Mindmap werden einzeln geprüft. „Geschlossen“ beantwortet die Frage nach dem Stoffaustausch; „adiabat“ die nach Wärmeübertragung. Erst zusammen mit der Beweglichkeit der Grenze und möglichen Arbeitsanschlüssen ergibt sich ein vollständiges Modell. Aus einem einzigen dieser Wörter darfst du deshalb nicht alle übrigen Randbedingungen ableiten.

*Die Gesamtgrenze zählt:* Interne Ströme zwischen den Teilanlagen eines Kraftwerks überqueren die gemeinsame äußere Systemgrenze nicht. Was eine Teilanlage abgibt, nimmt die andere auf; diese Beiträge heben sich in der Gesamtbilanz auf. Das ist eine ergänzende Einordnung zur Wahl der Systemgrenze.

#src([L 1.1.3, PDF-S. 7–8; V PDF-S. 12–15. Arbeitsformen ergänzend präzisiert.])

=== 1.1.5 Typische Berechnung: Kraftwerk
#grid(columns: (1fr, 1fr), gutter: 7mm,
 [#bild("turbine", [Turbine, Ausschnitt V, PDF-S. 24.], height: 44mm)],
 [*1538 MW Brennstoffleistung*\
 $arrow.r$ Umwandlung mit $eta="0,52"$\
 *800 MW elektrische Nutzleistung*\
 Rund 738 MW verlassen die Gesamtanlage auf anderen Wegen.]
)
$ eta_"el"=P_"el"/dot(Q)_B quad => quad dot(Q)_B=800/"0,52" approx 1538 thin "MW" $
Mit $H_u=50 thin "MJ/kg"$: $dot(m)_B=dot(Q)_B/H_u approx "30,8" thin "kg/s"$. Bei $rho_n="0,7175" thin "kg/m"^3$ folgt $dot(V)_n approx "42,9" thin "m"^3/"s"$.

Jahreskosten: $K_B=k_B dot(Q)_B t_B$. Nur bei *angenommenen* 8760 Volllaststunden und 3 €/GJ ergeben sich etwa 146 Mio. €. Die Leistung allein legt die Betriebszeit nicht fest.
#src([L 1.1.5, PDF-S. 9; V PDF-S. 16.])
#hoch(<a-1>, [Kapitelübersicht])


== 1.2 Gleichgewicht und stationärer Zustand <a-1-2>
#tab(columns: (1fr, 2fr),
 th([Begriff], [Anschauliche Bedeutung]),
 [Gleichgewicht], [Kein antreibendes Ungleichgewicht unter den Randbedingungen. Thermisch: Temperaturausgleich; mechanisch: Kräftegleichgewicht; chemisch: keine Nettoänderung durch Reaktion.],
 [Stationär], [Am festen Ort bleiben die Werte zeitlich gleich. Ein Durchlauferhitzer darf dauerhaft kalten Eintritt und warmen Austritt haben.],
 [Homogen / heterogen], [Räumlich einheitliche Eigenschaften / beispielsweise Flüssigkeit und Dampf gemeinsam.],
 [Isotrop / isentrop], [Richtungsunabhängig / Entropie konstant.],
)

*Teilchenreise:* Ein Teilchen wandert in einer stationären Düse von einem langsamen zu einem schnellen Bereich und beschleunigt. Das Strömungsbild am festen Ort bleibt trotzdem gleich.

Ein stationärer Zustand kann nur durch fortlaufenden Austausch aufrechterhalten werden, etwa durch Heizleistung und Wasserströmung im Durchlauferhitzer. Das ist etwas anderes als Gleichgewicht ohne antreibende Temperaturunterschiede. Auch „homogen“ beschreibt eine andere Eigenschaft: Ein ideal gerührtes Bad kann überall dieselbe Temperatur haben und sich trotzdem im Laufe der Zeit erwärmen.

#src([L 1.2, PDF-S. 9–11; V PDF-S. 17–18; BS 1.2, PDF-S. 18–20.])
#hoch(<a-1>, [Kapitelübersicht])


== 1.3 Nullter Hauptsatz und Temperaturmessung <a-1-3>
Ein Thermometer C kann Temperaturen vergleichen, weil gilt:
$ T_A=T_C quad "und" quad T_B=T_C quad => quad T_A=T_B $
Messbar ist beispielsweise Flüssigkeitsausdehnung, elektrischer Widerstand oder eine Thermoelementspannung.
#bild("expansion", [Erwärmen verlängert den Stab. Der gelbe Anteil ist die Längenänderung. V, PDF-S. 47.], height: 38mm)
$ Delta L=alpha_L L_0 Delta T quad quad Delta V=alpha_V V_0 Delta T $
Die Ausdehnungskoeffizienten haben die Einheit $1/"K"$. Näherung für kleine Änderungen und ausreichend konstante Koeffizienten; bei isotropen Feststoffen $alpha_V approx 3 alpha_L$. Faustregel: 1 m Stahl wird bei 100 K etwa 1 mm länger.

#heading(level: 3, outlined: false)[Vom Temperaturverlauf zur Heizleistung]
Die Steigung der Temperaturkurve ist das „Gaspedal“ der Erwärmung:
#form[$ P_"el" approx m c (dif theta)/(dif t) $]
Modell: Wasser und Heizer geschlossen und nach außen adiabat; konstantes $m,c$; zusätzliche Speicher, Rührleistung und Verluste vernachlässigt.
#bild("heating-temperature", [Ü 1.4: Temperatur steigt erst geradlinig, dann parabolisch bis zum flachen Ende. Eigene Auswertung nach T und W.], height: 54mm)
#bild("heating-power", [Die Leistung ist proportional zur Steigung oben. Ohne Wassermasse ist nur W/kg bestimmbar.], height: 50mm)
10 K/h ergeben mit $c=4200 thin "J/(kg K)"$ *11,67 W/kg*. Im ideal adiabaten Halteabschnitt gilt $P=0$; real gleicht eine Halteleistung die Wärmeverluste aus. Vollständige Rechnung: Aufgabe „Wasserbad mit knickfreiem Temperaturverlauf“ auf der Lernwebseite.
#src([L 1.3, PDF-S. 11–12; L 1.1.1, PDF-S. 5–6; Ü 1.4, PDF-S. 5; T PDF-S. 4–9 (neu abgelegte Datei mit Dateinamensbeginn „2024-09-13“, handschriftlich 15.10.2026); W PDF-S. 1–3.])
#hoch(<a-1>, [Kapitelübersicht])


== 1.4 Stoffmenge, Masse, spezifische und molare Größen <a-1-4>
#bild("division", [Gedankliche Teilung eines homogenen Systems. Gesamtmengen teilen sich; intensive Werte bleiben gleich. V, PDF-S. 25.], height: 45mm)
#tab(columns: (1.1fr, 1.4fr, 1fr),
 th([Größe], [Definition], [Einheit]),
 [Masse], [$m=n M=rho V$], [kg],
 [Dichte], [$rho=m/V$], [kg/m³],
 [Spezifisches Volumen], [$v=V/m=1/rho$], [m³/kg],
 [Spezifische Energie], [$u=U/m$, $h=H/m$], [kJ/kg],
 [Molares Volumen], [$V_m=V/n=M v$], [m³/kmol],
)
*Spezifisch* heißt pro Kilogramm, *molar* pro Stoffmenge. Bei $n$ in kmol muss $M$ in kg/kmol stehen. 1 kmol enthält etwa $"6,022" times 10^26$ Teilchen.
Ein Kilogramm Wasser und ein Kilogramm Luft haben dieselbe Masse, benötigen aber sehr unterschiedliche Volumina. Das erfasst $v$: Es ist keine zusätzliche Stoffmenge, sondern ein Volumen je Kilogramm. Solche spezifischen Größen trennen die Stoffeigenschaft von der Gesamtmenge. Aus $h$ wird beispielsweise erst durch Multiplikation mit $m$ die Gesamtenthalpie $H$.

#src([L 1.4, PDF-S. 12–13; V PDF-S. 21 und 25.])
#hoch(<a-1>, [Kapitelübersicht])


== 1.5 Ströme und Kontinuitätsgleichung <a-1-5>
#bild("continuity", [Eine Stromröhre begrenzt den transportierten Stoffstrom. BS, PDF-S. 19.], height: 46mm)
#form[$ dot(V)=A c quad dot(m)=rho A c quad J=dot(m)/A $]
$A$ in m², $c$ in m/s, $dot(V)$ in m³/s, $dot(m)$ in kg/s; Massenstromdichte $J$ in kg/(m² s).

Stationär ohne weitere Ein- oder Austritte bleibt der Massenstrom gleich:
$ rho_1 A_1 c_1=rho_2 A_2 c_2 $
Nur bei konstanter Dichte: $A_1c_1=A_2c_2$. Halber *Durchmesser* ergibt ein Viertel der Fläche und vierfache Geschwindigkeit.
#bild("hose", [Gartenschlauch mit enger Düse. Eigens erzeugte Illustration; nicht maßstäblich.], height: 48mm)
*Ü 1.7:* 25 l in 50 s ergeben 0,5 l/s. Bei 20 mm Durchmesser: 1,59 m/s; bei 8 mm: 9,95 m/s. Rechnung: Aufgabe „Gartenschlauch und Düse“ auf der Lernwebseite.

Eine *Stromlinie* zeigt die momentane Geschwindigkeitsrichtung; eine *Bahnkurve* verfolgt ein Teilchen. Stationär stimmen beide überein. BS schreibt meist $w$, hier verwenden wir $c$ für die Geschwindigkeit.

#note("Zwei verschiedene Idealmodelle", [*Ideales Gas:* $p v=R T$, Dichte darf sich ändern. *Ideales Fluid in BS:* inkompressibel und reibungsfrei. Aus der Gasgleichung folgt keine Reibungsfreiheit.], fill: sand)
Die engere Düse erzeugt keine zusätzliche Masse. Bei fest vorgegebenem Volumenstrom muss sich das Fluid im kleineren Querschnitt schneller bewegen. Verändert sich die Dichte, wird die Aussage allgemeiner: Dieselbe Masse pro Sekunde kann an verschiedenen Orten unterschiedlich viel Volumen pro Sekunde beanspruchen. Das wird beim Verdampfer in Kapitel 2 besonders deutlich.

#src([L 1.5, PDF-S. 13–14; V PDF-S. 21–24; BS 1.2, PDF-S. 18–20.])

#heading(level: 3, outlined: false)[Brücke zur Strömungslehre: Bernoulli und Ausfluss]
Die Kontinuität erhält die Masse. Bernoulli beschreibt den Austausch von Druck-, Bewegungs- und Lageenergie:
$ p/rho+c^2/2+g z="konstant" $
Gültig entlang einer Stromlinie: stationär, inkompressibel, reibungsfrei, ohne Maschinenarbeit. Alle Summanden haben die Einheit J/kg.
#bild("bernoulli", [Höhe kann in Geschwindigkeit übergehen. BS, PDF-S. 49.], height: 46mm)

Großer offener Behälter, kleiner Auslass, gleiche Umgebungsdrücke und vernachlässigte Verluste:
$ c_0=sqrt(2 g h) quad quad A (dif h)/(dif t)=-A_0 sqrt(2 g h) $
Sinkt $h$, sinkt auch der Ausfluss. Der Behälter ist instationär, der lokale Ausfluss wird quasistationär modelliert.
#bild("drain-plot", [Ü 1.5, vereinfachtes Modell: Die erste Volumenhälfte fließt schneller ab als die zweite. Eigene Rechnung; Aufgabe „Füllstandsabhängiger Ausfluss“.], height: 54mm)
#src([L: Kontinuität 1.5, PDF-S. 13–14, Druck 1.7, PDF-S. 19–20. Bernoulli ergänzt nach BS 2.1, PDF-S. 48–55; Ü 1.5, PDF-S. 5.])
#hoch(<a-1>, [Kapitelübersicht])


== 1.6 Thermodynamische Zustandsgrößen <a-1-6>
#bild("states", [Zwei Zustände sind zwei Momentaufnahmen. Der Pfeil beschreibt den Prozess dazwischen. V, PDF-S. 37.], height: 35mm)
*Zustandsgrößen* beschreiben das aktuelle System. Ihre Änderung hängt nur von den Endzuständen ab. *Wärme und Arbeit* beschreiben Übertragungen auf dem Weg.

#tab(columns: (1fr, 1.8fr),
 th([Einteilung], [Beispiele und Bedeutung]),
 [Extensiv], [$m,V,U,H,S$ addieren sich bei der Systemteilung.],
 [Intensiv], [$p,T,rho,v,h$ bleiben bei Teilung eines homogenen Zustands gleich.],
 [Thermisch], [$p,T,V$: Druck, Temperatur, Volumen.],
 [Kalorisch], [$U,H,S$: innere Energie, Enthalpie, Entropie.],
)
$U,H$ in J; $S$ in J/K; $s=S/m$ in J/(kg K). Entropie beschreibt später Prozessrichtung und Irreversibilität mit.

Im Kreisprozess kehrt jede Zustandsgröße zum Anfangswert zurück: $integral.cont dif Y=0$. Nettoübertragungen von Wärme oder Arbeit können trotzdem verbleiben.
#bild("map-state", [Mindmap: Zustand, Menge, Prozess und Stoffmodell unterscheiden. Eigene Darstellung.], height: 47mm)
Normzustand des Skripts: $p_n="1,01325" thin "bar"$, $T_n="273,15" thin "K"$. Ein Normvolumen braucht immer diesen Bezugszustand.
Bei einer Zustandsgröße reicht der Vergleich „Endwert minus Anfangswert“. Die innere Energie kann etwa durch Wärmeaufnahme oder durch zugeführte Arbeit steigen. Der gleiche Anstieg von $U$ verrät deshalb noch nicht, auf welchem Weg er zustande kam. Im Kreisprozess ist die Zustandsänderung insgesamt null; die einzelnen Übertragungen müssen es nicht sein.

#src([L 1.6, PDF-S. 14–16; V PDF-S. 25–26.])

#pagebreak()
=== 1.6.1 Zustandsfläche, ideales Gas und Zustandsdiagramme
Für einen einfachen reinen Stoff im einphasigen Gleichgewicht genügen zwei unabhängige intensive Angaben. Eine Zustandsfläche ist die Landkarte der zulässigen Kombinationen, etwa $p=p(v,T)$.
#grid(columns: (1fr, 1fr), gutter: 7mm,
 [#bild("piston", [Kolben-Gas-System, eigens erzeugte schematische Illustration.], height: 52mm)],
 [#form[$ p v=R T $\ $p V=m R T$]
 $p$: absolut in Pa; $T$: in K; $R$: in J/(kg K). Für Luft: $R="287,2" thin "J/(kg K)"$.

 *Bei 1 bar und 0 °C:* $v approx "0,7845" thin "m"^3/"kg"$, $rho approx "1,275" thin "kg/m"^3$.]
)
Für dieselbe geschlossene Gasmenge gilt $p_1V_1/T_1=p_2V_2/T_2$. Isochor folgt $p_2/p_1=T_2/T_1$. Differenziell: $dif p/p+dif v/v=dif T/T$.
#bild("pv-isolines", [Die Form im p-v-Diagramm folgt aus der jeweils konstanten Größe. Schematisch für ein ideales Gas.], height: 51mm)
Isentrop: $s$ konstant; beim idealen Gas mit konstanten Wärmekapazitäten steiler als die Isotherme. Isenthalp: $h$ konstant. Isovapor: $x$ konstant im Nassdampfgebiet.

#note("Gültigkeit", [Das ideale Gasmodell vernachlässigt Eigenvolumen und Wechselwirkungen. Nahe Kondensation oder bei hoher Dichte reicht es oft nicht aus. Ausreichend verdünnter Dampf kann dagegen näherungsweise ideal sein.], fill: sand)
Das ideale Gasmodell liefert eine anschauliche Ursache-Wirkungs-Beziehung: Bei festem Volumen führt Erwärmen zu höherem Druck. Vereinfacht stoßen die Teilchen stärker gegen die Wand. Bei gleichbleibender Temperatur verringert Vergrößern des Volumens dagegen den Druck. Entscheidend ist immer, welche Größe während der Änderung festgehalten wird; aus „Erwärmen“ allein folgt noch keine eindeutige Druckänderung.

#src([L 1.6.1, PDF-S. 16–19; V PDF-S. 27–33.])
#hoch(<a-1>, [Kapitelübersicht])


== 1.7 Druck <a-1-7>
#grid(columns: (0.9fr, 1.1fr), gutter: 6mm,
 [#bild("manometer", [U-Rohr-Manometer, V PDF-S. 35.], height: 63mm)],
 [Druck ist Normalkraft pro Fläche: $p=F_"normal"/A$.

 $1 thin "Pa"=1 thin "N/m"^2$; $1 thin "bar"=10^5 thin "Pa"$.

 *Absolutdruck* zählt vom Vakuum, *Überdruck* von der Umgebung:
 $p_"abs"=p_e+p_"amb"$

 Beispiel: 2,2 bar Überdruck + 0,96 bar Umgebung = *3,16 bar absolut*.]
)
Der Druckgradient trägt das Gewicht des ruhenden Wassers: Mechanisches Gleichgewicht verlangt Kräftegleichgewicht, nicht überall gleichen Druck.

Ruhende Flüssigkeit konstanter Dichte, Tiefe $h$ nach unten: $p=p_0+rho g h$. Bei Höhenkoordinate $z$ nach oben: $dif p/dif z=-rho g$.

Beim einfachen U-Rohr mit vernachlässigbarer Gasdichte: $abs(Delta p)=rho_M g Delta h$. Flüssige Messleitungen können einen Dichteunterschied statt nur $rho_M$ erfordern. Das Vorzeichen folgt aus dem Druckweg.

*Kolben:* 1 kg Zusatzmasse auf 1 cm² erzeugt $m g/A="0,981" thin "bar"$ Überdruck. Zehn Meter Wasser erzeugen ungefähr ein zusätzliches Bar.
Druck ist eine Zustandsgröße; die Druckdifferenz bestimmt, welche mechanische Wirkung zwischen zwei Seiten möglich ist. An einem Kolben zählt beispielsweise die Druckkraft jeder Seite. Für die Gasgleichung brauchst du dagegen den vom Vakuum aus gemessenen Absolutdruck. Die passende Druckangabe ergibt sich also aus der konkreten Gleichung.

#src([L 1.7, PDF-S. 19–20; V PDF-S. 34–35.])
#hoch(<a-1>, [Kapitelübersicht])


== 1.8 Temperatur <a-1-8>
#bild("kelvin", [Celsius und Kelvin haben dieselbe Schrittweite, aber verschiedene Nullpunkte. Eigene Darstellung.], height: 49mm)
$ T/"K"=theta/"°C"+"273,15" $
In der Gasgleichung und in Temperaturverhältnissen braucht man *Kelvin*. Eine Differenz von 10 °C entspricht 10 K. 60 °C ist nicht die dreifache absolute Temperatur von 20 °C.

Fahrenheit als Zahlenwert: $theta_C=(5/9)(theta_F-32)$. Somit entsprechen 68 °F genau 20 °C.
#src([L 1.8, PDF-S. 20–21; V PDF-S. 36.])
#hoch(<a-1>, [Kapitelübersicht])


== 1.9 Zustandsänderungen und Prozessgrößen <a-1-9>
Gleiche Endzustände erlauben verschiedene Wege. Die Zustandsänderung $Delta U$ ist gleich; Wärme und Arbeit können sich unterscheiden.
#bild("path-work", [Gleiche Punkte 1 und 2; unterschiedliche Flächen unter dem Weg. Geschlossene ideale Gasmenge, quasistatische Volumenarbeit. Eigene Zahlenillustration.], height: 54mm)
#form[$ W_v=-integral_(V_1)^(V_2) p dif V $]
Expansion hat $dif V>0$, also $W_v<0$: Arbeit verlässt das System. Kompression hat $W_v>0$. Im Bild ist der Arbeitsbetrag die Fläche; 1 bar·m³ = 100 kJ.

Isobar: $W_v=-p(V_2-V_1)$. Isotherm beim idealen Gas: $W_v=m R T ln(V_1/V_2)$.

Ein rechtsläufiger Kreisprozess expandiert bei höherem Druck und komprimiert bei niedrigerem Druck: Nettoarbeit nach außen, also negativ in der Zufuhrkonvention. Auch innere Ausgleichsvorgänge können Teilzustände ändern, ohne äußeren Austausch.
#src([L 1.9, PDF-S. 21–23; V PDF-S. 37–39.])
#hoch(<a-1>, [Kapitelübersicht])


== 1.10 Modelle; reversibel und irreversibel <a-1-10>
#bild("reversibility", [Heizen und Rühren verändern den Gaszustand. Rückwärtsrühren kann die dissipierte Arbeit nicht wieder zurückholen. V, PDF-S. 43.], height: 58mm)
*Reversibel* heißt: System *und Umgebung* ließen sich ohne bleibende Änderung zurücksetzen. Reibung und Wärmeübertragung über endliche Temperaturunterschiede verhindern das.

*Quasistatisch* heißt: gedachte Folge von Gleichgewichtszuständen. Ein langsamer Kolben mit Reibung kann quasistatisch und trotzdem irreversibel sein.

#tab(columns: (1fr, 1fr, 1fr, 1fr),
 th([isobar], [isochor], [isotherm], [adiabat]),
 [$p$ konstant], [$V$ konstant], [$T$ konstant], [$Q=0$],
)
Adiabat schließt Erwärmung durch Arbeit nicht aus. Energieerhaltung gilt auch bei irreversiblen Prozessen.
#bild("map-ptw", [Mindmap: Messgrößen, Arbeitsvorzeichen und Umkehrbarkeit. Eigene Darstellung.], height: 46mm)
Bei technischen „Verlusten“ verschwindet keine Energie. Reibung kann geordnete Bewegung in innere Energie umwandeln, die sich nicht vollständig auf demselben Weg zurückgewinnen lässt. Die Energiebilanz beantwortet die Mengenfrage. Ob ein Prozess umkehrbar ist, erfordert zusätzlich eine Aussage über seine Richtung und seine Wirkung auf die Umgebung.

#src([L 1.10, PDF-S. 23–25; V PDF-S. 40–43.])

*Der Zusammenhang in Kapitel 1.* Die Systemgrenze bestimmt die Übertragungen. Die Bilanz bestimmt die Speicherung beziehungsweise den Energieumsatz. Das Stoffmodell verbindet diese Größen mit dem Zustand. Der Prozessweg legt schließlich fest, welche Wärme und Arbeit zwischen den Zuständen übertragen werden.
#hoch(<a-1>, [Kapitelübersicht])


#pagebreak(weak: true)
= Kapitel 2 · Stoffeigenschaften <a-2>

#überblick([Kapitel 2 auf einen Blick],
  idee(<a-2-1>, [Energiezufuhr kann Temperatur oder Phase ändern.], [Beim Verdampfen eines reinen Stoffes hängen Sättigungsdruck und Sättigungstemperatur zusammen.]),
  idee(<a-2-4>, [Das Zustandsgebiet kommt vor der Rechnung.], [Flüssigkeit, Nassdampf, überhitzter Dampf und überkritische Zustände verlangen passende Beschreibungen.]),
  idee(<a-2-9>, [Dampfgehalt ist ein Massenanteil.], [Er bestimmt die gemittelten spezifischen Größen im Nassdampfgebiet.]),
  idee(<a-2-10>, [Die Tabelle muss zum Gebiet passen.], [Sättigungswerte, Überhitzung und Interpolation folgen den Angaben; #link(<a-2-15>)[Dampfleitung und Überhitzer] wenden das an.]),
  idee(<a-2-12>, [Stoffmodelle haben einen Gültigkeitsbereich.], [Realgasgleichungen und Gemischgrößen ergänzen das ideale Gasmodell.]),
  idee(<a-2-13>, [Ein Prozess verbindet Zustände unter Bedingungen.], [Konstante Größen, Bezugsgrößen und Tabellenrichtung steuern den Rechenplan; #link(<a-2-14>)[drei Phasen] verlangen drei Phasenbeiträge.]),
)

#ablauf(
  chunk([Gegebene Größen lesen], [Druck · Temperatur · spezifisches Volumen · Stoff], ziel: <a-2-4>),
  entscheidung([Liegt der Zustand im Nassdampfgebiet?],
    chunk([Sättigung und Dampfgehalt], [Strichwerte und Massenanteile verwenden], ziel: <a-2-9>),
    chunk([Einphasiges Gebiet prüfen], [passende Tabelle oder Zustandsgleichung wählen], ziel: <a-2-10>)),
  chunk([Stoffwerte bestimmen], [bei Bedarf interpolieren · Bezugsgröße und Einheiten prüfen], ziel: <a-2-13>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])


Die Bilanzmethode bleibt erhalten. Neu ist, dass Energiezufuhr auch die Phase des Stoffes verändern kann. Deshalb müssen wir vor der Rechnung erkennen, in welchem Zustandsgebiet der Stoff liegt. Die Diagramme liefern dafür die Orientierung; Stoffwerttabellen und Mischungsregeln liefern anschließend die Zahlen.

== 2.1 Die Erwärmungskurve: fest → flüssig → Dampf <a-2-1>
Zugeführte Energie kann die Temperatur erhöhen (*fühlbar*) oder den Phasenanteil verändern (*latent*). Darum zeigt die Erwärmungskurve verschiedene Abschnitte.
#bild("warming", [1 kg Wasser bei 1 bar: vom Eis bei −15 °C bis zum Dampf bei 200 °C. Vereinfachte Rechenvariante aus Ü 2.2; Aufgabe „Fünf Energieanteile beim Erwärmen“.], height: 59mm)
#tab(columns: (1.1fr, 1.7fr),
 th([Was passiert?], [Wohin geht die Energie?]),
 [Einphasig erwärmen], [Temperatur steigt: näherungsweise $Q=m c Delta T$.],
 [Schmelzen / Verdampfen], [Phase wandelt sich um. Isobar im Gleichgewicht bleibt bei einem reinen Stoff die Temperatur konstant.],
)
#bild("energy-parts", [Energieanteile zur Kurve oben. Besonders viel Energie steckt in der Verdampfung. Eigene Rechnung.], height: 47mm)

Steht wie in der Mitschrift die Temperatur auf der waagerechten Achse, erscheint derselbe Phasenwechsel senkrecht. Hier steht die Temperatur auf der senkrechten Achse: Der Phasenwechsel ist waagerecht.

Beim isobaren Modell eines geschlossenen Systems mit nur Volumenarbeit und vernachlässigbaren äußeren Energieänderungen gilt $Q=Delta H$. Die Sättigungsenthalpiedifferenz ist $r=h''-h'$; vollständiges Verdampfen benötigt $Q=m r$.

#heading(level: 3, outlined: false)[Mittlere Wärmekapazität: den Tabellenbezug beachten]
Ein auf 0 °C bezogener Mittelwert $C_theta$ umfasst den Bereich 0 → $theta$. Für 6 → 80 °C zieht man den bereits vorhandenen Anteil ab:
$ Delta h=(C_80 times 80-C_6 times 6)(1 thin "K") $
80 und 6 sind hier ausdrücklich Celsius-Zahlenwerte. Allgemein gilt $Delta h=integral_(T_1)^(T_2)c_p(T)dif T=overline(c)_(p,12)Delta T$. Beim idealen Gas gilt zudem $dif u=c_v dif T$ und $dif h=c_p dif T$.
Nicht einfach den 0→80-Mittelwert mit 74 K multiplizieren. Das Intervall ist ein anderes. Beispiele auf der Lernwebseite: „Boiler, Mittelwert und Spitzenlast“ und „Bottich mit genauer Wärmekapazität“.
#bild("map-heat", [Mindmap: Wann steigt die Temperatur und wann verändert sich der Phasenanteil? Eigene Darstellung.], height: 46mm)
Die Wärmekapazität beschreibt den Energiebedarf je Temperaturänderung. Für dieselbe Masse bedeutet größeres $c$: Mehr Energie ist für ein Kelvin Erwärmung erforderlich. Während eines Phasenwechsels reicht diese Beschreibung nicht aus. Dann ändern sich die innere Struktur und gegebenenfalls das Volumen des Stoffes; die zusätzliche Phasenwechselenergie wird durch die passende Enthalpiedifferenz erfasst.

#src([L 2.1, PDF-S. 32–34; Ü 2.2, PDF-S. 13 und Tabelle PDF-S. 19; BT 6.4, PDF-S. 213–214.])
#hoch(<a-2>, [Kapitelübersicht])


== 2.2 Ideales Gas als Teil des realen Verhaltens <a-2-2>
Der *Realgasfaktor* misst die Abweichung von der idealen thermischen Beziehung:
#form[$ Z=(p v)/(R T) quad quad p V=m Z R T $]
Ideal gilt $Z=1$. Real hängt $Z$ vom Zustand ab. Hohe Dichte und die Nähe zur Kondensation machen Abweichungen oft bedeutsam.

Geschlossene starre Flasche, gleiche Gaszusammensetzung:
$ p_2/p_1=(Z_2 T_2)/(Z_1 T_1) $
#bild("oxygen", [Ü 2.5: dieselbe Abkühlaufgabe, zwei Stoffmodelle. Nur ideal gilt hier p/T = konstant. Eigene Rechnung; Aufgabe „Sauerstoffflasche: ideal und real“.], height: 50mm)
Ein vorgegebener $Z_2$ muss zum Endzustand gehören. Ohne diese Vorgabe kann wegen der Druckabhängigkeit eine gekoppelte Stoffwertsuche erforderlich sein.
$Z$ ist ein Korrekturfaktor der thermischen Zustandsgleichung, kein Wirkungsgrad. Ein Wert unter eins bedeutet bei gleichem $R,T$ ein kleineres Produkt $p v$ als im idealen Modell; ein Wert über eins ein größeres. Daraus folgt nicht pauschal „weniger“ oder „mehr“ Energie. Für Energiebilanzen brauchst du weiterhin kalorische Stoffwerte wie $u$ oder $h$.

#src([L 2.2, PDF-S. 35–36; V PDF-S. 71; Ü 2.5, PDF-S. 13.])
#hoch(<a-2>, [Kapitelübersicht])


== 2.3 Verdampfen auf der Zustandsfläche <a-2-3>
#bild("pvt", [Eine Zustandsfläche verknüpft p, v und T. Die Projektionen sind p-v-, T-v- und p-T-Diagramme. V, PDF-S. 52.], height: 73mm)
Im Flüssig-Dampf-Gleichgewicht eines reinen Stoffes sind Druck und Temperatur gekoppelt: $T=T_s(p)$. Der Phasenanteil ist dadurch noch nicht bekannt.

*Feynman-Bild:* Die Sättigung ist wie eine Schiene auf der Landkarte. Der Druck legt die zugehörige Temperatur fest; eine weitere Angabe sagt, wie viel Flüssigkeit und wie viel Dampf vorliegen.
#src([L 2.3, PDF-S. 36–37; V PDF-S. 52–53.])
#hoch(<a-2>, [Kapitelübersicht])


== 2.4 Zustandsbereiche eines Fluids und kritischer Punkt <a-2-4>
#bild("phase-dome", [Flüssig-Dampf-Gebiet im p-v-Diagramm, schematisch und ohne Stoffwertmaßstab. Eigene Darstellung.], height: 62mm)
#tab(columns: (1.1fr, 1.8fr),
 th([Bereich / Grenze], [Bedeutung]),
 [Unterkühlte Flüssigkeit], [$T<T_s(p)$ im betrachteten Flüssig-Dampf-Bereich.],
 [Siedelinie], [Gesättigte Flüssigkeit: $x=0$, Werte $v',h',u',s'$.],
 [Nassdampf], [Beide Phasen: $0<x<1$.],
 [Taulinie], [Trocken gesättigter Dampf: $x=1$, Werte $v'',h'',u'',s''$.],
 [Überhitzter Dampf], [$T>T_s(p)$.],
)
Am kritischen Punkt verschwinden der Unterschied $v''-v'$ und die Verdampfungsenthalpie. Konsistente gerundete Wasserwerte: $p_"kr" approx "220,64" thin "bar"$, $T_"kr" approx "647,1" thin "K"$, $v_"kr" approx "0,003106" thin "m"^3/"kg"$.

#note("Tabellen nicht mischen", [V verwendet daneben $v_"kr"="0,00317" thin "m"^3/"kg"$; BT enthält einen älteren kritischen Datensatz. Verwende innerhalb einer Rechnung den vorgegebenen Datensatz. „Unterkühlt“ und „überhitzt“ beziehen sich auf die Sättigung, nicht auf den menschlichen Wärmeindruck.], fill: sand)
Im Nassdampfgebiet verändern unterschiedliche Phasenanteile das spezifische Volumen, obwohl Druck und Temperatur dieselben bleiben. Am kritischen Punkt fallen die Stoffwerte der koexistierenden Phasen zusammen. Dort verlieren die getrennten Bezeichnungen „Flüssigkeitsanteil“ und „Dampfanteil“ ihre bisherige Bedeutung. Der kritische Punkt ist daher keine gewöhnliche Sättigung mit nur besonders hoher Temperatur.

#src([L 2.4, PDF-S. 37–38; V PDF-S. 54 und 68; älterer BT-Datensatz: Tabelle 3.2, PDF-S. 82.])
#hoch(<a-2>, [Kapitelübersicht])


== 2.5 Isobares Verdampfen 1–2–3–4–5 <a-2-5>
#bild("five-states", [Ein passend belasteter beweglicher Kolben hält den Druck ungefähr konstant. BT, PDF-S. 73.], height: 55mm)
#tab(columns: (0.4fr, 1.2fr, 1.6fr),
 th([Nr.], [Zustand], [Beim Heizen]),
 [1], [Unterkühlte Flüssigkeit], [Temperatur steigt bis $T_s$.],
 [2], [Gesättigte Flüssigkeit], [$x=0$: Verdampfen beginnt.],
 [3], [Nassdampf], [$x$ wächst, $p,T$ bleiben gleich.],
 [4], [Sattdampf], [$x=1$: Verdampfen ist vollständig.],
 [5], [Überhitzter Dampf], [Temperatur steigt wieder.],
)
$ Q_(2,4)=m(h''-h')=m r $
Gültig unter den isobaren Modellbedingungen aus 2.1. Kondensieren gibt die entsprechende Energie ab. Wasser siedet bei 1 bar bei etwa 99,6 °C, bei rund 1,013 bar bei etwa 100 °C. Höherer Sättigungsdruck bedeutet höhere Sättigungstemperatur.
#src([L 2.5, PDF-S. 38–39; V PDF-S. 53–56; BT PDF-S. 72–74.])
#hoch(<a-2>, [Kapitelübersicht])


== 2.6 Überkritischer Weg 1–a–b–5 <a-2-6>
#bild("supercritical", [Druckerhöhung, Erwärmen bei überkritischem Druck und anschließende Entspannung. BT, PDF-S. 76.], height: 57mm)
Oberhalb des kritischen Drucks gibt es beim Erwärmen keinen gewöhnlichen Siedevorgang mit zwei getrennten Phasen. Die Eigenschaften ändern sich kontinuierlich von flüssigkeitsähnlich zu gasähnlich.

*Kein latenter Phasensprung* bedeutet nicht *kein Energiebedarf*: Die Enthalpie steigt weiterhin. „Fluid“ ist der Oberbegriff für Flüssigkeiten und Gase, nicht erst die Bezeichnung eines überkritischen Zustands.
Der Unterschied zum isobaren Verdampfen ist der Weg auf der Zustandsfläche. Beim gewöhnlichen Sieden durchläuft man ein Gebiet mit zwei Phasen. Der Weg bei überkritischem Druck umgeht diese Koexistenz. Die Stoffeigenschaften ändern sich dabei weiterhin, deshalb sind auch hier Energiezufuhr und passende reale Stoffwerte erforderlich.

#src([L 2.6, PDF-S. 39–40; V PDF-S. 53 und 55–56; BT PDF-S. 75–76.])
#hoch(<a-2>, [Kapitelübersicht])


== 2.7 Isochore Verdampfung: starrer Behälter <a-2-7>
#bild("isochoric", [Senkrechte Wege bei konstantem spezifischem Volumen: Die Füllung bestimmt, welche Seite erreicht wird. V, PDF-S. 57; dessen kritischer Datensatz.], height: 65mm)
Geschlossen und starr: $m,V$ und damit $v=V/m$ bleiben konstant.

- $v>v_"kr"$: Austritt aus dem Nassdampfgebiet zur *Dampfseite*.
- $v<v_"kr"$: Austritt zur *Flüssigkeitsseite*. Danach kann der Druck stark steigen, weil Flüssigkeit wenig kompressibel ist.
- $v=v_"kr"$: idealisierter Weg zum kritischen Zustand.

Mehr Wärmezufuhr bedeutet deshalb nicht bei jeder Randbedingung mehr Dampf. Ein starker Druckanstieg ist möglich; eine Explosion folgt nicht zwangsläufig allein aus $v<v_"kr"$.
#src([L 2.7, PDF-S. 40; V PDF-S. 57.])
#hoch(<a-2>, [Kapitelübersicht])


== 2.8 Polytrope Zustandsänderung mit Verdampfung <a-2-8>
Im allgemeinen Folienbeispiel ändern sich $p,V,T$ gleichzeitig. Der Stoff erhält Wärme und gibt bei Expansion Volumenarbeit ab:
$ Delta U=Q_12+W_12 quad "mit" quad W_v<0 $
Die Wärme ist daher im Allgemeinen nicht allein gleich $Delta U$.

Eine mathematische Polytrope erfüllt $p v^n="konstant"$ bei konstantem $n$. Ein beliebiger realer Zweiphasenweg erfüllt das nicht automatisch. Die Folienbezeichnung erlaubt also nicht ungeprüft die Formeln idealer Gaspolytropen.
#bild("map-path", [Mindmap: Die festgehaltene Größe entscheidet über den Zustandsweg. Eigene Darstellung.], height: 48mm)
#src([L 2.8, PDF-S. 41; V PDF-S. 58. Engere Polytropendefinition ergänzend präzisiert.])
#hoch(<a-2>, [Kapitelübersicht])


== 2.9 Nassdampf und Dampfgehalt <a-2-9>
Der *Dampfgehalt* ist ein Massenanteil:
#form[$ x=m''/(m'+m'') quad m''=x m quad m'=(1-x)m $]
Weil Dampf pro Kilogramm viel mehr Raum braucht, kann wenig Dampfmasse den größten Teil eines Gefäßes ausfüllen.
#bild("mass-volume", [Ammoniak-Ampulle aus Ü 2.3: 1,22 % Dampfmasse belegen 83,68 % des Volumens. Eigene Rechnung; Aufgabe „Ammoniak: wenig Dampfmasse, viel Dampfvolumen“.], height: 48mm)

*Herleitung der Mischungsregel:* $V=m'v'+m''v''$. Durch $m$ teilen und $m''/m=x$ setzen:
$ v=(1-x)v'+x v''=v'+x(v''-v') $
Für $y=v,h,u,s$ gilt daher:
#form[$ y=y'+x(y''-y') quad => quad x=(y-y')/(y''-y') $]
Alle Randwerte gehören zur *gleichen Sättigung*. $p$ legt $T_s$ fest; zusätzlich braucht man beispielsweise $x$ oder einen Mischungswert.
#bild("lever", [Hebelregel: Der Abstand vom Flüssigkeitsrand relativ zur gesamten Zweiphasenbreite bestimmt x. V, PDF-S. 60.], height: 57mm)

*Volumenanteil statt Massenanteil:*
$ mu=V''/V=(x v'')/v $
Bei gegebenen Teilvolumina zuerst $m'=V'/v'$ und $m''=V''/v''$ berechnen. Erst danach $x=m''/(m'+m'')$ bilden.

In einer Zweiphasenströmung mit gemeinsamer mittlerer Geschwindigkeit gilt $dot(V)''=x dot(m)v''$, $dot(V)'=(1-x)dot(m)v'$ und $c=dot(m)v/A$. Phasengleiten erfordert ein anderes Modell.
#note("Plausibilitätsprüfung", [Bei $0<=x<=1$ liegen $v,h,u,s$ zwischen ihren Randwerten. $x>1$ ist keine zulässige Beschreibung überhitzten Dampfes mit der Nassdampfformel.], fill: sand)
Die Mischungsregel folgt daraus, dass sich die Gesamtmengen von Volumen, innerer Energie, Enthalpie und Entropie aus den Beiträgen beider Phasen addieren. Nach dem Teilen durch die Gesamtmasse entstehen Massen-Gewichte $1-x$ und $x$. Druck und Temperatur werden damit nicht zu frei mischbaren Größen: Beide Phasen besitzen bereits dieselben Sättigungswerte.

#src([L 2.9, PDF-S. 41–43; V PDF-S. 59–60; BT 3.4, PDF-S. 80–85.])

#heading(level: 3, outlined: false)[Anwendung: Wärmerohr]
#bild("heatpipe", [Am warmen Ende verdampft Fluid; am kalten Ende kondensiert es. Die Masse zirkuliert innerhalb der äußeren Grenze. BT, PDF-S. 86.], height: 38mm)
Das Wärmerohr ist nach außen *geschlossen* und kann dennoch Wärme transportieren. Stationär bleibt sein Energieinhalt konstant, weil Aufnahme und Abgabe einander ausgleichen.
#src([L 1.1.3, PDF-S. 7–8, und 2.5, PDF-S. 38–39; Anwendung ergänzt nach BT 3.4, PDF-S. 86.])
#hoch(<a-2>, [Kapitelübersicht])


== 2.10 Dampftafel: Werte für Wasser ablesen <a-2-10>
Die Dampftafel ist die Zahlenkarte des realen Stoffes. Zuerst kommt die Gebietsentscheidung:
#tab(columns: (1.1fr, 1.8fr),
 th([Angaben / Bereich], [Vorgehen]),
 [$p$ vorgegeben], [$T_s(p)$ nachsehen. Im Flüssig-Dampf-Bereich $T$ damit vergleichen.],
 [$T<T_s$ / $T>T_s$], [Unterkühlte Flüssigkeit / überhitzter Dampf: passende p-T-Tabelle.],
 [Sättigung / Nassdampf], [Sättigungstafel mit Strichwerten; zusätzlich $x$, $v$ oder $h$ nutzen.],
)

*Beispiel bei 200 bar und $x="0,8"$:* $h'=1827$, $h''=2418 thin "kJ/kg"$; $s'="4,015"$, $s''="4,941" thin "kJ/(kg K)"$.
$ h=1827+"0,8"(2418-1827)="2299,8" thin "kJ/kg" $
$ s="4,015"+"0,8"("4,941"-"4,015")="4,7558" thin "kJ/(kg K)" $
Mit den in L ergänzten Näherungen $v' approx "0,00204"$, $v''="0,005877" thin "m"^3/"kg"$ folgt $v approx "0,00511" thin "m"^3/"kg"$ und $u=h-p v approx 2198 thin "kJ/kg"$. Dabei $p=20000 thin "kPa"$ einsetzen: kPa·m³/kg = kJ/kg.

*Interpolation:* Ein Anteil $f$ am Eingabeabstand liefert denselben Anteil am Werteunterschied:
$ f=(a-a_1)/(a_2-a_1) quad quad y approx y_1+f(y_2-y_1) $
Bei zwei veränderlichen Tabellengrößen zunächst in beiden Spalten interpolieren, dann zwischen den Spalten. Die umgekehrte Reihenfolge liefert mit denselben vier Eckwerten dasselbe bilineare Ergebnis. Beispiel: Aufgabe „Einfache und doppelte Interpolation“.
#bild("map-quality", [Mindmap: Angaben, Phasenanteil und passende Stoffwerte zusammenführen. Eigene Darstellung.], height: 48mm)
#note("Tabellenfallen", [Einheiten angleichen: v′ kann in dm³/kg stehen, v″ in m³/kg. Enthalpie und Entropie nur aus einem einheitlichen Datensatz kombinieren. Nicht ungeprüft über Phasengrenzen interpolieren.], fill: sand)
Eine Tabellenrechnung beginnt mit zwei unabhängigen Informationen über den Zustand. Einphasig sind das häufig Druck und Temperatur. Im Nassdampf sind diese gekoppelt; dort brauchst du zusätzlich etwa den Dampfgehalt. Interpolieren schließt anschließend nur die Lücke zwischen nahen Tabellenwerten. Es ersetzt weder die Gebietsentscheidung noch eine fehlende Zustandsangabe.

#src([L 2.10, PDF-S. 43–44; V PDF-S. 61–63; Ü 1.10, PDF-S. 7; BT Tabelle 3.2, PDF-S. 82.])
#hoch(<a-2>, [Kapitelübersicht])


== 2.11 Ergänzung aus der Vorlesung bis 20.10. <a-2-11>
#heading(level: 3, outlined: false)[Wasseranomalie und Tripelpunkt]
Gewöhnliches Eis benötigt bei gleicher Masse mehr Volumen als flüssiges Wasser: Es ist weniger dicht und schwimmt. Flüssiges Wasser hat bei ungefähr Atmosphärendruck seine größte Dichte nahe 4 °C; das ist die verwandte Dichteanomalie innerhalb der Flüssigkeit.
#bild("triple", [Eis, flüssiges Wasser und Sattdampf können am Tripelpunkt zugleich im Gleichgewicht vorliegen. V, PDF-S. 68.], height: 52mm)
Wassertripelpunkt: ungefähr 0,01 °C, 273,16 K und 612 Pa. Im p-T-Diagramm ist er ein Punkt; mit zusätzlicher Volumenachse entsteht für unterschiedliche Phasenanteile eine Tripellinie.

#heading(level: 3, outlined: false)[Clapeyron: Warum eine Phasengrenze steigt oder fällt]
#bild("anomaly", [p-T-Diagramm von Wasser mit fallender Schmelzgrenze und steigender Verdampfungsgrenze. Ausschnitt V, PDF-S. 65.], height: 59mm)
#form[$ (dif p_s)/(dif T)=(Delta s)/(Delta v)=(Delta h)/(T Delta v) $]
Die Differenzen beziehen sich auf die beiden koexistierenden Phasen. Verdampfen: $Delta h>0$, $Delta v>0$; die Dampfdruckkurve steigt. Schmelzen gewöhnlichen Eises: $Delta h>0$, $Delta v<0$; die Schmelzkurve fällt im betrachteten Druckbereich. $T$ steht in Kelvin.
#bild("map-water", [Mindmap: Phasenwechsel, Volumenänderung und Steigung verknüpfen. Eigene Darstellung.], height: 48mm)
Fest → flüssig: *Schmelzen*; zurück: *Erstarren*. Fest → gasförmig: *Sublimieren*; zurück: *Desublimieren*.
Tripelpunkt und kritischer Punkt beantworten unterschiedliche Fragen. Am Tripelpunkt können drei unterscheidbare Phasen nebeneinander bestehen. Am kritischen Punkt verschwindet gerade der Unterschied zwischen Flüssigkeit und Dampf. Die Clapeyron-Gleichung verbindet dazu den Energiebedarf einer Umwandlung mit ihrer Volumenänderung und erklärt die Richtung der jeweiligen Grenzkurve.

#src([V PDF-S. 64–70; nächster Bezug in L: 2.1, PDF-S. 34, und 2.4–2.5, PDF-S. 37–39. Dichteanomalie bei 4 °C ergänzende Einordnung.])
#hoch(<a-2>, [Kapitelübersicht])


== 2.12 Ergänzung aus der Vorlesung 21.10. <a-2-12>
=== 2.12.1 Weitere Zustandsgleichungen für reale Fluide <a-2-12-1>
Der Realgasfaktor aus 2.2 beschreibt die Abweichung der thermischen Gasgleichung für *einen bestimmten Zustand*. Liegt $Z$ als Tabellenwert vor, setzt du ihn in $p v=Z R T$ ein. Für einen anderen Zustand musst du $Z$ erneut prüfen; eine einzige Zahl ist kein Stoffgesetz für alle Drücke und Temperaturen. Weitere Gleichungen bilden das reale Verhalten näherungsweise nach:
#tab(columns: (1fr, 1.5fr, 1.7fr),
 th([Gleichung], [Form], [Idee]),
 [Van der Waals], [$(p+a/v^2)(v-b)=R T$], [$a$: Anziehung zwischen den Molekülen, $b$: Eigenvolumen. $a,b,R$ je Stoff aus Tabellen. Historisch bedeutend, nützlich bei wenig Messdaten.],
 [Virialgleichung], [$p=(R T)/v+B(T)/v^2+C(T)/v^3+D(T)/v^4+...$], [Erster Term = ideales Gas; die Virialkoeffizienten $B,C,D,...$ sind empirische Korrekturen und müssen gegeben sein.],
 [Computer-Gleichungen], [z. B. IAPWS 97 für Wasser], [Industriestandard; liefert Tabellen- und Programmwerte, nicht für Handrechnung.],
)
#note("In eigenen Worten", [Die ideale Gasgleichung tut so, als wären Moleküle punktförmig und würden sich nicht anziehen. Van der Waals bessert genau diese zwei Schwächen nach: Die Anziehung „zieht“ am Druck ($a/v^2$), das Eigenvolumen nimmt Platz weg ($-b$). Je kleiner $v$ (je dichter das Gas), desto wichtiger werden beide Korrekturen.])
#note("Gültigkeit der Folienaussage", [„Weit weg vom kritischen Punkt“ ist eine Orientierung, kein alleiniger Genauigkeitstest. $Z approx 1$ bedeutet nur eine kleine Abweichung der *thermischen* Beziehung am betrachteten Zustand. Es garantiert weder ideales Verhalten entlang eines ganzen Weges noch passende ideale Energiegrößen. Van der Waals liefert laut BT ein qualitatives Bild und zahlenmäßig Näherungen.], fill: sand)
#src([N S. 1 (Folie 02 Stoffeigenschaften 24, nach der Markierung „Ende 20.10“); BT 3.6, S. 80 (Gl. 3.23) und S. 82 (Gl. 3.27), PDF-S. 100–102; Stammbaum der Zustandsgleichungen BT Abb. 3.30, S. 83.])

=== 2.12.2 Stoffgemische <a-2-12-2>
Meist liegt ein Fluid *nicht* als reiner Stoff vor, sondern als *Gemisch*, zum Beispiel Luft. Die Vorlesung nutzt dafür die Vorstellung der *Partialvolumina*:
#bild("mixing", [Zwei Gase bei gleichem Druck und gleicher Temperatur, getrennt durch eine gedachte Membran. Wird sie entfernt, entsteht das Gemisch g mit $V_A+V_B=V_g$. Ausschnitt N S. 2 (Folie 02 Stoffeigenschaften 26).], height: 50mm)
Annahmen der Folie: $p$ und $T$ bleiben konstant, ideale Gase, keine chemischen Reaktionen. Deine Randnotiz „Partialdruck → Druck sinkt“ gehört zu einer zweiten gedanklichen Betrachtung:
#tab(columns: (1fr, 1.8fr),
 th([Betrachtung], [Was hältst du gleich?]),
 [*Partialvolumen* $V_i$], [Die Komponente ist allein bei Gemischdruck $p_g$ und Temperatur $T$. Ihre Teilvolumina addieren sich zu $V_g$; auf der Folie gilt vor dem Mischen $p_A=p_B=p_g$.],
 [*Partialdruck* $p_i$], [Die Komponente ist allein im *gesamten* Gemischvolumen $V_g$ bei Temperatur $T$. Ihr Druck ist bei $0<psi_i<1$ kleiner als $p_g$; die Partialdrücke addieren sich zu $p_g$.],
)
#form[$ p_i/p_g=V_i/V_g=psi_i quad quad p_g=sum p_i $]
$p_i,p_g$ in derselben Druckeinheit; $V_i,V_g$ in derselben Volumeneinheit. *Gültigkeit:* Gemisch idealer Gase, gemeinsames $T$, Partialgrößen wie oben definiert. Beispiel: rund 21 Mol-% Sauerstoff bedeuten bei 1 bar Gemischdruck etwa 0,21 bar Sauerstoff-Partialdruck (ergänzt).
#form[$ m_g=sum m_i quad quad n_g=sum n_i quad quad xi_i=m_i/m_g quad quad psi_i=n_i/n_g quad quad sum xi_i=sum psi_i=1 $]
#form[$ m_i=n_i M_i quad quad xi_i=psi_i M_i/M_g quad quad M_g=sum psi_i M_i quad quad R_g=sum xi_i R_i quad quad 1/M_g=sum xi_i/M_i $]
$xi_i$: Massenanteil, $psi_i$: Molanteil (Stoffmengenanteil), $M$ in kg/kmol, $R$ in J/(kg K). Die Beziehungen zwischen Massen, Stoffmengen und Molmassen folgen bereits aus den Definitionen. Die Gasgleichung und die Partialdruck-/Partialvolumenbeziehung verwenden zusätzlich das ideale Gasmodell.
#tab(columns: (1fr, 1fr, 1fr, 1fr, 1fr),
 th([Gas], [$M_i$ / kg/kmol], [$R_i$ / J/(kg K)], [$xi_i$ / Massen-%], [$psi_i$ / Mol-%]),
 [O#sub[2]], [32,0], [259,8], [23,20], [20,99],
 [N#sub[2]], [28,016], [296,8], [75,47], [78,03],
 [Ar + Rest], [39,944], [208,2], [1,33], [0,98],
 [Luft], [28,964], [287,0], [100,00], [100,00],
)
#note("Fehler vermeiden", [Luft enthält *23 Massen-%* oder *21 Mol-%* Sauerstoff. Eine Prozentangabe braucht immer ihre Bezugsgröße. Deine Notiz dazu: 100 kg + 50 kg ergeben Massenanteile 2/3 und 1/3; sind es zugleich gleich viele kmol (Molmasse doppelt so groß), sind die Molanteile 50 % und 50 %.], fill: sand)
#note("Quellen vergleichen", [Im Thermo-Buch sind in Gl. (3.30) und (3.31) die Zeichen vertauscht ($psi_i=m_i/m_g$, $xi_i=n_i/n_g$). Die Umrechnung (3.34) $xi_i=psi_i M_i/M_g$ und Beispiel 3.9 passen aber zur Folie: $xi$ = Massenanteil, $psi$ = Molanteil. Wir verwenden die Bedeutung der Folie.], fill: sand)
#bild("map-mix", [Mindmap: Mengen, Anteile und Gemischgrößen. Eigene Darstellung.], height: 46mm)
Ein Gemisch wird wie ein „Ersatzstoff“ behandelt: Kennt man die Anteile, ergeben sich eine scheinbare Molmasse $M_g$ und eine Gaskonstante $R_g$. Damit gilt für ein Gemisch idealer Gase wieder $p V=m_g R_g T$. Für Luft ist das genau der bekannte Wert $R approx 287 thin "J/(kg K)"$.
#src([N S. 2 (Folie 02 Stoffeigenschaften 26) mit Randnotizen; BT 3.7, S. 83–85 (Gl. 3.28–3.35, Beispiel 3.9), PDF-S. 103–105; Partialgrößen ergänzend erklärt nach BT 8.1–8.2, S. 240–243, PDF-S. 258–261. Ab Folie 27 nicht behandelt (N S. 3, Trennblatt).])
#hoch(<a-2>, [Kapitelübersicht])

#pagebreak(weak: true)
=== 2.12.3 Reduzierte Zustände, kritische Anpassung und Berthelot <a-2-12-3>
Ein allgemeines Realgasdiagramm ordnet ähnliche Stoffzustände über $p_r=p/p_"kr"$ und $T_r=T/T_"kr"$ zu. Z wird dann für diese reduzierten Koordinaten und den richtigen Stoff abgelesen. Diagramm, stoffeigene Tabelle und Zustandsgleichung sind verschiedene Genauigkeitsstufen; ihre Zahlen müssen nicht bis zur letzten Stelle übereinstimmen.
#bild("vdw-kritische-isotherme", [Kritische und überkritische Modellisotherme nach Van der Waals. Eigene Darstellung; Ü1.12.], height: 64mm)
Am kritischen Punkt hat die Modellisotherme eine waagerechte Wendestelle: $(partial p/partial v)_T=0$ und $(partial^2p/partial v^2)_T=0$. Für Van der Waals folgt:
#form[$ v_"kr"=3b quad a=3p_"kr" v_"kr"^2 quad R_"fit"=frac(8p_"kr"v_"kr",3T_"kr") $]
Diese Anpassung an alle drei kritischen Daten lässt R als Modellparameter frei. Das physikalische R bleibt dagegen $R_m/M$. Weil Van der Waals $Z_"kr"=3/8$ erzwingt, kann man nicht beliebige drei kritische Messwerte und das physikalische R zugleich mit nur a und b exakt erfüllen. Eine abweichende Anpassung ist eine Modellgrenze, keine Änderung der universellen Gaskonstante.
Die *Berthelot-Gleichung* macht den Anziehungsterm zusätzlich temperaturabhängig:
#form[$ p=frac(R T,v-b)-frac(a,T v^2) $
$ (frac(partial p,partial T))_v=frac(R,v-b)+frac(a,T^2v^2) quad (frac(partial p,partial v))_T=-frac(R T,(v-b)^2)+frac(2a,T v^3) $]
Das totale Differential ist $dif p=(partial p/partial v)_T dif v+(partial p/partial T)_v dif T$. Die Vertauschbarkeit der gemischten zweiten Ableitungen wird in einem glatten Gebiet geprüft; die Singularitäten v=0 und v=b gehören nicht dazu. Physikalische Phasenstabilität ist zusätzlich zu prüfen und folgt nicht schon aus einer formal glatten Funktion.

=== 2.12.4 Spannungskoeffizient und Kompressibilität <a-2-12-4>
#form[$ beta_v=frac(1,p)(frac(partial p,partial T))_v quad chi_T=-frac(1,v)(frac(partial v,partial p))_T=-frac(1,v(partial p/partial v)_T) $]
βv beschreibt die relative Druckänderung beim Erwärmen mit festem Volumen, χT die relative Volumenabnahme bei isothermer Druckerhöhung. βv hat die Einheit1/K, χT die Einheit1/Pa. Beim idealen Gas sind βv=1/T und χT=1/p. Ein Stoffmodell muss zuerst zu dem betrachteten Zustand passen.
Die Berthelot-Gleichung muss für χT nicht vollständig kubisch nach v aufgelöst werden, *wenn v bereits bekannt ist*: Dann wird die oben genannte Ableitung direkt eingesetzt und invertiert. Sind nur p und T bekannt, muss zunächst die passende physikalische Volumenlösung gefunden werden. Diese Unterscheidung präzisiert die Frage nach der „schwierigen“ direkten Auflösung in Ü1.13e.
Die isobare relative Volumenausdehnung $alpha_v=(partial v/partial T)_p/v$ erfüllt $alpha_v=p beta_v chi_T$ und $dif v/v=alpha_v dif T-chi_T dif p$. Diese Größen sind lokale Ableitungen; ein konstanter Zahlenwert über einen großen Bereich ist eine weitere Näherung.
#src[Ü1.11–1.13, PDF-S.8–9; kritische Bedingungen und Berthelot-Differential direkt aus den Aufgaben. Koeffizientenbeziehung eigene implizite Ableitung.]

=== 2.12.5 Empirische Wasserdampfgleichung nach Koch <a-2-12-5>
Die in Ü1.11 mitgegebene Koch-Beziehung ist ein empirischer Handrechenvergleich zur Dampftafel, kein allgemeines Naturgesetz:
#form[$ v=frac(R T,p)-frac(A,theta^"2,82")-p^2(frac(B,theta^14)+frac(C,theta^"31,6")) quad theta=T/(100 thin "K") $]
Der Druck wird hier in Pa, T in K und v in m³/kg eingesetzt. Für die ausdrücklich mitgelieferten Parameter gelten A=0,9172m³/kg, B=1,3609·10⁻⁶m³/(kgPa²), C=4,5534·10⁵m³/(kgPa²). Andere Einheiten verändern die Koeffizienten. Die Aufgaben vergleichen diese Näherung mit den vorgegebenen Tabellenzuständen; sie ist nicht ungeprüft in Flüssigkeits- oder andere Temperatur-/Druckbereiche zu extrapolieren.
#src[Ü1.11, PDF-S.8–9, Koch-Gleichung und dortige Parameter; Vergleich mit Dampftafel und Z-Modellen.]
#hoch(<a-2>, [Kapitelübersicht])


== 2.13 Ergänzung aus Tutorium und WZF 22.–23.10. <a-2-13>
Die neuen Übungen verbinden Tabellenlesen und Bilanzen. Drei Fragen steuern den Rechenweg: *In welchem Gebiet liegt der Stoff? Welche Bezugsgröße ist gemeint? Was bleibt im Prozess wirklich konstant?*

=== 2.13.1 Tabellenrichtung und rückwärtige Interpolation <a-2-13-1>
Eine *Sättigungstafel* nennt Strichwerte bei zusammengehörigem $p$ und $T_s$. Eine Tabelle für *einphasige* Zustände verwendet etwa $p$ und $T$ als unabhängige Angaben. Erst die Gebietsentscheidung, dann die passende Tabellenzeile: So beginnt das Tutorium vom 22.10.
#tab(columns: (1fr, 2fr),
 th([Gegebener Zustand], [Passende Tabelle]),
 [Sättigung, etwa $p$ und $x$], [Sättigungszeile und Mischungsregel. Nur $p,T_s$ legen $x$ noch nicht fest.],
 [Einphasig, etwa $p,T$], [Tabelle für überhitzten Dampf beziehungsweise unterkühlte Flüssigkeit. Werte im gleichen Gebiet interpolieren.],
)
Beim *rückwärtigen Interpolieren* ist der Stoffwert bekannt, die Temperatur wird gesucht. Du vertauschst dafür die Rolle von Eingabe und Ausgabe, nicht die physikalischen Größen.
#bild("interpolation-invers", [Rückwärtige Interpolation in Ü 1.10 b bei 1200 kPa. Eigene Darstellung nach T22, PDF-S. 2.], height: 55mm)
#form[$ vartheta=vartheta_1+frac(v-v_1, v_2-v_1)(vartheta_2-vartheta_1) $]
$v,v_1,v_2$ in m³/kg; $vartheta$ hier in °C. *Voraussetzung:* nahe Tabellenpunkte bei demselben Druck und im selben Zustandsgebiet; lineare Näherung. Bei $v="0,02300" thin "m"^3/"kg"$ zwischen $"0,02245"$ (100 °C) und $"0,02335"$ (110 °C) folgt *$vartheta approx "106,11" thin "°C"$*.
#note("Deine Tutoriumsnotiz", [Bei Ü 1.10 c steht „wird so nie drankommen“. Das bleibt als Hinweis aus T22 sichtbar. Es ist keine belegte Festlegung des aktuellen Prüfungsumfangs; die vorhandene Rechnung zur doppelten Interpolation bleibt als Verständnisbeispiel erhalten.], fill: sand)
#bild("map-tabellenmodell", [Mindmap: Zustand, Bezugsgröße, Tabellenwert und Bilanz verknüpfen. Eigene Darstellung.], height: 43mm)
#src[T22, PDF-S. 1–2; Ü 1.10, PDF-S. 7; passende Tabellen und Mischungsregel ergänzend BT 3.4, S. 61–65 / PDF-S. 81–85.]

=== 2.13.2 Stickstoffgefäß: Aufheizen und Entnehmen unterscheiden <a-2-13-2>
Wie bei einer Druckkanne erzeugt Verdampfen den Druck, der Flüssigkeit durch die Leitung hebt. Die Aufgabe betrachtet aber *verschiedene Prozesse*: Vor dem Austritt bleibt die Masse im Gefäß; beim Entnehmen sinkt sie.
#bild("stickstoff-zustaende", [Zustände ①–③ aus Ü 2.1. Eigene schematische Darstellung nach W23, PDF-S. 1–2, und M2, PDF-S. 1–2; nicht maßstäblich.], height: 55mm)
#tab(columns: (0.6fr, 1fr, 1fr, 1.6fr),
 th([Weg], [System], [Konstant], [Was ändert sich?]),
 [① → ②], [geschlossen], [$V,m$; daher $v=V/m$], [$p$ steigt von 1 auf etwa 1,4 bar; $T_s$ und die Phasenanteile ändern sich.],
 [② → ③], [offen, instationär], [$V,p$; daher $T_s$], [1 kg Flüssigkeit tritt aus. $m$ sinkt und $v=V/m$ wächst. Ein kleiner Teil verdampft.],
)
#bild("stickstoff-pv", [Weg im p-v-Diagramm. Eigene schematische Darstellung nach W23, PDF-S. 2; keine maßstäbliche Stoffwertkurve.], height: 48mm)
*Vorgegebene Stoffwerte* (gedruckte Stickstofftabelle aus Ü 2.1):
#tab(columns: (0.5fr, 0.7fr, 1fr, 0.9fr, 0.8fr, 0.8fr),
 th([$p$ / bar], [$T$ / K], [$v'$ / m³/kg], [$v''$ / m³/kg], [$h'$ / kJ/kg], [$h''$ / kJ/kg]),
 [1,0], [77,24], [0,0012398], [0,21947], [−122,25], [77,073],
 [1,4], [80,21], [0,0012611], [0,16082], [−116,15], [79,245],
)
Bei 1,4 bar sind außerdem $s'="2,9081"$ und $s''="5,3442" thin "kJ/(kg K)"$ vorgegeben. Negative Enthalpiewerte stammen aus dem Tabellen-Bezugsnullpunkt; für eine Bilanz müssen alle Werte aus demselben Datensatz kommen.

#heading(level: 3, outlined: false)[Warum mehr Flüssigkeit verschwindet, als entnommen wird]
Bei gleichem $p$ bleiben die Sättigungswerte $v',v''$ konstant. Die beiden extensiven Bilanzen lauten mit $Delta m=m_3-m_2$:
#form[$ Delta m'+Delta m''=Delta m quad "und" quad v' Delta m'+v'' Delta m''=Delta V=0 $]
Aus $Delta m'=Delta m-Delta m''$ folgt:
#form[$ Delta m''=frac(-v' Delta m, v''-v')=frac(v' m_"entn", v''-v') $]
$Delta m''$ ist die *Zunahme der Dampfmasse* in kg; $m_"entn">0$ die nach außen abgegebene Flüssigkeitsmasse. Es gilt $Delta m=-m_"entn"$. Die verdampfte Masse bleibt im Gefäß und beansprucht den frei werdenden Raum.
#note("Fehler vermeiden", [„Starrer Behälter“ bedeutet hier $V$ konstant. Beim Austritt von Masse bleibt $v=V/m$ gerade *nicht* konstant. Ebenso ist der Dampfgehalt $x$ ein Massenanteil; der Dampfvolumenanteil $mu=x v''/v$ ist eine andere Zahl.], fill: sand)
#src[W23, PDF-S. 1–2; M2, PDF-S. 1–2; Ü 2.1 mit Originaltabelle, PDF-S. 11; BT 3.4, Gl. (3.10)–(3.14), S. 60–62 / PDF-S. 80–82. Bezugsnullpunkt: BT 4.4, S. 108–109 / PDF-S. 128–129.]

=== 2.13.3 Verdampfer: Stoffwerte in Energieströme übersetzen <a-2-13-3>
Der Verdampfer aus Ü 1.14 erhält ständig dieselbe Masse pro Sekunde. Das Verdampfen verändert aber Volumenstrom, Geschwindigkeit und die mitgeführten Energiegrößen. Die neue Musterlösung ergänzt die bisher behandelten Teilaufgaben um $h,u,s$ und die Phasenströme.
#bild("verdampfer-stroeme", [R134a-Verdampfer nach Ü 1.14 und M1, PDF-S. 1–2. Eigene Darstellung; nicht maßstäblich.], height: 52mm)
*M1 gibt für den Austritt bei 164,2 kPa näherungsweise vor:*
#tab(columns: (1fr, 1fr, 1fr, 1fr),
 th([Stoffwert], [Einheit], [Flüssig, Strich], [Dampf, Doppelstrich]),
 [$v$], [m³/kg], [0,0007], [0,1205],
 [$h$], [kJ/kg], [180,25], [389,83],
 [$s$], [kJ/(kg K)], [0,9259], [1,73787],
)
Die Mischungsregel gilt jeweils für die *spezifischen* Werte. Erst danach macht $dot(m)$ daraus einen Strom:
#form[$ h=h'+x(h''-h') quad s=s'+x(s''-s') quad u=h-p v $]
#form[$ dot(H)=dot(m)h quad dot(S)=dot(m)s quad dot(H)'=dot(m)(1-x)h' quad dot(H)''=dot(m)x h'' $]
$dot(H)$ in kW, $dot(S)$ in kW/K, wenn $dot(m)$ in kg/s, $h$ in kJ/kg und $s$ in kJ/(kg K) stehen. Für $u=h-p v$: kPa·m³/kg = kJ/kg. *Gültigkeit:* zwei Phasen im selben Sättigungszustand; stationäre Phasenmassenströme mit bekanntem Dampfgehalt.
#note("Zustandsgebiet vor Interpolation", [Am Eintritt gilt $p_1="164,2"$ kPa und $vartheta_1=-20$ °C. Die Sättigungstemperatur liegt bei etwa −14,96 °C: Der Eintritt ist unterkühlte Flüssigkeit. Der Wert $v_1 approx "0,0007"$ m³/kg ist dafür eine Flüssigkeitsnäherung; die Sättigungstafel wird nicht mit einer idealen Gasgleichung ersetzt.], fill: sand)
#note("Musterlösung prüfen", [In M1 steht in der Enthalpierechnung einmal 389,9 statt des Tabellenwerts 389,83 kJ/kg. Wir rechnen durchgängig mit 389,83. Kleine Abweichungen bei $u$ entstehen zusätzlich durch das vorzeitige Runden von $v$. Die Kontrolle $dot(H)=dot(H)'+dot(H)''$ muss mit ungerundeten Zwischenwerten stimmen.], fill: sand)
#src[M1, PDF-S. 1–3; Ü 1.14, PDF-S. 10; BT 3.4, Beispiel 3.4, S. 64–65 / PDF-S. 84–85, und 4.4, Gl. (4.46), (4.49), S. 108 / PDF-S. 128. Tabellenwerte und Rundung nach M1; eigene Nachrechnung.]

#pagebreak()
== 2.14 Ergänzung 30.10. · Drei Phasen im starren Gefäß <a-2-14>
Ein Gemisch aus Eis, flüssigem Wasser und Wasserdampf kann trotz Wärmezufuhr zunächst dieselbe Temperatur behalten. Die zugeführte Energie verändert dann die *Phasenanteile*. Alle drei Phasen befinden sich im *Tripelgleichgewicht*: bei Wasser $T_"Tr"="273,16"$ K und $p_"Tr"="611,66"$ Pa.
#bild("tripel-isochor", [Weg von Ü 2.13. Eigene schematische Darstellung nach R30, PDF-S. 3–4, und M13, PDF-S. 1 und 4–5; keine maßstäblichen Phasengrenzen.], height: 58mm)

=== 2.14.1 Derselbe Diagrammpunkt kann andere Phasenanteile enthalten <a-2-14-1>
Im geschlossenen starren Gefäß bleiben $m,V$ und damit $v=V/m$ konstant. Solange noch Eis, Wasser und Dampf vorhanden sind, bleiben auch $p$ und $T$ auf ihren Tripelwerten. Die Zustände ① und ② am Ende des Schmelzens haben daher *dieselben Koordinaten* im p-v- und p-T-Diagramm; ihre Phasenanteile unterscheiden sich trotzdem.
Erst wenn das Eis vollständig verschwunden ist, verlässt weitere Erwärmung den Tripelzustand. Im p-v-Diagramm steigt der Druck bei festem $v$ senkrecht an; im p-T-Diagramm folgt der Zustand der Flüssig-Dampf-Grenze. Die gegebenen Phasenanteile führen im Beispiel zunächst in das Nassdampfgebiet.
#form[$ m=m'+m''+m''' quad V=m'v'+m''v''+m'''v''' quad H=m'h'+m''h''+m'''h''' $]
Strich: Flüssigkeit, Doppelstrich: Dampf, Dreifachstrich: Eis. Die Gesamtgrößen werden addiert. Bei drei Phasen reichen die zwei Gewichte $1-x$ und $x$ der üblichen Nassdampfregel nicht aus.
#src[R30, PDF-S. 3–4; M13, PDF-S. 1–2 und 5; Ü 2.13, PDF-S. 16; BT 3.5, S. 72–74 / PDF-S. 92–94. Diagrammüberlagerung und Abgrenzung der Zweiphasenregel: ergänzte Einordnung.]

#pagebreak()
=== 2.14.2 Wärme verändert U; Tabellenwerte brauchen denselben Bezug <a-2-14-2>
Ohne äußere Bewegung, Höhenänderung und weitere Arbeit gilt wegen der starren Grenze:
#form[$ Q_12=U_2-U_1 quad Delta t=frac(Q_12,dot(Q)) quad U=H-p V $]
$Q,U,H$ in J, $dot(Q)$ in W ergeben Sekunden; bei kJ ist passend kW zu verwenden. Vor Zustand ② müssen die neuen Flüssigkeits- und Dampfmassen aus *Massen- und Volumenbilanz* bestimmt werden. Die anfänglichen Teilmassen bleiben beim Schmelzen nicht unverändert.
#note("Tabellen konsistent verwenden", [Ü 2.13 gibt stark gerundete $u$- und $h$-Werte an. Für die Musterrechnung werden die angegebenen $h$- und $v$-Werte verwendet und $U=H-p V$ durchgängig gebildet. Ein negatives $H$ oder $U$ ist mit dem gewählten Tripel-Bezugszustand vereinbar; benötigt wird die Energiedifferenz.], fill: sand)
Die dortige lineare Abschätzung des späteren Dampfdrucks benutzt die *Clapeyron-Steigung* am Tripelpunkt:
#form[$ frac(dif p_s,dif T)=frac(s''-s',v''-v') quad p_3 approx p_"Tr"+(frac(dif p_s,dif T))_"Tr" dot (T_3-T_"Tr") $]
Mit $s$ in J/(kg K) und $v$ in m³/kg ergibt sich Pa/K. Die konstante Steigung ist die ausdrücklich vorgegebene lokale Näherung der Aufgabe; sie ersetzt keine genaue Dampftafel über große Temperaturbereiche.
#bild("map-tripel", [Mindmap: Phasenanteile, Gesamtgrößen und Energie im Tripelgefäß. Eigene Darstellung.], height: 45mm)
#note("Abgleich mit der neuen Musterlösung Ü 2.11", [M211 verwendet andere Anfangsmengen und 10 W statt 1 W. Der Rechenweg bleibt gleich. Solange der geschlossene starre Inhalt am Tripelpunkt bleibt, sind *p und V zugleich konstant*: $Delta U=Delta H$ und daher hier auch $Q=Delta H$. Das folgt aus $U=H-p V$; starres V allein würde dafür nicht genügen. Beide Aufgaben stehen mit ihren eigenen Daten und vollständigen Lösungen auf der Lernplattform.], fill: sand)
#src[R30, PDF-S. 3–4; M13, PDF-S. 2–4; M211, PDF-S. 1; Ü 2.11 / 2.13, PDF-S. 15–16; BT 3.5, S. 72–74 / PDF-S. 92–94. Energiebezug und Rundungsstrategie ausdrücklich ergänzt.]
#hoch(<a-2>, [Kapitelübersicht])

#pagebreak()
== 2.15 Ergänzung Tutorium 29.10. · Dampfleitung, Trommel und Überhitzer <a-2-15>
Dieselben Dampftafeln beantworten drei verschiedene Fragen: Wie viel Raum beansprucht der Stoffstrom, wie verteilt sich die gespeicherte Masse und welchen Weg nimmt ein abgesperrter Inhalt beim Heizen? Die *Randbedingung* entscheidet, welche Rechnung passt.

=== 2.15.1 Dampfleitung: erst den realen Stoffwert, dann den Querschnitt <a-2-15-1>
Für einen stationären Strom mit mittlerer Geschwindigkeit $c$ gilt:
#form[$ dot(m)=rho A c=frac(A c,v) quad d=sqrt(frac(4 dot(m)v,pi c)) $]
$dot(m)$ in kg/s, $v$ in m³/kg und $c$ in m/s liefern $d$ in m. Das spezifische Volumen wird zum gegebenen *Druck und zur Temperatur* aus der Überhitzungstafel gelesen. Der Massenstrom allein legt den Rohrdurchmesser nicht fest.
#src[T29, PDF-S. 1; Ü 2.15, PDF-S. 17; BT A.8, S. 492 / PDF-S. 507.]

=== 2.15.2 Gleiche Phasenvolumina bedeuten verschiedene Phasenmassen <a-2-15-2>
#bild("dampftrommel-anteile", [Je die Hälfte einer 8-m³-Trommel. Eigene Darstellung nach T29, PDF-S. 2–3.], height: 50mm)
Die Flüssigkeit ist viel dichter als der Dampf. Deshalb enthält die volumetrisch halb gefüllte Trommel überwiegend *Flüssigkeitsmasse*. Der Rechenweg bleibt eindeutig:
#form[$ m'=frac(V',v') quad m''=frac(V'',v'') quad x=frac(m'',m'+m'') quad H=m'h'+m''h'' $]
Die 50 % Dampfvolumen in Ü 2.16 entsprechen nur etwa 3,158 % Dampfmasse. $h'$ und $h''$ müssen zu derselben Sättigung gehören; spezifische Enthalpien werden nicht einfach addiert.
#note("Abgleich mit der Mitschrift", [T29, PDF-S. 3, nennt für $h'$ korrekt 1155 kJ/kg, schreibt im nachfolgenden Produkt einmal 1150. Die Rechnung verwendet den Tabellenwert 1155; der notierte Ergebnisbereich von etwa 3,876 GJ passt dazu.], fill: sand)
#src[T29, PDF-S. 2–3; Ü 2.16, PDF-S. 17. Flüssigkeitsvolumen nach der im Tutorium gezeigten Interpolation; Datensatz nicht mit anderen Tabellen gerundet vermischt.]

=== 2.15.3 Abgesperrter Überhitzer: zwei Füllungen, zwei Isochoren <a-2-15-3>
#bild("ueberhitzer-wege", [Zwei Anfangsfüllungen α und β aus Ü 2.17. Eigene schematische Darstellung nach T29, PDF-S. 3–5; nicht maßstäblich.], height: 57mm)
Nach dem Absperren bleiben Masse und Gesamtvolumen fest. Unterschiedliche Anfangs-Dampfgehalte liefern daher *unterschiedliche spezifische Volumina* und verschiedene Isochoren. „Gerade Sattdampf“ bedeutet: Die jeweilige Isochore trifft die Sattdampflinie $v''(p_2)=v_1$.
Im überhitzten Gebiet wird anschließend bei bekanntem $v,T$ rückwärts der Druck oder bei bekanntem $v,p$ die Temperatur gesucht. Für die starre Erwärmung bleibt die Energiebilanz $Q_14=m(u_4-u_1)$; mit $u=h-p v$:
#form[$ Q_14=m[(h_4-h_1)-v(p_4-p_1)] $]
$p$ in kPa und $v$ in m³/kg liefern kJ/kg. Der Druck-Volumen-Term verschwindet nicht, nur weil das *Volumen* konstant ist: Der Druck ändert sich.
#note("Tabellengrenze und Ergebnisprüfung", [Für Fall β liegt die Ventilöffnung bei 25 bar außerhalb der im Tutorium gezeigten Überhitzungstabelle; eine belastbare Öffnungstemperatur wird daraus nicht extrapoliert. Bei den Wärmemengen verwendet die ergänzte Lösung getrennte Endenthalpien für α und β. Der notierte β-Wert 252,23 kJ stimmt damit nicht überein; aus den mitgegebenen Tabellen folgt rund 258,23 kJ.], fill: sand)
Der Weg bis 600 °C ist als *hypothetisch geschlossene Isochore* zu lesen. Öffnet das Sicherheitsventil vorher, ändern sich Masse und Bilanz; die Rechnung darf dann nicht als tatsächlicher Entlastungsvorgang ausgegeben werden.
#src[T29, PDF-S. 3–7; Ü 2.17, PDF-S. 17; eigene Nachrechnung mit den dortigen Tabellen und ausgewiesenen Rundungen.]

*Der Zusammenhang in Kapitel 2.* Zuerst wird das Zustandsgebiet erkannt. Einphasig nutzt du das passende Stoffmodell oder eine p-T-Tabelle; im Nassdampf die Sättigungswerte und einen zusätzlichen Phasenanteil. Danach werden Stoffwerte in die Massen- und Energiebilanz eingesetzt. Der Vergleich von Verdampfer und Entnahmebehälter zeigt, wann ein Massenstrom konstant bleibt und wann sich der Bestand ändert. Die Darstellung im Diagramm hilft, den Rechenweg zu prüfen. Das Tripelgefäß ergänzt drei Phasen; die Trommel trennt Volumen- und Massenanteile, der Überhitzer zeigt die Wirkung verschiedener Isochoren.
#hoch(<a-2>, [Kapitelübersicht])


#pagebreak(weak: true)
= Kapitel 3 · Energiebilanzen: Erster Hauptsatz <a-3>

#überblick([Kapitel 3 auf einen Blick],
 idee(<a-3-1>, [Systemart und Speicherung zuerst.], [Offene Ströme tragen Enthalpie; #link(<a-3-2>)[Flüssigkeitsentnahme] und #link(<a-3-12>)[Dampfaustritt] behalten den Speicherterm.]),
 idee(<a-3-4>, [Arbeitsform und Weg gehören zusammen.], [Volumen-, #link(<a-3-5>)[Druck-] und #link(<a-3-7>)[Gaswechselarbeit] haben passende Voraussetzungen.]),
 idee(<a-3-8>, [Stoffwerte schließen die Bilanz.], [#link(<a-3-6>)[U und H] brauchen ein Stoffmodell; Wärmekapazitäten einen Mengen- und Temperaturbezug.]),
 idee(<a-3-9>, [Ein Kreis hat keinen bleibenden Zustandszuwachs.], [Netto-Wärme und Netto-Arbeit können trotzdem übertragen werden.]),
 idee(<a-3-10>, [Düse und Drossel vereinfachen verschieden.], [Geschwindigkeit, Enthalpie und Druck folgen jeweils den getroffenen Annahmen.]),
 idee(<a-3-11>, [Die Gesamtgrenze entfernt interne Ströme.], [#link(<a-3-3>)[Anlagenbauteile] und mehrere Stoffströme werden über extensive Leistungen verbunden.]),
)

#ablauf(
  chunk([System und Zustände festlegen], [Grenze · Zeitpunkte oder Ein- und Austritt], ziel: <a-3-1>),
  entscheidung([Strömt Stoff über die Grenze?],
    chunk([Offene Bilanz], [Enthalpieströme · Speicherterm auf Stationarität prüfen], ziel: <a-3-1-1>),
    chunk([Geschlossene Bilanz], [gespeicherte Energie · Wärme · Gesamtarbeit], ziel: <a-3-1-2>)),
  chunk([Annahmen und Stoffwerte einsetzen], [erst vollständige Bilanz, dann begründet vereinfachen], ziel: <a-3-1-3>),
  chunk([Prozessweg und Arbeitsform prüfen], [Druckverlauf · Verschiebearbeit · Wärmeannahme], ziel: <a-3-4>),
  chunk([Ergebnis prüfen], [Vorzeichen · Einheit · Bezugsgröße · Plausibilität], ziel: <a-3-7>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])


Kapitel 1 hat die Bilanzhülle und die Prozessgrößen eingeführt, Kapitel 2 die Stoffwerte. Der erste Hauptsatz (1. HS) verbindet beides: Er sagt, wie viel sich die Energie eines Systems ändert, wenn Wärme und Arbeit über seine Grenze fließen. Im Buch ist das Kapitel 4.

== 3.1 Erster Hauptsatz: die Energiebilanz <a-3-1>
#bild("hs-overview", [Links ein offenes, stationär durchströmtes System (Brennkammer), rechts ein geschlossenes System (Zylinder). Ausschnitt N S. 5 (Folie 03 Erster Hauptsatz 2).], height: 80mm)
Die Folie stellt die beiden Grundfälle nebeneinander. *Offen:* Stoff strömt bei ① *örtlich vorher* ein und bei ② *örtlich nachher* aus; der innere Aufbau interessiert nicht. *Geschlossen:* Dieselbe Masse ist ① *zeitlich vorher* und ② *zeitlich nachher* im Zylinder.
#note("Dein Feynman-Schritt", [Stell dir einen Teich vor. Wasser fließt durch Bäche zu und ab (das sind Wärme und Arbeit), der Wasserstand ist die gespeicherte Energie. Der Teich weiß nicht, aus welchem Bach sein Wasser kam: Ist es einmal drin, ist es einfach Energie. Erkläre damit in zwei Sätzen, warum $Q$ und $W$ keine Zustandsgrößen sind.])
- *Zustandsgrößen* ($p, v, T, u, h, s, c, z$) beschreiben den Zustand an ① und ②. Deine Notiz: Zustandsgrößen sind *wegunabhängig*. Große Änderungen schreibt man $Delta p_12=p_2-p_1$, kleine $dif p, dif T, dif U$.
- *Prozessgrößen* (Arbeit, Wärme) bewirken die Zustandsänderung. Sie sind nur während des Prozesses da: endlicher Betrag $Q_12=m q_12$, $W_12=m w_12$; unendlich kleiner Betrag $delta Q$, $delta W$ (Folie: $dif Q$, $dif W_g$).
- *Kein Punkt* auf $Q_12$ in der geschlossenen Bilanz zwischen zwei Zeitpunkten (Notiz auf der Folie): $Q_12$ ist eine Energiemenge in kJ. Die offen-stationäre Bilanz betrachtet dagegen Ströme: $dot(Q)_12=dot(m) q_12$ und $P=dot(m) w_(t,12)$ in kW. Ein Wärmestrom $dot(Q)$ lässt sich auch bei einem geschlossenen System definieren; der Punkt bezeichnet den Zeitbezug, nicht die Systemart.
- *Vorzeichen:* zugeführte Wärme und Arbeit positiv, abgeführte negativ (Zufuhrkonvention wie in Kapitel 1).
#src([N S. 5 (Folie 03 Erster Hauptsatz 2) und S. 6 (Randnotiz); BT 4.1, S. 92–94, Teich-Analogie Abb. 4.7, S. 97 (PDF-S. 112–117).])

=== 3.1.1 Offenes, stationär durchströmtes System <a-3-1-1>
#bild("hs-open", [Offenes System mit Ein- und Austritt, Arbeit $P$ und Wärme $dot(Q)_12$. Ausschnitt N S. 6 (Folie 03 Erster Hauptsatz 3).], height: 78mm)
Instationär ändert sich die *gesamte gespeicherte Energie* um die Nettosumme der Energieströme:
$ (dif E_"sys")/(dif t)=dot(E)_1-dot(E)_2+dot(Q)_12+P $
$E_"sys"=U_"sys"+E_"kin,sys"+E_"pot,sys"$. N S. 6 schreibt links nur $U_"sys"$; das setzt vernachlässigbare Änderungen der gespeicherten äußeren Energien voraus. *Stationär* sind alle Speicheränderungen null und $dot(m)_1=dot(m)_2=dot(m)$ (ein Ein- und Austritt). Die mit einem Stoffstrom transportierte Energie einschließlich Verschiebearbeit ist:
$ e=h+c^2/2+g z quad "mit" quad h=u+p v $
#note("In eigenen Worten", [Warum steht hier $h$ und nicht $u$? Um Stoff in das System hineinzuschieben, muss der nachfolgende Stoff Arbeit leisten: die *Einströmarbeit* (Verschiebearbeit) $p_1 v_1$. Beim Austritt wird $p_2 v_2$ als Ausströmarbeit abgegeben. Die Enthalpie $h=u+p v$ packt diese Verschiebearbeit gleich mit in die Stoffenergie.])
#form[$ (h_2-h_1)+(c_2^2-c_1^2)/2+g(z_2-z_1)=q_12+w_(t,12) $
$ dot(H)_2-dot(H)_1+dot(m)[(c_2^2-c_1^2)/2+g(z_2-z_1)]=dot(Q)_12+P_12 $]
*Einheiten:* spezifisch J/kg oder einheitlich kJ/kg; Ströme entsprechend W oder kW. Mit $c$ in m/s, $z$ in m und $g$ in m/s² ergeben $c^2/2$ und $g z$ zunächst *J/kg*. Für eine Bilanz in kJ/kg teilst du diese Zahlenwerte durch 1000. $dot(m)$ steht in kg/s.
Links stehen die Änderungen der Zustandsgrößen (innere: Enthalpie; äußere: Bewegungs- und Lageenergie), rechts die Prozessgrößen: *Σ Änderung Zustandsgrößen = Σ Prozessgrößen*. $w_(t,12)$ heißt *technische Arbeit*; im Turbomaschinenbau auch *spezifische Stutzenarbeit* $Y_12$.

*Aufschlüsselung der technischen Arbeit* (ausgeführt in Abschnitt 3.5):
$ w_(t,12)=j_12+w_(p 12)+(c_2^2-c_1^2)/2+g(z_2-z_1) quad "mit" quad w_(p 12)=integral_1^2 v dif p $
$j_12$: spezifische Streu- oder *Dissipationsarbeit* (von dir markiert), $w_(p 12)$: spezifische *Druckarbeit*, dazu Beschleunigungs- und Hubarbeit.
#src([N S. 6–7 (Folie 03 Erster Hauptsatz 3–4); BT 4.1, Gl. (4.2), (4.3) und (4.9), S. 92–93, sowie 4.2, Gl. (4.32), S. 103 (PDF-S. 112–113 und 123). Speicherpräzisierung und Einheitenhinweis: ergänzte Einordnung.])

=== 3.1.2 Geschlossenes System <a-3-1-2>
#bild("hs-closed", [Geschlossenes System: Kolben von Zustand ① nach ②, dazwischen kleine Änderungen $dif v$, $dif q$, $dif w_g$. Ausschnitt N S. 8 (Folie 03 Erster Hauptsatz 5).], height: 75mm)
Kein Massenaustausch über die Grenze, also auch keine Ein- und Ausströmarbeit. Darum steht hier die *innere Energie* $u$. Differenziell gilt $dif E=delta Q+delta W_g$ mit $dif e=dif u+c dif c+g dif z$; integriert:
#form[$ (u_2-u_1)+(c_2^2-c_1^2)/2+g(z_2-z_1)=q_12+w_(g,12) $
$ U_2-U_1+m[(c_2^2-c_1^2)/2+g(z_2-z_1)]=Q_12+W_(g,12) $]
*Einheiten:* spezifisch J/kg oder einheitlich kJ/kg; mit $m$ in kg erhältst du J beziehungsweise kJ. Die Umrechnung der äußeren Energiebeiträge gilt wie in 3.1.1. $c$ bezeichnet hier die Bewegung des gesamten Systems, nicht die ungeordnete Teilchenbewegung im Stoff.
$W_(g,12)$ ist die *Gesamtarbeit* (Index g wird oft weggelassen). $c$ ist die Geschwindigkeit des bewegten Zylinders. Aufgeschlüsselt:
$ w_(g,12)=j_12+w_(v 12)+(c_2^2-c_1^2)/2+g(z_2-z_1) quad "mit" quad w_(v 12)=-integral_1^2 p dif v $
#note("Achtung! Minuszeichen bei der Volumenarbeit", [Deine Notiz: Bei Kompression wird $dif v$ negativ. Das Minus sorgt dafür, dass die *zugeführte* Arbeit trotzdem positiv herauskommt (Zufuhrkonvention). Expandiert das Gas, gibt es Arbeit ab: $w_v<0$.], fill: sand)
#note("Fehler vermeiden", [In deiner roten Randnotiz auf Folie 4 sind die Begriffe vertauscht. Richtig ist: *offenes* System → Druck(änderungs)arbeit $w_p=integral v dif p$ (steckt in $w_t$); *geschlossenes* System → Volumen(änderungs)arbeit $w_v=-integral p dif v$ (steckt in $w_g$). So stehen sie auch auf den Folien 4 und 6 und im Buch (Gl. 4.37/4.38, S. 104). Eselsbrücke: Im offenen System fließt Stoff durch, das Volumen der Maschine ändert sich nicht, wohl aber der Druck.], fill: sand)
#src([N S. 8–9 (Folie 03 Erster Hauptsatz 5–6) mit Randnotizen; BT 4.1, Gl. (4.11)–(4.12), S. 95, und 4.2, Gl. (4.37)–(4.38), S. 104 (PDF-S. 115 und 124).])

=== 3.1.3 Sonderfälle im geschlossenen System <a-3-1-3>
Für ein *ruhendes* System ($c_1=c_2=0$) konstanter Höhe ($dif z=0$) bleibt nur die innere Energie übrig. Je nach Annahme fallen weitere Terme weg:
#tab(columns: (1.3fr, 1.6fr),
  th([Fall], [1. HS, extensiv]),
  [Mit Dissipation $J_12$ (z. B. Turbulenz, innere Gasreibung)], [$m(u_2-u_1)=Q_12+J_12+W_(v 12)$],
  [„Reibfrei“: Rechenmodell ohne Dissipation, $J_12=0$], [$m(u_2-u_1)=Q_12+W_(v 12)$],
  [Reibfrei *und* adiabat ($Q_12=0$, $W_12=W_(v 12)$)], [$m(u_2-u_1)=W_(v 12)=m(-integral p dif v)$],
  [Abgeschlossenes System (weder Arbeit noch Wärme)], [$m(u_2-u_1)=0$, also $dif u=0$],
)
#bild("hs-special", [Skizzen zu den vier Fällen, von oben nach unten. Ausschnitt N S. 10 (Folie 03 Erster Hauptsatz 7).], height: 62mm)
Bei Dissipation dient nur ein Teil der übertragenen Arbeit $W_(g,12)$ der Volumenänderung; der Rest $J_12$ „wirkt wie Wärmezufuhr“.
Das beschreibt die *Wirkung* auf $U$: Die Energie hat die Grenze als Arbeit überquert. $J_12$ ist deshalb kein zusätzlicher Wärmestrom und wird nicht noch einmal neben der bereits vollständig erfassten Gesamtarbeit addiert. Für ein abgeschlossenes System gilt allgemein $Delta E_"sys"=0$; $Delta U=0$ folgt hier zusätzlich aus dem ruhenden System mit unveränderter Höhe.
#bild("map-firstlaw", [Mindmap: Der erste Hauptsatz auf einen Blick. Eigene Darstellung.], height: 46mm)
#src([N S. 10 (Folie 03 Erster Hauptsatz 7); BT 4.1, Gl. (4.10)–(4.13) und Abb. 4.5–4.6, S. 95–96 (PDF-S. 115–116). Allgemeine Energieaussage: ergänzende Einordnung mit N S. 8.])

=== 3.1.4 Beispiel: Erwärmung einer Kugel beim Aufschlag <a-3-1-4>
#bild("ball", [① Bleikugel in $z_1=30 thin "m"$ mit $c_1=30 thin "m/s"$; ② ideal starr am Boden in Ruhe; ②\* Realität: Kugel plattgedrückt (Verformungsarbeit). Ausschnitt N S. 12 (Tafelanschrieb).], height: 42mm)
*System:* die Kugel (geschlossen), von Zustand ① oberhalb des Bodens bis Zustand ② nach dem Aufprall. *Idealisierungen der Tafelrechnung:* Luftwiderstand, Energieabgabe an Boden und Umgebung sowie Rückprall werden vernachlässigt; die gesamte anfängliche äußere Energie erhöht $U$ der Kugel. Damit setzt das Modell $q_12=0$, $w_12=0$, $z_2=0$ und $c_2=0$:
$ c_"Pb" Delta T_12-c_1^2/2-g z_1=0 quad => quad Delta T_12=frac(c_1^2/2+g z_1, c_"Pb") $
$ Delta T_12=1/(130 thin "J/(kg K)")(30^2/2+"9,81" dot 30) thin "m"^2/"s"^2=("450"+"294,3")/130 thin "K" approx "5,73" thin "K" $
Einheitencheck: $1 thin "m"^2/"s"^2=1 thin "N m/kg"=1 thin "J/kg"$. Für feste Stoffe gilt $u_2-u_1=c Delta T$.
#note("Modell und Realität", [Die 5,73 K sind der idealisierte Temperaturanstieg mit dem verwendeten konstanten $c_"Pb"$. Reale Verformung ist nicht automatisch Energieabgabe: Dissipation *in der Kugel* kann sie erwärmen. Energie, die an Boden und Umgebung geht oder als andere Speicheränderung verbleibt, steht dagegen nicht vollständig für $m c Delta T$ zur Verfügung.], fill: sand)
#note("Fehler vermeiden", [Im älteren Anschrieb N S. 12 steht $c_"Pb"=130 thin "kJ/(kg K)"$; N27, PDF-S. 8, bestätigt inzwischen die Einheit J/(kg K). Richtig ist $130 thin "J/(kg K)"$ (Blei, ca. 0,13 kJ/(kg K)). Nur mit J ergibt sich das Ergebnis 5,73 K; mit kJ wären es 0,0057 K.], fill: sand)
#note("★ Klausur", [„1. HS ist der richtige Ansatz in der Prüfung!!“ (von dir markiert). Immer zuerst System und Zustände ① und ② festlegen, dann alle Terme hinschreiben und erst danach streichen.], fill: sand)
*Hinweis zum 1. HS:* Er sagt nur, dass die Summe der Zustandsänderungen gleich der Summe der Prozessgrößen ist. Er sagt *nicht*, welche Prozessgröße in welche Zustandsänderung umgewandelt wird. Das Pumpspeicherbeispiel ist inzwischen in 3.3 behandelt. Das Strahltriebwerk mit Nachbrenner und adiabater Düse wird in N27, PDF-S. 10, weiterhin nur genannt; zu diesem Beispiel werden keine fehlenden Daten ergänzt.
#src([N S. 11 (Folie 03 Erster Hauptsatz 8) und S. 12 (Tafel, „Ende VL 21.10“). N27, PDF-S. 8 und 10. Einheitenkorrektur bei $c_"Pb"$: eigene Ergänzung.])
#hoch(<a-3>, [Kapitelübersicht])



#pagebreak()
== 3.2 Ergänzung aus WZF 23.10.: der instationäre Stickstoffbehälter <a-3-2>
Eine unveränderte Behälterwand macht die Stickstoffentnahme nicht stationär: Im Gefäß bleibt nachher weniger Masse. Der erste Hauptsatz muss deshalb *Speicherung und Stoffaustritt* gleichzeitig erfassen. Das ist die Verbindung zwischen Stoffwerten aus 2.13 und der Energiebilanz.

=== 3.2.1 Die Systemgrenze entscheidet über die Energiezufuhr <a-3-2-1>
Wir legen die Grenze um den Gefäßinhalt, mit dem Flüssigkeitsaustritt am Gefäß. Bewegungs- und Lageenergieänderungen des gespeicherten Inhalts werden wie in M2 vernachlässigt. Die Entnahme erfolgt im Modell bei konstantem $p_2=p_3$; es gibt keinen Zufluss.
#tab(columns: (1fr, 2fr),
 th([Gewählte Grenze], [Energie des Heizers]),
 [Nur Stickstoff], [Der Heizer überträgt die Energiemenge als $Q_"zu,23"$ an den Stickstoff. So bezeichnet sie die Musterlösung. Die äußere Gefäßwand ist adiabat.],
 [Stickstoff und Heizer], [Elektrische Arbeit $W_"el,23"$ kommt über das Kabel hinein. Bei vernachlässigbarer Heizerspeicherung und ohne Verluste entspricht ihr Betrag $Q_"zu,23"$.],
)
Die Massenbilanz ist $Delta m=m_3-m_2=-m_"entn"$. Der austretende Stickstoff ist flüssig und trägt die spezifische Enthalpie $h'$ mit:
#form[$ U_3-U_2=Q_"zu,23"-m_"entn" h' $]
$U,Q$ in kJ, $m_"entn"$ in kg, $h'$ in kJ/kg. *Voraussetzungen:* starrer Behälter, konstante Austrittsenthalpie im isobaren Entnahmeabschnitt, keine weitere Arbeitsübertragung und vernachlässigte äußere Energien. $h'$ enthält bereits die Verschiebearbeit des Austritts.

Weil sowohl $p$ als auch das *gesamte* $V$ gleich bleiben, gilt $Delta(p V)=0$ und damit $Delta U=Delta H$. Mit $H=m'h'+m''h''$ ergibt sich:
$ Delta H=h' Delta m'+h'' Delta m''=-m_"entn" h'+Delta m''(h''-h') $
Eingesetzt in die Bilanz:
#form[$ Q_"zu,23"=Delta m''(h''-h') $]
Diese kurze Verdampfungsformel gilt *hier wegen der hergeleiteten Randbedingungen*. Sie darf bei einem beliebigen Entleerungsprozess nicht ungeprüft eingesetzt werden.
#note("Fehler vermeiden", [Die 1 kg Entnahme sind nicht die verdampfte Masse. Die neue Dampfmasse bleibt im Gefäß, während flüssiger Stickstoff austritt. Außerdem ist der Gefäßinhalt während der Entnahme kein geschlossenes System: $Q_"zu,23"=Delta U$ allein lässt den Enthalpietransport mit der entnommenen Masse weg.], fill: sand)
#src[W23, PDF-S. 2–3; M2, PDF-S. 2–3 (dort ausdrücklich instationäre Massen- und Energiebilanz); Enthalpiedefinition ergänzend BT 4.4, S. 107–108 / PDF-S. 127–128. Wahl der Heizergrenze: ergänzte Einordnung.]


#pagebreak()
=== 3.2.2 Die 39 Zustandsgrößen systematisch aufbauen <a-3-2-2>
Ü 2.1 f verlangt 13 Größen für *drei Betrachtungen*: das gesamte Nassdampfgemisch, die gesättigte Flüssigkeit und den Sattdampf. Du brauchst keine 39 voneinander unabhängigen Ansätze. Nutze denselben Rechenplan für jede Spalte.
#tab(columns: (0.9fr, 1.05fr, 2.1fr),
 th([Größen], [Einheiten], [Rechenplan und Bedeutung]),
 [$p,T$], [bar, K], [Beide Phasen sind im Sättigungsgleichgewicht: $p'=p''=p$, $T'=T''=T$. Thermische intensive Größen.],
 [$x,mu$], [1], [$x=m''/m$, $mu=V''/V=x v''/v$. Zusammensetzung, intensiv; reiner Flüssigkeitszustand: 0, reiner Dampfzustand: 1.],
 [$v$], [m³/kg], [$v=V/m=v'+x(v''-v')$. Thermische intensive Größe.],
 [$h,u,s$], [kJ/kg; kJ/(kg K)], [Kalorische intensive Größen: Mischungsregel für $h,s$; $u=h-p v$ mit konsistenten Einheiten.],
 [$m,V$], [kg; m³], [Extensiv: $m'=m(1-x)$, $m''=m x$; $V'=m'v'$, $V''=m''v''$. $V$ ist zugleich eine thermische Größe.],
 [$H,U,S$], [kJ; kJ/K], [Kalorisch und extensiv: $H=m h$, $U=m u$, $S=m s$; für jede Phase denselben Ansatz mit Strichwerten verwenden.],
)
*Additionsprüfung:* $m=m'+m''$, $V=V'+V''$, $H=H'+H''$, $U=U'+U''$, $S=S'+S''$. Die spezifischen Größen werden dagegen mit *Massenanteilen* gewichtet. $p$ und $T$ werden weder addiert noch zwischen den Phasen gemittelt.
#note("Bezugsgröße mitsprechen", [„Die Entropie steigt“ ist ohne Bezugsgröße unvollständig. Nach der Entnahme kann die spezifische Entropie $s$ des Restes größer und die gesamte Entropie $S=m s$ kleiner sein. Die Aufgabe „Stickstoff: Heizerenergie und Zustandsgrößen“ prüft beides anhand desselben Datensatzes.])
#src[Ü 2.1 f–g, PDF-S. 11–12; M2, PDF-S. 4 und 6–8; BT 3.4, S. 60–62 / PDF-S. 80–82, und 4.4, S. 108 / PDF-S. 128.]

#hoch(<a-3>, [Kapitelübersicht])

#pagebreak()
== 3.3 Ergänzung 27.10. · Turbine und Kraftwerk <a-3-3>
Ein Gefälle oder heißer Dampf kann eine Welle antreiben. Entscheidend ist, welche Energie der strömende Stoff zwischen Ein- und Austritt abgibt. Eine *adiabate Turbine* überträgt keine Wärme über ihre Grenze; das bedeutet noch keinen verlustfreien Prozess.

=== 3.3.1 Das Pumpspeicherbeispiel: Wohin geht die Gefälleenergie? <a-3-3-1>
#bild("turbine-energie", [Energieaufteilung des Vorlesungsbeispiels. Eigene Darstellung nach N27, PDF-S. 9.], height: 53mm)
Zwischen den freien Wasserspiegeln gilt derselbe Umgebungsdruck. Änderungen der Geschwindigkeit werden vernachlässigt. Bei näherungsweise inkompressiblem Wasser ist dann $Delta h approx c Delta T$ und mit $H=z_1-z_2>0$:
#form[$ c Delta T-g H=w_t quad eta=frac(abs(P_t),rho dot(V)g H) $]
$c$ in J/(kg K), $H$ in m, $w_t$ in J/kg; $rho dot(V)=dot(m)$ in kg/s. Die Wellenleistung $P_t$ ist in der Zufuhrkonvention negativ. Der Wirkungsgrad verwendet ihren *positiven Betrag* als Nutzen.
Die 7 MW Wellenleistung erreichen im Beispiel etwa *89,2 %* der 7,848 MW Gefälleleistung. Die restlichen 0,848 MW erhöhen die innere Energie des Wassers: $Delta T approx "0,0253"$ K. Ein kleiner Temperaturanstieg ist wegen des großen Massenstroms mit erheblicher Leistung verbunden.
#note("Fehler vermeiden", [„Adiabat“ bedeutet $Q=0$. Die hier fehlende Nutzarbeit verlässt das System nicht als Wärmeverlust, sondern bleibt als erhöhte innere Energie im Wasser. Dagegen würde „ohne Dissipation“ eine zusätzliche Annahme verlangen.], fill: sand)
#src[N27, PDF-S. 9–10; Bilanz ergänzend BT 4.1, S. 92–93 / PDF-S. 112–113. Energieaufteilung und Zahlen: eigene Nachrechnung des Tafelbeispiels.]

=== 3.3.2 Offene Dampfanlage: Kessel und Turbine getrennt bilanzieren <a-3-3-2>
#bild("kraftwerk-enthalpie", [Offenes Dampfkraftwerk: Zustandsnummern wie in N27, PDF-S. 11; vereinfachtes eigenes Fließschema.], height: 52mm)
Im *Dampfkessel* führt Wärme dem Strom Energie zu; technische Arbeit wird dort im Modell nicht übertragen. In der *Turbine* wird dagegen bei vernachlässigten Änderungen von Geschwindigkeit und Höhe ein Enthalpieabfall zu abgegebener Wellenarbeit:
#form[$ q_12=h_2-h_1 quad w_(t,23)=h_3-h_2 quad dot(Q)_12=dot(m)q_12 quad P_23=dot(m)w_(t,23) $]
$h,q,w_t$ in kJ/kg und $dot(m)$ in kg/s liefern kW. Bei 100 t/h aus der Vorlesung beträgt die Kesselwärme 3022 kJ/kg, die Turbinenarbeit −800 kJ/kg. Es ergeben sich 83,94 MW Wärmezufuhr und 22,22 MW abgegebene Wellenleistung.
#form[$ eta_"Anlage"=frac(abs(P_23),dot(Q)_12)=frac(h_2-h_3,h_2-h_1) approx "0,2647" $]
*Gültigkeit:* genau das gezeigte offene Anlagenmodell. Pumpen-, Generator- und weitere Verluste sind nicht angegeben. Die 26,47 % sind keine zusätzlich berechnete Effizienz eines vollständigen geschlossenen Dampfkreislaufs.
In einem Fließbild bedeuten Pfeile Stofftransport, ein Kessel die Wärmezufuhr und die Turbine die Wellenabgabe. Ein solcher Plan legt die zu bilanzierenden Bauteile und Zustände fest; er ist keine räumlich maßstäbliche Zeichnung.
#src[N27, PDF-S. 11–12; Enthalpiebilanz ergänzend BT 4.4, S. 107–109 / PDF-S. 127–129. Zahlen: eigene Nachrechnung.]
#hoch(<a-3>, [Kapitelübersicht])

#pagebreak()
== 3.4 Volumenarbeit, Prozessweg und Nutzarbeit <a-3-4>
Eine Fahrradpumpe lässt sich mit Kühlung anders zusammendrücken als ohne Kühlung. Dieselben Endzustände legen deshalb die Arbeit noch nicht fest: Es kommt auf den Druck *während* der Bewegung an.

=== 3.4.1 Energie, spezifische Energie und Leistung auseinanderhalten <a-3-4-1>
#tab(columns: (1fr, 1.5fr, 1.4fr),
 th([Bezugsgröße], [Zusammenhang], [Bedeutung und Einheit]),
 [Spezifische Arbeit], [$w=W/m$], [Arbeit je Masse, J/kg oder kJ/kg.],
 [Geschlossene Masse], [$W=m w$], [Energie, J oder kJ.],
 [Stationärer Stoffstrom], [$P=dot(m)w_t$], [Energie pro Zeit, W oder kW.],
)
Gesamtenergien beziehungsweise passende Leistungen lassen sich addieren. Spezifische Werte verschiedener Massen werden massengewichtet; ihr bloßes Addieren würde die Bezugsgröße verlieren.
#src[N27, PDF-S. 13; Größen und Enthalpiestrom ergänzend BT 4.4, S. 108 / PDF-S. 128.]

=== 3.4.2 Die Fläche unter dem Weg ist die Volumenarbeit <a-3-4-2>
Die Kraft auf einen Kolben ist Druck mal Fläche. Fläche mal Weg ergibt die Volumenänderung. In der *Zufuhrkonvention* steht daher ein Minus vor dem Integral:
#form[$ W_(v,12)=-integral_(V_1)^(V_2) p(V) dif V quad w_(v,12)=-integral_(v_1)^(v_2) p(v) dif v $]
$p$ ist der absolute Systemdruck, $V$ das Gesamtvolumen, $v$ das spezifische Volumen. Pa·m³ ergibt J; Pa·m³/kg ergibt J/kg. *Voraussetzung:* quasistatische Grenzbewegung mit eindeutigem Druck; im reibfreien ruhenden Modell ist dies die gesamte Arbeit. Expansion ergibt $W_v<0$, Kompression $W_v>0$.
#bild("arbeit-zwei-wege", [Zwei Verdichtungswege mit $epsilon=V_1/V_2=10$. Eigene normierte Darstellung nach N27, PDF-S. 14–16.], height: 61mm)
Beim idealen Gas gilt isotherm $p V=p_1 V_1$. Alternativ kann zunächst bei $p_1$ isobar verdichtet und danach bei festem $V_2$ bis zum selben Endzustand erwärmt werden:
#form[$ W_"I"=p_1 V_1 ln(epsilon) quad W_"II"=p_1 V_1(1-1/epsilon) $]
Für $epsilon=10$ benötigt Weg I etwa *2,56-mal* so viel Volumenarbeit wie Weg II. Beim zweiten Weg wird vor allem bei niedrigerem Druck verdichtet. Das senkrechte, isochore Stück trägt keine Volumenarbeit bei.
Da Anfangs- und Endtemperatur gleich sind, ist bei idealem Gas $Delta U=0$. Auf *jedem* Weg gilt deshalb $Q=-W_v$, obwohl $Q$ und $W_v$ einzeln verschieden sind. Der erste Hauptsatz legt ihre Summe fest, nicht ihre getrennten Beträge.
#note("Gültigkeit", [Weniger mechanische Arbeit setzt hier einen anders geführten Wärmeprozess voraus. Daraus folgt noch kein Gesamtwirkungsgrad einer realen Anlage; Aufwand für Kühlung und Erwärmung ist in diesem Wegvergleich nicht bilanziert.], fill: sand)
#src[N27, PDF-S. 14–16; Volumenarbeit BT 4.2, S. 99 / PDF-S. 119. Normierung und Verhältnis: eigene Nachrechnung.]

=== 3.4.3 Nutzarbeit: Auch die Umgebung muss Platz machen <a-3-4-3>
#bild("arbeit-nutzanteil", [Nutzbarer Anteil der Volumenarbeit bei Expansion. Eigene schematische Darstellung nach N27, PDF-S. 17.], height: 53mm)
Eine expandierende Gasportion muss die Umgebung gegen deren Druck verdrängen. Bei konstantem Umgebungsdruck $p_"∞"$ steht für eine zusätzliche Nutzung nur die Druckdifferenz zur Verfügung:
#form[$ W_"∞"=p_"∞"(V_2-V_1) quad W_(v,n)=-integral_(V_1)^(V_2)(p-p_"∞")dif V=W_v+W_"∞" $]
$W_"∞"$ ist hier der *positive Verdrängungsaufwand* bei Expansion; $W_(v,n)$ die in der Zufuhrkonvention vorzeichenbehaftete Nutzarbeit. Der Betrag der nutzbaren Abgabe ist daher kleiner als der Betrag der gesamten Volumenarbeitsabgabe. Im Integral für $W_v$ darf der absolute Druck nicht still durch Überdruck ersetzt werden; das ergäbe bereits die Nutzarbeit.
#bild("map-arbeit", [Mindmap: Arbeit, Prozessweg und Nutzanteil. Eigene Darstellung.], height: 45mm)
#note("Vorzeichen im Folienbild", [Am kleinen Flächenelement in N27, PDF-S. 17, steht $dif W_v=p(V)dif V$ ohne Minus. Das zeigt eine Flächenbeschriftung; als vorzeichenbehaftete Zufuhrarbeit gilt dagegen $dif W_v=-p dif V$, wie auch die große Integralformel auf derselben Folie angibt.], fill: sand)
#src[N27, PDF-S. 17. Vorzeichenhinweis und konstante Umgebung ausdrücklich ergänzt.]
#hoch(<a-3>, [Kapitelübersicht])

#pagebreak()
== 3.5 Technische Arbeit und Verschiebearbeit <a-3-5>
Eine Pumpe fördert Stoff in einen höheren Druck hinein. Nicht die Größe des Maschinengehäuses, sondern die Energieänderung des *hindurchströmenden Stoffes* ist entscheidend. Die technische Arbeit enthält dafür mehrere Beiträge.
#form[$ w_t=j_12+underbrace(integral_1^2 v dif p,w_p)+frac(c_2^2-c_1^2, 2)+g(z_2-z_1) $]
Alle Terme in J/kg oder einheitlich kJ/kg. $j_12$ ist Dissipationsarbeit, $w_p$ Druckarbeit, $c$ Strömungsgeschwindigkeit und $z$ Höhe. Nur bei $j_12=0$ und vernachlässigten Änderungen äußerer Energie gilt $w_t=w_p$. Beim Druckanstieg einer idealen Pumpe ist $w_p>0$, bei der Expansion in einer idealen Turbine $w_p<0$.

=== 3.5.1 Druckarbeit und Volumenarbeit sind miteinander verbunden <a-3-5-1>
Aus $dif(p v)=p dif v+v dif p$ folgt für *denselben Zustandsweg*:
#form[$ w_p=integral_1^2 v dif p=-integral_1^2 p dif v+p_2v_2-p_1v_1=w_v+Delta(p v) $]
#bild("arbeit-verschiebung", [Zusammenhang für dieselbe Bezugsmasse. Eigene Darstellung nach N27, PDF-S. 19.], height: 48mm)
Die Einströmverschiebung liefert in dieser Zerlegung den Beitrag $-p_1v_1$, die Ausströmverschiebung $+p_2v_2$. Sie unterscheiden die Druckarbeit von der Volumenarbeit einer geschlossenen Portion entlang desselben Wegs. Dass eine reale Kolbenmaschine und eine reale Strömungsmaschine automatisch denselben Weg durchlaufen, wird damit nicht behauptet.

=== 3.5.2 Flüssigkeit und Gas: Das Volumenmodell entscheidet <a-3-5-2>
#tab(columns: (1fr, 1.55fr),
 th([Stoffmodell], [Folge für die ideale Druckarbeit]),
 [Flüssigkeit, annähernd inkompressibel], [$v approx "konstant"$: $w_p approx v(p_2-p_1)$. Einheiten: m³/kg mal Pa ergibt J/kg.],
 [Gas, kompressibel], [$v$ ändert sich: $w_p=integral v(p)dif p$. Ohne Prozessgesetz lässt sich $v$ nicht einfach vor das Integral ziehen.],
 [Ideales Gas, isotherm], [$p v=R T="konstant"$: $Delta(p v)=0$, deshalb $w_p=w_v$ für denselben Weg.],
)
#note("Fehler vermeiden", [Eine Flüssigkeit kann bei fast unverändertem spezifischem Volumen erhebliche Pumpenarbeit benötigen. $w_v approx 0$ bedeutet dann nicht $w_p approx 0$: Gerade die Änderung von $p v$ bleibt erhalten.], fill: sand)
#src[N27, PDF-S. 18–19; BT 4.2, S. 100 und 102–103 / PDF-S. 120 und 122–123, insbesondere Gl. (4.28)–(4.32).]
#hoch(<a-3>, [Kapitelübersicht])

#pagebreak()
== 3.6 Wärme, innere Energie und Enthalpie <a-3-6>
Wird ein Topf Wasser erhitzt, überquert Energie die Grenze wegen eines Temperaturunterschieds. Diese Übertragung heißt *Wärme*. Im Wasser bleibt kein eigener „Wärmevorrat“, sondern seine Zustandsenergie ändert sich.
#bild("map-waerme-enthalpie", [Mindmap: Übertragung, Speicherung und Stoffmodell trennen. Eigene Darstellung nach N27, PDF-S. 20.], height: 48mm)
#form[$ U=m u quad H=m h quad h=u+p v quad dot(H)=dot(m)h $]
$U,H,Q$ in J oder kJ, $u,h,q$ in J/kg oder kJ/kg; $dot(H)$ ist Leistung in W oder kW. Enthalpie ist eine Zustandsgröße, die Wärme $Q$ eine Prozessgröße. Je nach System und Bedingungen kann eine *Änderung* der Enthalpie gleich einer übertragenen Wärme sein; beides ist nicht grundsätzlich identisch.

=== 3.6.1 Kalorische Stoffmodelle passend wählen <a-3-6-1>
Für das *ideale Gas* hängen $u$ und $h$ nur von der Temperatur ab:
#form[$ dif u=c_v dif T quad dif h=c_p dif T quad c_p-c_v=R $]
Bei annähernd konstanten Wärmekapazitäten folgen $Delta u=c_v Delta T$ und $Delta h=c_p Delta T$. $c_v,c_p,R$ müssen dieselben Einheiten besitzen. Bei größeren Temperaturbereichen sind konstante Werte eine ausdrücklich zu prüfende Modellannahme.
Für reale Fluide genügt die Temperatur im Allgemeinen nicht: Nutze etwa $u(T,v)$ oder $h(T,p)$ und die passenden Tabellen aus Kapitel 2. Bei näherungsweise inkompressiblen Flüssigkeiten und Feststoffen wird oft $c_p approx c_v approx c$ gesetzt; Druckeinflüsse auf $h$ verschwinden dadurch nicht automatisch.

=== 3.6.2 Die Änderung von pv vollständig mitnehmen <a-3-6-2>
#form[$ dif u=dif h-p dif v-v dif p quad u_2-u_1=h_2-h_1-(p_2v_2-p_1v_1) $]
Nur falls $Delta(p v)=0$ gilt auch $Delta u=Delta h$. Die Stickstoffentnahme in 3.2 hält *gesamtes* $p V$ konstant und erlaubt deshalb $Delta U=Delta H$, obwohl die spezifischen Größen und die Masse sich ändern. Die Bezugsgröße gehört immer zur Aussage.
#src[N27, PDF-S. 20; BT 4.3–4.4, S. 104–109 / PDF-S. 124–129. Ideales kalorisches Modell ergänzend BT 7.5, S. 217 / PDF-S. 236; Bezug zur Entnahme: W23 und M2, jeweils PDF-S. 2–3.]
#hoch(<a-3>, [Kapitelübersicht])

#pagebreak()
== 3.7 Druckluftmotor mit Gaswechsel <a-3-7>
Im Druckluftmotor füllt Druckluft den Zylinder, expandiert und wird anschließend ausgestoßen. Die Vorlesung vergleicht dafür zwei ideale Wege: *reversibel adiabat* (isentrop) und *isotherm*. Eine gleiche Anfangsportion erreicht in beiden Fällen denselben Enddruck, aber verschiedene Endvolumina.
#bild("druckluftmotor-vergleich", [Vergleich der Expansionswege und der idealisierten Füll-/Ausschiebelinien. Eigene Darstellung nach N27, PDF-S. 21.], height: 65mm)

=== 3.7.1 Zwei Wege, zwei Energiequellen <a-3-7-1>
Für eine geschlossene Gasportion gilt bei reversibler adiabater Expansion eines idealen Gases mit konstantem $kappa=c_p/c_v$:
#form[$ p V^kappa="konstant" quad frac(T_2,T_1)=(p_2/p_1)^((kappa-1)/kappa) quad W_v=frac(p_2 V_2-p_1 V_1,kappa-1) $]
$Q=0$: Die Expansionsarbeit verringert die innere Energie und die Temperatur sinkt. *Adiabat allein* würde noch keine Isentropie begründen; hier kommt ausdrücklich die Reversibilität hinzu.
Bei isothermer Expansion desselben idealen Gases bleibt dagegen $T_2=T_1$ und damit $Delta U=0$:
#form[$ p_1 V_1=p_2 V_(2*) quad W_(v,"isoth")=-p_1 V_1 ln(p_1/p_2) quad Q_"isoth"=-W_(v,"isoth")>0 $]
Die nachströmende Wärme ermöglicht die zusätzliche Arbeitsabgabe. Das größere isotherme Endvolumen und die größere Fläche sind deshalb keine Arbeitsgewinnung ohne zusätzliche Energiezufuhr.
#src[N27, PDF-S. 21; isentrope Beziehungen ergänzend BT 7.5, Gl. (7.27)–(7.29), S. 217 / PDF-S. 236. Isothermer Weg: N27, PDF-S. 14 und 21.]

#pagebreak()
=== 3.7.2 Gaswechsel ergänzt die Expansionsarbeit <a-3-7-2>
Beim Einfüllen schiebt die Zuluft den Kolben bei $p_1$ von null bis $V_1$; beim Ausstoßen wird gegen $p_2$ von $V_2$ bis null zurückgeschoben. Ohne Totvolumen und mit idealisiert konstanten Füll-/Ausschiebedrücken gilt:
#form[$ W_"Verschiebung"=-p_1 V_1+p_2 V_2 quad W_"Zyklus"=W_v+W_"Verschiebung"=W_p $]
Die Gesamtarbeit pro Gaswechselzyklus entspricht damit der Druckarbeit entlang des Expansionswegs. Im reversiblen Modell ohne Änderungen äußerer Energie ist sie zugleich die technische Arbeit dieser Gasportion. $P=f W_"Zyklus"$ benötigt die *Arbeitsspiele pro Sekunde* $f$, nicht nur eine Drehzahlangabe.
#note("Abgleich mit dem Anschrieb vom 28.10.", [N28, PDF-S. 4 und 7, gibt $R="287,2"$ J/(kg K), $kappa="1,4"$ und den Ansatz $dot(m)=m N/60$ vor. Dieser Tafelansatz entspricht *einem Arbeitsspiel je Umdrehung* und damit $f=10 thin "s"^(-1)$ bei 600 U/min. Der zuvor ergänzte Modellansatz ist damit durch Deine neuen Unterlagen bestätigt.], fill: sand)
Bei $p_(1,"ü")="22,3"$ bar und $p_"∞"="0,91"$ bar ist der Anfangsdruck *23,21 bar absolut*, die Anfangstemperatur *297,95 K*. Die bereits vorhandene Musterrechnung bleibt fachlich gültig; kleine Unterschiede zum Tafelanschrieb entstehen durch gerundete Zwischenwerte.
#note("Von dir markiert", [Auf N28, PDF-S. 4, steht mit „\@KI“, dass auch ein Zustandsdiagramm in der Prüfung gezeichnet werden soll. Benenne Achsen, Zustände und die konstant gehaltene Größe; die Einordnung der Diagramme steht jetzt in #link(<a-4-4>)[4.4].])
#src[N27, PDF-S. 21; N28, PDF-S. 3–7; N03, PDF-S. 1–3; BT A.4, S. 482 / PDF-S. 497, und BT 4.2, S. 102 / PDF-S. 122. Bestehende Zahlen unabhängig erneut geprüft.]

#hoch(<a-3>, [Kapitelübersicht])

#pagebreak()
== 3.8 Ergänzung 3.11. · Wärmekapazitäten richtig verwenden <a-3-8>
Eine Wärmekapazität sagt, wie stark sich eine Energiegröße bei einer Temperaturänderung verändert. Sie braucht einen *Mengenbezug* und einen *Temperaturbereich*. Eine Tabelle mit Mittelwerten seit 0 °C liefert nicht unmittelbar den Mittelwert zwischen zwei anderen Temperaturen.

=== 3.8.1 Isochor und isobar: Die Ausdehnung braucht zusätzliche Energie <a-3-8-1>
#bild("waermekapazitaet-kolben", [Gleiche Temperaturerhöhung in zwei idealisierten Kolbensystemen. Eigene Darstellung nach N03, PDF-S. 9–11.], height: 53mm)
Im geschlossenen, ruhenden Idealmodell ohne Dissipation wird bei festgehaltenem Volumen keine Volumenarbeit übertragen: $q=c_v Delta T$. Bei konstantem Druck dehnt sich das Gas aus und gibt Arbeit ab; dafür muss zusätzlich Wärme zugeführt werden: $q=c_p Delta T$.
#form[$ dif u=c_v dif T quad dif h=c_p dif T quad c_p-c_v=R quad kappa=frac(c_p,c_v)>1 $]
*Gültigkeit:* ideales Gas; für endliche Änderungen konstante oder passende mittlere Wärmekapazitäten. Die Stoffbeziehungen $dif u=c_v dif T$ und $dif h=c_p dif T$ gelten beim idealen Gas auch auf anderen Wegen. Erst die Gleichsetzung von Wärme mit $c_v dif T$ beziehungsweise $c_p dif T$ benötigt die jeweilige Prozessbedingung.
#tab(columns: (1fr, 1fr, 1.25fr),
 th([Bezug], [Isobar], [Einheit / Umrechnung]),
 [Gesamte Portion], [$C_p=m c_p=n C_(m,p)$], [kJ/K.],
 [Je Masse], [$c_p$], [kJ/(kg K).],
 [Je Stoffmenge], [$C_(m,p)=M c_p$], [kJ/(kmol K); $M$ in kg/kmol.],
)
Die entsprechende Umrechnung gilt für die isochoren Größen mit Index $v$.
#src[N03, PDF-S. 4 und 9–11; BT 6.4, S. 192–194 / PDF-S. 211–213.]

#bild("map-waermekapazitaet", [Mindmap: Prozessbedingung, Bezugsmenge und Mittelwert. Eigene Darstellung.], height: 43mm)

=== 3.8.2 Wahre Wärmekapazität und Bereichsmittel unterscheiden <a-3-8-2>
#bild("waermekapazitaet-mittel", [Fläche unter einer schematischen Kurve und flächengleiches Mittelwertrechteck. Eigene Darstellung nach N03, PDF-S. 4–6; keine Stoffdatenkurve.], height: 56mm)
Der Kurvenwert $c_p(T)$ beschreibt eine kleine Änderung am jeweiligen Zustand. Der Mittelwert über ein Intervall wird so gewählt, dass er *dieselbe Energieänderung* liefert:
#form[$ overline(c)_(p,12)=frac(integral_(T_1)^(T_2)c_p(T)dif T,T_2-T_1) quad Delta h=overline(c)_(p,12)(T_2-T_1) $]
Der Wert in der Intervallmitte ist im Allgemeinen kein exakter Ersatz. Auch ein Tabellenmittel 0–800 °C ist nicht das Mittel für 400–1200 °C, obwohl beide Bereiche 800 K breit sind.
Für die auf $vartheta_0=0$ °C bezogenen *molaren* Tabellenwerte folgt durch Abziehen der beiden Energiezunahmen:
#form[$ overline(C)_(m,p,12)=frac(overline(C)_(m,p,02)(vartheta_2-vartheta_0)-overline(C)_(m,p,01)(vartheta_1-vartheta_0),vartheta_2-vartheta_1) $]
Alle Temperaturdifferenzen besitzen dieselbe Schrittweite in K und °C. Hier dürfen die Celsius-Zahlenwerte wegen des ausdrücklich festgelegten Tabellenbezugs verwendet werden; in Gasgleichungen und Logarithmen bleibt Kelvin erforderlich.
#note("Zwei verschiedene Tabellen", [N03, PDF-S. 7, nennt $c_p,c_v,kappa$ für *0 °C* (alte T-3, heute BT A.4). Die Mittelwerttabelle auf PDF-S. 8 verwendet einen Temperaturbereich seit 0 °C (alte T-4, heute BT A.5). Ihre Luft-Molmassen sind leicht unterschiedlich gerundet. Die Vorlesungsrechnung bleibt deshalb mit $M="28,95"$ kg/kmol innerhalb der T-4-Werte.], fill: sand)
Für Luft von 400 bis 1200 °C ergibt die Vorlesungsrechnung $overline(C)_(m,p,12)="33,27"$ kJ/(kmol K), $overline(c)_(p,12) approx "1,14922"$ kJ/(kg K) und einen daraus gebildeten *Bereichswert* $kappa approx "1,33315"$. Er ist kein überall unveränderlicher Isentropenexponent; 1,4 ist hier nur der Vergleichswert des konstanten Luftmodells.
#src[N03, PDF-S. 4–11, besonders markierter Hinweis „Man muss rechnen & nicht ablesen“ auf PDF-S. 5; BT 6.4, S. 195 / PDF-S. 214, und A.4–A.5, S. 482–483 / PDF-S. 497–498. Werte selbst nachgerechnet.]
#hoch(<a-3>, [Kapitelübersicht])

#pagebreak()
== 3.9 Ergänzung 3.11. · Energiebilanz von Kreisprozessen <a-3-9>
In einem *Kreisprozess* durchläuft das Arbeitsmittel mehrere Zustandsänderungen und kehrt anschließend in seinen Anfangszustand zurück. Eine Dampfkraftanlage verbindet dazu Pumpe, Kessel, Turbine und Kondensator. Die Bauteile werden einzeln offen bilanziert; der gesamte Umlauf hat keine bleibende Änderung der Zustandsgrößen.
#bild("kreisprozess-energie", [Bauteile und Energieübertragungen einer einfachen Dampfkraftanlage. Eigene Darstellung nach N03, PDF-S. 12–13.], height: 53mm)

=== 3.9.1 Zustand kehrt zurück; Wärme und Arbeit bleiben als Bilanzbeiträge <a-3-9-1>
#form[$ integral.cont dif U=0 quad integral.cont dif H=0 quad Q_"zu"+Q_"ab"+W_"netto"=0 $]
$Q_"zu">0$, $Q_"ab"<0$ und bei Arbeitsabgabe $W_"netto"<0$ sind hier *vorzeichenbehaftete* Größen. Für stationäre Anlagen gilt dieselbe Summe mit Wärmeströmen und Leistungen. Die Pumpenaufnahme wird von der Turbinenabgabe abgezogen, um die Nutzabgabe zu bestimmen.
Interne Stoff- und Energieübertragungen treten an benachbarten Bauteilen mit entgegengesetzten Vorzeichen auf. In der Gesamtbilanz bleiben nur die Übertragungen über die *äußere Systemgrenze*. Ein interner Enthalpiestrom ist kein zusätzlicher Nutzen der Gesamtanlage.
#form[$ eta_"th"=frac(abs(W_"netto"),Q_"zu")=1-frac(abs(Q_"ab"),Q_"zu") $]
*Gültigkeit:* die gezeigte Wärmekraftmaschine mit zwei entsprechend bilanzierten Wärmeaustauschbeiträgen; gleiche Größenbasis verwenden, also Energien oder Leistungen. Der erste Hauptsatz prüft den Energieausgleich. Ob ein gedachter Prozess auch möglich ist, verlangt Kapitel 4.
#src[N03, PDF-S. 12–13; BT 4.5, S. 112 und 115–116 / PDF-S. 132 und 135–136. Vorzeichen ausdrücklich vereinheitlicht.]

=== 3.9.2 Rechtslauf, Linkslauf und Perpetuum mobile erster Art <a-3-9-2>
#tab(columns: (1fr, 1.6fr, 1.2fr),
 th([Prozess], [Energienutzung], [Typisches Beispiel]),
 [Rechtsläufig], [Nettoarbeit wird abgegeben; Wärme auf hohem Niveau aufgenommen und auf niedrigerem abgegeben.], [Wärmekraftmaschine.],
 [Linksläufig], [Arbeit wird zugeführt; Wärme wird von niedrigerem auf höheres Temperaturniveau übertragen.], [Kältemaschine, Wärmepumpe.],
)
Ein *Perpetuum mobile erster Art* würde fortlaufend Arbeit abgeben, ohne eine gleichwertige andere Energieaufnahme oder Speicherabnahme. Das widerspricht dem ersten Hauptsatz. Die Rückkehr des Arbeitsmittels zum Anfangszustand ist keine Energiequelle.
#src[N03, PDF-S. 12–14, dort „Ein Perpetuum Mobile erster Art ist unmöglich!“ markiert.]
#hoch(<a-3>, [Kapitelübersicht])

#pagebreak()
== 3.10 Ergänzung 4.11. · Düse, Ausfluss, Drossel und Rohr <a-3-10>
Bei einer *Düse* wird der Strom schneller; bei einer *Drossel* wird vor allem der Druck abgebaut. Beide können nach außen adiabat und ohne technische Arbeitsübertragung sein. Daraus folgt jeweils eine Energiebilanz, aber noch keine Reversibilität.
#form[$ h_2-h_1+frac(c_2^2-c_1^2, 2)+g(z_2-z_1)=0 $]
*Voraussetzungen:* stationärer Stoffstrom, $q_12=0$, $w_(t,12)=0$. Die Folienbezeichnung „rigid“ bedeutet hier keine technische Arbeitsübertragung; ein starres Gehäuse allein würde etwa elektrische Arbeit nicht ausschließen. Enthalpien in J/kg verwenden, wenn Geschwindigkeit in m/s eingesetzt wird.
#bild("stroemung-duese-drossel", [Zwei verschiedene Vereinfachungen derselben Energiebilanz. Eigene Darstellung nach N04, PDF-S. 1.], height: 56mm)
#tab(columns: (1fr, 1.9fr),
 th([Fall und Zusatzannahme], [Physikalische Folge]),
 [Düse; gleiche Höhe], [$c_2^2-c_1^2=2(h_1-h_2)$. Sinkende Enthalpie erhöht die Bewegungsenergie.],
 [Druckbehälterausfluss; Eintritt aus großem Vorrat, $c_1 approx 0$], [Lokaler Ausfluss: $c_2 approx sqrt(2(h_1-h_2))$. Ein sich leerender Gesamtbehälter ist trotzdem instationär.],
 [Torricelli; inkompressibel, gleicher Umgebungsdruck, $c_1 approx 0$], [$c_2=sqrt(2g(z_1-z_2))$. Der Höhenverlust treibt die Geschwindigkeit.],
 [Drossel; gleiche Höhe und $c_1 approx c_2$], [$h_2 approx h_1$. Druck und bei realen Stoffen auch Temperatur können sich ändern.],
 [Langes Rohr; gleiche Höhe, Geschwindigkeit ändert sich], [$h_1+c_1^2/2=h_2+c_2^2/2$. Bei gleichem Querschnitt bleibt $dot(m)=rho A c$ erhalten.],
)
#note("Folienüberschrift einordnen", [Die Überschrift N04, PDF-S. 1, nennt „reversibel adiabat = isentrop“. Das ist für einen ausdrücklich reversiblen adiabaten Vergleichsweg richtig. Eine reale Drossel und ein Rohr mit Reibung sind dagegen irreversibel. $q=0$ und $w_t=0$ allein machen einen Prozess nicht isentrop.], fill: sand)
Eine Drosselung ist beim idealen Gas mit $h=h(T)$ unter diesen Bedingungen auch isotherm. Für ein reales Fluid folgt aus $h_2=h_1$ keine allgemeine Temperaturkonstanz. Umgekehrt beweist gleiche Entropie allein ohne weitere Bedingungen weder fehlende Wärmeübertragung noch fehlende Irreversibilität; verschiedene Beiträge können sich ausgleichen.
#src[N04, PDF-S. 1 (Folie 03-32; mit handschriftlichem Beginn VL 4.11.); BT 4.6, Gl. (4.67)–(4.71), S. 120–121 / PDF-S. 140–141, und 5.1–5.2, PDF-S. 149–150 und 157–158. Der Trennhinweis auf N04, PDF-S. 2, beendet diesen Foliensatz; anschließend beginnt der belegte Foliensatz 04.]
#hoch(<a-3>, [Kapitelübersicht])

#pagebreak()
== 3.11 Ergänzung Übung 30.10. · Zwei Stoffströme, eine Gesamtbilanz <a-3-11>
Ein Heizregister überträgt Energie vom warmen Wasser an vorbeiströmende Luft. Der Wärmestrom ist für die beiden Stoffseiten ein Grenzübertritt. Umschließt Du Wasser, Luft und Lüfter gemeinsam, ist derselbe Wärmestrom *intern* und fällt aus der Gesamtbilanz heraus.
#bild("lufterhitzer-grenzen", [Innere und äußere Grenzen in Ü 3.2. Eigene Darstellung nach R30, PDF-S. 1–2, und M32, PDF-S. 1.], height: 62mm)
Die Luft- und Wassermassenströme sind verschieden. Deshalb werden zuerst die jeweiligen *Enthalpieströme* gebildet. Ohne Änderungen äußerer Energie gilt für die Wasser- und Luftseite:
#form[$ dot(m)_W dot (h_"W2"-h_"W1")=-dot(Q)_"WL" $]
#form[$ dot(m)_L dot (h_"L2"-h_"L1")=dot(Q)_"WL"+P_"Lüfter" $]
$dot(Q)_"WL">0$ ist hier der vom Wasser zur Luft gerichtete Übertragungsbetrag. Addiert man beide Gleichungen, kürzt er sich:
#form[$ dot(m)_W Delta h_W+dot(m)_L Delta h_L=P_"Lüfter" $]
*Gültigkeit:* nach außen adiabates Gesamtgerät; die zugeführte Lüfterleistung gelangt vollständig in die betrachtete Luftseite. Die *Adiabatie der Gesamtgrenze* verbietet den inneren Wärmeaustausch nicht. Bei den angegebenen 0,8 kW liefert der Lüfter zusätzlich Energie zur Luft; nur die Wasserabkühlung liefert den Registerwärmestrom.
#note("Vorzeichen mit der Grenze verbinden", [Der gleiche innere Wärmestrom ist für das Wasser Abgabe und für die Luft Zufuhr. Du darfst den Pfeil anders wählen; dann müssen sein Vorzeichen und alle zugehörigen Bilanzgleichungen gemeinsam angepasst werden.], fill: sand)
#src[R30, PDF-S. 1–2; M32, PDF-S. 1; Ü 3.2, PDF-S. 20.]
#hoch(<a-3>, [Kapitelübersicht])

#pagebreak()
== 3.12 Ergänzung Musterlösung · Dampfkochtopf mit Dampfaustritt <a-3-12>
Ein Dampfkochtopf hält über das Ventil den Druck konstant. Solange Flüssigkeit und Dampf gemeinsam im Sättigungsgleichgewicht vorliegen, bleibt damit auch die Temperatur konstant. Der Inhalt ist trotzdem *instationär*: Dampf verlässt den Topf, der Flüssigkeitsspiegel sinkt und der Energiespeicher nimmt ab.
#bild("kochtopf-phasen", [Phasenbilanz und Zustandsweg von Ü 3.6. Eigene schematische Darstellung nach M36, PDF-S. 1; nicht maßstäblich.], height: 57mm)

=== 3.12.1 Weniger Flüssigkeit ist nicht genau die ausgetretene Masse <a-3-12-1>
Die Bilanzhülle umfasst den starren Topfinhalt und den Austrittsquerschnitt; es gibt keinen Zufluss. Bei gleichem Sättigungsdruck bleiben die Stoffwerte jeder Phase konstant. Der gesamte Raum bleibt gleich, deshalb wächst der Dampfraum um genau das verlorene Flüssigkeitsvolumen:
#form[$ Delta V''=-Delta V' quad Delta m'=frac(Delta V',v') quad Delta m''=-frac(Delta V',v'') $]
Hier ist $Delta V'<0$, $Delta m'<0$, aber $Delta m''>0$: Ein kleiner Teil des neu gebildeten Dampfes *bleibt im Topf*. Aus der gesamten Massenbilanz folgt für die positiv gezählte Ausströmmasse:
#form[$ m_"aus"=-(Delta m'+Delta m'')=(frac(1,v'')-frac(1,v'))Delta V' quad dot(m)_"aus"=frac(m_"aus",Delta t) $]
Volumina in m³ und spezifische Volumina in m³/kg liefern kg. Bei konstanter Volumenabnahme je Zeit ist auch der Massenstrom konstant. In Ü 3.6 werden aus 0,6 Litern Flüssigkeitsabnahme rund 0,56945 kg ausströmender Dampf. Die Gleichsetzung mit der gesamten verschwundenen Flüssigkeitsmasse wäre nur eine Näherung.
Die Restmasse sinkt bei konstantem Gesamtvolumen. Deshalb steigt ihr *spezifisches* Volumen $v=V/m$; der Gemischpunkt wandert im p-v-Diagramm nach rechts. Er bleibt im betrachteten Abschnitt zwischen Siede- und Taulinie.
#src[M36, PDF-S. 1; Ü 3.6, PDF-S. 21. Stoffwerte nach der Aufgabenangabe; Zustandsgebiet und Massenbilanz ergänzend BT 3.4, S. 60–62 / PDF-S. 80–82.]

#pagebreak()
=== 3.12.2 Ausströmender Energiestrom und zugeführte Heizleistung <a-3-12-2>
Der Dampf wird im Aufgabenmodell mit den angegebenen Sattdampfwerten am gewählten Austrittsquerschnitt beschrieben. Aus Querschnitt und Massenstrom folgt seine Geschwindigkeit:
#form[$ A=frac(pi d^2,4) quad c=frac(dot(m)_"aus" v'',A) quad w_"VS,aus"=p v'' quad e_"aus"=h''+frac(c^2,2) $]
$c$ in m/s; $p$ in Pa und $v''$ in m³/kg liefern J/kg. Die angegebene *Verschiebearbeit* $p v''$ ist der positive Abgabebetrag beim Herausschieben. Sie steckt bereits in $h''=u''+p v''$ und wird in $e_"aus"$ nicht nochmals addiert. Bei $h''$ in kJ/kg wird der Geschwindigkeitsbeitrag durch 1000 umgerechnet. Lageenergien sind hier vernachlässigt.
#form[$ frac(dif U_"Sys",dif t)=dot(Q)-dot(m)_"aus" e_"aus" quad Q_01=Delta U+m_"aus" e_"aus" $]
*Voraussetzungen:* keine weitere Arbeit, vernachlässigbare äußere Speicherenergien und Topfwärmekapazität; gleichbleibende Austrittswerte. Im Topf wird $U$ gespeichert, der austretende Strom trägt dagegen $h''+c^2/2$. Wegen des konstanten gesamten $p V$ darf die Speicheränderung hier auch mit Enthalpien berechnet werden:
#form[$ Delta U=Delta H=(frac(h',v')-frac(h'',v''))Delta V' $]
Die spezifischen Phasenwerte bleiben konstant, ihre *Massen* ändern sich. Darum folgt aus konstantem Druck und konstanter Temperatur gerade nicht $Delta U=0$.
#bild("kochtopf-energie", [Leistungsbilanz von Ü 3.6: rund 528,80 W zugeführt, 639,14 W ausströmend, Speicheränderung −110,35 W. Eigene Nachrechnung nach M36, PDF-S. 2–3.], height: 45mm)
Für die elektrische Kochplatte gilt $P_"el"=dot(Q)/eta_"ges"$. Der Gesamtwirkungsgrad berücksichtigt laut Aufgabe bereits die Verluste bis zum Topf. Dieselben Verluste werden nicht zusätzlich ein zweites Mal abgezogen. Der größere ausströmende Energiestrom gegenüber der Heizleistung ist durch die Speicherabnahme gedeckt; die Energieerhaltung bleibt erfüllt.
#src[M36, PDF-S. 2–3; Ü 3.6, PDF-S. 21; BT 4.1, S. 92–93 / PDF-S. 112–113, und 4.4, S. 108 / PDF-S. 128. Instationärer Speicherterm nach M36; Zahlen mit ungerundeten Zwischenwerten nachgerechnet.]
#hoch(<a-3>, [Kapitelübersicht])

*Der Zusammenhang in Kapitel 3.* Systemgrenze, Speicheränderung und Stoffzustand bestimmen die Energiebilanz. Der Prozessweg legt die Arbeitsintegrale fest; Wärme- und Verschiebearbeit dürfen nicht doppelt gezählt werden. Wärmekapazitäten verbinden Temperatur- und Energieänderungen. Im Kreisprozess kehren die Zustandsgrößen zurück, während Nettoübertragungen bleiben; Düse, Drossel und Heizregister zeigen verschiedene Bilanzvereinfachungen. Beim Dampfkochtopf bleiben Druck und Temperatur konstant, während Masse und Speicherenergie abnehmen. Kapitel 4 prüft anschließend, welche dieser energetisch gedachten Abläufe auch möglich sind.
#pagebreak()
= Kapitel 4 · Zweiter Hauptsatz und Zustandsdiagramme <a-4>
#überblick([Kapitel 4 auf einen Blick],
 idee(<a-4-1>, [Energieerhaltung legt die Richtung noch nicht fest.], [Irreversibilität beschreibt die gemeinsame Rückkehr von System und Umgebung.]),
 idee(<a-4-2>, [Entropie wird transportiert und erzeugt.], [Wärme und Stoff tragen sie über Grenzen; innere Erzeugung ist niemals negativ.]),
 idee(<a-4-4>, [Ein Diagramm zeigt Bedingungen als Linien.], [Erst Achsen und konstant gehaltene Größe nennen, dann den Zustandsweg lesen.]),
 idee(<a-4-7>, [Kreisprozesse verbinden Wärme und Arbeit.], [Rankine, Plank und Carnot anhand der Richtung und der Bauteile erklären.]),
 idee(<a-4-8>, [Weg und Umlaufrichtung bestimmen die Flächendeutung.], [h-s-Strecken und Nettoflächen mit der Bilanz verknüpfen.]),
 idee(<a-4-9>, [Exergie bewertet die Arbeitsfähigkeit gegenüber der Umgebung.], [Offen oder geschlossen rechnen und Entropieerzeugung als Verlust erkennen.]),
)
#karte((1fr, auto, 1fr),
 chunk([Richtung prüfen], [reversibel · irreversibel · unmöglich], ziel: <a-4-1>), pfeil(), chunk([Entropie bilanzieren], [Transport + Erzeugung], ziel: <a-4-2>),
 chunk([Werte bestimmen], [Stoffmodell · Tabellen · Δs], ziel: <a-4-3>), pfeil(), chunk([Weg darstellen], [T-s · h-s · lg(p)-h], ziel: <a-4-4>),
 chunk([Kreisprozess auswerten], [Wärme · Arbeit · Richtung], ziel: <a-4-8>), pfeil(), chunk([Arbeitsfähigkeit bewerten], [Umgebung · Exergie · Verlust], ziel: <a-4-9>),
)
#hoch(<ueberblick>, [Modul auf einen Blick])
Der erste Hauptsatz sagt, *wie viel Energie* ausgetauscht wird. Der zweite prüft, *in welcher Richtung* ein Prozess ablaufen kann. Die neue Zustandsgröße Entropie macht diese Prüfung berechenbar; Diagramme verbinden sie mit den schon bekannten Stoffgrößen.
#src[Eigene Zusammenführung der behandelten Folien N04, PDF-S. 4–11; handschriftliches Ende VL 4.11. auf PDF-S. 11.]

#pagebreak()
== 4.1 Reversibel und irreversibel: Energie allein genügt nicht <a-4-1>
Ein fallendes Gewicht treibt einen Rührer an und erwärmt ein Fluid. Die Energie des Gewichts verschwindet nicht: Sie erhöht die innere Energie des Fluids. Bloßes Abkühlen des Fluids setzt den Rührer jedoch nicht von selbst rückwärts in Bewegung und hebt das Gewicht wieder an.
#bild("joule-prozess", [Joules Schaufelradprozess als Richtungskette. Eigene Darstellung nach N04, PDF-S. 4.], height: 51mm)
#form[$ m_"Sys" c_v(T_2-T_1)=m_"Gewicht" g(z_1-z_2)>0 $]
*Voraussetzungen dieses Beispiels:* ideales Gas mit konstantem $c_v$, adiabater starrer Fluidbehälter; übertragene Arbeit gelangt vollständig in dessen innere Energie. Mit J/(kg K), kg, m und m/s² steht auf beiden Seiten J.
Ein Prozess heißt *reversibel*, wenn System und Umgebung gemeinsam ohne bleibende Änderung zurückgeführt werden könnten. *Irreversibel* bedeutet, dass dies nicht möglich ist. Das System allein kann unter Umständen zurückgesetzt werden; die dafür veränderte Umgebung muss mitbetrachtet werden.
#note("Folienhinweis zur Umkehrung", [Die auf N04, PDF-S. 4, durchgestrichene Umkehrungszeile ist keine verwendbare Prozessgleichung. Die Energiegleichung für den Rührvorgang erlaubt keine selbsttätige Rückumwandlung durch Abkühlen. Einheiten und mögliche Prozessrichtung müssen beide stimmen.], fill: sand)
Reibung, Temperaturausgleich über endliche Unterschiede, Mischung und Drosselung sind Beispiele für irreversible Vorgänge. Ein langsamer Prozess ist deshalb noch nicht reversibel: Vorhandene Reibung verschwindet durch Langsamkeit nicht automatisch.
#src[N04, PDF-S. 4; BT 5.1, S. 127–130 / PDF-S. 147–150. Reversibilität bereits in 1.10 vorbereitet; Modellbedingungen ergänzt.]
#hoch(<a-4>, [Kapitelübersicht])

#pagebreak()
== 4.2 Entropie und Entropiestrom bilanzieren <a-4-2>
*Entropie* $S$ ist eine additive Zustandsgröße. Für eine homogene Portion ist $S=m s$; ein Stoffstrom transportiert $dot(S)=dot(m)s$. Entropie wird außerdem mit Wärme übertragen und im Inneren durch irreversible Vorgänge erzeugt. Diese drei Beiträge dürfen nicht verwechselt werden.
#bild("entropie-bilanz", [Speicherung, Transport und Erzeugung. Eigene Darstellung nach N04, PDF-S. 5–7.], height: 56mm)
$S$ in J/K oder kJ/K; $s$ in J/(kg K) oder kJ/(kg K); $dot(S)$ in W/K oder kW/K. Eine Arbeitsübertragung allein transportiert keine Entropie. Wird übertragene Arbeit im System dissipiert, kann dort jedoch Entropie entstehen.

=== 4.2.1 Geschlossen: Wärmetransport und innere Erzeugung <a-4-2-1>
#form[$ dif S=frac(delta Q,T_b)+dif S_"erz" quad dif S_"erz">=0 $]
$T_b$ ist die absolute Temperatur an der betrachteten Wärmeübertragungsgrenze. Bei mehreren Wärmeübertragungen werden ihre Beiträge einzeln bilanziert. Wärmeabgabe zählt negativ; deshalb darf die Entropie eines gekühlten Systems sinken. Die *Erzeugung* bleibt trotzdem nichtnegativ.
Für das Folienmodell eines einfachen kompressiblen Stoffes mit Dissipationsarbeit $J$ wird der Erzeugungsbeitrag als $delta J/T$ geschrieben:
#form[$ dif S=frac(delta Q,T)+frac(delta J,T) quad S_2-S_1=integral_1^2 frac(delta Q,T)+integral_1^2 frac(delta J,T) $]
Hier ist $T$ die zum jeweiligen differentiellen Modellschritt gehörige Temperatur. Allgemeine Irreversibilitäten werden sicher mit $S_"erz"$ bilanziert; sie müssen nicht als eine zusätzlich über die Grenze zugeführte Reibungsenergie auftreten.
#note("Die Bedingung gehört zur Aussage", [In einem *adiabaten geschlossenen* System kann die Entropie niemals abnehmen: $Delta S>=0$. Bei reversiblem Verlauf bleibt sie gleich. Ohne „adiabat“ darf $Delta S<0$ durch Wärmeabgabe möglich sein; ohne „geschlossen“ muss der Stofftransport berücksichtigt werden.], fill: sand)
#src[N04, PDF-S. 6–7 und handschriftliche Herleitung auf PDF-S. 9; BT 5.2, Gl. (5.15) und (5.20)–(5.21), S. 134–135 / PDF-S. 154–155. Grenztemperatur und allgemeine Erzeugungsnotation ergänzend präzisiert.]

#pagebreak()
=== 4.2.2 Offen: Entropie reist mit dem Stoff <a-4-2-2>
Für ein stationäres System mit einem Ein- und Austritt gilt:
#form[$ dot(m)(s_2-s_1)=sum_i frac(dot(Q)_i,T_(b,i))+dot(S)_"erz" $]
Bei adiabatem Betrieb bleibt rechts nur die Erzeugung. Reversibel und adiabat liefert daher $s_2=s_1$: der Prozess ist *isentrop*. Eine adiabate Drossel erzeugt dagegen Entropie und ist trotz $h_2 approx h_1$ im Allgemeinen nicht isentrop.
Ein unveränderter Entropiespeicher im stationären Gerät verlangt nicht $s_2=s_1$: Erzeugte Entropie kann laufend mit dem austretenden Stoff abgeführt werden. Auch eine zufällig gleiche Entropie an Ein- und Austritt beweist allein keine Reversibilität; Wärmeabgabe und Erzeugung könnten sich kompensieren.
#src[N04, PDF-S. 5 und 7; BT 5.2, Gl. (5.22)–(5.24), S. 135–136 / PDF-S. 155–156.]

=== 4.2.3 Gibbs verbindet Stoffzustand und Entropie <a-4-2-3>
Für einen einfachen kompressiblen Stoff bei fester Zusammensetzung verbindet die *Gibbs'sche Fundamentalgleichung* die Zustandsgrößen:
#form[$ T dif s=dif u+p dif v=dif h-v dif p $]
Mit J/kg, Pa und m³/kg ergibt der Zähler J/kg und nach Division durch K die Einheit J/(kg K). Die Zustandsbeziehung liefert Entropieunterschiede zwischen passenden Gleichgewichtszuständen. Sie behauptet nicht, dass der tatsächliche Prozess zwischen ihnen reversibel gewesen sein muss.
#bild("map-entropie", [Mindmap: Entropie als Zustand, Transport und Erzeugung. Eigene Darstellung.], height: 45mm)
#note("Mitschrift vom 10.11. präzisiert", [*Starr* bedeutet konstantes Volumen; daraus folgt nicht allgemein Reibungsfreiheit oder $j=0$. Auch ein Rührer im starren Gefäß kann Entropie erzeugen. Nur wenn zusätzlich keine innere Dissipation vorliegt, fällt dieser Beitrag weg. Eine Entropieabnahme durch Kühlung ist dennoch möglich, wenn mehr Entropie abgeführt als erzeugt wird.], fill: sand)
#src[N04, PDF-S. 5–7; N10, PDF-S. 1 (präzisierte Mitschrift); BT 5.2, Gl. (5.11), S. 133 / PDF-S. 153. Voraussetzungen der Stoffbeziehung ausdrücklich ergänzt.]
#hoch(<a-4>, [Kapitelübersicht])

#pagebreak()
== 4.3 Entropiedifferenzen aus Zuständen berechnen <a-4-3>
Der tatsächliche Weg kann irreversibel sein; die Entropiedifferenz bleibt eine Zustandsdifferenz. Wähle deshalb zuerst ein passendes Stoffmodell und die zwei Endzustände. Die Berechnung aus bekannten Prozessbeiträgen ist ein zweiter Weg und kann als Kontrolle dienen.

=== 4.3.1 Ideales Gas und inkompressible Stoffe <a-4-3-1>
Für ideale Gase mit konstanten Wärmekapazitäten gelten drei gleichwertige Schreibweisen:
#form[$ s_2-s_1=c_p ln(T_2/T_1)-R ln(p_2/p_1) $]
#form[$ s_2-s_1=c_v ln(T_2/T_1)+R ln(v_2/v_1)=c_v ln(p_2/p_1)+c_p ln(v_2/v_1) $]
Alle Temperaturen in *Kelvin*, Drücke absolut; die Größen in jedem Verhältnis haben dieselbe Einheit. $c_p,c_v,R$ in kJ/(kg K) liefern $Delta s$ in kJ/(kg K). $Delta S=m Delta s$ gilt bei konstanter Masse. Bei temperaturabhängigen Wärmekapazitäten muss der Temperaturterm passend integriert werden; ein Bereichsmittel für $Delta h$ ist nicht automatisch das richtige Mittel im Entropieintegral $integral c_p(T)/T dif T$.
Für näherungsweise inkompressible Festkörper und Flüssigkeiten mit konstantem $c$:
#form[$ Delta s=c ln(T_2/T_1) quad Delta S=m c ln(T_2/T_1) $]
Ein abkühlender Stahlblock hat damit $Delta S<0$. Ob der Gesamtprozess reversibel ist, zeigt erst die Bilanz *einschließlich Umgebung* und deren positiver Entropieaufnahme.
#src[N04, PDF-S. 8 und Beispiel IV-2 auf PDF-S. 10; BT 5.2, S. 137 / PDF-S. 157. Hinweis auf temperaturabhängige Integrale aus Gibbs und Definition des kalorischen Modells ergänzt.]

=== 4.3.2 Reale Fluide und Phasenwechsel <a-4-3-2>
Bei realen Fluiden werden $s_1,s_2$ aus denselben passenden Tabellen ermittelt. Im Nassdampfgebiet gilt die Massenmischungsregel; für einen vollständigen Phasenwechsel im Sättigungsgleichgewicht:
#form[$ s=s'+x(s''-s') quad s''-s'=frac(h''-h',T_s) $]
$T_s$ in K; kJ/kg geteilt durch K ergibt kJ/(kg K). Der Tabellen-Nullpunkt fällt bei konsistent gebildeten Differenzen heraus. Entropie und Entropiestrom bleiben verschiedene Bezugsgrößen: In einer stationären Rechnung wird mit $dot(m)Delta s$ daraus eine Stromdifferenz.
#src[N04, PDF-S. 8; BT 5.2, Gl. (5.25)–(5.28), S. 137 / PDF-S. 157.]

#pagebreak()
=== 4.3.3 Turbine und blockierte Turbine vergleichen <a-4-3-3>
#bild("turbine-hs-vergleich", [Endzustandsvergleich zu IV-3. Eigene Darstellung nach N04, PDF-S. 10, und BT A.8, PDF-S. 505 und 507; Tabellenpunkte linear verbunden.], height: 61mm)
Die isentrope Vergleichsturbine expandiert vom gegebenen Anfangszustand bis zum gleichen Enddruck bei $s_(2s)=s_1$. Die reale adiabate Turbine hat wegen innerer Irreversibilität eine kleinere Arbeitsabgabe:
#form[$ eta_("is,T")=frac(h_1-h_2,h_1-h_(2s)) quad P_t=dot(m)(h_2-h_1) quad dot(S)_"erz"=dot(m)(s_2-s_1)>=0 $]
*Gültigkeit:* stationär, adiabat, Änderungen äußerer Energie vernachlässigt; $h$ in kJ/kg und $dot(m)$ in kg/s liefern kW. Der Vergleich bei *gleichem Anfangszustand und gleichem Enddruck* ist wesentlich.
Ist die Turbine blockiert und strömt der Dampf ohne Arbeitsabgabe hindurch, wird sie im Folienmodell zur Drossel: $P_t=0$, $h_2=h_1$, aber $s_2>s_1$.
#note("Verlust eindeutig benennen", [Aus dem Gütegrad lässt sich die *Leistungsminderung gegenüber der isentropen Vergleichsturbine* berechnen: $P_"Verlust"=dot(m)(h_2-h_(2s))$. Sie beschreibt entgangene Wellenleistung und keine vernichtete Energie. Eine genaue Dissipationsarbeit $j=integral T dif s$ wäre zusätzlich eine Prozessgröße; sie ist nicht ohne Prozessverlauf mit jeder solchen Vergleichsdifferenz identisch. Der Folienauftrag IV-3 verwendet „dissipierte Leistung“, ohne diese Unterscheidung weiter festzulegen.], fill: sand)
#src[N04, PDF-S. 10 (IV-3); BT 5.1, S. 129–131 / PDF-S. 149–151, und 6.3, Definition des isentropen Gütegrades. Verlustbegriff und fehlende Prozessangabe sichtbar abgegrenzt.]
#hoch(<a-4>, [Kapitelübersicht])

#pagebreak()
== 4.4 Zustandsdiagramme und Isolinien lesen <a-4-4>
Eine *Isolinie* verbindet Zustände, bei denen eine gewählte Größe konstant bleibt. Ihr Aussehen hängt von den Achsen ab. „Senkrecht“ oder „waagerecht“ ist deshalb keine universelle Eigenschaft eines Prozesses.
#bild("zustandsdiagramme-achsen", [Achsen und ausgewählte Isolinien. Eigene schematische Darstellung nach N04, PDF-S. 11; keine maßstäblichen Stoffdiagramme.], height: 60mm)
#tab(columns: (1fr, 1.3fr, 1.6fr),
 th([Diagramm], [Achsen], [Direkt erkennbare Linien]),
 [T-s], [Waagerecht $s$, senkrecht $T$.], [Isentrope senkrecht, Isotherme waagerecht.],
 [h-s], [Waagerecht $s$, senkrecht $h$.], [Isentrope senkrecht, Isenthalpe waagerecht.],
 [lg(p)-h], [Waagerecht $h$, senkrecht logarithmischer Absolutdruck.], [Isenthalpe senkrecht, Isobare waagerecht.],
)
*Isotherm:* $T$ konstant. *Isobar:* $p$ konstant. *Isochor:* $v$ konstant. *Isentrop:* $s$ konstant. *Isenthalp:* $h$ konstant. *Isovapor / Isohygre:* Dampfgehalt $x$ konstant; diese Bezeichnung gehört zum Zweiphasengebiet.
Die Lesereihenfolge lautet: Achsen benennen, Zustandsgebiet erkennen, konstant gehaltene Größe nennen und den Verlauf zur gesuchten Größe verfolgen. Im lg(p)-h-Diagramm bedeutet eine Kurve etwa: Wie verändert sich der Druck mit der Enthalpie, wenn die auf der Kurve angegebene Größe konstant bleibt?
#note("Von dir markiert", [N28, PDF-S. 4, verlangt mit „\@KI“ auch ein selbst gezeichnetes Zustandsdiagramm für die Prüfung. N04, PDF-S. 11, ist ebenfalls mit „In der Prüfung machen“ markiert. Dazu gehören benannte Achsen, Anfang/Ende, Prozessrichtung und die konstant gehaltene Größe.])
Eine Fläche im T-s-Diagramm ist nur bei einem *reversiblen* Weg unmittelbar die spezifische Wärme $q_"rev"=integral T dif s$. Bei Irreversibilität enthält $T dif s$ auch die Entropieerzeugung; die Fläche darf dann nicht ungeprüft als tatsächliche Wärmezufuhr gelesen werden.
#src[N03, PDF-S. 1–2; N04, PDF-S. 11 und Ende VL 4.11.; N28, PDF-S. 4; ergänzend BT 5.3, S. 138–140 / PDF-S. 158–160.]
#hoch(<a-4>, [Kapitelübersicht])


#pagebreak()
== 4.5 Ergänzung 10.11. · Flächen im T-s-Diagramm <a-4-5>
Eine Fläche ist erst dann eine Energieaussage, wenn du den Prozessweg und seine Voraussetzungen kennst. Wie bei einer Landkarte genügt die Form einer Linie allein nicht: Auch die Achsen und ihre Einheiten gehören zur Bedeutung.
#bild("ts-prozessflaechen", [Wärme und Dissipation im T-s-Diagramm. N10, PDF-S. 7 / Folie 04-12.], height: 73mm)
Im Folienmodell des einfach kompressiblen Fluids gilt mit der spezifischen Dissipationsarbeit $j_12>=0$:
#form[$ integral_1^2 T dif s=q_12+j_12 $]
$T$ in K und $s$ in kJ/(kg K) ergeben kJ/kg. Bei reibungsfreiem, intern reversiblem Verlauf ist $j=0$ und die Fläche entspricht $q$. Adiabat mit Reibung ist $q=0$ und die Fläche entspricht $j$. Bei Kühlung können sich $q<0$ und $j>0$ gerade aufheben: Dann ist der Verlauf isentrop, aber nicht reversibel.
#note("Gültigkeit", [Die allgemeine Entropiebilanz verwendet die tatsächlichen Grenztemperaturen der Wärmekontakte. Die Foliengleichung $T dif s=delta q+delta j$ setzt die dort modellierte lokale Fluidtemperatur und eine passende Aufteilung voraus; $j$ ist nicht pauschal jede Differenz zweier Turbinenleistungen.], fill: sand)
#src[N10, PDF-S. 1–3 und 7 / Folie 04-12; Unterscheidung von lokaler Folienbeziehung und allgemeiner Bilanz aus 4.2 ergänzt.]
#hoch(<a-4>, [Kapitelübersicht])

#pagebreak()
== 4.6 Ergänzung 10.11. · Isochore, Isobare und Phasengrenze <a-4-6>
Gibbs verbindet dieselbe Fläche mit Zustandsgrößen. Deshalb kann eine Flächenaussage auch gelten, wenn der Wärmeaustausch nicht allein aus der Fläche ablesbar ist.
#bild("ts-zustandsflaechen", [Zustandsgrößen aus Flächen. N10, PDF-S. 8 / Folie 04-13.], height: 75mm)
#form[$ v="konstant": integral_1^2 T dif s=u_2-u_1 quad p="konstant": integral_1^2 T dif s=h_2-h_1 $]
#note("Korrektur der Tutoriumsmitschrift", [T12, PDF-S. 5, vertauscht beide Vorzeichen. Richtig ist $T dif s=dif h-v dif p=dif u+p dif v$. Das folgt aus $h=u+p v$. Auf PDF-S. 6 steht beim isothermen Hilfsschritt $dif v=0$; Isothermie allein fordert das nicht. Im hier zusätzlich inkompressiblen Stoffmodell ist $dif v approx 0$ eine eigene Näherung.], fill: sand)
Die erste Beziehung folgt aus $T dif s=dif u+p dif v$ mit $dif v=0$, die zweite aus $T dif s=dif h-v dif p$ mit $dif p=0$. Beide beschreiben einen Weg auf der jeweiligen Gleichgewichtslinie. Im Zweiphasengebiet eines reinen Stoffes sind Isobare und Isotherme dieselbe Sättigungsstrecke:
#form[$ h''-h'=T_s(s''-s') quad frac(dif p_s,dif T)=frac(h''-h',T(v''-v'))=frac(s''-s',v''-v') $]
Dies ist die *Clausius-Clapeyron-Gleichung* entlang der Phasengrenze. Bei Verdampfung sind Zähler und Volumendifferenz positiv: Mit steigender Sättigungstemperatur steigt der Sättigungsdruck. Für die Schmelzkurve von Wasser ist die Volumenänderung andersherum; die Steigung kann negativ sein.
#note("Fehler vermeiden", [Die Folien zeichnen oft °C an die T-Achse. Eine Energiefläche muss trotzdem von *0 K* aus gemessen werden. Rechne deshalb die Achsenwerte zuerst um: $T/"K"=vartheta/"°C"+"273,15"$, dann integrieren.], fill: sand)
#src[N10, PDF-S. 8 und 11 / Folien 04-13 und 04-16; T12, PDF-S. 5–6; eigene Ableitung aus Gibbs.]
#hoch(<a-4>, [Kapitelübersicht])

#pagebreak()
== 4.7 Ergänzung 10.–11.11. · Rankine, Plank und Carnot <a-4-7>
Kreisprozesse setzen die einzelnen Bauteilbilanzen zu einem Umlauf zusammen. Eine Wärmekraftmaschine gibt Arbeit ab; eine Kältemaschine oder Wärmepumpe braucht Arbeit, um Wärme vom kalten zum warmen Niveau zu bringen.
=== 4.7.1 Rankine: Dampf verrichtet Arbeit <a-4-7-1>
#bild("rankine-vorlesung", [Clausius-Rankine-Prozess. N10, PDF-S. 12 / Folie 04-17.], height: 61mm)
Die Pumpe hebt den Druck der Flüssigkeit an. Der Dampferzeuger erwärmt, verdampft und überhitzt bei näherungsweise konstantem Druck. Die Turbine expandiert im Idealvergleich isentrop; im realen adiabaten Fall steigt $s$. Der Kondensator führt Wärme ab und verflüssigt das Wasser. Die Arbeit der Pumpe wird von der Turbinenabgabe abgezogen.
#form[$ eta_"th"=frac(abs(w_"T")-w_"P",q_"zu")=1-frac(abs(q_"ab"),q_"zu") $]
Stationärer Umlauf; äußere Energieänderungen vernachlässigt. Alle spezifischen Energiebeiträge in kJ/kg; $w_"P">0$, $w_"T"<0$ in der Zufuhrkonvention.

#pagebreak()
=== 4.7.2 Plank: Mit Arbeit Wärme anheben <a-4-7-2>
#bild("plank-vorlesung", [Plank-Prozess der Vorlesung. N10, PDF-S. 13 / Folie 04-18.], height: 63mm)
Im *Verdampfer* nimmt das Kältemittel bei niedrigem Druck Wärme auf. Der *Verdichter* braucht Arbeit und hebt den Druck an. Im *Verflüssiger* gibt das Kältemittel Wärme bei höherem Druck ab. Die *Drossel* senkt den Druck ohne technische Arbeitsabgabe; im Modell bleibt die Enthalpie konstant. Eine Drossel ist auch im sonst idealisierten Kreislauf irreversibel.
#form[$ epsilon_"K"=frac(q_"kalt",w_"zu") quad epsilon_"WP"=frac(abs(q_"warm"),w_"zu")=epsilon_"K"+1 $]
Diese *Leistungszahlen* vergleichen den jeweils gewünschten Wärmestrom mit dem Arbeitsaufwand; sie dürfen größer als eins sein. Die letzte Beziehung verlangt dieselben Systemgrenzen und vollständige Bilanzierung.

#pagebreak()
=== 4.7.3 Carnot: reversibler Vergleich zwischen zwei Temperaturen <a-4-7-3>
#bild("carnot-ts-rechteck", [Carnot im T-s-Diagramm. Eigene schematische Darstellung nach N11, PDF-S. 1–2; nicht maßstäblich.], height: 52mm)
Die überlieferten Seiten zeigen vier Schritte: 1→2 reversibel adiabate Verdichtung, 2→3 isotherme Wärmezufuhr bei $T_H$, 3→4 reversibel adiabate Expansion, 4→1 isotherme Wärmeabfuhr bei $T_K$. Auf den Isentropen wird keine Wärme übertragen. Die beiden Isothermen haben dieselbe Entropiebreite $Delta s$.
#form[$ q_"zu"=T_H Delta s quad abs(q_"ab")=T_K Delta s quad eta_C=1-frac(T_K,T_H) $]
$T_H>T_K>0$ in *Kelvin*. Die letzte Gleichung folgt direkt aus der Kreisprozessbilanz und der Rechteckfläche. Sie ist der reversible Vergleich für genau zwei konstante Temperaturniveaus; reale Irreversibilität senkt die erreichbare Arbeitsausbeute.
#note("★ Klausur · von dir markiert", [N10, PDF-S. 3, nennt ausdrücklich „Aufgabe 1 Prüfung = Entwicklung Zustandsdiagramm (eher Ts-Diagramm)“. Benenne Achsen, Zustände, Laufrichtung, konstante Größen und die Bedeutung der Flächen. N11 zeigt den Carnot-Weg. Die zusätzlich von dir bestätigten Folien 04-19–24 werden in 4.8 ergänzt; Exergie ab 04-30 folgt in 4.9.])
#bild("map-diagramme", [Mindmap: Zustandsdiagramme und Kreisprozesse. Eigene Darstellung.], height: 46mm)
#src[N10, PDF-S. 12–13 / Folien 04-17–18; N11, PDF-S. 1–2 / Folie 04-25 und Mitschrift. Leistungszahlen und Carnot-Formel aus den gezeigten Energiebilanzen bzw. Flächen hergeleitet (eigene Ergänzung).]
#hoch(<a-4>, [Kapitelübersicht])


#pagebreak()
== 4.8 Ergänzung · h-s-Strecken und allgemeine Kreisprozesse <a-4-8>
Ein Diagramm ändert nicht die Energiebilanz, sondern zeigt sie anders. Im h-s-Bild liest du Enthalpiedifferenzen direkt als Höhenunterschiede ab; im T-s-Bild brauchst du für Energieaussagen Flächen und die zugehörigen Prozessbedingungen.
#bild("hs-ts-vergleich", [Derselbe Dampfprozess in zwei Diagrammen. V04, PDF-S. 19 / Folie 04-19.], height: 67mm)
#form[$ q_"Kessel"=h_5-h_2 quad w_"T"=h_6-h_5 quad w_"P"=h_2-h_1 $]
*Voraussetzungen:* stationäre Bauteile; Kessel ohne technische Arbeit, Turbine und Pumpe adiabat; Änderungen äußerer Energien vernachlässigt. Die Turbinenarbeit ist in Zufuhrkonvention negativ. Rechts vom isentropen Vergleich liegt bei gleichem Enddruck eine größere Austrittsenthalpie: weniger Abgabe. Nicht jede beliebige h-Differenz ist automatisch Wärme oder Arbeit.
#note("Genaue Lesart der Folie", [„Technische Arbeit im T-s-Diagramm nicht darstellbar“ meint: keine allgemeine unmittelbare Arbeitsstrecke. Mit Prozessmodell und Bilanz kann Arbeit sehr wohl berechnet werden; beim reversiblen vollständigen Umlauf entspricht die eingeschlossene Wärmefläche dem Betrag der Nettoarbeit.], fill: sand)
#src[V04, PDF-S. 19; Bauteilbilanzen aus 3.10 und 4.7.1. Präzisierung der verkürzten Bildunterschrift als eigene Ergänzung.]

#pagebreak()
=== 4.8.1 Rechts- und linksläufig: dieselbe Bilanz, anderer Nutzen <a-4-8-1>
#bild("kreisprozess-flaechen", [Arbeits- und Wärmeflächen im Umlauf. V04, PDF-S. 24 / Folie 04-24.], height: 70mm)
Die Wärmekraftmaschine verdichtet auf dem kälteren und expandiert auf dem heißeren Weg. So ist die Arbeitsabgabe größer als die Aufnahme. Beim umgekehrten Umlauf ist die Nettoarbeit aufzuwenden; damit wird Wärme vom kalten zum warmen Niveau transportiert. Bei einer Kolbenmaschine wechseln die Schritte zeitlich, bei durchströmten Bauteilen liegen sie an verschiedenen Orten.
#form[$ W_"netto"=-(Q_"zu"+Q_"ab") quad P_"netto"=-(dot(Q)_"zu"+dot(Q)_"ab") $]
$Q_"ab"<0$; rechtsläufig ist $W_"netto"<0$, linksläufig $W_"netto">0$. $W,Q$ sind Energien in kJ, $P,dot(Q)$ Leistungen in kW. Stationärer Kreislauf bzw. vollständiger Umlauf ohne verbleibende Änderung gespeicherter Energie.
#form[$ w_v=-integral.cont p dif v quad w_p=integral.cont v dif p=-integral.cont p dif v $]
Die beiden Umlaufintegrale sind gleich, weil $integral.cont dif(p v)=0$. Die erste Formel beschreibt quasistatische Volumenarbeit eines geschlossenen Systems, die zweite reversible Druckarbeit eines durchströmten Kreises. Bei realer Dissipation muss deren Beitrag zur Gesamtarbeit zusätzlich berücksichtigt werden.
#note("Tutorium · Vorzeichen und Flächen", [T12, PDF-S. 1, schreibt verkürzt $integral p dif v=w$ und $integral T dif s=q$. In unserer Zufuhrkonvention gilt geschlossen $w_v=-integral p dif v$; offen ist Druckarbeit $integral v dif p$. Die T-s-Fläche ist nur im passenden reversiblen Modell allein Wärme, sonst im Folienmodell $q+j$. Im p-v-Bild heißt Expansion Bewegung nach rechts; ein Druckabfall allein beweist keine Expansion.], fill: sand)
#src[V04, PDF-S. 20–24; T12, PDF-S. 1. Vorzeichen aus der im Skript durchgehend verwendeten Zufuhrkonvention; Umlaufintegral durch partielle Integration ergänzt.]
#hoch(<a-4>, [Kapitelübersicht])

#pagebreak()
== 4.9 Ergänzung · Exergie und Anergie <a-4-9>
Gleich viel Energie kann unterschiedlich viel Arbeit ermöglichen. Ein warmer Speicher in einer kalten Umgebung besitzt einen Temperaturunterschied, den eine ideale Maschine nutzen kann; derselbe Speicher bei Umgebungstemperatur bietet diese Möglichkeit nicht mehr.
#bild("map-exergie", [Mindmap zur Exergie. Eigene Darstellung nach V04, PDF-S. 30–39.], height: 46mm)
*Exergie* ist die maximal nutzbare Arbeit beim reversiblen Übergang zum festgelegten Umgebungszustand. *Anergie* ist der verbleibende, unter diesen Bedingungen nicht in Arbeit umwandelbare Energieanteil. „Nutzlos“ auf der Folie meint nur die fehlende Arbeitsfähigkeit gegenüber dieser Umgebung: Wärme kann für einen anderen Zweck weiterhin brauchbar sein. Energie bleibt erhalten, Exergie kann durch Irreversibilität vernichtet werden.
$E$ in kJ, $dot(E)$ in kW, $e$ in kJ/kg. Mechanische und elektrische Arbeit sind vollständig Exergie. Thermische Energie wird erst nach Angabe von Umgebungstemperatur $T_"∞"$ und gegebenenfalls Umgebungsdruck $p_"∞"$ bewertet.
#note("Modellgrenze im Wasserbeispiel", [V04, PDF-S. 30, kühlt Wasser rechnerisch von 50 auf −50 °C mit konstantem $c_p$ ohne Phasenwechsel. Das erklärt die Umgebungsabhängigkeit, ist aber kein physikalisch vollständiger Gefriervorgang: Bei gewöhnlichem Druck müsste Eisbildung mit Schmelzwärme und anderen Wärmekapazitäten berücksichtigt werden. Der Folienwert rund 7,3 MJ gilt nur für das vereinfachte Stoffmodell.], fill: sand)
#src[V04, PDF-S. 30–31; BT 5.5, S. 157–159 / PDF-S. 177–179. Modellgrenze anhand der Phasenlehre aus Kapitel 2 ergänzt.]

=== 4.9.1 Exergie der Wärme: Carnot-Faktor am Wärmekontakt <a-4-9-1>
#form[$ E_(Q,12)=integral_1^2 (1-frac(T_"∞",T_b)) delta Q quad T_b="konstant": E_Q=(1-frac(T_"∞",T_b))Q $]
$T_b$ ist die absolute Temperatur, bei der die Wärmeübertragung bewertet wird; die Umgebung bleibt bei $T_"∞"$. Für $T_b>T_"∞"$ und positive Wärmezufuhr liegt der Exergieanteil zwischen null und $Q$. Bei Umgebungstemperatur ist er null. Für wechselnde Temperatur darf ein einzelner Carnot-Faktor nicht ungeprüft vor das Integral gezogen werden.
#form[$ B_Q=Q-E_Q quad T_b="konstant": B_Q=frac(T_"∞",T_b)Q $]
Unter Umgebungstemperatur kann der *gerichtete* Exergietransport ein anderes Vorzeichen als der Wärmetransport haben. Zum Kälteerzeugen ist Arbeitsfähigkeit aufzuwenden; „Exergieanteil“ ist dann kein stets positives Stück eines Wärmestrompfeils.
#note("Endlicher Speicher", [Für einen inkompressiblen Körper mit konstantem $c$, ohne Phasenwechsel und ohne Lage-/Bewegungsänderung folgt bei gleichem Umgebungsdruck: $E=m c[(T_1-T_"∞")-T_"∞" ln(T_1/T_"∞")]$. Die Temperatur des Körpers sinkt beim Entladen; deshalb ist sein anfänglicher Carnot-Faktor nicht für die gesamte abgegebene Wärme gültig.])
#src[V04, PDF-S. 30–31; BT 5.5, S. 159–161 / PDF-S. 179–181. Speicherformel durch Integration ergänzt.]

#pagebreak()
=== 4.9.2 Offener Stoffstrom und geschlossene Masse <a-4-9-2>
Wähle zuerst die Systemart. Im Stoffstrom steckt die Verschiebearbeit in der Enthalpie. Bei einer geschlossenen Masse geht die Volumenänderung gegen die Umgebung gesondert in die nutzbare Arbeit ein.
#form[$ e_"offen"=(h_1-h_"∞")-T_"∞"(s_1-s_"∞")+frac(c_1^2-c_"∞"^2,2)+g(z_1-z_"∞") $]
#form[$ e_"geschlossen"=(u_1-u_"∞")+p_"∞"(v_1-v_"∞")-T_"∞"(s_1-s_"∞")+frac(c_1^2-c_"∞"^2,2)+g(z_1-z_"∞") $]
$E=m e$ für die Masse und $dot(E)=dot(m)e$ für den stationären Strom. In SI liefern $p$ in Pa, $v$ in m³/kg, $c$ in m/s und $g z$ in m²/s² zunächst J/kg. Bei $h,u$ in kJ/kg sind diese Beiträge durch 1000 umzurechnen. Alle Stoffwerte benutzen denselben Referenzzustand, dieselbe Zusammensetzung und dasselbe Stoffmodell; chemische Reaktionen sind hier nicht bewertet.
#note("Quellenkorrektur · Folie 04-32", [In der Klammer der *spezifischen* geschlossenen Formel muss $p_"∞"(v_1-v_"∞")$ stehen. Die groß geschriebenen $V$ der Folie würden nach Multiplikation mit $m$ die Einheit verfälschen. Gleichwertig extensiv ist $p_"∞"(V_1-V_"∞")$ außerhalb der Massenklammer.], fill: sand)
Für ideale Gase mit konstanten Wärmekapazitäten gilt $Delta h=c_p Delta T$, $Delta u=c_v Delta T$ und $Delta s=c_p ln(T_1/T_"∞")-R ln(p_1/p_"∞")$. Bei Wasserdampf werden passende Tabellenwerte statt eines pauschalen konstanten $c_p$ verwendet.
#src[V04, PDF-S. 32; BT 5.5, S. 161–163 / PDF-S. 181–183. Dimensionsprüfung und Umrechnung ergänzt.]

#pagebreak()
=== 4.9.3 Reversibler Weg und maximal nutzbare Arbeit <a-4-9-3>
#bild("exergie-weg", [Isentrope und Umgebungsisotherme als reversibler Weg. V04, PDF-S. 33 / Folie 04-33.], height: 66mm)
Ein geeigneter Vergleichsweg hat zwei Schritte: erst reversibel adiabat bis zur Umgebungstemperatur, dann reversibel isotherm bis zum Umgebungsdruck. Beim isothermen Schritt wird Wärme nur mit der Umgebung und im Grenzfall verschwindender Temperaturdifferenz übertragen. Je nach Anfangszustand kann einer der Schritte Verdichtung und Arbeitsaufnahme verlangen; entscheidend ist die Summe.
#form[$ W_"Nutz,rev"=-E_1 quad P_"rev"=-dot(E)_1 $]
Die negative Arbeit ist die maximal mögliche Abgabe in der Zufuhrkonvention. Für ein geschlossenes System ist die *Nutzarbeit* von der gesamten Grenzarbeit zu unterscheiden: $W_"Nutz"=W_v+p_"∞"(V_"∞"-V_1)$. Der Anteil zur Verdrängung der Umgebung steht nicht als zusätzliche Nutzarbeit zur Verfügung.
Für zwei vorgegebene Stromzustände ohne äußere Energieänderung und mit Wärme ausschließlich bei $T_"∞"$ gilt:
#form[$ w_(t,"rev",12)=(h_2-h_1)-T_"∞"(s_2-s_1)=e_2-e_1 $]
Der dargestellte Weg erreicht das Maximum; andere *reversible* Wege mit denselben äußeren Bedingungen können denselben Wert erreichen. Die Folienaussage „alle anderen Wege liefern weniger“ ist für irreversible Alternativen richtig, als pauschaler Ausschluss weiterer reversibler Anordnungen jedoch zu stark.
#src[V04, PDF-S. 32–38; BT 5.5, S. 161–163 / PDF-S. 181–183. Abgrenzung Nutz-/Gesamtarbeit und Präzisierung gleichwertiger reversibler Wege ergänzt.]

=== 4.9.4 Entropieerzeugung misst die verlorene Arbeitsfähigkeit <a-4-9-4>
#form[$ E_"V"=T_"∞" S_"erz">=0 quad dot(E)_"V"=T_"∞" dot(S)_"erz">=0 $]
Hier bedeutet Verlust stets den *positiven Betrag*. Bei einer stationären adiabaten Turbine ohne äußere Energieänderung folgt aus der Exergiebilanz:
#form[$ dot(E)_1+P=dot(E)_2+dot(E)_"V" quad dot(E)_"V"=dot(E)_1-dot(E)_2+P $]
$P<0$ bei Abgabe. Deshalb darf der ganze Exergieabfall nicht als Verlust gezählt werden: Ein Teil verlässt die Turbine als wertvolle Wellenleistung. Bei einer adiabaten Drossel mit unveränderter kinetischer Energie ist $P=0$; dort geht der gesamte Exergieabfall verloren.
#note("Quellenhinweis · Folie 04-39", [Die Folie nennt den negativen Rest $dot(E)_2-dot(E)_1-P$ „Verluststrom“. Unser positiver Verlustbetrag ist sein Gegenwert. Bei gleichem Zahlenmaterial stimmen die Bilanzen überein. Der Umgebungsdruck fehlt in der Aufgabenabbildung; absolute Exergieströme benötigen diese zusätzliche Angabe, ihre Differenz und der Verlust dagegen nicht.], fill: sand)
#src[V04, PDF-S. 39; BT 5.5, S. 163–165 / PDF-S. 183–185. Positive Verlustkonvention ausdrücklich gewählt.]
#hoch(<a-4>, [Kapitelübersicht])

#block(breakable: false)[
*Der Zusammenhang in Kapitel 4.* Reversibilität verlangt die gemeinsame Rückkehr von System und Umgebung. Die Entropiebilanz trennt dafür Transport und nichtnegative Erzeugung. Stoffmodelle und Tabellen liefern die Zustandsdifferenzen; die Diagramme machen ihren Zusammenhang mit Druck, Temperatur und Enthalpie sichtbar. Die neuen Flächenbeziehungen erklären Wärme, Dissipation und Zustandsdifferenzen. Rankine und Plank ordnen die Bauteile zu Kreisprozessen; Carnot liefert den reversiblen Temperaturvergleich. h-s-Strecken zeigen Bauteilenergien; Umlaufflächen erklären die Nettoarbeit. Exergie verbindet die erreichbare Nutzarbeit mit dem Umgebungszustand, Entropieerzeugung mit ihrem Verlust. Zusammen mit dem ersten Hauptsatz entsteht so eine doppelte Prüfung: Der Energieausgleich muss stimmen und die Entropieerzeugung darf nicht negativ sein.
#src[N04, PDF-S. 4–11; N10, PDF-S. 7–13; N11, PDF-S. 1–2; V04, PDF-S. 19–24 und 30–39; T12. Eigene Zusammenführung.]
]


#pagebreak()
= Kapitel 5 · Ideales Gas und Zustandsänderungen <a-5>
#überblick([Kapitel 5 auf einen Blick],
 idee(<a-5-1>, [Modell, Gas- und Normvolumen], [Absolutdruck, Kelvin und Mengenbezug festlegen.]),
 idee(<a-5-2>, [Kalorische Größen und Differentiale], [Wegunabhängige Stoffgrößen von Prozessgrößen trennen.]),
 idee(<a-5-3>, [Isolinien und Entropiedifferenz], [Das Diagramm vor der Rechnung lesen.]),
 idee(<a-5-4>, [Polytrope und Sonderfälle], [Zustandsweg bestimmen und Integrale passend auswerten.]),
 idee(<a-5-5>, [Offene Maschine, Kolben und Entleeren], [Druckarbeit, Dissipation und Speicherung unterscheiden.]),
)
#karte((1fr, auto, 1fr),
 chunk([Modell, Gas- und Normvolumen], [Absolutdruck, Kelvin und Mengenbezug festlegen.], ziel: <a-5-1>), pfeil(),
 chunk([Kalorische Größen und Differentiale], [Wegunabhängige Stoffgrößen von Prozessgrößen trennen.], ziel: <a-5-2>),
 chunk([Isolinien und Entropiedifferenz], [Das Diagramm vor der Rechnung lesen.], ziel: <a-5-3>), pfeil(),
 chunk([Polytrope und Sonderfälle], [Zustandsweg bestimmen und Integrale passend auswerten.], ziel: <a-5-4>),
)
#hoch(<ueberblick>, [Modul auf einen Blick])
Das ideale Gas ist das gemeinsame Rechenmodell vieler Verdichter-, Kolben- und Turbinenaufgaben. Die Zustandsgleichung verbindet p, v und T; erst der Prozessweg und die Bilanz legen Wärme und Arbeit fest. Dieses Kapitel ergänzt den vollständigen Foliensatz V05, unabhängig vom aktuellen Vorlesungsfortschritt.

#pagebreak(weak: true)
== 5.1 Modell, Gas- und Normvolumen <a-5-1>
Ein Gas verhält sich näherungsweise ideal, wenn Wechselwirkungen und Eigenvolumen gegenüber den übrigen Effekten klein sind. „Hohe Temperatur, niedriger Druck“ ist eine qualitative Hilfe; nahe Sättigung oder kritischem Zustand sind Tabellen oder reale Zustandsgleichungen nötig.
#bild("map-idealesgas", [Mindmap zum idealen Gas. Eigene Darstellung.], height: 46mm)
#form[$ p V=m R T=n R_m T quad R=R_m/M quad V_n=V frac(p,p_n)frac(T_n,T) $]
$V_n$ ist das auf einen genannten Referenzdruck und eine genannte Referenztemperatur umgerechnete Volumen derselben Stoffmenge. Die Folie verwendet $T_n="273,15"$ K, $p_n="1,01325"$ bar und $V_(m,n) approx "22,414"$ m³/kmol. Ein Normkubikmeter ist kein zusätzlich vorhandener Raum. Ein Überdruck muss vor der Gasgleichung zum Absolutdruck ergänzt werden.
#note("Vorlesungsanschrieb später ergänzen", [V05 enthält Tafel-/Arbeitsseiten, insbesondere PDF-S. 6, 10, 14–15 und 18–19. Die hier belegten Modellgleichungen ersetzen keinen noch fehlenden konkreten Vorlesungsanschrieb. Neue ausgefüllte Seiten werden später unter den stabilen Abschnitten dieses Kapitels eingearbeitet.])
#src[V05, PDF-S. 3–10 und 16; MT, PDF-S. 18–20. Normzustand als Definition der vorliegenden Quelle, nicht als Behauptung, jeder Normbezug sei gleich.]
#hoch(<a-5>, [Kapitelübersicht])

#pagebreak(weak: true)
== 5.2 Kalorische Größen und Differentiale <a-5-2>
Beim idealen Gas hängen h und u nur von T ab. Die Enthalpie einer realen Drossel muss daher nicht mit deren Temperatur konstant bleiben; diese Folgerung gilt erst nach Wahl des idealen Gasmodells. Der Joule-Überströmversuch untersucht u, der Joule-Thomson-Drosselversuch h.
#form[$ dif u=c_v(T)dif T quad dif h=c_p(T)dif T quad c_p-c_v=R quad kappa=c_p/c_v $]
Bei konstanten Wärmekapazitäten ist $Delta h=c_p Delta T$, $Delta u=c_v Delta T$, $c_v=R/(kappa-1)$ und $c_p=kappa R/(kappa-1)$. Für große Temperaturbereiche die vorgegebene mittlere Wärmekapazität oder das Integral verwenden. Die reine Temperaturabhängigkeit ist nicht dasselbe wie konstantes c.
#form[$ frac(dif p,p)+frac(dif v,v)=frac(dif T,T) $]
Das totale Differential folgt aus der Gasgleichung. Es beschreibt kleine verknüpfte Zustandsänderungen; für große Änderungen nutzt man die vollständige Gleichung zwischen den Endzuständen.
Für das *halbideale Gas* bleiben p v=R T und u/h temperaturabhängig, aber die Wärmekapazität ist nicht konstant. Aus einer mittleren Tabelle ab 0 °C entsteht Δh als Differenz c̄p(ϑ₂)ϑ₂−c̄p(ϑ₁)ϑ₁. Für Entropie ist dagegen das Integral ∫cp(T)/T dT nötig, mit der wahren Kapazität cp=dh/dT. Die mittlere Tabelle ungeändert als lokale Kapazität einzusetzen wäre ein Modellwechsel.
#src[V05, PDF-S. 7–12 und 16; MT, PDF-S. 18–20; Ü 9.8; Grundlagen der Wärmekapazität bereits 3.8.]
#hoch(<a-5>, [Kapitelübersicht])

#pagebreak(weak: true)
== 5.3 Isolinien und Entropiedifferenz <a-5-3>
#bild("gas-isolinien", [Isolinien des idealen Gases. V05, PDF-S. 13.], height: 68mm)
#form[$ Delta s=c_p ln(T_2/T_1)-R ln(p_2/p_1)=c_v ln(T_2/T_1)+R ln(v_2/v_1) $]
Konstante Wärmekapazitäten; absolute Temperaturen und Drücke. Im T-s-Bild ist die Steigung einer Isobare $dif T/dif s=T/c_p$, einer Isochore $T/c_v$. Weil $c_p>c_v$, steigt die Isochore steiler. Die Wahl des Entropienullpunkts verschiebt das Diagramm, nicht die Differenzen.
Für eine Luft-Isobare mit Referenz $(T_0,p_0,s_0)$ folgt $T=T_0 exp[(s-s_0+R ln(p/p_0))/c_p]$. Das ist die Grundlage der Zeichenaufgabe auf V05, PDF-S. 14; die Wärmefläche ist in Kelvin zu lesen.
#src[V05, PDF-S. 13–15; MT, PDF-S. 18–20. Steigungen und explizite Isobare ergänzend hergeleitet.]
#hoch(<a-5>, [Kapitelübersicht])

#pagebreak(weak: true)
== 5.4 Polytrope und Sonderfälle <a-5-4>
Eine *Polytrope* ist ein Weg mit $p v^n="konstant"$. Der Exponent n beschreibt den Verlauf; er ist nicht automatisch der Stoffwert κ. Eine polytrope reale Maschine kann Wärme und Dissipation zugleich besitzen.
#form[$ frac(T_2,T_1)=(frac(p_2,p_1))^((n-1)/n) quad frac(T_2,T_1)=(frac(v_1,v_2))^(n-1) $]
#tab(columns: (auto,1fr,1.6fr), th([Weg],[Bedingung],[Folge]),
[isobar],[$n=0$],[$v/T="konstant"$],
[isochor],[$v="konstant"$],[$p/T="konstant"$; Grenzfall $n arrow infinity$],
[isotherm],[$n=1$],[$p v="konstant"$],
[isentrop],[$n=kappa$],[Reversibel adiabat bei konstantem κ; Isentropie allein beweist keine Reversibilität.])
#form[$ w_v=frac(p_2 v_2-p_1 v_1,n-1) quad w_p=frac(n,n-1)R(T_2-T_1)=n w_v $]
Die Formeln gelten für $n != 1$, quasistatische Volumenarbeit bzw. Druckarbeitsintegral. Für $n=1$ ist $w_v=R T ln(v_1/v_2)$ und $w_p=R T ln(p_2/p_1)$. Bei konstantem Volumen ist $w_v=0$; der Grenzfall wird direkt bilanziert. Die Wärme folgt bei geschlossenem reibungsfreiem System aus $q=Delta u-w_v$, beim stationären reibungsfreien Strom aus $q=Delta h-w_p$.
#src[V05, PDF-S. 17–19; M71, PDF-S. 1. Mathematische Grenzfälle mit der Energiebilanz präzisiert.]
#hoch(<a-5>, [Kapitelübersicht])

#pagebreak(weak: true)
== 5.5 Offene Maschine, Kolben und Entleeren <a-5-5>
Für dieselben Endzustände sind offene und geschlossene Aufgaben verschieden. Im offenen stationären Verdichter gilt ohne äußere Energieänderung $w_t=Delta h-q=w_p+j$; im geschlossenen Kolben $w_g=Delta u-q=w_v+j$. Der reversible Vergleich streicht j, nicht beliebig die Wärme.
#form[$ j=w_t-w_p>=0 quad integral T dif s=q+j $]
Die zweite Beziehung benutzt das lokale Folienmodell aus 4.5. Ein diabater Verdichter kann Entropie abgeben und trotzdem Dissipation erzeugen. Die minimale Wärmeabfuhr für denselben Weg bei $j=0$ ist deshalb von der tatsächlichen Abfuhr zu trennen.
Ein starrer Tank mit Entnahme ist dagegen *offen und instationär*. Für ideale, homogene, adiabate Tankentleerung ohne Arbeit und ohne äußere Energien gilt $dif(m c_v T)=c_p T dif m$ und damit $T/T_0=(m/m_0)^(kappa-1)$, $p/p_0=(m/m_0)^kappa$. Beim Füllen sind Einströmzustand und Speicherzustand getrennt zu bilanzieren.
#note("Der Zusammenhang in Kapitel 5", [Gasgleichung und kalorische Beziehungen liefern Zustände. Der Prozessweg bestimmt die Integrale, die Systemart die Bilanz. Erst danach werden Arbeit, Wärme und Entropie gemeinsam geprüft.])
#src[V05, PDF-S. 5 und 11–19; Ü 5.1–5.14, PDF-S. 31–35. Entleerungsbeziehung eigene Herleitung für das ausdrücklich genannte Modell.]
#hoch(<a-5>, [Kapitelübersicht])

#pagebreak()
= Kapitel 6 · Thermische Maschinen <a-6>
#überblick([Kapitel 6 auf einen Blick],
 idee(<a-6-1>, [Kolbenprozesse: Otto, Diesel, Seiliger], [Wärmezufuhr und Verdichtung bestimmen den Vergleich.]),
 idee(<a-6-2>, [Reale Wirkungsgrade und Kraft-Wärme-Kopplung], [Vergleich, innere Arbeit und Wellenarbeit getrennt zählen.]),
 idee(<a-6-3>, [Joule-Prozess und Gasturbine], [Verdichter und Turbine gemeinsam bilanzieren.]),
 idee(<a-6-4>, [Regeneration und weitere Energiewandler], [Stirling, chemische Arbeit und Wärmeleitung im Zusammenhang.]),
 idee(<a-6-5>, [Rankine, Entnahme und Gas-und-Dampf], [Teilströme nach jeder Verzweigung neu bestimmen.]),
 idee(<a-6-6>, [Kälteprozesse, Unterkühlung und Kaskade], [Nutzen und Verdichteraufwand an derselben Grenze messen.]),
)
#karte((1fr, auto, 1fr),
 chunk([Kolbenprozesse: Otto, Diesel, Seiliger], [Wärmezufuhr und Verdichtung bestimmen den Vergleich.], ziel: <a-6-1>), pfeil(),
 chunk([Reale Wirkungsgrade und Kraft-Wärme-Kopplung], [Vergleich, innere Arbeit und Wellenarbeit getrennt zählen.], ziel: <a-6-2>),
 chunk([Joule-Prozess und Gasturbine], [Verdichter und Turbine gemeinsam bilanzieren.], ziel: <a-6-3>), pfeil(),
 chunk([Stirling und Regenerator], [Innere und äußere Wärme auseinanderhalten.], ziel: <a-6-4>),
)
#hoch(<ueberblick>, [Modul auf einen Blick])
#link(<a-6-7>)[Brennstoffzellen] · #link(<a-6-8>)[Wärmeleitung]
Vergleichsprozesse zerlegen eine Maschine in berechenbare Schritte. Die reale Maschine wird anschließend über Gütegrade und mechanische Wirkungsgrade mit diesem Vergleich verbunden. Ein einzelner großer Turbinenbeitrag ist noch keine große Nettoleistung.

#pagebreak(weak: true)
== 6.1 Kolbenprozesse: Otto, Diesel, Seiliger <a-6-1>
#bild("otto-diesel-seiliger", [Vergleichsprozesse und Wirkungsgrade. V06, PDF-S. 5.], height: 70mm)
Beim *Otto*-Vergleich erfolgt die Wärmezufuhr isochor, beim *Diesel*-Vergleich isobar, beim *Seiliger*-Vergleich in beiden Schritten. Verdichtung und Expansion sind im Idealvergleich isentrop, die abschließende Wärmeabgabe isochor. Der echte Viertaktmotor hat zusätzlich Ansaugen und Ausschieben; dessen Gaswechselschleife wird im einfachen Vergleich ersetzt bzw. vernachlässigt.
#form[$ epsilon=V_1/V_2 quad eta_"Otto"=1-epsilon^(1-kappa) $]
#form[$ eta_"Diesel"=1-frac(phi^kappa-1,epsilon^(kappa-1)kappa(phi-1)) $]
$phi$ ist das Einspritz-/Abschneidevolumenverhältnis. Gleiches κ und gleiches ε vorausgesetzt, ist der ideale Otto-Wirkungsgrad größer. Reale Diesel arbeiten meist mit anderen Verdichtungsverhältnissen; aus dem idealen Vergleich folgt daher keine pauschale reale Rangfolge.
Hubvolumen $V_h=V_1-V_2$, Rest-/Kompressionsvolumen $V_k=V_2$, Mitteldruckbetrag $p_m=abs(W)/V_h$. Die Leistung ist Arbeit je Spiel mal Spiele je Zeit: Viertakt ein Spiel je zwei Umdrehungen und Zylinder, Zweitakt je eine Umdrehung.
Warum die Verdichtung im Otto-Vergleich den Wirkungsgrad erhöht: $q_"zu"=c_v(T_3-T_2)$ und $abs(q_"ab")=c_v(T_4-T_1)$. Die beiden Isentropen liefern $T_2/T_1=T_3/T_4=epsilon^(kappa-1)$. Damit ist $abs(q_"ab")/q_"zu"=epsilon^(1-kappa)$. Das Kreisprozess-Ergebnis ist also die Folge der beiden Volumengrenzen und der Wärmeübertragung, keine zusätzliche Stoffformel.
=== 6.1.1 Seiliger: Druck- und Volumensteigerung getrennt <a-6-1-1>
Die isochore Teilwärme erhöht zunächst den Druck um den Faktor $psi=p_3/p_2$. Die anschließende isobare Teilwärme vergrößert das Volumen um $phi=V_4/V_3$; wegen $V_3=V_2$ ist das dieselbe φ-Basis wie im Memory. Für konstantes ideales Gas ergibt sich:
#form[$ eta_"Seiliger"=1-frac(psi phi^kappa-1,epsilon^(kappa-1)[psi-1+kappa psi(phi-1)]) $]
Im Grenzfall φ=1 bleibt der Otto-Prozess, im Grenzfall ψ=1 der Diesel-Prozess. Bei beiden zugleich gleich eins wird keine Wärme zugeführt; dann ist der Quotient als Wirkungsgrad des arbeitenden Kreisprozesses nicht definiert. Die Gleichung setzt dieselben isentropen Verdichtungs-/Expansionsmodelle wie die beiden Vergleiche voraus.
#src[MT, PDF-S.28–29 (M29–M30), Gl.9.29–9.34; V06, PDF-S.5. Grenzfälle eigene Prüfung.]
#src[V06, PDF-S. 2–8; Ü 6.1–6.4 und 9.6. Bezeichnungen ε/φ nach den Folien.]
#hoch(<a-6>, [Kapitelübersicht])

#pagebreak(weak: true)
== 6.2 Reale Wirkungsgrade und Kraft-Wärme-Kopplung <a-6-2>
Theoretische Arbeit, indizierte Arbeit aus dem gemessenen p-V-Diagramm und effektive Wellenarbeit sind verschiedene Größen. Mechanische Verluste liegen zwischen innerer und äußerer Arbeit, der Gütegrad zwischen Idealvergleich und indiziertem Prozess.
#form[$ eta_"eff"=eta_"th" eta_G eta_"mech" quad eta_G=abs(W_i)/abs(W_"Vergleich") $]
Die gleiche System- und Brennstoffbasis muss bei jedem Quotienten erhalten bleiben. Die im Diagramm abgelesene Kreisfläche ist mit der jeweiligen Vorzeichenkonvention zu versehen.
#form[$ eta_"BHKW"=frac(P_"el"+dot(Q)_"Nutz",dot(m)_B H_u) $]
Beim Blockheizkraftwerk wird zusätzlich nutzbare Heizwärme gezählt. Dieser Gesamtenergienutzungsgrad ist nicht der elektrische Wirkungsgrad und nicht der exergetische Wirkungsgrad. Ein höherer Wert durch Mitnutzung von Wärme bedeutet nicht, dass Wärme vollständig zu Strom wird.
#bild("map-maschinen", [Mindmap zur Maschinenbilanz. Eigene Darstellung.], height: 46mm)
#src[V06, PDF-S. 5 und 9; Ü 6.1–6.4. Begriffe zur Nutzungsgrenze ergänzt.]
#hoch(<a-6>, [Kapitelübersicht])

#pagebreak(weak: true)
== 6.3 Joule-Prozess und Gasturbine <a-6-3>
#bild("joule-ideal-real", [Idealer und realer Joule-Prozess. V06, PDF-S. 14.], height: 67mm)
Der ideale Joule-Prozess besteht aus isentroper Verdichtung, isobarer Wärmezufuhr, isentroper Expansion und isobarer Wärmeabgabe. In der offenen Gasturbine ersetzt der Gaswechsel die letzte Kühlstrecke des gedachten geschlossenen Umlaufs. Beim Strahltriebwerk wird ein Teil der verfügbaren Enthalpie in der Düse zur Strahlgeschwindigkeit.
#form[$ eta_"Joule"=1-(p_1/p_2)^((kappa-1)/kappa) quad w_t=c_p[(T_2-T_1)+(T_4-T_3)] $]
Konstantes ideales Gas, gleiche Druckverhältnisse, reversible Druckmaschinen und keine Druckverluste. Real ist $eta_("is,V")=(h_(2s)-h_1)/(h_2-h_1)$, $eta_("is,T")=(h_3-h_4)/(h_3-h_(4s))$. Verdichter: ideale Aufnahme durch Gütegrad teilen; Turbine: ideale Abgabe damit multiplizieren.
Innere Wärmerückgewinnung ist sinnvoll, wenn der Turbinenaustritt wärmer ist als der Verdichteraustritt. Ein Regenerator verringert die nötige Brennkammerwärme; er erzeugt keine Energie. Druckverluste und unvollständiger Wärmeaustausch begrenzen den Gewinn.
=== 6.3.1 Turbojet, Turbofan und getrennte Wellen <a-6-3-1>
Im *Turbojet* liefert der Gasgenerator einen heißen Druckgasstrom, der in der Schubdüse beschleunigt wird. Die Turbine muss zuerst den Verdichter antreiben; nur der verbleibende Enthalpieabfall steht für den Strahl zur Verfügung. Bei der *offenen* Gasturbine wird das Arbeitsgas laufend ausgetauscht, im Gegensatz zum eingeschlossenen Vergleichsgas des Kolbenprozesses.
#bild("turbofan-folien-original", [Zweiwelliger Turbofan im historischen Folienbeispiel. V06, PDF-S.13.], height: 66mm)
Ein *Turbofan* fördert zusätzlich Luft am Kern vorbei. Hoch- und Niederdrucksystem können über getrennte Wellen mit unterschiedlichen Drehzahlen laufen. Das *Nebenstromverhältnis* ist der Massenstrom im Nebenstrom geteilt durch den Kernmassenstrom. Für eine Gesamtbilanz sind beide Austrittsstrahlen und alle äußeren Energieanschlüsse zu erfassen.
#src[V06, PDF-S. 11–18; Ü 9.5. Folienzahlen zu konkreten Anlagen als historische Beispiele.]
#hoch(<a-6>, [Kapitelübersicht])

#pagebreak(weak: true)
== 6.4 Stirling und Regenerator <a-6-4>
#bild("stirling-regeneration", [Stirling-Vergleich mit Regeneration. V06, PDF-S. 19.], height: 70mm)
Zwei Isothermen übertragen äußere Wärme, zwei Isochoren verbinden sie. Im idealen Regenerator wird die beim Abkühlen auf einer Isochore frei werdende Wärme gespeichert und im nächsten Schritt wieder an das Gas abgegeben. Ein reiner Speicher ist damit kein zusätzlicher äußerer Wärmelieferant.
#form[$ abs(W_"netto")=m R(T_H-T_K)ln(V_"max"/V_"min") $]
Für ideale vollständige Regeneration ist $Q_"zu"=m R T_H ln(V_"max"/V_"min")$ und $eta=1-T_K/T_H$. Ohne Regeneration muss die äußere Wärme auch die isochore Erwärmung decken; derselbe Carnot-Wert darf dann nicht einfach angesetzt werden. Die konkrete Konstruktion mit Verdränger und Arbeitskolben erklärt die zeitliche Verschiebung der Gasvolumina.
=== 6.4.1 Weitere regenerative Verfahren aus dem Memory
Der *Ericsson*-Vergleich ersetzt die beiden Isochoren des Stirling-Prozesses durch Isobaren. Zwei Isothermen und ideale vollständige Regeneration ergeben wieder den Carnot-Wirkungsgrad. Die Regeneratorwärme ist intern, äußere Wärme wird auf den Isothermen übertragen.
Die im Memory gezeigten *Gifford-McMahon*- und *Vuilleumier*-Anlagen nutzen periodische Gasverschiebung zwischen warmen und kalten Räumen. Das Verdrängen und Speichern verbindet die Teilprozesse; es ist keine zusätzliche Energiequelle. Die Vuilleumier-Wärmepumpe erhält ihren Antrieb wesentlich durch Wärme. Für die Bewertung sind deshalb alle äußeren Wärme- und Arbeitsanschlüsse der jeweiligen Skizze zu zählen.
Im gezeigten β-Stirling haben *Arbeitskolben* und *Verdränger* unterschiedliche Aufgaben. Der Arbeitskolben ändert das gesamte Gasvolumen und überträgt Arbeit. Der Verdränger verschiebt Gas zwischen heißem und kaltem Bereich; seine Bewegung ist zeitlich gegenüber dem Arbeitskolben versetzt. Beim Folienmodell ohne Regenerator muss die sonst intern speicherbare Wärme von außen zu- und abgeführt werden. Das ideale Stirling-Diagramm ist daher ein Vergleich, kein identisches Messdiagramm dieses Modells.
=== 6.4.2 Linksläufiger Stirling und Philips-Gaskältemaschine <a-6-4-2>
Kehrt man die Umlaufrichtung um, wird Arbeit zugeführt: Das Gas nimmt auf der kalten Isotherme Wärme auf und gibt auf der warmen Wärme ab. Die beiden Isochoren verbinden die Temperaturniveaus über den Regenerator.
#bild("philips-stirling-kaelte-memory", [Linksläufiger Stirling und Philips-Gaskältemaschine. MT, PDF-S.31 (M32).], height: 61mm)
#form[$ epsilon_K=frac(T_K,T_H-T_K) quad epsilon_"WP"=frac(T_H,T_H-T_K) $]
Das sind die reversiblen Grenzen bei vollständiger Regeneration, jeweils in Kelvin und mit $T_H>T_K$. Reale Temperaturdifferenzen, Druckverluste und unvollständige Regeneration erhöhen den Aufwand. „Gas“ bezeichnet hier das Arbeitsmittel, nicht einen Brennstoff, der in der Kältemaschine verbrennt.
#src[MT, PDF-S.31, BildM9-16/M9-17 und Gl.5.54/5.58.]
#src[V06, PDF-S. 19–21; MT, PDF-S. 29 und 31–32, regenerative Kreisprozesse. Stirling-Arbeit ergänzend hergeleitet.]
#hoch(<a-6>, [Kapitelübersicht])

#pagebreak(weak: true)
== 6.5 Rankine, Entnahme und Gas-und-Dampf <a-6-5>
#bild("rankine-zwischenueberhitzung", [Rankine, Zwischenüberhitzung und Heizdampfentnahme. V06, PDF-S. 22.], height: 72mm)
Die Grundbilanz aus 4.7 bleibt: Pumpe → Kessel → Turbine → Kondensator. Zwischenüberhitzung führt zwischen Turbinenstufen zusätzliche Wärme zu. Bei Heizdampfentnahme gilt $dot(m)_"HT"=dot(m)_"Heiz"+dot(m)_"NT"$; die zweite Turbine und ihr Kondensator erhalten nur den Reststrom. Abgeschiedenes Wasser ist weder vernichtet noch automatisch im nächsten Turbinenstrom enthalten.
#form[$ P_T=sum_i dot(m)_i(h_("aus",i)-h_("ein",i)) quad P_P approx sum_i dot(m)_i v_i Delta p_i $]
Jeweils passende Massenbasis, Stoffwerte und Wirkungsgraddefinition verwenden. Wird Pumpenarbeit laut Aufgabe schon in einem Gesamtfaktor berücksichtigt, darf sie nicht nochmals abgezogen werden.
Ein Gas-und-Dampf-Kraftwerk nutzt Gasturbinenabwärme als Wärmezufuhr des Dampfkreises. Bei einer gemeinsamen Brennstoffbasis gilt $eta_"GuD"=(abs(P_"GT")+abs(P_"Dampf"))/(dot(Q)_B+dot(Q)_"Zusatz")$. Heizwärme, interne Übertragerwärme und Brennstoffwärme dürfen nicht doppelt in die Bilanz eingehen.
#tab(columns: (1fr,1fr,1fr), th([Vergleich],[Vorteil],[Grenze]),
[Gasprozess],[Hohe obere Fluidtemperatur erreichbar.],[Verdichter braucht viel Arbeit; Abgas bleibt heiß.],
[Dampfprozess],[Kondensation nahe Umgebung ermöglicht niedrige Wärmeabgabetemperatur.],[Oberes Temperaturniveau ist durch Stoff-/Anlagengrenzen beschränkt.],
[GuD],[Heißes GT-Abgas treibt zusätzlich den Dampfprozess.],[Endliche Temperaturdifferenzen, Verluste und Eigenbedarf bleiben.])
Für den vereinfachten GuD ohne Zusatzfeuerung folgt aus der Kette $eta_"GuD"=eta_G+eta_D eta_K(1-eta_G)$. $eta_K$ bezeichnet hier den Anteil der GT-Abwärme, der den Dampfprozess erreicht; $eta_D$ dessen Netto-Wirkungsgrad. Eine Formel mit Zusatzfeuerung braucht die zusätzliche Brennstoffwärme auch im Nenner.
=== 6.5.1 Mittlere Wärmezufuhrtemperatur und Regeneration <a-6-5-1>
Die Kesselwärme entsteht aus Flüssigkeitsvorwärmung, Verdampfung und Überhitzung. Für einen reversiblen isobaren Heizweg ist die thermodynamische mittlere Zufuhrtemperatur $bar(T)_"zu"=(h_5-h_2)/(s_5-s_2)$; sie ist kein einfaches arithmetisches Mittel der Eintritts- und Austrittstemperatur.
Speisewasservorwärmung durch Entnahmedampf verschiebt äußere Kesselwärme zu höheren Temperaturen. Dafür steht der entnommene Dampf nicht mehr für die gesamte weitere Turbinenexpansion zur Verfügung. Zwischenüberhitzung, überkritische Wärmezufuhr und Luftvorwärmung verändern jeweils andere Teile des Heizwegs; ihr Nutzen wird mit der vollständigen Bilanz geprüft.
Mit Zusatzfeuerung lautet das gemeinsame Kesselmodell des Memory $dot(Q)_D=eta_K[(1-eta_G)dot(Q)_G+dot(Q)_Z]$ und $eta_"GuD"=[eta_G dot(Q)_G+eta_D dot(Q)_D]/[dot(Q)_G+dot(Q)_Z]$. $dot(Q)_Z$ ist hier der zusätzliche Wärmestrom vor dem Dampferzeuger; der gemeinsame Übertragungs-/Kesselwirkungsgrad ηK wirkt auf beide Wärmezufuhren. Andere Anlagen mit getrennten Wirkungsgraden brauchen eine entsprechend getrennte Bilanz.
#src[MT, PDF-S.26 (M27), Gl.9.1–9.12 und Maßnahmen zur Wirkungsgradverbesserung; PDF-S.38, Gl.9.81–9.85. Bezüge der Zusatzwärme ausdrücklich getrennt.]
#src[V06, PDF-S. 22–23; Ü 6.7–6.9 und 9.1–9.4.]
#hoch(<a-6>, [Kapitelübersicht])

#pagebreak(weak: true)
== 6.6 Kälteprozesse, Unterkühlung und Kaskade <a-6-6>
#bild("plank-unterkuehlung", [Plank-Prozess mit Unterkühlung und Saugüberhitzung. V06, PDF-S. 25.], height: 70mm)
Die Drossel erhält h, der Verdampfer nimmt Wärme auf, der Verdichter benötigt Arbeit und der Verflüssiger gibt Wärme ab. Unterkühlung verringert die Enthalpie vor der Drossel. Überhitzung im eigentlichen Verdampfer kann zum Nutzen zählen; weitere Erwärmung in der Saugleitung außerhalb der Wärmequelle ist zusätzliche Verdichterbelastung.
#form[$ epsilon_K=dot(Q)_"Quelle"/P_V quad epsilon_"WP"=abs(dot(Q)_"Heiz")/P_V $]
Bei einer Kaskade gibt der kalte Kreislauf seine Kondensationswärme an den warmen ab: $abs(dot(Q)_"Kond,kalt")=dot(Q)_"Verd,warm"$. Die gesamte Kälteleistungszahl ist $dot(Q)_"kalt"/(P_(V,1)+P_(V,2))$, nicht das Produkt der einzelnen Zahlen. Reale Verdichtung und Drosselung erzeugen Entropie.
=== 6.6.1 Absorption und kryogene Verflüssigung
Bei der *Absorptionskältemaschine* ersetzen Absorber, Lösungspumpe und Austreiber den großen Dampfverdichter. Wärme treibt das Austreiben des Kältemittels an. Der Verdampfer nimmt Nutzkälte auf, Absorber und Kondensator geben Wärme ab; die kleine Lösungspumpe benötigt trotzdem Arbeit. Deshalb ist die Kälteleistungszahl auf den gesamten zugeführten Antriebsaufwand zu beziehen.
Beim *Linde-Verfahren* wird Hochdruckgas vor der Drossel durch den kalten Rückgasstrom vorgekühlt. Die isenthalpe Drossel kann bei geeignetem realem Stoffzustand einen Flüssigkeitsanteil erzeugen; der Abscheider trennt ihn ab. Im Wärmeübertrager fließt nur der verbleibende Dampf zurück. Der ideale Gasfall mit h=h(T) erklärt die Verflüssigung durch bloßes Drosseln nicht.
Das *Claude-Verfahren* ergänzt eine Expansionsmaschine für einen Teilstrom. Sie liefert Arbeit und zusätzliche Kühlung. Damit ändern sich Rückstrom- und Energieaufteilung; die Linde-Formel darf nicht ohne den zusätzlichen Turbinenzweig übernommen werden.
=== 6.6.2 Joule-Gaskälte: Verdichten, kühlen, entspannen <a-6-6-2>
Im *linksläufigen Joule-Prozess* bleibt das Arbeitsmittel gasförmig: Es wird isentrop verdichtet, bei hohem Druck gekühlt, isentrop entspannt und bei niedrigem Druck durch Aufnahme der Nutzkälte erwärmt. Anders als bei der Dampfkältemaschine ersetzt die Expansionsmaschine die isenthalpe Drossel und gewinnt einen Teil der Verdichterarbeit zurück.
#bild("joule-kaeltemaschine-memory", [Joule-Gaskältemaschine mit idealen und realen Wegen. MT, PDF-S.30 (M31).], height: 60mm)
#form[$ epsilon_K=frac(1,r^((kappa-1)/kappa)-1) quad epsilon_"WP"=frac(1,1-r^(-(kappa-1)/kappa)) quad r=p_H/p_K $]
Konstante Wärmekapazitäten, ideale Isentropen und gleiche Druckverhältnisse. Die Temperaturfolge muss tatsächlich Wärmeaufnahme auf der kalten Isobare ergeben. Real folgen Nutzkälte und Nettoarbeit aus den konkreten Enthalpiedifferenzen; die Idealformeln werden dann nicht unverändert übernommen.

=== 6.6.3 Wärmegetriebene Kälte und Verflüssigungsanteil <a-6-6-3>
Für die Absorptionsanlage definiert das Memory das Wärmeverhältnis $zeta=dot(Q)_0/(dot(Q)_G+P_P)$: Nutzkälte geteilt durch Austreiberwärme und Pumpenarbeit, jeweils als positive Aufwands-/Nutzbeträge. Das ist eine andere Bezugsgröße als die reine Verdichter-Leistungszahl.
#bild("linde-claude-memory", [Stromaufteilung und T-s-Verlauf bei Linde und Claude. MT, PDF-S.30 (M31), vollständig angeordnete Ausschnitte.], height: 100mm)
Für die Zustandsnummern dieser Abbildung gilt mit den Enthalpien auf derselben Stoffbasis:
#form[$ y_"Linde"=frac(dot(m)_L,dot(m))=frac(h_1-h_2,h_1-h_0) $
$ y_"Claude"=frac(h_1-h_2,h_1-h_0)+frac(dot(m)_E,dot(m))frac(h_3-h_7,h_1-h_0) $]
0 ist die abgetrennte Flüssigkeit, 1 der zurückkehrende Niederdruckstrom am warmen Ende, 2 der vorgekühlte Hochdruckstrom. Beim Claude-Verfahren expandiert der Teilstrom E von3 nach7. Die Beziehungen entstehen aus der Energie- und Massenbilanz des dargestellten Gesamtbereichs; sie sind keine universelle Formel für anders verschaltete Anlagen.
#src[MT, PDF-S.27, Gl.9.28; PDF-S.30, BildM9-10 bisM9-13 und Gl.9.48–9.55.]
#src[MT, PDF-S. 27 und 30; Ü 9.20, PDF-S. 61.]

#hoch(<a-6>, [Kapitelübersicht])
#pagebreak(weak: true)
== 6.7 Ergänzung · Brennstoffzellen und chemische Arbeit <a-6-7>
Eine *Brennstoffzelle* wandelt chemische Reaktionsenergie durch getrennte Elektrodenreaktionen direkt in elektrische Arbeit und Wärme um. Der äußere Elektronenweg führt durch den Verbraucher. Der Elektrolyt transportiert passende Ionen und verhindert den direkten Elektronenkurzschluss.
#bild("brennstoffzelle-schema", [Elektroden und äußerer Stromkreis. MT, PDF-S. 32 (M33).], height: 58mm)
#form[$ "H₂"+frac(1,2)"O₂" -> "H₂O" quad Delta G_m=Delta H_m-T Delta S_m $]
Reaktionsgrößen beziehen sich auf dieselbe stöchiometrische Reaktionsmenge und dieselben Temperatur-/Druckzustände. Für die isotherme, isobare reversible Reaktion ist die maximal abgegebene elektrische Arbeit je Reaktionsmenge $-Delta G_m$; die gesamte freiwerdende Reaktionsenthalpie $-Delta H_m$ umfasst zusätzlich den Wärmeteil.
#form[$ abs(P_"el,rev")=-dot(xi) Delta G_m quad U_"rev"=-frac(Delta G_m,z F) $]
$dot(xi)$ ist der Reaktionsfortschritt in mol/s, z die Elektronenzahl pro Reaktion, F die Faraday-Konstante in C/mol. Dann sind ΔG in J/mol und Spannung in Volt zu verwenden. Bei Wasserstoff/Sauerstoff ist z=2.
#src[MT, PDF-S. 32–34 (M33–M35), insbesondere Gl. 9.59–9.69.]
#hoch(<a-6>, [Kapitelübersicht])

#pagebreak(weak: true)
=== 6.7.1 Reale Zellspannung, Nutzung und Zelltypen
#bild("brennstoffzelle-kennlinie", [Strom-Spannungs-Kennlinie. MT, PDF-S. 35 (M36).], height: 66mm)
Bei Belastung fällt die reale Spannung unter die reversible Spannung. Elektrischer Abgabebetrag ist U I, nicht Leerlaufspannung mal einem beliebigen Strom. Die *Spannungseffizienz* ist U/Urev; zusätzlich bestimmt die Brennstoffnutzung, welcher Anteil des zugeführten Brennstoffs tatsächlich reagiert.
#form[$ eta_"el"=frac(U I,dot(n)_("B,zu") H_(u,m)) $]
Gleiche molare Brennstoffbasis und Heizwertbezug vorausgesetzt. Wird Wasser flüssig statt dampfförmig als Produkt angesetzt, ändert sich Reaktionsenthalpie und Bezugswirkungsgrad. Für eine Wasserstoffzelle ist daher ausdrücklich zu sagen, ob Hu oder Ho im Nenner steht.
#tab(columns: (auto,1fr,1fr), th([Typ],[Elektrolyt / Ionen],[Temperaturniveau im Memory]),
[PEMFC],[Protonenmembran, H⁺],[Niedertemperatur etwa 60–90 °C],
[AFC],[Alkalische Lösung, OH⁻],[Etwa 60–80 °C],
[PAFC],[Phosphorsäure, H⁺],[Etwa 160–220 °C],
[MCFC],[Carbonatschmelze, CO₃²⁻],[Etwa 600–650 °C],
[SOFC],[Festoxid, O²⁻],[Etwa 800–1000 °C])
Diese Bereiche sind die historischen Lehrtabellen des Memory, keine Aussage über aktuelle am Markt angebotene Anlagen. Wasserstoffherstellung, Aufbereitung und eventuelle Kraft-Wärme-Kopplung erweitern die Systemgrenze; sie werden bei einem Anlagenwirkungsgrad zusätzlich bilanziert.
=== 6.7.2 Reaktionsumsatz, Verlustwärme und elektrische Nutzung <a-6-7-2>
Der *Reaktionsfortschritt* ξ zählt umgesetzte Reaktionsmengen: $n_i=n_(i,0)+nu_i xi$. Stöchiometrische Zahlen ν sind bei Edukten negativ, bei Produkten positiv. Deshalb kann sich die gesamte Stoffmenge ändern, obwohl die Atomzahlen erhalten bleiben. Das z des Memory bezeichnet hier den Reaktionsfortschritt; im Lernskript bleibt z die Elektronenzahl, ξ der Fortschritt.
#form[$ I=z F dot(xi) quad U_H=-frac(Delta H_m,z F) quad abs(P_"el")=U I $]
$U_H$ ist die thermoneutrale Spannung auf der gewählten Enthalpie-/Wasserbasis. Für abgegebene elektrische Leistung und abgegebene Wärme als positive Beträge folgt $dot(Q)_"ab"=(-Delta H_m)dot(xi)-U I=(U_H-U)I$. Die reversible Spannung verwendet dagegen ΔG. Wärmeabgabe kann deshalb auch im reversiblen Betrieb auftreten: Reversibel bedeutet nicht automatisch adiabatisch.
#form[$ P_"zu"=dot(xi)Delta G_m+T dot(S)_"erz" quad dot(Q)_"zu"=T dot(xi)Delta S_m-T dot(S)_"erz" $]
Diese beiden Vorzeichengleichungen gelten für die isotherm-isobare Reaktion mit äußerer Wärmeübertragung bei T; Leistungen positiv *zum* System, $dot(S)_"erz">=0$. Bei gleicher Reaktion vermindert Entropieerzeugung die abgebbare elektrische Leistung. Zusammen ergeben sie wieder $P_"zu"+dot(Q)_"zu"=dot(xi)Delta H_m$.
Mit Brennstoffnutzung $chi=dot(n)_"B,umgesetzt"/dot(n)_"B,zu"$ folgt auf derselben Enthalpiebasis $eta_"el"=chi U/U_H=chi(U/U_"rev")(U_"rev"/U_H)$. Drei verschiedene Begriffe stehen darin: Nutzung des Brennstoffs, Spannungsverlust und thermodynamischer Anteil. Beim Umstellen auf den Heizwert müssen Wasserzustand und ΔH dazu passen.
#bild("brennstoffzelle-elektroden-memory", [Elektrodenreaktionen und Ladungsträger. MT, PDF-S.37 (M38), TabelleM9-3.], height: 74mm)
Protonenzellen transportieren H⁺ von der Anode zur Kathode; die hier gezeigten OH⁻-, CO₃²⁻- und O²⁻-Zellen transportieren negative Ionen in Gegenrichtung. Bei der Carbonatzelle wird zusätzlich CO₂ an der Kathode benötigt und an der Anode frei. Die Halbgleichungen erklären damit die unterschiedlichen Stoffanschlüsse trotz ähnlicher Gesamtreaktion.
#note("Wasserzustand in der Quellentabelle", [MT, PDF-S.37, TabelleM9-4 bezeichnet auch in der zweiten Zeile das Produkt als flüssig. Die Zeilen unterscheiden sich aber ausdrücklich durch gasförmiges bzw. flüssiges Wasser und zugehörige Enthalpie-/Gibbswerte. Die Werte 241,82/228,57kJ/mol werden hier nur als das vorgegebene Paar der Dampfprodukt-Zeile verwendet; Wasserzustand und Bezug dürfen nicht zwischen den Zeilen vermischt werden.], fill: sand)
#src[MT, PDF-S.33–35 (M34–M36), Gl.9.59–9.79; PDF-S.37, TabellenM9-3/M9-4. Abgabe-/Zufuhrzeichen und ξ gegenüber z vereinheitlicht.]
#src[MT, PDF-S. 35–37 (M36–M38), Tabellen M9-2 bis M9-4; Definition der äußeren Bilanzgrenze erläutert.]
#hoch(<a-6>, [Kapitelübersicht])

#pagebreak(weak: true)
== 6.8 Ergänzung · Wärmeleitung aus dem Memory <a-6-8>
*Wärmeleitung* ist Energieübertragung infolge eines Temperaturgefälles ohne einen makroskopischen Stoffstrom durch die Wand. Der Stoffwert λ heißt hier Wärmeleitfähigkeit; er ist von der dimensionslosen Darcy-Rohrreibzahl gleichen Buchstabens zu unterscheiden.
#bild("waermeleitung-fourier", [Fourier-Beziehung für Wärmeleitung. MT, PDF-S. 38 (M39).], height: 63mm)
#form[$ dot(q)_x=-lambda frac(dif T,dif x) quad dot(Q)=lambda A frac(T_1-T_2,L) $]
Die zweite Gleichung gilt für stationäre eindimensionale Leitung durch eine ebene Wand mit konstanter Fläche A, Dicke L und konstanter λ, ohne innere Wärmequelle. λ in W/(m K), A in m², L in m liefern Watt. Das Minuszeichen der lokalen Form bedeutet: Die Wärme fließt zum kälteren Ort.
Bei einem Rohr oder einer Kugelschale ändert sich die leitende Fläche mit dem Radius. Dann wird die lokale Gleichung mit A(r) integriert; die ebene Formel mit einer beliebigen Außenfläche wäre falsch. Grenzflächen-Konvektion und Strahlung benötigen eigene Modelle und Randbedingungen, die diese lokale Leitungsbeziehung nicht ersetzt.
=== 6.8.1 Temperaturfeld und Wärmeausbreitung <a-6-8-1>
Fourier beschreibt den lokalen Wärmestrom; die *Wärmeleitungsgleichung* beschreibt, wie sich die Temperatur im Körper mit der Zeit verändert. Für homogenen isotropen Stoff mit konstanten Kennwerten, ohne Strömung und ohne innere Wärmequelle gilt:
#form[$ frac(partial T,partial tau)=a nabla^2 T quad a=frac(lambda,rho c) $]
$a$ ist die Temperaturleitfähigkeit in m²/s, c die passende spezifische Wärmekapazität. Für λ in W/(m K) und ρ in kg/m³ muss c in J/(kg K) eingesetzt werden, damit a in m²/s entsteht. In kartesischen Koordinaten ist $nabla^2 T=T_(x x)+T_(y y)+T_(z z)$; die Indizes bedeuten zweite Ortsableitungen. Bei rein radialer Zylindersymmetrie wird daraus $T_(r r)+T_r/r$, bei Kugelsymmetrie $T_(r r)+2T_r/r$. Der Geometriefaktor beschreibt die mit r zunehmende Wärmeleitfläche.
Zum Lösen braucht man eine Anfangstemperaturverteilung und Randbedingungen, etwa vorgegebene Wandtemperatur oder Wärmestromdichte. Die Größenordnung der Ausgleichszeit ist $tau approx L^2/a$; doppelte Weglänge bedeutet bei gleichem Stoff etwa vierfache Zeit. Die vollständigen Winkelterme des Memory entfallen nur unter den ausdrücklich genannten Symmetrien.
#src[MT, PDF-S. 38 (M39), Abschnitt 10.1, Gl.10.1 und10.9a–d; ebene stationäre Form ergänzend integriert.]
#hoch(<a-6>, [Kapitelübersicht])

#note("Der Zusammenhang in Kapitel 6", [Jeder Vergleichsprozess benutzt die Gas- oder Dampfbilanzen aus den vorigen Kapiteln. Die Apparate und Teilmassenströme bestimmen, welche Wärme und Arbeit zusammengezählt werden; Wirkungsgrade vergleichen erst danach klar definierte Nutzen und Aufwände.])
#src[V06, PDF-S. 24–27; Ü 6.5–6.6 und 6.10. Leistungszahlen bereits in 4.7 eingeführt.]
#hoch(<a-6>, [Kapitelübersicht])

#pagebreak()
= Kapitel 7 · Feuchte Luft · Ergänzung aus der vollständigen Aufgabensammlung <a-7>
#überblick([Kapitel 7 auf einen Blick],
 idee(<a-7-5>, [Allgemeine Gasgemische], [Massen- und Molanteile richtig umrechnen.]),
 idee(<a-7-1>, [Bezugsmasse, Partialdruck und Sättigung], [Wassergehalt x und relative Feuchte φ unterscheiden.]),
 idee(<a-7-2>, [Volumen, Enthalpie und h-x-Diagramm], [Alle spezifischen Größen auf dieselbe Masse beziehen.]),
 idee(<a-7-3>, [Taupunkt, Erwärmen und Entfeuchten], [Beim Kühlen zuerst die Phasengrenze prüfen.]),
 idee(<a-7-4>, [Mischen, Befeuchten und Druckluft], [Luft-, Wasser- und Energiebilanz gemeinsam lösen.]),
)
#karte((1fr, auto, 1fr),
 chunk([Bezugsmasse, Partialdruck und Sättigung], [Wassergehalt x und relative Feuchte φ unterscheiden.], ziel: <a-7-1>), pfeil(),
 chunk([Volumen, Enthalpie und h-x-Diagramm], [Alle spezifischen Größen auf dieselbe Masse beziehen.], ziel: <a-7-2>),
 chunk([Taupunkt, Erwärmen und Entfeuchten], [Beim Kühlen zuerst die Phasengrenze prüfen.], ziel: <a-7-3>), pfeil(),
 chunk([Mischen, Befeuchten und Druckluft], [Luft-, Wasser- und Energiebilanz gemeinsam lösen.], ziel: <a-7-4>),
)
#hoch(<ueberblick>, [Modul auf einen Blick])
Die Übungs- und Klausursammlungen enthalten auch Luftbehandlung und Feuchtebilanzen. Dieses Kapitel stellt dafür die Grundlagen bereit; es ist eine Ergänzung aus diesen Quellen und dem mitgelieferten Thermodynamik-Memory, kein nachträglich behaupteter Vorlesungsanschrieb.

#pagebreak(weak: true)
== 7.1 Bezugsmasse, Partialdruck und Sättigung <a-7-1>
Feuchte Luft besteht aus trockener Luft und Wasser. Solange kein Nebel vorliegt, wird der Wasserdampf als Gasanteil behandelt. Seine mögliche Menge ist durch den Sättigungsdruck bei der Lufttemperatur begrenzt; der Gesamtdruck allein bestimmt die Feuchte nicht.
#bild("map-feuchte", [Mindmap zur Luftbehandlung. Eigene Darstellung.], height: 46mm)
#form[$ p=p_L+p_W quad phi=p_W/p_s(T) quad x=m_W/m_L $]
$x$ ist kg Wasser je kg *trockene* Luft, nicht der Wasser-Massenanteil am gesamten Gemisch und nicht der Dampfgehalt des Nassdampfs. Für gasförmiges Wasser folgt mit $R_L/R_W approx "0,622"$:
#form[$ x=frac(R_L,R_W)frac(phi p_s,p-phi p_s) quad p_W=frac(x p,R_L/R_W+x) $]
Die Gleichung setzt die ideale Gasphase voraus. Enthält die Luft zusätzlich flüssige Tröpfchen, hat der Dampfdruck höchstens den Sättigungswert; der darüber hinausgehende Wassergehalt ist gesondert als Flüssigkeit zu bilanzieren.
Die *Sättigungswasserbeladung* ist $x_s=(R_L/R_W)p_s/(p-p_s)$. Der *Feuchtegrad* $Psi=x/x_s$ ist deshalb nicht allgemein gleich der relativen Feuchte φ. Für ungesättigte Gasphase folgt $Psi=phi(p-p_s)/(p-phi p_s)$. Bei Nebel ist φ=1, während der gesamte Wassergehalt x größer als $x_s$ sein kann. Der Wasser-Massenanteil am gesamten Gemisch ist $xi_W=x/(1+x)$.
#src[Ü Kapitel 7, PDF-S. 42–44; MT, PDF-S. 21–25; BT 8.4–8.5, S. 248–252 / PDF-S. 266–270.]
#hoch(<a-7>, [Kapitelübersicht])

#pagebreak(weak: true)
== 7.2 Volumen, Enthalpie und h-x-Diagramm <a-7-2>
#form[$ v_L=V/m_L=frac((R_L+x R_W)T,p) quad rho_"Gemisch"=frac(1+x,v_L) $]
$v_L$ ist auf trockene Luft bezogen. Sein Kehrwert ist die trockene Luftmasse pro Gemischvolumen; erst der Faktor $1+x$ liefert die gesamte Gemischdichte. Bei Nebel ist der Gasanteil mit dem Sättigungswert zu beschreiben, das kleine Flüssigkeitsvolumen meist vernachlässigbar.
#form[$ h_(1+x)=c_(p,L) vartheta+x(r_0+c_(p,W) vartheta) $]
Die Enthalpie steht in kJ je kg trockener Luft. $vartheta$ ist hier der Celsius-Zahlenwert gegenüber dem ausdrücklich gewählten 0-°C-Bezug, keine absolute Temperatur in einem Carnot-Quotienten. Nach BT passen näherungsweise $c_(p,L)="1,005"$, $c_(p,W)="1,852"$ kJ/(kg K), $r_0=2502$ kJ/kg für den dort genannten Temperaturbereich. Aufgaben können andere gerundete Konstanten verwenden; diese haben für deren Nachrechnung Vorrang.
Im h-x-Diagramm müssen die schiefe Enthalpieachse, die x-Richtung und die Sättigungskurve zuerst gelesen werden. Außerhalb des Sättigungsgebiets liegt der Mischzustand auf der Verbindungsgeraden der Ausgangszustände. Eine Temperaturdifferenz allein ist bei wechselndem x kein vollständiger Enthalpieunterschied.
#bild("mollier-memory-original", [Original-Mollierbild mit Misch-, Heiz- und Kühlwegen. MT, PDF-S.23 (M24).], height: 76mm)
#note("Dichtebezug im Memory", [MT, PDF-S.22, Gl.8.47 bezeichnet $m_L/V$ als „Dichte der feuchten Luft“. Der Nennerbezug zeigt: Das ist die *Trockenluft-Partialdichte*. Die gesamte Gemischdichte enthält den Faktor $1+x$.], fill: sand)

=== 7.2.1 Gesättigte Luft, Wassernebel und Eisnebel <a-7-2-1>
Sobald überschüssiges Wasser als Tropfen vorliegt, darf der Gesamtwassergehalt nicht vollständig mit der Dampfenthalpie multipliziert werden. Die Gasphase enthält bei Gleichgewicht nur $x_s$; der Rest $x-x_s$ hat Flüssigkeits- oder Eisenthalpie.
#form[$ h_s=c_(p,L)vartheta+x_s(r_0+c_(p,W)vartheta) $
$ h_"Nebel"=h_s+(x-x_s)c_(W,"fl")vartheta $
$ h_"Eisnebel"=h_s+(x-x_s)(-r_"Schmelz"+c_"Eis" vartheta) $]
Alle Werte je kg trockener Luft, mit flüssigem Wasser bei0°C als Nullpunkt. Im Eisgebiet ist $p_s$ der Sättigungsdruck über Eis. Das Memory nennt näherungsweise $r_"Schmelz"="333,5"$ kJ/kg und $c_"Eis"="2,04"$ kJ/(kg K). Die freie Gasgleichung benutzt nur die gasförmige Wasserbeladung, die Gesamtmasse zusätzlich das kondensierte Wasser.
#src[BT 8.5, S. 250–253 / PDF-S. 268–271; MT, PDF-S. 22–24; Ü Kapitel 7.]
#hoch(<a-7>, [Kapitelübersicht])

#pagebreak(weak: true)
== 7.3 Taupunkt, Erwärmen und Entfeuchten <a-7-3>
Der *Taupunkt* ist die Temperatur, bei der der vorhandene Wasserdampfpartialdruck zum Sättigungsdruck wird: $p_s(T_"tau")=p_W$. Reines Erwärmen bei gleichem Druck und ohne Wasserzugabe erhält x; φ sinkt, weil der Sättigungsdruck steigt. Beim Abkühlen steigt φ zunächst bis eins.
#form[$ dot(m)_"Kond"=dot(m)_L(x_1-x_2) $]
Die Formel gilt für abgeführtes Kondensat bei $x_1>x_2$. Wird unter den Taupunkt gekühlt, bleibt der gasförmige Anteil im idealen Endgleichgewicht gesättigt; überschüssiges Wasser fällt aus. Die Kühlleistung muss die Enthalpie des abgetrennten Kondensats berücksichtigen:
#form[$ dot(Q)=dot(m)_L(h_2-h_1)+dot(m)_"Kond" h_"Kond" $]
Stationärer Kühler ohne Wellenarbeit und äußere Energieänderung; Q positiv zum System. Mit dem gewählten Wasserbezug ist $h_"Kond" approx c_W vartheta_2$. Unter 0 °C muss statt flüssigem Kondensat der Eis-/Reifzustand samt Enthalpie verwendet werden.
Die *Kühlgrenztemperatur* ist von der Taupunkttemperatur zu unterscheiden. Beim idealen adiabaten Kontakt mit Wasser nähert sich die Luft einem Sättigungszustand G. Die Wasserenthalpie bestimmt die Richtung im h-x-Bild:
#form[$ h_G-h_1=(x_G-x_1)h_W quad x_G=x_s(T_G) $]
Ist die zugeführte Flüssigkeitsenthalpie im gewählten Bezug vernachlässigbar, ist dieser Weg näherungsweise isenthalp. Der Taupunkt entsteht dagegen durch Abkühlen ohne anfängliche Wasserzugabe. Die Kühlfläche kann wiederum unter beiden Temperaturen liegen und dadurch aktiv entfeuchten.
#src[MT, PDF-S. 24–25; BT 8.7 und 8.9; Ü 7.1–7.9. Bilanz mit Kondensat ausdrücklich aus der Energieerhaltung formuliert.]
#hoch(<a-7>, [Kapitelübersicht])

#pagebreak(weak: true)
== 7.4 Mischen, Befeuchten und Druckluft <a-7-4>
Bei einer adiabaten Mischkammer wird die trockene Luftmasse erhalten. Die Wasser- und Enthalpieströme addieren sich auf derselben trockenen Luftbasis.
#form[$ x_M=frac(dot(m)_(L,1)x_1+dot(m)_(L,2)x_2,dot(m)_(L,1)+dot(m)_(L,2)) quad h_M=frac(dot(m)_(L,1)h_1+dot(m)_(L,2)h_2,dot(m)_(L,1)+dot(m)_(L,2)) $]
Der Mischpunkt liegt näher am stärkeren Trockenluftstrom. Erst nach x und h wird die Mischtemperatur berechnet und geprüft, ob Nebel entsteht. Beim Einsprühen kommt zusätzlich die Enthalpie des Wassers bzw. Dampfes hinzu; eine adiabate Befeuchtung ist nur bei vernachlässigbarer Wasserenthalpie näherungsweise isenthalp.
Bei Verdichtung ohne Kondensation bleibt x gleich, der Wasserdampfpartialdruck wächst mit dem Gesamtdruck. Kühlt die Druckluft danach ab, kann sie Wasser abgeben. Entspannung auf den alten Gesamtdruck macht das zuvor ausgeschiedene Wasser nicht automatisch rückgängig.
#form[$ h_2-h_1=(x_2-x_1)h_W+q $]
Stationär, gleiche trockene Luftmasse, eingesprühtes Wasser verbleibt im betrachteten Austritt und q ist zusätzlich zugeführte Wärme je kg trockener Luft. Bei abgeschiedenem Wasser kommt dessen eigener Enthalpiestrom hinzu. So werden Dampfbefeuchtung, Flüssigeindüsung und Raumwärme getrennt.

=== 7.4.1 Taupunktregelung und Wasseroberfläche <a-7-4-1>
Ein idealer Taupunktregler stellt zuerst die zum gewünschten Wassergehalt gehörende Sättigung her. Im Winter wird die Außenluft nötigenfalls vorgewärmt, im Wäscher bis zum Soll-Taupunkt befeuchtet und anschließend auf die gewünschte Zulufttemperatur erwärmt. Der Nacherhitzer ändert x nicht. Ist die Außenluft schon zu feucht, reicht dieses reine Befeuchtungsverfahren nicht; Wasser muss zuvor auskondensieren.
#bild("taupunktregler-memory", [Taupunktregelung im h-x-Bild. MT, PDF-S.25 (M26), BildM8-3a.], height: 47mm)
Wärmerückgewinnung überträgt Energie zwischen zwei Luftströmen. Umluft führt dagegen auch deren Feuchte zurück. Deshalb ändern diese beiden Maßnahmen die Mischbilanzen unterschiedlich.
#bild("luft-wasser-memory", [Wärme- und Stoffaustausch an einer Wasseroberfläche. MT, PDF-S.25 (M26), BildM8-4.], height: 61mm)
Über einer Wasseroberfläche bei $T_W$ ist die Grenzluft gesättigt. Ist $p_W<p_s(T_W)$, verdunstet Wasser; bei größerem Luft-Dampfpartialdruck kondensiert es. Die Richtung des sensiblen Wärmestroms folgt unabhängig davon dem Temperaturunterschied. Deshalb kann Verdunstung je nach Wasserzustand mit Abkühlung oder Erwärmung der Luft verbunden sein.
=== 7.4.2 Raumzustand aus Zuluft und inneren Lasten <a-7-4-2>
#bild("klimazentrale-memory", [Luftbehandlungszentrale und Raumlasten. MT, PDF-S.23 (M24), BildM8-2.], height: 60mm)
Zuluft ist der Zustand vor dem Raum, Raum-/Abluft der Zustand danach. Menschen, Prozesse oder eine Wasseroberfläche bringen Feuchte und Energie ein. Im stationären Raum mit gleichem Trockenluftstrom am Ein- und Austritt gelten:
#form[$ dot(m)_L(x_"IDA"-x_"SUP")=sum dot(m)_W $
$ dot(m)_L(h_"IDA"-h_"SUP")=sum dot(Q)+sum P+sum dot(m)_W h_W $]
Wärme, Arbeit und Wasserströme sind hier positiv in den Raum; Wasserabfuhr wird mit negativem Vorzeichen erfasst. Die Wasserenthalpie muss zur eintretenden Phase und zum gemeinsamen 0-°C-Bezug passen. Wird eine angegebene Raumlast bereits einschließlich der Verdampfungswärme definiert, darf diese nicht nochmals addiert werden. Aus beiden Bilanzen entsteht im h-x-Bild eine Raumgerade; ihr Schnitt mit dem gewünschten Raumzustand bestimmt einen passenden Zuluftzustand bzw. Luftstrom.
#src[MT, PDF-S.23, BildM8-2 und zugehörige Beschreibung der Raumlasten; Bilanzen aus dem ersten Hauptsatz und Wassererhaltung formuliert.]
#src[MT, PDF-S. 24–25; BT 8.7–8.10, insbesondere S. 261–262 / PDF-S. 279–280; Ü Kapitel 7.]
#hoch(<a-7>, [Kapitelübersicht])

#pagebreak(weak: true)
== 7.5 Ergänzung · Allgemeine ideale Gasgemische <a-7-5>
Ein *Massenanteil* zählt Kilogramm, ein *Molanteil* Teilchenmengen. Leichter Wasserstoff kann deshalb einen großen Molanteil haben, obwohl sein Massenanteil klein ist. Die Anteile sind immer auf dieselbe Gesamtmenge zu beziehen.
#form[$ xi_i=m_i/m quad psi_i=n_i/n quad psi_i=frac(xi_i/M_i,sum_j xi_j/M_j) $]
#form[$ M=frac(1,sum_i xi_i/M_i)=sum_i psi_i M_i quad R=R_m/M=sum_i xi_i R_i $]
M in kg/kmol und Rm in kJ/(kmol K) liefern R in kJ/(kg K). Für ideale Gase ist der Molanteil zugleich der Volumenanteil bei gemeinsamen p und T. Die Massenanteile erhältst Du umgekehrt aus $xi_i=psi_i M_i/M$.
Nach Dalton ist $p_i=psi_i p$ und nach Amagat addieren sich die gedachten Partialvolumina bei gleichem p und T. Wärmekapazitäten und Enthalpien werden dagegen passend zur Basis gemittelt: massenspezifisch mit ξ, molar mit ψ. In einem starren geschlossenen Gemisch wird elektrische Heizenergie zu ΔU, in einem stationär beheizten Strom zu ΔH (ohne andere Energieänderungen).
#note("Fehler vermeiden", [Reine Normdichten dürfen für Gemischmassenanteile nicht einfach addiert werden. Erst jeden Dichtebeitrag mit dem Volumen-/Molanteil gewichten. Das korrigiert M9.16f.], fill: sand)
=== 7.5.1 Entropie beim Mischen idealer Gase <a-7-5-1>
Ideale Gase haben bei gemeinsamem T keine Mischungsenthalpie. Trotzdem vergrößert das Vermischen verschiedener zunächst getrennter Gase bei gleichem T und p die Entropie: Jedes Gas kann nach dem Entfernen der Trennwand einen größeren Raum belegen.
#form[$ Delta S_"Misch"=-n R_m sum_i psi_i ln(psi_i)>=0 $]
Für vorher getrennte reine ideale Gase bei gleichem T und p, ohne Reaktion. Die Größe n ist die gesamte Stoffmenge nach dem Mischen. Bei unveränderter Zusammensetzung gilt für Zustandsänderungen dagegen $Delta s=c_(p,"Gemisch")ln(T_2/T_1)-R_"Gemisch"ln(p_2/p_1)$ bei konstanten Kapazitäten. Ändern sich die Anteile, darf dieser feste-Gemisch-Ausdruck nicht ungeprüft benutzt werden.
#src[MT, PDF-S. 20–21 (insbesondere Gl.8.31 zur Mischungsentropie); BT Kapitel 8; Ü 7.1–7.2, PDF-S. 42; Ü 9.16, PDF-S. 57. Umrechnungen aus Definitionen hergeleitet.]
#hoch(<a-7>, [Kapitelübersicht])
#note("Der Zusammenhang in Kapitel 7", [Der Partialdruck entscheidet über Sättigung, die Trockenluftmasse über die Bezugsbasis. x bilanziert Wasser, h bilanziert Energie. Erst beide zusammen legen den neuen Zustand fest.])

#pagebreak()
= Kapitel 8 · Verbrennungsrechnung · Ergänzung aus der Aufgabensammlung <a-8>
#überblick([Kapitel 8 auf einen Blick],
 idee(<a-8-1>, [Reaktionsgleichung und Mengenbasis], [Atome erhalten und molare von massenbezogenen Daten trennen.]),
 idee(<a-8-2>, [Mindestluftbedarf und Luftüberschuss], [Stöchiometrie vor den tatsächlichen Luftstrom setzen.]),
 idee(<a-8-3>, [Abgas: feucht, trocken und normiert], [Wasser und Luftstickstoff vollständig mitführen.]),
 idee(<a-8-4>, [Heizwert, Brennwert und Wärmebilanz], [Den Zustand des Produktwassers zur Energieaussage nennen.]),
)
#karte((1fr, auto, 1fr),
 chunk([Reaktionsgleichung und Mengenbasis], [Atome erhalten und molare von massenbezogenen Daten trennen.], ziel: <a-8-1>), pfeil(),
 chunk([Mindestluftbedarf und Luftüberschuss], [Stöchiometrie vor den tatsächlichen Luftstrom setzen.], ziel: <a-8-2>),
 chunk([Abgas: feucht, trocken und normiert], [Wasser und Luftstickstoff vollständig mitführen.], ziel: <a-8-3>), pfeil(),
 chunk([Heizwert, Brennwert und Wärmebilanz], [Den Zustand des Produktwassers zur Energieaussage nennen.], ziel: <a-8-4>),
)
#hoch(<ueberblick>, [Modul auf einen Blick])
Die vollständigen Aufgaben und historischen Prüfungen enthalten Brennstoff-, Luft- und Abgasrechnungen. Zuerst werden Atome bilanziert, danach Mengenbezug und Energie. Heizwerte und historische Brennstoffdaten werden als Aufgabenwerte verwendet.

#pagebreak(weak: true)
== 8.1 Reaktionsgleichung und Mengenbasis <a-8-1>
Eine vollständige Verbrennung bildet im vereinfachten Rechenmodell CO₂ aus C, H₂O aus H und SO₂ aus S. Die Atome bleiben erhalten. Für einen allgemeinen Brennstoffanteil mit C, H und O gilt:
#form[$ "C"_a "H"_b "O"_c+(a+b/4-c/2)"O"_2 -> a "CO"_2+(b/2)"H"_2"O" $]
Der bereits im Brennstoff enthaltene Sauerstoff vermindert den äußeren Bedarf. Inerte Anteile, Stickstoff, mitgebrachtes Wasser und Asche müssen getrennt verfolgt werden. Bei Massenanteilen zuerst durch die zugehörigen Molmassen teilen, bevor Atommengen addiert werden.
#bild("map-verbrennung", [Mindmap zum Verbrennungsschema. Eigene Darstellung.], height: 46mm)
#note("Quellenfehler im Buchbeispiel", [BT, PDF-S. 446, schreibt im Methanolbeispiel widersprüchliche Wasserkoeffizienten. Aus der Atombilanz folgt eindeutig $"CH"_3"OH"+"1,5""O"_2 -> "CO"_2+2"H"_2"O"$. Die allgemeine Reaktionsgleichung darüber ist die sichere Grundlage.], fill: sand)
#src[Ü Kapitel 8, PDF-S. 45 ff.; MT, Verbrennungsabschnitt; BT 11.3–11.4, S. 428–433 / PDF-S. 443–448.]
#hoch(<a-8>, [Kapitelübersicht])

#pagebreak(weak: true)
== 8.2 Mindestluftbedarf und Luftüberschuss <a-8-2>
#form[$ L_"min"=frac(O_"min",psi_("O2",L)) quad lambda=frac(L,L_"min") quad L=lambda L_"min" $]
L und O müssen denselben Brennstoffbezug besitzen, etwa kmol Luft bzw. O₂ je kmol Brennstoff. Bei trockener Luft verwendet die Quelle ungefähr 21 Mol-% Sauerstoff. Der Sauerstoff-Massenanteil ist dagegen rund 23,14 % und darf nicht an derselben Stelle eingesetzt werden.
Für eine Elementaranalyse mit Massenanteilen c, h, s und o folgt mit gerundeten Molmassen der O₂-Bedarf je kg Brennstoff:
#form[$ n_("O2,min")=c/12+h/4+s/32-o/32 $]
Alle Terme stehen in kmol/kg. Bei λ größer eins bleibt nach vollständiger Verbrennung überschüssiger Sauerstoff; bei λ kleiner eins ist das Modell vollständiger Verbrennung im Allgemeinen nicht mehr erfüllbar. „60 % Luftüberschuss“ bedeutet λ=1,6, nicht 0,6.
#src[BT 11.4, S. 431–435 / PDF-S. 446–450; Ü Kapitel 8. Gerundete Molmassen ausdrücklich angegeben.]
#hoch(<a-8>, [Kapitelübersicht])

#pagebreak(weak: true)
== 8.3 Abgas: feucht, trocken und normiert <a-8-3>
Zur Produktmenge gehören Reaktionsprodukte, Brennstoffwasser, mit der Luft eingetragenes Wasser, Luftstickstoff und gegebenenfalls überschüssiger Sauerstoff. Der trockene Abgasbezug lässt nur das Wasser weg, nicht den Stickstoff. Gasförmige Molanteile werden erst nach der Summe aller passenden Produktmengen gebildet.
#form[$ psi_i=n_i/sum_j n_j quad V_n=n V_(m,n) quad n_("O2,rest")=(lambda-1)n_("O2,min") $]
Die Rest-O₂-Beziehung setzt vollständige Umsetzung und den gleichen Stoffmengenbezug voraus. Bei feuchter Luft kommt $n_("H2O,L")/n_(L,"trocken")=phi p_s/(p-phi p_s)$ hinzu. Bei Abgasanalysen müssen gemessene trockene Prozentwerte mit einer trockenen Modellzusammensetzung verglichen werden.
Roh-, trocken-, wasserfrei- oder wasser-/aschefreier Brennstoff unterscheiden sich durch den Nenner. Vor einer Umrechnung die verbleibende Massenfraktion ausdrücklich nennen; ein auf Brennstoffmasse bezogener Heizwert bleibt dabei keine unveränderliche Zahl.
#note("Weiterrechenwerte neu bilanzieren", [Gibt ein Aufgabenblatt für spätere Teilaufgaben ausdrücklich eine andere Brenngaszusammensetzung vor, müssen deren Produkte und Mengen neu zu diesen Atomzahlen passen. Die alte Rauchgasanalyse darf dann nicht unverändert für den neuen Stoff verwendet werden. M9.16j vermischt diese Daten; die Aufgabe zeigt beide Ausgangslagen ausdrücklich.], fill: sand)
=== 8.3.1 Produkttabelle auf einer festen Brennstoffbasis <a-8-3-1>
Die beiden Brennstoffgruppen des Memory verlangen verschiedene Nenner. In der ersten Spalte stehen kmol Produkt je kg fester/flüssiger Brennstoff mit Massenanteilen c,h,s,w,n. In der zweiten stehen kmol Produkt je kmol Gasgemisch mit Molanteilen ψ. Für trockene Brennluft und vollständige Umsetzung gilt:
#tab(columns: (auto,1fr,1.4fr), th([Produkt],[Elementaranalyse: kmol/kg],[Gasgemisch: kmol/kmol]),
[CO₂],[$c/12$],[$sum_i a_i psi_i$; inklusive schon enthaltenem CO₂],
[H₂O],[$h/2+w/18$],[$sum_i (b_i/2)psi_i+psi_("H₂O")$],
[SO₂],[$s/32$],[Schwefelmenge aus allen umgesetzten Komponenten],
[O₂],[$(lambda-1)n_("O₂,min")$],[$(lambda-1)O_"min"$],
[N₂],[$n/28+psi_("N₂,L")lambda L_"min"$],[Brennstoff-N₂ plus Luft-N₂])
$a_i,b_i$ zählen die C-/H-Atome brennbarer Komponenten; bereits enthaltenes CO₂ oder H₂O wird als Inert-/Begleitstoff zusätzlich mitgenommen und nicht nochmals verbrannt. Bei feuchter Brennluft kommt deren Wasserbeitrag separat hinzu. Brennstoffsauerstoff ist schon bei der Mindestluft zu verrechnen; ihn ein zweites Mal vom Rest-O₂ abzuziehen wäre falsch.
Aus den molaren Produkten folgt die Massenmenge durch $m_i=n_i M_i$. Die trockene Analyse normiert erst nach Weglassen des Wassers neu auf ihre eigene Summe. Für Hu,m und Hu,v gilt $H_(u,m)=M_B H_u$ und $H_(u,v)=H_(u,m)/V_(m,n)$; derselbe Normzustand ist dabei ausdrücklich beizubehalten.
#src[MT, PDF-S.39–45 (M44–M50), TabellenM11-1 bisM11-10 und Gl.11.36–11.40. Produkttabelle aus Atombilanzen zusammengeführt.]
#src[BT 11.4–11.6, S. 433–443 / PDF-S. 448–458; MT Verbrennungsschema; Ü Kapitel 8 und 9.16.]
#hoch(<a-8>, [Kapitelübersicht])

#pagebreak(weak: true)
== 8.4 Heizwert, Brennwert und Wärmebilanz <a-8-4>
Der *Heizwert* Hᵤ beschreibt den Energieumsatz mit dampfförmigem Produktwasser; der *Brennwert* Hₒ mit kondensiertem Wasser am festgelegten Bezug. Der Unterschied ist die zusätzlich nutzbare Kondensationsenthalpie des bei der Verbrennung entstandenen bzw. mitgebrachten Wassers.
#form[$ H_o-H_u=m_("W,Produkt")r_0 quad dot(Q)_B=dot(m)_B H_u $]
Die erste Formel ist je kg Brennstoff zu lesen, wenn die Wassermasse entsprechend auf kg Brennstoff bezogen ist. Bei Volumen- und Molheizwerten müssen Bezug und Einheiten erst umgerechnet werden. Eine Temperaturerhöhung des Abgases erfordert die Enthalpiesumme aller Produktkomponenten, nicht nur eines pauschalen Luftstroms.
Für den adiabaten Verbrennungszustand gilt im vereinfachten Modell: Brennstoffenergie plus sensible Zufuhrenthalpie gleich sensible Produktenthalpie. Temperaturabhängige Wärmekapazitäten erfordern gegebenenfalls eine Iteration. Der Taupunkt folgt aus dem Wasserdampfpartialdruck; Kondensation verändert zugleich Abgasmenge und Energiebilanz.
Für feste/flüssige Brennstoffe verwendet MT die empirische Näherung $H_u=["33,9"c+"121,4"h+"10,5"s-"15,2"o-"2,44"w]$ MJ/kg mit Element-/Wassermassenanteilen als Brüchen. Ein Mess- oder Tabellenwert hat Vorrang. Ein unbekannter Restanteil im Brenngas bleibt mit seinem Heizwert als Parameter stehen; die Bezeichnung „weitere Kohlenwasserstoffe“ allein legt den Zahlenwert nicht fest.
Bei einer Bezugstemperatur ϑ₀ sind sensible Produktenthalpien als c̄pi(ϑ)ϑ−c̄pi(ϑ₀)ϑ₀ anzusetzen. Liegen Brennstoff und Luft schon bei ϑ₀, ist deren zusätzliche sensible Zufuhr null. Adiabate Verbrennungstemperatur ist die Nullstelle der vollständigen Energiebilanz mit temperaturabhängigen c̄p; Wärmeverlust und unverbrannte Stoffe verändern die Bilanz.
#src[MT PDF-S. 45 (M50), Gl. 11.39–11.51; Ü 8.4 und 8.10.]
#note("Der Zusammenhang in Kapitel 8", [Atombilanz liefert Sauerstoffbedarf und Produkte. Luftüberschuss und Feuchte vervollständigen die Stoffbilanz. Erst danach bewerten Heizwert, Brennwert und sensible Enthalpien den Energieumsatz.])
#src[Ü Kapitel 8; MT Verbrennungsabschnitt; BT 11.7, S. 449–457 / PDF-S. 464–472. Wärmekapazitäten nur nach der jeweiligen Aufgabenquelle.]
#hoch(<a-8>, [Kapitelübersicht])

#pagebreak()
= Kapitel 9 · Strömungsmechanik <a-9>
#überblick([Kapitel 9 auf einen Blick],
 idee(<a-9-1>, [Hydrostatik, Druckmessung und Kesselformel], [Druck ist skalar, Druckkräfte sind gerichtet.]),
 idee(<a-9-2>, [Wandkraft, Druckmittelpunkt und Auftrieb], [Druckverteilung integrieren statt nur mit Tiefe zu multiplizieren.]),
 idee(<a-9-3>, [Atmosphäre und gekrümmte Stromlinien], [Veränderliche Dichte und Normalbeschleunigung berücksichtigen.]),
 idee(<a-9-4>, [Bernoulli und Druckbegriffe], [Statische, dynamische und Lageanteile gemeinsam bilanzieren.]),
 idee(<a-9-5>, [Rohrreibung und Einzelverluste], [Reynolds-Zahl und Darcy-Reibzahl passend bestimmen.]),
 idee(<a-9-6>, [Pumpen, Kennlinien und Rohrnetze], [Knoten und Maschen mit dem richtigen Widerstandsgesetz lösen.]),
)
#karte((1fr, auto, 1fr),
 chunk([Hydrostatik, Druckmessung und Kesselformel], [Druck ist skalar, Druckkräfte sind gerichtet.], ziel: <a-9-1>), pfeil(),
 chunk([Wandkraft, Druckmittelpunkt und Auftrieb], [Druckverteilung integrieren statt nur mit Tiefe zu multiplizieren.], ziel: <a-9-2>),
 chunk([Atmosphäre und gekrümmte Stromlinien], [Veränderliche Dichte und Normalbeschleunigung berücksichtigen.], ziel: <a-9-3>), pfeil(),
 chunk([Bernoulli und Druckbegriffe], [Statische, dynamische und Lageanteile gemeinsam bilanzieren.], ziel: <a-9-4>),
)
#hoch(<ueberblick>, [Modul auf einen Blick])
#link(<a-9-7>)[Impuls] · #link(<a-9-8>)[Drall] · #link(<a-9-9>)[Ähnlichkeit] · #link(<a-9-10>)[Potential] · #link(<a-9-11>)[Widerstand] · #link(<a-9-12>)[Gleitflug] · #link(<a-9-13>)[Kompressibler Ausfluss]

Strömungsaufgaben beginnen mit der Wahl des Kontrollvolumens. Hydrostatik bestimmt ruhende Druckfelder, Bernoulli die mechanische Energiebilanz, Impuls die Kräfte. Verluste und Pumpen verbinden diese Werkzeuge im Rohrnetz.

#pagebreak(weak: true)
== 9.1 Hydrostatik, Druckmessung und Kesselformel <a-9-1>
In einer ruhenden Flüssigkeit gleicher Dichte wächst der Druck mit der Tiefe; bei Höhe z nach oben gilt $dif p/dif z=-rho g$. Zusammenhängende ruhende Flüssigkeitsbereiche haben in derselben Höhe denselben Druck, sofern kein Trennglied dazwischen liegt. Ein U-Rohr wird deshalb abschnittsweise über seine Dichten bilanziert.
#form[$ p=p_0+rho g h quad F=p A quad frac(F_1,A_1)=frac(F_2,A_2) $]
Die Kraftformel setzt gleichmäßigen Druck auf einer ebenen Fläche voraus. Eine hydraulische Presse überträgt Druck, erzeugt aber keine Energie: Kraftgewinn geht mit kleinerem Weg einher. Bei absolutem Druck unter dem Dampfdruck kann Flüssigkeit verdampfen; ein gedachter Heber funktioniert dann nicht mehr als zusammenhängende Flüssigkeitssäule.
Für den dünnwandigen Zylinder liefern Freischnitte näherungsweise Umfangsspannung $sigma_U=p_"ü"d/(2t)$ und Längsspannung $sigma_L=p_"ü"d/(4t)$. Entscheidend ist die Druckdifferenz über der Wand. Ein Festigkeitsnachweis verlangt zusätzlich zulässige Spannung, Sicherheitsbeiwert und geeignetes Vergleichsspannungsmodell.
#bild("map-stroemung", [Mindmap der strömungsmechanischen Werkzeuge. Eigene Darstellung.], height: 46mm)
=== 9.1.1 Hydrostatisches Paradoxon <a-9-1-1>
#bild("hydrostatisches-paradoxon", [Gleiche Bodenkraft bei verschiedenen Gefäßformen. Eigene Darstellung nach BS, PDF-S.45; Thema S1, PDF-S.4.], height: 62mm)
Die Folie S1, PDF-S.4, ist ein Tafel-Platzhalter; die Skizze erklärt das belegte Grundprinzip und ersetzt nicht Deine spätere Mitschrift. Gleiche Füllhöhe und Dichte ergeben auf gleicher horizontaler Bodenfläche dieselbe Bodenkraft, auch wenn unterschiedlich viel Flüssigkeit im Gefäß liegt. Der scheinbare Widerspruch verschwindet im Kräftegleichgewicht: Schräge oder abgestufte Seitenwände übertragen zusätzlich vertikale Kräfte. „Bodenkraft gleich Flüssigkeitsgewicht“ gilt deshalb nicht für beliebige Gefäßformen.
=== 9.1.2 Warum Druck keine Richtung hat <a-9-1-2>
#bild("druck-richtungsunabhaengigkeit", [Kräftegleichgewicht am ruhenden Flüssigkeitsprisma. S1, PDF-S.2.], height: 67mm)
Druck ist eine skalare Ortsgröße; erst die *Druckkraft* bekommt durch die Flächennormale eine Richtung. Beim infinitesimal kleinen ruhenden Prisma verknüpfen die projizierten Flächen die Normalkraftkomponenten. Deren Gleichgewicht liefert denselben Druck auf allen unterschiedlich orientierten Schnittflächen. Das Eigengewicht skaliert mit der dritten, die Flächenkraft mit der zweiten Längendimension und verschwindet deshalb in diesem lokalen Grenzübergang relativ zur Flächenkraft.
Die Richtungsunabhängigkeit gilt für den hydrostatischen Druck. In einer bewegten zähen Flüssigkeit kommen Schub- und gegebenenfalls weitere Normalspannungen zum Druckanteil hinzu; diese werden dadurch nicht ebenfalls zu richtungsunabhängigen Größen.
#src[S1, PDF-S.2; Gleichgewichtsargument der Folie ergänzend in Worten ausgeführt.]
#src[S1, PDF-S. 1–8; BS Kapitel 1. Die überwiegend mit „Tafel“ beschrifteten Arbeitsseiten bleiben Quellen für spätere Mitschriftergänzungen.]
#hoch(<a-9>, [Kapitelübersicht])

#pagebreak(weak: true)

=== 9.1.3 Wandspannungen, Kapillaren und dünne Druckhüllen <a-9-1-3>
Ein ruhendes einfaches Fluid trägt keine dauernden Schubspannungen. Sein Druck ist am selben Punkt in allen Richtungen gleich. Bei einem strömenden realen Fluid muss dieser skalare thermodynamische Druck von den zusätzlichen viskosen Spannungen unterschieden werden: Die gesamte Normalspannung ist dann nicht zwingend richtungsunabhängig. Räumliche Druckänderung, etwa mit der Tiefe, widerspricht örtlicher Druckisotropie nicht.
*Oberflächenspannung* σ beschreibt Kraft je Grenzlinienlänge bzw. Energie je neu gebildeter Grenzfläche; N/m und J/m² sind gleichwertig. In einer dünnen kreisförmigen Kapillare verbindet das Kräftegleichgewicht Grenzflächenzug und Flüssigkeitsgewicht:
#form[$ h=frac(2sigma cos theta,rho g r) $]
Kontaktwinkel θ wird durch die Flüssigkeit gemessen, r ist der Kapillarradius. Gute Benetzung wie Wasser an sauberem Glas liefert im einfachen Modell θ kleiner als90° und Aufstieg; Quecksilber an Glas liefert Depression. Andere Stoffpaarungen und verschmutzte Oberflächen brauchen ihre eigenen Kontaktwinkel.
Eine dünnwandige geschlossene zylindrische Druckhülle trägt den inneren Überdruck Δp vor allem als Membranzug. Mit Wanddicke s und Durchmesser D folgt aus dem Gleichgewicht am längs aufgeschnittenen Mantel bzw. an der Stirnfläche:
#form[$ sigma_phi=frac(Delta p D,2s) quad sigma_z=frac(Delta p D,4s) $]
Die Umfangsspannung ist doppelt so groß wie die axiale. Ein Längsriss entlastet diese stärkere Umfangszugspannung. Die echte radiale Wandnormalspannung ist etwas anderes und im dünnwandigen Modell vergleichsweise klein; die Bezeichnung „radiale Spannung“ mancher Kurzfragen meint hier ungenau die Umfangsspannung. Die Näherung verlangt s viel kleiner als D und erfasst keine lokalen Spannungsspitzen.
#src[SM PF SS03, Kurzfragen6–7 und10, PDF-S.1/MusterPDF-S.3; SM PF SS02, Kurzfrage12, PDF-S.2/MusterPDF-S.4; gescannte SM LN SS01, Fragen1.9–1.12, PDF-S.1. Kräftegleichgewichte eigene Erläuterung.]
#hoch(<a-9>, [Kapitelübersicht])

== 9.2 Wandkraft, Druckmittelpunkt und Auftrieb <a-9-2>
Auf eine senkrechte ebene Wand wirkt in größerer Tiefe stärkerer Druck. Die Gesamtkraft greift deshalb im Allgemeinen unterhalb des Flächenschwerpunkts an. Mit Überdruck null an der freien Oberfläche gilt für die vollständig benetzte vertikale Fläche:
#form[$ F=rho g A h_S quad h_D=h_S+frac(I_S,A h_S) $]
$h_S$ ist die Schwerpunkttiefe, $I_S$ das Flächenträgheitsmoment um die waagerechte Schwerpunktachse. Zusätzlicher gleichmäßiger Gasüberdruck verändert Kraft und Angriffspunkt; dafür den Druck direkt integrieren. Für geneigte Flächen ist die vertikale Tiefe von der Entfernung entlang der Fläche zu unterscheiden.
#form[$ F_A=rho_"Fluid"g V_"verdrängt" $]
Die Auftriebskraft entspricht dem Gewicht des verdrängten Fluids. Bei räumlich veränderlicher Dichte ist $F_A=g integral_(V_"verdrängt")rho(z)dif V$. Schweben verlangt gleiche Gesamtkräfte, stabile Lage zusätzlich ein rückstellendes Moment. Die Folienaussage „dreht sich bis Auftrieb im Schwerpunkt angreift“ ist verkürzt: Gewicht und Auftrieb müssen auf einer gemeinsamen Wirkungslinie liegen, ihre Angriffspunkte müssen nicht zusammenfallen.
#src[S1, PDF-S. 9–10 und 16–17; zusätzliches Blatt „2022-01-11 FET Auftrieb rho(z) Kugel.pdf“; BS Kapitel 1. Stabilitätsabgrenzung ergänzt.]
#hoch(<a-9>, [Kapitelübersicht])

#pagebreak(weak: true)

=== 9.2.1 Schwimmen braucht auch ein rückstellendes Moment <a-9-2-1>
Das Kräftegleichgewicht FA=FG legt fest, wie viel Fluid ein schwimmender Körper verdrängt. Es entscheidet noch nicht, ob eine leicht geneigte Lage wieder in die Ausgangslage zurückkehrt. Bei einer kleinen Neigung verschiebt sich der Schwerpunkt des verdrängten Volumens B und damit die Auftriebswirkungslinie.
Das *Metazentrum* M ist im linearen Kleinneigungsmodell der Schnitt dieser verschobenen Auftriebslinie mit der ursprünglichen Symmetrielinie. Liegt der Körperschwerpunkt G unter M, wirkt das Moment rückstellend. Für eine geeignete symmetrische Wasserlinienfläche gilt:
#form[$ G M=B M-B G quad B M=frac(I_"Wasserlinie",V_"verdrängt") $]
I ist das Flächenträgheitsmoment der Wasserlinie um die betrachtete Neigungsachse, mit Einheit m⁴; V hat m³. Daher ist GM eine Länge. G unter B ist eine hinreichende stabile Anordnung, aber allgemeine Stabilität verlangt G unter M. Für einen schlanken senkrechten Kreiszylinder ergibt sich BM=D²/(16LC), weil I=πD⁴/64 und V=πD²LC.
#note("Musterantwort präzisieren", [SM PF SS06, Aufgabe1.3, verlangt G unter B. Das ist eine passende hinreichende Bedingung für den schlanken Stab. Als allgemeines notwendiges Kriterium wäre sie zu streng. Die zusätzliche Geometriewirkung der Wasserlinie steckt in BM.], fill: sand)
#src[SM PF SS06, Aufgabe1.1–1.3, PDF-S.5 und9; Kräfte-/Momentenprinzip aus9.2. Metazentrische Kleinneigungsformel als eigene geometrische Ergänzung und Präzisierung der Musterantwort.]
#hoch(<a-9>, [Kapitelübersicht])

== 9.3 Atmosphäre und gekrümmte Stromlinien <a-9-3>
#form[$ frac(dif p,dif z)=-rho g=-frac(p g,R T(z)) $]
Bei isothermer Atmosphäre folgt $p(z)=p_0 exp[-g(z-z_0)/(R T)]$. Bei linearer Temperatur $T=T_0-L(z-z_0)$ mit positivem Temperaturgradientbetrag L:
#form[$ p(z)=p_0 (T(z)/T_0)^(g/(R L)) quad rho(z)=p(z)/(R T(z)) $]
Gleiche Gaskonstante, hydrostatisches Modell und näherungsweise konstantes g; jeden Schichtabschnitt mit seinem Anfangszustand verknüpfen. Eine polytrope Schichtung mit n ist nicht automatisch isentrop; dafür müsste n zum Stoffwert κ passen. Die Folie verwendet n≈1,23628, also nicht κ≈1,4 für Luft.
Quer zu einer gekrümmten Stromlinie erfordert die Zentripetalbeschleunigung einen Druckgradienten. In Richtung vom Krümmungsmittelpunkt nach außen gilt $dif p/dif r=rho c^2/r$. Im geraden Freistrahl ohne Oberflächenspannung prägt sich näherungsweise der Umgebungsdruck ein.
#note("Einheitenkorrektur auf S1, PDF-S. 18", [Der Rechenwert des dünnen Wasserfilms beträgt rund 2,63 bar. Das sind rund 263.000 Pa; die gedruckte Kombination „26300 Pa = 2,63 bar“ enthält einen Faktor-10-Fehler.], fill: sand)
Das historische Folienmodell benutzt $p_0=101325$ Pa, $T_0="288,15"$ K und $R="287,053"$ J/(kg K). Die Schichten werden an ihren Grenzen stetig aneinander angeschlossen:
#tab(columns: (auto,1fr,1fr), th([Höhe z],[Temperaturprofil],[Druckansatz]),
[0–11km],[$T=T_0-"0,0065"z$; z in m],[Polytrope Höhenformel],
[11–20km],[$T="216,65"$ K],[Isotherme Höhenformel ab11km],
[20–32km],[$T="216,65"+"0,001"(z-20000)$ K],[Allgemeine Integration mit positivem Temperaturgradient])
Die Tabelle beschreibt die idealisierte Standardatmosphäre der Unterlage, keine aktuelle Wetterlage. Die Schichtung ist ein räumlicher Zustand; sie ist nicht automatisch der isentrope Aufstieg eines einzelnen Luftpakets.
#src[S1, PDF-S. 11–15 und 18. Atmosphärenformeln aus Hydrostatik und idealem Gas hergeleitet; Zahlen sind das historische ICAO-Modell der Quelle.]
#hoch(<a-9>, [Kapitelübersicht])

#pagebreak(weak: true)
== 9.4 Bernoulli und Druckbegriffe <a-9-4>
#form[$ p_1+rho c_1^2/2+rho g z_1+Delta p_"Pumpe"=p_2+rho c_2^2/2+rho g z_2+Delta p_"V" $]
Stationäre inkompressible mechanische Energiebilanz; Verlustbetrag positiv in Strömungsrichtung, Pumpenzufuhr positiv. Die reibungsfreie Grundform gilt entlang einer Stromlinie. Zwischen beliebigen Punkten verschiedener Stromlinien ist zusätzlich etwa ein wirbelfreies Feld mit gemeinsamer Bernoulli-Konstante erforderlich; der pauschale Satz auf S23, PDF-S. 1, lässt diese Voraussetzung weg.
#form[$ p_"dyn"=rho c^2/2 quad p_"ges"=p_"stat"+p_"dyn" quad c=sqrt(2 Delta p/rho) $]
Prandtl-/Pitotmessung erfasst den Unterschied zwischen Stau- und statischem Druck. Die letzte Gleichung gilt bei geeigneter inkompressibler Messung. Eine Höhendifferenz in einem Manometer ist erst über die beteiligten Dichten in Δp umzusetzen. Venturi verbindet Kontinuität $A_1 c_1=A_2 c_2$ und Bernoulli; der kleinere Querschnitt erhöht c und senkt im reibungsfreien horizontalen Fall den statischen Druck.
=== 9.4.1 Hydrodynamisches Paradoxon <a-9-4-1>
#bild("hydrodynamisches-paradoxon", [Radiale Spaltströmung an einer Kreisplatte. S23, PDF-S.6.], height: 75mm)
Für einen engen konstanten Spalt s und stationäre radiale Strömung außerhalb der zentralen Umlenkzone gilt aus Kontinuität $c(r)=dot(V)/(2 pi r s)$. Nach außen wächst die durchströmte Ringfläche, die Geschwindigkeit sinkt. Bei Umgebungsdruck am äußeren Radius $r_a$ folgt reibungsfrei:
#form[$ p(r)=p_"∞"+rho/2[c(r_a)^2-c(r)^2] $]
Innen ist c größer und der statische Druck kleiner. Die Platte kann dadurch zum Rohr gezogen werden. Im unmittelbaren Auftreff- und Umlenkbereich reicht diese eindimensionale Bernoulli-Betrachtung nicht; dort gehört die Impulsbilanz hinzu.
=== 9.4.2 Ausfluss und Heber: erst die Endpunkte, dann den Scheitel <a-9-4-2>
#bild("torricelli-heber-folie", [Offener Behälter mit tieferem Austritt. S23, PDF-S.2.], height: 57mm)
Sind freie Oberfläche und Austritt auf gleichem Umgebungsdruck und ist die Behälterfläche groß, wird die Lageenergie in Austrittsgeschwindigkeit umgewandelt: $c_2=sqrt(2g(z_1-z_2))$. Das ist die Torricelli-Formel für den verlustfreien, näherungsweise stationären Ausfluss. Reale Rohr-/Einlaufverluste verringern die Geschwindigkeit.
Für einen gleich weiten Heber mit Verlustbeiwert ζ zwischen Oberfläche und Austritt gilt $c=sqrt(2g(z_1-z_2)/(1+zeta))$. Am Scheitel S ist der Absolutdruck $p_S=p_"∞"+rho g(z_1-z_S)-rho c_S^2/2-Delta p_("V",1->S)$. Er muss oberhalb des zum Stoffzustand gehörenden Dampfdrucks bleiben. Eine tiefere Austrittsöffnung kann somit mehr Durchsatz erzeugen und zugleich den Scheiteldruck weiter absenken.

=== 9.4.3 Dieselbe Bilanz in drei Einheiten <a-9-4-3>
#tab(columns: (auto,1fr,auto), th([Form],[Einzelterme],[Einheit]),
[Spezifische Energie],[$p/rho+c^2/2+g z$],[J/kg],
[Druck],[$p+rho c^2/2+rho g z$],[Pa],
[Höhe],[$p/(rho g)+c^2/(2g)+z$],[m])
Pumpenarbeit und Verlust müssen in derselben Zeile angegeben werden: Y und j, ρY und ΔpV, oder Y/g und hV. Es gilt $Delta p_V=rho j=rho g h_V$. Bei der Umrechnung ist insbesondere 1bar=100000Pa zu beachten; der nackte Zahlenwert eines Drucks in bar passt nicht zu ρc²/2 in Pascal.
#src[S23, PDF-S.1–3 und7–8; S1, PDF-S.7. Torricelli-/Heberbeziehung aus den angegebenen Bernoulli-Bedingungen hergeleitet.]
#src[S23, PDF-S. 1–8; BS 2.1–2.6. Gültigkeit zwischen Stromlinien ausdrücklich präzisiert.]
#hoch(<a-9>, [Kapitelübersicht])

#pagebreak(weak: true)

=== 9.4.4 Offene Gerinne und der Wechselsprung <a-9-4-4>
Ein Gerinne besitzt eine freie Oberfläche. Am festen Boden haftet das reale Fluid, oben fehlt eine zweite haftende Rohrwand. Die Geschwindigkeit wächst meist vom Boden zur Oberfläche; in realen Querschnitten kann ihr Maximum durch Sekundärströmungen etwas unter dem Spiegel liegen.
Die *Froude-Zahl* verbindet Strömung und Schwerewellen. Für einen breiten rechteckigen Querschnitt mit Tiefe h gilt Fr=c/√(gh): Fr kleiner als1 heißt strömend, Fr größer als1 schießend. Beim *Wechselsprung* wird eine schnelle flache Strömung abrupt langsamer und tiefer. Masse und Impuls bleiben bilanziert, mechanische Energie wird dissipiert.
#form[$ Q=b h_1 c_1=b h_2 c_2 quad frac(h_2,h_1)=frac(sqrt(1+8"Fr"_1^2)-1,2) $]
Die zweite Formel folgt als eigene Herleitung aus der stationären Impulsbilanz des horizontalen rechteckigen Kanals mit hydrostatischer Drucklast und vernachlässigter Bodenreibung über die kurze Sprungstrecke. Sie ist keine verlustfreie Bernoulli-Beziehung. Andere Querschnitte oder geneigte Sohlen benötigen ihre eigene Impulsbilanz.
#src[SM PF SS02, Kurzfrage9, PDF-S.1/MusterPDF-S.3; SM PF SS04, Kurzfragen3 und5, PDF-S.1/MusterPDF-S.3. Verbundene-Tiefen-Formel eigene Herleitung aus Kontinuität und Impulssatz9.7.]
#hoch(<a-9>, [Kapitelübersicht])

== 9.5 Rohrreibung und Einzelverluste <a-9-5>
#form[$ Re=frac(c d_h,nu) quad d_h=4 A/U_"benetzt" quad Delta p_"V"=(lambda L/d_h+sum_i zeta_i)rho c^2/2 $]
Die Summe setzt dieselbe Bezugsgeschwindigkeit voraus; bei verschiedenen Durchmessern jeden Beitrag mit seinem eigenen c auswerten. Der hydraulische Durchmesser ist eine geometrische Ersatzgröße; Formkorrekturen können im laminaren Fall nötig sein. ν in m²/s, Rohrrauigkeit k und d in denselben Längeneinheiten.
#bild("moody-original", [Darcy-Rohrreibzahl aus dem Moody-Diagramm. S23, PDF-S. 13.], height: 65mm)
Für laminares Kreisrohr gilt λ=64/Re. Die Folien verwenden Re≈2320 als Übergangskennwert; der Übergang ist kein universeller scharfer Sprung. Turbulent hängt λ von Re und k/d ab, im vollständig rauen Grenzfall nur von k/d. Eine gebräuchliche implizite Gleichung ist
#form[$ frac(1,sqrt(lambda))=-2 log_(10)(frac(k,"3,71"d)+frac("2,51",Re sqrt(lambda))) $]
Iteration und anschließend beide Seiten kontrollieren. Druckdifferenz ist nicht automatisch Verlust: Beschleunigung, Höhenänderung oder eine Maschine können ebenfalls p verändern. Positiver Verlustbetrag ist $Delta p_"V"=rho j$; die negative Vorzeichenangabe auf S23, PDF-S. 7, passt nicht zu dieser im Skript verwendeten Betragsdefinition.
Die Folien unterscheiden näherungsweise mit $Re k/d$: unter65 hydraulisch glatt, zwischen65 und1300 Übergang, oberhalb1300 vollständig rau. Das sind die Orientierungsbereiche der angegebenen Tabelle, keine universellen scharfen Naturgrenzen. „Glatt“ heißt, dass die Rauheit in der viskosen Unterschicht keinen maßgeblichen zusätzlichen Widerstand erzeugt; es heißt nicht zwangsläufig k=0.
Bei laminar voll entwickelter Kreisrohrströmung ist das Geschwindigkeitsprofil parabolisch: $c(r)=2 bar(c)[1-(r/R)^2]$. Wandhaftung erzwingt $c(R)=0$, in der Achse ist $c(0)=2bar(c)$. Im turbulenten Fall ist der Kern flacher, der Wandgradient bleibt groß. Die Darcy-Reibzahl bezieht sich auf die mittlere Geschwindigkeit $bar(c)$, nicht auf die Achsgeschwindigkeit.
=== 9.5.1 Reibungsformeln und das passende Widerstandsgesetz <a-9-5-1>
Für das voll entwickelte laminare Kreisrohr ergibt λ=64/Re unmittelbar das Hagen-Poiseuille-Gesetz mit dynamischer Viskosität $eta=rho nu$:
#form[$ Delta p_V=frac(128 eta L,pi d^4)dot(V) $]
Hier ist der Verlust *linear* im Durchsatz. Im glatten turbulenten Bereich liefert die Blasius-Näherung $lambda="0,3164"/Re^"0,25"$ ungefähr für Re zwischen4000 und100000. Damit wächst der reine Rohrverlust bei festen Stoff-/Geometriedaten ungefähr mit $dot(V)^"1,75"$. Im vollständig rauen Bereich ist λ näherungsweise unabhängig von Re und der Verlust wächst quadratisch.
Für das vollständig raue Kreisrohr folgt aus der Colebrook-Gleichung $lambda=[-2log_(10)(k/("3,71"d))]^(-2)$. Die vollständige Colebrook-Gleichung in9.5 verbindet den Übergangs- mit dem rauen Bereich; im laminaren Bereich ersetzt sie die 64/Re-Beziehung nicht. Ein Rohrbogen zählt mit seiner gestreckten Länge zur Wandreibung und zusätzlich mit seinem eigenen Umlenkverlust; keines der beiden ist automatisch schon im anderen enthalten.
Eine quadratische Anlagenkennlinie setzt daher konstante oder ausreichend wenig veränderliche Beiwerte voraus. Gerade bei einer Durchmessersuche ändern sich Geschwindigkeit, Reynolds-Zahl, k/d und Reibzahl gemeinsam. Nach dem Rechnen sind Bereich und angenommene Beiwerte erneut zu prüfen.
#src[S23, PDF-S.9–13 und20; Blasius-/Rauheitsbeziehung aus Tabelle aufPDF-S.12, Exponenten aus Darcy und Kontinuität hergeleitet.]
#src[S23, PDF-S. 9–20; Zusatzblatt Rohrreibzahl/Newton 09.01.2022; BS Kapitel 8. Reibzahl hier Darcy, nicht Fanning.]
#hoch(<a-9>, [Kapitelübersicht])

#pagebreak(weak: true)
== 9.6 Pumpen, Kennlinien und Rohrnetze <a-9-6>
Die Pumpe stellt die spezifische Stutzenarbeit $Y=Delta p/rho+Delta(c^2)/2+g Delta z$ bereit. Hydraulische Leistung ist $P_"hydr"=dot(m)Y=dot(V)Delta p_"Pumpe"$; für die elektrische Aufnahme durch den Gesamtwirkungsgrad teilen. Sind elektrische und hydraulische Teilwirkungsgrade getrennt gegeben, die passenden Grenzen beachten.
#form[$ sum_"Knoten"dot(V)_i=0 quad sum_"Masche"Delta p_i=0 quad Delta p_i=R_i dot(V)_i abs(dot(V)_i) $]
Die letzte Form gilt für das quadratische Widerstandsmodell mit Richtungsvorzeichen. Reihenschaltung: Widerstände addieren. Parallelschaltung gleichgerichteter Stränge: $1/sqrt(R_"ers")=sum_i 1/sqrt(R_i)$. Das ist nicht die elektrische Parallelschaltungsformel $1/R=sum 1/R_i$, weil die hydraulische Kennlinie hier quadratisch ist. Laminar kann das Gesetz dagegen linear sein.
Der Betriebspunkt ist der Schnitt von Pumpen- und Anlagenkennlinie. Bei unbekanntem Durchmesser oder Volumenstrom ändern sich Re und oft λ; Geometrie und Reibzahl deshalb gegebenenfalls iterativ gemeinsam bestimmen. Eine Höhen- oder Gegendruckdifferenz erzeugt einen Kennlinienanteil auch bei null Durchfluss.
#src[S23, PDF-S. 21–27; Blatt „03-X Ström Rohrnetz Aufg Angabe 2020-12-09.pdf“. Richtungsform und Parallelschaltung aus Kontinuität hergeleitet.]
#hoch(<a-9>, [Kapitelübersicht])

#pagebreak(weak: true)
== 9.7 Impulssatz und Krümmerkräfte <a-9-7>
#bild("impuls-kontrollvolumen", [Kontrollvolumen und Kraftkomponenten am Krümmer. S56, PDF-S. 3.], height: 70mm)
#form[$ sum vec(F)=sum_"aus"dot(m) vec(c)-sum_"ein"dot(m) vec(c) $]
Stationäres Kontrollvolumen mit geeigneten mittleren Geschwindigkeiten. Druckkräfte zeigen an der Schnittfläche von außen in das Kontrollvolumen; Gewicht, Lager-/Wandkraft und weitere äußere Kräfte sind zusätzlich einzutragen. Die Gleichung wird komponentenweise ausgewertet, nicht mit bloßen Geschwindigkeitsbeträgen.
Die gesuchte Fluidkraft auf den Krümmer ist die Gegenkraft der Wand auf das Fluid. Mit Überdrücken darf gerechnet werden, wenn der Umgebungsdruck auf alle übrigen äußeren Flächen konsistent mit erfasst ist; andernfalls Absolutdrücke und äußere Umgebungskräfte separat bilanzieren.
Bei einem freien Strahl ist der Überdruck am Austritt ungefähr null. Der Impulsstrom kann trotzdem groß sein. Eine Strahlumlenkung erzeugt auch ohne großen Druck an der sichtbaren freien Oberfläche eine Kraft.
#src[S56, PDF-S. 1–6; BS 3.1–3.2. Modellbedingungen und Kraft/Gegenkraft ausdrücklich getrennt.]
#hoch(<a-9>, [Kapitelübersicht])

#pagebreak(weak: true)
== 9.8 Drall und die gemeinsame Lösungsstrategie <a-9-8>
Für rotierende Strömungsmaschinen ist neben dem Impuls der *Drall* entscheidend. Der Hebelarm gehört zum Geschwindigkeitsanteil, der das Moment um die gewählte Achse erzeugt.
#form[$ M=dot(m)(r_2 c_(u,2)-r_1 c_(u,1)) quad P=M omega $]
Stationärer Einzelstrom, feste Achse und passende Drehrichtungszeichen. $c_u$ ist der tangentiale Anteil der absoluten Geschwindigkeit. Eine rein radiale Komponente trägt um diese Achse keinen Drallstrom. Für Kraft- und Momentenbilanzen sind Druckmomente und sonstige äußere Momente mit zu berücksichtigen.

Die Eulersche Turbomaschinenhauptgleichung folgt aus demselben Drallsatz durch Multiplikation mit der Winkelgeschwindigkeit:
#form[$ Y_"th"=u_2 c_(u,2)-u_1 c_(u,1) quad u_i=omega r_i quad P_"th"=dot(m)Y_"th" $]
$u_i$ ist die Umfangsgeschwindigkeit des Laufrads, $c_(u,i)$ die tangentiale Komponente der *absoluten* Fluidgeschwindigkeit. Positive Y bedeutet Energiezufuhr zum Fluid; für eine Turbine wird sie bei dieser Konvention negativ. Relative Schaufelgeschwindigkeit und absolute Fluidgeschwindigkeit dürfen nicht verwechselt werden.
#src[S56 (Impuls-/Drallthema); BS 3.3, S. 83 ff. / PDF-S. 98 ff. Drallform als ergänzende Buchgrundlage zur mitgelieferten Sammlung.]
#hoch(<a-9>, [Kapitelübersicht])

#pagebreak(weak: true)
== 9.9 Ergänzung für Altklausuren · Modellversuch und Ähnlichkeit <a-9-9>
Ein verkleinertes Modell soll dieselbe dimensionslose Strömung erzeugen wie das Original. Geometrische Ähnlichkeit allein reicht nicht: Je nach dominanten Kräften müssen passende Kennzahlen und relative Rauigkeiten gleich sein.
#bild("modell-aehnlichkeit", [Reynolds-Ähnlichkeit. Eigene Darstellung; Grundlage BS, PDF-S. 199–204.], height: 60mm)
#form[$ Re=c L/nu quad "Fr"=c/sqrt(g L) quad "Ma"=c/a quad "St"=f L/c $]
Re vergleicht Trägheits-/Druckwirkung und Zähigkeit; Fr ist bei Schwerkraft-/Oberflächenproblemen maßgeblich, Ma bei Kompressibilität und St bei periodischen Vorgängen wie Wirbelablösung. Für ideales Gas ist $a=sqrt(kappa R T)$ die Schallgeschwindigkeit. Bei kleinen Machzahlen (Faustregel Ma unter etwa 0,3) ist eine näherungsweise inkompressible Behandlung häufig möglich; hoher Absolutdruck allein garantiert sie nicht.
#form[$ frac(F_O,F_M)=frac(rho_O c_O^2 A_O,rho_M c_M^2 A_M) quad frac(Delta p_O,Delta p_M)=frac(rho_O c_O^2,rho_M c_M^2) $]
Die Quotienten setzen gleiche relevante dimensionslose Beiwerte voraus. Rauheit ist als k/L zu vergleichen. Eine Kraft pro Länge bei einem langen Draht ist auf die entsprechende Modelllänge zu beziehen; Fläche und Länge dürfen im Skalieren nicht vermischt werden.
=== 9.9.1 Euler-Zahl und die Verhältnisrichtung der Zeit <a-9-9-1>
Die *Euler-Zahl* $"Eu"=Delta p/(rho c^2)$ vergleicht eine Druckdifferenz mit dem Trägheitsdruckmaß; manche Quellen verwenden ρc²/2 und erhalten dann den doppelten Zahlenwert. Definition und Bezugsdruck sind daher mitzunennen. Fr=c/√(gL) ist die Wurzel des Verhältnisses von Trägheits- zu Gewichtskraft, nicht unmittelbar dieses Kraftverhältnis selbst.
Mit einer Periodendauer τ ist $"St"=f L/c=L/(c tau)$. Es ist die charakteristische Durchströmzeit L/c *geteilt durch* die Periodendauer. Der verbale Quotient in der Musterlösung SM WS03/04, Kurzfrage1, steht dazu umgekehrt; die dort angegebene Formel L/(cτ) und diese Definition stimmen überein.
#src[SM PF WS03/04, Kurzfrage1 mit Musterlösung, PDF-S.1und3; Verhältnisrichtungen aus den angegebenen dimensionslosen Definitionen geprüft.]
#src[Historische SM-Prüfungen SS00/SS01/SS04 und WS05/06, Aufgaben zum Modellversuch; BS, PDF-S. 199–204, Reynolds-Ähnlichkeit und weitere Kennzahlen; Schallgeschwindigkeit BS Kapitel 11.]
#hoch(<a-9>, [Kapitelübersicht])

#pagebreak(weak: true)
== 9.10 Ergänzung für Altklausuren · Potential und Stromfunktion <a-9-10>
Eine *Potentialströmung* ist im betrachteten Gebiet drehungsfrei. Bei inkompressibler ebener Strömung beschreiben Potential Φ und Stromfunktion Ψ dasselbe Geschwindigkeitsfeld. Sie liefern eine äußere reibungsfreie Modellströmung; die Wandhaftung und reale Grenzschicht werden dadurch nicht beschrieben.
#form[$ u=frac(partial Phi,partial x) quad v=frac(partial Phi,partial y) quad u=frac(partial Psi,partial y) quad v=-frac(partial Psi,partial x) $]
#form[$ frac(partial u,partial x)+frac(partial v,partial y)=0 quad frac(partial v,partial x)-frac(partial u,partial y)=0 $]
Die erste Gleichung ist Kontinuität, die zweite Drehungsfreiheit. Für das Potential folgt $Delta Phi=0$, für die Stromfunktion entsprechend $Delta Psi=0$. In glatten Gebieten stehen Linien Φ=konstant und Ψ=konstant senkrecht aufeinander. Singularitäten (Quellen, Senken, Wirbelzentren) sind ausdrücklich aus dem Gültigkeitsgebiet auszunehmen.
#bild("potential-stromlinien", [Parallelströmung plus Quelle als äußere Körperströmung. Eigene analytische Darstellung.], height: 66mm)
#src[BS, PDF-S. 161–163, ebene Potentialströmungen und Tabelle 4.1; historische SM-Prüfungen Aufgabe 4.]
#hoch(<a-9>, [Kapitelübersicht])

#pagebreak(weak: true)
=== 9.10.1 Polarkoordinaten, Quellen, Senken und Wirbel
#form[$ c_r=frac(partial Phi,partial r)=frac(1,r)frac(partial Psi,partial phi) quad c_phi=frac(1,r)frac(partial Phi,partial phi)=-frac(partial Psi,partial r) $]
$x=r cos phi$, $y=r sin phi$. Winkel im Bogenmaß und mit richtigem Quadranten verwenden; ein einzelnes arctan(y/x) ohne Quadrantenkontrolle beschreibt das Feld nicht überall richtig. Rücktransformation: $u=c_r cos phi-c_phi sin phi$, $v=c_r sin phi+c_phi cos phi$.
#tab(columns: (auto,1fr,1fr), th([Baustein],[Potential Φ],[Stromfunktion Ψ]),
[Parallel nach +x],[$c_infinity x=c_infinity r cos phi$],[$c_infinity y=c_infinity r sin phi$],
[Quelle/Senke],[$E/(2 pi) ln r$],[$E/(2 pi)phi$],
[Potentialwirbel],[$Gamma/(2 pi)phi$],[$-Gamma/(2 pi)ln r$],
[Kreiszylinder],[$c_infinity(r+R^2/r)cos phi$],[$c_infinity(r-R^2/r)sin phi$])
E positiv ist eine Quelle, E negativ eine Senke; Γ legt den Drehsinn fest. Die Funktionen dürfen wegen der Linearität der Laplace-Gleichung überlagert werden. Ein Staupunkt erfüllt u=v=0. Eine gewünschte Körperkontur kann als geeignete Stromlinie Ψ=ΨS gewählt werden; im Kanal mit konstanter Tiefe b ist der Volumenstrom zwischen zwei Linien $dot(V)=b abs(Delta Psi)$.
#form[$ p=p_0+frac(rho,2)(c_0^2-u^2-v^2)+rho g(z_0-z) $]
Bernoulli mit gemeinsamem Bezug gilt über das gesamte zusammenhängende drehungsfreie Gebiet unter den angegebenen reibungsfreien, stationären Bedingungen. Potential und Stromfunktion haben die Einheit m²/s; eine ebene Ergiebigkeit E ist eine Volumenrate pro Tiefe. An einem idealen Wirbelzentrum divergiert die Geschwindigkeit; dieses Zentrum ist kein physikalisch überall gültiges Modell.
Der Druckbeiwert normalisiert den örtlichen Druck gegenüber der ungestörten Anströmung:
#form[$ c_p=frac(p-p_"∞",rho c_"∞"^2/2)=1-frac(c^2,c_"∞"^2) $]
Die zweite Form setzt dieselbe reibungsfreie Bernoulli-Konstante und vernachlässigbare Höhenänderung voraus. $c_p$ ist hier dimensionsloser *Druckbeiwert*, nicht die Wärmekapazität. Auf einer Stromlinie ist die Geschwindigkeit tangential: $c_n=0$, $c_t=abs(vec(c))$; das ist eine weitere Zerlegung desselben Vektors.
#src[SM PF SS03, Aufgabe4.1 und4.10, PDF-S.6 und MusterlösungPDF-S.10; Druckbeiwert aus Bernoulli hergeleitet.]
#src[BS, PDF-S. 161–163; historische SM-Prüfungen SS00–SS06, Potential-/Stromfunktionsaufgaben; Umrechnungen aus Basisvektoren hergeleitet.]
#hoch(<a-9>, [Kapitelübersicht])

=== 9.10.2 D’Alembert und der reale Wirbelkern <a-9-10-2>
Das *D’Alembertsche Paradoxon* betrifft den verschwindenden Widerstand der idealen stationären inkompressiblen Potentialumströmung eines Körpers unter den zugehörigen Randbedingungen. Eine reale Strömung erzeugt dagegen Grenzschicht, Ablösung und Widerstand. „Die gesamte Druckkraft ist immer null“ wäre zu allgemein: Mit Zirkulation kann ein ideales Modell Auftrieb besitzen, obwohl es keinen Widerstand vorhersagt.
Beim idealen Potentialwirbel ist $c_phi=Gamma/(2pi r)$ und das Feld außerhalb des Zentrums drehungsfrei. Im Zentrum würde c unbeschränkt wachsen; reale Zähigkeit und ein endlicher Wirbelkern verhindern diese Singularität. Ein vereinfachter Starrkörperkern hat dagegen $c_phi=Omega r$ mit endlicher Drehung. Potentialwirbel und realer Wirbel sind deshalb nicht über den gesamten Radius dieselbe Funktion.
#src[SM PF WS03/04, Kurzfragen6b,15,17; BS, ebene Potentialströmung und reale Grenzschicht/Körperwiderstand. Voraussetzungen und Abgrenzung zum Auftrieb präzisiert.]
#hoch(<a-9>, [Kapitelübersicht])

#pagebreak(weak: true)

=== 9.10.3 Reale Strömung, Potentialnäherung und Feldanalogie <a-9-10-3>
Die *Navier-Stokes-Gleichungen* sind die lokale Impulsbilanz für ein viskoses Newtonsches Fluid. Eine konkrete Strömung folgt erst zusammen mit Massenerhaltung, gegebenenfalls thermischer Energiegleichung, Stoffmodell und Rand-/Anfangsbedingungen. Numerische Strömungsrechnung löst dieses gekoppelte Problem; zeitgemittelte Turbulenzmodelle benötigen zusätzliche Schließungen.
Ein zweiter Rechenweg verbindet ein reibungsfreies Außenfeld mit einer viskosen Grenzschicht. Das Außenfeld liefert den Druckverlauf, die Grenzschicht Wandreibung und Hinweise auf Ablösung. Bei großer abgelöster Nachlaufzone reicht diese einfache Trennung häufig nicht mehr.
Die gemeinsame Mathematik erklärt auch eine nützliche Analogie. Für stationäre quellenfreie Wärmeleitung mit konstantem λ gilt ΔT=0. Eine stationäre inkompressible Sickerströmung nach dem linearen Darcy-Gesetz mit konstantem isotropem Durchlässigkeitsbeiwert erfüllt für ihre hydraulische Höhe H ebenfalls ΔH=0. Das Potential einer inkompressiblen wirbelfreien Strömung erfüllt ΔΦ=0.
#form[$ Delta T=0 quad Delta H=0 quad Delta Phi=0 $]
Hier bezeichnet Δ den Laplace-Operator, etwa ∂²/∂x²+∂²/∂y² im ebenen Feld, keine endliche Zustandsdifferenz. Gleiche Geometrie und entsprechende Randbedingungen erzeugen mathematisch gleiche Feldformen, obwohl Temperatur, hydraulische Höhe und Geschwindigkeitspotential verschiedene physikalische Größen bleiben.
#src[SM LN SS00, Kurzfragen20 und29, PDF-S.2/4; SM PF SS00, Kurzfrage12, PDF-S.2/4; SM PF WS01/02, Kurzfrage14–15, PDF-S.2/4. Mathematische Verknüpfung eigene Erläuterung.]
#hoch(<a-9>, [Kapitelübersicht])

== 9.11 Ergänzung für Altklausuren · Grenzschicht und Körperwiderstand <a-9-11>
Reale Fluide haften an festen Wänden. In der *Grenzschicht* wächst die Geschwindigkeit von der Wand bis auf den Außenwert. Reibung und mögliche Ablösung erzeugen Widerstand, den eine ideale symmetrische Potentialströmung allein nicht vorhersagt.
#form[$ F_W=c_W frac(rho c^2,2)A quad Re=frac(c L,nu) $]
A ist die in der jeweiligen Beiwertdefinition genannte Fläche. Für Kugeln meist die Stirnfläche πd²/4, bei Plattenreibbeiwerten häufig die benetzte Fläche. Form, Re, Rauheit und gegebenenfalls Ma müssen zum Diagramm passen. Bei unbekannter Geschwindigkeit hängen cW und Re oft von derselben gesuchten Größe ab und werden iterativ abgeglichen.
#bild("koerperkraefte", [Stationäres Fallgleichgewicht. Eigene Darstellung; BS, Widerstands- und Fallmodelle.], height: 63mm)
#form[$ (m-rho_F V)g=frac(rho_F,2)c_W A c_"End"^2 $]
Endgeschwindigkeit bedeutet Kräftegleichgewicht, keine gleichmäßige Beschleunigung. Der Auftrieb kann bei einer schweren Stahlkugel in Luft klein sein, in Wasser oder bei leichten Hohlkörpern ist er mitzuzählen. Im Kriechbereich einer Kugel gilt $c_W=24/Re$ und damit $F_W=3pi eta d c$ (Stokes), mit dynamischer Viskosität η; außerhalb dieses Bereichs das passende Diagramm verwenden.
Eine turbulente Grenzschicht hat meist höhere Wandschubspannung, kann aber einem Druckanstieg länger folgen und später ablösen. Der Druckwiderstand kann dadurch sinken. Deshalb führt „mehr Turbulenz“ bei einem stumpfen Körper nicht automatisch zu größerem Gesamtwiderstand; die kritische Re-Zahl und Oberflächenbedingungen sind entscheidend.
#src[Historische SM-Prüfungen Aufgaben zu Kugel, Fallschirm und Draht; BS, PDF-S. 212 und 220, Grenzschicht/Wirbelbildung, sowie PDF-S. 282–306, Körperwiderstand und freier Fall.]
#hoch(<a-9>, [Kapitelübersicht])

#pagebreak(weak: true)
=== 9.11.1 Längsangeströmte Platte <a-9-11-1>
Bei einem dünnen plattenförmigen Körper entsteht der Widerstand vor allem durch Schubspannung an der benetzten Oberfläche. Der *mittlere Plattenreibungsbeiwert* $c_F$ ist auf die gesamte benetzte Fläche bezogen; er ist nicht die Darcy-Rohrreibzahl λ und nicht ein auf Stirnfläche definierter Körperbeiwert.
#form[$ F_R=c_F rho c_"∞"^2 A_"benetzt"/2 quad Re_L=c_"∞" L/nu $]
#tab(columns: (1fr,1.8fr,1.2fr), th([Modell],[Mittlerer Beiwert],[Voraussetzung]),
[Laminar/glatt],[$c_F="1,328"/sqrt(Re_L)$],[Unabgelöste ebene Platte.],
[Turbulent/glatt],[$c_F="0,455"/(log_(10)(Re_L))^"2,58"$],[Von vorne turbulent; Gültigkeitsbereich der Quelle beachten.],
[Turbulent/sandrau],[$c_F=("1,89"+"1,62"log_(10)(L/k_s))^(-"2,5")$],[$10^2<L/k_s<10^6$; sandraue Ersatzrauheit.])
Ein vorgegebener laminar-turbulenter Umschlag muss berücksichtigt werden, wenn der laminare Anlauf einen wesentlichen Anteil der Platte einnimmt. Die von-vorne-turbulente Formel darf dann nicht ungeprüft über die gesamte Fläche benutzt werden. Bei sehr großer Rauheit kann der Rauheitswiderstand dagegen dominieren.
Für die laminare Grenzschicht liefern die Folienbuch-Modelle die Dicke $delta approx 5sqrt(nu x/c_"∞")$ und die *Verdrängungsdicke* $delta^* approx "1,73"sqrt(nu x/c_"∞")$. δ kennzeichnet den Rand des Geschwindigkeitsdefizits; δ∗ die gleichwertige Verringerung des verfügbaren Durchflussquerschnitts. Beide Dicken sind deshalb verschieden.
#heading(level: 3, outlined: false)[Turbulente Plattengrenzschicht und Tabellenabgleich]
Für die von vorne turbulent angenäherte glatte Platte nennt die mitgelieferte Tabelle zusätzlich $delta="0,37"x Re_x^(-"0,2")$ und $delta^*="0,01738"Re_x^"0,861"nu/c_"∞"$. Ein Rohr-Einlaufmodell kann die Verdrängungsdicke näherungsweise über $D_"wirksam"=D-2delta^*$ berücksichtigen; es bleibt eine Näherung vor dem Zusammenwachsen der Wandgrenzschichten.
#note("Auffällige Wandschubspannungszeile", [Der Exponent−2/3 in der Wandschubspannungszeile der alten Beilage und auch BS,Tabelle7.1 ist nicht mit deren zugleich angegebenem mittleren Reibbeiwert vereinbar: Bei Re≈7,6·10⁶ ergibt die Zeile einen lokalen Beiwert von etwa0,18; aus der Ableitung der gesamten Reibkraft folgt aus cF dagegen etwa0,0026. Die Aufgabe „Rohreinlauf“ verwendet deshalb die explizite Diagramm-/Musterlösungsangabe für die Glattgrenze. Die auffällige Formel wird nicht als geprüfte Rechenregel übernommen.], fill: sand)
#src[SM LN SS05, PDF-S.9–10; BS,Tabelle7.1,PDF-S.214. Konsistenztest durch lokale Ableitung der angegebenen mittleren Reibkraft.]
#src[BS,Tabelle7.1,PDF-S.214; historische SM-Prüfungen, Aufgaben zur längsangeströmten Platte.]
#hoch(<a-9>, [Kapitelübersicht])

=== 9.11.2 Newtonscher Schubspannungsansatz <a-9-11-2>
Bei parallelen Fluidschichten mit Geschwindigkeit c(y) ist die viskose Schubspannung im Newtonschen Modell proportional zum Geschwindigkeitsgradienten:
#form[$ tau=eta frac(dif c,dif y) quad nu=eta/rho $]
η ist die dynamische Viskosität inPa·s, ν die kinematische inm²/s. Der Quotient c/y darf nur bei einem dazu passenden linearen Profil anstelle der lokalen Ableitung benutzt werden. Die hier gezeigte Vorzeichenform benennt die Spannungskomponente; die Reibungskraft auf das jeweils betrachtete Gegenstück wirkt entgegengesetzt zur Relativbewegung.
Turbulente Strömung hat zusätzlich einen durch Geschwindigkeitsschwankungen übertragenen Impuls. Die molekulare Viskosität des Stoffes wird dadurch nicht plötzlich zu einer anderen Stoffkonstante. Ein empirischer Reibungsbeiwert beschreibt die gesamte resultierende Wandwirkung im jeweils definierten Modell.
#src[SM PF WS03/04, Kurzfrage14 und Musterlösung; BS, Viskosität und Grenzschicht; η/ν-Umrechnung aus der Definition.]
#hoch(<a-9>, [Kapitelübersicht])

#pagebreak(weak: true)

=== 9.11.3 Ablösung, Nachlauf und Widerstandsarten <a-9-11-3>
Ein ansteigender Außendruck in Strömungsrichtung bremst die wandnahe Bewegung. Wird der Wandgradient null und danach negativ, kann die Grenzschicht ablösen und zurückströmen. Ein Krümmer oder eine zurückspringende Stufe erzeugt deshalb mehr als die Reibung einer gleich langen geraden Strecke: Umlenkung, Sekundärströmung und Ablösung dissipieren zusätzliche mechanische Energie.
*Reibungswiderstand* entsteht aus tangentialen Wandschubspannungen, *Druck- oder Formwiderstand* aus der resultierenden Druckverteilung. Eine dünne längs angeströmte Platte ist vor allem ein Reibungsfall; eine quer angeströmte Platte ein Druckwiderstandsfall. Ein stumpfes Heck verhindert im großen Nachlauf eine gute Druckrückgewinnung und erhöht dadurch den Gesamtwiderstand.
Bei Kugel und Zylinder kann ein Grenzschichtumschlag die Ablösung nach hinten verschieben. Trotz höherer Wandreibung kann der Gesamtwiderstand stark sinken, weil der Druckwiderstand stärker abnimmt: die *Widerstandskrise*. Kritischer Bereich und Verlauf hängen unter anderem von Re und Rauheit ab.
#note("Lokale und gesamte Kraft", [τW ist eine örtliche Spannung. Die gesamte Reibungskraft ist ihre Integration über die benetzte Fläche. τW mal Gesamtfläche ist nur dann richtig, wenn τW als geeigneter Flächenmittelwert gemeint ist.])
#src[SM PF WS02/03, Kurzfragen12–15, PDF-S.2/4; SM PF SS02, Kurzfragen17–19, PDF-S.2/4; SM PF SS05, Kurzfrage14, PDF-S.2/4.]
#hoch(<a-9>, [Kapitelübersicht])

== 9.12 Ergänzung für Altklausuren · Wirbelablösung und Gleitflug <a-9-12>
Hinter quer angeströmten Körpern können sich periodisch Wirbel ablösen. Die dimensionslose Frequenz beschreibt die *Strouhal-Zahl* $"St"=f d/c$. Bei ähnlichen Strömungen erlaubt sie die Umrechnung von Modell- auf Originalfrequenz; einen konstanten St-Wert nur im passenden Re-/Geometriebereich annehmen.
#bild("gleitflug-kraefte", [Kräfte im stationären Gleitflug. Eigene Darstellung, nicht maßstäblich.], height: 62mm)
Für einen Tragflügel mit Bezugsfläche S gilt $F_A=c_A rho c^2S/2$ und $F_W=c_W rho c^2S/2$. Im stetigen Gleitflug ist $F_A=m g cos gamma$, $F_W=m g sin gamma$; damit:
#form[$ tan gamma=c_W/c_A quad c=sqrt(frac(2m g cos gamma,rho S c_A)) $]
Kleineres cW/cA bedeutet einen flacheren Gleitwinkel. Manche Quellen nennen den Kehrwert cA/cW „Gleitzahl“; hier ist die im Buch verwendete Verhältnisrichtung jeweils ausdrücklich zu nennen. Im Polardiagramm liefert eine Ursprungstangente das beste Gleiten, sofern die Achsen und ihr Maßstab korrekt gelesen werden.
*Kleinste Sinkgeschwindigkeit* ist ein anderes Ziel. Bei kleinem Winkel ist $c_"sink" approx c c_W/c_A$; nach Einsetzen von c minimiert man $c_W/c_A^(3/2)$ statt nur cW/cA. Ein Aufwind muss mindestens diese Sinkgeschwindigkeit ausgleichen. In einer idealen Potentialströmung kann der vertikale Geschwindigkeitsanteil des Modells einen solchen Aufwind beschreiben.
Die lineare Potentialnäherung für ein schlankes symmetrisches Profil ist $c_A approx 2 pi alpha$ (α in rad); sie gilt nicht über den Strömungsabriss hinaus. Reale Polaren aus der Aufgabe haben Vorrang. Endliche Spannweite erzeugt Randwirbel und zusätzlichen induzierten Widerstand; der zweidimensionale Vergleich allein beschreibt diesen Anteil nicht.
=== 9.12.1 Parabolische Polare: Widerstand und Leistung optimieren <a-9-12-1>
Für $c_W=c_(W,0)+K c_A^2$ mit positiven konstanten $c_(W,0)$ und K hat stationärer Horizontalflug die Beziehung $c_A=2m g/(rho S c^2)$. Daraus folgen zwei verschiedene Betriebspunkte:
#form[$ c_(A,"min.Widerstand")=sqrt(c_(W,0)/K) quad c_(A,"min.Leistung")=sqrt(3c_(W,0)/K) $]
#form[$ c_"min.Leistung"=(frac(4K,3c_(W,0)))^(1/4)sqrt(frac(m g,rho S)) $]
Minimale Leistung bedeutet minimalen Widerstand *mal* Geschwindigkeit. Die zugehörige Geschwindigkeit ist deshalb kleiner als die des minimalen Widerstands. Der angenommene Beiwert muss noch unter dem zulässigen Auftriebsmaximum liegen; Abreißen und andere Grenzen sind in der einfachen quadratischen Polare nicht enthalten.
#src[SM PF SS04, Aufgabe5.6, PDF-S.6 und MusterlösungPDF-S.11; Optima aus der vorgegebenen Polare und dem Kräftegleichgewicht hergeleitet.]
#note("Der Zusammenhang der Altklausur-Ergänzungen", [Ähnlichkeit überträgt dimensionslose Ergebnisse zwischen Modell und Original. Potential-/Stromfunktion liefert ein äußeres Geschwindigkeitsfeld, Bernoulli den zugehörigen Druck. Grenzschicht und Beiwerte ergänzen reale Kräfte; Kraftgleichgewicht und Polare bestimmen Fall-, Steig- oder Gleitbewegung.])
#src[BS, PDF-S. 220 und 323–330; historische SM-Prüfungen zu Kármán-Wirbelstraße, Körperwiderstand und Segelflug. Sinkgeschwindigkeitsziel aus Kraftgleichgewicht hergeleitet.]
#hoch(<a-9>, [Kapitelübersicht])

#pagebreak(weak: true)

=== 9.12.2 Endliche Tragflächen, Bezugssysteme und Moment <a-9-12-2>
Auftrieb und Widerstand beziehen sich auf die Anströmrichtung, Normalkraft und Tangentialkraft auf die Flügelsehne. Beide Zerlegungen beschreiben dieselbe resultierende Kraft; der Anstellwinkel dreht das Bezugssystem. Der Druckpunkt ist ihr momentfreier Angriffspunkt und muss kein fester geometrischer Punkt sein.
#form[$ M=c_m frac(rho c_"∞"^2,2)S l_"ref" $]
Das Moment verlangt einen benannten Bezugspunkt und eine Referenzlänge lref. Der häufig verwendete Viertelsehnenpunkt ist eine solche Konvention. Ein Wechsel des Bezugspunktes ergänzt das Hebelarmmoment der resultierenden Kraft.
Die Zirkulation liefert im ebenen idealen Modell den Auftrieb je Spannweite. Die Kutta-Bedingung am Hinterrand wählt die passende Zirkulation; beim realen Anfahren entsteht zugleich ein Anfahrwirbel. Bei einer endlichen Tragfläche fließt Luft um die Randbögen von der Druck- zur Saugseite: Nachlaufwirbel und Abwind kippen die aerodynamische Kraft und erzeugen *induzierten Widerstand*.
Eine elliptische Auftriebsverteilung bedeutet einen elliptischen Verlauf der Last je Spannweite. Im idealen Traglinienmodell hat sie bei vorgegebener Spannweite und Gesamtauftrieb den kleinsten induzierten Widerstand. Das ist eine Aussage über die Lastverteilung, nicht bloß über einen elliptisch gezeichneten Grundriss.
#src[SM PF SS02, Kurzfragen20–23, PDF-S.2/4; SM PF SS01, Kurzfragen19–21, PDF-S.2/4; SM PF SS04, Kurzfragen19–20, PDF-S.2/4.]
#hoch(<a-9>, [Kapitelübersicht])

== 9.13 Kompressibler Gasausfluss und kritischer Massenstrom <a-9-13>
Strömt Luft durch ein kleines Ventil aus einer ruhenden Umgebung in einen stark evakuierten Raum, ändert sich ihre Dichte erheblich. Die inkompressible Formel $c=sqrt(2Delta p/rho)$ ist dafür keine ausreichende Ausflussregel. Der Zustand vor dem Ventil wird mit Staudruck p₀ und Stautemperatur T₀ beschrieben; dahinter herrscht der Absolutdruck pₐᵦ.
#form[$ pi_p=frac(p_"ab",p_0) quad frac(T,T_0)=pi_p^((kappa-1)/kappa) quad c^2/2=c_p(T_0-T) $]
Die Temperaturbeziehung setzt ideales Gas, konstantes κ und isentrope Entspannung voraus. Aus $dot(m)=rho c A$, $rho=p/(R T)$ und $c_p=kappa R/(kappa-1)$ folgt für das unterkritische Druckgefälle:
#form[$ dot(m)=frac(A p_0,sqrt(R T_0))sqrt(frac(2kappa,kappa-1)[pi_p^(2/kappa)-pi_p^((kappa+1)/kappa)]) $]
A ist hier die effektive engste Durchlassfläche; reale Abweichungen müssen bereits in dieser effektiven Fläche bzw. in einem zusätzlichen ausdrücklich genannten Ausflussbeiwert berücksichtigt sein. R inJ/(kgK),p₀inPa,T₀inK,Ainm²liefernkg/s.
#bild("kompressibler-gasausfluss", [Normierter isentroper Luftmassenstrom. Eigene Herleitung nach dem idealen Gasmodell; Bezug SM PF SS05, Aufgabe1.6–1.7.], height: 65mm)
Die Ausflussfunktion besitzt ein Maximum bei
#form[$ pi_"krit"=(frac(2,kappa+1))^(kappa/(kappa-1)) quad dot(m)_"max"=frac(A p_0,sqrt(R T_0))sqrt(kappa)(frac(2,kappa+1))^((kappa+1)/(2(kappa-1))) $]
Für Luft mit κ=1,4 ist das kritische Druckverhältnis etwa0,5283. Sobald $p_"ab"/p_0$ diesen Wert unterschreitet, wird die Formel mit dem kritischen Zustand ausgewertet: Noch niedrigerer Nachdruck steigert den idealen Massenstrom nicht weiter. Im engsten Querschnitt ist dann die lokale Machzahl1 erreicht. Ein kleineres Druckverhältnis ist also ein größeres Druckgefälle, nicht ein kleinerer Antrieb.
Beim Aquarium gilt aus Hydrostatik $p_"ab"=p_"∞"-rho_W g h$, wenn h über dem äußeren Teichspiegel gemessen wird. Daher $h_"krit"=(1-pi_"krit")p_"∞"/(rho_W g)$. Die Lufttemperatur im sich füllenden Innenraum wird dadurch nicht automatisch festgelegt: Eine Masse am späteren Füllstand verlangt zusätzlich dessen Gaszustand oder eine instationäre Energiebilanz.
#note("Der Zusammenhang der Ergänzung", [Gasgleichung und Isentrope liefern Dichte und Temperatur, die Energiebilanz liefert Geschwindigkeit. Das Produkt ρcA besitzt eine kritische Grenze. Dieselbe Systemwahl trennt den kurzzeitig betrachteten Ventilausfluss vom instationär gefüllten Raum.])
#src[SM PF SS05, Aufgabe1.1–1.7, PDF-S.5 und MusterlösungPDF-S.9; ideale Isentropen5.4 und stationäre Energiebilanz3.1.1. Ausflussfunktion/Maximum eigene Herleitung aus diesen Beziehungen.]
#hoch(<a-9>, [Kapitelübersicht])


=== 9.13.1 Schallausbreitung, Laval-Düse und konstantes Rohr <a-9-13-1>
Die Strömungsgeschwindigkeit c beschreibt Fluidteilchen, die *Schallgeschwindigkeit* a die Ausbreitung kleiner Druckstörungen relativ zum Fluid. Kleine Störungen sind näherungsweise isentrop:
#form[$ a^2=(frac(partial p,partial rho))_s quad a_"ideales Gas"=sqrt(kappa R T) quad "Ma"=c/a $]
Bei Ma größer als1 liegen die Störungen des gleichförmig bewegten kleinen Körpers im Machkegel hinter ihm; dessen halber Öffnungswinkel erfüllt sinμ=1/"Ma". Reine Hörverzögerung eines entfernten Flugzeugs beweist keinen Überschall: Licht kommt auch bei Unterschall früher an als Schall.
Für eine stationäre eindimensionale isentrope Gasströmung folgt aus Kontinuität und Energiebilanz die Flächen-Geschwindigkeits-Beziehung:
#form[$ frac(dif A,A)=("Ma"^2-1)frac(dif c,c) $]
Untersonisch beschleunigt die Verengung und verzögert die Erweiterung; im Überschall ist es umgekehrt. Eine passend betriebene *Laval-Düse* verbindet einen konvergenten mit einem divergenten Teil und erreicht am engsten Querschnitt Ma1. Der Nachdruck bestimmt den tatsächlichen Betriebszustand; ein kleines Druckverhältnis allein garantiert keinen stoßfreien Überschall im gesamten divergenten Teil.
In einem Rohr konstanten Querschnitts braucht eine qualitative p-ρ-T-c-Skizze weitere Annahmen. Im stationären adiabaten reibungsbehafteten Unterschallmodell (*Fanno-Strömung*) steigen c und Ma, während p,ρ,T sinken. Im inkompressiblen Modell bleiben bei festem Q und A die mittlere Geschwindigkeit und Dichte konstant; p fällt durch Reibung. Eine eindeutige Temperaturkurve folgt dort erst aus der thermischen Bilanz.
#note("Heizen im reibungsfreien Rohr", [Das Fragearchiv Q172, Thermodynamikfrage20, nennt bei konstantem Rohrquerschnitt und Erwärmung pauschal p=konstant. Das ist für einen beschleunigten kompressiblen Strom nicht allgemein richtig: Kontinuität liefert ρc=konstant und die reibungsfreie Impulsbilanz p+ρc²=konstant. Damit ändern sich p und c gekoppelt. Konstanter Druck wäre eine zusätzliche Näherung, etwa bei vernachlässigter Impulsänderung.], fill: sand)
#src[SM PF SS06, Kurzfragen19–21, PDF-S.2/4; SM PF SS00, Kurzfragen13–16, PDF-S.2/4; SM PF WS05/06, Kurzfrage21, PDF-S.2/4; Kurzfragenarchiv Q172, PDF-S.2, TD20. Flächenbeziehung und Heizrohr-Kontrolle eigene Herleitung aus Kontinuität, Impuls und Energie.]
#hoch(<a-9>, [Kapitelübersicht])

#note("Der Zusammenhang in Kapitel 9", [Hydrostatik liefert ruhende Drücke und Auftrieb. Kontinuität verbindet Querschnitt und Geschwindigkeit, Bernoulli bilanziert mechanische Energie. Rohrwiderstände beschreiben deren Entwertung, Impuls und Drall liefern Kräfte und Momente. Potentialfeld und Grenzschicht verbinden Außenströmung und Wandwirkung; Ähnlichkeit und Machzahl prüfen, ob das gewählte Modell zum konkreten Fall passt.])

#pagebreak(weak: true)
= Anhang

== Formelsammlung mit Voraussetzungen
Die Gleichungen sind mit der Zufuhrkonvention formuliert. $W$ und $P_t$ sind positiv bei Zufuhr zum System. In den Gasgleichungen ist $p$ der Absolutdruck, $T$ die Kelvin-Temperatur.

=== Formeln zu Kapitel 1 · Grundbegriffe
#tab(columns: (1.15fr, 1.8fr, 1.7fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Massenbilanz], [$dif m_"Sys"/dif t=sum dot(m)_"ein"-sum dot(m)_"aus"$], [Keine Erzeugung der Gesamtmasse. Stationär: linke Seite null.],
 [Energie, geschlossen], [$Delta U=Q_12+W_12$], [Keine wesentliche Änderung der äußeren Energien. Gesamte Arbeit zählen.],
 [Enthalpie], [$H=U+p V$, $h=u+p v$], [$"J"$ beziehungsweise $"J/kg"$.],
 [Enthalpiestrom], [$dot(H)=dot(m)h$], [$"kg/s" times "kJ/kg"="kW"$.],
 [Stationärer Strom], [$dot(Q)+P_t=dot(m)(h_2-h_1)$], [Ein Ein-/Austritt; äußere Energieänderungen vernachlässigt.],
 [Wirkungsgrad], [$eta=P_"Nutz"/P_"Aufwand"$], [Passende Nutzen- und Aufwandsdefinition.],
 [Wärmeausdehnung], [$Delta L=alpha_L L_0 Delta T$; $Delta V=alpha_V V_0 Delta T$], [Kleine Änderungen; passende, annähernd konstante Koeffizienten in 1/K.],
 [Brennstoff], [$dot(m)_B=dot(Q)_B/H_u$], [Heizwert und Leistung in passenden Einheiten.],
 [Stoffmenge], [$m=n M$], [$n$ in kmol, $M$ in kg/kmol.],
 [Spezifisches Volumen], [$v=V/m=1/rho$], [$"m"^3/"kg"$.],
 [Kontinuität], [$dot(m)=rho A c$], [Passender mittlerer Querschnittswert.],
 [Stationär, Dichte konstant], [$A_1 c_1=A_2 c_2$], [Nicht ohne Dichteprüfung auf Gase übertragen.],
 [Ideales Gas], [$p v=R T$, $p V=m R T$], [Geeigneter Gaszustand; konsistente Einheiten.],
 [Isochor, ideales Gas], [$p_2/p_1=T_2/T_1$], [Geschlossen, gleiches Volumen und gleiche Gaszusammensetzung.],
 [Absolutdruck], [$p_"abs"=p_e+p_"amb"$], [Überdruck kann negativ sein.],
 [Hydrostatik], [$p=p_0+rho g h$], [Ruhende Flüssigkeit, konstante Dichte, Tiefe nach unten.],
 [U-Rohr, einfacher Fall], [$abs(Delta p)=rho_M g Delta h$], [Gasdichte vernachlässigt.],
 [Temperatur], [$T/"K"=theta/"°C"+"273,15"$], [Zahlenwertgleichung; Differenzen haben dieselbe Schrittweite.],
 [Volumenarbeit], [$W_v=-integral p dif V$], [Systemdruck bei quasistatischer Grenzbewegung.],
 [Isobare Volumenarbeit], [$W_v=-p(V_2-V_1)$], [Zusätzlich konstanter Druck.],
 [Isotherm, ideales Gas], [$W_v=m R T ln(V_1/V_2)$], [Geschlossene Masse, quasistatische Volumenarbeit.],
 [Reversible technische Arbeit], [$w_t=integral v dif p$], [Reversibel; Änderungen von Bewegungs- und Lageenergie vernachlässigt.],
 [Bestand aus Strömen], [$m=m_0+integral_0^t dot(m)_"netto" dif tau$], [Anfangsbedingung und gültiger Zeitbereich erforderlich.],
 [Zeitmittelwert], [$overline(y)=integral_(t_1)^(t_2)y(t)dif t/(t_2-t_1)$], [Diskret: Zeitabschnitte gewichten.],
 [Heizrampe], [$P_"el" approx m c "d"theta/"d"t$], [Geschlossen, adiabat; konstantes $m,c$; weitere Speicher vernachlässigt.],
 [Bernoulli, ergänzend], [$p/rho+c^2/2+g z="konstant"$], [Entlang Stromlinie, stationär, inkompressibel, reibungsfrei; keine Maschinenarbeit.],
 [Torricelli, ergänzend], [$c_0=sqrt(2 g h)$], [Großer offener Behälter, kleine Öffnung, Verluste vernachlässigt.],
)

=== Formeln zu Kapitel 2 · Stoffeigenschaften
#tab(columns: (1.15fr, 1.8fr, 1.7fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Lineare Interpolation], [$y=y_1+f(y_2-y_1)$; $f=(a-a_1)/(a_2-a_1)$], [Zwischen nahen Tabellenpunkten desselben Zustandsgebiets.],
 [Mittlere Wärmekapazität ab 0 °C], [$Delta h=(C_2 vartheta_2-C_1 vartheta_1)(1 thin "K")$], [$vartheta_i$ sind Celsius-Zahlenwerte; $C_i$ auf 0 °C bezogene Mittelwerte.],
 [Realgasfaktor], [$Z=p v/(R T)$], [Zustandsabhängig; ideal $Z=1$.],
 [Sensible Erwärmung], [$Q approx m c_p Delta T$], [Isobares Modell, nur Volumenarbeit, $c_p$ näherungsweise konstant.],
 [Verdampfungsenthalpie], [$r=h''-h'$], [Beide Werte bei derselben Sättigung.],
 [Dampfgehalt], [$x=m''/m$], [Flüssig-Dampf-Gemisch; Massenanteil.],
 [Mischungsregel], [$y=y'+x(y''-y')$], [Für $y=v,h,u,s$ bei gleichem Sättigungszustand.],
 [Dampfgehalt aus Stoffwert], [$x=(y-y')/(y''-y')$], [Nur im Zweiphasenmodell.],
 [Innere Energie], [$u=h-p v$], [Pa·m³/kg ergibt J/kg; kPa·m³/kg ergibt kJ/kg.],
 [Mittlere Wärmekapazität], [$Delta h=overline(c)_(p,12) Delta T$], [Intervall und Tabellenbezug beachten; isobare Stoffwertänderung.],
 [Reales Gas, isochor], [$p_2/p_1=Z_2 T_2/(Z_1 T_1)$], [Gleiche Masse und gleiches Volumen; $Z$ passend zum Zustand.],
 [Dampfvolumenanteil], [$mu=x v''/v$], [Nicht mit dem Massenanteil $x$ verwechseln.],
 [Clapeyron], [$dif p_s/dif T=Delta h/(T Delta v)$], [Entlang der Phasengrenze; Differenzen zwischen den Phasen.],
 [Gemisch: Anteile], [$xi_i=m_i/m_g$; $psi_i=n_i/n_g$; $sum xi_i=sum psi_i=1$], [$xi$ Massenanteil, $psi$ Molanteil; Bezugsgröße immer nennen.],
 [Gemisch: Umrechnung], [$xi_i=psi_i M_i/M_g$; $M_g=sum psi_i M_i$], [$M$ in kg/kmol.],
 [Gemisch: Partialgrößen], [$p_i=psi_i p_g$; $V_i=psi_i V_g$], [Ideale Gase bei gleichem $T$; Partialdruck bei $V_g$, Partialvolumen bei $p_g$.],
 [Gemisch idealer Gase], [$R_g=sum xi_i R_i$; $1/M_g=sum xi_i/M_i$; $p V=m_g R_g T$], [Ideale Gase, keine Reaktion; Luft: $M="28,964" thin "kg/kmol"$, $R approx 287 thin "J/(kg K)"$.],
 [Van der Waals], [$(p+a/v^2)(v-b)=R T$], [Reales Fluid; $a,b$ stoffabhängig aus Tabellen.],
 [Rückwärtige Interpolation], [$vartheta=vartheta_1+frac(v-v_1,v_2-v_1)(vartheta_2-vartheta_1)$], [Gleicher Druck, gleiches Zustandsgebiet; lineare Näherung.],
 [Extensive Phasengröße], [$Y=m'y'+m''y''$], [$Y=V,H,U,S$; $y=v,h,u,s$. Beide Phasen bei gleicher Sättigung.],
 [Entropiestrom], [$dot(S)=dot(m)s$], [kg/s mal kJ/(kg K) ergibt kW/K.],
 [Isobare Flüssigkeitsentnahme], [$Delta m''=frac(v' m_"entn",v''-v')$], [Starrer Behälter, Sättigung, p konstant; Entnahme flüssig.],
 [Drei Phasen, extensiv], [$Y=sum_i m_i y_i$], [$Y=V,H,U,S$; alle Phasen einbeziehen, Werte mit demselben Bezug.],
 [Rohrdurchmesser], [$d=sqrt(4 dot(m)v/(pi c))$], [Stationärer Kreisquerschnitt; $v$ aus passendem Stoffmodell; Ergebnis m bei SI-Einheiten.],
 [Starre geschlossene Erwärmung], [$Q=m[(h_2-h_1)-v(p_2-p_1)]$], [Keine weitere Arbeit, äußere Energien unverändert; konstantes $m,V,v$.],
 [Kritische vdW-Anpassung], [$v_"kr"=3b; a=3p_"kr"v_"kr"^2; R_"fit"=8p_"kr"v_"kr"/(3T_"kr")$], [Rfit ist Modellparameter; Zkrit=3/8, physikalisches R=Rm/M getrennt.],
 [Berthelot], [$p=R T/(v-b)-a/(T v^2)$], [Einphasige passende Modellwurzel; a,b mit korrekter Massen-/Molbasis.],
 [Stoffkoeffizienten], [$beta_v=(partial p/partial T)_v/p; chi_T=-1/(v(partial p/partial v)_T)$], [βv in1/K, χT in1/Pa; lokale Ableitungen.],
 [Koch-Vergleich], [$v=R T/p-A/theta^"2,82"-p^2(B/theta^14+C/theta^"31,6")$], [θ=T/(100K); ausschließlich die Parameter/Einheiten aus2.12.5.],

)

=== Formeln zu Kapitel 3 · Energiebilanzen: Erster Hauptsatz
#tab(columns: (1.15fr, 1.8fr, 1.7fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [1. HS offen, stationär], [$h_2-h_1+(c_2^2-c_1^2)/2+g(z_2-z_1)=q_12+w_(t,12)$], [Ein Ein-/Austritt, $dot(m)_1=dot(m)_2$. Alle Terme in J/kg oder einheitlich in kJ/kg.],
 [1. HS offen, extensiv], [$dot(H)_2-dot(H)_1+dot(m)[(c_2^2-c_1^2)/2+g Delta z]=dot(Q)_12+P_12$], [W bei J/kg, kW bei kJ/kg; $P=dot(m)w_t$, $dot(Q)=dot(m)q$.],
 [Technische Arbeit], [$w_t=j_12+integral v dif p+(c_2^2-c_1^2)/2+g(z_2-z_1)$], [$j_12$ Dissipation; $w_p=integral v dif p$ Druckarbeit (offen).],
 [1. HS geschlossen], [$u_2-u_1+(c_2^2-c_1^2)/2+g(z_2-z_1)=q_12+w_(g,12)$], [Konstante Masse; einheitlich J/kg oder kJ/kg. Extensiv alle Terme mit $m$ multiplizieren.],
 [Gesamtarbeit], [$w_g=j_12-integral p dif v+(c_2^2-c_1^2)/2+g(z_2-z_1)$], [Minus bei der Volumenarbeit: Kompression zählt positiv.],
 [Ruhend, reibfrei, adiabat], [$m(u_2-u_1)=W_(v 12)$], [$c_1=c_2=0$, $dif z=0$, $J_12=0$, $Q_12=0$.],
 [Abgeschlossenes System], [$Delta E_"sys"=0$; ruhend: $u_2-u_1=0$], [Kein Stoff-, Wärme- oder Arbeitsaustausch. Für $Delta u=0$ zusätzlich äußere Energien unverändert.],
 [Äußere Energie: Einheiten], [$Delta e_"kin"=(c_2^2-c_1^2)/2$; $Delta e_"pot"=g Delta z$], [Mit m/s und m zunächst J/kg; Zahlenwerte durch 1000 für kJ/kg.],
 [Instationär, starr, Ausfluss], [$Delta U=E_"zu"-m_"entn" h_"aus"$], [Kein Zufluss; konstantes $h_"aus"$; äußere Energien vernachlässigt.],
 [Dampfaustritt, starrer Sättigungstopf], [$m_"aus"=(1/v''-1/v')Delta V'$], [p konstant, beide Phasen vorhanden; $Delta V'<0$; daher $m_"aus">0$.],
 [Dampftopf, Energiebilanz], [$Q=Delta U+m_"aus" dot (h''+c^2/2)$], [Keine weitere Arbeit, Lage-/äußere Speicherenergien vernachlässigt; alle Energieterme einheitlich.],
 [Stickstoff: Heizerenergie], [$E_"zu"=Delta m''(h''-h')$], [Zusätzlich isobare gesättigte Flüssigkeitsentnahme wie in Ü 2.1.],
 [Nutzbare Volumenarbeit], [$W_(v,n)=W_v+p_"∞"(V_2-V_1)$], [Konstanter Umgebungsdruck; $W_v$ mit Absolutdruck. Expansion: abgegebene Nutzarbeit negativ.],
 [Arbeitsformen, gleicher Weg], [$w_p=w_v+p_2 v_2-p_1 v_1$], [Gleicher Zustandsweg und gleiche Massenbasis; $w_t=w_p$ nur bei $j=0$, ohne äußere Energieänderung.],
 [Flüssigkeitspumpe, ideal], [$w_t approx v(p_2-p_1)$], [Konstantes $v$, reversibel, Änderungen äußerer Energien vernachlässigt; Pa·m³/kg = J/kg.],
 [Arbeit und Leistung], [$W=m w$; $P=dot(m) w_t$], [Erste Formel konstante Masse; zweite stationärer Stoffstrom. Energie und Leistung trennen.],
 [Ideales Gas, kalorisch], [$Delta u=c_v Delta T$; $Delta h=c_p Delta T$], [Konstante Wärmekapazitäten im betrachteten Bereich; $c_p-c_v=R$, $kappa=c_p/c_v$.],
 [Reversible Adiabate, ideales Gas], [$p V^kappa="konstant"$; $T_2/T_1=(p_2/p_1)^((kappa-1)/kappa)$], [Geschlossene Gasportion, $Q=0$, keine Dissipation, konstantes $kappa$.],
 [Adiabate Expansionsarbeit], [$W_v=(p_2 V_2-p_1 V_1)/(kappa-1)$], [Dieselben Voraussetzungen; $W_v<0$ bei Expansion.],
 [Gaswechselmotor], [$W_"Zyklus"=-p_1 V_1+W_v+p_2 V_2$; $P=f W_"Zyklus"$], [Kein Totvolumen; Füllung/Ausschiebung bei konstanten Drücken; $f$ Arbeitsspiele pro Sekunde.],
 [Gefälleleistung und Turbine], [$P_"Gefälle"=rho dot(V)g H$; $eta=abs(P_t)/P_"Gefälle"$], [Gleicher Umgebungsdruck, äußere Geschwindigkeitsänderung vernachlässigt; Nutzleistung eindeutig definieren.],
 [Kessel und Dampfturbine], [$q_12=h_2-h_1$; $w_(t,23)=h_3-h_2$], [Stationär; Kessel ohne technische Arbeit, Turbine adiabat; äußere Energien vernachlässigt.],
 [Wärmekapazitäten, Mengenbezug], [$C_p=m c_p=n C_(m,p)$; $C_(m,p)=M c_p$], [kJ/K, kJ/(kg K), kJ/(kmol K); entsprechend Index v.],
 [Bereichsmittel], [$overline(c)_(p,12)=integral_(T_1)^(T_2)c_p(T)dif T/(T_2-T_1)$], [Passender Bereich; liefert $Delta h=overline(c)_(p,12) Delta T$.],
 [Kreisprozess], [$Q_"zu"+Q_"ab"+W_"netto"=0$], [Zustandsänderungen im gesamten Umlauf null; Vorzeichenbeiträge, $Q_"ab"<0$.],
 [Thermischer Wirkungsgrad], [$eta_"th"=1-abs(Q_"ab")/Q_"zu"$], [Wärmekraftmaschine mit den bilanzierten Wärmezufuhr-/Abfuhrbeiträgen.],
 [Düse], [$c_2=sqrt(c_1^2+2(h_1-h_2))$], [Adiabat, keine technische Arbeit, gleiche Höhe; $h$ in J/kg.],
 [Drossel], [$h_2 approx h_1$], [Adiabat, keine technische Arbeit, äußere Energieänderungen vernachlässigt; irreversibel.],
)

=== Formeln zu Kapitel 4 · Zweiter Hauptsatz und Zustandsdiagramme
#tab(columns: (1.15fr, 1.8fr, 1.7fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Entropie, geschlossen], [$dif S=delta Q/T_b+dif S_"erz"$], [$dif S_"erz">=0$; Grenztemperatur $T_b$ in K. Adiabat geschlossen: $Delta S>=0$.],
 [Entropie, stationärer Strom], [$dot(m)Delta s=sum_i dot(Q)_i/T_(b,i)+dot(S)_"erz"$], [Ein Ein-/Austritt; alle Wärmekontakte zählen; W/K oder kW/K.],
 [Gibbs], [$T dif s=dif u+p dif v=dif h-v dif p$], [Einfacher kompressibler Stoff, feste Zusammensetzung; Gleichgewichtszustände.],
 [Entropie, ideales Gas], [$Delta s=c_p ln(T_2/T_1)-R ln(p_2/p_1)$], [Konstante Wärmekapazität; Kelvin und Absolutdruck.],
 [Entropie, ideales Gas, alternativ], [$Delta s=c_v ln(T_2/T_1)+R ln(v_2/v_1)$], [Dieselben Modellbedingungen; äquivalent über Gasgleichung.],
 [Entropie, inkompressibel], [$Delta S=m c ln(T_2/T_1)$], [Konstantes $m,c$; T in K.],
 [Entropie, Phasenwechsel], [$s''-s'=(h''-h')/T_s$], [Sättigungsgleichgewicht desselben Druck-/Temperaturpunkts.],
 [Turbinen-Gütegrad], [$eta_("is,T")=(h_1-h_2)/(h_1-h_(2s))$], [Adiabat, gleiche Einlassdaten und gleicher Enddruck; $s_(2s)=s_1$.],
 [T-s-Fläche], [$q_"rev"=integral T dif s$], [Reversibler Weg; bei Irreversibilität keine ungeprüfte Wärmedeutung.],
 [T-s-Prozessfläche], [$integral T dif s=q+j$], [Lokales Folienmodell mit passender Wärme-/Dissipationsaufteilung; T in K.],
 [T-s-Zustandsfläche], [$integral T dif s=Delta u$ bei $dif v=0$; $=Delta h$ bei $dif p=0$], [Gibbs, Gleichgewichtsweg auf Isochore bzw. Isobare.],
 [Carnot], [$eta_C=1-T_K/T_H$], [Reversibler Kreisprozess zwischen zwei konstanten Kelvin-Temperaturen.],
 [Leistungszahlen], [$epsilon_"K"=q_"kalt"/w_"zu"$; $epsilon_"WP"=epsilon_"K"+1$], [Stationärer Kreisprozess, gleiche Systemgrenze und vollständige Bilanz.],
 [Wärmeexergie], [$E_Q=integral(1-T_"∞"/T_b)delta Q$], [Bei konstantem $T_b$: $(1-T_"∞"/T_b)Q$. Kelvin; Umgebung konstant.],
 [Stromexergie], [$e=(h-h_"∞")-T_"∞"(s-s_"∞")$], [Stationärer Strom, äußere Energien hier vernachlässigt; $dot(E)=dot(m)e$.],
 [Geschlossene Exergie], [$e=(u-u_"∞")+p_"∞"(v-v_"∞")-T_"∞"(s-s_"∞")$], [Feste Masse; keine äußere Energieänderung; $E=m e$.],
 [Äußere Exergie], [$Delta e_"aussen"=(c^2-c_"∞"^2)/2+g(z-z_"∞")$], [Zu beiden Zustandsformeln addieren; SI ergibt J/kg.],
 [Maximale Nutzabgabe], [$W_"Nutz,rev"=-E$; $P_"rev"=-dot(E)$], [Reversibel zum festgelegten Umgebungszustand; Zufuhrkonvention.],
 [Zwei Stromzustände, reversibel], [$w_t=Delta h-T_"∞" Delta s$], [Wärme nur bei Umgebungstemperatur; äußere Energieänderungen null.],
 [Exergieverlust], [$E_"V"=T_"∞" S_"erz"$], [Positiver Verlustbetrag; stationär $dot(E)_"V"=T_"∞"dot(S)_"erz"$.],
 [Endlicher thermischer Speicher], [$E=m c[Delta T-T_"∞"ln(T_1/T_"∞")]$], [Konstantes $c$, inkompressibel, keine Phasen-/äußere Energieänderung, gleicher Druck; $Delta T=T_1-T_"∞"$.],
 [Fester Stoff], [$u_2-u_1=c Delta T$], [Inkompressibel; $c$ in J/(kg K).],
)


=== Formeln zu Kapitel 5 · Ideales Gas
#tab(columns: (1.15fr,1.8fr,1.7fr), th([Thema],[Formel],[Voraussetzung / Einheit]),
 [Gasgleichung], [$p V=m R T=n R_m T$], [Ideales Gas; p absolut, T Kelvin.],
 [Normvolumen], [$V_n=V(p/p_n)(T_n/T)$], [Gleiche Stoffmenge; Referenz ausdrücklich nennen.],
 [Polytrope], [$p v^n="konstant"$], [Gleichgewichtszustände; n ist Prozessparameter.],
 [Polytrope, Arbeit], [$w_v=(p_2v_2-p_1v_1)/(n-1); w_p=n w_v$], [n≠1, quasistatisch bzw. Druckintegral; reale Arbeit zusätzlich j.],
 [Isotherme Arbeit], [$w_v=R T ln(v_1/v_2); w_p=R T ln(p_2/p_1)$], [Konstantes T; offene und geschlossene Arbeitsform trennen.],
 [Tankentleerung], [$T/T_0=(m/m_0)^(kappa-1); p/p_0=(m/m_0)^kappa$], [Starr, homogen, adiabat; ideales Gas, konstante Wärmekapazitäten.],
)

=== Formeln zu Kapitel 6 · Thermische Maschinen
#tab(columns: (1.15fr,1.8fr,1.7fr), th([Thema],[Formel],[Voraussetzung / Einheit]),
 [Otto], [$eta=1-epsilon^(1-kappa)$], [Idealer Luftvergleich; epsilon=V_max/V_min.],
 [Seiliger], [$eta=1-(psi phi^kappa-1)/(epsilon^(kappa-1)(psi-1+kappa psi(phi-1)))$], [Ideale Isentropen, konstantes κ; ψ Druck-, φ Volumensteigerung.],
 [Diesel], [$eta=1-(phi^kappa-1)/(epsilon^(kappa-1)kappa(phi-1))$], [Isobare Wärmezufuhr; phi Abschneideverhältnis.],
 [Joule], [$eta=1-(p_1/p_2)^((kappa-1)/kappa)$], [Ideal reversibel; gleicher Druckhub beider Maschinen.],
 [Joule-Gaskälte], [$epsilon_K=1/(r^((kappa-1)/kappa)-1)$], [Ideale Isentropen, r=pH/pK; kalte Wärmeaufnahme muss möglich sein.],
 [Absorptionskälte], [$zeta=dot(Q)_0/(dot(Q)_G+P_P)$], [Positive Nutz-/Aufwandsbeträge; Wärme- und Arbeitsantrieb zählen.],
 [Wirkungsgradkette], [$eta_"eff"=eta_"th" eta_G eta_"mech"$], [Gleiche Energie-/Brennstoffbasis.],
 [Verdichtergüte], [$eta_("is,V")=(h_(2s)-h_1)/(h_2-h_1)$], [Adiabat, gleiche Enddruckbedingung.],
 [Spiele pro Zeit], [$f=N/120$], [Viertakt je Zylinder, N in min⁻¹; Zweitakt N/60.],
 [Regenerativer Stirling], [$abs(W)=m R(T_H-T_K)ln(V_max/V_min)$], [Ideales Gas, zwei Isothermen; idealer Regenerator für Carnot-Wirkungsgrad.],
 [GuD ohne Zusatzfeuerung], [$eta_"GuD"=eta_G+eta_D eta_K(1-eta_G)$], [Abwärme vollständig bilanziert; Dampf-Nettoanteil und Übertragungsgrad passend definiert.],
 [Wärmediffusion], [$partial T/partial tau=a nabla^2 T; a=lambda/(rho c)$], [Homogen/isotrop, konstante Stoffwerte, keine Quelle/Strömung.],
 [Reaktionsarbeit], [$Delta G_m=Delta H_m-T Delta S_m$], [Isotherm/isobar, dieselbe stöchiometrische Basis.],
 [Zellspannung], [$U_"rev"=-Delta G_m/(z F); abs(P_"el")=U I$], [ΔG J/mol, F C/mol, z Elektronen je Reaktion.],
 [Zellstrom und Wärme], [$I=z F dot(xi); dot(Q)_"ab"=(U_H-U)I$], [UH=−ΔHm/(zF), gleicher Reaktions-/Wasserbezug.],
 [Ebene Leitung], [$dot(Q)=lambda A (T_1-T_2)/L$], [Stationär, eindimensional, konstantes λ/A, keine Quelle.],
)

=== Formeln zu Kapitel 7 · Feuchte Luft
#tab(columns: (1.15fr,1.8fr,1.7fr), th([Thema],[Formel],[Voraussetzung / Einheit]),
 [Mischungsentropie], [$Delta S_"Misch"=-n R_m sum_i psi_i ln(psi_i)$], [Vorher getrennte reine ideale Gase, gemeinsames T/p, keine Reaktion.],
 [Nebelenthalpie], [$h=h_s+(x-x_s)c_W vartheta$], [Flüssigkeitsnebel; Gesamtwasser x, gesättigte Gasphase x_s; Bezug0°C.],
 [Feuchtegrad], [$Psi=x/x_s; xi_W=x/(1+x)$], [Ψ und φ unterscheiden; Massenanteil auf Gesamtgemisch.],
 [Befeuchten], [$h_2-h_1=(x_2-x_1)h_W+q$], [Je kg trockene Luft, alles eingesprühte Wasser bleibt im betrachteten Austritt.],
 [Gasgemisch], [$M=1/(sum xi_i/M_i); R=R_m/M$], [Massenanteile ξ; ideale Mischung.],
 [Umrechnung], [$xi_i=psi_i M_i/(sum psi_j M_j)$], [Molanteil ψ und Massenanteil ξ.],
 [Feuchte], [$x=m_W/m_L; phi=p_W/p_s$], [kg Wasser je kg trockene Luft; Gasphase bis Sättigung.],
 [Partialdruck], [$x=(R_L/R_W)phi p_s/(p-phi p_s)$], [Ideales Gas-Dampf-Gemisch.],
 [Enthalpie], [$h=c_(p,L) vartheta+x(r_0+c_(p,W)vartheta)$], [0-°C-Bezug; kJ/kg trockene Luft; passende Konstanten.],
 [Mischen], [$h_M=(sum dot(m)_(L,i)h_i)/(sum dot(m)_(L,i))$], [Ebenso x; stationär, adiabat, gleiche Bezugsmasse.],
 [Raumlast], [$dot(m)_L(h_"IDA"-h_"SUP")=sum dot(Q)+sum P+sum dot(m)_W h_W$], [Stationär, gleicher Trockenluftstrom; Lastdefinition ohne Doppelzählung.],
 [Kondensat], [$dot(m)_K=dot(m)_L(x_1-x_2)$], [Feuchteabnahme; Wasserenthalpie in Kühlbilanz beachten.],
)

=== Formeln zu Kapitel 8 · Verbrennung
#tab(columns: (1.15fr,1.8fr,1.7fr), th([Thema],[Formel],[Voraussetzung / Einheit]),
 [Luftverhältnis], [$lambda=L/L_min; L_min=O_min/psi_("O2",L)$], [Gleicher molarer Brennstoffbezug.],
 [Elementaranalyse], [$n_("O2,min")=c/12+h/4+s/32-o/32$], [kmol O₂ je kg Brennstoff; gerundete Molmassen.],
 [Heiz-/Brennwert], [$H_o-H_u=m_("W,Produkt")r_0$], [Wassermasse auf denselben Brennstoffbezug normiert.],
 [Empirischer Heizwert], [$H_u="33,9"c+"121,4"h+"10,5"s-"15,2"o-"2,44"w$], [MT-Näherung, MJ/kg; Massenanteile als Brüche.],
 [Brennstoffleistung], [$dot(Q)_B=dot(m)_B H_u$], [Heizwert-/Brennwertbasis ausdrücklich angeben.],
)

=== Formeln zu Kapitel 9 · Strömungsmechanik
#tab(columns: (1.15fr,1.8fr,1.7fr), th([Thema],[Formel],[Voraussetzung / Einheit]),
 [Hydrostatik], [$dif p/dif z=-rho g$], [Höhe nach oben, ruhendes Fluid.],
 [Seitenwand], [$F=rho g A h_S; h_D=h_S+I_S/(A h_S)$], [Vertikale ebene Fläche, freie Oberfläche ohne Überdruck.],
 [Auftrieb], [$F_A=g integral_V rho(z)dif V$], [Konstant rho: rho g V; verdrängtes Fluidvolumen.],
 [Atmosphäre, isotherm], [$p=p_0 exp[-g(z-z_0)/(R T)]$], [Hydrostatisch, ideale Luft, konstantes g und T.],
 [Torricelli], [$c=sqrt(2g Delta z)$], [Großer offener Behälter, freier tieferer Austritt, verlustfrei/quasistationär.],
 [Laminarer Durchsatz], [$Delta p_V=128 eta L dot(V)/(pi d^4)$], [Voll entwickeltes laminares Kreisrohr, η dynamische Viskosität.],
 [Rohrreibung], [$Re=c d_h/nu; Delta p_V=lambda(L/d_h)rho c^2/2$], [Darcy-Reibzahl; laminares Kreisrohr lambda=64/Re.],
 [Einzelverlust], [$Delta p_V=zeta rho c^2/2$], [Jeweils angegebene Bezugsgeschwindigkeit.],
 [Quadratische Parallele], [$1/sqrt(R_"ers")=sum_i 1/sqrt(R_i)$], [Gleiche Enddrücke; Delta p=R dot(V)^2.],
 [Pumpenaufnahme], [$P_"el"=dot(m)Y/eta_"ges"$], [Y spezifische mechanische Energiezunahme.],
 [Impuls], [$sum vec(F)=sum_"aus" dot(m)vec(c)-sum_"ein" dot(m)vec(c)$], [Stationär; Druck-, Gewicht- und Wandkräfte zählen.],
 [Drall], [$M=dot(m)(r_2c_(u,2)-r_1c_(u,1)); P=M omega$], [Stationär, feste Achse; c_u absoluter Tangentialanteil.],
 [Modellähnlichkeit], [$Re=c L/nu; "Fr"=c/sqrt(g L); "Ma"=c/a; "St"=f L/c$], [Passende Geometrie, Stoffwerte und dominante Effekte.],
 [Potential], [$u=partial Phi/partial x; v=partial Phi/partial y$], [Inkompressibel/drehungsfrei: Delta Phi=0, Singularitäten ausschließen.],
 [Stromfunktion], [$u=partial Psi/partial y; v=-partial Psi/partial x$], [Eben, gleiche Vorzeichenkonvention; Vdot=b abs(Delta Psi).],
 [Körperkräfte], [$F_W=c_W rho c^2 A/2; F_A=c_A rho c^2 S/2$], [Flächen-/Beiwertdefinition aus Diagramm.],
 [Plattenreibung], [$F_R=c_F rho c_"∞"^2 A_"benetzt"/2$], [cF auf benetzte Fläche, nicht Darcy-λ; korrekte Grenzschicht-/Rauheitsformel aus9.11.1.],
 [Laminare Grenzschicht], [$delta approx 5sqrt(nu x/c_"∞"); delta^* approx "1,73"sqrt(nu x/c_"∞")$], [Ebene Platte, ohne Druckgradient, stationär/inkompressibel und unabgelöst.],
 [Fallende Kugel], [$F_W=3pi eta d c$], [Stokes, Kriechströmung; eta dynamische Viskosität.],
 [Gleitflug], [$tan gamma=c_W/c_A$], [Stationäres Kräftegleichgewicht; kleine Sinkrate ist anderes Optimum.],

 [Druckbeiwert], [$c_p=(p-p_"∞")/(rho c_"∞"^2/2)$], [Dimensionslos; gleiche Bezugshöhe und freie Anströmung benennen.],
 [Kritisches Gasdruckverhältnis], [$pi_"krit"=(2/(kappa+1))^(kappa/(kappa-1))$], [Isentroper idealer Ausfluss; für Luftκ1,4 etwa0,5283.],
 [Kritischer Gasmassenstrom], [$dot(m)_"max"=A p_0 sqrt(kappa/(R T_0))(2/(kappa+1))^((kappa+1)/(2(kappa-1)))$], [p0/T0 Stauzustand; effektive FlächeA; SI-Einheiten.],

 [Kapillarhöhe], [$h=2sigma cos(theta)/(rho g r)$], [Kreisförmige dünne Kapillare; Kontaktwinkel durch Flüssigkeit.],
 [Dünne Druckhülle], [$sigma_phi=Delta p D/(2s), sigma_z=Delta p D/(4s)$], [Geschlossener dünnwandiger Zylinder; Überdruck.],
 [Metazentrische Höhe], [$G M=I_"Wasserlinie"/V_"verdrängt"-B G$], [Kleine Neigung, passende Symmetrie; stabil bei GM positiv.],
 [Rechteckiger Wechselsprung], [$h_2/h_1=(sqrt(1+8"Fr"_1^2)-1)/2$], [Horizontaler Rechteckkanal; hydrostatische Endquerschnitte.],
 [Schallgeschwindigkeit], [$a^2=(partial p/partial rho)_s, a=sqrt(kappa R T)$], [Zweite Gleichung ideales Gas; T inK.],
 [Düsenflächenbeziehung], [$dif A/A=("Ma"^2-1)dif c/c$], [Stationär, eindimensional, isentrop.],
 [Machwinkel], [$sin mu=1/"Ma"$], [Ma größer als1; kleine Störung, gleichförmiges Medium.],

)

#note("Wichtige Zahlen", [
$R_"Luft"="287,2" thin "J/(kg K)"$; $g approx "9,81" thin "m/s"^2$.

$1 thin "bar"=10^5 thin "Pa"$; $1 thin "l"=10^(-3) thin "m"^3$; $1 thin "cm"^2=10^(-4) thin "m"^2$.

$1 thin "kWh"="3,6" thin "MJ"$; Wasser flüssig näherungsweise $rho=1000 thin "kg"/"m"^3$, $c approx "4,19" thin "kJ/(kg K)"$ für die hier gerechneten Überschläge.
])

