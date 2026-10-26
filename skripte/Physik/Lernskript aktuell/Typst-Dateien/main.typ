// Kopf des Feynman-Lernskripts (Layout + Bausteine). Bilder liegen in abbildungen/. Keine Pakete erforderlich.
#set document(title: "Physik 2 – Feynman-Lernskript", author: "Lernzusammenfassung")
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
 header: [#text(size: 8pt, fill: muted)[Physik 2 #h(1fr) Sehen · Verstehen · Erklären]], footer: seitenfuss)
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
  "alt-harmwelle": "abbildungen/alt-harmwelle.svg",
  "alt-kopplung": "abbildungen/alt-kopplung.svg",
  "alt-pendel": "abbildungen/alt-pendel.svg",
  "alt-puls": "abbildungen/alt-puls.svg",
  "alt-schwebung": "abbildungen/alt-schwebung.svg",
  "cover": "abbildungen/cover.svg",
  "energie-quelle": "abbildungen/energie-quelle.svg",
  "harmonisch-quelle": "abbildungen/harmonisch-quelle.svg",
  "intensitaet-kurve": "abbildungen/intensitaet-kurve.svg",
  "interferenz-quelle": "abbildungen/interferenz-quelle.svg",
  "kopplung-quelle": "abbildungen/kopplung-quelle.svg",
  "longitudinal-quelle": "abbildungen/longitudinal-quelle.svg",
  "map-intensitaet": "abbildungen/map-intensitaet.svg",
  "map-interferenz": "abbildungen/map-interferenz.svg",
  "map-kopplung": "abbildungen/map-kopplung.svg",
  "map-medium": "abbildungen/map-medium.svg",
  "map-moden": "abbildungen/map-moden.svg",
  "map-schwebung": "abbildungen/map-schwebung.svg",
  "map-welle": "abbildungen/map-welle.svg",
  "mode-fest-quelle": "abbildungen/mode-fest-quelle.svg",
  "mode-frei-quelle": "abbildungen/mode-frei-quelle.svg",
  "mode-gemischt-quelle": "abbildungen/mode-gemischt-quelle.svg",
  "moden-skizze": "abbildungen/moden-skizze.svg",
  "pendel-quelle": "abbildungen/pendel-quelle.svg",
  "puls-quelle": "abbildungen/puls-quelle.svg",
  "reflexion-quelle": "abbildungen/reflexion-quelle.svg",
  "saite-quelle": "abbildungen/saite-quelle.svg",
  "schnelle-quelle": "abbildungen/schnelle-quelle.svg",
  "schwebung-quelle": "abbildungen/schwebung-quelle.svg",
  "stehend-quelle": "abbildungen/stehend-quelle.svg",
  "wellenarten-quelle": "abbildungen/wellenarten-quelle.svg",
)

#let bilddeutungen = (
  "alt-harmwelle": (titel: "Bild lesen", body: [Die blaue Kurve ist eine Momentaufnahme über dem Ort, gestrichelt die kurz darauf. Grün ist der Abstand zweier Berge λ, rot die Richtung von c. Orange zeigt die lokale Schnelle eines Teilchens; sie gehört nicht zur waagerechten Musterbewegung.]),
  "alt-kopplung": (titel: "Bild lesen", body: [Oben ist x₁(t), unten x₂(t), beide mit gleicher Zeitrichtung. Die schnellen Schwingungen liegen in wechselnden Hüllen. Der grüne Pfeil markiert einen vollständigen Hüllenzyklus; ein halber Zyklus reicht von einer großen Hülle zur jeweils anderen.]),
  "alt-pendel": (titel: "Bild lesen", body: [Die äußeren roten Federn besitzen jeweils D, die mittlere blaue Feder Dₖ. Beide Massen sind gleich und werden in derselben Richtung positiv gezählt. Diese Festlegung erklärt die entgegengesetzten Kopplungsterme.]),
  "alt-puls": (titel: "Bild lesen", body: [Die durchgezogene Form ist die Anfangsform; die gestrichelte liegt später weiter rechts. Form und Höhe bleiben in dieser idealisierten Darstellung gleich. Der rote Pfeil zeigt die Verschiebung c · t.]),
  "alt-schwebung": (titel: "Bild lesen", body: [Waagerecht steht eine schematische Zeit, senkrecht die Auslenkung. Blau ist die Summenschwingung; die roten gestrichelten Linien begrenzen sie. Der grüne Abstand zwischen benachbarten Hüllenminima ist Tₛ. Die Grafik zeigt keine zusätzliche niederfrequente Teilchenbahn.]),
  "cover": (titel: "Bild lesen", body: [Links ändern sich Verdichtung und Verdünnung entlang der Ausbreitung; rechts liegt die Auslenkung quer dazu. Die schwarzen Pfeile zeigen die Wanderung des Musters, die roten die lokale Schwingungsrichtung. Beide Bilder sind schematisch und nicht maßstäblich.]),
  "energie-quelle": (titel: "Bild lesen", body: [Die grüne Fläche liegt quer zur Ausbreitungsrichtung. Der rote markierte Bereich trägt durch seine lokale Schnelle Bewegungsenergie. Das Muster läuft nach rechts durch die Fläche; die Intensität zählt die pro Zeit und Fläche übertragene Energie.]),
  "harmonisch-quelle": (titel: "Bild lesen", body: [Die waagerechte Achse ist der Ort. Blau und orange stellen zwei Zeiten dar. Die Kurve ist nach rechts gewandert; der Abstand gleichphasiger benachbarter Punkte heißt Wellenlänge. Die vertikale Auslenkung ist nicht die zurückgelegte Ausbreitungsstrecke.]),
  "intensitaet-kurve": (titel: "Bild lesen", body: [Waagerecht steht die Amplitude relativ zu einem Ausgangswert u₀, senkrecht die Intensität relativ zu I₀. Die Kurve ist eine Parabel: Bei 2u₀ liest du 4I₀ ab, bei 3u₀ den Wert 9I₀. Medium und Frequenz sind festgehalten.]),
  "interferenz-quelle": (titel: "Bild lesen", body: [Rot und blau sind die einzelnen Auslenkungen über dem Ort, schwarz ist ihre punktweise Summe. Links unterscheiden sich die Wellenlängen, rechts stimmen sie überein. Die schwarze Kurve entsteht durch Addition der Höhenwerte, nicht durch Addition von Wellenlängen.]),
  "kopplung-quelle": (titel: "Bild lesen", body: [Beide Diagramme zeigen lokale Auslenkungen über derselben Zeit. Wird die Hülle der einen Bewegung klein, ist die andere groß. Die raschen Nulldurchgänge gehören zum schnellen Takt, das An- und Abschwellen zum langsamen Austausch.]),
  "longitudinal-quelle": (titel: "Bild lesen", body: [Dicht benachbarte Windungen stehen für Verdichtung, größere Abstände für Verdünnung. Die Teilchenverschiebung und die Ausbreitungsrichtung liegen längs desselben Mediums. Rechts erzeugt ein Schlag eine longitudinale Störung im Stab.]),
  "map-intensitaet": (titel: "Bild lesen", body: [Oben trennt die Mindmap Leistung und Leistung pro Fläche. Unten folgen die quadratische Amplitudenwirkung und die Umrechnung von Intensität in empfangene Leistung.]),
  "map-interferenz": (titel: "Bild lesen", body: [Die linken Äste zeigen gleich- und gegenphasige Überlagerung. Rechts steht die Rechenregel: Auslenkungen zuerst addieren. Gegenläufige gleichartige Wellen führen dann zum stehenden Muster.]),
  "map-kopplung": (titel: "Bild lesen", body: [Von der Modellanordnung führt der obere Weg zu Summe und Differenz. Unten stehen die beiden Moden. Gleiche Wege belasten die mittlere Feder nicht; entgegengesetzte Wege erzeugen ihre zusätzliche Rückstellkraft.]),
  "map-medium": (titel: "Bild lesen", body: [Die Äste ordnen die Geschwindigkeitsformeln nach Rückstellwirkung und Trägheit. Die Quadratwurzel macht deutlich: Eine Verdopplung der Ursache verdoppelt nicht automatisch die Geschwindigkeit.]),
  "map-moden": (titel: "Bild lesen", body: [Die oberen Äste legen die Endbedingungen fest: Knoten oder Bauch. Unten folgt, wie viele Halb- oder Viertelwellen hineinpassen. Daraus wird erst die Wellenlänge und dann die Eigenfrequenz berechnet.]),
  "map-schwebung": (titel: "Bild lesen", body: [Das Zentrum verbindet zwei nahe Frequenzen mit schnellem Träger und langsamem Anschwellrhythmus. Lies zuerst die Frequenzdifferenz, dann die Folgerung für das Stimmen: kleine Differenz, lange Schwebungsdauer.]),
  "map-welle": (titel: "Bild lesen", body: [Das Zentrum verbindet lokale Teilchenbewegung und wanderndes Muster. Links stehen die räumliche und zeitliche Beschreibung, rechts die Aufgaben von Medium und Quelle. Daraus entsteht c = λf.]),
  "mode-fest-quelle": (titel: "Bild lesen", body: [Alle farbigen Formen besitzen an beiden Grenzen Auslenkung null. Mit zunehmender Ordnung passen mehr halbe Wellenlängen auf dieselbe Länge L. Die Farben unterscheiden mögliche Moden, keine verschiedenen Materialien.]),
  "mode-frei-quelle": (titel: "Bild lesen", body: [Beide Ränder liegen an Schwingungsbäuchen. Die verschiedenfarbigen Moden haben unterschiedliche Zahlen innerer Knoten. Die Randwerte sind Auslenkungsmaxima, während die Wellenlänge wie beim Fall fest–fest 2L/n beträgt.]),
  "mode-gemischt-quelle": (titel: "Bild lesen", body: [Links bleibt der Punkt fest, rechts kann er schwingen. Eine Viertelwelle ist die Grundform; die nächsten Formen enthalten drei beziehungsweise fünf Viertelwellen. An keiner zulässigen Form darf rechts ein Knoten erzwungen werden.]),
  "moden-skizze": (titel: "Bild lesen", body: [Jede Spalte hat eine eigene Randbedingung, jede Zeile die nächste zulässige Mode. Durchgezogen und gestrichelt zeigen entgegengesetzte Auslenkungsphasen derselben Form. Gefüllte Endpunkte markieren feste Enden. Die waagerechte Strecke reicht jeweils von x/L = 0 bis 1; die Höhe ist normiert.]),
  "pendel-quelle": (titel: "Bild lesen", body: [Grün sind die beiden gleichen Massen, rot die äußeren Federn und blau die Kopplungsfeder. Beide Auslenkungspfeile zeigen nach rechts. Die mittlere Feder reagiert auf die Abstandsänderung zwischen den Massen.]),
  "puls-quelle": (titel: "Bild lesen", body: [Beide Achsenbilder zeigen Auslenkung über Ort. Links liegt die Anfangsform bei x₁, rechts dieselbe Form später bei x₂. Der Abstand x₂ − x₁ wächst bei konstanter Ausbreitung mit c · t.]),
  "reflexion-quelle": (titel: "Bild lesen", body: [Jeweils oben läuft der ursprüngliche Puls auf das Ende zu, darunter läuft der reflektierte zurück. Links ist das Ende fest: Berg wird Tal. Rechts ist es lose: Der reflektierte Puls bleibt gleich orientiert.]),
  "saite-quelle": (titel: "Bild lesen", body: [Links zieht eine Kraft F die Saite straff. Rechts regt ein Schlag die Bewegung des Stabes an. Die Verbindung zum Nachbarn überträgt die Störung; welche Rückstellwirkung vorliegt, entscheidet über die passende Geschwindigkeitsformel.]),
  "schnelle-quelle": (titel: "Bild lesen", body: [Der waagerechte rote Pfeil bezeichnet die Bewegung des Musters. Der senkrechte grüne Pfeil bezeichnet die Geschwindigkeit eines lokalen Teilchens. Ihre Richtungen müssen bei einer Transversalwelle verschieden sein.]),
  "schwebung-quelle": (titel: "Bild lesen", body: [Waagerecht steht die Zeit, senkrecht die Auslenkung. Die schnelle Schwingung liegt in der langsamen Hüllkurve. Die grün markierte Schwebungsdauer verbindet benachbarte Minima des Betrags; die Vorzeichenänderung der Hülle ist keine negative Lautstärke.]),
  "stehend-quelle": (titel: "Bild lesen", body: [Waagerecht steht der Ort. Die blaue Hülle legt die maximale Auslenkung fest; die roten Pfeile zeigen die zeitliche Bewegung. An Knoten bleibt die Auslenkung null, an Bäuchen erreicht die lokale Amplitude ihren größten Betrag. Benachbarte Knoten liegen eine halbe Wellenlänge auseinander.]),
  "wellenarten-quelle": (titel: "Bild lesen", body: [Die grüne Markierung zeigt die Ausbreitungsrichtung. Links schwingen die Pendel entlang dieser Richtung; rechts quer dazu. Die Ausbreitung wird mit der Schwingungsrichtung verglichen, nicht mit dem Verlauf der gezeichneten Verbindungslinie.]),
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
#text(size: 29pt, weight: "bold", fill: navy)[Physik 2]
#v(4mm)
#text(size: 20pt, fill: navy)[Feynman-Lernskript]
#v(3mm)
#text(size: 12pt)[Zusammenhänge sehen. Grundlagen verstehen. Selbst erklären.]
#v(5mm)
#bild("cover", [Longitudinale und transversale Bewegung. Eigene schematische Darstellung aus dem bisherigen Lernskript; nicht maßstäblich.], height: 65mm)
#v(4mm)
#text(size: 12pt, fill: teal)[Schwingung → Kopplung → Welle → Randbedingung]
]
#note("Dein Feynman-Schritt", [Sieh hin, erkläre den Zusammenhang ohne Vorlage und prüfe dann Formel und Voraussetzungen. Bearbeite anschließend eine Aufgabe auf der Lernwebseite. Vergleiche erst danach mit den Lösungsschritten und schließe deine konkrete Lücke.])

Stand *26.10.2026*: eingearbeitet sind Schwebung und Kopplung aus VL 1 sowie Wellen bis zu den eindimensionalen Eigenmoden an der bestätigten Grenze „Ende VL 19.10.“. Die Kapitelnummern 5 und 6 folgen dem Dozentenskript. Vorwissen steht als solches dabei. Stand *26.10.2026*: Aufgaben, ausführliche Lösungen und Quiz stehen auf der Lernwebseite (Tab „Lernen“); dieses Skript enthält nur noch Erklärung und Formelsammlung.
#src[V1, PDF-S. 1–13; VB, PDF-S. 3–22 bis zur Markierung; Bestätigung von Mario am 22.10.2026.]

#pagebreak()
#heading(level: 1, outlined: false)[Wegweiser]
#block[
#set text(size: 9.5pt)
#set par(leading: 0.3em, spacing: 0.15em)
#outline(title: none, depth: 2, indent: auto)
]
#v(2mm)
#text(size: 8.5pt, fill: muted)[*Quellenkürzel:* V = Flossmann, Physik für Ingenieure, Stand 26.10.2026, Gesamt-PDF; V1 = VL1 Physik (13 PDF-Seiten, Skript S. 169–174 und 177–183); VB = VL Physik bisher (22 PDF-Seiten, Skript S. 175–196); Ü = Physik2_Blatt10, Aufgaben 10.1–10.6; R = handschriftliche Lösung Blatt 10; AS = Aufgabensammlung, 23.04.2026, Nummer laut Sammlung; L = bisheriges Lernskript Physik 2, Stand 26.10.2026 (PDF und HTML); LB = Lernblatt VL 1 (Claude-Fassung und annotierter Export); K17/18 = Klausur Physik 1 WIW WS 17/18 mit Musterlösung; K15 = Prüfung Phy_1 (Deckblatt WS 2015/16). „PDF-S.“ zählt ab der ersten PDF-Seite der genannten Datei. Bei V stimmt diese Zählung für die verwendeten Seiten mit dem Seitenaufdruck überein. Alle „Nachschlagen“-Verweise führen zu Abschnitt und echter Seite dieses Lernskripts. Eigene Aufgaben, Umformungen und Darstellungen sind gekennzeichnet.]
#pagebreak()
#heading(level: 1, outlined: false, bookmarked: false)[Das Modul auf einen Blick] <ueberblick>

Jeder Kasten führt zu seinem Kapitel. Die Pfeiltexte zeigen, wie die Kapitel zusammenhängen.

#karte((1fr, auto, 1fr),
  chunk([Kapitel 5 · Schwingungen], [Federpendel · Schwebung · Kopplung · Eigenmoden], ziel: <a-5>),
  pfeil(beschriftung: [führt über Kopplung zu]),
  chunk([Kapitel 6 · Wellen], [Wellenfunktion · Medium · Intensität · Interferenz · Randbedingungen], ziel: <a-6>),
)

Eine Schwingung beschreibt die Bewegung an einem Ort. Gekoppelte Schwinger geben die Störung weiter und bilden die Brücke zur Welle. Bei Wellen trennst Du die lokale Teilchenbewegung vom wandernden Muster und seinem Energiefluss. Überlagerung und Randbedingungen bestimmen schließlich, welche stehenden Eigenmoden möglich sind.
#src[Eigene Darstellung; Zusammenführung des bereits enthaltenen Stoffs und der Denkkette auf der Titelseite.]

#pagebreak()
#pagebreak(weak: true)
= Kapitel 5 · Schwingungen <a-5>

#überblick([Kapitel 5 auf einen Blick],
  idee(<a-5-0>, [Der einzelne Schwinger ist der Baustein.], [Rückstellkraft und Trägheit bestimmen seinen Takt.]),
  idee(<a-5-4-1>, [Nahe Frequenzen erzeugen Schwebung.], [Die Phasendifferenz lässt die gemeinsame Amplitude langsam an- und abschwellen.]),
  idee(<a-5-4-2>, [Kopplung überträgt Kräfte.], [Gleich- und Gegentakt zerlegen die Bewegung in zwei unabhängige Eigenmoden.]),
  idee(<a-5-4-3>, [Die Moden ergeben die reale Bewegung.], [Ihre Überlagerung erklärt den langsamen Austausch zwischen den Pendeln.]),
)

#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Federpendel], [Rückstellkraft · Trägheit], ziel: <a-5-0>),
  pfeil(beschriftung: [Kopplungsfeder ergänzt]),
  chunk([Gekoppelte Pendel], [Gleichtakt · Gegentakt], ziel: <a-5-4-2>),
  pfeil(beschriftung: [Überlagerung erklärt]),
  chunk([Energieaustausch], [Überlagerung der Eigenmoden], ziel: <a-5-4-3>),
)
#karte((1fr, auto, 1fr),
  chunk([Zwei nahe Frequenzen], [Phasen verschieben sich], ziel: <a-5-4-1>),
  pfeil(beschriftung: [erzeugen]),
  chunk([Schwebung], [langsame Hülle · schneller Träger], ziel: <a-5-4-1>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])


Dieses Kapitel setzt bei dem in VL 1 behandelten Abschnitt 5.4 an. Zuerst addieren wir zwei Schwingungen, dann koppeln wir zwei Schwinger mechanisch. Die gleiche Mathematik erklärt dadurch sowohl das langsame An- und Abschwellen eines Tons als auch den Austausch zwischen zwei Pendeln.
#src[V1, PDF-S. 1–6 (Skript S. 169–174); L, PDF-S. 2–5.]

== 5.0 Vorwissen · Ein Federpendel als Baustein <a-5-0>
Eine ausgelenkte Feder zieht eine Masse zur Ruhelage zurück. Wegen ihrer Trägheit fliegt die Masse über diese Lage hinaus; im idealen Modell wiederholt sich die Bewegung. *Harmonisch* heißt: Die Auslenkung folgt einer Sinus- oder Kosinusfunktion.
#form[$ m dot.double(x)=-D x quad arrow.l.r quad dot.double(x)+D/m x=0 $]
#form[$ x(t)=A sin(omega_0 t+phi_0), quad omega_0=sqrt(D/m), quad omega=2 pi f, quad T=1/f $]
$m$ ist die schwingende Masse in kg, $D$ die Federkonstante in N/m, $A$ die Amplitude in m. $f$ zählt Schwingungen pro Sekunde in Hz, $omega$ ist die Kreisfrequenz in rad/s und $T$ die Periodendauer in s. $phi_0$ legt die Anfangslage fest.

#note("Gültigkeit", [Lineare Feder, konstante Masse, keine Dämpfung. Die Auslenkung wird von der Gleichgewichtslage gemessen. *Eigene Erklärungshilfe:* In $dot.double(y)+a y=0$ mit $a>0$ liest du $omega_0=sqrt(a)$ ab.], fill: sand)

*Eigene Erklärungshilfe:* Eine Frequenz von 2 Hz bedeutet zwei vollständige Wiederholungen in einer Sekunde. Der Sinus durchläuft dabei $4 pi$ Radiant. Deshalb sind $f$ und $omega$ verschiedene Zahlen für denselben Takt.
#src[V, PDF-S. 146–150, Gl. 5.1–5.8; L, PDF-S. 2; eigene Erläuterung aus diesen Gleichungen.]
#hoch(<a-5>, [Kapitelübersicht])


== 5.4 Überlagerung und Kopplung <a-5-4>
=== 5.4.1 Schwebung · Ein schneller Ton mit langsamem Rhythmus <a-5-4-1>
Zwei fast gleich gestimmte Stimmgabeln erzeugen zusammen einen Ton, der regelmäßig lauter und leiser wird. Diese *Schwebung* entsteht, weil sich ihre Phasen langsam gegeneinander verschieben: einmal verstärken sich die Auslenkungen, später wirken sie einander entgegen.

#bild("schwebung-quelle", [Schwebung im Dozentenskript: schneller Träger und langsame Hüllkurve. V1, PDF-S. 2, Abb. 5.8.], height: 48mm)

Für gleiche Amplituden $A$ und dieselbe Anfangsphase liefert das Additionstheorem:
#form[$ A sin(omega_1 t)+A sin(omega_2 t)=2 A cos((omega_1-omega_2)/2 t) sin((omega_1+omega_2)/2 t) $]

Die Summe bleibt also ein schneller Sinus, dessen Vorfaktor langsam zwischen $+2A$ und $-2A$ wechselt. Der Betrag dieses Vorfaktors beschreibt das An- und Abschwellen. Gleiche Amplituden ermöglichen eine vollständige Auslöschung; ungleiche Amplituden lassen ein Restminimum übrig (*ergänzt: aus der Addition der Auslenkungen*).

#form[$ omega_m=(omega_1+omega_2)/2, quad omega_d=abs(omega_1-omega_2)/2 $]
#form[$ f_m=(f_1+f_2)/2, quad f_s=abs(f_1-f_2), quad T_s=1/f_s=(2 pi)/abs(omega_1-omega_2) $]

$omega_m$ heißt im Skript Mittenkreisfrequenz: Sie beschreibt den schnellen Träger. $omega_d$ ist dort die „Differenzfrequenz“ der vorzeichenbehafteten Kosinushülle. Die hörbare Schwebungsfrequenz $f_s$ zählt dagegen die Lautstärkemaxima. Alle $f$ stehen in Hz; alle $omega$ in rad/s; $T_s$ in s.

#note("In deinen Unterlagen hervorgehoben", [V1, PDF-S. 1–3: Addition der Schwingungen, Mittenfrequenz, Differenzfrequenz und Schwebungsdauer. *Der Faktor zwei zählt:* Der Betrag der Hülle hat bei positiver und negativer Hülle ein Maximum. Deshalb ist $T_s$ nur die halbe Periode der Kosinushülle.])

*Beispiel aus dem alten Lernblatt:* 440 Hz und 442 Hz ergeben $f_m=441 thin "Hz"$ und $T_s="0,5" thin "s"$. Beim Stimmen wird die Schwebung langsamer, wenn die Frequenzen näher zusammenrücken. Bei gleichen Frequenzen gibt es kein periodisches An- und Abschwellen mehr; $T_s$ wächst im Grenzübergang unbegrenzt.

#bild("alt-schwebung", [Schwebung als Kurve, aus dem bisherigen Lernskript übernommen; eigene Darstellung, Achsen schematisch.], height: 47mm)

#note("In eigenen Worten", [*Eigene Analogie:* Zwei Läufer mit fast gleichem Tempo treffen nach jeder Überrundung wieder zusammen. Eine kleinere Tempodifferenz macht diesen Rhythmus langsamer. Die Analogie erklärt die Phasendifferenz; sie beschreibt keine mechanische Kopplung der Stimmgabeln.])

*Technischer Bezug, eigene Ergänzung aus L:* Zwei nahezu gleich getaktete Maschinen können ein langsames Dröhnen erzeugen, wenn ihre Schwingungen sich überlagern. Aus der Schwebung folgt die Differenz der Schwingungsfrequenzen. Eine Drehzahldifferenz folgt erst dann direkt, wenn die Zahl der Anregungen pro Umdrehung bekannt ist.

*Klavierbeispiel aus V1:* Leicht gegeneinander verstimmte Saiten können einen volleren Klang erzeugen. Die Skriptformulierung „jeder Ton hat drei Saiten“ wird hier als vereinfachtes Beispiel mehrerer Saiten gelesen; die Schwebungsrechnung benötigt keine bestimmte Saitenzahl.
#bild("map-schwebung", [Mindmap zur Schwebung. Eigene Darstellung; FET-Mindmap kopiert, nur Texte geändert.], height: 46mm)
#note("Selbst erklären", [Warum hört man nicht einfach einen 2-Hz-Ton, wenn 440 Hz und 442 Hz überlagert werden? *Antwort:* Die schnelle Schwingung liegt nahe 441 Hz. Die 2 Hz beschreiben, wie häufig ihr Betrag anschwillt.])
#src[V1, PDF-S. 1–3, Gl. 5.25–5.27; L, PDF-S. 3 und 10–11; LB, PDF-S. 1. Eigene Analogien und Ableitungen sind gekennzeichnet.]

=== 5.4.2 Gekoppelte Schwingungen · Zwei Massen wirken aufeinander <a-5-4-2>
Bei bloßer Überlagerung addieren wir zwei Bewegungen. Bei *Kopplung* beeinflusst dagegen ein Schwinger den anderen: Zwischen zwei gleichen Federpendeln sitzt eine weitere Feder. Sie überträgt Kräfte und damit Energie.
#bild("pendel-quelle", [Zwei identische Federpendel mit Kopplungsfeder. V1, PDF-S. 4, Abb. 5.9.], height: 30mm)

Beide Massen haben $m$, die äußeren Federn jeweils $D$, die mittlere Feder $D_k$. Beide Auslenkungen $x_1,x_2$ werden nach rechts positiv gemessen. Der relative Abstand verändert sich um $x_2-x_1$; deshalb hängt die Kopplungskraft von beiden Auslenkungen ab.
#form[$ m dot.double(x)_1=-D x_1-D_k(x_1-x_2) $]
#form[$ m dot.double(x)_2=-D x_2-D_k(x_2-x_1) $]
Die Kopplungskräfte sind entgegengesetzt. Bei $x_1=x_2$ sind sie null. Bei $x_1=x$ und $x_2=-x$ wird die Kopplungsfeder um den Betrag $2 abs(x)$ verändert. Das erklärt den späteren Faktor $2D_k$.

*Summe und Differenz entkoppeln die Bewegung*
Wir addieren die Gleichungen und subtrahieren sie. Mit $psi_1=x_1+x_2$ und $psi_2=x_1-x_2$ entstehen zwei unabhängige Gleichungen:
#form[$ dot.double(psi)_1+D/m psi_1=0, quad dot.double(psi)_2+(D+2D_k)/m psi_2=0 $]
Damit gilt das Muster des einzelnen Federpendels zweimal. Im alten Lernblatt heißen dieselben Hilfsgrößen $xi_1$ und $xi_2$; dies ist nur eine andere Bezeichnung.

#form[$ omega_"gl"=sqrt(D/m), quad omega_"gg"=sqrt((D+2D_k)/m) $]

Eine *Eigenmode* ist eine feste gemeinsame Schwingungsform aller beteiligten Massen. In einer reinen Eigenmode schwingen beide mit derselben Eigenfrequenz; ihr Amplitudenverhältnis bleibt gleich.
#tab(columns: (1fr, 1.5fr, 1.5fr),
 th([Merkmal], [Gleichtakt], [Gegentakt]),
 [Bewegung], [$x_1=x_2$], [$x_1=-x_2$],
 [Hilfsgröße], [$psi_2=0$], [$psi_1=0$],
 [Mittlere Feder], [Nicht zusätzlich gedehnt], [Dehnung/Stauchung mit Betrag $2 abs(x)$],
 [Eigenkreisfrequenz], [$sqrt(D/m)$], [$sqrt((D+2D_k)/m)$],
)

#bild("alt-pendel", [Das Federmodell aus dem bisherigen Lernskript. Eigene Darstellung; nicht maßstäblich.], height: 28mm)

#note("Fehler vermeiden", [„Im Gegentakt maximal belastet“ meint: Bei gleicher Massenauslenkung ist die Kopplungsdehnung besonders groß. Sie ist *nicht zu jedem Zeitpunkt maximal*: Beim Durchgang durch die Ruhelage ist sie null. Die höhere Frequenz stammt aus der zusätzlichen Rückstellwirkung.], fill: sand)

#note("Abweichungen in den Quellen", [V1, PDF-S. 5: Die zweite Eigenfrequenz ist an einer Stelle erneut mit „gl“ beschriftet; gemeint ist $omega_"gg"$. Bei $psi_2$ steht dort $A_1$, während die Rücktransformation auf PDF-S. 6 eine eigene Amplitude $A_2$ verwendet. Hier stehen zwei unabhängige Modenamplituden. Im Nenner von $T_s$ auf PDF-S. 6 ist mit $omega_g$ der Gleichtakt $omega_"gl"$ gemeint.], fill: sand)
#bild("map-kopplung", [Mindmap zu Kopplung und Eigenmoden. Eigene Darstellung.], height: 46mm)
#src[V1, PDF-S. 4–6; V, PDF-S. 172–174; L, PDF-S. 4–5 und 18; LB, PDF-S. 1. Erläuterung des Kopplungsterms und Korrekturen aus diesen Gleichungen.]

=== 5.4.3 Rücktransformation und Energieaustausch <a-5-4-3>
Aus den beiden einfachen Moden bauen wir die tatsächlichen Bewegungen wieder zusammen:
#form[$ x_1=(psi_1+psi_2)/2, quad x_2=(psi_1-psi_2)/2 $]
Für allgemeine Anfangsbedingungen erhält jede Mode eine eigene Amplitude und Phase. Die im Skript gezeigte Sinuslösung ist ein spezieller Fall davon (*ergänzt*).

*Ein Pendel auslenken und loslassen:* Für $x_1(0)=A$, $x_2(0)=0$ und beide Anfangsgeschwindigkeiten null gilt als eigene Ableitung aus den Modengleichungen:
#form[$ x_1(t)=A/2 (cos(omega_"gl" t)+cos(omega_"gg" t)) $]
#form[$ x_2(t)=A/2 (cos(omega_"gl" t)-cos(omega_"gg" t)) $]

Mit $bar(omega)=(omega_"gg"+omega_"gl")/2$ und $Delta omega=omega_"gg"-omega_"gl"$ wird daraus:
#form[$ x_1=A cos(Delta omega t/2)cos(bar(omega)t) $]
#form[$ x_2=A sin(Delta omega t/2)sin(bar(omega)t) $]

Die Hüllen wechseln sich ab. Der langsame Austausch ist dieselbe Schwebungsmathematik wie bei zwei Stimmgabeln.

#bild("alt-kopplung", [Zeitverläufe zweier gekoppelter Pendel aus L. Eigene Darstellung, normierte Auslenkungen und schematische Zeitachse.], height: 48mm)
#form[$ T_s=(2 pi)/(omega_"gg"-omega_"gl") $]
$T_s$ beschreibt einen vollständigen Hüllkurvenzyklus von Pendel 1 zu Pendel 2 und zurück. Nach ungefähr $T_s/2$ ist die Hülle von Pendel 1 klein und die von Pendel 2 groß. Stärkeres $D_k$ erhöht $omega_"gg"$, lässt $omega_"gl"$ unverändert und verkürzt $T_s$.

#bild("kopplung-quelle", [Austausch im Vorlesungsskript. V1, PDF-S. 6, Abb. 5.10.], height: 40mm)
#note("Gültigkeit", [Identische lineare Schwinger, keine Dämpfung. Die anschauliche Aussage „Energie wandert komplett hin und her“ ist das Schwebungsbild der Vorlesung. *Präzisierung aus den Gleichungen:* Eine momentane Auslenkung null beweist noch keine Ruhe, und auch die Kopplungsfeder speichert Energie. Für schwache Kopplung lassen sich Hüllkurve und schneller Takt besonders gut trennen.], fill: sand)

Erweitert man das Modell auf $N$ linear gekoppelte Schwinger mit je einem Freiheitsgrad, gibt es $N$ Eigenmoden. Ihre Eigenfrequenzen müssen nicht alle verschieden sein (*Präzisierung des Modenbegriffs*). Viele aneinander gekoppelte Schwinger bilden die Brücke zur Welle.
#note("Selbst erklären", [Warum bleibt im reinen Gleichtakt die Kopplungsfeder wirkungslos? *Antwort:* Beide Massen verschieben sich gleich weit; ihr gegenseitiger Abstand ändert sich nicht. Ohne relative Dehnung gibt es keine zusätzliche Kopplungskraft.])
#src[V1, PDF-S. 5–6; L, PDF-S. 5. Kosinuslösung, Anfangsbedingungen und Präzisierungen: eigene Ableitung aus V1, PDF-S. 4–6.]

*Der Zusammenhang in Kapitel 5.* Beim einzelnen Federpendel liefert die Rückstellwirkung die Eigenfrequenz. Zwei ähnliche Frequenzen erzeugen eine langsame Schwebung. Die gekoppelten Gleichungen lassen sich in zwei solche Einzelbewegungen zerlegen; ihre Rücktransformation erklärt den Austausch zwischen den Massen. Eine lange Kette setzt diese Weitergabe räumlich fort und führt zum Wellenmodell.
#src[V1, PDF-S. 1–7; eigene Zusammenfassung.]
#hoch(<a-5>, [Kapitelübersicht])


#pagebreak(weak: true)
= Kapitel 6 · Wellen <a-6>

#überblick([Kapitel 6 auf einen Blick],
  idee(<a-6-1>, [Das Muster wandert, die Teilchen schwingen lokal.], [Die Wellenfunktion beschreibt Auslenkung nach Ort und Zeit.]),
  idee(<a-6-2>, [Ort und Zeit haben je einen Takt.], [Wellenlänge und Frequenz sind über die Ausbreitungsgeschwindigkeit verbunden.]),
  idee(<a-6-3>, [Das Medium bestimmt die Geschwindigkeit.], [Rückstellwirkung und Trägheit legen den passenden Modellansatz fest.]),
  idee(<a-6-4>, [Amplitude bestimmt den Energiefluss.], [Im harmonischen Modell wächst die mittlere Intensität quadratisch mit der Amplitude.]),
  idee(<a-6-5>, [Überlagerung addiert Auslenkungen.], [Gegenläufige Wellen können ein stehendes Muster erzeugen.]),
  idee(<a-6-7>, [Die Enden wählen die Eigenmoden.], [Knoten und Bäuche begrenzen die erlaubten Wellenlängen und Frequenzen.]),
)

#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Anregung], [Frequenz · Amplitude], ziel: <a-6-2>),
  pfeil(beschriftung: [bestimmt Takt und Stärke]),
  chunk([Laufende Welle], [Wellenlänge · Intensität], ziel: <a-6-4>),
  pfeil(beschriftung: [braucht Modell für c]),
  chunk([Medium], [Rückstellwirkung · Trägheit · Geschwindigkeit], ziel: <a-6-3>),
)
#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Überlagerung und Reflexion], [hin- und rücklaufende Welle], ziel: <a-6-5>),
  pfeil(beschriftung: [erzeugen]),
  chunk([Stehende Welle], [Knoten · Bäuche], ziel: <a-6-6>),
  pfeil(beschriftung: [Randbedingungen wählen]),
  chunk([Erlaubte Eigenmoden], [Enden · Länge · Frequenz], ziel: <a-6-7>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])


Wir verfolgen nun, wie eine Störung von Ort zu Ort weitergegeben wird. Erst lesen wir die Wellenfunktion, dann bestimmen wir Geschwindigkeit und Energiefluss. Zum Schluss zeigt die Überlagerung, welche stehenden Muster zu festen oder freien Enden passen.
#src[VB, PDF-S. 3–22 bis zur handschriftlichen Grenze; V1, PDF-S. 7–13.]

== 6.1 Grundbegriffe · Das Muster wandert <a-6-1>
Eine *Welle* ist eine sich ausbreitende Störung beziehungsweise ein weitergegebener Schwingungszustand. Bei der hier betrachteten mechanischen Welle bewegen sich die Teilchen um ihre Ruhelage; sie reisen nicht mit dem Wellenberg durch das ganze Medium. Dabei kann Energie weitergegeben werden.

#bild("wellenarten-quelle", [Longitudinale und transversale Welle an gekoppelten Pendeln. VB, PDF-S. 3, Abb. 6.1.], height: 39mm)
#tab(columns: (1fr, 1.8fr, 1.8fr),
 th([Wellenart], [Bewegung der Teilchen], [Beispiele aus der Vorlesung]),
 [Longitudinal], [Parallel zur Ausbreitung; Verdichtung und Verdünnung], [Schall in Gasen, Flüssigkeiten und Festkörpern],
 [Transversal], [Senkrecht zur Ausbreitung], [Seil; elastische Stäbe/Platten; Licht als elektromagnetische Welle],
)

*Eigene Analogie aus L:* Bei einer Stadionwelle bleiben die Menschen an ihren Plätzen, während das Aufstehen weiterwandert. Das erklärt die Trennung von lokaler Bewegung und wanderndem Muster. Eine mechanische Welle entsteht jedoch durch Kräfte im Medium, nicht durch die bewusste Reaktion von Menschen.

Eine Welle muss nicht periodisch sein. Ein einzelner Knall oder ein einmaliges Zupfen an einer Leine erzeugt einen *Puls*, also eine einzelne wandernde Störung.
#note("Gültigkeit und Beispiele", [Mechanische Transversalwellen im Inneren eines Mediums brauchen eine seitliche Rückstellwirkung. Das Skript beschreibt sie über Scherkräfte und nennt Festkörper. Licht ist das gesondert genannte elektromagnetische Beispiel. Die im Übungsblatt vorkommende Wasseroberflächenwelle dient hier als Laufzeitbeispiel; die Teilchenbewegung an einer Oberfläche wird damit nicht als reine Querwelle festgelegt.], fill: sand)

*Anwendung aus dem Skript:* VB, PDF-S. 4 vergleicht die longitudinalen Druckanteile einer Explosion mit den starken transversalen Anteilen von Erdbeben. Wir verwenden diesen vereinfachten Vergleich zur Bedeutung der beiden Richtungen. Die dortige pauschale Aussage „reine Druckwellen“ ist kein hier hergeleitetes allgemeines Verfahren zur Ursachenbestimmung.
#src[VB, PDF-S. 3–4; V1, PDF-S. 7–8; L, PDF-S. 6; Ü 10.2. Analogie und Einschränkung des Beispiels: eigene Erklärung.]

=== 6.1.1 Eine Wellenfunktion lesen <a-6-1-1>
Die *Wellenfunktion* $psi(x,t)$ beantwortet zwei Fragen gleichzeitig: Wie stark ist das Medium am Ort $x$ ausgelenkt, und wie sieht diese Auslenkung zur Zeit $t$ aus? $x$ bezeichnet dabei den Ort, nicht die Auslenkung selbst.

#bild("puls-quelle", [Ein unverändert verschobener Puls. VB, PDF-S. 5, Abb. 6.2.], height: 38mm)
#form[$ c=(Delta x)/(Delta t), quad psi(x,t)=u(x-c t) " oder " u(x+c t) $]
$c$ ist die Ausbreitungsgeschwindigkeit in m/s; $Delta x$ die zurückgelegte Strecke in m, $Delta t$ die Zeit in s. $u(x)$ ist die Anfangsform bei $t=0$. Ein Minuszeichen steht für Ausbreitung nach $+x$, ein Pluszeichen für Ausbreitung nach $-x$.

*Eigene Herleitung:* Ein bestimmter Wellenberg liegt bei einem festen Argument $x-c t=a$. Also ist $x=a+c t$: Sein Ort wächst mit der Zeit. Aus $x+c t=a$ folgt entsprechend $x=a-c t$.
#bild("alt-puls", [Verschiebung einer Anfangsform aus L. Eigene Darstellung; Zeit und Ort schematisch.], height: 32mm)
#note("In deinen Unterlagen hervorgehoben", [VB, PDF-S. 6: $psi(x,t)=u(x plus.minus c t)$. Prüfe zuerst die *Konstanz des Arguments*, wenn du die Laufrichtung begründest.])
#note("Gültigkeit", [Das einfache Verschiebungsmodell setzt eine unverändert wandernde Form und konstantes $c$ voraus. Im behandelten Idealmodell werden Dämpfung und eine Verformung des Pulses nicht berücksichtigt.], fill: sand)
#src[VB, PDF-S. 5–6, Gl. 6.1; V1, PDF-S. 9–10; L, PDF-S. 6–7; Richtungsherleitung: eigene Ableitung.]
#hoch(<a-6>, [Kapitelübersicht])


== 6.2 Harmonische Wellen · Ort und Zeit haben je einen Takt <a-6-2>
Eine *harmonische Welle* besitzt Sinusform. In einem Ortsbild wiederholt sie sich nach einer Wellenlänge $lambda$; an einem festgehaltenen Ort wiederholt sie sich nach einer Periodendauer $T$. Das sind räumliche und zeitliche Wiederholung desselben Musters.
#bild("harmonisch-quelle", [Zwei Momentaufnahmen einer harmonischen Welle. VB, PDF-S. 7.], height: 43mm)
#form[$ psi(x,t)=psi_0 sin(k x-omega t-phi_0) $]
#form[$ k=(2 pi)/lambda, quad omega=2 pi f=(2 pi)/T, quad c=lambda f=omega/k $]

#tab(columns: (1fr, 1.5fr, 1fr),
 th([Symbol], [Bedeutung], [Einheit]),
 [$psi, psi_0$], [Auslenkung, maximale Amplitude], [m],
 [$x, lambda$], [Ort, Wellenlänge], [m],
 [$t,T$], [Zeit, Periodendauer], [s],
 [$k$], [Wellenzahl; Phase je Strecke], [$"m"^(-1)$],
 [$f$], [Schwingungen je Zeit], [Hz],
 [$omega$], [Kreisfrequenz], [rad/s],
 [$phi_0$], [Anfangsphase], [rad],
)

*Warum $c=lambda f$?* In einer Periode $T$ rückt ein Wellenberg genau um $lambda$ vor. Also ist $c=lambda/T=lambda f$. Mit $omega=2pi f$ und $k=2pi/lambda$ folgt $c=omega/k$ (*eigene Umformung*).

Die Quelle legt den zeitlichen Takt $f$ fest. Das Medium legt im behandelten Modell die Geschwindigkeit $c$ fest. Die passende Wellenlänge ist dann $lambda=c/f$. Beim Übergang zwischen zwei ruhenden Medien bleibt der von der Quelle vorgegebene Takt gleich; $c$ und $lambda$ können sich ändern.

*Zahlenbeispiel aus LB:* Für $c=343 thin "m/s"$ und $f=440 thin "Hz"$ ist $lambda=343/440 thin "m" approx "0,780" thin "m"$.
#bild("alt-harmwelle", [Wellenlänge, Ausbreitung und Teilchenbewegung aus L. Eigene Darstellung.], height: 41mm)
#note("In deinen Unterlagen hervorgehoben", [VB, PDF-S. 7–8: harmonische Wellenfunktion und $lambda f=c$. Ein Sinusargument muss dimensionslos sein: $k x$ und $omega t$ tragen jeweils eine Phase, keine Längen- oder Zeiteinheit.])

*Fourier-Gedanke:* Auch eine nicht sinusförmige Störung kann als Überlagerung harmonischer Anteile beschrieben werden. Deshalb sind harmonische Wellen die Bausteine der Vorlesung. Daraus folgt nicht, dass jede beliebige Gesamtwelle selbst sinusförmig ist.
#src[VB, PDF-S. 7–8, Gl. 6.2–6.3; V1, PDF-S. 11–12; LB, PDF-S. 1; Ü 10.1 und Lösung R, PDF-S. 1; L, PDF-S. 7. Umformungen: eigene Ableitungen.]

=== 6.2.1 Schnelle und Wellenfronten <a-6-2-1>
Die *Schnelle* $s$ ist die Geschwindigkeit eines Teilchens am betrachteten Ort. Die Ausbreitungsgeschwindigkeit $c$ beschreibt dagegen die Bewegung einer gleichen Phase, etwa eines Wellenbergs. Das sind zwei verschiedene Bewegungen.
#bild("schnelle-quelle", [Lokale Schnelle und wanderndes Muster. VB, PDF-S. 8.], height: 38mm)
#form[$ s(x,t)=(partial psi)/(partial t)=-psi_0 omega cos(k x-omega t-phi_0), quad s_"max"=psi_0 omega $]
Die Ableitung erfolgt bei festem Ort $x$. $s$ und $s_"max"$ haben die Einheit m/s. An einer maximalen Teilchenauslenkung ist die momentane Schnelle null; beim Durchgang durch die Ruhelage kann ihr Betrag maximal sein (*eigene Ableitung*).

*Wellenfronten* sind Punkte gleichen Schwingungszustands, also gleicher Phase. Gleiches Vorzeichen der Auslenkung allein genügt nicht: Auch die Bewegungsrichtung muss zum Zustand passen. Die roten Wellenberge in der Skriptskizze gehören zusammen, ebenso die orange markierten gleichgerichteten Nulldurchgänge.
#bild("map-welle", [Mindmap zu Ortsbild, Zeitbild und Bewegung. Eigene Darstellung.], height: 46mm)
#note("Selbst erklären", [Warum fliegt ein Luftteilchen nicht mit 343 m/s zum Zuhörer? *Antwort:* Diese Zahl bezeichnet hier die Wanderung des Schwingungsmusters. Das Teilchen bewegt sich lokal hin und her; seine Schnelle folgt aus der Zeitableitung der Auslenkung.])
#src[VB, PDF-S. 8–9; V1, PDF-S. 12–13; L, PDF-S. 7. Formel für Schnelle und Maximalwert: eigene Ableitung aus Gl. 6.2.]
#hoch(<a-6>, [Kapitelübersicht])


== 6.3 Das Medium bestimmt die Ausbreitungsgeschwindigkeit <a-6-3>
Die Nachbarteilchen müssen einander eine Bewegung weitergeben. Stärkere Rückstellkräfte erleichtern diese Weitergabe; größere Trägheit erschwert sie. Darum steht in den Formeln der Vorlesung meist ein Verhältnis aus Steifigkeit und Dichte unter einer Quadratwurzel.
#bild("saite-quelle", [Gespannte Saite und angeregter Stab. VB, PDF-S. 10, Abb. 6.3.], height: 31mm)

#tab(columns: (1.7fr, 1.5fr, 2fr),
 th([Modell aus der Vorlesung], [Geschwindigkeit], [Bedeutung und Voraussetzung]),
 [Gespannte Saite, transversal], [$c=sqrt(F/(rho A))$], [$F$ Zugkraft in N; $rho A$ Masse je Länge in kg/m],
 [Scher-/Torsionsmodell, Festkörper], [$c=sqrt(G/rho)$], [$G$ Schubmodul in Pa; $rho$ Dichte in kg/m³],
 [Longitudinalwelle im Stab], [$c=sqrt(E/rho)$], [$E$ Elastizitätsmodul in Pa; Modell aus Gl. 6.6],
 [Flüssigkeit, longitudinal], [$c=sqrt(K/rho)$], [$K$ Kompressionsmodul in Pa],
 [Ideales Gas, Schall], [$c=sqrt((kappa R T)/m_"mol")$], [$kappa$ Adiabatenexponent; $T$ in K; $m_"mol"$ in kg/mol],
)
$A$ bezeichnet den Saitenquerschnitt in m², $R$ die universelle Gaskonstante in J/(mol K). Das Skript nennt die molare Masse $m_"mol"$; sie ist keine einzelne Teilchenmasse.

#bild("longitudinal-quelle", [Verdichtung/Verdünnung und Longitudinalwelle im Stab. VB, PDF-S. 11, Abb. 6.4.], height: 32mm)

*Eigene Folgerungen:* Vierfache Saitenspannung macht $c$ doppelt so groß. Vierfache Dichte macht $c$ halb so groß, sofern die andere Modellgröße gleich bleibt. Für dasselbe ideale Gas gilt bei gleichem $kappa$:
#form[$ c_2/c_1=sqrt(T_2/T_1) $]
Das Skript nennt für Luft ungefähr 330 m/s bei 0 °C und 343 m/s bei 20 °C. Es sind Näherungswerte; in Rechnungen gilt der jeweils vorgegebene Aufgabenwert. Celsiuswerte dürfen in diesem Verhältnis nicht direkt eingesetzt werden. Die Umrechnung lautet $T/(1 thin "K")=vartheta/(1 thin "°C")+"273,15"$.

#note("Modelle bewusst lesen", [Die Skriptskizzen und die Aufgaben zu Blech und Kalimba verwenden ein einfaches Wellenmodell mit einem gemeinsamen $c$ für die betrachteten Moden. Wir rechnen diese Aufgaben genau unter dieser Annahme. Die Formeln sind damit kein ungeprüftes Universalgesetz für jeden beliebigen Stab oder jede Biegeschwingung.], fill: sand)
#bild("map-medium", [Mindmap: Rückstellwirkung und Trägheit. Eigene Darstellung.], height: 46mm)
#note("In deinen Unterlagen hervorgehoben", [VB, PDF-S. 10–12: Geschwindigkeiten nach Gl. 6.4–6.8. Der handschriftliche Beginn der folgenden Vorlesung steht vor Abschnitt 6.3.])
#src[VB, PDF-S. 10–12, Gl. 6.4–6.8; V, PDF-S. 216 zur Temperaturskala; AS 1.2 und Lösung 4.2, PDF-S. 11 und 46–47; AS 1.1, PDF-S. 10. Skalierungen und Temperaturverhältnis: eigene Ableitungen.]
#hoch(<a-6>, [Kapitelübersicht])


== 6.4 Energietransport · Intensität ist Leistung je Fläche <a-6-4>
Ein Teilchen erhält durch die Welle vorübergehend Bewegungsenergie $E_"kin"=1/2 m s^2$; über die Kopplung wird Energie weitergegeben. Dabei ist $m$ die Teilchenmasse und $s$ ihre momentane Schnelle. Die *Leistung* $P$ sagt, wie viel Energie pro Zeit eine Fläche durchquert. Die *Intensität* $I$ bezieht diese Leistung zusätzlich auf die Fläche.
#bild("energie-quelle", [Teilchenbewegung und Energiefluss durch eine Testfläche. VB, PDF-S. 13, Abb. 6.5.], height: 40mm)
#form[$ I=E_"trans"/(F t)=P/F, quad P=I F $]
$E_"trans"$ ist übertragene Energie in J, $t$ die Zeit in s, $F$ hier die Fläche senkrecht zur Ausbreitung in m². $P$ steht in W, $I$ in W/m². Die Vorlesung benutzt $F$ sowohl als Zugkraftsymbol in 6.3 als auch als Flächensymbol in 6.4; entscheide nach dem Zusammenhang und der Einheit.

Für die harmonische laufende mechanische Welle im Modell der Vorlesung gilt die zeitlich gemittelte Intensität:
#form[$ I=1/2 rho c omega^2 u^2=1/2 rho c omega^2 psi_0^2 $]
$u$ in Gl. 6.9 ist die *Maximalamplitude*, nicht die momentane Auslenkung und nicht die ganze Anfangsfunktion $u(x)$ aus 6.1. $rho$ steht in kg/m³, $c$ in m/s, $omega$ in rad/s und $u$ in m.

*Eigene Skalierung:* Doppelte Amplitude ergibt vierfache Intensität, halbe Amplitude ein Viertel. Bei konstantem $rho,c,u$ ergibt doppelte Frequenz ebenfalls vierfache Intensität. Eine größere Empfangsfläche erhöht bei gleichmäßiger Intensität die empfangene Leistung, nicht die Intensität selbst.
#bild("intensitaet-kurve", [Quadratischer Zusammenhang bei festem Medium und fester Frequenz. Eigene Darstellung nach Gl. 6.9.], height: 42mm)
#note("In deinen Unterlagen hervorgehoben", [VB, PDF-S. 13–14: $I prop u^2$ und $P=I F$. *Einheitenprüfung, eigene Ableitung:* $"kg/m³" · "m/s" · "s"^(-2) · "m²"="kg/s³"="W/m²"$.])
#bild("map-intensitaet", [Mindmap: Energie, Leistung, Fläche und Amplitude. Eigene Darstellung.], height: 46mm)
#src[VB, PDF-S. 13–14, Gl. 6.9–6.11. Mittelwertdeutung, Einheitenprüfung und Skalierungsbeispiele: eigene Erläuterung dieser Gleichungen.]
#hoch(<a-6>, [Kapitelübersicht])


== 6.5 Interferenz · Zuerst Auslenkungen addieren <a-6-5>
Treffen zwei Wellen im gleichen Medium zusammen, addieren sich im linearen Modell an jedem Ort ihre Auslenkungen. Die einzelnen Wellen laufen anschließend weiter. Diese *ungestörte Superposition* heißt bei Wellen auch *Interferenz*.
#form[$ psi_"gesamt"(x,t)=psi_1(x,t)+psi_2(x,t) $]
#bild("interferenz-quelle", [Überlagerung unterschiedlicher und gleicher Wellenlängen. VB, PDF-S. 15, Abb. 6.6.], height: 45mm)

Bei gleicher Frequenz und gleicher Wellenlänge entsteht am betrachteten Ort wieder eine harmonische Bewegung. Die Phasendifferenz entscheidet über die resultierende Amplitude. Für zwei gleich große Amplituden $A$ folgt aus dem Additionstheorem (*eigene Ableitung*):
#form[$ A_"res"=2 A abs(cos(Delta phi/2)) $]

#tab(columns: (1.5fr, 1.7fr, 1.6fr),
 th([Fall], [Phasendifferenz], [Folge bei gleichen Amplituden]),
 [Konstruktiv], [$Delta phi=2 pi j$], [Berg trifft Berg: $A_"res"=2A$],
 [Destruktiv], [$Delta phi=(2j+1)pi$], [Berg trifft Tal: $A_"res"=0$],
 [Zwischenfall], [Andere feste Phase], [Amplitude zwischen 0 und $2A$],
)
$j$ ist eine ganze Zahl. Bei ungleichen Amplituden bleibt auch im destruktiven Fall eine Restamplitude; vollständige Auslöschung braucht gleiche Beträge.

*Ergänzte Anwendung auf Ü 10.5:* Ein Wegunterschied $Delta l$ verändert die Phase um $2 pi Delta l/lambda$. Für zwei gleichphasige Quellen bedeuten ganze Wellenlängen konstruktive, ungerade halbe Wellenlängen destruktive Überlagerung. Eine zusätzliche Anfangsphase muss mitgerechnet werden.
#form[$ Delta phi=(2 pi)/lambda Delta l+Delta phi_0 $]

#note("Fehler vermeiden", [Addiere die *Auslenkungen*, erst danach leitest du die Intensität ab. Aus $A+A=2A$ folgt lokal bei gleicher Phase $I_"res"=4I_"einzeln"$, nicht $2I_"einzeln"$. Das folgt aus der quadratischen Abhängigkeit aus 6.4; eine einzelne lokale Verstärkung ist keine Erzeugung zusätzlicher Energie.], fill: sand)
#bild("map-interferenz", [Mindmap zur Überlagerung. Eigene Darstellung.], height: 46mm)
#src[VB, PDF-S. 15–16; Gl. 6.9–6.10; V1, PDF-S. 1 zum Additionstheorem; Ü 10.5 und R, PDF-S. 3; K15, PDF-S. 4, Frage 12. Amplituden- und Phasenformeln: eigene Ableitungen.]
#hoch(<a-6>, [Kapitelübersicht])


== 6.6 Stehende Wellen · Ein Ortsmuster bleibt stehen <a-6-6>
Zwei gleich große Wellen mit gleicher Frequenz laufen in entgegengesetzte Richtungen. Ihre Summe besitzt einen festen Verlauf der maximalen Auslenkung. Die Teilchen bewegen sich weiter; nur das Muster der möglichen Amplituden bleibt am Ort.
#form[$ A sin(k x-omega t)+A sin(k x+omega t)=2 A sin(k x)cos(omega t) $]
Der Faktor $2A sin(k x)$ hängt nur vom Ort ab, $cos(omega t)$ nur von der Zeit. Ein *Knoten* hat immer Auslenkung null. Ein *Bauch* ist eine Stelle maximaler Schwingungsamplitude.
#bild("stehend-quelle", [Stehende Welle mit Knoten und Bäuchen. VB, PDF-S. 18, Abb. 6.8.], height: 48mm)

Aus $sin(k x)=0$ folgen Knoten bei $x=j lambda/2$. Bäuche liegen dazwischen. Daher beträgt der Abstand zweier benachbarter Knoten $lambda/2$, zweier benachbarter Bäuche ebenfalls $lambda/2$ und zwischen benachbartem Knoten und Bauch $lambda/4$ (*eigene Ableitung*).

#note("Quellenfehler sichtbar korrigiert", [VB, PDF-S. 17 behauptet im Fließtext für benachbarte Knoten beziehungsweise Bäuche den Abstand $lambda$. Die dortige Gleichung 6.12 und Abb. 6.8 ergeben $lambda/2$. Hier wird die aus der Gleichung überprüfte Form verwendet.], fill: sand)

Eine ideale stehende Welle aus zwei gleich starken gegenläufigen Wellen hat keinen zeitlich gemittelten Nettoenergietransport entlang der Ausbreitungsrichtung. Die gegenläufigen *Energieflüsse* gleichen sich aus; die vorhandenen Energien werden nicht „wegsubtrahiert“. Das präzisiert die Formulierung auf VB, PDF-S. 19.
#src[VB, PDF-S. 17–19, Gl. 6.12; Abstände und Präzisierung: eigene Ableitung aus der Überlagerung.]

=== 6.6.1 Reflexion am festen und am losen Ende <a-6-6-1>
Eine Welle kann an einem Ende oder einem Übergang des Mediums reflektiert werden. Die zurücklaufende Welle überlagert sich mit der hinlaufenden. Wie das Ende sich bewegen darf, entscheidet über die Randbedingung.
#bild("reflexion-quelle", [Reflexion eines Seilpulses: festes und loses Ende. VB, PDF-S. 18, Abb. 6.9.], height: 40mm)
#tab(columns: (1.2fr, 1.5fr, 1.8fr),
 th([Ende], [Auslenkung am Ende], [Reflektierter Puls]),
 [Fest], [Knoten: Bewegung gesperrt], [Inversion: Ein Berg kommt als Tal zurück],
 [Lose/frei], [Bauch im behandelten Idealmodell], [Ohne Inversion: Ein Berg bleibt ein Berg],
)
#note("Selbst erklären", [Warum braucht das feste Ende einen Knoten? *Antwort:* Die Gesamtbewegung muss am festgehaltenen Punkt immer null sein. Die Überlagerung aus hin- und rücklaufender Welle muss diese Bedingung zu jeder Zeit erfüllen.])
#src[VB, PDF-S. 17–18; eigene Erklärung der Randbedingung.]
#hoch(<a-6>, [Kapitelübersicht])


== 6.7 Eindimensionale Eigenmoden · Die Enden wählen die Wellenlängen <a-6-7>
Auf einer begrenzten Länge $L$ passt nicht jede beliebige stehende Welle. Die Enden schreiben Knoten oder Bäuche vor. Eine *Eigenmode* ist eine dazu passende räumliche Schwingungsform; ihre Eigenfrequenz ergibt sich anschließend aus $f_n=c/lambda_n$.

=== 6.7.1 Zwei feste Enden <a-6-7-1>
Beide Enden müssen Knoten sein. Dazwischen passen eine, zwei, drei oder mehr halbe Wellenlängen.
#form[$ L=n lambda_n/2, quad lambda_n=(2L)/n, quad f_n=(n c)/(2L), quad n=1,2,3,dots $]
#bild("mode-fest-quelle", [Moden bei zwei festen Enden. VB, PDF-S. 20.], height: 36mm)
$n=1$ ist die Grundmode. Bei $n=2,3,dots$ entstehen höhere Moden; die ersten Obertöne haben im Modell die Frequenzen $2f_1,3f_1,dots$. Bei der Saite verändert Stimmen die Zugkraft, dadurch $c$ und damit alle Frequenzen.
#src[VB, PDF-S. 20, Gl. 6.13–6.14; Ü 10.4; eigene Erläuterung der Modennummer.]

=== 6.7.2 Ein festes und ein loses Ende <a-6-7-2>
Zwischen einem Knoten und einem Bauch passt in der Grundmode eine Viertelwellenlänge. Jede weitere passende Form fügt eine halbe Wellenlänge hinzu. Es passen also nur *ungerade* Vielfache von $lambda/4$.
#form[$ L=n lambda_n/4, quad lambda_n=(4L)/n, quad f_n=(n c)/(4L), quad n=1,3,5,7,dots $]
#bild("mode-gemischt-quelle", [Moden bei einem festen und einem losen Ende. VB, PDF-S. 21.], height: 35mm)
*Zählweise:* Die zweite tatsächlich vorhandene Mode hat hier die Wellenzahl-Ordnung $n=3$, die dritte $n=5$. „Zweite Mode“ bedeutet deshalb nicht, dass in die Formel $n=2$ eingesetzt wird.

Das Skript nennt einseitig befestigte Zungen und eine Luftsäule mit geschlossenem und offenem Ende. Bei der Luftsäule beziehen sich Knoten und Bauch hier auf die *Teilchenauslenkung*. Das Aufgabenmodell von Blech und Kalimba wird mit demselben gemeinsamen $c$ gerechnet.
#src[VB, PDF-S. 21, Gl. 6.15–6.16; Ü 10.3; AS 1.1–1.2 und Lösungen, PDF-S. 43–47; eigene Erläuterung der Nummerierung.]

=== 6.7.3 Zwei lose Enden <a-6-7-3>
An beiden Enden liegt im behandelten Modell ein Bauch. Die schwingenden Moden besitzen dieselben erlaubten Wellenlängen und Frequenzen wie bei zwei festen Enden, aber ein anderes Ortsbild. Als Anschauung nennt das Skript einen „Swing Stick“, der an einem inneren Schwingungsknoten gehalten wird.
#form[$ lambda_n=(2L)/n, quad f_n=(n c)/(2L), quad n=1,2,3,dots $]
#bild("mode-frei-quelle", [Zwei lose Enden: Bäuche an den Grenzen. VB, PDF-S. 22, oberer Teil.], height: 32mm)

#note("Quellenfehler sichtbar korrigiert", [VB, PDF-S. 22 sagt im Fließtext „mit geradem n“, listet in Gl. 6.17–6.18 aber $n=1,2,3,dots$ auf. Aus Bauch–Bauch und der halben Wellenlänge zwischen benachbarten Bäuchen folgen alle positiven ganzen $n$. Hier gelten die Gleichungen, nicht die widersprechende Einschränkung im Satz.], fill: sand)

#tab(columns: (1.6fr, 1.4fr, 1.3fr),
 th([Enden], [Grundwellenlänge], [Frequenzfolge im Modell]),
 [Fest–fest], [$2L$], [$f_1,2f_1,3f_1,dots$],
 [Fest–lose], [$4L$], [$f_1,3f_1,5f_1,dots$],
 [Lose–lose], [$2L$], [$f_1,2f_1,3f_1,dots$],
)
#bild("moden-skizze", [Die ersten drei Moden für jede Randbedingung. Eigene Darstellung nach Gl. 6.13–6.18; normierte Auslenkung, nicht maßstäblich.], height: 70mm)
#bild("map-moden", [Mindmap: Randbedingungen → Wellenlänge → Frequenz. Eigene Darstellung.], height: 46mm)

#note("Deine Vorlesungsgrenze", [Die handschriftliche Linie „Ende VL 19.10.“ liegt auf VB, PDF-S. 22 direkt vor „Stehende Wellen in zwei Dimensionen“. Du hast diese Grenze bestätigt. Hier endet deshalb der behandelte Stoff.])
#src[VB, PDF-S. 20–22 bis zur Grenze, Gl. 6.13–6.18; eigene Herleitung der zulässigen Ordnungen.]

*Der Zusammenhang in Kapitel 6.* Die Wellenfunktion trennt Ort und Zeit. Die Geschwindigkeit stammt aus dem Medium, die Frequenz aus der Anregung; daraus folgt die Wellenlänge. Die Amplitude bestimmt den Energiefluss quadratisch. Überlagerung erzeugt Verstärkung oder Auslöschung; Reflexion macht daraus stehende Wellen. Erst die Randbedingungen wählen ihre zulässigen Moden aus.
#src[VB, PDF-S. 5–22; eigene Zusammenfassung.]
#hoch(<a-6>, [Kapitelübersicht])


= Anhang
== Formelsammlung mit Voraussetzungen
#tab(columns: (1.1fr, 2fr, 1.9fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Federpendel], [$omega_0=sqrt(D/m)$; $T=2pi sqrt(m/D)$], [Linear, ungedämpft; gesamte schwingende Masse],
 [Frequenz], [$omega=2pi f$; $T=1/f$], [$f$ in Hz, $omega$ in rad/s, $T$ in s],
 [Additionstheorem], [$sin a+sin b=2sin((a+b)/2)cos((a-b)/2)$], [Phasen dimensionslos],
 [Schwebung], [$f_m=(f_1+f_2)/2$; $omega_d=abs(omega_1-omega_2)/2$], [Zwei nahe Frequenzen; Hüllkurvenmodell],
 [Anschwellrhythmus], [$f_s=abs(f_1-f_2)$; $T_s=1/f_s$], [$f_s$ ist nicht $omega_d/(2pi)$],
 [Gekoppelte Pendel], [$m dot.double(x)_1=-D x_1-D_k(x_1-x_2)$], [Zweite Gleichung durch Tausch 1 ↔ 2],
 [Eigenmoden], [$psi_1=x_1+x_2$; $psi_2=x_1-x_2$], [Identische Massen und äußere Federn],
 [Modenfrequenzen], [$omega_"gl"=sqrt(D/m)$; $omega_"gg"=sqrt((D+2D_k)/m)$], [Linear und ungedämpft],
 [Austauschzyklus], [$T_s=2pi/(omega_"gg"-omega_"gl")$], [Vollständiger Hüllenzyklus; $D_k>0$],
 [Puls], [$psi(x,t)=u(x plus.minus c t)$], [Unveränderte Form; − nach +x, + nach −x],
 [Harmonische Welle], [$psi=psi_0 sin(k x-omega t-phi_0)$], [Laufende Sinuswelle],
 [Wellenzahl], [$k=2pi/lambda$], [$k$ in m⁻¹, $lambda$ in m],
 [Ausbreitung], [$c=lambda f=omega/k$], [Phasengeschwindigkeit der betrachteten Welle],
 [Schnelle], [$s=partial psi/partial t$; $s_"max"=psi_0 omega$], [Ableitung bei festem Ort; harmonischer Maximalwert],
)
#pagebreak()
#tab(columns: (1.1fr, 2fr, 1.9fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Saite], [$c=sqrt(F/(rho A))$], [Zugkraft F in N; $rho A$ in kg/m],
 [Festkörper], [$c_T=sqrt(G/rho)$; $c_L=sqrt(E/rho)$], [Behandelte Scher-/Torsions- und Stabmodelle],
 [Flüssigkeit], [$c=sqrt(K/rho)$], [Longitudinal; K in Pa],
 [Ideales Gas], [$c=sqrt(kappa R T/m_"mol")$], [$T$ in K, $m_"mol"$ in kg/mol],
 [Temperaturvergleich], [$c_2/c_1=sqrt(T_2/T_1)$], [Gleiches Gas, konstantes $kappa$],
 [Intensität], [$I=1/2 rho c omega^2 u^2$], [Harmonische laufende Welle; zeitlicher Mittelwert],
 [Leistung], [$P=I F$], [F hier Fläche in m²; gleichmäßiges I senkrecht dazu],
 [Relative Phase], [$Delta phi=2pi Delta l/lambda+Delta phi_0$], [Gleiche Frequenz; konsistente Wegorientierung],
 [Interferenz], [$A_"res"=2A abs(cos(Delta phi/2))$], [Gleiche Teilamplituden am betrachteten Ort],
 [Stehende Welle], [$psi=2A sin(k x)cos(omega t)$], [Gleiche gegenläufige Teilwellen],
 [Abstände], [Knoten–Knoten: $lambda/2$; Knoten–Bauch: $lambda/4$], [Stehende harmonische Welle],
 [Fest–fest / lose–lose], [$lambda_n=2L/n$; $f_n=n c/(2L)$], [$n=1,2,3,dots$; gemeinsames c im Aufgabenmodell],
 [Fest–lose], [$lambda_n=4L/n$; $f_n=n c/(4L)$], [$n=1,3,5,dots$; Auslenkungsknoten und -bauch],
)
#note("Wichtige Zahlen", [$1 thin "Hz"=1 thin "s"^(-1)$; $1 thin "kHz"=10^3 thin "Hz"$; $1 thin "MHz"=10^6 thin "Hz"$. $1 thin "mm"=10^(-3) thin "m"$; $1 thin "µm"=10^(-6) thin "m"$. $T/(1 thin "K")=vartheta/(1 thin "°C")+"273,15"$. In den Aufgaben vorgegebene Schallgeschwindigkeiten werden jeweils übernommen: Luft 340 oder 343 m/s, Wasser 1480 oder 1500 m/s. Für die Kranaufgabe gilt $g="9,81" thin "m/s²"$.])
#src[V, PDF-S. 146–150; V1, PDF-S. 1–13; VB, PDF-S. 10–22 bis zur Grenze; Ü 10.1–10.5; AS 1.3–1.4. Umformungen und Einheitenumrechnungen: eigene Zusammenstellung.]
