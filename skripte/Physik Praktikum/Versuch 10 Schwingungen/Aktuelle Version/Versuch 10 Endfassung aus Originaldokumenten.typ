// Versuch 10 Erzwungene Schwingungen
// Bearbeitbare Typst-Fassung der aktuellen DOCX.
// Beim Verschieben oder Hochladen den Ordner Typst-Abbildungen mitnehmen.
// Texte, Messwerttabellen und Formeln der Auswertung sind direkt bearbeitbar.

#set document(title: "Versuch 10 Erzwungene Schwingungen", author: "Mario Gotzler")
#set text(font: ("Calibri", "Carlito", "Arial"), size: 11pt, lang: "de")
#set par(justify: false, leading: 0.5em, spacing: 5pt)
#set page(paper: "a4", margin: (x: 22mm, y: 20mm), numbering: "1", number-align: right)
#set heading(numbering: none)
#show heading: it => block(above: 10pt, below: 5pt, sticky: true)[
  #text(size: if it.level == 1 {16pt} else if it.level == 2 {13pt} else {11pt}, weight: "bold", it.body)
]
#set math.equation(block: true)
#show math.equation: set text(size: 11pt)

#let original-page(file, cover: false) = page(
  paper: "a4",
  margin: if cover {0pt} else {(top: 13.5mm, bottom: 11mm, x: 5mm)},
  numbering: none,
  footer: none,
)[
  #align(center)[#image("Typst-Abbildungen/" + file, width: if cover {210mm} else {200mm})]
]

#let messwerttabelle(columns, ..cells) = block(above: 5pt, below: 8pt)[
  #set text(size: 9.5pt)
  #set par(leading: 0.3em, spacing: 0pt)
  #table(
    columns: columns, align: center + horizon,
    stroke: 0.4pt + rgb("#d9d9d9"), inset: (x: 4pt, y: 5pt),
    fill: (x, y) => if y == 0 {rgb("#eeeeee")},
    ..cells.pos(),
  )
]

// Originaldeckblatt mit THD-Abbildung
#original-page("Originaldeckblatt.png", cover: true)

// Originale Versuchsanleitung
#original-page("original-01.png")

#original-page("original-02.png")

#original-page("original-03.png")

#original-page("original-04.png")

#original-page("original-05.png")

#original-page("original-06.png")

#original-page("original-07.png")

// Handschriftliche Vorbereitung
#original-page("original-08.png")

#original-page("original-09.png")

// Handschriftliche Original-Messprotokolle
#original-page("original-10.png")

#original-page("original-11.png")

#original-page("original-12.png")

#original-page("original-13.png")

// Bearbeitbare Messwertübersicht und Auswertung

= 4 Messungen und Auswertung

=== Messprotokoll

Durchgeführt am 19.10.2026 im Physiklabor der TH Deggendorf. Auf dem Wagen lag ein Zusatzgewicht von 200 g. Die gesamte bewegte Masse ist nicht bekannt. Die Zeiten und Kraftamplituden haben wir mit Pasco Capstone abgelesen.

=== Messung 1 Ungedämpfte Schwingung

#messwerttabelle((1417fr, 1928fr, 1928fr, 4139fr,),
  table.header([*Durchlauf*], [*Start \[s\]*], [*Ende \[s\]*], [*Zeit für 10 Schwingungen \[s\]*]),
  [1], [4,950], [16,950], [12,000],
  [2], [6,150], [19,550], [13,400],
  [3], [5,300], [18,750], [13,450],
)

=== Messung 2 Große Dämpfung

#messwerttabelle((2324fr, 1417fr, 1417fr, 1417fr, 1417fr, 1417fr,),
  table.header([*Maximum*], [*1*], [*2*], [*3*], [*4*], [*5*]),
  [Durchlauf 1: t \[s\]], [3,25], [4,60], [5,90], [7,25], [8,50],
  [Durchlauf 1: A \[N\]], [0,803], [0,515], [0,297], [0,154], [0,041],
  [Durchlauf 2: t \[s\]], [4,90], [6,20], [7,55], [8,90], [10,20],
  [Durchlauf 2: A \[N\]], [0,923], [0,597], [0,374], [0,204], [0,080],
)

=== Messung 3 Geringe Dämpfung

#messwerttabelle((2324fr, 1417fr, 1417fr, 1417fr, 1417fr, 1417fr,),
  table.header([*Maximum*], [*1*], [*2*], [*3*], [*4*], [*5*]),
  [Durchlauf 1: t \[s\]], [3,15], [4,50], [5,80], [7,15], [8,50],
  [Durchlauf 1: A \[N\]], [0,948], [0,783], [0,619], [0,463], [0,327],
  [Durchlauf 2: t \[s\]], [6,20], [7,50], [8,80], [10,20], [11,50],
  [Durchlauf 2: A \[N\]], [0,853], [0,707], [0,538], [0,379], [0,259],
)

Die handschriftlichen Original-Messprotokolle stehen vor dieser Übersicht. Die Werte der erzwungenen Schwingung stehen außerdem in Abschnitt 4.3.

#pagebreak()

== 4.1 Bestimmung der Eigenfrequenz

Für jede Messung teilen wir die Zeit für zehn Schwingungen durch 10. Daraus ergeben sich die Periodendauer T, die Eigenfrequenz f₀ und die Eigenkreisfrequenz ω₀:

#messwerttabelle((2353fr, 2353fr, 2353fr, 2353fr,),
  table.header([*Durchlauf*], [*T \[s\]*], [*f₀ \[Hz\]*], [*ω₀ \[s⁻¹\]*]),
  [1], [1,200], [0,8333], [5,236],
  [2], [1,340], [0,7463], [4,689],
  [3], [1,345], [0,7435], [4,672],
)

$ overline(T) = frac("1,200" + "1,340" + "1,345", 3) thin upright(s) = "1,295" thin upright(s) $

$ f_0 = frac(1, overline(T)) = "0,7722" thin upright("Hz") quad ; quad ω_0 = 2 π f_0 = "4,8519" thin upright(s)^(-1) $

Die erste Messung ist deutlich kürzer als die beiden anderen. Bei der ersten Messung haben wir möglicherweise falsch gezählt oder einen anderen Zeitraum abgelesen. Das lässt sich nachträglich nicht sicher sagen. Deshalb rechnen wir zunächst mit allen drei Messungen weiter.

== 4.2 Bestimmung der Abklingkonstanten

In jeder Messreihe sind fünf Maxima notiert. Wir tragen die Amplituden halblogarithmisch über der Zeit auf. Für die Darstellung setzen wir beim ersten Maximum τ = 0. Aus der Ausgleichsgeraden lesen wir die Zeit τₑ ab, nach der die Amplitude auf den 1/e-ten Teil gefallen ist:

$ A(τ) = A_0 dot e^(-δ τ) quad ; quad δ = frac(1, τ_e) $

Zur Kontrolle passen wir zusätzlich eine Exponentialfunktion direkt an die fünf Amplituden an. Das ist ein Fit der Spitzenwerte. Die Parameter des in der Anleitung geforderten Capstone-Fits am vollständigen Schwingungsverlauf sind nicht im Messprotokoll notiert.

Die Zeitachse bleibt für die Bestimmung von δ linear. Nur die Amplitudenachse ist logarithmisch, wie in Abschnitt 10.5 der Versuchsanleitung gefordert.

#pagebreak()

== 4.2.1 Große Dämpfung

#align(center)[#image("Typst-Abbildungen/decay_strong_paper.png", width: 164mm)]

#text(size: 9pt)[Halblogarithmische Auftragung auf dem bereitgestellten Papier. Blau: Durchlauf 1, Rot: Durchlauf 2. Linien: Ausgleichsgeraden; Hilfslinien: Abfall auf 1/e.]

#messwerttabelle((2353fr, 2353fr, 2353fr, 2353fr,),
  table.header([*Durchlauf*], [*τₑ \[s\]*], [*δ = 1/τₑ \[s⁻¹\]*], [*δ aus direktem Fit \[s⁻¹\]*]),
  [1], [1,84], [0,543], [0,404],
  [2], [2,23], [0,448], [0,374],
)

$ δ_("groß") = frac("0,5427" + "0,4483", 2) thin upright(s)^(-1) = "0,496" thin upright(s)^(-1) $

Bei großer Dämpfung nimmt die Amplitude schnell ab. Die beiden Durchläufe ergeben 0,543 s⁻¹ und 0,448 s⁻¹. Der direkte Exponentialfit liegt mit durchschnittlich 0,389 s⁻¹ darunter. Besonders die letzten kleinen Amplituden weichen von der Geraden ab und beeinflussen die logarithmische Auswertung stark.

#pagebreak()

== 4.2.2 Geringe Dämpfung

#align(center)[#image("Typst-Abbildungen/decay_weak_paper.png", width: 164mm)]

#text(size: 9pt)[Halblogarithmische Auftragung auf dem bereitgestellten Papier. Blau: Durchlauf 1, Rot: Durchlauf 2. Die Geraden sind flacher als bei großer Dämpfung.]

#messwerttabelle((2353fr, 2353fr, 2353fr, 2353fr,),
  table.header([*Durchlauf*], [*τₑ \[s\]*], [*δ = 1/τₑ \[s⁻¹\]*], [*δ aus direktem Fit \[s⁻¹\]*]),
  [1], [5,03], [0,199], [0,185],
  [2], [4,42], [0,226], [0,207],
)

$ δ_("gering") = frac("0,1989" + "0,2263", 2) thin upright(s)^(-1) = "0,213" thin upright(s)^(-1) $

Bei geringer Dämpfung klingt die Schwingung langsamer ab. Der direkte Exponentialfit ergibt im Mittel 0,196 s⁻¹ und liegt näher an 0,213 s⁻¹. Bei großer Dämpfung ist δ ungefähr 2,3-mal so groß wie bei geringer Dämpfung.

#pagebreak()

== 4.3 Erzwungene Schwingung

Die Kreisfrequenzen und Amplituden wurden nach dem Einschwingen abgelesen. Für die Frequenz gilt f = Ω/(2π).

=== Große Dämpfung

#messwerttabelle((2353fr, 2353fr, 2353fr, 2353fr,),
  table.header([*U \[V\]*], [*Ω \[s⁻¹\]*], [*f \[Hz\]*], [*A \[N\]*]),
  [9,0], [0,512 \*], [0,0815], [0,0778],
  [7,0], [9,730], [1,5486], [0,0331],
  [5,0], [5,930], [0,9438], [0,0886],
  [4,5], [5,230], [0,8324], [0,1760],
  [4,2], [4,680], [0,7448], [0,3500],
  [4,0], [4,600], [0,7321], [0,1560],
  [3,5], [3,850], [0,6127], [0,1200],
  [3,0], [3,260], [0,5188], [0,0898],
  [2,0], [2,000], [0,3183], [0,0627],
)

=== Geringe Dämpfung

#messwerttabelle((2353fr, 2353fr, 2353fr, 2353fr,),
  table.header([*U \[V\]*], [*Ω \[s⁻¹\]*], [*f \[Hz\]*], [*A \[N\]*]),
  [9,0], [10,900], [1,7348], [0,0167],
  [7,0], [8,260], [1,3146], [0,0325],
  [5,0], [5,540], [0,8817], [0,1680],
  [4,7], [5,320], [0,8467], [0,2180],
  [4,4], [4,950], [0,7878], [0,6000],
  [4,1], [4,530], [0,7210], [0,6220],
  [4,0], [4,540], [0,7226], [0,5510],
  [3,8], [4,210], [0,6700], [0,2610],
  [3,5], [3,850], [0,6127], [0,1160],
)

\* Bei 9 V und großer Dämpfung ist 0,512 s⁻¹ notiert. Das passt nicht zu den übrigen Frequenzen. Wir übernehmen den Eintrag unverändert und markieren ihn im Diagramm. Für die Abschätzung der Güte verwenden wir diesen Punkt nicht.

#pagebreak()

== 4.3.1 Amplitudenfrequenzgänge

#align(center)[#image("Typst-Abbildungen/frequency_paper.png", width: 164mm)]

#text(size: 9pt)[Amplitudenfrequenzgänge auf dem bereitgestellten Papier, beide Achsen linear. Blau: große Dämpfung, Rot: geringe Dämpfung. Die Linien verbinden die Messpunkte.]

Die größte gemessene Amplitude beträgt bei großer Dämpfung 0,350 N und bei geringer Dämpfung 0,622 N. Bei geringer Dämpfung ist das Maximum damit etwa 1,78-mal so hoch.

#messwerttabelle((2353fr, 2353fr, 2353fr, 2353fr,),
  table.header([*Dämpfung*], [*Aᵣ \[N\]*], [*ωᵣ \[s⁻¹\]*], [*fᵣ \[Hz\]*]),
  [groß], [0,350], [4,68], [0,7448],
  [gering], [0,622], [4,53], [0,7210],
)

Die Resonanzfrequenzen entnehmen wir den höchsten gemessenen Punkten. Zwischen den Messpunkten kann das tatsächliche Maximum etwas anders liegen. Bei geringer Dämpfung liefern die fast gleichen Kreisfrequenzen 4,53 s⁻¹ und 4,54 s⁻¹ unterschiedliche Amplituden. Möglicherweise war der Einschwingvorgang noch nicht vollständig beendet.

#pagebreak()

== 4.3.2 Dämpfung aus der Resonanzverschiebung

Aus der Eigenkreisfrequenz und der Resonanzkreisfrequenz berechnen wir die Abklingkonstante mit:

$ δ_R = sqrt(frac(ω_0^2 - ω_r^2, 2)) $

$ δ_(R comma "groß") = sqrt(frac(("4,8519")^2 - ("4,68")^2, 2)) thin upright(s)^(-1) = "0,905" thin upright(s)^(-1) $

$ δ_(R comma "gering") = sqrt(frac(("4,8519")^2 - ("4,53")^2, 2)) thin upright(s)^(-1) = "1,229" thin upright(s)^(-1) $

#messwerttabelle((1417fr, 3997fr, 3997fr,),
  table.header([*Dämpfung*], [*δ aus freier Schwingung \[s⁻¹\]*], [*δ aus Resonanzlage \[s⁻¹\]*]),
  [groß], [0,496], [0,905],
  [gering], [0,213], [1,229],
)

Die Werte stimmen nicht überein. Außerdem ist die Reihenfolge vertauscht: Aus der Resonanzlage ergibt sich bei geringer Dämpfung ein größeres δ. Nach der Theorie müsste die Resonanzfrequenz bei geringer Dämpfung näher an der Eigenfrequenz liegen.

Ein Grund ist die ungenaue Eigenfrequenz. Rechnen wir nur mit den beiden längeren Perioden, erhalten wir ω₀ = 4,6802 s⁻¹. Dann wäre δ aus der Resonanzlage ungefähr 0,03 s⁻¹ beziehungsweise 0,83 s⁻¹. Schon eine kleine Änderung von ω₀ verändert das Ergebnis also stark. Die Resonanzverschiebung ist mit unseren Messwerten keine zuverlässige Methode zur Bestimmung der Dämpfung.

== 4.4 Dämpfungskonstante des Systems

Für c brauchen wir die gesamte bewegte Masse m. Bekannt ist nur das Zusatzgewicht von 0,200 kg. Deshalb können wir c nur abhängig von m angeben:

$ c = 2 m δ $

$ c_("groß") = ("0,991" thin upright(s)^(-1)) dot m quad ; quad c_("gering") = ("0,425" thin upright(s)^(-1)) dot m $

Dabei besteht m aus dem Wagen, dem Magneten, den übrigen mitbewegten Teilen und dem Zusatzgewicht. Das Zusatzgewicht allein wäre zu klein angesetzt.

#pagebreak()

== 4.5 Güte des Systems

Aus den Abklingkonstanten der freien Schwingung ergibt sich nach der Formel aus der Anleitung:

$ G = frac(ω_0, 2 δ) $

$ G_("groß") = frac("4,8519", 2 dot "0,4955") = "4,90" quad ; quad G_("gering") = frac("4,8519", 2 dot "0,2126") = "11,41" $

Für die Abschätzung aus der Amplitudenüberhöhung brauchen wir die Amplitude bei sehr langsamer Anregung. Bei großer Dämpfung nehmen wir dafür näherungsweise den niedrigsten unauffälligen Frequenzpunkt mit Ω = 2,0 s⁻¹ und A = 0,0627 N:

$ G_("Amplitude,groß") approx frac("0,350", "0,0627") = "5,58" $

5,58 liegt in derselben Größenordnung wie 4,90. Es ist nur eine grobe Abschätzung, weil Ω = 2,0 s⁻¹ noch nicht sehr klein gegenüber ω₀ ist.

Bei geringer Dämpfung ist der niedrigste Messpunkt mit Ω = 3,85 s⁻¹ bereits nahe an der Resonanz. Der Quotient 0,622/0,116 = 5,36 ist deshalb keine verlässliche Güte. Für einen Vergleich mit 11,41 hätten wir bei deutlich kleineren Frequenzen und gleicher Erregeramplitude messen müssen.

= 5 Fazit

#messwerttabelle((4082fr, 2665fr, 2665fr,),
  table.header([*Größe*], [*Große Dämpfung*], [*Geringe Dämpfung*]),
  [δ aus freiem Abklingen], [0,496 s⁻¹], [0,213 s⁻¹],
  [größte gemessene Amplitude], [0,350 N], [0,622 N],
  [Resonanzfrequenz], [0,7448 Hz], [0,7210 Hz],
  [Güte aus freiem Abklingen], [4,90], [11,41],
)

Der Einfluss der Dämpfung ist gut zu erkennen. Bei großer Dämpfung klingen die freien Schwingungen schneller ab. Bei geringer Dämpfung wird die Resonanzamplitude größer.

Die aus den Resonanzfrequenzen berechneten Abklingkonstanten passen dagegen nicht zu den freien Schwingungen. Die erste Zeitmessung und einzelne Werte im Resonanzbereich sind auffällig. Auch ein ungenauer Nullpunkt des Kraftsensors würde besonders die kleinen Amplituden beeinflussen. Für genauere Ergebnisse müssten wir die Eigenfrequenz erneut messen, im Resonanzbereich kleinere Frequenzschritte verwenden und länger auf das Einschwingen warten.
