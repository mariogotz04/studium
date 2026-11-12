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

#aufgabe(titel: "Geladene Teilchen im Draht", art: "verstehen", quelle: "0.1", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 1", minuten: 3)[
#if not web [*Aufgabe 1* #linebreak()]
Welche Elementarteilchen sind elektrisch geladen? Welche davon bewegen sich in einem Metalldraht?
][
*Antwort:* Protonen (+) und Elektronen (−). Im Metall bewegen sich nur die Elektronen; Neutronen und Atome als Ganzes sind neutral.
][
*Ergänzung aus der früheren Karteikarte:* _Welche Teilchen sind geladen, und welche bewegen sich in einem Metalldraht?_

*Antwort:*
- Protonen sind positiv, Elektronen negativ, Neutronen neutral.
- Im Metall bewegen sich nur die Elektronen.
- Die Protonen sitzen fest im Atomgitter.
- Gleichartige Ladungen stoßen sich ab, ungleichartige ziehen sich an.
]

#aufgabe(titel: "Kräfte zwischen Ladungen", art: "verstehen", quelle: "0.1", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 2", minuten: 3)[
#if not web [*Aufgabe 2* #linebreak()]
Wie wirken gleichartige und ungleichartige Ladungen aufeinander?
][
*Antwort:* Gleichartige stoßen sich ab, ungleichartige ziehen sich an.
]

#aufgabe(titel: "Spannungsebenen zuordnen", art: "verstehen", quelle: "0.1", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 4", minuten: 3)[
#if not web [*Aufgabe 3* #linebreak()]
Ordne zu: 380 kV, 400 V, 230 V, 12 V, 1,5 V → AAA-Batterie, Höchstspannung, Drehstromnetz, Wechselstromnetz, PKW-Batterie.
][
*Antwort:* AAA 1,5 V; Höchstspannung 380 kV; Drehstrom 400 V; Wechselstrom 230 V; PKW 12 V.
]

#aufgabe(titel: "Spannung anschaulich", art: "verstehen", quelle: "0.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 4* #linebreak()]
Was ist elektrische Spannung anschaulich?
][
*Antwort:*
- *Spannung:* Energie je Ladung, anschaulich ein elektrischer „Druckunterschied“.
- Sie entsteht durch Ladungstrennung zwischen Plus- und Minuspol.
- Im einfachen Widerstandskreis treibt dieser Unterschied den Strom an.
][
*Bild:* Wasserkreislauf: Die Spannung ist der Druckunterschied der Pumpe.
]

#aufgabe(titel: "Gold-Cap-Kondensator an 5,5 V", art: "rechnen", quelle: "0.1", herkunft: "original", vorlage: "Altklausur (Jahr unbekannt 2), F2", minuten: 4,
  ergebnis: [a) $Q = 11 thin "As"$ b) $I = 0$],
)[
#if not web [*Aufgabe 5* #linebreak()]
*Gegeben und Annahmen*

Ein Gold-Cap-Kondensator mit der Kapazität $C = 2 thin "F"$ liegt seit mehr als 1 h an einer Gleichspannung von 5,5 V an. Für einen Kondensator gilt $Q = C dot.c U$.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist die gespeicherte Ladungsmenge?],
[Welcher Strom fließt in den Zuleitungen?],
)
][
*a) Ladung:* $Q = C U = 2 thin "As"\/"V" dot.c "5,5" thin "V" = 11 thin "As" = 11 thin "C"$. Das sind rund 3 mAh, sehr viel für einen Kondensator.
][
*b) Strom:* Nach mehr als einer Stunde ist der Ladevorgang abgeschlossen; $dif Q\/dif t = 0$, also $I = 0$ (bei idealem Kondensator ohne Leckstrom).
]

#aufgabe(titel: "Gold-Cap mit 0,47 F an 3,3 V (Variante)", art: "rechnen", quelle: "0.1", herkunft: "variante", vorlage: "Altklausur (Jahr unbekannt 2), F2", minuten: 4,
  ergebnis: [a) $Q approx "1,55" thin "As" approx "0,43" thin "mAh"$ b) $I = 0$],
)[
#if not web [*Aufgabe 6* #linebreak()]
*Gegeben und Annahmen*

Ein Gold-Cap-Kondensator mit $C = "0,47" thin "F"$ puffert die Uhr eines Geräts. Er liegt seit mehreren Stunden an der Gleichspannung 3,3 V. Für einen Kondensator gilt $Q = C dot.c U$.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist die gespeicherte Ladungsmenge, in As und in mAh?],
[Welcher Strom fließt in den Zuleitungen?],
)
][
*a) Ladung:* $Q = C U = "0,47" thin "As"\/"V" dot.c "3,3" thin "V" approx "1,55" thin "As"$. Umrechnen: 1 mAh = 3,6 As, also $Q approx "1,55"\/"3,6" approx "0,43" thin "mAh"$. Die Einheit F ist As/V, deshalb kommt direkt As heraus.
][
*b) Strom:* Nach Stunden an konstanter Spannung ändert sich die Ladung nicht mehr: $I = dif Q\/dif t = 0$ (idealer Kondensator ohne Leckstrom). Ein Strom fließt nur, solange sich die Spannung am Kondensator ändert.
]

#aufgabe(titel: "Einheiten umrechnen", art: "rechnen", quelle: "0.1", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 29", minuten: 6,
  ergebnis: [a) 2 670 000 µV b) 0,18 mA c) 0,37 MΩ d) 600 000 mV e) 36 200 µA f) 2200 mΩ g) 0,375 V h) 0,42 A i) 0,0047 Ω j) 0,23 kV k) 50 kA],
  tipp: [Jede Vorsilbe ist ein Faktor 1000 zur nächsten: µ, m, (ohne), k, M.],
)[
#if not web [*Aufgabe 7* #linebreak()]
*Gegeben und Annahmen*

Vorsilben: µ = $10^(-6)$, m = $10^(-3)$, k = $10^3$, M = $10^6$.

*Gesucht*

Wandeln Sie folgende Einheit um!

#enum(numbering: "a)",
[2,67 V in µV],
[180 µA in mA],
[370 kΩ in MΩ],
[600 V in mV],
[36,2 mA in µA],
[2,2 Ω in mΩ],
[375 mV in V],
[420 mA in A],
[4700 µΩ in Ω],
[230 V in kV],
[50000 A in kA],
)
][
*Das Prinzip:* Eine Vorsilbe ist nur ein Faktor: $mu = 10^(-6)$, $"m" = 10^(-3)$, $"k" = 10^3$, $"M" = 10^6$. Wird die Einheit *kleiner*, wird die Zahl *größer*, und umgekehrt. Der Wert selbst ändert sich nie.
][
*a), d), e) und f) zu kleineren Einheiten:* 1 V sind $10^6$ µV, also $"2,67" thin "V" = 2 thin 670 thin 000 thin mu"V"$. 1 V sind 1000 mV, also $600 thin "V" = 600 thin 000 thin "mV"$. 1 mA sind 1000 µA, also $"36,2" thin "mA" = 36 thin 200 thin mu"A"$. 1 Ω sind 1000 mΩ, also $"2,2" thin Omega = 2200 thin "m"Omega$.
][
*b), c), g), h), i), j) und k) zu größeren Einheiten:* $180 thin mu"A" = "0,18" thin "mA"$, $370 thin "k"Omega = "0,37" thin "M"Omega$, $375 thin "mV" = "0,375" thin "V"$, $420 thin "mA" = "0,42" thin "A"$, $230 thin "V" = "0,23" thin "kV"$, $50 thin 000 thin "A" = 50 thin "kA"$ (jeweils durch 1000) und $4700 thin mu Omega = "0,0047" thin Omega$ (durch $10^6$).
][
*Prüfen:* Frage dich bei jeder Antwort: Ist die neue Einheit größer? Dann muss die Zahl kleiner sein. Alle elf Ergebnisse erfüllen das.
]

#aufgabe(titel: "Einheiten umrechnen (Variante)", art: "rechnen", quelle: "0.1", herkunft: "variante", vorlage: "Fragenkatalog Einstieg GET, Frage 29", minuten: 5,
  ergebnis: [a) 45 000 µV b) 0,75 mA c) 2,2 MΩ d) 1,2 kV e) 0,0068 A f) 330 000 mΩ g) 0,015 kA h) 0,47 V],
)[
#if not web [*Aufgabe 8* #linebreak()]
*Gegeben und Annahmen*

Vorsilben: µ = $10^(-6)$, m = $10^(-3)$, k = $10^3$, M = $10^6$.

*Gesucht*

#enum(numbering: "a)",
[45 mV in µV],
[750 µA in mA],
[2200 kΩ in MΩ],
[1200 V in kV],
[6,8 mA in A],
[330 Ω in mΩ],
[15 A in kA],
[470 mV in V],
)
][
*Richtung merken:* Kleinere Einheit → größere Zahl, größere Einheit → kleinere Zahl. Zwischen benachbarten Vorsilben liegt der Faktor 1000.
][
*Zur kleineren Einheit:* a) $45 thin "mV" = 45 thin 000 thin mu"V"$; f) $330 thin Omega = 330 thin 000 thin "m"Omega$.
][
*Zur größeren Einheit:* b) 0,75 mA; c) 2,2 MΩ; d) 1,2 kV; e) 0,0068 A; g) 0,015 kA; h) 0,47 V (jeweils durch 1000).
]

#aufgabe(titel: "Ladung aus Strom und Zeit", art: "rechnen", quelle: "0.1", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 3", minuten: 3,
  ergebnis: [$Q = 18 thin "mC"$],
  tipp: [Strom ist Ladung pro Zeit. Was musst du also mit der Zeit machen, um die Ladung zu bekommen?],
)[
#if not web [*Aufgabe 9* #linebreak()]
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

#aufgabe(titel: "Ladung eines Kondensators an 30 V", art: "rechnen", quelle: "0.1", herkunft: "original", vorlage: "Übungsblatt B, Aufg. 19", minuten: 3,
  ergebnis: [a) $Q = "1,2" dot.c 10^(-4) thin "As" = 120 thin mu"C"$ b) $I = 0$],
  tipp: [Ein Kondensator speichert Ladung proportional zur Spannung: $Q = C U$.],
)[
#if not web [*Aufgabe 10* #linebreak()]
*Gegeben und Annahmen*

Ein Kondensator mit der Kapazität $C = 4 thin mu"F"$ liegt seit längerem (er ist voll aufgeladen) an der Gleichspannung $U = 30 thin "V"$. Für einen Kondensator gilt $Q = C dot.c U$ (1 F = 1 As/V).

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist die gespeicherte Ladungsmenge?],
[Wie groß ist der Strom in den Zuleitungen?],
)
][
*a) Ladung:* $Q = C U = 4 dot.c 10^(-6) thin "As"\/"V" dot.c 30 thin "V" = "1,2" dot.c 10^(-4) thin "As" = 120 thin mu"C"$.
][
*b) Strom:* Strom ist Ladungsänderung pro Zeit, $i = dif Q\/dif t$. Ist der Kondensator voll, ändert sich $Q$ nicht mehr: $I = 0$. Strom fließt nur beim Laden oder Entladen.
]

#aufgabe(titel: "Kondensator mit 470 µF (Variante)", art: "rechnen", quelle: "0.1", herkunft: "variante", vorlage: "Übungsblatt B, Aufg. 19", minuten: 3,
  ergebnis: [$Q = "7,52" thin "mC"$; $I = 0$; nach Verdopplung der Spannung $Q = "15,04" thin "mC"$],
)[
#if not web [*Aufgabe 11* #linebreak()]
*Gegeben und Annahmen*

Ein Elektrolytkondensator mit $C = 470 thin mu"F"$ ist an 16 V Gleichspannung voll aufgeladen. $Q = C U$.

*Gesucht*

#enum(numbering: "a)",
[Gespeicherte Ladung.],
[Strom in den Zuleitungen im geladenen Zustand.],
[Wie ändert sich die Ladung, wenn die Spannung auf 32 V verdoppelt würde (Spannungsfestigkeit vorausgesetzt)?],
)
][
*a) Ladung:* $Q = 470 dot.c 10^(-6) thin "F" dot.c 16 thin "V" = "7,52" dot.c 10^(-3) thin "As" = "7,52" thin "mC"$.
][
*b) Kein Strom:* Im geladenen Zustand ändert sich $Q$ nicht, deshalb $I = dif Q\/dif t = 0$.
][
*c) Proportional:* $Q ~ U$, also doppelte Ladung: 15,04 mC.
]

#aufgabe(titel: "Warum ein Leiter warm wird", art: "verstehen", quelle: "0.2", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 10", minuten: 3)[
#if not web [*Aufgabe 12* #linebreak()]
Warum setzt ein Leiter dem Strom einen Widerstand entgegen? Was entsteht dabei?
][
*Antwort:* Die Elektronen stoßen an die Atome des Gitters („Reibung“). Dabei wird elektrische Energie in Wärme umgewandelt.
][
*Ergänzung aus der früheren Karteikarte:* _Warum hat ein Leiter einen Widerstand, und was entsteht dabei?_

*Antwort:*
- Die Elektronen stoßen auf ihrem Weg ständig an die schwingenden Atome des Gitters.
- Diese „Reibung“ bremst den Strom, und dabei entsteht Wärme.
]

#aufgabe(titel: "Wovon der Widerstand abhängt", art: "verstehen", quelle: "0.2", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 15", minuten: 3)[
#if not web [*Aufgabe 13* #linebreak()]
Nenne vier Größen, von denen der Widerstand eines Leiters abhängt.
][
*Antwort:* Material ($rho$), Länge $l$, Querschnitt $A$ und Temperatur.
][
*Ergänzung aus der früheren Karteikarte:* _Wovon hängt der Widerstand eines Drahtes ab?_

*Antwort:*
$ R = rho l/A $
- Er wächst mit der Länge, sinkt mit dem Querschnitt, hängt vom Material (spezifischer Widerstand $rho$) und von der Temperatur ab.
- Halber Durchmesser gibt ein Viertel der Fläche und damit vierfachen Widerstand.
- Bei Hin- und Rückleiter zählt die Länge doppelt.

*Merksatz:* Lang und dünn bremst; kurz und dick leitet besser.
]

#aufgabe(titel: "AC, DC, PTC und NTC", art: "verstehen", quelle: "0.2", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Fragen 6 und 17", minuten: 4)[
#if not web [*Aufgabe 14* #linebreak()]
Wofür stehen AC, DC, PTC und NTC?
][
*Antwort:* AC = Alternating Current (Wechselstrom), DC = Direct Current (Gleichstrom), PTC = Kaltleiter ($R$ steigt mit $T$), NTC = Heißleiter ($R$ sinkt mit $T$).
][
*Ergänzung aus der früheren Karteikarte:* _Was bedeuten PTC und NTC?_

*Antwort:*
- *PTC (Kaltleiter):* Der Widerstand steigt mit der Temperatur.
- *NTC (Heißleiter):* Der Widerstand sinkt mit der Temperatur.

*Merksatz:* PTC: wärmer → mehr Widerstand; NTC: wärmer → weniger.
]

#aufgabe(titel: "Bester Leiterwerkstoff", art: "verstehen", quelle: "0.2", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 7", minuten: 3)[
#if not web [*Aufgabe 15* #linebreak()]
Welcher Werkstoff leitet am besten: Eisen, Silber, Kupfer oder Gold?
][
*Antwort:* Silber, vor Kupfer, Gold und Eisen.
]

#aufgabe(titel: "Kennlinie zum 2-Ω-Widerstand", art: "verstehen", quelle: "0.2", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 11", minuten: 3,
  tipp: [Lies auf jeder Geraden einen Punkt ab und bilde $R = U\/I$.],
)[
#if not web [*Aufgabe 16* #linebreak()]
Welche der folgenden Kennlinien A) bis D) gehört zu dem Bauelement mit einem Widerstandswert von 2 Ω? Begründe mit einem abgelesenen Punkt.

#image("abbildungen/fk-kennlinien-a-d.svg", width: 70%)
][
*Ablesen und rechnen:* Für eine Ursprungsgerade gilt überall $R = U\/I$. A) geht durch (2 V; 4 A): $R = "0,5" thin Omega$. B) durch (4 V; 4 A): $R = 1 thin Omega$. C) durch (6 V; 3 A): $R = 2 thin Omega$. D) durch (5 V; 1,5 A): $R approx "3,3" thin Omega$.
][
*Antwort:* Kennlinie *C*. Merke: Im $I$-$U$-Diagramm ist die Steigung $I\/U = 1\/R$; je flacher die Gerade, desto größer der Widerstand. Typische Verwechslung: die steilste Gerade für den größten Widerstand halten.
]

#aufgabe(titel: "Halber Drahtdurchmesser", art: "verstehen", quelle: "0.2", herkunft: "eigen", minuten: 2,
  tipp: [Schreib $R = rho l\/A$ auf und überleg, was mit $A$ passiert, wenn $d$ halb so groß wird.],
)[
#if not web [*Aufgabe 17* #linebreak()]
Ein Kupferdraht wird durch einen Draht mit halbem Durchmesser ersetzt, Länge und Material bleiben gleich. Wie ändert sich sein Widerstand? Begründe deine Antwort.
][
*Antwort:* Er vervierfacht sich.

*Begründung:* Halber Durchmesser gibt ein Viertel des Querschnitts ($A = pi\/4 d^2$). Wegen $R = rho l\/A$ wird der Widerstand viermal so groß.
][
*Typische Verwechslung:*
- Er verdoppelt sich. – Das wäre richtig, wenn der Widerstand vom Durchmesser abhinge. Er hängt aber vom Querschnitt ab, und der geht mit $d^2$.
- Er halbiert sich. – Ein dünnerer Draht hat mehr Widerstand, nicht weniger. Hier ist die Richtung vertauscht.
- Er bleibt gleich, weil das Material gleich bleibt. – Das Material bestimmt nur $rho$. Länge und Querschnitt gehen zusätzlich ein.
]

#aufgabe(titel: "Ohmsches Gesetz im I-U-Diagramm", art: "verstehen", quelle: "0.2", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 18* #linebreak()]
Was sagt das Ohmsche Gesetz, und wie sieht es im I-U-Diagramm aus?
][
*Antwort:*
- $U = R I$.
- Ein linearer Widerstand ist im $I$-$U$-Diagramm eine Gerade durch den Ursprung.
- Die Steigung ist $I\/U = 1\/R$: Je steiler die Gerade, desto kleiner der Widerstand.

*Merksatz:* Im I-U-Diagramm: steiler bedeutet kleineres R.
][
*Ergänzung aus der früheren Quizfrage:* _Im I-U-Diagramm wird eine ohmsche Ursprungsgerade steiler. Wird der Widerstand größer oder kleiner?_

*Antwort:* Er wird kleiner: Die Steigung ist Stromänderung durch Spannungsänderung, also der Leitwert. Der Widerstand ist dessen Kehrwert.
]

#aufgabe(titel: "Längen von Kupfer- und Aluminiumleiter", art: "rechnen", quelle: "0.2", herkunft: "original", vorlage: "Altklausur (Jahr unbekannt 2), F3", minuten: 8,
  ergebnis: [a) $l_"Cu"\/l_"Al" approx "1,56"$ b) $R_1\/R_2 = 9$ (dünnerer zu dickerem Leiter)],
  tipp: [Gleicher Querschnitt und gleicher Widerstand: dann muss $rho l$ gleich sein.],
)[
#if not web [*Aufgabe 19* #linebreak()]
*Gegeben und Annahmen*

$rho_"Cu" = "0,0178" thin Omega thin "mm"^2\/"m"$, $rho_"Al" = "0,0278" thin Omega thin "mm"^2\/"m"$. Der Querschnitt der Drähte ist rund.

*Gesucht*

#enum(numbering: "a)",
[In welchem Verhältnis stehen die Längen zweier gleich dicker Cu- und Al-Leiter, wenn diese den gleichen Widerstand aufweisen?],
[In welchem Verhältnis stehen die Widerstände gleich langer Al-Leiter, deren Durchmesserverhältnis 1 : 3 ist?],
)
][
*a) Ansatz:* $R = rho l\/A$ mit gleichem $A$ und gleichem $R$: $rho_"Cu" l_"Cu" = rho_"Al" l_"Al"$. Wer schlechter leitet, darf nur kürzer sein.
][
*a) Ergebnis:* $l_"Cu"\/l_"Al" = rho_"Al"\/rho_"Cu" = "0,0278"\/"0,0178" approx "1,56"$. Der Kupferdraht darf rund 1,56-mal so lang sein.
][
*b) Durchmesser 1 : 3:* $A ~ d^2$, also $A_1 : A_2 = 1 : 9$. Bei gleicher Länge und gleichem Material ist $R ~ 1\/A$: $R_1 : R_2 = 9 : 1$. Der dünnere Leiter hat den neunfachen Widerstand.
][
*Prüfen:* Typischer Fehler in b): nur mit dem Durchmesserverhältnis (3) rechnen. Der Querschnitt geht mit dem *Quadrat* des Durchmessers.
]

#aufgabe(titel: "Längenverhältnis Eisen gegen Kupfer (Variante)", art: "rechnen", quelle: "0.2", herkunft: "variante", vorlage: "Altklausur (Jahr unbekannt 2), F3", minuten: 6,
  ergebnis: [a) $l_"Cu"\/l_"Fe" approx "5,6"$ b) $R_1\/R_2 = 4$],
)[
#if not web [*Aufgabe 20* #linebreak()]
*Gegeben und Annahmen*

$rho_"Cu" = "0,0178" thin Omega thin "mm"^2\/"m"$, $rho_"Fe" = "0,10" thin Omega thin "mm"^2\/"m"$. Runde Drähte.

*Gesucht*

#enum(numbering: "a)",
[Ein Kupfer- und ein Eisendraht sind gleich dick und haben denselben Widerstand. In welchem Verhältnis stehen ihre Längen $l_"Cu" : l_"Fe"$?],
[Zwei gleich lange Eisendrähte haben das Durchmesserverhältnis $d_1 : d_2 = 1 : 2$. Wie verhalten sich ihre Widerstände?],
)
][
*a) Gleiches $rho l$:* Bei gleichem $A$ und $R$ gilt $rho_"Cu" l_"Cu" = rho_"Fe" l_"Fe"$, also $l_"Cu"\/l_"Fe" = "0,10"\/"0,0178" approx "5,6"$.
][
*b) Quadrat des Durchmessers:* $A_1 : A_2 = 1 : 4$, also $R_1 : R_2 = 4 : 1$.
]

#aufgabe(titel: "Strom durch eine Heizspirale", art: "rechnen", quelle: "0.2", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 13", minuten: 2,
  ergebnis: [$I approx "3,07" thin "A"$],
)[
#if not web [*Aufgabe 21* #linebreak()]
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

#aufgabe(titel: "Strom durch einen Lötkolben (Variante)", art: "rechnen", quelle: "0.2", herkunft: "variante", vorlage: "Fragenkatalog Einstieg GET, Frage 13", minuten: 2,
  ergebnis: [$I = "0,5" thin "A"$, $P = 115 thin "W"$],
)[
#if not web [*Aufgabe 22* #linebreak()]
*Gegeben und Annahmen*

Das Heizelement eines Lötkolbens hat im Betrieb den Widerstand 460 Ω und liegt an 230 V.

*Gesucht*

#enum(numbering: "a)",
[Welcher Strom fließt?],
[Welche Leistung nimmt der Lötkolben auf?],
)
][
*Ohmsches Gesetz:* $I = U\/R = 230 thin "V"\/460 thin Omega = "0,5" thin "A"$.
][
*Leistung:* $P = U I = 230 thin "V" dot.c "0,5" thin "A" = 115 thin "W"$. Kontrolle mit $U^2\/R = 52 thin 900\/460 = 115 thin "W"$.
]

#aufgabe(titel: "Toleranzbereich eines E12-Widerstands", art: "rechnen", quelle: "0.2", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 14", minuten: 3,
  ergebnis: [$"7,38" thin "k"Omega <= R <= "9,02" thin "k"Omega$],
  tipp: [Die E12-Reihe hat eine Fertigungstoleranz von ±10 %. Rechne 10 % vom Nennwert aus.],
)[
#if not web [*Aufgabe 23* #linebreak()]
*Gegeben und Annahmen*

Ein Kohleschichtwiderstand der E12-Reihe hat den Nennwert $R_N = "8,2" thin "k"Omega$. Widerstände der E12-Reihe haben eine Fertigungstoleranz von $plus.minus 10 thin %$.

*Gesucht*

#enum(numbering: "a)",
[Zwischen welchen Widerstandswerten kann der Widerstand aufgrund der Fertigungstoleranz schwanken?],
)
][
*Toleranz verstehen:* Der aufgedruckte Wert ist nur der Sollwert. Die Fertigung darf um einen festen Prozentsatz nach *unten und oben* abweichen. Deshalb rechnest du die Abweichung in Ohm aus und ziehst sie einmal ab und addierst sie einmal.
][
*Abweichung berechnen:* $Delta R = "0,10" dot.c "8,2" thin "k"Omega = "0,82" thin "k"Omega$.
][
*Grenzen bilden:* $R_"min" = "8,2" - "0,82" = "7,38" thin "k"Omega$ und $R_"max" = "8,2" + "0,82" = "9,02" thin "k"Omega$.
][
*Prüfen:* Die Spanne ist symmetrisch um 8,2 kΩ und zusammen 20 % des Nennwerts breit. Typischer Fehler: nur nach oben rechnen oder 0,1 kΩ statt 10 % nehmen.
][
*Ergänzung aus der früheren Quizfrage:* _Ein Widerstand der E12-Reihe hat 8,2 kΩ und ±10 % Toleranz. Zwischen welchen Werten darf er liegen?_

*Antwort:* 7,38 kΩ bis 9,02 kΩ.

*Begründung:* 10 % von 8,2 kΩ sind 0,82 kΩ, nach unten und oben.

*Typische Verwechslung:*
- 8,1 kΩ bis 8,3 kΩ – Hier wurde mit 0,1 kΩ statt mit 10 % gerechnet.
- 7,2 kΩ bis 9,2 kΩ – Das wäre ±1 kΩ, also gut 12 %.
- 8,2 kΩ bis 9,02 kΩ – Die Toleranz gilt in beide Richtungen, nicht nur nach oben.
]

#aufgabe(titel: "Toleranzbereich bei 4,7 kΩ und 5 % (Variante)", art: "rechnen", quelle: "0.2", herkunft: "variante", vorlage: "Fragenkatalog Einstieg GET, Frage 14", minuten: 3,
  ergebnis: [$"4,465" thin "k"Omega <= R <= "4,935" thin "k"Omega$],
)[
#if not web [*Aufgabe 24* #linebreak()]
*Gegeben und Annahmen*

Ein Metallschichtwiderstand der E24-Reihe hat den Nennwert $R_N = "4,7" thin "k"Omega$ und die Toleranz $plus.minus 5 thin %$.

*Gesucht*

#enum(numbering: "a)",
[Kleinster und größter zulässiger Widerstandswert.],
[Liegt ein gemessener Wert von 4,9 kΩ noch in der Toleranz?],
)
][
*Abweichung in Ohm:* $Delta R = "0,05" dot.c "4,7" thin "k"Omega = "0,235" thin "k"Omega$. Die Toleranz gilt in beide Richtungen.
][
*Grenzen:* $R_"min" = "4,7" - "0,235" = "4,465" thin "k"Omega$, $R_"max" = "4,7" + "0,235" = "4,935" thin "k"Omega$.
][
*Messwert einordnen:* 4,9 kΩ liegt unter 4,935 kΩ, also *innerhalb* der Toleranz (Abweichung $+"4,3" thin %$).
]

#aufgabe(titel: "Widerstand eines 350-m-Kupferleiters", art: "rechnen", quelle: "0.2", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 16", minuten: 3,
  ergebnis: [$R approx "1,04" thin Omega$],
  tipp: [$R = rho l\/A$; die Einheit $Omega thin "mm"^2\/"m"$ passt direkt zu Länge in m und Fläche in mm².],
)[
#if not web [*Aufgabe 25* #linebreak()]
*Gegeben und Annahmen*

Kupferleiter, Länge $l = 350 thin "m"$, Querschnitt $A = 6 thin "mm"^2$. Spezifischer Widerstand $rho_"Cu" = "0,0178" thin Omega thin "mm"^2\/"m"$ (Temperatur 20 °C).

*Gesucht*

#enum(numbering: "a)",
[Berechne den Widerstand des Leiters.],
)
][
*Formel wählen:* Ein gleichförmiger Draht bremst den Strom umso mehr, je länger er ist, und umso weniger, je dicker er ist: $R = rho dot.c l\/A$.
][
*Einsetzen:* $R = "0,0178" thin Omega thin "mm"^2\/"m" dot.c 350 thin "m" \/ (6 thin "mm"^2) = "1,038" thin Omega approx "1,04" thin Omega$.
][
*Einheiten prüfen:* m kürzt sich mit 1/m, mm² mit 1/mm², es bleibt Ω. Ein gutes Ohm für 350 m dicken Kupferdraht ist plausibel.
]

#aufgabe(titel: "Widerstand einer Kupferleitung hin und zurück", art: "rechnen", quelle: "0.2", herkunft: "variante", vorlage: "Fragenkatalog Einstieg GET, Frage 16", minuten: 12,
  ergebnis: [$l = 50 thin "m"$, $R approx "0,60" thin Omega$],
  tipp: [Der Strom muss vom Netz zum Gerät *und wieder zurück*. Wie lang ist dann der gesamte Draht?],
)[
#if not web [*Aufgabe 26* #linebreak()]
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

#aufgabe(titel: "Draht mit gegebenem Durchmesser", art: "rechnen", quelle: "0.2", herkunft: "variante", vorlage: "Fragenkatalog Einstieg GET, Frage 16", minuten: 12,
  ergebnis: [$A approx "0,196" thin "mm"^2$, $R approx "1,81" thin Omega$],
  tipp: [Die Formel braucht die *Querschnittsfläche*, gegeben ist aber der Durchmesser.],
)[
#if not web [*Aufgabe 27* #linebreak()]
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

#aufgabe(titel: "Dicke der Kohleschicht", art: "rechnen", quelle: "0.2", herkunft: "original", vorlage: "Übung GET, Aufg. 1a", minuten: 8)[
#if not web [*Aufgabe 28* #linebreak()]
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
*Lösung:* $R = rho l\/A$ nach $A$ umstellen: $A = (rho l)/R = (60 thin Omega thin "mm"^2\/"m" dot.c "0,095" thin "m")/(80 thin 000 thin Omega) approx "7,13" dot.c 10^(-5) thin "mm"^2$
][
*Lösung:* $d = A\/b = "7,13" dot.c 10^(-5) thin "mm"^2 \/ "3,5" thin "mm" approx "2,04" dot.c 10^(-5) thin "mm"$
][
*Ergebnis:* $d approx 20 thin "nm"$, wie auf dem Übungsblatt. *Prüfung:* mm² geteilt durch mm ergibt mm; eine hauchdünne Schicht ist für 80 kΩ plausibel.
#note("Von dir markiert", [„In Prüfung Einheiten richtig mitführen!!“ (Ü-N, PDF-S. 4). Dort steht im Zähler einmal 3,5 mm. Richtig ist die *Länge 95 mm*; 3,5 mm ist die Breite im Nenner. DC, PDF-S. 3, setzt richtig ein.], fill: sand)
#src([Ü 1a; Ü-N, PDF-S. 4; DC, PDF-S. 3.])
]

#aufgabe(titel: "Kohleschicht für 50 kΩ (Variante)", art: "rechnen", quelle: "0.2", herkunft: "variante", vorlage: "Übung GET, Aufg. 1a", minuten: 8,
  ergebnis: [$d = 48 thin "nm"$],
  tipp: [Der stromdurchflossene Querschnitt des Kohlebands ist Breite mal Schichtdicke.],
)[
#if not web [*Aufgabe 29* #linebreak()]
*Gegeben und Annahmen*

Auf einem Keramikkörper ist eine Kohleschicht zu einer Wendel geschliffen. Länge der Wendel $l = 120 thin "mm"$, Breite $b = 2 thin "mm"$, $rho_"Kohle" = 40 thin Omega thin "mm"^2\/"m"$.

*Gesucht*

#enum(numbering: "a)",
[Wie dick muss die Kohleschicht sein, damit der Widerstand 50 kΩ beträgt?],
)
][
*Modell:* Der Strom fließt längs der Wendel durch ein dünnes Band. Länge $l$, Querschnitt $A = b dot.c d$. Aus $R = rho l\/(b d)$ folgt $d = rho l\/(b R)$.
][
*In Grundeinheiten:* $rho = 40 thin Omega thin "mm"^2\/"m" = 40 dot.c 10^(-6) thin Omega "m"$, $l = "0,12" thin "m"$, $b = "0,002" thin "m"$.
][
*Einsetzen:* $d = (40 dot.c 10^(-6) dot.c "0,12")\/("0,002" dot.c 50 thin 000) thin "m" = "4,8" dot.c 10^(-8) thin "m" = 48 thin "nm"$.
][
*Prüfen:* Einheit $Omega "m" dot.c "m" \/ ("m" dot.c Omega) = "m"$. Eine Schicht von einigen zehn Nanometern ist für Schichtwiderstände typisch (Original: 20 nm).
]

#aufgabe(titel: "Durchmesser von Aluminium- und Kupferleiter (Variante)", art: "rechnen", quelle: "0.2", herkunft: "variante", vorlage: "Übung GET, Aufg. 7", minuten: 6,
  ergebnis: [a) $d_"Al"\/d_"Cu" approx "1,25"$ b) $R_1\/R_2 = 1\/9$],
  tipp: [Erst das Querschnittsverhältnis, dann die Wurzel daraus, weil $A ~ d^2$.],
)[
#if not web [*Aufgabe 30* #linebreak()]
*Gegeben und Annahmen*

$rho_"Al" = "0,0278" thin Omega thin "mm"^2\/"m"$, $rho_"Cu" = "0,0178" thin Omega thin "mm"^2\/"m"$. Alle Leiter sind rund.

*Gesucht*

#enum(numbering: "a)",
[Ein Aluminium- und ein Kupferleiter sind gleich lang und haben den gleichen Widerstand. In welchem Verhältnis stehen ihre *Durchmesser*?],
[Zwei gleich lange Kupferleiter haben das Durchmesserverhältnis $d_1 : d_2 = 3 : 1$. In welchem Verhältnis stehen ihre Widerstände $R_1 : R_2$?],
)
][
*Gleicher Widerstand bei gleicher Länge:* $rho_"Al" l\/A_"Al" = rho_"Cu" l\/A_"Cu"$, also $A_"Al"\/A_"Cu" = rho_"Al"\/rho_"Cu" = "1,562"$. Der schlechter leitende Stoff braucht mehr Querschnitt.
][
*Vom Querschnitt zum Durchmesser:* Wegen $A = pi d^2\/4$ ist $d_"Al"\/d_"Cu" = sqrt(A_"Al"\/A_"Cu") = sqrt("1,562") approx "1,25"$. Genau diese 1,25 steht als Lösung in Übung Aufg. 7 a; dort ist aber das Querschnittsverhältnis 1,56 gefragt.
][
*Durchmesser 3 : 1:* Der Querschnitt steigt mit dem Quadrat: $A_1\/A_2 = 9$. Da $R ~ 1\/A$, folgt $R_1\/R_2 = 1\/9$: Der dreifach dickere Leiter hat ein Neuntel des Widerstands.
]

#aufgabe(titel: "Aluminium gegen Kupfer", art: "rechnen", quelle: "0.2", herkunft: "original", vorlage: "Übung GET, Aufg. 7 (= Übungsblatt B, Aufg. 14; Altklausur (Jahr unbekannt), S. 1)", minuten: 8)[
#if not web [*Aufgabe 31* #linebreak()]
*Aluminium und Kupfer, Ü 7 (= Blatt B 14):*

*Gegeben und Annahmen*

Gleich lange Aluminium- und Kupferleiter mit gleichem Widerstand. $rho_"Al"="0,0278"$, $rho_"Cu"="0,0178" thin Omega thin "mm"^2/"m"$. Zweiter Fall: zwei gleich lange Kupferleiter mit Durchmesserverhältnis 2 : 1.

*Gesucht*

#enum(numbering: "a)",
[Bestimme das Querschnittsverhältnis Aluminium zu Kupfer im ersten Fall.],
[Bestimme das Widerstandsverhältnis im zweiten Fall.],
)
][
*Lösung:* a) Gleiche Länge, gleicher Widerstand: $rho_"Al" l\/A_"Al" = rho_"Cu" l\/A_"Cu"$, also $A_"Al"\/A_"Cu" = rho_"Al"\/rho_"Cu" = "0,0278"\/"0,0178" approx "1,56"$. Das Verhältnis der Durchmesser ist $sqrt("1,56") approx "1,25"$.\
b) Durchmesser 2 : 1 → Querschnitt 4 : 1 → $R_1\/R_2 = 1\/4 = "0,25"$: Der dickere Leiter hat ein Viertel des Widerstands. Deine Lösung R S. 8 kommt ebenfalls auf 1,56 und 1/4.
#note("Widerspruch in den Unterlagen", [Ü 7a nennt als Lösung 1,25. Das ist das Verhältnis der *Durchmesser*. Das Verhältnis der *Querschnitte* ist 1,56. Schreib in der Klausur beide Zahlen mit Begründung hin.], fill: sand)
_Eigene Ergänzung, WI-Sicht:_ Aluminium braucht rund 56 % mehr Querschnitt, ist aber leichter und billiger als Kupfer; deshalb bestehen Freileitungen oft aus Aluminium.
]

#aufgabe(titel: "Energie einer Heizung abschätzen", art: "verstehen", quelle: "0.3", herkunft: "eigen", minuten: 2,
  tipp: [Erst die Leistung $P = U I$, dann mal Zeit.],
)[
#if not web [*Aufgabe 32* #linebreak()]
Eine Heizung zieht an 230 V einen Strom von 8,7 A und läuft 240 Stunden im Monat. Ungefähr wie viel Energie verbraucht sie? Begründe deine Antwort.
][
*Antwort:* 480 kWh.

*Begründung:* $P = U I approx 2 thin "kW"$, mal 240 h ergibt rund 480 kWh.
][
*Typische Verwechslung:*
- 2 kWh – Das ist die Leistung von rund 2 kW mal einer Stunde. Die Betriebszeit fehlt.
- 2088 kWh – Hier wurde der Strom mit der Zeit multipliziert (8,7 · 240). Das ist eine Ladung in Ah, keine Energie.
- 480 kW – Die Zahl stimmt, die Einheit nicht. kW ist eine Leistung; Energie ist Leistung mal Zeit, also kWh.
]

#aufgabe(titel: "Welche Leistungsformel wann", art: "verstehen", quelle: "0.3", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 33* #linebreak()]
Welche Form der Leistungsformel nehme ich wann?
][
*Antwort:*
$ P = U I = I^2 R = U^2/R $
- Ist der Strom bekannt (typisch in Reihenschaltungen), nimmt man $I^2 R$.
- Ist die Spannung bekannt (typisch parallel), $U^2\/R$.

*Merksatz:* Bekanntes I: I²R; bekanntes U: U²/R.
]

#aufgabe(titel: "Leistung, Energie und Stromkosten", art: "verstehen", quelle: "0.3", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 34* #linebreak()]
Wie hängen Leistung, Energie und Stromkosten zusammen?
][
*Antwort:*
- Leistung ist Energie pro Zeit.
- $W = P dot t$, z. B. kW · h = kWh.
- Kosten = Energie × Preis pro kWh.

*Merksatz:* Leistung ist Tempo, Energie ist angesammelte Menge.
][
*Bild:* Leistung ist die Geschwindigkeit, Energie die gefahrene Strecke, die Kosten der Spritverbrauch.
]

#aufgabe(titel: "Widerstand einer Signallampe", art: "rechnen", quelle: "0.3", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 12", minuten: 3,
  ergebnis: [$R = 12 thin Omega$],
  tipp: [Leistung und Strom sind gegeben. Welche Leistungsformel enthält nur $P$, $I$ und $R$?],
)[
#if not web [*Aufgabe 35* #linebreak()]
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

#aufgabe(titel: "Widerstand einer Fahrradlampe (Variante)", art: "rechnen", quelle: "0.3", herkunft: "variante", vorlage: "Fragenkatalog Einstieg GET, Frage 12", minuten: 3,
  ergebnis: [$U = 6 thin "V"$, $R = 15 thin Omega$],
)[
#if not web [*Aufgabe 36* #linebreak()]
*Gegeben und Annahmen*

Eine Fahrradlampe hat die Nenndaten 2,4 W und 0,4 A.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist ihr Betriebswiderstand?],
[Für welche Spannung ist sie ausgelegt?],
)
][
*Weg über $P = I^2 R$:* Strom und Leistung sind gegeben, also $R = P\/I^2 = "2,4" thin "W"\/("0,4" thin "A")^2 = 15 thin Omega$.
][
*Spannung:* $U = P\/I = 6 thin "V"$. Kontrolle: $U\/I = 6\/"0,4" = 15 thin Omega$. Der Wert gilt nur im heißen Betrieb; kalt ist der Wendelwiderstand kleiner.
]

#aufgabe(titel: "Betriebsspannung eines Wärmegeräts", art: "rechnen", quelle: "0.3", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 18", minuten: 2,
  ergebnis: [$U approx "666,7" thin "V"$],
)[
#if not web [*Aufgabe 37* #linebreak()]
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

#aufgabe(titel: "Spannung an einem Heizgerät mit 2,2 kW (Variante)", art: "rechnen", quelle: "0.3", herkunft: "variante", vorlage: "Fragenkatalog Einstieg GET, Frage 18", minuten: 2,
  ergebnis: [$U approx 229 thin "V"$],
)[
#if not web [*Aufgabe 38* #linebreak()]
*Gegeben und Annahmen*

An einem elektrischen Heizgerät mit $P = "2,2" thin "kW"$ wird der Strom $I = "9,6" thin "A"$ gemessen.

*Gesucht*

#enum(numbering: "a)",
[Mit welcher Spannung wird das Gerät betrieben?],
)
][
*Umstellen:* $P = U I$ ergibt $U = P\/I$.
][
*Einsetzen:* $U = 2200 thin "W"\/"9,6" thin "A" approx 229 thin "V"$, also das 230-V-Netz. Einheit: W/A = V.
]

#aufgabe(titel: "Monatliche Heizkosten", art: "rechnen", quelle: "0.3", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 19", minuten: 5,
  ergebnis: [$P approx 2 thin "kW"$, $W approx 480 thin "kWh"$, Kosten $approx "148,87" thin "€"$],
  tipp: [Erst Leistung, dann Energie (Leistung mal Betriebszeit), dann Preis mal Energie.],
)[
#if not web [*Aufgabe 39* #linebreak()]
*Gegeben und Annahmen*

Eine elektrische Heizung nimmt an $U = 230 thin "V"$ den Strom $I = "8,7" thin "A"$ auf. Sie ist täglich 8 Stunden in Betrieb, 30 Tage im Monat. Arbeitspreis 0,31 €/kWh.

*Gesucht*

#enum(numbering: "a)",
[Berechne das monatliche Verbrauchsentgelt.],
)
][
*Leistung:* $P = U I = 230 thin "V" dot.c "8,7" thin "A" = 2001 thin "W" approx "2,0" thin "kW"$. Bezahlt wird aber nicht die Leistung, sondern die Energie.
][
*Energie im Monat:* Betriebszeit $t = 8 thin "h" dot.c 30 = 240 thin "h"$. $W = P t = "2,001" thin "kW" dot.c 240 thin "h" = "480,24" thin "kWh"$.
][
*Kosten:* $K = "480,24" thin "kWh" dot.c "0,31" thin "€"\/"kWh" approx "148,87" thin "€"$ (pro Tag $16 thin "kWh" dot.c "0,31" = "4,96" thin "€"$).
][
*Prüfen:* kW mal h ergibt kWh, kWh mal €/kWh ergibt €. Typischer Fehler: $I dot.c t$ rechnen, das ist eine Ladung (Ah), keine Energie.
]

#aufgabe(titel: "Monatliche Kosten eines Klimageräts (Variante)", art: "rechnen", quelle: "0.3", herkunft: "variante", vorlage: "Fragenkatalog Einstieg GET, Frage 19", minuten: 5,
  ergebnis: [$P = 1035 thin "W"$, $W = "186,3" thin "kWh"$, Kosten $approx "65,21" thin "€"$],
)[
#if not web [*Aufgabe 40* #linebreak()]
*Gegeben und Annahmen*

Ein Klimagerät nimmt an 230 V einen Strom von 4,5 A auf. Es läuft täglich 6 Stunden, 30 Tage lang. Arbeitspreis 0,35 €/kWh.

*Gesucht*

#enum(numbering: "a)",
[Leistungsaufnahme.],
[Monatlicher Energiebedarf.],
[Monatliche Stromkosten.],
)
][
*Leistung:* $P = U I = 230 thin "V" dot.c "4,5" thin "A" = 1035 thin "W" = "1,035" thin "kW"$.
][
*Energie:* $W = P t = "1,035" thin "kW" dot.c (6 dot.c 30) thin "h" = "1,035" dot.c 180 thin "kWh" = "186,3" thin "kWh"$.
][
*Kosten:* $K = "186,3" thin "kWh" dot.c "0,35" thin "€"\/"kWh" approx "65,21" thin "€"$. Bezahlt wird die Energie, darum muss die Zeit hinein.
]

#aufgabe(titel: "Höchstspannung bei 1/8 W Belastbarkeit", art: "rechnen", quelle: "0.3", herkunft: "original", vorlage: "Übungsblatt A, Aufg. 1", minuten: 3,
  ergebnis: [$U_"max" approx "24,2" thin "V"$],
  tipp: [Die Belastbarkeit ist eine Grenze für die Leistung. Welche Leistungsformel enthält $U$ und $R$?],
)[
#if not web [*Aufgabe 41* #linebreak()]
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

#aufgabe(titel: "Höchstspannung bei 1/4 W Belastbarkeit (Variante)", art: "rechnen", quelle: "0.3", herkunft: "variante", vorlage: "Übungsblatt A, Aufg. 1", minuten: 3,
  ergebnis: [$U_"max" approx "15,8" thin "V"$, $I_"max" approx "15,8" thin "mA"$],
)[
#if not web [*Aufgabe 42* #linebreak()]
*Gegeben und Annahmen*

Widerstand $R = 1 thin "k"Omega$, Dauerbelastbarkeit $P_"max" = 1\/4 thin "W"$.

*Gesucht*

#enum(numbering: "a)",
[An welcher Spannung darf der Widerstand höchstens betrieben werden?],
[Welcher Strom fließt dann?],
)
][
*Passende Leistungsform:* Gegeben sind $R$ und $P$, gesucht $U$: $P = U^2\/R$, also $U = sqrt(P R)$.
][
*Einsetzen:* $U_"max" = sqrt("0,25" thin "W" dot.c 1000 thin Omega) = sqrt(250) thin "V" approx "15,8" thin "V"$; $I = U\/R approx "15,8" thin "mA"$.
][
*Prüfen:* $U I = "15,8" thin "V" dot.c "0,0158" thin "A" approx "0,25" thin "W"$. Bei höherer Spannung wird der Widerstand thermisch überlastet.
]

#aufgabe(titel: "Höchstspannung und P-U-Diagramm eines Schichtwiderstands", art: "rechnen", quelle: "0.3", herkunft: "original", vorlage: "Übungsblatt A, Aufg. 5 (= Altklausur (Jahr unbekannt), S. 8)", minuten: 15, platz: 18,
  ergebnis: [a) $U = 30 thin "V"$; b) Schnittpunkt bei 30 V / 16,7 mA; c) $P$ = 0 / 55,6 / 222 / 500 / 889 mW bei 0 / 10 / 20 / 30 / 40 V],
  tipp: [Leistungshyperbel: $I = P\/U$ mit festem $P$. Widerstandsgerade: $I = U\/R$.],
)[
#if not web [*Aufgabe 43* #linebreak()]
*Gegeben und Annahmen*

Ein Schichtwiderstand hat die Daten 1,8 kΩ / 0,5 W.

*Gesucht*

#enum(numbering: "a)",
[Berechne seine höchstzulässige Spannung $U$.],
[Kontrolliere das Rechenergebnis grafisch durch Aufzeichnen der Leistungshyperbel für 0,5 W und der $I$-$U$-Kennlinie für den Widerstand 1,8 kΩ im Bereich $0 < U < 80 thin "V"$.],
[Berechne und zeichne das $P$-$U$-Diagramm für den Widerstand 1,8 kΩ im Bereich $0 < U < 40 thin "V"$ und trage die Nennleistungslinie 0,5 W ein.],
)
][
*a) Höchstspannung:* Aus $P = U^2\/R$ folgt $U = sqrt(P R) = sqrt("0,5" thin "W" dot.c 1800 thin Omega) = sqrt(900) thin "V" = 30 thin "V"$.
][
*b) Leistungshyperbel:* Alle Punkte mit $U I = "0,5" thin "W"$, also $I = "0,5" thin "W"\/U$: z. B. 10 V → 50 mA, 20 V → 25 mA, 30 V → 16,7 mA, 50 V → 10 mA, 80 V → 6,25 mA. Sie ist die Grenze: oberhalb wird mehr als 0,5 W umgesetzt.
][
*b) Widerstandsgerade und Schnitt:* $I = U\/1800 thin Omega$ ist eine Ursprungsgerade, z. B. 36 V → 20 mA, 72 V → 40 mA. Sie schneidet die Hyperbel bei $U = 30 thin "V"$, $I approx "16,7" thin "mA"$. Das bestätigt a): Bis 30 V liegt der Betrieb unter der Hyperbel.
][
*c) Wertetabelle:* $P = U^2\/R$: 0 V → 0 mW; 10 V → 55,6 mW; 20 V → 222 mW; 30 V → 500 mW; 40 V → 889 mW. Die Kurve ist eine nach oben geöffnete Parabel, weil $P ~ U^2$.
][
*c) Nennleistungslinie:* Die waagrechte Linie bei 500 mW schneidet die Parabel bei 30 V, wieder dieselbe Grenze. Bei 40 V wäre der Widerstand mit 889 mW fast doppelt überlastet.
]

#aufgabe(titel: "Schichtwiderstand 400 Ω / 1 W (Variante)", art: "rechnen", quelle: "0.3", herkunft: "variante", vorlage: "Übungsblatt A, Aufg. 5 (= Altklausur (Jahr unbekannt), S. 8)", minuten: 15, platz: 18,
  ergebnis: [a) $U = 20 thin "V"$, $I = 50 thin "mA"$; c) $P$ = 0 / 0,25 / 1 / 2,25 / 4 / 6,25 W bei 0 / 10 / 20 / 30 / 40 / 50 V],
)[
#if not web [*Aufgabe 44* #linebreak()]
*Gegeben und Annahmen*

Ein Schichtwiderstand hat die Daten 400 Ω / 1 W (so wurde die Aufgabe in der Übung abgewandelt).

*Gesucht*

#enum(numbering: "a)",
[Höchstzulässige Spannung und zugehöriger Strom.],
[Zeichne die Leistungshyperbel für 1 W und die $I$-$U$-Kennlinie des Widerstands im Bereich $0 < U < 100 thin "V"$ und kontrolliere a).],
[Berechne und zeichne das $P$-$U$-Diagramm im Bereich $0 < U < 50 thin "V"$ mit der Nennleistungslinie 1 W.],
)
][
*a) Grenze:* $U = sqrt(P R) = sqrt(1 thin "W" dot.c 400 thin Omega) = 20 thin "V"$, $I = U\/R = 50 thin "mA"$.
][
*b) Zwei Kurven:* Hyperbel $I = 1 thin "W"\/U$: 10 V → 100 mA, 20 V → 50 mA, 40 V → 25 mA, 100 V → 10 mA. Gerade $I = U\/400 thin Omega$: 20 V → 50 mA, 100 V → 250 mA. Schnitt bei (20 V; 50 mA), wie in a).
][
*c) Parabel:* $P = U^2\/400 thin Omega$: 0; 0,25; 1; 2,25; 4; 6,25 W bei 0 bis 50 V in 10-V-Schritten. Die Linie bei 1 W schneidet bei 20 V.
]

#aufgabe(titel: "Leistung bei 10 % mehr Spannung", art: "rechnen", quelle: "0.3", herkunft: "original", vorlage: "Übungsblatt A, Aufg. 6", minuten: 4,
  ergebnis: [Die Leistung steigt um 21 %.],
  tipp: [Wie hängt $P$ von $U$ ab, wenn $R$ konstant bleibt?],
)[
#if not web [*Aufgabe 45* #linebreak()]
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

#aufgabe(titel: "Leistung bei 5 % weniger Spannung (Variante)", art: "rechnen", quelle: "0.3", herkunft: "variante", vorlage: "Übungsblatt A, Aufg. 6", minuten: 4,
  ergebnis: [$P' = "0,9025" P$, also rund $-"9,75" thin %$],
)[
#if not web [*Aufgabe 46* #linebreak()]
*Gegeben und Annahmen*

Ein Heizwiderstand mit konstantem Widerstand wird statt an Nennspannung an einer um 5 % niedrigeren Spannung betrieben.

*Gesucht*

#enum(numbering: "a)",
[Um wie viel Prozent ändert sich die Leistung?],
[Warum ändert sich die Leistung prozentual stärker als die Spannung?],
)
][
*Ansatz:* Bei konstantem $R$ gilt $P = U^2\/R$. Mit $U' = "0,95" U$ wird $P' = ("0,95" U)^2\/R = "0,9025" P$.
][
*Ergebnis:* Die Leistung sinkt um $1 - "0,9025" = "0,0975"$, also um rund 9,75 %.
][
*Warum stärker:* Spannung und Strom sinken *beide* um 5 %, und $P = U I$ ist das Produkt. Deshalb fast doppelt so viel Prozent.
]

#aufgabe(titel: "Aufheizzeit eines Wasserkochers", art: "rechnen", quelle: "0.3", herkunft: "original", vorlage: "Übungsblatt A, Aufg. 7", minuten: 8)[
#if not web [*Aufgabe 47* #linebreak()]
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
*Nötige Wärme:* $Q = m c Delta T = 1 thin "kg" dot.c "4,19" thin "kJ/(kg K)" dot.c 85 thin "K" approx "356,2" thin "kJ"$
][
*Nutzleistung:* $P_"Nutz" = eta dot.c P = "0,85" dot.c 1500 thin "W" = 1275 thin "W"$
][
*Zeit:* $t = Q\/P_"Nutz" = 356 thin 150 thin "Ws" \/ 1275 thin "W" approx 279 thin "s"$
][
*Ergebnis:* $t approx 280 thin "s" approx "4,7" thin "min"$ (wie R S. 3, dort über $Q\/eta$ gerechnet). *Prüfung:* Ohne Verluste wären es rund 237 s; mit Verlusten dauert es länger.
]

#aufgabe(titel: "Aufheizzeit für 1,5 Liter (Variante)", art: "rechnen", quelle: "0.3", herkunft: "variante", vorlage: "Übungsblatt A, Aufg. 7", minuten: 8,
  ergebnis: [$Q = "502,8" thin "kJ"$, $W_"el" approx "628,5" thin "kJ"$, $t approx 314 thin "s" approx "5,2" thin "min"$],
)[
#if not web [*Aufgabe 48* #linebreak()]
*Gegeben und Annahmen*

Ein Wasserkocher hat die Nenndaten 230 V / 2000 W und arbeitet mit dem Wirkungsgrad 0,80. Es sollen 1,5 Liter Wasser ($m = "1,5" thin "kg"$) von 20 °C auf 100 °C erwärmt werden. $c_"Wasser" = "4,19" thin "kJ"\/("kg" dot.c "K")$, 1 J = 1 Ws.

*Gesucht*

#enum(numbering: "a)",
[Wie lange dauert das Erwärmen?],
)
][
*Nutzwärme:* $Q = m c Delta vartheta = "1,5" thin "kg" dot.c "4,19" thin "kJ"\/("kg K") dot.c 80 thin "K" = "502,8" thin "kJ"$.
][
*Elektrische Energie:* Nur 80 % kommen im Wasser an: $W_"el" = Q\/eta = "502,8"\/"0,80" thin "kJ" = "628,5" thin "kJ"$.
][
*Zeit:* $t = W_"el"\/P = 628 thin 500 thin "Ws"\/2000 thin "W" approx 314 thin "s" approx "5,2" thin "min"$.
][
*Prüfen:* Mehr Wasser und schlechterer Wirkungsgrad verlängern die Zeit gegenüber dem Original (4,7 min) trotz höherer Leistung leicht. Plausibel.
]

#aufgabe(titel: "Stand-by-Verbrauch eines Fernsehers", art: "rechnen", quelle: "0.3", herkunft: "original", vorlage: "Übungsblatt B, Aufg. 16", minuten: 8,
  ergebnis: [a) 10,8 kWh b) 9 kWh c) 37,5 %],
  tipp: [Energie ist Leistung mal Zeit. Rechne die Zeit pro Monat zuerst in Stunden aus.],
)[
#if not web [*Aufgabe 49* #linebreak()]
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

#aufgabe(titel: "Stand-by-Verbrauch eines Monitors (Variante)", art: "rechnen", quelle: "0.3", herkunft: "variante", vorlage: "Übungsblatt B, Aufg. 16", minuten: 6,
  ergebnis: [a) 7,2 kWh b) 0,96 kWh c) 10 %],
)[
#if not web [*Aufgabe 50* #linebreak()]
*Gegeben und Annahmen*

Ein Monitor nimmt im Betrieb 30 W und im Stand-by 2 W auf. Er läuft täglich 8 Stunden und steht 16 Stunden im Stand-by. Monat = 30 Tage.

*Gesucht*

#enum(numbering: "a)",
[Monatlicher Energiebedarf im Betrieb.],
[Monatlicher Energiebedarf im Stand-by.],
[Zu wie viel Prozent wäre ein 400-MW-Kraftwerk ausgelastet, um den Stand-by von 20 Millionen Monitoren zu versorgen?],
)
][
*a) Betrieb:* $W = 30 thin "W" dot.c 8 thin "h" dot.c 30 = 7200 thin "Wh" = "7,2" thin "kWh"$.
][
*b) Stand-by:* $W = 2 thin "W" dot.c 16 thin "h" dot.c 30 = 960 thin "Wh" = "0,96" thin "kWh"$.
][
*c) Leistung vergleichen, nicht Energie:* Das Kraftwerk liefert eine Leistung. Gleichzeitiger Stand-by-Bedarf $P = 2 thin "W" dot.c 20 dot.c 10^6 = 40 thin "MW"$, Anteil $40\/400 = 10 thin %$.
]

#aufgabe(titel: "Stromaufnahme eines Elektromotors", art: "rechnen", quelle: "0.3", herkunft: "original", vorlage: "Übungsblatt B, Aufg. 18", minuten: 4,
  ergebnis: [$P_"el" approx "8,33" thin "kW"$, $I approx "18,9" thin "A"$],
  tipp: [Die 6,5 kW sind die *abgegebene* Leistung an der Welle. Aufgenommen wird mehr.],
)[
#if not web [*Aufgabe 51* #linebreak()]
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

#aufgabe(titel: "Stromaufnahme einer Pumpe (Variante)", art: "rechnen", quelle: "0.3", herkunft: "variante", vorlage: "Übungsblatt B, Aufg. 18", minuten: 4,
  ergebnis: [$P_"zu" approx 2588 thin "W"$, $I approx "6,47" thin "A"$],
)[
#if not web [*Aufgabe 52* #linebreak()]
*Gegeben und Annahmen*

Ein Pumpenmotor gibt an der Welle 2,2 kW ab, Wirkungsgrad 85 %. Er liegt an 400 V Gleichspannung.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist die Stromaufnahme?],
)
][
*Zugeführte Leistung:* Die Wellenleistung ist die *abgegebene* Leistung. $P_"zu" = P_"ab"\/eta = 2200\/"0,85" approx 2588 thin "W"$.
][
*Strom:* $I = P_"zu"\/U = 2588 thin "W"\/400 thin "V" approx "6,47" thin "A"$. Typischer Fehler: mit 2,2 kW rechnen, das ergäbe 5,5 A und unterschlüge die Verluste.
]

#aufgabe(titel: "Größerer Widerstand in Reihe", art: "verstehen", quelle: "0.4", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 21", minuten: 3)[
#if not web [*Aufgabe 53* #linebreak()]
In einer Reihenschaltung wird ein Widerstand vergrößert. Was passiert mit Strom, Leistung und Belastung der Quelle?
][
*Antwort:* Strom sinkt, Leistung sinkt, die Quelle wird weniger belastet.
][
*Ergänzung aus der früheren Karteikarte:* _Was passiert, wenn man in einer Reihenschaltung einen Widerstand vergrößert?_

*Antwort:*
- $R_"ges"$ steigt, also sinken Strom und Gesamtleistung ($P = U^2\/R_"ges"$).
- Die Quelle wird weniger belastet.
]

#aufgabe(titel: "Reihenschaltung: was gleich bleibt", art: "verstehen", quelle: "0.4", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 20", minuten: 3)[
#if not web [*Aufgabe 54* #linebreak()]
Zwei unterschiedliche Widerstände liegen in Reihe. Was ist an beiden gleich, was ist verschieden? Hat die Schaltungsart Einfluss auf Strom und Spannung?
][
*Antwort:* Der Strom ist an beiden gleich; die Spannungen teilen sich im Verhältnis der Widerstände. Die Schaltungsart bestimmt also sehr wohl Strom und Spannung.
][
*Ergänzung aus der früheren Quizfrage:* _In einer Reihenschaltung aus zwei Widerständen ist \_\_\_ überall gleich, in einer Parallelschaltung \_\_\_._

*Antwort:* In einer Reihenschaltung aus zwei Widerständen ist #strong[der Strom] überall gleich, in einer Parallelschaltung #strong[die Spannung].

*Erklärung:* Reihenschaltung: ein einziger Strompfad, also derselbe Strom; die Spannung teilt sich auf. Parallelschaltung: alle Zweige hängen an denselben Klemmen, also dieselbe Spannung; der Strom teilt sich auf.
][
*Ergänzung aus der früheren Karteikarte:* _Was ist in einer Reihenschaltung überall gleich, und was teilt sich auf?_

*Antwort:*
- Der Strom ist überall gleich.
- *Die Spannung teilt sich auf:* $U = U_1 + U_2 + dots$.
- Am größten Widerstand fällt die größte Spannung ab.
- $R_"ges" = R_1 + R_2 + dots$ ist größer als jeder einzelne.

*Merksatz:* Reihe: gleicher Strom, Spannung verteilt.
]

#aufgabe(titel: "Parallelschaltung: was gleich bleibt", art: "verstehen", quelle: "0.4", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 23", minuten: 3)[
#if not web [*Aufgabe 55* #linebreak()]
Unterschiedliche Widerstände liegen parallel. Was gilt für Spannung, Strom und Leistung der einzelnen Widerstände? Was passiert mit dem Gesamtstrom, wenn ein Widerstand ausfällt?
][
*Antwort:* An jedem Widerstand liegt dieselbe Spannung, die Ströme sind verschieden. Je größer der Widerstand, desto kleiner seine Leistung ($P = U^2\/R$). Fällt ein Zweig aus, sinkt der Gesamtstrom.
][
*Ergänzung aus der früheren Karteikarte:* _Was ist in einer Parallelschaltung gleich, und was teilt sich auf?_

*Antwort:*
- Die Spannung ist an jedem Zweig gleich.
- *Der Strom teilt sich auf:* $I = I_1 + I_2 + dots$, und $1\/R_"ges" = 1\/R_1 + 1\/R_2 + dots$.
- Der kleinste Widerstand bekommt den größten Strom.
- $R_"ges"$ ist kleiner als der kleinste Einzelwiderstand.
- Fällt ein Zweig aus, laufen die anderen weiter, nur der Gesamtstrom sinkt.

*Merksatz:* Parallel: gleiche Spannung, Strom verteilt.
]

#aufgabe(titel: "Aussagen zur Parallelschaltung prüfen", art: "verstehen", quelle: "0.4", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 56* #linebreak()]
Welche Aussagen über eine Parallelschaltung aus mehreren Widerständen stimmen? Beurteile jede der folgenden Aussagen: richtig oder falsch? Begründe jeweils.
- Der Gesamtwiderstand ist kleiner als der kleinste Einzelwiderstand.
- Der größte Widerstand bekommt den größten Strom.
- Fällt ein Zweig aus, laufen die anderen weiter.
- Die Teilspannungen addieren sich zur Gesamtspannung.
][
*Richtig:*
- Der Gesamtwiderstand ist kleiner als der kleinste Einzelwiderstand. – Jeder zusätzliche Zweig ist ein weiterer Weg für den Strom. Mehr Wege heißt weniger Gesamtwiderstand.
- Fällt ein Zweig aus, laufen die anderen weiter. – Die übrigen Zweige liegen weiter an der vollen Spannung. Nur der Gesamtstrom sinkt.
][
*Falsch:*
- Der größte Widerstand bekommt den größten Strom. – Umgekehrt: Bei gleicher Spannung fließt durch den größten Widerstand der kleinste Strom ($I = U\/R$).
- Die Teilspannungen addieren sich zur Gesamtspannung. – Das gilt für die Reihenschaltung. Parallel liegt an jedem Zweig die volle Spannung.
]

#aufgabe(titel: "Reihenschaltung mit zwei Widerständen", art: "rechnen", quelle: "0.4", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 22", minuten: 5,
  ergebnis: [$R_2 = 110 thin Omega$; $U_1 = 140 thin "V"$, $U_2 = 220 thin "V"$; $U = 360 thin "V"$],
  tipp: [In einer Reihenschaltung gibt es nur einen Weg für die Ladung. Was folgt daraus für den Strom in $R_1$ und $R_2$?],
)[
#if not web [*Aufgabe 57* #linebreak()]
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

#aufgabe(titel: "Reihenschaltung mit 250 Ω Gesamtwiderstand (Variante)", art: "rechnen", quelle: "0.4", herkunft: "variante", vorlage: "Fragenkatalog Einstieg GET, Frage 22", minuten: 5,
  ergebnis: [$R_2 = 160 thin Omega$, $U_1 = 36 thin "V"$, $U_2 = 64 thin "V"$, $U = 100 thin "V"$],
)[
#if not web [*Aufgabe 58* #linebreak()]
*Gegeben und Annahmen*

Eine Reihenschaltung aus zwei Widerständen hat den Gesamtwiderstand 250 Ω und wird von 0,4 A durchflossen. $R_1 = 90 thin Omega$.

*Gesucht*

#enum(numbering: "a)",
[Berechne $R_2$.],
[Berechne die Teilspannungen.],
[Berechne die Gesamtspannung.],
)
][
*a) Reihe addiert:* $R_"ges" = R_1 + R_2$, also $R_2 = 250 - 90 = 160 thin Omega$.
][
*b) Gleicher Strom überall:* $U_1 = I R_1 = "0,4" dot.c 90 = 36 thin "V"$, $U_2 = "0,4" dot.c 160 = 64 thin "V"$.
][
*c) Masche:* $U = U_1 + U_2 = 100 thin "V"$; Kontrolle $I R_"ges" = "0,4" dot.c 250 = 100 thin "V"$.
]

#aufgabe(titel: "Drei Widerstände parallel an 36 V", art: "rechnen", quelle: "0.4", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 24", minuten: 6,
  ergebnis: [$R_1 = 8 thin Omega$, $R_2 approx "5,14" thin Omega$, $R_3 = "7,2" thin Omega$; $I = "16,5" thin "A"$; $R approx "2,18" thin Omega$],
  tipp: [Bei der Parallelschaltung hängt jeder Widerstand direkt an der Quelle. Welche Größe ist dann an allen gleich?],
)[
#if not web [*Aufgabe 59* #linebreak()]
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

#aufgabe(titel: "Drei Widerstände parallel an 24 V (Variante)", art: "rechnen", quelle: "0.4", herkunft: "variante", vorlage: "Fragenkatalog Einstieg GET, Frage 24", minuten: 6,
  ergebnis: [$R_1 = 12 thin Omega$, $R_2 = 8 thin Omega$, $R_3 = 20 thin Omega$; $I = "6,2" thin "A"$; $R_"ges" approx "3,87" thin Omega$],
)[
#if not web [*Aufgabe 60* #linebreak()]
*Gegeben und Annahmen*

Drei parallel geschaltete Widerstände liegen an $U = 24 thin "V"$. Es fließen $I_1 = 2 thin "A"$, $I_2 = 3 thin "A"$ und $I_3 = "1,2" thin "A"$.

*Gesucht*

#enum(numbering: "a)",
[Teilwiderstände.],
[Gesamtstrom.],
[Gesamtwiderstand.],
)
][
*a) Gleiche Spannung an allen:* $R_k = U\/I_k$: $R_1 = 12 thin Omega$, $R_2 = 8 thin Omega$, $R_3 = 20 thin Omega$.
][
*b) Knoten:* $I = I_1 + I_2 + I_3 = "6,2" thin "A"$.
][
*c) Gesamtwiderstand:* $R_"ges" = U\/I = 24\/"6,2" approx "3,87" thin Omega$. Kontrolle: kleiner als der kleinste Zweig (8 Ω), wie es parallel sein muss.
]

#aufgabe(titel: "Unbekannte Widerstände in Reihe", art: "rechnen", quelle: "0.4", herkunft: "original", vorlage: "Übungsblatt B, Aufg. 15", minuten: 5,
  ergebnis: [$R_2 = R_3 approx 47 thin Omega$],
  tipp: [Der gemessene Strom fließt durch alle drei Widerstände. Damit kennst du den Gesamtwiderstand.],
)[
#if not web [*Aufgabe 61* #linebreak()]
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

#aufgabe(titel: "Zwei gleiche Widerstände in Reihe bestimmen (Variante)", art: "rechnen", quelle: "0.4", herkunft: "variante", vorlage: "Übungsblatt B, Aufg. 15", minuten: 5,
  ergebnis: [$R_2 = R_3 = "76,5" thin Omega$],
)[
#if not web [*Aufgabe 62* #linebreak()]
*Gegeben und Annahmen*

Drei Widerstände in Reihe liegen an $U = 12 thin "V"$. Durch $R_1 = 47 thin Omega$ fließt $I = 60 thin "mA"$. Es gilt $R_2 = R_3$.

*Gesucht*

#enum(numbering: "a)",
[Wie groß sind $R_2$ und $R_3$?],
)
][
*Gesamtwiderstand:* In der Reihe fließt überall derselbe Strom: $R_"ges" = U\/I = 12 thin "V"\/"0,06" thin "A" = 200 thin Omega$.
][
*Aufteilen:* $R_"ges" = R_1 + 2 R_2$ → $R_2 = (200 - 47)\/2 = "76,5" thin Omega = R_3$.
][
*Prüfen:* $U_1 = "0,06" dot.c 47 = "2,82" thin "V"$, $U_2 = U_3 = "4,59" thin "V"$; Summe 12 V.
]

#aufgabe(titel: "Ideale gegen reale Spannungsquelle", art: "verstehen", quelle: "0.5", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 63* #linebreak()]
Was unterscheidet eine ideale von einer realen Spannungsquelle?
][
*Antwort:*
- Die ideale Quelle liefert immer dieselbe Spannung, egal wie viel Strom fließt.
- Die reale hat zusätzlich einen Innenwiderstand $R_i$ in Reihe.
- Je mehr Strom fließt, desto mehr Spannung bleibt innen hängen: $U_"Klemme" = U_q - I R_i$.

*Merksatz:* Mehr Laststrom lässt mehr Spannung innen fallen.
]

#aufgabe(titel: "Teilerregel nur ohne Last", art: "verstehen", quelle: "0.6", herkunft: "eigen", minuten: 2,
  tipp: [Die Teilerregel setzt voraus, dass beide Widerstände in Reihe liegen und denselben Strom führen.],
)[
#if not web [*Aufgabe 64* #linebreak()]
Ein unbelasteter Spannungsteiler aus $R_1 = 15 thin "k"Omega$ und $R_2 = 100 thin "k"Omega$ liegt an 35 V. Warum darfst du $U_2 = U dot R_2\/(R_1 + R_2)$ nicht mehr verwenden, sobald am Ausgang ein Verbraucher hängt?
][
*Antwort:* Der Verbraucher liegt parallel zu $R_2$. Dann fließt durch $R_1$ zusätzlich der Laststrom, und $R_1$ und $R_2$ führen nicht mehr denselben Strom. Man muss zuerst $R_2$ und den Verbraucher zu einem Parallelersatz zusammenfassen und erst dann die Teilerregel anwenden. Die Ausgangsspannung sinkt dadurch.
][
*Ergänzung aus der früheren Karteikarte:* _Was ist ein unbelasteter Spannungsteiler, und warum gilt die Teilerregel nur ohne Last?_

*Antwort:*
- Zwei Widerstände in Reihe, die Ausgangsspannung wird an R₂ abgegriffen:
$ U_2 = U dot R_2/(R_1 + R_2) $
- Das gilt nur, wenn am Ausgang kein Strom entnommen wird.
- Hängt ein Verbraucher dran, liegt er parallel zu $R_2$.
- Dann muss man erst den Parallelersatz bilden.
- Die Ausgangsspannung sinkt.

*Merksatz:* Erst die Last parallel ersetzen, dann teilen.
#image("abbildungen/notiz-spannungsteiler.svg", width: 80%)
]

#aufgabe(titel: "Unbelasteter Spannungsteiler", art: "rechnen", quelle: "0.6", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 25", minuten: 4,
  ergebnis: [$U_20 approx "30,4" thin "V"$],
  tipp: [Ohne Last fließt durch $R_1$ und $R_2$ derselbe Strom. Die Spannung teilt sich dann im Verhältnis der Widerstände.],
)[
#if not web [*Aufgabe 65* #linebreak()]
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

#aufgabe(titel: "Belasteter Spannungsteiler", art: "rechnen", quelle: "0.6", herkunft: "variante", vorlage: "Fragenkatalog Einstieg GET, Frage 25", minuten: 12)[
#if not web [*Aufgabe 66* #linebreak()]
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
*Parallelersatz:* $R_p = (100 dot.c 100)/(100 + 100) thin "k"Omega = 50 thin "k"Omega$.
][
*Gesamtstrom:* $I = 35 thin "V"/(65 thin "k"Omega) approx "0,5385" thin "mA"$; Ausgangsspannung: $U_a = 35 thin "V" dot.c 50/65 approx "26,92" thin "V"$.
][
*Ergebnis: 26,92 V.* Die Last verkleinert den unteren Ersatzwiderstand; an $R_1$ fällt mehr Spannung ab. *Prüfung:* In $R_2$ und $R_L$ fließen je rund 0,2692 mA, zusammen der Gesamtstrom. $U_a$ ist kleiner als die Leerlaufspannung 30,43 V.
]

#aufgabe(titel: "Klemmenspannung einer Mignonzelle", art: "rechnen", quelle: "0.6", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 27", minuten: 4,
  ergebnis: [$U(40 thin "mA") = "1,5148" thin "V"$, $U(80 thin "mA") = "1,5096" thin "V"$],
  tipp: [Ein Teil der Quellspannung bleibt schon im Inneren der Zelle hängen. Wie groß ist dieser Teil?],
)[
#if not web [*Aufgabe 67* #linebreak()]
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

#aufgabe(titel: "Die Formel Q = n e A l", art: "verstehen", quelle: "1.1.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 68* #linebreak()]
Erkläre die Formel $Q = n e A l$. Was bedeutet jede Größe?
][
*Antwort:* $n$ = freie Elektronen pro Volumen, $e$ = Ladung eines Elektrons, $A l = V$ = Volumen des Leiterstücks. Das Produkt ist die gesamte bewegliche Ladung im Stück.
][
*Ergänzung aus der früheren Karteikarte:* _Was bedeutet Q = n·e·A·l?_

*Antwort:*
- \*\*$n$:\*\* Zahl freier Elektronen je Volumen.
- \*\*$e$:\*\* Ladungsbetrag je Elektron.
- \*\*$A l$:\*\* Volumen des betrachteten Drahtstücks.
- Zusammen: $Q = n e A l$.
- Doppelte Länge bei sonst gleichen Größen → doppelte Ladungsmenge.
#image("abbildungen/skript-ladung.svg", width: 80%)

*Bild:* Ein Rohr, das randvoll mit Murmeln gefüllt ist.
]

#aufgabe(titel: "Ladung und Elektronenzahl", art: "rechnen", quelle: "1.1.1", herkunft: "variante", vorlage: "Fragenkatalog Einstieg GET, Frage 3", minuten: 9,
  ergebnis: [a) $Q = 60 thin "As"$ b) $N approx "3,75" dot.c 10^20$ Elektronen],
  tipp: [Erst die Ladung aus Strom und Zeit; dann fragen: Wie viele Elementarladungen passen in diese Ladung?],
)[
#if not web [*Aufgabe 69* #linebreak()]
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

#aufgabe(titel: "Technische und physikalische Stromrichtung", art: "verstehen", quelle: "1.1.2", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 8", minuten: 3)[
#if not web [*Aufgabe 70* #linebreak()]
Was ist der Unterschied zwischen technischer und physikalischer Stromrichtung? Welche benutzt man im Schaltbild?
][
*Technisch:* + nach − (Konvention, im Schaltbild). Physikalisch: − nach + (tatsächliche Elektronenbewegung).
][
*Ergänzung aus der früheren Quizfrage:* _In welche Richtung zeigt der Strompfeil $I$ in einem Schaltplan außerhalb der Quelle?_

*Antwort:* Von Plus nach Minus, also entgegen der Elektronenbewegung.

*Begründung:* Schaltpläne verwenden die technische Stromrichtung. Die Elektronen laufen tatsächlich andersherum.

*Typische Verwechslung:*
- Von Minus nach Plus, weil so die Elektronen laufen. – Das ist die physikalische Stromrichtung. Sie stimmt für die Elektronen, wird im Schaltbild aber nicht verwendet.
- Das hängt davon ab, ob Gleich- oder Wechselstrom fließt. – Die Festlegung der technischen Richtung gilt für den Zählpfeil allgemein. Bei Wechselstrom ändert sich nur das Vorzeichen des Werts.
][
*Ergänzung aus der früheren Karteikarte:* _Was ist der Unterschied zwischen technischer und physikalischer Stromrichtung?_

*Antwort:*
- Physikalisch wandern die Elektronen vom Minus- zum Pluspol.
- Die technische Stromrichtung zeigt außerhalb der Quelle von Plus nach Minus, also genau entgegengesetzt.
- In Schaltplänen nutzt man immer die technische Richtung.

*Merksatz:* Elektronen laufen entgegen dem technischen Strompfeil.
#image("abbildungen/skript-stromrichtung.svg", width: 80%)
]

#aufgabe(titel: "Elektrischer Strom: Formel und Bedeutung", art: "verstehen", quelle: "1.1.2", herkunft: "original", vorlage: "Altklausur (Jahr unbekannt 2), F1", minuten: 5,
  tipp: [Denk an Ladung, die pro Zeit durch einen Querschnitt fließt.],
)[
#if not web [*Aufgabe 71* #linebreak()]
Was ist ein elektrischer Strom? Gib eine Formel an. Was bedeuten die einzelnen Größen in der Formel? Erkläre, was diese Formel inhaltlich bedeutet.
][
*Begriff:* Elektrischer Strom ist die gerichtete Bewegung von Ladungsträgern (im Metall: Elektronen). Die Stromstärke gibt an, wie viel Ladung pro Zeit durch einen Leiterquerschnitt fließt.
][
*Formel:* $I = Q\/t$ bei konstantem Strom, allgemein $i = dif Q\/dif t$. $I$ = Stromstärke in A, $Q$ = transportierte Ladung in C = As, $t$ = Zeit in s.
][
*Inhaltlich:* 1 A bedeutet, dass pro Sekunde 1 C, also etwa $"6,25" dot.c 10^18$ Elektronen, durch den Querschnitt gehen. Wie beim Wasser in Litern pro Sekunde zählt der Strom also die Durchflussmenge pro Zeit, nicht die Geschwindigkeit einzelner Teilchen.
][
*Typische Verwechslung:* $I = U\/R$ ist das Ohmsche Gesetz. Es sagt, *wie groß* der Strom in einem Widerstand wird, ist aber keine Definition des Stroms.
]

#aufgabe(titel: "Stromstärke definieren", art: "verstehen", quelle: "1.1.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 72* #linebreak()]
Definiere die Stromstärke in Worten und als Formel. Wie viele Elektronen sind „1 Ampere“?
][
*Antwort:* Stromstärke = Ladung, die pro Zeit durch den Querschnitt fließt: $I = Q\/t$ bzw. $i = dif Q\/dif t$. 1 A ≈ $"6,25" dot.c 10^18$ Elektronen pro Sekunde.
][
*Ergänzung aus der früheren Karteikarte:* _Was ist elektrischer Strom?_

*Antwort:*
- Strom ist die Ladung, die pro Zeit durch den Leiterquerschnitt fließt: $I = Q\/t$.
- 1 A heißt, dass pro Sekunde rund $"6,25" dot 10^18$ Elektronen durch den Querschnitt gehen.

*Merksatz:* Ampere zählt Ladung je Sekunde.

*Bild:* Wassermenge pro Sekunde in einem Rohr.
]

#aufgabe(titel: "Was 36 Ah bedeuten", art: "verstehen", quelle: "1.1.2", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 73* #linebreak()]
Ein 12-V-Akku hat 36 Ah. Welche Aussage stimmt? Prüfe dazu die folgenden Aussagen und begründe, welche zutrifft.
- Er speichert 36 Ah Energie.
- Er speichert die Ladung 36 Ah und damit rund 432 Wh Energie.
- Er liefert 36 Stunden lang 12 A.
- Er kann höchstens 36 A abgeben.
][
*Antwort:* Er speichert die Ladung 36 Ah und damit rund 432 Wh Energie.

*Begründung:* $W = U Q = 12 thin "V" dot 36 thin "Ah" = 432 thin "Wh"$.
][
*Typische Verwechslung:*
- Er speichert 36 Ah Energie. – Amperestunden sind Strom mal Zeit, also eine Ladung. Energie hätte die Einheit Wh oder J.
- Er liefert 36 Stunden lang 12 A. – Das wären 432 Ah. 36 Ah reichen bei 12 A nur 3 Stunden.
- Er kann höchstens 36 A abgeben. – Die Angabe beschreibt die gespeicherte Ladung, nicht den Höchststrom.
][
*Ergänzung aus der früheren Karteikarte:* _Ist „Ah“ eine Energie?_

*Antwort:*
- Nein.
- Amperestunden sind Strom × Zeit, also eine Ladung.
- Die Energie ist erst $W = U Q$, z. B. in Wh.
- Ein 12-V-Akku mit 36 Ah speichert 432 Wh.

*Merksatz:* Ah zählt Ladung; erst mit Spannung wird daraus Energie.
#image("abbildungen/skript-akku.svg", width: 80%)
]

#aufgabe(titel: "Entladezeit des Auto-Akkus", art: "rechnen", quelle: "1.1.2", herkunft: "original", vorlage: "Übung GET, Aufg. 2", minuten: 5)[
#if not web [*Aufgabe 74* #linebreak()]
*Auto-Akku, Ü 2 und V S. 7:*

*Gegeben und Annahmen*

In einem vollgeladenen 12-V-Akku sind 36 Ah gespeichert.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist die theoretische Entladezeit mit zwei parallelen Scheinwerferlampen zu je 42 W?],
)
][
*Strom je Lampe:* $I = P\/U = 42\/12 = "3,5" thin "A"$; beide parallel: $sum I = 7 thin "A"$
][
*Entladezeit:* $t = Q_"max"\/sum I = 36 thin "Ah"\/7 thin "A" approx "5,14" thin "h"$
][
*Ergebnis:* $t approx 308 thin "min"$, wie auf dem Übungsblatt. *Prüfung:* Ah geteilt durch A ergibt h; die Ladung sinkt linear, weil der Strom konstant ist.
]

#aufgabe(titel: "Laufzeit einer Powerbank", art: "rechnen", quelle: "1.1.2", herkunft: "variante", vorlage: "Übung GET, Aufg. 2", minuten: 9,
  ergebnis: [$t = "12,5" thin "h"$],
)[
#if not web [*Aufgabe 75* #linebreak()]
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

#aufgabe(titel: "E-Bike-Akku", art: "rechnen", quelle: "1.1.2", herkunft: "variante", vorlage: "Übung GET, Aufg. 2", minuten: 12,
  ergebnis: [a) $I approx "6,94" thin "A"$ b) $t approx "2,0" thin "h"$ c) $W = 504 thin "Wh"$],
)[
#if not web [*Aufgabe 76* #linebreak()]
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

#aufgabe(titel: "Ladestrom aus dem Ladungsverlauf", art: "rechnen", quelle: "1.1.2", herkunft: "original", vorlage: "Übungsblatt B, Aufg. 12", minuten: 6, platz: 12,
  ergebnis: [$I approx 67 thin "mA"$ zwischen 2 h und 8 h, sonst $I = 0$],
  tipp: [Der Strom ist die Steigung der Ladungskurve: $I = Delta Q\/Delta t$.],
)[
#if not web [*Aufgabe 77* #linebreak()]
*Gegeben und Annahmen*

Das Liniendiagramm zeigt den Ladungsverlauf beim Aufladen eines Nickel-Cadmium-Kleinakkus: bis 2 h konstant 0,1 Ah, dann linear ansteigend bis 0,5 Ah bei 8 h, danach konstant.

#image("abbildungen/blatt-b-ladungsverlauf.svg", width: 70%)

*Gesucht*

#enum(numbering: "a)",
[Zeichne den zeitlichen Verlauf der Stromstärke $I$.],
[Berechne die Ladestromstärke $I$ im Zeitbereich 2 … 8 h.],
)
][
*Idee:* Strom ist Ladung pro Zeit. Wo die Ladungskurve waagrecht ist, kommt keine Ladung hinzu, also $I = 0$. Wo sie gleichmäßig steigt, ist der Strom konstant und gleich ihrer Steigung.
][
*b) Steigung berechnen:* $I = Delta Q\/Delta t = ("0,5" - "0,1") thin "Ah"\/(8 - 2) thin "h" = "0,4"\/6 thin "A" approx "0,067" thin "A" = 67 thin "mA"$.
][
*a) Stromverlauf zeichnen:* $I(t) = 0$ für $0 < t < 2 thin "h"$, ein Rechteck mit 67 mA von 2 h bis 8 h, danach wieder 0. Die Fläche des Rechtecks ($67 thin "mA" dot.c 6 thin "h" = "0,4" thin "Ah"$) ist genau die zugeführte Ladung.
]

#aufgabe(titel: "Ladestrom eines Akkupacks (Variante)", art: "rechnen", quelle: "1.1.2", herkunft: "variante", vorlage: "Übungsblatt B, Aufg. 12", minuten: 6, platz: 12,
  ergebnis: [$I = "0,2" thin "A"$ zwischen 1 h und 5 h, sonst 0; Ladezeit für 0,8 Ah bei 0,4 A: 2 h],
)[
#if not web [*Aufgabe 78* #linebreak()]
*Gegeben und Annahmen*

Die gespeicherte Ladung eines Akkupacks beträgt bis $t = 1 thin "h"$ konstant 0,2 Ah, steigt dann gleichmäßig bis $t = 5 thin "h"$ auf 1,0 Ah und bleibt danach konstant.

*Gesucht*

#enum(numbering: "a)",
[Skizziere den Ladungsverlauf $q(t)$ und den Stromverlauf $I(t)$ von 0 bis 7 h.],
[Berechne den Ladestrom.],
[Wie lange hätte das Laden derselben Ladungsmenge mit 0,4 A gedauert?],
)
][
*b) Steigung:* $I = Delta Q\/Delta t = ("1,0" - "0,2") thin "Ah"\/(5 - 1) thin "h" = "0,2" thin "A"$.
][
*a) Verläufe:* $q(t)$: waagrecht bei 0,2 Ah, Rampe bis 1,0 Ah, wieder waagrecht. $I(t)$: 0, dann 0,2 A von 1 h bis 5 h, dann 0. Waagrechte Ladung heißt kein Strom.
][
*c) Gleiche Ladung, doppelter Strom:* $t = Delta Q\/I = "0,8" thin "Ah"\/"0,4" thin "A" = 2 thin "h"$.
]

#aufgabe(titel: "Warum das Licht sofort angeht", art: "verstehen", quelle: "1.1.3", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 79* #linebreak()]
Die Elektronen driften nur mit etwa 1 mm/s. Warum geht das Licht trotzdem sofort an?
][
*Antwort:* Das elektrische Feld breitet sich fast mit Lichtgeschwindigkeit aus; alle Elektronen im Kreis beginnen gleichzeitig zu driften.
][
*Ergänzung aus der früheren Quizfrage:* _Die Elektronen im Draht driften nur mit etwa 1 mm/s. Warum leuchtet die Lampe trotzdem sofort nach dem Einschalten?_

*Antwort:* Weil sich das elektrische Feld fast mit Lichtgeschwindigkeit ausbreitet und alle Elektronen im Kreis praktisch gleichzeitig zu driften beginnen.

*Begründung:* Wie beim vollen Gartenschlauch: Vorne kommt sofort Wasser, obwohl das Wasser vom Hahn noch nicht dort ist.

*Typische Verwechslung:*
- Weil die Elektronen beim Einschalten kurz auf Lichtgeschwindigkeit beschleunigen. – Die Driftgeschwindigkeit bleibt klein. Kein einzelnes Elektron rast vom Schalter zur Lampe.
- Weil die Lampe ihre eigenen Elektronen hat, die nicht wandern müssen. – Auch in der Lampe fließt nur Strom, wenn der ganze Kreis geschlossen ist und das Feld überall wirkt.
][
*Ergänzung aus der früheren Karteikarte:* _Die Elektronen driften nur mit etwa 1 mm/s. Warum geht das Licht trotzdem sofort an?_

*Antwort:*
- Der Draht ist schon voller Elektronen.
- Beim Einschalten breitet sich das elektrische Feld fast mit Lichtgeschwindigkeit aus, und alle Elektronen im Kreis beginnen praktisch gleichzeitig zu driften.
- Kein Elektron muss vom Schalter zur Lampe wandern.

*Merksatz:* Das Feld läuft schnell; die Elektronen driften langsam.
#image("abbildungen/skript-impuls.svg", width: 80%)

*Bild:* Ein voller Gartenschlauch: Hahn auf, und vorne kommt sofort Wasser, obwohl das Wasser vom Hahn noch lange nicht vorne ist.
]

#aufgabe(titel: "Driftgeschwindigkeit in der Kupferleitung", art: "rechnen", quelle: "1.1.3", herkunft: "original", vorlage: "Vorlesungsskript S. 9", minuten: 12,
  ergebnis: [$A = "0,015" thin "cm"^2$, $v_d approx "0,82" thin "mm/s"$],
)[
#if not web [*Aufgabe 80* #linebreak()]
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

#aufgabe(titel: "Stromdichte: Formelzeichen und Einheit", art: "verstehen", quelle: "1.1.5", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 9", minuten: 3,
)[
#if not web [*Aufgabe 81* #linebreak()]
Was beschreibt die elektrische Stromdichte? Gib das Formelzeichen und die typische Einheit dieser Größe an.
][
*Bedeutung:* Die Stromdichte sagt, wie viel Strom auf jeden Quadratmillimeter Leiterquerschnitt kommt, also wie „gedrängt“ der Strom fließt. Sie bestimmt die Erwärmung eines Leiters.
][
*Formel und Einheit:* $S = I\/A$ (in manchen Büchern $J$). Typische Einheit in der Technik: $"A"\/"mm"^2$ (SI: $"A"\/"m"^2$).
]

#aufgabe(titel: "Stromdichte und Erwärmung", art: "verstehen", quelle: "1.1.5", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 82* #linebreak()]
Warum bestimmt die Stromdichte und nicht die Stromstärke die Erwärmung eines Leiters?
][
*Antwort:* Die Erwärmung kommt von der Reibung pro Querschnittsfläche. Derselbe Strom erzeugt in einem dünnen Draht eine viel höhere Stromdichte und damit mehr Wärme als in einem dicken.
][
*Ergänzung aus der früheren Quizfrage:* _Welche Größe ist maßgebend dafür, wie warm ein Leiter wird?_

*Antwort:* Die Stromdichte $S = I\/A$

*Begründung:* Sie sagt, wie viel Strom durch jeden mm² muss. Die engste Stelle wird am heißesten; darauf beruht die Schmelzsicherung.

*Typische Verwechslung:*
- Die Stromstärke allein – Derselbe Strom erwärmt einen dünnen Draht viel stärker als einen dicken.
- Die Spannung an der Quelle – Die Spannung treibt den Strom an, sagt aber nichts darüber, wie er sich auf den Querschnitt verteilt.
- Die Driftgeschwindigkeit der Elektronen – Sie hängt zwar mit der Stromdichte zusammen, ist aber nicht die Größe, mit der man die Erwärmung beurteilt.
][
*Ergänzung aus der früheren Karteikarte:* _Warum bestimmt die Stromdichte und nicht die Stromstärke die Erwärmung?_

*Antwort:*
- Die Stromdichte $S = I\/A$ sagt, wie viel Strom sich durch jeden mm² quetschen muss.
- Je enger, desto mehr Reibung pro Fläche, desto heißer.
- Die dünnste Stelle wird am heißesten, darauf beruht die Schmelzsicherung.
#image("abbildungen/querschnitt.svg", width: 80%)
]

#aufgabe(titel: "Leiter mit doppeltem Querschnitt", art: "verstehen", quelle: "1.1.5", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 83* #linebreak()]
Ein Leiter hat links den Querschnitt $A$, rechts $2 A$. Was gilt rechts für Strom und Stromdichte?
][
*Antwort:* Gleicher Strom (Kontinuität), halbe Stromdichte.
][
*Ergänzung aus der früheren Karteikarte:* _Ein Leiter hat links die Fläche A und rechts 2A. Was gilt rechts für Strom und Stromdichte?_

*Antwort:*
- Der Strom ist gleich, denn Ladung geht nicht verloren (Kontinuität).
- Die Stromdichte halbiert sich, weil sich derselbe Strom auf die doppelte Fläche verteilt: $S_1 A_1 = S_2 A_2$.

*Merksatz:* Gleicher Strom auf mehr Fläche ergibt kleinere Stromdichte.
#image("abbildungen/querschnitt.svg", width: 80%)
]

#aufgabe(titel: "Warum Hochspannung übertragen wird", art: "verstehen", quelle: "1.1.5", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 84* #linebreak()]
Warum überträgt man elektrische Energie über weite Strecken mit Hochspannung?
][
*Antwort:* Die Leitungsverluste $P = I^2 R$ hängen quadratisch vom Strom ab. Bei hoher Spannung braucht man für dieselbe Leistung nur wenig Strom.
][
*Ergänzung aus der früheren Quizfrage:* _Warum überträgt man elektrische Energie über weite Strecken mit sehr hoher Spannung?_

*Antwort:* Die Leitungsverluste sind $P_"Verlust" = I^2 R_"Leitung"$. Bei gleicher übertragener Leistung $P = U I$ wird der Strom umso kleiner, je höher die Spannung ist. Weil der Strom quadratisch in die Verluste eingeht, sinken sie stark. Die Spannung lässt sich mit Transformatoren hoch- und heruntersetzen, deshalb nutzt man Wechselstrom.
][
*Ergänzung aus der früheren Karteikarte:* _Warum überträgt man Strom über weite Strecken mit Hochspannung?_

*Antwort:*
- Die Leitungsverluste sind $P_V = I^2 R$.
- Bei gleicher Leistung $P = U I$ heißt hohe Spannung kleiner Strom und damit viel kleinere Verluste.
- Hochtransformieren geht nur mit Wechselstrom, deshalb hat sich Wechselstrom durchgesetzt.
#image("abbildungen/querschnitt.svg", width: 80%)
]

#aufgabe(titel: "Stromdichte und Driftgeschwindigkeit", art: "rechnen", quelle: "1.1.5", herkunft: "variante", vorlage: "Vorlesungsskript S. 9", minuten: 15,
  ergebnis: [a) $S approx "10,7" thin "A/mm"^2$, oberhalb des vorgegebenen Skriptrichtbereichs b) $v_d approx "0,79" thin "mm/s"$],
  tipp: [Für $v_d$ stellst du $I = n e A v_d$ um. Achte darauf, dass alle Längen in derselben Einheit stehen wie $n$.],
)[
#if not web [*Aufgabe 85* #linebreak()]
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

#aufgabe(titel: "Zulässige Stromdichte prüfen", art: "rechnen", quelle: "1.1.5", herkunft: "eigen", minuten: 9,
  ergebnis: [$S = 4 thin "A/mm"^2$, innerhalb des vorgegebenen Skriptrichtbereichs],
)[
#if not web [*Aufgabe 86* #linebreak()]
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

#aufgabe(titel: "Magnetfeld und Induktion", art: "verstehen", quelle: "1.1.6", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 28", minuten: 3)[
#if not web [*Aufgabe 87* #linebreak()]
*Magnetfeld, FK 28 als offene Frage; am 22.10. bearbeitet:* a) Erzeugt auch ein Strom von 0,5 A ein Magnetfeld? b) Eine Spule und ein Magnetfeld ruhen unverändert gegeneinander: Wird Spannung induziert? c) Kann in einem zeitlich konstanten Magnetfeld trotzdem eine Spannung induziert werden? Nenne eine passende Bewegung und die entscheidende Bedingung.
][
*Antwort:* a) Ja, jeder Strom erzeugt ein Magnetfeld; dafür gibt es keine 1-A-Schwelle. b) Nein: Der Fluss bleibt konstant. c) Ja: etwa beim Herausziehen der Spule aus dem Feld oder beim Drehen der Spule. Entscheidend ist die Änderung des magnetischen Flusses durch ihre Fläche; eine Bewegung, bei der der Fluss unverändert bleibt, genügt nicht.
][
*Ergänzung aus der früheren Karteikarte:* _Kann in einem zeitlich konstanten Magnetfeld trotzdem eine Spannung induziert werden?_

*Antwort:*
- Ja, wenn sich der Fluss durch die Spule trotzdem ändert, z. B. weil die Spule aus dem Feld gezogen oder gedreht wird.
- Entscheidend ist die Flussänderung, nicht ob sich das Feld selbst ändert.
#image("abbildungen/skript-induktion.svg", width: 80%)
]

#aufgabe(titel: "Drei Wirkungen des Stroms", art: "verstehen", quelle: "1.1.6", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 88* #linebreak()]
Nenne die drei Wirkungen des Stroms mit je einem Anwendungsbeispiel.
][
*Antwort:* Wärme (Heizlüfter), Kraft über das Magnetfeld (Elektromotor), Materialtransport (elektrochemische Prozesse, z. B. Galvanisieren).
][
*Ergänzung aus der früheren Karteikarte:* _Woran erkennt man, dass Strom fließt?_

*Antwort:*
- *An drei Wirkungen:*
- *Wärme:* Elektronenreibung, z. B. Wasserkocher, Sicherung.
- *Magnetfeld / Kraft:* jeder Strom erzeugt ein Magnetfeld, z. B. Elektromotor, Messgeräte.
- *Chemie:* Ionenstrom in Flüssigkeiten, z. B. Galvanisieren, Akku laden.
#image("abbildungen/skript-lorentz.svg", width: 80%)
]

#aufgabe(titel: "Wovon die Lorentzkraft abhängt", art: "verstehen", quelle: "1.1.6", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 89* #linebreak()]
Wovon hängt die Lorentzkraft auf einen stromdurchflossenen Leiter ab? Wann ist sie null?
][
*Antwort:* $F_L = I l B$: Sie wächst mit Strom, Leiterlänge im Feld und Flussdichte. Liegt der Leiter parallel zum Feld, ist $arrow(l) times arrow(B) = 0$, also keine Kraft.
][
*Ergänzung aus der früheren Quizfrage:* _Ein gerader Leiter liegt parallel zu den Feldlinien eines Magnetfelds und führt Strom. Welche Lorentzkraft wirkt auf ihn?_

*Antwort:* Keine, denn das Kreuzprodukt $arrow(l) times arrow(B)$ ist null.

*Begründung:* Die Lorentzkraft wirkt nur auf den Anteil senkrecht zum Feld.

*Typische Verwechslung:*
- Die größtmögliche Kraft $F = I l B$. – Das gilt, wenn Leiter und Feld senkrecht zueinander stehen.
- Eine Kraft entlang des Leiters. – Die Lorentzkraft steht immer senkrecht zu Leiter und Feld, nie entlang des Leiters.
][
*Ergänzung aus der früheren Karteikarte:* _Wovon hängt die Lorentzkraft auf einen stromdurchflossenen Leiter ab, und wann ist sie null?_

*Antwort:*
- $F = I l B$ bei senkrechtem Feld.
- Mehr Strom, längerer Leiter im Feld oder stärkeres Feld geben mehr Kraft.
- Die Kraft steht senkrecht zu Strom und Feld.
- Liegt der Leiter parallel zum Feld, ist sie null.
#image("abbildungen/skript-lorentz.svg", width: 80%)
]

#aufgabe(titel: "Lineare Skala des Drehspulinstruments", art: "verstehen", quelle: "1.1.6", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 90* #linebreak()]
Warum hat ein Drehspulinstrument eine lineare Skala?
][
*Antwort:* Weil $phi = N A B\/D^* dot.c I$: Der Ausschlag ist proportional zum Strom.
][
*Ergänzung aus der früheren Karteikarte:* _Warum hat ein Drehspulinstrument eine lineare Skala?_

*Antwort:*
- Das Drehmoment der Spule ist proportional zum Strom, die Rückstellfedern halten proportional zum Winkel dagegen.
- Im Gleichgewicht ist der Ausschlag also proportional zum Strom: doppelter Strom, doppelter Ausschlag.
#image("abbildungen/skript-drehspul.svg", width: 80%)
]

#aufgabe(titel: "Leiterschleife dreht sich im Magnetfeld", art: "verstehen", quelle: "1.1.6", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 91* #linebreak()]
Warum dreht sich eine Leiterschleife im Magnetfeld, statt sich zu verschieben?
][
*Antwort:*
- Der Strom fließt auf einer Seite hin und auf der anderen zurück.
- Die beiden Lorentzkräfte zeigen deshalb in entgegengesetzte Richtungen und bilden ein Drehmoment.
- Das ist das Prinzip von Elektromotor und Drehspulinstrument.
#image("abbildungen/skript-lorentz.svg", width: 80%)
]

#aufgabe(titel: "Kraft auf einen Leiter im Magnetfeld", art: "rechnen", quelle: "1.1.6", herkunft: "eigen", minuten: 12,
  ergebnis: [$F = "0,5" thin "N"$],
)[
#if not web [*Aufgabe 92* #linebreak()]
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

#aufgabe(titel: "Ausschlag eines Drehspulinstruments", art: "rechnen", quelle: "1.1.6", herkunft: "eigen", minuten: 9,
  ergebnis: [$phi = 75°$],
  tipp: [Der Ausschlag ist proportional zum Strom. Was passiert mit dem Winkel, wenn der Strom auf das 2,5-Fache steigt?],
)[
#if not web [*Aufgabe 93* #linebreak()]
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

#aufgabe(titel: "Drehspulinstrument bei 36°", art: "rechnen", quelle: "1.1.6", herkunft: "eigen", minuten: 12,
  ergebnis: [a) 0,4 mA b) 2 mC],
)[
#if not web [*Aufgabe 94* #linebreak()]
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

#aufgabe(titel: "Gleich- und Wechselspannung zeichnen", art: "verstehen", quelle: "1.1.7", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 5", minuten: 4, platz: 8,
)[
#if not web [*Aufgabe 95* #linebreak()]
Zeichne den zeitlichen Verlauf einer Gleichspannung und einer Wechselspannung (sinusförmig) jeweils in ein eigenes Diagramm, inklusive Achsenbeschriftung. Markiere bei der Wechselspannung Scheitelwert und Periodendauer.
][
*Gleichspannung:* Achsen $u(t)$ (V) nach oben, $t$ (s) nach rechts. Der Verlauf ist eine waagrechte Linie, z. B. bei 5 V: Betrag und Richtung bleiben zeitlich konstant.
][
*Wechselspannung:* Gleiche Achsen. Der Verlauf ist eine Sinuskurve $u(t) = hat(u) sin(omega t)$, die symmetrisch um die Zeitachse schwingt. Der Scheitelwert $hat(u)$ ist die größte Auslenkung, die Periodendauer $T = 1\/f$ ist der Abstand zwischen zwei gleichen Zuständen, z. B. zwei Nulldurchgängen in gleicher Richtung.
][
*Unterschied in Worten:* Bei Gleichspannung bleibt die Polarität fest, bei Wechselspannung wechselt sie periodisch; der Mittelwert der reinen Sinusspannung ist null.
][
*Ergänzung aus der früheren Karteikarte:* _Was ist der Unterschied zwischen Gleichstrom und Wechselstrom?_

*Antwort:*
- Gleichstrom (DC) bleibt konstant, z. B. aus Batterie oder Akku.
- Wechselstrom (AC) wechselt periodisch die Richtung, im Netz mit 50 Hz, also 20 ms pro Periode.
#image("abbildungen/stromarten.svg", width: 80%)
]

#aufgabe(titel: "Effektivwert eines Wechselstroms", art: "verstehen", quelle: "1.1.7", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 96* #linebreak()]
Was ist der Effektivwert eines Wechselstroms?
][
*Antwort:*
- Der Gleichstromwert, der in einem Widerstand dieselbe Wärme erzeugt.
- *Bei Sinus:* $I_"eff" = hat(i)\/sqrt(2)$.
- Die 230 V der Steckdose sind ein Effektivwert, der Scheitelwert liegt bei etwa 325 V.

*Merksatz:* Effektiv heißt: gleiche Wärmewirkung.
#image("abbildungen/stromarten.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Die Steckdose liefert 230 V. Das ist der \_\_\_wert; der Scheitelwert beträgt rund \_\_\_ V._

*Antwort:* Die Steckdose liefert 230 V. Das ist der #strong[Effektiv]wert; der Scheitelwert beträgt rund #strong[325] V.

*Erklärung:* 230 V ist der Effektivwert, also der Gleichspannungswert, der in einem Widerstand dieselbe Wärme erzeugt. Der Scheitelwert ist $230 dot sqrt(2) approx 325 thin "V"$.
]

#aufgabe(titel: "Periodendauer bei 60 Hz", art: "rechnen", quelle: "1.1.7", herkunft: "eigen", minuten: 9,
  ergebnis: [$T approx "16,7" thin "ms"$],
)[
#if not web [*Aufgabe 97* #linebreak()]
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

#aufgabe(titel: "Lampen-Aufgabe: Schalter schließen", art: "verstehen", quelle: "1.1.7.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 98* #linebreak()]
Drei gleiche Lampen A, B und C liegen in Reihe an einer idealen Batterie. Ein idealer Schalter S liegt parallel zu C und ist zunächst offen. Für das einfache Modell werden die Lampen als gleiche konstante Widerstände behandelt. S wird geschlossen: Was passiert mit C, mit dem Batteriestrom, mit A und B und mit der Gesamtleistung?
][
*Antwort:* C erlischt, der Batteriestrom steigt, A und B leuchten heller, die Gesamtleistung steigt.
][
*Ergänzung aus der früheren Quizfrage:* _Drei gleiche Lampen liegen in Reihe an einer Batterie. Ein Schalter parallel zu Lampe C wird geschlossen. Was passiert mit den Lampen A und B?_

*Antwort:* Sie werden heller; im Modell mit konstanten Lampenwiderständen steigt ihre Leistung auf das 2,25-Fache.

*Begründung:* Ihre Spannung steigt von $U_q\/3$ auf $U_q\/2$. Mit $P = U^2\/R$ gibt das $(3\/2)^2 = "2,25"$.

*Typische Verwechslung:*
- Sie werden dunkler, weil der Schalter Strom abzweigt. – Der Schalter überbrückt C. Der Gesamtwiderstand sinkt, also steigt der Strom durch A und B.
- Sie bleiben gleich hell, nur C geht aus. – Dann müsste der Strom gleich bleiben. Er steigt aber von $U_q\/(3R)$ auf $U_q\/(2R)$.
- Sie werden genau doppelt so hell. – Der Strom steigt um den Faktor 1,5, die Leistung aber quadratisch mit dem Strom.
][
*Ergänzung aus der früheren Karteikarte:* _Drei gleiche Lampen in Reihe, ein Schalter parallel zu Lampe C wird geschlossen. Was passiert?_

*Antwort:*
- Schalter schließen → C wird kurzgeschlossen und erlischt.
- Gesamtwiderstand sinkt von 3R auf 2R → Strom steigt.
- A und B erhalten je die halbe statt ein Drittel der Spannung.
- Sie leuchten heller; ihre Leistung steigt jeweils auf das 2,25-Fache.
- *Reihenfolge:* $R_"ges" -> I ->$ Teilspannungen → Leistungen.
#image("abbildungen/lampen.svg", width: 80%)
]

#aufgabe(titel: "Lampen-Aufgabe mit Zahlen", art: "rechnen", quelle: "1.1.7.1", herkunft: "eigen", minuten: 9,
  ergebnis: [Offen: 0,1 A, 3 V, 0,3 W. Geschlossen: 0,15 A, 4,5 V, 0,675 W],
  tipp: [Wenn S schließt, wird Lampe C überbrückt. Wie viele Lampen bleiben in Reihe?],
)[
#if not web [*Aufgabe 99* #linebreak()]
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

#aufgabe(titel: "Eine von vier Lampen überbrückt", art: "rechnen", quelle: "1.1.7.1", herkunft: "eigen", minuten: 12,
  ergebnis: [3 V vorher, 4 V nachher; Leistung × 1,78],
)[
#if not web [*Aufgabe 100* #linebreak()]
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

#aufgabe(titel: "Wie eine Quellspannung entsteht", art: "verstehen", quelle: "1.2.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 101* #linebreak()]
Was muss in jeder Spannungsquelle passieren, damit eine Quellspannung entsteht? Welche Energieumwandlung findet in Batterie und Generator statt?
][
*Antwort:* Ladungstrennung durch einen physikalischen Effekt. Batterie: chemisch → elektrisch. Generator: mechanisch → elektrisch (Induktion).
][
*Ergänzung aus der früheren Karteikarte:* _Was muss in jeder Spannungsquelle passieren, damit eine Quellspannung entsteht?_

*Antwort:*
- Ein physikalischer Effekt muss Ladungen trennen, sodass am Minuspol ein Elektronenüberschuss entsteht.
- Möglich durch Chemie (Batterie), Induktion (Generator), Temperaturdifferenz (Thermoelement), Licht (Solarzelle) oder Druck (Piezo).
#image("abbildungen/skript-chemie.svg", width: 80%)
]

#aufgabe(titel: "Spannung in einer Batterie", art: "verstehen", quelle: "1.2.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 102* #linebreak()]
Wie entsteht die Spannung in einer Batterie?
][
*Antwort:*
- Eine chemische Reaktion trennt Ladungen und erzeugt einen Elektronenüberschuss am Minuspol.
- Fließt Strom, liefert die Reaktion ständig Elektronen nach, bis die Chemie verbraucht ist.
- Umgewandelt wird chemische in elektrische Energie.
#image("abbildungen/skript-chemie.svg", width: 80%)
]

#aufgabe(titel: "Induktionsgesetz in Worten", art: "verstehen", quelle: "1.2.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 103* #linebreak()]
Formuliere das Induktionsgesetz in Worten. Was bedeutet das Minuszeichen?
][
*Antwort:* Ändert sich der magnetische Fluss durch eine Spule, wird eine Spannung induziert, umso größer, je schneller die Änderung und je mehr Windungen. Das Minus (Lenz): Die Wirkung ist ihrer Ursache entgegengerichtet.
][
*Ergänzung aus der früheren Karteikarte:* _Was sagt das Induktionsgesetz in Worten?_

*Antwort:*
- Änderung des magnetischen Flusses durch die Spule → induzierte Spannung.
$ u_i = -N (dif Phi)/(dif t) $
- Schnellere Änderung oder mehr Windungen → größerer Spannungsbetrag.
- Ein unveränderter Fluss genügt nicht: Entscheidend ist die *Änderung*.

*Merksatz:* Induktion braucht Flussänderung.
#image("abbildungen/skript-induktion.svg", width: 80%)
][
*Ergänzung aus der früheren Karteikarte:* _Was bedeutet das Minuszeichen im Induktionsgesetz (Lenzsche Regel)?_

*Antwort:*
- Die induzierte Spannung treibt einen Strom, dessen Magnetfeld der Flussänderung entgegenwirkt.
- Die Spule „will, dass alles gleich bleibt“.

*Merksatz:* Lenz: Gegen die Änderung, nicht pauschal gegen das Feld.
#image("abbildungen/skript-induktion.svg", width: 80%)

*Bild:* Ein träger Mitbewohner, der sich gegen jede Veränderung stemmt.
]

#aufgabe(titel: "Ruhender Magnet in der Spule", art: "verstehen", quelle: "1.2.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 104* #linebreak()]
Ein Magnet liegt ruhig in einer Spule. Wird eine Spannung induziert? Und wenn man die Spule aus dem Feld zieht?
][
*Ruhender Magnet:* nein, der Fluss ist konstant, $dif Phi\/dif t = 0$. Spule aus dem Feld ziehen: ja, der Fluss durch die Spule ändert sich.
][
*Ergänzung aus der früheren Karteikarte:* _Ein Magnet liegt ruhig in einer Spule. Wird eine Spannung induziert?_

*Antwort:*
- Nein, der Fluss ändert sich nicht.
- Erst wenn man den Magneten oder die Spule bewegt, sodass sich der Fluss durch die Spule ändert, entsteht eine Spannung.
#image("abbildungen/skript-induktion.svg", width: 80%)
]

#aufgabe(titel: "Aussagen zur Induktion prüfen", art: "verstehen", quelle: "1.2.2", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 105* #linebreak()]
Welche Aussagen zur Induktion stimmen? Beurteile jede der folgenden Aussagen: richtig oder falsch? Begründe jeweils.
- Nur eine Änderung des magnetischen Flusses erzeugt eine Induktionsspannung.
- Doppelt so schnelle Flussänderung ergibt doppelt so große induzierte Spannung.
- Ein starkes, konstantes Magnetfeld erzeugt in einer ruhenden Spule eine große Spannung.
- Das Minuszeichen im Induktionsgesetz bedeutet, dass die Spannung immer negativ ist.
][
*Richtig:*
- Nur eine Änderung des magnetischen Flusses erzeugt eine Induktionsspannung. – Ein ruhender Magnet in einer ruhenden Spule erzeugt nichts.
- Doppelt so schnelle Flussänderung ergibt doppelt so große induzierte Spannung. – $abs(u_i) = N dot Delta Phi\/Delta t$; halbe Zeit, doppelte Spannung.
][
*Falsch:*
- Ein starkes, konstantes Magnetfeld erzeugt in einer ruhenden Spule eine große Spannung. – Die Stärke des Felds allein reicht nicht. Entscheidend ist, dass sich der Fluss ändert.
- Das Minuszeichen im Induktionsgesetz bedeutet, dass die Spannung immer negativ ist. – Es beschreibt die Lenzsche Regel: Die Wirkung ist ihrer Ursache entgegengerichtet. Das Vorzeichen des Werts hängt von der Richtung der Änderung ab.
]

#aufgabe(titel: "Induzierte Spannung bei steigendem Fluss", art: "rechnen", quelle: "1.2.2", herkunft: "eigen", minuten: 12,
  ergebnis: [$abs(u_i) = 10 thin "V"$],
  tipp: [Die Spannung hängt davon ab, wie *schnell* sich der Fluss ändert, und von der Windungszahl.],
)[
#if not web [*Aufgabe 106* #linebreak()]
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

#aufgabe(titel: "Spule aus dem Feld gezogen", art: "rechnen", quelle: "1.2.2", herkunft: "eigen", minuten: 12,
  ergebnis: [$Delta Phi = "1,6" dot.c 10^(-4) thin "Vs"$, $abs(u_i) = "1,6" thin "V"$],
  tipp: [Zuerst den Fluss in der Spule berechnen. Nach dem Herausziehen ist er null.],
)[
#if not web [*Aufgabe 107* #linebreak()]
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

#aufgabe(titel: "Flussdichte aus dem Ladungsimpuls", art: "rechnen", quelle: "1.2.2", herkunft: "eigen", minuten: 12)[
#if not web [*Aufgabe 108* #linebreak()]
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
*Fläche:* $A = 4 thin "cm"^2 = 4 dot.c 10^(-4) thin "m"^2$; Ladung: $Q = 2 dot.c 10^(-6) thin "As"$.
][
*Flussdichte:* $B = (R Q)/(N A) = (100 thin Omega dot.c 2 dot.c 10^(-6) thin "As")/(200 dot.c 4 dot.c 10^(-4) thin "m"^2) = "0,0025" thin "T"$.
][
*Ergebnis: 2,5 mT.* Schnelleres Herausziehen vergrößert die Impulshöhe und verkürzt die Dauer. Bei gleichem Anfangs- und Endfluss bleibt die Fläche unter der Stromkurve, also $Q$, unverändert. *Prüfung:* Ω × As/m² = Vs/m² = T.
]

#aufgabe(titel: "Thermoelement: warum eine Temperatur nicht reicht", art: "verstehen", quelle: "1.2.3", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 109* #linebreak()]
Wie funktioniert ein Thermoelement, und warum reicht die Temperatur der Messstelle allein nicht?
][
*Antwort:*
- Zwei verschiedene Metalle (z. B. Kupfer und Konstantan) erzeugen eine Spannung, die vom *Temperaturunterschied* zwischen Messstelle und Vergleichsstelle abhängt (Seebeck-Effekt).
- Ohne die Temperatur der Vergleichsstelle weiß man also nicht, welche Spannung herauskommt.
- Sind beide gleich warm, ist die Spannung null.

*Merksatz:* Das Thermoelement vergleicht zwei Temperaturen.
#image("abbildungen/skript-thermo.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Ein Thermoelement Cu–Konstantan ($K = "0,05" thin "mV/K"$) hat die Messstelle bei 80 °C. Warum reicht diese Angabe nicht, um die Thermospannung anzugeben?_

*Antwort:* Die Thermospannung hängt von der Temperaturdifferenz zwischen Messstelle und Vergleichsstelle ab, $U_q approx K Delta theta$. Ohne die Temperatur der Vergleichsstelle an den Anschlüssen ist die Differenz unbekannt. Bei 20 °C an der Vergleichsstelle wären es zum Beispiel 3 mV, bei 80 °C null.
]

#aufgabe(titel: "Spannung eines Thermoelements", art: "rechnen", quelle: "1.2.3", herkunft: "eigen", minuten: 12,
  ergebnis: [a) 3 mV b) −3 mV c) 0 V],
  tipp: [Das Thermoelement misst keine Temperatur, sondern eine *Temperaturdifferenz*.],
)[
#if not web [*Aufgabe 110* #linebreak()]
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

#aufgabe(titel: "Temperatur aus Thermospannung", art: "rechnen", quelle: "1.2.3", herkunft: "eigen", minuten: 9,
  ergebnis: [Messstelle 85 °C],
)[
#if not web [*Aufgabe 111* #linebreak()]
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

#aufgabe(titel: "Wie eine Solarzelle Strom erzeugt", art: "verstehen", quelle: "1.2.4", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 112* #linebreak()]
Wie erzeugt eine Solarzelle Strom?
][
*Antwort:*
- Licht erzeugt im Halbleiter Elektron-Loch-Paare.
- Ein inneres elektrisches Feld trennt sie, sodass im äußeren Kreis ein Fotostrom fließt.
- Umgewandelt wird Strahlungsenergie in elektrische Energie.
#image("abbildungen/skript-foto.svg", width: 80%)
]

#aufgabe(titel: "Spannung und Leistung am Fotoelement", art: "rechnen", quelle: "1.2.4", herkunft: "eigen", minuten: 9,
  ergebnis: [$U = 2 thin "V"$, $P = 40 thin mu"W"$],
)[
#if not web [*Aufgabe 113* #linebreak()]
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

#aufgabe(titel: "Fotoeffekt in Silizium", art: "verstehen", quelle: "1.2.4.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 114* #linebreak()]
*Fotoeffekt, eigene Ergänzung zu V S. 18–19:* Silizium hat die Bandlücke 1,12 eV und die Grenzwellenlänge rund 1,11 µm. a) Können Photonen mit 850 nm bzw. 1550 nm im einfachen Bandlückenmodell Elektron-Loch-Paare erzeugen? b) Hilft bei ungeeigneter Wellenlänge einfach mehr Licht? Begründe mit der Energie eines Photons.
][
*Antwort:* a) 850 nm = 0,85 µm liegt unter der Grenzwellenlänge: im Modell genügend Energie. 1550 nm = 1,55 µm liegt darüber: zu wenig Energie. b) Mehr Photonen gleicher Wellenlänge ändern die Energie pro Photon $h c/lambda$ nicht; im einfachen Modell reicht mehr langwelliges Licht deshalb nicht.
][
*Ergänzung aus der früheren Quizfrage:* _Silizium hat eine Bandlücke von 1,12 eV, die Grenzwellenlänge liegt bei etwa 1,11 µm. Was passiert mit Licht der Wellenlänge 1,5 µm, wenn man die Lichtstärke verdoppelt?_

*Antwort:* Es erzeugt im einfachen Modell weiterhin keine Elektron-Loch-Paare.

*Begründung:* Für $lambda > lambda_g$ ist die Photonenergie $h c\/lambda$ kleiner als die Bandlücke, egal wie hell das Licht ist.

*Typische Verwechslung:*
- Es erzeugt dann doppelt so viele Elektron-Loch-Paare. – Mehr Licht heißt mehr Photonen, aber jedes einzelne hat immer noch zu wenig Energie.
- Es erzeugt Paare, aber nur halb so viele wie kurzwelliges Licht. – Unterhalb der Bandlücke gibt es im Modell überhaupt keine Erzeugung, nicht nur eine geringere.
][
*Ergänzung aus der früheren Karteikarte:* _Warum hilft bei zu langer Wellenlänge mehr Licht nicht?_

*Antwort:*
- Jedes Photon muss allein mindestens die Bandlücke $W$ überwinden: $h nu >= W$.
- Bei zu großer Wellenlänge ist die Energie jedes einzelnen Photons zu klein.
- Mehr Licht heißt nur mehr zu schwache Photonen.

*Merksatz:* Viele zu schwache Photonen ersetzen kein ausreichend energiereiches Photon.

*Bild:* Wer eine Mauer nicht überspringen kann, schafft es auch nicht, wenn hundert Leute nacheinander scheitern.
]

#aufgabe(titel: "Grenzwellenlänge für Germanium", art: "rechnen", quelle: "1.2.4.1", herkunft: "eigen", minuten: 12)[
#if not web [*Aufgabe 115* #linebreak()]
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
*Energie umrechnen:* $W = "0,67" dot.c "1,602176634" dot.c 10^(-19) thin "J" approx "1,07346" dot.c 10^(-19) thin "J"$.
][
*Einsetzen:* $lambda_g = (h c)/W = ("6,626" dot.c 10^(-34) thin "Js" dot.c 299792458 thin "m/s")/("1,07346" dot.c 10^(-19) thin "J") approx "1,8505" dot.c 10^(-6) thin "m"$.
][
*Ergebnis: rund 1,85 µm*, passend zur Tabelle. *Prüfung:* Js × m/s geteilt durch J ergibt m. Germanium hat eine kleinere Bandlücke als Silizium, deshalb liegt die Grenzwellenlänge weiter im Langwelligen.
]

#aufgabe(titel: "Direkter und umgekehrter Piezoeffekt", art: "verstehen", quelle: "1.2.5", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 116* #linebreak()]
*Piezoeffekt, eigene Verständnisfrage zu V S. 19:* Erkläre den direkten und den umgekehrten Effekt jeweils an einer Anwendung. Welche Material- und Richtungsbedingung musst du beachten?
][
*Direkt:* Eine mechanische Kraft auf den Kristall erzeugt ein elektrisches Signal, etwa beim Kristallmikrofon. Umgekehrt: Eine Spannung verformt den Kristall, etwa zur Ultraschallerzeugung. Der Kristall muss piezoelektrisch sein und in der passenden Richtung beansprucht werden.
][
*Ergänzung aus der früheren Karteikarte:* _Was ist der Piezoeffekt, und wie kann derselbe Effekt Sensor und Antrieb sein?_

*Antwort:*
- Drückt man auf einen geeigneten Kristall, verschieben sich Ladungen, es entsteht eine Spannung (Sensor, z. B. Mikrofon).
- Umgekehrt verformt eine angelegte Spannung den Kristall (Antrieb, z. B. Ultraschall, Schwingquarz).
- Es funktioniert nur mit piezoelektrischen Kristallen in der richtigen Richtung.
#image("abbildungen/skript-piezo.svg", width: 80%)
]

#aufgabe(titel: "Sekundentakt aus dem Schwingquarz", art: "verstehen", quelle: "1.2.5", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 117* #linebreak()]
Ein Schwingquarz in einer Uhr schwingt mit 32 768 Hz. Wie entsteht daraus der Sekundentakt? Begründe deine Antwort.
][
*Antwort:* Die Elektronik teilt die Frequenz durch $2^15$.

*Begründung:* $32768 = 2^15$; nach 15 Halbierungen bleibt 1 Hz. Der Quarz selbst schwingt weiter mit 32 768 Hz.
][
*Typische Verwechslung:*
- Der Quarz wird so lange gedämpft, bis er mit 1 Hz schwingt. – Ein Quarz schwingt mit seiner Eigenfrequenz. Gedämpft würde er nur aufhören.
- Der Quarz schwingt einmal pro Sekunde, die 32 768 Hz sind die Oberschwingung. – Die Grundschwingung ist 32 768 Hz. Der Sekundentakt kommt erst aus der Teilung.
]

#aufgabe(titel: "Takt aus dem Schwingquarz", art: "rechnen", quelle: "1.2.5", herkunft: "variante", vorlage: "Vorlesungsskript S. 19", minuten: 12,
  ergebnis: [$f_"Takt" = 2 thin "Hz"$, $T = "0,5" thin "s"$],
)[
#if not web [*Aufgabe 118* #linebreak()]
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

#aufgabe(titel: "Diode mit Vorwiderstand", art: "rechnen", quelle: "1.2.6", herkunft: "eigen", minuten: 12,
  ergebnis: [a) $I approx "20,9" thin "mA"$ b) $R = 690 thin Omega$],
  tipp: [Die Diode „verbraucht“ ihre 2,1 V. Was bleibt für den Widerstand übrig?],
)[
#if not web [*Aufgabe 119* #linebreak()]
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

#aufgabe(titel: "Zeitkonstante und Endstrom einer Spule", art: "verstehen", quelle: "1.2.6.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 120* #linebreak()]
Eine Spule ($L = 10 thin "mH"$) liegt mit $R = 10 thin Omega$ an 12 V. Wie groß ist die Zeitkonstante $tau$, und welcher Strom fließt nach sehr langer Zeit? Begründe deine Antwort.
][
*Antwort:* $tau = 1 thin "ms"$, Endstrom 1,2 A.

*Begründung:* $tau = L\/R = "0,01" thin "H"\/10 thin Omega = 1 thin "ms"$, $I_oo = U_q\/R = "1,2" thin "A"$.
][
*Typische Verwechslung:*
- $tau = 100 thin "s"$, Endstrom 1,2 A – Hier wurde $R\/L$ statt $L\/R$ gerechnet und mH nicht in H umgewandelt.
- $tau = 1 thin "ms"$, Endstrom 0 A, weil die Spule den Strom blockiert – Die Spule bremst nur die Änderung. Im eingeschwungenen Zustand begrenzt allein R den Strom.
- $tau = 1 thin "ms"$, Endstrom 0,76 A – 0,76 A fließen nach einer Zeitkonstante, also rund 63 % des Endstroms.
]

#aufgabe(titel: "Stromanstieg in der Spule", art: "verstehen", quelle: "1.2.6.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 121* #linebreak()]
Warum steigt der Strom in einer Spule nach dem Einschalten nur allmählich an?
][
*Antwort:*
- Die Spule wirkt jeder Stromänderung entgegen (Selbstinduktion).
- Der Strom wächst deshalb mit der Zeitkonstante $tau = L\/R$ an.
- Nach $tau$ ist er bei 63 %, nach $5 tau$ praktisch am Endwert.

*Merksatz:* Die Spule bremst Stromänderungen.
#image("abbildungen/rl-verlauf.svg", width: 80%)
][
*Bild:* Wie ein träges Schwungrad: Es widersetzt sich einer schnellen Änderung, nicht einem gleichbleibenden Zustand.
]

#aufgabe(titel: "Einschalten einer Spule", art: "rechnen", quelle: "1.2.6.1", herkunft: "eigen", minuten: 18)[
#if not web [*Aufgabe 122* #linebreak()]
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
*Endstrom:* $I_oo = U_q/R = 12 thin "V"/(10 thin Omega) = "1,2" thin "A"$.
][
*Zeitkonstante:* $tau = L/R = "0,010" thin "H"/(10 thin Omega) = 1 thin "ms"$.
][
*Lösung:* Bei $t = tau$: $i = "1,2" (1 - e^(-1)) thin "A" approx "0,759" thin "A"$; $u_L = 12 e^(-1) thin "V" approx "4,415" thin "V"$.
][
*Bei 20 Ω:* $I_oo = "0,6" thin "A"$, $tau = "0,5" thin "ms"$. Der Endstrom wird kleiner; sein relativer Aufbau erfolgt schneller.
][
*Ergebnis:* Nach 1 ms liegt der Strom bei *rund 0,759 A*. *Prüfung:* $R i + u_L approx "7,585" thin "V" + "4,415" thin "V" = 12 thin "V"$; H/Ω = (Vs/A)/(V/A) = s.
]

#aufgabe(titel: "Diode gegen ohmschen Widerstand", art: "verstehen", quelle: "1.2.6.2", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 123* #linebreak()]
Was unterscheidet eine Diode von einem ohmschen Widerstand?
][
*Antwort:*
- Eine Diode leitet in Durchlassrichtung viel besser als in Sperrrichtung.
- Ihre Kennlinie ist gekrümmt, keine Ursprungsgerade.
- Sie hat also keinen überall gleichen Widerstand.
- Den Arbeitspunkt findet man als Schnittpunkt von Diodenkennlinie und Arbeitsgerade.
#image("abbildungen/notiz-diode.svg", width: 80%)
]

#aufgabe(titel: "Potenzial braucht einen Bezugspunkt", art: "verstehen", quelle: "1.3", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 124* #linebreak()]
Warum braucht eine Potenzialangabe einen Bezugspunkt?
][
*Antwort:*
- Das Potenzial ist eine Spannung gegenüber einem festgelegten Nullpunkt.
- Ohne diesen Bezug ist die Zahl nicht eindeutig.
- Wie bei Höhenangaben kann man alle Werte gemeinsam verschieben, ohne die Unterschiede zu verändern.

*Merksatz:* Potenzial braucht einen Nullpunkt, Spannung braucht zwei Punkte.
#image("abbildungen/vl30-potential.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Du erklärst einen anderen Schaltungspunkt zur Masse. Was bleibt unverändert?_

*Antwort:* Die Spannung zwischen zwei unveränderten Punkten.

*Begründung:* Beide Potenziale verschieben sich um denselben Wert; ihre Differenz bleibt gleich.

*Typische Verwechslung:*
- Alle Potenzialzahlen. – Potenziale beziehen sich auf den gewählten Nullpunkt und ändern daher ihre Zahlenwerte.
- Nur negative Potenziale werden zu null. – Das Vorzeichen allein entscheidet nicht; alle Potenziale werden um denselben Betrag verschoben.
]

#aufgabe(titel: "Reihenfolge und Vorzeichen der Spannung", art: "verstehen", quelle: "1.3", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 125* #linebreak()]
Wie hängt die Reihenfolge A–B mit dem Vorzeichen der Spannung zusammen?
][
*Antwort:*
- $U_(A B) = phi_A - phi_B$.
- Liegt A niedriger als B, ist dieser Wert negativ.
- Beim Vertauschen der Punktreihenfolge ändert sich nur das Vorzeichen, nicht der Betrag.

*Merksatz:* Punkte vertauschen dreht das Spannungsvorzeichen um.
#image("abbildungen/vl30-bruecke.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _A liegt bei 5 V, B bei 8 V gegenüber derselben Masse. Wie groß ist die Spannung von A nach B?_

*Antwort:* −3 V.

*Begründung:* Es gilt $U_(A B) = phi_A - phi_B = 5 - 8$ V.

*Typische Verwechslung:*
- +3 V – Das ist die Spannung von B nach A. Die Reihenfolge der Punkte ist vertauscht.
- 13 V – Die Potenziale werden zur Spannungsbildung subtrahiert, nicht addiert.
]

#aufgabe(titel: "Querwiderstand zwischen zwei Teilern", art: "verstehen", quelle: "1.3", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 126* #linebreak()]
Warum verändert ein Querwiderstand die Potenziale zweier Spannungsteiler?
][
*Antwort:*
- Er verbindet die vorher getrennten Abgriffe und lässt einen zusätzlichen Strom fließen.
- Dadurch ändern sich die Knotenbilanzen und die Spannungsaufteilungen.
- Die unbelasteten Potenziale sind keine starren Spannungsquellen.
#image("abbildungen/vl30-bruecke.svg", width: 80%)
]

#aufgabe(titel: "Netz mit zwei Quellen: Ströme und Potenziale", art: "rechnen", quelle: "1.3", herkunft: "original", vorlage: "Aufgabe GET (jk), Netz mit zwei Quellen", minuten: 12, platz: 14,
  ergebnis: [$phi_B = 20 thin "V"$, $phi_A = 12 thin "V"$; $I_3 = 2 thin "A"$, $I_4 = 1 thin "A"$, $I_5 = "0,5" thin "A"$; durch R2 und R1 fließt 1 A von B nach links; $U_(R 2) = 8 thin "V"$, $U_(R 1) = 2 thin "V"$; Uq2 liefert 4,5 A],
  tipp: [Uq2 liegt direkt parallel zu R3, R4 und R5. Was bedeutet das für das Potenzial von B?],
)[
#if not web [*Aufgabe 127* #linebreak()]
*Gegeben und Annahmen*

Ideale Quellen $U_(q 1) = 10 thin "V"$ (links) und $U_(q 2) = 20 thin "V"$ (rechts), beide Plus oben; die untere Leitung ist Masse (0 V). $R_1 = 2 thin Omega$, $R_2 = 8 thin Omega$, $R_3 = 10 thin Omega$, $R_4 = 20 thin Omega$, $R_5 = 40 thin Omega$.

#image("abbildungen/neue-zwei-quellen-ab.svg", width: 95%)

*Gesucht*

#enum(numbering: "a)",
[Trage alle Ströme und alle Spannungen nach Betrag und Richtung in das Netzwerk ein.],
[Welche Potenziale stellen sich an den Punkten A und B ein?],
)
][
*Potenzial von B:* Die ideale Quelle $U_(q 2)$ liegt zwischen B und Masse. Sie hält B fest auf $phi_B = 20 thin "V"$, egal welche Ströme fließen.
][
*Parallelzweige:* An R3, R4, R5 liegen je 20 V (von oben nach unten): $I_3 = 20\/10 = 2 thin "A"$, $I_4 = 20\/20 = 1 thin "A"$, $I_5 = 20\/40 = "0,5" thin "A"$, alle nach unten.
][
*Linker Zweig:* Zwischen B (20 V) und dem Pluspol von $U_(q 1)$ (10 V) liegen R2 und R1 in Reihe. $I = (20 - 10) thin "V"\/(8 + 2) thin Omega = 1 thin "A"$, technisch von B nach links. Spannungen in Stromrichtung: $U_(R 2) = 8 thin "V"$, $U_(R 1) = 2 thin "V"$. Die Quelle $U_(q 1)$ wird dabei von oben nach unten durchflossen, sie nimmt also Leistung auf (10 W, sie wird „geladen“).
][
*b) Potenzial von A:* Von der Quelle $U_(q 1)$ aus gegen die Stromrichtung durch R1: $phi_A = 10 thin "V" + 1 thin "A" dot.c 2 thin Omega = 12 thin "V"$. Gegenprobe von B: $20 - 8 = 12 thin "V"$.
][
*Knoten B prüfen:* $U_(q 2)$ liefert $2 + 1 + "0,5" + 1 = "4,5" thin "A"$ nach oben in den Knoten. Leistungsbilanz: $U_(q 2)$ gibt $20 dot.c "4,5" = 90 thin "W"$ ab; aufgenommen werden 40 W, 20 W und 10 W in R3, R4, R5, 8 W und 2 W in R2 und R1 sowie 10 W in $U_(q 1)$, zusammen 90 W.
]

#aufgabe(titel: "Netz mit zwei Quellen, 24 V und 12 V (Variante)", art: "rechnen", quelle: "1.3", herkunft: "variante", vorlage: "Aufgabe GET (jk), Netz mit zwei Quellen", minuten: 12, platz: 14,
  ergebnis: [$phi_B = 12 thin "V"$, $phi_A = 20 thin "V"$; $I_(12) = 1 thin "A"$ von links nach B; $I_3 = 1 thin "A"$, $I_4 = "0,5" thin "A"$, $I_5 = 2 thin "A"$; Uq2 liefert 2,5 A],
)[
#if not web [*Aufgabe 128* #linebreak()]
*Gegeben und Annahmen*

Gleiche Schaltung wie im Bild, untere Leitung Masse: $U_(q 1) = 24 thin "V"$, $U_(q 2) = 12 thin "V"$ (beide Plus oben), $R_1 = 4 thin Omega$, $R_2 = 8 thin Omega$, $R_3 = 12 thin Omega$, $R_4 = 24 thin Omega$, $R_5 = 6 thin Omega$.

#image("abbildungen/neue-zwei-quellen-ab.svg", width: 95%)

*Gesucht*

#enum(numbering: "a)",
[Alle Ströme und Spannungen nach Betrag und Richtung.],
[Potenziale an A und B.],
[Liefert oder nimmt $U_(q 2)$ Leistung auf?],
)
][
*B festgelegt:* $phi_B = U_(q 2) = 12 thin "V"$. Parallelzweige: $I_3 = 1 thin "A"$, $I_4 = "0,5" thin "A"$, $I_5 = 2 thin "A"$, alle nach unten.
][
*Linker Zweig:* $I = (24 - 12)\/(4 + 8) = 1 thin "A"$, diesmal von $U_(q 1)$ nach B, weil links das höhere Potenzial liegt. $U_(R 1) = 4 thin "V"$, $U_(R 2) = 8 thin "V"$.
][
*b) A:* $phi_A = 24 - 4 = 20 thin "V"$ (Gegenprobe $12 + 8 = 20 thin "V"$).
][
*c) Knoten B:* Abfließend $1 + "0,5" + 2 = "3,5" thin "A"$, zufließend aus links 1 A. $U_(q 2)$ muss $"2,5" thin "A"$ nach oben liefern, gibt also $12 dot.c "2,5" = 30 thin "W"$ ab. $U_(q 1)$ gibt 24 W ab. Summe 54 W = $12 + 6 + 24 + 4 + 8 thin "W"$ in den Widerständen.
]

#aufgabe(titel: "Potenzialtreppe mit frei gewählter Masse", art: "rechnen", quelle: "1.3", herkunft: "original", vorlage: "Vorlesungsskript S. 20", minuten: 10,
 ergebnis: [$U_q = 90 thin "V"$; $R_1 = 3 thin "k"Omega$, $R_2 = 2 thin "k"Omega$, $R_3 = 4 thin "k"Omega$.], tipp: [Beginne bei D und gehe mit bzw. gegen die Spannungsabfälle.])[
#if not web [*Aufgabe 129* #linebreak()]
*Gegeben und Annahmen:* Reihenschaltung aus drei Widerständen, $I = 10 thin "mA"$. In technischer Stromrichtung lautet die Reihenfolge: B → C (idealer Draht) → R1 → D → R2 → E → R3 → F → A (idealer Draht). Die Spannungsabfälle sind $U_1 = 30 thin "V"$, $U_2 = 20 thin "V"$, $U_3 = 40 thin "V"$. Die Quelle verbindet A zurück mit B. Bezugspunkt D: 0 V.
*Gesucht:*
#enum(numbering: "a)")[Potenziale von A bis F und Quellspannung.][Widerstände R1 bis R3.][Als eigene Variation: Potenziale mit E als neuem Nullpunkt und die dabei unveränderte Spannung zwischen B und A.]
#src[N30, PDF-S. 1 = V S. 20; Teil c eigene Variation.]
][*Bezugspunkt festlegen:* D hat 0 V. Gegen die Stromrichtung über R1 steigt das Potenzial um 30 V. Daher sind $phi_C = phi_B = 30 thin "V"$. Hinter R2 liegt $phi_E = -20 thin "V"$, hinter R3 $phi_F = phi_A = -60 thin "V"$. Ideale Drähte ändern das Potenzial nicht.
][*Quellspannung bestimmen:* Die Quelle hebt das Potenzial von A nach B an. $U_q = phi_B - phi_A = 30 - (-60) = 90 thin "V"$. Das stimmt mit $30 + 20 + 40 = 90$ V aus den Widerständen überein.
][*Ohmsches Gesetz anwenden:* Jeder Widerstand führt denselben Strom 0,010 A. Deshalb $R_1 = 30/"0,010" = 3000 thin Omega$, $R_2 = 2000 thin Omega$ und $R_3 = 4000 thin Omega$. Spannung geteilt durch Strom ergibt Ω.
][*Nullpunkt verschieben und prüfen:* E lag bisher bei −20 V. Addiere zu allen Potenzialen 20 V: B und C = 50 V, D = 20 V, E = 0 V, A und F = −40 V. $U_(B A) = 50 - (-40) = 90 thin "V"$ bleibt gleich. Nur die Bezugswerte, nicht die Spannungsdifferenzen, ändern sich.]

#aufgabe(titel: "Potenzialtreppe mit 5 mA (Variante)", art: "rechnen", quelle: "1.3", herkunft: "variante", vorlage: "Vorlesungsskript S. 20", minuten: 8,
  ergebnis: [$phi_B = phi_C = 12 thin "V"$, $phi_D = 0$, $phi_E = -8 thin "V"$, $phi_F = phi_A = -28 thin "V"$; $U_q = 40 thin "V"$; $R_1 = "2,4" thin "k"Omega$, $R_2 = "1,6" thin "k"Omega$, $R_3 = 4 thin "k"Omega$],
)[
#if not web [*Aufgabe 130* #linebreak()]
*Gegeben und Annahmen*

Reihenschaltung aus drei Widerständen an einer idealen Quelle, $I = 5 thin "mA"$. In technischer Stromrichtung lautet die Reihenfolge: B → C (idealer Draht) → R1 → D → R2 → E → R3 → F → A (idealer Draht); die Quelle verbindet A zurück mit B. Spannungsabfälle $U_1 = 12 thin "V"$, $U_2 = 8 thin "V"$, $U_3 = 20 thin "V"$. Bezugspunkt D = 0 V.

*Gesucht*

#enum(numbering: "a)",
[Potenziale A bis F und Quellspannung.],
[Widerstände R1 bis R3.],
[Potenziale, wenn E zum Nullpunkt erklärt wird; Spannung zwischen B und A.],
)
][
*Treppe ablaufen:* In Stromrichtung sinkt das Potenzial an jedem Widerstand um dessen Spannung. Von D (0 V) gegen die Stromrichtung durch R1: $phi_C = phi_B = 12 thin "V"$. In Stromrichtung: $phi_E = -8 thin "V"$, $phi_F = phi_A = -28 thin "V"$.
][
*Quelle:* $U_q = phi_B - phi_A = 12 - (-28) = 40 thin "V" = 12 + 8 + 20 thin "V"$.
][
*Widerstände:* $R_k = U_k\/I$: $R_1 = 12\/"0,005" = 2400 thin Omega$, $R_2 = 1600 thin Omega$, $R_3 = 4000 thin Omega$.
][
*Neuer Nullpunkt E:* Alle Potenziale um +8 V verschieben: B, C = 20 V; D = 8 V; E = 0; A, F = −20 V. $U_(B A) = 40 thin "V"$ bleibt: Spannungen sind Differenzen und hängen nicht vom Bezugspunkt ab.
]

#aufgabe(titel: "Zwei Spannungsteiler und ein offener Querzweig", art: "rechnen", quelle: "1.3", herkunft: "original", vorlage: "Vorlesungsskript S. 21", minuten: 8,
 ergebnis: [$phi_A = 5 thin "V"$, $phi_B = 8 thin "V"$, $U_(A B) = -3 thin "V"$.], tipp: [Die Ausgangsspannung jedes offenen Teilers liegt am unteren Widerstand.])[
#if not web [*Aufgabe 131* #linebreak()]
*Gegeben und Annahmen:* Beide Zweige liegen an einer idealen 10-V-Quelle. Zwischen den oberen 10 V und A liegen 5 Ω, zwischen A und Masse weitere 5 Ω. Zwischen den oberen 10 V und B liegen 2 Ω, zwischen B und Masse 8 Ω. A und B sind zunächst nicht verbunden.
*Gesucht:*
#enum(numbering: "a)")[Potenziale A und B sowie die vorzeichenrichtigen Spannungen UAB und UBA.][Richtung eines Stroms beim Anschließen eines Querwiderstands zwischen A und B.][Warum die beiden unbelasteten Potenziale dann nicht unverändert eingesetzt werden dürfen.]
#src[N30, PDF-S. 2 = V S. 21.]
][*Unbelastete Teiler auswerten:* Jeder Zweig hat insgesamt 10 Ω und führt deshalb 1 A. A liegt um $1 thin "A" dot.c 5 thin Omega = 5 thin "V"$ über Masse, B um $1 thin "A" dot.c 8 thin Omega = 8 thin "V"$.
][*Spannungsrichtung beachten:* $U_(A B) = phi_A - phi_B = -3 thin "V"$, $U_(B A) = +3 thin "V"$. Ein passiver Querwiderstand lässt den technischen Strom vom zunächst höheren Potenzial B nach A fließen.
][*Belastung erklären:* Der Querzweig verändert die Knotenbilanzen. Die oberen und unteren Widerstände eines ursprünglichen Teilers führen dann nicht mehr zwangsläufig denselben Strom. Die neue Schaltung braucht gekoppelte Knoten- oder Maschengleichungen; die offenen Werte sind dafür keine feste Spannungsquelle.]

#aufgabe(titel: "Zwei Teiler an 12 V und ihre Potenziale (Variante)", art: "rechnen", quelle: "1.3", herkunft: "variante", vorlage: "Vorlesungsskript S. 21", minuten: 6,
  ergebnis: [$phi_A = 9 thin "V"$, $phi_B = 6 thin "V"$, $U_(A B) = +3 thin "V"$; ein Querwiderstand führt Strom von A nach B],
)[
#if not web [*Aufgabe 132* #linebreak()]
*Gegeben und Annahmen*

Zwei Zweige liegen an einer idealen 12-V-Quelle (Minus = Masse). Linker Zweig: oben 3 Ω bis A, von A nach Masse 9 Ω. Rechter Zweig: oben 6 Ω bis B, von B nach Masse 6 Ω. A und B sind nicht verbunden.

*Gesucht*

#enum(numbering: "a)",
[Potenziale von A und B, Spannungen $U_(A B)$ und $U_(B A)$.],
[In welche Richtung fließt Strom, wenn ein Widerstand zwischen A und B geschaltet wird?],
)
][
*Unbelastete Teiler:* Jeder Zweig hat 12 Ω und führt 1 A. $phi_A = 1 thin "A" dot.c 9 thin Omega = 9 thin "V"$, $phi_B = 1 thin "A" dot.c 6 thin Omega = 6 thin "V"$.
][
*Vorzeichen:* $U_(A B) = phi_A - phi_B = +3 thin "V"$, $U_(B A) = -3 thin "V"$.
][
*Querstrom:* Ein passiver Widerstand lässt technischen Strom vom höheren Potenzial A zum niedrigeren B fließen. Danach stimmen die Teilerformeln nicht mehr, weil oberer und unterer Widerstand nicht mehr denselben Strom führen.
]

#aufgabe(titel: "Materialwerte brauchen eine Temperatur", art: "verstehen", quelle: "1.4.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 133* #linebreak()]
Warum darfst du Materialwerte für den Drahtwiderstand nicht ohne Temperaturangabe verwenden?
][
*Antwort:* Der spezifische Widerstand ist temperaturabhängig. Die Tabelle dieses Abschnitts gilt bei 20 °C. Für eine andere Temperatur muss das passende Temperaturmodell oder der passende Materialwert verwendet werden.
]

#aufgabe(titel: "Leitwert und spezifische Leitfähigkeit", art: "verstehen", quelle: "1.4.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 134* #linebreak()]
Wie unterscheiden sich Leitwert und spezifische Leitfähigkeit?
][
*Antwort:*
- Der Leitwert $G = 1/R$ gehört zum konkreten Bauteil und hat die Einheit Siemens.
- Die Leitfähigkeit $kappa$ ist ein Materialwert.
- Erst Geometrie und Material zusammen liefern $G = kappa A/l$.
][
*Ergänzung aus der früheren Quizfrage:* _Was unterscheidet Leitwert und Leitfähigkeit?_

*Antwort:* Der Leitwert gehört zum konkreten Bauteil, die Leitfähigkeit zum Material.

*Begründung:* Die Geometrie geht in $G = kappa A/l$ zusätzlich zum Materialwert ein.

*Typische Verwechslung:*
- Beide sind derselbe Wert mit anderem Namen. – Sie haben verschiedene Einheiten und beziehen sich auf verschiedene Größen.
- Der Leitwert wächst mit dem Widerstand. – $G = 1/R$: Größerer Widerstand bedeutet kleineren Leitwert.
]

#aufgabe(titel: "Spannungsabfall ist nicht alles", art: "verstehen", quelle: "1.4.2", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 135* #linebreak()]
Warum beweist ein ausreichend kleiner Spannungsabfall noch nicht die vollständige Eignung eines Leiterquerschnitts?
][
*Antwort:* Die Spannungsabfallrechnung prüft nur ein Auslegungskriterium. Die thermische Belastbarkeit muss zusätzlich zur tatsächlichen Anwendung passen; V S. 24 fordert diese Prüfung ausdrücklich.
]

#aufgabe(titel: "Hin- und Rückleiter zählen", art: "verstehen", quelle: "1.4.2", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 136* #linebreak()]
Warum muss man bei einer Zweidrahtleitung Hin- und Rückleiter zählen?
][
*Antwort:*
- Der Strom muss auch von der Last zur Quelle zurückkehren.
- Beide Leiter haben Widerstand und verursachen Spannungsabfall.
- Die gesamte wirksame Länge ist deshalb die Summe beider Leiterlängen.

*Merksatz:* Der Strom muss hin und zurück.
#image("abbildungen/vl30-leitung.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Eine Motorzuleitung ist 25 m lang und hat Hin- und Rückleiter. Welche Leiterlänge zählt für den gesamten Spannungsabfall?_

*Antwort:* 50 m.

*Begründung:* Der Strom fließt über 25 m hin und 25 m zurück; beide Widerstände liegen in Reihe.

*Typische Verwechslung:*
- 25 m – Das zählt nur einen der beiden Leiter.
- 12,5 m – Die Aufteilung auf zwei Leiter halbiert nicht die gesamte Strecke.
]

#aufgabe(titel: "Motorzuleitung: Querschnitt und Potenziale", art: "rechnen", quelle: "1.4.2", herkunft: "original", vorlage: "Vorlesungsskript S. 23–24", minuten: 12,
 ergebnis: [$A_"min" = "4,45" thin "mm"^2$; gewählt 6 mm²; dann $U_M approx "217,03" thin "V"$.], tipp: [Zähle die Länge beider Leiter oder rechne mit 2 V und 25 m pro Leiter.])[
#if not web [*Aufgabe 137* #linebreak()]
*Gegeben und Annahmen:* Ideale Quelle mit 220 V, Motorstrom konstant 20 A. Kupfer-Hinleiter und -Rückleiter sind je 25 m lang und haben gleichen Querschnitt. $rho = "0,0178" thin Omega thin "mm"^2/"m"$. Am Motor sollen mindestens 216 V anliegen. Verfügbare Querschnitte: 1; 1,5; 2,5; 4; 6; 10 mm². A liegt am Quellenplus, B am Motorplus, C am Motorminus, D am Quellenminus; C ist Masse.
*Gesucht:*
#enum(numbering: "a)")[Maximaler gesamter Leitungswiderstand, Mindestquerschnitt und Auswahl aus der Reihe.][Potenziale A, B, C und D im Grenzfall mit genau 2 V Abfall je Leiter.][Als Nachrechnung: tatsächliche Motorspannung bei 6 mm² und weiterhin 20 A; welche zusätzliche Prüfung zur realen Auslegung fehlt.]
#src[N30, PDF-S. 4–5 = V S. 23–24; Nachrechnung mit 6 mm² ergänzt.]
][*Spannungsbudget wählen:* Von 220 V dürfen 4 V auf der Leitung bleiben. Da Hin- und Rückleiter in Reihe liegen, gilt $R_"L,ges,max" = 4 thin "V"/(20 thin "A") = "0,2" thin Omega$, also 0,1 Ω je Leiter.
][*Geometrie berechnen:* Für die gesamte Leiterlänge 50 m gilt $A_"min" = rho l/R = "0,0178" dot.c 50/"0,2" thin "mm"^2 = "4,45" thin "mm"^2$. 4 mm² reichen nicht; aus der Reihe sind *6 mm²* zu wählen.
][*Potenziale mit C = 0 bestimmen:* Am Motor liegt B um 216 V höher: $phi_B = 216 thin "V"$. Der Hinleiter führt von A nach B und verliert 2 V, also $phi_A = 218 thin "V"$. Der Rückleiter führt von C nach D und verliert 2 V, also $phi_D = -2 thin "V"$. Prüfung: $phi_A - phi_D = 220 thin "V"$.
][*Gewählten Querschnitt nachrechnen:* $R_"L,ges" = "0,0178" dot.c 50/6 approx "0,1483" thin Omega$. Bei 20 A fallen insgesamt rund 2,967 V ab, also $U_M approx "217,03" thin "V"$. Das erfüllt die Spannungsforderung. Die thermische Belastbarkeit muss zusätzlich geprüft werden; die Potenziale aus Teil b gehören zum dort angenommenen Grenzfall und sind nicht unverändert die Werte dieser Nachrechnung.]

#aufgabe(titel: "Zuleitung für 16 A: Querschnitt und Potenziale (Variante)", art: "rechnen", quelle: "1.4.2", herkunft: "variante", vorlage: "Vorlesungsskript S. 23–24", minuten: 12,
  ergebnis: [$A_"min" approx "3,42" thin "mm"^2$ → 4 mm²; Grenzfall $phi_A = "227,5" thin "V"$, $phi_B = 225 thin "V"$, $phi_D = -"2,5" thin "V"$; mit 4 mm² $U_M approx "225,7" thin "V"$],
)[
#if not web [*Aufgabe 138* #linebreak()]
*Gegeben und Annahmen*

Ideale Quelle 230 V, Verbraucherstrom konstant 16 A. Hin- und Rückleiter aus Kupfer, je 30 m lang, gleicher Querschnitt; $rho = "0,0178" thin Omega thin "mm"^2\/"m"$. Am Verbraucher sollen mindestens 225 V anliegen. Verfügbare Querschnitte: 1,5; 2,5; 4; 6 mm². A = Quellenplus, B = Verbraucherplus, C = Verbraucherminus (Masse), D = Quellenminus.

*Gesucht*

#enum(numbering: "a)",
[Höchster gesamter Leitungswiderstand, Mindestquerschnitt und Auswahl.],
[Potenziale A, B, C, D im Grenzfall (je Leiter genau die halbe zulässige Spannung).],
[Verbraucherspannung mit dem gewählten Querschnitt.],
)
][
*Spannungsbudget:* Von 230 V dürfen 5 V auf beiden Leitern zusammen abfallen: $R_"L,max" = 5 thin "V"\/16 thin "A" = "0,3125" thin Omega$.
][
*Querschnitt:* Gesamtlänge 60 m (Hin und Rück!): $A_"min" = rho l\/R = "0,0178" dot.c 60\/"0,3125" approx "3,42" thin "mm"^2$. Gewählt wird der nächstgrößere Wert *4 mm²*.
][
*Potenziale im Grenzfall (C = 0):* $phi_B = 225 thin "V"$; Hinleiter verliert 2,5 V: $phi_A = "227,5" thin "V"$; Rückleiter von C nach D: $phi_D = -"2,5" thin "V"$. Kontrolle $phi_A - phi_D = 230 thin "V"$.
][
*Nachrechnen mit 4 mm²:* $R_L = "0,0178" dot.c 60\/4 = "0,267" thin Omega$, Abfall $16 dot.c "0,267" = "4,27" thin "V"$, $U_M approx "225,7" thin "V" >= 225 thin "V"$. Die thermische Belastbarkeit wäre zusätzlich zu prüfen.
]

#aufgabe(titel: "PTC und NTC: Wärme kann Ursache und Folge sein", art: "verstehen", quelle: "1.4.3", herkunft: "eigen", minuten: 3,
 ergebnis: [PTC: Widerstand steigt bei Wärme; NTC: Widerstand sinkt.], tipp: [Unterscheide äußere Temperatur und Erwärmung durch die Messung selbst.])[
#if not web [*Aufgabe 139* #linebreak()]
Erkläre den Unterschied zwischen PTC und NTC. Warum kann eine Glühlampe beim Einschalten einen hohen Strom ziehen? Warum soll sich ein NTC zur Temperaturmessung möglichst wenig selbst erwärmen?
#src[N30, PDF-S. 7–8 = V S. 26–27.]
][*Temperaturrichtung trennen:* Beim PTC steigt der Widerstand mit der Temperatur, beim NTC sinkt er. Die Namen beziehen sich auf den Temperaturkoeffizienten, nicht auf die Höhe einer fest vorgegebenen Spannung.
][*Einschalten erklären:* Die kalte Wolframwendel hat einen viel kleineren Widerstand als im heißen Betrieb. Bei gleicher anliegender Spannung kann zunächst ein größerer Strom fließen. Die genaue Stromänderung hängt zusätzlich vom übrigen Stromkreis ab.
][*Messung prüfen:* Ein Messstrom erzeugt Verlustwärme. Erwärmt diese den NTC deutlich, misst er nicht mehr nur die Umgebungstemperatur. Seine Messleistung muss deshalb klein genug sein.]

#aufgabe(titel: "Gerade Kennlinie und konstanter Widerstand", art: "verstehen", quelle: "1.4.3.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 140* #linebreak()]
Wann darfst du aus einer geraden I-U-Kennlinie einen konstanten Widerstand folgern? Begründe deine Antwort.
][
*Antwort:* Für die Ursprungsgerade unter den betrachteten festen Bedingungen.

*Begründung:* Die konstante Steigung bedeutet konstanten Leitwert; eine andere Temperatur kann eine andere Gerade ergeben.
][
*Typische Verwechslung:*
- Immer und für jede Temperatur. – Temperaturänderungen können das Material und damit den Widerstandswert verändern.
- Nur wenn der Strom null ist. – Am Ursprung allein ist der Quotient U/I nicht bestimmbar. Die Gerade beschreibt gerade die weiteren Betriebspunkte.
][
*Ergänzung aus der früheren Karteikarte:* _Bedeutet eine lineare Kennlinie auch Temperaturunabhängigkeit?_

*Antwort:*
- Nein.
- Eine Ursprungsgerade beschreibt ein konstantes Verhältnis von Spannung zu Strom unter den betrachteten Bedingungen.
- Eine andere Temperatur kann den Widerstandswert ändern und zu einer anderen Geraden führen.
]

#aufgabe(titel: "Was beim nichtlinearen Widerstand anders ist", art: "verstehen", quelle: "1.4.3.2", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 141* #linebreak()]
Was ändert sich bei einem nichtlinearen Widerstand grundsätzlich? Begründe deine Antwort.
][
*Antwort:* Die Strom-Spannungs-Beziehung ist keine Ursprungsgerade mit überall gleichem Widerstand.

*Begründung:* Der Arbeitspunkt muss aus der Kennlinie oder einer passenden Bauteilgleichung bestimmt werden.
][
*Typische Verwechslung:*
- Die Knotenregel gilt nicht mehr. – Die Ladungsbilanz gilt weiterhin.
- Die Maschenregel darf nicht mehr verwendet werden. – Die Spannungsbilanz bleibt im betrachteten Netzwerkmodell gültig.
]

#aufgabe(titel: "U durch I ist kein fester Widerstand", art: "verstehen", quelle: "1.4.3.2", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 142* #linebreak()]
Warum darfst du den Quotienten U durch I eines nichtlinearen Bauteils nicht als festen Widerstand für alle Ströme benutzen?
][
*Antwort:* Der Quotient beschreibt nur den ausgewählten Arbeitspunkt. Bei einem anderen Strom liegt ein anderer Punkt auf der gekrümmten Kennlinie; Spannung und Quotient müssen neu bestimmt werden.
]

#aufgabe(titel: "Lampenfaktoren gelten nicht für echte Glühlampen", art: "verstehen", quelle: "1.4.3.2.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 143* #linebreak()]
Warum gelten die festen Leistungsfaktoren der einfachen Lampenrechnung nicht automatisch für echte Glühlampen?
][
*Antwort:* Die Rechnung setzt einen unveränderten Widerstand voraus. Ein echter Wolframfaden erwärmt sich und verändert seinen Widerstand. Die qualitative Aussage heller oder dunkler kann stimmen, während der genaue Leistungsfaktor vom konstanten Modell abweicht.
]

#aufgabe(titel: "Kalte Glühwendel und Einschaltstrom", art: "verstehen", quelle: "1.4.3.2.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 144* #linebreak()]
Warum lässt eine kalte Glühwendel besonders viel Strom zu?
][
*Antwort:*
- *Wolfram ist ein Kaltleiter:* Sein Widerstand ist kalt kleiner und wächst beim Erwärmen.
- Bei derselben anliegenden Spannung kann deshalb unmittelbar nach dem Einschalten mehr Strom fließen.
- Feste Leistungsfaktoren aus einem konstanten Widerstandsmodell sind für echte Glühlampen nur Näherungen.
#image("abbildungen/vl30-ptc.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Warum ist der Strom einer Wolfram-Glühwendel direkt beim Einschalten oft besonders hoch?_

*Antwort:* Die kalte Wendel hat einen kleineren Widerstand als im heißen Betrieb.

*Begründung:* Wolfram ist ein Kaltleiter; bei Wärme steigt sein Widerstand.

*Typische Verwechslung:*
- Der heiße Draht hat einen kleineren Widerstand. – Das wäre das Verhalten eines Heißleiters und kehrt hier die Temperaturwirkung um.
- Die Quelle muss beim Einschalten ihre Spannung verdoppeln. – Eine solche Spannungsänderung wird für die Erklärung nicht benötigt.
]

#aufgabe(titel: "Kelvin im NTC-Modell", art: "verstehen", quelle: "1.4.3.2.2", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 145* #linebreak()]
Warum müssen im NTC-Exponentialmodell Kelvinwerte stehen?
][
*Antwort:*
- Das Modell verwendet die Kehrwerte absoluter Temperaturen.
- Celsius besitzt einen verschobenen Nullpunkt und liefert dafür andere, falsche Quotienten.
- Mit Temperaturen und B-Konstante in Kelvin wird der Exponent dimensionslos.
#image("abbildungen/vl30-ntc.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Welche Temperaturen gehören in die NTC-Gleichung mit den Kehrwerten eins durch T?_

*Antwort:* Absolute Temperaturen in Kelvin.

*Begründung:* Nur diese passen zum angegebenen Exponentialmodell; der Exponent muss einheitenlos sein.

*Typische Verwechslung:*
- Celsiuszahlen wie 20 oder 100. – Die verschobene Celsius-Skala darf hier nicht als absoluter Kehrwert verwendet werden.
- Nur die Temperaturdifferenz. – Die Gleichung enthält die beiden absoluten Kehrwerte, nicht nur ihre Differenz als Temperaturanstieg.
]

#aufgabe(titel: "Selbsterwärmung des Messheißleiters", art: "verstehen", quelle: "1.4.3.2.2", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 146* #linebreak()]
Warum soll sich ein Messheißleiter möglichst wenig selbst erwärmen?
][
*Antwort:*
- Sein Widerstand soll die gesuchte äußere Temperatur abbilden.
- Eigene Verlustwärme verändert seine Temperatur zusätzlich und verfälscht damit den Messwert.
- Der Messstrom wird deshalb so gewählt, dass die Selbsterwärmung klein bleibt.
][
*Ergänzung aus der früheren Quizfrage:* _Warum kann ein zu großer Messstrom die NTC-Temperaturmessung verfälschen?_

*Antwort:* Der Strom erzeugt Verlustwärme und erwärmt das Messbauteil selbst. Dadurch ändert sich dessen Widerstand zusätzlich zur Umgebungstemperatur. Die Messleistung muss deshalb klein genug sein.
]

#aufgabe(titel: "NTC-Widerstand mit Kelvin im Exponenten", art: "rechnen", quelle: "1.4.3.2.2", herkunft: "original", vorlage: "Vorlesungsskript S. 27", minuten: 8,
 ergebnis: [$R(373 thin "K") approx "1,29" thin "k"Omega$.], tipp: [Ein größerer Kelvinwert hat einen kleineren Kehrwert.])[
#if not web [*Aufgabe 147* #linebreak()]
*Gegeben und Annahmen:* NTC-Modell $R(T) = R_(T_0) e^(B(1/T-1/T_0))$, $R_(T_0) = 10 thin "k"Omega$, $T_0 = 293 thin "K"$, $B = 2800 thin "K"$. Zieltemperatur 373 K; Selbsterwärmung vernachlässigt.
*Gesucht:*
#enum(numbering: "a)")[Widerstand bei 373 K.][Vorzeichen und Einheit des Exponenten.][Einordnung der groben Angabe 1,5 kΩ aus der Skriptskizze.]
#src[N30, PDF-S. 8 = V S. 27.]
][*Modell auswählen:* Der angegebene NTC folgt einer Exponentialbeziehung. Die Temperaturen sind bereits in Kelvin gegeben und dürfen direkt als Kehrwerte eingesetzt werden.
][*Dimensionslosen Exponenten bilden:* $x = 2800 thin "K" dot.c (1/(373 thin "K") - 1/(293 thin "K")) approx -"2,050"$. Die Einheiten K kürzen sich; der Exponent ist negativ, weil 373 K größer als die Bezugstemperatur ist.
][*Einsetzen und prüfen:* $R = 10 thin "k"Omega dot.c e^(-"2,050") approx "1,29" thin "k"Omega$. Der Widerstand sinkt, wie es für einen NTC sein muss. Die Skizzenangabe 1,5 kΩ ist eine grobe Kennlinienbeschriftung; die Rechnung mit diesen Parametern ergibt etwa 1,29 kΩ.]

#aufgabe(titel: "NTC bei 50 °C (Variante)", art: "rechnen", quelle: "1.4.3.2.2", herkunft: "variante", vorlage: "Vorlesungsskript S. 27", minuten: 6,
  ergebnis: [$R(323 thin "K") approx "1,89" thin "k"Omega$],
)[
#if not web [*Aufgabe 148* #linebreak()]
*Gegeben und Annahmen*

NTC-Modell $R(T) = R_(T_0) e^(B(1\/T - 1\/T_0))$ mit $R_(T_0) = "4,7" thin "k"Omega$ bei $T_0 = 298 thin "K"$ (25 °C) und $B = 3500 thin "K"$. Selbsterwärmung vernachlässigt.

*Gesucht*

#enum(numbering: "a)",
[Widerstand bei 50 °C.],
[Warum müssen die Temperaturen in Kelvin eingesetzt werden?],
)
][
*Temperatur umrechnen:* $T = 50 + 273 = 323 thin "K"$. Im Modell stehen Kehrwerte absoluter Temperaturen.
][
*Exponent:* $x = 3500 thin "K" dot.c (1\/323 - 1\/298) thin "K"^(-1) approx -"0,909"$; dimensionslos und negativ, weil es wärmer als bei $T_0$ ist.
][
*Ergebnis:* $R = "4,7" thin "k"Omega dot.c e^(-"0,909") approx "1,89" thin "k"Omega$. Wärmer → kleiner, wie beim Heißleiter erwartet.
][
*Kelvin begründen:* $1\/T$ mit Celsiuswerten wäre bei 0 °C unendlich und hätte keine physikalische Bedeutung; nur die absolute Temperatur passt zum Modell.
]

#aufgabe(titel: "Varistor bei doppelter Spannung", art: "verstehen", quelle: "1.4.3.2.3", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 149* #linebreak()]
Beim Varistormodell ist der Strom proportional zur fünften Potenz der Spannung. Was bewirkt eine Verdopplung der positiven Spannung? Begründe deine Antwort.
][
*Antwort:* Der Modellstrom wächst um den Faktor 32.

*Begründung:* Die gesamte Spannung wird potenziert: zwei hoch fünf ergibt 32.
][
*Typische Verwechslung:*
- Der Strom verdoppelt sich. – Das wäre die lineare Beziehung eines konstanten Widerstands.
- Der Strom wächst um den Faktor 5. – Der Exponent ist kein gewöhnlicher Multiplikationsfaktor.
]

#aufgabe(titel: "Varistor gegen Spannungsspitzen", art: "verstehen", quelle: "1.4.3.2.3", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 150* #linebreak()]
Wie begrenzt ein Varistor eine Spannungsspitze?
][
*Antwort:*
- Bei hoher Spannung wird der Varistor stark leitfähig.
- Parallel zur empfindlichen Schaltung übernimmt er einen großen Anteil des Störstroms und begrenzt die Spannung.
- Ein festes, von der Spannung unabhängiges R beschreibt diesen Vorgang nicht.
#image("abbildungen/vl30-vdr.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Wie hilft ein parallel angeschlossener Varistor gegen eine Überspannung?_

*Antwort:* Bei hoher Spannung wird er stark leitfähig und übernimmt einen großen Anteil des Störstroms. Dadurch wird die Spannung am geschützten Zweig begrenzt. Das konkrete Verhalten folgt seiner Kennlinie und Belastbarkeit, nicht einem universellen festen Widerstand.
]

#aufgabe(titel: "Varistor: Spannung verdoppelt, Strom nicht nur verdoppelt", art: "rechnen", quelle: "1.4.3.2.3", herkunft: "original", vorlage: "Vorlesungsskript S. 28", minuten: 8,
 ergebnis: [Bei 220 V: 1 A, 220 Ω; bei 440 V: 32 A, 13,75 Ω.], tipp: [Der gesamte dimensionslose Spannungsquotient steht in der fünften Potenz.])[
#if not web [*Aufgabe 151* #linebreak()]
*Gegeben und Annahmen:* Für die positive Kennlinie eines Varistormodells gilt $I/(1 thin "A") = (U/(220 thin "V"))^5$.
*Gesucht:*
#enum(numbering: "a)")[Strom und statischer Widerstand bei 220 V.][Strom und statischer Widerstand bei 440 V.][Erklärung, weshalb das Bauteil zur Begrenzung von Spannungsspitzen eingesetzt wird.]
#src[N30, PDF-S. 9 = V S. 28; zweite Spannung eigene Rechenvariation, keine Belastbarkeitszusage.]
][*Bezugswert einsetzen:* Bei 220 V ist das Verhältnis $U/(220 thin "V") = 1$. Damit $I = 1 thin "A"$ und $R = U/I = 220 thin Omega$.
][*Potenz beachten:* Bei 440 V verdoppelt sich die Spannung. Der Strom wächst auf $2^5 thin "A" = 32 thin "A"$, nicht auf 2 A. Dann ist $R = 440/32 thin Omega = "13,75" thin Omega$.
][*Physikalisch deuten:* Das Bauteil wird bei höherer Spannung viel leitfähiger. Parallel zur empfindlichen Schaltung kann es einen großen Teil des Überspannungsstroms aufnehmen. Prüfung: Die Widerstandsänderung zeigt die Nichtlinearität; konkrete Grenzenergien und Belastbarkeiten sind in dieser Modellgleichung nicht angegeben.]

#aufgabe(titel: "Varistor mit 300-V-Bezugswert (Variante)", art: "rechnen", quelle: "1.4.3.2.3", herkunft: "variante", vorlage: "Vorlesungsskript S. 28", minuten: 6,
  ergebnis: [150 V: 15,6 mA, 9,6 kΩ; 300 V: 0,5 A, 600 Ω; 360 V: 1,24 A, 289 Ω],
)[
#if not web [*Aufgabe 152* #linebreak()]
*Gegeben und Annahmen*

Für die positive Kennlinie eines Varistors gilt $I = "0,5" thin "A" dot.c (U\/(300 thin "V"))^5$.

*Gesucht*

#enum(numbering: "a)",
[Strom und statischer Widerstand $R = U\/I$ bei 150 V, 300 V und 360 V.],
[Um welchen Faktor steigt der Strom, wenn die Spannung nur um 20 % (300 V → 360 V) steigt?],
)
][
*150 V:* $(150\/300)^5 = 1\/32$, $I = "0,5"\/32 thin "A" approx "15,6" thin "mA"$, $R = 150\/"0,0156" approx "9,6" thin "k"Omega$.
][
*300 V:* Verhältnis 1, also $I = "0,5" thin "A"$, $R = 600 thin Omega$.
][
*360 V:* $"1,2"^5 approx "2,49"$, $I approx "1,24" thin "A"$, $R approx 289 thin Omega$.
][
*b) Deutung:* 20 % mehr Spannung bringen den Faktor 2,49 im Strom. Der Widerstand bricht bei Überspannung ein, deshalb schützt ein parallel geschalteter Varistor die Schaltung.
]

#aufgabe(titel: "Statischer und differenzieller Widerstand bei 2 mA", art: "verstehen", quelle: "1.4.3.2.4", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 153* #linebreak()]
Eine Diode liegt bei 0,6 V und 2 mA. Welche Aussage zu statischem und differenziellem Widerstand stimmt bei n gleich eins und 26 mV Temperaturspannung? Prüfe dazu die folgenden Aussagen und begründe, welche zutrifft.
- Statisch 300 Ω; differenziell ungefähr 13 Ω.
- Beide Widerstände sind 300 Ω.
- Die Diode hat überall 13 Ω.
][
*Antwort:* Statisch 300 Ω; differenziell ungefähr 13 Ω.

*Begründung:* Der Quotient U/I und die lokale Tangente sind verschiedene Auswertungen derselben Kennlinie.
][
*Typische Verwechslung:*
- Beide Widerstände sind 300 Ω. – Das würde Quotient und Ableitung einer gekrümmten Kennlinie gleichsetzen.
- Die Diode hat überall 13 Ω. – Der differenzielle Wert gilt nur für kleine Änderungen nahe dem gewählten Arbeitspunkt.
]

#aufgabe(titel: "Statischer und differenzieller Diodenwiderstand", art: "verstehen", quelle: "1.4.3.2.4", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 154* #linebreak()]
Was unterscheidet statischen und differenziellen Diodenwiderstand?
][
*Antwort:*
- Der statische Widerstand ist der Quotient $R_D = U_D/I_D$ im Arbeitspunkt.
- Der differenzielle Widerstand ist die lokale Tangente $r_e = dif U_D/dif I_D$.
- Er beschreibt nur kleine Änderungen um den gewählten Punkt
- bei einer gekrümmten Kennlinie sind beide Werte verschieden.

*Merksatz:* Statisch: vom Ursprung zum Punkt; differenziell: Tangente am Punkt.
#image("abbildungen/vl30-tangente.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Was beschreibt der differenzielle Widerstand einer Diode physikalisch?_

*Antwort:* Er beschreibt, wie viel kleine Spannungsänderung für eine kleine Stromänderung nahe einem festgelegten Arbeitspunkt nötig ist. Grafisch gehört er zur Tangente. Bei großen Auslenkungen braucht man wieder die vollständige Kennlinie.
]

#aufgabe(titel: "BAY41: Sättigungsstrom und zwei Widerstandsbegriffe", art: "rechnen", quelle: "1.4.3.2.4", herkunft: "original", vorlage: "Vorlesungsskript S. 30–31", minuten: 10,
 ergebnis: [$I_D approx 2 thin "mA"$, $I_S approx 190 thin "fA"$, $R_D = 300 thin Omega$, $r_e approx 13 thin Omega$.], tipp: [Zuerst die Kennlinie ablesen, dann das Modell im Arbeitspunkt auswerten.])[
#if not web [*Aufgabe 155* #linebreak()]
*Gegeben und Annahmen:* Gedruckte BAY41-Kennlinie bei 300 K; ideales Shockley-Modell mit $n = 1$. Verwende wie im Skript die gerundete Temperaturspannung $U_T = 26 thin "mV"$. $I_D = I_S(e^(U_D/U_T)-1)$.
#image("abbildungen/vl30-bay41.svg", width: 78%)
*Gesucht:*
#enum(numbering: "a)")[Strom bei $U_D = "0,6" thin "V"$ aus der Kennlinie und daraus der Modellparameter $I_S$.][Statischer Widerstand $R_D = U_D/I_D$.][Differenzieller Widerstand $r_e approx U_T/I_D$ und Erklärung des Unterschieds.]
#src[N30, PDF-S. 11–12 = V S. 30–31; Kennlinie nach Abb. 1.27.]
][*Arbeitspunkt ablesen:* Bei 0,6 V sind aus der Kennlinie ungefähr 2 mA abzulesen. Der Strom ist ein Ablesewert, keine beliebig genaue Messung.
][*Modellparameter bestimmen:* Nach $I_S$ umstellen: $I_S = (2 dot.c 10^(-3) thin "A")/(e^("0,6"/"0,026")-1) approx "1,90" dot.c 10^(-13) thin "A" = 190 thin "fA"$. Der Spannungsquotient im Exponenten ist dimensionslos. Der Wert gehört zum idealisierten Modell mit ausdrücklich auf 26 mV gerundetem $U_T$.
][*Statischen Quotienten berechnen:* $R_D = "0,6" thin "V"/("0,002" thin "A") = 300 thin Omega$. Das ist die Verbindungsgerade vom Ursprung zum Arbeitspunkt.
][*Lokale Änderung berechnen und prüfen:* $r_e approx "0,026" thin "V"/("0,002" thin "A") = 13 thin Omega$. Die lokale Tangente ist viel steiler als die Ursprungsgerade. Die 13 Ω dürfen nur für kleine Änderungen um den gewählten Arbeitspunkt verwendet werden.]

#aufgabe(titel: "LED-Schwelle ist nicht die Betriebsspannung", art: "verstehen", quelle: "1.4.3.2.4.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 156* #linebreak()]
Warum ist die aus einer Lichtwellenlänge berechnete LED-Schwelle nicht automatisch die Betriebsspannung?
][
*Antwort:*
- Die Energiebetrachtung verknüpft die Energie eines Photons mit einer elektrischen Spannungsskala.
- Die tatsächliche Durchlassspannung bei einem bestimmten Strom folgt zusätzlich aus der elektrischen Kennlinie.
- Quelle und Last müssen gemeinsam einen passenden Arbeitspunkt liefern.
#image("abbildungen/led-kennlinie-aufgabe.svg", width: 80%)
]

#aufgabe(titel: "LED-Leerlauf: was im Netz bleibt", art: "verstehen", quelle: "1.4.3.2.4.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 157* #linebreak()]
Was bleibt bei der Leerlaufbetrachtung der LED-Aufgabe im Netzwerk?
][
*Antwort:*
- Nur die LED wird als äußere Last entfernt.
- Die drei vorgegebenen Widerstände bleiben angeschlossen
- der Parallelwiderstand gehört weiter zum unbelasteten Spannungsteiler.
- Erst beim Kurzschließen der Klemmen wird er überbrückt.
#image("abbildungen/led-netzwerk.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Beim Leerlauf der LED-Aufgabe wird nur die LED entfernt. Was geschieht mit dem 50-Ω-Widerstand parallel zur LED?_

*Antwort:* Er bleibt im Netzwerk und beeinflusst die Leerlaufspannung.

*Begründung:* Leerlauf bezieht sich auf die äußere LED-Last; der vorhandene Teiler bleibt bestehen.

*Typische Verwechslung:*
- Er muss ebenfalls entfernt werden. – Dadurch würde ein anderes Netzwerk entstehen.
- Er wird automatisch kurzgeschlossen. – Das passiert beim Kurzschluss der Klemmen, nicht im Leerlauf.
]

#aufgabe(titel: "Bezugsleistung des LED-Wirkungsgrads", art: "verstehen", quelle: "1.4.3.2.4.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 158* #linebreak()]
Auf welche Leistung bezieht sich der optische LED-Wirkungsgrad?
][
*Antwort:*
- Auf die elektrische Leistung direkt an der LED: $P_"LED" = U_D I_D$.
- Die optische Leistung ist $P_"opt" = eta_"LED" P_"LED"$.
- Die Verlustleistungen im übrigen Netzwerk sind darin nicht enthalten.
][
*Ergänzung aus der früheren Quizfrage:* _Die LED hat 20 Prozent optischen Wirkungsgrad. Auf welche elektrische Leistung bezieht sich das in der Aufgabe?_

*Antwort:* Auf die Leistung direkt in der LED: Diodenspannung mal Diodenstrom.

*Begründung:* Die übrigen Widerstände sind nicht Teil dieses angegebenen LED-Wirkungsgrads.

*Typische Verwechslung:*
- Auf die gesamte Quellleistung. – Damit würde man die Netzwerkverluste fälschlich in die LED-Effizienz einbeziehen.
- Auf die Photonenergie allein. – Eine Energie pro Photon ist noch keine Leistung; dafür wäre auch die Zahl der Photonen pro Zeit nötig.
]

#aufgabe(titel: "Rote LED: Messreihe und Arbeitspunkt", art: "rechnen", quelle: "1.4.3.2.4.1", herkunft: "original", vorlage: "Aufgabe GET (jk), LED rot – Messung von Spannung und Strom", minuten: 15, platz: 18,
  ergebnis: [$I_k = 50 thin "mA"$; Arbeitspunkt etwa $U_D approx "2,8" thin "V"$, $I_D approx 34 thin "mA"$ (Mitschrift: 2,6 V / 36 mA aus der Zeichnung)],
  tipp: [Arbeitsgerade von $(0 thin "V"; I_k)$ nach $(U_l; 0 thin "mA")$ einzeichnen und mit der Messkurve schneiden.],
)[
#if not web [*Aufgabe 159* #linebreak()]
*Gegeben und Annahmen*

Messreihe einer roten 3-mm-LED (Spannung $U$ in V, Strom $I$ in mA):

#tab(columns: (1fr,1fr,1fr,1fr), th([$U$ / V], [$I$ / mA], [$U$ / V], [$I$ / mA]),
[0],[0],[2,6],[26,3], [0,5],[0],[2,8],[33,6], [1],[0],[3,0],[59,2], [1,5],[0],[3,2],[68], [2,0],[5,1],[3,4],[77], [2,2],[11,7],[3,6],[84], [2,4],[18,9],[3,8],[nicht angegeben])

Die LED wird an eine Quelle mit Leerlaufspannung $U_l = 9 thin "V"$ und Innenwiderstand (Vorwiderstand) $R_i = 180 thin Omega$ angeschlossen (Anode an Plus).

*Gesucht*

#enum(numbering: "a)",
[Zeichne die LED-Kennlinie $I(U)$ aus der Messreihe.],
[Berechne den Kurzschlussstrom der Quelle und zeichne ihre Kennlinie (Arbeitsgerade) ein.],
[Bestimme den Arbeitspunkt $U_D$, $I_D$.],
[Welche Leistung setzt die LED um?],
)
][
*a) Kennlinie:* Bis etwa 1,5 V fließt praktisch kein Strom, ab rund 2 V steigt er immer steiler an. Das ist das typische Diodenverhalten; ein fester Widerstand wäre eine Ursprungsgerade.
][
*b) Quellenkennlinie:* $I_k = U_l\/R_i = 9 thin "V"\/180 thin Omega = 50 thin "mA"$. Die Arbeitsgerade verbindet (0 V; 50 mA) mit (9 V; 0 mA): $I = (9 thin "V" - U)\/180 thin Omega$.
][
*c) Schnittpunkt:* Die Gerade liefert bei 2,8 V den Wert 34,4 mA (Messung: 33,6 mA, also noch knapp darunter) und bei 3,0 V 33,3 mA (Messung: 59,2 mA, darüber). Der Schnitt liegt also knapp über 2,8 V; lineare Interpolation zwischen 2,8 V und 3,0 V ergibt $U_D approx "2,81" thin "V"$, $I_D approx "34,4" thin "mA"$.
][
*Mitschrift einordnen:* Auf dem Blatt ist grafisch $U_D approx "2,6" thin "V"$, $I_D approx 36 thin "mA"$ notiert. Diese Paarung widerspricht der gedruckten Tabelle: Bei 2,6 V sind dort 26,3 mA angegeben. Aus der Tabelle und der Arbeitsgeraden folgen dagegen rund 2,81 V und 34,4 mA. Die Angaben sind als Quellenabweichung getrennt zu halten. In der Klausur den Schnittpunkt aus der tatsächlich vorgegebenen Kennlinie bestimmen und die Ablesegenauigkeit angeben.
][
*d) Leistung:* $P_D = U_D I_D approx "2,8" thin "V" dot.c "0,034" thin "A" approx 96 thin "mW"$. Am Vorwiderstand fallen $9 - "2,8" = "6,2" thin "V"$ ab ($approx 213 thin "mW"$).
]

#aufgabe(titel: "Rote LED an 5 V mit 100 Ω (Variante)", art: "rechnen", quelle: "1.4.3.2.4.1", herkunft: "variante", vorlage: "Aufgabe GET (jk), LED rot – Messung von Spannung und Strom", minuten: 12, platz: 16,
  ergebnis: [$I_k = 50 thin "mA"$; Arbeitspunkt etwa $U_D approx "2,55" thin "V"$, $I_D approx "24,5" thin "mA"$],
)[
#if not web [*Aufgabe 160* #linebreak()]
*Gegeben und Annahmen*

Dieselbe rote LED mit der Messreihe ($U$ in V / $I$ in mA): 2 / 5,1; 2,2 / 11,7; 2,4 / 18,9; 2,6 / 26,3; 2,8 / 33,6; 3,0 / 59,2. Sie liegt jetzt an einer Quelle mit $U_l = 5 thin "V"$ und $R_i = 100 thin Omega$.

*Gesucht*

#enum(numbering: "a)",
[Kurzschlussstrom und Arbeitsgerade.],
[Arbeitspunkt der LED.],
[Leistung in LED und Vorwiderstand.],
)
][
*a) Gerade:* $I_k = 5\/100 = 50 thin "mA"$; Gerade von (0 V; 50 mA) nach (5 V; 0).
][
*b) Schnitt eingrenzen:* Bei 2,4 V liefert die Gerade 26 mA (LED 18,9 mA, darunter), bei 2,6 V 24 mA (LED 26,3 mA, darüber). Interpolation: $U_D approx "2,55" thin "V"$, $I_D approx "24,5" thin "mA"$.
][
*c) Leistungen:* $P_D approx "2,55" dot.c "0,0245" approx 62 thin "mW"$; am Vorwiderstand $"2,45" thin "V" dot.c "24,5" thin "mA" approx 60 thin "mW"$. Gegenüber dem Original sinkt der Strom, aber der Vorwiderstand verbraucht relativ weniger.
]

#aufgabe(titel: "Grüne LED: Schwelle, Quellenkennlinie und Arbeitspunkt", art: "rechnen", quelle: "1.4.3.2.4.1", herkunft: "original", vorlage: "Aufgabe GET (jk), grüne LED", minuten: 25,
 ergebnis: [$U_"Schwelle" approx "2,14" thin "V"$, $U_l approx "6,02" thin "V"$, $I_k approx 303 thin "mA"$; AP ungefähr 2,4 V / 180 mA; $P_"opt" approx 86 thin "mW"$; neue Quelle etwa 7,2 V (Ablesewert).], tipp: [Im Leerlauf nur die LED entfernen; beim Kurzschluss wird R3 überbrückt.])[
#if not web [*Aufgabe 161* #linebreak()]
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

#aufgabe(titel: "Grüne LED an 8 V (Variante)", art: "rechnen", quelle: "1.4.3.2.4.1", herkunft: "variante", vorlage: "Aufgabe GET (jk), grüne LED", minuten: 20, platz: 18,
  ergebnis: [$U_l approx "5,33" thin "V"$, $I_k approx 364 thin "mA"$, $R_i approx "14,7" thin Omega$; AP etwa 2,4 V / 0,2 A; $P_"opt" approx 96 thin "mW"$; für 0,15 A etwa $U_q approx "6,9" thin "V"$],
)[
#if not web [*Aufgabe 162* #linebreak()]
*Gegeben und Annahmen*

Dieselbe grüne LED ($lambda = 580 thin "nm"$, Kennlinie wie unten) am Netzwerk aus dem Aufgabenblatt, jetzt mit $U_q = 8 thin "V"$, $R_1 = 10 thin Omega$, $R_2 = 12 thin Omega$, $R_3 = 44 thin Omega$. Die LED liegt zwischen A und B parallel zu R3. Optischer Wirkungsgrad 20 %.

#image("abbildungen/led-netzwerk-variante.svg", width: 85%)
#image("abbildungen/led-kennlinie-aufgabe.svg", width: 95%)

*Gesucht*

#enum(numbering: "a)",
[Leerlaufspannung, Kurzschlussstrom und Innenwiderstand an A–B.],
[Grafischer Arbeitspunkt der LED.],
[Optische Leistung.],
[Auf welchen Wert muss $U_q$ sinken, damit 0,15 A durch die LED fließen?],
)
][
*a) Ersatzquelle:* LED abklemmen, R3 bleibt: $U_l = 8 dot.c 44\/(22 + 44) approx "5,33" thin "V"$. Kurzschluss A–B überbrückt R3: $I_k = 8\/22 approx "0,364" thin "A"$. $R_i = U_l\/I_k = 22 || 44 approx "14,7" thin Omega$.
][
*b) Arbeitsgerade:* von (0 V; 364 mA) nach (5,33 V; 0). Sie schneidet die steile LED-Kennlinie bei etwa $U_D approx "2,4" thin "V"$; dort liefert die Gerade $I = ("5,33" - "2,4")\/"14,7" approx "0,20" thin "A"$.
][
*c) Optische Leistung:* $P_"el" approx "2,4" dot.c "0,20" = "0,48" thin "W"$, $P_"opt" = "0,2" dot.c "0,48" approx 96 thin "mW"$.
][
*d) Neuer Arbeitspunkt:* Bei 0,15 A liest du etwa $U_D approx "2,38" thin "V"$ ab. Durch R3 fließen $"2,38"\/44 approx "0,054" thin "A"$, durch R1 und R2 zusammen 0,204 A. $U_q = "2,38" + "0,204" dot.c 22 approx "6,9" thin "V"$ (Ablesetoleranz etwa ±0,1 V).
]

#aufgabe(titel: "Lastgerade begrenzt den Basisstrom", art: "verstehen", quelle: "1.4.3.2.5", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 163* #linebreak()]
Warum begrenzt die Lastgerade die Wirkung des Basisstroms?
][
*Antwort:*
- Im aktiven Transistormodell steuert der Basisstrom den Kollektorstrom.
- Quelle und Lastwiderstand erlauben aber nur die Betriebspunkte auf ihrer Lastgeraden.
- Gerät der Transistor in Sättigung, kann man den Strom nicht mehr unverändert mit beta mal Basisstrom weiterrechnen.
#image("abbildungen/vl30-transistorfeld.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Warum darfst du den Kollektorstrom nicht unbegrenzt mit beta mal Basisstrom hochrechnen?_

*Antwort:* Quelle, Lastgerade und Betriebsbereich begrenzen den möglichen Arbeitspunkt.

*Begründung:* In Sättigung gilt die einfache aktive Verstärkungsbeziehung nicht unverändert.

*Typische Verwechslung:*
- Weil beta immer genau eins ist. – Der behandelte Transistor kann deutlich größere Gleichstromverstärkungen haben.
- Weil die Knotenregel im Transistor aussetzt. – Auch hier addieren sich Basis- und Kollektorstrom zum Emitterstrom.
]

#aufgabe(titel: "Lastgerade und Verlustleistungshyperbel", art: "verstehen", quelle: "1.4.3.2.5", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 164* #linebreak()]
Was unterscheidet Lastgerade und Verlustleistungshyperbel beim Transistor?
][
*Antwort:*
- Die Lastgerade beschreibt die Spannungsbilanz mit Quelle und äußerem Widerstand.
- Die Verlustleistungshyperbel verbindet Punkte gleichen Produkts $U_(C E) I_C$.
- Ein Arbeitspunkt muss zur Last passen und zugleich unter der zulässigen Verlustleistungsgrenze liegen.
#image("abbildungen/vl30-transistorfeld.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Was zeigt die Verlustleistungshyperbel im Transistorkennlinienfeld?_

*Antwort:* Sie verbindet Punkte gleichen Produkts aus Kollektor-Emitter-Spannung und Kollektorstrom. Eine vorgegebene Grenze darf am Arbeitspunkt nicht überschritten werden. Sie beschreibt etwas anderes als die Lastgerade des äußeren Stromkreises.
][
*Ergänzung aus der früheren Quizfrage:* _Was kennzeichnet die Verlustleistungshyperbel eines Transistors?_

*Antwort:* Alle Punkte auf ihr besitzen dasselbe Produkt aus UCE und IC.

*Begründung:* Sie beschreibt $P_T=U_(C E)I_C=P_"max"$.

*Typische Verwechslung:*
- Sie ist die Lastgerade jedes möglichen Kollektorwiderstands. – Eine Lastgerade ist linear; eine konstante Leistung bildet eine Hyperbel.
- Oberhalb der Kurve ist die Verlustleistung grundsätzlich kleiner. – Bei gleichem U bedeutet ein größerer Strom eine größere Leistung.
]

#aufgabe(titel: "Transistorarbeitspunkt und Verlustleistungsgrenze", art: "rechnen", quelle: "1.4.3.2.5", herkunft: "original", vorlage: "Vorlesungsskript S. 32–33", minuten: 8,
 ergebnis: [$beta approx 300$, $I_E approx "60,2" thin "mA"$, $P_T approx "0,48" thin "W"$.], tipp: [Basis- und Kollektorstrom zuerst in dieselbe Einheit umrechnen.])[
#if not web [*Aufgabe 165* #linebreak()]
*Gegeben und Annahmen:* Aus dem Kennlinienfeld werden ungefähr $I_B = 200 thin mu"A"$, $I_C = 60 thin "mA"$ und $U_(C E) = 8 thin "V"$ am betrachteten Arbeitspunkt abgelesen. Zulässige Verlustleistung 0,5 W. Aktiver Betrieb im angegebenen Punkt.
*Gesucht:*
#enum(numbering: "a)")[Gleichstromverstärkung beta und Emitterstrom.][Verlustleistung und Vergleich mit der Grenze.][Warum man bei beliebiger Erhöhung des Basisstroms nicht unbegrenzt mit demselben beta weiterrechnen darf.]
#src[N30, PDF-S. 13–14 = V S. 32–33, abgelesener Arbeitspunkt und Verlustleistungshyperbel.]
][*Steuerverhältnis bilden:* $beta = I_C/I_B = "0,060" thin "A"/(200 dot.c 10^(-6) thin "A") approx 300$. Die Stromverstärkung ist einheitenlos. $I_E = I_C + I_B approx "60,2" thin "mA"$.
][*Verlustleistung prüfen:* $P_T = U_(C E) I_C = 8 thin "V" dot.c "0,060" thin "A" = "0,48" thin "W"$. Das liegt unter 0,5 W, aber nahe an der im Diagramm angegebenen Grenze. Die Ablesegenauigkeit erlaubt keine große zusätzliche Reservebehauptung.
][*Modellgrenze erklären:* Die Lastgerade und die Quellspannung begrenzen den möglichen Kollektorstrom. Bei Sättigung gilt die einfache aktive Beziehung $I_C approx beta I_B$ nicht unverändert; außerdem ist beta selbst betriebspunktabhängig.]

#aufgabe(titel: "Widerstand als Thermometer", art: "verstehen", quelle: "1.4.4", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 166* #linebreak()]
Wie kann man einen temperaturabhängigen Widerstand als Thermometer nutzen?
][
*Antwort:* Man kennt den Widerstand bei einer Bezugstemperatur und seinen passenden Temperaturkoeffizienten. Aus der gemessenen relativen Widerstandsänderung folgt im gültigen Modell die Temperaturänderung. Selbsterwärmung und Gültigkeitsbereich müssen dabei berücksichtigt werden.
]

#aufgabe(titel: "Celsius-Differenz ohne 273,15", art: "verstehen", quelle: "1.4.4", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 167* #linebreak()]
Warum wird zu einer Temperaturdifferenz in Grad Celsius nicht 273,15 addiert?
][
*Antwort:*
- Die Celsius- und Kelvin-Skala unterscheiden sich durch eine feste Verschiebung.
- Beim Subtrahieren zweier Temperaturen fällt diese Verschiebung weg.
- Deshalb hat ein Temperaturanstieg in Kelvin denselben Zahlenwert wie in Grad Celsius.
][
*Ergänzung aus der früheren Quizfrage:* _Kupfer erwärmt sich von 20 auf 100 Grad Celsius. Welche Temperaturdifferenz setzt du in das lineare Widerstandsmodell ein?_

*Antwort:* 80 Kelvin.

*Begründung:* Temperaturdifferenzen haben in Kelvin und Grad Celsius denselben Zahlenwert.

*Typische Verwechslung:*
- 373,15 Kelvin – Das ist die absolute Endtemperatur, nicht ihre Differenz zum Bezug.
- 353,15 Kelvin – Zu einer Celsius-Differenz wird nicht 273,15 addiert.
]

#aufgabe(titel: "Kupferwiderstand als Thermometer", art: "rechnen", quelle: "1.4.4", herkunft: "variante", vorlage: "Vorlesungsskript S. 34", minuten: 12,
 ergebnis: [$R(100 thin "°C") = "13,144" thin Omega$; bei 13,93 Ω: 120 °C.], tipp: [Rechne mit der Abweichung vom 20-°C-Wert, nicht mit der absoluten Kelvin-Temperatur.])[
#if not web [*Aufgabe 168* #linebreak()]
*Gegeben und Annahmen:* Eigene Rechenvariation mit einem Kupferwiderstand $R_20 = 10 thin Omega$ bei 20 °C; $alpha_20 = "3,93" dot.c 10^(-3) thin "1/K"$. Lineares Temperaturmodell, Selbsterwärmung vernachlässigt.
*Gesucht:*
#enum(numbering: "a)")[Widerstand bei 100 °C.][Temperatur bei einem gemessenen Widerstand von 13,93 Ω.][Warum die Differenz nicht durch Addition von 273,15 zu einer Kelvin-Differenz umgerechnet wird.]
#src[Materialkoeffizient und Modell: N30, PDF-S. 15 = V S. 34; Zahlenvariation eigene Ergänzung.]
][*Differenz bilden:* Für 100 °C gegenüber 20 °C gilt $Delta vartheta = 80 thin "K"$. Es wird eine Differenz, keine absolute Temperatur, benötigt.
][*Linear einsetzen:* $R = 10 thin Omega dot.c (1 + "0,00393" thin "1/K" dot.c 80 thin "K") = "13,144" thin Omega$. Die Klammer ist dimensionslos, und der Widerstand steigt wie bei Kupfer erwartet.
][*Messung umkehren:* $Delta vartheta = (R/R_20 - 1)/alpha_20 = ("13,93"/10 - 1)/"0,00393" thin "K" = 100 thin "K"$. Zur Bezugstemperatur addieren: $vartheta = 120 thin "°C"$.
][*Prüfen:* Der Anstieg von 100 K ist zahlenmäßig ein Anstieg von 100 °C. Die Verschiebung 273,15 gehört nur zur Umrechnung absoluter Skalenwerte und fällt beim Subtrahieren heraus. Die Werte bleiben im genannten linearen Modellbereich.]

#aufgabe(titel: "Endleistung mal Zeit ist falsch", art: "verstehen", quelle: "1.5", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 169* #linebreak()]
Warum darfst du bei zeitabhängigem Strom nicht immer einfach die Endleistung mit der gesamten Zeit multiplizieren?
][
*Antwort:* Die Endleistung lag vorher möglicherweise nicht die ganze Zeit an. Die Energie ergibt sich aus der gesamten Fläche unter der Leistungskurve. Erst eine konstante Leistung oder die korrekt gebildete mittlere Leistung darf mit der gesamten Zeit multipliziert werden.
]

#aufgabe(titel: "Energie aus der Leistung-Zeit-Kurve", art: "verstehen", quelle: "1.5", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 170* #linebreak()]
Wie liest man Energie und mittlere Leistung aus einer Leistung-Zeit-Kurve?
][
*Antwort:*
- Die Energie ist die Fläche unter der Kurve.
- Die mittlere Leistung ist die Höhe eines Rechtecks mit derselben Fläche und derselben Zeitbreite.
- Ein einzelner Endwert ersetzt die Fläche bei veränderlicher Leistung nicht.

*Merksatz:* Energie ist Fläche, mittlere Leistung ist passende Rechteckhöhe.
#image("abbildungen/vl30-leistung.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Was entspricht der Fläche unter einer Leistung-Zeit-Kurve?_

*Antwort:* Der umgesetzten Energie.

*Begründung:* Watt mal Sekunde ergibt Joule; die mittlere Leistung ist die Höhe des flächengleichen Rechtecks.

*Typische Verwechslung:*
- Der Endleistung. – Die Endleistung ist nur ein einzelner Kurvenwert.
- Dem mittleren Strom. – Die Fläche einer Leistungskurve hat die Energieeinheit, keine Stromeinheit.
]

#aufgabe(titel: "Zeitabhängige Leistung: Fläche statt Endwert", art: "rechnen", quelle: "1.5", herkunft: "variante", vorlage: "Vorlesungsskript S. 36–37", minuten: 9,
 ergebnis: [Endleistung 4 W, Energie 4 J, mittlere Leistung 2 W.], tipp: [Die Fläche unter einer linear von null steigenden Leistung ist ein Dreieck.])[
#if not web [*Aufgabe 171* #linebreak()]
*Gegeben und Annahmen:* Eigene Anwendung der Vorlesungsformel. Eine konstante Spannung von 10 V treibt in 2 s einen linear von 0 auf 0,4 A steigenden Strom. Damit $i(t) = ("0,2" thin "A/s") t$ für $0 <= t <= 2 thin "s"$.
*Gesucht:*
#enum(numbering: "a)")[Momentanleistung als Funktion der Zeit und Leistung am Ende.][Umgesetzte Energie und mittlere Leistung.][Begründung, weshalb Endleistung mal Gesamtzeit hier falsch ist.]
#src[N30, PDF-S. 17–18 = V S. 36–37; konkrete Zeitfunktion eigene Ergänzung.]
][*Momentanwerte verknüpfen:* $p(t) = u(t) i(t) = (2 thin "W/s") t$. Am Ende nach 2 s beträgt die Leistung 4 W; am Anfang ist sie null.
][*Energiefläche bestimmen:* Die Leistungskurve ist eine Gerade ab null. Ihre Fläche ist ein Dreieck: $W = "0,5" dot.c 2 thin "s" dot.c 4 thin "W" = 4 thin "J"$. Gleichwertig ist die Integration $integral_0^(2 thin "s") p(t) dif t$.
][*Mittelwert und Plausibilität prüfen:* $P_"mittel" = W/t_1 = 4 thin "J"/(2 thin "s") = 2 thin "W"$. Das flächengleiche Rechteck hat dieselbe Zeitbreite und halbe Endhöhe. Endleistung mal Gesamtzeit ergäbe 8 J und täte fälschlich so, als hätten von Anfang an 4 W vorgelegen.]

#kapitel("Kapitel 2 · Kirchhoffsche Gesetze und Grundstromkreis")

#aufgabe(titel: "Erhaltungsgröße hinter dem Knotenpunktsatz", art: "verstehen", quelle: "2.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 172* #linebreak()]
Welche Erhaltungsgröße steckt hinter dem Knotenpunktsatz?
][
*Antwort:* Die elektrische Ladung bleibt erhalten. Im stationären Knoten sammelt sich keine Ladung an; der gesamte Zufluss gleicht deshalb dem gesamten Abfluss. Die algebraische Summe ist nur mit richtiger Vorzeichenwahl null.
]

#aufgabe(titel: "Negativer Strom ist kein Fehler", art: "verstehen", quelle: "2.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 173* #linebreak()]
Warum ist ein negativer Strom in einer Knotenrechnung kein automatischer Fehler?
][
*Antwort:*
- Die Strompfeile sind zunächst Bezugsrichtungen.
- Ein negativer berechneter Wert bedeutet einen Strom entgegen dem angenommenen Pfeil.
- Die Ladungsbilanz muss mit diesen Vorzeichen trotzdem aufgehen.

*Merksatz:* Negatives I heißt: entgegen dem gewählten Pfeil.
#image("abbildungen/vl30-knoten.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Ein berechneter Zweigstrom ist negativ. Was bedeutet das bei festgelegtem Zählpfeil?_

*Antwort:* Der tatsächliche Strom fließt entgegen dem angenommenen Pfeil.

*Begründung:* Der Pfeil bleibt als Bezugsrichtung bestehen; das Vorzeichen gibt die reale Richtung an.

*Typische Verwechslung:*
- Die Knotenregel ist verletzt. – Eine vorzeichenrichtige Bilanz kann ohne Weiteres negative Ergebnisse liefern.
- Es fließt überhaupt kein Strom. – Ein negativer Wert ist nicht null.
]

#aufgabe(titel: "Knotenbilanz mit negativem Ergebnis", art: "rechnen", quelle: "2.1", herkunft: "variante", vorlage: "Vorlesungsskript S. 39", minuten: 9,
 ergebnis: [$I_4 = -1 thin "A"$, tatsächlich 1 A entgegen dem Pfeil zum Knoten.], tipp: [Alle Ströme mit ihren angenommenen Pfeilen in dieselbe Bilanz eintragen.])[
#if not web [*Aufgabe 174* #linebreak()]
*Gegeben und Annahmen:* Eigene Zahlenvariation zur Knotenregel. I1 = 2 A und I3 = 3 A sind zum Knoten hin definiert, I2 = 6 A vom Knoten weg. Für I4 wird ebenfalls ein Pfeil vom Knoten weg angenommen. Stationärer Knoten ohne Ladungsanhäufung.
*Gesucht:*
#enum(numbering: "a)")[Knotenbilanz und I4.][Bedeutung des Vorzeichens und Kontrolle der tatsächlichen Zu- und Abflüsse.]
#src[Knoten und Pfeilanordnung nach N30, PDF-S. 20 = V S. 39; Zahlen eigene Ergänzung.]
][*Richtungen festlegen:* Zuflüsse positiv, Abflüsse negativ: $I_1 + I_3 - I_2 - I_4 = 0$. Die Definition von I4 muss in der Rechnung beibehalten werden.
][*Unbekannten Strom berechnen:* $I_4 = I_1 + I_3 - I_2 = 2 + 3 - 6 = -1 thin "A"$. Der Strom fließt tatsächlich mit 1 A zum Knoten hin, entgegen dem angenommenen Pfeil.
][*Bilanz prüfen:* Tatsächlich fließen 2 A + 3 A + 1 A hinein und 6 A hinaus. Das passt. Ein negatives Ergebnis ist hier eine Richtungsinformation, kein Rechenfehler.]

#aufgabe(titel: "Maschenumlauf umkehren", art: "verstehen", quelle: "2.2", herkunft: "eigen", minuten: 3,
 ergebnis: [Alle Vorzeichen kehren sich gemeinsam um; die physikalische Lösung bleibt gleich.], tipp: [Ein Umlaufsinn ist eine Rechenentscheidung.])[
#if not web [*Aufgabe 175* #linebreak()]
Im Skriptumlauf gilt $U_q + U_1 + U_2 - U_3 = 0$. Erkläre, was beim Umkehren des Umlaufsinns passiert. Ändert die Umkehr die reale Stromrichtung oder die Polung der idealen Quelle?
#src[N30, PDF-S. 21 = V S. 40.]
][*Nur die Zählung umkehren:* Die neue Gleichung lautet $-U_q - U_1 - U_2 + U_3 = 0$. Sie entsteht durch Multiplikation der alten Gleichung mit −1.
][*Physik und Rechenrichtung trennen:* Die reale Schaltung, Quellenpolung und Ströme ändern sich durch unsere Wahl nicht. Wir laufen dieselbe geschlossene Masche rechnerisch andersherum ab. Die Lösungen müssen identisch bleiben.][
*Ergänzung aus der früheren Quizfrage:* _Du kehrst bei einer Maschengleichung den Umlaufsinn um. Was muss passieren?_

*Antwort:* Alle Spannungsbeiträge wechseln gemeinsam das Vorzeichen.

*Begründung:* Die ganze Gleichung wird mit minus eins multipliziert; die Lösung bleibt dieselbe.

*Typische Verwechslung:*
- Nur die Quellspannung wechselt das Vorzeichen. – Auch die übrigen Spannungen werden nun entgegengesetzt durchlaufen.
- Der reale Strom kehrt seine Richtung um. – Eine Rechenentscheidung verändert den Stromkreis nicht.
]

#aufgabe(titel: "Erhaltungsidee hinter dem Maschensatz", art: "verstehen", quelle: "2.2", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 176* #linebreak()]
Welche Erhaltungsidee steckt hinter dem Maschensatz?
][
*Antwort:*
- Nach einem geschlossenen Umlauf ist man wieder am selben Potenzial.
- Alle gezählten Spannungsanhebungen und Spannungsabfälle müssen sich deshalb im betrachteten Netzwerk ausgleichen.
- Beim Umkehren des Umlaufsinns wechseln alle Vorzeichen gemeinsam.
#image("abbildungen/vl30-masche.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Warum ist die Spannungssumme auf einer geschlossenen Masche null?_

*Antwort:* Nach dem Umlauf erreicht man wieder denselben Schaltungspunkt und damit dasselbe Potenzial. Alle Anhebungen und Abfälle müssen sich im betrachteten Netzwerkmodell ausgleichen. Die Vorzeichen folgen dem gewählten Umlauf und den Zählpfeilen.
]

#aufgabe(titel: "Nichtlineares Netz kontrollieren", art: "verstehen", quelle: "2.3", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 177* #linebreak()]
Wie kontrollierst du das Ergebnis eines nichtlinearen Netzwerks?
][
*Antwort:* Prüfe die verwendeten Punkte an den Kennlinien, die Summe der Ströme am Knoten und die Spannungssumme jeder betrachteten Masche. Berechnete Leistungen müssen zu den tatsächlichen Bauteilspannungen und -strömen gehören. Ein negativer Strom wird als Richtungsinformation interpretiert.
]

#aufgabe(titel: "Kirchhoff gilt auch nichtlinear", art: "verstehen", quelle: "2.3", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 178* #linebreak()]
Warum gelten Kirchhoffs Regeln auch mit nichtlinearen Bauteilen?
][
*Antwort:*
- Die Regeln bilanzieren Ladung am Knoten und Spannungen im Umlauf.
- Die Nichtlinearität steckt in der Bauteilkennlinie, nicht in diesen Bilanzen.
- Kennlinien und Kirchhoffsche Gleichungen müssen zusammen erfüllt werden.
#image("abbildungen/map-netzwerk.svg", width: 80%)
]

#aufgabe(titel: "Vorgegebener Zweigstrom im nichtlinearen Netz", art: "verstehen", quelle: "2.3", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 179* #linebreak()]
Wie hilft ein vorgegebener Zweigstrom beim Lösen eines nichtlinearen Netzwerks?
][
*Antwort:*
- Du liest zuerst die zugehörige Spannung des nichtlinearen Bauteils ab und ergänzt die übrigen Abfälle des Zweigs.
- Dadurch kennst du die gemeinsame Zweigspannung.
- Über Potenziale und Knotenbilanz lassen sich die anderen Zweige Schritt für Schritt verbinden.
#image("abbildungen/vl30-netzkennlinie.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _In einem nichtlinearen Dreizweignetz ist der Strom eines Zweigs bekannt. Was ist ein sinnvoller erster Schritt?_

*Antwort:* Aus dessen Kennlinie die Spannung lesen und weitere Spannungsabfälle dieses Zweigs ergänzen.

*Begründung:* Damit erhält man die gemeinsame Klemmen- bzw. Zweigspannung für den Vergleich mit den anderen Zweigen.

*Typische Verwechslung:*
- Alle nichtlinearen Bauteile durch denselben konstanten Widerstand ersetzen. – Die Kennlinien sind unterschiedlich und gelten nicht als universelle konstante Widerstände.
- Die Kirchhoffschen Gesetze weglassen. – Gerade diese Bilanzen verbinden die Zweige weiterhin.
]

#aufgabe(titel: "Nichtlineares Dreizweignetz aus der Vorlesung", art: "rechnen", quelle: "2.3", herkunft: "original", vorlage: "Vorlesungsskript S. 41, Aufg. 2.3", minuten: 15,
 ergebnis: [Uq2 = 8 V, Plus oben (Spannungspfeil nach unten); PR1 = 12 W, PR2 = 16 W.], tipp: [Beginne beim vorgegebenen Mittelzweig; die gemeinsame Zweigspannung verbindet alle drei Äste.])[
#if not web [*Aufgabe 180* #linebreak()]
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

#aufgabe(titel: "Ideale und reale Spannungsquelle", art: "verstehen", quelle: "2.4.1", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 26", minuten: 3)[
#if not web [*Aufgabe 181* #linebreak()]
Skizziere das Schaltbild einer idealen und einer realen Spannungsquelle.
][
*Ideal:* nur die Quelle $U_q$. Real: $U_q$ mit dem Innenwiderstand $R_i$ in Reihe.
][
*Ergänzung aus der früheren Karteikarte:* _Wie sieht das Ersatzschaltbild einer realen Quelle aus?_

*Antwort:*
- Eine ideale Spannungsquelle $U_q$ mit dem Innenwiderstand $R_i$ in Reihe.
- Fließt Strom, fällt an $R_i$ die Spannung $U_i = I R_i$ ab, an den Klemmen bleibt
$ U_a = U_q - I R_i $
]

#aufgabe(titel: "Leerlauf und Kurzschluss", art: "verstehen", quelle: "2.4.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 182* #linebreak()]
Beschreibe Leerlauf und Kurzschluss: Wie groß sind jeweils $R_a$, $I$, $U_a$ und die Spannung an $R_i$?
][
*Leerlauf:* $R_a = oo$, $I = 0$, $U_a = U_q$, an $R_i$ 0 V. Kurzschluss: $R_a = 0$, $I = I_k = U_q\/R_i$, $U_a = 0$, an $R_i$ liegt ganz $U_q$.
][
*Ergänzung aus der früheren Quizfrage:* _Im Leerlauf ist die Klemmenspannung gleich \_\_\_, im Kurzschluss ist sie \_\_\_ V._

*Antwort:* Im Leerlauf ist die Klemmenspannung gleich #strong[der Quellspannung], im Kurzschluss ist sie #strong[0] V.

*Erklärung:* Leerlauf: kein Strom, also fällt an $R_i$ nichts ab und $U_a = U_q$. Kurzschluss: die Pole sind direkt verbunden, $U_a = 0$, die ganze Quellspannung fällt an $R_i$ ab.
][
*Ergänzung aus der früheren Karteikarte:* _Was passiert im Leerlauf und im Kurzschluss?_

*Antwort:*
- Leerlauf ($R_a = infinity$): kein Strom, an $R_i$ fällt nichts ab, die Klemmenspannung ist maximal: $U_a = U_q$.
- Kurzschluss ($R_a = 0$): maximaler Strom $I_k = U_q\/R_i$, die Klemmenspannung ist null, die ganze Spannung fällt innen ab.

*Merksatz:* Leerlauf: Strom null. Kurzschluss: Klemmenspannung null.
#image("abbildungen/skript-grundstromkreis.svg", width: 80%)
]

#aufgabe(titel: "Hinweise auf den Innenwiderstand", art: "verstehen", quelle: "2.4.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 183* #linebreak()]
Woran merkt man, dass eine reale Quelle einen Innenwiderstand haben muss?
][
*Antwort:* Der Kurzschlussstrom ist endlich, und die Klemmenspannung sinkt unter Last. Bei einer idealen Quelle wäre $I_k$ unendlich.
][
*Ergänzung aus der früheren Karteikarte:* _Woran merkt man, dass eine reale Quelle einen Innenwiderstand haben muss?_

*Antwort:*
- Bei einer idealen Quelle würde im Kurzschluss ein unendlich großer Strom fließen.
- Tatsächlich ist der Kurzschlussstrom endlich, und die Klemmenspannung sinkt unter Last.
- Irgendetwas in der Quelle begrenzt also den Strom: der Innenwiderstand $R_i$.
#image("abbildungen/grundstromkreis.svg", width: 80%)
]

#aufgabe(titel: "Arbeitspunkt grafisch finden", art: "verstehen", quelle: "2.4.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 184* #linebreak()]
Wie findet man den Arbeitspunkt grafisch? Was passiert mit ihm, wenn $R_a$ kleiner wird?
][
*Antwort:* Quellenkennlinie (von $I_k$ bis $U_q$) und Widerstandsgerade (Ursprungsgerade, Steigung $1\/R_a$) einzeichnen; der Schnittpunkt ist der AP. Kleineres $R_a$: Gerade steiler, AP wandert Richtung Kurzschluss (mehr Strom, weniger Spannung).
][
*Ergänzung aus der früheren Quizfrage:* _Wird der Außenwiderstand $R_a$ im Grundstromkreis kleiner, wohin wandert der Arbeitspunkt im $I$-$U$-Diagramm?_

*Antwort:* Nach links oben: mehr Strom, weniger Spannung.

*Begründung:* Die Widerstandsgerade wird steiler und schneidet die Quellenkennlinie näher am Kurzschlusspunkt.

*Typische Verwechslung:*
- Nach rechts unten: weniger Strom, mehr Spannung. – So wandert er, wenn $R_a$ größer wird, also Richtung Leerlauf.
- Gar nicht, die Quellenkennlinie bleibt ja gleich. – Die Quellenkennlinie bleibt gleich, aber die Widerstandsgerade dreht sich, und damit verschiebt sich der Schnittpunkt.
][
*Ergänzung aus der früheren Karteikarte:* _Wie findet man den Arbeitspunkt grafisch?_

*Antwort:*
- Beide Kennlinien im selben $I$-$U$-Diagramm zeichnen.
- *Quelle:* fallende Gerade von $I_k$ auf der Stromachse bis $U_q$ auf der Spannungsachse.
- *Verbraucher:* Ursprungsgerade mit Steigung $1\/R_a$.
- *Schnittpunkt:* Strom und Spannung passen dort zu Quelle und Verbraucher.

*Merksatz:* Der Schnittpunkt muss Quelle und Last zugleich passen.
#image("abbildungen/zf-kennlinie.svg", width: 80%)
][
*Ergänzung aus der früheren Karteikarte:* _Was passiert mit dem Arbeitspunkt, wenn R\_a kleiner wird?_

*Antwort:*
- Die Widerstandsgerade wird steiler, der Arbeitspunkt wandert nach links oben: mehr Strom, weniger Klemmenspannung.
- Wird $R_a$ größer, wandert er Richtung Leerlauf.
#image("abbildungen/zf-kennlinie.svg", width: 80%)
]

#aufgabe(titel: "Quellenkennlinie und Widerstandsgerade", art: "verstehen", quelle: "2.4.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 185* #linebreak()]
Welche Steigung hat die Quellenkennlinie, wo schneidet sie die Achsen? Was bedeutet eine steilere Widerstandsgerade?
][
*Antwort:* Steigung $-1\/R_i$; sie schneidet die $I$-Achse bei $I_k$ und die $U$-Achse bei $U_q$. Eine steilere Widerstandsgerade bedeutet einen kleineren Widerstand.
][
*Ergänzung aus der früheren Karteikarte:* _Welche Steigung hat die Quellenkennlinie, und was bedeutet eine steilere Kennlinie?_

*Antwort:*
- Die Steigung ist $-1\/R_i$.
- Eine steilere Quellenkennlinie heißt kleinerer Innenwiderstand, also eine „steifere“ Quelle, deren Spannung unter Last weniger einbricht.
#image("abbildungen/zf-kennlinie.svg", width: 80%)
]

#aufgabe(titel: "Kurzschlussstrom einer 9-V-Quelle", art: "verstehen", quelle: "2.4.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 186* #linebreak()]
Eine reale Quelle hat $U_q = 9 thin "V"$ und $R_i = 300 thin Omega$. Wie groß ist der Kurzschlussstrom? Begründe deine Antwort.
][
*Antwort:* 30 mA.

*Begründung:* $I_k = U_q\/R_i = 9\/300 thin "A"$.
][
*Typische Verwechslung:*
- Unendlich groß – Das gilt nur für eine ideale Quelle. Der Innenwiderstand begrenzt den Strom.
- 0 A, weil im Kurzschluss keine Spannung anliegt – Die Klemmenspannung ist null, aber gerade deshalb fließt der größte Strom.
- 2,7 kA – Hier wurde $U_q dot R_i$ statt $U_q\/R_i$ gerechnet.
]

#aufgabe(titel: "Verbraucherzählpfeilsystem", art: "verstehen", quelle: "2.4.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 187* #linebreak()]
Was sagt das Verbraucherzählpfeilsystem?
][
*Antwort:*
- Am Verbraucher werden Strom- und Spannungspfeil gleichgerichtet gewählt.
- Bei positivem Spannungswert weist der Pfeil vom höheren zum niedrigeren Potenzial
- ein negativer Wert bezeichnet die umgekehrte tatsächliche Reihenfolge.
- Der Maschenumlauf ergibt $U_i + U_a - U_q = 0$.
#image("abbildungen/skript-grundstromkreis.svg", width: 80%)
]

#aufgabe(titel: "Quelle aus zwei Messpunkten", art: "rechnen", quelle: "2.4.1", herkunft: "variante", vorlage: "Altklausur (Jahr unbekannt), S. 2", minuten: 12,
  ergebnis: [$R_i = 1 thin Omega$, $U_q = 12 thin "V"$],
  tipp: [Schreibe $U = U_q - I R_i$ für beide Messungen auf und ziehe die Gleichungen voneinander ab.],
)[
#if not web [*Aufgabe 188* #linebreak()]
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

#aufgabe(titel: "Innenwiderstand einer Autobatterie", art: "rechnen", quelle: "2.4.1", herkunft: "variante", vorlage: "Fragenkatalog Einstieg GET, Frage 27", minuten: 12,
  ergebnis: [a) $R_i = 30 thin "m"Omega$ b) $U = "8,1" thin "V"$],
  tipp: [Im Kurzschluss bremst nur noch der Innenwiderstand den Strom.],
)[
#if not web [*Aufgabe 189* #linebreak()]
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

#aufgabe(titel: "Grundstromkreis mit 12 V", art: "rechnen", quelle: "2.4.1", herkunft: "eigen", minuten: 12,
  ergebnis: [$I = 2 thin "A"$, $U_a = 11 thin "V"$, $U_i = 1 thin "V"$, $eta approx "91,7" thin %$],
)[
#if not web [*Aufgabe 190* #linebreak()]
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

#aufgabe(titel: "Heizgerät an langer Leitung", art: "rechnen", quelle: "2.4.1", herkunft: "eigen", minuten: 18)[
#if not web [*Aufgabe 191* #linebreak()]
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
*Lösung:* $R_L = "0,0178" dot.c 60\/"1,5" approx "0,712" thin Omega$ (Hin- und Rückleiter: 60 m)
][
*Lösung:* $R_H = U^2\/P = 230^2\/2000 approx "26,45" thin Omega$
][
*Lösung:* $I = 230\/("26,45" + "0,712") approx "8,47" thin "A"$; $U_H = "8,47" dot.c "26,45" approx 224 thin "V"$; $P_V = "8,47"^2 dot.c "0,712" approx 51 thin "W"$
][
*Lösung:* $S = "8,47"\/"1,5" approx "5,6" thin "A/mm"^2$, gerade noch im Bereich bis 6 A/mm².
][
*Prüfung:* $224 thin "V" + "8,47" thin "A" dot.c "0,712" thin Omega approx 230 thin "V"$.
]

#aufgabe(titel: "Kennlinien zeichnen", art: "rechnen", quelle: "2.4.1", herkunft: "eigen", minuten: 15,
  ergebnis: [a) 2 Ω b) 2 Ω, 18 W c) 75 % d) AP bei 1,5 A und 9 V],
  tipp: [Die Quellenkennlinie ist die Gerade zwischen Kurzschlussstrom und Leerlaufspannung.],
)[
#if not web [*Aufgabe 192* #linebreak()]
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

#aufgabe(titel: "Leistung im Kohleschicht-Widerstand", art: "rechnen", quelle: "2.4.1", herkunft: "original", vorlage: "Übung GET, Aufg. 1b", minuten: 5)[
#if not web [*Aufgabe 193* #linebreak()]
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
*Gesamtwiderstand:* $R = 100 thin "k"Omega$; Strom: $I = 10 thin "V"/(100 thin "k"Omega) = "0,1" thin "mA"$.
][
*Teilspannungen:* $U_K = I R_K = 8 thin "V"$, $U_S = I R_S = 2 thin "V"$.
][
*Leistungen:* $P_K = 8 thin "V" dot.c "0,1" thin "mA" = "0,8" thin "mW"$; $P_S = "0,2" thin "mW"$.
][
*Ergebnis: 800 µW im Kohleschicht-Widerstand*, wie in Ü-N und DC. *Prüfung:* $10 - 8 - 2 = 0$ V; die Quelle liefert $10 thin "V" dot.c "0,1" thin "mA" = 1 thin "mW"$, gleich der Summe beider Leistungen. Der äußere Serienwiderstand erfüllt rechnerisch dieselbe Rolle wie ein Innenwiderstand.
#src([Ü 1b; Ü-N, PDF-S. 4; DC, PDF-S. 3.])
]

#aufgabe(titel: "Leistung im 50-kΩ-Schichtwiderstand (Variante)", art: "rechnen", quelle: "2.4.1", herkunft: "variante", vorlage: "Übung GET, Aufg. 1b", minuten: 5,
  ergebnis: [$I = "0,15" thin "mA"$, $U = "7,5" thin "V"$, $P = "1,125" thin "mW"$],
)[
#if not web [*Aufgabe 194* #linebreak()]
*Gegeben und Annahmen*

Ein Kohleschichtwiderstand $R_K = 50 thin "k"Omega$ liegt mit einem Serienwiderstand $R_S = 30 thin "k"Omega$ an einer idealen Spannungsquelle $U_q = 12 thin "V"$.

*Gesucht*

#enum(numbering: "a)",
[Strom im Kreis.],
[Spannung am Kohleschichtwiderstand.],
[Welche Leistung wird im Kohleschichtwiderstand in Wärme umgesetzt?],
)
][
*Reihenschaltung:* Ein einziger Strompfad: $I = U_q\/(R_S + R_K) = 12 thin "V"\/80 thin "k"Omega = "0,15" thin "mA"$.
][
*Teilspannung:* $U_K = I R_K = "0,15" thin "mA" dot.c 50 thin "k"Omega = "7,5" thin "V"$ (Teilerregel: $12 dot.c 50\/80$).
][
*Leistung:* $P_K = U_K I = "7,5" thin "V" dot.c "0,15" thin "mA" = "1,125" thin "mW"$. Nur die Leistung im betrachteten Widerstand zählt, nicht die der ganzen Schaltung.
]

#aufgabe(titel: "Arbeit beim Laden eines Akkus", art: "rechnen", quelle: "2.4.1", herkunft: "original", vorlage: "Übungsblatt B, Aufg. 17", minuten: 5)[
#if not web [*Aufgabe 195* #linebreak()]
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
*Lösung:* $U_i = R_i dot.c I = "0,5" thin Omega dot.c "0,1" thin "A" = "0,05" thin "V"$
][
*Lösung:* $U = U_q + U_i = "4,85" thin "V"$
][
*Lösung:* $W = U dot.c I dot.c t = "4,85" thin "V" dot.c "0,1" thin "A" dot.c 16 thin "h" = "7,76" thin "Wh"$
][
*Ergebnis:* $W approx "7,76" thin "Wh"$, wie in R S. 9. *Prüfung:* Ohne Innenwiderstand wären es 7,68 Wh; der kleine Zuschlag ist die Wärme in $R_i$. Achtung: Beim Laden ist das Vorzeichen anders als beim Entladen ($U = U_q - I R_i$).
]

#aufgabe(titel: "Arbeit beim Laden eines Akkupacks (Variante)", art: "rechnen", quelle: "2.4.1", herkunft: "variante", vorlage: "Übungsblatt B, Aufg. 17", minuten: 5,
  ergebnis: [$U = "7,26" thin "V"$, $W approx "20,3" thin "Wh"$],
)[
#if not web [*Aufgabe 196* #linebreak()]
*Gegeben und Annahmen*

Sechs Ni-MH-Zellen in Reihe haben zusammen die Nennspannung 7,2 V und den Innenwiderstand 0,3 Ω. Der Akku wird 14 h lang mit dem Konstantstrom 0,2 A geladen. Die Quellspannung des Akkus sei während des Ladens konstant.

*Gesucht*

#enum(numbering: "a)",
[Klemmenspannung während des Ladens.],
[Am Akku verrichtete elektrische Arbeit.],
)
][
*Ladestrom fließt hinein:* Beim Laden wird der Strom gegen die Quellspannung in den Akku gedrückt. Das Ladegerät muss deshalb zusätzlich den Abfall am Innenwiderstand liefern: $U = U_q + I R_i = "7,2" + "0,2" dot.c "0,3" = "7,26" thin "V"$.
][
*Arbeit:* $W = U I t = "7,26" thin "V" dot.c "0,2" thin "A" dot.c 14 thin "h" approx "20,3" thin "Wh"$. Davon werden $I^2 R_i t = "0,168" thin "Wh"$ im Innenwiderstand zu Wärme.
]

#aufgabe(titel: "Leistungen im Kennliniendiagramm", art: "verstehen", quelle: "2.4.1.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 197* #linebreak()]
Wo sieht man im Kennliniendiagramm die Leistungen?
][
*Antwort:*
- Das Rechteck unter dem Arbeitspunkt ($U_a dot I$) ist die Verbraucherleistung.
- Das Rechteck rechts daneben bis $U_q$ ($U_i dot I$) ist die Verlustleistung in der Quelle.
- Zusammen ergeben sie die Quellenleistung.
#image("abbildungen/zf-kennlinie.svg", width: 80%)
]

#aufgabe(titel: "Reale Quellen in Reihe und parallel vergleichen", art: "verstehen", quelle: "2.4.1.2", herkunft: "eigen", minuten: 3,
 ergebnis: [Reihe: $2U_q$, $2R_i$; gegenläufig: 0, $2R_i$; parallel: $U_q$, $R_i/2$.])[
#if not web [*Aufgabe 198* #linebreak()]
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

#aufgabe(titel: "Gegensinnige Quellen: Innenwiderstände addieren sich", art: "verstehen", quelle: "2.4.1.2", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 199* #linebreak()]
Warum addieren sich bei gegensinnig in Reihe geschalteten Quellen die Innenwiderstände trotzdem?
][
*Antwort:* Die Widerstände verursachen Spannungsabfälle durch denselben Strom. Ihre positiven Widerstandswerte addieren sich; nur die Quellspannungen erhalten je nach Polung unterschiedliche Vorzeichen.
]

#aufgabe(titel: "Parallele Quellen werden steifer", art: "verstehen", quelle: "2.4.1.2", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 200* #linebreak()]
Warum werden gleiche Quellen parallel steifer, ohne ihre Quellspannung zu erhöhen?
][
*Antwort:*
- Beide Quellen halten dieselbe Leerlaufspannung.
- Unter Last übernimmt jede einen Teil des Stroms, sodass ihr innerer Spannungsabfall kleiner wird.
- Im symmetrischen Modell halbiert sich bei zwei Quellen der Ersatzinnenwiderstand.
- Das setzt gleiche Parameter und passende Polung voraus.
#image("abbildungen/gesamt-quellen-parallel.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Zwei gleiche reale Spannungsquellen werden gleich gepolt parallel verbunden. Welche Ersatzgrößen gelten?_

*Antwort:* Die Quellspannung bleibt gleich, der Innenwiderstand halbiert sich.

*Begründung:* Beide Quellen liegen an denselben Klemmen und teilen den Laststrom symmetrisch.

*Typische Verwechslung:*
- Die Quellspannung verdoppelt sich, der Innenwiderstand bleibt gleich. – Das beschreibt auch eine Reihenschaltung nicht vollständig; parallel erhöht sich die Spannung nicht.
- Quellspannung und Innenwiderstand verdoppeln sich. – Das gilt für zwei gleiche unterstützend in Reihe geschaltete reale Quellen.
]

#aufgabe(titel: "Wo die fehlende Klemmenspannung bleibt", art: "verstehen", quelle: "2.4.2", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 201* #linebreak()]
Wo fällt die Differenz zwischen Leerlauf- und Klemmenspannung ab?
][
*Antwort:*
- Immer am Innenwiderstand.
- Daraus bestimmt man $R_i$:
$ R_i = (U_"Leerlauf" - U_"Klemme")/I $
]

#aufgabe(titel: "Reale Quelle aus zwei Belastungen", art: "rechnen", quelle: "2.4.2", herkunft: "original", vorlage: "Altklausur (Jahr unbekannt), S. 2", minuten: 8,
  ergebnis: [$I_1 = "1,0" thin "A"$, $I_2 = "1,5" thin "A"$, $R_i = "2,0" thin Omega$, $U_q = "12,0" thin "V"$],
  tipp: [Die Stromänderung erzeugt am Innenwiderstand genau die Spannungsänderung an den Klemmen.],
)[
#if not web [*Aufgabe 202* #linebreak()]
*Gegeben und Annahmen*

Eine reale Spannungsquelle soll durch die Reihenschaltung einer Konstantspannungsquelle (Quellspannung $U_q$) und eines Innenwiderstands $R_i$ dargestellt werden. Die Quelle wird a) durch einen Widerstand $R_1 = "10,0" thin Omega$ und b) durch einen Widerstand $R_2 = "6,0" thin Omega$ belastet. Die Klemmenspannungen betragen dabei $U_1 = "10,0" thin "V"$ bzw. $U_2 = "9,0" thin "V"$.

*Gesucht*

#enum(numbering: "a)",
[Wie groß sind der Innenwiderstand $R_i$ und die Quellspannung $U_q$ der Spannungsquelle?],
)
][
*Ströme der beiden Fälle:* $I_1 = U_1\/R_1 = "1,0" thin "A"$, $I_2 = U_2\/R_2 = "1,5" thin "A"$. Der kleinere Lastwiderstand zieht mehr Strom.
][
*Innenwiderstand:* In beiden Fällen gilt $U = U_q - I R_i$. Die Differenz der beiden Gleichungen streicht $U_q$: $R_i = (U_1 - U_2)\/(I_2 - I_1) = "1,0" thin "V"\/"0,5" thin "A" = "2,0" thin Omega$.
][
*Quellspannung:* $U_q = U_1 + I_1 R_i = 10 + 1 dot.c 2 = "12,0" thin "V"$. Probe mit Fall b: $9 + "1,5" dot.c 2 = 12 thin "V"$.
]

#aufgabe(titel: "Innenwiderstand des Netzes", art: "rechnen", quelle: "2.4.2", herkunft: "original", vorlage: "Übung GET, Aufg. 3", minuten: 6,
  ergebnis: [$I approx "6,99" thin "A"$, $R_i approx "1,7" thin Omega$],
  tipp: [Die 12 V, die beim Einschalten fehlen, fallen im Netz selbst ab.],
)[
#if not web [*Aufgabe 203* #linebreak()]
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
][
*Ergänzung aus der früheren Quizfrage:* _Ein Heizwiderstand am Netz senkt die Klemmenspannung von 230 V (Leerlauf) auf 218 V, es fließen rund 7 A. Wie groß ist der Innenwiderstand des Netzes ungefähr?_

*Antwort:* 1,7 Ω.

*Begründung:* Die Differenz 12 V fällt an $R_i$ ab: $R_i = 12 thin "V"\/"6,99" thin "A"$.

*Typische Verwechslung:*
- 31,2 Ω – Das ist der Heizwiderstand, also der Außenwiderstand.
- 33 Ω – So groß wäre der Widerstand des ganzen Kreises, $230 thin "V"\/7 thin "A"$.
- 0 Ω, das Netz ist eine ideale Quelle – Dann würde die Spannung unter Last nicht sinken.
]

#aufgabe(titel: "Innen- und Lastwiderstand aus einer Messung", art: "rechnen", quelle: "2.4.2", herkunft: "variante", vorlage: "Übung GET, Aufg. 3", minuten: 12,
  ergebnis: [$R_i = 1 thin Omega$, $R_a = 14 thin Omega$],
)[
#if not web [*Aufgabe 204* #linebreak()]
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

#aufgabe(titel: "Spannung bei Leistungsanpassung", art: "verstehen", quelle: "2.4.3", herkunft: "original", vorlage: "Fragenkatalog Einstieg GET, Frage 30", minuten: 3,
)[
#if not web [*Aufgabe 205* #linebreak()]
Eine Spannungsquelle mit Innenwiderstand $R_i$ wird leistungsangepasst beschaltet. Welcher Spannungsabfall wird am Abschlusswiderstand $R_a$ gemessen? Begründe.
][
*Antwort:* Die *halbe Leerlaufspannung*, $U_a = U_q\/2$.
][
*Begründung:* Leistungsanpassung heißt $R_a = R_i$. Dann bilden $R_i$ und $R_a$ einen Spannungsteiler aus zwei gleichen Widerständen: $U_a = U_q dot.c R_a\/(R_i + R_a) = U_q\/2$. Die andere Hälfte fällt innen an $R_i$ ab, deshalb ist der Wirkungsgrad nur 50 %.
][
*Typische Verwechslung:* Die volle Leerlaufspannung gäbe es nur im Leerlauf ($I = 0$, also keine Leistung); ein Viertel von $U_q$ verwechselt die Spannung mit dem Faktor in $P_"max" = U_q^2\/(4 R_i)$.
]

#aufgabe(titel: "Leistungsanpassung", art: "verstehen", quelle: "2.4.3", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 206* #linebreak()]
Was ist Leistungsanpassung? Welcher Wirkungsgrad ergibt sich, wie groß sind dann $U_a$ und $I$, und wo setzt man sie ein bzw. vermeidet sie?
][
*Antwort:* $R_a = R_i$: maximale Leistung am Verbraucher, $eta = 50 thin %$, $U_a = U_q\/2$, $I = I_k\/2$. Erwünscht in der Nachrichtentechnik, vermieden in der Energietechnik ($R_a >> R_i$).
][
*Ergänzung aus der früheren Quizfrage:* _Warum betreibt man Kraftwerke und Netze nicht bei Leistungsanpassung, Antennen und Lautsprecher aber schon?_

*Antwort:* Bei Anpassung bekommt der Verbraucher die größte Leistung, aber nur mit 50 % Wirkungsgrad, die andere Hälfte geht in der Quelle verloren. In der Energietechnik zählen die Verluste, deshalb wählt man $R_a >> R_i$ und nimmt etwas weniger als die Höchstleistung in Kauf. In der Nachrichtentechnik geht es um kleine Signale; dort zählt, möglichst viel Signalleistung zu übertragen, der Wirkungsgrad ist zweitrangig.
][
*Ergänzung aus der früheren Karteikarte:* _Was ist Leistungsanpassung?_

*Antwort:*
- Der Verbraucher bekommt die meiste Leistung, wenn $R_a = R_i$.
- Dann teilt sich die Spannung genau zur Hälfte, und der Strom ist halb so groß wie der Kurzschlussstrom.
- *Der Wirkungsgrad ist dabei nur 50 %:* Die Quelle verheizt innen genauso viel, wie beim Verbraucher ankommt.

*Merksatz:* Maximale Lastleistung heißt hier nur 50 % Wirkungsgrad.
#image("abbildungen/skript-anpassung.svg", width: 80%)
][
*Ergänzung aus der früheren Karteikarte:* _Wo setzt man Leistungsanpassung ein, und wo vermeidet man sie?_

*Antwort:*
- In der Nachrichtentechnik (Antenne, Lautsprecher) ist sie erwünscht, dort zählt maximale Signalleistung.
- In der Energietechnik (Kraftwerk, Netz) vermeidet man sie und wählt $R_a >> R_i$, dort zählt der Wirkungsgrad.
#image("abbildungen/skript-anpassung.svg", width: 80%)
]

#aufgabe(titel: "Wirkungsgrad im Grundstromkreis", art: "verstehen", quelle: "2.4.3", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 207* #linebreak()]
Wie hängt der Wirkungsgrad im Grundstromkreis von $R_a$ ab? Wann ist er null, wann steigt er?
][
*Antwort:* $eta = R_a\/(R_i + R_a)$: steigt, je größer $R_a$ gegenüber $R_i$ wird; im Kurzschluss ($R_a = 0$) ist $eta = 0$. Bei Anpassung ist $P_a$ maximal, nicht $eta$.
][
*Ergänzung aus der früheren Karteikarte:* _Wie hängt der Wirkungsgrad im Grundstromkreis von R\_a ab?_

*Antwort:*
$ eta = R_a/(R_a + R_i) $
- Im Kurzschluss ist er null.
- Je größer $R_a$ gegenüber $R_i$, desto näher an 100 %.
- Bester Wirkungsgrad und maximale Leistung sind also nicht derselbe Fall.
#image("abbildungen/skript-anpassung.svg", width: 80%)
]

#aufgabe(titel: "Aussagen zur Leistungsanpassung prüfen", art: "verstehen", quelle: "2.4.3", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 208* #linebreak()]
Welche Aussagen zur Leistungsanpassung $R_a = R_i$ stimmen? Beurteile jede der folgenden Aussagen: richtig oder falsch? Begründe jeweils.
- Der Verbraucher bekommt die größtmögliche Leistung $U_q^2\/(4 R_i)$.
- Der Wirkungsgrad beträgt nur 50 %.
- Das ist der Betriebsfall mit dem besten Wirkungsgrad.
- Die Klemmenspannung ist halb so groß wie die Quellspannung.
][
*Richtig:*
- Der Verbraucher bekommt die größtmögliche Leistung $U_q^2\/(4 R_i)$. – Bei kleinerem $R_a$ fehlt Spannung, bei größerem fehlt Strom.
- Der Wirkungsgrad beträgt nur 50 %. – Innen wird genauso viel Leistung verheizt, wie außen ankommt.
- Die Klemmenspannung ist halb so groß wie die Quellspannung. – Gleiche Widerstände teilen die Spannung zu gleichen Teilen.
][
*Falsch:*
- Das ist der Betriebsfall mit dem besten Wirkungsgrad. – Der Wirkungsgrad steigt mit $R_a\/R_i$. Deshalb betreibt man Kraftwerke mit $R_a >> R_i$.
]

#aufgabe(titel: "Wirkungsgrad bei 300 Ω und 500 Ω", art: "verstehen", quelle: "2.4.3", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 209* #linebreak()]
Für $U_q = 9 thin "V"$, $R_i = 300 thin Omega$ und $R_a = 500 thin Omega$: Wie groß ist der Wirkungsgrad? Begründe deine Antwort.
][
*Antwort:* 62,5 %.

*Begründung:* $eta = R_a\/(R_i + R_a) = 500\/800$.
][
*Typische Verwechslung:*
- 37,5 % – Das ist der Anteil, der am Innenwiderstand verloren geht, $300\/800$.
- 60 % – Das wäre $300\/500$, also das Verhältnis der Widerstände, nicht der Leistungen.
- 50 % – 50 % gilt nur bei Anpassung, also $R_a = R_i$.
]

#aufgabe(titel: "Warum die Verbraucherleistung ein Maximum hat", art: "verstehen", quelle: "2.4.3", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 210* #linebreak()]
Warum gibt es bei der Verbraucherleistung ein Maximum?
][
*Antwort:*
- Bei $R_a = 0$ fließt viel Strom, aber die Spannung ist null, also $P = 0$.
- Bei $R_a = infinity$ ist die Spannung maximal, aber der Strom null, also wieder $P = 0$.
- Dazwischen muss ein Maximum liegen, und das liegt bei $R_a = R_i$.
#image("abbildungen/skript-anpassung.svg", width: 80%)
]

#aufgabe(titel: "Innenwiderstand des Hochvoltnetzes und Höchstleistung", art: "rechnen", quelle: "2.4.3", herkunft: "original", vorlage: "Altklausur (Jahr unbekannt 2), F4", minuten: 10, platz: 14,
  ergebnis: [a) $P_"max" = "62,5" thin "kW"$ b) $R_a = 1 thin Omega$ c) Gerade von (0 V; 500 A) nach (500 V; 0), Arbeitspunkt (250 V; 250 A)],
  tipp: [Maximale Leistung bei Anpassung $R_a = R_i$.],
)[
#if not web [*Aufgabe 211* #linebreak()]
*Gegeben und Annahmen*

Die Leerlaufspannung einer Hochvolt-Spannungsquelle ist 500 V, ihr Innenwiderstand 1 Ω.

*Gesucht*

#enum(numbering: "a)",
[Welche maximale Leistung kann ein elektrischer Verbraucher aus dieser Spannungsquelle ziehen?],
[Welchen Widerstand weist ein Verbraucher auf, der diese maximale elektrische Leistung abnimmt?],
[Stelle die Lösung von a) und b) im Strom-Spannungs-Diagramm dar.],
)
][
*b) Bedingung zuerst:* Die Verbraucherleistung ist maximal bei Leistungsanpassung $R_a = R_i = 1 thin Omega$. Ein kleinerer Lastwiderstand zieht zwar mehr Strom, aber die Klemmenspannung bricht stärker ein.
][
*a) Höchstleistung:* $I = U_l\/(R_i + R_a) = 250 thin "A"$, $U_a = 250 thin "V"$, $P_"max" = U_a I = U_l^2\/(4 R_i) = 500^2\/4 thin "W" = 62 thin 500 thin "W" = "62,5" thin "kW"$.
][
*c) Diagramm:* Quellenkennlinie als Gerade von $(0 thin "V"; I_k = 500 thin "A")$ nach $(500 thin "V"; 0 thin "A")$. Widerstandsgerade für 1 Ω durch den Ursprung mit Steigung 1 A/V. Schnittpunkt = Arbeitspunkt (250 V; 250 A), genau in der Mitte der Quellengeraden. Die Leistung ist die Rechteckfläche $250 thin "V" dot.c 250 thin "A"$.
][
*Prüfen:* In $R_i$ werden ebenfalls 62,5 kW umgesetzt; Wirkungsgrad 50 %. Für ein echtes Hochvoltnetz wäre das untragbar, darum betreibt man Netze nie in Anpassung.
]

#aufgabe(titel: "Höchstleistung einer 48-V-Quelle (Variante)", art: "rechnen", quelle: "2.4.3", herkunft: "variante", vorlage: "Altklausur (Jahr unbekannt 2), F4", minuten: 8, platz: 12,
  ergebnis: [$R_a = "0,2" thin Omega$, $P_"max" = 2880 thin "W"$, $I_k = 240 thin "A"$, Arbeitspunkt (24 V; 120 A)],
)[
#if not web [*Aufgabe 212* #linebreak()]
*Gegeben und Annahmen*

Ein 48-V-Batteriesystem hat die Leerlaufspannung 48 V und den Innenwiderstand 0,2 Ω.

*Gesucht*

#enum(numbering: "a)",
[Bei welchem Lastwiderstand gibt die Quelle die größte Leistung ab, und wie groß ist sie?],
[Zeichne Quellenkennlinie und Widerstandsgerade und markiere den Arbeitspunkt.],
[Wie groß ist dann der Wirkungsgrad?],
)
][
*a) Anpassung:* $R_a = R_i = "0,2" thin Omega$; $P_"max" = U_l^2\/(4 R_i) = 48^2\/"0,8" = 2880 thin "W"$.
][
*b) Diagramm:* $I_k = 48\/"0,2" = 240 thin "A"$. Gerade von (0 V; 240 A) nach (48 V; 0). Die Lastgerade durch den Ursprung hat die Steigung 5 A/V und schneidet bei (24 V; 120 A).
][
*c) Wirkungsgrad:* $eta = R_a\/(R_i + R_a) = 50 thin %$; die halbe Energie heizt die Batterie.
]

#aufgabe(titel: "Grundstromkreis vollständig berechnen", art: "rechnen", quelle: "2.4.3", herkunft: "eigen", minuten: 15,
  ergebnis: [$I = 2 thin "A"$, $U_a = 20 thin "V"$, $U_i = 4 thin "V"$, $P_a = 40 thin "W"$, $P_i = 8 thin "W"$, $P_q = 48 thin "W"$, $eta approx "83,3" thin %$],
)[
#if not web [*Aufgabe 213* #linebreak()]
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

#aufgabe(titel: "Höchstleistung einer Starterbatterie", art: "rechnen", quelle: "2.4.3", herkunft: "original", vorlage: "Übungsblatt A, Aufg. 2", minuten: 5,
  ergebnis: [$R_a = 40 thin "m"Omega$, $P_"max" approx "1,2" thin "kW"$],
)[
#if not web [*Aufgabe 214* #linebreak()]
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

#aufgabe(titel: "Maximale Leistung derselben Quelle", art: "rechnen", quelle: "2.4.3", herkunft: "variante", vorlage: "Übungsblatt A, Aufg. 2", minuten: 12,
  ergebnis: [$R_a = 2 thin Omega$, $P_"a,max" = 72 thin "W"$ bei $eta = 50 thin %$],
  tipp: [Leistungsanpassung: Bei welchem Lastwiderstand bekommt der Verbraucher am meisten?],
)[
#if not web [*Aufgabe 215* #linebreak()]
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

#aufgabe(titel: "Größte Leistung einer 9-V-Batterie", art: "rechnen", quelle: "2.4.3", herkunft: "variante", vorlage: "Übungsblatt A, Aufg. 2", minuten: 12,
  ergebnis: [$R_a = 2 thin Omega$, $P_"a,max" approx "10,1" thin "W"$, $I = "2,25" thin "A"$, $U_a = "4,5" thin "V"$],
)[
#if not web [*Aufgabe 216* #linebreak()]
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

#aufgabe(titel: "Wann die Teilerregel direkt gilt", art: "verstehen", quelle: "2.4.4", herkunft: "eigen", minuten: 2,
  tipp: [Prüfe, ob beide Widerstände wirklich denselben Strom führen.],
)[
#if not web [*Aufgabe 217* #linebreak()]
Wann darf die unbelastete Spannungsteilerregel unmittelbar auf zwei Widerstände angewendet werden? Begründe deine Antwort.
][
*Antwort:* Wenn beide denselben Strom führen und am Abgriff kein zusätzlicher Strom entnommen wird.

*Begründung:* Die Regel folgt aus den Spannungsabfällen bei gemeinsamem Strom.
][
*Typische Verwechslung:*
- Wenn sie auf dem Blatt nebeneinander stehen. – Die Verbindung der Knoten entscheidet, nicht die Zeichenposition.
- Auch bei beliebigem Laststrom am Zwischenknoten. – Der Laststrom verändert die Stromaufteilung und den wirksamen unteren Widerstand.
]

#aufgabe(titel: "Spannungsteilung proportional zu R", art: "verstehen", quelle: "2.4.4", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 218* #linebreak()]
Warum ist die Spannungsteilung in Reihe proportional zu den Widerständen?
][
*Antwort:*
- Alle Widerstände führen denselben Strom.
- Der Spannungsabfall ist jeweils Strom mal Widerstand.
- Deshalb bekommt der größere Widerstand den größeren Anteil der Gesamtspannung.
- Eine Belastung am Abgriff muss vorher in das Modell aufgenommen werden.
#image("abbildungen/gesamt-serie.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Warum übernimmt der größere Widerstand einer Reihenschaltung den größeren Spannungsabfall?_

*Antwort:* Durch beide fließt derselbe Strom. Mit $U_k=I R_k$ wächst deshalb der Teilspannungsabfall proportional zum Widerstand. Das Verhältnis gilt unter den konstanten ohmschen Bedingungen.
]

#aufgabe(titel: "Vier Widerstände mit einem offenen Zweig", art: "rechnen", quelle: "2.4.4", herkunft: "original", vorlage: "Übungsblatt A, Aufg. 3", minuten: 5,
  ergebnis: [$U = I (R_1 + R_2 + R_4) = 135 thin "V"$ (mit vier gleichen 1,5-kΩ-Widerständen)],
  tipp: [Durch einen Widerstand, dessen eines Ende offen ist, fließt kein Strom.],
)[
#if not web [*Aufgabe 219* #linebreak()]
*Gegeben und Annahmen*

In der Schaltung mit den Widerständen $R_1 = R_2 = R_3 = R_4 = "1,5" thin "k"Omega$ fließt der Strom $I = 30 thin "mA"$. (Auf dem Blatt steht viermal „R1 = 1,5 kΩ“; gemeint sind vier gleiche Widerstände R1 bis R4.) R3 endet an einer offenen Klemme.

#image("abbildungen/blatt-a-vier-widerstaende.svg", width: 80%)

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist die angelegte Spannung $U$?],
)
][
*Offenen Zweig erkennen:* R3 ist nur an einem Ende angeschlossen. Ohne geschlossenen Kreis fließt durch ihn kein Strom, und an ihm fällt keine Spannung ab. Er spielt für $U$ keine Rolle.
][
*Reihenschaltung:* Der Strom $I$ fließt durch R1, R2 und dann durch R4 zurück. $R_"ges" = R_1 + R_2 + R_4 = "4,5" thin "k"Omega$.
][
*Spannung:* $U = I R_"ges" = 30 thin "mA" dot.c "4,5" thin "k"Omega = 135 thin "V"$ (mA mal kΩ ergibt V).
]

#aufgabe(titel: "Offener Zweig mit 680 Ω und 820 Ω (Variante)", art: "rechnen", quelle: "2.4.4", herkunft: "variante", vorlage: "Übungsblatt A, Aufg. 3", minuten: 5,
  ergebnis: [$U = 90 thin "V"$; Spannung an der offenen Klemme gegen unten: $U_4 = "24,6" thin "V"$],
)[
#if not web [*Aufgabe 220* #linebreak()]
*Gegeben und Annahmen*

Gleiche Schaltung wie in Blatt A, Aufg. 3 (R1 und R2 in Reihe, dann R4 nach unten, R3 vom Verbindungsknoten zu einer offenen Klemme). $R_1 = "1,5" thin "k"Omega$, $R_2 = 680 thin Omega$, $R_3 = "2,7" thin "k"Omega$, $R_4 = 820 thin Omega$, $I = 30 thin "mA"$ (diese Werte stehen in der handschriftlichen Lösung zu Blatt A).

#image("abbildungen/blatt-a-vier-widerstaende.svg", width: 80%)

*Gesucht*

#enum(numbering: "a)",
[Angelegte Spannung $U$.],
[Welche Spannung misst ein ideales Voltmeter zwischen der offenen Klemme hinter R3 und der unteren Leitung?],
)
][
*a) Nur der geschlossene Pfad zählt:* $R_"ges" = 1500 + 680 + 820 = 3000 thin Omega$, $U = "0,03" thin "A" dot.c 3000 thin Omega = 90 thin "V"$.
][
*b) Stromloser Widerstand:* Durch R3 fließt kein Strom, also fällt an ihm nichts ab. Die offene Klemme hat dasselbe Potenzial wie der Knoten über R4: $U = I R_4 = "0,03" dot.c 820 = "24,6" thin "V"$.
]

#aufgabe(titel: "Welcher Widerstand in die Stromteilerregel gehört", art: "verstehen", quelle: "2.4.5", herkunft: "eigen", minuten: 2,
  tipp: [Markiere die beiden Knoten der betrachteten Parallelgruppe.],
)[
#if not web [*Aufgabe 221* #linebreak()]
Welcher Widerstand gehört beim Stromteiler in das Verhältnis $I_k/I_"ges"=R_"ges"/R_k$? Begründe deine Antwort.
][
*Antwort:* Der Ersatzwiderstand genau der betrachteten Verzweigung.

*Begründung:* Der Gesamtstrom muss der Strom sein, der in diese Parallelgruppe eintritt.
][
*Typische Verwechslung:*
- Immer der Ersatzwiderstand des gesamten Stromkreises. – Ein äußerer Serienwiderstand gehört nicht zur Stromaufteilung in der Gruppe.
- Nur der größte Widerstand der Parallelgruppe. – Alle parallelen Zweige tragen zum Ersatzleitwert bei.
]

#aufgabe(titel: "Parallelersatz kleiner als jeder Zweig", art: "verstehen", quelle: "2.4.5", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 222* #linebreak()]
Warum ist der Ersatzwiderstand einer Parallelschaltung positiver Widerstände kleiner als jeder einzelne?
][
*Antwort:* Bei derselben Spannung kommen zusätzliche Stromwege hinzu. Die Leitwerte addieren sich, der Gesamtstrom steigt. Deshalb ist der Quotient aus Spannung und Gesamtstrom kleiner.
]

#aufgabe(titel: "Kleinerer Parallelwiderstand, größerer Strom", art: "verstehen", quelle: "2.4.5", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 223* #linebreak()]
Warum erhält der kleinere Parallelwiderstand den größeren Strom?
][
*Antwort:*
- An beiden Zweigen liegt dieselbe Spannung.
- Bei gleichem U führt ein kleinerer Widerstand einen größeren Strom.
- Deshalb teilen sich die Ströme proportional zu den Leitwerten und umgekehrt zu den Widerständen.
#image("abbildungen/gesamt-parallel.svg", width: 80%)
]

#aufgabe(titel: "Kettenleiter aus fünf gleichen Widerständen", art: "rechnen", quelle: "2.4.5", herkunft: "original", vorlage: "Altklausur (Jahr unbekannt), S. 10", minuten: 10,
  ergebnis: [a) $R_"ges" = 160 thin Omega$ b) $U_5 = "2,5" thin "V"$ c) $I_5 = 25 thin "mA"$],
  tipp: [Fang am Ende an: R4 parallel R5, dann in Reihe mit R3, dann parallel zu R2.],
)[
#if not web [*Aufgabe 224* #linebreak()]
*Gegeben und Annahmen*

Eine Spannungsquelle mit $U_q = 20 thin "V"$ ist an die gezeigte Widerstandsschaltung angeschlossen. Alle Widerstände R1 bis R5 haben 100 Ω.

#image("abbildungen/klausur-kettenleiter-r1-r5.svg", width: 85%)

*Gesucht*

#enum(numbering: "a)",
[Gesamtwiderstand $R_"ges"$.],
[Spannung $U_5$ an R5.],
[Wie groß ist der Strom $I_5$?],
)
][
*a) Von hinten zusammenfassen:* $R_(45) = 100 || 100 = 50 thin Omega$; mit R3 in Reihe $150 thin Omega$; parallel zu R2: $100 dot.c 150\/250 = 60 thin Omega$; mit R1: $R_"ges" = 160 thin Omega$. Eine Stern-Dreieck-Umwandlung ist nicht nötig.
][
*b) Spannung zurückrechnen:* $I = 20\/160 = "0,125" thin "A"$; am ersten Querknoten $U_2 = 20 - "0,125" dot.c 100 = "7,5" thin "V"$. Diese Spannung teilt sich auf R3 und $R_(45)$: $U_5 = "7,5" dot.c 50\/150 = "2,5" thin "V"$.
][
*c) Strom:* $I_5 = U_5\/R_5 = 25 thin "mA"$. Probe: durch R3 fließen 50 mA, die sich gleich auf R4 und R5 verteilen.
]

#aufgabe(titel: "Kettenleiter mit 200-Ω-Widerständen (Variante)", art: "rechnen", quelle: "2.4.5", herkunft: "variante", vorlage: "Altklausur (Jahr unbekannt), S. 10", minuten: 10,
  ergebnis: [$R_"ges" = 320 thin Omega$, $U_5 = 3 thin "V"$, $I_5 = 15 thin "mA"$],
)[
#if not web [*Aufgabe 225* #linebreak()]
*Gegeben und Annahmen*

Gleiche Schaltung, $U_q = 24 thin "V"$, alle Widerstände R1 bis R5 je 200 Ω.

#image("abbildungen/klausur-kettenleiter-r1-r5.svg", width: 85%)

*Gesucht*

#enum(numbering: "a)",
[$R_"ges"$, $U_5$ und $I_5$.],
[Welcher Anteil des Eingangsstroms kommt in R5 an?],
)
][
*a) Ersatz:* $R_(45) = 100 thin Omega$, $+ R_3 = 300 thin Omega$, $|| R_2 = 120 thin Omega$, $+ R_1 = 320 thin Omega$.
][
*a) Zurückrechnen:* $I = 24\/320 = 75 thin "mA"$, $U_2 = 24 - "0,075" dot.c 200 = 9 thin "V"$, $U_5 = 9 dot.c 100\/300 = 3 thin "V"$, $I_5 = 3\/200 = 15 thin "mA"$.
][
*b) Anteil:* $15\/75 = 20 thin %$, genau wie im Original ($25\/125$): Werden alle Widerstände gleich skaliert, bleiben die Teilungsverhältnisse gleich.
]

#aufgabe(titel: "Netzwerk mit vier Strömen", art: "rechnen", quelle: "2.4.5", herkunft: "original", vorlage: "Altklausur (Jahr unbekannt), S. 4", minuten: 10,
  ergebnis: [$I_1 approx 519 thin "mA"$, $I_2 approx 168 thin "mA"$, $I_3 approx 211 thin "mA"$, $I_4 approx 140 thin "mA"$],
)[
#if not web [*Aufgabe 226* #linebreak()]
*Gegeben und Annahmen*

Die Schaltung mit $R_1 = 30 thin Omega$, $R_2 = 50 thin Omega$, $R_3 = 40 thin Omega$, $R_4 = 50 thin Omega$ und $R_5 = 10 thin Omega$ liegt an der Spannung $U = 24 thin "V"$.

#image("abbildungen/klausur-netz-i1-i4.svg", width: 90%)

*Gesucht*

#enum(numbering: "a)",
[Bestimme die Ströme $I_1$ bis $I_4$.],
)
][
*Von hinten zusammenfassen:* R4 und R5 liegen in Reihe: $R_(45) = 60 thin Omega$. Dieser Zweig liegt parallel zu R2 und R3: $1\/R_p = 1\/50 + 1\/40 + 1\/60 = "0,06167" thin "S"$, $R_p approx "16,2" thin Omega$.
][
*Gesamtstrom:* $I_1 = U\/(R_1 + R_p) = 24\/(30 + "16,2") approx "0,519" thin "A"$.
][
*Gemeinsame Spannung der Parallelzweige:* $U_p = I_1 R_p approx "8,42" thin "V"$.
][
*Zweigströme:* $I_2 = "8,42"\/50 approx 168 thin "mA"$, $I_3 = "8,42"\/40 approx 211 thin "mA"$, $I_4 = "8,42"\/60 approx 140 thin "mA"$. Probe: $168 + 211 + 140 = 519 thin "mA"$.
]

#aufgabe(titel: "Netzwerk mit vier Strömen an 12 V (Variante)", art: "rechnen", quelle: "2.4.5", herkunft: "variante", vorlage: "Altklausur (Jahr unbekannt), S. 4", minuten: 10,
  ergebnis: [$I_1 approx 514 thin "mA"$, $I_2 approx 229 thin "mA"$, $I_3 approx 114 thin "mA"$, $I_4 approx 171 thin "mA"$],
)[
#if not web [*Aufgabe 227* #linebreak()]
*Gegeben und Annahmen*

Gleiche Schaltung: $U = 12 thin "V"$, $R_1 = 10 thin Omega$, $R_2 = 30 thin Omega$, $R_3 = 60 thin Omega$, $R_4 = 15 thin Omega$, $R_5 = 25 thin Omega$.

#image("abbildungen/klausur-netz-i1-i4.svg", width: 90%)

*Gesucht*

#enum(numbering: "a)",
[Ströme $I_1$ bis $I_4$ und die Spannung an R5.],
)
][
*Ersatz:* $R_(45) = 40 thin Omega$; $1\/R_p = 1\/30 + 1\/60 + 1\/40 = "0,075" thin "S"$, $R_p approx "13,33" thin Omega$.
][
*Gesamtstrom und Spannung:* $I_1 = 12\/"23,33" approx "0,514" thin "A"$, $U_p = I_1 R_p approx "6,86" thin "V"$.
][
*Zweige:* $I_2 = "6,86"\/30 approx 229 thin "mA"$, $I_3 = "6,86"\/60 approx 114 thin "mA"$, $I_4 = "6,86"\/40 approx 171 thin "mA"$; $U_5 = I_4 R_5 approx "4,29" thin "V"$. Summe der Ströme 514 mA.
]

#aufgabe(titel: "Gemischtes Netz: dieselbe Teilspannung auf zwei Wegen", art: "rechnen", quelle: "2.4.5", herkunft: "original", vorlage: "Vorlesungsskript S. 49–50, Beispiel 1", minuten: 10,
 ergebnis: [$R_"ges"=124 thin Omega$, $I approx "0,806" thin "A"$, $U_2 approx "16,13" thin "V"$.])[
#if not web [*Aufgabe 228* #linebreak()]
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

#aufgabe(titel: "Gemischtes Netz an 60 V (Variante)", art: "rechnen", quelle: "2.4.5", herkunft: "variante", vorlage: "Vorlesungsskript S. 49–50, Beispiel 1", minuten: 8,
  ergebnis: [$R_"ges" = 40 thin Omega$, $I = "1,5" thin "A"$, $U_2 = "22,5" thin "V"$],
)[
#if not web [*Aufgabe 229* #linebreak()]
*Gegeben und Annahmen*

Gleiche Struktur wie im Skriptbeispiel: R1 in Reihe mit der Parallelgruppe aus R4 und der Reihe R2–R3. $U = 60 thin "V"$, $R_1 = 20 thin Omega$, $R_2 = 30 thin Omega$, $R_3 = 10 thin Omega$, $R_4 = 40 thin Omega$.

#image("abbildungen/gesamt-teiler-kaskade.svg", width: 100%, height: 44mm, fit: "contain")

*Gesucht*

#enum(numbering: "a)",
[Gesamtwiderstand und Gesamtstrom.],
[Spannung an R2 über den Stromteiler.],
[Kontrolle über einen zweifachen Spannungsteiler.],
)
][
*a)* $R_(23) = 40 thin Omega$, $R_(234) = 40 || 40 = 20 thin Omega$, $R_"ges" = 40 thin Omega$, $I = "1,5" thin "A"$.
][
*b) Stromteiler:* $I_(23) = I dot.c R_(234)\/R_(23) = "0,75" thin "A"$, $U_2 = "0,75" dot.c 30 = "22,5" thin "V"$.
][
*c) Spannungsteiler:* $U_(234) = 60 dot.c 20\/40 = 30 thin "V"$, $U_2 = 30 dot.c 30\/40 = "22,5" thin "V"$.
]

#aufgabe(titel: "Verschachtelte Stromteiler: Verhältnis ohne Quellspannung", art: "rechnen", quelle: "2.4.5", herkunft: "original", vorlage: "Vorlesungsskript S. 50, Beispiel 2", minuten: 10,
 ergebnis: [$I_1/I_4=8$.])[
#if not web [*Aufgabe 230* #linebreak()]
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

#aufgabe(titel: "Verschachtelte Stromteiler mit anderen Werten (Variante)", art: "rechnen", quelle: "2.4.5", herkunft: "variante", vorlage: "Vorlesungsskript S. 50, Beispiel 2", minuten: 8,
  ergebnis: [$I_1\/I_4 = 4$],
)[
#if not web [*Aufgabe 231* #linebreak()]
*Gegeben und Annahmen*

Gleiches Netz wie im Skriptbeispiel 2 (Bild): $R_2 = 8 thin Omega$, $R_3 = 5 thin Omega$, $R_4 = 6 thin Omega$, $R_5 = 4 thin Omega$, $R_6 = 3 thin Omega$, $R_7 = 6 thin Omega$; Eingangsstrom $I_1 != 0$.

#image("abbildungen/gesamt-stromverhaeltnis.svg", width: 100%, height: 44mm, fit: "contain")

*Gesucht*

#enum(numbering: "a)",
[Das Verhältnis $I_1\/I_4$.],
)
][
*Innen beginnen:* $R_(67) = 3 || 6 = 2 thin Omega$, $R_(567) = 4 + 2 = 6 thin Omega$, $R_(4567) = 6 || 6 = 3 thin Omega$.
][
*Rechte Teilung:* $I_3$ teilt sich auf zwei gleiche 6-Ω-Wege, $I_4\/I_3 = 1\/2$.
][
*Linke Teilung:* Der rechte Zweig hat $R_3 + R_(4567) = 8 thin Omega$, parallel zu $R_2 = 8 thin Omega$: $I_3\/I_1 = 1\/2$.
][
*Verbinden:* $I_4\/I_1 = 1\/4$, also $I_1\/I_4 = 4$, unabhängig von der Quellspannung.
]

#aufgabe(titel: "Ersatzwiderstand, Teilspannung und Stromteiler", art: "rechnen", quelle: "2.4.5", herkunft: "original", vorlage: "Übung GET, Aufg. 4", minuten: 12,
  ergebnis: [a) $R_"ers" approx 1088 thin Omega$, $I_E approx 202 thin "mA"$ b) $U_(23) approx "13,5" thin "V"$ c) $I_5 approx "10,6" thin "mA"$],
  tipp: [Fasse zuerst die beiden Parallelgruppen zusammen; sie liegen dann mit R1 in Reihe.],
)[
#if not web [*Aufgabe 232* #linebreak()]
*Gegeben und Annahmen*

$U_E = 220 thin "V"$. $R_1 = 1 thin "k"Omega$ in Reihe mit der Parallelschaltung aus $R_2 = 200 thin Omega$ und $R_3 = 100 thin Omega$, dahinter in Reihe die Parallelschaltung aus $R_4 = 40 thin Omega$, $R_5 = 400 thin Omega$ und $R_6 = 50 thin Omega$.

#image("abbildungen/ue-gemischt-r1-r6.svg", width: 95%)

*Gesucht*

#enum(numbering: "a)",
[Berechne den Ersatzwiderstand $R_"ers"$ und die Stromaufnahme $I_E$.],
[Welche Spannung $U_(23)$ stellt sich ein? Berechne sie mit Hilfe der Spannungsteilerregel.],
[Welcher Strom fließt im Widerstand R5? Berechne ihn mit Hilfe der Stromteilerregel.],
)
][
*a) Parallelgruppen:* $R_(23) = 200 dot.c 100\/300 approx "66,67" thin Omega$. $1\/R_(456) = 1\/40 + 1\/400 + 1\/50 = "0,0475" thin "S"$, $R_(456) approx "21,05" thin Omega$.
][
*a) Reihe:* $R_"ers" = 1000 + "66,67" + "21,05" approx "1087,7" thin Omega$, $I_E = 220\/"1087,7" approx "0,2023" thin "A" approx 202 thin "mA"$.
][
*b) Spannungsteiler:* Alle drei Blöcke führen $I_E$, also teilen sie $U_E$ im Verhältnis ihrer Widerstände: $U_(23) = U_E dot.c R_(23)\/R_"ers" = 220 dot.c "66,67"\/"1087,7" approx "13,5" thin "V"$.
][
*c) Stromteiler:* In einer Parallelgruppe gilt $I_k\/I_"ges" = R_"Gruppe"\/R_k$: $I_5 = I_E dot.c R_(456)\/R_5 = "0,2023" dot.c "21,05"\/400 approx "10,6" thin "mA"$.
][
*Prüfen:* $U_(456) = "0,2023" dot.c "21,05" approx "4,26" thin "V"$ und $I_5 = "4,26"\/400 approx "10,6" thin "mA"$. R5 als größter Widerstand der Gruppe bekommt den kleinsten Strom.
]

#aufgabe(titel: "Ersatzwiderstand und Stromteiler bei 120 V (Variante)", art: "rechnen", quelle: "2.4.5", herkunft: "variante", vorlage: "Übung GET, Aufg. 4", minuten: 12,
  ergebnis: [$R_"ers" approx 703 thin Omega$, $I_E approx 171 thin "mA"$, $U_(23) approx "34,1" thin "V"$, $I_5 approx 19 thin "mA"$],
)[
#if not web [*Aufgabe 233* #linebreak()]
*Gegeben und Annahmen*

Gleiche Schaltung wie im Bild: $U_E = 120 thin "V"$, $R_1 = 470 thin Omega$, $R_2 = 300 thin Omega$, $R_3 = 600 thin Omega$, $R_4 = 60 thin Omega$, $R_5 = 300 thin Omega$, $R_6 = 100 thin Omega$.

#image("abbildungen/ue-gemischt-r1-r6.svg", width: 95%)

*Gesucht*

#enum(numbering: "a)",
[$R_"ers"$ und $I_E$.],
[$U_(23)$ mit der Spannungsteilerregel.],
[Strom in R5 mit der Stromteilerregel.],
)
][
*a)* $R_(23) = 300 || 600 = 200 thin Omega$; $1\/R_(456) = 1\/60 + 1\/300 + 1\/100 = "0,03" thin "S"$, $R_(456) approx "33,3" thin Omega$. $R_"ers" = 470 + 200 + "33,3" approx "703,3" thin Omega$, $I_E = 120\/"703,3" approx "0,1706" thin "A"$.
][
*b)* $U_(23) = 120 dot.c 200\/"703,3" approx "34,1" thin "V"$.
][
*c)* $I_5 = I_E dot.c R_(456)\/R_5 = "0,1706" dot.c "33,3"\/300 approx "0,0190" thin "A" = 19 thin "mA"$. Probe: $U_(456) approx "5,69" thin "V"$, $"5,69"\/300 approx 19 thin "mA"$.
]

#aufgabe(titel: "Verzweigtes Netzwerk: Strom und Potenziale", art: "rechnen", quelle: "2.4.5", herkunft: "original", vorlage: "Übung GET, Aufg. 6", minuten: 15, platz: 14,
  ergebnis: [a) $I_8 approx 168 thin "mA"$ b) $phi_B approx "27,63" thin "V"$ c) $U_(C A) = phi_C - phi_A approx -"30,8" thin "V"$],
  tipp: [Fasse von C aus nach vorn zusammen: R5 ∥ R6 ∥ R7, dann R4, dann R2 ∥ R3.],
)[
#if not web [*Aufgabe 234* #linebreak()]
*Gegeben und Annahmen*

$U_E = 100 thin "V"$ gegen Masse (0 V). $R_1 = 100 thin Omega$, $R_8 = 200 thin Omega$, $R_2 = 20 thin Omega$, $R_3 = 30 thin Omega$, $R_4 = 50 thin Omega$, $R_5 = 10 thin Omega$, $R_6 = 20 thin Omega$, $R_7 = 40 thin Omega$. R5, R6 und R7 liegen alle zwischen C und Masse.

#image("abbildungen/ue-verzweigtes-netz.svg", width: 95%)

*Gesucht*

#enum(numbering: "a)",
[Welcher Strom stellt sich im Widerstand R8 ein?],
[Welches Potenzial stellt sich im Punkt B gegenüber Masse ein?],
[Welches Potenzial hat der Punkt C in Bezug auf den Punkt A?],
)
][
*Rechter Zweig zusammenfassen:* $1\/R_(567) = 1\/10 + 1\/20 + 1\/40 = "0,175" thin "S"$, $R_(567) approx "5,714" thin Omega$. $R_(23) = 12 thin Omega$. Zweig ab A: $R_"Zw" = 12 + 50 + "5,714" approx "67,71" thin Omega$.
][
*Gesamtstrom:* R8 liegt parallel zum Zweig: $R_p = 200 || "67,71" approx "50,59" thin Omega$. $R_"ges" approx "150,59" thin Omega$, $I_E = 100\/"150,59" approx "0,664" thin "A"$.
][
*a) Strom in R8:* $phi_A = U_E - I_E R_1 approx 100 - "66,4" = "33,59" thin "V"$, $I_8 = phi_A\/R_8 approx 168 thin "mA"$.
][
*b) Potenzial B:* Zweigstrom $I_"Zw" = "33,59"\/"67,71" approx "0,496" thin "A"$. Über R2 ∥ R3 fallen $"0,496" dot.c 12 approx "5,95" thin "V"$ ab: $phi_B approx "27,63" thin "V"$.
][
*c) C gegen A:* $phi_C = I_"Zw" R_(567) approx "2,83" thin "V"$. $U_(C A) = phi_C - phi_A approx "2,83" - "33,59" = -"30,8" thin "V"$. Negativ, weil C tiefer liegt als A.
][
*Prüfen:* Knoten A: $I_E = I_8 + I_"Zw" = "0,168" + "0,496" = "0,664" thin "A"$.
]

#aufgabe(titel: "Verzweigtes Netzwerk an 60 V (Variante)", art: "rechnen", quelle: "2.4.5", herkunft: "variante", vorlage: "Übung GET, Aufg. 6", minuten: 15, platz: 14,
  ergebnis: [$I_8 approx 195 thin "mA"$, $phi_B approx "20,9" thin "V"$, $U_(C A) approx -"25,1" thin "V"$, $I_7 approx 209 thin "mA"$],
)[
#if not web [*Aufgabe 235* #linebreak()]
*Gegeben und Annahmen*

Gleiche Schaltung: $U_E = 60 thin "V"$, $R_1 = 50 thin Omega$, $R_8 = 150 thin Omega$, $R_2 = 30 thin Omega$, $R_3 = 60 thin Omega$, $R_4 = 40 thin Omega$, $R_5 = 30 thin Omega$, $R_6 = 60 thin Omega$, $R_7 = 20 thin Omega$.

#image("abbildungen/ue-verzweigtes-netz.svg", width: 95%)

*Gesucht*

#enum(numbering: "a)",
[Strom in R8.],
[Potenzial von B gegen Masse.],
[Potenzial von C in Bezug auf A und Strom in R7.],
)
][
*Zusammenfassen:* $R_(567) = 30 || 60 || 20 = 10 thin Omega$, $R_(23) = 20 thin Omega$, Zweig $R_"Zw" = 20 + 40 + 10 = 70 thin Omega$; $R_p = 150 || 70 approx "47,73" thin Omega$, $R_"ges" approx "97,73" thin Omega$.
][
*a)* $I_E = 60\/"97,73" approx "0,614" thin "A"$, $phi_A = 60 - "0,614" dot.c 50 approx "29,30" thin "V"$, $I_8 = "29,30"\/150 approx 195 thin "mA"$.
][
*b)* $I_"Zw" = "29,30"\/70 approx "0,419" thin "A"$, $phi_B = "29,30" - "0,419" dot.c 20 approx "20,93" thin "V"$.
][
*c)* $phi_C = "0,419" dot.c 10 approx "4,19" thin "V"$, $U_(C A) approx -"25,1" thin "V"$, $I_7 = "4,19"\/20 approx 209 thin "mA"$. Probe: $195 + 419 = 614 thin "mA"$.
]

#aufgabe(titel: "Ströme bei veränderlichem Vorwiderstand", art: "rechnen", quelle: "2.4.5", herkunft: "original", vorlage: "Übungsblatt A, Aufg. 4", minuten: 10,
  ergebnis: [a) $I_2 = 3 thin "mA"$, $I_3 = 2 thin "mA"$ b) $I_2 = "2,4" thin "mA"$, $I_3 = "1,6" thin "mA"$ c) $I_2 = "5,5" thin "mA"$, $I_3 = "3,67" thin "mA"$],
  tipp: [Erst den Parallelersatz von R2 und R3, dann den Gesamtstrom, dann die Spannung $U_p$.],
)[
#if not web [*Aufgabe 236* #linebreak()]
*Gegeben und Annahmen*

$R_1 = 1 thin "k"Omega$ in Reihe mit der Parallelschaltung aus $R_2 = 2 thin "k"Omega$ und $R_3 = 3 thin "k"Omega$; angelegte Spannung $U = 11 thin "V"$ (ideale Quelle).

#image("abbildungen/blatt-a-r1-parallel.svg", width: 80%)

*Gesucht*

#enum(numbering: "a)",
[Berechne die Ströme in R2 und R3.],
[Wie ändern sich die Ströme $I_2$ und $I_3$, wenn R1 auf 1,55 kΩ erhöht wird?],
[Wie verändern sich die Ströme $I_2$ und $I_3$, wenn R1 kurzgeschlossen wird?],
)
][
*a) Ersatzwiderstand:* $R_(23) = 2 dot.c 3\/(2 + 3) = "1,2" thin "k"Omega$, $R_"ges" = "2,2" thin "k"Omega$, $I = 11 thin "V"\/"2,2" thin "k"Omega = 5 thin "mA"$.
][
*a) Teilströme:* $U_p = I R_(23) = 6 thin "V"$. $I_2 = 6\/2 = 3 thin "mA"$, $I_3 = 6\/3 = 2 thin "mA"$. Knotenprobe $3 + 2 = 5 thin "mA"$.
][
*b) R1 = 1,55 kΩ:* $R_"ges" = "2,75" thin "k"Omega$, $I = 4 thin "mA"$, $U_p = "4,8" thin "V"$, $I_2 = "2,4" thin "mA"$, $I_3 = "1,6" thin "mA"$. Beide sinken um 20 %, weil mehr Spannung an R1 hängen bleibt.
][
*c) R1 kurzgeschlossen:* Jetzt liegt die volle Spannung an R2 und R3: $I_2 = 11\/2 = "5,5" thin "mA"$, $I_3 = 11\/3 approx "3,67" thin "mA"$.
][
*Beobachtung:* Das Verhältnis $I_2\/I_3 = R_3\/R_2 = "1,5"$ bleibt in allen Fällen gleich. Der Vorwiderstand ändert nur die gemeinsame Spannung, nicht die Aufteilung.
]

#aufgabe(titel: "Ströme bei veränderlichem Vorwiderstand, 16 V (Variante)", art: "rechnen", quelle: "2.4.5", herkunft: "variante", vorlage: "Übungsblatt A, Aufg. 4", minuten: 10,
  ergebnis: [a) $I_2 approx "2,67" thin "mA"$, $I_3 approx "1,33" thin "mA"$ b) $I_2 approx "2,13" thin "mA"$, $I_3 approx "1,07" thin "mA"$ c) $I_2 approx "5,33" thin "mA"$, $I_3 approx "2,67" thin "mA"$],
)[
#if not web [*Aufgabe 237* #linebreak()]
*Gegeben und Annahmen*

Gleiche Schaltung (R1 vor der Parallelschaltung aus R2 und R3): $R_1 = 2 thin "k"Omega$, $R_2 = 3 thin "k"Omega$, $R_3 = 6 thin "k"Omega$, $U = 16 thin "V"$.

#image("abbildungen/blatt-a-r1-parallel.svg", width: 80%)

*Gesucht*

#enum(numbering: "a)",
[Ströme in R2 und R3.],
[Ströme, wenn R1 auf 3 kΩ erhöht wird.],
[Ströme, wenn R1 kurzgeschlossen wird.],
)
][
*a)* $R_(23) = 3 || 6 = 2 thin "k"Omega$, $I = 16\/4 = 4 thin "mA"$, $U_p = 8 thin "V"$, $I_2 = 8\/3 approx "2,67" thin "mA"$, $I_3 = 8\/6 approx "1,33" thin "mA"$.
][
*b)* $R_"ges" = 5 thin "k"Omega$, $I = "3,2" thin "mA"$, $U_p = "6,4" thin "V"$, $I_2 approx "2,13" thin "mA"$, $I_3 approx "1,07" thin "mA"$.
][
*c)* $U_p = 16 thin "V"$: $I_2 approx "5,33" thin "mA"$, $I_3 approx "2,67" thin "mA"$. Das Verhältnis $I_2 : I_3 = 2 : 1$ bleibt immer gleich.
]

#aufgabe(titel: "Last am unteren Teilerwiderstand", art: "verstehen", quelle: "2.4.6", herkunft: "eigen", minuten: 2,
  tipp: [Ersetze zuerst unteren Widerstand und Last durch ihren Parallelersatz.],
)[
#if not web [*Aufgabe 238* #linebreak()]
Wie wirkt eine endliche Last parallel zum unteren Teil eines Spannungsteilers? Begründe deine Antwort.
][
*Antwort:* Sie verringert dessen Ersatzwiderstand und senkt die Ausgangsspannung.

*Begründung:* Der untere Parallelersatz ist kleiner als der untere Teilerwiderstand allein.
][
*Typische Verwechslung:*
- Sie erhöht die Ausgangsspannung, weil insgesamt mehr Strom fließt. – Der zusätzliche Strom vergrößert auch den Spannungsabfall am oberen Widerstand.
- Sie ändert nur den Strom, nie die Ausgangsspannung. – Ein Teiler besitzt einen endlichen Ausgangswiderstand und wird durch die Last beeinflusst.
]

#aufgabe(titel: "Halbe Schleiferstellung unter Last", art: "verstehen", quelle: "2.4.6", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 239* #linebreak()]
Warum ist eine halbe Schleiferstellung unter Last nicht automatisch die halbe Eingangsspannung?
][
*Antwort:*
- Die Last liegt parallel zum unteren Bahnabschnitt und senkt dessen wirksamen Widerstand.
- Der obere Abschnitt übernimmt dadurch mehr Spannungsabfall.
- Die ideale Proportionalität gilt nur ohne Last oder näherungsweise bei sehr kleiner Belastung.
#image("abbildungen/gesamt-potenziometer.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Warum sollte der Gesamtwiderstand eines Potenziometers gegenüber der Last klein sein, wenn die Stellkennlinie annähernd linear bleiben soll?_

*Antwort:* Bei $R_S << R_A$ ist der Laststrom klein gegenüber dem Querstrom. Der zusätzliche Term im Nenner der normierten Kennlinie bleibt klein. Die Ausgangsspannung folgt dann näherungsweise der Schleiferstellung.
]

#aufgabe(titel: "Zweistufiger Spannungsteiler allgemein", art: "rechnen", quelle: "2.4.6", herkunft: "original", vorlage: "Altklausur (Jahr unbekannt), S. 3", minuten: 12,
  ergebnis: [$U_A = U_E dot.c R_4\/(R_3 + R_4) dot.c (R_2 || (R_3 + R_4))\/(R_1 + R_2 || (R_3 + R_4))$],
  tipp: [Die zweite Stufe belastet die erste. Berechne zuerst die Zwischenspannung $U_2$ an R2 mit dem Parallelersatz.],
)[
#if not web [*Aufgabe 240* #linebreak()]
*Gegeben und Annahmen*

Die Ausgangsspannung $U_A$ ist unbelastet (kein Strom aus der Ausgangsklemme).

#image("abbildungen/klausur-zweistufiger-teiler.svg", width: 60%)

*Gesucht*

#enum(numbering: "a)",
[Berechne die Ausgangsspannung $U_A$ des zweistufigen Spannungsteilers als Funktion der Eingangsspannung $U_E$ und der Widerstände R1 bis R4.],
)
][
*Ansatz in zwei Stufen:* $U_A\/U_E = (U_A\/U_2) dot.c (U_2\/U_E)$ mit der Zwischenspannung $U_2$ an R2. So zerlegst du das Problem in zwei einfache Teiler.
][
*Zweite Stufe (unbelastet):* R3 und R4 führen denselben Strom: $U_A\/U_2 = R_4\/(R_3 + R_4)$.
][
*Erste Stufe (belastet):* Parallel zu R2 hängt die ganze zweite Stufe $R_3 + R_4$. Erst mit diesem Ersatz gilt die Teilerregel: $U_2\/U_E = (R_2 || (R_3 + R_4))\/(R_1 + R_2 || (R_3 + R_4))$, mit $R_2 || (R_3 + R_4) = R_2(R_3 + R_4)\/(R_2 + R_3 + R_4)$.
][
*Zusammensetzen:* $U_A = U_E dot.c R_4\/(R_3 + R_4) dot.c (R_2 || (R_3 + R_4))\/(R_1 + R_2 || (R_3 + R_4))$. Prüfen: Für $R_3 + R_4 -> oo$ entsteht der einfache Teiler $R_2\/(R_1 + R_2)$ für die erste Stufe.
]

#aufgabe(titel: "Zweistufiger Spannungsteiler mit Zahlen (Variante)", art: "rechnen", quelle: "2.4.6", herkunft: "variante", vorlage: "Altklausur (Jahr unbekannt), S. 3", minuten: 10,
  ergebnis: [$U_2 = 6 thin "V"$, $U_A = 3 thin "V"$; ohne Belastung durch Stufe 2 wäre $U_2 = 8 thin "V"$],
)[
#if not web [*Aufgabe 241* #linebreak()]
*Gegeben und Annahmen*

Zweistufiger Teiler wie im Bild: $U_E = 12 thin "V"$, $R_1 = 1 thin "k"Omega$, $R_2 = 2 thin "k"Omega$, $R_3 = 1 thin "k"Omega$, $R_4 = 1 thin "k"Omega$. Ausgang unbelastet.

#image("abbildungen/klausur-zweistufiger-teiler.svg", width: 60%)

*Gesucht*

#enum(numbering: "a)",
[Zwischenspannung $U_2$ an R2 und Ausgangsspannung $U_A$.],
[Welchen Wert hätte $U_2$, wenn man die Belastung durch die zweite Stufe vergäße?],
)
][
*Belastete erste Stufe:* $R_2 || (R_3 + R_4) = 2 || 2 = 1 thin "k"Omega$, $U_2 = 12 dot.c 1\/(1 + 1) = 6 thin "V"$.
][
*Zweite Stufe:* $U_A = 6 dot.c 1\/2 = 3 thin "V"$.
][
*b) Fehler bei Vernachlässigung:* $12 dot.c 2\/3 = 8 thin "V"$ statt 6 V. Weil die zweite Stufe ähnlich groß ist wie R2, ist die Belastung deutlich.
]

#aufgabe(titel: "Potenziometer: Lastfehler und Grenzstrom", art: "rechnen", quelle: "2.4.6", herkunft: "variante", vorlage: "Vorlesungsskript S. 51–54", minuten: 12,
 ergebnis: [$U_A=4 thin "V"$ statt 5 V; $I_E=12 thin "mA"$; $I_"zul">=20 thin "mA"$.])[
#if not web [*Aufgabe 242* #linebreak()]
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

#aufgabe(titel: "Festspannungsteiler für 10 V an der Last", art: "rechnen", quelle: "2.4.6", herkunft: "original", vorlage: "Übung GET, Aufg. 5", minuten: 10,
  ergebnis: [$R_x = U_a R_1 R_a\/(R_a(U_E - U_a) - U_a R_1) = 5 thin Omega$],
  tipp: [Wende die Teilerregel auf R1 und den Parallelersatz $R_x || R_a$ an.],
)[
#if not web [*Aufgabe 243* #linebreak()]
*Gegeben und Annahmen*

Über einen Festspannungsteiler $R_1$, $R_x$ soll eine definierte Spannung an den Verbraucherwiderstand $R_a$ gelegt werden. $U_E = 50 thin "V"$, $R_1 = 10 thin Omega$, $R_a = 5 thin Omega$ (parallel zu $R_x$ zwischen A und B).

#image("abbildungen/ue-festspannungsteiler.svg", width: 70%)

*Gesucht*

#enum(numbering: "a)",
[Leite zunächst mit Hilfe der Spannungsteilerregel die Berechnungsformel für $R_x$ allgemein ab.],
[Wie groß muss der Widerstand $R_x$ gewählt werden, damit sich am Lastwiderstand $R_a$ eine Spannung von $U_a = 10 thin "V"$ einstellt?],
)
][
*Belasteten Teiler erkennen:* $R_x$ und $R_a$ liegen parallel, ihr Ersatz $R_p = R_x R_a\/(R_x + R_a)$ bildet mit $R_1$ einen Teiler: $U_a\/U_E = R_p\/(R_1 + R_p)$.
][
*Nach $R_p$ auflösen:* $R_p = R_1 U_a\/(U_E - U_a)$.
][
*Nach $R_x$ auflösen:* Aus $1\/R_p = 1\/R_x + 1\/R_a$ folgt $R_x = R_p R_a\/(R_a - R_p)$, zusammen $R_x = U_a R_1 R_a\/(R_a(U_E - U_a) - U_a R_1)$.
][
*b) Einsetzen:* $R_p = 10 dot.c 10\/40 = "2,5" thin Omega$, $R_x = "2,5" dot.c 5\/(5 - "2,5") = 5 thin Omega$.
][
*Prüfen:* $5 || 5 = "2,5" thin Omega$, $U_a = 50 dot.c "2,5"\/"12,5" = 10 thin "V"$. Bedingung für eine Lösung: $R_p < R_a$, sonst müsste $R_x$ negativ sein.
]

#aufgabe(titel: "Festspannungsteiler für 12 V an 300 Ω (Variante)", art: "rechnen", quelle: "2.4.6", herkunft: "variante", vorlage: "Übung GET, Aufg. 5", minuten: 8,
  ergebnis: [$R_p = 100 thin Omega$, $R_x = 150 thin Omega$],
)[
#if not web [*Aufgabe 244* #linebreak()]
*Gegeben und Annahmen*

Festspannungsteiler wie im Bild: $U_E = 24 thin "V"$, $R_1 = 100 thin Omega$, Last $R_a = 300 thin Omega$. An der Last sollen $U_a = 12 thin "V"$ liegen.

#image("abbildungen/ue-festspannungsteiler.svg", width: 70%)

*Gesucht*

#enum(numbering: "a)",
[Erforderlicher Widerstand $R_x$.],
[Welche Lastspannung ergäbe sich, wenn die Last abgeklemmt würde?],
)
][
*Parallelersatz:* $R_p = R_1 U_a\/(U_E - U_a) = 100 dot.c 12\/12 = 100 thin Omega$.
][
*$R_x$:* $R_x = R_p R_a\/(R_a - R_p) = 100 dot.c 300\/200 = 150 thin Omega$.
][
*b) Leerlauf:* $U = 24 dot.c 150\/250 = "14,4" thin "V"$. Die Last zieht die Spannung von 14,4 V auf 12 V herunter.
]

#aufgabe(titel: "Spannungsrichtig gemessen: Fehler von U durch I", art: "verstehen", quelle: "2.4.7", herkunft: "eigen", minuten: 2,
  tipp: [Überlege, welchen zusätzlichen Strom das Amperemeter erfasst.],
)[
#if not web [*Aufgabe 245* #linebreak()]
Welches systematische Ergebnis liefert $U/I$ ohne Eigenverbrauchskorrektur bei spannungsrichtiger Widerstandsmessung? Begründe deine Antwort.
][
*Antwort:* Einen zu kleinen Widerstand.

*Begründung:* Das Amperemeter erfasst zusätzlich den Voltmeterstrom; der Nenner ist zu groß.
][
*Typische Verwechslung:*
- Einen zu großen Widerstand. – Das ist der typische Effekt der stromrichtigen Anordnung durch den zusätzlichen Spannungsabfall.
- Immer den exakten Prüflingswiderstand. – Das reale Voltmeter hat einen endlichen Widerstand und zieht Strom.
]

#aufgabe(titel: "Korrektur bei stromrichtiger Messung", art: "verstehen", quelle: "2.4.7", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 246* #linebreak()]
Welche Korrektur ist bei stromrichtiger Messung nötig und warum?
][
*Antwort:* Das Voltmeter misst die Spannung über Prüfling und Amperemeter zusammen. Der Quotient U/I enthält daher den Instrumentenwiderstand. Es gilt $R_x=U/I-R_"AM"$.
]

#aufgabe(titel: "Stromrichtig oder spannungsrichtig unterscheiden", art: "verstehen", quelle: "2.4.7", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 247* #linebreak()]
Wie unterscheidest du stromrichtige und spannungsrichtige Messung?
][
*Antwort:*
- Spannungsrichtig misst U direkt am Prüfling, aber I enthält den Voltmeterstrom.
- Stromrichtig misst I direkt im Prüfling, aber U enthält den Amperemeterabfall.
- Wähle die Schaltung mit der kleineren Eigenverbrauchskorrektur.
- Andere Geräteunsicherheiten bleiben bestehen.

*Merksatz:* Spannungsrichtig: I mit Zusatzstrom. Stromrichtig: U mit Zusatzabfall.
#image("abbildungen/gesamt-messung-u.svg", width: 80%)
]

#aufgabe(titel: "LED-Messung: richtige Spannung oder richtiger Strom?", art: "verstehen", quelle: "2.4.7", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 248* #linebreak()]
*Von KI erstellt.* Warum zieht das Amperemeter bei spannungsrichtiger LED-Messung auch den Voltmeterstrom mit? Welche Größe enthält bei stromrichtiger Messung einen Zusatzanteil?
][
*Antwort:*
- Spannungsrichtig: Voltmeter parallel zur LED; es zeigt die LED-Spannung. Das Amperemeter davor zählt LED- und Voltmeterstrom.
- Stromrichtig: Amperemeter in der LED-Reihe; es misst den LED-Strom. Das Voltmeter umfasst zusätzlich den Spannungsabfall des Amperemeters.
- Beide Korrekturen folgen aus Knoten- und Maschensatz und gelten je Messpunkt auch bei nichtlinearer LED.
*Begründung:* Der Innenwiderstand eines Messgeräts gehört zum Netzwerk. Grundlage: L12 PDF-S. 1 und V S. 54–57.
]

#aufgabe(titel: "Relaisspule stromrichtig oder spannungsrichtig messen", art: "rechnen", quelle: "2.4.7", herkunft: "original", vorlage: "Vorlesungsskript S. 56–57", minuten: 12,
 ergebnis: [$R_"VM"=30 thin "k"Omega$, $R_"AM"=5 thin Omega$; stromrichtig ist günstiger.])[
#if not web [*Aufgabe 249* #linebreak()]
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

#aufgabe(titel: "LED-Messwerte um den Geräteeigenverbrauch korrigieren", art: "rechnen", quelle: "2.4.7", herkunft: "eigen", minuten: 8)[
#if not web [*Aufgabe 250* #linebreak()]
*Von KI erstellt.* *Gegeben und Annahmen:* KI-Übungsdatensatz, ruhende Gleichstrommessung und ohmsche Instrumentenwiderstände. a) Spannungsrichtig: $U_D="2,8"$ V, $I_"AM"=34$ mA, $R_"VM"=100$ kΩ. b) Getrennte stromrichtige Messung: $I_D=30$ mA, $U_"VM"="2,9"$ V und $R_"AM"=2$ Ω.
*Gesucht:* Korrigierte LED-Ströme bzw. -Spannungen; Bedeutung für die Kennlinienpunkte.
][
*Knotenregel in a):* Das Voltmeter zieht $I_"VM"="2,8"/100000="0,000028"$ A = 0,028 mA. Also $I_D=34-"0,028"="33,972"$ mA. Das korrigierte Paar lautet 2,8 V / 33,972 mA.
][
*Maschenregel in b):* Das Amperemeter verbraucht $U_"AM"="0,030" dot 2="0,06"$ V. Also $U_D="2,9"-"0,06"="2,84"$ V; das Paar lautet 2,84 V / 30 mA. Die beiden getrennten Messsituationen sind kein gemeinsam konsistenter Datensatz einer einzigen LED-Kennlinie.
][
*Grenzfall prüfen:* Für $R_"VM" -> infinity$ verschwindet der abgezweigte Strom; für $R_"AM" -> 0$ verschwindet der zusätzliche Spannungsabfall. Keine der Rechnungen braucht einen konstanten LED-Widerstand.
]

#aufgabe(titel: "Instrumentenwiderstand beim Pt100 mitrechnen", art: "verstehen", quelle: "2.4.8", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 251* #linebreak()]
Warum muss der Instrumentenwiderstand bei der Pt100-Dimensionierung mitgerechnet werden?
][
*Antwort:* Das Instrument liegt parallel zum Sensor und entnimmt Strom. Es verändert den Ersatzwiderstand und die Spannung am Sensorzweig. Deshalb hängt der Instrumentenstrom sowohl vom Sensor als auch vom Instrument und Vorwiderstand ab.
]

#aufgabe(titel: "Pt100: lineare Stromskala, ungleichmäßige Temperaturskala", art: "verstehen", quelle: "2.4.8", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 252* #linebreak()]
Warum kann eine lineare Stromskala bei der Pt100-Schaltung eine ungleichmäßige Temperaturskala benötigen?
][
*Antwort:*
- Die Sensorannahme ist zwar linear, die elektrische Übertragung enthält aber Parallelbelastung und Spannungsteilung.
- Der Instrumentenstrom steigt daher nicht automatisch proportional zur Temperatur.
- Die Skala muss nach der gesamten Stromfunktion geeicht werden.
#image("abbildungen/gesamt-pt100.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Ein Pt100 ist im verwendeten Modell linear temperaturabhängig. Wird dadurch auch der Instrumentenstrom im belasteten Messnetz linear?_

*Antwort:* Nein, die belastete Stromaufteilung ist eine gebrochenrationale Funktion des Sensorwiderstands.

*Begründung:* Der Sensor beeinflusst zugleich die Spannung und die Aufteilung im Parallelzweig.

*Typische Verwechslung:*
- Ja, jede angeschlossene Anzeige wird dadurch linear. – Die Übertragungsfunktion der ganzen Schaltung muss berücksichtigt werden.
- Nur wenn die Temperatur in Kelvin statt Celsius eingesetzt wird. – Die Wahl des Nullpunkts beseitigt keine Nichtlinearität der Schaltung.
]

#aufgabe(titel: "Pt100 mit Drehspulinstrument dimensionieren", art: "rechnen", quelle: "2.4.8", herkunft: "original", vorlage: "Vorlesungsskript S. 58–59, Aufg. 2.4.8", minuten: 12,
 ergebnis: [$R_V approx "20,053" thin "k"Omega$; bei 0 °C etwa 45,1 % Vollausschlag.])[
#if not web [*Aufgabe 253* #linebreak()]
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

#aufgabe(titel: "Pt100 für 200 °C Vollausschlag (Variante)", art: "rechnen", quelle: "2.4.8", herkunft: "variante", vorlage: "Vorlesungsskript S. 58–59, Aufg. 2.4.8", minuten: 12,
  ergebnis: [$R_vartheta(200 thin "°C") = 177 thin Omega$, $R_V approx "19,35" thin "k"Omega$, bei 0 °C etwa 58,8 % Vollausschlag],
)[
#if not web [*Aufgabe 254* #linebreak()]
*Gegeben und Annahmen*

Schaltung wie im Skript: Vorwiderstand $R_V$ in Reihe mit der Parallelschaltung aus Pt100 und Drehspulinstrument an $U_B = 12 thin "V"$. Instrument $R_M = 2 thin "k"Omega$, Vollausschlag $I_M = 50 thin mu"A"$. $R_vartheta = R_0(1 + alpha vartheta)$, $R_0 = 100 thin Omega$, $alpha = "3,85" dot.c 10^(-3) thin "1/K"$.

#image("abbildungen/gesamt-pt100.svg", width: 100%, height: 35mm, fit: "contain")

*Gesucht*

#enum(numbering: "a)",
[$R_V$ für Vollausschlag bei 200 °C.],
[Anzeige bei 0 °C als Anteil des Vollausschlags.],
)
][
*Sensorwert:* $R_vartheta = 100(1 + "0,00385" dot.c 200) = 177 thin Omega$.
][
*a) Vorwiderstand:* Aus $I_m = U_B R_vartheta\/(R_V R_M + R_V R_vartheta + R_M R_vartheta)$ folgt $R_V = (U_B\/I_M - R_M) R_vartheta\/(R_M + R_vartheta) = (240 thin 000 - 2000) dot.c 177\/2177 approx 19 thin 350 thin Omega$.
][
*b) Nullpunkt:* Mit $R_vartheta = 100 thin Omega$: $I_m = 12 dot.c 100\/(19 thin 350 dot.c 2000 + 19 thin 350 dot.c 100 + 2000 dot.c 100) approx "29,4" thin mu"A"$, also rund 58,8 % des Vollausschlags. Der Zeiger beginnt nicht bei null.
]

#aufgabe(titel: "Kennzeichen der abgeglichenen Brücke", art: "verstehen", quelle: "2.4.9", herkunft: "eigen", minuten: 2,
  tipp: [Nullanzeige betrifft die Differenz zwischen den Mitten.],
)[
#if not web [*Aufgabe 255* #linebreak()]
Was kennzeichnet eine abgeglichene Wheatstone-Brücke? Begründe deine Antwort.
][
*Antwort:* Die Mitten besitzen gleiches Potenzial, der Querzweigstrom ist null.

*Begründung:* Die Nullanzeige erlaubt den Vergleich der beiden Widerstandsverhältnisse.
][
*Typische Verwechslung:*
- Alle vier Brückenwiderstände müssen gleich groß sein. – Gleiche Verhältnisse genügen, nicht gleiche Einzelwerte.
- Durch das gesamte Netzwerk fließt kein Strom. – Die beiden äußeren Teiler können weiterhin Strom führen.
]

#aufgabe(titel: "Schleifdraht: Längen statt Widerstände", art: "verstehen", quelle: "2.4.9", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 256* #linebreak()]
Unter welcher Zusatzbedingung darf das Widerstandsverhältnis eines Schleifdrahts durch sein Längenverhältnis ersetzt werden?
][
*Antwort:* Der Draht muss entlang beider Teile dasselbe Material und denselben Querschnitt besitzen. Dann ist der Widerstand proportional zur Länge. Der Brückenabgleich liefert anschließend das gesuchte Verhältnis.
]

#aufgabe(titel: "Nullanzeige der Wheatstone-Brücke", art: "verstehen", quelle: "2.4.9", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 257* #linebreak()]
Warum ist die Nullanzeige der Wheatstone-Brücke besonders hilfreich?
][
*Antwort:*
- Bei Nullanzeige haben beide Mitten dasselbe Potenzial.
- Das Messgerät führt dann keinen Querzweigstrom und belastet die Teiler an diesem Punkt nicht.
- Aus den gleichen Teilspannungen folgt das Verhältnis der Widerstände.

*Merksatz:* Brücke im Gleichgewicht: gleiche Mittenpotenziale, kein Querzweigstrom.
#image("abbildungen/gesamt-wheatstone.svg", width: 80%)
]

#aufgabe(titel: "Wheatstone-Abgleich und Schleifdraht", art: "rechnen", quelle: "2.4.9", herkunft: "original", vorlage: "Vorlesungsskript S. 60–61", minuten: 5,
 ergebnis: [$R_x=143 thin Omega$.])[
#if not web [*Aufgabe 258* #linebreak()]
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

#aufgabe(titel: "Wheatstone-Brücke mit 220-Ω-Normal (Variante)", art: "rechnen", quelle: "2.4.9", herkunft: "variante", vorlage: "Vorlesungsskript S. 60–61", minuten: 5,
  ergebnis: [$R_x = 165 thin Omega$; bei 1 m Drahtlänge $l_1 approx "42,9" thin "cm"$],
)[
#if not web [*Aufgabe 259* #linebreak()]
*Gegeben und Annahmen*

Abgeglichene Schleifdrahtbrücke, Normwiderstand $R_N = 220 thin Omega$, Längenverhältnis am Abgleich $l_1\/l_2 = "0,75"$; homogener Draht der Gesamtlänge 1 m.

*Gesucht*

#enum(numbering: "a)",
[Prüflingswiderstand $R_x$.],
[An welcher Stelle $l_1$ steht der Schleifer?],
)
][
*Abgleich:* Nullanzeige heißt gleiche Potenziale der Brückenmitten; dann gilt $R_x\/R_N = l_1\/l_2$. $R_x = 220 dot.c "0,75" = 165 thin Omega$.
][
*Schleiferstellung:* $l_1 + l_2 = 1 thin "m"$ und $l_1 = "0,75" l_2$ → $l_2 = 1\/"1,75" approx "0,571" thin "m"$, $l_1 approx "0,429" thin "m"$.
]

#aufgabe(titel: "Stern-Dreieck: welcher Arm im Nenner steht", art: "verstehen", quelle: "2.5.1", herkunft: "eigen", minuten: 2,
  tipp: [Beschrifte die äußeren Klemmen statt nur die Zeichenpositionen.],
)[
#if not web [*Aufgabe 260* #linebreak()]
Welcher Sternarm steht bei der Rückumwandlung zur Dreieckseite A–B im Nenner? Begründe deine Antwort.
][
*Antwort:* Der gegenüberliegende Arm zum Knoten C.

*Begründung:* Die Dreieckseite A–B ist der Summe der Sternprodukte geteilt durch den dritten Arm.
][
*Typische Verwechslung:*
- Immer der Arm zum Knoten A. – Die Zuordnung erfolgt über die gegenüberliegende Klemme, nicht über den ersten Buchstaben.
- Die Summe aller drei Sternarme. – Das ist nicht der Nenner der Stern-zu-Dreieck-Formel.
]

#aufgabe(titel: "Sternstrom ist kein Dreieckstrom", art: "verstehen", quelle: "2.5.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 261* #linebreak()]
Warum darfst du einen Strom aus dem neuen Stern nicht einfach als ursprünglichen Strom durch eine Dreieckseite übernehmen?
][
*Antwort:* Die Umwandlung erhält das Verhalten an den drei äußeren Klemmen. Die innere Topologie und ihre Einzelströme ändern sich. Ursprüngliche innere Ströme werden aus den ursprünglichen Widerständen und den äußeren Potenzialen zurückgerechnet.
]

#aufgabe(titel: "Was bei Stern-Dreieck gleich bleibt", art: "verstehen", quelle: "2.5.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 262* #linebreak()]
Was bleibt bei einer Stern-Dreieck-Umwandlung gleich?
][
*Antwort:*
- Das Verhalten an den drei äußeren Klemmen bleibt gleich, sodass sich der übrige Stromkreis gleich verhält.
- Die inneren Ströme müssen nicht gleich sein.
- Das umgewandelte Teilnetz enthält hier nur lineare Widerstände ohne Quellen.

*Merksatz:* Gleiche Klemmenwirkung heißt nicht: gleiche innere Ströme.
#image("abbildungen/gesamt-stern-dreieck.svg", width: 80%)
]

#aufgabe(titel: "Resultierender Widerstand einer Dreieckschaltung", art: "rechnen", quelle: "2.5.1", herkunft: "original", vorlage: "Altklausur (Jahr unbekannt 2), F7", minuten: 5,
  ergebnis: [$R_(13) = 5 thin Omega$],
  tipp: [Zwischen den Kontakten 1 und 3 gibt es zwei Wege: direkt und über Kontakt 2.],
)[
#if not web [*Aufgabe 263* #linebreak()]
*Gegeben und Annahmen*

Gegeben ist eine Dreieckschaltung. Zwischen den Kontakten 1 und 2 liegt der Widerstand $R_(12) = 3 thin Omega$, zwischen 2 und 3 der Widerstand $R_(23) = 7 thin Omega$, zwischen 1 und 3 der Widerstand $R_(13) = 10 thin Omega$. Kontakt 2 ist nicht angeschlossen.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist der resultierende Widerstand zwischen den Kontakten 1 und 3?],
)
][
*Wege erkennen:* Von 1 nach 3 führt ein direkter Weg über $R_(13)$ und ein zweiter über Kontakt 2, also $R_(12) + R_(23)$ in Reihe (Kontakt 2 ist frei, beide führen denselben Strom).
][
*Parallel schalten:* $R_"res" = R_(13) || (R_(12) + R_(23)) = 10 || 10 = 5 thin Omega$.
][
*Prüfen:* Das Ergebnis ist kleiner als jeder der beiden Wege, wie es für eine Parallelschaltung sein muss.
]

#aufgabe(titel: "Dreieckschaltung an allen Klemmenpaaren (Variante)", art: "rechnen", quelle: "2.5.1", herkunft: "variante", vorlage: "Altklausur (Jahr unbekannt 2), F7", minuten: 6,
  ergebnis: [$R_(1-3) = 6 thin Omega$, $R_(1-2) approx "4,67" thin Omega$, $R_(2-3) approx "6,67" thin Omega$],
)[
#if not web [*Aufgabe 264* #linebreak()]
*Gegeben und Annahmen*

Dreieckschaltung mit $R_(12) = 6 thin Omega$, $R_(23) = 12 thin Omega$, $R_(13) = 9 thin Omega$; die jeweils dritte Klemme bleibt offen.

*Gesucht*

#enum(numbering: "a)",
[Resultierender Widerstand zwischen 1 und 3, zwischen 1 und 2 sowie zwischen 2 und 3.],
)
][
*Regel:* Zwischen zwei Klemmen liegt die direkte Seite parallel zur Reihe der beiden anderen Seiten.
][
*Einsetzen:* $R_(1-3) = 9 || 18 = 6 thin Omega$; $R_(1-2) = 6 || 21 approx "4,67" thin Omega$; $R_(2-3) = 12 || 15 approx "6,67" thin Omega$.
]

#aufgabe(titel: "Brückennetz durch Stern-Dreieck-Umwandlung zerlegen", art: "rechnen", quelle: "2.5.1", herkunft: "original", vorlage: "Vorlesungsskript S. 64", minuten: 12,
 ergebnis: [$R_"ges"=r_A+((r_B+R_4) parallel (r_C+R_5))$, $I_3=(I_4 R_4-I_5 R_5)/R_3$.])[
#if not web [*Aufgabe 265* #linebreak()]
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

#aufgabe(titel: "Heißleiterbrücke mit endlichem Voltmeterwiderstand", art: "rechnen", quelle: "2.5.1", herkunft: "original", vorlage: "Vorlesungsskript S. 64–65, Aufg. 2.5.1.1", minuten: 15,
 ergebnis: [$R_"VM"=30 thin "k"Omega$; bei 100 °C etwa 14,9 V; Nullanzeige bei etwa −20 °C.])[
#if not web [*Aufgabe 266* #linebreak()]
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

#aufgabe(titel: "Brückenschaltung mit Stern-Dreieck-Umwandlung", art: "rechnen", quelle: "2.5.1", herkunft: "original", vorlage: "Übungsblatt B, Aufg. 13 (= Altklausur (Jahr unbekannt), S. 9)", minuten: 15, platz: 14,
  ergebnis: [$R_a = "1,2" thin Omega$, $R_b = 2 thin Omega$, $R_c = 3 thin Omega$, $R_"ges" = 12 thin Omega$, $I_1 = "0,5" thin "A"$],
  tipp: [Wandle das Dreieck R2, R3, R4 zwischen a, b und c in einen Stern um.],
)[
#if not web [*Aufgabe 267* #linebreak()]
*Gegeben und Annahmen*

Die Brückenschaltung besteht aus den Widerständen $R_1 = 6 thin Omega$, $R_2 = 4 thin Omega$, $R_3 = 6 thin Omega$, $R_4 = 10 thin Omega$, $R_5 = 10 thin Omega$, $R_6 = 5 thin Omega$ und liegt an der Quellspannung $U_q = 6 thin "V"$. R2 liegt zwischen a und b, R3 zwischen a und c, R4 zwischen b und c, R5 von b und R6 von c zur unteren Leitung; R1 liegt mit der Quelle im linken Zweig.

#image("abbildungen/blatt-b-bruecke.svg", width: 60%)

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist der Strom $I_1$?],
)
][
*Warum umwandeln:* R4 verbindet die beiden Brückenmitten; deshalb ist nichts rein in Reihe oder parallel. Das Dreieck R2–R3–R4 zwischen a, b, c wird durch einen gleichwertigen Stern ersetzt; danach entsteht eine einfache gemischte Schaltung.
][
*Sternwiderstände:* Nenner $R_2 + R_3 + R_4 = 20 thin Omega$. Arm an a: $R_a = R_2 R_3\/20 = "1,2" thin Omega$; an b: $R_b = R_2 R_4\/20 = 2 thin Omega$; an c: $R_c = R_3 R_4\/20 = 3 thin Omega$. Jeder Arm bekommt das Produkt der zwei Dreieckseiten, die an seinem Punkt anliegen.
][
*Gesamtwiderstand:* Vom Sternpunkt aus liegen $R_b + R_5 = 12 thin Omega$ und $R_c + R_6 = 8 thin Omega$ parallel: $12 || 8 = "4,8" thin Omega$. Dazu in Reihe $R_1$ und $R_a$: $R_"ges" = 6 + "1,2" + "4,8" = 12 thin Omega$.
][
*Strom:* $I_1 = U_q\/R_"ges" = 6\/12 = "0,5" thin "A"$.
][
*Prüfen:* Eine Knotenpotenzialrechnung im Original ergibt $phi_a = 3 thin "V"$, $phi_b = 2 thin "V"$, $phi_c = "1,5" thin "V"$ gegen die untere Leitung und $I_1 = (6 - 3)\/6 = "0,5" thin "A"$.
]

#aufgabe(titel: "Brückenschaltung an 12 V (Variante)", art: "rechnen", quelle: "2.5.1", herkunft: "variante", vorlage: "Übungsblatt B, Aufg. 13 (= Altklausur (Jahr unbekannt), S. 9)", minuten: 15, platz: 14,
  ergebnis: [$R_a = 1 thin Omega$, $R_b = 3 thin Omega$, $R_c = "1,5" thin Omega$, $R_"ges" approx "6,62" thin Omega$, $I_1 approx "1,81" thin "A"$],
)[
#if not web [*Aufgabe 268* #linebreak()]
*Gegeben und Annahmen*

Gleiche Brücke wie im Bild: $R_1 = 2 thin Omega$, $R_2 = 6 thin Omega$, $R_3 = 3 thin Omega$, $R_4 = 9 thin Omega$, $R_5 = 4 thin Omega$, $R_6 = 6 thin Omega$, $U_q = 12 thin "V"$.

#image("abbildungen/blatt-b-bruecke.svg", width: 60%)

*Gesucht*

#enum(numbering: "a)",
[Strom $I_1$ über eine Dreieck-Stern-Umwandlung.],
[Kontrolle über die Potenziale von a, b und c.],
)
][
*Stern:* Nenner $6 + 3 + 9 = 18 thin Omega$. $R_a = 6 dot.c 3\/18 = 1 thin Omega$, $R_b = 6 dot.c 9\/18 = 3 thin Omega$, $R_c = 3 dot.c 9\/18 = "1,5" thin Omega$.
][
*Gesamtwiderstand:* $(R_b + R_5) || (R_c + R_6) = 7 || "7,5" approx "3,62" thin Omega$; $R_"ges" = 2 + 1 + "3,62" approx "6,62" thin Omega$; $I_1 = 12\/"6,62" approx "1,81" thin "A"$.
][
*Kontrolle:* $phi_a = 12 - "1,8125" dot.c 2 approx "8,38" thin "V"$. Sternpunkt S: $phi_S = phi_a - "1,8125" dot.c 1 approx "6,56" thin "V"$; Zweig über b: $I = "6,56"\/7 approx "0,9375" thin "A"$, $phi_b = "0,9375" dot.c 4 = "3,75" thin "V"$; Zweig über c: $"6,56"\/"7,5" = "0,875" thin "A"$, $phi_c = "5,25" thin "V"$. Probe im Original an a: $("8,38" - "3,75")\/6 + ("8,38" - "5,25")\/3 approx "0,77" + "1,04" = "1,81" thin "A"$.
]

#aufgabe(titel: "Quellen verschieben heißt Bilanzen erhalten", art: "verstehen", quelle: "2.5.2", herkunft: "eigen", minuten: 3,
 ergebnis: [Maschenbeiträge bzw. Knotenbilanzen bleiben unverändert; $I_"quer"=0$.])[
#if not web [*Aufgabe 269* #linebreak()]
Vergleiche die beiden Umformungen. Erkläre, warum die Spannungsquelle in beide betroffenen Zweige übernommen wird und warum bei der Stromquellenumformung kein Strom im ergänzten Querzweig fließt.
#image("abbildungen/gesamt-quelle-verschieben-u.svg", width: 100%, height: 40mm, fit: "contain")#image("abbildungen/gesamt-quelle-verschieben-i.svg", width: 100%, height: 40mm, fit: "contain")
#src[V S. 66–67; Vergleichsfrage als eigene Zusammenführung.]
][
*Spannungsbilanzen vergleichen:* Jeder ursprünglich von Uq durchsetzte Umlauf muss denselben Spannungsbeitrag behalten. Nur eine Kopie in einem Zweig würde einen anderen Umlauf verändern. Zwischen zwei gleich gepolten Kopien heben sich die Quellenbeiträge auf.

][
*Strombilanz vergleichen:* Am ergänzten Knoten lautet die Bilanz $I_Q-I_Q+I_"quer"=0$. Deshalb ist Iquer=0, die ursprüngliche Knotenbilanz bleibt erhalten.

][
*Grenze nennen:* Die gezeigte Topologie und Polung sind wesentlich. Die Umformung verspricht dasselbe Verhalten des übrigen Netzes an den betrachteten Anschlüssen, keine beliebige Verschiebbarkeit von Quellen.
][
*Ergänzung aus der früheren Quizfrage:* _Warum wird die Spannungsquelle im gezeigten Umformungsschritt in beide betroffenen Zweige kopiert?_

*Antwort:* Damit alle ursprünglichen Maschen denselben Quellenbeitrag behalten.

*Begründung:* Die Gleichwertigkeit folgt aus den unveränderten Spannungsbilanzen.

*Typische Verwechslung:*
- Weil die Gesamtspannung dadurch verdoppelt werden soll. – Die Umformung soll das äußere Verhalten gerade erhalten.
- Weil ideale Spannungsquellen überall im Netz beliebig versetzt werden dürfen. – Die Topologie und die Polungen sind Teil der Voraussetzung.
][
*Ergänzung aus der früheren Quizfrage:* _Warum ist der ergänzte Querzweigstrom der gezeigten Stromquellenumformung null?_

*Antwort:* Gleich große entgegengesetzte Quellenbeiträge gleichen sich am ergänzten Knoten aus.

*Begründung:* Aus $I_Q-I_Q+I_"quer"=0$ folgt der Nullstrom.

*Typische Verwechslung:*
- Weil ein idealer Draht grundsätzlich keinen Strom führt. – Ein idealer Draht kann bei null Spannung sehr wohl Strom führen.
- Weil jede Stromquelle gleichzeitig kurzgeschlossen wird. – Die Quellen bleiben aktiv und behalten ihre vorgegebenen Ströme.
][
*Ergänzung aus der früheren Karteikarte:* _Warum darf eine Spannungsquelle nicht einfach an eine beliebige Stelle verschoben werden?_

*Antwort:*
- Die Quelle tritt in bestimmten Maschengleichungen auf.
- Eine beliebige Verschiebung verändert diese Bilanzen.
- Eine zulässige Umformung übernimmt Wert und Polung in alle betroffenen Zweige und erhält damit das betrachtete Klemmenverhalten.
#image("abbildungen/gesamt-quelle-verschieben-u.svg", width: 80%)
]

#aufgabe(titel: "Kontrolle nach dem Verschieben einer Spannungsquelle", art: "verstehen", quelle: "2.5.2", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 270* #linebreak()]
Welche Kontrolle schützt vor einer falschen Spannungsquellen-Verschiebung?
][
*Antwort:* Vergleiche jeden betroffenen Maschenumlauf vor und nach der Umformung. Die Summe der Quellenbeiträge und die zugehörigen Widerstandsbeiträge müssen dasselbe Verhalten beschreiben. Zwischen gleichartigen Kopien müssen sich die Quellenbeiträge korrekt aufheben.
]

#aufgabe(titel: "Erhaltungsidee der Stromquellenumformung", art: "verstehen", quelle: "2.5.3", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 271* #linebreak()]
Welche Erhaltungsidee begründet die gezeigte Stromquellenumformung?
][
*Antwort:*
- Die Knotenbilanzen bleiben erhalten.
- Die eingefügten Quellenströme gleichen sich am zusätzlichen Knoten aus, sodass der Querzweig stromlos bleibt.
- Die Vorschrift gilt für die dargestellte Topologie und passende Quellenrichtungen.
#image("abbildungen/gesamt-quelle-verschieben-i.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Was muss bei der Verschiebung einer Stromquelle an den ursprünglichen Knoten erhalten bleiben?_

*Antwort:* Die vorzeichenrichtige Strombilanz muss dieselbe bleiben. Wert und Richtung der eingefügten Quellen sind darauf abzustimmen. Eine bloße geometrische Verschiebung ohne diese Prüfung ist nicht allgemein zulässig.
]

#kapitel("Kapitel 3 · Netzwerke mit Kirchhoff systematisch berechnen")

#aufgabe(titel: "Cramersche Regel: was ersetzt wird", art: "verstehen", quelle: "3.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 272* #linebreak()]
Was wird bei Cramers Regel durch die rechte Seite ersetzt?
][
*Antwort:* Die Spalte der Koeffizientenmatrix, die zum gesuchten unbekannten Strom gehört. Der Quotient aus dieser neuen Determinante und der ursprünglichen Determinante liefert den Strom, sofern die ursprüngliche Determinante ungleich null ist.
]

#aufgabe(titel: "Unabhängige Gleichungen statt vieler", art: "verstehen", quelle: "3.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 273* #linebreak()]
Warum brauchst du unabhängige statt bloß viele Gleichungen?
][
*Antwort:*
- Eine wiederholte oder umgekehrte Gleichung enthält keine neue Information.
- Für die eindeutige Bestimmung der Unbekannten braucht das lineare System genügend unabhängige Beziehungen.
- Die letzte Knotenbilanz ist bereits in den übrigen enthalten.
#image("abbildungen/gesamt-kirchhoff-allgemein.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Wie viele unabhängige Knotengleichungen besitzt ein zusammenhängendes Netzwerk mit k Knoten?_

*Antwort:* $k-1$.

*Begründung:* Eine weitere Knotenbilanz folgt aus der Summe der anderen.

*Typische Verwechslung:*
- $k+1$. – Zusätzliche redundante Gleichungen erzeugen keine neue Information.
- Immer genau eine. – Nur Netze mit zwei Knoten besitzen eine einzige unabhängige Knotenbilanz.
]

#aufgabe(titel: "Zwei Quellen und drei Zweige direkt mit Kirchhoff lösen", art: "rechnen", quelle: "3.1", herkunft: "original", vorlage: "Vorlesungsskript S. 72–73", minuten: 12,
 ergebnis: [$I_1 approx "1,951" thin "A"$, $I_2 approx -"0,732" thin "A"$, $I_3 approx "1,220" thin "A"$.])[
#if not web [*Aufgabe 274* #linebreak()]
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

#aufgabe(titel: "Zwei Quellen und drei Zweige mit 12 V und 6 V (Variante)", art: "rechnen", quelle: "3.1", herkunft: "variante", vorlage: "Vorlesungsskript S. 72–73", minuten: 12,
  ergebnis: [$I_1 = 2 thin "A"$, $I_2 = -2\/3 thin "A" approx -"0,667" thin "A"$, $I_3 = 4\/3 thin "A" approx "1,333" thin "A"$, $phi_A = 8 thin "V"$],
  tipp: [Erst die Knotengleichung, dann je einen Umlauf links und rechts über den Widerstand $R_3$ aufschreiben.],
)[
#if not web [*Aufgabe 275* #linebreak()]
*Gegeben und Annahmen*

Aufbau wie in der Vorlage (Bild): Zwei ideale Spannungsquellen stehen nebeneinander, beide mit dem Pluspol oben, die Minuspole liegen auf Masse. Links: $U_"q1" = 12 thin "V"$, darüber $R_1 = 2 thin Omega$ zum gemeinsamen oberen Knoten A. Rechts: $U_"q2" = 6 thin "V"$, darüber $R_2 = 3 thin Omega$ zum Knoten A. In der Mitte liegt $R_3 = 6 thin Omega$ von A nach Masse. Zählrichtungen: $I_1$ und $I_2$ zum Knoten A hin, $I_3$ von A nach Masse.
#image("abbildungen/gesamt-drei-zweige.svg", width: 100%, height: 42mm, fit: "contain")
Die Zahlenwerte im Bild gehören zur Vorlage; es gelten die Werte aus dem Text.

*Gesucht*

#enum(numbering: "a)",
[Die drei Zweigströme mit dem Kirchhoff-Gleichungssystem.],
[Die tatsächliche Richtung von $I_2$ und was sie für die Quelle $U_"q2"$ bedeutet.],
[Das Potenzial $phi_A$ und eine Leistungsbilanz als Probe.],
)
][
*Gleichungen aufstellen:* Drei unbekannte Ströme brauchen drei unabhängige Gleichungen. Knoten A: $I_1 + I_2 - I_3 = 0$. Linker Umlauf (Quelle 1, $R_1$, $R_3$): $2 I_1 + 6 I_3 = 12$. Rechter Umlauf (Quelle 2, $R_2$, $R_3$): $3 I_2 + 6 I_3 = 6$. Einheiten: Ω, A und V.
][
*System lösen:* In der Reihenfolge $I_1, I_2, I_3$ lautet die Matrix $mat(1,1,-1;2,0,6;0,3,6)$ mit der Determinante $-36$. Cramer oder Einsetzen liefert $I_1 = 2 thin "A"$, $I_2 = -2\/3 thin "A"$ und $I_3 = 4\/3 thin "A"$.
][
*Richtung deuten:* $I_2$ ist negativ, also fließen tatsächlich $"0,667" thin "A"$ vom Knoten A nach unten in die 6-V-Quelle hinein, am Pluspol. Die Quelle $U_"q2"$ nimmt deshalb Leistung auf (sie wird „geladen“), weil das Knotenpotenzial höher ist als ihre Quellspannung.
][
*Potenzial und Probe:* $phi_A = I_3 R_3 = 4\/3 dot.c 6 = 8 thin "V"$. Kontrolle über die Zweige: $(12 - 8)\/2 = 2 thin "A" = I_1$ und $(6 - 8)\/3 = -2\/3 thin "A" = I_2$. Leistungsbilanz: Quelle 1 liefert $12 dot.c 2 = 24 thin "W"$, Quelle 2 nimmt $6 dot.c 2\/3 = 4 thin "W"$ auf. Die Widerstände setzen $2 dot.c 2^2 + 3 dot.c (2\/3)^2 + 6 dot.c (4\/3)^2 = 8 + "1,33" + "10,67" = 20 thin "W"$ um, genau $24 - 4$.
]

#aufgabe(titel: "Nullgesetzte reale Spannungsquelle", art: "verstehen", quelle: "3.2.1", herkunft: "eigen", minuten: 2,
  tipp: [Die Widerstände gehören zum unveränderten linearen Netz.],
)[
#if not web [*Aufgabe 276* #linebreak()]
Was bleibt beim Nullsetzen einer realen unabhängigen Spannungsquelle in einem Teilfall erhalten? Begründe deine Antwort.
][
*Antwort:* Ihr Innenwiderstand; nur die ideale Spannungsquelle wird kurzgeschlossen.

*Begründung:* Null Volt beschreibt einen Kurzschluss des idealen Quellenanteils.
][
*Typische Verwechslung:*
- Nur die ursprüngliche Quellspannung. – Gerade sie wird für diesen Teilfall auf null gesetzt.
- Nichts, der gesamte Quellenzweig wird entfernt. – Das würde die Widerstandstopologie verändern.
]

#aufgabe(titel: "Überlagerung: Ströme ja, Leistungen nein", art: "verstehen", quelle: "3.2.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 277* #linebreak()]
Warum funktioniert Überlagerung für Ströme in linearen Netzen, aber nicht durch Addieren der Teilleistungen?
][
*Antwort:*
- Die linearen Gleichungen erlauben die Addition der Quellenwirkungen auf Ströme und Spannungen.
- Leistung enthält dagegen Produkte bzw. Quadrate.
- Die Gesamtleistung muss deshalb aus dem gesamten Strom und der gesamten Spannung berechnet werden.

*Merksatz:* Erst Ströme und Spannungen überlagern, danach Leistung berechnen.
#image("abbildungen/gesamt-drei-zweige.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Warum dürfen die Teilleistungen nicht wie die Teilströme überlagert werden?_

*Antwort:* Leistung ist nicht linear in Strom oder Spannung. Beim Quadrieren des Gesamtstroms entstehen Mischterme. Deshalb erst die vorzeichenrichtigen Gesamtgrößen bilden und daraus die Leistung berechnen.
]

#aufgabe(titel: "Dasselbe Dreizweignetz mit Überlagerung lösen", art: "rechnen", quelle: "3.2.1", herkunft: "original", vorlage: "Vorlesungsskript S. 73–75", minuten: 12,
 ergebnis: [Gleiche Gesamtströme wie bei direkter Kirchhoffrechnung; $P_3 approx "14,87" thin "W"$.])[
#if not web [*Aufgabe 278* #linebreak()]
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

#aufgabe(titel: "Dreizweignetz mit 12 V und 6 V überlagern (Variante)", art: "rechnen", quelle: "3.2.1", herkunft: "variante", vorlage: "Vorlesungsskript S. 73–75", minuten: 12,
  ergebnis: [$I_1 = 2 thin "A"$, $I_2 = -2\/3 thin "A"$, $I_3 = 4\/3 thin "A"$; $P_3 approx "10,67" thin "W"$ (nicht 6,67 W aus Teilleistungen)],
  tipp: [Eine nicht betrachtete ideale Spannungsquelle wird durch einen Kurzschluss ersetzt; ihr Widerstand im Zweig bleibt stehen.],
)[
#if not web [*Aufgabe 279* #linebreak()]
*Gegeben und Annahmen*

Aufbau wie in der Vorlage (Bild): $U_"q1" = 12 thin "V"$ über $R_1 = 2 thin Omega$ und $U_"q2" = 6 thin "V"$ über $R_2 = 3 thin Omega$ zum gemeinsamen Knoten A, beide Pluspole oben. $R_3 = 6 thin Omega$ führt von A nach Masse. $I_1$ und $I_2$ zeigen von den Quellen nach A, $I_3$ von A nach Masse.
#image("abbildungen/gesamt-drei-zweige.svg", width: 100%, height: 40mm, fit: "contain")
Die Zahlenwerte im Bild gehören zur Vorlage; es gelten die Werte aus dem Text.

*Gesucht*

#enum(numbering: "a)",
[Die Teilströme, wenn nur $U_"q1"$ bzw. nur $U_"q2"$ wirkt.],
[Die Gesamtströme durch Überlagerung.],
[Die Leistung in $R_3$, und warum man sie nicht aus den Teilleistungen addieren darf.],
)
][
*Nur Uq1 aktiv:* $U_"q2"$ wird kurzgeschlossen, $R_2$ und $R_3$ liegen dann parallel: $3 parallel 6 = 2 thin Omega$. Spannungsteiler: $U_A = 12 dot.c 2\/(2 + 2) = 6 thin "V"$. Daraus $I_(1,1) = (12 - 6)\/2 = 3 thin "A"$, $I_(2,1) = -6\/3 = -2 thin "A"$ (fließt von A in den kurzgeschlossenen Zweig), $I_(3,1) = 6\/6 = 1 thin "A"$.
][
*Nur Uq2 aktiv:* $U_"q1"$ wird kurzgeschlossen: $2 parallel 6 = "1,5" thin Omega$. $U_A = 6 dot.c "1,5"\/(3 + "1,5") = 2 thin "V"$. Daraus $I_(1,2) = -2\/2 = -1 thin "A"$, $I_(2,2) = (6 - 2)\/3 = 4\/3 thin "A"$, $I_(3,2) = 2\/6 = 1\/3 thin "A"$.
][
*Vorzeichenrichtig addieren:* Die Bezugspfeile bleiben in beiden Teilschaltungen gleich, deshalb darf man einfach addieren: $I_1 = 3 - 1 = 2 thin "A"$, $I_2 = -2 + 4\/3 = -2\/3 thin "A"$, $I_3 = 1 + 1\/3 = 4\/3 thin "A"$. Das stimmt mit der direkten Kirchhoff-Rechnung überein.
][
*Leistung erst danach:* $P_3 = I_3^2 R_3 = (4\/3)^2 dot.c 6 approx "10,67" thin "W"$. Die Summe der Teilleistungen $1^2 dot.c 6 + (1\/3)^2 dot.c 6 approx "6,67" thin "W"$ ist falsch, weil $(a + b)^2 != a^2 + b^2$: Der Mischterm $2 a b R_3$ fehlt. Überlagern darf man nur Ströme und Spannungen.
]

#aufgabe(titel: "Gemeinsamer Zweig zweier Maschen", art: "verstehen", quelle: "3.2.2", herkunft: "eigen", minuten: 2,
  tipp: [Zeichne beide Kreisstrompfeile im gemeinsamen Zweig ein.],
)[
#if not web [*Aufgabe 280* #linebreak()]
Was ist der reale Strom in einem gemeinsamen Widerstand zweier gleichsinnig orientierter Nachbarmaschen? Begründe deine Antwort.
][
*Antwort:* Die vorzeichenrichtige Differenz ihrer Maschenströme.

*Begründung:* Im gemeinsamen Zweig durchlaufen die Kreisströme den Widerstand entgegengesetzt.
][
*Typische Verwechslung:*
- Immer nur der größere Maschenstrom. – Der andere Kreisstrom wirkt ebenfalls im gemeinsamen Zweig.
- Immer die Summe der Beträge. – Die Beiträge müssen entsprechend ihrer Richtungen kombiniert werden.
]

#aufgabe(titel: "Von Maschenströmen zu Zweigströmen", art: "verstehen", quelle: "3.2.2", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 281* #linebreak()]
Wie kommst du von Maschenströmen zu messbaren Zweigströmen zurück?
][
*Antwort:*
- Du prüfst, welche Kreisströme den betreffenden Zweig durchlaufen.
- Ihre Beiträge werden passend zum festgelegten Zweigpfeil addiert oder subtrahiert.
- Ein Randzweig kann nur einen Kreisbeitrag enthalten.
- Ein gemeinsamer Zweig enthält mehrere.
#image("abbildungen/gesamt-fuenf-widerstaende.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Warum sind Maschenströme Rechenhilfen und keine zusätzlichen physikalischen Ströme?_

*Antwort:* Sie zerlegen die vorhandenen Zweigströme in gedachte Kreisbeiträge. Nur deren vorzeichenrichtige Überlagerung ergibt den tatsächlich messbaren Strom in einem Zweig. Die Zerlegung fügt keine neue Ladungsbewegung hinzu.
]

#aufgabe(titel: "Fünf Widerstände mit Maschenströmen berechnen", art: "rechnen", quelle: "3.2.2", herkunft: "original", vorlage: "Vorlesungsskript S. 77–78, Beispiel 3.2.2.1", minuten: 15,
 ergebnis: [$I_1="0,477"$, $I_2="0,595"$, $I_3="0,118"$, $I_4="0,461"$, $I_5="0,578" thin "A"$ in den angegebenen realen Richtungen.])[
#if not web [*Aufgabe 282* #linebreak()]
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

#aufgabe(titel: "Fünf Widerstände mit Maschenströmen, 12 V und 6 V (Variante)", art: "rechnen", quelle: "3.2.2", herkunft: "variante", vorlage: "Vorlesungsskript S. 77–78, Beispiel 3.2.2.1", minuten: 15,
  ergebnis: [$I_1 approx "1,373" thin "A"$, $I_2 approx "1,084" thin "A"$, $I_3 approx -"0,289" thin "A"$ (also 0,289 A von A nach B), $I_4 approx "0,470" thin "A"$, $I_5 approx "0,181" thin "A"$],
  tipp: [Ein Maschenstrom pro Fenster. Ein Widerstand zwischen zwei Fenstern bekommt beide Maschenströme mit entgegengesetztem Vorzeichen.],
)[
#if not web [*Aufgabe 283* #linebreak()]
*Gegeben und Annahmen*

Aufbau wie in der Vorlage (Bild): Oben liegen zwei Knoten, A links und B rechts, verbunden durch $R_3$. Von A führt $R_2$ nach Masse, von B führt $R_4$ nach Masse. Ganz links führt $R_1$ von A über die Quelle $U_"q1"$ (Plus oben) nach Masse, ganz rechts führt $R_5$ von B über die Quelle $U_"q2"$ (Plus oben) nach Masse. Die drei Maschenströme $I_"I"$, $I_"II"$, $I_"III"$ laufen in den drei Fenstern von links nach rechts in derselben Drehrichtung wie im Bild.

Werte: $U_"q1" = 12 thin "V"$, $U_"q2" = 6 thin "V"$, $R_1 = 4 thin Omega$, $R_2 = 6 thin Omega$, $R_3 = 3 thin Omega$, $R_4 = 12 thin Omega$, $R_5 = 2 thin Omega$.
#image("abbildungen/gesamt-fuenf-widerstaende.svg", width: 100%, height: 45mm, fit: "contain")
Die Zahlenwerte im Bild gehören zur Vorlage; es gelten die Werte aus dem Text.

Zählrichtungen der Zweigströme wie in der Vorlage: $I_1$ von der linken Quelle nach A, $I_2$ von A nach Masse, $I_3$ von B nach A, $I_4$ von B nach Masse, $I_5$ von der rechten Quelle nach B.

*Gesucht*

#enum(numbering: "a)",
[Das Gleichungssystem der Maschenströme und seine Lösung.],
[Alle fünf Zweigströme mit ihrer tatsächlichen Richtung.],
[Die Potenziale $phi_A$ und $phi_B$ als Probe.],
)
][
*Maschengleichungen aufstellen:* In derselben Vorzeichenkonvention wie im Skriptbeispiel steht auf der Diagonale die Summe der Widerstände eines Fensters, daneben mit negativem Vorzeichen der gemeinsame Widerstand: $-(R_1 + R_2) I_"I" + R_2 I_"II" = U_"q1"$, also $-10 I_"I" + 6 I_"II" = 12$; $-6 I_"I" + 21 I_"II" - 12 I_"III" = 0$; $-12 I_"II" + 14 I_"III" = 6$.
][
*System lösen:* Es ergibt sich $I_"I" approx -"1,3735" thin "A"$, $I_"II" approx -"0,2892" thin "A"$, $I_"III" approx "0,1807" thin "A"$. Negative Maschenströme laufen tatsächlich gegen die gewählte Drehrichtung; das ist kein Fehler.
][
*Zweigströme ablesen:* Ein Zweig, der nur zu einem Fenster gehört, führt dessen Maschenstrom; ein gemeinsamer Zweig führt die Differenz. $I_1 = -I_"I" approx "1,373" thin "A"$, $I_2 = -I_"I" + I_"II" approx "1,084" thin "A"$, $I_3 = I_"II" approx -"0,289" thin "A"$, $I_4 = I_"III" - I_"II" approx "0,470" thin "A"$, $I_5 = I_"III" approx "0,181" thin "A"$.
][
*Richtung von I3 deuten:* $I_3$ ist negativ. Im Unterschied zur Vorlage fließt der Strom hier tatsächlich von A nach B, weil die stärkere Quelle links sitzt und A dadurch höher liegt als B.
][
*Probe mit Potenzialen:* $phi_A = I_2 R_2 approx 6 dot.c "1,0843" approx "6,506" thin "V"$, $phi_B = I_4 R_4 approx 12 dot.c "0,4699" approx "5,639" thin "V"$. Dann $(phi_A - phi_B)\/R_3 approx "0,867"\/3 approx "0,289" thin "A"$ von A nach B, $(12 - phi_A)\/4 approx "1,373" thin "A" = I_1$, $(6 - phi_B)\/2 approx "0,181" thin "A" = I_5$. Knoten A: $I_1 = I_2 + "0,289"$ stimmt; Knoten B: $I_5 + "0,289" = I_4$ stimmt.
]

#aufgabe(titel: "Pufferbatterie: Stromverteilung und stromlose Batterie", art: "rechnen", quelle: "3.2.2", herkunft: "original", vorlage: "Vorlesungsskript S. 79–80, Beispiel 3.2.2.2", minuten: 15,
 ergebnis: [$I approx "6,98" thin "A"$, $I_a approx "7,91" thin "A"$; Batterie liefert etwa 0,93 A; $R_v="1,5" thin Omega$ für IB=0.])[
#if not web [*Aufgabe 284* #linebreak()]
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

#aufgabe(titel: "Pufferbatterie an 48 V: Stromverteilung (Variante)", art: "rechnen", quelle: "3.2.2", herkunft: "variante", vorlage: "Vorlesungsskript S. 79–80, Beispiel 3.2.2.2", minuten: 15,
  ergebnis: [$I = 59\/7 approx "8,43" thin "A"$, $I_a = 43\/7 approx "6,14" thin "A"$, $I_B = 16\/7 approx "2,29" thin "A"$ nach unten (Batterie wird geladen), $U_a approx "49,1" thin "V"$; $R_v = "2,5" thin Omega$ für $I_B = 0$],
  tipp: [Für $I_B = 0$ ist die Batterie wie eine ideale Spannungsquelle im Leerlauf: Die Lastspannung ist dann genau $U_B$.],
)[
#if not web [*Aufgabe 285* #linebreak()]
*Gegeben und Annahmen*

Aufbau wie in der Vorlage (Bild): Ein Generator ($U_q = 66 thin "V"$, Innenwiderstand $R_"iG" = "0,5" thin Omega$) speist über einen Vorwiderstand $R_v = "1,5" thin Omega$ einen Lastknoten. Am Lastknoten liegen parallel nach Masse: die Pufferbatterie ($U_B = 48 thin "V"$, Innenwiderstand $R_"iB" = "0,5" thin Omega$) und die Last $R_a = 8 thin Omega$. Alle Pluspole oben. Zählrichtungen: Generatorstrom $I$ zum Lastknoten, Laststrom $I_a$ nach unten, Batteriestrom $I_B$ nach unten (in den Pluspol hinein).
#image("abbildungen/gesamt-pufferbatterie.svg", width: 100%, height: 40mm, fit: "contain")
Die Zahlenwerte im Bild gehören zur Vorlage; es gelten die Werte aus dem Text.

*Gesucht*

#enum(numbering: "a)",
[Stromverteilung und Lastspannung $U_a$.],
[Wird die Batterie geladen oder entladen?],
[Welcher Vorwiderstand $R_v$ macht die Batterie bei unveränderten Quellen stromlos?],
)
][
*Zwei Maschen wählen:* Die Generatormasche (Generator, $R_v$, Batterie) führt $I$, die Lastmasche (Batterie, Last) führt $I_a$; durch den Batteriezweig fließt dann $I_B = I - I_a$. Umlauf links: $(R_"iG" + R_v + R_"iB") I - R_"iB" I_a = U_q - U_B$, also $"2,5" I - "0,5" I_a = 18$. Umlauf rechts: $-R_"iB" I + (R_"iB" + R_a) I_a = U_B$, also $-"0,5" I + "8,5" I_a = 48$.
][
*System lösen:* Aus der ersten Gleichung $I = (18 + "0,5" I_a)\/"2,5"$; eingesetzt folgt $I_a = 43\/7 approx "6,143" thin "A"$ und $I = 59\/7 approx "8,429" thin "A"$. Lastspannung $U_a = R_a I_a = 344\/7 approx "49,14" thin "V"$.
][
*Batterierichtung deuten:* $I_B = I - I_a = 16\/7 approx "2,29" thin "A"$ ist positiv, fließt also nach unten in den Pluspol der Batterie. Die Batterie wird geladen. Plausibel: Die Lastspannung 49,14 V liegt über $U_B = 48 thin "V"$; die Differenz $16\/7 dot.c "0,5" approx "1,14" thin "V"$ fällt am Batterie-Innenwiderstand ab.
][
*Batterie stromlos einstellen:* Für $I_B = 0$ gilt $U_a = U_B = 48 thin "V"$ und damit $I_a = 48\/8 = 6 thin "A" = I$. Am Generatorzweig müssen $66 - 48 = 18 thin "V"$ bei 6 A abfallen: $R_"iG" + R_v = 18\/6 = 3 thin Omega$, also $R_v = "2,5" thin Omega$. Probe: $(66 - 48)\/("0,5" + "2,5") = 6 thin "A"$.
]

#aufgabe(titel: "Spannung der idealen Stromquelle in der Masche", art: "verstehen", quelle: "3.2.2.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 286* #linebreak()]
Warum darf die Spannung einer idealen Stromquelle in einer Maschenbilanz nicht einfach weggelassen werden?
][
*Antwort:* Die Quelle legt den Strom, aber nicht null Volt fest. Ihre unbekannte Spannung ist Teil der vollständigen Spannungsbilanz. Man nutzt eine Strombedingung bzw. geeignete Widerstandsumläufe und berechnet die Quellenspannung anschließend.
]

#aufgabe(titel: "Stromquellenstrom gleich Maschenstrom", art: "verstehen", quelle: "3.2.2.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 287* #linebreak()]
Wann ist ein Stromquellenstrom direkt gleich einem Maschenstrom?
][
*Antwort:*
- Wenn die Quelle in einem geeigneten Randzweig liegt, der nur von dieser Masche durchlaufen wird.
- In einem gemeinsamen Zweig legt sie dagegen eine Beziehung zwischen mehreren Maschenströmen fest.
- Die Quellenspannung bleibt dabei zunächst unbekannt.
#image("abbildungen/gesamt-ideale-quellen-netz.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Eine ideale Stromquelle liegt im gemeinsamen Zweig zweier Maschen. Was gibt sie unmittelbar vor?_

*Antwort:* Eine vorzeichenrichtige Beziehung zwischen den beiden Maschenströmen.

*Begründung:* Der Zweigstrom ist dort eine Differenz oder Summe der Kreisbeiträge.

*Typische Verwechslung:*
- Beide Maschenströme müssen einzeln gleich dem Quellenstrom sein. – Das gilt nicht allgemein bei einem gemeinsam durchlaufenen Zweig.
- Die Spannung im Quellenzweig ist null. – Eine Stromquelle legt ihren Strom fest; ihre Spannung folgt aus dem Netz.
]

#aufgabe(titel: "Ideale Stromquellen in einem Viermaschennetz", art: "rechnen", quelle: "3.2.2.1", herkunft: "original", vorlage: "Vorlesungsskript S. 80–84, Beispiel 3.2.2.3", minuten: 20,
 ergebnis: [$phi_E approx -"1,091"$, $phi_A approx -"4,636"$, $phi_B approx -"6,636"$, $phi_C="8,625"$, $phi_D="6,875" thin "V"$.])[
#if not web [*Aufgabe 288* #linebreak()]
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

#aufgabe(titel: "Diagonale der Leitwertmatrix", art: "verstehen", quelle: "3.2.3", herkunft: "eigen", minuten: 2,
  tipp: [Schreibe die vom eigenen Potenzial abhängigen Zweigströme aus.],
)[
#if not web [*Aufgabe 289* #linebreak()]
Was steht im Diagonaleintrag einer üblichen Leitwertmatrix? Begründe deine Antwort.
][
*Antwort:* Die Summe der am betreffenden Knoten angeschlossenen Leitwerte.

*Begründung:* Jeder dieser Zweige trägt einen vom eigenen Potenzial abhängigen Strom bei.
][
*Typische Verwechslung:*
- Die Summe der Widerstände im gesamten Netzwerk. – Die Knotenmethode verknüpft Potenziale über Leitwerte.
- Immer null, weil die Knotensumme null ist. – Die Bilanzsumme null bedeutet nicht, dass jeder Koeffizient null wäre.
]

#aufgabe(titel: "Zweigstrom aus Knotenpotenzialen", art: "verstehen", quelle: "3.2.3", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 290* #linebreak()]
Wie erhältst du nach der Knotenpotenzialrechnung einen Strom von A nach B?
][
*Antwort:* Bilde zuerst die Potenzialdifferenz in dieser Richtung. Multipliziere sie mit dem Leitwert des Zweigs: $I_(A B)=G_(A B)(phi_A-phi_B)$. Ein negativer Wert bedeutet einen tatsächlichen Strom von B nach A.
]

#aufgabe(titel: "Knotenpotenziale reichen aus", art: "verstehen", quelle: "3.2.3", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 291* #linebreak()]
Warum reichen die Knotenpotenziale aus, um das lineare Widerstandsnetz auszuwerten?
][
*Antwort:*
- Jede Zweigspannung ist die Differenz der angeschlossenen Potenziale.
- Mit dem jeweiligen Widerstand folgt daraus der Zweigstrom.
- Danach lassen sich auch die Leistungen bestimmen.
- Alle Potenziale müssen denselben Bezugspunkt verwenden.
#image("abbildungen/gesamt-knoten-netz.svg", width: 80%)
]

#aufgabe(titel: "Fünf Widerstände mit Knotenpotenzialen kontrollieren", art: "rechnen", quelle: "3.2.3", herkunft: "original", vorlage: "Vorlesungsskript S. 84–85", minuten: 15,
 ergebnis: [$phi_A approx "7,137" thin "V"$, $phi_B approx "7,373" thin "V"$, $I_3 approx "0,118" thin "A"$ von B nach A.])[
#if not web [*Aufgabe 292* #linebreak()]
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

#aufgabe(titel: "Fünf Widerstände mit Knotenpotenzialen, 12 V und 6 V (Variante)", art: "rechnen", quelle: "3.2.3", herkunft: "variante", vorlage: "Vorlesungsskript S. 84–85", minuten: 12,
  ergebnis: [$phi_A = 540\/83 approx "6,506" thin "V"$, $phi_B = 468\/83 approx "5,639" thin "V"$, $I_3 approx "0,289" thin "A"$ von A nach B],
  tipp: [Eine reale Spannungsquelle $U_q$ mit Widerstand $R$ wirkt am Knoten wie ein eingespeister Strom $U_q\/R$ parallel zum Leitwert $1\/R$.],
)[
#if not web [*Aufgabe 293* #linebreak()]
*Gegeben und Annahmen*

Quellen $U_"q1" = 12 thin "V"$ und $U_"q2" = 6 thin "V"$ gegen Masse. $R_1 = 4 thin Omega$ zwischen dem 12-V-Quellknoten und A, $R_2 = 6 thin Omega$ von A nach Masse, $R_3 = 3 thin Omega$ zwischen A und B, $R_4 = 12 thin Omega$ von B nach Masse, $R_5 = 2 thin Omega$ zwischen B und dem 6-V-Quellknoten. Die Spannung $U_3$ sei positiv von B nach A gerichtet (wie in der Vorlage).

*Gesucht*

#enum(numbering: "a)",
[Die Knotengleichungen in Leitwertform.],
[Die Potenziale $phi_A$ und $phi_B$.],
[$U_3$ und der Strom durch $R_3$ mit tatsächlicher Richtung.],
)
][
*Leitwerte eintragen:* $G_1 = 1\/4$, $G_2 = 1\/6$, $G_3 = 1\/3$, $G_4 = 1\/12$, $G_5 = 1\/2$, jeweils in S. Die Quellen speisen wie Ströme ein: links $12 G_1 = 3 thin "A"$, rechts $6 G_5 = 3 thin "A"$.
][
*Knotenbilanzen ordnen:* Auf der Diagonale steht die Summe aller Leitwerte am Knoten, daneben negativ der Koppelleitwert: $(G_1 + G_2 + G_3) phi_A - G_3 phi_B = 3$, also $3\/4 thin phi_A - 1\/3 thin phi_B = 3$; $-G_3 phi_A + (G_3 + G_4 + G_5) phi_B = 3$, also $-1\/3 thin phi_A + 11\/12 thin phi_B = 3$.
][
*System lösen:* Determinante $3\/4 dot.c 11\/12 - 1\/9 = 83\/144$. Cramer: $phi_A = (3 dot.c 11\/12 + 1\/3 dot.c 3)\/(83\/144) = 540\/83 approx "6,506" thin "V"$, $phi_B = (3\/4 dot.c 3 + 1\/3 dot.c 3)\/(83\/144) = 468\/83 approx "5,639" thin "V"$.
][
*Richtung prüfen:* $U_3 = phi_B - phi_A approx -"0,867" thin "V"$ ist negativ. Der Strom durch $R_3$ fließt also tatsächlich von A nach B: $|U_3|\/R_3 approx "0,289" thin "A"$. Das stimmt mit der Maschenstrom-Variante derselben Schaltung überein.
]

#aufgabe(titel: "Hohes Potenzial an einer idealen Stromquelle", art: "verstehen", quelle: "3.2.4", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 294* #linebreak()]
Warum widerlegt ein sehr hohes berechnetes Potenzial das Modell einer idealen Stromquelle nicht?
][
*Antwort:* Das ideale Modell begrenzt den Quellenstrom, aber nicht seinen Spannungsbereich. Eine reale Quelle besitzt dagegen einen endlichen Arbeitsbereich. Das Ergebnis kann mathematisch zum Idealmodell passen, obwohl eine reale Quelle es nicht erreichen würde.
]

#aufgabe(titel: "Ideale Spannungs- gegen ideale Stromquelle", art: "verstehen", quelle: "3.2.4", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 295* #linebreak()]
Was ist der entscheidende Unterschied zwischen idealer Spannungs- und idealer Stromquelle?
][
*Antwort:*
- Die Spannungsquelle hält U fest, I folgt aus dem Netz.
- Die Stromquelle hält I fest, U folgt aus dem Netz.
- Reale Quellen erreichen diese Bedingungen nur innerhalb ihres Arbeitsbereichs.

*Merksatz:* Spannungsquelle hält U; Stromquelle hält I.
#image("abbildungen/gesamt-quellen-ideal-gemischt.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Was bestimmt bei einer idealen Stromquelle die Quellenspannung?_

*Antwort:* Das angeschlossene Netzwerk bei vorgegebenem Quellenstrom.

*Begründung:* Die Quelle passt ihre Spannung im idealen Modell an die Strombedingung an.

*Typische Verwechslung:*
- Der Stromwert allein, unabhängig von der Last. – Ohne das restliche Netzwerk ist die Spannung nicht festgelegt.
- Sie ist immer null. – Null Spannung ist nur ein möglicher besonderer Betriebsfall.
]

#aufgabe(titel: "Eine ideale Spannungsquelle und eine ideale Stromquelle", art: "rechnen", quelle: "3.2.4", herkunft: "original", vorlage: "Vorlesungsskript S. 86, Aufg. 3.2.4.1", minuten: 10,
 ergebnis: [$phi_X=1 thin "V"$, $phi_Y=1001 thin "V"$; Strom in der Spannungsquelle 0,899 A nach unten.])[
#if not web [*Aufgabe 296* #linebreak()]
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

#aufgabe(titel: "Ideale Spannungsquelle 2 V und Stromquelle 0,5 A (Variante)", art: "rechnen", quelle: "3.2.4", herkunft: "variante", vorlage: "Vorlesungsskript S. 86, Aufg. 3.2.4.1", minuten: 10,
  ergebnis: [$phi_X = 2 thin "V"$, $phi_Y = 1002 thin "V"$; Ströme 0,1 A (20 Ω) und 4 mA (2 mS) nach unten; Strom in der Spannungsquelle 0,396 A nach unten],
  tipp: [Eine ideale Spannungsquelle legt ein Potenzial fest, eine ideale Stromquelle einen Zweigstrom. Damit ist fast alles schon bekannt.],
)[
#if not web [*Aufgabe 297* #linebreak()]
*Gegeben und Annahmen*

Aufbau wie in der Vorlage (Bild): Masse unten. Eine ideale Spannungsquelle 2 V (Plus oben) legt den Knoten X fest. Parallel dazu liegen zwischen X und Masse ein Widerstand $20 thin Omega$ und ein Zweig mit dem Leitwert $G = 2 thin "mS"$. Ein weiterer paralleler Zweig enthält unten eine ideale Stromquelle, die 0,5 A von Masse nach oben zum Knoten Y treibt, und darüber einen Widerstand $2 thin "k"Omega$ von Y nach X.
#image("abbildungen/gesamt-quellen-ideal-gemischt.svg", width: 100%, height: 41mm, fit: "contain")
Die Zahlenwerte im Bild gehören zur Vorlage; es gelten die Werte aus dem Text.

*Gesucht*

#enum(numbering: "a)",
[Die Potenziale $phi_X$ und $phi_Y$.],
[Alle Zweigströme mit Richtung.],
[Den Strom durch die Spannungsquelle und eine Leistungsbilanz.],
)
][
*Feste Größen zuerst:* Die ideale Spannungsquelle setzt $phi_X = 2 thin "V"$, unabhängig vom Rest. Die ideale Stromquelle erzwingt 0,5 A von Masse nach Y und weiter durch den 2-kΩ-Widerstand nach X.
][
*Hohes Potenzial:* Am 2-kΩ-Widerstand fallen in Stromrichtung Y→X $"0,5" thin "A" dot.c 2000 thin Omega = 1000 thin "V"$ ab. Also $phi_Y = phi_X + 1000 thin "V" = 1002 thin "V"$. So hoch muss die Stromquelle ihre Klemmenspannung treiben, um 0,5 A zu erzwingen.
][
*Parallele Zweige:* Beide liegen an 2 V. Durch $20 thin Omega$: $2\/20 = "0,1" thin "A"$ nach unten. Durch 2 mS (entspricht 500 Ω): $I = G U = "0,002" dot.c 2 = "0,004" thin "A"$ nach unten.
][
*Quellenstrom bilanzieren:* Am Knoten X kommen 0,5 A an, 0,104 A fließen über die Widerstände ab. Der Rest fließt durch die Spannungsquelle nach unten: $I_U = "0,5" - "0,1" - "0,004" = "0,396" thin "A"$. Weil der Strom am Pluspol hineinfließt, nimmt die Spannungsquelle Leistung auf.
][
*Leistungsprobe:* Die Stromquelle liefert $1002 thin "V" dot.c "0,5" thin "A" = 501 thin "W"$. Verbraucht werden $2000 dot.c "0,5"^2 = 250 thin "W"$, $20 dot.c "0,1"^2 = "0,2" thin "W"$, $2 dot.c "0,004" = "0,008" thin "W"$ und in der Spannungsquelle $2 dot.c "0,396" = "0,792" thin "W"$. Summe: 501 W.
]

#aufgabe(titel: "Zwei ideale Stromquellen: negative Knotenpotenziale", art: "rechnen", quelle: "3.2.4", herkunft: "original", vorlage: "Vorlesungsskript S. 86, Aufg. 3.2.4.2", minuten: 10,
 ergebnis: [$phi_A=1 thin "V"$, $phi_B=-3 thin "V"$, $phi_C=-18 thin "V"$.])[
#if not web [*Aufgabe 298* #linebreak()]
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

#aufgabe(titel: "Zwei ideale Stromquellen: positive Knotenpotenziale (Variante)", art: "rechnen", quelle: "3.2.4", herkunft: "variante", vorlage: "Vorlesungsskript S. 86, Aufg. 3.2.4.2", minuten: 10,
  ergebnis: [$phi_A = 11 thin "V"$, $phi_B = 8 thin "V"$, $phi_C = 6 thin "V"$],
)[
#if not web [*Aufgabe 299* #linebreak()]
*Gegeben und Annahmen*

Aufbau wie in der Vorlage (Bild): $R_1 = 1 thin "k"Omega$ zwischen A und B, $R_2 = 2 thin "k"Omega$ zwischen B und C, $R_3 = 4 thin "k"Omega$ von B nach Masse. Eine ideale Stromquelle $I_1 = 3 thin "mA"$ speist von Masse nach A. Eine ideale Stromquelle $I_2 = 1 thin "mA"$ führt von C nach Masse.
#image("abbildungen/gesamt-zwei-stromquellen.svg", width: 100%, height: 40mm, fit: "contain")
Die Zahlenwerte im Bild gehören zur Vorlage; es gelten die Werte aus dem Text.

*Gesucht*

Die Potenziale von A, B und C gegen Masse.
][
*Ströme in den Nachbarzweigen:* Am Knoten A hängen nur die Stromquelle und $R_1$, also fließen 3 mA von A nach B. Am Knoten C hängen nur $R_2$ und die zweite Stromquelle, also fließt 1 mA von B nach C.
][
*Knoten B bilanzieren:* Zu B fließen 3 mA hin, 1 mA weiter nach C. Durch $R_3$ fließen deshalb $3 - 1 = 2 thin "mA"$ nach Masse. Damit $phi_B = 2 thin "mA" dot.c 4 thin "k"Omega = 8 thin "V"$.
][
*Nachbarknoten:* In Stromrichtung fällt das Potenzial. $phi_A = phi_B + 3 thin "mA" dot.c 1 thin "k"Omega = 11 thin "V"$. $phi_C = phi_B - 1 thin "mA" dot.c 2 thin "k"Omega = 6 thin "V"$.
][
*Vergleich mit der Vorlage:* Dort holt $I_2$ mehr Strom ab, als $I_1$ liefert; der Strom in $R_3$ kehrt sich um und die Potenziale werden negativ. Hier ist $I_1 > I_2$, deshalb liegen alle Potenziale über Masse.
]

#kapitel("Kapitel 4 · Zweipoltheorie und nichtlineare Arbeitspunkte")

#aufgabe(titel: "Was die Ersatzstromquelle einprägt", art: "verstehen", quelle: "4.1", herkunft: "eigen", minuten: 2,
  tipp: [Beachte den Parallelzweig des Innenwiderstands.],
)[
#if not web [*Aufgabe 300* #linebreak()]
Was ist bei einer realen Ersatzstromquelle mit Parallel-Innenwiderstand eingeprägt? Begründe deine Antwort.
][
*Antwort:* Der Strom des idealen Quellenanteils.

*Begründung:* Er teilt sich zwischen Last und Innenwiderstand auf.
][
*Typische Verwechslung:*
- Immer der gesamte Laststrom. – Nur ein Teil des Quellenstroms muss durch die Last fließen.
- Die Spannung am Innenwiderstand unabhängig von der Last. – Die Klemmenspannung ändert sich mit der Stromaufteilung.
]

#aufgabe(titel: "Gleichwertigkeit der Ersatzquellen", art: "verstehen", quelle: "4.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 301* #linebreak()]
Welche Gleichwertigkeit versprechen Ersatzspannungsquelle und Ersatzstromquelle?
][
*Antwort:* Sie liefern an denselben beiden Klemmen dieselbe Beziehung zwischen Spannung und äußerem Laststrom. Nicht zugesichert ist die Gleichheit ursprünglicher innerer Ströme oder Verlustleistungen. Es gilt $U_l=I_k R_i$.
]

#aufgabe(titel: "Gleichwertige Ersatzquellen, verschiedene innere Leistung", art: "verstehen", quelle: "4.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 302* #linebreak()]
Warum können zwei gleichwertige Ersatzquellen intern unterschiedliche Leistungen besitzen?
][
*Antwort:*
- Gleichwertigkeit bezieht sich auf die äußeren Klemmen.
- Der innere Aufbau aus idealem Quellenanteil und Widerstand unterscheidet sich.
- Für ursprüngliche innere Leistungen muss die Originalschaltung ausgewertet werden.

*Merksatz:* Außen gleichwertig bedeutet innen nicht leistungsgleich.
#image("abbildungen/map-zweipol.svg", width: 80%)
]

#aufgabe(titel: "Was im Leerlauf entfernt wird", art: "verstehen", quelle: "4.2", herkunft: "eigen", minuten: 2,
  tipp: [Lege zuerst genau fest, welches Bauteil die äußere Last ist.],
)[
#if not web [*Aufgabe 303* #linebreak()]
Was wird bei der Leerlaufrechnung eines Zweipols entfernt? Begründe deine Antwort.
][
*Antwort:* Nur die gewählte äußere Last.

*Begründung:* Alle anderen Teile des aktiven Netzes bleiben angeschlossen.
][
*Typische Verwechslung:*
- Alle parallelen Widerstände des ursprünglichen Netzwerks. – Solche Widerstände können zum aktiven Teil gehören und müssen erhalten bleiben.
- Alle unabhängigen Quellen. – Für die Leerlaufspannung bleiben die Quellen aktiv.
]

#aufgabe(titel: "Last und Klemmen zuerst festlegen", art: "verstehen", quelle: "4.2", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 304* #linebreak()]
Warum musst du vor jeder Zweipolrechnung die Last und ihre Klemmen genau festlegen?
][
*Antwort:*
- Nur so ist eindeutig, welcher Zweig abgetrennt wird und was im aktiven Netz bleibt.
- Ein Parallelwiderstand kann zum Quellennetz gehören, obwohl er optisch neben der Last liegt.
- Andere Klemmen liefern andere Ersatzgrößen.
#image("abbildungen/gesamt-zweipol-zwei-quellen.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Warum bestimmt die Wahl der Klemmen, welche Ersatzquelle berechnet wird?_

*Antwort:* Die Klemmen legen fest, welche Last abgetrennt und welcher Rest als aktiver Zweipol betrachtet wird. Andere Klemmen sehen einen anderen Widerstands- und Quellenzusammenhang. Ersatzgrößen sind deshalb stets auf das gewählte Klemmenpaar bezogen.
]

#aufgabe(titel: "Zweipolersatz mit zwei gegensinnig gepolten Quellen", art: "rechnen", quelle: "4.2", herkunft: "original", vorlage: "Vorlesungsskript S. 90–92", minuten: 15,
 ergebnis: [$U_l approx "7,143" thin "V"$, $R_i approx "12,571" thin Omega$, $I_a approx "0,3165" thin "A"$.])[
#if not web [*Aufgabe 305* #linebreak()]
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

#aufgabe(titel: "Zweipolersatz mit zwei gegensinnigen Quellen, 12 V und 6 V (Variante)", art: "rechnen", quelle: "4.2", herkunft: "variante", vorlage: "Vorlesungsskript S. 90–92", minuten: 15,
  ergebnis: [$R_i = 6 thin Omega$, $U_l = 6 thin "V"$, $I_k = 1 thin "A"$; $I_a = 3\/7 approx "0,429" thin "A"$, $U_a approx "3,43" thin "V"$, $P_a approx "1,47" thin "W"$],
  tipp: [Für $R_i$ alle idealen Spannungsquellen durch Kurzschlüsse ersetzen; für $U_l$ fließt durch $R_3$ kein Strom.],
)[
#if not web [*Aufgabe 306* #linebreak()]
*Gegeben und Annahmen*

Aufbau wie in der Vorlage (Bild): Masse ist der Klemmpunkt B. Linker Zweig: Quelle mit oberem Pol $+12 thin "V"$ gegen B, darüber $R_1 = 6 thin Omega$ zum inneren Knoten N. Mittlerer Zweig: Quelle mit oberem Pol $-6 thin "V"$ gegen B, darüber $R_2 = 12 thin Omega$ nach N. Von N führt $R_3 = 2 thin Omega$ zur Klemme A. Zwischen A und B liegt die Last $R_a = 8 thin Omega$.
#image("abbildungen/gesamt-zweipol-zwei-quellen.svg", width: 100%, height: 45mm, fit: "contain")
Die Zahlenwerte im Bild gehören zur Vorlage; es gelten die Werte aus dem Text.

*Gesucht*

#enum(numbering: "a)",
[Innenwiderstand $R_i$ und Leerlaufspannung $U_l$ der Ersatzspannungsquelle bezüglich A–B.],
[Kurzschlussstrom $I_k$ als Probe.],
[Laststrom, Lastspannung und Lastleistung.],
)
][
*Last abtrennen, Ri bilden:* Beide Spannungsquellen werden kurzgeschlossen. Von A aus sieht man $R_3$ in Reihe mit $R_1 parallel R_2$: $R_i = 2 + (6 dot.c 12)\/(6 + 12) = 2 + 4 = 6 thin Omega$.
][
*Leerlaufspannung:* Ohne Last fließt durch $R_3$ kein Strom, also $U_l = phi_N$. Knotenregel an N: $(U_l - 12)\/6 + (U_l + 6)\/12 = 0$. Mal 12: $2 U_l - 24 + U_l + 6 = 0$, also $U_l = 6 thin "V"$. Wichtig: Die zweite Quelle geht mit $-6 thin "V"$ ein, nicht mit $+6 thin "V"$.
][
*Kurzschlussprobe:* $I_k = U_l\/R_i = 6\/6 = 1 thin "A"$. Direkt nachgerechnet: Bei A–B kurzgeschlossen gilt an N $(phi_N - 12)\/6 + (phi_N + 6)\/12 + phi_N\/2 = 0$, also $phi_N = 2 thin "V"$ und $I_k = 2\/2 = 1 thin "A"$.
][
*Last anschließen:* $I_a = U_l\/(R_i + R_a) = 6\/14 = 3\/7 approx "0,429" thin "A"$, $U_a = R_a I_a = 24\/7 approx "3,43" thin "V"$, $P_a = I_a^2 R_a = 72\/49 approx "1,47" thin "W"$.
]

#aufgabe(titel: "Strom I6 mit Ersatzspannungsquellen", art: "rechnen", quelle: "4.2", herkunft: "original", vorlage: "Übungsblatt A, Aufg. 8", minuten: 12,
  ergebnis: [$I_6 approx "0,105" thin "A" = 105 thin "mA"$],
  tipp: [Von links nach rechts arbeiten: Quelle mit $R_1$ und $R_2$ zu einer Ersatzquelle machen, $R_3$ dazurechnen, dann $R_4$ und $R_5$ genauso.],
)[
#if not web [*Aufgabe 307* #linebreak()]
*Gegeben*

Kettenschaltung: Die Quelle $U_q = 5 thin "V"$ speist über $R_1 = 10 thin Omega$ einen ersten Knoten; von dort liegt $R_2 = 40 thin Omega$ nach unten. Über $R_3 = 12 thin Omega$ geht es zum zweiten Knoten; dort liegt $R_4 = 100 thin Omega$ nach unten. Über $R_5 = 10 thin Omega$ geht es zur Last $R_6 = 5 thin Omega$, die den Strom $I_6$ führt.
#image("abbildungen/blatt-a-kette-r1-r6.svg", width: 95%)

*Gesucht*

Mit Hilfe der Ersatzquellen soll der Strom $I_6$ numerisch bestimmt werden. Wie hoch ist $I_6$?
][
*Erste Ersatzquelle (links von R3):* Quelle, $R_1$ und $R_2$ bilden einen unbelasteten Spannungsteiler. Leerlaufspannung $U_"l1" = 5 dot.c 40\/(10 + 40) = 4 thin "V"$, Innenwiderstand (Quelle kurzgeschlossen) $R_"i1" = 10 parallel 40 = 8 thin Omega$. $R_3$ liegt in Reihe dazu: $R_"i1"' = 8 + 12 = 20 thin Omega$.
][
*Zweite Ersatzquelle (links von R5):* Die Ersatzquelle (4 V, 20 Ω) wird mit $R_4$ belastet. $U_"l2" = 4 dot.c 100\/(20 + 100) = 10\/3 approx "3,33" thin "V"$, $R_"i2" = 20 parallel 100 = 50\/3 approx "16,67" thin Omega$. Mit $R_5$ in Reihe: $R_i = 50\/3 + 10 = 80\/3 approx "26,67" thin Omega$.
][
*Last anschließen:* Jetzt ist nur noch ein Grundstromkreis übrig: $I_6 = U_"l2"\/(R_i + R_6) = (10\/3)\/(80\/3 + 5) = 10\/95 approx "0,105" thin "A"$.
][
*Warum das schneller ist:* Statt ein Gleichungssystem mit allen Zweigen aufzustellen, wird die Schaltung Stück für Stück zu einer Quelle mit Innenwiderstand zusammengefasst. Probe mit der handschriftlichen Lösung: 105 mA.
]

#aufgabe(titel: "Strom I6 mit Ersatzspannungsquellen bei 12 V (Variante)", art: "rechnen", quelle: "4.2", herkunft: "variante", vorlage: "Übungsblatt A, Aufg. 8", minuten: 12,
  ergebnis: [$U_"l1" = 9 thin "V"$, $U_"l2" = "4,5" thin "V"$, $R_i = 20 thin Omega$, $I_6 = "0,15" thin "A"$],
)[
#if not web [*Aufgabe 308* #linebreak()]
*Gegeben*

Dieselbe Kettenschaltung wie im Bild: $U_q = 12 thin "V"$, $R_1 = 20 thin Omega$ (Längszweig), $R_2 = 60 thin Omega$ (Querzweig), $R_3 = 15 thin Omega$ (Längszweig), $R_4 = 30 thin Omega$ (Querzweig), $R_5 = 5 thin Omega$ (Längszweig), Last $R_6 = 10 thin Omega$.
#image("abbildungen/blatt-a-kette-r1-r6.svg", width: 95%)

*Gesucht*

#enum(numbering: "a)",
[Leerlaufspannung und Innenwiderstand nach $R_1$/$R_2$ und nach $R_3$/$R_4$.],
[Die Ersatzquelle an den Klemmen von $R_6$ und den Strom $I_6$.],
)
][
*Erste Ersatzquelle:* $U_"l1" = 12 dot.c 60\/(20 + 60) = 9 thin "V"$, $R_"i1" = 20 parallel 60 = 15 thin Omega$; mit $R_3$ in Reihe $15 + 15 = 30 thin Omega$.
][
*Zweite Ersatzquelle:* Belastung mit $R_4 = 30 thin Omega$: $U_"l2" = 9 dot.c 30\/(30 + 30) = "4,5" thin "V"$, $R_"i2" = 30 parallel 30 = 15 thin Omega$. Mit $R_5$: $R_i = 15 + 5 = 20 thin Omega$.
][
*Laststrom:* $I_6 = U_"l2"\/(R_i + R_6) = "4,5"\/(20 + 10) = "0,15" thin "A"$.
][
*Probe ohne Ersatzquelle:* Bei $I_6 = "0,15" thin "A"$ liegt am zweiten Knoten (vor $R_5$) die Spannung $"0,15" dot.c (5 + 10) = "2,25" thin "V"$. Durch $R_4$: $"2,25"\/30 = "0,075" thin "A"$, durch $R_3$ also 0,225 A; erster Knoten $"2,25" + "0,225" dot.c 15 = "5,625" thin "V"$. Durch $R_2$: $"0,09375" thin "A"$, durch $R_1$: $"0,31875" thin "A"$, Abfall $"6,375" thin "V"$. Summe $"5,625" + "6,375" = 12 thin "V" = U_q$.
]

#aufgabe(titel: "Ideale Stromquelle null setzen", art: "verstehen", quelle: "4.2.1", herkunft: "eigen", minuten: 2,
  tipp: [Überlege, welche Verbindung unabhängig von der Spannung null Strom erzwingt.],
)[
#if not web [*Aufgabe 309* #linebreak()]
Wie wird eine unabhängige ideale Stromquelle beim Bestimmen des Ersatzinnenwiderstands null gesetzt? Begründe deine Antwort.
][
*Antwort:* Als offene Verbindung.

*Begründung:* Null Strom bedeutet beim idealen Stromquellenanteil Leerlauf.
][
*Typische Verwechslung:*
- Als idealer Draht. – Ein idealer Draht entspricht null Spannung, nicht einer Nullstromquelle.
- Sie behält ihren ursprünglichen Strom. – Für diesen Nullsetz-Trick wird gerade die unabhängige Quelle deaktiviert.
]

#aufgabe(titel: "Innenwiderstände bleiben beim Nullsetzen", art: "verstehen", quelle: "4.2.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 310* #linebreak()]
Warum verschwinden beim Nullsetzen der Quellen nicht auch ihre Innenwiderstände?
][
*Antwort:*
- Die Quelle wird als Vorgabe auf null gesetzt.
- Der Widerstand beschreibt weiterhin die lineare Verbindung im Netzwerk.
- Ihn zu entfernen würde die Struktur verändern und einen falschen Ersatzinnenwiderstand ergeben.
#image("abbildungen/gesamt-zweipol-zwei-quellen.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Was geschieht beim Nullsetzen einer realen Spannungsquelle mit ihrem Innenwiderstand?_

*Antwort:* Der ideale Spannungsanteil wird kurzgeschlossen. Der physisch zum Modell gehörende Innenwiderstand bleibt erhalten. Der gesuchte Widerstand ergibt sich beim Blick in die offenen Lastklemmen.
]

#aufgabe(titel: "Kein Spannungsabfall am Zugangswiderstand", art: "verstehen", quelle: "4.2.2", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 311* #linebreak()]
Warum fällt in der gezeigten Leerlaufrechnung am Zugangswiderstand R3 keine Spannung ab?
][
*Antwort:* Durch R3 fließt bei offener Last kein Strom. Deshalb ist sein ohmscher Spannungsabfall null. Das Klemmenpotenzial entspricht dem inneren angeschlossenen Knotenpotenzial.
]

#aufgabe(titel: "Leerlauf heißt nur Laststrom null", art: "verstehen", quelle: "4.2.2", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 312* #linebreak()]
Warum bedeutet Leerlauf nur Laststrom null und nicht zwangsläufig alle Ströme null?
][
*Antwort:*
- Der Lastzweig ist offen, aber das aktive Netz kann innere geschlossene Wege enthalten.
- Unterschiedliche Quellen können dort weiterhin Strom treiben.
- Diese inneren Ströme bestimmen mit, welche Leerlaufspannung an den Klemmen entsteht.

*Merksatz:* Offene Last heißt nicht: überall stromlos.
#image("abbildungen/gesamt-zweipol-zwei-quellen.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Kann im aktiven Netzwerk ein innerer Strom fließen, obwohl die Lastklemmen offen sind?_

*Antwort:* Ja, Quellen können innerhalb des Netzes einen geschlossenen Kreis speisen.

*Begründung:* Nur der äußere Laststrom ist im Leerlauf null.

*Typische Verwechslung:*
- Nein, Leerlauf bedeutet überall im Netzwerk Strom null. – Die offenen Lastklemmen unterbrechen nicht automatisch alle inneren Strompfade.
- Nur wenn alle Quellen zuvor null gesetzt wurden. – Für die Leerlaufspannung bleiben sie aktiv.
]

#aufgabe(titel: "Leerlaufspannung und Kurzschlussstrom als Probe", art: "verstehen", quelle: "4.2.3", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 313* #linebreak()]
Wie hilft die Beziehung zwischen Leerlaufspannung und Kurzschlussstrom beim Prüfen der Ersatzquelle?
][
*Antwort:*
- Bei endlichem Innenwiderstand muss ihr Quotient denselben Innenwiderstand ergeben wie der Blick in das nullgesetzte Netz.
- Die Bezugsrichtungen müssen zusammenpassen.
- Eine unabhängige zweite Rechnung findet deshalb leicht Polungs- oder Topologiefehler.
#image("abbildungen/map-zweipol.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Welche Beziehung muss zwischen den drei Ersatzgrößen bei endlichem Ri gelten?_

*Antwort:* $U_l=I_k R_i$.

*Begründung:* Leerlauf- und Kurzschlusspunkt gehören zur selben linearen Quellenkennlinie.

*Typische Verwechslung:*
- $I_k=U_l R_i$. – Die Einheit wäre nicht Ampere; der Strom ist Spannung geteilt durch Widerstand.
- $R_i=I_k/U_l$. – Das ist ein Leitwert, nicht der Innenwiderstand.
][
*Ergänzung aus der früheren Quizfrage:* _Warum ist eine dritte, unabhängig berechnete Ersatzgröße als Probe nützlich?_

*Antwort:* Sie muss zu den beiden anderen Größen und zur festgelegten Polung passen. Ein Widerspruch kann auf eine falsche Klemmenwahl, ein vergessenes Bauteil oder einen Vorzeichenfehler hinweisen. Kleine Abweichungen durch Rundungen werden getrennt beurteilt.
]

#aufgabe(titel: "Quellengerade bei geänderter Leerlaufspannung", art: "verstehen", quelle: "4.3", herkunft: "eigen", minuten: 2,
  tipp: [Die Steigung hängt nur vom Innenwiderstand ab.],
)[
#if not web [*Aufgabe 314* #linebreak()]
Was bewirkt eine Änderung von Ul bei unverändertem Ri im I-U-Diagramm? Begründe deine Antwort.
][
*Antwort:* Die Quellenlinie verschiebt sich parallel.

*Begründung:* Die Steigung bleibt $-1/R_i$.
][
*Typische Verwechslung:*
- Die Quellenlinie dreht sich um den unveränderten Leerlaufpunkt. – Der Leerlaufpunkt ändert sich gerade mit Ul.
- Die Lastkennlinie wird zwangsläufig linear. – Die Lastkennlinie ist eine eigene Bauteileigenschaft.
]

#aufgabe(titel: "Quellen- und Lastkennlinie im Schnittpunkt", art: "verstehen", quelle: "4.3", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 315* #linebreak()]
Warum müssen Quellen- und Lastkennlinie denselben Strom und dieselbe Spannung liefern?
][
*Antwort:*
- Beide beschreiben dieselben verbundenen Klemmen.
- Eine Seite kann keinen anderen stationären Strom oder eine andere Klemmenspannung als die andere besitzen.
- Der Schnittpunkt erfüllt beide Bedingungen zugleich.
#image("abbildungen/map-zweipol.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Warum ist der Kennlinienschnitt die Lösung und nicht ein beliebiger Punkt auf der Quellenlinie?_

*Antwort:* Ein Punkt der Quellenlinie ist zunächst nur ein vom aktiven Netz möglicher Strom-Spannungs-Zustand. Er muss gleichzeitig zum Verhalten der Last passen. Genau das erfüllt der Schnitt mit der Lastkennlinie.
]

#aufgabe(titel: "Nichtlineare Kennlinien richtig zusammenfügen", art: "verstehen", quelle: "4.3.1", herkunft: "eigen", minuten: 3,
 ergebnis: [Parallel Ströme bei gleichem U, in Reihe Spannungen bei gleichem I addieren.])[
#if not web [*Aufgabe 316* #linebreak()]
Zwei nichtlineare Widerstände besitzen bekannte I-U-Kennlinien. Beschreibe jeweils eine konstruktive Vorschrift für ihre Gesamtkennlinie in Reihen- und Parallelschaltung. Erkläre außerdem, warum die statischen Quotienten U/I einzelner Arbeitspunkte keine allgemein konstanten Ersatzwiderstände sind.
#src[V S. 95–96, Abschnitt 4.3.1.]
][
*Parallel gemeinsame Spannung wählen:* Suche auf beiden Kennlinien denselben U-Wert, lies I1 und I2 ab und bilde I=I1+I2. Wiederhole dies für mehrere Spannungen. Die Summe wird im I-U-Bild senkrecht gebildet.

][
*In Reihe gemeinsamen Strom wählen:* Suche auf beiden Kennlinien denselben I-Wert, lies U1 und U2 ab und bilde U=U1+U2. Die Summe wird waagerecht gebildet.

][
*Arbeitspunktabhängigkeit nennen:* Bei gekrümmten Kennlinien ändert sich U/I mit dem Punkt. Ein einzelner Quotient ist keine Beschreibung der gesamten Kurve. Erst die Gesamtkennlinie kann mit der Quellenlinie geschnitten werden.
][
*Ergänzung aus der früheren Quizfrage:* _Wie entsteht die Gesamtkennlinie zweier parallel geschalteter nichtlinearer Lasten?_

*Antwort:* Ströme bei derselben Spannung addieren.

*Begründung:* Die gemeinsame Spannung folgt aus der Parallelschaltung.

*Typische Verwechslung:*
- Spannungen bei demselben Strom addieren. – Das ist die Konstruktionsregel für die Reihenschaltung.
- Statische Widerstände beliebiger Arbeitspunkte addieren. – Arbeitspunkte dürfen nicht beliebig kombiniert werden und die Quotienten sind nicht konstant.
]

#aufgabe(titel: "Varistor begrenzt und kann trotzdem überhitzen", art: "verstehen", quelle: "4.3.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 317* #linebreak()]
Warum kann ein Varistor die Ausgangsspannung begrenzen und dabei trotzdem thermisch überlastet werden?
][
*Antwort:* Der stark steigende Strom erhöht den Spannungsabfall im vorgeschalteten Netz und begrenzt so die Ausgangsspannung. Gleichzeitig setzt der Varistor Leistung aus seiner Spannung und seinem Strom um. Die Begrenzungswirkung ersetzt deshalb keine Prüfung der zulässigen Leistung und Energie.
]

#aufgabe(titel: "Nichtlineare Last an linearer Ersatzquelle", art: "verstehen", quelle: "4.3.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 318* #linebreak()]
Warum lässt die Zweipoltheorie eine nichtlineare Last zu, obwohl die Ersatzquelle linear ist?
][
*Antwort:*
- Ersetzt wird nur der lineare aktive Teil vor den Klemmen.
- Die Last bleibt mit ihrer eigenen gekrümmten Kennlinie erhalten.
- Der gemeinsame Arbeitspunkt ist der Schnitt beider Beschreibungen.
#image("abbildungen/gesamt-kennlinien-addieren.svg", width: 80%)
]

#aufgabe(titel: "Varistor am Festspannungsteiler: drei Arbeitspunkte", art: "rechnen", quelle: "4.3.1", herkunft: "original", vorlage: "Vorlesungsskript S. 97–98, Aufg. 4.3.1.1", minuten: 20,
 ergebnis: [Bei 100 V etwa 30 V/77 mA; bei 200 V etwa 40 V/311 mA; mit Rp etwa 23 V.])[
#if not web [*Aufgabe 319* #linebreak()]
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

#aufgabe(titel: "Obere Lastgrenze mit UCE = 0", art: "verstehen", quelle: "4.3.2", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 320* #linebreak()]
Warum ist ein berechneter oberer Lastgrenzwert mit UCE=0 nur eine Idealisierung?
][
*Antwort:* Ein realer Transistor benötigt eine positive Mindestspannung, um den gewünschten Strom im aktiven Bereich zu halten. Bei zu großer Last bleibt dafür zu wenig Spannung. Die Grenze muss aus der Kennlinie oder einer vorgegebenen Mindestspannung bestimmt werden.
]

#aufgabe(titel: "Grenzen des Konstantstrombetriebs", art: "verstehen", quelle: "4.3.2", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 321* #linebreak()]
Warum begrenzen sowohl zu kleine als auch zu große Lastwiderstände den Konstantstrombetrieb?
][
*Antwort:*
- Eine kleine Last lässt viel Spannung am Transistor, sodass seine Verlustleistung zu groß werden kann.
- Eine große Last beansprucht fast die ganze Quellspannung, sodass dem Transistor zu wenig Spannung für den aktiven Bereich bleibt.
- Zwischen beiden Bedingungen liegt der nutzbare Bereich.
#image("abbildungen/gesamt-konstantstrom-transistor.svg", width: 80%)
]

#aufgabe(titel: "Konstantstrom-Transistor: zulässiger Lastbereich", art: "rechnen", quelle: "4.3.2", herkunft: "original", vorlage: "Vorlesungsskript S. 101–102, Beispiel 4.3.2.2", minuten: 12,
 ergebnis: [Skript-Grenznäherung 90–190 Ω; ein positives UCE,min verkleinert den oberen Wert.])[
#if not web [*Aufgabe 322* #linebreak()]
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

#aufgabe(titel: "Basis-Emitter-Diode am Spannungsteiler", art: "rechnen", quelle: "4.3.2", herkunft: "original", vorlage: "Vorlesungsskript S. 99–100, Beispiel 4.3.2.1", minuten: 15,
 ergebnis: [$U_l approx "2,31" thin "V"$, $R_i approx "1,154" thin "k"Omega$, $I_k=2 thin "mA"$; $U_q' approx "7,8" thin "V"$.])[
#if not web [*Aufgabe 323* #linebreak()]
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

#aufgabe(titel: "Zweipol-Arbeitspunkt vollständig beurteilen", art: "verstehen", quelle: "4.4", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 324* #linebreak()]
Welche Schritte gehören zur vollständigen Beurteilung eines Zweipol-Arbeitspunkts?
][
*Antwort:*
- Lege Klemmen und Last fest, bestimme die Ersatzquelle und finde den gemeinsamen Arbeitspunkt.
- Danach prüfst du Kennlinienbereich und Leistungen der betroffenen Bauteile.
- Bei ursprünglichen inneren Größen gehst du zur Originalschaltung zurück.

*Merksatz:* Klemmen → Ersatzquelle → Arbeitspunkt → Leistungsprüfung.
#image("abbildungen/map-zweipol.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Wann ist eine berechnete Schaltungslösung als zulässiger Betrieb bestätigt?_

*Antwort:* Wenn zusätzlich Modellbereich und Leistungsgrenzen eingehalten sind.

*Begründung:* Ein algebraischer oder grafischer Schnitt allein prüft noch keine Belastbarkeit.

*Typische Verwechslung:*
- Sobald irgendein Kennlinienschnitt gefunden wurde. – Der Schnitt kann außerhalb des zulässigen Bereichs liegen.
- Wenn ausschließlich der Lastwiderstand thermisch geeignet ist. – Auch Quellen, Transistoren oder andere Bauteile können überlastet werden.
][
*Ergänzung aus der früheren Quizfrage:* _Welche Reihenfolge verbindet die abschließenden Zweipolaufgaben?_

*Antwort:* Klemmen und Last festlegen, aktiven Teil ersetzen, Arbeitspunkt mit der Last bestimmen und danach Leistungen und Betriebsgrenzen prüfen. Ursprüngliche innere Leistungen werden im Originalnetz kontrolliert.
]

#aufgabe(titel: "Leistung der Stromquelle im Originalnetz", art: "verstehen", quelle: "4.4.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 325* #linebreak()]
Warum muss die ursprüngliche Leistung einer idealen Stromquelle im Originalnetz berechnet werden?
][
*Antwort:* Die Spannung direkt über der Quelle kann von Spannungsanteilen auf beiden Seiten abhängen. Der äußere Zweipolersatz erhält nur das Klemmenverhalten. Seine interne Leistung ist nicht automatisch die ursprüngliche Quellenleistung.
]

#aufgabe(titel: "Negative Leerlaufspannung", art: "verstehen", quelle: "4.4.1", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 326* #linebreak()]
Warum ist ein negatives Ul bei der Zweipolrechnung kein automatischer Fehler?
][
*Antwort:*
- Ul ist eine vorzeichenbehaftete Potenzialdifferenz.
- Ein negatives Ergebnis bedeutet eine Polung entgegen der gewählten Richtung.
- Die Quelle kann trotzdem ein passives Widerstandsnetz versorgen und besitzt hier weiterhin einen positiven Ersatzinnenwiderstand.
#image("abbildungen/gesamt-stromquelle-symbolisch.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Was bedeutet eine negative Leerlaufspannung UAB?_

*Antwort:* A liegt beim gewählten Bezug unter dem Potenzial von B.

*Begründung:* Das Vorzeichen folgt aus $U_(A B)=phi_A-phi_B$.

*Typische Verwechslung:*
- Das Netz besitzt einen negativen ohmschen Innenwiderstand. – Negative Spannung folgt nicht aus einem negativen Widerstand.
- Die Klemmen wurden physikalisch falsch gewählt und sind unzulässig. – Die Klemmenwahl ist frei; die Bezugsrichtung legt nur das Vorzeichen fest.
]

#aufgabe(titel: "Symbolische Ersatzquelle und ursprüngliche Quellenleistung", art: "rechnen", quelle: "4.4.1", herkunft: "original", vorlage: "Vorlesungsskript S. 103, Aufg. 4.4.1", minuten: 15,
 ergebnis: [$U_l=-I_q(R_4 parallel R_5)$; $R_i=R_4 parallel R_5$; $P_q approx "14,89" thin "W"$.])[
#if not web [*Aufgabe 327* #linebreak()]
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

#aufgabe(titel: "Warum die Glimmlampe erlischt", art: "verstehen", quelle: "4.4.2", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 328* #linebreak()]
Warum kann eine gezündete Glimmlampe beim Absenken der Quelle erlöschen?
][
*Antwort:* Der Arbeitspunkt wandert entlang der Kennlinie. Unterschreitet er den Haltebereich der Entladung, kann diese nicht aufrechterhalten werden. Diese Grenze ist von der Zündbedingung zu unterscheiden.
]

#aufgabe(titel: "Negativer differenzieller Widerstand", art: "verstehen", quelle: "4.4.2", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 329* #linebreak()]
Wie kann ein negativer differenzieller Widerstand mit positiver Leistungsaufnahme zusammenpassen?
][
*Antwort:*
- Die Steigung beschreibt nur die Änderung zwischen benachbarten Arbeitspunkten.
- Die momentane Leistung hängt dagegen vom Produkt aus tatsächlicher Spannung und tatsächlichem Strom ab.
- Sind beide positiv, nimmt das Bauteil Leistung auf, auch wenn die Kennlinie lokal fällt.
#image("abbildungen/gesamt-glimmlampe-kennlinie.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Eine Glimmlampe besitzt in einem Abschnitt $dif U/dif I<0$. Was folgt daraus?_

*Antwort:* Ihr differenzieller Widerstand ist dort negativ.

*Begründung:* Eine kleine Stromerhöhung geht in diesem Abschnitt mit sinkender Spannung einher.

*Typische Verwechslung:*
- Ihre aufgenommene Leistung muss negativ sein. – U und I können weiterhin positiv sein, sodass das Produkt positiv ist.
- Der statische Widerstand U/I muss ebenfalls negativ sein. – Statischer Quotient und lokale Steigung sind unterschiedliche Begriffe.
]

#aufgabe(titel: "Glimmlampe in der Brücke: Arbeitspunkt und Erlöschen", art: "rechnen", quelle: "4.4.2", herkunft: "original", vorlage: "Vorlesungsskript S. 103–105, Aufg. 4.4.2", minuten: 20,
 ergebnis: [$U_l=150 thin "V"$, $R_i="11,6" thin "k"Omega$; AP etwa 70 V/7 mA, R5 etwa 0,5 W; Absenkung rund 50 V.])[
#if not web [*Aufgabe 330* #linebreak()]
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

#aufgabe(titel: "Was bei der Quellenumwandlung gleich bleibt", art: "verstehen", quelle: "4.4.3", herkunft: "eigen", minuten: 2,
  tipp: [Die Gleichwertigkeit bezieht sich auf die äußeren Anschlüsse.],
)[
#if not web [*Aufgabe 331* #linebreak()]
Was bleibt bei einer Umwandlung zwischen realer Spannungs- und Stromquelle an denselben Klemmen gleich? Begründe deine Antwort.
][
*Antwort:* Die äußere Strom-Spannungs-Beziehung.

*Begründung:* Deshalb kann das übrige angeschlossene Netz die Ersatzbilder nicht unterscheiden.
][
*Typische Verwechslung:*
- Jeder Strom in jedem inneren Bauteil. – Die inneren Topologien und ihre Zweigströme können sich ändern.
- Nur die Leerlaufspannung, der Laststrom ist beliebig. – Die gesamte lineare Klemmenkennlinie wird erhalten.
]

#aufgabe(titel: "Nichtlineare Last nicht auf Ri setzen", art: "verstehen", quelle: "4.4.3", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 332* #linebreak()]
Warum darfst du eine gegebene nichtlineare Last nicht einfach auf Ra gleich Ri setzen?
][
*Antwort:*
- Die Kennlinie legt die möglichen Strom-Spannungs-Kombinationen der Last fest.
- Der tatsächliche Punkt muss zusätzlich zur Quellenlinie passen.
- Die Anpassungsregel gilt für eine frei variierte konstante ohmsche Last, nicht für das freie Ersetzen einer vorgegebenen gekrümmten Kennlinie.
#image("abbildungen/gesamt-nichtlinear-lastkurve.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Wie unterscheidet sich die Wahl einer ohmschen Last für Maximalleistung von der Auswertung einer gegebenen nichtlinearen Last?_

*Antwort:* Bei einer frei wählbaren ohmschen Last kann $R_a=R_i$ gesetzt werden. Bei der vorgegebenen nichtlinearen Last wird ihre Kennlinie mit der Quellenlinie geschnitten. Ein einzelner statischer Quotient ist keine frei wählbare konstante Last.
]

#aufgabe(titel: "Gemischte Quellen und eine nichtlineare Last", art: "rechnen", quelle: "4.4.3", herkunft: "original", vorlage: "Vorlesungsskript S. 106, Aufg. 4.4.3", minuten: 20,
 ergebnis: [$U_l="7,5" thin "V"$, $R_i=750 thin Omega$; Anpassung 18,75 mW, nichtlineare Last etwa 12 mW.])[
#if not web [*Aufgabe 333* #linebreak()]
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

#aufgabe(titel: "Parallelwiderstände im LED-Leerlauf", art: "verstehen", quelle: "4.4.4", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 334* #linebreak()]
Warum müssen vorhandene Parallelwiderstände bei der Leerlaufrechnung ohne LED angeschlossen bleiben?
][
*Antwort:* Leerlauf betrifft nur den abgetrennten LED-Zweig. Die übrigen Widerstände gehören zum aktiven Netz und bestimmen dessen Leerlaufspannung sowie Innenwiderstand. Sie mitzuentfernen würde eine andere Ersatzquelle ergeben.
]

#aufgabe(titel: "Leerlaufspannung ist keine LED-Spannung", art: "verstehen", quelle: "4.4.4", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 335* #linebreak()]
Warum ist die Leerlaufspannung eines LED-Speisenetzes keine feste LED-Spannung?
][
*Antwort:*
- Leerlauf heißt, dass die LED noch keinen Laststrom entnimmt.
- Beim Anschließen verschiebt der Laststrom die Klemmenspannung entlang der Quellenlinie.
- Der Schnitt mit der LED-Kennlinie bestimmt erst den Betriebspunkt.
#image("abbildungen/gesamt-led-rot-netz.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Ein Netz hat ohne LED 5 V an den Klemmen. Welche Aussage gilt nach Anschluss der LED?_

*Antwort:* Ihre Spannung und ihr Strom ergeben sich aus Kennlinie und Innenwiderstand des Netzes.

*Begründung:* Die Last verändert die Klemmenspannung entsprechend der Quellenkennlinie.

*Typische Verwechslung:*
- An der LED bleiben unabhängig vom Strom immer genau 5 V. – Das würde einen endlichen Innenwiderstand ignorieren.
- Die LED führt im Leerlauf denselben Strom wie angeschlossen. – Ohne die LED ist ihr Zweig offen; der äußere Laststrom ist null.
]

#aufgabe(titel: "Rote LED an einem Netz mit zwei Spannungsquellen", art: "rechnen", quelle: "4.4.4", herkunft: "original", vorlage: "Vorlesungsskript S. 107, Aufg. 4.4.4", minuten: 15,
 ergebnis: [$R_i=200 thin Omega$, $I_"LED" approx 15 thin "mA"$, $U_"q1"=12 thin "V"$.])[
#if not web [*Aufgabe 336* #linebreak()]
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

#aufgabe(titel: "Transistor- und Kollektorleistung getrennt", art: "verstehen", quelle: "4.4.5", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 337* #linebreak()]
Warum werden Transistor- und Kollektorwiderstandsleistung getrennt berechnet?
][
*Antwort:* Der Transistor setzt $U_(C E)I_C$ um, der Widerstand $I_C^2R_C$. Beide sehen unterschiedliche Spannungsabfälle und haben eigene Belastungsgrenzen. Zusammen ergeben sie im verwendeten Modell die von der Kollektorquelle abgegebene Leistung.
]

#aufgabe(titel: "Größte zulässige Quellspannung im Kennlinienfeld", art: "verstehen", quelle: "4.4.5", herkunft: "eigen", minuten: 2,
)[
#if not web [*Aufgabe 338* #linebreak()]
Wie findest du die maximal zulässige Quellspannung im Ausgangskennlinienfeld?
][
*Antwort:*
- Wähle zuerst die Kurve des vorgegebenen Basisstroms.
- Bestimme ihren Schnitt mit der Verlustleistungshyperbel.
- Durch diesen Grenzpunkt verläuft die passende Lastgerade
- aus Transistorspannung plus Widerstandsabfall folgt die Quellspannung.
#image("abbildungen/gesamt-transistor-rc-feld.svg", width: 80%)
][
*Ergänzung aus der früheren Quizfrage:* _Was muss beim Grenzarbeitspunkt eines Transistors mit festem Basisstrom zugleich erfüllt sein?_

*Antwort:* Ausgangskennlinie, Quellenlinie und zulässige Verlustleistung.

*Begründung:* Der Punkt muss zum Bauteil, zum angeschlossenen Netz und zur thermischen Grenze passen.

*Typische Verwechslung:*
- Nur die Gleichung für die Widerstandsleistung. – Die Transistorleistung muss unabhängig davon geprüft werden.
- Ein beliebiger Punkt der höchsten Basisstromkennlinie. – Es ist die Kennlinie des tatsächlich vorgegebenen Basisstroms zu verwenden.
]

#aufgabe(titel: "Transistor: größte Quellspannung bei 0,4 Watt Verlust", art: "rechnen", quelle: "4.4.5", herkunft: "original", vorlage: "Vorlesungsskript S. 108, Aufg. 4.4.5", minuten: 15,
 ergebnis: [AP ungefähr 40 mA/10 V; $U_"q,max" approx 18 thin "V"$; $P_(R C) approx "0,32" thin "W"$.])[
#if not web [*Aufgabe 339* #linebreak()]
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
