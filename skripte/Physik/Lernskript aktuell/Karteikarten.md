# Karteikarten · Physik

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

## Kapitel 5 · Schwingungen

### Warum schwingt ein Federpendel immer wieder durch die Ruhelage hindurch?
Die ausgelenkte Feder zieht die Masse zur Ruhelage zurück. Dort hat die Masse ihre größte Geschwindigkeit und fliegt wegen ihrer Trägheit darüber hinaus. Jetzt bremst die Feder sie wieder ab und zieht zurück. Ohne Dämpfung wiederholt sich das ewig.
Quelle: 5.0

### Wovon hängt die Eigenfrequenz eines Federpendels ab?
$ omega_0 = sqrt(D/m) $
Eine härtere Feder (größeres $D$) macht die Schwingung schneller, eine größere Masse langsamer. Die Amplitude spielt keine Rolle.
Quelle: 5.0

### Was ist der Unterschied zwischen f und ω?
$f$ zählt vollständige Schwingungen pro Sekunde (Hz). $omega$ ist die Kreisfrequenz in rad/s: $omega = 2 pi f$. Es sind zwei Zahlen für denselben Takt. Bei 2 Hz durchläuft der Sinus $4 pi$ Radiant pro Sekunde.
Quelle: 5.0

### Wann entsteht eine Schwebung, und warum wird der Ton lauter und leiser?
Wenn zwei Schwingungen mit fast gleicher Frequenz überlagert werden. Ihre Phasen verschieben sich langsam gegeneinander: Mal sind sie im Takt und verstärken sich, mal gegeneinander und löschen sich aus.

Bild: Zwei Läufer mit fast gleichem Tempo: Sie laufen eine Weile nebeneinander, dann auseinander, und treffen sich nach jeder Überrundung wieder.
Quelle: 5.4.1
Abbildung: schwebung-quelle

### Was hört man bei 440 Hz und 442 Hz zusammen?
Einen Ton nahe 441 Hz (der schnelle Träger, die Mittenfrequenz), der zweimal pro Sekunde an- und abschwillt. Die 2 Hz sind kein eigener Ton, sondern der Rhythmus der Lautstärke: $f_s = abs(f_1 - f_2)$.
Quelle: 5.4.1
Abbildung: schwebung-quelle

### Warum ist die hörbare Schwebungsfrequenz doppelt so groß wie die Frequenz der Kosinushülle?
Die Hülle $2 A cos((Delta omega t)\/2)$ wechselt zwischen $+2A$ und $-2A$. Laut ist es aber bei beiden Extremen, denn das Ohr hört den Betrag. Pro Periode der Kosinushülle gibt es also zwei Lautstärkemaxima.
Quelle: 5.4.1
Abbildung: schwebung-quelle

### Wie nutzt man die Schwebung zum Stimmen eines Instruments?
Man spielt Saite und Stimmgabel zusammen. Je näher die Frequenzen, desto langsamer die Schwebung. Wird sie beim Nachspannen langsamer, ist man auf dem richtigen Weg. Verschwindet sie ganz, sind die Frequenzen gleich.
Quelle: 5.4.1
Abbildung: schwebung-quelle

### Braucht eine Schwebung gleiche Amplituden?
Nein. Mit gleichen Amplituden löschen sich die Schwingungen im Minimum vollständig aus. Bei ungleichen Amplituden bleibt ein Restminimum, die Schwebung ist dann weniger ausgeprägt.
Quelle: 5.4.1
Abbildung: schwebung-quelle

### Was ist der Unterschied zwischen Überlagerung und Kopplung zweier Schwingungen?
Bei der Überlagerung addiert man zwei Bewegungen, die sich gegenseitig nicht beeinflussen. Bei der Kopplung wirkt ein Schwinger auf den anderen, z. B. über eine Feder zwischen zwei Pendeln, die Kräfte und Energie überträgt.
Quelle: 5.4.2
Abbildung: pendel-quelle

### Warum hängt die Kraft der Kopplungsfeder vom Unterschied der Auslenkungen ab?
Die mittlere Feder wird nur gedehnt oder gestaucht, wenn sich der Abstand der Massen ändert, also um $x_2 - x_1$. Bewegen sich beide gleich weit, bleibt sie entspannt.
Quelle: 5.4.2
Abbildung: pendel-quelle

### Warum rechnet man bei gekoppelten Pendeln mit Summe und Differenz der Auslenkungen?
Die beiden Bewegungsgleichungen hängen voneinander ab. Addiert und subtrahiert man sie, entstehen zwei unabhängige Gleichungen, jede wie ein einzelnes Federpendel. Danach rechnet man mit
$ x_1 = (psi_1 + psi_2)/2, quad x_2 = (psi_1 - psi_2)/2 $
zurück.
Quelle: 5.4.2
Abbildung: pendel-quelle

### Was ist eine Eigenmode?
Eine feste gemeinsame Schwingungsform aller beteiligten Massen. Alle schwingen mit derselben Frequenz, und das Verhältnis ihrer Amplituden bleibt gleich.
Quelle: 5.4.2
Abbildung: pendel-quelle

### Was passiert bei gekoppelten Pendeln im Gleichtakt und im Gegentakt?
Gleichtakt: Beide bewegen sich gleich, die Kopplungsfeder bleibt entspannt. Frequenz wie beim einzelnen Pendel:
$ omega_"gl" = sqrt(D/m) $

Gegentakt: Beide bewegen sich entgegengesetzt, die Kopplungsfeder wird stark gedehnt und zieht zusätzlich zurück. Deshalb ist die Frequenz höher:
$ omega_"gg" = sqrt((D + 2 D_k)/m) $
Quelle: 5.4.2
Abbildung: pendel-quelle

### Ein Pendel wird ausgelenkt, das gekoppelte zweite ruht. Was passiert dann?
Die Schwingung wandert langsam zum zweiten Pendel hinüber, bis das erste fast ruht, und dann wieder zurück. Mathematisch ist das wieder eine Schwebung aus den beiden Eigenfrequenzen (Gleich- und Gegentakt).
Quelle: 5.4.3
Abbildung: alt-kopplung

### Was bewirkt eine härtere Kopplungsfeder?
Die Gleichtaktfrequenz bleibt gleich, die Gegentaktfrequenz steigt. Die beiden Frequenzen liegen weiter auseinander, also wird der Energieaustausch zwischen den Pendeln schneller.
Quelle: 5.4.3
Abbildung: alt-kopplung

### Wie viele Eigenmoden haben N gekoppelte Schwinger, und was ist der Schritt zur Welle?
N linear gekoppelte Schwinger mit je einem Freiheitsgrad haben N Eigenmoden. Koppelt man sehr viele hintereinander, wird die Störung von Glied zu Glied weitergereicht: Daraus wird eine Welle.
Quelle: 5.4.3
Abbildung: alt-kopplung


### Zeichne die Begriffslandkarte zu Kapitel 5 aus dem Kopf: Welche Begriffe gehören dazu und wie hängen sie zusammen?
Das Federpendel verbindet Rückstellkraft und Trägheit zu einer Eigenfrequenz. Zwei nahe Frequenzen erzeugen durch wechselnde Phasendifferenz eine Schwebung. Eine Kopplungsfeder verbindet zwei Pendel; Gleich- und Gegentakt sind ihre Eigenmoden. Deren Überlagerung und Rücktransformation erklären den Energieaustausch und führen zur Idee vieler gekoppelter Schwinger.
Quelle: 5.0

## Kapitel 6 · Wellen

### Was ist eine Welle, und was wandert dabei eigentlich?
Eine sich ausbreitende Störung. Die Teilchen schwingen nur um ihre Ruhelage, sie reisen nicht mit. Was wandert, ist das Muster des Schwingungszustands und die Energie.

Bild: Stadionwelle: Die Menschen bleiben auf ihren Plätzen, nur das Aufstehen wandert durchs Stadion.
Quelle: 6.1
Abbildung: wellenarten-quelle

### Was unterscheidet longitudinale von transversalen Wellen?
Longitudinal: Die Teilchen schwingen in Ausbreitungsrichtung, es gibt Verdichtungen und Verdünnungen. Beispiel: Schall in Luft.

Transversal: Die Teilchen schwingen quer zur Ausbreitung. Beispiel: Seilwelle. Im Inneren eines Mediums braucht das eine seitliche Rückstellkraft (Scherkraft), deshalb gibt es sie nur in Festkörpern.
Quelle: 6.1
Abbildung: wellenarten-quelle

### Muss eine Welle periodisch sein?
Nein. Ein einzelner Knall oder ein einmaliges Zupfen erzeugt einen Puls, also eine einzelne wandernde Störung.
Quelle: 6.1
Abbildung: wellenarten-quelle

### Woran erkennt man an ψ(x, t) = u(x − ct), in welche Richtung die Welle läuft?
Ein bestimmter Wellenberg hat ein festes Argument: $x - c t = "konstant"$, also $x = "konstant" + c t$. Sein Ort wächst mit der Zeit, die Welle läuft nach $+x$. Bei $u(x + c t)$ läuft sie nach $-x$.
Quelle: 6.1.1
Abbildung: alt-puls

### Was ist der Unterschied zwischen Wellenlänge und Periodendauer?
Die Wellenlänge $lambda$ ist die räumliche Wiederholung: der Abstand zweier gleicher Punkte in einer Momentaufnahme. Die Periodendauer $T$ ist die zeitliche Wiederholung: wie lange ein fester Ort für eine Schwingung braucht.
Quelle: 6.2
Abbildung: alt-harmwelle

### Warum gilt c = λ·f?
In einer Periodendauer $T$ rückt ein Wellenberg genau um eine Wellenlänge $lambda$ vor. Also ist
$ c = lambda/T = lambda f $
Quelle: 6.2
Abbildung: alt-harmwelle

### Was legt die Quelle fest und was das Medium?
Die Quelle gibt den Takt vor, also die Frequenz $f$. Das Medium bestimmt die Ausbreitungsgeschwindigkeit $c$. Daraus ergibt sich die Wellenlänge $lambda = c\/f$. Beim Übergang in ein anderes Medium bleibt $f$ gleich, $c$ und $lambda$ ändern sich.
Quelle: 6.2
Abbildung: alt-harmwelle

### Was ist der Unterschied zwischen Schnelle und Ausbreitungsgeschwindigkeit?
Die Schnelle ist die Geschwindigkeit, mit der ein einzelnes Teilchen hin und her schwingt. Die Ausbreitungsgeschwindigkeit $c$ ist die Geschwindigkeit, mit der das Muster (z. B. ein Wellenberg) wandert. Ein Luftteilchen fliegt also nicht mit 343 m/s zum Zuhörer.
Quelle: 6.2.1
Abbildung: schnelle-quelle

### Wo ist die Schnelle eines Teilchens am größten und wo null?
Am Umkehrpunkt (maximale Auslenkung) ist sie null. Beim Durchgang durch die Ruhelage ist sie am größten, wie beim Pendel.
Quelle: 6.2.1
Abbildung: schnelle-quelle

### Was sind Wellenfronten?
Punkte mit gleichem Schwingungszustand, also gleicher Phase. Gleiche Auslenkung allein reicht nicht, auch die Bewegungsrichtung muss passen.
Quelle: 6.2.1
Abbildung: schnelle-quelle

### Warum hängt die Wellengeschwindigkeit von Steifigkeit und Dichte des Mediums ab?
Die Nachbarteilchen müssen sich die Bewegung weitergeben. Starke Rückstellkräfte (Steifigkeit, Spannung) beschleunigen die Weitergabe, große Trägheit (Dichte) bremst sie. Deshalb steht in den Formeln meist $sqrt("Steifigkeit"\/"Dichte")$.
Quelle: 6.3
Abbildung: saite-quelle

### Was passiert mit der Wellengeschwindigkeit auf einer Saite bei vierfacher Spannung?
$ c = sqrt(F/(rho A)) $
Vierfache Zugkraft gibt doppelte Geschwindigkeit, wegen der Wurzel. Vierfache Dichte würde sie halbieren.
Quelle: 6.3
Abbildung: saite-quelle

### Wovon hängt die Schallgeschwindigkeit in einem idealen Gas ab?
$ c = sqrt((kappa R T)/m_"mol") $
Bei demselben Gas hängt sie nur von der absoluten Temperatur ab: $c prop sqrt(T)$. Wärmere Luft leitet Schall schneller (etwa 330 m/s bei 0 °C, 343 m/s bei 20 °C). $T$ muss in Kelvin stehen.
Quelle: 6.3
Abbildung: saite-quelle

### Was ist die Intensität einer Welle?
Die Leistung pro Fläche senkrecht zur Ausbreitung: $I = P\/F$ in W/m². Eine größere Empfangsfläche fängt mehr Leistung ein, die Intensität selbst bleibt dabei gleich.
Quelle: 6.4
Abbildung: energie-quelle

### Wie hängt die Intensität von Amplitude und Frequenz ab?
$ I = 1/2 rho c omega^2 hat(u)^2 $
Sie wächst mit dem Quadrat der Amplitude und dem Quadrat der Frequenz. Doppelte Amplitude gibt vierfache Intensität.
Quelle: 6.4
Abbildung: intensitaet-kurve

### Was passiert, wenn sich zwei Wellen treffen?
An jedem Ort addieren sich ihre Auslenkungen (Superposition). Danach laufen beide ungestört weiter. Berg auf Berg gibt doppelte Höhe (konstruktiv), Berg auf Tal löscht sich aus (destruktiv), wenn die Amplituden gleich sind.
Quelle: 6.5
Abbildung: interferenz-quelle

### Wann ist die Interferenz zweier gleichphasiger Quellen konstruktiv oder destruktiv?
Es zählt der Wegunterschied $Delta l$. Ganze Wellenlängen: konstruktiv. Ungerade halbe Wellenlängen: destruktiv.
Quelle: 6.5
Abbildung: interferenz-quelle

### Warum gibt doppelte Amplitude bei Interferenz die vierfache Intensität, und ist das Energie aus dem Nichts?
Man addiert zuerst die Auslenkungen: $A + A = 2A$. Die Intensität hängt quadratisch von der Amplitude ab, also $4 I$. Das ist keine neue Energie: An anderen Stellen löschen sich die Wellen aus, die Energie wird nur umverteilt.
Quelle: 6.4
Abbildung: energie-quelle

### Wie entsteht eine stehende Welle?
Zwei gleich starke Wellen mit gleicher Frequenz laufen gegeneinander, typisch eine Welle und ihre Reflexion. Ihre Summe ist
$ u = 2 A sin(k x) cos(omega t) $ Das Ortsmuster bleibt stehen, die Teilchen schwingen darin weiter auf und ab.
Quelle: 6.6
Abbildung: stehend-quelle

### Was sind Knoten und Bäuche, und wie weit liegen sie auseinander?
Knoten: Stellen, die immer in Ruhe sind. Bäuche: Stellen mit der größten Schwingungsamplitude. Zwei benachbarte Knoten (oder Bäuche) liegen $lambda\/2$ auseinander, Knoten und Bauch $lambda\/4$.
Quelle: 6.6
Abbildung: stehend-quelle

### Transportiert eine stehende Welle Energie?
Im Idealfall nicht netto. Die beiden gegenläufigen Wellen transportieren gleich viel Energie in entgegengesetzte Richtungen, das gleicht sich aus. Energie ist trotzdem in der Schwingung vorhanden.
Quelle: 6.6
Abbildung: stehend-quelle

### Was passiert bei der Reflexion am festen und am losen Ende?
Festes Ende: Der Punkt kann sich nicht bewegen, dort ist ein Knoten. Ein Berg kommt als Tal zurück (Phasensprung).

Loses Ende: Der Punkt darf frei schwingen, dort ist ein Bauch. Ein Berg kommt als Berg zurück.
Quelle: 6.6.1
Abbildung: reflexion-quelle

### Warum passen auf eine eingespannte Saite nur bestimmte Wellenlängen?
Beide Enden müssen Knoten sein. Dazwischen passen nur ganze Vielfache einer halben Wellenlänge:
$ L = n lambda/2, quad f_n = n c/(2L) $
Also Grundton und Obertöne $2 f_1$, $3 f_1$, …
Quelle: 6.7.1
Abbildung: mode-fest-quelle

### Was ändert sich beim Stimmen einer Saite?
Man ändert die Zugkraft. Damit ändert sich die Wellengeschwindigkeit c und damit alle Eigenfrequenzen gleichzeitig. Die erlaubten Wellenlängen bleiben gleich, denn die Länge bleibt gleich.
Quelle: 6.7.1
Abbildung: mode-fest-quelle

### Welche Moden passen bei einem festen und einem losen Ende?
Zwischen Knoten und Bauch passt in der Grundmode eine Viertelwellenlänge. Jede weitere Mode fügt eine halbe Wellenlänge dazu. Es passen nur ungerade Vielfache:
$ L = n lambda/4 quad "mit" n = 1, 3, 5, dots $

Achtung: Die zweite Mode hat hier $n = 3$, nicht $n = 2$. Beispiel: einseitig eingespannte Zunge, Luftsäule mit einem geschlossenen Ende.
Quelle: 6.7.2
Abbildung: mode-gemischt-quelle

### Welche Moden passen bei zwei losen Enden?
An beiden Enden ist ein Bauch. Es passen dieselben Wellenlängen wie bei zwei festen Enden, $L = n lambda\/2$ mit $n = 1, 2, 3, dots$, nur das Ortsbild ist anders: Knoten liegen innen, Bäuche an den Rändern.
Quelle: 6.7.3

### Zeichne die Begriffslandkarte zu Kapitel 6 aus dem Kopf: Welche Begriffe gehören dazu und wie hängen sie zusammen?
Die Quelle gibt Takt und Amplitude vor, das Medium die Geschwindigkeit; daraus folgt die Wellenlänge. Überlagerung und Ränder wählen stehende Eigenmoden, auf Flächen mit Knotenlinien. Im Raum bestimmt die Frontgeometrie die Intensitätsabnahme; Huygens verbindet Fronten mit Interferenz, Beugung, Reflexion und Brechung. Eine bewegte Quelle verändert die Frontabstände und damit den ankommenden Takt: Doppler-Effekt.
Quelle: 6.1


### Was sind Knotenlinien einer zweidimensionalen Eigenmode?
Linien auf einer schwingenden Fläche, die während der gesamten Bewegung unausgelenkt bleiben. Dazwischen schwingen Flächenbereiche. Die Form der Fläche und ihre Randbedingungen bestimmen, welche Eigenmoden möglich sind.
Quelle: 6.7.4
Abbildung: membran-knoten-quelle

### Warum sammelt sich Sand auf Knotenlinien einer schwingenden Platte?
Von schwingenden Bereichen wird Sand fortbewegt. An den ruhenden Knotenlinien sammelt er sich bevorzugt. So wird die räumliche Eigenmode sichtbar; ein momentaner Nulldurchgang allein wäre noch kein Knoten.
Quelle: 6.7.4
Abbildung: membran-knoten-quelle

### Wie unterscheiden sich ebene, Kugel- und Zylinderwellen?
Ihre Fronten sind parallele Ebenen, konzentrische Kugelflächen beziehungsweise Zylindermäntel. Dazu passen eine idealisierte flächige, punktförmige beziehungsweise lange linienförmige Quelle. Die Geometrie entscheidet, wie sich die Leistung beim Ausbreiten auf Flächen verteilt.
Quelle: 6.8.1
Abbildung: map-raumwellen

### Warum sinkt die Intensität einer Kugelwelle auch ohne Absorption?
Dieselbe Leistung verteilt sich auf Kugelflächen, die mit dem Quadrat des Radius wachsen: $I=P/(4 pi r^2)$. Bei doppeltem Abstand beträgt die Intensität nur ein Viertel. Die gesamte Leistung durch die Kugelfläche bleibt erhalten; es wird keine Energie vernichtet.
Quelle: 6.8.1
Abbildung: map-raumwellen

### Wie ändern sich Amplitude und Intensität einer Kugelwelle mit dem Abstand?
Im verlustfreien isotropen Modell gilt $I prop 1/r^2$. Bei festem Medium und Takt gilt zugleich $I prop u^2$, also $u prop 1/r$. Doppelte Entfernung halbiert damit die Amplitude, viertelt aber die Intensität.
Quelle: 6.8.1

### Warum nimmt die Intensität einer Zylinderwelle langsamer ab als die einer Kugelwelle?
Bei einer festen Länge der idealen Linienquelle wächst der Zylindermantel nur proportional zum Radius. Deshalb gilt $I prop 1/r$ statt $1/r^2$. Die Näherung einer sehr langen Linienquelle darf nicht beliebig weit von einer realen endlichen Quelle weg fortgesetzt werden.
Quelle: 6.8.1
Abbildung: map-raumwellen

### Was sagt das Huygenssche Prinzip über eine Wellenfront?
Jeder Punkt der alten Front wird als Ausgangspunkt einer Elementarwelle betrachtet. Nach derselben Zeit bildet die gemeinsame vordere Einhüllende dieser Elementarwellen die neue Front. Der Radius jeder Elementarwelle ist im homogenen Medium $c Delta t$.
Quelle: 6.8.2
Abbildung: huygens-quelle

### Was ergänzt Fresnel zur geometrischen Konstruktion nach Huygens?
Die Wellenfunktion am Ziel entsteht aus der Superposition aller Elementarwellen. Dabei müssen deren Phasen berücksichtigt werden, damit Verstärkung und Auslöschung richtig beschrieben werden. Die Einhüllende allein ist noch keine Berechnung der Intensität.
Quelle: 6.8.2
Abbildung: map-huygens

### Bedeutet ein zeitstabiles Interferenzmuster, dass die Teilchen nicht mehr schwingen?
Nein. Bei gleicher Frequenz und fester relativer Phase können die Orte der Verstärkung und Auslöschung beziehungsweise die gemittelte Intensitätsverteilung fest bleiben. Die momentane Auslenkung schwingt weiterhin. Gleiche Frequenz allein garantiert noch keine feste relative Phase.
Quelle: 6.8.2

### Warum darf man eine Phasendifferenz nicht direkt zu einer Weglänge addieren?
Weglängen stehen in Metern, Phasen in Radiant. Der Weg muss in Phase umgerechnet werden: $Delta phi=2 pi Delta s/lambda+Delta phi_0$. Alternativ entspricht die Anfangsphase der Wegverschiebung $lambda Delta phi_0/(2 pi)$.
Quelle: 6.8.3

### Wann darf man beim Doppelspalt mit dem Wegunterschied d mal Sinus des Winkels rechnen?
Nur im Fernfeld: Der Beobachtungsabstand muss viel größer als der Quellenabstand sein, damit die Wege nahezu parallel sind. Dann gilt $Delta s approx d sin(alpha)$. Im Nahfeld berechnet man beide Wege aus der tatsächlichen Geometrie und bildet ihre Differenz.
Quelle: 6.8.3
Abbildung: doppelspalt-quelle

### Warum garantiert eine Gegenphase noch keine vollständige Auslöschung?
Die Auslenkungen müssen zusätzlich am Beobachtungsort gleich große Amplituden besitzen. Bei unterschiedlichen Beträgen bleibt eine Restamplitude. Ein Interferenzminimum darf deshalb nicht automatisch mit vollständiger Stille gleichgesetzt werden.
Quelle: 6.8.3

### Was ist Beugung, und wie erklärt Huygens Wellen im Schatten?
Beugung ist die Ausbreitung von Wellen in den geometrischen Schatten eines Hindernisses. Die Elementarwellen der nicht blockierten Front an Öffnungen und Kanten reichen auch dorthin. Ihre Interferenz bestimmt die Stärke; die Kante erzeugt keine zusätzliche Energie.
Quelle: 6.8.4
Abbildung: beugung-quelle

### Wie hängen Beugung und Interferenz zusammen?
Beugung beschreibt, dass die Welle nicht auf gerade Strahlen beschränkt bleibt. Das Beugungsbild entsteht durch Interferenz der Elementarwellen mit ihren unterschiedlichen Phasen. Es sind zwei Blickwinkel auf dieselbe Ausbreitung, keine widersprüchlichen Erklärungen.
Quelle: 6.8.4

### Wie misst man die Winkel bei Reflexion und Brechung?
Zwischen der Ausbreitungsrichtung, also der Wellennormale, und dem Lot auf die Grenzfläche. Bei Reflexion sind Einfalls- und Ausfallswinkel betragsgleich. Misst man stattdessen zur Oberfläche oder zur Wellenfront, verwendet man andere Winkel und darf sie nicht unverändert in dieselben Formeln einsetzen.
Quelle: 6.8.5
Abbildung: reflexion-3d-quelle

### Was ändert sich bei Brechung in ein langsameres Medium, und was bleibt gleich?
An einer ruhenden Grenzfläche bleibt die Frequenz gleich. Die Wellenlänge wird im Verhältnis der Geschwindigkeiten kleiner: $lambda_2/lambda_1=c_2/c_1$. Bei schrägem Einfall wird die Wellennormale zum Lot hin gebrochen; bei senkrechtem Einfall ändert sie ihre Richtung nicht.
Quelle: 6.8.5
Abbildung: brechung-quelle

### Was verursacht den Doppler-Effekt bei bewegter Quelle und ruhendem Empfänger?
Der Sender rückt zwischen den Emissionen weiter. Vor ihm liegen die Fronten enger, hinter ihm weiter auseinander. Bei unverändertem $c$ zählt der ruhende Empfänger deshalb vorne mehr und hinten weniger Fronten pro Sekunde; der eigene Takt des Senders muss sich nicht ändern.
Quelle: 6.9.1
Abbildung: doppler-quelle

### Wie prüfst du beim Doppler-Effekt das richtige Vorzeichen?
Annäherung muss den Ton erhöhen: $f_"an"=f_S/(1-v_S/c)$ mit einem Nenner kleiner als eins. Entfernen senkt den Ton: $f_"ent"=f_S/(1+v_S/c)$. Für $v_S=0$ müssen beide Formeln wieder $f_S$ ergeben.
Quelle: 6.9.1
Abbildung: map-doppler

### Welche Voraussetzungen hat die Dopplerformel für die bewegte Quelle?
Der Empfänger ruht im ruhenden Medium, der Sender bewegt sich mit $v_S<c$ auf ihn zu oder von ihm weg. Die angegebenen Geschwindigkeitsbeträge gelten entlang der Verbindungslinie. Die Formel darf weder auf Licht noch ungeprüft auf einen bewegten Empfänger oder den seitlichen Moment einer Vorbeifahrt übertragen werden.
Quelle: 6.9.1
