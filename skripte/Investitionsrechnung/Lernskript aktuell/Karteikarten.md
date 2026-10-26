# Karteikarten · Investitionsrechnung

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

## Kapitel 1 · KLR und Deckungsbeitragsrechnung

### Warum kann ein Betrieb viel verkaufen und trotzdem Verlust machen?
Jedes verkaufte Stück muss erst seine eigenen variablen Kosten bezahlen. Der Rest, der Deckungsbeitrag, muss dann noch die Fixkosten decken. Ist der Deckungsbeitrag zu klein oder die Menge zu gering, bleibt trotz hohem Umsatz ein Verlust.
Quelle: 1.4
Abbildung: deckungsbalken

### Was bedeuten Groß- und Kleinbuchstaben in der Kostenrechnung (z. B. K und k)?
Großbuchstaben stehen für Beträge der ganzen Menge in einer Periode (z. B. $K$ in €/Monat). Kleinbuchstaben für Beträge je Stück (z. B. $k$ in €/Stück). Beides darf man nicht direkt addieren.
Quelle: 1.1
Abbildung: original-merke

### Mit welchen Preisen rechnet man in der KLR, brutto oder netto?
Immer mit Nettopreisen. Die Umsatzsteuer ist kein Erlös des Betriebs, sie wird an das Finanzamt weitergegeben. $"Netto" = "Brutto" \/ "1,19"$ bei 19 % USt.
Quelle: 1.1
Abbildung: original-merke

### Warum braucht eine Kapazitätsangabe immer einen Zeitbezug?
7 000 Stück pro Stunde ist etwas völlig anderes als 7 000 Stück pro Monat. Der Beschäftigungsgrad (genutzte durch mögliche Menge) ist nur sinnvoll, wenn Zähler und Nenner zur selben Periode gehören.
Quelle: 1.1

### Was unterscheidet fixe von variablen Kosten?
Fixe Kosten bleiben im betrachteten Bereich gleich, egal wie viel produziert wird, z. B. Miete. Variable Kosten ändern sich mit der Menge, z. B. Material je Stück.

Test: Ändert sich der Betrag, wenn ich ein Stück mehr herstelle?

Bild: Handyvertrag: Grundgebühr ist fix, jede Minute variabel.
Quelle: 1.2
Abbildung: original-sprung

### Warum beweist „je Stück“ allein noch nicht, dass Kosten variabel sind?
Auch Fixkosten kann man rechnerisch auf Stücke verteilen, z. B. Miete geteilt durch Stückzahl. Entscheidend ist, ob sich der Gesamtbetrag mit der Menge ändert, nicht wie er angegeben ist.
Quelle: 1.2
Abbildung: original-sprung

### Was sind Mischkosten, und was muss ich vor dem Rechnen mit ihnen tun?
Mischkosten enthalten einen fixen und einen variablen Anteil, z. B. die Stromrechnung mit Grundpreis und Verbrauchspreis. Vor dem Rechnen muss ich sie in den fixen und den variablen Teil aufteilen.
Quelle: 1.2

### Was sind sprungfixe Kosten?
Sie bleiben nur innerhalb eines Mengenbereichs konstant. Ab einer Grenze braucht man z. B. eine weitere Maschine oder Schicht, dann springen die Fixkosten auf einen neuen Block. Über so einen Sprung hinweg darf man nicht mit einem unveränderten $K_f$ rechnen.

Bild: Treppe statt Rampe.
Quelle: 1.2
Abbildung: original-sprung

### Was beschreibt die Kostenfunktion K(x) = K_f + k_v·x?
Die Gesamtkosten einer Periode: ein fester Block $K_f$ plus für jedes Stück die variablen Kosten $k_v$:
$ K = K_f + k_v x $
Im Diagramm eine Gerade, die bei $K_f$ startet und mit $k_v$ ansteigt. Gilt nur, solange die Fixkosten gleich bleiben und die variablen Kosten proportional sind.
Quelle: 1.3
Abbildung: stueckkosten

### Warum sinken die Stückkosten, wenn die Menge steigt (Fixkostendegression)?
$ k = K_f/x + k_v $
Die gleichen Fixkosten werden auf mehr Stücke verteilt, der fixe Anteil je Stück sinkt. Der variable Anteil $k_v$ bleibt gleich. Deshalb heißt das auch „Gesetz der Massenproduktion“.

Bild: Eine WG teilt die Miete: zu viert zahlt jeder weniger als zu zweit, das Essen pro Person wird dadurch aber nicht billiger.
Quelle: 1.3
Abbildung: stueckkosten

### Können die Stückkosten unter die variablen Stückkosten fallen?
Nein, solange es Fixkosten gibt. $k = K_f\/x + k_v$ liegt immer über $k_v$, der fixe Anteil wird nur kleiner. Bei $x = 0$ sind Stückkosten gar nicht definiert, obwohl die Fixkosten anfallen.
Quelle: 1.3
Abbildung: stueckkosten

### Was ist der Stückdeckungsbeitrag?
$"db" = e - k_v$, also Nettoerlös je Stück minus variable Kosten je Stück. Das ist der Betrag, den jedes Stück zur Deckung der Fixkosten beiträgt.

Bild: Die Fixkosten sind ein leerer Eimer. Jedes verkaufte Stück schüttet seinen Deckungsbeitrag hinein. Erst wenn der Eimer voll ist, entsteht Gewinn.
Quelle: 1.4
Abbildung: deckungsbalken

### Warum ist der Stückdeckungsbeitrag noch nicht der Gewinn je Stück?
Er deckt erst die variablen Kosten des Stücks. Die Fixkosten sind davon noch nicht abgezogen. Erst wenn alle Deckungsbeiträge zusammen die Fixkosten übersteigen, entsteht Gewinn.
Quelle: 1.4
Abbildung: deckungsbalken

### Wie hängen Deckungsbeitrag und Gewinn zusammen?
$ G = "db" dot x - K_f = "DB I" - K_f $
Man multipliziert den Stückdeckungsbeitrag mit der Menge und zieht die Fixkosten genau einmal ab. Das ist dieselbe Rechnung wie Erlöse minus Kosten, nur schneller.
Quelle: 1.4
Abbildung: deckungsbalken

### Was ist der Unterschied zwischen einstufiger und mehrstufiger Deckungsbeitragsrechnung?
Einstufig zieht man alle Fixkosten auf einmal vom gesamten Deckungsbeitrag ab. Mehrstufig ordnet man sie erst dem Produkt, dann der Produktgruppe und zuletzt dem Unternehmen zu. Deshalb kann „DB II“ je nach Schema etwas anderes bedeuten.
Quelle: 1.4
Abbildung: deckungsbalken

### Was ist der Break-Even-Point, und wie leitet man ihn her?
Die Gewinnschwelle: Die Menge, bei der Erlöse genau alle Kosten decken, der Gewinn ist null. Aus $E = K$ folgt $(e - k_v) dot x = K_f$, also
$ x_"BEP" = K_f/"db" $

Anschaulich: Wie viele Deckungsbeiträge brauche ich, um den Fixkosteneimer zu füllen?
Quelle: 1.5
Abbildung: original-bep

### Wann gibt es keine Gewinnschwelle?
Wenn der Stückdeckungsbeitrag null oder negativ ist. Dann deckt kein Stück auch nur seine variablen Kosten, und mehr Produktion macht die Lage nicht besser, sondern höchstens schlechter.
Quelle: 1.5
Abbildung: original-bep

### Wie rundet man den Break-Even-Point bei ganzen Stückzahlen?
Ist die exakte Schwelle nicht ganzzahlig, rundet man auf: Die kleinste ganze Menge ohne Verlust. Bei 914,3 Stück sind 914 noch Verlust, 915 schon Gewinn. Eine schon ganzzahlige Schwelle bleibt, wie sie ist.
Quelle: 1.5
Abbildung: original-bep

### Wie liest man ein Break-Even-Diagramm?
Waagerecht die Menge, senkrecht Euro. Die Erlösgerade startet im Ursprung mit Steigung $e$. Die Kostengerade startet bei $K_f$ mit Steigung $k_v$. Der Schnittpunkt ist der BEP. Rechts davon ist der Abstand der Geraden der Gewinn, links der Verlust. Die Kapazität ist eine senkrechte Grenze.
Quelle: 1.5
Abbildung: bep-aufgabe1

### Wo liegt im linearen Modell das Gewinnmaximum?
Bei positivem Stückdeckungsbeitrag bringt jedes weitere Stück mehr Gewinn. Das Maximum liegt also an der Kapazitätsgrenze, sofern die Nachfrage so viel abnimmt. Fehlt die Nachfrage, begrenzt sie die Menge.
Quelle: 1.5.1

### Was bedeutet ein hoher Beschäftigungsgrad am Break-Even-Point?
Man braucht fast die ganze Kapazität, nur um keinen Verlust zu machen. Es bleibt wenig Puffer: Schon ein kleiner Absatzrückgang führt in den Verlust.
Quelle: 1.5
Abbildung: bep-aufgabe1

### Wie wirken höhere Fixkosten, höhere variable Kosten oder ein anderer Preis auf den Break-Even-Point?
- Höhere Fixkosten: mehr muss gedeckt werden, der BEP steigt.
- Höhere variable Kosten: kleinerer db, der BEP steigt.
- Höherer Preis: größerer db, der BEP sinkt.
- Niedrigerer Preis: kleinerer db, der BEP steigt.

Alles läuft über $x_"BEP" = K_f \/ "db"$.
Quelle: 1.5
Abbildung: original-bep

### Was bedeutet es, wenn der Break-Even-Point über der Kapazität liegt?
Selbst bei voller Auslastung macht der Betrieb Verlust. Stellschrauben: Preis erhöhen, variable Kosten senken, Fixkosten senken oder Kapazität erweitern. Eine Erweiterung kann aber neue Fixkosten bringen, beides muss man zusammen prüfen.
Quelle: 1.8.1
Abbildung: bep-ausserhalb

### Was ist bei einer allgemeinen Preissenkung zu beachten?
Der niedrigere Preis gilt für **alle** Stücke, auch für die bisherigen Kunden. Man verliert auf der alten Menge Deckungsbeitrag, und die zusätzliche Menge muss das erst ausgleichen. Vergleichen muss man den gesamten Gewinn vorher und nachher, mit Kapazität und Nachfrage als Grenze.
Quelle: 1.6.1

### Wann lohnt sich ein einmaliger Zusatzauftrag zu einem niedrigeren Preis?
Wenn freie Kapazität da ist, die Fixkosten gleich bleiben und der Zusatzpreis über den variablen Stückkosten liegt. Dann steigt der Gewinn um $(e_Z - k_v) dot x_Z$. Die Fixkosten zieht man dabei nicht noch einmal ab, sie fallen ohnehin an.
Quelle: 1.6.2
Abbildung: entscheidungsvergleich

### Welches Risiko hat ein Zusatzauftrag zu einem Sonderpreis?
Bisherige Kunden könnten vom niedrigeren Preis erfahren und ihn ebenfalls verlangen. Dann bricht die Preisdifferenzierung zusammen und der Gewinn kann massiv sinken. Außerdem bindet der Auftrag Kapazität.
Quelle: 1.6.2
Abbildung: entscheidungsvergleich

### Muss ein Betrieb seine Fixkosten schon gedeckt haben, damit ein Zusatzauftrag sinnvoll ist?
Nein. Jeder positive zusätzliche Deckungsbeitrag verbessert das Ergebnis, auch wenn er nur einen bestehenden Verlust verkleinert.
Quelle: 1.6.2
Abbildung: entscheidungsvergleich

### Was ist die kurzfristige und was die langfristige Preisuntergrenze?
Kurzfristig (freie Kapazität, Fixkosten fallen sowieso an): Der Preis muss mindestens die variablen Stückkosten decken, $e >= k_v$. Erst darüber wächst der Gewinn.

Langfristig muss der Preis auch die Fixkosten tragen: $e >= k$, also die vollen Stückkosten.
Quelle: 1.6.3

### Wie bestimmt man variable Stückkosten und Fixkosten aus zwei Perioden?
Bei gleicher Kostenstruktur kommt der Kostenunterschied nur von der Mengenänderung:
$ k_v = (Delta K)/(Delta x), quad K_f = K_1 - k_v x_1 $
Gegenprobe: Mit der zweiten Periode muss dasselbe $K_f$ herauskommen.

Bild: Stromrechnung bei 300 und 400 kWh: Die Differenz zeigt den Preis pro kWh, der Rest ist die Grundgebühr.
Quelle: 1.7

### Was ändert sich bei doppelter Menge: K_f, k_f oder k?
$K_f$ bleibt gleich. $k_f = K_f\/x$ halbiert sich. Die gesamten Stückkosten $k$ sinken auch, aber nicht auf die Hälfte, weil $k_v$ gleich bleibt.
Quelle: 1.3
Abbildung: stueckkosten

### Wie gehe ich an jede KLR-Textaufgabe heran?
1. Basis: Netto? Gleiche Periode?
2. Modell: Was ist fix, was variabel? Kommen neue Kosten dazu?
3. Ansatz: Kosten, Erlöse und DB trennen, nach der gesuchten Größe umstellen.
4. Machbarkeit: Passt die Menge in Kapazität und Nachfrage?
5. Prüfung: Einheiten, Vorzeichen, Rundung.
6. Entscheidung: begründetes Ja oder Nein mit Bedingungen.
Quelle: 1.8.2

### Warum soll man beim Ergebnis ein Vorzeichen schreiben?
Damit sofort klar ist, ob es ein Gewinn oder Verlust ist: $G = +4 thin 000 "€"$ oder $G = -3 thin 000 "€"$.
Quelle: 1.8.2

### Zeichne die Begriffslandkarte zu Kapitel 1 aus dem Kopf: Welche Begriffe gehören dazu und wie hängen sie zusammen?
Am Anfang steht die **Bezugsgröße**: Periode, Nettopreise, Stück oder gesamt. Dann zerlege ich die Kosten in **fixe Kosten** $K_f$ und **variable Stückkosten** $k_v$; daraus entstehen die Kostenfunktion $K(x)$ und die Stückkosten $k(x)$.

Mit dem Preis kommt der **Deckungsbeitrag** dazu: $d = p - k_v$ je Stück, $D = d dot x$ gesamt. Er deckt erst die Fixkosten, der Rest ist Gewinn. Daraus folgt die **Gewinnschwelle** $x_"BEP" = K_f / d$, die ich mit Kapazität und Nachfrage abgleiche. Am Ende stehen **Entscheidungen** (Preissenkung, Zusatzauftrag), bei denen ich nur die tatsächlichen Änderungen vergleiche.

Bild: Wie eine Treppe: Bezugsgröße → Kosten → Deckungsbeitrag → Gewinnschwelle → Entscheidung. Keine Stufe lässt sich überspringen.
Quelle: 1.1
