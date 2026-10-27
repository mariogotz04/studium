# GET · Feynman-Hörzusammenfassung

<!-- Redaktionelle Quelle für EPUB und Leseansicht. Kapitel und Abschnittsquellen folgen main.typ.
Denkpause/Auflösung sind Paare; Formeln und Einheiten werden in Worten erklärt.
Eigene Alltagsbilder dienen der Erklärung, nicht als zusätzliche Lehrquelle. -->
Stand: 27.10.2026
Skriptstand: 27.10.2026

## Das Modul auf einen Blick

Spannung treibt, Strom transportiert Ladung, Widerstand beeinflusst den Strom und Leistung beschreibt die Energie pro Zeit. Aus diesen vier Größen entsteht zuerst ein Bild einfacher Stromkreise. Danach fragen wir, wie Quellen Ladungen trennen. Der reale Grundstromkreis führt beides zusammen: Quelle, innere Verluste und Verbraucher müssen zu demselben Arbeitspunkt passen.

Beim Hören geht es vor allem um diese Zusammenhänge. Zeichne Schaltungen und Kennlinien beim späteren Nacharbeiten im Lernskript selbst nach. Dann kannst Du prüfen, ob Deine Erklärung auch zur konkreten Verschaltung passt.

## Kapitel 0 · Vorwissen: Strom, Spannung, Widerstand, Leistung
Quelle: 0.1, 0.2, 0.3, 0.4, 0.5, 0.6

### Vier Größen, vier Fragen

Die Ladung sagt, was transportiert wird. Die Stromstärke sagt, wie viel Ladung pro Zeit einen Querschnitt passiert. Die Spannung beschreibt Energie je Ladung. Ein hilfreiches, begrenztes Bild ist ein Wasserkreislauf: Der Druckunterschied ähnelt der Spannung, die Wassermenge pro Zeit dem Strom und eine Engstelle dem Widerstand. Elektrische Ladung wird im Verbraucher aber nicht verbraucht.

Beim ohmschen Widerstand gilt: Spannung ist Widerstand mal Stromstärke. Wenn derselbe Widerstand an einer größeren Spannung liegt, fließt ein größerer Strom. Der Widerstand eines Drahts hängt außerdem von Material, Länge und Querschnitt ab. Ein längerer Draht bietet mehr Widerstand, ein größerer Querschnitt weniger.

Die elektrische Leistung ist Spannung mal Stromstärke. Energie ergibt sich bei konstanter Leistung aus Leistung mal Zeit. Ampere-Stunden beschreiben Ladung; Wattstunden beschreiben Energie. Schon die Einheit hilft Dir, beide Fragen auseinanderzuhalten.

### Die Verschaltung entscheidet

In einer Reihenschaltung fließt durch alle Bauteile derselbe Strom, und die Teilspannungen addieren sich. In einer Parallelschaltung liegt an allen Zweigen dieselbe Spannung, und die Teilströme addieren sich. Ein unbelasteter Spannungsteiler ist eine Reihenschaltung mit einem offenen Abgriff. Sobald am Ausgang ein Verbraucher angeschlossen ist, verändert dieser die Schaltung.

### Denkpause

Warum darfst Du die Formel für einen unbelasteten Spannungsteiler nicht einfach unverändert benutzen, nachdem Du am Ausgang einen Verbraucher angeschlossen hast?

### Auflösung

Der Verbraucher liegt parallel zu einem Teil des Spannungsteilers. Damit ändert sich dessen wirksamer Widerstand und die Aufteilung der Spannungen. Über den Abgriff fließt jetzt zusätzlicher Strom. Du musst deshalb die tatsächlich angeschlossene Schaltung auswerten.

Auch eine reale Spannungsquelle lässt sich nicht allein durch ihre Leerlaufspannung beschreiben. Ihr Innenwiderstand verursacht unter Last einen inneren Spannungsabfall. Diesen Gedanken brauchen wir in Kapitel zwei wieder.

## Kapitel 1 · Grundbegriffe: Strom und Quellspannung
Quelle: 1.1.1, 1.1.2, 1.1.3, 1.1.5, 1.1.6, 1.1.7, 1.2.1, 1.2.2, 1.2.3, 1.2.4, 1.2.5, 1.2.6

### Was im Leiter geschieht

Im Metall tragen bewegliche Elektronen den Strom. Ihre Bewegung ist der technischen Stromrichtung entgegengesetzt. Die Elektronen driften vergleichsweise langsam. Dass eine Lampe rasch reagiert, liegt an der schnellen Vermittlung durch das elektrische Feld, nicht daran, dass ein einzelnes Elektron erst den ganzen Weg vom Schalter zur Lampe zurücklegt.

Die Stromdichte ist die Stromstärke geteilt durch den Leiterquerschnitt. Derselbe Strom verteilt sich in einem dünneren Abschnitt auf weniger Fläche. Die Stromdichte und das Material sind deshalb wichtig für die thermische Beanspruchung. Strom erkennen wir an seinen Wirkungen: Wärme, magnetischen Kräften und chemischem Materialtransport. Beim Drehspulinstrument wird beispielsweise die Kraftwirkung in einen Zeigerausschlag übersetzt.

### Wo die Quellspannung herkommt

Eine Quelle trennt Ladungen unter Einsatz anderer Energie. In Batterie und Akku wirken chemische Vorgänge. Beim Generator entsteht Spannung durch eine Änderung des magnetischen Flusses. Entscheidend ist die Änderung, nicht allein die Anwesenheit eines Magneten. Die Induktionswirkung wirkt der verursachenden Flussänderung entgegen.

Ein Thermoelement reagiert auf eine Temperaturdifferenz zwischen Mess- und Vergleichsstelle. Licht kann in einer Solarzelle Elektron-Loch-Paare erzeugen, die ein inneres Feld trennt. Im behandelten Bandlückenmodell muss die Energie eines einzelnen Photons dafür ausreichen. Beim direkten Piezoeffekt erzeugt mechanische Verformung eine elektrische Spannung; der umgekehrte Effekt verformt den Kristall durch elektrische Spannung.

### Denkpause

Warum hilft bei Licht mit zu großer Wellenlänge im einfachen Bandlückenmodell auch eine höhere Lichtstärke nicht dabei, die nötige Energie eines einzelnen Photons zu erreichen?

### Auflösung

Die Energie eines einzelnen Photons hängt von seiner Frequenz und damit von seiner Wellenlänge ab. Mehr Licht liefert mehr Photonen, macht aber das einzelne Photon nicht energiereicher. Ist dessen Energie zu klein, fehlt weiterhin die nötige Schwellenenergie. Das ist die Modellgrenze, nicht die Behauptung einer ideal rechteckigen Empfindlichkeitskurve realer Bauteile.

### Bauteile reagieren unterschiedlich

Eine Spule widersetzt sich einer Änderung ihres Stroms. Bei der Diode ist die Strom-Spannungs-Kennlinie gekrümmt; ihr Arbeitspunkt muss zur Quelle und zum angeschlossenen Widerstand passen. Das verbindet die Quelleneffekte mit der Schaltungsbetrachtung im nächsten Kapitel.

## Kapitel 2 · Der Grundstromkreis
Quelle: 2.4.1, 2.4.2, 2.4.3

### Quelle und Last als gemeinsames Modell

Stell Dir eine Batterie als ideale Spannungsquelle mit einem zusätzlichen inneren Widerstand vor. Der Verbraucher ist der Außenwiderstand. Derselbe Strom fließt durch beide Widerstände. Die Quellspannung verteilt sich auf den inneren Spannungsabfall und die Klemmenspannung am Verbraucher.

Im Leerlauf fließt kein Strom. Deshalb fällt innen keine Spannung ab, und die Klemmenspannung entspricht der Quellspannung. Beim Kurzschluss ist die äußere Spannung null. Der Innenwiderstand begrenzt dann den Strom. Zwischen diesen Grenzfällen liegt der Arbeitspunkt. Er lässt sich berechnen oder als Schnittpunkt der Quellenkennlinie mit der Verbraucherkennlinie finden.

### Leistung ist nicht dasselbe wie Wirkungsgrad

Die von der Quelle bereitgestellte Leistung teilt sich in innere Verlustleistung und Verbraucherleistung. Der Wirkungsgrad beschreibt den Anteil, der den Verbraucher erreicht. Im behandelten Widerstandsmodell ist die Verbraucherleistung maximal, wenn Außen- und Innenwiderstand gleich groß sind. Das nennt man Leistungsanpassung. Dabei wird innen genauso viel Leistung umgesetzt wie außen, der Wirkungsgrad beträgt also fünfzig Prozent.

### Denkpause

Warum ist Leistungsanpassung nicht gleichzeitig der Fall mit dem besten Wirkungsgrad? Was passiert, wenn der Außenwiderstand gegenüber dem Innenwiderstand sehr groß wird?

### Auflösung

Bei gleichen Widerständen geht die Hälfte der Leistung innen verloren. Ein deutlich größerer Außenwiderstand erhält einen größeren Anteil der Quellspannung, und der Wirkungsgrad steigt. Gleichzeitig wird der Strom kleiner. Im Grenzfall des Leerlaufs ist die Verbraucherleistung trotz hoher Klemmenspannung null. Maximaler Anteil und maximaler Leistungsbetrag sind verschiedene Ziele.

Erkläre eine neue Schaltung deshalb immer in dieser Reihenfolge: Ersatzmodell, Strom und Spannungen, Leistungsbilanz und erst dann die Bewertung des gewünschten Betriebszustands.
