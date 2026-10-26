# Karteikarten · technische Mechanik

<!--
So ist diese Datei aufgebaut (die Webseite liest sie beim Hochladen automatisch ein):
- "## Kapitel …" beginnt ein Kapitel (Filter auf der Webseite).
- "### Frage" ist die Vorderseite einer Karte. Alles darunter bis zur nächsten ### ist die Rückseite.
- Auf der Rückseite gehen Absätze (Leerzeile), Listen (- …), **fett** und *kursiv*.
- Eine Zeile "Bild: …" erscheint als Merkbild (Analogie im Feynman-Stil) unten auf der Karte.
- "Quelle: 1.3" (Nummer des Abschnitts im Lernskript, bei TM2 z. B. "TM2 1.6") zeigt auf der Karte die Seite im aktuellen Lernskript an. Die Seite wird beim Hochladen automatisch bestimmt.
- "Abbildung: name" zeigt ein Bild aus Typst-Dateien/abbildungen/ (Dateiname ohne Endung, wie bei #bild im Lernskript). Mehrere mit Komma trennen.
- Nur Verständnisfragen, keine Rechenaufgaben. Antworten kurz, einfach, in eigenen Worten.
- Den Fragetext nur ändern, wenn nötig: Der Lernfortschritt hängt am Wortlaut der Frage.
-->

## TM1 Kapitel 1 · Werkzeuge

### Wann nimmt man bei der Kraftzerlegung den Sinus und wann den Kosinus?
Das hängt davon ab, von welcher Achse aus der Winkel gemessen wird. Die Komponente an der Achse, an der der Winkel anliegt, bekommt den Kosinus. Die andere Komponente bekommt den Sinus. Deshalb zeichnet man den Winkel immer erst ein, bevor man zerlegt.
Quelle: 1.3
Abbildung: tm1k2_mitschrift_zerlegung

### Was ist der Hebelarm einer Kraft?
Der senkrechte Abstand zwischen der Wirkungslinie der Kraft und dem Bezugspunkt. Der Abstand zum Angriffspunkt ist nicht gemeint. Eine Kraft, deren Wirkungslinie durch den Bezugspunkt geht, erzeugt dort kein Moment.

Bild: Ein Schraubenschlüssel: Drückst du senkrecht zum Griff, dreht es am besten. Ziehst du in Richtung Schraube, dreht sich gar nichts.
Quelle: 1.4
Abbildung: tm1k01_momentdarst

### Wie viele Gleichgewichtsbedingungen hat ein starrer Körper in der Ebene?
Drei: ΣF_x = 0, ΣF_y = 0 und ΣM = 0 um einen beliebigen Punkt. Deshalb kann man pro Körper höchstens drei Unbekannte bestimmen.
Quelle: 1.4
Abbildung: tm1k01_momentdarst

### Warum reicht ΣF = 0 allein nicht für Gleichgewicht?
Zwei gleich große, entgegengesetzte Kräfte auf verschiedenen Wirkungslinien heben sich als Kräfte auf, bilden aber ein Kräftepaar. Das dreht den Körper. Erst mit ΣM = 0 ist auch die Drehung ausgeschlossen.
Quelle: 1.4
Abbildung: tm1k01_momentdarst

### Wie geht man beim Freischneiden vor?
- Den Körper gedanklich von allen Lagern und Nachbarkörpern trennen.
- An jeder Schnittstelle die Kräfte und Momente einzeichnen, die das Lager übertragen kann.
- Die Richtungen von Unbekannten frei annehmen. Ein negatives Ergebnis heißt nur, dass sie andersherum wirken.
- Alle eingeprägten Lasten einzeichnen und die Gleichgewichtsbedingungen aufstellen.
Quelle: 1.6
Abbildung: tm1k01_gerber_frei

### Was sagt actio = reactio beim Freischneiden?
An einer Schnittstelle wirken auf beide Körper gleich große, entgegengesetzte Kräfte. Sie greifen an verschiedenen Körpern an und heben sich deshalb in den Gleichgewichtsbedingungen eines einzelnen Körpers nicht auf.
Quelle: 1.6
Abbildung: tm1k01_gerber_frei

### In welche Richtung wirkt die Kraft eines Seils?
Immer als Zugkraft entlang des Seils, vom Körper weg. Ein Seil kann nicht drücken und keine Querkraft übertragen.
Quelle: 1.6

## TM1 Kapitel 4 · Streckenlasten und Schwerpunkt

### Wie ersetzt man eine Streckenlast durch eine Einzelkraft?
Die Resultierende ist so groß wie die Fläche unter dem Lastbild. Sie greift im Schwerpunkt dieser Fläche an. Bei einer Rechtecklast liegt er in der Mitte, bei einer Dreieckslast bei einem Drittel von der hohen Seite.
Quelle: 4.1
Abbildung: ak24-system

### Darf man eine Streckenlast schon vor dem Schneiden zusammenfassen?
Für die Lagerreaktionen ja. Für Schnittgrößen nicht: Liegt der Schnitt mitten in der Streckenlast, gehört zu jedem Teil nur der Teil der Last, der auf ihm liegt. Diesen Teil fasst man dann neu zusammen.
Quelle: 4.1
Abbildung: ak24-system

### Wie bestimmt man den Schwerpunkt einer zusammengesetzten Fläche?
Man zerlegt sie in einfache Teilflächen mit bekannten Schwerpunkten und bildet das flächengewichtete Mittel: x_S = Σ(A_i·x_i)/ΣA_i. Löcher und Ausschnitte zählt man als negative Flächen.
Quelle: 4.2
Abbildung: tm2k4_wzf0806_ue10

### Was hilft eine Symmetrieachse beim Schwerpunkt?
Der Schwerpunkt liegt auf jeder Symmetrieachse. Bei einer Achse muss man nur noch eine Koordinate berechnen, bei zwei Achsen liegt er im Schnittpunkt.
Quelle: 4.2
Abbildung: tm2k4_wzf0806_ue10

## TM1 Kapitel 5 · Lager und Lagerreaktionen

### Was bedeutet die Wertigkeit eines Lagers?
Die Anzahl der Reaktionen, die es übertragen kann:
- Loslager: 1 (Kraft senkrecht zur Gleitebene)
- Festlager: 2 (zwei Kräfte)
- Feste Einspannung: 3 (zwei Kräfte und ein Moment)

Bild: Ein Lager überträgt genau die Bewegungen, die es verhindert. Was es zulässt (Gleiten, Drehen), kostet nichts.
Quelle: 5.1
Abbildung: tm1k2_lager1

### Was übertragen ein Gelenk und ein Querkraftgelenk?
Ein Gelenk überträgt Kräfte in beide Richtungen, aber kein Moment. Deshalb ist dort M = 0. Ein Querkraftgelenk überträgt Normalkraft und Moment, aber keine Querkraft. Deshalb ist dort Q = 0.
Quelle: 5.1
Abbildung: tm1k2_lager1

### Was sagt die Abzählbedingung r + v = 3n, und was sagt sie nicht?
r Lagerreaktionen plus v Verbindungsreaktionen müssen der Zahl der Gleichgewichtsbedingungen (3 pro Körper) entsprechen. Das ist notwendig für statische Bestimmtheit, aber nicht hinreichend. Ein System kann die Zahl erfüllen und trotzdem beweglich sein, zum Beispiel wenn sich alle Lagerkräfte in einem Punkt schneiden oder alle parallel sind.
Quelle: 5.3.2

### Wie geht man bei einem System aus mehreren Körpern mit Gelenk vor?
Man schneidet am Gelenk auf und stellt für jeden Teilkörper die drei Gleichgewichtsbedingungen auf. Am besten beginnt man mit Momentengleichungen um Punkte, durch die viele Unbekannte gehen. Am Ende prüft man das Ergebnis am Gesamtsystem.
Quelle: 5.3.3

### Warum prüft man die Lagerreaktionen am Gesamtsystem?
Das Gesamtsystem liefert drei unabhängige Kontrollgleichungen, die man nicht zum Lösen gebraucht hat. Geht dort etwas nicht auf, steckt irgendwo ein Vorzeichen- oder Hebelarmfehler.
Quelle: 5.3.3

## TM1 Kapitel 6 · Fachwerke

### Welche Annahmen gelten für ein ideales Fachwerk?
- Die Stäbe sind gerade und gelenkig verbunden.
- Lasten greifen nur in den Knoten an.
- Das Eigengewicht der Stäbe wird vernachlässigt.

Deshalb trägt jeder Stab nur Zug oder Druck entlang seiner Achse.
Quelle: 6.1

### Was sagt die Abzählbedingung 2k = s + r beim Fachwerk?
Jeder Knoten liefert zwei Gleichgewichtsbedingungen (2k Gleichungen). Unbekannt sind s Stabkräfte und r Lagerreaktionen. Stimmen beide Zahlen überein, ist das Fachwerk notwendig statisch bestimmt. Wie bei jeder Abzählung ist das nicht hinreichend.
Quelle: 6.1

### Wie erkennt man Nullstäbe?
- Ein unbelasteter Knoten mit zwei Stäben, die nicht auf einer Linie liegen: beide Stäbe sind Nullstäbe.
- Ein unbelasteter Knoten mit drei Stäben, von denen zwei auf einer Linie liegen: der dritte ist ein Nullstab.
- Ein Knoten mit zwei Stäben, bei dem die Last in Richtung des einen Stabs wirkt: der andere ist ein Nullstab.
Quelle: 6.3.1

### Ist ein Nullstab überflüssig?
Nein. Er trägt nur bei diesem Lastfall nichts. Bei einer anderen Last kann er tragen. Außerdem stabilisiert er das Fachwerk und verkürzt die Knicklänge der Druckstäbe.
Quelle: 6.3.1

### Wo beginnt man beim Knotenpunktverfahren?
An einem Knoten mit höchstens zwei unbekannten Stabkräften, denn ein Knoten liefert nur zwei Gleichungen. Danach geht man Knoten für Knoten weiter.
Quelle: 6.3.1

### Wann verwendet man den Ritterschnitt, und wo darf man schneiden?
Wenn man nur einzelne Stabkräfte in der Mitte des Fachwerks braucht. Der Schnitt trennt das Fachwerk in zwei Teile und geht durch höchstens drei Stäbe. Diese dürfen sich nicht alle in einem Punkt schneiden und nicht alle parallel sein. Mit einer Momentengleichung um den Schnittpunkt zweier Stäbe bekommt man die dritte Stabkraft direkt.
Quelle: 6.3.3
Abbildung: ak24-fachwerk-schnitt

### Warum nimmt man unbekannte Stabkräfte zunächst als Zug an?
Damit die Vorzeichen eindeutig sind. Ist das Ergebnis positiv, ist der Stab ein Zugstab. Ist es negativ, ist er ein Druckstab. So muss man nicht vorher raten.
Quelle: 6.3.3
Abbildung: ak24-fachwerk-schnitt

## TM1 Kapitel 7 · Schnittgrößen

### Was sind N, Q und M?
Die inneren Kräfte, die ein Balken an einer Schnittstelle überträgt:
- N, die Normalkraft, wirkt entlang der Achse (Zug oder Druck).
- Q, die Querkraft, wirkt senkrecht zur Achse.
- M, das Biegemoment, biegt den Balken.
Quelle: 7.1
Abbildung: tm1k01_mitschrift_schnitt

### Wozu braucht man die gestrichelte Bezugsfaser?
Sie legt fest, wo die positive Seite ist. Ein positives Moment dehnt die Faser auf der gestrichelten Seite. Ohne Bezugsfaser wäre das Vorzeichen von M nicht eindeutig.
Quelle: 7.1
Abbildung: tm1k01_mitschrift_schnitt

### Warum zeigen die positiven Schnittgrößen an beiden Schnittufern in entgegengesetzte Richtungen?
Wegen actio = reactio: Positives und negatives Schnittufer sind zwei Seiten desselben Schnitts. Was der linke Teil auf den rechten ausübt, übt der rechte entgegengesetzt auf den linken aus.
Quelle: 7.1
Abbildung: tm1k01_mitschrift_schnitt

### Wie hängen q, Q und M zusammen?
Q′ = −q und M′ = Q. Die Streckenlast ist die negative Steigung des Querkraftverlaufs, und die Querkraft ist die Steigung des Momentenverlaufs. Ohne Streckenlast ist Q also konstant und M linear. Bei konstanter Streckenlast ist Q linear und M eine Parabel.
Quelle: 7.3

### Was passiert im Q- und M-Verlauf an einer Einzelkraft und an einem Einzelmoment?
An einer Einzelkraft springt Q um den Betrag der Kraft, und M hat einen Knick. An einem eingeprägten Einzelmoment springt M, und Q bleibt unverändert.
Quelle: 7.3

### Wo hat der Momentenverlauf sein Extremum?
Dort, wo die Querkraft null wird bzw. ihr Vorzeichen wechselt, denn M′ = Q. Das gilt auch an einem Sprung von Q über null hinweg, zum Beispiel unter einer Einzelkraft.
Quelle: 7.3

### Welche Schnittgrößen sind an einem Gelenk und an einem Querkraftgelenk bekannt?
Am Gelenk ist M = 0, am Querkraftgelenk ist Q = 0. Diese Stellen sind gute Kontrollpunkte für den Verlauf.
Quelle: 7.3

### Was passiert mit N und Q an einer rechtwinkligen Rahmenecke?
Sie tauschen die Rollen. Was im einen Stab Querkraft ist, wird im anderen Stab Normalkraft, und umgekehrt. Das Moment läuft ohne äußeres Moment unverändert um die Ecke.
Quelle: 7.3

## TM1 Kapitel 9 · Reibung

### Ist die Haftreibungskraft immer μ₀·N?
Nein. Sie stellt sich so ein, wie es das Gleichgewicht verlangt, und ist meist kleiner. μ₀·N ist nur die Obergrenze, die Haftgrenze. Erst wenn diese erreicht ist, gilt H = μ₀·N.

Bild: Wie ein Freund, der dagegenhält: Er drückt genau so stark wie du, bis seine Kraft nicht mehr reicht.
Quelle: 9.2
Abbildung: ak_ss16_klotz

### In welche Richtung zeigt die Haftreibungskraft?
Entgegen der Bewegung, die ohne Reibung eintreten würde. Ist die Richtung unklar, nimmt man sie an. Ein negatives Ergebnis heißt dann, dass sie andersherum wirkt.
Quelle: 9.2
Abbildung: ak_ss16_klotz

### Was bedeutet es, wenn die Normalkraft negativ herauskommt?
Der Kontakt müsste ziehen. Das kann eine Auflage nicht, also hebt der Körper an dieser Stelle ab. Die Annahme »liegt auf« war falsch, und man muss neu rechnen.
Quelle: 9.2
Abbildung: ak_ss16_klotz

### Wie unterscheiden sich Haftreibung und Gleitreibung?
Haftreibung wirkt, solange nichts rutscht, und passt sich bis μ₀·N an. Gleitreibung wirkt, sobald es rutscht, und ist fest R = μ·N mit μ < μ₀. Deshalb ist es schwerer, etwas loszureißen, als es in Bewegung zu halten.
Quelle: 9.2
Abbildung: ak_ss16_klotz

## TM2 Kapitel 1 · Zug, Druck und Wärmedehnung

### Was beschreiben Spannung und Dehnung?
Die Spannung σ = N/A ist die Kraft pro Fläche im Material. Die Dehnung ε ist die relative Längenänderung Δl/l. Beide machen Bauteile unterschiedlicher Größe vergleichbar.
Quelle: TM2 1.1
Abbildung: ak_stab_ax

### Woraus setzt sich die Dehnung bei Last und Temperaturänderung zusammen?
ε = σ/E + α_T·ΔT. Der erste Teil kommt aus der Kraft (Hooke), der zweite aus der Wärmedehnung. Beide addieren sich.
Quelle: TM2 1.1
Abbildung: ak_stab_ax

### Entsteht durch Erwärmung immer eine Spannung?
Nein. Kann sich der Stab frei ausdehnen, dehnt er sich nur und bleibt spannungsfrei. Erst wenn die Ausdehnung behindert wird, zum Beispiel zwischen zwei festen Wänden, entsteht Spannung. Beim Erwärmen ist das Druck, beim Abkühlen Zug.

Bild: Schienen im Sommer: Lässt man keine Lücke, drücken sie gegeneinander und verbiegen sich.
Quelle: TM2 1.4

### Was ist der Unterschied zwischen Dehnung und Verschiebung?
Die Dehnung ist lokal, also wie stark ein kleines Stück gestreckt wird. Die Verschiebung ist, wie weit sich ein Punkt bewegt. Sie ergibt sich durch Aufsummieren (Integrieren) der Dehnungen über die Länge.
Quelle: TM2 1.4

### Warum reichen bei statisch unbestimmten Systemen die Gleichgewichtsbedingungen nicht?
Es gibt mehr Unbekannte als Gleichgewichtsgleichungen. Die fehlende Gleichung liefert die Verformung: eine Verträglichkeitsbedingung, zum Beispiel »die Gesamtlänge bleibt gleich« oder »beide Stäbe verlängern sich gleich«.
Quelle: TM2 1.6

### Wie löst man ein statisch unbestimmtes Stabproblem?
- Gleichgewicht aufstellen.
- Elastizitätsgesetz für jeden Stab (mit Temperaturanteil).
- Verträglichkeitsbedingung aus der Geometrie formulieren.
- Alles zusammen nach den Unbekannten auflösen.
Quelle: TM2 1.6

### Was ist Knicken?
Ein schlanker Druckstab weicht ab einer kritischen Last seitlich aus, obwohl die Spannung noch weit unter der Festigkeit liegt. Es ist ein Stabilitätsversagen, kein Festigkeitsversagen. Deshalb prüft man schlanke Druckstäbe zusätzlich auf Knicken.
Quelle: TM2 1.6

## TM2 Kapitel 2 · Spannungszustand

### Was ist ein ebener Spannungszustand?
Alle Spannungen liegen in einer Ebene: σ_x, σ_y und τ_xy. Senkrecht dazu ist alles null. Das gilt näherungsweise für dünne Bleche und freie Oberflächen.
Quelle: TM2 2.1

### Warum hängen die Spannungen davon ab, wie man schneidet?
Spannung ist Kraft pro Schnittfläche. Dreht man die Schnittfläche, verteilt sich dieselbe innere Kraft anders auf Normal- und Schubanteil. Derselbe Spannungszustand sieht in einem gedrehten Koordinatensystem anders aus.
Quelle: TM2 2.1

### Was sind Hauptspannungen?
Die größte und die kleinste Normalspannung, die bei Drehung des Schnitts auftreten. In den Hauptrichtungen ist die Schubspannung null. Die beiden Hauptrichtungen stehen senkrecht aufeinander.
Quelle: TM2 2.2

### Wie liest man den Mohrschen Kreis?
Jeder Punkt auf dem Kreis ist ein Schnitt mit (σ, τ). Der Mittelpunkt liegt bei (σ_x + σ_y)/2. Die Schnittpunkte mit der σ-Achse sind die Hauptspannungen. Der Radius ist die größte Schubspannung in der Ebene.
Quelle: TM2 2.2.3
Abbildung: tm2k2_fs_kreis

### Warum ist der Winkel im Mohrschen Kreis doppelt so groß wie am Bauteil?
Dreht man den Schnitt um 90°, kommt man von der x- zur y-Fläche. Die liegen im Kreis gegenüber, also 180° auseinander. Jede Drehung am Bauteil erscheint im Kreis doppelt, je nach Konvention mit umgekehrtem Drehsinn.
Quelle: TM2 2.2.3
Abbildung: tm2k2_fs_kreis

### Warum kann die größte Schubspannung größer sein als der Radius des Mohrschen Kreises?
Im ebenen Spannungszustand ist die dritte Hauptspannung σ₃ = 0. Haben σ₁ und σ₂ dasselbe Vorzeichen, liegt der größte Kreis zwischen 0 und der betragsgrößten Hauptspannung. Dann ist τ_max = |σ₁|/2 und nicht (σ₁ − σ₂)/2.
Quelle: TM2 2.2

## TM2 Kapitel 3 · Verzerrungen und Hookesches Gesetz

### Was ist der Unterschied zwischen Dehnung und Gleitung?
Die Dehnung ε ändert Längen. Die Gleitung γ ändert den Winkel zwischen zwei ursprünglich senkrechten Linien, aus dem Rechteck wird ein Parallelogramm.
Quelle: TM2 3.1
Abbildung: tm2k3_reine

### Was steht beim Mohrschen Verzerrungskreis auf der senkrechten Achse?
γ/2, nicht γ. Nur mit dem halben Gleitwinkel transformieren sich die Verzerrungen genauso wie die Spannungen, und der Kreis funktioniert wie beim Spannungszustand.
Quelle: TM2 2.2.3
Abbildung: tm2k2_fs_kreis

### Warum ist ein ebener Spannungszustand kein ebener Verzerrungszustand?
Wegen der Querkontraktion. Zieht man ein Blech in der Ebene, wird es dünner, obwohl senkrecht dazu keine Spannung wirkt. Es gilt ε_z = −ν/E·(σ_x + σ_y), also ist ε_z ≠ 0.

Bild: Ein Gummiband wird beim Ziehen schmaler, obwohl niemand von der Seite drückt.
Quelle: TM2 3.2

### Was sagt das Hookesche Gesetz im ebenen Fall?
Die Dehnung in einer Richtung kommt aus der eigenen Spannung minus der Querkontraktion durch die andere: ε_x = (σ_x − ν·σ_y)/E. Die Gleitung kommt nur aus der Schubspannung: γ = τ/G.
Quelle: TM2 3.1
Abbildung: tm2k3_reine

### Wozu dient eine DMS-Rosette mit 0°, 45° und 90°?
Ein Dehnungsmessstreifen misst nur die Dehnung in seiner Richtung. Mit drei Richtungen kann man ε_x, ε_y und γ_xy bestimmen. Daraus folgen die Hauptdehnungen und mit Hooke die Spannungen.
Quelle: TM2 3.3
Abbildung: tm2k3_dms_anordnung

### Liegen Hauptspannungs- und Hauptdehnungsrichtungen gleich?
Bei isotropem Material ja. Ohne Schubspannung gibt es keine Gleitung, also sind die Richtungen ohne Schub in beiden Fällen dieselben.
Quelle: TM2 3.3
Abbildung: tm2k3_dms_anordnung

## TM2 Kapitel 4 · Biegung

### Wie ist die Biegespannung über den Querschnitt verteilt?
Linear: null in der neutralen Faser, die durch den Schwerpunkt geht, und am größten am Rand. Auf einer Seite herrscht Zug, auf der anderen Druck: σ = M/I·z.

Bild: Biegt man einen Schaumstoffbalken, wird die eine Seite länger, die andere kürzer, und in der Mitte bleibt eine Linie gleich lang.
Quelle: TM2 4.2
Abbildung: tm2k4_spannungsverlauf

### Was ist das Widerstandsmoment, und welcher Rand ist maßgebend?
W = I/z_max. Es verknüpft direkt Moment und größte Randspannung: σ_max = M/W. Maßgebend ist der Rand mit dem größten Abstand vom Schwerpunkt. Bei unsymmetrischen Profilen sind beide Ränder unterschiedlich weit weg.
Quelle: TM2 4.2
Abbildung: tm2k4_spannungsverlauf

### Warum hat das Flächenträgheitsmoment die Einheit mm⁴?
Jedes Flächenstück zählt mit dem Quadrat seines Abstands: I = ∫z² dA, also mm² · mm². Material weit außen zählt deshalb viel mehr. Das ist der Grund, warum I-Träger so effizient sind. W hat entsprechend mm³.
Quelle: TM2 4.3
Abbildung: ak24-querschnitt

### Wann braucht man den Satz von Steiner?
Wenn man das Trägheitsmoment einer Teilfläche um eine Achse braucht, die nicht durch ihren eigenen Schwerpunkt geht: I = I_eigen + a²·A. Der Steiner-Anteil ist immer positiv.
Quelle: TM2 4.3
Abbildung: ak24-querschnitt

### Was folgt aus einer Symmetrieachse für das Deviationsmoment?
Eine Symmetrieachse ist eine Hauptachse, also ist I_yz = 0. Dann biegt sich der Balken genau in der Ebene der Last, ohne schief auszuweichen.
Quelle: TM2 4.3
Abbildung: ak24-querschnitt

### Wie hängen Biegelinie und Moment zusammen?
EI·w″ = −M. Die Krümmung der Biegelinie ist proportional zum Moment. Zweimal integrieren liefert die Durchbiegung. Die Integrationskonstanten kommen aus den Randbedingungen.
Quelle: TM2 4.4

### Welche Randbedingungen gelten an Einspannung, Lager und freiem Ende?
- Einspannung: w = 0 und w′ = 0.
- Gelenkiges Lager: w = 0 und M = 0.
- Freies Ende: M = 0 und Q = 0.
Quelle: TM2 4.4

### Was braucht man, wenn die Biegelinie in Bereiche aufgeteilt ist?
Übergangsbedingungen: An der Grenze müssen Durchbiegung und Neigung von beiden Seiten gleich sein. Der Balken hat dort keinen Sprung und keinen Knick. An einem Gelenk darf die Neigung springen.
Quelle: TM2 4.4

### Was ist Superposition bei der Biegelinie?
Bei linear elastischem Verhalten darf man Lastfälle einzeln berechnen, zum Beispiel aus der Biegelinientabelle, und die Durchbiegungen addieren. Das spart das Integrieren für jeden Fall.
Quelle: TM2 4.4

## TM2 Kapitel 5 · Torsion

### Wie ist die Schubspannung bei Torsion einer Vollwelle verteilt?
Linear über den Radius: null in der Mitte, am größten am Rand: τ = M_T/I_p·r. Das Material in der Mitte trägt wenig, deshalb sind Hohlwellen leichter bei fast gleicher Tragfähigkeit.
Quelle: TM2 5.1

### Ist das Torsionsträgheitsmoment I_T immer gleich dem polaren Trägheitsmoment I_p?
Nein, nur beim Kreis- und Kreisringquerschnitt. Bei anderen Querschnitten verwölben sich die Querschnitte, und I_T ist kleiner als I_p.
Quelle: TM2 5.1

### Was ist der Schubfluss bei einem dünnwandigen geschlossenen Profil?
T = τ·t ist entlang des Umfangs konstant (Bredt). Wo die Wand dünner ist, muss τ deshalb größer sein. Die größte Schubspannung sitzt an der dünnsten Stelle.

Bild: Wasser in einem Ringkanal: Die Menge pro Sekunde ist überall gleich, an engen Stellen fließt es schneller.
Quelle: TM2 5.2
Abbildung: ak24-querschnitt

### Was ist A_m in der Bredtschen Formel?
Die Fläche, die von der Mittellinie der Wand eingeschlossen wird. Gemeint ist weder die Materialfläche noch die Innenfläche. Je größer A_m, desto steifer und tragfähiger ist das Profil gegen Torsion.
Quelle: TM2 5.2
Abbildung: ak24-querschnitt

### Wo sitzt die größte Schubspannung bei einem dünnwandigen offenen Profil?
Im dicksten Teil: τ_max = M_T/I_T·t_max. Das ist umgekehrt zum geschlossenen Profil, wo die dünnste Stelle maßgebend ist.
Quelle: TM2 5.3
Abbildung: ak_2018_torsion

### Warum verdreht sich ein geschlitztes Rohr so viel stärker als ein geschlossenes?
Im geschlossenen Profil läuft der Schubfluss einmal um den ganzen Umfang und nutzt die große eingeschlossene Fläche. Im offenen Profil fließt der Schub nur hin und zurück innerhalb der dünnen Wand. I_T schrumpft dadurch drastisch, oft um mehrere Größenordnungen.
Quelle: TM2 5.3
Abbildung: ak_2018_torsion

### Welche zwei Nachweise führt man bei Torsion?
Den Spannungsnachweis (τ_max ≤ τ_zul) und den Verformungsnachweis (Verdrehwinkel ≤ zulässig). Beide getrennt, denn ein Bauteil kann fest genug, aber zu weich sein, oder umgekehrt.
Quelle: TM2 5.1
