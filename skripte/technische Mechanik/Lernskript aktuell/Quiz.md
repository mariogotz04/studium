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

## TM1 · Statik

### Eine Kraft $F$ ist um den Winkel $alpha$ gegen die *Senkrechte* geneigt. Wie groß ist ihre horizontale Komponente?
- [ ] $F cos alpha$
  > „Horizontal immer Kosinus“ gilt nur, wenn der Winkel zur Waagerechten gemessen wird. Hier liegt er zur Senkrechten.
- [x] $F sin alpha$
  > Zur Senkrechten gemessen tauschen Sinus und Kosinus ihre Rollen: Die senkrechte Komponente ist $F cos alpha$, die waagerechte $F sin alpha$.
- [ ] $F tan alpha$
  > Der Tangens ist ein Verhältnis zweier Komponenten, keine Komponente selbst.
- [ ] $F$
  > Die volle Kraft wirkt nur dann horizontal, wenn sie waagerecht liegt.
Tipp: Zeichne das Kraftdreieck und markiere, an welcher Seite der Winkel liegt.
Quelle: 1.3

### Für das Moment einer Kraft um einen Punkt P zählt der ___ Abstand der ___ von P.
Antwort: senkrechte/kuerzeste/rechtwinklige | Wirkungslinie
Tipp: Denk an eine Tür: Wo und wie musst Du drücken, damit sie am leichtesten aufgeht?
Erklärung: $M = F d$ mit dem senkrechten Abstand $d$ zwischen Wirkungslinie und Bezugspunkt. Eine Kraft, deren Wirkungslinie durch P geht, erzeugt um P kein Moment.
Quelle: 1.4

### Warum reicht $sum F_x = 0$ und $sum F_y = 0$ allein nicht für das Gleichgewicht eines starren Körpers?
- [ ] Weil man zusätzlich die Masse des Körpers kennen muss.
  > Für das Gleichgewicht in der Statik braucht man die Masse nur als Gewichtskraft, nicht als eigene Bedingung.
- [x] Weil zwei gleich große, entgegengesetzte, versetzte Kräfte die Kraftsumme null haben und trotzdem drehen.
  > Ein Kräftepaar dreht den Körper. Deshalb braucht man zusätzlich $sum M = 0$, insgesamt drei Bedingungen in der Ebene.
- [ ] Weil die Kraftsummen nur für Fachwerke gelten.
  > Kraftsummen gelten für jeden freigeschnittenen Körper.
- [ ] Doch, die beiden Gleichungen reichen immer.
  > Ohne Momentengleichgewicht ist der Körper nicht gegen Drehen gesichert.
Quelle: 1.4

### Welche Aussagen zum Freischneiden stimmen?
- [x] Jede gelöste Lagerung wird durch ihre zulässigen Reaktionen ersetzt.
  > Ein Festlager wird zu zwei Kraftkomponenten, eine Einspannung zu zwei Kräften und einem Moment.
- [ ] Im Freikörperbild eines Körpers trägt man actio und reactio beide ein.
  > Actio und reactio wirken auf verschiedene Körper. Am einzelnen Körper erscheint nur eine davon.
- [x] Ergibt die Rechnung einen negativen Wert, zeigt die Kraft entgegen dem angenommenen Pfeil.
  > Den Pfeil legt man vorher fest. Ein Minus kehrt nur die tatsächliche Richtung um.
- [x] An einem gelösten Gelenk setzt man an beiden Teilkörpern dieselben Unbekannten entgegengesetzt an.
  > So bleibt das Gesamtsystem im Gleichgewicht, die Gelenkkräfte heben sich im Gesamtsystem auf.
Quelle: 1.6

### Eine Dreieckslast steigt über die Länge $L$ von 0 auf $q_0$. Wie groß ist die Resultierende und wo greift sie an?
- [ ] $q_0 L$ bei $L\/2$
  > Das gilt für eine Rechtecklast. Die Dreiecksfläche ist nur halb so groß.
- [x] $q_0 L \/ 2$ bei $2L\/3$ von der Nullseite
  > Fläche des Dreiecks und sein Schwerpunkt, also näher an der hohen Seite.
- [ ] $q_0 L \/ 2$ bei $L\/3$ von der Nullseite
  > Der Betrag stimmt, der Angriffspunkt ist gespiegelt. Er liegt näher an der hohen Seite.
- [ ] $q_0 L \/ 2$ bei $L\/2$
  > Die Mitte wäre richtig für eine gleichmäßige Last. Beim Dreieck verschiebt sich der Schwerpunkt.
Tipp: Die Resultierende ist die Fläche unter dem Lastbild, sie greift im Flächenschwerpunkt an.
Quelle: 4.1

### Bei der Schwerpunktberechnung eines Querschnitts mit einer Bohrung: Wie geht die Bohrung ein?
- [ ] Gar nicht, man rechnet nur mit der Außenkontur.
  > Dann wäre die Fläche zu groß und der Schwerpunkt falsch.
- [x] Als negative Teilfläche mit ihrem eigenen Schwerpunkt
  > Aussparungen zählen negativ in $sum A_i$ und in $sum A_i y'_(S i)$.
- [ ] Als positive Fläche, weil jede Fläche positiv ist
  > Dann würde die Bohrung den Querschnitt größer machen statt kleiner.
- [ ] Nur über ihren Radius im Nenner
  > Der Nenner ist die Summe der Flächen, nicht ein Radius.
Quelle: 4.2

### Wie viele unbekannte Reaktionen liefert eine feste Einspannung in der Ebene?
- [ ] 1
  > Das ist ein Loslager oder eine Pendelstütze.
- [ ] 2
  > Das ist ein Festlager: zwei Kraftkomponenten, aber Drehung frei.
- [x] 3
  > Zwei Kräfte und ein Moment, weil beide Verschiebungen und die Drehung gesperrt sind.
- [ ] 4
  > In der Ebene hat ein Körper nur drei Freiheitsgrade, mehr kann ein einzelnes Lager nicht sperren.
Quelle: 5.1

### Ein System aus zwei Teilkörpern ($n = 2$) hat $r = 4$ äußere Lagerreaktionen und $v = 2$ Gelenkreaktionen. Was folgt?
- [ ] Es ist sicher statisch bestimmt.
  > Die Abzählbedingung ist nur notwendig. Ob die Lagerung geometrisch wirksam ist, muss man zusätzlich prüfen.
- [x] Die Abzählbedingung $r + v = 3n$ ist erfüllt, die Geometrie muss noch geprüft werden.
  > $4 + 2 = 6 = 3 dot 2$. Erst wenn das System unbeweglich ist, ist es statisch bestimmt.
- [ ] Es ist statisch unbestimmt.
  > Das wäre bei $r + v > 3n$ der Fall.
- [ ] Es ist beweglich.
  > Bei $r + v < 3n$ wäre es im Allgemeinen beweglich. Hier sind es genau 6.
Tipp: $r + v = 3n$
Quelle: 5.3.2

### Wie wählst Du den Momentenbezugspunkt bei der Berechnung von Lagerreaktionen geschickt?
- [ ] Immer im linken Lager
  > Eine feste Regel gibt es nicht. Es kommt auf die Lage der Unbekannten an.
- [x] So, dass möglichst viele unbekannte Kräfte durch den Punkt gehen
  > Kräfte durch den Bezugspunkt erzeugen kein Moment. So bleibt im Idealfall nur eine Unbekannte übrig.
- [ ] Im Schwerpunkt des Körpers
  > Der Schwerpunkt hilft für Streckenlasten, ist aber für Lagerkräfte kein besonderer Punkt.
- [ ] Dort, wo die größte Kraft angreift
  > Bekannte Kräfte stören nicht. Es geht darum, Unbekannte aus der Gleichung zu entfernen.
Quelle: 5.3.3

### Ein unbelasteter Fachwerkknoten verbindet drei Stäbe, zwei davon liegen auf einer Linie. Was gilt für den dritten Stab?
- [ ] Er trägt die doppelte Kraft der anderen.
  > Quer zu den kollinearen Stäben hat er keinen Partner, der ihn ausgleichen könnte.
- [x] Er ist ein Nullstab.
  > Das Gleichgewicht quer zur Linie der beiden kollinearen Stäbe lässt nur $S_3 = 0$ zu (Nullstabregel 3).
- [ ] Er ist immer auf Druck belastet.
  > Ohne Last am Knoten gibt es keine Kraft, die ihn drücken könnte.
- [ ] Er kann ohne Weiteres aus der Konstruktion entfernt werden.
  > Ein Nullstab kann den Knoten stabilisieren oder bei anderer Belastung Kräfte tragen. Weglassen ist nicht automatisch erlaubt.
Quelle: 6.3.1

### Wie setzt Du eine unbekannte Stabkraft beim Knotenverfahren zunächst an?
- [x] Als Zug, der Pfeil zeigt vom Knoten weg
  > Ein negatives Ergebnis bedeutet dann Druck. So bleibt die Vorzeichenregel einheitlich.
- [ ] Als Druck, der Pfeil zeigt zum Knoten hin
  > Das geht theoretisch auch, aber die Vorlesungskonvention setzt Zug an, damit das Vorzeichen gleich gedeutet wird.
- [ ] Gar nicht, man rät die Richtung aus der Skizze.
  > Raten führt zu Vorzeichenfehlern. Man legt eine Konvention fest.
- [ ] Senkrecht zum Stab
  > Ideale Fachwerkstäbe übertragen Kräfte nur entlang ihrer Achse.
Quelle: 6.1

### Ein Ritterschnitt trennt drei unbekannte Stäbe. Wie bestimmst Du eine einzelne Stabkraft am schnellsten?
- [ ] Mit der Kraftsumme in Richtung der gesuchten Kraft
  > Dann stehen meist noch die anderen beiden Unbekannten in der Gleichung.
- [x] Mit dem Moment um den Schnittpunkt der beiden anderen Stabkräfte
  > Die anderen zwei Kräfte gehen durch diesen Punkt und fallen heraus. Übrig bleibt nur die gesuchte.
- [ ] Mit dem Moment um einen Punkt auf dem gesuchten Stab
  > Dann fällt gerade die gesuchte Kraft heraus.
- [ ] Mit $s + r = 2k$
  > Das ist die Abzählbedingung für die statische Bestimmtheit, keine Rechenmethode für Stabkräfte.
Quelle: 6.3.3

### Welche Zusammenhänge gelten im geraden Balken zwischen Streckenlast, Querkraft und Moment?
- [x] $M'(x) = Q(x)$
  > Die Steigung des Momentenverlaufs ist die Querkraft.
- [x] $Q'(x) = -q(x)$
  > Die Streckenlast ändert die Querkraft, mit der Vorlesungskonvention negativ.
- [ ] $Q'(x) = M(x)$
  > Die Ableitungsrichtung ist vertauscht.
- [ ] $M''(x) = q(x)$
  > Aus den beiden Gleichungen folgt $M'' = -q$, das Vorzeichen fehlt.
Quelle: 7.3

### An einer Stelle des Balkens greift eine Einzelkraft quer zur Achse an. Was siehst Du in den Verläufen?
- [ ] Einen Sprung im Momentenverlauf
  > Ein Sprung im Moment entsteht durch ein Einzelmoment, nicht durch eine Einzelkraft.
- [x] Einen Sprung in $Q$ und einen Knick in $M$
  > Die Querkraft springt um den Betrag der Kraft. Das Moment bleibt stetig, aber seine Steigung ändert sich.
- [ ] Keine Änderung, Einzelkräfte wirken nur auf die Lager
  > Einzelkräfte verändern die Schnittgrößen an ihrer Angriffsstelle sichtbar.
- [ ] Einen parabelförmigen Momentenverlauf
  > Eine Parabel entsteht durch eine konstante Streckenlast.
Quelle: 7.3

### Wo liegen innere Extremstellen des Biegemoments?
- [ ] Immer in Balkenmitte
  > Nur bei symmetrischer Belastung und Lagerung. Allgemein gilt das nicht.
- [x] Dort, wo $Q = 0$ ist und sein Vorzeichen wechselt
  > Wegen $M' = Q$ hat $M$ dort eine waagerechte Tangente. Rand- und Sprungstellen trotzdem zusätzlich prüfen.
- [ ] Dort, wo die Streckenlast am größten ist
  > Die Last bestimmt die Krümmung, nicht die Lage des Extremums.
- [ ] An jedem Lager
  > An einem gelenkigen Endlager ist das Moment sogar null.
Quelle: 7.3

### Ein Klotz liegt auf einer rauen Fläche ($mu_0 = "0,4"$, $N = 100$ N). Eine waagerechte Kraft von 20 N zieht, er bewegt sich nicht. Wie groß ist die Haftkraft?
- [ ] 40 N
  > 40 N ist die Haftgrenze $mu_0 N$. Solange der Klotz haftet, wirkt nur die nötige Kraft.
- [x] 20 N
  > Aus dem Gleichgewicht folgt $H = 20$ N. $abs(H) <= mu_0 N = 40$ N ist erfüllt, also haftet er.
- [ ] 0 N
  > Ohne Haftkraft würde die Zugkraft den Klotz beschleunigen.
- [ ] 100 N
  > Das ist die Normalkraft, nicht die Haftkraft.
Tipp: $H = mu_0 N$ gilt nur im Grenzfall.
Quelle: 9.2

## TM2 · Festigkeitslehre

### Ein Stab wird frei erwärmt, nichts behindert seine Ausdehnung. Welche Spannung entsteht?
- [x] Keine
  > Bei freier Ausdehnung ist die Dehnung rein thermisch: $epsilon = alpha_T Delta T$, $sigma = 0$.
- [ ] Zugspannung
  > Zug würde ein Festhalten gegen eine Verkürzung voraussetzen.
- [ ] Druckspannung
  > Druck entsteht erst, wenn die Ausdehnung behindert wird.
- [ ] $sigma = E alpha_T Delta T$
  > Das ist die Druckspannung bei vollständig verhinderter Ausdehnung, nicht bei freier.
Quelle: TM2 1.4

### Ein Stab ist zwischen zwei starren Wänden eingespannt und wird erwärmt. Woher kommt die zusätzliche Gleichung, um die Wandkraft zu bestimmen?
Antwort: Aus der Verträglichkeit: Die Gesamtlänge ist festgehalten, also muss die Summe aus thermischer und elastischer Längenänderung null sein: $Delta l = X l \/ (E A) + alpha_T Delta T l = 0$ (mit $X$ als Normalkraft). Daraus folgt $X = -E A alpha_T Delta T$, also Druck. Das Gleichgewicht allein liefert nur, dass beide Wandkräfte gleich groß sind, nicht ihren Betrag.
Tipp: Gleichgewicht liefert hier zu wenig. Was weißt Du über die Länge?
Quelle: TM2 1.6

### Ein Stab hat $l = 1000$ mm, $A = 100$ mm², $E = 200.000$ N/mm² und wird mit $N = 20$ kN gezogen. Wie groß ist die Längenänderung?
- [ ] 0,01 mm
  > Hier fehlt ein Faktor 100. Prüfe, ob die Kraft in N umgerechnet ist.
- [x] 1 mm
  > $Delta l = N l \/ (E A) = 20000 dot 1000 \/ (200000 dot 100) = 1$ mm.
- [ ] 100 mm
  > Das wäre eine Dehnung von 10 %, für Stahl im elastischen Bereich unmöglich.
- [ ] 0,2 mm
  > Hier wurde die Spannung (200 N/mm²) mit der Länge verwechselt.
Quelle: TM2 1.4

### Wie konstruierst Du den Mohrschen Spannungskreis?
- [x] Die Punkte $(sigma_x, tau_(x y))$ und $(sigma_y, -tau_(x y))$ eintragen, sie bilden einen Durchmesser.
  > Der Mittelpunkt liegt bei $((sigma_x + sigma_y)\/2, 0)$, der Kreis geht durch beide Punkte.
- [x] Beide Achsen im gleichen Maßstab zeichnen.
  > Sonst wird der Kreis zur Ellipse und alle Ablesungen werden falsch.
- [ ] Ein Winkel $phi$ am Bauteil entspricht $phi$ im Kreis.
  > Im Kreis ist der Winkel doppelt so groß, $2 phi$, mit entgegengesetztem Drehsinn in dieser Konvention.
- [ ] Der Mittelpunkt liegt immer im Ursprung.
  > Nur wenn $sigma_x + sigma_y = 0$ ist. Allgemein liegt er bei der mittleren Normalspannung.
Quelle: TM2 2.2.3

### Gegeben sind $sigma_x = 80$, $sigma_y = 20$ und $tau_(x y) = 40$ (N/mm²). Wie groß sind die Hauptspannungen?
- [ ] 80 und 20 N/mm²
  > Das sind die Normalspannungen im gegebenen Achsensystem. Wegen der Schubspannung sind es keine Hauptspannungen.
- [x] 100 und 0 N/mm²
  > Mittelpunkt 50, Radius $sqrt(30^2 + 40^2) = 50$, also $sigma_(1,2) = 50 plus.minus 50$.
- [ ] 90 und 10 N/mm²
  > Hier wurde nur $tau$ halbiert oder der Radius falsch gebildet. Der Radius ist $sqrt(30^2 + 40^2)$.
- [ ] 120 und −20 N/mm²
  > Hier wurde der Radius ohne Wurzel als $30 + 40 = 70$ angesetzt.
Tipp: $sigma_(1,2) = (sigma_x + sigma_y)\/2 plus.minus sqrt(((sigma_x - sigma_y)\/2)^2 + tau_(x y)^2)$
Quelle: TM2 2.2

### Im Mohrschen Verzerrungskreis ersetzt man $sigma$ durch $epsilon$ und $tau$ durch die ___ Gleitung.
Antwort: halbe
Tipp: Im Verzerrungstensor steht auf der Nebendiagonale nicht $gamma$ selbst.
Erklärung: Der Tensor hat $gamma_(x y)\/2$ auf der Nebendiagonale. Deshalb trägt man $P = (epsilon_x, gamma\/2)$ ein. Wer $gamma$ ohne den Faktor 1/2 nimmt, bekommt einen falschen Kreis.
Quelle: TM2 3.1

### Bei einer 0°/45°/90°-Rosette misst Du $epsilon_0$, $epsilon_45$ und $epsilon_90$. Wie bestimmst Du die Gleitung?
- [ ] $gamma_(x y) = epsilon_45$
  > Der 45°-DMS enthält auch Anteile von $epsilon_x$ und $epsilon_y$, die man abziehen muss.
- [x] $gamma_(x y) = 2 epsilon_45 - epsilon_0 - epsilon_90$
  > Aus $epsilon_45 = (epsilon_x + epsilon_y)\/2 + gamma\/2$ folgt diese Formel durch Umstellen.
- [ ] $gamma_(x y) = epsilon_0 - epsilon_90$
  > Die Differenz der Normaldehnungen sagt nichts über die Winkeländerung.
- [ ] $gamma_(x y) = epsilon_45 \/ 2$
  > Hier fehlen die Normaldehnungen, und der Faktor ist umgekehrt.
Quelle: TM2 3.3

### Ein Blech ist im ebenen Spannungszustand ($sigma_z = 0$). Ist dann auch $epsilon_z = 0$?
- [ ] Ja, ohne Spannung gibt es keine Dehnung.
  > Die Querkontraktion koppelt die Richtungen. Zug in $x$ macht das Blech dünner.
- [x] Nein, $epsilon_z = -nu (sigma_x + sigma_y) \/ E$ ist im Allgemeinen nicht null.
  > Ein ebener Spannungszustand ist kein ebener Verzerrungszustand.
- [ ] Nur bei Temperaturänderung ist $epsilon_z$ nicht null.
  > Auch ohne Temperatur gibt es die Querkontraktion.
- [ ] Ja, weil das Blech dünn ist.
  > Die Dicke rechtfertigt $sigma_z approx 0$, nicht $epsilon_z = 0$.
Quelle: TM2 3.2

### Welcher Randabstand gehört bei Biegung um die $y$-Achse in das Widerstandsmoment $W_y = I_y \/ max abs(z)$?
- [ ] Immer die halbe Gesamthöhe
  > Nur bei symmetrischen Querschnitten. Sonst liegt der Schwerpunkt nicht in der Mitte.
- [x] Der größte Abstand eines Randes vom Schwerpunkt in $z$-Richtung
  > Dort ist die Biegespannung am größten. Bei unsymmetrischem Querschnitt ist das der weiter entfernte Rand.
- [ ] Der Abstand in $y$-Richtung
  > Zu $I_y$ gehören Abstände in $z$-Richtung.
- [ ] Der Abstand vom Lager
  > Das ist eine Längskoordinate des Balkens. Gefragt ist eine Querschnittsgröße.
Quelle: TM2 4.2

### Ein Rechteck hat $b = 20$ mm und $h = 60$ mm. Wie groß ist $I_y$ um die waagerechte Schwerpunktachse?
- [ ] 40.000 mm⁴
  > Das ist $h b^3 \/ 12$, also $I_z$. Bei $I_y$ steht die Höhe in der dritten Potenz.
- [x] 360.000 mm⁴
  > $I_y = b h^3 \/ 12 = 20 dot 60^3 \/ 12 = 360000$ mm⁴.
- [ ] 1.200 mm⁴
  > Das ist die Fläche $b h$ in mm², kein Flächenträgheitsmoment.
- [ ] 1.440.000 mm⁴
  > Hier fehlt der Faktor 1/12, und $b h^3\/3$ ist das Moment um die Unterkante.
Tipp: Die Abmessung quer zur Biegeachse geht in die dritte Potenz.
Quelle: TM2 4.3

### Warum braucht man den Satz von Steiner bei zusammengesetzten Querschnitten?
Antwort: Die Eigen-Flächenträgheitsmomente der Teilflächen (z. B. $b h^3\/12$) gelten nur um deren eigene Schwerpunktachsen. Für das Gesamt-FTM braucht man alle Anteile um dieselbe Achse durch den Gesamtschwerpunkt. Steiner verschiebt jeden Anteil auf diese parallele Achse: $I_y = sum (I_(y i,S) + A_i d_(z i)^2)$, Aussparungen mit Minus. Der Abstandsanteil $A_i d^2$ ist oft der größte Beitrag.
Tipp: Um welche Achse gilt $b h^3 \/ 12$?
Quelle: TM2 4.3

### Welche Randbedingungen gelten an einer festen Einspannung eines Balkens?
- [x] $w = 0$ und $w' = 0$
  > Durchbiegung und Neigung sind gesperrt.
- [ ] $w = 0$ und $M = 0$
  > Das ist ein gelenkiges Endlager. Die Einspannung kann ein Moment aufnehmen.
- [ ] $Q = 0$ und $M = 0$
  > Das ist ein freies Ende.
- [ ] $w' = 0$ und $Q = 0$
  > Das ist eine Parallelführung mit freier Querverschiebung.
Quelle: TM2 4.4

### Wo liegt bei einem dünnwandigen *geschlossenen* Profil die größte Torsionsschubspannung, und wo bei einem *offenen*?
- [x] Geschlossen an der dünnsten Wand, offen im dicksten Teil
  > Geschlossen: $tau = M_T \/ (2 A_m t)$, kleines $t$ heißt großes $tau$. Offen: $tau_"max" approx M_T t_"max" \/ I_T$.
- [ ] In beiden Fällen an der dünnsten Wand
  > Für offene Profile gilt das Gegenteil, weil die Spannung dort mit der Dicke wächst.
- [ ] In beiden Fällen im dicksten Teil
  > Beim geschlossenen Profil ist der Schubfluss konstant, deshalb ist die dünnste Wand am stärksten belastet.
- [ ] Geschlossen im dicksten Teil, offen an der dünnsten Wand
  > Genau vertauscht.
Quelle: TM2 5.2

### Warum vergrößert ein schmaler Längsschlitz in einem Rohr die Verdrehung unter Torsion stark?
Antwort: Der Schlitz unterbricht den umlaufenden Schubfluss. Aus dem geschlossenen Profil (Bredt, $I_T = 4 A_m^2 \/ integral.cont dif s \/ t$) wird ein offenes Profil mit $I_T approx 1\/3 sum b_i t_i^3$. Weil $t$ klein ist, sinkt $I_T$ um Größenordnungen, obwohl kaum Material fehlt. Die Verdrehung $theta' = M_T \/ (G I_T)$ steigt entsprechend stark.
Tipp: Welches Torsionsmodell passt vor und nach dem Schlitz?
Quelle: TM2 5.3

### Für die dünnwandige Torsion eines Profils mit äußerem Radius $r = 50$ mm und Wanddicke $t = "3,75"$ mm: Welcher Radius gehört in $A_m$?
- [ ] 50 mm
  > Das ist der Außenradius. Bredt verlangt die Wandmittellinie.
- [x] 48,125 mm
  > $r_m = r - t\/2 = 50 - "1,875" = "48,125"$ mm.
- [ ] 46,25 mm
  > Das ist der Innenradius $r - t$.
- [ ] 53,75 mm
  > Hier wurde die Wanddicke addiert statt abgezogen.
Quelle: TM2 5.4
