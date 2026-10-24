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
  #text(size: 8pt, fill: muted)[Feynman-Lernskript · Stand 22.10.2026]
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

Stand 22.10.2026, ergänzt um die neuen Unterlagen: Enthalten sind Skript Kapitel 1.1 bis 1.2.5, deine Randnotizen zu Spule und Diode sowie der Grundstromkreis aus der Zusammenfassung (Skript 2.4.1 bis 2.4.3). Die neuen Markierungen belegen den 15.10. auf Skript S. 16–17 und den 22.10. auf S. 18–19; die Nummern dieser Vorlesungen sind offen. Ergänzt sind auch die am 22.10. bearbeiteten Fragen 25–28; Aufgaben und getrennte Lösungen wachsen mit.

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
#note("Von dir markiert", [Im neuen Fragenkatalog steht: „Aufgabe 25 bis 28 am 22.10 gemacht“. Die Spannungsteilerregel ist in deiner Lösung eingerahmt. Die Fragen zum Magnetfeld greifen wir bei Induktion und in Aufgabe 37 von Kapitel 1 auf.])
#bild("notiz-spannungsteiler", [Spannungsteiler mit deinem Rechenweg. FK-N, PDF-S. 6, Aufgabe 25, Ausschnitt.], height: 48mm)
#form[$ I = U/(R_1 + R_2) quad U_20 = I R_2 = U R_2/(R_1 + R_2) $]
$U$: Gesamtspannung in V; $R_1$, $R_2$: Widerstände in Ω; $U_20$: Ausgangsspannung an $R_2$ im Leerlauf. *Voraussetzung:* kein Laststrom am Ausgang; ein ideales Voltmeter verändert die Schaltung nicht.

*FK 25:* $I = 35 thin "V"/(115 thin "k"Omega) approx "0,30435" thin "mA"$. Damit ist $U_20 = 35 thin "V" dot.c 100/115 approx "30,43" thin "V"$. Runde möglichst erst das Ergebnis, damit sich Rundungsfehler nicht fortsetzen.
#note("Fehler vermeiden", [Ein angeschlossener Verbraucher liegt parallel zu $R_2$. Dann ist der untere Widerstand durch den Parallelersatz zu ersetzen; die unbelastete Formel mit unverändertem $R_2$ gilt nicht mehr. Das ist die Bedeutung deiner Randnotiz neben den Ausgangsklemmen.], fill: sand)

*FK 26–27:* Bei einer idealen Quelle entfällt der Innenwiderstand. Bei einer realen Quelle fällt unter Last innen $U_i = I R_i$ ab: Mit $U_q = "1,52" thin "V"$, $R_i = "0,13" thin Omega$ und $I = "0,04" thin "A"$ erhältst du $U_i = "0,0052" thin "V"$ und *$U_"Klemme" = "1,5148" thin "V"$*. Das ist die genauer gerechnete Version des Beispiels in Abschnitt 0.5.
#note("Selbst erklären", [Warum darfst du die Spannungsteilerregel nicht ohne Prüfung für einen belasteten Ausgang verwenden? \ *Antwort:* Der Laststrom fließt zusätzlich durch $R_1$; $R_1$ und $R_2$ führen dann nicht mehr denselben Strom. Erst den Parallelersatz unten bilden, dann die Regel anwenden.])
#src([FK-N, PDF-S. 6, Aufgaben 25–27 samt handschriftlichen Lösungen; Abschnitt 0.4 und V S. 42 für die Schaltungsregeln. Rechenwege ergänzt und ohne frühes Runden geprüft.])

*Der Zusammenhang in Kapitel 0.* Die Spannung ist die Ursache, der Strom die Folge, der Widerstand bestimmt, wie viel Strom die Spannung antreibt. Die Leistung verknüpft Spannung und Strom zu dem, was am Verbraucher ankommt, und über die Zeit zur Energie, die bezahlt wird. In Schaltungen entscheidet die Schaltungsart, welche Größe überall gleich ist.

#pagebreak()
== Verständnisfragen und Rechenaufgaben · Kapitel 0
#set enum(spacing: 0.85em)
Erkläre erst selbst. Bei Rechenaufgaben schreibst du Gegebenes, Gesuchtes und die Formel auf. Die Lösungen folgen getrennt.

1. Welche Elementarteilchen sind elektrisch geladen? Welche davon bewegen sich in einem Metalldraht?
2. Wie wirken gleichartige und ungleichartige Ladungen aufeinander?
3. Warum setzt ein Leiter dem Strom einen Widerstand entgegen? Was entsteht dabei?
4. Nenne vier Größen, von denen der Widerstand eines Leiters abhängt.
5. Wofür stehen AC, DC, PTC und NTC?
6. In einer Reihenschaltung wird ein Widerstand vergrößert. Was passiert mit Strom, Leistung und Belastung der Quelle?
7. Ordne zu: 380 kV, 400 V, 230 V, 12 V, 1,5 V → AAA-Batterie, Höchstspannung, Drehstromnetz, Wechselstromnetz, PKW-Batterie.
8. Welcher Werkstoff leitet am besten: Eisen, Silber, Kupfer oder Gold?
9. Zwei unterschiedliche Widerstände liegen in Reihe. Was ist an beiden gleich, was ist verschieden? Hat die Schaltungsart Einfluss auf Strom und Spannung?
10. Unterschiedliche Widerstände liegen parallel. Was gilt für Spannung, Strom und Leistung der einzelnen Widerstände? Was passiert mit dem Gesamtstrom, wenn ein Widerstand ausfällt?
11. Welche Ladung wird bei konstant 600 mA in 30 ms transportiert?
12. Signallampe 3 W / 0,5 A: Wie groß ist ihr Betriebswiderstand?
13. Heizspirale 75 Ω an 230 V: Welcher Strom fließt?
14. Wärmegerät 2,5 kW, gemessener Strom 3,75 A: An welcher Spannung wird es betrieben?
15. Reihenschaltung, $R_"ges" = 180 thin Omega$, $I = 2 thin "A"$, $R_1 = 70 thin Omega$. a) $R_2$? b) Teilspannungen? c) Gesamtspannung?
16. Drei Widerstände parallel an 36 V, Ströme 4,5 A, 7 A und 5 A. a) Teilwiderstände? b) Gesamtstrom? c) Gesamtwiderstand?
17. Unbelasteter Spannungsteiler: $R_1 = 15 thin "k"Omega$, $R_2 = 100 thin "k"Omega$, $U = 35 thin "V"$. Wie groß ist $U_20$ an $R_2$?
18. Rechne um: a) 2,67 V in µV b) 180 µA in mA c) 370 kΩ in MΩ d) 36,2 mA in µA e) 4700 µΩ in Ω f) 50 000 A in kA.
19. Eine Kupferleitung führt 25 m hin und 25 m zurück, $A = "1,5" thin "mm"^2$, $rho_"Cu" = "0,0179" thin Omega thin "mm"^2\/"m"$ (Daten aus V S. 9). Bestimme die Leiterlänge und den Widerstand. Warum zählt die Länge doppelt?
20. Ein Kupferdraht ($rho = "0,0178" thin Omega thin "mm"^2\/"m"$) ist 20 m lang und hat 0,5 mm Durchmesser. Wie groß ist sein Widerstand?

#heading(level: 3, outlined: false)[Vertiefende Verständnisfragen und Rechenaufgaben]
21. *Kohleschicht-Widerstand, Ü 1a:* Die Kohleschicht ist zu einer Wendel von 95 mm Länge und 3,5 mm Breite geschliffen, $rho_"Kohle" = 60 thin Omega thin "mm"^2\/"m"$. Wie dick muss die Schicht sein, damit der Widerstand 80 kΩ beträgt?
22. *Aluminium und Kupfer, Ü 7 (= Blatt B 14):* In welchem Verhältnis stehen a) die Querschnitte gleich langer und widerstandsgleicher Aluminium- und Kupferleiter, b) die Widerstände gleich langer Kupferleiter mit dem Durchmesserverhältnis 2 : 1? ($rho_"Al" = "0,0278"$, $rho_"Cu" = "0,0178" thin Omega thin "mm"^2\/"m"$)
23. *Belastbarkeit, Blatt A 1:* An welcher Spannung darf ein Widerstand von 4,7 kΩ mit einer Dauerbelastbarkeit von 1/8 W höchstens betrieben werden?
24. *Spannung +10 %, Blatt A 6:* Bei einem Verbraucher mit konstantem Widerstand steigt die Spannung um 10 % über die Nennspannung. Um wie viel Prozent ändert sich die Leistung?
25. *Wasserkocher, Blatt A 7:* Nenndaten 230 V / 1500 W, Wirkungsgrad 0,85. Wie lange dauert es, 1 Liter Wasser von 15 °C auf 100 °C zu erwärmen? ($c = "4,19" thin "kJ/(kg K)"$, 1 J = 1 Ws)
26. *Reihenschaltung, Blatt B 15:* Drei Widerstände in Reihe liegen an 10 V. In $R_1 = 39 thin Omega$ fließen 75,2 mA. Wie groß sind $R_2 = R_3$?
27. *Stand-by, Blatt B 16:* Ein Fernseher nimmt im Betrieb 90 W auf, im Stand-by 15 W; Betrieb 4 h, Stand-by 20 h täglich. a) Monatlicher Energiebedarf (30 Tage) im Betrieb? b) im Stand-by? c) Zu wie viel Prozent wäre ein 400-MW-Kraftwerk ausgelastet, um den Stand-by von 10 Millionen Geräten zu versorgen?
28. *Elektromotor, Blatt B 18:* Ein Motor gibt an der Welle 6,5 kW ab, Wirkungsgrad 78 %. Wie groß ist seine Stromaufnahme an 440 V Gleichspannung?

29. *Ergänzung zu FK 25, eigene Aufgabe:* Der Spannungsteiler aus Abschnitt 0.6 erhält einen Verbraucher $R_L = 100 thin "k"Omega$ parallel zu $R_2 = 100 thin "k"Omega$. $R_1 = 15 thin "k"Omega$, $U = 35 thin "V"$. a) Welche Spannung liegt jetzt am Ausgang? b) Warum ist sie kleiner als im Leerlauf?
30. *FK 27, am 22.10. bearbeitet:* Eine Mignonzelle hat $U_q = "1,52" thin "V"$ und $R_i = "0,13" thin Omega$. Berechne die Klemmenspannung bei 40 mA und, als eigene Variation, bei 80 mA. Erkläre den Unterschied.

#pagebreak()
== Lösungen Kapitel 0
#set enum(spacing: 0.65em)
1. Protonen (+) und Elektronen (−). Im Metall bewegen sich nur die Elektronen; Neutronen und Atome als Ganzes sind neutral. #nachschlagen[Lernskript, #stelle(<a-0-1>)]
2. Gleichartige stoßen sich ab, ungleichartige ziehen sich an. #nachschlagen[Lernskript, #stelle(<a-0-1>)]
3. Die Elektronen stoßen an die Atome des Gitters („Reibung“). Dabei wird elektrische Energie in Wärme umgewandelt. #nachschlagen[Lernskript, #stelle(<a-0-2>)]
4. Material ($rho$), Länge $l$, Querschnitt $A$ und Temperatur. #nachschlagen[Lernskript, #stelle(<a-0-2>)]
5. AC = Alternating Current (Wechselstrom), DC = Direct Current (Gleichstrom), PTC = Kaltleiter ($R$ steigt mit $T$), NTC = Heißleiter ($R$ sinkt mit $T$). #nachschlagen[Lernskript, #stelle(<a-0-2>); Stromarten: #stelle(<a-1-1-7>)]
6. Strom sinkt, Leistung sinkt, die Quelle wird weniger belastet. #nachschlagen[Lernskript, #stelle(<a-0-4>)]
7. AAA 1,5 V; Höchstspannung 380 kV; Drehstrom 400 V; Wechselstrom 230 V; PKW 12 V. #nachschlagen[Lernskript, #stelle(<a-0-1>)]
8. Silber, vor Kupfer, Gold und Eisen. #nachschlagen[Lernskript, #stelle(<a-0-2>)]
9. Der Strom ist an beiden gleich; die Spannungen teilen sich im Verhältnis der Widerstände. Die Schaltungsart bestimmt also sehr wohl Strom und Spannung. #nachschlagen[Lernskript, #stelle(<a-0-4>)]
10. An jedem Widerstand liegt dieselbe Spannung, die Ströme sind verschieden. Je größer der Widerstand, desto kleiner seine Leistung ($P = U^2\/R$). Fällt ein Zweig aus, sinkt der Gesamtstrom. #nachschlagen[Lernskript, #stelle(<a-0-4>)]
11. $Q = "0,6" thin "A" dot.c "0,03" thin "s" = "0,018" thin "As" = 18 thin "mC"$. #nachschlagen[Lernskript, #stelle(<a-0-1>)]
12. $R = P\/I^2 = 3\/"0,25" = 12 thin Omega$ (oder $U = P\/I = 6 thin "V"$, $R = 6\/"0,5" = 12 thin Omega$). #nachschlagen[Lernskript, #stelle(<a-0-3>)]
13. $I = 230\/75 approx "3,07" thin "A"$. #nachschlagen[Lernskript, #stelle(<a-0-2>)]
14. $U = P\/I = 2500\/"3,75" approx "666,7" thin "V"$. #nachschlagen[Lernskript, #stelle(<a-0-3>)]
15. a) $R_2 = 180 - 70 = 110 thin Omega$ b) $U_1 = 140 thin "V"$, $U_2 = 220 thin "V"$ c) $U = 360 thin "V"$. Prüfung: $180 thin Omega dot.c 2 thin "A" = 360 thin "V"$. #nachschlagen[Lernskript, #stelle(<a-0-4>)]
16. a) $R_1 = 36\/"4,5" = 8 thin Omega$, $R_2 = 36\/7 approx "5,14" thin Omega$, $R_3 = 36\/5 = "7,2" thin Omega$ b) $I = "16,5" thin "A"$ c) $R = 36\/"16,5" approx "2,18" thin Omega$, kleiner als der kleinste Einzelwiderstand. #nachschlagen[Lernskript, #stelle(<a-0-4>)]
17. $U_20 = 35 thin "V" dot.c 100\/115 approx "30,4" thin "V"$. #nachschlagen[Lernskript, #stelle(<a-0-4>)]
18. a) 2 670 000 µV b) 0,18 mA c) 0,37 MΩ d) 36 200 µA e) 0,0047 Ω f) 50 kA. #nachschlagen[Lernskript, #stelle(<a-0-1>)]
19. $l = 2 dot.c 25 thin "m" = 50 thin "m"$; $R = "0,0179" dot.c 50\/"1,5" approx "0,60" thin Omega$ (wie V S. 9). Der Strom fließt hin und zurück; beide Leiter liegen in Reihe. #nachschlagen[Lernskript, #stelle(<a-0-2>)]
20. $A = pi\/4 dot.c ("0,5" thin "mm")^2 approx "0,196" thin "mm"^2$; $R = "0,0178" dot.c 20\/"0,196" approx "1,81" thin Omega$. Gegeben war der Durchmesser, nicht der Querschnitt. #nachschlagen[Lernskript, #stelle(<a-0-2>)]

#block(breakable: false)[
#heading(level: 3, outlined: false)[21 · Dicke der Kohleschicht]
*Idee:* Das Kohleband ist ein flacher, langer Leiter mit dem Querschnitt $A = b dot.c d$.
+ $R = rho l\/A$ nach $A$ umstellen: $A = (rho l)/R = (60 thin Omega thin "mm"^2\/"m" dot.c "0,095" thin "m")/(80 thin 000 thin Omega) approx "7,13" dot.c 10^(-5) thin "mm"^2$
+ $d = A\/b = "7,13" dot.c 10^(-5) thin "mm"^2 \/ "3,5" thin "mm" approx "2,04" dot.c 10^(-5) thin "mm"$
*Ergebnis:* $d approx 20 thin "nm"$, wie auf dem Übungsblatt. *Prüfung:* mm² geteilt durch mm ergibt mm; eine hauchdünne Schicht ist für 80 kΩ plausibel.
#note("Von dir markiert", [„In Prüfung Einheiten richtig mitführen!!“ (Ü-N, PDF-S. 4). Dort steht im Zähler einmal 3,5 mm. Richtig ist die *Länge 95 mm*; 3,5 mm ist die Breite im Nenner. DC, PDF-S. 3, setzt richtig ein.], fill: sand)
#src([Ü 1a; Ü-N, PDF-S. 4; DC, PDF-S. 3.])
#nachschlagen[Lernskript, #stelle(<a-0-2>)]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[22 · Aluminium gegen Kupfer]
a) Gleiche Länge, gleicher Widerstand: $rho_"Al" l\/A_"Al" = rho_"Cu" l\/A_"Cu"$, also $A_"Al"\/A_"Cu" = rho_"Al"\/rho_"Cu" = "0,0278"\/"0,0178" approx "1,56"$. Das Verhältnis der Durchmesser ist $sqrt("1,56") approx "1,25"$.\
b) Durchmesser 2 : 1 → Querschnitt 4 : 1 → $R_1\/R_2 = 1\/4 = "0,25"$: Der dickere Leiter hat ein Viertel des Widerstands. Deine Lösung R S. 8 kommt ebenfalls auf 1,56 und 1/4.
#note("Widerspruch in den Unterlagen", [Ü 7a nennt als Lösung 1,25. Das ist das Verhältnis der *Durchmesser*. Das Verhältnis der *Querschnitte* ist 1,56. Schreib in der Klausur beide Zahlen mit Begründung hin.], fill: sand)
_Eigene Ergänzung, WI-Sicht:_ Aluminium braucht rund 56 % mehr Querschnitt, ist aber leichter und billiger als Kupfer; deshalb bestehen Freileitungen oft aus Aluminium.
#nachschlagen[Lernskript, #stelle(<a-0-2>)]
]

23. $P = U^2\/R => U = sqrt(P R) = sqrt("0,125" thin "W" dot.c 4700 thin Omega) approx "24,2" thin "V"$ (R S. 1: 24 V). #nachschlagen[Lernskript, #stelle(<a-0-3>)]
24. $P' = ("1,1" U)^2\/R = "1,21" dot.c P$: Die Leistung steigt um 21 %, weil $P ∼ U^2$ (R S. 3). #nachschlagen[Lernskript, #stelle(<a-0-3>)]

#block(breakable: false)[
#heading(level: 3, outlined: false)[25 · Wasserkocher]
*Annahme:* 1 Liter Wasser hat die Masse 1 kg.
+ Nötige Wärme: $Q = m c Delta T = 1 thin "kg" dot.c "4,19" thin "kJ/(kg K)" dot.c 85 thin "K" approx "356,2" thin "kJ"$
+ Nutzleistung: $P_"Nutz" = eta dot.c P = "0,85" dot.c 1500 thin "W" = 1275 thin "W"$
+ Zeit: $t = Q\/P_"Nutz" = 356 thin 150 thin "Ws" \/ 1275 thin "W" approx 279 thin "s"$
*Ergebnis:* $t approx 280 thin "s" approx "4,7" thin "min"$ (wie R S. 3, dort über $Q\/eta$ gerechnet). *Prüfung:* Ohne Verluste wären es rund 237 s; mit Verlusten dauert es länger.
#nachschlagen[Lernskript, #stelle(<a-0-3>); Wirkungsgrad: #stelle(<a-2-4-3>)]
]

26. $R_"ges" = U\/I = 10 thin "V"\/"75,2" thin "mA" approx 133 thin Omega$; $R_2 = R_3 = (133 - 39)\/2 approx 47 thin Omega$ (R S. 8). #nachschlagen[Lernskript, #stelle(<a-0-4>)]
27. a) $90 thin "W" dot.c 4 thin "h" dot.c 30 = "10,8" thin "kWh"$ b) $15 thin "W" dot.c 20 thin "h" dot.c 30 = 9 thin "kWh"$ c) $15 thin "W" dot.c 10^7 = 150 thin "MW"$, also $150\/400 = "37,5" thin %$, solange alle Geräte gleichzeitig im Stand-by sind (R S. 9). #nachschlagen[Lernskript, #stelle(<a-0-3>)]
28. $P_"el" = P_"mech"\/eta = "6,5"\/"0,78" approx "8,33" thin "kW"$; $I = P_"el"\/U approx 8333\/440 approx "18,9" thin "A"$ (R S. 9). #nachschlagen[Lernskript, #stelle(<a-0-3>); Wirkungsgrad: #stelle(<a-2-4-3>)]

#block(breakable: false)[
#heading(level: 3, outlined: false)[29 · Belasteter Spannungsteiler]
*Modell:* Ideale 35-V-Quelle, konstante Widerstände, Last parallel zu $R_2$.
+ Parallelersatz: $R_p = (100 dot.c 100)/(100 + 100) thin "k"Omega = 50 thin "k"Omega$.
+ Gesamtstrom: $I = 35 thin "V"/(65 thin "k"Omega) approx "0,5385" thin "mA"$; Ausgangsspannung: $U_a = 35 thin "V" dot.c 50/65 approx "26,92" thin "V"$.
*Ergebnis: 26,92 V.* Die Last verkleinert den unteren Ersatzwiderstand; an $R_1$ fällt mehr Spannung ab. *Prüfung:* In $R_2$ und $R_L$ fließen je rund 0,2692 mA, zusammen der Gesamtstrom. $U_a$ ist kleiner als die Leerlaufspannung 30,43 V.
#nachschlagen[Lernskript, #stelle(<a-0-6>); Parallelersatz: #stelle(<a-0-4>)]
]

30. $U(40 thin "mA") = "1,5148" thin "V"$; $U(80 thin "mA") = "1,5096" thin "V"$. Rechnung: jeweils $U = "1,52" thin "V" - I dot.c "0,13" thin Omega$. Doppelter Strom verdoppelt den inneren Spannungsabfall (5,2 → 10,4 mV). *Prüfung:* Beide Klemmenspannungen sind kleiner als 1,52 V. #nachschlagen[Lernskript, #stelle(<a-0-6>)]

#pagebreak()
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

#pagebreak()
== Verständnisfragen und Rechenaufgaben · Kapitel 1
#set enum(spacing: 0.85em)
Erkläre erst selbst, am besten laut und ohne Vorlage. Die Lösungen folgen getrennt.

1. Erkläre die Formel $Q = n e A l$. Was bedeutet jede Größe?
2. Definiere die Stromstärke in Worten und als Formel. Wie viele Elektronen sind „1 Ampere“?
3. Was ist der Unterschied zwischen technischer und physikalischer Stromrichtung? Welche benutzt man im Schaltbild?
4. Die Elektronen driften nur mit etwa 1 mm/s. Warum geht das Licht trotzdem sofort an?
5. Warum bestimmt die Stromdichte und nicht die Stromstärke die Erwärmung eines Leiters?
6. Ein Leiter hat links den Querschnitt $A$, rechts $2 A$. Was gilt rechts für Strom und Stromdichte?
7. Nenne die drei Wirkungen des Stroms mit je einem Anwendungsbeispiel.
8. Wovon hängt die Lorentzkraft auf einen stromdurchflossenen Leiter ab? Wann ist sie null?
9. Warum hat ein Drehspulinstrument eine lineare Skala?
10. Warum überträgt man elektrische Energie über weite Strecken mit Hochspannung?
11. Was muss in jeder Spannungsquelle passieren, damit eine Quellspannung entsteht? Welche Energieumwandlung findet in Batterie und Generator statt?
12. Formuliere das Induktionsgesetz in Worten. Was bedeutet das Minuszeichen?
13. Ein Magnet liegt ruhig in einer Spule. Wird eine Spannung induziert? Und wenn man die Spule aus dem Feld zieht?
14. In der Lampen-Aufgabe wird S geschlossen. Was passiert mit C, mit dem Batteriestrom, mit A und B und mit der Gesamtleistung?
15. Durch einen Leiter fließen 2 Minuten lang 0,5 A. a) Welche Ladung? b) Wie viele Elektronen sind das?
16. Kupferleitung, $A = "1,5" thin "mm"^2$, $I = 16 thin "A"$. a) Stromdichte $S$? Ist das zulässig? b) Driftgeschwindigkeit $v_d$?
17. Kupferleitung (Daten aus V S. 9): $I = "16,66" thin "A"$, $A = "1,5" thin "mm"^2$. Rechne $A$ in cm² um und bestimme $v_d$.
18. Durch einen Leiter mit 2,5 mm² fließen 10 A. Wie groß ist die Stromdichte? Liegt sie im zulässigen Bereich?
19. Ein gerader Leiter liegt auf 20 cm Länge senkrecht in einem Magnetfeld $B = "0,5" thin "T"$ und führt 5 A. Wie groß ist die Kraft?
20. Ein Drehspulinstrument zeigt bei 2 mA einen Ausschlag von 30°. Welchen Ausschlag zeigt es bei 5 mA?
21. Lampen-Aufgabe mit $U_q = 9 thin "V"$ und $R = 30 thin Omega$ je Lampe. Berechne Strom, Spannung an A und Leistung von A, jeweils bei offenem und bei geschlossenem Schalter.
22. Vier gleiche Lampen liegen in Reihe an 12 V. Eine Lampe wird überbrückt. Wie groß ist die Spannung an einer der übrigen Lampen vorher und nachher? Um welchen Faktor ändert sich ihre Leistung?
23. Netzfrequenz in den USA: 60 Hz. Wie lang ist eine Periode?
24. Eine Spule mit 500 Windungen; der Fluss steigt in 0,1 s gleichmäßig von 0 auf 2 mWb. Wie groß ist $abs(u_i)$?
25. Eine Spule mit 500 Windungen und 4 cm² Querschnitt steckt in einem Feld mit $B = "0,4" thin "T"$. Sie wird in 50 ms ganz aus dem Feld gezogen. Wie groß ist $abs(u_i)$ bei gleichmäßiger Änderung?
26. Eine Powerbank speichert 10 Ah. Ein Gerät zieht konstant 0,8 A. Wie lange reicht die Ladung?

#heading(level: 3, outlined: false)[Vertiefende Verständnisfragen und Rechenaufgaben]
27. *Auto-Akku, Ü 2 und V S. 7:* In einem vollgeladenen 12-V-Akku sind 36 Ah gespeichert. Wie groß ist die theoretische Entladezeit mit zwei parallelen Scheinwerferlampen zu je 42 W?
28. *E-Bike-Akku:* 36 V und 14 Ah, der Motor nimmt 250 W auf. a) Welcher Strom fließt? b) Wie lange kann man fahren? c) Wie viel Energie in Wh steckt im Akku?
29. *Drehspulinstrument:* Vollausschlag 90° bei 1 mA. a) Welcher Strom fließt bei 36°? b) Welche Ladung fließt bei diesem Strom in 5 s durch das Instrument? c) Warum darfst du hier mit einem Dreisatz rechnen?

30. *Thermoeffekt, eigene Ergänzung zu V S. 17:* Ein Cu–Konstantan-Thermoelement hat die Messstelle bei 80 °C, die Vergleichsstelle bei 20 °C. Verwende $K = "0,05" thin "mV/K"$. a) Berechne die Spannung. b) Was ändert sich beim Vertauschen der Temperaturen? c) Was misst du, wenn beide Stellen bei 80 °C liegen?
31. *Fotoeffekt, eigene Ergänzung zu V S. 18–19:* Silizium hat die Bandlücke 1,12 eV und die Grenzwellenlänge rund 1,11 µm. a) Können Photonen mit 850 nm bzw. 1550 nm im einfachen Bandlückenmodell Elektron-Loch-Paare erzeugen? b) Hilft bei ungeeigneter Wellenlänge einfach mehr Licht? Begründe mit der Energie eines Photons.
32. *Piezoeffekt, eigene Verständnisfrage zu V S. 19:* Erkläre den direkten und den umgekehrten Effekt jeweils an einer Anwendung. Welche Material- und Richtungsbedingung musst du beachten?
33. *Grenzwellenlänge, eigene Rechenvariation zu Tabelle 1.1:* Berechne für Germanium mit $W = "0,67" thin "eV"$ die Grenzwellenlänge in µm. Verwende $h = "6,626" dot.c 10^(-34) thin "Js"$, $c = 299792458 thin "m/s"$ und die eV-Umrechnung aus Abschnitt 1.2.4. Vergleiche mit der Tabelle.
34. *Temperatur aus Spannung, eigene Ergänzung:* Ein Cu–Konstantan-Thermoelement liefert in der gewählten Polung +3 mV. Die Vergleichsstelle hat 25 °C. Wie warm ist die Messstelle bei Verwendung des Skriptkoeffizienten? Welche Annahme steckt darin?
35. *Schwingquarz, eigene Variation zu V S. 19:* Ein Quarz schwingt mit 32768 Hz. Eine Elektronik teilt diesmal nur durch $2^14$. Welche Taktfrequenz und Periodendauer entstehen? Ändert die Frequenzteilung die mechanische Quarzfrequenz?
36. *Spule, eigene Rechenaufgabe zu N PDF-S. 3:* Die 12-V-Quelle wird an $R = 10 thin Omega$, $L = 10 thin "mH"$ eingeschaltet; anfangs fließt kein Strom. a) Bestimme Endstrom und Zeitkonstante. b) Berechne Strom und Spulenspannung nach einer Zeitkonstante. c) Was geschieht mit Endstrom und Zeitkonstante, wenn $R$ auf 20 Ω steigt?
37. *Magnetfeld, FK 28 als offene Frage; am 22.10. bearbeitet:* a) Erzeugt auch ein Strom von 0,5 A ein Magnetfeld? b) Eine Spule und ein Magnetfeld ruhen unverändert gegeneinander: Wird Spannung induziert? c) Kann in einem zeitlich konstanten Magnetfeld trotzdem eine Spannung induziert werden? Nenne eine passende Bewegung und die entscheidende Bedingung.
38. *Diode, eigene Variation zur 9-V-Randnotiz:* Am Arbeitspunkt liegen an einer Diode 2,1 V. Sie ist mit 330 Ω in Reihe an 9 V angeschlossen. a) Welcher Strom fließt? b) Welcher Vorwiderstand ergibt näherungsweise 10 mA, wenn die Diodenspannung dort ebenfalls mit 2,1 V angesetzt wird? Warum ist der Schnittpunkt der Kennlinien die genauere Methode?
39. *Fotostrom, eigene Anwendung zu V S. 18:* Im betrachteten Arbeitspunkt fließen 20 µA durch den äußeren Widerstand von 100 kΩ. Welche Spannung und Leistung entstehen dort? Welche Bedingung musst du prüfen, bevor du denselben Strom für einen anderen Lastwiderstand annimmst?
40. *Magnetfeldmessung, eigene Rechenaufgabe nach V S. 16–17:* Eine Messspule mit 200 Windungen und 4 cm² Fläche wird vollständig aus einem homogenen, senkrecht durch die Spulenfläche gerichteten Magnetfeld gezogen. Gesamtwiderstand 100 Ω, gemessene Ladung 2 µC. a) Wie groß ist der Betrag der Flussdichte? b) Was passiert mit dem Ladungsimpuls bei doppelt so schnellem Herausziehen, wenn alle Modellannahmen bestehen bleiben?

#pagebreak()
== Lösungen Kapitel 1
#set enum(spacing: 0.65em)
1. $n$ = freie Elektronen pro Volumen, $e$ = Ladung eines Elektrons, $A l = V$ = Volumen des Leiterstücks. Das Produkt ist die gesamte bewegliche Ladung im Stück. #nachschlagen[Lernskript, #stelle(<a-1-1-1>)]
2. Stromstärke = Ladung, die pro Zeit durch den Querschnitt fließt: $I = Q\/t$ bzw. $i = dif Q\/dif t$. 1 A ≈ $"6,25" dot.c 10^18$ Elektronen pro Sekunde. #nachschlagen[Lernskript, #stelle(<a-1-1-2>)]
3. Technisch: + nach − (Konvention, im Schaltbild). Physikalisch: − nach + (tatsächliche Elektronenbewegung). #nachschlagen[Lernskript, #stelle(<a-1-1-2>)]
4. Das elektrische Feld breitet sich fast mit Lichtgeschwindigkeit aus; alle Elektronen im Kreis beginnen gleichzeitig zu driften. #nachschlagen[Lernskript, #stelle(<a-1-1-3>)]
5. Die Erwärmung kommt von der Reibung pro Querschnittsfläche. Derselbe Strom erzeugt in einem dünnen Draht eine viel höhere Stromdichte und damit mehr Wärme als in einem dicken. #nachschlagen[Lernskript, #stelle(<a-1-1-5>)]
6. Gleicher Strom (Kontinuität), halbe Stromdichte. #nachschlagen[Lernskript, #stelle(<a-1-1-5>)]
7. Wärme (Heizlüfter), Kraft über das Magnetfeld (Elektromotor), Materialtransport (elektrochemische Prozesse, z. B. Galvanisieren). #nachschlagen[Lernskript, #stelle(<a-1-1-6>)]
8. $F_L = I l B$: Sie wächst mit Strom, Leiterlänge im Feld und Flussdichte. Liegt der Leiter parallel zum Feld, ist $arrow(l) times arrow(B) = 0$, also keine Kraft. #nachschlagen[Lernskript, #stelle(<a-1-1-6>)]
9. Weil $phi = N A B\/D^* dot.c I$: Der Ausschlag ist proportional zum Strom. #nachschlagen[Lernskript, #stelle(<a-1-1-6>)]
10. Die Leitungsverluste $P = I^2 R$ hängen quadratisch vom Strom ab. Bei hoher Spannung braucht man für dieselbe Leistung nur wenig Strom. #nachschlagen[Lernskript, #stelle(<a-1-1-5>)]
11. Ladungstrennung durch einen physikalischen Effekt. Batterie: chemisch → elektrisch. Generator: mechanisch → elektrisch (Induktion). #nachschlagen[Lernskript, #stelle(<a-1-2-1>); #stelle(<a-1-2-2>)]
12. Ändert sich der magnetische Fluss durch eine Spule, wird eine Spannung induziert, umso größer, je schneller die Änderung und je mehr Windungen. Das Minus (Lenz): Die Wirkung ist ihrer Ursache entgegengerichtet. #nachschlagen[Lernskript, #stelle(<a-1-2-2>)]
13. Ruhender Magnet: nein, der Fluss ist konstant, $dif Phi\/dif t = 0$. Spule aus dem Feld ziehen: ja, der Fluss durch die Spule ändert sich. #nachschlagen[Lernskript, #stelle(<a-1-2-2>)]
14. C erlischt, der Batteriestrom steigt, A und B leuchten heller, die Gesamtleistung steigt. #nachschlagen[Lernskript, #stelle(<a-1-1-7-1>)]
15. a) $Q = "0,5" thin "A" dot.c 120 thin "s" = 60 thin "As"$ b) $N = Q\/e = 60\/("1,602" dot.c 10^(-19)) approx "3,75" dot.c 10^20$ Elektronen. #nachschlagen[Lernskript, #stelle(<a-1-1-1>)]
16. a) $S = 16\/"1,5" approx "10,7" thin "A/mm"^2$: deutlich über 6 A/mm², nicht dauerhaft zulässig. b) $v_d = 16\/("8,44" dot.c 10^22 dot.c "1,602" dot.c 10^(-19) dot.c "0,015") thin "cm/s" approx "0,079" thin "cm/s" = "0,79" thin "mm/s"$. #nachschlagen[Lernskript, #stelle(<a-1-1-5>); #stelle(<a-1-1-3>)]
17. $A = "0,015" thin "cm"^2$; $v_d = "16,66"\/("8,44" dot.c 10^22 dot.c "1,602" dot.c 10^(-19) dot.c "0,015") approx "0,082" thin "cm/s" = "0,82" thin "mm/s"$ (wie V S. 9). #nachschlagen[Lernskript, #stelle(<a-1-1-3>)]
18. $S = 10\/"2,5" = 4 thin "A/mm"^2$: im Bereich 1 … 6 A/mm², zulässig. #nachschlagen[Lernskript, #stelle(<a-1-1-5>)]
19. $F = I l B = 5 thin "A" dot.c "0,2" thin "m" dot.c "0,5" thin "T" = "0,5" thin "N"$. #nachschlagen[Lernskript, #stelle(<a-1-1-6>)]
20. $phi ∼ I$: $30° dot.c 5\/2 = 75°$. #nachschlagen[Lernskript, #stelle(<a-1-1-6>)]
21. Offen: $I = 9\/90 = "0,1" thin "A"$, $U_A = 3 thin "V"$, $P_A = "0,3" thin "W"$. Geschlossen: $I = 9\/60 = "0,15" thin "A"$, $U_A = "4,5" thin "V"$, $P_A = "0,675" thin "W"$, also das 2,25-Fache. #nachschlagen[Lernskript, #stelle(<a-1-1-7-1>)]
22. Vorher $12\/4 = 3 thin "V"$, nachher $12\/3 = 4 thin "V"$. Wegen $P ∼ U^2$: Faktor $(4\/3)^2 approx "1,78"$. #nachschlagen[Lernskript, #stelle(<a-1-1-7-1>)]
#block(breakable: false)[
23. $T = 1\/(60 thin "Hz") approx "16,7" thin "ms"$. #nachschlagen[Lernskript, #stelle(<a-1-1-7>)]
]
24. $abs(u_i) = 500 dot.c (2 dot.c 10^(-3) thin "Vs")\/("0,1" thin "s") = 10 thin "V"$. #nachschlagen[Lernskript, #stelle(<a-1-2-2>)]
25. $Delta Phi = B A = "0,4" thin "T" dot.c 4 dot.c 10^(-4) thin "m"^2 = "1,6" dot.c 10^(-4) thin "Vs"$; $abs(u_i) = 500 dot.c "1,6" dot.c 10^(-4)\/"0,05" = "1,6" thin "V"$. #nachschlagen[Lernskript, #stelle(<a-1-2-2>)]
26. $t = Q\/I = 10 thin "Ah"\/"0,8" thin "A" = "12,5" thin "h"$. #nachschlagen[Lernskript, #stelle(<a-1-1-2>)]

#block(breakable: false)[
#heading(level: 3, outlined: false)[27 · Entladezeit des Auto-Akkus]
+ Strom je Lampe: $I = P\/U = 42\/12 = "3,5" thin "A"$; beide parallel: $sum I = 7 thin "A"$
+ Entladezeit: $t = Q_"max"\/sum I = 36 thin "Ah"\/7 thin "A" approx "5,14" thin "h"$
*Ergebnis:* $t approx 308 thin "min"$, wie auf dem Übungsblatt. *Prüfung:* Ah geteilt durch A ergibt h; die Ladung sinkt linear, weil der Strom konstant ist.
#nachschlagen[Lernskript, #stelle(<a-1-1-2>)]
]

28. a) $I = 250\/36 approx "6,94" thin "A"$ b) $t = 14\/"6,94" approx "2,0" thin "h"$ c) $W = 36 thin "V" dot.c 14 thin "Ah" = 504 thin "Wh"$. Leistung aus Kapitel 0, Ladung aus Kapitel 1. #nachschlagen[Lernskript, #stelle(<a-1-1-2>); #stelle(<a-0-3>)]
29. a) $phi ∼ I$: $I = 1 thin "mA" dot.c 36\/90 = "0,4" thin "mA"$ b) $Q = "0,4" thin "mA" dot.c 5 thin "s" = 2 thin "mAs" = 2 thin "mC"$ c) Weil $phi = N A B\/D^* dot.c I$ linear ist. #nachschlagen[Lernskript, #stelle(<a-1-1-6>)]

#block(breakable: false)[
30. a) $Delta vartheta = 60 thin "K"$; $U_q = "0,05" thin "mV/K" dot.c 60 thin "K" = 3 thin "mV"$. b) Die Differenz wird −60 K, die Spannung −3 mV: gleiche Größe, umgekehrte Polung. c) $Delta vartheta = 0$, also $U_q = 0$. *Prüfung:* mV/K × K ergibt mV; die Temperaturdifferenz entscheidet. #nachschlagen[Lernskript, #stelle(<a-1-2-3>)]
]
#block(breakable: false)[
31. a) 850 nm = 0,85 µm liegt unter der Grenzwellenlänge: im Modell genügend Energie. 1550 nm = 1,55 µm liegt darüber: zu wenig Energie. b) Mehr Photonen gleicher Wellenlänge ändern die Energie pro Photon $h c/lambda$ nicht; im einfachen Modell reicht mehr langwelliges Licht deshalb nicht. #nachschlagen[Lernskript, #stelle(<a-1-2-4-g>)]
]
#block(breakable: false)[
32. Direkt: Eine mechanische Kraft auf den Kristall erzeugt ein elektrisches Signal, etwa beim Kristallmikrofon. Umgekehrt: Eine Spannung verformt den Kristall, etwa zur Ultraschallerzeugung. Der Kristall muss piezoelektrisch sein und in der passenden Richtung beansprucht werden. #nachschlagen[Lernskript, #stelle(<a-1-2-5>)]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[33 · Grenzwellenlänge für Germanium]
*Modell:* Ideale Schwelle bei Photonenergie gleich Bandlücke; Bandlücke bei 300 K.
+ Energie umrechnen: $W = "0,67" dot.c "1,602176634" dot.c 10^(-19) thin "J" approx "1,07346" dot.c 10^(-19) thin "J"$.
+ Einsetzen: $lambda_g = (h c)/W = ("6,626" dot.c 10^(-34) thin "Js" dot.c 299792458 thin "m/s")/("1,07346" dot.c 10^(-19) thin "J") approx "1,8505" dot.c 10^(-6) thin "m"$.
*Ergebnis: rund 1,85 µm*, passend zur Tabelle. *Prüfung:* Js × m/s geteilt durch J ergibt m. Germanium hat eine kleinere Bandlücke als Silizium, deshalb liegt die Grenzwellenlänge weiter im Langwelligen.
#nachschlagen[Lernskript, #stelle(<a-1-2-4-g>)]
]

#block(breakable: false)[
34. $Delta vartheta = U_q/K = 3 thin "mV"/("0,05" thin "mV/K") = 60 thin "K"$. Die Messstelle hat *85 °C* ($25 + 60$). Annahmen: korrekte Polung und näherungsweise konstanter Koeffizient im betrachteten Bereich. *Prüfung:* mV geteilt durch mV/K ergibt K. #nachschlagen[Lernskript, #stelle(<a-1-2-3>)]
]
#block(breakable: false)[
35. $f_"Takt" = 32768/16384 thin "Hz" = 2 thin "Hz"$; $T = 1/f_"Takt" = "0,5" thin "s"$. Der Quarz schwingt weiterhin mit 32768 Hz; die Elektronik teilt nur die Frequenz des ausgegebenen Takts. #nachschlagen[Lernskript, #stelle(<a-1-2-5>)]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[36 · Einschalten der Spule]
*Modell:* Ideale Gleichspannungsquelle, lineare ideale Spule, konstanter Serienwiderstand, $i(0) = 0$.
+ Endstrom: $I_oo = U_q/R = 12 thin "V"/(10 thin Omega) = "1,2" thin "A"$.
+ Zeitkonstante: $tau = L/R = "0,010" thin "H"/(10 thin Omega) = 1 thin "ms"$.
+ Bei $t = tau$: $i = "1,2" (1 - e^(-1)) thin "A" approx "0,759" thin "A"$; $u_L = 12 e^(-1) thin "V" approx "4,415" thin "V"$.
+ Bei 20 Ω: $I_oo = "0,6" thin "A"$, $tau = "0,5" thin "ms"$. Der Endstrom wird kleiner; sein relativer Aufbau erfolgt schneller.
*Ergebnis:* Nach 1 ms liegt der Strom bei *rund 0,759 A*. *Prüfung:* $R i + u_L approx "7,585" thin "V" + "4,415" thin "V" = 12 thin "V"$; H/Ω = (Vs/A)/(V/A) = s.
#nachschlagen[Lernskript, #stelle(<a-1-2-6-l>)]
]

#block(breakable: false)[
37. a) Ja, jeder Strom erzeugt ein Magnetfeld; dafür gibt es keine 1-A-Schwelle. b) Nein: Der Fluss bleibt konstant. c) Ja: etwa beim Herausziehen der Spule aus dem Feld oder beim Drehen der Spule. Entscheidend ist die Änderung des magnetischen Flusses durch ihre Fläche; eine Bewegung, bei der der Fluss unverändert bleibt, genügt nicht. #nachschlagen[Lernskript, #stelle(<a-1-1-6>); #stelle(<a-1-2-2>)]
]
#block(breakable: false)[
38. a) $I = (9 - "2,1") thin "V"/(330 thin Omega) approx "0,0209" thin "A" = "20,9" thin "mA"$. b) $R = "6,9" thin "V"/("0,010" thin "A") = 690 thin Omega$. Das ist eine Näherung mit vorgegebener Diodenspannung. Die Kennlinie berücksichtigt, dass diese Spannung vom Strom abhängt. *Prüfung:* Diodenspannung und Widerstandsspannung 6,9 V ergeben zusammen 9 V. #nachschlagen[Lernskript, #stelle(<a-1-2-6-d>)]
]
#block(breakable: false)[
39. $U = I R = 20 thin mu"A" dot.c 100 thin "k"Omega = 2 thin "V"$; $P = U I = 40 thin mu"W"$. Bei anderer Last muss der neue Arbeitspunkt mit der beleuchteten Kennlinie verträglich sein; der Fotostrom ist nicht für jeden Widerstand unverändert vorgegeben. *Prüfung:* A × Ω ergibt V, V × A ergibt W. #nachschlagen[Lernskript, #stelle(<a-1-2-4>); #stelle(<a-1-2-6-d>)]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[40 · Magnetfeld aus dem Ladungsimpuls]
*Modell:* Spule wird vom ursprünglichen Feld vollständig in den feldfreien Bereich gezogen; Fläche und Orientierung sind definiert, der Gesamtwiderstand ist konstant. Die Formel vernachlässigt Einflüsse der Selbstinduktion während des Messimpulses.
+ Fläche: $A = 4 thin "cm"^2 = 4 dot.c 10^(-4) thin "m"^2$; Ladung: $Q = 2 dot.c 10^(-6) thin "As"$.
+ Flussdichte: $B = (R Q)/(N A) = (100 thin Omega dot.c 2 dot.c 10^(-6) thin "As")/(200 dot.c 4 dot.c 10^(-4) thin "m"^2) = "0,0025" thin "T"$.
*Ergebnis: 2,5 mT.* Schnelleres Herausziehen vergrößert die Impulshöhe und verkürzt die Dauer. Bei gleichem Anfangs- und Endfluss bleibt die Fläche unter der Stromkurve, also $Q$, unverändert. *Prüfung:* Ω × As/m² = Vs/m² = T.
#nachschlagen[Lernskript, #stelle(<a-1-2-2>)]
]

#pagebreak()
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

#pagebreak()
== Verständnisfragen und Rechenaufgaben · Kapitel 2
#set enum(spacing: 0.85em)
Skizziere zuerst das Ersatzschaltbild mit Zählpfeilen. Die Lösungen folgen getrennt.

1. Beschreibe Leerlauf und Kurzschluss: Wie groß sind jeweils $R_a$, $I$, $U_a$ und die Spannung an $R_i$?
2. Woran merkt man, dass eine reale Quelle einen Innenwiderstand haben muss?
3. Wie findet man den Arbeitspunkt grafisch? Was passiert mit ihm, wenn $R_a$ kleiner wird?
4. Welche Steigung hat die Quellenkennlinie, wo schneidet sie die Achsen? Was bedeutet eine steilere Widerstandsgerade?
5. Was ist Leistungsanpassung? Welcher Wirkungsgrad ergibt sich, wie groß sind dann $U_a$ und $I$, und wo setzt man sie ein bzw. vermeidet sie?
6. Wie hängt der Wirkungsgrad im Grundstromkreis von $R_a$ ab? Wann ist er null, wann steigt er?
7. Skizziere das Schaltbild einer idealen und einer realen Spannungsquelle.
8. Eine Batterie hat $U_l = "12,6" thin "V"$ und $I_k = 420 thin "A"$. a) $R_i$? b) Klemmenspannung, wenn der Anlasser 150 A zieht?
9. Quelle $U_q = 24 thin "V"$, $R_i = 2 thin Omega$, Last $R_a = 10 thin Omega$. Berechne $I$, $U_a$, $U_i$, $P_a$, $P_i$, $P_q$ und $eta$.
10. Gleiche Quelle wie in Aufgabe 9: Welches $R_a$ liefert maximale Leistung? Wie groß ist $P_"a,max"$?
11. Eine Quelle liefert bei 2 A eine Klemmenspannung von 10 V und bei 4 A noch 8 V. Bestimme $R_i$ und $U_q$.
12. Grundstromkreis: $U_q = 12 thin "V"$, $R_i = "0,5" thin Omega$, $R_a = "5,5" thin Omega$. Bestimme $I$, $U_a$, $U_i$ und $eta$.
13. Eine Quelle hat 4,5 V Leerlaufspannung. Bei 300 mA misst du an den Klemmen 4,2 V. Bestimme $R_i$ und den angeschlossenen $R_a$.
14. Eine Batterie hat $U_q = 9 thin "V"$ und $R_i = 2 thin Omega$. Bei welchem $R_a$ gibt sie die größte Leistung ab? Wie groß sind dann $P_"a,max"$, $I$ und $U_a$?

#heading(level: 3, outlined: false)[Vertiefende Verständnisfragen und Rechenaufgaben]
15. *Innenwiderstand des Netzes, Ü 3 (= V S. 43):* Heizwiderstand 31,2 Ω, Leerlaufspannung 230 V, Klemmenspannung beim Einschalten 218 V. a) Zeichne den Ersatzstromkreis. b) Wie groß ist $R_i$?
16. *Kohleschicht-Widerstand, Ü 1b:* Der 80-kΩ-Widerstand liegt mit $R_S = 20 thin "k"Omega$ in Reihe an $U_q = 10 thin "V"$. Welche Leistung wird im 80-kΩ-Widerstand in Wärme umgesetzt?
17. *Starterbatterie, Blatt A 2:* Leerlaufspannung 13,8 V, Innenwiderstand 40 mΩ. Welche Leistung kann der Akku höchstens an einen Verbraucher abgeben? Wie groß muss der Verbraucherwiderstand dafür sein?
18. *Akku laden, Blatt B 17:* Vier Ni-Cd-Zellen in Reihe haben zusammen 4,8 V Nennspannung und 0,5 Ω Innenwiderstand. Sie werden 16 h lang mit 0,1 A Konstantstrom geladen. Wie viel elektrische Arbeit wird am Akku verrichtet?
19. *Heizgerät an langer Leitung:* Nenndaten 2 kW / 230 V, angeschlossen über eine 30 m lange Kupferleitung (Hin- und Rückleiter je 1,5 mm², $rho = "0,0178" thin Omega thin "mm"^2\/"m"$). Am Leitungsanfang liegen 230 V, der Heizwiderstand sei konstant. a) Widerstand der Leitung? b) Widerstand des Heizgeräts? c) Strom, Spannung am Gerät, Verlustleistung in der Leitung? d) Stromdichte in der Leitung, zulässig?
20. *Kennlinien zeichnen:* Eine Quelle hat 12 V Leerlaufspannung und 6 A Kurzschlussstrom. a) $R_i$? b) Welches $R_a$ ergibt Leistungsanpassung, wie groß ist dann $P_a$? c) Wirkungsgrad bei $R_a = 6 thin Omega$? d) Zeichne Quellenkennlinie und Widerstandsgerade für $R_a = 6 thin Omega$ und lies den Arbeitspunkt ab.

#pagebreak()
== Lösungen Kapitel 2
#set enum(spacing: 0.65em)
1. Leerlauf: $R_a = oo$, $I = 0$, $U_a = U_q$, an $R_i$ 0 V. Kurzschluss: $R_a = 0$, $I = I_k = U_q\/R_i$, $U_a = 0$, an $R_i$ liegt ganz $U_q$. #nachschlagen[Lernskript, #stelle(<a-2-4-1>)]
2. Der Kurzschlussstrom ist endlich, und die Klemmenspannung sinkt unter Last. Bei einer idealen Quelle wäre $I_k$ unendlich. #nachschlagen[Lernskript, #stelle(<a-2-4-1>)]
3. Quellenkennlinie (von $I_k$ bis $U_q$) und Widerstandsgerade (Ursprungsgerade, Steigung $1\/R_a$) einzeichnen; der Schnittpunkt ist der AP. Kleineres $R_a$: Gerade steiler, AP wandert Richtung Kurzschluss (mehr Strom, weniger Spannung). #nachschlagen[Lernskript, #stelle(<a-2-4-1-k>)]
4. Steigung $-1\/R_i$; sie schneidet die $I$-Achse bei $I_k$ und die $U$-Achse bei $U_q$. Eine steilere Widerstandsgerade bedeutet einen kleineren Widerstand. #nachschlagen[Lernskript, #stelle(<a-2-4-1-k>)]
5. $R_a = R_i$: maximale Leistung am Verbraucher, $eta = 50 thin %$, $U_a = U_q\/2$, $I = I_k\/2$. Erwünscht in der Nachrichtentechnik, vermieden in der Energietechnik ($R_a >> R_i$). #nachschlagen[Lernskript, #stelle(<a-2-4-3>)]
6. $eta = R_a\/(R_i + R_a)$: steigt, je größer $R_a$ gegenüber $R_i$ wird; im Kurzschluss ($R_a = 0$) ist $eta = 0$. Bei Anpassung ist $P_a$ maximal, nicht $eta$. #nachschlagen[Lernskript, #stelle(<a-2-4-3>)]
7. Ideal: nur die Quelle $U_q$. Real: $U_q$ mit dem Innenwiderstand $R_i$ in Reihe. #nachschlagen[Lernskript, #stelle(<a-2-4-1>)]
8. a) $R_i = "12,6"\/420 = "0,03" thin Omega = 30 thin "m"Omega$ b) $U = "12,6" - 150 dot.c "0,03" = "8,1" thin "V"$. #nachschlagen[Lernskript, #stelle(<a-2-4-1>)]
9. $I = 24\/12 = 2 thin "A"$; $U_a = 20 thin "V"$; $U_i = 4 thin "V"$; $P_a = 40 thin "W"$; $P_i = 8 thin "W"$; $P_q = 48 thin "W"$; $eta = 40\/48 approx "83,3" thin %$. #nachschlagen[Lernskript, #stelle(<a-2-4-3>)]
10. $R_a = R_i = 2 thin Omega$; $P_"a,max" = 24^2\/(4 dot.c 2) = 72 thin "W"$ bei $eta = 50 thin %$. #nachschlagen[Lernskript, #stelle(<a-2-4-3>)]
11. $10 = U_q - 2 R_i$ und $8 = U_q - 4 R_i$. Subtrahieren: $2 = 2 R_i$, also $R_i = 1 thin Omega$ und $U_q = 12 thin "V"$. #nachschlagen[Lernskript, #stelle(<a-2-4-1>)]
12. $I = 12\/("0,5" + "5,5") = 2 thin "A"$; $U_a = 11 thin "V"$; $U_i = 1 thin "V"$; $eta = 11\/12 approx "91,7" thin %$ (gleicher Strom, daher $P_a\/P_q = U_a\/U_q$). #nachschlagen[Lernskript, #stelle(<a-2-4-1>); #stelle(<a-2-4-3>)]
13. $U_i = "4,5" - "4,2" = "0,3" thin "V"$; $R_i = "0,3"\/"0,3" = 1 thin Omega$; $R_a = "4,2"\/"0,3" = 14 thin Omega$. #nachschlagen[Lernskript, #stelle(<a-2-4-2>)]
14. $R_a = R_i = 2 thin Omega$; $P_"a,max" = 81\/8 approx "10,1" thin "W"$; $I = 9\/4 = "2,25" thin "A"$; $U_a = "4,5" thin "V"$. #nachschlagen[Lernskript, #stelle(<a-2-4-3>)]
15. a) Grundstromkreis mit $U_q = 230 thin "V"$, $R_i$ gesucht, $R_a = "31,2" thin Omega$. b) $I = 218\/"31,2" approx "6,99" thin "A"$; $R_i = 12 thin "V"\/"6,99" thin "A" approx "1,7" thin Omega$. #nachschlagen[Lernskript, #stelle(<a-2-4-2>)]
#block(breakable: false)[
#heading(level: 3, outlined: false)[16 · Leistung im Kohleschicht-Widerstand]
*Modell:* Ideale 10-V-Quelle; 20 kΩ und 80 kΩ in Reihe, beide Widerstände konstant.
+ Gesamtwiderstand: $R = 100 thin "k"Omega$; Strom: $I = 10 thin "V"/(100 thin "k"Omega) = "0,1" thin "mA"$.
+ Teilspannungen: $U_K = I R_K = 8 thin "V"$, $U_S = I R_S = 2 thin "V"$.
+ Leistungen: $P_K = 8 thin "V" dot.c "0,1" thin "mA" = "0,8" thin "mW"$; $P_S = "0,2" thin "mW"$.
*Ergebnis: 800 µW im Kohleschicht-Widerstand*, wie in Ü-N und DC. *Prüfung:* $10 - 8 - 2 = 0$ V; die Quelle liefert $10 thin "V" dot.c "0,1" thin "mA" = 1 thin "mW"$, gleich der Summe beider Leistungen. Der äußere Serienwiderstand erfüllt rechnerisch dieselbe Rolle wie ein Innenwiderstand.
#src([Ü 1b; Ü-N, PDF-S. 4; DC, PDF-S. 3.])
#nachschlagen[Lernskript, #stelle(<a-2-4-1>); #stelle(<a-0-3>)]
]
17. Anpassung: $R_a = R_i = 40 thin "m"Omega$; $P_"max" = U_0^2\/(4 R_i) = ("13,8" thin "V")^2\/(4 dot.c "0,04" thin Omega) approx 1190 thin "W" approx "1,2" thin "kW"$ (R S. 1). #nachschlagen[Lernskript, #stelle(<a-2-4-3>)]

#block(breakable: false)[
#heading(level: 3, outlined: false)[18 · Arbeit beim Laden]
*Modell:* Beim Laden fließt der Strom *in* den Akku hinein. Die Klemmenspannung muss deshalb die Quellspannung *und* den Spannungsabfall am Innenwiderstand aufbringen.
+ $U_i = R_i dot.c I = "0,5" thin Omega dot.c "0,1" thin "A" = "0,05" thin "V"$
+ $U = U_q + U_i = "4,85" thin "V"$
+ $W = U dot.c I dot.c t = "4,85" thin "V" dot.c "0,1" thin "A" dot.c 16 thin "h" = "7,76" thin "Wh"$
*Ergebnis:* $W approx "7,76" thin "Wh"$, wie in R S. 9. *Prüfung:* Ohne Innenwiderstand wären es 7,68 Wh; der kleine Zuschlag ist die Wärme in $R_i$. Achtung: Beim Laden ist das Vorzeichen anders als beim Entladen ($U = U_q - I R_i$).
#nachschlagen[Lernskript, #stelle(<a-2-4-1>); Energie: #stelle(<a-0-3>)]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[19 · Heizgerät an langer Leitung]
*Idee:* Die Leitung wirkt wie ein Innenwiderstand vor dem Verbraucher (Kapitel 0, 1 und 2 zusammen).
+ $R_L = "0,0178" dot.c 60\/"1,5" approx "0,712" thin Omega$ (Hin- und Rückleiter: 60 m)
+ $R_H = U^2\/P = 230^2\/2000 approx "26,45" thin Omega$
+ $I = 230\/("26,45" + "0,712") approx "8,47" thin "A"$; $U_H = "8,47" dot.c "26,45" approx 224 thin "V"$; $P_V = "8,47"^2 dot.c "0,712" approx 51 thin "W"$
+ $S = "8,47"\/"1,5" approx "5,6" thin "A/mm"^2$, gerade noch im Bereich bis 6 A/mm².
*Prüfung:* $224 thin "V" + "8,47" thin "A" dot.c "0,712" thin Omega approx 230 thin "V"$.
#nachschlagen[Lernskript, #stelle(<a-2-4-1>); #stelle(<a-0-2>); #stelle(<a-1-1-5>)]
]

20. a) $R_i = 12\/6 = 2 thin Omega$ b) $R_a = 2 thin Omega$, $P_a = 144\/8 = 18 thin "W"$ c) $eta = 6\/8 = 75 thin %$ d) Quellenkennlinie von (0 V | 6 A) nach (12 V | 0 A), Widerstandsgerade durch (0 | 0) und (6 V | 1 A); Schnittpunkt bei $I = 12\/8 = "1,5" thin "A"$, $U = 9 thin "V"$. #nachschlagen[Lernskript, #stelle(<a-2-4-1-k>); #stelle(<a-2-4-3>)]

#pagebreak()
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
