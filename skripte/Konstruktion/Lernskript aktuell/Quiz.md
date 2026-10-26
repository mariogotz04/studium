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

## Kapitel 1–2 · Grundlagen und CAD

### Warum verwendet man für die Technische Zeichnung die senkrechte Parallelprojektion?
- [ ] Weil sie wie ein Foto wirkt und am anschaulichsten ist.
  > Das trifft auf die Perspektive (Zentralprojektion) zu. Dort werden ferne Kanten aber kleiner, man kann nicht messen.
- [x] Weil Flächen parallel zur Bildebene unverzerrt in wahrer Größe erscheinen.
  > Die Strahlen laufen parallel und senkrecht zur Bildebene. Deshalb besteht eine Zeichnung aus mehreren solchen Ansichten.
- [ ] Weil darin auch schräge Flächen immer in wahrer Größe erscheinen.
  > Geneigte Flächen werden auch hier verkürzt. Dafür gibt es Zusatzansichten senkrecht auf die schräge Fläche.
- [ ] Weil sie nur eine einzige Ansicht braucht.
  > Meist braucht man mehrere Ansichten, bis zu sechs.
Quelle: 1.1

### Wie viele A4-Blätter passen flächenmäßig in ein A0-Blatt?
- [ ] 4
  > Von A0 nach A4 sind es vier Halbierungen, nicht vier Blätter.
- [ ] 8
  > Das wäre A3, drei Halbierungen.
- [x] 16
  > Vier Halbierungen: $2^4 = 16$. A0 hat 1 m², A4 also $1\/16$ m².
- [ ] 32
  > Das wäre A5.
Quelle: 1.3

### Wo steht das Schriftfeld, und warum gerade dort?
- [ ] Oben links, weil man dort zu lesen beginnt
  > Nach dem Falten wäre es dann verdeckt.
- [x] Unten rechts, weil es nach dem Falten auf A4 sichtbar bleibt
  > Fest vorgeschrieben ist nur die Breite von 180 mm, damit es auf A4 passt.
- [ ] Unten links neben dem Heftrand
  > Am Heftrand wird gelocht, dort steht das Schriftfeld nicht.
- [ ] Beliebig, Hauptsache auf dem Blatt
  > Die Lage ist genormt: immer unten rechts.
Quelle: 1.3

### Was ist der Unterschied zwischen einer Zusammenbauzeichnung und einer Einzelteilzeichnung?
- [x] Die Zusammenbauzeichnung zeigt, wie die Teile zusammengehören, mit Positionsnummern und nur Haupt- und Anschlussmaßen.
  > Dazu gehört eine Stückliste. Oft genügt eine Ansicht in Gebrauchslage.
- [x] Die Einzelteilzeichnung zeigt ein Teil mit vollständiger Bemaßung, Toleranzen, Oberflächen und Werkstoff.
  > Sie beschreibt, wie das Teil hergestellt wird.
- [ ] Die Zusammenbauzeichnung enthält alle Maße aller Teile.
  > Dann wäre sie unlesbar. Die vollständigen Maße stehen in den Einzelteilzeichnungen.
- [ ] Die Einzelteilzeichnung enthält immer eine Stückliste.
  > Stücklisten gehören zur Zusammenbau- bzw. Sammelzeichnung.
Quelle: 1.4

### Ein Bauteil enthält vier identische Schrauben. Wie viele Positionsnummern bekommen sie?
- [ ] Vier, eine pro Schraube
  > Identische Teile erhalten nur eine Nummer.
- [x] Eine, die Menge 4 steht in der Stückliste
  > Die Nummer erscheint nur einmal in der Zeichnung, die Menge regelt die Stückliste.
- [ ] Keine, Normteile werden nicht nummeriert
  > Auch Normteile stehen in der Stückliste und haben eine Positionsnummer.
- [ ] Zwei, eine für jede Seite
  > Dafür gibt es keine Regel.
Quelle: 1.5

### Wie unterscheiden sich die Volumenmodelle B-Rep und CSG?
- [x] B-Rep speichert die Begrenzungsflächen mit Materialseite, CSG die Entstehungsgeschichte aus Grundkörpern und Booleschen Operationen.
  > Merkhilfe: B-Rep speichert, was da ist; CSG speichert, wie es entstanden ist.
- [ ] B-Rep ist ein Flächenmodell ohne Volumen, CSG ein Volumenmodell.
  > Beide sind Volumenmodelle. B-Rep beschreibt das Volumen über seine Hülle plus Materialvektoren.
- [ ] CSG speichert die Geometrie immer explizit, B-Rep berechnet sie erst beim Evaluieren.
  > Genau umgekehrt.
- [ ] B-Rep und CSG sind zwei Namen für dasselbe Verfahren.
  > Es sind zwei unterschiedliche Darstellungsarten.
Quelle: 2.3

### Ein Bauteil soll an einen 3D-Drucker geschickt werden. Welches Austauschformat ist dafür Standard?
- [ ] DXF
  > DXF ist der Standard für den 2D-Zeichnungsaustausch.
- [ ] STEP
  > STEP überträgt das vollständige Produktmodell, ist aber nicht das typische Druckformat.
- [x] STL
  > STL beschreibt die Oberfläche aus Dreiecken und lässt sich leicht in Schichten schneiden.
- [ ] VDAFS
  > VDAFS ist für Freiformflächen zwischen Autoherstellern und Zulieferern.
Quelle: 2.5

## Kapitel 3 · Werkstücke darstellen

### Eine Welle ist 480 mm lang und wird im Maßstab 1 : 2 gezeichnet. Welche Maßzahl steht an der Maßlinie?
- [ ] 240
  > 240 mm ist die gezeichnete Länge. Maßzahlen geben immer die wahre Größe an.
- [x] 480
  > Der Maßstab ändert nur die Zeichnung, nicht die Maßzahl.
- [ ] 960
  > Hier wurde der Maßstab falsch herum angewandt.
- [ ] 480 : 2
  > Maßstäbe stehen nicht an der Maßzahl, sondern im Schriftfeld bzw. neben Einzelheiten.
Quelle: 3.1

### Welche Linienart verwendet man für Mittel- und Symmetrielinien?
- [ ] Breite Strich-Punktlinie
  > Die breite Strich-Punktlinie kennzeichnet den Schnittverlauf und Behandlungszonen.
- [x] Schmale Strich-Punktlinie
  > Auch Lochkreise und Teilkreise von Zahnrädern werden so gezeichnet.
- [ ] Schmale Strichlinie
  > Die schmale Strichlinie ist für verdeckte Kanten.
- [ ] Schmale Strich-Zweipunktlinie
  > Sie zeigt angrenzende Teile, Extremstellungen oder Rohteilkonturen.
Quelle: 3.2

### Wofür steht die schmale Strich-Zweipunktlinie?
- [x] Angrenzende Teile
  > Merkhilfe: „Zweipunkt = das zweite Teil“.
- [x] Extremstellungen beweglicher Teile
  > Die zweite Stellung eines Hebels wird so gezeichnet.
- [ ] Verdeckte Kanten
  > Dafür nimmt man die schmale Strichlinie.
- [x] Rohteilkontur in einer Fertigteilzeichnung
  > Auch der Zustand vor bzw. nach der Bearbeitung wird so dargestellt.
- [ ] Sichtbare Kanten
  > Sichtbare Kanten sind breite Volllinien.
Quelle: 3.2

### Wo liegt bei Projektionsmethode 1 die Seitenansicht von links?
- [ ] Links neben der Vorderansicht
  > Das ist Projektionsmethode 3 (anglo-amerikanisch). Bei Methode 1 ist es gerade umgekehrt.
- [x] Rechts neben der Vorderansicht
  > Man schaut von links und „klappt“ die Ansicht nach rechts weg. Die Draufsicht liegt unter der Vorderansicht.
- [ ] Unter der Vorderansicht
  > Unter der Vorderansicht liegt die Draufsicht.
- [ ] Über der Vorderansicht
  > Über der Vorderansicht liegt bei Methode 1 die Untersicht.
Tipp: Wer das vertauscht, zeichnet das Teil spiegelverkehrt.
Quelle: 3.3

### In welcher Lage zeichnet man ein Drehteil, wenn man die Fertigungslage wählt?
- [ ] Senkrecht stehend
  > Drehteile werden waagerecht gezeichnet, wie sie auf der Drehmaschine liegen.
- [x] Waagerecht, das dünne Ende nach rechts
  > So liegt es auf der Drehmaschine.
- [ ] Waagerecht, das dicke Ende nach rechts
  > Die Richtung ist vertauscht.
- [ ] Unter 45°, damit alle Absätze sichtbar sind
  > Eine schräge Hauptansicht widerspricht der senkrechten Parallelprojektion.
Quelle: 3.3

### Welche Regeln gelten für die Schraffur einer Schnittfläche?
- [x] Schmale Linien, grundsätzlich unter 45°
  > Zur Mittellinie bzw. zum Hauptumriss.
- [x] Alle Schnittflächen eines Bauteils werden identisch schraffiert, auch in verschiedenen Ansichten.
  > So erkennt man das Teil überall wieder.
- [ ] Im Schnitt werden verdeckte Kanten gestrichelt mitgezeichnet.
  > Im Schnitt werden keine verdeckten Kanten gezeichnet.
- [ ] Aneinanderstoßende Teile bekommen die gleiche Schraffur.
  > Sie bekommen eine andere Richtung oder einen anderen Abstand, damit man sie unterscheidet.
Quelle: 3.5

### Wie trennt man im Halbschnitt die geschnittene von der ungeschnittenen Hälfte?
- [ ] Durch eine breite Volllinie
  > Eine Volllinie wäre eine Körperkante, die es dort nicht gibt.
- [x] Nur durch die Mittellinie
  > Bei senkrechter Achse liegt links die Ansicht, bei waagerechter oben.
- [ ] Durch eine Zickzacklinie
  > Zickzack- oder Freihandlinien begrenzen Teilschnitte (Ausbrüche).
- [ ] Durch eine schmale Strichlinie
  > Die Strichlinie steht für verdeckte Kanten.
Quelle: 3.5

### Welche Teile werden im Längsschnitt nicht geschnitten dargestellt?
- [x] Wellen
  > Massive Teile ohne Hohlräume zeigen im Längsschnitt innen nichts Neues.
- [x] Schrauben
  > Merkhilfe „WeSBo-PaKS-NiKu“: Wellen, Stifte, Bolzen, Passfedern, Keile, Schrauben, Niete, Kugeln.
- [ ] Gehäuse
  > Gehäuse sind hohl und werden gerade deshalb geschnitten.
- [x] Passfedern
  > Auch sie gehören zur Liste der nicht geschnittenen Teile.
- [ ] Wellen im Querschnitt (Profilschnitt)
  > Quer geschnitten wird eine Welle schraffiert.
Quelle: 3.6

## Kapitel 4 · Bemaßung und Dokumentation

### Welche Grundregeln der Maßeintragung stimmen?
- [x] Jedes Maß wird nur einmal eingetragen, in nur einer Ansicht.
  > Doppelte Maße können sich widersprechen.
- [x] Maße ohne Einheit gelten in mm, Winkel immer mit Einheit.
  > „45°“ statt „45“.
- [ ] Maßhilfslinien dürfen über mehrere Ansichten gezogen werden.
  > Das ist nicht erlaubt. Maßhilfslinien bleiben in ihrer Ansicht.
- [ ] Maßzahlen müssen von allen vier Seiten lesbar sein.
  > Nach DIN EN ISO 129-1 sind sie von unten und von rechts lesbar.
Quelle: 4.3

### Was bedeutet ein Maß in runden Klammern, z. B. (120)?
- [ ] Rohmaß
  > Rohmaße stehen in eckigen Klammern.
- [x] Hilfsmaß, das sich aus anderen Maßen ergibt und nur zur Information dient
  > Es ist nicht maßgeblich, Allgemeintoleranzen gelten dafür nicht.
- [ ] Prüfmaß
  > Prüfmaße stehen in einem Rahmen mit runden Ecken.
- [ ] Theoretisch genaues Maß
  > Das steht in einem rechteckigen Rahmen.
Tipp: Runde Klammern, eckige Klammern, runder Rahmen, eckiger Rahmen: vier verschiedene Bedeutungen.
Quelle: 4.5

### Wann darf man eine Fase in der Form „3 × 45°“ bemaßen?
- [ ] Bei jedem Fasenwinkel
  > Bei anderen Winkeln werden Länge und Winkel getrennt angegeben.
- [x] Nur bei 45°
  > Nur dann dürfen Länge und Winkel zusammen stehen.
- [ ] Nur bei Bohrungen
  > Die Regel gilt für Außen- und Innenfasen.
- [ ] Nie, Fasen werden über Kantensymbole angegeben
  > Definierte Fasen werden normal bemaßt. Kantensymbole sind für undefinierte Kantenformen.
Quelle: 4.5

### Ein Drehteil wird nach dem ersten Bearbeitungsschritt umgespannt. Was folgt daraus für die Bemaßung?
- [ ] Alle Maße beziehen sich weiterhin auf eine einzige Bezugsebene.
  > Nach dem Umspannen ist die erste Bezugsebene nicht mehr zugänglich.
- [x] Man braucht zwei Bezugsebenen, je eine pro Aufspannung.
  > Die zweite Stirnseite wird plangedreht und wird zur neuen Bezugsebene.
- [ ] Man bemaßt als Kettenmaße von Absatz zu Absatz.
  > Kettenmaße sind prüfbezogen. Fertigungsgerecht wird von Bezugsebenen aus bemaßt.
- [ ] Die radialen Maße werden als Radien angegeben.
  > Radial bemaßt man Drehteile als Durchmesser.
Quelle: 4.4

### Welche Angaben sind Pflichtfelder im Schriftfeld nach DIN EN ISO 7200?
- [x] Sachnummer und Titel
  > Gehören zu den identifizierenden und beschreibenden Pflichtfeldern.
- [x] Ersteller und genehmigende Person
  > Administrative Pflichtfelder. Merkhilfe „ESAB-T-GED“.
- [ ] Maßstab
  > Der Maßstab ist kein Pflichtfeld, er steht außerhalb oder in einer Erweiterung.
- [ ] Projektionsmethode
  > Auch sie gehört nicht zu den Pflichtfeldern.
- [x] Ausgabedatum und Blattnummer
  > Beide sind identifizierende Pflichtfelder.
Quelle: 4.7

## Kapitel 5 · Oberflächen und Kanten

### Ein Profil springt regelmäßig zwischen +2 µm und −2 µm (Rechteckprofil). Wie groß sind Rz und Ra?
- [ ] Rz = 2 µm, Ra = 2 µm
  > Rz ist die Summe aus Spitze und Tal: $R_z = R_p + R_v = 4$ µm.
- [x] Rz = 4 µm, Ra = 2 µm
  > $R_z = 2 + 2 = 4$ µm. Der Betrag des Abstands ist überall 2 µm, also $R_a = 2$ µm.
- [ ] Rz = 4 µm, Ra = 1 µm
  > Ra = 1 µm gilt für ein Dreiecksprofil mit gleichem Rz. Ra und Rz lassen sich nicht ineinander umrechnen.
- [ ] Rz = 4 µm, Ra = 0 µm
  > Ra mittelt die Beträge, deshalb heben sich positive und negative Werte nicht auf.
Quelle: 5.3

### Welches Oberflächensymbol fordert einen Materialabtrag?
- [ ] Grundsymbol mit Kreis zwischen den Schenkeln
  > Der Kreis bedeutet: Materialabtrag unzulässig.
- [x] Grundsymbol mit zusätzlicher Linie am kurzen Schenkel (geschlossenes Dreieck)
  > Im Text abgekürzt als MRR.
- [ ] Grundsymbol ohne Zusatz
  > Allein bedeutet es nur, dass an die Fläche Anforderungen gestellt werden.
- [ ] Grundsymbol mit Kreis an der Ecke
  > Der Kreis an der Ecke bedeutet „rundum“.
Quelle: 5.4

### Welche Regel gilt ohne Zusatzangabe für die Annahme von Rauheitsmesswerten?
- [x] Nach DIN EN ISO 1302 die 16-%-Regel, nach DIN EN ISO 21920-1 die Tmax-Regel
  > Der Standard hat sich umgedreht: alt tolerant, neu streng.
- [ ] Nach beiden Normen die 16-%-Regel
  > Die neue Norm verlangt ohne Angabe Tmax, keine Überschreitung.
- [ ] Nach beiden Normen die max-Regel
  > In der alten Norm musste „max“ ausdrücklich angegeben werden.
- [ ] Nach DIN EN ISO 1302 die Tmax-Regel, nach 21920-1 die 16-%-Regel
  > Genau vertauscht.
Quelle: 5.5

### Auf Position c am Oberflächensymbol steht das Fertigungsverfahren. In welcher Form?
- [ ] Im Infinitiv, z. B. „drehen“
  > Die Zeichnung zeigt den Endzustand, nicht die Anweisung.
- [x] In der Vergangenheitsform, z. B. „gedreht“ oder „geschliffen“
  > Die Zeichnung beschreibt den fertigen Zustand.
- [ ] Als Kürzel, z. B. „D“ für Drehen
  > Kürzel für Verfahren sind nicht vorgesehen.
- [ ] Gar nicht, Verfahren stehen nur im Arbeitsplan
  > Das Verfahren sollte möglichst angegeben werden, weil jedes ein typisches Profil erzeugt.
Quelle: 5.5

### Ab welchem Kantenmaß gilt eine Kante nach DIN ISO 13715 als scharfkantig?
- [ ] Höchstens 0,5 mm
  > 0,5 mm ist schon eine deutlich gebrochene Kante.
- [x] Höchstens 0,05 mm
  > 0,05 mm = 50 µm. Mit einem sehr kleinen Wert wie ±0,05 wird „scharfkantig“ angegeben.
- [ ] Genau 0 mm
  > Eine Kante ganz ohne Abweichung lässt sich nicht fertigen.
- [ ] Höchstens 0,2 mm
  > Dieser Wert steht nicht in der Norm.
Quelle: 5.9

## Kapitel 6 · Toleranzen und Passungen

### Was ist das Maximum-Material-Maß einer Bohrung?
- [ ] Ihr Höchstmaß
  > Das ist das Maximum-Material-Maß einer Welle. Eine große Bohrung hat wenig Material.
- [x] Ihr Mindestmaß
  > Die kleinste Bohrung lässt am meisten Material stehen. Es ist zugleich das Gutmaß.
- [ ] Ihr Nennmaß
  > Das Nennmaß ist nur die Bezugsgröße für die Abmaße.
- [ ] Der Mittelwert aus Höchst- und Mindestmaß
  > Der Mittelwert hat keine besondere Bedeutung für das Material.
Quelle: 6.1

### Was gibt bei einer ISO-Toleranzklasse wie „H7“ der Buchstabe und was die Zahl an?
- [x] Buchstabe = Lage des Toleranzfelds zur Null-Linie, Zahl = Toleranzgrad (Größe des Felds)
  > Großbuchstaben stehen für Bohrungen, Kleinbuchstaben für Wellen.
- [ ] Buchstabe = Werkstoff, Zahl = Oberflächengüte
  > Werkstoff und Oberfläche haben eigene Angaben.
- [ ] Buchstabe = Größe des Felds, Zahl = Lage
  > Genau vertauscht.
- [ ] Beide zusammen geben nur das obere Abmaß an
  > Eine Toleranzklasse legt beide Abmaße fest.
Quelle: 6.3

### Welche Aussage über das Toleranzfeld „h“ einer Welle stimmt?
- [ ] Das untere Abmaß ist null.
  > Das gilt für eine Bohrung „H“.
- [x] Das obere Abmaß ist null, die Welle ist höchstens so groß wie das Nennmaß.
  > es = 0, das Toleranzfeld liegt unter der Null-Linie.
- [ ] Das Feld liegt symmetrisch um die Null-Linie.
  > Das sind js bzw. JS.
- [ ] Beide Abmaße sind positiv.
  > Positive Abmaße haben Wellen von k aufwärts.
Quelle: 6.3

### Was bedeutet der Eintrag „ISO 2768-mK“ am Schriftfeld?
- [ ] Alle Maße sind mit ±0,1 mm toleriert.
  > Die Abmaße hängen vom Nennmaßbereich ab.
- [x] Allgemeintoleranzen für Längen und Winkel in Klasse m, für Form und Lage in Klasse K
  > Für Hilfsmaße und theoretisch genaue Maße gilt das nicht.
- [ ] Mittlere Oberflächengüte, Kanten gebrochen
  > Oberflächen und Kanten haben eigene Angaben.
- [ ] Toleranzklasse m6 für alle Wellen
  > ISO-Toleranzklassen werden einzeln eingetragen.
Quelle: 6.4

### Ø50 H7/j6: ES = +0,025, EI = 0, es = +0,011, ei = −0,005 (mm). Welche Passungsart liegt vor?
- [ ] Spielpassung
  > Dann müssten Höchst- und Mindestpassung positiv sein. Die Mindestpassung ist aber negativ.
- [x] Übergangspassung
  > $P_O = "0,025" - (-"0,005") = +"0,030"$, $P_U = 0 - "0,011" = -"0,011"$. Vorzeichen +/− heißt Übergang.
- [ ] Übermaßpassung
  > Dafür müsste auch die Höchstpassung negativ sein.
- [ ] Das lässt sich ohne Istmaße nicht sagen.
  > Die Passungsart folgt aus den Grenzmaßen. Erst die Istpassung braucht Istmaße.
Tipp: Höchstpassung = größte Bohrung minus kleinste Welle, Mindestpassung = kleinste Bohrung minus größte Welle.
Quelle: 6.6

### Warum wird das System Einheitsbohrung meist bevorzugt?
- [ ] Weil Wellen leichter zu messen sind als Bohrungen.
  > Messbarkeit ist nicht der Grund.
- [x] Weil eine einheitliche Bohrung (gleiche Reibahle und Lehrdorn) mit verschiedenen Wellen billiger ist als umgekehrt.
  > Werkzeuge und Lehren für Bohrungen sind teurer, deshalb hält man sie einheitlich bei H.
- [ ] Weil Einheitsbohrung immer Übermaßpassungen ergibt.
  > Die Passungsart wird über die Welle gewählt. Spiel, Übergang und Übermaß sind alle möglich.
- [ ] Weil die Einheitswelle nicht genormt ist.
  > Die Einheitswelle ist genauso genormt.
Quelle: 6.7

### Welche Passung wählst Du typischerweise für einen Wälzlagerinnenring bei mittlerer Last?
- [ ] H7/r6
  > Das ist eine Übermaßpassung für Pressverbände.
- [x] H7/k6
  > Übergangspassung, Haftsitz. Merkhilfe: H7/k6 → Wälzlager.
- [ ] H8/f7
  > Das ist eine Spielpassung für drehende Lagerungen (Gleitlager).
- [ ] H7/h6
  > Gleitsitz, von Hand verschiebbar, zu locker für einen Innenring unter Umfangslast.
Quelle: 6.7

## Kapitel 7–12 · Maschinenelemente

### Welche Linie ist beim Außengewinde (Bolzen) breit gezeichnet?
- [x] Der Nenndurchmesser
  > Breit ist immer die Kante, die den Körper begrenzt. Beim Bolzen ist das der Außendurchmesser.
- [ ] Der Kerndurchmesser
  > Der Kern-Ø ist beim Bolzen schmal. Breit ist er bei der Mutter.
- [ ] Beide
  > Dann könnte man Außen- und Innengewinde nicht unterscheiden.
- [ ] Keine, Gewinde werden nur schmal gezeichnet
  > Die Körperkante wird immer breit gezeichnet.
Quelle: 7.1

### Was bedeutet die Bezeichnung „Tr16 × 4 P2“?
- [ ] Feingewinde mit 16 mm Durchmesser und 4 mm Steigung
  > Tr steht für Trapezgewinde, nicht für ein metrisches Feingewinde.
- [x] Zweigängiges Trapezgewinde, d = 16 mm, Steigung 4 mm, Teilung 2 mm
  > $n = P_h \/ P = 4 \/ 2 = 2$ Gänge.
- [ ] Trapezgewinde mit 4 Gängen und 2 mm Steigung
  > Die 4 ist die Steigung $P_h$, die Gangzahl folgt erst aus $P_h \/ P$.
- [ ] Trapezgewinde mit Linksgang
  > Linksgewinde wird mit LH gekennzeichnet.
Quelle: 7.3

### Was bedeutet die Festigkeitsklasse 8.8 einer Schraube?
- [ ] Zugfestigkeit 88 N/mm²
  > Die beiden Zahlen werden nicht zusammengelesen.
- [x] Zugfestigkeit 800 N/mm², Streckgrenze 640 N/mm²
  > Erste Zahl × 100 = $R_m$, zweite Zahl / 10 = Streckgrenzenverhältnis: $"0,8" dot 800 = 640$.
- [ ] Streckgrenze 800 N/mm², Zugfestigkeit 880 N/mm²
  > Die erste Zahl gibt die Zugfestigkeit an, nicht die Streckgrenze.
- [ ] Gewindesteigung 8,8 mm
  > Die Steigung steht in der Gewindebezeichnung, nicht in der Festigkeitsklasse.
Quelle: 7.6

### Ist eine Unterlegscheibe eine Sicherung gegen Losdrehen?
- [ ] Ja, sie erhöht die Reibung und hält die Mutter fest.
  > Sie senkt bei rauer Fläche eher die Reibung beim Anziehen und verteilt die Kraft.
- [x] Nein, sie verteilt die Kraft und schützt weiche Flächen, sichert aber nicht.
  > Auch der Federring gilt in Versuchen als unwirksame Sicherung.
- [ ] Ja, aber nur zusammen mit einem Federring.
  > Auch der Federring sichert in Versuchen nicht wirksam.
- [ ] Nur bei Feingewinde
  > Die Gewindeart ändert nichts an der Funktion der Scheibe.
Quelle: 7.5

### Was bedeutet „Passfeder DIN 6885 – A 12 × 8 × 40“?
- [x] Form A (rundstirnig), Breite 12 mm, Höhe 8 mm, Gesamtlänge 40 mm
  > Bei Form A zählt die Länge inklusive der Rundungen.
- [ ] Form A, Wellendurchmesser 12 mm, Nuttiefe 8 mm, Länge 40 mm
  > Die Zahlen sind die Maße der Passfeder selbst.
- [ ] Form A, Länge 12 mm, Breite 8 mm, Höhe 40 mm
  > Die Reihenfolge ist b × h × l.
- [ ] Gleitfeder mit Halteschrauben
  > Das wäre Form E.
Quelle: 8.4

### Mit welchen Flächen überträgt eine Passfeder das Drehmoment?
- [ ] Mit der Oberseite
  > Oben hat sie Rückenspiel und berührt die Nabe nicht.
- [x] Mit den Seitenflächen
  > Formschlüssig über die Flanken in Wellen- und Nabennut.
- [ ] Mit allen vier Flächen gleichzeitig
  > Die Oberseite hat Rückenspiel.
- [ ] Durch Reibung an der Wellenoberfläche
  > Die Passfeder ist eine formschlüssige Verbindung, keine reibschlüssige.
Quelle: 8.4

### Welche Bohrungskennzahl gehört zum Rillenkugellager 6208, und welcher Bohrungsdurchmesser folgt daraus?
- [ ] 2, also d = 10 mm
  > Die 2 ist die Durchmesserreihe.
- [x] 08, also d = 40 mm
  > $08 dot 5 = 40$ mm. Die 6 steht für das einreihige Rillenkugellager.
- [ ] 208, also d = 208 mm
  > Die Zeichen werden einzeln gelesen: Lagerart, Reihe, Bohrungskennzahl.
- [ ] 08, also d = 8 mm
  > Die Kennzahl wird ab 04 mit 5 multipliziert.
Quelle: 10.4

### Eine Getriebewelle dreht, die Zahnkraft steht im Raum still. Welcher Lagerring hat Umfangslast und braucht einen festen Sitz?
- [x] Der Innenring
  > Er läuft unter der stehenden Kraft um. Typisch Welle k6.
- [ ] Der Außenring
  > Der Außenring steht still unter stehender Kraft, das ist Punktlast. Dort ist ein loser Sitz erlaubt (H7).
- [ ] Beide Ringe gleichermaßen
  > Die Lastart hängt von der Relativbewegung ab, und die ist für die beiden Ringe verschieden.
- [ ] Keiner, Wälzlager brauchen keinen festen Sitz
  > Ein Ring mit Umfangslast würde ohne festen Sitz wandern.
Quelle: 10.5

### Warum lagert man eine Welle normalerweise mit einem Festlager und einem Loslager?
Antwort: Die Welle erwärmt sich im Betrieb meist stärker als das Gehäuse und dehnt sich aus. Bei zwei Festlagern könnte sie sich nicht längen, die Lager würden verspannt und beschädigt. Das Festlager nimmt alle Axialkräfte in beiden Richtungen auf, das Loslager lässt einen Ring axial wandern und gleicht so die Wärmedehnung aus.
Tipp: Was passiert mit der Wellenlänge, wenn die Maschine warm läuft?
Quelle: 10.6

### Wie wird ein eingebauter O-Ring im Schnitt gezeichnet?
- [ ] Kreisrund, wie im Katalog
  > Kreisrund wäre der uneingebaute Zustand.
- [x] Verformt, weil erst die Verformung die Anpresskraft erzeugt
  > Statische Dichtungen werden immer im Schnitt gezeichnet, Elastomere meist mit Kreuzschraffur.
- [ ] Gar nicht, Dichtungen werden nur in der Stückliste geführt
  > Dichtungen werden gezeichnet, damit man Querschnitt und Funktion sieht.
- [ ] Als verdeckte Kante
  > Dichtungen werden im Schnitt dargestellt, nicht verdeckt.
Quelle: 11.3

### Ein Stirnrad hat den Modul $m = 3$ mm und $z = 45$ Zähne. Wie groß sind Teilkreis- und Kopfkreisdurchmesser?
- [ ] $d = 15$ mm, $d_a = 21$ mm
  > Hier wurde $z\/m$ statt $m dot z$ gerechnet.
- [x] $d = 135$ mm, $d_a = 141$ mm
  > $d = m z = 135$ mm, $d_a = m (z + 2) = 141$ mm.
- [ ] $d = 135$ mm, $d_a = 138$ mm
  > Die Kopfhöhe $h_a = m$ kommt auf beiden Seiten dazu, also $2 h_a$.
- [ ] $d = 141$ mm, $d_a = 135$ mm
  > Vertauscht: Der Kopfkreis ist größer als der Teilkreis.
Tipp: $m = d \/ z$, $h_a = m$
Quelle: 12.2

### Wie wird der Teilkreis eines Zahnrads gezeichnet?
- [ ] Als breite Volllinie
  > Breite Volllinien sind sichtbare Kanten, und der Teilkreis ist keine Kante.
- [x] Als schmale Strich-Punktlinie
  > In der Ansicht ist sie das einzige Merkmal, das ein Zahnrad von einer Scheibe unterscheidet.
- [ ] Als schmale Volllinie
  > So wird bei Bedarf der Fußkreis gezeichnet.
- [ ] Gar nicht, nur der Kopfkreis wird gezeichnet
  > Der Teilkreis wird immer gezeichnet.
Quelle: 12.3
