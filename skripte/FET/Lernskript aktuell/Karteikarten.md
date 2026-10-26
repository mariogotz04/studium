# Karteikarten · FET

<!--
So ist diese Datei aufgebaut (die Webseite liest sie beim Hochladen automatisch ein):
- "## Kapitel …" beginnt ein Kapitel (Filter auf der Webseite).
- "### Frage" ist die Vorderseite einer Karte. Alles darunter bis zur nächsten ### ist die Rückseite.
- Auf der Rückseite gehen Absätze (Leerzeile), Listen (- …), **fett** und *kursiv*.
- Eine Zeile "Bild: …" erscheint als Merkbild (Analogie im Feynman-Stil) unten auf der Karte.
- "Quelle: 1.3" (Nummer des Abschnitts im Lernskript, bei TM2 z. B. "TM2 1.6") zeigt auf der Karte die Seite im aktuellen Lernskript an. Die Seite wird beim Hochladen automatisch bestimmt.
- "Abbildung: name" zeigt ein Bild aus Typst-Dateien/abbildungen/ (Dateiname ohne Endung, wie bei #bild im Lernskript). Mehrere mit Komma trennen.
- Nur Verständnisfragen, keine Rechenaufgaben. Antworten kurz, einfach, in eigenen Worten.
- Den Fragetext nur ändern, wenn nötig: Der Lernfortschritt hängt am Wortlaut der Frage.
-->

## Kapitel 1 · Grundbegriffe

### Was beschreibt die Thermodynamik, und wie geht sie dabei vor?
Sie verfolgt, wie sich Zustand, Masse und Energie einer Anlage ändern, zum Beispiel bei Pumpe, Wasserkocher oder Turbine. Statt einzelne Moleküle zu verfolgen, beschreibt sie das System von außen mit messbaren Größen.

Der Weg ist immer: Systemgrenze festlegen, Masse und Energie bilanzieren, dann mit einem Stoffmodell auf Druck, Temperatur oder Volumen schließen.
Quelle: 1.0

### Was ist ein thermodynamisches System, und warum ist die Systemgrenze so wichtig?
Das System ist der Ausschnitt, den ich betrachte. Die Grenze trennt ihn von der Umgebung. In die Bilanz kommt nur, was diese Grenze überquert.

Dieselbe Energie kann je nach Grenze anders heißen: Nehme ich beim Boiler nur das Wasser, kommt Wärme vom Heizstab. Nehme ich Wasser und Heizstab, kommt elektrische Arbeit über das Kabel.

Bild: Eine Bilanz ist die Buchhaltung eines Ausschnitts. Erst muss klar sein, wessen Konto ich führe.
Quelle: 1.1
Abbildung: boundary

### Warum tauchen innere Energieströme zwischen zwei Teilsystemen in der Gesamtbilanz nicht auf?
Wenn ich die Grenze um beide Teilsysteme lege, verlassen diese Ströme die Grenze nie. Was das eine Teilsystem abgibt, nimmt das andere auf. In der Gesamtbilanz heben sie sich deshalb auf.
Quelle: 1.1
Abbildung: boundary

### Was sagt eine Bilanz aus, und was ist der Unterschied zwischen Rate und Bestand?
Bilanz: Änderung des Bestands = Zufluss − Abfluss. Die Rate (z. B. kg/s) sagt, wie schnell sich etwas ändert. Der Bestand (kg) sagt, wie viel gerade drin ist.

Aus der Rate allein kenne ich den Bestand nicht: Ich brauche zusätzlich den Anfangsbestand.

Bild: Badewanne. Gleich viel Zu- und Abfluss hält den Wasserstand konstant, obwohl ständig anderes Wasser hindurchfließt.
Quelle: 1.1.1
Abbildung: bath

### Was bedeutet „stationär“ für eine Bilanz, und was bedeutet es nicht?
Stationär heißt: Am festen Ort ändert sich nichts mit der Zeit. Die Speicherterme (z. B. dm/dt) sind null.

Die Ströme verschwinden dabei nicht. Ein Durchlauferhitzer ist stationär, obwohl ständig Wasser durchfließt und Energie zugeführt wird.
Quelle: 1.1.1
Abbildung: bath

### Auf welchen drei Wegen kann Energie über eine Systemgrenze kommen?
- **Arbeit:** durch Bewegung, z. B. Kolben, Welle oder elektrischer Strom.
- **Wärme:** wegen eines Temperaturunterschieds.
- **Mit Stoff:** strömende Masse bringt ihre Energie mit.

Das sind Arten der Übertragung, keine verschiedenen Energiearten im Stoff. Gespeichert wird z. B. innere Energie.
Quelle: 1.1.2
Abbildung: transfers

### Was ist die Enthalpie anschaulich, und warum nutzt man sie bei durchströmten Systemen?
h = u + pv. Ein Stoffstrom bringt seine innere Energie u mit. Zusätzlich muss er gegen den Druck in den Kontrollraum hineingeschoben werden, das ist die Verschiebearbeit pv.

Die Enthalpie packt beides zusammen. Deshalb darf man pv in der Strömungsbilanz nicht noch einmal extra als Arbeit addieren.

Bild: Wer in eine volle U-Bahn einsteigt, bringt nicht nur sich selbst mit, sondern muss auch Platz schieben. Die Enthalpie zählt beides.
Quelle: 1.1.2
Abbildung: transfers

### Was bedeuten offen, geschlossen, adiabat, starr und abgeschlossen?
- **Offen:** Masse darf über die Grenze.
- **Geschlossen:** keine Masse über die Grenze.
- **Adiabat:** keine Wärme über die Grenze, Arbeit bleibt möglich.
- **Starr:** Volumen bleibt gleich, also keine Volumenarbeit.
- **Abgeschlossen:** weder Masse noch Energie über die Grenze.

Jede Eigenschaft wird einzeln geprüft. Aus einem Wort folgen nicht automatisch die anderen.
Quelle: 1.1.3

### Kann ein geschlossenes, starres, adiabates Gefäß wärmer werden?
Ja. Geschlossen verbietet nur Stoffaustausch, adiabat nur Wärme, starr nur Volumenarbeit. Über einen Heizstab oder Rührer kann trotzdem elektrische oder Wellenarbeit zugeführt werden.
Quelle: 1.1.3

### Was ist der Unterschied zwischen Gleichgewicht und stationärem Zustand?
Gleichgewicht: Es gibt keinen antreibenden Unterschied mehr, z. B. keinen Temperaturunterschied. Es passiert von selbst nichts.

Stationär: Die Werte am festen Ort bleiben gleich, aber nur weil ständig etwas zu- und abfließt. Ein Durchlauferhitzer hat dauerhaft kalten Eintritt und warmen Austritt und ist trotzdem stationär, aber nicht im Gleichgewicht.
Quelle: 1.2

### Wie kann ein Teilchen in einer stationären Strömung beschleunigt werden?
Stationär heißt nur: Am festen Ort ändert sich nichts mit der Zeit. Ein Teilchen wandert aber von Ort zu Ort, z. B. in einer Düse von einem langsamen in einen schnellen Bereich. Es wird also beschleunigt, obwohl das Strömungsbild gleich bleibt.
Quelle: 1.2

### Was sagt der nullte Hauptsatz, und warum braucht man ihn zum Temperaturmessen?
Sind A und C gleich warm und B und C gleich warm, dann sind auch A und B gleich warm. Nur deshalb kann ein Thermometer C Temperaturen vergleichen, ohne dass A und B sich berühren.
Quelle: 1.3
Abbildung: expansion

### Was unterscheidet extensive, intensive und spezifische Größen?
Teilungstest: Ich teile einen homogenen Behälter gedanklich in zwei Hälften.
- **Extensiv** (m, V, U, H): halbiert sich, hängt an der Menge.
- **Intensiv** (p, T, ρ): bleibt gleich.
- **Spezifisch** (v = V/m, u, h): Größe pro kg. Bleibt auch gleich, weil Zähler und Nenner gleich schrumpfen.

Spezifische Größen trennen die Stoffeigenschaft von der Menge.
Quelle: 1.4
Abbildung: division

### Was sagt die Kontinuitätsgleichung, und warum wird Wasser in einer engen Düse schneller?
Stationär ohne weitere Zu- oder Abflüsse geht durch jeden Querschnitt dieselbe Masse pro Sekunde: ρ·A·c = konstant.

Bei konstanter Dichte heißt das A·c = konstant. Wird die Fläche kleiner, muss die Geschwindigkeit steigen. Halber Durchmesser gibt ein Viertel der Fläche und die vierfache Geschwindigkeit.

Bild: Gartenschlauch mit Daumen auf der Öffnung.
Quelle: 1.5
Abbildung: hose

### Was ist der Unterschied zwischen einem idealen Gas und einem idealen Fluid?
Ideales Gas: gehorcht pv = RT, seine Dichte darf sich ändern.

Ideales Fluid (Strömungslehre): inkompressibel und reibungsfrei.

Aus der Gasgleichung folgt keine Reibungsfreiheit, das sind zwei verschiedene Modelle.
Quelle: 1.5

### Was beschreibt die Bernoulli-Gleichung, und wann gilt sie?
p/ρ + c²/2 + g·z = konstant. Entlang einer Stromlinie tauschen Druck-, Bewegungs- und Lageenergie untereinander aus.

Sie gilt nur stationär, inkompressibel, reibungsfrei und ohne Maschinenarbeit.

Bild: Ein Wasserbehälter: Die Höhe des Wasserspiegels wird am Auslass zu Geschwindigkeit (c = √(2gh)).
Quelle: 1.5
Abbildung: bernoulli

### Warum fließt die erste Hälfte eines Behälters schneller aus als die zweite?
Die Ausflussgeschwindigkeit hängt von der Füllhöhe ab (c ≈ √(2gh)). Am Anfang drückt eine hohe Wassersäule, später nur noch eine niedrige. Der Ausfluss wird also immer langsamer, und die Kurve h(t) flacht ab.
Quelle: 1.5
Abbildung: drain-plot

### Was unterscheidet Zustandsgrößen von Prozessgrößen?
Zustandsgrößen (p, T, U, H) beschreiben eine Momentaufnahme. Ihre Änderung hängt nur von Anfang und Ende ab, nicht vom Weg.

Prozessgrößen (Wärme Q, Arbeit W) gibt es nur während eines Vorgangs. Sie hängen vom Weg ab.

Bild: Der Höhenunterschied zwischen Tal und Gipfel ist fest. Wie weit ich laufe, hängt vom Weg ab.
Quelle: 1.6
Abbildung: states

### Warum kann bei gleichem Anfangs- und Endzustand unterschiedlich viel Arbeit übertragen werden?
Die Volumenarbeit ist die Fläche unter der Kurve im p-V-Diagramm. Verschiedene Wege zwischen denselben Punkten haben verschiedene Flächen. ΔU ist gleich, aber die Aufteilung in Wärme und Arbeit nicht.
Quelle: 1.9
Abbildung: path-work

### Was ändert sich im Kreisprozess, und was nicht?
Alle Zustandsgrößen kehren zum Anfangswert zurück, ihre Gesamtänderung ist null. Trotzdem kann netto Wärme aufgenommen und Arbeit abgegeben werden. Genau so funktioniert eine Wärmekraftmaschine.
Quelle: 1.6
Abbildung: states

### Wie viele Angaben legen den Zustand eines einfachen reinen Stoffes fest?
Im einphasigen Gleichgewicht reichen zwei unabhängige intensive Angaben, z. B. p und T. Die Zustandsfläche ist die Landkarte aller erlaubten Kombinationen, z. B. p = p(v, T).
Quelle: 1.6.1

### Welchen Druck und welche Temperatur brauche ich in der idealen Gasgleichung?
Immer den **Absolutdruck** (vom Vakuum aus gemessen) und die Temperatur in **Kelvin**.

Ein Manometer zeigt meist Überdruck an, dazu kommt der Umgebungsdruck: p_abs = p_e + p_amb.
Quelle: 1.7
Abbildung: manometer

### Wann gilt das ideale Gasmodell nicht mehr gut?
Es vernachlässigt das Eigenvolumen der Moleküle und ihre Anziehung. Bei hoher Dichte oder nahe der Kondensation wird das spürbar. Verdünnter Dampf kann dagegen näherungsweise ideal sein.
Quelle: 1.6.1

### Warum hat ruhendes Wasser unten einen höheren Druck als oben?
Jede Schicht muss das Gewicht des Wassers darüber tragen. Der Druck wächst deshalb mit der Tiefe: p = p₀ + ρgh. Etwa 10 m Wasser entsprechen 1 bar.

Mechanisches Gleichgewicht heißt also Kräftegleichgewicht, nicht überall gleicher Druck.
Quelle: 1.7
Abbildung: manometer

### Warum sind Temperaturdifferenzen in K und °C gleich, Verhältnisse aber nicht?
Beide Skalen haben dieselbe Schrittweite, aber verschiedene Nullpunkte (T = θ + 273,15). Eine Differenz von 10 °C sind daher 10 K.

60 °C ist aber nicht dreimal so warm wie 20 °C: In Kelvin sind es 333 K gegen 293 K, nur etwa 14 % mehr.
Quelle: 1.8
Abbildung: kelvin

### Welches Vorzeichen hat die Volumenarbeit bei Expansion und Kompression, und warum?
W_v = −∫p dV. Bei Expansion ist dV > 0, also W_v < 0: Das Gas gibt Arbeit ab. Bei Kompression ist W_v > 0: Arbeit wird zugeführt.

Das Minus sorgt dafür, dass in der Zufuhrkonvention Zugeführtes positiv zählt.
Quelle: 1.9
Abbildung: path-work

### Was bedeutet reversibel, und was macht einen Vorgang irreversibel?
Reversibel: System **und** Umgebung lassen sich ohne bleibende Spuren zurücksetzen.

Reibung und Wärmeübertragung über einen endlichen Temperaturunterschied verhindern das. Die Energie bleibt erhalten, aber man bekommt sie nicht auf demselben Weg vollständig zurück.
Quelle: 1.10
Abbildung: reversibility

### Warum ist Rühren in einem adiabaten Behälter irreversibel?
Die Rührarbeit wird durch Reibung zu innerer Energie, das Gas wird wärmer. Dreht man den Rührer rückwärts, kühlt das Gas nicht ab, sondern wird noch wärmer. Die Dissipation lässt sich nicht umkehren.

Bild: Umrühren im Kaffee macht ihn minimal wärmer. Rückwärtsrühren macht ihn nicht wieder kälter.
Quelle: 1.10
Abbildung: reversibility

### Was bedeutet quasistatisch, und ist quasistatisch dasselbe wie reversibel?
Quasistatisch: eine gedachte Folge von Gleichgewichtszuständen, also sehr langsam. Das ist nicht dasselbe wie reversibel: Ein langsamer Kolben mit Reibung ist quasistatisch, aber wegen der Reibung trotzdem irreversibel.
Quelle: 1.10
Abbildung: reversibility

### Was bedeutet ein „Energieverlust“ in der Technik wirklich?
Die Energie verschwindet nicht. Sie wird z. B. durch Reibung zu innerer Energie oder geht an die Umgebung, wo sie nicht mehr nutzbar ist. Die Energiebilanz sagt, wie viel. Ob ein Vorgang umkehrbar ist, braucht eine zusätzliche Aussage.
Quelle: 1.10
Abbildung: reversibility

## Kapitel 2 · Stoffeigenschaften

### Warum hat die Erwärmungskurve von Eis zu Dampf waagerechte Abschnitte?
Auf den schrägen Abschnitten wird eine einzelne Phase wärmer (fühlbare Wärme). Auf den waagerechten Plateaus fließt weiter Energie zu, aber sie verändert nur den Phasenanteil (latente Wärme). Bei konstantem Druck bleibt die Temperatur dabei konstant.

Ein Plateau heißt also nicht „Heizung aus“.
Quelle: 2.1
Abbildung: warming

### Warum braucht das Verdampfen von Wasser so viel Energie?
Beim Verdampfen müssen die Moleküle voneinander gelöst werden, und das Volumen wächst stark. Für 1 kg Wasser braucht das Verdampfen etwa 2257 kJ, das Erwärmen von 0 auf 100 °C nur etwa 417 kJ.
Quelle: 2.5
Abbildung: five-states

### Unter welchen Bedingungen gilt beim Verdampfen Q = m·(h″ − h′)?
Reiner Stoff, Gleichgewicht, konstanter Druck unter dem kritischen Druck, vollständiger Wechsel von gesättigter Flüssigkeit zu Sattdampf. Im geschlossenen System nur Volumenarbeit und keine nennenswerten Änderungen von Bewegungs- und Lageenergie.
Quelle: 2.5
Abbildung: five-states

### Was ist bei einer mittleren Wärmekapazität mit Bezug auf 0 °C zu beachten?
Der Tabellenwert C_θ gilt für das Intervall von 0 °C bis θ. Für 6 → 80 °C rechnet man daher C₈₀·80 − C₆·6 und nicht einfach C₈₀·74. Das Intervall ist ein anderes.
Quelle: 2.1
Abbildung: warming

### Was misst der Realgasfaktor Z?
Z = pv/(RT) sagt, wie stark ein reales Gas von der idealen Gasgleichung abweicht. Z = 1 heißt ideal.

Z hängt vom Zustand ab und muss für jeden Zustand neu bestimmt werden. Er ist ein Korrekturfaktor für die thermische Zustandsgleichung, kein Wirkungsgrad.
Quelle: 2.2
Abbildung: oxygen

### Was ist die Sättigung, und warum sind dort Druck und Temperatur gekoppelt?
Im Gleichgewicht von Flüssigkeit und Dampf eines reinen Stoffes gehört zu jedem Druck genau eine Siedetemperatur: T = T_s(p).

Damit weiß ich aber noch nicht, wie viel Flüssigkeit und wie viel Dampf da sind. Dafür brauche ich eine weitere Angabe, z. B. den Dampfgehalt x.

Bild: Die Sättigung ist wie eine Schiene: Der Druck legt die Temperatur fest, wie weit man auf der Schiene ist, sagt erst x.
Quelle: 2.3
Abbildung: pvt

### Wodurch unterscheiden sich unterkühlte Flüssigkeit, Nassdampf, Sattdampf und überhitzter Dampf?
- **Unterkühlte Flüssigkeit:** T < T_s(p).
- **Siedelinie:** gesättigte Flüssigkeit, x = 0.
- **Nassdampf:** beide Phasen zugleich, 0 < x < 1.
- **Taulinie / Sattdampf:** x = 1.
- **Überhitzter Dampf:** T > T_s(p).

„Unterkühlt“ und „überhitzt“ beziehen sich auf die Siedetemperatur, nicht auf das Gefühl warm oder kalt.
Quelle: 2.4
Abbildung: phase-dome

### Was passiert am kritischen Punkt?
Flüssigkeit und Dampf werden ununterscheidbar: v″ − v′ und die Verdampfungsenthalpie gehen gegen null. Die Flüssig-Dampf-Grenze endet dort. Wasser: etwa 220,6 bar und 647 K.
Quelle: 2.4
Abbildung: phase-dome

### Was passiert beim isobaren Verdampfen in einem Zylinder mit Kolben?
Unterkühlte Flüssigkeit wird bis zur Siedetemperatur warm. Dann verdampft sie bei gleichem Druck und gleicher Temperatur, der Dampfanteil und das Volumen wachsen stark, der Kolben hebt sich. Erst wenn alles verdampft ist, steigt die Temperatur des Dampfes wieder.
Quelle: 2.5
Abbildung: five-states

### Warum braucht auch ein überkritischer Erwärmungsweg Energie, obwohl es kein Siedeplateau gibt?
Oberhalb des kritischen Drucks gibt es keinen Siedevorgang mit zwei Phasen. Die Eigenschaften ändern sich fließend von flüssigkeitsähnlich zu gasähnlich. Der Energiebedarf bleibt aber, die Enthalpie steigt weiter. Es fehlt nur der sprunghafte Phasenwechsel.
Quelle: 2.6
Abbildung: supercritical

### Was entscheidet beim Erwärmen von Nassdampf in einem starren Behälter, ob am Ende Flüssigkeit oder Dampf übrig bleibt?
Im starren, geschlossenen Behälter bleibt v = V/m konstant. Ist v größer als v_kr, verlässt der Stoff das Nassdampfgebiet zur Dampfseite. Ist v kleiner, endet er auf der Flüssigkeitsseite, danach kann der Druck stark steigen.

Mehr Wärme heißt also nicht immer mehr Dampf.
Quelle: 2.7
Abbildung: isochoric

### Was ist der Dampfgehalt x, und warum ist er kein Volumenanteil?
x = Dampfmasse / Gesamtmasse. Weil Dampf pro kg viel mehr Platz braucht, kann wenig Dampfmasse den größten Teil des Volumens füllen. Beispiel Ammoniak-Ampulle: 1,2 % der Masse sind Dampf, aber 84 % des Volumens.

Aus „halb mit Dampf gefüllt“ folgt also nicht „halbe Masse Dampf“.
Quelle: 2.9
Abbildung: mass-volume

### Woher kommt die Mischungsregel y = y′ + x·(y″ − y′)?
Volumen, Enthalpie, innere Energie und Entropie des Gemisches setzen sich aus den Beiträgen beider Phasen zusammen. Teilt man durch die Gesamtmasse, werden die Phasen mit ihren Massenanteilen (1 − x) und x gewichtet. Das gilt für v, u, h und s, nicht für p und T.
Quelle: 2.9
Abbildung: mass-volume

### Was sagt die Hebelregel im p-v-Diagramm?
Auf der waagerechten Linie im Nassdampfgebiet ist x der Abstand vom Flüssigkeitsrand v′ bis zum Gemischpunkt v, geteilt durch die ganze Breite v″ − v′. In der Mitte ist x = 0,5.
Quelle: 2.9
Abbildung: lever

### Wie prüfe ich, ob ein berechneter Nassdampfwert plausibel ist?
Für 0 ≤ x ≤ 1 müssen v, h, u und s zwischen ihren Randwerten (′ und ″) liegen. Ein x > 1 ist kein Nassdampf mehr, dann ist der Dampf überhitzt und die Mischungsregel gilt nicht.
Quelle: 2.9

### Wie transportiert ein Wärmerohr Wärme, obwohl es geschlossen ist?
Am warmen Ende verdampft das Fluid, am kalten Ende kondensiert es und gibt dort die Verdampfungsenergie ab. Die Flüssigkeit läuft in einer Kapillarstruktur zurück. Innen zirkuliert Masse, aber über die äußere Grenze geht keine.
Quelle: 2.9
Abbildung: heatpipe

### Wie gehe ich beim Ablesen der Dampftafel vor?
Erst das Zustandsgebiet bestimmen: Bei gegebenem Druck T_s(p) nachschlagen und mit T vergleichen. Unterkühlt oder überhitzt: p-T-Tabelle. Nassdampf: Sättigungstafel plus x.

Interpolieren schließt nur Lücken zwischen nahen Tabellenwerten im selben Gebiet, nie über Phasengrenzen hinweg.
Quelle: 2.10

### Warum darf man Enthalpiewerte aus verschiedenen Tabellen nicht einfach mischen?
Enthalpien haben einen willkürlich gewählten Nullpunkt. Verschiedene Tabellen haben oft verschiedene Nullpunkte. Nur Differenzen aus demselben Datensatz sind sinnvoll. Deshalb können Tabellenwerte sogar negativ sein.
Quelle: 2.13.2

### Was ist der Tripelpunkt, und wie unterscheidet er sich vom kritischen Punkt?
Am Tripelpunkt existieren fest, flüssig und gasförmig gleichzeitig im Gleichgewicht (Wasser: 0,01 °C, 612 Pa).

Am kritischen Punkt verschwindet dagegen der Unterschied zwischen Flüssigkeit und Dampf. Der eine Punkt hat drei unterscheidbare Phasen, der andere gar keine Phasengrenze mehr.
Quelle: 2.11
Abbildung: triple

### Warum steigt die Dampfdruckkurve, während die Schmelzkurve von Eis fällt?
Clapeyron: dp/dT = Δh/(T·Δv). Beim Verdampfen ist Δh > 0 und Δv > 0, also steigt die Kurve.

Eis braucht mehr Platz als Wasser. Beim Schmelzen ist Δv < 0, also fällt die Schmelzkurve: Mehr Druck lässt Eis eher schmelzen.
Quelle: 2.11
Abbildung: triple

### Welche Schwächen der idealen Gasgleichung korrigiert van der Waals?
Zwei Dinge: Die Moleküle ziehen sich an (Term a/v², verringert den Druck auf die Wand), und sie haben ein Eigenvolumen (Term −b, nimmt Platz weg). Je dichter das Gas, desto wichtiger werden beide Korrekturen.
Quelle: 2.12.1

### Was ist der Unterschied zwischen Partialdruck und Partialvolumen in einem Gasgemisch?
Partialdruck: der Druck, den eine Komponente allein im ganzen Gemischvolumen hätte. Die Partialdrücke addieren sich zum Gesamtdruck.

Partialvolumen: das Volumen, das eine Komponente allein beim Gemischdruck einnähme. Die Partialvolumina addieren sich zum Gesamtvolumen.

Bei idealen Gasen gilt beides: p_i/p = V_i/V = Molanteil ψ_i.
Quelle: 2.12.2
Abbildung: mixing

### Warum enthält Luft 23 % Sauerstoff und gleichzeitig 21 % Sauerstoff?
23 % ist der Massenanteil ξ, 21 % der Molanteil ψ. Sauerstoff-Moleküle sind schwerer als Stickstoff-Moleküle, deshalb ist ihr Massenanteil größer. Eine Prozentangabe braucht immer ihre Bezugsgröße.
Quelle: 2.12.2
Abbildung: mixing

### Warum verschwindet beim Entnehmen von Flüssigkeit aus einem Stickstoffgefäß mehr Flüssigkeit, als entnommen wird?
Das Gefäßvolumen bleibt gleich. Wo vorher Flüssigkeit war, entsteht Platz, und den füllt Dampf. Dafür verdampft ein Teil der Flüssigkeit. Die neue Dampfmasse bleibt im Gefäß, die entnommene Flüssigkeit geht hinaus.
Quelle: 2.13.2
Abbildung: stickstoff-zustaende

### Warum bleibt in einem starren Behälter v nicht konstant, wenn Masse austritt?
v = V/m. V bleibt gleich, aber m sinkt. Also wird v größer. „Starr“ heißt nur, dass das Gesamtvolumen V konstant ist.
Quelle: 2.13.2
Abbildung: stickstoff-zustaende

## Kapitel 3 · Erster Hauptsatz

### Was sagt der erste Hauptsatz in einem Satz?
Die Änderung der gespeicherten Energie eines Systems ist gleich der Summe der Energie, die als Wärme, Arbeit und mit Stoffströmen über die Grenze kommt. Energie geht nicht verloren und entsteht nicht.

Er sagt aber nicht, welche Prozessgröße in welche Zustandsänderung umgewandelt wird.
Quelle: 3.1
Abbildung: hs-overview

### Warum sind Wärme und Arbeit keine Zustandsgrößen?
Sie existieren nur während der Übertragung über die Grenze. Ist die Energie einmal im System, ist sie einfach Energie, man sieht ihr nicht mehr an, ob sie als Wärme oder Arbeit kam.

Bild: Teich mit Bächen: Die Bäche sind Wärme und Arbeit, der Wasserstand ist die gespeicherte Energie. Der Teich weiß nicht, aus welchem Bach sein Wasser kam.
Quelle: 3.1
Abbildung: hs-overview

### Warum steht im ersten Hauptsatz für offene Systeme die Enthalpie h, im geschlossenen die innere Energie u?
Im offenen System muss der Stoff hinein- und hinausgeschoben werden. Diese Verschiebearbeit pv steckt in h = u + pv.

Im geschlossenen System geht keine Masse über die Grenze, es gibt keine Verschiebearbeit. Deshalb reicht u.
Quelle: 3.1.1
Abbildung: hs-open

### Welche Arbeit gehört zum offenen und welche zum geschlossenen System?
Offen (durchströmt): technische Arbeit, mit der Druckarbeit ∫v dp. Das Maschinenvolumen ändert sich nicht, aber der Druck.

Geschlossen: Gesamtarbeit, mit der Volumenarbeit −∫p dv. Der Kolben verschiebt sich, das Volumen ändert sich.
Quelle: 3.1.2
Abbildung: hs-closed

### Was unterscheidet Q₁₂ von Q̇₁₂?
Q₁₂ ist eine Energiemenge in J oder kJ, übertragen zwischen zwei Zeitpunkten. Q̇₁₂ ist ein Wärmestrom in W oder kW, also Energie pro Zeit.

Der Punkt bezeichnet den Zeitbezug, nicht die Systemart. Auch ein geschlossenes System kann einen Wärmestrom aufnehmen.
Quelle: 3.1
Abbildung: hs-overview

### Welche Energieformen stehen in der Stoffstromenergie e = h + c²/2 + g·z?
h ist innere Energie plus Verschiebearbeit, c²/2 die Bewegungsenergie und g·z die Lageenergie, jeweils pro kg. Achtung: c²/2 und g·z kommen in J/kg heraus und müssen für eine Bilanz in kJ/kg durch 1000 geteilt werden.
Quelle: 3.1.1
Abbildung: hs-open

### Was bedeutet Dissipation J₁₂ im ersten Hauptsatz?
Ein Teil der zugeführten Arbeit wird durch Reibung oder Turbulenz direkt zu innerer Energie, statt das Volumen zu ändern. Er wirkt wie Wärmezufuhr, ist aber über die Grenze als Arbeit gekommen. Man darf ihn deshalb nicht noch einmal als Wärme addieren.
Quelle: 3.1.3
Abbildung: hs-special

### Was bleibt vom ersten Hauptsatz für ein abgeschlossenes, ruhendes System übrig?
Weder Wärme noch Arbeit noch Masse gehen über die Grenze. Also ändert sich die Energie nicht: ΔU = 0, wenn das System auch ruht und seine Höhe gleich bleibt.
Quelle: 3.1.3
Abbildung: hs-special

### Warum erwärmt sich eine Bleikugel beim Aufschlag?
Ihre Lage- und Bewegungsenergie wird beim Aufprall durch Verformung zu innerer Energie. Im idealen Modell geht nichts an Boden oder Luft, dann steigt ihre Temperatur um (c²/2 + g·z)/c_Pb. Real geht ein Teil an Boden und Umgebung.
Quelle: 3.1.4
Abbildung: ball

### Wie gehe ich bei einer Aufgabe zum ersten Hauptsatz vor?
1. System und Zustände ① und ② festlegen.
2. Offen oder geschlossen? Danach h oder u wählen.
3. Alle Terme hinschreiben.
4. Erst dann mit den Annahmen streichen (stationär, adiabat, reibfrei, ruhend).
5. Stoffwerte einsetzen.
Quelle: 3.1

### Warum reicht beim Entnehmen aus einem Behälter Q = ΔU nicht?
Während der Entnahme ist der Behälterinhalt ein offenes, instationäres System. Die austretende Masse nimmt ihre Enthalpie mit. Richtig ist: ΔU = Q − m_entn·h′. Wer das vergisst, lässt den Energietransport mit der Masse weg.
Quelle: 3.2.1

### Warum muss man bei „die Entropie steigt“ immer die Bezugsgröße nennen?
Die spezifische Entropie s (pro kg) und die gesamte Entropie S = m·s können sich verschieden verhalten. Nach einer Entnahme kann s des Restes steigen, während S sinkt, weil weniger Masse da ist.
Quelle: 3.2.2
