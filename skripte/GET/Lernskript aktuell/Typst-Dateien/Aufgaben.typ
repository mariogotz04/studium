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
#let aufgabe(titel: none, art: "rechnen", quelle: none, ergebnis: none, tipp: none, ..teile) = {
  assert(titel != none, message: "Jede Aufgabe braucht einen titel")
  assert(art in ("rechnen", "verstehen"), message: "art ist \"rechnen\" oder \"verstehen\": " + titel)
  let teile = teile.pos()
  assert(teile.len() >= 2, message: "Aufgabe ohne Lösungsschritte: " + titel)
  let (text-aufgabe, ..schritte) = teile
  let info = context [#metadata((titel: titel, art: art, quelle: quelle, kapitel: _kapitel.get(),
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


#kapitel("Kapitel 0 · Vorwissen: Strom, Spannung, Widerstand, Leistung")

// 0-1
#aufgabe(titel: "Geladene Teilchen im Draht", art: "verstehen", quelle: "0.1")[
Welche Elementarteilchen sind elektrisch geladen? Welche davon bewegen sich in einem Metalldraht?
][
Protonen (+) und Elektronen (−). Im Metall bewegen sich nur die Elektronen; Neutronen und Atome als Ganzes sind neutral.
]

// 0-2
#aufgabe(titel: "Kräfte zwischen Ladungen", art: "verstehen", quelle: "0.1")[
Wie wirken gleichartige und ungleichartige Ladungen aufeinander?
][
Gleichartige stoßen sich ab, ungleichartige ziehen sich an.
]

// 0-3
#aufgabe(titel: "Warum ein Leiter warm wird", art: "verstehen", quelle: "0.2")[
Warum setzt ein Leiter dem Strom einen Widerstand entgegen? Was entsteht dabei?
][
Die Elektronen stoßen an die Atome des Gitters („Reibung“). Dabei wird elektrische Energie in Wärme umgewandelt.
]

// 0-4
#aufgabe(titel: "Wovon der Widerstand abhängt", art: "verstehen", quelle: "0.2")[
Nenne vier Größen, von denen der Widerstand eines Leiters abhängt.
][
Material ($rho$), Länge $l$, Querschnitt $A$ und Temperatur.
]

// 0-5
#aufgabe(titel: "AC, DC, PTC und NTC", art: "verstehen", quelle: "0.2")[
Wofür stehen AC, DC, PTC und NTC?
][
AC = Alternating Current (Wechselstrom), DC = Direct Current (Gleichstrom), PTC = Kaltleiter ($R$ steigt mit $T$), NTC = Heißleiter ($R$ sinkt mit $T$).
]

// 0-6
#aufgabe(titel: "Größerer Widerstand in Reihe", art: "verstehen", quelle: "0.4")[
In einer Reihenschaltung wird ein Widerstand vergrößert. Was passiert mit Strom, Leistung und Belastung der Quelle?
][
Strom sinkt, Leistung sinkt, die Quelle wird weniger belastet.
]

// 0-7
#aufgabe(titel: "Spannungsebenen zuordnen", art: "verstehen", quelle: "0.1")[
Ordne zu: 380 kV, 400 V, 230 V, 12 V, 1,5 V → AAA-Batterie, Höchstspannung, Drehstromnetz, Wechselstromnetz, PKW-Batterie.
][
AAA 1,5 V; Höchstspannung 380 kV; Drehstrom 400 V; Wechselstrom 230 V; PKW 12 V.
]

// 0-8
#aufgabe(titel: "Bester Leiterwerkstoff", art: "verstehen", quelle: "0.2")[
Welcher Werkstoff leitet am besten: Eisen, Silber, Kupfer oder Gold?
][
Silber, vor Kupfer, Gold und Eisen.
]

// 0-9
#aufgabe(titel: "Reihenschaltung: was gleich bleibt", art: "verstehen", quelle: "0.4")[
Zwei unterschiedliche Widerstände liegen in Reihe. Was ist an beiden gleich, was ist verschieden? Hat die Schaltungsart Einfluss auf Strom und Spannung?
][
Der Strom ist an beiden gleich; die Spannungen teilen sich im Verhältnis der Widerstände. Die Schaltungsart bestimmt also sehr wohl Strom und Spannung.
]

// 0-10
#aufgabe(titel: "Parallelschaltung: was gleich bleibt", art: "verstehen", quelle: "0.4")[
Unterschiedliche Widerstände liegen parallel. Was gilt für Spannung, Strom und Leistung der einzelnen Widerstände? Was passiert mit dem Gesamtstrom, wenn ein Widerstand ausfällt?
][
An jedem Widerstand liegt dieselbe Spannung, die Ströme sind verschieden. Je größer der Widerstand, desto kleiner seine Leistung ($P = U^2\/R$). Fällt ein Zweig aus, sinkt der Gesamtstrom.
]

// 0-11
#aufgabe(titel: "Ladung aus Strom und Zeit", art: "rechnen", quelle: "0.1",
  ergebnis: [$Q = 18 thin "mC"$],
  tipp: [Strom ist Ladung pro Zeit. Was musst du also mit der Zeit machen, um die Ladung zu bekommen?],
)[
Welche Ladung wird bei konstant 600 mA in 30 ms transportiert?
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
Signallampe 3 W / 0,5 A: Wie groß ist ihr Betriebswiderstand?
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
Heizspirale 75 Ω an 230 V: Welcher Strom fließt?
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
Wärmegerät 2,5 kW, gemessener Strom 3,75 A: An welcher Spannung wird es betrieben?
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
Reihenschaltung, $R_"ges" = 180 thin Omega$, $I = 2 thin "A"$, $R_1 = 70 thin Omega$. a) $R_2$? b) Teilspannungen? c) Gesamtspannung?
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
Drei Widerstände parallel an 36 V, Ströme 4,5 A, 7 A und 5 A. a) Teilwiderstände? b) Gesamtstrom? c) Gesamtwiderstand?
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
Unbelasteter Spannungsteiler: $R_1 = 15 thin "k"Omega$, $R_2 = 100 thin "k"Omega$, $U = 35 thin "V"$. Wie groß ist $U_20$ an $R_2$?
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
Rechne um: a) 2,67 V in µV b) 180 µA in mA c) 370 kΩ in MΩ d) 36,2 mA in µA e) 4700 µΩ in Ω f) 50 000 A in kA.
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
Eine Kupferleitung führt 25 m hin und 25 m zurück, $A = "1,5" thin "mm"^2$, $rho_"Cu" = "0,0179" thin Omega thin "mm"^2\/"m"$ (Daten aus V S. 9). Bestimme die Leiterlänge und den Widerstand. Warum zählt die Länge doppelt?
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
Ein Kupferdraht ($rho = "0,0178" thin Omega thin "mm"^2\/"m"$) ist 20 m lang und hat 0,5 mm Durchmesser. Wie groß ist sein Widerstand?
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
*Kohleschicht-Widerstand, Ü 1a:* Die Kohleschicht ist zu einer Wendel von 95 mm Länge und 3,5 mm Breite geschliffen, $rho_"Kohle" = 60 thin Omega thin "mm"^2\/"m"$. Wie dick muss die Schicht sein, damit der Widerstand 80 kΩ beträgt?
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
*Aluminium und Kupfer, Ü 7 (= Blatt B 14):* In welchem Verhältnis stehen a) die Querschnitte gleich langer und widerstandsgleicher Aluminium- und Kupferleiter, b) die Widerstände gleich langer Kupferleiter mit dem Durchmesserverhältnis 2 : 1? ($rho_"Al" = "0,0278"$, $rho_"Cu" = "0,0178" thin Omega thin "mm"^2\/"m"$)
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
*Belastbarkeit, Blatt A 1:* An welcher Spannung darf ein Widerstand von 4,7 kΩ mit einer Dauerbelastbarkeit von 1/8 W höchstens betrieben werden?
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
*Spannung +10 %, Blatt A 6:* Bei einem Verbraucher mit konstantem Widerstand steigt die Spannung um 10 % über die Nennspannung. Um wie viel Prozent ändert sich die Leistung?
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
*Wasserkocher, Blatt A 7:* Nenndaten 230 V / 1500 W, Wirkungsgrad 0,85. Wie lange dauert es, 1 Liter Wasser von 15 °C auf 100 °C zu erwärmen? ($c = "4,19" thin "kJ/(kg K)"$, 1 J = 1 Ws)
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
*Reihenschaltung, Blatt B 15:* Drei Widerstände in Reihe liegen an 10 V. In $R_1 = 39 thin Omega$ fließen 75,2 mA. Wie groß sind $R_2 = R_3$?
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
*Stand-by, Blatt B 16:* Ein Fernseher nimmt im Betrieb 90 W auf, im Stand-by 15 W; Betrieb 4 h, Stand-by 20 h täglich. a) Monatlicher Energiebedarf (30 Tage) im Betrieb? b) im Stand-by? c) Zu wie viel Prozent wäre ein 400-MW-Kraftwerk ausgelastet, um den Stand-by von 10 Millionen Geräten zu versorgen?
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
*Elektromotor, Blatt B 18:* Ein Motor gibt an der Welle 6,5 kW ab, Wirkungsgrad 78 %. Wie groß ist seine Stromaufnahme an 440 V Gleichspannung?
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
*Ergänzung zu FK 25, eigene Aufgabe:* Der Spannungsteiler aus Abschnitt 0.6 erhält einen Verbraucher $R_L = 100 thin "k"Omega$ parallel zu $R_2 = 100 thin "k"Omega$. $R_1 = 15 thin "k"Omega$, $U = 35 thin "V"$. a) Welche Spannung liegt jetzt am Ausgang? b) Warum ist sie kleiner als im Leerlauf?
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
*FK 27, am 22.10. bearbeitet:* Eine Mignonzelle hat $U_q = "1,52" thin "V"$ und $R_i = "0,13" thin Omega$. Berechne die Klemmenspannung bei 40 mA und, als eigene Variation, bei 80 mA. Erkläre den Unterschied.
][
*Modell der realen Quelle:* Eine Batterie ist eine ideale Quelle $U_q$ mit einem kleinen Widerstand $R_i$ in Reihe. Fließt Strom, fällt an $R_i$ die Spannung $U_i = I R_i$ ab, und außen kommt nur der Rest an: $U = U_q - I R_i$.
][
*Bei 40 mA:* $U_i = "0,04" thin "A" dot.c "0,13" thin Omega = "0,0052" thin "V"$, also $U = "1,52" - "0,0052" = "1,5148" thin "V"$.
][
*Bei 80 mA:* $U_i = "0,08" dot.c "0,13" = "0,0104" thin "V"$, also $U = "1,5096" thin "V"$.
][
*Deuten und prüfen:* Doppelter Strom, doppelter innerer Spannungsabfall (5,2 → 10,4 mV), weil $U_i$ proportional zu $I$ ist. Beide Klemmenspannungen liegen unter 1,52 V, wie es bei Entladung sein muss.
]


#kapitel("Kapitel 1 · Grundbegriffe: Strom und Quellspannung")

// 1-1
#aufgabe(titel: "Die Formel Q = n e A l", art: "verstehen", quelle: "1.1.1")[
Erkläre die Formel $Q = n e A l$. Was bedeutet jede Größe?
][
$n$ = freie Elektronen pro Volumen, $e$ = Ladung eines Elektrons, $A l = V$ = Volumen des Leiterstücks. Das Produkt ist die gesamte bewegliche Ladung im Stück.
]

// 1-2
#aufgabe(titel: "Stromstärke definieren", art: "verstehen", quelle: "1.1.2")[
Definiere die Stromstärke in Worten und als Formel. Wie viele Elektronen sind „1 Ampere“?
][
Stromstärke = Ladung, die pro Zeit durch den Querschnitt fließt: $I = Q\/t$ bzw. $i = dif Q\/dif t$. 1 A ≈ $"6,25" dot.c 10^18$ Elektronen pro Sekunde.
]

// 1-3
#aufgabe(titel: "Technische und physikalische Stromrichtung", art: "verstehen", quelle: "1.1.2")[
Was ist der Unterschied zwischen technischer und physikalischer Stromrichtung? Welche benutzt man im Schaltbild?
][
Technisch: + nach − (Konvention, im Schaltbild). Physikalisch: − nach + (tatsächliche Elektronenbewegung).
]

// 1-4
#aufgabe(titel: "Warum das Licht sofort angeht", art: "verstehen", quelle: "1.1.3")[
Die Elektronen driften nur mit etwa 1 mm/s. Warum geht das Licht trotzdem sofort an?
][
Das elektrische Feld breitet sich fast mit Lichtgeschwindigkeit aus; alle Elektronen im Kreis beginnen gleichzeitig zu driften.
]

// 1-5
#aufgabe(titel: "Stromdichte und Erwärmung", art: "verstehen", quelle: "1.1.5")[
Warum bestimmt die Stromdichte und nicht die Stromstärke die Erwärmung eines Leiters?
][
Die Erwärmung kommt von der Reibung pro Querschnittsfläche. Derselbe Strom erzeugt in einem dünnen Draht eine viel höhere Stromdichte und damit mehr Wärme als in einem dicken.
]

// 1-6
#aufgabe(titel: "Leiter mit doppeltem Querschnitt", art: "verstehen", quelle: "1.1.5")[
Ein Leiter hat links den Querschnitt $A$, rechts $2 A$. Was gilt rechts für Strom und Stromdichte?
][
Gleicher Strom (Kontinuität), halbe Stromdichte.
]

// 1-7
#aufgabe(titel: "Drei Wirkungen des Stroms", art: "verstehen", quelle: "1.1.6")[
Nenne die drei Wirkungen des Stroms mit je einem Anwendungsbeispiel.
][
Wärme (Heizlüfter), Kraft über das Magnetfeld (Elektromotor), Materialtransport (elektrochemische Prozesse, z. B. Galvanisieren).
]

// 1-8
#aufgabe(titel: "Wovon die Lorentzkraft abhängt", art: "verstehen", quelle: "1.1.6")[
Wovon hängt die Lorentzkraft auf einen stromdurchflossenen Leiter ab? Wann ist sie null?
][
$F_L = I l B$: Sie wächst mit Strom, Leiterlänge im Feld und Flussdichte. Liegt der Leiter parallel zum Feld, ist $arrow(l) times arrow(B) = 0$, also keine Kraft.
]

// 1-9
#aufgabe(titel: "Lineare Skala des Drehspulinstruments", art: "verstehen", quelle: "1.1.6")[
Warum hat ein Drehspulinstrument eine lineare Skala?
][
Weil $phi = N A B\/D^* dot.c I$: Der Ausschlag ist proportional zum Strom.
]

// 1-10
#aufgabe(titel: "Warum Hochspannung übertragen wird", art: "verstehen", quelle: "1.1.5")[
Warum überträgt man elektrische Energie über weite Strecken mit Hochspannung?
][
Die Leitungsverluste $P = I^2 R$ hängen quadratisch vom Strom ab. Bei hoher Spannung braucht man für dieselbe Leistung nur wenig Strom.
]

// 1-11
#aufgabe(titel: "Wie eine Quellspannung entsteht", art: "verstehen", quelle: "1.2.1")[
Was muss in jeder Spannungsquelle passieren, damit eine Quellspannung entsteht? Welche Energieumwandlung findet in Batterie und Generator statt?
][
Ladungstrennung durch einen physikalischen Effekt. Batterie: chemisch → elektrisch. Generator: mechanisch → elektrisch (Induktion).
]

// 1-12
#aufgabe(titel: "Induktionsgesetz in Worten", art: "verstehen", quelle: "1.2.2")[
Formuliere das Induktionsgesetz in Worten. Was bedeutet das Minuszeichen?
][
Ändert sich der magnetische Fluss durch eine Spule, wird eine Spannung induziert, umso größer, je schneller die Änderung und je mehr Windungen. Das Minus (Lenz): Die Wirkung ist ihrer Ursache entgegengerichtet.
]

// 1-13
#aufgabe(titel: "Ruhender Magnet in der Spule", art: "verstehen", quelle: "1.2.2")[
Ein Magnet liegt ruhig in einer Spule. Wird eine Spannung induziert? Und wenn man die Spule aus dem Feld zieht?
][
Ruhender Magnet: nein, der Fluss ist konstant, $dif Phi\/dif t = 0$. Spule aus dem Feld ziehen: ja, der Fluss durch die Spule ändert sich.
]

// 1-14
#aufgabe(titel: "Lampen-Aufgabe: Schalter schließen", art: "verstehen", quelle: "1.1.7.1")[
In der Lampen-Aufgabe wird S geschlossen. Was passiert mit C, mit dem Batteriestrom, mit A und B und mit der Gesamtleistung?
][
C erlischt, der Batteriestrom steigt, A und B leuchten heller, die Gesamtleistung steigt.
]

// 1-15
#aufgabe(titel: "Ladung und Elektronenzahl", art: "rechnen", quelle: "1.1.1",
  ergebnis: [a) $Q = 60 thin "As"$ b) $N approx "3,75" dot.c 10^20$ Elektronen],
  tipp: [Erst die Ladung aus Strom und Zeit; dann fragen: Wie viele Elementarladungen passen in diese Ladung?],
)[
Durch einen Leiter fließen 2 Minuten lang 0,5 A. a) Welche Ladung? b) Wie viele Elektronen sind das?
][
*a) Ladung:* Bei konstantem Strom ist $Q = I t$. Die Zeit muss in Sekunden: 2 min = 120 s. Also $Q = "0,5" thin "A" dot.c 120 thin "s" = 60 thin "As" = 60 thin "C"$.
][
*b) Elektronen zählen:* Jedes Elektron trägt die Elementarladung $e = "1,602" dot.c 10^(-19) thin "C"$. Die Anzahl ist die Gesamtladung geteilt durch die Ladung eines Elektrons: $N = Q\/e = 60\/("1,602" dot.c 10^(-19)) approx "3,75" dot.c 10^20$.
][
*Prüfen:* Faustwert: 1 A sind etwa $"6,25" dot.c 10^18$ Elektronen pro Sekunde. 0,5 A über 120 s: $"0,5" dot.c 120 dot.c "6,25" dot.c 10^18 = "3,75" dot.c 10^20$. Eine riesige Zahl, weil ein einzelnes Elektron winzig wenig Ladung trägt.
]

// 1-16
#aufgabe(titel: "Stromdichte und Driftgeschwindigkeit", art: "rechnen", quelle: "1.1.5",
  ergebnis: [a) $S approx "10,7" thin "A/mm"^2$, nicht dauerhaft zulässig b) $v_d approx "0,79" thin "mm/s"$],
  tipp: [Für $v_d$ stellst du $I = n e A v_d$ um. Achte darauf, dass alle Längen in derselben Einheit stehen wie $n$.],
)[
Kupferleitung, $A = "1,5" thin "mm"^2$, $I = 16 thin "A"$. a) Stromdichte $S$? Ist das zulässig? b) Driftgeschwindigkeit $v_d$?
][
*a) Stromdichte:* $S = I\/A$ sagt, wie viel Strom sich durch jeden Quadratmillimeter drängt. $S = 16 thin "A"\/"1,5" thin "mm"^2 approx "10,7" thin "A/mm"^2$.
][
*Bewerten:* Für Kupferleitungen gelten etwa 1 bis 6 A/mm² als dauerhaft zulässig. 10,7 A/mm² liegt deutlich darüber; die Leitung würde zu warm.
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
Kupferleitung (Daten aus V S. 9): $I = "16,66" thin "A"$, $A = "1,5" thin "mm"^2$. Rechne $A$ in cm² um und bestimme $v_d$.
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
  ergebnis: [$S = 4 thin "A/mm"^2$, zulässig],
)[
Durch einen Leiter mit 2,5 mm² fließen 10 A. Wie groß ist die Stromdichte? Liegt sie im zulässigen Bereich?
][
*Formel:* Stromdichte ist Strom pro Querschnittsfläche, $S = I\/A$. Sie entscheidet über die Erwärmung, nicht der Strom allein.
][
*Einsetzen:* $S = 10 thin "A"\/"2,5" thin "mm"^2 = 4 thin "A/mm"^2$.
][
*Bewerten:* Der übliche Bereich liegt bei 1 bis 6 A/mm². 4 A/mm² liegt darin, die Leitung ist also zulässig belastet.
]

// 1-19
#aufgabe(titel: "Kraft auf einen Leiter im Magnetfeld", art: "rechnen", quelle: "1.1.6",
  ergebnis: [$F = "0,5" thin "N"$],
)[
Ein gerader Leiter liegt auf 20 cm Länge senkrecht in einem Magnetfeld $B = "0,5" thin "T"$ und führt 5 A. Wie groß ist die Kraft?
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
Ein Drehspulinstrument zeigt bei 2 mA einen Ausschlag von 30°. Welchen Ausschlag zeigt es bei 5 mA?
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
Lampen-Aufgabe mit $U_q = 9 thin "V"$ und $R = 30 thin Omega$ je Lampe. Berechne Strom, Spannung an A und Leistung von A, jeweils bei offenem und bei geschlossenem Schalter.
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
Vier gleiche Lampen liegen in Reihe an 12 V. Eine Lampe wird überbrückt. Wie groß ist die Spannung an einer der übrigen Lampen vorher und nachher? Um welchen Faktor ändert sich ihre Leistung?
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
Netzfrequenz in den USA: 60 Hz. Wie lang ist eine Periode?
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
Eine Spule mit 500 Windungen; der Fluss steigt in 0,1 s gleichmäßig von 0 auf 2 mWb. Wie groß ist $abs(u_i)$?
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
Eine Spule mit 500 Windungen und 4 cm² Querschnitt steckt in einem Feld mit $B = "0,4" thin "T"$. Sie wird in 50 ms ganz aus dem Feld gezogen. Wie groß ist $abs(u_i)$ bei gleichmäßiger Änderung?
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
Eine Powerbank speichert 10 Ah. Ein Gerät zieht konstant 0,8 A. Wie lange reicht die Ladung?
][
*Was heißt Ah?* Amperestunden sind Strom mal Zeit, also eine Ladung. 10 Ah heißt: 10 A eine Stunde lang, oder 1 A zehn Stunden lang.
][
*Rechnen:* Aus $Q = I t$ folgt $t = Q\/I = 10 thin "Ah"\/"0,8" thin "A" = "12,5" thin "h"$.
][
*Prüfen:* Ah geteilt durch A ergibt h. In der Praxis ist es etwas weniger, weil die Elektronik der Powerbank selbst Verluste hat.
]

// 1-27
#aufgabe(titel: "Entladezeit des Auto-Akkus", art: "rechnen", quelle: "1.1.2")[
*Auto-Akku, Ü 2 und V S. 7:* In einem vollgeladenen 12-V-Akku sind 36 Ah gespeichert. Wie groß ist die theoretische Entladezeit mit zwei parallelen Scheinwerferlampen zu je 42 W?
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
*E-Bike-Akku:* 36 V und 14 Ah, der Motor nimmt 250 W auf. a) Welcher Strom fließt? b) Wie lange kann man fahren? c) Wie viel Energie in Wh steckt im Akku?
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
*Drehspulinstrument:* Vollausschlag 90° bei 1 mA. a) Welcher Strom fließt bei 36°? b) Welche Ladung fließt bei diesem Strom in 5 s durch das Instrument? c) Warum darfst du hier mit einem Dreisatz rechnen?
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
*Thermoeffekt, eigene Ergänzung zu V S. 17:* Ein Cu–Konstantan-Thermoelement hat die Messstelle bei 80 °C, die Vergleichsstelle bei 20 °C. Verwende $K = "0,05" thin "mV/K"$. a) Berechne die Spannung. b) Was ändert sich beim Vertauschen der Temperaturen? c) Was misst du, wenn beide Stellen bei 80 °C liegen?
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
*Fotoeffekt, eigene Ergänzung zu V S. 18–19:* Silizium hat die Bandlücke 1,12 eV und die Grenzwellenlänge rund 1,11 µm. a) Können Photonen mit 850 nm bzw. 1550 nm im einfachen Bandlückenmodell Elektron-Loch-Paare erzeugen? b) Hilft bei ungeeigneter Wellenlänge einfach mehr Licht? Begründe mit der Energie eines Photons.
][
a) 850 nm = 0,85 µm liegt unter der Grenzwellenlänge: im Modell genügend Energie. 1550 nm = 1,55 µm liegt darüber: zu wenig Energie. b) Mehr Photonen gleicher Wellenlänge ändern die Energie pro Photon $h c/lambda$ nicht; im einfachen Modell reicht mehr langwelliges Licht deshalb nicht.
]

// 1-32
#aufgabe(titel: "Direkter und umgekehrter Piezoeffekt", art: "verstehen", quelle: "1.2.5")[
*Piezoeffekt, eigene Verständnisfrage zu V S. 19:* Erkläre den direkten und den umgekehrten Effekt jeweils an einer Anwendung. Welche Material- und Richtungsbedingung musst du beachten?
][
Direkt: Eine mechanische Kraft auf den Kristall erzeugt ein elektrisches Signal, etwa beim Kristallmikrofon. Umgekehrt: Eine Spannung verformt den Kristall, etwa zur Ultraschallerzeugung. Der Kristall muss piezoelektrisch sein und in der passenden Richtung beansprucht werden.
]

// 1-33
#aufgabe(titel: "Grenzwellenlänge für Germanium", art: "rechnen", quelle: "1.2.4.1")[
*Grenzwellenlänge, eigene Rechenvariation zu Tabelle 1.1:* Berechne für Germanium mit $W = "0,67" thin "eV"$ die Grenzwellenlänge in µm. Verwende $h = "6,626" dot.c 10^(-34) thin "Js"$, $c = 299792458 thin "m/s"$ und die eV-Umrechnung aus Abschnitt 1.2.4. Vergleiche mit der Tabelle.
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
*Temperatur aus Spannung, eigene Ergänzung:* Ein Cu–Konstantan-Thermoelement liefert in der gewählten Polung +3 mV. Die Vergleichsstelle hat 25 °C. Wie warm ist die Messstelle bei Verwendung des Skriptkoeffizienten? Welche Annahme steckt darin?
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
*Schwingquarz, eigene Variation zu V S. 19:* Ein Quarz schwingt mit 32768 Hz. Eine Elektronik teilt diesmal nur durch $2^14$. Welche Taktfrequenz und Periodendauer entstehen? Ändert die Frequenzteilung die mechanische Quarzfrequenz?
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
*Spule, eigene Rechenaufgabe zu N PDF-S. 3:* Die 12-V-Quelle wird an $R = 10 thin Omega$, $L = 10 thin "mH"$ eingeschaltet; anfangs fließt kein Strom. a) Bestimme Endstrom und Zeitkonstante. b) Berechne Strom und Spulenspannung nach einer Zeitkonstante. c) Was geschieht mit Endstrom und Zeitkonstante, wenn $R$ auf 20 Ω steigt?
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
*Magnetfeld, FK 28 als offene Frage; am 22.10. bearbeitet:* a) Erzeugt auch ein Strom von 0,5 A ein Magnetfeld? b) Eine Spule und ein Magnetfeld ruhen unverändert gegeneinander: Wird Spannung induziert? c) Kann in einem zeitlich konstanten Magnetfeld trotzdem eine Spannung induziert werden? Nenne eine passende Bewegung und die entscheidende Bedingung.
][
a) Ja, jeder Strom erzeugt ein Magnetfeld; dafür gibt es keine 1-A-Schwelle. b) Nein: Der Fluss bleibt konstant. c) Ja: etwa beim Herausziehen der Spule aus dem Feld oder beim Drehen der Spule. Entscheidend ist die Änderung des magnetischen Flusses durch ihre Fläche; eine Bewegung, bei der der Fluss unverändert bleibt, genügt nicht.
]

// 1-38
#aufgabe(titel: "Diode mit Vorwiderstand", art: "rechnen", quelle: "1.2.6",
  ergebnis: [a) $I approx "20,9" thin "mA"$ b) $R = 690 thin Omega$],
  tipp: [Die Diode „verbraucht“ ihre 2,1 V. Was bleibt für den Widerstand übrig?],
)[
*Diode, eigene Variation zur 9-V-Randnotiz:* Am Arbeitspunkt liegen an einer Diode 2,1 V. Sie ist mit 330 Ω in Reihe an 9 V angeschlossen. a) Welcher Strom fließt? b) Welcher Vorwiderstand ergibt näherungsweise 10 mA, wenn die Diodenspannung dort ebenfalls mit 2,1 V angesetzt wird? Warum ist der Schnittpunkt der Kennlinien die genauere Methode?
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
*Fotostrom, eigene Anwendung zu V S. 18:* Im betrachteten Arbeitspunkt fließen 20 µA durch den äußeren Widerstand von 100 kΩ. Welche Spannung und Leistung entstehen dort? Welche Bedingung musst du prüfen, bevor du denselben Strom für einen anderen Lastwiderstand annimmst?
][
*Spannung:* $U = I R = 20 dot.c 10^(-6) thin "A" dot.c 100 dot.c 10^3 thin Omega = 2 thin "V"$. Mikro mal Kilo ergibt Milli; $20 dot.c 100 thin "mV" = 2 thin "V"$.
][
*Leistung:* $P = U I = 2 thin "V" dot.c 20 thin mu"A" = 40 thin mu"W"$.
][
*Bedingung:* Der Fotostrom ist nicht für jeden Widerstand gleich. Bei anderer Last stellt sich ein neuer Arbeitspunkt auf der beleuchteten Kennlinie ein; den musst du prüfen. *Prüfen:* A·Ω = V, V·A = W.
]

// 1-40
#aufgabe(titel: "Flussdichte aus dem Ladungsimpuls", art: "rechnen", quelle: "1.2.2")[
*Magnetfeldmessung, eigene Rechenaufgabe nach V S. 16–17:* Eine Messspule mit 200 Windungen und 4 cm² Fläche wird vollständig aus einem homogenen, senkrecht durch die Spulenfläche gerichteten Magnetfeld gezogen. Gesamtwiderstand 100 Ω, gemessene Ladung 2 µC. a) Wie groß ist der Betrag der Flussdichte? b) Was passiert mit dem Ladungsimpuls bei doppelt so schnellem Herausziehen, wenn alle Modellannahmen bestehen bleiben?
][
*Modell:* Spule wird vom ursprünglichen Feld vollständig in den feldfreien Bereich gezogen; Fläche und Orientierung sind definiert, der Gesamtwiderstand ist konstant. Die Formel vernachlässigt Einflüsse der Selbstinduktion während des Messimpulses.
][
Fläche: $A = 4 thin "cm"^2 = 4 dot.c 10^(-4) thin "m"^2$; Ladung: $Q = 2 dot.c 10^(-6) thin "As"$.
][
Flussdichte: $B = (R Q)/(N A) = (100 thin Omega dot.c 2 dot.c 10^(-6) thin "As")/(200 dot.c 4 dot.c 10^(-4) thin "m"^2) = "0,0025" thin "T"$.
][
*Ergebnis: 2,5 mT.* Schnelleres Herausziehen vergrößert die Impulshöhe und verkürzt die Dauer. Bei gleichem Anfangs- und Endfluss bleibt die Fläche unter der Stromkurve, also $Q$, unverändert. *Prüfung:* Ω × As/m² = Vs/m² = T.
]


#kapitel("Kapitel 2 · Der Grundstromkreis")

// 2-1
#aufgabe(titel: "Leerlauf und Kurzschluss", art: "verstehen", quelle: "2.4.1")[
Beschreibe Leerlauf und Kurzschluss: Wie groß sind jeweils $R_a$, $I$, $U_a$ und die Spannung an $R_i$?
][
Leerlauf: $R_a = oo$, $I = 0$, $U_a = U_q$, an $R_i$ 0 V. Kurzschluss: $R_a = 0$, $I = I_k = U_q\/R_i$, $U_a = 0$, an $R_i$ liegt ganz $U_q$.
]

// 2-2
#aufgabe(titel: "Hinweise auf den Innenwiderstand", art: "verstehen", quelle: "2.4.1")[
Woran merkt man, dass eine reale Quelle einen Innenwiderstand haben muss?
][
Der Kurzschlussstrom ist endlich, und die Klemmenspannung sinkt unter Last. Bei einer idealen Quelle wäre $I_k$ unendlich.
]

// 2-3
#aufgabe(titel: "Arbeitspunkt grafisch finden", art: "verstehen", quelle: "2.4.1")[
Wie findet man den Arbeitspunkt grafisch? Was passiert mit ihm, wenn $R_a$ kleiner wird?
][
Quellenkennlinie (von $I_k$ bis $U_q$) und Widerstandsgerade (Ursprungsgerade, Steigung $1\/R_a$) einzeichnen; der Schnittpunkt ist der AP. Kleineres $R_a$: Gerade steiler, AP wandert Richtung Kurzschluss (mehr Strom, weniger Spannung).
]

// 2-4
#aufgabe(titel: "Quellenkennlinie und Widerstandsgerade", art: "verstehen", quelle: "2.4.1")[
Welche Steigung hat die Quellenkennlinie, wo schneidet sie die Achsen? Was bedeutet eine steilere Widerstandsgerade?
][
Steigung $-1\/R_i$; sie schneidet die $I$-Achse bei $I_k$ und die $U$-Achse bei $U_q$. Eine steilere Widerstandsgerade bedeutet einen kleineren Widerstand.
]

// 2-5
#aufgabe(titel: "Leistungsanpassung", art: "verstehen", quelle: "2.4.3")[
Was ist Leistungsanpassung? Welcher Wirkungsgrad ergibt sich, wie groß sind dann $U_a$ und $I$, und wo setzt man sie ein bzw. vermeidet sie?
][
$R_a = R_i$: maximale Leistung am Verbraucher, $eta = 50 thin %$, $U_a = U_q\/2$, $I = I_k\/2$. Erwünscht in der Nachrichtentechnik, vermieden in der Energietechnik ($R_a >> R_i$).
]

// 2-6
#aufgabe(titel: "Wirkungsgrad im Grundstromkreis", art: "verstehen", quelle: "2.4.3")[
Wie hängt der Wirkungsgrad im Grundstromkreis von $R_a$ ab? Wann ist er null, wann steigt er?
][
$eta = R_a\/(R_i + R_a)$: steigt, je größer $R_a$ gegenüber $R_i$ wird; im Kurzschluss ($R_a = 0$) ist $eta = 0$. Bei Anpassung ist $P_a$ maximal, nicht $eta$.
]

// 2-7
#aufgabe(titel: "Ideale und reale Spannungsquelle", art: "verstehen", quelle: "2.4.1")[
Skizziere das Schaltbild einer idealen und einer realen Spannungsquelle.
][
Ideal: nur die Quelle $U_q$. Real: $U_q$ mit dem Innenwiderstand $R_i$ in Reihe.
]

// 2-8
#aufgabe(titel: "Innenwiderstand einer Autobatterie", art: "rechnen", quelle: "2.4.1",
  ergebnis: [a) $R_i = 30 thin "m"Omega$ b) $U = "8,1" thin "V"$],
  tipp: [Im Kurzschluss bremst nur noch der Innenwiderstand den Strom.],
)[
Eine Batterie hat $U_l = "12,6" thin "V"$ und $I_k = 420 thin "A"$. a) $R_i$? b) Klemmenspannung, wenn der Anlasser 150 A zieht?
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
Quelle $U_q = 24 thin "V"$, $R_i = 2 thin Omega$, Last $R_a = 10 thin Omega$. Berechne $I$, $U_a$, $U_i$, $P_a$, $P_i$, $P_q$ und $eta$.
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
Gleiche Quelle wie in „Grundstromkreis vollständig berechnen“ ($U_q = 24 thin "V"$, $R_i = 2 thin Omega$): Welches $R_a$ liefert maximale Leistung? Wie groß ist $P_"a,max"$?
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
Eine Quelle liefert bei 2 A eine Klemmenspannung von 10 V und bei 4 A noch 8 V. Bestimme $R_i$ und $U_q$.
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
Grundstromkreis: $U_q = 12 thin "V"$, $R_i = "0,5" thin Omega$, $R_a = "5,5" thin Omega$. Bestimme $I$, $U_a$, $U_i$ und $eta$.
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
Eine Quelle hat 4,5 V Leerlaufspannung. Bei 300 mA misst du an den Klemmen 4,2 V. Bestimme $R_i$ und den angeschlossenen $R_a$.
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
Eine Batterie hat $U_q = 9 thin "V"$ und $R_i = 2 thin Omega$. Bei welchem $R_a$ gibt sie die größte Leistung ab? Wie groß sind dann $P_"a,max"$, $I$ und $U_a$?
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
*Innenwiderstand des Netzes, Ü 3 (= V S. 43):* Heizwiderstand 31,2 Ω, Leerlaufspannung 230 V, Klemmenspannung beim Einschalten 218 V. a) Zeichne den Ersatzstromkreis. b) Wie groß ist $R_i$?
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
*Kohleschicht-Widerstand, Ü 1b:* Der 80-kΩ-Widerstand liegt mit $R_S = 20 thin "k"Omega$ in Reihe an $U_q = 10 thin "V"$. Welche Leistung wird im 80-kΩ-Widerstand in Wärme umgesetzt?
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
*Starterbatterie, Blatt A 2:* Leerlaufspannung 13,8 V, Innenwiderstand 40 mΩ. Welche Leistung kann der Akku höchstens an einen Verbraucher abgeben? Wie groß muss der Verbraucherwiderstand dafür sein?
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
*Akku laden, Blatt B 17:* Vier Ni-Cd-Zellen in Reihe haben zusammen 4,8 V Nennspannung und 0,5 Ω Innenwiderstand. Sie werden 16 h lang mit 0,1 A Konstantstrom geladen. Wie viel elektrische Arbeit wird am Akku verrichtet?
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
*Heizgerät an langer Leitung:* Nenndaten 2 kW / 230 V, angeschlossen über eine 30 m lange Kupferleitung (Hin- und Rückleiter je 1,5 mm², $rho = "0,0178" thin Omega thin "mm"^2\/"m"$). Am Leitungsanfang liegen 230 V, der Heizwiderstand sei konstant. a) Widerstand der Leitung? b) Widerstand des Heizgeräts? c) Strom, Spannung am Gerät, Verlustleistung in der Leitung? d) Stromdichte in der Leitung, zulässig?
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
*Kennlinien zeichnen:* Eine Quelle hat 12 V Leerlaufspannung und 6 A Kurzschlussstrom. a) $R_i$? b) Welches $R_a$ ergibt Leistungsanpassung, wie groß ist dann $P_a$? c) Wirkungsgrad bei $R_a = 6 thin Omega$? d) Zeichne Quellenkennlinie und Widerstandsgerade für $R_a = 6 thin Omega$ und lies den Arbeitspunkt ab.
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

