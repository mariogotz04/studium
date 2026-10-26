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

## Kapitel 1 · Grundbegriffe

### Ein Boiler wird elektrisch beheizt. Du legst die Systemgrenze um Wasser *und* Heizstab. Wie kommt die Energie ins System?
- [ ] Als Wärme vom Heizstab
  > So wäre es, wenn nur das Wasser das System wäre. Dann überquert die Energie die Grenze zwischen Heizstab und Wasser als Wärme.
- [x] Als elektrische Arbeit über das Kabel
  > Der Heizstab liegt innerhalb der Grenze. Über die Grenze läuft nur das Kabel, und das überträgt Arbeit.
- [ ] Gar nicht, weil die Energie im System bleibt
  > Die Energie kommt von außen aus dem Netz, also überquert sie die Grenze.
Tipp: Frag dich, was genau die Grenze überquert.
Quelle: 1.1

### Ein geschlossenes System bekommt 100 J Wärme und gibt 40 J Arbeit ab. Wie groß ist $Delta U$?
- [x] 60 J
  > $Delta U = Q + W = 100 + (-40)$. Abgegebene Arbeit zählt in der Zufuhrkonvention negativ.
- [ ] 140 J
  > Hier wurde die abgegebene Arbeit als Zufuhr gezählt.
- [ ] −60 J
  > Die Vorzeichen sind vertauscht. Es kommt mehr Energie hinein als hinaus.
- [ ] 100 J, weil Arbeit die innere Energie nicht ändert
  > Arbeit überträgt Energie genauso wie Wärme. Beide gehen in $Delta U$ ein.
Quelle: 1.1.1

### Welche Aussagen über ein geschlossenes, starres, adiabates Gefäß mit eingebautem Heizstab stimmen?
- [x] Über die Grenze fließt keine Masse.
  > Das bedeutet „geschlossen“.
- [x] Es wird keine Volumenarbeit übertragen.
  > Starr heißt $dif V = 0$, also $-integral p dif V = 0$.
- [ ] Seine innere Energie kann sich nicht ändern.
  > Der elektrische Anschluss kann Arbeit zuführen. Adiabat verbietet nur Wärme, starr nur Volumenarbeit.
- [ ] Es ist ein abgeschlossenes System.
  > Abgeschlossen hieße: weder Wärme noch Arbeit noch Masse. Die elektrische Arbeit ist hier aber möglich.
Quelle: 1.1.3

### Ein Durchlauferhitzer läuft seit Stunden mit konstantem Wasserstrom und konstanter Heizleistung. Kalt hinein, warm hinaus. Welcher Begriff passt?
- [ ] Gleichgewicht, weil sich nichts mehr ändert
  > Im Gleichgewicht gäbe es keinen antreibenden Temperaturunterschied. Hier besteht ein großer Unterschied zwischen Ein- und Austritt.
- [x] Stationär, weil die Werte an jedem festen Ort zeitlich gleich bleiben
  > Der Zustand wird durch ständigen Austausch aufrechterhalten. Das ist stationär, aber kein Gleichgewicht.
- [ ] Homogen, weil überall dieselbe Temperatur herrscht
  > Die Temperatur ist am Eintritt und Austritt verschieden, also nicht homogen.
Quelle: 1.2

### Bei konstanter Dichte strömt Wasser durch ein Rohr. Der Durchmesser halbiert sich. Wie ändert sich die Geschwindigkeit?
- [ ] Sie verdoppelt sich.
  > Das gälte, wenn die Fläche linear mit dem Durchmesser ginge. Sie geht aber mit $d^2$.
- [x] Sie vervierfacht sich.
  > Halber Durchmesser gibt ein Viertel der Fläche. Aus $A_1 c_1 = A_2 c_2$ folgt die vierfache Geschwindigkeit.
- [ ] Sie halbiert sich.
  > Im engeren Querschnitt muss dieselbe Masse pro Sekunde durch, also schneller, nicht langsamer.
- [ ] Sie bleibt gleich, nur der Druck ändert sich.
  > Die Kontinuität verlangt eine höhere Geschwindigkeit. Dass sich auch der Druck ändert, beschreibt Bernoulli zusätzlich.
Quelle: 1.5

### Ein Manometer zeigt 2,2 bar Überdruck, die Umgebung hat 0,96 bar. Welcher Druck gehört in die Gasgleichung?
- [ ] 2,2 bar
  > Das ist der Überdruck gegenüber der Umgebung. Die Gasgleichung braucht den Druck ab Vakuum.
- [x] 3,16 bar
  > $p_"abs" = p_e + p_"amb" = "2,2" + "0,96"$.
- [ ] 1,24 bar
  > Hier wurde die Umgebung abgezogen statt addiert.
Quelle: 1.7

### Ein Gas wird bei konstantem Volumen von 20 °C auf 60 °C erwärmt. Verdreifacht sich sein Druck?
- [ ] Ja, weil sich die Temperatur verdreifacht.
  > 60 °C ist nicht das Dreifache von 20 °C, wenn man in Kelvin rechnet. Verhältnisse brauchen absolute Temperaturen.
- [x] Nein, er steigt nur um rund 14 %.
  > $p_2\/p_1 = T_2\/T_1 = "333,15"\/"293,15" approx "1,14"$.
- [ ] Nein, bei konstantem Volumen bleibt auch der Druck konstant.
  > Isochor heißt, das Volumen bleibt gleich. Der Druck steigt mit der Temperatur.
Tipp: Rechne die Temperaturen in Kelvin um.
Quelle: 1.8

### Zustandsgrößen hängen nur von ___ ab, Prozessgrößen wie Wärme und Arbeit vom ___.
Antwort: den Endzuständen/Endzustand/Anfangs- und Endzustand/Zustand | Weg/Prozessweg/Prozess
Erklärung: Eine Zustandsgröße wie $U$ ändert sich um Endwert minus Anfangswert, egal auf welchem Weg. Wie viel davon als Wärme und wie viel als Arbeit übertragen wurde, hängt vom Weg ab.
Quelle: 1.6

### Ein Gas expandiert. Welches Vorzeichen hat die Volumenarbeit $W_v = -integral p dif V$, und was bedeutet das?
- [x] Negativ: Das Gas gibt Arbeit ab.
  > Bei Expansion ist $dif V > 0$, das Minus macht $W_v$ negativ. In der Zufuhrkonvention heißt negativ abgegeben.
- [ ] Positiv: Das Gas gibt Arbeit ab.
  > Abgegebene Arbeit ist in der Zufuhrkonvention negativ.
- [ ] Positiv: Dem Gas wird Arbeit zugeführt.
  > Das gilt bei Kompression, wenn $dif V < 0$ ist.
Quelle: 1.9

### Ein Kolben bewegt sich sehr langsam, aber mit Reibung. Ist der Vorgang reversibel?
Antwort: Nein. Er kann quasistatisch sein, also eine Folge von Gleichgewichtszuständen durchlaufen, weil er langsam ist. Reibung wandelt aber geordnete Bewegung in innere Energie um, und das lässt sich nicht ohne bleibende Änderung in der Umgebung rückgängig machen. Reversibel heißt, System und Umgebung ließen sich vollständig zurücksetzen; das verhindert die Reibung.
Quelle: 1.10

## Kapitel 2 · Stoffeigenschaften

### Wasser wird bei konstantem Druck erhitzt und beginnt zu sieden. Was passiert mit der Temperatur, solange noch Flüssigkeit da ist?
- [x] Sie bleibt konstant; die Energie geht in den Phasenwechsel.
  > Bei einem reinen Stoff sind im Zweiphasengebiet Druck und Temperatur gekoppelt. Die zugeführte Energie ist latent.
- [ ] Sie steigt weiter, aber langsamer.
  > Isobar und im Gleichgewicht bleibt sie bei einem reinen Stoff konstant, bis alles verdampft ist.
- [ ] Sie sinkt, weil das Verdampfen Energie verbraucht.
  > Verdampfen braucht Energie, aber die wird zugeführt. Die Temperatur bleibt auf der Siedetemperatur.
Quelle: 2.1

### Eine Tabelle nennt mittlere Wärmekapazitäten bezogen auf 0 °C. Du brauchst $Delta h$ für 6 °C → 80 °C. Was ist richtig?
- [ ] $Delta h = C_80 dot 74 thin "K"$
  > $C_80$ gilt für den Bereich 0 bis 80 °C, nicht für 6 bis 80 °C.
- [x] $Delta h = (C_80 dot 80 - C_6 dot 6) dot 1 thin "K"$
  > Man nimmt den Anteil 0→80 °C und zieht den schon vorhandenen Anteil 0→6 °C ab.
- [ ] $Delta h = (C_80 + C_6)\/2 dot 74 thin "K"$
  > Der Mittelwert zweier Tabellenwerte ist kein Mittelwert über das richtige Intervall.
Quelle: 2.1

### Welche Aussagen über den Realgasfaktor $Z = p v\/(R T)$ stimmen?
- [x] Für ein ideales Gas ist $Z = 1$.
  > Dann ist $p v = R T$ erfüllt.
- [x] $Z$ hängt vom Zustand ab und muss für jeden Zustand neu bestimmt werden.
  > Eine einzige Zahl ist kein Stoffgesetz für alle Drücke und Temperaturen.
- [ ] $Z < 1$ bedeutet, dass das Gas weniger Energie enthält.
  > $Z$ korrigiert nur die thermische Zustandsgleichung. Für Energien braucht man kalorische Stoffwerte.
- [ ] Nahe der Kondensation ist $Z$ immer genau 1.
  > Gerade dort weicht das Verhalten oft stark vom idealen Gas ab.
Quelle: 2.2

### Im Nassdampfgebiet eines reinen Stoffes legt der Druck ___ fest. Um den Zustand vollständig zu kennen, braucht man zusätzlich zum Beispiel den ___.
Antwort: die Temperatur/Temperatur/Siedetemperatur/Sättigungstemperatur | Dampfgehalt/x
Erklärung: Druck und Temperatur sind im Zweiphasengebiet gekoppelt, $T = T_s(p)$. Wie viel Flüssigkeit und wie viel Dampf vorliegen, sagt erst eine weitere Angabe wie $x$, $v$ oder $h$.
Quelle: 2.3

### Was gilt am kritischen Punkt?
- [x] Der Unterschied zwischen $v'$ und $v''$ verschwindet, ebenso die Verdampfungsenthalpie.
  > Flüssigkeit und Dampf lassen sich dort nicht mehr unterscheiden.
- [ ] Dort bestehen Eis, Wasser und Dampf nebeneinander.
  > Das ist der Tripelpunkt, nicht der kritische Punkt.
- [ ] Die Verdampfungsenthalpie ist dort am größten.
  > Sie wird zum kritischen Punkt hin kleiner und verschwindet dort.
Quelle: 2.4

### Wasser wird in einem geschlossenen starren Behälter erhitzt, das spezifische Volumen ist kleiner als $v_"kr"$. Wie verlässt der Zustand das Nassdampfgebiet?
- [ ] Zur Dampfseite, weil Erhitzen immer mehr Dampf erzeugt.
  > Das gilt nur für $v > v_"kr"$. Mehr Wärme heißt nicht bei jeder Randbedingung mehr Dampf.
- [x] Zur Flüssigkeitsseite; danach kann der Druck stark steigen.
  > Bei kleinem $v$ füllt die sich ausdehnende Flüssigkeit den Behälter. Flüssigkeit ist kaum kompressibel.
- [ ] Genau durch den kritischen Punkt.
  > Das ist der idealisierte Grenzfall $v = v_"kr"$.
Quelle: 2.7

### Der Dampfgehalt $x$ ist ein ___anteil. Ein kleines $x$ kann trotzdem den größten Teil des ___ ausfüllen.
Antwort: Massen/Masse/Massenanteil | Volumens/Volumen/Gefäßes/Behälters
Tipp: Dampf braucht pro Kilogramm viel mehr Raum als Flüssigkeit.
Erklärung: $x = m''\/(m' + m'')$ bezieht sich auf Masse. Weil $v'' >> v'$, kann wenig Dampfmasse den meisten Raum einnehmen. Der Volumenanteil ist eine andere Größe, $mu = x v''\/v$.
Quelle: 2.9

### Bei 200 bar und $x = "0,8"$ ist $h' = 1827$ und $h'' = 2418 thin "kJ/kg"$. Wie groß ist $h$?
- [x] 2299,8 kJ/kg
  > $h = h' + x (h'' - h') = 1827 + "0,8" dot 591$.
- [ ] 1945,2 kJ/kg
  > Hier wurde mit $1 - x$ statt mit $x$ gewichtet.
- [ ] 1934,4 kJ/kg
  > Das ist $"0,8" dot 2418$, also nur der Dampfanteil ohne die Flüssigkeit.
- [ ] 2122,5 kJ/kg
  > Das ist der einfache Mittelwert. Er gälte nur bei $x = "0,5"$.
Quelle: 2.10

### Warum darfst du die Mischungsregel nicht für überhitzten Dampf mit $x > 1$ verwenden?
Antwort: Die Mischungsregel gewichtet die Sättigungswerte beider Phasen mit ihren Massenanteilen $1 - x$ und $x$. Sie gilt nur im Nassdampfgebiet, also für $0 <= x <= 1$. Überhitzter Dampf ist einphasig und liegt nicht auf der Sättigung; seine Werte stammen aus der Tabelle für überhitzten Dampf bei $p$ und $T$. Ein $x > 1$ ist dort keine sinnvolle Größe.
Quelle: 2.9

### Warum fällt die Schmelzkurve von gewöhnlichem Eis im p-T-Diagramm, die Dampfdruckkurve aber steigt?
- [x] Beim Schmelzen von Eis wird das Volumen kleiner ($Delta v < 0$), beim Verdampfen größer.
  > Nach Clapeyron ist $dif p_s\/dif T = Delta h\/(T Delta v)$. Mit $Delta h > 0$ bestimmt das Vorzeichen von $Delta v$ die Steigung.
- [ ] Beim Schmelzen wird Energie frei, beim Verdampfen verbraucht.
  > Beide Umwandlungen brauchen Energie, $Delta h > 0$.
- [ ] Weil Eis bei 0 °C schmilzt und Wasser bei 100 °C siedet.
  > Die Lage der Kurven sagt nichts über ihre Steigung.
Quelle: 2.11

### Luft enthält rund 21 % Sauerstoff. Welche Aussage ist richtig?
- [ ] Das sind 21 Massen-%.
  > Nach Masse sind es rund 23 %, weil Sauerstoff schwerer ist als Stickstoff.
- [x] Das sind 21 Mol-%; nach Masse sind es rund 23 %.
  > Eine Prozentangabe braucht ihre Bezugsgröße.
- [ ] Massen- und Molanteil sind bei Luft gleich.
  > Sie wären nur gleich, wenn alle Komponenten dieselbe Molmasse hätten.
Quelle: 2.12.2

### Aus einem starren Stickstoffgefäß wird bei konstantem Druck 1 kg Flüssigkeit entnommen. Welche Aussagen stimmen?
- [x] Ein kleiner Teil der Flüssigkeit verdampft, um den frei werdenden Raum zu füllen.
  > Das Volumen bleibt gleich, die Masse sinkt. Die neue Dampfmasse bleibt im Gefäß.
- [ ] Das spezifische Volumen bleibt konstant, weil der Behälter starr ist.
  > Starr heißt $V$ konstant. Weil $m$ sinkt, wächst $v = V\/m$.
- [x] Im Gefäß verschwindet mehr Flüssigkeit, als entnommen wird.
  > Zur entnommenen Masse kommt der verdampfte Anteil hinzu.
- [ ] Die entnommene Masse ist die verdampfte Masse.
  > Entnommen wird Flüssigkeit; verdampft ist ein anderer, viel kleinerer Teil.
Quelle: 2.13.2

## Kapitel 3 · Energiebilanzen: Erster Hauptsatz

### Warum steht in der Energiebilanz eines durchströmten Systems die Enthalpie $h$ statt der inneren Energie $u$?
- [x] Weil $h = u + p v$ die Verschiebearbeit enthält, mit der der Stoff hinein- und hinausgeschoben wird.
  > Diese Ein- und Ausströmarbeit gehört zu jedem Stoffstrom und steckt schon in $h$.
- [ ] Weil durchströmte Systeme keine innere Energie haben.
  > Der Stoff hat innere Energie. $h$ enthält sie und zusätzlich $p v$.
- [ ] Weil die Enthalpie bei Strömungen immer konstant ist.
  > Sie ändert sich, wenn Wärme oder technische Arbeit übertragen wird.
Quelle: 3.1.1

### Im offenen System gehört zur technischen Arbeit die Druckarbeit $w_p = integral v dif p$, im geschlossenen System zur Gesamtarbeit die ___arbeit.
Antwort: Volumen/Volumenänderungs
Tipp: Im geschlossenen System ändert sich das Volumen, im offenen fließt Stoff durch eine Maschine mit festem Volumen.
Erklärung: Offen: Druckarbeit $w_p = integral v dif p$ in der technischen Arbeit. Geschlossen: Volumenarbeit $w_v = -integral p dif v$ in der Gesamtarbeit. Die rote Randnotiz auf Folie 4 hatte die Begriffe vertauscht.
Quelle: 3.1.2

### Eine Bleikugel fällt aus 30 m Höhe mit 30 m/s Anfangsgeschwindigkeit auf den Boden. Alle Energie bleibt in der Kugel, $c_"Pb" = 130 thin "J/(kg K)"$. Um wie viel erwärmt sie sich?
- [x] Um etwa 5,7 K
  > $Delta T = (c_1^2\/2 + g z_1)\/c_"Pb" = (450 + "294,3")\/130$.
- [ ] Um etwa 0,0057 K
  > So käme es heraus, wenn man $c_"Pb"$ als 130 kJ/(kg K) einsetzt. Blei hat aber rund 0,13 kJ/(kg K).
- [ ] Um etwa 2,3 K
  > Das ist nur die Lageenergie. Die kinetische Anfangsenergie fehlt.
- [ ] Das hängt von der Masse der Kugel ab.
  > Die Masse kürzt sich heraus, weil alle Energien pro Kilogramm gerechnet werden.
Tipp: Erst System und Zustände ① und ② festlegen, dann alle Terme des 1. HS aufschreiben und streichen.
Quelle: 3.1.4

### Welche Aussage über den ersten Hauptsatz ist richtig?
- [x] Er sagt, wie groß die Summe der Zustandsänderungen ist, aber nicht, welche Prozessgröße in welche Zustandsänderung übergeht.
  > Er ist eine Bilanz. Wohin die Energie im Einzelnen geht, bestimmen das Modell und die Stoffwerte.
- [ ] Er sagt, dass Wärme immer vollständig in Arbeit umgewandelt werden kann.
  > Das folgt aus der Bilanz nicht; dafür braucht man den zweiten Hauptsatz.
- [ ] Er gilt nur für reversible Prozesse.
  > Energieerhaltung gilt auch bei irreversiblen Prozessen.
Quelle: 3.1.4

### Beim Entnehmen aus dem Stickstoffbehälter: Warum reicht $Q_"zu,23" = Delta U$ nicht aus?
Antwort: Während der Entnahme fließt Masse über die Grenze, das System ist offen und instationär. Der austretende flüssige Stickstoff nimmt seine Enthalpie $h'$ mit, einschließlich der Verschiebearbeit. Die Bilanz lautet daher $U_3 - U_2 = Q_"zu,23" - m_"entn" h'$. Ohne den Term $m_"entn" h'$ fehlt der Energietransport mit der entnommenen Masse.
Quelle: 3.2.1

### Nach der Entnahme ist die spezifische Entropie $s$ des Restes größer geworden. Ist damit auch die gesamte Entropie $S$ gestiegen?
- [ ] Ja, $S$ und $s$ ändern sich immer in dieselbe Richtung.
  > $S = m s$. Wenn die Masse sinkt, kann $S$ trotz größerem $s$ kleiner werden.
- [x] Nicht unbedingt, denn die Masse im Gefäß ist gesunken.
  > Eine Aussage über die Entropie braucht ihre Bezugsgröße: pro Kilogramm oder gesamt.
- [ ] Nein, die Entropie sinkt bei einer Entnahme immer.
  > Ob $S$ sinkt, hängt davon ab, wie stark $m$ sinkt und $s$ steigt.
Quelle: 3.2.2
