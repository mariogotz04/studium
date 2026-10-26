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

## Kapitel 5 · Schwingungen

### Ein Federpendel gehorcht $dot.double(x) + 25 x = 0$ (in s⁻²). Wie groß ist die Eigenkreisfrequenz?
- [ ] 25 rad/s
  > 25 ist $omega_0^2$, nicht $omega_0$. Die Wurzel fehlt.
- [x] 5 rad/s
  > Aus $dot.double(x) + a x = 0$ liest man $omega_0 = sqrt(a) = sqrt(25) = 5$ rad/s ab.
- [ ] 0,8 Hz
  > $5 \/ (2 pi) approx "0,8"$ Hz wäre die Frequenz $f$. Gefragt ist die Kreisfrequenz.
- [ ] 12,5 rad/s
  > Hier wurde durch zwei geteilt statt die Wurzel gezogen.
Quelle: 5.0

### Wie hängen Frequenz $f$, Kreisfrequenz $omega$ und Periodendauer $T$ zusammen?
- [x] $omega = 2 pi f$ und $T = 1 \/ f$
  > Bei 2 Hz durchläuft der Sinus pro Sekunde $4 pi$ Radiant, deshalb sind $f$ und $omega$ verschiedene Zahlen für denselben Takt.
- [ ] $omega = f$ und $T = 2 pi \/ f$
  > $omega$ und $f$ unterscheiden sich um den Faktor $2 pi$. Und $T = 2 pi \/ omega$, nicht $2 pi \/ f$.
- [ ] $f = 2 pi omega$ und $T = omega$
  > Der Faktor steht auf der falschen Seite, und $T$ hat die Einheit s, $omega$ dagegen rad/s.
- [ ] $omega = f \/ (2 pi)$ und $T = f$
  > Umgekehrt: $omega$ ist größer als $f$. Und $T$ ist der Kehrwert von $f$.
Quelle: 5.0

### Zwei Stimmgabeln mit 440 Hz und 442 Hz klingen gleichzeitig. Was hört man?
- [ ] Einen 2-Hz-Ton
  > 2 Hz ist viel zu tief zum Hören. Die 2 Hz beschreiben, wie oft der Betrag anschwillt.
- [x] Einen Ton von etwa 441 Hz, der zweimal pro Sekunde lauter und leiser wird
  > Mittenfrequenz $f_m = (440 + 442) \/ 2 = 441$ Hz, Schwebungsfrequenz $f_s = abs(f_1 - f_2) = 2$ Hz.
- [ ] Zwei getrennte Töne von 440 und 442 Hz
  > So nah beieinander verschmelzen die Töne zu einem, dessen Lautstärke schwankt.
- [ ] Einen Ton von 882 Hz
  > Die Frequenzen addieren sich nicht. Die Summe der Auslenkungen schwingt mit der mittleren Frequenz.
Quelle: 5.4.1

### Wie lang ist die Schwebungsdauer $T_s$ bei 440 Hz und 442 Hz?
- [ ] 1 s
  > Das wäre die Periode der Kosinushülle mit $(f_1 - f_2)\/2 = 1$ Hz. Ihr Betrag hat aber pro Periode zwei Maxima.
- [x] 0,5 s
  > $T_s = 1 \/ f_s = 1 \/ (2 thin "Hz") = "0,5"$ s. Der Faktor zwei zählt.
- [ ] 2 s
  > Hier wurde $T_s = f_s$ gesetzt. Die Dauer ist der Kehrwert der Frequenz.
- [ ] 0,0023 s
  > Das ist ungefähr die Periode des schnellen 441-Hz-Tons, nicht die der Schwebung.
Tipp: $f_s = abs(f_1 - f_2)$, dann Kehrwert.
Quelle: 5.4.1

### Beim Stimmen einer Gitarre nähert sich eine Saite dem Referenzton. Wie verändert sich die Schwebung?
- [ ] Sie wird schneller.
  > Die Richtung ist vertauscht. Die Schwebungsfrequenz ist die Differenz der Frequenzen.
- [x] Sie wird langsamer und verschwindet bei gleicher Frequenz.
  > $f_s = abs(f_1 - f_2)$ geht gegen null, $T_s$ wächst unbegrenzt. Daran stimmt man nach Gehör.
- [ ] Sie bleibt gleich, nur der Ton wird höher.
  > Die Schwebung hängt direkt von der Differenz ab, die sich ja ändert.
- [ ] Sie wird lauter.
  > Die Lautstärke der Maxima hängt an den Amplituden, nicht an der Frequenzdifferenz.
Quelle: 5.4.1

### Wann löschen sich zwei überlagerte Schwingungen im Schwebungsminimum vollständig aus?
- [x] Wenn ihre Amplituden gleich groß sind
  > Nur dann ist $A_1 - A_2 = 0$. Bei ungleichen Amplituden bleibt ein Restminimum.
- [ ] Wenn ihre Frequenzen gleich sind
  > Bei gleichen Frequenzen gibt es gar keine Schwebung mehr.
- [ ] Immer, unabhängig von den Amplituden
  > Bei ungleichen Amplituden bleibt im Minimum $abs(A_1 - A_2)$ übrig.
- [ ] Nur wenn die Frequenzen sich um genau 1 Hz unterscheiden
  > Die Frequenzdifferenz bestimmt den Rhythmus, nicht die Tiefe des Minimums.
Quelle: 5.4.1

### Zwei gleiche Federpendel sind über eine Kopplungsfeder $D_k$ verbunden. Welche Aussagen über die Eigenmoden stimmen?
- [x] Im Gleichtakt ($x_1 = x_2$) wirkt die Kopplungsfeder nicht, also $omega_"gl" = sqrt(D \/ m)$.
  > Beide Massen verschieben sich gleich weit, ihr Abstand bleibt gleich. Die Kopplungsfeder wird nicht gedehnt.
- [x] Im Gegentakt ($x_1 = -x_2$) gilt $omega_"gg" = sqrt((D + 2 D_k) \/ m)$.
  > Die Kopplungsfeder wird um $2 abs(x)$ gedehnt. Das liefert die zusätzliche Rückstellung $2 D_k$.
- [ ] Die Gegentaktfrequenz ist kleiner als die Gleichtaktfrequenz.
  > Umgekehrt: Die zusätzliche Rückstellung durch die Kopplungsfeder macht den Gegentakt schneller.
- [ ] Im Gegentakt ist die Kopplungsfeder zu jedem Zeitpunkt maximal gedehnt.
  > Beim Durchgang durch die Ruhelage ist die Dehnung null. „Maximal belastet“ heißt nur, dass die Dehnung bei gleicher Auslenkung besonders groß ist.
Quelle: 5.4.2

### Mit welchen Hilfsgrößen entkoppelt man die Bewegungsgleichungen zweier gekoppelter Pendel?
- [ ] $psi_1 = x_1 dot x_2$ und $psi_2 = x_1 \/ x_2$
  > Produkt und Quotient machen die Gleichungen nichtlinear. Man braucht lineare Kombinationen.
- [x] $psi_1 = x_1 + x_2$ und $psi_2 = x_1 - x_2$
  > Addieren und Subtrahieren der Gleichungen liefert zwei unabhängige Gleichungen wie beim einzelnen Federpendel.
- [ ] $psi_1 = x_1$ und $psi_2 = x_2$
  > Das sind die ursprünglichen Koordinaten, und die sind gerade gekoppelt.
- [ ] $psi_1 = dot(x)_1$ und $psi_2 = dot(x)_2$
  > Geschwindigkeiten statt Auslenkungen zu nehmen, löst die Kopplung nicht.
Quelle: 5.4.2

### Man lenkt Pendel 1 aus und lässt es los, Pendel 2 ruht. Was beobachtet man?
Antwort: Die Schwingung wandert langsam von Pendel 1 zu Pendel 2 und wieder zurück. Mathematisch ist die Bewegung eine Überlagerung von Gleich- und Gegentaktmode mit leicht verschiedenen Frequenzen. Das ergibt eine Schwebung: $x_1$ hat die Hülle $cos(Delta omega t\/2)$, $x_2$ die Hülle $sin(Delta omega t\/2)$, die Hüllen wechseln sich ab. Nach etwa $T_s\/2$ schwingt fast nur noch Pendel 2. Ein vollständiger Zyklus dauert $T_s = 2 pi \/ (omega_"gg" - omega_"gl")$.
Tipp: Welche zwei Eigenmoden stecken in diesem Anfangszustand, und was passiert, wenn man zwei ähnliche Frequenzen addiert?
Quelle: 5.4.3

### Die Kopplungsfeder wird steifer. Wie ändert sich die Austauschzeit $T_s$?
- [ ] Sie wird länger.
  > Steifere Kopplung vergrößert den Frequenzabstand, und ein größerer Abstand heißt schnellere Schwebung.
- [x] Sie wird kürzer.
  > Größeres $D_k$ erhöht $omega_"gg"$, $omega_"gl"$ bleibt gleich. Also wächst $omega_"gg" - omega_"gl"$ und $T_s$ sinkt.
- [ ] Sie bleibt gleich, weil beide Eigenfrequenzen gleich stark steigen.
  > Die Gleichtaktfrequenz hängt gar nicht von $D_k$ ab.
- [ ] Sie wird null, die Energie wechselt sofort.
  > $T_s$ wird kleiner, aber bleibt endlich.
Quelle: 5.4.3

## Kapitel 6 · Wellen

### Bei einer Seilwelle läuft ein Wellenberg von links nach rechts. Was machen die einzelnen Seilstücke?
- [ ] Sie laufen mit dem Wellenberg nach rechts.
  > Wie bei einer Stadionwelle bleiben die Teilchen an ihrem Platz. Nur das Muster wandert.
- [x] Sie bewegen sich um ihre Ruhelage, hier senkrecht zur Ausbreitungsrichtung.
  > Das ist eine Transversalwelle. Weitergegeben wird der Schwingungszustand, und damit Energie.
- [ ] Sie bewegen sich parallel zur Ausbreitungsrichtung hin und her.
  > Das wäre eine Longitudinalwelle wie Schall in Luft.
- [ ] Sie bleiben vollständig in Ruhe.
  > Dann gäbe es keine Auslenkung und keine Welle.
Quelle: 6.1

### Schall breitet sich in Luft als ___welle aus, eine Welle auf einem gespannten Seil ist eine ___welle.
Antwort: Longitudinal/Laengs/Dichte/Druck | Transversal/Quer
Tipp: Schwingen die Teilchen parallel oder senkrecht zur Ausbreitungsrichtung?
Erklärung: Schall in Gasen ist longitudinal: Verdichtungen und Verdünnungen wandern. Am Seil schwingen die Stücke senkrecht zur Laufrichtung, die Welle ist transversal.
Quelle: 6.1

### In welche Richtung läuft die Welle $psi(x,t) = u(x + c t)$?
- [ ] In $+x$-Richtung
  > Das gilt für $u(x - c t)$. Ein Plus im Argument bedeutet die Gegenrichtung.
- [x] In $-x$-Richtung
  > Ein fester Wellenberg hat $x + c t = a$, also $x = a - c t$. Sein Ort nimmt mit der Zeit ab.
- [ ] Sie steht still.
  > Eine stehende Welle hat die Form $f(x) g(t)$, nicht $u(x + c t)$.
- [ ] Das hängt von der Form von $u$ ab.
  > Die Form legt fest, wie die Welle aussieht. Die Richtung steckt allein im Vorzeichen vor $c t$.
Tipp: Halte das Argument konstant und löse nach $x$ auf.
Quelle: 6.1.1

### Schall mit $c = 343$ m/s und $f = 440$ Hz. Wie groß ist die Wellenlänge?
- [ ] 1,28 m
  > Hier wurde $f \/ c$ gerechnet. Es ist $lambda = c \/ f$.
- [x] etwa 0,78 m
  > $lambda = 343 \/ 440 thin "m" approx "0,780"$ m.
- [ ] 150.920 m
  > Hier wurden $c$ und $f$ multipliziert. Die Einheit wäre dann m/s², keine Länge.
- [ ] 343 m
  > Das ist die Strecke, die der Schall in einer Sekunde zurücklegt.
Tipp: $c = lambda f$
Quelle: 6.2

### Eine Schallwelle läuft von Luft in Wasser. Was bleibt gleich?
- [ ] Die Wellenlänge
  > Die Wellenlänge passt sich an: $lambda = c\/f$, und $c$ ist im Wasser größer.
- [ ] Die Ausbreitungsgeschwindigkeit
  > $c$ hängt vom Medium ab und ändert sich beim Übergang.
- [x] Die Frequenz
  > Die Quelle gibt den Takt vor. Beim Übergang zwischen ruhenden Medien bleibt $f$ gleich, $c$ und $lambda$ ändern sich.
- [ ] Frequenz und Wellenlänge
  > Wenn $f$ gleich bleibt und sich $c$ ändert, muss sich $lambda$ ändern.
Quelle: 6.2

### Wie unterscheidet sich die Schnelle $s$ von der Ausbreitungsgeschwindigkeit $c$?
- [x] $s$ ist die Geschwindigkeit eines Teilchens am Ort, $c$ die Geschwindigkeit, mit der das Muster wandert.
  > Ein Luftteilchen fliegt nicht mit 343 m/s zum Zuhörer. Es schwingt lokal mit $s = partial psi \/ partial t$.
- [ ] Beide sind dasselbe, nur anders bezeichnet.
  > Das ist der klassische Denkfehler. Die Bewegungen sind verschieden.
- [ ] $s$ ist immer größer als $c$.
  > Ein fester Zusammenhang besteht nicht. $s_"max" = psi_0 omega$ hängt von der Amplitude ab, $c$ vom Medium.
- [ ] Die Schnelle ist am Ort maximaler Auslenkung am größten.
  > Dort ist sie null. Ihr Betrag ist beim Durchgang durch die Ruhelage maximal.
Quelle: 6.2.1

### Die Zugkraft einer Saite wird vervierfacht. Wie ändert sich die Ausbreitungsgeschwindigkeit?
- [ ] Sie vervierfacht sich.
  > $F$ steht unter der Wurzel. Faktor 4 in der Kraft heißt nicht Faktor 4 in $c$.
- [x] Sie verdoppelt sich.
  > $c = sqrt(F \/ (rho A))$, also $sqrt(4) = 2$.
- [ ] Sie halbiert sich.
  > Eine größere Zugkraft macht die Welle schneller, nicht langsamer.
- [ ] Sie bleibt gleich.
  > Die Saitenspannung ist gerade die Größe, mit der man beim Stimmen $c$ und damit den Ton ändert.
Quelle: 6.3

### In Luft beträgt die Schallgeschwindigkeit bei 0 °C etwa 330 m/s. Warum darf man für 20 °C nicht einfach $sqrt(20 \/ 0)$ rechnen?
Antwort: Im Verhältnis $c_2 \/ c_1 = sqrt(T_2 \/ T_1)$ steht die absolute Temperatur in Kelvin. Celsiuswerte sind gegenüber Kelvin verschoben, 0 °C sind 273,15 K. Man muss also $sqrt("293,15" \/ "273,15") approx "1,036"$ rechnen und erhält etwa 342 m/s, passend zu den 343 m/s aus dem Skript.
Tipp: Welche Temperaturskala steckt in $c = sqrt(kappa R T \/ m_"mol")$?
Quelle: 6.3

### Die Amplitude einer Welle wird verdoppelt, alles andere bleibt gleich. Wie ändert sich die Intensität?
- [ ] Sie verdoppelt sich.
  > Die Intensität hängt quadratisch von der Amplitude ab, nicht linear.
- [x] Sie vervierfacht sich.
  > $I = 1\/2 rho c omega^2 psi_0^2$, also Faktor $2^2 = 4$.
- [ ] Sie bleibt gleich, weil die Energie erhalten bleibt.
  > Eine größere Amplitude heißt mehr transportierte Energie pro Zeit und Fläche.
- [ ] Sie steigt um den Faktor $sqrt(2)$.
  > Die Wurzel gehört zu $c$, nicht zur Intensität.
Quelle: 6.4

### Zwei gleich starke, gleichphasige Wellen treffen am selben Ort zusammen. Wie groß ist dort die Intensität im Vergleich zu einer einzelnen Welle?
- [ ] Doppelt so groß
  > Man addiert zuerst die Auslenkungen: $A + A = 2A$. Die Intensität geht mit dem Quadrat.
- [x] Viermal so groß
  > $(2A)^2 = 4 A^2$, also $I_"res" = 4 I_"einzeln"$. Lokal ist das keine neue Energie, an anderen Orten wird es dafür dunkler bzw. leiser.
- [ ] Genauso groß
  > Gleichphasig heißt konstruktiv. Die Auslenkung verdoppelt sich.
- [ ] Null
  > Null wäre der destruktive Fall mit Phasendifferenz $pi$.
Quelle: 6.5

### Zwei gleichphasige Lautsprecher stehen unterschiedlich weit von Dir weg. Bei welchem Wegunterschied hörst Du ein Minimum?
- [ ] Bei einer ganzen Wellenlänge
  > Dann kommen die Wellen phasengleich an, das gibt ein Maximum.
- [x] Bei einer halben Wellenlänge
  > $Delta phi = 2 pi Delta l \/ lambda = pi$. Berg trifft Tal, destruktive Interferenz.
- [ ] Bei einer Viertelwellenlänge
  > $Delta phi = pi\/2$ ergibt einen Zwischenfall, die Amplitude ist $sqrt(2) A$.
- [ ] Bei null Wegunterschied
  > Ohne Wegunterschied sind die Wellen gleichphasig. Das ist ein Maximum.
Quelle: 6.5

### Wie groß ist bei einer stehenden Welle der Abstand zwischen zwei benachbarten Knoten?
- [ ] $lambda$
  > Das steht zwar im Fließtext der Vorlesung, ist aber ein Quellenfehler. Aus $sin(k x) = 0$ folgt $lambda\/2$.
- [x] $lambda \/ 2$
  > Knoten liegen bei $x = j lambda \/ 2$. Zwischen Knoten und Bauch liegt $lambda\/4$.
- [ ] $lambda \/ 4$
  > Das ist der Abstand zwischen einem Knoten und dem benachbarten Bauch.
- [ ] $2 lambda$
  > Dafür gibt es keine Herleitung. Knoten liegen dichter.
Quelle: 6.6

### Ein Wellenberg läuft auf ein festes Seilende zu. Wie kommt er zurück?
- [ ] Als Berg, weil das Ende den Puls einfach spiegelt
  > Das passiert am losen Ende. Am festen Ende muss die Auslenkung immer null sein.
- [x] Als Tal, also invertiert
  > Am festen Ende liegt ein Knoten. Damit die Summe dort null bleibt, kommt der Puls umgedreht zurück.
- [ ] Gar nicht, das feste Ende schluckt die Welle
  > Im Idealmodell wird die Welle vollständig reflektiert.
- [ ] Mit doppelter Amplitude
  > Die Amplitude bleibt im Idealmodell gleich, nur das Vorzeichen dreht sich.
Quelle: 6.6.1

### Eine Saite der Länge $L = "0,5"$ m ist an beiden Enden fest, $c = 200$ m/s. Wie hoch ist die Grundfrequenz?
- [ ] 100 Hz
  > Das wäre $f = c \/ (4 L)$, also fest–lose. Hier sind beide Enden fest.
- [x] 200 Hz
  > $f_1 = c \/ (2 L) = 200 \/ 1 = 200$ Hz. In die Saite passt eine halbe Wellenlänge.
- [ ] 400 Hz
  > Hier wurde $c\/L$ gerechnet, das ist schon die zweite Mode.
- [ ] 50 Hz
  > Das wäre $c\/(8L)$. Dafür gibt es keine passende Randbedingung.
Tipp: Fest–fest: $L = n lambda_n \/ 2$
Quelle: 6.7.1

### Ein Rohr ist an einem Ende geschlossen und am anderen offen. Welche Frequenzen kommen als Eigenmoden vor?
- [ ] $f_1, 2 f_1, 3 f_1, dots$
  > Diese Folge gilt für fest–fest und lose–lose.
- [x] $f_1, 3 f_1, 5 f_1, dots$
  > Zwischen Knoten und Bauch passen nur ungerade Vielfache von $lambda\/4$: $f_n = n c \/ (4 L)$ mit $n = 1, 3, 5, dots$.
- [ ] $f_1, 2 f_1, 4 f_1, dots$
  > Für Zweierpotenzen gibt es keine Randbedingung.
- [ ] Nur $f_1$
  > Es gibt auch höhere Moden. Sie sind nur auf ungerade Vielfache beschränkt.
Quelle: 6.7.2

### Bei fest–losem Ende fragt eine Aufgabe nach der „zweiten Mode“. Welches $n$ setzt Du in $f_n = n c \/ (4 L)$ ein?
- [ ] $n = 2$
  > $n = 2$ ist hier gar nicht erlaubt. Die Zählweise ist der typische Fehler.
- [x] $n = 3$
  > Erlaubt sind nur $n = 1, 3, 5, dots$. Die zweite tatsächlich vorhandene Mode hat also $n = 3$.
- [ ] $n = 4$
  > Gerade $n$ sind bei fest–lose nicht möglich.
- [ ] $n = 1$
  > $n = 1$ ist die Grundmode, also die erste.
Quelle: 6.7.2
