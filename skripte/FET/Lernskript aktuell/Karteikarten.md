# Karteikarten · FET

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
Stationär heißt: Am festen Ort ändert sich nichts mit der Zeit. Die Speicherterme (z. B. $(dif m)/(dif t)$) sind null.

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
$h = u + p v$. Ein Stoffstrom bringt seine innere Energie u mit. Zusätzlich muss er gegen den Druck in den Kontrollraum hineingeschoben werden, das ist die Verschiebearbeit $p v$.

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
- **Intensiv** ($p$, $T$, $rho$): bleibt gleich.
- **Spezifisch** ($v = V\/m$, $u$, $h$): Größe pro kg. Bleibt auch gleich, weil Zähler und Nenner gleich schrumpfen.

Spezifische Größen trennen die Stoffeigenschaft von der Menge.
Quelle: 1.4
Abbildung: division

### Was sagt die Kontinuitätsgleichung, und warum wird Wasser in einer engen Düse schneller?
Stationär ohne weitere Zu- oder Abflüsse geht durch jeden Querschnitt dieselbe Masse pro Sekunde: $rho A c = "konstant"$.

Bei konstanter Dichte heißt das $A c = "konstant"$. Wird die Fläche kleiner, muss die Geschwindigkeit steigen. Halber Durchmesser gibt ein Viertel der Fläche und die vierfache Geschwindigkeit.

Bild: Gartenschlauch mit Daumen auf der Öffnung.
Quelle: 1.5
Abbildung: hose

### Was ist der Unterschied zwischen einem idealen Gas und einem idealen Fluid?
Ideales Gas: gehorcht $p v = R T$, seine Dichte darf sich ändern.

Ideales Fluid (Strömungslehre): inkompressibel und reibungsfrei.

Aus der Gasgleichung folgt keine Reibungsfreiheit, das sind zwei verschiedene Modelle.
Quelle: 1.5

### Was beschreibt die Bernoulli-Gleichung, und wann gilt sie?
$p/rho + c^2/2 + g z = "konstant"$. Entlang einer Stromlinie tauschen Druck-, Bewegungs- und Lageenergie untereinander aus.

Sie gilt nur stationär, inkompressibel, reibungsfrei und ohne Maschinenarbeit.

Bild: Ein Wasserbehälter: Die Höhe des Wasserspiegels wird am Auslass zu Geschwindigkeit ($c = sqrt(2 g h)$).
Quelle: 1.5
Abbildung: bernoulli

### Warum fließt die erste Hälfte eines Behälters schneller aus als die zweite?
Die Ausflussgeschwindigkeit hängt von der Füllhöhe ab ($c approx sqrt(2 g h)$). Am Anfang drückt eine hohe Wassersäule, später nur noch eine niedrige. Der Ausfluss wird also immer langsamer, und die Kurve $h(t)$ flacht ab.
Quelle: 1.5
Abbildung: drain-plot

### Was unterscheidet Zustandsgrößen von Prozessgrößen?
Zustandsgrößen ($p$, $T$, $U$, $H$) beschreiben eine Momentaufnahme. Ihre Änderung hängt nur von Anfang und Ende ab, nicht vom Weg.

Prozessgrößen (Wärme Q, Arbeit W) gibt es nur während eines Vorgangs. Sie hängen vom Weg ab.

Bild: Der Höhenunterschied zwischen Tal und Gipfel ist fest. Wie weit ich laufe, hängt vom Weg ab.
Quelle: 1.6
Abbildung: states

### Warum kann bei gleichem Anfangs- und Endzustand unterschiedlich viel Arbeit übertragen werden?
Die Volumenarbeit ist die Fläche unter der Kurve im $p$-$V$-Diagramm. Verschiedene Wege zwischen denselben Punkten haben verschiedene Flächen. $Delta U$ ist gleich, aber die Aufteilung in Wärme und Arbeit nicht.
Quelle: 1.9
Abbildung: path-work

### Was ändert sich im Kreisprozess, und was nicht?
Alle Zustandsgrößen kehren zum Anfangswert zurück, ihre Gesamtänderung ist null. Trotzdem kann netto Wärme aufgenommen und Arbeit abgegeben werden. Genau so funktioniert eine Wärmekraftmaschine.
Quelle: 1.6
Abbildung: states

### Wie viele Angaben legen den Zustand eines einfachen reinen Stoffes fest?
Im einphasigen Gleichgewicht reichen zwei unabhängige intensive Angaben, z. B. $p$ und $T$. Die Zustandsfläche ist die Landkarte aller erlaubten Kombinationen, z. B. $p = p(v, T)$.
Quelle: 1.6.1

### Welchen Druck und welche Temperatur brauche ich in der idealen Gasgleichung?
Immer den **Absolutdruck** (vom Vakuum aus gemessen) und die Temperatur in **Kelvin**.

Ein Manometer zeigt meist Überdruck an, dazu kommt der Umgebungsdruck: $p_"abs" = p_e + p_"amb"$.
Quelle: 1.7
Abbildung: manometer

### Wann gilt das ideale Gasmodell nicht mehr gut?
Es vernachlässigt das Eigenvolumen der Moleküle und ihre Anziehung. Bei hoher Dichte oder nahe der Kondensation wird das spürbar. Verdünnter Dampf kann dagegen näherungsweise ideal sein.
Quelle: 1.6.1

### Warum hat ruhendes Wasser unten einen höheren Druck als oben?
Jede Schicht muss das Gewicht des Wassers darüber tragen. Der Druck wächst deshalb mit der Tiefe: $p = p_0 + rho g h$. Etwa 10 m Wasser entsprechen 1 bar.

Mechanisches Gleichgewicht heißt also Kräftegleichgewicht, nicht überall gleicher Druck.
Quelle: 1.7
Abbildung: manometer

### Warum sind Temperaturdifferenzen in K und °C gleich, Verhältnisse aber nicht?
Beide Skalen haben dieselbe Schrittweite, aber verschiedene Nullpunkte ($T\/"K" = theta\/"°C" + "273,15"$). Eine Differenz von 10 °C sind daher 10 K.

60 °C ist aber nicht dreimal so warm wie 20 °C: In Kelvin sind es 333 K gegen 293 K, nur etwa 14 % mehr.
Quelle: 1.8
Abbildung: kelvin

### Welches Vorzeichen hat die Volumenarbeit bei Expansion und Kompression, und warum?
$W_v = -integral p dif V$. Bei Expansion ist $dif V > 0$, also $W_v < 0$: Das Gas gibt Arbeit ab. Bei Kompression ist $W_v > 0$: Arbeit wird zugeführt.

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


### Zeichne die Begriffslandkarte zu Kapitel 1 aus dem Kopf: Welche Begriffe gehören dazu und wie hängen sie zusammen?
Die Systemgrenze trennt System und Umgebung und entscheidet, ob Masse sowie Energie übertragen werden. Zustandsgrößen beschreiben den Speicher; Wärme und Arbeit beschreiben Übertragungen auf einem Prozessweg. Masse, Stoffmenge und spezifische Größen legen den Bezug fest, Ströme ergänzen den Zeitbezug. Stationarität bedeutet zeitlich unverändert, Gleichgewicht fehlende antreibende Unterschiede; Modellannahmen wie Reversibilität müssen zusätzlich geprüft werden.
Quelle: 1.0

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
Der Tabellenwert $C_theta$ gilt für das Intervall von 0 °C bis $theta$. Für 6 → 80 °C rechnet man daher
$ C_80 dot 80 - C_6 dot 6 quad "und nicht" quad C_80 dot 74 $
Das Intervall ist ein anderes.
Quelle: 2.1
Abbildung: warming

### Was misst der Realgasfaktor Z?
$Z = (p v)/(R T)$ sagt, wie stark ein reales Gas von der idealen Gasgleichung abweicht. $Z = 1$ heißt ideal.

$Z$ hängt vom Zustand ab und muss für jeden Zustand neu bestimmt werden. Er ist ein Korrekturfaktor für die thermische Zustandsgleichung, kein Wirkungsgrad.
Quelle: 2.2
Abbildung: oxygen

### Was ist die Sättigung, und warum sind dort Druck und Temperatur gekoppelt?
Im Gleichgewicht von Flüssigkeit und Dampf eines reinen Stoffes gehört zu jedem Druck genau eine Siedetemperatur: $T = T_s (p)$.

Damit weiß ich aber noch nicht, wie viel Flüssigkeit und wie viel Dampf da sind. Dafür brauche ich eine weitere Angabe, z. B. den Dampfgehalt $x$.

Bild: Die Sättigung ist wie eine Schiene: Der Druck legt die Temperatur fest, wie weit man auf der Schiene ist, sagt erst x.
Quelle: 2.3
Abbildung: pvt

### Wodurch unterscheiden sich unterkühlte Flüssigkeit, Nassdampf, Sattdampf und überhitzter Dampf?
- **Unterkühlte Flüssigkeit:** $T < T_s (p)$.
- **Siedelinie:** gesättigte Flüssigkeit, $x = 0$.
- **Nassdampf:** beide Phasen zugleich, 0 < x < 1.
- **Taulinie / Sattdampf:** $x = 1$.
- **Überhitzter Dampf:** $T > T_s (p)$.

„Unterkühlt“ und „überhitzt“ beziehen sich auf die Siedetemperatur, nicht auf das Gefühl warm oder kalt.
Quelle: 2.4
Abbildung: phase-dome

### Was passiert am kritischen Punkt?
Flüssigkeit und Dampf werden ununterscheidbar: $v'' - v'$ und die Verdampfungsenthalpie gehen gegen null. Die Flüssig-Dampf-Grenze endet dort. Wasser: etwa 220,6 bar und 647 K.
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
Im starren, geschlossenen Behälter bleibt $v = V\/m$ konstant. Ist $v$ größer als $v_"kr"$, verlässt der Stoff das Nassdampfgebiet zur Dampfseite. Ist $v$ kleiner, endet er auf der Flüssigkeitsseite, danach kann der Druck stark steigen.

Mehr Wärme heißt also nicht immer mehr Dampf.
Quelle: 2.7
Abbildung: isochoric

### Was ist der Dampfgehalt x, und warum ist er kein Volumenanteil?
$x = m_"Dampf" \/ m_"gesamt"$. Weil Dampf pro kg viel mehr Platz braucht, kann wenig Dampfmasse den größten Teil des Volumens füllen. Beispiel Ammoniak-Ampulle: 1,2 % der Masse sind Dampf, aber 84 % des Volumens.

Aus „halb mit Dampf gefüllt“ folgt also nicht „halbe Masse Dampf“.
Quelle: 2.9
Abbildung: mass-volume

### Woher kommt die Mischungsregel y = y′ + x·(y″ − y′)?
Volumen, Enthalpie, innere Energie und Entropie des Gemisches setzen sich aus den Beiträgen beider Phasen zusammen. Teilt man durch die Gesamtmasse, werden die Phasen mit ihren Massenanteilen $(1 - x)$ und $x$ gewichtet. Das gilt für $v$, $u$, $h$ und $s$, nicht für $p$ und $T$.
Quelle: 2.9
Abbildung: mass-volume

### Was sagt die Hebelregel im p-v-Diagramm?
Auf der waagerechten Linie im Nassdampfgebiet ist $x$ der Abstand vom Flüssigkeitsrand $v'$ bis zum Gemischpunkt $v$, geteilt durch die ganze Breite $v'' - v'$:
$ x = (v - v')/(v'' - v') $
In der Mitte ist $x = "0,5"$.
Quelle: 2.9
Abbildung: lever

### Wie prüfe ich, ob ein berechneter Nassdampfwert plausibel ist?
Für $0 <= x <= 1$ müssen $v$, $h$, $u$ und $s$ zwischen ihren Randwerten ($'$ und $''$) liegen. Ein $x > 1$ ist kein Nassdampf mehr, dann ist der Dampf überhitzt und die Mischungsregel gilt nicht.
Quelle: 2.9

### Wie transportiert ein Wärmerohr Wärme, obwohl es geschlossen ist?
Am warmen Ende verdampft das Fluid, am kalten Ende kondensiert es und gibt dort die Verdampfungsenergie ab. Die Flüssigkeit läuft in einer Kapillarstruktur zurück. Innen zirkuliert Masse, aber über die äußere Grenze geht keine.
Quelle: 2.9
Abbildung: heatpipe

### Wie gehe ich beim Ablesen der Dampftafel vor?
Erst das Zustandsgebiet bestimmen: Bei gegebenem Druck $T_s (p)$ nachschlagen und mit $T$ vergleichen. Unterkühlt oder überhitzt: $p$-$T$-Tabelle. Nassdampf: Sättigungstafel plus $x$.

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
Clapeyron:
$ (dif p)/(dif T) = (Delta h)/(T Delta v) $
Beim Verdampfen ist $Delta h > 0$ und $Delta v > 0$, also steigt die Kurve.

Eis braucht mehr Platz als Wasser. Beim Schmelzen ist $Delta v < 0$, also fällt die Schmelzkurve: Mehr Druck lässt Eis eher schmelzen.
Quelle: 2.11
Abbildung: triple

### Welche Schwächen der idealen Gasgleichung korrigiert van der Waals?
Zwei Dinge: Die Moleküle ziehen sich an (Term $a\/v^2$, verringert den Druck auf die Wand), und sie haben ein Eigenvolumen (Term $-b$, nimmt Platz weg). Je dichter das Gas, desto wichtiger werden beide Korrekturen.
Quelle: 2.12.1

### Was ist der Unterschied zwischen Partialdruck und Partialvolumen in einem Gasgemisch?
Partialdruck: der Druck, den eine Komponente allein im ganzen Gemischvolumen hätte. Die Partialdrücke addieren sich zum Gesamtdruck.

Partialvolumen: das Volumen, das eine Komponente allein beim Gemischdruck einnähme. Die Partialvolumina addieren sich zum Gesamtvolumen.

Bei idealen Gasen gilt beides: $p_i\/p = V_i\/V = psi_i$ (Molanteil).
Quelle: 2.12.2
Abbildung: mixing

### Warum enthält Luft 23 % Sauerstoff und gleichzeitig 21 % Sauerstoff?
23 % ist der Massenanteil $xi$, 21 % der Molanteil $psi$. Sauerstoff-Moleküle sind schwerer als Stickstoff-Moleküle, deshalb ist ihr Massenanteil größer. Eine Prozentangabe braucht immer ihre Bezugsgröße.
Quelle: 2.12.2
Abbildung: mixing

### Warum verschwindet beim Entnehmen von Flüssigkeit aus einem Stickstoffgefäß mehr Flüssigkeit, als entnommen wird?
Das Gefäßvolumen bleibt gleich. Wo vorher Flüssigkeit war, entsteht Platz, und den füllt Dampf. Dafür verdampft ein Teil der Flüssigkeit. Die neue Dampfmasse bleibt im Gefäß, die entnommene Flüssigkeit geht hinaus.
Quelle: 2.13.2
Abbildung: stickstoff-zustaende

### Warum bleibt in einem starren Behälter v nicht konstant, wenn Masse austritt?
$v = V\/m$. $V$ bleibt gleich, aber $m$ sinkt. Also wird $v$ größer. „Starr“ heißt nur, dass das Gesamtvolumen $V$ konstant ist.
Quelle: 2.13.2
Abbildung: stickstoff-zustaende


### Zeichne die Begriffslandkarte zu Kapitel 2 aus dem Kopf: Welche Begriffe gehören dazu und wie hängen sie zusammen?
Energiezufuhr verändert Temperatur oder Phasenanteile. Zuerst wird das Zustandsgebiet bestimmt; daraus ergibt sich die passende Tabelle oder Zustandsgleichung. Im Nassdampfgebiet koppeln Sättigung Druck und Temperatur, während der Dampfgehalt die Massenaufteilung und die gemittelten spezifischen Größen festlegt. Prozessbedingungen wie konstantes Volumen verbinden die Zustände; Interpolation und einheitliche Bezugsgrößen liefern die Werte für die Energiebilanz.
Quelle: 2.1

### Warum kann sich ein Eis-Wasser-Dampf-Gemisch trotz Wärmezufuhr zunächst nicht erwärmen?
Solange alle drei Phasen im Gleichgewicht vorhanden sind, bleiben Druck und Temperatur auf ihren Tripelwerten. Die zugeführte Energie verändert zunächst die Phasenmengen. Erst nach dem Verschwinden einer Phase kann der weitere Weg den Tripelzustand verlassen.
Quelle: 2.14.1
Abbildung: map-tripel

### Warum liegen Anfang und Ende des Schmelzens im starren Tripelgefäß im p-v-Diagramm auf demselben Punkt?
Masse und Gesamtvolumen bleiben konstant, damit auch das spezifische Volumen. Solange der Tripelzustand besteht, bleibt außerdem der Druck gleich. Die Phasenanteile können sich ändern, obwohl die Diagrammkoordinaten gleich bleiben.
Quelle: 2.14.1
Abbildung: tripel-isochor

### Warum müssen nach dem Schmelzen im Tripelgefäß die Teilmassen neu berechnet werden?
Eis, Flüssigkeit und Dampf ändern während der Wärmezufuhr ihre Anteile. Nach dem Verschwinden des Eises gelten eine Massenbilanz und eine Volumenbilanz für die beiden übrigen Phasen. Erst mit diesen neuen Teilmassen lässt sich die Endenergie und daraus die nötige Wärme bestimmen.
Quelle: 2.14.2
Abbildung: map-tripel

### Warum darf beim Schmelzen im geschlossenen starren Tripelgefäß mit der Änderung der Gesamtenthalpie gerechnet werden?
Die Wärme ändert zunächst die gesamte innere Energie. Weil sowohl der Tripeldruck als auch das Gesamtvolumen konstant bleiben, ändert sich ihr Produkt nicht. Aus $U=H-p V$ folgt dann $Delta U=Delta H$. Erst nach Verlassen des Tripelzustands muss der Druck-Volumen-Anteil wieder geprüft werden.
Quelle: 2.14.2
Abbildung: map-tripel

### Warum legt ein Massenstrom den Durchmesser einer Dampfleitung noch nicht allein fest?
Man braucht außerdem das spezifische Volumen des Dampfes und die vorgesehene mittlere Geschwindigkeit. Das spezifische Volumen wandelt den Massenstrom in einen Volumenstrom um. Erst aus Volumenstrom und Geschwindigkeit folgt der freie Querschnitt.
Quelle: 2.15.1

### Warum enthält eine volumetrisch halb mit Dampf gefüllte Kesseltrommel nicht zur Hälfte Dampfmasse?
Dampf braucht pro Kilogramm viel mehr Raum als Flüssigkeit. Gleiche Teilvolumina liefern deshalb verschiedene Teilmassen. Der Dampfgehalt wird aus den Massen gebildet, nachdem jede Teilmasse über ihr spezifisches Volumen berechnet wurde.
Quelle: 2.15.2
Abbildung: dampftrommel-anteile

### Warum führt derselbe Heizvorgang im abgesperrten Überhitzer bei verschiedenen Anfangs-Dampfgehalten auf verschiedene Zustandswege?
Jede Füllung besitzt ein anderes spezifisches Volumen. Nach dem Absperren bleiben Masse und Gesamtvolumen fest, also verläuft jede Füllung auf ihrer eigenen Isochore. Deshalb erreicht sie die Sattdampflinie und später bestimmte Druckgrenzen an anderen Zuständen.
Quelle: 2.15.3
Abbildung: ueberhitzer-wege

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
Im offenen System muss der Stoff hinein- und hinausgeschoben werden. Diese Verschiebearbeit $p v$ steckt in $h = u + p v$.

Im geschlossenen System geht keine Masse über die Grenze, es gibt keine Verschiebearbeit. Deshalb reicht $u$.
Quelle: 3.1.1
Abbildung: hs-open

### Welche Arbeit gehört zum offenen und welche zum geschlossenen System?
Offen (durchströmt): technische Arbeit, mit der Druckarbeit $integral v dif p$. Das Maschinenvolumen ändert sich nicht, aber der Druck.

Geschlossen: Gesamtarbeit, mit der Volumenarbeit $-integral p dif v$. Der Kolben verschiebt sich, das Volumen ändert sich.
Quelle: 3.1.2
Abbildung: hs-closed

### Was unterscheidet Q₁₂ von Q̇₁₂?
$Q_12$ ist eine Energiemenge in J oder kJ, übertragen zwischen zwei Zeitpunkten. $dot(Q)_12$ ist ein Wärmestrom in W oder kW, also Energie pro Zeit.

Der Punkt bezeichnet den Zeitbezug, nicht die Systemart. Auch ein geschlossenes System kann einen Wärmestrom aufnehmen.
Quelle: 3.1
Abbildung: hs-overview

### Welche Energieformen stehen in der Stoffstromenergie e = h + c²/2 + g·z?
$h$ ist innere Energie plus Verschiebearbeit, $c^2\/2$ die Bewegungsenergie und $g z$ die Lageenergie, jeweils pro kg. Achtung: $c^2\/2$ und $g z$ kommen in J/kg heraus und müssen für eine Bilanz in kJ/kg durch 1000 geteilt werden.
Quelle: 3.1.1
Abbildung: hs-open

### Was bedeutet Dissipation J₁₂ im ersten Hauptsatz?
Ein Teil der zugeführten Arbeit wird durch Reibung oder Turbulenz direkt zu innerer Energie, statt das Volumen zu ändern. Er wirkt wie Wärmezufuhr, ist aber über die Grenze als Arbeit gekommen. Man darf ihn deshalb nicht noch einmal als Wärme addieren.
Quelle: 3.1.3
Abbildung: hs-special

### Was bleibt vom ersten Hauptsatz für ein abgeschlossenes, ruhendes System übrig?
Weder Wärme noch Arbeit noch Masse gehen über die Grenze. Also ändert sich die Energie nicht: $Delta U = 0$, wenn das System auch ruht und seine Höhe gleich bleibt.
Quelle: 3.1.3
Abbildung: hs-special

### Warum erwärmt sich eine Bleikugel beim Aufschlag?
Ihre Lage- und Bewegungsenergie wird beim Aufprall durch Verformung zu innerer Energie. Im idealen Modell geht nichts an Boden oder Luft, dann steigt ihre Temperatur um $(c^2\/2 + g z)\/c_"Pb"$. Real geht ein Teil an Boden und Umgebung.
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
Während der Entnahme ist der Behälterinhalt ein offenes, instationäres System. Die austretende Masse nimmt ihre Enthalpie mit. Richtig ist: $Delta U = Q - m_"entn" h'$. Wer das vergisst, lässt den Energietransport mit der Masse weg.
Quelle: 3.2.1

### Warum muss man bei „die Entropie steigt“ immer die Bezugsgröße nennen?
Die spezifische Entropie $s$ (pro kg) und die gesamte Entropie $S = m s$ können sich verschieden verhalten. Nach einer Entnahme kann $s$ des Restes steigen, während $S$ sinkt, weil weniger Masse da ist.
Quelle: 3.2.2

### Zeichne die Begriffslandkarte zu Kapitel 3 aus dem Kopf: Welche Begriffe gehören dazu und wie hängen sie zusammen?
Die Systemgrenze bestimmt Stoffaustausch und Speicherung. Der erste Hauptsatz verbindet diese mit Wärme, Arbeit und Änderungen der Stoffenergie. Arbeitsformen hängen vom Prozessweg ab; Wärmekapazitäten vom Stoffmodell und vom Temperaturbereich. Ein Kreisprozess besitzt keine bleibende Zustandsänderung, aber Nettoübertragungen; Düse, Drossel und Heizregister verlangen unterschiedliche Bilanzvereinfachungen. Der Dampfkochtopf zeigt, dass konstantes p und T eine Speicherabnahme beim Massenaustritt nicht ausschließen. Erst Kapitel 4 ergänzt die Prüfung der Prozessrichtung.
Quelle: 3.12

### Warum kann sich Wasser in einer adiabaten Turbine erwärmen?
Adiabat bedeutet nur, dass keine Wärme über die Grenze übertragen wird. Wird nicht die gesamte Gefälleenergie als Wellenarbeit abgegeben, kann der Rest die innere Energie des Wassers erhöhen. Diese Energie verlässt die Turbine mit dem erwärmten Wasser; sie ist kein Wärmeverlust nach außen.
Quelle: 3.3.1
Abbildung: turbine-energie

### Warum verwendet der Turbinenwirkungsgrad den Betrag der Wellenleistung?
In der Zufuhrkonvention ist die abgegebene Wellenleistung negativ. Der Wirkungsgrad vergleicht jedoch einen positiven Nutzen mit einem positiven Aufwand. Deshalb wird hier der Betrag der Wellenleistung durch die verfügbare Gefälleleistung geteilt.
Quelle: 3.3.1
Abbildung: turbine-energie

### Wie unterscheiden sich die Energiebilanzen von Dampfkessel und adiabater Turbine?
Im stationären Kessel ohne technische Arbeit erhöht die Wärmezufuhr die Enthalpie des Stroms. In der adiabaten Turbine führt die Enthalpieabnahme zur Wellenabgabe. Beide Vereinfachungen setzen hier vernachlässigte Änderungen von Bewegungs- und Lageenergie voraus.
Quelle: 3.3.2
Abbildung: kraftwerk-enthalpie

### Warum sind spezifische Arbeit und Leistung verschiedene Größen?
Die spezifische Arbeit ist eine Energie pro Masse. Die Leistung ist dagegen Energie pro Zeit. Bei einem stationären Stoffstrom macht erst die Multiplikation mit dem Massenstrom aus der spezifischen technischen Arbeit eine Leistung: $P=dot(m) w_t$.
Quelle: 3.4.1

### Warum können zwei Verdichtungen mit denselben Endzuständen unterschiedliche Arbeit benötigen?
Die Volumenarbeit hängt vom Druck während der Volumenänderung ab. Verschiedene Wege besitzen verschiedene Flächen im Druck-Volumen-Diagramm, auch wenn Anfang und Ende gleich sind. Die Änderung der inneren Energie ist dabei gleich; unterschiedliche Arbeitsbeträge werden in der Energiebilanz durch unterschiedliche Wärmemengen ausgeglichen.
Quelle: 3.4.2
Abbildung: arbeit-zwei-wege

### Warum ist die nutzbare Arbeitsabgabe bei Expansion kleiner als die gesamte Volumenarbeitsabgabe?
Ein Teil der Volumenarbeit verdrängt die Umgebung gegen ihren Druck. Nur der darüber hinausgehende Anteil kann zusätzlich genutzt werden. Bei konstantem Umgebungsdruck gilt in der Zufuhrkonvention $W_(v,n)=W_v+p_"∞"(V_2-V_1)$; bei Expansion sind beide Abgaben negativ, der Nutzbetrag ist kleiner.
Quelle: 3.4.3
Abbildung: arbeit-nutzanteil

### Wann ist die technische Arbeit gleich dem Integral von v über den Druck?
Wenn Dissipation und Änderungen von Bewegungs- und Lageenergie vernachlässigt werden dürfen. Allgemein enthält die technische Arbeit zusätzlich diese Beiträge. Das Druckintegral allein ist daher eine begründete Vereinfachung und keine allgemeine Definition aller technischen Arbeit.
Quelle: 3.5
Abbildung: map-arbeit

### Wie hängen Druckarbeit und Volumenarbeit desselben Zustandswegs zusammen?
Es gilt $w_p=w_v+p_2 v_2-p_1 v_1$. Der Unterschied entsteht durch die Verschiebearbeiten an Ein- und Austritt. Verglichen werden derselbe Zustandsweg und dieselbe Massenbasis; reale offene und geschlossene Maschinen müssen nicht automatisch denselben Weg durchlaufen.
Quelle: 3.5.1
Abbildung: arbeit-verschiebung

### Warum braucht eine Flüssigkeitspumpe Arbeit, obwohl das spezifische Volumen fast konstant bleibt?
Die Pumpe erhöht den Druck des hindurchströmenden Stoffes. Bei annähernd konstantem spezifischem Volumen bleibt $w_p=v(p_2-p_1)$ positiv, obwohl die Volumenarbeit entlang dieses Wegs annähernd null ist. Den Unterschied erklärt die Änderung von $p v$.
Quelle: 3.5.2
Abbildung: arbeit-verschiebung

### Warum sagt man fachlich nicht, ein Stoff enthalte Wärme?
Wärme beschreibt Energieübertragung wegen eines Temperaturunterschieds. Der Stoff speichert innere Energie und besitzt Enthalpie als Zustandsgröße. Eine zugeführte Wärmemenge kann diese Zustandsgrößen verändern, ist aber kein eigener gespeicherter Wärmebestand.
Quelle: 3.6
Abbildung: map-waerme-enthalpie

### Warum darf man bei realen Fluiden Energieunterschiede nicht grundsätzlich nur aus der Temperatur berechnen?
Beim idealen Gas hängen innere Energie und Enthalpie nur von der Temperatur ab. Reale Fluide benötigen im Allgemeinen weitere Zustandsangaben und passende Tabellen. Auch konstante Wärmekapazitäten sind eine Modellannahme für den betrachteten Bereich.
Quelle: 3.6.1
Abbildung: map-waerme-enthalpie

### Wann sind die Änderungen der spezifischen Enthalpie und der inneren Energie gleich?
Wenn sich das Produkt aus Druck und spezifischem Volumen nicht ändert. Allgemein gilt $Delta u=Delta h-Delta(p v)$. Bei veränderlicher Masse muss man davon die Aussage über Gesamtgrößen unterscheiden: Konstantes gesamtes $p V$ bedeutet $Delta U=Delta H$.
Quelle: 3.6.2

### Warum gibt die isotherme Expansion im Druckluftmotor mehr Arbeit ab als die reversible Adiabate?
Bei der isothermen Expansion wird Wärme zugeführt, damit die Temperatur trotz Arbeitsabgabe gleich bleibt. Die Adiabate erhält keine Wärme; ihre Arbeit verringert die innere Energie und die Temperatur sinkt. Das größere isotherme Arbeitsvermögen benötigt deshalb zusätzliche Energiezufuhr.
Quelle: 3.7.1
Abbildung: druckluftmotor-vergleich

### Warum reicht beim Druckluftmotor die Expansionsarbeit allein nicht für die Arbeit des ganzen Gaswechsels?
Die Füllung bei hohem Druck und die Ausschiebung bei niedrigem Druck übertragen ebenfalls Arbeit. Ohne Totvolumen ergibt ihre Summe mit der Expansionsarbeit die Druckarbeit des Zyklus: $W_"Zyklus"=W_v-p_1 V_1+p_2 V_2$. Diese Verschiebearbeit ist in einer Enthalpiebilanz bereits enthalten.
Quelle: 3.7.2
Abbildung: druckluftmotor-vergleich

### Warum genügt die Drehzahl eines Motors allein nicht, um aus der Arbeit je Zyklus die Leistung zu berechnen?
Man braucht die Zahl der Arbeitsspiele pro Zeit. Die Drehzahl liefert zunächst nur Umdrehungen pro Zeit; zusätzlich muss bekannt sein, wie viele Arbeitsspiele zu einer Umdrehung gehören. Erst dann gilt $P=f W_"Zyklus"$ mit der richtigen Zyklusfrequenz.
Quelle: 3.7.2

### Warum braucht das ideale Gas bei gleichem Temperaturanstieg isobar mehr Wärme als isochor?
Bei konstantem Volumen wird keine Volumenarbeit abgegeben. Bei konstantem Druck dehnt sich das Gas beim Erwärmen aus und gibt zusätzlich Arbeit ab. Deshalb gilt im passenden reibfreien Modell $c_p=c_v+R>c_v$.
Quelle: 3.8.1
Abbildung: waermekapazitaet-kolben

### Gelten die kalorischen Stoffbeziehungen beim idealen Gas nur auf isochoren beziehungsweise isobaren Wegen?
Nein. Beim idealen Gas hängen innere Energie und Enthalpie nur von der Temperatur ab; die beiden Stoffbeziehungen gelten auch auf anderen Wegen. Erst die Gleichsetzung der Wärme mit diesen Energieänderungen benötigt passende Prozessbedingungen.
Quelle: 3.8.1

### Wie unterscheiden sich gesamte, spezifische und molare Wärmekapazität?
Die gesamte Wärmekapazität gehört zu einer konkreten Portion und hat die Einheit Energie pro Kelvin. Spezifisch bedeutet je Masse, molar je Stoffmenge. Verbunden werden sie über Masse beziehungsweise Stoffmenge und Molmasse: $C_p=m c_p=n C_(m,p)$ und $C_(m,p)=M c_p$.
Quelle: 3.8.1
Abbildung: map-waermekapazitaet

### Warum ist das Mittel 0 bis 800 Grad nicht das Mittel 400 bis 1200 Grad?
Gleiche Bereichsbreite bedeutet nicht dieselben Temperaturen oder dieselbe Wärmekapazität. Aus seit 0 Grad tabellierten Mittelwerten werden zuerst die Energiezunahmen zu beiden Endtemperaturen gebildet und voneinander abgezogen. Erst danach wird durch die Breite des gesuchten Bereichs geteilt.
Quelle: 3.8.2
Abbildung: waermekapazitaet-mittel

### Warum kann ein Kreisprozess Arbeit abgeben, obwohl seine Zustandsänderungen insgesamt null sind?
Das Arbeitsmittel kehrt nach dem Umlauf zu seinen Anfangswerten zurück. Wärme und Arbeit sind aber Übertragungen entlang des Wegs und können netto bestehen bleiben. Ihre vorzeichenbehaftete Summe muss sich nach dem ersten Hauptsatz ausgleichen.
Quelle: 3.9.1
Abbildung: kreisprozess-energie

### Wie unterscheiden sich rechtsläufiger und linksläufiger Kreisprozess in ihrer Energienutzung?
Der rechtsläufige Wärmekraftprozess gibt netto Arbeit ab. Beim linksläufigen Prozess wird Arbeit zugeführt, um Wärme von einem niedrigeren auf ein höheres Temperaturniveau zu übertragen. Pumpenaufnahme und Turbinenabgabe dürfen in einer Gesamtbilanz nicht verwechselt werden.
Quelle: 3.9.2
Abbildung: kreisprozess-energie

### Warum ist in einer adiabaten Düse nicht allgemein die Enthalpie konstant?
Ohne technische Arbeit und bei gleicher Höhe bleibt die Summe aus Enthalpie und spezifischer Bewegungsenergie gleich. Wird der Strom schneller, kann seine Enthalpie sinken. Adiabat streicht den Wärmestrom und streicht nicht den Geschwindigkeitsbeitrag.
Quelle: 3.10
Abbildung: stroemung-duese-drossel

### Warum kann eine adiabate Drossel irreversibel sein, obwohl sie keine technische Arbeit überträgt?
Druckabbau und innere Irreversibilität sind auch ohne äußere Arbeitsabgabe möglich. Bei vernachlässigten äußeren Energieänderungen bleibt die Enthalpie gleich, während die Entropie zunimmt. Die Energiebilanz allein beweist deshalb keine Reversibilität.
Quelle: 3.10
Abbildung: stroemung-duese-drossel

### Warum bedeutet isenthalpe Drosselung bei einem realen Fluid nicht automatisch konstante Temperatur?
Die Enthalpie eines realen Fluids hängt im Allgemeinen von mehr als der Temperatur ab. Daher können sich Druck und Temperatur ändern, obwohl die Enthalpie gleich bleibt. Nur beim idealen Gas mit Enthalpie als reiner Temperaturfunktion folgt unter diesen Bedingungen auch gleiche Temperatur.
Quelle: 3.10

### Warum verschwindet der Registerwärmestrom aus der Gesamtbilanz des Lufterhitzers?
Er liegt vollständig innerhalb der Grenze um Wasser, Luft und Lüfter. Was das Wasser abgibt, erhält die Luft mit dem entgegengesetzten Bilanzvorzeichen. In der Gesamtbilanz bleiben die Enthalpieänderungen beider Stoffströme und die von außen zugeführte Lüfterleistung.
Quelle: 3.11
Abbildung: lufterhitzer-grenzen

### Warum darf man bei zwei verschiedenen Stoffströmen die spezifischen Enthalpieänderungen nicht einfach addieren?
Sie beziehen sich auf jeweils ein Kilogramm ihres eigenen Stoffes. Erst die Multiplikation mit dem jeweiligen Massenstrom ergibt vergleichbare Leistungen. Unterschiedliche Massenströme müssen deshalb bis zur Bildung dieser Enthalpieströme getrennt bleiben.
Quelle: 3.11
Abbildung: lufterhitzer-grenzen


### Warum ist ein Dampfkochtopf bei konstantem Druck und konstanter Temperatur trotzdem instationär?
Dampf strömt hinaus und die Masse im Topf nimmt ab. Die Stoffwerte der einzelnen Phasen bleiben bei gleichem Sättigungsdruck zwar konstant, aber ihre Mengen ändern sich. Daher ändern sich die gesamten Speichergrößen wie die innere Energie.
Quelle: 3.12
Abbildung: kochtopf-phasen

### Warum ist die ausströmende Dampfmasse etwas kleiner als die verschwundene Flüssigkeitsmasse?
Der sinkende Flüssigkeitsspiegel schafft zusätzlichen Dampfraum. Ein kleiner Teil der verdampften Masse bleibt im Topf und füllt diesen Raum. Nur der übrige Dampf überquert die äußere Grenze.
Quelle: 3.12.1
Abbildung: kochtopf-phasen

### Warum kann der ausströmende Energiestrom eines Dampfkochtopfs größer als seine Heizleistung sein?
Die gespeicherte innere Energie im Topf nimmt ab. Der ausströmende Stoff trägt deshalb sowohl die zugeführte Energie als auch Energie aus dem sinkenden Bestand hinaus. Die Bilanz lautet $dot(Q)=frac(dif U_"Sys",dif t)+dot(E)_"aus"$; bei negativer Speicheränderung ist die Heizleistung kleiner als der ausströmende Energiestrom.
Quelle: 3.12.2
Abbildung: kochtopf-energie

### Warum wird beim Dampfaustritt die Verschiebearbeit nicht zusätzlich zur Enthalpie addiert?
Die Enthalpie enthält bereits innere Energie und Druck-Volumen-Anteil: $h=u+p v$. Die mitgeführte Energie ist bei vernachlässigter Lageenergie deshalb $e=h+c^2/2$. Wer noch einmal $p v$ addiert, zählt dieselbe Verschiebearbeit doppelt.
Quelle: 3.12.2
Abbildung: kochtopf-energie

## Kapitel 4 · Zweiter Hauptsatz und Zustandsdiagramme

### Warum reicht die Energieerhaltung allein nicht aus, um einen Prozess als möglich zu beurteilen?
Sie verlangt den Ausgleich aller Energiebeiträge, legt aber die mögliche Richtung noch nicht vollständig fest. Ein Rührer kann Fluid erwärmen; Abkühlen allein hebt das antreibende Gewicht nicht wieder an. Der zweite Hauptsatz prüft zusätzlich Irreversibilität und Entropieerzeugung.
Quelle: 4.1
Abbildung: joule-prozess

### Warum muss man bei Reversibilität die Umgebung mitbetrachten?
Reversibel wäre eine gemeinsame Rückkehr von System und Umgebung ohne bleibende Änderung. Dass nur das System wieder denselben Zustand erreicht, genügt nicht. Die dafür eingesetzte Arbeit oder Wärme kann die Umgebung dauerhaft verändert haben.
Quelle: 4.1
Abbildung: joule-prozess

### Wodurch kann sich die Entropie eines Systems ändern?
Entropie kann mit Wärme und bei offenen Systemen mit Stoff über die Grenze transportiert werden. Außerdem kann sie im Inneren durch irreversible Vorgänge entstehen. Eine Speicheränderung ist deshalb nicht automatisch gleich der Erzeugung.
Quelle: 4.2
Abbildung: entropie-bilanz

### Unter welchen Bedingungen darf die Entropie eines Systems niemals abnehmen?
Für ein adiabates geschlossenes System kann die Gesamtentropie nur zunehmen oder im reversiblen Grenzfall gleich bleiben. Bei Wärmeabgabe darf seine Entropie dagegen sinken. Bei Stoffaustausch muss zusätzlich der Entropietransport mit der Masse bilanziert werden.
Quelle: 4.2.1
Abbildung: map-entropie

### Warum kann in einer stationären adiabaten Turbine Entropie erzeugt werden, obwohl im Gerät nichts gespeichert wird?
Stationär bleibt der Entropiespeicher zeitlich gleich. Die im Inneren erzeugte Entropie kann laufend mit dem austretenden Stoff abgeführt werden. Dann besitzt der austretende Stoff eine größere spezifische Entropie als der eintretende.
Quelle: 4.2.2
Abbildung: entropie-bilanz

### Was verbindet die Gibbs'sche Fundamentalgleichung?
Sie verknüpft Temperatur und spezifische Entropieänderung mit Änderungen der inneren Energie und des Volumens beziehungsweise der Enthalpie und des Drucks. Für einen einfachen kompressiblen Stoff gilt $T dif s=dif u+p dif v=dif h-v dif p$. Die Zustandsbeziehung bedeutet nicht, dass der tatsächliche Weg reversibel gewesen sein muss.
Quelle: 4.2.3
Abbildung: map-entropie

### Warum müssen in Entropieformeln Kelvin und absolute Drücke verwendet werden?
Die Logarithmen vergleichen absolute Zustandsgrößen. Ein Quotient von Celsius-Temperaturen oder von Überdrücken ist kein entsprechendes absolutes Verhältnis. Deshalb kann er auch bei scheinbar plausiblen Zahlen eine falsche Entropiedifferenz liefern.
Quelle: 4.3.1

### Warum verletzt die sinkende Entropie eines abkühlenden Stahlblocks nicht den zweiten Hauptsatz?
Der Block gibt Wärme und damit Entropie an die Umgebung ab. Seine Entropie darf deshalb sinken, weil er nicht adiabat ist. Beim vollständigen Vergleich erhält die Umgebung mehr Entropie, als der Block verliert; die positive Gesamtänderung zeigt die Irreversibilität.
Quelle: 4.3.1

### Warum ist der reale Austritt einer adiabaten Turbine enthalpiereicher als der isentrope Vergleich bei gleichem Enddruck?
Die reale Turbine gibt wegen innerer Irreversibilität weniger Wellenarbeit ab. Die entsprechend größere Energie bleibt mit dem austretenden Stoff erhalten. Gleichzeitig steigt seine spezifische Entropie; der isentrope Vergleich besitzt unveränderte spezifische Entropie.
Quelle: 4.3.3

### Warum ist entgangene isentrope Wellenleistung nicht automatisch dieselbe Größe wie eine genaue Dissipationsarbeit?
Die entgangene Wellenleistung ist eine Vergleichsdifferenz zwischen realem und isentropem Prozess mit gleichen Randzustandsvorgaben. Eine genaue Dissipationsarbeit enthält dagegen ein Integral entlang des inneren Prozesswegs. Ohne diesen Weg darf sie nicht mit einer erfundenen mittleren Temperatur aus der Entropiedifferenz berechnet werden.
Quelle: 4.3.3

### Warum ist eine Isentrope nicht in jedem Diagramm eine senkrechte Linie?
Eine Isentrope hält die spezifische Entropie konstant. Senkrecht ist sie nur dann unmittelbar, wenn diese Entropie die waagerechte Achse bildet, etwa im T-s- oder h-s-Diagramm. Bei anderen Achsen muss ihre Form aus dem Stoffdiagramm abgelesen werden.
Quelle: 4.4
Abbildung: zustandsdiagramme-achsen

### Was bedeutet eine Isovapore, und wo ist sie sinnvoll?
Sie verbindet Zustände mit gleichem Dampf-Massenanteil. Dieser Anteil beschreibt ein Flüssig-Dampf-Gemisch im Zweiphasengebiet. Er ist kein fortsetzbarer Dampfgehalt eines einphasig überhitzten Gases.
Quelle: 4.4

### Wann ist die Fläche unter einem T-s-Weg unmittelbar die übertragene spezifische Wärme?
Bei einem reversiblen Weg gilt $delta q_"rev"=T dif s$. Dann liefert die Fläche das Integral dieser Wärme. Bei einem irreversiblen Weg enthält die Entropieänderung zusätzlich Erzeugung; die Fläche darf deshalb nicht ungeprüft als tatsächliche Wärmezufuhr gelesen werden.
Quelle: 4.4
Abbildung: zustandsdiagramme-achsen

### Zeichne die Begriffslandkarte zu Kapitel 4 aus dem Kopf: Welche Begriffe gehören dazu und wie hängen sie zusammen?
Reversibilität betrifft die gemeinsame Rückkehr von System und Umgebung. Die Entropiebilanz verbindet Speicheränderung mit Transport durch Wärme und Stoff sowie nichtnegativer Erzeugung. Gibbs, Stoffmodelle und Tabellen liefern Entropiedifferenzen zwischen Zuständen. T-s-, h-s- und lg(p)-h-Diagramme zeigen diese Zusammenhänge über Achsen, Isolinien und Zustandswege; zusammen mit der Energiebilanz prüfen sie die mögliche Prozessrichtung.
Quelle: 4.4
Abbildung: map-entropie
