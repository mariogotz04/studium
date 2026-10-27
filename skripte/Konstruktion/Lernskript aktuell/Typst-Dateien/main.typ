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
  #text(size: 8pt, fill: muted)[Feynman-Lernskript · Stand 27.10.2026]
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
  "b-projektionen": "abbildungen/b-projektionen.svg",
  "b-csg": "abbildungen/b-csg.svg",
  "b-ansichten": "abbildungen/b-ansichten.svg",
  "b-schnitte": "abbildungen/b-schnitte.svg",
  "b-schraffur": "abbildungen/b-schraffur.svg",
  "b-masshilfslinien": "abbildungen/b-masshilfslinien.svg",
  "b-radius": "abbildungen/b-radius.svg",
  "b-bemassungsarten": "abbildungen/b-bemassungsarten.svg",
  "b-schriftfeld": "abbildungen/b-schriftfeld.svg",
  "b-rauheit": "abbildungen/b-rauheit.svg",
  "b-oberflaechensymbole": "abbildungen/b-oberflaechensymbole.svg",
  "b-symbolpositionen": "abbildungen/b-symbolpositionen.svg",
  "b-kanten": "abbildungen/b-kanten.svg",
  "b-toleranzbegriffe": "abbildungen/b-toleranzbegriffe.svg",
  "b-abmasstabelle": "abbildungen/b-abmasstabelle.svg",
  "b-toleranzrahmen": "abbildungen/b-toleranzrahmen.svg",
  "b-passungsbegriffe": "abbildungen/b-passungsbegriffe.svg",
  "b-gewinde": "abbildungen/b-gewinde.svg",
  "b-freistich": "abbildungen/b-freistich.svg",
  "b-zentrierung": "abbildungen/b-zentrierung.svg",
  "b-passfedern": "abbildungen/b-passfedern.svg",
  "b-sicherungsringe": "abbildungen/b-sicherungsringe.svg",
  "b-nutmutter": "abbildungen/b-nutmutter.svg",
  "b-lagerproportionen": "abbildungen/b-lagerproportionen.svg",
  "b-stuetzlagerung": "abbildungen/b-stuetzlagerung.svg",
  "b-o-ring": "abbildungen/b-o-ring.svg",
  "b-rwdr": "abbildungen/b-rwdr.svg",
  "b-getriebearten": "abbildungen/b-getriebearten.svg",
  "b-stirnrad": "abbildungen/b-stirnrad.svg",
  "b-spiralkegelgetriebe": "abbildungen/b-spiralkegelgetriebe.svg",
  "b-explosion": "abbildungen/b-explosion.svg",
  "b-flanschlager": "abbildungen/b-flanschlager.svg",
  "linienarten": "abbildungen/linienarten.svg",
  "toleranzsymbole": "abbildungen/toleranzsymbole.svg",
  "ak-wuerfel-loesung": "abbildungen/ak-wuerfel-loesung.svg",
  "ak-projektionssymbole": "abbildungen/ak-projektionssymbole.svg",
  "ak-kegel": "abbildungen/ak-kegel.svg",
  "ak-schraubverbindung": "abbildungen/ak-schraubverbindung.svg",
  "ak-lagerdeckel": "abbildungen/ak-lagerdeckel.svg",
  "alt-a1-1": "abbildungen/alt-a1-1.svg",
  "map-kapitel-01": "abbildungen/map-kapitel-01.svg",
  "alt-a2-1": "abbildungen/alt-a2-1.svg",
  "map-kapitel-02": "abbildungen/map-kapitel-02.svg",
  "alt-b1-1": "abbildungen/alt-b1-1.svg",
  "alt-b1-2": "abbildungen/alt-b1-2.svg",
  "map-kapitel-03": "abbildungen/map-kapitel-03.svg",
  "alt-b2-1": "abbildungen/alt-b2-1.svg",
  "alt-b2-2": "abbildungen/alt-b2-2.svg",
  "map-kapitel-04": "abbildungen/map-kapitel-04.svg",
  "alt-c1-1": "abbildungen/alt-c1-1.svg",
  "alt-c1-2": "abbildungen/alt-c1-2.svg",
  "alt-c1-3": "abbildungen/alt-c1-3.svg",
  "map-kapitel-05": "abbildungen/map-kapitel-05.svg",
  "alt-c2-1": "abbildungen/alt-c2-1.svg",
  "alt-c2-2": "abbildungen/alt-c2-2.svg",
  "map-kapitel-06": "abbildungen/map-kapitel-06.svg",
  "alt-d1-1": "abbildungen/alt-d1-1.svg",
  "map-kapitel-07": "abbildungen/map-kapitel-07.svg",
  "alt-d2-1": "abbildungen/alt-d2-1.svg",
  "map-kapitel-08": "abbildungen/map-kapitel-08.svg",
  "map-kapitel-09": "abbildungen/map-kapitel-09.svg",
  "alt-d4-1": "abbildungen/alt-d4-1.svg",
  "map-kapitel-10": "abbildungen/map-kapitel-10.svg",
  "alt-d5-1": "abbildungen/alt-d5-1.svg",
  "alt-d5-2": "abbildungen/alt-d5-2.svg",
  "alt-d5-3": "abbildungen/alt-d5-3.svg",
  "map-kapitel-11": "abbildungen/map-kapitel-11.svg",
  "alt-d6-1": "abbildungen/alt-d6-1.svg",
  "alt-d6-2": "abbildungen/alt-d6-2.svg",
  "map-kapitel-12": "abbildungen/map-kapitel-12.svg",
  "map-kapitel-13": "abbildungen/map-kapitel-13.svg",
)

#let bilddeutungen = (
  "b-projektionen": (titel: "Bild lesen", body: [Von links nach rechts verändert sich die Projektionsart. Die räumliche Perspektive dient dem Anschauen; die rechte Ansicht macht die Kontur ohne perspektivische Größenänderung vergleichbar. Wahre Flächengröße erhältst Du nur bei einer zur Bildebene parallelen Fläche.]),
  "b-csg": (titel: "Bild lesen", body: [Links stehen die Ausgangskörper; daneben zeigen Vereinigung, Differenz und Schnittmenge jeweils anderes verbleibendes Material. Eine Bohrung entsteht im Modell durch Abziehen eines Körpers, nicht durch eine aufgemalte Kreislinie.]),
  "b-ansichten": (titel: "Bild lesen", body: [Die Vorderansicht ist der Bezug. Die Draufsicht liegt darunter, die Seitenansicht von links rechts daneben. Übertrage Höhe, Breite und Tiefe zwischen den Ansichten; gestrichelte Linien kennzeichnen verdeckte Konturen.]),
  "b-schnitte": (titel: "Bild lesen", body: [Die obere Reihe zeigt das gedankliche Aufschneiden, die untere die Zeichnung. Schraffiert wird nur vom Schnitt getroffenes Material. Die Buchse hat innen freie Flächen; diese Hohlräume bekommen keine Schraffur.]),
  "b-schraffur": (titel: "Bild lesen", body: [An der gemeinsamen Grenze wechseln Schraffurrichtung oder Abstand. Dadurch bleiben benachbarte Einzelteile getrennt lesbar. Dass zwei Schnittflächen ähnlich aussehen, macht sie noch nicht zu einem gemeinsamen Bauteil.]),
  "b-masshilfslinien": (titel: "Bild lesen", body: [Maßlinie, Maßhilfslinien und Körperkante erfüllen verschiedene Aufgaben. Eine günstige Hilfslinie darf schräg geführt werden; die Maßzahl beschreibt weiterhin das zugehörige reale Merkmal.]),
  "b-radius": (titel: "Bild lesen", body: [Der Buchstabe R ordnet die Zahl einem Radius zu. Die Maßlinie weist auf den Kreisbogen; ein außerhalb des Blatts liegender Mittelpunkt darf durch die vereinfachte Linienführung dargestellt werden. R und Ø beschreiben verschiedene Geometrieangaben.]),
  "b-bemassungsarten": (titel: "Bild lesen", body: [Oben beginnen die Maße jeweils am selben Bezug. Unten wird der Nullpunkt markiert, und die Zahlen steigen vom gemeinsamen Ursprung aus. Die Lage einer Bohrung ergibt sich aus dem Bezug, nicht aus dem Schätzen der Zeichnung.]),
  "b-schriftfeld": (titel: "Bild lesen", body: [Die Felder ordnen Benennung, Identifikation und Freigabe einer bestimmten Zeichnung zu. Die feste Gesamtbreite ist am Beispiel erkennbar; einzelne Firmen dürfen ihre Felder entsprechend den im Buch beschriebenen Regeln gestalten.]),
  "b-rauheit": (titel: "Bild lesen", body: [Die waagerechte Achse folgt der Messstrecke. Senkrechte Pfeile messen Höhen zur Mittellinie. Rz verbindet höchste Spitze und tiefstes Tal derselben Einzelmessstrecke; eine andere Auswertelänge kann einen anderen Extremwert liefern.]),
  "b-oberflaechensymbole": (titel: "Bild lesen", body: [Die drei Varianten unterscheiden alle zulässigen Verfahren, verlangten Materialabtrag und unzulässigen Materialabtrag. Der zusätzliche Balken unterscheidet die hier abgebildete Normfassung von der älteren Darstellung nach ISO 1302.]),
  "b-symbolpositionen": (titel: "Bild lesen", body: [Die Buchstaben sind Platzhalter: a/b für Anforderungen, c für Verfahren, d für Rillenrichtung, e für Zugabe. Sie gehören nicht als Buchstaben in die fertige Zeichnung. Beachte, welche Normfassung die Aufgabe voraussetzt.]),
  "b-kanten": (titel: "Bild lesen", body: [Links liegt eine Außenkante, rechts eine Innenkante. Materialüberschuss und Materialabtragung haben unterschiedliche Vorzeichen. Eine Forderung nach einem Kantenzustand legt noch keine bestimmte Fase mit festem Winkel fest.]),
  "b-toleranzbegriffe": (titel: "Bild lesen", body: [Die idealen Grenzlinien umschließen den zulässigen Maßbereich. Das Nennmaß dient als Bezug; die Abmaße beschreiben die Abstände der Grenzmaße von diesem Bezug. Die Feldbreite ist die Toleranz, nicht das obere Abmaß allein.]),
  "b-abmasstabelle": (titel: "Bild lesen", body: [Wähle zuerst die linke Zeile nach dem Nennmaß, dann die Spalte nach Buchstabe und Grad. Bei zusammengefassten Zeilen gelten die verbundenen Werte weiter. Oben steht das obere, darunter das untere Abmaß. Für Grenzmaße in mm teilst Du die Werte durch 1000.]),
  "b-toleranzrahmen": (titel: "Bild lesen", body: [Die Felder geben Eigenschaft und Toleranzwert an. Die Hinweislinie zeigt auf das tolerierte Element; ein Bezug wird bei einer bezogenen Forderung zusätzlich benannt. Der Zahlenwert ist die Breite beziehungsweise der Durchmesser der Zone, keine beidseitige Plus-minus-Angabe.]),
  "b-passungsbegriffe": (titel: "Bild lesen", body: [Die Tabelle verknüpft die beiden extremen Paarungen mit Spiel oder Übermaß. Größte Bohrung minus kleinste Welle liefert den größten vorzeichenbehafteten Freiraum; kleinste Bohrung minus größte Welle den kleinsten.]),
  "b-gewinde": (titel: "Bild lesen", body: [Der geschlossene breite Kreis ist die sichtbare Materialkante. Beim Außengewinde gehört er zum Nenndurchmesser, beim Innengewinde zum Kerndurchmesser. Der jeweils andere Durchmesser wird durch einen schmalen Dreiviertelkreis angedeutet.]),
  "b-freistich": (titel: "Bild lesen", body: [Die vergrößerten Übergänge zeigen, an welchen Flächen das Werkzeug auslaufen kann. Form F berücksichtigt zusätzlich die Planfläche. Radius, Einstichtiefe und Lage gehören zusammen; ein beliebiger scharfer Einstich ist kein gleichwertiger Ersatz.]),
  "b-zentrierung": (titel: "Bild lesen", body: [Die Kegelfläche führt die Drehmaschinenspitze. Die zusätzliche Schutzsenkung der Form B schützt den tragenden Bereich; Form R verwendet eine gerundete Anlage. Die dargestellte Bohrung ist eine Fertigungshilfe und nicht automatisch eine Betriebsbohrung.]),
  "b-passfedern": (titel: "Bild lesen", body: [Die Formen unterscheiden Stirnenden und zusätzliche Bohrungen. Die Seitenflächen übertragen die Umfangskraft; die obere Fläche soll im beschriebenen Einbau nicht gegen die Nabe tragen. Die Formbezeichnung gehört deshalb zur Bestellung.]),
  "b-sicherungsringe": (titel: "Bild lesen", body: [Links sichert ein Außenring auf einer Welle, rechts ein Innenring in einer Bohrung. Die Nut schafft den axialen Anschlag, lässt aber mit den Toleranzen ein Axialspiel zu. Die beiden Ringarten sind nicht austauschbar.]),
  "b-nutmutter": (titel: "Bild lesen", body: [Eine innere Nase verdrehsichert das Blech an der Welle; eine umgebogene äußere Nase greift in eine Mutternut. Die Mutter stellt axial ein, das Blech sichert ihre Stellung. Beides sind verschiedene Funktionen.]),
  "b-lagerproportionen": (titel: "Bild lesen", body: [Aus Innen- und Außendurchmesser folgt die radiale Bauhöhe H. Die angegebenen Bruchteile liefern eine erkennbare Handskizze. Es sind Zeichenproportionen; tatsächliche Bestell- und Anschlussmaße kommen aus dem Katalog.]),
  "b-stuetzlagerung": (titel: "Bild lesen", body: [Die Schultern zeigen die jeweilige axiale Abstützrichtung. Verfolge für eine nach links und eine nach rechts wirkende Axialkraft getrennt den Kraftweg. Der erkennbare Spalt gehört zur Verschiebbarkeit beziehungsweise Einstellung.]),
  "b-o-ring": (titel: "Bild lesen", body: [Der Ringquerschnitt wird durch Nut und Gegenfläche verformt. Die Dichtung ist eingebaut nicht mehr kreisrund. Nutbreite, Nuttiefe und Passung sorgen gemeinsam für Raum und Anpressung; die Klammer kennzeichnet das Hilfsmaß T.]),
  "b-rwdr": (titel: "Bild lesen", body: [Die beiden Bilder vergleichen die Montagerichtung. Fase und gerundete Kante schützen die empfindliche Dichtlippe. Die Laufstelle ist als drallfrei geschliffen gekennzeichnet; Form, Maßtoleranz und Oberfläche müssen gemeinsam passen.]),
  "b-getriebearten": (titel: "Bild lesen", body: [Die Spalten trennen parallele, sich schneidende und sich kreuzende Wellen. Verfolge die Achsen vor der Zahnform: Die gewünschte räumliche Verbindung entscheidet mit über Stirnrad-, Kegelrad- oder Schneckengetriebe.]),
  "b-stirnrad": (titel: "Bild lesen", body: [Die Außenkontur liegt am Kopfkreis, der Teilkreis ist eine schmale Strichpunktlinie. Im Achsschnitt bleiben die Zähne ungeschraffiert; die Schnittfläche des Radkörpers wird schraffiert. So bleibt die Darstellung einfach und normtypisch.]),
  "b-spiralkegelgetriebe": (titel: "Bild lesen", body: [Beginne mit den Wellenachsen und verfolge dann den Leistungsweg über die Zahnräder. Positionsnummern verbinden die Teile mit der Stückliste. Schraffur trennt Bauteile; Lager und Dichtungen erklären, wie die bewegten Teile gehalten und abgedichtet werden.]),
  "b-explosion": (titel: "Bild lesen", body: [Die auseinandergezogenen Teile behalten ihre Montageachsen und werden über Positionsnummern identifiziert. Die Abstände sind Darstellungsabstände und keine Montage- oder Betriebsmaße. Prüfe, welche Teile als Unterbaugruppe vormontiert werden.]),
  "b-flanschlager": (titel: "Bild lesen", body: [Vergleiche Schnitt und Stirnansicht: Bohrungen, Stufen und Lochkreis ergänzen sich. Passmaße gehören zu Funktionsflächen; allgemeine Anforderungen stehen gesammelt am Blatt. Keine Länge durch Messen aus diesem verkleinerten Ausschnitt bestimmen.]),
  "linienarten": (titel: "Bild lesen", body: [Die Linien unterscheiden sich durch Breite und Strichfolge. Breit und schmal stehen hier im Verhältnis 2:1. Die Reihenfolge aus Strichen und Punkten gehört zur Bedeutung; eine Mittellinie ist keine verdeckte Kante.]),
  "toleranzsymbole": (titel: "Bild lesen", body: [Die Symbole werden als erstes Feld des Toleranzrahmens gelesen. Die übrigen Felder ergänzen Wert und gegebenenfalls Bezüge. Das gleiche Profilsymbol kann mit oder ohne Bezug auftreten; sein Name allein legt die gesamte Forderung nicht fest.]),
  "ak-wuerfel-loesung": (titel: "Bild lesen", body: [Vergleiche die drei parallelen Kantenfamilien. Bei der Isometrie sind die gezeichneten Kanten gleich lang; bei der technischen Dimetrie wird die Tiefenrichtung halbiert. Die Maßzahl bleibt für alle realen Würfelkanten 30 mm, auch wenn in der Tiefenrichtung nur 15 mm gezeichnet werden.]),
  "ak-projektionssymbole": (titel: "Bild lesen", body: [Der Kegelstumpf und seine Kreisansicht bilden zusammen das Methodenzeichen. Die Blattseite der Kreisansicht unterscheidet Methode 1 von Methode 3. Das Symbol legt die Ansichtenanordnung fest und ist kein Zeichen für eine bestimmte Schnittart.]),
  "ak-kegel": (titel: "Bild lesen", body: [Die Vorderansicht zeigt einen Kegel mit schräger Schnittebene. Die Achse ist strichpunktiert; die schräg begrenzte obere Kontur ist die Schnittkante. Die zweite Ansicht muss aus projizierten Punkten dieser Kante entstehen, nicht aus einer frei gezeichneten Ellipse.]),
  "ak-schraubverbindung": (titel: "Bild lesen", body: [Oben stehen die verbindlichen Aufgabenmaße, darunter die vorgegebene Baugruppe und ein handschriftlicher Ansatz. Die handschriftlichen Linien sind keine geprüfte Musterlösung. Ordne Gewindelänge, Durchgangsloch und Sacklochtiefe getrennten Merkmalen zu.]),
  "ak-lagerdeckel": (titel: "Bild lesen", body: [Die markierte Anforderung betrifft Form- und Lagetoleranz. Der Deckel ist Position 2. Verfolge seine Kontur getrennt von Gehäuse, Schrauben und Lager; die gelbe Markierung und die Handskizzen stammen aus der vorhandenen Unterlage.]),
  "alt-a1-1": (titel: "Bild lesen", body: [Die eingezeichneten Halbierungen zerlegen A0 schrittweise in kleinere A-Formate. Bei jeder Stufe halbiert sich die Fläche; die Lage der Felder dient nur der Veranschaulichung.]),
  "map-kapitel-01": (titel: "Bild lesen", body: [Die Äste verbinden die vier Arbeitsschritte dieses Kapitels. Lies jeden Ast als Ursache-Folge-Beziehung und erkläre an einem Bauteil, wie die vier Schritte zusammen zur eindeutigen Zeichnung führen.]),
  "alt-a2-1": (titel: "Bild lesen", body: [Die linken Körper sind die Ausgangsgeometrien. Die weiteren Bilder zeigen vereinigtes, abgezogenes und gemeinsam verbleibendes Volumen. Die Operation beschreibt Material, nicht nur die sichtbare Kontur.]),
  "map-kapitel-02": (titel: "Bild lesen", body: [Die Äste verbinden die vier Arbeitsschritte dieses Kapitels. Lies jeden Ast als Ursache-Folge-Beziehung und erkläre an einem Bauteil, wie die vier Schritte zusammen zur eindeutigen Zeichnung führen.]),
  "alt-b1-1": (titel: "Bild lesen", body: [Die Ansichten stehen in festem Bezug zueinander: gleiche Höhen liegen waagerecht, gleiche Breiten senkrecht untereinander. Die Seitenansicht von links steht bei Methode 1 rechts.]),
  "alt-b1-2": (titel: "Bild lesen", body: [Die Mittellinie trennt Außenansicht und Schnitt. Die schraffierte Hälfte zeigt Material, der weiße Innenbereich die Bohrung. Eine zusätzliche breite Trennlinie würde eine nicht vorhandene Kante vortäuschen.]),
  "map-kapitel-03": (titel: "Bild lesen", body: [Die Äste verbinden die vier Arbeitsschritte dieses Kapitels. Lies jeden Ast als Ursache-Folge-Beziehung und erkläre an einem Bauteil, wie die vier Schritte zusammen zur eindeutigen Zeichnung führen.]),
  "alt-b2-1": (titel: "Bild lesen", body: [Die breite Körperkante gehört zum Bauteil; Maß- und Maßhilfslinien sind schmal. Die Maßzahl ist der reale Abstand und bleibt bei einem anderen Zeichenmaßstab gleich.]),
  "alt-b2-2": (titel: "Bild lesen", body: [Die Längenmaße beginnen an der linken Bezugsebene. Die Durchmesser werden quer zur Achse angegeben. Damit sind Lage der Absätze und jeweilige Drehdurchmesser getrennt lesbar.]),
  "map-kapitel-04": (titel: "Bild lesen", body: [Die Äste verbinden die vier Arbeitsschritte dieses Kapitels. Lies jeden Ast als Ursache-Folge-Beziehung und erkläre an einem Bauteil, wie die vier Schritte zusammen zur eindeutigen Zeichnung führen.]),
  "alt-c1-1": (titel: "Bild lesen", body: [Waagerecht folgt die Messrichtung der Oberfläche, senkrecht stehen Profilhöhen. Höchste Spitze und tiefstes Tal derselben Einzelmessstrecke ergeben zusammen Rz.]),
  "alt-c1-2": (titel: "Bild lesen", body: [Die Zusätze am Grundsymbol kennzeichnen unterschiedliche Forderungen an den Materialabtrag. Hier ist ausdrücklich die ältere ISO-1302-Schreibweise gezeigt; die neuere 21920-Darstellung steht daneben als Buchausschnitt.]),
  "alt-c1-3": (titel: "Bild lesen", body: [Die Buchstaben markieren Eintragsplätze und sind keine fertigen Rauheitsangaben. Mehrere Anforderungen stehen untereinander; Verfahren, Rillenrichtung und Zugabe gehören an andere Plätze.]),
  "map-kapitel-05": (titel: "Bild lesen", body: [Die Äste verbinden die vier Arbeitsschritte dieses Kapitels. Lies jeden Ast als Ursache-Folge-Beziehung und erkläre an einem Bauteil, wie die vier Schritte zusammen zur eindeutigen Zeichnung führen.]),
  "alt-c2-1": (titel: "Bild lesen", body: [Die Null-Linie entspricht dem Nennmaß. Oberes und unteres Abmaß begrenzen das zulässige Feld; dessen senkrechte Breite ist die Maßtoleranz.]),
  "alt-c2-2": (titel: "Bild lesen", body: [Die senkrechte Achse zeigt Abmaße in µm relativ zum Nennmaß. Das H7-Feld bleibt fest, während die Wellenfelder ihre Lage ändern. Die extremen Paarungen entscheiden über Spiel, Übergang oder Übermaß.]),
  "map-kapitel-06": (titel: "Bild lesen", body: [Die Äste verbinden die vier Arbeitsschritte dieses Kapitels. Lies jeden Ast als Ursache-Folge-Beziehung und erkläre an einem Bauteil, wie die vier Schritte zusammen zur eindeutigen Zeichnung führen.]),
  "alt-d1-1": (titel: "Bild lesen", body: [Beim Außengewinde liegt die breite Linie außen, beim Innengewinde innen an der Materialkante. Der schmale Dreiviertelkreis kennzeichnet den jeweils zweiten Durchmesser als Gewindevereinfachung.]),
  "map-kapitel-07": (titel: "Bild lesen", body: [Die Äste verbinden die vier Arbeitsschritte dieses Kapitels. Lies jeden Ast als Ursache-Folge-Beziehung und erkläre an einem Bauteil, wie die vier Schritte zusammen zur eindeutigen Zeichnung führen.]),
  "alt-d2-1": (titel: "Bild lesen", body: [Die Passfeder greift mit den Seiten in Wellen- und Nabennut. Die Tiefen t1 und t2 bestimmen ihre Einbaulage, die freie obere Stelle das Rückenspiel. Der Drehmomentfluss verläuft über die Seitenflächen.]),
  "map-kapitel-08": (titel: "Bild lesen", body: [Die Äste verbinden die vier Arbeitsschritte dieses Kapitels. Lies jeden Ast als Ursache-Folge-Beziehung und erkläre an einem Bauteil, wie die vier Schritte zusammen zur eindeutigen Zeichnung führen.]),
  "map-kapitel-09": (titel: "Bild lesen", body: [Die Äste verbinden die vier Arbeitsschritte dieses Kapitels. Lies jeden Ast als Ursache-Folge-Beziehung und erkläre an einem Bauteil, wie die vier Schritte zusammen zur eindeutigen Zeichnung führen.]),
  "alt-d4-1": (titel: "Bild lesen", body: [Die radiale Bauhöhe H verteilt sich auf Innenring, Wälzkörper und Außenring. Die Bruchteile liefern nur Handzeichnungsproportionen. Die Kugel bleibt ungeschnitten, die Ringe werden schraffiert.]),
  "map-kapitel-10": (titel: "Bild lesen", body: [Die Äste verbinden die vier Arbeitsschritte dieses Kapitels. Lies jeden Ast als Ursache-Folge-Beziehung und erkläre an einem Bauteil, wie die vier Schritte zusammen zur eindeutigen Zeichnung führen.]),
  "alt-d5-1": (titel: "Bild lesen", body: [Die eingeengte Nut verformt den O-Ring; der Abstand T und die Nutbreite B bestimmen den Einbauraum. Die Passung beschreibt die miteinander geführten Metallteile und darf nicht mit der Schnurstärke verwechselt werden.]),
  "alt-d5-2": (titel: "Bild lesen", body: [Die angegebene Fase führt die Dichtlippe beim Einbau über die Kante. Die Lauffläche benötigt außer dem richtigen Durchmesser auch passende Rauheit und drallfreie Bearbeitung.]),
  "alt-d5-3": (titel: "Bild lesen", body: [Das Rechteck steht für den Einbauraum der Dichtung. Das Diagonalkreuz ist das vereinfachte Symbol; ein zusätzlicher Pfeil kann die Dichtwirkung zuordnen.]),
  "map-kapitel-11": (titel: "Bild lesen", body: [Die Äste verbinden die vier Arbeitsschritte dieses Kapitels. Lies jeden Ast als Ursache-Folge-Beziehung und erkläre an einem Bauteil, wie die vier Schritte zusammen zur eindeutigen Zeichnung führen.]),
  "alt-d6-1": (titel: "Bild lesen", body: [Vom Teilkreis nach außen liegt die Kopfhöhe, nach innen die Fußhöhe. Zahndicke und Zahnlücke teilen sich die Umfangsteilung. Die Skizze zeigt ein unverschobenes geradverzahntes Stirnrad.]),
  "alt-d6-2": (titel: "Bild lesen", body: [Die Ansicht zeigt konzentrische Kopf-, Teil- und gegebenenfalls Fußkreise. Im Achsschnitt werden die Zähne nicht schraffiert; die Nabe und der Radkörper bleiben als geschnittenes Material erkennbar.]),
  "map-kapitel-12": (titel: "Bild lesen", body: [Die Äste verbinden die vier Arbeitsschritte dieses Kapitels. Lies jeden Ast als Ursache-Folge-Beziehung und erkläre an einem Bauteil, wie die vier Schritte zusammen zur eindeutigen Zeichnung führen.]),
  "map-kapitel-13": (titel: "Bild lesen", body: [Die Äste verbinden die vier Arbeitsschritte dieses Kapitels. Lies jeden Ast als Ursache-Folge-Beziehung und erkläre an einem Bauteil, wie die vier Schritte zusammen zur eindeutigen Zeichnung führen.]),
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
#v(5mm)
#text(size: 29pt, weight: "bold", fill: navy)[Konstruktion]
#v(3mm)
#text(size: 20pt, fill: navy)[Feynman-Lernskript]
#v(3mm)
#text(size: 12pt)[Zusammenhänge sehen. Grundlagen verstehen. Selbst erklären.]
#bild("b-spiralkegelgetriebe", [Konstruktion als Zusammenspiel von Form, Funktion und eindeutiger Zeichnung. B, Bild 14-1, S. 270 (PDF-S. 281).], height: 66mm)
#text(size: 12pt, fill: teal)[Form → Darstellung → Bemaßung → Funktion]
]
#note("Dein Feynman-Schritt", [Sieh Dir die Zeichnung an. Erkläre ohne Vorlage: *Was sehe ich? Warum ist es so gezeichnet? Welche Angabe brauche ich für Fertigung und Prüfung?* Vergleiche erst anschließend mit der Erklärung und prüfe Dich an einer Aufgabe auf der Lernwebseite.])
Stand: *27.10.2026*. Grundlage sind die fachlichen Kapitel 1–15 des Buchs, der vollständig überarbeitete alte Lernskript-Stand und die Altklausur WS20/21. Weil es keine Vorlesungsskripte gibt, wird auf Deinen Auftrag das Buch breit abgedeckt; die Gliederung folgt seiner Reihenfolge, mit zusammengefassten Grundlagen- und Anwendungskapiteln. Aufgaben, ausführliche Lösungen und Quiz stehen auf der Lernwebseite (Tab „Lernen“); dieses Skript enthält Erklärung und im Anhang die Formelsammlung.

#pagebreak()
#heading(level: 1, outlined: false)[Wegweiser]
#block[
#set text(size: 9.5pt)
#set par(leading: 0.3em, spacing: 0.15em)
#outline(title: none, depth: 2, indent: auto)
]
#v(2mm)
#text(size: 8.5pt, fill: muted)[*Quellenkürzel:* B = Labisch/Wählisch, Technisches Zeichnen, 7. Auflage 2025. Gedruckte S. 1–291 = PDF-S. minus 11; Sachwortverzeichnis S. 293–297 = PDF-S. minus 10. AK = Konstruktion Prüfung WS20/21, 03.02.2021; Seiten dort sind PDF-Seiten. L-alt = Claude-Lernskript Stand 15.10.2026; überarbeitete Vorarbeit, keine Dozentenquelle. Ü bezeichnet eine Buchübung. Eigene Beispiele, Herleitungen und Lösungen sind gekennzeichnet; es liegen keine amtlichen Lösungen zu AK vor. Normbezeichnungen folgen der jeweils genannten Buch-/Aufgabenfassung; ältere und neuere Schreibweisen werden unterschieden. Ergänzende Herstellerquellen sind direkt im Abschnitt verlinkt.]

#pagebreak()
#heading(level: 1, outlined: false, bookmarked: false)[Das Modul auf einen Blick] <ueberblick>

Jeder Kasten führt zu seinem Kapitel. Die Pfeiltexte zeigen, wie die Kapitel zusammenhängen.

#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Kapitel 1 · Grundlagen und Zeichnungserstellung], [Zeichnungssprache · Normen · Blatt · Zeichnungsart · Stückliste], ziel: <a-1>),
  pfeil(beschriftung: [wird digital erstellt mit]),
  chunk([Kapitel 2 · CAD und digitale Produktmodelle], [CAD · Volumenmodell · Modellierschritte · Schnittstellen · Freigabe], ziel: <a-2>),
  pfeil(beschriftung: [liefert Geometrie für]),
  chunk([Kapitel 3 · Werkstücke darstellen], [Maßstab · Linien · Ansichten · Projektion · Schnitt], ziel: <a-3>),
)
#align(center)[#text(size: 8pt, fill: teal)[↓ wird maßlich festgelegt durch]]
#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Kapitel 4 · Bemaßung und Dokumentation], [Funktion · Bezug · Maße · Sonderzeichen · Dokumentstand], ziel: <a-4>),
  pfeil(beschriftung: [wird ergänzt durch]),
  chunk([Kapitel 5 · Oberflächen und Kanten], [Funktion · Rauheit · Kennwert · Oberflächensymbol · Kante], ziel: <a-5>),
  pfeil(beschriftung: [braucht passende Grenzangaben aus]),
  chunk([Kapitel 6 · Toleranzen und Passungen], [Nennmaß · Abmaß · Grenzmaß · Passung · Form und Lage], ziel: <a-6>),
)
#align(center)[#text(size: 8pt, fill: teal)[↓ sichert die Funktion von]]
#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Kapitel 7 · Gewinde und Schraubenverbindungen], [Gewindeprofil · Darstellung · Nutzlänge · Schraube · Normbezeichnung], ziel: <a-7>),
  pfeil(beschriftung: [ergänzt Verbindungen an]),
  chunk([Kapitel 8 · Elemente an Achsen und Wellen], [Wellenende · Freistich · Zentrierung · Passfeder · Profilwelle], ziel: <a-8>),
  pfeil(beschriftung: [braucht axiale Sicherung aus]),
  chunk([Kapitel 9 · Sicherungselemente], [Axialsicherung · Sicherungsring · Nut · Nutmutter · Sicherungsblech], ziel: <a-9>),
)
#align(center)[#text(size: 8pt, fill: teal)[↓ sichert Bauteile in]]
#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Kapitel 10 · Wälzlager und Lageranordnungen], [Last · Lagerbauform · Sitz · Festlager · Loslager], ziel: <a-10>),
  pfeil(beschriftung: [wird abgedichtet durch]),
  chunk([Kapitel 11 · Dichtungen], [Medium · Relativbewegung · Dichtprinzip · Einbauraum · Oberfläche], ziel: <a-11>),
  pfeil(beschriftung: [steht im Getriebe neben]),
  chunk([Kapitel 12 · Zahnräder], [Zahnradart · Modul · Zähnezahl · Teilkreis · Verzahnungstabelle], ziel: <a-12>),
)
#align(center)[#text(size: 8pt, fill: teal)[↓ wird zusammengeführt in]]
#karte((1fr,),
  chunk([Kapitel 13 · Zeichnungen lesen und erstellen], [Gesamtzeichnung · Funktion · Stückliste · Montage · Einzelteilzeichnung], ziel: <a-13>),
)

Die Form eines Bauteils muss für andere eindeutig lesbar werden. Grundlagen, CAD und Darstellungsregeln führen vom räumlichen Modell zur Zeichnung; Bemaßung, Oberflächen und Toleranzen beschreiben die nötige Funktion. Gewinde, Wellenverbindungen, Sicherungen, Lager, Dichtungen und Zahnräder wenden diese Sprache auf Maschinenelemente an. Am Ende werden Baugruppen über ihre Funktion und Montage verstanden und daraus vollständige Einzelteilzeichnungen erstellt.
#src[Eigene Darstellung; Zusammenführung des bereits enthaltenen Stoffs und der Denkkette auf der Titelseite.]

#pagebreak()

#pagebreak(weak: true)
= Kapitel 1 · Grundlagen und Zeichnungserstellung <a-1>

#überblick([Kapitel 1 auf einen Blick],
  idee(<a-1-1>, [Die Zeichnung vermittelt eine eindeutige technische Aussage.], [Fertigung und Montage müssen dieselbe Form und Funktion erkennen können.]),
  idee(<a-1-2>, [Normen vereinbaren die Sprache.], [Zeichen, Formate und Angaben werden dadurch einheitlich lesbar.]),
  idee(<a-1-4>, [Die Zeichnungsart folgt dem Zweck.], [Einzelteil und Gesamtzeichnung geben unterschiedliche Informationen weiter.]),
  idee(<a-1-5>, [Positionsnummern verknüpfen Bauteil und Liste.], [Die Stückliste ordnet jeder Position die benötigten Teile zu.]),
)

#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Zweck und Funktion], [Was muss der Empfänger wissen?], ziel: <a-1-1>),
  pfeil(beschriftung: [bestimmt]),
  chunk([Zeichnungsart], [Einzelteil · Baugruppe · Skizze], ziel: <a-1-4>),
  pfeil(beschriftung: [braucht]),
  chunk([Geordnete Information], [Normen · Blatt · Positionen · Stückliste], ziel: <a-1-5>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])


Eine Technische Zeichnung ist eine #strong[Sprache]: Der Konstrukteur schreibt, Fertigung, Einkauf, Montage und Zulieferer lesen. Damit alle dasselbe verstehen, ist diese Sprache #strong[genormt]. In diesem Teil geht es um die Grundbegriffe: warum orthogonale Ansichten für die eindeutige Fertigungsdarstellung eingesetzt werden, welche Normen es gibt, welche Blattformate erlaubt sind, welche Zeichnungsarten es gibt und wie Gesamtzeichnung, Positionsnummern und Stückliste zusammenhängen.

#src[B S. 1–16; überarbeitete Erklärung aus L-alt A1. Eigene Beispiele sind jeweils gekennzeichnet.]

== 1.1 Wozu Technische Zeichnungen? <a-1-1>

#bild("b-projektionen", [Bild 1-1: Zentral-, Parallel- und orthogonale Projektion. B, S. 2 (PDF-S. 13).], height: 46mm)

#note("Genau lesen", [Eine orthogonale Ansicht zeigt nur Flächen parallel zur Bildebene in wahrer Größe. Geneigte Strecken oder Flächen können auch hier verkürzt erscheinen. Axonometrische Parallelprojektionen können ebenfalls maßstäblich nach ihren Projektionsregeln aufgebaut sein; „nur eine Projektionsart ist maßstäblich“ wäre zu pauschal.], fill: sand)

#text(fill: teal, weight: "bold")[Einfach erklärt]

Ein Produkt entsteht nicht an einem Ort. Konstruktion, Arbeitsvorbereitung, Fertigung, Qualitätssicherung, Montage, Einkauf und oft externe Lieferanten arbeiten daran. Die Technische Zeichnung ist der #strong[Informationsträger] zwischen diesen Stellen: Sie beschreibt Form, Maße, Toleranzen, Oberflächen und Werkstoff eines Teils so eindeutig, dass jemand anders es ohne Rückfrage herstellen kann (S. 1).

#note("Beispiel (eigene Ergänzung)", [Ein Maschinenbauer in Deggendorf lässt Wellen bei einem Lohnfertiger in Tschechien drehen. Der Lohnfertiger kennt die Maschine nicht und spricht vielleicht kein Deutsch. Er bekommt nur die Zeichnung. Steht dort „Ø40 k6“ und „Ra 1,6“, weiß er genau, was er liefern muss.])

#text(fill: teal, weight: "bold")[Drei Arten der Darstellung (S. 2, Bild 1-1)]

#tab(columns: (1fr, 1fr, 1fr),
 th([Darstellung], [Merkmal], [Einsatz]),
 [#strong[Perspektive] (Zentralprojektion)], [Projektionsstrahlen laufen in einem Punkt zusammen; wirkt wie ein Foto, ferne Kanten werden kleiner], [Präsentation, Katalog],
 [#strong[Parallelprojektion] (z. B. isometrisch)], [Strahlen parallel; orthogonale oder schiefe Ausführung möglich, räumliche Darstellungen wie Isometrie mit definierten Achsenverkürzungen], [Anschauliche Skizzen, Explosionsdarstellungen],
 [#strong[Senkrechte Parallelprojektion]], [Strahlen parallel #strong[und] senkrecht zur Bildebene; Flächen parallel zur Bildebene erscheinen in wahrer Größe; geneigte Flächen sind verkürzt], [#strong[Technische Zeichnung]],
)

#note("Merke", [Die senkrechte Parallelprojektion ist #strong[maßstäblich]: Eine Fläche parallel zur Bildebene erscheint unverzerrt. Deshalb besteht eine Technische Zeichnung aus mehreren solchen Ansichten (mehr dazu in Kapitel 3).])

#src[B S. 1–2; L-alt A1, überarbeitet.]
#hoch(<a-1>, [Kapitelübersicht])


== 1.2 Normen: DIN, EN, ISO <a-1-2>

Eine Zeichnung ist ein stark vereinfachtes, zweidimensionales Abbild eines dreidimensionalen Gegenstands und muss interpretiert werden. Damit alle sie #strong[gleich] interpretieren, gibt es Zeichnungsnormen (S. 3). Normen haben den Charakter von #strong[Empfehlungen] mit technisch-normativer Wirkung: Ihre Beachtung steht jedem frei, aus sich heraus sind sie rechtlich nicht verbindlich, aber wer sich nach ihnen richtet, verhält sich ordnungsgemäß (S. 3). Bei einer Normreferenz gehört neben Kürzel und Nummer auch das #strong[Ausgabedatum] dazu (S. 4).

#tab(columns: (1fr, 1fr),
 th([Kürzel], [Bedeutung]),
 [#strong[DIN]], [Deutsches Institut für Normung; rein deutsche Norm],
 [#strong[DIN EN]], [Europäische Norm (CEN), unverändert als DIN übernommen],
 [#strong[DIN ISO]], [Internationale Norm (ISO, Sitz Genf), als DIN übernommen],
 [#strong[DIN EN ISO]], [Internationale Norm, die zugleich europäische und deutsche Norm ist],
)

#note("Achtung", [Gleiche Nummer heißt nicht gleicher Inhalt. DIN 228 und DIN EN ISO 228 sind verschiedene Normen (S. 4). Die Norm immer vollständig mit Präfix nennen.], fill: sand)

#src[B S. 3–4; L-alt A1, überarbeitet.]
#hoch(<a-1>, [Kapitelübersicht])


== 1.3 Blattformate und Blattaufteilung <a-1-3>


#bild("alt-a1-1", [A0 halbiert ergibt A1, A1 halbiert A2 usw. Quelle der Skizze: L-alt A1; eigene Darstellung.], height: 56mm)


Die Blattgrößen sind in #strong[DIN EN ISO 5457] geregelt (S. 6). Ausgangspunkt ist #strong[A0 mit 1 m² Fläche]. Jedes kleinere Format entsteht durch Halbieren der langen Seite, die Flächen zweier aufeinanderfolgender Formate verhalten sich also wie 2 : 1. Die Seiten verhalten sich wie Quadratseite zu Diagonale:

#tab(columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
 th([Format], [A0], [A1], [A2], [A3], [A4]),
 [mm], [841 × 1189], [594 × 841], [420 × 594], [297 × 420], [210 × 297],
)

A2 und A3 folgen aus dem Halbieren (S. 6 nennt A0, A1, A4 ausdrücklich).


Formate herleiten (mit Variablen und Einheiten)

#form[
$ A _(A 0)  = x   dot  y  = 1 thin "m" ^(2) , $
$ y  = sqrt(2)  thin x   quad  =>  quad  x  = sqrt(frac(1 thin "m" ^(2), sqrt(2)))   approx  0","841 thin "m" , $
$ y   approx  1","189 thin "m" $
]

x = kurze Seite, y = lange Seite. Fläche von An: $ A _("An")  = 1 thin "m" ^(2)  / 2^(n) $, z. B. A4: $ 1/16 thin "m" ^(2)  = 0","0625 thin "m" ^(2) $ (210 mm · 297 mm = 62.370 mm² ≈ 0,0624 m²).

#note("Merkhilfe (eigene Ergänzung)", [Von A0 nach A4 sind es 4 Halbierungen, also 2⁴ = 16 A4-Blätter in einem A0-Blatt. Gefaltet wird ein großes Blatt auf A4-Größe, damit es in einen Ordner passt (#strong[B Übung 2.4]).])

#text(fill: teal, weight: "bold")[Blattaufteilung (S. 6–7)]

- #strong[Lage]: A4 ist nur als #strong[Hochformat] vorgesehen, alle anderen Formate nur als #strong[Querformat] (S. 6, Übung 2.1).
- #strong[Heftrand] 20 mm, damit man das Blatt lochen und abheften kann; die nutzbare Zeichenfläche ist zusätzlich um das Schriftfeld kleiner.
- #strong[Schriftfeld] immer #strong[unten rechts]; es ist im gefalteten Zustand sichtbar (Inhalt siehe Kapitel 4).
- #strong[Feldeinteilung] (Bild 2-2): Die Spalten bekommen Großbuchstaben, die Zeilen Zahlen, wie beim Schachbrett. So kann man am Telefon sagen: „Die Bohrung in Feld B6“.

#src[B S. 5–7; L-alt A1, überarbeitet.]
#hoch(<a-1>, [Kapitelübersicht])


== 1.4 Zeichnungsarten <a-1-4>

„Technische Zeichnung“ ist ein Sammelbegriff. Benannt wird nach (S. 7, DIN EN ISO 10209): der #strong[Darstellung] (Skizze, Zeichnung, Diagramm), dem #strong[Fertigungsmittel] (Transparentzeichnung, CAD-Zeichnung), dem #strong[Entwicklungsstand] (Vorentwurf, Grundlagenzeichnung), dem #strong[Inhalt] (Zusammenbau-, Baugruppen-, Einzelteil-Zeichnung) und dem #strong[Zweck] (Entwurfs-, Fertigungs-, Demontagezeichnung).

#text(fill: teal, weight: "bold")[Erzeugnisgliederung (S. 8, Bild 2-3)]

Ein Erzeugnis wird von oben nach unten zerlegt: #strong[Anlage/System → Gerät/Maschine/Apparat → Baugruppe → Einzelteile]. Fast jeder Fertigungsschritt wird durch eine Zeichnung begleitet, z. B. die Gussform, dann das Drehen, dann die Anordnung in der Baugruppe (S. 8).

#tab(columns: (1fr, 1fr, 1fr),
 th([Zeichnung], [zeigt], [enthält vor allem]),
 [#strong[Einzelteilzeichnung] (S. 9)], [ein einzelnes Teil, das nicht zerstörungsfrei zerlegt werden kann], [vollständige Bemaßung, Toleranzen, Oberflächen, Werkstoff],
 [#strong[Zusammenbauzeichnung] (Gesamtzeichnung, S. 10–11)], [alle Einzelteile eines Erzeugnisses im zusammengebauten Zustand; als Teil-Zusammenbauzeichnung auch nur eine Baugruppe (S. 9)], [Anordnung und Zusammenwirken der Teile, Positionsnummern, nur Haupt- und Anschlussmaße, Stückliste; oft genügt eine Ansicht in Gebrauchslage],
 [#strong[Fertigungszeichnung] (S. 10)], [ein Teil mit allem, was die Fertigung braucht], [Maßstab, vollständige Bemaßung, Werkstoff, Oberflächen- und Kantenzustand, Fertigungsverfahren],
 [#strong[Sammelzeichnung] (S. 10)], [mehrere zusammengehörige Einzelteile auf einem Blatt], [jedes Teil nummeriert und mit Benennung in einer Stückliste; Format und Ansicht möglichst einheitlich],
)

#note("Begriffe (S. 9)", [#strong[Teil] = Gegenstand, den der Anwender nicht weiter aufgliedern muss, z. B. ein ganzes Rillenkugellager. #strong[Einzelteil] = Teil, das nicht zerstörungsfrei zerlegt werden kann, z. B. der Innenring dieses Lagers. #strong[Halbzeug] = Material mit bestimmter Form, bei dem mindestens ein Maß noch offen ist (Bleche, Stangen, Rohre). #strong[Rohteil] = spanlos gefertigtes Teil (z. B. Guss- oder Schmiedestück), das noch bearbeitet werden muss. #strong[Umarbeitsteil] = entsteht aus einem Fertigteil durch weitere Bearbeitung.])

#note("Beispiel Fahrrad (eigene Ergänzung)", [Erzeugnis Fahrrad → Baugruppe Hinterrad → Einzelteil Speiche. Die Gesamtzeichnung des Hinterrads zeigt Nabe, Speichen und Felge zusammen mit Positionsnummern und nur wenigen Maßen (z. B. Raddurchmesser, Einbaubreite). Für die Nabe gibt es eine eigene Einzelteilzeichnung mit allen Maßen.])

#note("Merke", [Gesamtzeichnung = #strong[wie] gehören die Teile zusammen (Hauptmaße, Anschlussmaße). Einzelteilzeichnung = #strong[wie] wird ein Teil hergestellt (alle Maße). Eine Gesamtzeichnung kann auch nur eine Baugruppe zeigen (#strong[B Übung 2.8]).])

Wird eine Zeichnung zu groß und damit für Werkstatt oder Archiv unhandlich, teilt man sie auf #strong[mehrere Blätter] auf: Alle Blätter haben dieselbe Benennung und Zeichnungsnummer, werden durch einen Untertitel unterschieden, und das erste Blatt enthält eine Übersicht aller zusammengehörenden Blätter (S. 10).

#src[B S. 7–12; L-alt A1, überarbeitet.]
#hoch(<a-1>, [Kapitelübersicht])


== 1.5 Positionsnummern und Stückliste <a-1-5>

In der Gesamtzeichnung bekommt jedes Teil eine #strong[Positionsnummer]. Über diese Nummer findet man das Teil in der Stückliste.

- Nummern in #strong[Montagereihenfolge] oder #strong[im Uhrzeigersinn] anordnen, sauber in Reihen oder Spalten.
- Die dünne Bezugslinie endet mit einem #strong[Punkt] innerhalb des Teils oder mit einem #strong[Pfeil] an der Außenkontur. Sie soll nicht parallel zu anderen Linien laufen, damit man sie nicht verwechselt.
- Schrifthöhe der Positionsnummer = #strong[doppelte Maßzahlhöhe], mindestens 5 mm (Liniengruppe 0,5).
- #strong[Identische Teile] bekommen nur eine Nummer, die auch nur einmal in der Zeichnung erscheint; die Menge steht in der Stückliste.

Die #strong[Stückliste] ist das nach Positionsnummern geordnete Verzeichnis aller Einzelteile und neben der Zeichnung das wichtigste Ergebnis der Konstruktion (S. 12). Sie ist Grundlage für die Fertigungsvorbereitung und für kaufmännische Bereiche wie Kalkulation, Bestellwesen und Lager. Die Spalten folgen in Kapitel 4. Eine #strong[Explosionszeichnung] zeigt die Teile auseinandergezogen, meist perspektivisch; man braucht sie z. B. für Kataloge und Montageanleitungen (S. 12, Bild 2-6; Beispiel in Kapitel 13).

#src[B S. 11–12; L-alt A1, überarbeitet.]
#hoch(<a-1>, [Kapitelübersicht])


== 1.6 Skizzen <a-1-6>

Eine Skizze ist eine Freihandzeichnung. Es gibt zwei Arten (S. 13–14):

- #strong[Skizze zum Konstruieren]: Ideen festhalten, Varianten vergleichen, Funktion klären (z. B. wie die Klemmkraft in einer Schraubzwinge wirkt).
- #strong[Skizze als Vorlage] für eine Zeichnung oder für die Fertigung eines Einzelstücks, möglichst proportional.

#note("Merke (S. 14)", [Immer mit den #strong[Mittellinien] beginnen. Sie legen Symmetrie und Lage fest, und alle Ansichten richten sich daran aus. Danach dünne Hilfslinien (bei mehreren Ansichten #strong[über alle Ansichten durchgezogen], damit die Ansichten zueinander passen), erst zum Schluss die sichtbaren Kanten breit nachziehen (Bild 2-9).])

#src[B S. 13–15; L-alt A1, überarbeitet.]

#bild("map-kapitel-01", [Mindmap zu Kapitel 1. Eigene Darstellung nach B S. 1–16.], height: 46mm)

*Der Zusammenhang in Kapitel 1.* Eine Zeichnung wird eindeutig, wenn Formdarstellung, genormte Angaben und Dokumentorganisation zusammenpassen. Zeichnungsart und Stückliste verbinden die Information über das Einzelteil mit seiner Rolle in der Baugruppe.
#src[B S. 1–16; eigene Zusammenfassung.]
#hoch(<a-1>, [Kapitelübersicht])


#pagebreak(weak: true)
= Kapitel 2 · CAD und digitale Produktmodelle <a-2>

#überblick([Kapitel 2 auf einen Blick],
  idee(<a-2-3>, [Das CAD-Modell beschreibt Geometrie intern.], [B-Rep und CSG organisieren Volumen auf unterschiedliche Weise.]),
  idee(<a-2-4>, [Das Modell entsteht aus gezielten Schritten.], [Skizzen und Modellieroperationen bauen die gewünschte Bauteilform auf.]),
  idee(<a-2-5>, [Das Austauschformat folgt dem Verwendungszweck.], [Geometrie, bearbeitbare Informationen und Darstellungsdaten werden unterschiedlich übertragen.]),
  idee(<a-2-6>, [Dokumentation braucht einen verbindlichen Stand.], [Modell und Zeichnung müssen zum freigegebenen Produkt passen.]),
)

#ablauf(
  chunk([Geometrie und Aufbau planen], [Skizze · Bezug · Volumenmodell], ziel: <a-2-3>),
  chunk([Bauteil modellieren], [gezielte Operationen und passende Arbeitstechnik], ziel: <a-2-4>),
  chunk([Daten weitergeben und dokumentieren], [Schnittstelle wählen · verbindlichen Stand sichern], ziel: <a-2-6>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])


Heute wird fast nur noch am Rechner konstruiert. Trotzdem bleibt die Technische Zeichnung wichtig, weil sie den #strong[verbindlichen Stand] einer Konstruktion dokumentiert (S. 17, 33). In diesem Teil lernst du, wie ein 3D-CAD-System intern arbeitet (Volumenmodell aus Grundkörpern und Booleschen Operationen), wie man Bauteile aus der realen Welt in den Rechner bringt (Scanner, Photogrammetrie) und wieder heraus (3D-Druck), welche Austauschformate es gibt und wofür ein Digital Mock-Up gut ist. Für Wirtschaftsingenieure besonders wichtig: wo CAD wirtschaftlich stark ist und wo nicht (eigene Ergänzung: WI-Sicht).

#src[B S. 17–38; überarbeitete Erklärung aus L-alt A2. Eigene Beispiele sind jeweils gekennzeichnet.]

== 2.1 Hardware: Daten rein, Daten raus <a-2-1>

Ein CAD-Arbeitsplatz sieht heute aus wie ein normaler Büroarbeitsplatz (S. 18). Besonders sind nur einige Geräte:

#tab(columns: (1fr, 1fr),
 th([Gerät / Verfahren], [Was es tut]),
 [#strong[Maus, Tastatur]], [Maus: Befehle wählen, Koordinaten digitalisieren, Elemente „anpicken“. Geübte arbeiten mit Tastatur-Kurzbefehlen (Shortcuts) (S. 18)],
 [#strong[3D-Maus]], [Bauteile im virtuellen Raum drehen und bewegen; beidhändiges Arbeiten, hilfreich beim virtuellen Zusammenbau (S. 18)],
 [#strong[Scanner + OCR]], [Papiervorlagen rasterförmig einlesen. Durchgesetzt hat sich nur die Texterkennung (OCR); bei Zeichnungen ist ein Neuaufbau des Modells meist sinnvoller (S. 19)],
 [#strong[3D-Scanner]], [tastet Oberflächen mit Laser ab, Objekt auf Drehteller; Punktewolken werden zu Flächen zusammengesetzt. Als Volumen weiterzuverarbeiten bereitet oft Probleme (S. 19–20)],
 [#strong[Photogrammetrie]], [viele Fotos aus definierten Positionen; aus dem Versatz markanter Punkte werden x-, y-, z-Koordinaten berechnet, daraus Facetten. Für komplexe, empfindliche oder schwer zugängliche Objekte (Libellenflügel, Archäologie, Mars) (S. 20–21)],
 [#strong[VR]], [stereoskopische Darstellung über Powerwall, CAVE (begehbarer Raum) oder VR-Brille; damit Montage- und Wartungsarbeiten früh prüfen (S. 24–25)],
)

#text(fill: teal, weight: "bold")[3D-Druck (additive Fertigung) (S. 22–24)]

Ablauf: CAD-Modell → Export als #strong[STL] (Dreiecksfacetten) → Programm zerlegt das Modell in #strong[Schichten] → Drucker baut Schicht für Schicht auf (Bild 3-6). Sinnvoll bei kleinen Stückzahlen (Ersatzteile), personalisierten Produkten (Zahnprothesen) und Geometrien, die konventionell nicht herstellbar sind (Leichtbau).

#tab(columns: (1fr, 1fr),
 th([Fertigungsart], [Prinzip]),
 [additiv], [Material schichtweise hinzufügen (3D-Druck)],
 [subtraktiv], [Material abtragen: Bohren, Fräsen, Drehen; Standard für größere Stückzahlen],
 [formend], [mechanische oder thermische Kräfte: Biegen, Pressen, Gießen],
 [hybrid], [nicht klar einzuordnen oder mehrere Verfahren kombiniert],
)

#tab(columns: (1fr, 1fr),
 th([Druckverfahren], [So funktioniert es]),
 [#strong[FDM] (Fused Deposition Modelling)], [Kunststoffstrang wird im Druckkopf geschmolzen und Schicht für Schicht abgelegt; bei Überhängen Stützstrukturen nötig],
 [#strong[SLA] (Stereolithographie)], [Laser härtet flüssigen Photopolymer lokal aus; Modell wird schichtweise abgesenkt; nur dieser Kunststoff möglich],
 [#strong[Pulver-Binder] („3D-Print“)], [Pulver wird schichtweise mit Kleber getränkt; auch Metallpulver möglich],
 [#strong[SLS] (Selective Laser Sintering)], [Laser verschmilzt Metallpulver; belastbar und filigran, z. B. Zahnkronen],
)

#src[B S. 17–25; L-alt A2, überarbeitet.]
#hoch(<a-2>, [Kapitelübersicht])


== 2.2 Wie eine CAD-Software aufgebaut ist <a-2-2>

CAD-Software ist im Kern ein Verwaltungsprogramm: #strong[Eingabebaustein] → #strong[Algorithmenteil] (verarbeiten, verknüpfen) → #strong[Ausgabebaustein]. Den Kern bildet die #strong[Datenbasis]; ihr Inhalt ist das #strong[rechnerinterne Modell (RIM)] des Produkts, das CAD-Modell. Unterstützend gibt es eine Datenbank mit vorbereiteten Informationen (S. 25).

Es gibt #strong[linien-, flächen- und volumenbasierte] Systeme. Linienbasierte Systeme sind im Maschinenbau unüblich und werden heute vor allem in der Elektrotechnik für Schaltpläne genutzt (S. 25).

#src[B S. 25; L-alt A2, überarbeitet.]
#hoch(<a-2>, [Kapitelübersicht])


== 2.3 Volumenmodelle: B-Rep und CSG <a-2-3>

#bild("b-csg", [Bild 3-9: Boolesche Operationen an Körpern. B, S. 26 (PDF-S. 37).], height: 45mm)

Ein Volumenmodell enthält das ganze Bauteil in einer Datei. Vorteil: Ansichten aus jedem Blickwinkel lassen sich automatisch erzeugen, und die Ansichten können sich nicht widersprechen (S. 25).


#note("B-Rep (Boundary Representation)", [\
Das Volumen wird über seine #strong[Begrenzungsflächen] beschrieben, ergänzt um #strong[Materialvektoren], die sagen, auf welcher Seite jeder Fläche das Material liegt. Nach jeder Änderung wird das Modell aktualisiert, die Geometrie liegt also immer #strong[explizit] vor (S. 26).])

#note("CSG (Constructive Solid Geometry)", [\
Gespeichert wird die #strong[Entstehungsgeschichte]: welche Grundkörper (Quader, Keil, Zylinder, Torus, Kegel, Kugel …) mit welchen #strong[Booleschen Operationen] verknüpft wurden, als Baumstruktur. Flächen und Kanten werden erst beim „Evaluieren“ berechnet (S. 26–27).])


#bild("alt-a2-1", [Boolesche Operationen am Beispiel Quader und Zylinder (eigene Prinzipskizze, vgl. Bild 3-9, S. 26) Quelle der Skizze: L-alt A2; eigene Darstellung.], height: 56mm)

#note("Merke", [B-Rep speichert #strong[was da ist] (Flächen + Materialseite). CSG speichert #strong[wie es entstanden ist] (Grundkörper + Operationen). Vereinigung = zusammenfügen, Differenz = abziehen (z. B. Bohrung), Durchschnitt = nur das gemeinsame Volumen bleibt.])

#note("Beispiel (eigene Ergänzung)", [Eine Lochscheibe = Zylinder Ø80 × 10 #strong[minus] Zylinder Ø20 (Mittelbohrung) #strong[minus] 4 Zylinder Ø9 (Schraubenlöcher). Eine Welle mit Bund = Zylinder Ø30 × 100 #strong[vereinigt] mit Zylinder Ø40 × 10.])

#src[B S. 25–27; L-alt A2, überarbeitet.]
#hoch(<a-2>, [Kapitelübersicht])


== 2.4 Arbeitstechnik im 3D-CAD <a-2-4>

+ #strong[Datei-Art wählen]: Bauteil, Baugruppe oder Zeichnung; jede hat eine eigene Dateiendung.
+ #strong[Skizze] im Skizzenmodul auf einer Arbeitsebene: Linien, Spiegeln, Verschieben, geometrische Abhängigkeiten (rechtwinklig, tangential, symmetrisch). Die Kontur muss ein #strong[geschlossener Linienzug] sein, sonst entsteht kein Volumen.
+ #strong[Extrudieren] (Profil entlang einer Richtung ziehen) oder #strong[Rotieren] (Profil um eine Achse drehen, z. B. für Drehteile).
+ #strong[Weitere Körper verknüpfen] mit Booleschen Operationen; Details wie Augen, Passfedernuten, Fasen, Radien ergänzen und ggf. vervielfältigen.
+ Der #strong[Modellbaum] zeigt alle Operationen; jede Stufe lässt sich nachträglich ändern.
+ #strong[Zeichnungsableitung]: Ansichten und Schnitte werden aus dem Modell erzeugt und um Bemaßung, Rahmen und Schriftfeld ergänzt; die Zeichnung ist fast ein „Nebenprodukt“.

#note("Achtung", [Auch eine aus CAD abgeleitete Zeichnung muss allen Normen genügen. Das System hilft, Fehler zu vermeiden, ersetzt aber nicht die Kenntnis der Normen (S. 28).], fill: sand)

#text(fill: teal, weight: "bold")[Flächenbasierte Systeme (S. 29–30)]

Grundelement ist die (auch gekrümmte) Fläche, beschrieben über #strong[NURBS] und verändert über #strong[Kontrollpunkte]. Ideal für Design und Freiformflächen. Nachteile: keine volumenbezogenen Operationen wie Volumenberechnung oder Kollisionsprüfung, oft keine Zeichnungsableitung und kein Datenbaum, und es ist nicht garantiert, dass die Flächen lückenlos schließen (was für den 3D-Druck nötig wäre).

#src[B S. 27–28, Bild 3-10/3-11; L-alt A2, überarbeitet.]
#hoch(<a-2>, [Kapitelübersicht])


== 2.5 Schnittstellen <a-2-5>

Daten müssen zwischen CAD, Berechnung, Arbeitsplanung, 3D-Druck und Firmen fließen. Drei Konzepte: direkte Konvertierung ins Zielformat, ein #strong[systemneutrales] Austauschformat, oder ein einheitliches Format mit gemeinsamem Datenzugriff (S. 30).

#tab(columns: (1fr, 1fr),
 th([Format], [Was und wofür]),
 [#strong[DXF]], [Drawing Exchange Format von Autodesk (AutoCAD); Industriestandard für den #strong[2D]-Austausch (Geometrie, Symbole, Bemaßung, Schraffur), später um 3D erweitert; nicht allgemein genormt],
 [#strong[IGES]], [Initial Graphics Exchange Specification; vor allem Geometriedaten, auch Bemaßung, Text, FEM-Daten; heute in STEP weitergeführt],
 [#strong[STEP]], [Standard for the Exchange of Product Model Data; #strong[vollständiges Produktmodell] über den ganzen Lebenszyklus (Partialmodelle), zum Austauschen und Archivieren],
 [#strong[STL]], [Oberfläche aus #strong[Dreiecken] (facettiert); Standard für den #strong[3D-Druck], einfach in Schichten schneidbar],
 [#strong[VDAFS]], [VDA-Flächenschnittstelle für 3D-Kurven und Freiformflächen; wichtig zwischen Autoherstellern und Zulieferern],
)

#note("Merkhilfe (eigene Ergänzung)", [DXF = #strong[D]rawing (2D-Zeichnung) · STEP = #strong[E]verything (ganzes Produkt) · STL = #strong[T]riangles (3D-Druck) · VDAFS = #strong[V]DA (Auto).])

#src[B S. 30–31; L-alt A2, überarbeitet.]
#hoch(<a-2>, [Kapitelübersicht])


== 2.6 Rechnerunterstützte Konstruktion und Dokumentation <a-2-6>

#note("Einordnung der Buchaussage", [B S. 33 beschreibt die Zeichnung als rechtlich relevanten Informationsträger und problematisiert Änderungen in CAD. Das ist der im Buch erklärte Dokumentationsablauf. Für das Verständnis zählt: vollständige Spezifikation, nachvollziehbare Version und Freigabe. Die Aussage ist keine allgemeine Festlegung, dass Produktdaten zwingend auf Papier freigegeben werden müssten.], fill: sand)

#strong[CAD = Computer Aided Design], also rechnerunterstütztes #strong[Konstruieren], nicht nur Zeichnen. Der Unterschied zum Zeichenbrett: Zu jedem Teil entsteht ein rechnerinternes Modell, das für viele Zwecke weiterverwendet wird. #strong[Hauptvorteil] ist die #strong[Durchgängigkeit der Daten] in der Prozesskette Entwicklung – Konstruktion – Fertigung (S. 32).

#tab(columns: (1fr, 1fr),
 th([Konstruktionsart], [Nutzen von CAD (S. 32–33)]),
 [Neukonstruktion], [gering: CAD hilft in der kreativen Phase kaum, neue Lösungen zu finden],
 [Anpassungskonstruktion], [hoch: vorhandene Konstruktionen archivieren und schnell abändern],
 [Variantenkonstruktion], [sehr hoch: ohne parametrisierbare CAD-Modelle kaum noch wirtschaftlich],
)

#note("Merke (S. 33)", [Die Technische Zeichnung bleibt das #strong[rechtlich relevante, verbindliche Dokument], weil ein verlässlich freigegebener und nachvollziehbarer Dokumentationsstand benötigt wird. Nach der Freigabe bekommt sie eine Zeichnungs- und eine #strong[Revisionsnummer]; jede spätere Änderung wird auf der Zeichnung gekennzeichnet, paraphiert und erhöht die Revisionsnummer. Auf Papier können zwei Parteien per Unterschrift zustimmen.])

#note("Wirtschaftlicher Blick", [Nach der Freigabe ist eine Änderung teuer, weil Kunden und Lieferanten zustimmen müssen und alle Folgedokumente (Stückliste, Montage-, Transport-, Betriebsanleitung, Recycling) auf einen bestimmten Zeichnungsstand verweisen und mitgeändert werden müssen (S. 33–34).])

#strong[Papierlos] geht es nur, wenn (S. 34, nach \[Gro20\]): alle Informationen durchgängig im 3D-Modell stehen, das Modell alle geometrischen Details sowie Oberflächen, Kanten und Toleranzen enthält, die Daten alle Lebensphasen bedienen, die Informationen am Arbeitsplatz papierlos abrufbar sind und Begleitpapiere durch ein System wie Barcode ersetzt werden.

#text(fill: teal, weight: "bold")[Digital Mock-Up (DMU) (S. 34–35)]

#tab(columns: (1fr, 1fr),
 th([Anwendung], [Frage, die damit beantwortet wird]),
 [Visualisierung], [Wie sieht das Teil von allen Seiten aus (auch mit VR)?],
 [Packaging, Space Management], [Passt das Teil an seinen Platz, reicht der Montagefreiraum?],
 [Clash & Clearance], [Kollidieren Teile? Ist genug Freigängigkeit da (Kopffreiheit, Fluchtwege)?],
 [Enveloping], [Wie viel zusätzlichen Raum brauchen Teile durch Schwingung oder Wärmedehnung („virtuelle Umkleidung“)?],
 [Virtual Workshop], [Wie viel Platz braucht man bei Montage und Instandhaltung?],
)

Außerdem lassen sich aus dem Modell Stücklisten, Illustrationen und NC-Programme ableiten (S. 35).

#src[B S. 32–35; L-alt A2, überarbeitet.]
#hoch(<a-2>, [Kapitelübersicht])


== 2.7 KI beim Technischen Zeichnen <a-2-7>

KI-Antworten sind nicht wissensbasiert, sondern beruhen auf #strong[Wahrscheinlichkeiten] (welches Wort folgt am wahrscheinlichsten). Deshalb können Zusammenhänge falsch sein. Im Test des Buchs (ChatGPT 2024/2025) zeichnete die KI anfangs kein Pleuel, später ein Pleuel ohne normgerechte Zeichnung; beim Erklären einer Zeichnung erkannte sie vieles, machte aber Fehler und übersah z. B. die Passfedernut. Fazit des Buchs: KI hilft, Probleme zu strukturieren und Sachverhalte erklärt zu bekommen; je präziser die Frage, desto besser die Antwort, aber Details muss man prüfen (S. 38).

#src[B S. 35–38; L-alt A2, überarbeitet.]

#bild("map-kapitel-02", [Mindmap zu Kapitel 2. Eigene Darstellung nach B S. 17–38.], height: 46mm)

*Der Zusammenhang in Kapitel 2.* Das interne Geometriemodell entsteht aus gezielten Modellierschritten. Passende Schnittstellen und ein freigegebener Dokumentationsstand machen es für andere Beteiligte nutzbar.
#src[B S. 17–38; eigene Zusammenfassung.]
#hoch(<a-2>, [Kapitelübersicht])


#pagebreak(weak: true)
= Kapitel 3 · Werkstücke darstellen <a-3>

#überblick([Kapitel 3 auf einen Blick],
  idee(<a-3-1>, [Der Maßstab ändert die Darstellung.], [Das eingetragene Maß beschreibt weiterhin die wirkliche Größe.]),
  idee(<a-3-2>, [Die Linienart trägt Bedeutung.], [Sichtbare, verdeckte und gedankliche Elemente werden unterschiedlich gekennzeichnet.]),
  idee(<a-3-3>, [Ansichten müssen räumlich zusammenpassen.], [Projektionsmethode und Anordnung bestimmen die Zuordnung.]),
  idee(<a-3-5>, [Ein Schnitt macht innere Formen lesbar.], [Schnittverlauf, Schraffur und Ausnahmen gehören zusammen.]),
)

#ablauf(
  chunk([Ansichten und Maßstab wählen], [so viele wie zur eindeutigen Form nötig], ziel: <a-3-3>),
  entscheidung([Sind innere Merkmale ausreichend erkennbar?],
    chunk([Ansichten ausarbeiten], [passende Linienarten verwenden], ziel: <a-3-2>),
    chunk([Schnitt ergänzen], [Schnittverlauf · Schraffur · Ausnahmen prüfen], ziel: <a-3-5>)),
  chunk([Räumliche Übereinstimmung kontrollieren], [alle Ansichten beschreiben denselben Körper], ziel: <a-3-3>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])


Hier lernst du das „Alphabet“ der Zeichnung: in welchem #strong[Maßstab] gezeichnet wird, welche #strong[Linie] was bedeutet, wie die #strong[Ansichten] angeordnet werden und wie man mit #strong[Schnitten] ins Innere eines Bauteils schaut. Dieser Teil ist die Grundlage für alles Weitere und wird in der vorliegenden Altklausur mit Verständnis- und Zeichenaufgaben geprüft.

#src[B S. 39–64; überarbeitete Erklärung aus L-alt B1. Eigene Beispiele sind jeweils gekennzeichnet.]

== 3.1 Maßstäbe <a-3-1>

#text(fill: teal, weight: "bold")[Einfach erklärt]

Jedes Werkstück wird #strong[maßstäblich] gezeichnet, und der Maßstab steht auf der Zeichnung (S. 39). Man wählt ihn so, dass Einzelheiten erkennbar sind, der Gesamteindruck aber erhalten bleibt; danach richtet sich das Blattformat. Vorzugsweise zeichnet man #strong[1 : 1] (S. 40).

Maßstab M

#form[
$ M  = frac("gezeichnete Länge"  l _(Z), "wirkliche Länge"  l _(W)) $
$ => $
$ l _(Z)  = M   dot  l _(W) $
]

l#sub[Z], l#sub[W] in mm. 1 : 2 heißt: 1 mm auf dem Papier = 2 mm in Wirklichkeit. 2 : 1 heißt: doppelt so groß gezeichnet.

#tab(columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
 th([Art (DIN ISO 5455, Tab. 4-1)], table.cell(colspan: 6, rowspan: 1)[Maßstäbe (Auswahl)]),
 [Vergrößerung], [2 : 1], [5 : 1], [10 : 1], [20 : 1], [50 : 1], [],
 [natürlich], [1 : 1], [], [], [], [], [],
 [Verkleinerung], [1 : 2], [1 : 5], [1 : 10], [1 : 20], [1 : 50], [1 : 100],
)

#note("Merke (S. 40–41)", [


- Die eingetragenen #strong[Maßzahlen] geben immer die #strong[wahre Größe] an, nie die gezeichnete.
- #strong[Winkel] ändern sich durch den Maßstab nicht (60° bleibt 60°).
- #strong[Hauptmaßstab] ins Schriftfeld; weitere Maßstäbe neben Einzelheit oder Schnitt, z. B. „Y 10:1“, „C-D 5:1“.
- Verschiedene Ansichten dürfen verschiedene Maßstäbe haben, aber #strong[nie mehrere Maßstäbe in einer Ansicht] (das Teil wäre verzerrt).
- Handskizzen brauchen keine Maßstabsangabe.
])

#note("Beispiel (eigene Ergänzung)", [Eine Welle ist 480 mm lang. Auf A3 (420 mm breit) passt sie 1 : 1 nicht. Im Maßstab 1 : 2 ist sie 240 mm lang gezeichnet; an der Maßlinie steht trotzdem „480“. Eine kleine Nut von 1,2 mm Breite zeichnest du zusätzlich als Einzelheit „Z 5:1“, dort ist sie 6 mm breit.])

#src[B S. 39–41; L-alt B1, überarbeitet.]
#hoch(<a-3>, [Kapitelübersicht])


== 3.2 Linienarten <a-3-2>

#bild("linienarten", [Eigene Vektordarstellung nach B Tab. 4-2 und Bild 4-2, S. 41–43.], height: 57mm)

Nach #strong[DIN EN ISO 128-2] gibt es nur zwei Linienbreiten: #strong[breit] und #strong[schmal], wobei breit = 2 × schmal. Die Linienbreiten (und Schriftgrößen) sind mit dem Stufensprung √2 gestuft, damit beim Vergrößern oder Verkleinern auf ein anderes A-Format wieder genormte Breiten entstehen (S. 41). Liniengruppe #strong[0,5] (breit 0,5 / schmal 0,25 mm) für A1 bis A4, Liniengruppe #strong[0,7] für A0 (S. 43).

#tab(columns: (1fr, 1fr, 1fr),
 th([Nr.], [Linie], [Anwendungen (Auswahl, S. 41–43)]),
 [1], [#strong[breite Volllinie]], [sichtbare Kanten und Umrisse; Grenze der nutzbaren Gewindelänge; vereinfachte Freistiche],
 [2], [breite Strichlinie], [Kennzeichnung #strong[zulässiger] Oberflächenbehandlung],
 [3], [breite Strich-Punktlinie], [#strong[Schnittlinien] (Schnittverlauf); Zonen mit vorgeschriebener Behandlung, z. B. Wärmebehandlung, Beschichtung],
 [4], [#strong[schmale Volllinie]], [Schraffur; Umrahmung von Einzelheiten; #strong[Maß- und Maßhilfslinien]; Hinweislinien; eingedrehte Querschnitte; kurze Mittellinien; Lichtkanten; Gewindegrund; Diagonalkreuz],
 [5], [schmale Strichlinie], [#strong[verdeckte] Kanten und Umrisse],
 [6], [schmale Strich-Punktlinie], [#strong[Mittel- und Symmetrielinien]; Lochkreise; Teilkreise von Zahnrädern; Bahnlinien],
 [7], [schmale Strich-Zweipunktlinie], [#strong[angrenzende Teile]; Rohteil in Fertigteilzeichnung (und umgekehrt); #strong[Extremstellungen] beweglicher Teile; Teile vor der Schnittebene; alternative Ausführung; Werkzeug; #strong[unzulässige] Oberflächenbehandlung],
 [8], [schmale Freihand-/Zickzacklinie], [Begrenzung abgebrochener oder unterbrochener Darstellungen (Bruchlinie); in einer Zeichnung nur eine der beiden Formen],
)

#note("Achtung (S. 43)", [Mittellinien enden nicht an der Körperkante, sie ragen #strong[sichtbar darüber hinaus]. Strich- und Strich-Punktlinien treffen sich an Ecken und Kreuzungen mit einem #strong[Strich], nie mit einer Lücke. Sehr kurze Mittellinien zeichnet man als schmale Volllinie. Fallen verdeckte Kante und Mittellinie zusammen, hat die #strong[verdeckte Kante Vorrang].], fill: sand)

#note("Merkhilfe (eigene Ergänzung)", [#strong[Breit] = was man am Teil sieht oder was besonders wichtig ist (Kanten, Schnittverlauf, Behandlungszonen). #strong[Schmal] = alles „Drumherum“ (Maße, Schraffur, Mittellinien, Verdecktes, Nachbarteile). Strich-#strong[Zwei]punkt = „das #strong[zweite] Teil“: Nachbarteil, zweite Stellung, zweiter Zustand (Rohteil).])

#src[B S. 41–43, Tab. 4-2, Bild 4-2; L-alt B1, überarbeitet.]
#hoch(<a-3>, [Kapitelübersicht])


== 3.3 Anordnung der Ansichten <a-3-3>

#bild("b-ansichten", [Bilder 4-4/4-5: Ansichten nach Projektionsmethode 1. B, S. 45 (PDF-S. 56).], height: 91mm)
#bild("ak-projektionssymbole", [Eigene Darstellung nach AK 1c, PDF-S. 2, und B Bild 4-6, S. 46.], height: 35mm)
#bild("ak-wuerfel-loesung", [Eigene Zeichenlösung zu AK 2b, PDF-S. 6; technische Axonometrien nach ISO 5456-3 und Europa-Lehrmittel, Räumliche Darstellung.], height: 65mm)

#note("Ergänzt: räumliche Skizzen aus AK 2b", [Isometrische Achsrichtungen: eine Achse senkrecht, zwei um 30° zur Waagerechten; gleiche Zeichenlängen auf allen Achsen. In der üblichen technischen Isometrie zeichnest Du einen 30-mm-Würfel mit 30 mm je Achse. Bei normierter Dimetrie liegen die schrägen Achsen bei ungefähr 7° und 42°; zwei Achslängen sind gleich, die Tiefenachse halbiert. Konstruktionshilfe und Lösung stehen bei den Aufgaben. Diese Angaben ergänzen die orthogonalen Ansichten.])
#src[Ergänzte Zeichenkonventionen: #link("https://cdn.standards.iteh.ai/samples/11503/006c88f9e0b040618800ce7a590d049f/ISO-5456-3-1996.pdf")[ISO 5456-3:1996, Abschnitte 5.1–5.2, S. 2–3]; #link("https://www.europa-lehrmittel.de/leseprobe/24213-1.pdf")[Europa-Lehrmittel, Fachzeichnen für kraftfahrzeugtechnische Berufe, S. 8 (PDF-S. 8), Räumliche Darstellung]; Abruf 24.10.2026.]

#text(fill: teal, weight: "bold")[Einfach erklärt: die Dreitafelprojektion]

Stell dir vor, das Werkstück steht in einer Raumecke aus drei senkrechten Wänden. Man projiziert es senkrecht auf jede Wand und klappt dann zwei Wände in die Zeichenebene (S. 44, Bild 4-3). Nach #strong[DIN ISO 5456], #strong[Projektionsmethode 1] (europäisch), liegt

- die #strong[Draufsicht] (DS) senkrecht #strong[unter] der Vorderansicht,
- die #strong[Seitenansicht von links] (SAL) waagrecht #strong[rechts] neben der Vorderansicht (S. 43–44).

#bild("alt-b1-1", [Projektionsmethode 1 an einem Stufenklotz (eigene Skizze; vgl. Bild 4-4, S. 45) Quelle der Skizze: L-alt B1; eigene Darstellung.], height: 56mm)

#note("Merke", [Es werden nur so viele Ansichten gezeichnet wie nötig: Reichen ein oder zwei, entfällt der Rest; reichen drei nicht, gibt es bis zu #strong[sechs] (zusätzlich Untersicht, Seitenansicht von rechts, Rückansicht; Bild 4-5) (S. 45).])

#text(fill: teal, weight: "bold")[Hauptansicht wählen (S. 44)]

- Möglichst in #strong[Gebrauchslage] (Stehendes nicht liegend zeichnen).
- Alternativ in #strong[Fertigungslage]: Drehteile liegen #strong[waagrecht mit dem dünnen Ende nach rechts] (wie auf der Drehmaschine).
- Oder die Ansicht, die die wesentlichen Merkmale am besten zeigt, mit möglichst #strong[wenig verdeckten Kanten].

#text(fill: teal, weight: "bold")[Projektionsmethode 3 und Pfeilmethode (S. 46–47)]

#tab(columns: (1fr, 1fr, 1fr),
 th([Methode], [Anordnung], [Wo / wann]),
 [#strong[Projektionsmethode 1]], [Draufsicht unten, Seitenansicht von links rechts (Ansicht „wird weggeklappt“)], [Europa (früher „Methode E“)],
 [#strong[Projektionsmethode 3]], [Draufsicht #strong[oben], Seitenansicht von links #strong[links], von rechts rechts, Untersicht unten], [anglo-amerikanisch (früher „Methode A“), DIN EN ISO 128-3],
 [#strong[Pfeilmethode]], [Blickrichtung jeder Ansicht durch Pfeil mit Großbuchstaben, Ansicht mit gleichem Buchstaben frei platziert], [wenn man von der Standardanordnung abweichen will oder schräge Ansichten unverkürzt zeigen möchte],
)

Damit niemand die Methoden verwechselt, wird die Projektionsmethode durch ein #strong[Symbol] nahe dem Schriftfeld gekennzeichnet (Bild 4-6). Verdeckte Kanten zeichnet man #strong[sparsam], nur wenn die Information nicht anders darstellbar ist; zusätzliche Ansichten oder Schnitte sind besser (S. 46).

#note("Achtung", [Bei Methode 3 liegt die Seitenansicht #strong[von links] auch #strong[links]. Bei Methode 1 liegt sie rechts. Wer das vertauscht, zeichnet das Teil spiegelverkehrt.], fill: sand)

#src[B S. 43–46, Bild 4-3 bis 4-6; L-alt B1, überarbeitet.]
#hoch(<a-3>, [Kapitelübersicht])


== 3.4 Vereinfachungen in Ansichten <a-3-4>

#tab(columns: (1fr, 1fr),
 th([Vereinfachung], [Regel]),
 [Klappen um schräge Kanten (Bild 4-8)], [Zusatzansicht senkrecht auf eine schräge Fläche, nur als Teilansicht; Pfeil entfällt, wenn die Blickrichtung eindeutig ist],
 [Vor / nach Bearbeitung (Bild 4-9)], [ein Zustand normal, der andere als schmale #strong[Strich-Zweipunktlinie] in derselben Ansicht],
 [Diagonalkreuz (Bild 4-10)], [schmale Volllinien kennzeichnen eine #strong[ebene Fläche] (z. B. Schlüsselfläche an einer Welle), spart eine Ansicht],
 [Lochkreis eingeklappt (Bild 4-11)], [Löcher eines Flansches in die Zeichenebene geklappt, mit #strong[schmalen] Volllinien],
 [Einzelheit (Bild 4-12)], [Stelle mit schmalem Kreis und Großbuchstaben (bevorzugt vom #strong[Ende des Alphabets], z. B. X, Y, Z) markieren; vergrößert daneben mit Buchstabe und Maßstab, z. B. „Y 10:1“],
 [Bruchdarstellung (S. 60, Bild 4-32)], [lange gleichförmige Abschnitte weglassen; Freihandlinie endet an der Umrisslinie, Zickzacklinie ragt etwas darüber hinaus; gilt für alle Körperformen gleich],
)

#src[B S. 47–49; L-alt B1, überarbeitet.]
#hoch(<a-3>, [Kapitelübersicht])


== 3.5 Schnitte und Schraffur <a-3-5>

#bild("b-schnitte", [Bild 4-21: Vollschnitt, Halbschnitt und Teilschnitt. B, S. 53 (PDF-S. 64).], height: 61mm)

#text(fill: teal, weight: "bold")[Einfach erklärt]

Verdeckte Kanten machen eine Zeichnung schnell unübersichtlich. Besser: Man #strong[schneidet das Teil gedanklich auf], nimmt die vordere Hälfte weg und zeichnet, was man dann sieht. Die Schnittfläche wird schraffiert (S. 49–50, Bild 4-13/4-14).

#note("Fünf Grundregeln der Schraffur (S. 50)", [


+ Die Schnittfläche wird durch geneigte Schraffurlinien gekennzeichnet,
+ in #strong[schmaler] Linienbreite,
+ grundsätzlich unter #strong[45°] zur Mittellinie bzw. zum Hauptumriss,
+ alle Schnittflächen #strong[eines] Bauteils werden #strong[identisch] schraffiert (auch in verschiedenen Ansichten, Bild 4-17),
+ im Schnitt werden #strong[keine verdeckten Kanten] gezeichnet.
])

- #strong[Aneinanderstoßende Teile] bekommen eine andere Richtung (45° bleibt) oder, wenn das nicht geht, einen anderen Abstand (Bild 4-16).
- Laufen Schraffur und Kanten fast parallel, darf der #strong[Winkel angepasst] werden; #strong[große Flächen] dürfen nur am Rand schraffiert werden (Randschraffur, Bild 4-18/4-19).
- #strong[Werkstoffschraffuren] (S fest, L flüssig, G gasförmig; SN Naturstoff, SM Metall, SP Kunststoff; Bild 4-15) sind nicht mehr genormt, aber noch verbreitet. Normalerweise schraffiert man unabhängig vom Werkstoff (S. 50–51).
- #strong[Teileverbände] (z. B. Wälzlager): einheitlich schraffiert, wenn sie als eine Einheit mit einer Positionsnummer gelten; unterschiedlich, wenn die Montage im Vordergrund steht (S. 52).

#text(fill: teal, weight: "bold")[Schnittarten (S. 53–55)]


#bild("alt-b1-2", [Halbschnitt einer Buchse, waagrechte Achse (eigene Skizze) Quelle der Skizze: L-alt B1; eigene Darstellung.], height: 56mm)


#tab(columns: (1fr, 1fr),
 th([Schnitt], [zeigt]),
 [#strong[Vollschnitt]], [Teil komplett durchgeschnitten; Standard für hohle Teile],
 [#strong[Halbschnitt]], [halb Ansicht, halb Schnitt; wenn auch außen etwas Wichtiges zu sehen ist. Nur die #strong[Mittellinie] trennt beide Hälften (keine Volllinie!), keine verdeckten Kanten. Senkrechte Achse: #strong[links Ansicht]; waagrechte Achse: #strong[oben Ansicht] (S. 53–54)],
 [#strong[Teilschnitt]], [als #strong[Ausbruch] (begrenzt durch Freihand- oder Zickzacklinie, die nicht auf Kanten liegen darf) oder als #strong[Teilausschnitt] (Einzelheit, Schraffur endet an gedachter gerader Kante)],
)


#strong[Profilschnitte] (Querschnitte, Bild 4-24): in die Ansicht #strong[hineingedreht] mit #strong[schmalen] Volllinien, #strong[neben] die Ansicht gezeichnet mit #strong[breiten] Volllinien (S. 54–55).

#src[B S. 49–53; L-alt B1, überarbeitet.]
#hoch(<a-3>, [Kapitelübersicht])


== 3.6 Was nicht geschnitten wird <a-3-6>

Ein Schnitt soll Inneres zeigen. Teile, die #strong[in Längsrichtung] getroffen werden und #strong[keine Hohlräume] haben, zeigen innen nichts Neues und werden deshalb auch im Vollschnitt #strong[nicht geschnitten]: #strong[Wellen, Stifte, Bolzen, Passfedern, Keile, Schrauben, Niete, Kugeln] (Wälzkörper).

#note("Beispiel (eigene Ergänzung)", [In der Schnittzeichnung eines Getriebes ist das Gehäuse schraffiert, die Welle darin aber voll gezeichnet (nicht schraffiert), ebenso die Passfeder und die Schrauben des Deckels. Wird eine Welle dagegen #strong[quer] geschnitten (Profilschnitt), wird sie schraffiert.])

#note("Merkhilfe „WeSBo-PaKS-NiKu“ (eigene Ergänzung)", [#strong[We]llen, #strong[S]tifte, #strong[Bo]lzen, #strong[Pa]ssfedern, #strong[K]eile, #strong[S]chrauben, #strong[Ni]ete, #strong[Ku]geln.])

#src[B S. 56, Bild 4-25/4-26; L-alt B1, überarbeitet.]
#hoch(<a-3>, [Kapitelübersicht])


== 3.7 Schnittlinien und Schnittverlauf <a-3-7>

#bild("b-schraffur", [Bild 4-16: Aneinandergrenzende Schnittflächen. B, S. 51 (PDF-S. 62).], height: 42mm)

- Ist der Schnittverlauf nicht eindeutig, wird er mit einer #strong[breiten Strich-Punktlinie] gekennzeichnet, die an Anfang und Ende etwas ins Bauteil ragt; bei abgeknicktem Schnitt auch an jedem #strong[Knickpunkt] (Bild 4-29).
- #strong[Pfeile] an Anfang und Ende zeigen die Blickrichtung, Spitze auf die Schnittlinie, etwa #strong[1,5-mal so lang] wie Maßpfeile.
- #strong[Großbuchstaben] am Anfang und Ende („A–A“), mindestens eine Schriftgröße größer als die Maßzahlen; die Schnittdarstellung trägt dieselbe Bezeichnung.
- Profilschnitte länglicher Teile (Wellen) dürfen direkt #strong[unter] der Schnittebene liegen; bei symmetrischen Profilen entfallen die Buchstaben, wenn die Mittellinien verbunden sind (Bild 4-28).
- Geknickte Schnitte dürfen auch #strong[schräg] verlaufen (z. B. Flansch, Bild 4-30). Verschiedene parallele Schnittebenen werden durch eine Bruchlinie oder durch #strong[versetzte Schraffur] (gleicher Winkel und Abstand) getrennt (Bild 4-31).

#src[B S. 56–59; L-alt B1, überarbeitet.]

#bild("map-kapitel-03", [Mindmap zu Kapitel 3. Eigene Darstellung nach B S. 39–64.], height: 46mm)

*Der Zusammenhang in Kapitel 3.* Maßstab und Linien bilden das Alphabet. Ansichten ordnen die Raumrichtungen zu, Schnitte machen verborgene Merkmale lesbar; alle Darstellungen müssen denselben Körper beschreiben.
#src[B S. 39–64; eigene Zusammenfassung.]
#hoch(<a-3>, [Kapitelübersicht])


#pagebreak(weak: true)
= Kapitel 4 · Bemaßung und Dokumentation <a-4>

#überblick([Kapitel 4 auf einen Blick],
  idee(<a-4-1>, [Die Funktion bestimmt die nötigen Angaben.], [Geometrische Produktspezifikation verknüpft Gestalt und Anforderungen.]),
  idee(<a-4-3>, [Maße müssen vollständig und eindeutig sein.], [Doppelte oder widersprüchliche Festlegungen erschweren Fertigung und Prüfung.]),
  idee(<a-4-4>, [Der Bezug folgt Funktion und Fertigung.], [Die Maße sollen mit dem vorgesehenen Herstellungsablauf zusammenpassen.]),
  idee(<a-4-7>, [Der Dokumentstand gehört zur technischen Aussage.], [Schriftfeld, Stückliste und Änderungen ordnen die Angaben eindeutig zu.]),
)

#ablauf(
  chunk([Funktion und Bezug klären], [wichtige Merkmale und Fertigungsablauf], ziel: <a-4-4>),
  chunk([Maße und Sonderzeichen eintragen], [vollständig · eindeutig · gut lesbar], ziel: <a-4-3>),
  chunk([Dokumentation prüfen], [Schriftfeld · Stückliste · Änderungsstand], ziel: <a-4-7>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])


Die Bemaßung sagt, #strong[wie groß] jedes Formelement ist. Sie muss vollständig und eindeutig sein und soll sich nach der #strong[Fertigung] richten: Wer an der Drehmaschine steht, soll jedes Maß direkt ablesen können, ohne zu rechnen. Dazu kommen Sonderzeichen (Ø, R, SW, M …), die Regeln für Schriftfeld und Stückliste und der Umgang mit Änderungen. Für Wirtschaftsingenieure wichtig: Schriftfeld und Stückliste sind die Schnittstelle zu Einkauf, Kalkulation und Dokumentenverwaltung (eigene Ergänzung: WI-Sicht).

#src[B S. 65–106; überarbeitete Erklärung aus L-alt B2. Eigene Beispiele sind jeweils gekennzeichnet.]

== 4.1 Geometrische Produktspezifikation (GPS) <a-4-1>

Bemaßung (Kapitel 4), Oberflächen (C1) und Toleranzen (C2) beschreiben zusammen die #strong[ideale Geometrie] und ihre #strong[zulässigen Abweichungen]. Dieses Gesamtsystem heißt #strong[Geometrische Produktspezifikation (GPS)], Übersichtsnorm DIN EN ISO 14638 (S. 65). Der Grundgedanke: #strong[Spezifikation, Fertigung und Prüfung] beeinflussen sich gegenseitig und müssen zusammenpassen.

Die #strong[GPS-Matrix] hat 18 Zeilen (Merkmale: Maß, Abstand, Radius, Winkel, Form, Richtung, Lage, Lauf, Bezüge, Rauheit, Welligkeit, Primärprofil, Oberflächenunvollkommenheit, Kanten) und 6 Spalten, die #strong[Kettenglieder]: 1–2 Spezifikation (Zeichnungssprache), 3 Vergleich Soll mit Ist, 4 Messmethoden/Auswertung, 5 Messgeräte, 6 Kalibrierung (S. 66–67, Tab. 5-1).

#note("Beispiel (eigene Ergänzung)", [„Ø40 h6“ auf der Zeichnung ist Kettenglied 1–2. Wie der Prüfer den Ist-Durchmesser mit dem Sollmaß vergleicht (Zweipunktmessung? Hüllzylinder?), regeln Kettenglied 3–4. Womit er misst (Bügelmessschraube) und wie diese kalibriert ist, regeln 5–6.])

#src[B S. 65–67; L-alt B2, überarbeitet.]
#hoch(<a-4>, [Kapitelübersicht])


== 4.2 Normschrift <a-4-2>

- Normschrift nach #strong[DIN EN ISO 3098], wichtigste Form: #strong[Schriftform B, vertikal].
- Linienbreite = #strong[1/10 der Schrifthöhe]; Nenngröße = Höhe der Großbuchstaben.
- Nenngrößen #strong[2,5 – 3,5 – 5 – 7 mm] (Linienbreiten 0,25 – 0,35 – 0,5 – 0,7 mm), gestuft mit √2, damit beim Vergrößern (141 %) oder Verkleinern (70,7 %) wieder Normgrößen entstehen. Mindestens 2,5 mm.

#src[B S. 67–68; L-alt B2, überarbeitet.]
#hoch(<a-4>, [Kapitelübersicht])


== 4.3 Grundregeln der Maßeintragung <a-4-3>

#bild("b-masshilfslinien", [Bild 5-4: Besondere Maßhilfslinien. B, S. 70 (PDF-S. 81).], height: 38mm)

#tab(columns: (1fr, 1fr, 1fr),
 th([Bemaßungsart (Tab. 5-2)], [Ziel], [Merkmal]),
 [#strong[funktionsbezogen]], [Funktion, Zusammenpassen der Teile], [Toleranzen sichern störungsfreie Funktion],
 [#strong[fertigungsbezogen]], [Fertigung ohne Umrechnung], [abhängig vom Fertigungsverfahren; Bemaßung von Bezugsebenen aus],
 [#strong[prüfbezogen]], [direkte Prüfung der Maßhaltigkeit], [abhängig vom Prüfverfahren; Kettenmaße sinnvoll],
)

Einzelteilzeichnungen sind meist Fertigungszeichnungen, also #strong[fertigungsbezogen] bemaßt. Regeln nach #strong[DIN EN ISO 129-1] (früher DIN 406):

#note("Merke: vier Grundregeln (S. 69)", [


+ Maße gelten für den #strong[Endzustand], den die Zeichnung zeigt (Rohteil, Zwischenzustand oder Fertigteil).
+ #strong[Jedes Maß nur einmal], in nur einer Ansicht.
+ Einzelteilzeichnung: #strong[vollständig]; was sich von selbst ergibt (z. B. Durchdringungskurven), wird nicht bemaßt.
+ Einheit #strong[mm ohne Angabe]; andere Einheiten hinter die Zahl („4,8 m“). #strong[Winkel immer mit Einheit] („45°“).
])


#bild("alt-b2-1", [Elemente einer Maßangabe (eigene Skizze, vgl. Bild 5-3) Quelle der Skizze: L-alt B2; eigene Darstellung.], height: 56mm)


#strong[Elemente]: Maßlinie, Maßhilfslinie, Maßlinienbegrenzung (Pfeil), Nennmaßwert (S. 69).

- Maß- und Maßhilfslinien: #strong[schmale Volllinie], möglichst an sichtbaren Kanten; Mittellinien dürfen als Maßhilfslinie dienen.
- Abstand Maßlinie – Kante ca. #strong[10 mm], Maßlinien untereinander gleich, mindestens #strong[7 mm]; Maßhilfslinie #strong[1–2 mm] über die Maßlinie hinaus.
- Maßlinien schneiden sich nicht und liegen nicht parallel zur Schraffur; Maßhilfslinien #strong[nie über mehrere Ansichten].


- Maße möglichst nach #strong[Normzahlen (DIN 323)] wählen: standardisiert Werkzeuge, Prüflehren, Halbzeuge (S. 70).
- Maßzahlen mindestens #strong[3,5 mm] hoch (nie unter 2,5 mm), Schriftform B.
- Maßzahlen werden #strong[von keiner Linie gekreuzt]: Hilfslinien unterbrechen, Schraffur um die Zahl aussparen.
- Leserichtung nach DIN EN ISO 129-1: #strong[von unten und von rechts] lesbar (zwei Hauptleserichtungen, Bild 5-5); nie mit der Ein-Leserichtungs-Methode mischen.
- 6, 9, 66, 99 dürfen einen Punkt bekommen („6.“), damit man sie nicht verwechselt. Bei kurzen Maßlinien Pfeile und notfalls Zahl nach außen (möglichst rechts) setzen (Bild 5-6).

#src[B S. 68–71; L-alt B2, überarbeitet.]
#hoch(<a-4>, [Kapitelübersicht])


== 4.4 Fertigungsgerechte Bemaßung <a-4-4>

Fertigungsgerecht heißt: Die Bemaßung folgt den #strong[Bearbeitungsschritten], und in der Werkstatt muss #strong[kein Maß umgerechnet] werden (S. 72).

#bild("alt-b2-2", [Drehteil fertigungsgerecht bemaßt: Längen von der linken Planfläche aus, Durchmesser mit Ø (eigene Skizze, vgl. Bild 5-8) Quelle der Skizze: L-alt B2; eigene Darstellung.], height: 56mm)

#tab(columns: (1fr, 1fr),
 th([Verfahren], [Regeln für die Bemaßung]),
 [#strong[Drehen] (S. 72–76, Bild 5-8/5-9)], [Axial (Vorschubrichtung) von einer #strong[Bezugsebene] aus, die zuerst plangedreht wird; wird #strong[umgespannt], braucht man #strong[zwei Bezugsebenen]. Radial (Zustellrichtung) als #strong[Durchmesser]. Fasen, Radien, Einstiche separat (mit Position).],
 [#strong[Fräsen] (S. 76–79, Bild 5-11/5-12)], [Zuerst alle sechs Seiten planfräsen, damit jede Seite Bezug sein kann. Wenige Bezugsebenen; eingespannte Seiten können nicht gleichzeitig Bezug sein. Maße so, dass der #strong[Fräserweg] ablesbar ist. #strong[Mittige Nuten] brauchen keine Lageangabe. Flächen aus dem Werkzeugauslauf werden nicht bemaßt.],
 [#strong[Bohren] (S. 79–82, Bild 5-14/5-15)], [Bei Gewindebohrungen nur das #strong[Gewinde-Nennmaß] (Kernloch ist durch DIN 13 festgelegt). #strong[Tiefe] von Kernloch und nutzbarer Gewindelänge angeben, von einer Bezugsfläche. Durchmesser, Tiefe und möglichst Position in #strong[einer] Ansicht. Bohrerspitze (120° bei Stahl) wird #strong[gezeichnet, aber nicht bemaßt].],
)

#note("Beispiel Drehteil (Bild 5-9)", [Rohteil absägen (1–2 mm Aufmaß) → einspannen → Stirnseite plandrehen = Bezugsebene „0“ → Absatz auf Ø drehen, Länge von der Bezugsebene messen → Fasen → Nut einstechen → umspannen, andere Stirnseite plandrehen = neue Bezugsebene → großen Ø, kleinen Absatz, Fasen. Deshalb hat die Zeichnung zwei Bezugsebenen.])

#src[B S. 71–82; L-alt B2, überarbeitet.]
#hoch(<a-4>, [Kapitelübersicht])


== 4.5 Sonderzeichen (Eigenschaftsindikatoren) <a-4-5>

#bild("b-radius", [Bild 5-17: Radiusbemaßungen. B, S. 83 (PDF-S. 94).], height: 68mm)

Das Zeichen steht #strong[vor] der Maßzahl und hat dieselbe Linienbreite wie die Schrift (S. 82).

#tab(columns: (1fr, 1fr, 1fr),
 th([Zeichen], [Bedeutung], [Regel / Beispiel]),
 [#strong[Ø]], [Durchmesser], [Ø40; bei Platzmangel von außen, Zahl auf Höhe der abgebrochenen Maßlinie (S. 82–83)],
 [#strong[R]], [Radius], [R5; Maßlinie aus Richtung des Mittelpunkts, nur ein Pfeil am Bogen; gleiche Radien per Vermerk „nicht bemaßte Radien R = 3“; Radien nach DIN 250 (S. 83–84)],
 [#strong[SØ / SR]], [Kugel (Sphere)], [SØ bei bemaßtem Mittelpunkt, sonst SR; S immer vor Ø bzw. R (S. 84)],
 [#strong[SW]], [Schlüsselweite], [Abstand zweier paralleler Flächen, mit Hinweislinie, wenn nicht mit Maßlinie bemaßbar; oft mit Diagonalkreuz (S. 84)],
 [#strong[M, Tr …]], [Gewinde], [M12 = metrisches ISO-Gewinde; Tr = Trapezgewinde usw. (S. 85, Kapitel 7)],
 [#strong[□]], [Quadrat], [□20: nur eine Seite bemaßt, möglichst in der Ansicht, in der das Quadrat zu sehen ist (S. 85)],
 [#strong[]], [Bogenlänge], [Halbkreis vor der Zahl; bis 90° Maßhilfslinien parallel zur Winkelhalbierenden, darüber zum Mittelpunkt (S. 86)],
 [#strong[( )]], [Hilfsmaß], [(120): ergibt sich aus anderen Maßen, nur zur Information, nicht maßgeblich (S. 86–87)],
 [#strong[◺ 1:10]], [Neigung], [rechtwinkliges Dreieck, als Verhältnis oder % (S. 87)],
 [#strong[▷ 1:5]], [Verjüngung], [gleichschenkliges Dreieck, für zweiseitig symmetrische Verjüngungen (Kegel, Pyramide) (S. 87)],
 [Kegel / Senkung], [ohne Zeichen], [Kegel: zwei Ø und Länge, halber Kegelwinkel als Hilfsmaß; Senkung: Senkwinkel + Senktiefe oder Senkdurchmesser (S. 88–89)],
 [#strong[3 × 45°]], [45°-Fase], [nur bei 45° dürfen Länge und Winkel zusammen stehen; sonst Länge und Winkel getrennt; Fasenlänge zählt zur Bauteillänge (S. 89)],
 [#strong[\[ \]]], [Rohmaß], [Roh- oder Vorbearbeitungsmaß in der Fertigteilzeichnung (Rohteilkontur als Strich-Zweipunktlinie); Erklärung über dem Schriftfeld (S. 90)],
 [#strong[t = 5]], [Dicke], [Flachteile (Bleche), spart eine Ansicht; weitere Maßbuchstaben b, h, l (S. 90)],
 [40], [Prüfmaß], [Rahmen mit runden Ecken: wird von der Qualitätssicherung geprüft, ggf. „100 %“ (S. 90)],
 [40], [theoretisch genaues Maß], [rechteckiger Rahmen: Maß #strong[ohne Toleranz], Basis z. B. für Positionstoleranzen (S. 91)],
 [gestreckte Länge, Mess-Stelle], [Abwicklung, Messpunkt], [eigene Symbole nach DIN EN ISO 129-1 (S. 91)],
 [#strong[Ⓜ Ⓔ]], [Maximum-Material-Bedingung, Hüllbedingung], [Tolerierungsgrundsätze, siehe Kapitel 6 (S. 92)],
)

#note("Achtung", [Runde Klammern ( ) = Hilfsmaß, eckige Klammern \[ \] = Rohmaß. Rahmen mit #strong[runden] Ecken = Prüfmaß, #strong[eckiger] Rahmen = theoretisch genaues Maß. Diese vier werden in Klausuren gern verwechselt.], fill: sand)

#src[B S. 82–92; L-alt B2, überarbeitet.]
#hoch(<a-4>, [Kapitelübersicht])


== 4.6 Vereinfachungen und Bemaßungsarten <a-4-6>

#bild("b-bemassungsarten", [Bilder 5-37/5-38: Parallel- und steigende Bemaßung. B, S. 94 (PDF-S. 105).], height: 78mm)

- #strong[Maßbuchstaben mit Tabelle] für Varianten: Kleinbuchstaben (keine Großbuchstaben, kein „o“); Zeichen wie Ø stehen in der Tabelle vor dem Wert; m und z nicht anders belegen (S. 92).
- #strong[Teilungen]: erstes Element mit Größe und Lage, Abstand zum zweiten, dann „Anzahl × Teilung (= Gesamtmaß)“, z. B. „6 × 25° (= 150°)“. Bei 2 oder 4 gleichmäßig verteilten Löchern entfällt der Teilungswinkel (S. 92–93).
- #strong[Hinweislinien] für Fasen und Bohrungen; die Linie zeigt auf eine Körperfläche: von außen = Vollkörper, von innen = Hohlkörper (S. 94).

#tab(columns: (1fr, 1fr),
 th([Bemaßungsart], [Prinzip (S. 94–95)]),
 [Parallelbemaßung], [Maßlinien parallel in bis zu drei senkrechten Richtungen oder konzentrisch (Standard bisher)],
 [steigende Bemaßung], [je Richtung meist nur eine Maßlinie vom Ursprung „0“, an jeder Maßhilfslinie ein Pfeil; Gegenrichtung mit Minus],
 [Koordinatenbemaßung], [Punkte über kartesische oder Polarkoordinaten, oft in einer Tabelle; erleichtert NC-Programmierung],
)

#strong[3D-Bemaßung] nach ISO 16792: Maße direkt am 3D-Modell. Die Beschriftung muss beim Drehen lesbar bleiben, darf sich nicht überlappen und das Modell nicht verdecken; Modelle haben mindestens ein Koordinatensystem; Mittellinien sind optional. Vorher muss klar sein, ob Zeichnung, Datensatz oder Modell das führende „Originaldokument“ ist (S. 96–97).

#src[B S. 92–97; L-alt B2, überarbeitet.]
#hoch(<a-4>, [Kapitelübersicht])


== 4.7 Schriftfeld nach DIN EN ISO 7200 <a-4-7>

#bild("b-schriftfeld", [Bild 5-42: Schriftfeld nach DIN EN ISO 7200. B, S. 98 (PDF-S. 109).], height: 32mm)

Das Schriftfeld identifiziert Zeichnung, Bauteil und Eigentümer und enthält Verwaltungsangaben. Fest vorgeschrieben ist nur die #strong[Breite 180 mm] (passt auf A4); es steht immer #strong[unten rechts] (hoch und quer) und ist so nach dem Falten oben sichtbar (S. 98).

#tab(columns: (1fr, 1fr, 1fr),
 th([Gruppe], [Pflichtfelder (P)], [optionale Felder]),
 [identifizierend], [#strong[gesetzlicher Eigentümer], #strong[Sachnummer] (früher Zeichnungsnummer), #strong[Ausgabedatum], #strong[Blattnummer]], [Änderungsindex (1, 2 … / A, B …), Anzahl der Blätter, Sprachenzeichen („de“)],
 [beschreibend], [#strong[Titel] (ohne Abkürzungen, ca. 25 Zeichen)], [zusätzlicher Titel],
 [administrativ], [#strong[genehmigende Person], #strong[Ersteller], #strong[Dokumentenart]], [verantwortliche Abteilung, technische Referenz, Klassifikation, Dokumentenstatus („in Bearbeitung“, „freigegeben“, „zurückgezogen“), Papierformat],
)

#note("Merkhilfe für die 8 Pflichtfelder: „ESAB-T-GED“ (eigene Ergänzung)", [#strong[E]igentümer, #strong[S]achnummer, #strong[A]usgabedatum, #strong[B]lattnummer · #strong[T]itel · #strong[G]enehmigt von, #strong[E]rsteller, #strong[D]okumentenart.])

Maßstab, Projektionsmethode, Toleranz- und Oberflächenangaben sind keine Pflichtfelder; sie stehen außerhalb oder in einer #strong[Erweiterung] des Schriftfelds (S. 98). Die #strong[technische Referenz] muss zur Organisation des Eigentümers gehören und darf ohne Revision geändert werden (S. 100). Ohne Änderungsindex müssen sich Versionen über das Ausgabedatum unterscheiden lassen (S. 99).

#src[B S. 98–101; L-alt B2, überarbeitet.]
#hoch(<a-4>, [Kapitelübersicht])


== 4.8 Stückliste und Zeichnungsänderungen <a-4-8>

Zur Gesamtzeichnung gehört stets eine Stückliste: Verzeichnis aller Einzelteile #strong[einschließlich Normteile], sinnvollerweise auch Hilfsstoffe (Kleber, Reiniger, Beschichtungen), damit man sie z. B. bei Gesetzesänderungen schnell findet. Die Norm DIN 6771 für den Aufbau wurde #strong[2007 zurückgezogen]; Unternehmen gestalten Stücklisten seither individuell (S. 101).

#note("Widerspruch im Buch", [Auf S. 12 steht „Auch Stücklisten sind genormt“, auf S. 101 dagegen, dass die Stücklistennorm DIN 6771 im Oktober 2007 zurückgezogen wurde. Aktueller Stand laut Buch ist S. 101: Es gibt keine gültige Norm mehr für den Stücklistenaufbau. Prüfe, was eure Vorlesung dazu sagt.])

#tab(columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
 th([Pos.], [Menge], [Einheit], [Benennung], [Sachnummer], [Bemerkung / Normbezeichnung]),
 [1], [1], [Stck.], [Gehäuse], [40.100.000.010], [EN-GJL-250],
 [2], [4], [Stck.], [Zylinderschraube], [8MZ.5X16], [DIN 6912 – M5 × 16 – 8.8],
)

Grundspalten nach S. 102; Werte angelehnt an Tab. 14-1, S. 274. Erweiterbar z. B. um Werkstoff und Gewicht.

- #strong[Stückliste auf der Zeichnung] (auf das Schriftfeld gesetzt): Überschrift unten, von #strong[unten nach oben] füllen.
- #strong[Lose Stückliste] (A4 hoch, eigene Blätter): Überschrift oben, von #strong[oben nach unten] füllen; hat sich wegen der Datenverarbeitung durchgesetzt (S. 102).

#strong[Änderungen] (S. 102): Hat die Zeichnung das Büro noch nicht verlassen, ändert man nur sie. Ist sie freigegeben oder verteilt, sind weitergehende, betriebsabhängige Schritte nötig. Bei großen Änderungen gibt es eine neue Zeichnung, die alte wird „zurückgezogen“ (auch die lose Stückliste anpassen!). Kleine Änderungen kennzeichnet man an der Stelle, z. B. mit einem #strong[Buchstaben im Kreis] (Bild 5-45), und erhöht den Änderungsindex.

#src[B S. 101–102; L-alt B2, überarbeitet.]

#bild("map-kapitel-04", [Mindmap zu Kapitel 4. Eigene Darstellung nach B S. 65–106.], height: 46mm)

*Der Zusammenhang in Kapitel 4.* Die Funktion legt fest, was maßlich bestimmt sein muss. Fertigungsablauf und Bezugssystem bestimmen eine eindeutige Maßeintragung; Schriftfeld und Stückliste ordnen sie dem richtigen Stand zu.
#src[B S. 65–106; eigene Zusammenfassung.]
#hoch(<a-4>, [Kapitelübersicht])


#pagebreak(weak: true)
= Kapitel 5 · Oberflächen und Kanten <a-5>

#überblick([Kapitel 5 auf einen Blick],
  idee(<a-5-1>, [Die Funktion bestimmt die benötigte Oberfläche.], [Eine feinere Forderung muss technisch begründet sein.]),
  idee(<a-5-3>, [Rauheitskennwerte beschreiben verschiedene Eigenschaften.], [Messgröße und Auswertung entscheiden darüber, was der Zahlenwert aussagt.]),
  idee(<a-5-4>, [Das Symbol übersetzt die Forderung in die Zeichnung.], [Kennwert, Eintragungsstelle und verwendete Normfassung müssen zusammenpassen.]),
  idee(<a-5-9>, [Kanten und Behandlungen ergänzen die Oberfläche.], [Kantenzustand, Wärmebehandlung und Beschichtung sind eigene Anforderungen.]),
)

#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Funktion], [Reibung · Dichtung · Herstellung], ziel: <a-5-1>),
  pfeil(beschriftung: [bestimmt]),
  chunk([Oberflächenforderung], [Kennwert · Messung · Symbol], ziel: <a-5-3>),
  pfeil(beschriftung: [wird lesbar als]),
  chunk([Zeichnungseintrag], [Oberfläche · Kante · Behandlung], ziel: <a-5-6>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])


Maße allein reichen nicht: Eine Lagerstelle muss glatt sein, eine Gussfläche darf rau bleiben. Buchkapitel 6 zeigt, wie man #strong[Rauheit] misst (Ra, Rz), wie man sie mit dem #strong[Oberflächensymbol] in die Zeichnung schreibt und wie man #strong[Wärmebehandlung], #strong[Beschichtung] und #strong[Kantenzustand] angibt. Für Wirtschaftsingenieure ist der Kostenaspekt zentral (eigene Ergänzung: WI-Sicht): Jede feinere Oberfläche bedeutet einen zusätzlichen, teuren Arbeitsgang. Deshalb gilt: #strong[„So grob wie möglich, so fein wie nötig“] (S. 117).

#src[B S. 107–130; überarbeitete Erklärung aus L-alt C1. Eigene Beispiele sind jeweils gekennzeichnet.]

== 5.1 Warum Oberflächen angeben? <a-5-1>

Die Oberfläche bestimmt, ob ein Bauteil seine Funktion erfüllt. Das Buch nennt als Beispiele (S. 107): die Lauffläche einer #strong[Kolbenstange im Hydraulikzylinder] (Dichtung darf nicht verschleißen), die Lauffläche eines #strong[Radial-Wellendichtrings], #strong[Wälzlagersitze], Dichtflächen von #strong[Flanschen], #strong[medizinische Instrumente] (Reinigbarkeit) und die #strong[Spaltmaße an Karosserien] (Optik). Die Oberfläche beeinflusst Verschleiß, Reibung, Dichtheit, Verschmutzungsneigung und Beschichtbarkeit (S. 112).

#src[B S. 107; L-alt C1, überarbeitet.]
#hoch(<a-5>, [Kapitelübersicht])


== 5.2 Oberflächen und Gestaltabweichungen (DIN 4760) <a-5-2>

#text(fill: teal, weight: "bold")[Drei Oberflächenbegriffe]

#tab(columns: (1fr, 1fr),
 th([Begriff], [Bedeutung]),
 [#strong[geometrische Oberfläche]], [die ideale Oberfläche, wie sie die Zeichnung (Nennmaße) beschreibt, ohne jede Abweichung],
 [#strong[wirkliche Oberfläche]], [die tatsächlich vorhandene Oberfläche, die das Werkstück vom Umgebungsmedium trennt],
 [#strong[Istoberfläche]], [das #strong[messtechnisch erfasste], angenäherte Abbild der wirklichen Oberfläche; hängt vom Messverfahren ab],
)

#text(fill: teal, weight: "bold")[Gestaltabweichungen 1.–5. Ordnung]

#tab(columns: (1fr, 1fr, 1fr),
 th([Ordnung], [Art], [Beispiel / Ursache]),
 [1], [#strong[Formabweichung]], [Unebenheit, Unrundheit; z. B. Durchbiegung des Werkstücks, Führungsfehler der Maschine],
 [2], [#strong[Welligkeit]], [Wellen; z. B. Schwingungen der Maschine, Unwucht des Fräsers],
 [3], [Rillen], [Vorschubriefen der Schneide],
 [4], [Riefen, Schuppen, Kuppen], [Spanbildung, Aufbauschneide],
 [5], [Gefügestruktur], [Kristallisation, chemische Vorgänge (nicht mehr einfach darstellbar)],
)

#note("Merke", [#strong[Rauheit = Gestaltabweichungen 3. bis 5. Ordnung.] Form (1.) und Welligkeit (2.) werden getrennt betrachtet; Formabweichungen toleriert man mit Form- und Lagetoleranzen (Kapitel 6), nicht mit Rauheitsangaben (S. 108–110).])

#text(fill: teal, weight: "bold")[Profile und Messstrecken]

Ein Tastschnittgerät fährt mit einer feinen Nadel über die Oberfläche und zeichnet ein Profil auf. Durch #strong[Filter] wird es zerlegt (S. 110):

- #strong[P-Profil] (Primärprofil): das ungefilterte, gemessene Profil, Gesamthöhe #strong[Pt].
- #strong[W-Profil] (Welligkeitsprofil): nur die langwelligen Anteile, Gesamthöhe #strong[Wt].
- #strong[R-Profil] (Rauheitsprofil): nur die kurzwelligen Anteile, Gesamthöhe #strong[Rt]. Alle folgenden Kenngrößen beziehen sich auf das R-Profil.

Die #strong[Einzelmessstrecke] $ l _(r) $ ist die Länge, auf der eine Kenngröße einmal ausgewertet wird. Die #strong[Messstrecke] $ l _(n) $ besteht im Regelfall aus #strong[5 Einzelmessstrecken] (S. 110, 115).

#src[B S. 108–110; L-alt C1, überarbeitet.]
#hoch(<a-5>, [Kapitelübersicht])


== 5.3 Rauheitskenngrößen Rz, Rt, Ra, RSm <a-5-3>

#bild("b-rauheit", [Bild 6-3: Profilspitze, Profiltal und Rautiefe. B, S. 111 (PDF-S. 122).], height: 52mm)

#note("Buchaussage zu Rz und Rt", [B S. 111 enthält zusätzlich den Satz, Rz und Rt seien ohne andere Angabe identisch. Diese pauschale Gleichsetzung wird hier nicht als Rechenregel verwendet: Rz bezieht sich in der beschriebenen älteren Auswertung auf eine Einzelmessstrecke, Rt auf die gesamte Messstrecke. Identische Werte entstehen nur bei passenden Profilen und Bezugsstrecken. Die Definition und die Auswertelänge müssen genannt bleiben.], fill: sand)

Die Definitionen stammen aus DIN EN ISO 4287, die durch DIN EN ISO 21920-2 ersetzt ist, in der Praxis aber noch verwendet wird (S. 110).

#bild("alt-c1-1", [Rauheitsprofil mit Rp, Rv und Rz (eigene Skizze, vgl. Bild 6-3, S. 111) Quelle der Skizze: L-alt C1; eigene Darstellung.], height: 52mm)

#tab(columns: (1fr, 1fr, 1fr),
 th([Kenngröße], [Name], [Definition]),
 [#strong[Rp]], [Höhe der größten Profilspitze], [über der Mittellinie, innerhalb einer Einzelmessstrecke],
 [#strong[Rv]], [Tiefe des größten Profiltals], [unter der Mittellinie, innerhalb einer Einzelmessstrecke],
 [#strong[Rz]], [größte Höhe des Profils (in den Übungen: „gemittelte Rautiefe“)], [Rz = Rp + Rv in #strong[einer Einzelmessstrecke]; entspricht dem früheren #strong[Ry] (DIN 4762, zurückgezogen); das „alte“ Rz ist nicht mehr genormt],
 [#strong[Rt]], [Gesamthöhe des Profils], [Rt = Rp + Rv über die #strong[ganze Messstrecke], kann daher größer als Rz sein; Rt und Rz sind nicht allgemein identisch; entscheidend sind Bezugsstrecke und Auswerteregel],
 [#strong[Ra]], [arithmetischer Mittenrauwert], [Mittelwert der Beträge der Profilordinaten in einer Einzelmessstrecke],
 [#strong[RSm]], [mittlere Rillenbreite], [Mittelwert der Breiten X#sub[s] der Profilelemente; braucht vertikale und horizontale Zählschwelle],
)

Arithmetischer Mittenrauwert und mittlere Rillenbreite (S. 111)

#form[
$ R _(a)  = frac(1, l)  integral _(0) ^(l)  | y (x )|  thin "d" x $
$ R _("Sm")  = frac(1, m)  sum _(i =1) ^(m)  X _(s ,i) $
$ R _(z)  = R _(p)  + R _(v) $
]

$ l $ Einzelmessstrecke \[mm\] · $ y (x ) $ Abstand des Profils von der Mittellinie \[µm\] · $ m $ Anzahl der Profilelemente · $ X _(s ,i) $ Breite des i-ten Profilelements · Ra, Rz, Rp, Rv in µm

#strong[Anschaulich:] Ra ist die Höhe eines Rechtecks über der Einzelmessstrecke, das die #strong[gleiche Fläche] hat wie alle Flächen zwischen Profil und Mittellinie zusammen (S. 111). Weil Ra mittelt, verschwinden einzelne Ausreißer darin. Rz reagiert dagegen auf einen einzigen tiefen Kratzer.

#note("Beispiel (eigene Ergänzung, gerechnet nach der Definition S. 111)", [Ein Rechteckprofil springt regelmäßig zwischen +2 µm und −2 µm.
Rp = 2 µm, Rv = 2 µm            -\>  Rz = 4 µm
|y(x)| ist überall 2 µm           -\>  Ra = 2 µm
Dreieck-(Sägezahn-)Profil ±2 µm:  Rz = 4 µm, |y| läuft linear 0…2  -\>  Ra = 1 µm
Gleiches Rz, aber halbes Ra: #strong[Ra und Rz lassen sich nicht ineinander umrechnen], das Verhältnis hängt von der Profilform ab.])

#text(fill: teal, weight: "bold")[Welche Kenngröße wofür?]

- #strong[Ra, Rz]: vor allem für #strong[aperiodische] (unregelmäßige) Profile, z. B. durch #strong[Schleifen] oder #strong[Erodieren] (S. 112).
- #strong[RSm]: für #strong[periodische] Profile, z. B. durch #strong[Drehen, Fräsen, Stoßen] (S. 112).

#note("Achtung", [Gleiche Kennwerte heißen nicht gleiche Oberfläche. Bild 6-6 zeigt zwei Profile mit Rz = 10 µm, Ra = 2,5 µm und RSm = 5 µm, aber Rp = 2 µm bzw. Rp = 8 µm. Das Profil mit den spitzen, hohen Spitzen verschleißt ganz anders. Wenn es darauf ankommt, gibt man mehrere Kenngrößen an; DIN EN ISO 21920 erlaubt dazu auch eine #strong[Materialanteilkurve] (S. 112).], fill: sand)

#src[B S. 110–112; L-alt C1, überarbeitet.]
#hoch(<a-5>, [Kapitelübersicht])


== 5.4 Das Oberflächensymbol <a-5-4>

#bild("b-oberflaechensymbole", [Bild 6-8: Oberflächensymbole nach DIN EN ISO 21920-1. B, S. 113 (PDF-S. 124).], height: 30mm)

Das Grundsymbol nach DIN EN ISO 1302 (zurückgezogen, ersetzt durch DIN EN ISO 21920-1) besteht aus #strong[zwei ungleich langen Linien, 60° zur Grundlinie geneigt]; Linienbreite wie die Beschriftung. Allein bedeutet es nur „an diese Fläche werden Anforderungen gestellt“ und tritt allein nur als Sammelangabe auf (S. 112–113).

#bild("alt-c1-2", [Symbole nach DIN EN ISO 1302 (eigene Skizze, vgl. Bild 6-7, S. 113); nach DIN EN ISO 21920-1 kommt ein zusätzlicher Balken hinzu (Bild 6-8) Quelle der Skizze: L-alt C1; eigene Darstellung.], height: 52mm)

#tab(columns: (1fr, 1fr),
 th([Symbol], [Bedeutung]),
 [Grundsymbol + waagerechte Linie am #strong[langen] Schenkel], [alle Fertigungsverfahren zulässig; die Linie wird angefügt, sobald rechts etwas eingetragen wird],
 [zusätzlich Linie am #strong[kurzen] Schenkel (geschlossenes Dreieck)], [#strong[Materialabtrag gefordert] (trennende, meist spanende Bearbeitung); Kurzform im Text: #strong[MRR]],
 [#strong[Kreis] zwischen den Schenkeln], [#strong[Materialabtrag unzulässig]: Oberfläche bleibt im Anlieferzustand (Ur-/Umformzustand, vorherige Beschichtung); mit Zusatzangaben ist die Beschaffenheit ohne Spanen zu erreichen, z. B. durch Beschichten],
 [Kreis an der Ecke zwischen langem Schenkel und waagerechter Linie], [„#strong[rundum]“: gilt für alle Flächen rund um die gezeichnete Kontur (nur DIN EN ISO 1302; in 21920-1 nicht mehr definiert)],
)

#note("Merke: 21920-1 gegenüber 1302 (S. 113)", [Nach DIN EN ISO 21920-1 ist das Symbol immer das #strong[vollständige] Symbol mit einem zusätzlichen Balken; ein reines Grundsymbol gibt es dort nicht mehr. Weil die Praxis noch mit 1302 arbeitet, erklärt das Buch beide.])

#src[B S. 112–114; L-alt C1, überarbeitet.]
#hoch(<a-5>, [Kapitelübersicht])


== 5.5 Angaben am Symbol: Positionen a bis e <a-5-5>

#bild("b-symbolpositionen", [Bild 6-10: Positionen am älteren Oberflächensymbol nach ISO 1302. B, S. 114 (PDF-S. 125).], height: 56mm)


#bild("alt-c1-3", [Positionen am Symbol (eigene Skizze, vgl. Bild 6-10, S. 114) Quelle der Skizze: L-alt C1; eigene Darstellung.], height: 52mm)

#tab(columns: (1fr, 1fr),
 th([Pos.], [Inhalt]),
 [#strong[a]], [Übertragungscharakteristik / Einzelmessstrecke, Kenngröße und #strong[Grenzwert in µm]],
 [#strong[b]], [zweite (und weitere) Anforderung; das Symbol wächst nach oben],
 [#strong[c]], [Fertigungsverfahren, Behandlung, Beschichtung (in Vergangenheitsform: „gedreht“, „geschliffen“)],
 [#strong[d]], [Rillenrichtung (Symbol)],
 [#strong[e]], [Bearbeitungszugabe in #strong[mm]],
)


Grenzwerte stehen nach DIN EN ISO 1302 #strong[nur auf Position a] und immer #strong[hinter] der Kenngröße (S. 114).

#text(fill: teal, weight: "bold")[Schreibregeln für Grenzwerte]

#tab(columns: (1fr, 1fr, 1fr),
 th([Angabe], [Bedeutung], [Seite]),
 [0,0025-0,8/Rz  6,3], [Kurzwellenfilter 0,0025 mm, Langwellenfilter bzw. Einzelmessstrecke 0,8 mm, durch „/“ von der Kenngröße getrennt; fehlt ein Filter, bleibt der Bindestrich stehen, und es gilt der Regelfall nach DIN EN ISO 4288/3274], [115],
 [Ra  3,2], [Messstrecke = Regelfall 5 Einzelmessstrecken], [115],
 [MRR Rz1  3,2], [Abtrag gefordert, Messstrecke aus #strong[1] Einzelmessstrecke; #strong[zwei Leerzeichen] vor dem Wert, damit „Rz1 3,2“ nicht als „Rz 13,2“ gelesen wird], [115],
 [Ra  6,3 (einzeln)], [einseitige Angabe = #strong[obere Grenze]], [115],
 [MRR L Ra  0,3], [einseitige #strong[untere] Grenze („nicht zu fein“)], [115],
 [U Rz  0,9 über L Ra  0,3], [obere und untere Grenze, übereinander, größerer Wert oben; U/L nötig, weil verschiedene Kenngrößen], [115],
 [Ra  6,3 über Ra  3,2], [gleiche Kenngröße oben und unten: U/L dürfen entfallen; Ra muss zwischen 3,2 und 6,3 µm liegen], [115],
 [Rz max  6,3], [„max-Regel“ (1302): #strong[kein] Messwert darf den Grenzwert überschreiten], [116],
)

#text(fill: teal, weight: "bold")[Annahmeregeln: 16 %, max, Tmax, Tmed]

#tab(columns: (1fr, 1fr, 1fr),
 th([Norm], [Standard (ohne Zusatz)], [andere Regeln]),
 [DIN EN ISO 1302 (alt)], [#strong[16 %-Regel]: annehmbar, wenn höchstens 16 % aller Messwerte den Grenzwert überschreiten (bzw. bei unterer Grenze unterschreiten)], [„max“ an der Kenngröße: kein Wert darf überschreiten],
 [DIN EN ISO 21920-1 (neu)], [#strong[Tmax]: keine Überschreitung erlaubt, gilt auch ohne Angabe], [„T16%“ muss angegeben werden; „Tmed“: der #strong[Median] aller Messwerte muss eingehalten werden],
)

#note("Achtung: Fehler vermeiden (S. 116)", [Der Standard hat sich umgedreht: Nach der alten Norm gilt ohne Angabe die tolerante 16 %-Regel, nach der neuen Norm die strenge Tmax-Regel.], fill: sand)

#text(fill: teal, weight: "bold")[Rillenrichtung (Position d, Tab. 6-2)]

#tab(columns: (1fr, 1fr, 1fr),
 th([Symbol], [Rillen verlaufen …], [typisch]),
 [#strong[=]], [parallel zur Projektionsebene der Ansicht, in der das Symbol steht], [Hobeln, Längsschleifen],
 [#strong[⊥]], [senkrecht zur Projektionsebene], [Stirnseite quer gehobelt],
 [#strong[X]], [gekreuzt in zwei schrägen Richtungen], [Honen],
 [#strong[M]], [in mehreren Richtungen], [Stirnfräsen mit Überlappung],
 [#strong[C]], [annähernd zentrisch (kreisförmig) zum Mittelpunkt], [plangedrehte Stirnfläche],
 [#strong[R]], [annähernd radial zum Mittelpunkt], [Planschleifen (Topfscheibe)],
 [#strong[P]], [nichtrillig, ungerichtet oder muldig], [Strahlen, Erodieren],
)

Die Spalte „typisch“ ist eine Ergänzung zur Orientierung, nicht aus dem Buchtext. Nach 21920-1 werden „=“, „⊥“ und „X“ durch Indikatoren definiert (Tab. 6-2).

#text(fill: teal, weight: "bold")[Fertigungsverfahren (Position c) und Richtwerte]

Angaben auf Position c stehen in der #strong[Vergangenheitsform], weil die Zeichnung den Endzustand zeigt (S. 117). Das Verfahren sollte möglichst mit angegeben werden, denn jedes Verfahren erzeugt ein typisches Profil.

#tab(columns: (1fr, 1fr, 1fr, 1fr),
 th([Bearbeitung (Beispiel Drehen)], [Ra], [Rz], [Riefen]),
 [geschruppt], [12,5 µm], [100 µm], [fühl- und sichtbar],
 [geschlichtet], [3,2 µm], [25 µm], [nur noch sichtbar],
 [fein(st)geschlichtet], [0,8 µm], [6,3 µm], [weder sicht- noch fühlbar],
)

#tab(columns: (1fr, 1fr, 1fr),
 th([Funktion der Fläche (S. 117)], [Rz], [Ra]),
 [funktionslose Fläche], [\> 100 µm], [\> 12,5 µm],
 [kraft- oder formschlüssig aufeinanderliegende Flächen], [≤ 100 µm], [≤ 12,5 µm],
 [Dichtfläche, statisch], [16 … 25 µm], [1,6 … 3,2 µm],
 [Dichtfläche, dynamisch], [4 … 6,3 µm], [0,4 … 0,8 µm],
 [Wälzlagersitz auf der Welle], [≤ 6,3 µm], [≤ 1,6 µm],
 [Wälzlagersitz im Gehäuse], [≤ 10 µm], [≤ 3,2 µm],
)

#note("Merkhilfe (eigene Ergänzung)", [Die Reihe #strong[12,5 – 3,2 – 0,8] (Ra) gehört zu #strong[100 – 25 – 6,3] (Rz): jeweils etwa Faktor 8. Je „dynamischer“ und „präziser“ die Fläche (Dichtung läuft, Lager sitzt), desto kleiner der Wert. Welle feiner als Gehäuse.])

In der Praxis werden Kennwert und Grenzwert meist #strong[aus Erfahrung] festgelegt; bei Normteilen helfen die Herstellerkataloge, bei Sonderteilen oder Prototypen muss man schätzen oder probieren (S. 117). Die #strong[Bearbeitungszugabe] (Position e) gibt man an, wenn mehrere Verfahrensstufen in derselben Zeichnung stehen, immer in #strong[mm] (S. 117).

#src[B S. 114–117; L-alt C1, überarbeitet.]
#hoch(<a-5>, [Kapitelübersicht])


== 5.6 Eintragung in die Zeichnung <a-5-6>

- Angaben nur, wenn sie für die #strong[Funktion] nötig sind, also in der Regel nur an #strong[Funktionsflächen] (S. 118).
- Symbol und Zusatzangaben müssen wie Maße #strong[von unten bzw. von rechts lesbar] sein. Wo das nicht geht, verbindet eine Hinweislinie mit Pfeil das Symbol mit der Fläche (S. 118).
- Symbol oder Pfeil zeigen #strong[von außen] auf die Körperkante oder auf eine Maßhilfslinie als ihre Verlängerung.
- Die Angabe steht in der Ansicht, in der die Fläche #strong[bemaßt] ist.
- Jede Fläche nur #strong[einmal] kennzeichnen; bei Drehteilen genügt eine Mantellinie (S. 119).
- Das Symbol darf auch an der Maßlinie oder am Toleranzrahmen einer Form- und Lagetoleranz stehen.

#text(fill: teal, weight: "bold")[Sammelangabe und Vereinfachung]

Gilt für die meisten Flächen dieselbe Beschaffenheit, steht ein Symbol #strong[nahe am Teil, an der Positionsnummer oder über dem Schriftfeld]. Dahinter folgen #strong[in Klammern] die Ausnahmen (oder nur das Grundsymbol in Klammern als Hinweis, dass es Ausnahmen gibt). Die abweichenden Flächen werden direkt gekennzeichnet (S. 119).

#note("Beispiel (eigene Ergänzung)", [Über dem Schriftfeld steht „Ra 6,3 ( Ra 1,6 , Rz 6,3 )“. Heißt: alle Flächen Ra 6,3 µm, außer den direkt gekennzeichneten Flächen mit Ra 1,6 bzw. Rz 6,3 µm. Bei Platzmangel nutzt man Buchstaben-Symbole (z. B. ein Symbol mit „x“), deren Bedeutung nahe am Schriftfeld erklärt wird (S. 119–120). Soll nur ein Teil einer Fläche gelten, wird der Bereich durch ein Maß begrenzt (S. 120).])

#src[B S. 118–120; L-alt C1, überarbeitet.]
#hoch(<a-5>, [Kapitelübersicht])


== 5.7 Wärmebehandlung (DIN 17014) <a-5-7>

- Die Zeichnung beschreibt nur den #strong[Endzustand] nach der Behandlung, also z. B. „#strong[gehärtet]“, „#strong[einsatzgehärtet]“, „#strong[nitriert]“, „#strong[vergütet]“, mit Härtewert. Der Weg dorthin ist Sache der Fertigung.
- Die Angabe steht nahe am #strong[Schriftfeld].
- Örtlich behandelte Bereiche werden mit einer #strong[breiten Strichpunktlinie] außerhalb der Kontur markiert und bemaßt.
- #strong[Messstellen] für die Härteprüfung werden gekennzeichnet, weil die Prüfung Eindrücke hinterlässt und diese nicht auf Funktionsflächen liegen sollen.
- Härtewerte erhalten eine möglichst große, aber funktionsgerechte #strong[Plustoleranz] (eigenes Beispiel: 58 + 4 HRC).
- Bei vielen Angaben gibt es ein eigenes „#strong[Wärmebehandlungsbild]“ nahe dem Schriftfeld.

#src[B S. 120–122; L-alt C1, überarbeitet.]
#hoch(<a-5>, [Kapitelübersicht])


== 5.8 Beschichtung (DIN 50960) <a-5-8>

Ein komplett beschichtetes Teil erhält ein Oberflächensymbol nahe der Positionsnummer oder dem Schriftfeld. Das Kurzzeichen steht in der Einzelteilzeichnung an der Darstellung, in der Gruppenzeichnung hinter der Positionsnummer (S. 122–123). Inhalt: Norm + Kurzzeichen aus #strong[chemischen Symbolen] und #strong[Schichtdicken in µm] in der Reihenfolge des Aufbringens, dazu ggf. Nachbehandlung, z. B. #strong[e] = eingefärbt, #strong[f] = gefettet/geölt, #strong[w] = gewachst.

#tab(columns: (1fr, 1fr),
 th([Linie außerhalb der Kontur], [Bedeutung]),
 [#strong[breite Strichpunktlinie]], [nur dieser Bereich wird beschichtet (partielle Beschichtung)],
 [#strong[schmale Strich-Zweipunktlinie]], [Beschichtung hier #strong[nicht zulässig]],
 [#strong[breite Strichlinie]], [Beschichtung nicht nötig, aber #strong[zulässig]],
)

Die Bedeutung der verwendeten Linien muss in der Zeichnung erklärt werden (S. 124).

#src[B S. 122–124; L-alt C1, überarbeitet.]
#hoch(<a-5>, [Kapitelübersicht])


== 5.9 Kantenzustand (DIN ISO 13715) <a-5-9>

#bild("b-kanten", [Bild 6-23: Außen- und Innenkanten mit undefinierter Form. B, S. 124 (PDF-S. 135).], height: 58mm)

Kanten mit #strong[undefinierter] Form (Grat, Abtragung, scharf) werden mit einem Symbol angegeben. Eine #strong[definierte] Fase oder ein Radius wird dagegen normal bemaßt (S. 124). Warum überhaupt? Grate können verletzen, Montage behindern oder abbrechen und Lager beschädigen; zu stark gebrochene Kanten verringern Anlageflächen.

#tab(columns: (1fr, 1fr, 1fr),
 th([Zeichen], [Außenkante], [Innenkante]),
 [#strong[+]], [Grat zulässig (Überstand)], [Übergang zulässig (Material steht in die Ecke)],
 [#strong[−]], [gratfrei, Abtragung (Fase/Rundung) zulässig], [Abtragung (Freistich) zulässig],
 [#strong[±]], table.cell(colspan: 2, rowspan: 1)[wahlweise Grat/Übergang #strong[oder] Abtragung; mit sehr kleinem Wert (z. B. ±0,05) bedeutet das #strong[scharfkantig] (Tab. 6-3, Nr. 6)],
)

- Empfohlene Werte a in mm: +2,5; +1; +0,5; +0,3; +0,1; „scharfkantig“ 0,05 und 0,02; −0,1; −0,3; −0,5; −1; −2,5.
- Eine Kante gilt als #strong[scharfkantig], wenn das Kantenmaß höchstens #strong[0,05 mm = 50 µm] beträgt.
- Zwei Werte (übereinander) geben einen #strong[Bereich] an, z. B. −0,1 und −0,5.
- Symbol (Bild 6-25): eine angedeutete Werkstückkante (Ecke immer #strong[links unten]) mit einer Pfeillinie unter #strong[45°], mindestens 1,5 × Schrifthöhe lang, deren Spitze auf die Bauteilkante zeigt. Zeichen und Wert stehen #strong[zwischen den Schenkeln], wenn die Grat-/Abtragsrichtung beliebig ist, und #strong[in Verlängerung eines Schenkels], wenn die Richtung vorgegeben ist (S. 125).
- Wird mit Symbolen gearbeitet, steht neben dem Schriftfeld der Hinweis „#strong[Kanten ISO 13715]“. Der überwiegende Kantenzustand steht nahe am Teil oder Schriftfeld, die Ausnahmen in Klammern dahinter (wie bei der Oberflächen-Sammelangabe).

#note("Beispiel", [Eine Außenkante soll gratfrei sein, mit einer Abtragung zwischen 0,1 und 0,5 mm, und die Richtung ist vorgegeben (Buch-Übung 6.26). Das Symbol trägt #strong[−0,1] und #strong[−0,5] übereinander, und zwar in Verlängerung des Schenkels, der die vorgeschriebene Richtung angibt.])

#src[B S. 124–127; L-alt C1, überarbeitet.]

#bild("map-kapitel-05", [Mindmap zu Kapitel 5. Eigene Darstellung nach B S. 107–130.], height: 46mm)

*Der Zusammenhang in Kapitel 5.* Die Funktion entscheidet, welche Oberflächeneigenschaft nötig ist. Messung, Kennwert, Symbol und Normfassung müssen dieselbe Forderung beschreiben; Kantenzustand und Behandlung ergänzen sie.
#src[B S. 107–130; eigene Zusammenfassung.]
#hoch(<a-5>, [Kapitelübersicht])


#pagebreak(weak: true)
= Kapitel 6 · Toleranzen und Passungen <a-6>

#überblick([Kapitel 6 auf einen Blick],
  idee(<a-6-2>, [Toleranz begrenzt zulässige Abweichung.], [Nennmaß und Abmaße ergeben die Grenzmaße.]),
  idee(<a-6-3>, [Das ISO-System beschreibt Lage und Breite des Feldes.], [Buchstabe und Toleranzgrad erfüllen unterschiedliche Aufgaben.]),
  idee(<a-6-6>, [Die Extremkombination entscheidet über die Passungsart.], [Größte und kleinste Bohrung werden mit den Wellengrenzmaßen verglichen.]),
  idee(<a-6-5>, [Ein Größenmaß sichert nicht jede geometrische Funktion.], [Form- und Lagetoleranzen legen zusätzliche Anforderungen fest.]),
  idee(<a-6-7>, [Die Passungsauswahl folgt der Funktion.], [Fertigungs- und Montagebedingungen gehören zur Entscheidung.]),
)

#ablauf(
  chunk([Funktion und Toleranzangaben lesen], [Nennmaß · Feldlage · Toleranzgrad], ziel: <a-6-3>),
  chunk([Grenzmaße bilden], [obere und untere Abmaße zuordnen], ziel: <a-6-2>),
  chunk([Extremfälle der Passung vergleichen], [Spiel · Übergang · Übermaß], ziel: <a-6-6>),
  chunk([Geometrische Funktion zusätzlich prüfen], [Form · Lage · Bezugssystem], ziel: <a-6-5>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])


Kein Maß lässt sich exakt fertigen. Die #strong[Toleranz] sagt, wie weit das Istmaß vom Nennmaß abweichen darf. Wenn zwei tolerierte Teile ineinander gesteckt werden (Welle in Bohrung), ergibt sich eine #strong[Passung]: Spiel, Übergang oder Übermaß. Dazu kommen #strong[Form- und Lagetoleranzen] (Rundheit, Parallelität, Rundlauf …). Dieses Kapitel verbindet Zeichnungsangaben mit Grenzmaß- und Passungsrechnungen. Auch wirtschaftlich zentral: Der Konstrukteur steht immer zwischen #strong[Funktion] (kleine Toleranzen helfen) und #strong[Kosten] (kleine Toleranzen sind teuer) (S. 131).

#src[B S. 131–168; überarbeitete Erklärung aus L-alt C2. Eigene Beispiele sind jeweils gekennzeichnet.]

== 6.1 Tolerierungsgrundsätze <a-6-1>

#note("Hülle ist keine allgemeine Lageforderung", [Die Hüllbedingung koppelt beim einzelnen Größenmaßelement Maß und Form. Sie legt nicht automatisch dessen Position oder Richtung relativ zu einer anderen Achse fest. Solche Funktionsforderungen brauchen eigene Bezüge und Toleranzen.], fill: sand)

Maß-, Form- und Lagetoleranzen beeinflussen sich gegenseitig. Wie, regelt der #strong[Tolerierungsgrundsatz].

#tab(columns: (1fr, 1fr, 1fr),
 th([Grundsatz], [Aussage], [Kennzeichnung]),
 [#strong[Unabhängigkeitsprinzip] (DIN EN ISO 8015)], [Jede Maß-, Form- und Lagetoleranz ist #strong[für sich] einzuhalten. Ein Zylinder Ø150 mit Durchmesser-, Geradheits- und Rundheitsforderung braucht #strong[drei] Angaben (S. 132).], [heute Normalfall; „Tolerierung ISO 8015“ neben dem Schriftfeld sinnvoll, aber nicht mehr zwingend],
 [#strong[Hüllbedingung] (früher DIN 7167)], [Die Oberfläche des einzelnen Größenmaßelements darf die ideale #strong[Hülle am Maximum-Material-Maß] nicht verletzen; eine Lageforderung zu anderen Elementen folgt daraus nicht. Ein Teil am Höchstmaß (Welle) muss am Maximum-Material-Maß die ideale Form der Hülle einhalten (S. 133).], [einzelnes Maß: #strong[Ⓔ] hinter der Toleranz; ganze Zeichnung: „Maße nach DIN EN ISO 14405 Ⓔ“ (S. 134)],
 [#strong[Maximum-Material-Bedingung]], [Nicht ausgeschöpfte Maßtoleranz darf zusätzlich von der Form-/Lagetoleranz genutzt werden. Gut bei Teilen, die gleichzeitig gepaart werden (Steckverbindungen, Lochbilder), geprüft mit Lehren (S. 134).], [#strong[Ⓜ] hinter der Form-/Lagetoleranz],
 [#strong[Minimum-Material-Bedingung]], [Begrenzung nach unten, z. B. für eine Mindestwanddicke (S. 135).], [#strong[Ⓛ] („least“)],
)

#note("Maximum-Material-Maß (S. 133)", [der Grenzwert, bei dem das Teil das #strong[meiste Material] hat. Bei #strong[Innenteilen (Wellen)] ist das das #strong[Höchstmaß], bei #strong[Außenteilen (Bohrungen)] das #strong[Mindestmaß]. Innenteil = wird umschlossen, Außenteil = umschließt.])

#note("Merke: Warum Unabhängigkeitsprinzip? (S. 134)", [Die Hüllbedingung verlangt bei gleicher Maßtoleranz eine viel höhere Genauigkeit, ist nur für einfache Elemente (Zylinder, parallele Ebenen) definiert und lässt offen, wie sich der Resttoleranzraum auf Geradheit und Rundheit verteilt. Das Unabhängigkeitsprinzip spart deshalb #strong[Kosten].])

#src[B S. 131–135; L-alt C2, überarbeitet.]
#hoch(<a-6>, [Kapitelübersicht])


== 6.2 Maßtoleranzen: Grundbegriffe <a-6-2>

#bild("b-toleranzbegriffe", [Bild 7-4: Nennmaß und Grenzmaße an einer Welle. B, S. 136 (PDF-S. 147).], height: 45mm)


#bild("alt-c2-1", [Begriffe am Beispiel einer Welle (eigene Skizze, vgl. Bild 7-4, S. 136) Quelle der Skizze: L-alt C2; eigene Darstellung.], height: 56mm)


- #strong[Nennmaß N]: das in der Zeichnung eingetragene Maß.
- #strong[Istmaß I]: das gemessene Maß nach der Fertigung.
- #strong[Höchstmaß Go], #strong[Mindestmaß Gu]: die Grenzmaße; Gu ≤ I ≤ Go, sonst Nacharbeit oder Ausschuss (S. 136).
- #strong[Abmaße]: oberes Abmaß ES (Bohrung) bzw. es (Welle), unteres Abmaß EI bzw. ei, von franz. „écart supérieur/inférieur“. #strong[Großbuchstaben = Bohrung (Innenmaß)], #strong[Kleinbuchstaben = Welle (Außenmaß)].
- #strong[Istabmaß A] = I − N, kann beide Vorzeichen haben.
- #strong[Maßtoleranz T] = Go − Gu, immer positiv.


Grundformeln Maßtoleranz (Tab. 7-1, S. 136)

#form[
$ "ES"  = G _(o)  - N $
$ "EI"  = G _(u)  - N $
$ A  = I  - N $
$ T  = G _(o)  - G _(u)  = "ES"  - "EI" $
]

für Wellen gleich mit es, ei · alle Größen in mm (Tabellenwerte der ISO-Abmaße in µm; 1 mm = 1000 µm)

#text(fill: teal, weight: "bold")[Eintragung in die Zeichnung (S. 137–138)]

- Abmaße bevorzugt in #strong[gleicher Schriftgröße] hinter das Nennmaß: übereinander (unteres Abmaß auf Höhe des Nennmaßes, oberes darüber) oder hintereinander mit „/“. Früher eine Schriftgröße kleiner.
- #strong[Oberes Abmaß immer über bzw. vor dem unteren], jeweils mit Vorzeichen. Symmetrisch: nur einmal mit „±“ (z. B. 40 ± 0,1).
- Auch ein Abmaß von #strong[0] sollte angegeben werden. Nennmaß + Abmaße zusammen heißt #strong[Passmaß].

#text(fill: teal, weight: "bold")[Gutmaß und Ausschussmaß (S. 138–139)]

Das #strong[Gutmaß] ist das Grenzmaß, das beim Materialabtragen #strong[zuerst] erreicht wird (= Maximum-Material-Maß). Trägt man über das andere Grenzmaß, das #strong[Ausschussmaß], hinaus ab, ist das Teil Ausschuss.

#tab(columns: (1fr, 1fr, 1fr, 1fr),
 th([], [Gutmaß], [Ausschussmaß], [Prüfmittel]),
 [Welle (Innenteil)], [Höchstmaß], [Mindestmaß], [#strong[Grenzrachenlehre]: Gutseite muss drüber, Ausschussseite darf nicht drüber],
 [Bohrung (Außenteil)], [Mindestmaß], [Höchstmaß], [#strong[Grenzlehrdorn]: Gutseite muss rein, Ausschussseite darf nicht rein],
)

#src[B S. 135–139; L-alt C2, überarbeitet.]
#hoch(<a-6>, [Kapitelübersicht])


== 6.3 ISO-Toleranzsystem <a-6-3>

#bild("b-abmasstabelle", [Tabelle 7-3: Grenzabmaße ausgewählter ISO-Toleranzklassen in µm. B, S. 142 (PDF-S. 153).], height: 132mm)

Grundidee: Größere Teile lassen sich mit gleichem Aufwand nur absolut ungenauer fertigen. Deshalb gelten für eine Toleranzklasse in verschiedenen #strong[Nennmaßbereichen] verschiedene Abmaße. Eine ISO-Toleranzklasse legt #strong[beide] Abmaße fest (S. 139). Sie ist keine Spezialität für Passungen, sondern eine gleichwertige, oft bessere Alternative zu Zahlenabmaßen, weil Werkzeuge (Reibahlen) und Lehren darauf abgestimmt sind.

#note("Merke: Aufbau einer ISO-Toleranzklasse, z. B. „H7“ oder „k6“ (S. 139)", [#strong[Buchstabe = Lage] des Toleranzfelds zur Null-Linie. #strong[Zahl = Toleranzgrad] („Qualität“) = Größe des Toleranzfelds.\

#strong[Großbuchstaben A–ZC: Bohrungen] (Außenteile), #strong[Kleinbuchstaben a–zc: Wellen] (Innenteile). Nicht verwendet: i, l, o, q, w (Verwechslungsgefahr mit Ziffern 1, 0 usw.).])

#tab(columns: (1fr, 1fr, 1fr),
 th([Buchstabe], [Welle (klein)], [Bohrung (groß)]),
 [a … g / A … G], [beide Abmaße #strong[negativ] (Welle kleiner als N)], [beide Abmaße #strong[positiv] (Bohrung größer als N)],
 [#strong[h / H]], [oberes Abmaß #strong[es = 0]], [unteres Abmaß #strong[EI = 0]],
 [j, js / J, JS], table.cell(colspan: 2, rowspan: 1)[Toleranzfeld liegt #strong[um die Null-Linie] (oben +, unten −); Übergangsbereich],
 [k … zc / K … ZC], [Lage zunehmend oberhalb des Nennmaßes; konkrete Abmaße aus Tabelle], [konkrete Lage und Abmaße aus Tabelle lesen],
)

#text(fill: teal, weight: "bold")[Toleranzgrade (Tab. 7-2, S. 141)]

20 Grade: #strong[IT01, IT0, IT1 … IT18] (IT = internationale Toleranz). Kleine Zahl = enge Toleranz. Grade 01–5 braucht man meist nur für Lehren, normale spanende Fertigung nutzt 5–13, spanlose Verfahren (Schmieden, Gießen, Walzen) erreichen etwa 14–18 (S. 141).

#tab(columns: (1fr, 1fr, 1fr),
 th([Grade], [Anwendung], [Verfahren]),
 [01 … 4 (klein)], [Prüflehren (Arbeitslehren bis in den mittleren Bereich)], [Läppen, Honen],
 [5 … 11 (mittel)], [bearbeitete Werkstücke, Maschinenbau], [Schleifen, Reiben, Fräsen, Drehen],
 [12 … 18 (groß)], [nicht für Passmaße; gezogene, gewalzte, gegossene, geschmiedete Teile], [Walzen, Schmieden, Pressen],
)

Der Buchstabe legt das #strong[näher an der Null-Linie liegende] Abmaß fest, der Grad dann (mit dem Nennmaßbereich) die Größe des Felds und damit das zweite Abmaß (S. 143).

#text(fill: teal, weight: "bold")[Tabelle 7-3: Grenzabmaße in µm (Auszug, S. 142)]


Oberer Wert = oberes Abmaß, unterer Wert = unteres Abmaß. Die Grenze gehört zum unteren Bereich: Ø50 liegt in „über 30 bis 50“. Größere Bereiche bis 500 mm stehen im Buch auf S. 142.

#note("Beispiel: Tabelle lesen (eigene Ergänzung, Werte aus Tab. 7-3, S. 142)", [Ø40 k6:  Bereich 30–50  -\>  es = +18 µm, ei = +2 µm
          Go = 40,018 mm   Gu = 40,002 mm   T = 16 µm
Ø40 H7:  ES = +25 µm, EI = 0   -\>  Go = 40,025 mm   Gu = 40,000 mm   T = 25 µm
Gleicher Grad 6 heißt im gleichen Bereich gleiche Toleranz: k6, j6, h6, r6 und s6 haben bei 30–50 mm alle T = 16 µm.])

#strong[Eintragung] (S. 144): Toleranzklasse hinter das Nennmaß („Ø40 k6“). Bei gepaarten Teilen steht die Bohrung (Großbuchstabe) #strong[über] oder #strong[vor] der Welle: „Ø40 H7/r6“. Die Grenzabmaße schreibt man zur Erleichterung der Fertigung entweder in Klammern dahinter oder, übersichtlicher, in eine #strong[Passmaßtabelle] nahe dem Schriftfeld.

#src[B S. 139–144; L-alt C2, überarbeitet.]
#hoch(<a-6>, [Kapitelübersicht])


== 6.4 Allgemeintoleranzen (DIN ISO 2768) <a-6-4>

Streng genommen ist ein Maß ohne Toleranz unvollständig. Damit nicht jedes Maß einzeln toleriert werden muss, gibt man #strong[Allgemeintoleranzen] für die ganze Zeichnung vor und toleriert nur die genaueren Maße einzeln (S. 144–145).

#tab(columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
 th([Klasse (2768-1)], [0,5–3], [3–6], [6–30], [30–120], [120–400], [400–1000], [1000–2000]),
 [#strong[f] fein], [±0,05], [±0,05], [±0,1], [±0,15], [±0,2], [±0,3], [±0,5],
 [#strong[m] mittel], [±0,1], [±0,1], [±0,2], [±0,3], [±0,5], [±0,8], [±1,2],
 [#strong[c] grob], [±0,2], [±0,3], [±0,5], [±0,8], [±1,2], [±2], [±3],
 [#strong[v] sehr grob], [–], [±0,5], [±1], [±1,5], [±2,5], [±4], [±6],
)

Tab. 7-4, S. 145, Grenzabmaße für Längenmaße in mm. Erster Bereich 0,5 bis 3 mm einschließlich; danach jeweils „über … bis …“.

Für #strong[Form und Lage] gibt DIN ISO 2768-2:1989 die Klassen #strong[H] (genau), #strong[K], #strong[L] (grob) vor, z. B. Geradheit/Ebenheit bis 10 mm: H 0,02 / K 0,05 / L 0,1 mm (Tab. 7-9, S. 153). Weil DIN EN ISO 22081 die Teil-2-Norm formal ersetzt hat, soll man sie #strong[mit Datum] zitieren (S. 152).

#note("Merke: Eintrag am Schriftfeld (S. 146, 153)", [„#strong[ISO 2768-mK]“ = Längen und Winkel Klasse #strong[m] (mittel), Form und Lage Klasse #strong[K]. Allgemeintoleranzen gelten #strong[nicht] für Hilfsmaße in Klammern und nicht für theoretisch genaue Maße im Rechteckrahmen.])

#src[B S. 144–146, 152–153; L-alt C2, überarbeitet.]
#hoch(<a-6>, [Kapitelübersicht])


== 6.5 Form- und Lagetoleranzen (DIN EN ISO 1101) <a-6-5>

#bild("b-toleranzrahmen", [Bild 7-16: Toleranzrahmen und Hinweislinie. B, S. 147 (PDF-S. 158).], height: 42mm)
#bild("toleranzsymbole", [Eigene Vektordarstellung nach B Tabellen 7-5 bis 7-8, S. 148–150 (DIN EN ISO 1101).], height: 78mm)

#note("Präzisierung zu Bezügen", [Die vereinfachte Gegenüberstellung im Buch ist als Einstieg hilfreich. In einer konkreten Zeichnung liest Du den vollständigen Rahmen: Profilforderungen können ohne oder mit Bezug definiert sein; eine Position kann sich auch auf einen theoretisch genau festgelegten Zusammenhang innerhalb eines Musters beziehen. Die genannten Tabellenbeispiele ersetzen dieses Lesen nicht.], fill: sand)
#note("Von dir markiert", [In AK, PDF-S. 9, ist „Form- und einer Lagetoleranz“ gelb markiert. Übe am Lagerdeckel getrennt: Was soll unabhängig von der Lage formrichtig sein? Welche Fläche oder Achse braucht ihre richtige Lage zu einem Bezug?])

Form- und Lagetoleranzen definieren eine #strong[Toleranzzone], in der alle Punkte des tolerierten Elements liegen müssen (S. 146).

- #strong[Formtoleranz]: zulässige Abweichung von der idealen Form; ohne Bezug. Die Lage innerhalb der Zone ist frei.
- #strong[Lagetoleranz]: zulässige Abweichung der Lage #strong[relativ zu einem Bezugselement]; unterteilt in Richtungs-, Orts- und Lauftoleranzen (S. 147).
- #strong[Bezugselement]: soll auch am realen Bauteil eine Bezugsfunktion haben (z. B. Lagersitz) und selbst formgenau genug sein.

#tab(columns: (1fr, 1fr, 1fr),
 th([Gruppe], [Eigenschaft], [Toleranzzone (Beispiel)]),
 table.cell(colspan: 3, rowspan: 1)[Formtoleranzen (ohne Bezug), Tab. 7-5],
 [], [Geradheit], [Achse in einem Zylinder Ø t; Kante zwischen zwei parallelen Ebenen],
 [], [Ebenheit], [zwischen zwei parallelen Ebenen im Abstand t],
 [], [Rundheit], [in jedem Querschnitt zwischen zwei konzentrischen Kreisen],
 [], [Zylinderform], [zwischen zwei koaxialen Zylindern],
 [], [Linienform (Profil)], [zwischen zwei Linien, die Kreise Ø t auf der Ideallinie einhüllen],
 [], [Flächenform (Profil)], [zwischen zwei Flächen, die Kugeln Ø t einhüllen],
 table.cell(colspan: 3, rowspan: 1)[Richtungstoleranzen (mit Bezug), Tab. 7-6],
 [], [Parallelität], [z. B. Bohrungsachse in Zylinder Ø t parallel zur Bezugsachse],
 [], [Rechtwinkligkeit], [zwischen zwei zur Bezugsachse senkrechten Ebenen],
 [], [Neigung (Winkligkeit)], [zwischen zwei parallelen, um den Sollwinkel geneigten Ebenen],
 table.cell(colspan: 3, rowspan: 1)[Ortstoleranzen (mit Bezug), Tab. 7-7],
 [], [Position], [Mittelpunkt in Kreis Ø t um die theoretisch genaue Lage],
 [], [Konzentrizität / Koaxialität], [Achse in Zylinder Ø t koaxial zur Bezugsachse],
 [], [Symmetrie], [zwischen zwei Ebenen symmetrisch zur Bezugsmittelebene],
 table.cell(colspan: 3, rowspan: 1)[Lauftoleranzen (mit Bezug), Tab. 7-8],
 [], [Lauf (Rund- oder Planlauf)], [Rundlauf: in jeder Messebene beim Drehen; Planlauf: in jedem Messzylinder],
 [], [Gesamtlauf], [zusätzlich mit Verschieben der Messuhr über die ganze Fläche],
)

#text(fill: teal, weight: "bold")[Toleranzrahmen und Bezug (S. 147–152)]

Der #strong[Toleranzrahmen] (schmale Linie) hat bei Formtoleranzen 2 Felder: #strong[Symbol | Toleranzwert] (in der Einheit der Zeichnung, also #strong[mm]; „Ø“ davor bei zylindrischer Zone). Bei Lagetoleranzen kommt ein #strong[3. Feld mit dem Bezugsbuchstaben] hinzu. Das Bezugselement trägt ein #strong[Bezugsdreieck] (gefüllt oder leer) mit eingerahmtem Buchstaben A, B … (S. 149).

0,005   Zylinderform 5 µm    
↗0,007A–B   Planlauf 7 µm zur gemeinsamen Achse A–B    
∥Ø0,1B

- Toleriert man eine #strong[Fläche oder Linie]: Pfeil direkt auf die Fläche oder eine Maßhilfslinie, aber #strong[nicht] in Verlängerung einer Maßlinie (S. 151).
- Toleriert man eine #strong[Achse oder Mittelebene]: Pfeil #strong[in Verlängerung der Maßlinie]. Gleiches gilt für Bezugsdreiecke.
- Mehrere Anforderungen an ein Element: Toleranzrahmen #strong[übereinander].
- Nur für einen Teilbereich: breite Strichpunktlinie und Bemaßung des Bereichs.
- Bei Positions-, Profil- und Neigungstoleranzen bemaßt man mit #strong[theoretisch genauen Maßen] im Rechteckrahmen; diese bekommen keine eigene Maßtoleranz (S. 151).
- Gemeinsamer Bezug aus zwei Lagersitzen: Buchstaben mit Strich getrennt, „A–B“ (S. 152).

#note("Achtung", [Der Toleranzwert im Rahmen steht in #strong[mm] (0,005), nicht in µm (5). Die Klausurfrage „In welcher Einheit?“ (Buch 7.30) zielt genau darauf.], fill: sand)

#src[B S. 146–153; L-alt C2, überarbeitet.]
#hoch(<a-6>, [Kapitelübersicht])


== 6.6 Passungen: Begriffe und Berechnung <a-6-6>

#bild("b-passungsbegriffe", [Tabelle 7-10: Grenzpassungen und Vorzeichen. B, S. 154 (PDF-S. 165).], height: 62mm)

#note("Definition (S. 153)", [#strong[Passung ist die Maßdifferenz von Innen- und Außenpassfläche vor der Paarung.] Innenpassfläche = Bohrungswand (gehört zum Außenteil), Außenpassfläche = Wellenoberfläche (gehört zum Innenteil). Positive Passung = #strong[Spiel], negative Passung = #strong[Übermaß].])

Passungsformeln (S. 155)

#form[
$ P _(O)  = G _("oI")  - G _("uA")  = "ES"  - "ei" $
$ P _(U)  = G _("uI")  - G _("oA")  = "EI"  - "es" $
]


#form[
$ P _(T)  = P _(O)  - P _(U)  = T _(I)  + T _(A) $
$ P _(i)  = I _(I)  - I _(A) $
]

Index I: Innenpassfläche (Bohrung) · Index A: Außenpassfläche (Welle) · $ P _(O) $ Höchstpassung · $ P _(U) $ Mindestpassung · $ P _(T) $ Passtoleranz (immer positiv) · $ P _(i) $ Istpassung · positiv = Spiel, negativ = Übermaß

#tab(columns: (1fr, 1fr, 1fr, 1fr),
 th([Passungsart], [P#sub[O] (Höchstpassung)], [P#sub[U] (Mindestpassung)], [Fügen / Sitz]),
 [#strong[Spielpassung]], [\> 0 = Höchstspiel P#sub[SO]], [≥ 0 = Mindestspiel P#sub[SU]], [praktisch kraftfrei; relativ loser Sitz],
 [#strong[Übergangspassung]], [\> 0 = Höchstspiel P#sub[SO]], [\< 0 = Höchstübermaß P#sub[ÜU]], [ohne oder mit geringer Kraft; enger Sitz, Spiel oder Übermaß je nach Istmaßen],
 [#strong[Übermaßpassung]], [≤ 0 = Mindestübermaß P#sub[ÜO]], [\< 0 = Höchstübermaß P#sub[ÜU]], [nur mit Kraft oder Schrumpfen; sicher spielfrei und fest],
)

#note("Merkhilfe (eigene Ergänzung)", [Für die Passungsart reichen die beiden Vorzeichen: #strong[+/+ Spiel], #strong[+/− Übergang], #strong[−/− Übermaß]. Höchstpassung: #strong[größte Bohrung minus kleinste Welle]. Mindestpassung: #strong[kleinste Bohrung minus größte Welle].])

#bild("alt-c2-2", [Toleranzfelder bei Ø50 im System Einheitsbohrung H7, maßstäblich (Werte in µm aus Tab. 7-3; eigene Skizze, vgl. Bild 7-8 und 7-21) Quelle der Skizze: L-alt C2; eigene Darstellung.], height: 56mm)

#note("Beispiel aus dem Buch: Ø50 H7/j6 (Bild 7-22, S. 157)", [Bohrung H7: ES = +0,025   EI = 0       Go = 50,025   Gu = 50,000   T = 0,025
Welle   j6: es = +0,011   ei = −0,005  Go = 50,011   Gu = 49,995   T = 0,016
Höchstspiel    PSO = 50,025 − 49,995 = +0,030 mm
Höchstübermaß  PÜU = 50,000 − 50,011 = −0,011 mm      -\> + / −  = Übergangspassung
Passtoleranz   PT  = 0,030 − (−0,011) = 0,041 mm  = 0,025 + 0,016  ✓])

#src[B S. 153–157; L-alt C2, überarbeitet.]
#hoch(<a-6>, [Kapitelübersicht])


== 6.7 Pass-Systeme und Passungsauswahl <a-6-7>

#tab(columns: (1fr, 1fr, 1fr),
 th([], [Einheitsbohrung (EB)], [Einheitswelle (EW)]),
 [fest], [alle Bohrungen #strong[H] (EI = 0), zugelassen H6–H13], [alle Wellen #strong[h] (es = 0), zugelassen h5, h6, h8–h13],
 [Passungsart über], [Wahl der #strong[Welle]], [Wahl der #strong[Bohrung]],
 [Vorzug Reihe 1], [H7, H8 (Reihe 2: H11)], [h6, h9 (Reihe 2: h11)],
 [Bewertung], [#strong[meist bevorzugt]: Eine einheitliche Bohrung (Reibahle, Lehrdorn) mit verschiedenen Wellen ist billiger als umgekehrt (S. 161)], [z. B. bei durchgehenden gezogenen Wellen mit mehreren Teilen darauf],
)

Die Bemerkung zum Einsatz der Einheitswelle ist eine Ergänzung, nicht aus dem Buchtext.

Nicht jede Kombination ist sinnvoll: Die Vielfalt wird aus #strong[Wirtschaftlichkeit] begrenzt (weniger Werkzeuge und Lehren). DIN EN ISO 286-1 ordnet die Kombinationen in Reihen I (bevorzugt), II, III (S. 157–160).

#tab(columns: (1fr, 1fr, 1fr),
 th([Passung], [Reihe I (Tab. 7-13)], [Eigenschaft und Anwendung (Tab. 7-14)]),
 [#strong[Übermaß]], [H7/r6, H7/s6, P7/h6], [H7/s6, H7/r6: unter hohem Druck bzw. durch Erwärmen/Kühlen fügbar, #strong[keine zusätzliche Verdrehsicherung] nötig; Kupplungen auf Wellenenden, Buchsen in Radnaben, Bronzekränze auf Schneckenradkörpern],
 [#strong[Übergang]], [H7/k6, H7/js6, N7/h6], [H7/n6: Festsitz, Sicherung gegen Verdrehen nötig; Zahnräder, Lagerbuchsen. H7/k6: Haftsitz mit geringer Kraft, Sicherung gegen Verdrehen bzw. Verschieben erforderlich (S. 162); Riemenscheiben, Kupplungen, #strong[Wälzlagerinnenringe] (mittlere Last). H7/js6: Schiebesitz, von Hand fügbar; häufig auszubauende Räder, Kolben auf Kolbenstange],
 [#strong[Spiel]], [H7/h6, H7/g6, H8/f7, H8/e8, G7/h6, F8/h9, E9/h9, D10/h9, B11/h9], [H7/h6: Gleitsitz, von Hand verschiebbar (Pinole, Fräser auf Dorn). H7/g6: enger Laufsitz (Spindellager an Schleifmaschinen). H8/f7: #strong[meist angewendete Lagerpassung] (Spindellagerung an Werkzeugmaschinen, Kurbel- oder Nockenwellenlagerung, Gleitführungen; S. 163). H11/h11: große Toleranzen, verstiftete oder verschraubte Teile (Kurbeln, Hebel)],
)

#note("Merkhilfe für die Klausur (eigene Ergänzung)", [#strong[H7/r6 → fest] (Pressverband), #strong[H7/k6 → Wälzlager] (Übergang), #strong[H7/h6 → schieben], #strong[H8/f7 → drehen] (drehende Lagerung). Je weiter der Wellenbuchstabe hinten im Alphabet, desto fester der Sitz.])

#src[B S. 157–163; L-alt C2, überarbeitet.]

#bild("map-kapitel-06", [Mindmap zu Kapitel 6. Eigene Darstellung nach B S. 131–168.], height: 46mm)

*Der Zusammenhang in Kapitel 6.* Aus Nennmaß und Abmaßen entstehen Grenzmaße. Deren Extremkombination ergibt die Passungsart; zusätzliche Form- und Lageforderungen sichern geometrische Funktionen, die ein Durchmesser allein nicht beschreibt.
#src[B S. 131–168; eigene Zusammenfassung.]
#hoch(<a-6>, [Kapitelübersicht])


#pagebreak(weak: true)
= Kapitel 7 · Gewinde und Schraubenverbindungen <a-7>

#überblick([Kapitel 7 auf einen Blick],
  idee(<a-7-1>, [Die Gewindedarstellung vereinfacht die reale Form.], [Breite und schmale Linien müssen der Gewindeart und Ansicht entsprechen.]),
  idee(<a-7-2>, [Nutzbare Länge und Auslauf sind verschieden.], [Die Verbindung braucht genügend wirksames Gewinde und passenden Freiraum.]),
  idee(<a-7-3>, [Die Gewindeart folgt der Aufgabe.], [Profil und Bezeichnung legen die Verbindung eindeutig fest.]),
  idee(<a-7-6>, [Die vollständige Bezeichnung macht Normteile bestellbar.], [Schraube, Mutter und Sicherung müssen zur vorgesehenen Montage passen.]),
)

#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Verbindungsaufgabe], [Gewindeart · Schraube · Mutter], ziel: <a-7-3>),
  pfeil(beschriftung: [bestimmt]),
  chunk([Zeichnung], [Linien · Nutzlänge · Auslauf], ziel: <a-7-1>),
  pfeil(beschriftung: [wird eindeutig durch]),
  chunk([Montage und Bestellung], [vollständige Normbezeichnung], ziel: <a-7-6>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])


Die Schraube ist das wichtigste Maschinenelement (S. 181). Buchkapitel 8 zeigt, wie man Gewinde #strong[vereinfacht zeichnet] (welche Linie breit, welche schmal), welche #strong[Gewindearten] es gibt, wie man Gewinde #strong[bezeichnet] und toleriert, welche Schrauben, Muttern und Sicherungen üblich sind und wie die #strong[Normbezeichnung] in der Stückliste aussieht. Normteile werden nicht bemaßt, sondern nur über ihre Bezeichnung bestellt: Für Einkauf und Lager ist diese Bezeichnung daher entscheidend (S. 192).

#src[B S. 169–196; überarbeitete Erklärung aus L-alt D1. Eigene Beispiele sind jeweils gekennzeichnet.]

== 7.1 Gewinde darstellen <a-7-1>

#bild("b-gewinde", [Bild 8-3: Außen- und Innengewinde in axialer Ansicht. B, S. 171 (PDF-S. 182).], height: 42mm)

Alle Gewindearten werden in der Zeichnung #strong[gleich] dargestellt; unterschieden wird nur über die Beschriftung (S. 169). Die schraubenförmige Kerbe wird nicht gezeichnet, nur #strong[Nenn- und Kerndurchmesser] als Linien (DIN ISO 6410-1). Bemaßt wird nur der Nenndurchmesser mit Gewindeart (z. B. „M16“), der Kerndurchmesser muss trotzdem #strong[maßstäblich] eingezeichnet sein.

#note("Merke: Welche Linie ist breit? (S. 169–170)", [Breit (Volllinie) ist immer die #strong[Kante, die den Körper begrenzt], also die, die du mit dem Messschieber greifen kannst.\

#strong[Bolzen (Außengewinde):] Nenn-Ø breit, Kern-Ø schmal.\

#strong[Mutter (Innengewinde):] Kern-Ø breit, Nenn-Ø schmal; die #strong[Schraffur geht bis zum Kerndurchmesser].])

#bild("alt-d1-1", [Gewindedarstellung nach DIN ISO 6410-1 (eigene Skizze, vgl. Bild 8-1 und 8-3, S. 170–171) Quelle der Skizze: L-alt D1; eigene Darstellung.], height: 56mm)

- #strong[Axiale Ansicht] (S. 171): Beim Bolzen ist der Nenn-Ø ein voller breiter Kreis, der Kern-Ø nur ein #strong[¾-Kreis] (etwa 270°) in schmaler Linie, als vereinbarte vereinfachte Gewindedarstellung. Der ¾-Kreis beginnt und endet kurz neben den Mittellinien. Bei der Mutter ist es umgekehrt: Kern-Ø voll, Nenn-Ø als ¾-Kreis.
- #strong[Verschraubte Teile] (S. 170–171): Das #strong[Bolzengewinde hat Vorrang], es liegt gedanklich „obenauf“. Seine Begrenzungskanten werden breit gezeichnet, die Schraffur der Mutter endet an der Körperkante des Bolzens.
- Bolzen- und Muttergewinde erhalten eine #strong[Fase], sonst wird das Einschrauben ein Geduldsspiel. Die Fase wird als Körperkante gezeichnet (S. 170).

#src[B S. 169–171; L-alt D1, überarbeitet.]
#hoch(<a-7>, [Kapitelübersicht])


== 7.2 Gewindelänge, Auslauf und Freistich <a-7-2>

- #strong[Nutzbare Gewindelänge]: von der Anlagefläche bis zum letzten vollen Gewindegang. Ihr Ende ist eine #strong[breite Volllinie] (darf nie fehlen) und wird in der Regel bemaßt, möglichst in derselben Ansicht wie der Nenndurchmesser.
- #strong[Gewindeauslauf x]: herstellungsbedingter Bereich danach, in dem die Gänge auslaufen. Faustregel: #strong[x ≈ 2,5 · P]; M16: x = 5 mm. Darf vereinfacht ohne die kurzen Auslauflinien gezeichnet werden.
- #strong[Grundlochüberhang e]: zusätzliche Bohrtiefe bei Innengewinden, damit der Gewindebohrer schneiden kann; M16: e = 9,3 mm.
- #strong[Gewindefreistich] (DIN 76): Einstich am Gewindeende, damit das Gegenstück bis ganz heran geschraubt werden kann. M16 außen (Form A): g1 ≥ 4,5 mm, g2 ≤ 7 mm, d#sub[g] = 13 h13; innen (Form C): g1 ≥ 8 mm, g2 ≤ 10,3 mm, d#sub[g] = 16,5 H13.

#src[B S. 172–173; L-alt D1, überarbeitet.]
#hoch(<a-7>, [Kapitelübersicht])


== 7.3 Gewindearten <a-7-3>

Gewinde unterscheiden sich nach #strong[Profilform], #strong[Steigung], #strong[Gangzahl] und #strong[Windungssinn] (S. 174). Ein Kennbuchstabe plus Nennmaß legt alle anderen Maße über die Norm fest: „M16“ heißt metrisches ISO-Gewinde nach DIN 13 mit d = 16 mm.

#text(fill: teal, weight: "bold")[Metrisches ISO-Gewinde (DIN 13-1)]

Flankenwinkel #strong[60°] („Spitzgewinde“); als #strong[Regelgewinde] von M1 bis M68 genormt (unter 1 mm: DIN 14-1), vorzugsweise als #strong[Befestigungsgewinde] (S. 175).

Maße des metrischen ISO-Gewindes (Bild 8-8, S. 174)

#form[
$ H  = 0","86603 thin P $
$ H _(1)  = 0","54127 thin P $
$ h _(3)  = 0","61343 thin P $
]


#form[
$ d _(2)  = D _(2)  = d  - 0","64953 thin P $
$ D _(1)  = d  - 2H _(1)  = d  - 1","08253 thin P $
$ d _(3)  = d  - 1","22687 thin P $
]

$ d  = D $ Nenndurchmesser \[mm\] · $ P $ Steigung \[mm\] · $ H $ Höhe des Profildreiecks · $ H _(1) $ Flankenüberdeckung · $ d _(2) $ Flankendurchmesser · $ D _(1) $ Kerndurchmesser der Mutter · $ d _(3) $ Kerndurchmesser des Bolzens · $ h _(3) $ Gewindetiefe am Bolzen

#note("Beispiel: M16 (P = 2 mm, S. 175)", [d2 = 16 − 0,64953 · 2 = 14,701 mm
D1 = 16 − 1,08253 · 2 = 13,835 mm
d3 = 16 − 1,22687 · 2 = 13,546 mm      (h3 = 0,61343 · 2 = 1,227 mm  -\>  16 − 2·1,227 = 13,546 ✓)
Den Kern-Ø von etwa 13,5 mm zeichnest du maßstäblich ein, bemaßt wird aber nur „M16“.])

#text(fill: teal, weight: "bold")[Sonderformen und weitere Gewinde]

#tab(columns: (1fr, 1fr, 1fr),
 th([Gewinde], [Bezeichnung], [Merkmal / Anwendung]),
 [Regelgewinde], [#strong[M16]], [keine Steigung angegeben = Regelsteigung (M16: P = 2)],
 [Feingewinde (DIN 13-2 … 11)], [#strong[M16 × 1,5]], [kleinere Steigung, #strong[Steigung wird immer angegeben]; d = 1 bis 1000 mm; für dünnwandige Teile, hohe Beanspruchung, Mess-, Einstell- und Dichtschrauben (S. 175–176)],
 [Linksgewinde], [#strong[M16 – LH]], [Regelfall ist Rechtsgewinde; „RH“ nur bei Verwechslungsgefahr (S. 176)],
 [Trapezgewinde (DIN 103)], [#strong[Tr16 × 4]], [30°-Trapezprofil, #strong[Bewegungsgewinde] in beide Richtungen (Leitspindeln, Pressen, Schraubstöcke); d = 8 bis 300 mm; mehrere Steigungen je Ø, daher #strong[Steigung immer angeben] (S. 176–178)],
 [mehrgängiges Trapezgewinde], [#strong[Tr16 × 4 P2]], [Steigung P#sub[h] = 4 mm, Teilung P = 2 mm, Gangzahl = P#sub[h]/P = 2; mehr Hub pro Umdrehung (S. 178)],
 [Sägengewinde (DIN 513)], [#strong[S]], [tragende Flanke 3°, Last nur in #strong[einer] Richtung (Pressen); trägt mehr als Trapezgewinde; d = 10 bis 640 mm (S. 178–179)],
 [Whitworth-Rohrgewinde (DIN EN ISO 228-1)], [#strong[G]], [Spitzgewinde, Angabe in Zoll, Nennweite ≈ Rohr-Innen-Ø, nicht dichtend (Tab. 8-1)],
 [Rundgewinde (DIN 405)], [#strong[Rd]], [stoßartige Last, starke Verschmutzung, auch in Blech (Glühlampenfassung) (Tab. 8-1)],
)

Mehrgängige Gewinde (S. 178)

#form[
$ n  = frac(P _(h), P) $
]

$ n $ Gangzahl · $ P _(h) $ Steigung = Axialweg pro Umdrehung \[mm\] · $ P $ Teilung = Abstand zweier Flanken \[mm\]

Trapezgewinde: Flankenüberdeckung #strong[H₁ = 0,5 · P], Kopfspiel a#sub[c] aus Tabelle (P = 4 mm: a#sub[c] = 0,25 mm). Steigung und Flanken sind etwa doppelt so groß wie beim metrischen Gewinde, weil Bewegungsgewinde aufeinander gleiten und Lasten heben (S. 177–178).

#text(fill: teal, weight: "bold")[Gewindetoleranzen (DIN ISO 965) (S. 180–181)]

- Toleranzgrad 3 bis 9; Lage #strong[e, f, g, h] (Bolzen) bzw. #strong[G, H] (Mutter).
- Bei Gewinden steht die #strong[Zahl vor dem Buchstaben] (6g, 6H), damit man sie nicht mit einer normalen Passung verwechselt.
- Bolzen: Flanken-Ø und Nenn-Ø toleriert („M20 – 5g6g“); Mutter: Flanken-Ø und Kern-Ø („M20 – 4H5H“). Sind beide gleich, nur einmal („M20 – 4h“).
- Ohne Angabe gilt Klasse #strong[„mittel“: 6g (Bolzen) und 6H (Mutter)] (S. 181).

#src[B S. 174–179; L-alt D1, überarbeitet.]
#hoch(<a-7>, [Kapitelübersicht])


== 7.4 Schrauben und Muttern <a-7-4>

#note("Zeichenrichtwerte und Bemessung", [Die im Buch genannten Einschraublängen sind Richtwerte für die dargestellten Werkstoffe und Zeichenaufgaben. Sie sind kein universeller Festigkeitsnachweis einer Schraubverbindung. Die zulässige Belastung müsste mit Schrauben-, Innengewinde- und Betriebsdaten geprüft werden.], fill: sand)

Schrauben unterscheidet man nach #strong[Kopfform], #strong[Schaftform] und #strong[Gewindeende]; benannt werden sie meist nach dem Kopf, weil er das Montagewerkzeug bestimmt (S. 182).

#tab(columns: (1fr, 1fr),
 th([Merkmal], [Beispiele]),
 [#strong[Kopf] (Bild 8-18)], [Sechskantschraube ISO 4014 (Schlüssel, Platz zum Ansetzen nötig); Zylinderschraube mit Innensechskant ISO 4762 (versenkbar); Senkschraube mit Kreuzschlitz ISO 7046; Linsen-Senkschraube ISO 7047; Flügelschraube DIN 316 (von Hand); Ringschraube DIN 580 (Kranhaken)],
 [#strong[Innenangriff] (Bild 8-19)], [Schlitz, Kreuzschlitz, Innensechskant, Innensechsrund],
 [#strong[Schaft] (Bild 8-21)], [Starrschraube (Dick-, Dünnschaft), #strong[Passschraube] (Passdurchmesser: halten + positionieren), #strong[Dehnschraube] (Schaft auf ca. 90 % des Gewinde-Ø verjüngt, federt beim Anziehen)],
 [#strong[Ende] (DIN EN ISO 4753)], [CH Kegelkuppe, RN Linsenkuppe (üblich); SD/LD Zapfen (Druckschrauben); CN/TC Spitze (Sicherung in Senkung); CP Ringschneide (Stellringe); SC Schabenut. Alle zählen zur Länge, nur PC (Einführzapfen) nicht.],
 [#strong[ohne Kopf]], [#strong[Stiftschraube] (Gewinde an beiden Enden), #strong[Gewindestift]/„Madenschraube“ (durchgehendes Gewinde, sichert die Lage von Teilen)],
)

#text(fill: teal, weight: "bold")[Darstellungsregeln Schraubenkopf (S. 183–184)]

- Das #strong[Werkzeug] muss erkennbar sein. Innensechskant in der Seitenansicht als #strong[verdeckte Kante] (schmale Strichlinie), obwohl sonst auf verdeckte Kanten verzichtet wird.
- Schlitz in der Seitenansicht immer im #strong[Querschnitt], in der Draufsicht unter #strong[45°] (ohne Rücksicht auf die Projektion); Sechskantschraube mit Schlitz: 60° bzw. 30°.
- Muttern meist in #strong[Ansicht], Schnitt nur bei unklarem Innenaufbau. Sechskantmutter ISO 4032 ist innen und außen an beiden Seiten gefast; die Fasen werden gezeichnet (S. 186).

#note("Merke: Mindest-Einschraublänge der Stiftschraube (Bild 8-22, S. 184)", [


#tab(columns: (1fr, 1fr, 1fr, 1fr, 1fr),
 th([Werkstoff des Innengewindes], [Stahl], [Grauguss], [Aluminium], [Weichmetall]),
 [Einschraublänge L], [1 · d], [1,25 · d], [2 · d], [2,5 · d],
)
ohne])

#src[B S. 181–186; L-alt D1, überarbeitet.]
#hoch(<a-7>, [Kapitelübersicht])


== 7.5 Scheiben und Schraubensicherungen <a-7-5>

#tab(columns: (1fr, 1fr, 1fr),
 th([Element], [Zweck / Bewertung], [Darstellung]),
 [#strong[Unterlegscheibe] ISO 7089], [senkt Reibung bei rauer Fläche (mehr Vorspannung), verteilt Kraft bei weichem Werkstoff, Keilscheiben (DIN 434/435) gleichen Schrägen aus. #strong[Keine Sicherung] gegen Losdrehen!], [normal],
 [#strong[Federring] (Bild 8-28)], [Schlitz sperrt das Aufdrehen; gilt in Versuchen aber als #strong[unwirksame] Sicherung], [zusammengepresst, #strong[nie geschnitten], Schlitzseite nach vorn, Neigung beachten],
 [#strong[Federscheibe, Zahnscheibe]], [Federwirkung; Zahnscheiben sind zu weich, um wirklich zu sichern], [gezahnte mit Zähnchen],
 [#strong[Scheibe mit Lappen/Nase], Sicherungsblech], [Lappen wird nach dem Anziehen umgebogen (formschlüssig)], [zeigen, welcher Lappen wohin gebogen wird],
 [#strong[Selbstsichernde Mutter] ISO 7040], [Kunststoffring dämpft, verhindert vibrationsbedingtes Losdrehen], [nur im (Halb-)Schnitt erkennbar],
 [#strong[Splint] ISO 1234 + #strong[Kronenmutter] DIN 935/979], [Splint durch Querbohrung; mit Kronenmutter auch gegen Verdrehen], [Lage von Kopf und Enden zeigen],
 [#strong[Stoffschlüssig]: Schweißmutter DIN 928, Kleben, mikroverkapselte Schrauben], [sehr wirksam, aber nur zerstörend lösbar], [Schweißstelle bzw. Hinweis „durch Klebung gesichert“; in der Stückliste kennzeichnen],
)

Das Buch nennt beim Federring DIN 267 (Bild 8-28). Bekannter ist der Federring unter DIN 127 (zurückgezogen). Falls in der Vorlesung eine bestimmte Norm genannt wird, nimm diese.

#src[B S. 187–192; L-alt D1, überarbeitet.]
#hoch(<a-7>, [Kapitelübersicht])


== 7.6 Normbezeichnung (DIN 962) <a-7-6>

Normteile werden #strong[nicht bemaßt], sondern in der Stückliste mit vollständiger Normbezeichnung geführt. DIN 962 legt Inhalt und Reihenfolge fest:

Aufbau der Bezeichnung (S. 192)
A B – C D × E × F × G – H – K – L – M – N – P
A Benennung · B Norm-Nummer · C Schaftform · D Gewinde (M20, M20 × 1,5, M20 – LH) · E Zusatz-Ø (Passschraube) · F Nennlänge (gestuft, entfällt bei Muttern) · G Gewinde-/Schaftlänge · H Formbuchstaben (alphabetisch) · K Schlüsselweite · L Festigkeitsklasse · M Produktklasse · N Kreuzschlitzform · P Oberflächenbehandlung

#note("Beispiele (S. 193)", [Sechskantschraube ISO 4014 – M12 x 50 – 8.8
Sechskantschraube ISO 4014 – B M12 x 50 – K Sk To – 8.8 – B
    (1. B: Schaft ≈ Flanken-Ø; K Kegelkuppe; Sk Sicherungsloch im Kopf;
     To ohne Telleransatz; 2. B: Produktklasse)
Stiftschraube DIN 938 – M12 – M12 x 1,25 x 80 – 8.8
Stiftschraube DIN 938 – M20 x 80 – 8.8
Sechskantmutter ISO 4032 – M12 – 8])

Festigkeitsklasse von Schrauben, z. B. 8.8 (DIN EN ISO 898-1, S. 193)

#form[
$ R _(m)  = 8  dot  100 thin frac("N", "mm" ^(2))  = 800 thin frac("N", "mm" ^(2)) $
$ R _("p0,2")  = 0","8  dot  R _(m)  = 640 thin frac("N", "mm" ^(2)) $
]

erste Zahl × 100 = Nennzugfestigkeit $ R _(m) $ · zweite Zahl / 10 = Streckgrenzenverhältnis · Mutter „8“: B S. 193 nennt als Beispiel eine Prüfspannung 800 N/mm²; die tatsächliche Zuordnung erfordert die passende Normtabelle (DIN EN ISO 898-2). Die Werte für 8.8 stehen im Buch, die Rechenregel ist daraus abgeleitet.

#src[B S. 192–193; L-alt D1, überarbeitet.]
#hoch(<a-7>, [Kapitelübersicht])


== 7.7 Vereinfachte Darstellung (DIN ISO 6410-3) <a-7-7>

- Fasenkreise, Fasenkanten und Kuppen dürfen entfallen (Tab. 8-3). Lohnt sich vor allem beim Zeichnen von Hand; im CAD kommen Normteile ohnehin aus der Bibliothek.
- Nicht erlaubt, wenn dadurch etwas missverständlich oder unvollständig wird.
- Gewinde mit Nenn-Ø #strong[≤ 6 mm] oder in regelmäßigen Mustern dürfen ganz entfallen: nur Hinweislinie mit Pfeil auf die Mittellinie und Bezeichnung, z. B. „M5“ oder „8 × M12“ (S. 194).

#src[B S. 193–194; L-alt D1, überarbeitet.]

#bild("map-kapitel-07", [Mindmap zu Kapitel 7. Eigene Darstellung nach B S. 169–196.], height: 46mm)

*Der Zusammenhang in Kapitel 7.* Die vereinfachten Linien stehen für eine genormte Geometrie. Nutzbare Länge, Toleranz und vollständige Bezeichnung sorgen dafür, dass gezeichnete Schraubverbindung, Montage und Bestellung zusammenpassen.
#src[B S. 169–196; eigene Zusammenfassung.]
#hoch(<a-7>, [Kapitelübersicht])


#pagebreak(weak: true)
= Kapitel 8 · Elemente an Achsen und Wellen <a-8>

#überblick([Kapitel 8 auf einen Blick],
  idee(<a-8-1>, [Das Wellenende bildet die Anschlussstelle.], [Seine Form muss zur anzuschließenden Nabe passen.]),
  idee(<a-8-2>, [Freistiche und Zentrierungen unterstützen die Herstellung.], [Werkzeugauslauf, Anlage und Einspannung brauchen passende Geometrie.]),
  idee(<a-8-4>, [Die Welle-Nabe-Verbindung überträgt Drehmoment.], [Passfeder und Profilwelle erfordern jeweils eigene Darstellung und Bezeichnung.]),
)

#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Fertigung und Anschluss], [Wellenende · Freistich · Zentrierung], ziel: <a-8-2>),
  pfeil(beschriftung: [ermöglicht Zusammenbau von]),
  chunk([Welle und Nabe], [Passfeder oder Profilverbindung], ziel: <a-8-4>),
  pfeil(beschriftung: [wird beschrieben durch]),
  chunk([Drehmomentübertragung], [Nut · Querschnitt · Bezeichnung], ziel: <a-8-5>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])


Eine Welle ist nicht einfach ein Zylinder. Sie hat #strong[genormte Enden] für Kupplungen, #strong[Freistiche] an den Absätzen, #strong[Zentrierbohrungen] zum Einspannen und #strong[Welle-Nabe-Verbindungen] (Passfeder, Vielnut, Passverzahnung, Polygon), die das Drehmoment auf Zahnräder und Scheiben übertragen. Für alle diese Elemente gibt es Normbezeichnungen und meist eine vereinfachte Darstellung. Das Kapitel behandelt nur die Darstellung, nicht die Berechnung (S. 197).

#src[B S. 197–220; überarbeitete Erklärung aus L-alt D2. Eigene Beispiele sind jeweils gekennzeichnet.]

== 8.1 Wellenenden <a-8-1>

Wellenenden treten aus Getriebe oder Maschine aus und nehmen z. B. eine Kupplung auf. Würde man jeden Durchmesser frei berechnen, wären alle Kupplungen Sonderanfertigungen. Deshalb sind Durchmesser #strong[gestuft] und Längen zugeordnet (S. 199). Wegen der Normung dürfen sie abgebrochen dargestellt werden.

#tab(columns: (1fr, 1fr, 1fr),
 th([Norm], [Form], [Anwendung]),
 [DIN 748], [zylindrisch (mit oder ohne Bund)], [Kupplung aufziehen],
 [DIN 1448], [kegelig mit Außengewinde], [z. B. Keilriemenscheiben],
 [DIN 1449], [kegelig mit Innengewinde], [z. B. Keilriemenscheiben],
)

#note("Merke (S. 199)", [„Wellenende DIN 748 – 45 × 110“ = zylindrisch, d₁ = 45 mm, l₁ = 110 mm. Toleranz bis d₁ = 50 mm: #strong[k6], von 55 bis 630 mm: #strong[m6].])

#src[B S. 197–199; L-alt D2, überarbeitet.]
#hoch(<a-8>, [Kapitelübersicht])


== 8.2 Freistiche (DIN 509) <a-8-2>

#bild("b-freistich", [Bild 9-5: Freistiche Form E und F nach DIN 509. B, S. 200 (PDF-S. 211).], height: 52mm)

An Wellenabsätzen liegen Lager und Zahnräder an der #strong[Schulter] an (axiale Fixierung). Daraus folgen drei Forderungen, die sich widersprechen (S. 199–200):

+ #strong[Anlage:] Der Radius im Absatz muss #strong[kleiner] sein als die Kantenrundung des aufgeschobenen Teils (r₁ \< r₂), sonst liegt es nicht an.
+ #strong[Fertigung:] Für Schleifen, Planlauf und Zylinderform braucht man einen #strong[Werkzeugauslauf] (z. B. für die Schleifscheibe).
+ #strong[Festigkeit:] Ein #strong[großer] Übergangsradius verringert die Kerbwirkung.

Die Lösung ist der genormte #strong[Freistich]: eine kleine Einstechung mit definiertem Radius. Die alten Formen A–D sollen nicht mehr verwendet werden.

#tab(columns: (1fr, 1fr),
 th([Form], [Anwendung (S. 200)]),
 [#strong[E]], [keine besonderen Anforderungen an die Planfläche (nur die Zylinderfläche wird weiterbearbeitet)],
 [#strong[F]], [beide rechtwinklig zueinander stehenden Flächen werden weiterbearbeitet (Zylinder und Planschulter)],
 [G], [gering belastete Teile, möglichst kleiner Übergang],
 [H], [stärker ausgerundete Übergänge],
)

- Darstellung als #strong[Einzelheit] mit Bemaßung (Bild 9-6) oder #strong[vereinfacht]: breite Volllinie im Abstand f vom Absatz und Hinweislinie mit Bezeichnung (Bild 9-7).
- Bezeichnung „#strong[DIN 509 – F0,8 × 0,3]“: Form F, Radius r = 0,8 mm, Tiefe t₁ = 0,3 mm (S. 201).
- Normale Beanspruchung, 18 \< d₁ ≤ 80 mm: r = 0,8, t₁ = 0,3; erhöhte Wechselfestigkeit: r = 1,2 × 0,2 (bis 50 mm) bzw. 1,6 × 0,3 (50 bis 80 mm) (Tab. 9-1).
- Im Freistichgrund gilt ohne Angabe eine #strong[geschlichtete] Oberfläche: Rz1max 25 bzw. Ra 3,2 (S. 201).

#src[B S. 199–202; L-alt D2, überarbeitet.]
#hoch(<a-8>, [Kapitelübersicht])


== 8.3 Zentrierbohrungen <a-8-3>

#bild("b-zentrierung", [Bild 9-8: Zentrierbohrungen der Formen A, B und R. B, S. 203 (PDF-S. 214).], height: 50mm)

Lange Wellen werden beim Drehen auf der einen Seite im #strong[Futter], auf der anderen im #strong[Reitstock] mit einer Körnerspitze geführt; dafür braucht die Stirnseite eine #strong[Zentrierbohrung]. Wird umgespannt, braucht man sie an beiden Seiten (S. 202). Bevorzugt sind die Formen A, B und R nach DIN 332-1, weil sie mit genormten Zentrierbohrern in einem Arbeitsgang entstehen.

#tab(columns: (1fr, 1fr),
 th([Form], [Merkmal / Vorteil (S. 203)]),
 [#strong[A] (ISO 866)], [einfachste und günstigste Form, 60°-Kegel],
 [#strong[B] (ISO 2540)], [zusätzliche 120°-#strong[Schutzsenkung] schützt die innen liegenden Flächen vor Beschädigung],
 [#strong[R] (ISO 2541)], [#strong[gewölbte] Fläche gleicht Maß- und Lagefehler aus, vermeidet Kantentragen],
)

- Darstellung als #strong[Ausbruch] oder #strong[Einzelheit] mit Maßen, besser aber #strong[vereinfacht] nach DIN ISO 6411, da die Bohrer genormt sind (S. 204).
- Bezeichnung „#strong[ISO 6411 – B 4/12,5]“: Form B, Führungs-Ø d = 4 mm, Senkdurchmesser D₂ = 12,5 mm.
- Das Symbol sagt, ob die Bohrung #strong[am Fertigteil erforderlich] ist, #strong[verbleiben darf] oder #strong[nicht verbleiben darf] (dann wird die Welle zunächst länger gefertigt und anschließend gekürzt) (Bild 9-11, S. 205).

#src[B S. 202–205; L-alt D2, überarbeitet.]
#hoch(<a-8>, [Kapitelübersicht])


== 8.4 Passfedern (DIN 6885) <a-8-4>

#bild("b-passfedern", [Bild 9-13: Ausführungsformen der Passfedern nach DIN 6885. B, S. 206 (PDF-S. 217).], height: 53mm)


#bild("alt-d2-1", [Passfederverbindung, Welle und Nabe geschnitten (eigene Skizze, vgl. Bild 9-15, S. 207) Quelle der Skizze: L-alt D2; eigene Darstellung.], height: 56mm)


Die Passfeder ist eine #strong[formschlüssige Welle-Nabe-Verbindung]: Sie liegt in einer Nut der Welle, ragt heraus und greift in die Nut der Nabe. Gut für #strong[einseitige], kleine bis mittlere Drehmomente; preiswert, einfach zu montieren und lösbar (S. 206).

Sie trägt nur mit den #strong[Seitenflächen]; oben hat sie #strong[Rückenspiel] (S. 208).


#tab(columns: (1fr, 1fr, 1fr),
 th([Form], [Merkmal], [Nut]),
 [#strong[A]], [rundstirnig, ohne Bohrungen; #strong[am häufigsten]], [N1, mit Schaftfräser],
 [#strong[B]], [geradstirnig], [N2, mit Scheibenfräser],
 [#strong[E]], [rundstirnig mit Halte- (und Abdrück-)schrauben; für #strong[axial verschiebbare] Naben („Gleitfeder“), z. B. Schieberäder in Getrieben], [N1],
)

#text(fill: teal, weight: "bold")[Auswahl und Bemaßung]

+ Querschnitt #strong[b × h] aus dem Wellendurchmesser (Tab. 9-3), z. B. d über 44 bis 50 mm: #strong[14 × 9], t₁ = 5,5#super[+0,2], t₂ = 3,8#super[+0,2]; über 50 bis 58 mm: #strong[16 × 10], t₁ = 6,0#super[+0,2], t₂ = 4,3#super[+0,2].
+ Länge aus der Drehmomentberechnung, dann auf eine #strong[Normlänge] aufrunden: 6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 28, 32, 36, 40, 45, 50, 56, 63, 70, 80, 90 … (S. 207).
+ Nutbreite tolerieren: #strong[fester Sitz P9] (Welle und Nabe); leichter Sitz N9 / JS9; Gleitsitz H8 / D10 (S. 208).
+ Durchmesserpassung (Tab. 9-4): auf Wellenenden fest H7/k6 oder m6; auf längeren Wellen fest H7/j6; verschiebbar H7/h6 oder j6.

#note("Achtung: häufiger Fehler (S. 209)", [Eine Welle mit Passfedernut braucht #strong[zwei Ansichten]. Die #strong[Nuttiefe t₁] wird von der Wellenoberfläche, die abgefräst wird, bis zum Nutgrund bemaßt. Beispiel Bild 9-16: Ø50 k6, Nutbreite 14 P9, Tiefe 5,5#super[+0,2], Nutlänge 63#super[+0,3].], fill: sand)

#note("Merke: Bezeichnung (S. 209)", [„#strong[Passfeder DIN 6885 – A 12 × 8 × 40]“ = Form A, b = 12, h = 8, l = 40 mm. Bei Form A ist l die #strong[Gesamtlänge inklusive der Rundungen], obwohl nur die geraden Seitenflächen tragen. Eine vereinfachte Darstellung von Passfedern gibt es nicht.])

#src[B S. 205–209; L-alt D2, überarbeitet.]
#hoch(<a-8>, [Kapitelübersicht])


== 8.5 Profilwellen: Vielnut, Passverzahnung, Polygon <a-8-5>

#tab(columns: (1fr, 1fr, 1fr, 1fr),
 th([], [Vielnutprofil (DIN ISO 14)], [Passverzahnung (DIN 5480/5481)], [Polygonprofil (DIN 32711/32712)]),
 [Idee], [vervielfachte Passfeder, parallele Flanken; 6, 8 oder 10 Nuten], [kleine Zähne: Kerbflanken (5481) oder Evolventenflanken (5480)], [Unrundprofil: P3G (Gleichdick aus Dreieck), P4C (Quadrat mit angeschnittenen Ecken)],
 [Vorteile], [viel größere Drehmomente als Passfeder; fest oder längsverschiebbar (Kfz-Kupplungsscheibe)], [dünne Nabenwände; geringere Kerbwirkung als Vielnut], [selbstzentrierend, geringste Kerbwirkung, #strong[höchstes Drehmoment] bei gleichem Ø, stoßfest; Fertigung einfacher und billiger als Vielnut/Zahn (Spezialmaschine nötig)],
 [Nachteile], [teure Fertigung, Kerbwirkung], [Kerbflanken nur für feste Sitze (Übergangssitz)], [–],
 [Zentrierung], [innen (bevorzugt), Flanken (hohe Wechsellast), außen (kaum noch)], [Evolvente: Flankenzentrierung ermöglicht Presssitz], [selbstzentrierend],
 [Bezeichnung], [DIN ISO 14 – W 8 × 32 × 36 (Welle, 8 Keile, d = 32, D = 36)], [DIN 5481 – N 40 × 44; DIN 5480 – WA 120 × 3 × 38 × 8f], [Profil DIN 32711 – A P3G 40 – k6],
 [vereinfacht], [ja, DIN EN ISO 6413 mit Symbol; Länge und Werkzeugauslauf bemaßen], [ja, DIN EN ISO 6413; Kopf-, Fußkreis, Breite, Oberfläche zusätzlich], [nicht üblich, nicht genormt],
)

Kennbuchstaben: N = Nabe, W = Welle; bei Polygon A = Welle, B = Nabe. Die Länge des Profils wird immer separat angegeben (S. 210, 215, 217).

#src[B S. 209–218; L-alt D2, überarbeitet.]

#bild("map-kapitel-08", [Mindmap zu Kapitel 8. Eigene Darstellung nach B S. 197–220.], height: 46mm)

*Der Zusammenhang in Kapitel 8.* Wellenenden, Freistiche und Zentrierungen machen Fertigung und Anlage möglich. Welle-Nabe-Verbindungen übertragen Drehmoment; Querschnitt, Bezeichnung und Nutdarstellung folgen der gewählten Verbindung.
#src[B S. 197–220; eigene Zusammenfassung.]
#hoch(<a-8>, [Kapitelübersicht])


#pagebreak(weak: true)
= Kapitel 9 · Sicherungselemente <a-9>

#überblick([Kapitel 9 auf einen Blick],
  idee(<a-9-1>, [Drehmomentübertragung ersetzt keine Axialsicherung.], [Ein Sicherungselement begrenzt die Verschiebung entlang der Welle.]),
  idee(<a-9-1>, [Der Sicherungsring sitzt in einer Nut.], [Seine Funktion und das konstruktive Spiel müssen zur Lagerung passen.]),
  idee(<a-9-2>, [Die Nutmutter verbindet Einstellung mit axialem Halt.], [Das Sicherungsblech verhindert das unerwünschte Verdrehen der Mutter.]),
)

#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Axiale Lage sichern], [Bewegung entlang der Welle begrenzen], ziel: <a-9-1>),
  pfeil(beschriftung: [möglich durch]),
  chunk([Sicherungsring], [Nut · konstruktives Spiel], ziel: <a-9-1>),
  pfeil(beschriftung: [Alternative ist]),
  chunk([Nutmutter mit Sicherungsblech], [Einstellung · axialer Halt · Verdrehschutz], ziel: <a-9-2>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])


Passfedern und Profilwellen übertragen das Drehmoment, halten die Nabe aber #strong[nicht axial] fest. Ein Wellenbund stützt nur auf einer Seite ab. Für die andere Seite braucht man ein #strong[Sicherungselement]: am häufigsten den #strong[Sicherungsring] (billig, schnell, mit etwas Spiel) oder die #strong[Nutmutter mit Sicherungsblech] (aufwändiger, dafür spielfrei) (S. 221, 227). Allgemein ist ein Sicherungselement jedes Element, das die Position eines anderen sichert (auch Gewindestift, Kontermutter, Splint).

#src[B S. 221–230; überarbeitete Erklärung aus L-alt D3. Eigene Beispiele sind jeweils gekennzeichnet.]

== 9.1 Sicherungsringe (DIN 471 Welle, DIN 472 Bohrung) <a-9-1>

#bild("b-sicherungsringe", [Bild 10-3: Sicherungsringe nach DIN 471 und DIN 472. B, S. 222 (PDF-S. 233).], height: 43mm)

- Der Ring sitzt in einer #strong[Ringnut]. Ungespannt ist er nicht kreisrund, seine radiale Breite nimmt zu den Enden ab. Eingebaut verformt er sich #strong[rund] und sitzt mit gleichmäßiger Vorspannung in der Nut (S. 221).
- Montage mit genormten Werkzeugen: #strong[Spreizzange] für Wellenringe (DIN 471), #strong[Zange] zum Zusammendrücken für Bohrungsringe (DIN 472).
- Der überstehende Teil bildet eine #strong[künstliche Schulter], an der sich das Bauteil axial abstützt.
- Die Nut wird mit kleinem Radius (r ≈ 0,1 · s) geschnitten und hat eine #strong[hohe Kerbwirkung]. Sicherungsringe gehören deshalb an #strong[Wellenenden] mit geringer Biegebelastung; eine Entlastungsnut verbessert die Dauerfestigkeit (S. 222).

#note("Beispiel: Axialspiel bei d = 55 mm (S. 222)", [Ring:  s = 2 −0,07       -\>  1,93 … 2,00 mm
Nut:   m = 2,15 H13 (+0,14) -\>  2,15 … 2,29 mm
Spiel min = 2,15 − 2,00 = 0,15 mm
Spiel max = 2,29 − 1,93 = 0,36 mm   (= 0,15 + 0,07 + 0,14)
Das Spiel ist gewollt (der Ring muss in die Nut passen), kann aber zu #strong[Klappern] führen. Prüfe also vorher, ob die Konstruktion es verträgt.])

#text(fill: teal, weight: "bold")[Darstellung in der Gesamtzeichnung (S. 223–224)]

#note("Merke", [Sicherungsringe werden #strong[immer geschnitten] dargestellt, damit man sie erkennt. Der Ring wird so gedreht, dass die #strong[breite Seite oben] (im Schnitt) und die #strong[offene Seite unten] liegt; die offene Seite wird als Ansicht in die Schnittebene hineingedreht, nicht projiziert. Die Umlaufkanten der Nut nicht vergessen.])

- In der Fertigungszeichnung der Nut erhalten Nutgrund und Abstützschulter #strong[Lauf- und Richtungstoleranzen]; ihre Größe richtet sich nach der (nicht bemaßten) Nuttiefe t, z. B. 0,14 · t (Bild 10-5).
- Nuttiefe: Welle #strong[t = (d₁ − d₂)/2], Bohrung #strong[t = (d₂ − d₁)/2] (S. 224).
- Bezeichnung: „#strong[Sicherungsring DIN 471 – 55 × 2]“ (Wellen-Ø × Ringdicke), Bohrung entsprechend „DIN 472 – 55 × 2“ (S. 225).
- Vereinfachung bei Handzeichnungen: Höhe b wie a zeichnen (eigentlich etwa halb so groß), Montagelöcher weglassen. Weitere Vereinfachungen sind nicht genormt.
- Weitere Ringe: mit Lappen (DIN 983/984), Runddraht-Sprengringe (DIN 7993, zurückgezogen), Sicherungsscheiben (DIN 6799).

#src[B S. 221–225; L-alt D3, überarbeitet.]
#hoch(<a-9>, [Kapitelübersicht])


== 9.2 Nutmuttern mit Sicherungsblech <a-9-2>

#bild("b-nutmutter", [Bild 10-7: Nutmutter mit Sicherungsblech. B, S. 227 (PDF-S. 238).], height: 48mm)

Die Nutmutter (DIN 981 für Wälzlager, DIN 1804, DIN 1816) wird auf ein #strong[Feingewinde] der Welle geschraubt. Am Umfang hat sie mehrere #strong[Nuten]: zum Ansetzen eines Haken- oder Schlagschlüssels und zum Einbiegen einer Nase des #strong[Sicherungsblechs] (DIN 5406). Die #strong[innere Nase] des Blechs liegt in einer Längsnut der Welle; so können sich Welle und Mutter nicht mehr gegeneinander verdrehen (S. 225–226).

#note("Montagereihenfolge (Bild 10-6, Buch 10.9)", [1. Lager auf die Welle schieben, 2. Sicherungsblech aufschieben, innere Nase in die Wellennut, 3. Nutmutter aufschrauben und festziehen, 4. eine äußere Nase in eine Nut der Mutter biegen. Die Nenngröße der Mutter ist gleich oder etwas kleiner als die des Lagers, damit das Lager bequem aufgeschoben werden kann (S. 226).])

Bezeichnung: „#strong[Nutmutter DIN 981 – M48 × 1,5]“ und „#strong[Sicherungsblech DIN 5406 – A 48]“ (S. 226).

#text(fill: teal, weight: "bold")[Darstellungsregeln nach Bild 10-8 (S. 228)]

+ Ausnahme: Hier hat das #strong[Gewinde der Nutmutter Vorrang], weil die Welle eine Nut hat und der Schnitt der Mutter über die Nut reicht.
+ Die Wellennut wird mit einem #strong[Ausbruch] gezeigt; Schraffurrichtung und -abstand wie in anderen Schnitten der Welle.
+ Die Nut liegt in der Zeichnung in der Regel #strong[oben].
+ In der Nut ist die Gewindelinie sichtbar.
+ Die Nut reicht #strong[bis unter das Lager], damit immer das Lager die Verschraubung axial begrenzt.
+ Das Sicherungsblech wird #strong[im Vollschnitt] gezeichnet, damit man die (einzige) innere Nase in der Wellennut sieht.
+ Eine äußere Nase wird in die #strong[unten liegende] Mutternut gebogen gezeichnet, auch wenn dort real keine Nut wäre.
+ Weitere Nasen in Ansicht.
+ Der Lagerdeckel liegt am Lager an und ist verschraubt; zwischen Deckel und Gehäuse bleibt ein #strong[Spalt].

Eine vereinfachte Darstellung von Nutmuttern und Sicherungsblechen ist nicht üblich und nicht genormt (S. 227).

#tab(columns: (1fr, 1fr, 1fr),
 th([], [Sicherungsring], [Nutmutter + Sicherungsblech]),
 [Aufwand], [gering: Nut einstechen, Ring einsetzen], [höher: Feingewinde schneiden, Längsnut fräsen, Blech und Mutter montieren],
 [Axialspiel], [immer etwas Spiel (z. B. 0,15–0,36 mm)], [#strong[spielfrei] und nachstellbar],
 [Festigkeit], [hohe Kerbwirkung der Nut], [Kerbwirkung durch Gewinde und Nut],
 [typisch], [Wellenenden, Bohrungen, geringe Axialkräfte], [Wälzlager-Festlager, spielfreie Sicherung],
)

Die Tabelle fasst S. 222 und S. 227 zusammen; die Fertigungsschritte sind aus dem Buchtext abgeleitet (vgl. Buch 10.11).

#src[B S. 225–228; L-alt D3, überarbeitet.]

#bild("map-kapitel-09", [Mindmap zu Kapitel 9. Eigene Darstellung nach B S. 221–230.], height: 46mm)

*Der Zusammenhang in Kapitel 9.* Ein Sicherungsring begrenzt axiale Bewegung mit konstruktivem Spiel. Nutmutter und Sicherungsblech übernehmen Einstellung und Verdrehschutz; die gewählte Lösung muss in Montage und Darstellung erkennbar sein.
#src[B S. 221–230; eigene Zusammenfassung.]
#hoch(<a-9>, [Kapitelübersicht])


#pagebreak(weak: true)
= Kapitel 10 · Wälzlager und Lageranordnungen <a-10>

#überblick([Kapitel 10 auf einen Blick],
  idee(<a-10-1>, [Das Lager überträgt Kräfte zwischen Welle und Gehäuse.], [Wälzkörper ermöglichen die relative Drehbewegung.]),
  idee(<a-10-3>, [Die Bauform muss zum Lastfall passen.], [Radiale und axiale Lastanteile bestimmen die geeignete Lagerfunktion.]),
  idee(<a-10-5>, [Der Lastumlauf bestimmt die Sitzanforderung.], [Die Relativbewegung der Last zum Ring ist dafür entscheidend.]),
  idee(<a-10-6>, [Die Anordnung braucht Führung und Längenausgleich.], [Fest- und Loslageraufgaben müssen gemeinsam erfüllt sein.]),
)

#ablauf(
  chunk([Kräfte und Bewegung erfassen], [radial · axial · Relativbewegung], ziel: <a-10-1>),
  chunk([Bauform und Sitze wählen], [Last zum Ring · Toleranzen der Anschlussteile], ziel: <a-10-5>),
  chunk([Lageranordnung prüfen], [axiale Führung · Längenausgleich · Sicherung], ziel: <a-10-6>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])


Lager übertragen Kräfte zwischen sich drehenden Teilen und dem Gehäuse und sollen dabei wenig Reibung erzeugen. Wälzlager übertragen Lasten über #strong[rollende Wälzkörper]. Gleitanteile bleiben möglich. Sie sind fertige Katalogteile; der Konstrukteur wählt die #strong[Bauform], legt die #strong[Anordnung] (Festlager/Loslager) fest und toleriert die #strong[Anschlussteile] (Welle, Gehäuse). Dieses Kapitel verbindet mehrere Themen, weil es Darstellung (Buchkapitel 4), Passungen (Buchkapitel 7) und Sicherungen (Buchkapitel 10) zusammenführt.

#src[B S. 231–248; überarbeitete Erklärung aus L-alt D4. Eigene Beispiele sind jeweils gekennzeichnet.]

== 10.1 Funktion und Aufbau <a-10-1>

#note("Widerspruch beim Berührungswinkel", [B S. 231 ordnet bei einem Winkel zwischen Kraftrichtung und Lagerebene die Bereiche Radial/Axial umgekehrt zur Herstellerdefinition zu. SKF und NSK messen den Berührungswinkel von der Radialebene: bis einschließlich 45° Radiallager, darüber Axiallager. Diese Definition ist hier ausdrücklich ergänzt; die widersprüchliche Buchzuordnung ist kein bloßer Wechsel des Winkelnullpunkts.], fill: sand)
#src[Ergänzte Prüfung: #link("https://www.nsk.com/tools-resources/abc-bearings/differentiating-rolling-bearings/")[NSK, Differentiating Rolling Bearings]; #link("https://cdn.skfmediahub.skf.com/api/public/094ea584acc90401/pdf_preview_medium/094ea584acc90401_pdf_preview_medium.pdf")[SKF, Radial- und Axiallager, S. 21]; Abruf 24.10.2026.]

#tab(columns: (1fr, 1fr, 1fr),
 th([], [Gleitlager], [Wälzlager]),
 [Prinzip], [direkte Gleitbewegung; Schmierung mit Fett/Öl oder Gleitwerkstoff (PTFE); schnell laufend „schwimmt“ die Welle auf dem Ölfilm], [Wälzkörper zwischen Welle und Gehäuse; #strong[Rollreibung statt Gleitreibung]],
)

Radiallager tragen vorwiegend Kräfte quer zur Wellenachse, Axiallager vorwiegend Kräfte längs der Achse. Eine Bauform kann zusätzlich eine kombinierte Belastung aufnehmen; dafür sind ihre konkreten Daten maßgeblich.


#bild("alt-d4-1", [Rillenkugellager im Schnitt, Proportionen für Handzeichnungen (eigene Skizze, vgl. Bild 11-7, S. 235) Quelle der Skizze: L-alt D4; eigene Darstellung.], height: 56mm)


Ein Wälzlager besteht aus #strong[Innenring] und #strong[Außenring] (Laufringe), den #strong[Wälzkörpern] und dem #strong[Käfig]. Der Käfig verhindert, dass sich die Wälzkörper berühren, und verteilt sie gleichmäßig am Umfang (S. 232).

Wälzkörper: #strong[Kugel, Zylinder (Rolle), Nadel, Kegelrolle, Tonne]; sie geben dem Lager den Namen. Werkstoffe: Wälzlagerstahl, Edelstahl, Kunststoff, Vollkeramik, Hybrid (Stahlringe, Keramikkugeln) (S. 233–234).


#src[B S. 231–234; L-alt D4, überarbeitet.]
#hoch(<a-10>, [Kapitelübersicht])


== 10.2 Darstellung <a-10-2>

#bild("b-lagerproportionen", [Bild 11-7: Proportionen eines Rillenkugellagers für Handzeichnungen. B, S. 235 (PDF-S. 246).], height: 43mm)

- Wälzlager werden #strong[immer im Schnitt] gezeichnet, weil der Innenaufbau die Funktion zeigt.
- Innen- und Außenring erhalten #strong[dieselbe Schraffur] (Richtung und Abstand), obwohl es zwei Teile sind. Geteilte Ringe: kleineres Teil abweichend schraffiert.
- Wälzkörper werden nicht geschnitten; der #strong[Käfig wird im Allgemeinen nicht dargestellt].
- Handzeichnung ohne Katalogwerte: #strong[H = (D − d)/2], Wälzkörper #strong[D#sub[W] ≈ H/2], Ringdicke #strong[H#sub[R] ≈ H/3], Kantenradien #strong[R ≈ H#sub[R]/3 = H/9]. Die Radien dürfen nie fehlen, sonst kann man die Schulterhöhe nicht prüfen (S. 234–235).

#note("Beispiel: Rillenkugellager 6208 (d = 40, D = 80) freihand (eigene Ergänzung, Proportionen S. 235)", [H  = (80 − 40) / 2 = 20 mm
DW ≈ H/2 = 10 mm      HR ≈ H/3 ≈ 6,7 mm      R ≈ H/9 ≈ 2,2 mm])

#src[B S. 234–235; L-alt D4, überarbeitet.]
#hoch(<a-10>, [Kapitelübersicht])


== 10.3 Bauformen <a-10-3>

#tab(columns: (1fr, 1fr, 1fr),
 th([Bauform (Norm)], [Kräfte], [Besonderheit]),
 [#strong[Rillenkugellager] (DIN 625)], [radial hoch, axial beidseitig beträchtlich], [tiefe symmetrische Rillen; einfach, billig, #strong[am meisten verwendet]],
 [#strong[Schrägkugellager] (DIN 628)], [hohe Axialkraft in #strong[einer] Richtung], [niedrige und hohe Schulter, α = 40°; für beide Richtungen paarweise oder zweireihig],
 [#strong[Vierpunktlager] (DIN 628)], [axial beidseitig], [Rillen aus zwei Kreisbögen (4 Berührpunkte); #strong[geteilter Innenring] mit gegenläufiger Schraffur],
 [#strong[Schulterkugellager] (DIN 615)], [gering], [zerlegbar, Außenring mit nur einer Schulter; nur bis d = 30 mm],
 [#strong[Pendelkugellager] (DIN 630)], [radial], [#strong[immer zweireihig], hohlkugelige Außenbahn, gleicht bis 4° Schiefstellung aus],
 [#strong[Zylinderrollenlager] (DIN 5412)], [radial sehr hoch (Linienberührung), axial keine bis gering], [N: Außenring ohne Borde; NU: Innenring ohne Borde (beide #strong[beidseitig verschiebbar]); NJ: einseitig; NUP: beidseitig geführt],
 [#strong[Nadellager] (DIN 617)], [radial], [Sonderform des Zylinderrollenlagers, sehr kleine Bauhöhe, auch ohne Ringe (Nadelkranz)],
 [#strong[Kegelrollenlager] (DIN 720)], [radial und axial hoch, axial nur #strong[eine] Richtung], [Außenring abnehmbar; paarweise spiegelbildlich, Spiel per Nutmutter einstellbar],
 [#strong[Tonnenlager] (DIN 635)], [hohe stoßartige Radialkraft, axial gering], [einreihig, bis 4° Winkelausgleich],
 [#strong[Pendelrollenlager] (DIN 635)], [radial und axial hoch], [zweireihig, nur 0,5° (max. 2°) Einstellbarkeit],
 [#strong[Axial-Rillenkugellager] (DIN 711/715)], [nur axial; einseitig (711) oder zweiseitig (715)], [Wellenscheibe sitzt auf der Welle, Gehäusescheibe berührt die Welle nicht; kugelige Unterlegscheibe gleicht Winkelfehler aus],
)

#src[B S. 234–241; L-alt D4, überarbeitet.]
#hoch(<a-10>, [Kapitelübersicht])


== 10.4 Kurzzeichen (DIN 623) <a-10-4>

#note("Ergänzt: Bohrungskennzahl", [Bei den üblichen codierten Größen 04 bis 96 wird die zweistellige Kennzahl mit 5 mm multipliziert. Ausnahmen: 00 → 10 mm, 01 → 12 mm, 02 → 15 mm, 03 → 17 mm. Sondergrößen und bestimmte kleine oder große Lager werden direkt angegeben, beispielsweise mit Schrägstrich. Deshalb ist „letzte zwei Ziffern mal 5“ keine Regel für jedes beliebige Lagerzeichen.])
#src[Ergänzt nach #link("https://www.skf.com/binaries/pub12/Images/0901d196802809de-Rolling-bearings---17000_1-EN_tcm_12-121486.pdf")[SKF, Rolling bearings, S. 31, Basic bearing designation system]; Abruf 24.10.2026.]

Das Kurzzeichen beginnt mit der #strong[Lagerart]: 6 = Rillenkugellager (einreihig), 2 = Pendelrollenlager, 3 = Kegelrollenlager, N = Zylinderrollenlager. Danach folgen Breiten-/Durchmesserreihe und #strong[Bohrungskennzahl].

#note("Beispiel: 6208 (S. 241)", [6    einreihiges Rillenkugellager
 2   Durchmesserreihe 2 (Breitenreihe 0 wird unterdrückt)
  08 Bohrungskennzahl  -\>  d = 08 · 5 = 40 mm
aus DIN 616: D = 80 mm, B = 18 mm
Die Regel „Bohrungskennzahl × 5 = d“ (für die üblichen codierten Größen 04 bis 96; Sonderfälle beachten) ist eine Ergänzung; das Buch liest die Werte aus der Tabelle DIN 616 ab. Weiteres Beispiel aus Buchkapitel 14: #strong[6006] → d = 30 mm.])

- #strong[Vorsetzzeichen] bezeichnen Einzelteile, z. B. #strong[K] = Käfig mit Wälzkörpern.
- #strong[Nachsetzzeichen] geben Abweichungen an, z. B. #strong[P6] = erhöhte Genauigkeit, #strong[MA] = Messing-Massivkäfig, außenringgeführt; in Buchkapitel 14 z. B. #strong[C3] = vergrößerte Lagerluft (Ergänzung) und #strong[B] bei 7203B.

#src[B S. 241; L-alt D4, überarbeitet.]


#src[Ergänzte Kennzeichen: #link("https://cdn.skfmediahub.skf.com/api/public/0901d196802809de/pdf_preview_medium/0901d196802809de_pdf_preview_medium.pdf")[SKF Rolling bearings, S. 392, Nachsetzzeichen B]; #link("https://www.nsk.com/tools-resources/abc-bearings/fits-and-internal-clearance/")[NSK, Fits and Internal Clearance, Kennzeichen C3]; Abruf 24.10.2026.]
#hoch(<a-10>, [Kapitelübersicht])


== 10.5 Toleranzen der Anschlussteile <a-10-5>

Lagerbohrung d, Außen-Ø D und Breite B haben nach DIN 620 #strong[Minustoleranzen] (Nennmaß = Höchstmaß). Über den Sitz entscheidet also die Toleranz von #strong[Welle] und #strong[Gehäusebohrung]. Kriterien: Lagerart und -größe, Belastung, Verschiebbarkeit des Loslagers und vor allem die #strong[Umlaufverhältnisse] (S. 242).

#note("Punktlast und Umfangslast (S. 245)", [#strong[Punktlast:] Die Kraft wirkt bezogen auf den Ring immer auf #strong[dieselbe Stelle] (Ring und Kraft stehen beide still oder laufen gemeinsam um).\

#strong[Umfangslast:] Die Kraft #strong[läuft relativ zum Ring um] (stehender Ring unter umlaufender Kraft oder umlaufender Ring unter stehender Kraft).])

#note("Merke: Regel für Sitz und Fixierung (S. 245)", [Ring mit #strong[Umfangslast → fester Sitz] (Übergangs- bis mittlere Übermaßpassung), sonst „wandert“ er.\

Ring mit #strong[Punktlast → loser Sitz erlaubt] (enge Spiel- bis weite Übergangspassung).\

Beim Loslager mit äußerer Verschiebung kann der Ring mit Punktlast axial gleiten. Bei N/NU erfolgt der Längenausgleich dagegen im Lagerinneren.])

#tab(columns: (1fr, 1fr, 1fr),
 th([Fall], [Welle (Tab. 11-1)], [Gehäuse (Tab. 11-2)]),
 [Punktlast Innenring, Loslager mit verschiebbarem Innenring], [g6 (g5)], [–],
 [Umfangslast Innenring, Kugellager bis 100 mm, normale/hohe Last], [#strong[k6] (k5); bis 40 mm normal: j6], [–],
 [Umfangslast Innenring, Kugellager bis 200 mm, normale/hohe Last], [m6 (m5)], [–],
 [Punktlast Außenring, Loslager mit leicht verschiebbarem Außenring], [–], [#strong[H7] (H6)],
 [Punktlast Außenring, Wärmezufuhr über die Welle], [–], [G7],
 [Umfangslast Außenring, normale Last/Stöße], [–], [M7 (M6)],
)

#note("Typischer Fall: Getriebewelle", [Die Welle dreht, die Zahnkraft steht im Raum still. Der #strong[Innenring] läuft unter der stehenden Kraft um: #strong[Umfangslast → fester Sitz], z. B. Ø40 #strong[k6]. Der #strong[Außenring] steht still unter stehender Kraft: #strong[Punktlast → loser Sitz], z. B. #strong[H7] im Gehäuse; beim Loslager darf er axial wandern.])

Eine feste Passung allein sichert den Ring #strong[nicht axial]: Zusätzlich braucht man Wellenschultern, Sicherungsringe, Nutmuttern bzw. im Gehäuse Absätze, Deckel oder Sicherungsringe (S. 243).

#src[B S. 242–245; L-alt D4, überarbeitet.]
#hoch(<a-10>, [Kapitelübersicht])


== 10.6 Lageranordnung <a-10-6>

#bild("b-stuetzlagerung", [Bild 11-21: Zwei Seiten einer Stützlagerung. B, S. 245 (PDF-S. 256).], height: 72mm)

- #strong[Festlager-Loslager] (Normalfall): Das #strong[Festlager] ist an Innen- #strong[und] Außenring in beiden Richtungen axial fixiert und nimmt alle Axialkräfte auf. Beim #strong[Loslager] ist ein Ring fixiert, der andere kann axial wandern; das zeigt man in der Zeichnung mit einem #strong[kleinen Abstand] (S. 243–244).
- Grund: Die Welle erwärmt sich stärker als das Gehäuse. Zwei Festlager würden sich bei der #strong[Wärmedehnung] verspannen und beschädigen (S. 244).
- Zylinderrollenlager N und NU sind in sich verschiebbar, also immer Loslager, auch wenn beide Ringe fixiert sind.
- #strong[Stützlagerung]: Jedes Lager nimmt die Axialkraft in einer Richtung auf. Mit Axialspiel bzw. Zylinderrollenlagern heißt das #strong[schwimmende Lagerung], mit Schrägkugellagern in O- oder X-Anordnung #strong[angestellte Lagerung] (S. 245–246).

#src[B S. 243–246; L-alt D4, überarbeitet.]
#hoch(<a-10>, [Kapitelübersicht])


== 10.7 Vereinfachte Darstellung (DIN ISO 8826) <a-10-7>

- Bevorzugt ist die ausführliche Darstellung, weil nur sie alle Informationen zur Lagerung zeigt.
- #strong[8826-1 (allgemein):] Rechteck mit innen liegendem aufrechtem Kreuz, breite Volllinie: „hier sitzt ein Wälzlager“.
- #strong[8826-2 (detailliert):] Symbole zeigen Lastrichtung, Reihenzahl und Einstellbarkeit. Die lange (gerade oder gebogene) Linie steht für die Achse des Wälzelements, kurze Linien für Anzahl und Lage der Reihen (Bild 11-22).

#src[B S. 246; L-alt D4, überarbeitet.]

#bild("map-kapitel-10", [Mindmap zu Kapitel 10. Eigene Darstellung nach B S. 231–248.], height: 46mm)

*Der Zusammenhang in Kapitel 10.* Bauform und Lastverlauf bestimmen die Lagerfunktion. Relativbewegung der Last zum Ring legt die Sitzart nahe; die Lageranordnung muss zusätzlich die axiale Führung und den Längenausgleich ermöglichen.
#src[B S. 231–248; eigene Zusammenfassung.]
#hoch(<a-10>, [Kapitelübersicht])


#pagebreak(weak: true)
= Kapitel 11 · Dichtungen <a-11>

#überblick([Kapitel 11 auf einen Blick],
  idee(<a-11-1>, [Die Dichtaufgabe legt fest, was getrennt werden muss.], [Medium und Umgebung bestimmen die Anforderung.]),
  idee(<a-11-2>, [Die Relativbewegung ordnet das Dichtprinzip ein.], [Ruhende und bewegte Kontaktstellen brauchen unterschiedliche Lösungen.]),
  idee(<a-11-6>, [Das Gegenstück gehört zur Dichtfunktion.], [Einbauraum, Kanten und Oberflächen müssen zur gewählten Dichtung passen.]),
  idee(<a-11-9>, [Berührungsfreie Dichtungen sind ein eigenes Prinzip.], [Ihre Wirkung muss zur konkreten Betriebsbedingung passen.]),
)

#ablauf(
  chunk([Medium und Bewegungsart bestimmen], [drinnen halten · draußen halten · Stoffe trennen], ziel: <a-11-1>),
  entscheidung([Bewegen sich die abzudichtenden Teile relativ zueinander?],
    chunk([Dynamisches Prinzip prüfen], [Drehung oder Längsbewegung unterscheiden], ziel: <a-11-5>),
    chunk([Statische Dichtung prüfen], [passende Flächen und Einbauraum], ziel: <a-11-2>)),
  chunk([Einbau und Zeichnung abstimmen], [Dichtstelle · Kanten · Rauheit · Werkstoff], ziel: <a-11-6>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])


Dichtungen halten etwas #strong[drin] (Öl, Gas, Hydraulikflüssigkeit) oder etwas #strong[draußen] (Schmutz, Staub, Feuchtigkeit) und trennen verschiedene Betriebsstoffe voneinander (S. 249). Für die Zeichnung ist wichtig: Dichtungen werden fast immer #strong[im Schnitt] gezeichnet, ihr Werkstoff zeigt sich in der #strong[Schraffur] oder steht in der Stückliste, und manche Dichtungen brauchen an Welle und Gehäuse #strong[besondere Fertigungsangaben] (Fasen, Toleranzen, Rauheit).

#src[B S. 249–258; überarbeitete Erklärung aus L-alt D5. Eigene Beispiele sind jeweils gekennzeichnet.]

== 11.1 Aufgaben und Einteilung <a-11-1>

Dichtheit wird gefordert, um #strong[Stoffverluste] zu vermeiden (Pneumatik, Hydraulik), um die #strong[Vermischung] verschiedener Betriebsstoffe zu verhindern und um #strong[Verschleiß] durch Schmutz, Staub und Feuchtigkeit zu vermeiden (S. 249).

#tab(columns: (1fr, 1fr, 1fr),
 th([], [berührend], [berührungsfrei]),
 [#strong[ruhende Bauteile]], [#strong[statische Dichtungen]: O-Ring, Flachdichtung, Faltenbalg], [gibt es nicht (S. 249)],
 [#strong[bewegte Bauteile]], [#strong[dynamische Dichtungen]: Radial-Wellendichtring, Filzring, federnde Abdeckscheibe, Stopfbuchse, Formdichtung], [Spalt-, Rillen-, Labyrinthdichtung (Schutz- und Strömungsdichtungen)],
)

#note("Merke", [Zwei Einteilungen werden kombiniert: #strong[ruhend / bewegt] und #strong[berührend / berührungsfrei]. Die Kombination „berührungsfrei an ruhenden Teilen“ wird nicht verwirklicht (S. 249).])

#src[B S. 249; L-alt D5, überarbeitet.]
#hoch(<a-11>, [Kapitelübersicht])


== 11.2 Statische Dichtungen <a-11-2>

Statische Dichtungen dichten zwischen Teilen ab, die sich #strong[nicht gegeneinander bewegen]. Sie wirken, weil sich die Rauheitsspitzen der Bauteiloberfläche in den Dichtungswerkstoff #strong[einbetten]. Dafür braucht es zwei Dinge (S. 249):

+ Der Dichtungswerkstoff ist #strong[weicher] als das Bauteil.
+ Eine #strong[Anpresskraft] drückt die Dichtung an die Fläche, durch Schrauben bei der Montage oder durch den Betriebsdruck (S. 250).

Werkstoffe: Elastomere (Kautschuke), Thermoplaste, fluorhaltige Kunststoffe und bei Stahlbauteilen auch „weiche“ Metalle wie Messing (S. 249–250).

Beispiele (Bild 12-1, S. 250): #strong[Runddichtring (O-Ring)] in einer Nut, #strong[Flachdichtung] am Flansch, #strong[Faltenbalg]. Der Faltenbalg ist eine hermetische Dichtung und kann wegen seiner Form auch bewegte Teile abdichten.

#src[B S. 249–250; L-alt D5, überarbeitet.]
#hoch(<a-11>, [Kapitelübersicht])


== 11.3 Darstellung von Dichtungen <a-11-3>

- Statische Dichtungen werden #strong[immer im Schnitt] gezeichnet. So sieht man Bauteil, Querschnitt und Funktion der Dichtung.
- Die #strong[Schraffur zeigt den Werkstoff] (vgl. Kapitel 4): Elastomer- oder Kunststoffdichtungen erhalten meist eine #strong[Kreuzschraffur], Metalldichtungen die normale #strong[45°-Schraffur].
- Ist die Dichtung zu #strong[dünn] zum Schraffieren, wird der Schnitt #strong[geschwärzt]. Dann muss der Werkstoff unbedingt aus der #strong[Stückliste] hervorgehen.

#note("Achtung", [Ein O-Ring wird im eingebauten Zustand #strong[verformt] gezeichnet, nicht kreisrund. Die Verformung erzeugt erst die Anpresskraft (S. 252).], fill: sand)

#src[B S. 250; L-alt D5, überarbeitet.]
#hoch(<a-11>, [Kapitelübersicht])


== 11.4 Runddichtring (O-Ring, DIN 3771) <a-11-4>

#bild("b-o-ring", [Bild 12-3: O-Ring in radial verformter Einbaulage. B, S. 251 (PDF-S. 262).], height: 39mm)


#bild("alt-d5-1", [O-Ring in Rechtecknut, radial verformt (eigene Skizze, vgl. Bild 12-3, S. 251) Quelle der Skizze: L-alt D5; eigene Darstellung.], height: 52mm)


Der O-Ring ist die #strong[häufigste statische Dichtung] für Flüssigkeiten und Gase. Bei kleinen Geschwindigkeiten kann er sogar dynamisch abdichten (S. 250–251).

Maße: #strong[d1] = Innendurchmesser, #strong[d2] = Schnurstärke (Querschnittsdurchmesser). Zu einem d1 gibt es meist mehrere d2 (S. 251).

Einbau: in eine #strong[Rechtecknut] mit radialer oder axialer Verformung. Dreiecknuten sind zulässig, Rechtecknuten aber vorzuziehen (S. 252).


Bezeichnung O-Ring (S. 251)
O-Ring  DIN 3771 – 13,2 x 1,8 – N – NBR70
         Norm     d1    d2   Sorte  Werkstoff (mit Härte)

Ergänzung (nicht im Buch erklärt): „N“ steht für die Standard-Sortenklasse, „NBR70“ für Nitrilkautschuk mit Härte 70 Shore A. Das Buch sagt nur, dass bei Elastomeren die Härte in der Bezeichnung stehen muss (S. 251).

In Bild 12-3 (S. 251) sind die Einbauvorschriften eingetragen: Nutbreite #strong[B + 0,2], Nuttiefe #strong[(T)], Passung zwischen Bohrung und Kolben #strong[Ø H8/f7], Nutgrund #strong[Ø h9]. Die Nutmaße hängen #strong[nur von d2] ab (S. 252):

#tab(columns: (1fr, 1fr, 1fr),
 th([d2 \[mm\]], [T \[mm\]], [B \[mm\]]),
 [2], [1,5], [2,6],
 [4], [3,15], [5,2],
 [6], [4,95], [7,8],
 [8], [6,75], [10,4],
)

Tabelle 12-1 (S. 252), Rechtecknut bei radialer Verformung. Weitere Maße stehen in Herstellerkatalogen.

#note("Beispiel: Nut für O-Ring mit d2 = 4 mm (eigene Ergänzung, Werte aus Tab. 12-1, S. 252)", [Nuttiefe  T = 3,15 mm   -\>  Verpressung ca. 4 − 3,15 = 0,85 mm (abgeleitet)
Nutbreite B = 5,2 mm    -\>  Zeichnungsangabe: 5,2 +0,2])

#src[B S. 251–252; L-alt D5, überarbeitet.]
#hoch(<a-11>, [Kapitelübersicht])


== 11.5 Dynamische Dichtungen: Grundprinzip <a-11-5>

Dynamische Dichtungen dichten zwischen #strong[bewegten] Teilen ab. Meist presst eine #strong[Feder] eine Kunststofflippe an das bewegte Teil. Bei Flüssigkeiten bildet sich ein #strong[Schmierfilm] an der Gleitfläche; er verhindert schnellen Verschleiß, führt aber langfristig zu #strong[kleinen Leckverlusten] (S. 252).

#src[B S. 252; L-alt D5, überarbeitet.]
#hoch(<a-11>, [Kapitelübersicht])


== 11.6 Radial-Wellendichtring (RWDR, DIN 3760) <a-11-6>

#bild("b-rwdr", [Bild 12-5: Einbaurichtlinien für Radial-Wellendichtringe. B, S. 253 (PDF-S. 264).], height: 60mm)


#bild("alt-d5-2", [RWDR im Einbau, Montage mit der Dichtlippe voran (eigene Skizze, vgl. Bild 12-4/12-5, S. 253) Quelle der Skizze: L-alt D5; eigene Darstellung.], height: 52mm)


Der RWDR dichtet #strong[rotierende Wellen] gegen stehende Gehäuse ab. Er besteht aus drei Teilen, die in der Zeichnung unterschiedlich aussehen (S. 252–253):

- #strong[Kunststoffkörper] mit Dichtlippe: meist #strong[geschwärzt]
- metallischer #strong[Versteifungsring]: #strong[schraffiert]
- #strong[Feder], die die Lippe anpresst: #strong[zwei kleine konzentrische Kreise]


#strong[Einbaurichtlinien] (Bild 12-5, S. 253): Die Dichtlippe ist empfindlich, deshalb muss die Konstruktion die Montage schon vorbereiten.

#tab(columns: (1fr, 1fr),
 th([Stelle], [Vorgabe]),
 [Welle, Montage #strong[mit der Lippe voran]], [Fase #strong[15° bis 25°], Kante gerundet und poliert],
 [Welle, Montage #strong[mit der Lippe nach hinten]], [Radius #strong[R ≥ 1 mm] genügt, Fase ist günstiger],
 [Gehäusebohrung], [genügend breite Aufnahme, Fase #strong[5° bis 10°]],
 [Toleranzen (S. 254)], [Bohrung #strong[H8], Welle #strong[h11], Rundheit der Welle nach IT 8 („drallfrei geschliffen“)],
 [Rauheit Welle (S. 254)], [#strong[Ra = 0,2 bis 0,8 µm] (Rz = 1 bis 4 µm; Rmax = 6 µm)],
 [Rauheit Bohrung (S. 254)], [Rmax höchstens 25 µm],
)

#note("Achtung: Rauheit nach unten begrenzt", [Die Welle darf #strong[nicht zu glatt] sein. Sonst fehlt der Schmierfilm und die Dichtlippe läuft heiß (S. 254). Darum gibt man hier eine #strong[obere und untere Grenze] an (vgl. Kapitel 5, Grenzwertangabe U/L).], fill: sand)

Bezeichnung RWDR (S. 254)
Wellendichtring DIN 3760 – A 25 x 40 x 7 NB
                 Norm    Form d1  d2  B  Werkstoff Elastomerteil

d1 = Wellendurchmesser, d2 = Gehäusedurchmesser, B = Breite. Ergänzung: NB steht für Nitrilkautschuk (NBR).

#src[B S. 252–254; L-alt D5, überarbeitet.]
#hoch(<a-11>, [Kapitelübersicht])


== 11.7 Filzring und federnde Abdeckscheibe <a-11-7>

- #strong[Filzring (DIN 5419)]: ungespannt rechteckiger Querschnitt. Die Nut im Gehäuse oder Deckel ist #strong[konisch] (7° Seitenwinkel, also 14° Öffnungswinkel), dadurch wird der Ring bei der Montage zusammengedrückt und presst gegen die Welle. Er wird #strong[geölt] eingebaut, das Öl verbessert die Notlaufeigenschaften. Der Ring liegt #strong[nicht am Nutgrund] auf (Platz für Wärmedehnung), und dieser Abstand wird gezeichnet (S. 254).
- Bezeichnung: #strong[Filzring DIN 5419 – 40 – M5] (Wellendurchmesser 40 mm, Filzhärte M5) (S. 254).
- #strong[Federnde Abdeckscheiben] dichten #strong[Wälzlager bei Fettschmierung]. Eine Seite wird am Innenring (innen gespannt) oder am Außenring (außen gespannt) eingespannt, die andere liegt federnd an der Stirnfläche des anderen Lagerrings und arbeitet sich dort eine feine Rille ein (S. 254).
- Abdeckscheiben sind aus Metall, aber so dünn, dass sie #strong[geschwärzt] gezeichnet werden (S. 255).

#src[B S. 254–255; L-alt D5, überarbeitet.]
#hoch(<a-11>, [Kapitelübersicht])


== 11.8 Abdichtung bei Längsbewegungen <a-11-8>

- #strong[Stopfbuchsenpackung (DIN 3780)]: geschichtete oder geflochtene Ringe (natürlich, Kunststoff, Metall) in einem Ringraum. Ein Ringelement, die #strong[Brille], drückt sie mit Schrauben zusammen. Geeignet für axiale, drehende und kombinierte Bewegungen (S. 255).
- Stopfbuchsen werden meist #strong[nicht im Detail] gezeichnet. Darum muss die genaue #strong[Herstellerbezeichnung in der Stückliste] stehen, ggf. mit Montagehinweis (S. 256).
- #strong[Formdichtungen] (S. 256): #strong[Lippendichtungen] arbeiten wie der RWDR mit vorgespannter oder gefederter Lippe; #strong[Kompaktdichtungen] sind selbst radial verpresst.

#src[B S. 255–256; L-alt D5, überarbeitet.]
#hoch(<a-11>, [Kapitelübersicht])


== 11.9 Berührungsfreie Dichtungen <a-11-9>

Sie dichten über einen #strong[engen Spalt]. Weil nichts schleift, sind sie praktisch #strong[verschleiß- und reibungsfrei] und eignen sich für #strong[hohe Drehzahlen]. Die Form des Spalts bestimmt die Wirkung (S. 256).

#tab(columns: (1fr, 1fr, 1fr),
 th([], [Schutzdichtungen], [Strömungsdichtungen]),
 [Einsatz], [Schutz gegen Schmutz, kein großer Druckunterschied (abgeleitet)], [bei #strong[Druckunterschied] zwischen Gehäuse und außen, z. B. Dampfturbine],
 [Bauformen], [Spalt-, Rillendichtung, axiale und radiale Labyrinthdichtung (Bild 12-10)], [meist #strong[Labyrinthdichtung]: verwirbelt das Medium und bremst es ab (Bild 12-11)],
 [Zeichnung], [aus Stahl, also im Schnitt mit einfacher 45°-Schraffur; Details müssen erkennbar sein], [Labyrinth erfordert oft ein #strong[zweigeteiltes Gehäuse]],
 [Leckage], table.cell(colspan: 2, rowspan: 1)[Bei Strömungsdichtungen ist #strong[immer] mit einer Leckmenge zu rechnen (S. 257).],
)

#src[B S. 256–257; L-alt D5, überarbeitet.]
#hoch(<a-11>, [Kapitelübersicht])


== 11.10 Vereinfachte Darstellung (DIN ISO 9222) <a-11-10>


#bild("alt-d5-3", [Symbol nach DIN ISO 9222-1 (eigene Skizze, vgl. Bild 12-12 a/b, S. 257) Quelle der Skizze: L-alt D5; eigene Darstellung.], height: 52mm)


- Die #strong[ausführliche] Darstellung ist immer vorzuziehen. Vereinfacht wird nur, wenn alle Funktionen klar sind und die Dichtung untergeordnet ist (S. 257).
- #strong[DIN ISO 9222-1]: „Hier ist eine Dichtung“ = #strong[Rechteck mit Diagonalkreuz] in breiter Volllinie; die Dichtungsrichtung zeigt ein #strong[Pfeil].
- #strong[DIN ISO 9222-2]: symbolische Darstellung der Bauart, z. B. RWDR mit oder ohne Schmutzlippe, Lippendichtung, Labyrinth.


#src[B S. 257; L-alt D5, überarbeitet.]

#bild("map-kapitel-11", [Mindmap zu Kapitel 11. Eigene Darstellung nach B S. 249–258.], height: 46mm)

*Der Zusammenhang in Kapitel 11.* Dichtungsart und Bewegung legen das Wirkprinzip fest. Einbauraum, Montagekanten, Passungen und Oberflächen bestimmen gemeinsam, ob die Dichtlippe oder der Ring die vorgesehene Funktion erfüllen kann.
#src[B S. 249–258; eigene Zusammenfassung.]
#hoch(<a-11>, [Kapitelübersicht])


#pagebreak(weak: true)
= Kapitel 12 · Zahnräder <a-12>

#überblick([Kapitel 12 auf einen Blick],
  idee(<a-12-1>, [Wellenlage und Bewegungsübertragung bestimmen die Bauart.], [Stirnrad, Kegelrad und Schnecke beschreiben unterschiedliche Getriebeprinzipien.]),
  idee(<a-12-2>, [Modul und Zähnezahl bestimmen wesentliche Größen.], [Die verwendeten Formeln müssen zur behandelten Verzahnungsgeometrie passen.]),
  idee(<a-12-3>, [Symbolische Linien ersetzen das Zeichnen aller Zähne.], [Kopf- und Teilkreis machen die vereinfachte Darstellung lesbar.]),
  idee(<a-12-6>, [Die Tabelle ergänzt die Geometrie.], [Verzahnungsdaten und Qualitätsangaben machen die Zeichnung vollständig.]),
)

#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Getriebeprinzip], [Wellenlage · Zahnradart], ziel: <a-12-1>),
  pfeil(beschriftung: [bestimmt Modell für]),
  chunk([Geometrie], [Modul · Zähnezahl · Kreise], ziel: <a-12-2>),
  pfeil(beschriftung: [wird übermittelt durch]),
  chunk([Zeichnung und Tabelle], [symbolische Linien · Verzahnungsdaten], ziel: <a-12-6>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])


Zahnräder exakt zu zeichnen wäre viel zu aufwendig. Deshalb gibt es feste #strong[Symbolregeln] (DIN ISO 2203): Ein Zahnrad sieht in der Zeichnung aus wie eine Scheibe bis zum Kopfkreis, und nur die #strong[strichpunktierte Teilkreislinie] verrät, dass es ein Zahnrad ist (S. 261–262). Eine zusätzliche „vereinfachte Darstellung“ gibt es nicht, weil die normgerechte Darstellung schon die vereinfachte ist (S. 259). Rechnerisch dreht sich alles um den #strong[Modul m].

#src[B S. 259–268; überarbeitete Erklärung aus L-alt D6. Eigene Beispiele sind jeweils gekennzeichnet.]

== 12.1 Bauarten der Zahnradgetriebe <a-12-1>

#bild("b-getriebearten", [Bild 13-2: Getriebearten nach Stellung der Wellen. B, S. 260 (PDF-S. 271).], height: 94mm)

Man teilt nach der #strong[Grobgestalt der Räder] (Zylinder, Kegel, Schnecke) und der #strong[Lage der Wellen] ein (Bild 13-2, S. 260):

#tab(columns: (1fr, 1fr),
 th([Wellenlage], [Getriebeart]),
 [Wellen #strong[parallel]], [Stirnradgetriebe (außen- oder innenverzahnt, auch Zahnstange)],
 [Wellen #strong[schneiden sich]], [Kegelradgetriebe],
 [Wellen #strong[kreuzen sich]], [Schneckengetriebe, Schraubradgetriebe, Kegelschraubgetriebe (Hypoidgetriebe)],
)

Die Zahnform ist für die Kraftübertragung wichtig. In der Praxis am weitesten verbreitet ist die #strong[Evolventenverzahnung]; alle Erklärungen beziehen sich darauf (S. 260).

#src[B S. 259–260; L-alt D6, überarbeitet.]
#hoch(<a-12>, [Kapitelübersicht])


== 12.2 Kenngrößen einer Verzahnung <a-12-2>

#note("Gültigkeit der ergänzten Formeln", [Die Beziehungen da = m(z + 2), a = (d1 + d2)/2 und i = z2/z1 gelten hier für ein unverschobenes, außenverzahntes geradverzahntes Stirnradpaar mit gleichem Modul. Die Übersetzung ist als Betrag bei Antrieb 1 und Abtrieb 2 angegeben; die Räder drehen entgegengesetzt. Schrägverzahnung, Profilverschiebung und Kegelräder benötigen angepasste Beziehungen.], fill: sand)


#bild("alt-d6-1", [Zahnausschnitt eines geradverzahnten Stirnrads (eigene Skizze, vgl. Bild 13-3, S. 261) Quelle der Skizze: L-alt D6; eigene Darstellung.], height: 56mm)


Der #strong[Modul m] ist die zentrale Größe einer Verzahnung. Er ist definiert als Teilkreisdurchmesser durch Zähnezahl (S. 260).

Vorteil: Ganze Zähnezahlen, „glatte“ Teilkreisdurchmesser und „glatte“ Modulwerte passen zusammen. Zwei Räder, die miteinander kämmen, müssen #strong[den gleichen Modul] haben (S. 260).

Der Modul ist #strong[nicht frei wählbar]: DIN 780 gibt Werte von 0,05 bis 70 mm vor; #strong[Reihe I] ist gegenüber Reihe II zu bevorzugen (S. 261).


Grundformeln Verzahnung (S. 260–261)

#form[
$ m  = frac(d, z) $
$ h _(a)  = m $
$ h _(f)  = m  + c $
]

d = Teilkreisdurchmesser, z = Zähnezahl, ha = Kopfhöhe, hf = Fußhöhe, c = Kopfspiel (Bruchteil von m)

Daraus abgeleitet (nicht als Formel im Buch)

#form[
$ d  = m   dot  z $
$ d _(a)  = d  + 2h _(a)  = m  thin (z +2) $
$ d _(f)  = d  - 2h _(f) $
]


#form[
$ p  =  pi   dot  m $
$ h  = h _(a)  + h _(f) $
]

da = Kopfkreis-, df = Fußkreisdurchmesser, p = Teilung, h = Zahnhöhe. Ergänzung für Radpaare: Achsabstand a = (d1 + d2)/2, Übersetzung i = z2/z1.

#note("Beispiel: Stirnrad m = 3 mm, z = 45 (Werte aus der Verzahnungstabelle S. 267, Rechnung abgeleitet)", [d  = m · z        = 3 · 45      = 135 mm
ha = m            = 3 mm        -\>  da = 135 + 2 · 3   = 141 mm
c  = 0,25 · m     = 0,75 mm     (Annahme, üblich nach Bezugsprofil DIN 867)
hf = m + c        = 3,75 mm     -\>  df = 135 − 2 · 3,75 = 127,5 mm
p  = π · m        = 9,42 mm])

Das Buch nennt als Beispiel für das Kopfspiel einen Bruchteil von m (S. 261). In Aufgaben gilt der Wert, den die Vorlesung oder Aufgabe vorgibt.

#src[B S. 260–261; L-alt D6, überarbeitet.]
#hoch(<a-12>, [Kapitelübersicht])


== 12.3 Darstellungsregeln nach DIN ISO 2203 <a-12-3>

#bild("b-stirnrad", [Bild 13-4: Stirnrad in Ansicht, Halbschnitt und Vollschnitt. B, S. 263 (PDF-S. 274).], height: 46mm)


#bild("alt-d6-2", [Stirnrad: Ansicht mit Kopfkreis (breit), Teilkreis (Strichpunkt), Fußkreis (schmal, optional); Vollschnitt mit zwei ungeschnittenen Zähnen (eigene Skizze, vgl. Bild 13-4, S. 263) Quelle der Skizze: L-alt D6; eigene Darstellung.], height: 56mm)


#strong[Einzelnes Zahnrad] (S. 261–262):

+ #strong[Ansicht]: wie ein ganzes Teil #strong[bis zum Kopfkreis], ohne Zähne.
+ #strong[Teilkreis] (Bezugsfläche) immer als #strong[schmale Strichpunktlinie]. In der Ansicht ist sie das #strong[einzige] Merkmal, das ein Zahnrad von einer Scheibe unterscheidet.
+ #strong[Fußkreis] in Ansichten nur bei Bedarf, als #strong[schmale Volllinie].


+ #strong[Schnitte] werden normalerweise parallel zur Radachse gelegt (#strong[Achsschnitt]). Die Zähne bleiben #strong[ungeschnitten]; die Schraffur endet an der #strong[Fußlinie]. Im Vollschnitt zeichnet man #strong[zwei gegenüberliegende] ungeschnittene Zähne, auch bei ungerader Zähnezahl (S. 261).
+ #strong[Zähne] werden nur gezeichnet, wenn es unbedingt nötig ist (z. B. Lage zu anderen Formelementen), dann #strong[höchstens zwei] (S. 262).
+ #strong[Schräg- oder Pfeilverzahnung] kann in einer achsparallelen Ansicht durch #strong[drei schmale Volllinien] in Form und Richtung angedeutet werden. Das ist nicht Pflicht; die Steigung muss aber immer aus den Fertigungsunterlagen hervorgehen (S. 262).

#note("Merke: Radpaare (S. 262)", [Gegenseitige Verdeckungen werden normalerweise #strong[nicht] berücksichtigt. Ausnahmen: (1) Liegt ein Rad in der Ansicht vollständig vor dem anderen, gilt das hintere als verdeckt. (2) Sind beide Räder im Achsschnitt gezeichnet, wird eine Verzahnung als „vorne liegend“ angenommen, die andere teilweise verdeckt (Strichlinie). Üblich: das #strong[Ritzel] (kleineres Rad) liegt vorne.])

#src[B S. 261–262; L-alt D6, überarbeitet.]
#hoch(<a-12>, [Kapitelübersicht])


== 12.4 Stirnräder, Kegelräder, Schnecken <a-12-4>

#tab(columns: (1fr, 1fr, 1fr),
 th([Bauform], [Besonderheiten der Darstellung], [„vorne liegend“]),
 [#strong[Stirnrad] (S. 262–263)], [Wellen parallel, Räder zylindrisch. Ansicht, Halbschnitt, Vollschnitt nach den Grundregeln (Bild 13-4). Auch #strong[Innenverzahnung] (Hohlrad, Bild 13-5 b) möglich.], [Ritzel],
 [#strong[Zahnstange] (S. 262–263)], [Zahnrad mit unendlich großem Radius. In der Draufsicht verdeckt das Rad die Zahnstange (Bild 13-6).], [Rad vor Zahnstange],
 [#strong[Kegelrad] (S. 264)], [Teilkreisdurchmesser ändert sich über die Zahnbreite. Gezeichnet wird der #strong[mittlere Teilkreisdurchmesser], weil mit ihm gerechnet wird (Bild 13-7).], [Ritzel vor #strong[Tellerrad] (Halbschnitt, Bild 13-8)],
 [#strong[Schneckengetriebe] (S. 265)], [Grundregeln wie oben (Bild 13-9).], [#strong[Schnecke]; das Schneckenrad wird verdeckt],
)

Fußnote S. 262: Beveloidräder sind eine Ausnahme unter den Stirnrädern; ihre Außenform ist durch eine spezielle Verzahnung kegelstumpfförmig.

#src[B S. 262–265; L-alt D6, überarbeitet.]
#hoch(<a-12>, [Kapitelübersicht])


== 12.5 Verzahnungsqualität und Toleranzen <a-12-5>

- Verzahnungen haben ein eigenes Toleranzsystem (ähnlich wie Gewinde und Wälzlager), weil ihre Güte besondere Messgrößen braucht (S. 265).
- #strong[12 Verzahnungsqualitäten] (Grundlage DIN 3961, zurückgezogen): #strong[1 = höchste], praktisch kaum herstellbare Genauigkeit, #strong[12 = gröbste]. Die meisten Getriebe liegen bei #strong[5 bis 8] (S. 265).
- DIN ISO 1328-2: zulässige Zweiflanken-Wälzabweichung für Stirnräder. DIN 3965: zulässige Abweichungen für Kegelräder, gestuft nach d oder b (S. 265).
- #strong[DIN 3967 (Getriebe-Passsystem)]: Kennbuchstabe = oberes Zahndickenabmaß, Kennzahl = Zahndickentoleranz. Ziel: ein #strong[Kleinst-Flankenspiel] nicht unterschreiten (Wärmedehnung) und ein #strong[Größt-Flankenspiel] nicht überschreiten (Stöße bei Lastwechsel) (S. 266).

#note("Merke", [Wie bei ISO-Toleranzen gilt: kleine Zahl = genau. Andere Kennzahlen als im ISO-System sollen Verwechslungen vermeiden (S. 266).])

#src[B S. 265–266; L-alt D6, überarbeitet.]
#hoch(<a-12>, [Kapitelübersicht])


== 12.6 Angaben in der Zahnradzeichnung (DIN 3966-1) <a-12-6>

#strong[Direkt an der Darstellung] sind anzugeben (Bild 13-10, S. 267):

+ #strong[Kopfkreisdurchmesser], bei Bedarf mit Abmaßen.
+ #strong[Fußkreisdurchmesser], falls nicht die Zahnhöhe angegeben ist.
+ #strong[Zahnbreite].
+ #strong[Bezugselemente] mit Toleranz: Außenverzahnung → Bohrung; Ritzelwelle → Wellenachse; Innenverzahnung → Außendurchmesser des Hohlrads.
+ #strong[Lagetoleranzen] vom Bezug aus, z. B. Rund- und Planlauf.
+ #strong[Oberfläche der Zahnflanken]: Symbol auf die #strong[Teilkreis-Strichpunktlinie] setzen; ggf. auch Zahnfuß und Fußrundung.

Dazu kommt immer eine #strong[Verzahnungstabelle] (neben der Zeichnung oder separat), mindestens mit (S. 267):

#tab(columns: (1fr, 1fr),
 th([Angabe], [Beispiel aus dem Buch]),
 [Außen- oder Innenverzahnung], [Außenverzahnung],
 [Modul], [m = 3 mm],
 [Zähnezahl], [z = 45],
 [Bezugsprofil], [DIN 867],
 [Schrägungswinkel], [β = 0°],
 [Profilverschiebungsfaktor], [x = 0,5],
 [Verzahnungsqualität], [8 e 26],
 [Achsabstand im Gehäuse mit Abmaßen], [a = 100,5 ± 0,027 mm],
 [Gegenrad], [Zähnezahl und/oder Sachnummer],
)

Ergänzung zur Lesart „8 e 26“: Qualität 8, Kennbuchstabe e für das obere Zahndickenabmaß, Kennzahl 26 für die Zahndickentoleranz (System nach DIN 3967, S. 266).

#src[B S. 266–267; L-alt D6, überarbeitet.]

#bild("map-kapitel-12", [Mindmap zu Kapitel 12. Eigene Darstellung nach B S. 259–268.], height: 46mm)

*Der Zusammenhang in Kapitel 12.* Wellenlage und Zahnradart legen das Prinzip fest. Modul und Zähnezahl beschreiben die Größe; vereinfachte Zeichnung und Verzahnungstabelle vermitteln die Geometrie ohne jeden Zahn vollständig zu konstruieren.
#src[B S. 259–268; eigene Zusammenfassung.]
#hoch(<a-12>, [Kapitelübersicht])


#pagebreak(weak: true)
= Kapitel 13 · Zeichnungen lesen und erstellen <a-13>

#überblick([Kapitel 13 auf einen Blick],
  idee(<a-13-1>, [Die Baugruppe wird zuerst als Funktion verstanden.], [Ansichten, Schnitte und Kraftwege erklären das Zusammenwirken der Teile.]),
  idee(<a-13-3>, [Die Stückliste identifiziert die Bestandteile.], [Normteile und eigene Bauteile werden den Positionen zugeordnet.]),
  idee(<a-13-4>, [Die Montagefolge erklärt Anschlüsse und Sicherungen.], [Unterbaugruppen machen den Zusammenbau übersichtlich.]),
  idee(<a-13-7>, [Die Einzelteilzeichnung folgt aus der Bauteilfunktion.], [Ansichten und Anforderungen müssen Fertigung und Prüfung eindeutig ermöglichen.]),
)

#ablauf(
  chunk([Gesamtzeichnung erschließen], [Funktion · Kraftweg · Lagerung], ziel: <a-13-1>),
  chunk([Teile und Montage zuordnen], [Stückliste · Normteile · Unterbaugruppen], ziel: <a-13-4>),
  chunk([Einzelteil vollständig beschreiben], [Ansichten · Maße · Toleranzen · Oberfläche], ziel: <a-13-7>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])


Hier wird alles aus Grundlagen und Maschinenelementen #strong[zusammen angewendet]. Buchkapitel 14 zeigt, wie man eine fremde, komplexe #strong[Gesamtzeichnung erschließt]: mit einfachen Leitfragen, über die Stückliste und über die Montagereihenfolge. Buchkapitel 15 geht den umgekehrten Weg und baut für ein Einzelteil, das #strong[Flanschlager], Schritt für Schritt eine vollständige #strong[Einzelteilzeichnung] auf (S. 269, 283).

#src[B S. 269–290; überarbeitete Erklärung aus L-alt E1. Eigene Beispiele sind jeweils gekennzeichnet.]

== 13.1 Eine Gesamtzeichnung lesen: Leitfragen <a-13-1>

#bild("b-spiralkegelgetriebe", [Bild 14-1: Gesamtzeichnung des Spiralkegelgetriebes. B, S. 270 (PDF-S. 281).], height: 141mm)

Das Buch erschließt das Getriebe mit Fragen, die bewusst #strong[allgemein] gehalten sind und sich auf andere Zeichnungen übertragen lassen (S. 269):

#note("Leitfragen für jede Gesamtzeichnung (nach S. 269–277, zusammengefasst)", [


+ #strong[Funktion:] Was soll die Baugruppe ganz allgemein tun?
+ #strong[Schnittstellen:] Wo kommt Leistung herein, wo geht sie heraus (Wellenenden, Passfedern, Flansche)?
+ #strong[Lagerung:] Wie sind die Wellen gelagert? Gibt es eine Fest-Los-Anordnung?
+ #strong[Größenverhältnisse:] Was verraten Durchmesser und Radgrößen über Momente und Übersetzung?
+ #strong[Normteile:] Welche Schrauben, Lager, Dichtungen, Sicherungen gibt es, mit welcher Position?
+ #strong[Montage:] Welche Unterbaugruppen bilden sich, in welcher Reihenfolge wird montiert?
+ #strong[Einzelteile:] Welche Teile berührt ein Bauteil, und welche Toleranz braucht deshalb welche Fläche?
])

#note("Merke: Bauteile in der Gesamtzeichnung finden (S. 277)", [Folge der #strong[Schraffur]: Ein Bauteil hat in der ganzen Zeichnung dieselbe Schraffurrichtung und denselben Abstand, und keine andere Fläche darf diese Kombination nochmal verwenden (vgl. Kapitel 4). Das Buch empfiehlt, das Teil farbig nachzuziehen. Vorsicht bei ähnlichen Schraffuren (Lagerhalter 9 und Distanzring 21).])

#src[B S. 269–272; L-alt E1, überarbeitet.]
#hoch(<a-13>, [Kapitelübersicht])


== 13.2 Funktion des Spiralkegelgetriebes <a-13-2>

#tab(columns: (1fr, 1fr),
 th([Frage], [Antwort aus der Zeichnung]),
 [Übertragungs- oder Führungsgetriebe?], [#strong[Übertragungsgetriebe]: drei Wellenenden mit Passfeder schauen aus dem Gehäuse, also werden Drehmoment und Drehzahl weitergeleitet. (Führungsgetriebe führen Punkte auf Bahnen.)],
 [Wo ist An-, wo Abtrieb?], [Die beiden horizontalen Wellenenden gehören zu #strong[einer] Welle. Antrieb daher an der #strong[vertikalen Welle] (Ritzelwelle 16), Abtrieb über die horizontale Welle (20).],
 [Wie sind die Wellen gelagert?], [Antriebswelle: zwei #strong[Schrägkugellager] (43, 44). Abtriebswelle: zwei #strong[Rillenkugellager] (45). #strong[Keine] Fest-Los-Anordnung.],
 [Momentenverhältnis?], [Gleich große Wellenenden, Ritzel (16) und Tellerrad (15) scheinbar gleich groß: etwa #strong[gleiche Momente]; Abtrieb wahlweise links oder rechts.],
)

Ergebnis: Das Getriebe #strong[lenkt Drehmoment und Drehzahl um 90° um], es wandelt kaum. Der Herstellerkatalog bestätigt: beliebige Drehrichtung, in jeder Lage einsetzbar, Befestigungsgewinde auf allen sechs Flächen (S. 271).

#src[B S. 269–272; L-alt E1, überarbeitet.]
#hoch(<a-13>, [Kapitelübersicht])


== 13.3 Normteile und Stückliste <a-13-3>

#tab(columns: (1fr, 1fr, 1fr),
 th([Normteilgruppe], [Pos.], [genauer (Tab. 14-1)]),
 [Wälzlager], [43, 44 / 45], [Schrägkugellager #strong[7203 B] / Rillenkugellager #strong[6006 C3] (2 Stück)],
 [Mutter + Sicherung], [52, 53], [#strong[Nutmutter] (Wellen-Mutter) mit #strong[Sicherungsblech]],
 [Dichtungen], [58, 59 / 77–80], [#strong[Radial-Wellendichtringe] 15×24×7 und 18×32×6 / #strong[O-Ringe] 50×2,0, 24×3,0, 11×2,5],
 [Passfedern], [67, 68, 69], [DIN 6885 A 5×5×25 und A 6×6×25],
 [Schrauben], [61, 62, 74], [Zylinderschrauben DIN 6912 M5×16 und M5×10, Festigkeit 8.8; Verschlussschrauben M12×1,5 DIN 908],
)

Das Buch nennt als Sicherung nur Pos. 53. Verschlussschraube 73 und Ölauge 76 stehen zusätzlich in der Stückliste (S. 272, 274).

- #strong[43 und 44 sind identische Lager], aber mit unterschiedlicher #strong[Einbaurichtung]. Darum bekommen sie zwei Positionsnummern; Rillenkugellager haben keine Einbaurichtung und teilen sich Pos. 45. Das Buch weist darauf hin, dass die Bezeichnungen 43/44 in Bild 14-1 und 14-2 vertauscht sind (S. 272).

#note("Widerspruch im Buch", [Auf S. 269 sitzen die Schrägkugellager 43/44 an der #strong[Antriebswelle] (16), auf S. 272 heißt es in einer Frage „Schrägkugellager der Abtriebswelle“. Richtig ist die Antriebswelle; S. 272 ist ein Schreibfehler. Außerdem sind laut Buch die Bezeichnungen 43/44 in Bild 14-1 und 14-2 vertauscht (S. 272).])

- #strong[Lücken in den Positionsnummern] heißen nicht, dass Teile fehlen. Sie sind historisch (geänderte Teile) oder #strong[bewusst freigelassen] für spätere Ergänzungen; das ist wahrscheinlicher (S. 276–277).
- #strong[Nummerierungsschema]: weitgehend von #strong[außen nach innen]: Gehäuse (1) und gehäuseartige Teile (3, 9, 10, 11), dann Zahnräder und Welle, dann Normteile (S. 277).
- #strong[Einheit] in der Stückliste ist nicht immer „Stück“: z. B. Ölfüllung in Litern oder kg. Zulässig sind die SI-Einheiten nach DIN 1301-1 (S. 277).

Hinweis zu Explosionszeichnungen (Fußnote S. 272): Sie unterliegen nicht der strengen Zeichnungsnormung und werden oft als 3D-Darstellung ausgeführt.

#src[B S. 272–274, 277; L-alt E1, überarbeitet.]
#hoch(<a-13>, [Kapitelübersicht])


== 13.4 Montage mit Unterbaugruppen <a-13-4>

#bild("b-explosion", [Bild 14-3: Explosionszeichnung und Montagefolge. B, S. 273 (PDF-S. 284).], height: 134mm)

Sinnvoll sind zwei #strong[Unterbaugruppen], die getrennt vormontiert und dann ins Gehäuse eingebaut werden (S. 274–275):

#tab(columns: (1fr, 1fr),
 th([Unterbaugruppe Antriebswelle (S. 276)], [Unterbaugruppe Abtriebswelle (S. 281–282)]),
 [Schrägkugellager #strong[43] bis zum Ritzel auf die Ritzelwelle #strong[16] schieben
Distanzring #strong[21]
Lagerhalter #strong[9] (mit O-Ringen 77, 78 bereits eingesetzt)
zweites Schrägkugellager #strong[44]
mit Sicherungsblech #strong[53] und Nutmutter #strong[52] verspannen
Flanschlager #strong[3] aufschieben], [links: Passfeder #strong[68] einlegen, Tellerrad #strong[15] aufschieben, darauf Rillenkugellager #strong[45]
rechts: Lagerring #strong[10] aufschieben, darauf Rillenkugellager #strong[45]
Unterbaugruppe ins Gehäuse #strong[1] schieben
danach die Unterbaugruppe Antriebswelle montieren],
)

#note("Was verspannt die Nutmutter 52? (S. 276)", [Sicherungsblech (53), Innenring Schrägkugellager, Distanzring (21) und Innenring des anderen Schrägkugellagers, der sich an einer #strong[Schulter der Ritzelwelle] (16) abstützt. Das ist genau das spielfreie Verspannen aus Kapitel 9.])

#src[B S. 274–276, 281–282; L-alt E1, überarbeitet.]
#hoch(<a-13>, [Kapitelübersicht])


== 13.5 Einzelteil Lagerhalter (Pos. 9) <a-13-5>

- Zeichnungsnummer #strong[00-1.1-9]; die letzte Ziffer entspricht der Positionsnummer und hilft beim Wiederfinden (S. 277).
- #strong[Berührt]: Gehäuse 1, Flanschlager 3, Schrägkugellager 43 und 44, O-Ringe 77 und 78. #strong[Nicht] die Zylinderschrauben 61, die durch Bohrungen gehen (S. 277).
- Zwei #strong[Gewindebohrungen M5] am Umfang sind #strong[Abdrückgewinde] für die Demontage; zwei Stück, damit der Lagerhalter nicht verkantet. Für den Zusammenbau spielen sie keine Rolle und erscheinen deshalb nicht in der Gesamtzeichnung (S. 279).

#tab(columns: (1fr, 1fr),
 th([Durchmesser], [Bedeutung (S. 279)]),
 [Ø34, Ø39], [ohne Toleranz → #strong[Allgemeintoleranz] aus dem Schriftfeld (dort noch „DIN 7168 mittel“, heute ISO 2768-m: #strong[±0,3 mm]). Vertretbar, weil keine Kontaktflächen.],
 [Ø40 H6], [Sitz für den #strong[Außenring] des Schrägkugellagers. Welle dreht, Gehäuse steht → #strong[Punktlast] am Außenring → #strong[Spielpassung] zulässig (vgl. Kapitel 10).],
 [Ø50 j6, Ø55 j6], [#strong[Übergangspassung] (mit H7 ein von Hand montierbares Schiebesitzteil). Diese Flächen #strong[zentrieren] Lagerhalter und Flanschlager; gegen Verdrehen sichern die Zylinderschrauben.],
 [Ø74 −0,1/−0,2], [Außenmaß mit zwei negativen Abmaßen: soll vermutlich einen #strong[Überstand über das Flanschlager] verhindern.],
)

#note("Beispiel: Dicke des nicht bemaßten Schraubenflanschs (S. 281)", [Maße 19,5 (gesamt), 5 (eine Seite), 9,5 (andere Seite), alle mit ISO 2768-m:
19,5 ± 0,2     5 ± 0,1     9,5 ± 0,2

Dicke = 19,5 − 5 − 9,5 = 5 mm (Nennmaß)
min   = (19,5 − 0,2) − (5 + 0,1) − (9,5 + 0,2) = 4,5 mm
max   = (19,5 + 0,2) − (5 − 0,1) − (9,5 − 0,2) = 5,5 mm])

#note("Merke: Maßkette", [Das #strong[Kleinstmaß] des Restmaßes entsteht, wenn das Gesamtmaß am kleinsten und alle abgezogenen Maße am größten sind; beim #strong[Größtmaß] umgekehrt. Die Toleranzen addieren sich: 0,4 + 0,2 + 0,4 = 1,0 mm (abgeleitet aus S. 281).])

#src[B S. 277–281; L-alt E1, überarbeitet.]
#hoch(<a-13>, [Kapitelübersicht])


== 13.6 Einzelteil Abtriebswelle (Pos. 20) <a-13-6>

- #strong[Berührt] (von links nach rechts): Passfeder 69, RWDR 59, Passfeder 68, Tellerrad 15, Lagerring 10, RWDR 59, Passfeder 69 (S. 281).
- Tellerrad 15 und Lagerring 10 sitzen als Hülsen auf #strong[Ø18 k6]. Die Wälzlager 45 sitzen auf diesen Hülsen, nicht direkt auf der Welle (S. 281–282).
- Warum hat nur das Tellerrad eine #strong[Passfeder]? B S. 282 beschreibt H7/k6 als Haftsitz und begründet damit die zusätzliche Passfeder am Tellerrad. Präzisierung: Eine Übergangspassung kann auch Spiel ergeben und garantiert keine bestimmte Drehmomentkapazität. Die Passfeder stellt hier die formschlüssige Drehmomentübertragung sicher (S. 282).

#note("Beispiel: Ø18 H7/k6 nachrechnen (eigene Ergänzung, Abmaße aus Tab. 7-3, S. 142)", [Bohrung H7 (über 10 bis 18):  ES = +18 µm   EI = 0
Welle   k6 (über 10 bis 18):  es = +12 µm   ei = +1 µm
PSO = ES − ei = 18 − 1  = +17 µm  (größtes Spiel)
PÜO = EI − es = 0 − 12  = −12 µm  (größtes Übermaß)   -\>  Übergangspassung])

#src[B S. 280–282; L-alt E1, überarbeitet.]
#hoch(<a-13>, [Kapitelübersicht])


== 13.7 Repetitorium: Einzelteilzeichnung Flanschlager (Pos. 3) <a-13-7>

#bild("b-flanschlager", [Bild 15-7: Vollständige Einzelteilzeichnung des Flanschlagers. B, S. 290 (PDF-S. 301).], height: 142mm)

Buchkapitel 15 wiederholt das ganze Buch an einem Teil. Gehe die Schritte in dieser Reihenfolge durch; jeder Schritt verweist auf einen Teil dieses Skripts.

#tab(columns: (1fr, 1fr),
 th([Schritt], [Entscheidung beim Flanschlager]),
 [#strong[Ansichten] (S. 284, Teil B)], [So wenige wie möglich, so viele wie nötig: #strong[zwei]. Vorderansicht als #strong[Vollschnitt] (alle Innenformen), Draufsicht für Anzahl, Art und Lage der Bohrungen. Senkbohrung und Gewindebohrung liegen nicht in einer Ebene, erscheinen aber durch #strong[aufgeklappte Schnittebenen] beide im Schnitt. Eine Untersicht wäre ungünstig, weil dann der Senkdurchmesser nur verdeckt (Strichlinie) zu sehen wäre. Im Querformat: Vorder- und Seitenansicht, besser für Drehteile.],
 [#strong[Bemaßung] (S. 284–285, Kapitel 2)], [Längen ohne Zusatz, Durchmesser mit Ø, Radien mit R; Einheit mm wird nicht geschrieben (DIN EN ISO 129-1). Lesbar #strong[von unten und von rechts]. #strong[Kein Maß doppelt]; ein Hilfsmaß steht in Klammern. Schnittverlauf muss hier nicht beschriftet werden, weil eindeutig.],
 [#strong[Oberflächen] (S. 285–286, Kapitel 5)], [Nach Funktion: #strong[Rz 63] für alle funktionslosen Flächen (sichtbar, daher nicht gröber), #strong[Rz 16] für die O-Ring-Dichtfläche und die Auflage der Schraubenköpfe, #strong[Rz 10] für Lagersitz, RWDR-Sitz, Zentrierung und ein Außenmaß. Der Lagersitz wird nur dort fein bearbeitet, wo das Lager wirklich sitzt. Kennbuchstaben-Tabelle im Schriftfeld, Kanten als Text „Kanten gebrochen“ statt ISO 13715.],
 [#strong[Passungen] (S. 287–288, Kapitel 6)], [#strong[Ø24 H8] RWDR-Sitz (passt zur Regel H8 aus Kapitel 11), #strong[Ø40 H6] Wälzlagersitz, #strong[Ø50 H7] Zentrierung, #strong[Ø74 j7] Außenmaß. Toleranzgrade 6 bis 8, also mittlerer Bereich. Eine #strong[Passmaßtabelle] mit allen Abmaßen dockt am Schriftfeld an.],
 [#strong[Form und Lage] (S. 288, Kapitel 6)], [Nur #strong[Lauftoleranzen]: Bezug ist die Sitzfläche des Wälzlagers (Bezugsdreieck). Zentrierung, Dichtsitz und Außenfläche erhalten #strong[Rundlauf] (gekrümmte Flächen) bzw. #strong[Planlauf] (plane Flächen), vereinfacht mit einer Angabe für alle drei.],
 [#strong[Allgemeintoleranzen] (S. 288)], [„mittel“ nach ISO 2768, gilt für Maße sowie Form und Lage; normgerecht kurz: #strong[ISO 2768-mK].],
 [#strong[Sonstige Abmaße] (S. 288)], [#strong[Ø52 −0,5] (statt ±0,3: mehr Toleranz; Außenmaß, also kein Plusabmaß nötig) und #strong[3,5 +0,2] (statt ±0,1; Innenmaß, also kein Minusabmaß nötig).],
 [#strong[Schriftfeld] (S. 289, Kapitel 1)], [Benennung (Flanschlager), Maßstab 1:1, Zeichnungsnummer 00-1.1-3-I, Werkstoff EN-GJL-250, Bearbeiter und Datum, Prüfer und Freigabe, Eigentümer, Blattanzahl. Zusätzlich: Projektionsmethode 1, Normhinweise (DIN ISO 1302 → heute DIN EN ISO 21920-1; ISO 2768 Teil 2 → DIN EN ISO 22081), Rohteil, Änderungsverlauf.],
)

#note("Achtung: Oberfläche und Toleranz gehören zusammen", [Eine feine Oberfläche ist nur sinnvoll, wenn auch das Maß eng toleriert ist, und umgekehrt (S. 287). In der Klausur also nie eine Passfläche mit grober Rauheit oder eine funktionslose Fläche mit IT6 versehen.], fill: sand)

#src[B S. 283–290; L-alt E1, überarbeitet.]

#bild("map-kapitel-13", [Mindmap zu Kapitel 13. Eigene Darstellung nach B S. 269–290.], height: 46mm)

*Der Zusammenhang in Kapitel 13.* Zuerst wird die Baugruppe über Kraft-, Lager- und Montageweg verstanden. Danach wird das einzelne Teil mit passenden Ansichten und funktionsgerechten Anforderungen so beschrieben, dass Fertigung und Prüfung es eindeutig lesen können.
#src[B S. 269–290; eigene Zusammenfassung.]
#hoch(<a-13>, [Kapitelübersicht])


= Anhang
== Formelsammlung mit Voraussetzungen
Die Beziehungen beziehen sich auf die beschriebenen Zeichen- und Rechenmodelle. Vor jedem Einsetzen Normfassung, Bezugsstrecke und Einheiten prüfen.

#tab(columns: (1fr, 1fr, 1fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 table.cell(colspan: 3, rowspan: 1)[Grundlagen (Kapitel 1, B1)],
 [Blattformat A0], [$ x   dot  y  = 1 thin "m" ^(2) , quad  y  = sqrt(2)  thin x $], [x ≈ 841 mm, y ≈ 1189 mm; jedes nächste Format = Hälfte],
 [Fläche An], [$ A _("An")  = 1 thin "m" ^(2)  / 2^(n) $], [A4 = 1/16 m²],
 [Maßstab], [$ M  = l _(Z)  / l _(W) $], [1 : 2 = Verkleinerung, 2 : 1 = Vergrößerung; Maßzahl immer wirkliche Länge],
 table.cell(colspan: 3, rowspan: 1)[Oberflächen (Kapitel 5, S. 109–111)],
 [Rautiefe], [$ R _(z)  = R _(p)  + R _(v) $], [höchste Spitze + tiefstes Tal in einer Einzelmessstrecke],
 [Mittenrauwert], [$ R _(a)  = frac(1, l)  integral _(0) ^(l)  |y (x )| thin "d" x $], [Rechteck gleicher Fläche; unempfindlich gegen Ausreißer],
 [Rillenbreite], [$ R _("Sm")  = frac(1, m)  sum  X _(s ,i) $], [mittlere Breite der Profilelemente],
 table.cell(colspan: 3, rowspan: 1)[Toleranzen und Passungen (Kapitel 6, S. 136, 155)],
 [Abmaße], [$ "ES"  = G _(o)  - N , quad  "EI"  = G _(u)  - N $], [Bohrung groß (ES, EI), Welle klein (es, ei)],
 [Maßtoleranz], [$ T  = G _(o)  - G _(u)  = "ES"  - "EI" $], [immer positiv],
 [Höchstpassung], [$ P _(O)  = "ES"  - "ei" $], [positiv = Spiel],
 [Mindestpassung], [$ P _(U)  = "EI"  - "es" $], [negativ = Übermaß],
 [Passtoleranz], [$ P _(T)  = P _(O)  - P _(U)  = T _(I)  + T _(A) $], [Spiel: P#sub[U] ≥ 0; Übermaß: P#sub[O] ≤ 0; sonst Übergang],
 [Maßkette (Restmaß)], [min = Gesamt#sub[min] − Σ Teilmaße#sub[max]], [Toleranzen addieren sich (Kapitel 13, S. 281)],
 table.cell(colspan: 3, rowspan: 1)[Gewinde (Kapitel 7, S. 174–178, 193)],
 [Flankendurchmesser], [$ d _(2)  = d  - 0","64953 thin P $], [M16: P = 2 mm],
 [Kerndurchmesser], [$ d _(3)  = d  - 1","22687 thin P , quad  D _(1)  = d  - 1","08253 thin P $], [d#sub[3] Bolzen, D#sub[1] Mutter],
 [Gangzahl], [$ n  = P _(h)  / P $], [Tr40×14 P7 → n = 2],
 [Festigkeitsklasse x.y], [$ R _(m)  = x   dot  100, quad  R _("p0,2")  = frac(y,10) dot R_(m) $], [in N/mm²; 8.8 → 800 / 640 (Regel abgeleitet)],
 [Gewindeauslauf], [x ≈ 2,5 · P], [M16: x = 5 mm (Tabellenwert)],
 table.cell(colspan: 3, rowspan: 1)[Wellen, Sicherungen, Lager (Kapitel 8–D4)],
 [Nuttiefe Sicherungsring], [$ t  = (d _(1)  - d _(2) )/2 $], [d#sub[2] = Nutgrund],
 [Axialspiel Sicherungsring], [Spiel#sub[max] = m#sub[max] − s#sub[min]], [Spiel#sub[min] = m#sub[min] − s#sub[max]],
 [Lagerquerschnitt], [$ H  = (D  - d )/2 $], [D#sub[W] ≈ H/2, H#sub[R] ≈ H/3, R ≈ H/9 (S. 235)],
 [Lagerbohrung], [d = Bohrungskennzahl · 5], [ab Kennzahl 04; 00/01/02/03 = 10/12/15/17 mm (Ergänzung)],
 table.cell(colspan: 3, rowspan: 1)[Zahnräder (Kapitel 12, S. 260–261)],
 [Modul], [$ m  = d  / z $], [beide Räder gleicher Modul; DIN 780 Reihe I bevorzugt],
 [Kopf- / Fußhöhe], [$ h _(a)  = m , quad  h _(f)  = m  + c $], [c = Kopfspiel (Bruchteil von m)],
 [Kopf- / Fußkreis], [$ d _(a)  = m (z +2), quad  d _(f)  = d  - 2h _(f) $], [abgeleitet],
 [Teilung], [$ p  =  pi   dot  m $], [abgeleitet],
 [Achsabstand, Übersetzung], [$ a  = (d _(1)  + d _(2) )/2, quad  i  = z _(2) /z _(1) $], [Ergänzung],
)

#note("Wichtige Zahlen", [1 mm = 1000 µm. A4: 210 × 297 mm; A3: 297 × 420 mm. Bei Projektionsmethode 1 liegt die Draufsicht unten, die Seitenansicht von links rechts. H: EI = 0; h: es = 0. Zahlen aus Normtabellen immer mit Nennmaßbereich und Tabelle lesen; nicht außerhalb ihres Bereichs übertragen.])
#src[B S. 6, 43–46, 136, 139–142; weitere Quellen der Formeln in den zugehörigen Kapiteln. Die ergänzten Zahnradbeziehungen gelten für ein unverschobenes außenverzahntes geradverzahntes Paar; Einschraub- und Lagerproportionen sind Zeichenrichtwerte.]
