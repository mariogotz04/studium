<!--
Quiz zum Lernskript (erscheint auf der Lernwebseite unter „Lernen“ → Quiz). Aufbau:

## Kapitel …                Kapitelüberschrift, gruppiert die Fragen
### Fragetext               eine Frage; ___ markiert eine Lücke im Satz
- [x] richtige Option       Auswahlfrage: genau ein [x] = Einfachauswahl, mehrere [x] = Mehrfachauswahl
- [ ] falsche Option
  > Erklärung zur Option    für JEDE Option: warum sie stimmt bzw. welcher Denkfehler dahintersteckt
Antwort: a | b/c            Lücke: eine Antwort je ___ (mit | getrennt), Alternativen mit /
Antwort: Musterantwort      Freitext (ohne Optionen und ohne ___): Musterlösung zum Vergleich
Tipp: …                     Hinweis, den man vor dem Antworten aufklappen kann
Erklärung: …                wird nach dem Antworten gezeigt
Quelle: 1.2                 Abschnittsnummer im Lernskript (wird zur Seitenzahl verlinkt)

Formeln in $…$ (Typst-Mathe, Dezimalzahlen in Anführungszeichen: $"0,5"$), **fett**, *kursiv*.
Falsche Optionen sollen plausibel sein und einen typischen Denkfehler treffen.
-->

## Kapitel 0 · Vorwissen: Strom, Spannung, Widerstand, Leistung

### Ein Kupferdraht wird durch einen Draht mit halbem Durchmesser ersetzt, Länge und Material bleiben gleich. Wie ändert sich sein Widerstand?
- [ ] Er verdoppelt sich.
  > Das wäre richtig, wenn der Widerstand vom Durchmesser abhinge. Er hängt aber vom Querschnitt ab, und der geht mit $d^2$.
- [ ] Er halbiert sich.
  > Ein dünnerer Draht hat mehr Widerstand, nicht weniger. Hier ist die Richtung vertauscht.
- [x] Er vervierfacht sich.
  > Halber Durchmesser gibt ein Viertel des Querschnitts ($A = pi\/4 d^2$). Wegen $R = rho l\/A$ wird der Widerstand viermal so groß.
- [ ] Er bleibt gleich, weil das Material gleich bleibt.
  > Das Material bestimmt nur $rho$. Länge und Querschnitt gehen zusätzlich ein.
Tipp: Schreib $R = rho l\/A$ auf und überleg, was mit $A$ passiert, wenn $d$ halb so groß wird.
Quelle: 0.2

### In einer Reihenschaltung aus zwei Widerständen ist ___ überall gleich, in einer Parallelschaltung ___.
Antwort: der Strom/Strom | die Spannung/Spannung
Tipp: In der Reihe gibt es nur einen Weg für die Ladung, parallel liegen alle Zweige an denselben zwei Knoten.
Erklärung: Reihenschaltung: ein einziger Strompfad, also derselbe Strom; die Spannung teilt sich auf. Parallelschaltung: alle Zweige hängen an denselben Klemmen, also dieselbe Spannung; der Strom teilt sich auf.
Quelle: 0.4

### Welche Aussagen über eine Parallelschaltung aus mehreren Widerständen stimmen?
- [x] Der Gesamtwiderstand ist kleiner als der kleinste Einzelwiderstand.
  > Jeder zusätzliche Zweig ist ein weiterer Weg für den Strom. Mehr Wege heißt weniger Gesamtwiderstand.
- [ ] Der größte Widerstand bekommt den größten Strom.
  > Umgekehrt: Bei gleicher Spannung fließt durch den größten Widerstand der kleinste Strom ($I = U\/R$).
- [x] Fällt ein Zweig aus, laufen die anderen weiter.
  > Die übrigen Zweige liegen weiter an der vollen Spannung. Nur der Gesamtstrom sinkt.
- [ ] Die Teilspannungen addieren sich zur Gesamtspannung.
  > Das gilt für die Reihenschaltung. Parallel liegt an jedem Zweig die volle Spannung.
Quelle: 0.4

### Eine Heizung zieht an 230 V einen Strom von 8,7 A und läuft 240 Stunden im Monat. Ungefähr wie viel Energie verbraucht sie?
- [ ] 2 kWh
  > Das ist die Leistung von rund 2 kW mal einer Stunde. Die Betriebszeit fehlt.
- [x] 480 kWh
  > $P = U I approx 2 thin "kW"$, mal 240 h ergibt rund 480 kWh.
- [ ] 2088 kWh
  > Hier wurde der Strom mit der Zeit multipliziert (8,7 · 240). Das ist eine Ladung in Ah, keine Energie.
- [ ] 480 kW
  > Die Zahl stimmt, die Einheit nicht. kW ist eine Leistung; Energie ist Leistung mal Zeit, also kWh.
Tipp: Erst die Leistung $P = U I$, dann mal Zeit.
Quelle: 0.3

### Ein unbelasteter Spannungsteiler aus $R_1 = 15 thin "k"Omega$ und $R_2 = 100 thin "k"Omega$ liegt an 35 V. Warum darfst du $U_2 = U dot R_2\/(R_1 + R_2)$ nicht mehr verwenden, sobald am Ausgang ein Verbraucher hängt?
Antwort: Der Verbraucher liegt parallel zu $R_2$. Dann fließt durch $R_1$ zusätzlich der Laststrom, und $R_1$ und $R_2$ führen nicht mehr denselben Strom. Man muss zuerst $R_2$ und den Verbraucher zu einem Parallelersatz zusammenfassen und erst dann die Teilerregel anwenden. Die Ausgangsspannung sinkt dadurch.
Tipp: Die Teilerregel setzt voraus, dass beide Widerstände in Reihe liegen und denselben Strom führen.
Quelle: 0.6

### Ein Widerstand der E12-Reihe hat 8,2 kΩ und ±10 % Toleranz. Zwischen welchen Werten darf er liegen?
- [x] 7,38 kΩ bis 9,02 kΩ
  > 10 % von 8,2 kΩ sind 0,82 kΩ, nach unten und oben.
- [ ] 8,1 kΩ bis 8,3 kΩ
  > Hier wurde mit 0,1 kΩ statt mit 10 % gerechnet.
- [ ] 7,2 kΩ bis 9,2 kΩ
  > Das wäre ±1 kΩ, also gut 12 %.
- [ ] 8,2 kΩ bis 9,02 kΩ
  > Die Toleranz gilt in beide Richtungen, nicht nur nach oben.
Quelle: 0.2

## Kapitel 1 · Grundbegriffe: Strom, Spannung, Widerstand, Leistung

### In welche Richtung zeigt der Strompfeil $I$ in einem Schaltplan außerhalb der Quelle?
- [x] Von Plus nach Minus, also entgegen der Elektronenbewegung.
  > Schaltpläne verwenden die technische Stromrichtung. Die Elektronen laufen tatsächlich andersherum.
- [ ] Von Minus nach Plus, weil so die Elektronen laufen.
  > Das ist die physikalische Stromrichtung. Sie stimmt für die Elektronen, wird im Schaltbild aber nicht verwendet.
- [ ] Das hängt davon ab, ob Gleich- oder Wechselstrom fließt.
  > Die Festlegung der technischen Richtung gilt für den Zählpfeil allgemein. Bei Wechselstrom ändert sich nur das Vorzeichen des Werts.
Quelle: 1.1.2

### Ein 12-V-Akku hat 36 Ah. Welche Aussage stimmt?
- [ ] Er speichert 36 Ah Energie.
  > Amperestunden sind Strom mal Zeit, also eine Ladung. Energie hätte die Einheit Wh oder J.
- [x] Er speichert die Ladung 36 Ah und damit rund 432 Wh Energie.
  > $W = U Q = 12 thin "V" dot 36 thin "Ah" = 432 thin "Wh"$.
- [ ] Er liefert 36 Stunden lang 12 A.
  > Das wären 432 Ah. 36 Ah reichen bei 12 A nur 3 Stunden.
- [ ] Er kann höchstens 36 A abgeben.
  > Die Angabe beschreibt die gespeicherte Ladung, nicht den Höchststrom.
Quelle: 1.1.2

### Die Elektronen im Draht driften nur mit etwa 1 mm/s. Warum leuchtet die Lampe trotzdem sofort nach dem Einschalten?
- [ ] Weil die Elektronen beim Einschalten kurz auf Lichtgeschwindigkeit beschleunigen.
  > Die Driftgeschwindigkeit bleibt klein. Kein einzelnes Elektron rast vom Schalter zur Lampe.
- [x] Weil sich das elektrische Feld fast mit Lichtgeschwindigkeit ausbreitet und alle Elektronen im Kreis praktisch gleichzeitig zu driften beginnen.
  > Wie beim vollen Gartenschlauch: Vorne kommt sofort Wasser, obwohl das Wasser vom Hahn noch nicht dort ist.
- [ ] Weil die Lampe ihre eigenen Elektronen hat, die nicht wandern müssen.
  > Auch in der Lampe fließt nur Strom, wenn der ganze Kreis geschlossen ist und das Feld überall wirkt.
Quelle: 1.1.3

### Welche Größe ist maßgebend dafür, wie warm ein Leiter wird?
- [ ] Die Stromstärke allein
  > Derselbe Strom erwärmt einen dünnen Draht viel stärker als einen dicken.
- [x] Die Stromdichte $S = I\/A$
  > Sie sagt, wie viel Strom durch jeden mm² muss. Die engste Stelle wird am heißesten; darauf beruht die Schmelzsicherung.
- [ ] Die Spannung an der Quelle
  > Die Spannung treibt den Strom an, sagt aber nichts darüber, wie er sich auf den Querschnitt verteilt.
- [ ] Die Driftgeschwindigkeit der Elektronen
  > Sie hängt zwar mit der Stromdichte zusammen, ist aber nicht die Größe, mit der man die Erwärmung beurteilt.
Quelle: 1.1.5

### Warum überträgt man elektrische Energie über weite Strecken mit sehr hoher Spannung?
Antwort: Die Leitungsverluste sind $P_"Verlust" = I^2 R_"Leitung"$. Bei gleicher übertragener Leistung $P = U I$ wird der Strom umso kleiner, je höher die Spannung ist. Weil der Strom quadratisch in die Verluste eingeht, sinken sie stark. Die Spannung lässt sich mit Transformatoren hoch- und heruntersetzen, deshalb nutzt man Wechselstrom.
Tipp: Schreib die Verlustleistung in der Leitung mit dem Strom auf.
Quelle: 1.1.5

### Ein gerader Leiter liegt parallel zu den Feldlinien eines Magnetfelds und führt Strom. Welche Lorentzkraft wirkt auf ihn?
- [x] Keine, denn das Kreuzprodukt $arrow(l) times arrow(B)$ ist null.
  > Die Lorentzkraft wirkt nur auf den Anteil senkrecht zum Feld.
- [ ] Die größtmögliche Kraft $F = I l B$.
  > Das gilt, wenn Leiter und Feld senkrecht zueinander stehen.
- [ ] Eine Kraft entlang des Leiters.
  > Die Lorentzkraft steht immer senkrecht zu Leiter und Feld, nie entlang des Leiters.
Quelle: 1.1.6

### Die Steckdose liefert 230 V. Das ist der ___wert; der Scheitelwert beträgt rund ___ V.
Antwort: Effektiv/Effektivwert | 325
Tipp: $hat(u) = U_"eff" dot sqrt(2)$.
Erklärung: 230 V ist der Effektivwert, also der Gleichspannungswert, der in einem Widerstand dieselbe Wärme erzeugt. Der Scheitelwert ist $230 dot sqrt(2) approx 325 thin "V"$.
Quelle: 1.1.7

### Drei gleiche Lampen liegen in Reihe an einer Batterie. Ein Schalter parallel zu Lampe C wird geschlossen. Was passiert mit den Lampen A und B?
- [ ] Sie werden dunkler, weil der Schalter Strom abzweigt.
  > Der Schalter überbrückt C. Der Gesamtwiderstand sinkt, also steigt der Strom durch A und B.
- [ ] Sie bleiben gleich hell, nur C geht aus.
  > Dann müsste der Strom gleich bleiben. Er steigt aber von $U_q\/(3R)$ auf $U_q\/(2R)$.
- [x] Sie werden heller; im Modell mit konstanten Lampenwiderständen steigt ihre Leistung auf das 2,25-Fache.
  > Ihre Spannung steigt von $U_q\/3$ auf $U_q\/2$. Mit $P = U^2\/R$ gibt das $(3\/2)^2 = "2,25"$.
- [ ] Sie werden genau doppelt so hell.
  > Der Strom steigt um den Faktor 1,5, die Leistung aber quadratisch mit dem Strom.
Tipp: Reihenfolge: $R_"ges"$ → $I$ → Teilspannungen → Leistungen.
Quelle: 1.1.7.1

### Welche Aussagen zur Induktion stimmen?
- [x] Nur eine Änderung des magnetischen Flusses erzeugt eine Induktionsspannung.
  > Ein ruhender Magnet in einer ruhenden Spule erzeugt nichts.
- [x] Doppelt so schnelle Flussänderung ergibt doppelt so große induzierte Spannung.
  > $abs(u_i) = N dot Delta Phi\/Delta t$; halbe Zeit, doppelte Spannung.
- [ ] Ein starkes, konstantes Magnetfeld erzeugt in einer ruhenden Spule eine große Spannung.
  > Die Stärke des Felds allein reicht nicht. Entscheidend ist, dass sich der Fluss ändert.
- [ ] Das Minuszeichen im Induktionsgesetz bedeutet, dass die Spannung immer negativ ist.
  > Es beschreibt die Lenzsche Regel: Die Wirkung ist ihrer Ursache entgegengerichtet. Das Vorzeichen des Werts hängt von der Richtung der Änderung ab.
Quelle: 1.2.2

### Ein Thermoelement Cu–Konstantan ($K = "0,05" thin "mV/K"$) hat die Messstelle bei 80 °C. Warum reicht diese Angabe nicht, um die Thermospannung anzugeben?
Antwort: Die Thermospannung hängt von der Temperaturdifferenz zwischen Messstelle und Vergleichsstelle ab, $U_q approx K Delta theta$. Ohne die Temperatur der Vergleichsstelle an den Anschlüssen ist die Differenz unbekannt. Bei 20 °C an der Vergleichsstelle wären es zum Beispiel 3 mV, bei 80 °C null.
Quelle: 1.2.3

### Silizium hat eine Bandlücke von 1,12 eV, die Grenzwellenlänge liegt bei etwa 1,11 µm. Was passiert mit Licht der Wellenlänge 1,5 µm, wenn man die Lichtstärke verdoppelt?
- [ ] Es erzeugt dann doppelt so viele Elektron-Loch-Paare.
  > Mehr Licht heißt mehr Photonen, aber jedes einzelne hat immer noch zu wenig Energie.
- [x] Es erzeugt im einfachen Modell weiterhin keine Elektron-Loch-Paare.
  > Für $lambda > lambda_g$ ist die Photonenergie $h c\/lambda$ kleiner als die Bandlücke, egal wie hell das Licht ist.
- [ ] Es erzeugt Paare, aber nur halb so viele wie kurzwelliges Licht.
  > Unterhalb der Bandlücke gibt es im Modell überhaupt keine Erzeugung, nicht nur eine geringere.
Tipp: Entscheidend ist die Energie eines einzelnen Photons.
Quelle: 1.2.4.1

### Ein Schwingquarz in einer Uhr schwingt mit 32 768 Hz. Wie entsteht daraus der Sekundentakt?
- [x] Die Elektronik teilt die Frequenz durch $2^15$.
  > $32768 = 2^15$; nach 15 Halbierungen bleibt 1 Hz. Der Quarz selbst schwingt weiter mit 32 768 Hz.
- [ ] Der Quarz wird so lange gedämpft, bis er mit 1 Hz schwingt.
  > Ein Quarz schwingt mit seiner Eigenfrequenz. Gedämpft würde er nur aufhören.
- [ ] Der Quarz schwingt einmal pro Sekunde, die 32 768 Hz sind die Oberschwingung.
  > Die Grundschwingung ist 32 768 Hz. Der Sekundentakt kommt erst aus der Teilung.
Quelle: 1.2.5

### Eine Spule ($L = 10 thin "mH"$) liegt mit $R = 10 thin Omega$ an 12 V. Wie groß ist die Zeitkonstante $tau$, und welcher Strom fließt nach sehr langer Zeit?
- [x] $tau = 1 thin "ms"$, Endstrom 1,2 A
  > $tau = L\/R = "0,01" thin "H"\/10 thin Omega = 1 thin "ms"$, $I_oo = U_q\/R = "1,2" thin "A"$.
- [ ] $tau = 100 thin "s"$, Endstrom 1,2 A
  > Hier wurde $R\/L$ statt $L\/R$ gerechnet und mH nicht in H umgewandelt.
- [ ] $tau = 1 thin "ms"$, Endstrom 0 A, weil die Spule den Strom blockiert
  > Die Spule bremst nur die Änderung. Im eingeschwungenen Zustand begrenzt allein R den Strom.
- [ ] $tau = 1 thin "ms"$, Endstrom 0,76 A
  > 0,76 A fließen nach einer Zeitkonstante, also rund 63 % des Endstroms.
Quelle: 1.2.6.1

### Du erklärst einen anderen Schaltungspunkt zur Masse. Was bleibt unverändert?
- [x] Die Spannung zwischen zwei unveränderten Punkten.
  > Beide Potenziale verschieben sich um denselben Wert; ihre Differenz bleibt gleich.
- [ ] Alle Potenzialzahlen.
  > Potenziale beziehen sich auf den gewählten Nullpunkt und ändern daher ihre Zahlenwerte.
- [ ] Nur negative Potenziale werden zu null.
  > Das Vorzeichen allein entscheidet nicht; alle Potenziale werden um denselben Betrag verschoben.
Quelle: 1.3

### A liegt bei 5 V, B bei 8 V gegenüber derselben Masse. Wie groß ist die Spannung von A nach B?
- [x] −3 V
  > Es gilt $U_(A B) = phi_A - phi_B = 5 - 8$ V.
- [ ] +3 V
  > Das ist die Spannung von B nach A. Die Reihenfolge der Punkte ist vertauscht.
- [ ] 13 V
  > Die Potenziale werden zur Spannungsbildung subtrahiert, nicht addiert.
Quelle: 1.3

### Was unterscheidet Leitwert und Leitfähigkeit?
- [x] Der Leitwert gehört zum konkreten Bauteil, die Leitfähigkeit zum Material.
  > Die Geometrie geht in $G = kappa A/l$ zusätzlich zum Materialwert ein.
- [ ] Beide sind derselbe Wert mit anderem Namen.
  > Sie haben verschiedene Einheiten und beziehen sich auf verschiedene Größen.
- [ ] Der Leitwert wächst mit dem Widerstand.
  > $G = 1/R$: Größerer Widerstand bedeutet kleineren Leitwert.
Quelle: 1.4.1

### Warum darfst du Materialwerte für den Drahtwiderstand nicht ohne Temperaturangabe verwenden?
Antwort: Der spezifische Widerstand ist temperaturabhängig. Die Tabelle dieses Abschnitts gilt bei 20 °C. Für eine andere Temperatur muss das passende Temperaturmodell oder der passende Materialwert verwendet werden.
Quelle: 1.4.1

### Eine Motorzuleitung ist 25 m lang und hat Hin- und Rückleiter. Welche Leiterlänge zählt für den gesamten Spannungsabfall?
- [x] 50 m
  > Der Strom fließt über 25 m hin und 25 m zurück; beide Widerstände liegen in Reihe.
- [ ] 25 m
  > Das zählt nur einen der beiden Leiter.
- [ ] 12,5 m
  > Die Aufteilung auf zwei Leiter halbiert nicht die gesamte Strecke.
Quelle: 1.4.2

### Warum beweist ein ausreichend kleiner Spannungsabfall noch nicht die vollständige Eignung eines Leiterquerschnitts?
Antwort: Die Spannungsabfallrechnung prüft nur ein Auslegungskriterium. Die thermische Belastbarkeit muss zusätzlich zur tatsächlichen Anwendung passen; V S. 24 fordert diese Prüfung ausdrücklich.
Quelle: 1.4.2

### Wann darfst du aus einer geraden I-U-Kennlinie einen konstanten Widerstand folgern?
- [x] Für die Ursprungsgerade unter den betrachteten festen Bedingungen.
  > Die konstante Steigung bedeutet konstanten Leitwert; eine andere Temperatur kann eine andere Gerade ergeben.
- [ ] Immer und für jede Temperatur.
  > Temperaturänderungen können das Material und damit den Widerstandswert verändern.
- [ ] Nur wenn der Strom null ist.
  > Am Ursprung allein ist der Quotient U/I nicht bestimmbar. Die Gerade beschreibt gerade die weiteren Betriebspunkte.
Quelle: 1.4.3.1

### Im I-U-Diagramm wird eine ohmsche Ursprungsgerade steiler. Wird der Widerstand größer oder kleiner?
Antwort: Er wird kleiner: Die Steigung ist Stromänderung durch Spannungsänderung, also der Leitwert. Der Widerstand ist dessen Kehrwert.
Quelle: 1.4.3.1

### Was ändert sich bei einem nichtlinearen Widerstand grundsätzlich?
- [x] Die Strom-Spannungs-Beziehung ist keine Ursprungsgerade mit überall gleichem Widerstand.
  > Der Arbeitspunkt muss aus der Kennlinie oder einer passenden Bauteilgleichung bestimmt werden.
- [ ] Die Knotenregel gilt nicht mehr.
  > Die Ladungsbilanz gilt weiterhin.
- [ ] Die Maschenregel darf nicht mehr verwendet werden.
  > Die Spannungsbilanz bleibt im betrachteten Netzwerkmodell gültig.
Quelle: 1.4.3.2

### Warum darfst du den Quotienten U durch I eines nichtlinearen Bauteils nicht als festen Widerstand für alle Ströme benutzen?
Antwort: Der Quotient beschreibt nur den ausgewählten Arbeitspunkt. Bei einem anderen Strom liegt ein anderer Punkt auf der gekrümmten Kennlinie; Spannung und Quotient müssen neu bestimmt werden.
Quelle: 1.4.3.2

### Warum ist der Strom einer Wolfram-Glühwendel direkt beim Einschalten oft besonders hoch?
- [x] Die kalte Wendel hat einen kleineren Widerstand als im heißen Betrieb.
  > Wolfram ist ein Kaltleiter; bei Wärme steigt sein Widerstand.
- [ ] Der heiße Draht hat einen kleineren Widerstand.
  > Das wäre das Verhalten eines Heißleiters und kehrt hier die Temperaturwirkung um.
- [ ] Die Quelle muss beim Einschalten ihre Spannung verdoppeln.
  > Eine solche Spannungsänderung wird für die Erklärung nicht benötigt.
Quelle: 1.4.3.2.1

### Warum gelten die festen Leistungsfaktoren der einfachen Lampenrechnung nicht automatisch für echte Glühlampen?
Antwort: Die Rechnung setzt einen unveränderten Widerstand voraus. Ein echter Wolframfaden erwärmt sich und verändert seinen Widerstand. Die qualitative Aussage heller oder dunkler kann stimmen, während der genaue Leistungsfaktor vom konstanten Modell abweicht.
Quelle: 1.4.3.2.1

### Welche Temperaturen gehören in die NTC-Gleichung mit den Kehrwerten eins durch T?
- [x] Absolute Temperaturen in Kelvin.
  > Nur diese passen zum angegebenen Exponentialmodell; der Exponent muss einheitenlos sein.
- [ ] Celsiuszahlen wie 20 oder 100.
  > Die verschobene Celsius-Skala darf hier nicht als absoluter Kehrwert verwendet werden.
- [ ] Nur die Temperaturdifferenz.
  > Die Gleichung enthält die beiden absoluten Kehrwerte, nicht nur ihre Differenz als Temperaturanstieg.
Quelle: 1.4.3.2.2

### Warum kann ein zu großer Messstrom die NTC-Temperaturmessung verfälschen?
Antwort: Der Strom erzeugt Verlustwärme und erwärmt das Messbauteil selbst. Dadurch ändert sich dessen Widerstand zusätzlich zur Umgebungstemperatur. Die Messleistung muss deshalb klein genug sein.
Quelle: 1.4.3.2.2

### Beim Varistormodell ist der Strom proportional zur fünften Potenz der Spannung. Was bewirkt eine Verdopplung der positiven Spannung?
- [x] Der Modellstrom wächst um den Faktor 32.
  > Die gesamte Spannung wird potenziert: zwei hoch fünf ergibt 32.
- [ ] Der Strom verdoppelt sich.
  > Das wäre die lineare Beziehung eines konstanten Widerstands.
- [ ] Der Strom wächst um den Faktor 5.
  > Der Exponent ist kein gewöhnlicher Multiplikationsfaktor.
Quelle: 1.4.3.2.3

### Wie hilft ein parallel angeschlossener Varistor gegen eine Überspannung?
Antwort: Bei hoher Spannung wird er stark leitfähig und übernimmt einen großen Anteil des Störstroms. Dadurch wird die Spannung am geschützten Zweig begrenzt. Das konkrete Verhalten folgt seiner Kennlinie und Belastbarkeit, nicht einem universellen festen Widerstand.
Quelle: 1.4.3.2.3

### Eine Diode liegt bei 0,6 V und 2 mA. Welche Aussage zu statischem und differenziellem Widerstand stimmt bei n gleich eins und 26 mV Temperaturspannung?
- [x] Statisch 300 Ω; differenziell ungefähr 13 Ω.
  > Der Quotient U/I und die lokale Tangente sind verschiedene Auswertungen derselben Kennlinie.
- [ ] Beide Widerstände sind 300 Ω.
  > Das würde Quotient und Ableitung einer gekrümmten Kennlinie gleichsetzen.
- [ ] Die Diode hat überall 13 Ω.
  > Der differenzielle Wert gilt nur für kleine Änderungen nahe dem gewählten Arbeitspunkt.
Quelle: 1.4.3.2.4

### Was beschreibt der differenzielle Widerstand einer Diode physikalisch?
Antwort: Er beschreibt, wie viel kleine Spannungsänderung für eine kleine Stromänderung nahe einem festgelegten Arbeitspunkt nötig ist. Grafisch gehört er zur Tangente. Bei großen Auslenkungen braucht man wieder die vollständige Kennlinie.
Quelle: 1.4.3.2.4

### Beim Leerlauf der LED-Aufgabe wird nur die LED entfernt. Was geschieht mit dem 50-Ω-Widerstand parallel zur LED?
- [x] Er bleibt im Netzwerk und beeinflusst die Leerlaufspannung.
  > Leerlauf bezieht sich auf die äußere LED-Last; der vorhandene Teiler bleibt bestehen.
- [ ] Er muss ebenfalls entfernt werden.
  > Dadurch würde ein anderes Netzwerk entstehen.
- [ ] Er wird automatisch kurzgeschlossen.
  > Das passiert beim Kurzschluss der Klemmen, nicht im Leerlauf.
Quelle: 1.4.3.2.4.1

### Die LED hat 20 Prozent optischen Wirkungsgrad. Auf welche elektrische Leistung bezieht sich das in der Aufgabe?
- [x] Auf die Leistung direkt in der LED: Diodenspannung mal Diodenstrom.
  > Die übrigen Widerstände sind nicht Teil dieses angegebenen LED-Wirkungsgrads.
- [ ] Auf die gesamte Quellleistung.
  > Damit würde man die Netzwerkverluste fälschlich in die LED-Effizienz einbeziehen.
- [ ] Auf die Photonenergie allein.
  > Eine Energie pro Photon ist noch keine Leistung; dafür wäre auch die Zahl der Photonen pro Zeit nötig.
Quelle: 1.4.3.2.4.1

### Warum darfst du den Kollektorstrom nicht unbegrenzt mit beta mal Basisstrom hochrechnen?
- [x] Quelle, Lastgerade und Betriebsbereich begrenzen den möglichen Arbeitspunkt.
  > In Sättigung gilt die einfache aktive Verstärkungsbeziehung nicht unverändert.
- [ ] Weil beta immer genau eins ist.
  > Der behandelte Transistor kann deutlich größere Gleichstromverstärkungen haben.
- [ ] Weil die Knotenregel im Transistor aussetzt.
  > Auch hier addieren sich Basis- und Kollektorstrom zum Emitterstrom.
Quelle: 1.4.3.2.5

### Was zeigt die Verlustleistungshyperbel im Transistorkennlinienfeld?
Antwort: Sie verbindet Punkte gleichen Produkts aus Kollektor-Emitter-Spannung und Kollektorstrom. Eine vorgegebene Grenze darf am Arbeitspunkt nicht überschritten werden. Sie beschreibt etwas anderes als die Lastgerade des äußeren Stromkreises.
Quelle: 1.4.3.2.5

### Kupfer erwärmt sich von 20 auf 100 Grad Celsius. Welche Temperaturdifferenz setzt du in das lineare Widerstandsmodell ein?
- [x] 80 Kelvin
  > Temperaturdifferenzen haben in Kelvin und Grad Celsius denselben Zahlenwert.
- [ ] 373,15 Kelvin
  > Das ist die absolute Endtemperatur, nicht ihre Differenz zum Bezug.
- [ ] 353,15 Kelvin
  > Zu einer Celsius-Differenz wird nicht 273,15 addiert.
Quelle: 1.4.4

### Wie kann man einen temperaturabhängigen Widerstand als Thermometer nutzen?
Antwort: Man kennt den Widerstand bei einer Bezugstemperatur und seinen passenden Temperaturkoeffizienten. Aus der gemessenen relativen Widerstandsänderung folgt im gültigen Modell die Temperaturänderung. Selbsterwärmung und Gültigkeitsbereich müssen dabei berücksichtigt werden.
Quelle: 1.4.4

### Was entspricht der Fläche unter einer Leistung-Zeit-Kurve?
- [x] Der umgesetzten Energie.
  > Watt mal Sekunde ergibt Joule; die mittlere Leistung ist die Höhe des flächengleichen Rechtecks.
- [ ] Der Endleistung.
  > Die Endleistung ist nur ein einzelner Kurvenwert.
- [ ] Dem mittleren Strom.
  > Die Fläche einer Leistungskurve hat die Energieeinheit, keine Stromeinheit.
Quelle: 1.5

### Warum darfst du bei zeitabhängigem Strom nicht immer einfach die Endleistung mit der gesamten Zeit multiplizieren?
Antwort: Die Endleistung lag vorher möglicherweise nicht die ganze Zeit an. Die Energie ergibt sich aus der gesamten Fläche unter der Leistungskurve. Erst eine konstante Leistung oder die korrekt gebildete mittlere Leistung darf mit der gesamten Zeit multipliziert werden.
Quelle: 1.5

## Kapitel 2 · Kirchhoffsche Gesetze und Grundstromkreis

### Ein berechneter Zweigstrom ist negativ. Was bedeutet das bei festgelegtem Zählpfeil?
- [x] Der tatsächliche Strom fließt entgegen dem angenommenen Pfeil.
  > Der Pfeil bleibt als Bezugsrichtung bestehen; das Vorzeichen gibt die reale Richtung an.
- [ ] Die Knotenregel ist verletzt.
  > Eine vorzeichenrichtige Bilanz kann ohne Weiteres negative Ergebnisse liefern.
- [ ] Es fließt überhaupt kein Strom.
  > Ein negativer Wert ist nicht null.
Quelle: 2.1

### Welche Erhaltungsgröße steckt hinter dem Knotenpunktsatz?
Antwort: Die elektrische Ladung bleibt erhalten. Im stationären Knoten sammelt sich keine Ladung an; der gesamte Zufluss gleicht deshalb dem gesamten Abfluss. Die algebraische Summe ist nur mit richtiger Vorzeichenwahl null.
Quelle: 2.1

### Du kehrst bei einer Maschengleichung den Umlaufsinn um. Was muss passieren?
- [x] Alle Spannungsbeiträge wechseln gemeinsam das Vorzeichen.
  > Die ganze Gleichung wird mit minus eins multipliziert; die Lösung bleibt dieselbe.
- [ ] Nur die Quellspannung wechselt das Vorzeichen.
  > Auch die übrigen Spannungen werden nun entgegengesetzt durchlaufen.
- [ ] Der reale Strom kehrt seine Richtung um.
  > Eine Rechenentscheidung verändert den Stromkreis nicht.
Quelle: 2.2

### Warum ist die Spannungssumme auf einer geschlossenen Masche null?
Antwort: Nach dem Umlauf erreicht man wieder denselben Schaltungspunkt und damit dasselbe Potenzial. Alle Anhebungen und Abfälle müssen sich im betrachteten Netzwerkmodell ausgleichen. Die Vorzeichen folgen dem gewählten Umlauf und den Zählpfeilen.
Quelle: 2.2

### In einem nichtlinearen Dreizweignetz ist der Strom eines Zweigs bekannt. Was ist ein sinnvoller erster Schritt?
- [x] Aus dessen Kennlinie die Spannung lesen und weitere Spannungsabfälle dieses Zweigs ergänzen.
  > Damit erhält man die gemeinsame Klemmen- bzw. Zweigspannung für den Vergleich mit den anderen Zweigen.
- [ ] Alle nichtlinearen Bauteile durch denselben konstanten Widerstand ersetzen.
  > Die Kennlinien sind unterschiedlich und gelten nicht als universelle konstante Widerstände.
- [ ] Die Kirchhoffschen Gesetze weglassen.
  > Gerade diese Bilanzen verbinden die Zweige weiterhin.
Quelle: 2.3

### Wie kontrollierst du das Ergebnis eines nichtlinearen Netzwerks?
Antwort: Prüfe die verwendeten Punkte an den Kennlinien, die Summe der Ströme am Knoten und die Spannungssumme jeder betrachteten Masche. Berechnete Leistungen müssen zu den tatsächlichen Bauteilspannungen und -strömen gehören. Ein negativer Strom wird als Richtungsinformation interpretiert.
Quelle: 2.3


### Eine reale Quelle hat $U_q = 9 thin "V"$ und $R_i = 300 thin Omega$. Wie groß ist der Kurzschlussstrom?
- [x] 30 mA
  > $I_k = U_q\/R_i = 9\/300 thin "A"$.
- [ ] Unendlich groß
  > Das gilt nur für eine ideale Quelle. Der Innenwiderstand begrenzt den Strom.
- [ ] 0 A, weil im Kurzschluss keine Spannung anliegt
  > Die Klemmenspannung ist null, aber gerade deshalb fließt der größte Strom.
- [ ] 2,7 kA
  > Hier wurde $U_q dot R_i$ statt $U_q\/R_i$ gerechnet.
Quelle: 2.4.1

### Im Leerlauf ist die Klemmenspannung gleich ___, im Kurzschluss ist sie ___ V.
Antwort: der Quellspannung/Quellspannung/Uq/U_q | 0/null
Erklärung: Leerlauf: kein Strom, also fällt an $R_i$ nichts ab und $U_a = U_q$. Kurzschluss: die Pole sind direkt verbunden, $U_a = 0$, die ganze Quellspannung fällt an $R_i$ ab.
Quelle: 2.4.1

### Wird der Außenwiderstand $R_a$ im Grundstromkreis kleiner, wohin wandert der Arbeitspunkt im $I$-$U$-Diagramm?
- [x] Nach links oben: mehr Strom, weniger Spannung.
  > Die Widerstandsgerade wird steiler und schneidet die Quellenkennlinie näher am Kurzschlusspunkt.
- [ ] Nach rechts unten: weniger Strom, mehr Spannung.
  > So wandert er, wenn $R_a$ größer wird, also Richtung Leerlauf.
- [ ] Gar nicht, die Quellenkennlinie bleibt ja gleich.
  > Die Quellenkennlinie bleibt gleich, aber die Widerstandsgerade dreht sich, und damit verschiebt sich der Schnittpunkt.
Quelle: 2.4.1

### Ein Heizwiderstand am Netz senkt die Klemmenspannung von 230 V (Leerlauf) auf 218 V, es fließen rund 7 A. Wie groß ist der Innenwiderstand des Netzes ungefähr?
- [ ] 31,2 Ω
  > Das ist der Heizwiderstand, also der Außenwiderstand.
- [x] 1,7 Ω
  > Die Differenz 12 V fällt an $R_i$ ab: $R_i = 12 thin "V"\/"6,99" thin "A"$.
- [ ] 33 Ω
  > So groß wäre der Widerstand des ganzen Kreises, $230 thin "V"\/7 thin "A"$.
- [ ] 0 Ω, das Netz ist eine ideale Quelle
  > Dann würde die Spannung unter Last nicht sinken.
Tipp: Die Differenz zwischen Leerlauf- und Klemmenspannung fällt immer an $R_i$ ab.
Quelle: 2.4.2

### Welche Aussagen zur Leistungsanpassung $R_a = R_i$ stimmen?
- [x] Der Verbraucher bekommt die größtmögliche Leistung $U_q^2\/(4 R_i)$.
  > Bei kleinerem $R_a$ fehlt Spannung, bei größerem fehlt Strom.
- [x] Der Wirkungsgrad beträgt nur 50 %.
  > Innen wird genauso viel Leistung verheizt, wie außen ankommt.
- [ ] Das ist der Betriebsfall mit dem besten Wirkungsgrad.
  > Der Wirkungsgrad steigt mit $R_a\/R_i$. Deshalb betreibt man Kraftwerke mit $R_a >> R_i$.
- [x] Die Klemmenspannung ist halb so groß wie die Quellspannung.
  > Gleiche Widerstände teilen die Spannung zu gleichen Teilen.
Quelle: 2.4.3

### Für $U_q = 9 thin "V"$, $R_i = 300 thin Omega$ und $R_a = 500 thin Omega$: Wie groß ist der Wirkungsgrad?
- [ ] 37,5 %
  > Das ist der Anteil, der am Innenwiderstand verloren geht, $300\/800$.
- [x] 62,5 %
  > $eta = R_a\/(R_i + R_a) = 500\/800$.
- [ ] 60 %
  > Das wäre $300\/500$, also das Verhältnis der Widerstände, nicht der Leistungen.
- [ ] 50 %
  > 50 % gilt nur bei Anpassung, also $R_a = R_i$.
Quelle: 2.4.3

### Warum betreibt man Kraftwerke und Netze nicht bei Leistungsanpassung, Antennen und Lautsprecher aber schon?
Antwort: Bei Anpassung bekommt der Verbraucher die größte Leistung, aber nur mit 50 % Wirkungsgrad, die andere Hälfte geht in der Quelle verloren. In der Energietechnik zählen die Verluste, deshalb wählt man $R_a >> R_i$ und nimmt etwas weniger als die Höchstleistung in Kauf. In der Nachrichtentechnik geht es um kleine Signale; dort zählt, möglichst viel Signalleistung zu übertragen, der Wirkungsgrad ist zweitrangig.
Quelle: 2.4.3
