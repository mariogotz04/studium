// Kopf des Feynman-Lernskripts (Layout + Bausteine). Bilder liegen in abbildungen/. Keine Pakete erforderlich.
#set document(title: "Grundlagen der Elektrotechnik – Feynman-Lernskript", author: "Lernzusammenfassung")
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
  #text(size: 8pt, fill: muted)[Feynman-Lernskript · Stand 06.11.2026]
  #h(1fr)
  #text(size: 9pt, fill: navy)[Seite #counter(page).display("1") von #counter(page).final().first()]
]
#set page(paper: "a4", margin: (left: 20mm, right: 19mm, top: 19mm, bottom: 20mm),
 header: [#text(size: 8pt, fill: muted)[Grundlagen der Elektrotechnik #h(1fr) Sehen · Verstehen · Erklären]], footer: seitenfuss)
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
  "gesamt-basis-arbeitspunkt": "abbildungen/gesamt-basis-arbeitspunkt.svg",
  "gesamt-basis-netz": "abbildungen/gesamt-basis-netz.svg",
  "gesamt-drei-zweige": "abbildungen/gesamt-drei-zweige.svg",
  "gesamt-fuenf-widerstaende": "abbildungen/gesamt-fuenf-widerstaende.svg",
  "gesamt-glimmlampe-kennlinie": "abbildungen/gesamt-glimmlampe-kennlinie.svg",
  "gesamt-glimmlampe-netz": "abbildungen/gesamt-glimmlampe-netz.svg",
  "gesamt-ideale-quellen-netz": "abbildungen/gesamt-ideale-quellen-netz.svg",
  "gesamt-kennlinien-addieren": "abbildungen/gesamt-kennlinien-addieren.svg",
  "gesamt-kirchhoff-allgemein": "abbildungen/gesamt-kirchhoff-allgemein.svg",
  "gesamt-knoten-netz": "abbildungen/gesamt-knoten-netz.svg",
  "gesamt-konstantstrom-transistor": "abbildungen/gesamt-konstantstrom-transistor.svg",
  "gesamt-led-rot-kennlinie": "abbildungen/gesamt-led-rot-kennlinie.svg",
  "gesamt-led-rot-netz": "abbildungen/gesamt-led-rot-netz.svg",
  "gesamt-messung-i": "abbildungen/gesamt-messung-i.svg",
  "gesamt-messung-u": "abbildungen/gesamt-messung-u.svg",
  "gesamt-nichtlinear-lastkurve": "abbildungen/gesamt-nichtlinear-lastkurve.svg",
  "gesamt-ntc-bruecke": "abbildungen/gesamt-ntc-bruecke.svg",
  "gesamt-ntc-kennlinie": "abbildungen/gesamt-ntc-kennlinie.svg",
  "gesamt-parallel": "abbildungen/gesamt-parallel.svg",
  "gesamt-potenziometer": "abbildungen/gesamt-potenziometer.svg",
  "gesamt-pt100": "abbildungen/gesamt-pt100.svg",
  "gesamt-pufferbatterie": "abbildungen/gesamt-pufferbatterie.svg",
  "gesamt-quelle-verschieben-i": "abbildungen/gesamt-quelle-verschieben-i.svg",
  "gesamt-quelle-verschieben-u": "abbildungen/gesamt-quelle-verschieben-u.svg",
  "gesamt-quellen-ideal-gemischt": "abbildungen/gesamt-quellen-ideal-gemischt.svg",
  "gesamt-quellen-mischung": "abbildungen/gesamt-quellen-mischung.svg",
  "gesamt-quellen-parallel": "abbildungen/gesamt-quellen-parallel.svg",
  "gesamt-quellen-reihe": "abbildungen/gesamt-quellen-reihe.svg",
  "gesamt-serie": "abbildungen/gesamt-serie.svg",
  "gesamt-stern-dreieck": "abbildungen/gesamt-stern-dreieck.svg",
  "gesamt-stromquelle-symbolisch": "abbildungen/gesamt-stromquelle-symbolisch.svg",
  "gesamt-stromverhaeltnis": "abbildungen/gesamt-stromverhaeltnis.svg",
  "gesamt-teiler-kaskade": "abbildungen/gesamt-teiler-kaskade.svg",
  "gesamt-transistor-rc-feld": "abbildungen/gesamt-transistor-rc-feld.svg",
  "gesamt-transistor-rc-netz": "abbildungen/gesamt-transistor-rc-netz.svg",
  "gesamt-varistor-kennlinie": "abbildungen/gesamt-varistor-kennlinie.svg",
  "gesamt-varistor-netz": "abbildungen/gesamt-varistor-netz.svg",
  "gesamt-wheatstone": "abbildungen/gesamt-wheatstone.svg",
  "gesamt-zwei-stromquellen": "abbildungen/gesamt-zwei-stromquellen.svg",
  "gesamt-zweipol-zwei-quellen": "abbildungen/gesamt-zweipol-zwei-quellen.svg",
  "map-schaltungen": "abbildungen/map-schaltungen.svg",
  "map-methoden": "abbildungen/map-methoden.svg",
  "map-zweipol": "abbildungen/map-zweipol.svg",

  "led-netzwerk": "abbildungen/led-netzwerk.svg",
  "netzwerk-nichtlinear": "abbildungen/netzwerk-nichtlinear.svg",
  "vl30-bruecke": "abbildungen/vl30-bruecke.svg",
  "vl30-potential": "abbildungen/vl30-potential.svg",
  "vl30-vdr": "abbildungen/vl30-vdr.svg",
  "vl30-leistung": "abbildungen/vl30-leistung.svg",
  "vl30-knoten": "abbildungen/vl30-knoten.svg",
  "vl30-diode": "abbildungen/vl30-diode.svg",
  "vl30-tangente": "abbildungen/vl30-tangente.svg",
  "vl30-bay41": "abbildungen/vl30-bay41.svg",
  "vl30-netzkennlinie": "abbildungen/vl30-netzkennlinie.svg",
  "vl30-ptc": "abbildungen/vl30-ptc.svg",
  "vl30-leitung": "abbildungen/vl30-leitung.svg",
  "vl30-transistorfeld": "abbildungen/vl30-transistorfeld.svg",
  "vl30-masche": "abbildungen/vl30-masche.svg",
  "vl30-transistor": "abbildungen/vl30-transistor.svg",
  "vl30-ntc": "abbildungen/vl30-ntc.svg",
  "map-widerstandsarten": "abbildungen/map-widerstandsarten.svg",
  "map-netzwerk": "abbildungen/map-netzwerk.svg",
  "led-kennlinie-aufgabe": "abbildungen/led-kennlinie-aufgabe.svg",

  "skript-thermo": "abbildungen/skript-thermo.svg",
  "skript-foto": "abbildungen/skript-foto.svg",
  "skript-piezo": "abbildungen/skript-piezo.svg",
  "notiz-diode": "abbildungen/notiz-diode.svg",
  "notiz-spannungsteiler": "abbildungen/notiz-spannungsteiler.svg",
  "map-quelleneffekte": "abbildungen/map-quelleneffekte.svg",
  "rl-verlauf": "abbildungen/rl-verlauf.svg",
  "anpassung": "abbildungen/anpassung.svg",
  "cover": "abbildungen/cover.svg",
  "grundstromkreis": "abbildungen/grundstromkreis.svg",
  "kennlinie": "abbildungen/kennlinie.svg",
  "lampen": "abbildungen/lampen.svg",
  "map-grundgroessen": "abbildungen/map-grundgroessen.svg",
  "map-grundstromkreis": "abbildungen/map-grundstromkreis.svg",
  "map-quellen": "abbildungen/map-quellen.svg",
  "map-strom": "abbildungen/map-strom.svg",
  "map-wirkungen": "abbildungen/map-wirkungen.svg",
  "querschnitt": "abbildungen/querschnitt.svg",
  "skript-akku": "abbildungen/skript-akku.svg",
  "skript-anpassung": "abbildungen/skript-anpassung.svg",
  "skript-chemie": "abbildungen/skript-chemie.svg",
  "skript-drehspul": "abbildungen/skript-drehspul.svg",
  "skript-grundstromkreis": "abbildungen/skript-grundstromkreis.svg",
  "skript-impuls": "abbildungen/skript-impuls.svg",
  "skript-induktion": "abbildungen/skript-induktion.svg",
  "skript-ladung": "abbildungen/skript-ladung.svg",
  "skript-lorentz": "abbildungen/skript-lorentz.svg",
  "skript-stromdichte": "abbildungen/skript-stromdichte.svg",
  "skript-stromrichtung": "abbildungen/skript-stromrichtung.svg",
  "stromarten": "abbildungen/stromarten.svg",
  "zf-grundstromkreis": "abbildungen/zf-grundstromkreis.svg",
  "zf-kennlinie": "abbildungen/zf-kennlinie.svg",
)

#let bilddeutungen = (
  "gesamt-basis-arbeitspunkt": (titel: "Bild lesen", body: [Die steile Kurve ist die Diodenkennlinie, die fallenden Geraden sind das Speisenetz bei zwei Quellspannungen. Die Schnittpunkte ändern sich bei paralleler Verschiebung der Geraden.]),
  "gesamt-basis-netz": (titel: "Bild lesen", body: [Der Spannungsteiler R1 und R2 speist die Basis-Emitter-Strecke. Die Ausgangsklemmen A und B trennen das lineare Speisenetz von der nichtlinearen Eingangsdiode.]),
  "gesamt-drei-zweige": (titel: "Bild lesen", body: [Die beiden äußeren Quellen speisen über R1 und R2 denselben Knoten A. Der mittlere Widerstand R3 verbindet A mit dem unteren Bezugsknoten. Der Pfeil I2 ist zunächst zum Knoten A hin gewählt.]),
  "gesamt-fuenf-widerstaende": (titel: "Bild lesen", body: [R3 verbindet die beiden oberen Knoten. R2 und R4 liegen in den gemeinsam benutzten Zweigen benachbarter Maschen. Die Kreisströme sind gedachte Rechengrößen, deren Beiträge sich dort überlagern.]),
  "gesamt-glimmlampe-kennlinie": (titel: "Bild lesen", body: [Waagerecht steht die Lampenspannung, senkrecht der Strom in Milliampere. Zunächst fällt die Spannung bei wachsendem Strom. Oberhalb des Knicks steigt sie wieder. Die gestrichelte Linie kennzeichnet den unteren Haltebereich.]),
  "gesamt-glimmlampe-netz": (titel: "Bild lesen", body: [Die Quelle speist zwei Teiler aus R1/R2 und R3/R4. Die Last im Querzweig besteht aus R5 und der Glimmlampe. Für die Ersatzquelle an der Lampe bleibt R5 im aktiven Teil.]),
  "gesamt-ideale-quellen-netz": (titel: "Bild lesen", body: [Alle unteren Knoten sind Masse. Die erste Stromquelle liegt oben zwischen B und C, die zweite ganz rechts. Römisch bezeichnete Kreisströme und reale Widerstandsströme müssen getrennt werden.]),
  "gesamt-kennlinien-addieren": (titel: "Bild lesen", body: [Waagerecht steht U, senkrecht I. Oben werden zu einer gemeinsamen Spannung die beiden Ströme senkrecht addiert. Unten werden für denselben Strom die Teilspannungen waagerecht addiert.]),
  "gesamt-kirchhoff-allgemein": (titel: "Bild lesen", body: [Die schwarzen Punkte A, B und C sind die drei Knoten, die Pfeile I1 bis I5 definieren Zweigstromrichtungen. Die drei eingezeichneten Umläufe ergänzen zwei unabhängige Knotenbilanzen.]),
  "gesamt-knoten-netz": (titel: "Bild lesen", body: [Die beiden Quellen sind mit ihren Serienwiderständen in Stromersatzformen überführt. A und B sind die unbekannten Knoten, 0 ist Masse. Der Widerstand R3 koppelt ihre Potenziale.]),
  "gesamt-konstantstrom-transistor": (titel: "Bild lesen", body: [Oben liegen Verbraucher und Quelleninnenwiderstand im Lastkreis. Unten steht UCE waagerecht und IC senkrecht. Die Hyperbel begrenzt die Transistorleistung; die beiden Quellenlinien markieren die idealisierten Lastgrenzen.]),
  "gesamt-led-rot-kennlinie": (titel: "Bild lesen", body: [Waagerecht steht die LED-Spannung in Volt, senkrecht der Strom in Milliampere. Die rote Kennlinie steigt bei rund 2 V sehr steil an. Die Schwelle ist keine über alle Stromwerte exakt konstante Spannung.]),
  "gesamt-led-rot-netz": (titel: "Bild lesen", body: [R1 und der obere Quellenzweig speisen die Klemme A. R3 und R4 bleiben parallel zwischen A und B. Nur die LED wird für die Leerlaufrechnung abgetrennt.]),
  "gesamt-messung-i": (titel: "Bild lesen", body: [Das Amperemeter liegt im selben Zweig wie der Prüfling. Das Voltmeter umfasst beide Bauteile und misst den Spannungsabfall am Amperemeter mit.]),
  "gesamt-messung-u": (titel: "Bild lesen", body: [Das Voltmeter liegt direkt parallel zum Prüfling. Das Amperemeter sitzt vor der Verzweigung und misst zusätzlich den Voltmeterstrom. Seine Stromanzeige ist daher für den Prüfling allein zu groß.]),
  "gesamt-nichtlinear-lastkurve": (titel: "Bild lesen", body: [Waagerecht steht die Lastspannung, senkrecht der Laststrom in Milliampere. Dreiecke kennzeichnen die vorgegebenen Kennlinienpunkte. Zwischenwerte werden grafisch angenähert.]),
  "gesamt-ntc-bruecke": (titel: "Bild lesen", body: [Oben bildet der Heißleiter mit R1 einen Teiler, unten R2 mit R3. Das Voltmeter verbindet beide Mitten und besitzt einen endlichen Innenwiderstand. Die Quelle speist die Brücke von links nach rechts.]),
  "gesamt-ntc-kennlinie": (titel: "Bild lesen", body: [Waagerecht steht die Temperatur in Grad Celsius, senkrecht der Heißleiterwiderstand in Ohm auf logarithmischer Skala. Ein gleicher vertikaler Abstand entspricht einem gleichen Faktor, keiner gleichen Widerstandsdifferenz.]),
  "gesamt-parallel": (titel: "Bild lesen", body: [Die oberen und unteren Leiter verbinden jeweils einen gemeinsamen Knoten. An allen Widerständen liegt dieselbe Spannung U. Der Gesamtstrom teilt sich in I1, I2 und I3 auf.]),
  "gesamt-potenziometer": (titel: "Bild lesen", body: [Links liegt die feste Eingangsspannung an der gesamten Widerstandsbahn. Der Schleifer legt x und damit R2 fest. Rechts liegt die Last RA parallel zum unteren Bahnstück; IE teilt sich in Last- und Querstrom.]),
  "gesamt-pt100": (titel: "Bild lesen", body: [Der Vorwiderstand RV speist zwei parallele Wege: den temperaturabhängigen Pt100 und das Instrument RM. Der Strom Im fließt nur durch das Instrument und ist nicht der gesamte Quellenstrom.]),
  "gesamt-pufferbatterie": (titel: "Bild lesen", body: [Links speist der Generator über seinen Innen- und Vorwiderstand. Die Batterie liegt im mittleren Zweig, der Verbraucher rechts. Ein nach unten gerichteter Batteriestrom bedeutet bei der gezeichneten Polung Ladung der Batterie.]),
  "gesamt-quelle-verschieben-i": (titel: "Bild lesen", body: [Die Kopien der Quelle rechts führen gleich große Ströme in passend gewählte Richtungen. Im ergänzten Querzweig gleichen sich die Quellenbeiträge aus; sein Strom ist null.]),
  "gesamt-quelle-verschieben-u": (titel: "Bild lesen", body: [Links liefert eine Quelle ihren Beitrag zu zwei Widerstandszweigen. Rechts erhält jeder dieser Zweige eine gleich große, passend gepolte Kopie. Zwischen den kopierten Quellen heben sich die Spannungsbeiträge auf.]),
  "gesamt-quellen-ideal-gemischt": (titel: "Bild lesen", body: [Die Spannungsquelle legt das obere Potenzial X gegen Masse fest. Die ideale Stromquelle treibt ihren vorgegebenen Strom durch den 1-kΩ-Widerstand. Der rechte Zweig ist durch seinen Leitwert beschriftet.]),
  "gesamt-quellen-mischung": (titel: "Bild lesen", body: [Links speist eine Stromquelle einen Parallelwiderstand. Oben liegen 0,5 kΩ und eine Spannungsquelle in Reihe. Rechts bildet 1,5 kΩ einen Teil des aktiven Netzwerks; Ra ist die abtrennbare Last.]),
  "gesamt-quellen-parallel": (titel: "Bild lesen", body: [Links liegen zwei gleiche Quellen an denselben Klemmen. Jede führt die Hälfte des Laststroms. Rechts bleibt die Quellspannung gleich, der Ersatzinnenwiderstand ist halb so groß.]),
  "gesamt-quellen-reihe": (titel: "Bild lesen", body: [Oben unterstützen sich die Quellspannungen, unten wirken sie gegeneinander. Die Innenwiderstände stehen jeweils in Reihe und addieren sich. Die Minuszeichen am angenommenen Strom zeigen den Wechsel der tatsächlichen Richtung.]),
  "gesamt-serie": (titel: "Bild lesen", body: [Der Strom hat zwischen den Widerständen keinen Abzweig. Die beiden Teilspannungen sind im Maschenumlauf gemeinsam der Quellspannung gegenübergestellt. Größerer Widerstand bedeutet bei gleichem Strom größeren Spannungsabfall.]),
  "gesamt-stern-dreieck": (titel: "Bild lesen", body: [A, B und C bleiben als äußere Klemmen erhalten. Das äußere Dreieck kann durch drei innere Sternarme ersetzt werden. Die Sternmitte ist ein neuer innerer Punkt, kein zusätzlicher äußerer Anschluss.]),
  "gesamt-stromquelle-symbolisch": (titel: "Bild lesen", body: [Links der idealen Stromquelle liegt ein rein passives Netzwerk, rechts die Klemmen A und B mit R4 und R5. Der Pfeil der Quelle bestimmt die Richtung des übertragenen Stroms und die mögliche negative Klemmenspannung.]),
  "gesamt-stromverhaeltnis": (titel: "Bild lesen", body: [Die Verzweigungen sind ineinander verschachtelt. Ganz rechts bilden R6 und R7 die innerste Parallelgruppe. Vom inneren Ersatz aus werden die Stromteilungsverhältnisse nach links aufgebaut.]),
  "gesamt-teiler-kaskade": (titel: "Bild lesen", body: [R2 und R3 bilden einen Serienzweig, der parallel zu R4 liegt. Erst diese Gruppe liegt in Reihe mit R1. Der Strom durch R1 teilt sich am Knoten auf.]),
  "gesamt-transistor-rc-feld": (titel: "Bild lesen", body: [Waagerecht steht UCE in Volt, senkrecht links IC in Milliampere. Rechts sind die zugehörigen Basisströme in Mikroampere angeschrieben. Zur Auswertung wird die Kurve für 200 Mikroampere verwendet.]),
  "gesamt-transistor-rc-netz": (titel: "Bild lesen", body: [Der fest vorgegebene Basisstrom wählt eine Ausgangskennlinie. Im Kollektorkreis liegen RC und die Quelle. Ihre Maschenbilanz teilt Uq zwischen Widerstand und Transistor auf.]),
  "gesamt-varistor-kennlinie": (titel: "Bild lesen", body: [Waagerecht steht die Spannung in Volt, senkrecht der Strom in Milliampere. Die rote Kurve steigt mit der fünften Potenz stark an. Der Wert von 1 A liegt bei 50 V.]),
  "gesamt-varistor-netz": (titel: "Bild lesen", body: [R1 und R2 bilden den speisenden Teiler. R3 liegt zwischen dessen Abgriff und Klemme A. Der VDR liegt als Last zwischen A und B und belastet den Teiler über R3.]),
  "gesamt-wheatstone": (titel: "Bild lesen", body: [Die obere und untere Widerstandskette sind zwei Spannungsteiler. Das Galvanometer verbindet ihre Mitten B und C. Beim Abgleich verschwindet der Querzweigstrom; das Widerstandsverhältnis wird am Schleifdraht abgelesen.]),
  "gesamt-zwei-stromquellen": (titel: "Bild lesen", body: [Die Widerstände R1 und R2 verbinden die drei oberen Knoten A, B und C. R3 führt von B zur Masse. Links speist die 2-mA-Quelle ein, rechts entnimmt die 5-mA-Quelle Strom.]),
  "gesamt-zweipol-zwei-quellen": (titel: "Bild lesen", body: [Die Last Ra liegt zwischen A und B. R3 verbindet die Last mit dem inneren Quellennetz. Die beiden Spannungsquellen sind gegensinnig gepolt; diese Polungen bleiben beim Bestimmen der Leerlaufspannung aktiv.]),
  "map-schaltungen": (titel: "Bild lesen", body: [Das dunkelgrüne Zentrum verbindet vier hellblaue Äste. Lies zuerst die vier Hauptideen, dann erkläre die Verbindungen in eigenen Worten. Die Äste zeigen unterschiedliche Zugänge zum selben Kapitel.]),
  "map-methoden": (titel: "Bild lesen", body: [Das dunkelgrüne Zentrum verbindet vier hellblaue Äste. Lies zuerst die vier Hauptideen, dann erkläre die Verbindungen in eigenen Worten. Die Äste zeigen unterschiedliche Zugänge zum selben Kapitel.]),
  "map-zweipol": (titel: "Bild lesen", body: [Das dunkelgrüne Zentrum verbindet vier hellblaue Äste. Lies zuerst die vier Hauptideen, dann erkläre die Verbindungen in eigenen Worten. Die Äste zeigen unterschiedliche Zugänge zum selben Kapitel.]),

  "vl30-potential": (titel: "Bild lesen", body: [Links verbinden ideale Drähte Punkte gleichen Potenzials. Rechts steht waagerecht die Folge der Schaltungspunkte, senkrecht das Potenzial in V mit D als Nullpunkt. Über Widerständen sinkt es in Stromrichtung, über der Quelle steigt es wieder. Der Anstieg schließt den Umlauf.]),
  "vl30-bruecke": (titel: "Bild lesen", body: [Beide Zweige liegen an 10 V. Links teilen zwei gleiche Widerstände die Spannung auf 5 V. Rechts bleiben unter dem Abgriff 8 V. Der gestrichelte Querzweig ist offen; ein realer Querwiderstand würde beide Spannungsteiler belasten.]),
  "vl30-leitung": (titel: "Bild lesen", body: [A und B liegen am Hinleiter, C und D am Rückleiter. Die Spannungen 220 V und 216 V unterscheiden sich um die Summe der Abfälle beider Leiter. C ist als Bezugspunkt markiert; Masse muss nicht am Minuspol der Quelle liegen.]),
  "vl30-ptc": (titel: "Bild lesen", body: [Links stehen Strom und Spannung, rechts Widerstand und Temperatur. Die Temperaturkennlinien steigen an. Die gekrümmten Strom-Spannungs-Kennlinien zeigen, dass sich ein erwärmter Kaltleiter anders als ein konstanter ohmscher Widerstand verhält.]),
  "vl30-ntc": (titel: "Bild lesen", body: [Links oben sind unterschiedliche Arbeitspunkte bei unterschiedlichen Temperaturen eingetragen. Rechts steht die Reihenschaltung mit Vorwiderstand. Unten fällt die Temperaturkennlinie: Je wärmer der NTC, desto kleiner sein Widerstand. Die Beschriftung ist eine Skizzenangabe, kein genauer Ersatz für die Exponentialrechnung.]),
  "vl30-vdr": (titel: "Bild lesen", body: [Oben links steigt der Strom mit der Spannung stark an, während der Widerstandsquotient abnimmt. Oben rechts liegt der Varistor parallel zur Halbleiterschaltung. Unten wird die Spannungsspitze ohne Schutz der begrenzten Spannung mit Varistor gegenübergestellt; waagerecht steht die Zeit.]),
  "vl30-diode": (titel: "Bild lesen", body: [Waagerecht steht die Diodenspannung, senkrecht der Strom. Rechts ist der Durchlassbereich, links der Sperrbereich bis zum Durchbruch. Unten sind beide Polungen mit Lastwiderstand dargestellt. Der Ring am Bauteil kennzeichnet die Kathode.]),
  "vl30-bay41": (titel: "Bild lesen", body: [Waagerecht steht die Spannung in V, senkrecht der Strom in mA. Die rote Durchlasskennlinie wird bei wachsender Spannung sehr steil. Die Aufgabe verwendet den aus der Kurve abgelesenen Arbeitspunkt, um das Modell lokal auszuwerten.]),
  "vl30-tangente": (titel: "Bild lesen", body: [Die drei Diagramme zeigen dieselbe gekrümmte Kennlinie. Eine Gerade mit festgelegter Steigung wird bis an den Arbeitspunkt verschoben. Ihre Steigung ist der differenzielle Leitwert; der Kehrwert ist der differenzielle Widerstand. Die Gerade gilt nur in der Nähe dieses Punkts.]),
  "vl30-transistor": (titel: "Bild lesen", body: [Links ist der kleine Basisstrom im Steuerkreis, rechts der Kollektorstrom im Lastkreis mit Lastwiderstand. Beide Ströme vereinigen sich zum Emitterstrom. Die Quellspannung teilt sich zwischen Transistor und Lastwiderstand auf.]),
  "vl30-transistorfeld": (titel: "Bild lesen", body: [Waagerecht steht die Kollektor-Emitter-Spannung, senkrecht der Kollektorstrom. Jede nahezu waagerechte Kurve gehört zu einem Basisstrom. Die fallende Lastgerade schneidet die gewählte Kennlinie im Arbeitspunkt. Die rote Hyperbel kennzeichnet gleiche Verlustleistung von 0,5 W.]),
  "vl30-leistung": (titel: "Bild lesen", body: [Waagerecht steht die Zeit. Die Spannungs-, Strom- und Leistungskurven sind qualitativ überlagert, ihre Einheiten verschieden. Die rot schraffierte Fläche unter p(t) ist Energie. Das flächengleiche Rechteck hat die Höhe der mittleren Leistung; die Ausgleichsflächen F1 und F2 sind gleich groß.]),
  "vl30-knoten": (titel: "Bild lesen", body: [I1 und I3 zeigen auf den schwarzen Knoten, I2 und I4 von ihm weg. Die Bilanz vergleicht daher I1 plus I3 mit I2 plus I4. Die räumliche Richtung auf dem Blatt ist nur für die Pfeilzuordnung wichtig.]),
  "vl30-masche": (titel: "Bild lesen", body: [Die Pfeile U1, U2, U3 und Uq sind Bezugsrichtungen der Spannungen. Der eingezeichnete Umlauf zählt Uq, U1 und U2 gleichgerichtet und U3 entgegengerichtet. Ein anderer Umlaufsinn ändert alle Vorzeichen gemeinsam.]),
  "vl30-netzkennlinie": (titel: "Bild lesen", body: [Waagerecht steht die Spannung in V, senkrecht der Strom in A. R1 gehört zur flach auslaufenden Kurve, R3 zur nach oben steiler werdenden Kurve. Für einen vorgegebenen Strom gehst du zuerst waagerecht bis zur passenden Kurve und dann senkrecht zur Spannungsachse.]),
  "map-widerstandsarten": (titel: "Bild lesen", body: [Das Zentrum verbindet vier Blickwinkel: lineares Verhalten, Temperaturabhängigkeit, Spannungsabhängigkeit und Steuerung durch einen Basisstrom. Alle Bauteile brauchen passende Betriebsbedingungen; ein einziges konstantes R reicht bei den nichtlinearen Fällen nicht.]),
  "map-netzwerk": (titel: "Bild lesen", body: [Oben links beginnt die Rechnung mit einem Potenzialbezug. Knoten- und Maschenbilanz verbinden Ströme und Spannungen; rechts unten ergänzen die Kennlinien das Bauteilverhalten. Erst zusammen ergeben diese Beziehungen den Arbeitspunkt.]),
  "led-kennlinie-aufgabe": (titel: "Bild lesen", body: [Waagerecht steht die Spannung an der LED, senkrecht ihr Strom in mA. Die grüne Linie wurde aus der gedruckten Kennlinie nachgezeichnet. Sie steigt oberhalb des Knies steil an. Arbeitsgeraden und gesuchte Punkte sind bewusst nicht vorgegeben; die Kennlinie ist ein Ablesediagramm.]),

  "skript-thermo": (titel: "Zwei Temperaturen vergleichen", body: [Oben sind Kupfer und Konstantan an der Messstelle verbunden; rechts liegen die offenen Messanschlüsse. Unten zeigt die Skizze die Temperaturdifferenz zwischen Messstelle und Vergleichsstelle. Entscheidend ist diese Differenz, nicht die Temperatur einer einzelnen Stelle. Bei gleicher Temperatur verschwindet die Thermospannung.]),
  "skript-foto": (titel: "Vom Licht zum Strom", body: [Die gewellten Pfeile treffen auf den Halbleiter. Dort entstehen bewegliche Ladungsträger; das innere elektrische Feld trennt sie. Der Fotostrom fließt durch den äußeren Widerstand R und erzeugt dort die Spannung Uq. Die Skizze zeigt den Energiefluss von der Strahlung zum elektrischen Verbraucher.]),
  "skript-piezo": (titel: "Sensor und Schwingquarz unterscheiden", body: [Oben links drücken graue Pfeile auf den Kristall, rote Pfeile stehen für Zug. An den Elektroden entsteht eine Spannung; bei umgekehrter Wirkung verformt eine Spannung den Kristall. Rechts steht das elektrische Ersatzmodell mit R, L, Cs und Cp für das Resonanzverhalten. Unten siehst du einen Quarz im Gehäuse, geöffnet und in einer Oszillatorschaltung. Die Ersatzbauteile werden hier nur eingeordnet, nicht berechnet.]),
  "notiz-diode": (titel: "Deine Kennlinien lesen", body: [Waagerecht steht die Spannung U, senkrecht der Strom I. Rot steigt die Durchlasskennlinie der Diode stark an. Die fallende grüne Gerade beschreibt Quelle und Vorwiderstand; ihr Schnittpunkt mit der roten Kurve ist der Arbeitspunkt AP. Die orange Kennlinie ist durch Beleuchtung nach unten verschoben. Links ist der Sperrbereich bis zum Durchbruch skizziert. Die Zeichnung ist qualitativ; aus ihr werden keine genauen Stromwerte abgelesen.]),
  "notiz-spannungsteiler": (titel: "Deinen Rechenweg lesen", body: [Links liegen R1 und R2 in Reihe an 35 V. Rechts wird die Spannung an R2 zwischen den offenen Klemmen abgegriffen. Weil dort kein Laststrom abfließt, führen beide Widerstände denselben Strom. Deine eingerahmte Spannungsteilerregel folgt daraus. Die gerundeten 30 V entstehen durch frühes Runden; genauer sind es 30,43 V.]),
  "map-quelleneffekte": (titel: "Die fünf Quellenarten verbinden", body: [Das Zentrum ist immer die Quellspannung durch Ladungstrennung. Oben links sind chemische Reaktion und Induktion zusammengefasst. Die weiteren Äste ergänzen Temperaturdifferenz, Licht und mechanische Kraft als Ursachen. Frage bei jedem Ast: Welche Energieform wird umgewandelt und was löst die Ladungstrennung aus?]),
  "rl-verlauf": (titel: "Schaltung und Kurven verbinden", body: [Links wird eine Reihenschaltung aus 10 Ω und einer idealen Spule von 10 mH an 12 V eingeschaltet. Rechts steht waagerecht die Zeit geteilt durch τ, senkrecht jeweils ein Anteil zwischen null und eins. Grün steigt der Stromanteil i/I∞, ocker fällt der Spannungsanteil uL/Uq. Bei τ ist der Strom erst bei 63,2 Prozent seines Endwerts; die Spule nimmt noch 36,8 Prozent der Quellspannung auf. Die normierten Kurven ergänzen sich zu eins.]),
  "map-grundgroessen": (titel: "Die Mindmap lesen", body: [Im Zentrum stehen die vier Grundgrößen. Oben links die Ursache: Spannung entsteht durch Ladungstrennung. Oben rechts die Folge: Strom ist Ladung pro Zeit. Unten links bremst der Widerstand und verbindet beide über $U = R I$. Unten rechts die Leistung, also das, was am Verbraucher ankommt. Lies im Uhrzeigersinn: treiben, fließen, bremsen, ankommen.]),
  "skript-ladung": (titel: "Das Leiterstück lesen", body: [Der Zylinder ist ein Stück Draht mit Querschnitt $A$ (schraffiert) und Länge $l$. Die Kreise mit Minus sind die frei beweglichen Elektronen mit der Konzentration $n$. Alle Elektronen im Volumen $V = A l$ zusammen ergeben die Ladung $Q$. Ein doppelt so langes oder doppelt so dickes Stück enthält doppelt so viel Ladung.]),
  "skript-stromrichtung": (titel: "Zwei Pfeile, zwei Richtungen", body: [Unten sitzt die Quelle $U_q$, links ihr Plus-, rechts ihr Minuspol. Im Leiter oben wandern die Elektronen nach links (Pfeil „Richtung der e⁻“). Die Strompfeile $I$ an den Seiten zeigen die technische Stromrichtung: aus dem Pluspol heraus, durch den äußeren Kreis, in den Minuspol. Sie laufen genau gegen die Elektronen.]),
  "skript-akku": (titel: "Vom Schaltbild zur Entladekurve", body: [Links zwei Lampen mit je 3,5 A parallel am 12-V-Akku mit 36 Ah. Rechts steht waagerecht die Zeit, senkrecht die gespeicherte Ladung $Q$. Sie sinkt von 36 Ah geradlinig auf null bei $t_"entlade"$. Die rote Linie ist der Strom: konstant 7 A, solange Ladung vorhanden ist. Das Steigungsdreieck $Delta Q \/ Delta t$ zeigt: Die Steigung der Ladungskurve ist der Strom. Der Wassereimer mit konstantem Ausfluss ist das mechanische Gegenstück.]),
  "skript-impuls": (titel: "Warum die Wirkung sofort da ist", body: [Die Röhre ist voller Kugeln. Schiebt man links eine Kugel hinein, fällt rechts sofort eine heraus, obwohl jede einzelne Kugel kaum weiterrückt. So breitet sich beim Strom das elektrische Feld viel schneller aus, als die Elektronen selbst wandern.]),
  "map-strom": (titel: "Die Mindmap lesen", body: [Das Zentrum „Strom“ hat vier Äste. Oben links die Menge der Ladung im Leiter, oben rechts die Definition $I = Q\/t$ mit der technischen Richtung. Unten links: Die Elektronen driften langsam, die Wirkung ist trotzdem sofort da. Unten rechts: Die Stromdichte entscheidet über die Erwärmung. Alle vier Äste beschreiben dieselbe bewegte Ladung aus einem anderen Blickwinkel.]),
  "skript-stromdichte": (titel: "Gleicher Strom, andere Dichte", body: [Oben weitet sich ein Leiter von einer kleinen auf eine große Fläche $A$. Die Strompfeile gehen durch, $I_"Aus" = I_"Ein"$. Darunter steht waagerecht der Weg entlang des Leiters, senkrecht die Stromdichte $S$ in A/mm². Im engen Teil ist $S$ groß ($S_1$), nach der Erweiterung klein ($S_2$). Nur die Fläche, auf die sich der Strom verteilt, ändert sich.]),
  "querschnitt": (titel: "Die Pfeile zählen", body: [Links ist der Querschnitt klein, die Pfeile liegen dicht: große Stromdichte. Rechts ist er groß, die gleichen Pfeile verteilen sich: kleine Stromdichte. Es kommen rechts genauso viele Pfeile an, wie links hineingehen. Das ist die Kontinuitätsbedingung.]),
  "skript-drehspul": (titel: "Wie das Instrument misst", body: [Zwischen den Polen N und S des Dauermagneten sitzt die drehbar gelagerte Messspule mit dem Zeiger. Die spiralförmigen Rückstellfedern führen den Messstrom zu und drehen die Spule zurück. Links ist die Leiterschleife vereinfacht gezeichnet: Strom $I$ im Magnetfeld $B$, auf die beiden Längsseiten $l$ wirken entgegengesetzte Lorentzkräfte $F_L$ und erzeugen ein Drehmoment. Die Skala ist gleichmäßig geteilt, weil der Ausschlag proportional zum Strom ist. Rot sind deine Notizen.]),
  "skript-lorentz": (titel: "Warum sich die Schleife dreht", body: [Das Magnetfeld $B$ kommt von oben. Der Strom $I$ fließt auf der einen Längsseite der Schleife hinauf, auf der anderen hinunter. Deshalb zeigen die beiden Kräfte $F_L$ in entgegengesetzte Richtungen: Die Schleife wird gedreht, nicht verschoben. Der Hebelarm ist der Radius $r$.]),
  "map-wirkungen": (titel: "Die Mindmap lesen", body: [Strom sieht man nicht, man erkennt ihn an seinen Wirkungen. Oben links die Wärme durch Elektronenreibung, oben rechts die Kraft über das Magnetfeld, unten links der Materialtransport in Flüssigkeiten. Unten rechts steht, wie man eine Wirkung zum Messen nutzt: Beim Drehspulinstrument ist der Ausschlag proportional zum Strom.]),
  "stromarten": (titel: "Die beiden Verläufe lesen", body: [Waagerecht steht jeweils die Zeit, senkrecht der Strom $i(t)$. Links Gleichstrom: eine waagerechte Linie, der Strom bleibt konstant. Rechts sinusförmiger Wechselstrom: Er wechselt periodisch die Richtung und erreicht den Scheitelwert $hat(i)$. Eine Periode dauert bei 50 Hz $T = 20 thin "ms"$.]),
  "lampen": (titel: "Wo der Schalter sitzt", body: [Drei gleiche Lampen A, B und C liegen in Reihe an der Batterie. Der Schalter S liegt parallel zu C. Ist S offen, fließt der Strom durch alle drei Lampen. Ist S geschlossen, bietet er einen Weg ohne Widerstand an C vorbei: C ist überbrückt, also kurzgeschlossen.]),
  "skript-chemie": (titel: "Wo die Spannung entsteht", body: [Im Gefäß mit Elektrolyt stehen zwei Elektroden. Rechts ist der Minuspol, links der Pluspol. Die Bezeichnungen „Kathode“ und „Anode“ in der Originalabbildung sind für den gezeigten Entladebetrieb vertauscht (siehe Fehlerhinweis im Abschnitt). Zwischen den Polen liegt die Quellspannung $U_q$. Über den äußeren Widerstand $R$ fließen Elektronen von Minus nach Plus; der Strom $I$ ist in technischer Richtung eingezeichnet.]),
  "skript-induktion": (titel: "Die Versuchsanordnung lesen", body: [Rechts verlaufen die senkrechten Feldlinien des Magnetfelds $B$. Die Spule mit $N$ Windungen und Fläche $A$ wird mit der Geschwindigkeit $v$ von Stelle 1 nach Stelle 2 bewegt, an der das Feld $B_0$ herrscht. Dabei ändert sich der Fluss durch die Spule. Links ist sie über den Widerstand $R$ an ein Galvanometer angeschlossen, das den induzierten Strom $i$ anzeigt. Eine Spannung entsteht nur, solange sich der Fluss ändert.]),
  "map-quellen": (titel: "Die Mindmap lesen", body: [Jede Quellspannung beginnt mit Ladungstrennung durch einen physikalischen Effekt (oben links). Behandelt sind zwei Effekte: die chemische Reaktion in Batterie und Akku (oben rechts) und die Induktion (unten links). Unten rechts steht die Lenzsche Regel, die das Minuszeichen im Induktionsgesetz erklärt.]),
  "skript-grundstromkreis": (titel: "Das Ersatzschaltbild lesen", body: [Links die reale Quelle: ideale Quelle $U_q$ mit dem Innenwiderstand $R_i$ in Reihe, an $R_i$ fällt $U_i$ ab. Rechts zwischen den Klemmen A und B der Verbraucher $R_a$ mit der Klemmenspannung $U_a$. Der Strom $I = I_a$ ist im ganzen Kreis gleich. Am Verbraucher zeigen Strom- und Spannungspfeil in dieselbe Richtung (Verbraucherzählpfeilsystem).]),
  "zf-grundstromkreis": (titel: "Deine Zusammenfassung lesen", body: [Dieselbe Schaltung mit Zahlen: $U_q = 9 thin "V"$, $R_i = 300 thin Omega$, $R_a = 500 thin Omega$. Darunter steht der Umlauf $U_i + U_a - U_q = 0$, rechts die berechneten Werte. Rot notiert: Ohne Abschlusswiderstand ist der Kreis offen, an A und B liegt dann die Leerlaufspannung. Der Strom ist hier mit 11,23 mA notiert; richtig sind 11,25 mA (siehe Kasten „Fehler vermeiden“).]),
  "map-grundstromkreis": (titel: "Die Mindmap lesen", body: [Oben links das Modell: Eine reale Quelle ist $U_q$ mit $R_i$ in Reihe. Oben rechts und unten links die beiden Grenzfälle Leerlauf und Kurzschluss, aus denen man $R_i$ bestimmt. Unten rechts die Leistungsanpassung: maximale Leistung am Verbraucher, aber nur 50 Prozent Wirkungsgrad.]),
  "zf-kennlinie": (titel: "Deine Kennlinien lesen", body: [Waagerecht steht $U$ in V, senkrecht $I$ in mA. Die schwarze fallende Gerade ist die Quellenkennlinie von $I_k = 30 thin "mA"$ (bei $U = 0$) bis $U_q = 9 thin "V"$ (bei $I = 0$). Die rote Ursprungsgerade gehört zu $R_a = 500 thin Omega$, die blaue, steilere zu $R_a' = 50 thin Omega$. Die Schnittpunkte sind die Arbeitspunkte AP₁ und AP₂. Grün schraffiert ist die Fläche $P_a$, blau die Fläche $P_i$.]),
  "kennlinie": (titel: "Den Arbeitspunkt ablesen", body: [Dieselben Kennlinien sauber gezeichnet. Der Arbeitspunkt AP liegt bei 5,625 V und 11,25 mA. Das grüne Rechteck links unter dem AP hat die Fläche $U_a dot.c I = P_a$, das blaue Rechteck rechts davon bis 9 V die Fläche $U_i dot.c I = P_i$. Wird $R_a$ kleiner, wird die Widerstandsgerade steiler und der Arbeitspunkt wandert nach links oben zu AP₂.]),
  "skript-anpassung": (titel: "Halb und halb", body: [Im Anpassungsfall $R_a = R_i$ teilt sich die Quellspannung genau zur Hälfte: $U_a = U_q\/2$ am Verbraucher und $U_q\/2$ an $R_i$. Der Strom ist $I = U_q\/(2 R_i) = I_k\/2$. Die Quelle liefert $P_q = 2 P_"a,max"$; die eine Hälfte kommt beim Verbraucher an, die andere wird als $P_v$ in der Quelle verheizt.]),
  "anpassung": (titel: "Die Kurve lesen", body: [Waagerecht steht das Verhältnis $R_a\/R_i$, senkrecht der Anteil $P_a\/P_"a,max"$. Die Kurve steigt links steil an, erreicht bei $R_a = R_i$ ihr Maximum 1 und fällt rechts nur langsam ab. Rechts liegt die Überanpassung: etwas weniger Leistung, aber deutlich höherer Wirkungsgrad.]),
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
#text(size: 29pt, weight: "bold", fill: navy)[Grundlagen der\ Elektrotechnik]
#v(4mm)
#text(size: 20pt, fill: navy)[Feynman-Lernskript]
#v(3mm)
#text(size: 12pt)[Spannung treibt. Strom fließt. Widerstand bremst. Leistung kommt an.]
#v(5mm)
#bild("cover", [Grundstromkreis aus Quelle, Innenwiderstand und Lampe. Eigene Darstellung; nicht maßstäblich.], height: 62mm)
#v(4mm)
#text(size: 12pt, fill: teal)[Ladung → Strom → Schaltung → Netzwerk → Arbeitspunkt]
]

#note("Dein Feynman-Schritt", [Sieh dir die Abbildung an. Erkläre dann ohne Vorlage: *Was passiert? Warum? Wann gilt die Formel?* Erst anschließend vergleichst du deine Erklärung mit dem Text und den Formeln.])

Stand 06.11.2026: Vollständige Feynman-Zusammenfassung zum GET-Vorlesungsskript bis S. 108 als Grundlage für dein Selbststudium. Die bisherigen Markierungen und Mitschriften bleiben einbezogen; die weiteren Kapitel ergänzen Messschaltungen, Netzwerkmethoden und Zweipoltheorie. Aufgaben mit vollständigen Lösungen, Quiz, Verständnis-Karten und Hörfassung werden zusammen auf der Lernplattform gepflegt.

#pagebreak()
#heading(level: 1, outlined: false)[Wegweiser]
#block[
#set text(size: 9.5pt)
#set par(leading: 0.3em, spacing: 0.15em)
#outline(title: none, depth: 2, indent: auto)
]
#v(2mm)
#text(size: 8.5pt, fill: muted)[*Quellenkürzel:* V = Vorlesungsskript Kölbl, „Grundlagen der Elektrotechnik“ (aufgedruckte Seite = PDF-Seite); M = Mitschrift „eigenes Skript Elektrotechnik“; B = BAF-Mitschrift VL 1–3 (S. 1 = VL 1, S. 2 = VL 2, S. 3 = VL 3); Z = handschriftliche Zusammenfassung VL 3; FK = Fragenkatalog „Einstieg GET auf Schulniveau“ (Fragennummer); Ü = Übung GET (Aufgabe); A, B = Übungsblatt A bzw. B (Aufgabe); R = handschriftliche Lösungen zu Blatt A und B („Prüfungsvorbereitungsfragen.pdf“). N30 = „Skript GET vl 30.10.pdf“ (PDF-S. 1–22 entsprechen V S. 20–41); LED = „Aufgabe GET_grüne_LED_202610291323_57076.pdf“ (PDF-S. 1 Aufgabe, S. 2–3 Mitschrift); N = „neue VL GET.pdf“ mit Notizen vom 15./22.10. (PDF-S. 1–6 entsprechen V S. 14–19); FK-N = Fragenkatalog mit Lösungen bis 22.10.; Ü-N = „ÜBUNG GET (mit Mitschrift zu Aufgabe 1)“; DC = „ÜBUNGEN_GET_DC_URI_Basics_202610161827_42497“ mit Rechenwegen zu Ü 1–3. „S.“ bei Mitschriften zählt ab der ersten PDF-Seite. Externe Fachprüfungen sind mit Anbieter und Link direkt am Abschnitt genannt. „Eigene Ergänzung“ bezeichnet zusätzliche Erklärhilfen und Beispiele.]

#pagebreak()
#heading(level: 1, outlined: false, bookmarked: false)[Das Modul auf einen Blick] <ueberblick>

Jeder Kasten führt zu seinem Kapitel. Die Pfeiltexte zeigen, wie die Kapitel zusammenhängen.

#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Kapitel 0 · Vorwissen: Strom, Spannung, Widerstand, Leistung], [Ladung · Spannung · Strom · Widerstand · Leistung], ziel: <a-0>),
  pfeil(beschriftung: [erklärt die Größen für]),
  chunk([Kapitel 1 · Grundbegriffe], [Strom · Quellen · Potenzial · Kennlinien · Energie], ziel: <a-1>),
  pfeil(beschriftung: [liefert Quellenmodell für]),
  chunk([Kapitel 2 · Kirchhoff und Grundstromkreis], [Knoten · Maschen · Arbeitspunkt · Leistungsbilanz], ziel: <a-2>),
)

#karte((1fr, auto, 1fr),
 chunk([Kapitel 3 · Netzwerkmethoden], [Gleichungssystem · Überlagerung · Maschen · Knoten], ziel: <a-3>),
 pfeil(beschriftung: [vereinfacht das Netz zur]),
 chunk([Kapitel 4 · Zweipoltheorie], [Ersatzquelle · Kennlinienschnitt · Leistungsgrenze], ziel: <a-4>),
)

Ladung, Spannung und Strom bilden die Sprache des Moduls. Mit Widerstand und Leistung beschreibst Du zuerst einfache Schaltungen. Danach erklären die Quelleneffekte, wie eine Spannung entsteht. Potenziale und Kennlinien erweitern die Sprache auf nichtlineare Bauteile. Knoten- und Maschenregel verbinden die Zweige; Netzwerkmethoden machen größere Schaltungen berechenbar. Die Zweipoltheorie fasst das Speisenetz zusammen und findet den zulässigen Arbeitspunkt auch mit nichtlinearer Last.
#src[Eigene Darstellung; Zusammenführung des bereits enthaltenen Stoffs und der Denkkette auf der Titelseite.]

#pagebreak()

#pagebreak(weak: true)
= Kapitel 0 · Vorwissen: Strom, Spannung, Widerstand, Leistung <a-0>

#überblick([Kapitel 0 auf einen Blick],
  idee(<a-0-1>, [Spannung treibt, Strom transportiert Ladung.], [Beide Größen beschreiben unterschiedliche Eigenschaften desselben Stromkreises.]),
  idee(<a-0-2>, [Widerstand verknüpft Spannung und Strom.], [Das Ohmsche Gesetz gilt für das betrachtete ohmsche Modell.]),
  idee(<a-0-3>, [Leistung beschreibt die Energie pro Zeit.], [Spannung und Strom bestimmen gemeinsam die umgesetzte Leistung.]),
  idee(<a-0-4>, [Die Verschaltung bestimmt die Aufteilung.], [In Reihe ist der Strom gleich, parallel die Spannung.]),
  idee(<a-0-6>, [Eine reale Quelle hat innere Verluste.], [Der Innenwiderstand verbindet das Vorwissen mit dem späteren Grundstromkreis.]),
)

#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Spannung U], [Energie je Ladung], ziel: <a-0-1>),
  pfeil(beschriftung: [treibt über R]),
  chunk([Strom I], [Ladung je Zeit · Widerstand R], ziel: <a-0-2>),
  pfeil(beschriftung: [liefert mit U]),
  chunk([Leistung P], [Energie je Zeit], ziel: <a-0-3>),
)
#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Reihenschaltung], [gleicher Strom], ziel: <a-0-4>),
  pfeil(beschriftung: [liefert Regel für]),
  chunk([Schaltung auswerten], [Ersatzwiderstand · Teilgrößen], ziel: <a-0-6>),
  pfeil(beschriftung: [braucht eigene Regel für]),
  chunk([Parallelschaltung], [gleiche Spannung], ziel: <a-0-4>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])


Die Vorlesung setzt Schulwissen voraus. Dieses Kapitel baut die vier Grundgrößen und ihre zwei wichtigsten Verknüpfungen auf: das Ohmsche Gesetz und die Leistung. Wenn hier etwas wackelt, festige es zuerst. Der Fragenkatalog enthält nur Fragen; die Erklärtexte sind deshalb Schulwissen und, wo nicht anders angegeben, _eigene Ergänzung_. Die Formeln $R = rho l\/A$ und $P = U I$ stehen auch in deiner Mitschrift.

#bild("map-grundgroessen", [Mindmap: Die vier Grundgrößen der Elektrotechnik. Eigene Darstellung.], height: 44mm)

== 0.1 Ladung, Spannung, Strom <a-0-1>
Atome bestehen aus Protonen (positiv), Neutronen (neutral) und Elektronen (negativ). Elektrisch interessant sind nur die *geladenen* Teilchen: Protonen und Elektronen. Im Metall bewegen sich nur die Elektronen, die Protonen sitzen fest im Atomgitter. *Gleichartige* Ladungen stoßen sich ab, *ungleichartige* ziehen sich an.

Die *Spannung* $U$ in Volt ist der „Druck“, der Ladungen in Bewegung setzen will. Sie entsteht durch Ladungstrennung (Plus- und Minuspol). Der *Strom* $I$ in Ampere ist die Ladung, die pro Zeit durch den Leiter fließt:
#form[$ I = Q/t quad <=> quad Q = I dot.c t quad quad [Q] = 1 thin "C" = 1 thin "As" $]
#note("In eigenen Worten", [_Eigene Ergänzung:_ Vergleich Wasserkreislauf. Spannung ist der Druckunterschied der Pumpe, Strom die Wassermenge pro Sekunde, Widerstand ein enges Rohr. Ohne Druckunterschied fließt nichts, egal wie dick das Rohr ist. Grenze des Vergleichs: Elektronen „verbrauchen“ sich nicht und fließen nur im geschlossenen Kreis.])

#tab(columns: (1.4fr, 0.8fr, 1.6fr, 0.8fr),
 th([Anwendung], [Spannung], [Anwendung], [Spannung]),
 [AAA-Batterie], [1,5 V], [Wechselstromnetz (Steckdose)], [230 V],
 [PKW-Batterie], [12 V], [Drehstromnetz], [400 V],
 [], [], [Höchstspannung (Überlandleitung)], [380 kV],
)
#tab(columns: (1.4fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
 th([Vorsilbe], [M (Mega)], [k (Kilo)], [–], [m (Milli)], [µ (Mikro)], [n (Nano)]),
 [Faktor], [$10^6$], [$10^3$], [$10^0$], [$10^(-3)$], [$10^(-6)$], [$10^(-9)$],
)
#note("Fehler vermeiden", [Zwischen zwei benachbarten Vorsilben liegt immer der Faktor 1000. Von groß nach klein (kV → V → mV) wird die Zahl größer: 0,23 kV = 230 V = 230 000 mV.], fill: sand)
#src([FK 1–4, 6 und Umrechnungsaufgaben; Erklärtexte Schulwissen, eigene Ergänzung.])
#hoch(<a-0>, [Kapitelübersicht])


== 0.2 Widerstand und Ohmsches Gesetz <a-0-2>
Die Elektronen stoßen auf ihrem Weg ständig an die schwingenden Atome des Metallgitters. Diese „Reibung“ bremst den Strom: Das ist der *Widerstand*. Dabei entsteht Wärme.
#form[$ U = R dot.c I quad quad R = U/I quad quad [R] = 1 thin Omega = 1 thin "V/A" quad quad G = 1/R quad [G] = 1 thin "S (Siemens)" $]
Im $I$-$U$-Diagramm ist ein linearer Widerstand eine Gerade durch den Ursprung. Je steiler die Gerade, desto kleiner der Widerstand, denn die Steigung ist $I\/U = 1\/R$. Für $R = 2 thin Omega$ fließt bei 2 V genau 1 A.

*Widerstand eines Drahtes.* Er wächst mit der Länge und sinkt mit dem Querschnitt:
#form[$ R = rho dot.c l/A = l/(kappa dot.c A) quad quad A = pi/4 d^2 $]
$rho$: spezifischer Widerstand in $Omega thin "mm"^2\/"m"$ (Materialkonstante); $kappa = 1\/rho$: Leitfähigkeit in $"m"\/(Omega thin "mm"^2)$; $l$: Leiterlänge in m (bei Hin- und Rückleiter doppelt!); $A$: Querschnitt in mm². Der Widerstand hängt außerdem von der Temperatur ab. Werte aus Ü 7: $rho_"Cu" = "0,0178"$, $rho_"Al" = "0,0278" thin Omega thin "mm"^2\/"m"$. Deine Mitschrift hält fest: Je länger das Kabel und je kleiner der Querschnitt, desto größer der Widerstand (B S. 1).

*Beispiel (FK 16):* Kupferleiter, 350 m, 6 mm²: $R = "0,0178" dot.c 350\/6 approx "1,04" thin Omega$. Die Einheiten mm² und m kürzen sich direkt; deshalb ist $Omega thin "mm"^2\/"m"$ so praktisch.
#note("Widerspruch in den Unterlagen", [V S. 9 rechnet mit $rho_"Cu" = "0,0179" thin Omega thin "mm"^2\/"m"$ (aus $kappa = 56$), Ü 7 und Blatt B 14 mit 0,0178. Der Unterschied ist klein; nimm immer den Wert, der in der Aufgabe gegeben ist.], fill: sand)
#note("Fehler vermeiden", [Halber Durchmesser heißt viertel Querschnitt (wegen $d^2$) und damit vierfacher Widerstand.], fill: sand)
*Weitere Begriffe aus dem Fragenkatalog.* *PTC* (Kaltleiter): Widerstand steigt mit der Temperatur. *NTC* (Heißleiter): Widerstand sinkt mit der Temperatur. *E12-Reihe:* Normwerte mit ±10 % Toleranz; ein 8,2-kΩ-Widerstand liegt zwischen 7,38 und 9,02 kΩ. Beste Leiter: Silber vor Kupfer, Gold und Aluminium, Eisen deutlich schlechter (_eigene Ergänzung_, FK 7 fragt danach).
#src([FK 7, 13–17; M S. 1; B S. 1 (VL 1); V S. 9; Ü 7. Ohmsches Gesetz jetzt vertieft in Abschnitt 1.4.1–1.4.3 (VL 30.10.).])
#hoch(<a-0>, [Kapitelübersicht])


== 0.3 Leistung, Energie, Kosten <a-0-3>
Die *Leistung* sagt, wie viel Energie pro Sekunde umgesetzt wird. Mit dem Ohmschen Gesetz gibt es drei gleichwertige Formen:
#form[$ P = U dot.c I = I^2 dot.c R = U^2/R quad ["W"] quad quad W = P dot.c t quad ["Ws" = "J"; thin "kWh"] $]
Welche Form du nimmst, hängt davon ab, was gegeben ist: $I^2 R$, wenn der Strom bekannt ist (Reihenschaltung), $U^2\/R$, wenn die Spannung bekannt ist (Parallelschaltung). $P = U I$ und $P = I^2 R$ stehen auch in deiner Mitschrift (B S. 2).

*Beispiel (FK 19):* Heizung 230 V, 8,7 A, 8 h täglich, 30 Tage, 0,31 €/kWh.
+ Leistung: $P = 230 thin "V" dot.c "8,7" thin "A" = 2001 thin "W" approx "2,0" thin "kW"$
+ Betriebszeit: $t = 8 thin "h" dot.c 30 = 240 thin "h"$
+ Energie: $W = "2,001" thin "kW" dot.c 240 thin "h" = "480,2" thin "kWh"$
+ Kosten: $K = "480,2" thin "kWh" dot.c "0,31" thin "€/kWh" approx "148,87" thin "€"$
#note("In eigenen Worten", [_Eigene Ergänzung, WI-Sicht:_ Stromkosten = Leistung × Zeit × Preis. Genauso rechnest du später Betriebskosten von Maschinen oder die Amortisation effizienterer Geräte.])
#src([FK 18–19; M S. 3; B S. 2 (VL 2).])
#hoch(<a-0>, [Kapitelübersicht])


== 0.4 Reihen- und Parallelschaltung <a-0-4>
#tab(columns: (1fr, 1.6fr, 1.6fr),
 th([], [Reihenschaltung], [Parallelschaltung]),
 [gleich ist …], [der Strom $I$ (überall derselbe)], [die Spannung $U$ (an jedem Zweig dieselbe)],
 [es teilt sich …], [die Spannung: $U = U_1 + U_2 + dots$], [der Strom: $I = I_1 + I_2 + dots$],
 [Gesamtwiderstand], [$R_"ges" = R_1 + R_2 + dots$, größer als jeder einzelne], [$1\/R_"ges" = 1\/R_1 + 1\/R_2 + dots$, kleiner als der kleinste],
 [größter $R$ bekommt …], [die größte Spannung], [den kleinsten Strom],
 [ein Teil fällt aus], [alles aus (Kreis offen)], [die anderen laufen weiter, Gesamtstrom sinkt],
)
#form[$ "zwei parallele Widerstände:" quad R_"ges" = (R_1 R_2)/(R_1 + R_2) quad quad "unbelasteter Spannungsteiler:" quad U_2 = U dot.c R_2/(R_1 + R_2) $]
#note("In eigenen Worten", [Erhöht man in einer Reihenschaltung einen Widerstand, sinken Strom und Gesamtleistung ($P = U^2\/R_"ges"$); die Quelle wird weniger belastet.])
#src([FK 20–25; Schulwissen, eigene Ergänzung. Vertiefung in Abschnitt 2.4.4–2.4.6 nach V S. 47–54.])
#hoch(<a-0>, [Kapitelübersicht])


== 0.5 Ideale und reale Spannungsquelle (Vorschau) <a-0-5>
Eine ideale Quelle liefert immer dieselbe Spannung, egal wie viel Strom fließt. Eine reale Quelle hat zusätzlich einen *Innenwiderstand* $R_i$ in Reihe. Je mehr Strom fließt, desto mehr Spannung bleibt innen hängen, die Klemmenspannung sinkt:
#form[$ U_"Klemme" = U_q - I dot.c R_i $]
*Beispiel (FK 27):* Mignonzelle, $U_q = "1,52" thin "V"$, $R_i = "0,13" thin Omega$, $I = 40 thin "mA"$: $U = "1,52" - "0,04" dot.c "0,13" approx "1,515" thin "V"$. Ausführlich in Abschnitt 2.4.1.
#src([FK 26–30; V S. 42.])
#hoch(<a-0>, [Kapitelübersicht])


== 0.6 Ergänzung vom 22.10.: Spannungsteiler und Quellen <a-0-6>
Ein *unbelasteter Spannungsteiler* ist eine Reihenschaltung mit offenem Ausgang: Du greifst eine Spannung ab, ohne dort Strom zu entnehmen. Wie bei zwei Engstellen hintereinander verteilt sich der gesamte Spannungsabfall auf beide Widerstände.
#note("Von dir markiert", [Im neuen Fragenkatalog steht: „Aufgabe 25 bis 28 am 22.10 gemacht“. Die Spannungsteilerregel ist in deiner Lösung eingerahmt. Die Fragen zum Magnetfeld greifen wir bei der Induktion und in den Aufgaben auf der Lernwebseite auf.])
#bild("notiz-spannungsteiler", [Spannungsteiler mit deinem Rechenweg. FK-N, PDF-S. 6, Aufgabe 25, Ausschnitt.], height: 48mm)
#form[$ I = U/(R_1 + R_2) quad U_20 = I R_2 = U R_2/(R_1 + R_2) $]
$U$: Gesamtspannung in V; $R_1$, $R_2$: Widerstände in Ω; $U_20$: Ausgangsspannung an $R_2$ im Leerlauf. *Voraussetzung:* kein Laststrom am Ausgang; ein ideales Voltmeter verändert die Schaltung nicht.

*FK 25:* $I = 35 thin "V"/(115 thin "k"Omega) approx "0,30435" thin "mA"$. Damit ist $U_20 = 35 thin "V" dot.c 100/115 approx "30,43" thin "V"$. Runde möglichst erst das Ergebnis, damit sich Rundungsfehler nicht fortsetzen.
#note("Fehler vermeiden", [Ein angeschlossener Verbraucher liegt parallel zu $R_2$. Dann ist der untere Widerstand durch den Parallelersatz zu ersetzen; die unbelastete Formel mit unverändertem $R_2$ gilt nicht mehr. Das ist die Bedeutung deiner Randnotiz neben den Ausgangsklemmen.], fill: sand)

*FK 26–27:* Bei einer idealen Quelle entfällt der Innenwiderstand. Bei einer realen Quelle fällt unter Last innen $U_i = I R_i$ ab: Mit $U_q = "1,52" thin "V"$, $R_i = "0,13" thin Omega$ und $I = "0,04" thin "A"$ erhältst du $U_i = "0,0052" thin "V"$ und *$U_"Klemme" = "1,5148" thin "V"$*. Das ist die genauer gerechnete Version des Beispiels in Abschnitt 0.5.
#note("In eigenen Worten", [Der Laststrom fließt zusätzlich durch $R_1$; $R_1$ und $R_2$ führen dann nicht mehr denselben Strom. Erst den Parallelersatz unten bilden, dann die Regel anwenden.])
#src([FK-N, PDF-S. 6, Aufgaben 25–27 samt handschriftlichen Lösungen; Abschnitt 0.4 und V S. 42 für die Schaltungsregeln. Rechenwege ergänzt und ohne frühes Runden geprüft.])

*Der Zusammenhang in Kapitel 0.* Die Spannung ist die Ursache, der Strom die Folge, der Widerstand bestimmt, wie viel Strom die Spannung antreibt. Die Leistung verknüpft Spannung und Strom zu dem, was am Verbraucher ankommt, und über die Zeit zur Energie, die bezahlt wird. In Schaltungen entscheidet die Schaltungsart, welche Größe überall gleich ist.
#hoch(<a-0>, [Kapitelübersicht])


#pagebreak(weak: true)
= Kapitel 1 · Grundbegriffe: Strom, Spannung, Widerstand, Leistung <a-1>

#überblick([Kapitel 1 auf einen Blick],
 idee(<a-1-1-2>, [Strom transportiert Ladung.], [Drift, Stromdichte und Wirkungen beschreiben denselben Vorgang aus verschiedenen Blickwinkeln.]),
 idee(<a-1-2-1>, [Quellen trennen Ladungen.], [Chemie, Flussänderung, Temperaturdifferenz, Licht und Kraft sind die behandelten Ursachen.]),
 idee(<a-1-3>, [Potenziale brauchen einen Nullpunkt.], [Spannungen sind Differenzen zweier Potenziale.]),
 idee(<a-1-4-1>, [Material, Geometrie und Temperatur bestimmen den Drahtwiderstand.], [Widerstand und Leitwert sind Kehrwerte.]),
 idee(<a-1-4-3>, [Kennlinien beschreiben das Bauteilverhalten.], [Bei nichtlinearen Bauteilen unterscheiden sich statischer und differenzieller Widerstand.]),
 idee(<a-1-5>, [Leistung ist Energieumsatz pro Zeit.], [Bei zeitabhängigen Größen ergibt sich die Energie als Fläche unter der Leistungskurve.]),
)

#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Bewegte Ladung], [Strom · Drift], ziel: <a-1-1-2>),
  pfeil(beschriftung: [bezogen auf Fläche ergibt]),
  chunk([Stromdichte], [Strom je Querschnitt], ziel: <a-1-1-5>),
  pfeil(beschriftung: [ordnet Beanspruchung ein]),
  chunk([Stromwirkungen], [Wärme · Kraft · Stofftransport], ziel: <a-1-1-6>),
)
#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Zugeführte Energie], [Chemie · Bewegung · Wärme · Licht · Kraft], ziel: <a-1-2-1>),
  pfeil(beschriftung: [ermöglicht]),
  chunk([Ladungstrennung], [jeweiliger Quelleneffekt], ziel: <a-1-2-2>),
  pfeil(beschriftung: [erzeugt]),
  chunk([Quellspannung], [Antrieb des äußeren Stromkreises], ziel: <a-1-2-4>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])


#karte((1fr, auto, 1fr, auto, 1fr),
 chunk([Potenziale], [Bezugspunkt und Differenz], ziel: <a-1-3>), pfeil(beschriftung: [liefern Spannungen für]),
 chunk([Bauteilkennlinien], [Material · Temperatur · Arbeitspunkt], ziel: <a-1-4-3>), pfeil(beschriftung: [bestimmen mit dem Strom]),
 chunk([Leistung und Energie], [Momentanwert · Fläche · Mittelwert], ziel: <a-1-5>),
)
Wir bauen ein Bild davon auf, was im Draht passiert, wenn Strom fließt: wie viel Ladung darin steckt, wie schnell sie wandert, wie sie sich auf den Querschnitt verteilt und woran man sie erkennt. Danach klären wir, woher der Antrieb kommt: Eine Quelle trennt Ladungen, chemisch, durch Induktion, eine Temperaturdifferenz, Licht oder eine mechanische Einwirkung. Grundlage ist Skript Kapitel 1.1 bis 1.5; hinzu kommen die Randnotizen vom 15., 22. und 30.10. sowie die LED-Aufgabe.

#bild("map-strom", [Mindmap: Vier Blicke auf den elektrischen Strom. Eigene Darstellung.], height: 44mm)

== 1.1.1 Die elektrische Ladung <a-1-1-1>
Stell dir einen Draht als Rohr vor, das randvoll mit frei beweglichen Elektronen ist. Wie viel *Ladung* darin steckt, hängt davon ab, wie dicht die Elektronen gepackt sind ($n$), wie viel Ladung jedes trägt ($e$) und wie groß das Drahtstück ist ($V = A l$).
#bild("skript-ladung", [Ladungen im elektrischen Leiter. V S. 5, Abb. 1.1.], height: 34mm)
#form[$ Q = n dot.c e dot.c V = n dot.c e dot.c A dot.c l $]
$n$: Ladungsträgerdichte, Kupfer $n_"Cu" approx "8,44" dot.c 10^22 thin "cm"^(-3)$; $e$: Elementarladung, $e = "1,602176634" dot.c 10^(-19) thin "As"$, die kleinste in der Natur vorkommende Ladung und eine Naturkonstante (in deinen Vorlesungsseiten gerundet zu $"1,6" dot.c 10^(-19) thin "As"$); $A$, $l$: Querschnitt und Länge des Leiterstücks; $[Q] = 1 thin "Coulomb" = 1 thin "As"$.

Ein Elektron trägt $-e$, ein Proton $+e$. Ladung ist immer an einen Träger und damit an Masse gebunden. Sie hat *Mengencharakter*: Man kann sie zählen wie Wasser in Litern.
#src([V S. 5–6; M S. 1.])
#hoch(<a-1>, [Kapitelübersicht])


== 1.1.2 Die elektrische Stromstärke und die Stromrichtung <a-1-1-2>
Gerät die Ladung unter dem „Druck“ einer Spannung $U_q$ in Bewegung, fließt ein Strom. Die *Stromstärke* ist die Ladung, die pro Zeit durch den Querschnitt fließt:
#form[$ I = Q/t = (n dot.c e dot.c l dot.c A)/t quad quad "zeitlich veränderlich:" quad i(t) = (dif Q(t))/(dif t) $]
Das Ampere ist laut Skript eine der Basiseinheiten des SI. 1 A heißt: Pro Sekunde fließen rund $"6,25" dot.c 10^18$ Elektronen durch den Querschnitt ($1\/e$).
#note("Widerspruch in den Unterlagen", [V S. 7 spricht von „6 Basiseinheiten“ und listet A, m, kg, s, cd, K. _Eigene Ergänzung:_ Das SI hat 7 Basiseinheiten; es fehlt das Mol (Stoffmenge). Für die Klausur zählt im Zweifel die Liste des Dozenten.], fill: sand)
#bild("skript-stromrichtung", [Stromfluss der Elektronen und technische Stromrichtung. V S. 6, Abb. 1.2.], height: 40mm)
#tab(columns: (1fr, 1fr),
 th([technische Stromrichtung], [physikalische Stromrichtung]),
 [von + nach − (außerhalb der Quelle)], [von − nach +: So laufen die Elektronen wirklich.],
 [wird in allen Schaltplänen verwendet], [Bewegungsrichtung der Elektronen],
)
#note("Fehler vermeiden", [Der Strompfeil $I$ im Schaltbild zeigt immer die technische Richtung, also *entgegen* der Elektronenbewegung (V S. 6; B S. 2).], fill: sand)

*Beispiel (V S. 7, Ü 2):* 12-V-Akku mit 36 Ah, zwei Scheinwerfer zu je 42 W parallel.
#bild("skript-akku", [Auto-Akku mit zwei Scheinwerferlampen und mechanisches Analogon. V S. 7, Abb. 1.3.], height: 44mm)
+ Strom je Lampe: $I = P\/U = 42 thin "W"\/12 thin "V" = "3,5" thin "A"$; zusammen $sum I = 7 thin "A"$
+ Entladezeit: $t_"entlade" = Q_"max"\/sum I = 36 thin "Ah"\/7 thin "A" approx "5,14" thin "h" approx 308 thin "min"$
Die Ladung im Akku nimmt dabei linear ab, wie Wasser in einem Eimer mit konstantem Ausfluss.
#note("Fehler vermeiden", [_Eigene Ergänzung:_ „Ah“ ist eine Ladung (Strom × Zeit), keine Energie. Die Energie wäre $W = U dot.c Q = 12 thin "V" dot.c 36 thin "Ah" = 432 thin "Wh"$.], fill: sand)
#src([V S. 6–7; M S. 2; B S. 2 (VL 2); Ü 2.])
#hoch(<a-1>, [Kapitelübersicht])


== 1.1.3 Driftgeschwindigkeit und Stromleitung im Festkörper <a-1-1-3>
Setzt man in $I = n e l A\/t$ für $l\/t$ eine Geschwindigkeit ein, erhält man, wie schnell die Elektronen im Mittel wandern, die *Driftgeschwindigkeit*:
#form[$ I = n dot.c e dot.c v_d dot.c A quad => quad v_d = l/t = I/(n dot.c e dot.c A) $]
*Beispiel (V S. 8):* Kupferdraht, $A = 1 thin "mm"^2 = "0,01" thin "cm"^2$, $I = 16 thin "A"$:
$ v_d = (16 thin "A")/("8,44" dot.c 10^22 thin "cm"^(-3) dot.c "1,6" dot.c 10^(-19) thin "As" dot.c "0,01" thin "cm"^2) approx "0,12" thin "cm/s" = "1,2" thin "mm/s" $
Das ist Schneckentempo; das Berechnungsblatt in V S. 9 vergleicht ausdrücklich mit einer Schnecke (etwa 4,2 m/h = 1,2 mm/s). Dort steht auch ein zweites Zahlenbeispiel: 50 m Kupferleitung mit 1,5 mm² an 12 V, $I approx "16,66" thin "A"$, $v_d approx "0,82" thin "mm/s"$.
#bild("skript-impuls", [Der Impuls der Elektronen breitet sich rascher aus, als sie sich fortbewegen. V S. 8, Abb. 1.4.], height: 24mm)
#note("In eigenen Worten", [Das elektrische Feld breitet sich fast mit Lichtgeschwindigkeit aus. Alle Elektronen im Kreis beginnen praktisch gleichzeitig zu driften; kein Elektron muss vom Schalter zur Lampe laufen (V S. 8; M S. 1).])
#note("In eigenen Worten", [_Eigene Ergänzung:_ Ein Gartenschlauch, der schon voll Wasser ist: Drehst du den Hahn auf, kommt vorne sofort Wasser heraus, obwohl das Wasser vom Hahn noch lange nicht vorne ist.])
#note("Widerspruch in den Unterlagen", [V S. 8 nennt für den 1-mm²-Draht „dauernd 16 A zugelassen“, also 16 A/mm². V S. 10 nennt als zulässige Stromdichte aber nur $S_"zul" = 1 dots 6 thin "A/mm"^2$. Rechne das Beispiel so, wie es dasteht; für die Frage „zulässig?“ gilt S. 10. Am besten in der Vorlesung nachfragen.], fill: sand)
#note("Fehler vermeiden", [Einheiten konsequent einsetzen: $n$ ist in cm⁻³ gegeben, also $A$ in cm² umrechnen ($1 thin "mm"^2 = "0,01" thin "cm"^2$).], fill: sand)
#src([V S. 8–9 (Kap. 1.1.3 und 1.1.4 mit Berechnungsblatt Abb. 1.5); M S. 1.])
#hoch(<a-1>, [Kapitelübersicht])


== 1.1.5 Die Stromdichte <a-1-1-5>
Die *Stromdichte* sagt, wie viel Strom sich durch jeden mm² Querschnitt „quetschen“ muss. Je enger, desto mehr Reibung pro Fläche, desto heißer wird der Leiter. Nicht die Stromstärke allein, sondern die Stromdichte ist maßgebend für die Erwärmung (V S. 10; B S. 2: „Stromdichte entscheidet, wie warm etwas wird“).
#form[$ S = I/A = U/(R dot.c A) = U/(rho dot.c l\/A dot.c A) quad ["A/mm"^2] quad quad S_"zul" approx 1 dots 6 thin "A/mm"^2 $]
#grid(columns: (1fr, 1fr), gutter: 5mm,
 [#bild("skript-stromdichte", [Stromdichteverlauf bei Querschnittsänderung. V S. 10, Abb. 1.6.], height: 40mm)],
 [#bild("querschnitt", [Kontinuität: gleicher Strom, andere Stromdichte. Eigene Darstellung nach V S. 10.], height: 30mm)],
)
*Kontinuitätsbedingung.* Strom verschwindet nicht, Ladung bleibt erhalten:
#form[$ I_"Ein" = I_"Aus" quad => quad S_1 dot.c A_1 = S_2 dot.c A_2 $]
Größerer Querschnitt bedeutet kleinere Stromdichte (M S. 1). Die dünnste Stelle wird am heißesten; _eigene Ergänzung:_ darauf beruht die Schmelzsicherung.

*Praxis: Fernleitungen (V S. 10, Fußnote).* Die Verluste in der Leitung sind $P_"Verlust" = I^2 dot.c R_"Leitung"$. Damit trotzdem eine große Leistung $P = U dot.c I$ ankommt, macht man $U$ groß (z. B. 110 kV, 380 kV) und $I$ klein. Das geht nur mit Transformatoren, also mit Wechselstrom:
#form[$ U_1/U_2 = N_1/N_2 = I_2/I_1 $]
Deshalb setzte sich Teslas Wechselstrom gegen Edisons Gleichstrom durch. Deine Mitschrift hält fest: Der Transformator kann hohe Spannung auf kleine heruntersetzen und auch niedrige auf hohe, also in beide Richtungen (B S. 2). Dort steht auch „Spannung kleiner ⇒ es fließt größerer Strom“; das gilt bei gleicher übertragener Leistung $P = U I$ (Deutung ergänzt).
#src([V S. 10; M S. 1; B S. 2 (VL 2).])
#hoch(<a-1>, [Kapitelübersicht])


== 1.1.6 Die äußere Wirkung des Stromes <a-1-1-6>
Strom kann man nicht sehen. Man erkennt ihn an drei Wirkungen:
#tab(columns: (1fr, 1.6fr, 1.4fr),
 th([Wirkung], [Ursache], [Anwendung]),
 [1. Wärmewirkung], [Elektronenreibung im Leitermaterial], [_eigene Ergänzung:_ Heizlüfter, Wasserkocher, Sicherung],
 [2. Kraftwirkung], [Jeder Strom erzeugt ein Magnetfeld; Magnetfelder üben Kräfte aufeinander aus.], [Elektromagnet, E-Motor (V); Messgeräte],
 [3. Materialtransport], [Ionenstrom in flüssigen Leitern], [elektrochemische Prozesse (V); _eigene Ergänzung:_ Galvanisieren, Akku laden],
)
Alle drei Wirkungen kann man zum Messen benutzen; praktisch nutzt man vor allem die Kraftwirkung.
#bild("map-wirkungen", [Mindmap: Woran man Strom erkennt. Eigene Darstellung.], height: 44mm)

*Lorentzkraft.* Bewegte Ladung im Magnetfeld spürt eine Kraft senkrecht zur Bewegung und zum Feld. Mit $arrow(v) = arrow(l)\/t$ und $Q = I t$ kürzt sich die Zeit:
#form[$ arrow(F)_L = Q dot.c (arrow(v) times arrow(B)) quad => quad arrow(F)_L = I dot.c (arrow(l) times arrow(B)) quad quad "Betrag bei" arrow(l) perp arrow(B): quad F_L = I dot.c l dot.c B $]
$F_L$ in N, $B$ = magnetische Flussdichte in $"T" = "Vs/m"^2$. Je größer Strom, Leiterlänge im Feld oder Magnetfeld, desto größer die Kraft. Liegt der Leiter parallel zum Feld, ist das Kreuzprodukt null: keine Kraft. Beispiel aus deiner Mitschrift: Das laute Klacken und Rattern im MRT kommt von der Lorentzkraft auf die Spulen, deren Magnetfeld sehr hoch ist (B S. 1–2).
#bild("skript-lorentz", [Lorentzkraft auf eine stromdurchflossene Leiterschleife. V S. 12, Abb. 1.8, mit deiner Notiz.], height: 40mm)

*Drehspulinstrument.* Eine drehbar gelagerte Spule sitzt im Feld eines Dauermagneten. Fließt Strom, wirkt auf beide Längsseiten die Lorentzkraft, die Spule dreht sich; Spiralfedern halten dagegen.
#bild("skript-drehspul", [Drehspulinstrument zum Messen von Gleichströmen. V S. 11, Abb. 1.7, mit deinen Markierungen.], height: 58mm)
#form[$ M_"el" = N dot.c A dot.c B dot.c I quad (A = 2 r l) quad quad M_"mech" = D^* dot.c phi quad quad M_"el" = M_"mech" => phi = (N A B)/D^* dot.c I $]
$N$: Windungszahl; $A$: Fläche der Leiterschleife $2 r l$; $D^*$: Winkelrichtgröße der Rückstellfedern; $phi$: Zeigerausschlag.
#note("In eigenen Worten", [$phi ∼ I$: Der Ausschlag ist direkt proportional zum Strom. Doppelter Strom, doppelter Ausschlag. Deshalb hat das Instrument eine lineare Skala (V S. 13; M S. 2).])
#src([V S. 11–13; M S. 2; B S. 1–2 (VL 1–2).])
#hoch(<a-1>, [Kapitelübersicht])


== 1.1.7 Stromarten <a-1-1-7>
#bild("stromarten", [Gleichstrom und sinusförmiger Wechselstrom. Eigene Darstellung nach V S. 13, Abb. 1.9.], height: 36mm)
- *Gleichstrom* (DC, Direct Current): $i(t) = I = "konst."$ (Batterie, Akku).
- *Sinusförmiger Wechselstrom* (AC, Alternating Current): Die Richtung wechselt periodisch. Netz: $f = 50 thin "Hz" => T = 1\/f = 20 thin "ms"$. Effektivwert $I_"eff" = hat(i)\/sqrt(2)$ (V S. 13; M S. 2).
- *Nichtsinusförmiger Wechselstrom*: beliebige periodische Form mit der Periodendauer $T$; wird per Fourieranalyse in Sinusanteile zerlegt.
#note("In eigenen Worten", [_Eigene Ergänzung:_ Der Effektivwert ist der Gleichstromwert, der in einem Widerstand dieselbe Wärme erzeugt. Die 230 V der Steckdose sind ein Effektivwert; der Scheitelwert ist $hat(u) = 230 thin "V" dot.c sqrt(2) approx 325 thin "V"$. Deine Mitschrift notiert dazu $u_"eff" = hat(u)\/sqrt(2)$ beim Hausnetz (B S. 2).])
#src([V S. 13; M S. 2; B S. 2 (VL 2).])
#hoch(<a-1>, [Kapitelübersicht])


== 1.1.7.1 Drei Lampen und ein Schalter <a-1-1-7-1>
Drei identische Glühlampen liegen in Reihe an einer Batterie, der Schalter S liegt parallel zu Lampe C. Beim Schließen überbrückt er diese Lampe und verändert damit den gesamten Stromkreis.
#note("Modell für die Zahlenfaktoren", [Die Quelle und der Schalter seien ideal, die drei Lampen werden als gleiche *konstante Widerstände* behandelt. Reale Wolframwendeln sind PTCs (Abschnitt 1.4.3.2.1); ihre Widerstände ändern sich mit der Temperatur. Die angegebenen exakten Faktoren gehören daher zum vereinfachten Modell.], fill: sand)
#grid(columns: (1fr, 1.2fr), gutter: 5mm,
 [#bild("lampen", [Drei gleiche Lampen in Reihe, Schalter S parallel zu C. Eigene Darstellung nach V S. 14, Abb. 1.10.], height: 36mm)],
 [*S offen:* Reihenschaltung aus drei gleichen Lampen.
 $ R_"ges" = 3 R, quad I = U_q/(3 R), quad U_A = U_B = U_C = U_q/3 $
 *S zu:* Kurzschluss über C, C erlischt.
 $ R_"ges" = 2 R, quad I = U_q/(2 R), quad U_A = U_B = U_q/2, quad U_C = 0 $],
)
#note("Von dir markiert", [„Der Strom nimmt den Weg des geringsten Widerstandes !!!“ (B S. 2, mit Verweis auf V S. 14).])
#tab(columns: (1.3fr, 1.1fr, 1.6fr),
 th([Größe (S wird geschlossen)], [Änderung], [Begründung]),
 [Gesamtwiderstand], [sinkt (3R → 2R)], [C ist überbrückt],
 [Strom aus der Batterie], [steigt (×1,5)], [$I = U_q\/R_"ges"$],
 [Helligkeit A und B], [steigt (×2,25)], [$U$ von $U_q\/3$ auf $U_q\/2$; $P = U^2\/R$],
 [Helligkeit C], [erlischt], [kein Strom mehr durch C],
 [Spannung an C], [sinkt auf 0 V], [Kurzschluss],
 [Gesamtleistung], [steigt (×1,5)], [$P = U_q dot.c I$, $I$ steigt],
)
Die Faktoren sind eigene Rechnung. Mit den Zahlen aus deiner Mitschrift (12-V-Autobatterie): vorher jede Lampe 4 V, nachher A und B je 6 V, C 0 V (M S. 3).
#note("Fehler vermeiden", [Helligkeit hängt an der Leistung: $P = I^2 R = U I = U^2\/R$. Gehe immer in dieser Reihenfolge vor: $R_"ges"$ → $I$ → Teilspannungen → Leistungen.], fill: sand)
#src([V S. 14; M S. 2–3; B S. 2 (VL 2).])
#hoch(<a-1>, [Kapitelübersicht])


== 1.2.1 Quellspannung durch chemische Reaktion <a-1-2-1>
Damit eine Quellspannung entsteht, also ein „Elektronendruck“, muss in der Quelle aufgrund eines physikalischen Effekts eine *Ladungstrennung* stattfinden. In Akku, Trockenbatterie und Brennstoffzelle sorgt eine chemische Reaktion für einen Elektronenüberschuss am Minuspol gegenüber dem Pluspol. Im äußeren Lastkreis fließen die Elektronen vom Minus- zum Pluspol.
#bild("skript-chemie", [Quellspannung $U_q$ durch chemische Reaktion im Akku ($I$ in technischer Stromrichtung). V S. 15, Abb. 1.11.], height: 42mm)
- Energieumwandlung: chemische → elektrische Energie.
- Fließt Strom, werden die abfließenden Elektronen von der Reaktion ständig nachgeliefert; $U_q$ bleibt erhalten, bis die Chemie „verbraucht“ ist.
- Historisch nennt V das Leclanché-Element (1866). Die zusätzliche Behauptung „erste elektrische Batterie“ ist falsch: Voltas erste Batterie stammt bereits von 1800.
- Deine Mitschrift ergänzt: Beim Entleeren eines Akkus wird sein Innenwiderstand größer (B S. 1).
Die weiteren behandelten Effekte stehen in den Ergänzungen 1.2.3 bis 1.2.5: Temperaturdifferenz, Licht und mechanische Einwirkung können ebenfalls Ladungen trennen.
#note("Skriptfehler: Elektrodenbezeichnungen", [V S. 15 und die bisherige Lernskriptfassung ordnen Kathode dem Minuspol und Anode dem Pluspol zu. Beim gezeigten Entladen gilt dagegen: *Anode = Minuspol, Kathode = Pluspol*. Die Originalabbildung bleibt als Quelle erkennbar; ihre Beschriftung ist hier ausdrücklich berichtigt.], fill: sand)
#src([V S. 15; N, PDF-S. 2; M S. 3; B S. 1 (VL 1). Fachprüfung: #link("https://engineering.mit.edu/ask-an-engineer/how-does-a-battery-work")[MIT, How does a battery work?]; Geschichte: #link("https://www.eia.gov/kids/history-of-energy/timelines/electricity.php")[EIA, Electricity timeline].])
#hoch(<a-1>, [Kapitelübersicht])


== 1.2.2 Induktion <a-1-2-2>
Bewegt man eine Spule im Magnetfeld (oder einen Magneten in einer Spule), ändert sich der *magnetische Fluss* $Phi$ durch die Spule. Diese Änderung trennt Ladungen: Es entsteht eine induzierte Spannung $u_i$. Energieumwandlung: mechanische → elektrische Energie (Synchrongenerator, Gleichstromgenerator). Deine Mitschrift spricht bildlich von einer Spannung „aus dem Nichts“ (B S. 3). Gemeint ist eine Spannung ohne chemische Batterie; die elektrische Energie stammt beim Generator aus der zugeführten mechanischen Arbeit.
#bild("skript-induktion", [Quellspannung durch Induktion. V S. 16, Abb. 1.12.], height: 42mm)
#form[$ u_i = -N dot.c (dif Phi)/(dif t) quad "mit" quad dif Phi = dif B dot.c A quad => quad u_i = -N dot.c A dot.c (dif B)/(dif t) $]
$u_i$: induzierte Spannung in V; $N$: Windungszahl; $Phi$: magnetischer Fluss in $"Vs" = "Wb"$ (Weber); $B$: magnetische Flussdichte in $"Vs/m"^2 = "T"$. *Voraussetzung der vereinfachten Form $dif Phi = A dif B$:* konstante Fläche und Orientierung, homogenes Feld senkrecht durch die Fläche. Allgemein entscheidet die Flussänderung, auch durch eine Änderung der durchsetzten Fläche oder des Winkels.
#note("In eigenen Worten", [*Lenzsche Regel:* Das Minuszeichen bedeutet, dass die Induktionswirkung ihrer Ursache, der Flussänderung, entgegenwirkt. Deine Mitschrift: Die Spule „will, dass alles gleich bleibt“, und erzeugt selbst ein Magnetfeld (über den Strom), das den bisherigen Zustand aufrechterhalten möchte (B S. 3).])
#note("Von dir markiert", [Merksatz aus deiner Mitschrift: *Nur eine Änderung des magnetischen Flusses erzeugt eine Induktionsspannung.* Je schneller die Änderung und je größer die Windungszahl, desto größer der Betrag der induzierten Spannung. Ein ruhender Magnet in einer ruhenden Spule erzeugt nichts (M S. 4).])
*Zahlenbeispiel* (_eigene Ergänzung_): Spule mit $N = 200$ Windungen, der Fluss ändert sich gleichmäßig um 4 mWb in 20 ms:
$ abs(u_i) = N dot.c (Delta Phi)/(Delta t) = 200 dot.c ("4" dot.c 10^(-3) thin "Vs")/("0,02" thin "s") = 40 thin "V" $
Dieselbe Änderung in 10 ms ist doppelt so schnell: 80 V.

*Praxis (V S. 16, Fußnote):* Mit dem Induktionsgesetz kann man Magnetfelder messen. Man zieht eine kleine Messspule aus dem Feld und misst die durchgeflossene Ladung $Q = integral i thin dif t$. Mit $u_i = i R$ folgt $B = (R dot.c Q)\/(N dot.c A)$, unabhängig davon, wie schnell man zieht.
#bild("map-quellen", [Mindmap: Wie eine Quellspannung entsteht. Eigene Darstellung.], height: 44mm)
#src([V S. 16–17; N, PDF-S. 3–4 mit Markierung „Start VL 15.10.26“ und „Ende 15.10.26“; M S. 3–4; B S. 3 (VL 3). FK-N, PDF-S. 6, Aufgabe 28; Präzisierung der Voraussetzungen ergänzt.])
#hoch(<a-1>, [Kapitelübersicht])


== 1.2.3 Thermoeffekt · ergänzt aus der VL vom 15.10. <a-1-2-3>
Zwei unterschiedliche Metalle können eine Temperaturdifferenz in eine elektrische Spannung übersetzen. Das ist der *Seebeck-Effekt*: Ein *Thermoelement* aus Kupfer und Konstantan vergleicht die Temperatur seiner Messstelle mit der Temperatur der Vergleichsstelle an den Anschlüssen.
#bild("skript-thermo", [Thermoelement aus Kupfer und Konstantan. N, PDF-S. 4 = V S. 17, Abb. 1.13.], height: 42mm)
#form[$ U_q approx K dot.c Delta vartheta quad Delta vartheta = vartheta_1 - vartheta_2 quad K = "0,05" thin "mV/K" quad "(Cu–Konstantan, Skriptwert)" $]
$U_q$: Thermospannung in mV; $K$: näherungsweise konstanter Thermokoeffizient; $Delta vartheta$: Temperaturdifferenz in K. Die Zahlenwerte einer Differenz sind in K und °C gleich. *Gültigkeit:* lineare Näherung mit dem angegebenen Koeffizienten; Materialpaar, Temperaturbereich und Polung beachten. $K$ ist hier der Koeffizient, nicht die Einheit Kelvin.

*Beispiel, eigene Ergänzung:* Messstelle 80 °C, Vergleichsstelle 20 °C: $Delta vartheta = 60 thin "K"$, also $U_q approx "0,05" thin "mV/K" dot.c 60 thin "K" = 3 thin "mV"$. Werden beide Stellen gleich warm, ist die Spannung null; vertauscht man die Temperaturen, kehrt sich ihre Polung um.
#note("Gültigkeit und Skriptangabe", [V S. 17 nennt einen Temperaturbereich „bis 1000 °C“. Das darfst du nicht pauschal auf Cu–Konstantan übertragen: Herstellerangaben für Typ T reichen bis etwa 400 °C, abhängig von der Ausführung. Auch der konstante Skriptwert 0,05 mV/K ist eine Rechennäherung. Für unsere Aufgaben verwenden wir den angegebenen Wert; eine reale Messung braucht die passende Kennlinie.], fill: sand)
#note("In eigenen Worten", [Es fehlt die Temperatur der Vergleichsstelle. Dieselbe Messstelle liefert bei unterschiedlich warmen Anschlüssen unterschiedliche Spannungen.])
#src([N, PDF-S. 4 = V S. 17, Abschnitt 1.2.3; Beispiel und Erklärung der Vergleichsstelle ergänzt. Fachprüfung des Temperaturbereichs: #link("https://www.emerson.com/en/measurement-instrumentation/catalog/temperature-measurement/temperature-sensors/type-t-thermocouple")[Emerson, Type T Thermocouple].])
#hoch(<a-1>, [Kapitelübersicht])


== 1.2.4 Fotoeffekt · VL vom 22.10. <a-1-2-4>
Eine Solarzelle wandelt *Strahlungsenergie* in elektrische Energie um. Im Halbleiter erzeugt geeignetes Licht *Elektron-Loch-Paare*: ein bewegliches Elektron und eine positiv wirkende Lücke. Ein inneres elektrisches Feld trennt beide, sodass im äußeren Kreis ein Fotostrom fließen kann.
#note("Von dir markiert", [Auf V S. 18 beginnt laut deiner roten Markierung die Vorlesung vom 22.10.; ihr Ende ist auf S. 19 vermerkt. Die Randnotiz „Leitwert = 1/R“ verknüpft das Thema mit $G = 1/R$ aus Abschnitt 0.2.])
#bild("skript-foto", [Quellspannung durch Fotoeffekt im Halbleiter. N, PDF-S. 5 = V S. 18, Abb. 1.14.], height: 42mm)
#form[$ I_"Foto" = f("Lichtstärke, Wellenlänge") quad U_q = I_"Foto" dot.c R $]
$I_"Foto"$: Fotostrom in A; $R$: äußerer Lastwiderstand in Ω; $U_q$: Spannung am Lastwiderstand in V. Die zweite Gleichung ist das Ohmsche Gesetz am angeschlossenen Widerstand. Sie bedeutet nicht, dass eine Solarzelle bei beliebigem $R$ denselben Strom liefert: Strom und Spannung müssen zum *Arbeitspunkt* passen.

=== 1.2.4.1 Photonenergie und Bandlücke <a-1-2-4-g>
Ein *Photon* ist ein Energiepaket des Lichts. Die *Bandlücke* $W$ ist die nötige Mindestenergie, um im hier betrachteten Modell ein Elektron-Loch-Paar zu erzeugen. Das Formelzeichen $W$ meint an dieser Stelle eine Energie, keine Leistung in Watt.
#form[$ E_"Photon" = h nu = (h c)/lambda quad nu_g = W/h quad lambda_g = (h c)/W $]
$nu$: Lichtfrequenz in Hz; $lambda$: Wellenlänge in m; $h approx "6,626" dot.c 10^(-34) thin "Js"$: Planck-Konstante (für die Rechnungen gerundet); $c = 299792458 thin "m/s"$: Lichtgeschwindigkeit. $W$ muss in J eingesetzt werden; $1 thin "eV" = "1,602176634" dot.c 10^(-19) thin "J"$.
#tab(columns: (1fr, 1.15fr, 1.2fr),
 th([Material], [Bandlücke bei 300 K], [Grenzwellenlänge laut V]),
 [GaAs], [1,42 eV], [0,88 µm],
 [Silizium (Si)], [1,12 eV], [1,11 µm],
 [Germanium (Ge)], [0,67 eV], [1,85 µm],
)
*Silizium, nach V S. 19 nachgerechnet:*
$ lambda_g = ("6,626" dot.c 10^(-34) thin "Js" dot.c 299792458 thin "m/s")/("1,12" dot.c "1,602176634" dot.c 10^(-19) thin "J") approx "1,107" thin mu"m" $

#note("Grenze richtig lesen", [Für die Erzeugung über die Bandlücke braucht man $h nu >= W$, also $nu >= nu_g$ bzw. $lambda <= lambda_g$. Jenseits der langwelligen Grenze ($lambda > lambda_g$) reicht die Photonenergie nicht. V S. 18 formuliert das Verschwinden mit „≤“ bzw. „≥“ an der Grenze; die Gleichheit bezeichnet den idealen Schwellenfall. Eine reale Empfindlichkeitskurve ist keine scharfe Rechteckkante.], fill: sand)
*In eigenen Worten:* Mehr Licht kann mehr geeignete Photonen liefern. Eine zu große Wellenlänge wird dadurch im einfachen Modell nicht kurz genug: Die Energie eines einzelnen Photons bleibt zu klein. Anwendungen laut V: fotoelektronische Steuerungen, Solarzellen und Photovoltaik; Fotodioden wandeln Licht in ein Messsignal um. Die erwähnte Lawinenfotodiode verstärkt das Signal intern; die Durchbruchidee ist in deiner Randnotiz skizziert.
#src([N, PDF-S. 5–6 = V S. 18–19, Abschnitt 1.2.4 und Tabelle 1.1; Umrechnung und Erklärhilfen ergänzt. Fachprüfung des Bandlückenmodells: #link("https://hub.hamamatsu.com/us/en/technical-notes/detector-selection/guide-to-detector-selection.html")[Hamamatsu, Guide to Detector Selection].])
#hoch(<a-1>, [Kapitelübersicht])


== 1.2.5 Piezoeffekt · VL vom 22.10. <a-1-2-5>
Drückst oder ziehst du an einem geeigneten Kristall, verschieben sich Ladungen im Kristallgitter. An seinen Elektroden entsteht eine Spannung. Dieser *direkte Piezoeffekt* macht aus einer mechanischen Einwirkung ein elektrisches Signal, etwa im Kristallmikrofon oder Tonabnehmer.
#bild("skript-piezo", [Piezo-Kristall, elektrisches Ersatzbild und Schwingquarz. N, PDF-S. 6 = V S. 19, Abb. 1.15–1.16.], height: 60mm)
#tab(columns: (1.15fr, 1.5fr, 1.3fr),
 th([Richtung], [Vorgang], [Anwendung laut V]),
 [Direkter Effekt], [Kraft → Ladungsverschiebung → Spannung], [Kristallmikrofon, Tonabnehmer],
 [Umgekehrter Effekt], [Spannung → Verformung des Kristalls], [Ultraschallerzeugung, Schwingquarz],
)
*Voraussetzung:* Der Kristall muss piezoelektrisch sein; die Richtung der Kraft zum Kristallgitter zählt (*Piezo-Achse*). Es funktioniert nicht mit jedem Material in jeder Richtung. Eine allgemeine Zahlenformel für Spannung aus Kraft ist in diesem Abschnitt des Skripts nicht angegeben; dafür fehlen Material- und Geometriedaten.

*Schwingquarz als Taktgeber.* Die mechanische Schwingung und die elektrische Spannung beeinflussen sich gegenseitig. Das Ersatzbild rechts beschreibt das Resonanzverhalten; seine Berechnung gehört noch nicht zu dieser Ergänzung. Für die Uhr-Anwendung ist die Frequenzteilung entscheidend:
#form[$ f_"Quarz" = 32768 thin "Hz" = 2^15 thin "Hz" quad => quad f_"Takt" = f_"Quarz"/2^15 = 1 thin "Hz" quad T = 1/f_"Takt" = 1 thin "s" $]
*Gültigkeit:* Quarzfrequenz 32768 Hz und elektronische Teilung durch $2^15$. Die Elektronik teilt die Frequenz; der Quarz schwingt weiterhin mit 32768 Hz.
#note("In eigenen Worten", [Als Sensor liefert eine mechanische Einwirkung ein elektrisches Signal. Beim umgekehrten Effekt erzeugt eine angelegte Spannung eine mechanische Verformung.])
#src([N, PDF-S. 6 = V S. 19, Abschnitt 1.2.5 und Abb. 1.15–1.16; Erklärung der Frequenzteilung ergänzt.])
#hoch(<a-1>, [Kapitelübersicht])


== 1.2.6 Ergänzungen aus den Randnotizen vom 15. und 22.10. <a-1-2-6>
Die neuen Randnotizen verbinden die Quellen mit Bauteilen, deren Verhalten nicht durch einen konstanten Widerstand allein beschrieben wird. Bei der Spule zählt die zeitliche Stromänderung; bei der Diode eine gekrümmte Kennlinie. Dieser Abschnitt übernimmt nur die dort skizzierten Zusammenhänge.

=== 1.2.6.1 Spule: Strom baut sich verzögert auf <a-1-2-6-l>
Eine Spule wirkt der Änderung ihres Stroms entgegen (*Selbstinduktion*). Nach dem Einschalten einer Gleichspannung steigt der Strom deshalb allmählich an. $L$ heißt *Induktivität*; ihre Einheit ist Henry: $1 thin "H" = 1 thin "Vs/A"$.
#bild("rl-verlauf", [Einschaltvorgang mit den Zahlen deiner Randnotiz. Eigene Darstellung nach N, PDF-S. 3, rechter Rand zu V S. 16.], height: 58mm)
#form[$ tau = L/R quad I_oo = U_q/R quad i(t) = I_oo (1 - e^(-t/tau)) quad u_L(t) = U_q e^(-t/tau) $]
$tau$: Zeitkonstante in s; $R$: gesamter Serienwiderstand in Ω; $I_oo$: Strom im eingeschwungenen Zustand; $u_L$: Spannung an der Spule im Verbraucherzählpfeilsystem. *Voraussetzungen:* konstante ideale Gleichspannung wird bei $t = 0$ eingeschaltet, $i(0) = 0$, konstante lineare Induktivität und konstanter Widerstand. Dann gilt $U_q = R i(t) + u_L(t)$.

*Deine Zahlen:* $U_q = 12 thin "V"$, $R = 10 thin Omega$, $L = 10 thin "mH"$. Daraus folgen $I_oo = "1,2" thin "A"$ und $tau = "0,01" thin "H"/(10 thin Omega) = "0,001" thin "s" = 1 thin "ms"$. Nach einer Zeitkonstante fließen rund $"0,759" thin "A"$; nach fünf Zeitkonstanten etwa 99,3 % des Endstroms (eigene Rechnung).
#note("Die Ausschalt-Skizze einordnen", [Die Randnotiz zeichnet auch eine Gegenpolung beim Ausschalten. Der Strom kann bei endlicher Spannung nicht sprunghaft verschwinden. Der genaue Verlauf hängt vom verbleibenden Strompfad ab: Für eine geschlossene Entladeschleife aus $L$ und $R$ gilt $i(t) = I_0 e^(-t/tau)$; eine vollständig geöffnete Leitung ist ein anderer Fall und kann eine hohe Spannungsspitze verursachen. Die Formel $12 thin "V" dot.c e^(-t/tau)$ beschreibt hier die Spulenspannung beim Einschalten, nicht pauschal jedes Ausschalten.], fill: sand)
#src([N, PDF-S. 3, Randnotizen neben V S. 16; Werte und Einschaltformel aus der Mitschrift, Kurven und Zahlen ergänzt. Fachprüfung: #link("https://ez.analog.com/adiacademy/university-program/a/studentzone-articles/SA1047/adalm1000-smu-training-topic-5-transient-response-of-rl-circuit")[Analog Devices, Transient Response of RL Circuit]; Ausschalten: #link("https://www.tdk.com/en/tech-mag/electronics_primer/2")[TDK, The Basics of Inductors].])

=== 1.2.6.2 Diode: Arbeitspunkt mit einer gekrümmten Kennlinie <a-1-2-6-d>
Eine *Diode* leitet in Durchlassrichtung viel stärker als in Sperrrichtung. Sie hat keine ohmsche Ursprungsgerade; deine Skizze zeigt eine stark ansteigende Durchlasskennlinie. Im Sperrbereich ist der Strom zunächst klein, beim eingezeichneten Durchbruch wächst sein Betrag stark.
#bild("notiz-diode", [Diode, beleuchtete Kennlinie und Arbeitsgerade aus deiner Randnotiz. N, PDF-S. 6, neben Tabelle 1.1 auf V S. 19.], height: 48mm)
#form[$ U_q = I R + U_D quad => quad I = (U_q - U_D)/R $]
$U_D$: Diodenspannung in V; $R$: Serienwiderstand in Ω; $I$: gemeinsamer Strom in A. *Voraussetzung:* Gleichstrom-Arbeitspunkt einer Reihenschaltung aus idealer Quelle, Vorwiderstand und Diode. Die Gleichung beschreibt die grüne *Arbeitsgerade*, nicht die Diodenkennlinie.

*So liest du den Arbeitspunkt:* Bei $U_D = 0$ schneidet die Arbeitsgerade die Stromachse bei $U_q/R$; bei $I = 0$ schneidet sie die Spannungsachse bei $U_q$. Der Schnittpunkt mit der Diodenkennlinie liefert die tatsächlich zusammenpassenden Werte. Das ist dieselbe Schnittpunktidee wie beim Grundstromkreis in Abschnitt 2.4.1.
#note("Fehler vermeiden", [„Leitwert = $1/R$“ ist die Definition für einen Widerstand. Eine gekrümmte Diodenkennlinie hat keinen überall gleichen Widerstand. Die beleuchtete Kennlinie deiner Skizze liegt tiefer: Der Fotostrom kommt zur Diodenwirkung hinzu. Eine LED und eine beleuchtete Fotodiode nutzen dabei unterschiedliche Betriebsweisen; die gezeichneten Kurven sind qualitativ.], fill: sand)
#src([N, PDF-S. 6, handschriftliche Diodenkennlinien und 9-V-Schaltung neben V S. 19; Arbeitsgerade durch Umstellen des Maschenumlaufs ergänzt.])

#bild("map-quelleneffekte", [Mindmap: Chemie, Induktion, Thermo-, Foto- und Piezoeffekt. Eigene Darstellung nach V S. 15–19.], height: 40mm)
#src([Zusammenführung von V S. 15–19 und N, PDF-S. 2–6; eigene Darstellung.])

#hoch(<a-1>, [Kapitelübersicht])

== 1.3 Der Potenzialbegriff · VL vom 30.10. <a-1-3>
Das *Potenzial* $phi_A$ ist die Spannung eines Punktes A gegenüber einem festgelegten Bezugspunkt. Wie bei Höhenangaben brauchst du zuerst „Meereshöhe null“: In der Schaltung ist das meist die *Masse* oder Ground, der du 0 V zuweist. Eine Spannung zwischen zwei Punkten ist dagegen die Differenz ihrer Potenziale.
#bild("vl30-potential", [Potenziale und Potenzialverlauf. N30, PDF-S. 1 = V S. 20, Abb. 1.17, mit deinen Notizen.], height: 55mm)
#form[$ phi_A = U_(A "Masse") quad U_(A B) = phi_A - phi_B quad U_(B A) = -U_(A B) $]
$phi$, $U$ in V. *Voraussetzung:* Alle verglichenen Potenziale beziehen sich auf denselben Nullpunkt. Im idealen Draht ohne Widerstand bleibt das Potenzial gleich. Über einem passiven Widerstand fällt es in Richtung des positiven technischen Stroms ab; eine Quelle kann es anheben.
#note("Von dir markiert · ★ Klausur", [Auf V S. 20 hast du „Prüfungsaufgabe: geben sie das Potential an dieser oder jener Stelle an!“ vermerkt. Lege daher zuerst den Bezugspunkt fest und gehe dann mit den Spannungspfeilen durch die Schaltung.])

*Den Verlauf verstehen:* Mit D als Masse liegen B und C bei +30 V, E bei −20 V sowie F und A bei −60 V. Die Quellspannung zwischen A und B beträgt 90 V. Das sind die Werte aus den Spannungsabfällen 30 V, 20 V und 40 V; die Zeichnung des Verlaufs ist qualitativ und ersetzt die Rechnung nicht.

#bild("vl30-bruecke", [Zwei Spannungsteiler mit offenem Querzweig. N30, PDF-S. 2 = V S. 21, Abb. 1.18.], height: 47mm)
Im offenen Querzweig gilt $phi_A = 5 thin "V"$ und $phi_B = 8 thin "V"$. Deshalb ist $U_(A B) = -3 thin "V"$ und $U_(B A) = +3 thin "V"$. Ein negatives Ergebnis bedeutet eine zur gewählten Richtung entgegengesetzte Spannung. Wird zwischen A und B ein Widerstand angeschlossen, belastet er beide Teiler und verändert die Potenziale; die unbelasteten 5 V und 8 V gelten dann nicht unverändert.
#note("In eigenen Worten", [Beide Potenziale verschieben sich um denselben Wert. Ihre Differenz und damit die physikalische Spannung bleibt gleich.])
#src[N30, PDF-S. 1–2 = V S. 20–21, Abschnitt 1.3; Höhenvergleich und Rechenprüfung ergänzt.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.4.1 Widerstand und Leitwert gleichförmiger Körper <a-1-4-1>
Ein Draht bremst den Ladungstransport abhängig von Material und Geometrie. Eine längere Strecke bietet mehr Widerstand; eine größere Querschnittsfläche mehr parallele Wege. Die in Abschnitt 0.2 eingeführten Größen werden jetzt mit Materialwerten und Voraussetzungen verbunden.
#form[$ R = rho l/A = l/(kappa A) quad G = 1/R = kappa A/l quad rho = 1/kappa $]
$R$ in Ω, $G$ in S; $rho$ in $Omega thin "mm"^2/"m"$; $kappa$ in $"m"/(Omega thin "mm"^2)$; $l$ in m, $A$ in mm². *Gültigkeit:* gleichförmiger Leiter bei der zum Materialwert gehörenden Temperatur, hier 20 °C. Bei einer Zweidrahtleitung tragen Hin- und Rückleiter zum Gesamtwiderstand bei.
#tab(columns: (1fr, 1.5fr, 1.5fr),
 th([Material], [$rho_20$ in Ω mm²/m], [$kappa_20$ in m/(Ω mm²)]),
 [Silber], [0,016], [62,5],
 [Kupfer], [0,0178], [56],
 [Gold], [0,022], [45],
 [Aluminium], [0,0286], [35],
 [Eisen], [0,1 … 0,15], [10 … 7],
)
Die Tabellenwerte sind gerundet. Ein größerer Leitwert bedeutet einen kleineren Widerstand; *Leitwert* $G$ beschreibt das konkrete Bauteil, *Leitfähigkeit* $kappa$ das Material.
#note("Von dir markiert", [Neben der Materialtabelle steht „In Prüfung einheiten richtig kürzen“. Mit $rho$ in Ω mm²/m, $l$ in m und $A$ in mm² bleibt bei $rho l/A$ genau Ω übrig.])
#note("Verschiedene Aluminiumwerte", [V S. 22 nennt 0,0286 Ω mm²/m; Ü 7 und das bisherige Schulwissen rechnen mit 0,0278 Ω mm²/m. Beide Fassungen bleiben kenntlich: Verwende den ausdrücklich vorgegebenen Aufgabenwert, sonst die zum Abschnitt gehörende Tabelle.], fill: sand)
#src[N30, PDF-S. 3 = V S. 22, Abschnitt 1.4.1 und Materialtabelle; Ü 7 für den abweichenden Aluminiumwert.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.4.2 Ohmsches Gesetz und Leitungsabfall <a-1-4-2>
Ein *passiver Zweipol* wird über zwei Klemmen angeschlossen und enthält im betrachteten Modell keine eigene Quellspannung. Für einen Arbeitspunkt mit $I != 0$ lässt sich das Verhältnis $R = U/I$ bilden. Ein *ohmscher Widerstand* hat darüber hinaus bei festen Bedingungen ein konstantes $R$: Strom und Spannung sind proportional.
#form[$ U = R I quad I = U/R = G U quad R = U/I $]
*Gültigkeit:* konstantes $R$ nur beim linearen, ohmschen Modell; bei temperaturabhängigen oder nichtlinearen Bauteilen nicht ungeprüft auf andere Betriebspunkte übertragen.
#bild("vl30-leitung", [Motor mit Hin- und Rückleiter und Bezugspunkt C. N30, PDF-S. 4 = V S. 23, Abb. 1.19.], height: 44mm)
Bei der gezeigten 25-m-Leitung fließt der Strom auch 25 m zurück. Die erlaubte Spannungsdifferenz von 220 V auf 216 V entfällt insgesamt auf beide Leiter. Für symmetrische Leiter sind das 2 V je Leiter. Daher ergeben sich rechnerisch 0,1 Ω je Leiter und mindestens 4,45 mm² Kupferquerschnitt; aus der im Skript genannten Reihe wird 6 mm² gewählt.
#note("Gültigkeit", [Die Querschnittsrechnung in V S. 24 prüft den Spannungsabfall. Die thermische Belastbarkeit muss zusätzlich geprüft werden. Ein günstiger Spannungsabfall allein ist keine vollständige Auslegung.], fill: sand)
Mit C als Bezugspunkt gilt für die im Bild angenommenen Spannungsabfälle: $phi_C = 0$, $phi_B = 216 thin "V"$, $phi_D = -2 thin "V"$ und $phi_A = 218 thin "V"$. Auch ein negativer Masse-bezogener Wert passt damit zur positiven Quellspannung von 220 V zwischen A und D.
#src[N30, PDF-S. 4–5 = V S. 23–24, Abschnitt 1.4.2; Zahlen beziehen sich auf die angenommenen Spannungsabfälle von je 2 V, nicht auf eine Neuberechnung mit 6 mm². Vollständige Rechenaufgabe in Aufgaben.typ.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.4.3 Widerstandsarten und Kennlinien <a-1-4-3>
Eine *Kennlinie* zeigt, welcher Strom zu welcher Spannung gehört. Lies zuerst die Achsen: In unseren $I$-$U$-Diagrammen steht die Spannung waagerecht, der Strom senkrecht. Eine steile Ursprungsgerade bedeutet großen Leitwert und kleinen Widerstand; bei einer gekrümmten Kennlinie hängt die Steigung vom Arbeitspunkt ab.
#bild("map-widerstandsarten", [Mindmap: Die behandelten Widerstandsarten. Eigene Darstellung nach V S. 25–33.], height: 44mm)

=== 1.4.3.1 Lineare Widerstände <a-1-4-3-1>
Für einen linearen Widerstand ist das Verhältnis $U/I$ bei unveränderten Bedingungen konstant. Seine Kennlinie ist eine Gerade durch den Ursprung:
#form[$ R = U_1/I_1 = U_2/I_2 = "konstant" quad G = (Delta I)/(Delta U) = 1/R $]
Eine Erwärmung kann den Widerstand ändern: Dann gehört zur neuen Temperatur eine andere Gerade. „Linear“ heißt also nicht, dass ein Material unabhängig von der Temperatur immer denselben Widerstand hat.
#src[N30, PDF-S. 6 = V S. 25, Abschnitt 1.4.3.1; Abgrenzung der Temperaturbedingung ergänzt.]

=== 1.4.3.2 Nichtlineare Widerstände <a-1-4-3-2>
Bei nichtlinearen Bauteilen ist $U/I$ nicht überall gleich. Du brauchst die Kennlinie, eine zum Betrieb passende Gleichung oder ein Modell. *Die Kirchhoffschen Gesetze gelten weiterhin*: Nichtlinearität ändert das Bauteilverhalten, nicht die Strom- und Spannungsbilanzen des hier behandelten Netzwerks.
#src[N30, PDF-S. 7 = V S. 26, Abschnitt 1.4.3.2.]

=== 1.4.3.2.1 Kaltleiter (PTC) <a-1-4-3-2-1>
Ein *Kaltleiter* hat einen positiven Temperaturkoeffizienten: Wird er wärmer, steigt sein Widerstand. Das Skript nennt Wolfram mit einem Widerstandsverhältnis kalt zu warm von ungefähr 1 : 15 sowie dotiertes Bleititanat.
#bild("vl30-ptc", [Kaltleiter: Strom-Spannungs- und Temperaturkennlinien. N30, PDF-S. 7 = V S. 26, Abb. 1.22.], height: 43mm)
Eine kalte Glühwendel lässt zunächst mehr Strom zu als im heißen Betrieb. Der Anfangsstrom kann die Wendel gerade beim Einschalten stark beanspruchen. Weitere Anwendungen sind Temperaturerfassung, Überlastschutz und einfache Heizregler. Die Bezeichnung „Kaltleiter“ beschreibt das bessere Leiten bei niedriger Temperatur.
#src[N30, PDF-S. 7 = V S. 26, einschließlich Fußnote 11.]

=== 1.4.3.2.2 Heißleiter (NTC) <a-1-4-3-2-2>
Beim *Heißleiter* sinkt der Widerstand mit steigender Temperatur. Wärme kann von außen kommen oder durch den eigenen Strom entstehen. Deshalb muss ein Messheißleiter mit so kleiner Messleistung betrieben werden, dass er seine zu messende Temperatur kaum selbst verändert.
#bild("vl30-ntc", [Heißleiter: Kennlinien und Reihenschaltung. N30, PDF-S. 8 = V S. 27, Abb. 1.23.], height: 49mm)
#form[$ R(T) = R_(T_0) e^(B (1/T - 1/T_0)) $]
$T$, $T_0$ sind absolute Temperaturen in K; $B$ ist die Materialkonstante in K. *Voraussetzung:* das angegebene NTC-Modell und sein Gültigkeitsbereich. Für die Skriptwerte $R_(T_0) = 10 thin "k"Omega$, $T_0 = 293 thin "K"$ und $B = 2800 thin "K"$ ergibt sich bei 373 K rechnerisch etwa 1,29 kΩ. Die Skizze nennt rund 1,5 kΩ; ihre gerundete Beschriftung ist nicht mit einer genauen Auswertung dieser Parameter gleichzusetzen.
#note("Fehler vermeiden", [In der Exponentialgleichung niemals 20 oder 100 als Celsiuszahl einsetzen: Die Kehrwerte $1/T$ verlangen Kelvin. Anwendungen laut V: Temperaturmessung, Temperaturkompensation, Einschaltstrombegrenzung und Relaisverzögerung.], fill: sand)
#src[N30, PDF-S. 8 = V S. 27; Nachrechnung ergänzt. Fachprüfung der Selbsterwärmung: #link("https://www.murata.com/en-us/products/thermistor/ntc/overview/basic/characteristic")[Murata, Basic Characteristics of NTC Thermistor].]

=== 1.4.3.2.3 Spannungsabhängiger Widerstand (VDR) <a-1-4-3-2-3>
Ein *Varistor* oder VDR wird bei hoher Spannung viel leitfähiger. Als paralleler Schutzpfad kann er einen großen Teil eines Überspannungsstroms übernehmen. Bei normaler Betriebsspannung ist sein Strom vergleichsweise klein.
#bild("vl30-vdr", [Varistor und Begrenzung einer Spannungsspitze. N30, PDF-S. 9 = V S. 28, Abb. 1.24.], height: 50mm)
#form[$ I/(1 thin "A") = (U/(220 thin "V"))^5 $]
*Gültigkeit:* Das ist die beispielhafte positive Kennlinie aus V S. 28, kein universelles Varistorgesetz. Die Quotienten im Potenzterm sind dimensionslos. Wächst die Spannung um den Faktor 2, steigt der Strom in diesem Modell um $2^5 = 32$; der Quotient $U/I$ sinkt stark.
#src[N30, PDF-S. 9 = V S. 28, Abschnitt 1.4.3.2.3.]

=== 1.4.3.2.4 Diode: Durchlass, Sperren und Kleinsignal <a-1-4-3-2-4>
Die *Anode* und die am Bauteilring erkennbare *Kathode* bestimmen die Polung einer Diode. Eine Siliziumdiode leitet in Durchlassrichtung mit positiver Anode gegenüber der Kathode; in Sperrrichtung ist der Strom vor dem Durchbruch klein. Werte wie 0,6 V oder 1 V sind Betriebspunkte bzw. Näherungen, keine für jeden Strom feste Diodenspannung.
#bild("vl30-diode", [Siliziumdiode in Durchlass- und Sperrrichtung. N30, PDF-S. 10 = V S. 29, Abb. 1.26.], height: 62mm)
#form[$ I_D = I_S (e^(U_D/(n U_T)) - 1) quad U_T = (k T)/e approx 26 thin "mV" quad "bei Raumtemperatur" $]
$I_S$: Sättigungsstrom des Modells (im Skript „Sperrstrom“); $n$: Emissionskoeffizient, ideal 1; $U_T$: Temperaturspannung; $k$: Boltzmann-Konstante, $T$ in K, $e$: Elementarladung. *Gültigkeit:* Shockley-Modell im geeigneten Betriebsbereich, ohne Durchbruch und ohne Berücksichtigung größerer Serienwiderstandseffekte.

*Zwei Widerstandsbegriffe:* Der *statische Widerstand* verbindet den Ursprung mit dem Arbeitspunkt: $R_D = U_D/I_D$. Der *differenzielle Widerstand* beschreibt die örtliche Tangente, also die Reaktion auf eine kleine Änderung:
#form[$ g_d = (dif I_D)/(dif U_D) quad r_e = 1/g_d = (dif U_D)/(dif I_D) approx (n U_T)/I_D quad "für" I_D >> I_S $]
#bild("vl30-tangente", [Tangente im Arbeitspunkt der BAY41-Diode. N30, PDF-S. 12 = V S. 31, Abb. 1.28.], height: 35mm)
Bei 0,6 V und 2 mA ist $R_D = 300 thin Omega$. Mit $n = 1$ und $U_T approx 26 thin "mV"$ ist dagegen $r_e approx 13 thin Omega$. Die 13 Ω gelten nur für kleine Änderungen um diesen Arbeitspunkt. Sie ersetzen weder den ganzen Diodenstromkreis noch die vollständige Kennlinie.
#src[N30, PDF-S. 10–12 = V S. 29–31; Begriffe und Gültigkeit präzisiert. Fachprüfung: #link("https://wiki.analog.com/university/courses/electronics/text/chapter-5")[Analog Devices, Solid-state diodes and diode characteristics].]

=== 1.4.3.2.4.1 LED: Lichtenergie und elektrischer Arbeitspunkt <a-1-4-3-2-4-1>
Eine *Leuchtdiode* wandelt einen Teil ihrer elektrischen Leistung in Strahlungsleistung um. Die Energiebetrachtung verbindet die Lichtwellenlänge mit einer Spannungsskala; der tatsächliche Arbeitspunkt muss zusätzlich zur elektrischen Kennlinie passen.
#form[$ h f = e U_"Schwelle" quad f = c/lambda quad => quad U_"Schwelle" = (h c)/(e lambda) quad P_"opt" = eta_"LED" U_D I_D $]
$h$ in Js, $c$ in m/s, $lambda$ in m; $eta_"LED"$ ist der optische Wirkungsgrad bezogen auf die elektrische Leistung *der LED*. *Gültigkeit:* vereinfachte Energiebetrachtung aus dem Aufgabenblatt; keine allgemeine exakte Durchlassspannung bei beliebigem Strom. Für die dort „grün“ genannte LED ist ausdrücklich $lambda = 580 thin "nm"$ vorgegeben.
#bild("led-kennlinie-aufgabe", [Elektrische LED-Kennlinie ohne Lösungseintragungen. Nachgezeichnet aus LED, PDF-S. 1; Ablesediagramm.], height: 54mm)
Ein Netzwerk vor der LED kann bezüglich ihrer Klemmen durch Leerlaufspannung und Kurzschlussstrom beschrieben werden. Die Gerade durch diese beiden Achsenschnittpunkte trifft die LED-Kennlinie im Arbeitspunkt. *Leerlauf* heißt hier: nur die LED abklemmen; ein im Netzwerk vorhandener Parallelwiderstand bleibt angeschlossen.
#note("Fehler vermeiden", [Photonenenergie, statische Durchlassspannung und Tangentensteigung sind verschiedene Angaben. Für die optische Leistung zählt $U_D I_D$, nicht die gesamte Quellleistung einschließlich der anderen Widerstände. Die vollständige LED-Aufgabe mit Schaltung und allen Teilfragen steht in Aufgaben.typ.], fill: sand)
#src[LED, PDF-S. 1–3; Energiebeziehung und Wirkungsgrad aus der Aufgabenstellung, elektrische Einordnung ergänzt.]

=== 1.4.3.2.5 Transistor: Steuern und Lastgerade <a-1-4-3-2-5>
Ein *Bipolartransistor* hat Basis B, Kollektor C und Emitter E. Im aktiven Bereich steuert ein kleiner Basisstrom $I_B$ den größeren Kollektorstrom $I_C$. Das Skript beschreibt ihn anschaulich als elektronisch regelbaren Widerstand; die Ausgangskennlinien zeigen genauer eine annähernd stromgesteuerte Stromquelle.
#bild("vl30-transistor", [Steuerkreis und Lastkreis eines Transistors. N30, PDF-S. 13 = V S. 32, Abb. 1.29.], height: 38mm)
#form[$ beta = I_C/I_B quad I_C approx beta I_B quad I_E = I_B + I_C quad U_q = U_(C E) + I_C R_L $]
*Gültigkeit:* $I_C approx beta I_B$ als Gleichstrommodell im aktiven Bereich; $beta$ ist bauteil- und betriebspunktabhängig. Die Quelle und der Lastwiderstand begrenzen den tatsächlich möglichen Strom. Im Sättigungsbetrieb darf die einfache Verstärkungsbeziehung nicht unbesehen weiterverwendet werden.
#bild("vl30-transistorfeld", [Ausgangskennlinienfeld, Lastgerade und 0,5-W-Grenze. N30, PDF-S. 14 = V S. 33, Abb. 1.32, mit deinen Eintragungen.], height: 55mm)
Eine bestimmte Basisstrom-Kennlinie schneidet die Lastgerade im Arbeitspunkt. Gleichzeitig muss die *Verlustleistung* $P_T = U_(C E) I_C$ unter der zulässigen Grenze bleiben. Die Hyperbel $P_T = "0,5" thin "W"$ verbindet die Punkte gleicher Verlustleistung; sie ist keine zusätzliche Lastgerade.
#src[N30, PDF-S. 13–14 = V S. 32–33, einschließlich Abb. 1.31 für die Stromaufteilung; Modellgrenzen erläutert.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.4.4 Temperaturgang von Widerständen <a-1-4-4>
Ein Widerstandswert braucht eine Temperaturangabe. Metalle werden beim Erwärmen meist hochohmiger; Konstantan ändert sich nur wenig. Der *Temperaturkoeffizient* $alpha_20$ gibt die relative Widerstandsänderung je Kelvin gegenüber dem Wert bei 20 °C an.
#form[$ Delta vartheta = vartheta - 20 thin "°C" quad R(vartheta) approx R_20 (1 + alpha_20 Delta vartheta) $]
*Gültigkeit:* lineare Näherung im für das Material passenden Bereich; V S. 34 nennt 0 bis 200 °C. Über größere Bereiche verwendet das Skript einen quadratischen Term:
#form[$ R(vartheta) approx R_20 (1 + alpha_20 Delta vartheta + beta_20 (Delta vartheta)^2) $]
$alpha_20$ in $"1/K"$, $beta_20$ in $"1/K"^2$, $Delta vartheta$ in K; beide Klammerterme sind dimensionslos. Bei Materialwerten mit negativem $alpha$ sinkt $R$ beim Erwärmen.
#tab(columns: (1fr, 1.3fr, 1.2fr), th([Material], [$alpha_20$ in 1/K], [$beta_20$ in 1/K²]),
 [Kupfer], [$"3,93" dot.c 10^(-3)$], [$"0,6" dot.c 10^(-6)$],
 [Aluminium], [$"3,77" dot.c 10^(-3)$], [$"1,3" dot.c 10^(-6)$],
 [Konstantan], [$"3,5" dot.c 10^(-6)$], [nicht angegeben],
 [Kohle], [$-("0,2" dots "0,8") dot.c 10^(-3)$], [nicht angegeben],
)
*Umgekehrt messen:* Aus einer Widerstandsänderung lässt sich im linearen Modell die Temperaturänderung berechnen: $Delta vartheta = (R/R_20 - 1)/alpha_20$. Das Skript nennt die Bestimmung der Wicklungstemperatur elektrischer Maschinen als Anwendung.
#note("Fehler vermeiden", [Temperatur und Temperaturdifferenz auseinanderhalten: $T/(1 thin "K") = vartheta/(1 thin "°C") + "273,15"$. Ein Temperaturanstieg um 10 °C ist ein Anstieg um 10 K, nicht um 283,15 K. Die Celsius-Skala wird als verschobene Temperaturskala verwendet; Kelvin ist die SI-Basiseinheit.], fill: sand)
#src[N30, PDF-S. 15 = V S. 34, Abschnitt 1.4.4 und Tabelle; Begriffe und Umkehrformel erläutert.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.5 Energie und Leistung · konstant und zeitabhängig <a-1-5>
*Energie* beschreibt die Fähigkeit, Arbeit zu verrichten; *Leistung* sagt, wie schnell Energie umgesetzt wird. Eine Quelle erzeugt keine Energie aus dem Nichts: Bei der im Skript gezeigten Wasserkraft wird Lageenergie über mechanische Arbeit in elektrische Energie umgewandelt.
#form[$ W_"el" = U Q = U I t quad P = W_"el"/t = U I quad P_R = I^2 R = U^2/R $]
*Gültigkeit:* die ersten Produktformen mit konstantem $U$, $I$ bzw. $P$; die Widerstandsformen am ohmschen Widerstand. Energie in J = Ws, Leistung in W = J/s. Ein Elektronenvolt ist die Energie einer Elementarladung beim Durchlaufen von 1 V, keine Spannungseinheit.
#bild("vl30-leistung", [Momentanleistung, Energiefläche und mittlere Leistung. N30, PDF-S. 17 = V S. 36, Abb. 1.34.], height: 52mm)
#form[$ p(t) = u(t) i(t) quad W_"el" = integral_0^(t_1) p(t) dif t quad P_"mittel" = W_"el"/t_1 $]
*Gültigkeit:* zeitabhängige Größen im gewählten Zeitraum; nicht ohne Weiteres Mittelwert der Spannung mal Mittelwert des Stroms rechnen. Die Fläche unter der Leistungskurve ist die Energie. Die mittlere Leistung ist die Höhe des flächengleichen Rechtecks über derselben Zeitspanne. Für die Erwärmung ist die mittlere Verlustleistung wichtig.
#note("In eigenen Worten", [Leistung ist die Geschwindigkeit der Energieumsetzung. Zwei Geräte können in einer Stunde dieselbe Energie umsetzen, obwohl eines gleichmäßig arbeitet und das andere kurze hohe Leistungsspitzen hat. Für das Rechteck müssen Fläche und Zeitdauer passen.])
#src[N30, PDF-S. 16–18 = V S. 35–37; Formeln, Wasserkraftbeispiel und Energie-/Leistungsbegriffe; Alltagsbeispiel ergänzt.]
#hoch(<a-1>, [Kapitelübersicht])

*Der Zusammenhang in Kapitel 1.* Potenziale machen Spannungsunterschiede eindeutig; Kennlinien verbinden sie mit dem Strom. Material und Temperatur bestimmen das Verhalten von Widerständen, Halbleiter reagieren darüber hinaus nichtlinear. Energie und Leistung bewerten die Wirkung des Stromkreises. Strom beschreibt bewegte Ladung. Die Elektronen driften langsam; das elektrische Feld vermittelt die Wirkung rasch. Stromdichte und Material bestimmen die Erwärmung, Wärme-, Kraft- und chemische Wirkung machen Strom erkennbar. Quellen trennen Ladungen durch Chemie, Flussänderung, Temperaturdifferenz, Licht oder Kraft. Die Randnotizen verbinden diese Grundlagen mit der verzögerten Stromänderung einer Spule und dem Arbeitspunkt einer Diode.
#hoch(<a-1>, [Kapitelübersicht])


#pagebreak(weak: true)
= Kapitel 2 · Kirchhoffsche Gesetze und Grundstromkreis <a-2>

#überblick([Kapitel 2 auf einen Blick],
 idee(<a-2-1>, [Am Knoten bleibt Ladung erhalten.], [Die zufließenden und abfließenden Ströme gleichen sich aus.]),
 idee(<a-2-2>, [Eine Masche schließt die Spannungsbilanz.], [Umlaufsinn und Zählpfeile legen die Vorzeichen fest.]),
 idee(<a-2-4-5>, [Reihe und Parallel richtig erkennen.], [Spannungs- und Stromteiler folgen aus den beiden Kirchhoffschen Regeln.]),
 idee(<a-2-4-1>, [Die reale Quelle hat einen Innenwiderstand.], [Unter Last sinkt die Klemmenspannung; der Kurzschlussstrom bleibt endlich.]),
 idee(<a-2-4-7>, [Messgeräte belasten die Schaltung.], [Die passende Messanordnung und Brückenabgleich begrenzen den Eigenverbrauch.]),
 idee(<a-2-5-1>, [Umwandlungen erhalten das Klemmenverhalten.], [Stern, Dreieck und passende Quellenformen vereinfachen vermaschte Netze.]),
)

#bild("map-netzwerk", [Mindmap: Potenziale, Knoten, Maschen und Kennlinien verbinden. Eigene Darstellung nach V S. 20–21 und 39–41.], height: 40mm)
#src[Eigene Zusammenführung von N30, PDF-S. 1–2 und 20–22.]

#ablauf(
  chunk([Quelle und Last modellieren], [Quellspannung · Innenwiderstand · Außenwiderstand], ziel: <a-2-4-1>),
  chunk([Arbeitspunkt bestimmen], [Maschenumlauf oder Schnittpunkt der Kennlinien], ziel: <a-2-4-1-k>),
  chunk([Leistungsbilanz prüfen], [Quellenleistung = innere Verluste + Lastleistung], ziel: <a-2-4-3>),
  entscheidung([Ist maximale Lastleistung das Ziel?],
    chunk([Leistungsanpassung], [Außenwiderstand = Innenwiderstand · Wirkungsgrad 50 %], ziel: <a-2-4-3>),
    chunk([Anderes Ziel prüfen], [für hohen Wirkungsgrad Außenwiderstand deutlich größer wählen], ziel: <a-2-4-3>)),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])


Mit Knoten- und Maschenregel bestimmst du Ströme und Spannungen über die Erhaltungssätze. Kennlinien ergänzen das Verhalten nichtlinearer Bauteile. Der zuvor vorgezogene Grundstromkreis bleibt als Anwendung mit realer Quelle, Last und Leistungsbilanz erhalten. Für das Selbststudium folgen nun auch die weiteren Widerstands- und Messschaltungen sowie Netzwerkumwandlungen bis V S. 67.

== 2.1 Der Knotenpunktsatz <a-2-1>
An einem *Knoten* treffen Leiter zusammen. Im stationären Netzwerk sammelt sich dort keine Ladung an: Was pro Zeit hineinfließt, fließt auch wieder heraus. Das ist dieselbe Ladungserhaltung wie bei der Kontinuität im unverzweigten Draht, jetzt mit mehreren Wegen.
#bild("vl30-knoten", [Zufließende und abfließende Ströme. N30, PDF-S. 20 = V S. 39, Abb. 2.1.], height: 31mm)
#form[$ sum I_"zu" = sum I_"ab" quad "bzw. mit Vorzeichen:" quad sum_(nu=1)^n I_nu = 0 $]
*Vorzeichenkonvention:* z. B. zufließende Ströme positiv, abfließende negativ. Für die Pfeile im Bild: $I_1 + I_3 - I_2 - I_4 = 0$. Ein negativ berechneter Strom fließt entgegen seinem angenommenen Zählpfeil; das ist ein zulässiges Ergebnis.
#note("Fehler vermeiden", [„Die Summe ist null“ meint eine vorzeichenbehaftete Summe. Alle Strombeträge ohne Richtungsunterscheidung zu addieren kann keine Knotenbilanz ergeben.])
#src[N30, PDF-S. 20 = V S. 39, Abschnitt 2.1; Zusammenhang mit Ladungserhaltung ergänzt.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.2 Der Maschensatz <a-2-2>
Eine *Masche* ist ein geschlossener Weg durch die Schaltung. Kehrst du zum Ausgangspunkt zurück, bist du wieder beim selben Potenzial. Deshalb ist die Summe der vorzeichenrichtig gezählten Spannungen null.
#bild("vl30-masche", [Umlaufsinn und Spannungspfeile einer Masche. N30, PDF-S. 21 = V S. 40, Abb. 2.2.], height: 49mm)
#form[$ sum_(nu=1)^n U_nu = 0 quad "im Bild:" quad U_q + U_1 + U_2 - U_3 = 0 $]
*Vorgehen:* Umlaufsinn wählen. Spannungspfeile in Umlaufrichtung positiv zählen, entgegen der Umlaufrichtung negativ. An einem ohmschen Widerstand im Verbraucherzählpfeilsystem gilt $U_k = R_k I_k$ mit den gewählten Vorzeichen. Die Polung einer idealen Quelle legt ihren Spannungspfeil fest, unabhängig von der tatsächlichen Stromrichtung.
#note("In eigenen Worten", [Jedes Vorzeichen kehrt sich um. Die ganze Gleichung wird mit −1 multipliziert und beschreibt denselben physikalischen Zusammenhang.])
*Gültigkeit:* das hier behandelte konzentrierte Gleichstromnetzwerk. Ein zusätzlich von außen induzierter Spannungsbeitrag müsste im erweiterten Modell mit erfasst werden.
#src[N30, PDF-S. 21 = V S. 40, Abschnitt 2.2; Potenzialerklärung und Modellabgrenzung ergänzt.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.3 Nichtlineare Netzwerke systematisch auswerten <a-2-3>
Auch bei gekrümmten Bauteilkennlinien gelten Knoten- und Maschenregel. Der Trick ist, zuerst eine bekannte Zweiggröße zu verwenden: Aus einem vorgegebenen Strom liest du die zugehörige Bauteilspannung ab. Danach verbindest du die Zweige über gleiche Klemmenpotenziale und Strombilanzen.
#bild("vl30-netzkennlinie", [Kennlinien der nichtlinearen Widerstände R1 und R3. N30, PDF-S. 22 = V S. 41, rechter Teil von Abschnitt 2.3.], height: 43mm)
#ablauf(
 chunk([Bekannten Zweig auswerten], [Kennlinie lesen · ohmsche Spannungsabfälle ergänzen], ziel: <a-1-4-3>),
 chunk([Gemeinsame Klemmenpotenziale verbinden], [gleiche Zweigspannung · Quellpolung beachten], ziel: <a-1-3>),
 chunk([Knotenbilanz aufstellen], [Ströme mit Zählpfeilen · negatives Ergebnis deuten], ziel: <a-2-1>),
 chunk([Leistung und Plausibilität prüfen], [p = u · i · Maschenbilanz kontrollieren], ziel: <a-1-5>),
)
Der Quotient $U/I$ aus einem Arbeitspunkt ist kein konstanter Ersatzwiderstand für die gesamte gekrümmte Kennlinie. Für einen neuen Strom musst du die Kennlinie erneut auswerten. Die vollständig vorgegebene Netzwerkaufgabe aus V S. 41 steht mit Schaltung, Kennlinien und Lösung in Aufgaben.typ.
#src[N30, PDF-S. 22 = V S. 41, Abschnitt 2.3 und deine eingetragenen Potenziale; Lösungsstrategie als eigene Zusammenführung.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.4.1 Der Grundstromkreis: reale Quelle mit Verbraucher <a-2-4-1>
*Experiment (V S. 42):* Schließt man einen Akku kurz, müsste bei einer idealen Quelle ein unendlich hoher Kurzschlussstrom fließen: $I_k = U_q\/R$ mit $R = 0$ ergäbe $I_k -> oo$. Tatsächlich ist $I_k$ endlich (z. B. 200 A). In der Quelle muss also ein Widerstand stecken, der den Strom begrenzt: der *Innenwiderstand* $R_i$. Deine Mitschrift: „Innenwiderstand ist wichtig“ (B S. 1).
#grid(columns: (1fr, 1fr), gutter: 5mm,
 [#bild("skript-grundstromkreis", [Grundstromkreis mit Generator und Verbraucher. V S. 42, Abb. 2.3.], height: 34mm)],
 [#bild("grundstromkreis", [Dasselbe Ersatzschaltbild; gestrichelt die reale Quelle. Eigene Darstellung.], height: 34mm)],
)
Bei positivem Spannungswert weist der Spannungspfeil vom höheren zum niedrigeren Potenzial; ein negativer Wert bedeutet die umgekehrte tatsächliche Reihenfolge. Im Verbraucher fließt der Strom von + nach −; Strom- und Spannungspfeil zeigen dort in dieselbe Richtung (*Verbraucherzählpfeilsystem*). Der Umlauf um die Masche ergibt:
#form[$ U_i + U_a - U_q = 0 quad quad I = U_q/(R_i + R_a) quad quad U_a = U_q - U_i = I dot.c R_a $]
*Grenzfälle* zeigen, was $R_i$ bewirkt:
#tab(columns: (1fr, 1.2fr, 1.2fr),
 th([], [Leerlauf], [Kurzschluss]),
 [Außenwiderstand], [$R_a = oo$ (nichts angeschlossen)], [$R_a = 0$ (Pole direkt verbunden)],
 [Strom], [$I = 0$], [maximal: $I_k = U_q\/R_i$],
 [Klemmenspannung], [maximal: $U_a = U_l = U_q$], [$U_a = 0$],
 [Spannung an $R_i$], [0 V (kein Strom)], [ganz $U_q$],
)
#form[$ R_i = "Leerlaufspannung"/"Kurzschlussstrom" = U_l/I_k $]
#note("In eigenen Worten", [Leerlauf = maximale Klemmenspannung, kein Strom. Kurzschluss = maximaler Strom, keine Klemmenspannung. Je kleiner $R_i$, desto größer der Kurzschlussstrom (M S. 3–4).])

*Beispiel aus deiner Zusammenfassung:* $U_q = 9 thin "V"$, $R_i = 300 thin Omega$, $R_a = 500 thin Omega$.
#bild("zf-grundstromkreis", [Reale Spannungsquelle mit Abschluss. Z S. 1, Ausschnitt.], height: 52mm)
+ Strom: $I = 9 thin "V"\/800 thin Omega = "11,25" thin "mA"$
+ Spannung am Innenwiderstand: $U_i = I R_i = "3,375" thin "V"$
+ Klemmenspannung: $U_a = I R_a = "5,625" thin "V"$. Probe: $"3,375" + "5,625" = 9 thin "V"$.
+ Kurzschlussstrom: $I_k = 9 thin "V"\/300 thin Omega = 30 thin "mA"$
#note("Fehler vermeiden", [In deiner Zusammenfassung stehen $I = "11,23" thin "mA"$ und $P_a = "63,68" thin "mW"$. Richtig sind $9\/800 = "11,25" thin "mA"$ und $P_a = "5,625" thin "V" dot.c "11,25" thin "mA" approx "63,28" thin "mW"$. Deine Werte für $U_i$, $U_a$, $P_i$ und $P_q$ stimmen.], fill: sand)
#bild("map-grundstromkreis", [Mindmap: Modell, Grenzfälle und Anpassung. Eigene Darstellung.], height: 44mm)

=== 2.4.1.1 Kennlinien und Arbeitspunkt <a-2-4-1-k>
Man kann den Grundstromkreis auch zeichnerisch lösen. Dazu trägt man zwei Kennlinien in ein $I$-$U$-Diagramm ein:
- *Quellenkennlinie:* Gerade von $I_k$ auf der $I$-Achse (bei $U = 0$) bis $U_l = U_q$ auf der $U$-Achse (bei $I = 0$).
- *Widerstandsgerade:* Ursprungsgerade mit der Steigung $1\/R_a$. Je steiler, desto kleiner der Widerstand.
- Der Schnittpunkt ist der *Arbeitspunkt* (AP): Dort passen Strom und Spannung von Quelle und Verbraucher zusammen.
#grid(columns: (1fr, 1fr), gutter: 5mm,
 [#bild("zf-kennlinie", [Kennlinien in deiner Zusammenfassung. Z S. 1, Ausschnitt.], height: 48mm)],
 [#bild("kennlinie", [Dieselben Kennlinien, $U_q = 9 thin "V"$, $R_i = 300 thin Omega$. Eigene Darstellung nach Z S. 1.], height: 48mm)],
)
#form[$ I(U) = -1/R_i dot.c U + I_k = -G_i dot.c U + I_k $]
Probe: Bei $U = U_q$ ist $I = -U_q\/R_i + I_k = 0$. Die Steigung der Quellenkennlinie ist $-1\/R_i$ (Z S. 2, Geradengleichung $y = m x + b$). Wird $R_a$ kleiner (z. B. $R_a' = 50 thin Omega$ wie in deiner Zusammenfassung), wird die Gerade steiler und der AP wandert nach links oben: mehr Strom, weniger Spannung (AP₂, eigene Rechnung: 1,29 V, 25,7 mA). Wird $R_a$ größer, wandert der AP Richtung Leerlauf. Die Rechteckfläche $U_a dot.c I$ unter dem AP ist die Verbraucherleistung $P_a$, das Rechteck rechts daneben bis $U_q$ die Verlustleistung $P_i$ in der Quelle.
#src([V S. 42; Z S. 1–2; M S. 3–4; B S. 1 (VL 1).])
#hoch(<a-2>, [Kapitelübersicht])



=== 2.4.1.2 Mehrere reale Spannungsquellen verbinden <a-2-4-1-2>
In Reihe addieren sich die *vorzeichenrichtig gezählten Quellspannungen*, während sich die Innenwiderstände immer addieren. Zwei gleiche Polungen unterstützen einander; gegeneinander gerichtete Quellen kompensieren sich teilweise.
#bild("gesamt-quellen-reihe", [Summen- und Gegenschaltung realer Quellen. V S. 43, Abb. 2.4–2.5.], height: 59mm)
#form[$ U_"q,ers"=sum_k s_k U_(q k) quad R_"i,ers"=sum_k R_(i k) quad I=U_"q,ers"/(R_a+R_"i,ers") $]
$s_k$ ist +1 oder −1 entsprechend der Polung zum gewählten Umlauf. Das Vorzeichen von $I$ legt die tatsächliche Richtung fest. Eine ideale Spannungsquelle kann dabei auch Leistung aufnehmen; ihre Polung bestimmt nicht allein die Stromrichtung.

Für $n$ *gleiche, gleich gepolte* reale Quellen parallel gilt dagegen:
#form[$ U_"q,ers"=U_q quad R_"i,ers"=R_i/n quad I=U_q/(R_i/n+R_a) $]
#bild("gesamt-quellen-parallel", [Gleiche Quellen parallel: gleiche Spannung, geteilter Innenwiderstand. V S. 44, Abb. 2.6.], height: 42mm)
Jede Quelle trägt im symmetrischen Modell den Anteil $I/n$. Gleiche Akkus können so länger denselben Laststrom liefern; ihre Ladungskapazitäten addieren sich im vereinfachten Modell. *Gültigkeit:* gleiche Quellspannungen und Innenwiderstände, gleiche Polung und kompatibles Quellenmodell. Bei ungleichen Quellen sind Ausgleichsströme möglich; dann ist eine Netzwerkrechnung nötig.
#src[V S. 43–44; Rechenregeln und Vorzeichenbedingung erläutert.]

#hoch(<a-2>, [Kapitelübersicht])

== 2.4.2 Spannungseinbruch unter Last <a-2-4-2>
*V S. 43 und Ü 3:* Ein Heizwiderstand von 31,2 Ω wird ans Netz gelegt. Die Netzspannung beträgt im Leerlauf 230 V, im Einschaltmoment sinkt die Klemmenspannung auf 218 V. Die Spannungsdifferenz beschreibt den inneren Spannungsabfall des Quellenmodells.
+ Ersatzschaltbild: Grundstromkreis aus Abschnitt 2.4.1 mit $U_q = 230 thin "V"$ und $R_a = "31,2" thin Omega$.
+ Strom aus der Last: $I = U_a\/R_a = 218\/"31,2" approx "6,99" thin "A"$
+ Spannung, die innen abfällt: $U_i = 230 - 218 = 12 thin "V"$
+ $R_i = U_i\/I = 12\/"6,99" approx "1,7" thin Omega$, wie auf dem Übungsblatt.
#note("In eigenen Worten", [Die Differenz zwischen Leerlauf- und Klemmenspannung fällt immer an $R_i$ ab.])
#note("Deinen Rechenweg einordnen", [DC, PDF-S. 4, unterscheidet den Leerlauf ($I = 0$, kein innerer Spannungsabfall) und den Lastfall (12 V Spannungsabfall bei rund 7 A). Die dort notierten 135 A Kurzschlussstrom entstehen aus dem gerundeten $R_i = "1,7"$ Ω; mit dem ungerundeten Wert sind es rund 134 A. Das ist eine Modellrechnung, kein zusätzlich gemessener Wert.])
#src([V S. 43; Ü 3; DC, PDF-S. 1 und 4.])
#hoch(<a-2>, [Kapitelübersicht])


== 2.4.3 Die Leistungsverhältnisse im Grundstromkreis <a-2-4-3>
*Leistungsbilanz.* Quellenleistung = Verlustleistung + Verbraucherleistung:
#form[$ underbrace(U_q dot.c I, P_q) = underbrace(I^2 dot.c R_i, P_v) + underbrace(I dot.c U_a, P_a) quad quad eta = P_a/P_q = R_a/(R_i + R_a) = 1/(1 + R_i\/R_a) $]
*Werte aus deiner Zusammenfassung:* $P_a = "5,625" thin "V" dot.c "11,25" thin "mA" approx "63,28" thin "mW"$, $P_i = "3,375" thin "V" dot.c "11,25" thin "mA" approx "37,97" thin "mW"$, $P_q = 9 thin "V" dot.c "11,25" thin "mA" = "101,25" thin "mW"$; Summe stimmt. Wirkungsgrad (eigene Rechnung): $eta = 500\/800 = "62,5" thin %$.

*Leistungsanpassung.* Bei welchem $R_a$ bekommt der Verbraucher die meiste Leistung? Zwei Extreme helfen: Bei $R_a = 0$ fließt viel Strom, aber $U_a = 0$, also $P_a = 0$. Bei $R_a = oo$ ist $U_a$ maximal, aber $I = 0$, also wieder $P_a = 0$. Dazwischen liegt ein Maximum. Das Skript differenziert $P_a = U_q I - I^2 R_i$ nach $I$:
#form[$ P_a = (U_q^2 dot.c R_a)/(R_i + R_a)^2 quad quad (dif P_a)/(dif I) = U_q - 2 I R_i = 0 quad => quad I = U_q/(2 R_i) = U_q/(R_i + R_a) quad => quad R_a = R_i $]
#form[$ P_"a,max" = U_q^2/(4 R_i) quad quad U_a = U_q/2 quad quad I = I_k/2 quad quad eta = 50 thin % $]
#grid(columns: (1.1fr, 1fr), gutter: 5mm,
 [#bild("skript-anpassung", [Grundstromkreis im Anpassungsfall, $eta = 50 thin %$. V S. 46, Abb. 2.8.], height: 40mm)],
 [#bild("anpassung", [Leistungsminderung bei Fehlanpassung, $P_a\/P_"a,max" = 4 (R_a\/R_i)\/(1 + R_a\/R_i)^2$. Eigene Darstellung nach V S. 46.], height: 40mm)],
)
#note("In eigenen Worten", [$R_a = R_i$ heißt maximale Leistung am Verbraucher, aber nur 50 % Wirkungsgrad: Die Quelle verheizt innen genauso viel, wie sie abgibt ($P_q = 2 P_"a,max"$, V S. 46). Deine Zusammenfassung: $R_i = R_a$ ⇒ maximale Leistung (Z S. 1).])
*Mit den Zahlen der Zusammenfassung weitergerechnet* (_eigene Ergänzung_): Anpassung bei $R_a = 300 thin Omega$ ergibt $P_"a,max" = (9 thin "V")^2\/(4 dot.c 300 thin Omega) = "67,5" thin "mW"$. Mit $R_a = 500 thin Omega$ bekommst du 63,28 mW, also rund 94 % davon, aber mit besserem Wirkungsgrad (62,5 % statt 50 %).

_Eigene Ergänzung:_ In der Nachrichtentechnik (Antenne, Lautsprecher) ist Anpassung erwünscht, dort zählt die maximale Signalleistung. In der Energietechnik (Kraftwerk, Netz) gilt $R_a >> R_i$, denn dort zählt der Wirkungsgrad.
#note("Fehler vermeiden", [Leistungsanpassung ist *nicht* der Fall mit dem besten Wirkungsgrad. $eta$ steigt, je größer $R_a$ gegenüber $R_i$ ist; im Kurzschluss ist $eta = 0$.], fill: sand)
#src([V S. 44–46; Z S. 1; FK 30.])

#hoch(<a-2>, [Kapitelübersicht])

== 2.4.4 Reihenschaltung und Spannungsteiler <a-2-4-4>
In einer *Reihenschaltung* gibt es zwischen den Bauteilen keine Stromverzweigung. Derselbe Strom fließt durch alle Widerstände. Wie bei mehreren Engstellen hintereinander addieren sich die nötigen Spannungsabfälle.
#bild("gesamt-serie", [Reihenschaltung mit frei gewähltem Maschenumlauf. V S. 47, Abb. 2.10.], height: 32mm)
#form[$ R_"ges" = sum_(nu=1)^n R_nu quad U_k = U_"ges" R_k/R_"ges" quad U_1/U_2 = R_1/R_2 $]
*Voraussetzung:* lineare Widerstände und derselbe Strom durch die betrachteten Teile. Ein Spannungsteiler belastet seine Quelle; sein Ausgang ist nur dann *unbelastet*, wenn dort kein zusätzlicher Strom abfließt. Die größere Teilresistenz übernimmt bei gleichem Strom den größeren Spannungsabfall.
#note("Fehler vermeiden", [„Hintereinander gezeichnet“ genügt nicht. Ein zusätzlicher Zweig am Zwischenknoten beendet die reine Reihenschaltung. Dann zuerst die tatsächlich parallelen Teile zusammenfassen.], fill: sand)
#src[V S. 47, Abschnitt 2.4.4; Erklärbild und Abgrenzung ergänzt.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.4.5 Parallelschaltung und Stromteiler <a-2-4-5>
*Parallel* heißt: Beide Anschlüsse eines Bauteils liegen an denselben zwei Knoten wie die Anschlüsse des anderen. Deshalb ist die Spannung gleich. Der besser leitende Zweig übernimmt mehr Strom.
#bild("gesamt-parallel", [Parallele Zweige mit gemeinsamer Spannung. V S. 48, Abb. 2.11.], height: 38mm)
#form[$ G_"ges" = sum_k G_k quad 1/R_"ges" = sum_k 1/R_k quad I_k/I_"ges" = G_k/G_"ges" = R_"ges"/R_k $]
Für zwei Zweige:
#form[$ R_1 parallel R_2 = (R_1 R_2)/(R_1+R_2) quad I_1 = I_"ges" R_2/(R_1+R_2) $]
$G$ in S, $R$ in Ω, $I$ in A. *Voraussetzung:* ohmsche Zweige zwischen denselben Knoten. Der Ersatzwiderstand ist kleiner als der kleinste Einzelwiderstand: Der zweite Weg erleichtert den Ladungstransport.
#note("Der richtige Gesamtwiderstand", [In der Stromteilerregel bezeichnet $R_"ges"$ nur den Ersatz der gerade betrachteten Verzweigung. Ein davor liegender Serienwiderstand gehört nicht in diesen Quotienten. Beim Zweig 1 steht für zwei Zweige der Widerstand des anderen Zweigs im Zähler.], fill: sand)
#bild("gesamt-teiler-kaskade", [Gemischtes Netzwerk: erst Teilnetze erkennen. V S. 49, Abb. 2.12.], height: 37mm)
*Vom Detail zum Ganzen und zurück:* Erst innere Serien- und Parallelgruppen ersetzen. Dann den Gesamtstrom bestimmen. Anschließend vom äußeren Ersatzschaltbild zurück zu den Teilspannungen und Teilströmen gehen. Die beiden Beispiele von V S. 49–50 stehen vollständig in den Aufgaben.
#src[V S. 48–50, Abschnitt 2.4.5; Vorgehensfolge als eigene Zusammenführung.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.4.6 Der belastete Spannungsteiler <a-2-4-6>
Bei einem *Potenziometer* teilt ein beweglicher Schleifer den Gesamtwiderstand $R_S$ in $R_1$ und $R_2$. Eine angeschlossene Last $R_A$ liegt parallel zum unteren Teil $R_2$. Sie zieht dessen Ersatzwiderstand nach unten: Die Ausgangsspannung fällt kleiner aus als im Leerlauf.
#bild("gesamt-potenziometer", [Belasteter Stellwiderstand mit Schleiferstellung x. V S. 51, Abb. 2.14.], height: 48mm)
#form[$ R_S = R_1+R_2 quad x = R_2/R_S quad R_p = R_2 parallel R_A quad U_A = U_E R_p/(R_1+R_p) $]
Mit $R_1=(1-x)R_S$ und $R_2=x R_S$ folgt die normierte Stellkennlinie:
#form[$ U_A/U_E = I_A/I_"A,max" = x/(1+(R_S/R_A)(x-x^2)) quad I_"A,max" = U_E/R_A $]
*Gültigkeit:* ideale konstante Eingangsspannung, lineare positive Widerstände, feste Last, $0 <= x <= 1$. Der zusätzliche Term im Nenner erklärt die Abweichung von der idealen Geraden $U_A/U_E=x$. Für $R_S << R_A$ ist die Lastwirkung klein.
#note("Belastbarkeit des Schleifers", [Für die Auslegung eines gewendelten Teilers verlangt V S. 54 $I_"zul" >= U_E/R_A + U_E/R_S$. Nahe der oberen Endstellung kann die letzte Windung praktisch Laststrom und Querstrom zugleich führen. Eine hohe Nennleistung des gesamten Widerstands erlaubt nicht automatisch jeden Schleiferstrom.], fill: sand)
#src[V S. 51–54, Abschnitt 2.4.6; Ersatzbildung und Nennerdeutung erläutert.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.4.7 Widerstand messen: Das Messgerät gehört zur Schaltung <a-2-4-7>
Ein reales Amperemeter besitzt einen kleinen Innenwiderstand $R_"AM"$ und verbraucht Spannung. Ein reales Voltmeter besitzt einen großen Innenwiderstand $R_"VM"$ und zieht Strom. Der Quotient aus den beiden Anzeigen kann deshalb vom gesuchten Widerstand abweichen.
#tab(columns: (1fr,1.65fr,1.65fr), th([Schaltung],[Spannungsrichtig],[Stromrichtig]),
 [Direkt richtig], [Spannung am Prüfling], [Strom durch den Prüfling],
 [Miterfasst], [Voltmeterstrom beim Amperemeter], [Amperemeter-Spannung beim Voltmeter],
 [Unkorrigiertes $U/I$], [zu klein], [zu groß],
 [Günstig], [$R_x << R_"VM"$], [$R_x >> R_"AM"$],
)
#grid(columns: (1fr,1fr), gutter: 5mm,
 [#bild("gesamt-messung-u", [Spannungsrichtig. V S. 55, Abb. 2.16.], height: 42mm)],
 [#bild("gesamt-messung-i", [Stromrichtig. V S. 56, Abb. 2.17.], height: 42mm)],
)
#form[$ "spannungsrichtig:" quad R_x = U_x/(I-U_x/R_"VM") quad "stromrichtig:" quad R_x = U/I_x-R_"AM" $]
Instrumentenwerte aus Angaben auf dem Messgerät:
#form[$ R_"AM" = (Delta U_"Endwert")/I_"Endwert" quad R_"VM" = K U_"Bereichsendwert" $]
$K$ ist hier die Empfindlichkeit in Ω/V, kein Temperaturkoeffizient. *Gültigkeit:* die gezeigte Gleichstrommessung mit ohmschem Prüfling und Instrumentenwiderständen im gewählten Messbereich. Die Korrektur des Eigenverbrauchs beseitigt nicht automatisch alle Messunsicherheiten. Die Geräteklasse im Relaisbeispiel bezieht sich auf den Bereichsendwert.
#src[V S. 54–57, Abschnitte 2.4.7–2.4.7.3; Vorzeichen der Messabweichung und Grenzen erläutert.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.4.8 Pt100: Widerstandsänderung wird zur Anzeige <a-2-4-8>
Ein *Pt100* ist ein Platinwiderstand mit 100 Ω bei 0 °C. Im Skriptmodell steigt sein Widerstand linear mit der Temperatur. Das Anzeigeinstrument liegt parallel zum Sensor und wird deshalb von ihm mitbelastet.
#bild("gesamt-pt100", [Temperaturfühler und Anzeigeinstrument hinter dem Vorwiderstand. V S. 58.], height: 38mm)
#form[$ R_vartheta = R_0 (1+alpha (vartheta-vartheta_0)) quad I_m = (U_B R_vartheta)/(R_V R_M+R_V R_vartheta+R_M R_vartheta) $]
$R_M$: Instrumentenwiderstand, $R_V$: Vorwiderstand, $U_B$: Speisespannung, $I_m$: tatsächlicher Instrumentenstrom. *Voraussetzung:* das ausdrücklich vorgegebene lineare Pt100-Modell mit $R_0=100 thin Omega$ bei $vartheta_0=0 thin "°C"$, $alpha="3,85" dot.c 10^(-3) thin "1/K"$. Der Modellbereich der Aufgabe reicht bis 400 °C; dies ist keine Zusage einer exakt linearen realen Pt100-Kennlinie.
Die Temperatur verändert einen Widerstand, daraus folgt eine nichtlineare Stromaufteilung. Eine lineare Skala des Drehspulinstruments ist daher nicht automatisch eine lineare Temperaturskala. Die Dimensionierung und Nullpunktanzeige werden im Aufgabenband berechnet.
#src[V S. 58–59, Abschnitt 2.4.8; Stromformel aus dem Parallelersatz hergeleitet, Modellabgrenzung ergänzt.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.4.9 Die Wheatstone-Brücke <a-2-4-9>
Eine *Messbrücke* vergleicht zwei Spannungsteiler. Beim Abgleich haben ihre Mitten dasselbe Potenzial; durch das Messinstrument im Querzweig fließt dann kein Strom. Das Nullsignal ist die entscheidende Information.
#bild("gesamt-wheatstone", [Abgeglichene Wheatstone-Brücke mit Schleifdraht. V S. 60, Abb. 2.21.], height: 51mm)
#form[$ U_(B C)=0 quad => quad R_x/R_N=R_1/R_2 quad => quad R_x=R_N R_1/R_2=R_N l_1/l_2 $]
*Gültigkeit:* abgeglichene Brücke; die Längenform zusätzlich nur bei homogenem Schleifdraht mit gleichem Material und Querschnitt. $R_N$ ist der bekannte Normwiderstand. Seine Größenordnung legt den Messbereich fest, das Verhältnis den Feinabgleich.
#note("Abgleich und belastete Brücke", [Außerhalb des Abgleichs zieht ein reales Messgerät Querzweigstrom. Dann lassen sich die beiden Seiten nicht unabhängig als unbelastete Teiler behandeln. Beim Nulldurchgang verschwindet gerade dieser Einfluss im idealisierten Widerstandsmodell.], fill: sand)
#src[V S. 60–61, Abschnitt 2.4.9; Vergleich mit zwei Spannungsteilern erläutert.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.5.1 Stern und Dreieck: drei Klemmen gleichwertig ersetzen <a-2-5-1>
Eine Brückenschaltung lässt sich oft nicht direkt in Reihe und parallel zerlegen. Die *Stern-Dreieck-Transformation* ersetzt ein Teilnetz zwischen drei äußeren Klemmen so, dass es von außen dasselbe Verhalten zeigt. Innere Einzelströme dürfen sich dabei ändern.
#bild("gesamt-stern-dreieck", [Drei äußere Klemmen A, B und C; Stern im Dreieck. V S. 62, Abb. 2.22.], height: 45mm)
Um Verwechslungen zu vermeiden, bezeichnen wir die Sternarme nach ihren äußeren Klemmen: $r_A$, $r_B$, $r_C$. Die Dreieckseiten heißen $R_(A B)$, $R_(B C)$ und $R_(C A)$.
#form[$ S_D=R_(A B)+R_(B C)+R_(C A) quad r_A=(R_(A B) R_(C A))/S_D $]
Die beiden anderen Sternarme entstehen zyklisch: Am Knoten B steht das Produkt der dort anliegenden Dreieckseiten, am Knoten C ebenso. Umgekehrt:
#form[$ S_Y=r_A r_B+r_B r_C+r_C r_A quad R_(A B)=S_Y/r_C quad R_(B C)=S_Y/r_A quad R_(C A)=S_Y/r_B $]
*Gültigkeit:* das umgewandelte Teilnetz besteht aus linearen Widerständen ohne Quellen. Der übrige Stromkreis darf Quellen enthalten. In der Rückrichtung steht der gegenüberliegende Sternarm im Nenner. Nicht bloß die geometrische Lage der Beschriftung übernehmen.
#bild("gesamt-ntc-bruecke", [Belastete Messbrücke mit Heißleiter und realem Voltmeter. V S. 65, Abb. 2.24.], height: 42mm)
Das Voltmeter im Heißleiterbeispiel hat $R_"VM"=30 thin "k"Omega$ und verändert die Brücke. Es gehört in die Rechnung. Die Umwandlung kann einen Gesamtstrom vereinfachen; gesuchte Ströme im ursprünglichen Teilnetz werden anschließend aus den ursprünglichen Potenzialen rekonstruiert.
#src[V S. 62–65, Abschnitte 2.5.1–2.5.1.1; klemmennamenbezogene Notation als eigene Darstellung der gleichen Transformation.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.5.2 Eine Spannungsquelle gezielt verschieben <a-2-5-2>
Eine ideale Spannungsquelle darf nicht beliebig im Schaltbild versetzt werden. Im gezeigten Spezialfall wird ihr Spannungsbeitrag in alle betroffenen Zweige mit demselben Wert und passender Polung übernommen. Dadurch bleiben die Maschengleichungen des übrigen Netzes erhalten.
#bild("gesamt-quelle-verschieben-u", [Gleichwertige Aufteilung einer Spannungsquelle in die betroffenen Zweige. V S. 66, Abb. 2.26.], height: 49mm)
*Prüfidee:* Jede ursprüngliche Masche muss denselben resultierenden Quellenbeitrag enthalten. Die neue Masche zwischen den beiden kopierten Quellen enthält deren Differenz; gleiche Beiträge heben sich dort auf. Danach kann eine Quelle mit Serienwiderstand leichter in eine Ersatzstromquelle umgewandelt werden (Kapitel 4).
#note("Grenze der Gleichwertigkeit", [Die ursprünglichen Zweigwiderstände bleiben erhalten. Eine Kopie nur in einen von mehreren betroffenen Zweigen einzusetzen würde das Netzwerk verändern. Die Gleichwertigkeit wird an den betrachteten Klemmen geprüft.], fill: sand)
#src[V S. 66, Abschnitt 2.5.2; Erläuterung der unveränderten Maschenbeiträge ergänzt.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.5.3 Eine Stromquelle gezielt verschieben <a-2-5-3>
Die entsprechende Stromumformung erhält die Knotenbilanzen. Im gezeigten Ersatz entstehen zwei gleich große Quellen; an dem ergänzten Verbindungsknoten heben sich ihre Beiträge auf.
#bild("gesamt-quelle-verschieben-i", [Stromquellenumformung unter Erhaltung der Knotenbilanzen. V S. 67, Abb. 2.27.], height: 48mm)
#form[$ I_Q-I_Q+I_"quer"=0 quad => quad I_"quer"=0 $]
Damit bleibt auch die Bilanz am ursprünglichen Knoten gleich. *Voraussetzung:* genau die gezeigte Topologie und die richtigen Quellenrichtungen. Die Vorschrift ist eine begründete Netzwerkumformung, keine allgemeine Erlaubnis, Stromquellen zwischen beliebigen Knoten zu versetzen.
#bild("map-schaltungen", [Mindmap: Schaltung erkennen, ersetzen, messen und prüfen. Eigene Darstellung.], height: 43mm)
#src[V S. 67, Abschnitt 2.5.3; Zusammenhang mit dem Knotenpunktsatz erläutert.]
#hoch(<a-2>, [Kapitelübersicht])

*Der Zusammenhang in Kapitel 2.* Die Knotenbilanz erhält die Ladung, der Maschenumlauf verbindet die Potenziale. Kennlinien liefern das nichtlineare Bauteilverhalten. Im Grundstromkreis erklärt der Innenwiderstand Spannungseinbruch und endlichen Kurzschlussstrom. Der Arbeitspunkt erfüllt Quellen- und Verbraucherkennlinie zugleich. Die Leistungsbilanz unterscheidet nutzbare Leistung, innere Verluste und Wirkungsgrad; bei Leistungsanpassung wird innen genauso viel umgesetzt wie außen. Reihen- und Parallelregeln zerlegen einfache Netze; belastete Teiler und Messgeräte zeigen die Grenzen dieses Zerlegens. Messbrücken nutzen Potenzialgleichheit. Stern-Dreieck- und Quellenumformungen erhalten das äußere Klemmenverhalten.
#hoch(<a-2>, [Kapitelübersicht])


#pagebreak(weak: true)
= Kapitel 3 · Netzwerke mit Kirchhoff systematisch berechnen <a-3>
#überblick([Kapitel 3 auf einen Blick],
 idee(<a-3-1>, [Genug unabhängige Gleichungen aufstellen.], [Zweigströme, Knotenbilanzen und Maschen schließen ein gemeinsames Gleichungssystem.]),
 idee(<a-3-2-1>, [Lineare Quellenwirkungen überlagern.], [Teilspannungen und Teilströme mit ihren Vorzeichen addieren.]),
 idee(<a-3-2-2>, [Maschenströme sparen Unbekannte.], [Fiktive Kreisströme werden anschließend in reale Zweigströme übersetzt.]),
 idee(<a-3-2-3>, [Knotenpotenziale beschreiben das ganze Netz.], [Leitwerte verbinden unbekannte Potenziale mit den eingespeisten Strömen.]),
 idee(<a-3-2-4>, [Ideale Quellen geben eine Größe fest vor.], [Die andere Größe folgt aus dem restlichen Netzwerk.]),
)
#ablauf(
 chunk([Topologie und Bezug wählen], [Knoten · Zweige · Zählpfeile], ziel: <a-3-1>),
 entscheidung([Welche Unbekannten sind am günstigsten?],
  chunk([Wenige unabhängige Maschen], [Maschenströme und Spannungsbilanzen], ziel: <a-3-2-2>),
  chunk([Wenige unbekannte Potenziale], [Knotenbilanzen mit Leitwerten], ziel: <a-3-2-3>)),
 chunk([Zur physikalischen Lösung zurück], [Zweiggrößen · Vorzeichen · Bilanzprüfung], ziel: <a-3-2-4>),
)
#src[Eigene Zusammenführung von V S. 69–86.]
#hoch(<ueberblick>, [Modul auf einen Blick])

Die Gesetze bleiben gleich; nur die Wahl der Unbekannten ändert sich. Eine passende Methode kann aus fünf Zweigströmen drei Maschenströme oder zwei Knotenpotenziale machen. Nach dem Lösen prüfst du stets dieselbe physikalische Schaltung. Ein negatives Ergebnis beschreibt dabei die Gegenrichtung zum gewählten Pfeil.

== 3.1 Direkte Netzwerkanalyse und lineares Gleichungssystem <a-3-1>
Ein *Zweig* verbindet zwei Knoten und führt einen Zweigstrom. Für jeden unbekannten Zweigstrom wählst du zuerst eine Richtung. Danach formulierst du Knotenbilanzen und Maschenbilanzen mit denselben Pfeilen.
#bild("gesamt-kirchhoff-allgemein", [Netzwerk mit fünf Zweigströmen und drei Knoten. V S. 70, Abb. 3.1.], height: 50mm)
Für ein zusammenhängendes Netz mit $z$ Zweigen und $k$ Knoten gibt es $k-1$ unabhängige Knotengleichungen. Ergänzt werden $z-k+1$ unabhängige Maschengleichungen. Im Beispiel sind das zwei Knoten- und drei Maschengleichungen für fünf Ströme.

*Unabhängig* heißt: Keine Gleichung folgt bereits aus den anderen. Die letzte Knotenbilanz ist redundant, weil jede Verbindung bei einer Gesamtsumme einmal hinein- und einmal herausgezählt wird. Ein bereits verwendeter Maschenumlauf liefert durch bloßes Umkehren keine neue Gleichung.
#form[$ A bold(I)=bold(b) quad I_j=D_j/D quad D=det(A) != 0 $]
$A$: Koeffizientenmatrix, $bold(I)$: Vektor der unbekannten Ströme, $bold(b)$: bekannte Quellenbeiträge. *Cramers Regel:* In $D_j$ wird die *Spalte* des gesuchten Stroms durch die rechte Seite ersetzt. Die Zeilen und Spalten müssen während der ganzen Rechnung in derselben Reihenfolge bleiben.
#tab(columns: (1fr,2.5fr), th([Werkzeug],[Bedeutung]),
 [2×2-Determinante], [$det(mat(a,b;c,d))=a d-b c$],
 [3×3-Determinante], [Sarrus: drei positive und drei negative Diagonalprodukte; nur für 3×3.],
 [Größere Systeme], [Gauß-Elimination oder ein geeignetes lineares Lösungsverfahren; Sarrus nicht fortsetzen.],
)
*Gültigkeit:* lineares Gleichstromnetzwerk mit konsistenten, unabhängigen Gleichungen. $D=0$ verlangt eine Prüfung auf fehlende Eindeutigkeit oder widersprüchliche Vorgaben. Eine beliebige Lösung darf dann nicht durch Division durch null erzwungen werden.
#note("Nach dem Rechnen", [Setze die Ströme in die ursprünglichen Knoten- und Maschenbilanzen ein. Einheiten helfen: Eine Spannungszeile enthält Ω mal A gleich V; eine Knotenzeile nur Ströme. Die zugehörigen Aufgaben zeigen das Aufstellen, Lösen und Prüfen an konkreten Netzen.], fill: sand)
#src[V S. 69–73, Abb. 3.1–3.2 und Fußnote zu Determinanten; Gauß-Verfahren als ergänzende Rechenhilfe.]
#hoch(<a-3>, [Kapitelübersicht])

== 3.2.1 Überlagerung: eine Quelle nach der anderen <a-3-2-1>
In einem *linearen Netzwerk* kannst du die Wirkung mehrerer unabhängiger Quellen getrennt berechnen. Es ist wie das Addieren mehrerer linearer Ursachen: Jeder Teilbeitrag verwendet dasselbe Widerstandsnetz, am Ende werden die vorzeichenbehafteten Ströme oder Spannungen addiert.
#form[$ I_k=sum_j I_(k j) quad U_k=sum_j U_(k j) $]
Beim einzelnen Teilfall bleibt eine Quelle aktiv. Alle anderen *unabhängigen* Quellen werden auf null gesetzt:
#tab(columns: (1fr,1fr,1.5fr), th([Quelle],[Null setzen],[Bleibt erhalten]),
 [Ideale Spannungsquelle], [Kurzschluss: $U_q=0$], [vorhandener Innenwiderstand],
 [Ideale Stromquelle], [Leerlauf: $I_q=0$], [vorhandener Parallelwiderstand],
)
#bild("gesamt-drei-zweige", [Zwei Quellen wirken auf denselben mittleren Verbraucher. V S. 72, Abb. 3.2.], height: 45mm)
Im Beispiel trägt jede Quelle zu allen drei Zweigströmen bei. Die auf V S. 75 verwendete Richtung von $I_2$ ist gegenüber der Anfangsannahme auf S. 72 umgekehrt: $-"0,732" thin "A"$ in der ursprünglichen Richtung und $+"0,732" thin "A"$ in der umgekehrten Richtung beschreiben dieselbe Lösung.
#note("Leistungen werden nicht überlagert", [Erst den Gesamtstrom bzw. die Gesamtspannung bilden, dann $P=U I$ oder $P=R I^2$ berechnen. Aus $R(I_a+I_b)^2$ entsteht zusätzlich der Mischterm $2 R I_a I_b$. Die Summe der einzelnen Teilleistungen wäre deshalb im Allgemeinen falsch.], fill: sand)
*Gültigkeit:* lineares Bauteilverhalten. Eine nichtlineare Diode kann nicht durch dieselbe einfache Addition vollständiger Großsignal-Arbeitspunkte behandelt werden.
#src[V S. 73–75, Abschnitt 3.2.1; Leistungsausschluss aus der vorhandenen Leistungsformel hergeleitet, Vorzeichenwechsel ausdrücklich erläutert.]
#hoch(<a-3>, [Kapitelübersicht])

== 3.2.2 Maschenströme: Kreisströme als Rechenhilfe <a-3-2-2>
Ein *Maschenstrom* ist eine gedachte Rechengröße, die um eine gewählte Masche läuft. Durch einen Randwiderstand fließt oft nur ein Maschenstrom. Einen gemeinsamen Widerstand durchsetzen dagegen zwei Maschenströme; der reale Zweigstrom ist ihre vorzeichenrichtige Summe oder Differenz.
#bild("gesamt-fuenf-widerstaende", [Drei Maschenströme für ein Netzwerk mit fünf Widerständen. V S. 77, Abb. 3.6.], height: 47mm)
Bei gleichsinnig orientierten Nachbarmaschen ist ein gemeinsamer Zweig entgegengesetzt durchlaufen. Dann trägt er etwa $R(I_"I"-I_"II")$ zur ersten Masche bei. Daraus folgt für die übliche Matrix: Summe der eigenen Widerstände auf der Diagonale, gemeinsamer Widerstand mit negativem Vorzeichen daneben. Andere Umlaufrichtungen können andere Vorzeichen ergeben.
#form[$ sum "Spannungsbeiträge einer Masche" = 0 quad I_"Zweig"=s_1 I_"I"+s_2 I_"II" $]
$s_1$, $s_2$ sind die Richtungszeichen. *Voraussetzung:* geeignete unabhängige Maschen und lineare Widerstände. Die Knotenbilanz steckt bereits in der Zerlegung in Kreisströme; sie ist anschließend eine gute Kontrolle.
#bild("gesamt-pufferbatterie", [Generator, Pufferbatterie und Verbraucher. V S. 79, Abb. 3.8.], height: 44mm)
Bei der Pufferbatterie entscheidet das Vorzeichen ihres Zweigstroms, ob sie den Verbraucher zusätzlich speist oder geladen wird. Gleiche Polung zweier Quellen garantiert keinen Stromfluss in derselben Richtung.

=== 3.2.2.1 Ideale Stromquellen in Maschen <a-3-2-2-1>
Eine ideale Stromquelle am Rand legt einen Maschenstrom direkt fest. Liegt sie im gemeinsamen Zweig zweier Maschen, legt sie die *Differenz* der Maschenströme fest. Ihre Spannung ist eine zusätzliche unbekannte Größe; sie darf nicht als null eingesetzt werden.
#bild("gesamt-ideale-quellen-netz", [Umgeordnetes Netzwerk mit zwei idealen Stromquellen. V S. 81, Abb. 3.10.], height: 48mm)
#note("Skriptpräzisierung auf S. 80", [„Stromquellenströme sind Maschenströme“ gilt unmittelbar nur für die passende Randmasche. Die formal notierten Umläufe 2 und 4 lassen die unbekannten Spannungen der idealen Stromquellen aus; als vollständige Spannungsbilanzen wären sie so nicht gültig. Für die Rechnung werden die fest vorgegebenen Ströme der Randmaschen und die gültigen Widerstandsmaschen I und III verwendet. Anschließend ergeben sich die Quellenspannungen aus den Knotenpotenzialen.], fill: sand)
Eine Umformung zu einer Ersatzspannungsquelle verlangt einen passenden endlichen Parallelwiderstand. Eine alleinstehende ideale Stromquelle besitzt diesen nicht. Quellenumformungen erhalten außerdem die äußeren Klemmenwerte, nicht automatisch sämtliche inneren Zweigströme.
#src[V S. 76–84, Abschnitt 3.2.2; Spezialfälle idealer Stromquellen und fehlende Quellenspannungsbeiträge aus den Kirchhoffschen Bilanzen präzisiert.]
#hoch(<a-3>, [Kapitelübersicht])

== 3.2.3 Knotenpotenziale: erst die Spannungen bestimmen <a-3-2-3>
Du wählst einen Knoten als Masse. Die übrigen *Knotenpotenziale* sind die Unbekannten. Ein Widerstand zwischen zwei Knoten übersetzt ihre Potenzialdifferenz in einen Strom; die Knotenbilanz verbindet alle Zweige.
#form[$ I_(A B)=G_(A B)(phi_A-phi_B) quad G_(A B)=1/R_(A B) $]
#bild("gesamt-knoten-netz", [Zwei unbekannte Potenziale und umgeformte Quellen. V S. 84, Abb. 3.14.], height: 40mm)
Für das dortige Netzwerk:
#form[$
 mat(G_1+G_2+G_3,-G_3;-G_3,G_3+G_4+G_5)
 vec(U_20,U_40)
 =
 vec(U_(q 1) G_1,U_(q 2) G_5)
 $]
Die Diagonale enthält die Summe aller am Knoten angeschlossenen Leitwerte. Der negative Nebeneintrag verbindet die beiden Knoten über $G_3$. Die rechte Seite enthält die vorzeichenrichtig eingespeisten Quellenströme. Danach folgen Zweigspannungen aus Potenzialdifferenzen und Ströme aus dem Ohmschen Gesetz.
#note("Vorzeichen und Druckfehler", [Die Richtung von $U_3$ in V S. 84 ist so gewählt, dass $U_3=U_40-U_20$. In der skalaren Zwischenzeile auf S. 85 muss rechts $U_(q 2)G_5$ stehen; das dortige $G_3$ ist ein Druckfehler. Die darunter gezeigte Matrix verwendet bereits korrekt $G_5$.], fill: sand)
*Gültigkeit:* die angegebene Leitwertmatrix für das gezeigte lineare Netzwerk. V nutzt nach Quellenumformung nur Stromquellen. Die Knotenpotenzialmethode ist allgemeiner: Eine ideale Spannungsquelle gegen Masse kann ein bekanntes Potenzial vorgeben; bei einer Quelle zwischen unbekannten Knoten braucht man eine zusätzliche Spannungsbedingung. Für die hier gerechnete Standardform genügt die Quellenumwandlung.
#src[V S. 84–85, Abschnitt 3.2.3; Druckfehler durch Vergleich von Knotenbilanz und Matrix belegt, Einordnung idealer Quellen ergänzt.]
#hoch(<a-3>, [Kapitelübersicht])

== 3.2.4 Ideale Quellen und die Wahl der Methode <a-3-2-4>
Eine ideale Spannungsquelle hält ihre Spannung fest, ihr Strom folgt aus dem Netzwerk. Eine ideale Stromquelle hält ihren Strom fest, ihre Spannung folgt aus dem Netzwerk. Beide können im idealen Modell beliebig große Werte der jeweils anderen Größe annehmen.
#bild("gesamt-quellen-ideal-gemischt", [Eine Spannungsquelle und eine Stromquelle mit Widerständen. V S. 86, Abb. 3.15.], height: 44mm)
Ein sehr hohes berechnetes Potenzial an einer idealen Stromquelle widerspricht daher nicht ihrer Modellvorgabe. Eine reale Quelle besitzt dagegen einen begrenzten Arbeitsbereich. Bei der Auswertung muss außerdem *Leitwert* von Widerstand unterschieden werden: $1 thin "mS"$ entspricht $1 thin "k"Omega$.
#tab(columns: (1fr,2.3fr), th([Methode],[Besonders hilfreich, wenn …]),
 [Direkt mit Kirchhoff], [nur wenige Zweige vorkommen oder ideale Quellen viele Größen festlegen.],
 [Überlagerung], [der Beitrag einer einzelnen Quelle interessiert und das Netz linear ist.],
 [Maschenströme], [wenige unabhängige Maschen und viele Serienzweige vorliegen.],
 [Knotenpotenziale], [wenige unbekannte Knoten und viele Parallelzweige vorliegen.],
)
#bild("map-methoden", [Mindmap: Vier Wege, dieselbe Schaltung zu beschreiben. Eigene Darstellung.], height: 44mm)
*Der Zusammenhang in Kapitel 3.* Knoten und Maschen liefern die Erhaltungsgleichungen. Die direkte Rechnung verwendet Zweigströme; Überlagerung zerlegt Quellenwirkungen. Maschenströme und Knotenpotenziale reduzieren die Zahl der Unbekannten. Erst die Rückübersetzung in reale Ströme, Spannungen und Leistungen schließt die Lösung ab.
#src[V S. 69–86, besonders Abschnitt 3.2.4; Methodenvergleich als eigene Zusammenführung.]
#hoch(<a-3>, [Kapitelübersicht])

#pagebreak(weak: true)
= Kapitel 4 · Zweipoltheorie und nichtlineare Arbeitspunkte <a-4>
#überblick([Kapitel 4 auf einen Blick],
 idee(<a-4-1>, [Ein lineares Netz kann von außen sehr einfach sein.], [Eine Ersatzquelle beschreibt das Verhalten zwischen zwei gewählten Klemmen.]),
 idee(<a-4-2>, [Leerlauf, Kurzschluss und Innenwiderstand verbinden sich.], [Zwei korrekt bestimmte Größen legen die dritte fest.]),
 idee(<a-4-3>, [Der Arbeitspunkt erfüllt Quelle und Last zugleich.], [Die Quelle liefert eine Gerade, die Last ihre eigene Kennlinie.]),
 idee(<a-4-3-1>, [Nichtlineare Lasten bleiben mit ihrer Kennlinie erhalten.], [In Reihe werden Spannungen, parallel Ströme addiert.]),
 idee(<a-4-4>, [Leistungsgrenzen gehören zur Lösung.], [Eine elektrisch mögliche Lösung kann thermisch unzulässig sein.]),
)
#ablauf(
 chunk([Zwei Klemmen wählen], [gesuchte Last abtrennen · restliches Netz festlegen], ziel: <a-4-2>),
 chunk([Ersatzquelle bestimmen], [Leerlaufspannung · Innenwiderstand · Kurzschlussprobe], ziel: <a-4-2-1>),
 entscheidung([Ist die Last linear?],
  chunk([Berechnen], [Ohmsches Gesetz im Ersatzkreis], ziel: <a-4-3>),
  chunk([Kennlinien schneiden], [graphisch oder mit Bauteilgleichung], ziel: <a-4-3-1>)),
 chunk([Betriebsgrenzen kontrollieren], [Leistung · Kennlinienbereich · innere Originalgrößen], ziel: <a-4-4>),
)
#src[Eigene Zusammenführung von V S. 87–108.]
#hoch(<ueberblick>, [Modul auf einen Blick])

Wenn nur der Strom einer bestimmten Last interessiert, musst du das übrige Netzwerk nicht für jeden Lastwert neu lösen. Die Zweipoltheorie fasst es an zwei Klemmen zusammen. Gerade für eine Diode, einen Varistor oder einen Transistor ist das hilfreich: Der lineare Quellenteil wird einfach, die nichtlineare Last bleibt sichtbar.

== 4.1 Ersatzspannungsquelle und Ersatzstromquelle <a-4-1>
Ein *Zweipol* besitzt zwei Anschlussklemmen. Ein lineares aktives Widerstandsnetzwerk mit unabhängigen Quellen lässt sich an diesen Klemmen durch eine *Ersatzspannungsquelle* $U_l$ mit Serienwiderstand $R_i$ darstellen. Alternativ steht eine *Ersatzstromquelle* $I_k$ mit Parallelwiderstand $R_i$ dafür.
#form[$ U=U_l-I R_i quad I=I_k-U/R_i quad U_l=I_k R_i $]
Die Stromquelle liefert intern ihren eingeprägten Strom; dieser teilt sich zwischen Innen- und Lastwiderstand auf. Daher ist der *Laststrom* einer realen Ersatzstromquelle nicht generell gleich ihrem Quellenstrom.
#tab(columns: (1fr,1.7fr,1.7fr), th([Blick von den Klemmen],[Spannungsersatz],[Stromersatz]),
 [Quelle], [$U_l$ mit $R_i$ in Reihe], [$I_k$ mit $R_i$ parallel],
 [Leerlauf], [$U=U_l$, $I=0$], [Strom durch $R_i$ erzeugt $U_l=I_k R_i$],
 [Kurzschluss], [$I=U_l/R_i$], [$I=I_k$, $U=0$],
 [Ohmsche Last], [$I_a=U_l/(R_i+R_a)$], [$I_a=I_k R_i/(R_i+R_a)$],
)
*Gültigkeit:* endlicher positiver Ersatzwiderstand für die hier betrachteten linearen Widerstandsnetze mit unabhängigen Quellen. Ideale Spannungs- und Stromquellen sind Grenzfälle; eine alleinstehende ideale Stromquelle lässt sich nicht in eine endliche ideale Spannungsquelle umrechnen.
#note("Von außen gleichwertig", [Die Ersatzbilder liefern an denselben Klemmen dieselben Spannungen und Lastströme. Sie versprechen keine Gleichheit aller inneren Ströme oder Verlustleistungen. Eine gesuchte ursprüngliche Quellenleistung musst du im Originalnetz bestimmen.], fill: sand)
#src[V S. 87–89 und S. 83–84 zur Grenze innerer Gleichwertigkeit; Ersatzformen algebraisch zusammengefasst.]
#hoch(<a-4>, [Kapitelübersicht])

== 4.2 Ersatzgrößen Schritt für Schritt bestimmen <a-4-2>
Lege die Klemmen an die Last, deren Verhalten du untersuchen willst. *Last abtrennen* heißt nur diesen Zweig entfernen. Alle anderen Widerstände und Quellen bleiben Bestandteil des aktiven Netzes.
#bild("gesamt-zweipol-zwei-quellen", [Aktiver Zweipol links der Klemmen A–B; Ra ist die abtrennbare Last. V S. 90, Abb. 4.6.], height: 47mm)

=== 4.2.1 Innenwiderstand: unabhängige Quellen auf null setzen <a-4-2-1>
Schau von den offenen Klemmen in das Netz: Ideale Spannungsquellen werden kurzgeschlossen, ideale Stromquellen geöffnet. Widerstände bleiben erhalten. Im gezeigten Beispiel ist der Zugangswiderstand in Reihe mit dem Parallelersatz der beiden Quellenzweige.
#form[$ R_i=R_3+(R_1 parallel R_2) $]
*Voraussetzung des Nullsetz-Tricks:* die hier vorhandenen unabhängigen Quellen und linearen Widerstände. Das Nullsetzen ist ein mathematischer Rechenschritt am Ersatzmodell.

=== 4.2.2 Leerlaufspannung: Laststrom null, innere Ströme möglich <a-4-2-2>
Für $U_l=U_(A B)$ wird nur der Lastzweig geöffnet. Durch den Zugangswiderstand fließt dann kein Laststrom, also fällt dort keine Spannung ab. Zwischen den inneren Quellen kann trotzdem ein Kreisstrom fließen. Die Quellen bleiben zur Leerlaufrechnung aktiv.
#note("Nicht verwechseln", [Für $R_i$ werden Quellen null gesetzt. Für $U_l$ bleiben sie aktiv. Wer beides vermischt, berechnet eine andere Schaltung.], fill: sand)

=== 4.2.3 Kurzschlussstrom und Gegenprobe <a-4-2-3>
Verbinde A und B gedanklich mit einem idealen Draht. Der Zweigstrom ist $I_k$ in der festgelegten Richtung. Nach zwei unabhängig berechneten Ersatzgrößen dient die dritte als Probe:
#form[$ I_k=U_l/R_i quad U_l=I_k R_i $]
Im Beispiel ist ungerundet $R_i=88/7 thin Omega$ und $U_l=50/7 thin "V"$, also $I_k=25/44 thin "A" approx "0,568" thin "A"$. V S. 90–92 nennt gerundet 12,6 Ω, 7,14 V und 0,566 A. Die leicht abweichenden letzten Stellen entstehen durch gerundete Zwischenwerte.
#src[V S. 90–92, Abschnitte 4.2–4.2.3; exakte Bruchwerte als geprüfte Nachrechnung.]
#hoch(<a-4>, [Kapitelübersicht])

== 4.3 Die grafische Lösung <a-4-3>
Die fallende Quellenkennlinie beschreibt alle vom aktiven Zweipol angebotenen Kombinationen aus Spannung und Strom. Die Lastkennlinie beschreibt alle Kombinationen, die zur Last passen. Ihr Schnittpunkt ist der *Arbeitspunkt*.
#form[$ I_"Quelle"(U)=(U_l-U)/R_i quad I_"Last"=f(U) quad I_"Quelle"(U_"AP")=I_"Last"(U_"AP") $]
Waagerecht steht die Klemmenspannung, senkrecht der Laststrom. Die Quellenlinie verläuft von $(0,I_k)$ nach $(U_l,0)$. Ihre Steigung ist $-1/R_i$. Bei unverändertem $R_i$ verschiebt eine andere Quellspannung diese Gerade parallel. Bei unverändertem $U_l$ dreht eine Änderung von $R_i$ die Linie um den Spannungsschnittpunkt.
#note("Last wählen und anschließend prüfen", [Eine neue Last erhält einen neuen Arbeitspunkt auf derselben Quellenlinie, solange das aktive Netzwerk unverändert bleibt. Ein abgelesener Wert ist immer so genau wie Raster, Linienbreite und Kennlinie. Mit Zahlen aus einer Grafik keine scheinbar exakten Nachkommastellen erzeugen.], fill: sand)
#src[V S. 93–94, Abschnitt 4.3 und Abb. 4.9–4.10; Ableseregeln erläutert.]
#hoch(<a-4>, [Kapitelübersicht])

== 4.3.1 Nichtlineare Lasten und zusammengesetzte Kennlinien <a-4-3-1>
Eine nichtlineare Last braucht keinen konstanten Ersatzwiderstand. Ihre Kennlinie darf gekrümmt sein; der lineare Quellenteil bleibt trotzdem durch $U_l$ und $R_i$ beschrieben. Mehrere Lastbauteile können zunächst zu einer *resultierenden Kennlinie* verbunden werden.
#bild("gesamt-kennlinien-addieren", [Oben parallel: Ströme addieren. Unten in Reihe: Spannungen addieren. V S. 96, Abb. 4.12–4.13.], height: 76mm)
#form[$ "parallel:" quad I(U)=I_1(U)+I_2(U) quad "in Reihe:" quad U(I)=U_1(I)+U_2(I) $]
*Voraussetzung:* gleicher Spannungswert in den parallelen Zweigen bzw. derselbe Strom in der Reihe; zu jedem Wert passende Betriebspunkte der jeweiligen Kennlinie. Die Addition erfolgt bei gleicher gemeinsamer Größe, nicht an beliebigen Punkten beider Kurven.
Beim Überspannungsschutz nimmt der Varistor bei ansteigender Spannung viel mehr Strom auf. Dadurch steigt der Spannungsabfall im vorgeschalteten Netz; die Lastspannung wächst weniger stark als ohne Schutz. Seine Verlustleistung muss trotzdem geprüft werden.
#src[V S. 95–98, besonders Abschnitte 4.3.1 und 4.3.1.1; Verknüpfung mit den Schaltungsregeln erläutert.]
#hoch(<a-4>, [Kapitelübersicht])

== 4.3.2 Transistor: Eingangsdiode und Ausgangskennlinien trennen <a-4-3-2>
Am Eingang kann die Basis-Emitter-Strecke als Diodenkennlinie behandelt werden. Der speisende Spannungsteiler wird zur Ersatzquelle. Der Schnittpunkt bestimmt $I_B$ und $U_(B E)$; der Basisstrom ist eine Belastung des Teilers.
#bild("gesamt-basis-arbeitspunkt", [Basis-Emitter-Kennlinie und zwei Quellenlinien. V S. 100, Abb. 4.17.], height: 47mm)
Im Ausgangskreis wird dagegen eine Kennlinie für den gewählten Basisstrom verwendet. Der ungefähr konstante Kollektorstrom gilt nur in einem geeigneten Bereich der Kollektor-Emitter-Spannung. Zu geringe Spannung führt aus dem aktiven Bereich heraus, zu hohe Spannung kann die Verlustleistungsgrenze überschreiten.
#form[$ P_T=U_(C E) I_C quad I_(C,"zul")=P_"max"/U_(C E) $]
Die Grenze gleicher Leistung ist im Kennlinienfeld eine Hyperbel. Für den Konstantstromfall mit Serienwiderstand gilt näherungsweise:
#form[$ U_(C E)=U_q-I_C(R_a+R_"iq") $]
*Gültigkeit:* der Basisstrom bleibt passend vorgegeben; hier vernachlässigt das Skript im Lastkreis den kleinen Unterschied zwischen Emitter- und Kollektorstrom.
#note("Grenznäherung des Skripts", [V S. 101–102 liest für 100 mA ungefähr 90–190 Ω ab. Die obere Grenze setzt näherungsweise $U_(C E)=0$ an. Ein realer Transistor braucht eine positive Mindestspannung für zuverlässigen Konstantstrombetrieb; mit vorgegebenem $U_(C E,"min")$ wäre $R_"a,max"=(U_q-U_(C E,"min"))/I_C-R_"iq"$. Die Skriptgrenze ist daher ein idealisierter Diagramm-Grenzfall.], fill: sand)
#src[V S. 99–102, Abschnitte 4.3.2.1–4.3.2.2; Mindestspannungsbedingung aus der Maschenbilanz ergänzt.]
#hoch(<a-4>, [Kapitelübersicht])

== 4.4 Anwendungen: Polung, Kennlinie und Leistungsgrenze verbinden <a-4-4>
Die abschließenden Skriptaufgaben verbinden bekannte Bausteine. Der folgende Überblick erklärt die Modelle; die vollständig vorgegebenen Aufgaben mit allen Lösungsschritten stehen auf der Lernplattform.

=== 4.4.1 Eine Stromquelle kann an den Klemmen negative Spannung erzeugen <a-4-4-1>
Die Richtung der Quelle und der Bezug $U_(A B)=phi_A-phi_B$ entscheiden gemeinsam über das Vorzeichen. Eine negative Leerlaufspannung ist kein Rechenfehler. Die Leistung einer Quelle muss mit ihrer tatsächlichen Spannung und Stromrichtung ausgewertet werden; bei Strom vom niedrigeren zum höheren Potenzial gibt sie Leistung ab.
#src[V S. 103, Abschnitt 4.4.1; Potenzial- und Leistungsdeutung erläutert.]

=== 4.4.2 Glimmlampe: negativer differenzieller Widerstand <a-4-4-2>
In einer Gasentladung können freie Ladungsträger durch Stöße weitere Träger erzeugen. Die angelegte Spannung treibt die Entladung, Licht entsteht beim Übergang angeregter Zustände. Die Glimmlampe enthält ein Gas bei niedrigem Druck; „luftleer“ in V ist keine vollständige Abwesenheit von Gas.
#bild("gesamt-glimmlampe-kennlinie", [Kennlinie einer Glimmlampe mit markiertem Glimmbereich. V S. 105, Abb. 4.21.], height: 72mm)
Auf dem fallenden Kurvenabschnitt sinkt die Spannung bei steigendem Strom: $dif U/dif I<0$. Das ist ein *negativer differenzieller Widerstand*. Der statische Quotient $U/I$ kann dabei weiterhin positiv sein. Der Vorwiderstand begrenzt den Strom; beim Absenken der Quelle kann die Entladung unterhalb ihres Haltebereichs erlöschen. Zündgrenze und Haltegrenze sind verschiedene Betriebsbedingungen.
#src[V S. 103–105, Abschnitt 4.4.2 und Kennlinie; Formulierung „luftleer“ und Widerstandsbegriffe physikalisch präzisiert.]

=== 4.4.3 Quellen zusammenfassen, innere Leistungen im Original prüfen <a-4-4-3>
Eine reale Spannungsquelle mit Serienwiderstand und eine reale Stromquelle mit Parallelwiderstand lassen sich umformen. Gleichgerichtete parallele Quellenströme werden addiert; gegengerichtete subtrahiert. Die widerstandsbehafteten Zweige bleiben als Parallelleitwerte im Netz.
#form[$ I_"q,ers"=sum_k s_k I_(q k) quad G_"i,ers"=sum_k G_(i k) quad U_l=I_"q,ers"/G_"i,ers" $]
*Gültigkeit:* gemeinsame Klemmen, unabhängige Quellen mit passenden linearen Innenwiderständen. Maximalleistung an einer variablen ohmschen Last ist weiterhin bei $R_a=R_i$ erreicht. Eine nichtlineare Last wird stattdessen über ihren Kennlinienschnitt bestimmt.
#src[V S. 106 und 87–94; Quellenzusammenfassung als eigene Zusammenführung.]

=== 4.4.4 LED: Leerlaufspannung ist noch kein Arbeitspunkt <a-4-4-4>
Die Leerlaufspannung eines Netzwerks wird ohne LED bestimmt. Beim Anschließen zieht die LED Strom; die Klemmenspannung fällt entsprechend dem Innenwiderstand. Das Quellennetz wird daher zuerst ersetzt, anschließend wird die LED-Kennlinie geschnitten.
#bild("gesamt-led-rot-kennlinie", [Steile Durchlasskennlinie der roten LED. V S. 107, Abb. 4.22, Kennlinienteil.], height: 55mm)
Die in V genannte Schwelle von ungefähr 1,9 V ist eine Größenordnung im vereinfachten Energiebild. In der gezeigten Durchlasskennlinie ist die LED-Spannung positiv. Der tatsächliche Durchlasswert gehört zum gewählten Strom und zur Temperatur.
#src[V S. 107, Abschnitt 4.4.4 einschließlich Fußnote; Schwellenwert als Näherung eingeordnet.]

=== 4.4.5 Transistor mit Kollektorwiderstand <a-4-4-5>
Bei festem Basisstrom wählst du die passende Ausgangskennlinie. Die Quellenlinie besitzt den Spannungsschnittpunkt $U_q$ und die Steigung $-1/R_C$. Am zulässigen Grenzarbeitspunkt erfüllt die Kennlinie zusätzlich die Verlustleistungshyperbel.
#bild("gesamt-transistor-rc-feld", [Ausgangskennlinien für verschiedene Basisströme. V S. 108.], height: 65mm)
#form[$ U_q=U_(C E)+I_C R_C quad P_T=U_(C E) I_C quad P_(R C)=I_C^2 R_C $]
*Voraussetzung:* das vorgegebene Basisstromniveau und der betrachtete Gleichstrom-Arbeitspunkt; die Verlustleistung der Basis wird im Skriptmodell vernachlässigt. Die Transistorleistung und die Widerstandsleistung sind getrennt zu berechnen. Ein höherer zulässiger Quellenwert ergibt sich nicht durch Prüfen des Widerstands allein.
#bild("map-zweipol", [Mindmap: Vom Netzwerk zum zulässigen Arbeitspunkt. Eigene Darstellung.], height: 44mm)
*Der Zusammenhang in Kapitel 4.* Zwei Klemmen legen fest, welcher Teil ersetzt wird. Leerlaufspannung, Kurzschlussstrom und Innenwiderstand beschreiben den linearen aktiven Teil. Die Lastkennlinie findet den Arbeitspunkt; ihre Form entscheidet über Strom, Spannung und mögliche Mehrdeutigkeiten. Die abschließende Leistungsprüfung grenzt das mathematisch Mögliche auf den zulässigen Betrieb ein.
#src[V S. 108, Abschnitt 4.4.5; Verbindung der Maschen- und Leistungsbilanz erläutert.]
#hoch(<a-4>, [Kapitelübersicht])

#pagebreak(weak: true)
= Anhang

== Formelsammlung mit Voraussetzungen
Zählpfeile im Verbraucherzählpfeilsystem; Strom in technischer Richtung (+ → −). Bei Drahtwiderständen $l$ in m und $A$ in mm².

=== Kapitel 0 · Vorwissen: Strom, Spannung, Widerstand, Leistung
#tab(columns: (1.15fr, 1.8fr, 1.7fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Ladung und Strom], [$Q = I dot.c t$; $I = Q\/t$; $i(t) = dif Q\/dif t$], [$1 thin "C" = 1 thin "As"$; konstanter Strom für $Q = I t$.],
 [Ohmsches Gesetz], [$U = R dot.c I$; $G = 1\/R$], [Linearer Widerstand; Ω, S.],
 [Drahtwiderstand], [$R = rho l\/A = l\/(kappa A)$; $A = pi d^2\/4$], [Gleichförmiger Leiter; Hin- und Rückleiter zählen.],
 [Leistung], [$P = U I = I^2 R = U^2\/R$], [W; letzte zwei Formen nur am ohmschen Widerstand.],
 [Energie], [$W = P dot.c t$], [Konstante Leistung; $1 thin "kWh" = "3,6" thin "MJ"$.],
 [Reihenschaltung], [$R_"ges" = sum R_k$; $I$ überall gleich], [Spannungen addieren sich.],
 [Parallelschaltung], [$1\/R_"ges" = sum 1\/R_k$; zwei: $R_1 R_2\/(R_1 + R_2)$], [$U$ an allen Zweigen gleich.],
 [Spannungsteiler], [$U_2 = U dot.c R_2\/(R_1 + R_2)$], [Unbelastet (kein Strom abgegriffen).],
 [Belasteter Spannungsteiler], [$R_p = R_2 R_L/(R_2 + R_L)$; $U_a = U R_p/(R_1 + R_p)$], [Ohmsche Last $R_L$ parallel zu $R_2$; ideale Quelle.],
)

=== Kapitel 1 · Grundbegriffe: Strom, Spannung, Widerstand, Leistung
#tab(columns: (1.15fr, 1.8fr, 1.7fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Ladung im Leiter], [$Q = n e A l$], [$n_"Cu" approx "8,44" dot.c 10^22 thin "cm"^(-3)$.],
 [Driftgeschwindigkeit], [$I = n e v_d A$; $v_d = I\/(n e A)$], [Einheiten passend (cm oder m); Größenordnung mm/s.],
 [Stromdichte], [$S = I\/A$], [A/mm²; zulässig etwa 1 … 6 A/mm² (V S. 10).],
 [Kontinuität], [$I_"Ein" = I_"Aus"$; $S_1 A_1 = S_2 A_2$], [Unverzweigter Leiter.],
 [Lorentzkraft], [$arrow(F)_L = Q (arrow(v) times arrow(B)) = I (arrow(l) times arrow(B))$; $F = I l B$], [Betragsform bei $arrow(l) perp arrow(B)$; parallel: $F = 0$.],
 [Drehspulinstrument], [$M_"el" = N A B I$; $phi = N A B\/D^* dot.c I$], [$A = 2 r l$; $phi ∼ I$.],
 [Wechselstrom], [$T = 1\/f$; $I_"eff" = hat(i)\/sqrt(2)$], [Effektivwert nur für Sinusform; 50 Hz → 20 ms.],
 [Induktion], [$u_i = -N dif Phi\/dif t = -N A dif B\/dif t$], [Fluss in Wb; zweite Form nur bei fester Fläche und Orientierung sowie homogenem senkrechtem Feld.],
 [Transformator], [$U_1\/U_2 = N_1\/N_2 = I_2\/I_1$], [Wechselstrom; ideal, ohne Verluste.],
 [Thermoeffekt], [$U_q approx K Delta vartheta$; $Delta vartheta = vartheta_1 - vartheta_2$], [Cu–Konstantan: Skriptwert $K = "0,05" thin "mV/K"$; lineare Näherung.],
 [Photonenergie], [$E_"Photon" = h nu = h c/lambda$], [Energie in J; $1 thin "eV" = "1,602176634" dot.c 10^(-19) thin "J"$.],
 [Bandlückenschwelle], [$nu_g = W/h$; $lambda_g = h c/W$], [Bandlücke $W$ in J; im einfachen Modell $h nu >= W$ bzw. $lambda <= lambda_g$.],
 [Fotostrom am Lastwiderstand], [$U = I_"Foto" R$], [Am tatsächlichen Arbeitspunkt; $I_"Foto"$ nicht bei beliebiger Last konstant annehmen.],
 [Quarztakt], [$f_"Takt" = f_"Quarz"/2^n$; $T = 1/f_"Takt"$], [Elektronische Frequenzteilung; 32768 Hz / $2^15$ = 1 Hz.],
 [R–L-Zeitkonstante], [$tau = L/R$; $I_oo = U_q/R$], [Lineares $L$ in H, gesamter Serienwiderstand $R$ in Ω; $tau$ in s.],
 [R–L-Einschalten], [$i(t) = I_oo (1 - e^(-t/tau))$; $u_L(t) = U_q e^(-t/tau)$], [Gleichspannungssprung bei $t = 0$, $i(0) = 0$; ideale Spule.],
 [Dioden-Arbeitsgerade], [$I = (U_q - U_D)/R$], [Quelle, Vorwiderstand, Diode in Reihe; Schnittpunkt mit Diodenkennlinie.],
 [Potenzial und Spannung], [$U_(A B) = phi_A - phi_B$], [Gleicher Bezugspunkt; Potenziale und Spannung in V.],
 [NTC], [$R(T) = R_(T_0) e^(B(1/T-1/T_0))$], [$T$, $T_0$, $B$ in K; passendes Materialmodell.],
 [Diode], [$I_D = I_S(e^(U_D/(n U_T))-1)$; $U_T = k T/e$], [Shockley-Modell außerhalb des Durchbruchs; $U_T approx 26 thin "mV"$ bei Raumtemperatur.],
 [Diodenwiderstände], [$R_D = U_D/I_D$; $r_e approx n U_T/I_D$], [Statischer Quotient bzw. lokale Tangente; zweite Form bei $I_D >> I_S$.],
 [LED], [$U_"Schwelle" = h c/(e lambda)$; $P_"opt" = eta_"LED" U_D I_D$], [Vereinfachte Photonenergie; Wirkungsgrad bezogen auf die LED.],
 [Transistor], [$I_C approx beta I_B$; $P_T = U_(C E) I_C$], [Aktiver Bereich; Lastgerade und Verlustleistungsgrenze prüfen.],
 [Temperaturgang], [$R approx R_20(1+alpha_20 Delta vartheta+beta_20(Delta vartheta)^2)$], [Linear: quadratischen Term weglassen; Materialbereich beachten.],
 [Zeitabhängige Leistung], [$p(t) = u(t)i(t)$; $W = integral_0^(t_1) p(t) dif t$; $P_"mittel" = W/t_1$], [Integration über denselben Zeitraum; W in J, mittlere Leistung in W.],
)

=== Kapitel 2 · Kirchhoffsche Gesetze und Grundstromkreis
#tab(columns: (1.15fr, 1.8fr, 1.7fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Knoten und Maschen], [$sum I_nu = 0$; $sum U_nu = 0$], [Vorzeichen gemäß Zählpfeilen; konzentriertes Netzwerkmodell.],
 [Grundstromkreis], [$I = U_q\/(R_i + R_a)$; $U_a = U_q - I R_i$], [Reale Quelle = $U_q$ mit $R_i$ in Reihe; Entladebetrieb.],
 [Innenwiderstand], [$R_i = U_l\/I_k$; $I_k = U_q\/R_i$], [Leerlaufspannung $U_l = U_q$.],
 [Quellenkennlinie], [$I(U) = -U\/R_i + I_k$], [Steigung $-1\/R_i$.],
 [Quellen in Reihe], [$U_"q,ers"=sum s_k U_(q k)$; $R_"i,ers"=sum R_(i k)$], [Polungen zählen; innere Widerstände addieren.],
 [Gleiche Quellen parallel], [$U_"q,ers"=U_q$; $R_"i,ers"=R_i/n$], [Gleiche Polung, gleiche Quellenparameter.],
 [Leistungsbilanz], [$U_q I = I^2 R_i + U_a I$], [$P_q = P_v + P_a$.],
 [Wirkungsgrad], [$eta = P_a\/P_q = R_a\/(R_i + R_a)$], [Allgemein $eta = P_"Nutz"\/P_"Aufwand"$.],
 [Leistungsanpassung], [$R_a = R_i$: $P_"a,max" = U_q^2\/(4 R_i)$, $U_a = U_q\/2$, $I = I_k\/2$], [$eta = 50 thin %$.],
 [Fehlanpassung], [$P_a\/P_"a,max" = 4 (R_a\/R_i)\/(1 + R_a\/R_i)^2$], [Nach V S. 46.],
 [Stromteiler], [$I_k=I_"ges" G_k/G_"ges"$], [Nur Leitwerte der betrachteten Verzweigung.],
 [Potenziometer], [$U_A/U_E=x/(1+(R_S/R_A)(x-x^2))$], [$x=R_2/R_S$; feste ohmsche Last.],
 [Spannungsrichtige Messung], [$R_x=U_x/(I-U_x/R_"VM")$], [Voltmeterstrom vom gemessenen Strom abziehen.],
 [Stromrichtige Messung], [$R_x=U/I_x-R_"AM"$], [Amperemeterwiderstand abziehen.],
 [Messgeräte], [$R_"AM"=Delta U/I_"Endwert"$; $R_"VM"=K U_"Endwert"$], [$K$ in Ω/V; zum gewählten Messbereich.],
 [Brückenabgleich], [$R_x=R_N R_1/R_2$], [Querzweigstrom null; Schleifdraht zusätzlich homogen.],
 [Dreieck zu Stern], [$r_A=R_(A B) R_(C A)/(R_(A B)+R_(B C)+R_(C A))$], [Zyklisch für B und C; quellenfreies Widerstands-Teilnetz.],
 [Stern zu Dreieck], [$R_(A B)=(r_A r_B+r_B r_C+r_C r_A)/r_C$], [Gegenüberliegender Arm im Nenner.],
)

=== Kapitel 3 · Netzwerke mit Kirchhoff systematisch berechnen
#tab(columns: (1.15fr, 1.8fr, 1.7fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Lineares Netz], [$A bold(I)=bold(b)$; $I_j=D_j/det(A)$], [Unabhängige Gleichungen; $det(A)!=0$.],
 [Knotenpotenziale], [$I_(A B)=G_(A B)(phi_A-phi_B)$], [Gleicher Bezug; Vorzeichen gemäß gewählter Richtung.],
)

=== Kapitel 4 · Zweipoltheorie und nichtlineare Arbeitspunkte
#tab(columns: (1.15fr, 1.8fr, 1.7fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Zweipol], [$U_l=I_k R_i$; $U=U_l-I R_i$], [Linearer aktiver Quellenteil; gleiche Klemmen.],
 [Nichtlineare Last], [$I_"Last"(U)=(U_l-U)/R_i$], [Arbeitspunkt als Schnitt; mehrere Lösungen möglich.],
 [Kennlinien addieren], [Parallel: $I(U)=I_1(U)+I_2(U)$; Reihe: $U(I)=U_1(I)+U_2(I)$], [Gleiche Spannung bzw. gleicher Strom.],
 [Verlustleistungsgrenze], [$I_"zul"=P_"max"/U$], [Leistungshyperbel; positive Größen im betrachteten Betrieb.],
)

#src([Gesamtskript-Erweiterung: V S. 43–108, insbesondere 47–67, 69–85 und 87–108. Ergänzte Formeln: N30, PDF-S. 1–18 und 20–22 = V S. 20–37 und 39–41; LED, PDF-S. 1; FK-N, PDF-S. 6; V S. 17–19; N, PDF-S. 3 und 6. Voraussetzungen und belasteter Teiler wie in Abschnitt 0.6 und 1.2.3–1.2.6 hergeleitet.])

#note("Wichtige Zahlen", [
$e = "1,602176634" dot.c 10^(-19) thin "As"$ (gerundet $"1,602" dot.c 10^(-19)$); 1 A ≈ $"6,25" dot.c 10^18$ Elektronen pro Sekunde; $n_"Cu" approx "8,44" dot.c 10^22 thin "cm"^(-3)$.

$rho_"Cu" = "0,0178"$ (Ü) bzw. $"0,0179" thin Omega thin "mm"^2\/"m"$ (V); $rho_"Al" = "0,0278" thin Omega thin "mm"^2\/"m"$; $S_"zul" approx 1 dots 6 thin "A/mm"^2$.

Für die neuen Aufgaben: $h approx "6,626" dot.c 10^(-34) thin "Js"$; $c = 299792458 thin "m/s"$; Si: $W = "1,12" thin "eV"$, $lambda_g approx "1,11" thin mu"m"$ (V S. 18–19).

Netz: 230 V, 50 Hz, $T = 20 thin "ms"$; $1 thin "mm"^2 = "0,01" thin "cm"^2 = 10^(-6) thin "m"^2$; $1 thin "kWh" = "3,6" thin "MJ"$.
])
