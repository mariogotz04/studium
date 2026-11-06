<!-- Kartenstil: kurze Stichpunkte; Merksätze und Bild:-Analogien sind ergänzte eigene Lernhilfen. Fachliche Grundlage bleibt die jeweilige Quelle. -->
# Karteikarten · GET

<!--
So ist diese Datei aufgebaut (die Webseite liest sie beim Hochladen automatisch ein):
- "## Kapitel …" beginnt ein Kapitel (Filter auf der Webseite).
- "### Frage" ist die Vorderseite einer Karte. Alles darunter bis zur nächsten ### ist die Rückseite.
- Auf der Rückseite gehen Absätze (Leerzeile), Listen (- …), **fett** und *kursiv*.
- Eine Zeile "Bild: …" erscheint als Merkbild (Analogie im Feynman-Stil) unten auf der Karte.
- "Quelle: 1.3" (Nummer des Abschnitts im Lernskript, bei TM2 z. B. "TM2 1.6") zeigt auf der Karte die Seite im aktuellen Lernskript an. Die Seite wird beim Hochladen automatisch bestimmt.
- "Abbildung: name" zeigt ein Bild aus Typst-Dateien/abbildungen/ (Dateiname ohne Endung, wie bei #bild im Lernskript). Mehrere mit Komma trennen.
- Formeln in Typst-Schreibweise wie im Lernskript zwischen Dollarzeichen, z. B. $c = sqrt(2 g h)$ oder $p_"abs"$. Eine Zeile nur mit "$ … $" (mit Leerzeichen) wird abgesetzt und groß gesetzt. Ein Schrägstrich ohne Bruch: \/
- Nur Verständnisfragen, keine Rechenaufgaben. Antworten kurz, einfach, in eigenen Worten.
- Den Fragetext nur ändern, wenn nötig: Der Lernfortschritt hängt am Wortlaut der Frage.
-->

## Kapitel 0 · Vorwissen

### Was ist elektrische Spannung anschaulich?
- **Spannung:** Energie je Ladung, anschaulich ein elektrischer „Druckunterschied“.
- Sie entsteht durch Ladungstrennung zwischen Plus- und Minuspol.
- Im einfachen Widerstandskreis treibt dieser Unterschied den Strom an.

Bild: Wasserkreislauf: Die Spannung ist der Druckunterschied der Pumpe.
Quelle: 0.1

### Was ist elektrischer Strom?
- Strom ist die Ladung, die pro Zeit durch den Leiterquerschnitt fließt: $I = Q\/t$.
- 1 A heißt, dass pro Sekunde rund $"6,25" dot 10^18$ Elektronen durch den Querschnitt gehen.

**Merksatz:** Ampere zählt Ladung je Sekunde.

Bild: Wassermenge pro Sekunde in einem Rohr.
Quelle: 0.1

### Welche Teilchen sind geladen, und welche bewegen sich in einem Metalldraht?
- Protonen sind positiv, Elektronen negativ, Neutronen neutral.
- Im Metall bewegen sich nur die Elektronen.
- Die Protonen sitzen fest im Atomgitter.
- Gleichartige Ladungen stoßen sich ab, ungleichartige ziehen sich an.

Quelle: 0.1

### Warum hat ein Leiter einen Widerstand, und was entsteht dabei?
- Die Elektronen stoßen auf ihrem Weg ständig an die schwingenden Atome des Gitters.
- Diese „Reibung“ bremst den Strom, und dabei entsteht Wärme.

Quelle: 0.2

### Wovon hängt der Widerstand eines Drahtes ab?
$ R = rho l/A $
- Er wächst mit der Länge, sinkt mit dem Querschnitt, hängt vom Material (spezifischer Widerstand $rho$) und von der Temperatur ab.
- Halber Durchmesser gibt ein Viertel der Fläche und damit vierfachen Widerstand.
- Bei Hin- und Rückleiter zählt die Länge doppelt.

**Merksatz:** Lang und dünn bremst; kurz und dick leitet besser.

Quelle: 0.2

### Was sagt das Ohmsche Gesetz, und wie sieht es im I-U-Diagramm aus?
- $U = R I$.
- Ein linearer Widerstand ist im $I$-$U$-Diagramm eine Gerade durch den Ursprung.
- Die Steigung ist $I\/U = 1\/R$: Je steiler die Gerade, desto kleiner der Widerstand.

**Merksatz:** Im I-U-Diagramm: steiler bedeutet kleineres R.

Quelle: 0.2

### Was bedeuten PTC und NTC?
- **PTC (Kaltleiter):** Der Widerstand steigt mit der Temperatur.
- **NTC (Heißleiter):** Der Widerstand sinkt mit der Temperatur.

**Merksatz:** PTC: wärmer → mehr Widerstand; NTC: wärmer → weniger.

Quelle: 0.2

### Welche Form der Leistungsformel nehme ich wann?
$ P = U I = I^2 R = U^2/R $
- Ist der Strom bekannt (typisch in Reihenschaltungen), nimmt man $I^2 R$.
- Ist die Spannung bekannt (typisch parallel), $U^2\/R$.

**Merksatz:** Bekanntes I: I²R; bekanntes U: U²/R.

Quelle: 0.3

### Wie hängen Leistung, Energie und Stromkosten zusammen?
- Leistung ist Energie pro Zeit.
- $W = P dot t$, z. B. kW · h = kWh.
- Kosten = Energie × Preis pro kWh.

**Merksatz:** Leistung ist Tempo, Energie ist angesammelte Menge.

Bild: Leistung ist die Geschwindigkeit, Energie die gefahrene Strecke, die Kosten der Spritverbrauch.
Quelle: 0.3

### Was ist in einer Reihenschaltung überall gleich, und was teilt sich auf?
- Der Strom ist überall gleich.
- **Die Spannung teilt sich auf:** $U = U_1 + U_2 + dots$.
- Am größten Widerstand fällt die größte Spannung ab.
- $R_"ges" = R_1 + R_2 + dots$ ist größer als jeder einzelne.

**Merksatz:** Reihe: gleicher Strom, Spannung verteilt.

Quelle: 0.4

### Was ist in einer Parallelschaltung gleich, und was teilt sich auf?
- Die Spannung ist an jedem Zweig gleich.
- **Der Strom teilt sich auf:** $I = I_1 + I_2 + dots$, und $1\/R_"ges" = 1\/R_1 + 1\/R_2 + dots$.
- Der kleinste Widerstand bekommt den größten Strom.
- $R_"ges"$ ist kleiner als der kleinste Einzelwiderstand.
- Fällt ein Zweig aus, laufen die anderen weiter, nur der Gesamtstrom sinkt.

**Merksatz:** Parallel: gleiche Spannung, Strom verteilt.

Quelle: 0.4

### Was passiert, wenn man in einer Reihenschaltung einen Widerstand vergrößert?
- $R_"ges"$ steigt, also sinken Strom und Gesamtleistung ($P = U^2\/R_"ges"$).
- Die Quelle wird weniger belastet.

Quelle: 0.4

### Was ist ein unbelasteter Spannungsteiler, und warum gilt die Teilerregel nur ohne Last?
- Zwei Widerstände in Reihe, die Ausgangsspannung wird an R₂ abgegriffen:
$ U_2 = U dot R_2/(R_1 + R_2) $
- Das gilt nur, wenn am Ausgang kein Strom entnommen wird.
- Hängt ein Verbraucher dran, liegt er parallel zu $R_2$.
- Dann muss man erst den Parallelersatz bilden.
- Die Ausgangsspannung sinkt.

**Merksatz:** Erst die Last parallel ersetzen, dann teilen.

Quelle: 0.6
Abbildung: notiz-spannungsteiler

### Was unterscheidet eine ideale von einer realen Spannungsquelle?
- Die ideale Quelle liefert immer dieselbe Spannung, egal wie viel Strom fließt.
- Die reale hat zusätzlich einen Innenwiderstand $R_i$ in Reihe.
- Je mehr Strom fließt, desto mehr Spannung bleibt innen hängen: $U_"Klemme" = U_q - I R_i$.

**Merksatz:** Mehr Laststrom lässt mehr Spannung innen fallen.

Quelle: 0.5

### Zeichne die Begriffslandkarte zu Kapitel 0 aus dem Kopf: Welche Begriffe gehören dazu und wie hängen sie zusammen?
- Ladung ist die transportierte Größe
- Strom sagt, wie viel Ladung pro Zeit fließt.
- Spannung beschreibt Energie je Ladung, und der Widerstand verknüpft Spannung und Strom.
- Aus Spannung mal Strom folgt die Leistung, aus Leistung mal Zeit die Energie.
- Reihen- und Parallelschaltung bestimmen die Verteilung
- der Innenwiderstand erweitert die ideale zur realen Quelle.

Quelle: 0.1

## Kapitel 1 · Grundbegriffe: Strom, Spannung, Widerstand, Leistung

### Was bedeutet Q = n·e·A·l?
- **$n$:** Zahl freier Elektronen je Volumen.
- **$e$:** Ladungsbetrag je Elektron.
- **$A l$:** Volumen des betrachteten Drahtstücks.
- Zusammen: $Q = n e A l$.
- Doppelte Länge bei sonst gleichen Größen → doppelte Ladungsmenge.

Bild: Ein Rohr, das randvoll mit Murmeln gefüllt ist.
Quelle: 1.1.1
Abbildung: skript-ladung

### Was ist der Unterschied zwischen technischer und physikalischer Stromrichtung?
- Physikalisch wandern die Elektronen vom Minus- zum Pluspol.
- Die technische Stromrichtung zeigt außerhalb der Quelle von Plus nach Minus, also genau entgegengesetzt.
- In Schaltplänen nutzt man immer die technische Richtung.

**Merksatz:** Elektronen laufen entgegen dem technischen Strompfeil.

Quelle: 1.1.2
Abbildung: skript-stromrichtung

### Ist „Ah“ eine Energie?
- Nein.
- Amperestunden sind Strom × Zeit, also eine Ladung.
- Die Energie ist erst $W = U Q$, z. B. in Wh.
- Ein 12-V-Akku mit 36 Ah speichert 432 Wh.

**Merksatz:** Ah zählt Ladung; erst mit Spannung wird daraus Energie.

Quelle: 1.1.2
Abbildung: skript-akku

### Die Elektronen driften nur mit etwa 1 mm/s. Warum geht das Licht trotzdem sofort an?
- Der Draht ist schon voller Elektronen.
- Beim Einschalten breitet sich das elektrische Feld fast mit Lichtgeschwindigkeit aus, und alle Elektronen im Kreis beginnen praktisch gleichzeitig zu driften.
- Kein Elektron muss vom Schalter zur Lampe wandern.

**Merksatz:** Das Feld läuft schnell; die Elektronen driften langsam.

Bild: Ein voller Gartenschlauch: Hahn auf, und vorne kommt sofort Wasser, obwohl das Wasser vom Hahn noch lange nicht vorne ist.
Quelle: 1.1.3
Abbildung: skript-impuls

### Warum bestimmt die Stromdichte und nicht die Stromstärke die Erwärmung?
- Die Stromdichte $S = I\/A$ sagt, wie viel Strom sich durch jeden mm² quetschen muss.
- Je enger, desto mehr Reibung pro Fläche, desto heißer.
- Die dünnste Stelle wird am heißesten, darauf beruht die Schmelzsicherung.

Quelle: 1.1.5
Abbildung: querschnitt

### Ein Leiter hat links die Fläche A und rechts 2A. Was gilt rechts für Strom und Stromdichte?
- Der Strom ist gleich, denn Ladung geht nicht verloren (Kontinuität).
- Die Stromdichte halbiert sich, weil sich derselbe Strom auf die doppelte Fläche verteilt: $S_1 A_1 = S_2 A_2$.

**Merksatz:** Gleicher Strom auf mehr Fläche ergibt kleinere Stromdichte.

Quelle: 1.1.5
Abbildung: querschnitt

### Warum überträgt man Strom über weite Strecken mit Hochspannung?
- Die Leitungsverluste sind $P_V = I^2 R$.
- Bei gleicher Leistung $P = U I$ heißt hohe Spannung kleiner Strom und damit viel kleinere Verluste.
- Hochtransformieren geht nur mit Wechselstrom, deshalb hat sich Wechselstrom durchgesetzt.

Quelle: 1.1.5
Abbildung: querschnitt

### Woran erkennt man, dass Strom fließt?
- **An drei Wirkungen:**
- **Wärme:** Elektronenreibung, z. B. Wasserkocher, Sicherung.
- **Magnetfeld / Kraft:** jeder Strom erzeugt ein Magnetfeld, z. B. Elektromotor, Messgeräte.
- **Chemie:** Ionenstrom in Flüssigkeiten, z. B. Galvanisieren, Akku laden.

Quelle: 1.1.6
Abbildung: skript-lorentz

### Wovon hängt die Lorentzkraft auf einen stromdurchflossenen Leiter ab, und wann ist sie null?
- $F = I l B$ bei senkrechtem Feld.
- Mehr Strom, längerer Leiter im Feld oder stärkeres Feld geben mehr Kraft.
- Die Kraft steht senkrecht zu Strom und Feld.
- Liegt der Leiter parallel zum Feld, ist sie null.

Quelle: 1.1.6
Abbildung: skript-lorentz

### Warum dreht sich eine Leiterschleife im Magnetfeld, statt sich zu verschieben?
- Der Strom fließt auf einer Seite hin und auf der anderen zurück.
- Die beiden Lorentzkräfte zeigen deshalb in entgegengesetzte Richtungen und bilden ein Drehmoment.
- Das ist das Prinzip von Elektromotor und Drehspulinstrument.

Quelle: 1.1.6
Abbildung: skript-lorentz

### Warum hat ein Drehspulinstrument eine lineare Skala?
- Das Drehmoment der Spule ist proportional zum Strom, die Rückstellfedern halten proportional zum Winkel dagegen.
- Im Gleichgewicht ist der Ausschlag also proportional zum Strom: doppelter Strom, doppelter Ausschlag.

Quelle: 1.1.6
Abbildung: skript-drehspul

### Was ist der Unterschied zwischen Gleichstrom und Wechselstrom?
- Gleichstrom (DC) bleibt konstant, z. B. aus Batterie oder Akku.
- Wechselstrom (AC) wechselt periodisch die Richtung, im Netz mit 50 Hz, also 20 ms pro Periode.

Quelle: 1.1.7
Abbildung: stromarten

### Was ist der Effektivwert eines Wechselstroms?
- Der Gleichstromwert, der in einem Widerstand dieselbe Wärme erzeugt.
- **Bei Sinus:** $I_"eff" = hat(i)\/sqrt(2)$.
- Die 230 V der Steckdose sind ein Effektivwert, der Scheitelwert liegt bei etwa 325 V.

**Merksatz:** Effektiv heißt: gleiche Wärmewirkung.

Quelle: 1.1.7
Abbildung: stromarten

### Drei gleiche Lampen in Reihe, ein Schalter parallel zu Lampe C wird geschlossen. Was passiert?
- Schalter schließen → C wird kurzgeschlossen und erlischt.
- Gesamtwiderstand sinkt von 3R auf 2R → Strom steigt.
- A und B erhalten je die halbe statt ein Drittel der Spannung.
- Sie leuchten heller; ihre Leistung steigt jeweils auf das 2,25-Fache.
- **Reihenfolge:** $R_"ges" -> I ->$ Teilspannungen → Leistungen.

Quelle: 1.1.7.1
Abbildung: lampen

### Was muss in jeder Spannungsquelle passieren, damit eine Quellspannung entsteht?
- Ein physikalischer Effekt muss Ladungen trennen, sodass am Minuspol ein Elektronenüberschuss entsteht.
- Möglich durch Chemie (Batterie), Induktion (Generator), Temperaturdifferenz (Thermoelement), Licht (Solarzelle) oder Druck (Piezo).

Quelle: 1.2.1
Abbildung: skript-chemie

### Wie entsteht die Spannung in einer Batterie?
- Eine chemische Reaktion trennt Ladungen und erzeugt einen Elektronenüberschuss am Minuspol.
- Fließt Strom, liefert die Reaktion ständig Elektronen nach, bis die Chemie verbraucht ist.
- Umgewandelt wird chemische in elektrische Energie.

Quelle: 1.2.1
Abbildung: skript-chemie

### Was sagt das Induktionsgesetz in Worten?
- Änderung des magnetischen Flusses durch die Spule → induzierte Spannung.
$ u_i = -N (dif Phi)/(dif t) $
- Schnellere Änderung oder mehr Windungen → größerer Spannungsbetrag.
- Ein unveränderter Fluss genügt nicht: Entscheidend ist die **Änderung**.

**Merksatz:** Induktion braucht Flussänderung.

Quelle: 1.2.2
Abbildung: skript-induktion

### Was bedeutet das Minuszeichen im Induktionsgesetz (Lenzsche Regel)?
- Die induzierte Spannung treibt einen Strom, dessen Magnetfeld der Flussänderung entgegenwirkt.
- Die Spule „will, dass alles gleich bleibt“.

**Merksatz:** Lenz: Gegen die Änderung, nicht pauschal gegen das Feld.

Bild: Ein träger Mitbewohner, der sich gegen jede Veränderung stemmt.
Quelle: 1.2.2
Abbildung: skript-induktion

### Ein Magnet liegt ruhig in einer Spule. Wird eine Spannung induziert?
- Nein, der Fluss ändert sich nicht.
- Erst wenn man den Magneten oder die Spule bewegt, sodass sich der Fluss durch die Spule ändert, entsteht eine Spannung.

Quelle: 1.2.2
Abbildung: skript-induktion

### Kann in einem zeitlich konstanten Magnetfeld trotzdem eine Spannung induziert werden?
- Ja, wenn sich der Fluss durch die Spule trotzdem ändert, z. B. weil die Spule aus dem Feld gezogen oder gedreht wird.
- Entscheidend ist die Flussänderung, nicht ob sich das Feld selbst ändert.

Quelle: 1.2.2
Abbildung: skript-induktion

### Wie funktioniert ein Thermoelement, und warum reicht die Temperatur der Messstelle allein nicht?
- Zwei verschiedene Metalle (z. B. Kupfer und Konstantan) erzeugen eine Spannung, die vom **Temperaturunterschied** zwischen Messstelle und Vergleichsstelle abhängt (Seebeck-Effekt).
- Ohne die Temperatur der Vergleichsstelle weiß man also nicht, welche Spannung herauskommt.
- Sind beide gleich warm, ist die Spannung null.

**Merksatz:** Das Thermoelement vergleicht zwei Temperaturen.

Quelle: 1.2.3
Abbildung: skript-thermo

### Wie erzeugt eine Solarzelle Strom?
- Licht erzeugt im Halbleiter Elektron-Loch-Paare.
- Ein inneres elektrisches Feld trennt sie, sodass im äußeren Kreis ein Fotostrom fließt.
- Umgewandelt wird Strahlungsenergie in elektrische Energie.

Quelle: 1.2.4
Abbildung: skript-foto

### Warum hilft bei zu langer Wellenlänge mehr Licht nicht?
- Jedes Photon muss allein mindestens die Bandlücke $W$ überwinden: $h nu >= W$.
- Bei zu großer Wellenlänge ist die Energie jedes einzelnen Photons zu klein.
- Mehr Licht heißt nur mehr zu schwache Photonen.

**Merksatz:** Viele zu schwache Photonen ersetzen kein ausreichend energiereiches Photon.

Bild: Wer eine Mauer nicht überspringen kann, schafft es auch nicht, wenn hundert Leute nacheinander scheitern.
Quelle: 1.2.4.1

### Was ist der Piezoeffekt, und wie kann derselbe Effekt Sensor und Antrieb sein?
- Drückt man auf einen geeigneten Kristall, verschieben sich Ladungen, es entsteht eine Spannung (Sensor, z. B. Mikrofon).
- Umgekehrt verformt eine angelegte Spannung den Kristall (Antrieb, z. B. Ultraschall, Schwingquarz).
- Es funktioniert nur mit piezoelektrischen Kristallen in der richtigen Richtung.

Quelle: 1.2.5
Abbildung: skript-piezo

### Warum steigt der Strom in einer Spule nach dem Einschalten nur allmählich an?
- Die Spule wirkt jeder Stromänderung entgegen (Selbstinduktion).
- Der Strom wächst deshalb mit der Zeitkonstante $tau = L\/R$ an.
- Nach $tau$ ist er bei 63 %, nach $5 tau$ praktisch am Endwert.

**Merksatz:** Die Spule bremst Stromänderungen.

Bild: Wie ein träges Schwungrad: Es widersetzt sich einer schnellen Änderung, nicht einem gleichbleibenden Zustand.
Quelle: 1.2.6.1
Abbildung: rl-verlauf

### Was unterscheidet eine Diode von einem ohmschen Widerstand?
- Eine Diode leitet in Durchlassrichtung viel besser als in Sperrrichtung.
- Ihre Kennlinie ist gekrümmt, keine Ursprungsgerade.
- Sie hat also keinen überall gleichen Widerstand.
- Den Arbeitspunkt findet man als Schnittpunkt von Diodenkennlinie und Arbeitsgerade.

Quelle: 1.2.6.2
Abbildung: notiz-diode

### Zeichne die Begriffslandkarte zu Kapitel 1 aus dem Kopf: Welche Begriffe gehören dazu und wie hängen sie zusammen?
- **Ladungsbewegung → Strom; Strom je Fläche → Stromdichte.**
- Langsame Elektronendrift von rascher Feldwirkung unterscheiden.
- **Stromwirkungen:** Wärme, Kraft und chemische Veränderungen.
- **Quellen:** Chemie, Induktion, Thermo-, Foto- oder Piezoeffekt → Ladungstrennung → Quellspannung.
- **Spule:** Stromänderung; **Diode:** Arbeitspunkt beachten.
- **Potenziale:** Spannungen relativ zu einer Masse bestimmen.
- **Material und Temperatur → Widerstand; Kennlinie → nichtlineares Bauteil.**
- **Leistung über der Zeit:** die Fläche entspricht der Energie.

Quelle: 1.1.1

### Warum braucht eine Potenzialangabe einen Bezugspunkt?
- Das Potenzial ist eine Spannung gegenüber einem festgelegten Nullpunkt.
- Ohne diesen Bezug ist die Zahl nicht eindeutig.
- Wie bei Höhenangaben kann man alle Werte gemeinsam verschieben, ohne die Unterschiede zu verändern.

**Merksatz:** Potenzial braucht einen Nullpunkt, Spannung braucht zwei Punkte.

Quelle: 1.3
Abbildung: vl30-potential

### Wie hängt die Reihenfolge A–B mit dem Vorzeichen der Spannung zusammen?
- $U_(A B) = phi_A - phi_B$.
- Liegt A niedriger als B, ist dieser Wert negativ.
- Beim Vertauschen der Punktreihenfolge ändert sich nur das Vorzeichen, nicht der Betrag.

**Merksatz:** Punkte vertauschen dreht das Spannungsvorzeichen um.

Quelle: 1.3
Abbildung: vl30-bruecke

### Warum verändert ein Querwiderstand die Potenziale zweier Spannungsteiler?
- Er verbindet die vorher getrennten Abgriffe und lässt einen zusätzlichen Strom fließen.
- Dadurch ändern sich die Knotenbilanzen und die Spannungsaufteilungen.
- Die unbelasteten Potenziale sind keine starren Spannungsquellen.

Quelle: 1.3
Abbildung: vl30-bruecke

### Wie unterscheiden sich Leitwert und spezifische Leitfähigkeit?
- Der Leitwert $G = 1/R$ gehört zum konkreten Bauteil und hat die Einheit Siemens.
- Die Leitfähigkeit $kappa$ ist ein Materialwert.
- Erst Geometrie und Material zusammen liefern $G = kappa A/l$.

Quelle: 1.4.1

### Warum muss man bei einer Zweidrahtleitung Hin- und Rückleiter zählen?
- Der Strom muss auch von der Last zur Quelle zurückkehren.
- Beide Leiter haben Widerstand und verursachen Spannungsabfall.
- Die gesamte wirksame Länge ist deshalb die Summe beider Leiterlängen.

**Merksatz:** Der Strom muss hin und zurück.

Quelle: 1.4.2
Abbildung: vl30-leitung

### Bedeutet eine lineare Kennlinie auch Temperaturunabhängigkeit?
- Nein.
- Eine Ursprungsgerade beschreibt ein konstantes Verhältnis von Spannung zu Strom unter den betrachteten Bedingungen.
- Eine andere Temperatur kann den Widerstandswert ändern und zu einer anderen Geraden führen.

Quelle: 1.4.3.1

### Warum lässt eine kalte Glühwendel besonders viel Strom zu?
- **Wolfram ist ein Kaltleiter:** Sein Widerstand ist kalt kleiner und wächst beim Erwärmen.
- Bei derselben anliegenden Spannung kann deshalb unmittelbar nach dem Einschalten mehr Strom fließen.
- Feste Leistungsfaktoren aus einem konstanten Widerstandsmodell sind für echte Glühlampen nur Näherungen.

Quelle: 1.4.3.2.1
Abbildung: vl30-ptc

### Warum müssen im NTC-Exponentialmodell Kelvinwerte stehen?
- Das Modell verwendet die Kehrwerte absoluter Temperaturen.
- Celsius besitzt einen verschobenen Nullpunkt und liefert dafür andere, falsche Quotienten.
- Mit Temperaturen und B-Konstante in Kelvin wird der Exponent dimensionslos.

Quelle: 1.4.3.2.2
Abbildung: vl30-ntc

### Warum soll sich ein Messheißleiter möglichst wenig selbst erwärmen?
- Sein Widerstand soll die gesuchte äußere Temperatur abbilden.
- Eigene Verlustwärme verändert seine Temperatur zusätzlich und verfälscht damit den Messwert.
- Der Messstrom wird deshalb so gewählt, dass die Selbsterwärmung klein bleibt.

Quelle: 1.4.3.2.2

### Wie begrenzt ein Varistor eine Spannungsspitze?
- Bei hoher Spannung wird der Varistor stark leitfähig.
- Parallel zur empfindlichen Schaltung übernimmt er einen großen Anteil des Störstroms und begrenzt die Spannung.
- Ein festes, von der Spannung unabhängiges R beschreibt diesen Vorgang nicht.

Quelle: 1.4.3.2.3
Abbildung: vl30-vdr

### Was unterscheidet statischen und differenziellen Diodenwiderstand?
- Der statische Widerstand ist der Quotient $R_D = U_D/I_D$ im Arbeitspunkt.
- Der differenzielle Widerstand ist die lokale Tangente $r_e = dif U_D/dif I_D$.
- Er beschreibt nur kleine Änderungen um den gewählten Punkt
- bei einer gekrümmten Kennlinie sind beide Werte verschieden.

**Merksatz:** Statisch: vom Ursprung zum Punkt; differenziell: Tangente am Punkt.

Quelle: 1.4.3.2.4
Abbildung: vl30-tangente

### Warum ist die aus einer Lichtwellenlänge berechnete LED-Schwelle nicht automatisch die Betriebsspannung?
- Die Energiebetrachtung verknüpft die Energie eines Photons mit einer elektrischen Spannungsskala.
- Die tatsächliche Durchlassspannung bei einem bestimmten Strom folgt zusätzlich aus der elektrischen Kennlinie.
- Quelle und Last müssen gemeinsam einen passenden Arbeitspunkt liefern.

Quelle: 1.4.3.2.4.1
Abbildung: led-kennlinie-aufgabe

### Was bleibt bei der Leerlaufbetrachtung der LED-Aufgabe im Netzwerk?
- Nur die LED wird als äußere Last entfernt.
- Die drei vorgegebenen Widerstände bleiben angeschlossen
- der Parallelwiderstand gehört weiter zum unbelasteten Spannungsteiler.
- Erst beim Kurzschließen der Klemmen wird er überbrückt.

Quelle: 1.4.3.2.4.1
Abbildung: led-netzwerk

### Auf welche Leistung bezieht sich der optische LED-Wirkungsgrad?
- Auf die elektrische Leistung direkt an der LED: $P_"LED" = U_D I_D$.
- Die optische Leistung ist $P_"opt" = eta_"LED" P_"LED"$.
- Die Verlustleistungen im übrigen Netzwerk sind darin nicht enthalten.

Quelle: 1.4.3.2.4.1

### Warum begrenzt die Lastgerade die Wirkung des Basisstroms?
- Im aktiven Transistormodell steuert der Basisstrom den Kollektorstrom.
- Quelle und Lastwiderstand erlauben aber nur die Betriebspunkte auf ihrer Lastgeraden.
- Gerät der Transistor in Sättigung, kann man den Strom nicht mehr unverändert mit beta mal Basisstrom weiterrechnen.

Quelle: 1.4.3.2.5
Abbildung: vl30-transistorfeld

### Was unterscheidet Lastgerade und Verlustleistungshyperbel beim Transistor?
- Die Lastgerade beschreibt die Spannungsbilanz mit Quelle und äußerem Widerstand.
- Die Verlustleistungshyperbel verbindet Punkte gleichen Produkts $U_(C E) I_C$.
- Ein Arbeitspunkt muss zur Last passen und zugleich unter der zulässigen Verlustleistungsgrenze liegen.

Quelle: 1.4.3.2.5
Abbildung: vl30-transistorfeld

### Warum wird zu einer Temperaturdifferenz in Grad Celsius nicht 273,15 addiert?
- Die Celsius- und Kelvin-Skala unterscheiden sich durch eine feste Verschiebung.
- Beim Subtrahieren zweier Temperaturen fällt diese Verschiebung weg.
- Deshalb hat ein Temperaturanstieg in Kelvin denselben Zahlenwert wie in Grad Celsius.

Quelle: 1.4.4

### Wie liest man Energie und mittlere Leistung aus einer Leistung-Zeit-Kurve?
- Die Energie ist die Fläche unter der Kurve.
- Die mittlere Leistung ist die Höhe eines Rechtecks mit derselben Fläche und derselben Zeitbreite.
- Ein einzelner Endwert ersetzt die Fläche bei veränderlicher Leistung nicht.

**Merksatz:** Energie ist Fläche, mittlere Leistung ist passende Rechteckhöhe.

Quelle: 1.5
Abbildung: vl30-leistung

## Kapitel 2 · Kirchhoffsche Gesetze und Grundstromkreis

### Warum ist ein negativer Strom in einer Knotenrechnung kein automatischer Fehler?
- Die Strompfeile sind zunächst Bezugsrichtungen.
- Ein negativer berechneter Wert bedeutet einen Strom entgegen dem angenommenen Pfeil.
- Die Ladungsbilanz muss mit diesen Vorzeichen trotzdem aufgehen.

**Merksatz:** Negatives I heißt: entgegen dem gewählten Pfeil.

Quelle: 2.1
Abbildung: vl30-knoten

### Welche Erhaltungsidee steckt hinter dem Maschensatz?
- Nach einem geschlossenen Umlauf ist man wieder am selben Potenzial.
- Alle gezählten Spannungsanhebungen und Spannungsabfälle müssen sich deshalb im betrachteten Netzwerk ausgleichen.
- Beim Umkehren des Umlaufsinns wechseln alle Vorzeichen gemeinsam.

Quelle: 2.2
Abbildung: vl30-masche

### Warum gelten Kirchhoffs Regeln auch mit nichtlinearen Bauteilen?
- Die Regeln bilanzieren Ladung am Knoten und Spannungen im Umlauf.
- Die Nichtlinearität steckt in der Bauteilkennlinie, nicht in diesen Bilanzen.
- Kennlinien und Kirchhoffsche Gleichungen müssen zusammen erfüllt werden.

Quelle: 2.3
Abbildung: map-netzwerk

### Wie hilft ein vorgegebener Zweigstrom beim Lösen eines nichtlinearen Netzwerks?
- Du liest zuerst die zugehörige Spannung des nichtlinearen Bauteils ab und ergänzt die übrigen Abfälle des Zweigs.
- Dadurch kennst du die gemeinsame Zweigspannung.
- Über Potenziale und Knotenbilanz lassen sich die anderen Zweige Schritt für Schritt verbinden.

Quelle: 2.3
Abbildung: vl30-netzkennlinie

### Woran merkt man, dass eine reale Quelle einen Innenwiderstand haben muss?
- Bei einer idealen Quelle würde im Kurzschluss ein unendlich großer Strom fließen.
- Tatsächlich ist der Kurzschlussstrom endlich, und die Klemmenspannung sinkt unter Last.
- Irgendetwas in der Quelle begrenzt also den Strom: der Innenwiderstand $R_i$.

Quelle: 2.4.1
Abbildung: grundstromkreis

### Wie sieht das Ersatzschaltbild einer realen Quelle aus?
- Eine ideale Spannungsquelle $U_q$ mit dem Innenwiderstand $R_i$ in Reihe.
- Fließt Strom, fällt an $R_i$ die Spannung $U_i = I R_i$ ab, an den Klemmen bleibt
$ U_a = U_q - I R_i $

Quelle: 0.5

### Was passiert im Leerlauf und im Kurzschluss?
- Leerlauf ($R_a = infinity$): kein Strom, an $R_i$ fällt nichts ab, die Klemmenspannung ist maximal: $U_a = U_q$.
- Kurzschluss ($R_a = 0$): maximaler Strom $I_k = U_q\/R_i$, die Klemmenspannung ist null, die ganze Spannung fällt innen ab.

**Merksatz:** Leerlauf: Strom null. Kurzschluss: Klemmenspannung null.

Quelle: 2.4.1
Abbildung: skript-grundstromkreis

### Wo fällt die Differenz zwischen Leerlauf- und Klemmenspannung ab?
- Immer am Innenwiderstand.
- Daraus bestimmt man $R_i$:
$ R_i = (U_"Leerlauf" - U_"Klemme")/I $

Quelle: 2.4.2

### Was sagt das Verbraucherzählpfeilsystem?
- Am Verbraucher werden Strom- und Spannungspfeil gleichgerichtet gewählt.
- Bei positivem Spannungswert weist der Pfeil vom höheren zum niedrigeren Potenzial
- ein negativer Wert bezeichnet die umgekehrte tatsächliche Reihenfolge.
- Der Maschenumlauf ergibt $U_i + U_a - U_q = 0$.

Quelle: 2.4.1
Abbildung: skript-grundstromkreis

### Wie findet man den Arbeitspunkt grafisch?
- Beide Kennlinien im selben $I$-$U$-Diagramm zeichnen.
- **Quelle:** fallende Gerade von $I_k$ auf der Stromachse bis $U_q$ auf der Spannungsachse.
- **Verbraucher:** Ursprungsgerade mit Steigung $1\/R_a$.
- **Schnittpunkt:** Strom und Spannung passen dort zu Quelle und Verbraucher.

**Merksatz:** Der Schnittpunkt muss Quelle und Last zugleich passen.

Quelle: 2.4.1.1
Abbildung: zf-kennlinie

### Was passiert mit dem Arbeitspunkt, wenn R_a kleiner wird?
- Die Widerstandsgerade wird steiler, der Arbeitspunkt wandert nach links oben: mehr Strom, weniger Klemmenspannung.
- Wird $R_a$ größer, wandert er Richtung Leerlauf.

Quelle: 2.4.1.1
Abbildung: zf-kennlinie

### Welche Steigung hat die Quellenkennlinie, und was bedeutet eine steilere Kennlinie?
- Die Steigung ist $-1\/R_i$.
- Eine steilere Quellenkennlinie heißt kleinerer Innenwiderstand, also eine „steifere“ Quelle, deren Spannung unter Last weniger einbricht.

Quelle: 2.4.1.1
Abbildung: zf-kennlinie

### Wo sieht man im Kennliniendiagramm die Leistungen?
- Das Rechteck unter dem Arbeitspunkt ($U_a dot I$) ist die Verbraucherleistung.
- Das Rechteck rechts daneben bis $U_q$ ($U_i dot I$) ist die Verlustleistung in der Quelle.
- Zusammen ergeben sie die Quellenleistung.

Quelle: 2.4.1.1
Abbildung: zf-kennlinie

### Was ist Leistungsanpassung?
- Der Verbraucher bekommt die meiste Leistung, wenn $R_a = R_i$.
- Dann teilt sich die Spannung genau zur Hälfte, und der Strom ist halb so groß wie der Kurzschlussstrom.
- **Der Wirkungsgrad ist dabei nur 50 %:** Die Quelle verheizt innen genauso viel, wie beim Verbraucher ankommt.

**Merksatz:** Maximale Lastleistung heißt hier nur 50 % Wirkungsgrad.

Quelle: 2.4.3
Abbildung: skript-anpassung

### Warum gibt es bei der Verbraucherleistung ein Maximum?
- Bei $R_a = 0$ fließt viel Strom, aber die Spannung ist null, also $P = 0$.
- Bei $R_a = infinity$ ist die Spannung maximal, aber der Strom null, also wieder $P = 0$.
- Dazwischen muss ein Maximum liegen, und das liegt bei $R_a = R_i$.

Quelle: 2.4.3
Abbildung: skript-anpassung

### Wo setzt man Leistungsanpassung ein, und wo vermeidet man sie?
- In der Nachrichtentechnik (Antenne, Lautsprecher) ist sie erwünscht, dort zählt maximale Signalleistung.
- In der Energietechnik (Kraftwerk, Netz) vermeidet man sie und wählt $R_a >> R_i$, dort zählt der Wirkungsgrad.

Quelle: 2.4.3
Abbildung: skript-anpassung

### Wie hängt der Wirkungsgrad im Grundstromkreis von R_a ab?
$ eta = R_a/(R_a + R_i) $
- Im Kurzschluss ist er null.
- Je größer $R_a$ gegenüber $R_i$, desto näher an 100 %.
- Bester Wirkungsgrad und maximale Leistung sind also nicht derselbe Fall.

Quelle: 2.4.3
Abbildung: skript-anpassung

### Zeichne die Begriffslandkarte zu Kapitel 2 aus dem Kopf: Welche Begriffe gehören dazu und wie hängen sie zusammen?
- **Knotenregel:** Ladung erhalten; **Maschenregel:** Spannungsbilanz schließen.
- **Kennlinie:** nichtlineare Zweige beschreiben und Arbeitspunkt finden.
- **Ersatzschaltbild:** ideale Quellspannung, Innenwiderstand und Last verbinden.
- **Maschenumlauf:** Strom und Klemmenspannung berechnen; Kennlinienschnitt liefert denselben Arbeitspunkt.
- **Leistungsbilanz:** Quellenleistung = innere Verluste + Lastleistung.
- **Leistungsanpassung:** Außen- = Innenwiderstand → maximale Lastleistung, aber nur 50 % Wirkungsgrad.
- **Hoher Wirkungsgrad:** benötigt einen anderen Lastfall.
- **Reihe/parallel:** Spannungs- und Stromteilung; Last und Messgerät verändern die Schaltung.
- **Brücke:** gleiche Potenziale nutzen; **Stern-Dreieck/Quellenumformung:** Klemmenverhalten erhalten.

Quelle: 2.4.1

### Warum werden gleiche Quellen parallel steifer, ohne ihre Quellspannung zu erhöhen?
- Beide Quellen halten dieselbe Leerlaufspannung.
- Unter Last übernimmt jede einen Teil des Stroms, sodass ihr innerer Spannungsabfall kleiner wird.
- Im symmetrischen Modell halbiert sich bei zwei Quellen der Ersatzinnenwiderstand.
- Das setzt gleiche Parameter und passende Polung voraus.

Quelle: 2.4.1.2
Abbildung: gesamt-quellen-parallel

### Warum ist die Spannungsteilung in Reihe proportional zu den Widerständen?
- Alle Widerstände führen denselben Strom.
- Der Spannungsabfall ist jeweils Strom mal Widerstand.
- Deshalb bekommt der größere Widerstand den größeren Anteil der Gesamtspannung.
- Eine Belastung am Abgriff muss vorher in das Modell aufgenommen werden.

Quelle: 2.4.4
Abbildung: gesamt-serie

### Warum erhält der kleinere Parallelwiderstand den größeren Strom?
- An beiden Zweigen liegt dieselbe Spannung.
- Bei gleichem U führt ein kleinerer Widerstand einen größeren Strom.
- Deshalb teilen sich die Ströme proportional zu den Leitwerten und umgekehrt zu den Widerständen.

Quelle: 2.4.5
Abbildung: gesamt-parallel

### Warum ist eine halbe Schleiferstellung unter Last nicht automatisch die halbe Eingangsspannung?
- Die Last liegt parallel zum unteren Bahnabschnitt und senkt dessen wirksamen Widerstand.
- Der obere Abschnitt übernimmt dadurch mehr Spannungsabfall.
- Die ideale Proportionalität gilt nur ohne Last oder näherungsweise bei sehr kleiner Belastung.

Quelle: 2.4.6
Abbildung: gesamt-potenziometer

### Wie unterscheidest du stromrichtige und spannungsrichtige Messung?
- Spannungsrichtig misst U direkt am Prüfling, aber I enthält den Voltmeterstrom.
- Stromrichtig misst I direkt im Prüfling, aber U enthält den Amperemeterabfall.
- Wähle die Schaltung mit der kleineren Eigenverbrauchskorrektur.
- Andere Geräteunsicherheiten bleiben bestehen.

**Merksatz:** Spannungsrichtig: I mit Zusatzstrom. Stromrichtig: U mit Zusatzabfall.

Quelle: 2.4.7
Abbildung: gesamt-messung-u

### Warum kann eine lineare Stromskala bei der Pt100-Schaltung eine ungleichmäßige Temperaturskala benötigen?
- Die Sensorannahme ist zwar linear, die elektrische Übertragung enthält aber Parallelbelastung und Spannungsteilung.
- Der Instrumentenstrom steigt daher nicht automatisch proportional zur Temperatur.
- Die Skala muss nach der gesamten Stromfunktion geeicht werden.

Quelle: 2.4.8
Abbildung: gesamt-pt100

### Warum ist die Nullanzeige der Wheatstone-Brücke besonders hilfreich?
- Bei Nullanzeige haben beide Mitten dasselbe Potenzial.
- Das Messgerät führt dann keinen Querzweigstrom und belastet die Teiler an diesem Punkt nicht.
- Aus den gleichen Teilspannungen folgt das Verhältnis der Widerstände.

**Merksatz:** Brücke im Gleichgewicht: gleiche Mittenpotenziale, kein Querzweigstrom.

Quelle: 2.4.9
Abbildung: gesamt-wheatstone

### Was bleibt bei einer Stern-Dreieck-Umwandlung gleich?
- Das Verhalten an den drei äußeren Klemmen bleibt gleich, sodass sich der übrige Stromkreis gleich verhält.
- Die inneren Ströme müssen nicht gleich sein.
- Das umgewandelte Teilnetz enthält hier nur lineare Widerstände ohne Quellen.

**Merksatz:** Gleiche Klemmenwirkung heißt nicht: gleiche innere Ströme.

Quelle: 2.5.1
Abbildung: gesamt-stern-dreieck

### Warum darf eine Spannungsquelle nicht einfach an eine beliebige Stelle verschoben werden?
- Die Quelle tritt in bestimmten Maschengleichungen auf.
- Eine beliebige Verschiebung verändert diese Bilanzen.
- Eine zulässige Umformung übernimmt Wert und Polung in alle betroffenen Zweige und erhält damit das betrachtete Klemmenverhalten.

Quelle: 2.5.2
Abbildung: gesamt-quelle-verschieben-u

### Welche Erhaltungsidee begründet die gezeigte Stromquellenumformung?
- Die Knotenbilanzen bleiben erhalten.
- Die eingefügten Quellenströme gleichen sich am zusätzlichen Knoten aus, sodass der Querzweig stromlos bleibt.
- Die Vorschrift gilt für die dargestellte Topologie und passende Quellenrichtungen.

Quelle: 2.5.3
Abbildung: gesamt-quelle-verschieben-i

## Kapitel 3 · Netzwerke mit Kirchhoff systematisch berechnen

### Warum brauchst du unabhängige statt bloß viele Gleichungen?
- Eine wiederholte oder umgekehrte Gleichung enthält keine neue Information.
- Für die eindeutige Bestimmung der Unbekannten braucht das lineare System genügend unabhängige Beziehungen.
- Die letzte Knotenbilanz ist bereits in den übrigen enthalten.

Quelle: 3.1
Abbildung: gesamt-kirchhoff-allgemein

### Warum funktioniert Überlagerung für Ströme in linearen Netzen, aber nicht durch Addieren der Teilleistungen?
- Die linearen Gleichungen erlauben die Addition der Quellenwirkungen auf Ströme und Spannungen.
- Leistung enthält dagegen Produkte bzw. Quadrate.
- Die Gesamtleistung muss deshalb aus dem gesamten Strom und der gesamten Spannung berechnet werden.

**Merksatz:** Erst Ströme und Spannungen überlagern, danach Leistung berechnen.

Quelle: 3.2.1
Abbildung: gesamt-drei-zweige

### Wie kommst du von Maschenströmen zu messbaren Zweigströmen zurück?
- Du prüfst, welche Kreisströme den betreffenden Zweig durchlaufen.
- Ihre Beiträge werden passend zum festgelegten Zweigpfeil addiert oder subtrahiert.
- Ein Randzweig kann nur einen Kreisbeitrag enthalten.
- Ein gemeinsamer Zweig enthält mehrere.

Quelle: 3.2.2
Abbildung: gesamt-fuenf-widerstaende

### Wann ist ein Stromquellenstrom direkt gleich einem Maschenstrom?
- Wenn die Quelle in einem geeigneten Randzweig liegt, der nur von dieser Masche durchlaufen wird.
- In einem gemeinsamen Zweig legt sie dagegen eine Beziehung zwischen mehreren Maschenströmen fest.
- Die Quellenspannung bleibt dabei zunächst unbekannt.

Quelle: 3.2.2.1
Abbildung: gesamt-ideale-quellen-netz

### Warum reichen die Knotenpotenziale aus, um das lineare Widerstandsnetz auszuwerten?
- Jede Zweigspannung ist die Differenz der angeschlossenen Potenziale.
- Mit dem jeweiligen Widerstand folgt daraus der Zweigstrom.
- Danach lassen sich auch die Leistungen bestimmen.
- Alle Potenziale müssen denselben Bezugspunkt verwenden.

Quelle: 3.2.3
Abbildung: gesamt-knoten-netz

### Was ist der entscheidende Unterschied zwischen idealer Spannungs- und idealer Stromquelle?
- Die Spannungsquelle hält U fest, I folgt aus dem Netz.
- Die Stromquelle hält I fest, U folgt aus dem Netz.
- Reale Quellen erreichen diese Bedingungen nur innerhalb ihres Arbeitsbereichs.

**Merksatz:** Spannungsquelle hält U; Stromquelle hält I.

Quelle: 3.2.4
Abbildung: gesamt-quellen-ideal-gemischt

### Zeichne die Begriffslandkarte zu Kapitel 3 aus dem Kopf: Welche Begriffe gehören dazu und wie hängen sie zusammen?
- Knoten und Maschen liefern unabhängige Gleichungen.
- Die direkte Rechnung verwendet Zweigströme
- Überlagerung trennt Quellenwirkungen im linearen Netz.
- Maschenströme sind gedachte Kreisbeiträge, Knotenpotenziale Spannungen gegen Masse.
- Alle Methoden werden in reale Zweiggrößen übersetzt und mit den ursprünglichen Bilanzen geprüft.

Quelle: 3.1
Abbildung: map-methoden

## Kapitel 4 · Zweipoltheorie und nichtlineare Arbeitspunkte

### Warum können zwei gleichwertige Ersatzquellen intern unterschiedliche Leistungen besitzen?
- Gleichwertigkeit bezieht sich auf die äußeren Klemmen.
- Der innere Aufbau aus idealem Quellenanteil und Widerstand unterscheidet sich.
- Für ursprüngliche innere Leistungen muss die Originalschaltung ausgewertet werden.

**Merksatz:** Außen gleichwertig bedeutet innen nicht leistungsgleich.

Quelle: 4.1
Abbildung: map-zweipol

### Warum musst du vor jeder Zweipolrechnung die Last und ihre Klemmen genau festlegen?
- Nur so ist eindeutig, welcher Zweig abgetrennt wird und was im aktiven Netz bleibt.
- Ein Parallelwiderstand kann zum Quellennetz gehören, obwohl er optisch neben der Last liegt.
- Andere Klemmen liefern andere Ersatzgrößen.

Quelle: 4.2
Abbildung: gesamt-zweipol-zwei-quellen

### Warum verschwinden beim Nullsetzen der Quellen nicht auch ihre Innenwiderstände?
- Die Quelle wird als Vorgabe auf null gesetzt.
- Der Widerstand beschreibt weiterhin die lineare Verbindung im Netzwerk.
- Ihn zu entfernen würde die Struktur verändern und einen falschen Ersatzinnenwiderstand ergeben.

Quelle: 4.2.1
Abbildung: gesamt-zweipol-zwei-quellen

### Warum bedeutet Leerlauf nur Laststrom null und nicht zwangsläufig alle Ströme null?
- Der Lastzweig ist offen, aber das aktive Netz kann innere geschlossene Wege enthalten.
- Unterschiedliche Quellen können dort weiterhin Strom treiben.
- Diese inneren Ströme bestimmen mit, welche Leerlaufspannung an den Klemmen entsteht.

**Merksatz:** Offene Last heißt nicht: überall stromlos.

Quelle: 4.2.2
Abbildung: gesamt-zweipol-zwei-quellen

### Wie hilft die Beziehung zwischen Leerlaufspannung und Kurzschlussstrom beim Prüfen der Ersatzquelle?
- Bei endlichem Innenwiderstand muss ihr Quotient denselben Innenwiderstand ergeben wie der Blick in das nullgesetzte Netz.
- Die Bezugsrichtungen müssen zusammenpassen.
- Eine unabhängige zweite Rechnung findet deshalb leicht Polungs- oder Topologiefehler.

Quelle: 4.2.3
Abbildung: map-zweipol

### Warum müssen Quellen- und Lastkennlinie denselben Strom und dieselbe Spannung liefern?
- Beide beschreiben dieselben verbundenen Klemmen.
- Eine Seite kann keinen anderen stationären Strom oder eine andere Klemmenspannung als die andere besitzen.
- Der Schnittpunkt erfüllt beide Bedingungen zugleich.

Quelle: 4.3
Abbildung: map-zweipol

### Warum lässt die Zweipoltheorie eine nichtlineare Last zu, obwohl die Ersatzquelle linear ist?
- Ersetzt wird nur der lineare aktive Teil vor den Klemmen.
- Die Last bleibt mit ihrer eigenen gekrümmten Kennlinie erhalten.
- Der gemeinsame Arbeitspunkt ist der Schnitt beider Beschreibungen.

Quelle: 4.3.1
Abbildung: gesamt-kennlinien-addieren

### Warum begrenzen sowohl zu kleine als auch zu große Lastwiderstände den Konstantstrombetrieb?
- Eine kleine Last lässt viel Spannung am Transistor, sodass seine Verlustleistung zu groß werden kann.
- Eine große Last beansprucht fast die ganze Quellspannung, sodass dem Transistor zu wenig Spannung für den aktiven Bereich bleibt.
- Zwischen beiden Bedingungen liegt der nutzbare Bereich.

Quelle: 4.3.2
Abbildung: gesamt-konstantstrom-transistor

### Welche Schritte gehören zur vollständigen Beurteilung eines Zweipol-Arbeitspunkts?
- Lege Klemmen und Last fest, bestimme die Ersatzquelle und finde den gemeinsamen Arbeitspunkt.
- Danach prüfst du Kennlinienbereich und Leistungen der betroffenen Bauteile.
- Bei ursprünglichen inneren Größen gehst du zur Originalschaltung zurück.

**Merksatz:** Klemmen → Ersatzquelle → Arbeitspunkt → Leistungsprüfung.

Quelle: 4.4
Abbildung: map-zweipol

### Warum ist ein negatives Ul bei der Zweipolrechnung kein automatischer Fehler?
- Ul ist eine vorzeichenbehaftete Potenzialdifferenz.
- Ein negatives Ergebnis bedeutet eine Polung entgegen der gewählten Richtung.
- Die Quelle kann trotzdem ein passives Widerstandsnetz versorgen und besitzt hier weiterhin einen positiven Ersatzinnenwiderstand.

Quelle: 4.4.1
Abbildung: gesamt-stromquelle-symbolisch

### Wie kann ein negativer differenzieller Widerstand mit positiver Leistungsaufnahme zusammenpassen?
- Die Steigung beschreibt nur die Änderung zwischen benachbarten Arbeitspunkten.
- Die momentane Leistung hängt dagegen vom Produkt aus tatsächlicher Spannung und tatsächlichem Strom ab.
- Sind beide positiv, nimmt das Bauteil Leistung auf, auch wenn die Kennlinie lokal fällt.

Quelle: 4.4.2
Abbildung: gesamt-glimmlampe-kennlinie

### Warum darfst du eine gegebene nichtlineare Last nicht einfach auf Ra gleich Ri setzen?
- Die Kennlinie legt die möglichen Strom-Spannungs-Kombinationen der Last fest.
- Der tatsächliche Punkt muss zusätzlich zur Quellenlinie passen.
- Die Anpassungsregel gilt für eine frei variierte konstante ohmsche Last, nicht für das freie Ersetzen einer vorgegebenen gekrümmten Kennlinie.

Quelle: 4.4.3
Abbildung: gesamt-nichtlinear-lastkurve

### Warum ist die Leerlaufspannung eines LED-Speisenetzes keine feste LED-Spannung?
- Leerlauf heißt, dass die LED noch keinen Laststrom entnimmt.
- Beim Anschließen verschiebt der Laststrom die Klemmenspannung entlang der Quellenlinie.
- Der Schnitt mit der LED-Kennlinie bestimmt erst den Betriebspunkt.

Quelle: 4.4.4
Abbildung: gesamt-led-rot-netz

### Wie findest du die maximal zulässige Quellspannung im Ausgangskennlinienfeld?
- Wähle zuerst die Kurve des vorgegebenen Basisstroms.
- Bestimme ihren Schnitt mit der Verlustleistungshyperbel.
- Durch diesen Grenzpunkt verläuft die passende Lastgerade
- aus Transistorspannung plus Widerstandsabfall folgt die Quellspannung.

Quelle: 4.4.5
Abbildung: gesamt-transistor-rc-feld

### Zeichne die Begriffslandkarte zu Kapitel 4 aus dem Kopf: Welche Begriffe gehören dazu und wie hängen sie zusammen?
- Die Klemmen trennen Last und aktives Netz.
- Leerlaufspannung, Kurzschlussstrom und Innenwiderstand beschreiben die lineare Ersatzquelle.
- Die Lastkennlinie bestimmt zusammen mit der Quellenlinie den Arbeitspunkt.
- Leistungsgrenzen und Modellbereich entscheiden, ob er zulässig ist.
- Ursprüngliche innere Größen werden im Originalnetz berechnet.

Quelle: 4.1
Abbildung: map-zweipol

