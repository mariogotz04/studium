# GET · Feynman-Hörzusammenfassung

<!-- Redaktionelle Quelle für EPUB und Leseansicht. Kapitel und Abschnittsquellen folgen main.typ.
Denkpause/Auflösung sind Paare; Formeln und Einheiten werden in Worten erklärt.
Eigene Alltagsbilder dienen der Erklärung, nicht als zusätzliche Lehrquelle. -->
Stand: 05.11.2026
Skriptstand: 05.11.2026

## Das Modul auf einen Blick

Spannung treibt, Strom transportiert Ladung, Widerstand beeinflusst den Strom und Leistung beschreibt die Energie pro Zeit. Aus diesen vier Größen entsteht zuerst ein Bild einfacher Stromkreise. Danach fragen wir, wie Quellen Ladungen trennen und wie Potenziale und Kennlinien unterschiedliche Bauteile beschreiben. Knoten- und Maschenregel verbinden die Zweige eines Netzwerks. Der reale Grundstromkreis führt beides zusammen: Quelle, innere Verluste und Verbraucher müssen zu demselben Arbeitspunkt passen.

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

## Kapitel 1 · Grundbegriffe: Strom, Spannung, Widerstand, Leistung
Quelle: 1.1.1, 1.1.2, 1.1.3, 1.1.5, 1.1.6, 1.1.7, 1.2.1, 1.2.2, 1.2.3, 1.2.4, 1.2.5, 1.2.6, 1.3, 1.4.1, 1.4.2, 1.4.3, 1.4.4, 1.5

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

### Potenziale sind wie Höhen mit gemeinsamem Nullpunkt

Ein Potenzial ist immer eine Spannung gegenüber einem Bezugspunkt. Stelle Dir Höhenangaben auf einer Wanderkarte vor: Du musst wissen, worauf sich null bezieht. In einer Schaltung nennen wir den gewählten Nullpunkt häufig Masse. Er muss nicht zwangsläufig am Minuspol der Quelle liegen.

Eine Spannung zwischen zwei Punkten ist ihre Potenzialdifferenz. Die Reihenfolge zählt: Spannung von A nach B bedeutet Potenzial von A minus Potenzial von B. Liegt A bei fünf und B bei acht Volt, ist die Spannung von A nach B negativ. Das Minus bedeutet keine fehlende Spannung, sondern die umgekehrte Richtung gegenüber der gewählten Reihenfolge.

Änderst Du den Bezugspunkt, verschieben sich alle Potenziale gemeinsam. Die Spannungen zwischen den Punkten bleiben gleich. Eine ideale Drahtverbindung verursacht keinen Spannungsabfall. Über einen passiven Widerstand fällt das Potenzial in Richtung des positiven technischen Stroms ab, eine Quelle kann es anheben.

### Denkpause

Zwei offene Spannungsteiler liefern an ihren Abgriffen unterschiedliche Potenziale. Du verbindest diese Abgriffe mit einem Widerstand. Darfst Du die beiden alten Potenziale weiter als fest vorgegeben betrachten?

### Auflösung

Nein. Der Querwiderstand lässt einen zusätzlichen Strom fließen und belastet die Teiler. Dadurch ändern sich die Ströme und die Spannungsabfälle in den vorher getrennten Zweigen. Die offenen Potenziale beschreiben den unbelasteten Zustand. Für die verbundene Schaltung brauchst Du die gemeinsamen Knoten- und Spannungsbilanzen.

### Material, Geometrie und Temperatur gehören zusammen

Der Widerstand eines gleichförmigen Leiters wächst mit seiner Länge und sinkt mit seiner Querschnittsfläche. Der spezifische Widerstand beschreibt dabei das Material bei einer bestimmten Temperatur. Sein Kehrwert ist die spezifische Leitfähigkeit. Der konkrete Leitwert eines Bauteils ist dagegen der Kehrwert seines konkreten Widerstands und hängt zusätzlich von der Geometrie ab.

Bei einer Leitung zur Last fließt der Strom auch zurück. Deshalb verursachen Hin- und Rückleiter beide Spannungsabfall. Eine fünfundzwanzig Meter entfernte Last mit zwei Leitern besitzt insgesamt fünfzig Meter stromdurchflossenen Draht. Die Rechnung mit dem erlaubten Spannungsabfall ist ein Auslegungsschritt; die thermische Belastbarkeit muss zusätzlich geprüft werden.

Ein ohmscher Widerstand zeigt bei festen Bedingungen eine Ursprungsgerade in der Strom-Spannungs-Kennlinie. Eine steilere Gerade bedeutet größeren Leitwert und kleineren Widerstand. Steigt die Temperatur, kann eine andere Gerade zu einem anderen Widerstandswert gehören. Linearität bedeutet deshalb nicht Temperaturunabhängigkeit.

### Die Kennlinie verrät die Widerstandsart

Ein Kaltleiter wird bei Erwärmung hochohmiger. Wolfram in der Glühwendel ist ein Beispiel: Kalt hat die Wendel einen kleineren Widerstand als im heißen Betrieb. Darum kann ihr Einschaltstrom hoch sein. Die festen Leistungsfaktoren einer einfachen Lampenrechnung setzen dagegen gleiche, unveränderte Widerstände voraus. Bei echten Glühlampen ist diese Annahme nur ein Modell.

Ein Heißleiter verhält sich anders: Sein Widerstand sinkt bei Wärme. Die Wärme kann von außen oder vom eigenen Strom kommen. Für eine Temperaturmessung soll die Selbsterwärmung klein bleiben, sonst verändert die Messung die gesuchte Temperatur. Die behandelte Exponentialgleichung verwendet absolute Temperaturen in Kelvin. Ihre Kehrwerte lassen sich nicht durch Celsiuszahlen ersetzen.

Ein Varistor reagiert stark auf die Spannung. Bei einer Spannungsspitze wird er leitfähiger und kann als paralleler Pfad einen großen Teil des Störstroms übernehmen. Bei einer Diode zählt zusätzlich die Polung. In Durchlassrichtung steigt der Strom stark an, in Sperrrichtung bleibt er vor dem Durchbruch klein. Die Spannung einer leitenden Diode ist keine für jeden Strom unveränderte feste Zahl.

### Denkpause

Eine Diode hat einen bestimmten Gleichstromarbeitspunkt. Der Quotient aus Spannung und Strom ergibt einen statischen Widerstand. Warum ist dieser Wert nicht automatisch der richtige Widerstand für eine kleine Änderung des Stroms?

### Auflösung

Der statische Quotient gehört zur Geraden vom Ursprung zum Arbeitspunkt. Eine kleine Änderung folgt dagegen der örtlichen Steigung der gekrümmten Kennlinie. Dafür verwendet man den differenziellen Widerstand, also die Tangente am Arbeitspunkt. Beide Werte können stark verschieden sein. Die Tangente gilt nur nahe dem gewählten Punkt; für größere Änderungen brauchst Du erneut die vollständige Kennlinie.

### Leuchtdiode und Transistor verbinden Bauteil und Netzwerk

Bei der Leuchtdiode liefert die Energie eines Photons eine theoretische Spannungsskala. Eine größere Wellenlänge bedeutet weniger Energie je Photon. Die tatsächliche Durchlassspannung für einen bestimmten Strom liest Du trotzdem aus der elektrischen Kennlinie ab. Der Arbeitspunkt muss zugleich zum angeschlossenen Netzwerk passen.

Für die Leerlaufspannung der LED-Aufgabe entfernst Du nur die LED. Die drei anderen Widerstände bleiben Teil des Netzwerks. Beim Kurzschließen der LED-Klemmen wird der parallele Widerstand dagegen überbrückt. Aus Leerlaufspannung und Kurzschlussstrom entsteht die Arbeitsgerade. Ihr Schnittpunkt mit der LED-Kennlinie liefert Strom und Spannung an der LED.

Der gegebene optische Wirkungsgrad bezieht sich auf die elektrische Leistung direkt an der LED. Multipliziere dafür ihre eigene Spannung mit ihrem eigenen Strom. Die gesamte Leistung der Quelle enthält zusätzlich die Verluste im übrigen Netzwerk und ist hier eine andere Bezugsgröße.

Beim Bipolartransistor kann ein kleiner Basisstrom einen größeren Kollektorstrom steuern. Die einfache Stromverstärkung gilt im passenden aktiven Bereich. Quelle und Lastwiderstand begrenzen über die Lastgerade, welche Arbeitspunkte möglich sind. Außerdem darf das Produkt aus Kollektor-Emitter-Spannung und Kollektorstrom die Verlustleistungsgrenze nicht überschreiten. Eine Lastgerade und eine Verlustleistungshyperbel beantworten deshalb verschiedene Fragen.

### Wärme, Widerstandsänderung und Energiefläche

Ein Temperaturkoeffizient beschreibt die relative Widerstandsänderung je Kelvin gegenüber einer Bezugstemperatur. Beim linearen Modell gehst Du vom Widerstand bei zwanzig Grad Celsius aus und addierst den Anteil der Temperaturänderung. Für größere Bereiche kann ein quadratischer Term nötig sein. Umgekehrt lässt eine bekannte Widerstandsänderung auf eine Temperaturänderung schließen.

Absolute Temperatur und Temperaturdifferenz sind dabei verschieden. Für einen absoluten Celsiuswert addierst Du zur Umrechnung in Kelvin zweihundertdreiundsiebzig Komma fünfzehn. Bei einer Differenz fällt diese Verschiebung weg. Ein Anstieg um achtzig Grad Celsius entspricht einem Anstieg um achtzig Kelvin.

Energie und Leistung führen alle Bauteile wieder zusammen. Die Momentanleistung entsteht aus Spannung mal Strom im selben Zeitpunkt. Bei veränderlicher Leistung ist die umgesetzte Energie die Fläche unter der Leistungskurve. Die mittlere Leistung ist die Höhe eines Rechtecks mit derselben Zeitbreite und derselben Fläche.

### Denkpause

Eine Leistung steigt während eines Zeitraums gleichmäßig von null auf ihren Endwert. Warum liefert Endleistung mal gesamte Zeit die falsche Energie?

### Auflösung

Damit würdest Du ein Rechteck unterstellen, obwohl die Leistung zu Beginn noch kleiner war. Die wirkliche Fläche ist bei diesem linearen Anstieg ein Dreieck. Ihre mittlere Höhe ist halb so groß wie der Endwert. Erst die korrekt gebildete mittlere Leistung darfst Du mit der gesamten Zeit multiplizieren.


## Kapitel 2 · Kirchhoffsche Gesetze und Grundstromkreis
Quelle: 2.1, 2.2, 2.3, 2.4.1, 2.4.2, 2.4.3

### Die Bilanzen verbinden die Zweige

An einem Knoten bleibt elektrische Ladung erhalten. Im stationären Netzwerk sammelt sich dort keine Ladung an. Deshalb muss insgesamt genauso viel Strom zufließen wie abfließen. Du legst für jeden unbekannten Strom zunächst einen Pfeil fest. Liefert die Rechnung einen negativen Wert, fließt der Strom tatsächlich entgegen diesem Pfeil. Das Vorzeichen ist eine Richtungsinformation.

Eine Masche ist ein geschlossener Weg durch die Schaltung. Kehrst Du zum selben Punkt zurück, bist Du wieder beim selben Potenzial. Die vorzeichenrichtig gezählten Spannungsbeiträge müssen sich deshalb zu null addieren. Du darfst den Umlaufsinn frei wählen, musst ihn anschließend aber konsequent verwenden. Ein anderer Umlaufsinn kehrt alle Vorzeichen gemeinsam um und verändert die physikalische Lösung nicht.

### Denkpause

Ein Zweig enthält ein nichtlineares Bauteil. Darfst Du deshalb Knoten- und Maschenregel nicht mehr benutzen? Was brauchst Du zusätzlich?

### Auflösung

Die beiden Bilanzen gelten im behandelten Netzwerk weiterhin. Die Nichtlinearität steckt im Zusammenhang zwischen Strom und Spannung des Bauteils. Deshalb brauchst Du zusätzlich seine Kennlinie oder eine passende Bauteilgleichung. Alle Beziehungen müssen gemeinsam erfüllt werden.

### Ein bekannter Zweig als Einstieg

In der behandelten Dreizweigaufgabe ist ein Strom vorgegeben. Beginne mit diesem Zweig und lies an seiner Kennlinie die zugehörige Spannung ab. Ergänze die ohmschen Spannungsabfälle des Zweigs. Damit kennst Du die Spannung zwischen den gemeinsamen Knoten.

Diese gemeinsame Spannung verbindet die anderen Zweige. Aus Quellenpolung und Potenzialdifferenzen findest Du weitere Bauteilspannungen. Ihre Kennlinien liefern die zugehörigen Ströme. Die Knotenbilanz und die Maschenbilanzen kontrollieren das Ergebnis. Erst danach berechnest Du die Leistungen mit den tatsächlich zugehörigen Bauteilspannungen und -strömen.


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
