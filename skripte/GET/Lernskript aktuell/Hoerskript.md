# GET · Feynman-Hörzusammenfassung

<!-- Redaktionelle Quelle für EPUB und Leseansicht. Kapitel und Abschnittsquellen folgen main.typ.
Denkpause/Auflösung sind Paare; Formeln und Einheiten werden in Worten erklärt.
Eigene Alltagsbilder dienen der Erklärung, nicht als zusätzliche Lehrquelle. -->
Stand: 06.11.2026
Skriptstand: 06.11.2026

## Das Modul auf einen Blick

Spannung treibt, Strom transportiert Ladung, Widerstand beeinflusst den Strom und Leistung beschreibt die Energie pro Zeit. Aus diesen vier Größen entsteht zuerst ein Bild einfacher Stromkreise. Danach fragen wir, wie Quellen Ladungen trennen und wie Potenziale und Kennlinien unterschiedliche Bauteile beschreiben. Knoten- und Maschenregel verbinden die Zweige eines Netzwerks. Der reale Grundstromkreis führt beides zusammen: Quelle, innere Verluste und Verbraucher müssen zu demselben Arbeitspunkt passen.

Beim Hören geht es vor allem um diese Zusammenhänge. Zeichne Schaltungen und Kennlinien beim späteren Nacharbeiten im Lernskript selbst nach. Dann kannst Du prüfen, ob Deine Erklärung auch zur konkreten Verschaltung passt.

Für Dein Selbststudium erweitert der vollständige Stand die Grundlagen um Messschaltungen, systematische Netzwerkmethoden und die Zweipoltheorie. So führt der Weg von der einzelnen Ladung bis zum zulässigen Arbeitspunkt einer nichtlinearen Last.

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
Quelle: 2.1, 2.2, 2.3, 2.4.1, 2.4.1.2, 2.4.2, 2.4.3, 2.4.4, 2.4.5, 2.4.6, 2.4.7, 2.4.8, 2.4.9, 2.5.1, 2.5.2, 2.5.3

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

### Schaltungen zuerst erkennen

In einer Reihenschaltung fließt überall derselbe Strom. Der größere Widerstand übernimmt deshalb den größeren Spannungsabfall. In parallelen Zweigen ist dagegen die Spannung gleich. Der besser leitende Zweig übernimmt mehr Strom. Entscheidend sind die angeschlossenen Knoten, nicht die Anordnung auf dem Papier.

Bei verschachtelten Netzen arbeitest Du zuerst von innen nach außen. Ersetze kleine Gruppen durch ihren Gesamtwiderstand. Bestimme dann den Gesamtstrom und gehe anschließend rückwärts zu den Teilgrößen. In der Stromteilerregel darfst Du nur den Ersatzwiderstand der gerade betrachteten Verzweigung verwenden. Ein davor liegender Widerstand gehört nicht in dieses Teilungsverhältnis.

Mehrere reale Quellen brauchen ebenfalls eine passende Verschaltung. In Reihe addieren sich die vorzeichenrichtig gezählten Quellspannungen. Die Innenwiderstände addieren sich unabhängig davon. Zwei gleiche gleich gepolte Quellen parallel behalten ihre Spannung und teilen sich die Last. Ihr gemeinsamer Innenwiderstand wird kleiner. Ungleiche Quellen können sich gegenseitig belasten; dann genügt die einfache Symmetrieregel nicht.

### Denkpause

Ein Potenziometer steht genau in der Mitte. Du schließt einen endlichen Lastwiderstand zwischen Schleifer und unterem Anschluss an. Muss am Ausgang noch die halbe Eingangsspannung liegen? Halte die Wiedergabe an und erkläre die Stromwege.

### Auflösung

Die Last liegt parallel zum unteren Teil der Widerstandsbahn. Sie verkleinert dessen wirksamen Widerstand. Dadurch übernimmt der obere Teil mehr Spannungsabfall, und die Ausgangsspannung liegt unter der Hälfte. Der Zusammenhang zwischen Schleiferstellung und Ausgangsspannung wird gekrümmt. Für eine annähernd lineare Stellkennlinie sollte die Last den Teiler nur wenig belasten. Auch der Schleiferstrom muss für die ungünstigste Stellung zulässig sein.

### Messgeräte verändern ihr Messobjekt

Ein Amperemeter benötigt einen kleinen Spannungsabfall. Ein Voltmeter zieht einen kleinen Strom. Beide Effekte können die gesuchte Widerstandsmessung beeinflussen.

Spannungsrichtig heißt: Das Voltmeter liegt direkt über dem Prüfling. Das Amperemeter misst zusätzlich den Voltmeterstrom. Ohne Korrektur ergibt Spannung geteilt durch Strom einen zu kleinen Widerstand. Stromrichtig heißt: Das Amperemeter liegt direkt im Prüflingszweig. Das Voltmeter misst den zusätzlichen Spannungsabfall am Amperemeter mit. Ohne Korrektur fällt der Widerstandswert zu groß aus.

Wähle die Anordnung, die die kleinere Eigenverbrauchskorrektur erfordert. Die Korrektur beseitigt nicht automatisch die übrigen Unsicherheiten der Instrumente. Auch die Messbereichswahl beeinflusst den Instrumentenwiderstand.

### Vom Sensor zum Nullsignal

Ein Pt100 besitzt bei null Grad Celsius einen Widerstand von hundert Ohm. Im verwendeten Modell steigt er linear mit der Temperatur. Die Anzeige muss trotzdem nicht linear mitsteigen. Der Sensor liegt parallel zum Messinstrument, und die ganze Stromaufteilung verändert sich. Eine lineare Stromskala ist deshalb nicht automatisch eine lineare Temperaturskala.

Eine Wheatstone-Brücke nutzt einen anderen Zugang. Sie vergleicht die Mitten zweier Spannungsteiler. Beim Abgleich haben beide Mitten dasselbe Potenzial. Durch das verbindende Messgerät fließt dann kein Strom. Aus dem passenden Widerstandsverhältnis wird der unbekannte Widerstand bestimmt. Eine Schleifdrahtbrücke ersetzt das Widerstandsverhältnis durch ein Längenverhältnis, wenn der Draht überall dasselbe Material und denselben Querschnitt hat.

Außerhalb des Abgleichs belastet ein reales Voltmeter die Brücke. Bei der Heißleiteraufgabe muss sein Innenwiderstand deshalb mitgerechnet werden. Die logarithmische Widerstandsskala des Heißleiters zeigt Faktoren, keine gleich großen Widerstandsschritte.

### Denkpause

Du ersetzt ein Widerstandsdreieck durch einen gleichwertigen Stern. Darfst Du den Strom eines Sternarms anschließend einfach dem Strom einer früheren Dreieckseite gleichsetzen? Begründe Deine Antwort, bevor Du weiterhörst.

### Auflösung

Die Umwandlung erhält das Verhalten an den drei äußeren Klemmen. Die inneren Verbindungen sind aber andere. Deshalb können sich auch die inneren Ströme ändern. Berechne einen gesuchten ursprünglichen Strom aus den ursprünglichen Widerständen und den erhaltenen äußeren Potenzialen zurück.

### Umformen mit einer Erhaltungsidee

Stern und Dreieck helfen, wenn Reihe und Parallel eine vermaschte Brücke nicht direkt zerlegen. Bei der Umwandlung zum Stern steht im Zähler das Produkt der beiden am äußeren Knoten anliegenden Dreieckseiten. Bei der Rückrichtung gehört der gegenüberliegende Sternarm in den Nenner. Am sichersten beschriftest Du die Klemmen zuerst, statt eine Formel nach der Zeichenposition auswendig einzusetzen.

Auch das Verschieben einer Quelle muss begründet sein. Eine Spannungsquelle wird im gezeigten Spezialfall passend in alle betroffenen Zweige übernommen, damit die Maschenbeiträge gleich bleiben. Bei der entsprechenden Stromquellenumformung heben sich die Quellenbeiträge am ergänzten Knoten auf. So bleiben die Knotenbilanzen erhalten. Diese Vorschriften gelten für die gezeigten Verbindungen und Polungen; Quellen können nicht beliebig im Netz versetzt werden.

## Kapitel 3 · Netzwerke mit Kirchhoff systematisch berechnen

Quelle: 3.1, 3.2.1, 3.2.2, 3.2.2.1, 3.2.3, 3.2.4

### Dieselbe Physik, günstigere Unbekannte

Bei einem größeren Netzwerk ist oft nicht die Physik neu, sondern die Zahl der Unbekannten. Du kannst jeden Zweigstrom einzeln berechnen. Du kannst aber auch gedachte Kreisströme oder Spannungen der Knoten gegen Masse als Unbekannte wählen. Alle Wege müssen am Ende dieselben Ströme und Spannungen liefern.

Beginne mit klaren Knoten, Zweigen und Pfeilen. In einem zusammenhängenden Netz ist eine der Knotenbilanzen bereits in den übrigen enthalten. Du brauchst unabhängige Beziehungen statt bloß möglichst vieler Gleichungen. Ergänze passende Maschenbilanzen und ordne die Unbekannten in einer festen Reihenfolge.

Die Matrix ist eine übersichtliche Schreibweise dieser Gleichungen. Bei Cramers Regel wird die Spalte des gesuchten Stroms durch die bekannte rechte Seite ersetzt. Das funktioniert nur bei einer von null verschiedenen Determinante. Die Regel von Sarrus gilt für drei Zeilen und drei Spalten; sie wird nicht einfach auf größere Matrizen verlängert.

### Die Wirkung der Quellen trennen

Überlagerung ist für lineare Netze gedacht. Lasse eine unabhängige Quelle wirken und setze die anderen auf null. Eine ideale Nullvoltquelle wird zum Draht. Eine ideale Nullstromquelle wird zur offenen Verbindung. Die zugehörigen Widerstände bleiben erhalten.

Berechne alle Teilbeiträge mit denselben Bezugspfeilen. Addiere anschließend die vorzeichenbehafteten Teilströme oder Teilspannungen. Ein negatives Ergebnis bedeutet einen Beitrag entgegen dem gewählten Pfeil. Drehe nicht mitten in der Rechnung unbemerkt die Bezugsrichtung um.

### Denkpause

Zwei Quellen erzeugen einzeln jeweils einen Strom durch denselben Widerstand. Du kennst beide Teilströme. Darfst Du die beiden einzeln berechneten Wärmeleistungen einfach addieren, um die gemeinsame Wärmeleistung zu erhalten?

### Auflösung

Nein. Die Leistung hängt vom Quadrat des gesamten Stroms ab. Beim Quadrieren einer Summe entsteht ein zusätzlicher gemischter Term. Bilde zuerst den vorzeichenrichtigen Gesamtstrom und berechne erst daraus die Leistung. Überlagerbar sind hier Ströme und Spannungen, nicht die Teilleistungen.

### Gedachte Kreisströme und reale Zweigströme

Beim Maschenstromverfahren führst Du Kreisströme als Rechenhilfen ein. Ein Widerstand am Rand gehört oft nur zu einer Masche. In einem gemeinsamen Zweig wirken mehrere Kreisbeiträge. Laufen sie entgegengesetzt durch den Widerstand, wird subtrahiert. Erst diese Summe oder Differenz ist der messbare Zweigstrom.

Die Pufferbatterie zeigt, warum die Rückübersetzung wichtig ist. Das Vorzeichen des Batteriestroms entscheidet, ob sie gerade Energie liefert oder aufnimmt. Ihre aufgedruckte Polung legt nicht allein die Stromrichtung fest.

Eine ideale Stromquelle in einer Randmasche kann einen Kreisstrom unmittelbar festlegen. Im gemeinsamen Zweig legt sie dagegen eine Beziehung zwischen zwei Kreisströmen fest. Ihre Spannung ist zunächst unbekannt und darf in einer Spannungsbilanz nicht verschwinden. Einige formale Umläufe des Originalskripts lassen diesen Beitrag aus; die ergänzte Lösung arbeitet deshalb mit den gültigen Widerstandsumläufen und den fest vorgegebenen Quellenströmen.

### Potenziale als gemeinsame Sprache

Beim Knotenpotenzialverfahren erklärst Du einen Knoten zur Masse. Jede unbekannte Knotenspannung wird gegenüber dieser Masse gemessen. Ein Widerstandsstrom folgt aus der Potenzialdifferenz seiner Anschlüsse geteilt durch den Widerstand.

Die Knotenbilanz sammelt diese Ströme. In der Leitwertmatrix stehen auf der Diagonale die angeschlossenen Leitwerte. Ein negativer Nebeneintrag verbindet zwei unbekannte Knoten über ihren gemeinsamen Zweig. Die bekannte rechte Seite enthält die Quellenströme. Aus den berechneten Potenzialen folgen danach alle Zweigspannungen und Ströme.

### Denkpause

Eine ideale Stromquelle erzwingt einen Ampere durch einen Widerstand von einem Kiloohm. In der Rechnung erscheint deshalb eine sehr hohe Spannung. Ist das allein schon ein Beweis, dass die Rechnung falsch ist? Halte die Wiedergabe an und trenne Modell und reales Bauteil.

### Auflösung

Im idealen Modell ist der Strom festgelegt, der mögliche Spannungsbereich aber nicht begrenzt. Eine hohe Spannung kann deshalb zum Modell passen. Eine reale Stromquelle erreicht dagegen nur einen begrenzten Arbeitsbereich. Die mathematische Lösung und ihre praktische Realisierbarkeit sind getrennte Prüfungen.

### Nach jeder Methode dieselben Kontrollen

Prüfe die ursprünglichen Knotenbilanzen und Maschenbilanzen. Kontrolliere die zugehörigen Potenzialdifferenzen, Einheiten und Leistungen. Ein negatives Potenzial ist lediglich eine Spannung unterhalb des gewählten Nullpunkts. Ein negativer Zweigstrom bezeichnet die Gegenrichtung zum angenommenen Pfeil.

## Kapitel 4 · Zweipoltheorie und nichtlineare Arbeitspunkte

Quelle: 4.1, 4.2, 4.2.1, 4.2.2, 4.2.3, 4.3, 4.3.1, 4.3.2, 4.4, 4.4.1, 4.4.2, 4.4.3, 4.4.4, 4.4.5

### Ein komplexes Netz von zwei Klemmen aus betrachten

Du möchtest wissen, wie sich eine bestimmte Last verhält. Lege zwei Klemmen um diesen Lastzweig und trenne ihn gedanklich ab. Das übrige lineare Netzwerk kann von diesen Klemmen aus durch eine einfache Ersatzquelle beschrieben werden.

Die Ersatzspannungsquelle besitzt eine Leerlaufspannung und einen Innenwiderstand in Reihe. Die gleichwertige Ersatzstromquelle besitzt einen eingeprägten Quellenstrom und einen Innenwiderstand parallel. Ihr Laststrom ist nicht automatisch der ganze Quellenstrom. Ein Teil kann durch den Innenwiderstand fließen.

Gleichwertig bedeutet, dass das angeschlossene äußere Netz dieselbe Strom-Spannungs-Beziehung sieht. Es bedeutet nicht, dass alle ursprünglichen inneren Ströme oder Wärmeverluste gleich bleiben.

### Drei Ersatzgrößen, zwei Rechnungen und eine Probe

Für den Innenwiderstand setzt Du unabhängige Quellen auf null. Spannungsquellen werden kurzgeschlossen, Stromquellen geöffnet. Ihre Widerstände bleiben erhalten. Schaue von den offenen Lastklemmen in das Netzwerk.

Für die Leerlaufspannung bleiben die Quellen aktiv. Nur die Last ist entfernt. Ein Parallelwiderstand im aktiven Netz bleibt angeschlossen. Auch wenn außen kein Strom fließt, können innere Quellen weiterhin Kreisströme treiben.

Der Kurzschlussstrom ist der Strom durch eine gedachte Verbindung der beiden Klemmen. Leerlaufspannung geteilt durch Innenwiderstand muss denselben Wert ergeben. Zwei korrekt bestimmte Ersatzgrößen legen die dritte fest. Kleine Abweichungen wegen gerundeter Zwischenwerte werden von echten Polungsfehlern unterschieden.

### Denkpause

Du bestimmst die Leerlaufspannung eines Netzwerks vor einer LED. Neben der LED liegt noch ein Widerstand zwischen den Ausgangsklemmen. Musst Du für den Leerlauf beide entfernen? Begründe Deine Entscheidung.

### Auflösung

Entfernt wird nur die festgelegte LED-Last. Der andere Widerstand gehört weiterhin zum aktiven Netz. Er beeinflusst dessen Leerlaufspannung und Innenwiderstand. Würdest Du ihn ebenfalls entfernen, würdest Du eine andere Ersatzquelle berechnen.

### Der Schnittpunkt verbindet Angebot und Last

Im Strom-Spannungs-Diagramm ist die Quellenkennlinie eine fallende Gerade. Am Spannungsschnittpunkt fließt kein Strom. Am Stromschnittpunkt ist die Spannung null. Dazwischen liegen alle Kombinationen, die diese Quelle einer Last anbieten kann.

Die Last besitzt ihre eigene Kennlinie. Nur ein gemeinsamer Schnitt erfüllt beide Seiten zugleich. Wenn Du die Leerlaufspannung bei gleichem Innenwiderstand änderst, verschiebt sich die Quellenlinie parallel. Wenn Du nur den Innenwiderstand bei gleicher Leerlaufspannung änderst, verändert sich ihre Steigung.

Die Last muss nicht linear sein. Eine Diode oder ein Varistor behält seine gekrümmte Kennlinie, während das speisende lineare Netz einfach wird. Bei mehreren parallelen Lasten addierst Du die Ströme zur gleichen Spannung. In einer Reihe addierst Du die Spannungen zum gleichen Strom.

### Begrenzen heißt auch Leistung aufnehmen

Ein Varistor wird bei höherer Spannung viel leitfähiger. Dadurch fällt mehr Spannung im vorgeschalteten Netz ab, und die Ausgangsspannung steigt weniger stark an. Gleichzeitig nimmt der Varistor Leistung auf. Dass er die Spannung begrenzt, beweist noch nicht, dass er den Betrieb thermisch aushält.

Bei der Basis-Emitter-Diode zeigt der Kennlinienschnitt, wie stark ein speisender Spannungsteiler belastet wird. Die Teilerspannung ohne Basisstrom ist noch nicht die tatsächliche Diodenspannung. Eine feste Durchlassspannung ist nur eine Näherung für einen bestimmten Betrieb.

### Denkpause

Die Spannung einer Glimmlampe sinkt auf einem Kennlinienabschnitt, obwohl der Strom zunimmt. Bedeutet das, dass die Lampe auf diesem Abschnitt elektrische Energie liefert?

### Auflösung

Nicht zwangsläufig. Die fallende Kennlinie bedeutet einen negativen differenziellen Widerstand: Sie beschreibt eine Änderung zwischen benachbarten Arbeitspunkten. Die tatsächliche Leistung ist Spannung mal Strom. Sind beide positiv, nimmt die Lampe weiterhin Leistung auf. Statischer Quotient, lokale Steigung und Leistung sind verschiedene Aussagen.

### Haltegrenze und Transistorgrenze

Eine Glimmlampe enthält Gas bei niedrigem Druck. Die Entladung kann Licht erzeugen, solange ihr Arbeitspunkt im passenden Haltebereich liegt. Beim Absenken der Quelle kann sie erlöschen. Zünden und Aufrechterhalten der Entladung sind dabei verschiedene Bedingungen.

Beim Transistor kommt eine andere Grenze hinzu. Der Basisstrom wählt eine Ausgangskennlinie. Der Kollektorstrom ist nur in einem geeigneten Spannungsbereich näherungsweise konstant. Die Verlustleistung ist das Produkt aus Kollektor-Emitter-Spannung und Kollektorstrom. Punkte gleicher zulässiger Leistung bilden im Diagramm eine Hyperbel.

Eine zu kleine Last lässt bei vorgegebenem Strom viel Spannung und damit viel Leistung am Transistor. Eine zu große Last beansprucht fast die gesamte Quellspannung. Dann fehlt dem Transistor Spannung für den aktiven Bereich. Die obere Lastgrenze des vereinfachten Skriptmodells mit null Volt am Transistor ist deshalb ein idealisierter Grenzfall.

Für die abschließende Verstärkeraufgabe wählst Du die Kurve des gegebenen Basisstroms und schneidest sie mit der Verlustleistungshyperbel. Der Grenzpunkt bestimmt über Transistorspannung plus Widerstandsabfall die größte zulässige Quellspannung. Die Wärmeleistung des Kollektorwiderstands wird separat geprüft.

### Denkpause

Zwei Ersatzschaltungen liefern an denselben Klemmen dieselbe Spannung und denselben Laststrom. Ist damit auch die Leistung jeder ursprünglichen inneren Quelle bekannt?

### Auflösung

Nein. Die äußere Gleichwertigkeit erhält das Klemmenverhalten. Innere Quellen und Widerstände können anders zusammengesetzt sein und andere Ströme führen. Für eine ursprüngliche innere Quellenleistung gehst Du zurück zur Originalschaltung und bestimmst dort ihre tatsächliche Spannung und ihren Strom.

Der rote Faden endet deshalb mit einer vollständigen Prüfung: Klemmen und Last wählen, Ersatzquelle bestimmen, Arbeitspunkt finden und Betriebsgrenzen kontrollieren. Mit dieser Reihenfolge kannst Du Dir die Schaltungen des ganzen Skripts selbst erschließen und anschließend ohne Vorlage erklären.
