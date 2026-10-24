// Kopf des Feynman-Lernskripts (Layout + Bausteine). Bilder liegen in abbildungen/. Keine Pakete erforderlich.
#set document(title: "Konstruktion – Feynman-Lernskript", author: "Lernzusammenfassung")
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
  #text(size: 8pt, fill: muted)[Feynman-Lernskript · Stand 24.10.2026]
  #h(1fr)
  #text(size: 9pt, fill: navy)[Seite #counter(page).display("1") von #counter(page).final().first()]
]
#set page(paper: "a4", margin: (left: 20mm, right: 19mm, top: 19mm, bottom: 20mm),
 header: [#text(size: 8pt, fill: muted)[Konstruktion #h(1fr) Sehen · Verstehen · Erklären]], footer: seitenfuss)
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

#let abbildungen = (
  "cover": "abbildungen/map-ablauf.svg",
)

#let bilddeutungen = (
  "cover": (titel: "Bild lesen", body: [Die vier Äste zeigen die Arbeitsweise für dieses Lernskript: Unterlagen prüfen, den behandelten Umfang abgrenzen, Inhalte mit Quellen erklären und anschließend selbst anwenden. Die Mindmap beschreibt den Aufbau; sie bestätigt keinen Vorlesungsstand.]),
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
#text(size: 29pt, weight: "bold", fill: navy)[Konstruktion]
#v(4mm)
#text(size: 20pt, fill: navy)[Feynman-Lernskript]
#v(3mm)
#text(size: 12pt)[Zusammenhänge sehen. Grundlagen verstehen. Selbst erklären.]
#v(7mm)
#bild("cover", [Arbeitsweise für das Lernskript. Eigene Darstellung nach dem FET-Mindmap-Muster.], height: 63mm)
#v(4mm)
#text(size: 12pt, fill: teal)[Form → Darstellung → Bemaßung → Funktion]
]

#note("Dein Feynman-Schritt", [Sieh Dir die Zeichnung an. Erkläre ohne Vorlage: *Was stellt sie dar? Warum ist es so gezeichnet? Welche Angaben brauche ich zum Fertigen und Prüfen?* Vergleiche erst danach mit Erklärung und Lösung.])

Stand: *24.10.2026 · Einrichtung, noch kein ausgearbeitetes Lernskript.* Buch, Altklausur und alter Lernskript-Stand sind erfasst. Die Vorlesungsgrenze ist aus diesen Dateien nicht belegbar; deshalb werden die Fachkapitel erst nach Klärung des behandelten Umfangs übernommen.

#pagebreak()
#heading(level: 1, outlined: false)[Wegweiser]
#block[
#set text(size: 9.5pt)
#set par(leading: 0.3em, spacing: 0.15em)
#outline(title: none, depth: 2, indent: auto)
]
#v(2mm)
#text(size: 8.5pt, fill: muted)[*Quellenkürzel:* B = Labisch/Wählisch, Technisches Zeichnen, 7. Auflage 2025; AK = Konstruktion Prüfung WS20/21, 03.02.2021; L-alt = altes Claude-Lernskript, Stand 15.10.2026. Bei B sind „S.“ gedruckte Buchseiten: S. 1–291 = PDF-S. minus 11, im Sachwortverzeichnis S. 293–297 = PDF-S. minus 10. „PDF-S.“ zählt stets ab der ersten PDF-Seite. L-alt ist eine zu prüfende Vorarbeit und kein Nachweis für behandelte Vorlesungsinhalte.]

// Fachkapitel, Aufgaben und Lösungen hier vor dem Anhang einfügen, sobald
// Mario den Vorlesungsumfang genannt hat. Keine Buchkapitel auf Verdacht aufnehmen.
// Jede Zielüberschrift erhält ein Label; neue Lösungen verwenden #stelle.

#v(6mm)
= Anhang
== Formelsammlung mit Voraussetzungen
Nach Klärung des behandelten Umfangs werden hier die zugehörigen Formeln mit Voraussetzungen und Einheiten gesammelt.
#note("Wichtige Zahlen", [In diesem Aufbaustand sind noch keine fachlichen Zahlenwerte übernommen.])
