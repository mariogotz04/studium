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
  #text(size: 8pt, fill: muted)[Feynman-Lernskript · Stand 12.11.2026]
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
  "membran-knoten-quelle": "abbildungen/membran-knoten-quelle.svg",
  "huygens-quelle": "abbildungen/huygens-quelle.svg",
  "doppelspalt-quelle": "abbildungen/doppelspalt-quelle.svg",
  "beugung-quelle": "abbildungen/beugung-quelle.svg",
  "reflexion-3d-quelle": "abbildungen/reflexion-3d-quelle.svg",
  "brechung-quelle": "abbildungen/brechung-quelle.svg",
  "doppler-quelle": "abbildungen/doppler-quelle.svg",
  "map-raumwellen": "abbildungen/map-raumwellen.svg",
  "map-huygens": "abbildungen/map-huygens.svg",
  "map-doppler": "abbildungen/map-doppler.svg",
  "alt-harmwelle": "abbildungen/alt-harmwelle.svg",
  "alt-puls": "abbildungen/alt-puls.svg",
  "cover": "abbildungen/cover.svg",
  "energie-quelle": "abbildungen/energie-quelle.svg",
  "harmonisch-quelle": "abbildungen/harmonisch-quelle.svg",
  "intensitaet-kurve": "abbildungen/intensitaet-kurve.svg",
  "interferenz-quelle": "abbildungen/interferenz-quelle.svg",
  "longitudinal-quelle": "abbildungen/longitudinal-quelle.svg",
  "map-intensitaet": "abbildungen/map-intensitaet.svg",
  "map-interferenz": "abbildungen/map-interferenz.svg",
  "map-medium": "abbildungen/map-medium.svg",
  "map-moden": "abbildungen/map-moden.svg",
  "map-welle": "abbildungen/map-welle.svg",
  "mode-fest-quelle": "abbildungen/mode-fest-quelle.svg",
  "mode-frei-quelle": "abbildungen/mode-frei-quelle.svg",
  "mode-gemischt-quelle": "abbildungen/mode-gemischt-quelle.svg",
  "moden-skizze": "abbildungen/moden-skizze.svg",
  "puls-quelle": "abbildungen/puls-quelle.svg",
  "reflexion-quelle": "abbildungen/reflexion-quelle.svg",
  "saite-quelle": "abbildungen/saite-quelle.svg",
  "schnelle-quelle": "abbildungen/schnelle-quelle.svg",
  "stehend-quelle": "abbildungen/stehend-quelle.svg",
  "wellenarten-quelle": "abbildungen/wellenarten-quelle.svg",
  "doppler-empfaenger-quelle": "abbildungen/doppler-empfaenger-quelle.svg",
  "mach-quelle": "abbildungen/mach-quelle.svg",
  "bimetall-quelle": "abbildungen/bimetall-quelle.svg",
  "thermoelement-quelle": "abbildungen/thermoelement-quelle.svg",
  "boyle-quelle": "abbildungen/boyle-quelle.svg",
  "gaylussac-quelle": "abbildungen/gaylussac-quelle.svg",
  "gaswuerfel-quelle": "abbildungen/gaswuerfel-quelle.svg",
  "freiheitsgrade-quelle": "abbildungen/freiheitsgrade-quelle.svg",
  "kolben-quelle": "abbildungen/kolben-quelle.svg",
  "perpetuum-quelle": "abbildungen/perpetuum-quelle.svg",
  "mischung-quelle": "abbildungen/mischung-quelle.svg",
  "isobar-erwaermen-quelle": "abbildungen/isobar-erwaermen-quelle.svg",
  "phasen-quelle": "abbildungen/phasen-quelle.svg",
  "isotherme-quelle": "abbildungen/isotherme-quelle.svg",
  "isobare-quelle": "abbildungen/isobare-quelle.svg",
  "isochore-quelle": "abbildungen/isochore-quelle.svg",
  "adiabate-quelle": "abbildungen/adiabate-quelle.svg",
  "kreisprozess-quelle": "abbildungen/kreisprozess-quelle.svg",
  "carnot-quelle": "abbildungen/carnot-quelle.svg",
  "carnot-schritte-quelle": "abbildungen/carnot-schritte-quelle.svg",
  "blockdiagramm-quelle": "abbildungen/blockdiagramm-quelle.svg",
  "stirling-quelle": "abbildungen/stirling-quelle.svg",
  "waermeleitung-quelle": "abbildungen/waermeleitung-quelle.svg",
  "netzwerk-quelle": "abbildungen/netzwerk-quelle.svg",
  "konvektion-quelle": "abbildungen/konvektion-quelle.svg",
  "planck-quelle": "abbildungen/planck-quelle.svg",
  "treibhaus-quelle": "abbildungen/treibhaus-quelle.svg",
  "optik-gebiete-quelle": "abbildungen/optik-gebiete-quelle.svg",
  "spektrum-quelle": "abbildungen/spektrum-quelle.svg",
  "fermat-quelle": "abbildungen/fermat-quelle.svg",
  "reflexion-licht-quelle": "abbildungen/reflexion-licht-quelle.svg",
  "hohlspiegel-quelle": "abbildungen/hohlspiegel-quelle.svg",
  "brechung-licht-quelle": "abbildungen/brechung-licht-quelle.svg",
  "totalreflexion-quelle": "abbildungen/totalreflexion-quelle.svg",
  "dispersion-quelle": "abbildungen/dispersion-quelle.svg",
  "linsenschleifer-quelle": "abbildungen/linsenschleifer-quelle.svg",
  "sammellinse-quelle": "abbildungen/sammellinse-quelle.svg",
  "zerstreuungslinse-quelle": "abbildungen/zerstreuungslinse-quelle.svg",
  "sammel-konstruktion-quelle": "abbildungen/sammel-konstruktion-quelle.svg",
  "lupe-virtuell-quelle": "abbildungen/lupe-virtuell-quelle.svg",
  "zerstreu-konstruktion-quelle": "abbildungen/zerstreu-konstruktion-quelle.svg",
  "linsensystem-quelle": "abbildungen/linsensystem-quelle.svg",
  "auge-quelle": "abbildungen/auge-quelle.svg",
  "kurzsichtig-quelle": "abbildungen/kurzsichtig-quelle.svg",
  "weitsichtig-quelle": "abbildungen/weitsichtig-quelle.svg",
  "lupe-quelle": "abbildungen/lupe-quelle.svg",
  "mikroskop-quelle": "abbildungen/mikroskop-quelle.svg",
  "kepler-quelle": "abbildungen/kepler-quelle.svg",
  "galilei-quelle": "abbildungen/galilei-quelle.svg",
  "licht-em-quelle": "abbildungen/licht-em-quelle.svg",
  "kohaerenz-quelle": "abbildungen/kohaerenz-quelle.svg",
  "michelson-quelle": "abbildungen/michelson-quelle.svg",
  "young-quelle": "abbildungen/young-quelle.svg",
  "gitter-quelle": "abbildungen/gitter-quelle.svg",
  "einzelspalt-quelle": "abbildungen/einzelspalt-quelle.svg",
  "spaltbreite-quelle": "abbildungen/spaltbreite-quelle.svg",
  "doppelspalt-huelle-quelle": "abbildungen/doppelspalt-huelle-quelle.svg",
  "map-gasgesetz": "abbildungen/map-gasgesetz.svg",
  "map-hauptsatz": "abbildungen/map-hauptsatz.svg",
  "map-kreisprozess": "abbildungen/map-kreisprozess.svg",
  "map-waermetransport": "abbildungen/map-waermetransport.svg",
  "map-brechung": "abbildungen/map-brechung.svg",
  "map-abbildung": "abbildungen/map-abbildung.svg",
  "map-instrumente": "abbildungen/map-instrumente.svg",
  "map-kohaerenz": "abbildungen/map-kohaerenz.svg",
)

#let bilddeutungen = (
  "membran-knoten-quelle": (titel: "Bild lesen", body: [Die Draufsichten zeigen die ruhenden Knotenlinien verschiedener Moden auf einer Rechteck- und einer Kreismembran. Die Farben unterscheiden Moden, keine Auslenkungswerte. Zwischen diesen Linien schwingen Flächenbereiche; Sand sammelt sich bevorzugt auf den ruhenden Linien.]),
  "huygens-quelle": (titel: "Bild lesen", body: [Blau ist die alte Front, rot sind Elementarwellen mit gleichem Ausbreitungszeitraum. Grün ist ihre gemeinsame vordere Einhüllende, also die neue Wellenfront. Die Skizze ist ein Schnitt; im Raum sind die Elementarwellen kugelförmig.]),
  "doppelspalt-quelle": (titel: "Bild lesen", body: [Von links trifft eine Welle auf zwei Öffnungen mit Abstand d. Rechts entstehen überlagerte Kreisfronten als Schnitt durch Kugelwellen. Die gestrichelten Richtungen markieren Maxima beziehungsweise Minima; der Winkel wird von der Mittelsenkrechten der Quellenverbindung aus gemessen.]),
  "beugung-quelle": (titel: "Bild lesen", body: [Die blauen Hindernisse begrenzen den geometrischen Schatten. Von den roten Punkten gehen Elementarwellen aus. Auch im markierten Schatten sind Wellenstrukturen sichtbar: Die Ausbreitung ist nicht auf gerade Strahlen beschränkt.]),
  "reflexion-3d-quelle": (titel: "Bild lesen", body: [a bis c zeigen nacheinander einfallende Fronten und die an der Grenzfläche erzeugten Elementarwellen. Deren Einhüllende bildet die reflektierte Front. In d stehen beide Winkel zwischen Ausbreitungsrichtung und Lot, nicht zwischen Front und Oberfläche.]),
  "brechung-quelle": (titel: "Bild lesen", body: [Oben gilt c₁, unten das kleinere c₂. Im gleichen Zeitraum wachsen die unteren Elementarwellen weniger weit. Deshalb dreht sich die Front und ihre Normale wird zum Lot hin gebrochen; zugleich wird der Frontabstand kleiner.]),
  "doppler-quelle": (titel: "Bild lesen", body: [Die roten Punkte markieren frühere und aktuelle Senderorte; der Sender bewegt sich nach rechts. Jede ausgesandte Front breitet sich vom jeweiligen Emissionsort aus. Rechts liegen die Fronten enger, links weiter auseinander. Ruhende Empfänger hören deshalb vorne einen höheren und hinten einen tieferen Ton.]),
  "map-raumwellen": (titel: "Die Mindmap lesen", body: [Die drei Geometrien unterscheiden sich durch die Fläche, auf die sich dieselbe Leistung verteilt. Der vierte Ast nennt die Voraussetzung: keine Absorption. Eine sinkende Intensität beweist daher noch keinen Energieverlust.]),
  "map-huygens": (titel: "Die Mindmap lesen", body: [Von der alten Front führen Startpunkte über Elementarwellen zur neuen Front. Die Einhüllende erklärt die Geometrie; die Superposition der Auslenkungen erklärt Verstärkung und Auslöschung.]),
  "map-doppler": (titel: "Die Mindmap lesen", body: [Der Sender behält seinen eigenen Takt, verändert aber beim Weiterfahren die räumlichen Abstände der Fronten. Der ruhende Empfänger zählt diese Fronten pro Sekunde. So entsteht die Frequenzänderung, ohne dass sich c im Medium ändert.]),
  "alt-harmwelle": (titel: "Bild lesen", body: [Die blaue Kurve ist eine Momentaufnahme über dem Ort, gestrichelt die kurz darauf. Grün ist der Abstand zweier Berge λ, rot die Richtung von c. Orange zeigt die lokale Schnelle eines Teilchens; sie gehört nicht zur waagerechten Musterbewegung.]),
  "alt-puls": (titel: "Bild lesen", body: [Die durchgezogene Form ist die Anfangsform; die gestrichelte liegt später weiter rechts. Form und Höhe bleiben in dieser idealisierten Darstellung gleich. Der rote Pfeil zeigt die Verschiebung c · t.]),
  "cover": (titel: "Bild lesen", body: [Links ändern sich Verdichtung und Verdünnung entlang der Ausbreitung; rechts liegt die Auslenkung quer dazu. Die schwarzen Pfeile zeigen die Wanderung des Musters, die roten die lokale Schwingungsrichtung. Beide Bilder sind schematisch und nicht maßstäblich.]),
  "energie-quelle": (titel: "Bild lesen", body: [Die grüne Fläche liegt quer zur Ausbreitungsrichtung. Der rote markierte Bereich trägt durch seine lokale Schnelle Bewegungsenergie. Das Muster läuft nach rechts durch die Fläche; die Intensität zählt die pro Zeit und Fläche übertragene Energie.]),
  "harmonisch-quelle": (titel: "Bild lesen", body: [Die waagerechte Achse ist der Ort. Blau und orange stellen zwei Zeiten dar. Die Kurve ist nach rechts gewandert; der Abstand gleichphasiger benachbarter Punkte heißt Wellenlänge. Die vertikale Auslenkung ist nicht die zurückgelegte Ausbreitungsstrecke.]),
  "intensitaet-kurve": (titel: "Bild lesen", body: [Waagerecht steht die Amplitude relativ zu einem Ausgangswert u₀, senkrecht die Intensität relativ zu I₀. Die Kurve ist eine Parabel: Bei 2u₀ liest du 4I₀ ab, bei 3u₀ den Wert 9I₀. Medium und Frequenz sind festgehalten.]),
  "interferenz-quelle": (titel: "Bild lesen", body: [Rot und blau sind die einzelnen Auslenkungen über dem Ort, schwarz ist ihre punktweise Summe. Links unterscheiden sich die Wellenlängen, rechts stimmen sie überein. Die schwarze Kurve entsteht durch Addition der Höhenwerte, nicht durch Addition von Wellenlängen.]),
  "longitudinal-quelle": (titel: "Bild lesen", body: [Dicht benachbarte Windungen stehen für Verdichtung, größere Abstände für Verdünnung. Die Teilchenverschiebung und die Ausbreitungsrichtung liegen längs desselben Mediums. Rechts erzeugt ein Schlag eine longitudinale Störung im Stab.]),
  "map-intensitaet": (titel: "Bild lesen", body: [Oben trennt die Mindmap Leistung und Leistung pro Fläche. Unten folgen die quadratische Amplitudenwirkung und die Umrechnung von Intensität in empfangene Leistung.]),
  "map-interferenz": (titel: "Bild lesen", body: [Die linken Äste zeigen gleich- und gegenphasige Überlagerung. Rechts steht die Rechenregel: Auslenkungen zuerst addieren. Gegenläufige gleichartige Wellen führen dann zum stehenden Muster.]),
  "map-medium": (titel: "Bild lesen", body: [Die Äste ordnen die Geschwindigkeitsformeln nach Rückstellwirkung und Trägheit. Die Quadratwurzel macht deutlich: Eine Verdopplung der Ursache verdoppelt nicht automatisch die Geschwindigkeit.]),
  "map-moden": (titel: "Bild lesen", body: [Die oberen Äste legen die Endbedingungen fest: Knoten oder Bauch. Unten folgt, wie viele Halb- oder Viertelwellen hineinpassen. Daraus wird erst die Wellenlänge und dann die Eigenfrequenz berechnet.]),
  "map-welle": (titel: "Bild lesen", body: [Das Zentrum verbindet lokale Teilchenbewegung und wanderndes Muster. Links stehen die räumliche und zeitliche Beschreibung, rechts die Aufgaben von Medium und Quelle. Daraus entsteht c = λf.]),
  "mode-fest-quelle": (titel: "Bild lesen", body: [Alle farbigen Formen besitzen an beiden Grenzen Auslenkung null. Mit zunehmender Ordnung passen mehr halbe Wellenlängen auf dieselbe Länge L. Die Farben unterscheiden mögliche Moden, keine verschiedenen Materialien.]),
  "mode-frei-quelle": (titel: "Bild lesen", body: [Beide Ränder liegen an Schwingungsbäuchen. Die verschiedenfarbigen Moden haben unterschiedliche Zahlen innerer Knoten. Die Randwerte sind Auslenkungsmaxima, während die Wellenlänge wie beim Fall fest–fest 2L/n beträgt.]),
  "mode-gemischt-quelle": (titel: "Bild lesen", body: [Links bleibt der Punkt fest, rechts kann er schwingen. Eine Viertelwelle ist die Grundform; die nächsten Formen enthalten drei beziehungsweise fünf Viertelwellen. An keiner zulässigen Form darf rechts ein Knoten erzwungen werden.]),
  "moden-skizze": (titel: "Bild lesen", body: [Jede Spalte hat eine eigene Randbedingung, jede Zeile die nächste zulässige Mode. Durchgezogen und gestrichelt zeigen entgegengesetzte Auslenkungsphasen derselben Form. Gefüllte Endpunkte markieren feste Enden. Die waagerechte Strecke reicht jeweils von x/L = 0 bis 1; die Höhe ist normiert.]),
  "puls-quelle": (titel: "Bild lesen", body: [Beide Achsenbilder zeigen Auslenkung über Ort. Links liegt die Anfangsform bei x₁, rechts dieselbe Form später bei x₂. Der Abstand x₂ − x₁ wächst bei konstanter Ausbreitung mit c · t.]),
  "reflexion-quelle": (titel: "Bild lesen", body: [Jeweils oben läuft der ursprüngliche Puls auf das Ende zu, darunter läuft der reflektierte zurück. Links ist das Ende fest: Berg wird Tal. Rechts ist es lose: Der reflektierte Puls bleibt gleich orientiert.]),
  "saite-quelle": (titel: "Bild lesen", body: [Links zieht eine Kraft F die Saite straff. Rechts regt ein Schlag die Bewegung des Stabes an. Die Verbindung zum Nachbarn überträgt die Störung; welche Rückstellwirkung vorliegt, entscheidet über die passende Geschwindigkeitsformel.]),
  "schnelle-quelle": (titel: "Bild lesen", body: [Der waagerechte rote Pfeil bezeichnet die Bewegung des Musters. Der senkrechte grüne Pfeil bezeichnet die Geschwindigkeit eines lokalen Teilchens. Ihre Richtungen müssen bei einer Transversalwelle verschieden sein.]),
  "stehend-quelle": (titel: "Bild lesen", body: [Waagerecht steht der Ort. Die blaue Hülle legt die maximale Auslenkung fest; die roten Pfeile zeigen die zeitliche Bewegung. An Knoten bleibt die Auslenkung null, an Bäuchen erreicht die lokale Amplitude ihren größten Betrag. Benachbarte Knoten liegen eine halbe Wellenlänge auseinander.]),
  "wellenarten-quelle": (titel: "Bild lesen", body: [Die grüne Markierung zeigt die Ausbreitungsrichtung. Links schwingen die Pendel entlang dieser Richtung; rechts quer dazu. Die Ausbreitung wird mit der Schwingungsrichtung verglichen, nicht mit dem Verlauf der gezeichneten Verbindungslinie.]),
  "doppler-empfaenger-quelle": (titel: "Bild lesen", body: [Der rote Sender ruht, die Kreise sind gleich weit auseinander. Ihr Abstand, hier mit s beschriftet, ist die unveränderte Wellenlänge. Der blaue Empfänger fährt nach links in die Fronten hinein und trifft sie deshalb häufiger als ein ruhender Beobachter.]),
  "mach-quelle": (titel: "Bild lesen", body: [In a fährt der Sender genau mit c: Alle Fronten berühren sich vorne in einem Punkt. In b ist er schneller; die zu verschiedenen Zeiten ausgesandten Kreise haben eine gemeinsame grüne Tangente, den Kegelmantel. Die Strecken c·t und v_S·t bilden das Dreieck für den halben Öffnungswinkel.]),
  "bimetall-quelle": (titel: "Bild lesen", body: [Zwei verschweißte Streifen aus verschiedenen Metallen sind links gerade. Beim Erwärmen dehnt sich ein Streifen stärker; der Doppelstreifen biegt sich und öffnet den Kontakt zur Spannungsquelle U.]),
  "thermoelement-quelle": (titel: "Bild lesen", body: [Zwei verschiedenfarbige Drähte sind an der Messstelle mit T₁ verbunden. Ihre freien Enden liegen in der Vergleichsstelle mit T₂ und führen zum Voltmeter. Die angezeigte Spannung hängt von der Differenz T₁ − T₂ ab.]),
  "boyle-quelle": (titel: "Bild lesen", body: [Gleiche Temperatur links und rechts. Die zweite Masse auf dem Kolben verdoppelt den Druck, und das Gasvolumen wird kleiner. Die Gewichte symbolisieren nur den Druck.]),
  "gaylussac-quelle": (titel: "Bild lesen", body: [Die Masse auf dem Kolben bleibt gleich, also auch der Druck. Das Gas wird von T₁ auf T₂ erwärmt (orange) und schiebt den Kolben nach oben: Das Volumen wächst mit der Temperatur.]),
  "gaswuerfel-quelle": (titel: "Bild lesen", body: [Der Würfel hat die Kantenlänge L. Die grünen Pfeile sind Teilchen, die sich im vereinfachten Modell nur entlang der Kantenrichtungen bewegen. Jeder Stoß an eine Wand überträgt Impuls; daraus entsteht der Druck.]),
  "freiheitsgrade-quelle": (titel: "Bild lesen", body: [a zeigt die drei Richtungen der Translation eines Punktteilchens. b und c zeigen Drehungen eines linearen und eines gewinkelten Moleküls, d und e Schwingungen der Bindungen. Jede Bewegungsart ist ein Speicher für Energie.]),
  "kolben-quelle": (titel: "Bild lesen", body: [Das Gas mit Druck P und Volumen V steckt unter einem beweglichen Kolben. Der rote Pfeil drückt den Kolben um die Strecke x hinein; die gestrichelte Linie ist die neue Kolbenlage. Dabei wird am Gas Arbeit verrichtet.]),
  "perpetuum-quelle": (titel: "Bild lesen", body: [Der Elektromotor treibt über eine Welle den Generator, der den Motor mit Strom versorgen soll. Zusätzlich sitzt ein Propeller auf der Welle, dessen Abwind den Wagen antreiben soll. Die Energie dafür käme aus dem Nichts.]),
  "mischung-quelle": (titel: "Bild lesen", body: [1: Zwei getrennte Körper mit T₁, C₁ und T₂, C₂. 2: Im Kontakt fließt Wärme Q vom wärmeren zum kälteren. 3: Am Ende haben beide dieselbe Temperatur T_end.]),
  "isobar-erwaermen-quelle": (titel: "Bild lesen", body: [Links wird dem Gas Wärme Q zugeführt. Der Kolben mit gleicher Masse, also gleichem Druck, steigt nach oben: Das Gas wird wärmer und dehnt sich aus.]),
  "phasen-quelle": (titel: "Bild lesen", body: [Waagerecht steht die zugeführte Wärme, senkrecht die Temperatur. Die schrägen Abschnitte erwärmen Eis, Wasser oder Dampf. Die waagerechten Plateaus bei 0 °C und 100 °C sind die Phasenübergänge; ihre Breite ist Q_S beziehungsweise Q_V. Das Verdampfungsplateau ist viel länger.]),
  "isotherme-quelle": (titel: "Bild lesen", body: [a: Der Zylinder steht im Wasserbad und behält die Temperatur, während der Kolben Arbeit W hineinsteckt und Wärme Q ins Bad abfließt. b: Die Isotherme ist eine Hyperbel; die grüne Fläche zwischen V₂ und V₁ ist die Kompressionsarbeit.]),
  "isobare-quelle": (titel: "Bild lesen", body: [a: Wärme Q wird bei konstantem Druck zugeführt, der Kolben steigt. b: Im P-V-Diagramm läuft der Zustand waagerecht von der Isotherme T₁ zur Isotherme T₂. Die grüne Rechteckfläche ist die vom Gas geleistete Arbeit.]),
  "isochore-quelle": (titel: "Bild lesen", body: [a: Das Volumen ist eingesperrt, Wärme Q erhöht Druck und Temperatur. b: Der Zustand springt senkrecht von P₁ nach P₂; unter einer senkrechten Linie gibt es keine Fläche, also keine Volumenarbeit.]),
  "adiabate-quelle": (titel: "Bild lesen", body: [a: Der Zylinder ist isoliert, es fließt keine Wärme. b: Die schwarze Adiabate fällt steiler als die rote Isotherme. Die grüne Fläche unter der Adiabate ist die Volumenarbeit.]),
  "kreisprozess-quelle": (titel: "Bild lesen", body: [Das Gas läuft von 1 über 2, 3 und 4 zurück nach 1. Die rote Kurve ist geschlossen; die eingeschlossene grüne Fläche W ist die Nutzarbeit eines Umlaufs.]),
  "carnot-quelle": (titel: "Bild lesen", body: [Rot ist die heiße Isotherme T₁, blau die kalte T₂, grün die beiden Adiabaten. Zwischen 1 und 2 fließt Wärme Q₁₂ ins Gas, zwischen 3 und 4 fließt Q₃₄ ab. Die Pfeile W zeigen, wo das Gas Arbeit leistet und wo an ihm Arbeit verrichtet wird.]),
  "carnot-schritte-quelle": (titel: "Bild lesen", body: [Von links nach rechts die vier Schritte: Expansion im heißen Bad, isolierte Expansion, Kompression im kalten Bad, isolierte Kompression. Orange und blau markieren Wärmekontakt, die Isolierung steht für ΔQ = 0.]),
  "blockdiagramm-quelle": (titel: "Bild lesen", body: [a: Wärme fließt von der heißen Quelle (orange) durch die Maschine (grün) zur kalten Senke (blau); unten wird Nutzarbeit abgegeben. b: Mit hineingesteckter Arbeit W wird Wärme von kalt nach heiß gepumpt; die Pfeile kehren sich um.]),
  "stirling-quelle": (titel: "Bild lesen", body: [a: Zwei Isothermen T₁ und T₂ sind durch zwei senkrechte Isochoren verbunden. b: Der heiße rechte und der kalte linke Zylinder sind über den Regenerator unten verbunden, der die Wärme zwischen den Isochoren zwischenspeichert.]),
  "waermeleitung-quelle": (titel: "Bild lesen", body: [Links der heiße Körper T_h, rechts der kalte T_k. Dazwischen liegt ein Leiter der Länge L mit Querschnitt A. Der rote Pfeil zeigt den Wärmestrom von heiß nach kalt.]),
  "netzwerk-quelle": (titel: "Bild lesen", body: [a: Zwei Wärmewiderstände in Reihe; derselbe Wärmestrom fließt durch beide, die Temperatur fällt in zwei Stufen. b: Zwei Wege parallel; beide liegen an derselben Temperaturdifferenz, die Wärmeströme addieren sich.]),
  "konvektion-quelle": (titel: "Bild lesen", body: [In einem Rohr wird ein Fluidpaket mit Masse m und Wärmekapazität c vom warmen Ort T₁ zum kälteren Ort T₂ getragen. Die Wärme reist mit dem Material.]),
  "planck-quelle": (titel: "Bild lesen", body: [Waagerecht steht die Wellenlänge in µm, senkrecht die abgestrahlte Intensität. a ist linear, b logarithmisch aufgetragen. Mit steigender Temperatur wachsen die Kurven stark, und ihr Maximum rückt nach links zu kurzen Wellenlängen. Der schmale sichtbare Bereich ist in b markiert.]),
  "treibhaus-quelle": (titel: "Bild lesen", body: [Die Sonne strahlt kurzwelliges Licht um 500 nm (grün), das die Atmosphäre durchlässt. Die Erde strahlt langwellig (rot); ein Teil davon wird in der Atmosphäre aufgehalten und wieder zur Erde geschickt. Die Beschriftungen „15K“ und „1µm“ sind Fehler der Folie.]),
  "optik-gebiete-quelle": (titel: "Bild lesen", body: [a: Strahlen von einer Lampe werfen hinter einer Blende scharfe Schatten. b: Hinter einem engen Spalt breitet sich Licht durch Beugung auch in den Schatten aus. c: Ein einzelnes Photon landet entweder in Detektor 1 oder in Detektor 2.]),
  "spektrum-quelle": (titel: "Bild lesen", body: [Die Achse zeigt die Wellenlänge in nm. Nur der farbige Streifen zwischen etwa 400 und 700 nm ist sichtbar; links schließen Ultraviolett und Röntgen, rechts Infrarot, Mikrowellen und Radiowellen an.]),
  "fermat-quelle": (titel: "Bild lesen", body: [Oben ist Strand, unten Wasser. Die grünen Linien sind mögliche Wege vom Rettungsschwimmer zum Ertrinkenden. Der rote Weg knickt an der Wasserlinie und braucht die kürzeste Zeit, obwohl die gepunktete Gerade kürzer ist.]),
  "reflexion-licht-quelle": (titel: "Bild lesen", body: [Der Strahl kommt von links oben und wird am Spiegel unten zurückgeworfen. Die senkrechte Linie ist das Einfallslot; beide grünen Winkel werden zum Lot gemessen und sind gleich groß.]),
  "hohlspiegel-quelle": (titel: "Bild lesen", body: [Rote achsenparallele Strahlen treffen den Kugelspiegel und laufen zum Brennpunkt f auf halbem Weg zum Mittelpunkt. Der grüne Radius R ist an jeder Stelle das Lot.]),
  "brechung-licht-quelle": (titel: "Bild lesen", body: [Oben liegt Medium n₁, unten das dichtere n₂. Der Strahl knickt an der Grenze zum Lot hin; α₂ ist kleiner als α₁.]),
  "totalreflexion-quelle": (titel: "Bild lesen", body: [Der Strahl kommt aus dem dichteren Medium n₁ oben. Beim Grenzwinkel läuft der gebrochene Strahl genau entlang der Grenzfläche, α₂ = 90°. Größere Einfallswinkel führen zur Totalreflexion.]),
  "dispersion-quelle": (titel: "Bild lesen", body: [a: Der Brechungsindex von BK7-Glas sinkt mit wachsender Wellenlänge. b: Weißes Licht wird beim Eintritt aufgefächert. c: Ein Prisma zerlegt Weißlicht in ein Regenbogenspektrum.]),
  "linsenschleifer-quelle": (titel: "Bild lesen", body: [Licht kommt von links. R₁ gehört zur ersten, R₂ zur zweiten Fläche, die Kreisbögen zeigen die Kugelflächen. a ist eine Sammellinse mit Brennpunkt f′ rechts, b eine Linse, deren Radien nach derselben Regel ein Vorzeichen bekommen; n ist das Linsenmaterial, n₀ die Umgebung.]),
  "sammellinse-quelle": (titel: "Bild lesen", body: [Parallele Strahlen treffen die Sammellinse. Rot laufen achsenparallele Strahlen im Brennpunkt f′ zusammen, grün schräg einfallende Strahlen in einem anderen Punkt derselben Brennebene.]),
  "zerstreuungslinse-quelle": (titel: "Bild lesen", body: [Achsenparallele rote Strahlen laufen hinter der Zerstreuungslinse auseinander. Die gestrichelten Rückverlängerungen treffen sich im Brennpunkt f′ vor der Linse.]),
  "sammel-konstruktion-quelle": (titel: "Bild lesen", body: [Der grüne Gegenstand G steht weiter als f vor der Linse. Parallelstrahl 1, Mittenstrahl 2 und Brennpunktstrahl 3 treffen sich rechts im blauen Bild B. Es ist reell und steht auf dem Kopf; g und b sind oben markiert.]),
  "lupe-virtuell-quelle": (titel: "Bild lesen", body: [G steht innerhalb der Brennweite. Die gebrochenen Strahlen laufen rechts auseinander; ihre gestrichelten Rückverlängerungen treffen sich links im großen, aufrechten virtuellen Bild B, das das Auge sieht.]),
  "zerstreu-konstruktion-quelle": (titel: "Bild lesen", body: [Die Strahlen 1 bis 3 gehen vom grünen Gegenstand aus und werden auseinandergelenkt. Ihre Rückverlängerungen schneiden sich im kleinen, aufrechten virtuellen Bild B zwischen f′ und Linse.]),
  "linsensystem-quelle": (titel: "Bild lesen", body: [Das Raster zeigt Millimeter. Die Sammellinse L₁ bei 0 bildet G als blaues Zwischenbild Z ab; Z ist der Gegenstand für die Zerstreuungslinse L₂ bei 150 mm. Das grüne Endbild B liegt virtuell vor L₂.]),
  "auge-quelle": (titel: "Bild lesen", body: [Der grüne Gegenstand links wird durch die blaue Linse auf die Netzhaut rechts abgebildet; dort steht das Bild B auf dem Kopf. Der Ringmuskel verändert die Linsenform, die Bildweite von etwa 2,5 cm bleibt fest.]),
  "kurzsichtig-quelle": (titel: "Bild lesen", body: [Links liegt der Bildpunkt eines fernen Gegenstands vor der Netzhaut. Rechts spreizt eine Zerstreuungslinse die Strahlen etwas auf, sodass sie sich auf der Netzhaut treffen.]),
  "weitsichtig-quelle": (titel: "Bild lesen", body: [Links läge der Bildpunkt hinter der Netzhaut. Rechts bündelt eine Sammellinse die Strahlen vorab, sodass das Bild auf die Netzhaut fällt.]),
  "lupe-quelle": (titel: "Bild lesen", body: [Links betrachtet das Auge G aus der deutlichen Sehweite s₀ unter dem kleinen Winkel ε. Rechts liegt G im Brennpunkt der Lupe direkt vor dem Auge; der Sehwinkel ε′ ist deutlich größer.]),
  "mikroskop-quelle": (titel: "Bild lesen", body: [Das Objektiv links erzeugt aus dem kleinen G ein großes reelles Zwischenbild Z. Zwischen den Brennpunkten liegt die Tubuslänge t. Das Okular rechts wirkt als Lupe und vergrößert den Sehwinkel ε.]),
  "kepler-quelle": (titel: "Bild lesen", body: [Ein weit entfernter Gegenstand erscheint unter ε₁. Das Objektiv bildet ihn in seine Brennebene ab, wo das blaue Zwischenbild Z liegt. Das Okular hat dort ebenfalls seinen Brennpunkt; das Auge sieht unter dem größeren Winkel ε₂.]),
  "galilei-quelle": (titel: "Bild lesen", body: [Das Objektiv ist eine Sammellinse, das Okular eine Zerstreuungslinse. Beide Brennpunkte liegen rechts am selben Ort; deshalb ist das Rohr um |f_ok| kürzer als f_obj.]),
  "licht-em-quelle": (titel: "Bild lesen", body: [a: Elektrisches (rot) und magnetisches Feld (blau) schwingen senkrecht zueinander und zur Ausbreitungsrichtung. b: Bei linearer Polarisation bleibt das E-Feld in einer Ebene. c: Bei zirkularer Polarisation dreht es sich auf einer Schraube.]),
  "kohaerenz-quelle": (titel: "Bild lesen", body: [a: Zwei Quellen mit fester Phasenverschiebung Δφ sind kohärent. b: Springt die Phase zufällig, sind sie inkohärent. c: Ein Strahlteiler macht aus einer Quelle zwei kohärente Teilwellen auf Weg 1 und Weg 2; L markiert die Kohärenzlänge.]),
  "michelson-quelle": (titel: "Bild lesen", body: [Das Licht der Quelle wird am Strahlteiler in den Referenzarm A nach oben und den Messarm B nach rechts geteilt. Beide Spiegel werfen es zurück; nach dem Strahlteiler interferieren die Teilwellen auf dem grünen Schirm. Δx ist die Spiegelverschiebung.]),
  "young-quelle": (titel: "Bild lesen", body: [a: Eine ebene Welle trifft von links auf zwei Spalte mit Abstand d; die Kreiswellen überlagern sich, gelb gestrichelt sind Minima und Maxima. b: Auf dem Schirm erscheinen gleich breite Streifen der Ordnungen −4 bis 4. c: Die Intensität schwankt periodisch mit dem Winkel.]),
  "gitter-quelle": (titel: "Bild lesen", body: [Das Gitter mit Spaltabstand d steht links, der Schirm rechts. Die grünen Flecken sind die Beugungsordnungen 0, ±1, ±2; α ist der Winkel zur ersten Ordnung.]),
  "einzelspalt-quelle": (titel: "Bild lesen", body: [a: Hinter dem Spalt entstehen ein zentrales Maximum, Minima und schwache Nebenmaxima. b: Der Spalt der Breite b wird gedanklich in Punkte geteilt; Punkt 1 und Punkt N/2 haben im ersten Minimum den Wegunterschied Δs = λ/2.]),
  "spaltbreite-quelle": (titel: "Bild lesen", body: [Oben die Intensität über dem Winkel in rad, unten das Streifenbild. Der schmalere Spalt (rechts, b = 5λ) erzeugt das breitere Hauptmaximum mit ersten Minima bei etwa ±0,2 rad.]),
  "doppelspalt-huelle-quelle": (titel: "Bild lesen", body: [Orange sind die schnell wechselnden Doppelspaltstreifen, rot die Einhüllende des Einzelspalts. Links sind die Spalte schmaler und die Hülle breiter, rechts umgekehrt; außerhalb der Hülle verschwinden die Streifen fast.]),
  "map-gasgesetz": (titel: "Die Mindmap lesen", body: [Oben stehen die beiden Teilgesetze mit ihrer festgehaltenen Größe. Unten links zählt die Stoffmenge die Teilchen; unten rechts fasst das Gasgesetz alles zusammen, mit der wichtigsten Falle: Kelvin.]),
  "map-hauptsatz": (titel: "Die Mindmap lesen", body: [Wärme und Arbeit sind die beiden Wege, auf denen sich die innere Energie ändert. Unten rechts steht die Bilanz; aus ihr folgt, dass keine Maschine Energie aus dem Nichts liefert.]),
  "map-kreisprozess": (titel: "Die Mindmap lesen", body: [Links oben die Grundidee: Die umschlossene Fläche ist die Arbeit. Rechts der Carnot-Prozess und darunter seine Grenze für den Wirkungsgrad. Links unten die Umkehrung zur Wärmepumpe.]),
  "map-waermetransport": (titel: "Die Mindmap lesen", body: [Drei Äste nennen die drei Mechanismen mit ihrem Merkmal. Der vierte Ast zeigt das Rechenwerkzeug für die Wärmeleitung: Widerstände wie in der Elektrotechnik.]),
  "map-brechung": (titel: "Die Mindmap lesen", body: [Links oben die Ursache: Licht ist im Medium langsamer. Rechts oben das Gesetz mit Winkeln zum Lot. Unten zwei Folgen: Totalreflexion und die Farbaufspaltung durch Dispersion.]),
  "map-abbildung": (titel: "Die Mindmap lesen", body: [Oben die Gleichung und die Bedeutung des Vorzeichens von b. Unten der Abbildungsmaßstab und die zeichnerische Konstruktion mit Hauptstrahlen.]),
  "map-instrumente": (titel: "Die Mindmap lesen", body: [Alle vier Instrumente vergrößern den Sehwinkel. Lupe und Mikroskop arbeiten mit nahen, die beiden Fernrohre mit fernen Gegenständen; Galilei liefert ein aufrechtes Bild.]),
  "map-kohaerenz": (titel: "Die Mindmap lesen", body: [Links oben die Voraussetzung für Interferenz, rechts oben die Größe, die die Phase bestimmt. Unten die beiden Grundanordnungen: viele Spalte geben scharfe Maxima, ein einzelner Spalt bestimmt die Breite.]),
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
#text(size: 12pt, fill: teal)[Welle → Wärme → Licht]
]
#note("Dein Feynman-Schritt", [Sieh hin, erkläre den Zusammenhang ohne Vorlage und prüfe dann Formel und Voraussetzungen. Bearbeite anschließend eine Aufgabe auf der Lernwebseite. Vergleiche erst danach mit den Lösungsschritten und schließe deine konkrete Lücke.])

Stand *12.11.2026*: Klausurrelevant sind die Kapitel 6 bis 8; das frühere Kapitel 5 (Schwingungen) ist entfernt. Kapitel 6 Wellen ist jetzt vollständig, einschließlich bewegtem Empfänger und Mach-Kegel. Neu sind Kapitel 7 Wärmelehre und Kapitel 8 Optik nach den Vorlesungsfolien, ergänzt um Übungsblatt 11, die Musterlösungen zu Altklausuraufgaben und die Nummern Deiner Formelsammlung. Die Kapitelnummern folgen dem Dozentenskript. Aufgaben und Lösungen stehen auf der Lernwebseite; dieses Skript enthält Erklärungen und Formelsammlung.
#src[V1, PDF-S. 7–13; VB, PDF-S. 3–22; V26, PDF-S. 1–15; K6, S. 209–213; K7, S. 215–270; K8, S. 271–316; Ü11; M; FS.]

#pagebreak()
#heading(level: 1, outlined: false)[Wegweiser]
#block[
#set text(size: 9.5pt)
#set par(leading: 0.3em, spacing: 0.15em)
#outline(title: none, depth: 2, indent: auto)
]
#v(2mm)
#text(size: 8.5pt, fill: muted)[*Quellenkürzel:* V = Flossmann, Physik für Ingenieure, Stand 02.10.2026, Gesamt-PDF; V1 = VL1 Physik (13 PDF-Seiten, Skript S. 169–174 und 177–183); VB = VL Physik bisher (22 PDF-Seiten, Skript S. 175–196); V26 = VL 26.10.pdf (15 PDF-Seiten, Skript S. 196–210); K6 = Kapitel_6.pdf, K7 = Kapitel_7_Stand_5_1_26.pdf, K8 = Kapitel_8_Stand_12_1_26.pdf (Vorlesungsfolien; „S.“ ist hier der Seitenaufdruck, die PDF-Seite ist S. − 176, S. − 214 beziehungsweise S. − 270); ÜN = Physik2_Blatt10_mit_Notizen_26.10.pdf (4 PDF-Seiten); Ü = Physik2_Blatt10, Aufgaben 10.1–10.6; R = handschriftliche Lösung Blatt 10; Ü11 = Physik2_Blatt11_mit_Loesung.pdf (Aufgaben PDF-S. 1–2, handschriftliche Lösungen PDF-S. 3–5); M = Musterlösungen zu Altklausuraufgaben (Ordner Altklausuren/Musterlösungen, benannt nach der Aufgabe); FS = Deine handschriftliche Formelsammlung Klausur Physik, zitiert mit ihren eigenen Nummern (Kapitel 8 ist dort ab K9.3 nummeriert); AS = Aufgabensammlung, 23.04.2026, Nummer laut Sammlung; L = bisheriges Lernskript Physik 2, Stand 15.10.2026; LB = Lernblatt VL 1; K15 = Prüfung Phy_1 (Deckblatt WS 2015/16). „PDF-S.“ zählt ab der ersten PDF-Seite der genannten Datei. Bei V stimmt diese Zählung mit dem Seitenaufdruck überein. Alle „Nachschlagen“-Verweise führen zu Abschnitt und echter Seite dieses Lernskripts. Eigene Aufgaben, Umformungen und Darstellungen sind gekennzeichnet.]
#pagebreak()
#heading(level: 1, outlined: false, bookmarked: false)[Das Modul auf einen Blick] <ueberblick>

Jeder Kasten führt zu seinem Kapitel. Die Pfeiltexte zeigen, wie die Kapitel zusammenhängen.

#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Kapitel 6 · Wellen], [Wellenfunktion · Eigenmoden · Raumwellen · Huygens · Doppler · Mach], ziel: <a-6>),
  pfeil(beschriftung: [Schall im Gas hängt von T ab]),
  chunk([Kapitel 7 · Wärmelehre], [Gasgesetz · 1. Hauptsatz · Kreisprozesse · Wärmetransport], ziel: <a-7>),
  pfeil(beschriftung: [Wärmestrahlung ist Licht im Infrarot]),
  chunk([Kapitel 8 · Optik], [Brechung · Linsen · Instrumente · Interferenz · Beugung], ziel: <a-8>),
)

Bei Wellen trennst Du die lokale Teilchenbewegung vom wandernden Muster und seinem Energiefluss. Überlagerung und Randbedingungen bestimmen die Eigenmoden; im Raum erklären Wellenfronten Intensität, Beugung und Grenzflächen, Bewegung führt zum Doppler-Effekt. Die Wärmelehre beschreibt viele Teilchen nur noch über Temperatur, Druck und Volumen und bilanziert Wärme und Arbeit bis zur Wärmekraftmaschine. Die Optik nimmt die Wellenideen wieder auf: Licht wird gebrochen, durch Linsen abgebildet und interferiert an Spalten und Gittern.
#src[Eigene Darstellung; Zusammenführung der Kapitel 6 bis 8 und der Denkkette auf der Titelseite.]

#pagebreak()
#pagebreak(weak: true)
= Kapitel 6 · Wellen <a-6>

#überblick([Kapitel 6 auf einen Blick],
  idee(<a-6-1>, [Das Muster wandert, die Teilchen schwingen lokal.], [Die Wellenfunktion beschreibt Auslenkung nach Ort und Zeit.]),
  idee(<a-6-2>, [Ort und Zeit haben je einen Takt.], [Wellenlänge und Frequenz sind über die Ausbreitungsgeschwindigkeit verbunden.]),
  idee(<a-6-3>, [Medium und Amplitude bestimmen die Ausbreitung.], [Rückstellwirkung und Trägheit liefern c; die Amplitude bestimmt den Energiefluss.]),
  idee(<a-6-7>, [Überlagerung und Ränder wählen die Eigenmoden.], [Das gilt auf einer Strecke und auf einer Fläche.]),
  idee(<a-6-8>, [Fronten erklären räumliche Ausbreitung.], [Geometrie, Huygens, Interferenz, Beugung und Grenzflächen hängen zusammen.]),
  idee(<a-6-9>, [Bewegung verändert den ankommenden Takt.], [Doppler-Effekt für bewegte Quelle und bewegten Empfänger; Mach-Kegel bei Überschall.]),
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
#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Räumliche Fronten], [Geometrie · Huygens], ziel: <a-6-8-1>),
  pfeil(beschriftung: [erklären]),
  chunk([Überlagerung und Grenzen], [Interferenz · Beugung · Brechung], ziel: <a-6-8-3>),
  pfeil(beschriftung: [Bewegung ändert]),
  chunk([Ankommenden Takt], [Doppler · Mach-Kegel], ziel: <a-6-9>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])


Wir verfolgen nun, wie eine Störung von Ort zu Ort weitergegeben wird. Erst lesen wir die Wellenfunktion, dann bestimmen wir Geschwindigkeit und Energiefluss. Danach zeigt die Überlagerung, welche stehenden Muster zu Rändern passen. Räumliche Fronten erklären Interferenz, Beugung und Grenzflächen. Zum Schluss verändern bewegte Quellen und Empfänger den ankommenden Takt.
#src[VB, PDF-S. 3–22; V1, PDF-S. 7–13; V26, PDF-S. 1–15; K6, S. 209–213.]

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

#note("Bisherige Vorlesungsgrenze", [Die Grenze „Ende VL 19.10.“ auf VB, PDF-S. 22 ist in V26, PDF-S. 1 erneut markiert. Direkt darunter beginnt die neue Vorlesung vom 26.10.; ihre Ergänzungen folgen im nächsten Abschnitt.])
#src[VB, PDF-S. 20–22 bis zur Grenze, Gl. 6.13–6.18; eigene Herleitung der zulässigen Ordnungen.]

*Von der laufenden Welle zu den Eigenmoden.* Die Wellenfunktion trennt Ort und Zeit. Die Geschwindigkeit stammt aus dem Medium, die Frequenz aus der Anregung; daraus folgt die Wellenlänge. Die Amplitude bestimmt den Energiefluss quadratisch. Überlagerung erzeugt Verstärkung oder Auslöschung; Reflexion macht daraus stehende Wellen. Erst die Randbedingungen wählen ihre zulässigen Moden aus.
#src[VB, PDF-S. 5–22; eigene Zusammenfassung.]
#hoch(<a-6>, [Kapitelübersicht])


== 6.7.4 Ergänzung vom 26.10. · Stehende Wellen auf Flächen <a-6-7-4>
Ein Trommelfell kann nicht nur entlang einer Strecke, sondern in zwei Richtungen schwingen. Eine *zweidimensionale Eigenmode* ist eine gemeinsame Schwingungsform der ganzen Fläche, die zu deren Form und Randbedingungen passt. Statt einzelner Knotenpunkte entstehen *Knotenlinien*: Auf ihnen bleibt die Auslenkung jederzeit null.

#bild("membran-knoten-quelle", [Knotenlinien auf Rechteck- und Kreismembran. V26, PDF-S. 2, Abb. 6.11.], height: 48mm)

Zwischen den Knotenlinien liegen schwingende Flächenbereiche. Feiner Sand wird von diesen Bereichen fortbewegt und sammelt sich bevorzugt an ruhenden Linien. So macht das Experiment die Eigenmode sichtbar. Am eingespannten Rand ist die Auslenkung ebenfalls null; ein freier Rand verlangt eine andere Randbedingung.
#note("In eigenen Worten", [Aus dem Knotenmuster einer Saite wird auf einer Fläche ein Netz ruhender Linien. Die Randbedingungen müssen in der ganzen Ebene erfüllt sein; die eindimensionale Formel $f_n=n c/(2L)$ darf nicht ungeprüft auf ein Trommelfell übertragen werden.], fill: sand)
#src[V26, PDF-S. 1 ab der Startmarkierung und PDF-S. 2, Skript S. 196–197; eigene Erläuterung des Modenbegriffs.]
#hoch(<a-6>, [Kapitelübersicht])

== 6.8 Wellenausbreitung im Raum · Fronten statt Teilchenbahnen <a-6-8>
Eine Sirene erreicht nicht nur eine Linie von Zuhörern. Im Raum beschreiben wir ihre Ausbreitung durch Flächen gleicher Phase. Das Huygenssche Prinzip erklärt anschließend, wie Fronten weiterwandern, sich überlagern und an Hindernissen ihre Form ändern.
#src[V26, PDF-S. 3–13, Skript S. 198–208; eigene Zusammenfassung.]

=== 6.8.1 Ebene, Kugel- und Zylinderwellen <a-6-8-1>
Eine *Wellenfront* verbindet Orte gleichen Schwingungszustands. Auf der Wasseroberfläche ist sie eine Linie, im Raum eine Fläche. Die *Wellennormale* steht senkrecht auf der Front und zeigt im behandelten homogenen, isotropen Medium die Ausbreitungsrichtung. Benachbarte gleichphasige Fronten liegen eine Wellenlänge auseinander.

#tab(columns: (1fr, 1.3fr, 1.6fr),
 th([Idealtyp], [Quelle und Front], [Intensität ohne Verluste]),
 [Ebene Welle], [Flächige Quelle; parallele Ebenen], [Gleichbleibende Transportfläche: $I="konstant"$],
 [Kugelwelle], [Punktquelle; konzentrische Kugeln], [$A=4 pi r^2$; $I prop 1/r^2$],
 [Zylinderwelle], [Lange Linienquelle; Zylindermäntel], [$A=2 pi r ell$; $I prop 1/r$],
)
#form[$ I(r)=P/(4 pi r^2), quad I(r_2)/I(r_1)=(r_1/r_2)^2 quad "(Kugelwelle)" $]
$P$ ist die gleichmäßig in alle Richtungen abgestrahlte Leistung in W, $r$ der Abstand in m und $I$ die Intensität in W/m². Bei der Zylinderwelle wird eine feste Quellenlänge $ell$ betrachtet. Die Flächenformeln und das Intensitätsverhältnis sind eigene Ableitungen aus $I=P/A$.

#bild("map-raumwellen", [Mindmap zur geometrischen Verteilung der Leistung. Eigene Darstellung nach V26, PDF-S. 3–5.], height: 46mm)

*Eigene Folgerung:* Doppelter Abstand ergibt bei der Kugelwelle ein Viertel, bei der Zylinderwelle die Hälfte der Intensität. Bei festem Medium und fester Frequenz folgt aus $I prop u^2$: Die Amplitude einer Kugelwelle fällt wie $1/r$, die einer Zylinderwelle wie $1/sqrt(r)$.
#note("Gültigkeit", [Idealisierte, verlustfreie Ausbreitung ohne Reflexionen und ohne Absorption. Reale Quellen sind nicht unendlich groß oder exakt punktförmig. Die Autobahn als Linienquelle und eine entfernte kompakte Maschine als Punktquelle sind Näherungen; eine Intensitätsabnahme durch Flächenwachstum bedeutet keine Vernichtung von Energie.], fill: sand)
#src[V26, PDF-S. 3–6, Abb. 6.12–6.16; VB, PDF-S. 13–14 für $I=P/A$ und $I prop u^2$; Flächen- und Amplitudenskalierung: eigene Ableitungen.]
#hoch(<a-6>, [Kapitelübersicht])

=== 6.8.2 Huygens · Aus Elementarwellen wird eine neue Front <a-6-8-2>
Jeder Punkt einer Wellenfront wird als Ausgangspunkt einer *Elementarwelle* betrachtet. Nach derselben kurzen Zeit konstruiert man die neue Front als gemeinsame *Einhüllende*: Sie berührt die vorwärts laufenden Elementarwellen. So wird aus vielen kleinen Ausbreitungen wieder eine zusammenhängende Front.
#bild("huygens-quelle", [Alte Front, Elementarwellen und neue Einhüllende. V26, PDF-S. 7, Abb. 6.18.], height: 38mm)
#form[$ r_"Elementar"=c Delta t $]
Der Radius in m wächst während $Delta t$ in s mit der Geschwindigkeit $c$ in m/s. Das ist eine eigene Anwendung von Strecke = Geschwindigkeit × Zeit. Der Abstand zwischen alter und neuer Front ist nur dann genau eine Wellenlänge, wenn $Delta t=T$ gewählt wird.

Das *Huygens-Fresnelsche Prinzip* ergänzt die geometrische Konstruktion: Die Auslenkung am Ziel entsteht aus der Superposition der Elementarwellen. Dabei zählen deren Phasen; nicht jede Elementarwelle verstärkt die anderen. Das Summieren über alle Punkte führt mathematisch zu einer Integration, die hier nicht ausgerechnet wird.
#bild("map-huygens", [Mindmap: Konstruktion und Überlagerung. Eigene Darstellung nach V26, PDF-S. 6–7.], height: 46mm)
#note("Präzisierung der Vorlage", [V26, PDF-S. 6–7 spricht bei gleichen Frequenzen von einer „zeitlich konstanten Funktion". Die momentane Auslenkung schwingt weiterhin. Zeitstabil sind bei fester relativer Phase die Orte der Verstärkung und Auslöschung beziehungsweise das zeitlich gemittelte Intensitätsmuster. Gleiche Frequenz allein ersetzt die feste Phasenbeziehung nicht.], fill: sand)
#src[V26, PDF-S. 6–7, Abb. 6.17–6.18; Präzisierung aus der dort angegebenen Superposition harmonischer Wellen.]
#hoch(<a-6>, [Kapitelübersicht])

=== 6.8.3 Zwei Quellen und Doppelspalt · Der Weg entscheidet die Phase <a-6-8-3>
Zwei gleich getaktete Quellen können an einem Ort gemeinsam stark und an einem anderen schwach wirken. Entscheidend sind die *Wegdifferenz* $Delta s$ und eine mögliche Anfangsphasendifferenz. Für zwei Wege $s_1,s_2$ wähle konsistent $Delta s=s_1-s_2$ und die dazu passende Phase $Delta phi_0$:
#form[$ Delta phi=(2 pi)/lambda Delta s+Delta phi_0 $]
$Delta s$ und $lambda$ stehen in m, die Phasen in rad. Das Vorzeichen hängt von der Reihenfolge der Quellen ab; eine gleichzeitige Umkehr beider Differenzen ändert das Interferenzergebnis nicht.
#note("Dimensionsfehler in der Quelle", [Gl. 6.19 auf V26, PDF-S. 8 addiert eine Phasenverschiebung direkt zu Weglängen. Eine Phase in rad darf aber nicht ohne Umrechnung zu Metern addiert werden. Die äquivalente Wegverschiebung ist $lambda Delta phi_0/(2pi)$. Hier wird deshalb mit der dimensionsrichtigen Phasengleichung gerechnet.], fill: sand)

Bei gleichphasigen Quellen liegen Maxima bei $abs(Delta s)=j lambda$ und Minima bei $abs(Delta s)=(j+1/2)lambda$ mit $j=0,1,2,dots$. Vollständige Auslöschung erfordert zusätzlich gleiche Amplituden am Beobachtungsort. Im Nahbereich berechnest du beide Wege aus der Geometrie; das zeigt die Mitschrift zu Ü 10.5 ausdrücklich.
#bild("doppelspalt-quelle", [Zwei Öffnungen wirken als Quellen; Maxima und Minima hinter dem Doppelspalt. V26, PDF-S. 10, Abb. 6.21.], height: 55mm)

Im *Fernfeld*, also bei Beobachtungsabstand viel größer als Quellenabstand $d$, verlaufen die beiden Wege näherungsweise parallel. Für den Winkel $alpha$ gegen die Mittelsenkrechte der Quellenverbindung gilt:
#form[$ Delta s approx d sin(alpha), quad sin(alpha_j)=j lambda/d quad "(Maxima)" $]
#form[$ sin(alpha_"min")=(j+1/2)lambda/d quad "(Minima)" $]
Hier dürfen positive und negative ganze $j$ eingesetzt werden. Physikalisch existiert nur ein Winkel, wenn die rechte Seite im Bereich von −1 bis +1 liegt. Vorausgesetzt sind gleiche Frequenz und feste, hier gleiche Anfangsphase.

#note("Mehrfachspalt nicht gleich Doppelspalt", [Der letzte Satz auf V26, PDF-S. 10 behauptet gleiche Maxima- *und* Minimawinkel beim n-fach-Spalt. Die gemeinsamen Hauptmaxima gleichabständiger, gleichphasiger Quellen erfüllen weiterhin $d sin(alpha)=j lambda$. Die Aussage über alle Minima ist jedoch nicht allgemein richtig: Zusätzliche Quellen ändern die Auslöschungsbedingungen. Die Doppelspalt-Minimaformel wird hier nicht auf beliebig viele Spalte übertragen.], fill: sand)
#src[V26, PDF-S. 8–10, Gl. 6.19–6.21; ÜN, PDF-S. 3; dimensionsrichtige Phasenform und Einschränkung des Mehrfachspalts: eigene Präzisierungen aus dem Superpositionsprinzip.]
#hoch(<a-6>, [Kapitelübersicht])

=== 6.8.4 Beugung · Wellen reichen in den geometrischen Schatten <a-6-8-4>
Hinter einer Kante ist nicht zwangsläufig völlige Ruhe. *Beugung* bedeutet, dass sich Wellen auch in den geometrischen Schatten eines Hindernisses ausbreiten. Deshalb ist eine Schallquelle nicht nur dort wahrnehmbar, wo eine gerade Verbindung zu ihr frei ist (*eigene Alltagsveranschaulichung*).
#bild("beugung-quelle", [Beugung an verschiedenen Hindernissen. V26, PDF-S. 11, Abb. 6.22.], height: 52mm)
Das Huygenssche Modell erklärt dies mit den Elementarwellen der nicht blockierten Front an Öffnungen und Kanten. Ihre Ausläufer reichen in den Schatten. Die tatsächliche Stärke ergibt sich aus der Interferenz aller Beiträge; die Kante ist keine zusätzliche Energiequelle.
#note("Begriffe trennen", [Beugung beschreibt die Ausbreitung in Bereiche, die ein reines geradliniges Strahlenbild ausblendet. Interferenz bezeichnet die Überlagerung der Auslenkungen. Beugungsbilder entstehen durch diese Überlagerung der Elementarwellen; es sind keine konkurrierenden Erklärungen.])
#src[V26, PDF-S. 7 und 11, Abb. 6.18 und 6.22; Alltagsbild und Begriffstrennung: eigene Erläuterung.]
#hoch(<a-6>, [Kapitelübersicht])

=== 6.8.5 Reflexion und Brechung · Winkel immer zum Lot <a-6-8-5>
Eine schräge Welle trifft nicht mit ihrer ganzen Front gleichzeitig auf eine Grenzfläche. Die zuerst auftreffenden Punkte senden früher Elementarwellen aus. Deren gemeinsame Einhüllende erklärt sowohl die zurücklaufende als auch die in ein anderes Medium übergehende Front.
#bild("reflexion-3d-quelle", [Reflexion mit dem Huygensschen Prinzip. V26, PDF-S. 12, Abb. 6.23.], height: 57mm)
#form[$ alpha_"ein"=alpha_"aus" quad "(Winkelbeträge zum Lot)" $]
Bei *Reflexion* bleibt die Welle im selben Medium. Einfalls- und Ausfallswinkel sind betragsgleich. Das Minuszeichen in Gl. 6.22 kennzeichnet die entgegengesetzten Seiten des Lots bei vorzeichenbehafteten Winkeln; Gl. 6.23 nennt die gleichen Beträge.

#bild("brechung-quelle", [Brechung in ein langsameres Medium. V26, PDF-S. 13, Abb. 6.24.], height: 43mm)
Bei *Brechung* ändert sich die Ausbreitungsgeschwindigkeit. Die neu entstehenden Elementarwellen wachsen deshalb unterschiedlich weit, und die Ausbreitungsrichtung dreht sich. Das Snelliussche Gesetz lautet:
#form[$ sin(alpha_1)/c_1=sin(alpha_2)/c_2, quad lambda_2/lambda_1=c_2/c_1, quad f_2=f_1 $]
$c_1,c_2$ stehen in m/s; die Winkel werden zwischen Wellennormale und Grenzflächenlot gemessen. Für $c_2<c_1$ wird zum Lot hin, für $c_2>c_1$ vom Lot weg gebrochen. Die Frequenz bleibt an der ruhenden Grenzfläche gleich; nur Geschwindigkeit und Wellenlänge ändern sich.
#note("Gültigkeit und Grenzfälle", [Ruhende Grenzfläche, homogene isotrope Medien und ein möglicher sich ausbreitender gebrochener Anteil. Senkrechter Einfall ergibt keine Richtungsänderung, auch wenn $c$ sich ändert. Liefert die Rechnung $abs(sin(alpha_2))>1$, existiert kein reeller Brechungswinkel dieses Strahlenmodells; keinen unmöglichen Winkel angeben.], fill: sand)
#src[V26, PDF-S. 12–13, Gl. 6.22–6.24; Wellenlängenverhältnis und Grenzfälle: eigene Ableitungen.]
#hoch(<a-6>, [Kapitelübersicht])

== 6.9 Doppler-Effekt und Mach-Kegel · Bewegung ändert den ankommenden Takt <a-6-9>
Ein vorbeifahrendes Fahrzeug klingt bei der Annäherung höher als beim Entfernen. Der Takt der Quelle muss sich dafür nicht ändern. Entscheidend ist, wie viele Fronten der Empfänger pro Sekunde erreicht. Das kann sich ändern, weil die Quelle die Frontabstände verändert oder weil der Empfänger den Fronten entgegenläuft. Wird die Quelle schneller als die Welle, entsteht der Mach-Kegel.
#src[V26, PDF-S. 14–15; K6, S. 209–213; Ü 10.6.]

=== 6.9.1 Doppler-Effekt · Bewegte Quelle, ruhender Empfänger <a-6-9-1>
Der Sender emittiert im Abstand $T_S=1/f_S$ jeweils eine neue Front. Währenddessen rückt er um $v_S T_S$ weiter. Vor ihm werden die Frontabstände kleiner, hinter ihm größer. Die Welle selbst läuft im ruhenden Medium weiterhin mit $c$.
#bild("doppler-quelle", [Bewegter Sender: gestauchte und gedehnte Frontabstände. V26, PDF-S. 15, linker Teil von Abb. 6.25.], height: 49mm)
#form[$ lambda_"vor"=(c-v_S)/f_S, quad lambda_"hinter"=(c+v_S)/f_S $]
#form[$ f_"an"=f_S/(1-v_S/c), quad f_"ent"=f_S/(1+v_S/c) $]
$f_S$ ist die Senderfrequenz in Hz; $f_"an"$ und $f_"ent"$ sind die vom ruhenden Empfänger gehörten Frequenzen. $v_S$ ist hier der positive Geschwindigkeitsbetrag in m/s bei geradliniger Bewegung auf ihn zu beziehungsweise von ihm weg; $c$ ist die Schallgeschwindigkeit relativ zum Medium.

*Eigene Herleitung:* Der ruhende Empfänger erhält pro Sekunde $c/lambda_E$ Fronten. Mit kleinerem Frontabstand hört er daher eine höhere Frequenz. Als Vorzeichenkontrolle gilt: Bei Annäherung muss der Nenner kleiner als eins, beim Entfernen größer als eins sein. Bei $v_S=0$ erhält man wieder $f_E=f_S$.
#bild("map-doppler", [Mindmap zum Doppler-Effekt bei bewegtem Sender. Eigene Darstellung.], height: 46mm)
#note("Gültigkeit", [Klassisches Wellenmodell mit ruhendem Medium; bewegte Quelle mit $0<=v_S<c$ und ruhender Empfänger. Die beiden angegebenen Beträge gelten für Bewegung entlang der Verbindungslinie, nicht ungeprüft im Moment einer seitlichen Vorbeifahrt. Für Licht sind diese Formeln nicht gültig.], fill: sand)
#src[V26, PDF-S. 14–15, Gl. 6.25 und linker Teil von Abb. 6.25; K6, S. 210; ÜN, PDF-S. 4. Herleitung und Grenzfallprüfung: eigene Erläuterungen.]

=== 6.9.2 Doppler-Effekt · Bewegter Empfänger und beide bewegt <a-6-9-2>
Jetzt ruht die Quelle, und der Empfänger fährt mit $v_E$ auf sie zu. Die Fronten liegen im Medium unverändert $lambda_S$ auseinander. Der Empfänger läuft ihnen aber entgegen und trifft deshalb in kürzerer Zeit auf die nächste Front. *Alltagsbild (eigene Ergänzung):* Wer auf einer Rolltreppe gegen die Laufrichtung geht, begegnet mehr Stufen pro Sekunde, obwohl die Stufen gleich weit auseinander bleiben.
#bild("doppler-empfaenger-quelle", [Ruhende Quelle, bewegter Empfänger. K6, S. 210, rechter Teil von Abb. 6.25.], height: 42mm)
Zwischen zwei Fronten vergeht für den Empfänger die Zeit $T_E$. In dieser Zeit schrumpft der Abstand zur nächsten Front um genau $lambda_S$:
#form[$ lambda_S=T_E (c plus.minus v_E) quad arrow.r.double quad f_E=f_S (1 plus.minus v_E/c) $]
Das Pluszeichen gilt bei Annäherung, das Minuszeichen beim Entfernen. Bewegen sich beide, setzt man das von der bewegten Quelle veränderte $f_S$ in diese Gleichung ein:
#form[$ f_E=f_S (1 plus.minus v_E/c)/(1 minus.plus v_S/c) $]
Bei Annäherung steht im Zähler $+$ und im Nenner $-$; beim Entfernen umgekehrt. $v_E$ und $v_S$ sind Beträge in m/s relativ zum ruhenden Medium.

#tab(columns: (1.2fr, 1.6fr, 1.7fr),
 th([Fall], [Gehörte Frequenz], [Woran es liegt]),
 [Quelle bewegt], [$f_E=f_S/(1 minus.plus v_S/c)$], [Frontabstand im Medium ändert sich],
 [Empfänger bewegt], [$f_E=f_S(1 plus.minus v_E/c)$], [Frontabstand bleibt; Begegnungsrate ändert sich],
 [Beide bewegt], [$f_E=f_S(1 plus.minus v_E/c)/(1 minus.plus v_S/c)$], [Beide Effekte nacheinander],
)
*Eigenes Zahlenbeispiel:* Eine ruhende Sirene sendet 500 Hz, $c=340 thin "m/s"$. Ein Radfahrer nähert sich mit 20 m/s: $f_E=500 dot (1+20/340) thin "Hz" approx 529 thin "Hz"$. Fährt stattdessen die Sirene mit 20 m/s auf den ruhenden Radfahrer zu, hört er $500/(1-20/340) thin "Hz"="531,25" thin "Hz"$. Gleiche Geschwindigkeit ergibt also nicht genau dieselbe Frequenz.
#note("Fehler vermeiden", [Die Formeln für bewegte Quelle und bewegten Empfänger sind nicht austauschbar: Die Quelle steht im Nenner, der Empfänger im Zähler. Prüfe das Vorzeichen immer mit dem Satz „Annäherung macht den Ton höher“.], fill: sand)
#note("Quellenfehler sichtbar korrigiert", [Im rechten Teil von Abb. 6.25 ist die Geschwindigkeit des Empfängers mit $v_S$ beschriftet. Gemeint ist $v_E$, wie im Text und in Gl. 6.26.], fill: sand)
#src[K6, S. 209–211, Gl. 6.25–6.27 und rechter Teil von Abb. 6.25; FS, K6.25–K6.27. Rolltreppenbild und Zahlenbeispiel: eigene Ergänzungen.]
#hoch(<a-6>, [Kapitelübersicht])

=== 6.9.3 Der Mach-Kegel · Die Quelle überholt ihre Wellen <a-6-9-3>
Erreicht der Sender genau die Wellengeschwindigkeit, $v_S=c$, liegen alle Fronten vor ihm übereinander. Nach Gl. 6.25 würde die gehörte Frequenz unendlich groß. Das Skript nennt diese Verdichtung die „Schallmauer“. Ist der Sender schneller, $v_S>c$, überholt er seine eigenen Fronten. Die Kugelwellen berühren dann alle einen gemeinsamen Kegelmantel: den *Mach-Kegel*.
#bild("mach-quelle", [Schallmauer bei $v_S=c$ (a) und Mach-Kegel bei $v_S>c$ (b). K6, S. 212, Abb. 6.26.], height: 42mm)
In der Zeit $t$ fliegt der Sender die Strecke $v_S t$; die zu Beginn ausgesandte Front wächst auf den Radius $c t$. Im rechtwinkligen Dreieck gilt $v_S t sin(theta)=c t$, also:
#form[$ sin(theta)=c/v_S, quad theta=arcsin(c/v_S) quad (v_S>c) $]
$theta$ ist der *halbe* Öffnungswinkel des Kegels. Je schneller der Sender, desto spitzer der Kegel. *Eigenes Zahlenbeispiel:* Bei doppelter Schallgeschwindigkeit ist $sin(theta)=1/2$ und $theta=30°$.

Am Kegelmantel entsteht eine Schockwelle: Der Druck steigt plötzlich an und fällt danach ab. Wer vom Mantel gestreift wird, hört den *Überschallknall*. Bei feuchter Luft kann der Druckabfall Wasserdampf kondensieren lassen; dann wird der Kegel als Wolke sichtbar („Wolkenscheibeneffekt“).
#note("Gültigkeit", [Gl. 6.28 gilt nur für $v_S>c$; für $v_S<c$ gibt es keinen reellen Winkel. Der Knall entsteht nicht nur beim „Durchbrechen“ der Schallmauer, sondern begleitet den Überschallflug, solange der Kegel über den Beobachter streicht (*eigene Präzisierung* aus der Kegelgeometrie).], fill: sand)
#src[K6, S. 212–213, Gl. 6.28, Abb. 6.26; FS, K6.28. Zahlenbeispiel und Präzisierung: eigene Ergänzungen.]
#hoch(<a-6>, [Kapitelübersicht])

*Der Zusammenhang in Kapitel 6.* Die Randbedingungen wählen auch auf Flächen die Eigenmoden. Im freien Raum entscheidet die Frontgeometrie, auf welche Fläche sich die Leistung verteilt. Huygens verbindet die Frontausbreitung mit Interferenz, Beugung, Reflexion und Brechung. Bewegungen verändern den ankommenden Takt: Die Quelle verändert die Frontabstände, der Empfänger seine Begegnungsrate mit den Fronten. Überholt die Quelle ihre Wellen, bündeln sich die Fronten im Mach-Kegel.
#src[V26, PDF-S. 1–15; K6, S. 196–213; eigene Zusammenfassung.]

#pagebreak(weak: true)
= Kapitel 7 · Wärmelehre <a-7>

#überblick([Kapitel 7 auf einen Blick],
  idee(<a-7-1>, [Wärme braucht Platz.], [Temperatur wird in Kelvin gezählt; Stoffe dehnen sich proportional zu ΔT aus.]),
  idee(<a-7-2>, [Druck, Volumen und Temperatur hängen zusammen.], [Für das ideale Gas gilt $P V=n R T$.]),
  idee(<a-7-3>, [Temperatur ist Teilchenbewegung.], [Der 1. Hauptsatz bilanziert Wärme und Arbeit als Änderung der inneren Energie.]),
  idee(<a-7-4>, [Phasenwechsel schlucken Wärme ohne Temperaturänderung.], [Schmelzen und Verdampfen brauchen latente Wärme.]),
  idee(<a-7-5>, [Kreisprozesse wandeln Wärme in Arbeit.], [Der Carnot-Wirkungsgrad ist die Obergrenze; rückwärts entsteht eine Wärmepumpe.]),
  idee(<a-7-6>, [Wärme fließt auf drei Wegen.], [Leitung, Konvektion und Strahlung.]),
)

#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Temperatur], [Kelvin · Ausdehnung · Messung], ziel: <a-7-1>),
  pfeil(beschriftung: [im Gas verknüpft mit P, V]),
  chunk([Ideales Gas], [Boyle · Gay-Lussac · PV = nRT], ziel: <a-7-2>),
  pfeil(beschriftung: [Teilchenbild erklärt]),
  chunk([Energie], [Ekin · Wärme · Arbeit · 1. Hauptsatz], ziel: <a-7-3>),
)
#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Wärmekapazität], [ΔQ = mcΔT · Mischung · Phasen], ziel: <a-7-3-4>),
  pfeil(beschriftung: [Gas im Zylinder]),
  chunk([Zustandsänderungen], [isotherm · isobar · isochor · adiabat], ziel: <a-7-5-1>),
  pfeil(beschriftung: [im Kreis gefahren]),
  chunk([Wärmekraftmaschine], [Carnot · Wärmepumpe · Stirling], ziel: <a-7-5-2>),
)
#karte((1fr, auto, 1fr),
  chunk([Temperaturunterschied], [treibt jeden Wärmestrom an], ziel: <a-7-3-2>),
  pfeil(beschriftung: [transportiert durch]),
  chunk([Wärmetransport], [Leitung · Konvektion · Strahlung], ziel: <a-7-6>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])

Wir betrachten jetzt Systeme aus sehr vielen Teilchen, vor allem Gase. Einzelne Teilchenbahnen interessieren nicht mehr; wir beschreiben das Ganze durch Zustandsgrößen wie Temperatur, Druck und Volumen. Danach fragen wir, wie Wärme und Arbeit diese Größen ändern und wie eine Maschine daraus Nutzarbeit gewinnt.
#src[K7, S. 215; eigene Einleitung.]

== 7.1 Temperatur und Ausdehnung · Wärme braucht Platz <a-7-1>
Die *Celsius-Skala* hängt an zwei Fixpunkten des Wassers bei Normaldruck: Gefrieren bei 0 °C, Sieden bei 100 °C. Die *Kelvin-Skala* beginnt am absoluten Nullpunkt und kennt keine negativen Werte. Ein Kelvin Temperaturunterschied ist genauso groß wie ein Grad Celsius. Seit 2019 ist das Kelvin über die Boltzmann-Konstante festgelegt.
#form[$ T/"K"=vartheta/"°C"+"273,15", quad k_B="1,380649" dot 10^(-23) thin "J/K" quad "(exakt)" $]

Fast alle Stoffe dehnen sich beim Erwärmen aus: Die Teilchen bewegen sich stärker und brauchen mehr Platz. Für einen Stab der Länge $L$ und einen Körper des Volumens $V$ gilt:
#form[$ Delta L=alpha L Delta T, quad Delta V=gamma V Delta T, quad gamma=3 alpha " (isotrop)" $]
$alpha$ ist der Längen-, $gamma$ der Volumenausdehnungskoeffizient, beide in 1/K. Weil nur eine *Temperaturdifferenz* vorkommt, darfst du sie in K oder °C einsetzen.

#tab(columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
 th([Stahl], [Alu], [Kupfer], [Hartgummi], [Beton], [Holz]),
 [1–1,6], [2,38], [1,68], [7,5], [1,2], [0,8],
)
Werte für $alpha$ in $10^(-5)$ 1/K nach der Folie.

*Eigenes Zahlenbeispiel:* Eine 100 m lange Betonbrücke erwärmt sich vom Winter zum Sommer um 40 K. Sie wird $Delta L="1,2" dot 10^(-5) dot 100 dot 40 thin "m"="4,8" thin "cm"$ länger. Deshalb brauchen Brücken Dehnungsfugen; Hochspannungsleitungen hängen im Sommer stärker durch.
#bild("bimetall-quelle", [Bimetallstreifen verbiegt sich beim Erwärmen und öffnet einen Kontakt. K7, S. 218, Abb. 7.2.], height: 30mm)
#note("Gültigkeit", [$gamma=3alpha$ gilt nur für isotrope Stoffe ohne Vorzugsrichtung, etwa Stahl oder Glas, nicht für Holz. Die lineare Formel ist eine Näherung für nicht zu große Temperaturänderungen. Gase dehnen sich bei konstantem Druck viel stärker aus; dafür gilt das Gasgesetz aus 7.2.], fill: sand)
#src[K7, S. 215–218, Gl. 7.1–7.3, Abb. 7.2; FS, K7.1–K7.6. Zahlenbeispiel: eigene Ergänzung.]

=== 7.1.1 Temperatur messen <a-7-1-1>
Ein Thermometer nutzt eine Größe, die sich mit der Temperatur ändert. Die Folie nennt vier Prinzipien:

#tab(columns: (1.2fr, 2.4fr),
 th([Prinzip], [Was sich ändert]),
 [Ausdehnung], [Flüssigkeitssäule im Glas; Bimetallspirale dreht einen Zeiger],
 [Widerstand], [Bei Metallen steigt, bei Halbleitern sinkt der Widerstand mit der Temperatur],
 [Thermoelement], [Zwei verbundene Metalle liefern eine Thermospannung $U=epsilon_(12)(T_1-T_2)$],
 [Pyrometer], [Die Farbzusammensetzung der Wärmestrahlung verrät über das Wiensche Gesetz die Temperatur (7.6.3)],
)
#bild("thermoelement-quelle", [Thermoelement mit Mess- und Vergleichsstelle. K7, S. 219.], height: 28mm)
*Eigenes Zahlenbeispiel:* Ein Kupfer-Konstantan-Element hat $epsilon_(12)=42 thin "µV/K"$. Ist die Messstelle 100 K wärmer als die Vergleichsstelle, misst man $U=42 dot 10^(-6) dot 100 thin "V"="4,2" thin "mV"$. Ein Thermoelement misst also immer eine *Temperaturdifferenz*.
#src[K7, S. 218–219. Zahlenbeispiel und Hinweis auf die Differenz: eigene Ergänzung.]
#hoch(<a-7>, [Kapitelübersicht])


== 7.2 Ideales Gas · Druck, Volumen und Temperatur hängen zusammen <a-7-2>
Gase lassen sich leicht zusammendrücken. Deshalb musst du beim Erwärmen eines Gases Druck $P$, Volumen $V$ und Temperatur $T$ gemeinsam betrachten. Das Modell *ideales Gas* setzt voraus: punktförmige Teilchen ohne Eigenvolumen, völlig zufällige Bewegung und nur elastische Stöße. Es passt gut, solange der Druck nicht zu hoch ist.

=== 7.2.1 Boyle-Mariotte und Gay-Lussac <a-7-2-1>
#grid(columns: (1fr, 1fr), column-gutter: 4mm,
  bild("boyle-quelle", [Boyle-Mariotte: $T$ konstant. K7, S. 221.], height: 30mm),
  bild("gaylussac-quelle", [Gay-Lussac: $P$ konstant. K7, S. 221.], height: 30mm),
)
#form[$ P V="konst." " bei " T="konst.", quad V/T="konst." " bei " P="konst.", quad (P V)/T="konst." $]
Bei Boyle-Mariotte halbiert doppelter Druck das Volumen. Bei Gay-Lussac wächst das Volumen proportional zur *Kelvin*-Temperatur. Daraus folgt schon der absolute Nullpunkt: Bei $T=0$ müsste $V=0$ werden; ein negatives Volumen gibt es nicht. Die Kombination beider Gesetze in zwei Schritten liefert $P V/T="konst."$
#src[K7, S. 220–222, Gl. 7.4–7.6; FS, K7.7–K7.10.]

=== 7.2.2 Mol und ideales Gasgesetz <a-7-2-2>
Die Konstante in $P V/T$ hängt von der Teilchenzahl ab. Gezählt wird in *Mol*: Ein Mol enthält genau $N_A$ Teilchen. Die molare Masse sagt, wie viel ein Mol wiegt; sie folgt aus dem Periodensystem, etwa 18 g/mol für Wasser.
#form[$ N_A="6,02214076" dot 10^(23) thin "1/mol", quad m_"mol"=m/n, quad V_m="22,41383" thin "l/mol" $]
$V_m$ ist das Molvolumen jedes idealen Gases bei 273,15 K und 1013,25 hPa. Setzt man diese Normalbedingungen in $P V/T$ ein, erhält man die universelle Gaskonstante und das *ideale Gasgesetz*:
#form[$ R="8,31441" thin "J/(mol K)", quad P V=n R T $]

#tab(columns: (0.7fr, 1.6fr, 1fr),
 th([Größe], [Bedeutung], [SI-Einheit]),
 [$P$], [Druck, absolut], [Pa],
 [$V$], [Volumen], [m³],
 [$n$], [Stoffmenge], [mol],
 [$T$], [Temperatur], [K],
 [$R$], [universelle Gaskonstante], [J/(mol K)],
)
*Beispiel aus der Vorlesung:* 1 l Wasser sind $1000/18 thin "mol" approx "55,56" thin "mol"$. Als ideales Gas bei 1013 hPa und 20 °C nähme das $V=n R T/P approx "1,336" thin "m³"$ ein: aus 1 l Wasser werden rund 1336 l Dampf.
#bild("map-gasgesetz", [Mindmap zum idealen Gas. Eigene Darstellung nach K7, S. 220–225.], height: 46mm)
#note("Fehler vermeiden", [Im Gasgesetz steht die *Kelvin*-Temperatur und der *absolute* Druck. Ein Reifen- oder Flaschenmanometer zeigt meist den Überdruck an; addiere dann den Umgebungsdruck von etwa 1 bar. Liter in m³ umrechnen: $1 thin "l"=10^(-3) thin "m³"$.], fill: sand)
#note("Präzisierung der Vorlage", [Wasserdampf bei 20 °C und 1013 hPa ist kein stabiler Zustand, denn Wasser siedet bei diesem Druck erst bei 100 °C. Das Beispiel zeigt die Größenordnung des Volumensprungs im Modell des idealen Gases; bei 100 °C wären es rund 1700 l (*eigene Nachrechnung* mit $T="373,15" thin "K"$).], fill: sand)
*Anwendungen aus der Vorlesung:* Beim Pumpen wird die Luft komprimiert und warm; eine Spraydose kühlt beim Ausströmen ab; im Heißluftballon sinkt die Dichte der erhitzten Luft, sodass der Auftrieb die Gewichtskraft übersteigt; Klimaanlage und Kühlschrank expandieren und komprimieren ein umlaufendes Gas.
#src[K7, S. 223–226, Gl. 7.7–7.11; FS, K7.11–K7.15; Ü11, Aufg. 4–5 zum Überdruck. Präzisierung und Nachrechnung: eigene Ergänzung.]
#hoch(<a-7>, [Kapitelübersicht])


== 7.3 Wärmeenergie · Temperatur ist Teilchenbewegung <a-7-3>
Was misst ein Thermometer eigentlich? Die kinetische Gastheorie gibt die Antwort: die mittlere Bewegungsenergie der Teilchen. Darauf baut die Energiebilanz der Wärmelehre auf.

=== 7.3.1 Kinetische Gastheorie <a-7-3-1>
#bild("gaswuerfel-quelle", [Würfelmodell: Gasteilchen fliegen entlang der Kanten. K7, S. 227.], height: 34mm)
*Modell:* $N$ Teilchen fliegen mit der mittleren Geschwindigkeit $v$ in einem Würfel der Kantenlänge $L$; je ein Sechstel bewegt sich auf eine Wand zu. Bei jedem elastischen Stoß gibt ein Teilchen den Impuls $2 m v$ an die Wand ab, und zwar einmal pro Laufzeit $L/v$. So entsteht der Druck $P=N/6 dot 2 m v^2/V$. Der Vergleich mit $P V=n R T$ ergibt:
#form[$ E_"kin"=3/2 k_B T, quad k_B=R/N_A $]
*Kernaussage:* Die Temperatur ist ein Maß für die mittlere kinetische Energie eines Teilchens. *Eigenes Zahlenbeispiel:* Bei 300 K trägt ein Gasteilchen im Mittel $E_"kin"="1,5" dot "1,38" dot 10^(-23) dot 300 thin "J" approx "6,2" dot 10^(-21) thin "J"$.

Der Faktor 3 stammt aus den drei Raumrichtungen, den *Freiheitsgraden* der Translation. Mehratomige Moleküle können zusätzlich rotieren und bei höheren Temperaturen schwingen:
#form[$ E_"kin"=f/2 k_B T $]
#bild("freiheitsgrade-quelle", [Translation (a), Rotationen (b, c) und Schwingungen (d, e). K7, S. 229, Abb. 7.3.], height: 22mm)
#tab(columns: (1.6fr, 1fr, 2fr),
 th([Teilchen], [$f$], [Beispiel]),
 [einatomig], [3], [Helium],
 [zweiatomig, ohne Schwingung], [5], [Sauerstoff, Stickstoff ($kappa=7/5$, siehe 7.5.1)],
 [Festkörper (Dulong-Petit)], [6], [3 Schwingungen, je kinetisch und potentiell],
)
#note("Quellenfehler sichtbar korrigiert", [Gl. 7.12 nennt $k_B="1,380622" dot 10^(-23) thin "J/K"$, ein älterer Wert. Auf S. 216 steht der seit 2019 exakte Wert $"1,380649" dot 10^(-23) thin "J/K"$. Für Rechnungen sind beide gleichwertig; als Definition gilt der neue Wert.], fill: sand)
#note("Präzisierung der Tabelle", [Dass zweiatomige Gase bei Raumtemperatur $f=5$ haben, folgt aus dem in 7.5.1 genannten Adiabatenexponenten $kappa=7/5$ für Sauerstoff über $kappa=(f+2)/f$ (*eigene Folgerung*).], fill: sand)
#src[K7, S. 227–229, Gl. 7.12–7.13, Abb. 7.3; FS, K7.16–K7.17. Zahlenbeispiel und Zuordnung von f: eigene Ergänzungen.]

=== 7.3.2 Wärme, innere Energie und Volumenarbeit <a-7-3-2>
*Wärme* $Q$ ist die Energie, die wegen eines Temperaturunterschieds übertragen wird, vom wärmeren zum kälteren System. Die *innere Energie* $U$ ist hier die Bewegungsenergie aller Teilchen, also der Anteil, der sich durch Wärme ändern lässt. Nach 7.3.1 gilt deshalb $Delta U prop Delta T$.

Schiebt man einen Kolben in den Zylinder, verrichtet man am Gas *Volumenarbeit*:
#bild("kolben-quelle", [Gas mit beweglichem Kolben. K7, S. 231.], height: 30mm)
#form[$ Delta W=-P Delta V, quad W_(12)=-integral_(V_1)^(V_2) P(V) dif V $]
#tab(columns: (1fr, 1fr, 2fr),
 th([Vorgang], [$Delta V$], [Vorzeichen von $W$ (Sicht des Gases)]),
 [Kompression], [$<0$], [$W>0$: Energie wird dem Gas zugeführt],
 [Expansion], [$>0$], [$W<0$: Das Gas leistet Arbeit],
)
#note("Fehler vermeiden", [Die Vorlesung zählt Arbeit und Wärme aus Sicht des Gases: Was dem Gas zugeführt wird, ist positiv. Manche Lehrbücher zählen die vom Gas *geleistete* Arbeit positiv; dann kehrt sich das Vorzeichen um. Bleib in einer Aufgabe bei einer Konvention.], fill: sand)
#src[K7, S. 230–232, Gl. 7.14–7.16.]

=== 7.3.3 Der erste Hauptsatz <a-7-3-3>
Der Energieerhaltungssatz der Mechanik wird um die Wärme erweitert. Die innere Energie eines Systems ändert sich nur durch Austausch mit der Umgebung, als Wärme oder als Arbeit:
#form[$ Delta U=Delta Q+Delta W $]
Gleichwertig: Es gibt kein *Perpetuum mobile erster Art*, also keine Maschine, die dauernd Arbeit leistet, ohne Energie von außen aufzunehmen.
#bild("perpetuum-quelle", [Motor treibt Generator, der den Motor speist, und ein Propeller soll zusätzlich Nutzarbeit liefern. K7, S. 233, Abb. 7.4.], height: 26mm)
*Bild lesen in eigenen Worten:* Damit der Wagen fährt, müssten Motor und Generator zusammen mehr als 100 % Wirkungsgrad haben. Das verbietet der erste Hauptsatz.
#bild("map-hauptsatz", [Mindmap zum ersten Hauptsatz. Eigene Darstellung nach K7, S. 230–233.], height: 46mm)
#src[K7, S. 232–233, Gl. 7.17, Abb. 7.4.]

=== 7.3.4 Wärmekapazität und Wärmemischung <a-7-3-4>
Wie stark steigt die Temperatur, wenn man Wärme zuführt? Das sagt die *Wärmekapazität* $C$, das „Wärmespeichervermögen“. Auf die Masse bezogen wird daraus eine Materialkonstante, die *spezifische Wärmekapazität* $c$:
#form[$ Delta Q=C Delta T, quad c=C/m, quad Delta Q=m c Delta T, quad Delta Q=n c_m Delta T $]
#tab(columns: (1fr, 1fr, 1fr, 1fr, 1fr),
 th([Holz], [Stahl], [Kupfer], [Wasser], [Luft]),
 [1400–2400], [500], [385], [4200], [1000],
)
Werte für $c$ in J/(kg K) nach der Folie. Wasser speichert besonders viel Wärme; deshalb steckt es in Heizung, Warmwasserspeicher und Autokühler. Daher kommt auch die alte Einheit: $1 thin "cal"="4,2" thin "J"$ erwärmt 1 g Wasser um 1 K. Übungsblatt 11 rechnet mit $c_W="4,18" thin "kJ/(kg K)"$; nimm jeweils den Wert der Aufgabe.

*Wärmemischung:* Bringst du Körper unterschiedlicher Temperatur zusammen, gibt der warme genau so viel Wärme ab, wie der kalte aufnimmt, wenn nichts nach außen verloren geht. Aus $sum m_i c_i (T_"end"-T_i)=0$ folgt:
#form[$ T_"end"=(m_1 c_1 T_1+m_2 c_2 T_2+dots)/(m_1 c_1+m_2 c_2+dots) $]
#bild("mischung-quelle", [Zwei Körper gleichen ihre Temperaturen aus. K7, S. 235, Abb. 7.5.], height: 20mm)
Die Formel ist ein gewichteter Mittelwert: Jeder Körper zählt mit seinem $m c$. Du darfst Celsius einsetzen, weil sich die Verschiebung um 273,15 auf beiden Seiten aufhebt.
#note("Quellenfehler sichtbar korrigiert", [Das Beispiel auf S. 236 wirft 100 g *Aluminium* (350 °C) in 1 l Wasser (20 °C), rechnet aber mit $c_"Cu"=385 thin "J/(kg K)"$ und erhält 23 °C. Mit dem Tabellenwert für Aluminium, $c_"Al"=897 thin "J/(kg K)"$ (S. 241), ergibt sich $T_"end"=("0,1" dot 897 dot 350+1 dot 4200 dot 20)/("0,1" dot 897+4200) thin "°C" approx "26,9" thin "°C"$ (*eigene Nachrechnung*). Die 23 °C passen zu einem Kupferstück.], fill: sand)
#src[K7, S. 233–236, Gl. 7.18–7.23, Abb. 7.5; FS, K7.18–K7.21; Ü11, Aufg. 8–9. Nachrechnung: eigene Ergänzung.]

=== 7.3.5 Wärmekapazität von Gasen und Festkörpern <a-7-3-5>
Bei einem Gas kommt es darauf an, ob es sich ausdehnen darf.
#tab(columns: (1fr, 2.2fr),
 th([Fall], [Was mit der zugeführten Wärme geschieht]),
 [$V$ konstant], [$Delta W=0$: Die ganze Wärme erhöht $U$ und damit $T$],
 [$P$ konstant], [Ein Teil der Wärme geht in Ausdehnungsarbeit; $T$ steigt weniger],
)
#bild("isobar-erwaermen-quelle", [Isobare Erwärmung: Das Gas hebt den Kolben. K7, S. 239, Abb. 7.7.], height: 30mm)
#form[$ R_s=R/m_"mol", quad c_V=f/2 R_s, quad c_P=c_V+R_s=R_s (f/2+1) $]
#form[$ c_(m,V)=f/2 R, quad c_(m,P)=c_(m,V)+R $]
$R_s$ ist die *spezifische Gaskonstante* in J/(kg K). Weniger Freiheitsgrade bedeuten eine kleinere Wärmekapazität: Dieselbe Wärme heizt dann stärker.

*Festkörper:* Die Atome sitzen fest im Gitter und haben nur noch drei Schwingungsfreiheitsgrade, die je doppelt zählen, also $f=6$. Die Volumenarbeit ist vernachlässigbar. Daraus folgt die Regel von *Dulong-Petit*:
#form[$ c_(m,V)=c_(m,P)=3 R approx "24,9" thin "J/(mol K)" $]
*Beispiel aus der Vorlesung:* Aluminium (27 g/mol) ergibt $c approx 922 thin "J/(kg K)"$, Tabellenwert 897; Kupfer (64 g/mol) ergibt 389, Tabellenwert 385.
#src[K7, S. 237–241, Gl. 7.24–7.29, Abb. 7.7.]
#hoch(<a-7>, [Kapitelübersicht])


== 7.4 Phasenübergänge · Latente Wärme <a-7-4>
Ein Topf mit Eiswasser bleibt bei 0 °C, bis das letzte Eis geschmolzen ist, obwohl die Herdplatte dauernd heizt. Die Wärme bricht Bindungen zwischen den Molekülen auf, statt sie schneller zu machen. Diese „versteckte“ Wärme heißt *latente Wärme*.
#bild("phasen-quelle", [Temperatur über zugeführter Wärme: Plateaus beim Schmelzen und Sieden. K7, S. 242, Abb. 7.9.], height: 44mm)
#tab(columns: (1.3fr, 1.3fr, 2fr),
 th([Übergang], [Rückweg], [Wärme]),
 [Schmelzen], [Erstarren], [Schmelzwärme; beim Erstarren wieder frei],
 [Verdampfen], [Kondensieren], [Verdampfungswärme; beim Kondensieren wieder frei],
 [Sublimieren], [Resublimieren], [Summe aus Schmelz- und Verdampfungswärme],
)
#form[$ Delta Q=q_S m " (Schmelzen)", quad Delta Q=q_V m " (Verdampfen)" $]
Für Wasser bei Normaldruck: $q_S="333,5" thin "kJ/kg"$, $q_V=2257 thin "kJ/kg"$. Zum Vergleich: 1 kg Wasser von 0 °C auf 100 °C zu erwärmen kostet nur 420 kJ.

*Eigenes Zahlenbeispiel:* 1 kg Eis von 0 °C vollständig zu Dampf von 100 °C: $"333,5"+420+2257 approx 3011 thin "kJ"$. Drei Viertel davon stecken im Verdampfen.
#note("Fehler vermeiden", [Während eines Phasenübergangs gilt *nicht* $Delta Q=m c Delta T$, denn $Delta T=0$. Rechne die Abschnitte getrennt: erwärmen, umwandeln, weiter erwärmen. Die Formelsammlung schreibt $Delta Q=q_S m$ (FS, K7.19); Übungsblatt 11 rundet auf 334 kJ/kg.], fill: sand)
#src[K7, S. 242–243, Abb. 7.9; Ü11, Aufg. 9; FS, K7.19. Zahlenbeispiel: eigene Ergänzung.]
#hoch(<a-7>, [Kapitelübersicht])


== 7.5 Zustandsänderungen und Kreisprozesse <a-7-5>
Eine Wärmekraftmaschine führt ein Gas immer wieder durch dieselbe Folge von Zuständen. Dafür brauchen wir zuerst vier besonders einfache Zustandsänderungen. Arbeit und Wärme zählen wie in 7.3.2 aus Sicht des Gases.

=== 7.5.1 Vier spezielle Zustandsänderungen <a-7-5-1>
#grid(columns: (1fr, 1fr), column-gutter: 4mm,
  bild("isotherme-quelle", [Isotherme Kompression im Wärmebad. K7, S. 244, Abb. 7.10.], height: 30mm),
  bild("isobare-quelle", [Isobare Erwärmung. K7, S. 246, Abb. 7.11.], height: 30mm),
)
#grid(columns: (1fr, 1fr), column-gutter: 4mm,
  bild("isochore-quelle", [Isochore Erwärmung. K7, S. 247, Abb. 7.12.], height: 30mm),
  bild("adiabate-quelle", [Adiabate im Vergleich zur Isotherme. K7, S. 247, Abb. 7.13.], height: 30mm),
)
#tab(columns: (0.9fr, 0.9fr, 1.6fr, 1.7fr),
 th([Änderung], [Bedingung], [Arbeit $W_(12)$], [Wärme $Q_(12)$]),
 [Isotherm], [$T$ konstant], [$n R T ln(V_1/V_2)$], [$-n R T ln(V_1/V_2)$, denn $Delta U=0$],
 [Isobar], [$P$ konstant], [$-P(V_2-V_1)$], [$c_V m(T_2-T_1)+P(V_2-V_1)$],
 [Isochor], [$V$ konstant], [$0$], [$c_V m(T_2-T_1)$],
 [Adiabatisch], [$Delta Q=0$], [$Delta U=c_V m(T_2-T_1)$], [$0$],
)
Im P-V-Diagramm ist die Isotherme eine Hyperbel, die Isobare waagerecht, die Isochore senkrecht. Die Fläche unter der Kurve ist der Betrag der Volumenarbeit.

*Adiabatisch* heißt: kein Wärmeaustausch, weil das Gefäß isoliert ist oder der Vorgang zu schnell für den Wärmefluss abläuft. Dann gelten die Adiabatengleichungen mit dem *Adiabatenexponenten* $kappa$:
#form[$ kappa=c_P/c_V=(f+2)/f, quad T V^(kappa-1)="konst.", quad P V^kappa="konst.", quad T P^(1/kappa-1)="konst." $]
Für Helium ist $kappa=5/3$, für Sauerstoff $7/5$. Wegen $kappa>1$ fällt die Adiabate steiler als die Isotherme.

*Eigenes Zahlenbeispiel:* Luft ($kappa="1,4"$) mit 20 °C wird in einem Motorzylinder schnell auf ein Zehntel ihres Volumens komprimiert: $T_2=293 dot 10^("0,4") thin "K" approx 736 thin "K" approx 463 thin "°C"$. Darauf beruht die Selbstzündung im Dieselmotor.

*Beispiele aus der Vorlesung:* Fahrradpumpe wird heiß; beim Öffnen einer Sektflasche entsteht Nebel; Kompression im Verbrennungsmotor; aufsteigende Luft kühlt ab, deshalb ist es am Berg kälter.
#note("Fehler vermeiden", [In $ln(V_1/V_2)$ ist das Minuszeichen aus Gl. 7.16 schon eingerechnet: Bei Kompression ist $V_1>V_2$ und $W>0$. Setze in alle vier Formeln Kelvin ein. Die Adiabatengleichungen gelten nur für langsame, reibungsfreie Änderungen des idealen Gases.], fill: sand)
#src[K7, S. 244–250, Gl. 7.30–7.39, Abb. 7.10–7.13. Dieselbeispiel: eigene Ergänzung.]

=== 7.5.2 Kreisprozess und Carnot-Prozess <a-7-5-2>
Kehrt das Gas nach mehreren Zustandsänderungen in seinen Anfangszustand zurück, beschreibt es eine geschlossene Kurve: einen *Kreisprozess*. Die eingeschlossene Fläche ist die Nutzarbeit eines Umlaufs.
#bild("kreisprozess-quelle", [Erfundener Kreisprozess; die grüne Fläche ist die Nutzarbeit. K7, S. 251, Abb. 7.14.], height: 36mm)
Der *Carnot-Prozess* besteht aus zwei Isothermen und zwei Adiabaten. Er ist technisch nicht umsetzbar, setzt aber die Obergrenze für jede Wärmekraftmaschine.
#bild("carnot-quelle", [Carnot-Prozess im P-V-Diagramm. K7, S. 252, Abb. 7.15.], height: 46mm)
#bild("carnot-schritte-quelle", [Die vier Schritte im Zylinder. K7, S. 252, Abb. 7.16.], height: 22mm)
#tab(columns: (0.7fr, 1.6fr, 1.8fr),
 th([Schritt], [Vorgang], [Energie]),
 [1 → 2], [isotherme Expansion bei $T_1$], [nimmt Wärme $Q_(12)$ aus dem heißen Bad auf, leistet Arbeit],
 [2 → 3], [adiabatische Expansion], [kühlt von $T_1$ auf $T_2$, leistet Arbeit],
 [3 → 4], [isotherme Kompression bei $T_2$], [gibt Wärme an das kalte Bad ab],
 [4 → 1], [adiabatische Kompression], [heizt von $T_2$ auf $T_1$],
)
Die adiabatischen Arbeiten heben sich auf. Aus den Adiabatengleichungen folgt $V_3/V_2=V_4/V_1$, und es bleibt $W_"netto"=n R ln(V_1/V_2)(T_1-T_2)<0$: Das Gas leistet Arbeit, die Maschine läuft. Der Wirkungsgrad ist Nutzen durch Aufwand:
#form[$ eta_C=abs(W_"netto"/Q_(12))=(T_"heiß"-T_"kalt")/T_"heiß" quad (T "in K") $]
*Vergleich aus der Vorlesung:* Wie ein Wasserkraftwerk Wasser von oben nach unten fließen lässt, nutzt die Maschine den natürlichen Wärmefluss von heiß nach kalt. *Eigenes Zahlenbeispiel:* Zwischen 600 K und 300 K lässt sich höchstens die Hälfte der aufgenommenen Wärme in Arbeit umwandeln.
#bild("map-kreisprozess", [Mindmap zum Kreisprozess. Eigene Darstellung nach K7, S. 251–257.], height: 46mm)
#src[K7, S. 251–255, Gl. 7.40, Abb. 7.14–7.16. Zahlenbeispiel: eigene Ergänzung.]

=== 7.5.3 Wärmepumpe und Kältemaschine <a-7-5-3>
Läuft der Carnot-Prozess linksherum, muss man Arbeit hineinstecken; dafür wird Wärme vom kalten zum warmen Reservoir „gepumpt“.
#bild("blockdiagramm-quelle", [Wärmekraftmaschine (a) und Wärmepumpe (b) im Blockdiagramm. K7, S. 256, Abb. 7.17.], height: 28mm)
#form[$ epsilon_"WP"=Q_"zu"/W=T_"heiß"/(T_"heiß"-T_"kalt")=1/eta_C, quad epsilon_"KM"=Q_"ab"/W=T_"kalt"/(T_"heiß"-T_"kalt") $]
Bei der Wärmepumpe ist die ins Haus gelieferte Wärme der Nutzen, bei der Kältemaschine die dem Kühlraum entzogene. Beide *Leistungszahlen* sind größer als eins.

*Eigenes Zahlenbeispiel:* Eine ideale Wärmepumpe holt Wärme aus 0 °C kalter Luft und heizt Wasser auf 35 °C. $epsilon_"WP"="308,15"/35 approx "8,8"$: Aus 1 kJ Strom werden bis zu 8,8 kJ Heizwärme. Je kleiner der Temperaturhub, desto besser.
#note("Präzisierung der Vorlage", [Die Folie schreibt die Leistungszahlen mit $eta$. Sie sind aber keine Wirkungsgrade, denn sie dürfen größer als 1 sein. Hier steht deshalb $epsilon$. Es wird keine Energie erzeugt: Die zusätzliche Wärme kommt aus dem kalten Reservoir.], fill: sand)
#src[K7, S. 256–257, Gl. 7.41–7.42, Abb. 7.17. Zahlenbeispiel und Symbolwahl: eigene Ergänzung.]

=== 7.5.4 Stirling-Prozess <a-7-5-4>
Der Stirling-Motor ist ein real gebauter Kreisprozess: zwei Isothermen und zwei *Isochoren*. Beim isochoren Umpumpen läuft das Gas durch einen *Regenerator*, einen Wärmespeicher, der die Wärme aus Schritt 2 → 3 in Schritt 4 → 1 zurückgibt.
#bild("stirling-quelle", [Stirling-Prozess (a) und Alpha-Motor mit Regenerator (b). K7, S. 258, Abb. 7.18.], height: 46mm)
Mit Regenerator muss nur in Schritt 1 → 2 Wärme von außen zugeführt werden, und der Wirkungsgrad erreicht den Carnot-Wert:
#form[$ eta_"Stirling"=(T_"heiß"-T_"kalt")/T_"heiß" quad "(mit Regenerator)" $]
Ohne Regenerator kommt $Q_(41)$ zum Aufwand hinzu, und der Wirkungsgrad sinkt. Bauformen: *Alpha* mit zwei Arbeitskolben, *Beta* mit Arbeits- und Verdrängerkolben in einem Zylinder, *Gamma* mit zwei verbundenen Zylindern. Einsatz: kleine Blockheizkraftwerke mit Kraft-Wärme-Kopplung.
#src[K7, S. 258–261, Gl. 7.43, Abb. 7.18–7.19.]
#hoch(<a-7>, [Kapitelübersicht])


== 7.6 Wärmetransport · Drei Wege für die Wärme <a-7-6>
Wärme fließt von selbst immer von warm nach kalt. *Wie* sie dorthin gelangt, unterscheidet drei Mechanismen.

=== 7.6.1 Wärmeleitung <a-7-6-1>
Wärmeleitung transportiert Energie durch ein ruhendes Medium, von Teilchen zu Teilchen, ohne dass Material mitwandert. Zwischen einem heißen und einem kalten Körper stellt sich ein konstanter *Wärmestrom* ein:
#bild("waermeleitung-quelle", [Wärmeleiter der Länge $L$ und Querschnittsfläche $A$. K7, S. 262, Abb. 7.20.], height: 28mm)
#form[$ dot(Q)=(Delta Q)/(Delta t), quad dot(Q)=(lambda A)/L (T_"heiß"-T_"kalt") $]
$dot(Q)$ ist eine Leistung in W, $lambda$ die Wärmeleitfähigkeit in W/(m K).
#tab(columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
 th([Stahl], [Alu], [Kupfer], [Holz], [Luft], [Schaumstoff]),
 [40–50], [220], [380], [0,1], [0,026], [0,04],
)
*Ohmsches Gesetz der Wärmeleitung:* Der Wärmestrom entspricht dem elektrischen Strom, die Temperaturdifferenz der Spannung. Damit kannst du Wärmewiderstände wie in der Elektrotechnik verschalten:
#form[$ dot(Q)=(Delta T)/R_"th", quad R_"th"=L/(lambda A), quad R_"ges"=R_1+R_2+dots " (Serie)", quad 1/R_"ges"=1/R_1+1/R_2+dots " (parallel)" $]
#bild("netzwerk-quelle", [Serien- (a) und Parallelschaltung (b) von Wärmewiderständen. K7, S. 264, Abb. 7.21.], height: 22mm)
In Serie fließt durch alle Widerstände derselbe Wärmestrom, an jedem fällt $Delta T_i=R_i dot(Q)$ ab. Parallel liegt an allen dieselbe Temperaturdifferenz.

*Eigenes Zahlenbeispiel:* Eine Holzplatte, 1 m² groß und 2 cm dick, trennt 20 K Temperaturunterschied. $R_"th"="0,02"/("0,1" dot 1) thin "K/W"="0,2" thin "K/W"$, also $dot(Q)=20/"0,2" thin "W"=100 thin "W"$.
#note("Quellenfehler sichtbar korrigiert", [Die Folie nennt die Definition $dot(Q)=Delta Q/Delta t$ (Gl. 7.44) in der Überschrift „Fouriersches Gesetz“ und schreibt danach „mit dem Gleichung 7.44 lautet“. Das Fouriersche Gesetz ist Gl. 7.45; erst sie wird mit $R_"th"$ umgeschrieben.], fill: sand)
#note("Gültigkeit", [Stationärer Fall: Die beiden Temperaturen bleiben konstant, der heiße Körper kühlt nicht ab. Ändern sie sich, braucht man eine Differentialgleichung; die ist nicht Teil der Vorlesung.], fill: sand)
#src[K7, S. 262–265, Gl. 7.44–7.49, Abb. 7.20–7.22. Zahlenbeispiel: eigene Ergänzung.]

=== 7.6.2 Konvektion <a-7-6-2>
Bei Konvektion trägt eine Strömung die Wärme mit: Heizungswasser, Föhn, Golfstrom, aufsteigende Warmluft. Transportiert die Strömung pro Zeit die Masse $Delta m/Delta t$ von $T_1$ nach $T_2$, gilt:
#form[$ dot(Q)=c (Delta m)/(Delta t) (T_1-T_2) $]
#bild("konvektion-quelle", [Ein Fluidpaket trägt Wärme von $T_1$ nach $T_2$. K7, S. 265, Abb. 7.23.], height: 26mm)
*Beispiel aus der Vorlesung:* Pro Stunde fließt 1 m³ Heizungswasser mit 50 °C zu den Heizkörpern und kommt mit 40 °C zurück. $dot(Q)=4200 dot 1000/3600 dot 10 thin "W" approx "11,7" thin "kW"$; so viel muss der Kessel nachliefern.
#src[K7, S. 265–266, Gl. 7.50, Abb. 7.23.]

=== 7.6.3 Wärmestrahlung <a-7-6-3>
Strahlung braucht kein Medium: Die Sonne wärmt uns durch das Vakuum, ein Lagerfeuer über die Luft hinweg. Jeder Körper strahlt elektromagnetische Wellen ab und absorbiert gleichzeitig Strahlung aus der Umgebung:
#form[$ P_E=sigma epsilon A T^4, quad P_"netto"=sigma epsilon A (T_K^4-T_U^4), quad sigma="5,6704" dot 10^(-8) thin "W/(m² K⁴)" $]
$epsilon$ ist der Emissionsgrad zwischen 0 (perfekter Spiegel) und 1 (schwarzer Körper). Emission und Absorption haben denselben Grad: Ein guter Absorber ist auch ein guter Strahler. Die vierte Potenz macht heiße Körper zu sehr starken Strahlern.
#bild("planck-quelle", [Spektren schwarzer Strahler, linear (a) und logarithmisch (b). K7, S. 268, Abb. 7.25.], height: 38mm)
Das Spektrum ist kontinuierlich; sein Maximum wandert mit steigender Temperatur zu kürzeren Wellenlängen (*Wiensches Verschiebungsgesetz*):
#form[$ lambda_"max"=(2898 dot 10^(-6) thin "m K")/T $]
*Beispiele aus der Vorlesung:* Die Sonne strahlt am stärksten bei etwa 500 nm, also ist ihre Oberfläche rund 5796 K heiß. Die Erde mit 288 K (15 °C) strahlt bei etwa 10 µm im Infraroten. Die Atmosphäre lässt das Sonnenlicht durch, hält aber einen Teil der Infrarotstrahlung zurück: der *Treibhauseffekt*.
#bild("treibhaus-quelle", [Treibhauseffekt. K7, S. 270, Abb. 7.26.], height: 40mm)
#note("Quellenfehler sichtbar korrigiert", [Abb. 7.26 beschriftet die Erde mit „15K“ und „1µm“. Der Text rechnet richtig mit 15 °C = 288 K und $lambda approx 10 thin "µm"$. Außerdem „reflektiert“ die Atmosphäre die Wärmestrahlung nicht im Sinne eines Spiegels: Die Gasmoleküle *absorbieren* sie, wie der Text selbst sagt, und strahlen einen Teil zur Erde zurück.], fill: sand)
#bild("map-waermetransport", [Mindmap zum Wärmetransport. Eigene Darstellung nach K7, S. 262–270.], height: 46mm)
#src[K7, S. 266–270, Gl. 7.51–7.53, Abb. 7.24–7.26.]
#hoch(<a-7>, [Kapitelübersicht])

*Der Zusammenhang in Kapitel 7.* Temperatur misst die mittlere Bewegungsenergie der Teilchen. Im idealen Gas verknüpft $P V=n R T$ Druck, Volumen und Temperatur. Der erste Hauptsatz bilanziert, wie Wärme und Arbeit die innere Energie ändern; die Wärmekapazität sagt, wie stark sich dabei die Temperatur bewegt, Phasenübergänge schlucken Wärme ohne Temperaturanstieg. Fährt man ein Gas im Kreis, entsteht Nutzarbeit, höchstens mit dem Carnot-Wirkungsgrad; rückwärts wird daraus eine Wärmepumpe. Wie schnell Wärme fließt, entscheiden Leitung, Konvektion und Strahlung.
#src[K7, S. 215–270; eigene Zusammenfassung.]

#pagebreak(weak: true)
= Kapitel 8 · Optik <a-8>

#überblick([Kapitel 8 auf einen Blick],
  idee(<a-8-0>, [Licht ist eine elektromagnetische Welle.], [Im Medium läuft es langsamer: $c=c_0/n$, die Frequenz bleibt.]),
  idee(<a-8-1>, [Strahlen folgen dem schnellsten Weg.], [Aus Fermat folgen Reflexion und Brechung; Linsen bilden ab mit $1/f=1/g+1/b$.]),
  idee(<a-8-2>, [Instrumente vergrößern den Sehwinkel.], [Lupe, Mikroskop und Fernrohr sind Kombinationen dünner Linsen.]),
  idee(<a-8-3>, [Kohärentes Licht interferiert.], [Wegunterschiede erzeugen Streifen an Doppelspalt und Gitter; der Einzelspalt begrenzt die Schärfe.]),
)

#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Licht], [EM-Welle · Spektrum · $c=c_0/n$], ziel: <a-8-0>),
  pfeil(beschriftung: [Strukturen ≫ λ]),
  chunk([Strahlenoptik], [Fermat · Reflexion · Brechung · Linsen], ziel: <a-8-1>),
  pfeil(beschriftung: [Linsen kombiniert]),
  chunk([Instrumente], [Auge · Lupe · Mikroskop · Fernrohr], ziel: <a-8-2>),
)
#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Licht], [Welle mit λ und Phase], ziel: <a-8-3-1>),
  pfeil(beschriftung: [Strukturen ≈ λ]),
  chunk([Interferenz], [Kohärenz · optische Weglänge · Michelson], ziel: <a-8-3-2>),
  pfeil(beschriftung: [viele Quellen]),
  chunk([Beugung], [Doppelspalt · Gitter · Einzelspalt], ziel: <a-8-3-4>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])

Die Optik ist die Lehre vom Licht. Wir benutzen zwei Modelle: Strahlen, wenn alle Strukturen viel größer als die Wellenlänge sind, und Wellen, wenn Spalte oder Gitter in die Größenordnung der Wellenlänge kommen. Die Wellenoptik baut direkt auf Kapitel 6 auf.
#src[K8, S. 271–273, 302; eigene Einleitung.]

== 8.0 Licht · Drei Modelle, eine Geschwindigkeit <a-8-0>
#bild("optik-gebiete-quelle", [Strahlenoptik (a), Wellenoptik (b) und Quantenoptik (c). K8, S. 271, Abb. 8.1.], height: 34mm)
#tab(columns: (1fr, 1.8fr, 1.6fr),
 th([Modell], [Gilt, wenn …], [Erklärt]),
 [Strahlenoptik], [Strukturen viel größer als $lambda$], [Schatten, Spiegel, Linsen, Instrumente],
 [Wellenoptik], [Strukturen etwa so groß wie $lambda$], [Interferenz, Beugung, Polarisation],
 [Quantenoptik], [sehr geringe Intensität], [Licht als Photonen; Laser, Detektoren],
)
Licht entsteht, wenn ein angeregtes Elektron auf ein tieferes Energieniveau zurückfällt. Die abgegebene Energie bestimmt die Wellenlänge: $Delta E prop 1/lambda$. Sichtbar ist nur der schmale Bereich von etwa 400 nm (violett) bis 700 nm (rot).
#bild("spektrum-quelle", [Elektromagnetisches Spektrum mit dem sichtbaren Bereich. K8, S. 274, Abb. 8.3.], height: 16mm)
Licht braucht kein Medium. Im Vakuum läuft es mit $c_0$, in jedem Medium langsamer. Der *Brechungsindex* $n$ sagt, um welchen Faktor:
#form[$ c_0=299792458 thin "m/s" approx 3 dot 10^8 thin "m/s", quad c_n=c_0/n, quad lambda_n=lambda_0/n $]
Die Frequenz bleibt beim Übergang gleich, wie bei der Brechung in 6.8.5. *Eigenes Zahlenbeispiel:* Rotes Licht mit $lambda_0=600 thin "nm"$ hat $f=5 dot 10^(14) thin "Hz"$; in Wasser ($n="1,33"$) schrumpft die Wellenlänge auf 451 nm.
#src[K8, S. 271–274, Gl. 8.1–8.3, Abb. 8.1 und 8.3. Zahlenbeispiel: eigene Ergänzung.]
#hoch(<a-8>, [Kapitelübersicht])


== 8.1 Strahlenoptik <a-8-1>
=== 8.1.1 Axiome und Fermatsches Prinzip <a-8-1-1>
Die Strahlenoptik beschreibt Licht als unendlich dünne Strahlen und vereinbart vier Axiome:
+ In homogenen Medien sind Lichtstrahlen gerade.
+ Richtungsänderungen gibt es nur an Grenzflächen (Reflexion oder Brechung).
+ Der Strahlengang ist umkehrbar.
+ Strahlen kreuzen sich, ohne sich zu stören.
Dahinter steht das *Fermatsche Prinzip*: Licht nimmt zwischen zwei Punkten den Weg mit der kürzesten Laufzeit.
#bild("fermat-quelle", [Der Rettungsschwimmer läuft am Strand schneller als er schwimmt; der rote Weg ist der schnellste. K8, S. 275.], height: 40mm)
Der schnellste Weg ist nicht der geometrisch kürzeste: Der Schwimmer läuft länger am Strand, wo er schnell ist, und knickt an der Wasserlinie ab. Genau so knickt Licht an einer Grenzfläche.
#src[K8, S. 274–275.]

=== 8.1.2 Reflexion und Hohlspiegel <a-8-1-2>
#bild("reflexion-licht-quelle", [Reflexion am Einfallslot. K8, S. 275.], height: 30mm)
#form[$ alpha_"ein"=alpha_"aus" $]
Beide Winkel werden zum *Einfallslot* gemessen, der Senkrechten auf die Fläche im Auftreffpunkt. Beim *sphärischen Hohlspiegel* ist das Lot jeweils der Radius der Spiegelkugel. Achsenparallele Strahlen treffen sich im Brennpunkt:
#form[$ f=R/2 $]
#bild("hohlspiegel-quelle", [Achsenparallele Strahlen am Hohlspiegel. K8, S. 276.], height: 40mm)
#note("Gültigkeit", [$f=R/2$ gilt nur für achsennahe Strahlen. Achsenferne Strahlen schneiden die Achse näher am Spiegel: *sphärische Aberration* (Kugelformfehler).], fill: sand)
#src[K8, S. 275–276, Gl. 8.4–8.5.]

=== 8.1.3 Brechung, Totalreflexion und Dispersion <a-8-1-3>
Trifft Licht schräg auf eine durchsichtige Grenzfläche, ändert es seine Richtung, weil es im zweiten Medium anders schnell ist. Das *Snelliussche Brechungsgesetz*:
#form[$ n_1 sin(alpha_1)=n_2 sin(alpha_2) $]
#bild("brechung-licht-quelle", [Brechung zum Lot hin beim Übergang ins optisch dichtere Medium. K8, S. 277.], height: 36mm)
Ins optisch dichtere Medium ($n_2>n_1$) wird zum Lot hin gebrochen, ins dünnere vom Lot weg. Mit $n=c_0/c$ ist das dasselbe Gesetz wie $sin(alpha_1)/c_1=sin(alpha_2)/c_2$ aus 6.8.5. Die Folie leitet es aus dem Fermatschen Prinzip ab: Man minimiert die Laufzeit über den Auftreffpunkt.
#tab(columns: (1fr, 1fr, 1fr, 1fr, 1fr),
 th([Vakuum], [Luft], [Wasser], [Glas, Kunststoff], [Diamant]),
 [1], [≈ 1,0003], [1,33], [1,3–2], [2,4],
)

*Totalreflexion:* Von dicht nach dünn wird $alpha_2$ größer als $alpha_1$. Ab dem Grenzwinkel wäre $alpha_2=90°$; darüber kann kein Licht mehr austreten, alles wird reflektiert.
#form[$ alpha_"G"=arcsin(n_2/n_1) quad (n_1>n_2) $]
#bild("totalreflexion-quelle", [Am Grenzwinkel läuft der gebrochene Strahl entlang der Grenzfläche. K8, S. 279.], height: 34mm)
Wasser → Luft: $alpha_G=arcsin(1/"1,33")="48,8"°$. *Eigenes Zahlenbeispiel:* Glas mit $n="1,5"$ → Luft: $alpha_G approx "41,8"°$. Darauf beruhen Lichtleiter.

*Dispersion:* $n$ hängt leicht von der Wellenlänge ab. Weißes Licht wird deshalb aufgefächert; Rot wird am schwächsten, Violett am stärksten gebrochen. So entstehen Regenbogen und Prismenspektrum.
#bild("dispersion-quelle", [Brechungsindex von BK7-Glas (a), aufgefächertes Weißlicht (b), Prisma (c). K8, S. 280, Abb. 8.5.], height: 28mm)
#bild("map-brechung", [Mindmap zur Brechung. Eigene Darstellung nach K8, S. 277–280.], height: 46mm)
#note("Fehler vermeiden", [Winkel immer zum Lot messen, nicht zur Oberfläche. Totalreflexion gibt es nur von optisch dicht nach optisch dünn; liefert die Rechnung $sin(alpha_2)>1$, gibt es keinen gebrochenen Strahl.], fill: sand)
#src[K8, S. 277–280, Gl. 8.6, Abb. 8.4–8.5; FS, K9.3–K9.5. Glasbeispiel: eigene Ergänzung.]

=== 8.1.4 Linsen <a-8-1-4>
Eine *dünne Linse* ist von zwei Kugelflächen begrenzt und dünn im Vergleich zu Radien und Durchmesser. Man ersetzt beide Brechungen durch eine einzige an der Hauptebene. Charakterisiert wird sie allein durch ihre Brennweite $f$; die *Linsenschleiferformel* berechnet sie aus den Radien:
#form[$ 1/f=(n/n_0-1)(1/R_1-1/R_2), quad D=1/f " in dpt"=1/"m" $]
$n$ ist der Brechungsindex der Linse, $n_0$ der der Umgebung, $R_1$ und $R_2$ sind die Radien in der Reihenfolge, in der das Licht die Flächen durchläuft. Ein Radius ist positiv, wenn sein Mittelpunkt auf der Seite der gebrochenen Strahlen liegt.
#bild("linsenschleifer-quelle", [Bezeichnungen für die Linsenschleiferformel. K8, S. 281, Abb. 8.6.], height: 34mm)
*Eigenes Zahlenbeispiel:* Bikonvexe Glaslinse in Luft, $n="1,5"$, $R_1=10 thin "cm"$, $R_2=-10 thin "cm"$: $1/f="0,5" dot (10+10) thin "1/m"=10 thin "dpt"$, also $f=10 thin "cm"$. In Wasser ($n_0="1,33"$) würde dieselbe Linse viel schwächer.
#note("Widerspruch in der Quelle", [Die Bildunterschrift von Abb. 8.6 sagt: „In b): $R_1$ und $R_2$ sind beide negativ.“ Der Text auf S. 282 sagt: „In der Abbildung 8.6 b) ist $R_1>0$, $R_2<0$.“ Beides kann nicht stimmen. Wende die Regel selbst an: Liegt der Krümmungsmittelpunkt auf der Ausgangsseite, ist der Radius positiv. Frage im Zweifel in der Übung nach, welche Lesart gemeint ist.], fill: sand)

#grid(columns: (1fr, 1fr), column-gutter: 4mm,
  bild("sammellinse-quelle", [Sammellinse, $f>0$. K8, S. 283.], height: 32mm),
  bild("zerstreuungslinse-quelle", [Zerstreuungslinse, $f<0$. K8, S. 283.], height: 32mm),
)
Eine *Sammellinse* ($f>0$) bündelt parallele Strahlen im hinteren Brennpunkt $f'$. Eine *Zerstreuungslinse* ($f<0$) lässt sie so auseinanderlaufen, als kämen sie aus einem Punkt vor der Linse; vorderer und hinterer Brennpunkt sind vertauscht. Brillen werden in Dioptrien angegeben: −5 dpt bedeuten $f=-"0,2" thin "m"$.
#src[K8, S. 281–283, Gl. 8.7–8.9, Abb. 8.6; FS (Linsenschleiferformel und Dioptrie fehlen dort). Zahlenbeispiel: eigene Ergänzung.]

=== 8.1.5 Abbildung durch eine dünne Linse <a-8-1-5>
Eine *Abbildung* macht die auseinanderlaufenden Strahlen eines Gegenstandspunkts wieder konvergent, sodass sie sich in einem Bildpunkt treffen. Liegt das Bild auf der anderen Seite der Linse, ist es *reell* und lässt sich auf einem Schirm auffangen. Liegt es auf derselben Seite, ist es *virtuell* und entsteht erst im Auge.

*Konstruktion mit den Hauptstrahlen* (zwei genügen):
#tab(columns: (1.1fr, 1.6fr, 1.6fr),
 th([Hauptstrahl], [Sammellinse], [Zerstreuungslinse]),
 [Parallelstrahl], [wird zum Brennpunktstrahl durch $f'$], [scheint aus $f'$ vor der Linse zu kommen],
 [Mittenstrahl], [läuft ungebrochen weiter], [läuft ungebrochen weiter],
 [Brennpunktstrahl], [durch $f$, danach parallel], [zielt auf $f$, danach parallel],
)
#bild("sammel-konstruktion-quelle", [Reelle Abbildung durch eine Sammellinse. K8, S. 285, Abb. 8.9.], height: 42mm)
#grid(columns: (1fr, 1fr), column-gutter: 4mm,
  bild("lupe-virtuell-quelle", [Gegenstand innerhalb von $f$: virtuelles Bild. K8, S. 286, Abb. 8.10.], height: 32mm),
  bild("zerstreu-konstruktion-quelle", [Zerstreuungslinse: immer virtuell. K8, S. 287, Abb. 8.11.], height: 32mm),
)
Gerechnet wird mit der *Abbildungsgleichung* und dem *Abbildungsmaßstab*:
#form[$ 1/f=1/g+1/b, quad B/G=-b/g $]
#tab(columns: (1.3fr, 1.2fr, 1.2fr),
 th([Größe], [positiv], [negativ]),
 [Brennweite $f$], [Sammellinse], [Zerstreuungslinse],
 [Gegenstandsweite $g$], [immer], [–],
 [Bildweite $b$], [reelles Bild], [virtuelles Bild],
 [Bildgröße $B$], [aufrecht], [kopfstehend],
)
*Beispiel aus der Vorlesung:* Mit einer 5-dpt-Brille ($f="0,2" thin "m"$) soll eine Kerzenflamme scharf auf die 0,5 m entfernte Wand. $g=f b/(b-f)=("0,2" dot "0,5")/"0,3" thin "m"=1/3 thin "m"$ und $B=-"1,5" G$: anderthalbfach vergrößert und kopfstehend.
#note("Quellenfehler sichtbar korrigiert", [Die Aufgabe nennt 5 Dioptrien, die Rechnung beginnt mit „Eine Brille mit 4 Dioptrien hat eine Brennweite von $f=1/5 thin "m"$“. Gerechnet wird richtig mit 5 dpt; „4“ ist ein Tippfehler.], fill: sand)
*Selbst ausprobieren (aus der Vorlesung):* Mit einer Lupe kannst du im dunklen Zimmer eine Kerze an die Wand abbilden (reell, kopfstehend). Hältst du sie nah an einen Gegenstand, siehst du ein vergrößertes, aufrechtes virtuelles Bild.
#bild("map-abbildung", [Mindmap zur Abbildung. Eigene Darstellung nach K8, S. 284–289.], height: 46mm)
#src[K8, S. 284–289, Gl. 8.10–8.11, Abb. 8.7–8.11; FS, K9.6–K9.7.]

=== 8.1.6 Systeme aus dünnen Linsen <a-8-1-6>
Bei mehreren Linsen gehst du Schritt für Schritt vor: Die erste Linse erzeugt ein *Zwischenbild*, das ist der Gegenstand für die zweite Linse.
#bild("linsensystem-quelle", [Zwei Linsen: $f_1=30 thin "mm"$, $f_2=-60 thin "mm"$, Abstand 150 mm. K8, S. 289, Abb. 8.12.], height: 40mm)
*Beispiel aus der Vorlesung:* $G=30 thin "mm"$ bei $g_1=80 thin "mm"$.
#tab(columns: (1.2fr, 2.6fr),
 th([Schritt], [Rechnung]),
 [Linse 1], [$b_1=f_1 g_1/(g_1-f_1)=30 dot 80/50 thin "mm"=48 thin "mm"$; $Z=-G b_1/g_1=-18 thin "mm"$],
 [Abstand], [$g_2=150-48 thin "mm"=102 thin "mm"$],
 [Linse 2], [$b_2=f_2 g_2/(g_2-f_2)=-60 dot 102/162 thin "mm" approx -"37,8" thin "mm"$, virtuell],
 [Endbild], [$B=-Z b_2/g_2 approx -"6,7" thin "mm"$, kopfstehend relativ zu $G$],
)
Liegen Linsen dicht beieinander (Abstand viel kleiner als die Brennweiten), addieren sich ihre Brechkräfte:
#form[$ 1/f_"ges"=1/f_1+1/f_2+dots, quad D_"ges"=D_1+D_2+dots $]
#note("Quellenfehler sichtbar korrigiert", [Gl. 8.12 ist auf der Folie als „$1/f_1+1/f_1$“ gesetzt. Gemeint ist $1/f_1+1/f_2+dots$, wie Gl. 8.13 mit den Dioptrien zeigt.], fill: sand)
#src[K8, S. 289–290, Gl. 8.12–8.13, Abb. 8.12; M, Dünne Linsen.]
#hoch(<a-8>, [Kapitelübersicht])


== 8.2 Optische Instrumente <a-8-2>
=== 8.2.1 Auge und Brille <a-8-2-1>
Das Auge ist ein Ein-Linsen-System mit veränderlicher Brennweite. Ein Ringmuskel verformt die Linse; die Bildweite liegt fest bei etwa 2,5 cm, der Länge des Augapfels. Das Bild auf der Netzhaut steht auf dem Kopf; das Gehirn dreht es um.
#bild("auge-quelle", [Aufbau des Auges. K8, S. 291, Abb. 8.13.], height: 40mm)
#form[$ D_"Auge" approx 40 " bis " 44 thin "dpt", quad s_0=25 thin "cm" " (deutliche Sehweite)" $]
#grid(columns: (1fr, 1fr), column-gutter: 4mm,
  bild("kurzsichtig-quelle", [Kurzsichtigkeit, Korrektur mit Zerstreuungslinse. K8, S. 292, Abb. 8.14.], height: 22mm),
  bild("weitsichtig-quelle", [Weitsichtigkeit, Korrektur mit Sammellinse. K8, S. 293, Abb. 8.15.], height: 22mm),
)
#tab(columns: (1fr, 1.8fr, 1.3fr),
 th([Sehfehler], [Ursache], [Brille]),
 [Kurzsichtig], [Augapfel zu lang oder Linse zu stark: Bild ferner Dinge vor der Netzhaut], [Zerstreuungslinse],
 [Weitsichtig], [Augapfel zu kurz: Bild naher Dinge hinter der Netzhaut], [Sammellinse],
)
*Beispiel aus der Vorlesung:* Der Nahpunkt eines älteren Menschen liegt bei 80 cm. Die Lesebrille soll die Zeitung in $g=25 thin "cm"$ als virtuelles Bild bei $b=-80 thin "cm"$ zeigen: $f=g b/(g+b)=("0,25" dot (-"0,8"))/(-"0,55") thin "m" approx "0,36" thin "m"$, also etwa 2,8 dpt.
#src[K8, S. 291–294, Gl. 8.14, Abb. 8.13–8.15; FS, K9.8.]

=== 8.2.2 Sehwinkel und Lupe <a-8-2-2>
Wie groß uns etwas erscheint, bestimmt der *Sehwinkel*, denn er legt die Bildgröße auf der Netzhaut fest. Ein Instrument vergrößert diesen Winkel:
#form[$ Gamma=tan(epsilon_"mit")/tan(epsilon_"ohne") $]
Ohne Lupe kommst du einem Gegenstand höchstens bis $s_0$ nahe: $tan(epsilon_"ohne")=G/s_0$. Mit Lupe liegt der Gegenstand im Brennpunkt, das Bild entsteht im Unendlichen, und das Auge bleibt entspannt: $tan(epsilon_"mit")=G/f$.
#bild("lupe-quelle", [Sehwinkel ohne (links) und mit Lupe (rechts). K8, S. 295, Abb. 8.16.], height: 22mm)
#form[$ V_L=s_0/f $]
Eine fünffach vergrößernde Lupe hat also $f=25/5 thin "cm"=5 thin "cm"$.
#src[K8, S. 294–295, Gl. 8.15–8.16, Abb. 8.16; FS, K9.9–K9.12.]

=== 8.2.3 Mikroskop <a-8-2-3>
Das *Objektiv* erzeugt ein vergrößertes, reelles Zwischenbild; das *Okular* betrachtet es wie eine Lupe. Die *Tubuslänge* $t$ ist der Abstand zwischen hinterem Objektiv- und vorderem Okularbrennpunkt.
#bild("mikroskop-quelle", [Strahlengang im Mikroskop. K8, S. 296, Abb. 8.17.], height: 34mm)
#form[$ V_M=(s_0 dot t)/(f_"obj" dot f_"ok") $]
*Beispiel aus der Vorlesung:* Zwei Linsen mit je $f=1 thin "cm"$ an den Enden eines 20 cm langen Rohrs: $t=18 thin "cm"$, $V_M=25 dot 18=450$. Das Zwischenbild liegt bei $b=t+f_"obj"=19 thin "cm"$, also $g=b f/(b-f)=19/18 thin "cm" approx "1,06" thin "cm"$, nur 0,6 mm vor dem Objektivbrennpunkt.
#note("Quellenfehler sichtbar korrigiert", [Die Folie schreibt $g=(1 thin "cm" dot 19 thin "cm")/(19 thin "cm")$; das wäre 1 cm. Im Nenner gehört $t=18 thin "cm"$, dann stimmt das angegebene Ergebnis 1,06 cm.], fill: sand)
#src[K8, S. 296–297, Gl. 8.17, Abb. 8.17; FS, K9.13; M, Mikroskop.]

=== 8.2.4 Fernrohre, Kamera und Projektor <a-8-2-4>
Beim Fernrohr ist der Gegenstand praktisch unendlich weit weg. Das Objektiv bildet ihn deshalb in seine Brennebene ab, und dort liegt zugleich der Brennpunkt des Okulars.
#bild("kepler-quelle", [Kepler-Fernrohr: Zwischenbild im gemeinsamen Brennpunkt. K8, S. 298, Abb. 8.18.], height: 26mm)
#bild("galilei-quelle", [Galilei-Fernrohr mit Zerstreuungslinse als Okular. K8, S. 300, Abb. 8.19.], height: 30mm)
#tab(columns: (1fr, 1.2fr, 1.2fr, 1.4fr),
 th([Typ], [Okular], [Vergrößerung], [Baulänge, Bild]),
 [Kepler (astronomisch)], [Sammellinse], [$V_T=f_"obj"/f_"ok"$], [$L=f_"obj"+f_"ok"$; kopfstehend],
 [Galilei (terrestrisch)], [Zerstreuungslinse], [$V_T=f_"obj"/abs(f_"ok")$], [$L=f_"obj"-abs(f_"ok")$; aufrecht],
)
Beispiel aus der Vorlesung: $f_"obj"=150 thin "mm"$, $f_"ok"=15 thin "mm"$ ergibt zehnfache Vergrößerung. Im Kepler-Fernrohr kann man in die Zwischenbildebene ein Fadenkreuz setzen; Feldstecher drehen das Bild mit einer dritten Linse oder einem Umkehrprisma um. Das Galilei-Fernrohr ist kürzer und eignet sich als Opernglas.

Eine *Kamera* bildet das Motiv mit einer Sammellinse reell auf den Sensor ab; scharfgestellt wird, indem man die Bildweite anpasst. Ein *Projektor* arbeitet umgekehrt: Ein kleines, helles Bild wird stark vergrößert an die Wand abgebildet.
#bild("map-instrumente", [Mindmap zu den Instrumenten. Eigene Darstellung nach K8, S. 294–301.], height: 46mm)
#src[K8, S. 298–301, Gl. 8.18–8.19, Abb. 8.18–8.20; FS, K9.14–K9.15.]
#hoch(<a-8>, [Kapitelübersicht])


== 8.3 Wellenoptik <a-8-3>
Alles aus Kapitel 6 über Wellen gilt auch für Licht. Neu ist vor allem die Frage, wann zwei Lichtwellen überhaupt ein stabiles Interferenzbild liefern.

=== 8.3.1 Licht als Welle <a-8-3-1>
Licht ist eine transversale elektromagnetische Welle: Elektrisches und magnetisches Feld schwingen senkrecht zur Ausbreitung und senkrecht zueinander.
#form[$ lambda f=c, quad c=c_0/n $]
#bild("licht-em-quelle", [EM-Welle (a), lineare (b) und zirkulare Polarisation (c). K8, S. 303, Abb. 8.21.], height: 28mm)
Die Schwingungsrichtung des elektrischen Feldes heißt *Polarisation*: linear, wenn sie in einer Ebene bleibt, zirkular, wenn die Feldspitze einen Kreis beschreibt. Laserlicht ist oft polarisiert; Licht von Sonne, Glühlampe oder LED ist im Allgemeinen unpolarisiert: Die Feldrichtung wechselt ständig zufällig.
#src[K8, S. 302–303, Gl. 8.20–8.21, Abb. 8.21.]

=== 8.3.2 Kohärenz <a-8-3-2>
Zwei Lichtwellen erzeugen nur dann ein stabiles Interferenzmuster, wenn sie *kohärent* sind:
+ gleiche Polarisation (sonst interferieren nur die gleich polarisierten Anteile),
+ zeitlich konstante Phasendifferenz,
+ gleiche Wellenlänge und Frequenz.
#bild("kohaerenz-quelle", [Kohärente (a) und inkohärente Quellen (b); kohärente Teilwellen aus einer Quelle über einen Strahlteiler (c). K8, S. 304, Abb. 8.22.], height: 30mm)
Zwei verschiedene Lampen sind nie zueinander kohärent: Ihre Atome senden zu zufälligen Zeiten kurze Wellenzüge aus. Deshalb teilt man das Licht *einer* Quelle mit einem Strahlteiler auf. Interferenz klappt aber nur, solange der Wegunterschied kleiner als die *Kohärenzlänge* $L$ ist, die mittlere Länge eines Wellenzugs:
#form[$ tau=L/c_0 $]
#tab(columns: (1.4fr, 1.4fr, 1.6fr),
 th([Quelle], [Kohärenzlänge], [Kohärenzzeit]),
 [Weißlicht], [1 µm], [$3 dot 10^(-15)$ s],
 [LED], [5 µm], [$15 dot 10^(-15)$ s],
 [Spektrallampe], [1 cm], [$3 dot 10^(-10)$ s],
 [Diodenlaser], [1 cm … 10 m], [$3 dot 10^(-11)$ … $3 dot 10^(-8)$ s],
 [He-Ne-Laser], [1 m … 100 km], [$"0,3" dot 10^(-8)$ … $"0,3" dot 10^(-3)$ s],
)
#src[K8, S. 304–305, Gl. 8.22–8.23, Abb. 8.22.]

=== 8.3.3 Zweistrahlinterferenz und Michelson-Interferometer <a-8-3-3>
Ein *Zweistrahl-Interferometer* teilt das Licht einer Quelle auf zwei Wege und führt es auf einem Schirm wieder zusammen. Wie bei den zwei Lautsprechern in 6.8.3 entscheidet der Wegunterschied:
#form[$ Delta s=m lambda " (hell)", quad Delta s=(2m+1) lambda/2 " (dunkel)", quad m=0,1,2,dots $]
Läuft Licht durch ein Medium, zählt die *optische Weglänge*: Strecke mal Brechungsindex. Im Medium ist das Licht $n$-mal langsamer, das wirkt wie ein $n$-mal längerer Weg.

Beim *Michelson-Interferometer* durchläuft das Licht beide Arme hin und zurück. Verschiebt man den Spiegel im Messarm um $Delta x$, ändert sich der Wegunterschied um $2 Delta x$:
#form[$ Delta s=abs(2A-2(B+Delta x)) $]
#bild("michelson-quelle", [Michelson-Interferometer. K8, S. 308, Abb. 8.24.], height: 38mm)
Eine Verschiebung um $lambda/2$ lässt den Schirm einmal hell–dunkel–hell durchlaufen. Zählt ein Photodetektor diese Wechsel, misst man Längen auf Bruchteile einer Wellenlänge genau. Michelson und Morley zeigten damit 1887, dass Licht keinen „Äther“ als Medium braucht.
#note("Gültigkeit", [Der Wegunterschied muss kleiner als die Kohärenzlänge der Quelle bleiben, sonst verschwindet das Interferenzbild. Mit Weißlicht (1 µm) funktioniert ein Michelson-Interferometer daher nur bei fast gleich langen Armen.], fill: sand)
#src[K8, S. 306–308, Gl. 8.24, Abb. 8.23–8.24.]

=== 8.3.4 Doppelspalt und Gitter <a-8-3-4>
Youngs Doppelspalt (1803) bewies die Wellennatur des Lichts. Für einen weit entfernten Schirm ($z gt.double d$) ist der Wegunterschied $Delta s=d sin(alpha)$; damit folgen dieselben Formeln wie in 6.8.3:
#form[$ sin(alpha_n)=n lambda/d quad (n=0, plus.minus 1, plus.minus 2, dots) " Maxima" $]
#form[$ sin(alpha_n)=n lambda/(2d) quad (n=plus.minus 1, plus.minus 3, dots) " Minima" $]
#bild("young-quelle", [Youngscher Doppelspalt mit grünem Laser: Wellenbild (a), Streifen auf dem Schirm (b), Intensität (c). K8, S. 309, Abb. 8.25.], height: 42mm)
Ein *optisches Gitter* hat viele gleiche Spalte im gleichen Abstand $d$, der *Gitterkonstante*. Die Hauptmaxima, hier *Beugungsordnungen* genannt, liegen an denselben Stellen wie beim Doppelspalt, werden aber viel schärfer:
#form[$ sin(alpha_n)=n lambda/d $]
#bild("gitter-quelle", [Beugungsordnungen hinter einem Gitter. K8, S. 311, Abb. 8.27.], height: 34mm)
Rotes Licht wird stärker gebeugt als blaues; Weißlicht erzeugt deshalb in den höheren Ordnungen Regenbogenspektren. CD und DVD wirken mit ihren Spurabständen von 1,6 µm und 0,74 µm als Reflexionsgitter. *Eigenes Zahlenbeispiel:* Licht mit 600 nm erscheint an der CD in der ersten Ordnung unter $arcsin("0,6"/"1,6") approx 22°$, an der DVD unter etwa 54°.
#note("Quellenverweis angepasst", [Die Folie verweist für die Doppelspaltformel auf „Kapitel 6.8.2“. In diesem Lernskript steht sie in Abschnitt 6.8.3.], fill: sand)
#src[K8, S. 309–312, Gl. 8.25–8.27, Abb. 8.25–8.29; FS, K6.22. Zahlenbeispiel: eigene Ergänzung.]

=== 8.3.5 Einzelspalt und Beugungsbegrenzung <a-8-3-5>
Auch hinter einem einzelnen Spalt sieht man nicht nur einen hellen Streifen, sondern ein Hauptmaximum mit schwachen Nebenmaxima. Nach Huygens sendet jeder Punkt der Öffnung eine Elementarwelle aus. Im ersten Minimum löschen sich die Wellen paarweise aus: Punkt 1 mit dem Punkt in der Spaltmitte, Punkt 2 mit dem nächsten und so weiter. Ihr Wegunterschied ist dann $(b/2) sin(alpha)=lambda/2$:
#form[$ sin(alpha_"min")=lambda/b, quad gamma=2 arcsin(lambda/b), quad I(alpha)=I_0 (sin(pi b sin(alpha)/lambda)/(pi b sin(alpha)/lambda))^2 $]
$b$ ist die Spaltbreite, $gamma$ der volle Winkel des Hauptmaximums. Je schmaler der Spalt, desto breiter das Hauptmaximum.
#bild("einzelspalt-quelle", [Elementarwellen im Einzelspalt (a) und Paarbildung für das erste Minimum (b). K8, S. 314, Abb. 8.31.], height: 32mm)
#bild("spaltbreite-quelle", [Beugungsbilder zweier Spaltbreiten. K8, S. 313, Abb. 8.30.], height: 44mm)
#note("Quellenfehler sichtbar korrigiert", [Die Bildunterschrift von Abb. 8.30 nennt „Links: $b approx 100 lambda$, rechts: $b approx 50 lambda$“. Die Grafiken selbst sind mit $b=10 lambda$ und $b=5 lambda$ beschriftet. Die Achsen passen zu den Grafikbeschriftungen: Für $b=5 lambda$ liegt das erste Minimum bei $sin(alpha)="0,2"$, also bei etwa 0,2 rad (*eigene Nachrechnung*).], fill: sand)

*Doppelspalt mit echten Spalten:* Haben die Spalte die Breite $b$, legt sich das Einzelspaltbild als *Einhüllende* über die Doppelspaltstreifen. Deshalb werden die Streifen nach außen schwächer.
#bild("doppelspalt-huelle-quelle", [Doppelspalt mit Einzelspalt-Einhüllende (rot). K8, S. 315.], height: 40mm)
*Beugungsbegrenzung:* Eine runde Blende erzeugt ein *Airy-Scheibchen* mit Ringen. In einem Teleskop wird ein Stern deshalb nie kleiner als dieses Scheibchen abgebildet; zwei sehr nahe Sterne verschwimmen. Größere Öffnungen verkleinern das Scheibchen.
#bild("map-kohaerenz", [Mindmap zur Wellenoptik. Eigene Darstellung nach K8, S. 302–316.], height: 46mm)
#src[K8, S. 313–316, Gl. 8.28, Abb. 8.30–8.31. Nachrechnung: eigene Ergänzung.]
#hoch(<a-8>, [Kapitelübersicht])

*Der Zusammenhang in Kapitel 8.* Licht ist eine elektromagnetische Welle, die im Medium um den Faktor $n$ langsamer läuft. Sind alle Strukturen groß gegen die Wellenlänge, genügen Strahlen: Aus dem Fermatschen Prinzip folgen Reflexion und Brechung, aus der Brechung an Kugelflächen die Linse. Linsen bilden ab und lassen sich zu Lupe, Mikroskop und Fernrohr kombinieren, die alle den Sehwinkel vergrößern. Werden Spalte so klein wie die Wellenlänge, zählt die Phase: Kohärentes Licht interferiert am Doppelspalt und am Gitter, und die Beugung am Einzelspalt begrenzt, wie scharf ein Instrument abbilden kann.
#src[K8, S. 271–316; eigene Zusammenfassung.]

= Anhang
== Formelsammlung mit Voraussetzungen
Die Spalte rechts nennt zusätzlich die Nummer in Deiner handschriftlichen Formelsammlung (FS). „nicht in FS“ heißt: Diese Formel fehlt dort noch.
=== Formeln zu Kapitel 6 · Wellen
#tab(columns: (1.1fr, 2fr, 1.9fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Puls], [$c=Delta x/Delta t$; $psi(x,t)=u(x plus.minus c t)$], [Unveränderte Form; − nach +x, + nach −x · FS K6.1–K6.2],
 [Harmonische Welle], [$psi=psi_0 sin(k x-omega t-phi_0)$], [Laufende Sinuswelle · FS K6.3],
 [Wellenzahl], [$k=2pi/lambda$; $omega=2pi f$], [$k$ in m⁻¹, $lambda$ in m · FS K6.4–K6.5],
 [Ausbreitung], [$c=lambda f=omega/k$], [Phasengeschwindigkeit · FS K6.6],
 [Schnelle], [$s=partial psi/partial t$; $s_"max"=psi_0 omega$], [Ableitung bei festem Ort · nicht in FS],
 [Saite], [$c=sqrt(F/(rho A))$], [Zugkraft F in N; $rho A$ in kg/m · FS K6.7],
 [Festkörper], [$c_T=sqrt(G/rho)$; $c_L=sqrt(E/rho)$], [Scher-/Torsions- und Stabmodell · FS K6.8–K6.9],
 [Flüssigkeit], [$c=sqrt(K/rho)$], [Longitudinal; K in Pa · FS K6.10],
 [Ideales Gas], [$c=sqrt(kappa R T/m_"mol")$], [$T$ in K, $m_"mol"$ in kg/mol · FS K6.11],
 [Temperaturvergleich], [$c_2/c_1=sqrt(T_2/T_1)$], [Gleiches Gas, konstantes $kappa$ · nicht in FS],
 [Intensität], [$I=1/2 rho c omega^2 u^2$], [Harmonische laufende Welle; Mittelwert · FS K6.12],
 [Leistung], [$P=I F$], [F hier Fläche in m² · FS K6.13],
 [Interferenz], [$A_"res"=2A abs(cos(Delta phi/2))$], [Gleiche Teilamplituden · nicht in FS],
 [Stehende Welle], [$psi=2A sin(k x)cos(omega t)$], [Gleiche gegenläufige Teilwellen · FS K6.14],
 [Abstände], [Knoten–Knoten: $lambda/2$; Knoten–Bauch: $lambda/4$], [Stehende harmonische Welle],
 [Fest–fest / lose–lose], [$lambda_n=2L/n$; $f_n=n c/(2L)$], [$n=1,2,3,dots$ · FS K6.15–K6.16, K6.19–K6.20],
 [Fest–lose], [$lambda_n=4L/n$; $f_n=n c/(4L)$], [$n=1,3,5,dots$ · FS K6.17–K6.18],
 [Kugelwelle], [$I=P/(4pi r^2)$; $I_2/I_1=(r_1/r_2)^2$], [Isotrop, verlustfrei · nicht in FS],
 [Zylinderwelle], [$I prop 1/r$], [Lange Linienquelle, verlustfrei · nicht in FS],
 [Elementarwelle], [$r=c Delta t$], [Gleiches c; Radius in m],
 [Phase aus Weg], [$Delta phi=2pi Delta s/lambda+Delta phi_0$], [Phase nicht zu Metern addieren; FS K6.21 übernimmt die dimensionsfalsche Folienform],
 [Doppelspalt], [$sin(alpha_j)=j lambda/d$], [Maxima; gleichphasig, Fernfeld · FS K6.22],
 [Doppelspalt-Minima], [$sin(alpha)=(j+1/2)lambda/d$], [Zwei Quellen, gleichphasig, Fernfeld],
 [Reflexion], [$alpha_"ein"=alpha_"aus"$], [Winkelbeträge zum Lot · FS K6.23],
 [Brechung], [$sin(alpha_1)/c_1=sin(alpha_2)/c_2$], [Ruhende Grenze; Winkel zum Lot · FS K6.24],
 [Wellenlängenwechsel], [$lambda_2/lambda_1=c_2/c_1$; $f_2=f_1$], [Ruhende Medien und Grenzfläche],
 [Doppler, Quelle bewegt], [$f_E=f_S/(1 minus.plus v_S/c)$], [− Annäherung, + Entfernung; $v_S<c$ · FS K6.25],
 [Doppler, Empfänger bewegt], [$f_E=f_S (1 plus.minus v_E/c)$], [+ Annäherung, − Entfernung · FS K6.26],
 [Doppler, beide bewegt], [$f_E=f_S (1 plus.minus v_E/c)/(1 minus.plus v_S/c)$], [Annäherung: Zähler +, Nenner − · FS K6.27],
 [Mach-Kegel], [$sin(theta)=c/v_S$], [$theta$ halber Öffnungswinkel; nur $v_S>c$ · FS K6.28],
)
=== Formeln zu Kapitel 7 · Wärmelehre
#tab(columns: (1.1fr, 2fr, 1.9fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Temperatur], [$T/"K"=vartheta/"°C"+"273,15"$], [Differenzen in K und °C gleich · FS K7.1–K7.3],
 [Längenausdehnung], [$Delta L=alpha L Delta T$], [Lineare Näherung · FS K7.4],
 [Volumenausdehnung], [$Delta V=gamma V Delta T$; $gamma=3alpha$], [$gamma=3alpha$ nur isotrop · FS K7.5–K7.6],
 [Thermoelement], [$U=epsilon_(12)(T_1-T_2)$], [Cu-Konstantan: 42 µV/K · nicht in FS],
 [Boyle-Mariotte], [$P V="konst."$], [$T$ konstant · FS K7.7],
 [Gay-Lussac], [$V/T="konst."$], [$P$ konstant, $T$ in K · FS K7.8],
 [Kombiniert], [$P_1 V_1/T_1=P_2 V_2/T_2$], [Gleiche Gasmenge · FS K7.9–K7.10],
 [Stoffmenge], [$n=N/N_A$; $m_"mol"=m/n$], [$N_A="6,022" dot 10^23$/mol · FS K7.11–K7.12],
 [Ideales Gas], [$P V=n R T$], [Absoluter Druck in Pa, $T$ in K · FS K7.15],
 [Teilchenenergie], [$E_"kin"=f/2 k_B T$; $k_B=R/N_A$], [$f=3$ einatomig, 5 zweiatomig · FS K7.16–K7.17],
 [Volumenarbeit], [$Delta W=-P Delta V$; $W_(12)=-integral P dif V$], [Am Gas positiv · nicht in FS],
 [1. Hauptsatz], [$Delta U=Delta Q+Delta W$], [Zugeführt positiv · nicht in FS],
 [Wärmemenge], [$Delta Q=m c Delta T=n c_m Delta T$], [Ohne Phasenwechsel · FS K7.18–K7.20],
 [Latente Wärme], [$Delta Q=q_S m$; $Delta Q=q_V m$], [Bei konstanter Temperatur · FS K7.19 (nur $q_S$)],
 [Mischung], [$T_"end"=sum m_i c_i T_i\/sum m_i c_i$], [Keine Verluste, kein Phasenwechsel · FS K7.21],
 [Gas-Wärmekapazität], [$c_V=f/2 R_s$; $c_P=c_V+R_s$; $R_s=R/m_"mol"$], [Ideales Gas · nicht in FS],
 [Molar], [$c_(m,V)=f/2 R$; $c_(m,P)=c_(m,V)+R$], [Ideales Gas · nicht in FS],
 [Dulong-Petit], [$c_m=3R approx "24,9" thin "J/(mol K)"$], [Festkörper · nicht in FS],
 [Isotherm], [$W_(12)=n R T ln(V_1/V_2)$; $Q_(12)=-W_(12)$], [$Delta U=0$ · nicht in FS],
 [Isobar], [$W_(12)=-P(V_2-V_1)$; $Q_(12)=c_V m Delta T+P Delta V$], [$P$ konstant · nicht in FS],
 [Isochor], [$W_(12)=0$; $Q_(12)=c_V m Delta T$], [$V$ konstant · nicht in FS],
 [Adiabatisch], [$P V^kappa="konst."$; $T V^(kappa-1)="konst."$; $W_(12)=c_V m Delta T$], [$Delta Q=0$; $kappa=(f+2)/f$ · nicht in FS],
 [Carnot], [$eta_C=(T_"heiß"-T_"kalt")/T_"heiß"$], [Obergrenze; T in K · nicht in FS],
 [Wärmepumpe], [$epsilon_"WP"=T_"heiß"/(T_"heiß"-T_"kalt")$], [Ideal · nicht in FS],
 [Kältemaschine], [$epsilon_"KM"=T_"kalt"/(T_"heiß"-T_"kalt")$], [Ideal · nicht in FS],
 [Wärmeleitung], [$dot(Q)=lambda A/L (T_"heiß"-T_"kalt")=Delta T/R_"th"$], [Stationär; $R_"th"=L/(lambda A)$ · nicht in FS],
 [Wärmewiderstände], [Serie $R_1+R_2$; parallel $1/R=1/R_1+1/R_2$], [Wie elektrische Widerstände · nicht in FS],
 [Konvektion], [$dot(Q)=c thin Delta m/Delta t (T_1-T_2)$], [Massenstrom in kg/s · nicht in FS],
 [Strahlung], [$P_"netto"=sigma epsilon A (T_K^4-T_U^4)$], [$sigma="5,67" dot 10^(-8)$ W/(m² K⁴) · nicht in FS],
 [Wien], [$lambda_"max"=2898 thin "µm K"/T$], [Schwarzer Strahler · nicht in FS],
)
=== Formeln zu Kapitel 8 · Optik
#tab(columns: (1.1fr, 2fr, 1.9fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Licht im Medium], [$c=c_0/n$; $lambda_n=lambda_0/n$; $lambda f=c$], [Frequenz bleibt · nicht in FS],
 [Reflexion], [$alpha_"ein"=alpha_"aus"$], [Zum Lot · FS K8.1],
 [Hohlspiegel], [$f=R/2$], [Achsennah · FS K8.2],
 [Brechung], [$n_1 sin(alpha_1)=n_2 sin(alpha_2)$], [Winkel zum Lot · FS K9.3–K9.4],
 [Totalreflexion], [$alpha_G=arcsin(n_2/n_1)$], [Nur $n_1>n_2$ · FS K9.5],
 [Linsenschleifer], [$1/f=(n/n_0-1)(1/R_1-1/R_2)$], [Dünne Linse; Vorzeichenregel · nicht in FS],
 [Brechkraft], [$D=1/f$ in dpt], [$f$ in m · nicht in FS],
 [Abbildung], [$1/f=1/g+1/b$; $B/G=-b/g$], [Vorzeichen nach Tabelle in 8.1.5 · FS K9.6–K9.7],
 [Linsen dicht hintereinander], [$1/f_"ges"=sum 1/f_i$; $D_"ges"=sum D_i$], [Abstand ≪ Brennweiten · nicht in FS],
 [Deutliche Sehweite], [$s_0=25 thin "cm"$], [Normalsichtiges Auge · FS K9.8],
 [Vergrößerung], [$Gamma=tan(epsilon_"mit")/tan(epsilon_"ohne")$], [Sehwinkel · FS K9.9–K9.11],
 [Lupe], [$V_L=s_0/f$], [Gegenstand im Brennpunkt · FS K9.12],
 [Mikroskop], [$V_M=s_0 t/(f_"obj" f_"ok")$], [$t$ Tubuslänge · FS K9.13],
 [Kepler-Fernrohr], [$V_T=f_"obj"/f_"ok"$; $L=f_"obj"+f_"ok"$], [Bild kopfstehend · FS K9.14],
 [Galilei-Fernrohr], [$V_T=f_"obj"/abs(f_"ok")$; $L=f_"obj"-abs(f_"ok")$], [Bild aufrecht · FS K9.15],
 [Kohärenzzeit], [$tau=L/c_0$], [L Kohärenzlänge · nicht in FS],
 [Zweistrahl], [hell: $Delta s=m lambda$; dunkel: $Delta s=(2m+1)lambda/2$], [Optische Weglänge = Strecke · n · nicht in FS],
 [Michelson], [$Delta s=abs(2A-2(B+Delta x))$], [$Delta x=lambda/2$: ein Hell-dunkel-Zyklus · nicht in FS],
 [Doppelspalt, Gitter], [$sin(alpha_n)=n lambda/d$], [Maxima, Fernfeld · FS K6.22],
 [Doppelspalt-Minima], [$sin(alpha_n)=n lambda/(2d)$], [$n=plus.minus 1, plus.minus 3, dots$ · nicht in FS],
 [Einzelspalt], [$sin(alpha_"min")=lambda/b$; $gamma=2arcsin(lambda/b)$], [Erstes Minimum, Fernfeld · nicht in FS],
)
#note("Wichtige Zahlen", [$1 thin "Hz"=1 thin "s"^(-1)$; $1 thin "µm"=10^(-6) thin "m"$; $1 thin "nm"=10^(-9) thin "m"$; $1 thin "l"=10^(-3) thin "m³"$; $1 thin "bar"=10^5 thin "Pa"$. $T/(1 thin "K")=vartheta/(1 thin "°C")+"273,15"$. Schall: Luft 340 oder 343 m/s, Wasser 1480 oder 1500 m/s, je nach Aufgabe. $N_A="6,022" dot 10^(23) thin "1/mol"$; $R="8,314" thin "J/(mol K)"$; $k_B="1,381" dot 10^(-23) thin "J/K"$; $V_m="22,4" thin "l/mol"$ bei 0 °C und 1013 hPa. Wasser: $c=4200 thin "J/(kg K)"$ (Folie) bzw. 4180 (Übung 11), $q_S approx 334 thin "kJ/kg"$, $q_V=2257 thin "kJ/kg"$. $sigma="5,67" dot 10^(-8) thin "W/(m² K⁴)"$; Wien: $2898 thin "µm K"$. $c_0 approx 3 dot 10^8 thin "m/s"$; sichtbares Licht 400–700 nm; $s_0=25 thin "cm"$. $g="9,81" thin "m/s²"$.])
#src[V26, PDF-S. 1–15; VB, PDF-S. 5–22; K6, S. 209–213; K7, S. 215–270; K8, S. 271–316; FS; Ü 10.1–10.6; Ü11. Umformungen und Einheitenumrechnungen: eigene Zusammenstellung.]
