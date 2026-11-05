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

## Kapitel 1 · KLR und Deckungsbeitragsrechnung

### In der Kostenrechnung stehen Großbuchstaben für Beträge der ___ Menge, Kleinbuchstaben für Beträge je ___.
Antwort: gesamten/ganzen/gesamte/ganze | Stück/Stueck/Einheit
Tipp: $K$ und $k$ unterscheiden sich nur in der Bezugsgröße.
Erklärung: Groß = gesamt, klein = je Stück. $K(x)$ sind die Gesamtkosten der Periode in €, $k(x)$ die Kosten je Stück in €/Stück.
Quelle: 1.1

### Eine Maschine schafft 7.000 Stück pro Stunde und produziert gerade 4.900 Stück pro Stunde. Wie hoch ist der Beschäftigungsgrad?
- [ ] 30 %
  > 30 % ist die freie, also nicht genutzte Kapazität.
- [x] 70 %
  > $"BG" = 4900 \/ 7000 dot 100 % = 70 %$.
- [ ] 143 %
  > Zähler und Nenner sind vertauscht. Ein Beschäftigungsgrad über 100 % ist hier nicht möglich.
- [ ] Ohne Monatsangabe nicht berechenbar
  > Beide Werte beziehen sich auf dieselbe Periode (Stunde). Mehr braucht es nicht.
Quelle: 1.1

### Ein Regal kostet brutto 214,20 € bei 19 % Umsatzsteuer. Mit welchem Preis rechnest Du in der Erlösfunktion?
- [ ] 214,20 €
  > In der KLR rechnet man immer mit Nettopreisen. Die Umsatzsteuer gehört dem Finanzamt.
- [ ] 173,50 €
  > Hier wurden 19 % vom Bruttopreis abgezogen. Die 19 % beziehen sich aber auf den Nettopreis.
- [x] 180 €
  > $e_"netto" = "214,20" \/ "1,19" = 180$ €.
- [ ] 254,90 €
  > Hier wurde die Steuer noch einmal aufgeschlagen statt herausgerechnet.
Tipp: Brutto = netto mal 1,19.
Quelle: 1.1

### Welche Kostenarten sind in Ü 1 (Packungen) variable Kosten?
- [x] Akkordlöhne von 22 € je Packung
  > Akkordlohn wird je erstellter Packung gezahlt und wächst mit der Menge.
- [ ] Gehälter von 9.000 € im Monat
  > Ein Monatsgehalt fällt unabhängig von der Stückzahl an, ist also fix.
- [x] Roh-, Hilfs- und Betriebsstoffe von 6 € je Packung
  > Jede zusätzliche Packung braucht Material. Das ist der klassische variable Anteil.
- [ ] Abschreibungen von 6.000 € im Monat
  > In dieser Aufgabe sind die Abschreibungen zeitabhängig angesetzt, also fix.
- [ ] Fremdkapitalzinsen von 3.000 € im Monat
  > Zinsen hängen nicht von der Packungszahl ab, sie sind hier fix.
Tipp: Frag bei jeder Position: Ändert sich der Betrag, wenn ich eine Packung mehr herstelle?
Quelle: 1.2

### Ab 9.000 Stück braucht ein Betrieb eine zweite Maschine, deren Miete monatlich fest anfällt. Wie heißen solche Kosten?
- [ ] Variable Kosten
  > Innerhalb eines Bereichs ändern sie sich nicht mit jedem Stück. Sie springen nur an einer Grenze.
- [x] Sprungfixe Kosten
  > Sie bleiben in einem Bereich konstant und springen ab einer Grenze auf einen neuen Fixkostenblock.
- [ ] Mischkosten
  > Mischkosten haben gleichzeitig einen fixen und einen variablen Anteil, wie eine Stromrechnung mit Grundpreis.
- [ ] Stückkosten
  > Stückkosten sind eine Bezugsgröße (€ je Stück), keine Kostenart.
Quelle: 1.2

### Ein Betrieb hat Fixkosten von 20.000 € im Monat und variable Kosten von 30 € je Packung. Wie hoch sind die Stückkosten bei 400 Packungen?
- [ ] 30 €
  > Das sind nur die variablen Stückkosten. Der Fixkostenanteil je Packung fehlt.
- [ ] 50 €
  > 50 € wären es bei 1.000 Packungen. Bei 400 Packungen verteilen sich die Fixkosten auf weniger Stücke.
- [x] 80 €
  > $k = 20000 \/ 400 + 30 = 50 + 30 = 80$ €/Packung.
- [ ] 32.000 €
  > Das sind die Gesamtkosten $K(400)$. Gefragt sind die Kosten je Stück.
Tipp: $k(x) = K_f\/x + k_v$
Quelle: 1.3

### Was beschreibt die Fixkostendegression?
- [ ] Die Fixkosten sinken, wenn mehr produziert wird.
  > Die Fixkosten insgesamt bleiben gleich. Nur der Anteil je Stück sinkt.
- [x] Die fixen Kosten je Stück sinken, weil sich derselbe Fixkostenblock auf mehr Stücke verteilt.
  > Bei 200 Packungen sind es 100 € je Packung, bei 1.000 nur 20 €. Wie bei einer WG, die sich die Miete teilt.
- [ ] Die variablen Stückkosten sinken mit wachsender Menge.
  > Im linearen Modell bleibt $k_v$ konstant. Das Essen wird durch das Mietteilen nicht billiger.
- [ ] Die Stückkosten sinken bei großer Menge bis auf null.
  > Die Stückkosten nähern sich höchstens $k_v$ an und liegen bei endlicher Kapazität darüber.
Quelle: 1.3

### Warum sind Stückkosten bei $x = 0$ nicht definiert, obwohl die Gesamtkosten existieren?
- [ ] Weil bei null Stück auch keine Kosten anfallen.
  > Die Fixkosten fallen trotzdem an: $K(0) = K_f$.
- [x] Weil man durch die Menge teilen müsste und durch null nicht teilen kann.
  > $k(x) = K(x)\/x$ verlangt $x > 0$. Die Gesamtkosten $K(0) = K_f$ gibt es trotzdem.
- [ ] Weil die variablen Kosten bei null Stück negativ werden.
  > Variable Kosten sind bei null Stück einfach null, nicht negativ.
- [ ] Weil die Fixkosten bei null Stück verschwinden.
  > Fixkosten fallen unabhängig von der Menge an, auch bei null.
Quelle: 1.3

### Eine Packung bringt netto 70 €, die variablen Kosten betragen 30 € je Packung. Wie hoch ist der Stückdeckungsbeitrag?
- [x] 40 €
  > $d b_"I" = e - k_v = 70 - 30 = 40$ €. Dieser Betrag trägt zur Deckung der Fixkosten bei.
- [ ] 100 €
  > Preis und Kosten wurden addiert statt subtrahiert.
- [ ] 70 €
  > Das ist der Preis. Der Deckungsbeitrag zieht die variablen Kosten ab.
- [ ] 20 €
  > Hier wurden zusätzlich die Fixkosten je Stück abgezogen. Das wäre $d b_"II"$ bei 1.000 Stück, nicht der Stückdeckungsbeitrag.
Quelle: 1.4

### Welche Gleichungen beschreiben im einstufigen Schema den Gewinn richtig?
- [x] $G = E(x) - K(x)$
  > Erlöse minus Gesamtkosten, die Grunddefinition.
- [x] $G = d b_"I" dot x - K_f$
  > Der Schnellweg: gesamter Deckungsbeitrag minus Fixkosten, Fixkosten genau einmal abgezogen.
- [ ] $G = d b_"I" - K_f$
  > Hier steht der Stückdeckungsbeitrag ohne Menge. Euro je Stück und Euro je Periode passen nicht zusammen.
- [ ] $G = (e - k_v) x - K_f x$
  > Die Fixkosten fallen einmal pro Periode an und werden nicht mit der Menge multipliziert.
Quelle: 1.4

### Fixkosten 20.000 €, Preis 70 €, variable Kosten 30 € je Packung. Wo liegt die Gewinnschwelle?
- [ ] 286 Packungen
  > Hier wurde durch den Preis geteilt statt durch den Deckungsbeitrag.
- [x] 500 Packungen
  > $x_"BEP" = 20000 \/ (70 - 30) = 500$ Packungen. Danach ist der „Fixkosten-Eimer“ voll.
- [ ] 667 Packungen
  > Hier wurde durch die variablen Kosten geteilt. Entscheidend ist aber der Beitrag je Packung.
- [ ] 200 Packungen
  > Hier wurde durch die Summe aus Preis und variablen Kosten geteilt.
Tipp: Wie viele Beiträge zu je $e - k_v$ brauchst Du, um $K_f$ zu decken?
Quelle: 1.5

### Die exakte Gewinnschwelle liegt bei 914,29 Regalen. Welche kleinste ganze Stückzahl ist ohne Verlust?
- [ ] 914
  > 914 Regale ergeben noch −20 €. Abrunden reicht hier nicht.
- [x] 915
  > 915 Regale ergeben +50 €. Bei ganzen Stückzahlen rundet man auf, wenn die Schwelle nicht ganzzahlig ist.
- [ ] 900
  > Das wäre eine grobe Rundung mit klarem Verlust.
- [ ] 914,29 Regale lassen sich direkt verkaufen.
  > Bruchteile von Regalen werden nicht verkauft. Die exakte Schwelle ist ein theoretischer Wert.
Quelle: 1.5

### Wie verändert sich die Break-Even-Menge, wenn die variablen Stückkosten steigen (sonst alles gleich)?
- [ ] Sie sinkt.
  > Die Richtung ist vertauscht. Höhere variable Kosten machen jedes Stück weniger wertvoll.
- [x] Sie steigt.
  > Der Stückdeckungsbeitrag $e - k_v$ wird kleiner, also braucht man mehr Stücke, um $K_f$ zu decken.
- [ ] Sie bleibt gleich, weil nur die Fixkosten den BEP bestimmen.
  > Der BEP hängt von $K_f$ und vom Stückdeckungsbeitrag ab.
- [ ] Sie wird negativ.
  > Negativ wird nichts. Fällt der Deckungsbeitrag auf null oder darunter, gibt es keine erreichbare Schwelle mehr.
Quelle: 1.5.1

### Wo liegt im linearen Modell mit positivem Stückdeckungsbeitrag das Gewinnmaximum, wenn die Nachfrage unbegrenzt ist?
- [ ] An der Gewinnschwelle
  > Dort ist der Gewinn gerade null. Jedes weitere Stück bringt zusätzlichen Gewinn.
- [x] An der Kapazitätsgrenze
  > Jedes Stück erhöht den Gewinn um $d b_"I"$. Also lohnt es sich, bis $x_"max"$ zu produzieren.
- [ ] Dort, wo die Stückkosten am niedrigsten sind, egal wie hoch die Kapazität ist
  > Die Stückkosten sind tatsächlich an der Kapazität am niedrigsten, aber das Argument ist der Deckungsbeitrag, nicht die Stückkosten.
- [ ] Bei 50 % Auslastung
  > Für diese Zahl gibt es im linearen Modell keinen Grund.
Quelle: 1.5.1

### Bei einer Auslastung von 85 % werden 1.020 Regale verkauft, die Gewinnschwelle liegt bei 915 Regalen. Was sagt das über das Risiko?
Antwort: Der Sicherheitsabstand ist klein: Nur 105 Regale liegen über der Gewinnschwelle, obwohl der Betrieb schon zu 85 % ausgelastet ist. Ein kleiner Absatzrückgang von gut 10 % führt bereits in den Verlust. Ein hoher Beschäftigungsgrad an der Gewinnschwelle (hier gut 76 %) lässt wenig Puffer. Man sollte Fixkosten, variable Kosten und Preis prüfen.
Tipp: Vergleiche die verkaufte Menge mit der Schwelle und überlege, was bei einem Absatzrückgang passiert.
Quelle: 1.5.1

### Ein Betrieb mit freier Kapazität erhält einen einmaligen Zusatzauftrag über 200 Packungen zu 35 €. Die variablen Kosten betragen 30 € je Packung, die Fixkosten ändern sich nicht. Wie verändert sich der Gewinn?
- [ ] Er sinkt, weil 35 € unter den Stückkosten liegen.
  > Die Fixkosten sind ohnehin da. Für den Zusatzauftrag zählt nur, was er zusätzlich bringt und kostet.
- [x] Er steigt um 1.000 €.
  > $Delta G = (35 - 30) dot 200 = 1000$ €. Die Fixkosten werden nicht noch einmal abgezogen.
- [ ] Er steigt um 7.000 €.
  > Das ist der Erlös des Auftrags. Die variablen Kosten fehlen.
- [ ] Er bleibt gleich, weil nur die Fixkosten zählen.
  > Jeder positive Deckungsbeitrag erhöht den Gewinn oder verkleinert einen Verlust.
Tipp: $Delta G = (e_"Z" - k_v) x_"Z"$
Quelle: 1.6.2

### Ein Betrieb senkt den Preis für alle Kunden, um mehr zu verkaufen. Welcher Fehler passiert hier oft?
- [ ] Man vergisst, die Fixkosten zweimal abzuziehen.
  > Die Fixkosten werden genau einmal abgezogen, nie zweimal.
- [x] Man rechnet nur die zusätzliche Menge zum neuen Preis und vergisst, dass auch alle bisherigen Kunden weniger zahlen.
  > Bei einer allgemeinen Preissenkung zahlt die ganze Menge den neuen Preis. Man verliert Deckungsbeitrag auf der alten Menge.
- [ ] Man rechnet mit der Kapazität statt mit der Nachfrage.
  > Das ist ein eigener Prüfschritt. Der typische Fehler hier betrifft den Preis der alten Menge.
- [ ] Man setzt den Bruttopreis ein.
  > Das wäre generell falsch, ist aber nicht der spezifische Fehler der Preissenkung.
Quelle: 1.6.1

### Welches Risiko birgt ein Zusatzauftrag zu einem niedrigen Preis, selbst wenn er rechnerisch Gewinn bringt?
- [x] Bisherige Kunden könnten den niedrigeren Preis ebenfalls fordern.
  > Lässt sich die Preisdifferenzierung nicht halten, kann der Gewinn kippen: Bei 35 € für alle 1.000 Packungen wären es −15.000 €.
- [x] Die Kapazität ist durch den Auftrag gebunden und fehlt für besser bezahlte Aufträge.
  > Freie Kapazität ist eine Voraussetzung. Ein späterer, besserer Auftrag könnte verdrängt werden.
- [ ] Die Fixkosten steigen automatisch durch jeden Zusatzauftrag.
  > Im Modell bleiben die Fixkosten gleich. Steigen sie doch, gehört das in die Rechnung.
- [ ] Der Zusatzauftrag senkt immer den Stückdeckungsbeitrag der Stammkunden.
  > Solange die Stammkunden den alten Preis zahlen, ändert sich ihr Deckungsbeitrag nicht.
Quelle: 1.6.2

### Kurzfristig (freie Kapazität, Fixkosten unverändert) liegt die Preisuntergrenze bei den ___ Stückkosten, langfristig bei den ___ Stückkosten.
Antwort: variablen | gesamten/vollen/totalen
Tipp: Was muss ein Zusatzauftrag mindestens decken, und was muss die ganze Produktion auf Dauer decken?
Erklärung: Kurzfristig reicht $e_"Z" >= k_v$, weil die Fixkosten ohnehin anfallen. Langfristig muss der Preis auch die Fixkosten tragen, also $e >= k(x)$.
Quelle: 1.6.3

### Im Oktober kosten 20.000 Stück 700.000 €, im November 24.000 Stück 800.000 €. Wie hoch sind die variablen Stückkosten?
- [ ] 35 €
  > Das sind die gesamten Stückkosten im Oktober (700.000 durch 20.000). Darin stecken noch Fixkosten.
- [x] 25 €
  > $k_v = (800000 - 700000) \/ (24000 - 20000) = 25$ €/Stück.
- [ ] 33,33 €
  > Das sind die gesamten Stückkosten im November. Die Fixkosten sind nicht herausgerechnet.
- [ ] 100.000 €
  > Das ist nur die Kostendifferenz. Sie muss noch durch die Mengendifferenz geteilt werden.
Tipp: Die Kostendifferenz kommt nur aus der Mengendifferenz.
Quelle: 1.7

### Mit $k_v = 25$ € und den Oktoberwerten (20.000 Stück, 700.000 €): Wie hoch sind die Fixkosten?
- [x] 200.000 €
  > $K_f = 700000 - 25 dot 20000 = 200000$ €. Die Probe mit November ergibt denselben Wert.
- [ ] 500.000 €
  > Das sind die variablen Kosten im Oktober. Sie müssen von den Gesamtkosten abgezogen werden.
- [ ] 100.000 €
  > Das ist die Kostendifferenz zwischen den Monaten.
- [ ] 0 €
  > Dann müssten die Stückkosten in beiden Monaten gleich sein. Sie sind es nicht.
Quelle: 1.7

### Warum muss beim Zwei-Perioden-Verfahren aus beiden Perioden dasselbe $K_f$ herauskommen?
Antwort: Weil man annimmt, dass beide Beobachtungen auf derselben linearen Kostenlinie liegen, also gleiche Fixkosten und gleiche variable Stückkosten haben. Die Steigung wird gerade aus den beiden Punkten bestimmt, deshalb liefern beide denselben Achsenabschnitt. Kommt etwas anderes heraus, hat man sich verrechnet. Zwei Punkte beweisen aber nicht, dass das Modell in jedem anderen Monat gilt.
Quelle: 1.7

### Fixkosten 20.000 €, Stückdeckungsbeitrag 40 €. Wie viele Packungen braucht man für einen Zielgewinn von 8.000 €?
- [ ] 200 Packungen
  > Das deckt nur den Zielgewinn, nicht zusätzlich die Fixkosten.
- [ ] 500 Packungen
  > Das ist die Gewinnschwelle, also Zielgewinn null.
- [x] 700 Packungen
  > $x_"Ziel" = (20000 + 8000) \/ 40 = 700$ Packungen.
- [ ] 300 Packungen
  > Hier wurde der Zielgewinn von den Fixkosten abgezogen statt addiert.
Tipp: $x_"Ziel" = (K_f + G_"Ziel") \/ d b_"I"$, dann Kapazität prüfen.
Quelle: 1.8

### In Ü 2 liegt die Gewinnschwelle bei 5.000 Stück, die Kapazität aber nur bei 4.500 Stück. Welche Stellschrauben gibt es?
- [x] Den Preis erhöhen
  > Ein höherer Preis vergrößert den Stückdeckungsbeitrag und senkt die Schwelle.
- [x] Variable Stückkosten senken
  > Auch das vergrößert den Stückdeckungsbeitrag.
- [x] Fixkosten senken
  > Weniger Fixkosten heißt, man braucht weniger Deckungsbeiträge.
- [ ] Mehr als 4.500 Stück produzieren, ohne etwas zu ändern
  > Die Kapazität ist die Grenze. Eine Erweiterung kann neue Fixkosten verursachen, dann müssen beide Änderungen zusammen geprüft werden.
Quelle: 1.8.1

## Kapitel 2 · Statische Investitionsrechnung

### Eine Maschine kostet 140.000 €, hält sieben Jahre und hat Restwert null. Wie hoch ist die lineare Abschreibung pro Jahr?
- [x] 20.000 €
  > Anschaffung minus Restwert wird auf sieben Jahre verteilt: $140000/7=20000$ €/Jahr.
- [ ] 140.000 €
  > Das ist der einmalige Kaufbetrag, kein jährlicher Wertverbrauch.
- [ ] 70.000 €
  > Das ist die mittlere Kapitalbindung in diesem Modell, keine Abschreibung.
Quelle: 2.1

### Was gehört in den vorliegenden Aufgaben zum Kapitaldienst?
- [x] Kalkulatorische Abschreibung und kalkulatorische Zinsen
  > Diese Summe ist die verwendete Begriffsdefinition.
- [ ] Nur die variablen Kosten
  > Diese gehören zu den Betriebskosten.
- [ ] Kaufbetrag plus alle Betriebskosten
  > Kaufbetrag und Jahreskosten haben unterschiedliche Zeitbezüge.
Quelle: 2.1

### Betriebskosten sind ausdrücklich ohne Abschreibung und Zinsen angegeben. Was fehlt bis zu den Gesamtkosten?
Antwort: Der Kapitaldienst aus kalkulatorischer Abschreibung und kalkulatorischen Zinsen muss einmal addiert werden. Ist er bereits als Betrag vorgegeben, werden seine Bestandteile nicht nochmals zusätzlich aufgeschlagen.
Quelle: 2.1

### Bei gleicher Jahresmenge und gleichwertiger Leistung sind die Gesamtkosten von Anlage A niedriger. Was folgt in der KVR?
- [x] A ist nach dem Kostenkriterium vorteilhafter.
  > Bei gleicher Menge haben Gesamt- und Stückkosten dieselbe Rangfolge.
- [ ] A hat zwingend den höheren Gewinn, auch bei anderen Verkaufspreisen.
  > Unterschiedliche Erlöse können die Gewinnrangfolge umkehren.
- [ ] Man muss die Anschaffungskosten nochmals als Jahreskosten addieren.
  > Abschreibung und Zinsen sind in vollständigen Jahreskosten schon enthalten.
Quelle: 2.2

### Warum ist der Vergleich 100.000 Brötchen aus Normalo gegen 150.000 aus Back de luxe kein bloßer Gesamtkostenvergleich gleicher Leistung?
Antwort: Die Jahresmengen sind verschieden. Die Stückkosten zeigen die Kosten je Einheit; zusätzlich müssen Kapazität und Absatz passen. Die GVR braucht außerdem die zugehörigen Erlöse. Normalo kann die 150.000 Stück allein nicht herstellen.
Quelle: 2.2

### Ein einzelnes Angebot hat bekannte Jahreskosten, aber keinen Erlös und kein Vergleichsangebot. Welche Aussage ist begründet?
- [x] Die Kosten sind bestimmbar, die Vorteilhaftigkeit allein daraus nicht.
  > Es fehlt eine Vergleichs- oder Erfolgsbasis.
- [ ] Jede Anlage mit positiven Kosten ist unvorteilhaft.
  > Kosten allein sagen nichts über die Gegenleistung oder Erlöse.
- [ ] Man nimmt automatisch das Angebot an.
  > Eine Kostenberechnung ersetzt keine begründete Investitionsentscheidung.
Quelle: 2.2

### Bei 100.000 Stück erlöst Back de luxe 5.000 € mehr und kostet 2.110 € mehr pro Jahr. Wie ändert sich der Gewinn?
- [x] Er steigt um 2.890 €/Jahr.
  > Mehrerlös minus Mehrkosten: $5000-2110=2890$.
- [ ] Er sinkt um 2.110 €/Jahr.
  > Der zusätzliche Erlös wurde vergessen.
- [ ] Er steigt um 5.000 €/Jahr.
  > Die höheren Kosten wurden vergessen.
Quelle: 2.3

### Welche Größen gehören in einen Jahresgewinnvergleich mit unterschiedlichen Absatzmengen?
- [x] Jeweils absetzbare Menge und Nettoerlös je Stück
  > Ihr Produkt liefert den jeweiligen Jahreserlös.
- [x] Vollständige Jahreskosten einschließlich kalkulatorischer Kapitalpositionen
  > Sie werden vom zugehörigen Jahreserlös abgezogen.
- [ ] Nur der Gewinn je Stück ohne Menge
  > Das würde einen anderen Maßstab als den gesamten Jahresgewinn vergleichen.
Quelle: 2.3

### Warum kann die GVR bei Qualitätsunterschieden aussagekräftiger sein als eine reine KVR?
Antwort: Qualität kann unterschiedliche erzielbare Preise verursachen. Die GVR berücksichtigt die daraus entstehenden Erlöse zusammen mit den Kosten. Die KVR kann diesen Mehrerlös allein nicht bewerten.
Quelle: 2.3

### Ein GVR-Gewinn ist bereits nach kalkulatorischen Zinsen angegeben. Welcher Zähler passt zur Verzinsung des gesamten durchschnittlich gebundenen Kapitals?
- [x] Gewinn plus kalkulatorische Zinsen
  > So erhält man den Erfolg vor diesen Zinsen.
- [ ] Gewinn minus kalkulatorische Zinsen
  > Dann würden dieselben kalkulatorischen Zinsen zweimal abgezogen.
- [ ] Nur der Jahreserlös
  > Kosten und Wertverbrauch würden ignoriert.
Quelle: 2.4

### Was muss bei einer billigeren Anlage geschehen, bevor Du dasselbe Gesamtbudget rentabilitätsmäßig vergleichst?
Antwort: Die Alternativverwendung des freien Kapitals muss mit Ertrag und Kapitalbindung festgelegt werden. Diese Differenzinvestition wird zur billigeren Anlage hinzugefügt. Ein isolierter Anlagenprozentsatz bildet die ganze Budgetverwendung noch nicht ab.
Quelle: 2.4

### Der Backofen-Aufgabentext nennt 2.000 € Jahresertrag der Differenzanlage. Darf dieser Ertrag wegen halber mittlerer Kapitalbindung zu 1.000 € werden?
- [x] Nein, der gegebene Jahresertrag bleibt unverändert.
  > Kapitalmittelwert und Jahresertrag sind verschiedene Größen. Die Halbierung des Nenners halbiert nicht den gegebenen Zähler.
- [ ] Ja, jeder Ertrag muss immer halbiert werden.
  > Dafür liefert die Durchschnittsbindung keine Begründung.
- [ ] Ja, weil die Rentabilität sonst immer über 100 % läge.
  > Die Höhe des Prozentsatzes ist kein Grund, einen gegebenen Ertrag zu ändern.
Quelle: 2.4

### Ein Betrieb hat 300.000 € Jahresgewinn und 2.000.000 € Jahresumsatz. Wie hoch ist die Umsatzrendite mit dieser Gewinnabgrenzung?
- [x] 15 %
  > $300000/2000000 dot 100 %=15 %$; beide Beträge beziehen sich auf dasselbe Jahr.
- [ ] 300.000 €
  > Das ist der Gewinnbetrag, keine Verhältniszahl.
- [ ] 666,67 %
  > Gewinn und Umsatz wurden vertauscht.
Quelle: 2.4.1

### Welche Aussage trennt Umsatzrendite und Cashflow richtig?
- [x] Die Rendite ist eine Verhältniszahl; der Cashflow ein Zahlungsüberschuss pro Periode.
  > Prozent und Euro je Periode sind unterschiedliche Größen, auch wenn beide zur Beurteilung beitragen können.
- [ ] Umsatzrendite ist nur ein anderes Wort für Cashflow.
  > Gewinn, Umsatz und Zahlungsüberschuss sind verschieden abgegrenzt.
- [ ] Ein Gewinn enthält grundsätzlich nur Zahlungen.
  > Beispielsweise Abschreibung ist ein Aufwand beziehungsweise kalkulatorischer Wertverbrauch ohne laufende Auszahlung.
Quelle: 2.4.1

### Welche Rückflussgröße verwendet die Backofen-Mitschrift B31 für die AVR?
- [x] GVR-Gewinn plus Abschreibung
  > Das ist die ausdrücklich übernommene vereinfachte Konvention nach kalkulatorischen Zinsen.
- [ ] Nur der Gewinn
  > Die nicht zahlungswirksame Abschreibung wäre nicht zurückaddiert.
- [ ] Erlös plus Anschaffungskosten
  > Weder Kostenabzug noch Zeitbezug stimmen damit.
Quelle: 2.5

### Warum darf man den Rückfluss Gewinn plus Abschreibung nicht ohne Prüfung als tatsächlichen Cashflow bezeichnen?
Antwort: Es kommt auf die Abgrenzung des Gewinns an. In B31 enthält er bereits kalkulatorische Zinsen als Abzug. Für einen Rückfluss vor diesen rein kalkulatorischen Zinsen wäre unter sonst passenden Zahlungsannahmen auch dieser Betrag zurückzuaddieren. Man muss die Konvention benennen und durchhalten.
Quelle: 2.5

### Normalo amortisiert sich nach B31 in etwa 1,94 Jahren, Back de luxe in 2,14 Jahren. Welche Aussagen stimmen?
- [x] Normalo ist nach dem Amortisationskriterium besser.
  > Der Kaufbetrag wird in kürzerer Zeit rechnerisch ausgeglichen.
- [x] Back de luxe kann trotzdem den höheren Jahresgewinn erzielen.
  > Kaufbetrag und Rückfluss wachsen unterschiedlich; die Kriterien beantworten verschiedene Fragen.
- [ ] Damit ist Normalo automatisch über die gesamte Nutzungsdauer gewinnreicher.
  > Die AVR erfasst den späteren Erfolg nicht.
Quelle: 2.5

### Zwei Kostenlinien schneiden sich bei exakt 10.967,7419 Stück/Jahr; Objekt 1 ist rechts davon günstiger. Welcher Bereich stimmt bei ganzen Stückzahlen?
- [x] Objekt 2 bis 10.967, Objekt 1 ab 10.968
  > 10.968 liegt schon rechts der exakten Grenze.
- [ ] Bei 10.968 sind beide exakt gleich teuer.
  > Die Rundung verschiebt den Punkt; dort hat Objekt 1 bereits 0,40 € Kostenvorteil im KR-Beispiel.
- [ ] Objekt 1 erst ab 10.969
  > Damit würde die erste bereits günstigere ganze Menge übersprungen.
Quelle: 2.6

### An einer kritischen Kostenmenge sind beide Kosten gleich. Ist dort automatisch der Gewinn null?
Antwort: Nein. Die Kosten zweier Anlagen werden gleichgesetzt, nicht der Erlös mit den Kosten einer Anlage. Der gemeinsame Gewinn kann positiv, null oder negativ sein. Nur die Gewinnschwelle verlangt Erlös gleich Kosten.
Quelle: 2.6

### Bei 20.000 Stück entstehen 295.000 € variable Jahreskosten. Welche Steigung gehört in die lineare Kostenfunktion?
- [x] 14,75 €/Stück
  > Der Jahresgesamtbetrag wird durch die Jahresmenge geteilt.
- [ ] 295.000 €/Stück
  > Die Menge wäre doppelt berücksichtigt.
- [ ] 20.000 €/Stück
  > Das ist die Stückzahl, keine Kostengröße.
Quelle: 2.6
