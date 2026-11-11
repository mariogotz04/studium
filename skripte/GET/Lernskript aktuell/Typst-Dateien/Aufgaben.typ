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
// web: Bausteine der Webseite. blatt: nur Aufgabenstellungen für die Wochen-PDF zum Selbstlösen.
#let blatt = "blatt" in sys.inputs
#let web = "web" in sys.inputs or blatt
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
#set page(..if blatt { (width: 176mm, height: auto, margin: (x: 0mm, y: 1mm), header: none, footer: none, fill: none) }
  else if web { (width: 140mm, height: auto, margin: (x: 1.5mm, y: 2.5mm), header: none, footer: none, fill: none) }
  else { (paper: "a4", margin: (x: 20mm, y: 20mm), numbering: "1") })
#let _kapitel = state("aufgaben-kapitel", "")
#let kapitel(titel) = {
  _kapitel.update(titel)
  if not web { pagebreak(weak: true); text(size: 20pt, weight: "bold", fill: navy, titel); v(4mm) }
}
// herkunft: "original" (Aufgabe des Professors), "variante" (von Claude nach einer Vorlage, z. B. andere Zahlen),
// "eigen" (von Claude ohne direkte Vorlage). vorlage: Fundstelle, z. B. "Übung 3, Aufg. 2" oder "Altklausur WS 23/24, Aufg. 4".
#let herkunft-text(herkunft, vorlage) = {
  if herkunft == "original" { "Original" + if vorlage != none { " · " + vorlage } }
  else if herkunft == "variante" { "Von Claude erstellt · nach " + if vorlage != none { vorlage } else { "Vorlage" } }
  else if herkunft == "eigen" { "Von Claude erstellt" } else { none }
}
#let aufgabe(titel: none, art: "rechnen", quelle: none, ergebnis: none, tipp: none, minuten: none,
  herkunft: none, vorlage: none, platz: none, ..teile) = {
  assert(titel != none, message: "Jede Aufgabe braucht einen titel")
  assert(art in ("rechnen", "verstehen"), message: "art ist \"rechnen\" oder \"verstehen\": " + titel)
  assert(herkunft in (none, "original", "variante", "eigen"), message: "herkunft ist \"original\", \"variante\" oder \"eigen\": " + titel)
  assert(herkunft != "variante" or vorlage != none, message: "Eine Variante braucht vorlage: " + titel)
  let teile = teile.pos()
  assert(teile.len() >= 2, message: "Aufgabe ohne Lösungsschritte: " + titel)
  let (text-aufgabe, ..schritte) = teile
  let info = context [#metadata((titel: titel, art: art, quelle: quelle, minuten: minuten, kapitel: _kapitel.get(),
    herkunft: herkunft, vorlage: vorlage, platz: platz,
    schritte: if blatt { 0 } else { schritte.len() }, ergebnis: ergebnis != none and not blatt, tipp: tipp != none and not blatt)) <aufgabe>]
  if blatt {
    // Eine Seite je Aufgabe, nur die Aufgabenstellung: Die Webseite setzt sie auf A4 und ergänzt den Schreibraum.
    pagebreak(weak: true)
    info
    text-aufgabe
  } else if web {
    // Jede Seite ist ein Baustein der Webseite: Aufgabe, Tipp, Ergebnis, dann die Schritte.
    pagebreak(weak: true)
    info
    text-aufgabe
    for teil in (tipp, ergebnis).filter(t => t != none) + schritte { pagebreak(); teil }
  } else {
    info
    let hk = herkunft-text(herkunft, vorlage)
    block(breakable: false, above: 1.4em, below: 0.6em)[
      #text(weight: "bold", fill: navy, size: 12.5pt, titel)
      #h(1fr) #text(size: 8.5pt, fill: muted)[#if art == "rechnen" [Rechenaufgabe] else [Verständnisfrage]#if quelle != none [ · Abschnitt #quelle]]
      #if hk != none { linebreak(); text(size: 8.5pt, fill: if herkunft == "original" { teal } else { muted }, style: "italic", hk) }
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


#kapitel("Kapitel 0 · Vorwissen: Strom, Spannung, Widerstand, Leistung")

// 0-1
#aufgabe(titel: "Geladene Teilchen im Draht", art: "verstehen", quelle: "0.1")[
#if not web [*Aufgabe 1* #linebreak()]
Welche Elementarteilchen sind elektrisch geladen? Welche davon bewegen sich in einem Metalldraht?
][
Protonen (+) und Elektronen (−). Im Metall bewegen sich nur die Elektronen; Neutronen und Atome als Ganzes sind neutral.
]

// 0-2
#aufgabe(titel: "Kräfte zwischen Ladungen", art: "verstehen", quelle: "0.1")[
#if not web [*Aufgabe 2* #linebreak()]
Wie wirken gleichartige und ungleichartige Ladungen aufeinander?
][
Gleichartige stoßen sich ab, ungleichartige ziehen sich an.
]

// 0-3
#aufgabe(titel: "Warum ein Leiter warm wird", art: "verstehen", quelle: "0.2")[
#if not web [*Aufgabe 3* #linebreak()]
Warum setzt ein Leiter dem Strom einen Widerstand entgegen? Was entsteht dabei?
][
Die Elektronen stoßen an die Atome des Gitters („Reibung“). Dabei wird elektrische Energie in Wärme umgewandelt.
]

// 0-4
#aufgabe(titel: "Wovon der Widerstand abhängt", art: "verstehen", quelle: "0.2")[
#if not web [*Aufgabe 4* #linebreak()]
Nenne vier Größen, von denen der Widerstand eines Leiters abhängt.
][
Material ($rho$), Länge $l$, Querschnitt $A$ und Temperatur.
]

// 0-5
#aufgabe(titel: "AC, DC, PTC und NTC", art: "verstehen", quelle: "0.2")[
#if not web [*Aufgabe 5* #linebreak()]
Wofür stehen AC, DC, PTC und NTC?
][
AC = Alternating Current (Wechselstrom), DC = Direct Current (Gleichstrom), PTC = Kaltleiter ($R$ steigt mit $T$), NTC = Heißleiter ($R$ sinkt mit $T$).
]

// 0-6
#aufgabe(titel: "Größerer Widerstand in Reihe", art: "verstehen", quelle: "0.4")[
#if not web [*Aufgabe 6* #linebreak()]
In einer Reihenschaltung wird ein Widerstand vergrößert. Was passiert mit Strom, Leistung und Belastung der Quelle?
][
Strom sinkt, Leistung sinkt, die Quelle wird weniger belastet.
]

// 0-7
#aufgabe(titel: "Spannungsebenen zuordnen", art: "verstehen", quelle: "0.1")[
#if not web [*Aufgabe 7* #linebreak()]
Ordne zu: 380 kV, 400 V, 230 V, 12 V, 1,5 V → AAA-Batterie, Höchstspannung, Drehstromnetz, Wechselstromnetz, PKW-Batterie.
][
AAA 1,5 V; Höchstspannung 380 kV; Drehstrom 400 V; Wechselstrom 230 V; PKW 12 V.
]

// 0-8
#aufgabe(titel: "Bester Leiterwerkstoff", art: "verstehen", quelle: "0.2")[
#if not web [*Aufgabe 8* #linebreak()]
Welcher Werkstoff leitet am besten: Eisen, Silber, Kupfer oder Gold?
][
Silber, vor Kupfer, Gold und Eisen.
]

// 0-9
#aufgabe(titel: "Reihenschaltung: was gleich bleibt", art: "verstehen", quelle: "0.4")[
#if not web [*Aufgabe 9* #linebreak()]
Zwei unterschiedliche Widerstände liegen in Reihe. Was ist an beiden gleich, was ist verschieden? Hat die Schaltungsart Einfluss auf Strom und Spannung?
][
Der Strom ist an beiden gleich; die Spannungen teilen sich im Verhältnis der Widerstände. Die Schaltungsart bestimmt also sehr wohl Strom und Spannung.
]

// 0-10
#aufgabe(titel: "Parallelschaltung: was gleich bleibt", art: "verstehen", quelle: "0.4")[
#if not web [*Aufgabe 10* #linebreak()]
Unterschiedliche Widerstände liegen parallel. Was gilt für Spannung, Strom und Leistung der einzelnen Widerstände? Was passiert mit dem Gesamtstrom, wenn ein Widerstand ausfällt?
][
An jedem Widerstand liegt dieselbe Spannung, die Ströme sind verschieden. Je größer der Widerstand, desto kleiner seine Leistung ($P = U^2\/R$). Fällt ein Zweig aus, sinkt der Gesamtstrom.
]

// 0-11
#aufgabe(titel: "Ladung aus Strom und Zeit", art: "rechnen", quelle: "0.1",
  ergebnis: [$Q = 18 thin "mC"$],
  tipp: [Strom ist Ladung pro Zeit. Was musst du also mit der Zeit machen, um die Ladung zu bekommen?],
)[
#if not web [*Aufgabe 11* #linebreak()]
*Gegeben und Annahmen*

Konstanter Strom $I=600 thin "mA"$, Dauer $t=30 thin "ms"$.

*Gesucht*

#enum(numbering: "a)",
[Berechne die transportierte Ladung.],
)
][
*Bild zuerst:* Strom ist ein Ladungsfluss, so wie Wasser in Litern pro Sekunde fließt. Wer wissen will, wie viel insgesamt durchgeflossen ist, multipliziert den Fluss mit der Dauer. Weil der Strom konstant ist, gilt einfach $Q = I dot.c t$.
][
*In Grundeinheiten umrechnen:* $I = 600 thin "mA" = "0,6" thin "A"$ und $t = 30 thin "ms" = "0,03" thin "s"$. So vermeidest du, Milli und Milli versehentlich zu verrechnen.
][
*Einsetzen:* $Q = "0,6" thin "A" dot.c "0,03" thin "s" = "0,018" thin "As" = 18 thin "mC"$.
][
*Prüfen:* A·s ist genau die Einheit Coulomb. Ein großer Strom, aber nur einige Millisekunden lang, ergibt eine kleine Ladung. Das passt.
]

// 0-12
#aufgabe(titel: "Widerstand einer Signallampe", art: "rechnen", quelle: "0.3",
  ergebnis: [$R = 12 thin Omega$],
  tipp: [Leistung und Strom sind gegeben. Welche Leistungsformel enthält nur $P$, $I$ und $R$?],
)[
#if not web [*Aufgabe 12* #linebreak()]
*Gegeben und Annahmen*

Signallampe 3 W / 0,5 A

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist ihr Betriebswiderstand?],
)
][
*Gegeben und gesucht:* $P = 3 thin "W"$, $I = "0,5" thin "A"$, gesucht $R$. Die Spannung kennst du nicht; du brauchst also eine Formel ohne $U$.
][
*Formel finden:* Aus $P = U I$ und $U = R I$ wird $P = R I^2$. Der Strom steckt quadratisch drin, weil er die Spannung am Widerstand erzeugt *und* selbst noch einmal mit ihr multipliziert wird. Umgestellt: $R = P\/I^2$.
][
*Einsetzen:* $R = 3 thin "W"\/("0,5" thin "A")^2 = 3\/"0,25" thin Omega = 12 thin Omega$.
][
*Gegenprobe auf dem zweiten Weg:* $U = P\/I = 3\/"0,5" = 6 thin "V"$, dann $R = U\/I = 6\/"0,5" = 12 thin Omega$. Beide Wege stimmen überein. „Betriebswiderstand“ heißt: Das gilt im heißen Zustand bei Nennstrom; kalt hat der Glühfaden weniger Widerstand.
]

// 0-13
#aufgabe(titel: "Strom durch eine Heizspirale", art: "rechnen", quelle: "0.2",
  ergebnis: [$I approx "3,07" thin "A"$],
)[
#if not web [*Aufgabe 13* #linebreak()]
*Gegeben und Annahmen*

Heizspirale 75 Ω an 230 V

*Gesucht*

#enum(numbering: "a)",
[Welcher Strom fließt?],
)
][
*Ursache und Wirkung:* Die Spannung treibt, der Widerstand bremst. Der Strom ist das, was dabei herauskommt: $I = U\/R$ (ohmsches Gesetz).
][
*Einsetzen:* $I = 230 thin "V"\/75 thin Omega approx "3,07" thin "A"$.
][
*Prüfen:* V geteilt durch Ω ergibt A. Zur Kontrolle der Größenordnung: Die Leistung wäre $P = U I approx 706 thin "W"$, für eine Heizspirale realistisch.
]

// 0-14
#aufgabe(titel: "Betriebsspannung eines Wärmegeräts", art: "rechnen", quelle: "0.3",
  ergebnis: [$U approx "666,7" thin "V"$],
)[
#if not web [*Aufgabe 14* #linebreak()]
*Gegeben und Annahmen*

Leistung 2,5 kW, gemessener Strom 3,75 A.

*Gesucht*

#enum(numbering: "a)",
[Berechne die Betriebsspannung.],
)
][
*Formel wählen:* Leistung ist Spannung mal Strom, $P = U I$. Gegeben sind $P$ und $I$; die Spannung ist die einzige Unbekannte: $U = P\/I$.
][
*Einheiten angleichen:* $P = "2,5" thin "kW" = 2500 thin "W"$.
][
*Einsetzen:* $U = 2500 thin "W"\/"3,75" thin "A" approx "666,7" thin "V"$.
][
*Prüfen:* W geteilt durch A ergibt V. Das Gerät läuft also nicht am normalen 230-V-Netz. Rückwärts: $"666,7" thin "V" dot.c "3,75" thin "A" approx 2500 thin "W"$.
]

// 0-15
#aufgabe(titel: "Reihenschaltung mit zwei Widerständen", art: "rechnen", quelle: "0.4",
  ergebnis: [$R_2 = 110 thin Omega$; $U_1 = 140 thin "V"$, $U_2 = 220 thin "V"$; $U = 360 thin "V"$],
  tipp: [In einer Reihenschaltung gibt es nur einen Weg für die Ladung. Was folgt daraus für den Strom in $R_1$ und $R_2$?],
)[
#if not web [*Aufgabe 15* #linebreak()]
*Gegeben und Annahmen*

Reihenschaltung, $R_"ges" = 180 thin Omega$, $I = 2 thin "A"$, $R_1 = 70 thin Omega$.

*Gesucht*

#enum(numbering: "a)",
[$R_2$?],
[Teilspannungen?],
[Gesamtspannung?],
)
][
*a) Widerstände addieren sich:* Die Ladung muss erst durch $R_1$, dann durch $R_2$. Jeder Widerstand bremst zusätzlich, deshalb $R_"ges" = R_1 + R_2$. Umgestellt: $R_2 = 180 thin Omega - 70 thin Omega = 110 thin Omega$.
][
*b) Teilspannungen:* Derselbe Strom von 2 A fließt durch beide Widerstände. Mit $U = R I$ folgt $U_1 = 70 thin Omega dot.c 2 thin "A" = 140 thin "V"$ und $U_2 = 110 thin Omega dot.c 2 thin "A" = 220 thin "V"$. Der größere Widerstand bekommt den größeren Anteil der Spannung.
][
*c) Gesamtspannung:* Die Teilspannungen addieren sich (Maschenregel): $U = 140 thin "V" + 220 thin "V" = 360 thin "V"$.
][
*Prüfen:* Auf dem direkten Weg: $U = R_"ges" I = 180 thin Omega dot.c 2 thin "A" = 360 thin "V"$. Beide Wege liefern dasselbe.
]

// 0-16
#aufgabe(titel: "Drei Widerstände parallel an 36 V", art: "rechnen", quelle: "0.4",
  ergebnis: [$R_1 = 8 thin Omega$, $R_2 approx "5,14" thin Omega$, $R_3 = "7,2" thin Omega$; $I = "16,5" thin "A"$; $R approx "2,18" thin Omega$],
  tipp: [Bei der Parallelschaltung hängt jeder Widerstand direkt an der Quelle. Welche Größe ist dann an allen gleich?],
)[
#if not web [*Aufgabe 16* #linebreak()]
*Gegeben und Annahmen*

Drei Widerstände parallel an 36 V, Ströme 4,5 A, 7 A und 5 A.

*Gesucht*

#enum(numbering: "a)",
[Teilwiderstände?],
[Gesamtstrom?],
[Gesamtwiderstand?],
)
][
*a) Gleiche Spannung an jedem Zweig:* Jeder Widerstand ist mit beiden Klemmen direkt an der Quelle angeschlossen, also liegen an jedem 36 V. Damit gilt je Zweig $R = U\/I$: $R_1 = 36\/"4,5" = 8 thin Omega$, $R_2 = 36\/7 approx "5,14" thin Omega$, $R_3 = 36\/5 = "7,2" thin Omega$.
][
*b) Ströme addieren sich:* Am Knoten teilt sich der Strom auf die drei Wege auf; was hineinfließt, kommt auch heraus (Knotenregel). $I = "4,5" + 7 + 5 = "16,5" thin "A"$.
][
*c) Gesamtwiderstand aus Gesamtgrößen:* $R = U\/I = 36 thin "V"\/"16,5" thin "A" approx "2,18" thin Omega$.
][
*Prüfen:* Mehr parallele Wege bedeuten weniger Gesamtwiderstand, deshalb muss $R$ kleiner sein als der kleinste Einzelwiderstand (5,14 Ω). 2,18 Ω erfüllt das. Gegenprobe mit Leitwerten: $1\/8 + 1\/"5,14" + 1\/"7,2" approx "0,458" thin "S"$, Kehrwert 2,18 Ω.
]

// 0-17
#aufgabe(titel: "Unbelasteter Spannungsteiler", art: "rechnen", quelle: "0.6",
  ergebnis: [$U_20 approx "30,4" thin "V"$],
  tipp: [Ohne Last fließt durch $R_1$ und $R_2$ derselbe Strom. Die Spannung teilt sich dann im Verhältnis der Widerstände.],
)[
#if not web [*Aufgabe 17* #linebreak()]
*Gegeben und Annahmen*

Unbelasteter Spannungsteiler: $R_1 = 15 thin "k"Omega$, $R_2 = 100 thin "k"Omega$, $U = 35 thin "V"$.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist $U_20$ an $R_2$?],
)
][
*Modell:* „Unbelastet“ heißt: Am Ausgang hängt nichts, es fließt kein Strom ab. $R_1$ und $R_2$ sind also eine einfache Reihenschaltung.
][
*Strom bestimmen:* $I = U\/(R_1 + R_2) = 35 thin "V"\/115 thin "k"Omega approx "0,304" thin "mA"$.
][
*Spannung an $R_2$:* $U_20 = I R_2 = U dot.c R_2\/(R_1 + R_2) = 35 thin "V" dot.c 100\/115 approx "30,43" thin "V"$. Der Bruch $R_2\/(R_1 + R_2)$ ist der Anteil, den $R_2$ am Gesamtwiderstand hat, und genau diesen Anteil der Spannung bekommt er.
][
*Prüfen:* An $R_1$ bleiben $35 - "30,43" = "4,57" thin "V"$; das ist $15\/115$ von 35 V. Der große Widerstand bekommt den großen Teil. Runde erst am Ende.
]

// 0-18
#aufgabe(titel: "Einheiten umrechnen", art: "rechnen", quelle: "0.1",
  ergebnis: [a) 2 670 000 µV b) 0,18 mA c) 0,37 MΩ d) 36 200 µA e) 0,0047 Ω f) 50 kA],
  tipp: [Jede Vorsilbe ist ein Faktor 1000 zur nächsten: µ, m, (ohne), k, M.],
)[
#if not web [*Aufgabe 18* #linebreak()]
*Gegeben und Annahmen*

Ausgangswerte: 2,67 V; 180 µA; 370 kΩ; 36,2 mA; 4700 µΩ; 50 000 A.

*Gesucht*

#enum(numbering: "a)",
[Rechne 2,67 V in µV um.],
[Rechne 180 µA in mA um.],
[Rechne 370 kΩ in MΩ um.],
[Rechne 36,2 mA in µA um.],
[Rechne 4700 µΩ in Ω um.],
[Rechne 50 000 A in kA um.],
)
][
*Das Prinzip:* Eine Vorsilbe ist nur ein Faktor: $mu = 10^(-6)$, $"m" = 10^(-3)$, $"k" = 10^3$, $"M" = 10^6$. Wird die Einheit *kleiner*, wird die Zahl *größer*, und umgekehrt. Der Wert selbst ändert sich nie.
][
*a) und d) zu kleineren Einheiten:* 1 V sind $10^6$ µV, also $"2,67" thin "V" = 2 thin 670 thin 000 thin mu"V"$. 1 mA sind 1000 µA, also $"36,2" thin "mA" = 36 thin 200 thin mu"A"$.
][
*b), c), e) und f) zu größeren Einheiten:* $180 thin mu"A" = "0,18" thin "mA"$ (durch 1000), $370 thin "k"Omega = "0,37" thin "M"Omega$ (durch 1000), $4700 thin mu Omega = "0,0047" thin Omega$ (durch $10^6$), $50 thin 000 thin "A" = 50 thin "kA"$ (durch 1000).
][
*Prüfen:* Frage dich bei jeder Antwort: Ist die neue Einheit größer? Dann muss die Zahl kleiner sein. Alle sechs Ergebnisse erfüllen das.
]

// 0-19
#aufgabe(titel: "Widerstand einer Kupferleitung hin und zurück", art: "rechnen", quelle: "0.2",
  ergebnis: [$l = 50 thin "m"$, $R approx "0,60" thin Omega$],
  tipp: [Der Strom muss vom Netz zum Gerät *und wieder zurück*. Wie lang ist dann der gesamte Draht?],
)[
#if not web [*Aufgabe 19* #linebreak()]
*Gegeben und Annahmen*

Eine Kupferleitung führt 25 m hin und 25 m zurück, $A = "1,5" thin "mm"^2$, $rho_"Cu" = "0,0179" thin Omega thin "mm"^2\/"m"$ (Daten aus V S. 9).

*Gesucht*

#enum(numbering: "a)",
[Bestimme die Leiterlänge und den Widerstand.],
[Warum zählt die Länge doppelt?],
)
][
*Länge verstehen:* Strom fließt nur im geschlossenen Kreis. Er läuft durch den Hinleiter zum Gerät und durch den Rückleiter zurück. Beide Drähte liegen in Reihe, also zählt jeder Meter: $l = 2 dot.c 25 thin "m" = 50 thin "m"$.
][
*Formel:* $R = rho l\/A$. Je länger der Draht, desto mehr Zusammenstöße; je dicker, desto mehr parallele Wege. Der spezifische Widerstand $rho$ beschreibt das Material.
][
*Einsetzen:* $R = "0,0179" thin Omega thin "mm"^2\/"m" dot.c 50 thin "m"\/"1,5" thin "mm"^2 approx "0,60" thin Omega$.
][
*Prüfen:* mm² kürzt sich, m kürzt sich, übrig bleibt Ω. Ein halbes Ohm für 50 m Kupfer ist klein, aber bei großen Strömen nicht vernachlässigbar.
]

// 0-20
#aufgabe(titel: "Draht mit gegebenem Durchmesser", art: "rechnen", quelle: "0.2",
  ergebnis: [$A approx "0,196" thin "mm"^2$, $R approx "1,81" thin Omega$],
  tipp: [Die Formel braucht die *Querschnittsfläche*, gegeben ist aber der Durchmesser.],
)[
#if not web [*Aufgabe 20* #linebreak()]
*Gegeben und Annahmen*

Ein Kupferdraht ($rho = "0,0178" thin Omega thin "mm"^2\/"m"$) ist 20 m lang und hat 0,5 mm Durchmesser.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist sein Widerstand?],
)
][
*Die Falle erkennen:* $R = rho l\/A$ braucht die Fläche $A$, nicht den Durchmesser. Wer 0,5 einsetzt, rechnet falsch.
][
*Querschnitt berechnen:* Der Draht ist rund, also $A = pi d^2\/4 = pi\/4 dot.c ("0,5" thin "mm")^2 approx "0,196" thin "mm"^2$.
][
*Widerstand:* $R = "0,0178" dot.c 20\/"0,196" thin Omega approx "1,81" thin Omega$.
][
*Prüfen:* Halber Durchmesser bedeutet ein Viertel der Fläche und damit den vierfachen Widerstand. Der dünne Draht hat deshalb deutlich mehr Widerstand als die 1,5-mm²-Leitung aus der vorigen Aufgabe.
]

// 0-21
#aufgabe(titel: "Dicke der Kohleschicht", art: "rechnen", quelle: "0.2")[
#if not web [*Aufgabe 21* #linebreak()]
*Kohleschicht-Widerstand, Ü 1a:*

*Gegeben und Annahmen*

Die Kohleschicht ist zu einer Wendel von 95 mm Länge und 3,5 mm Breite geschliffen, $rho_"Kohle" = 60 thin Omega thin "mm"^2\/"m"$.

*Gesucht*

#enum(numbering: "a)",
[Wie dick muss die Schicht sein, damit der Widerstand 80 kΩ beträgt?],
)
][
*Idee:* Das Kohleband ist ein flacher, langer Leiter mit dem Querschnitt $A = b dot.c d$.
][
$R = rho l\/A$ nach $A$ umstellen: $A = (rho l)/R = (60 thin Omega thin "mm"^2\/"m" dot.c "0,095" thin "m")/(80 thin 000 thin Omega) approx "7,13" dot.c 10^(-5) thin "mm"^2$
][
$d = A\/b = "7,13" dot.c 10^(-5) thin "mm"^2 \/ "3,5" thin "mm" approx "2,04" dot.c 10^(-5) thin "mm"$
][
*Ergebnis:* $d approx 20 thin "nm"$, wie auf dem Übungsblatt. *Prüfung:* mm² geteilt durch mm ergibt mm; eine hauchdünne Schicht ist für 80 kΩ plausibel.
#note("Von dir markiert", [„In Prüfung Einheiten richtig mitführen!!“ (Ü-N, PDF-S. 4). Dort steht im Zähler einmal 3,5 mm. Richtig ist die *Länge 95 mm*; 3,5 mm ist die Breite im Nenner. DC, PDF-S. 3, setzt richtig ein.], fill: sand)
#src([Ü 1a; Ü-N, PDF-S. 4; DC, PDF-S. 3.])
]

// 0-22
#aufgabe(titel: "Aluminium gegen Kupfer", art: "rechnen", quelle: "0.2")[
#if not web [*Aufgabe 22* #linebreak()]
*Aluminium und Kupfer, Ü 7 (= Blatt B 14):*

*Gegeben und Annahmen*

Gleich lange Aluminium- und Kupferleiter mit gleichem Widerstand. $rho_"Al"="0,0278"$, $rho_"Cu"="0,0178" thin Omega thin "mm"^2/"m"$. Zweiter Fall: zwei gleich lange Kupferleiter mit Durchmesserverhältnis 2 : 1.

*Gesucht*

#enum(numbering: "a)",
[Bestimme das Querschnittsverhältnis Aluminium zu Kupfer im ersten Fall.],
[Bestimme das Widerstandsverhältnis im zweiten Fall.],
)
][
a) Gleiche Länge, gleicher Widerstand: $rho_"Al" l\/A_"Al" = rho_"Cu" l\/A_"Cu"$, also $A_"Al"\/A_"Cu" = rho_"Al"\/rho_"Cu" = "0,0278"\/"0,0178" approx "1,56"$. Das Verhältnis der Durchmesser ist $sqrt("1,56") approx "1,25"$.\
b) Durchmesser 2 : 1 → Querschnitt 4 : 1 → $R_1\/R_2 = 1\/4 = "0,25"$: Der dickere Leiter hat ein Viertel des Widerstands. Deine Lösung R S. 8 kommt ebenfalls auf 1,56 und 1/4.
#note("Widerspruch in den Unterlagen", [Ü 7a nennt als Lösung 1,25. Das ist das Verhältnis der *Durchmesser*. Das Verhältnis der *Querschnitte* ist 1,56. Schreib in der Klausur beide Zahlen mit Begründung hin.], fill: sand)
_Eigene Ergänzung, WI-Sicht:_ Aluminium braucht rund 56 % mehr Querschnitt, ist aber leichter und billiger als Kupfer; deshalb bestehen Freileitungen oft aus Aluminium.
]

// 0-23
#aufgabe(titel: "Höchstspannung bei 1/8 W Belastbarkeit", art: "rechnen", quelle: "0.3",
  ergebnis: [$U_"max" approx "24,2" thin "V"$],
  tipp: [Die Belastbarkeit ist eine Grenze für die Leistung. Welche Leistungsformel enthält $U$ und $R$?],
)[
#if not web [*Aufgabe 23* #linebreak()]
*Belastbarkeit, Blatt A 1:*

*Gegeben und Annahmen*

$R="4,7" thin "k"Omega$, zulässige Dauerleistung $P_"max"=1/8 thin "W"$.

*Gesucht*

#enum(numbering: "a)",
[Berechne die höchstens zulässige Betriebsspannung.],
)
][
*Was bedeutet Belastbarkeit?* Der Widerstand wandelt elektrische Leistung in Wärme um. 1/8 W ist die Wärme, die er dauerhaft loswird, ohne zu überhitzen. Gesucht ist die Spannung, bei der genau diese Leistung entsteht.
][
*Formel:* Strom ist nicht gegeben, also $P = U^2\/R$. Umgestellt: $U = sqrt(P R)$.
][
*Einsetzen:* $U = sqrt("0,125" thin "W" dot.c 4700 thin Omega) = sqrt("587,5") thin "V" approx "24,2" thin "V"$.
][
*Prüfen:* W·Ω = V²/Ω·Ω = V², die Wurzel ergibt V. Die Lösung R S. 1 nennt gerundet 24 V. Darüber wird der Widerstand auf Dauer zu heiß.
]

// 0-24
#aufgabe(titel: "Leistung bei 10 % mehr Spannung", art: "rechnen", quelle: "0.3",
  ergebnis: [Die Leistung steigt um 21 %.],
  tipp: [Wie hängt $P$ von $U$ ab, wenn $R$ konstant bleibt?],
)[
#if not web [*Aufgabe 24* #linebreak()]
*Spannung +10 %, Blatt A 6:*

*Gegeben und Annahmen*

Bei einem Verbraucher mit konstantem Widerstand steigt die Spannung um 10 % über die Nennspannung.

*Gesucht*

#enum(numbering: "a)",
[Um wie viel Prozent ändert sich die Leistung?],
)
][
*Warum nicht einfach 10 %?* Mehr Spannung treibt mehr Strom, und die Leistung ist Spannung *mal* Strom. Beide steigen um 10 %, deshalb wächst die Leistung stärker. In einer Formel: $P = U^2\/R$.
][
*Rechnen mit Faktoren:* Neue Spannung $U' = "1,1" U$. Dann $P' = ("1,1" U)^2\/R = "1,21" dot.c U^2\/R = "1,21" P$.
][
*Ergebnis deuten:* Der Faktor 1,21 bedeutet 21 % mehr Leistung. Man braucht dafür keine Zahlenwerte, weil sich $R$ und $U$ herauskürzen.
][
*Prüfen:* Kleine Probe mit Zahlen: 100 V an 100 Ω ergibt 100 W; 110 V ergibt 121 W. Das sind 21 % mehr.
]

// 0-25
#aufgabe(titel: "Aufheizzeit eines Wasserkochers", art: "rechnen", quelle: "0.3")[
#if not web [*Aufgabe 25* #linebreak()]
*Wasserkocher, Blatt A 7:*

*Gegeben und Annahmen*

Nenndaten 230 V / 1500 W, Wirkungsgrad 0,85. Für Wasser gilt hier $rho=1 thin "kg/l"$.

*Gesucht*

#enum(numbering: "a)",
[Wie lange dauert es, 1 Liter Wasser von 15 °C auf 100 °C zu erwärmen? ($c = "4,19" thin "kJ/(kg K)"$, 1 J = 1 Ws)],
)
][
*Annahme:* 1 Liter Wasser hat die Masse 1 kg.
][
Nötige Wärme: $Q = m c Delta T = 1 thin "kg" dot.c "4,19" thin "kJ/(kg K)" dot.c 85 thin "K" approx "356,2" thin "kJ"$
][
Nutzleistung: $P_"Nutz" = eta dot.c P = "0,85" dot.c 1500 thin "W" = 1275 thin "W"$
][
Zeit: $t = Q\/P_"Nutz" = 356 thin 150 thin "Ws" \/ 1275 thin "W" approx 279 thin "s"$
][
*Ergebnis:* $t approx 280 thin "s" approx "4,7" thin "min"$ (wie R S. 3, dort über $Q\/eta$ gerechnet). *Prüfung:* Ohne Verluste wären es rund 237 s; mit Verlusten dauert es länger.
]

// 0-26
#aufgabe(titel: "Unbekannte Widerstände in Reihe", art: "rechnen", quelle: "0.4",
  ergebnis: [$R_2 = R_3 approx 47 thin Omega$],
  tipp: [Der gemessene Strom fließt durch alle drei Widerstände. Damit kennst du den Gesamtwiderstand.],
)[
#if not web [*Aufgabe 26* #linebreak()]
*Reihenschaltung, Blatt B 15:*

*Gegeben und Annahmen*

Drei Widerstände in Reihe liegen an 10 V. In $R_1 = 39 thin Omega$ fließen 75,2 mA.

*Gesucht*

#enum(numbering: "a)",
[Wie groß sind $R_2 = R_3$?],
)
][
*Der Schlüssel:* In einer Reihenschaltung gibt es nur einen Strom. Die 75,2 mA in $R_1$ fließen also durch die ganze Kette, und die Quelle „sieht“ den Gesamtwiderstand.
][
*Gesamtwiderstand:* $R_"ges" = U\/I = 10 thin "V"\/"0,0752" thin "A" approx 133 thin Omega$.
][
*Aufteilen:* $R_"ges" = R_1 + R_2 + R_3 = 39 thin Omega + 2 R_2$. Daraus $R_2 = (133 - 39)\/2 thin Omega approx 47 thin Omega$, also auch $R_3 approx 47 thin Omega$.
][
*Prüfen:* $39 + 47 + 47 = 133 thin Omega$; $133 thin Omega dot.c "75,2" thin "mA" approx 10 thin "V"$. 47 Ω ist zudem ein Normwert, das passt zur Lösung R S. 8.
]

// 0-27
#aufgabe(titel: "Stand-by-Verbrauch eines Fernsehers", art: "rechnen", quelle: "0.3",
  ergebnis: [a) 10,8 kWh b) 9 kWh c) 37,5 %],
  tipp: [Energie ist Leistung mal Zeit. Rechne die Zeit pro Monat zuerst in Stunden aus.],
)[
#if not web [*Aufgabe 27* #linebreak()]
*Stand-by, Blatt B 16:*

*Gegeben und Annahmen*

Ein Fernseher nimmt im Betrieb 90 W auf, im Stand-by 15 W; Betrieb 4 h, Stand-by 20 h täglich.

*Gesucht*

#enum(numbering: "a)",
[Monatlicher Energiebedarf (30 Tage) im Betrieb?],
[im Stand-by?],
[Zu wie viel Prozent wäre ein 400-MW-Kraftwerk ausgelastet, um den Stand-by von 10 Millionen Geräten zu versorgen?],
)
][
*Leistung und Energie trennen:* Leistung (W) sagt, wie schnell Energie verbraucht wird. Energie (Wh) ist Leistung mal Dauer. Bezahlt wird die Energie.
][
*a) Betrieb:* $W = 90 thin "W" dot.c 4 thin "h" dot.c 30 = 10 thin 800 thin "Wh" = "10,8" thin "kWh"$.
][
*b) Stand-by:* $W = 15 thin "W" dot.c 20 thin "h" dot.c 30 = 9000 thin "Wh" = 9 thin "kWh"$. Überraschung: Fast so viel wie im Betrieb, weil das Gerät fünfmal so lange im Stand-by ist.
][
*c) Kraftwerk:* Hier ist nach *Leistung* gefragt, nicht nach Energie. 10 Millionen Geräte zu je 15 W: $P = 15 thin "W" dot.c 10^7 = 150 thin "MW"$. Anteil: $150\/400 = "0,375" = "37,5" thin %$.
][
*Prüfen:* Die Rechnung c) setzt voraus, dass alle Geräte gleichzeitig im Stand-by sind. Größenordnung: Ein gutes Drittel eines Kraftwerks nur für Stand-by, das zeigt, warum Stand-by-Verluste politisch wichtig sind.
]

// 0-28
#aufgabe(titel: "Stromaufnahme eines Elektromotors", art: "rechnen", quelle: "0.3",
  ergebnis: [$P_"el" approx "8,33" thin "kW"$, $I approx "18,9" thin "A"$],
  tipp: [Die 6,5 kW sind die *abgegebene* Leistung an der Welle. Aufgenommen wird mehr.],
)[
#if not web [*Aufgabe 28* #linebreak()]
*Elektromotor, Blatt B 18:*

*Gegeben und Annahmen*

Ein Motor gibt an der Welle 6,5 kW ab, Wirkungsgrad 78 %.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist seine Stromaufnahme an 440 V Gleichspannung?],
)
][
*Energiefluss denken:* Elektrische Leistung geht hinein, mechanische Leistung kommt an der Welle heraus, der Rest wird Wärme. Der Wirkungsgrad ist das Verhältnis $eta = P_"ab"\/P_"zu"$.
][
*Aufgenommene Leistung:* $P_"el" = P_"mech"\/eta = "6,5" thin "kW"\/"0,78" approx "8,33" thin "kW"$. Teilen, nicht multiplizieren: Die Eingangsleistung muss größer sein.
][
*Strom:* $I = P_"el"\/U = 8333 thin "W"\/440 thin "V" approx "18,9" thin "A"$.
][
*Prüfen:* Verlust $"8,33" - "6,5" approx "1,83" thin "kW"$ Wärme, das sind 22 %. Hättest du mit 6,5 kW gerechnet, kämen nur 14,8 A heraus, und die Leitung wäre zu knapp ausgelegt.
]

// 0-29
#aufgabe(titel: "Belasteter Spannungsteiler", art: "rechnen", quelle: "0.6")[
#if not web [*Aufgabe 29* #linebreak()]
*Ergänzung zu FK 25, eigene Aufgabe:*

*Gegeben und Annahmen*

Ein Spannungsteiler erhält einen Verbraucher $R_L = 100 thin "k"Omega$ parallel zu $R_2 = 100 thin "k"Omega$. $R_1 = 15 thin "k"Omega$, $U = 35 thin "V"$.

*Gesucht*

#enum(numbering: "a)",
[Welche Spannung liegt jetzt am Ausgang?],
[Warum ist sie kleiner als im Leerlauf?],
)
][
*Modell:* Ideale 35-V-Quelle, konstante Widerstände, Last parallel zu $R_2$.
][
Parallelersatz: $R_p = (100 dot.c 100)/(100 + 100) thin "k"Omega = 50 thin "k"Omega$.
][
Gesamtstrom: $I = 35 thin "V"/(65 thin "k"Omega) approx "0,5385" thin "mA"$; Ausgangsspannung: $U_a = 35 thin "V" dot.c 50/65 approx "26,92" thin "V"$.
][
*Ergebnis: 26,92 V.* Die Last verkleinert den unteren Ersatzwiderstand; an $R_1$ fällt mehr Spannung ab. *Prüfung:* In $R_2$ und $R_L$ fließen je rund 0,2692 mA, zusammen der Gesamtstrom. $U_a$ ist kleiner als die Leerlaufspannung 30,43 V.
]

// 0-30
#aufgabe(titel: "Klemmenspannung einer Mignonzelle", art: "rechnen", quelle: "0.6",
  ergebnis: [$U(40 thin "mA") = "1,5148" thin "V"$, $U(80 thin "mA") = "1,5096" thin "V"$],
  tipp: [Ein Teil der Quellspannung bleibt schon im Inneren der Zelle hängen. Wie groß ist dieser Teil?],
)[
#if not web [*Aufgabe 30* #linebreak()]
*FK 27, am 22.10. bearbeitet:*

*Gegeben und Annahmen*

Eine Mignonzelle hat $U_q = "1,52" thin "V"$ und $R_i = "0,13" thin Omega$.

*Gesucht*

#enum(numbering: "a)",
[Berechne die Klemmenspannung bei 40 mA und, als eigene Variation, bei 80 mA.],
[Erkläre den Unterschied.],
)
][
*Modell der realen Quelle:* Eine Batterie ist eine ideale Quelle $U_q$ mit einem kleinen Widerstand $R_i$ in Reihe. Fließt Strom, fällt an $R_i$ die Spannung $U_i = I R_i$ ab, und außen kommt nur der Rest an: $U = U_q - I R_i$.
][
*Bei 40 mA:* $U_i = "0,04" thin "A" dot.c "0,13" thin Omega = "0,0052" thin "V"$, also $U = "1,52" - "0,0052" = "1,5148" thin "V"$.
][
*Bei 80 mA:* $U_i = "0,08" dot.c "0,13" = "0,0104" thin "V"$, also $U = "1,5096" thin "V"$.
][
*Deuten und prüfen:* Doppelter Strom, doppelter innerer Spannungsabfall (5,2 → 10,4 mV), weil $U_i$ proportional zu $I$ ist. Beide Klemmenspannungen liegen unter 1,52 V, wie es bei Entladung sein muss.
]


#kapitel("Kapitel 1 · Grundbegriffe: Strom, Spannung, Widerstand, Leistung")

// 1-1
#aufgabe(titel: "Die Formel Q = n e A l", art: "verstehen", quelle: "1.1.1")[
#if not web [*Aufgabe 31* #linebreak()]
Erkläre die Formel $Q = n e A l$. Was bedeutet jede Größe?
][
$n$ = freie Elektronen pro Volumen, $e$ = Ladung eines Elektrons, $A l = V$ = Volumen des Leiterstücks. Das Produkt ist die gesamte bewegliche Ladung im Stück.
]

// 1-2
#aufgabe(titel: "Stromstärke definieren", art: "verstehen", quelle: "1.1.2")[
#if not web [*Aufgabe 32* #linebreak()]
Definiere die Stromstärke in Worten und als Formel. Wie viele Elektronen sind „1 Ampere“?
][
Stromstärke = Ladung, die pro Zeit durch den Querschnitt fließt: $I = Q\/t$ bzw. $i = dif Q\/dif t$. 1 A ≈ $"6,25" dot.c 10^18$ Elektronen pro Sekunde.
]

// 1-3
#aufgabe(titel: "Technische und physikalische Stromrichtung", art: "verstehen", quelle: "1.1.2")[
#if not web [*Aufgabe 33* #linebreak()]
Was ist der Unterschied zwischen technischer und physikalischer Stromrichtung? Welche benutzt man im Schaltbild?
][
Technisch: + nach − (Konvention, im Schaltbild). Physikalisch: − nach + (tatsächliche Elektronenbewegung).
]

// 1-4
#aufgabe(titel: "Warum das Licht sofort angeht", art: "verstehen", quelle: "1.1.3")[
#if not web [*Aufgabe 34* #linebreak()]
Die Elektronen driften nur mit etwa 1 mm/s. Warum geht das Licht trotzdem sofort an?
][
Das elektrische Feld breitet sich fast mit Lichtgeschwindigkeit aus; alle Elektronen im Kreis beginnen gleichzeitig zu driften.
]

// 1-5
#aufgabe(titel: "Stromdichte und Erwärmung", art: "verstehen", quelle: "1.1.5")[
#if not web [*Aufgabe 35* #linebreak()]
Warum bestimmt die Stromdichte und nicht die Stromstärke die Erwärmung eines Leiters?
][
Die Erwärmung kommt von der Reibung pro Querschnittsfläche. Derselbe Strom erzeugt in einem dünnen Draht eine viel höhere Stromdichte und damit mehr Wärme als in einem dicken.
]

// 1-6
#aufgabe(titel: "Leiter mit doppeltem Querschnitt", art: "verstehen", quelle: "1.1.5")[
#if not web [*Aufgabe 36* #linebreak()]
Ein Leiter hat links den Querschnitt $A$, rechts $2 A$. Was gilt rechts für Strom und Stromdichte?
][
Gleicher Strom (Kontinuität), halbe Stromdichte.
]

// 1-7
#aufgabe(titel: "Drei Wirkungen des Stroms", art: "verstehen", quelle: "1.1.6")[
#if not web [*Aufgabe 37* #linebreak()]
Nenne die drei Wirkungen des Stroms mit je einem Anwendungsbeispiel.
][
Wärme (Heizlüfter), Kraft über das Magnetfeld (Elektromotor), Materialtransport (elektrochemische Prozesse, z. B. Galvanisieren).
]

// 1-8
#aufgabe(titel: "Wovon die Lorentzkraft abhängt", art: "verstehen", quelle: "1.1.6")[
#if not web [*Aufgabe 38* #linebreak()]
Wovon hängt die Lorentzkraft auf einen stromdurchflossenen Leiter ab? Wann ist sie null?
][
$F_L = I l B$: Sie wächst mit Strom, Leiterlänge im Feld und Flussdichte. Liegt der Leiter parallel zum Feld, ist $arrow(l) times arrow(B) = 0$, also keine Kraft.
]

// 1-9
#aufgabe(titel: "Lineare Skala des Drehspulinstruments", art: "verstehen", quelle: "1.1.6")[
#if not web [*Aufgabe 39* #linebreak()]
Warum hat ein Drehspulinstrument eine lineare Skala?
][
Weil $phi = N A B\/D^* dot.c I$: Der Ausschlag ist proportional zum Strom.
]

// 1-10
#aufgabe(titel: "Warum Hochspannung übertragen wird", art: "verstehen", quelle: "1.1.5")[
#if not web [*Aufgabe 40* #linebreak()]
Warum überträgt man elektrische Energie über weite Strecken mit Hochspannung?
][
Die Leitungsverluste $P = I^2 R$ hängen quadratisch vom Strom ab. Bei hoher Spannung braucht man für dieselbe Leistung nur wenig Strom.
]

// 1-11
#aufgabe(titel: "Wie eine Quellspannung entsteht", art: "verstehen", quelle: "1.2.1")[
#if not web [*Aufgabe 41* #linebreak()]
Was muss in jeder Spannungsquelle passieren, damit eine Quellspannung entsteht? Welche Energieumwandlung findet in Batterie und Generator statt?
][
Ladungstrennung durch einen physikalischen Effekt. Batterie: chemisch → elektrisch. Generator: mechanisch → elektrisch (Induktion).
]

// 1-12
#aufgabe(titel: "Induktionsgesetz in Worten", art: "verstehen", quelle: "1.2.2")[
#if not web [*Aufgabe 42* #linebreak()]
Formuliere das Induktionsgesetz in Worten. Was bedeutet das Minuszeichen?
][
Ändert sich der magnetische Fluss durch eine Spule, wird eine Spannung induziert, umso größer, je schneller die Änderung und je mehr Windungen. Das Minus (Lenz): Die Wirkung ist ihrer Ursache entgegengerichtet.
]

// 1-13
#aufgabe(titel: "Ruhender Magnet in der Spule", art: "verstehen", quelle: "1.2.2")[
#if not web [*Aufgabe 43* #linebreak()]
Ein Magnet liegt ruhig in einer Spule. Wird eine Spannung induziert? Und wenn man die Spule aus dem Feld zieht?
][
Ruhender Magnet: nein, der Fluss ist konstant, $dif Phi\/dif t = 0$. Spule aus dem Feld ziehen: ja, der Fluss durch die Spule ändert sich.
]

// 1-14
#aufgabe(titel: "Lampen-Aufgabe: Schalter schließen", art: "verstehen", quelle: "1.1.7.1")[
#if not web [*Aufgabe 44* #linebreak()]
Drei gleiche Lampen A, B und C liegen in Reihe an einer idealen Batterie. Ein idealer Schalter S liegt parallel zu C und ist zunächst offen. Für das einfache Modell werden die Lampen als gleiche konstante Widerstände behandelt. S wird geschlossen: Was passiert mit C, mit dem Batteriestrom, mit A und B und mit der Gesamtleistung?
][
C erlischt, der Batteriestrom steigt, A und B leuchten heller, die Gesamtleistung steigt.
]

// 1-15
#aufgabe(titel: "Ladung und Elektronenzahl", art: "rechnen", quelle: "1.1.1",
  ergebnis: [a) $Q = 60 thin "As"$ b) $N approx "3,75" dot.c 10^20$ Elektronen],
  tipp: [Erst die Ladung aus Strom und Zeit; dann fragen: Wie viele Elementarladungen passen in diese Ladung?],
)[
#if not web [*Aufgabe 45* #linebreak()]
*Gegeben und Annahmen*

Durch einen Leiter fließen 2 Minuten lang 0,5 A. Elementarladung: $e="1,602" dot.c 10^(-19) thin "C"$.

*Gesucht*

#enum(numbering: "a)",
[Welche Ladung?],
[Wie viele Elektronen sind das?],
)
][
*a) Ladung:* Bei konstantem Strom ist $Q = I t$. Die Zeit muss in Sekunden: 2 min = 120 s. Also $Q = "0,5" thin "A" dot.c 120 thin "s" = 60 thin "As" = 60 thin "C"$.
][
*b) Elektronen zählen:* Jedes Elektron trägt die Elementarladung $e = "1,602" dot.c 10^(-19) thin "C"$. Die Anzahl ist die Gesamtladung geteilt durch die Ladung eines Elektrons: $N = Q\/e = 60\/("1,602" dot.c 10^(-19)) approx "3,75" dot.c 10^20$.
][
*Prüfen:* Faustwert: 1 A sind etwa $"6,25" dot.c 10^18$ Elektronen pro Sekunde. 0,5 A über 120 s: $"0,5" dot.c 120 dot.c "6,25" dot.c 10^18 = "3,75" dot.c 10^20$. Eine riesige Zahl, weil ein einzelnes Elektron winzig wenig Ladung trägt.
]

// 1-16
#aufgabe(titel: "Stromdichte und Driftgeschwindigkeit", art: "rechnen", quelle: "1.1.5",
  ergebnis: [a) $S approx "10,7" thin "A/mm"^2$, oberhalb des vorgegebenen Skriptrichtbereichs b) $v_d approx "0,79" thin "mm/s"$],
  tipp: [Für $v_d$ stellst du $I = n e A v_d$ um. Achte darauf, dass alle Längen in derselben Einheit stehen wie $n$.],
)[
#if not web [*Aufgabe 46* #linebreak()]
*Gegeben und Annahmen*

Kupferleitung, $A = "1,5" thin "mm"^2$, $I = 16 thin "A"$. Elektronendichte $n="8,44" dot.c 10^22 thin "cm"^(-3)$; $e="1,602" dot.c 10^(-19) thin "C"$. Für die Modellbeurteilung dieser Aufgabe gilt der im Lernblatt verwendete Richtbereich 1 bis 6 A/mm²; eine reale Leitungsdimensionierung ist damit nicht vollständig beschrieben.

*Gesucht*

#enum(numbering: "a)",
[Stromdichte $S$? Ist das zulässig?],
[Driftgeschwindigkeit $v_d$?],
)
][
*a) Stromdichte:* $S = I\/A$ sagt, wie viel Strom sich durch jeden Quadratmillimeter drängt. $S = 16 thin "A"\/"1,5" thin "mm"^2 approx "10,7" thin "A/mm"^2$.
][
*Bewerten:* 10,7 A/mm² liegt über dem ausdrücklich vorgegebenen Skriptrichtbereich von 1 bis 6 A/mm². Nach diesem Aufgabenmodell ist der Wert nicht zulässig. Eine reale thermische Beurteilung folgt nicht allein aus diesem Richtbereich; V S. 24 verlangt eine zusätzliche Prüfung.
][
*b) Modell für die Drift:* Im Draht steckt die Ladung $n e$ pro Volumen. Wandern die Elektronen mit $v_d$, fließt pro Sekunde die Ladung $n e A v_d$ durch den Querschnitt. Also $I = n e A v_d$ und $v_d = I\/(n e A)$.
][
*Einheiten angleichen und einsetzen:* $n = "8,44" dot.c 10^22 thin "cm"^(-3)$, also $A = "0,015" thin "cm"^2$. $v_d = 16\/("8,44" dot.c 10^22 dot.c "1,602" dot.c 10^(-19) dot.c "0,015") thin "cm/s" approx "0,079" thin "cm/s" = "0,79" thin "mm/s"$.
][
*Prüfen:* Die Elektronen kriechen also langsamer als eine Schnecke. Trotzdem fließt viel Strom, weil unvorstellbar viele gleichzeitig wandern.
]

// 1-17
#aufgabe(titel: "Driftgeschwindigkeit in der Kupferleitung", art: "rechnen", quelle: "1.1.3",
  ergebnis: [$A = "0,015" thin "cm"^2$, $v_d approx "0,82" thin "mm/s"$],
)[
#if not web [*Aufgabe 47* #linebreak()]
*Gegeben und Annahmen*

Kupferleitung (Daten aus V S. 9): $I = "16,66" thin "A"$, $A = "1,5" thin "mm"^2$. Elektronendichte $n="8,44" dot.c 10^22 thin "cm"^(-3)$; $e="1,602" dot.c 10^(-19) thin "C"$.

*Gesucht*

#enum(numbering: "a)",
[Rechne $A$ in cm² um und bestimme $v_d$.],
)
][
*Umrechnen:* 1 cm = 10 mm, also $1 thin "cm"^2 = 100 thin "mm"^2$. Damit $A = "1,5" thin "mm"^2 = "0,015" thin "cm"^2$. Das braucht man, weil die Elektronendichte in $"cm"^(-3)$ angegeben ist.
][
*Formel:* $v_d = I\/(n e A)$ aus $I = n e A v_d$.
][
*Einsetzen:* $v_d = "16,66"\/("8,44" dot.c 10^22 dot.c "1,602" dot.c 10^(-19) dot.c "0,015") thin "cm/s" approx "0,082" thin "cm/s" = "0,82" thin "mm/s"$.
][
*Prüfen:* Einheiten: A geteilt durch ($"cm"^(-3)$ · As · cm²) ergibt cm/s. Der Wert stimmt mit V S. 9 überein.
]

// 1-18
#aufgabe(titel: "Zulässige Stromdichte prüfen", art: "rechnen", quelle: "1.1.5",
  ergebnis: [$S = 4 thin "A/mm"^2$, innerhalb des vorgegebenen Skriptrichtbereichs],
)[
#if not web [*Aufgabe 48* #linebreak()]
*Gegeben und Annahmen*

Durch einen Leiter mit 2,5 mm² fließen 10 A. Für die Modellbeurteilung dieser Aufgabe gilt der im Lernblatt verwendete Richtbereich 1 bis 6 A/mm²; eine reale Leitungsdimensionierung ist damit nicht vollständig beschrieben.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist die Stromdichte? Liegt sie im zulässigen Bereich?],
)
][
*Formel:* Stromdichte ist Strom pro Querschnittsfläche, $S = I\/A$. Sie entscheidet über die Erwärmung, nicht der Strom allein.
][
*Einsetzen:* $S = 10 thin "A"\/"2,5" thin "mm"^2 = 4 thin "A/mm"^2$.
][
*Bewerten:* 4 A/mm² liegt innerhalb des in der Aufgabe vorgegebenen Skriptrichtbereichs von 1 bis 6 A/mm². Das erfüllt die Modellvorgabe, ist aber kein alleiniger Nachweis der thermischen Belastbarkeit einer realen Leitung (V S. 24).
]

// 1-19
#aufgabe(titel: "Kraft auf einen Leiter im Magnetfeld", art: "rechnen", quelle: "1.1.6",
  ergebnis: [$F = "0,5" thin "N"$],
)[
#if not web [*Aufgabe 49* #linebreak()]
*Gegeben und Annahmen*

Ein gerader Leiter liegt auf 20 cm Länge senkrecht in einem Magnetfeld $B = "0,5" thin "T"$ und führt 5 A.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist die Kraft?],
)
][
*Bild:* Jedes wandernde Elektron wird im Magnetfeld seitlich abgelenkt; zusammen drücken sie den ganzen Leiter zur Seite. Mehr Strom, mehr Länge im Feld und ein stärkeres Feld ergeben mehr Kraft.
][
*Formel:* Steht der Leiter senkrecht zum Feld, gilt $F = I l B$ (sonst nur der senkrechte Anteil).
][
*Einsetzen:* $l = 20 thin "cm" = "0,2" thin "m"$. $F = 5 thin "A" dot.c "0,2" thin "m" dot.c "0,5" thin "T" = "0,5" thin "N"$.
][
*Prüfen:* $1 thin "T" = 1 thin "Vs/m"^2$, also A·m·Vs/m² = VAs/m = J/m = N. Ein halbes Newton entspricht etwa der Gewichtskraft von 50 g.
]

// 1-20
#aufgabe(titel: "Ausschlag eines Drehspulinstruments", art: "rechnen", quelle: "1.1.6",
  ergebnis: [$phi = 75°$],
  tipp: [Der Ausschlag ist proportional zum Strom. Was passiert mit dem Winkel, wenn der Strom auf das 2,5-Fache steigt?],
)[
#if not web [*Aufgabe 50* #linebreak()]
*Gegeben und Annahmen*

Ein Drehspulinstrument zeigt bei 2 mA einen Ausschlag von 30°.

*Gesucht*

#enum(numbering: "a)",
[Welchen Ausschlag zeigt es bei 5 mA?],
)
][
*Warum ein Dreisatz erlaubt ist:* Im Drehspulinstrument ist das Drehmoment der Spule proportional zum Strom und wird von einer Feder ausgeglichen. Daraus folgt $phi = N A B\/D^* dot.c I$, also $phi ∼ I$.
][
*Rechnen:* Der Strom steigt von 2 mA auf 5 mA, also auf das 2,5-Fache. Der Winkel steigt genauso: $phi = 30° dot.c 5\/2 = 75°$.
][
*Prüfen:* 75° ist kleiner als 90°; der Zeiger bleibt auf der Skala.
]

// 1-21
#aufgabe(titel: "Lampen-Aufgabe mit Zahlen", art: "rechnen", quelle: "1.1.7.1",
  ergebnis: [Offen: 0,1 A, 3 V, 0,3 W. Geschlossen: 0,15 A, 4,5 V, 0,675 W],
  tipp: [Wenn S schließt, wird Lampe C überbrückt. Wie viele Lampen bleiben in Reihe?],
)[
#if not web [*Aufgabe 51* #linebreak()]
*Gegeben und Annahmen*

Lampen-Aufgabe mit $U_q = 9 thin "V"$ und $R = 30 thin Omega$ je Lampe. Drei Lampen A, B und C liegen in Reihe an der idealen Quelle. Der ideale Schalter liegt parallel zu C und überbrückt nur C, wenn er geschlossen ist. Jede Lampe wird als konstanter ohmscher Widerstand modelliert.

*Gesucht*

#enum(numbering: "a)",
[Berechne Strom, Spannung an A und Leistung von A, jeweils bei offenem und bei geschlossenem Schalter.],
)
][
*Schalter offen:* Alle drei Lampen liegen in Reihe, $R_"ges" = 90 thin Omega$. Strom $I = 9 thin "V"\/90 thin Omega = "0,1" thin "A"$. An A: $U_A = 30 thin Omega dot.c "0,1" thin "A" = 3 thin "V"$, Leistung $P_A = U_A I = "0,3" thin "W"$.
][
*Schalter geschlossen:* Der Schalter schließt C kurz; der Strom nimmt den widerstandslosen Weg. Es bleiben A und B in Reihe, $R_"ges" = 60 thin Omega$. $I = 9\/60 = "0,15" thin "A"$, $U_A = "4,5" thin "V"$, $P_A = "4,5" dot.c "0,15" = "0,675" thin "W"$.
][
*Vergleichen und prüfen:* Die Spannung an A steigt um den Faktor 1,5, die Leistung um $"1,5"^2 = "2,25"$. Das passt zu $P = U^2\/R$. A leuchtet heller, C ist aus.
]

// 1-22
#aufgabe(titel: "Eine von vier Lampen überbrückt", art: "rechnen", quelle: "1.1.7.1",
  ergebnis: [3 V vorher, 4 V nachher; Leistung × 1,78],
)[
#if not web [*Aufgabe 52* #linebreak()]
*Gegeben und Annahmen*

Vier gleiche Lampen liegen in Reihe an einer idealen 12-V-Quelle. Eine Lampe wird ideal überbrückt. Jede Lampe wird für diese Rechnung als gleicher konstanter ohmscher Widerstand modelliert.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist die Spannung an einer der übrigen Lampen vorher und nachher? Um welchen Faktor ändert sich ihre Leistung?],
)
][
*Vorher:* Vier gleiche Widerstände teilen sich die Spannung gleichmäßig: $12 thin "V"\/4 = 3 thin "V"$ je Lampe.
][
*Nachher:* Die überbrückte Lampe bekommt keine Spannung mehr. Drei Lampen teilen sich 12 V: $4 thin "V"$ je Lampe.
][
*Leistung:* Bei gleichem Widerstand gilt $P = U^2\/R$, also $P ∼ U^2$. Faktor $(4\/3)^2 = 16\/9 approx "1,78"$.
][
*Prüfen:* Die Spannung steigt um ein Drittel, die Leistung fast auf das Doppelte. Bei echten Lampen ist der Faktor etwas kleiner, weil der heißere Faden mehr Widerstand hat.
]

// 1-23
#aufgabe(titel: "Periodendauer bei 60 Hz", art: "rechnen", quelle: "1.1.7",
  ergebnis: [$T approx "16,7" thin "ms"$],
)[
#if not web [*Aufgabe 53* #linebreak()]
*Gegeben und Annahmen*

Netzfrequenz in den USA: 60 Hz.

*Gesucht*

#enum(numbering: "a)",
[Wie lang ist eine Periode?],
)
][
*Bedeutung der Frequenz:* 60 Hz heißt, die Spannung wiederholt sich 60-mal pro Sekunde. Eine Wiederholung dauert also den 60. Teil einer Sekunde: $T = 1\/f$.
][
*Rechnen:* $T = 1\/(60 thin "Hz") approx "0,0167" thin "s" = "16,7" thin "ms"$.
][
*Prüfen:* In Europa sind es 50 Hz und 20 ms. Höhere Frequenz bedeutet kürzere Periode.
]

// 1-24
#aufgabe(titel: "Induzierte Spannung bei steigendem Fluss", art: "rechnen", quelle: "1.2.2",
  ergebnis: [$abs(u_i) = 10 thin "V"$],
  tipp: [Die Spannung hängt davon ab, wie *schnell* sich der Fluss ändert, und von der Windungszahl.],
)[
#if not web [*Aufgabe 54* #linebreak()]
*Gegeben und Annahmen*

Eine Spule mit 500 Windungen; der Fluss steigt in 0,1 s gleichmäßig von 0 auf 2 mWb.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist $abs(u_i)$?],
)
][
*Induktionsgesetz:* Jede Windung „spürt“ die Flussänderung und liefert ihren Beitrag; die Windungen liegen in Reihe. Deshalb $abs(u_i) = N dot.c Delta Phi\/Delta t$ bei gleichmäßiger Änderung.
][
*Werte:* $N = 500$, $Delta Phi = 2 thin "mWb" = 2 dot.c 10^(-3) thin "Vs"$, $Delta t = "0,1" thin "s"$.
][
*Einsetzen:* $abs(u_i) = 500 dot.c 2 dot.c 10^(-3) thin "Vs"\/"0,1" thin "s" = 10 thin "V"$.
][
*Prüfen:* Vs/s = V. Zehnmal schneller ändern würde zehnmal mehr Spannung liefern.
]

// 1-25
#aufgabe(titel: "Spule aus dem Feld gezogen", art: "rechnen", quelle: "1.2.2",
  ergebnis: [$Delta Phi = "1,6" dot.c 10^(-4) thin "Vs"$, $abs(u_i) = "1,6" thin "V"$],
  tipp: [Zuerst den Fluss in der Spule berechnen. Nach dem Herausziehen ist er null.],
)[
#if not web [*Aufgabe 55* #linebreak()]
*Gegeben und Annahmen*

Eine Spule mit 500 Windungen und 4 cm² Querschnitt steckt in einem Feld mit $B = "0,4" thin "T"$. Sie wird in 50 ms ganz aus dem Feld gezogen.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist $abs(u_i)$ bei gleichmäßiger Änderung?],
)
][
*Fluss vorher:* Der Fluss ist Flussdichte mal durchsetzte Fläche, $Phi = B A$. Mit $A = 4 thin "cm"^2 = 4 dot.c 10^(-4) thin "m"^2$: $Phi = "0,4" thin "T" dot.c 4 dot.c 10^(-4) thin "m"^2 = "1,6" dot.c 10^(-4) thin "Vs"$.
][
*Änderung:* Außerhalb des Feldes ist der Fluss null. Die Änderung ist also der ganze Fluss: $Delta Phi = "1,6" dot.c 10^(-4) thin "Vs"$.
][
*Induktionsgesetz:* $abs(u_i) = N Delta Phi\/Delta t = 500 dot.c "1,6" dot.c 10^(-4)\/"0,05" thin "V" = "1,6" thin "V"$.
][
*Prüfen:* Die Flächeneinheit ist der häufigste Fehler: 4 cm² sind $4 dot.c 10^(-4)$ m², nicht $4 dot.c 10^(-2)$.
]

// 1-26
#aufgabe(titel: "Laufzeit einer Powerbank", art: "rechnen", quelle: "1.1.2",
  ergebnis: [$t = "12,5" thin "h"$],
)[
#if not web [*Aufgabe 56* #linebreak()]
*Gegeben und Annahmen*

Eine Powerbank speichert 10 Ah. Ein Gerät zieht konstant 0,8 A.

*Gesucht*

#enum(numbering: "a)",
[Wie lange reicht die Ladung?],
)
][
*Was heißt Ah?* Amperestunden sind Strom mal Zeit, also eine Ladung. 10 Ah heißt: 10 A eine Stunde lang, oder 1 A zehn Stunden lang.
][
*Rechnen:* Aus $Q = I t$ folgt $t = Q\/I = 10 thin "Ah"\/"0,8" thin "A" = "12,5" thin "h"$.
][
*Prüfen:* Ah geteilt durch A ergibt h. In der Praxis ist es etwas weniger, weil die Elektronik der Powerbank selbst Verluste hat.
]

// 1-27
#aufgabe(titel: "Entladezeit des Auto-Akkus", art: "rechnen", quelle: "1.1.2")[
#if not web [*Aufgabe 57* #linebreak()]
*Auto-Akku, Ü 2 und V S. 7:*

*Gegeben und Annahmen*

In einem vollgeladenen 12-V-Akku sind 36 Ah gespeichert.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist die theoretische Entladezeit mit zwei parallelen Scheinwerferlampen zu je 42 W?],
)
][
Strom je Lampe: $I = P\/U = 42\/12 = "3,5" thin "A"$; beide parallel: $sum I = 7 thin "A"$
][
Entladezeit: $t = Q_"max"\/sum I = 36 thin "Ah"\/7 thin "A" approx "5,14" thin "h"$
][
*Ergebnis:* $t approx 308 thin "min"$, wie auf dem Übungsblatt. *Prüfung:* Ah geteilt durch A ergibt h; die Ladung sinkt linear, weil der Strom konstant ist.
]

// 1-28
#aufgabe(titel: "E-Bike-Akku", art: "rechnen", quelle: "1.1.2",
  ergebnis: [a) $I approx "6,94" thin "A"$ b) $t approx "2,0" thin "h"$ c) $W = 504 thin "Wh"$],
)[
#if not web [*Aufgabe 58* #linebreak()]
*E-Bike-Akku:*

*Gegeben und Annahmen*

36 V und 14 Ah, der Motor nimmt 250 W auf.

*Gesucht*

#enum(numbering: "a)",
[Welcher Strom fließt?],
[Wie lange kann man fahren?],
[Wie viel Energie in Wh steckt im Akku?],
)
][
*a) Strom aus der Leistung:* $P = U I$, also $I = P\/U = 250 thin "W"\/36 thin "V" approx "6,94" thin "A"$.
][
*b) Fahrzeit aus der Ladung:* Der Akku speichert 14 Ah Ladung. Bei 6,94 A: $t = Q\/I = 14 thin "Ah"\/"6,94" thin "A" approx "2,0" thin "h"$.
][
*c) Energie:* Ladung mal Spannung ergibt Energie: $W = U Q = 36 thin "V" dot.c 14 thin "Ah" = 504 thin "Wh"$.
][
*Prüfen auf zweitem Weg:* $504 thin "Wh"\/250 thin "W" approx "2,0" thin "h"$, dieselbe Fahrzeit. Hier treffen sich Leistung (Kapitel 0) und Ladung (Kapitel 1).
]

// 1-29
#aufgabe(titel: "Drehspulinstrument bei 36°", art: "rechnen", quelle: "1.1.6",
  ergebnis: [a) 0,4 mA b) 2 mC],
)[
#if not web [*Aufgabe 59* #linebreak()]
*Drehspulinstrument:*

*Gegeben und Annahmen*

Vollausschlag 90° bei 1 mA.

*Gesucht*

#enum(numbering: "a)",
[Welcher Strom fließt bei 36°?],
[Welche Ladung fließt bei diesem Strom in 5 s durch das Instrument?],
[Warum darfst du hier mit einem Dreisatz rechnen?],
)
][
*c) zuerst: Warum Dreisatz?* Beim Drehspulinstrument gilt $phi = N A B\/D^* dot.c I$. Alles vor $I$ ist konstant, also ist der Winkel proportional zum Strom. Nur bei einer solchen Proportionalität ist der Dreisatz erlaubt.
][
*a) Strom:* 36° sind $36\/90 = "0,4"$ des Vollausschlags, also $I = "0,4" dot.c 1 thin "mA" = "0,4" thin "mA"$.
][
*b) Ladung:* $Q = I t = "0,4" thin "mA" dot.c 5 thin "s" = 2 thin "mAs" = 2 thin "mC"$.
][
*Prüfen:* Kleiner Winkel, kleiner Strom: 36° liegt unter der Hälfte von 90°, und 0,4 mA unter der Hälfte von 1 mA.
]

// 1-30
#aufgabe(titel: "Spannung eines Thermoelements", art: "rechnen", quelle: "1.2.3",
  ergebnis: [a) 3 mV b) −3 mV c) 0 V],
  tipp: [Das Thermoelement misst keine Temperatur, sondern eine *Temperaturdifferenz*.],
)[
#if not web [*Aufgabe 60* #linebreak()]
*Thermoeffekt, eigene Ergänzung zu V S. 17:*

*Gegeben und Annahmen*

Ein Cu–Konstantan-Thermoelement hat die Messstelle bei 80 °C, die Vergleichsstelle bei 20 °C. Verwende $K = "0,05" thin "mV/K"$.

*Gesucht*

#enum(numbering: "a)",
[Berechne die Spannung.],
[Was ändert sich beim Vertauschen der Temperaturen?],
[Was misst du, wenn beide Stellen bei 80 °C liegen?],
)
][
*Prinzip:* An jeder Verbindungsstelle zweier Metalle entsteht eine kleine temperaturabhängige Spannung. Im Kreis liegen zwei Stellen gegeneinander; übrig bleibt nur der Unterschied: $U_q = K Delta vartheta$.
][
*a) Spannung:* $Delta vartheta = 80 - 20 = 60 thin "K"$, also $U_q = "0,05" thin "mV/K" dot.c 60 thin "K" = 3 thin "mV"$.
][
*b) Vertauscht:* $Delta vartheta = -60 thin "K"$, also $U_q = -3 thin "mV"$. Gleicher Betrag, umgekehrte Polung.
][
*c) Gleiche Temperatur:* $Delta vartheta = 0$, also $U_q = 0$, obwohl es 80 °C heiß ist. *Prüfen:* mV/K mal K ergibt mV.
]

// 1-31
#aufgabe(titel: "Fotoeffekt in Silizium", art: "verstehen", quelle: "1.2.4.1")[
#if not web [*Aufgabe 61* #linebreak()]
*Fotoeffekt, eigene Ergänzung zu V S. 18–19:* Silizium hat die Bandlücke 1,12 eV und die Grenzwellenlänge rund 1,11 µm. a) Können Photonen mit 850 nm bzw. 1550 nm im einfachen Bandlückenmodell Elektron-Loch-Paare erzeugen? b) Hilft bei ungeeigneter Wellenlänge einfach mehr Licht? Begründe mit der Energie eines Photons.
][
a) 850 nm = 0,85 µm liegt unter der Grenzwellenlänge: im Modell genügend Energie. 1550 nm = 1,55 µm liegt darüber: zu wenig Energie. b) Mehr Photonen gleicher Wellenlänge ändern die Energie pro Photon $h c/lambda$ nicht; im einfachen Modell reicht mehr langwelliges Licht deshalb nicht.
]

// 1-32
#aufgabe(titel: "Direkter und umgekehrter Piezoeffekt", art: "verstehen", quelle: "1.2.5")[
#if not web [*Aufgabe 62* #linebreak()]
*Piezoeffekt, eigene Verständnisfrage zu V S. 19:* Erkläre den direkten und den umgekehrten Effekt jeweils an einer Anwendung. Welche Material- und Richtungsbedingung musst du beachten?
][
Direkt: Eine mechanische Kraft auf den Kristall erzeugt ein elektrisches Signal, etwa beim Kristallmikrofon. Umgekehrt: Eine Spannung verformt den Kristall, etwa zur Ultraschallerzeugung. Der Kristall muss piezoelektrisch sein und in der passenden Richtung beansprucht werden.
]

// 1-33
#aufgabe(titel: "Grenzwellenlänge für Germanium", art: "rechnen", quelle: "1.2.4.1")[
#if not web [*Aufgabe 63* #linebreak()]
*Grenzwellenlänge, eigene Rechenvariation zu Tabelle 1.1:*

*Gegeben und Annahmen*

Germanium bei 300 K: Bandlücke $W="0,67" thin "eV"$. $h="6,626" dot.c 10^(-34) thin "Js"$, $c=299792458 thin "m/s"$, $1 thin "eV"="1,602176634" dot.c 10^(-19) thin "J"$. Ideale Schwelle: Photonenergie gleich Bandlücke.

*Gesucht*

#enum(numbering: "a)",
[Berechne die Grenzwellenlänge in µm und vergleiche mit dem Tabellen-Richtwert 1,85 µm.],
)
][
*Modell:* Ideale Schwelle bei Photonenergie gleich Bandlücke; Bandlücke bei 300 K.
][
Energie umrechnen: $W = "0,67" dot.c "1,602176634" dot.c 10^(-19) thin "J" approx "1,07346" dot.c 10^(-19) thin "J"$.
][
Einsetzen: $lambda_g = (h c)/W = ("6,626" dot.c 10^(-34) thin "Js" dot.c 299792458 thin "m/s")/("1,07346" dot.c 10^(-19) thin "J") approx "1,8505" dot.c 10^(-6) thin "m"$.
][
*Ergebnis: rund 1,85 µm*, passend zur Tabelle. *Prüfung:* Js × m/s geteilt durch J ergibt m. Germanium hat eine kleinere Bandlücke als Silizium, deshalb liegt die Grenzwellenlänge weiter im Langwelligen.
]

// 1-34
#aufgabe(titel: "Temperatur aus Thermospannung", art: "rechnen", quelle: "1.2.3",
  ergebnis: [Messstelle 85 °C],
)[
#if not web [*Aufgabe 64* #linebreak()]
*Temperatur aus Spannung, eigene Ergänzung:*

*Gegeben und Annahmen*

Ein Cu–Konstantan-Thermoelement liefert in der gewählten Polung +3 mV. Die Vergleichsstelle hat 25 °C. Cu–Konstantan: $K="0,05" thin "mV/K"$ wird im betrachteten Bereich als konstant angenommen; positive Spannung bedeutet Messstelle wärmer.

*Gesucht*

#enum(numbering: "a)",
[Wie warm ist die Messstelle bei Verwendung des Skriptkoeffizienten?],
[Welche Annahme steckt darin?],
)
][
*Umkehren:* Das Thermoelement liefert $U_q = K Delta vartheta$. Gesucht ist die Differenz: $Delta vartheta = U_q\/K = 3 thin "mV"\/("0,05" thin "mV/K") = 60 thin "K"$.
][
*Auf die Messstelle schließen:* Die Differenz sagt nur, wie viel wärmer die Messstelle ist. Dazu die bekannte Vergleichstemperatur: $25 thin "°C" + 60 thin "K" = 85 thin "°C"$.
][
*Annahmen und Prüfung:* Positive Spannung heißt hier „Messstelle wärmer“; der Koeffizient $K$ ist im Bereich etwa konstant. mV geteilt durch mV/K ergibt K.
]

// 1-35
#aufgabe(titel: "Takt aus dem Schwingquarz", art: "rechnen", quelle: "1.2.5",
  ergebnis: [$f_"Takt" = 2 thin "Hz"$, $T = "0,5" thin "s"$],
)[
#if not web [*Aufgabe 65* #linebreak()]
*Schwingquarz, eigene Variation zu V S. 19:*

*Gegeben und Annahmen*

Ein Quarz schwingt mit 32768 Hz. Eine Elektronik teilt diesmal nur durch $2^14$.

*Gesucht*

#enum(numbering: "a)",
[Welche Taktfrequenz und Periodendauer entstehen? Ändert die Frequenzteilung die mechanische Quarzfrequenz?],
)
][
*Warum 32768?* $32768 = 2^15$. Ein Zähler, der immer halbiert, kommt nach 15 Stufen genau auf 1 Hz; hier sind es nur 14 Stufen.
][
*Taktfrequenz:* $2^14 = 16384$, also $f_"Takt" = 32768 thin "Hz"\/16384 = 2 thin "Hz"$.
][
*Periodendauer:* $T = 1\/f_"Takt" = "0,5" thin "s"$.
][
*Deuten:* Der Quarz schwingt unverändert mit 32768 Hz. Die Elektronik zählt nur die Schwingungen und gibt jeden 16384. Impuls aus.
]

// 1-36
#aufgabe(titel: "Einschalten einer Spule", art: "rechnen", quelle: "1.2.6.1")[
#if not web [*Aufgabe 66* #linebreak()]
*Spule, eigene Rechenaufgabe zu N PDF-S. 3:*

*Gegeben und Annahmen*

Die 12-V-Quelle wird an $R = 10 thin Omega$, $L = 10 thin "mH"$ eingeschaltet; anfangs fließt kein Strom.

*Gesucht*

#enum(numbering: "a)",
[Bestimme Endstrom und Zeitkonstante.],
[Berechne Strom und Spulenspannung nach einer Zeitkonstante.],
[Was geschieht mit Endstrom und Zeitkonstante, wenn $R$ auf 20 Ω steigt?],
)
][
*Modell:* Ideale Gleichspannungsquelle, lineare ideale Spule, konstanter Serienwiderstand, $i(0) = 0$.
][
Endstrom: $I_oo = U_q/R = 12 thin "V"/(10 thin Omega) = "1,2" thin "A"$.
][
Zeitkonstante: $tau = L/R = "0,010" thin "H"/(10 thin Omega) = 1 thin "ms"$.
][
Bei $t = tau$: $i = "1,2" (1 - e^(-1)) thin "A" approx "0,759" thin "A"$; $u_L = 12 e^(-1) thin "V" approx "4,415" thin "V"$.
][
Bei 20 Ω: $I_oo = "0,6" thin "A"$, $tau = "0,5" thin "ms"$. Der Endstrom wird kleiner; sein relativer Aufbau erfolgt schneller.
][
*Ergebnis:* Nach 1 ms liegt der Strom bei *rund 0,759 A*. *Prüfung:* $R i + u_L approx "7,585" thin "V" + "4,415" thin "V" = 12 thin "V"$; H/Ω = (Vs/A)/(V/A) = s.
]

// 1-37
#aufgabe(titel: "Magnetfeld und Induktion", art: "verstehen", quelle: "1.1.6")[
#if not web [*Aufgabe 67* #linebreak()]
*Magnetfeld, FK 28 als offene Frage; am 22.10. bearbeitet:* a) Erzeugt auch ein Strom von 0,5 A ein Magnetfeld? b) Eine Spule und ein Magnetfeld ruhen unverändert gegeneinander: Wird Spannung induziert? c) Kann in einem zeitlich konstanten Magnetfeld trotzdem eine Spannung induziert werden? Nenne eine passende Bewegung und die entscheidende Bedingung.
][
a) Ja, jeder Strom erzeugt ein Magnetfeld; dafür gibt es keine 1-A-Schwelle. b) Nein: Der Fluss bleibt konstant. c) Ja: etwa beim Herausziehen der Spule aus dem Feld oder beim Drehen der Spule. Entscheidend ist die Änderung des magnetischen Flusses durch ihre Fläche; eine Bewegung, bei der der Fluss unverändert bleibt, genügt nicht.
]

// 1-38
#aufgabe(titel: "Diode mit Vorwiderstand", art: "rechnen", quelle: "1.2.6",
  ergebnis: [a) $I approx "20,9" thin "mA"$ b) $R = 690 thin Omega$],
  tipp: [Die Diode „verbraucht“ ihre 2,1 V. Was bleibt für den Widerstand übrig?],
)[
#if not web [*Aufgabe 68* #linebreak()]
*Diode, eigene Variation zur 9-V-Randnotiz:*

*Gegeben und Annahmen*

Am Arbeitspunkt liegen an einer Diode 2,1 V. Sie ist mit 330 Ω in Reihe an 9 V angeschlossen.

*Gesucht*

#enum(numbering: "a)",
[Welcher Strom fließt?],
[Welcher Vorwiderstand ergibt näherungsweise 10 mA, wenn die Diodenspannung dort ebenfalls mit 2,1 V angesetzt wird? Warum ist der Schnittpunkt der Kennlinien die genauere Methode?],
)
][
*Maschenregel:* Die 9 V teilen sich auf Diode und Widerstand auf. Am Widerstand liegen $9 - "2,1" = "6,9" thin "V"$.
][
*a) Strom:* Derselbe Strom fließt durch beide, und am Widerstand gilt das ohmsche Gesetz: $I = "6,9" thin "V"\/330 thin Omega approx "0,0209" thin "A" = "20,9" thin "mA"$.
][
*b) Vorwiderstand für 10 mA:* $R = "6,9" thin "V"\/"0,010" thin "A" = 690 thin Omega$.
][
*Warum Kennlinie genauer:* Die Diodenspannung ist in Wirklichkeit nicht fest, sie hängt vom Strom ab. Der Schnittpunkt von Diodenkennlinie und Widerstandsgerade berücksichtigt das. *Prüfen:* $"2,1" + "6,9" = 9 thin "V"$.
]

// 1-39
#aufgabe(titel: "Spannung und Leistung am Fotoelement", art: "rechnen", quelle: "1.2.4",
  ergebnis: [$U = 2 thin "V"$, $P = 40 thin mu"W"$],
)[
#if not web [*Aufgabe 69* #linebreak()]
*Fotostrom, eigene Anwendung zu V S. 18:*

*Gegeben und Annahmen*

Im betrachteten Arbeitspunkt fließen 20 µA durch den äußeren Widerstand von 100 kΩ.

*Gesucht*

#enum(numbering: "a)",
[Welche Spannung und Leistung entstehen dort?],
[Welche Bedingung musst du prüfen, bevor du denselben Strom für einen anderen Lastwiderstand annimmst?],
)
][
*Spannung:* $U = I R = 20 dot.c 10^(-6) thin "A" dot.c 100 dot.c 10^3 thin Omega = 2 thin "V"$. Mikro mal Kilo ergibt Milli; $20 dot.c 100 thin "mV" = 2 thin "V"$.
][
*Leistung:* $P = U I = 2 thin "V" dot.c 20 thin mu"A" = 40 thin mu"W"$.
][
*Bedingung:* Der Fotostrom ist nicht für jeden Widerstand gleich. Bei anderer Last stellt sich ein neuer Arbeitspunkt auf der beleuchteten Kennlinie ein; den musst du prüfen. *Prüfen:* A·Ω = V, V·A = W.
]

// 1-40
#aufgabe(titel: "Flussdichte aus dem Ladungsimpuls", art: "rechnen", quelle: "1.2.2")[
#if not web [*Aufgabe 70* #linebreak()]
*Magnetfeldmessung, eigene Rechenaufgabe nach V S. 16–17:*

*Gegeben und Annahmen*

Eine Messspule mit 200 Windungen und 4 cm² Fläche wird vollständig aus einem homogenen, senkrecht durch die Spulenfläche gerichteten Magnetfeld gezogen. Gesamtwiderstand 100 Ω, gemessene Ladung 2 µC.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist der Betrag der Flussdichte?],
[Was passiert mit dem Ladungsimpuls bei doppelt so schnellem Herausziehen, wenn alle Modellannahmen bestehen bleiben?],
)
][
*Modell:* Spule wird vom ursprünglichen Feld vollständig in den feldfreien Bereich gezogen; Fläche und Orientierung sind definiert, der Gesamtwiderstand ist konstant. Die Formel vernachlässigt Einflüsse der Selbstinduktion während des Messimpulses.
][
Fläche: $A = 4 thin "cm"^2 = 4 dot.c 10^(-4) thin "m"^2$; Ladung: $Q = 2 dot.c 10^(-6) thin "As"$.
][
Flussdichte: $B = (R Q)/(N A) = (100 thin Omega dot.c 2 dot.c 10^(-6) thin "As")/(200 dot.c 4 dot.c 10^(-4) thin "m"^2) = "0,0025" thin "T"$.
][
*Ergebnis: 2,5 mT.* Schnelleres Herausziehen vergrößert die Impulshöhe und verkürzt die Dauer. Bei gleichem Anfangs- und Endfluss bleibt die Fläche unter der Stromkurve, also $Q$, unverändert. *Prüfung:* Ω × As/m² = Vs/m² = T.
]



#aufgabe(titel: "Potenzialtreppe mit frei gewählter Masse", art: "rechnen", quelle: "1.3",
 ergebnis: [$U_q = 90 thin "V"$; $R_1 = 3 thin "k"Omega$, $R_2 = 2 thin "k"Omega$, $R_3 = 4 thin "k"Omega$.], tipp: [Beginne bei D und gehe mit bzw. gegen die Spannungsabfälle.])[
#if not web [*Aufgabe 71* #linebreak()]
*Gegeben und Annahmen:* Reihenschaltung aus drei Widerständen, $I = 10 thin "mA"$. In technischer Stromrichtung lautet die Reihenfolge: B → C (idealer Draht) → R1 → D → R2 → E → R3 → F → A (idealer Draht). Die Spannungsabfälle sind $U_1 = 30 thin "V"$, $U_2 = 20 thin "V"$, $U_3 = 40 thin "V"$. Die Quelle verbindet A zurück mit B. Bezugspunkt D: 0 V.
*Gesucht:*
#enum(numbering: "a)")[Potenziale von A bis F und Quellspannung.][Widerstände R1 bis R3.][Als eigene Variation: Potenziale mit E als neuem Nullpunkt und die dabei unveränderte Spannung zwischen B und A.]
#src[N30, PDF-S. 1 = V S. 20; Teil c eigene Variation.]
][*Bezugspunkt festlegen:* D hat 0 V. Gegen die Stromrichtung über R1 steigt das Potenzial um 30 V. Daher sind $phi_C = phi_B = 30 thin "V"$. Hinter R2 liegt $phi_E = -20 thin "V"$, hinter R3 $phi_F = phi_A = -60 thin "V"$. Ideale Drähte ändern das Potenzial nicht.
][*Quellspannung bestimmen:* Die Quelle hebt das Potenzial von A nach B an. $U_q = phi_B - phi_A = 30 - (-60) = 90 thin "V"$. Das stimmt mit $30 + 20 + 40 = 90$ V aus den Widerständen überein.
][*Ohmsches Gesetz anwenden:* Jeder Widerstand führt denselben Strom 0,010 A. Deshalb $R_1 = 30/"0,010" = 3000 thin Omega$, $R_2 = 2000 thin Omega$ und $R_3 = 4000 thin Omega$. Spannung geteilt durch Strom ergibt Ω.
][*Nullpunkt verschieben und prüfen:* E lag bisher bei −20 V. Addiere zu allen Potenzialen 20 V: B und C = 50 V, D = 20 V, E = 0 V, A und F = −40 V. $U_(B A) = 50 - (-40) = 90 thin "V"$ bleibt gleich. Nur die Bezugswerte, nicht die Spannungsdifferenzen, ändern sich.]


#aufgabe(titel: "Zwei Spannungsteiler und ein offener Querzweig", art: "rechnen", quelle: "1.3",
 ergebnis: [$phi_A = 5 thin "V"$, $phi_B = 8 thin "V"$, $U_(A B) = -3 thin "V"$.], tipp: [Die Ausgangsspannung jedes offenen Teilers liegt am unteren Widerstand.])[
#if not web [*Aufgabe 72* #linebreak()]
*Gegeben und Annahmen:* Beide Zweige liegen an einer idealen 10-V-Quelle. Zwischen den oberen 10 V und A liegen 5 Ω, zwischen A und Masse weitere 5 Ω. Zwischen den oberen 10 V und B liegen 2 Ω, zwischen B und Masse 8 Ω. A und B sind zunächst nicht verbunden.
*Gesucht:*
#enum(numbering: "a)")[Potenziale A und B sowie die vorzeichenrichtigen Spannungen UAB und UBA.][Richtung eines Stroms beim Anschließen eines Querwiderstands zwischen A und B.][Warum die beiden unbelasteten Potenziale dann nicht unverändert eingesetzt werden dürfen.]
#src[N30, PDF-S. 2 = V S. 21.]
][*Unbelastete Teiler auswerten:* Jeder Zweig hat insgesamt 10 Ω und führt deshalb 1 A. A liegt um $1 thin "A" dot.c 5 thin Omega = 5 thin "V"$ über Masse, B um $1 thin "A" dot.c 8 thin Omega = 8 thin "V"$.
][*Spannungsrichtung beachten:* $U_(A B) = phi_A - phi_B = -3 thin "V"$, $U_(B A) = +3 thin "V"$. Ein passiver Querwiderstand lässt den technischen Strom vom zunächst höheren Potenzial B nach A fließen.
][*Belastung erklären:* Der Querzweig verändert die Knotenbilanzen. Die oberen und unteren Widerstände eines ursprünglichen Teilers führen dann nicht mehr zwangsläufig denselben Strom. Die neue Schaltung braucht gekoppelte Knoten- oder Maschengleichungen; die offenen Werte sind dafür keine feste Spannungsquelle.]


#aufgabe(titel: "Motorzuleitung: Querschnitt und Potenziale", art: "rechnen", quelle: "1.4.2",
 ergebnis: [$A_"min" = "4,45" thin "mm"^2$; gewählt 6 mm²; dann $U_M approx "217,03" thin "V"$.], tipp: [Zähle die Länge beider Leiter oder rechne mit 2 V und 25 m pro Leiter.])[
#if not web [*Aufgabe 73* #linebreak()]
*Gegeben und Annahmen:* Ideale Quelle mit 220 V, Motorstrom konstant 20 A. Kupfer-Hinleiter und -Rückleiter sind je 25 m lang und haben gleichen Querschnitt. $rho = "0,0178" thin Omega thin "mm"^2/"m"$. Am Motor sollen mindestens 216 V anliegen. Verfügbare Querschnitte: 1; 1,5; 2,5; 4; 6; 10 mm². A liegt am Quellenplus, B am Motorplus, C am Motorminus, D am Quellenminus; C ist Masse.
*Gesucht:*
#enum(numbering: "a)")[Maximaler gesamter Leitungswiderstand, Mindestquerschnitt und Auswahl aus der Reihe.][Potenziale A, B, C und D im Grenzfall mit genau 2 V Abfall je Leiter.][Als Nachrechnung: tatsächliche Motorspannung bei 6 mm² und weiterhin 20 A; welche zusätzliche Prüfung zur realen Auslegung fehlt.]
#src[N30, PDF-S. 4–5 = V S. 23–24; Nachrechnung mit 6 mm² ergänzt.]
][*Spannungsbudget wählen:* Von 220 V dürfen 4 V auf der Leitung bleiben. Da Hin- und Rückleiter in Reihe liegen, gilt $R_"L,ges,max" = 4 thin "V"/(20 thin "A") = "0,2" thin Omega$, also 0,1 Ω je Leiter.
][*Geometrie berechnen:* Für die gesamte Leiterlänge 50 m gilt $A_"min" = rho l/R = "0,0178" dot.c 50/"0,2" thin "mm"^2 = "4,45" thin "mm"^2$. 4 mm² reichen nicht; aus der Reihe sind *6 mm²* zu wählen.
][*Potenziale mit C = 0 bestimmen:* Am Motor liegt B um 216 V höher: $phi_B = 216 thin "V"$. Der Hinleiter führt von A nach B und verliert 2 V, also $phi_A = 218 thin "V"$. Der Rückleiter führt von C nach D und verliert 2 V, also $phi_D = -2 thin "V"$. Prüfung: $phi_A - phi_D = 220 thin "V"$.
][*Gewählten Querschnitt nachrechnen:* $R_"L,ges" = "0,0178" dot.c 50/6 approx "0,1483" thin Omega$. Bei 20 A fallen insgesamt rund 2,967 V ab, also $U_M approx "217,03" thin "V"$. Das erfüllt die Spannungsforderung. Die thermische Belastbarkeit muss zusätzlich geprüft werden; die Potenziale aus Teil b gehören zum dort angenommenen Grenzfall und sind nicht unverändert die Werte dieser Nachrechnung.]


#aufgabe(titel: "PTC und NTC: Wärme kann Ursache und Folge sein", art: "verstehen", quelle: "1.4.3",
 ergebnis: [PTC: Widerstand steigt bei Wärme; NTC: Widerstand sinkt.], tipp: [Unterscheide äußere Temperatur und Erwärmung durch die Messung selbst.])[
#if not web [*Aufgabe 74* #linebreak()]
Erkläre den Unterschied zwischen PTC und NTC. Warum kann eine Glühlampe beim Einschalten einen hohen Strom ziehen? Warum soll sich ein NTC zur Temperaturmessung möglichst wenig selbst erwärmen?
#src[N30, PDF-S. 7–8 = V S. 26–27.]
][*Temperaturrichtung trennen:* Beim PTC steigt der Widerstand mit der Temperatur, beim NTC sinkt er. Die Namen beziehen sich auf den Temperaturkoeffizienten, nicht auf die Höhe einer fest vorgegebenen Spannung.
][*Einschalten erklären:* Die kalte Wolframwendel hat einen viel kleineren Widerstand als im heißen Betrieb. Bei gleicher anliegender Spannung kann zunächst ein größerer Strom fließen. Die genaue Stromänderung hängt zusätzlich vom übrigen Stromkreis ab.
][*Messung prüfen:* Ein Messstrom erzeugt Verlustwärme. Erwärmt diese den NTC deutlich, misst er nicht mehr nur die Umgebungstemperatur. Seine Messleistung muss deshalb klein genug sein.]


#aufgabe(titel: "NTC-Widerstand mit Kelvin im Exponenten", art: "rechnen", quelle: "1.4.3.2.2",
 ergebnis: [$R(373 thin "K") approx "1,29" thin "k"Omega$.], tipp: [Ein größerer Kelvinwert hat einen kleineren Kehrwert.])[
#if not web [*Aufgabe 75* #linebreak()]
*Gegeben und Annahmen:* NTC-Modell $R(T) = R_(T_0) e^(B(1/T-1/T_0))$, $R_(T_0) = 10 thin "k"Omega$, $T_0 = 293 thin "K"$, $B = 2800 thin "K"$. Zieltemperatur 373 K; Selbsterwärmung vernachlässigt.
*Gesucht:*
#enum(numbering: "a)")[Widerstand bei 373 K.][Vorzeichen und Einheit des Exponenten.][Einordnung der groben Angabe 1,5 kΩ aus der Skriptskizze.]
#src[N30, PDF-S. 8 = V S. 27.]
][*Modell auswählen:* Der angegebene NTC folgt einer Exponentialbeziehung. Die Temperaturen sind bereits in Kelvin gegeben und dürfen direkt als Kehrwerte eingesetzt werden.
][*Dimensionslosen Exponenten bilden:* $x = 2800 thin "K" dot.c (1/(373 thin "K") - 1/(293 thin "K")) approx -"2,050"$. Die Einheiten K kürzen sich; der Exponent ist negativ, weil 373 K größer als die Bezugstemperatur ist.
][*Einsetzen und prüfen:* $R = 10 thin "k"Omega dot.c e^(-"2,050") approx "1,29" thin "k"Omega$. Der Widerstand sinkt, wie es für einen NTC sein muss. Die Skizzenangabe 1,5 kΩ ist eine grobe Kennlinienbeschriftung; die Rechnung mit diesen Parametern ergibt etwa 1,29 kΩ.]


#aufgabe(titel: "Varistor: Spannung verdoppelt, Strom nicht nur verdoppelt", art: "rechnen", quelle: "1.4.3.2.3",
 ergebnis: [Bei 220 V: 1 A, 220 Ω; bei 440 V: 32 A, 13,75 Ω.], tipp: [Der gesamte dimensionslose Spannungsquotient steht in der fünften Potenz.])[
#if not web [*Aufgabe 76* #linebreak()]
*Gegeben und Annahmen:* Für die positive Kennlinie eines Varistormodells gilt $I/(1 thin "A") = (U/(220 thin "V"))^5$.
*Gesucht:*
#enum(numbering: "a)")[Strom und statischer Widerstand bei 220 V.][Strom und statischer Widerstand bei 440 V.][Erklärung, weshalb das Bauteil zur Begrenzung von Spannungsspitzen eingesetzt wird.]
#src[N30, PDF-S. 9 = V S. 28; zweite Spannung eigene Rechenvariation, keine Belastbarkeitszusage.]
][*Bezugswert einsetzen:* Bei 220 V ist das Verhältnis $U/(220 thin "V") = 1$. Damit $I = 1 thin "A"$ und $R = U/I = 220 thin Omega$.
][*Potenz beachten:* Bei 440 V verdoppelt sich die Spannung. Der Strom wächst auf $2^5 thin "A" = 32 thin "A"$, nicht auf 2 A. Dann ist $R = 440/32 thin Omega = "13,75" thin Omega$.
][*Physikalisch deuten:* Das Bauteil wird bei höherer Spannung viel leitfähiger. Parallel zur empfindlichen Schaltung kann es einen großen Teil des Überspannungsstroms aufnehmen. Prüfung: Die Widerstandsänderung zeigt die Nichtlinearität; konkrete Grenzenergien und Belastbarkeiten sind in dieser Modellgleichung nicht angegeben.]


#aufgabe(titel: "BAY41: Sättigungsstrom und zwei Widerstandsbegriffe", art: "rechnen", quelle: "1.4.3.2.4",
 ergebnis: [$I_D approx 2 thin "mA"$, $I_S approx 190 thin "fA"$, $R_D = 300 thin Omega$, $r_e approx 13 thin Omega$.], tipp: [Zuerst die Kennlinie ablesen, dann das Modell im Arbeitspunkt auswerten.])[
#if not web [*Aufgabe 77* #linebreak()]
*Gegeben und Annahmen:* Gedruckte BAY41-Kennlinie bei 300 K; ideales Shockley-Modell mit $n = 1$. Verwende wie im Skript die gerundete Temperaturspannung $U_T = 26 thin "mV"$. $I_D = I_S(e^(U_D/U_T)-1)$.
#image("abbildungen/vl30-bay41.svg", width: 78%)
*Gesucht:*
#enum(numbering: "a)")[Strom bei $U_D = "0,6" thin "V"$ aus der Kennlinie und daraus der Modellparameter $I_S$.][Statischer Widerstand $R_D = U_D/I_D$.][Differenzieller Widerstand $r_e approx U_T/I_D$ und Erklärung des Unterschieds.]
#src[N30, PDF-S. 11–12 = V S. 30–31; Kennlinie nach Abb. 1.27.]
][*Arbeitspunkt ablesen:* Bei 0,6 V sind aus der Kennlinie ungefähr 2 mA abzulesen. Der Strom ist ein Ablesewert, keine beliebig genaue Messung.
][*Modellparameter bestimmen:* Nach $I_S$ umstellen: $I_S = (2 dot.c 10^(-3) thin "A")/(e^("0,6"/"0,026")-1) approx "1,90" dot.c 10^(-13) thin "A" = 190 thin "fA"$. Der Spannungsquotient im Exponenten ist dimensionslos. Der Wert gehört zum idealisierten Modell mit ausdrücklich auf 26 mV gerundetem $U_T$.
][*Statischen Quotienten berechnen:* $R_D = "0,6" thin "V"/("0,002" thin "A") = 300 thin Omega$. Das ist die Verbindungsgerade vom Ursprung zum Arbeitspunkt.
][*Lokale Änderung berechnen und prüfen:* $r_e approx "0,026" thin "V"/("0,002" thin "A") = 13 thin Omega$. Die lokale Tangente ist viel steiler als die Ursprungsgerade. Die 13 Ω dürfen nur für kleine Änderungen um den gewählten Arbeitspunkt verwendet werden.]


#aufgabe(titel: "Grüne LED: Schwelle, Quellenkennlinie und Arbeitspunkt", art: "rechnen", quelle: "1.4.3.2.4.1",
 ergebnis: [$U_"Schwelle" approx "2,14" thin "V"$, $U_l approx "6,02" thin "V"$, $I_k approx 303 thin "mA"$; AP ungefähr 2,4 V / 180 mA; $P_"opt" approx 86 thin "mW"$; neue Quelle etwa 7,2 V (Ablesewert).], tipp: [Im Leerlauf nur die LED entfernen; beim Kurzschluss wird R3 überbrückt.])[
#if not web [*Aufgabe 78* #linebreak()]
*Gegeben und Annahmen:* Netzwerk nach dem Aufgabenblatt mit $U_q = 10 thin "V"$, $R_1 = 18 thin Omega$, $R_2 = 15 thin Omega$, $R_3 = 50 thin Omega$. Die LED liegt zwischen A und B parallel zu R3. Wellenlänge 580 nm; optischer LED-Wirkungsgrad 20 %. Ideale Quelle und Leitungen, konstante Widerstände. Verwende $h = "6,626" dot.c 10^(-34) thin "Js"$, $c = "3,00" dot.c 10^8 thin "m/s"$, $e = "1,602" dot.c 10^(-19) thin "As"$. Gegeben ist die nachgezeichnete elektrische Kennlinie; Ablesewerte sinnvoll runden.
#image("abbildungen/led-netzwerk.svg", width: 95%)
#image("abbildungen/led-kennlinie-aufgabe.svg", width: 100%)
*Gesucht:*
#enum(numbering: "a)")[Theoretische Schwellenspannung aus $h f = e U$ und $c = lambda f$.][Markierung der Schwellenspannung im Diagramm und ihre Abgrenzung zur tatsächlichen Betriebsspannung.][Leerlaufspannung und Kurzschlussstrom an A–B bei abgeklemmter LED.][Grafischer Arbeitspunkt mit der LED.][Emittierte optische Leistung.][Quellspannung für einen LED-Strom von 0,1 A.]
#src[LED, PDF-S. 1–3, alle Teilfragen a–f; Schaltung neu gezeichnet, nur gedruckte grüne Kennlinie ohne handschriftliche Lösungen nachgezeichnet.]
][*Energiebeziehung nutzen:* $U_"Schwelle" = h c/(e lambda)$. Mit $lambda = 580 dot.c 10^(-9) thin "m"$ folgt $U_"Schwelle" approx "2,14" thin "V"$. Js × m/s geteilt durch As × m ergibt J/As = V.
][*Markierung einordnen:* Zeichne etwa 2,14 V auf der Spannungsachse ein. Die Energiebeziehung ist eine theoretische Spannungsskala aus der Photonenenergie. Für einen konkreten Strom liefert erst die elektrische Kennlinie die passende Durchlassspannung.
][*Leerlauf richtig definieren:* Nur die LED wird entfernt; R3 bleibt im Netzwerk. $R_12 = 18 + 15 = 33 thin Omega$. Durch den unbelasteten Teiler fließen $10/83 thin "A" approx "0,1205" thin "A"$. Daher $U_l = 10 dot.c 50/83 thin "V" approx "6,024" thin "V"$.
][*Kurzschluss auswerten:* A und B werden direkt verbunden. Damit ist R3 überbrückt, aber R1 und R2 bleiben in Reihe zur Quelle. $I_k = 10/33 thin "A" approx "0,3030" thin "A"$. Kontrolle: $R_i = U_l/I_k approx "19,88" thin Omega$, gleich dem Parallelersatz von 33 Ω und 50 Ω bei kurzgeschlossener idealer Quelle.
][*Arbeitsgerade zeichnen:* Verbinde (0 V; 303 mA) mit (6,02 V; 0 mA). Am Schnittpunkt mit der LED-Kennlinie liest du ungefähr $U_D approx "2,4" thin "V"$ und $I_D approx "0,18" thin "A"$ ab. Die Mitschrift verwendet diese gerundeten Werte. Die Quellspannung 10 V ist nicht die LED-Spannung.
][*Optische Leistung bestimmen:* Erst die elektrische Leistung der LED: $P_"LED" approx "2,4" thin "V" dot.c "0,18" thin "A" = "0,432" thin "W"$. Dann $P_"opt" = "0,20" dot.c P_"LED" approx "0,0864" thin "W" = 86 thin "mW"$. Die Verluste in den drei Widerständen gehören nicht in die elektrische Bezugsleistung des gegebenen LED-Wirkungsgrads.
][*Neuen Arbeitspunkt festlegen:* Bei $I_D = "0,1" thin "A"$ liest du etwa $U_D = "2,35" thin "V"$ ab. R3 führt dann zusätzlich $I_3 = "2,35"/50 thin "A" = "0,047" thin "A"$. Durch R1 und R2 fließen zusammen $I_12 = "0,147" thin "A"$. Die benötigte Quellspannung ist $U_q' = U_D + I_12 R_12 approx "2,35" + "0,147" dot.c 33 = "7,20" thin "V"$.
][*Mitschrift und Plausibilität prüfen:* Die 7,1 V aus der Mitschrift sind eine gröbere grafische Ablesung: Mit etwa 2,3 V bei 0,1 A erhält man rund 7,12 V. Sinnvoll ist daher etwa *7,2 V* mit Ablesetoleranz, keine übergenaue Zahl. Bei festem Widerstandsnetz ändert sich die Steigung der Quellenkennlinie nicht; sie verschiebt sich parallel. Die Knotenkontrolle $I_12 = I_D + I_3$ ist erfüllt.]


#aufgabe(titel: "Transistorarbeitspunkt und Verlustleistungsgrenze", art: "rechnen", quelle: "1.4.3.2.5",
 ergebnis: [$beta approx 300$, $I_E approx "60,2" thin "mA"$, $P_T approx "0,48" thin "W"$.], tipp: [Basis- und Kollektorstrom zuerst in dieselbe Einheit umrechnen.])[
#if not web [*Aufgabe 79* #linebreak()]
*Gegeben und Annahmen:* Aus dem Kennlinienfeld werden ungefähr $I_B = 200 thin mu"A"$, $I_C = 60 thin "mA"$ und $U_(C E) = 8 thin "V"$ am betrachteten Arbeitspunkt abgelesen. Zulässige Verlustleistung 0,5 W. Aktiver Betrieb im angegebenen Punkt.
*Gesucht:*
#enum(numbering: "a)")[Gleichstromverstärkung beta und Emitterstrom.][Verlustleistung und Vergleich mit der Grenze.][Warum man bei beliebiger Erhöhung des Basisstroms nicht unbegrenzt mit demselben beta weiterrechnen darf.]
#src[N30, PDF-S. 13–14 = V S. 32–33, abgelesener Arbeitspunkt und Verlustleistungshyperbel.]
][*Steuerverhältnis bilden:* $beta = I_C/I_B = "0,060" thin "A"/(200 dot.c 10^(-6) thin "A") approx 300$. Die Stromverstärkung ist einheitenlos. $I_E = I_C + I_B approx "60,2" thin "mA"$.
][*Verlustleistung prüfen:* $P_T = U_(C E) I_C = 8 thin "V" dot.c "0,060" thin "A" = "0,48" thin "W"$. Das liegt unter 0,5 W, aber nahe an der im Diagramm angegebenen Grenze. Die Ablesegenauigkeit erlaubt keine große zusätzliche Reservebehauptung.
][*Modellgrenze erklären:* Die Lastgerade und die Quellspannung begrenzen den möglichen Kollektorstrom. Bei Sättigung gilt die einfache aktive Beziehung $I_C approx beta I_B$ nicht unverändert; außerdem ist beta selbst betriebspunktabhängig.]


#aufgabe(titel: "Kupferwiderstand als Thermometer", art: "rechnen", quelle: "1.4.4",
 ergebnis: [$R(100 thin "°C") = "13,144" thin Omega$; bei 13,93 Ω: 120 °C.], tipp: [Rechne mit der Abweichung vom 20-°C-Wert, nicht mit der absoluten Kelvin-Temperatur.])[
#if not web [*Aufgabe 80* #linebreak()]
*Gegeben und Annahmen:* Eigene Rechenvariation mit einem Kupferwiderstand $R_20 = 10 thin Omega$ bei 20 °C; $alpha_20 = "3,93" dot.c 10^(-3) thin "1/K"$. Lineares Temperaturmodell, Selbsterwärmung vernachlässigt.
*Gesucht:*
#enum(numbering: "a)")[Widerstand bei 100 °C.][Temperatur bei einem gemessenen Widerstand von 13,93 Ω.][Warum die Differenz nicht durch Addition von 273,15 zu einer Kelvin-Differenz umgerechnet wird.]
#src[Materialkoeffizient und Modell: N30, PDF-S. 15 = V S. 34; Zahlenvariation eigene Ergänzung.]
][*Differenz bilden:* Für 100 °C gegenüber 20 °C gilt $Delta vartheta = 80 thin "K"$. Es wird eine Differenz, keine absolute Temperatur, benötigt.
][*Linear einsetzen:* $R = 10 thin Omega dot.c (1 + "0,00393" thin "1/K" dot.c 80 thin "K") = "13,144" thin Omega$. Die Klammer ist dimensionslos, und der Widerstand steigt wie bei Kupfer erwartet.
][*Messung umkehren:* $Delta vartheta = (R/R_20 - 1)/alpha_20 = ("13,93"/10 - 1)/"0,00393" thin "K" = 100 thin "K"$. Zur Bezugstemperatur addieren: $vartheta = 120 thin "°C"$.
][*Prüfen:* Der Anstieg von 100 K ist zahlenmäßig ein Anstieg von 100 °C. Die Verschiebung 273,15 gehört nur zur Umrechnung absoluter Skalenwerte und fällt beim Subtrahieren heraus. Die Werte bleiben im genannten linearen Modellbereich.]


#aufgabe(titel: "Zeitabhängige Leistung: Fläche statt Endwert", art: "rechnen", quelle: "1.5",
 ergebnis: [Endleistung 4 W, Energie 4 J, mittlere Leistung 2 W.], tipp: [Die Fläche unter einer linear von null steigenden Leistung ist ein Dreieck.])[
#if not web [*Aufgabe 81* #linebreak()]
*Gegeben und Annahmen:* Eigene Anwendung der Vorlesungsformel. Eine konstante Spannung von 10 V treibt in 2 s einen linear von 0 auf 0,4 A steigenden Strom. Damit $i(t) = ("0,2" thin "A/s") t$ für $0 <= t <= 2 thin "s"$.
*Gesucht:*
#enum(numbering: "a)")[Momentanleistung als Funktion der Zeit und Leistung am Ende.][Umgesetzte Energie und mittlere Leistung.][Begründung, weshalb Endleistung mal Gesamtzeit hier falsch ist.]
#src[N30, PDF-S. 17–18 = V S. 36–37; konkrete Zeitfunktion eigene Ergänzung.]
][*Momentanwerte verknüpfen:* $p(t) = u(t) i(t) = (2 thin "W/s") t$. Am Ende nach 2 s beträgt die Leistung 4 W; am Anfang ist sie null.
][*Energiefläche bestimmen:* Die Leistungskurve ist eine Gerade ab null. Ihre Fläche ist ein Dreieck: $W = "0,5" dot.c 2 thin "s" dot.c 4 thin "W" = 4 thin "J"$. Gleichwertig ist die Integration $integral_0^(2 thin "s") p(t) dif t$.
][*Mittelwert und Plausibilität prüfen:* $P_"mittel" = W/t_1 = 4 thin "J"/(2 thin "s") = 2 thin "W"$. Das flächengleiche Rechteck hat dieselbe Zeitbreite und halbe Endhöhe. Endleistung mal Gesamtzeit ergäbe 8 J und täte fälschlich so, als hätten von Anfang an 4 W vorgelegen.]

#kapitel("Kapitel 2 · Kirchhoffsche Gesetze und Grundstromkreis")

#aufgabe(titel: "Knotenbilanz mit negativem Ergebnis", art: "rechnen", quelle: "2.1",
 ergebnis: [$I_4 = -1 thin "A"$, tatsächlich 1 A entgegen dem Pfeil zum Knoten.], tipp: [Alle Ströme mit ihren angenommenen Pfeilen in dieselbe Bilanz eintragen.])[
#if not web [*Aufgabe 82* #linebreak()]
*Gegeben und Annahmen:* Eigene Zahlenvariation zur Knotenregel. I1 = 2 A und I3 = 3 A sind zum Knoten hin definiert, I2 = 6 A vom Knoten weg. Für I4 wird ebenfalls ein Pfeil vom Knoten weg angenommen. Stationärer Knoten ohne Ladungsanhäufung.
*Gesucht:*
#enum(numbering: "a)")[Knotenbilanz und I4.][Bedeutung des Vorzeichens und Kontrolle der tatsächlichen Zu- und Abflüsse.]
#src[Knoten und Pfeilanordnung nach N30, PDF-S. 20 = V S. 39; Zahlen eigene Ergänzung.]
][*Richtungen festlegen:* Zuflüsse positiv, Abflüsse negativ: $I_1 + I_3 - I_2 - I_4 = 0$. Die Definition von I4 muss in der Rechnung beibehalten werden.
][*Unbekannten Strom berechnen:* $I_4 = I_1 + I_3 - I_2 = 2 + 3 - 6 = -1 thin "A"$. Der Strom fließt tatsächlich mit 1 A zum Knoten hin, entgegen dem angenommenen Pfeil.
][*Bilanz prüfen:* Tatsächlich fließen 2 A + 3 A + 1 A hinein und 6 A hinaus. Das passt. Ein negatives Ergebnis ist hier eine Richtungsinformation, kein Rechenfehler.]


#aufgabe(titel: "Maschenumlauf umkehren", art: "verstehen", quelle: "2.2",
 ergebnis: [Alle Vorzeichen kehren sich gemeinsam um; die physikalische Lösung bleibt gleich.], tipp: [Ein Umlaufsinn ist eine Rechenentscheidung.])[
#if not web [*Aufgabe 83* #linebreak()]
Im Skriptumlauf gilt $U_q + U_1 + U_2 - U_3 = 0$. Erkläre, was beim Umkehren des Umlaufsinns passiert. Ändert die Umkehr die reale Stromrichtung oder die Polung der idealen Quelle?
#src[N30, PDF-S. 21 = V S. 40.]
][*Nur die Zählung umkehren:* Die neue Gleichung lautet $-U_q - U_1 - U_2 + U_3 = 0$. Sie entsteht durch Multiplikation der alten Gleichung mit −1.
][*Physik und Rechenrichtung trennen:* Die reale Schaltung, Quellenpolung und Ströme ändern sich durch unsere Wahl nicht. Wir laufen dieselbe geschlossene Masche rechnerisch andersherum ab. Die Lösungen müssen identisch bleiben.]


#aufgabe(titel: "Nichtlineares Dreizweignetz aus der Vorlesung", art: "rechnen", quelle: "2.3",
 ergebnis: [Uq2 = 8 V, Plus oben (Spannungspfeil nach unten); PR1 = 12 W, PR2 = 16 W.], tipp: [Beginne beim vorgegebenen Mittelzweig; die gemeinsame Zweigspannung verbindet alle drei Äste.])[
#if not web [*Aufgabe 84* #linebreak()]
*Gegeben und Annahmen:* Drei parallele Zweige zwischen demselben oberen und unteren Knoten, ideale Leitungen. Links R1 über einer Quelle mit 20 V (Plus oben). Mitte R3 in Reihe mit R4 = 10 Ω; I3 = 1 A soll nach unten fließen. Rechts R2 = 4 Ω über einer Quelle Uq2 unbekannter Polung. R1 und R3 sind nichtlinear mit den mitgegebenen Kennlinien; keine konstanten Widerstandswerte unterstellen.
#image("abbildungen/netzwerk-nichtlinear.svg", width: 98%)
#image("abbildungen/vl30-netzkennlinie.svg", width: 70%)
*Gesucht:*
#enum(numbering: "a)")[Erforderlicher Betrag und Polung von Uq2 für I3 = 1 A.][Leistungen in R1 und R2.][Kontrolle über Knotenbilanz und Zweigspannungen.]
#src[N30, PDF-S. 22 = V S. 41, gesamte Aufgabe 2.3; Schaltung ohne Lösungseinträge neu gezeichnet.]
][*Bekannten Mittelzweig verwenden:* Bei I3 = 1 A liest man an der R3-Kennlinie etwa 6 V ab. An R4 fallen $1 thin "A" dot.c 10 thin Omega = 10 thin "V"$ ab. Der obere Knoten liegt deshalb 16 V über dem unteren.
][*Linken Zweig mit Potenzialen verbinden:* Über der linken Quelle liegt der Zwischenpunkt 20 V über dem unteren Knoten. Zwischen diesem Punkt und dem oberen 16-V-Knoten liegen an R1 daher 4 V. Aus seiner Kennlinie folgt ein Strom von etwa 3 A nach oben in den oberen Knoten.
][*Knotenbilanz aufstellen:* Die 3 A aus dem linken Zweig teilen sich in 1 A im Mittelzweig und damit 2 A im rechten Zweig nach unten. An R2 fallen $2 thin "A" dot.c 4 thin Omega = 8 thin "V"$ ab.
][*Gesuchte Quelle bestimmen:* Von den 16 V zwischen den Knoten bleiben unter R2 noch 8 V bis zum unteren Knoten. Uq2 muss daher 8 V haben, mit Plus oben und Minus unten; der zugehörige positive Spannungspfeil zeigt nach unten.
][*Leistung und Plausibilität prüfen:* R1 nimmt $4 thin "V" dot.c 3 thin "A" = 12 thin "W"$ auf, R2 $8 thin "V" dot.c 2 thin "A" = 16 thin "W"$. Beide Ergebnisse stimmen mit den Endergebnissen in V überein. Knoten: 3 = 1 + 2 A; Mittelzweig: 6 + 10 = 16 V; rechter Zweig: 8 + 8 = 16 V.]


// 2-1
#aufgabe(titel: "Leerlauf und Kurzschluss", art: "verstehen", quelle: "2.4.1")[
#if not web [*Aufgabe 85* #linebreak()]
Beschreibe Leerlauf und Kurzschluss: Wie groß sind jeweils $R_a$, $I$, $U_a$ und die Spannung an $R_i$?
][
Leerlauf: $R_a = oo$, $I = 0$, $U_a = U_q$, an $R_i$ 0 V. Kurzschluss: $R_a = 0$, $I = I_k = U_q\/R_i$, $U_a = 0$, an $R_i$ liegt ganz $U_q$.
]

// 2-2
#aufgabe(titel: "Hinweise auf den Innenwiderstand", art: "verstehen", quelle: "2.4.1")[
#if not web [*Aufgabe 86* #linebreak()]
Woran merkt man, dass eine reale Quelle einen Innenwiderstand haben muss?
][
Der Kurzschlussstrom ist endlich, und die Klemmenspannung sinkt unter Last. Bei einer idealen Quelle wäre $I_k$ unendlich.
]

// 2-3
#aufgabe(titel: "Arbeitspunkt grafisch finden", art: "verstehen", quelle: "2.4.1")[
#if not web [*Aufgabe 87* #linebreak()]
Wie findet man den Arbeitspunkt grafisch? Was passiert mit ihm, wenn $R_a$ kleiner wird?
][
Quellenkennlinie (von $I_k$ bis $U_q$) und Widerstandsgerade (Ursprungsgerade, Steigung $1\/R_a$) einzeichnen; der Schnittpunkt ist der AP. Kleineres $R_a$: Gerade steiler, AP wandert Richtung Kurzschluss (mehr Strom, weniger Spannung).
]

// 2-4
#aufgabe(titel: "Quellenkennlinie und Widerstandsgerade", art: "verstehen", quelle: "2.4.1")[
#if not web [*Aufgabe 88* #linebreak()]
Welche Steigung hat die Quellenkennlinie, wo schneidet sie die Achsen? Was bedeutet eine steilere Widerstandsgerade?
][
Steigung $-1\/R_i$; sie schneidet die $I$-Achse bei $I_k$ und die $U$-Achse bei $U_q$. Eine steilere Widerstandsgerade bedeutet einen kleineren Widerstand.
]

// 2-5
#aufgabe(titel: "Leistungsanpassung", art: "verstehen", quelle: "2.4.3")[
#if not web [*Aufgabe 89* #linebreak()]
Was ist Leistungsanpassung? Welcher Wirkungsgrad ergibt sich, wie groß sind dann $U_a$ und $I$, und wo setzt man sie ein bzw. vermeidet sie?
][
$R_a = R_i$: maximale Leistung am Verbraucher, $eta = 50 thin %$, $U_a = U_q\/2$, $I = I_k\/2$. Erwünscht in der Nachrichtentechnik, vermieden in der Energietechnik ($R_a >> R_i$).
]

// 2-6
#aufgabe(titel: "Wirkungsgrad im Grundstromkreis", art: "verstehen", quelle: "2.4.3")[
#if not web [*Aufgabe 90* #linebreak()]
Wie hängt der Wirkungsgrad im Grundstromkreis von $R_a$ ab? Wann ist er null, wann steigt er?
][
$eta = R_a\/(R_i + R_a)$: steigt, je größer $R_a$ gegenüber $R_i$ wird; im Kurzschluss ($R_a = 0$) ist $eta = 0$. Bei Anpassung ist $P_a$ maximal, nicht $eta$.
]

// 2-7
#aufgabe(titel: "Ideale und reale Spannungsquelle", art: "verstehen", quelle: "2.4.1")[
#if not web [*Aufgabe 91* #linebreak()]
Skizziere das Schaltbild einer idealen und einer realen Spannungsquelle.
][
Ideal: nur die Quelle $U_q$. Real: $U_q$ mit dem Innenwiderstand $R_i$ in Reihe.
]

// 2-8
#aufgabe(titel: "Innenwiderstand einer Autobatterie", art: "rechnen", quelle: "2.4.1",
  ergebnis: [a) $R_i = 30 thin "m"Omega$ b) $U = "8,1" thin "V"$],
  tipp: [Im Kurzschluss bremst nur noch der Innenwiderstand den Strom.],
)[
#if not web [*Aufgabe 92* #linebreak()]
*Gegeben und Annahmen*

Eine Batterie hat $U_l = "12,6" thin "V"$ und $I_k = 420 thin "A"$.

*Gesucht*

#enum(numbering: "a)",
[$R_i$?],
[Klemmenspannung, wenn der Anlasser 150 A zieht?],
)
][
*Zwei Extremfälle nutzen:* Im Leerlauf fließt kein Strom, also fällt an $R_i$ nichts ab: Die Leerlaufspannung ist die Quellspannung, $U_q = "12,6" thin "V"$. Im Kurzschluss ist außen kein Widerstand; nur $R_i$ begrenzt den Strom: $I_k = U_q\/R_i$.
][
*a) Innenwiderstand:* $R_i = U_q\/I_k = "12,6" thin "V"\/420 thin "A" = "0,03" thin Omega = 30 thin "m"Omega$.
][
*b) Unter Last:* Der Anlasser zieht 150 A. Innen fallen $U_i = 150 thin "A" dot.c "0,03" thin Omega = "4,5" thin "V"$ ab. An den Klemmen bleiben $U = "12,6" - "4,5" = "8,1" thin "V"$.
][
*Prüfen:* Deshalb flackert beim Starten das Licht: Die Klemmenspannung bricht kurz stark ein. Bei 0 A wären es 12,6 V, bei 420 A null; 150 A liegen dazwischen.
]

// 2-9
#aufgabe(titel: "Grundstromkreis vollständig berechnen", art: "rechnen", quelle: "2.4.3",
  ergebnis: [$I = 2 thin "A"$, $U_a = 20 thin "V"$, $U_i = 4 thin "V"$, $P_a = 40 thin "W"$, $P_i = 8 thin "W"$, $P_q = 48 thin "W"$, $eta approx "83,3" thin %$],
)[
#if not web [*Aufgabe 93* #linebreak()]
*Gegeben und Annahmen*

Quelle $U_q = 24 thin "V"$, $R_i = 2 thin Omega$, Last $R_a = 10 thin Omega$.

*Gesucht*

#enum(numbering: "a)",
[Berechne $I$, $U_a$, $U_i$, $P_a$, $P_i$, $P_q$ und $eta$.],
)
][
*Ersatzbild:* Innenwiderstand und Last liegen in Reihe an der idealen Quelle. Ein Strom für alles: $I = U_q\/(R_i + R_a) = 24\/12 = 2 thin "A"$.
][
*Spannungen:* $U_a = R_a I = 20 thin "V"$ außen, $U_i = R_i I = 4 thin "V"$ innen. Zusammen 24 V, wie es die Maschenregel verlangt.
][
*Leistungen:* $P_a = U_a I = 40 thin "W"$ (nutzbar), $P_i = U_i I = 8 thin "W"$ (Wärme in der Quelle), $P_q = U_q I = 48 thin "W"$ (insgesamt erzeugt).
][
*Wirkungsgrad:* $eta = P_a\/P_q = 40\/48 approx "0,833" = "83,3" thin %$. Weil überall derselbe Strom fließt, gilt auch $eta = R_a\/(R_i + R_a) = 10\/12$.
][
*Prüfen:* $P_a + P_i = 48 thin "W" = P_q$. Die Energie geht nicht verloren, sie verteilt sich.
]

// 2-10
#aufgabe(titel: "Maximale Leistung derselben Quelle", art: "rechnen", quelle: "2.4.3",
  ergebnis: [$R_a = 2 thin Omega$, $P_"a,max" = 72 thin "W"$ bei $eta = 50 thin %$],
  tipp: [Leistungsanpassung: Bei welchem Lastwiderstand bekommt der Verbraucher am meisten?],
)[
#if not web [*Aufgabe 94* #linebreak()]
*Gegeben und Annahmen*

Ideale Quellenspannung und Innenwiderstand ($U_q = 24 thin "V"$, $R_i = 2 thin Omega$)

*Gesucht*

#enum(numbering: "a)",
[Welches $R_a$ liefert maximale Leistung?],
[Wie groß ist $P_"a,max"$?],
)
][
*Der Zielkonflikt:* Ist $R_a$ sehr klein, fließt viel Strom, aber außen liegt kaum Spannung. Ist $R_a$ sehr groß, liegt außen fast $U_q$, aber es fließt kaum Strom. Dazwischen gibt es ein Maximum, und es liegt bei $R_a = R_i$ (Leistungsanpassung).
][
*Lastwiderstand:* $R_a = R_i = 2 thin Omega$.
][
*Maximale Leistung:* Strom $I = 24\/4 = 6 thin "A"$, Spannung außen $U_a = 12 thin "V"$, also $P_"a,max" = 72 thin "W"$. Kurzformel: $P_"a,max" = U_q^2\/(4 R_i) = 576\/8 = 72 thin "W"$.
][
*Preis dafür:* Innen entsteht genauso viel Wärme wie außen, $eta = 50 thin %$. *Prüfen:* 72 W sind mehr als die 40 W bei $R_a = 10 thin Omega$, obwohl der Wirkungsgrad schlechter ist.
]

// 2-11
#aufgabe(titel: "Quelle aus zwei Messpunkten", art: "rechnen", quelle: "2.4.1",
  ergebnis: [$R_i = 1 thin Omega$, $U_q = 12 thin "V"$],
  tipp: [Schreibe $U = U_q - I R_i$ für beide Messungen auf und ziehe die Gleichungen voneinander ab.],
)[
#if not web [*Aufgabe 95* #linebreak()]
*Gegeben und Annahmen*

Eine Quelle liefert bei 2 A eine Klemmenspannung von 10 V und bei 4 A noch 8 V.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $R_i$ und $U_q$.],
)
][
*Zwei Gleichungen aufstellen:* Für jede reale Quelle gilt $U = U_q - I R_i$. Messung 1: $10 = U_q - 2 R_i$. Messung 2: $8 = U_q - 4 R_i$.
][
*Subtrahieren:* $U_q$ fällt weg: $10 - 8 = -2 R_i + 4 R_i$, also $2 = 2 R_i$ und $R_i = 1 thin Omega$. Anschaulich: 2 A mehr Strom kosten 2 V Klemmenspannung, also 1 V pro A.
][
*Quellspannung:* Einsetzen in Gleichung 1: $U_q = 10 + 2 dot.c 1 = 12 thin "V"$.
][
*Prüfen:* Gleichung 2: $12 - 4 dot.c 1 = 8 thin "V"$. Passt. Die Quellenkennlinie ist eine Gerade; zwei Punkte legen sie fest.
]

// 2-12
#aufgabe(titel: "Grundstromkreis mit 12 V", art: "rechnen", quelle: "2.4.1",
  ergebnis: [$I = 2 thin "A"$, $U_a = 11 thin "V"$, $U_i = 1 thin "V"$, $eta approx "91,7" thin %$],
)[
#if not web [*Aufgabe 96* #linebreak()]
*Gegeben und Annahmen*

Grundstromkreis: $U_q = 12 thin "V"$, $R_i = "0,5" thin Omega$, $R_a = "5,5" thin Omega$.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $I$, $U_a$, $U_i$ und $eta$.],
)
][
*Strom:* $R_i$ und $R_a$ in Reihe: $I = 12 thin "V"\/6 thin Omega = 2 thin "A"$.
][
*Spannungen:* $U_a = "5,5" dot.c 2 = 11 thin "V"$, $U_i = "0,5" dot.c 2 = 1 thin "V"$.
][
*Wirkungsgrad:* Gleicher Strom überall, also verhalten sich die Leistungen wie die Spannungen: $eta = U_a\/U_q = 11\/12 approx "91,7" thin %$.
][
*Prüfen:* $11 + 1 = 12 thin "V"$. Der Lastwiderstand ist viel größer als $R_i$, deshalb ist der Wirkungsgrad hoch.
]

// 2-13
#aufgabe(titel: "Innen- und Lastwiderstand aus einer Messung", art: "rechnen", quelle: "2.4.2",
  ergebnis: [$R_i = 1 thin Omega$, $R_a = 14 thin Omega$],
)[
#if not web [*Aufgabe 97* #linebreak()]
*Gegeben und Annahmen*

Eine Quelle hat 4,5 V Leerlaufspannung. Bei 300 mA misst du an den Klemmen 4,2 V.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $R_i$ und den angeschlossenen $R_a$.],
)
][
*Wo bleiben die fehlenden 0,3 V?* Im Leerlauf misst man $U_q = "4,5" thin "V"$. Unter Last fehlen $"4,5" - "4,2" = "0,3" thin "V"$; die fallen innen an $R_i$ ab.
][
*Innenwiderstand:* $R_i = U_i\/I = "0,3" thin "V"\/"0,3" thin "A" = 1 thin Omega$.
][
*Lastwiderstand:* Außen liegt die Klemmenspannung: $R_a = "4,2" thin "V"\/"0,3" thin "A" = 14 thin Omega$.
][
*Prüfen:* $I = "4,5"\/(1 + 14) = "0,3" thin "A"$. Genau der gemessene Strom.
]

// 2-14
#aufgabe(titel: "Größte Leistung einer 9-V-Batterie", art: "rechnen", quelle: "2.4.3",
  ergebnis: [$R_a = 2 thin Omega$, $P_"a,max" approx "10,1" thin "W"$, $I = "2,25" thin "A"$, $U_a = "4,5" thin "V"$],
)[
#if not web [*Aufgabe 98* #linebreak()]
*Gegeben und Annahmen*

Eine Batterie hat $U_q = 9 thin "V"$ und $R_i = 2 thin Omega$.

*Gesucht*

#enum(numbering: "a)",
[Bei welchem $R_a$ gibt sie die größte Leistung ab?],
[Wie groß sind dann $P_"a,max"$, $I$ und $U_a$?],
)
][
*Anpassung:* Die größte Leistung außen gibt es bei $R_a = R_i = 2 thin Omega$.
][
*Strom und Spannung:* Gesamtwiderstand 4 Ω, also $I = 9\/4 = "2,25" thin "A"$. Die Spannung teilt sich halb und halb: $U_a = "4,5" thin "V"$.
][
*Leistung:* $P_"a,max" = U_a I = "4,5" dot.c "2,25" approx "10,1" thin "W"$, gleich $U_q^2\/(4 R_i) = 81\/8$.
][
*Prüfen:* Bei Anpassung gilt immer $U_a = U_q\/2$ und $I = I_k\/2$; hier ist $I_k = "4,5" thin "A"$.
]

// 2-15
#aufgabe(titel: "Innenwiderstand des Netzes", art: "rechnen", quelle: "2.4.2",
  ergebnis: [$I approx "6,99" thin "A"$, $R_i approx "1,7" thin Omega$],
  tipp: [Die 12 V, die beim Einschalten fehlen, fallen im Netz selbst ab.],
)[
#if not web [*Aufgabe 99* #linebreak()]
*Innenwiderstand des Netzes, Ü 3 (= V S. 43):*

*Gegeben und Annahmen*

Heizwiderstand 31,2 Ω, Leerlaufspannung 230 V, Klemmenspannung beim Einschalten 218 V.

*Gesucht*

#enum(numbering: "a)",
[Zeichne den Ersatzstromkreis.],
[Wie groß ist $R_i$?],
)
][
*a) Ersatzstromkreis:* Das Netz ist eine Quelle $U_q = 230 thin "V"$ mit Innenwiderstand $R_i$ (Leitungen, Transformator). Daran in Reihe der Heizwiderstand $R_a = "31,2" thin Omega$.
][
*Strom aus der Last:* An $R_a$ liegen 218 V: $I = 218 thin "V"\/"31,2" thin Omega approx "6,99" thin "A"$.
][
*Innenwiderstand:* Innen fallen $230 - 218 = 12 thin "V"$ ab. $R_i = 12 thin "V"\/"6,99" thin "A" approx "1,7" thin Omega$.
][
*Prüfen:* $I = 230\/("31,2" + "1,72") approx "6,99" thin "A"$. Auch das Steckdosennetz ist keine ideale Quelle.
]

// 2-16
#aufgabe(titel: "Leistung im Kohleschicht-Widerstand", art: "rechnen", quelle: "2.4.1")[
#if not web [*Aufgabe 100* #linebreak()]
*Kohleschicht-Widerstand, Ü 1b:*

*Gegeben und Annahmen*

Der 80-kΩ-Widerstand liegt mit $R_S = 20 thin "k"Omega$ in Reihe an $U_q = 10 thin "V"$.

*Gesucht*

#enum(numbering: "a)",
[Welche Leistung wird im 80-kΩ-Widerstand in Wärme umgesetzt?],
)
][
*Modell:* Ideale 10-V-Quelle; 20 kΩ und 80 kΩ in Reihe, beide Widerstände konstant.
][
Gesamtwiderstand: $R = 100 thin "k"Omega$; Strom: $I = 10 thin "V"/(100 thin "k"Omega) = "0,1" thin "mA"$.
][
Teilspannungen: $U_K = I R_K = 8 thin "V"$, $U_S = I R_S = 2 thin "V"$.
][
Leistungen: $P_K = 8 thin "V" dot.c "0,1" thin "mA" = "0,8" thin "mW"$; $P_S = "0,2" thin "mW"$.
][
*Ergebnis: 800 µW im Kohleschicht-Widerstand*, wie in Ü-N und DC. *Prüfung:* $10 - 8 - 2 = 0$ V; die Quelle liefert $10 thin "V" dot.c "0,1" thin "mA" = 1 thin "mW"$, gleich der Summe beider Leistungen. Der äußere Serienwiderstand erfüllt rechnerisch dieselbe Rolle wie ein Innenwiderstand.
#src([Ü 1b; Ü-N, PDF-S. 4; DC, PDF-S. 3.])
]

// 2-17
#aufgabe(titel: "Höchstleistung einer Starterbatterie", art: "rechnen", quelle: "2.4.3",
  ergebnis: [$R_a = 40 thin "m"Omega$, $P_"max" approx "1,2" thin "kW"$],
)[
#if not web [*Aufgabe 101* #linebreak()]
*Starterbatterie, Blatt A 2:*

*Gegeben und Annahmen*

Leerlaufspannung 13,8 V, Innenwiderstand 40 mΩ.

*Gesucht*

#enum(numbering: "a)",
[Welche Leistung kann der Akku höchstens an einen Verbraucher abgeben?],
[Wie groß muss der Verbraucherwiderstand dafür sein?],
)
][
*Anpassung:* Höchstleistung gibt es bei $R_a = R_i = 40 thin "m"Omega$.
][
*Leistung:* Dann liegt außen die halbe Spannung, $U_a = "6,9" thin "V"$, und es fließt $I = "13,8"\/"0,08" = "172,5" thin "A"$. $P_"max" = "6,9" dot.c "172,5" approx 1190 thin "W"$.
][
*Kurzformel zur Kontrolle:* $P_"max" = U_0^2\/(4 R_i) = ("13,8")^2\/(4 dot.c "0,04") thin "W" approx 1190 thin "W" approx "1,2" thin "kW"$.
][
*Deuten:* So viel kann der Akku kurz abgeben, etwa für den Anlasser. Dauerhaft wäre das wegen 50 % Verlust und Erwärmung unsinnig.
]

// 2-18
#aufgabe(titel: "Arbeit beim Laden eines Akkus", art: "rechnen", quelle: "2.4.1")[
#if not web [*Aufgabe 102* #linebreak()]
*Akku laden, Blatt B 17:*

*Gegeben und Annahmen*

Vier Ni-Cd-Zellen in Reihe haben zusammen 4,8 V Nennspannung und 0,5 Ω Innenwiderstand. Sie werden 16 h lang mit 0,1 A Konstantstrom geladen.

*Gesucht*

#enum(numbering: "a)",
[Wie viel elektrische Arbeit wird am Akku verrichtet?],
)
][
*Modell:* Beim Laden fließt der Strom *in* den Akku hinein. Die Klemmenspannung muss deshalb die Quellspannung *und* den Spannungsabfall am Innenwiderstand aufbringen.
][
$U_i = R_i dot.c I = "0,5" thin Omega dot.c "0,1" thin "A" = "0,05" thin "V"$
][
$U = U_q + U_i = "4,85" thin "V"$
][
$W = U dot.c I dot.c t = "4,85" thin "V" dot.c "0,1" thin "A" dot.c 16 thin "h" = "7,76" thin "Wh"$
][
*Ergebnis:* $W approx "7,76" thin "Wh"$, wie in R S. 9. *Prüfung:* Ohne Innenwiderstand wären es 7,68 Wh; der kleine Zuschlag ist die Wärme in $R_i$. Achtung: Beim Laden ist das Vorzeichen anders als beim Entladen ($U = U_q - I R_i$).
]

// 2-19
#aufgabe(titel: "Heizgerät an langer Leitung", art: "rechnen", quelle: "2.4.1")[
#if not web [*Aufgabe 103* #linebreak()]
*Heizgerät an langer Leitung:*

*Gegeben und Annahmen*

Nenndaten 2 kW / 230 V, angeschlossen über eine 30 m lange Kupferleitung (Hin- und Rückleiter je 1,5 mm², $rho = "0,0178" thin Omega thin "mm"^2\/"m"$). Am Leitungsanfang liegen 230 V, der Heizwiderstand sei konstant. Für die Modellbeurteilung dieser Aufgabe gilt der im Lernblatt verwendete Richtbereich 1 bis 6 A/mm²; eine reale Leitungsdimensionierung ist damit nicht vollständig beschrieben.

*Gesucht*

#enum(numbering: "a)",
[Widerstand der Leitung?],
[Widerstand des Heizgeräts?],
[Strom, Spannung am Gerät, Verlustleistung in der Leitung?],
[Stromdichte in der Leitung, zulässig?],
)
][
*Idee:* Die Leitung wirkt wie ein Innenwiderstand vor dem Verbraucher (Kapitel 0, 1 und 2 zusammen).
][
$R_L = "0,0178" dot.c 60\/"1,5" approx "0,712" thin Omega$ (Hin- und Rückleiter: 60 m)
][
$R_H = U^2\/P = 230^2\/2000 approx "26,45" thin Omega$
][
$I = 230\/("26,45" + "0,712") approx "8,47" thin "A"$; $U_H = "8,47" dot.c "26,45" approx 224 thin "V"$; $P_V = "8,47"^2 dot.c "0,712" approx 51 thin "W"$
][
$S = "8,47"\/"1,5" approx "5,6" thin "A/mm"^2$, gerade noch im Bereich bis 6 A/mm².
][
*Prüfung:* $224 thin "V" + "8,47" thin "A" dot.c "0,712" thin Omega approx 230 thin "V"$.
]

// 2-20
#aufgabe(titel: "Kennlinien zeichnen", art: "rechnen", quelle: "2.4.1",
  ergebnis: [a) 2 Ω b) 2 Ω, 18 W c) 75 % d) AP bei 1,5 A und 9 V],
  tipp: [Die Quellenkennlinie ist die Gerade zwischen Kurzschlussstrom und Leerlaufspannung.],
)[
#if not web [*Aufgabe 104* #linebreak()]
*Kennlinien zeichnen:*

*Gegeben und Annahmen*

Eine Quelle hat 12 V Leerlaufspannung und 6 A Kurzschlussstrom.

*Gesucht*

#enum(numbering: "a)",
[$R_i$?],
[Welches $R_a$ ergibt Leistungsanpassung, wie groß ist dann $P_a$?],
[Wirkungsgrad bei $R_a = 6 thin Omega$?],
[Zeichne Quellenkennlinie und Widerstandsgerade für $R_a = 6 thin Omega$ und lies den Arbeitspunkt ab.],
)
][
*a) Innenwiderstand:* Im Kurzschluss begrenzt nur $R_i$: $R_i = U_q\/I_k = 12\/6 = 2 thin Omega$.
][
*b) Anpassung:* $R_a = R_i = 2 thin Omega$, $P_a = U_q^2\/(4 R_i) = 144\/8 = 18 thin "W"$.
][
*c) Wirkungsgrad bei 6 Ω:* $eta = R_a\/(R_i + R_a) = 6\/8 = 75 thin %$.
][
*d) Zeichnen:* Quellenkennlinie von (0 V | 6 A) nach (12 V | 0 A). Widerstandsgerade durch den Ursprung mit $I = U\/6 thin Omega$, zum Beispiel durch (6 V | 1 A). Schnittpunkt ist der Arbeitspunkt: Dort erfüllen Quelle und Last gleichzeitig ihre Gleichung.
][
*Prüfen rechnerisch:* $I = 12\/(2 + 6) = "1,5" thin "A"$, $U = 6 dot.c "1,5" = 9 thin "V"$. Der abgelesene Punkt muss (9 V | 1,5 A) sein.
]


#kapitel("Kapitel 2 · Kirchhoffsche Gesetze und Grundstromkreis")

#aufgabe(titel: "Reale Quellen in Reihe und parallel vergleichen", art: "verstehen", quelle: "2.4.1.2",
 ergebnis: [Reihe: $2U_q$, $2R_i$; gegenläufig: 0, $2R_i$; parallel: $U_q$, $R_i/2$.])[
#if not web [*Aufgabe 105* #linebreak()]
*Gegeben und Annahmen:* Zwei gleiche reale Quellen mit Quellspannung $U_q$ und Innenwiderstand $R_i>0$, ohmsche Last $R_a>0$. Nur die Verschaltung wird verändert.

*Gesucht:*
#enum(numbering: "a)")[Ersatzgrößen bei unterstützender und entgegengesetzter Reihenschaltung.][Ersatzgrößen und Laststrom bei gleich gepolter Parallelschaltung.][Ob die Lastströme bei Parallel- und Reihenschaltung grundsätzlich gleich sind.]
#src[V S. 43–44; Vergleichsfrage als eigene Zusammenführung.]
][
*Polungen zählen:* Unterstützend ist $U_"ers"=2U_q$, gegensinnig ist die Differenz gleicher Quellen null. In beiden Reihenfällen ist $R_"ers"=2R_i$. Die Widerstände werden durch eine Gegenpolung nicht negativ.

][
*Parallele Quellen ersetzen:* Bei gleichen Quellen teilt sich der Laststrom symmetrisch. Es gilt $U_"ers"=U_q$, $R_"ers"=R_i/2$ und $I=U_q/(R_a+R_i/2)$.

][
*Lastwirkung prüfen:* Unterstützend in Reihe fließt $I=2U_q/(R_a+2R_i)$. Das ist nicht generell derselbe Wert wie parallel. Bei genau entgegengesetzten gleichen Quellen ist der Laststrom in diesem Modell null.
]

#aufgabe(titel: "Gemischtes Netz: dieselbe Teilspannung auf zwei Wegen", art: "rechnen", quelle: "2.4.5",
 ergebnis: [$R_"ges"=124 thin Omega$, $I approx "0,806" thin "A"$, $U_2 approx "16,13" thin "V"$.])[
#if not web [*Aufgabe 106* #linebreak()]
*Gegeben und Annahmen:* Ideale Quelle $U=100 thin "V"$, lineare Widerstände $R_1=100 thin Omega$, $R_2=50 thin Omega$, $R_3=10 thin Omega$, $R_4=40 thin Omega$. R1 liegt in Reihe mit der Parallelgruppe aus R4 und der Reihe R2–R3.
#image("abbildungen/gesamt-teiler-kaskade.svg", width: 100%, height: 44mm, fit: "contain")

*Gesucht:*
#enum(numbering: "a)")[Gesamtwiderstand und Gesamtstrom.][Spannung U2 über R2 mittels Stromteiler.][Kontrolle mittels zweifachem Spannungsteiler.]
#src[V S. 49–50, Beispiel 1; ohne frühe Zwischenrundung nachgerechnet.]
][
*Von innen ersetzen:* $R_23=50+10=60 thin Omega$, $R_234=40 parallel 60=24 thin Omega$. R1 liegt erst außerhalb dieser Verzweigung: $R_"ges"=100+24=124 thin Omega$.

][
*Gesamtstrom berechnen:* $I=100/124 thin "A" approx "0,80645" thin "A"$. Der Stromteiler verwendet nur $R_234$, nicht 124 Ω: $I_23=I dot.c 24/60 approx "0,32258" thin "A"$.

][
*Teilspannung bestimmen:* $U_2=I_23 R_2 approx "16,129" thin "V"$. Quelle und Widerstände sind konstant, deshalb ist das Ohmsche Gesetz hier zulässig.

][
*Unabhängig prüfen:* $U_234=100 dot.c 24/124 approx "19,3548" thin "V"$. Innerhalb der Reihe R2–R3 gilt $U_2=U_234 dot.c 50/60 approx "16,129" thin "V"$. V rundet früh auf 16,2 V; ohne frühes Runden erhältst du etwa 16,1 V.
]

#aufgabe(titel: "Verschachtelte Stromteiler: Verhältnis ohne Quellspannung", art: "rechnen", quelle: "2.4.5",
 ergebnis: [$I_1/I_4=8$.])[
#if not web [*Aufgabe 107* #linebreak()]
*Gegeben und Annahmen:* Das gezeigte lineare Widerstandsnetz mit $R_2=4 thin Omega$, $R_3=8 thin Omega$, $R_4=8 thin Omega$, $R_5=5 thin Omega$, $R_6=4 thin Omega$, $R_7=12 thin Omega$. Es fließt ein von null verschiedener Eingangsstrom I1; seine Größe ist für das Verhältnis nicht nötig.
#image("abbildungen/gesamt-stromverhaeltnis.svg", width: 100%, height: 44mm, fit: "contain")

*Gesucht:* Das Verhältnis $I_1/I_4$.
#src[V S. 50, Beispiel 2.]
][
*Innerste Verzweigung ersetzen:* $R_67=4 parallel 12=3 thin Omega$. Damit ist $R_567=5+3=8 thin Omega$ und $R_4567=8 parallel 8=4 thin Omega$.

][
*Rechte Stromteilung:* Der Strom I3 teilt sich auf zwei 8-Ω-Wege. Deshalb ist $I_4/I_3=1/2$.

][
*Linke Stromteilung:* Der rechte Gesamtzweig hat $R_3+R_4567=12 thin Omega$; parallel dazu liegen 4 Ω. Daher $I_3/I_1=4/(4+12)=1/4$.

][
*Verhältnisse verbinden:* $I_4/I_1=(1/2)(1/4)=1/8$, also $I_1/I_4=8$. Die unbekannte Quellspannung kürzt sich im linearen Netz heraus.
]

#aufgabe(titel: "Potenziometer: Lastfehler und Grenzstrom", art: "rechnen", quelle: "2.4.6",
 ergebnis: [$U_A=4 thin "V"$ statt 5 V; $I_E=12 thin "mA"$; $I_"zul">=20 thin "mA"$.])[
#if not web [*Aufgabe 108* #linebreak()]
*Gegeben und Annahmen:* Eigene Modellanwendung der Gleichungen von V S. 51–54: $U_E=10 thin "V"$, $R_S=1 thin "k"Omega$, $R_A=1 thin "k"Omega$, $x="0,5"$. Ideale Quelle, ohmsche Widerstände.

*Gesucht:*
#enum(numbering: "a)")[Ausgangsspannung mit und ohne Last.][Laststrom und Eingangsstrom bei dieser Stellung.][Erforderlicher Grenzstrom nach der Skriptregel.]
#src[Eigene Modellanwendung nach V S. 51–54; Zahlen ausdrücklich als ergänztes Beispiel.]
][
*Widerstandsbahn teilen:* Bei halber Stellung sind $R_1=R_2=500 thin Omega$. Unbelastet wäre $U_A=5 thin "V"$. Unter Last ist $R_p=500 parallel 1000= "333,33" thin Omega$.

][
*Belastete Spannung berechnen:* $U_A=10 dot.c "333,33"/(500+"333,33")=4 thin "V"$. Die normierte Formel liefert dasselbe: $"0,5"/(1+1 dot.c "0,25")="0,4"$.

][
*Ströme trennen:* $I_A=4/1000=4 thin "mA"$, $I_Q=4/500=8 thin "mA"$ und $I_E=12 thin "mA"$. Die Last verringert die Spannung um 20 % gegenüber dem unbelasteten 5-V-Wert.

][
*Grenzstellung auslegen:* Nach V muss $I_"zul" >= U_E/R_A+U_E/R_S=10 thin "mA"+10 thin "mA"=20 thin "mA"$ sein. Der Strom bei halber Stellung genügt nicht als alleiniger Auslegungswert.
]

#aufgabe(titel: "Relaisspule stromrichtig oder spannungsrichtig messen", art: "rechnen", quelle: "2.4.7",
 ergebnis: [$R_"VM"=30 thin "k"Omega$, $R_"AM"=5 thin Omega$; stromrichtig ist günstiger.])[
#if not web [*Aufgabe 109* #linebreak()]
*Gegeben und Annahmen:* Relaisspule mit Nennwerten 24 V und 10 mA. Voltmeterbereich 0–30 V, Empfindlichkeit 1000 Ω/V; Amperemeterbereich 0–30 mA, Spannungsabfall am Endwert 150 mV; Geräteklasse 2,5 %. Für den Vergleich wird der Spulenwiderstand aus den Nennwerten abgeschätzt. Die Quelle mit 110 V im Skript erfordert eine passende Strom-/Spannungseinstellung; 110 V werden nicht ungebremst an die 24-V-Spule gelegt.

*Gesucht:*
#enum(numbering: "a)")[Innenwiderstände der Geräte und Größenordnung der Spule.][Unkorrigiertes Messergebnis bei spannungsrichtiger Messung.][Unkorrigiertes Ergebnis bei stromrichtiger Messung und günstigere Anordnung.]
#src[V S. 56–57, Relaisbeispiel; Einordnung der 110-V-Quelle ergänzt.]
][
*Geräte in Widerstände übersetzen:* $R_"VM"=1000 thin "Ω/V" dot.c 30 thin "V"=30 thin "k"Omega$. $R_"AM"="0,15" thin "V"/"0,03" thin "A"=5 thin Omega$. Die Spule hat näherungsweise $R_x=24/"0,01"=2400 thin Omega$.

][
*Spannungsrichtig:* Bei 24 V zieht das Voltmeter zusätzlich $24/30000="0,8" thin "mA"$. Das Amperemeter zeigt 10,8 mA. Ohne Korrektur ergibt sich $24/"0,0108" approx 2222 thin Omega$, rund 7,4 % zu wenig. Mit Abzug des Voltmeterstroms erhältst du wieder 2400 Ω.

][
*Stromrichtig:* Bei 10 mA fallen zusätzlich $"0,01" dot.c 5="0,05" thin "V"$ am Amperemeter ab. $U/I="24,05"/"0,01"=2405 thin Omega$, rund 0,21 % zu viel. Der Abzug von 5 Ω korrigiert diesen Eigenverbrauch.

][
*Bewerten:* Stromrichtig benötigt hier die viel kleinere Korrektur. Die Genauigkeitsklasse bleibt eine zusätzliche Geräteunsicherheit; die Rechnung des Eigenverbrauchs macht die Messung nicht fehlerfrei.
]

#aufgabe(titel: "Pt100 mit Drehspulinstrument dimensionieren", art: "rechnen", quelle: "2.4.8",
 ergebnis: [$R_V approx "20,053" thin "k"Omega$; bei 0 °C etwa 45,1 % Vollausschlag.])[
#if not web [*Aufgabe 110* #linebreak()]
*Gegeben und Annahmen:* $U_B=10 thin "V"$, $R_M=1 thin "k"Omega$, Vollausschlag $I_M=100 thin "µA"$. Sensor $R_vartheta=R_0(1+alpha(vartheta-vartheta_0))$ mit $R_0=100 thin Omega$, $vartheta_0=0 thin "°C"$ und $alpha="3,85" dot.c 10^(-3) thin "1/K"$. Das ausdrücklich lineare Skriptmodell wird verwendet; Sensor und Instrument liegen parallel hinter RV.
#image("abbildungen/gesamt-pt100.svg", width: 100%, height: 35mm, fit: "contain")

*Gesucht:*
#enum(numbering: "a)")[Allgemeine Stromfunktion Im(Temperatur).][Vorwiderstand RV für Vollausschlag bei 400 °C.][Anzeige bei 0 °C als Anteil des Vollausschlags.]
#src[V S. 58–59, Aufgabe 2.4.8.]
][
*Messnetz ersetzen:* $R_p=R_M R_vartheta/(R_M+R_vartheta)$. Über der Parallelgruppe liegen $U_M=U_B R_p/(R_V+R_p)$. Durch das Instrument fließt $I_m=U_M/R_M$.

][
*Funktion vereinfachen:* $I_m=U_B R_vartheta/(R_V R_M+R_V R_vartheta+R_M R_vartheta)$. Die Temperatur wirkt über Rvartheta, die Stromaufteilung ist daher trotz linearer Sensorannahme nicht linear.

][
*Endwert einstellen:* Bei 400 °C ist $R_vartheta=100(1+"0,00385" dot.c 400)=254 thin Omega$. Aus der Stromfunktion folgt $R_V=((U_B/I_M-R_M)R_vartheta)/(R_M+R_vartheta) approx "20052,63" thin Omega$.

][
*Nullpunktanzeige prüfen:* Bei 0 °C ist Rvartheta=100 Ω. Einsetzen liefert $I_m approx "45,13" thin "µA"$, also $I_m/I_M approx "0,4513"$. Auf der linearen Stromskala steht der Zeiger bereits bei etwa 45,1 %.
]

#aufgabe(titel: "Wheatstone-Abgleich und Schleifdraht", art: "rechnen", quelle: "2.4.9",
 ergebnis: [$R_x=143 thin Omega$.])[
#if not web [*Aufgabe 111* #linebreak()]
*Gegeben und Annahmen:* Abgeglichene Wheatstone-Brücke mit Normwiderstand $R_N=100 thin Omega$ und Schleifdrahtverhältnis $l_1/l_2="1,43"$. Der Draht hat gleichförmigen Querschnitt und dasselbe Material entlang seiner Länge.

*Gesucht:*
#enum(numbering: "a)")[Prüflingswiderstand Rx.][Begründung, warum der Querzweig den Abgleich nicht belastet.]
#src[V S. 60–61, Beispiel zur Schleifdrahtbrücke.]
][
*Nullsignal deuten:* Beim Abgleich haben die beiden Mitten gleiches Potenzial. Die Spannung und damit der Strom im Messquerzweig sind null.

][
*Verhältnis verwenden:* Aus den beiden unbelasteten Teilern folgt $R_x/R_N=R_1/R_2=l_1/l_2$. Also $R_x=100 dot.c "1,43"=143 thin Omega$.

][
*Voraussetzungen prüfen:* Die Längenregel braucht einen homogenen Draht. Außerhalb des Abgleichs würde ein reales Messgerät Strom zwischen den Mitten ziehen; dann gilt die unbelastete Auswertung nicht unverändert.
]

#aufgabe(titel: "Brückennetz durch Stern-Dreieck-Umwandlung zerlegen", art: "rechnen", quelle: "2.5.1",
 ergebnis: [$R_"ges"=r_A+((r_B+R_4) parallel (r_C+R_5))$, $I_3=(I_4 R_4-I_5 R_5)/R_3$.])[
#if not web [*Aufgabe 112* #linebreak()]
*Gegeben und Annahmen:* Quellenfreies Widerstandsteilnetz: links Klemme A, rechts D. R1 zwischen A–B, R2 zwischen A–C, R3 zwischen B–C; R4 zwischen B–D und R5 zwischen C–D. Alle Ri sind positive lineare Widerstände; eine ideale Spannung U speist A gegen D. Diese symbolischen Werte sind die vollständigen Vorgaben.

*Gesucht:*
#enum(numbering: "a)")[Gesamtwiderstand zwischen A–D und Eingangsstrom.][Vorgehen zur Rückrechnung des ursprünglichen Stroms durch R3 von B nach C.]
#src[V S. 64, symbolisches Brückenbeispiel; Klemmenzuordnung vollständig ausgeschrieben.]
][
*Linkes Dreieck ersetzen:* Setze $S=R_1+R_2+R_3$. Die Sternarme zu A, B, C sind $r_A=R_1 R_2/S$, $r_B=R_1 R_3/S$, $r_C=R_2 R_3/S$. Jeder Zähler enthält die am betreffenden Knoten anliegenden Dreieckseiten.

][
*Ersatznetz zusammenfassen:* $R_"ges"=r_A+((r_B+R_4) parallel (r_C+R_5))$. Jetzt sind nur noch Reihe und Parallel enthalten. Der Eingangsstrom ist $I=U/R_"ges"$.

][
*Äußere Zweige zurückrechnen:* Die beiden Parallelzweigströme bestimmen die ursprünglichen I4 und I5. Gegen D als Masse sind $phi_B=I_4 R_4$ und $phi_C=I_5 R_5$.

][
*Inneren Originalstrom bestimmen:* Im ursprünglichen Widerstand gilt $I_3=(phi_B-phi_C)/R_3$. Dieser Strom wird nicht einfach aus einem neuen Sternarm übernommen. Ein negatives Ergebnis bedeutet Fluss von C nach B.
]

#aufgabe(titel: "Heißleiterbrücke mit endlichem Voltmeterwiderstand", art: "rechnen", quelle: "2.5.1",
 ergebnis: [$R_"VM"=30 thin "k"Omega$; bei 100 °C etwa 14,9 V; Nullanzeige bei etwa −20 °C.])[
#if not web [*Aufgabe 113* #linebreak()]
*Gegeben und Annahmen:* Ideale Quelle 30 V zwischen linkem und rechtem Knoten (rechts Masse). Oben RHL in Reihe mit R1=3 kΩ; unten R2=100 kΩ in Reihe mit R3=10 kΩ. Das Voltmeter verbindet die Mitten A oben und B unten; Messbereich 30 V, Empfindlichkeit 1000 Ω/V. Eigenerwärmung des NTC vernachlässigbar.
#image("abbildungen/gesamt-ntc-bruecke.svg", width: 100%, height: 40mm, fit: "contain")#image("abbildungen/gesamt-ntc-kennlinie.svg", width: 100%, height: 52mm, fit: "contain")

*Gesucht:*
#enum(numbering: "a)")[Instrumentenwiderstand.][Anzeige bei 100 °C mit Widerstandsablesung aus der Kennlinie.][Temperatur für 0 V Anzeige.]
#src[V S. 64–65, Aufgabe 2.5.1.1; gleichwertige Lösung über den späteren Zweipolersatz.]
][
*Messlast bestimmen:* $R_"VM"=1000 thin "Ω/V" dot.c 30 thin "V"=30 thin "k"Omega$. Bei 100 °C liest man aus der logarithmischen Kurve ungefähr RHL=1 kΩ ab.

][
*Unbelastete Mitten berechnen:* $phi_A=30 dot.c 3/(1+3)="22,5" thin "V"$. $phi_B=30 dot.c 10/(100+10) approx "2,727" thin "V"$. Die Leerlaufdifferenz ist damit etwa 19,773 V.

][
*Belastung einarbeiten:* Von A–B gesehen ist $R_i=(1 parallel 3)+(100 parallel 10) approx "9,841" thin "k"Omega$. Deshalb zeigt das Instrument $U_"VM"="19,773" dot.c 30/(30+"9,841") approx "14,89" thin "V"$. Das ist gleichwertig zur vollständigen Brückenrechnung.

][
*Nullpunkt bestimmen:* Bei UAB=0 zieht das Messgerät keinen Strom. Dann gilt $R_"HL"/R_1=R_2/R_3=10$, also RHL=30 kΩ. Die Kennlinie ordnet diesen Wert ungefähr −20 °C zu. Ablesegenauigkeit und vernachlässigte Eigenerwärmung begrenzen die Aussage.
]


#aufgabe(titel: "Quellen verschieben heißt Bilanzen erhalten", art: "verstehen", quelle: "2.5.2",
 ergebnis: [Maschenbeiträge bzw. Knotenbilanzen bleiben unverändert; $I_"quer"=0$.])[
#if not web [*Aufgabe 114* #linebreak()]
Vergleiche die beiden Umformungen. Erkläre, warum die Spannungsquelle in beide betroffenen Zweige übernommen wird und warum bei der Stromquellenumformung kein Strom im ergänzten Querzweig fließt.
#image("abbildungen/gesamt-quelle-verschieben-u.svg", width: 100%, height: 40mm, fit: "contain")#image("abbildungen/gesamt-quelle-verschieben-i.svg", width: 100%, height: 40mm, fit: "contain")
#src[V S. 66–67; Vergleichsfrage als eigene Zusammenführung.]
][
*Spannungsbilanzen vergleichen:* Jeder ursprünglich von Uq durchsetzte Umlauf muss denselben Spannungsbeitrag behalten. Nur eine Kopie in einem Zweig würde einen anderen Umlauf verändern. Zwischen zwei gleich gepolten Kopien heben sich die Quellenbeiträge auf.

][
*Strombilanz vergleichen:* Am ergänzten Knoten lautet die Bilanz $I_Q-I_Q+I_"quer"=0$. Deshalb ist Iquer=0, die ursprüngliche Knotenbilanz bleibt erhalten.

][
*Grenze nennen:* Die gezeigte Topologie und Polung sind wesentlich. Die Umformung verspricht dasselbe Verhalten des übrigen Netzes an den betrachteten Anschlüssen, keine beliebige Verschiebbarkeit von Quellen.
]
#kapitel("Kapitel 3 · Netzwerke mit Kirchhoff systematisch berechnen")

#aufgabe(titel: "Zwei Quellen und drei Zweige direkt mit Kirchhoff lösen", art: "rechnen", quelle: "3.1",
 ergebnis: [$I_1 approx "1,951" thin "A"$, $I_2 approx -"0,732" thin "A"$, $I_3 approx "1,220" thin "A"$.])[
#if not web [*Aufgabe 115* #linebreak()]
*Gegeben und Annahmen:* Ideale Quellen Uq1=20 V und Uq2=10 V, beide Plus oben. R1=4 Ω und R2=3 Ω liegen in den Quellenzweigen; R3=10 Ω liegt vom gemeinsamen oberen Knoten A nach Masse. I1 und I2 seien zum Knoten A gerichtet, I3 von A nach Masse.
#image("abbildungen/gesamt-drei-zweige.svg", width: 100%, height: 42mm, fit: "contain")

*Gesucht:* Alle drei Ströme samt tatsächlicher Richtung und eine Bilanzprobe.
#src[V S. 72–73, Abschnitt 3.1.]
][
*Unbekannte konsequent ordnen:* Die Knotenbilanz lautet $I_1+I_2-I_3=0$. Die linken und rechten Umläufe liefern $4I_1+10I_3=20$ und $3I_2+10I_3=10$ bei Ω, A und V als zusammenpassenden Einheiten.

][
*Gleichungssystem lösen:* In der Reihenfolge I1,I2,I3 ist die Matrix $mat(1,1,-1;4,0,10;0,3,10)$. Ihre Determinante ist −82 Ω². Cramer liefert $I_1=160/82 approx "1,9512" thin "A"$, $I_2=-60/82 approx -"0,7317" thin "A"$, $I_3=100/82 approx "1,2195" thin "A"$.

][
*Richtung deuten:* I2 fließt tatsächlich vom gemeinsamen Knoten in den 10-V-Quellenzweig. Die Quelle Uq2 nimmt hier Strom am Pluspol auf. I1 und I3 folgen ihren angenommenen Pfeilen.

][
*Physikalisch prüfen:* Der Knoten hat $phi_A=10I_3 approx "12,1951" thin "V"$. Damit ist $(20-phi_A)/4=I_1$ und $(10-phi_A)/3=I_2$. Auch $I_1+I_2=I_3$ stimmt.
]

#aufgabe(titel: "Dasselbe Dreizweignetz mit Überlagerung lösen", art: "rechnen", quelle: "3.2.1",
 ergebnis: [Gleiche Gesamtströme wie bei direkter Kirchhoffrechnung; $P_3 approx "14,87" thin "W"$.])[
#if not web [*Aufgabe 116* #linebreak()]
*Gegeben und Annahmen:* Lineares Dreizweignetz: Uq1=20 V über R1=4 Ω und Uq2=10 V über R2=3 Ω zum gemeinsamen Knoten A; beide Quellen Plus oben. R3=10 Ω führt von A nach Masse. I1 und I2 zeigen von den Quellen nach A, I3 von A nach Masse.
#image("abbildungen/gesamt-drei-zweige.svg", width: 100%, height: 40mm, fit: "contain")

*Gesucht:* Alle Teilströme und Gesamtströme mit unverändertem Bezugspfeil.
#src[V S. 73–75; Bezugsrichtungen von S. 72 durchgehend beibehalten.]
][
*Nur Uq1 aktiv:* Uq2 wird kurzgeschlossen, R2 bleibt erhalten. $R_2 parallel R_3=30/13 thin Omega$. Der Knoten liegt bei $U_A=300/41 approx "7,3171" thin "V"$. Daraus folgen $I_(1,1)=130/41$, $I_(2,1)=-100/41$ und $I_(3,1)=30/41$, jeweils in A.

][
*Nur Uq2 aktiv:* Uq1 wird kurzgeschlossen, R1 bleibt. $R_1 parallel R_3=20/7 thin Omega$. $U_A=200/41 approx "4,8780" thin "V"$. Daher $I_(1,2)=-50/41$, $I_(2,2)=70/41$ und $I_(3,2)=20/41$, jeweils in A.

][
*Vorzeichenrichtig addieren:* $I_1=80/41 approx "1,9512" thin "A"$, $I_2=-30/41 approx -"0,7317" thin "A"$, $I_3=50/41 approx "1,2195" thin "A"$. Die negativen Teilbeiträge laufen entgegen den anfänglichen Pfeilen.

][
*Leistung erst danach:* Im R3 ist $P_3=I_3^2 R_3 approx "14,87" thin "W"$. Die einzelnen Teilleistungen würden den Mischterm auslassen und dürfen nicht einfach addiert werden.
]

#aufgabe(titel: "Fünf Widerstände mit Maschenströmen berechnen", art: "rechnen", quelle: "3.2.2",
 ergebnis: [$I_1="0,477"$, $I_2="0,595"$, $I_3="0,118"$, $I_4="0,461"$, $I_5="0,578" thin "A"$ in den angegebenen realen Richtungen.])[
#if not web [*Aufgabe 117* #linebreak()]
*Gegeben und Annahmen:* Uq1=10 V und Uq2=12 V, Plus jeweils oben; R1=6 Ω, R2=12 Ω, R3=2 Ω, R4=16 Ω, R5=8 Ω. Obere Knoten A links und B rechts; R3 zwischen ihnen. R2/R4 führen nach Masse, R1/R5 jeweils über die Quellen nach Masse.
#image("abbildungen/gesamt-fuenf-widerstaende.svg", width: 100%, height: 45mm, fit: "contain")

*Gesucht:* Maschenströme wie eingezeichnet und reale Zweigströme. Reale Richtungen: I1 linke Quelle nach A, I2 A nach Masse, I3 B nach A, I4 B nach Masse, I5 rechte Quelle nach B.
#src[V S. 77–78, Beispiel 3.2.2.1.]
][
*Gemeinsame Widerstände erfassen:* Mit den eingezeichneten römischen Maschenströmen lauten die geordneten Gleichungen $-18I_"I"+12I_"II"=10$, $-12I_"I"+30I_"II"-16I_"III"=0$, $-16I_"II"+24I_"III"=12$. Die Koeffizienten haben die Einheit Ω.

][
*System lösen:* Es folgt $I_"I" approx -"0,477124" thin "A"$, $I_"II" approx "0,117647" thin "A"$ und $I_"III" approx "0,578431" thin "A"$. Der erste tatsächliche Kreisbeitrag läuft gegen die angenommene Richtung.

][
*In Zweigströme übersetzen:* $I_1=-I_"I" approx "0,4771" thin "A"$, $I_2=-I_"I"+I_"II" approx "0,5948" thin "A"$, $I_3=I_"II" approx "0,1176" thin "A"$, $I_4=I_"III"-I_"II" approx "0,4608" thin "A"$ und $I_5=I_"III" approx "0,5784" thin "A"$.

][
*Knoten und Spannungen prüfen:* $phi_A=12I_2 approx "7,1373" thin "V"$, $phi_B=16I_4 approx "7,3725" thin "V"$. Daher $(phi_B-phi_A)/2=I_3$. An A gilt I1+I3=I2, an B I5=I3+I4.
]

#aufgabe(titel: "Pufferbatterie: Stromverteilung und stromlose Batterie", art: "rechnen", quelle: "3.2.2",
 ergebnis: [$I approx "6,98" thin "A"$, $I_a approx "7,91" thin "A"$; Batterie liefert etwa 0,93 A; $R_v="1,5" thin Omega$ für IB=0.])[
#if not web [*Aufgabe 118* #linebreak()]
*Gegeben und Annahmen:* Generator Uq=100 V, RiG=1 Ω, vorgeschalteter Rv=2 Ω. Pufferbatterie UB=80 V mit RiB=1 Ω. Last Ra=10 Ω liegt parallel zum Batteriezweig; alle positiven Quellenpole oben. Generatorstrom I zum Lastknoten, Laststrom Ia nach unten, Batteriestrom IB nach unten definiert.
#image("abbildungen/gesamt-pufferbatterie.svg", width: 100%, height: 40mm, fit: "contain")

*Gesucht:*
#enum(numbering: "a)")[Stromverteilung und Lastspannung.][Ob die Batterie lädt oder entlädt.][Rv für IB=0 bei unveränderten Quellen.]
#src[V S. 79–80, Beispiel 3.2.2.2.]
][
*Zwei Maschen wählen:* Generator- und Lastmasche führen die Ströme I und Ia. Die Gleichungen sind $4I-I_a=20$ und $-I+11I_a=80$. Der Batteriestrom ist die Differenz $I_B=I-I_a$.

][
*System lösen:* $I=300/43 approx "6,9767" thin "A"$ und $I_a=340/43 approx "7,9070" thin "A"$. Die Lastspannung ist $U_a=10I_a approx "79,0698" thin "V"$.

][
*Batterierichtung deuten:* $I_B=-40/43 approx -"0,9302" thin "A"$. Der Strom fließt also nach oben aus der Batterie zum Verbraucher: Die Batterie entlädt. Ihre innere Polung wird dadurch nicht vertauscht.

][
*Batterie stromlos einstellen:* Für IB=0 ist Ua=UB=80 V und Ia=8 A. Am Generatorzweig müssen 20 V bei 8 A abfallen: $R_"iG"+R_v=20/8="2,5" thin Omega$. Also $R_v="1,5" thin Omega$. Probe: $(100-80)/(1+"1,5")=8 thin "A"$.
]

#aufgabe(titel: "Ideale Stromquellen in einem Viermaschennetz", art: "rechnen", quelle: "3.2.2.1",
 ergebnis: [$phi_E approx -"1,091"$, $phi_A approx -"4,636"$, $phi_B approx -"6,636"$, $phi_C="8,625"$, $phi_D="6,875" thin "V"$.])[
#if not web [*Aufgabe 119* #linebreak()]
*Gegeben und Annahmen:* Alle unteren Leiter sind Masse. Quellknoten F=+6 V, G=−5 V, H=+3 V, J=+3 V. Widerstände: R2=3 kΩ zwischen E–F, R4=1,5 kΩ E–A, R3=1 kΩ A–G, R1=1 kΩ A–B, R5=5 kΩ C–H, R6=2 kΩ C–D, R7=1 kΩ D–J. Stromquelle I1=2 mA von B nach C, I2=3 mA von Masse nach D. Quellen und Widerstände ideal.
#image("abbildungen/gesamt-ideale-quellen-netz.svg", width: 100%, height: 40mm, fit: "contain")

*Gesucht:* Alle Potenziale E,A,B,C,D und Widerstandsströme sowie Spannung UBC über I1.
#src[V S. 80–84, Beispiel 3.2.2.3; Quellenspannungen korrekt mitgeführt.]
][
*Eingeprägte Maschenströme nutzen:* In der passenden Randmasche ist $I_"II"=2 thin "mA"$ und $I_"IV"=-3 thin "mA"$. Für den linken Widerstandsumlauf folgt $I_"I"=(6+5+2 thin "mA" dot.c 1 thin "k"Omega)/("5,5" thin "k"Omega) approx "2,363636" thin "mA"$. Im Nenner sind 5,5 kΩ gemeint.

][
*Linke Potenziale berechnen:* Durch R2 fließen 2,363636 mA von F nach E, durch R4 von E nach A. Damit $phi_E=6-"2,363636" dot.c 3 approx -"1,09091" thin "V"$ und $phi_A=phi_E-"2,363636" dot.c "1,5" approx -"4,63636" thin "V"$. Durch R3 fließen $"0,363636" thin "mA"$ nach G. R1 führt 2 mA von A nach B, also $phi_B=phi_A-2 approx -"6,63636" thin "V"$.

][
*Rechte Widerstandsmasche lösen:* $I_"III"=(3-3+2 thin "mA" dot.c 5 thin "k"Omega-3 thin "mA" dot.c 1 thin "k"Omega)/(8 thin "k"Omega)="0,875" thin "mA"$. Damit I_R6=0,875 mA C→D; I_R5=2−0,875=1,125 mA C→H. Es folgt $phi_C=3+"1,125" dot.c 5="8,625" thin "V"$, $phi_D=phi_C-"0,875" dot.c 2="6,875" thin "V"$.

][
*Reststrom und Quellen-Spannung prüfen:* I_R7=0,875+3=3,875 mA nach J. $U_(B C)=phi_B-phi_C approx -"15,26136" thin "V"$. Die ideale Stromquelle hebt das Potenzial in Stromrichtung an; ihre Spannung ist nicht null.

][
*Skriptfehler vermeiden:* Die auf S. 80 formal aufgeführten Maschen 2 und 4 benötigen zusätzlich die unbekannten Spannungen der Stromquellen. Hier wurden nur die gültigen Widerstandsumläufe und die eingeprägten Randströme benutzt. Die Knotenbilanzen bestätigen alle sieben Widerstandsströme.
]

#aufgabe(titel: "Fünf Widerstände mit Knotenpotenzialen kontrollieren", art: "rechnen", quelle: "3.2.3",
 ergebnis: [$phi_A approx "7,137" thin "V"$, $phi_B approx "7,373" thin "V"$, $I_3 approx "0,118" thin "A"$ von B nach A.])[
#if not web [*Aufgabe 120* #linebreak()]
*Gegeben und Annahmen:* Quellen Uq1=10 V und Uq2=12 V gegen Masse. R1=6 Ω zwischen 10-V-Quellknoten und A, R2=12 Ω A–Masse, R3=2 Ω A–B, R4=16 Ω B–Masse, R5=8 Ω zwischen B und 12-V-Quellknoten. Positive U3 sei von B nach A gerichtet.

*Gesucht:* Potenziale A/B, U3 und Strom von B nach A; Lösung mit Leitwertmatrix.
#src[V S. 84–85, Abschnitt 3.2.3.1.]
][
*Leitwerte eintragen:* $G_1=1/6$, $G_2=1/12$, $G_3=1/2$, $G_4=1/16$, $G_5=1/8$, jeweils in S. Die Quellenströme der Ersatzformen sind $10/6 thin "A"$ links und $12/8 thin "A"$ rechts.

][
*Knotenbilanzen ordnen:* $(G_1+G_2+G_3)phi_A-G_3 phi_B=10G_1$ und $-G_3 phi_A+(G_3+G_4+G_5)phi_B=12G_5$. Rechts steht G5, nicht der Druckfehler G3 aus einer Zwischenzeile von V S. 85.

][
*System lösen:* $phi_A approx "7,137255" thin "V"$ und $phi_B approx "7,372549" thin "V"$. Diese zwei Unbekannten ersetzen die fünf ursprünglichen Zweigströme.

][
*Gesuchte Richtung prüfen:* $U_3=phi_B-phi_A approx "0,235294" thin "V"$. Daher $I_3=U_3/2 approx "0,117647" thin "A"$ von B nach A. Die Rückrechnung stimmt mit dem Maschenstromverfahren überein.
]

#aufgabe(titel: "Eine ideale Spannungsquelle und eine ideale Stromquelle", art: "rechnen", quelle: "3.2.4",
 ergebnis: [$phi_X=1 thin "V"$, $phi_Y=1001 thin "V"$; Strom in der Spannungsquelle 0,899 A nach unten.])[
#if not web [*Aufgabe 121* #linebreak()]
*Gegeben und Annahmen:* Masse unten; ideale 1-V-Quelle Plus oben legt Knoten X fest. Parallel dazu 10 Ω sowie ein Zweig mit 1 mS Leitwert. Ein weiterer paralleler Zweig enthält eine ideale Stromquelle 1 A nach oben zum Knoten Y und darüber 1 kΩ von Y nach X.
#image("abbildungen/gesamt-quellen-ideal-gemischt.svg", width: 100%, height: 41mm, fit: "contain")

*Gesucht:* Alle Ströme/Spannungen samt Richtung sowie Potenziale X und Y.
#src[V S. 86, Aufgabe 3.2.4.1; vollständige Leistungsprobe ergänzt.]
][
*Feste Größen zuerst:* Die Spannungsquelle setzt $phi_X=1 thin "V"$. Die Stromquelle erzwingt 1 A von Masse nach Y und weiter durch 1 kΩ nach X.

][
*Hohes Potenzial berechnen:* Am 1-kΩ-Widerstand fallen in Stromrichtung Y→X 1000 V ab. Deshalb $phi_Y=phi_X+1000=1001 thin "V"$. Die Stromquelle hat somit 1001 V zwischen Y und Masse.

][
*Parallele Zweige auswerten:* Durch 10 Ω fließen 0,1 A nach unten. 1 mS entspricht 1 kΩ, dort fließt 0,001 A nach unten. Beide Spannungen betragen 1 V nach unten.

][
*Quellenstrom bilanzieren:* Von oben nach unten durch die 1-V-Quelle gilt $I_U=1-"0,1"-"0,001"="0,899" thin "A"$. Sie nimmt in diesem Fall Leistung auf. Probe: Die Stromquelle liefert 1001 W; Widerstände setzen zusammen 1000,101 W um, die Spannungsquelle nimmt 0,899 W auf. Die Summe ist 1001 W.
]

#aufgabe(titel: "Zwei ideale Stromquellen: negative Knotenpotenziale", art: "rechnen", quelle: "3.2.4",
 ergebnis: [$phi_A=1 thin "V"$, $phi_B=-3 thin "V"$, $phi_C=-18 thin "V"$.])[
#if not web [*Aufgabe 122* #linebreak()]
*Gegeben und Annahmen:* R1=2 kΩ A–B, R2=3 kΩ B–C, R3=1 kΩ B–Masse. I1=2 mA speist von Masse nach A; I2=5 mA führt von C nach Masse.
#image("abbildungen/gesamt-zwei-stromquellen.svg", width: 100%, height: 40mm, fit: "contain")

*Gesucht:* Potenziale A, B und C gegen Masse.
#src[V S. 86, Aufgabe 3.2.4.2.]
][
*Quellenströme in Nachbarzweigen:* A hat nur Quelle und R1, deshalb fließen 2 mA von A nach B. Bei C müssen 5 mA von B nach C fließen.

][
*Knoten B bilanzieren:* Mit R3-Strom nach unten gilt $I_3=2-5=-3 thin "mA"$. R3 führt tatsächlich 3 mA von Masse nach B. Daher $phi_B=I_3 R_3=-3 thin "V"$.

][
*Nachbarknoten berechnen:* $phi_A=phi_B+2 thin "mA" dot.c 2 thin "k"Omega=1 thin "V"$. $phi_C=phi_B-5 thin "mA" dot.c 3 thin "k"Omega=-18 thin "V"$.

][
*Prüfen:* Negative Potenziale sind relativ zu Masse zulässig. Die Quellenspannungen passen sich den vorgegebenen Strömen an; die idealen Quellen sind nicht durch einen realen Spannungsbereich begrenzt.
]

#kapitel("Kapitel 4 · Zweipoltheorie und nichtlineare Arbeitspunkte")

#aufgabe(titel: "Zweipolersatz mit zwei gegensinnig gepolten Quellen", art: "rechnen", quelle: "4.2",
 ergebnis: [$U_l approx "7,143" thin "V"$, $R_i approx "12,571" thin Omega$, $I_a approx "0,3165" thin "A"$.])[
#if not web [*Aufgabe 123* #linebreak()]
*Gegeben und Annahmen:* Masse B. Linker Zweig: Quelle +20 V gegen B und darüber R1=15 Ω zum gemeinsamen inneren Knoten N. Mittlerer Zweig: Quelle mit oberem Pol −10 V gegen B und darüber R2=20 Ω nach N. R3=4 Ω von N nach A. Last Ra=10 Ω A–B.
#image("abbildungen/gesamt-zweipol-zwei-quellen.svg", width: 100%, height: 45mm, fit: "contain")

*Gesucht:*
#enum(numbering: "a)")[Ri und Ul bezüglich A–B.][Ik als Probe.][Laststrom, Lastspannung und Lastleistung.]
#src[V S. 90–92; Last Ra=10 Ω bereits in Abb. 4.6 vorgegeben.]
][
*Last abtrennen und Ri bilden:* Für Ri werden beide unabhängigen Spannungsquellen kurzgeschlossen. Von A nach B sieht man $R_i=4+(15 parallel 20)=88/7 thin Omega approx "12,5714" thin Omega$.

][
*Leerlauf bei aktiven Quellen:* Durch R3 fließt kein Strom. Am inneren Knoten gilt $(U_l-20)/15+(U_l+10)/20=0$. Daraus $U_l=50/7 thin "V" approx "7,142857" thin "V"$. Die entgegengesetzte zweite Quelle darf nicht als +10 V eingesetzt werden.

][
*Kurzschlussprobe:* $I_k=U_l/R_i=25/44 thin "A" approx "0,56818" thin "A"$. Die Skriptangabe 0,566 A entsteht aus zuvor gerundeten Werten; alle drei exakten Ersatzgrößen erfüllen Ul=Ik Ri.

][
*Last wieder anschließen:* $I_a=U_l/(R_i+10)=25/79 thin "A" approx "0,31646" thin "A"$. $U_a=10I_a approx "3,16456" thin "V"$; $P_a=I_a^2 dot.c 10 approx "1,0014" thin "W"$. Probe: $U_l=I_a R_i+U_a$.
]

#aufgabe(titel: "Nichtlineare Kennlinien richtig zusammenfügen", art: "verstehen", quelle: "4.3.1",
 ergebnis: [Parallel Ströme bei gleichem U, in Reihe Spannungen bei gleichem I addieren.])[
#if not web [*Aufgabe 124* #linebreak()]
Zwei nichtlineare Widerstände besitzen bekannte I-U-Kennlinien. Beschreibe jeweils eine konstruktive Vorschrift für ihre Gesamtkennlinie in Reihen- und Parallelschaltung. Erkläre außerdem, warum die statischen Quotienten U/I einzelner Arbeitspunkte keine allgemein konstanten Ersatzwiderstände sind.
#src[V S. 95–96, Abschnitt 4.3.1.]
][
*Parallel gemeinsame Spannung wählen:* Suche auf beiden Kennlinien denselben U-Wert, lies I1 und I2 ab und bilde I=I1+I2. Wiederhole dies für mehrere Spannungen. Die Summe wird im I-U-Bild senkrecht gebildet.

][
*In Reihe gemeinsamen Strom wählen:* Suche auf beiden Kennlinien denselben I-Wert, lies U1 und U2 ab und bilde U=U1+U2. Die Summe wird waagerecht gebildet.

][
*Arbeitspunktabhängigkeit nennen:* Bei gekrümmten Kennlinien ändert sich U/I mit dem Punkt. Ein einzelner Quotient ist keine Beschreibung der gesamten Kurve. Erst die Gesamtkennlinie kann mit der Quellenlinie geschnitten werden.
]

#aufgabe(titel: "Varistor am Festspannungsteiler: drei Arbeitspunkte", art: "rechnen", quelle: "4.3.1",
 ergebnis: [Bei 100 V etwa 30 V/77 mA; bei 200 V etwa 40 V/311 mA; mit Rp etwa 23 V.])[
#if not web [*Aufgabe 125* #linebreak()]
*Gegeben und Annahmen:* R1=75 Ω und R2=50 Ω bilden einen Teiler an UE. R3=100 Ω liegt vom Teilerabgriff zur Klemme A, B ist Masse. VDR A–B mit $I(U)=1 thin "A" dot.c (U/(50 thin "V"))^5$ für U≥0.
#image("abbildungen/gesamt-varistor-netz.svg", width: 100%, height: 38mm, fit: "contain")#image("abbildungen/gesamt-varistor-kennlinie.svg", width: 100%, height: 57mm, fit: "contain")

*Gesucht:*
#enum(numbering: "a)")[Arbeitspunkt und VDR-Leistung bei UE=100 V.][Arbeitspunkt bei UE=200 V.][Spannung bei UE=100 V und zusätzlichem Rp=200 Ω parallel zum VDR.]
#src[V S. 97–98, Aufgabe 4.3.1.1; grafische Werte von numerischer Nachrechnung getrennt.]
][
*Aktiven Teil ersetzen:* Ohne VDR ist $U_l=U_E dot.c 50/(75+50)="0,4"U_E$. Bei kurzgeschlossener Quelle ist $R_i=100+(75 parallel 50)=130 thin Omega$. R3 bleibt auch im Leerlauffall als Teil des aktiven Netzes erhalten, führt dann aber keinen Strom.

][
*Ersten Schnitt finden:* Für UE=100 V lautet die Quellenlinie $I=(40-U)/130$ mit V, Ω und A. Schneide sie mit der roten Kennlinie. Grafisch etwa U=30 V, I≈75–78 mA. Mit der Gleichung nachgerechnet: U≈29,96 V, I≈77,24 mA, also P≈2,31 W. Die gedruckten 2,25 W beruhen auf den grob abgelesenen 30 V und 75 mA.

][
*Überspannungsfall:* Nun ist Ul=80 V, Ri bleibt 130 Ω. Der Schnitt liegt bei U≈39,58 V und I≈310,91 mA; grafisch rund 40 V/310 mA. Die VDR-Leistung beträgt ungefähr 12,3 W. Eine reale Eignung verlangt zusätzlich eine zulässige Leistungs-/Energieangabe.

][
*Zusätzliche Last berücksichtigen:* Für Rp=200 Ω teilt sich der Quellenstrom: $(40-U)/130=(U/50)^5+U/200$. Der Schnitt ergibt U≈22,72 V, also grafisch rund 23 V. Nur den VDR abzuklemmen würde Rp in der Ersatzrechnung angeschlossen lassen; alternativ addierst du seine Kennlinie wie hier.

][
*Plausibilität prüfen:* Verdoppeltes UE verdoppelt UAB nicht, weil der VDR erheblich leitfähiger wird. Der zusätzliche Parallelverbraucher senkt UAB weiter. Kein Zweigstrom darf mit dem gesamten Quellenstrom verwechselt werden.
]

#aufgabe(titel: "Basis-Emitter-Diode am Spannungsteiler", art: "rechnen", quelle: "4.3.2",
 ergebnis: [$U_l approx "2,31" thin "V"$, $R_i approx "1,154" thin "k"Omega$, $I_k=2 thin "mA"$; $U_q' approx "7,8" thin "V"$.])[
#if not web [*Aufgabe 126* #linebreak()]
*Gegeben und Annahmen:* Quelle Uq=10 V, R1=5 kΩ oben und R2=1,5 kΩ unten als Teiler; Basis-Emitter-Diode an dessen Ausgang. Die gedruckte Kennlinie liefert ungefähr UBE=0,9 V bei IB≈1,2 mA sowie UBE≈0,88 V bei IB=0,8 mA; dies sind Ablesedaten.

*Gesucht:*
#enum(numbering: "a)")[Ul, Ri und Ik des speisenden Teilers.][Kontrolle des ersten grafischen Arbeitspunkts.][Neue Quellspannung für IB=0,8 mA.]
#src[V S. 99–100, Beispiel 4.3.2.1; Kennlinienwerte ausdrücklich grafisch.]
][
*Quelle ersetzen:* $U_l=10 dot.c "1,5"/"6,5" approx "2,30769" thin "V"$. $R_i=5 parallel "1,5" approx "1,15385" thin "k"Omega$. Im Kurzschluss wird R2 überbrückt: Ik=10/5000=2 mA.

][
*Grafischen Punkt kontrollieren:* Mit UBE=0,9 V liefert die Quellenlinie $("2,30769"-"0,9")/"1153,85" approx "0,00122" thin "A" = "1,22" thin "mA"$. Dies stimmt innerhalb der grafischen Genauigkeit mit 1,2 mA überein.

][
*Neue Leerlaufspannung bestimmen:* Für IB=0,8 mA und den abgelesenen UBE≈0,88 V gilt $U_l' approx "0,88"+"0,8" thin "mA" dot.c "1,15385" thin "k"Omega approx "1,80308" thin "V"$. Die Quellenlinie wird parallel verschoben, da Ri gleich bleibt.

][
*Auf die Versorgung zurückrechnen:* $U_q'=U_l' dot.c "6,5"/"1,5" approx "7,81" thin "V"$. Das entspricht der grob grafischen Skriptlösung 7,8 V. UBE ist dabei kein für jeden Strom konstant vorgegebener Spannungsabfall.
]

#aufgabe(titel: "Konstantstrom-Transistor: zulässiger Lastbereich", art: "rechnen", quelle: "4.3.2",
 ergebnis: [Skript-Grenznäherung 90–190 Ω; ein positives UCE,min verkleinert den oberen Wert.])[
#if not web [*Aufgabe 127* #linebreak()]
*Gegeben und Annahmen:* Uq=20 V, Quelleninnenwiderstand Riq=10 Ω, vorgegebener Basisstrom IB=1 mA und Verstärkungsmodell IC≈100 mA. Maximale Transistorleistung 1 W; variable Last Ra in Reihe. Für die gedruckte obere Grenznäherung wird UCE,min=0 V gesetzt; anschließend soll diese Idealisierung erläutert werden.

*Gesucht:*
#enum(numbering: "a)")[Leistungshyperbel und kleinster Lastwiderstand.][Oberer Lastgrenzwert des idealisierten Skriptmodells.][Allgemeine Korrektur bei benötigter positiver Mindestspannung.]
#src[V S. 101–102, Beispiel 4.3.2.2; obere Modellgrenze präzisiert.]
][
*Leistung in Spannung übersetzen:* Bei IC=0,1 A ist höchstens $U_(C E)=1/"0,1"=10 thin "V"$ erlaubt. Allgemein gilt $I_"zul"=1 thin "W"/U_(C E)$.

][
*Kleinsten Lastwiderstand berechnen:* $20=10+"0,1"(R_a+10)$ ergibt Ra,min=90 Ω. Kleinere Lastwiderstände lassen im Konstantstrommodell mehr Spannung am Transistor und überschreiten 1 W.

][
*Idealisierten oberen Grenzwert bestimmen:* Mit UCE=0 ist $R_"a,max"=20/"0,1"-10=190 thin Omega$. Im Grenzfall bleibt dem Transistor keine Kollektor-Emitter-Spannung; zuverlässiger realer Konstantstrombetrieb ist dort nicht zugesichert.

][
*Modellgrenze ausdrücken:* Bei positiv vorgegebenem UCE,min lautet $R_"a,max"=(20 thin "V"-U_(C E,"min"))/("0,1" thin "A")-10 thin Omega$. Für eine reale Auslegung braucht man diese Mindestspannung bzw. eine ausreichend genaue Ausgangskennlinie.
]

#aufgabe(titel: "Symbolische Ersatzquelle und ursprüngliche Quellenleistung", art: "rechnen", quelle: "4.4.1",
 ergebnis: [$U_l=-I_q(R_4 parallel R_5)$; $R_i=R_4 parallel R_5$; $P_q approx "14,89" thin "W"$.])[
#if not web [*Aufgabe 128* #linebreak()]
*Gegeben und Annahmen:* Links der idealen Stromquelle liegt R3 nach Masse parallel zur Reihe R2–R1. Rechts liegt der Ausgang A mit R4 und R5 jeweils nach Masse B. Die Stromquelle Iq zeigt von A nach links.
#image("abbildungen/gesamt-stromquelle-symbolisch.svg", width: 100%, height: 32mm, fit: "contain")

*Gesucht:*
#enum(numbering: "a)")[U1 über R1 nach unten.][Ul, Ri und Ik an A–B mit beiden Widerständen R4/R5 im aktiven Teil.][Abgegebene Quellenleistung bei Iq=2 A und Ri=i Ω für i=1,…,5.]
#src[V S. 103, Aufgabe 4.4.1; Gesamtleistung ohne frühe Rundung geprüft.]
][
*Linken Stromteiler auswerten:* Der Strom durch R1 und R2 beträgt $I_q R_3/(R_1+R_2+R_3)$. Deshalb $U_1=I_q R_1 R_3/(R_1+R_2+R_3)$.

][
*Rechte Klemmen bestimmen:* Die Quelle zieht Iq aus A ab. Deshalb $U_l=-I_q(R_4 parallel R_5)$. Für Ri wird die ideale Stromquelle geöffnet; links ist dann kein Beitrag mehr sichtbar. $R_i=R_4 parallel R_5$ und $I_k=U_l/R_i=-I_q$.

][
*Innere Quellenspannung im Originalnetz:* Mit den Zahlen ist der linke Ersatz $(R_1+R_2) parallel R_3=3 parallel 3="1,5" thin Omega$, rechts $R_4 parallel R_5=20/9 thin Omega$. Links der Stromquelle herrschen 3 V, rechts −40/9 V.

][
*Leistung und Bilanz prüfen:* Der Quellenstrom läuft vom niedrigeren zum höheren Potenzial. Die abgegebene Leistung ist $P_q=I_q^2("1,5"+20/9) approx "14,889" thin "W"$. V nennt 14,8 W nach Rundung; die ungerundete Widerstandssumme ergibt 14,89 W. Die im Ersatzbild sichtbare Lastleistung allein wäre nicht die gesamte ursprüngliche Quellenleistung.
]

#aufgabe(titel: "Glimmlampe in der Brücke: Arbeitspunkt und Erlöschen", art: "rechnen", quelle: "4.4.2",
 ergebnis: [$U_l=150 thin "V"$, $R_i="11,6" thin "k"Omega$; AP etwa 70 V/7 mA, R5 etwa 0,5 W; Absenkung rund 50 V.])[
#if not web [*Aufgabe 129* #linebreak()]
*Gegeben und Annahmen:* Quelle Uq=250 V zwischen links (+) und rechts (−). Oberer Teiler R1=1 kΩ links, R2=4 kΩ rechts; unterer Teiler R3=4 kΩ links, R4=1 kΩ rechts. Zwischen oberer und unterer Mitte liegen R5=10 kΩ und die Glimmlampe in Reihe. Die Kennlinie zeigt auch die Haltegrenze bei ungefähr 1 mA und 110 V.
#image("abbildungen/gesamt-glimmlampe-netz.svg", width: 100%, height: 43mm, fit: "contain")#image("abbildungen/gesamt-glimmlampe-kennlinie.svg", width: 100%, height: 65mm, fit: "contain")

*Gesucht:*
#enum(numbering: "a)")[Ersatzquelle an den Lampenklemmen.][Grafischer Arbeitspunkt.][Erforderliche Dauerleistung von R5.][Ungefähre Absenkung von Uq bis zum Erlöschen.]
#src[V S. 103–105, Aufgabe 4.4.2; grafische Genauigkeit explizit eingeordnet.]
][
*Leerlaufdifferenz bilden:* Ohne Lampenstrom fällt an R5 nichts ab. Die obere Mitte hat $250 dot.c 4/5=200$ V gegen rechts, die untere $250 dot.c 1/5=50$ V. Also Ul=150 V. Mit kurzgeschlossener Quelle ist $R_i=10+(1 parallel 4)+(4 parallel 1)="11,6" thin "k"Omega$.

][
*Kurzschluss und Lastlinie:* $I_k=150/11600 approx "12,93" thin "mA"$. Die Lastlinie $I=(150-U)/11600$ schneidet die Lampenkennlinie ungefähr bei U=70 V und I=7 mA. Mit genau 70 V liefert die Linie 6,90 mA; die Diagrammablesung ist entsprechend grob.

][
*Widerstand belasten:* Durch R5 fließt derselbe Lampenstrom. Mit 7 mA ist $P_5=I^2 R_5=("0,007")^2 dot.c 10000="0,49" thin "W"$. Damit fordert das Skript mindestens die 0,5-W-Größenordnung; eine reale Reserve wäre nach Betriebsbedingungen festzulegen.

][
*Haltegrenze verschieben:* Für die abgelesene Grenze 110 V/1 mA muss $U_l' approx 110+"0,001" dot.c 11600="121,6" thin "V"$ sein. Weil $U_l="0,6"U_q$, folgt Uq'≈202,7 V. Grafisch ist dies rund 200 V, also etwa 50 V Absenkung. Die grobe Skriptangabe ist kein auf einzelne Volt genauer Grenzwert.

][
*Kennlinie richtig deuten:* Auf dem fallenden Teil ist der differenzielle Widerstand negativ, während U und I positiv und damit die aufgenommene Leistung positiv bleiben. Die Haltegrenze ist von der Zündbedingung zu unterscheiden.
]

#aufgabe(titel: "Gemischte Quellen und eine nichtlineare Last", art: "rechnen", quelle: "4.4.3",
 ergebnis: [$U_l="7,5" thin "V"$, $R_i=750 thin Omega$; Anpassung 18,75 mW, nichtlineare Last etwa 12 mW.])[
#if not web [*Aufgabe 130* #linebreak()]
*Gegeben und Annahmen:* Stromquelle 10 mA nach oben parallel zu 1 kΩ. Vom oberen linken Knoten führen 0,5 kΩ und eine ideale 5-V-Quelle (Spannungsanhebung nach rechts) zur Klemme A. Zwischen A und Masse B bleibt ein 1,5-kΩ-Widerstand. Die Last Ra ist zusätzlich an A–B angeschlossen.
#image("abbildungen/gesamt-quellen-mischung.svg", width: 100%, height: 32mm, fit: "contain")#image("abbildungen/gesamt-nichtlinear-lastkurve.svg", width: 100%, height: 43mm, fit: "contain")

*Gesucht:*
#enum(numbering: "a)")[Ul und Ri ohne Ra.][Ohmsche Last für Maximalleistung mit Strom, Spannung und Leistung.][Arbeitspunkt und Leistung für die gegebene nichtlineare Lastkennlinie.]
#src[V S. 106, Aufgabe 4.4.3.]
][
*Linke Quelle umformen:* 10 mA parallel 1 kΩ entsprechen einer 10-V-Quelle mit 1 kΩ in Reihe. Die weitere 5-V-Quelle unterstützt sie. Zusammen sind dies 15 V mit 1,5 kΩ in Reihe; der feste 1,5-kΩ-Widerstand bleibt als Belastung erhalten.

][
*Äußere Ersatzquelle berechnen:* Der unbelastete Ausgang gegenüber der zusätzlichen Ra-Last hat $U_l=15 dot.c "1,5"/("1,5"+"1,5")="7,5" thin "V"$. Quellen null setzen ergibt $R_i=(1+"0,5") parallel "1,5"="0,75" thin "k"Omega=750 thin Omega$.

][
*Ohmsche Leistungsanpassung:* Bei Ra=750 Ω gilt Ia=7,5/1500=5 mA, Ua=3,75 V und Pa=Ua Ia=18,75 mW. Der Wirkungsgrad des Ersatzkreises ist 50 %; das ist keine Aussage über alle ursprünglichen inneren Leistungen.

][
*Nichtlineare Last schneiden:* Die Quellenlinie verläuft von 10 mA bei U=0 nach 7,5 V bei I=0. Ihr Schnitt mit der vorgegebenen Kurve liegt bei etwa 6 V und 2 mA. Daher nimmt die Last $P_a approx 6 thin "V" dot.c 2 thin "mA"=12 thin "mW"$ auf.
]

#aufgabe(titel: "Rote LED an einem Netz mit zwei Spannungsquellen", art: "rechnen", quelle: "4.4.4",
 ergebnis: [$R_i=200 thin Omega$, $I_"LED" approx 15 thin "mA"$, $U_"q1"=12 thin "V"$.])[
#if not web [*Aufgabe 131* #linebreak()]
*Gegeben und Annahmen:* R1=R2=1200 Ω, R3=R4=600 Ω. R1 von oberem Uq1-Knoten nach A; R2 vom Knoten Uq1+6 V nach A. R3 und R4 von A nach Masse B. Die zusätzliche rote LED liegt A–B. Quelle Uq2=6 V hebt das Potenzial vom linken zum rechten oberen Knoten an. Gefordert ist ohne LED eine Leerlaufspannung UAB=5 V.
#image("abbildungen/gesamt-led-rot-netz.svg", width: 100%, height: 45mm, fit: "contain")#image("abbildungen/gesamt-led-rot-kennlinie.svg", width: 100%, height: 55mm, fit: "contain")

*Gesucht:*
#enum(numbering: "a)")[Ri und LED-Strom bei vorgegebener Leerlaufspannung.][Erforderliche Uq1 für diese Leerlaufspannung.]
#src[V S. 107, Aufgabe 4.4.4.]
][
*Innenwiderstand mit nullgesetzten Quellen:* Nach Kurzschluss beider Spannungsquellen liegen alle vier Widerstände parallel. $1/R_i=2/1200+2/600=1/200$, also Ri=200 Ω.

][
*Quellenlinie zeichnen:* Sie läuft von 5 V bei I=0 nach 25 mA bei U=0. Der Schnitt mit der LED-Kennlinie liegt ungefähr bei 2 V und 15 mA. Probe: $(5-2)/200="0,015" thin "A"$. Die 5 V liegen beim angeschlossenen Bauteil nicht unverändert an der LED.

][
*Leerlauf-Knotenbilanz:* Ohne LED gilt $(U_"q1"-5)/1200+(U_"q1"+6-5)/1200=5/600+5/600$. Multiplizieren mit 1200 ergibt $2U_"q1"-4=20$, also Uq1=12 V.

][
*Polung und Größe prüfen:* Allgemein ist $U_l=(2U_"q1"+6)/6=U_"q1"/3+1 thin "V"$. Mit 12 V ergeben sich 5 V. Die positive Durchlasskennlinie liefert hier die tatsächliche LED-Spannung; die Schwellenangabe von etwa 1,9 V ist eine Näherung.
]

#aufgabe(titel: "Transistor: größte Quellspannung bei 0,4 Watt Verlust", art: "rechnen", quelle: "4.4.5",
 ergebnis: [AP ungefähr 40 mA/10 V; $U_"q,max" approx 18 thin "V"$; $P_(R C) approx "0,32" thin "W"$.])[
#if not web [*Aufgabe 132* #linebreak()]
*Gegeben und Annahmen:* Kollektorwiderstand RC=200 Ω, Basisstrom IB=200 µA, zulässige Transistorleistung PT=0,4 W. Ausgangskennlinienfeld wie unten; Basisleistung wird im Skriptmodell vernachlässigt.
#image("abbildungen/gesamt-transistor-rc-netz.svg", width: 100%, height: 30mm, fit: "contain")#image("abbildungen/gesamt-transistor-rc-feld.svg", width: 100%, height: 65mm, fit: "contain")

*Gesucht:*
#enum(numbering: "a)")[Verlustleistungshyperbel.][Grafisch größtmögliche Uq für den gewählten Basisstrom.][Zugehöriger Arbeitspunkt.][Wärmeleistung in RC.]
#src[V S. 108, Aufgabe 4.4.5; Werte aus der Grafik angenähert, Leistungsbilanz ergänzt.]
][
*Leistungsgrenze eintragen:* $I_C="0,4" thin "W"/U_(C E)$. Geeignete Punkte sind 4 V/100 mA, 8 V/50 mA und 10 V/40 mA. Oberhalb der Hyperbel würde der Transistor mehr als 0,4 W umsetzen.

][
*Basisstromkurve auswählen:* Verwendet wird ausschließlich die Kurve für 200 µA. Ihr Schnitt mit der Hyperbel liegt ungefähr bei IC=40 mA und UCE=10 V. Die grafische Auflösung erlaubt nur ungefähre Werte.

][
*Quelle über die Masche bestimmen:* $U_q=U_(C E)+I_C R_C approx 10 thin "V"+"0,04" thin "A" dot.c 200 thin Omega=18 thin "V"$. Die Lastgerade mit Steigung −1/200 Ω wird durch den Grenzpunkt gelegt.

][
*Widerstandsleistung getrennt prüfen:* $P_(R C)=I_C^2 R_C approx ("0,04")^2 dot.c 200="0,32" thin "W"$. Kontrolle: Die Kollektorquelle liefert ungefähr 18 V·40 mA=0,72 W; 0,4 W Transistor plus 0,32 W Widerstand ergeben dieselbe Summe.
]
