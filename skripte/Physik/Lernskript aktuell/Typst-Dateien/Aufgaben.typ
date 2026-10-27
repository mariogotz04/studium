// Aufgaben zum Lernskript: Rechenaufgaben und Verständnisfragen mit Lösung Schritt für Schritt.
// Sie erscheinen auf der Webseite im Reiter „Lernen“; dort deckst du jeden Schritt einzeln auf.
// Diese Datei lässt sich zur Kontrolle direkt kompilieren (PDF mit allen Aufgaben und Lösungen).
//
// Aufbau:
//   #kapitel("Kapitel 1 · Grundbegriffe")          beginnt ein Kapitel
//   #aufgabe(titel: "Kurzer, eindeutiger Titel", art: "rechnen", quelle: "1.5",
//     ergebnis: [$c_2 = 4 c_1$],                     (optional) Endergebnis zum Vergleichen
//     tipp: [Was bleibt bei stationärer Strömung gleich?],   (optional) Denkanstoß
//   )[Aufgabentext][Schritt 1 …][Schritt 2 …][…]
// art: "rechnen" (Rechenaufgabe) oder "verstehen" (Verständnisfrage). quelle: Abschnitt im Lernskript.
// minuten: (optional) Bearbeitungszeit in einer Klausur, z. B. minuten: 20. Die Probeklausur auf der Webseite
// plant damit ihre Zeit; fehlt die Angabe, schätzt sie nach der Zahl der Lösungsschritte.
// Der Titel muss im Modul eindeutig bleiben: Daran hängt, ob die Aufgabe als gelöst markiert ist.
// Jeder Schritt beginnt mit einer fetten Kurzüberschrift (*Bilanz aufstellen:*) und erklärt im
// Feynman-Stil, *warum* man so vorgeht, nicht nur was gerechnet wird. Außerhalb von #aufgabe und
// #kapitel steht nichts (auf der Webseite wird jede Aufgabe und jeder Schritt einzeln gesetzt).
// ─── Kopf: nicht ändern ───────────────────────────────────────────────────────
#import "main.typ": *
#let web = "web" in sys.inputs
#let stelle(ziel) = {
  let teile = str(ziel).split("-").slice(1).filter(t => t.len() > 1 or t.match(regex("\d")) != none)
  let nr = teile.join(".")
  if nr.starts-with("tm") { nr = "TM" + nr.slice(2, 3) + " " + nr.slice(4) }
  [Abschnitt #nr]
}
#set document(title: "Aufgaben")
#set text(font: "Libertinus Serif", size: 11pt, lang: "de", fill: ink, hyphenate: true)
#set par(justify: false, leading: 0.55em, spacing: 0.75em)
#set list(indent: 0.6em, body-indent: 0.5em, spacing: 0.45em)
#set enum(indent: 0.6em, body-indent: 0.5em, spacing: 0.6em)
#set math.equation(numbering: none)
#show math.equation.where(block: true): it => block(above: 0.6em, below: 0.6em, breakable: false)[#it]
#set page(..if web { (width: 140mm, height: auto, margin: (x: 1.5mm, y: 2.5mm), header: none, footer: none, fill: none) }
  else { (paper: "a4", margin: (x: 20mm, y: 20mm), numbering: "1") })
#let _kapitel = state("aufgaben-kapitel", "")
#let kapitel(titel) = {
  _kapitel.update(titel)
  if not web { pagebreak(weak: true); text(size: 20pt, weight: "bold", fill: navy, titel); v(4mm) }
}
#let aufgabe(titel: none, art: "rechnen", quelle: none, ergebnis: none, tipp: none, minuten: none, ..teile) = {
  assert(titel != none, message: "Jede Aufgabe braucht einen titel")
  assert(art in ("rechnen", "verstehen"), message: "art ist \"rechnen\" oder \"verstehen\": " + titel)
  let teile = teile.pos()
  assert(teile.len() >= 2, message: "Aufgabe ohne Lösungsschritte: " + titel)
  let (text-aufgabe, ..schritte) = teile
  let info = context [#metadata((titel: titel, art: art, quelle: quelle, minuten: minuten, kapitel: _kapitel.get(),
    schritte: schritte.len(), ergebnis: ergebnis != none, tipp: tipp != none)) <aufgabe>]
  if web {
    // Jede Seite ist ein Baustein der Webseite: Aufgabe, Tipp, Ergebnis, dann die Schritte.
    pagebreak(weak: true)
    info
    text-aufgabe
    for teil in (tipp, ergebnis).filter(t => t != none) + schritte { pagebreak(); teil }
  } else {
    info
    block(breakable: false, above: 1.4em, below: 0.6em)[
      #text(weight: "bold", fill: navy, size: 12.5pt, titel)
      #h(1fr) #text(size: 8.5pt, fill: muted)[#if art == "rechnen" [Rechenaufgabe] else [Verständnisfrage]#if quelle != none [ · Abschnitt #quelle]]
      #v(1mm) #text-aufgabe
    ]
    if tipp != none { block(fill: sand, inset: 7pt, width: 100%)[*Tipp:* #tipp] }
    if ergebnis != none { block(fill: pale, inset: 7pt, width: 100%)[*Ergebnis:* #ergebnis] }
    block(stroke: (left: 2pt + teal), inset: (left: 9pt, y: 3pt), width: 100%)[
      #for (i, s) in schritte.enumerate() [
        #text(size: 8.5pt, fill: teal, weight: "bold")[SCHRITT #(i + 1) VON #schritte.len()] \
        #s
        #v(1mm)
      ]
    ]
  }
}
// ─── Ende Kopf ────────────────────────────────────────────────────────────────


#kapitel("Kapitel 5 · Schwingungen")

// 0-1
#aufgabe(titel: "Wie eine Schwebung entsteht", art: "verstehen", quelle: "5.4.1")[
#if not web [*Aufgabe 1* #linebreak()]
Erkläre, wann eine Schwebung entsteht und warum der Ton abwechselnd lauter und leiser wird.
][
Zwei ähnliche Frequenzen laufen in ihrer Phase langsam auseinander. Gleiche Phase verstärkt die gemeinsame Auslenkung, Gegenphase verringert sie. Dadurch verändert sich der Betrag der Hülle periodisch.

#src[L, Fragen 1 und 22, PDF-S. 8–11; LB, PDF-S. 1.]
]

// 0-2
#aufgabe(titel: "Träger, Hülle und Schwebungsfrequenz", art: "verstehen", quelle: "5.4.1")[
#if not web [*Aufgabe 2* #linebreak()]
Unterscheide $omega_m$, $omega_d$, $f_s$ und $T_s$. Warum besitzt die hörbare Schwebung den doppelten Takt der vorzeichenbehafteten Kosinushülle?
][
Der Träger hat $omega_m=(omega_1+omega_2)/2$. Die Kosinushülle hat $omega_d=abs(omega_1-omega_2)/2$. Ihr Betrag erreicht in einer Hüllenperiode zweimal ein Maximum; deshalb $f_s=abs(f_1-f_2)$ und $T_s=1/f_s$.

#src[L, Fragen 2–3 und K2–K5, PDF-S. 8, 10 und 15.]
]

// 0-3
#aufgabe(titel: "Saite mit der Stimmgabel stimmen", art: "verstehen", quelle: "5.4.1")[
#if not web [*Aufgabe 3* #linebreak()]
Beschreibe das Stimmen einer Saite mit einer Stimmgabel. Was sagt eine langsamer werdende Schwebung aus?
][
Die beiden Töne werden gleichzeitig erzeugt. Eine längere Schwebungsdauer zeigt eine kleinere Frequenzdifferenz. Verschwindet die Schwebung, stimmen die Frequenzen im Idealmodell überein. Aus der Differenz allein erkennt man noch nicht, welcher Ton höher ist.

#src[L, Frage 4, PDF-S. 8 und 10; LB, PDF-S. 1.]
]

// 0-4
#aufgabe(titel: "Bewegungsgleichungen gekoppelter Pendel", art: "verstehen", quelle: "5.4.2")[
#if not web [*Aufgabe 4* #linebreak()]
Stelle beide Bewegungsgleichungen für zwei identische gekoppelte Federpendel auf. Warum hängt die mittlere Feder vom Unterschied der Auslenkungen ab?
][
Es gilt $m dot.double(x)_1=-D x_1-D_k(x_1-x_2)$ und $m dot.double(x)_2=-D x_2-D_k(x_2-x_1)$. Die mittlere Feder reagiert auf die relative Abstandsänderung. Bei gleicher Verschiebung beider Massen bleibt ihre Länge gleich.

#src[L, Frage 5 und K7, PDF-S. 8, 10 und 15.]
]

// 0-5
#aufgabe(titel: "Summe und Differenz als neue Koordinaten", art: "verstehen", quelle: "5.4.2")[
#if not web [*Aufgabe 5* #linebreak()]
Warum verwendet man Summe und Differenz? Beschreibe auch den Weg zurück zu $x_1$ und $x_2$.
][
Mit $psi_1=x_1+x_2$ und $psi_2=x_1-x_2$ entstehen zwei unabhängige harmonische Gleichungen. Ihre Lösungen können getrennt bestimmt werden. Anschließend liefern $x_1=(psi_1+psi_2)/2$ und $x_2=(psi_1-psi_2)/2$ die ursprünglichen Bewegungen.

#src[L, Frage 6 und K8, PDF-S. 8, 10 und 15; LB, Frage 4, PDF-S. 2.]
]

// 0-6
#aufgabe(titel: "Gleichtakt und Gegentakt", art: "verstehen", quelle: "5.4.2")[
#if not web [*Aufgabe 6* #linebreak()]
Vergleiche Gleich- und Gegentakt: Wie bewegen sich die Massen, was macht die mittlere Feder, und woher kommt $2D_k$?
][
Im Gleichtakt ist $x_1=x_2$, die Kopplungsfeder bleibt ungedehnt und $omega_"gl"=sqrt(D/m)$. Im Gegentakt ist $x_1=-x_2$; zu einer Massenauslenkung $x$ gehört eine relative Dehnung von $2x$. Daher $omega_"gg"=sqrt((D+2D_k)/m)>omega_"gl"$ für $D_k>0$.

#src[L, Fragen 7 und 24, PDF-S. 8–10; LB, Frage 3, PDF-S. 2.]
]

// 0-7
#aufgabe(titel: "Energieaustausch zwischen zwei Pendeln", art: "verstehen", quelle: "5.4.3")[
#if not web [*Aufgabe 7* #linebreak()]
Ein Pendel wird ausgelenkt und losgelassen, das zweite ist anfangs in Ruhe. Erkläre den Wechsel der Hüllkurven und die Bedeutung von $T_s$.
][
Beide Eigenmoden sind angeregt. Ihre leicht verschiedenen Frequenzen überlagern sich in jeder Pendelbewegung. Die Hüllen wechseln sich ab; $T_s=2pi/(omega_"gg"-omega_"gl")$ beschreibt einen vollständigen Austauschzyklus. Eine einzelne Auslenkung null ist dabei kein Beweis für Energie null.

#src[L, Frage 8 und K11, PDF-S. 8, 10 und 16; LB, Frage 5, PDF-S. 2; Präzisierung ergänzt.]
]

// 0-8
#aufgabe(titel: "Härtere oder weichere Kopplungsfeder", art: "verstehen", quelle: "5.4.3")[
#if not web [*Aufgabe 8* #linebreak()]
Was verändert eine härtere oder weichere Kopplungsfeder an beiden Eigenkreisfrequenzen und an der Austauschdauer?
][
Härteres $D_k$ lässt den Gleichtakt unverändert und erhöht den Gegentakt. Die Differenz wächst, $T_s$ sinkt. Eine weichere Kopplung wirkt umgekehrt; für $D_k=0$ sind die Schwinger entkoppelt und es gibt keinen solchen Austausch.

#src[L, Frage 25 und Üben 13a, PDF-S. 9, 11 und 13–14; LB, Frage 6, PDF-S. 2.]
]

// 0-9
#aufgabe(titel: "Drei Pendel und die lange Kette", art: "verstehen", quelle: "5.4.3")[
#if not web [*Aufgabe 9* #linebreak()]
Wie viele Eigenmoden besitzen drei linear gekoppelte Pendel mit je einem Freiheitsgrad? Was ist beim Übergang zu einer langen Kette der neue Gedanke?
][
Drei Pendel besitzen drei Eigenmoden. Bei einer langen Kette kann eine Störung von Nachbar zu Nachbar weiterwandern. Das führt von der gemeinsamen Schwingungsform zur räumlichen Ausbreitung einer Welle.

#src[LB, Frage 7, PDF-S. 2; L, K12, PDF-S. 16; V1, PDF-S. 6–7.]
]

// 0-10
#aufgabe(titel: "Schwebung bei ungleichen Amplituden", art: "verstehen", quelle: "5.4.1")[
#if not web [*Aufgabe 10* #linebreak()]
Braucht eine Schwebung gleiche Amplituden? Was passiert bei exakt gleichen Frequenzen?
][
Gleiche Amplituden sind für das periodische An- und Abschwellen nicht zwingend, aber für vollständige Auslöschung nötig. Bei exakt gleichen Frequenzen bleibt die Phasendifferenz konstant: Es entsteht keine langsame Schwebung.

#src[L, Frage 22, PDF-S. 9 und 11; eigene Erläuterung.]
]

// 0-11
#aufgabe(titel: "Schwebung zweier Stimmgabeln", art: "rechnen", quelle: "5.4.1",
  ergebnis: [$f_m = "441,5" thin "Hz"$, $T_s approx "0,333" thin "s"$, $omega_d approx "9,42" thin "s"^(-1)$, 30 Schwebungen in 10 s],
  tipp: [Der Träger liegt in der Mitte der beiden Frequenzen, die hörbare Schwebung beim Abstand.],
)[
#if not web [*Aufgabe 11* #linebreak()]
*Gegeben und Annahmen*

Stimmgabeln mit 440 Hz und 443 Hz

*Gesucht*

#enum(numbering: "a)",
[Bestimme $f_m$, $T_s$, $omega_d$ und die Zahl der Schwebungen in 10 s.],
)
][
*Bild:* Zwei fast gleiche Töne laufen wie zwei Läufer mit leicht verschiedenem Tempo. Mal sind sie im Gleichschritt (laut), mal gegeneinander (leise). Was du als Tonhöhe hörst, ist der Mittelwert; das An- und Abschwellen kommt vom Unterschied.
][
*Träger:* $f_m = (440 + 443)\/2 = "441,5" thin "Hz"$.
][
*Schwebung:* Der Gleichschritt wiederholt sich so oft, wie die Frequenzen auseinanderliegen: $f_s = abs(f_1 - f_2) = 3 thin "Hz"$, also $T_s = 1\/f_s approx "0,333" thin "s"$.
][
*Hüllkreisfrequenz:* Die Kosinushülle läuft mit der halben Differenz: $omega_d = 2 pi dot abs(f_1 - f_2)\/2 = pi dot 3 thin "s"^(-1) approx "9,42" thin "s"^(-1)$. Ihr Betrag hat pro Periode zwei Maxima; deshalb hört man $f_s$, nicht $omega_d\/(2 pi)$.
][
*Anzahl und Prüfung:* In 10 s: $10 thin "s" dot 3 thin "Hz" = 30$ Schwebungen. Drei Lautstärkemaxima pro Sekunde passen zu 3 Hz Abstand.
#src[L, Frage 15, PDF-S. 8 und 11; Zahlenbeispiel aus L.]
]

// 0-12
#aufgabe(titel: "Saite zu tief oder zu hoch?", art: "rechnen", quelle: "5.4.1",
  ergebnis: [438 Hz oder 442 Hz möglich; es war 438 Hz],
  tipp: [Die Schwebung verrät nur den Abstand, nicht die Richtung. Was macht Spannen mit der Frequenz?],
)[
#if not web [*Aufgabe 12* #linebreak()]
*Gegeben und Annahmen*

Beim Stimmen mit 440 Hz hörst du alle 0,5 s ein Anschwellen.

*Gesucht*

#enum(numbering: "a)",
[Welche zwei Saitenfrequenzen sind möglich? Beim stärkeren Spannen wird die Schwebung langsamer: Welche war es?],
)
][
*Abstand bestimmen:* Ein Anschwellen alle 0,5 s heißt $f_s = 1\/"0,5" thin "s" = 2 thin "Hz"$.
][
*Zwei Möglichkeiten:* Die Saite liegt 2 Hz neben der Stimmgabel, also bei *438 Hz oder 442 Hz*. Das Ohr hört nur den Betrag.
][
*Richtung durch Probieren:* Mehr Spannung erhöht die Wellengeschwindigkeit auf der Saite und damit die Frequenz. Wird die Schwebung dabei langsamer, wird der Abstand kleiner; die Saite nähert sich also von unten. Sie hatte *438 Hz*.
][
*Prüfen:* Läge sie bei 442 Hz, würde Spannen den Abstand vergrößern und die Schwebung schneller machen.
#src[L, Frage 16, PDF-S. 8 und 11; zur Saitenspannung VB, PDF-S. 20.]
]

// 0-13
#aufgabe(titel: "Eigenfrequenzen gekoppelter Federpendel", art: "rechnen", quelle: "5.4.2")[
#if not web [*Aufgabe 13* #linebreak()]
*Gegeben und Annahmen*

Zwei gekoppelte Federpendel haben $m="0,5" thin "kg"$, $D=50 thin "N/m"$ und $D_k=5 thin "N/m"$.

*Gesucht*

#enum(numbering: "a)",
[Bestimme beide Eigenkreisfrequenzen, ihre Frequenzen und $T_s$.],
)
][
*Modell:* identische lineare Schwinger, ungedämpft.
][
$omega_"gl"=sqrt(50/"0,5")=10 thin "s"^(-1)$.
][
$omega_"gg"=sqrt(60/"0,5")=sqrt(120) approx "10,954" thin "s"^(-1)$.
][
Division durch $2pi$ ergibt $f_"gl" approx "1,592" thin "Hz"$ und $f_"gg" approx "1,743" thin "Hz"$.
][
$T_s=2pi/(sqrt(120)-10) approx "6,583" thin "s"$.
][
*Ergebnis: $T_s approx "6,58" thin "s"$.* Prüfung: Gegentakt schneller; $D/m$ hat die Einheit s⁻².

#src[L, Frage 17, PDF-S. 8 und 11; eigenes Nachrechnen.]
]

// 0-14
#aufgabe(titel: "Kopplungsfeder für 10 s Austausch", art: "rechnen", quelle: "5.4.3")[
#if not web [*Aufgabe 14* #linebreak()]
*Gegeben und Annahmen*

Für $m="0,5" thin "kg"$ und $D=50 thin "N/m"$ soll ein Austauschzyklus 10 s dauern.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $D_k$.],
)
][
*Modell:* gleiche Voraussetzungen wie zuvor; $T_s$ ist ein vollständiger Zyklus.
][
$omega_"gl"=10 thin "s"^(-1)$.
][
$omega_"gg"=omega_"gl"+2pi/T_s=10+2pi/10 approx "10,628" thin "s"^(-1)$.
][
Aus $m omega_"gg"^2=D+2D_k$ folgt $D_k=(m omega_"gg"^2-D)/2 approx "3,240" thin "N/m"$.
][
*Ergebnis: $D_k approx "3,24" thin "N/m"$.* Prüfung: Die weichere Kopplung gegenüber 5 N/m verlängert den Zyklus.

#src[L, Frage 18, PDF-S. 8 und 11; eigenes Nachrechnen.]
]

// 0-15
#aufgabe(titel: "Schwebung bei 300 und 304 Hz", art: "rechnen", quelle: "5.4.1",
  ergebnis: [$f_m = 302 thin "Hz"$, $T_s = "0,25" thin "s"$, $omega_d = 4 pi thin "s"^(-1)$],
)[
#if not web [*Aufgabe 15* #linebreak()]
*Gegeben und Annahmen*

Zwei harmonische Schwingungen mit 300 Hz und 304 Hz.

*Gesucht*

#enum(numbering: "a)",
[Bestimme Trägerfrequenz, Schwebungsdauer und $omega_d$.],
)
][
*Träger:* Mittelwert der beiden Frequenzen, $f_m = 302 thin "Hz"$.
][
*Schwebungsdauer:* $f_s = 4 thin "Hz"$, also $T_s = 1\/(4 thin "Hz") = "0,25" thin "s"$.
][
*Hüllkreisfrequenz:* $omega_d = 2 pi dot (304 - 300)\/2 thin "s"^(-1) = 4 pi thin "s"^(-1)$.
][
*Die Falle:* $omega_d$ ist *nicht* $2 pi f_s = 8 pi thin "s"^(-1)$. Die Hülle $cos(omega_d t)$ hat pro Periode zwei Betragsmaxima, deshalb ist der hörbare Rhythmus doppelt so schnell wie die Hülle selbst.
#src[L, Frage 23, PDF-S. 9 und 11; als offene Aufgabe übernommen.]
]

// 0-16
#aufgabe(titel: "Schwebungen pro Minute", art: "rechnen", quelle: "5.4.1",
  ergebnis: [$f_m = 514 thin "Hz"$, $T_s = "0,25" thin "s"$, 240 Schwebungen pro Minute],
)[
#if not web [*Aufgabe 16* #linebreak()]
*Gegeben und Annahmen*

Zwei Stimmgabeln haben 512 Hz und 516 Hz.

*Gesucht*

#enum(numbering: "a)",
[Bestimme die Trägerfrequenz, $T_s$ und die Zahl der Schwebungen pro Minute.],
)
][
*Träger:* $f_m = (512 + 516)\/2 = 514 thin "Hz"$. Das ist die Tonhöhe, die du hörst.
][
*Schwebung:* $f_s = 516 - 512 = 4 thin "Hz"$, also $T_s = "0,25" thin "s"$.
][
*Pro Minute:* $60 thin "s" dot 4 thin "Hz" = 240$ Schwebungen. *Prüfen:* $60\/"0,25" = 240$.
#src[L, Üben 1, PDF-S. 12–13; eigene Zahlen aus L.]
]

// 0-17
#aufgabe(titel: "Austauschdauer gekoppelter Pendel", art: "rechnen", quelle: "5.4.2",
  ergebnis: [$omega_"gl" = 10 thin "s"^(-1)$, $omega_"gg" approx "10,488" thin "s"^(-1)$, $T_s approx "12,87" thin "s"$],
  tipp: [Im Gleichtakt bleibt die Kopplungsfeder ungedehnt, im Gegentakt wirkt sie doppelt.],
)[
#if not web [*Aufgabe 17* #linebreak()]
*Gegeben und Annahmen*

Für $m="0,2" thin "kg"$, $D=20 thin "N/m"$ und $D_k=1 thin "N/m"$

*Gesucht*

#enum(numbering: "a)",
[Bestimme beide Eigenkreisfrequenzen und die Austauschdauer.],
)
][
*Gleichtakt:* Beide Massen bewegen sich gleich, die mittlere Feder wird nicht gedehnt. Jede Masse spürt nur ihre eigene Feder: $omega_"gl" = sqrt(D\/m) = sqrt(20\/"0,2") = 10 thin "s"^(-1)$.
][
*Gegentakt:* Die Massen bewegen sich gegeneinander; die Kopplungsfeder wird an beiden Enden gezogen, ihre Kraft zählt doppelt: $omega_"gg" = sqrt((D + 2 D_k)\/m) = sqrt(22\/"0,2") = sqrt(110) approx "10,488" thin "s"^(-1)$.
][
*Austausch:* Die Energie wandert im Rhythmus der Differenz der beiden Eigenkreisfrequenzen hin und her: $T_s = 2 pi\/(omega_"gg" - omega_"gl") approx 2 pi\/"0,488" thin "s" approx "12,87" thin "s"$.
][
*Prüfen:* Eine schwache Kopplung erzeugt einen kleinen Unterschied und damit einen langsamen Austausch, viel langsamer als die Einzelschwingung mit etwa 0,6 s.
#src[L, Üben 2, PDF-S. 12–13.]
]

// 0-18
#aufgabe(titel: "Zweite Orgelpfeife bestimmen", art: "rechnen", quelle: "5.4.1",
  ergebnis: [217 Hz oder 223 Hz],
)[
#if not web [*Aufgabe 18* #linebreak()]
*Gegeben und Annahmen*

In 2 s hörst du sechs Schwebungen zweier Orgelpfeifen. Eine Pfeife hat 220 Hz.

*Gesucht*

#enum(numbering: "a)",
[Welche Frequenzen sind für die zweite möglich?],
)
][
*Schwebungsfrequenz:* Sechs Schwebungen in 2 s sind $f_s = 6\/(2 thin "s") = 3 thin "Hz"$.
][
*Mögliche Frequenzen:* Die zweite Pfeife liegt 3 Hz neben 220 Hz, also bei *217 Hz oder 223 Hz*.
][
*Prüfen:* Beide Abstände betragen 3 Hz. Welche richtig ist, lässt sich aus der Schwebung allein nicht entscheiden; dazu müsste man eine Pfeife leicht verstimmen und beobachten, ob die Schwebung schneller oder langsamer wird.
#src[L, Üben 4, PDF-S. 12–13.]
]

// 0-19
#aufgabe(titel: "Federkonstanten aus gemessenen Frequenzen", art: "rechnen", quelle: "5.4.2",
  ergebnis: [$D = 36 thin "N/m"$, $D_k = "3,125" thin "N/m"$, $T_s approx "12,57" thin "s"$],
)[
#if not web [*Aufgabe 19* #linebreak()]
*Gegeben und Annahmen*

Für zwei identische gekoppelte Pendel mit $m=1 thin "kg"$ werden $omega_"gl"=6 thin "s"^(-1)$ und $omega_"gg"="6,5" thin "s"^(-1)$ gemessen.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $D$, $D_k$ und $T_s$.],
)
][
*Rückwärts denken:* Im Gleichtakt wirkt nur $D$, also $m omega_"gl"^2 = D$: $D = 1 dot 6^2 = 36 thin "N/m"$.
][
*Kopplung:* Im Gegentakt wirken $D + 2 D_k$: $m omega_"gg"^2 = D + 2 D_k$. Daraus $D_k = m(omega_"gg"^2 - omega_"gl"^2)\/2 = ("42,25" - 36)\/2 = "3,125" thin "N/m"$.
][
*Austauschdauer:* $T_s = 2 pi\/("6,5" - 6) thin "s" = 4 pi thin "s" approx "12,57" thin "s"$.
][
*Prüfen:* $sqrt((36 + "6,25")\/1) = sqrt("42,25") = "6,5" thin "s"^(-1)$, genau der Messwert.
#src[L, Üben 5, PDF-S. 12–13.]
]

// 0-20
#aufgabe(titel: "Verstimmung beim Klavier", art: "rechnen", quelle: "5.4.1",
  ergebnis: [Verstimmung 1,25 Hz; 260,35 Hz oder 262,85 Hz; 75-mal pro Minute],
)[
#if not web [*Aufgabe 20* #linebreak()]
*Gegeben und Annahmen*

Ein Klavierstimmer hört bei einer Referenzsaite von 261,6 Hz eine Schwebungsdauer von 0,8 s.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist die Verstimmung, welche Frequenzen sind möglich und wie oft schwillt der Ton pro Minute an?],
)
][
*Verstimmung:* Die Schwebungsfrequenz ist der Frequenzabstand: $f_s = 1\/"0,8" thin "s" = "1,25" thin "Hz"$.
][
*Mögliche Frequenzen:* $"261,6" plus.minus "1,25"$, also *260,35 Hz oder 262,85 Hz*.
][
*Pro Minute:* $60\/"0,8" = 75$ Anschwellvorgänge.
][
*Prüfen:* Die Schwebung liefert nur den Betrag. Ob die Saite zu hoch oder zu tief ist, zeigt erst eine kleine Änderung der Spannung.
#src[L, Üben 7, PDF-S. 12–13.]
]

// 0-21
#aufgabe(titel: "Kopplungsfeder für 5 s Austausch", art: "rechnen", quelle: "5.4.2",
  ergebnis: [$D_k approx "5,342" thin "N/m"$],
  tipp: [Aus $T_s$ bekommst du die nötige Differenz der Eigenkreisfrequenzen.],
)[
#if not web [*Aufgabe 21* #linebreak()]
*Gegeben und Annahmen*

Bei $m="0,4" thin "kg"$ und $D=40 thin "N/m"$ soll ein vollständiger Austauschzyklus 5 s dauern.

*Gesucht*

#enum(numbering: "a)",
[Wie groß muss $D_k$ sein?],
)
][
*Gleichtakt liegt fest:* $omega_"gl" = sqrt(40\/"0,4") = 10 thin "s"^(-1)$; die Kopplung ändert ihn nicht.
][
*Nötige Differenz:* $T_s = 2 pi\/(omega_"gg" - omega_"gl")$ ergibt $omega_"gg" = 10 + 2 pi\/5 approx "11,257" thin "s"^(-1)$.
][
*Kopplungsfeder:* Aus $m omega_"gg"^2 = D + 2 D_k$ folgt $D_k = ("0,4" dot "11,257"^2 - 40)\/2 approx "5,342" thin "N/m"$.
][
*Prüfen:* Ein schnellerer Austausch als in den anderen Beispielen braucht eine stärkere Kopplung. Rückeinsetzen ergibt wieder die Differenz $2 pi\/5 thin "s"^(-1)$.
#src[L, Üben 8, PDF-S. 12–13.]
]

// 0-22
#aufgabe(titel: "Träger und Anschwellrhythmus", art: "rechnen", quelle: "5.4.1",
  ergebnis: [$f_m = 258 thin "Hz"$, $f_s = 4 thin "Hz"$, $T_s = "0,25" thin "s"$],
)[
#if not web [*Aufgabe 22* #linebreak()]
*Gegeben und Annahmen*

Stimmgabeln mit 256 Hz und 260 Hz

*Gesucht*

#enum(numbering: "a)",
[Bestimme den schnellen Träger und den langsamen Anschwellrhythmus.],
)
][
*Schneller Träger:* Die Luft schwingt mit dem Mittelwert, $f_m = 258 thin "Hz"$.
][
*Langsamer Rhythmus:* Lautstärke schwillt mit $f_s = 4 thin "Hz"$ an, also alle $T_s = "0,25" thin "s"$.
][
*Prüfen:* 4 Hz ist der Anschwellrhythmus, nicht die Schwingung selbst; 4 Hz wären als Ton gar nicht hörbar.
#src[LB, Fragen 1–2, PDF-S. 2; in offene Rechenaufgabe umgestellt.]
]

// 0-23
#aufgabe(titel: "Fledermausdetektor", art: "rechnen", quelle: "5.4.1")[
#if not web [*Aufgabe 23* #linebreak()]
*Gegeben und Annahmen*

Ein ruhender Abendsegler erzeugt 20 kHz. Der Fledermausdetektor ist auf einen lokalen Oszillator von 21 kHz eingestellt.

*Gesucht*

#enum(numbering: "a)",
[Welche Frequenzdifferenz ergibt sich? Ordne sie gegenüber der Trägerfrequenz ein.],
)
][
Die Differenz beträgt *$f_s=abs(21000-20000)=1000 thin "Hz"$*. Die arithmetische Trägerfrequenz einer reinen Addition wäre 20,5 kHz. Die Aufgabe bezeichnet den im Detektor nutzbaren Differenzanteil als hörbare Schwebung; 1 kHz darf hier nicht mit der Trägerfrequenz verwechselt werden. Prüfung: Es wird kein Doppler-Effekt benötigt, weil die Quelle ruht.

#src[AS 1.3, Teil 2, PDF-S. 12; Lösung 4.3, PDF-S. 48; Präzisierung ergänzt.]
]

// 0-24
#aufgabe(titel: "Federsitz: Masse aus der Periodendauer", art: "rechnen", quelle: "5.0")[
#if not web [*Aufgabe 24* #linebreak()]
*BMMD, K17/18 Aufgabe 1:*

*Gegeben und Annahmen*

Ein reibungsfreier Sitz von 4 kg ist an einer Feder befestigt. Mit Pete (75 kg) beträgt $T_1=2 thin "s"$.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $D$ und die Periodendauer mit Mary (60 kg).],
[Welche Zeitänderung entspricht 1 kg Massenabnahme bei Pete?],
[Ändert ein gleichmäßiges Schwerefeld die ideale Periodendauer?],
)
][
*Modell:* horizontaler linearer Federoszillator; die Sitzmasse schwingt mit.
][
Kalibrierung: $D=4pi^2 (75+4)/(2 thin "s")^2 approx "779,70" thin "N/m"$.
][
Mary: $T_2=2pi sqrt((60+4)/D)=2sqrt(64/79) thin "s" approx "1,800" thin "s"$.
][
Pete mit 74 kg: $T_3=2sqrt(78/79) thin "s" approx "1,98730" thin "s"$. Der Unterschied ist *$Delta T approx "0,01270" thin "s"="12,7" thin "ms"$*. Die Zeitmessung muss diesen Unterschied auflösen können.
][
Eine konstante zusätzliche Kraft verschiebt die Gleichgewichtslage, verändert aber im linearen Idealmodell $D$ und die schwingende Masse nicht. Die Periodendauer bleibt gleich.
][
*Prüfung:* Weniger Masse ergibt eine kürzere Periodendauer. Die Gesamtmasse ist stets Körpermasse plus 4 kg. Die handschriftliche Rundung auf „1,99 s“ reicht für Teil b allein nicht aus.

#src[K17/18, PDF-S. 1–2, als Bild gelesen; eigene überprüfte Rechnung.]
]


#kapitel("Kapitel 6 · Wellen")

// 1-25
#aufgabe(titel: "Von gekoppelten Pendeln zur Welle", art: "verstehen", quelle: "6.1")[
#if not web [*Aufgabe 25* #linebreak()]
Erkläre den Übergang von vielen gekoppelten Pendeln zu einer Welle. Was wird weitergegeben, und was bleibt lokal?
][
Die Kopplung überträgt die Störung und Energie an benachbarte Schwinger. Die Teilchen bewegen sich im behandelten Modell um ihre Ruhelage; sie wandern nicht mit dem Muster durch das ganze Medium.

#src[L, Frage 9 und K13, PDF-S. 8, 11 und 16; LB, PDF-S. 1.]
]

// 1-26
#aufgabe(titel: "Longitudinal und transversal", art: "verstehen", quelle: "6.1")[
#if not web [*Aufgabe 26* #linebreak()]
Vergleiche longitudinale und transversale Bewegung an Schall, Saite und Festkörper. Warum trägt Luft im behandelten Modell keine mechanische Scherwelle?
][
Longitudinal bedeutet Bewegung parallel zur Ausbreitung, transversal senkrecht dazu. Schall in Luft ist longitudinal, die Seilwelle transversal. Festkörper können beide Arten tragen. Luft besitzt im behandelten Modell keine elastische Scher-Rückstellwirkung für eine solche Transversalwelle.

#src[L, Fragen 10 und 26, PDF-S. 8–11; LB, Fragen 8–9, PDF-S. 2.]
]

// 1-27
#aufgabe(titel: "Laufrichtung von u(x − ct) und u(x + ct)", art: "verstehen", quelle: "6.1.1")[
#if not web [*Aufgabe 27* #linebreak()]
Begründe die Laufrichtung von $u(x-c t)$ und $u(x+c t)$ über einen Punkt gleicher Phase. Welche Modellvoraussetzung steckt in dieser Schreibweise?
][
Für ein festes Argument $a$ gilt zuerst $x=a+c t$: Bewegung nach $+x$. Im zweiten Fall ist $x=a-c t$: Bewegung nach $-x$. Die Form $u$ wird unverändert mit konstantem $c$ verschoben.

#src[L, Fragen 11 und 27, PDF-S. 8–11; LB, Frage 10, PDF-S. 2.]
]

// 1-28
#aufgabe(titel: "Schnelle und Ausbreitungsgeschwindigkeit", art: "verstehen", quelle: "6.2.1")[
#if not web [*Aufgabe 28* #linebreak()]
Unterscheide Schnelle und Ausbreitungsgeschwindigkeit. Wie kann ein Teilchen gerade stillstehen, obwohl die Welle weiterläuft?
][
Die Schnelle ist die lokale Zeitableitung der Auslenkung. Am Umkehrpunkt eines Teilchens ist sie null. Die Phase wandert trotzdem mit $c$ weiter, weil benachbarte Orte zeitversetzt denselben Zustand annehmen.

#src[L, Frage 12 und Üben 13c, PDF-S. 8, 11 und 13–14; LB, Frage 12, PDF-S. 2.]
]

// 1-29
#aufgabe(titel: "λ f = c herleiten", art: "verstehen", quelle: "6.2")[
#if not web [*Aufgabe 29* #linebreak()]
Leite $lambda f=c$ her. Was bestimmt das Medium, was die Quelle? Wie ändert sich $lambda$, wenn bei gleichem $f$ das Medium ein größeres $c$ erlaubt?
][
In $T=1/f$ rückt das Muster um $lambda$ vor, also $c=lambda/T=lambda f$. Die Quelle bestimmt den zeitlichen Takt; das Medium im Modell $c$. Bei gleichem $f$ wächst $lambda$ proportional zu $c$.

#src[L, Frage 13 und Üben 13d, PDF-S. 8, 11 und 13–14.]
]

// 1-30
#aufgabe(titel: "Warum harmonische Wellen?", art: "verstehen", quelle: "6.2")[
#if not web [*Aufgabe 30* #linebreak()]
Warum untersucht die Vorlesung harmonische Wellen, obwohl auch einzelne Pulse auftreten? Was sagt das Fourier-Theorem dabei aus?
][
Harmonische Wellen sind Bausteine, aus deren Überlagerung nicht sinusförmige Signale dargestellt werden können. Ein Puls muss selbst keine Sinusform besitzen. Das Theorem macht die einzelnen Anteile nützlich, nicht jede Gesamtwelle harmonisch.

#src[L, Frage 14 und K24, PDF-S. 8, 11 und 16; V1, PDF-S. 11.]
]

// 1-31
#aufgabe(titel: "Wellengeschwindigkeit auf der Saite verdoppeln", art: "verstehen", quelle: "6.3")[
#if not web [*Aufgabe 31* #linebreak()]
Welche Änderung von Zugkraft oder Dichte verdoppelt die Geschwindigkeit auf einer Saite? Begründe mit der Formel.
][
Bei festem $rho A$ muss $F$ vervierfacht werden. Bei festem $F,A$ muss $rho$ auf ein Viertel sinken. Denn $c=sqrt(F/(rho A))$.

#src[Eigene Verständnisfrage aus VB, PDF-S. 10, Gl. 6.4.]
]

// 1-32
#aufgabe(titel: "Intensität und Leistung", art: "verstehen", quelle: "6.4")[
#if not web [*Aufgabe 32* #linebreak()]
Vergleiche Intensität und Leistung. Warum ist bei doppelter Amplitude die Intensität viermal so groß?
][
Intensität ist Leistung pro senkrechter Fläche. Für die harmonische Welle gilt $I=1/2 rho c omega^2 u^2$. Der Faktor $u^2$ macht aus $2u$ den Faktor 4. Leistung ergibt sich bei gleichmäßigem $I$ aus $P=I F$.

#src[Eigene Verständnisfrage aus VB, PDF-S. 13–14.]
]

// 1-33
#aufgabe(titel: "Bedingung für Auslöschung", art: "verstehen", quelle: "6.5")[
#if not web [*Aufgabe 33* #linebreak()]
Welche Phasenlage und welcher Wegunterschied erzeugen bei gleichphasigen Quellen vollständige Auslöschung? Was muss für die Amplituden gelten?
][
Die relative Phase muss ein ungerades Vielfaches von $pi$ betragen. Ohne zusätzliche Anfangsphase ist $Delta l=(2j+1)lambda/2$. Vollständige Auslöschung braucht gleiche Amplituden am Beobachtungsort.

#src[K15, PDF-S. 4, Frage 12; Ü 10.5; offene Frage, eigene Erklärung.]
]

// 1-34
#aufgabe(titel: "Knoten und Bäuche der stehenden Welle", art: "verstehen", quelle: "6.6")[
#if not web [*Aufgabe 34* #linebreak()]
Leite aus $2A sin(k x)cos(omega t)$ Knoten- und Bauchabstände her. Was bedeutet „kein Nettoenergietransport“?
][
Knoten liegen bei $k x=j pi$, also im Abstand $pi/k=lambda/2$. Bäuche liegen dazwischen: Knoten–Bauch ist $lambda/4$. Die gleich starken gegenläufigen gemittelten Energieflüsse gleichen sich aus; Schwingungsenergie ist trotzdem vorhanden.

#src[Eigene Verständnisfrage aus VB, PDF-S. 17–19; Quellenfehler im Text korrigiert.]
]

// 1-35
#aufgabe(titel: "Reflexion am festen und losen Ende", art: "verstehen", quelle: "6.6.1")[
#if not web [*Aufgabe 35* #linebreak()]
Wie unterscheiden sich die Reflexion am festen und am losen Ende? Begründe den Knoten am festen Ende.
][
Am festen Ende kehrt der Puls invertiert zurück; die Gesamtbewegung muss dort zu jeder Zeit null sein. Am losen Ende findet im Idealmodell keine Inversion statt und die stehende Auslenkung besitzt einen Bauch.

#src[Eigene Verständnisfrage aus VB, PDF-S. 18.]
]

// 1-36
#aufgabe(titel: "Eigenmoden der drei Randfälle", art: "verstehen", quelle: "6.7.3")[
#if not web [*Aufgabe 36* #linebreak()]
Skizziere je drei Moden für fest–fest, fest–lose und lose–lose. Begründe die erlaubten Ordnungen und unterscheide Mode und Oberton.
][
Fest–fest: $sin(n pi x/L)$ mit $n=1,2,3$. Lose–lose: $cos(n pi x/L)$ mit $n=1,2,3$. Fest–lose: $sin(n pi x/(2L))$ mit $n=1,3,5$. Die Enden liefern Knoten oder Bäuche. Die Grundmode ist die niedrigste schwingende Mode; Obertöne sind die darüberliegenden. Siehe die Modenskizze in Abschnitt 6.7.3.

#src[Eigene Frage aus VB, PDF-S. 20–22; Ü 10.3; AS 1.1–1.2.]
]

// 1-37
#aufgabe(titel: "Wellenlängen des Hörbereichs", art: "rechnen", quelle: "6.2",
  ergebnis: [1,7 cm bis 17 m],
)[
#if not web [*Aufgabe 37* #linebreak()]
*Gegeben und Annahmen*

Für den in L angenommenen Hörbereich 20 Hz bis 20 kHz

*Gesucht*

#enum(numbering: "a)",
[Welcher Wellenlängenbereich folgt in Luft mit $c=340 thin "m/s"$?],
)
][
*Grundgleichung:* In einer Periode rückt die Welle um eine Wellenlänge vor, also $c = lambda f$ und $lambda = c\/f$.
][
*Tiefster Ton:* $lambda = 340\/20 thin "m" = 17 thin "m"$.
][
*Höchster Ton:* $lambda = 340\/20 thin 000 thin "m" = "0,017" thin "m" = "1,7" thin "cm"$.
][
*Prüfen:* Höhere Frequenz, kürzere Welle. Ein Bass hat die Länge eines Hauses, ein Pfeifton die Breite eines Fingers.
#src[L, Frage 19, PDF-S. 8 und 11; Hörgrenzen sind Aufgabenannahme.]
]

// 1-38
#aufgabe(titel: "Wellenfunktion ablesen", art: "rechnen", quelle: "6.2.1")[
#if not web [*Aufgabe 38* #linebreak()]
*Gegeben und Annahmen*

Gegeben ist $psi=2 thin "mm" · sin(4pi thin "m"^(-1)x-600pi thin "s"^(-1)t)$.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $lambda,f,T,c$, Laufrichtung und maximale Schnelle.],
)
][
*Modell:* harmonische laufende Welle.
][
Ablesen: $psi_0="0,002" thin "m"$, $k=4pi thin "m"^(-1)$, $omega=600pi thin "s"^(-1)$.
][
$lambda=2pi/k="0,5" thin "m"$, $f=omega/(2pi)=300 thin "Hz"$, $T=1/f approx "3,333" thin "ms"$.
][
$c=omega/k=150 thin "m/s"$; Minus vor $omega t$ bedeutet Ausbreitung nach $+x$.
][
$s_"max"=psi_0 omega approx "3,770" thin "m/s"$.
][
*Ergebnis: $c=150 thin "m/s"$, $s_"max" approx "3,77" thin "m/s"$.* Prüfung: $lambda f=150 thin "m/s"$; Schnelle und Ausbreitung sind verschieden.

#src[L, Frage 20, PDF-S. 8 und 11.]
]

// 1-39
#aufgabe(titel: "Geschwindigkeit eines Pulses", art: "rechnen", quelle: "6.2",
  ergebnis: [$c = 24 thin "m/s"$, $lambda = 3 thin "m"$],
)[
#if not web [*Aufgabe 39* #linebreak()]
*Gegeben und Annahmen*

Ein Puls legt 6 m in 0,25 s zurück.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $c$ und danach $lambda$ bei harmonischer Anregung mit 8 Hz.],
)
][
*Geschwindigkeit:* Weg durch Zeit, $c = 6 thin "m"\/"0,25" thin "s" = 24 thin "m/s"$. Sie gehört zum Medium und gilt auch für eine harmonische Welle.
][
*Wellenlänge:* $lambda = c\/f = 24\/8 thin "m" = 3 thin "m"$.
][
*Prüfen:* 8 Perioden pro Sekunde mal 3 m pro Periode ergeben 24 m pro Sekunde.
#src[L, Frage 21, PDF-S. 8 und 11.]
]

// 1-40
#aufgabe(titel: "Kenngrößen einer 50-Hz-Welle", art: "rechnen", quelle: "6.2",
  ergebnis: [$c = 200 thin "m/s"$, $T = 20 thin "ms"$, $k = pi\/2 thin "m"^(-1)$, $omega = 100 pi thin "s"^(-1)$],
)[
#if not web [*Aufgabe 40* #linebreak()]
*Gegeben und Annahmen*

Eine harmonische Welle besitzt $f=50 thin "Hz"$ und $lambda=4 thin "m"$.

*Gesucht*

#enum(numbering: "a)",
[Berechne $c,T,k,omega$.],
)
][
*Geschwindigkeit:* $c = lambda f = 4 dot 50 = 200 thin "m/s"$.
][
*Zeittakt:* $T = 1\/f = "0,020" thin "s"$ und $omega = 2 pi f = 100 pi thin "s"^(-1)$.
][
*Ortstakt:* Die Wellenzahl ist das räumliche Gegenstück zu $omega$: $k = 2 pi\/lambda = pi\/2 thin "m"^(-1)$.
][
*Prüfen:* $omega\/k = 100 pi\/(pi\/2) = 200 thin "m/s" = c$.
#src[L, Frage 28, PDF-S. 9 und 11; als offene Rechenaufgabe übernommen.]
]

// 1-41
#aufgabe(titel: "Wellenfunktion nach +x lesen", art: "rechnen", quelle: "6.2",
  ergebnis: [$lambda = 1 thin "m"$, $f = 50 thin "Hz"$, $c = 50 thin "m/s"$, Laufrichtung $+x$],
)[
#if not web [*Aufgabe 41* #linebreak()]
*Gegeben und Annahmen*

$psi=5 thin "mm" dot sin(2pi thin "m"^(-1)x-100pi thin "s"^(-1)t)$.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $lambda$, $f$, $c$ und die Laufrichtung.],
)
][
*Muster erkennen:* Vergleiche mit $psi = psi_0 sin(k x - omega t)$: $k = 2 pi thin "m"^(-1)$, $omega = 100 pi thin "s"^(-1)$.
][
*Umrechnen:* $lambda = 2 pi\/k = 1 thin "m"$, $f = omega\/(2 pi) = 50 thin "Hz"$, $c = omega\/k = 50 thin "m/s"$.
][
*Richtung:* Verschiedene Vorzeichen vor $x$ und $t$ bedeuten Ausbreitung nach $+x$: Für gleiche Phase muss $x$ mit $t$ wachsen.
][
*Prüfen:* $k lambda = 2 pi$ und $omega T = 2 pi$.
#src[L, Üben 3, PDF-S. 12–13.]
]

// 1-42
#aufgabe(titel: "Wellenfunktion nach −x aufstellen", art: "rechnen", quelle: "6.2",
  ergebnis: [$psi(x,t) = 1 thin "cm" · sin((2pi\/3) thin "m"^(-1) x + 8 pi thin "s"^(-1) t)$],
)[
#if not web [*Aufgabe 42* #linebreak()]
*Gegeben und Annahmen*

Eine Seilwelle mit $c=12 thin "m/s"$, $f=4 thin "Hz"$ und $psi_0=1 thin "cm"$ läuft nach $-x$, Anfangsphase null.

*Gesucht*

#enum(numbering: "a)",
[Stelle eine passende Wellenfunktion auf.],
)
][
*Bausteine:* $lambda = c\/f = 3 thin "m"$, also $k = 2 pi\/3 thin "m"^(-1)$; $omega = 2 pi f = 8 pi thin "s"^(-1)$.
][
*Richtung einbauen:* Nach $-x$ braucht man gleiche Vorzeichen vor $x$ und $t$: $sin(k x + omega t)$.
][
*Zusammensetzen:* $psi(x,t) = 1 thin "cm" · sin((2pi\/3) thin "m"^(-1) x + 8 pi thin "s"^(-1) t)$.
][
*Prüfen:* $omega\/k = 8 pi\/(2 pi\/3) = 12 thin "m/s"$. Mit Minuszeichen würde die Welle in die falsche Richtung laufen.
#src[L, Üben 6, PDF-S. 12–13.]
]

// 1-43
#aufgabe(titel: "Echolot in Wasser und Luft", art: "rechnen", quelle: "6.3",
  ergebnis: [Wasser 2,96 cm, Luft 6,8 mm],
)[
#if not web [*Aufgabe 43* #linebreak()]
*Gegeben und Annahmen*

Ein Echolot erzeugt 50 kHz.

*Gesucht*

#enum(numbering: "a)",
[Berechne $lambda$ in Wasser mit 1480 m/s und in Luft mit 340 m/s.],
[Warum bleibt beim ruhenden Medienwechsel die Frequenz erhalten?],
)
][
*Wasser:* $lambda = 1480\/50 thin 000 thin "m" = "0,0296" thin "m" = "2,96" thin "cm"$.
][
*Luft:* $lambda = 340\/50 thin 000 thin "m" = "0,0068" thin "m" = "6,8" thin "mm"$.
][
*Warum die Frequenz bleibt:* Die Grenzfläche wird im Takt der Quelle angestoßen und gibt genau diesen Takt weiter. Das Medium bestimmt nur, wie weit sich das Muster in einer Periode bewegt.
][
*Prüfen:* Das schnellere Medium hat bei gleicher Frequenz die längere Wellenlänge.
#src[L, Üben 9, PDF-S. 13; gleiche Idee wie Ü 10.1.]
]

// 1-44
#aufgabe(titel: "Welle nach −x mit maximaler Schnelle", art: "rechnen", quelle: "6.2",
  ergebnis: [$lambda = 4 thin "m"$, $f = 10 thin "Hz"$, $c = 40 thin "m/s"$, Richtung $-x$, $s_"max" approx "0,314" thin "m/s"$],
)[
#if not web [*Aufgabe 44* #linebreak()]
*Gegeben und Annahmen*

Für $psi="0,5" thin "cm" · sin("0,5" pi thin "m"^(-1)x+20pi thin "s"^(-1)t)$

*Gesucht*

#enum(numbering: "a)",
[Bestimme $lambda,f,c$, Laufrichtung und maximale Schnelle.],
)
][
*Ablesen:* $k = "0,5" pi thin "m"^(-1)$, $omega = 20 pi thin "s"^(-1)$, $psi_0 = "0,005" thin "m"$.
][
*Kenngrößen:* $lambda = 2 pi\/k = 4 thin "m"$, $f = omega\/(2 pi) = 10 thin "Hz"$, $c = omega\/k = 40 thin "m/s"$.
][
*Richtung:* Gleiche Vorzeichen vor $x$ und $t$: Ausbreitung nach $-x$.
][
*Schnelle:* Die Teilchengeschwindigkeit ist die Zeitableitung der Auslenkung; ihr Maximum ist $s_"max" = psi_0 omega = "0,005" dot 20 pi approx "0,314" thin "m/s"$. *Prüfen:* Die Amplitude erst in Meter umrechnen, sonst kommt cm/s heraus. Die Schnelle ist viel kleiner als $c$.
#src[L, Üben 10, PDF-S. 13.]
]

// 1-45
#aufgabe(titel: "Zwei Lautsprecher mit 680 und 684 Hz", art: "rechnen", quelle: "6.2",
  ergebnis: [$lambda_1 = "0,500" thin "m"$, $lambda_2 approx "0,49708" thin "m"$; $f_m = 682 thin "Hz"$, $T_s = "0,25" thin "s"$],
)[
#if not web [*Aufgabe 45* #linebreak()]
*Gegeben und Annahmen*

Zwei Lautsprecher schwingen mit 680 Hz und 684 Hz, $c=340 thin "m/s"$.

*Gesucht*

#enum(numbering: "a)",
[Berechne beide Wellenlängen sowie Trägerfrequenz und Anschwellrhythmus.],
)
][
*Wellenlängen:* $lambda = c\/f$: $lambda_1 = 340\/680 = "0,500" thin "m"$, $lambda_2 = 340\/684 approx "0,49708" thin "m"$.
][
*Schwebung:* Am Ohr überlagern sich beide Töne: Träger $f_m = 682 thin "Hz"$, Rhythmus $f_s = 4 thin "Hz"$, also $T_s = "0,25" thin "s"$.
][
*Prüfen:* Die etwas höhere Frequenz hat die etwas kürzere Wellenlänge. Hier verbinden sich Kapitel 5 (Schwebung) und Kapitel 6 (Welle).
#src[L, Üben 11, PDF-S. 13; Schwebung nach 5.4.1.]
]

// 1-46
#aufgabe(titel: "Welle in einer Pendelkette", art: "rechnen", quelle: "6.1",
  ergebnis: [$c = "2,5" thin "m/s"$, $lambda = "0,5" thin "m"$, longitudinal],
)[
#if not web [*Aufgabe 46* #linebreak()]
*Gegeben und Annahmen*

In einer Pendelkette beträgt der Abstand 5 cm, die Störung benötigt 0,02 s zum nächsten Pendel. Die Quelle schwingt mit 5 Hz; die Teilchen bewegen sich längs der Kette.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $c,lambda$ und die Wellenart.],
)
][
*Geschwindigkeit:* Die Störung springt 5 cm in 0,02 s weiter: $c = "0,05"\/"0,02" = "2,5" thin "m/s"$.
][
*Wellenlänge:* $lambda = c\/f = "2,5"\/5 = "0,5" thin "m"$.
][
*Wellenart:* Die Teilchen schwingen in Ausbreitungsrichtung, also *longitudinal*.
][
*Prüfen:* In einer Wellenlänge liegen $"0,5"\/"0,05" = 10$ Pendelabstände.
#src[L, Üben 12, PDF-S. 13.]
]

// 1-47
#aufgabe(titel: "Frequenz- und Kreisfrequenzdifferenz", art: "rechnen", quelle: "5.4.1",
  ergebnis: [$abs(f_1 - f_2) = 2 thin "Hz"$, $abs(omega_1 - omega_2) = 4 pi thin "s"^(-1) approx "12,566" thin "s"^(-1)$],
)[
#if not web [*Aufgabe 47* #linebreak()]
*Gegeben und Annahmen*

Bei zwei Stimmgabeln hörst du alle 0,5 s ein Anschwellen.

*Gesucht*

#enum(numbering: "a)",
[Berechne sowohl $abs(f_1-f_2)$ als auch $abs(omega_1-omega_2)$.],
)
][
*Frequenzdifferenz:* Der hörbare Rhythmus ist die Frequenzdifferenz: $1\/"0,5" thin "s" = 2 thin "Hz"$.
][
*Kreisfrequenzdifferenz:* Jede Frequenz wird mit $2 pi$ zur Kreisfrequenz, die Differenz auch: $2 pi dot 2 = 4 pi thin "s"^(-1) approx "12,566" thin "s"^(-1)$.
][
*Prüfen:* $2 thin "s"^(-1)$ als Kreisfrequenzdifferenz wäre ein Fehler um den Faktor $2 pi$.
#src[L, Üben 13b, PDF-S. 13–14; Bezug zu 5.4.1.]
]

// 1-48
#aufgabe(titel: "Ton von Wasser in Luft", art: "rechnen", quelle: "6.3",
  ergebnis: [$f = 256 thin "Hz"$ bleibt; $lambda_"Wasser" approx "5,859" thin "m"$, $lambda_"Luft" approx "1,328" thin "m"$; $lambda = 2 thin "m"$],
)[
#if not web [*Aufgabe 48* #linebreak()]
*Medienwechsel, Ü 10.1:*

*Gegeben und Annahmen*

Ein Ton mit 256 Hz breitet sich unter Wasser mit 1500 m/s aus und tritt in Luft mit 340 m/s über.

*Gesucht*

#enum(numbering: "a)",
[Was geschieht mit Frequenz und Wellenlänge?],
[Berechne zusätzlich die Wellenlänge bei 340 m/s und 170 Hz aus dem bisherigen Lernblatt.],
)
][
*Frequenz:* Die Grenzfläche gibt den Takt unverändert weiter: $f = 256 thin "Hz"$ in beiden Medien.
][
*Wellenlängen:* $lambda_"Wasser" = 1500\/256 approx "5,859" thin "m"$, $lambda_"Luft" = 340\/256 approx "1,328" thin "m"$. Die Welle wird kürzer, weil sie in Luft langsamer ist.
][
*Zusatz:* $lambda = 340\/170 = 2 thin "m"$.
][
*Prüfen:* Das Verhältnis der Wellenlängen ist $340\/1500$, genau das Verhältnis der Geschwindigkeiten.
#src[Ü 10.1, PDF-S. 1; R, PDF-S. 1; LB, Frage 11, PDF-S. 2; als offene Aufgabe übernommen.]
]

// 1-49
#aufgabe(titel: "Wann erreicht die Welle die Ente?", art: "rechnen", quelle: "6.2",
  ergebnis: [$t approx "4,17" thin "s"$],
  tipp: [Die Amplitude ist eine Ablenkung; für die Laufzeit brauchst du nur die Geschwindigkeit.],
)[
#if not web [*Aufgabe 49* #linebreak()]
*Wasserwellen, Ü 10.2:*

*Gegeben und Annahmen*

Wasserwelle: Amplitude 5 cm, Frequenz 3 Hz, Wellenlänge 0,4 m; Abstand zwischen Stein und Ente 5 m.

*Gesucht*

#enum(numbering: "a)",
[Berechne, wann die erste Wellenfront die Ente erreicht.],
)
][
*Geschwindigkeit:* $c = lambda f = "0,4" dot 3 = "1,2" thin "m/s"$.
][
*Laufzeit:* $t = s\/c = 5\/"1,2" thin "s" approx "4,17" thin "s"$.
][
*Prüfen:* Die Amplitude wird nicht gebraucht; sie sagt, wie hoch die Ente schaukelt, nicht wann. Gut vier Sekunden bei 1,2 m/s sind etwa fünf Meter.
#src[Ü 10.2, PDF-S. 1; R, PDF-S. 1.]
]

// 1-50
#aufgabe(titel: "Klapperkiste: Resonanzdrehzahlen", art: "rechnen", quelle: "6.7.2")[
#if not web [*Aufgabe 50* #linebreak()]
*Klapperkiste, Ü 10.3 / AS 1.1:*

*Gegeben und Annahmen*

Ein 40-cm-Blech ist zuerst einseitig befestigt. Die erste Resonanz tritt bei 900 U/min auf.

*Gesucht*

#enum(numbering: "a)",
[Skizziere die ersten drei Moden, bestimme $c$ und alle weiteren Resonanzdrehzahlen bis 6500 U/min. Danach werden beide Enden befestigt: Bestimme erneut Grundresonanz und weitere Resonanzen bis 6500 U/min.],
)
][
*Modell:* Aufgabenmodell mit konstantem $c$ und einer Anregung je Umdrehung. Die zweite Schraube verändert nur die Randbedingung.
][
Zunächst Knoten–Bauch: erste drei Moden haben $n=1,3,5$ wie in der Modenskizze. $lambda_1=4L="1,6" thin "m"$.
][
$f_1=900/60=15 thin "Hz"$ und damit *$c="1,6" · 15=24 thin "m/s"$*. Der Ersatzwert 25 m/s aus AS wird nicht gebraucht.
][
Ungerade Vielfache ergeben 45, 75 und 105 Hz, also *2700, 4500 und 6300 U/min*.
][
Nach der Reparatur Knoten–Knoten: erste drei Formen $n=1,2,3$. $lambda_1=2L="0,8" thin "m"$ und $f_1=24/"0,8"=30 thin "Hz"$.
][
*Erste Resonanz 1800 U/min; weitere 3600 und 5400 U/min*. 7200 U/min liegt außerhalb des Bereichs.
][
*Prüfung:* Die neue Grundwellenlänge halbiert sich; bei unverändertem $c$ verdoppelt sich die Grundfrequenz.

#src[Ü 10.3, PDF-S. 1–2; R, PDF-S. 1–2; AS 1.1 und 4.1, PDF-S. 9–10 und 43–45.]
]

// 1-51
#aufgabe(titel: "Klavierstimmer: Zugkraft erhöhen", art: "rechnen", quelle: "6.3")[
#if not web [*Aufgabe 51* #linebreak()]
*Klavierstimmer, Ü 10.4:*

*Gegeben und Annahmen*

Eine Saite liegt unter 440 Hz; mit einer 440-Hz-Stimmgabel entsteht $T_s="0,2" thin "s"$.

*Gesucht*

#enum(numbering: "a)",
[Um wie viel Prozent muss die Zugkraft bei unveränderter Länge und Masse je Länge steigen?],
[Bestimme auch das Verhältnis der Wellengeschwindigkeiten.],
)
][
*Modell:* gleiche Grundmode, Länge und Masse je Länge unverändert.
][
$f_s=1/T_s=5 thin "Hz"$. Weil die Saite zu tief liegt, ist $f_"vor"=435 thin "Hz"$.
][
Aus $f=c/(2L)$ folgt $c_"nach"/c_"vor"=440/435 approx "1,01149"$.
][
Mit $c=sqrt(F/(rho A))$ folgt $F_"nach"/F_"vor"=(440/435)^2 approx "1,02312"$.
][
*Ergebnis: Die Zugkraft muss um etwa 2,31 % steigen.* Prüfung: Die Geschwindigkeit steigt nur um etwa 1,15 %, weil sie von der Quadratwurzel der Kraft abhängt.

#src[Ü 10.4, PDF-S. 2; R, PDF-S. 2–3.]
]

// 1-52
#aufgabe(titel: "Interferenz zweier Lautsprecher", art: "rechnen", quelle: "6.5")[
#if not web [*Aufgabe 52* #linebreak()]
*Interferenz, Ü 10.5:*

*Gegeben und Annahmen*

Zwei gleichphasige Lautsprecher liegen 2,6 m auseinander. Der Hörer geht auf einer parallelen Linie in 3 m Abstand vom Mittelpunkt $P_0$ nach $P_1$, das 1,8 m oberhalb $P_0$ liegt. Dort hört er das erste Minimum.

*Gesucht*

#enum(numbering: "a)",
[Bestimme die Frequenz für $c=340 thin "m/s"$.],
)
][
*Modell:* gleiche Frequenz, gleichphasige Quellen; das erste Minimum wird dem Gangunterschied $lambda/2$ zugeordnet.
][
Halber Quellenabstand $"1,3" thin "m"$. Die beiden Wege sind $l_1=sqrt(3^2+("1,8"-"1,3")^2) approx "3,04138" thin "m"$ und $l_2=sqrt(3^2+("1,8"+"1,3")^2) approx "4,31393" thin "m"$.
][
$Delta l=abs(l_2-l_1) approx "1,27255" thin "m"$.
][
$lambda=2 Delta l approx "2,54510" thin "m"$; daher *$f=340/lambda approx "133,59" thin "Hz" approx 134 thin "Hz"$*.
][
*Prüfung:* Die Wege müssen aus der Geometrie berechnet werden; 3 m sind keine hinreichende Fernfeldnäherung. Im Aufgabentext steht einmal $P_2$ statt $P_0$; die Skizze und R zeigen die gemeinte 1,8-m-Verschiebung. Die in R gerundeten 133 Hz entstehen durch frühes Runden der Wege.

#src[Ü 10.5, PDF-S. 2; R, PDF-S. 3; eigene geometrisch überprüfte Rechnung.]
]

// 1-53
#aufgabe(titel: "Kalimba: Zungenlänge und Obertöne", art: "rechnen", quelle: "6.7.2")[
#if not web [*Aufgabe 53* #linebreak()]
*Kalimba, AS 1.2:*

*Gegeben und Annahmen*

Eine einseitig befestigte Zunge ist 10 cm lang und besitzt den Grundton 440 Hz.

*Gesucht*

#enum(numbering: "a)",
[Skizziere die ersten drei Moden.],
[Bestimme Grundwellenlänge, $c$, die ersten zwei Obertöne und die Länge einer sonst gleichen Zunge für 495 Hz.],
[Wie lässt sich $c$ im Modell verändern?],
)
][
*Modell:* fest–lose und gemeinsames konstantes $c$ wie in der Sammlung.
][
Erste drei Formen: $n=1,3,5$. $lambda_1=4L="0,4" thin "m"$.
][
*$c="0,4" · 440=176 thin "m/s"$*. Der Ersatzwert 180 m/s wird nicht benötigt.
][
Erste zwei Obertöne: *1320 Hz und 2200 Hz*.
][
Bei gleicher Ausbreitungsgeschwindigkeit ist $L_2=c/(4f_2)=176/(4 · 495) approx "0,08889" thin "m"= "8,89" thin "cm"$.
][
$c$ lässt sich im Materialmodell über Steifigkeit und Dichte beeinflussen. Eine Längenänderung verändert unmittelbar die Eigenfrequenz; im hier vorausgesetzten Modell ist sie keine Änderung von $c$.
][
*Prüfung:* Die höhere Grundfrequenz verlangt eine kürzere Zunge. Die gegenteilige Längen-Erklärung in AS, PDF-S. 46 ist mit der anschließenden Rechnung mit konstantem $c$ nicht vereinbar; hier ist diese Modellannahme sichtbar gemacht.

#src[AS 1.2 und 4.2, PDF-S. 11 und 46–47; eigene Präzisierung.]
]

// 1-54
#aufgabe(titel: "Abendsegler: Wellenlänge bei 30 °C", art: "rechnen", quelle: "6.3")[
#if not web [*Aufgabe 54* #linebreak()]
*Abendsegler, AS 1.3 Teil 1:*

*Gegeben und Annahmen*

Ein 20-kHz-Ruf hat bei 10 °C die Wellenlänge 1,675 cm.

*Gesucht*

#enum(numbering: "a)",
[Welche Wellenlänge hat er bei 30 °C, wenn dasselbe ideale Gas und dieselbe Frequenz vorliegen?],
)
][
*Modell:* $kappa$ und molare Masse konstant.
][
$c_1=lambda_1 f="0,01675" · 20000=335 thin "m/s"$.
][
Temperaturen: $T_1="283,15" thin "K"$, $T_2="303,15" thin "K"$.
][
$c_2=335sqrt("303,15"/"283,15") approx "346,63" thin "m/s"$.
][
*$lambda_2=c_2/20000 approx "0,017331" thin "m"="1,7331" thin "cm"$*.
][
*Prüfung:* Wärmeres Gas besitzt im Modell größeres $c$; bei gleichem Takt wächst die Wellenlänge.

#src[AS 1.3, Teil 1, PDF-S. 12; Lösung 4.3, PDF-S. 48.]
]

// 1-55
#aufgabe(titel: "Kranführer: Seilschwingung und Last", art: "rechnen", quelle: "6.7.1")[
#if not web [*Aufgabe 55* #linebreak()]
*Kranführer, AS 1.4:*

*Gegeben und Annahmen*

Ein 15-m-Stahlseil mit zwei als fest angenommenen Enden schwingt bei 20 Hz im Grundton. Der Durchmesser beträgt 8 mm, die Dichte 7000 kg/m³.

*Gesucht*

#enum(numbering: "a)",
[Bestimme Grundwellenlänge, $c$, die ersten drei Obertöne und die Lastmasse bei $g="9,81" thin "m/s²"$.],
[Zeichne die Formen. Dann werden 30 % der Last abgeladen; anschließend verkürzt sich das Seil auf 10 m.],
[Bestimme beide neuen Grundtöne.],
)
][
*Modell:* gespannte Saite; Seileigengewicht gegenüber der Last vernachlässigt, $F=m g$ und Querschnitt konstant.
][
Zwei feste Enden: $lambda_1=2L=30 thin "m"$, *$c=30 · 20=600 thin "m/s"$*. Erste drei Obertöne: *40, 60 und 80 Hz*; Formen mit 2, 3 und 4 halben Wellen.
][
$A=pi ("0,008" thin "m")^2/4 approx "5,02655" · 10^(-5) thin "m²"$.
][
$m_1=c^2 rho A/g approx 12912 thin "kg"= "12,91" thin "t"$.
][
Nach dem Abladen $m_2=0,7m_1$, daher $c_2=c sqrt("0,7") approx "502,0" thin "m/s"$. Bei 15 m bleibt $lambda_1=30 thin "m"$: *$f_1 approx "16,73" thin "Hz"$*.
][
Bei 10 m ist $lambda_1=20 thin "m"$: *$f_1 approx "25,10" thin "Hz"$*.
][
*Prüfung:* Weniger Spannung senkt $c$; kürzere Länge erhöht bei gleichem $c$ die Frequenz. Die Rückstellwirkung ist die Seilspannung, kein Pendelmodell.

#src[AS 1.4 und 4.4, PDF-S. 13 und 50–51; eigene geprüfte Rechnung.]
]

// 1-56
#aufgabe(titel: "Schiffe versenken: Auslöschung", art: "rechnen", quelle: "6.2")[
#if not web [*Aufgabe 56* #linebreak()]
*Schiffe versenken, AS 1.5:*

*Gegeben und Annahmen*

Max patscht bei $(0,0)$ mit 2 Hz. Die erste Welle erreicht das Schiff bei $(5 thin "m",0)$ nach 5 s.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $c$ und $lambda$.],
[Welche Frequenz und Wellenlänge braucht Moritz für dauerhafte Auslöschung?],
[Moritz steht auf der y-Achse: Bestimme den kleinsten von null verschiedenen Abstand zu Max für gleichphasiges und für gegenphasiges Patschen. Setze gleiche Amplituden am Schiff voraus.],
)
][
*Modell:* Phasenvergleich aus 6.5; gleiche Frequenz und gleiche Amplituden am Beobachtungsort. Die Wege werden geometrisch bestimmt.
][
$c=5/5=1 thin "m/s"$ und *$lambda=c/f="0,5" thin "m"$*.
][
Moritz braucht ebenfalls *2 Hz und 0,5 m*, damit die Phasendifferenz zeitlich gleich bleibt. Gleiche Amplituden sind für vollständige Auslöschung erforderlich; Interferenz selbst ist auch bei ungleichen Amplituden möglich.
][
Sein Weg ist $sqrt(5^2+y^2)$; der von Max ist 5 m. Bei gleichphasigem Patschen braucht das erste Minimum $Delta l=lambda/2="0,25" thin "m"$. Also *$y=sqrt("5,25"^2-5^2) approx "1,601" thin "m"$*.
][
Bei gegenphasigem Patschen muss die räumliche Zusatzphase ein ganzes Vielfaches von $2pi$ sein. Der kleinste positive Wegunterschied ist $lambda="0,5" thin "m"$: *$y=sqrt("5,5"^2-5^2) approx "2,291" thin "m"$*.
][
*Prüfung:* Bei $y=0$ wären beide am selben Ort, was die Aufgabe ausschließt. Die zwei positiven Ergebnisse stimmen mit der Sammlung überein. Deren Formulierung zu gleichen Amplituden wird hier ausdrücklich auf vollständige Auslöschung beschränkt.

#src[AS 1.5 und 4.5, PDF-S. 14 und 52–53; Anwendung des behandelten Phasenvergleichs.]
]

// 1-57
#aufgabe(titel: "Akusto-optische Anordnung", art: "rechnen", quelle: "6.7.2")[
#if not web [*Aufgabe 57* #linebreak()]
*Akusto-optische Anordnung, AS 1.6 Teile 2–4, mit Ersatzwert:*

*Gegeben und Annahmen*

Verwende ausdrücklich den angegebenen Ersatzwert $d=75 thin "µm"$ sowie $lambda_S=2d$. Eine stehende Ultraschallwelle mit $f="5,00" thin "MHz"$ liegt auf $L="10,0125" thin "mm"$ zwischen Knoten und Bauch.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $c$, Modenordnung, Knotenzahl und Frequenz/Wellenlänge der nächsthöheren passenden Mode.],
)
][
*Modell:* Der optische Teil 1 wird nicht vorausgesetzt. Hier wird sein angegebener Ersatzwert benutzt; fest–lose und konstantes $c$.
][
$lambda_S=150 thin "µm"$. *$c=f lambda_S=750 thin "m/s"$*.
][
$n=4L/lambda_S=4 · "10,0125"/"0,150"=267$; die Ordnung ist ungerade.
][
Knoten liegen bei $x=j lambda_S/2$ von $j=0$ bis 133: *134 Knoten einschließlich des festen Endes, davon 133 innere Knoten*. AS, PDF-S. 54 nennt 133, ohne den Randknoten gesondert auszuweisen; hier ist die Zählweise ausdrücklich angegeben.
][
Die nächste Ordnung ist 269. *$f_"neu"="5,00" · 269/267 thin "MHz" approx "5,03745" thin "MHz"$*.
][
*$lambda_"neu"=4L/269 approx "148,885" thin "µm"$*.
][
*Prüfung:* Ein festes und ein loses Ende erlauben nur ungerade Ordnungen; deshalb steigt $n$ um 2. Ergebnisse gelten hier ausdrücklich für den Ersatzwert. Optische Gitter und die Änderung des Schirmbilds folgen erst mit dem Optikstoff.

#src[AS 1.6 und 4.6, PDF-S. 15 und 54, Teilrechnung mit vorgegebenem Ersatzwert; eigene Lösung.]
]

// 1-58
#aufgabe(titel: "Dreifache Amplitude, neunfache Intensität", art: "rechnen", quelle: "6.4",
  ergebnis: [$I_2 = 18 thin "W/m²"$, $P = "0,9" thin "W"$],
  tipp: [Wie hängt die Intensität von der Amplitude ab?],
)[
#if not web [*Aufgabe 58* #linebreak()]
*Eigene Rechenaufgabe:*

*Gegeben und Annahmen*

Bei unverändertem Medium und gleicher Frequenz wird die Amplitude von 1 mm auf 3 mm erhöht. Zunächst ist $I_1=2 thin "W/m²"$.

*Gesucht*

#enum(numbering: "a)",
[Welche Intensität entsteht und welche Leistung empfängt eine senkrechte Fläche von 0,05 m²?],
)
][
*Abhängigkeit:* $I = 1\/2 rho c omega^2 u^2$. Medium und Frequenz bleiben gleich, also gilt $I ∼ u^2$: Die Energie einer Schwingung wächst mit dem Quadrat der Auslenkung, wie bei einer Feder.
][
*Neue Intensität:* $I_2\/I_1 = (3\/1)^2 = 9$, also $I_2 = 9 dot 2 = 18 thin "W/m²"$.
][
*Leistung:* Intensität ist Leistung pro Fläche, also $P = I_2 A = 18 dot "0,05" = "0,9" thin "W"$.
][
*Prüfen:* W/m² mal m² ergibt W; die Fläche wird nicht quadriert.
#src[Eigene Ergänzung nach VB, PDF-S. 13–14, Gl. 6.9–6.11.]
]

