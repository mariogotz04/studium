<!-- Kartenstil: kurze Stichpunkte; Merksätze und Bild:-Analogien sind ergänzte eigene Lernhilfen. Fachliche Grundlage bleibt die jeweilige Quelle. -->
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
- Jedes verkaufte Stück muss erst seine eigenen variablen Kosten bezahlen.
- Der Rest, der Deckungsbeitrag, muss dann noch die Fixkosten decken.
- Ist der Deckungsbeitrag zu klein oder die Menge zu gering, bleibt trotz hohem Umsatz ein Verlust.

**Merksatz:** Umsatz füllt erst Kostenlücken, dann entsteht Gewinn.

Quelle: 1.4
Abbildung: deckungsbalken

### Was bedeuten Groß- und Kleinbuchstaben in der Kostenrechnung (z. B. K und k)?
- Großbuchstaben stehen für Beträge der ganzen Menge in einer Periode (z. B. $K$ in €/Monat).
- Kleinbuchstaben für Beträge je Stück (z. B. $k$ in €/Stück).
- Beides darf man nicht direkt addieren.

**Merksatz:** Groß rechnet gesamt, klein rechnet je Stück.

Quelle: 1.1
Abbildung: original-merke

### Mit welchen Preisen rechnet man in der KLR, brutto oder netto?
- Immer mit Nettopreisen.
- Die Umsatzsteuer ist kein Erlös des Betriebs, sie wird an das Finanzamt weitergegeben.
- $"Netto" = "Brutto" \/ "1,19"$ bei 19 % USt.

Quelle: 1.1
Abbildung: original-merke

### Warum braucht eine Kapazitätsangabe immer einen Zeitbezug?
- 7 000 Stück pro Stunde ist etwas völlig anderes als 7 000 Stück pro Monat.
- Der Beschäftigungsgrad (genutzte durch mögliche Menge) ist nur sinnvoll, wenn Zähler und Nenner zur selben Periode gehören.

**Merksatz:** Gleiche Mengen brauchen denselben Zeitmaßstab.

Quelle: 1.1

### Was unterscheidet fixe von variablen Kosten?
- Fixe Kosten bleiben im betrachteten Bereich gleich, egal wie viel produziert wird, z. B. Miete.
- Variable Kosten ändern sich mit der Menge, z. B. Material je Stück.
- **Test:** Ändert sich der Betrag, wenn ich ein Stück mehr herstelle?

**Merksatz:** Fix bleibt im Bereich gleich; variabel wächst mit der Menge.

Bild: Handyvertrag: Grundgebühr ist fix, jede Minute variabel.
Quelle: 1.2
Abbildung: original-sprung

### Warum beweist „je Stück“ allein noch nicht, dass Kosten variabel sind?
- Auch Fixkosten kann man rechnerisch auf Stücke verteilen, z. B. Miete geteilt durch Stückzahl.
- Entscheidend ist, ob sich der Gesamtbetrag mit der Menge ändert, nicht wie er angegeben ist.

**Merksatz:** „Je Stück“ beschreibt die Angabe, nicht das Kostenverhalten.

Quelle: 1.2
Abbildung: original-sprung

### Was sind Mischkosten, und was muss ich vor dem Rechnen mit ihnen tun?
- Mischkosten enthalten einen fixen und einen variablen Anteil, z. B. die Stromrechnung mit Grundpreis und Verbrauchspreis.
- Vor dem Rechnen muss ich sie in den fixen und den variablen Teil aufteilen.

**Merksatz:** Mischkosten erst zerlegen, dann rechnen.

Bild: Ein Taxipreis aus Grundpreis und Kilometerpreis: Ein Teil fällt einmal an, ein Teil wächst mit der Fahrt.
Quelle: 1.2

### Was sind sprungfixe Kosten?
- Sie bleiben nur innerhalb eines Mengenbereichs konstant.
- Ab einer Grenze braucht man z. B. eine weitere Maschine oder Schicht, dann springen die Fixkosten auf einen neuen Block.
- Über so einen Sprung hinweg darf man nicht mit einem unveränderten $K_f$ rechnen.

**Merksatz:** Sprungfix heißt: gleich bis zur nächsten Stufe.

Bild: Treppe statt Rampe.
Quelle: 1.2
Abbildung: original-sprung

### Was beschreibt die Kostenfunktion K(x) = K_f + k_v·x?
- **Die Gesamtkosten einer Periode:** ein fester Block $K_f$ plus für jedes Stück die variablen Kosten $k_v$:
$ K = K_f + k_v x $
- Im Diagramm eine Gerade, die bei $K_f$ startet und mit $k_v$ ansteigt.
- Gilt nur, solange die Fixkosten gleich bleiben und die variablen Kosten proportional sind.

Quelle: 1.3
Abbildung: stueckkosten

### Warum sinken die Stückkosten, wenn die Menge steigt (Fixkostendegression)?
$ k = K_f/x + k_v $
- Die gleichen Fixkosten werden auf mehr Stücke verteilt, der fixe Anteil je Stück sinkt.
- Der variable Anteil $k_v$ bleibt gleich.
- Deshalb heißt das auch „Gesetz der Massenproduktion“.

**Merksatz:** Mehr Stücke teilen sich denselben Fixkostenblock.

Bild: Eine WG teilt die Miete: zu viert zahlt jeder weniger als zu zweit, das Essen pro Person wird dadurch aber nicht billiger.
Quelle: 1.3
Abbildung: stueckkosten

### Können die Stückkosten unter die variablen Stückkosten fallen?
- Nein, solange es Fixkosten gibt.
- $k = K_f\/x + k_v$ liegt immer über $k_v$, der fixe Anteil wird nur kleiner.
- Bei $x = 0$ sind Stückkosten gar nicht definiert, obwohl die Fixkosten anfallen.

Quelle: 1.3
Abbildung: stueckkosten

### Was ist der Stückdeckungsbeitrag?
- $"db" = e - k_v$, also Nettoerlös je Stück minus variable Kosten je Stück.
- Das ist der Betrag, den jedes Stück zur Deckung der Fixkosten beiträgt.

**Merksatz:** Der Deckungsbeitrag deckt zuerst die Fixkosten.

Bild: Die Fixkosten sind ein leerer Eimer. Jedes verkaufte Stück schüttet seinen Deckungsbeitrag hinein. Erst wenn der Eimer voll ist, entsteht Gewinn.
Quelle: 1.4
Abbildung: deckungsbalken

### Warum ist der Stückdeckungsbeitrag noch nicht der Gewinn je Stück?
- Der Stückdeckungsbeitrag ist der Erlösrest nach Abzug der variablen Kosten.
- Die Fixkosten sind davon noch nicht abgezogen.
- Erst wenn alle Deckungsbeiträge zusammen die Fixkosten übersteigen, entsteht Gewinn.

**Merksatz:** Deckungsbeitrag ist noch kein Gewinn.

Quelle: 1.4
Abbildung: deckungsbalken

### Wie hängen Deckungsbeitrag und Gewinn zusammen?
$ G = "db" dot x - K_f = "DB I" - K_f $
- Man multipliziert den Stückdeckungsbeitrag mit der Menge und zieht die Fixkosten genau einmal ab.
- Das ist dieselbe Rechnung wie Erlöse minus Kosten, nur schneller.

Quelle: 1.4
Abbildung: deckungsbalken

### Was ist der Unterschied zwischen einstufiger und mehrstufiger Deckungsbeitragsrechnung?
- Einstufig zieht man alle Fixkosten auf einmal vom gesamten Deckungsbeitrag ab.
- Mehrstufig ordnet man sie erst dem Produkt, dann der Produktgruppe und zuletzt dem Unternehmen zu.
- Deshalb kann „DB II“ je nach Schema etwas anderes bedeuten.

Quelle: 1.4
Abbildung: deckungsbalken

### Was ist der Break-Even-Point, und wie leitet man ihn her?
- **Die Gewinnschwelle:** Die Menge, bei der Erlöse genau alle Kosten decken, der Gewinn ist null.
- Aus $E = K$ folgt $(e - k_v) dot x = K_f$, also
$ x_"BEP" = K_f/"db" $
- **Anschaulich:** Wie viele Deckungsbeiträge brauche ich, um den Fixkosteneimer zu füllen?

**Merksatz:** Gewinnschwelle: Fixkosten gerade gedeckt.

Quelle: 1.5
Abbildung: original-bep

### Wann gibt es keine Gewinnschwelle?
- Voraussetzung: **positive Fixkosten**.
- Stückdeckungsbeitrag null → Preis deckt nur die variablen Kosten.
- Negativer Stückdeckungsbeitrag → nicht einmal die variablen Kosten sind gedeckt.
- In beiden Fällen erreicht mehr Produktion keine Gewinnschwelle.

**Merksatz:** Ohne positiven Stückbeitrag hilft mehr Menge nicht zur Gewinnschwelle.

Quelle: 1.5
Abbildung: original-bep

### Wie rundet man den Break-Even-Point bei ganzen Stückzahlen?
- Ist die exakte Schwelle nicht ganzzahlig, rundet man auf: Die kleinste ganze Menge ohne Verlust.
- Bei 914,3 Stück sind 914 noch Verlust, 915 schon Gewinn.
- Eine schon ganzzahlige Schwelle bleibt, wie sie ist.

**Merksatz:** Eine angebrochene Stückzahl deckt keine volle Kostenlücke.

Quelle: 1.5
Abbildung: original-bep

### Wie liest man ein Break-Even-Diagramm?
- Waagerecht die Menge, senkrecht Euro.
- Die Erlösgerade startet im Ursprung mit Steigung $e$.
- Die Kostengerade startet bei $K_f$ mit Steigung $k_v$.
- Der Schnittpunkt ist der BEP.
- Rechts davon ist der Abstand der Geraden der Gewinn, links der Verlust.
- Die Kapazität ist eine senkrechte Grenze.

Quelle: 1.5
Abbildung: bep-aufgabe1

### Wo liegt im linearen Modell das Gewinnmaximum?
- Bei positivem Stückdeckungsbeitrag bringt jedes weitere Stück mehr Gewinn.
- Das Maximum liegt also an der Kapazitätsgrenze, sofern die Nachfrage so viel abnimmt.
- Fehlt die Nachfrage, begrenzt sie die Menge.

**Merksatz:** Ein positiver Stückbeitrag hilft nur bei verkäuflicher Menge.

Quelle: 1.5.1

### Was bedeutet ein hoher Beschäftigungsgrad am Break-Even-Point?
- Man braucht fast die ganze Kapazität, nur um keinen Verlust zu machen.
- **Es bleibt wenig Puffer:** Schon ein kleiner Absatzrückgang führt in den Verlust.

Quelle: 1.5
Abbildung: bep-aufgabe1

### Wie wirken höhere Fixkosten, höhere variable Kosten oder ein anderer Preis auf den Break-Even-Point?
- **Höhere Fixkosten:** mehr muss gedeckt werden, der BEP steigt.
- **Höhere variable Kosten:** kleinerer db, der BEP steigt.
- **Höherer Preis:** größerer db, der BEP sinkt.
- **Niedrigerer Preis:** kleinerer db, der BEP steigt.
- Alles läuft über $x_"BEP" = K_f \/ "db"$.

Quelle: 1.5
Abbildung: original-bep

### Was bedeutet es, wenn der Break-Even-Point über der Kapazität liegt?
- Selbst bei voller Auslastung macht der Betrieb Verlust.
- **Stellschrauben:** Preis erhöhen, variable Kosten senken, Fixkosten senken oder Kapazität erweitern.
- Eine Erweiterung kann aber neue Fixkosten bringen, beides muss man zusammen prüfen.

Quelle: 1.8.1
Abbildung: bep-ausserhalb

### Was ist bei einer allgemeinen Preissenkung zu beachten?
- Der niedrigere Preis gilt für **alle** Stücke, auch für die bisherigen Kunden.
- Man verliert auf der alten Menge Deckungsbeitrag, und die zusätzliche Menge muss das erst ausgleichen.
- Vergleichen muss man den gesamten Gewinn vorher und nachher, mit Kapazität und Nachfrage als Grenze.

**Merksatz:** Eine allgemeine Preissenkung trifft auch die bisherigen Stücke.

Quelle: 1.6.1

### Wann lohnt sich ein einmaliger Zusatzauftrag zu einem niedrigeren Preis?
- Wenn freie Kapazität da ist, die Fixkosten gleich bleiben und der Zusatzpreis über den variablen Stückkosten liegt.
- Dann steigt der Gewinn um $(e_Z - k_v) dot x_Z$.
- Die Fixkosten zieht man dabei nicht noch einmal ab, sie fallen ohnehin an.

**Merksatz:** Zusatzauftrag: zusätzliche Erlöse minus zusätzliche Kosten.

Quelle: 1.6.2
Abbildung: entscheidungsvergleich

### Welches Risiko hat ein Zusatzauftrag zu einem Sonderpreis?
- Bisherige Kunden könnten vom niedrigeren Preis erfahren und ihn ebenfalls verlangen.
- Dann bricht die Preisdifferenzierung zusammen und der Gewinn kann massiv sinken.
- Außerdem bindet der Auftrag Kapazität.

Quelle: 1.6.2
Abbildung: entscheidungsvergleich

### Muss ein Betrieb seine Fixkosten schon gedeckt haben, damit ein Zusatzauftrag sinnvoll ist?
- Nein.
- Jeder positive zusätzliche Deckungsbeitrag verbessert das Ergebnis, auch wenn er nur einen bestehenden Verlust verkleinert.

Quelle: 1.6.2
Abbildung: entscheidungsvergleich

### Was ist die kurzfristige und was die langfristige Preisuntergrenze?
- Kurzfristig (freie Kapazität, Fixkosten fallen sowieso an): Der Preis muss mindestens die variablen Stückkosten decken, $e >= k_v$.
- Erst darüber wächst der Gewinn.
- Langfristig muss der Preis auch die Fixkosten tragen: $e >= k$, also die vollen Stückkosten.

**Merksatz:** Kurzfristig variabel decken, langfristig alle Kosten.

Quelle: 1.6.3

### Wie bestimmt man variable Stückkosten und Fixkosten aus zwei Perioden?
- Bei gleicher Kostenstruktur kommt der Kostenunterschied nur von der Mengenänderung:
$ k_v = (Delta K)/(Delta x), quad K_f = K_1 - k_v x_1 $
- **Gegenprobe:** Mit der zweiten Periode muss dasselbe $K_f$ herauskommen.

Bild: Stromrechnung bei 300 und 400 kWh: Die Differenz zeigt den Preis pro kWh, der Rest ist die Grundgebühr.
Quelle: 1.7

### Was ändert sich bei doppelter Menge: K_f, k_f oder k?
- $K_f$ bleibt gleich.
- $k_f = K_f\/x$ halbiert sich.
- Die gesamten Stückkosten $k$ sinken auch, aber nicht auf die Hälfte, weil $k_v$ gleich bleibt.

Quelle: 1.3
Abbildung: stueckkosten

### Wie gehe ich an jede KLR-Textaufgabe heran?
- **Basis:** Netto?
- Gleiche Periode?
- **Modell:** Was ist fix, was variabel?
- Kommen neue Kosten dazu?
- **Ansatz:** Kosten, Erlöse und DB trennen, nach der gesuchten Größe umstellen.
- **Machbarkeit:** Passt die Menge in Kapazität und Nachfrage?
- **Prüfung:** Einheiten, Vorzeichen, Rundung.
- **Entscheidung:** begründetes Ja oder Nein mit Bedingungen.

Quelle: 1.8.2

### Warum soll man beim Ergebnis ein Vorzeichen schreiben?
- Damit sofort klar ist, ob es ein Gewinn oder Verlust ist: $G = +4 thin 000 "€"$ oder $G = -3 thin 000 "€"$.

Quelle: 1.8.2

### Zeichne die Begriffslandkarte zu Kapitel 1 aus dem Kopf: Welche Begriffe gehören dazu und wie hängen sie zusammen?
- **Bezugsgröße:** Periode, Nettopreis, Stück oder Gesamtbetrag klären.
- **Kosten:** fixe Kosten $K_f$ und variable Stückkosten $k_v$ trennen.
- Daraus folgen Kostenfunktion $K(x)$ und Stückkosten $k(x)$.
- **Deckungsbeitrag:** $d = p - k_v$ je Stück; $D = d dot x$ gesamt.
- Erst Fixkosten decken, der Rest ist Gewinn.
- **Gewinnschwelle:** $x_"BEP" = K_f / d$; mit Kapazität und Nachfrage abgleichen.
- **Entscheidungen:** bei Preissenkung oder Zusatzauftrag die tatsächlichen Änderungen vergleichen.

Bild: Wie eine Treppe: Bezugsgröße → Kosten → Deckungsbeitrag → Gewinnschwelle → Entscheidung. Keine Stufe lässt sich überspringen.
Quelle: 1.1

## Kapitel 2 · Statische Investitionsrechnung

### Warum wird der Kaufbetrag einer Maschine nicht als voller jährlicher Kostenbetrag angesetzt?
- Die Anschaffung betrifft mehrere Nutzungsjahre.
- Die lineare Abschreibung verteilt den Wertverbrauch auf diese Jahre.
- Zusätzlich bewertet der kalkulatorische Zins die durchschnittliche Kapitalbindung.
- So werden daraus vergleichbare Jahreskosten.

Quelle: 2.1
Abbildung: map-investitionskosten

### Warum rechnet man bei linearem Kapitalabbau mit der durchschnittlichen Kapitalbindung?
- Am Anfang ist mehr Kapital gebunden als am Ende.
- Bei linearer Entwicklung ist der Mittelwert aus Anschaffungskosten und Restwert die passende durchschnittliche Bindung.
- Bei Restwert null ist das die Hälfte der Anschaffungskosten
- das ist nicht automatisch die Basis jeder anderen Investition.

**Merksatz:** Linearer Kapitalabbau: Anfang und Ende mitteln.

Quelle: 2.1
Abbildung: map-investitionskosten

### Was bedeuten Kapitaldienst und Betriebskosten in den vorliegenden Aufgaben?
- Kapitaldienst ist hier kalkulatorische Abschreibung plus kalkulatorische Zinsen.
- Betriebskosten bestehen aus sonstigen Fixkosten und variablen Kosten.
- Zusammen ergeben sie die Jahresgesamtkosten.
- Sind Abschreibung und Zinsen schon enthalten, werden sie nicht nochmals addiert.

**Merksatz:** Schon enthaltene Abschreibung und Zinsen nicht doppelt addieren.

Quelle: 2.1
Abbildung: map-investitionskosten

### Wann kann die Kostenvergleichsrechnung eine sinnvolle Investitionswahl begründen?
- Wenn die Leistung gleichwertig und die Mengenbasis passend ist.
- Bei gleicher Menge genügt der Vergleich der Gesamtkosten
- verschiedene Mengen erfordern eine bewusste Leistungsbasis.
- Unterschiedliche Qualitätspreise oder Erlöse müssen zusätzlich über den Gewinn betrachtet werden.

Quelle: 2.2
Abbildung: map-kvr

### Warum reichen niedrige Stückkosten bei unterschiedlichen Kapazitäten nicht als vollständiges Gewinnurteil?
- Stückkosten sagen nur, was eine Leistungseinheit kostet.
- Der Jahresgewinn hängt außerdem von der verkauften Menge und dem Nettoerlös ab.
- Eine hohe Kapazität bringt erst durch passenden Absatz zusätzlichen Erlös.

Quelle: 2.2
Abbildung: map-kvr

### Warum kann die Gewinnvergleichsrechnung die teurere Anlage bevorzugen?
- Ein höherer Verkaufspreis oder mehr absetzbare Stücke können die Mehrkosten übertreffen.
- Die GVR betrachtet Erlöse minus vollständige Jahreskosten.
- Beim Backofen überwiegt der Qualitätsmehrerlös von Back de luxe dessen Mehrkosten.

Quelle: 2.3
Abbildung: map-gvr

### Was bedeutet ein positiver Gewinn nach kalkulatorischen Zinsen im Investitionsmodell?
- Die Erlöse decken die Betriebskosten, die Abschreibung und die angesetzte kalkulatorische Verzinsung.
- Ein positiver Rest liegt somit über dieser Kostenbasis.
- Das gilt für die vorgegebenen Mengen, Preise und Jahresannahmen.

Quelle: 2.3
Abbildung: map-gvr

### Warum addiert man für die Investitionsrentabilität kalkulatorische Zinsen zum Gewinn zurück?
- Der verwendete GVR-Gewinn ist bereits um diese Zinsen gemindert.
- Für den Erfolg vor kalkulatorischen Zinsen werden sie zurückaddiert und dann durch die mittlere Kapitalbindung geteilt.
- Ist der Gewinn schon vor Zinsen gegeben, würde erneutes Addieren doppelt zählen.

**Merksatz:** Zinsen nur zurückaddieren, wenn sie vorher abgezogen wurden.

Quelle: 2.4
Abbildung: map-rvr

### Wozu braucht man beim Rentabilitätsvergleich eine Differenzinvestition?
- Bei der billigeren Anlage bleibt ein Teil des Budgets frei.
- Die Differenzinvestition macht dessen Alternativverwendung ausdrücklich.
- Erst dann vergleicht man dasselbe Gesamtbudget
- das Ergebnis hängt vom angenommenen Ertrag und von der Kapitalbindung dieser Zusatzanlage ab.

**Merksatz:** Gleicher Budgetvergleich braucht auch die freie Restanlage.

Quelle: 2.4
Abbildung: map-rvr

### Darf man einen gegebenen Jahresertrag halbieren, weil die mittlere Kapitalbindung halb so hoch ist wie der Kaufbetrag?
- Nein.
- Durchschnittliche Kapitalbindung und Jahresertrag sind verschiedene Größen.
- Der Nenner wird aus dem Kapitalverlauf bestimmt
- ein ausdrücklich gegebener Jahresertrag bleibt im Zähler unverändert.
- Genau hier weicht die Backofen-Mitschrift vom Aufgabentext ab.

**Merksatz:** Ein halbierter Kapitalnenner halbiert nicht den Jahresertrag.

Quelle: 2.4
Abbildung: map-rvr

### Was unterscheidet Eigenkapital-, Gesamtkapital- und Umsatzrendite?
- Die Eigenkapitalrendite bezieht den Gewinn für die Eigentümer auf das mittlere Eigenkapital.
- Die Gesamtkapitalrendite betrachtet den Erfolg vor Fremdkapitalzinsen je mittlerem Gesamtkapital.
- Die Umsatzrendite setzt den klar abgegrenzten Gewinn ins Verhältnis zum Umsatz derselben Periode.
- Verschiedene Nenner beantworten verschiedene Fragen.

Quelle: 2.4.1

### Warum ist eine Umsatzrendite kein Cashflow?
- Die Rendite ist ein Verhältnis von Gewinn zu Umsatz in Prozent.
- Ein Cashflow ist dagegen ein Zahlungsüberschuss in Euro je Periode.
- Gewinn enthält beispielsweise Abschreibung und möglicherweise kalkulatorische Positionen
- deshalb ist er nicht automatisch ein Zahlungsüberschuss.

**Merksatz:** Rendite ist ein Verhältnis, Cashflow ein Zahlungsbetrag.

Quelle: 2.4.1

### Warum wird die Abschreibung bei der Amortisationsrechnung zum Gewinn addiert?
- Sie hat den Jahresgewinn vermindert, ist im jeweiligen Jahr aber keine Auszahlung.
- Die Mitschrift B31 verwendet deshalb den vereinfachten Rückfluss Gewinn plus Abschreibung.
- Weil der Gewinn dabei nach kalkulatorischen Zinsen abgegrenzt ist, muss diese Konvention ausdrücklich benannt werden.

Quelle: 2.5
Abbildung: amortisationsverlauf

### Warum kann ein höherer Jahresgewinn mit einer längeren Amortisationszeit zusammenfallen?
- Auch der zurückzugewinnende Kaufbetrag kann höher sein.
- Steigt dieser stärker als der jährliche Rückfluss, dauert die Rückgewinnung länger.
- Ein Verfahren für Rückgewinnungszeit und ein Verfahren für Jahresgewinn beantworten verschiedene Fragen.

**Merksatz:** Mehr Gewinn kann trotzdem längere Rückgewinnung bedeuten.

Quelle: 2.5
Abbildung: amortisationsverlauf

### Was erfasst eine kurze Amortisationszeit nicht?
- Sie sagt nicht, wie viel Erfolg nach dem Rückgewinnungszeitpunkt noch entsteht.
- Auch die genaue zeitliche Lage einzelner Zahlungen geht in die statische Durchschnittsmethode nicht ein.
- Deshalb ergänzt sie ein Gewinn- oder Rentabilitätsurteil.

Quelle: 2.5
Abbildung: amortisationsverlauf

### Was unterscheidet die kritische Kostenmenge von der Gewinnschwelle?
- An der kritischen Kostenmenge kosten zwei Alternativen gleich viel.
- An der Gewinnschwelle deckt der Erlös die Kosten einer Alternative und deren Gewinn ist null.
- Am Kosten-Schnittpunkt können beide Anlagen bereits Gewinn oder auch noch Verlust erzielen.

**Merksatz:** Kritische Menge vergleicht Anlagen; Gewinnschwelle vergleicht Erlös und Kosten.

Quelle: 2.6
Abbildung: kritische-auslastung

### Warum müssen variable Jahreskosten vor dem Aufstellen einer Kostenfunktion in Stückkosten umgerechnet werden?
- Die Steigung multipliziert sich mit einer Stückzahl und muss deshalb Euro je Stück sein.
- Ein Jahresgesamtbetrag enthält die betrachtete Menge schon.
- Erst das Teilen durch diese Menge liefert den variablen Stückbetrag.

**Merksatz:** Die Steigung braucht Euro je Stück, keinen Jahresgesamtbetrag.

Quelle: 2.6
Abbildung: kritische-auslastung

### Wann haben Kostenvergleich und Gewinnvergleich dieselbe kritische Menge?
- Wenn beide Alternativen bei derselben Menge denselben Stückerlös erzielen.
- Dann fällt der gemeinsame Erlös beim Gleichsetzen der Gewinne heraus.
- Bei verschiedenen Preisen muss man die Gewinnfunktionen mit ihren jeweils eigenen Erlösen gleichsetzen.

Quelle: 2.6
Abbildung: map-kritisch

### Zeichne die Begriffslandkarte zu Kapitel 2 aus dem Kopf: Welche Begriffe gehören dazu und wie hängen sie zusammen?
- **Anschaffung, Restwert, Nutzungsdauer → Abschreibung und mittlere Kapitalbindung.**
- **Zins und Betriebskosten → vollständige Jahreskosten.**
- **KVR:** Kosten vergleichen; **GVR:** Erlös und Menge ergänzen → Gewinn.
- **RVR:** passenden Erfolg auf Kapital beziehen; gegebenenfalls Differenzinvestition einbeziehen.
- **AVR:** Zeit bis zur Rückgewinnung prüfen.
- **Kritische Menge:** zeigt, wann bei anderer Auslastung die vorteilhafte Alternative wechselt.

Quelle: 2.1
Abbildung: map-investitionskosten

