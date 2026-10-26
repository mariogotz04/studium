# Karteikarten · Konstruktion

<!--
So ist diese Datei aufgebaut (die Webseite liest sie beim Hochladen automatisch ein):
- "## Kapitel …" beginnt ein Kapitel (Filter auf der Webseite).
- "### Frage" ist die Vorderseite einer Karte. Alles darunter bis zur nächsten ### ist die Rückseite.
- Auf der Rückseite gehen Absätze (Leerzeile), Listen (- …), **fett** und *kursiv*.
- Eine Zeile "Bild: …" erscheint als Merkbild (Analogie im Feynman-Stil) unten auf der Karte.
- Nur Verständnisfragen, keine Rechenaufgaben. Antworten kurz, einfach, in eigenen Worten.
- Den Fragetext nur ändern, wenn nötig: Der Lernfortschritt hängt am Wortlaut der Frage.
-->

## Kapitel 1 · Grundlagen und Zeichnungserstellung

### Wozu dient eine Technische Zeichnung?
Sie ist der eindeutige Informationsträger zwischen allen, die an einem Produkt arbeiten: Konstruktion, Fertigung, Qualitätssicherung, Einkauf, Montage und externe Zulieferer. Sie legt Form, Maße, Toleranzen, Oberflächen und Werkstoff so fest, dass jemand anders das Teil ohne Rückfrage herstellen kann.

Bild: Eine Sprache: Der Konstrukteur schreibt, alle anderen lesen. Damit alle dasselbe verstehen, ist die Grammatik genormt.

### Warum nimmt man für Technische Zeichnungen die senkrechte Parallelprojektion und keine Perspektive?
Nur bei ihr erscheinen Flächen parallel zur Bildebene in wahrer Größe. In der Perspektive werden ferne Kanten kleiner, und man könnte nichts vergleichen. Geneigte Flächen sind auch in der orthogonalen Ansicht verkürzt, deshalb braucht man oft mehrere Ansichten.

### Was bedeuten DIN, DIN EN, DIN ISO und DIN EN ISO, und sind Normen Gesetze?
- DIN: rein deutsche Norm
- DIN EN: europäische Norm, als DIN übernommen
- DIN ISO: internationale Norm, als DIN übernommen
- DIN EN ISO: international, europäisch und deutsch zugleich

Normen sind Empfehlungen und aus sich heraus nicht rechtsverbindlich. Wer sie anwendet, verhält sich aber ordnungsgemäß. Gleiche Nummer heißt nicht gleicher Inhalt, deshalb nennt man immer das vollständige Präfix.

### Warum haben die A-Formate das Seitenverhältnis 1 : √2?
Nur bei diesem Verhältnis hat die Hälfte eines Blatts wieder dieselbe Form. So kann man Zeichnungen ohne Verzerrung vergrößern und verkleinern. A0 hat 1 m², und jede Stufe halbiert die Fläche.

### Wo steht das Schriftfeld, und wozu dient die Feldeinteilung am Blattrand?
Das Schriftfeld steht immer unten rechts, damit es im gefalteten Zustand sichtbar ist. A4 ist hoch, alle anderen Formate sind quer. Die Feldeinteilung (Spalten mit Buchstaben, Zeilen mit Zahlen) erlaubt es, eine Stelle anzusprechen, zum Beispiel »die Bohrung in Feld B6«.

### Was ist der Unterschied zwischen Teil und Einzelteil?
Ein Teil muss der Anwender nicht weiter aufgliedern, zum Beispiel ein gekauftes Kugellager. Ein Einzelteil kann man nicht zerstörungsfrei zerlegen, zum Beispiel den Innenring dieses Lagers.

### Was gehört in eine Einzelteilzeichnung und was in eine Gesamtzeichnung?
Die Einzelteilzeichnung zeigt, wie ein Teil hergestellt wird: vollständige Bemaßung, Toleranzen, Oberflächen und Werkstoff. Die Gesamtzeichnung zeigt, wie die Teile zusammengehören: Positionsnummern, nur Haupt- und Anschlussmaße und die Stückliste.

### Warum bemaßt man eine Gesamtzeichnung nur mit Haupt- und Anschlussmaßen?
Sie dient dem Einbau und der Montage, nicht der Fertigung. Hauptmaße sagen, wie viel Platz das Erzeugnis braucht. Anschlussmaße sagen, wie es an die Umgebung angeschlossen wird. Alle anderen Maße stehen in den Einzelteilzeichnungen.

### Welche Regeln gelten für Positionsnummern?
- In Montagereihenfolge oder im Uhrzeigersinn, sauber in Reihen oder Spalten.
- Dünne Bezugslinie mit Punkt im Teil oder Pfeil an der Kontur, nicht parallel zu anderen Linien.
- Doppelte Maßzahlhöhe, mindestens 5 mm.
- Identische Teile bekommen nur eine Nummer, die nur einmal erscheint. Die Menge steht in der Stückliste.

### Warum gilt die Stückliste als eines der wichtigsten Konstruktionsergebnisse?
Sie ist die Grundlage für Fertigungsvorbereitung, Kalkulation, Bestellwesen und Lager. Ohne sie weiß niemand, welche Teile in welcher Menge gefertigt oder bestellt werden müssen.

### Warum beginnt man eine Skizze mit den Mittellinien?
Sie legen Symmetrie und Lage fest, und alle Ansichten richten sich daran aus. Danach kommen dünne Hilfslinien, erst zum Schluss werden die sichtbaren Kanten breit nachgezogen.

## Kapitel 2 · CAD und digitale Produktmodelle

### Was ist der Hauptvorteil von CAD?
Die Durchgängigkeit der Daten: Dasselbe Modell wird von der Entwicklung über die Konstruktion bis zur Fertigung genutzt, ohne es neu zu zeichnen.

### Was ist der Unterschied zwischen B-Rep und CSG?
B-Rep beschreibt den Körper über seine Begrenzungsflächen, die Geometrie liegt also explizit vor. CSG speichert die Entstehungsgeschichte als Baum aus Grundkörpern und Booleschen Operationen (vereinigen, abziehen, schneiden). Die Flächen werden erst beim Auswerten berechnet.

Bild: B-Rep ist das Foto der fertigen Torte, CSG ist das Rezept.

### Welche Bedingung muss eine Skizze im Skizzenmodul erfüllen?
Die Kontur muss ein geschlossener Linienzug sein. Nur dann kann man sie zu einem Volumen extrudieren oder rotieren.

### Warum erstellt man trotz CAD noch eine Technische Zeichnung?
Die Zeichnung dokumentiert den freigegebenen, abgestimmten Stand mit Zeichnungs- und Revisionsnummer. Änderungen bleiben nachvollziehbar, Beteiligte können per Unterschrift zustimmen, und Folgedokumente verweisen auf genau diesen Stand.

### Für welche Konstruktionsart lohnt sich CAD am meisten und für welche am wenigsten?
Am meisten bei der Variantenkonstruktion, weil parametrische Modelle schnell neue Größen liefern. Dann bei der Anpassungskonstruktion. Am wenigsten bei der Neukonstruktion, denn CAD hilft nicht beim Finden neuer Lösungen.

### Wofür verwendet man STL und wofür STEP?
STL beschreibt die Oberfläche nur als Dreiecke und genügt für den 3D-Druck. STEP überträgt ein umfassendes Produktmodell und dient dem Datenaustausch zwischen CAD-Systemen.

### Welche Nachteile haben flächenbasierte CAD-Systeme gegenüber volumenbasierten?
Sie kennen kein Volumen, also gibt es keine Volumenberechnung und keine Kollisionsprüfung. Oft fehlen Zeichnungsableitung und Datenbaum, nachträgliche Änderungen sind schwer, und die Lückenlosigkeit der Flächen ist nicht garantiert.

### Was prüft man mit Clash & Clearance im Digital Mock-Up?
Ob sich Bauteile durchdringen (Clash) und ob genug Abstand für Bewegung bleibt (Clearance). So findet man Kollisionen, bevor ein Prototyp gebaut wird.

### Warum muss man KI-Erklärungen zu Technischen Zeichnungen immer prüfen?
Die KI antwortet nach Wahrscheinlichkeiten, nicht nach Normwissen. Im Test des Buchs waren Aussagen teils falsch, pauschal oder irreführend.

## Kapitel 3 · Werkstücke darstellen

### Was bedeuten die Maßstäbe 1 : 5 und 5 : 1?
1 : 5 ist fünffach verkleinert (1 mm auf dem Papier sind 5 mm in Wirklichkeit). 5 : 1 ist fünffach vergrößert. An der Maßlinie steht trotzdem immer das wirkliche Maß.

### Warum darf man keine Maße aus einer Zeichnung abgreifen?
Maßgebend sind nur die eingetragenen Maße. Kopien sind oft nicht maßstäblich, und eine Zeichnung ist nur so genau, wie sie gezeichnet wurde.

### Welche Linienart wird wofür verwendet?
- Breite Volllinie: sichtbare Kanten
- Schmale Strichlinie: verdeckte Kanten
- Schmale Strich-Punktlinie: Mittel- und Symmetrielinien, Lochkreise, Teilkreise
- Schmale Volllinie: Maß- und Hilfslinien, Schraffur, Lichtkanten
- Strich-Zweipunktlinie: angrenzende Teile, Extremstellungen, Rohteilkontur
- Breite Strich-Punktlinie: Schnittverlauf, wärmebehandelte Zone

### In welcher Lage stellt man ein Werkstück dar?
Vorzugsweise in Gebrauchslage, sonst in Fertigungslage. Drehteile liegen waagrecht mit dem dünnen Ende nach rechts, so wie sie in der Drehmaschine eingespannt werden.

### Wie viele Ansichten braucht eine Zeichnung?
So viele wie nötig, damit das Teil eindeutig ist, und nicht mehr. Oft reichen eine oder zwei, typisch sind drei.

### Wie unterscheiden sich Projektionsmethode 1 und 3?
Bei Methode 1 liegt die Draufsicht unter der Vorderansicht und die Seitenansicht von links rechts daneben. Bei Methode 3 ist es umgekehrt. Welche Methode gilt, zeigt das Symbol nahe dem Schriftfeld.

Bild: Methode 1: Man schaut von oben, und das Bild fällt durch das Teil nach unten aufs Papier.

### Welche Grundregeln gelten für die Schraffur?
- Schmale Linien unter 45° zur Mittellinie oder zum Hauptumriss.
- Alle Schnittflächen eines Teils bekommen dasselbe Muster.
- Aneinanderstoßende Teile werden in verschiedene Richtungen oder mit anderem Abstand schraffiert.
- In geschnittenen Bereichen werden keine verdeckten Kanten gezeichnet.

### Wann wählt man einen Vollschnitt und wann einen Halbschnitt?
Den Vollschnitt bei hohlen Teilen ohne wichtige Außenmerkmale. Den Halbschnitt bei symmetrischen Teilen, die innen und außen etwas Wichtiges zeigen. Bei senkrechter Achse ist die linke Hälfte Ansicht, bei waagrechter Achse die obere.

### Welche Teile werden im Längsschnitt nicht geschnitten, und warum?
Massive Teile wie Wellen, Stifte, Bolzen, Passfedern, Schrauben, Niete und Wälzkörper. Ein Längsschnitt würde nichts Neues zeigen und die Baugruppe nur unübersichtlich machen.

### Wie kennzeichnet man einen abgeknickten Schnittverlauf?
Mit einer breiten Strich-Punktlinie an Anfang, Ende und jedem Knick, Pfeilen für die Blickrichtung an Anfang und Ende und Großbuchstaben (A–A) an den Enden und über der Schnittdarstellung.

## Kapitel 4 · Bemaßung und Dokumentation

### Was ist die Geometrische Produktspezifikation (GPS)?
Das Gesamtkonzept aller Normen, die Idealgeometrie und zulässige Abweichungen festlegen: Maße, Form, Lage, Oberfläche und Kanten. Sie verbindet Spezifikation, Fertigung und Prüfung, damit alle drei dasselbe meinen.

### Welche Grundregeln gelten für die Maßeintragung?
Alle Maße, die zur Herstellung nötig sind, vollständig. In mm ohne Einheit, bezogen auf den dargestellten Endzustand. Jedes Maß nur einmal. Maßzahlen werden von unten und von rechts gelesen und von keiner Linie gekreuzt.

### Warum soll jedes Maß nur einmal in der Zeichnung stehen?
Steht ein Maß doppelt, kann es bei einer Änderung nur an einer Stelle angepasst werden, und die Zeichnung widerspricht sich. Außerdem bleibt dann unklar, welcher Wert gilt.

### Wie bemaßt man ein Drehteil fertigungsgerecht?
Axiale Maße von einer plangedrehten Bezugsebene aus, radiale Maße als Durchmesser. Nach dem Umspannen wird die zweite Stirnseite die neue Bezugsebene. So kann der Dreher jedes Maß direkt von der Fläche aus messen, an der er gerade arbeitet.

### Was wird bei einer Gewindebohrung bemaßt und was nicht?
Bemaßt werden Gewinde-Nennmaß (zum Beispiel M8), nutzbare Gewindelänge, Tiefe der Kernlochbohrung und Position. Nicht bemaßt werden der Kernlochdurchmesser, weil er aus der Norm folgt, und die 120°-Bohrerspitze.

### Was bedeuten runde Klammern, eckige Klammern und die beiden Rahmen an einem Maß?
- ( ) Hilfsmaß: ergibt sich aus anderen Maßen, nur zur Information.
- [ ] Roh- oder Vorbearbeitungsmaß.
- Rahmen mit runden Ecken: Prüfmaß.
- Rechteckiger Rahmen: theoretisch genaues Maß ohne Toleranz.

### Wann darf man eine Fase als »2 × 45°« angeben?
Nur bei 45°-Fasen, weil dort beide Schenkel gleich lang sind. Bei anderen Winkeln stehen Länge und Winkel getrennt.

### Wofür ist die Koordinatenbemaßung besonders praktisch?
Für die NC-Programmierung: Alle Punkte stehen als Koordinaten von einem Ursprung aus, oft in einer Tabelle. Die Maschine braucht genau diese Werte.

### Wie geht man bei kleinen und großen Zeichnungsänderungen vor?
Klein: Die Stelle mit einem Buchstaben im Kreis kennzeichnen und Änderungsindex und Datum anpassen. Groß: neue Zeichnung erstellen, die alte als »zurückgezogen« kennzeichnen und die lose Stückliste anpassen.

## Kapitel 5 · Oberflächen und Kanten

### Welche Gestaltabweichungen gibt es, und welche zählen zur Rauheit?
1. Formabweichung, 2. Welligkeit, 3. Rillen, 4. Riefen, Schuppen, Kuppen, 5. Gefügestruktur. Zur Rauheit zählen die 3. bis 5. Ordnung.

### Wie entstehen P-, W- und R-Profil?
Das gemessene Primärprofil (P) wird gefiltert. Die langwelligen Anteile ergeben das Welligkeitsprofil (W), die kurzwelligen das Rauheitsprofil (R).

### Was ist der Unterschied zwischen Rz und Rt?
Beide sind höchste Spitze plus tiefstes Tal. Rz gilt für eine Einzelmessstrecke, Rt für die ganze Messstrecke. Rt ist größer, wenn das Extrem außerhalb der betrachteten Einzelmessstrecke liegt.

### Warum reagiert Rz stärker auf einen einzelnen Kratzer als Ra?
Ra mittelt über alle Punkte, ein einzelner Kratzer fällt kaum ins Gewicht. Rz nimmt direkt das tiefste Tal und die höchste Spitze, ein Kratzer geht also voll ein.

Bild: Ra ist der Notendurchschnitt der Klasse, Rz die Differenz zwischen bester und schlechtester Note.

### Was bedeuten die drei Grundformen des Oberflächensymbols?
- Nur Linie am langen Schenkel: alle Fertigungsverfahren zulässig.
- Zusätzlicher Querstrich: Materialabtrag gefordert.
- Kreis im Symbol: Materialabtrag unzulässig, die Fläche bleibt zum Beispiel im Gusszustand.

### Warum steht zwischen »Rz1« und dem Grenzwert ein doppeltes Leerzeichen?
Damit die Anzahl der Einzelmessstrecken nicht mit dem Grenzwert verwechselt wird: »Rz1  3,2« statt »Rz 13,2«.

### Was ist der Unterschied zwischen der 16-%-Regel und Tmax?
Nach der älteren DIN EN ISO 1302 ist eine Fläche annehmbar, wenn höchstens 16 % der Messwerte den Grenzwert überschreiten. Nach DIN EN ISO 21920-1 gilt ohne Angabe Tmax, also darf kein Messwert überschreiten. Deshalb muss man wissen, nach welcher Normfassung die Zeichnung erstellt ist.

### Warum steht das Fertigungsverfahren am Oberflächensymbol in der Vergangenheitsform?
Die Zeichnung beschreibt den Endzustand des Bauteils. Deshalb heißt es »gedreht« oder »geschliffen«.

### Warum braucht die Welle unter einem Radial-Wellendichtring auch eine untere Rauheitsgrenze?
Eine zu glatte Welle hält keinen Schmierfilm, und die Dichtlippe läuft heiß. Deshalb gibt man zwei Werte an, zum Beispiel Ra 0,8 oben und Ra 0,2 unten.

### Warum schreibt man nicht einfach auf alle Flächen eine feine Rauheit?
Jede feinere Oberfläche kostet Bearbeitungszeit. Flächen ohne Funktion können roh bleiben. Fein sein müssen nur Funktionsflächen wie Lagersitze, Dichtflächen oder Zentrierungen. Das Motto ist: so grob wie möglich, so fein wie nötig.

### Was bedeuten »+« und »−« beim Kantenzustand?
An einer Außenkante heißt + Grat zulässig und − gratfrei bzw. Abtragung. An einer Innenkante heißt + Übergang zulässig und − Abtragung. ± lässt beides zu. So sind Verletzungsgefahr, Montage, Funktion und Kosten eindeutig geregelt.

## Kapitel 6 · Toleranzen und Passungen

### Was besagt das Unabhängigkeitsprinzip?
Alle Maß-, Form- und Lagetoleranzen werden unabhängig voneinander eingehalten. Heute gilt es nach ISO 8015 auch ohne Hinweis. Der Vermerk »Tolerierung ISO 8015« ist nur noch zur Klarheit sinnvoll.

### Was ist die Hüllbedingung, und warum ist sie teurer?
Das Formelement muss die ideale Hülle am Maximum-Material-Maß einhalten. Form- und Maßabweichung teilen sich also dieselbe Toleranz. Für die Form bleibt nur der ungenutzte Rest, das verlangt eine genauere Fertigung.

### Was ist das Maximum-Material-Maß bei Welle und Bohrung?
Der Zustand, in dem am meisten Material vorhanden ist. Bei der Welle ist das das Höchstmaß, bei der Bohrung das Mindestmaß.

### Was sind Gutmaß und Ausschussmaß?
Das Gutmaß ist das Grenzmaß, das beim Abtragen zuerst erreicht wird, also das Maximum-Material-Maß. Das andere ist das Ausschussmaß: Wer darüber hinaus abträgt, produziert Ausschuss. Die Welle muss durch die Gutseite der Rachenlehre passen und darf nicht durch die Ausschussseite gleiten.

### Was sagen bei »H7« der Buchstabe und die Zahl?
Der Buchstabe gibt die Lage des Toleranzfelds zur Nulllinie an, die Zahl den Toleranzgrad, also die Größe des Felds. Großbuchstaben gelten für Bohrungen, Kleinbuchstaben für Wellen.

### Was bedeutet »ISO 2768-mK«, und wofür gilt es nicht?
Allgemeintoleranzen: Klasse m (mittel) für Längen und Winkel, Klasse K für Form und Lage. Sie gelten für alle Maße ohne eigene Toleranz, aber nicht für Hilfsmaße in Klammern und theoretisch genaue Maße im Rahmen.

### Was unterscheidet Form- von Lagetoleranzen?
Formtoleranzen beschreiben ein Element allein, zum Beispiel Geradheit, Ebenheit oder Rundheit. Sie brauchen keinen Bezug. Lagetoleranzen beschreiben ein Element relativ zu einem Bezug, zum Beispiel Parallelität, Rechtwinkligkeit oder Rundlauf.

### Wann setzt man den Bezugspfeil in die Verlängerung der Maßlinie?
Wenn eine Achse oder Mittelebene toleriert wird. Wird dagegen eine Fläche oder Linie toleriert, sitzt der Pfeil deutlich neben der Maßlinie auf der Kontur.

### Wann toleriert man Rundlauf und wann Planlauf?
Rundlauf für Mantelflächen (radial gemessen), Planlauf für Stirnflächen (axial gemessen). Bei der Gesamtlauftoleranz wird die Messuhr zusätzlich über die ganze Fläche verschoben.

### Woran erkennt man Spiel-, Übergangs- und Übermaßpassung?
- Spiel: Höchst- und Mindestpassung sind beide ≥ 0. Das Bohrungsfeld liegt über dem Wellenfeld.
- Übergang: Die Höchstpassung ist positiv, die Mindestpassung negativ. Die Felder überlappen.
- Übermaß: Beide sind negativ. Das Bohrungsfeld liegt unter dem Wellenfeld.

### Warum bevorzugt man das System Einheitsbohrung?
Eine Bohrung genau zu fertigen braucht Reibahlen und Lehren für jedes Maß. Eine Welle lässt sich leichter auf verschiedene Maße drehen und schleifen. Mit einer einheitlichen Bohrung H und verschiedenen Wellen spart man also Werkzeuge und Lehren.

### Welche Passungsart wählt man für feste Verbindungen, gesicherte Verbindungen und Teile, die man von Hand fügt?
- Ohne zusätzliche Verdrehsicherung: Übermaßpassung, zum Beispiel H7/r6.
- Mit Sicherung (Passfeder): Übergangspassung, zum Beispiel H7/k6 oder H7/n6.
- Von Hand fügbar: Spielpassung, zum Beispiel H7/h6.

## Kapitel 7 · Gewinde und Schraubenverbindungen

### Welche Durchmesser zeichnet man beim Gewinde breit und welche schmal?
Beim Bolzen ist der Nenndurchmesser breit und der Kerndurchmesser schmal. Bei der Mutter ist es umgekehrt. Breit ist immer die Kante, die den Körper begrenzt und die man mit dem Messschieber greifen kann.

### Warum zeichnet man den Gewindegrund in der Draufsicht nur als ¾-Kreis?
Die Linie des Gewindegrunds windet sich durch die Steigung nach unten und ist deshalb nur über etwa 270° sichtbar. Beim Bolzen ist der Kern der schmale ¾-Kreis, bei der Mutter der Nenndurchmesser.

### Welches Gewinde hat bei verschraubten Teilen Vorrang?
Das Bolzengewinde. Seine Kanten werden breit gezeichnet, und die Schraffur der Mutter endet an der Kante des Bolzens.

### Was ist der Unterschied zwischen nutzbarer Gewindelänge, Gewindeauslauf und Grundlochüberhang?
Die nutzbare Länge reicht bis zum letzten vollen Gang. Der Auslauf ist der herstellungsbedingte Rest mit kleiner werdenden Gängen. Der Grundlochüberhang ist die zusätzliche Bohrtiefe, damit das Werkzeug das Innengewinde schneiden kann.

### Woran erkennt man ein Feingewinde?
Es hat dasselbe 60°-Profil, aber eine kleinere Steigung. Die Steigung steht in der Bezeichnung, zum Beispiel M16 × 1,5. Fehlt sie, ist es ein Regelgewinde.

### Wofür nimmt man Trapez-, Säge- und Rundgewinde?
Trapezgewinde für Bewegungen in beide Richtungen (Leitspindeln, Schraubstöcke). Sägengewinde für Last in nur einer Richtung (Pressen). Rundgewinde bei Stößen und Schmutz.

### Was ist eine Dehnschraube und was eine Passschraube?
Bei der Dehnschraube ist der Schaft dünner als das Gewinde. Sie dehnt sich beim Anziehen und wirkt wie eine Feder, die die Vorspannkraft hält. Die Passschraube hat einen Schaft mit Passmaß zur Bohrung. Sie hält und positioniert zugleich.

### Ist ein Federring eine wirksame Schraubensicherung?
Nach dem Buch nicht: Versuche konnten nicht nachweisen, dass er die Vorspannung sicher hält. Auch eine Unterlegscheibe ist keine Sicherung gegen Losdrehen.

### Warum werden Normteile nicht bemaßt?
Ihre Maße sind durch die Norm festgelegt. Die Normbezeichnung in der Stückliste reicht für Bestellung und Montage.

## Kapitel 8 · Elemente an Achsen und Wellen

### Warum sind Wellenenden genormt?
Damit nicht jede Kupplung oder Riemenscheibe eine Sonderanfertigung ist. Gestufte Durchmesser mit zugeordneten Längen und Toleranzen passen zu genormten Naben.

### Welche drei Forderungen treffen an einem Wellenabsatz aufeinander?
Die Anlage braucht einen kleinen Radius, damit das Bauteil plan anliegt. Die Fertigung braucht einen Werkzeugauslauf. Die Festigkeit braucht einen großen Radius gegen Kerbwirkung. Der Freistich löst das mit einem definierten Auslauf und genormtem Radius.

### Wann reicht ein Freistich Form E, und wann braucht man Form F?
Form E, wenn nur der Zylinder weiterbearbeitet wird und an die Planfläche keine besonderen Anforderungen gestellt werden. Form F, wenn Zylinder und Planfläche beide bearbeitet werden, zum Beispiel an einer Lageranlageschulter.

### Wozu braucht man eine Zentrierbohrung?
Damit die Welle beim Drehen von der Reitstockspitze geführt wird und sich unter den Schnittkräften nicht verformt. Wird umgespannt, braucht man an beiden Enden eine.

### Wann darf eine Zentrierbohrung am Fertigteil nicht bleiben?
Wenn sie die Funktion stört, zum Beispiel an einer Stirnfläche, die als Anlage- oder Dichtfläche dient. Dann fertigt man die Welle länger und kürzt sie danach.

### Warum hat nicht jeder Wellendurchmesser einen eigenen Passfederquerschnitt?
Gestufte Querschnitte und Normlängen reduzieren die Vielfalt. Man braucht weniger Fräser, weniger Lagerhaltung, und die Feder ist ein Katalogteil.

### Wie überträgt eine Passfeder das Drehmoment?
Formschlüssig über ihre Seitenflächen. Oben hat sie Spiel zur Nabennut. Axialkräfte überträgt sie nicht.

### Wie unterscheiden sich Passfeder, Vielnutprofil und Polygonprofil beim Drehmoment?
Die Passfeder überträgt kleine bis mittlere Momente. Ein Vielnutprofil überträgt wesentlich größere. Das Polygonprofil überträgt bei gleichem Durchmesser das höchste Moment, weil es keine Kerbe durch eine Nut hat.

## Kapitel 9 · Sicherungselemente

### Warum braucht man überhaupt axiale Sicherungen?
Formschlüssige Welle-Nabe-Verbindungen wie die Passfeder übertragen keine Axialkräfte. Ohne Sicherung könnten Welle und Nabe axial wandern. Ein Wellenbund stützt nur in eine Richtung ab.

### Warum ist ein Sicherungsring im ungespannten Zustand nicht kreisrund?
Seine radiale Breite nimmt zu den Enden hin ab. Eingebaut verformt er sich dadurch rund und liegt mit gleichmäßiger Vorspannung in der Nut.

### Warum ist die Nut breiter als der Sicherungsring, und wann ist das ungünstig?
Damit der Ring trotz Toleranzen sicher hineinpasst. Ungünstig ist das, wenn das Bauteil spielfrei sitzen muss, zum Beispiel bei wechselnden Axialkräften oder präzisen Lagerungen.

### Warum setzt man Sicherungsringe möglichst an Wellenenden?
Die Nut hat einen kleinen Radius und damit eine hohe Kerbwirkung. An den Wellenenden ist die Biegebeanspruchung gering, deshalb schadet die Kerbe dort am wenigsten.

### Was spricht für einen Sicherungsring und was für eine Nutmutter?
Der Sicherungsring ist einfach, billig, braucht wenig Platz und ist schnell montiert. Die Nutmutter ist spielfrei, nachstellbar und nimmt höhere Axialkräfte auf, zum Beispiel am Festlager.

### Warum reicht die Wellennut für das Sicherungsblech bis unter das Lager?
Damit immer das Lager die Verschraubung axial begrenzt und nicht das Nutende. Sonst könnte die Mutter am Nutende anstehen, bevor sie das Lager festspannt.

## Kapitel 10 · Wälzlager und Lageranordnungen

### Was ist der grundlegende Unterschied zwischen Gleit- und Wälzlagern?
Im Gleitlager gleitet die Welle direkt auf einem Schmierfilm. Im Wälzlager rollen Wälzkörper zwischen den Ringen ab, es herrscht also Rollreibung statt Gleitreibung.

### Welche Aufgabe hat der Käfig im Wälzlager?
Er hält die Wälzkörper auf Abstand und verteilt sie gleichmäßig über den Umfang. Ohne ihn würden sie aneinander reiben.

### Welche Regeln gelten für die Schnittdarstellung eines Wälzlagers?
Das Lager wird immer geschnitten. Innen- und Außenring bekommen dieselbe Schraffur, die Wälzkörper werden nicht geschnitten. Der Käfig wird meist weggelassen, Kantenradien zeichnet man immer.

### Welche Kräfte nimmt ein Kegelrollenlager auf, und warum baut man es paarweise ein?
Hohe Radial- und Axialkräfte, axial aber nur in einer Richtung. Deshalb baut man zwei spiegelbildlich ein. Das Spiel lässt sich dann über eine Nutmutter einstellen.

### Warum baut man keine Festlager-Festlager-Anordnung und keine Loslager-Loslager-Anordnung?
Bei zwei Festlagern verspannt die Wärmedehnung der Welle die Lager gegeneinander. Bei zwei Loslagern ist die Welle axial nicht geführt und kann wandern. Deshalb führt ein Festlager die Welle axial, und das Loslager lässt die Längenänderung zu.

Bild: Ein Brückenträger: an einem Ende fest verankert, am anderen auf Rollen, damit er sich im Sommer ausdehnen kann.

### Was ist Punktlast und was Umfangslast, und welcher Ring bekommt den festen Sitz?
Bei Punktlast drückt die Kraft immer auf dieselbe Stelle des Rings. Bei Umfangslast läuft die Kraft relativ zum Ring um. Der Ring mit Umfangslast bekommt den festen Sitz, sonst würde er langsam in seinem Sitz wandern.

### Welcher Ring bekommt beim Laufrad auf einer stehenden Achse den festen Sitz?
Der Außenring. Er dreht sich mit dem Rad unter der stillstehenden Last hindurch, hat also Umfangslast. Der Innenring steht mit der Achse still zur Last, hat Punktlast und darf lose sitzen.

### Warum sichert man das Loslager oft mit einem Sicherungsring, das Festlager mit einer Nutmutter?
Das Loslager muss nur einen Ring leicht halten, dafür reicht ein billiger Sicherungsring. Das Festlager nimmt alle Axialkräfte auf und soll spielfrei sitzen. Das schafft nur die Nutmutter mit Sicherungsblech.

## Kapitel 11 · Dichtungen

### Wozu braucht man Dichtungen?
Um Stoffverluste (Gase, Flüssigkeiten) zu vermeiden, die Vermischung verschiedener Betriebsstoffe zu verhindern und Verschleiß durch Schmutz, Staub und Feuchtigkeit zu vermeiden.

### Nach welchen Merkmalen teilt man Dichtungen ein, und welche Kombination gibt es nicht?
Nach ruhenden oder bewegten Bauteilen und nach berührend oder berührungsfrei. Berührungsfreie Dichtungen an ruhenden Teilen gibt es nicht.

### Wie funktioniert eine statische Dichtung?
Die Rauheitsspitzen der Bauteilfläche drücken sich in den Dichtungswerkstoff ein und schließen so die Spalte. Dafür braucht es einen weicheren Dichtungswerkstoff und eine Anpresskraft durch Schrauben oder Betriebsdruck.

### Ist ein Faltenbalg eine dynamische Dichtung?
Nein. Er ist eine statische, hermetische Dichtung, die an beiden Enden fest sitzt. Er kann bewegte Teile nur wegen seiner Form abdichten.

### Warum zeichnet man einen eingebauten O-Ring verformt?
Die Verformung erzeugt die Anpresskraft, die abdichtet. Ein unverformt gezeichneter O-Ring würde eine Dichtung ohne Wirkung zeigen.

### Warum hat ein Radial-Wellendichtring einen kleinen Leckverlust, obwohl er berührend dichtet?
Unter der Lippe muss ein Schmierfilm des Mediums vorhanden sein, sonst verschleißt sie schnell. Dieser Film führt auf Dauer zu einer geringen Leckage.

### Was ist der Unterschied zwischen Strömungsdichtungen und Schutzdichtungen?
Strömungsdichtungen arbeiten bei einem Druckunterschied und bremsen das Medium ab, zum Beispiel durch ein Labyrinth. Sie haben immer eine Leckmenge. Schutzdichtungen halten Schmutz fern, ohne dass ein nennenswerter Druckunterschied besteht.

### Warum eignen sich berührungsfreie Dichtungen für hohe Drehzahlen?
Es gibt keinen Kontakt, also keine Reibung, keine Wärme und praktisch keinen Verschleiß. Dafür sind sie nie ganz dicht.

## Kapitel 12 · Zahnräder

### Nach welchen Merkmalen teilt man Zahnradgetriebe ein?
Nach der Grobgestalt der Räder und der Lage der Wellen. Parallele Wellen: Stirnräder. Sich schneidende Wellen: Kegelräder. Sich kreuzende Wellen: Schnecken-, Schraub- und Hypoidgetriebe.

### Was ist der Modul, und warum müssen kämmende Räder denselben Modul haben?
m = d/z, also Teilkreisdurchmesser pro Zahn. Er bestimmt die Zahngröße. Nur bei gleichem Modul passen Teilung und Zahnform zusammen.

Bild: Wie die Gliedergröße einer Fahrradkette: Ritzel und Kettenblatt müssen zur selben Kette passen.

### Woran erkennt man in einer Ansicht, dass eine Scheibe ein Zahnrad ist?
Nur an der strichpunktierten Teilkreislinie. Die Zähne selbst werden nicht gezeichnet.

### Mit welchen Linien zeichnet man Kopf-, Teil- und Fußkreis?
Den Kopfkreis als breite Volllinie, weil er die Körperkante ist. Den Teilkreis als schmale Strich-Punktlinie. Den Fußkreis als schmale Volllinie, nur bei Bedarf.

### Wie werden Zähne im Achsschnitt dargestellt?
Ungeschnitten, die Schraffur endet an der Fußlinie. Im Vollschnitt zeichnet man zwei gegenüberliegende Zähne, auch bei ungerader Zähnezahl.

### Welches Rad liegt bei einem Radpaar in der Zeichnung vorn?
Beim Stirnradpaar das Ritzel, beim Kegelradpaar das Ritzel vor dem Tellerrad, beim Schneckengetriebe die Schnecke.

### Was bedeutet die Verzahnungsqualität?
Sie reicht von 1 (höchste, kaum herstellbare Genauigkeit) bis 12 (gröbste). Üblich sind 5 bis 8.

### Wozu dient das Getriebe-Passsystem nach DIN 3967?
Es legt über die Zahndickenabmaße das Flankenspiel des montierten Radpaars fest. Zu wenig Spiel klemmt bei Wärmedehnung, zu viel Spiel führt zu Stößen bei Lastwechsel.

### Warum braucht ein Zahnrad mit H7/k6-Sitz trotzdem eine Passfeder?
H7/k6 ist eine Übergangspassung und garantiert keinen Presssitz. Das Drehmoment muss deshalb formschlüssig über die Passfeder übertragen werden.

## Kapitel 13 · Zeichnungen lesen und erstellen

### Was ist der Unterschied zwischen Übertragungs- und Führungsgetrieben?
Übertragungsgetriebe leiten Leistung weiter (Drehmoment und Drehzahl) und wandeln sie gegebenenfalls. Führungsgetriebe führen Punkte eines Körpers auf bestimmten Bahnen.

### Warum haben zwei gleiche Schrägkugellager zwei Positionsnummern, zwei gleiche Rillenkugellager aber nur eine?
Schrägkugellager haben eine Einbaurichtung und werden hier spiegelbildlich eingebaut. Für die Montage sind es also verschiedene Positionen. Rillenkugellager haben keine Einbaurichtung.

### Warum gibt es Lücken in den Positionsnummern einer Stückliste?
Entweder historisch, weil Teile geändert und neu nummeriert wurden, oder bewusst freigelassen für spätere Ergänzungen.

### Wozu dienen Abdrückgewinde, und warum sind es mindestens zwei?
Sie helfen bei der Demontage: Schrauben drücken das Teil aus seinem Sitz heraus. Mit zwei Gewinden wird gleichmäßig gedrückt, und das Teil verkantet nicht.

### Warum darf der Außenring im stehenden Lagerhalter mit Spiel sitzen?
Die Welle dreht, der Lagerhalter steht. Der Außenring hat also Punktlast und darf locker sitzen.

### Nach welchem Prinzip verteilt man Rauheiten an einem Einzelteil?
Nach der Funktion. Funktionslose, aber sichtbare Flächen bekommen eine grobe Rauheit. Dicht- und Auflageflächen bekommen eine mittlere. Lagersitze, Dichtringsitze und Zentrierungen bekommen die feinste.

### Welcher Bezug wird für Lauftoleranzen an einem Flanschlager gewählt?
Die Sitzfläche des Wälzlagers, weil sie die Drehachse festlegt. Gekrümmte Flächen bekommen Rundlauf, plane Flächen Planlauf.
