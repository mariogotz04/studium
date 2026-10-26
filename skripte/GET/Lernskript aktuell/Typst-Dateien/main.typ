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
  #text(size: 8pt, fill: muted)[Feynman-Lernskript · Stand 26.10.2026]
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

#let abbildungen = (
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
#text(size: 12pt, fill: teal)[Ladung → Strom → Quelle → Grundstromkreis]
]

#note("Dein Feynman-Schritt", [Sieh dir die Abbildung an. Erkläre dann ohne Vorlage: *Was passiert? Warum? Wann gilt die Formel?* Erst anschließend vergleichst du deine Erklärung mit dem Text und den Formeln.])

Stand 26.10.2026: Enthalten sind Skript Kapitel 1.1 bis 1.2.5, deine Randnotizen zu Spule und Diode sowie der Grundstromkreis aus der Zusammenfassung (Skript 2.4.1 bis 2.4.3). Die neuen Markierungen belegen den 15.10. auf Skript S. 16–17 und den 22.10. auf S. 18–19; die Nummern dieser Vorlesungen sind offen. Das Skript enthält nur noch die Erklärungen und im Anhang die Formelsammlung. Alle Rechenaufgaben und Verständnisfragen mit Lösungen Schritt für Schritt stehen auf der Lernwebseite im Reiter „Lernen“, das Quiz ebenfalls dort.

#pagebreak()
#heading(level: 1, outlined: false)[Wegweiser]
#block[
#set text(size: 9.5pt)
#set par(leading: 0.3em, spacing: 0.15em)
#outline(title: none, depth: 2, indent: auto)
]
#v(2mm)
#text(size: 8.5pt, fill: muted)[*Quellenkürzel:* V = Vorlesungsskript Kölbl, „Grundlagen der Elektrotechnik“ (aufgedruckte Seite = PDF-Seite); M = Mitschrift „eigenes Skript Elektrotechnik“; B = BAF-Mitschrift VL 1–3 (S. 1 = VL 1, S. 2 = VL 2, S. 3 = VL 3); Z = handschriftliche Zusammenfassung VL 3; FK = Fragenkatalog „Einstieg GET auf Schulniveau“ (Fragennummer); Ü = Übung GET (Aufgabe); A, B = Übungsblatt A bzw. B (Aufgabe); R = handschriftliche Lösungen zu Blatt A und B („Prüfungsvorbereitungsfragen.pdf“). N = „neue VL GET.pdf“ mit Notizen vom 15./22.10. (PDF-S. 1–6 entsprechen V S. 14–19); FK-N = Fragenkatalog mit Lösungen bis 22.10.; Ü-N = „ÜBUNG GET (mit Mitschrift zu Aufgabe 1)“; DC = „ÜBUNGEN_GET_DC_URI_Basics_202610161827_42497“ mit Rechenwegen zu Ü 1–3. „S.“ bei Mitschriften zählt ab der ersten PDF-Seite. Externe Fachprüfungen sind mit Anbieter und Link direkt am Abschnitt genannt. „Eigene Ergänzung“ bezeichnet zusätzliche Erklärhilfen und Beispiele.]

#pagebreak()
= Kapitel 0 · Vorwissen: Strom, Spannung, Widerstand, Leistung

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
#src([FK 7, 13–17; M S. 1; B S. 1 (VL 1); V S. 9; Ü 7. Ohmsches Gesetz ausführlich erst in V Kap. 1.4 (noch nicht behandelt).])

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
#src([FK 20–25; Schulwissen, eigene Ergänzung. Im Skript folgen Reihen- und Parallelschaltung ausführlich in V Kap. 2.4.4–2.4.5 (noch nicht behandelt).])

== 0.5 Ideale und reale Spannungsquelle (Vorschau) <a-0-5>
Eine ideale Quelle liefert immer dieselbe Spannung, egal wie viel Strom fließt. Eine reale Quelle hat zusätzlich einen *Innenwiderstand* $R_i$ in Reihe. Je mehr Strom fließt, desto mehr Spannung bleibt innen hängen, die Klemmenspannung sinkt:
#form[$ U_"Klemme" = U_q - I dot.c R_i $]
*Beispiel (FK 27):* Mignonzelle, $U_q = "1,52" thin "V"$, $R_i = "0,13" thin Omega$, $I = 40 thin "mA"$: $U = "1,52" - "0,04" dot.c "0,13" approx "1,515" thin "V"$. Ausführlich in Abschnitt 2.4.1.
#src([FK 26–30; V S. 42.])

== 0.6 Ergänzung vom 22.10.: Spannungsteiler und Quellen <a-0-6>
Ein *unbelasteter Spannungsteiler* ist eine Reihenschaltung mit offenem Ausgang: Du greifst eine Spannung ab, ohne dort Strom zu entnehmen. Wie bei zwei Engstellen hintereinander verteilt sich der gesamte Spannungsabfall auf beide Widerstände.
#note("Von dir markiert", [Im neuen Fragenkatalog steht: „Aufgabe 25 bis 28 am 22.10 gemacht“. Die Spannungsteilerregel ist in deiner Lösung eingerahmt. Die Fragen zum Magnetfeld greifen wir bei der Induktion und in den Aufgaben auf der Lernwebseite auf.])
#bild("notiz-spannungsteiler", [Spannungsteiler mit deinem Rechenweg. FK-N, PDF-S. 6, Aufgabe 25, Ausschnitt.], height: 48mm)
#form[$ I = U/(R_1 + R_2) quad U_20 = I R_2 = U R_2/(R_1 + R_2) $]
$U$: Gesamtspannung in V; $R_1$, $R_2$: Widerstände in Ω; $U_20$: Ausgangsspannung an $R_2$ im Leerlauf. *Voraussetzung:* kein Laststrom am Ausgang; ein ideales Voltmeter verändert die Schaltung nicht.

*FK 25:* $I = 35 thin "V"/(115 thin "k"Omega) approx "0,30435" thin "mA"$. Damit ist $U_20 = 35 thin "V" dot.c 100/115 approx "30,43" thin "V"$. Runde möglichst erst das Ergebnis, damit sich Rundungsfehler nicht fortsetzen.
#note("Fehler vermeiden", [Ein angeschlossener Verbraucher liegt parallel zu $R_2$. Dann ist der untere Widerstand durch den Parallelersatz zu ersetzen; die unbelastete Formel mit unverändertem $R_2$ gilt nicht mehr. Das ist die Bedeutung deiner Randnotiz neben den Ausgangsklemmen.], fill: sand)

*FK 26–27:* Bei einer idealen Quelle entfällt der Innenwiderstand. Bei einer realen Quelle fällt unter Last innen $U_i = I R_i$ ab: Mit $U_q = "1,52" thin "V"$, $R_i = "0,13" thin Omega$ und $I = "0,04" thin "A"$ erhältst du $U_i = "0,0052" thin "V"$ und *$U_"Klemme" = "1,5148" thin "V"$*. Das ist die genauer gerechnete Version des Beispiels in Abschnitt 0.5.
#note("Selbst erklären", [Warum darfst du die Spannungsteilerregel nicht ohne Prüfung für einen belasteten Ausgang verwenden? \ *Antwort:* Der Laststrom fließt zusätzlich durch $R_1$; $R_1$ und $R_2$ führen dann nicht mehr denselben Strom. Erst den Parallelersatz unten bilden, dann die Regel anwenden.])
#src([FK-N, PDF-S. 6, Aufgaben 25–27 samt handschriftlichen Lösungen; Abschnitt 0.4 und V S. 42 für die Schaltungsregeln. Rechenwege ergänzt und ohne frühes Runden geprüft.])

*Der Zusammenhang in Kapitel 0.* Die Spannung ist die Ursache, der Strom die Folge, der Widerstand bestimmt, wie viel Strom die Spannung antreibt. Die Leistung verknüpft Spannung und Strom zu dem, was am Verbraucher ankommt, und über die Zeit zur Energie, die bezahlt wird. In Schaltungen entscheidet die Schaltungsart, welche Größe überall gleich ist.

= Kapitel 1 · Grundbegriffe: Strom und Quellspannung

Wir bauen ein Bild davon auf, was im Draht passiert, wenn Strom fließt: wie viel Ladung darin steckt, wie schnell sie wandert, wie sie sich auf den Querschnitt verteilt und woran man sie erkennt. Danach klären wir, woher der Antrieb kommt: Eine Quelle trennt Ladungen, chemisch, durch Induktion, eine Temperaturdifferenz, Licht oder eine mechanische Einwirkung. Grundlage ist Skript Kapitel 1.1 bis 1.2.5; hinzu kommen die Randnotizen vom 15. und 22.10.

#bild("map-strom", [Mindmap: Vier Blicke auf den elektrischen Strom. Eigene Darstellung.], height: 44mm)

== 1.1.1 Die elektrische Ladung <a-1-1-1>
Stell dir einen Draht als Rohr vor, das randvoll mit frei beweglichen Elektronen ist. Wie viel *Ladung* darin steckt, hängt davon ab, wie dicht die Elektronen gepackt sind ($n$), wie viel Ladung jedes trägt ($e$) und wie groß das Drahtstück ist ($V = A l$).
#bild("skript-ladung", [Ladungen im elektrischen Leiter. V S. 5, Abb. 1.1.], height: 34mm)
#form[$ Q = n dot.c e dot.c V = n dot.c e dot.c A dot.c l $]
$n$: Ladungsträgerdichte, Kupfer $n_"Cu" approx "8,44" dot.c 10^22 thin "cm"^(-3)$; $e$: Elementarladung, $e = "1,602176634" dot.c 10^(-19) thin "As"$, die kleinste in der Natur vorkommende Ladung und eine Naturkonstante (in deinen Vorlesungsseiten gerundet zu $"1,6" dot.c 10^(-19) thin "As"$); $A$, $l$: Querschnitt und Länge des Leiterstücks; $[Q] = 1 thin "Coulomb" = 1 thin "As"$.

Ein Elektron trägt $-e$, ein Proton $+e$. Ladung ist immer an einen Träger und damit an Masse gebunden. Sie hat *Mengencharakter*: Man kann sie zählen wie Wasser in Litern.
#src([V S. 5–6; M S. 1.])

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

== 1.1.3 Driftgeschwindigkeit und Stromleitung im Festkörper <a-1-1-3>
Setzt man in $I = n e l A\/t$ für $l\/t$ eine Geschwindigkeit ein, erhält man, wie schnell die Elektronen im Mittel wandern, die *Driftgeschwindigkeit*:
#form[$ I = n dot.c e dot.c v_d dot.c A quad => quad v_d = l/t = I/(n dot.c e dot.c A) $]
*Beispiel (V S. 8):* Kupferdraht, $A = 1 thin "mm"^2 = "0,01" thin "cm"^2$, $I = 16 thin "A"$:
$ v_d = (16 thin "A")/("8,44" dot.c 10^22 thin "cm"^(-3) dot.c "1,6" dot.c 10^(-19) thin "As" dot.c "0,01" thin "cm"^2) approx "0,12" thin "cm/s" = "1,2" thin "mm/s" $
Das ist Schneckentempo; das Berechnungsblatt in V S. 9 vergleicht ausdrücklich mit einer Schnecke (etwa 4,2 m/h = 1,2 mm/s). Dort steht auch ein zweites Zahlenbeispiel: 50 m Kupferleitung mit 1,5 mm² an 12 V, $I approx "16,66" thin "A"$, $v_d approx "0,82" thin "mm/s"$.
#bild("skript-impuls", [Der Impuls der Elektronen breitet sich rascher aus, als sie sich fortbewegen. V S. 8, Abb. 1.4.], height: 24mm)
#note("Selbst erklären", [Die Elektronen driften nur mit mm/s. Warum leuchtet die Lampe trotzdem sofort? \ *Antwort:* Das elektrische Feld breitet sich fast mit Lichtgeschwindigkeit aus. Alle Elektronen im Kreis beginnen praktisch gleichzeitig zu driften; kein Elektron muss vom Schalter zur Lampe laufen (V S. 8; M S. 1).])
#note("In eigenen Worten", [_Eigene Ergänzung:_ Ein Gartenschlauch, der schon voll Wasser ist: Drehst du den Hahn auf, kommt vorne sofort Wasser heraus, obwohl das Wasser vom Hahn noch lange nicht vorne ist.])
#note("Widerspruch in den Unterlagen", [V S. 8 nennt für den 1-mm²-Draht „dauernd 16 A zugelassen“, also 16 A/mm². V S. 10 nennt als zulässige Stromdichte aber nur $S_"zul" = 1 dots 6 thin "A/mm"^2$. Rechne das Beispiel so, wie es dasteht; für die Frage „zulässig?“ gilt S. 10. Am besten in der Vorlesung nachfragen.], fill: sand)
#note("Fehler vermeiden", [Einheiten konsequent einsetzen: $n$ ist in cm⁻³ gegeben, also $A$ in cm² umrechnen ($1 thin "mm"^2 = "0,01" thin "cm"^2$).], fill: sand)
#src([V S. 8–9 (Kap. 1.1.3 und 1.1.4 mit Berechnungsblatt Abb. 1.5); M S. 1.])

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

== 1.1.7 Stromarten <a-1-1-7>
#bild("stromarten", [Gleichstrom und sinusförmiger Wechselstrom. Eigene Darstellung nach V S. 13, Abb. 1.9.], height: 36mm)
- *Gleichstrom* (DC, Direct Current): $i(t) = I = "konst."$ (Batterie, Akku).
- *Sinusförmiger Wechselstrom* (AC, Alternating Current): Die Richtung wechselt periodisch. Netz: $f = 50 thin "Hz" => T = 1\/f = 20 thin "ms"$. Effektivwert $I_"eff" = hat(i)\/sqrt(2)$ (V S. 13; M S. 2).
- *Nichtsinusförmiger Wechselstrom*: beliebige periodische Form mit der Periodendauer $T$; wird per Fourieranalyse in Sinusanteile zerlegt.
#note("In eigenen Worten", [_Eigene Ergänzung:_ Der Effektivwert ist der Gleichstromwert, der in einem Widerstand dieselbe Wärme erzeugt. Die 230 V der Steckdose sind ein Effektivwert; der Scheitelwert ist $hat(u) = 230 thin "V" dot.c sqrt(2) approx 325 thin "V"$. Deine Mitschrift notiert dazu $u_"eff" = hat(u)\/sqrt(2)$ beim Hausnetz (B S. 2).])
#src([V S. 13; M S. 2; B S. 2 (VL 2).])

== 1.1.7.1 Qualitative Fragestellung: drei Lampen und ein Schalter <a-1-1-7-1>
Drei identische Glühlampen liegen in Reihe an einer Batterie, der Schalter S liegt parallel zu Lampe C. Was passiert, wenn S geschlossen wird?
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

== 1.2.3 Thermoeffekt · ergänzt aus der VL vom 15.10. <a-1-2-3>
Zwei unterschiedliche Metalle können eine Temperaturdifferenz in eine elektrische Spannung übersetzen. Das ist der *Seebeck-Effekt*: Ein *Thermoelement* aus Kupfer und Konstantan vergleicht die Temperatur seiner Messstelle mit der Temperatur der Vergleichsstelle an den Anschlüssen.
#bild("skript-thermo", [Thermoelement aus Kupfer und Konstantan. N, PDF-S. 4 = V S. 17, Abb. 1.13.], height: 42mm)
#form[$ U_q approx K dot.c Delta vartheta quad Delta vartheta = vartheta_1 - vartheta_2 quad K = "0,05" thin "mV/K" quad "(Cu–Konstantan, Skriptwert)" $]
$U_q$: Thermospannung in mV; $K$: näherungsweise konstanter Thermokoeffizient; $Delta vartheta$: Temperaturdifferenz in K. Die Zahlenwerte einer Differenz sind in K und °C gleich. *Gültigkeit:* lineare Näherung mit dem angegebenen Koeffizienten; Materialpaar, Temperaturbereich und Polung beachten. $K$ ist hier der Koeffizient, nicht die Einheit Kelvin.

*Beispiel, eigene Ergänzung:* Messstelle 80 °C, Vergleichsstelle 20 °C: $Delta vartheta = 60 thin "K"$, also $U_q approx "0,05" thin "mV/K" dot.c 60 thin "K" = 3 thin "mV"$. Werden beide Stellen gleich warm, ist die Spannung null; vertauscht man die Temperaturen, kehrt sich ihre Polung um.
#note("Gültigkeit und Skriptangabe", [V S. 17 nennt einen Temperaturbereich „bis 1000 °C“. Das darfst du nicht pauschal auf Cu–Konstantan übertragen: Herstellerangaben für Typ T reichen bis etwa 400 °C, abhängig von der Ausführung. Auch der konstante Skriptwert 0,05 mV/K ist eine Rechennäherung. Für unsere Aufgaben verwenden wir den angegebenen Wert; eine reale Messung braucht die passende Kennlinie.], fill: sand)
#note("Selbst erklären", [Warum reicht „Die Messstelle hat 80 °C“ noch nicht für die Spannung? \ *Antwort:* Es fehlt die Temperatur der Vergleichsstelle. Dieselbe Messstelle liefert bei unterschiedlich warmen Anschlüssen unterschiedliche Spannungen.])
#src([N, PDF-S. 4 = V S. 17, Abschnitt 1.2.3; Beispiel und Erklärung der Vergleichsstelle ergänzt. Fachprüfung des Temperaturbereichs: #link("https://www.emerson.com/en/measurement-instrumentation/catalog/temperature-measurement/temperature-sensors/type-t-thermocouple")[Emerson, Type T Thermocouple].])

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
#note("Selbst erklären", [Wie kann derselbe Effekt Sensor und Antrieb sein? \ *Antwort:* Als Sensor liefert eine mechanische Einwirkung ein elektrisches Signal. Beim umgekehrten Effekt erzeugt eine angelegte Spannung eine mechanische Verformung.])
#src([N, PDF-S. 6 = V S. 19, Abschnitt 1.2.5 und Abb. 1.15–1.16; Erklärung der Frequenzteilung ergänzt.])

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

*Der Zusammenhang in Kapitel 1.* Strom beschreibt bewegte Ladung. Die Elektronen driften langsam; das elektrische Feld vermittelt die Wirkung rasch. Stromdichte und Material bestimmen die Erwärmung, Wärme-, Kraft- und chemische Wirkung machen Strom erkennbar. Quellen trennen Ladungen durch Chemie, Flussänderung, Temperaturdifferenz, Licht oder Kraft. Die Randnotizen verbinden diese Grundlagen mit der verzögerten Stromänderung einer Spule und dem Arbeitspunkt einer Diode.

= Kapitel 2 · Der Grundstromkreis

Im Skript gehört der Grundstromkreis zu Kapitel 2 „Die Kirchhoffschen Gesetze“ (Abschnitt 2.4.1 bis 2.4.3). In der Vorlesung 3 kam er vorab dran, deine Zusammenfassung rechnet ihn vollständig durch. Die Strategie: Eine reale Quelle wird als ideale Quelle mit Innenwiderstand modelliert. Daraus folgen Strom, Klemmenspannung, Arbeitspunkt, Leistung und Wirkungsgrad. Die übrigen Abschnitte von Kapitel 2 folgen, sobald sie behandelt sind.

== 2.4.1 Der Grundstromkreis: reale Quelle mit Verbraucher <a-2-4-1>
*Experiment (V S. 42):* Schließt man einen Akku kurz, müsste bei einer idealen Quelle ein unendlich hoher Kurzschlussstrom fließen: $I_k = U_q\/R$ mit $R = 0$ ergäbe $I_k -> oo$. Tatsächlich ist $I_k$ endlich (z. B. 200 A). In der Quelle muss also ein Widerstand stecken, der den Strom begrenzt: der *Innenwiderstand* $R_i$. Deine Mitschrift: „Innenwiderstand ist wichtig“ (B S. 1).
#grid(columns: (1fr, 1fr), gutter: 5mm,
 [#bild("skript-grundstromkreis", [Grundstromkreis mit Generator und Verbraucher. V S. 42, Abb. 2.3.], height: 34mm)],
 [#bild("grundstromkreis", [Dasselbe Ersatzschaltbild; gestrichelt die reale Quelle. Eigene Darstellung.], height: 34mm)],
)
Spannungspfeile weisen vom höheren zum niedrigeren Potenzial. Im Verbraucher fließt der Strom von + nach −; Strom- und Spannungspfeil zeigen dort in dieselbe Richtung (*Verbraucherzählpfeilsystem*). Der Umlauf um die Masche ergibt:
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

=== Kennlinien und Arbeitspunkt <a-2-4-1-k>
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

== 2.4.2 Aufgabe zum Grundstromkreis <a-2-4-2>
*V S. 43 und Ü 3:* Ein Heizwiderstand von 31,2 Ω wird ans Netz gelegt. Die Netzspannung beträgt im Leerlauf 230 V, im Einschaltmoment sinkt die Klemmenspannung auf 218 V. Wie groß ist der Innenwiderstand des Netzes?
+ Ersatzschaltbild: Grundstromkreis aus Abschnitt 2.4.1 mit $U_q = 230 thin "V"$ und $R_a = "31,2" thin Omega$.
+ Strom aus der Last: $I = U_a\/R_a = 218\/"31,2" approx "6,99" thin "A"$
+ Spannung, die innen abfällt: $U_i = 230 - 218 = 12 thin "V"$
+ $R_i = U_i\/I = 12\/"6,99" approx "1,7" thin Omega$, wie auf dem Übungsblatt.
#note("In eigenen Worten", [Die Differenz zwischen Leerlauf- und Klemmenspannung fällt immer an $R_i$ ab.])
#note("Deinen Rechenweg einordnen", [DC, PDF-S. 4, unterscheidet den Leerlauf ($I = 0$, kein innerer Spannungsabfall) und den Lastfall (12 V Spannungsabfall bei rund 7 A). Die dort notierten 135 A Kurzschlussstrom entstehen aus dem gerundeten $R_i = 1,7$ Ω; mit dem ungerundeten Wert sind es rund 134 A. Das ist eine Modellrechnung, kein zusätzlich gemessener Wert.])
#src([V S. 43; Ü 3; DC, PDF-S. 1 und 4.])

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

*Der Zusammenhang in Kapitel 2.* Das Modell „ideale Quelle plus Innenwiderstand“ erklärt, warum der Kurzschlussstrom endlich ist und die Klemmenspannung unter Last sinkt. Strom und Spannung lassen sich rechnerisch über den Maschenumlauf oder zeichnerisch über den Schnittpunkt zweier Kennlinien bestimmen. Die Leistungsbilanz zeigt, dass der Verbraucher bei $R_a = R_i$ am meisten bekommt, die Quelle dabei aber die Hälfte selbst verheizt.

= Anhang

== Formelsammlung mit Voraussetzungen
Zählpfeile im Verbraucherzählpfeilsystem; Strom in technischer Richtung (+ → −). Bei Drahtwiderständen $l$ in m und $A$ in mm².

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
 [Thermoeffekt], [$U_q approx K Delta vartheta$; $Delta vartheta = vartheta_1 - vartheta_2$], [Cu–Konstantan: Skriptwert $K = "0,05" thin "mV/K"$; lineare Näherung.],
 [Photonenergie], [$E_"Photon" = h nu = h c/lambda$], [Energie in J; $1 thin "eV" = "1,602176634" dot.c 10^(-19) thin "J"$.],
 [Bandlückenschwelle], [$nu_g = W/h$; $lambda_g = h c/W$], [Bandlücke $W$ in J; im einfachen Modell $h nu >= W$ bzw. $lambda <= lambda_g$.],
 [Fotostrom am Lastwiderstand], [$U = I_"Foto" R$], [Am tatsächlichen Arbeitspunkt; $I_"Foto"$ nicht bei beliebiger Last konstant annehmen.],
 [Quarztakt], [$f_"Takt" = f_"Quarz"/2^n$; $T = 1/f_"Takt"$], [Elektronische Frequenzteilung; 32768 Hz / $2^15$ = 1 Hz.],
 [R–L-Zeitkonstante], [$tau = L/R$; $I_oo = U_q/R$], [Lineares $L$ in H, gesamter Serienwiderstand $R$ in Ω; $tau$ in s.],
 [R–L-Einschalten], [$i(t) = I_oo (1 - e^(-t/tau))$; $u_L(t) = U_q e^(-t/tau)$], [Gleichspannungssprung bei $t = 0$, $i(0) = 0$; ideale Spule.],
 [Dioden-Arbeitsgerade], [$I = (U_q - U_D)/R$], [Quelle, Vorwiderstand, Diode in Reihe; Schnittpunkt mit Diodenkennlinie.],
 [Ladung im Leiter], [$Q = n e A l$], [$n_"Cu" approx "8,44" dot.c 10^22 thin "cm"^(-3)$.],
 [Driftgeschwindigkeit], [$I = n e v_d A$; $v_d = I\/(n e A)$], [Einheiten passend (cm oder m); Größenordnung mm/s.],
 [Stromdichte], [$S = I\/A$], [A/mm²; zulässig etwa 1 … 6 A/mm² (V S. 10).],
 [Kontinuität], [$I_"Ein" = I_"Aus"$; $S_1 A_1 = S_2 A_2$], [Unverzweigter Leiter.],
 [Transformator], [$U_1\/U_2 = N_1\/N_2 = I_2\/I_1$], [Wechselstrom; ideal, ohne Verluste.],
 [Lorentzkraft], [$arrow(F)_L = Q (arrow(v) times arrow(B)) = I (arrow(l) times arrow(B))$; $F = I l B$], [Betragsform bei $arrow(l) perp arrow(B)$; parallel: $F = 0$.],
 [Drehspulinstrument], [$M_"el" = N A B I$; $phi = N A B\/D^* dot.c I$], [$A = 2 r l$; $phi ∼ I$.],
 [Wechselstrom], [$T = 1\/f$; $I_"eff" = hat(i)\/sqrt(2)$], [Effektivwert nur für Sinusform; 50 Hz → 20 ms.],
 [Induktion], [$u_i = -N dif Phi\/dif t = -N A dif B\/dif t$], [Fluss in Wb; zweite Form nur bei fester Fläche und Orientierung sowie homogenem senkrechtem Feld.],
 [Grundstromkreis], [$I = U_q\/(R_i + R_a)$; $U_a = U_q - I R_i$], [Reale Quelle = $U_q$ mit $R_i$ in Reihe; Entladebetrieb.],
 [Innenwiderstand], [$R_i = U_l\/I_k$; $I_k = U_q\/R_i$], [Leerlaufspannung $U_l = U_q$.],
 [Quellenkennlinie], [$I(U) = -U\/R_i + I_k$], [Steigung $-1\/R_i$.],
 [Leistungsbilanz], [$U_q I = I^2 R_i + U_a I$], [$P_q = P_v + P_a$.],
 [Wirkungsgrad], [$eta = P_a\/P_q = R_a\/(R_i + R_a)$], [Allgemein $eta = P_"Nutz"\/P_"Aufwand"$.],
 [Leistungsanpassung], [$R_a = R_i$: $P_"a,max" = U_q^2\/(4 R_i)$, $U_a = U_q\/2$, $I = I_k\/2$], [$eta = 50 thin %$.],
 [Fehlanpassung], [$P_a\/P_"a,max" = 4 (R_a\/R_i)\/(1 + R_a\/R_i)^2$], [Nach V S. 46.],
)

#src([Ergänzte Formeln: FK-N, PDF-S. 6; V S. 17–19; N, PDF-S. 3 und 6. Voraussetzungen und belasteter Teiler wie in Abschnitt 0.6 und 1.2.3–1.2.6 hergeleitet.])

#note("Wichtige Zahlen", [
$e = "1,602176634" dot.c 10^(-19) thin "As"$ (gerundet $"1,602" dot.c 10^(-19)$); 1 A ≈ $"6,25" dot.c 10^18$ Elektronen pro Sekunde; $n_"Cu" approx "8,44" dot.c 10^22 thin "cm"^(-3)$.

$rho_"Cu" = "0,0178"$ (Ü) bzw. $"0,0179" thin Omega thin "mm"^2\/"m"$ (V); $rho_"Al" = "0,0278" thin Omega thin "mm"^2\/"m"$; $S_"zul" approx 1 dots 6 thin "A/mm"^2$.

Für die neuen Aufgaben: $h approx "6,626" dot.c 10^(-34) thin "Js"$; $c = 299792458 thin "m/s"$; Si: $W = "1,12" thin "eV"$, $lambda_g approx "1,11" thin mu"m"$ (V S. 18–19).

Netz: 230 V, 50 Hz, $T = 20 thin "ms"$; $1 thin "mm"^2 = "0,01" thin "cm"^2 = 10^(-6) thin "m"^2$; $1 thin "kWh" = "3,6" thin "MJ"$.
])
