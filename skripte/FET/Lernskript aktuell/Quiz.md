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

### In einem starren geschlossenen Gefäß schmilzt Eis, während Eis, Wasser und Dampf im Gleichgewicht vorhanden sind. Was bleibt zunächst konstant?
- [x] Druck und Temperatur bleiben auf ihren Tripelwerten.
  > Die Wärmezufuhr ändert zunächst die Phasenanteile; die drei Phasen koexistieren weiter.
- [ ] Alle drei Teilmassen bleiben unverändert.
  > Gerade die Teilmassen ändern sich beim Schmelzen und der begleitenden Umverteilung.
- [ ] Die innere Energie bleibt wegen des konstanten Volumens gleich.
  > Ein starres Volumen streicht die Volumenarbeit, nicht die Wirkung zugeführter Wärme.
Quelle: 2.14.1

### Bei der starren geschlossenen Erwärmung eines Tripelgemisches ohne weitere Arbeit gilt $Q$ = ___. Nenne die geänderte Gesamtgröße in Worten.
Antwort: Änderung der inneren Energie/innere Energieänderung
Erklärung: Aus dem ersten Hauptsatz bleibt bei unveränderten äußeren Energien die Änderung von U. Die Teilmassen des Endzustands müssen davor neu bestimmt werden.
Quelle: 2.14.2

### Eine Dampftrommel enthält gleich viel Flüssigkeits- und Dampfvolumen. Welche Aussage folgt daraus?
- [x] Die Massenanteile sind wegen unterschiedlicher spezifischer Volumina verschieden.
  > Teilmassen werden aus Teilvolumen geteilt durch den passenden Stoffwert berechnet.
- [ ] Der Dampfgehalt ist genau 50 Prozent.
  > Der Dampfgehalt ist ein Massenanteil, kein Volumenanteil.
- [ ] Die beiden spezifischen Enthalpien werden ohne Gewichtung addiert.
  > Erst Masse mal spezifische Enthalpie ergibt die addierbare Gesamtenergie.
Quelle: 2.15.2

### Für eine abgesperrte starre Überhitzerfüllung ändert sich der Druck. Welche Formel beschreibt die benötigte Wärme bei unveränderten äußeren Energien?
- [x] $Q=m[(h_2-h_1)-v(p_2-p_1)]$
  > Wärme ändert hier U. Der Druck-Volumen-Anteil verbindet u mit h und bleibt bei veränderlichem Druck erhalten.
- [ ] $Q=m(h_2-h_1)$ unabhängig vom Druckverlauf
  > Die Änderung von pv wurde weggelassen. Konstantes v bedeutet nicht konstantes pv.
- [ ] $Q=0$, weil keine Volumenarbeit übertragen wird.
  > Die starre Wand verhindert Volumenarbeit, aber nicht Wärmeübertragung.
Quelle: 2.15.3

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

### Eine adiabate Wasserturbine gibt weniger Wellenleistung ab als die verfügbare Gefälleleistung. Im betrachteten Modell bleibt der Rest im Wasser. Was folgt?
- [x] Die Temperatur des Wassers kann steigen.
  > Adiabat streicht den Wärmestrom über die Grenze. Nicht genutzte Gefälleenergie kann als innere Energie mit dem Wasser austreten.
- [ ] Die Temperatur muss gleich bleiben, weil die Turbine adiabat ist.
  > Keine Wärmeübertragung bedeutet nicht unveränderte innere Energie oder unveränderte Temperatur.
- [ ] Der Rest ist zwangsläufig ein Wärmestrom an die Umgebung.
  > Ein solcher Wärmestrom widerspräche der hier angenommenen adiabaten Grenze.
Tipp: Trenne innere Energie im austretenden Stoff von Wärmeübertragung.
Quelle: 3.3.1

### Im stationären Dampfkessel gibt es keine technische Arbeit; äußere Energieänderungen sind vernachlässigt. Welche Aussage gilt?
- [x] Die spezifische Wärmezufuhr ist $q_12=h_2-h_1$.
  > Ohne technische Arbeit erhöht die Wärmezufuhr die Enthalpie des Stroms.
- [ ] Die spezifische Wärmezufuhr ist grundsätzlich $h_2$.
  > Benötigt wird der Unterschied zwischen Ein- und Austritt, nicht der Endwert allein.
- [ ] Die spezifische Wärmezufuhr ist $h_1-h_2$.
  > Beim Heizen nimmt die Enthalpie zu; die Wärmezufuhr zählt positiv.
Quelle: 3.3.2

### Welche Aussagen zum Wirkungsgrad der offenen Dampfanlage treffen zu?
- [x] Die abgegebene Wellenleistung wird als positiver Nutzen eingesetzt.
  > Das Bilanzvorzeichen der Abgabe ist negativ, der Nutzen im Wirkungsgrad wird als positiver Betrag verwendet.
- [x] Nicht angegebene Pumpen- und Generatorverluste sind in dieser Rechnung nicht erfasst.
  > Der Wert gehört zum ausdrücklich beschriebenen offenen Anlagenmodell.
- [ ] Derselbe Zahlenwert beweist die Effizienz eines vollständigen geschlossenen Dampfkreislaufs.
  > Ein solcher Kreislauf mit seinen weiteren Komponenten wurde hier nicht bilanziert.
Quelle: 3.3.2

### Bei einem stationären Stoffstrom wird aus der spezifischen technischen Arbeit durch Multiplikation mit dem ___ eine Leistung.
Antwort: Massenstrom
Tipp: kJ/kg muss zu kJ/s werden.
Erklärung: Der Massenstrom in kg/s liefert den erforderlichen Zeitbezug: $P=dot(m)w_t$.
Quelle: 3.4.1

### Zwei reibfreie Verdichtungswege eines idealen Gases haben gleiche Anfangs- und Endtemperatur. Was muss gelten?
- [x] Auf beiden Wegen ist $Delta U=0$.
  > Beim idealen Gas hängt die innere Energie nur von der Temperatur ab.
- [ ] Auf beiden Wegen muss die Volumenarbeit gleich sein.
  > Arbeit ist eine Prozessgröße und hängt von der Fläche unter dem jeweiligen Druck-Volumen-Weg ab.
- [ ] Auf beiden Wegen muss $Q=0$ sein.
  > Bei $Delta U=0$ folgt $Q=-W_v$. Gleiche Endtemperatur bedeutet nicht fehlenden Wärmeaustausch.
Quelle: 3.4.2

### Wie wird die Nutzarbeit einer Expansion bei konstantem Umgebungsdruck in der Zufuhrkonvention bestimmt?
- [x] $W_(v,n)=W_v+p_"∞"(V_2-V_1)$
  > Der positive Verdrängungsaufwand reduziert den Betrag der negativen Arbeitsabgabe.
- [ ] $W_(v,n)=W_v-p_"∞"(V_2-V_1)$
  > Das würde den Betrag der Abgabe vergrößern, obwohl ein Anteil zum Verdrängen der Umgebung benötigt wird.
- [ ] $W_(v,n)=W_v$ unabhängig vom Umgebungsdruck.
  > Der Umgebungsanteil wird damit übersehen; gleich sind die Größen nur in passenden Grenzfällen.
Quelle: 3.4.3

### Welche Voraussetzungen erlauben $w_t=integral v dif p$?
- [x] Keine Dissipation
  > Sonst bleibt der zusätzliche Dissipationsbeitrag in der technischen Arbeit erhalten.
- [x] Änderungen von Bewegungs- und Lageenergie sind vernachlässigbar.
  > Andernfalls enthält die technische Arbeit auch diese Beiträge.
- [ ] Das Maschinengehäuse hat ein unverändertes Volumen; weitere Annahmen sind unnötig.
  > Die Gehäusegröße allein streicht weder Dissipation noch äußere Energieänderungen des Stoffstroms.
Quelle: 3.5

### Eine ideale Flüssigkeitspumpe erhöht bei annähernd konstantem spezifischem Volumen den Druck. Welche Aussage stimmt?
- [x] $w_p approx v(p_2-p_1)>0$
  > Das Druckintegral bleibt trotz fast unverändertem spezifischem Volumen positiv.
- [ ] $w_p approx 0$, weil $dif v approx 0$ ist.
  > Verwechselt werden Druckarbeit mit Integral über dp und Volumenarbeit mit Integral über dv.
- [ ] Druckarbeit und Volumenarbeit müssen auf jedem Weg denselben Wert haben.
  > Der Unterschied ist $Delta(p v)$; er verschwindet nicht allgemein.
Quelle: 3.5.2

### Erkläre, warum Druckarbeit und Volumenarbeit bei einem isothermen Weg eines idealen Gases gleich sein können.
Antwort: Für dieselbe Gasportion und denselben Weg gilt $w_p=w_v+Delta(p v)$. Beim idealen Gas ist $p v=R T$; isotherm bleibt dieses Produkt konstant. Deshalb verschwindet der Zusatzterm. Ohne diese Voraussetzung sind beide Arbeiten nicht grundsätzlich gleich.
Tipp: Nutze die Produktänderung von Druck und spezifischem Volumen.
Quelle: 3.5.1

### Welche Aussage über Wärme und Enthalpie ist richtig?
- [x] Wärme ist eine Prozessgröße; Enthalpie ist eine Zustandsgröße.
  > Wärme beschreibt einen Grenzübertritt wegen eines Temperaturunterschieds, Enthalpie beschreibt den Zustand.
- [ ] Ein warmer Stoff besitzt einen Bestand an Wärme, der gleich seiner Enthalpie ist.
  > Gespeichert wird Zustandsenergie. Wärme ist kein eigener Bestand, und die Enthalpie ist nicht allgemein eine übertragene Wärmemenge.
- [ ] Jede Wärmezufuhr ist gleich dem Endwert der Enthalpie.
  > Selbst wenn eine passende Bilanz Wärme und Enthalpie verknüpft, betrifft sie eine Änderung und benötigt Voraussetzungen.
Quelle: 3.6

### Für welches Modell darf man die spezifischen Energieänderungen mit konstanten Wärmekapazitäten allein aus der Temperaturänderung berechnen?
- [x] Ideales Gas mit im betrachteten Bereich konstant angesetzten Wärmekapazitäten
  > Dann gelten $Delta u=c_v Delta T$ und $Delta h=c_p Delta T$.
- [ ] Jedes reale Fluid unabhängig von Druck und Phase
  > Reale Fluide benötigen im Allgemeinen weitere Zustandsangaben und passende Tabellen.
- [ ] Jeden Stoff allein deshalb, weil die Systemwand starr ist
  > Die Wandbedingung ersetzt kein kalorisches Stoffmodell.
Quelle: 3.6.1

### Aus $h=u+p v$ folgt für Zustandsänderungen $Delta u=Delta h$, wenn ___ konstant bleibt.
Antwort: das Produkt aus Druck und spezifischem Volumen/das Druck-Volumen-Produkt
Erklärung: Allgemein ist $Delta u=Delta h-Delta(p v)$. Für Gesamtgrößen bei veränderlicher Masse muss stattdessen das gesamte Produkt $p V$ geprüft werden.
Quelle: 3.6.2

### Warum kann die isotherme Expansion im idealen Druckluftmotor mehr Arbeit abgeben als die reversible Adiabate?
- [x] Sie erhält Wärme, die den Temperaturabfall verhindert und die zusätzliche Arbeitsabgabe ermöglicht.
  > Bei idealem Gas bleibt isotherm die innere Energie gleich; abgegebene Arbeit muss durch Wärmezufuhr ausgeglichen werden.
- [ ] Das Wort isotherm bedeutet, dass keinerlei Energie übertragen wird.
  > Isotherm beschreibt die Temperatur, nicht die Abwesenheit von Energieübertragung.
- [ ] Die zusätzliche Arbeit entsteht ohne weiteren Energieaufwand.
  > Die notwendige Wärmezufuhr würde damit in der Energiebilanz fehlen.
Quelle: 3.7.1

### Welche Aussagen zum Druckluftmotor mit idealisiertem Gaswechsel sind richtig?
- [x] Füllung und Ausschiebung ergänzen die Expansionsarbeit um $-p_1 V_1+p_2 V_2$.
  > Die Rechteckanteile im Druck-Volumen-Diagramm gehören zur gesamten Zyklusarbeit.
- [x] Eine Leistungsrechnung benötigt die Zahl der Arbeitsspiele je Zeit.
  > Umdrehungen pro Minute allein bestimmen diese Frequenz noch nicht.
- [ ] Die Enthalpiebilanz erfordert zusätzlich eine zweite Addition derselben Verschiebearbeit.
  > Die Enthalpie enthält den pv-Anteil bereits. Eine erneute Addition würde ihn doppelt zählen.
Quelle: 3.7.2

### Warum müssen beim Druckluftmotor Überdruck und Celsius vor dem Einsetzen in die Gasgleichung umgerechnet werden?
Antwort: Die Gasgleichung und die verwendeten Zustandsverhältnisse benötigen absolute Drücke und Kelvin. Zum Überdruck wird der Umgebungsdruck addiert; zur Celsius-Temperatur werden 273,15 addiert. Im Vorlesungsbeispiel sind das 23,21 bar absolut und 297,95 Kelvin.
Tipp: Ein Druckverhältnis aus Überdrücken ist nicht das Verhältnis der absoluten Zustandsdrücke.
Quelle: 3.7.2

### Warum ist beim idealen Gas $c_p>c_v$?
- [x] Isobare Erwärmung muss im passenden Modell zusätzlich die Ausdehnungsarbeit bedienen.
  > Bei gleicher Temperaturerhöhung kommt zur Änderung der inneren Energie eine Arbeitsabgabe hinzu.
- [ ] Weil isochore Erwärmung die Temperatur nicht ändern kann.
  > Bei festem Volumen kann die Temperatur steigen; stattdessen steigt der Druck.
- [ ] Weil die gleiche Gasportion isobar automatisch schwerer wird.
  > Verglichen wird dieselbe geschlossene Masse. Der Unterschied stammt nicht aus zusätzlicher Masse.
Quelle: 3.8.1

### Eine Tabelle nennt Mittelwerte seit 0 °C. Du brauchst den Mittelwert von 400 bis 1200 °C. Was ist richtig?
- [x] Die beiden seit 0 °C berechneten Energiezunahmen subtrahieren und durch 800 K teilen.
  > So bleibt genau die Energiezunahme im gesuchten Intervall übrig.
- [ ] Den Tabellenwert seit 0 bis 800 °C ablesen.
  > Die gleiche Breite macht zwei verschiedene Temperaturbereiche nicht gleich.
- [ ] Die beiden Tabellenwerte einfach arithmetisch mitteln.
  > Tabelliert sind bereits unterschiedliche integrale Mittel. Ihre bloße Mittelung bildet das Zielintervall nicht ab.
Quelle: 3.8.2

### Welche Einheit gehört zur molaren isobaren Wärmekapazität bei Stoffmenge in kmol?
- [x] kJ/(kmol K)
  > Der molare Bezug ist pro Stoffmenge. Mit der Molmasse wird daraus der spezifische Bezug.
- [ ] kJ/(kg K)
  > Das ist die spezifische Wärmekapazität je Masse.
- [ ] kJ/K
  > Das ist die gesamte Wärmekapazität einer konkreten Portion.
Quelle: 3.8.1

### Welche Aussagen treffen auf einen vollständigen Kreisprozess zu?
- [x] Das Arbeitsmittel erreicht wieder seinen Anfangszustand.
  > Deshalb verschwinden die Änderungen seiner Zustandsgrößen nach dem gesamten Umlauf.
- [x] Netto-Wärme und Netto-Arbeit können trotzdem ungleich null sein.
  > Wärme und Arbeit sind Prozessgrößen. Ihre vorzeichenbehaftete Summe muss ausgeglichen sein.
- [ ] Die Pumpenaufnahme darf bei der Nettoleistung grundsätzlich ignoriert werden.
  > Die Nutzabgabe ist Turbinenabgabe abzüglich der zugehörigen Pumpenaufnahme.
Quelle: 3.9.1

### Eine Maschine soll dauernd Arbeit abgeben, ohne andere Energie aufzunehmen oder einen Speicher abzubauen. Das wäre ein Perpetuum mobile ___ Art.
Antwort: erster/1./1
Erklärung: Die Behauptung verletzt den ersten Hauptsatz. Ein geschlossener Kreis des Arbeitsmittels ist keine Energiequelle.
Quelle: 3.9.2

### Bei einer adiabaten Düse ohne technische Arbeit und mit gleicher Höhe nimmt die Geschwindigkeit zu. Was kann dabei geschehen?
- [x] Die spezifische Enthalpie sinkt und liefert den Zuwachs an Bewegungsenergie.
  > Erhalten bleibt unter diesen Annahmen h plus spezifische Bewegungsenergie.
- [ ] Die Enthalpie muss gleich bleiben, weil keine Wärme übertragen wird.
  > Adiabat streicht nur den Wärmestrom; die Bewegungsenergie bleibt Teil der Bilanz.
- [ ] Die Düse erzeugt zusätzliche Energie durch den kleineren Querschnitt.
  > Der Querschnitt beeinflusst die Strömung, erzeugt aber keine Energie.
Quelle: 3.10

### Welche Aussage zur adiabaten Drossel mit vernachlässigten äußeren Energieänderungen ist richtig?
- [x] Die Enthalpie bleibt etwa gleich; der Prozess kann trotzdem irreversibel sein.
  > Die gleichbleibende Enthalpie ist eine Energieaussage. Druckabbau kann mit positiver Entropieerzeugung verbunden sein.
- [ ] Enthalpiekonstanz beweist Reversibilität.
  > Reversibilität wird dadurch nicht bewiesen; die Drossel ist ein typisches Gegenbeispiel.
- [ ] Bei jedem realen Fluid bleibt automatisch auch die Temperatur gleich.
  > Die Enthalpie eines realen Fluids hängt im Allgemeinen nicht allein von der Temperatur ab.
Quelle: 3.10

### Warum fällt der Registerwärmestrom in der Gesamtbilanz um Wasser, Luft und Lüfter weg?
Antwort: Er liegt innerhalb der Gesamtgrenze. Die Wasserabgabe und die Luftaufnahme erscheinen mit entgegengesetzten Vorzeichen und heben sich auf. Die verschiedenen Enthalpieströme und die von außen zugeführte Lüfterleistung bleiben in der Bilanz.
Erklärung: Lege zuerst die Grenze fest und verfolge dann denselben inneren Pfeil auf beiden Seiten.
Quelle: 3.11

### Ein Lufterhitzer ist nach außen adiabat. Welche Aussagen sind trotzdem möglich?
- [x] Im Inneren überträgt Wasser Wärme an Luft.
  > Die Adiabatie betrifft die äußere Gesamtgrenze und verhindert keinen inneren Austausch.
- [x] Über die äußere Grenze wird Lüfterarbeit zugeführt.
  > Adiabat bedeutet keine Wärmeübertragung; Arbeit ist eine andere Übertragungsform.
- [ ] Alle spezifischen Enthalpieänderungen werden ohne ihre Massenströme addiert.
  > Verschiedene spezifische Bezüge müssen zuerst in vergleichbare extensive Leistungen umgerechnet werden.
Quelle: 3.11


## Kapitel 4 · Zweiter Hauptsatz und Zustandsdiagramme

### Ein Rührer erwärmt mit Arbeit ein Fluid. Warum beweist die Energieerhaltung nicht, dass Abkühlen allein das antreibende Gewicht wieder anhebt?
- [x] Der erste Hauptsatz bilanziert Energie; der zweite begrenzt zusätzlich die mögliche Prozessrichtung.
  > Ein energetisch gedachter Rückvorgang muss nicht ohne weitere Veränderung der Umgebung möglich sein.
- [ ] Weil beim Rühren Energie vernichtet wird.
  > Die Arbeit erhöht die innere Energie. Energie wird nicht vernichtet.
- [ ] Weil ein Fluid überhaupt keine Arbeit abgeben kann.
  > Fluide können in passenden Prozessen Arbeit abgeben. Hier ist die behauptete selbsttätige Umkehr das Problem.
Quelle: 4.1

### Ein System wird in seinen Anfangszustand zurückgebracht, dabei wird die Umgebung bleibend verändert. Ist damit Reversibilität bewiesen?
- [x] Nein; auch die Umgebung müsste ohne bleibende Änderung zurückkehren.
  > Die gemeinsame Rückkehr ist Teil der Reversibilitätsbedingung.
- [ ] Ja; allein der Systemzustand entscheidet.
  > Damit würde gerade die für die Rückführung veränderte Umgebung ausgeblendet.
- [ ] Ja; sobald der Prozess nur langsam genug ablief.
  > Langsamkeit beseitigt vorhandene Reibung oder andere Irreversibilitäten nicht automatisch.
Quelle: 4.1

### Welche Aussage über Entropie ist ohne weitere Einschränkung richtig?
- [x] Die innere Entropieerzeugung ist nichtnegativ.
  > Transport kann die Systementropie senken; die Erzeugung im Inneren wird dadurch nicht negativ.
- [ ] Die Entropie jedes einzelnen Systems steigt bei jedem Vorgang.
  > Ein System kann durch Wärme- oder Stoffabgabe Entropie verlieren.
- [ ] Wärmeabgabe erzeugt grundsätzlich negative Entropie.
  > Wärmeabgabe ist ein negativer Transportbeitrag, keine negative innere Erzeugung.
Quelle: 4.2.1

### Wann folgt aus der Entropiebilanz unmittelbar $Delta S>=0$ für die Gesamtentropie des betrachteten Systems?
- [x] Bei einem adiabaten geschlossenen System.
  > Es gibt weder Wärme- noch Stofftransport von Entropie über die Grenze; die Änderung entspricht der nichtnegativen Erzeugung.
- [ ] Bei jedem starren System, unabhängig von Wärme- und Stoffaustausch.
  > Starrheit allein verhindert diese Entropietransporte nicht.
- [ ] Bei jedem offenen System allein wegen der Durchströmung.
  > Offene Systeme müssen den mit Masse transportierten Entropiestrom mitbilanzieren.
Quelle: 4.2.1

### Eine stationäre adiabate Turbine erzeugt im Inneren Entropie. Was muss bei einem Ein- und Austritt im betrachteten Modell gelten?
- [x] Der Austritts-Entropiestrom ist größer als der Eintritts-Entropiestrom.
  > Die Erzeugung wird mit dem Stoff abgeführt, obwohl der Speicher im Gerät stationär bleibt.
- [ ] Die Entropie im Gerät muss immer weiter anwachsen.
  > Stationär bleibt der Speicher gleich; Erzeugung und Abtransport können sich ausgleichen.
- [ ] Die Entropieerzeugung muss null sein, weil die Turbine adiabat ist.
  > Adiabat streicht den Wärme-Entropietransport und verbietet keine innere Erzeugung.
Quelle: 4.2.2

### Ein Stahlblock kühlt ab und seine Entropie sinkt. Welche zusätzliche Betrachtung entscheidet über die Irreversibilität des ganzen Vorgangs?
- [x] Die Entropieaufnahme der Umgebung und die gemeinsame Gesamtbilanz.
  > Die Umgebung nimmt die abgegebene Wärme und Entropie auf; ihre Zunahme muss mitbetrachtet werden.
- [ ] Nur das Vorzeichen der Blockentropie.
  > Die negative Änderung eines nichtadiabaten Teilsystems ist für sich kein Verstoß.
- [ ] Nur der Energieausgleich; Entropie ist dafür überflüssig.
  > Gleiche Energiebeträge bei Abgabe und Aufnahme sagen noch nicht, ob ein Prozess reversibel ist.
Quelle: 4.3.1

### Welche Größen gehören in die Verhältnisse der idealen Gas-Entropieformel?
- [x] Kelvin-Temperaturen und absolute Drücke in jeweils einheitlichen Einheiten.
  > Nur diese Verhältnisse vergleichen die entsprechenden absoluten Zustandsgrößen.
- [ ] Celsius-Temperaturen und Überdrücke reichen grundsätzlich aus.
  > Ihre Quotienten sind im Allgemeinen andere Zahlenverhältnisse und liefern falsche Logarithmen.
- [ ] Beliebige gemischte Druckeinheiten, solange die Zahlen positiv sind.
  > Die Einheiten müssen sich innerhalb jedes Verhältnisses kürzen.
Quelle: 4.3.1

### Bei gleichem Einlass und gleichem Enddruck hat eine reale adiabate Turbine gegenüber dem isentropen Vergleich typischerweise welche Eigenschaften?
- [x] Geringere Wellenabgabe und höhere Austrittsenthalpie.
  > Die kleinere abgegebene Arbeit lässt eine entsprechend größere Enthalpie im austretenden Stoff.
- [x] Eine höhere spezifische Entropie am Austritt.
  > Innere Irreversibilität erzeugt unter den adiabaten Annahmen Entropie.
- [ ] Eine vernichtete Energiemenge in Höhe der Vergleichsverlustleistung.
  > Die entgangene Arbeit ist kein Energieverlust aus der Gesamtbilanz; der Austrittszustand enthält die Energie.
Quelle: 4.3.3

### Im lg(p)-h-Diagramm ist die waagerechte Achse h. Welche Linie ist unmittelbar senkrecht?
- [x] Eine Isenthalpe.
  > Bei konstantem h ändert sich die waagerechte Koordinate nicht.
- [ ] Jede Isentrope unabhängig von Stoff und Gebiet.
  > Senkrechte Isentropen ergeben sich unmittelbar bei s als waagerechter Achse, nicht allgemein in diesem Diagramm.
- [ ] Eine Isobare.
  > Ein konstanter Druck hält hier die senkrechte Koordinate fest und ergibt eine waagerechte Linie.
Quelle: 4.4

### Darf eine T-s-Fläche unter einem beliebigen tatsächlichen Prozessweg ohne Weiteres als übertragene Wärme gelesen werden?
- [x] Nur für einen reversiblen Weg gilt unmittelbar $q_"rev"=integral T dif s$.
  > Bei Irreversibilität enthält die Entropieänderung zusätzlich Erzeugung.
- [ ] Ja; jede Entropieänderung entsteht ausschließlich durch Wärme.
  > Entropie kann auch im Inneren erzeugt und bei offenen Systemen mit Stoff transportiert werden.
- [ ] Ja; sobald nur die Endtemperaturen bekannt sind.
  > Die tatsächliche Wärme hängt auch vom Prozessweg und seinen Bedingungen ab.
Quelle: 4.4

