# Karteikarten · Physik

<!--
So ist diese Datei aufgebaut (die Webseite liest sie beim Hochladen automatisch ein):
- "## Kapitel …" beginnt ein Kapitel (Filter auf der Webseite).
- "### Frage" ist die Vorderseite einer Karte. Alles darunter bis zur nächsten ### ist die Rückseite.
- Auf der Rückseite gehen Absätze (Leerzeile), Listen (- …), **fett** und *kursiv*.
- Eine Zeile "Bild: …" erscheint als Merkbild (Analogie im Feynman-Stil) unten auf der Karte.
- Nur Verständnisfragen, keine Rechenaufgaben. Antworten kurz, einfach, in eigenen Worten.
- Den Fragetext nur ändern, wenn nötig: Der Lernfortschritt hängt am Wortlaut der Frage.
-->

## Kapitel 5 · Schwingungen

### Warum schwingt ein Federpendel immer wieder durch die Ruhelage hindurch?
Die ausgelenkte Feder zieht die Masse zur Ruhelage zurück. Dort hat die Masse ihre größte Geschwindigkeit und fliegt wegen ihrer Trägheit darüber hinaus. Jetzt bremst die Feder sie wieder ab und zieht zurück. Ohne Dämpfung wiederholt sich das ewig.

### Wovon hängt die Eigenfrequenz eines Federpendels ab?
ω₀ = √(D/m). Eine härtere Feder (größeres D) macht die Schwingung schneller, eine größere Masse langsamer. Die Amplitude spielt keine Rolle.

### Was ist der Unterschied zwischen f und ω?
f zählt vollständige Schwingungen pro Sekunde (Hz). ω ist die Kreisfrequenz in rad/s: ω = 2πf. Es sind zwei Zahlen für denselben Takt. Bei 2 Hz durchläuft der Sinus 4π Radiant pro Sekunde.

### Wann entsteht eine Schwebung, und warum wird der Ton lauter und leiser?
Wenn zwei Schwingungen mit fast gleicher Frequenz überlagert werden. Ihre Phasen verschieben sich langsam gegeneinander: Mal sind sie im Takt und verstärken sich, mal gegeneinander und löschen sich aus.

Bild: Zwei Läufer mit fast gleichem Tempo: Sie laufen eine Weile nebeneinander, dann auseinander, und treffen sich nach jeder Überrundung wieder.

### Was hört man bei 440 Hz und 442 Hz zusammen?
Einen Ton nahe 441 Hz (der schnelle Träger, die Mittenfrequenz), der zweimal pro Sekunde an- und abschwillt. Die 2 Hz sind kein eigener Ton, sondern der Rhythmus der Lautstärke: f_s = |f₁ − f₂|.

### Warum ist die hörbare Schwebungsfrequenz doppelt so groß wie die Frequenz der Kosinushülle?
Die Hülle 2A·cos(Δω·t/2) wechselt zwischen +2A und −2A. Laut ist es aber bei beiden Extremen, denn das Ohr hört den Betrag. Pro Periode der Kosinushülle gibt es also zwei Lautstärkemaxima.

### Wie nutzt man die Schwebung zum Stimmen eines Instruments?
Man spielt Saite und Stimmgabel zusammen. Je näher die Frequenzen, desto langsamer die Schwebung. Wird sie beim Nachspannen langsamer, ist man auf dem richtigen Weg. Verschwindet sie ganz, sind die Frequenzen gleich.

### Braucht eine Schwebung gleiche Amplituden?
Nein. Mit gleichen Amplituden löschen sich die Schwingungen im Minimum vollständig aus. Bei ungleichen Amplituden bleibt ein Restminimum, die Schwebung ist dann weniger ausgeprägt.

### Was ist der Unterschied zwischen Überlagerung und Kopplung zweier Schwingungen?
Bei der Überlagerung addiert man zwei Bewegungen, die sich gegenseitig nicht beeinflussen. Bei der Kopplung wirkt ein Schwinger auf den anderen, z. B. über eine Feder zwischen zwei Pendeln, die Kräfte und Energie überträgt.

### Warum hängt die Kraft der Kopplungsfeder vom Unterschied der Auslenkungen ab?
Die mittlere Feder wird nur gedehnt oder gestaucht, wenn sich der Abstand der Massen ändert, also um x₂ − x₁. Bewegen sich beide gleich weit, bleibt sie entspannt.

### Warum rechnet man bei gekoppelten Pendeln mit Summe und Differenz der Auslenkungen?
Die beiden Bewegungsgleichungen hängen voneinander ab. Addiert und subtrahiert man sie, entstehen zwei unabhängige Gleichungen, jede wie ein einzelnes Federpendel. Danach rechnet man mit x₁ = (ψ₁ + ψ₂)/2 und x₂ = (ψ₁ − ψ₂)/2 zurück.

### Was ist eine Eigenmode?
Eine feste gemeinsame Schwingungsform aller beteiligten Massen. Alle schwingen mit derselben Frequenz, und das Verhältnis ihrer Amplituden bleibt gleich.

### Was passiert bei gekoppelten Pendeln im Gleichtakt und im Gegentakt?
Gleichtakt: Beide bewegen sich gleich, die Kopplungsfeder bleibt entspannt. Frequenz wie beim einzelnen Pendel: ω_gl = √(D/m).

Gegentakt: Beide bewegen sich entgegengesetzt, die Kopplungsfeder wird stark gedehnt und zieht zusätzlich zurück. Deshalb ist die Frequenz höher: ω_gg = √((D + 2D_k)/m).

### Ein Pendel wird ausgelenkt, das gekoppelte zweite ruht. Was passiert dann?
Die Schwingung wandert langsam zum zweiten Pendel hinüber, bis das erste fast ruht, und dann wieder zurück. Mathematisch ist das wieder eine Schwebung aus den beiden Eigenfrequenzen (Gleich- und Gegentakt).

### Was bewirkt eine härtere Kopplungsfeder?
Die Gleichtaktfrequenz bleibt gleich, die Gegentaktfrequenz steigt. Die beiden Frequenzen liegen weiter auseinander, also wird der Energieaustausch zwischen den Pendeln schneller.

### Wie viele Eigenmoden haben N gekoppelte Schwinger, und was ist der Schritt zur Welle?
N linear gekoppelte Schwinger mit je einem Freiheitsgrad haben N Eigenmoden. Koppelt man sehr viele hintereinander, wird die Störung von Glied zu Glied weitergereicht: Daraus wird eine Welle.

## Kapitel 6 · Wellen

### Was ist eine Welle, und was wandert dabei eigentlich?
Eine sich ausbreitende Störung. Die Teilchen schwingen nur um ihre Ruhelage, sie reisen nicht mit. Was wandert, ist das Muster des Schwingungszustands und die Energie.

Bild: Stadionwelle: Die Menschen bleiben auf ihren Plätzen, nur das Aufstehen wandert durchs Stadion.

### Was unterscheidet longitudinale von transversalen Wellen?
Longitudinal: Die Teilchen schwingen in Ausbreitungsrichtung, es gibt Verdichtungen und Verdünnungen. Beispiel: Schall in Luft.

Transversal: Die Teilchen schwingen quer zur Ausbreitung. Beispiel: Seilwelle. Im Inneren eines Mediums braucht das eine seitliche Rückstellkraft (Scherkraft), deshalb gibt es sie nur in Festkörpern.

### Muss eine Welle periodisch sein?
Nein. Ein einzelner Knall oder ein einmaliges Zupfen erzeugt einen Puls, also eine einzelne wandernde Störung.

### Woran erkennt man an ψ(x, t) = u(x − ct), in welche Richtung die Welle läuft?
Ein bestimmter Wellenberg hat ein festes Argument: x − ct = konstant, also x = konstant + ct. Sein Ort wächst mit der Zeit, die Welle läuft nach +x. Bei u(x + ct) läuft sie nach −x.

### Was ist der Unterschied zwischen Wellenlänge und Periodendauer?
Die Wellenlänge λ ist die räumliche Wiederholung: der Abstand zweier gleicher Punkte in einer Momentaufnahme. Die Periodendauer T ist die zeitliche Wiederholung: wie lange ein fester Ort für eine Schwingung braucht.

### Warum gilt c = λ·f?
In einer Periodendauer T rückt ein Wellenberg genau um eine Wellenlänge λ vor. Also ist c = λ/T = λ·f.

### Was legt die Quelle fest und was das Medium?
Die Quelle gibt den Takt vor, also die Frequenz f. Das Medium bestimmt die Ausbreitungsgeschwindigkeit c. Daraus ergibt sich die Wellenlänge λ = c/f. Beim Übergang in ein anderes Medium bleibt f gleich, c und λ ändern sich.

### Was ist der Unterschied zwischen Schnelle und Ausbreitungsgeschwindigkeit?
Die Schnelle ist die Geschwindigkeit, mit der ein einzelnes Teilchen hin und her schwingt. Die Ausbreitungsgeschwindigkeit c ist die Geschwindigkeit, mit der das Muster (z. B. ein Wellenberg) wandert. Ein Luftteilchen fliegt also nicht mit 343 m/s zum Zuhörer.

### Wo ist die Schnelle eines Teilchens am größten und wo null?
Am Umkehrpunkt (maximale Auslenkung) ist sie null. Beim Durchgang durch die Ruhelage ist sie am größten, wie beim Pendel.

### Was sind Wellenfronten?
Punkte mit gleichem Schwingungszustand, also gleicher Phase. Gleiche Auslenkung allein reicht nicht, auch die Bewegungsrichtung muss passen.

### Warum hängt die Wellengeschwindigkeit von Steifigkeit und Dichte des Mediums ab?
Die Nachbarteilchen müssen sich die Bewegung weitergeben. Starke Rückstellkräfte (Steifigkeit, Spannung) beschleunigen die Weitergabe, große Trägheit (Dichte) bremst sie. Deshalb steht in den Formeln meist √(Steifigkeit/Dichte).

### Was passiert mit der Wellengeschwindigkeit auf einer Saite bei vierfacher Spannung?
c = √(F/(ρA)). Vierfache Zugkraft gibt doppelte Geschwindigkeit, wegen der Wurzel. Vierfache Dichte würde sie halbieren.

### Wovon hängt die Schallgeschwindigkeit in einem idealen Gas ab?
c = √(κRT/m_mol). Bei demselben Gas nur von der absoluten Temperatur: c ∝ √T. Wärmere Luft leitet Schall schneller (etwa 330 m/s bei 0 °C, 343 m/s bei 20 °C). T muss in Kelvin stehen.

### Was ist die Intensität einer Welle?
Die Leistung pro Fläche senkrecht zur Ausbreitung: I = P/F in W/m². Eine größere Empfangsfläche fängt mehr Leistung ein, die Intensität selbst bleibt dabei gleich.

### Wie hängt die Intensität von Amplitude und Frequenz ab?
I = ½·ρ·c·ω²·u². Sie wächst mit dem Quadrat der Amplitude und dem Quadrat der Frequenz. Doppelte Amplitude gibt vierfache Intensität.

### Was passiert, wenn sich zwei Wellen treffen?
An jedem Ort addieren sich ihre Auslenkungen (Superposition). Danach laufen beide ungestört weiter. Berg auf Berg gibt doppelte Höhe (konstruktiv), Berg auf Tal löscht sich aus (destruktiv), wenn die Amplituden gleich sind.

### Wann ist die Interferenz zweier gleichphasiger Quellen konstruktiv oder destruktiv?
Es zählt der Wegunterschied Δl. Ganze Wellenlängen: konstruktiv. Ungerade halbe Wellenlängen: destruktiv.

### Warum gibt doppelte Amplitude bei Interferenz die vierfache Intensität, und ist das Energie aus dem Nichts?
Man addiert zuerst die Auslenkungen: A + A = 2A. Die Intensität hängt quadratisch von der Amplitude ab, also 4·I. Das ist keine neue Energie: An anderen Stellen löschen sich die Wellen aus, die Energie wird nur umverteilt.

### Wie entsteht eine stehende Welle?
Zwei gleich starke Wellen mit gleicher Frequenz laufen gegeneinander, typisch eine Welle und ihre Reflexion. Ihre Summe ist 2A·sin(kx)·cos(ωt): Das Ortsmuster bleibt stehen, die Teilchen schwingen darin weiter auf und ab.

### Was sind Knoten und Bäuche, und wie weit liegen sie auseinander?
Knoten: Stellen, die immer in Ruhe sind. Bäuche: Stellen mit der größten Schwingungsamplitude. Zwei benachbarte Knoten (oder Bäuche) liegen λ/2 auseinander, Knoten und Bauch λ/4.

### Transportiert eine stehende Welle Energie?
Im Idealfall nicht netto. Die beiden gegenläufigen Wellen transportieren gleich viel Energie in entgegengesetzte Richtungen, das gleicht sich aus. Energie ist trotzdem in der Schwingung vorhanden.

### Was passiert bei der Reflexion am festen und am losen Ende?
Festes Ende: Der Punkt kann sich nicht bewegen, dort ist ein Knoten. Ein Berg kommt als Tal zurück (Phasensprung).

Loses Ende: Der Punkt darf frei schwingen, dort ist ein Bauch. Ein Berg kommt als Berg zurück.

### Warum passen auf eine eingespannte Saite nur bestimmte Wellenlängen?
Beide Enden müssen Knoten sein. Dazwischen passen nur ganze Vielfache einer halben Wellenlänge: L = n·λ/2. Daraus folgen die Eigenfrequenzen f_n = n·c/(2L), also Grundton und Obertöne 2f₁, 3f₁, …

### Was ändert sich beim Stimmen einer Saite?
Man ändert die Zugkraft. Damit ändert sich die Wellengeschwindigkeit c und damit alle Eigenfrequenzen gleichzeitig. Die erlaubten Wellenlängen bleiben gleich, denn die Länge bleibt gleich.

### Welche Moden passen bei einem festen und einem losen Ende?
Zwischen Knoten und Bauch passt in der Grundmode eine Viertelwellenlänge. Jede weitere Mode fügt eine halbe Wellenlänge dazu. Es passen nur ungerade Vielfache: L = n·λ/4 mit n = 1, 3, 5, …

Achtung: Die zweite Mode hat hier n = 3, nicht n = 2. Beispiel: einseitig eingespannte Zunge, Luftsäule mit einem geschlossenen Ende.

### Welche Moden passen bei zwei losen Enden?
An beiden Enden ist ein Bauch. Es passen dieselben Wellenlängen wie bei zwei festen Enden, L = n·λ/2 mit n = 1, 2, 3, …, nur das Ortsbild ist anders: Knoten liegen innen, Bäuche an den Rändern.
