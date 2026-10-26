// Kopf des Feynman-Lernskripts (Layout + Bausteine). Bilder liegen in abbildungen/. Keine Pakete erforderlich.
#set document(title: "Investitionsrechnung und technisches Controlling – Feynman-Lernskript", author: "Lernzusammenfassung")
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
  #text(size: 8pt, fill: muted)[Feynman-Lernskript · Stand 26.10.2026]
  #h(1fr)
  #text(size: 9pt, fill: navy)[Seite #counter(page).display("1") von #counter(page).final().first()]
]
#set page(paper: "a4", margin: (left: 20mm, right: 19mm, top: 19mm, bottom: 20mm),
 header: [#text(size: 8pt, fill: muted)[Investitionsrechnung und technisches Controlling #h(1fr) Sehen · Verstehen · Erklären]], footer: seitenfuss)
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
  "bep-aufgabe1": "abbildungen/bep-aufgabe1.svg",
  "bep-aufgabe3": "abbildungen/bep-aufgabe3.svg",
  "bep-ausserhalb": "abbildungen/bep-ausserhalb.svg",
  "cover": "abbildungen/cover.svg",
  "deckungsbalken": "abbildungen/deckungsbalken.svg",
  "entscheidungsvergleich": "abbildungen/entscheidungsvergleich.svg",
  "map-begriffe": "abbildungen/map-begriffe.svg",
  "map-bep": "abbildungen/map-bep.svg",
  "map-deckung": "abbildungen/map-deckung.svg",
  "map-entscheidung": "abbildungen/map-entscheidung.svg",
  "map-kosten": "abbildungen/map-kosten.svg",
  "map-perioden": "abbildungen/map-perioden.svg",
  "map-stueck": "abbildungen/map-stueck.svg",
  "map-ueberblick": "abbildungen/map-ueberblick.svg",
  "original-bep": "abbildungen/original-bep.svg",
  "original-gewinn": "abbildungen/original-gewinn.svg",
  "original-merke": "abbildungen/original-merke.svg",
  "original-sprung": "abbildungen/original-sprung.svg",
  "stueckkosten": "abbildungen/stueckkosten.svg",
)

#let bilddeutungen = (
  "bep-aufgabe1": (titel: "Bild lesen", body: [Waagerecht steht die Monatsmenge, senkrecht Euro je Monat. Grün ist E(x), orange K(x), gestrichelt der Fixkostenbetrag. Ihr Schnittpunkt liegt bei 500 Packungen und 35 000 €. Bei 1 000 Packungen stehen 70 000 € Erlös 50 000 € Kosten gegenüber; der senkrechte Abstand beträgt 20 000 € Gewinn.]),
  "bep-aufgabe3": (titel: "Bild lesen", body: [Waagerecht steht die Monatsmenge, senkrecht stehen Euro je Monat. Der Schnittpunkt von E = 40x und K = 200 000 + 25x liegt bei 13 333,333… Stück. Die gestrichelte Senkrechte bei 24 000 zeigt die Novembermenge. Sie ist keine belegte Kapazitätsgrenze. Die größeren Abstände rechts des Schnittpunkts bedeuten höheren Gewinn.]),
  "bep-ausserhalb": (titel: "Bild lesen", body: [Die grüne Erlöslinie steigt stärker als die orange Kostenlinie, schneidet sie aber erst bei 5 000 Stück. Die senkrechte Kapazitätsgrenze liegt bereits bei 4 500. Dort ist die Kostenlinie noch 3 000 € höher. Die Fortsetzung nach rechts zeigt nur den rechnerischen Schnittpunkt, keine lieferbare Menge.]),
  "cover": (titel: "Bild lesen", body: [Lies von links nach rechts: Vom Nettoerlös 70 € gehen 30 € variable Kosten ab. Der grüne Rest von 40 € ist der Beitrag einer Packung. Unten wird daraus die Gesamtdeckung: 500 Beiträge decken 20 000 € Fixkosten. Diese Darstellung ist eine Kostenrechnung, kein Zeitverlauf von Zahlungen.]),
  "deckungsbalken": (titel: "Bild lesen", body: [Oben ist eine einzelne Packung in 30 € variable Kosten und 40 € Beitrag zerlegt. Unten steht der gesamte Beitrag von 600 Packungen: 24 000 €. Davon deckt der blaue Anteil 20 000 € Fixkosten; nur die letzten 4 000 € bleiben als Gewinn. Die beiden Balken verwenden verschiedene Bezugsgrößen.]),
  "entscheidungsvergleich": (titel: "Bild lesen", body: [Die Balkenhöhe zeigt den Monatsgewinn, keine Absatzmenge. Der bisherige Fall bringt 12 000 €. Der orange Balken der allgemeinen Preissenkung sinkt auf 10 000 €, obwohl mehr verkauft wird. Der separate Zusatzauftrag erhöht den Gewinn auf 13 000 €, weil die bisherigen 800 Packungen weiter 70 € erlösen.]),
  "map-begriffe": (titel: "Bild lesen", body: [Beginne im dunkelgrünen Zentrum. Die vier hellblauen Äste gehören zusammen: Gesamt und Stück unterscheiden, Kapazität mit Zeitbezug angeben und netto auf derselben Periodenbasis rechnen. Prüfe diese Begriffe vor jeder Formel.]),
  "map-bep": (titel: "Bild lesen", body: [Beginne im dunkelgrünen Zentrum. Die vier hellblauen Äste gehören zusammen: Den Schnittpunkt mit E = K begründen, Kf durch den positiven Stück-DB teilen, ganze Stücke korrekt runden und die Kapazität prüfen.]),
  "map-deckung": (titel: "Bild lesen", body: [Beginne im dunkelgrünen Zentrum. Die vier hellblauen Äste gehören zusammen: Vom Nettoerlös erst variable Kosten abziehen, den Stückbeitrag mit der Menge multiplizieren und dann die Fixkosten einmal abziehen. Erst der letzte Schritt liefert das Ergebnis.]),
  "map-entscheidung": (titel: "Bild lesen", body: [Beginne im dunkelgrünen Zentrum. Die vier hellblauen Äste gehören zusammen: Die Art der Preisänderung unterscheiden, freie Kapazität prüfen, die passende Ergebnisänderung berechnen und Kundenrisiken berücksichtigen.]),
  "map-kosten": (titel: "Bild lesen", body: [Beginne im dunkelgrünen Zentrum. Die vier hellblauen Äste gehören zusammen: Fixkosten, variable Kosten, Mischkosten und Sprünge auseinanderhalten. Die Kostenfunktion ist erst sinnvoll, wenn diese Einordnung und ihr Mengenbereich stimmen.]),
  "map-perioden": (titel: "Bild lesen", body: [Beginne im dunkelgrünen Zentrum. Die vier hellblauen Äste gehören zusammen: Zwei Beobachtungen vergleichen, daraus die Steigung ermitteln, den Fixkostenblock berechnen und mit der zweiten Periode gegenprüfen.]),
  "map-stueck": (titel: "Bild lesen", body: [Beginne im dunkelgrünen Zentrum. Die vier hellblauen Äste gehören zusammen: Von K(x) durch Teilen zu k(x) gelangen, dabei fixe und variable Stückanteile unterscheiden und die Kapazitätsgrenze beachten. Mehr Menge verteilt Fixkosten, beseitigt sie aber nicht.]),
  "map-ueberblick": (titel: "Bild lesen", body: [Beginne im dunkelgrünen Zentrum. Die vier hellblauen Äste gehören zusammen: Bezugsgröße klären, Kosten aufteilen, Beiträge zur Deckung sammeln und danach entscheiden. Gehe diesen Weg beim Erklären einer Aufgabe in derselben Reihenfolge durch.]),
  "original-bep": (titel: "Bild lesen", body: [Waagerecht steht die Stückzahl, senkrecht stehen Kosten und Erlös in Euro. Die rote Erlösgerade startet im Ursprung; die orange Kostenlinie startet oberhalb davon bei den Fixkosten. Am Schnittpunkt ist der Gewinn null. Die blaue Senkrechte begrenzt die Kapazität; der Abstand der Geraden dort ist der maximal mögliche Gewinn im gezeichneten linearen Modell.]),
  "original-gewinn": (titel: "Bild lesen", body: [Der grüne Rahmen hält den Zusatzauftrag getrennt vom bisherigen Absatz fest. Die Erlöse beider Mengen werden addiert, die Kosten der neuen Gesamtmenge einmal abgezogen. Die Randnotiz warnt davor, dass bisherige Kunden ebenfalls den niedrigen Preis fordern könnten. Den verschriebenen Faktor bei den 7 000 € korrigiert die Lösung sichtbar.]),
  "original-merke": (titel: "Bild lesen", body: [Die roten Zeilen markieren drei Arbeitsregeln: Großbuchstaben für Gesamtbeträge einer Menge, Kleinbuchstaben für einen Stückbetrag und Nettopreise für die Rechnung. Die Farbe zeigt hier Deine Hervorhebung, keine zusätzliche Kostenart.]),
  "original-sprung": (titel: "Bild lesen", body: [Waagerecht nimmt die Menge zu, senkrecht stehen Kosten. Die waagerechten Stufen zeigen feste Kosten innerhalb eines Bereichs; der senkrechte Sprung steht für den neuen Fixkostenblock ab der markierten Grenze. Er ist kein proportionaler Anstieg bei jedem Stück.]),
  "stueckkosten": (titel: "Bild lesen", body: [Waagerecht steht die monatliche Packungsmenge, senkrecht Euro je Packung. Die blaue Kurve zeigt k = 20 000/x + 30; die grün gestrichelte Linie den konstanten variablen Anteil von 30 €. Der Abstand zwischen Kurve und Linie ist der fixe Anteil je Packung. Er sinkt, weil dieselben Fixkosten auf mehr Packungen verteilt werden.]),
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
#v(7mm)
#text(size: 11pt, tracking: 1pt, fill: teal)[VERSTEHEN · ERKLÄREN · ANWENDEN]
#v(6mm)
#text(size: 27pt, weight: "bold", fill: navy)[Investitionsrechnung\ und technisches Controlling]
#v(4mm)
#text(size: 20pt, fill: navy)[Feynman-Lernskript]
#v(3mm)
#text(size: 12pt)[Zusammenhänge sehen. Grundlagen verstehen. Selbst erklären.]
#v(4mm)
#bild("cover", [Vom Verkaufserlös zum Deckungsbeitrag. Eigene Darstellung mit den Zahlen aus Ü 1, PDF-S. 1.], height: 61mm)
#v(3mm)
#text(size: 12pt, fill: teal)[Menge → Kosten → Deckungsbeitrag → Gewinn → Entscheidung]
]
#note("Dein Feynman-Schritt", [Erkläre ohne Vorlage: *Was kostet ein weiteres Stück? Was trägt es bei? Wann wird daraus Gewinn?* Zeichne dazu zwei Linien oder einen Geldfluss. Prüfe anschließend Erklärung, Einheiten und Annahmen.])

*Stand 26.10.2026.* Enthalten ist der von Dir bestätigte Stoff aus VL 1–2: Grundlagen der KLR und Deckungsbeitragsrechnung, einschließlich der Aufgaben 1–4 des Blatts „08 Übungsaufgaben: KLR“. Die fachlichen Inhalte der älteren Skripte sind zusammengeführt; Das Skript enthält nur die Erklärungen und im Anhang die Formelsammlung; die Aufgaben (mit Altklausurteilen) samt Lösungen Schritt für Schritt und das Quiz stehen auf der Lernwebseite im Reiter „Lernen“. Spätere Investitionsverfahren und Controllingkennzahlen folgen erst nach Behandlung in der Vorlesung.
#src[Gliederung, PDF-S. 1–2; K, PDF-S. 1–2; Ü, PDF-S. 1–2; L15, PDF-S. 1 und 22; Umfang von Mario am 22.10.2026 bestätigt.]

#pagebreak()
#heading(level: 1, outlined: false)[Wegweiser]
#block[
#set text(size: 9.5pt)
#set par(leading: 0.3em, spacing: 0.15em)
#outline(title: none, depth: 2, indent: auto)
]
#v(2mm)
#text(size: 8.5pt, fill: muted)[*Quellenkürzel:* M = „KLR Skript eigenes Skript.pdf“, 2 S., vom 06.10.2026; K = „KLR.pdf“, 2 S., handschriftliche Grundlagen und VL-1-Übung; Ü = „VL2 Investition und Controlling.pdf“, 2 S., Blatt „08 Übungsaufgaben: KLR“ mit Notizen; Fotos Ü 2–4 = gleichnamige Originalfotos; F = „Formelsammlung.pdf“, 7 S.; A13 = „Controlling SS 13.pdf“; A14 = „Controlling WS 14-15.pdf“; A18 = „Controlling WS18-19.pdf“; L15 = „Stand 15.10.26_Lernskript_Investition.pdf“, 22 S.; L13 = Stand 13.10., 18 S.; L02 = „VL02_KLR_Grundlagen_Lernskript.pdf“, 15 S.; H = zugehörige frühere HTML-Skripte. Die alten Skripte liegen in „Zum Löschen/Alte Lernskript-Stände/“. „PDF-S.“ zählt ab der ersten Dateiseite. Alle „Nachschlagen“-Verweise führen mit automatisch berechneter Seite in dieses Lernskript. Eigene Erklärhilfen und Präzisierungen sind gekennzeichnet.]

#bild("map-ueberblick", [Die Denkkette des bisher behandelten Stoffs. Eigene Darstellung nach K und Ü, jeweils PDF-S. 1–2.], height: 47mm)

#pagebreak()
#heading(level: 1, outlined: false, bookmarked: false)[Das Modul auf einen Blick] <ueberblick>

Jeder Kasten ist ein Link: Tippe ihn an, um ins Kapitel oder in den Abschnitt zu springen. Graue Kästen stehen in der Gliederung, sind aber noch nicht behandelt.

#karte((1fr, auto, 1fr, auto, 1fr, auto, 1fr),
  chunk([Kapitel 1 · KLR und Deckungsbeitragsrechnung], [Bezugsgröße · fixe und variable Kosten · Deckungsbeitrag · Break-Even · Entscheidungen], ziel: <a-1>),
  pfeil(beschriftung: [Grundlage für]),
  chunk([Statische Investitionsverfahren], [noch nicht behandelt], fill: white, stroke: muted),
  pfeil(),
  chunk([Dynamische Investitionsverfahren], [noch nicht behandelt], fill: white, stroke: muted),
  pfeil(),
  chunk([Technisches Controlling], [noch nicht behandelt], fill: white, stroke: muted),
)

*Der rote Faden in Kapitel 1*

#karte((1fr, auto, 1fr, auto, 1fr, auto, 1fr, auto, 1fr),
  chunk([1.1 Bezugsgröße], [Periode · netto · Stück oder gesamt], ziel: <a-1-1>),
  pfeil(),
  chunk([1.2–1.3 Kosten], [$K_f$ · $k_v$ · $K(x)$ · $k(x)$], ziel: <a-1-2>),
  pfeil(),
  chunk([1.4 Deckungsbeitrag], [$d = p - k_v$ · $D = d dot x$], ziel: <a-1-4>),
  pfeil(),
  chunk([1.5 Break-Even], [$x_"BEP" = K_f / d$ · Kapazität], ziel: <a-1-5>),
  pfeil(),
  chunk([1.6 Entscheidung], [Preissenkung · Zusatzauftrag · Untergrenze], ziel: <a-1-6>),
)
#karte((1fr, 1fr),
  chunk([1.7 Kosten aus zwei Perioden], [zwei Beobachtungen → $k_v$ und $K_f$], ziel: <a-1-7>),
  chunk([1.8 Rückwärts rechnen und prüfen], [Zielgewinn · unerreichbare Schwelle · Ansatz für jede Textaufgabe], ziel: <a-1-8>),
)

Das Modul fragt im Kern: *Lohnt sich das?* Kapitel 1 legt dafür das Werkzeug. Du trennst Kosten, die mit jedem Stück entstehen, von Kosten, die ohnehin anfallen. Der Deckungsbeitrag zeigt, was jedes Stück zur Deckung der Fixkosten beiträgt, und daraus folgen Gewinnschwelle und Entscheidungen. Die späteren Investitionsverfahren bauen laut Gliederung auf genau dieser Trennung auf.
#src[Gliederung, PDF-S. 1–2; Zusammenführung aus Kapitel 1. Eigene Darstellung.]

#pagebreak()
= Kapitel 1 · KLR und #box[Deckungsbeitragsrechnung] <a-1>

#überblick([Kapitel 1 auf einen Blick],
  idee(<a-1-1>, [Erst die Bezugsgröße.], [Periode, Nettopreise und Stück oder Gesamtbetrag klären, bevor gerechnet wird.]),
  idee(<a-1-2>, [Kosten zerlegen.], [Fixe Kosten fallen ohnehin an, variable Kosten mit jedem Stück; daraus entstehen $K(x)$ und $k(x)$.]),
  idee(<a-1-4>, [Der Deckungsbeitrag verbindet Stück und Gewinn.], [Jedes Stück bringt $d = p - k_v$; erst wenn die Summe die Fixkosten deckt, entsteht Gewinn.]),
  idee(<a-1-5>, [Die Gewinnschwelle zeigt die nötige Menge.], [$x_"BEP" = K_f / d$, aber nur sinnvoll, wenn Kapazität und Nachfrage sie erlauben.]),
  idee(<a-1-6>, [Entscheiden heißt Änderungen vergleichen.], [Bei Preissenkung oder Zusatzauftrag zählt, wie sich Erlös und Kosten wirklich ändern.]),
)

*So gehst Du jede Textaufgabe an* (Abschnitt 1.8.2)

#ablauf(
  chunk([1 · Basis], [Preise netto? Mengen und Kosten auf dieselbe Periode bezogen?], ziel: <a-1-1>),
  chunk([2 · Modell], [Was ist fix, was je Stück variabel? Kommen neue Kosten dazu?], ziel: <a-1-2>),
  chunk([3 · Ansatz], [Kosten, Erlös und DB unterscheiden, gesuchte Größe durch Umstellen bestimmen], ziel: <a-1-4>),
  entscheidung([4 · Passt die Menge in Kapazität und Nachfrage?],
    chunk([5 · Prüfen], [Einheiten, Vorzeichen, Rundung, zweiter Rechenweg], ziel: <a-1-8-2>),
    chunk([Ziel unerreichbar], [Preis, Kosten oder Kapazität ändern], ziel: <a-1-8-1>)),
  chunk([6 · Entscheidung], [begründetes Ja oder Nein mit Bedingungen und Risiko], ziel: <a-1-6>),
)
#hoch(<ueberblick>, [Modul auf einen Blick])

Ein Betrieb kann viel verkaufen und trotzdem Verlust machen. Deshalb trennst Du zuerst die Kosten eines zusätzlichen Stücks von den Kosten, die ohnehin anfallen. Danach verbindest Du Preis, Menge und Kapazität zu einer nachvollziehbaren Entscheidung. Diese Grundlage steht in der Gliederung vor den eigentlichen Investitionsverfahren.
#src[Gliederung, PDF-S. 1; K, PDF-S. 1–2; Ü 1–4, PDF-S. 1–2. Einstieg: eigene Erklärung.]

== 1.1 Begriffe: erst die Bezugsgröße klären <a-1-1>

Ein Preis von 70 € je Packung und ein Monatsumsatz von 42 000 € sind unterschiedliche Größen. *Großbuchstaben* bezeichnen hier Beträge für die ganze betrachtete Menge, *Kleinbuchstaben* Beträge je Stück. Die *Periode* ist der gemeinsame Zeitraum, beispielsweise ein Monat.

#tab(columns: (0.8fr, 2.8fr, 1.25fr),
 th([Symbol], [Bedeutung], [Einheit]),
 [$x$], [hergestellte und verkaufte Menge im betrachteten Modell], [Stück/Periode],
 [Kap, $x_"max"$], [Kapazität: maximal mögliches Leistungsvermögen], [Stück/Periode],
 [BG], [Beschäftigungsgrad: Anteil der genutzten Kapazität], [%],
 [$K(x), K_f, K_v(x)$], [Gesamtkosten, fixe Kosten, variable Gesamtkosten], [€/Periode],
 [$k(x), k_f(x), k_v$], [gesamte, fixe und variable Kosten je Stück], [€/Stück],
 [$e$], [Nettoverkaufspreis je Stück], [€/Stück],
 [$E(x), G(x)$], [Erlös und Gewinn bzw. Betriebsergebnis], [€/Periode],
 [$d b_"I", d b_"II"$], [Stückdeckungsbeitrag und Ergebnis je Stück], [€/Stück],
 [$D B_"I", D B_"II"$], [Deckungsbeitrag gesamt und Ergebnis gesamt im einstufigen Schema], [€/Periode],
 [BEP; IB], [Break-Even-Point = Gewinnschwelle; Industriebetrieb], [Menge bzw. Betrieb],
)

*Kapazität braucht einen Zeitbezug:* 7 000 Stück pro Stunde sind etwas anderes als 7 000 Stück pro Monat. Bei 4 900 von 7 000 möglichen Stück pro Stunde sind 70 % ausgelastet; 30 % bleiben frei.
#form[$ "BG" = x/x_"max" dot 100 % $]
Zähler und Nenner müssen zur selben Periode gehören. Wenn in einer Aufgabe nur „Kap = 1 300 Stück“ steht, beziehst Du sie auf die dort betrachtete Periode; eine Stunde oder einen Monat ergänzt Du nicht ohne Beleg.

#bild("original-merke", [Deine roten Merksätze zu Groß-/Kleinschreibung und Nettopreisen. Ausschnitt M, PDF-S. 1.], height: 24mm)
#note("Von Dir markiert", [*Groß = gesamt, klein = je Stück. Immer Nettopreise.* Das sind die roten „Merke“-Zeilen aus Deiner Mitschrift.])

*Brutto in netto umrechnen:* In Ü 4 wird bei 19 % Umsatzsteuer aus 214,20 € brutto ein Nettoverkaufspreis von 180 €. Für diese Aufgabe gilt:
#form[$ e_"netto"=e_"brutto"/(1+"0,19")=("214,20" thin "€")/("1,19")=180 thin "€" $]
Die 19 % sind die Rechenannahme dieser Aufgaben. In den folgenden Erlösrechnungen wird mit dem Nettopreis gerechnet.
#bild("map-begriffe", [Mindmap: Bezugsgrößen vor dem Einsetzen prüfen. Eigene Darstellung nach M und K, jeweils PDF-S. 1.], height: 46mm)
#src[M, PDF-S. 1–2; K, PDF-S. 1–2; Ü 4, PDF-S. 2; Foto Ü 4; L15, PDF-S. 3. Klarstellung zur Periode: eigene Präzisierung.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.2 Fixe, variable, gemischte und sprungfixe Kosten <a-1-2>

*Fixe Kosten* bleiben innerhalb des betrachteten Beschäftigungsbereichs und Zeitraums gleich, etwa die hier vorgegebene Monatsmiete. *Variable Kosten* ändern sich mit der Menge. Im linearen Modell verursacht jede weitere Packung denselben variablen Betrag $k_v$.

*Eigene Erklärhilfe:* Beim Handyvertrag entspricht eine feste Grundgebühr dem fixen Anteil; jede zusätzlich berechnete Minute dem variablen Anteil. Bei einer Pizzeria sind Ladenmiete und Zutaten eine ähnliche Hilfe zum Einordnen. Welche Kosten tatsächlich fix sind, entscheidet aber immer das konkrete Modell.

#tab(columns: (2.1fr, 1fr, 1.8fr),
 th([Kosten aus Ü 1], [Ansatz], [Warum in dieser Aufgabe?]),
 [Gehälter 9 000 €], [$K_f$], [monatlicher Festbetrag],
 [Miete 1 600 €], [$K_f$], [nicht von Packungen abhängig],
 [Nebenkosten 400 €], [$K_f$], [als Monatsbetrag vorgegeben],
 [Fremdkapitalzinsen 3 000 €], [$K_f$], [mengenunabhängig angesetzt],
 [Abschreibungen 6 000 €], [$K_f$], [hier zeitabhängig angesetzt],
 [RHB-Stoffe 6 €/Packung], [$k_v$], [Roh-, Hilfs- und Betriebsstoffe je Packung],
 [Akkordlöhne 22 €/Packung], [$k_v$], [Bezahlung je erstellter Packung],
 [Energie 2 €/Packung], [$k_v$], [je Packung vorgegeben],
)
Damit ergeben sich *20 000 € Fixkosten pro Monat* und *30 € variable Kosten je Packung*. Die Eurobeträge je Monat und je Packung werden nicht direkt miteinander addiert.

*Mischkosten* enthalten beide Anteile. In Deiner Randnotiz steht deshalb: zuerst in variabel und fix aufteilen. Beispiel als eigene Erklärhilfe: Stromkosten aus Grundpreis und Verbrauchspreis.

*Sprungfixe Kosten* bleiben nur in einem Bereich konstant. Ab einer Grenze braucht man etwa eine weitere Maschine; damit beginnt ein neuer Fixkostenblock. Die Skizze auf Ü, PDF-S. 1 markiert einen Sprung bei 9 000 Stück.
#bild("original-sprung", [Sprungfixe Kosten aus Deiner Randnotiz; Ausschnitt Ü, PDF-S. 1.], height: 38mm)
#note("Fehler vermeiden", [Der *1-Stück-Test* ist eine Erklärhilfe: „Ändert sich dieser Betrag bei einem Stück mehr?“ Er gilt innerhalb desselben Bereichs. An einem Fixkostensprung reicht eine einzige Kostenfunktion mit unverändertem $K_f$ nicht mehr. „Je Stück“ allein beweist ebenfalls keine variable Kostenart: Auch fixe Kosten können rechnerisch auf Stücke verteilt sein.], fill: sand)
#bild("map-kosten", [Mindmap: Kosten zuerst richtig aufteilen. Eigene Darstellung nach Ü 1, PDF-S. 1.], height: 46mm)
#src[Ü 1 und Randnotizen, PDF-S. 1; L15, PDF-S. 4; L02, PDF-S. 2–3. Analogien und Modellgrenzen: eigene Erklärung/Präzisierung.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.3 Kostenfunktion und Stückkosten <a-1-3>

Die *Kostenfunktion* beantwortet: „Was kostet die ganze Menge?“ Die *Stückkosten* beantworten: „Wie viel davon entfällt rechnerisch auf ein Stück?“ Das ist dieselbe Kostenrechnung mit einer anderen Bezugsgröße.
#form[$ K_v(x)=k_v x quad K(x)=K_f+k_v x $]
$K_f$: €/Periode; $k_v$: €/Stück; $x$: Stück/Periode. Gültig bei unveränderten Fixkosten und proportionalen variablen Kosten innerhalb des betrachteten Bereichs.
#form[$ k(x)=K(x)/x=K_f/x+k_v=k_f(x)+k_v quad k_f(x)=K_f/x $]
$k,k_f,k_v$: €/Stück. Für die Division gilt $x>0$; bei $x=0$ sind Stückkosten nicht definiert, obwohl die Gesamtkosten $K(0)=K_f$ existieren.

#tab(columns: (0.8fr, 1fr, 1fr, 1fr, 1fr),
 th([$x$], [$K_f$ in €], [$K_v$ in €], [$K$ in €], [$k$ in €/Pack.]),
 [200], [20 000], [6 000], [26 000], [130,00],
 [400], [20 000], [12 000], [32 000], [80,00],
 [600], [20 000], [18 000], [38 000], [63,33],
 [800], [20 000], [24 000], [44 000], [55,00],
 [1 000], [20 000], [30 000], [50 000], [50,00],
)
Tabelle für Ü 1: $K_f=20 000$ €/Monat, $k_v=30$ €/Packung. Die Produktionsmengen sind Monatsmengen.

#bild("stueckkosten", [Fixkostendegression mit den Zahlen aus Ü 1, PDF-S. 1. Eigene Darstellung.], height: 58mm)
Die *Fixkostendegression*, in der Mitschrift „Gesetz der Massenproduktion“, verteilt dieselben Fixkosten auf mehr Stücke. Bei 200 Packungen sind es 100 € fixe Kosten je Packung, bei 1 000 nur 20 €. Der variable Anteil bleibt 30 € je Packung.

*Eigene Erklärhilfe:* Eine WG teilt 1 200 € Miete: zu zweit 600 €, zu viert 300 € pro Person. Das Essen pro Person wird durch das Teilen der Miete nicht automatisch billiger. Genauso sinkt $k_f$, während $k_v$ gleich bleibt.
#form[$ k_"min"=K_f/x_"max"+k_v quad k_(f,"min")=K_f/x_"max" $]
Im Modell mit $K_f>0$ und endlicher Kapazität liegen die minimalen Stückkosten *über* $k_v$. Ein mathematischer Grenzwert für unendlich große Mengen ist kein erreichbarer Betriebspunkt.
#note("Quelle sichtbar korrigiert", [In Deiner Kostentabelle steht bei 600 Packungen „63,30“. Die Rechnung ergibt $38 000/600="63,333…"$, auf Cent gerundet *63,33 €/Packung*. Der Originalscan bleibt unverändert.], fill: sand)
#bild("map-stueck", [Mindmap: vom Gesamtbetrag zum Betrag je Stück. Eigene Darstellung nach K, PDF-S. 1, und Ü 1, PDF-S. 1.], height: 46mm)
#src[M, PDF-S. 2; K, PDF-S. 1; Ü 1 mit Kostentabelle und Markierung „Gesetz der Massenproduktion“, PDF-S. 1; L15, PDF-S. 4–5; L02, PDF-S. 3–4. Grenzfall und WG: eigene Erklärung.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.4 Erlös, Gewinn und Deckungsbeitrag <a-1-4>

Ein verkauftes Stück bringt den Nettoerlös $e$. Nach Abzug seiner variablen Kosten bleibt der *Stückdeckungsbeitrag* $d b_"I"$. Er hilft, den festen Kostenblock zu bezahlen. Erst wenn der gesamte Deckungsbeitrag die Fixkosten übersteigt, ist das Betriebsergebnis positiv.
#form[$ E(x)=e x quad G(x)=E(x)-K(x) quad d b_"I"=e-k_v $]
$e,k_v,d b_"I"$: €/Stück; $E,K,G$: €/Periode. Produktion und Absatz werden in diesen Aufgaben gleichgesetzt; Nettoverkaufspreis und variable Stückkosten bleiben im jeweiligen Fall konstant.
#bild("deckungsbalken", [Ein Stück und die ganze Monatsmenge auseinanderhalten. Eigene Darstellung nach Ü 1, PDF-S. 1.], height: 55mm)

#tab(columns: (1fr, 1fr),
 th([Für die ganze Menge], [Für ein Stück, $x>0$]),
 [Erlöse $E(x)$], [Nettoverkaufspreis $e$],
 [− variable Gesamtkosten $K_v(x)$], [− variable Stückkosten $k_v$],
 [\= $D B_"I"=d b_"I" x$], [\= $d b_"I"$],
 [− fixe Gesamtkosten $K_f$], [− fixe Stückkosten $k_f=K_f/x$],
 [\= $D B_"II"=G$], [\= $d b_"II"=G/x$],
)
Die Mitschrift nennt $d b_"II"$ „GuV für ein Stück“ und $D B_"II"$ „GuV für $x$ Stück“. Gemeint ist hier der *Gewinn/Verlust*, also das Betriebsergebnis im vereinfachten Schema; „GuV“ ist in dieser Rechnung die Kurzbezeichnung Deiner Unterlagen.
#form[$ G(x)=d b_"I" x-K_f=D B_"I"-K_f=D B_"II" $]
Das ist der in der Randnotiz bezeichnete Schnellweg „Variante GBW“. Er ersetzt dieselbe Rechnung $E-K$; die Fixkosten werden dabei genau einmal abgezogen.

#note("Von Dir markiert · ★ Klausur", [Auf Ü 1 steht rot, dass man beim Ergebnis ein *Pluszeichen* ergänzen soll, damit der Gewinn erkennbar ist. Schreibe beispielsweise *$G=+4 000$ €* bzw. bei Verlust *$G=-3 000$ €*. Auch die grün umrandeten Rechenblöcke und die mehrstufige DB-Skizze sind übernommen.])

*Die mehrstufige Randnotiz:* Im einstufigen Schema werden alle Fixkosten gemeinsam abgezogen. Die mehrstufige Darstellung ordnet sie erst dem Produkt, dann der Produktgruppe und zuletzt dem Unternehmen zu. Die Bezeichnung „DB II“ hängt deshalb von der Stufe ab: Nach Abzug nur der Produktfixkosten ist sie noch nicht automatisch das gesamte Betriebsergebnis. Hier ist die kurze Einordnung aus Deinen Notizen und den alten Skripten gemeint.

*Eigene Erklärhilfe:* Stell Dir 20 000 € Fixkosten als leeren Eimer vor. Jede Packung zu 70 € bei 30 € variablen Kosten liefert 40 €. Nach 500 Packungen ist der Eimer rechnerisch gefüllt. Weitere Packungen liefern bei gleichbleibenden Bedingungen Gewinn. Das Bild erklärt die Kostendeckung; es beschreibt keinen tatsächlichen Zahlungsstrom.
#bild("map-deckung", [Mindmap: Deckungsbeitrag und Gewinn unterscheiden. Eigene Darstellung nach M, PDF-S. 2, und Ü 1, PDF-S. 1.], height: 46mm)
#note("Notation in den Quellen", [F, PDF-S. 4–5 verwendet „dB I“ und „DB I“ ohne überall klaren Stückbezug. Für den BEP teilst Du *Euro durch Euro je Stück*. Deshalb steht im Nenner der Stückdeckungsbeitrag, nicht der gesamte Monats-DB.], fill: sand)
#src[M, PDF-S. 1–2; K, PDF-S. 1; Ü 1, PDF-S. 1, grün umrandete Randrechnungen und rote Notiz; F, PDF-S. 4–5; L15, PDF-S. 5–6; L02, PDF-S. 5. Eimer und begriffliche Präzisierung: eigene Erklärung.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.5 Break-Even-Point und Beschäftigungsgrad <a-1-5>

Die *Gewinnschwelle* liegt dort, wo die Erlöse gerade alle Kosten decken. Bei einem positiven Stückdeckungsbeitrag fragst Du: Wie viele solcher Beiträge brauche ich, um $K_f$ zu decken?
#form[$ E(x)=K(x) => e x=K_f+k_v x => (e-k_v)x=K_f $]
#form[$ x_"BEP"=K_f/(e-k_v)=K_f/(d b_"I") quad E_"BEP"=e x_"BEP" $]
$x_"BEP"$: Stück/Periode; $E_"BEP"$: €/Periode. Voraussetzungen: lineares Modell, gleiche Periode, konstantes $e$, $k_v$, $K_f$ und $d b_"I">0$. Für $K_f>0$ und $d b_"I"<=0$ lässt sich durch zusätzliche Produktion keine Gewinnschwelle erreichen (eigene algebraische Präzisierung).

#bild("original-bep", [Deine BEP-Skizze mit Kapazitätsgrenze; Ausschnitt K, PDF-S. 1.], height: 48mm)
Die 3 500 Stück in der Originalskizze bezeichnen die *Gewinnschwellenmenge*. Ein *Gewinnschwellenumsatz* benötigt dagegen die Einheit Euro. Die Skizze liefert ohne Preisangabe keinen numerisch gesicherten Eurobetrag.

#bild("bep-aufgabe1", [BEP für Ü 1: 500 Packungen, 35 000 € Umsatz, Kapazität 1 000 Packungen pro Monat. Eigene Darstellung nach Ü, PDF-S. 1.], height: 59mm)
*So zeichnest Du selbst:* Waagerecht steht $x$, senkrecht stehen Eurobeträge. Zeichne $K_f$ waagerecht, $K(x)$ mit Startwert $K_f$ und Steigung $k_v$, $E(x)$ durch den Ursprung mit Steigung $e$. Der Schnittpunkt liefert die theoretische BEP-Menge. Die Kapazität zeichnest Du als senkrechte Grenze ein.

#note("Fehler vermeiden · exakt und ganzzahlig", [Die exakte Schwelle von Ü 4 ist $64 000/70="914,2857…"$ Regale. Bei ganzen Stückzahlen ist *915* die kleinste Menge ohne Verlust: 914 ergeben −20 €, 915 ergeben +50 €. Du rundest nur dann nach oben, wenn die exakte Menge nicht ganzzahlig ist. Ein schon ganzzahliger Wert bleibt unverändert.], fill: sand)

=== 1.5.1 Gewinnmaximum und Sicherheitsabstand <a-1-5-1>

Bei $d b_"I">0$ erhöht jedes weitere verkaufte Stück den Gewinn um $d b_"I"$. Wenn die gesamte Kapazität abgesetzt werden kann, liegt das Gewinnmaximum dieses linearen Modells an $x_"max"$:
#form[$ G_"max"=G(x_"max")=d b_"I" x_"max"-K_f $]
Ist die Nachfrage kleiner, begrenzt sie die verkaufbare Menge. Bei $d b_"I"=0$ wächst der Gewinn durch mehr Menge nicht, bei negativem Beitrag wird er schlechter. Das sind Grenzen der Aussage „Gewinnmaximum an der Kapazität“.

#form[$ "BG"_"BEP"=x_"BEP"/x_"max" dot 100 % $]
Bei Ü 4 liegt der *theoretische* BG der Schwelle bei etwa 76,19 %. Mit der kleinsten ganzen Stückzahl ohne Verlust sind es $915/1200 dot 100 %= "76,25" %$. Beide Werte haben eine klare Bedeutung; die Rechnung muss sagen, welchen sie verwendet.

#tab(columns: (1.4fr, 1.2fr, 1fr),
 th([Änderung, sonst gleich], [Stück-DB], [BEP-Menge]),
 [$K_f$ steigt], [bleibt gleich], [steigt],
 [$k_v$ steigt], [sinkt], [steigt],
 [$e$ steigt], [steigt], [sinkt],
 [$e$ sinkt], [sinkt], [steigt],
)
Ein hoher BG an der Gewinnschwelle lässt wenig Puffer gegen einen Absatzrückgang. In Ü 4 werden bei 85 % tatsächlich 1 020 Regale verkauft: nur 105 Stück mehr als die kleinste ganze Menge ohne Verlust.
#note("Von Dir markiert", [Bei Ü 4 steht rot sinngemäß: „Gewinn zu niedrig bei solch einer hohen Auslastung“; $K_f$, $k_v$ und $e$ prüfen. Die Rechnung liefert +7 400 €. Ob dieser Gewinn wirtschaftlich genügt, braucht zusätzlich ein Ziel; die Randnotiz ist ein Anlass zur Prüfung, kein allgemeiner Grenzwert.])
#bild("map-bep", [Mindmap: Schwelle, Rundung und Kapazität zusammen denken. Eigene Darstellung nach K, PDF-S. 1–2, und Ü, PDF-S. 1–2.], height: 46mm)
#src[K, PDF-S. 1–2; M, PDF-S. 1–2; Ü 1 und 4, PDF-S. 1–2; F, PDF-S. 5; L15, PDF-S. 6–7 und 10. Unterscheidung exakt/ganzzahlig, Randfälle und Nachfragegrenze: eigene Präzisierung.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.6 Entscheidungen: Preissenkung und Zusatzauftrag <a-1-6>

„Mehr verkaufen“ und „mehr verdienen“ sind nicht dasselbe. Entscheidend ist, ob der zusätzliche Beitrag größer ist als das, was die Entscheidung an anderer Stelle kostet. In Ü 1 werden deshalb zwei unterschiedliche Preisentscheidungen gerechnet.

=== 1.6.1 Preis für die gesamte Menge senken <a-1-6-1>

Bei einer allgemeinen Preissenkung erhalten auch die bisherigen Käufer den niedrigeren Preis. Du verlierst auf der alten Menge Deckungsbeitrag; die größere Absatzmenge muss das erst ausgleichen.

+ Rechne mit dem neuen Nettopreis und der *lieferbaren* neuen Menge.
+ Begrenze die Menge durch Kapazität und Nachfrage.
+ Vergleiche den gesamten Gewinn vorher und nachher.

#form[$ G_"alt"=(e_"alt"-k_v)x_"alt"-K_f quad G_"neu"=(e_"neu"-k_v)x_"neu"-K_f $]
Gültigkeit hier: $K_f$ und $k_v$ bleiben bei der Entscheidung unverändert. Bei neuen Kosten oder einem Fixkostensprung gehören diese in den Vergleich.

=== 1.6.2 Einmaliger Auftrag zu anderem Preis <a-1-6-2>

Beim Zusatzauftrag bleibt der Preis der bisherigen Menge unverändert. *Freie Kapazität* bedeutet hier: Der Auftrag verdrängt keine andere Produktion. Ändern sich die Fixkosten nicht und fallen keine weiteren auftragsbedingten Kosten an, gilt:
#form[$ Delta G=(e_"Z"-k_v)x_"Z" $]
$e_"Z"$: Zusatzpreis in €/Stück; $x_"Z"$: Zusatzmenge in Stück/Periode; $Delta G$: zusätzlicher Gewinn in €/Periode. Bei $e_"Z">k_v$ steigt der Gewinn, bei Gleichheit bleibt er gleich. Der Kernbetrieb muss seine Fixkosten dafür *nicht bereits vollständig gedeckt haben*: Ein positiver zusätzlicher DB kann auch einen bestehenden Verlust verkleinern (eigene Präzisierung des alten Skripts).

#bild("entscheidungsvergleich", [Gleiche Kostenstruktur, unterschiedliche Preisentscheidungen. Eigene Darstellung nach Ü 1, PDF-S. 1.], height: 58mm)

#note("Fehler vermeiden", [Beim Zusatzauftrag nicht $K_f$ ein zweites Mal abziehen. Bei einer allgemeinen Preissenkung dagegen nicht nur die 200 neuen Packungen zum neuen Preis rechnen: In Ü 1 zahlen dann *alle 1 000 Packungen* nur 60 €.], fill: sand)

*Risiko aus Deiner Notiz:* Bisherige Kunden könnten ebenfalls den niedrigeren Preis fordern. Die Preisdifferenzierung lässt sich dann nicht halten. Würden alle 1 000 Packungen nur 35 € erlösen, wäre $G=(35-30) dot 1000-20 000=-15 000$ €. Außerdem ist die Kapazität durch den Zusatzauftrag gebunden.

=== 1.6.3 Preisuntergrenzen im verwendeten Modell <a-1-6-3>

Als *eigene ergänzende Einordnung aus den alten Skripten* gilt kurzfristig bei freier Kapazität und unveränderten Fixkosten: $e_"Z"=k_v$ deckt gerade die variablen Kosten, erst darüber wächst der Gewinn. Langfristig muss die geplante Menge auch die Fixkosten tragen: Im einfachen Einproduktmodell ist dafür $e>=k(x)$ nötig. Das ist kein Freibrief für einen dauerhaft niedrigen Preis; Menge, Zusatzkosten und Verdrängung müssen zum Modell passen.

#bild("original-gewinn", [Zusatzauftrag und Kundenrisiko in Deiner grün umrandeten Randrechnung. Ausschnitt Ü, PDF-S. 1.], height: 53mm)

#note("In eigenen Worten", [„Für den Zusatzauftrag frage ich: *Was ändert sich durch ihn?* Für die allgemeine Preissenkung frage ich: *Was verdient der ganze Betrieb danach?*“ Eigene Erklärung nach Ü 1.])
#bild("map-entscheidung", [Mindmap: Kapazität, Vergleich und Risiko. Eigene Darstellung nach Ü 1, PDF-S. 1.], height: 46mm)
#src[Ü 1 mit grün umrandeten Rechnungen und Notiz „Preisdifferenzierung“, PDF-S. 1; L15, PDF-S. 7–9; L13, PDF-S. 7–9; L02, PDF-S. 7–9. Preisuntergrenzen, Bedingungen und Verlustverkleinerung: ausdrücklich ergänzte Erklärung/Präzisierung.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.7 Kosten aus zwei Perioden bestimmen <a-1-7>

Kennst Du Menge und Gesamtkosten aus zwei Perioden, kannst Du die Steigung der Kostenlinie bestimmen. *Wenn beide Perioden dieselbe lineare Kostenstruktur haben*, stammt die Kostendifferenz nur aus der Mengendifferenz.
#form[$ k_v=(K_2-K_1)/(x_2-x_1)=(Delta K)/(Delta x) quad K_f=K_1-k_v x_1 $]
$Delta K$: €/Periode; $Delta x$: Stück/Periode; $k_v$: €/Stück. Voraussetzungen: $x_2!=x_1$, gleicher Periodenbezug, unveränderte Fixkosten und variable Stückkosten, kein Struktur- oder Fixkostensprung.

Für Oktober und November in Ü 3 gilt:
$ k_v=(800 000-700 000)/(24 000-20 000)=25 thin "€/Stück" $.
Dann $K_f=700 000-25 dot 20 000=200 000$ €/Periode.
*Probe:* $800 000-25 dot 24 000=200 000$ €; beide Perioden liefern denselben Fixkostenblock.

#bild("map-perioden", [Mindmap: Differenz, Fixkosten, Gegenprobe. Eigene Darstellung nach Ü 3, PDF-S. 2.], height: 46mm)

*Eigene Erklärhilfe aus dem alten Skript:* Eine Stromrechnung kostet bei 300 kWh 110 €, bei 400 kWh 140 €. Die Steigung ist 30 €/100 kWh = 0,30 €/kWh. Der feste Anteil ist 110 € − 0,30 €/kWh · 300 kWh = 20 €. Das Beispiel zeigt nur das lineare Modell.
#note("Selbst erklären", [Warum muss bei beiden Perioden dasselbe $K_f$ herauskommen? *Weil Du gerade annimmst, dass beide Punkte zu derselben Kostenlinie gehören.* Zwei Beobachtungen allein beweisen noch nicht, dass das Modell auch in jedem anderen Monat gilt. Eigene Präzisierung.])
#src[Ü 3 und Randrechnungen, PDF-S. 2; Foto Ü 3; L15, PDF-S. 8 und 10; L02, PDF-S. 7–9. Strombeispiel und Aussage zur Modellprüfung: eigene Erklärung.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.8 Rückwärts rechnen, Ziele setzen und Ergebnisse prüfen <a-1-8>

Bei Textaufgaben ist oft nicht der Gewinn gesucht. Nutze dieselben Beziehungen rückwärts, statt für jede Formulierung eine neue Formel auswendig zu lernen.
#tab(columns: (1.6fr, 2fr, 1.8fr),
 th([Gegeben/gesucht], [Ansatz], [Prüfung]),
 [Kosten und Verlust; Erlös gesucht], [$E=G+K$, dann $e=E/x$], [Verlust als negatives $G$ einsetzen],
 [$K,K_f,x$; $k_v$ gesucht], [$k_v=(K-K_f)/x$], [Einheit €/Stück],
 [Zielgewinn $G_"Ziel"$], [$x_"Ziel"=(K_f+G_"Ziel")/(d b_"I")$], [ganze Menge, Kapazität, Absatz],
 [Theoretischer BEP und Stück-DB], [$K_f=x_"BEP" d b_"I"$], [keine gerundete Menge als exakte Schwelle behandeln],
)
Die Zielgewinnformel folgt durch Umstellen von $G=d b_"I" x-K_f$. Gültig ist sie bei positivem Stück-DB und derselben Kostenstruktur. Die Gewinnschwelle ist der Sonderfall $G_"Ziel"=0$.

=== 1.8.1 Wenn die Gewinnschwelle unerreichbar ist <a-1-8-1>

In Ü 2 liegt der theoretische Schnittpunkt bei 5 000 Stück, die Kapazität aber bei 4 500. Das Modell liefert dann selbst bei Vollauslastung noch −3 000 €.
#bild("bep-ausserhalb", [Die Gewinnschwelle liegt rechts der Kapazitätsgrenze. Eigene Darstellung nach Ü 2, PDF-S. 2. Die Linie über 4 500 Stück ist nur rechnerisch fortgesetzt.], height: 56mm)
Mögliche Stellschrauben sind Preis erhöhen, variable Stückkosten senken, Fixkosten senken oder Kapazität ändern. Eine Kapazitätserweiterung kann neue Fixkosten verursachen; danach musst Du *beide* Änderungen zusammen prüfen.

=== 1.8.2 Ein Ansatz für jede Textaufgabe <a-1-8-2>

+ *Basis:* Sind Preise netto, Mengen und Kosten auf dieselbe Periode bezogen?
+ *Modell:* Welche Kosten sind fix, welche je Stück variabel? Gibt es neue Kosten?
+ *Ansatz:* Kosten, Erlöse und DB sauber unterscheiden; gesuchte Größe durch Umstellen bestimmen.
+ *Machbarkeit:* Passt die errechnete Menge in Kapazität und Nachfrage?
+ *Prüfung:* Einheiten, Vorzeichen, Rundung und möglichst einen zweiten Rechenweg kontrollieren.
+ *Entscheidung:* Bei „Soll der IB …?“ ein begründetes Ja/Nein mit den passenden Bedingungen und dem Risiko angeben.

#note("Anschluss an das Modul", [Die Gliederung baut nach dieser Basis statische und dynamische Investitionsverfahren sowie Controlling auf. Schon jetzt kannst Du verstehen, warum eine neue Maschine fixe und variable Kosten verändern kann. Die zusätzlichen Verfahren werden hier noch nicht vorweg erklärt.])
#src[Ü 2–4, PDF-S. 2; K, PDF-S. 2, Rückwärtsaufgaben; Gliederung, PDF-S. 1–2; L15, PDF-S. 8–10 und 21–22; L02, PDF-S. 9–10 und 15. Geordneter Lösungsablauf: eigene Zusammenführung.]

#block(breakable: false)[
*Der Zusammenhang in Kapitel 1.* Erst klärst Du Periode und Bezugsgröße. Dann zerlegst Du Kosten und bildest Kosten- und Erlösfunktion. Der Stückdeckungsbeitrag verbindet jede einzelne Einheit mit dem gesamten Gewinn. Die Gewinnschwelle zeigt die nötige Menge; Kapazität und Nachfrage zeigen, ob sie erreichbar ist. Bei Entscheidungen prüfst Du schließlich die tatsächliche Änderung und ihre Bedingungen.
#src[Zusammenführung aus M und K, jeweils PDF-S. 1–2, sowie Ü 1–4, PDF-S. 1–2. Eigene Darstellung.]

]
#hoch(<a-1>, [Kapitelübersicht])

= Anhang
== Formelsammlung mit Voraussetzungen

Alle Beträge und Mengen beziehen sich auf dieselbe Periode. Es gilt das im Kapitel erläuterte lineare Einproduktmodell; für einen gegebenen Mehrproduktfall werden die Gesamt-DB addiert und gemeinsame Fixkosten einmal abgezogen.

#tab(columns: (1.35fr, 2fr, 2fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Kosten], [$K_v=k_v x$; $K=K_f+k_v x$], [proportionales $K_v$; gleiches $K_f,k_v$ im Bereich; €/Periode],
 [Stückkosten], [$k_f=K_f/x$; $k=K/x=k_f+k_v$], [$x>0$; €/Stück],
 [Nettopreis], [$e_"netto"=e_"brutto"/(1+s)$], [$s$ als Dezimalzahl vorgegeben; in Ü 4: 0,19],
 [Erlös], [$E(x)=e x$], [$e$ netto; vollständiger Absatz der Menge $x$],
 [Gewinn], [$G(x)=E(x)-K(x)$], [Vorzeichen; €/Periode],
 [Deckungsbeitrag I], [$d b_"I"=e-k_v$; $D B_"I"=d b_"I" x=E-K_v$], [Stück-DB €/Stück; Gesamt-DB €/Periode],
 [Ergebnis einstufig], [$D B_"II"=D B_"I"-K_f=G$; $d b_"II"=G/x=d b_"I"-k_f$], [Fixkosten einmal abziehen; Stückwert nur $x>0$],
 [Gewinn-Schnellweg], [$G=d b_"I" x-K_f$], [lineares Modell; €/Periode],
 [Exakter BEP], [$x_"BEP"=K_f/(d b_"I")$], [positiver Stück-DB; theoretische Menge],
 [Ganzzahlige Schwelle], [$x_"ganz"=ceil(x_"BEP")$], [kleinste ganze Menge mit $G>=0$; Kapazität prüfen],
 [BEP-Umsatz], [$E_"BEP"=e x_"BEP"$], [für exakten Schnittpunkt ungerundetes $x$],
 [Rückschluss Fixkosten], [$K_f=x_"BEP" d b_"I"$], [exakte Schwelle, keine vorher gerundete Menge],
 [Zielgewinn], [$x_"Ziel"=(K_f+G_"Ziel")/(d b_"I")$], [$d b_"I">0$; ganze Stücke nach oben, Absatz/Kapazität],
 [Gewinnmaximum], [$G_"max"=d b_"I" x_"max"-K_f$], [positiver Stück-DB; voller Absatz bis Kapazität],
 [Beschäftigungsgrad], [$"BG"=x/x_"max" dot 100 %$], [gleicher Zeitbezug; theoretisch/ganzzahlig benennen],
 [Zusatzauftrag], [$Delta G=(e_"Z"-k_v)x_"Z"$], [freie Kapazität, keine Verdrängung; keine weiteren Kosten],
 [Zwei Perioden], [$k_v=(K_2-K_1)/(x_2-x_1)$], [$x_2!=x_1$; gleiche lineare Kostenstruktur],
 [Fixkosten ermitteln], [$K_f=K-k_v x$], [Gegenprobe mit zweiter Periode],
 [Variable Stückkosten], [$k_v=(K-K_f)/x$], [$x>0$; €/Stück],
 [Erlös aus Ergebnis], [$E=G+K quad e=E/x$], [Verlust negativ; für Preis $x>0$],
)
#src[M und K, jeweils PDF-S. 1–2; Ü 1–4, PDF-S. 1–2; F, PDF-S. 5; L15, PDF-S. 19 und L02, PDF-S. 15. Zusammenstellung, Zielgewinn-Umstellung und Gültigkeitspräzisierungen: eigene Darstellung.]

#note("Wichtige Zahlen", [*Ü 1:* $K_f=20 000$ €/Monat, $k_v=30$ €/Packung, $e=70$ €/Packung → Stück-DB 40 €, BEP 500 Packungen, $G(800)=+12 000$ €. *Ü 4:* 214,20 € brutto / 1,19 = 180 € netto; Stück-DB 70 €; exakte Schwelle 914,2857… Regale, kleinste ganze Menge 915. *Prozent:* 85 % = 0,85. Zahlen sind Aufgabenwerte, keine allgemeinen Betriebskennzahlen.])
#src[Ü 1 und 4, PDF-S. 1–2; Foto Ü 4; Werte nachgerechnet.]
