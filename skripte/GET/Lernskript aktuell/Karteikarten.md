# Karteikarten · GET

<!--
So ist diese Datei aufgebaut (die Webseite liest sie beim Hochladen automatisch ein):
- "## Kapitel …" beginnt ein Kapitel (Filter auf der Webseite).
- "### Frage" ist die Vorderseite einer Karte. Alles darunter bis zur nächsten ### ist die Rückseite.
- Auf der Rückseite gehen Absätze (Leerzeile), Listen (- …), **fett** und *kursiv*.
- Eine Zeile "Bild: …" erscheint als Merkbild (Analogie im Feynman-Stil) unten auf der Karte.
- Nur Verständnisfragen, keine Rechenaufgaben. Antworten kurz, einfach, in eigenen Worten.
- Den Fragetext nur ändern, wenn nötig: Der Lernfortschritt hängt am Wortlaut der Frage.
-->

## Kapitel 0 · Vorwissen

### Was ist elektrische Spannung anschaulich?
Spannung ist der „Druck“, der Ladungen in Bewegung setzen will. Sie entsteht durch Ladungstrennung zwischen Plus- und Minuspol. Ohne Spannung fließt kein Strom, egal wie gut der Leiter ist.

Bild: Wasserkreislauf: Die Spannung ist der Druckunterschied der Pumpe.

### Was ist elektrischer Strom?
Strom ist die Ladung, die pro Zeit durch den Leiterquerschnitt fließt: I = Q/t. 1 A heißt, dass pro Sekunde rund 6,25·10¹⁸ Elektronen durch den Querschnitt gehen.

Bild: Wassermenge pro Sekunde in einem Rohr.

### Welche Teilchen sind geladen, und welche bewegen sich in einem Metalldraht?
Protonen sind positiv, Elektronen negativ, Neutronen neutral. Im Metall bewegen sich nur die Elektronen. Die Protonen sitzen fest im Atomgitter.

Gleichartige Ladungen stoßen sich ab, ungleichartige ziehen sich an.

### Warum hat ein Leiter einen Widerstand, und was entsteht dabei?
Die Elektronen stoßen auf ihrem Weg ständig an die schwingenden Atome des Gitters. Diese „Reibung“ bremst den Strom, und dabei entsteht Wärme.

### Wovon hängt der Widerstand eines Drahtes ab?
R = ρ·l/A. Er wächst mit der Länge, sinkt mit dem Querschnitt, hängt vom Material (spezifischer Widerstand ρ) und von der Temperatur ab.

Halber Durchmesser gibt ein Viertel der Fläche und damit vierfachen Widerstand. Bei Hin- und Rückleiter zählt die Länge doppelt.

### Was sagt das Ohmsche Gesetz, und wie sieht es im I-U-Diagramm aus?
U = R·I. Ein linearer Widerstand ist im I-U-Diagramm eine Gerade durch den Ursprung. Die Steigung ist I/U = 1/R: Je steiler die Gerade, desto kleiner der Widerstand.

### Was bedeuten PTC und NTC?
PTC (Kaltleiter): Der Widerstand steigt mit der Temperatur.

NTC (Heißleiter): Der Widerstand sinkt mit der Temperatur.

### Welche Form der Leistungsformel nehme ich wann?
P = U·I = I²·R = U²/R. Ist der Strom bekannt (typisch in Reihenschaltungen), nimmt man I²R. Ist die Spannung bekannt (typisch parallel), U²/R.

### Wie hängen Leistung, Energie und Stromkosten zusammen?
Leistung ist Energie pro Zeit. Energie = Leistung × Zeit, z. B. kW × h = kWh. Kosten = Energie × Preis pro kWh.

Bild: Leistung ist die Geschwindigkeit, Energie die gefahrene Strecke, die Kosten der Spritverbrauch.

### Was ist in einer Reihenschaltung überall gleich, und was teilt sich auf?
Der Strom ist überall gleich. Die Spannung teilt sich auf: U = U₁ + U₂ + …. Am größten Widerstand fällt die größte Spannung ab. R_ges = R₁ + R₂ + … ist größer als jeder einzelne.

### Was ist in einer Parallelschaltung gleich, und was teilt sich auf?
Die Spannung ist an jedem Zweig gleich. Der Strom teilt sich auf: I = I₁ + I₂ + …. Der kleinste Widerstand bekommt den größten Strom. R_ges ist kleiner als der kleinste Einzelwiderstand.

Fällt ein Zweig aus, laufen die anderen weiter, nur der Gesamtstrom sinkt.

### Was passiert, wenn man in einer Reihenschaltung einen Widerstand vergrößert?
R_ges steigt, also sinken Strom und Gesamtleistung (P = U²/R_ges). Die Quelle wird weniger belastet.

### Was ist ein unbelasteter Spannungsteiler, und warum gilt die Teilerregel nur ohne Last?
Zwei Widerstände in Reihe, die Ausgangsspannung wird an R₂ abgegriffen: U₂ = U·R₂/(R₁ + R₂). Das gilt nur, wenn am Ausgang kein Strom entnommen wird.

Hängt ein Verbraucher dran, liegt er parallel zu R₂. Dann muss man erst den Parallelersatz bilden. Die Ausgangsspannung sinkt.

### Was unterscheidet eine ideale von einer realen Spannungsquelle?
Die ideale Quelle liefert immer dieselbe Spannung, egal wie viel Strom fließt. Die reale hat zusätzlich einen Innenwiderstand R_i in Reihe. Je mehr Strom fließt, desto mehr Spannung bleibt innen hängen: U_Klemme = U_q − I·R_i.

## Kapitel 1 · Strom und Quellspannung

### Was bedeutet Q = n·e·A·l?
Die Ladung in einem Drahtstück hängt davon ab, wie dicht die freien Elektronen gepackt sind (n), wie viel Ladung jedes trägt (e) und wie groß das Drahtstück ist (A·l). Doppelt so langes Stück, doppelte Ladung.

Bild: Ein Rohr, das randvoll mit Murmeln gefüllt ist.

### Was ist der Unterschied zwischen technischer und physikalischer Stromrichtung?
Physikalisch wandern die Elektronen vom Minus- zum Pluspol. Die technische Stromrichtung zeigt außerhalb der Quelle von Plus nach Minus, also genau entgegengesetzt. In Schaltplänen nutzt man immer die technische Richtung.

### Ist „Ah“ eine Energie?
Nein. Amperestunden sind Strom × Zeit, also eine Ladung. Die Energie ist erst W = U·Q, z. B. in Wh. Ein 12-V-Akku mit 36 Ah speichert 432 Wh.

### Die Elektronen driften nur mit etwa 1 mm/s. Warum geht das Licht trotzdem sofort an?
Der Draht ist schon voller Elektronen. Beim Einschalten breitet sich das elektrische Feld fast mit Lichtgeschwindigkeit aus, und alle Elektronen im Kreis beginnen praktisch gleichzeitig zu driften. Kein Elektron muss vom Schalter zur Lampe wandern.

Bild: Ein voller Gartenschlauch: Hahn auf, und vorne kommt sofort Wasser, obwohl das Wasser vom Hahn noch lange nicht vorne ist.

### Warum bestimmt die Stromdichte und nicht die Stromstärke die Erwärmung?
Die Stromdichte S = I/A sagt, wie viel Strom sich durch jeden mm² quetschen muss. Je enger, desto mehr Reibung pro Fläche, desto heißer. Die dünnste Stelle wird am heißesten, darauf beruht die Schmelzsicherung.

### Ein Leiter hat links die Fläche A und rechts 2A. Was gilt rechts für Strom und Stromdichte?
Der Strom ist gleich, denn Ladung geht nicht verloren (Kontinuität). Die Stromdichte halbiert sich, weil sich derselbe Strom auf die doppelte Fläche verteilt: S₁·A₁ = S₂·A₂.

### Warum überträgt man Strom über weite Strecken mit Hochspannung?
Die Leitungsverluste sind P_V = I²·R. Bei gleicher Leistung P = U·I heißt hohe Spannung kleiner Strom und damit viel kleinere Verluste. Hochtransformieren geht nur mit Wechselstrom, deshalb hat sich Wechselstrom durchgesetzt.

### Woran erkennt man, dass Strom fließt?
An drei Wirkungen:
- **Wärme:** Elektronenreibung, z. B. Wasserkocher, Sicherung.
- **Magnetfeld / Kraft:** jeder Strom erzeugt ein Magnetfeld, z. B. Elektromotor, Messgeräte.
- **Chemie:** Ionenstrom in Flüssigkeiten, z. B. Galvanisieren, Akku laden.

### Wovon hängt die Lorentzkraft auf einen stromdurchflossenen Leiter ab, und wann ist sie null?
F = I·l·B bei senkrechtem Feld. Mehr Strom, längerer Leiter im Feld oder stärkeres Feld geben mehr Kraft. Die Kraft steht senkrecht zu Strom und Feld. Liegt der Leiter parallel zum Feld, ist sie null.

### Warum dreht sich eine Leiterschleife im Magnetfeld, statt sich zu verschieben?
Der Strom fließt auf einer Seite hin und auf der anderen zurück. Die beiden Lorentzkräfte zeigen deshalb in entgegengesetzte Richtungen und bilden ein Drehmoment. Das ist das Prinzip von Elektromotor und Drehspulinstrument.

### Warum hat ein Drehspulinstrument eine lineare Skala?
Das Drehmoment der Spule ist proportional zum Strom, die Rückstellfedern halten proportional zum Winkel dagegen. Im Gleichgewicht ist der Ausschlag also proportional zum Strom: doppelter Strom, doppelter Ausschlag.

### Was ist der Unterschied zwischen Gleichstrom und Wechselstrom?
Gleichstrom (DC) bleibt konstant, z. B. aus Batterie oder Akku. Wechselstrom (AC) wechselt periodisch die Richtung, im Netz mit 50 Hz, also 20 ms pro Periode.

### Was ist der Effektivwert eines Wechselstroms?
Der Gleichstromwert, der in einem Widerstand dieselbe Wärme erzeugt. Bei Sinus: I_eff = î/√2. Die 230 V der Steckdose sind ein Effektivwert, der Scheitelwert liegt bei etwa 325 V.

### Drei gleiche Lampen in Reihe, ein Schalter parallel zu Lampe C wird geschlossen. Was passiert?
C wird kurzgeschlossen und erlischt, der Strom nimmt den Weg ohne Widerstand. Der Gesamtwiderstand sinkt von 3R auf 2R, der Strom steigt. A und B bekommen jetzt je die halbe statt ein Drittel der Spannung und leuchten heller (Leistung ×2,25).

Vorgehen immer: R_ges → I → Teilspannungen → Leistungen.

### Was muss in jeder Spannungsquelle passieren, damit eine Quellspannung entsteht?
Ein physikalischer Effekt muss Ladungen trennen, sodass am Minuspol ein Elektronenüberschuss entsteht. Möglich durch Chemie (Batterie), Induktion (Generator), Temperaturdifferenz (Thermoelement), Licht (Solarzelle) oder Druck (Piezo).

### Wie entsteht die Spannung in einer Batterie?
Eine chemische Reaktion trennt Ladungen und erzeugt einen Elektronenüberschuss am Minuspol. Fließt Strom, liefert die Reaktion ständig Elektronen nach, bis die Chemie verbraucht ist. Umgewandelt wird chemische in elektrische Energie.

### Was sagt das Induktionsgesetz in Worten?
Ändert sich der magnetische Fluss durch eine Spule, wird eine Spannung induziert: u_i = −N·dΦ/dt. Je schneller die Änderung und je mehr Windungen, desto größer die Spannung. Nur die **Änderung** zählt.

### Was bedeutet das Minuszeichen im Induktionsgesetz (Lenzsche Regel)?
Die induzierte Spannung treibt einen Strom, dessen Magnetfeld der Flussänderung entgegenwirkt. Die Spule „will, dass alles gleich bleibt“.

Bild: Ein träger Mitbewohner, der sich gegen jede Veränderung stemmt.

### Ein Magnet liegt ruhig in einer Spule. Wird eine Spannung induziert?
Nein, der Fluss ändert sich nicht. Erst wenn man den Magneten oder die Spule bewegt, sodass sich der Fluss durch die Spule ändert, entsteht eine Spannung.

### Kann in einem zeitlich konstanten Magnetfeld trotzdem eine Spannung induziert werden?
Ja, wenn sich der Fluss durch die Spule trotzdem ändert, z. B. weil die Spule aus dem Feld gezogen oder gedreht wird. Entscheidend ist die Flussänderung, nicht ob sich das Feld selbst ändert.

### Wie funktioniert ein Thermoelement, und warum reicht die Temperatur der Messstelle allein nicht?
Zwei verschiedene Metalle (z. B. Kupfer und Konstantan) erzeugen eine Spannung, die vom **Temperaturunterschied** zwischen Messstelle und Vergleichsstelle abhängt (Seebeck-Effekt). Ohne die Temperatur der Vergleichsstelle weiß man also nicht, welche Spannung herauskommt. Sind beide gleich warm, ist die Spannung null.

### Wie erzeugt eine Solarzelle Strom?
Licht erzeugt im Halbleiter Elektron-Loch-Paare. Ein inneres elektrisches Feld trennt sie, sodass im äußeren Kreis ein Fotostrom fließt. Umgewandelt wird Strahlungsenergie in elektrische Energie.

### Warum hilft bei zu langer Wellenlänge mehr Licht nicht?
Jedes Photon muss allein mindestens die Bandlücke W überwinden: h·ν ≥ W. Bei zu großer Wellenlänge ist die Energie jedes einzelnen Photons zu klein. Mehr Licht heißt nur mehr zu schwache Photonen.

Bild: Wer eine Mauer nicht überspringen kann, schafft es auch nicht, wenn hundert Leute nacheinander scheitern.

### Was ist der Piezoeffekt, und wie kann derselbe Effekt Sensor und Antrieb sein?
Drückt man auf einen geeigneten Kristall, verschieben sich Ladungen, es entsteht eine Spannung (Sensor, z. B. Mikrofon). Umgekehrt verformt eine angelegte Spannung den Kristall (Antrieb, z. B. Ultraschall, Schwingquarz). Es funktioniert nur mit piezoelektrischen Kristallen in der richtigen Richtung.

### Warum steigt der Strom in einer Spule nach dem Einschalten nur allmählich an?
Die Spule wirkt jeder Stromänderung entgegen (Selbstinduktion). Der Strom wächst deshalb mit der Zeitkonstante τ = L/R an. Nach τ ist er bei 63 %, nach 5τ praktisch am Endwert.

### Was unterscheidet eine Diode von einem ohmschen Widerstand?
Eine Diode leitet in Durchlassrichtung viel besser als in Sperrrichtung. Ihre Kennlinie ist gekrümmt, keine Ursprungsgerade. Sie hat also keinen überall gleichen Widerstand. Den Arbeitspunkt findet man als Schnittpunkt von Diodenkennlinie und Arbeitsgerade.

## Kapitel 2 · Grundstromkreis

### Woran merkt man, dass eine reale Quelle einen Innenwiderstand haben muss?
Bei einer idealen Quelle würde im Kurzschluss ein unendlich großer Strom fließen. Tatsächlich ist der Kurzschlussstrom endlich, und die Klemmenspannung sinkt unter Last. Irgendetwas in der Quelle begrenzt also den Strom: der Innenwiderstand R_i.

### Wie sieht das Ersatzschaltbild einer realen Quelle aus?
Eine ideale Spannungsquelle U_q mit dem Innenwiderstand R_i in Reihe. Fließt Strom, fällt an R_i die Spannung U_i = I·R_i ab, an den Klemmen bleibt U_a = U_q − U_i.

### Was passiert im Leerlauf und im Kurzschluss?
Leerlauf (R_a = ∞): kein Strom, an R_i fällt nichts ab, die Klemmenspannung ist maximal: U_a = U_q.

Kurzschluss (R_a = 0): maximaler Strom I_k = U_q/R_i, die Klemmenspannung ist null, die ganze Spannung fällt innen ab.

### Wo fällt die Differenz zwischen Leerlauf- und Klemmenspannung ab?
Immer am Innenwiderstand. Daraus bestimmt man R_i: R_i = (U_Leerlauf − U_Klemme)/I.

### Was sagt das Verbraucherzählpfeilsystem?
Am Verbraucher zeigen Strom- und Spannungspfeil in dieselbe Richtung. Spannungspfeile zeigen vom höheren zum niedrigeren Potenzial. Der Maschenumlauf ergibt U_i + U_a − U_q = 0.

### Wie findet man den Arbeitspunkt grafisch?
Man zeichnet zwei Kennlinien ins I-U-Diagramm: die Quellenkennlinie (fallende Gerade von I_k auf der Stromachse bis U_q auf der Spannungsachse) und die Widerstandsgerade des Verbrauchers (Ursprungsgerade, Steigung 1/R_a). Der Schnittpunkt ist der Arbeitspunkt: Dort passen Strom und Spannung von Quelle und Verbraucher zusammen.

### Was passiert mit dem Arbeitspunkt, wenn R_a kleiner wird?
Die Widerstandsgerade wird steiler, der Arbeitspunkt wandert nach links oben: mehr Strom, weniger Klemmenspannung. Wird R_a größer, wandert er Richtung Leerlauf.

### Welche Steigung hat die Quellenkennlinie, und was bedeutet eine steilere Kennlinie?
Die Steigung ist −1/R_i. Eine steilere Quellenkennlinie heißt kleinerer Innenwiderstand, also eine „steifere“ Quelle, deren Spannung unter Last weniger einbricht.

### Wo sieht man im Kennliniendiagramm die Leistungen?
Das Rechteck unter dem Arbeitspunkt (U_a × I) ist die Verbraucherleistung. Das Rechteck rechts daneben bis U_q (U_i × I) ist die Verlustleistung in der Quelle. Zusammen ergeben sie die Quellenleistung.

### Was ist Leistungsanpassung?
Der Verbraucher bekommt die meiste Leistung, wenn R_a = R_i. Dann teilt sich die Spannung genau zur Hälfte, und der Strom ist halb so groß wie der Kurzschlussstrom.

Der Wirkungsgrad ist dabei nur 50 %: Die Quelle verheizt innen genauso viel, wie beim Verbraucher ankommt.

### Warum gibt es bei der Verbraucherleistung ein Maximum?
Bei R_a = 0 fließt viel Strom, aber die Spannung ist null, also P = 0. Bei R_a = ∞ ist die Spannung maximal, aber der Strom null, also wieder P = 0. Dazwischen muss ein Maximum liegen, und das liegt bei R_a = R_i.

### Wo setzt man Leistungsanpassung ein, und wo vermeidet man sie?
In der Nachrichtentechnik (Antenne, Lautsprecher) ist sie erwünscht, dort zählt maximale Signalleistung. In der Energietechnik (Kraftwerk, Netz) vermeidet man sie und wählt R_a ≫ R_i, dort zählt der Wirkungsgrad.

### Wie hängt der Wirkungsgrad im Grundstromkreis von R_a ab?
η = R_a/(R_a + R_i). Im Kurzschluss ist er null. Je größer R_a gegenüber R_i, desto näher an 100 %. Bester Wirkungsgrad und maximale Leistung sind also nicht derselbe Fall.
