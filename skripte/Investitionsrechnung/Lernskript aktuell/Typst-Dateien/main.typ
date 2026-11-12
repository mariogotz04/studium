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
  #text(size: 8pt, fill: muted)[Feynman-Lernskript · Stand 12.11.2026]
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
  "db-stufentreppe": "abbildungen/db-stufentreppe.svg",
  "map-db-stufen": "abbildungen/map-db-stufen.svg",
  "kritisch-erweiterung": "abbildungen/kritisch-erweiterung.svg",
  "map-investitionskosten": "abbildungen/map-investitionskosten.svg",
  "map-kvr": "abbildungen/map-kvr.svg",
  "map-gvr": "abbildungen/map-gvr.svg",
  "map-rvr": "abbildungen/map-rvr.svg",
  "map-kritisch": "abbildungen/map-kritisch.svg",
  "kritische-auslastung": "abbildungen/kritische-auslastung.svg",
  "amortisationsverlauf": "abbildungen/amortisationsverlauf.svg",
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
  "db-stufentreppe": (titel: "Bild lesen", body: [Von links nach rechts werden die fixen Kosten der jeweils passenden Ebene abgezogen. Beiträge mehrerer Produkte werden vor dem Abzug ihrer gemeinsamen Gruppenkosten addiert. Die Stufen sind eine Ordnung von Beträgen, keine Zeitachse.]),
  "map-db-stufen": (titel: "Bild lesen", body: [Die Äste verbinden den Beitrag jedes Produkts mit den verursachungsnahen Fixkostenstufen. Entscheidungen prüfen die Veränderung; bei einer knappen Ressource zählt zusätzlich ihr Verbrauch.]),
  "kritisch-erweiterung": (titel: "Bild lesen", body: [Waagerecht steht die gemeinsame Jahresmenge, senkrecht die Jahreskosten. Blau ist Angebot a mit höherem Fixkostenstart, aber geringerer Steigung. Orange ist b. Unterhalb von 7 344,8276 Stück ist b günstiger, oberhalb a. Der Punkt liegt innerhalb der Kapazität von 12 000 Stück; der hier gleiche Stückerlös ist nicht als Linie gezeichnet.]),
  "map-investitionskosten": (titel: "Bild lesen", body: [Beginne im dunkelgrünen Zentrum und folge den vier hellblauen Ästen. Der Kaufbetrag wird nicht als voller Jahresaufwand angesetzt. Abschreibung und Zinsen bilden den Kapitaldienst; dazu kommen die Betriebskosten.]),
  "map-kvr": (titel: "Bild lesen", body: [Beginne im dunkelgrünen Zentrum und folge den vier hellblauen Ästen. Ein Kostenurteil braucht gleichwertige Leistung und eine klare Mengenbasis. Kapazität und Absatz begrenzen den Vergleich.]),
  "map-gvr": (titel: "Bild lesen", body: [Beginne im dunkelgrünen Zentrum und folge den vier hellblauen Ästen. Die Jahresmenge verbindet den Nettoerlös je Stück mit dem Gesamterlös. Erst nach Abzug sämtlicher Jahreskosten bleibt der Jahresgewinn.]),
  "map-rvr": (titel: "Bild lesen", body: [Beginne im dunkelgrünen Zentrum und folge den vier hellblauen Ästen. Zähler und Nenner müssen dieselbe Investition beschreiben. Beim Budgetvergleich wird auch die Verwendung des freien Kapitals berücksichtigt.]),
  "map-kritisch": (titel: "Bild lesen", body: [Beginne im dunkelgrünen Zentrum und folge den vier hellblauen Ästen. Die Gleichung findet nur die Grenze. Erst eine Probe auf beiden Seiten und der Kapazitätstest machen daraus eine Entscheidung.]),
  "kritische-auslastung": (titel: "Bild lesen", body: [Waagerecht steht die Jahresmenge, senkrecht stehen Jahreskosten. Die blaue Linie startet höher bei 47 000 €, steigt aber mit 14,75 €/Stück flacher. Orange startet bei 30 000 € und steigt mit 16,30 €/Stück. Links der exakten Schwelle ist Objekt 2 günstiger, rechts Objekt 1. Der Schnittpunkt zeigt Kostengleichheit zweier Anlagen, keinen Nullgewinn.]),
  "amortisationsverlauf": (titel: "Bild lesen", body: [Waagerecht steht die Zeit in Jahren, senkrecht der rechnerisch kumulierte Rückfluss. Die blaue Gerade erreicht ihren eigenen Kaufbetrag von 18 000 € nach etwa 1,94 Jahren. Grün steigt schneller, muss aber 32 000 € ausgleichen und erreicht diesen Betrag erst nach etwa 2,14 Jahren. Es sind Durchschnittsgeraden, keine beobachteten Zahlungsreihen.]),
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

*Stand 12.11.2026.* Enthalten sind KLR und Deckungsbeitragsrechnung aus VL 1–2 sowie die neuen Unterlagen zu statischen Investitionsverfahren und kritischer Auslastung (unter anderem mit „VL 3.11“ markiert). Kapitel 2 erklärt Kosten-, Gewinn-, Rentabilitäts- und Amortisationsvergleich einschließlich der Rechenkonventionen und geprüften Quellenabweichungen. Der Quellenabgleich vom 12.11. ergänzt mehrstufige Deckungsbeiträge, Produktstreichung, Eigenfertigung/Fremdbezug und die Grenzen statischer Verfahren. Aufgaben mit vollständigen Lösungen stehen im Reiter „Lernen“. Dynamische Verfahren und technische Controllingkennzahlen sind weiterhin nicht belegt.
#src[K und Ü, PDF-S. 1–2; B31, PDF-S. 1–5; S32, PDF-S. 1–3; KR, PDF-S. 1–3; KD, PDF-S. 1–3; C09, PDF-S. 1–5.]

#pagebreak()
#heading(level: 1, outlined: false)[Wegweiser]
#block[
#set text(size: 9.5pt)
#set par(leading: 0.3em, spacing: 0.15em)
#outline(title: none, depth: 2, indent: auto)
]
#v(2mm)
#text(size: 8.5pt, fill: muted)[*Quellenkürzel:* W20 = „20 Aufgaben Deckungsbeitragsrechnung_202611110749_03307.pdf“ (3 PDF-Seiten, Originaldateiname mit zwei Leerzeichen nach „Aufgaben“); S11 = „Datei 11.pdf“ (3 PDF-Seiten); S12 = „Datei 12.pdf“ (7 PDF-Seiten); B27 = „031 Investitionsrechnung Beispiele Backofen.pdf“, 2 S.; B31 = gleichnamige Fassung mit Suffix „202611030745_48266“, 5 S.; S32 = „032 Aufgabe Investitionsrechnung_202611030745_19484.pdf“, 3 S.; KR = „Datei 04 .pdf“, 4 S., kritische Auslastung; KD = „Datei 05.pdf“, 3 S., Kapitaldienst und Aufgaben 20–21; C09 = „07  Controlling  Aufgaben_202611040747_40352.pdf“, 5 S., Blattüberschrift „09: Aufgaben: KVR, kritische Menge, Gewinnvergleichsrechnung“. Diese sechs Originale liegen unter „Unterlagen/Vorlesungsseiten mit Notizen/“. M = „KLR Skript eigenes Skript.pdf“, 2 S., vom 06.10.2026; K = „KLR.pdf“, 2 S., handschriftliche Grundlagen und VL-1-Übung; Ü = „VL2 Investition und Controlling.pdf“, 2 S., Blatt „08 Übungsaufgaben: KLR“ mit Notizen; Fotos Ü 2–4 = gleichnamige Originalfotos; F = „Formelsammlung.pdf“, 7 S.; A13 = „Controlling SS 13.pdf“; A14 = „Controlling WS 14-15.pdf“; A18 = „Controlling WS18-19.pdf“; L15 = „Stand 15.10.26_Lernskript_Investition.pdf“, 22 S.; L13 = Stand 13.10., 18 S.; L02 = „VL02_KLR_Grundlagen_Lernskript.pdf“, 15 S.; H = zugehörige frühere HTML-Skripte. Die alten Skripte liegen in „Zum Löschen/Alte Lernskript-Stände/“. „PDF-S.“ zählt ab der ersten Dateiseite. Alle „Nachschlagen“-Verweise führen mit automatisch berechneter Seite in dieses Lernskript. Eigene Erklärhilfen und Präzisierungen sind gekennzeichnet.]

#bild("map-ueberblick", [Die Denkkette des bisher behandelten Stoffs. Eigene Darstellung nach K und Ü, jeweils PDF-S. 1–2.], height: 47mm)

#pagebreak()
#heading(level: 1, outlined: false, bookmarked: false)[Das Modul auf einen Blick] <ueberblick>

Jeder Kasten ist ein Link: Tippe ihn an, um ins Kapitel oder in den Abschnitt zu springen. Graue Kästen stehen in der Gliederung, sind aber noch nicht behandelt.

#karte((1fr, auto, 1fr, auto, 1fr, auto, 1fr),
  chunk([Kapitel 1 · KLR und Deckungsbeitragsrechnung], [Bezugsgröße · fixe und variable Kosten · Deckungsbeitrag · Break-Even · Entscheidungen], ziel: <a-1>),
  pfeil(beschriftung: [Grundlage für]),
  chunk([Kapitel 2 · Statische Investitionsrechnung], [Kosten · Gewinn · Rentabilität · Amortisation · kritische Auslastung], ziel: <a-2>),
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
  chunk([1.9 Mehrere Produkte], [Fixkostenstufen · Produktstreichung · Eigenfertigung], ziel: <a-1-9>),
)

Das Modul fragt im Kern: *Lohnt sich das?* Kapitel 1 legt dafür das Werkzeug. Kapitel 2 nutzt es zum Vergleich von Investitionsalternativen und ergänzt Kapitalbindung und Rückflusszeit. Du trennst Kosten, die mit jedem Stück entstehen, von Kosten, die ohnehin anfallen. Der Deckungsbeitrag zeigt, was jedes Stück zur Deckung der Fixkosten beiträgt, und daraus folgen Gewinnschwelle und Entscheidungen. Die statischen Verfahren bauen auf dieser Trennung auf; ihre verschiedenen Maßstäbe werden in Kapitel 2 verbunden.
#src[Gliederung, PDF-S. 1–2; K und Ü, jeweils PDF-S. 1–2; B31, PDF-S. 1–5; KR, PDF-S. 1–3. Eigene Zusammenführung.]

#pagebreak()
= Kapitel 1 · KLR und #box[Deckungsbeitragsrechnung] <a-1>

#überblick([Kapitel 1 auf einen Blick],
  idee(<a-1-1>, [Erst die Bezugsgröße.], [Periode, Nettopreise und Stück oder Gesamtbetrag klären, bevor gerechnet wird.]),
  idee(<a-1-2>, [Kosten zerlegen.], [Fixe Kosten fallen ohnehin an, variable Kosten mit jedem Stück; daraus entstehen $K(x)$ und $k(x)$.]),
  idee(<a-1-4>, [Der Deckungsbeitrag verbindet Stück und Gewinn.], [Jedes Stück bringt $d = p - k_v$; erst wenn die Summe die Fixkosten deckt, entsteht Gewinn.]),
  idee(<a-1-5>, [Die Gewinnschwelle zeigt die nötige Menge.], [$x_"BEP" = K_f / d$, aber nur sinnvoll, wenn Kapazität und Nachfrage sie erlauben.]),
  idee(<a-1-6>, [Entscheiden heißt Änderungen vergleichen.], [Bei Preissenkung oder Zusatzauftrag zählt, wie sich Erlös und Kosten wirklich ändern.]),
  idee(<a-1-9>, [Fixkosten haben unterschiedliche Ebenen.], [Produkt, Gruppe und Gesamtbetrieb trennen; vermeidbare Kosten statt zugerechneter Verluste prüfen.]),
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

#note("Anschluss an das Modul", [Die Gliederung baut nach dieser Basis statische und dynamische Investitionsverfahren sowie Controlling auf. Schon jetzt kannst Du verstehen, warum eine neue Maschine fixe und variable Kosten verändern kann. Die statischen Verfahren folgen jetzt in Kapitel 2; dynamische Verfahren und weitere Controllingthemen bleiben bis zu belegten Vorlesungsunterlagen offen.])
#src[Ü 2–4, PDF-S. 2; K, PDF-S. 2, Rückwärtsaufgaben; Gliederung, PDF-S. 1–2; L15, PDF-S. 8–10 und 21–22; L02, PDF-S. 9–10 und 15. Geordneter Lösungsablauf: eigene Zusammenführung.]

#pagebreak()
== 1.9 Ergänzung 12.11. · Mehrere Produkte und entscheidungsrelevante Kosten <a-1-9>
Ein Produkt kann in der Vollkostenrechnung einen Verlust zeigen und trotzdem Geld zur Deckung gemeinsamer Kosten beitragen. Wie bei einer gemeinsam gemieteten Werkstatt verschwindet die Miete nicht automatisch, sobald ein Nutzer auszieht. Entscheidend ist, welche Erlöse und Kosten sich durch die Entscheidung tatsächlich ändern; die Analogie gilt nur für die dabei unveränderten gemeinsamen Kosten.

=== 1.9.1 Deckungsbeiträge nach Fixkostenstufen ordnen <a-1-9-1>
Bei der *mehrstufigen Deckungsbeitragsrechnung* werden Fixkosten nach ihrer Zugehörigkeit abgezogen. *Produktfixkosten* sind einem bestimmten Erzeugnis direkt zugeordnet; *Produktgruppenfixkosten* fallen gemeinsam für eine Gruppe an; *Unternehmensfixkosten* gehören zum gesamten Betrieb.
#bild("db-stufentreppe", [Fixkosten vom Produkt bis zum Betrieb zuordnen. Eigene Darstellung nach W20, PDF-S. 3, Aufgabe 5.], height: 51mm)
#form[$ D B_("I",j)=E_j-K_(v,j) quad D B_("II",j)=D B_("I",j)-K_(f,"Produkt",j) $]
#form[$ D B_("III",g)=sum_(j "in" g) D B_("II",j)-K_(f,"Gruppe",g) quad G=sum_g D B_("III",g)-K_(f,"Unternehmen") $]
Alle DB und Fixkosten in €/Periode; j bezeichnet das Produkt, g die Gruppe. Jede Kostenposition wird einmal auf der passenden Ebene abgezogen. Die Zählung ist eine *Konvention des Schemas*: Das einstufige Blatt nennt bereits den Betrag nach sämtlichen Fixkosten „DB II“; im mehrstufigen Schema bleiben danach noch Gruppen- und Unternehmensfixkosten abzuziehen.

=== 1.9.2 Ein Produkt streichen: Was fällt wirklich weg? <a-1-9-2>
Ein negativer Vollkostengewinn ist noch kein Beweis, dass ein Produkt gestrichen werden sollte. Sind ihm gemeinsame Fixkosten zugerechnet, bleiben diese bei der Streichung bestehen. Ohne Absatzverschiebungen zu anderen Produkten und ohne Kapazitätsalternative gilt:
#form[$ Delta G_"Streichung"=K_(f,"vermeidbar")-D B_("I","entfallend") $]
Ein positiver DB, der verloren geht, verschlechtert das Ergebnis, solange dadurch keine ausreichend großen Kosten vermieden werden. *Zurechenbar* bedeutet nicht automatisch *sofort abbaubar*: Kündigungsfristen, Restbindungen und der betrachtete Zeitraum bestimmen die Vermeidbarkeit. Im Blatt W20, Aufgabe 2 bleiben die gemeinsamen Fixkosten als Modellannahme bestehen.

=== 1.9.3 Eigenfertigung, Fremdbezug und Prioritäten <a-1-9-3>
Bei *Eigenfertigung oder Fremdbezug* wird dieselbe Bedarfsmenge entweder selbst hergestellt oder gekauft. Bei freier Kapazität und unveränderten Fixkosten vergleichst du den Einstandspreis mit den zusätzlich entstehenden Fertigungskosten. Ein bereits verrechneter Fixkostenanteil pro Stück ist dann kein zusätzlicher Geldabfluss.
#form[$ "Vorteil Eigenfertigung"=(e_"Bezug"-k_v)x-K_(f,"zusätzlich") $]
Beträge in €/Periode; Einstandspreis und variable Kosten in €/Stück. Voraussetzung: gleiche Qualität, Lieferbedingungen, geeignete Kapazität und keine verdrängte bessere Alternative. Bei knapper Kapazität gehören entgehende Deckungsbeiträge als *Opportunitätskosten* in den Vergleich.
#note("Reihenfolge braucht einen Maßstab", [Eine Rangliste nach Stück-DB ist nur eine Rangliste in €/Stück. Ohne Engpass und ohne Angaben über den Ressourcenverbrauch ist daraus kein notwendiger Produktionsablauf ableitbar. Bei einem einzigen Engpass lautet der passende Maßstab $d b_I$ je benötigter Engpasseinheit, etwa €/Maschinenstunde. W20, Aufgabe 5 verlangt eine Reihenfolge, gibt aber keinen Engpass an; die ausgewiesene Stück-DB-Reihenfolge ist deshalb ausdrücklich eine konventionelle Rechenrangliste.], fill: sand)
#bild("map-db-stufen", [Mindmap: Kostenebenen und Entscheidungen. Eigene Darstellung nach W20, PDF-S. 1–3.], height: 46mm)
#src[W20, Aufgaben 1–5 auf PDF-S. 1 und 3; Mitschrift zur Produktstreichung auf PDF-S. 2. Stufenbezeichnungen und Entscheidungsdifferenzen hergeleitet; Voraussetzungen zur Vermeidbarkeit und Engpassrangfolge ergänzend präzisiert.]
#hoch(<a-1>, [Kapitelübersicht])

#block(breakable: false)[
*Der Zusammenhang in Kapitel 1.* Erst klärst Du Periode und Bezugsgröße. Dann zerlegst Du Kosten und bildest Kosten- und Erlösfunktion. Der Stückdeckungsbeitrag verbindet jede einzelne Einheit mit dem gesamten Gewinn. Die Gewinnschwelle zeigt die nötige Menge; Kapazität und Nachfrage zeigen, ob sie erreichbar ist. Bei Entscheidungen prüfst Du schließlich die tatsächliche Änderung und ihre Bedingungen. Mehrere Produkte teilen sich gemeinsame Fixkosten; die Stufenrechnung trennt die Ebenen, während der Veränderungsvergleich entscheidet, welche Beiträge oder Kosten wirklich entfallen.
#src[Zusammenführung aus M und K, jeweils PDF-S. 1–2, sowie Ü 1–4, PDF-S. 1–2. Eigene Darstellung.]

]
#hoch(<a-1>, [Kapitelübersicht])

#pagebreak()
= Kapitel 2 · Statische Investitionsrechnung <a-2>

#überblick([Kapitel 2 auf einen Blick],
  idee(<a-2-1>, [Jahreskosten aufbauen.], [Anschaffung, Abschreibung und Kapitalbindung sauber trennen.]),
  idee(<a-2-2>, [Kosten vergleichen.], [Gleiche Leistung und passende Mengenbasis herstellen.]),
  idee(<a-2-3>, [Gewinn vergleichen.], [Unterschiedliche Erlöse und Absatzmengen berücksichtigen.]),
  idee(<a-2-4>, [Rentabilität vergleichen.], [Erfolg auf das durchschnittlich gebundene Kapital beziehen.]),
  idee(<a-2-5>, [Amortisation und Aussagegrenzen prüfen.], [Die Rückflusszeit und die Grenzen des Jahresmodells unterscheiden; Ergänzung 2.7.]),
  idee(<a-2-6>, [Kritische Auslastung.], [Den Mengenbereich finden, in dem eine Alternative günstiger ist.]),
)
#ablauf(
  chunk([Daten und Vergleichsbasis], [Jahr · Menge · Nutzungsdauer · Restwert], ziel: <a-2-1>),
  chunk([Kosten → Erlöse → Gewinn], [KVR und GVR], ziel: <a-2-2>),
  chunk([Kapital und Rückfluss], [RVR und AVR], ziel: <a-2-4>),
  chunk([Entscheidung mit Grenzen], [kritische Menge · Absatz · Aussage des Verfahrens], ziel: <a-2-6>),
)
#hoch(<ueberblick>, [Modul auf einen Blick])

Eine Maschine kostet beim Kauf Geld, beeinflusst aber viele spätere Jahresergebnisse. Die *statischen Verfahren* verdichten diese Folgen auf eine repräsentative Jahresrechnung mit Durchschnittswerten. Du baust zunächst dieselbe Kostenbasis auf und wechselst dann die Frage: weniger Kosten, mehr Gewinn, höhere Verzinsung oder schnellere Rückgewinnung?
#src[B31, PDF-S. 1–5; S32, PDF-S. 1–3; KD, PDF-S. 1–3. Einordnung und Denkkette: eigene Zusammenführung.]

== 2.1 Anschaffung, Kapitalkosten und Betriebskosten <a-2-1>

Die *Anschaffungskosten* $A K$ sind der Kaufbetrag. Die *kalkulatorische Abschreibung* $A$ verteilt den Wertverbrauch auf die Nutzungsdauer $n$. Die *kalkulatorischen Zinsen* $Z$ bewerten das gebundene Kapital mit dem vorgegebenen Zinssatz $i$; sie sind hier keine zusätzlich belegte Bankzahlung.

#form[$ A=(A K-R W)/n quad overline(K)_"geb"=(A K+R W)/2 quad Z=overline(K)_"geb" dot i $]
$A K,R W,overline(K)_"geb"$: €; $A,Z$: €/Jahr; $n$: Jahre; $i$: Zinssatz pro Jahr als Dezimalzahl. $R W$ ist der Restwert am Ende. Gültig bei linearer Abschreibung und dem in den Unterlagen verwendeten durchschnittlichen Kapitalverlauf. Bei $R W=0$ bindest Du im Mittel $A K/2$. In S32 ist diese Hälfte ausdrücklich vorgegeben; mangels eines anderen Restwerts wird dort für die Abschreibung $R W=0$ angenommen.

#karte((1fr, auto, 1fr),
  chunk([Kapitalkosten / Kapitaldienst], [$K D = A + Z$ · €/Jahr]),
  pfeil(zeichen: sym.plus),
  chunk([Betriebskosten], [$B K = K_(f,"sonst") + k_v x$ · €/Jahr]),
)
#form[$ K(x)=K D+B K=A+Z+K_(f,"sonst")+k_v x quad K_f=A+Z+K_(f,"sonst") $]
$x$: Stück/Jahr; $k_v$: €/Stück. In diesen Blättern bedeutet *Kapitaldienst* Abschreibung plus kalkulatorische Zinsen. Die Betriebskosten enthalten hier beides noch nicht. Ein vorgegebener Kapitaldienst wird deshalb *einmal* addiert; Abschreibung und Zinsen danach nicht nochmals aufschlagen.

#note("★ Klausur · von Dir markiert", [In KD, PDF-S. 2 steht: „Abschreibungen u. Zinsen fehlen hier noch! Muss man in der Klausur wissen!“ Gemeint sind die dortigen Betriebskosten. Prüfe stets, ob „fixe Kosten“ nur die *sonstigen* Fixkosten oder bereits den gesamten Fixkostenblock bezeichnen.])
#bild("map-investitionskosten", [Mindmap: vom Kaufbetrag zu den Jahreskosten. Eigene Darstellung nach B31, PDF-S. 2, und KD, PDF-S. 2–3.], height: 46mm)
#note("Restwert wirkt auf zwei Größen", [Ein höherer Restwert senkt den abschreibbaren Betrag, erhöht aber die durchschnittliche Kapitalbindung. Abschreibung und kalkulatorische Zinsen verändern sich deshalb gegenläufig. S11, PDF-S. 1, variiert genau diese beiden Größen.])
#src[B31, PDF-S. 1–2; S32, PDF-S. 1–2; KD, PDF-S. 1–3, besonders markierte Abgrenzung auf S. 2. Symbolwahl und Abgrenzung zur Bankzahlung: eigene Erklärung.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.2 Kostenvergleichsrechnung: dieselbe Leistung vergleichen <a-2-2>

Die *Kostenvergleichsrechnung (KVR)* bevorzugt die Alternative mit den geringeren Kosten. Das ist aussagekräftig, wenn die verglichene Leistung gleichwertig ist und Erlösunterschiede keine Rolle spielen. Sonst kann gerade die teurere Anlage den höheren Gewinn erzielen.
#form[$ K_j(x)=K_(f,j)+k_(v,j)x quad k_j(x)=K_j(x)/x $]
$K_j$: €/Jahr; $k_j$: €/Stück; $j$: Alternative. Bei gleicher Jahresmenge liefern Gesamt- und Stückkosten dieselbe Rangfolge. Bei verschiedenen Mengen brauchst Du eine bewusste Vergleichsbasis: Stückkosten zeigen die Kosten je Leistungseinheit, ersetzen aber keinen Vergleich der gesamten Erlöse und Gewinne.

#tab(columns: (1.7fr, 1fr, 1fr),
 th([Backofen-Beispiel], [Normalo-Back], [Back de luxe]),
 [$K_f$ in €/Jahr], [7 320], [12 430],
 [$k_v$ in €/Brötchen], [0,12], [0,09],
 [$K(100 000)$ in €/Jahr], [19 320], [21 430],
 [$k$ bei 100 000 bzw. 150 000 Stück/Jahr], [0,1932 €/Stück], [0,172866… €/Stück],
)
Die letzte Zeile gehört zum *anderen Mengenfall* aus Aufgabe 24: Der Normalo-Back schafft nur 100 000 Brötchen/Jahr, Back de luxe 150 000. Niedrige Stückkosten und eine ausreichende Kapazität sprechen dort für Back de luxe. Bei 100 000 gleichen Brötchen ist dagegen der Normalo-Back um 2 110 €/Jahr günstiger.

#note("Gültigkeit", [Ein einzelnes Angebot mit bekannten Kosten, aber ohne Erlös, Vergleichsangebot oder Kostenobergrenze lässt noch kein Urteil „lohnt sich“ zu. Genau diese Grenze nennt KD, PDF-S. 2. Ein positiver Gewinn einschließlich kalkulatorischer Zinsen ist eine andere, weitergehende Aussage.], fill: sand)
#bild("map-kvr", [Mindmap: Kostenvergleich braucht eine passende Leistungsbasis. Eigene Darstellung nach B31, PDF-S. 1–3, und KD, PDF-S. 1–3.], height: 46mm)
#src[B31, Aufgaben 23–24, PDF-S. 1–3; B27, PDF-S. 1–2 als zusätzliche Mitschrift desselben Beispiels; KD, Aufgaben 20–21, PDF-S. 1–3; S32, PDF-S. 1–2. Vergleichsbedingungen: eigene Präzisierung.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.3 Gewinnvergleichsrechnung: Qualität und Menge zählen mit <a-2-3>

Die *Gewinnvergleichsrechnung (GVR)* nimmt die Erlöse hinzu. Ein besseres Produkt kann einen höheren Preis erzielen; ein leistungsfähigerer Ofen kann mehr verkaufbare Stücke ermöglichen. Deshalb reicht „billiger“ als Investitionsurteil nicht immer aus.
#form[$ E_j=e_j x_j quad G_j=E_j-K_j=(e_j-k_(v,j))x_j-K_(f,j) $]
$e_j$: Nettoerlös in €/Stück; $x_j$: hergestellte und verkaufte Stück/Jahr; $G_j$: €/Jahr, hier *nach* kalkulatorischen Zinsen. Für die relative Wahl wird der höhere Jahresgewinn bevorzugt. $G>0$ bedeutet in diesem Kostenmodell, dass auch die vorgegebene kalkulatorische Verzinsung verdient wurde.

*Gleiche Menge:* Beim Backofenfall 25 stehen 100 000 Brötchen zu 0,25 € den 100 000 Vollkornbrötchen zu 0,30 € gegenüber. Back de luxe hat höhere Kosten, erzielt aber den höheren Gewinn. *Verschiedene Mengen:* Beim Pizzafall vergleichst Du die tatsächlich absetzbaren 50 000 Pizzas aus Roma mit 40 000 aus Florenz über die gesamten Jahresgewinne.
#bild("map-gvr", [Mindmap: erst verkaufbare Menge, dann Erlös und vollständige Kosten. Eigene Darstellung nach B31, PDF-S. 3, und C09, PDF-S. 3–4.], height: 46mm)
#note("Fehler vermeiden", [Gewinn je Stück und Jahresgewinn sind bei unterschiedlichen Mengen verschiedene Maßstäbe. Für die gesamte Investitionsalternative zählt in der GVR der *gesamte Jahresgewinn*. Eine hohe Produktionskapazität wird erst durch Absatz zu Erlös.], fill: sand)
#src[B31, Aufgaben 24–25 und Verfahrensübersicht, PDF-S. 1, 3 und 5; S32, PDF-S. 1–2; C09, PDF-S. 1–4. Positive-Gewinn-Aussage und Mengenabgrenzung: eigene Erklärung.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.4 Rentabilität und Differenzinvestition <a-2-4>

Die *Rentabilitätsvergleichsrechnung (RVR)* fragt nach dem Jahreserfolg je Euro durchschnittlich gebundenem Kapital. Sie setzt eine Erfolgsgröße zu einer Kapitalgröße ins Verhältnis. Wenn im Jahresgewinn die kalkulatorischen Zinsen bereits abgezogen sind, werden sie für die hier verwendete Verzinsung des gesamten gebundenen Kapitals wieder hinzugerechnet.
#form[$ R=(G+Z)/overline(K)_"geb" dot 100 % $]
$G,Z$: €/Jahr; $overline(K)_"geb"$: €; $R$: % pro Jahr. Prüfe die Gewinnabgrenzung: Ist ein Gewinn *vor* kalkulatorischen Zinsen gegeben, darfst Du $Z$ nicht nochmals addieren. Die Mitschrift nennt daneben Eigenkapital- und Umsatzrendite; diese Nenner beantworten andere Fragen und werden hier nicht mit der Investitionsrentabilität vermischt.

#bild("map-rvr", [Mindmap: Zähler, Nenner und Alternativverwendung abstimmen. Eigene Darstellung nach B31, PDF-S. 4–5, und S32, PDF-S. 2–3.], height: 46mm)

Bei ungleichen Anschaffungskosten bleibt bei der billigeren Anlage Kapital frei. Die *Differenzinvestition* legt fest, was dieses Geld alternativ erwirtschaftet. Für ein gleiches Gesamtbudget vergleichst Du „billigere Anlage plus Alternative“ mit der teureren Anlage. Dadurch kann sich die Rangfolge gegenüber den isolierten Prozentsätzen ändern.
#form[$ R_("1+Diff")=(G_1+Z_1+g_"Diff")/(overline(K)_1+overline(K)_"Diff") dot 100 % $]
$g_"Diff"$ ist hier der ausdrücklich gegebene jährliche Ertrag der Zusatzanlage, passend zur Erfolgsgröße vor kalkulatorischen Zinsen. Die Halbierung ihres Anschaffungsbetrags als durchschnittliche Bindung folgt in den vorliegenden Mitschriften demselben Modell; sie ist keine allgemeine Regel für jede Geldanlage.

#note("Quelle sichtbar geprüft · Backofen 26", [Der Aufgabentext B31, PDF-S. 1 nennt für die 14 000 € Differenz einen Ertrag von *2 000 €*. Auf S. 4 stehen stattdessen 1 000 € und das Ergebnis 52,9 %. Beides passt nicht zusammen: $(6400+1000)/16000 dot 100 %="46,25" %$. Mit dem ausdrücklich vorgegebenen Ertrag 2 000 €/Jahr sind es *52,50 %*. Back de luxe erreicht 61,5625 % und bleibt in beiden Varianten vorn. Die Halbierung des Kapitalbetrags halbiert nicht automatisch den vorgegebenen Ertrag.], fill: sand)
#block(breakable: false)[
=== 2.4.1 Renditebegriffe: der Nenner verrät die Frage <a-2-4-1>

Die Randübersicht auf B31, S. 5 nennt drei weitere Bezugsgrößen. *Eigenkapital* ist der von den Eigentümern bereitgestellte Teil, *Gesamtkapital* umfasst Eigen- und Fremdkapital; *Umsatz* ist der Verkaufserlös. Benenne stets, welche Gewinnabgrenzung zum verwendeten Nenner passt.
#tab(columns: (1.4fr, 1.7fr, 2.2fr),
 th([Kennzahl], [Bezugsgröße], [Was wird verglichen?]),
 [Eigenkapitalrendite], [durchschnittliches Eigenkapital], [Gewinn für die Eigentümer nach Fremdkapitalzinsen je Euro Eigenkapital],
 [Gesamtkapitalrendite], [durchschnittliches Gesamtkapital], [Erfolg vor Fremdkapitalzinsen je Euro Gesamtkapital],
 [Umsatzrendite], [Umsatz derselben Periode], [Gewinnanteil je Euro Umsatz; Gewinnabgrenzung benennen],
)
#form[$ R_"Umsatz"=G/E dot 100 % $]
$G,E$: €/Jahr; $R_"Umsatz"$: %. Voraussetzung: dieselbe Periode und klar abgegrenzter Gewinn. Für die Kapitalrenditen gilt entsprechend Erfolg geteilt durch die genannte durchschnittliche Kapitalbasis mal 100 %. Die Mitschrift schreibt allgemein „Gewinn“; die passende Zinsabgrenzung ist hier ausdrücklich ergänzt.
#note("Fehler vermeiden", [Die Pfeilnotiz „Cashflow“ unter der Umsatzrendite in B31, S. 5 ist keine Gleichsetzung: Eine Rendite ist ein *Verhältnis in Prozent*, ein Cashflow ein *Zahlungsüberschuss in Euro pro Periode*. Abschreibungen, kalkulatorische Zinsen und die tatsächlichen Zahlungen machen diese Größen verschieden.], fill: sand)
]
#src[B31, Aufgabe 26, PDF-S. 1 und 4, ergänzende Renditebegriffe S. 5; S32, Differenzinvestition, PDF-S. 2–3. Quellenabweichung und Rechnung mit dem gedruckten Ertrag: eigene Prüfung; Jahresbezug des Ertrags als statische Modellannahme.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.5 Amortisation: wann ist der Kaufbetrag zurück? <a-2-5>

Die *Amortisationsvergleichsrechnung (AVR)* fragt nach der Zeit, bis laufende Rückflüsse den eingesetzten Betrag rechnerisch ausgeglichen haben. Eine kürzere Zeit bedeutet in dieser Betrachtung eine schnellere Kapitalrückgewinnung. Sie ist kein Beweis für den größten Gewinn über die gesamte Nutzungsdauer.

#form[$ t_"A"=(A K-R W)/overline(r) quad overline(r)=G+A quad ("Rechenkonvention B31") $]
$t_"A"$: Jahre; $overline(r)$: durchschnittlicher jährlicher Rückfluss in €/Jahr. In Aufgabe 27 ist $R W=0$ und die Mitschrift rechnet mit $G+A$, wobei $G$ aus der GVR nach kalkulatorischen Zinsen stammt. Abschreibung wird addiert, weil sie den Gewinn mindert, aber im jeweiligen Jahr keine Auszahlung ist.

#bild("amortisationsverlauf", [Rechnerisch kumulierter Rückfluss der Backöfen, Konvention B31. Eigene Darstellung nach B31, PDF-S. 4.], height: 56mm)
#note("Gültigkeit · Gewinn ist nicht automatisch Cashflow", [Die Unterlagen verwenden mit $G+A$ eine vereinfachte Rückflussgröße *nach kalkulatorischen Zinsen*. Für einen Rückfluss vor diesen rein kalkulatorischen Zinsen wäre bei sonst zahlungswirksamen Jahrespositionen $G+A+Z$ anzusetzen. Dann ergeben sich andere Zeiten. Hier bleibt die Vorlesungskonvention ausdrücklich benannt; beide Abgrenzungen dürfen nicht unbemerkt vermischt werden.], fill: sand)

Die Durchschnittsmethode verlangt einen positiven, repräsentativen Jahresrückfluss. Vergleiche die Zeit mit der Nutzungsdauer und gegebenenfalls einer vorgegebenen Höchstzeit. Die Methode lässt die zeitliche Lage einzelner Zahlungen und den Erfolg nach dem Amortisationszeitpunkt außer Betracht; sie dient deshalb als zusätzliche Betrachtung von Kapitalbindung und Risiko.
#note("Quelle sichtbar korrigiert · S32", [Auf S32, PDF-S. 3 steht nur „AVR = gleich“. Die vollständig gerechneten Zeiten sind mit derselben Konvention *2,7752 Jahre für A* und *2,7314 Jahre für B*. Sie sind nahe beieinander, aber nicht gleich. B amortisiert sich etwas schneller.], fill: sand)
#src[B31, Aufgabe 27, PDF-S. 1 und 4–5; S32, Aufgabenstellung S. 1 und Kurznotiz S. 3. Vollständige Rechnung, Cashflow-Abgrenzung und Verfahrensgrenzen: eigene ergänzende Erklärung.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.6 Kritische Auslastung: wann wechselt der Kostenvorteil? <a-2-6>

Eine teurere Maschine kann höhere Fixkosten, aber geringere Kosten je Stück haben. Bei geringer Menge überwiegt der feste Block; bei hoher Menge die Ersparnis pro Stück. Die *kritische Auslastung* ist hier die Jahresmenge, bei der *zwei Alternativen dieselben Kosten* haben.
#form[$ K_1(x)=K_2(x) => K_(f,1)+k_(v,1)x=K_(f,2)+k_(v,2)x $]
#form[$ x_"krit"=(K_(f,2)-K_(f,1))/(k_(v,1)-k_(v,2)) $]
$x_"krit"$: Stück/Jahr. Voraussetzungen: dieselbe Jahresmenge für beide Alternativen, gültige lineare Kostenfunktionen, unterschiedliche variable Stückkosten und ein Schnittpunkt im machbaren Mengenbereich. Bei gleichen Steigungen gibt es entweder keinen Schnittpunkt oder zwei identische Kostenlinien.

#bild("kritische-auslastung", [Kostenvergleich aus KR, PDF-S. 2–3. Eigene Darstellung mit exaktem Schnittpunkt.], height: 60mm)

*Einheiten zuerst:* Die 295 000 bzw. 326 000 € sind *variable Jahreskosten bei 20 000 Stück*. Erst die Division durch 20 000 liefert 14,75 bzw. 16,30 €/Stück. Ein Gesamtbetrag in €/Jahr gehört nicht als Steigung an $x$.
#note("Quelle sichtbar korrigiert", [KR rundet die Schwelle $17000/"1,55"="10 967,7419…"$ auf 10 968 Stück. Genau bei *10 968* ist Objekt 1 bereits um 0,40 €/Jahr günstiger. Daher: Objekt 2 bis einschließlich 10 967, Objekt 1 ab 10 968; nur am nicht ganzzahligen exakten Schnittpunkt sind beide gleich. Die Randnotiz auf KR, S. 3 begründet den Vorteil bei 18 000 mit niedrigeren Fixkosten; tatsächlich hat Objekt 1 *höhere* Fixkosten und *niedrigere variable Stückkosten*.], fill: sand)

#tab(columns: (1.3fr, 2fr, 2fr),
 th([Schnittpunkt], [Gleichgesetzt], [Bedeutung]),
 [Gewinnschwelle], [$E(x)=K(x)$ einer Anlage], [$G=0$, siehe 1.5],
 [Kritische Kostenmenge], [$K_1(x)=K_2(x)$], [Wechsel des Kostenvorteils],
 [Kritische Gewinnmenge], [$G_1(x)=G_2(x)$], [Wechsel des Gewinnvorteils],
)
Bei gleichem Stückerlös und gleicher Menge fällt der Erlös im Gewinnvergleich heraus: Kosten- und Gewinnvergleich haben dann dieselbe kritische Menge. Bei unterschiedlichen Erlösen musst Du die *Gewinnfunktionen* gleichsetzen. Die kritische Menge ist also nicht automatisch die Gewinnschwelle.
#bild("map-kritisch", [Mindmap: Gleichsetzen, Bereich prüfen und richtig entscheiden. Eigene Darstellung nach KR, PDF-S. 1–3, und C09, PDF-S. 1–2 und 5.], height: 46mm)
#src[KR, PDF-S. 1–3; S. 4 enthält nur die Überschrift „Aufgaben“, keinen weiteren Aufgabentext. C09, PDF-S. 1–2 und 5. Exakte Rundungsgrenze, Randfälle und Unterscheidung der Schnittpunkte: eigene algebraische Prüfung.]
#hoch(<a-2>, [Kapitelübersicht])


#pagebreak()
== 2.7 Ergänzung 12.11. · Statische Verfahren richtig vergleichen <a-2-7>
Statische Verfahren sind schnell, weil sie den Zeitverlauf stark vereinfachen. Ein typisches Jahr oder ein Jahresdurchschnitt kann eine erste Auswahl ermöglichen, zeigt aber nicht automatisch, wie groß der Vorteil über alle Jahre und zu welchem Zeitpunkt er verfügbar ist.
#tab(columns: (1.2fr,2.3fr,2.2fr), th([Prüfung],[Was du festlegen musst],[Was sonst schiefgeht]),
[Leistung],[Gleiche Menge und Qualität oder bewusst Stückkosten/Gewinne vergleichen.],[Eine größere Kapazität wird ungeprüft als verkaufte Menge gewertet.],
[Zeitraum],[Repräsentatives Jahr, konstante bzw. passend gemittelte Daten.],[Frühe und späte Zahlung werden gleich behandelt.],
[Kostenbasis],[Abschreibung, kalkulatorische Zinsen und sonstige Kosten vollständig und einmal zählen.],[Kapitalkosten fehlen oder werden doppelt addiert.],
[Entscheidungsfrage],[Geringste Kosten, höchster Gewinn, passende Rendite oder Rückflusszeit.],[Ein Verfahren beantwortet eine andere Frage als die gestellte.])
#note("S11 sprachlich präzisieren", [S11, PDF-S. 1, schreibt pauschal, statische Verfahren berücksichtigten „keine Verzinsung des eingesetzten Kapitals“. Das passt nicht zur unmittelbar folgenden Berechnung kalkulatorischer Zinsen. Präzise ist: Die Verfahren erfassen hier *keine periodengenaue Auf- und Abzinsung der einzelnen Zahlungen*. Kalkulatorische Zinsen werden im Jahreskostenmodell sehr wohl berücksichtigt.], fill: sand)

Beim *Ersatzvergleich* wird der Gewinn mit neuem Objekt dem Gewinn mit altem Objekt gegenübergestellt. Für die gleiche verkaufte Menge gilt:
#form[$ Delta G=[(e_"neu"-k_(v,"neu"))-(e_"alt"-k_(v,"alt"))]x-(K_(f,"neu")-K_(f,"alt")) $]
Die Formel fasst zwei bekannte Gewinnfunktionen zusammen. Sie beantwortet den statischen Jahresvergleich bei der jeweils vorgegebenen vollständigen Kostenbasis, keine zusätzliche dynamische Kapitalwertfrage.
#note("Quelle S12: zwei verschiedene Schnittpunkte", [Der Kostenvergleich auf S12, PDF-S. 3, nennt zunächst die Anlagen A/C, fragt im nächsten Satz aber nach A/B. Beide Fälle sind in der Aufgabenlösung getrennt: A/C kostengleich bei 6 250 Stück; A/B bei 5 833,33… Stück. Im Gewinnvergleich A/C auf PDF-S. 5 sind es dagegen 5 000 Stück, weil dort unterschiedliche Erlöse gelten. Die kritische Menge ist außerdem keine Gewinnschwelle.], fill: sand)
#src[S11, PDF-S. 1–3; S12, PDF-S. 1–7, besonders unterschiedliche Auslastungen S. 3, Gewinnvergleich S. 4–5 und Ersatzvergleich S. 6. Präzisierungen und algebraische Zusammenführung: eigene Darstellung.]
#hoch(<a-2>, [Kapitelübersicht])

*Der Zusammenhang in Kapitel 2.* Die Jahreskosten aus Abschreibung, Zinsen und Betriebskosten sind die gemeinsame Basis. Die KVR vergleicht Kosten, die GVR ergänzt Erlöse. Die RVR setzt den passend abgegrenzten Erfolg zur Kapitalbindung ins Verhältnis; eine Differenzinvestition stellt die Budgetverwendung vergleichbar her. Die AVR betrachtet die Rückgewinnungszeit. Kritische Mengen zeigen schließlich, ob ein Urteil auch bei einer anderen Auslastung Bestand hat. Die Verfahren beantworten unterschiedliche Fragen und können deshalb zu unterschiedlichen Empfehlungen führen.
#src[B31, PDF-S. 1–5; S32, PDF-S. 1–3; KD, PDF-S. 1–3; KR, PDF-S. 1–3; C09, PDF-S. 1–5. Eigene Zusammenführung.]

#pagebreak()
= Anhang
== Formelsammlung mit Voraussetzungen

Alle Beträge und Mengen beziehen sich innerhalb einer Rechnung auf dieselbe Periode. Die erste Tabelle betrifft das lineare Einproduktmodell aus Kapitel 1; die zweite die statischen Investitionsverfahren aus Kapitel 2. Für die KLR gilt das lineare Einproduktmodell; für einen gegebenen Mehrproduktfall werden die Gesamt-DB addiert und gemeinsame Fixkosten einmal abgezogen.

=== Formeln zu Kapitel 1 · KLR und Deckungsbeitragsrechnung

#tab(columns: (1.35fr, 2fr, 2fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Kosten], [$K_v=k_v x$; $K=K_f+k_v x$], [proportionales $K_v$; gleiches $K_f,k_v$ im Bereich; €/Periode],
 [Stückkosten], [$k_f=K_f/x$; $k=K/x=k_f+k_v$], [$x>0$; €/Stück],
 [Nettopreis], [$e_"netto"=e_"brutto"/(1+s)$], [$s$ als Dezimalzahl vorgegeben; in Ü 4: 0,19],
 [Erlös], [$E(x)=e x$], [$e$ netto; vollständiger Absatz der Menge $x$],
 [Gewinn], [$G(x)=E(x)-K(x)$], [Vorzeichen; €/Periode],
 [Deckungsbeitrag I], [$d b_"I"=e-k_v$; $D B_"I"=d b_"I" x=E-K_v$], [Stück-DB €/Stück; Gesamt-DB €/Periode],
 [DB mehrstufig], [$D B_("II",j)=D B_("I",j)-K_(f,"Produkt",j)$; $D B_("III",g)=sum_(j "in" g)D B_("II",j)-K_(f,"Gruppe",g)$], [€/Periode; danach Unternehmensfixkosten einmal abziehen; W20 PDF-S. 3.],
 [Produkt streichen], [$Delta G=K_(f,"vermeidbar")-D B_("I","entfallend")$], [Keine Verlagerungen oder alternativen Kapazitätsbeiträge; Zeitraum nennen.],
 [Eigenfertigungsvorteil], [$(e_"Bezug"-k_v)x-K_(f,"zusätzlich")$], [Gleiche Bedarfsdeckung, freie Kapazität; positive Differenz spricht für Eigenfertigung.],
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
#src[W20, PDF-S. 1–3; M und K, jeweils PDF-S. 1–2; Ü 1–4, PDF-S. 1–2; F, PDF-S. 5; L15, PDF-S. 19 und L02, PDF-S. 15. Zusammenstellung, Zielgewinn-Umstellung und Gültigkeitspräzisierungen: eigene Darstellung.]

#note("Wichtige Zahlen", [*Ü 1:* $K_f=20 000$ €/Monat, $k_v=30$ €/Packung, $e=70$ €/Packung → Stück-DB 40 €, BEP 500 Packungen, $G(800)=+12 000$ €. *Ü 4:* 214,20 € brutto / 1,19 = 180 € netto; Stück-DB 70 €; exakte Schwelle 914,2857… Regale, kleinste ganze Menge 915. *Prozent:* 85 % = 0,85. Zahlen sind Aufgabenwerte, keine allgemeinen Betriebskennzahlen.])
#src[Ü 1 und 4, PDF-S. 1–2; Foto Ü 4; Werte nachgerechnet.]


=== Formeln zu Kapitel 2 · Statische Investitionsrechnung

#tab(columns: (1.35fr, 2fr, 2fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Abschreibung], [$A=(A K-R W)/n$], [linear; €/Jahr],
 [Mittlere Kapitalbindung], [$overline(K)_"geb"=(A K+R W)/2$], [linearer Kapitalabbau; €; S32 gibt $A K/2$ vor],
 [Kalkulatorische Zinsen], [$Z=overline(K)_"geb" i$], [$i$ pro Jahr als Dezimalzahl; €/Jahr],
 [Kapitaldienst], [$K D=A+Z$], [Begriffsverwendung der vorliegenden Blätter; €/Jahr],
 [Betriebskosten], [$B K=K_(f,"sonst")+k_v x$], [hier ohne Abschreibung/Zinsen; €/Jahr],
 [Gesamtkosten], [$K=K D+B K$], [Kapitaldienst genau einmal; €/Jahr],
 [Gewinn], [$G=e x-K$], [verkaufbare Menge; hier nach kalkulatorischen Zinsen],
 [Ersatz-Gewinndifferenz], [$(d b_"neu"-d b_"alt")x-(K_(f,"neu")-K_(f,"alt"))$], [Gleiche Menge und vollständige jeweilige Kostenbasis; S12 PDF-S. 6.],
 [Rentabilität], [$R=(G+Z)/overline(K)_"geb" dot 100 %$], [Zähler vor kalkulatorischen Zinsen; % pro Jahr],
 [Umsatzrendite], [$R_"Umsatz"=G/E dot 100 %$], [gleiche Periode, $E>0$; Gewinnabgrenzung benennen],
 [Amortisation], [$t_"A"=(A K-R W)/(G+A)$], [Konvention B31, konstanter positiver Jahresrückfluss; Jahre],
 [Rückfluss vor kalk. Zinsen], [$overline(r)_"vor Z"=G+A+Z$], [ergänzende Abgrenzung; andere Jahrespositionen zahlungswirksam],
 [Kritische Kostenmenge], [$x_"krit"=(K_(f,2)-K_(f,1))/(k_(v,1)-k_(v,2))$], [gleiche Menge, ungleiche Steigungen, machbarer Bereich; Stück/Jahr],
)
#src[B31, PDF-S. 1–5; S32, PDF-S. 1–3; KD, PDF-S. 1–3; KR, PDF-S. 1–3. Abgrenzungen wie in Kapitel 2.]
#note("Wichtige Zahlen · Investitionsrechnung", [*Backöfen bei 100 000 Stück:* Kosten 19 320 / 21 430 €/Jahr; bei Preisen 0,25 / 0,30 € Gewinne 5 680 / 8 570 €/Jahr. *KR:* exakte kritische Menge 10 967,7419… Stück/Jahr, Objekt 1 bei ganzen Mengen ab 10 968 günstiger. *S32:* $x=12 000$ Stück/Jahr; KVR bevorzugt A, GVR und RVR mit Differenzinvestition bevorzugen B; AVR nach B31 knapp B.])
#src[B31, PDF-S. 1–4; KR, PDF-S. 2–3; S32, PDF-S. 1–3. Nachgerechnet.]
