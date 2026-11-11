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


#kapitel("Kapitel 1 · Grundlagen und Zeichnungserstellung")

#aufgabe(titel: "Wozu eine Technische Zeichnung dient", art: "verstehen", quelle: "1.1", herkunft: "eigen")[
#if not web [*Aufgabe 1* #linebreak()]
Wozu dient eine Technische Zeichnung? Nenne drei Abteilungen, die mit ihr arbeiten.
][
*Antwort:* Sie ist der eindeutige Informationsträger zwischen allen, die an einem Produkt arbeiten, auch extern (S. 1). Z. B. Fertigung, Qualitätssicherung, Einkauf (auch Montage, Arbeitsvorbereitung, Zulieferer).
][
*Kurz gefasst (aus der Karteikarte):*
- Sie ist der eindeutige Informationsträger zwischen allen, die an einem Produkt arbeiten: Konstruktion, Fertigung, Qualitätssicherung, Einkauf, Montage und externe Zulieferer.
- Sie legt Form, Maße, Toleranzen, Oberflächen und Werkstoff so fest, dass jemand anders das Teil ohne Rückfrage herstellen kann.

*Merksatz:* Die Zeichnung muss das Teil ohne Rückfrage beschreiben.
#bild("b-projektionen", [Bild 1-1: Zentral-, Parallel- und orthogonale Projektion. B, S. 2 (PDF-S. 13).], height: 50mm)
][
*Bild:* Eine Sprache: Der Konstrukteur schreibt, alle anderen lesen. Damit alle dasselbe verstehen, ist die Grammatik genormt.
#src[L-alt A1, Frage 1; nach B S. 1–16]
]

#aufgabe(titel: "Parallelprojektion statt Perspektive", art: "verstehen", quelle: "1.1", herkunft: "eigen")[
#if not web [*Aufgabe 2* #linebreak()]
Warum verwendet man für Technische Zeichnungen die senkrechte Parallelprojektion und keine Perspektive?
][
*Antwort:* Nur bei ihr erscheinen Flächen parallel zur Bildebene in wahrer Größe, also maßstäblich. Perspektive verkürzt ferne Kanten, man könnte keine Maße abgreifen (S. 2).
][
*Kurz gefasst (aus dem Quiz):*
- Weil Flächen parallel zur Bildebene unverzerrt in wahrer Größe erscheinen. Die Strahlen laufen parallel und senkrecht zur Bildebene. Deshalb besteht eine Zeichnung aus mehreren solchen Ansichten.
][
*Typische Verwechslungen:*
- „Weil sie wie ein Foto wirkt und am anschaulichsten ist.“: Das trifft auf die Perspektive (Zentralprojektion) zu. Dort werden ferne Kanten aber kleiner, man kann nicht messen.
- „Weil darin auch schräge Flächen immer in wahrer Größe erscheinen.“: Geneigte Flächen werden auch hier verkürzt. Dafür gibt es Zusatzansichten senkrecht auf die schräge Fläche.
- „Weil sie nur eine einzige Ansicht braucht.“: Meist braucht man mehrere Ansichten, bis zu sechs.
][
*Kurz gefasst (aus der Karteikarte):*
- Nur bei ihr erscheinen Flächen parallel zur Bildebene in wahrer Größe.
- In der Perspektive werden ferne Kanten kleiner, und man könnte nichts vergleichen.
- Geneigte Flächen sind auch in der orthogonalen Ansicht verkürzt, deshalb braucht man oft mehrere Ansichten.

*Merksatz:* Wahre Größe nur bei Flächen parallel zur Bildebene.
#bild("b-projektionen", [Bild 1-1: Zentral-, Parallel- und orthogonale Projektion. B, S. 2 (PDF-S. 13).], height: 50mm)
#src[L-alt A1, Frage 2; nach B S. 1–16]
]

#aufgabe(titel: "Wahre Größe in orthogonalen Ansichten", art: "verstehen", quelle: "1.1", herkunft: "eigen")[
#if not web [*Aufgabe 3* #linebreak()]
Erkläre, welche Flächen bei orthogonalen Ansichten in wahrer Größe erscheinen und warum eine einzige Ansicht oft nicht genügt.
][
*Antwort:* Bei orthogonaler Projektion erscheinen Flächen parallel zur Bildebene in wahrer Größe; geneigte Flächen sind verkürzt. Weitere Ansichten ergänzen die fehlenden Raumrichtungen.

#src[L-alt A1, offene Überarbeitung Frage 15; B S. 1–16]
]

#aufgabe(titel: "DIN, EN, ISO und die Frage nach dem Gesetz", art: "verstehen", quelle: "1.2", herkunft: "eigen")[
#if not web [*Aufgabe 4* #linebreak()]
Was bedeuten DIN, DIN EN, DIN ISO und DIN EN ISO? Sind Normen Gesetze?
][
*Antwort:* DIN = deutsche Norm, DIN EN = europäische Norm (CEN) als DIN übernommen, DIN ISO = internationale Norm (ISO, Genf) als DIN übernommen, DIN EN ISO = international, europäisch und deutsch zugleich. Normen sind Empfehlungen mit technisch-normativer Wirkung, aus sich heraus nicht rechtsverbindlich; wer sie anwendet, verhält sich ordnungsgemäß (S. 3).
][
*Kurz gefasst (aus der Karteikarte):*
- *DIN:* rein deutsche Norm
- *DIN EN:* europäische Norm, als DIN übernommen
- *DIN ISO:* internationale Norm, als DIN übernommen
- *DIN EN ISO:* international, europäisch und deutsch zugleich
- Normen sind Empfehlungen und aus sich heraus nicht rechtsverbindlich.
- Wer sie anwendet, verhält sich aber ordnungsgemäß.
- Gleiche Nummer heißt nicht gleicher Inhalt, deshalb nennt man immer das vollständige Präfix.
#src[L-alt A1, Frage 3; nach B S. 1–16]
]

#aufgabe(titel: "Schriftfeld, Blattlage und Feldeinteilung", art: "verstehen", quelle: "1.3", herkunft: "variante", vorlage: "Buch Kap. 2, Aufg. 2.1")[
#if not web [*Aufgabe 5* #linebreak()]
Wo steht das Schriftfeld, welche Formate sind hoch, welche quer, und wozu dient die Feldeinteilung am Blattrand? (#strong[B Übung 2.1])
][
*Antwort:* Schriftfeld immer unten rechts. A4 nur hoch, alle anderen Formate nur quer. Die Feldeinteilung (Spalten Buchstaben, Zeilen Zahlen) erlaubt es, eine Stelle anzusprechen, z. B. „Feld B6“ (S. 6–7).
][
*Kurz gefasst (aus dem Quiz):*
- Unten rechts, weil es nach dem Falten auf A4 sichtbar bleibt. Fest vorgeschrieben ist nur die Breite von 180 mm, damit es auf A4 passt.
][
*Typische Verwechslungen:*
- „Oben links, weil man dort zu lesen beginnt“: Nach dem Falten wäre es dann verdeckt.
- „Unten links neben dem Heftrand“: Am Heftrand wird gelocht, dort steht das Schriftfeld nicht.
- „Beliebig, Hauptsache auf dem Blatt“: Die Lage ist genormt: immer unten rechts.
][
*Kurz gefasst (aus der Karteikarte):*
- Das Schriftfeld steht immer unten rechts, damit es im gefalteten Zustand sichtbar ist.
- A4 ist hoch, alle anderen Formate sind quer.
- Die Feldeinteilung (Spalten mit Buchstaben, Zeilen mit Zahlen) erlaubt es, eine Stelle anzusprechen, zum Beispiel »die Bohrung in Feld B6«.
#src[L-alt A1, Frage 5; nach B S. 1–16]
]

#aufgabe(titel: "Seitenverhältnis der A-Formate", art: "verstehen", quelle: "1.3", herkunft: "eigen")[
#if not web [*Aufgabe 6* #linebreak()]
Welches Seitenverhältnis haben die A-Formate, und warum gerade dieses?
][
*Antwort:* 1 : √2. Nur bei diesem Verhältnis hat die Hälfte eines Blattes wieder dieselbe Form. So kann man Zeichnungen ohne Verzerrung vergrößern oder verkleinern (S. 6).
][
*Kurz gefasst (aus der Karteikarte):*
- Nur bei diesem Verhältnis hat die Hälfte eines Blatts wieder dieselbe Form.
- So kann man Zeichnungen ohne Verzerrung vergrößern und verkleinern.
- A0 hat 1 m², und jede Stufe halbiert die Fläche.

*Merksatz:* A-Formate halbieren die Fläche und behalten die Form.
#bild("alt-a1-1", [A0 halbiert ergibt A1, A1 halbiert A2 usw. Quelle der Skizze: L-alt A1; eigene Darstellung.], height: 50mm)
#src[L-alt A1, Frage 4; nach B S. 1–16]
]

#aufgabe(titel: "A4-Blätter in einem A0-Blatt", art: "verstehen", quelle: "1.3", herkunft: "eigen")[
#if not web [*Aufgabe 7* #linebreak()]
Wie viele A4-Blätter passen flächenmäßig in ein A0-Blatt? Begründe deine Antwort.
][
*Antwort:*
- 16. Vier Halbierungen: $2^4 = 16$. A0 hat 1 m², A4 also $1\/16$ m².
][
*Typische Verwechslungen:*
- „4“: Von A0 nach A4 sind es vier Halbierungen, nicht vier Blätter.
- „8“: Das wäre A3, drei Halbierungen.
- „32“: Das wäre A5.
]

#aufgabe(titel: "Seitenlängen von A0, A1 und A4", art: "rechnen", quelle: "1.3", herkunft: "eigen",
  ergebnis: [A0 = 841 × 1189 mm, A1 = 594 × 841 mm, A4 = 210 × 297 mm],
  tipp: [Zwei Gleichungen: Fläche $x y = 1 thin "m"^2$ und Verhältnis $y = sqrt(2) x$. Jede nächste Stufe halbiert die lange Seite.],
)[
#if not web [*Aufgabe 8* #linebreak()]
*Gegeben und Annahmen*

Papierformat A0 mit Fläche 1 m² und Seitenverhältnis $1:sqrt(2)$; jedes folgende A-Format entsteht durch Halbieren der längeren Seite.

*Gesucht*

#enum(numbering: "a)",
[Berechne die Seitenlängen von A0 in mm.],
[Leite daraus A1 und A4 her.],
)
][
*Bild:* Faltet man ein A-Blatt in der Mitte, entsteht das nächste Format mit genau demselben Seitenverhältnis. Das klappt nur mit $1 : sqrt(2)$. A0 ist der Startpunkt mit genau 1 m².
][
*Gleichungen aufstellen:* $x dot y = 1 thin "m"^2$ und $y = sqrt(2) dot x$. Einsetzen gibt $sqrt(2) dot x^2 = 1 thin "m"^2$.
][
*A0 ausrechnen:* $x = sqrt(1\/sqrt(2)) thin "m" approx "0,8409" thin "m" approx 841 thin "mm"$ und $y = sqrt(2) dot 841 thin "mm" approx 1189 thin "mm"$. A0 ist also 841 × 1189 mm.
][
*Halbieren:* A1 entsteht, indem die lange Seite halbiert wird: $1189\/2 approx 594 thin "mm"$, also 594 × 841 mm. Dreimal weiter halbiert (A2, A3, A4) ergibt 210 × 297 mm.
][
*Prüfen:* $297\/210 approx "1,414" approx sqrt(2)$, das Verhältnis bleibt. Und $"0,210" dot "0,297" approx "0,0624" thin "m"^2 approx 1\/16 thin "m"^2$, denn A4 ist viermal halbiert.
#src[L-alt A1, Frage 13; nach B S. 1–16]
]

#aufgabe(titel: "A4-Blätter auf A1 und Fläche von A3", art: "rechnen", quelle: "1.3", herkunft: "eigen",
  ergebnis: [8 A4-Blätter; A3 hat 0,125 m²],
  tipp: [Zähle die Halbierungsschritte zwischen den Formaten. Jeder Schritt halbiert die Fläche.],
)[
#if not web [*Aufgabe 9* #linebreak()]
*Gegeben und Annahmen*

A0 hat 1 m²; von A0 zum jeweils nächsten A-Format halbiert sich die Fläche.

*Gesucht*

#enum(numbering: "a)",
[Wie viele A4-Blätter passen flächengleich auf ein A1-Blatt?],
[Wie groß ist die Fläche eines A3-Blatts in m²?],
)
][
*Bild:* Jede Stufe im A-System ist ein in der Mitte gefaltetes Blatt der Stufe davor. Von A1 nach A4 faltest du also dreimal.
][
*A4 auf A1:* A1 → A2 → A3 → A4 sind drei Halbierungen. Das ergibt $2^3 = 8$ Blätter.
][
*Fläche von A3:* A0 hat 1 m², A3 liegt drei Stufen darunter: $1 thin "m"^2 \/ 2^3 = "0,125" thin "m"^2$.
][
*Prüfen mit den Maßen:* A3 ist 297 × 420 mm, also $"0,297" dot "0,420" approx "0,1247" thin "m"^2$. Die kleine Abweichung kommt vom Runden der Normmaße.
#src[L-alt A1, Frage 14; nach B S. 1–16]
]

#aufgabe(titel: "Fläche und Seitenlängen von A0 herleiten", art: "rechnen", quelle: "1.3", herkunft: "eigen",
  ergebnis: [1 m², ungefähr 841 × 1189 mm],
  tipp: [A0 ist über die Fläche definiert. Das Seitenverhältnis $1 : sqrt(2)$ legt dann beide Seiten fest.],
)[
#if not web [*Aufgabe 10* #linebreak()]
*Gegeben und Annahmen*

Für die A-Reihe gilt $x:y=1:sqrt(2)$, die Fläche von A0 ist definitionsgemäß 1 m².

*Gesucht*

#enum(numbering: "a)",
[Leite aus Fläche und Seitenverhältnis die ungefähren Seitenlängen von A0 her und prüfe die Fläche.],
)
][
*Festlegung:* A0 ist so definiert, dass es genau 1 m² Fläche hat. Das ist die Ausgangsgröße des ganzen A-Systems.
][
*Seitenverhältnis:* Damit das halbierte Blatt dieselbe Form behält, muss gelten $y\/x = sqrt(2)$.
][
*Seiten berechnen:* Aus $x dot sqrt(2) x = 1 thin "m"^2$ folgt $x approx 841 thin "mm"$ und $y approx 1189 thin "mm"$.
][
*Prüfen:* $"0,841" dot "1,189" approx "1,000" thin "m"^2$.
#src[L-alt A1, offene Überarbeitung Frage 18; B S. 1–16]
]

#aufgabe(titel: "Einzelteilzeichnung und Gesamtzeichnung", art: "verstehen", quelle: "1.4", herkunft: "original", vorlage: "Buch Kap. 2, Aufg. 2.6 und 2.7")[
#if not web [*Aufgabe 11* #linebreak()]
#enum(numbering: "a)",
[Welche Angaben müssen in einer Einzelteilzeichnung enthalten sein?],
[Welche Angaben müssen in einer Gesamtzeichnung enthalten sein?],
)
][
*Antwort:* Einzelteil: vollständige Bemaßung, Toleranzen, Oberflächen, Werkstoff, Maßstab, Schriftfeld. Gesamtzeichnung: zusammengebauter Zustand, Positionsnummern, Haupt- und Anschlussmaße, Stückliste (S. 9–11).

#src[L-alt A1, Frage 8; nach B S. 1–16]
]

#aufgabe(titel: "Bemaßung in der Gesamtzeichnung", art: "verstehen", quelle: "1.4", herkunft: "original", vorlage: "Buch Kap. 2, Aufg. 2.12")[
#if not web [*Aufgabe 12* #linebreak()]
Was wird in einer Gesamtzeichnung bemaßt? Wozu dient die Bemaßung in einer Gesamtzeichnung?
][
*Antwort:* Nur Hauptmaße (welchen Platz das Erzeugnis insgesamt braucht) und Anschlussmaße (wie Anschluss- und Befestigungsteile bemessen sind). Sie dienen dem Einbau und der weiteren Montage, nicht der Fertigung der Einzelteile (S. 10–11).
][
*Kurz gefasst (aus der Karteikarte):*
- Sie dient dem Einbau und der Montage, nicht der Fertigung.
- Hauptmaße sagen, wie viel Platz das Erzeugnis braucht.
- Anschlussmaße sagen, wie es an die Umgebung angeschlossen wird.
- Alle anderen Maße stehen in den Einzelteilzeichnungen.
#src[L-alt A1, Frage 9; nach B S. 1–16]
]

#aufgabe(titel: "Vier Zeichnungstypen und ihre Empfänger", art: "verstehen", quelle: "1.4", herkunft: "original", vorlage: "Altklausur WS 20/21, Aufg. 1a", minuten: 4)[
#if not web [*Aufgabe 13* #linebreak()]
Nennen Sie 4 Zeichnungstypen. (4 Punkte)

_Zusatz zum Verständnis (nicht Teil der Klausuraufgabe):_ Welcher Empfänger gewinnt aus jedem Typ welche Information?
][
*Klausurantwort (je Typ 1 Punkt):* Einzelteilzeichnung, Gesamtzeichnung (Zusammenbauzeichnung), Fertigungszeichnung, Sammelzeichnung. Weitere zulässige Nennungen: Gruppenzeichnung (Baugruppe), Skizze.
][
*Zusatz – wer was daraus liest:* Einzelteilzeichnung: Die Fertigung erhält Form, Maße und Anforderungen eines Teils. Gesamt-/Zusammenbauzeichnung: Die Montage erkennt Zuordnung und Zusammenwirken der Teile (mit Positionsnummern und Stückliste). Fertigungszeichnung: enthält alle für den betreffenden Fertigungsschritt nötigen Angaben. Sammelzeichnung: fasst mehrere zusammengehörige Einzelteile auf einem Blatt zusammen.

#src[AK 1a, PDF-S. 2; B S. 7–12]
]

#aufgabe(titel: "Vier Stufen der Erzeugnisgliederung", art: "verstehen", quelle: "1.4", herkunft: "eigen")[
#if not web [*Aufgabe 14* #linebreak()]
Nenne die vier Stufen der Erzeugnisgliederung.
][
*Antwort:* Anlage/System → Gerät/Maschine/Apparat → Baugruppe → Einzelteile (S. 8, Bild 2-3).

#src[L-alt A1, Frage 6; nach B S. 1–16]
]

#aufgabe(titel: "Teil und Einzelteil", art: "verstehen", quelle: "1.4", herkunft: "eigen")[
#if not web [*Aufgabe 15* #linebreak()]
Was ist der Unterschied zwischen einem Teil und einem Einzelteil? Nenne ein Beispiel.
][
*Antwort:* Teil: wird nicht weiter zerlegt, z. B. gekauftes Kugellager. Einzelteil: nicht zerstörungsfrei zerlegbar, z. B. Innenring des Lagers (S. 9).
][
*Kurz gefasst (aus der Karteikarte):*
- Ein Teil muss der Anwender nicht weiter aufgliedern, zum Beispiel ein gekauftes Kugellager.
- Ein Einzelteil kann man nicht zerstörungsfrei zerlegen, zum Beispiel den Innenring dieses Lagers.
#src[L-alt A1, Frage 7; nach B S. 1–16]
]

#aufgabe(titel: "Angaben in Gesamt- und Einzelteilzeichnung", art: "verstehen", quelle: "1.4", herkunft: "eigen")[
#if not web [*Aufgabe 16* #linebreak()]
Welche Angaben braucht eine Gesamtzeichnung, und welche gehören in die Einzelteilzeichnung?
][
*Antwort:* Positionsnummern. Haupt- und Anschlussmaße. eine Stückliste oder einen Verweis darauf.
][
*Kurz gefasst (aus dem Quiz):*
- Die Zusammenbauzeichnung zeigt, wie die Teile zusammengehören, mit Positionsnummern und nur Haupt- und Anschlussmaßen. Dazu gehört eine Stückliste. Oft genügt eine Ansicht in Gebrauchslage.
- Die Einzelteilzeichnung zeigt ein Teil mit vollständiger Bemaßung, Toleranzen, Oberflächen und Werkstoff. Sie beschreibt, wie das Teil hergestellt wird.
][
*Typische Verwechslungen:*
- „Die Zusammenbauzeichnung enthält alle Maße aller Teile.“: Dann wäre sie unlesbar. Die vollständigen Maße stehen in den Einzelteilzeichnungen.
- „Die Einzelteilzeichnung enthält immer eine Stückliste.“: Stücklisten gehören zur Zusammenbau- bzw. Sammelzeichnung.
][
*Kurz gefasst (aus der Karteikarte):*
- Die Einzelteilzeichnung zeigt, wie ein Teil hergestellt wird: vollständige Bemaßung, Toleranzen, Oberflächen und Werkstoff.
- Die Gesamtzeichnung zeigt, wie die Teile zusammengehören: Positionsnummern, nur Haupt- und Anschlussmaße und die Stückliste.

*Merksatz:* Einzelteil: herstellen. Gesamtzeichnung: zusammenbauen.
#src[L-alt A1, offene Überarbeitung Frage 16; B S. 1–16]
]

#aufgabe(titel: "Regeln für Positionsnummern", art: "verstehen", quelle: "1.5", herkunft: "eigen")[
#if not web [*Aufgabe 17* #linebreak()]
Nenne vier Regeln für Positionsnummern.
][
*Antwort:* Mit 1 beginnend in Montagereihenfolge oder im Uhrzeigersinn; dünne Bezugslinie mit Punkt im Teil oder Pfeil an der Kontur, nicht parallel zu anderen Linien; doppelte Maßzahlhöhe, mind. 5 mm; identische Teile nur eine Nummer, nur einmal eingetragen (S. 11–12).
][
*Kurz gefasst (aus der Karteikarte):*
- In Montagereihenfolge oder im Uhrzeigersinn, sauber in Reihen oder Spalten.
- Dünne Bezugslinie mit Punkt im Teil oder Pfeil an der Kontur, nicht parallel zu anderen Linien.
- Doppelte Maßzahlhöhe, mindestens 5 mm.
- Identische Teile bekommen nur eine Nummer, die nur einmal erscheint.
- Die Menge steht in der Stückliste.
#src[L-alt A1, Frage 10; nach B S. 1–16]
]

#aufgabe(titel: "Warum die Stückliste so wichtig ist", art: "verstehen", quelle: "1.5", herkunft: "eigen")[
#if not web [*Aufgabe 18* #linebreak()]
Warum gilt die Stückliste als eines der wichtigsten Konstruktionsergebnisse?
][
*Antwort:* Sie ist Grundlage für die Fertigungsvorbereitung und für Kalkulation, Bestellwesen und Lager: Ohne sie weiß niemand, welche Teile in welcher Menge bestellt oder gefertigt werden (S. 12).
][
*Kurz gefasst (aus der Karteikarte):*
- Sie ist die Grundlage für Fertigungsvorbereitung, Kalkulation, Bestellwesen und Lager.
- Ohne sie weiß niemand, welche Teile in welcher Menge gefertigt oder bestellt werden müssen.

*Merksatz:* Die Stückliste sagt: welches Teil, wie oft.
#src[L-alt A1, Frage 11; nach B S. 1–16]
]

#aufgabe(titel: "Gleiche Schrauben in Zeichnung und Stückliste", art: "verstehen", quelle: "1.5", herkunft: "eigen")[
#if not web [*Aufgabe 19* #linebreak()]
Wie werden fünf gleiche Schrauben einer Baugruppe in Zeichnung und Stückliste identifiziert?
][
*Antwort:* bekommen eine Positionsnummer, Menge 5 in der Stückliste.
][
*Kurz gefasst (aus dem Quiz):*
- Eine, die Menge 4 steht in der Stückliste. Die Nummer erscheint nur einmal in der Zeichnung, die Menge regelt die Stückliste.
][
*Typische Verwechslungen:*
- „Vier, eine pro Schraube“: Identische Teile erhalten nur eine Nummer.
- „Keine, Normteile werden nicht nummeriert“: Auch Normteile stehen in der Stückliste und haben eine Positionsnummer.
- „Zwei, eine für jede Seite“: Dafür gibt es keine Regel.
#src[L-alt A1, offene Überarbeitung Frage 17; B S. 1–16]
]

#aufgabe(titel: "Skizzenarten und Mittellinien", art: "verstehen", quelle: "1.6", herkunft: "variante", vorlage: "Buch Kap. 2, Aufg. 2.17 und 2.19")[
#if not web [*Aufgabe 20* #linebreak()]
Welche zwei Arten von Skizzen gibt es? Warum beginnt man mit den Mittellinien? (#strong[B Übung 2.17/2.19])
][
*Antwort:* Skizze zum Konstruieren (Ideen, Funktion) und Skizze als Vorlage für Zeichnung/Fertigung. Mittellinien legen Lage und Symmetrie fest; alle weiteren Linien hängen daran (S. 13–14).
][
*Kurz gefasst (aus der Karteikarte):*
- Sie legen Symmetrie und Lage fest, und alle Ansichten richten sich daran aus.
- Danach kommen dünne Hilfslinien, erst zum Schluss werden die sichtbaren Kanten breit nachgezogen.

*Merksatz:* Erst die Mitte, dann die Kontur.
#src[L-alt A1, Frage 12; nach B S. 1–16]
]


#kapitel("Kapitel 2 · CAD und digitale Produktmodelle")

#aufgabe(titel: "Vorhandene Bauteile ins CAD bringen", art: "verstehen", quelle: "2.1", herkunft: "original", vorlage: "Buch Kap. 3, Aufg. 3.5")[
#if not web [*Aufgabe 21* #linebreak()]
Welche Möglichkeiten bestehen, bereits vorhandene Bauteile in ein CAD-System zu übertragen?
][
*Antwort:* Abzeichnen und neu modellieren (bei einfachen Teilen meist am besten), Scannen von Zeichnungen, 3D-Scanner (Laser, Punktewolke), Photogrammetrie (bei komplexer, empfindlicher Geometrie) (S. 19–21).

#src[L-alt A2, Frage 6; nach B S. 17–38]
]

#aufgabe(titel: "Vom CAD-Modell zum 3D-Druck", art: "verstehen", quelle: "2.1", herkunft: "eigen")[
#if not web [*Aufgabe 22* #linebreak()]
Beschreibe den Ablauf vom CAD-Modell zum 3D-gedruckten Teil.
][
*Antwort:* CAD-Modell → STL-Export → Zerlegen in Schichten (Slicen) mit Druckvorschau → schichtweiser Aufbau, ggf. mit Stützstrukturen (S. 22, Bild 3-6).

#src[L-alt A2, Frage 11; nach B S. 17–38]
]

#aufgabe(titel: "Arten von CAD-Systemen", art: "verstehen", quelle: "2.2", herkunft: "variante", vorlage: "Buch Kap. 3, Aufg. 3.2")[
#if not web [*Aufgabe 23* #linebreak()]
Welche grundsätzlichen Arten von CAD-Systemen gibt es, und wo werden linienbasierte Systeme noch eingesetzt? (#strong[B Übung 3.2])
][
*Antwort:* Linien-, flächen- und volumenbasierte Systeme. Linienbasierte vor allem in der Elektrotechnik (Schaltpläne) (S. 25).

#src[L-alt A2, Frage 2; nach B S. 17–38]
]

#aufgabe(titel: "CSG-Baum eines Flansches", art: "verstehen", quelle: "2.3", herkunft: "variante", vorlage: "Buch Kap. 3, Aufg. 3.7")[
#if not web [*Aufgabe 24* #linebreak()]
Ein Flansch besteht aus einem Zylinder Ø120 × 15, einem aufgesetzten Zylinder Ø60 × 30, einer durchgehenden Bohrung Ø40 und sechs Bohrungen Ø11 auf dem Lochkreis. Schreibe die Entstehungsgeschichte als CSG-Folge mit Booleschen Operationen auf. (vgl. Übung 3.6/3.7)
][
*Modell / Annahmen:* Idealisiertes CAD-Volumenmodell; Körperlage und Abmessungen sind wie in der Aufgabe angegeben.

K1 = Zylinder Ø120 × 15
K2 = K1 ∪ Zylinder Ø60 × 30        (Nabe aufsetzen)
K3 = K2 \\ Zylinder Ø40 × 45        (Mittelbohrung)
K4 = K3 \\ 6 × Zylinder Ø11 × 15    (Lochkreisbohrungen)

*Prüfung:* Die Boolesche Operation muss das beabsichtigte Material liefern.

#src[L-alt A2, Frage 13; nach B S. 17–38]
]

#aufgabe(titel: "B-Rep und CSG", art: "verstehen", quelle: "2.3", herkunft: "eigen")[
#if not web [*Aufgabe 25* #linebreak()]
Erkläre den Unterschied zwischen B-Rep und CSG.
][
*Antwort:* B-Rep: Volumen über Begrenzungsflächen plus Materialvektoren, Geometrie liegt explizit vor. CSG: Volumen als Folge Boolescher Operationen auf Grundkörpern (Baum), Flächen werden erst beim Evaluieren berechnet (S. 26–27).
][
*Kurz gefasst (aus dem Quiz):*
- B-Rep speichert die Begrenzungsflächen mit Materialseite, CSG die Entstehungsgeschichte aus Grundkörpern und Booleschen Operationen. Merkhilfe: B-Rep speichert, was da ist; CSG speichert, wie es entstanden ist.
][
*Typische Verwechslungen:*
- „B-Rep ist ein Flächenmodell ohne Volumen, CSG ein Volumenmodell.“: Beide sind Volumenmodelle. B-Rep beschreibt das Volumen über seine Hülle plus Materialvektoren.
- „CSG speichert die Geometrie immer explizit, B-Rep berechnet sie erst beim Evaluieren.“: Genau umgekehrt.
- „B-Rep und CSG sind zwei Namen für dasselbe Verfahren.“: Es sind zwei unterschiedliche Darstellungsarten.
][
*Kurz gefasst (aus der Karteikarte):*
- B-Rep beschreibt den Körper über seine Begrenzungsflächen, die Geometrie liegt also explizit vor.
- CSG speichert die Entstehungsgeschichte als Baum aus Grundkörpern und Booleschen Operationen (vereinigen, abziehen, schneiden).
- Die Flächen werden erst beim Auswerten berechnet.

*Merksatz:* B-Rep beschreibt den Rand; CSG beschreibt den Aufbau.
#bild("b-csg", [Bild 3-9: Boolesche Operationen an Körpern. B, S. 26 (PDF-S. 37).], height: 50mm)
][
*Bild:* B-Rep ist das Foto der fertigen Torte, CSG ist das Rezept.
#src[L-alt A2, Frage 3; nach B S. 17–38]
]

#aufgabe(titel: "Würfel und Kugel verknüpfen", art: "verstehen", quelle: "2.3", herkunft: "eigen")[
#if not web [*Aufgabe 26* #linebreak()]
Was ergibt der Durchschnitt (∩) aus einem Würfel 40 × 40 × 40 und einer Kugel Ø50 mit gleichem Mittelpunkt? Was ergibt die Differenz Würfel \\ Kugel?
][
*Modell / Annahmen:* Idealisiertes CAD-Volumenmodell; Körperlage und Abmessungen sind wie in der Aufgabe angegeben.

Durchschnitt: Die Kugel (Radius 25) ragt über die Würfelflächen (Abstand 20 vom Mittelpunkt) hinaus. Übrig bleibt eine Kugel, die an den sechs Würfelseiten eben abgeflacht ist (sechs kreisförmige Flächen). Differenz Würfel \\ Kugel: Ein hohler Würfel, dessen Kanten und Ecken stehen bleiben (Kantenmitte 20·√2 ≈ 28,3 \> 25); jede Würfelseite bekommt ein kreisrundes Loch mit Radius √(25² − 20²) = 15.

*Prüfung:* Die Boolesche Operation muss das beabsichtigte Material liefern.

#src[L-alt A2, Frage 14; nach B S. 17–38]
]

#aufgabe(titel: "Wie CSG ein Bauteil speichert", art: "verstehen", quelle: "2.3", herkunft: "eigen")[
#if not web [*Aufgabe 27* #linebreak()]
Wie speichert ein CSG-Modell ein Bauteil und wann entsteht daraus die explizite Begrenzungsgeometrie?
][
*Antwort:* Sie speichern die Entstehungsgeschichte als Baum. Sie nutzen Grundkörper wie Quader, Zylinder, Kugel. Flächen werden beim Evaluieren abgeleitet.

#src[L-alt A2, offene Überarbeitung Frage 16; B S. 17–38]
]

#aufgabe(titel: "Skizzenmodul und seine Bedingung", art: "verstehen", quelle: "2.4", herkunft: "variante", vorlage: "Buch Kap. 3, Aufg. 3.3")[
#if not web [*Aufgabe 28* #linebreak()]
Wozu dient das Skizzenmodul, und welche Bedingung muss die Skizze erfüllen? (#strong[B Übung 3.3])
][
*Antwort:* Es erzeugt auf einer Arbeitsebene den Umriss der Grundgeometrie, der dann extrudiert oder rotiert wird. Die Kontur muss ein geschlossener Linienzug sein (S. 27–28).
][
*Kurz gefasst (aus der Karteikarte):*
- Die Kontur muss ein geschlossener Linienzug sein.
- Nur dann kann man sie zu einem Volumen extrudieren oder rotieren.

*Merksatz:* Für den Volumenkörper muss die Skizzenkontur geschlossen sein.
#src[L-alt A2, Frage 4; nach B S. 17–38]
]

#aufgabe(titel: "Nachteile flächenbasierter Systeme", art: "verstehen", quelle: "2.4", herkunft: "eigen")[
#if not web [*Aufgabe 29* #linebreak()]
Welche Nachteile haben flächenbasierte Systeme gegenüber volumenbasierten?
][
*Antwort:* Keine Volumenberechnung oder Kollisionsprüfung, oft keine Zeichnungsableitung und kein Datenbaum, kaum nachträglich änderbar, Lückenlosigkeit der Flächen nicht garantiert (S. 29–30).
][
*Kurz gefasst (aus der Karteikarte):*
- Sie kennen kein Volumen, also gibt es keine Volumenberechnung und keine Kollisionsprüfung.
- Oft fehlen Zeichnungsableitung und Datenbaum, nachträgliche Änderungen sind schwer, und die Lückenlosigkeit der Flächen ist nicht garantiert.
#src[L-alt A2, Frage 10; nach B S. 17–38]
]

#aufgabe(titel: "Austauschformate zuordnen", art: "verstehen", quelle: "2.5", herkunft: "eigen")[
#if not web [*Aufgabe 30* #linebreak()]
Ordne zu: 2D-Zeichnungsaustausch, 3D-Druck, vollständiges Produktmodell, Freiformflächen in der Autoindustrie.
][
*Antwort:* DXF; STL; STEP; VDAFS (S. 31).

#src[L-alt A2, Frage 8; nach B S. 17–38]
]

#aufgabe(titel: "STL oder STEP wählen", art: "verstehen", quelle: "2.5", herkunft: "eigen")[
#if not web [*Aufgabe 31* #linebreak()]
Welches Austauschformat beschreibt Dreiecksflächen, welches ein umfassendes Produktmodell? Begründe die Wahl für 3D-Druck und Datenaustausch.
][
*Antwort:* STL: Dreiecke. STEP: ganzes Produktmodell.
][
*Kurz gefasst (aus dem Quiz):*
- STL. STL beschreibt die Oberfläche aus Dreiecken und lässt sich leicht in Schichten schneiden.
][
*Typische Verwechslungen:*
- „DXF“: DXF ist der Standard für den 2D-Zeichnungsaustausch.
- „STEP“: STEP überträgt das vollständige Produktmodell, ist aber nicht das typische Druckformat.
- „VDAFS“: VDAFS ist für Freiformflächen zwischen Autoherstellern und Zulieferern.
][
*Kurz gefasst (aus der Karteikarte):*
- STL beschreibt die Oberfläche nur als Dreiecke und genügt für den 3D-Druck.
- STEP überträgt ein umfassendes Produktmodell und dient dem Datenaustausch zwischen CAD-Systemen.

*Merksatz:* STL für Dreiecke, STEP für den umfassenderen Produktaustausch.
#src[L-alt A2, offene Überarbeitung Frage 15; B S. 17–38]
]

#aufgabe(titel: "Warum trotz CAD noch gedruckt wird", art: "verstehen", quelle: "2.6", herkunft: "original", vorlage: "Buch Kap. 3, Aufg. 3.4")[
#if not web [*Aufgabe 32* #linebreak()]
Warum ist es sinnvoll, trotz der Nutzung eines CAD-Systems und der Übertragung von elektronischen Daten, noch eine Technische Zeichnung zu erstellen und auch auszudrucken?
][
*Antwort:* Die Zeichnung dokumentiert den freigegebenen, abgestimmten Stand (Zeichnungs- und Revisionsnummer); Der Änderungsstand muss nachvollziehbar sein. Auf Papier können Parteien per Unterschrift zustimmen (paraphieren). Folgedokumente verweisen auf einen Zeichnungsstand (S. 33–34).
][
*Kurz gefasst (aus der Karteikarte):*
- Die Zeichnung dokumentiert den freigegebenen, abgestimmten Stand mit Zeichnungs- und Revisionsnummer.
- Änderungen bleiben nachvollziehbar, Beteiligte können per Unterschrift zustimmen, und Folgedokumente verweisen auf genau diesen Stand.
#src[L-alt A2, Frage 5; nach B S. 17–38]
]

#aufgabe(titel: "CAD und sein Hauptvorteil", art: "verstehen", quelle: "2.6", herkunft: "variante", vorlage: "Buch Kap. 3, Aufg. 3.1")[
#if not web [*Aufgabe 33* #linebreak()]
Wofür steht CAD, und worin liegt der Hauptvorteil? (#strong[B Übung 3.1])
][
*Antwort:* Computer Aided Design = rechnerunterstütztes Konstruieren. Hauptvorteil: Durchgängigkeit der Daten von Entwicklung über Konstruktion bis Fertigung (S. 32).
][
*Kurz gefasst (aus der Karteikarte):*
- *Die Durchgängigkeit der Daten:* Dasselbe Modell wird von der Entwicklung über die Konstruktion bis zur Fertigung genutzt, ohne es neu zu zeichnen.
#src[L-alt A2, Frage 1; nach B S. 17–38]
]

#aufgabe(titel: "Wann sich CAD lohnt", art: "verstehen", quelle: "2.6", herkunft: "eigen")[
#if not web [*Aufgabe 34* #linebreak()]
Für welche Konstruktionsart lohnt sich CAD am meisten, für welche am wenigsten? Begründe.
][
*Antwort:* Am meisten: Variantenkonstruktion (parametrisierbare Modelle), dann Anpassungskonstruktion (Vorlagen schnell ändern). Am wenigsten: Neukonstruktion, weil CAD nicht beim Finden neuer Lösungen hilft (S. 32–33).
][
*Kurz gefasst (aus der Karteikarte):*
- Am meisten bei der Variantenkonstruktion, weil parametrische Modelle schnell neue Größen liefern.
- Dann bei der Anpassungskonstruktion.
- Am wenigsten bei der Neukonstruktion, denn CAD hilft nicht beim Finden neuer Lösungen.
#src[L-alt A2, Frage 7; nach B S. 17–38]
]

#aufgabe(titel: "Fünf Anwendungen des Digital Mock-Up", art: "verstehen", quelle: "2.6", herkunft: "eigen")[
#if not web [*Aufgabe 35* #linebreak()]
Nenne die fünf Anwendungen des Digital Mock-Up mit je einem Satz.
][
*Antwort:* Visualisierung (Gestalt von allen Seiten), Packaging (Platzverhältnisse), Clash & Clearance (Kollision, Freigängigkeit), Enveloping (Zusatzraum durch Schwingung/Wärme), Virtual Workshop (Platzbedarf bei Montage/Wartung) (S. 34–35).

#src[L-alt A2, Frage 9; nach B S. 17–38]
]

#aufgabe(titel: "Freigabe, Revision und Folgedokumente", art: "verstehen", quelle: "2.6", herkunft: "eigen")[
#if not web [*Aufgabe 36* #linebreak()]
Welche Aufgabe erfüllen Freigabe, Revision und Folgedokumente im Dokumentationsablauf des Buchs?
][
*Antwort:* Im Buch dient der freigegebene Zeichnungsstand zur nachvollziehbaren Änderungskontrolle. Sie trägt eine Revisionsnummer und Paraphen. Folgedokumente beziehen sich auf einen Zeichnungsstand.

#src[L-alt A2, offene Überarbeitung Frage 17; B S. 17–38]
]

#aufgabe(titel: "Clash und Clearance an einem Beispiel", art: "verstehen", quelle: "2.6", herkunft: "eigen")[
#if not web [*Aufgabe 37* #linebreak()]
Erkläre Clash & Clearance an einem eigenen Montagebeispiel.
][
*Antwort:* Kollisionsprüfung und Prüfung der Freigängigkeit.
][
*Kurz gefasst (aus der Karteikarte):*
- Ob sich Bauteile durchdringen (Clash) und ob genug Abstand für Bewegung bleibt (Clearance).
- So findet man Kollisionen, bevor ein Prototyp gebaut wird.

*Merksatz:* Clash fragt „Zusammenstoß?“, Clearance fragt „Genug Platz?“.
#src[L-alt A2, offene Überarbeitung Frage 18; B S. 17–38]
]

#aufgabe(titel: "KI-Erklärungen zu Zeichnungen prüfen", art: "verstehen", quelle: "2.7", herkunft: "eigen")[
#if not web [*Aufgabe 38* #linebreak()]
Warum soll man Erklärungen einer KI zu einer Technischen Zeichnung immer prüfen?
][
*Antwort:* Weil die KI nach Wahrscheinlichkeiten antwortet; im Buchtest waren Aussagen teils falsch, pauschal oder irreführend (S. 35–38).
][
*Kurz gefasst (aus der Karteikarte):*
- Die KI antwortet nach Wahrscheinlichkeiten, nicht nach Normwissen.
- Im Test des Buchs waren Aussagen teils falsch, pauschal oder irreführend.
#src[L-alt A2, Frage 12; nach B S. 17–38]
]


#kapitel("Kapitel 3 · Werkstücke darstellen")

#aufgabe(titel: "Natürlicher Maßstab, Verkleinerung, Vergrößerung", art: "verstehen", quelle: "3.1", herkunft: "original", vorlage: "Buch Kap. 4, Aufg. 4.1 und 4.2")[
#if not web [*Aufgabe 39* #linebreak()]
#enum(numbering: "a)",
[Was steht hinter dem Begriff „natürlicher Maßstab“?],
[Was bedeutet der Maßstab „1:5“ und was der Maßstab „5:1“?],
)
][
*Antwort:* Natürlicher Maßstab 1 : 1: gezeichnete Länge = wirkliche Länge. 1 : 5: fünffach verkleinert (1 mm Papier = 5 mm Wirklichkeit). 5 : 1: fünffach vergrößert (S. 40).
][
*Kurz gefasst (aus der Karteikarte):*
- 1 : 5 ist fünffach verkleinert (1 mm auf dem Papier sind 5 mm in Wirklichkeit).
- 5 : 1 ist fünffach vergrößert.
- An der Maßlinie steht trotzdem immer das wirkliche Maß.

*Merksatz:* Gezeichnete Größe darf wechseln, die Maßzahl bleibt wirklich.
#src[L-alt B1, Frage 1; nach B S. 39–64]
]

#aufgabe(titel: "Maßstäbe wählen und angeben", art: "verstehen", quelle: "3.1", herkunft: "original", vorlage: "Buch Kap. 4, Aufg. 4.3 und 4.4")[
#if not web [*Aufgabe 40* #linebreak()]
#enum(numbering: "a)",
[Dürfen Maßstäbe frei gewählt werden?],
[Wo wird der Maßstab in einer Zeichnung angegeben?],
)
][
*Antwort:* Nein, nur die Maßstäbe nach DIN ISO 5455 (Tab. 4-1). Hauptmaßstab im Schriftfeld; weitere bei der Einzelheit bzw. dem Schnitt, z. B. „Y 10:1“ (S. 40).

#src[L-alt B1, Frage 2; nach B S. 39–64]
]

#aufgabe(titel: "Maßzahl einer Welle im Maßstab 1 : 2", art: "verstehen", quelle: "3.1", herkunft: "eigen")[
#if not web [*Aufgabe 41* #linebreak()]
Eine Welle ist 480 mm lang und wird im Maßstab 1 : 2 gezeichnet. Welche Maßzahl steht an der Maßlinie? Begründe deine Antwort.
][
*Antwort:*
- 480. Der Maßstab ändert nur die Zeichnung, nicht die Maßzahl.
][
*Typische Verwechslungen:*
- „240“: 240 mm ist die gezeichnete Länge. Maßzahlen geben immer die wahre Größe an.
- „960“: Hier wurde der Maßstab falsch herum angewandt.
- „480 : 2“: Maßstäbe stehen nicht an der Maßzahl, sondern im Schriftfeld bzw. neben Einzelheiten.
]

#aufgabe(titel: "Warum man keine Maße aus der Zeichnung abgreift", art: "verstehen", quelle: "3.1", herkunft: "eigen")[
#if not web [*Aufgabe 42* #linebreak()]
Warum darf man keine Maße aus einer Zeichnung abgreifen?
][
*Antwort:*
- Maßgebend sind nur die eingetragenen Maße.
- Kopien sind oft nicht maßstäblich, und eine Zeichnung ist nur so genau, wie sie gezeichnet wurde.

*Merksatz:* Maßzahl lesen, nicht mit dem Lineal raten.
]

#aufgabe(titel: "Hebel im Maßstab 1 : 5", art: "rechnen", quelle: "3.1", herkunft: "eigen",
  ergebnis: [a) 72 mm (Breite 9,6 mm), b) 360, c) Maßstab 5 : 1],
  tipp: [Zeichenlänge = Maßstab mal wirkliche Länge. An der Maßlinie steht immer das wirkliche Maß.],
)[
#if not web [*Aufgabe 43* #linebreak()]
*Gegeben und Annahmen*

Ein Hebel ist in Wirklichkeit 360 mm lang und 48 mm breit. Für die Einzelheit stehen die Vergrößerungsmaßstäbe 2:1, 5:1 und 10:1 zur Auswahl.

*Gesucht*

#enum(numbering: "a)",
[Wie lang wird er im Maßstab 1 : 5 gezeichnet?],
[Welche Zahl steht an der Maßlinie?],
[Eine Bohrung Ø6 soll als Einzelheit gezeichnet werden. Welchen genormten Maßstab wählst du, damit sie mindestens 25 mm groß erscheint?],
)
][
*Bild:* Der Maßstab ist eine Lupe oder ein Verkleinerungsglas. Er ändert nur, wie groß das Teil auf dem Papier aussieht, nie das Teil selbst.
][
*a) Zeichenlänge:* Bei 1 : 5 wird alles fünfmal kleiner: $360\/5 = 72 thin "mm"$ lang, $48\/5 = "9,6" thin "mm"$ breit.
][
*b) Maßzahl:* An der Maßlinie steht *360*, also das wirkliche Maß. Die Werkstatt fertigt nach der Zahl, nicht nach der gezeichneten Länge.
][
*c) Maßstab für die Einzelheit:* Gefordert ist Zeichengröße ≥ 25 mm. Also muss der Vergrößerungsfaktor mindestens $25\/6 approx "4,2"$ sein. Der nächste genormte Maßstab darüber ist *5 : 1*; Ø6 erscheint dann 30 mm groß.
][
*Prüfen:* 2 : 1 gäbe nur 12 mm, zu klein. 10 : 1 ginge auch, wäre aber unnötig groß.
#src[L-alt B1, Frage 15; nach B S. 39–64]
]

#aufgabe(titel: "Länge aus einer Zeichnung 1 : 2", art: "rechnen", quelle: "3.1", herkunft: "eigen",
  ergebnis: [74 mm; abgreifen ist trotzdem unzulässig],
  tipp: [Bei 1 : 2 ist das Bild halb so groß wie das Teil. Rechne zurück.],
)[
#if not web [*Aufgabe 44* #linebreak()]
*Gegeben und Annahmen*

Auf einer Zeichnung im Maßstab 1 : 2 misst du eine Länge von 37 mm nach.

*Gesucht*

#enum(numbering: "a)",
[Wie lang ist das Teil wirklich?],
[Warum darf man in der Praxis trotzdem keine Maße aus der Zeichnung abgreifen?],
)
][
*Bild:* 1 : 2 heißt: 1 mm auf dem Papier steht für 2 mm am Teil.
][
*Zurückrechnen:* wirkliche Länge = Zeichenlänge geteilt durch Maßstab $= 37 thin "mm" \/ (1\/2) = 74 thin "mm"$.
][
*Warum trotzdem nicht abgreifen:* Maßgebend sind nur die eingetragenen Maße. Kopien und Ausdrucke sind oft nicht maßstabsgetreu (S. 40), und eine Zeichnung ist nur so genau, wie sie gezeichnet wurde.
][
*Merksatz:* Fehlt ein Maß, fragt man den Konstrukteur. Ein nachgemessenes Maß kann um Zehntel danebenliegen, und das reicht für Ausschuss.
#src[L-alt B1, Frage 16; nach B S. 39–64]
]

#aufgabe(titel: "Zeichenlänge und Maßzahl bei 1 : 5", art: "rechnen", quelle: "3.1", herkunft: "eigen",
  ergebnis: [Zeichenlänge 48 mm, Maßzahl 240],
  tipp: [Zeichenlänge und Maßzahl sind zwei verschiedene Dinge.],
)[
#if not web [*Aufgabe 45* #linebreak()]
*Gegeben und Annahmen*

Ein Bauteil ist 240 mm lang und wird im Maßstab 1:5 gezeichnet.

*Gesucht*

#enum(numbering: "a)",
[Berechne Zeichenlänge und Maßzahl.],
)
][
*Maßstab lesen:* 1 : 5 ist eine Verkleinerung, der Faktor ist $1\/5$.
][
*Zeichenlänge:* $240 thin "mm" \/ 5 = 48 thin "mm"$. So lang wird die Linie auf dem Papier.
][
*Maßzahl:* An die Maßlinie schreibst du *240*, das wirkliche Maß.
][
*Prüfen:* Die Zeichnung ist fünfmal kleiner als das Werkstück: $5 dot 48 = 240$.
#src[L-alt, Zusatzaufgabe L1; eigenes Zahlenbeispiel nach B S. 39–41]
]

#aufgabe(titel: "Kantenlänge aus einer Zeichnung 1 : 2", art: "rechnen", quelle: "3.1", herkunft: "eigen",
  ergebnis: [Kante 170 mm, Maßzahl 170],
  tipp: [Bei einer Verkleinerung ist das Teil größer als das Bild.],
)[
#if not web [*Aufgabe 46* #linebreak()]
*Gegeben und Annahmen*

In einer Zeichnung im Maßstab 1 : 2 misst du eine Kante mit 85 mm.

*Gesucht*

#enum(numbering: "a)",
[Wie lang ist die Kante am Bauteil, und welche Maßzahl muss dort stehen?],
)
][
*Maßstab lesen:* 1 : 2 heißt, das Bild ist halb so groß wie das Teil.
][
*Zurückrechnen:* $85 thin "mm" dot 2 = 170 thin "mm"$ am Bauteil.
][
*Maßzahl:* An der Maßlinie steht das wirkliche Maß, also *170*.
][
*Prüfen:* Das Bauteil muss größer sein als die Zeichnung, und 170 > 85 passt.
#src[L-alt A1; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

#aufgabe(titel: "Linienarten zuordnen", art: "verstehen", quelle: "3.2", herkunft: "original", vorlage: "Buch Kap. 4, Aufg. 4.5")[
#if not web [*Aufgabe 47* #linebreak()]
Ordnen Sie in folgender Auflistung die jeweils richtige Linienart zu.
#enum(numbering: "a)", [Umrisse und Kanten, allgemein], [verdeckte Umrisse und Kanten], [Umrisse eines angrenzenden Werkstücks], [Lichtkanten], [Rohteilgeometrie in einer Fertigteilzeichnung], [Hinweislinien], [Bruchkante eines unvollständig dargestellten Werkstücks], [Mittellinie an einem Handgriff], [Wärmebehandlung einer bestimmten Zone], [Andeutung der Extremstellungen von beweglichen Teilen], [Schraffurlinien])
][
*Antwort:* a) 1 breite Volllinie; b) 5 schmale Strichlinie; c) 7 Strich-Zweipunktlinie; d) 4 schmale Volllinie; e) 7; f) 4; g) 8 Freihand-/Zickzacklinie; h) 6 schmale Strich-Punktlinie; i) 3 breite Strich-Punktlinie; j) 7; k) 4 (S. 41–43).
][
*Kurz gefasst (aus der Karteikarte):*
- *Breite Volllinie:* sichtbare Kanten
- *Schmale Strichlinie:* verdeckte Kanten
- *Schmale Strich-Punktlinie:* Mittel- und Symmetrielinien, Lochkreise, Teilkreise
- *Schmale Volllinie:* Maß- und Hilfslinien, Schraffur, Lichtkanten
- *Strich-Zweipunktlinie:* angrenzende Teile, Extremstellungen, Rohteilkontur
- *Breite Strich-Punktlinie:* Schnittverlauf, wärmebehandelte Zone
#bild("linienarten", [Eigene Vektordarstellung nach B Tab. 4-2 und Bild 4-2, S. 41–43.], height: 50mm)
#src[L-alt B1, Frage 3; nach B S. 39–64]
]

#aufgabe(titel: "Strich-Punktlinie und Linienbreite auf A3", art: "verstehen", quelle: "3.2", herkunft: "variante", vorlage: "Buch Kap. 4, Aufg. 4.6 und 4.7")[
#if not web [*Aufgabe 48* #linebreak()]
Was kann mit einer schmalen Strich-Punktlinie dargestellt werden? Welche Linienbreite haben Körperkanten auf A3? (#strong[B Übung 4.6/4.7])
][
*Antwort:* Mittel- und Symmetrielinien, Lochkreise, Teilkreise von Zahnrädern, Bahnlinien. Körperkanten auf A3: Liniengruppe 0,5, also 0,5 mm (schmale Linien 0,25 mm) (S. 43).

#src[L-alt B1, Frage 4; nach B S. 39–64]
]

#aufgabe(titel: "Schmale und breite Linien", art: "verstehen", quelle: "3.2", herkunft: "eigen")[
#if not web [*Aufgabe 49* #linebreak()]
Welche Linien sind bei Bemaßung, Schraffur und Symmetrie schmal, und welche Konturen werden breit gezeichnet?
][
*Antwort:* Maßlinien. Schraffur. Mittellinien.

#src[L-alt B1, offene Überarbeitung Frage 18; B S. 39–64]
]

#aufgabe(titel: "Linienart für Mittel- und Symmetrielinien", art: "verstehen", quelle: "3.2", herkunft: "eigen")[
#if not web [*Aufgabe 50* #linebreak()]
Welche Linienart verwendet man für Mittel- und Symmetrielinien? Begründe deine Antwort.
][
*Antwort:*
- Schmale Strich-Punktlinie. Auch Lochkreise und Teilkreise von Zahnrädern werden so gezeichnet.
][
*Typische Verwechslungen:*
- „Breite Strich-Punktlinie“: Die breite Strich-Punktlinie kennzeichnet den Schnittverlauf und Behandlungszonen.
- „Schmale Strichlinie“: Die schmale Strichlinie ist für verdeckte Kanten.
- „Schmale Strich-Zweipunktlinie“: Sie zeigt angrenzende Teile, Extremstellungen oder Rohteilkonturen.
]

#aufgabe(titel: "Wofür die Strich-Zweipunktlinie steht", art: "verstehen", quelle: "3.2", herkunft: "eigen")[
#if not web [*Aufgabe 51* #linebreak()]
Wofür steht die schmale Strich-Zweipunktlinie? Begründe deine Antwort.
][
*Antwort:*
- Angrenzende Teile. Merkhilfe: „Zweipunkt = das zweite Teil“.
- Extremstellungen beweglicher Teile. Die zweite Stellung eines Hebels wird so gezeichnet.
- Rohteilkontur in einer Fertigteilzeichnung. Auch der Zustand vor bzw. nach der Bearbeitung wird so dargestellt.
][
*Typische Verwechslungen:*
- „Verdeckte Kanten“: Dafür nimmt man die schmale Strichlinie.
- „Sichtbare Kanten“: Sichtbare Kanten sind breite Volllinien.
]

#aufgabe(titel: "Wie viele Ansichten nötig sind", art: "verstehen", quelle: "3.3", herkunft: "original", vorlage: "Buch Kap. 4, Aufg. 4.9")[
#if not web [*Aufgabe 52* #linebreak()]
Wie viele Ansichten müssen von einem Bauteil in einer Technischen Zeichnung erzeugt werden?
][
*Antwort:* So viele wie nötig, um das Teil eindeutig darzustellen: oft eine oder zwei, typisch drei, maximal sechs Standardansichten, bei Bedarf Zusatzansichten (S. 45–46).
][
*Kurz gefasst (aus der Karteikarte):*
- So viele wie nötig, damit das Teil eindeutig ist, und nicht mehr.
- Oft reichen eine oder zwei, typisch sind drei.

*Merksatz:* So viele Ansichten wie nötig, so wenige wie möglich.
#bild("b-ansichten", [Bilder 4-4/4-5: Ansichten nach Projektionsmethode 1. B, S. 45 (PDF-S. 56).], height: 50mm)
#src[L-alt B1, Frage 6; nach B S. 39–64]
]

#aufgabe(titel: "Projektionsmethode 1 und 3", art: "verstehen", quelle: "3.3", herkunft: "original", vorlage: "Buch Kap. 4, Aufg. 4.10 und 4.11")[
#if not web [*Aufgabe 53* #linebreak()]
#enum(numbering: "a)",
[Was versteht man unter der Bezeichnung Projektionsmethode 1 und wie unterscheidet sich diese von der Projektionsmethode 3?],
[Wie bzw. wodurch wird in einer Technischen Zeichnung definiert, ob die Projektionsmethode 1 oder Projektionsmethode 3 gültig ist?],
)
][
*Antwort:* Methode 1: Draufsicht unten, Seitenansicht von links rechts. Methode 3: Draufsicht oben, Seitenansicht von links links. Kennzeichnung durch das Symbol der Projektionsmethode nahe dem Schriftfeld (Bild 4-6) (S. 46).
][
*Kurz gefasst (aus der Karteikarte):*
- Bei Methode 1 liegt die Draufsicht unter der Vorderansicht und die Seitenansicht von links rechts daneben.
- Bei Methode 3 ist es umgekehrt.
- Welche Methode gilt, zeigt das Symbol nahe dem Schriftfeld.
#bild("b-ansichten", [Bilder 4-4/4-5: Ansichten nach Projektionsmethode 1. B, S. 45 (PDF-S. 56).], height: 50mm)
][
*Bild:* Methode 1: Man schaut von oben, und das Bild fällt durch das Teil nach unten aufs Papier.
#src[L-alt B1, Frage 7; nach B S. 39–64]
]

#aufgabe(titel: "Pfeilmethode und Abweichen von Methode 1", art: "verstehen", quelle: "3.3", herkunft: "original", vorlage: "Buch Kap. 4, Aufg. 4.12 und 4.19")[
#if not web [*Aufgabe 54* #linebreak()]
#enum(numbering: "a)",
[Die Darstellung von Ansichten mithilfe der Pfeilmethode ist wenig übersichtlich. In welchen Fällen ist die Pfeilmethode dennoch sinnvoll?],
[Wie wird verfahren, wenn abweichend von der allgemein üblichen Projektionsmethode 1 die Ansichten eines Werkstückes positioniert werden sollen?],
)
][
*Antwort:* Wenn Ansichten anders angeordnet werden sollen oder schräge Flächen unverkürzt gezeigt werden müssen. Vorgehen: Blickrichtung jeder Ansicht mit Pfeil und Großbuchstaben festlegen, Ansicht mit demselben Buchstaben bezeichnen (S. 46).

#src[L-alt B1, Frage 8; nach B S. 39–64]
]

#aufgabe(titel: "Dreitafelprojektion und Projektionssymbole", art: "verstehen", quelle: "3.3", herkunft: "original", vorlage: "Altklausur WS 20/21, Aufg. 1b und 1c", minuten: 5)[
#if not web [*Aufgabe 55* #linebreak()]
#enum(numbering: "a)",
[Wie nennt man die Ansichten in einer 3-Tafelprojektion? (3 Punkte)],
[Wofür stehen diese Symbole? (2 Punkte)
#bild("ak-projektionssymbole", [Die beiden Symbole aus AK 1c (eigene Nachzeichnung nach AK, PDF-S. 2). Links: Kegelstumpf links, Kreisansicht rechts. Rechts: Kreisansicht links, Kegelstumpf rechts.], height: 30mm)],
)
][
*a) Drei Ansichten:* Vorderansicht (Hauptansicht), Draufsicht (Blick von oben) und Seitenansicht von links. Je Ansicht ein Punkt.
][
*b) Symbole:* Beide Zeichen zeigen einen Kegelstumpf und seine Kreisansicht; sie kennzeichnen die Projektionsmethode. Liegt die Kreisansicht #strong[rechts] vom Kegelstumpf, ist es Projektionsmethode 1 (europäisch): Die Ansicht von links wird nach rechts geklappt. Liegt die Kreisansicht #strong[links], ist es Projektionsmethode 3 (amerikanisch). Das Symbol steht im oder am Schriftfeld und legt fest, wie die Ansichten angeordnet sind.

#src[AK 1b/1c, PDF-S. 2; B Bild 4-6, S. 46]
]

#aufgabe(titel: "Lage des Werkstücks in der Zeichnung", art: "verstehen", quelle: "3.3", herkunft: "variante", vorlage: "Buch Kap. 4, Aufg. 4.8")[
#if not web [*Aufgabe 56* #linebreak()]
In welcher Lage wird ein Werkstück vorzugsweise dargestellt? Wie liegt ein Drehteil? (#strong[B Übung 4.8])
][
*Antwort:* In Gebrauchslage, sonst in Fertigungslage; Drehteile waagrecht mit dem dünnen Ende nach rechts (S. 44).
][
*Kurz gefasst (aus dem Quiz):*
- Waagerecht, das dünne Ende nach rechts. So liegt es auf der Drehmaschine.
][
*Typische Verwechslungen:*
- „Senkrecht stehend“: Drehteile werden waagerecht gezeichnet, wie sie auf der Drehmaschine liegen.
- „Waagerecht, das dicke Ende nach rechts“: Die Richtung ist vertauscht.
- „Unter 45°, damit alle Absätze sichtbar sind“: Eine schräge Hauptansicht widerspricht der senkrechten Parallelprojektion.
][
*Kurz gefasst (aus der Karteikarte):*
- Vorzugsweise in Gebrauchslage, sonst in Fertigungslage.
- Drehteile liegen waagrecht mit dem dünnen Ende nach rechts, so wie sie in der Drehmaschine eingespannt werden.
#bild("b-ansichten", [Bilder 4-4/4-5: Ansichten nach Projektionsmethode 1. B, S. 45 (PDF-S. 56).], height: 50mm)
#src[L-alt B1, Frage 5; nach B S. 39–64]
]

#aufgabe(titel: "Stufenklotz nach Projektionsmethode 3", art: "verstehen", quelle: "3.3", herkunft: "eigen")[
#if not web [*Aufgabe 57* #linebreak()]
Skizziere den Stufenklotz aus der Abbildung in Abschnitt 3 nach Projektionsmethode 3. Wo liegen Draufsicht und Seitenansicht von links?
][
*Modell / Annahmen:* Maßstäbliche orthogonale Zeichnung; Maße beziehen sich auf das wirkliche Bauteil.

Methode 3: Draufsicht über der Vorderansicht (Rechteck 120 × 80 mit Linie bei der Stufe), Seitenansicht von links links neben der Vorderansicht (Quadrat mit verdeckter Linie auf halber Höhe).

*Prüfung:* Maßzahl und wirkliche Länge müssen übereinstimmen; alle Ansichten müssen denselben Körper zeigen.

#src[L-alt B1, Frage 17; nach B S. 39–64]
]

#aufgabe(titel: "Lage der Draufsicht bei Methode 1", art: "verstehen", quelle: "3.3", herkunft: "eigen")[
#if not web [*Aufgabe 58* #linebreak()]
Wo liegt bei Projektionsmethode 1 die Draufsicht? Begründe die Lage durch gedankliches Aufklappen.
][
*Antwort:* unter der Vorderansicht.

#src[L-alt B1, offene Überarbeitung Frage 19; B S. 39–64]
]

#aufgabe(titel: "Lage der Seitenansicht von links bei Methode 1", art: "verstehen", quelle: "3.3", herkunft: "eigen",
  tipp: [Wer das vertauscht, zeichnet das Teil spiegelverkehrt.],
)[
#if not web [*Aufgabe 59* #linebreak()]
Wo liegt bei Projektionsmethode 1 die Seitenansicht von links? Begründe deine Antwort.
][
*Antwort:*
- Rechts neben der Vorderansicht. Man schaut von links und „klappt“ die Ansicht nach rechts weg. Die Draufsicht liegt unter der Vorderansicht.
][
*Typische Verwechslungen:*
- „Links neben der Vorderansicht“: Das ist Projektionsmethode 3 (anglo-amerikanisch). Bei Methode 1 ist es gerade umgekehrt.
- „Unter der Vorderansicht“: Unter der Vorderansicht liegt die Draufsicht.
- „Über der Vorderansicht“: Über der Vorderansicht liegt bei Methode 1 die Untersicht.
]

#aufgabe(titel: "Geschnittener Kegel in drei Ansichten", art: "rechnen", quelle: "3.3", herkunft: "original", vorlage: "Altklausur WS 20/21, Aufg. 2a", minuten: 9, platz: 18)[
#if not web [*Aufgabe 60* #linebreak()]
Konstruieren Sie Draufsicht und Seitenansicht von links des geschnittenen Kegels. (10 Punkte)
#bild("ak-kegel", [Originalausschnitt AK, PDF-S. 5: Vorderansicht eines geraden Kreiskegels, dessen Spitze durch eine schräge Ebene abgeschnitten ist.], height: 69mm)
][
*Lesen, was gegeben ist:* Ein gerader Kreiskegel (Achse senkrecht, Grundkreis unten) wird von einer Ebene geschnitten, die senkrecht zur Bildebene steht. In der Vorderansicht erscheint sie deshalb als Gerade vom linken Umriss (unten) zum rechten Umriss (oben). Weil die Ebene alle Mantellinien schneidet, ist die Schnittfigur eine Ellipse. Maße sind nicht angegeben, also überträgst Du alles aus der Vorderansicht mit dem Zirkel bzw. Lineal.
][
*Anordnung (Methode 1):* Draufsicht senkrecht unter die Vorderansicht, Seitenansicht von links rechts daneben, auf gleicher Höhe. In der Draufsicht ist der Grundkreis ein voller Kreis um die Achse.
][
*Hilfsmittel Mantellinien:* Teile den Grundkreis in der Draufsicht in z. B. 12 gleiche Teile und zeichne die Mantellinien zur Spitze. Übertrage sie in die Vorderansicht (Fußpunkte hochloten, mit der Spitze verbinden). Wo eine Mantellinie die Schnittgerade trifft, liegt ein Punkt der Schnittkurve.
][
*Punkte projizieren:* Lote jeden Schnittpunkt senkrecht nach unten auf die zugehörige Mantellinie der Draufsicht und waagrecht nach rechts in die Seitenansicht; dort trägst Du die Tiefe (Abstand von der Mittellinie) aus der Draufsicht ab (45°-Hilfslinie oder Zirkel). Warum: Jeder Punkt hat in allen Ansichten dieselbe Höhe bzw. Breite.
][
*Kennpunkte prüfen:* Der unterste Punkt liegt auf dem linken, der oberste auf dem rechten Umriss (beide auf der Symmetrieebene). Die größte Breite der Ellipse liegt auf halber Strecke der Schnittgeraden. In der Seitenansicht berührt die Schnittkurve den Umriss dort, wo die Schnittgerade die Kegelachse kreuzt.
][
*Ausziehen:* Punkte zu glatten Kurven verbinden (Ellipse in der Draufsicht, Kurve in der Seitenansicht), sichtbare Kanten breit, Achsen als schmale Strich-Punktlinien. Der abgeschnittene Teil mit der Spitze entfällt in beiden Ansichten.

#src[AK 2a, PDF-S. 5; eigene Lösung mit B S. 43–47]
]

#aufgabe(titel: "Kegel mit elliptischem Schnitt (Variante)", art: "rechnen", quelle: "3.3", herkunft: "variante", vorlage: "Altklausur WS 20/21, Aufg. 2a", minuten: 12, platz: 18,
  ergebnis: [Draufsicht: Ellipse von $x = -20$ bis $x = 10$ mm, Mittelpunkt bei $x = -5$ mm, Halbachsen 15 mm und $approx "14,1"$ mm. Seitenansicht: Kurve von Höhe 30 bis 60 mm, größte Breite $plus.minus "14,1"$ mm in Höhe 45 mm, berührt den Umriss in Höhe 50 mm bei $plus.minus "13,3"$ mm],
  tipp: [Ein Punkt der Schnittkurve liegt auf dem Kegel ($r = 30 - z\/3$) und auf der Schnittebene. Für jede Höhe $z$ gilt $y^2 = r^2 - x^2$.],
)[
#if not web [*Aufgabe 61* #linebreak()]
*Gegeben und Annahmen*

Gerader Kreiskegel: Grundkreis Ø60 mm, Höhe $H = 90$ mm, Achse senkrecht. Eine Ebene senkrecht zur Bildebene schneidet die Spitze ab. In der Vorderansicht ist sie eine Gerade vom linken Umriss in 30 mm Höhe zum rechten Umriss in 60 mm Höhe. Koordinaten: $x$ nach rechts, $y$ nach hinten, $z$ nach oben, Ursprung in der Mitte des Grundkreises.
#align(center)[#image("abbildungen/var-kegel-ellipse.svg", height: 62mm)]
#align(center)[#text(size: 8.4pt, fill: muted)[Vorderansicht des geschnittenen Kegels (eigene Darstellung, nicht maßstäblich).]]

*Gesucht*

#enum(numbering: "a)",
[Berechne die $x$-Lage der beiden Schnittpunkte mit dem Umriss und die Gleichung der Schnittgeraden $z(x)$.],
[Berechne für $x = -20, -15, -10, -5, 0, 5, 10$ mm die Höhe $z$, den Kegelradius $r$ und die halbe Breite $y$ der Schnittkurve (Tabelle).],
[Gib Mittelpunkt und Halbachsen der Ellipse in der Draufsicht an.],
[Wo berührt die Schnittkurve in der Seitenansicht von links den Umriss, und wo ist sie am breitesten?],
[Skizziere Draufsicht und Seitenansicht von links (Methode 1).],
)
][
*a) Umrisspunkte:* Der Umriss ist $x = plus.minus r(z)$ mit $r(z) = 30 dot (1 - z\/90) = 30 - z\/3$. Links in 30 mm Höhe: $r = 20$, also $x = -20$ mm. Rechts in 60 mm Höhe: $r = 10$, also $x = +10$ mm. Die Gerade steigt um 30 mm auf 30 mm Breite: $z = x + 50$.
][
*b) Punkte der Schnittkurve:* Ein Punkt liegt auf dem Kegel, wenn sein Abstand von der Achse $sqrt(x^2 + y^2) = r(z)$ ist, also $y = sqrt(r^2 - x^2)$. Mit $z = x + 50$:
#tab(columns: 7, th([$x$ / mm], [−20], [−15], [−10], [−5], [0], [5]), [$z$ / mm], [30], [35], [40], [45], [50], [55], [$r$ / mm], [20,0], [18,3], [16,7], [15,0], [13,3], [11,7], [$y$ / mm], [0], [10,5], [13,3], [14,1], [13,3], [10,5])
Bei $x = 10$: $z = 60$, $r = 10$, $y = 0$.
][
*c) Ellipse in der Draufsicht:* Sie reicht in $x$ von −20 bis +10 mm, Mittelpunkt bei $x = -5$ mm, große Halbachse dort 15 mm. Die größte Breite liegt bei $x = -5$: $y = sqrt(15^2 - 5^2) = sqrt(200) approx "14,1"$ mm. Die Ellipse ist also fast ein Kreis, weil die Ebene nur 45° geneigt ist. Außen herum bleibt der volle Grundkreis Ø60 sichtbar.
][
*d) Seitenansicht:* Hier sieht man $(y, z)$. Der Umriss ist $y = plus.minus r(z)$; die Kurve berührt ihn, wo der Kurvenpunkt in der Symmetrieebene quer zur Blickrichtung liegt, also bei $x = 0$: Höhe 50 mm, $y = plus.minus "13,3"$ mm. Am breitesten ist sie in 45 mm Höhe mit $plus.minus "14,1"$ mm, tiefster Punkt 30 mm, höchster 60 mm (beide auf der Achse).
][
*e) Skizze und Prüfung:* Draufsicht unter, Seitenansicht rechts neben die Vorderansicht. In der Seitenansicht oberhalb von 50 mm keinen Kegelumriss mehr zeichnen, dort begrenzt die Schnittkurve. Prüfen: Alle $y$-Werte sind kleiner als $r$, und die Kurve ist zur Mittelebene symmetrisch.
#src[Variante zu AK 2a; eigenes Zahlenbeispiel, Konstruktionsweg nach B S. 43–47]
]

#aufgabe(titel: "Kegel mit Parabelschnitt (Variante)", art: "rechnen", quelle: "3.3", herkunft: "variante", vorlage: "Altklausur WS 20/21, Aufg. 2a", minuten: 12, platz: 18,
  ergebnis: [Schnittgerade $z = 3x + 30$; Punkte $(x; z; y)$: (−10; 0; 28,3), (−5; 15; 24,5), (0; 30; 20,0), (5; 45; 14,1), (10; 60; 0). Draufsicht: Parabelbogen plus gerade Kante $x = -10$ mm; Seitenansicht: Parabel von $plus.minus "28,3"$ mm am Boden bis zur Spitze in 60 mm Höhe],
  tipp: [Die Ebene ist parallel zu einer Mantellinie, darum schneidet sie den Grundkreis und läuft oben spitz zu: Das ergibt eine Parabel.],
)[
#if not web [*Aufgabe 62* #linebreak()]
*Gegeben und Annahmen*

Gleicher Kegel wie im Original: Grundkreis Ø60 mm, Höhe 90 mm. Die Schnittebene steht senkrecht zur Bildebene und verläuft in der Vorderansicht parallel zur linken Mantellinie: vom Grundkreis bei $x = -10$ mm bis zum rechten Umriss in 60 mm Höhe. Der Teil links oberhalb der Ebene (mit der Spitze) ist entfernt.
#align(center)[#image("abbildungen/var-kegel-parabel.svg", height: 62mm)]
#align(center)[#text(size: 8.4pt, fill: muted)[Vorderansicht des geschnittenen Kegels (eigene Darstellung, nicht maßstäblich).]]

*Gesucht*

#enum(numbering: "a)",
[Gleichung der Schnittgeraden $z(x)$ und Nachweis, dass sie zur linken Mantellinie parallel ist.],
[Halbe Breite $y$ der Schnittkurve für $x = -10, -5, 0, 5, 10$ mm.],
[Was sieht man in der Draufsicht? Welche Kanten begrenzen die Schnittfläche?],
[Skizziere die Seitenansicht von links mit den Punkten aus b).],
)
][
*a) Gerade:* Die linke Mantellinie geht von $(-30; 0)$ zur Spitze $(0; 90)$, Steigung $90\/30 = 3$. Die Schnittgerade geht durch $(10; 60)$ mit derselben Steigung: $z = 60 + 3(x - 10) = 3x + 30$. Bei $z = 0$ ist $x = -10$ ✓. Gleiche Steigung heißt parallel, also Parabel.
][
*b) Punkte:* $r = 30 - z\/3 = 30 - (3x + 30)\/3 = 20 - x$, damit $y = sqrt((20 - x)^2 - x^2) = sqrt(400 - 40 x)$.
#tab(columns: 6, th([$x$ / mm], [−10], [−5], [0], [5], [10]), [$z$ / mm], [0], [15], [30], [45], [60], [$y$ / mm], [28,3], [24,5], [20,0], [14,1], [0])
Prüfung bei $x = -10$: $sqrt(10^2 + "28,3"^2) = 30$ mm, der Punkt liegt genau auf dem Grundkreis.
][
*c) Draufsicht:* Vom Grundkreis bleibt nur der Bogen rechts von $x = -10$ mm. Die Schnittfläche wird begrenzt vom Parabelbogen (Scheitel bei $x = 10$, Enden bei $x = -10$, $y = plus.minus "28,3"$) und von der geraden Kante $x = -10$, wo die Ebene die Grundfläche schneidet. Die Gerade ist zugleich Teil des Umrisses.
][
*d) Seitenansicht von links:* Unterhalb von 30 mm Höhe begrenzt der Kegelumriss ($y = plus.minus r$), ab 30 mm die Parabel bis zum Scheitel in 60 mm Höhe auf der Achse. Bei 30 mm berührt die Parabel den Umriss ($y = plus.minus 20$ mm = $r$). Am Boden ist die Parabel $plus.minus "28,3"$ mm breit, sie liegt dort innerhalb des Grundkreisumrisses $plus.minus 30$ mm. Die Schnittfläche ist von links sichtbar, weil sie nach links oben zeigt.
#src[Variante zu AK 2a; eigenes Zahlenbeispiel, Konstruktionsweg nach B S. 43–47]
]

#aufgabe(titel: "Würfel in Isometrie und Dimetrie", art: "rechnen", quelle: "3.3", herkunft: "original", vorlage: "Altklausur WS 20/21, Aufg. 2b", minuten: 5, platz: 12)[
#if not web [*Aufgabe 63* #linebreak()]
Zeichnen Sie einen Würfel mit Kantenlänge 30 mm in isometrischer und dimetrischer Projektion. (5 Punkte)
][
*Isometrie – Achsen:* Eine Achse senkrecht, die beiden anderen je 30° zur Waagerechten (alle drei Achsen 120° zueinander). In der technischen Isometrie werden alle drei Kanten unverkürzt gezeichnet: je 30 mm.
][
*Dimetrie – Achsen:* Eine Achse senkrecht, die Breitenachse etwa 7° und die Tiefenachse etwa 42° zur Waagerechten. Breite und Höhe unverkürzt (30 mm), die Tiefe auf die Hälfte verkürzt: 15 mm. Warum: So sieht die Vorderfläche fast unverzerrt aus, und der Körper wirkt nicht zu tief.
][
*Zeichnen und prüfen:* Von einer Ecke aus die drei Kanten abtragen, dann mit Parallelen zu den Achsen schließen. Kanten derselben Raumrichtung bleiben parallel; sichtbare Kanten breit. Die Maßzahl bleibt für jede Kante 30 mm, auch wenn in der Dimetrie nur 15 mm gezeichnet werden.
#bild("ak-wuerfel-loesung", [Eigene Zeichenlösung zu AK 2b, PDF-S. 6.], height: 60mm)

#src[AK 2b, PDF-S. 6; ergänzte Zeichenkonventionen nach ISO 5456-3]
]

#aufgabe(titel: "Quader in Isometrie und Dimetrie (Variante)", art: "rechnen", quelle: "3.3", herkunft: "variante", vorlage: "Altklausur WS 20/21, Aufg. 2b", minuten: 8, platz: 14,
  ergebnis: [Isometrie: Zeichenlängen 40/30/20 mm, Platzbedarf ca. 60,6 × 55,0 mm. Dimetrie: 40/15/20 mm, Platzbedarf ca. 50,8 × 34,9 mm],
  tipp: [Platzbedarf waagrecht: Summe der waagrechten Anteile der beiden schrägen Achsen ($l dot cos alpha$); senkrecht: Höhe plus die senkrechten Anteile ($l dot sin alpha$).],
)[
#if not web [*Aufgabe 64* #linebreak()]
*Gegeben und Annahmen*

Ein Quader mit Breite 40 mm, Tiefe 30 mm und Höhe 20 mm soll in technischer Isometrie (Achsen 30°/30°, alle Längen unverkürzt) und in technischer Dimetrie (Breitenachse 7°, Tiefenachse 42°, Tiefe auf die Hälfte verkürzt) gezeichnet werden.

*Gesucht*

#enum(numbering: "a)",
[Welche Längen trägst Du in beiden Darstellungen auf den drei Achsen ab?],
[Wie breit und wie hoch wird jedes Bild auf dem Blatt (umschreibendes Rechteck)?],
[Zeichne beide Darstellungen.],
)
][
*a) Zeichenlängen:* Isometrie: alle Kanten wahre Länge, also 40, 30 und 20 mm. Dimetrie: Breite 40 mm und Höhe 20 mm unverkürzt, Tiefe halbiert auf 15 mm. Warum gerade die Tiefe: Sie läuft steil nach hinten und würde sonst zu lang wirken.
][
*b) Isometrie:* waagrecht $(40 + 30) dot cos 30° = 70 dot "0,866" = "60,6"$ mm; senkrecht $20 + (40 + 30) dot sin 30° = 20 + 35 = "55,0"$ mm.
][
*b) Dimetrie:* waagrecht $40 dot cos 7° + 15 dot cos 42° = "39,7" + "11,1" = "50,8"$ mm; senkrecht $20 + 40 dot sin 7° + 15 dot sin 42° = 20 + "4,9" + "10,0" = "34,9"$ mm.
][
*c) Zeichnen und prüfen:* Von der vorderen unteren Ecke aus die drei Kanten abtragen, mit Parallelen schließen, sichtbare Kanten breit. Prüfen: Die Dimetrie ist flacher, weil die Breitenachse nur 7° ansteigt. Bemaßt würde trotzdem mit den wahren Maßen 40, 30 und 20.
#src[Variante zu AK 2b; Zeichenkonventionen nach ISO 5456-3, eigenes Zahlenbeispiel]
]

#aufgabe(titel: "Bohrung im Würfel isometrisch (Variante)", art: "rechnen", quelle: "3.3", herkunft: "variante", vorlage: "Altklausur WS 20/21, Aufg. 2b", minuten: 8, platz: 14,
  ergebnis: [Isometrie: Ellipse mit Achsen 24,5 mm und 14,1 mm auf allen drei Flächen. Dimetrie: Vorderfläche 21,2 × 18,7 mm, Ober- und Seitenfläche 21,2 × 7,0 mm],
  tipp: [Ein Kreis wird in jeder axonometrischen Ansicht zur Ellipse. Ihre große Achse steht immer senkrecht zu der Achse, die auf der Kreisfläche senkrecht steht.],
)[
#if not web [*Aufgabe 65* #linebreak()]
*Gegeben und Annahmen*

Ein Würfel mit 40 mm Kantenlänge hat auf der Oberseite, der Vorderseite und der rechten Seite je eine Bohrung Ø20 mm, mittig. Faustwerte für die Ellipsen (technische Axonometrie nach ISO 5456-3, Achsen unverkürzt gezeichnet): Isometrie große Achse $"1,22" d$, kleine Achse $"0,71" d$. Dimetrie (7°/42°, Tiefe halbiert): Vorderfläche $"1,06" d$ und $"0,94" d$; Ober- und Seitenfläche $"1,06" d$ und $"0,35" d$.

*Gesucht*

#enum(numbering: "a)",
[Berechne die Ellipsenachsen der Bohrungskanten in der Isometrie.],
[Berechne sie für die Dimetrie, getrennt nach Vorderfläche und Ober-/Seitenfläche.],
[Wie liegt die große Achse der Ellipse auf der Oberseite in der Isometrie?],
)
][
*a) Isometrie:* große Achse $"1,22" dot 20 = "24,4" approx "24,5"$ mm, kleine Achse $"0,71" dot 20 approx "14,1"$ mm, auf allen drei Flächen gleich. Warum gleich: Alle drei Flächen sind in der Isometrie gleich stark geneigt.
][
*b) Dimetrie:* Vorderfläche $"1,06" dot 20 = "21,2"$ mm und $"0,94" dot 20 = "18,8"$ mm (fast ein Kreis, weil die Vorderfläche fast unverzerrt erscheint). Ober- und Seitenfläche $"21,2"$ mm und $"0,35" dot 20 = "7,0"$ mm (sehr flach, weil diese Flächen die verkürzte Tiefenachse enthalten).
][
*c) Lage:* Auf der Oberseite steht die senkrechte Würfelachse auf der Kreisfläche senkrecht, also liegt die große Achse der Ellipse waagrecht. Auf den Seitenflächen ist die große Achse um 60° gegen die Waagrechte geneigt (senkrecht zur jeweils dritten Achse).
][
*Prüfen:* Die große Achse ist in der technischen Isometrie größer als 20 mm, weil die Achsen unverkürzt gezeichnet werden (Vergrößerung um etwa 1,22 gegenüber der echten Projektion). Bemaßt wird weiterhin Ø20.
#src[Variante zu AK 2b; Ellipsenfaktoren nach ISO 5456-3 (eigene Nachrechnung)]
]

#aufgabe(titel: "Symmetrische Teile vereinfacht zeichnen", art: "verstehen", quelle: "3.4", herkunft: "original", vorlage: "Buch Kap. 4, Aufg. 4.14")[
#if not web [*Aufgabe 66* #linebreak()]
Wie können symmetrische Bauteile vereinfacht dargestellt werden? Ist diese Vereinfachung auf rotationssymmetrische Bauteile beschränkt?
][
*Antwort:* Im Buchtext dafür vorgesehen: Halbschnitt (eine Hälfte Ansicht, eine Hälfte Schnitt) und eingeklappte Lochkreise. Ergänzung, nicht im Buchtext erklärt: Nach DIN EN ISO 128-3 darf man symmetrische Teile auch nur zur Hälfte oder zu einem Viertel zeichnen und die Symmetrielinie an den Enden mit zwei kurzen parallelen Strichen kennzeichnen. Das gilt für alle symmetrischen Teile, nicht nur für rotationssymmetrische.

#src[L-alt B1, Frage 14; nach B S. 39–64]
]

#aufgabe(titel: "Vergrößerte Einzelheit kennzeichnen", art: "verstehen", quelle: "3.4", herkunft: "eigen")[
#if not web [*Aufgabe 67* #linebreak()]
Wie kennzeichnest Du eine vergrößerte Einzelheit?
][
*Antwort:* vom Ende des Alphabets.

#src[L-alt B1, offene Überarbeitung Frage 22; B S. 39–64]
]

#aufgabe(titel: "Aneinanderstoßende Schnittflächen und Werkstoffe", art: "verstehen", quelle: "3.5", herkunft: "variante", vorlage: "Buch Kap. 4, Aufg. 4.23")[
#if not web [*Aufgabe 68* #linebreak()]
Wie unterscheidet man in einer Zeichnung zwei aneinanderstoßende geschnittene Teile? Wie kann man Stahl von Glas unterscheiden? (#strong[B Übung 4.23])
][
*Antwort:* Andere Schraffurrichtung (45° bleibt), sonst anderer Abstand. Stahl und Glas: mit unterschiedlichen, vorher definierten Schraffurmustern (Werkstoffschraffur nach Bild 4-15) (S. 50–51).

#src[L-alt B1, Frage 12; nach B S. 39–64]
]

#aufgabe(titel: "Fünf Grundregeln der Schraffur", art: "verstehen", quelle: "3.5", herkunft: "eigen")[
#if not web [*Aufgabe 69* #linebreak()]
Nenne die fünf Grundregeln der Schraffur.
][
*Antwort:* Geneigte Linien; schmal; 45° zur Mittellinie/zum Hauptumriss; gleiches Muster für alle Schnittflächen eines Teils; keine verdeckten Kanten (S. 50).
][
*Kurz gefasst (aus dem Quiz):*
- Schmale Linien, grundsätzlich unter 45°. Zur Mittellinie bzw. zum Hauptumriss.
- Alle Schnittflächen eines Bauteils werden identisch schraffiert, auch in verschiedenen Ansichten. So erkennt man das Teil überall wieder.
][
*Typische Verwechslungen:*
- „Im Schnitt werden verdeckte Kanten gestrichelt mitgezeichnet.“: Im Schnitt werden keine verdeckten Kanten gezeichnet.
- „Aneinanderstoßende Teile bekommen die gleiche Schraffur.“: Sie bekommen eine andere Richtung oder einen anderen Abstand, damit man sie unterscheidet.
][
*Kurz gefasst (aus der Karteikarte):*
- Schmale Linien unter 45° zur Mittellinie oder zum Hauptumriss.
- Alle Schnittflächen eines Teils bekommen dasselbe Muster.
- Aneinanderstoßende Teile werden in verschiedene Richtungen oder mit anderem Abstand schraffiert.
- In geschnittenen Bereichen werden keine verdeckten Kanten gezeichnet.

*Merksatz:* Ein Teil: gleiche Schraffur. Nachbarteil: unterscheidbar.
#bild("b-schnitte", [Bild 4-21: Vollschnitt, Halbschnitt und Teilschnitt. B, S. 53 (PDF-S. 64).], height: 50mm)
#src[L-alt B1, Frage 9; nach B S. 39–64]
]

#aufgabe(titel: "Vollschnitt oder Halbschnitt", art: "verstehen", quelle: "3.5", herkunft: "eigen")[
#if not web [*Aufgabe 70* #linebreak()]
Wann wählt man einen Vollschnitt, wann einen Halbschnitt? Welche Hälfte ist beim Halbschnitt Ansicht?
][
*Antwort:* Vollschnitt bei hohlen Teilen ohne wichtige Außenmerkmale; Halbschnitt bei symmetrischen Teilen, wenn außen auch etwas Darstellenswertes ist. Senkrechte Achse: linke Hälfte Ansicht; waagrechte Achse: obere Hälfte Ansicht (S. 53–54).
][
*Kurz gefasst (aus der Karteikarte):*
- Den Vollschnitt bei hohlen Teilen ohne wichtige Außenmerkmale.
- Den Halbschnitt bei symmetrischen Teilen, die innen und außen etwas Wichtiges zeigen.
- Bei senkrechter Achse ist die linke Hälfte Ansicht, bei waagrechter Achse die obere.
#bild("b-schnitte", [Bild 4-21: Vollschnitt, Halbschnitt und Teilschnitt. B, S. 53 (PDF-S. 64).], height: 50mm)
#src[L-alt B1, Frage 10; nach B S. 39–64]
]

#aufgabe(titel: "Schnitt und Ansicht im Halbschnitt", art: "verstehen", quelle: "3.5", herkunft: "eigen")[
#if not web [*Aufgabe 71* #linebreak()]
Wie werden Schnitt und Ansicht im Halbschnitt getrennt und welche Hälfte wird bei senkrechter Achse geschnitten?
][
*Antwort:* trennt die Mittellinie Schnitt und Ansicht. werden keine verdeckten Kanten gezeichnet. ist bei senkrechter Achse die linke Hälfte Ansicht.
][
*Kurz gefasst (aus dem Quiz):*
- Nur durch die Mittellinie. Bei senkrechter Achse liegt links die Ansicht, bei waagerechter oben.
][
*Typische Verwechslungen:*
- „Durch eine breite Volllinie“: Eine Volllinie wäre eine Körperkante, die es dort nicht gibt.
- „Durch eine Zickzacklinie“: Zickzack- oder Freihandlinien begrenzen Teilschnitte (Ausbrüche).
- „Durch eine schmale Strichlinie“: Die Strichlinie steht für verdeckte Kanten.
#src[L-alt B1, offene Überarbeitung Frage 20; B S. 39–64]
]

#aufgabe(titel: "Drei Ausnahmen im Längsschnitt", art: "verstehen", quelle: "3.6", herkunft: "original", vorlage: "Altklausur WS 20/21, Aufg. 1d", minuten: 3)[
#if not web [*Aufgabe 72* #linebreak()]
Nennen Sie 3 Elemente, die in einer Schnittdarstellung nicht längs geschnitten werden. (3 Punkte)
][
*Klausurantwort:* z. B. Wellen (Vollwellen), Schrauben und Bolzen, Passfedern; außerdem Stifte, Niete, Muttern und Wälzkörper (Kugeln, Rollen). Je Element ein Punkt.
][
*Warum:* Massive Teile ohne innere Form würden im Längsschnitt nur eine große schraffierte Fläche ergeben, die nichts Neues zeigt. Ungeschnitten bleibt die Baugruppe lesbar. Ein Querschnitt, z. B. um eine Passfedernut zu zeigen, ist davon nicht betroffen.

#src[AK 1d, PDF-S. 2; B S. 56]
]

#aufgabe(titel: "Was im Längsschnitt nicht geschnitten wird", art: "verstehen", quelle: "3.6", herkunft: "eigen")[
#if not web [*Aufgabe 73* #linebreak()]
Welche Teile werden im Längsschnitt nicht geschnitten, und warum?
][
*Antwort:* Wellen, Stifte, Bolzen, Passfedern, Keile, Schrauben, Niete, Kugeln. Sie sind voll (ohne Hohlräume), ein Längsschnitt würde nichts Neues zeigen (S. 56).
][
*Kurz gefasst (aus dem Quiz):*
- Wellen. Massive Teile ohne Hohlräume zeigen im Längsschnitt innen nichts Neues.
- Schrauben. Merkhilfe „WeSBo-PaKS-NiKu“: Wellen, Stifte, Bolzen, Passfedern, Keile, Schrauben, Niete, Kugeln.
- Passfedern. Auch sie gehören zur Liste der nicht geschnittenen Teile.
][
*Typische Verwechslungen:*
- „Gehäuse“: Gehäuse sind hohl und werden gerade deshalb geschnitten.
- „Wellen im Querschnitt (Profilschnitt)“: Quer geschnitten wird eine Welle schraffiert.
][
*Kurz gefasst (aus der Karteikarte):*
- Massive Teile wie Wellen, Stifte, Bolzen, Passfedern, Schrauben, Niete und Wälzkörper.
- Ein Längsschnitt würde nichts Neues zeigen und die Baugruppe nur unübersichtlich machen.

*Merksatz:* Längsschnitt durch massive Verbindungsteile bringt oft keinen Zusatznutzen.
#src[L-alt B1, Frage 11; nach B S. 39–64]
]

#aufgabe(titel: "Abgeknickter Schnittverlauf", art: "verstehen", quelle: "3.7", herkunft: "eigen")[
#if not web [*Aufgabe 74* #linebreak()]
Wie wird ein abgeknickter Schnittverlauf gekennzeichnet?
][
*Antwort:* Breite Strich-Punktlinie an Anfang, Ende und jedem Knickpunkt; Pfeile für die Blickrichtung an Anfang und Ende; Großbuchstaben „A–A“ an Anfang/Ende und über der Schnittdarstellung (S. 56–58).
][
*Kurz gefasst (aus der Karteikarte):*
- *Schnittverlauf:* breite Strich-Punktlinie an Anfang, Ende und jedem Knick.
- *Blickrichtung:* Pfeile an Anfang und Ende.
- *Zuordnung:* Großbuchstaben, etwa A–A, an den Enden und über der Schnittdarstellung.
#src[L-alt B1, Frage 13; nach B S. 39–64]
]

#aufgabe(titel: "Gedrehter Profilschnitt", art: "verstehen", quelle: "3.7", herkunft: "eigen")[
#if not web [*Aufgabe 75* #linebreak()]
Wie wird ein in die Ansicht gedrehter Profilschnitt begrenzt?
][
*Antwort:* schmaler Volllinie.

#src[L-alt B1, offene Überarbeitung Frage 21; B S. 39–64]
]


#kapitel("Kapitel 4 · Bemaßung und Dokumentation")

#aufgabe(titel: "GPS und ihre drei Welten", art: "verstehen", quelle: "4.1", herkunft: "eigen")[
#if not web [*Aufgabe 76* #linebreak()]
Was versteht man unter GPS, und welche drei „Welten“ verbindet sie?
][
*Antwort:* Geometrische Produktspezifikation: Gesamtkonzept aller Normen, die Idealgeometrie und zulässige Abweichungen festlegen (Maße, Form, Lage, Oberfläche, Kanten). Sie verbindet Spezifikation, Fertigung und Prüfung (GPS-Matrix mit 18 Merkmalen × 6 Kettengliedern, DIN EN ISO 14638) (S. 65–67).
][
*Kurz gefasst (aus der Karteikarte):*
- Das Gesamtkonzept aller Normen, die Idealgeometrie und zulässige Abweichungen festlegen: Maße, Form, Lage, Oberfläche und Kanten.
- Sie verbindet Spezifikation, Fertigung und Prüfung, damit alle drei dasselbe meinen.
#src[L-alt B2, Frage 1; nach B S. 65–106]
]

#aufgabe(titel: "Normschrift B", art: "verstehen", quelle: "4.2", herkunft: "variante", vorlage: "Buch Kap. 5, Aufg. 5.1")[
#if not web [*Aufgabe 77* #linebreak()]
Was ist die Besonderheit der Normschrift B bei Größe und Linienbreite? (#strong[B Übung 5.1])
][
*Antwort:* Linienbreite = 1/10 der Schrifthöhe; Größen 2,5/3,5/5/7 mm mit Stufensprung √2, damit beim Vergrößern/Verkleinern wieder Normgrößen entstehen (S. 67–68).

#src[L-alt B2, Frage 2; nach B S. 65–106]
]

#aufgabe(titel: "Grundregeln der Maßeintragung", art: "verstehen", quelle: "4.3", herkunft: "original", vorlage: "Buch Kap. 5, Aufg. 5.2, 5.3, 5.4 und 5.5")[
#if not web [*Aufgabe 78* #linebreak()]
#enum(numbering: "a)",
[Welche Maße müssen in einer Technischen Zeichnung eingetragen werden?],
[In welcher Einheit wird grundsätzlich die Maßangabe gemacht?],
[Auf welchen Fertigungszustand beziehen sich die Maßangaben?],
[Wie häufig dürfen Maße wiederholt werden, z. B. in anderen Ansichten?],
)
][
*Antwort:* Alle zur Herstellung nötigen Maße (vollständig), in mm ohne Einheit, bezogen auf den dargestellten Endzustand, jedes Maß nur einmal (S. 69).
][
*Kurz gefasst (aus dem Quiz):*
- Jedes Maß wird nur einmal eingetragen, in nur einer Ansicht. Doppelte Maße können sich widersprechen.
- Maße ohne Einheit gelten in mm, Winkel immer mit Einheit. „45°“ statt „45“.
][
*Typische Verwechslungen:*
- „Maßhilfslinien dürfen über mehrere Ansichten gezogen werden.“: Das ist nicht erlaubt. Maßhilfslinien bleiben in ihrer Ansicht.
- „Maßzahlen müssen von allen vier Seiten lesbar sein.“: Nach DIN EN ISO 129-1 sind sie von unten und von rechts lesbar.
][
*Kurz gefasst (aus der Karteikarte):*
- Alle Maße, die zur Herstellung nötig sind, vollständig.
- In mm ohne Einheit, bezogen auf den dargestellten Endzustand.
- Jedes Maß nur einmal.
- Maßzahlen werden von unten und von rechts gelesen und von keiner Linie gekreuzt.
#bild("b-masshilfslinien", [Bild 5-4: Besondere Maßhilfslinien. B, S. 70 (PDF-S. 81).], height: 50mm)
#src[L-alt B2, Frage 3; nach B S. 65–106]
]

#aufgabe(titel: "Abstände von Maß- und Maßhilfslinien", art: "verstehen", quelle: "4.3", herkunft: "eigen")[
#if not web [*Aufgabe 79* #linebreak()]
Nenne die Abstände: Maßlinie zur Kante, Maßlinien untereinander, Überstand der Maßhilfslinie.
][
*Antwort:* Ca. 10 mm; mindestens 7 mm; 1–2 mm (S. 69).

#src[L-alt B2, Frage 4; nach B S. 65–106]
]

#aufgabe(titel: "Fehler in einer Bemaßung finden", art: "verstehen", quelle: "4.3", herkunft: "eigen")[
#if not web [*Aufgabe 80* #linebreak()]
Finde die Fehler: Auf einer Zeichnung steht „Länge 120 mm“ an einer Maßlinie, „45“ an einem Winkel, das Maß 30 ist in Vorder- und Draufsicht eingetragen, und eine Mittellinie läuft durch die Maßzahl.
][
*Modell / Annahmen:* Bemaßung im Maschinenbau nach den im Kapitel benannten Normen.

„mm“ gehört nicht an die Maßzahl (und kein Wort „Länge“); Winkel braucht die Einheit „45°“; das Maß 30 darf nur einmal eingetragen werden; Maßzahlen dürfen von keiner Linie gekreuzt werden, die Mittellinie wird unterbrochen (S. 69–70).

*Prüfung:* Jedes Funktionsmerkmal ist eindeutig bemaßt und auf denselben Bezug zurückführbar.

#src[L-alt B2, Frage 16; nach B S. 65–106]
]

#aufgabe(titel: "Linienbreite, Leserichtung und Einheit", art: "verstehen", quelle: "4.3", herkunft: "eigen")[
#if not web [*Aufgabe 81* #linebreak()]
Erkläre Linienbreite, Leserichtung und Einheit bei der Maßeintragung.
][
*Antwort:* Maßlinien sind schmale Volllinien. Maßzahlen werden von unten und von rechts gelesen. Winkel brauchen eine Einheit.

#src[L-alt B2, offene Überarbeitung Frage 17; B S. 65–106]
]

#aufgabe(titel: "Warum jedes Maß nur einmal steht", art: "verstehen", quelle: "4.3", herkunft: "eigen")[
#if not web [*Aufgabe 82* #linebreak()]
Warum soll jedes Maß nur einmal in der Zeichnung stehen?
][
*Antwort:*
- Steht ein Maß doppelt, kann es bei einer Änderung nur an einer Stelle angepasst werden, und die Zeichnung widerspricht sich.
- Außerdem bleibt dann unklar, welcher Wert gilt.

*Merksatz:* Ein Maß, eine verbindliche Angabe.
]

#aufgabe(titel: "Drehteil fertigungsgerecht bemaßen", art: "verstehen", quelle: "4.4", herkunft: "eigen")[
#if not web [*Aufgabe 83* #linebreak()]
Wie bemaßt man ein Drehteil fertigungsgerecht? Warum braucht man beim Umspannen zwei Bezugsebenen?
][
*Antwort:* Axiale Maße von einer plangedrehten Bezugsebene aus, radiale als Durchmesser, Fasen/Radien/Einstiche separat. Nach dem Umspannen ist die zweite Stirnseite die neue Bezugsebene, von der aus die Maße dieser Seite abgelesen werden (S. 75–76).
][
*Kurz gefasst (aus dem Quiz):*
- Man braucht zwei Bezugsebenen, je eine pro Aufspannung. Die zweite Stirnseite wird plangedreht und wird zur neuen Bezugsebene.
][
*Typische Verwechslungen:*
- „Alle Maße beziehen sich weiterhin auf eine einzige Bezugsebene.“: Nach dem Umspannen ist die erste Bezugsebene nicht mehr zugänglich.
- „Man bemaßt als Kettenmaße von Absatz zu Absatz.“: Kettenmaße sind prüfbezogen. Fertigungsgerecht wird von Bezugsebenen aus bemaßt.
- „Die radialen Maße werden als Radien angegeben.“: Radial bemaßt man Drehteile als Durchmesser.
][
*Kurz gefasst (aus der Karteikarte):*
- Axiale Maße von einer plangedrehten Bezugsebene aus, radiale Maße als Durchmesser.
- Nach dem Umspannen wird die zweite Stirnseite die neue Bezugsebene.
- So kann der Dreher jedes Maß direkt von der Fläche aus messen, an der er gerade arbeitet.
#bild("alt-b2-2", [Drehteil fertigungsgerecht bemaßt: Längen von der linken Planfläche aus, Durchmesser mit Ø (eigene Skizze, vgl. Bild 5-8) Quelle der Skizze: L-alt B2; eigene Darstellung.], height: 50mm)
#src[L-alt B2, Frage 5; nach B S. 65–106]
]

#aufgabe(titel: "Gewindebohrung bemaßen", art: "verstehen", quelle: "4.4", herkunft: "eigen")[
#if not web [*Aufgabe 84* #linebreak()]
Was wird bei einer Gewindebohrung bemaßt und was nicht?
][
*Antwort:* Bemaßt: Gewinde-Nennmaß (z. B. M8), Tiefe der Kernlochbohrung, nutzbare Gewindelänge, Position. Nicht bemaßt: Kernlochdurchmesser (DIN 13) und Bohrerspitze (120°, nur gezeichnet) (S. 81–82).
][
*Kurz gefasst (aus der Karteikarte):*
- Bemaßt werden Gewinde-Nennmaß (zum Beispiel M8), nutzbare Gewindelänge, Tiefe der Kernlochbohrung und Position.
- Nicht bemaßt werden der Kernlochdurchmesser, weil er aus der Norm folgt, und die 120°-Bohrerspitze.
#bild("alt-b2-2", [Drehteil fertigungsgerecht bemaßt: Längen von der linken Planfläche aus, Durchmesser mit Ø (eigene Skizze, vgl. Bild 5-8) Quelle der Skizze: L-alt B2; eigene Darstellung.], height: 50mm)
#src[L-alt B2, Frage 6; nach B S. 65–106]
]

#aufgabe(titel: "Maße eines Frästeils und Bezugsflächen", art: "verstehen", quelle: "4.4", herkunft: "eigen")[
#if not web [*Aufgabe 85* #linebreak()]
Wie müssen die Maße eines Frästeils zu Werkzeugweg und Bezugsflächen passen?
][
*Antwort:* mittige Nuten brauchen keine Lageangabe. der Fräserweg soll ablesbar sein. Flächen aus dem Werkzeugauslauf werden nicht bemaßt.

#src[L-alt B2, offene Überarbeitung Frage 20; B S. 65–106]
]

#aufgabe(titel: "Klammern und Rahmen an Maßen", art: "verstehen", quelle: "4.5", herkunft: "original", vorlage: "Buch Kap. 5, Aufg. 5.6, 5.7, 5.8, 5.9 und 5.11")[
#if not web [*Aufgabe 86* #linebreak()]
#enum(numbering: "a)",
[Wie wird ein Maß gekennzeichnet, das sich geometrisch aus anderen bestimmen lässt?],
[Wie wird ein Maß als Prüfmaß gekennzeichnet?],
[Was bedeutet ein in eckige Klammern gesetztes Maß?],
[Wie wird ein Maß als theoretisch genaues Maß gekennzeichnet?],
[Was bedeutet ein in einen Rahmen mit runden Ecken gesetztes Maß?],
)
][
*Antwort:* ( ) Hilfsmaß, ergibt sich aus anderen Maßen; \[ \] Roh- oder Vorbearbeitungsmaß; runder Rahmen: Prüfmaß; rechteckiger Rahmen: theoretisch genaues Maß ohne Toleranz (S. 86–91).
][
*Kurz gefasst (aus der Karteikarte):*
- ( ) Hilfsmaß: ergibt sich aus anderen Maßen, nur zur Information.
- [ ] Roh- oder Vorbearbeitungsmaß.
- *Rahmen mit runden Ecken:* Prüfmaß.
- *Rechteckiger Rahmen:* theoretisch genaues Maß ohne Toleranz.
#src[L-alt B2, Frage 7; nach B S. 65–106]
]

#aufgabe(titel: "Maßzeichen Ø, M, Tr, R, S, SW und Co.", art: "verstehen", quelle: "4.5", herkunft: "variante", vorlage: "Buch Kap. 5, Aufg. 5.12 und 5.13")[
#if not web [*Aufgabe 87* #linebreak()]
Was bedeuten die Zeichen Ø, M, Tr, R, S, SR, SW, □, t = 5? (#strong[B Übung 5.12/5.13])
][
*Antwort:* Ø Durchmesser; M metrisches ISO-Gewinde; Tr Trapezgewinde; R Radius; S Kugel (SØ Kugeldurchmesser); SR Kugelradius; SW Schlüsselweite; □ Quadrat; t = 5 Dicke 5 mm (S. 82–90).

#src[L-alt B2, Frage 8; nach B S. 65–106]
]

#aufgabe(titel: "Wann eine Fase als 2 × 45° gilt", art: "verstehen", quelle: "4.5", herkunft: "eigen")[
#if not web [*Aufgabe 88* #linebreak()]
Wann darf man eine Fase als „2 × 45°“ angeben, wann nicht?
][
*Antwort:* Nur bei 45°-Fasen dürfen Länge und Winkel gemeinsam stehen („2 × 45°“). Bei anderen Winkeln getrennt: Länge und Winkel (S. 89).
][
*Kurz gefasst (aus dem Quiz):*
- Nur bei 45°. Nur dann dürfen Länge und Winkel zusammen stehen.
][
*Typische Verwechslungen:*
- „Bei jedem Fasenwinkel“: Bei anderen Winkeln werden Länge und Winkel getrennt angegeben.
- „Nur bei Bohrungen“: Die Regel gilt für Außen- und Innenfasen.
- „Nie, Fasen werden über Kantensymbole angegeben“: Definierte Fasen werden normal bemaßt. Kantensymbole sind für undefinierte Kantenformen.
][
*Kurz gefasst (aus der Karteikarte):*
- Nur bei 45°-Fasen, weil dort beide Schenkel gleich lang sind.
- Bei anderen Winkeln stehen Länge und Winkel getrennt.
#src[L-alt B2, Frage 9; nach B S. 65–106]
]

#aufgabe(titel: "Rohmaß und Hilfsmaß", art: "verstehen", quelle: "4.5", herkunft: "eigen")[
#if not web [*Aufgabe 89* #linebreak()]
Worin unterscheiden sich ein Rohmaß in eckigen Klammern und ein Hilfsmaß in runden Klammern?
][
*Antwort:* ein Rohmaß.
][
*Kurz gefasst (aus dem Quiz):*
- Hilfsmaß, das sich aus anderen Maßen ergibt und nur zur Information dient. Es ist nicht maßgeblich, Allgemeintoleranzen gelten dafür nicht.
][
*Typische Verwechslungen:*
- „Rohmaß“: Rohmaße stehen in eckigen Klammern.
- „Prüfmaß“: Prüfmaße stehen in einem Rahmen mit runden Ecken.
- „Theoretisch genaues Maß“: Das steht in einem rechteckigen Rahmen.
#src[L-alt B2, offene Überarbeitung Frage 18; B S. 65–106]
]

#aufgabe(titel: "Bemaßungsarten und Schriftfeld aus der Altklausur", art: "verstehen", quelle: "4.6", herkunft: "original", vorlage: "Altklausur WS 20/21, Aufg. 1h und 1i", minuten: 6)[
#if not web [*Aufgabe 90* #linebreak()]
#enum(numbering: "a)",
[Nennen Sie für die dargestellten Zeichnungen den zugehörigen Fachbegriff für die Art der Bemaßung. (3 Punkte)
#align(center)[#image("abbildungen/ak-bemassungsarten.png", width: 100%)]
#text(size: 8.4pt, fill: muted)[Originalausschnitt AK, PDF-S. 4.]],
[Nennen Sie 4 Angaben im Schriftfeld einer Technischen Zeichnung. (4 Punkte)],
)
][
*a) Bild 1 – Kettenbemaßung:* Die Maße 15 und 20 schließen aneinander an, jedes Maß beginnt dort, wo das vorige endet.
][
*a) Bild 2 – Parallelbemaßung:* Die Maße 15 und 35 gehen beide von derselben Bezugskante (linke Kante) aus; die Maßlinien liegen parallel übereinander.
][
*a) Bild 3 – steigende Bemaßung:* Eine einzige Maßlinie vom Ursprung (Bezugskante) aus; die Maßzahlen stehen an den Maßhilfslinien der einzelnen Bohrungen. Sie hat den Vorteil der Parallelbemaßung (ein Bezug) bei weniger Platzbedarf.
][
*b) Schriftfeld:* z. B. Benennung (Titel), Sachnummer/Zeichnungsnummer, Ersteller (Name) und Datum, Freigabe/genehmigende Person, Maßstab, Werkstoff, Blattnummer, Eigentümer (Firma), Ausgabedatum.

#src[AK 1h/1i, PDF-S. 4; B S. 94–95, 98–101]
]

#aufgabe(titel: "Parallel-, steigende und Koordinatenbemaßung", art: "verstehen", quelle: "4.6", herkunft: "eigen")[
#if not web [*Aufgabe 91* #linebreak()]
Erkläre Parallel-, steigende und Koordinatenbemaßung. Wofür ist die Koordinatenbemaßung praktisch?
][
*Antwort:* Parallel: alle Maßlinien parallel bzw. konzentrisch. Steigend: eine Maßlinie je Richtung ab Ursprung 0, Pfeile an jeder Maßhilfslinie. Koordinaten: Punkte als x/y- oder Polarkoordinaten, oft in Tabelle; vereinfacht die NC-Programmierung (S. 94–95).
][
*Kurz gefasst (aus der Karteikarte):*
- *Für die NC-Programmierung:* Alle Punkte stehen als Koordinaten von einem Ursprung aus, oft in einer Tabelle.
- Die Maschine braucht genau diese Werte.
#bild("b-bemassungsarten", [Bilder 5-37/5-38: Parallel- und steigende Bemaßung. B, S. 94 (PDF-S. 105).], height: 50mm)
#src[L-alt B2, Frage 10; nach B S. 65–106]
]

#aufgabe(titel: "Teilungsangabe für acht Bohrungen", art: "verstehen", quelle: "4.6", herkunft: "eigen")[
#if not web [*Aufgabe 92* #linebreak()]
Ein Flansch hat 8 Bohrungen Ø9 gleichmäßig auf einem Lochkreis Ø100. Wie lautet die vereinfachte Teilungsangabe für die Winkel (erste bis letzte Bohrung)?
][
*Modell / Annahmen:* Bemaßung im Maschinenbau nach den im Kapitel benannten Normen.

Teilung = 360° / 8 = 45°;  von der 

1. bis zur 8. Bohrung: 7 Teilungen
Angabe: 7 × 45° (= 315°), dazu 8 × Ø9 und Lochkreis Ø100

*Prüfung:* Jedes Funktionsmerkmal ist eindeutig bemaßt und auf denselben Bezug zurückführbar.

#src[L-alt B2, Frage 14; nach B S. 65–106]
]

#aufgabe(titel: "Was wohin auf die Zeichnung gehört", art: "verstehen", quelle: "4.7", herkunft: "variante", vorlage: "Buch Kap. 5, Aufg. 5.15")[
#if not web [*Aufgabe 93* #linebreak()]
Ordne zu (vgl. Übung 5.15): Wo stehen a) „Werkstoff S235JR“, b) „Maßstab 1:1“, c) „ISO 2768-mK“, d) Name des Erstellers, e) Sachnummer 311.234, f) Änderung einer Länge von 50 auf 70 mm?
][
*Modell / Annahmen:* Bemaßung im Maschinenbau nach den im Kapitel benannten Normen.

a) Werkstoff im Schriftfeld bzw. seiner Erweiterung; b) Maßstab in der Schriftfeld-Erweiterung (kein Pflichtfeld); c) Allgemeintoleranzen nahe/in der Erweiterung des Schriftfelds; d) Ersteller: Pflichtfeld im Schriftfeld; e) Sachnummer: Pflichtfeld; der Ersatzvermerk „ersetzt 311.200“ zusätzlich; f) an der Maßstelle mit Änderungszeichen (Buchstabe im Kreis), Änderungsindex im Schriftfeld erhöhen.

*Prüfung:* Jedes Funktionsmerkmal ist eindeutig bemaßt und auf denselben Bezug zurückführbar.

#src[L-alt B2, Frage 15; nach B S. 65–106]
]

#aufgabe(titel: "Pflichtfelder des Schriftfelds", art: "verstehen", quelle: "4.7", herkunft: "eigen")[
#if not web [*Aufgabe 94* #linebreak()]
Nenne die Pflichtfelder des Schriftfelds nach DIN EN ISO 7200.
][
*Antwort:* Gesetzlicher Eigentümer, Sachnummer, Ausgabedatum, Blattnummer, Titel, genehmigende Person, Ersteller, Dokumentenart (S. 99–100).
][
*Kurz gefasst (aus dem Quiz):*
- Sachnummer und Titel. Gehören zu den identifizierenden und beschreibenden Pflichtfeldern.
- Ersteller und genehmigende Person. Administrative Pflichtfelder. Merkhilfe „ESAB-T-GED“.
- Ausgabedatum und Blattnummer. Beide sind identifizierende Pflichtfelder.
][
*Typische Verwechslungen:*
- „Maßstab“: Der Maßstab ist kein Pflichtfeld, er steht außerhalb oder in einer Erweiterung.
- „Projektionsmethode“: Auch sie gehört nicht zu den Pflichtfeldern.
#src[L-alt B2, Frage 11; nach B S. 65–106]
]

#aufgabe(titel: "Identifikationsfelder im Schriftfeld", art: "verstehen", quelle: "4.7", herkunft: "eigen")[
#if not web [*Aufgabe 95* #linebreak()]
Nenne wichtige verpflichtende Identifikationsfelder eines Schriftfelds nach dem Buchbeispiel.
][
*Antwort:* Titel. Sachnummer. Ersteller.

#src[L-alt B2, offene Überarbeitung Frage 19; B S. 65–106]
]

#aufgabe(titel: "Lose Stückliste und Stückliste auf der Zeichnung", art: "verstehen", quelle: "4.8", herkunft: "original", vorlage: "Buch Kap. 5, Aufg. 5.19")[
#if not web [*Aufgabe 96* #linebreak()]
Was muss berücksichtigt werden bei einer „losen“ Stückliste im Gegensatz zu einer, die in der Technischen Zeichnung mitangegeben wird?
][
*Antwort:* Lose Stückliste: eigene A4-Blätter, Überschrift oben, von oben nach unten gefüllt, muss bei Zeichnungsänderungen mitgepflegt werden, weil sie auf die Zeichnung verweist. Auf der Zeichnung: auf dem Schriftfeld, Überschrift unten, von unten nach oben (S. 102).

#src[L-alt B2, Frage 12; nach B S. 65–106]
]

#aufgabe(titel: "Kleine und große Zeichnungsänderungen", art: "verstehen", quelle: "4.8", herkunft: "eigen")[
#if not web [*Aufgabe 97* #linebreak()]
Wie geht man bei kleinen und bei großen Zeichnungsänderungen vor?
][
*Antwort:* Klein: an der Stelle kennzeichnen (Buchstabe im Kreis), Änderungsindex/Ausgabedatum anpassen. Groß: neue Zeichnung, alte als „zurückgezogen“ kennzeichnen, lose Stückliste anpassen. Nach Freigabe/Verteilung zusätzlich betriebsinterne Abläufe (S. 102).
][
*Kurz gefasst (aus der Karteikarte):*
- *Klein:* Die Stelle mit einem Buchstaben im Kreis kennzeichnen und Änderungsindex und Datum anpassen.
- *Groß:* neue Zeichnung erstellen, die alte als »zurückgezogen« kennzeichnen und die lose Stückliste anpassen.
#src[L-alt B2, Frage 13; nach B S. 65–106]
]


#kapitel("Kapitel 5 · Oberflächen und Kanten")

#aufgabe(titel: "Warum nicht überall feine Rauheit", art: "verstehen", quelle: "5.1", herkunft: "eigen")[
#if not web [*Aufgabe 98* #linebreak()]
Warum schreibt man nicht einfach auf alle Flächen eine feine Rauheit?
][
*Antwort:*
- Jede feinere Oberfläche kostet Bearbeitungszeit.
- Flächen ohne Funktion können roh bleiben.
- Fein sein müssen nur Funktionsflächen wie Lagersitze, Dichtflächen oder Zentrierungen.
- *Das Motto ist:* so grob wie möglich, so fein wie nötig.

*Merksatz:* So grob wie möglich, so fein wie nötig.
]

#aufgabe(titel: "Gestaltabweichungen erster bis fünfter Ordnung", art: "verstehen", quelle: "5.2", herkunft: "eigen")[
#if not web [*Aufgabe 99* #linebreak()]
Nenne die Gestaltabweichungen 1. bis 5. Ordnung. Welche davon zählen zur Rauheit?
][
*Antwort:* Formabweichung, 2. Welligkeit, 3. Rillen, 4. Riefen/Schuppen/Kuppen, 5. Gefügestruktur. Rauheit = 3. bis 5. Ordnung (S. 108–110).
][
*Kurz gefasst (aus der Karteikarte):*
- *1. Ordnung:* Formabweichung.
- *2. Ordnung:* Welligkeit.
- *3. Ordnung:* Rillen.
- *4. Ordnung:* Riefen, Schuppen und Kuppen.
- *5. Ordnung:* Gefügestruktur.
- Zur Rauheit zählen hier die *3. bis 5. Ordnung*.
#src[L-alt C1, Frage 1; nach B S. 107–130]
]

#aufgabe(titel: "Geometrische, wirkliche und Istoberfläche", art: "verstehen", quelle: "5.2", herkunft: "eigen")[
#if not web [*Aufgabe 100* #linebreak()]
Was unterscheidet geometrische Oberfläche, wirkliche Oberfläche und Istoberfläche?
][
*Antwort:* Geometrisch: ideal laut Zeichnung. Wirklich: tatsächlich vorhandene Grenze zwischen Werkstück und Umgebung. Ist: gemessenes, angenähertes Abbild der wirklichen Oberfläche (S. 108–109).

#src[L-alt C1, Frage 2; nach B S. 107–130]
]

#aufgabe(titel: "P-, W- und R-Profil", art: "verstehen", quelle: "5.2", herkunft: "eigen")[
#if not web [*Aufgabe 101* #linebreak()]
Wie entstehen P-, W- und R-Profil? Was ist der Unterschied zwischen Einzelmessstrecke und Messstrecke?
][
*Antwort:* Das gemessene Primärprofil (P) wird gefiltert: langwellige Anteile ergeben das Welligkeitsprofil (W), kurzwellige das Rauheitsprofil (R). Die Einzelmessstrecke ist die Auswertelänge für einen Kennwert; die Messstrecke besteht im Regelfall aus 5 Einzelmessstrecken (S. 110, 115).
][
*Kurz gefasst (aus der Karteikarte):*
- Das gemessene Primärprofil (P) wird gefiltert.
- Die langwelligen Anteile ergeben das Welligkeitsprofil (W), die kurzwelligen das Rauheitsprofil (R).

*Merksatz:* P ist das Ausgangsprofil; W langwellig, R kurzwellig.
#src[L-alt C1, Frage 3; nach B S. 107–130]
]

#aufgabe(titel: "Rp, Rv, Rz und Rt", art: "verstehen", quelle: "5.3", herkunft: "eigen")[
#if not web [*Aufgabe 102* #linebreak()]
Definiere Rp, Rv, Rz und Rt. Wann sind Rz und Rt verschieden?
][
*Antwort:* Rp größte Spitze, Rv tiefstes Tal, Rz = Rp + Rv je Einzelmessstrecke, Rt = Rp + Rv über die ganze Messstrecke. Rt ist größer, wenn die höchste Spitze oder das tiefste Tal außerhalb der betrachteten Einzelmessstrecke liegt; ohne andere Angabe gelten sie als identisch (S. 110–111).

#src[L-alt C1, Frage 4; nach B S. 107–130]
]

#aufgabe(titel: "Ra anschaulich und der einzelne Kratzer", art: "verstehen", quelle: "5.3", herkunft: "eigen")[
#if not web [*Aufgabe 103* #linebreak()]
Was beschreibt Ra anschaulich? Warum reagiert Rz stärker auf einen einzelnen Kratzer als Ra?
][
*Antwort:* Ra ist die Höhe eines Rechtecks mit gleicher Fläche wie alle Flächen zwischen Profil und Mittellinie. Ra mittelt über alle Punkte, ein einzelner Kratzer fällt kaum ins Gewicht; Rz wird direkt aus dem tiefsten Tal bestimmt (S. 110–111).
][
*Kurz gefasst (aus der Karteikarte):*
- Ra mittelt über alle Punkte, ein einzelner Kratzer fällt kaum ins Gewicht.
- Rz nimmt direkt das tiefste Tal und die höchste Spitze, ein Kratzer geht also voll ein.

*Merksatz:* Ra mittelt, Rz reagiert stärker auf tiefe Einzelstellen.
#bild("b-rauheit", [Bild 6-3: Profilspitze, Profiltal und Rautiefe. B, S. 111 (PDF-S. 122).], height: 50mm)
][
*Bild:* Ra ist der Notendurchschnitt der Klasse, Rz die Differenz zwischen bester und schlechtester Note.
#src[L-alt C1, Frage 5; nach B S. 107–130]
]

#aufgabe(titel: "Ra, Rz oder RSm", art: "verstehen", quelle: "5.3", herkunft: "eigen")[
#if not web [*Aufgabe 104* #linebreak()]
Für welche Profile verwendet man Ra/Rz und für welche RSm? Nenne je ein Fertigungsverfahren.
][
*Antwort:* Ra/Rz: aperiodische Profile (Schleifen, Erodieren). RSm: periodische Profile (Drehen, Fräsen, Stoßen) (S. 112).

#src[L-alt C1, Frage 6; nach B S. 107–130]
]

#aufgabe(titel: "Rz nach ISO 4287 und Rt", art: "verstehen", quelle: "5.3", herkunft: "eigen")[
#if not web [*Aufgabe 105* #linebreak()]
Definiere Rz nach der im Buch erläuterten älteren ISO-4287-Auswertung und grenze es von Rt ab.
][
*Antwort:* Rz = Rp + Rv innerhalb einer Einzelmessstrecke. Rz entspricht dem früheren Ry. Rz bezieht sich auf das Rauheitsprofil.
][
*Kurz gefasst (aus der Karteikarte):*
- Beide sind höchste Spitze plus tiefstes Tal.
- Rz gilt für eine Einzelmessstrecke, Rt für die ganze Messstrecke.
- Rt ist größer, wenn das Extrem außerhalb der betrachteten Einzelmessstrecke liegt.
#bild("b-rauheit", [Bild 6-3: Profilspitze, Profiltal und Rautiefe. B, S. 111 (PDF-S. 122).], height: 50mm)
#src[L-alt C1, offene Überarbeitung Frage 24; B S. 107–130]
]

#aufgabe(titel: "Rz und Ra eines Rechteckprofils ±2 µm", art: "verstehen", quelle: "5.3", herkunft: "eigen")[
#if not web [*Aufgabe 106* #linebreak()]
Ein Profil springt regelmäßig zwischen +2 µm und −2 µm (Rechteckprofil). Wie groß sind Rz und Ra? Begründe deine Antwort.
][
*Antwort:*
- Rz = 4 µm, Ra = 2 µm. $R_z = 2 + 2 = 4$ µm. Der Betrag des Abstands ist überall 2 µm, also $R_a = 2$ µm.
][
*Typische Verwechslungen:*
- „Rz = 2 µm, Ra = 2 µm“: Rz ist die Summe aus Spitze und Tal: $R_z = R_p + R_v = 4$ µm.
- „Rz = 4 µm, Ra = 1 µm“: Ra = 1 µm gilt für ein Dreiecksprofil mit gleichem Rz. Ra und Rz lassen sich nicht ineinander umrechnen.
- „Rz = 4 µm, Ra = 0 µm“: Ra mittelt die Beträge, deshalb heben sich positive und negative Werte nicht auf.
]

#aufgabe(titel: "Rz und Rt aus Spitzen und Tälern", art: "rechnen", quelle: "5.3", herkunft: "eigen",
  ergebnis: [Rz = 8 µm (diese Einzelmessstrecke), Rt = 11 µm],
  tipp: [Rz schaut in eine Einzelmessstrecke, Rt auf die ganze Messstrecke.],
)[
#if not web [*Aufgabe 107* #linebreak()]
*Gegeben und Annahmen*

Ein Profil hat in einer Einzelmessstrecke die höchste Spitze 3,5 µm über und das tiefste Tal 4,5 µm unter der Mittellinie. Auf der ganzen Messstrecke liegt die höchste Spitze bei 5 µm, das tiefste Tal bei 6 µm.

*Gesucht*

#enum(numbering: "a)",
[Bestimme Rz (dieser Einzelmessstrecke) und Rt.],
)
][
*Bild:* Stell dir das Profil als Gebirge um eine Mittellinie vor. Rz misst den Abstand zwischen höchstem Gipfel und tiefstem Tal in einem Ausschnitt. Rt macht dasselbe über die ganze Strecke.
][
*Rz dieser Einzelmessstrecke:* $R_z = R_p + R_v = "3,5" + "4,5" = 8 thin "µm"$.
][
*Rt der ganzen Messstrecke:* Höchste Spitze plus tiefstes Tal irgendwo auf der Strecke: $R_t = 5 + 6 = 11 thin "µm"$.
][
*Prüfen:* Rt ist nie kleiner als Rz, weil es den größeren Bereich absucht. Hier ist Rt > Rz, weil Spitze und Tal der ganzen Strecke außerhalb dieser Einzelmessstrecke liegen.
#src[L-alt C1, Frage 17; nach B S. 107–130]
]

#aufgabe(titel: "Ra und Rz eines Rechteckprofils", art: "rechnen", quelle: "5.3", herkunft: "eigen",
  ergebnis: [Ra = 1,5 µm, Rz = 3 µm],
  tipp: [Ra ist der Mittelwert der Beträge der Abweichung von der Mittellinie.],
)[
#if not web [*Aufgabe 108* #linebreak()]
*Gegeben und Annahmen*

Ein ideales Rechteckprofil wechselt gleichmäßig zwischen +1,5 µm und −1,5 µm.

*Gesucht*

#enum(numbering: "a)",
[Berechne Ra und Rz.],
)
][
*Bild:* Das Profil liegt immer genau 1,5 µm über oder unter der Mittellinie, nie dazwischen.
][
*Ra:* Ra mittelt den Betrag $abs(y(x))$. Der ist überall 1,5 µm, also $R_a = "1,5" thin "µm"$.
][
*Rz:* Spitze 1,5 µm plus Tal 1,5 µm: $R_z = 3 thin "µm"$.
][
*Prüfen:* Beim Rechteckprofil ist $R_z = 2 R_a$. Bei echten Oberflächen mit einzelnen Spitzen ist Rz meist viel größer als 2 Ra.
#src[L-alt C1, Frage 18; nach B S. 107–130]
]

#aufgabe(titel: "Ra und Rz bei ±3 µm", art: "rechnen", quelle: "5.3", herkunft: "eigen",
  ergebnis: [Ra = 3 µm, Rz = 6 µm],
  tipp: [Wie beim Rechteckprofil mit ±1,5 µm, nur mit doppelter Höhe.],
)[
#if not web [*Aufgabe 109* #linebreak()]
*Gegeben und Annahmen*

Ein ideales Rechteckprofil springt zwischen +3 µm und −3 µm.

*Gesucht*

#enum(numbering: "a)",
[Berechne Ra und Rz (Kapitel 5, S. 109–111).],
)
][
*Bild:* Das Profil steht überall genau 3 µm von der Mittellinie weg.
][
*Ra:* Der Betrag der Abweichung ist überall 3 µm, also $R_a = 3 thin "µm"$.
][
*Rz:* Höchste Spitze plus tiefstes Tal: $R_z = 3 + 3 = 6 thin "µm"$.
][
*Prüfen:* Doppelte Profilhöhe gibt doppelte Kennwerte, verglichen mit ±1,5 µm.
#src[L-alt S2; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

#aufgabe(titel: "Drei Oberflächensymbole", art: "verstehen", quelle: "5.4", herkunft: "eigen")[
#if not web [*Aufgabe 110* #linebreak()]
Erkläre die drei Oberflächensymbole nach DIN EN ISO 1302. Was ändert sich nach DIN EN ISO 21920-1?
][
*Antwort:* Mit Linie am langen Schenkel: alle Verfahren zulässig. Zusätzlich Linie am kurzen Schenkel: Materialabtrag gefordert. Kreis: Materialabtrag unzulässig. 21920-1: ein zusätzlicher Balken, immer das vollständige Symbol, kein Grundsymbol und kein Rundum-Kreis mehr (S. 113).
][
*Kurz gefasst (aus dem Quiz):*
- Grundsymbol mit zusätzlicher Linie am kurzen Schenkel (geschlossenes Dreieck). Im Text abgekürzt als MRR.
][
*Typische Verwechslungen:*
- „Grundsymbol mit Kreis zwischen den Schenkeln“: Der Kreis bedeutet: Materialabtrag unzulässig.
- „Grundsymbol ohne Zusatz“: Allein bedeutet es nur, dass an die Fläche Anforderungen gestellt werden.
- „Grundsymbol mit Kreis an der Ecke“: Der Kreis an der Ecke bedeutet „rundum“.
][
*Kurz gefasst (aus der Karteikarte):*
- *Nur Linie am langen Schenkel:* alle Fertigungsverfahren zulässig.
- *Zusätzlicher Querstrich:* Materialabtrag gefordert.
- *Kreis im Symbol:* Materialabtrag unzulässig, die Fläche bleibt zum Beispiel im Gusszustand.

*Merksatz:* Querstrich fordert Abtrag, Kreis verbietet Abtrag.
#bild("alt-c1-2", [Symbole nach DIN EN ISO 1302 (eigene Skizze, vgl. Bild 6-7, S. 113); nach DIN EN ISO 21920-1 kommt ein zusätzlicher Balken hinzu (Bild 6-8) Quelle der Skizze: L-alt C1; eigene Darstellung.], height: 50mm)
#src[L-alt C1, Frage 7; nach B S. 107–130]
]

#aufgabe(titel: "Kreis im Oberflächensymbol", art: "verstehen", quelle: "5.4", herkunft: "eigen")[
#if not web [*Aufgabe 111* #linebreak()]
Was fordert ein Kreis zwischen den Schenkeln eines Oberflächensymbols?
][
*Antwort:* Materialabtrag unzulässig. Oberfläche bleibt z. B. im Gusszustand.

#src[L-alt C1, offene Überarbeitung Frage 25; B S. 107–130]
]

#aufgabe(titel: "Oberflächenangabe für spanlose Fläche", art: "verstehen", quelle: "5.5", herkunft: "original", vorlage: "Buch Kap. 6, Aufg. 6.17")[
#if not web [*Aufgabe 112* #linebreak()]
Wie erfolgt die Angabe der Oberflächenbeschaffenheit für eine spanlos hergestellte Oberfläche mit gemittelter Rautiefe Rz = 2,5 µm bis 4,5 µm?
][
*Modell / Annahmen:* Genannte Profilform und Normfassung; Längen des Profils und Höhen einheitlich behandeln.

Symbol mit #strong[Kreis] (Materialabtrag unzulässig) und zwei Werten übereinander: oben „Rz  4,5“, unten „Rz  2,5“ (gleiche Kenngröße, U/L dürfen entfallen; sonst „U Rz 4,5“ / „L Rz 2,5“) (S. 113, 115).

*Prüfung:* Ra und Rz sind Höhenwerte in µm; die genannte Normfassung und Auswertelänge müssen passen.

#src[L-alt C1, Frage 19; nach B S. 107–130]
]

#aufgabe(titel: "Oberflächenangabe für verzinkte Fläche", art: "verstehen", quelle: "5.5", herkunft: "original", vorlage: "Buch Kap. 6, Aufg. 6.18")[
#if not web [*Aufgabe 113* #linebreak()]
Wie erfolgt die Angabe der Oberflächenbeschaffenheit für eine beliebig hergestellte (spanlos oder spanend), verzinkte Oberfläche mit einem Mittenrauwert Ra ≤ 25 µm?
][
*Modell / Annahmen:* Genannte Profilform und Normfassung; Längen des Profils und Höhen einheitlich behandeln.

Symbol „alle Verfahren zulässig“ (nur Linie am langen Schenkel), Position a „Ra  25“ (einseitig = obere Grenze), Position c „verzinkt“ (S. 113–117).

*Prüfung:* Ra und Rz sind Höhenwerte in µm; die genannte Normfassung und Auswertelänge müssen passen.

#src[L-alt C1, Frage 20; nach B S. 107–130]
]

#aufgabe(titel: "Rauheit für Außenfläche, Lagersitz, Dichtfläche", art: "verstehen", quelle: "5.5", herkunft: "variante", vorlage: "Buch Kap. 6, Aufg. 6.21")[
#if not web [*Aufgabe 114* #linebreak()]
Welche Grenzwerte forderst du für a) eine funktionslose Außenfläche, b) einen Wälzlagersitz auf einer Welle, c) eine dynamische Dichtfläche (Buch 6.21)?
][
*Modell / Annahmen:* Genannte Profilform und Normfassung; Längen des Profils und Höhen einheitlich behandeln.

a) Rz \> 100 µm bzw. Ra \> 12,5 µm (keine Angabe nötig, außer Sammelangabe). b) Rz ≤ 6,3 µm, Ra ≤ 1,6 µm. c) Rz 4–6,3 µm, Ra 0,4–0,8 µm (S. 117).

*Prüfung:* Ra und Rz sind Höhenwerte in µm; die genannte Normfassung und Auswertelänge müssen passen.

#src[L-alt C1, Frage 21; nach B S. 107–130]
]

#aufgabe(titel: "Positionen a bis e am Oberflächensymbol", art: "verstehen", quelle: "5.5", herkunft: "eigen")[
#if not web [*Aufgabe 115* #linebreak()]
Was steht auf den Positionen a bis e am Oberflächensymbol? In welcher Einheit steht die Bearbeitungszugabe?
][
*Antwort:* a: Filter/Einzelmessstrecke, Kenngröße, Grenzwert; b: weitere Anforderung; c: Verfahren, Behandlung, Beschichtung; d: Rillenrichtung; e: Bearbeitungszugabe in mm (S. 114, 117).

#src[L-alt C1, Frage 8; nach B S. 107–130]
]

#aufgabe(titel: "Zwei Leerzeichen hinter Rz1", art: "verstehen", quelle: "5.5", herkunft: "eigen")[
#if not web [*Aufgabe 116* #linebreak()]
Warum stehen zwischen „Rz1“ und dem Grenzwert zwei Leerzeichen?
][
*Antwort:* Damit die Anzahl der Einzelmessstrecken (z. B. 1) nicht mit dem Grenzwert verwechselt wird: „Rz1  3,2“ statt „Rz 13,2“ (S. 115).
][
*Kurz gefasst (aus der Karteikarte):*
- Damit die Anzahl der Einzelmessstrecken nicht mit dem Grenzwert verwechselt wird: »Rz1  3,2« statt »Rz 13,2«.
#bild("b-symbolpositionen", [Bild 6-10: Positionen am älteren Oberflächensymbol nach ISO 1302. B, S. 114 (PDF-S. 125).], height: 50mm)
#src[L-alt C1, Frage 9; nach B S. 107–130]
]

#aufgabe(titel: "Obere und untere Rauheitsgrenze", art: "verstehen", quelle: "5.5", herkunft: "eigen")[
#if not web [*Aufgabe 117* #linebreak()]
Wie begrenzt man eine Oberfläche nach oben und nach unten? Wann braucht man „U“ und „L“?
][
*Antwort:* Zwei Werte übereinander, der größere oben. „U“ (upper) und „L“ (lower) sind nötig, wenn verschiedene Kenngrößen verwendet werden; bei gleicher Kenngröße dürfen sie entfallen (S. 115).

#src[L-alt C1, Frage 10; nach B S. 107–130]
]

#aufgabe(titel: "Die 16-%-Regel", art: "verstehen", quelle: "5.5", herkunft: "eigen")[
#if not web [*Aufgabe 118* #linebreak()]
Was besagt die 16 %-Regel, und wann gilt sie? Was gilt ohne Angabe nach DIN EN ISO 21920-1?
][
*Antwort:* Nach DIN EN ISO 1302 ohne Zusatzangabe: annehmbar, wenn höchstens 16 % aller Messwerte den Grenzwert überschreiten. Nach 21920-1 gilt ohne Angabe Tmax: keine Überschreitung (S. 116).
][
*Kurz gefasst (aus dem Quiz):*
- Nach DIN EN ISO 1302 die 16-%-Regel, nach DIN EN ISO 21920-1 die Tmax-Regel. Der Standard hat sich umgedreht: alt tolerant, neu streng.
][
*Typische Verwechslungen:*
- „Nach beiden Normen die 16-%-Regel“: Die neue Norm verlangt ohne Angabe Tmax, keine Überschreitung.
- „Nach beiden Normen die max-Regel“: In der alten Norm musste „max“ ausdrücklich angegeben werden.
- „Nach DIN EN ISO 1302 die Tmax-Regel, nach 21920-1 die 16-%-Regel“: Genau vertauscht.
][
*Kurz gefasst (aus der Karteikarte):*
- Nach der älteren DIN EN ISO 1302 ist eine Fläche annehmbar, wenn höchstens 16 % der Messwerte den Grenzwert überschreiten.
- Nach DIN EN ISO 21920-1 gilt ohne Angabe Tmax, also darf kein Messwert überschreiten.
- Deshalb muss man wissen, nach welcher Normfassung die Zeichnung erstellt ist.
#bild("b-symbolpositionen", [Bild 6-10: Positionen am älteren Oberflächensymbol nach ISO 1302. B, S. 114 (PDF-S. 125).], height: 50mm)
#src[L-alt C1, Frage 11; nach B S. 107–130]
]

#aufgabe(titel: "Fertigungsverfahren in der Vergangenheitsform", art: "verstehen", quelle: "5.5", herkunft: "eigen")[
#if not web [*Aufgabe 119* #linebreak()]
Warum steht das Fertigungsverfahren auf Position c in der Vergangenheitsform?
][
*Antwort:* Die Zeichnung beschreibt den Endzustand des Bauteils, deshalb „gedreht“, „geschliffen“ (S. 117).
][
*Kurz gefasst (aus dem Quiz):*
- In der Vergangenheitsform, z. B. „gedreht“ oder „geschliffen“. Die Zeichnung beschreibt den fertigen Zustand.
][
*Typische Verwechslungen:*
- „Im Infinitiv, z. B. „drehen““: Die Zeichnung zeigt den Endzustand, nicht die Anweisung.
- „Als Kürzel, z. B. „D“ für Drehen“: Kürzel für Verfahren sind nicht vorgesehen.
- „Gar nicht, Verfahren stehen nur im Arbeitsplan“: Das Verfahren sollte möglichst angegeben werden, weil jedes ein typisches Profil erzeugt.
][
*Kurz gefasst (aus der Karteikarte):*
- Die Zeichnung beschreibt den Endzustand des Bauteils.
- Deshalb heißt es »gedreht« oder »geschliffen«.

*Merksatz:* Die Zeichnung beschreibt den fertigen Zustand.
#bild("b-symbolpositionen", [Bild 6-10: Positionen am älteren Oberflächensymbol nach ISO 1302. B, S. 114 (PDF-S. 125).], height: 50mm)
#src[L-alt C1, Frage 12; nach B S. 107–130]
]

#aufgabe(titel: "Ra 0,8 auf allen Gussflächen", art: "verstehen", quelle: "5.5", herkunft: "eigen")[
#if not web [*Aufgabe 120* #linebreak()]
Kostenfrage: Ein Kollege schreibt auf alle Flächen eines Gussgehäuses „Ra 0,8“. Was sagst du ihm?
][
*Modell / Annahmen:* Genannte Profilform und Normfassung; Längen des Profils und Höhen einheitlich behandeln.

Unnötig teuer: Gussflächen ohne Funktion können roh bleiben (Kreissymbol oder Sammelangabe grob). Fein nur an Funktionsflächen wie Lagersitz oder Dichtfläche; Motto „so grob wie möglich, so fein wie nötig“ (S. 117–118).

*Prüfung:* Ra und Rz sind Höhenwerte in µm; die genannte Normfassung und Auswertelänge müssen passen.

#src[L-alt C1, Frage 23; nach B S. 107–130]
]

#aufgabe(titel: "Ra 6,3 nach alter und neuer Norm", art: "verstehen", quelle: "5.5", herkunft: "eigen")[
#if not web [*Aufgabe 121* #linebreak()]
Wie wird eine einzelne Angabe Ra 6,3 nach der älteren ISO 1302 interpretiert, und warum muss die Normfassung beachtet werden?
][
*Antwort:* Nach der älteren ISO 1302 ist 6,3 µm die obere Grenze und ohne Zusatz gilt die 16-%-Regel. Nach der im Buch beschriebenen ISO 21920-1 gilt ohne Zusatz dagegen Tmax; deshalb sind Normfassung und Zusatz gemeinsam zu lesen.

#src[L-alt C1, offene Überarbeitung Frage 26; B S. 107–130]
]

#aufgabe(titel: "Rillenrichtungen C, R, X und P", art: "verstehen", quelle: "5.5", herkunft: "eigen")[
#if not web [*Aufgabe 122* #linebreak()]
Erkläre die Rillenrichtungssymbole C, R, X und P.
][
*Antwort:* C. R. P. X.

#src[L-alt C1, offene Überarbeitung Frage 27; B S. 107–130]
]

#aufgabe(titel: "Oberflächen am Gehäusedeckel", art: "verstehen", quelle: "5.6", herkunft: "variante", vorlage: "Buch Kap. 6, Aufg. 6.12")[
#if not web [*Aufgabe 123* #linebreak()]
Gehäusedeckel (Buch 6.12): Fläche 1 ist Auflage für Schraubenköpfe, Fläche 3 eine Durchgangsbohrung für Schrauben, Fläche 5 die Zentrierung zum Gehäuse, Flächen 6/7 berühren nichts. Ordne grob/fein zu und begründe kurz.
][
*Modell / Annahmen:* Genannte Profilform und Normfassung; Längen des Profils und Höhen einheitlich behandeln.

Fläche 1: fein (z. B. Ra 1,6), Schraubenkopfauflage. Fläche 3: grob, Schrauben berühren die Bohrung nicht und sie bestimmt die Lage nicht. Fläche 5: fein, Zentrierung bestimmt die Lage. Flächen 6/7: grob, keine Funktionsflächen. Fläche 4 (Auflage zum Gehäuse): fein; Fläche 2 (entsteht nur nebenbei): grob (S. 129).

*Prüfung:* Ra und Rz sind Höhenwerte in µm; die genannte Normfassung und Auswertelänge müssen passen.

#src[L-alt C1, Frage 22; nach B S. 107–130]
]

#aufgabe(titel: "Überwiegende Oberfläche mit Ausnahmen", art: "verstehen", quelle: "5.6", herkunft: "eigen")[
#if not web [*Aufgabe 124* #linebreak()]
Wie gibt man eine überwiegende Oberflächenbeschaffenheit mit Ausnahmen an?
][
*Antwort:* Symbol mit Hauptangabe nahe am Teil bzw. über dem Schriftfeld, dahinter in Klammern die Ausnahmen (oder das Grundsymbol in Klammern); die abweichenden Flächen werden direkt am Teil gekennzeichnet (S. 119).

#src[L-alt C1, Frage 13; nach B S. 107–130]
]

#aufgabe(titel: "Örtlich gehärteten Bereich kennzeichnen", art: "verstehen", quelle: "5.7", herkunft: "eigen")[
#if not web [*Aufgabe 125* #linebreak()]
Wie kennzeichnet man einen örtlich gehärteten Bereich, und was gehört zur Angabe der Wärmebehandlung?
][
*Antwort:* Bereich mit breiter Strichpunktlinie außerhalb der Kontur kennzeichnen und bemaßen. Angabe des Endzustands („einsatzgehärtet“ usw.) mit Härtewert und Plustoleranz nahe dem Schriftfeld, ggf. Messstellen und Wärmebehandlungsbild (S. 120–122).

#src[L-alt C1, Frage 14; nach B S. 107–130]
]

#aufgabe(titel: "Beschichtungen kennzeichnen", art: "verstehen", quelle: "5.8", herkunft: "eigen")[
#if not web [*Aufgabe 126* #linebreak()]
Mit welchen Linien kennzeichnet man partielle Beschichtung, unzulässige Beschichtung und zulässige Beschichtung?
][
*Antwort:* Partiell: breite Strichpunktlinie. Nicht zulässig: schmale Strich-Zweipunktlinie. Zulässig, aber nicht nötig: breite Strichlinie. Die Bedeutung ist zu erklären (S. 123–124).

#src[L-alt C1, Frage 15; nach B S. 107–130]
]

#aufgabe(titel: "Kantenzustand mit Plus und Minus", art: "verstehen", quelle: "5.9", herkunft: "eigen")[
#if not web [*Aufgabe 127* #linebreak()]
Was bedeuten „+“, „−“ und „±“ beim Kantenzustand für Außen- und Innenkanten? Warum lohnt es sich, Kanten zu definieren?
][
*Antwort:* Außenkante: + Grat zulässig, − gratfrei/Abtragung. Innenkante: + Übergang zulässig, − Abtragung. ± beides zulässig. Sinn: Verletzungsgefahr, Montage, Funktion (Anlage, Dichtung) und Kosten werden eindeutig geregelt (S. 124–126).
][
*Kurz gefasst (aus der Karteikarte):*
- An einer Außenkante heißt + Grat zulässig und − gratfrei bzw. Abtragung.
- An einer Innenkante heißt + Übergang zulässig und − Abtragung. ± lässt beides zu.
- So sind Verletzungsgefahr, Montage, Funktion und Kosten eindeutig geregelt.
#bild("b-kanten", [Bild 6-23: Außen- und Innenkanten mit undefinierter Form. B, S. 124 (PDF-S. 135).], height: 50mm)
#src[L-alt C1, Frage 16; nach B S. 107–130]
]

#aufgabe(titel: "Scharfkantige Außenkante", art: "verstehen", quelle: "5.9", herkunft: "eigen")[
#if not web [*Aufgabe 128* #linebreak()]
Welche Größenordnung nennt das Buch für eine scharfkantige Außenkante?
][
*Antwort:* 50 µm.
][
*Kurz gefasst (aus dem Quiz):*
- Höchstens 0,05 mm. 0,05 mm = 50 µm. Mit einem sehr kleinen Wert wie ±0,05 wird „scharfkantig“ angegeben.
][
*Typische Verwechslungen:*
- „Höchstens 0,5 mm“: 0,5 mm ist schon eine deutlich gebrochene Kante.
- „Genau 0 mm“: Eine Kante ganz ohne Abweichung lässt sich nicht fertigen.
- „Höchstens 0,2 mm“: Dieser Wert steht nicht in der Norm.
#src[L-alt C1, offene Überarbeitung Frage 28; B S. 107–130]
]


#kapitel("Kapitel 6 · Toleranzen und Passungen")

#aufgabe(titel: "Die Zeichen Ⓜ, Ⓛ und Ⓔ", art: "verstehen", quelle: "6.1", herkunft: "original", vorlage: "Buch Kap. 7, Aufg. 7.14")[
#if not web [*Aufgabe 129* #linebreak()]
Was bedeutet jeweils das eingekreiste M, L und E hinter einer Maßangabe?
][
*Antwort:* Ⓜ Maximum-Material-Bedingung (ungenutzte Maßtoleranz darf für Form/Lage genutzt werden); Ⓛ Minimum-Material-Bedingung (z. B. Mindestwanddicke); Ⓔ Hüllbedingung für dieses Maß (S. 134–135).

#src[L-alt C2, Frage 3; nach B S. 131–168]
]

#aufgabe(titel: "Unabhängigkeitsprinzip und ISO 8015", art: "verstehen", quelle: "6.1", herkunft: "eigen")[
#if not web [*Aufgabe 130* #linebreak()]
Was besagt das Unabhängigkeitsprinzip? Was gilt, wenn „Tolerierung ISO 8015“ am Schriftfeld steht, und was, wenn die Angabe fehlt?
][
*Antwort:* Alle Maß-, Form- und Lagetoleranzen sind unabhängig voneinander einzuhalten. Der Hinweis „Tolerierung ISO 8015“ macht das ausdrücklich; früher war er zwingend, weil ohne ihn die Hüllbedingung galt. Heute gilt ISO 8015 auch ohne Hinweis, der Vermerk ist nur noch sinnvoll gegen Missverständnisse (S. 132, 135).
][
*Kurz gefasst (aus der Karteikarte):*
- Alle Maß-, Form- und Lagetoleranzen werden unabhängig voneinander eingehalten.
- Heute gilt es nach ISO 8015 auch ohne Hinweis.
- Der Vermerk »Tolerierung ISO 8015« ist nur noch zur Klarheit sinnvoll.
#src[L-alt C2, Frage 1; nach B S. 131–168]
]

#aufgabe(titel: "Hüllbedingung", art: "verstehen", quelle: "6.1", herkunft: "eigen")[
#if not web [*Aufgabe 131* #linebreak()]
Erkläre die Hüllbedingung. Warum ist sie teurer als das Unabhängigkeitsprinzip?
][
*Antwort:* Die Oberfläche des einzelnen Größenmaßelements muss die ideale Hülle am Maximum-Material-Maß einhalten. Eine Lageforderung zu anderen Elementen ist damit nicht allgemein festgelegt. Bei gleicher Maßtoleranz bleibt für Formabweichungen nur der nicht genutzte Rest; das erfordert höhere Genauigkeit (S. 133–134).
][
*Kurz gefasst (aus der Karteikarte):*
- Das Formelement muss die ideale Hülle am Maximum-Material-Maß einhalten.
- Form- und Maßabweichung teilen sich also dieselbe Toleranz.
- Für die Form bleibt nur der ungenutzte Rest, das verlangt eine genauere Fertigung.
#src[L-alt C2, Frage 2; nach B S. 131–168]
]

#aufgabe(titel: "Maximum-Material-Maß", art: "verstehen", quelle: "6.1", herkunft: "eigen")[
#if not web [*Aufgabe 132* #linebreak()]
Was ist das Maximum-Material-Maß bei Welle und Bohrung?
][
*Antwort:* Welle: Höchstmaß. Bohrung: Mindestmaß (S. 133).
][
*Kurz gefasst (aus dem Quiz):*
- Ihr Mindestmaß. Die kleinste Bohrung lässt am meisten Material stehen. Es ist zugleich das Gutmaß.
][
*Typische Verwechslungen:*
- „Ihr Höchstmaß“: Das ist das Maximum-Material-Maß einer Welle. Eine große Bohrung hat wenig Material.
- „Ihr Nennmaß“: Das Nennmaß ist nur die Bezugsgröße für die Abmaße.
- „Der Mittelwert aus Höchst- und Mindestmaß“: Der Mittelwert hat keine besondere Bedeutung für das Material.
][
*Kurz gefasst (aus der Karteikarte):*
- Der Zustand, in dem am meisten Material vorhanden ist.
- Bei der Welle ist das das Höchstmaß, bei der Bohrung das Mindestmaß.

*Merksatz:* Maximales Material: dickste Welle, kleinste Bohrung.
#bild("b-toleranzbegriffe", [Bild 7-4: Nennmaß und Grenzmaße an einer Welle. B, S. 136 (PDF-S. 147).], height: 50mm)
][
*Bild:* Mehr Material macht die Welle außen größer, aber das Loch innen kleiner.
#src[L-alt C2, Frage 4; nach B S. 131–168]
]

#aufgabe(titel: "Standard-Tolerierungsgrundsatz", art: "verstehen", quelle: "6.1", herkunft: "eigen")[
#if not web [*Aufgabe 133* #linebreak()]
Welcher Tolerierungsgrundsatz wird im Buch als Standard nach ISO 8015 erläutert?
][
*Antwort:* das Unabhängigkeitsprinzip. DIN EN ISO 8015.

#src[L-alt C2, offene Überarbeitung Frage 28; B S. 131–168]
]

#aufgabe(titel: "Gutmaß, Ausschussmaß und Grenzrachenlehre", art: "verstehen", quelle: "6.2", herkunft: "eigen")[
#if not web [*Aufgabe 134* #linebreak()]
Definiere Gutmaß und Ausschussmaß. Wie prüft man eine Welle mit der Grenzrachenlehre?
][
*Antwort:* Gutmaß: Grenzmaß, das beim Abtragen zuerst erreicht wird (= Maximum-Material-Maß). Ausschussmaß: das andere; darüber hinaus entsteht Ausschuss. Die Welle muss durch die Gutseite der Rachenlehre passen und darf nicht durch die Ausschussseite gleiten (S. 138).
][
*Kurz gefasst (aus der Karteikarte):*
- Das Gutmaß ist das Grenzmaß, das beim Abtragen zuerst erreicht wird, also das Maximum-Material-Maß.
- *Das andere ist das Ausschussmaß:* Wer darüber hinaus abträgt, produziert Ausschuss.
- Die Welle muss durch die Gutseite der Rachenlehre passen und darf nicht durch die Ausschussseite gleiten.
#bild("b-toleranzbegriffe", [Bild 7-4: Nennmaß und Grenzmaße an einer Welle. B, S. 136 (PDF-S. 147).], height: 50mm)
#src[L-alt C2, Frage 5; nach B S. 131–168]
]

#aufgabe(titel: "Mikrometer und Millimeter umrechnen", art: "rechnen", quelle: "6.2", herkunft: "variante", vorlage: "Buch Kap. 7, Aufg. 7.42 und 7.43",
  ergebnis: [30 µm = 0,030 mm; 20 mm = 20 000 µm],
  tipp: [1 mm = 1000 µm.],
)[
#if not web [*Aufgabe 135* #linebreak()]
*Gegeben und Annahmen*

Ausgangswerte 30 µm und 20 mm; $1 thin "mm"=1000 thin "µm"$.

*Gesucht*

#enum(numbering: "a)",
[Rechne 30 µm in mm um.],
[Rechne 20 mm in µm um.],
)
][
*Faktor:* Ein Millimeter hat 1000 Mikrometer.
][
*30 µm in mm:* durch 1000 teilen: 0,030 mm. Die Null hinten zeigt die Genauigkeit auf drei Stellen.
][
*20 mm in µm:* mal 1000: 20 000 µm.
][
*Warum das zählt:* Abmaße stehen in Tabellen in µm, Nennmaße in mm. Vor jeder Addition musst du auf eine Einheit bringen.
#src[L-alt C2, Frage 23; nach B S. 131–168]
]

#aufgabe(titel: "Toleranzgrade und Drehen", art: "verstehen", quelle: "6.3", herkunft: "original", vorlage: "Buch Kap. 7, Aufg. 7.19 und 7.20")[
#if not web [*Aufgabe 136* #linebreak()]
#enum(numbering: "a)",
[Welche Zahlen (Toleranzgrade) sind bei Nutzung einer ISO-Toleranzklasse möglich?],
[Welche Toleranzgrade sind durch das Bearbeitungsverfahren Drehen realisierbar?],
)
][
*Antwort:* IT01, IT0, IT1 bis IT18 (20 Grade). Drehen liegt in Tab. 7-2 bei den mittleren Toleranzgraden #strong[5 bis 11]; laut Text kommen für normale spanende Verfahren vorwiegend 5 bis 13 zum Einsatz (S. 141).

#src[L-alt C2, Frage 8; nach B S. 131–168]
]

#aufgabe(titel: "Buchstabe und Zahl bei H7", art: "verstehen", quelle: "6.3", herkunft: "eigen")[
#if not web [*Aufgabe 137* #linebreak()]
Was definieren bei „H7“ der Buchstabe und die Zahl? Wann Groß-, wann Kleinbuchstaben?
][
*Antwort:* Buchstabe: Lage des Toleranzfelds zur Null-Linie; Zahl: Toleranzgrad (Größe des Felds). Großbuchstaben für Bohrungen/Außenteile, Kleinbuchstaben für Wellen/Innenteile (S. 139).
][
*Kurz gefasst (aus dem Quiz):*
- Buchstabe = Lage des Toleranzfelds zur Null-Linie, Zahl = Toleranzgrad (Größe des Felds). Großbuchstaben stehen für Bohrungen, Kleinbuchstaben für Wellen.
][
*Typische Verwechslungen:*
- „Buchstabe = Werkstoff, Zahl = Oberflächengüte“: Werkstoff und Oberfläche haben eigene Angaben.
- „Buchstabe = Größe des Felds, Zahl = Lage“: Genau vertauscht.
- „Beide zusammen geben nur das obere Abmaß an“: Eine Toleranzklasse legt beide Abmaße fest.
][
*Kurz gefasst (aus der Karteikarte):*
- Der Buchstabe gibt die Lage des Toleranzfelds zur Nulllinie an, die Zahl den Toleranzgrad, also die Größe des Felds.
- Großbuchstaben gelten für Bohrungen, Kleinbuchstaben für Wellen.

*Merksatz:* Buchstabe legt die Lage fest, Zahl die Feldbreite.
#bild("b-abmasstabelle", [Tabelle 7-3: Grenzabmaße ausgewählter ISO-Toleranzklassen in µm. B, S. 142 (PDF-S. 153).], height: 50mm)
#src[L-alt C2, Frage 6; nach B S. 131–168]
]

#aufgabe(titel: "Nicht verwendete Toleranzbuchstaben", art: "verstehen", quelle: "6.3", herkunft: "eigen")[
#if not web [*Aufgabe 138* #linebreak()]
Welche Buchstaben werden nicht verwendet und warum?
][
*Antwort:* i, l, o, q, w bzw. I, L, O, Q, W, um Verwechslungen (z. B. mit 1 und 0) zu vermeiden (S. 139).

#src[L-alt C2, Frage 7; nach B S. 131–168]
]

#aufgabe(titel: "Feld h und Einheitswelle", art: "verstehen", quelle: "6.3", herkunft: "eigen")[
#if not web [*Aufgabe 139* #linebreak()]
Erkläre das Feld h und das System Einheitswelle.
][
*Antwort:* oberes Abmaß = 0. gilt für Wellen. ist die Grundlage der Einheitswelle.
][
*Kurz gefasst (aus dem Quiz):*
- Das obere Abmaß ist null, die Welle ist höchstens so groß wie das Nennmaß. es = 0, das Toleranzfeld liegt unter der Null-Linie.
][
*Typische Verwechslungen:*
- „Das untere Abmaß ist null.“: Das gilt für eine Bohrung „H“.
- „Das Feld liegt symmetrisch um die Null-Linie.“: Das sind js bzw. JS.
- „Beide Abmaße sind positiv.“: Positive Abmaße haben Wellen von k aufwärts.
#src[L-alt C2, offene Überarbeitung Frage 24; B S. 131–168]
]

#aufgabe(titel: "Toleranzklassen aus Grenzabmaßen finden", art: "rechnen", quelle: "6.3", herkunft: "variante", vorlage: "Buch Kap. 7, Aufg. 7.39",
  ergebnis: [Ø40 H7/r6, Übermaßpassung (PO = −9 µm, PU = −50 µm)],
  tipp: [Eine Bohrung, die das Nennmaß nicht unterschreiten darf, hat das Feld H.],
)[
#if not web [*Aufgabe 140* #linebreak()]
*Gegeben und Annahmen*

Nennmaß 40 mm. Die Bohrung darf 40 mm nicht unterschreiten und höchstens um 25 µm überschreiten. Die Welle soll zwischen +34 µm und +50 µm liegen.

*Gesucht*

#enum(numbering: "a)",
[Welche ISO-Toleranzklassen sind das, und welche Passungsart ergibt sich (Buch 7.39)?],
)
][
*Bohrung zuordnen:* Untere Grenze genau am Nennmaß heißt EI = 0, also Feld H. Die Toleranz von 25 µm entspricht im Bereich 30 bis 50 mm dem Grad IT7. Ergebnis *H7*.
][
*Welle zuordnen:* ei = +34 µm und es = +50 µm. Die Toleranz 16 µm ist IT6, und in Tabelle 7-3 gehört ei = +34 µm im Bereich 30–50 zum Feld r. Ergebnis *r6*.
][
*Grenzpassungen:* $P_O = 25 - 34 = -9 thin "µm"$, $P_U = 0 - 50 = -50 thin "µm"$.
][
*Deuten und prüfen:* Beide Grenzpassungen sind negativ, also immer Übermaß: *Übermaßpassung*. Es ist dieselbe Paarung wie Ø50 H7/r6, weil beide im Bereich 30–50 liegen.
#src[L-alt C2, Frage 19; nach B S. 131–168]
]

#aufgabe(titel: "Grenzmaße von Ø25 H7", art: "rechnen", quelle: "6.3", herkunft: "variante", vorlage: "Altklausur WS 20/21, Aufg. 4",
  ergebnis: [25,000 bis 25,021 mm, T = 0,021 mm],
  tipp: [H beginnt genau am Nennmaß.],
)[
#if not web [*Aufgabe 141* #linebreak()]
*Gegeben und Annahmen*

Bohrung Ø25 H7. Verwende die direkt beigefügte Tabelle 7-3 aus B S. 142 (Abmaße in µm).
#align(center)[#image(abbildungen.at("b-abmasstabelle"), width: 100%)]

*Gesucht*

#enum(numbering: "a)",
[Lies die Grenzabmaße ab und berechne Grenzmaße sowie Toleranz.],
)
][
*Tabelle:* Ø25 liegt im Bereich über 18 bis 30 mm. Dort steht für H7: ES = +21 µm, EI = 0.
][
*In mm umrechnen:* +0,021 mm und 0 mm.
][
*Grenzmaße:* Größtmaß Go = 25 + 0,021 = 25,021 mm, Kleinstmaß Gu = 25,000 mm. Toleranz T = 0,021 mm.
][
*Prüfen:* Feld H liegt direkt über der Nulllinie, die Bohrung ist also nie kleiner als das Nennmaß.
#src[L-alt L2; B Tab. 7-3, S. 142]
]

#aufgabe(titel: "Grenzabmaße aus Tabelle 7-3", art: "rechnen", quelle: "6.3", herkunft: "eigen",
  ergebnis: [Ø120 h6: 0/−22 µm; Ø119 H11: +220/0 µm; Ø5 E9: +50/+20 µm; Ø25 F8: +53/+20 µm],
  tipp: [Erst den Nennmaßbereich suchen, dann in der Spalte der Toleranzklasse ablesen. Großbuchstabe heißt Bohrung.],
)[
#if not web [*Aufgabe 142* #linebreak()]
*Gegeben und Annahmen*

Tolerierte Maße: Ø120 h6, Ø119 H11, Ø5 E9 und Ø25 F8. Beigefügt ist Tabelle 7-3 aus B S. 142, Abmaße in µm.
#align(center)[#image(abbildungen.at("b-abmasstabelle"), width: 100%)]

*Gesucht*

#enum(numbering: "a)",
[Lies die Grenzabmaße für alle vier Maße ab.],
[Prüfe die Feldbreiten und die Zuordnung von Bohrung und Welle.],
)
][
*Vorgehen:* Zeile nach dem Nennmaßbereich, Spalte nach der Toleranzklasse. Kleinbuchstaben sind Wellen (es, ei), Großbuchstaben Bohrungen (ES, EI).
][
*Ø120 h6* liegt im Bereich über 100 bis 120: es = 0, ei = −22 µm. Feld h beginnt an der Nulllinie und geht nach unten.
][
*Ø119 H11* liegt ebenfalls im Bereich 100 bis 120: ES = +220 µm, EI = 0. Feld H beginnt an der Nulllinie und geht nach oben.
][
*Ø5 E9* (Bereich 3 bis 6): ES = +50 µm, EI = +20 µm. *Ø25 F8* (Bereich 18 bis 30): ES = +53 µm, EI = +20 µm.
][
*Prüfen:* Die Toleranz ist ES − EI bzw. es − ei und immer positiv: 22, 220, 30 und 33 µm. Größere Zahl hinter dem Buchstaben heißt größere Toleranz.
#src[L-alt C2, Frage 18; nach B S. 131–168]
]

#aufgabe(titel: "Welle Ø50 j6 prüfen", art: "rechnen", quelle: "6.3", herkunft: "eigen",
  ergebnis: [Gut, denn 49,995 ≤ 50,008 ≤ 50,011 mm; Istabmaß +8 µm],
  tipp: [Erst die Grenzmaße bilden, dann prüfen, ob das Istmaß dazwischen liegt.],
)[
#if not web [*Aufgabe 143* #linebreak()]
*Gegeben und Annahmen*

Welle Ø50 j6; es = +11 µm, ei = −5 µm. Gemessenes Istmaß 50,008 mm.

*Gesucht*

#enum(numbering: "a)",
[Prüfe, ob die Welle maßlich gut ist, und berechne das Istabmaß.],
)
][
*Tabelle:* j6 bei Ø50: es = +11 µm, ei = −5 µm. Feld j liegt fast symmetrisch um die Nulllinie.
][
*Grenzmaße:* Kleinstmaß 50 − 0,005 = 49,995 mm, Größtmaß 50 + 0,011 = 50,011 mm.
][
*Vergleich:* 50,008 mm liegt zwischen 49,995 und 50,011 mm. Die Welle ist *gut*.
][
*Istabmaß:* Istmaß minus Nennmaß: 50,008 − 50,000 = +0,008 mm = +8 µm. Es liegt zwischen ei = −5 und es = +11 µm, das passt.
#src[L-alt G8; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

#aufgabe(titel: "Allgemeintoleranz ISO 2768-mK", art: "verstehen", quelle: "6.4", herkunft: "eigen")[
#if not web [*Aufgabe 144* #linebreak()]
Was bedeutet „ISO 2768-mK“? Für welche Maße gelten Allgemeintoleranzen nicht?
][
*Antwort:* Allgemeintoleranzen Klasse m (mittel) für Längen und Winkel nach 2768-1, Klasse K für Form und Lage nach 2768-2. Nicht für Hilfsmaße in Klammern und theoretisch genaue Maße im Rahmen (S. 146, 153).
][
*Kurz gefasst (aus dem Quiz):*
- Allgemeintoleranzen für Längen und Winkel in Klasse m, für Form und Lage in Klasse K. Für Hilfsmaße und theoretisch genaue Maße gilt das nicht.
][
*Typische Verwechslungen:*
- „Alle Maße sind mit ±0,1 mm toleriert.“: Die Abmaße hängen vom Nennmaßbereich ab.
- „Mittlere Oberflächengüte, Kanten gebrochen“: Oberflächen und Kanten haben eigene Angaben.
- „Toleranzklasse m6 für alle Wellen“: ISO-Toleranzklassen werden einzeln eingetragen.
][
*Kurz gefasst (aus der Karteikarte):*
- *Allgemeintoleranzen:* Klasse m (mittel) für Längen und Winkel, Klasse K für Form und Lage.
- Sie gelten für alle Maße ohne eigene Toleranz, aber nicht für Hilfsmaße in Klammern und theoretisch genaue Maße im Rahmen.
#src[L-alt C2, Frage 9; nach B S. 131–168]
]

#aufgabe(titel: "Grenzmaße nach ISO 2768-m", art: "rechnen", quelle: "6.4", herkunft: "eigen",
  ergebnis: [8 ± 0,2 → 7,8 bis 8,2 mm; 45 ± 0,3 → 44,7 bis 45,3 mm; 250 ± 0,5 → 249,5 bis 250,5 mm],
  tipp: [Allgemeintoleranzen hängen nur vom Nennmaßbereich ab und sind symmetrisch.],
)[
#if not web [*Aufgabe 145* #linebreak()]
*Gegeben und Annahmen*

Eine Zeichnung trägt „ISO 2768-m“. Tabellenauszug ISO 2768-m: über 6 bis 30 mm: ±0,2 mm; über 30 bis 120 mm: ±0,3 mm; über 120 bis 400 mm: ±0,5 mm.

*Gesucht*

#enum(numbering: "a)",
[Welche Grenzmaße gelten für die Maße 8, 45 und 250 mm?],
)
][
*Bild:* Für Maße ohne eigene Toleranz gilt eine Pauschaltoleranz. Je größer das Maß, desto großzügiger, denn große Teile sind schwerer genau zu fertigen.
][
*8 mm* liegt im Bereich über 6 bis 30: ±0,2 mm, also 7,8 bis 8,2 mm.
][
*45 mm* liegt im Bereich über 30 bis 120: ±0,3 mm, also 44,7 bis 45,3 mm.
][
*250 mm* liegt im Bereich über 120 bis 400: ±0,5 mm, also 249,5 bis 250,5 mm.
][
*Prüfen:* Die Klasse m heißt „mittel“. Mit f (fein) wären die Toleranzen kleiner, mit c (grob) größer.
#src[L-alt C2, Frage 20; nach B S. 131–168]
]

#aufgabe(titel: "H7 und Allgemeintoleranz auf einer Zeichnung", art: "rechnen", quelle: "6.4", herkunft: "eigen",
  ergebnis: [Ø40 H7: 40,000 bis 40,025 mm; 25: 24,8 bis 25,2 mm; IT7 z. B. durch Reiben, Schleifen, Feindrehen],
  tipp: [Ein Maß mit eigener Toleranz folgt Tabelle 7-3, eines ohne folgt der Allgemeintoleranz im Schriftfeld.],
)[
#if not web [*Aufgabe 146* #linebreak()]
*Gegeben und Annahmen*

An einer Bohrung steht „Ø40 H7“, im Schriftfeld „ISO 2768-mK“. Ein anderes Maß der Zeichnung lautet „25“ ohne Toleranz. Tabellenwerte: Ø40 H7: ES/EI = +25/0 µm; ISO 2768-m für 25 mm: ±0,2 mm.

*Gesucht*

#enum(numbering: "a)",
[Grenzmaße beider Maße?],
[Welche Bearbeitung ist für IT7 typisch?],
)
][
*Bild:* Auf jeder Zeichnung gibt es zwei Arten von Maßen: die wenigen wichtigen mit eigener Toleranz und die vielen übrigen, für die das Schriftfeld eine Pauschale vorgibt.
][
*Ø40 H7:* Tabelle 7-3, Bereich 30 bis 50: +25/0 µm. Also 40,000 bis 40,025 mm.
][
*Maß 25 ohne Toleranz:* Es gilt ISO 2768-m. 25 liegt im Bereich über 6 bis 30, also ±0,2 mm: 24,8 bis 25,2 mm.
][
*Bearbeitung für IT7:* IT7 liegt im Bereich der Grade, die Feinbearbeitung brauchen: Reiben, Schleifen, Feindrehen oder Fräsen (Tab. 7-2).
][
*Prüfen:* Die Passbohrung ist rund sechzehnmal enger toleriert (25 µm gegen 400 µm). Deshalb steht dort eine eigene Angabe.
#src[L-alt G2; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

#aufgabe(titel: "Toleranzrahmen für einen Lagersitz", art: "verstehen", quelle: "6.5", herkunft: "variante", vorlage: "Buch Kap. 7, Aufg. 7.31")[
#if not web [*Aufgabe 147* #linebreak()]
Schreibe die Toleranzrahmen: a) Lagersitz Zylinderform 5 µm, b) Lagersitz Koaxialität 5 µm zur gemeinsamen Achse A–B, c) Anlageschulter Planlauf 7 µm zur Achse A–B (vgl. Buch 7.31).
][
*Modell / Annahmen:* Worst-Case-Grenzmaße; keine statistische Verteilung voraussetzen.

0,005   ◎Ø0,005A–B   ↗0,007A–B (Werte in mm; Bezugsdreiecke A und B an den Lagersitzachsen; Planlauf mit Lauf-Symbol, Pfeil auf die Schulterfläche) (S. 147–152).

*Prüfung:* Toleranzen sind nicht negativ, und PO ist mindestens so groß wie PU. Abmaße in µm vor Addition zu mm umrechnen.

#src[L-alt C2, Frage 22; nach B S. 131–168]
]

#aufgabe(titel: "Form- und Lagetoleranzen", art: "verstehen", quelle: "6.5", herkunft: "eigen")[
#if not web [*Aufgabe 148* #linebreak()]
Was unterscheidet Form- von Lagetoleranzen? Nenne je drei Beispiele mit Symbol.
][
*Antwort:* Reine Formforderungen: beispielsweise Geradheit, Ebenheit und Rundheit. Bezogene Forderungen: beispielsweise Parallelität, Rechtwinkligkeit und Rundlauf. Die Originalsymbole zeigt die Vektorübersicht in Abschnitt 6.5 (S. 146–150).
][
*Kurz gefasst (aus der Karteikarte):*
- Formtoleranzen beschreiben ein Element allein, zum Beispiel Geradheit, Ebenheit oder Rundheit.
- Sie brauchen keinen Bezug.
- Lagetoleranzen beschreiben ein Element relativ zu einem Bezug, zum Beispiel Parallelität, Rechtwinkligkeit oder Rundlauf.

*Merksatz:* Form prüft das Element, Lage prüft seine Beziehung zum Bezug.
#bild("b-toleranzrahmen", [Bild 7-16: Toleranzrahmen und Hinweislinie. B, S. 147 (PDF-S. 158).], height: 50mm)
#src[L-alt C2, Frage 10; nach B S. 131–168]
]

#aufgabe(titel: "Lage des Bezugspfeils", art: "verstehen", quelle: "6.5", herkunft: "eigen")[
#if not web [*Aufgabe 149* #linebreak()]
Wann setzt man den Bezugspfeil in die Verlängerung der Maßlinie, wann nicht?
][
*Antwort:* In Verlängerung der Maßlinie, wenn eine Achse oder Mittelebene toleriert wird; nicht in Verlängerung, wenn eine Fläche oder Linie toleriert wird (S. 151).
][
*Kurz gefasst (aus der Karteikarte):*
- Wenn eine Achse oder Mittelebene toleriert wird.
- Wird dagegen eine Fläche oder Linie toleriert, sitzt der Pfeil deutlich neben der Maßlinie auf der Kontur.
#bild("b-toleranzrahmen", [Bild 7-16: Toleranzrahmen und Hinweislinie. B, S. 147 (PDF-S. 158).], height: 50mm)
#src[L-alt C2, Frage 11; nach B S. 131–168]
]

#aufgabe(titel: "Lauf und Gesamtlauf", art: "verstehen", quelle: "6.5", herkunft: "eigen")[
#if not web [*Aufgabe 150* #linebreak()]
Worin unterscheiden sich Lauf- und Gesamtlauftoleranz? Wann Rundlauf, wann Planlauf?
][
*Antwort:* Lauf: Messung in einzelnen Messebenen (Rundlauf, radial) bzw. Messzylindern (Planlauf, axial). Gesamtlauf: zusätzlich wird die Messuhr axial (Mantel) bzw. radial (Planfläche) über die ganze Fläche verschoben. Rundlauf für Mantelflächen, Planlauf für Stirnflächen (S. 150).
][
*Kurz gefasst (aus der Karteikarte):*
- Rundlauf für Mantelflächen (radial gemessen), Planlauf für Stirnflächen (axial gemessen).
- Bei der Gesamtlauftoleranz wird die Messuhr zusätzlich über die ganze Fläche verschoben.

*Merksatz:* Rundlauf radial, Planlauf axial.
#bild("b-toleranzrahmen", [Bild 7-16: Toleranzrahmen und Hinweislinie. B, S. 147 (PDF-S. 158).], height: 50mm)
#src[L-alt C2, Frage 12; nach B S. 131–168]
]

#aufgabe(titel: "Welche Toleranzen einen Bezug brauchen", art: "verstehen", quelle: "6.5", herkunft: "eigen")[
#if not web [*Aufgabe 151* #linebreak()]
Welche Bezüge benötigen Parallelität, Rundlauf und Position? Vergleiche mit Ebenheit und Rundheit.
][
*Antwort:* Parallelität. Rundlauf. Position.

#src[L-alt C2, offene Überarbeitung Frage 26; B S. 131–168]
]

#aufgabe(titel: "Passung und Grenzpassung", art: "verstehen", quelle: "6.6", herkunft: "eigen")[
#if not web [*Aufgabe 152* #linebreak()]
Definiere „Passung“ und „Grenzpassung“.
][
*Antwort:* Passung: Maßdifferenz von Innen- und Außenpassfläche vor dem Fügen. Grenzpassung: Passung, wenn beide Passflächen an ihren Grenzmaßen liegen (Höchst- und Mindestpassung) (S. 153–154).

#src[L-alt C2, Frage 13; nach B S. 131–168]
]

#aufgabe(titel: "Spiel, Übergang und Übermaß", art: "verstehen", quelle: "6.6", herkunft: "eigen")[
#if not web [*Aufgabe 153* #linebreak()]
Woran erkennt man Spiel-, Übergangs- und Übermaßpassung?
][
*Antwort:* Spiel: P#sub[O] und P#sub[U] ≥ 0; Übergang: P#sub[O] \> 0, P#sub[U] \< 0; Übermaß: beide ≤ 0 bzw. \< 0. Im Toleranzfeldbild: Bohrungsfeld über, überlappend mit bzw. unter dem Wellenfeld (S. 156).
][
*Kurz gefasst (aus der Karteikarte):*
- *Spiel:* Höchst- und Mindestpassung sind beide ≥ 0.
- Das Bohrungsfeld liegt über dem Wellenfeld.
- *Übergang:* Die Höchstpassung ist positiv, die Mindestpassung negativ.
- Die Felder überlappen.
- *Übermaß:* Beide sind negativ.
- Das Bohrungsfeld liegt unter dem Wellenfeld.
#bild("b-passungsbegriffe", [Tabelle 7-10: Grenzpassungen und Vorzeichen. B, S. 154 (PDF-S. 165).], height: 50mm)
#src[L-alt C2, Frage 14; nach B S. 131–168]
]

#aufgabe(titel: "Passtoleranz herleiten", art: "verstehen", quelle: "6.6", herkunft: "eigen")[
#if not web [*Aufgabe 154* #linebreak()]
Leite die Passtoleranz aus Bohrungs- und Wellentoleranz her.
][
*Antwort:* ist die Summe der Maßtoleranzen von Bohrung und Welle. ist PO − PU.

#src[L-alt C2, offene Überarbeitung Frage 25; B S. 131–168]
]

#aufgabe(titel: "Grenzmaße und Passungen aus der Altklausur", art: "rechnen", quelle: "6.6", herkunft: "original", vorlage: "Altklausur WS 20/21, Aufg. 4", minuten: 14,
  ergebnis: [H7: 30,021/30,000/0,021; h6: 30,000/29,987/0,013; j6: 30,009/29,996/0,013; r6: 30,041/30,028/0,013 (Go/Gu/T in mm). H7/h6 Spiel, H7/j6 Übergang, H7/r6 Übermaß],
  tipp: [Rechne alles in µm und setze erst am Ende auf mm um. Dieselbe Bohrung, drei verschiedene Wellen.],
)[
#if not web [*Aufgabe 155* #linebreak()]
Vervollständigen Sie die fehlenden Daten zu den angegebenen Passungen. (15 Punkte)

#tab(columns: (auto, 1fr, 1fr, 1fr, 1fr),
 th([Paßmaße], [Ø30 H7], [Ø30 h6], [Ø30 j6], [Ø30 r6]),
 [Oberes Abmaß A#sub[o] \[µm\]], [+21], [0], [+9], [+41],
 [Unteres Abmaß A#sub[u] \[µm\]], [0], [−13], [−4], [+28],
 [Höchstmaß G#sub[o] \[mm\]], [], [], [], [],
 [Mindestmaß G#sub[u] \[mm\]], [], [], [], [],
 [Maßtoleranz T \[mm\]], [], [], [], [],
)
#tab(columns: (1fr, 1fr),
 th([Passung], [Passungstyp]),
 [Ø30 H7/h6], [],
 [Ø30 H7/j6], [],
 [Ø30 H7/r6 (im Original verkürzt „ØH7/r6“)], [],
)
Berechnungen angeben.
][
*Modell:* Höchstmaß = Nennmaß + oberes Abmaß, Mindestmaß = Nennmaß + unteres Abmaß, Toleranz = Differenz. Für die Passung zählen die Extremfälle: $P_O = "ES" - "ei"$ (größte Bohrung, kleinste Welle) und $P_U = "EI" - "es"$ (kleinste Bohrung, größte Welle). Positiv heißt Spiel, negativ Übermaß.
][
*Grenzmaße:* H7: G#sub[o] = 30,021 mm, G#sub[u] = 30,000 mm, T = 0,021 mm. h6: 30,000 / 29,987 / 0,013 mm. j6: 30,009 / 29,996 / 0,013 mm. r6: 30,041 / 30,028 / 0,013 mm.
][
*H7/h6:* $P_O = 21 - (-13) = 34 thin "µm"$, $P_U = 0 - 0 = 0$. Nie Übermaß: *Spielpassung.*
][
*H7/j6:* $P_O = 21 - (-4) = 25 thin "µm"$, $P_U = 0 - 9 = -9 thin "µm"$. Je nach Paarung Spiel oder Übermaß: *Übergangspassung.*
][
*H7/r6:* $P_O = 21 - 28 = -7 thin "µm"$, $P_U = 0 - 41 = -41 thin "µm"$. Immer Übermaß: *Übermaßpassung.*
][
*Prüfen:* Alle drei haben $P_T = P_O - P_U = 34 thin "µm" = 21 + 13$, denn die Toleranzen sind gleich, nur die Lage des Wellenfelds verschiebt sich.
#src[AK 4, PDF-S. 8; Tabellenwerte sind in AK vorgegeben]
]

#aufgabe(titel: "Passung Ø25 H7/s6", art: "rechnen", quelle: "6.6", herkunft: "variante", vorlage: "Altklausur WS 20/21, Aufg. 4",
  ergebnis: [PO = −14 µm, PU = −48 µm, Übermaßpassung],
  tipp: [Höchstpassung: größte Bohrung gegen kleinste Welle.],
)[
#if not web [*Aufgabe 156* #linebreak()]
*Gegeben und Annahmen*

Ø25 H7/s6; H7: ES/EI = +21/0 µm, s6: es/ei = +48/+35 µm.

*Gesucht*

#enum(numbering: "a)",
[Berechne PO, PU, Passtoleranz und Passungsart.],
)
][
*Bild:* Die Welle s6 liegt komplett über der Bohrung H7. Selbst die kleinste Welle ist größer als die größte Bohrung.
][
*Höchstpassung:* $P_O = "ES" - "ei" = 21 - 35 = -14 thin "µm"$.
][
*Mindestpassung:* $P_U = "EI" - "es" = 0 - 48 = -48 thin "µm"$.
][
*Deuten und prüfen:* Beide negativ, also *Übermaßpassung* mit 14 bis 48 µm Übermaß. $P_T = 34 thin "µm" = 21 + 13$, die Summe der Toleranzen.
#src[L-alt L3; B Tab. 7-3 S. 142 und S. 155]
]

#aufgabe(titel: "Passung Ø60 H7/k6", art: "rechnen", quelle: "6.6", herkunft: "variante", vorlage: "Altklausur WS 20/21, Aufg. 4",
  ergebnis: [PO = +28 µm, PU = −21 µm, Übergangspassung],
  tipp: [Erst die Abmaße für Ø60 aus der Tabelle, dann die beiden Grenzfälle.],
)[
#if not web [*Aufgabe 157* #linebreak()]
*Gegeben und Annahmen*

Ø60 H7/k6; H7: ES/EI = +30/0 µm, k6: es/ei = +21/+2 µm.

*Gesucht*

#enum(numbering: "a)",
[Berechne Höchstpassung, Mindestpassung, Passtoleranz und Passungsart.],
)
][
*Tabelle:* Für Ø60 gilt H7 = +30/0 µm und k6 = +21/+2 µm.
][
*Höchstpassung:* größte Bohrung minus kleinste Welle, $P_O = 30 - 2 = +28 thin "µm"$.
][
*Mindestpassung:* kleinste Bohrung minus größte Welle, $P_U = 0 - 21 = -21 thin "µm"$.
][
*Deuten und prüfen:* Ein Vorzeichen positiv, eins negativ: *Übergangspassung*. $P_T = 49 thin "µm" = 30 + 19$.
#src[L-alt S1; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

#aufgabe(titel: "Passung Ø100 H8/h11", art: "rechnen", quelle: "6.6", herkunft: "variante", vorlage: "Altklausur WS 20/21, Aufg. 4",
  ergebnis: [PO = +274 µm, PU = 0, Spielpassung],
  tipp: [H und h berühren beide die Nulllinie, von entgegengesetzten Seiten.],
)[
#if not web [*Aufgabe 158* #linebreak()]
*Gegeben und Annahmen*

Ø100 H8/h11; H8: ES/EI = +54/0 µm, h11: es/ei = 0/−220 µm.

*Gesucht*

#enum(numbering: "a)",
[Berechne PO, PU, Passtoleranz und Passungsart.],
)
][
*Tabelle:* Bereich über 80 bis 100 mm: H8 = +54/0 µm, h11 = 0/−220 µm.
][
*Höchstpassung:* $P_O = 54 - (-220) = +274 thin "µm"$.
][
*Mindestpassung:* $P_U = 0 - 0 = 0$.
][
*Deuten und prüfen:* Im strammsten Fall berühren sich die Teile gerade, sonst ist Spiel. $P_U = 0$ zählt noch als *Spielpassung*. $P_T = 274 thin "µm" = 54 + 220$.
#src[L-alt A2; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

#aufgabe(titel: "Passung Ø12 F8/h6", art: "rechnen", quelle: "6.6", herkunft: "variante", vorlage: "Altklausur WS 20/21, Aufg. 4",
  ergebnis: [PO = +54 µm, PU = +16 µm, Spielpassung im System Einheitswelle],
  tipp: [Ist die Welle h, gehört die Paarung zum System Einheitswelle.],
)[
#if not web [*Aufgabe 159* #linebreak()]
*Gegeben und Annahmen*

Ø12 F8/h6; F8: ES/EI = +43/+16 µm, h6: es/ei = 0/−11 µm.

*Gesucht*

#enum(numbering: "a)",
[Berechne PO, PU und Passtoleranz; bestimme Passungsart und Pass-System.],
)
][
*Tabelle:* Bereich über 10 bis 18 mm: F8 = +43/+16 µm, h6 = 0/−11 µm.
][
*Höchstpassung:* $P_O = 43 - (-11) = +54 thin "µm"$.
][
*Mindestpassung:* $P_U = 16 - 0 = +16 thin "µm"$.
][
*Deuten:* Beide positiv: immer mindestens 16 µm Spiel, also *Spielpassung*. Weil die Welle das Feld h hat, ist es das *System Einheitswelle*.
][
*Prüfen:* $P_T = 38 thin "µm" = 27 + 11$, Summe der beiden Toleranzen.
#src[L-alt A3; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

#aufgabe(titel: "Passungstabelle Ø40 H7 mit g6, k6, s6 (Variante)", art: "rechnen", quelle: "6.6", herkunft: "variante", vorlage: "Altklausur WS 20/21, Aufg. 4", minuten: 14,
  ergebnis: [H7: 40,025/40,000/0,025; g6: 39,991/39,975/0,016; k6: 40,018/40,002/0,016; s6: 40,059/40,043/0,016 mm. H7/g6 Spiel (+9 bis +50 µm), H7/k6 Übergang (−18 bis +23 µm), H7/s6 Übermaß (−18 bis −59 µm)],
  tipp: [Gleiche Bohrung, drei Wellen: Liegt das Wellenfeld unter, über oder halb in dem Bohrungsfeld?],
)[
#if not web [*Aufgabe 160* #linebreak()]
*Gegeben und Annahmen*

Vervollständige die Tabelle wie in der Altklausur (Abmaße nach ISO 286 für den Nennmaßbereich über 30 bis 50 mm).
#tab(columns: (auto, 1fr, 1fr, 1fr, 1fr),
 th([Passmaße], [Ø40 H7], [Ø40 g6], [Ø40 k6], [Ø40 s6]),
 [Oberes Abmaß \[µm\]], [+25], [−9], [+18], [+59],
 [Unteres Abmaß \[µm\]], [0], [−25], [+2], [+43],
 [Höchstmaß G#sub[o] \[mm\]], [], [], [], [],
 [Mindestmaß G#sub[u] \[mm\]], [], [], [], [],
 [Maßtoleranz T \[mm\]], [], [], [], [],
)

*Gesucht*

#enum(numbering: "a)",
[Höchstmaß, Mindestmaß und Toleranz aller vier Elemente.],
[Höchst- und Mindestpassung sowie Passungstyp für H7/g6, H7/k6 und H7/s6.],
)
][
*a) Grenzmaße:* H7: 40,025 / 40,000 / 0,025 mm. g6: 39,991 / 39,975 / 0,016 mm. k6: 40,018 / 40,002 / 0,016 mm. s6: 40,059 / 40,043 / 0,016 mm.
][
*H7/g6:* $P_O = 25 - (-25) = +50 thin "µm"$, $P_U = 0 - (-9) = +9 thin "µm"$. Beide positiv: *Spielpassung* (die Welle ist immer kleiner als die Bohrung).
][
*H7/k6:* $P_O = 25 - 2 = +23 thin "µm"$, $P_U = 0 - 18 = -18 thin "µm"$. Vorzeichenwechsel: *Übergangspassung.*
][
*H7/s6:* $P_O = 25 - 43 = -18 thin "µm"$, $P_U = 0 - 59 = -59 thin "µm"$. Beide negativ: *Übermaßpassung.*
][
*Prüfen:* Jede Passtoleranz ist $25 + 16 = 41 thin "µm"$: $50 - 9$, $23 - (-18)$, $-18 - (-59)$. Stimmt.
#src[Variante zu AK 4; Abmaße nach ISO 286 (B Tab. 7-3)]
]

#aufgabe(titel: "Passungstabelle aus Grenzmaßen Ø60 (Variante)", art: "rechnen", quelle: "6.6", herkunft: "variante", vorlage: "Altklausur WS 20/21, Aufg. 4", minuten: 14,
  ergebnis: [Abmaße: H7 +30/0, f7 −30/−60, m6 +30/+11, u6 +106/+87 µm; T = 30/30/19/19 µm. H7/f7 Spiel (+30 bis +90 µm), H7/m6 Übergang (−30 bis +19 µm), H7/u6 Übermaß (−57 bis −106 µm)],
  tipp: [Rückwärts rechnen: Abmaß = Grenzmaß − Nennmaß.],
)[
#if not web [*Aufgabe 161* #linebreak()]
*Gegeben und Annahmen*

Diesmal sind die Grenzmaße gegeben (Nennmaß 60 mm):
#tab(columns: (auto, 1fr, 1fr, 1fr, 1fr),
 th([Passmaße], [Ø60 H7], [Ø60 f7], [Ø60 m6], [Ø60 u6]),
 [Höchstmaß G#sub[o] \[mm\]], [60,030], [59,970], [60,030], [60,106],
 [Mindestmaß G#sub[u] \[mm\]], [60,000], [59,940], [60,011], [60,087],
 [Oberes Abmaß \[µm\]], [], [], [], [],
 [Unteres Abmaß \[µm\]], [], [], [], [],
 [Maßtoleranz T \[µm\]], [], [], [], [],
)

*Gesucht*

#enum(numbering: "a)",
[Abmaße und Toleranzen aller vier Elemente.],
[Grenzpassungen und Passungstyp für H7/f7, H7/m6, H7/u6.],
[Bei welcher Paarung ist ein Fügen von Hand möglich?],
)
][
*a) Abmaße:* Grenzmaß minus 60 mm, in µm: H7 +30/0, T = 30. f7 −30/−60, T = 30. m6 +30/+11, T = 19. u6 +106/+87, T = 19.
][
*H7/f7:* $P_O = 30 - (-60) = +90 thin "µm"$, $P_U = 0 - (-30) = +30 thin "µm"$: *Spielpassung.*
][
*H7/m6:* $P_O = 30 - 11 = +19 thin "µm"$, $P_U = 0 - 30 = -30 thin "µm"$: *Übergangspassung.*
][
*H7/u6:* $P_O = 30 - 87 = -57 thin "µm"$, $P_U = 0 - 106 = -106 thin "µm"$: *Übermaßpassung* (Pressverband, nur mit Presse oder Erwärmen fügbar).
][
*c) und Prüfen:* Von Hand fügbar ist nur H7/f7, weil immer mindestens 30 µm Spiel bleibt. Passtoleranzen: $60 = 30 + 30$ und $49 = 30 + 19$ ✓.
#src[Variante zu AK 4; Abmaße nach ISO 286 (B Tab. 7-3)]
]

#aufgabe(titel: "Passungen H7/r6 und H7/h6 bei Ø50", art: "rechnen", quelle: "6.6", herkunft: "variante", vorlage: "Buch Kap. 7, Aufg. 7.6",
  ergebnis: [H7/r6: Übermaß 9 bis 50 µm, PT = 41 µm. H7/h6: Spiel 0 bis 41 µm, PT = 41 µm],
  tipp: [Höchstpassung = größte Bohrung minus kleinste Welle, Mindestpassung = kleinste Bohrung minus größte Welle.],
)[
#if not web [*Aufgabe 162* #linebreak()]
*Gegeben und Annahmen*

Nennmaß 50 mm; Paarungen H7/r6 und H7/h6. Die benötigte Abmaßtabelle ist direkt beigefügt (B, Tabelle 7-3, S. 142; Werte in µm).
#align(center)[#image(abbildungen.at("b-abmasstabelle"), width: 100%)]

*Gesucht*

#enum(numbering: "a)",
[Lies ES, EI, es und ei für beide Paarungen ab.],
[Berechne Grenzmaße und Einzeltoleranzen von Bohrung und Welle.],
[Bestimme Grenzpassungen, Passtoleranz und Passungsart für beide Paarungen.],
)
][
*Bild:* Eine Passung ist die Frage, ob die Welle locker oder stramm im Loch sitzt. Weil beide Teile streuen, gibt es einen lockersten und einen strammsten Fall. Positive Werte bedeuten Spiel, negative Übermaß.
][
*Bohrung Ø50 H7* (Bereich 30–50 mm): ES = +25 µm, EI = 0. Damit Go = 50,025 mm, Gu = 50,000 mm, T = 0,025 mm.
][
*Welle r6:* es = +50 µm, ei = +34 µm, also Go = 50,050 mm, Gu = 50,034 mm, T = 0,016 mm. Grenzpassungen: $P_O = "ES" - "ei" = 25 - 34 = -9 thin "µm"$ und $P_U = "EI" - "es" = 0 - 50 = -50 thin "µm"$. Beide negativ: *Übermaßpassung*. Passtoleranz $P_T = -9 - (-50) = 41 thin "µm"$.
][
*Welle h6:* es = 0, ei = −16 µm, also Go = 50,000 mm, Gu = 49,984 mm, T = 0,016 mm. $P_O = 25 - (-16) = +41 thin "µm"$, $P_U = 0 - 0 = 0$. Kein Übermaß möglich: *Spielpassung*, $P_T = 41 thin "µm"$.
][
*Prüfen:* Die Passtoleranz ist jedes Mal die Summe der Einzeltoleranzen, $25 + 16 = 41 thin "µm"$. Die Bohrung bleibt gleich; allein die Welle entscheidet über die Passungsart.
#src[L-alt C2, Frage 16; nach B S. 131–168]
]

#aufgabe(titel: "Passungsart aus PO und PU", art: "rechnen", quelle: "6.6", herkunft: "eigen",
  ergebnis: [Übergangspassung, PT = 0,041 mm],
  tipp: [Schau nur auf die Vorzeichen: positiv heißt Spiel, negativ Übermaß.],
)[
#if not web [*Aufgabe 163* #linebreak()]
*Gegeben und Annahmen*

Höchstpassung PO = +0,030 mm, Mindestpassung PU = −0,011 mm.

*Gesucht*

#enum(numbering: "a)",
[Bestimme Passungsart und Passtoleranz.],
)
][
*Vorzeichen lesen:* $P_O = +"0,030" thin "mm"$ heißt, im lockersten Fall bleiben 30 µm Spiel. $P_U = -"0,011" thin "mm"$ heißt, im strammsten Fall entsteht 11 µm Übermaß.
][
*Passungsart:* Je nach Paarung kann Spiel oder Übermaß entstehen. Das ist eine *Übergangspassung*.
][
*Passtoleranz:* $P_T = P_O - P_U = "0,030" - (-"0,011") = "0,041" thin "mm"$.
][
*Prüfen:* Die Passtoleranz ist immer positiv und gleich der Summe der Toleranzen von Bohrung und Welle.
#src[L-alt C2, offene Überarbeitung Frage 27; B S. 131–168]
]

#aufgabe(titel: "Passungen und Pass-Systeme zuordnen", art: "verstehen", quelle: "6.7", herkunft: "original", vorlage: "Buch Kap. 7, Aufg. 7.3")[
#if not web [*Aufgabe 164* #linebreak()]
Prüfen Sie, ob es sich bei den im Folgenden genannten Passungen um Übermaß-, Übergangs- oder Spielpassungen handelt.

H7/r6; H7/n6; H7/h6; H11/h11; F8/h9; H7/j6; H8/x8; J7/h6; H7/k6; S7/h6; A11/h11; H7/f7

Gehören die genannten Passungen zum System Einheitsbohrung oder Einheitswelle?
][
*Modell / Annahmen:* Worst-Case-Grenzmaße; keine statistische Verteilung voraussetzen.

Übermaß: H7/r6 (EB), H8/x8 (EB), S7/h6 (EW). Übergang: H7/n6 (EB), H7/j6 (EB), H7/k6 (EB), J7/h6 (EW). Spiel: H7/h6 und H11/h11 (beide Systeme), F8/h9 (EW), A11/h11 (EW), H7/f7 (EB) (S. 140, 158–163).

*Prüfung:* Toleranzen sind nicht negativ, und PO ist mindestens so groß wie PU. Abmaße in µm vor Addition zu mm umrechnen.

#src[L-alt C2, Frage 17; nach B S. 131–168]
]

#aufgabe(titel: "Passungen für Fügen mit und ohne Sicherung", art: "verstehen", quelle: "6.7", herkunft: "original", vorlage: "Buch Kap. 7, Aufg. 7.5")[
#if not web [*Aufgabe 165* #linebreak()]
Welche Passungen schlagen Sie jeweils vor, wenn Folgendes gefordert wird:
- nach dem Fügen ist eine zusätzliche Sicherung gegen Verdrehen/Verschieben nicht mehr erforderlich
- nach dem Fügen ist eine Sicherung gegen Verdrehen/Verschieben erforderlich
- das Fügen soll von Hand möglich sein
][
*Modell / Annahmen:* Worst-Case-Grenzmaße; keine statistische Verteilung voraussetzen.

a) Übermaß, z. B. H7/r6 oder H7/s6; b) Übergang, z. B. H7/n6 oder H7/k6; c) H7/js6 (Schiebesitz) oder H7/h6 (Gleitsitz) (Tab. 7-14).

*Prüfung:* Toleranzen sind nicht negativ, und PO ist mindestens so groß wie PU. Abmaße in µm vor Addition zu mm umrechnen.
][
*Kurz gefasst (aus der Karteikarte):*
- *Ohne zusätzliche Verdrehsicherung:* Übermaßpassung, zum Beispiel H7/r6.
- *Mit Sicherung (Passfeder):* Übergangspassung, zum Beispiel H7/k6 oder H7/n6.
- *Von Hand fügbar:* Spielpassung, zum Beispiel H7/h6.
#src[L-alt C2, Frage 21; nach B S. 131–168]
]

#aufgabe(titel: "Warum die Einheitsbohrung bevorzugt wird", art: "verstehen", quelle: "6.7", herkunft: "eigen")[
#if not web [*Aufgabe 166* #linebreak()]
Warum wird die Einheitsbohrung bevorzugt? Warum lässt man nicht alle Kombinationen zu?
][
*Antwort:* Eine einheitliche Bohrung mit verschiedenen Wellen ist fertigungstechnisch einfacher und billiger. Die Begrenzung der Kombinationen spart Werkzeuge und Lehren (S. 157, 161).
][
*Kurz gefasst (aus dem Quiz):*
- Weil eine einheitliche Bohrung (gleiche Reibahle und Lehrdorn) mit verschiedenen Wellen billiger ist als umgekehrt. Werkzeuge und Lehren für Bohrungen sind teurer, deshalb hält man sie einheitlich bei H.
][
*Typische Verwechslungen:*
- „Weil Wellen leichter zu messen sind als Bohrungen.“: Messbarkeit ist nicht der Grund.
- „Weil Einheitsbohrung immer Übermaßpassungen ergibt.“: Die Passungsart wird über die Welle gewählt. Spiel, Übergang und Übermaß sind alle möglich.
- „Weil die Einheitswelle nicht genormt ist.“: Die Einheitswelle ist genauso genormt.
][
*Kurz gefasst (aus der Karteikarte):*
- Eine Bohrung genau zu fertigen braucht Reibahlen und Lehren für jedes Maß.
- Eine Welle lässt sich leichter auf verschiedene Maße drehen und schleifen.
- Mit einer einheitlichen Bohrung H und verschiedenen Wellen spart man also Werkzeuge und Lehren.

*Merksatz:* Bohrung einheitlich halten, Welle passend fertigen.
#bild("alt-c2-2", [Toleranzfelder bei Ø50 im System Einheitsbohrung H7, maßstäblich (Werte in µm aus Tab. 7-3; eigene Skizze, vgl. Bild 7-8 und 7-21) Quelle der Skizze: L-alt C2; eigene Darstellung.], height: 50mm)
#src[L-alt C2, Frage 15; nach B S. 131–168]
]

#aufgabe(titel: "Passung für einen Wälzlagerinnenring", art: "verstehen", quelle: "6.7", herkunft: "eigen")[
#if not web [*Aufgabe 167* #linebreak()]
Welche Passung wählst Du typischerweise für einen Wälzlagerinnenring bei mittlerer Last? Begründe deine Antwort.
][
*Antwort:*
- H7/k6. Übergangspassung, Haftsitz. Merkhilfe: H7/k6 → Wälzlager.
][
*Typische Verwechslungen:*
- „H7/r6“: Das ist eine Übermaßpassung für Pressverbände.
- „H8/f7“: Das ist eine Spielpassung für drehende Lagerungen (Gleitlager).
- „H7/h6“: Gleitsitz, von Hand verschiebbar, zu locker für einen Innenring unter Umfangslast.
]


#kapitel("Kapitel 7 · Gewinde und Schraubenverbindungen")

#aufgabe(titel: "Breite und schmale Linien am Gewinde", art: "verstehen", quelle: "7.1", herkunft: "eigen")[
#if not web [*Aufgabe 168* #linebreak()]
Welche Durchmesser werden bei Außen- und Innengewinde breit, welche schmal gezeichnet? Nenne eine Eselsbrücke.
][
*Antwort:* Bolzen: Nenn-Ø breit, Kern-Ø schmal. Mutter: Kern-Ø breit, Nenn-Ø schmal. Eselsbrücke (eigene Ergänzung): breit ist die Kante, die den Körper begrenzt und die du mit dem Messschieber greifen kannst (S. 169–170).
][
*Kurz gefasst (aus dem Quiz):*
- Der Nenndurchmesser. Breit ist immer die Kante, die den Körper begrenzt. Beim Bolzen ist das der Außendurchmesser.
][
*Typische Verwechslungen:*
- „Der Kerndurchmesser“: Der Kern-Ø ist beim Bolzen schmal. Breit ist er bei der Mutter.
- „Beide“: Dann könnte man Außen- und Innengewinde nicht unterscheiden.
- „Keine, Gewinde werden nur schmal gezeichnet“: Die Körperkante wird immer breit gezeichnet.
][
*Kurz gefasst (aus der Karteikarte):*
- Beim Bolzen ist der Nenndurchmesser breit und der Kerndurchmesser schmal.
- Bei der Mutter ist es umgekehrt.
- Breit ist immer die Kante, die den Körper begrenzt und die man mit dem Messschieber greifen kann.

*Merksatz:* Breit ist die greifbare Körperkante.
#bild("b-gewinde", [Bild 8-3: Außen- und Innengewinde in axialer Ansicht. B, S. 171 (PDF-S. 182).], height: 50mm)
#src[L-alt D1, Frage 1; nach B S. 169–196]
]

#aufgabe(titel: "Gewinde in axialer Ansicht", art: "verstehen", quelle: "7.1", herkunft: "eigen")[
#if not web [*Aufgabe 169* #linebreak()]
Wie sieht ein Gewinde in axialer Ansicht aus, und warum nur ein ¾-Kreis?
][
*Antwort:* Bolzen: Nenn-Ø voller breiter Kreis, Kern-Ø schmaler ¾-Kreis; Mutter umgekehrt. Die Kernlinie windet sich durch die Steigung nach unten und ist nur etwa über 270° sichtbar (S. 171).
][
*Kurz gefasst (aus der Karteikarte):*
- Die Linie des Gewindegrunds windet sich durch die Steigung nach unten und ist deshalb nur über etwa 270° sichtbar.
- Beim Bolzen ist der Kern der schmale ¾-Kreis, bei der Mutter der Nenndurchmesser.
#bild("b-gewinde", [Bild 8-3: Außen- und Innengewinde in axialer Ansicht. B, S. 171 (PDF-S. 182).], height: 50mm)
#src[L-alt D1, Frage 2; nach B S. 169–196]
]

#aufgabe(titel: "Welches Gewinde Vorrang hat", art: "verstehen", quelle: "7.1", herkunft: "eigen")[
#if not web [*Aufgabe 170* #linebreak()]
Welches Gewinde hat bei verschraubten Teilen Vorrang? Was bedeutet das für die Schraffur?
][
*Antwort:* Das Bolzengewinde. Seine Kanten werden breit gezeichnet, die Schraffur der Mutter endet an der Körperkante des Bolzens (S. 170–171).
][
*Kurz gefasst (aus der Karteikarte):*
- Das Bolzengewinde.
- Seine Kanten werden breit gezeichnet, und die Schraffur der Mutter endet an der Kante des Bolzens.

*Merksatz:* Beim verschraubten Paar hat das Bolzengewinde Vorrang.
#bild("b-gewinde", [Bild 8-3: Außen- und Innengewinde in axialer Ansicht. B, S. 171 (PDF-S. 182).], height: 50mm)
#src[L-alt D1, Frage 3; nach B S. 169–196]
]

#aufgabe(titel: "Linien an der geschnittenen Gewindebohrung", art: "verstehen", quelle: "7.1", herkunft: "eigen")[
#if not web [*Aufgabe 171* #linebreak()]
Welche Linienbreiten und Schraffurgrenzen gelten bei einer geschnittenen Gewindebohrung?
][
*Antwort:* geht die Schraffur bis zum Kerndurchmesser. ist der Nenndurchmesser eine schmale Linie.

#src[L-alt D1, offene Überarbeitung Frage 19; B S. 169–196]
]

#aufgabe(titel: "Sackloch-Schraubverbindung zeichnen", art: "rechnen", quelle: "7.1", herkunft: "original", vorlage: "Altklausur WS 20/21, Aufg. 3", minuten: 14, platz: 18)[
#if not web [*Aufgabe 172* #linebreak()]
Zeichnen Sie folgende Schraubverbindung. (15 Punkte)

#tab(columns: (1fr, auto),
 [Schraubverbindung mit Sackloch], [M20],
 [Durchmesser Durchgangsbohrung], [24 mm],
 [Kernloch/Gewindegrunddurchmesser], [17 mm],
 [Schraubenlänge], [50 mm],
 [Nutzbare Gewindelänge Schraube], [45 mm],
 [Nutzbare Länge Innengewinde], [45 mm],
 [Sacklochtiefe], [65 mm],
)
#bild("ak-schraubverbindung", [Originalausschnitt AK, PDF-S. 7 (Zylinderschraube durch ein oberes Bauteil in ein Gehäuse); mit vorhandenen handschriftlichen Einträgen.], height: 90mm)
][
*Aufbau verstehen:* Die Zylinderschraube geht durch die Durchgangsbohrung Ø24 des oberen Teils und ist in das Sackloch des unteren Teils eingeschraubt. Die Durchgangsbohrung ist größer als M20, damit die Schraube nur im Gehäuse trägt und das obere Teil nur klemmt.
][
*Längen abtragen:* Schraubenlänge 50 mm ab Kopfauflage. Davon sind 45 mm nutzbares Außengewinde, die restlichen 5 mm unter dem Kopf sind Schaft. Im Gehäuse: nutzbares Innengewinde 45 mm ab Gehäuseoberfläche, Bohrtiefe des Sacklochs 65 mm (zylindrischer Teil), am Ende die 120°-Bohrspitze. Zwischen Gewindeende und Bohrgrund bleiben also 20 mm für Auslauf und Überhang.
][
*Linien der Gewinde:* Bolzen: Nenn-Ø 20 breit, Kern-Ø schmal. Gewindebohrung: Kern-Ø (hier 17 mm) breit, Nenn-Ø 20 schmal. Im eingeschraubten Bereich hat das Bolzengewinde Vorrang: Dort sieht man nur die Linien der Schraube. Ende der nutzbaren Gewinde jeweils mit breiter Volllinie.
][
*Schnitt und Schraffur:* Die Schraube wird im Längsschnitt nicht geschnitten. Oberes Teil und Gehäuse gegensinnig schraffieren; im freien Innengewinde unterhalb der Schraube geht die Schraffur bis an die breite Kernlinie (Ø17). Die Bohrspitze wird nicht als Gewinde gezeichnet.
][
*Prüfen:* 65 mm Sacklochtiefe sind nicht 65 mm Gewinde. Ø17 ist der in der Aufgabe vorgegebene Zeichenwert (der rechnerische Kern-Ø der Mutter wäre $D_1 = 20 - "1,08253" dot "2,5" approx "17,3" thin "mm"$). Die Dicke des oberen Teils ist nur zeichnerisch vorgegeben, also nicht zusätzlich erfinden.

#src[AK 3, PDF-S. 7; eigene Lösung mit B S. 169–173]
]

#aufgabe(titel: "Sackloch-Schraubverbindung M16 in Grauguss (Variante)", art: "rechnen", quelle: "7.1", herkunft: "variante", vorlage: "Altklausur WS 20/21, Aufg. 3", minuten: 15, platz: 18,
  ergebnis: [a) 20 mm; b) l = 40 mm; c) nutzbares Innengewinde 25 mm, Bohrtiefe 34,3 mm (ohne Spitze), Spitzenhöhe ≈ 4,2 mm; d) d#sub[3] ≈ 13,55 mm, D#sub[1] ≈ 13,83 mm],
  tipp: [Erst die Einschraublänge aus dem Werkstoff bestimmen, dann die Schraubenlänge aus Klemmteil plus Einschraublänge.],
)[
#if not web [*Aufgabe 173* #linebreak()]
*Gegeben und Annahmen*

Ein 20 mm dicker Deckel wird mit einer Zylinderschraube ISO 4762 M16 (Regelgewinde, $P = 2$ mm) an ein Gehäuse aus Grauguss geschraubt (Sackloch). Durchgangsbohrung im Deckel Ø17,5 mm, Kernlochbohrung Ø14 mm mit 118°-Bohrspitze. Mindest-Einschraublänge: Stahl $1 d$, Grauguss $"1,25" d$, Aluminium $2 d$. Lieferbare Schraubenlängen: 35, 40, 45, 50 mm. Das Schraubenende soll mindestens 5 mm vor dem Ende des nutzbaren Innengewindes bleiben. Grundlochüberhang für M16: $e = "9,3"$ mm.

*Gesucht*

#enum(numbering: "a)",
[Mindest-Einschraublänge im Gehäuse.],
[Kürzeste geeignete Schraubenlänge und tatsächliche Einschraubtiefe.],
[Nutzbare Innengewindelänge und Bohrtiefe des Sacklochs; Höhe der Bohrspitze.],
[Kerndurchmesser von Bolzen- und Muttergewinde und welche Linie jeweils breit gezeichnet wird.],
[Zeichne die Verbindung im Schnitt (Maßstab 1 : 1).],
)
][
*a) Einschraublänge:* Grauguss ist weicher und spröder als Stahl, die Gänge im Gehäuse würden früher ausreißen. Deshalb $"1,25" dot 16 = 20$ mm.
][
*b) Schraubenlänge:* Die Länge zählt ab Kopfauflage. Nötig: Klemmlänge + Einschraublänge $= 20 + 20 = 40$ mm. Die kürzeste lieferbare Länge, die das erfüllt, ist 40 mm; Einschraubtiefe dann genau $40 - 20 = 20$ mm.
][
*c) Gewinde und Bohrung:* Nutzbares Innengewinde = Einschraubtiefe + 5 mm Sicherheit = 25 mm. Danach braucht der Gewindebohrer Auslauf: Bohrtiefe (zylindrischer Teil) $25 + "9,3" = "34,3"$ mm. Die 118°-Spitze kommt dazu: Höhe $7 \/ tan 59° approx "4,2"$ mm.
][
*d) Durchmesser und Linien:* Bolzen $d_3 = 16 - "1,22687" dot 2 approx "13,55"$ mm, Mutter $D_1 = 16 - "1,08253" dot 2 approx "13,83"$ mm (die Kernlochbohrung Ø14 liegt knapp darüber). Bolzen: Nenn-Ø breit, Kern-Ø schmal. Innengewinde: Kern-Ø breit, Nenn-Ø schmal. Im Eingriff hat der Bolzen Vorrang.
][
*e) Zeichnen und prüfen:* Schraube ungeschnitten, Deckel und Gehäuse gegensinnig schraffiert, Schraffur im freien Innengewinde bis zur breiten Kernlinie, Gewindeenden als breite Volllinien. Prüfen: Das Schraubenende (20 mm tief) liegt 5 mm vor dem Gewindeende (25 mm), das Gewindeende 9,3 mm vor dem Bohrgrund.
#src[Variante zu AK 3; Einschraublängen und Grundlochüberhang nach Lernskript 7.2/7.4 (B S. 172–184), Durchgangsbohrung mittel nach ISO 273]
]

#aufgabe(titel: "Sackloch-Schraubverbindung M12 in Aluminium (Variante)", art: "rechnen", quelle: "7.1", herkunft: "variante", vorlage: "Altklausur WS 20/21, Aufg. 3", minuten: 12, platz: 16,
  ergebnis: [a) 24 mm, Einschraubtiefe 25 mm reicht; b) 5 mm; c) 12 mm; d) x ≈ 4,4 mm; e) d#sub[3] ≈ 9,85 mm, D#sub[1] ≈ 10,11 mm; 5 mm Bolzengewinde liegen in der Durchgangsbohrung],
  tipp: [Zeichne Dir die Längen als Zahlenstrahl ab der Gehäuseoberfläche: Schraubenende, Ende des Innengewindes, Bohrgrund.],
)[
#if not web [*Aufgabe 174* #linebreak()]
*Gegeben und Annahmen*

Schraubverbindung mit Sackloch wie in der Altklausur, jetzt in ein Aluminiumgehäuse:
#tab(columns: (1fr, auto),
 [Gewinde], [M12 ($P = "1,75"$ mm)],
 [Dicke des oberen Teils (Klemmlänge)], [15 mm],
 [Durchmesser Durchgangsbohrung], [13,5 mm],
 [Kernloch], [10,2 mm],
 [Schraubenlänge], [40 mm],
 [Nutzbare Gewindelänge Schraube], [30 mm],
 [Nutzbare Länge Innengewinde], [30 mm],
 [Sacklochtiefe (Bohrtiefe ohne Spitze)], [42 mm],
)
Mindest-Einschraublänge in Aluminium $2 d$; Gewindeauslauf $x approx "2,5" P$.

*Gesucht*

#enum(numbering: "a)",
[Mindest-Einschraublänge und tatsächliche Einschraubtiefe. Reicht die Schraube?],
[Abstand des Schraubenendes vom Ende des nutzbaren Innengewindes.],
[Wie viel Bohrtiefe bleibt unter dem nutzbaren Innengewinde?],
[Gewindeauslauf $x$ schätzen.],
[Kerndurchmesser $d_3$ und $D_1$; wo endet das Gewinde der Schraube?],
)
][
*a) Einschraublänge:* Aluminium braucht $2 dot 12 = 24$ mm. Die Schraube steckt $40 - 15 = 25$ mm tief im Gehäuse, $25 >= 24$: Sie reicht knapp.
][
*b) Reserve im Gewinde:* $30 - 25 = 5$ mm. Die Schraube stößt also nicht am Gewindeende an, sie kann voll angezogen werden.
][
*c) Bohrreserve:* $42 - 30 = 12$ mm unter dem nutzbaren Gewinde, Platz für Gewindeauslauf und Anschnitt des Gewindebohrers.
][
*d) Auslauf:* $x approx "2,5" dot "1,75" approx "4,4"$ mm. Er passt in die 12 mm Reserve.
][
*e) Durchmesser und Gewindeende:* $d_3 = 12 - "1,22687" dot "1,75" approx "9,85"$ mm, $D_1 = 12 - "1,08253" dot "1,75" approx "10,11"$ mm. Das Schraubengewinde ist 30 mm lang, im Gehäuse stecken 25 mm, also liegen 5 mm Gewinde noch in der Durchgangsbohrung des oberen Teils. Gut so: Das Gewindeende liegt oberhalb der Trennfuge, das Innengewinde wird voll genutzt. Zeichnen wie im Original (Bolzen hat Vorrang, Schraube ungeschnitten).
#src[Variante zu AK 3; Einschraublängen und Auslauf nach Lernskript 7.2/7.4 (B S. 172–184)]
]

#aufgabe(titel: "Nutzbare Länge, Auslauf und Überhang", art: "verstehen", quelle: "7.2", herkunft: "eigen")[
#if not web [*Aufgabe 175* #linebreak()]
Was ist die nutzbare Gewindelänge, der Gewindeauslauf und der Grundlochüberhang?
][
*Antwort:* Nutzbare Länge: Anlagefläche bis letzter voller Gang (Ende als breite Linie). Auslauf: herstellungsbedingter Rest mit kleiner werdenden Gängen, ca. 2,5 · P. Grundlochüberhang: zusätzliche Bohrtiefe bei Innengewinden für das Schneiden (S. 172–173).
][
*Kurz gefasst (aus der Karteikarte):*
- Die nutzbare Länge reicht bis zum letzten vollen Gang.
- Der Auslauf ist der herstellungsbedingte Rest mit kleiner werdenden Gängen.
- Der Grundlochüberhang ist die zusätzliche Bohrtiefe, damit das Werkzeug das Innengewinde schneiden kann.
#src[L-alt D1, Frage 4; nach B S. 169–196]
]

#aufgabe(titel: "Gewindeauslauf bei M16 schätzen", art: "rechnen", quelle: "7.2", herkunft: "eigen",
  ergebnis: [$x approx "2,5" P = 5 thin "mm"$, gleich dem Normwert],
  tipp: [Die Faustregel nimmt ein Vielfaches der Steigung. M16 hat P = 2 mm.],
)[
#if not web [*Aufgabe 176* #linebreak()]
*Gegeben und Annahmen*

Regelgewinde M16, Steigung $P=2 thin "mm"$. Zum Vergleich: Normwert des Auslaufs in der verwendeten Unterlage 5 mm.

*Gesucht*

#enum(numbering: "a)",
[Schätze den Gewindeauslauf mit der Faustregel und vergleiche mit dem vorgegebenen Normwert.],
)
][
*Bild:* Am Ende eines geschnittenen Gewindes laufen die Gänge nicht abrupt aus, sondern werden allmählich flacher. Dieser Übergang ist der Auslauf.
][
*Steigung:* M16 hat die Regelsteigung $P = 2 thin "mm"$.
][
*Faustregel:* $x approx "2,5" dot P = "2,5" dot 2 = 5 thin "mm"$.
][
*Vergleich:* Der Normwert für M16 ist ebenfalls 5 mm (S. 172–173). Die Faustregel trifft hier genau.
#src[L-alt D1, Frage 18; nach B S. 169–196]
]

#aufgabe(titel: "Linksgewinde kennzeichnen", art: "verstehen", quelle: "7.3", herkunft: "original", vorlage: "Buch Kap. 8, Aufg. 8.4")[
#if not web [*Aufgabe 177* #linebreak()]
Wie wird ein linksdrehendes Gewinde in Technischen Zeichnungen gekennzeichnet?
][
*Antwort:* Mit dem Zusatz „-LH“, z. B. „M16 – LH“ (S. 176).

#src[L-alt D1, Frage 6; nach B S. 169–196]
]

#aufgabe(titel: "Feingewinde und Regelgewinde", art: "verstehen", quelle: "7.3", herkunft: "variante", vorlage: "Buch Kap. 8, Aufg. 8.3")[
#if not web [*Aufgabe 178* #linebreak()]
Wie unterscheidet sich ein Feingewinde vom Regelgewinde, und wie erkennt man es an der Bezeichnung (Buch 8.3)?
][
*Antwort:* Kleinere Steigung, gleiches 60°-Profil. In der Bezeichnung steht die Steigung („M16 × 1,5“); fehlt sie, ist es Regelgewinde (S. 175–176).

#src[L-alt D1, Frage 5; nach B S. 169–196]
]

#aufgabe(titel: "Trapez-, Säge- und Rundgewinde", art: "verstehen", quelle: "7.3", herkunft: "eigen")[
#if not web [*Aufgabe 179* #linebreak()]
Wofür nimmt man Trapez-, Säge- und Rundgewinde? Warum muss man beim Trapezgewinde immer die Steigung angeben?
][
*Antwort:* Trapez: Bewegungsgewinde in beide Richtungen (Leitspindeln, Schraubstöcke). Säge: Last nur in einer Richtung (Pressen). Rund: Stöße, Schmutz, Blech (Glühlampen). Beim Trapezgewinde gehören zu jedem Ø zwei oder drei Steigungen (S. 177–179).
][
*Kurz gefasst (aus der Karteikarte):*
- Trapezgewinde für Bewegungen in beide Richtungen (Leitspindeln, Schraubstöcke).
- Sägengewinde für Last in nur einer Richtung (Pressen).
- Rundgewinde bei Stößen und Schmutz.
#src[L-alt D1, Frage 7; nach B S. 169–196]
]

#aufgabe(titel: "Was 6g am Gewinde bedeutet", art: "verstehen", quelle: "7.3", herkunft: "eigen")[
#if not web [*Aufgabe 180* #linebreak()]
Was bedeutet „6g“ an einem Gewinde, und warum steht die Zahl vorn?
][
*Antwort:* Toleranzgrad 6, Lage g für ein Außengewinde. Die Zahl steht vorn, damit man die Angabe nicht mit einer normalen Rundpassung verwechselt, deren Werte anders sind (S. 180).

#src[L-alt D1, Frage 8; nach B S. 169–196]
]

#aufgabe(titel: "Feingewinde an der Bezeichnung erkennen", art: "verstehen", quelle: "7.3", herkunft: "eigen")[
#if not web [*Aufgabe 181* #linebreak()]
Woran erkennst Du M20 × 1,5 und M8 × 1 als Feingewinde?
][
*Antwort:* M20 × 1,5. M8 × 1.
][
*Kurz gefasst (aus der Karteikarte):*
- Es hat dasselbe 60°-Profil, aber eine kleinere Steigung.
- Die Steigung steht in der Bezeichnung, zum Beispiel M16 × 1,5.
- Fehlt sie, ist es ein Regelgewinde.

*Merksatz:* Feine Steigung wird ausdrücklich angegeben.
#src[L-alt D1, offene Überarbeitung Frage 20; B S. 169–196]
]

#aufgabe(titel: "Mittlere Gewindetoleranzklassen", art: "verstehen", quelle: "7.3", herkunft: "eigen")[
#if not web [*Aufgabe 182* #linebreak()]
Welche mittleren Gewindetoleranzklassen verwendet das Buch ohne nähere Angabe?
][
*Antwort:* 6H/6g. die Toleranzklasse „mittel“.

#src[L-alt D1, offene Überarbeitung Frage 21; B S. 169–196]
]

#aufgabe(titel: "Bezeichnung Tr16 × 4 P2 lesen", art: "verstehen", quelle: "7.3", herkunft: "eigen")[
#if not web [*Aufgabe 183* #linebreak()]
Was bedeutet die Bezeichnung „Tr16 × 4 P2“? Begründe deine Antwort.
][
*Antwort:*
- Zweigängiges Trapezgewinde, d = 16 mm, Steigung 4 mm, Teilung 2 mm. $n = P_h \/ P = 4 \/ 2 = 2$ Gänge.
][
*Typische Verwechslungen:*
- „Feingewinde mit 16 mm Durchmesser und 4 mm Steigung“: Tr steht für Trapezgewinde, nicht für ein metrisches Feingewinde.
- „Trapezgewinde mit 4 Gängen und 2 mm Steigung“: Die 4 ist die Steigung $P_h$, die Gangzahl folgt erst aus $P_h \/ P$.
- „Trapezgewinde mit Linksgang“: Linksgewinde wird mit LH gekennzeichnet.
]

#aufgabe(titel: "Gewindedurchmesser von M10", art: "rechnen", quelle: "7.3", herkunft: "eigen",
  ergebnis: [$d_2 approx "9,026" thin "mm"$, $D_1 approx "8,376" thin "mm"$, $d_3 approx "8,160" thin "mm"$],
  tipp: [Alle drei Durchmesser sind Nenndurchmesser minus Faktor mal Steigung.],
)[
#if not web [*Aufgabe 184* #linebreak()]
*Gegeben und Annahmen*

Metrisches Regelgewinde M10 mit $P="1,5" thin "mm"$.

*Gesucht*

#enum(numbering: "a)",
[Berechne $d_2$, $D_1$ und $d_3$.],
)
][
*Bild:* Ein Gewinde hat mehrere Durchmesser: außen den Nenndurchmesser, in der Mitte der Flanken den Flankendurchmesser $d_2$, innen den Kerndurchmesser der Schraube $d_3$ und den der Mutter $D_1$. Alle hängen von der Steigung ab, weil tiefere Gänge mehr wegnehmen.
][
*Flankendurchmesser:* $d_2 = d - "0,64953" P = 10 - "0,974" = "9,026" thin "mm"$.
][
*Kerndurchmesser der Mutter:* $D_1 = d - "1,08253" P = 10 - "1,624" = "8,376" thin "mm"$.
][
*Kerndurchmesser der Schraube:* $d_3 = d - "1,22687" P = 10 - "1,840" = "8,160" thin "mm"$.
][
*Prüfen:* $d_3 < D_1 < d_2 < d$. Der Schraubenkern ist am kleinsten, sonst würde die Mutter nicht passen.
#src[L-alt D1, Frage 13; nach B S. 169–196]
]

#aufgabe(titel: "Mehrgängiges Trapezgewinde Tr40 × 14 P7", art: "rechnen", quelle: "7.3", herkunft: "eigen",
  ergebnis: [Steigung 14 mm, Teilung 7 mm, zweigängig; 42 mm nach 3 Umdrehungen],
  tipp: [Die Zahl hinter × ist die Steigung, die hinter P die Teilung.],
)[
#if not web [*Aufgabe 185* #linebreak()]
*Gegeben und Annahmen*

Ein Gewinde ist mit „Tr40 × 14 P7“ bezeichnet.

*Gesucht*

#enum(numbering: "a)",
[Bestimme Steigung, Teilung und Gangzahl.],
[Wie weit bewegt sich die Mutter bei 3 Umdrehungen?],
)
][
*Bild:* Stell dir zwei Wendeltreppen vor, die ineinander laufen. Die Teilung ist der Abstand zwischen zwei benachbarten Stufen, die Steigung der Weg, den eine einzelne Treppe pro Umdrehung hochgeht.
][
*Bezeichnung lesen:* Tr40 heißt Trapezgewinde mit 40 mm Nenndurchmesser. Steigung $P_h = 14 thin "mm"$, Teilung $P = 7 thin "mm"$.
][
*Gangzahl:* $n = P_h \/ P = 14\/7 = 2$, also zweigängig.
][
*Weg der Mutter:* Pro Umdrehung bewegt sie sich um die Steigung: $3 dot 14 = 42 thin "mm"$.
][
*Prüfen:* Bei einem eingängigen Gewinde wären Steigung und Teilung gleich. Mehrgängig heißt schneller Vorschub bei gleicher Gangtiefe.
#src[L-alt D1, Frage 14; nach B S. 169–196]
]

#aufgabe(titel: "Gewindedurchmesser von M20", art: "rechnen", quelle: "7.3", herkunft: "eigen",
  ergebnis: [$d_2 approx "18,376" thin "mm"$, $d_3 approx "16,933" thin "mm"$],
  tipp: [Gleiche Faktoren wie bei M10, nur mit P = 2,5 mm.],
)[
#if not web [*Aufgabe 186* #linebreak()]
*Gegeben und Annahmen*

Regelgewinde M20 mit $P="2,5" thin "mm"$.

*Gesucht*

#enum(numbering: "a)",
[Berechne $d_2$ und $d_3$.],
)
][
*Formeln:* $d_2 = d - "0,64953" P$ und $d_3 = d - "1,22687" P$.
][
*Flankendurchmesser:* $d_2 = 20 - "0,64953" dot "2,5" = 20 - "1,624" = "18,376" thin "mm"$.
][
*Kerndurchmesser:* $d_3 = 20 - "1,22687" dot "2,5" = 20 - "3,067" = "16,933" thin "mm"$.
][
*Prüfen:* $d_3 < d_2 < d$. Das sind theoretische Profilmaße, keine Bohrerempfehlung.
#src[L-alt L4; B Bild 8-8, S. 174–175]
]

#aufgabe(titel: "Gewindedurchmesser von M12", art: "rechnen", quelle: "7.3", herkunft: "eigen",
  ergebnis: [$d_2 approx "10,863"$, $d_3 approx "9,853"$, $D_1 approx "10,106" thin "mm"$],
  tipp: [Erst die drei Abzüge Faktor mal P ausrechnen, dann von 12 mm abziehen.],
)[
#if not web [*Aufgabe 187* #linebreak()]
*Gegeben und Annahmen*

Regelgewinde M12 mit $P="1,75" thin "mm"$.

*Gesucht*

#enum(numbering: "a)",
[Berechne $d_2$, $d_3$ und $D_1$.],
)
][
*Abzüge:* $"0,64953" dot "1,75" approx "1,137"$; $"1,22687" dot "1,75" approx "2,147"$; $"1,08253" dot "1,75" approx "1,894" thin "mm"$.
][
*Flankendurchmesser:* $d_2 = 12 - "1,137" = "10,863" thin "mm"$.
][
*Kerndurchmesser Schraube:* $d_3 = 12 - "2,147" = "9,853" thin "mm"$.
][
*Kerndurchmesser Mutter:* $D_1 = 12 - "1,894" = "10,106" thin "mm"$.
][
*Prüfen:* $d_3 < D_1 < d_2$: Die Mutter lässt im Kern etwas Platz für die Schraube.
#src[L-alt A4; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

#aufgabe(titel: "Dehnschraube und Passschraube", art: "verstehen", quelle: "7.4", herkunft: "eigen")[
#if not web [*Aufgabe 188* #linebreak()]
Was ist eine Dehnschraube, was eine Passschraube?
][
*Antwort:* Dehnschraube: Schaft auf ca. 90 % des Gewinde-Ø verjüngt, dehnt sich beim Anziehen und wirkt als Feder. Passschraube: Schaft mit Passdurchmesser zur Bohrung; sie hält und positioniert zugleich (S. 184).
][
*Kurz gefasst (aus der Karteikarte):*
- Bei der Dehnschraube ist der Schaft dünner als das Gewinde.
- Sie dehnt sich beim Anziehen und wirkt wie eine Feder, die die Vorspannkraft hält.
- Die Passschraube hat einen Schaft mit Passmaß zur Bohrung.
- Sie hält und positioniert zugleich.

*Merksatz:* Dehnschraube federt, Passschraube positioniert.
#src[L-alt D1, Frage 9; nach B S. 169–196]
]

#aufgabe(titel: "Einschraublänge in Aluminium und Grauguss", art: "verstehen", quelle: "7.4", herkunft: "eigen")[
#if not web [*Aufgabe 189* #linebreak()]
Eine Stiftschraube M16 wird in ein Aluminiumgehäuse geschraubt. Wie lang muss das Einschraubende mindestens sein? Und in Grauguss?
][
*Modell / Annahmen:* Theoretisches Gewindeprofil beziehungsweise im Buch angegebene Zeichenrichtwerte; keine Festigkeitsbemessung.

Aluminium: L ≥ 2 · d = 32 mm. Grauguss: L ≥ 1,25 · 16 = 20 mm (Bild 8-22, S. 184).

*Prüfung:* Durchmesser und Steigung haben dieselbe Einheit; ein Kerndurchmesser bleibt kleiner als der Nenndurchmesser.

#src[L-alt D1, Frage 16; nach B S. 169–196]
]

#aufgabe(titel: "Schraube M10 in Grauguss", art: "rechnen", quelle: "7.4", herkunft: "eigen",
  ergebnis: [a) 12,5 mm, b) $d_3 approx "8,160" thin "mm"$, c) die Linien des Außengewindes],
  tipp: [Weichere Werkstoffe brauchen längere Einschraubtiefen. In der Verschraubung hat der Bolzen Vorrang.],
)[
#if not web [*Aufgabe 190* #linebreak()]
*Gegeben und Annahmen*

Eine Schraube M10 (P = 1,5 mm) wird in ein Gehäuse aus Grauguss eingeschraubt.

*Gesucht*

#enum(numbering: "a)",
[Welche Einschraublänge ist mindestens nötig?],
[Wie groß ist d3?],
[Welche Linie liegt in der Zeichnung im Bereich der Verschraubung vorne?],
)
][
*Bild:* Grauguss ist spröder und weicher als Stahl. Damit die Gänge im Gehäuse nicht ausreißen, muss die Schraube tiefer hinein.
][
*a) Einschraublänge:* Für Grauguss gilt etwa $"1,25" dot d = "1,25" dot 10 = "12,5" thin "mm"$ (S. 184). In Stahl würde etwa $1 dot d$ reichen.
][
*b) Kerndurchmesser:* $d_3 = 10 - "1,22687" dot "1,5" approx "8,160" thin "mm"$.
][
*c) Darstellung:* Der eingeschraubte Bolzen hat Vorrang. Seine Linien (Außengewinde) liegen vorne und verdecken das Innengewinde.
#src[L-alt G4; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

#aufgabe(titel: "Unterlegscheiben und Federringe", art: "verstehen", quelle: "7.5", herkunft: "variante", vorlage: "Buch Kap. 8, Aufg. 8.6")[
#if not web [*Aufgabe 191* #linebreak()]
Können Unterlegscheiben zu den Sicherungselementen gezählt werden (Buch 8.6)? Wie bewertet das Buch Federringe?
][
*Antwort:* Nein, eine Unterlegscheibe ist keine Sicherung gegen Aufdrehen (S. 187). Federringe gelten bei Fachleuten als unwirksame Sicherung, weil Versuche die Vorspannung nicht sicher nachweisen konnten (S. 188).
][
*Kurz gefasst (aus dem Quiz):*
- Nein, sie verteilt die Kraft und schützt weiche Flächen, sichert aber nicht. Auch der Federring gilt in Versuchen als unwirksame Sicherung.
][
*Typische Verwechslungen:*
- „Ja, sie erhöht die Reibung und hält die Mutter fest.“: Sie senkt bei rauer Fläche eher die Reibung beim Anziehen und verteilt die Kraft.
- „Ja, aber nur zusammen mit einem Federring.“: Auch der Federring sichert in Versuchen nicht wirksam.
- „Nur bei Feingewinde“: Die Gewindeart ändert nichts an der Funktion der Scheibe.
][
*Kurz gefasst (aus der Karteikarte):*
- *Nach dem Buch nicht:* Versuche konnten nicht nachweisen, dass er die Vorspannung sicher hält.
- Auch eine Unterlegscheibe ist keine Sicherung gegen Losdrehen.
#src[L-alt D1, Frage 10; nach B S. 169–196]
]

#aufgabe(titel: "Federring darstellen", art: "verstehen", quelle: "7.5", herkunft: "eigen")[
#if not web [*Aufgabe 192* #linebreak()]
Wie stellt man einen Federring dar und warum nie geschnitten?
][
*Antwort:* Im zusammengepressten Zustand, Schlitzseite nach vorn, Schlitzneigung richtig. Geschnitten sähe er wie eine einfache Unterlegscheibe aus (S. 188).

#src[L-alt D1, Frage 11; nach B S. 169–196]
]

#aufgabe(titel: "Kronenmutter, Sicherungsblech, selbstsichernde Mutter", art: "verstehen", quelle: "7.5", herkunft: "eigen")[
#if not web [*Aufgabe 193* #linebreak()]
Wie verhindern Kronenmutter mit Splint, Sicherungsblech und selbstsichernde Mutter ein Losdrehen?
][
*Antwort:* Kronenmutter mit Splint. Sicherungsblech mit umgebogenem Lappen. selbstsichernde Mutter.

#src[L-alt D1, offene Überarbeitung Frage 22; B S. 169–196]
]

#aufgabe(titel: "Normbezeichnung von Schraube und Mutter", art: "verstehen", quelle: "7.6", herkunft: "original", vorlage: "Buch Kap. 8, Aufg. 8.8 und 8.9")[
#if not web [*Aufgabe 194* #linebreak()]
#enum(numbering: "a)",
[Geben Sie die Bezeichnung nach Norm für eine Sechskantschraube nach DIN EN ISO 4014 mit M12 Linksgewinde, einer Nennlänge von 50 mm und einer Festigkeitsklasse von 10.8 an.],
[Geben Sie die Bezeichnung nach Norm für eine Sechskantmutter nach DIN EN ISO 4032 mit M12 Linksgewinde und der Festigkeitsklasse 10 an.],
)
][
*Modell / Annahmen:* Theoretisches Gewindeprofil beziehungsweise im Buch angegebene Zeichenrichtwerte; keine Festigkeitsbemessung.

Sechskantschraube ISO 4014 – M12 – LH × 50 – 10.8; Sechskantmutter ISO 4032 – M12 – LH – 10 (Aufbau nach DIN 962, S. 192–193). Hinweis: In der Praxis üblich ist die Festigkeitsklasse 10.9 (Ergänzung).

*Prüfung:* Durchmesser und Steigung haben dieselbe Einheit; ein Kerndurchmesser bleibt kleiner als der Nenndurchmesser.

#src[L-alt D1, Frage 15; nach B S. 169–196]
]

#aufgabe(titel: "Warum Normteile nicht bemaßt werden", art: "verstehen", quelle: "7.6", herkunft: "eigen")[
#if not web [*Aufgabe 195* #linebreak()]
Warum werden Normteile nicht bemaßt?
][
*Antwort:* Ihre Maße sind durch die Norm festgelegt; die Normbezeichnung in der Stückliste reicht für Bestellung und Montage (S. 192).
][
*Kurz gefasst (aus der Karteikarte):*
- Ihre Maße sind durch die Norm festgelegt.
- Die Normbezeichnung in der Stückliste reicht für Bestellung und Montage.

*Merksatz:* Normteil bestellen heißt: Normbezeichnung nennen.
#src[L-alt D1, Frage 12; nach B S. 169–196]
]

#aufgabe(titel: "Festigkeitsklasse 8.8 lesen", art: "verstehen", quelle: "7.6", herkunft: "eigen")[
#if not web [*Aufgabe 196* #linebreak()]
Was bedeutet die Festigkeitsklasse 8.8 einer Schraube? Begründe deine Antwort.
][
*Antwort:*
- Zugfestigkeit 800 N/mm², Streckgrenze 640 N/mm². Erste Zahl × 100 = $R_m$, zweite Zahl / 10 = Streckgrenzenverhältnis: $"0,8" dot 800 = 640$.
][
*Typische Verwechslungen:*
- „Zugfestigkeit 88 N/mm²“: Die beiden Zahlen werden nicht zusammengelesen.
- „Streckgrenze 800 N/mm², Zugfestigkeit 880 N/mm²“: Die erste Zahl gibt die Zugfestigkeit an, nicht die Streckgrenze.
- „Gewindesteigung 8,8 mm“: Die Steigung steht in der Gewindebezeichnung, nicht in der Festigkeitsklasse.
]

#aufgabe(titel: "Festigkeitsklasse 10.9", art: "rechnen", quelle: "7.6", herkunft: "eigen",
  ergebnis: [$R_m = 1000 thin "N/mm"^2$, $R_("p0,2") = 900 thin "N/mm"^2$],
  tipp: [Erste Zahl mal 100 gibt die Zugfestigkeit, die zweite Zahl ist das Streckgrenzenverhältnis in Zehnteln.],
)[
#if not web [*Aufgabe 197* #linebreak()]
*Gegeben und Annahmen*

Schraube der Festigkeitsklasse 10.9.

*Gesucht*

#enum(numbering: "a)",
[Erkläre die beiden Zahlen und berechne $R_m$ und $R_(p "0,2")$.],
)
][
*Bild:* Die Zahl auf dem Schraubenkopf ist eine verschlüsselte Festigkeitsangabe. Sie verrät, wie stark die Schraube ist und ab wann sie sich bleibend verformt.
][
*Erste Zahl:* 10 mal 100 ergibt die Mindestzugfestigkeit: $R_m = 1000 thin "N/mm"^2$.
][
*Zweite Zahl:* 9 heißt, die Dehngrenze liegt bei 0,9 mal $R_m$: $R_("p0,2") = "0,9" dot 1000 = 900 thin "N/mm"^2$.
][
*Prüfen:* Dieselbe Regel gibt für 8.8 die Werte 800 und 640 N/mm². Die Dehngrenze ist immer kleiner als die Zugfestigkeit.
#src[L-alt D1, Frage 17; nach B S. 169–196]
]


#kapitel("Kapitel 8 · Elemente an Achsen und Wellen")

#aufgabe(titel: "Genormte Wellenenden", art: "verstehen", quelle: "8.1", herkunft: "eigen")[
#if not web [*Aufgabe 198* #linebreak()]
Warum sind Wellenenden genormt? Welche Toleranzklasse gilt für ein Wellenende Ø40 nach DIN 748?
][
*Antwort:* Damit nicht jede Kupplung eine Sonderanfertigung ist: gestufte Durchmesser mit zugeordneten Längen. Ø40 liegt unter 50 mm, also k6 (S. 199).
][
*Kurz gefasst (aus der Karteikarte):*
- Damit nicht jede Kupplung oder Riemenscheibe eine Sonderanfertigung ist.
- Gestufte Durchmesser mit zugeordneten Längen und Toleranzen passen zu genormten Naben.
#src[L-alt D2, Frage 1; nach B S. 197–220]
]

#aufgabe(titel: "Freistich Form E oder F", art: "verstehen", quelle: "8.2", herkunft: "original", vorlage: "Buch Kap. 9, Aufg. 9.5")[
#if not web [*Aufgabe 199* #linebreak()]
Wann genügt bei Freistichen die Form E, wann ist nur Form F geeignet?
][
*Antwort:* E: keine besonderen Anforderungen an die Planfläche. F: Zylinder und Planfläche werden beide weiterbearbeitet, etwa bei einer Lageranlageschulter (S. 200).
][
*Kurz gefasst (aus der Karteikarte):*
- Form E, wenn nur der Zylinder weiterbearbeitet wird und an die Planfläche keine besonderen Anforderungen gestellt werden.
- Form F, wenn Zylinder und Planfläche beide bearbeitet werden, zum Beispiel an einer Lageranlageschulter.
#bild("b-freistich", [Bild 9-5: Freistiche Form E und F nach DIN 509. B, S. 200 (PDF-S. 211).], height: 50mm)
#src[L-alt D2, Frage 3; nach B S. 197–220]
]

#aufgabe(titel: "Oberfläche im Freistichgrund", art: "verstehen", quelle: "8.2", herkunft: "original", vorlage: "Buch Kap. 9, Aufg. 9.8")[
#if not web [*Aufgabe 200* #linebreak()]
Welche Oberflächenkenngrößen sind im Flächengrund eines Freistichs vorhanden, wenn keine expliziten Angaben hierzu existieren?
][
*Antwort:* Geschlichtet: Rz1max 25 bzw. Ra 3,2 (S. 201).

#src[L-alt D2, Frage 4; nach B S. 197–220]
]

#aufgabe(titel: "Elemente an Wellenenden", art: "verstehen", quelle: "8.2", herkunft: "original", vorlage: "Altklausur WS 20/21, Aufg. 1e bis 1g", minuten: 10)[
#if not web [*Aufgabe 201* #linebreak()]
#enum(numbering: "a)",
[Nennen Sie 5 mögliche Elemente, die man bei Konstruktionen an Achsen- und Wellenenden vorsehen kann. (5 Punkte)],
[Was ist ein Freistich und wofür/warum setzt man ihn ein? (3 Punkte)],
[Was ist eine Zentrierbohrung und wofür wird sie benötigt? (3 Punkte)],
)
][
*a) Fünf Elemente:* z. B. genormtes Wellenende (zylindrisch oder kegelig), Passfedernut, Sicherungsringnut, Gewinde (z. B. für eine Nutmutter), Zentrierbohrung, Freistich am Wellenabsatz, Fase, Profilwelle (Vielnut, Kerbverzahnung, Polygon).
][
*b) Freistich:* eine genormte Einstichrille (DIN 509) in der Ecke eines Wellenabsatzes. Er schafft Auslauf für das Werkzeug (Drehmeißel, Schleifscheibe), sodass Zylinder- und Planfläche bis in die Ecke fertig bearbeitet werden können. Dadurch liegt ein aufgeschobenes Teil (z. B. Lagerring) sauber an der Schulter an, und der gerundete Übergang mindert die Kerbwirkung.
][
*c) Zentrierbohrung:* eine genormte kegelige Bohrung (DIN 332, Formen A, B, R) in der Stirnfläche der Welle. In ihr greift die Spitze des Reitstocks bzw. der Drehmaschine an. So wird die Welle beim Drehen und Schleifen zwischen Spitzen geführt und biegt sich unter den Schnittkräften nicht weg; beim Umspannen bleibt die Achse dieselbe.

#src[AK 1e–1g, PDF-S. 3; B Buchkapitel 9–10]
]

#aufgabe(titel: "Freistich am Wellenabsatz", art: "verstehen", quelle: "8.2", herkunft: "variante", vorlage: "Buch Kap. 9, Aufg. 9.4")[
#if not web [*Aufgabe 202* #linebreak()]
Welche drei Forderungen treffen am Wellenabsatz aufeinander, und wie löst der Freistich das Problem (Buch 9.4)?
][
*Antwort:* Anlage (kleiner Radius, r₁ \< r₂), Fertigung (Werkzeugauslauf für Schleifscheibe) und Festigkeit (großer Radius gegen Kerbwirkung). Der Freistich bietet einen definierten Auslauf mit genormtem Radius; ein einfacher kleiner Radius würde Auslauf und Festigkeit nicht erfüllen (S. 199–200).
][
*Kurz gefasst (aus der Karteikarte):*
- Die Anlage braucht einen kleinen Radius, damit das Bauteil plan anliegt.
- Die Fertigung braucht einen Werkzeugauslauf.
- Die Festigkeit braucht einen großen Radius gegen Kerbwirkung.
- Der Freistich löst das mit einem definierten Auslauf und genormtem Radius.

*Merksatz:* Anlage, Werkzeug und Festigkeit brauchen gemeinsam Platz.
#bild("b-freistich", [Bild 9-5: Freistiche Form E und F nach DIN 509. B, S. 200 (PDF-S. 211).], height: 50mm)
#src[L-alt D2, Frage 2; nach B S. 197–220]
]

#aufgabe(titel: "Bezeichnung von Freistich, Zentrierbohrung, Passfeder", art: "verstehen", quelle: "8.2", herkunft: "eigen")[
#if not web [*Aufgabe 203* #linebreak()]
Bilde die Bezeichnungen: a) Freistich Form F mit r = 0,8 und t₁ = 0,3; b) Zentrierbohrung Form A, d = 4 mm, D₁ = 8,5 mm; c) Passfeder Form A 16 × 10, Länge 56 mm.
][
*Modell / Annahmen:* Genormte Zeichen- und Einbaumaße aus den genannten Buchtabellen; keine Drehmomentbemessung.

a) DIN 509 – F0,8 × 0,3; b) ISO 6411 – A 4/8,5; c) Passfeder DIN 6885 – A 16 × 10 × 56.

*Prüfung:* Querschnitt und Normbezeichnung müssen zum Durchmesserbereich der Tabelle passen.

#src[L-alt D2, Frage 13; nach B S. 197–220]
]

#aufgabe(titel: "DIN 509 F0,8 × 0,3 entschlüsseln", art: "verstehen", quelle: "8.2", herkunft: "eigen")[
#if not web [*Aufgabe 204* #linebreak()]
Entschlüssele DIN 509 – F0,8 × 0,3.
][
*Antwort:* Freistich Form F. Radius 0,8 mm. Tiefe 0,3 mm.

#src[L-alt D2, offene Überarbeitung Frage 16; B S. 197–220]
]

#aufgabe(titel: "Wozu Zentrierbohrungen dienen", art: "verstehen", quelle: "8.3", herkunft: "original", vorlage: "Buch Kap. 9, Aufg. 9.9")[
#if not web [*Aufgabe 205* #linebreak()]
Für welchen Einsatzfall ist es sinnvoll, Zentrierbohrungen zu realisieren? Genügt eine Zentrierbohrung oder müssen stets zwei Zentrierbohrungen realisiert sein?
][
*Antwort:* Für die Führung der Welle im Reitstock beim Drehen, damit sie sich unter Schnittkräften nicht verformt. Eine reicht ohne Umspannen; wird umgespannt, braucht man an beiden Seiten eine (S. 202).
][
*Kurz gefasst (aus der Karteikarte):*
- Damit die Welle beim Drehen von der Reitstockspitze geführt wird und sich unter den Schnittkräften nicht verformt.
- Wird umgespannt, braucht man an beiden Enden eine.
#bild("b-zentrierung", [Bild 9-8: Zentrierbohrungen der Formen A, B und R. B, S. 203 (PDF-S. 214).], height: 50mm)
#src[L-alt D2, Frage 5; nach B S. 197–220]
]

#aufgabe(titel: "Zentrierbohrung Form A, B und R", art: "verstehen", quelle: "8.3", herkunft: "original", vorlage: "Buch Kap. 9, Aufg. 9.10")[
#if not web [*Aufgabe 206* #linebreak()]
Welche Formen von Zentrierbohrungen kennen Sie? Nennen Sie die jeweiligen Vorteile.
][
*Antwort:* A: einfach, günstig. B: Schutzsenkung schützt die Zentrierflächen. R: gewölbt, gleicht Lagefehler aus, kein Kantentragen (S. 203).

#src[L-alt D2, Frage 6; nach B S. 197–220]
]

#aufgabe(titel: "Zentrierbohrung am Fertigteil", art: "verstehen", quelle: "8.3", herkunft: "original", vorlage: "Buch Kap. 9, Aufg. 9.14")[
#if not web [*Aufgabe 207* #linebreak()]
Nennen Sie Beispiele dafür, dass eine Zentrierbohrung am fertigen Bauteil verbleiben darf. Nennen Sie Beispiele dafür, dass am fertigen Bauteil keine Zentrierbohrung mehr vorhanden sein darf.
][
*Antwort:* Darf/muss bleiben: wenn die Welle später nachgeschliffen oder zwischen Spitzen geprüft wird, oder die Bohrung die Funktion nicht stört (Beispiele: eigene Ergänzung). Darf nicht bleiben: wenn sie die Funktion stört, z. B. an einer Stirnfläche, die als Anlage oder Dichtfläche dient; dann wird die Welle länger gefertigt und gekürzt (S. 205).
][
*Kurz gefasst (aus der Karteikarte):*
- Wenn sie die Funktion stört, zum Beispiel an einer Stirnfläche, die als Anlage- oder Dichtfläche dient.
- Dann fertigt man die Welle länger und kürzt sie danach.
#bild("b-zentrierung", [Bild 9-8: Zentrierbohrungen der Formen A, B und R. B, S. 203 (PDF-S. 214).], height: 50mm)
#src[L-alt D2, Frage 7; nach B S. 197–220]
]

#aufgabe(titel: "Gestufte Passfederquerschnitte und Längen", art: "verstehen", quelle: "8.4", herkunft: "original", vorlage: "Buch Kap. 9, Aufg. 9.16 und 9.18")[
#if not web [*Aufgabe 208* #linebreak()]
#enum(numbering: "a)",
[Warum ist nicht jedem Wellendurchmesser ein eigener Passfederquerschnitt zugeordnet?],
[Warum sind Passfedern in ihren Längen nicht stufenlos erhältlich?],
)
][
*Antwort:* Gestufte Querschnitte und Normlängen reduzieren die Vielfalt: weniger Fräser, Lagerhaltung und Kosten; die Feder ist ein Katalogteil (S. 207; Begründung abgeleitet).
][
*Kurz gefasst (aus der Karteikarte):*
- Gestufte Querschnitte und Normlängen reduzieren die Vielfalt.
- Man braucht weniger Fräser, weniger Lagerhaltung, und die Feder ist ein Katalogteil.
#src[L-alt D2, Frage 8; nach B S. 197–220]
]

#aufgabe(titel: "Passfeder Form A in Nut N2", art: "verstehen", quelle: "8.4", herkunft: "original", vorlage: "Buch Kap. 9, Aufg. 9.17")[
#if not web [*Aufgabe 209* #linebreak()]
Können Passfedern der Form A (rundstirnig) eingesetzt werden in Nuten der Form N2 (mit Scheibenfräser erzeugt)?
][
*Antwort:* Nein, nicht sinnvoll: N2 entsteht mit dem Scheibenfräser und hat auslaufende Enden für geradstirnige Federn (Form B). Für Form A gehört die Nut N1 vom Schaftfräser (S. 207).

#src[L-alt D2, Frage 9; nach B S. 197–220]
]

#aufgabe(titel: "Passfeder für 50 und 51 mm", art: "verstehen", quelle: "8.4", herkunft: "variante", vorlage: "Buch Kap. 9, Aufg. 9.19")[
#if not web [*Aufgabe 210* #linebreak()]
Welcher Passfederquerschnitt gilt für d = 50 mm und für d = 51 mm? Gib jeweils t₁ und t₂ an (Buch 9.19).
][
*Modell / Annahmen:* Genormte Zeichen- und Einbaumaße aus den genannten Buchtabellen; keine Drehmomentbemessung.

d = 50 mm  (über 44 bis 50):  14 x 9    t1 = 5,5 +0,2   t2 = 3,8 +0,2
d = 51 mm  (über 50 bis 58):  16 x 10   t1 = 6,0 +0,2   t2 = 4,3 +0,2

*Prüfung:* Querschnitt und Normbezeichnung müssen zum Durchmesserbereich der Tabelle passen.

#src[L-alt D2, Frage 11; nach B S. 197–220]
]

#aufgabe(titel: "Passfedernut normgerecht bemaßen", art: "verstehen", quelle: "8.4", herkunft: "variante", vorlage: "Buch Kap. 9, Aufg. 9.20")[
#if not web [*Aufgabe 211* #linebreak()]
Wie wird die Nut einer Welle Ø58 normgerecht bemaßt? Welche Angaben gehören in die Zeichnung (vgl. Buch 9.20)?
][
*Modell / Annahmen:* Genormte Zeichen- und Einbaumaße aus den genannten Buchtabellen; keine Drehmomentbemessung.

Ø58 liegt in „über 50 bis 58“: Passfeder 16 × 10. In die Zeichnung: Wellen-Ø mit Toleranz (z. B. k6), Nutbreite 16 P9, Nuttiefe t₁ = 6#super[+0,2] von der Wellenoberfläche zum Nutgrund, Nutlänge mit Toleranz, Lage der Nut; dazu ein Schnitt als zweite Ansicht (S. 208–209).

*Prüfung:* Querschnitt und Normbezeichnung müssen zum Durchmesserbereich der Tabelle passen.

#src[L-alt D2, Frage 12; nach B S. 197–220]
]

#aufgabe(titel: "Wie eine Passfeder trägt", art: "verstehen", quelle: "8.4", herkunft: "eigen")[
#if not web [*Aufgabe 212* #linebreak()]
Wie trägt eine Passfeder und welche Länge bezeichnet die Normbezeichnung der Form A?
][
*Antwort:* trägt mit den Seitenflächen. der Form A wird mit Gesamtlänge bezeichnet.
][
*Kurz gefasst (aus dem Quiz):*
- Mit den Seitenflächen. Formschlüssig über die Flanken in Wellen- und Nabennut.
][
*Typische Verwechslungen:*
- „Mit der Oberseite“: Oben hat sie Rückenspiel und berührt die Nabe nicht.
- „Mit allen vier Flächen gleichzeitig“: Die Oberseite hat Rückenspiel.
- „Durch Reibung an der Wellenoberfläche“: Die Passfeder ist eine formschlüssige Verbindung, keine reibschlüssige.
][
*Kurz gefasst (aus der Karteikarte):*
- Formschlüssig über ihre Seitenflächen.
- Oben hat sie Spiel zur Nabennut.
- Axialkräfte überträgt sie nicht.

*Merksatz:* Passfeder trägt seitlich Drehmoment, nicht axial.
#bild("alt-d2-1", [Passfederverbindung, Welle und Nabe geschnitten (eigene Skizze, vgl. Bild 9-15, S. 207) Quelle der Skizze: L-alt D2; eigene Darstellung.], height: 50mm)
#src[L-alt D2, offene Überarbeitung Frage 17; B S. 197–220]
]

#aufgabe(titel: "Passfeder für eine Welle Ø48", art: "verstehen", quelle: "8.4", herkunft: "eigen")[
#if not web [*Aufgabe 213* #linebreak()]
Auf eine Welle Ø48 soll eine Passfeder Form A mit l = 40 mm. Wie lautet die Normbezeichnung? (Kapitel 8, Tab. 9-3, S. 208–209)
][
*Modell / Annahmen:* Genormte Zeichen- und Einbaumaße aus den genannten Buchtabellen; keine Drehmomentbemessung.

48 mm liegt in „über 44 bis 50“ → b × h = 14 × 9: Passfeder DIN 6885 – A 14 × 9 × 40 (S. 208–209).

*Prüfung:* Querschnitt und Normbezeichnung müssen zum Durchmesserbereich der Tabelle passen.

#src[L-alt S4; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

#aufgabe(titel: "Bezeichnung von Passfeder und O-Ring", art: "verstehen", quelle: "8.4", herkunft: "eigen")[
#if not web [*Aufgabe 214* #linebreak()]
Formuliere die vollständige Normbezeichnung der Passfeder Pos. 68 und eines O-Rings Pos. 79 nach den Schemata in Abschnitt 8.4 und 11.4 dieses Lernskripts (Werkstoff NBR, Sortenmerkmal N, Härte 70 als Annahme).
][
*Modell / Annahmen:* Worst-Case-Maßkette beziehungsweise Zeichnungsinterpretation nach den genannten Funktionsflächen.

Passfeder DIN 6885 – A 6 × 6 × 25; O-Ring DIN 3771 – 24 x 3 – N – NBR70 (Stückliste S. 274 nennt „NBR / OR 24X3,0“; Sorte und Härte sind Annahmen).

*Prüfung:* Maßketten im ungünstigsten Grenzfall prüfen; aus verkleinerten Buchbildern keine Funktionsmaße abgreifen.

#src[L-alt E1, Frage 20; nach B S. 269–290]
]

#aufgabe(titel: "Passfeder DIN 6885 – A 12 × 8 × 40 lesen", art: "verstehen", quelle: "8.4", herkunft: "eigen")[
#if not web [*Aufgabe 215* #linebreak()]
Was bedeutet „Passfeder DIN 6885 – A 12 × 8 × 40“? Begründe deine Antwort.
][
*Antwort:*
- Form A (rundstirnig), Breite 12 mm, Höhe 8 mm, Gesamtlänge 40 mm. Bei Form A zählt die Länge inklusive der Rundungen.
][
*Typische Verwechslungen:*
- „Form A, Wellendurchmesser 12 mm, Nuttiefe 8 mm, Länge 40 mm“: Die Zahlen sind die Maße der Passfeder selbst.
- „Form A, Länge 12 mm, Breite 8 mm, Höhe 40 mm“: Die Reihenfolge ist b × h × l.
- „Gleitfeder mit Halteschrauben“: Das wäre Form E.
]

#aufgabe(titel: "Bezeichnung von Vielnut- und Kerbzahnprofil", art: "verstehen", quelle: "8.5", herkunft: "variante", vorlage: "Buch Kap. 9, Aufg. 9.21, 9.22 und 9.26")[
#if not web [*Aufgabe 216* #linebreak()]
Bilde die Bezeichnungen: a) Vielnut-#strong[Nabe] nach DIN ISO 14 mit 10 Keilen, d = 72 mm, D = 78 mm (Buch 9.21); b) Kerbzahn-#strong[Welle] DIN 5481 mit d₁ = 50, d₃ = 55 (Buch 9.22); c) Polygon P3G für eine #strong[Nabe] mit Nenngröße 35 mm (Buch 9.26).
][
*Modell / Annahmen:* Genormte Zeichen- und Einbaumaße aus den genannten Buchtabellen; keine Drehmomentbemessung.

a) DIN ISO 14 – N 10 × 72 × 78; b) DIN 5481 – W 50 × 55, die Länge wird separat angegeben; c) Profil DIN 32711 – B P3G 35 (S. 210, 215, 217).

*Prüfung:* Querschnitt und Normbezeichnung müssen zum Durchmesserbereich der Tabelle passen.

#src[L-alt D2, Frage 14; nach B S. 197–220]
]

#aufgabe(titel: "Passfeder, Vielnut und Polygon", art: "verstehen", quelle: "8.5", herkunft: "eigen")[
#if not web [*Aufgabe 217* #linebreak()]
Wodurch unterscheiden sich Passfeder, Vielnut und Polygonprofil beim übertragbaren Drehmoment?
][
*Antwort:* Passfeder: kleine bis mittlere Momente. Vielnut: wesentlich größere. Polygon: höchstes Moment bei gleichem Durchmesser (S. 206, 210, 216).
][
*Kurz gefasst (aus der Karteikarte):*
- Die Passfeder überträgt kleine bis mittlere Momente.
- Ein Vielnutprofil überträgt wesentlich größere.
- Das Polygonprofil überträgt bei gleichem Durchmesser das höchste Moment, weil es keine Kerbe durch eine Nut hat.
#src[L-alt D2, Frage 10; nach B S. 197–220]
]

#aufgabe(titel: "Polygonprofil statt Passfeder", art: "verstehen", quelle: "8.5", herkunft: "eigen")[
#if not web [*Aufgabe 218* #linebreak()]
Warum kann ein Polygonprofil eine günstige Alternative zu einer Passfeder sein?
][
*Antwort:* Polygonprofil.

#src[L-alt D2, offene Überarbeitung Frage 18; B S. 197–220]
]

#aufgabe(titel: "Radiale Überdeckung beim Kerbzahnprofil", art: "rechnen", quelle: "8.5", herkunft: "variante", vorlage: "Buch Kap. 9, Aufg. 9.24",
  ergebnis: [ungefähr 1,75 mm],
  tipp: [Die Zähne überdecken sich im Bereich zwischen dem kleinsten Durchmesser der Nabenzähne und dem größten der Wellenzähne.],
)[
#if not web [*Aufgabe 219* #linebreak()]
*Gegeben und Annahmen*

Kerbzahnprofil DIN 5481 – 26 × 30 Tabellenwerte für diese Paarung: Nabenmaß $d_1="26,5" thin "mm"$, Wellenmaß $d_3=30 thin "mm"$.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist die radiale Überdeckung der Zähne ungefähr (vgl. Buch 9.24, Tab. 9-6)?],
)
][
*Bild:* Wellenzähne greifen in die Nabenlücken. Tragen kann nur der Ring, in dem sich Wellen- und Nabenzähne radial überlappen.
][
*Werte aus der Tabelle:* Nabe $d_1 = "26,5" thin "mm"$, Welle $d_3 = 30 thin "mm"$.
][
*Überdeckung:* Die Differenz der Durchmesser verteilt sich auf beide Seiten: $(30 - "26,5")\/2 = "1,75" thin "mm"$.
][
*Prüfen:* Das ist eine Höhe von unter 2 mm, typisch für die feinen Kerbzähne. Der Wert ist aus Tab. 9-6 abgeleitet, keine Tragfähigkeitsangabe.
#src[L-alt D2, Frage 15; nach B S. 197–220]
]


#kapitel("Kapitel 9 · Sicherungselemente")

#aufgabe(titel: "Wozu axiale Sicherungen", art: "verstehen", quelle: "9.1", herkunft: "original", vorlage: "Buch Kap. 10, Aufg. 10.1")[
#if not web [*Aufgabe 220* #linebreak()]
Warum ist der Einsatz von Elementen zur axialen Sicherung überhaupt notwendig?
][
*Antwort:* Formschlüssige Welle-Nabe-Verbindungen übertragen keine Axialkräfte; Welle und Nabe könnten axial wandern. Ein Wellenbund stützt nur einseitig ab (S. 221).
][
*Kurz gefasst (aus der Karteikarte):*
- Formschlüssige Welle-Nabe-Verbindungen wie die Passfeder übertragen keine Axialkräfte.
- Ohne Sicherung könnten Welle und Nabe axial wandern.
- Ein Wellenbund stützt nur in eine Richtung ab.

*Merksatz:* Drehmoment übertragen heißt nicht axial sichern.
#src[L-alt D3, Frage 1; nach B S. 221–230]
]

#aufgabe(titel: "Weitere axiale Sicherungen für Wälzlager", art: "verstehen", quelle: "9.1", herkunft: "original", vorlage: "Buch Kap. 10, Aufg. 10.2")[
#if not web [*Aufgabe 221* #linebreak()]
In diesem Kapitel wurden als axiale Sicherungen der Sicherungsring und die Nutmutter mit Sicherungsblech ausführlich dargestellt. Welche weiteren Möglichkeiten sind gegeben, die axiale Position eines Wälzlagers auf einer Welle sicherzustellen? Nennen Sie einige Beispiele.
][
*Antwort:* Z. B. Wellenschulter und Distanzhülse, Lagerdeckel am Gehäuse, Klemmhülse/Spannhülse, Endscheibe mit Schraube an der Stirnseite, Presssitz (Beispiele als Ergänzung; im Buch werden Sicherungsring und Nutmutter behandelt).

#src[L-alt D3, Frage 2; nach B S. 221–230]
]

#aufgabe(titel: "Nutbreite größer als Ringdicke", art: "verstehen", quelle: "9.1", herkunft: "original", vorlage: "Buch Kap. 10, Aufg. 10.4 und 10.5")[
#if not web [*Aufgabe 222* #linebreak()]
#enum(numbering: "a)",
[Warum ist es sinnvoll, dass die Nut für den Sicherungsring breiter ist als der Sicherungsring selbst?],
[Nennen Sie Beispiele, wann der Breitenunterschied zwischen dem Sicherungsring und der Nut für den Sicherungsring in der Welle für die Gesamtkonstruktion ungünstig wird.],
)
][
*Antwort:* Damit der Ring trotz Toleranzen sicher in die Nut passt. Ungünstig wird es, wenn das Bauteil spielfrei sitzen muss: Es klappert, z. B. bei wechselnden Axialkräften oder präzisen Lagerungen (S. 222).
][
*Kurz gefasst (aus der Karteikarte):*
- Damit der Ring trotz Toleranzen sicher hineinpasst.
- Ungünstig ist das, wenn das Bauteil spielfrei sitzen muss, zum Beispiel bei wechselnden Axialkräften oder präzisen Lagerungen.
#bild("b-nutmutter", [Bild 10-7: Nutmutter mit Sicherungsblech. B, S. 227 (PDF-S. 238).], height: 50mm)
#src[L-alt D3, Frage 4; nach B S. 221–230]
]

#aufgabe(titel: "Warum der Sicherungsring nicht rund ist", art: "verstehen", quelle: "9.1", herkunft: "eigen")[
#if not web [*Aufgabe 223* #linebreak()]
Warum hat ein Sicherungsring im ungespannten Zustand keine Kreisform?
][
*Antwort:* Weil seine radiale Breite zu den Enden hin abnimmt: Eingebaut verformt er sich dadurch rund und liegt mit gleichmäßiger Vorspannung in der Nut (S. 221).
][
*Kurz gefasst (aus der Karteikarte):*
- Seine radiale Breite nimmt zu den Enden hin ab.
- Eingebaut verformt er sich dadurch rund und liegt mit gleichmäßiger Vorspannung in der Nut.
#bild("b-sicherungsringe", [Bild 10-3: Sicherungsringe nach DIN 471 und DIN 472. B, S. 222 (PDF-S. 233).], height: 50mm)
#src[L-alt D3, Frage 3; nach B S. 221–230]
]

#aufgabe(titel: "Sicherungsringe an Wellenenden", art: "verstehen", quelle: "9.1", herkunft: "eigen")[
#if not web [*Aufgabe 224* #linebreak()]
Warum gehören Sicherungsringe möglichst an Wellenenden?
][
*Antwort:* Die Nut mit kleinem Radius hat eine hohe Kerbwirkung; an den Enden ist die Biegebeanspruchung gering (S. 222).
][
*Kurz gefasst (aus der Karteikarte):*
- Die Nut hat einen kleinen Radius und damit eine hohe Kerbwirkung.
- An den Wellenenden ist die Biegebeanspruchung gering, deshalb schadet die Kerbe dort am wenigsten.
#bild("b-sicherungsringe", [Bild 10-3: Sicherungsringe nach DIN 471 und DIN 472. B, S. 222 (PDF-S. 233).], height: 50mm)
#src[L-alt D3, Frage 5; nach B S. 221–230]
]

#aufgabe(titel: "Sicherungsring in der Gesamtzeichnung", art: "verstehen", quelle: "9.1", herkunft: "eigen")[
#if not web [*Aufgabe 225* #linebreak()]
Wie wird ein Sicherungsring in der Gesamtzeichnung dargestellt?
][
*Antwort:* Immer geschnitten, breite Seite oben im Schnitt, offene Seite unten in Ansicht in die Schnittebene gedreht, mit Umlaufkanten der Nut (S. 223–224).

#src[L-alt D3, Frage 6; nach B S. 221–230]
]

#aufgabe(titel: "Sicherungsringe darstellen, Nachteile der Nut", art: "verstehen", quelle: "9.1", herkunft: "eigen")[
#if not web [*Aufgabe 226* #linebreak()]
Wie werden Sicherungsringe dargestellt, und welche Nachteile der Nut sind zu beachten?
][
*Antwort:* werden in Gesamtzeichnungen geschnitten dargestellt. haben die breite Seite oben in der Zeichnung. verursachen eine hohe Kerbwirkung in der Welle.

#src[L-alt D3, offene Überarbeitung Frage 13; B S. 221–230]
]

#aufgabe(titel: "Axialspiel am Sicherungsring für d = 40 mm", art: "rechnen", quelle: "9.1", herkunft: "eigen",
  ergebnis: [kleinstes Spiel 0,10 mm, größtes 0,30 mm],
  tipp: [Größtes Spiel: breiteste Nut mit dünnstem Ring. Kleinstes Spiel: schmalste Nut mit dickstem Ring.],
)[
#if not web [*Aufgabe 227* #linebreak()]
*Gegeben und Annahmen*

Sicherungsring für eine Welle d₁ = 40 mm: Ring s = 1,75#sub[−0,06], Nut m = 1,85 H13 (0/+0,14).

*Gesucht*

#enum(numbering: "a)",
[Berechne minimales und maximales Axialspiel.],
)
][
*Bild:* Der Ring sitzt in einer Nut, die etwas breiter ist als er. Die Lücke ist das Axialspiel. Weil beide Maße streuen, gibt es einen engsten und einen weitesten Fall.
][
*Grenzmaße:* Ring s = 1,69 bis 1,75 mm. Nut m = 1,85 bis 1,99 mm.
][
*Kleinstes Spiel:* $"1,85" - "1,75" = "0,10" thin "mm"$.
][
*Größtes Spiel:* $"1,99" - "1,69" = "0,30" thin "mm"$.
][
*Prüfen:* Auch im engsten Fall bleibt Spiel, der Ring lässt sich also immer einsetzen.
#src[L-alt D3, Frage 10; nach B S. 221–230]
]

#aufgabe(titel: "Nuttiefe und Ringbezeichnung für d = 45 mm", art: "rechnen", quelle: "9.1", herkunft: "eigen",
  ergebnis: [t = 1,25 mm; Sicherungsring DIN 471 – 45 × 1,75],
  tipp: [Die Nuttiefe ist die halbe Differenz von Wellen- und Nutgrunddurchmesser.],
)[
#if not web [*Aufgabe 228* #linebreak()]
*Gegeben und Annahmen*

Sicherungsring nach DIN 471: $d_1=45 thin "mm"$, $d_2="42,5" thin "mm"$, Ringdicke $s="1,75" thin "mm"$.

*Gesucht*

#enum(numbering: "a)",
[Berechne die Nuttiefe $t$ und bilde die Normbezeichnung.],
)
][
*Bild:* Die Nut ist eine ringförmige Rille. Von außen gemessen fehlt auf jeder Seite die Nuttiefe.
][
*Nuttiefe:* $t = (d_1 - d_2)\/2 = (45 - "42,5")\/2 = "1,25" thin "mm"$.
][
*Bezeichnung:* DIN 471 ist der Ring für Wellen. Bezeichnung: *Sicherungsring DIN 471 – 45 × 1,75* (Wellendurchmesser × Ringdicke).
][
*Prüfen:* DIN 472 wäre der Ring für Bohrungen. Hier sitzt er auf einer Welle, also 471.
#src[L-alt D3, Frage 11; nach B S. 221–230]
]

#aufgabe(titel: "Axialspiel aus Ring- und Nutmaßen", art: "rechnen", quelle: "9.1", herkunft: "eigen",
  ergebnis: [0,15 bis 0,36 mm],
  tipp: [Kombiniere jeweils die extremen Grenzmaße.],
)[
#if not web [*Aufgabe 229* #linebreak()]
*Gegeben und Annahmen*

Ein Sicherungsring ist 1,93 bis 2,00 mm dick, seine Nut 2,15 bis 2,29 mm breit.

*Gesucht*

#enum(numbering: "a)",
[Berechne kleinstes und größtes Axialspiel.],
)
][
*Kleinstes Spiel:* schmalste Nut minus dickster Ring: $"2,15" - "2,00" = "0,15" thin "mm"$.
][
*Größtes Spiel:* breiteste Nut minus dünnster Ring: $"2,29" - "1,93" = "0,36" thin "mm"$.
][
*Prüfen:* Auch im engsten Grenzfall bleibt Spiel. Die Spanne von 0,21 mm ist die Summe beider Toleranzen (0,07 + 0,14).
#src[L-alt L5; Buchbeispiel B S. 222]
]

#aufgabe(titel: "Axialspiel bei s = 1,2 mm", art: "rechnen", quelle: "9.1", herkunft: "eigen",
  ergebnis: [0,10 bis 0,30 mm],
  tipp: [Erst aus den Abmaßen die Grenzmaße bilden.],
)[
#if not web [*Aufgabe 230* #linebreak()]
*Gegeben und Annahmen*

Ein Sicherungsring hat s = 1,2 −0,06 mm, die Nut m = 1,3 +0,14 mm.

*Gesucht*

#enum(numbering: "a)",
[Bestimme das kleinste und das größte Axialspiel.],
)
][
*Grenzmaße:* Ring s = 1,14 bis 1,20 mm. Nut m = 1,30 bis 1,44 mm.
][
*Kleinstes Spiel:* $"1,30" - "1,20" = "0,10" thin "mm"$.
][
*Größtes Spiel:* $"1,44" - "1,14" = "0,30" thin "mm"$.
][
*Prüfen:* Spanne 0,20 mm = 0,06 + 0,14, die Summe der Toleranzen.
#src[L-alt A5; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

#aufgabe(titel: "Sicherungsring oder Nutmutter", art: "verstehen", quelle: "9.2", herkunft: "original", vorlage: "Buch Kap. 10, Aufg. 10.3")[
#if not web [*Aufgabe 231* #linebreak()]
Nennen Sie Gründe für den Einsatz von Sicherungsringen und auch Gründe für einen Einsatz einer Nutmutter mit Sicherungsblech.
][
*Antwort:* Sicherungsring: einfach, billig, wenig Bauraum, schnelle Montage. Nutmutter: spielfrei und nachstellbar, höhere Axialkräfte, z. B. für Festlager (S. 222, 227).
][
*Kurz gefasst (aus der Karteikarte):*
- Der Sicherungsring ist einfach, billig, braucht wenig Platz und ist schnell montiert.
- Die Nutmutter ist spielfrei, nachstellbar und nimmt höhere Axialkräfte auf, zum Beispiel am Festlager.

*Merksatz:* Sicherungsring einfach; Nutmutter einstellbar und spielfrei.
#bild("b-nutmutter", [Bild 10-7: Nutmutter mit Sicherungsblech. B, S. 227 (PDF-S. 238).], height: 50mm)
#src[L-alt D3, Frage 9; nach B S. 221–230]
]

#aufgabe(titel: "Vorrang des Muttergewindes bei der Nutmutter", art: "verstehen", quelle: "9.2", herkunft: "eigen")[
#if not web [*Aufgabe 232* #linebreak()]
Warum hat bei der Nutmutter ausnahmsweise das Muttergewinde Vorrang?
][
*Antwort:* Weil die Welle dort eine Nut hat und der Schnitt der Mutter über diese Nut reicht (S. 228).

#src[L-alt D3, Frage 7; nach B S. 221–230]
]

#aufgabe(titel: "Wellennut für das Sicherungsblech", art: "verstehen", quelle: "9.2", herkunft: "eigen")[
#if not web [*Aufgabe 233* #linebreak()]
Warum reicht die Wellennut für das Sicherungsblech bis unter das Lager?
][
*Antwort:* Damit immer das Lager die Verschraubung axial begrenzt, nicht das Nutende (S. 228).
][
*Kurz gefasst (aus der Karteikarte):*
- Damit immer das Lager die Verschraubung axial begrenzt und nicht das Nutende.
- Sonst könnte die Mutter am Nutende anstehen, bevor sie das Lager festspannt.
#bild("b-nutmutter", [Bild 10-7: Nutmutter mit Sicherungsblech. B, S. 227 (PDF-S. 238).], height: 50mm)
#src[L-alt D3, Frage 8; nach B S. 221–230]
]

#aufgabe(titel: "Nutmutter und Sicherungsblech für M50 × 1,5", art: "verstehen", quelle: "9.2", herkunft: "eigen")[
#if not web [*Aufgabe 234* #linebreak()]
Bilde die Bezeichnungen für Nutmutter und Sicherungsblech für ein Wellengewinde M50 × 1,5.
][
*Modell / Annahmen:* Axialspiel aus unabhängigen Grenzmaßen von Nut und Ring.

Nutmutter DIN 981 – M50 × 1,5; Sicherungsblech DIN 5406 – A 50 (Tab. 10-3).

*Prüfung:* Größtes Spiel: größte Nut minus kleinster Ring; kleinstes Spiel umgekehrt.

#src[L-alt D3, Frage 12; nach B S. 221–230]
]

#aufgabe(titel: "Kraftweg bei Nutmutter und Sicherungsblech", art: "verstehen", quelle: "9.2", herkunft: "eigen")[
#if not web [*Aufgabe 235* #linebreak()]
Erkläre den Kraft- und Sicherungsweg von Nutmutter und Sicherungsblech.
][
*Antwort:* Das Blech wird im Vollschnitt dargestellt. Eine äußere Nase greift in eine Nut der Mutter.

#src[L-alt D3, offene Überarbeitung Frage 14; B S. 221–230]
]


#kapitel("Kapitel 10 · Wälzlager und Lageranordnungen")

#aufgabe(titel: "Gleitlager und Wälzlager", art: "verstehen", quelle: "10.1", herkunft: "original", vorlage: "Buch Kap. 11, Aufg. 11.1")[
#if not web [*Aufgabe 236* #linebreak()]
Was ist der grundlegende Unterschied im Aufbau zwischen Gleit- und Wälzlagern?
][
*Antwort:* Gleitlager: direkte Gleitbewegung zwischen Welle und Lager (mit Schmierfilm). Wälzlager: Wälzkörper rollen zwischen den Ringen ab, Rollreibung statt Gleitreibung (S. 231).
][
*Kurz gefasst (aus der Karteikarte):*
- Im Gleitlager gleitet die Welle direkt auf einem Schmierfilm.
- Im Wälzlager rollen Wälzkörper zwischen den Ringen ab, es herrscht also Rollreibung statt Gleitreibung.
#bild("alt-d4-1", [Rillenkugellager im Schnitt, Proportionen für Handzeichnungen (eigene Skizze, vgl. Bild 11-7, S. 235) Quelle der Skizze: L-alt D4; eigene Darstellung.], height: 50mm)
#src[L-alt D4, Frage 1; nach B S. 231–248]
]

#aufgabe(titel: "Aufbau eines Wälzlagers und der Käfig", art: "verstehen", quelle: "10.1", herkunft: "original", vorlage: "Buch Kap. 11, Aufg. 11.2 und 11.5")[
#if not web [*Aufgabe 237* #linebreak()]
#enum(numbering: "a)",
[Aus welchen Elementen ist ein Wälzlager aufgebaut?],
[Was ist die Funktion des Käfigs?],
)
][
*Antwort:* Innenring, Außenring, Wälzkörper, Käfig. Der Käfig hält die Wälzkörper auf Abstand und verteilt sie gleichmäßig (S. 232).
][
*Kurz gefasst (aus der Karteikarte):*
- Er hält die Wälzkörper auf Abstand und verteilt sie gleichmäßig über den Umfang.
- Ohne ihn würden sie aneinander reiben.
#bild("alt-d4-1", [Rillenkugellager im Schnitt, Proportionen für Handzeichnungen (eigene Skizze, vgl. Bild 11-7, S. 235) Quelle der Skizze: L-alt D4; eigene Darstellung.], height: 50mm)
#src[L-alt D4, Frage 2; nach B S. 231–248]
]

#aufgabe(titel: "Wälzlager im Schnitt", art: "verstehen", quelle: "10.2", herkunft: "eigen")[
#if not web [*Aufgabe 238* #linebreak()]
Welche Regeln gelten für die Schnittdarstellung eines Wälzlagers?
][
*Antwort:* Immer im Schnitt; beide Ringe gleiche Schraffur; Wälzkörper ungeschnitten; Käfig meist nicht gezeichnet; Kantenradien immer darstellen (S. 234–235).
][
*Kurz gefasst (aus der Karteikarte):*
- Das Lager wird immer geschnitten.
- Innen- und Außenring bekommen dieselbe Schraffur, die Wälzkörper werden nicht geschnitten.
- Der Käfig wird meist weggelassen, Kantenradien zeichnet man immer.
#bild("b-lagerproportionen", [Bild 11-7: Proportionen eines Rillenkugellagers für Handzeichnungen. B, S. 235 (PDF-S. 246).], height: 50mm)
#src[L-alt D4, Frage 3; nach B S. 231–248]
]

#aufgabe(titel: "Ringe und Wälzkörper im Schnitt", art: "verstehen", quelle: "10.2", herkunft: "eigen")[
#if not web [*Aufgabe 239* #linebreak()]
Wie werden Ringe und Wälzkörper in der Schnittdarstellung unterschieden?
][
*Antwort:* werden Innen- und Außenring gleich schraffiert. werden Wälzkörper nicht schraffiert.

#src[L-alt D4, offene Überarbeitung Frage 17; B S. 231–248]
]

#aufgabe(titel: "Proportionen eines Rillenkugellagers", art: "rechnen", quelle: "10.2", herkunft: "eigen",
  ergebnis: [H = 12,5 mm, DW ≈ 6,25 mm, HR ≈ 4,2 mm, R ≈ 1,4 mm],
  tipp: [Alles hängt an der Ringhöhe H = (D − d)/2.],
)[
#if not web [*Aufgabe 240* #linebreak()]
*Gegeben und Annahmen*

Ein Rillenkugellager hat d = 30 mm und D = 55 mm.

*Gesucht*

#enum(numbering: "a)",
[Bestimme die Proportionen für eine Handzeichnung.],
)
][
*Bild:* Für eine Handskizze braucht man keine Katalogmaße. Man leitet alles aus der Ringhöhe ab, also dem Platz zwischen Bohrung und Außendurchmesser.
][
*Ringhöhe:* $H = (55 - 30)\/2 = "12,5" thin "mm"$.
][
*Kugel:* $D_W approx H\/2 approx "6,25" thin "mm"$.
][
*Ringdicke und Rundung:* $H_R approx H\/3 approx "4,2" thin "mm"$, $R approx H\/9 approx "1,4" thin "mm"$.
][
*Prüfen:* Die Kugel passt mit zwei Ringdicken in die Höhe: $"6,25" + 2 dot "4,2" approx 15 > "12,5"$, weil die Kugel in die Rillen eintaucht. Zeichenproportionen ersetzen keine Katalogmaße.
#src[L-alt D4, Frage 12; nach B S. 231–248]
]

#aufgabe(titel: "Zeichenmaße für Lager 6210", art: "rechnen", quelle: "10.2", herkunft: "eigen",
  ergebnis: [d = 50 mm, H = 20 mm, DW ≈ 10 mm, HR ≈ 6,7 mm, R ≈ 2,2 mm],
  tipp: [Die letzten beiden Ziffern mal 5 ergeben ab 04 den Bohrungsdurchmesser.],
)[
#if not web [*Aufgabe 241* #linebreak()]
*Gegeben und Annahmen*

Rillenkugellager 6210 mit D = 90 mm (Wert gegeben).

*Gesucht*

#enum(numbering: "a)",
[Bestimme d und die Zeichenmaße H, DW, HR, R für eine Handskizze (Kapitel 10, S. 235, 241).],
)
][
*Kurzzeichen lesen:* 62 heißt Rillenkugellager einer bestimmten Maßreihe, 10 ist die Bohrungskennzahl. Ab 04 gilt: Kennzahl mal 5. Also $d = 10 dot 5 = 50 thin "mm"$.
][
*Ringhöhe:* $H = (90 - 50)\/2 = 20 thin "mm"$.
][
*Kugel:* $D_W approx H\/2 = 10 thin "mm"$.
][
*Ringdicke und Rundung:* $H_R approx H\/3 approx "6,7" thin "mm"$, $R approx H\/9 approx "2,2" thin "mm"$.
][
*Prüfen:* Gleiche Proportionen wie bei jedem Rillenkugellager, nur mit größerem H.
#src[L-alt S3; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

#aufgabe(titel: "Zylinderrollenlager mit Axialkraft", art: "verstehen", quelle: "10.3", herkunft: "original", vorlage: "Buch Kap. 11, Aufg. 11.14")[
#if not web [*Aufgabe 242* #linebreak()]
Wie muss ein Radial-Zylinderrollenlager aussehen, welches auch (geringe) Axialkräfte übertragen soll?
][
*Antwort:* NJ (eine Richtung) oder NUP (beide Richtungen), weil dort Borde an beiden Ringen die Rollen führen (S. 237–238).

#src[L-alt D4, Frage 5; nach B S. 231–248]
]

#aufgabe(titel: "Pendelrollenlager als Festlager", art: "verstehen", quelle: "10.3", herkunft: "original", vorlage: "Buch Kap. 11, Aufg. 11.31")[
#if not web [*Aufgabe 243* #linebreak()]
Kann ein Pendelrollenlager als Festlager eingesetzt werden oder nur als Loslager?
][
*Antwort:* Ja, es nimmt hohe radiale und axiale Kräfte auf; dann werden beide Ringe beidseitig fixiert (S. 239; abgeleitet).

#src[L-alt D4, Frage 10; nach B S. 231–248]
]

#aufgabe(titel: "Schrägkugel-, Vierpunkt- und Pendelkugellager", art: "verstehen", quelle: "10.3", herkunft: "variante", vorlage: "Buch Kap. 11, Aufg. 11.10 bis 11.12")[
#if not web [*Aufgabe 244* #linebreak()]
Was kennzeichnet ein Schrägkugellager, ein Vierpunktlager und ein Pendelkugellager? Gibt es einreihige Pendelkugellager (Buch 11.10–11.12)?
][
*Antwort:* Schrägkugellager: niedrige und hohe Schulter, α = 40°, hohe Axialkraft in einer Richtung. Vierpunktlager: zwei Kreisbögen je Rille, vier Berührpunkte, geteilter Innenring, beidseitig axial. Pendelkugellager: hohlkugelige Außenbahn, gleicht bis 4° aus, immer zweireihig, also kein einreihiges (S. 235–236).

#src[L-alt D4, Frage 4; nach B S. 231–248]
]

#aufgabe(titel: "Kegelrollenlager paarweise", art: "verstehen", quelle: "10.3", herkunft: "variante", vorlage: "Buch Kap. 11, Aufg. 11.16")[
#if not web [*Aufgabe 245* #linebreak()]
Welche Kräfte kann ein Kegelrollenlager aufnehmen, und warum baut man es paarweise ein (Buch 11.16)?
][
*Antwort:* Radial und axial hoch, axial aber nur in einer Richtung; deshalb paarweise spiegelbildlich, Spiel über Nutmutter einstellbar (S. 239).
][
*Kurz gefasst (aus der Karteikarte):*
- Hohe Radial- und Axialkräfte, axial aber nur in einer Richtung.
- Deshalb baut man zwei spiegelbildlich ein.
- Das Spiel lässt sich dann über eine Nutmutter einstellen.
#src[L-alt D4, Frage 6; nach B S. 231–248]
]

#aufgabe(titel: "Lager für Axialkräfte in beide Richtungen", art: "verstehen", quelle: "10.3", herkunft: "eigen")[
#if not web [*Aufgabe 246* #linebreak()]
Nenne drei Lagerbauarten, die Axialkräfte in beiden Richtungen aufnehmen können.
][
*Antwort:* Rillenkugellager. Vierpunktlager. zweiseitig wirkendes Axial-Rillenkugellager.

#src[L-alt D4, offene Überarbeitung Frage 15; B S. 231–248]
]

#aufgabe(titel: "Kurzzeichen 6208 und 6006", art: "verstehen", quelle: "10.4", herkunft: "eigen")[
#if not web [*Aufgabe 247* #linebreak()]
Entschlüssele die Kurzzeichen 6208 und 6006 (Lagerart, Bohrungsdurchmesser).
][
*Modell / Annahmen:* Statische Lastzuordnung zum jeweiligen Ring; Zeichenproportionen ersetzen keine Katalogmaße.

6208: einreihiges Rillenkugellager, Durchmesserreihe 2, d = 40 mm (D = 80, B = 18). 6006: einreihiges Rillenkugellager, Durchmesserreihe 0, d = 06 · 5 = 30 mm (S. 241; Regel ×5 als Ergänzung).

*Prüfung:* Die Sitzwahl folgt der Relativbewegung zwischen Last und Ring; Zeichnungsmaße sind keine Belastbarkeitswerte.
][
*Kurz gefasst (aus dem Quiz):*
- 08, also d = 40 mm. $08 dot 5 = 40$ mm. Die 6 steht für das einreihige Rillenkugellager.
][
*Typische Verwechslungen:*
- „2, also d = 10 mm“: Die 2 ist die Durchmesserreihe.
- „208, also d = 208 mm“: Die Zeichen werden einzeln gelesen: Lagerart, Reihe, Bohrungskennzahl.
- „08, also d = 8 mm“: Die Kennzahl wird ab 04 mit 5 multipliziert.
#src[L-alt D4, Frage 11; nach B S. 231–248]
]

#aufgabe(titel: "Lagerbezeichnungen 7203 B und 6006 C3", art: "verstehen", quelle: "10.4", herkunft: "eigen")[
#if not web [*Aufgabe 248* #linebreak()]
Entschlüssle die Lagerbezeichnungen 7203 B und 6006 C3 aus der Stückliste (Bauart, Bohrung). Nutze Abschnitt 10.4 dieses Lernskripts.
][
*Modell / Annahmen:* Worst-Case-Maßkette beziehungsweise Zeichnungsinterpretation nach den genannten Funktionsflächen.

6006 C3: Rillenkugellager (6), Bohrungskennzahl 06 → d = 6 · 5 = 30 mm, Nachsetzzeichen C3 = vergrößerte Lagerluft (vgl. Abschnitt 10.4 dieses Lernskripts). 7203 B: Schrägkugellager (Lagerart 7), Bohrungskennzahl 03 → d = 17 mm (Sonderfall: 00 = 10, 01 = 12, 02 = 15, 03 = 17 mm), Nachsetzzeichen B = Berührungswinkel 40°. Die Bedeutung von 7, 03, B und C3 ist Ergänzung aus DIN 623/Herstellerkatalogen; das Buch nennt nur die Bezeichnungen (S. 274).

*Prüfung:* Maßketten im ungünstigsten Grenzfall prüfen; aus verkleinerten Buchbildern keine Funktionsmaße abgreifen.

#src[L-alt E1, Frage 19; nach B S. 269–290]
]

#aufgabe(titel: "Toleranzen für Welle und Gehäuse wählen", art: "verstehen", quelle: "10.5", herkunft: "variante", vorlage: "Buch Kap. 11, Aufg. 11.28")[
#if not web [*Aufgabe 249* #linebreak()]
Getriebewelle Ø50, Kugellager, normale Last und Laufgenauigkeit, Welle dreht, Kraft steht still. Welche Toleranzen wählst du für Welle und Gehäuse (vgl. Buch 11.28)?
][
*Modell / Annahmen:* Statische Lastzuordnung zum jeweiligen Ring; Zeichenproportionen ersetzen keine Katalogmaße.

Innenring Umfangslast: Welle #strong[k6] (Kugellager bis 100 mm, normale Last). Außenring Punktlast: Gehäuse #strong[H7] (Loslager leicht verschiebbar, normale Laufgenauigkeit) (Tab. 11-1, 11-2).

*Prüfung:* Die Sitzwahl folgt der Relativbewegung zwischen Last und Ring; Zeichnungsmaße sind keine Belastbarkeitswerte.

#src[L-alt D4, Frage 13; nach B S. 231–248]
]

#aufgabe(titel: "Punktlast und Umfangslast", art: "verstehen", quelle: "10.5", herkunft: "eigen")[
#if not web [*Aufgabe 250* #linebreak()]
Definiere Punktlast und Umfangslast. Welcher Ring bekommt den festen Sitz?
][
*Antwort:* Punktlast: Kraft wirkt immer auf dieselbe Ringstelle. Umfangslast: Kraft läuft relativ zum Ring um. Der Ring mit Umfangslast bekommt den festen Sitz (S. 245).
][
*Kurz gefasst (aus der Karteikarte):*
- Bei Punktlast drückt die Kraft immer auf dieselbe Stelle des Rings.
- Bei Umfangslast läuft die Kraft relativ zum Ring um.
- Der Ring mit Umfangslast bekommt den festen Sitz, sonst würde er langsam in seinem Sitz wandern.

*Merksatz:* Umfangslast verlangt festen Sitz.
#src[L-alt D4, Frage 8; nach B S. 231–248]
]

#aufgabe(titel: "Rad auf stehender Achse", art: "verstehen", quelle: "10.5", herkunft: "eigen")[
#if not web [*Aufgabe 251* #linebreak()]
Ein Rad mit stehender Achse: Der Außenring (in der Radnabe) dreht sich, die Last kommt von oben. Wo liegt Umfangslast, wo Punktlast? Welcher Ring braucht den festen Sitz?
][
*Modell / Annahmen:* Statische Lastzuordnung zum jeweiligen Ring; Zeichenproportionen ersetzen keine Katalogmaße.

Die Last steht still, der Außenring dreht sich: Außenring #strong[Umfangslast] → fester Sitz in der Nabe. Innenring auf der stehenden Achse: #strong[Punktlast] → loser Sitz erlaubt (S. 245).

*Prüfung:* Die Sitzwahl folgt der Relativbewegung zwischen Last und Ring; Zeichnungsmaße sind keine Belastbarkeitswerte.

#src[L-alt D4, Frage 14; nach B S. 231–248]
]

#aufgabe(titel: "Laufrad auf stehender Achse", art: "verstehen", quelle: "10.5", herkunft: "eigen")[
#if not web [*Aufgabe 252* #linebreak()]
Ein Laufrad dreht sich mit seinem Wälzlager auf einer stehenden Achse; die Radlast zeigt immer nach unten. Welcher Lagerring hat Umfangslast, und welcher Ring braucht deshalb den festen Sitz?
][
*Modell / Annahmen:* Statische Lastzuordnung zum jeweiligen Ring; Zeichenproportionen ersetzen keine Katalogmaße.

Die Last steht still, der Außenring dreht sich mit dem Rad unter ihr hindurch: Umfangslast am Außenring → Außenring fest im Rad. Der Innenring steht mit der Achse zur Last still: Punktlast → loser Sitz erlaubt (Regel S. 245).

*Prüfung:* Die Sitzwahl folgt der Relativbewegung zwischen Last und Ring; Zeichnungsmaße sind keine Belastbarkeitswerte.
][
*Kurz gefasst (aus der Karteikarte):*
- Der Außenring.
- Er dreht sich mit dem Rad unter der stillstehenden Last hindurch, hat also Umfangslast.
- Der Innenring steht mit der Achse still zur Last, hat Punktlast und darf lose sitzen.
#src[L-alt A7; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

#aufgabe(titel: "Lager 6006 auf einer Getriebewelle", art: "verstehen", quelle: "10.5", herkunft: "eigen")[
#if not web [*Aufgabe 253* #linebreak()]
Eine Getriebewelle trägt ein Rillenkugellager 6006. Die Welle dreht, die Zahnkraft steht still.a) Welcher Wellendurchmesser gehört zum Lagersitz? b) Welche Sitzart braucht der Innenring, und welche Toleranzklasse aus Kapitel 10 passt? c) Gib die Grenzmaße dieses Wellensitzes an.
][
*Modell / Annahmen:* Statische Lastzuordnung zum jeweiligen Ring; Zeichenproportionen ersetzen keine Katalogmaße.

a) 6006 → d = 6 · 5 = 30 mm. b) Innenring hat Umfangslast → fester Sitz, z. B. k6 (Kapitel 10, S. 245). c) Ø30 liegt in „über 18 bis 30“: k6 = +15/+2 µm → 30,002 … 30,015 mm.

*Prüfung:* Die Sitzwahl folgt der Relativbewegung zwischen Last und Ring; Zeichnungsmaße sind keine Belastbarkeitswerte.

#src[L-alt G1; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

#aufgabe(titel: "Umfangslast an der Getriebewelle", art: "verstehen", quelle: "10.5", herkunft: "eigen")[
#if not web [*Aufgabe 254* #linebreak()]
Eine Getriebewelle dreht, die Zahnkraft steht im Raum still. Welcher Lagerring hat Umfangslast und braucht einen festen Sitz? Begründe deine Antwort.
][
*Antwort:*
- Der Innenring. Er läuft unter der stehenden Kraft um. Typisch Welle k6.
][
*Typische Verwechslungen:*
- „Der Außenring“: Der Außenring steht still unter stehender Kraft, das ist Punktlast. Dort ist ein loser Sitz erlaubt (H7).
- „Beide Ringe gleichermaßen“: Die Lastart hängt von der Relativbewegung ab, und die ist für die beiden Ringe verschieden.
- „Keiner, Wälzlager brauchen keinen festen Sitz“: Ein Ring mit Umfangslast würde ohne festen Sitz wandern.
]

#aufgabe(titel: "Fest- und Loslageranordnung", art: "verstehen", quelle: "10.6", herkunft: "original", vorlage: "Buch Kap. 11, Aufg. 11.22 und 11.23")[
#if not web [*Aufgabe 255* #linebreak()]
#enum(numbering: "a)",
[Aus welchen Gründen darf keine Festlager-Festlager-Anordnung realisiert werden?],
[Warum darf keine Loslager-Loslager-Anordnung realisiert werden?],
)
][
*Antwort:* Fest-Fest: Wärmedehnung der Welle verspannt die Lager. Los-Los: Die Welle wäre axial nicht geführt und könnte wandern, Axialkräfte würden nicht aufgenommen (S. 244; zweiter Teil abgeleitet).
][
*Kurz gefasst (aus dem Quiz):* Die Welle erwärmt sich im Betrieb meist stärker als das Gehäuse und dehnt sich aus. Bei zwei Festlagern könnte sie sich nicht längen, die Lager würden verspannt und beschädigt. Das Festlager nimmt alle Axialkräfte in beiden Richtungen auf, das Loslager lässt einen Ring axial wandern und gleicht so die Wärmedehnung aus.
][
*Kurz gefasst (aus der Karteikarte):*
- Bei zwei Festlagern verspannt die Wärmedehnung der Welle die Lager gegeneinander.
- Bei zwei Loslagern ist die Welle axial nicht geführt und kann wandern.
- Deshalb führt ein Festlager die Welle axial, und das Loslager lässt die Längenänderung zu.

*Merksatz:* Festlager führt, Loslager lässt die Länge zu.
#bild("b-stuetzlagerung", [Bild 11-21: Zwei Seiten einer Stützlagerung. B, S. 245 (PDF-S. 256).], height: 50mm)
][
*Bild:* Ein Brückenträger: an einem Ende fest verankert, am anderen auf Rollen, damit er sich im Sommer ausdehnen kann.
#src[L-alt D4, Frage 7; nach B S. 231–248]
]

#aufgabe(titel: "Sicherung von Los- und Festlager", art: "verstehen", quelle: "10.6", herkunft: "original", vorlage: "Buch Kap. 11, Aufg. 11.30")[
#if not web [*Aufgabe 256* #linebreak()]
Bei einer Festlager-Loslager-Anordnung wird häufig das Loslager mithilfe eines Sicherungsringes auf der Welle fixiert, das Festlager hingegen in der Regel mithilfe einer Nutmutter mit Sicherungsblech. Können Sie sich erklären, warum so vorgegangen wird?
][
*Antwort:* Das Loslager muss nur einen Ring leicht halten, dafür reicht ein billiger Sicherungsring. Das Festlager nimmt alle Axialkräfte auf und soll spielfrei sitzen; das schafft nur die Nutmutter (S. 227, 243–244; abgeleitet).
][
*Kurz gefasst (aus der Karteikarte):*
- Das Loslager muss nur einen Ring leicht halten, dafür reicht ein billiger Sicherungsring.
- Das Festlager nimmt alle Axialkräfte auf und soll spielfrei sitzen.
- Das schafft nur die Nutmutter mit Sicherungsblech.
#bild("b-stuetzlagerung", [Bild 11-21: Zwei Seiten einer Stützlagerung. B, S. 245 (PDF-S. 256).], height: 50mm)
#src[L-alt D4, Frage 9; nach B S. 231–248]
]

#aufgabe(titel: "Festlager axial festlegen", art: "verstehen", quelle: "10.6", herkunft: "eigen")[
#if not web [*Aufgabe 257* #linebreak()]
Wie werden beide Ringe eines Festlagers axial festgelegt?
][
*Antwort:* Bei der klassischen Festlager-Loslager-Anordnung sind Innen- und Außenring des Festlagers axial beidseitig festgelegt. Dieses Lager führt die Welle axial und nimmt ihre Axialkräfte auf; das Loslager lässt den Längenausgleich zu.

#src[L-alt D4, offene Überarbeitung Frage 16; B S. 231–248]
]


#kapitel("Kapitel 11 · Dichtungen")

#aufgabe(titel: "Drei Gründe für Dichtungen", art: "verstehen", quelle: "11.1", herkunft: "variante", vorlage: "Buch Kap. 12, Aufg. 12.1")[
#if not web [*Aufgabe 258* #linebreak()]
Nenne drei Gründe für den Einsatz von Dichtungen. (vgl. Buch 12.1)
][
*Antwort:* Stoffverluste vermeiden (Gase, Flüssigkeiten), Vermischung verschiedener Betriebsstoffe verhindern, Verschleiß durch Schmutz, Staub und Feuchtigkeit vermeiden (S. 249).
][
*Kurz gefasst (aus der Karteikarte):*
- Um Stoffverluste (Gase, Flüssigkeiten) zu vermeiden, die Vermischung verschiedener Betriebsstoffe zu verhindern und Verschleiß durch Schmutz, Staub und Feuchtigkeit zu vermeiden.
#src[L-alt D5, Frage 1; nach B S. 249–258]
]

#aufgabe(titel: "Einteilung von Dichtungen", art: "verstehen", quelle: "11.1", herkunft: "eigen")[
#if not web [*Aufgabe 259* #linebreak()]
Nach welchen zwei Merkmalen teilt man Dichtungen ein, und welche Kombination gibt es nicht?
][
*Antwort:* Ruhende oder bewegte Bauteile sowie berührend oder berührungsfrei. Berührungsfreie Dichtungen an ruhenden Teilen gibt es nicht (S. 249).
][
*Kurz gefasst (aus der Karteikarte):*
- Nach ruhenden oder bewegten Bauteilen und nach berührend oder berührungsfrei.
- Berührungsfreie Dichtungen an ruhenden Teilen gibt es nicht.
#src[L-alt D5, Frage 2; nach B S. 249–258]
]

#aufgabe(titel: "Faltenbalg, statisch oder dynamisch", art: "verstehen", quelle: "11.2", herkunft: "original", vorlage: "Buch Kap. 12, Aufg. 12.6")[
#if not web [*Aufgabe 260* #linebreak()]
Mithilfe eines Faltenbalgs können relativ zueinander bewegte Teile abgedichtet werden. Gehören die Faltenbälge deswegen zu den dynamischen Dichtungen?
][
*Antwort:* Nein. Der Faltenbalg ist eine statische, hermetische Dichtung; er kann wegen seiner Form trotzdem bewegte Teile abdichten (S. 250).
][
*Kurz gefasst (aus der Karteikarte):*
- Nein.
- Er ist eine statische, hermetische Dichtung, die an beiden Enden fest sitzt.
- Er kann bewegte Teile nur wegen seiner Form abdichten.
#src[L-alt D5, Frage 4; nach B S. 249–258]
]

#aufgabe(titel: "Wie eine statische Dichtung dichtet", art: "verstehen", quelle: "11.2", herkunft: "eigen")[
#if not web [*Aufgabe 261* #linebreak()]
Wie funktioniert eine statische Dichtung, und welche zwei Voraussetzungen braucht sie?
][
*Antwort:* Die Rauheitsspitzen der Bauteilfläche betten sich in den Dichtungswerkstoff ein. Voraussetzungen: weicherer Dichtungswerkstoff und eine Anpresskraft durch Schrauben oder Betriebsdruck (S. 249–250).
][
*Kurz gefasst (aus der Karteikarte):*
- Die Rauheitsspitzen der Bauteilfläche drücken sich in den Dichtungswerkstoff ein und schließen so die Spalte.
- Dafür braucht es einen weicheren Dichtungswerkstoff und eine Anpresskraft durch Schrauben oder Betriebsdruck.

*Merksatz:* Weicher Dichtstoff plus Anpressung schließt die Spalte.
#src[L-alt D5, Frage 3; nach B S. 249–258]
]

#aufgabe(titel: "Schraffur von Dichtungen", art: "verstehen", quelle: "11.3", herkunft: "eigen")[
#if not web [*Aufgabe 262* #linebreak()]
Mit welcher Schraffur zeichnet man eine Elastomerdichtung, eine Kupferdichtung und eine sehr dünne Flachdichtung? Was muss dann zusätzlich passieren?
][
*Antwort:* Elastomer: Kreuzschraffur. Kupfer: 45°-Schraffur (oder NE-Metall-Schraffur, wenn der Werkstoff betont werden soll). Sehr dünn: geschwärzt. Dann muss der Werkstoff in der Stückliste stehen (S. 250).

#src[L-alt D5, Frage 5; nach B S. 249–258]
]

#aufgabe(titel: "Eingebauter O-Ring und Filzring", art: "verstehen", quelle: "11.4", herkunft: "original", vorlage: "Buch Kap. 12, Aufg. 12.5")[
#if not web [*Aufgabe 263* #linebreak()]
Was ist bei der Darstellung des Einbauzustandes bei einem Runddichtring oder einem Filzring zu beachten?
][
*Antwort:* O-Ring: verformt zeichnen, weil die Verformung die Anpresskraft erzeugt (S. 252). Filzring: zusammengedrückt in der konischen Nut, mit Abstand zum Nutgrund (S. 254).
][
*Kurz gefasst (aus dem Quiz):*
- Verformt, weil erst die Verformung die Anpresskraft erzeugt. Statische Dichtungen werden immer im Schnitt gezeichnet, Elastomere meist mit Kreuzschraffur.
][
*Typische Verwechslungen:*
- „Kreisrund, wie im Katalog“: Kreisrund wäre der uneingebaute Zustand.
- „Gar nicht, Dichtungen werden nur in der Stückliste geführt“: Dichtungen werden gezeichnet, damit man Querschnitt und Funktion sieht.
- „Als verdeckte Kante“: Dichtungen werden im Schnitt dargestellt, nicht verdeckt.
][
*Kurz gefasst (aus der Karteikarte):*
- Die Verformung erzeugt die Anpresskraft, die abdichtet.
- Ein unverformt gezeichneter O-Ring würde eine Dichtung ohne Wirkung zeigen.

*Merksatz:* Der O-Ring dichtet durch Verformung.
#src[L-alt D5, Frage 6; nach B S. 249–258]
]

#aufgabe(titel: "O-Ring-Bezeichnung entschlüsseln", art: "verstehen", quelle: "11.4", herkunft: "eigen")[
#if not web [*Aufgabe 264* #linebreak()]
Erkläre jedes Glied der Bezeichnung „O-Ring DIN 3771 – 13,2 x 1,8 – N – NBR70“.
][
*Modell / Annahmen:* Im Buch beschriebener Einbaufall; Tabellenwerte gelten für die bezeichnete Dichtung und Nut.

DIN 3771 = Norm, 13,2 = Innendurchmesser d1, 1,8 = Schnurstärke d2, N = Sortenmerkmal, NBR70 = Werkstoff mit Härte (S. 251; Bedeutung von N/NBR70 als Ergänzung).

*Prüfung:* Einbauraum, Toleranz und Oberflächenforderung müssen zur betreffenden Dichtung passen.

#src[L-alt D5, Frage 14; nach B S. 249–258]
]

#aufgabe(titel: "Nut für O-Ring mit d2 = 6 mm", art: "verstehen", quelle: "11.4", herkunft: "eigen")[
#if not web [*Aufgabe 265* #linebreak()]
Ein O-Ring mit d2 = 6 mm soll radial verformt in eine Rechtecknut. Welche Nuttiefe T und Nutbreite B gibst du an, und wie lautet die Breitenangabe mit Toleranz?
][
*Modell / Annahmen:* Im Buch beschriebener Einbaufall; Tabellenwerte gelten für die bezeichnete Dichtung und Nut.

Tab. 12-1, d2 = 6 mm:  T = 4,95 mm,  B = 7,8 mm
Breitenangabe nach Bild 12-3:  7,8 +0,2

*Prüfung:* Einbauraum, Toleranz und Oberflächenforderung müssen zur betreffenden Dichtung passen.

#src[L-alt D5, Frage 15; nach B S. 249–258]
]

#aufgabe(titel: "Nut für O-Ring mit d2 = 2 mm", art: "verstehen", quelle: "11.4", herkunft: "eigen")[
#if not web [*Aufgabe 266* #linebreak()]
Ein O-Ring mit d2 = 2 mm wird radial verformt eingebaut. Welche Nuttiefe und welche Nutbreite trägst du ein? (Kapitel 11, Tab. 12-1, S. 252)
][
*Modell / Annahmen:* Im Buch beschriebener Einbaufall; Tabellenwerte gelten für die bezeichnete Dichtung und Nut.

T = 1,5 mm, B = 2,6 mm, Eintrag der Breite mit 2,6 +0,2 (S. 251–252).

*Prüfung:* Einbauraum, Toleranz und Oberflächenforderung müssen zur betreffenden Dichtung passen.

#src[L-alt S6; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

#aufgabe(titel: "Geringer Leckverlust beim RWDR", art: "verstehen", quelle: "11.5", herkunft: "eigen")[
#if not web [*Aufgabe 267* #linebreak()]
Warum hat ein RWDR einen geringen Leckverlust, obwohl er berührend dichtet?
][
*Antwort:* An der Gleitfläche muss ein Schmierfilm des Mediums vorhanden sein, sonst verschleißt die Lippe schnell. Dieser Film führt langfristig zu geringer Leckage (S. 252).
][
*Kurz gefasst (aus der Karteikarte):*
- Unter der Lippe muss ein Schmierfilm des Mediums vorhanden sein, sonst verschleißt sie schnell.
- Dieser Film führt auf Dauer zu einer geringen Leckage.

*Merksatz:* Die Dichtlippe braucht ihren Schmierfilm.
#bild("b-rwdr", [Bild 12-5: Einbaurichtlinien für Radial-Wellendichtringe. B, S. 253 (PDF-S. 264).], height: 50mm)
#src[L-alt D5, Frage 8; nach B S. 249–258]
]

#aufgabe(titel: "Angaben an Welle und Bohrung für den RWDR", art: "verstehen", quelle: "11.6", herkunft: "variante", vorlage: "Buch Kap. 12, Aufg. 12.10")[
#if not web [*Aufgabe 268* #linebreak()]
Der RWDR aus „RWDR für Welle Ø30 bezeichnen“ wird mit der Dichtlippe voran über das Wellenende geschoben. Liste alle Angaben auf, die du an Welle und Gehäusebohrung einträgst. (vgl. Buch 12.10)
][
*Modell / Annahmen:* Im Buch beschriebener Einbaufall; Tabellenwerte gelten für die bezeichnete Dichtung und Nut.

Welle: Fase 15° bis 25°, Kante gerundet und poliert, Ø30 h11, drallfrei geschliffen (Rundheit IT 8), Ra 0,2 bis 0,8 µm als obere und untere Grenze. Bohrung: Ø47 H8, Einführfase 5° bis 10°, Rmax ≤ 25 µm (S. 253–254).

*Prüfung:* Einbauraum, Toleranz und Oberflächenforderung müssen zur betreffenden Dichtung passen.

#src[L-alt D5, Frage 17; nach B S. 249–258]
]

#aufgabe(titel: "Drei Teile eines RWDR", art: "verstehen", quelle: "11.6", herkunft: "eigen")[
#if not web [*Aufgabe 269* #linebreak()]
Aus welchen drei Teilen besteht ein RWDR, und wie wird jedes Teil im Schnitt dargestellt?
][
*Antwort:* Kunststoffkörper mit Lippe (geschwärzt), Versteifungsring aus Metall (schraffiert), Feder (zwei kleine konzentrische Kreise) (S. 252–253).

#src[L-alt D5, Frage 7; nach B S. 249–258]
]

#aufgabe(titel: "Untere Rauheitsgrenze unter dem RWDR", art: "verstehen", quelle: "11.6", herkunft: "eigen")[
#if not web [*Aufgabe 270* #linebreak()]
Warum wird für die Welle unter einem RWDR auch eine #strong[untere] Rauheitsgrenze angegeben?
][
*Antwort:* Eine zu glatte Welle lässt die Dichtlippe heiß laufen (S. 254).
][
*Kurz gefasst (aus der Karteikarte):*
- Eine zu glatte Welle hält keinen Schmierfilm, und die Dichtlippe läuft heiß.
- Deshalb gibt man zwei Werte an, zum Beispiel Ra 0,8 oben und Ra 0,2 unten.
#bild("alt-d5-2", [RWDR im Einbau, Montage mit der Dichtlippe voran (eigene Skizze, vgl. Bild 12-4/12-5, S. 253) Quelle der Skizze: L-alt D5; eigene Darstellung.], height: 50mm)
#src[L-alt D5, Frage 9; nach B S. 249–258]
]

#aufgabe(titel: "RWDR für Welle Ø30 bezeichnen", art: "verstehen", quelle: "11.6", herkunft: "eigen")[
#if not web [*Aufgabe 271* #linebreak()]
Bezeichne einen RWDR Form A für eine Welle Ø 30 mm, Gehäusebohrung Ø 47 mm, Breite 7 mm, Elastomer NB.
][
*Modell / Annahmen:* Im Buch beschriebener Einbaufall; Tabellenwerte gelten für die bezeichnete Dichtung und Nut.

Wellendichtring DIN 3760 – A 30 x 47 x 7 NB (Schema S. 254).

*Prüfung:* Einbauraum, Toleranz und Oberflächenforderung müssen zur betreffenden Dichtung passen.

#src[L-alt D5, Frage 16; nach B S. 249–258]
]

#aufgabe(titel: "Dichtlippe eines RWDR schützen", art: "verstehen", quelle: "11.6", herkunft: "eigen")[
#if not web [*Aufgabe 272* #linebreak()]
Welche Montage- und Anschlussanforderungen schützen die Dichtlippe eines RWDR?
][
*Antwort:* Die Feder wird als zwei kleine konzentrische Kreise gezeichnet. Bei Montage mit der Lippe nach hinten genügt an der Welle R ≥ 1 mm.

#src[L-alt D5, offene Überarbeitung Frage 19; B S. 249–258]
]

#aufgabe(titel: "RWDR für Welle Ø40 bezeichnen", art: "verstehen", quelle: "11.6", herkunft: "eigen")[
#if not web [*Aufgabe 273* #linebreak()]
Bilde die Normbezeichnung eines Radial-Wellendichtrings Form A für Welle Ø40, Gehäuse Ø62, Breite 8 mm, Elastomer NB.
][
*Modell / Annahmen:* Im Buch beschriebener Einbaufall; Tabellenwerte gelten für die bezeichnete Dichtung und Nut.

Wellendichtring DIN 3760 – A 40 x 62 x 8 NB (Schema S. 254).

*Prüfung:* Einbauraum, Toleranz und Oberflächenforderung müssen zur betreffenden Dichtung passen.

#src[L-alt A8; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

#aufgabe(titel: "Welle Ø40 h11 unter dem RWDR", art: "rechnen", quelle: "11.6", herkunft: "eigen",
  ergebnis: [39,840 bis 40,000 mm; Rauheit als Ra 0,8 oben und Ra 0,2 unten im Symbol],
  tipp: [Unter einer Dichtlippe darf die Welle weder zu rau noch zu glatt sein.],
)[
#if not web [*Aufgabe 274* #linebreak()]
*Gegeben und Annahmen*

Unter einem Radial-Wellendichtring hat die Welle Ø40 h11. h11 bei Ø40: es/ei = 0/−160 µm. Für den RWDR-Sitz gilt in der verwendeten Unterlage Ra = 0,2 bis 0,8 µm.

*Gesucht*

#enum(numbering: "a)",
[Grenzmaße?],
[Wie trägst du die zulässige Rauheit ein, und warum hat sie zwei Grenzen?],
)
][
*a) Tabelle:* h11 im Bereich über 30 bis 50: 0/−160 µm.
][
*Grenzmaße:* 40,000 − 0,160 = 39,840 mm bis 40,000 mm.
][
*b) Eintrag:* Zwei Werte übereinander im Oberflächensymbol, oben Ra 0,8 (obere Grenze), unten Ra 0,2 (untere Grenze). Bei gleicher Kenngröße dürfen U und L entfallen (S. 115).
][
*Warum zwei Grenzen:* Eine zu raue Welle schleift die Dichtlippe ab. Eine zu glatte Welle hält keinen Schmierfilm, die Lippe läuft trocken und wird heiß (S. 254).
#src[L-alt G5; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

#aufgabe(titel: "Federnde Abdeckscheiben", art: "verstehen", quelle: "11.7", herkunft: "eigen")[
#if not web [*Aufgabe 275* #linebreak()]
Wofür werden federnde Abdeckscheiben verwendet, und wie werden sie gezeichnet?
][
*Antwort:* Zur Abdichtung von Wälzlagern bei Fettschmierung. Sie sind aus Metall, aber so dünn, dass sie geschwärzt gezeichnet werden (S. 254–255).

#src[L-alt D5, Frage 10; nach B S. 249–258]
]

#aufgabe(titel: "Filzring für Welle Ø50 bezeichnen", art: "verstehen", quelle: "11.7", herkunft: "eigen")[
#if not web [*Aufgabe 276* #linebreak()]
Bezeichne einen Filzring für eine Welle Ø 50 mm mit Filzhärte M5.
][
*Modell / Annahmen:* Im Buch beschriebener Einbaufall; Tabellenwerte gelten für die bezeichnete Dichtung und Nut.

Filzring DIN 5419 – 50 – M5 (S. 254).

*Prüfung:* Einbauraum, Toleranz und Oberflächenforderung müssen zur betreffenden Dichtung passen.

#src[L-alt D5, Frage 18; nach B S. 249–258]
]

#aufgabe(titel: "Herstellerbezeichnung bei Stopfbuchsen", art: "verstehen", quelle: "11.8", herkunft: "eigen")[
#if not web [*Aufgabe 277* #linebreak()]
Warum muss bei einer Stopfbuchsenpackung die Herstellerbezeichnung in der Stückliste stehen?
][
*Antwort:* Stopfbuchsen werden wegen ihrer Vielfalt meist nicht im Detail gezeichnet, die Zeichnung allein reicht also nicht zur Bestellung (S. 256).

#src[L-alt D5, Frage 11; nach B S. 249–258]
]

#aufgabe(titel: "Schutzdichtung und Strömungsdichtung", art: "verstehen", quelle: "11.9", herkunft: "original", vorlage: "Buch Kap. 12, Aufg. 12.16")[
#if not web [*Aufgabe 278* #linebreak()]
Was ist der Unterschied zwischen Schutzdichtungen und Strömungsdichtungen?
][
*Antwort:* Strömungsdichtungen werden bei einem Druckunterschied zwischen innen und außen gebraucht und bremsen das Medium z. B. durch ein Labyrinth ab; sie haben immer eine Leckmenge. Schutzdichtungen schützen vor Schmutz ohne nennenswerten Druckunterschied (S. 256–257; Schutzfunktion abgeleitet).
][
*Kurz gefasst (aus der Karteikarte):*
- Strömungsdichtungen arbeiten bei einem Druckunterschied und bremsen das Medium ab, zum Beispiel durch ein Labyrinth.
- Sie haben immer eine Leckmenge.
- Schutzdichtungen halten Schmutz fern, ohne dass ein nennenswerter Druckunterschied besteht.
#src[L-alt D5, Frage 12; nach B S. 249–258]
]

#aufgabe(titel: "Berührungsfreie Dichtungen", art: "verstehen", quelle: "11.9", herkunft: "eigen")[
#if not web [*Aufgabe 279* #linebreak()]
Warum eignen sich berührungsfreie Dichtungen für hohe Drehzahlen und weshalb sind sie nicht pauschal leckfrei?
][
*Antwort:* sind praktisch verschleißfrei. eignen sich für hohe Drehzahlen. werden als Schutzdichtung aus Stahl mit 45°-Schraffur gezeichnet.
][
*Kurz gefasst (aus der Karteikarte):*
- Es gibt keinen Kontakt, also keine Reibung, keine Wärme und praktisch keinen Verschleiß.
- Dafür sind sie nie ganz dicht.
#src[L-alt D5, offene Überarbeitung Frage 20; B S. 249–258]
]

#aufgabe(titel: "Dichtung vereinfacht darstellen", art: "verstehen", quelle: "11.10", herkunft: "eigen")[
#if not web [*Aufgabe 280* #linebreak()]
Wann darf eine Dichtung vereinfacht nach DIN ISO 9222 dargestellt werden?
][
*Antwort:* Wenn alle Funktionen klar sind und die Dichtung von untergeordneter Bedeutung ist; sonst immer ausführlich (S. 257).

#src[L-alt D5, Frage 13; nach B S. 249–258]
]

#aufgabe(titel: "Rechteck mit Diagonalkreuz", art: "verstehen", quelle: "11.10", herkunft: "eigen")[
#if not web [*Aufgabe 281* #linebreak()]
Wie liest Du die vereinfachte Dichtungsdarstellung mit Rechteck und Diagonalkreuz?
][
*Antwort:* stammt aus DIN ISO 9222-1. wird in breiter Volllinie gezeichnet. kann durch einen Pfeil für die Dichtungsrichtung ergänzt werden.

#src[L-alt D5, offene Überarbeitung Frage 21; B S. 249–258]
]


#kapitel("Kapitel 12 · Zahnräder")

#aufgabe(titel: "Einteilung der Zahnradgetriebe", art: "verstehen", quelle: "12.1", herkunft: "original", vorlage: "Buch Kap. 13, Aufg. 13.1")[
#if not web [*Aufgabe 282* #linebreak()]
Entsprechend welcher Systematik können Zahnräder unterteilt werden? Welche Merkmale von Zahnrädern spielen bei dieser Unterteilung eine Rolle?
][
*Antwort:* Grobgestalt der Räder und Lage der Wellen. Parallel: Stirnrad; schneidend: Kegelrad; kreuzend: Schnecke, Schraubrad, Hypoid (S. 259–260).
][
*Kurz gefasst (aus der Karteikarte):*
- Nach der Grobgestalt der Räder und der Lage der Wellen.
- *Parallele Wellen:* Stirnräder.
- *Sich schneidende Wellen:* Kegelräder.
- *Sich kreuzende Wellen:* Schnecken-, Schraub- und Hypoidgetriebe.
#bild("b-getriebearten", [Bild 13-2: Getriebearten nach Stellung der Wellen. B, S. 260 (PDF-S. 271).], height: 50mm)
#src[L-alt D6, Frage 1; nach B S. 259–268]
]

#aufgabe(titel: "Modul und kämmende Räder", art: "verstehen", quelle: "12.2", herkunft: "eigen")[
#if not web [*Aufgabe 283* #linebreak()]
Wie ist der Modul definiert, und warum müssen zwei kämmende Räder denselben Modul haben?
][
*Antwort:* m = d/z. Beide Verzahnungen müssen von gleicher Art sein, sonst passen Teilung und Zahnform nicht zusammen (S. 260).
][
*Kurz gefasst (aus der Karteikarte):*
- $m = d\/z$, also Teilkreisdurchmesser pro Zahn.
- Er bestimmt die Zahngröße.
- Nur bei gleichem Modul passen Teilung und Zahnform zusammen.

*Merksatz:* Gleicher Modul bedeutet passende Zahngröße.
#bild("alt-d6-1", [Zahnausschnitt eines geradverzahnten Stirnrads (eigene Skizze, vgl. Bild 13-3, S. 261) Quelle der Skizze: L-alt D6; eigene Darstellung.], height: 50mm)
][
*Bild:* Wie die Gliedergröße einer Fahrradkette: Ritzel und Kettenblatt müssen zur selben Kette passen.
#src[L-alt D6, Frage 2; nach B S. 259–268]
]

#aufgabe(titel: "Räder mit verschiedenem Modul", art: "verstehen", quelle: "12.2", herkunft: "eigen")[
#if not web [*Aufgabe 284* #linebreak()]
Ein Rad mit m = 4 mm soll mit einem Rad mit m = 5 mm gepaart werden. Geht das? Begründe.
][
*Modell / Annahmen:* Unverschobenes geradverzahntes Stirnrad, sofern nicht anders angegeben.

Nein. Kämmende Räder müssen den gleichen Modul haben (S. 260).

*Prüfung:* Alle Durchmesser in mm; Kopfkreis größer und Fußkreis kleiner als der Teilkreis.

#src[L-alt D6, Frage 16; nach B S. 259–268]
]

#aufgabe(titel: "Teil- und Kopfkreis bei m = 3 mm und z = 45", art: "verstehen", quelle: "12.2", herkunft: "eigen",
  tipp: [$m = d \/ z$, $h_a = m$],
)[
#if not web [*Aufgabe 285* #linebreak()]
Ein Stirnrad hat den Modul $m = 3$ mm und $z = 45$ Zähne. Wie groß sind Teilkreis- und Kopfkreisdurchmesser? Begründe deine Antwort.
][
*Antwort:*
- $d = 135$ mm, $d_a = 141$ mm. $d = m z = 135$ mm, $d_a = m (z + 2) = 141$ mm.
][
*Typische Verwechslungen:*
- „$d = 15$ mm, $d_a = 21$ mm“: Hier wurde $z\/m$ statt $m dot z$ gerechnet.
- „$d = 135$ mm, $d_a = 138$ mm“: Die Kopfhöhe $h_a = m$ kommt auf beiden Seiten dazu, also $2 h_a$.
- „$d = 141$ mm, $d_a = 135$ mm“: Vertauscht: Der Kopfkreis ist größer als der Teilkreis.
]

#aufgabe(titel: "Modul und Kopfkreis aus d und z", art: "rechnen", quelle: "12.2", herkunft: "eigen",
  ergebnis: [m = 3 mm, ha = 3 mm, da = 126 mm],
  tipp: [Der Modul ist Teilkreisdurchmesser geteilt durch Zähnezahl.],
)[
#if not web [*Aufgabe 286* #linebreak()]
*Gegeben und Annahmen*

Ein Stirnrad hat d = 120 mm und z = 40.

*Gesucht*

#enum(numbering: "a)",
[Bestimme m, ha und da.],
)
][
*Bild:* Der Modul ist ein Maß für die Zahngröße: Wie viel Teilkreisdurchmesser kommt auf einen Zahn?
][
*Modul:* $m = d\/z = 120\/40 = 3 thin "mm"$.
][
*Kopfhöhe:* Beim Normprofil gilt $h_a = m = 3 thin "mm"$.
][
*Kopfkreis:* Auf beiden Seiten ragt ein Zahnkopf hinaus: $d_a = d + 2 h_a = 120 + 6 = 126 thin "mm"$.
][
*Prüfen:* $d_a = m (z + 2) = 3 dot 42 = 126 thin "mm"$, gleiches Ergebnis. Der Kopfkreis ist größer als der Teilkreis.
#src[L-alt D6, Frage 14; nach B S. 259–268]
]

#aufgabe(titel: "Maße eines Radpaars mit m = 2,5 mm", art: "rechnen", quelle: "12.2", herkunft: "eigen",
  ergebnis: [d1 = 45 mm, d2 = 135 mm, da1 = 50 mm, df1 = 38,75 mm, a = 90 mm],
  tipp: [Teilkreis $d = m z$; Kopf $h_a = m$; Fuß $h_f = m + c$; Achsabstand ist die Summe der Teilkreisradien.],
)[
#if not web [*Aufgabe 287* #linebreak()]
*Gegeben und Annahmen*

Ritzel z1 = 18, Rad z2 = 54, Modul m = 2,5 mm, Kopfspiel c = 0,25 · m.

*Gesucht*

#enum(numbering: "a)",
[Bestimme d1, d2, da1, df1 und den Achsabstand a (Ergänzungsformel).],
)
][
*Bild:* Zwei kämmende Räder rollen mit ihren Teilkreisen aufeinander ab wie zwei Reibräder. Deshalb bestimmen die Teilkreise den Achsabstand.
][
*Teilkreise:* $d_1 = "2,5" dot 18 = 45 thin "mm"$, $d_2 = "2,5" dot 54 = 135 thin "mm"$.
][
*Kopfkreis Ritzel:* $d_(a 1) = 45 + 2 dot "2,5" = 50 thin "mm"$.
][
*Fußkreis Ritzel:* $c = "0,625" thin "mm"$, also $h_f = "2,5" + "0,625" = "3,125" thin "mm"$ und $d_(f 1) = 45 - 2 dot "3,125" = "38,75" thin "mm"$.
][
*Achsabstand und Prüfung:* $a = (45 + 135)\/2 = 90 thin "mm"$. Probe: $d_f < d < d_a$, also $"38,75" < 45 < 50$. Das Kopfspiel sorgt dafür, dass der Zahnkopf des Gegenrads nicht im Grund aufsitzt.
#src[L-alt D6, Frage 15; nach B S. 259–268]
]

#aufgabe(titel: "Stirnrad mit m = 2 mm und z = 40", art: "rechnen", quelle: "12.2", herkunft: "eigen",
  ergebnis: [d = 80 mm, da = 84 mm, df = 75 mm],
  tipp: [Fußhöhe ist Kopfhöhe plus Kopfspiel.],
)[
#if not web [*Aufgabe 288* #linebreak()]
*Gegeben und Annahmen*

Ein Stirnrad hat m = 2 mm, z = 40 und angenommen c = 0,25 m.

*Gesucht*

#enum(numbering: "a)",
[Berechne d, da und df.],
)
][
*Teilkreis:* $d = m z = 2 dot 40 = 80 thin "mm"$.
][
*Kopfkreis:* $h_a = m = 2 thin "mm"$, also $d_a = 80 + 4 = 84 thin "mm"$.
][
*Fußkreis:* $c = "0,25" dot 2 = "0,5" thin "mm"$, $h_f = m + c = "2,5" thin "mm"$, also $d_f = 80 - 5 = 75 thin "mm"$.
][
*Prüfen:* $75 < 80 < 84$. Der Fuß geht tiefer als der Kopf hinaus, damit das Gegenrad Platz hat. c ist hier eine Aufgabenannahme.
#src[L-alt L6; eigene Aufgabe nach B S. 260–261]
]

#aufgabe(titel: "Radpaar mit Übersetzung 1 : 3", art: "rechnen", quelle: "12.2", herkunft: "eigen",
  ergebnis: [d1 = 60 mm, d2 = 180 mm, da1 = 66 mm, a = 120 mm, i = 3],
  tipp: [Die Übersetzung ist das Zähnezahlverhältnis.],
)[
#if not web [*Aufgabe 289* #linebreak()]
*Gegeben und Annahmen*

Ein Radpaar hat z1 = 20, z2 = 60, m = 3 mm.

*Gesucht*

#enum(numbering: "a)",
[Berechne d1, d2, da1, den Achsabstand a und die Übersetzung i (a und i: Ergänzungsformeln).],
)
][
*Teilkreise:* $d_1 = 3 dot 20 = 60 thin "mm"$, $d_2 = 3 dot 60 = 180 thin "mm"$.
][
*Kopfkreis Ritzel:* $d_(a 1) = 60 + 2 dot 3 = 66 thin "mm"$.
][
*Achsabstand:* $a = (60 + 180)\/2 = 120 thin "mm"$.
][
*Übersetzung:* $i = z_2\/z_1 = 60\/20 = 3$. Das große Rad dreht dreimal langsamer, liefert aber etwa das dreifache Moment.
][
*Prüfen:* Auch $d_2\/d_1 = 3$, denn beide Räder haben denselben Modul.
#src[L-alt A6; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

#aufgabe(titel: "Zahnrad mit Passfeder auf der Welle", art: "rechnen", quelle: "12.2", herkunft: "eigen",
  ergebnis: [a) da = 85 mm, b) Übergangspassung (PO = +19 µm, PU = −15 µm), c) die Passfeder überträgt das Drehmoment formschlüssig],
  tipp: [Eine Übergangspassung kann Spiel haben, sie hält also kein Moment sicher.],
)[
#if not web [*Aufgabe 290* #linebreak()]
*Gegeben und Annahmen*

Ein Zahnrad m = 2,5 mm, z = 32 sitzt mit Ø25 H7/k6 und einer Passfeder auf der Welle. Abmaße der Passung: H7: ES/EI = +21/0 µm; k6: es/ei = +15/+2 µm.

*Gesucht*

#enum(numbering: "a)",
[Kopfkreisdurchmesser?],
[Passungsart der Bohrung?],
[Warum braucht das Rad trotz der Passung eine Passfeder?],
)
][
*a) Kopfkreis:* $d = "2,5" dot 32 = 80 thin "mm"$ und $d_a = m (z + 2) = "2,5" dot 34 = 85 thin "mm"$.
][
*b) Abmaße:* H7 bei Ø25: +21/0 µm; k6: +15/+2 µm.
][
*b) Grenzpassungen:* $P_O = 21 - 2 = +19 thin "µm"$, $P_U = 0 - 15 = -15 thin "µm"$. Spiel oder Übermaß sind möglich: *Übergangspassung*.
][
*c) Warum die Passfeder:* Eine Übergangspassung garantiert keinen Presssitz. Im ungünstigen Fall hat das Rad Spiel und würde rutschen. Die Passfeder überträgt das Drehmoment formschlüssig, die Passung sorgt nur für die Zentrierung (vgl. Tellerrad im Spiralkegelgetriebe, S. 282).
#src[L-alt G3; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

#aufgabe(titel: "Keine vereinfachte Zahnraddarstellung", art: "verstehen", quelle: "12.3", herkunft: "eigen")[
#if not web [*Aufgabe 291* #linebreak()]
Warum gibt es für Zahnräder keine eigene „vereinfachte Darstellung“?
][
*Antwort:* Die normgerechte Darstellung ist bereits symbolisch und damit vereinfacht; eine ausführliche Darstellung wäre eher nicht normgerecht (S. 259).

#src[L-alt D6, Frage 3; nach B S. 259–268]
]

#aufgabe(titel: "Zahnrad in der Ansicht erkennen", art: "verstehen", quelle: "12.3", herkunft: "eigen")[
#if not web [*Aufgabe 292* #linebreak()]
Woran erkennt man in einer Ansicht, dass eine Scheibe ein Zahnrad ist?
][
*Antwort:* Nur an der strichpunktierten Teilkreislinie (S. 262).
][
*Kurz gefasst (aus der Karteikarte):*
- Nur an der strichpunktierten Teilkreislinie.
- Die Zähne selbst werden nicht gezeichnet.
#bild("b-stirnrad", [Bild 13-4: Stirnrad in Ansicht, Halbschnitt und Vollschnitt. B, S. 263 (PDF-S. 274).], height: 50mm)
#src[L-alt D6, Frage 4; nach B S. 259–268]
]

#aufgabe(titel: "Kopf-, Teil- und Fußkreis zeichnen", art: "verstehen", quelle: "12.3", herkunft: "eigen")[
#if not web [*Aufgabe 293* #linebreak()]
Mit welchen Linienarten werden Kopfkreis, Teilkreis und Fußkreis in der Ansicht gezeichnet?
][
*Antwort:* Kopfkreis: breite Volllinie (Körperkante); Teilkreis: schmale Strichpunktlinie; Fußkreis: schmale Volllinie, nur bei Bedarf (S. 261–262).
][
*Kurz gefasst (aus dem Quiz):*
- Als schmale Strich-Punktlinie. In der Ansicht ist sie das einzige Merkmal, das ein Zahnrad von einer Scheibe unterscheidet.
][
*Typische Verwechslungen:*
- „Als breite Volllinie“: Breite Volllinien sind sichtbare Kanten, und der Teilkreis ist keine Kante.
- „Als schmale Volllinie“: So wird bei Bedarf der Fußkreis gezeichnet.
- „Gar nicht, nur der Kopfkreis wird gezeichnet“: Der Teilkreis wird immer gezeichnet.
][
*Kurz gefasst (aus der Karteikarte):*
- Den Kopfkreis als breite Volllinie, weil er die Körperkante ist.
- Den Teilkreis als schmale Strich-Punktlinie.
- Den Fußkreis als schmale Volllinie, nur bei Bedarf.
#bild("alt-d6-2", [Stirnrad: Ansicht mit Kopfkreis (breit), Teilkreis (Strichpunkt), Fußkreis (schmal, optional); Vollschnitt mit zwei ungeschnittenen Zähnen (eigene Skizze, vgl. Bild 13-4, S. 263) Quelle der Skizze: L-alt D6; eigene Darstellung.], height: 50mm)
#src[L-alt D6, Frage 5; nach B S. 259–268]
]

#aufgabe(titel: "Zähne im Achsschnitt", art: "verstehen", quelle: "12.3", herkunft: "eigen")[
#if not web [*Aufgabe 294* #linebreak()]
Wie werden die Zähne im Achsschnitt dargestellt, und wo endet die Schraffur?
][
*Antwort:* Ungeschnitten; die Schraffur endet an der Fußlinie (S. 261).
][
*Kurz gefasst (aus der Karteikarte):*
- Ungeschnitten, die Schraffur endet an der Fußlinie.
- Im Vollschnitt zeichnet man zwei gegenüberliegende Zähne, auch bei ungerader Zähnezahl.
#bild("b-stirnrad", [Bild 13-4: Stirnrad in Ansicht, Halbschnitt und Vollschnitt. B, S. 263 (PDF-S. 274).], height: 50mm)
#src[L-alt D6, Frage 6; nach B S. 259–268]
]

#aufgabe(titel: "Zähne im Vollschnitt bei z = 25", art: "verstehen", quelle: "12.3", herkunft: "eigen")[
#if not web [*Aufgabe 295* #linebreak()]
Wie viele Zähne zeichnet man im Vollschnitt eines Rads mit z = 25?
][
*Antwort:* Zwei gegenüberliegende Zähne, auch bei ungerader Zähnezahl (S. 261).

#src[L-alt D6, Frage 7; nach B S. 259–268]
]

#aufgabe(titel: "Schrägverzahnung andeuten", art: "verstehen", quelle: "12.3", herkunft: "eigen")[
#if not web [*Aufgabe 296* #linebreak()]
Wie kann man eine Schrägverzahnung in der Zeichnung andeuten? Ist das Pflicht?
][
*Antwort:* Durch drei schmale Volllinien in Form und Richtung der Zähne in einer achsparallelen Ansicht. Nicht Pflicht, aber die Steigung muss in den Fertigungsunterlagen stehen (S. 262).

#src[L-alt D6, Frage 8; nach B S. 259–268]
]

#aufgabe(titel: "Kopfkreis, Teilkreis und Schraffur", art: "verstehen", quelle: "12.3", herkunft: "eigen")[
#if not web [*Aufgabe 297* #linebreak()]
Erkläre Kopfkreis, Teilkreis und Schraffur in der Zahnradzeichnung.
][
*Antwort:* Der Teilkreis wird als schmale Strichpunktlinie gezeichnet. Der Fußkreis darf in Ansichten als schmale Volllinie ergänzt werden. In der Ansicht reicht das Rad bis zum Kopfkreis.

#src[L-alt D6, offene Überarbeitung Frage 19; B S. 259–268]
]

#aufgabe(titel: "Welches Rad vorne liegt", art: "verstehen", quelle: "12.4", herkunft: "variante", vorlage: "Buch Kap. 13, Aufg. 13.6")[
#if not web [*Aufgabe 298* #linebreak()]
Welches Rad liegt „vorne“ bei: Stirnradpaar, Kegelradpaar, Schneckengetriebe? (Buch 13.6)
][
*Antwort:* Stirnradpaar: Ritzel. Kegelradpaar: Ritzel vor Tellerrad. Schneckengetriebe: Schnecke (S. 262, 264, 265).

#src[L-alt D6, Frage 9; nach B S. 259–268]
]

#aufgabe(titel: "Teilkreis beim Kegelrad", art: "verstehen", quelle: "12.4", herkunft: "eigen")[
#if not web [*Aufgabe 299* #linebreak()]
Welchen Teilkreisdurchmesser zeichnet man beim Kegelrad, und warum?
][
*Antwort:* Den mittleren Teilkreisdurchmesser, weil die Kegelräder damit berechnet werden (S. 264).

#src[L-alt D6, Frage 10; nach B S. 259–268]
]

#aufgabe(titel: "Radpaar im Achsschnitt", art: "verstehen", quelle: "12.4", herkunft: "eigen")[
#if not web [*Aufgabe 300* #linebreak()]
Welches Rad wird bei einem Radpaar im Achsschnitt vorn dargestellt und wie wird die Verdeckung gezeigt?
][
*Antwort:* wird das Ritzel üblicherweise vorne liegend gezeichnet. wird die hintere Verzahnung teilweise verdeckt dargestellt.
][
*Kurz gefasst (aus der Karteikarte):*
- Beim Stirnradpaar das Ritzel, beim Kegelradpaar das Ritzel vor dem Tellerrad, beim Schneckengetriebe die Schnecke.
#src[L-alt D6, offene Überarbeitung Frage 20; B S. 259–268]
]

#aufgabe(titel: "Verzahnungsqualität 1 bis 12", art: "verstehen", quelle: "12.5", herkunft: "eigen")[
#if not web [*Aufgabe 301* #linebreak()]
Was bedeutet Verzahnungsqualität 1 bzw. 12, und welche Qualitäten sind üblich?
][
*Antwort:* 1 = höchste, kaum herstellbare Genauigkeit; 12 = gröbste. Üblich sind 5 bis 8 (S. 265).
][
*Kurz gefasst (aus der Karteikarte):*
- Sie reicht von 1 (höchste, kaum herstellbare Genauigkeit) bis 12 (gröbste).
- Üblich sind 5 bis 8.
#src[L-alt D6, Frage 11; nach B S. 259–268]
]

#aufgabe(titel: "Getriebe-Passsystem DIN 3967", art: "verstehen", quelle: "12.5", herkunft: "eigen")[
#if not web [*Aufgabe 302* #linebreak()]
Wozu dient das Getriebe-Passsystem nach DIN 3967?
][
*Antwort:* Es legt über Zahndickenabmaße das Flankenspiel des montierten Radpaars fest: nicht zu klein (Wärmedehnung), nicht zu groß (Stöße bei Lastwechsel) (S. 266).
][
*Kurz gefasst (aus der Karteikarte):*
- Es legt über die Zahndickenabmaße das Flankenspiel des montierten Radpaars fest.
- Zu wenig Spiel klemmt bei Wärmedehnung, zu viel Spiel führt zu Stößen bei Lastwechsel.
#src[L-alt D6, Frage 12; nach B S. 259–268]
]

#aufgabe(titel: "Qualitätsstufen einer Verzahnung", art: "verstehen", quelle: "12.5", herkunft: "eigen")[
#if not web [*Aufgabe 303* #linebreak()]
Was bedeuten die Qualitätsstufen einer Verzahnung nach dem Buch?
][
*Antwort:* wird in 12 Stufen eingeteilt. liegt bei den meisten Getrieben zwischen 5 und 8. gehört in die Verzahnungstabelle.

#src[L-alt D6, offene Überarbeitung Frage 21; B S. 259–268]
]

#aufgabe(titel: "Pflichtangaben am Stirnrad", art: "verstehen", quelle: "12.6", herkunft: "variante", vorlage: "Buch Kap. 13, Aufg. 13.7")[
#if not web [*Aufgabe 304* #linebreak()]
Nenne die sechs Angaben nach DIN 3966-1, die direkt an der Darstellung eines Stirnrads mit Bohrung stehen müssen, und gib an, worauf sich die Lauftoleranzen beziehen. (vgl. Buch 13.7)
][
*Modell / Annahmen:* Unverschobenes geradverzahntes Stirnrad, sofern nicht anders angegeben.

Kopfkreisdurchmesser, Fußkreisdurchmesser (oder Zahnhöhe), Zahnbreite, Bezugselement (hier die Bohrung, toleriert), Lagetoleranzen wie Rund- und Planlauf, Oberflächenangabe der Flanken am Teilkreis. Die Lauftoleranzen beziehen sich auf die Bohrung als Bezug (S. 267).

*Prüfung:* Alle Durchmesser in mm; Kopfkreis größer und Fußkreis kleiner als der Teilkreis.

#src[L-alt D6, Frage 17; nach B S. 259–268]
]

#aufgabe(titel: "Oberflächensymbol an der Zahnflanke", art: "verstehen", quelle: "12.6", herkunft: "eigen")[
#if not web [*Aufgabe 305* #linebreak()]
Wo wird das Oberflächensymbol für die Zahnflanken angetragen?
][
*Antwort:* Auf die Strichpunktlinie des Teilkreises (S. 267).

#src[L-alt D6, Frage 13; nach B S. 259–268]
]

#aufgabe(titel: "Verzahnungstabelle zusammenstellen", art: "verstehen", quelle: "12.6", herkunft: "eigen")[
#if not web [*Aufgabe 306* #linebreak()]
Stelle die Mindestinhalte der Verzahnungstabelle für ein Rad mit m = 2 mm, z = 30, Geradverzahnung, ohne Profilverschiebung zusammen. Welche Angaben fehlen dir noch?
][
*Modell / Annahmen:* Unverschobenes geradverzahntes Stirnrad, sofern nicht anders angegeben.

Außenverzahnung, m = 2 mm, z = 30, β = 0°, x = 0. Es fehlen noch: Bezugsprofil (z. B. DIN 867), Verzahnungsqualität mit Passsystem-Kennung, Achsabstand mit Abmaßen und Angaben zum Gegenrad (S. 267).

*Prüfung:* Alle Durchmesser in mm; Kopfkreis größer und Fußkreis kleiner als der Teilkreis.

#src[L-alt D6, Frage 18; nach B S. 259–268]
]


#kapitel("Kapitel 13 · Zeichnungen lesen und erstellen")

#aufgabe(titel: "Übertragungs- und Führungsgetriebe", art: "verstehen", quelle: "13.1", herkunft: "eigen")[
#if not web [*Aufgabe 307* #linebreak()]
Was ist der Unterschied zwischen Übertragungs- und Führungsgetrieben? Woran erkennst du in Bild 14-1 ein Übertragungsgetriebe?
][
*Antwort:* Übertragungsgetriebe leiten Leistung (Drehmoment, Drehzahl) weiter und wandeln sie ggf.; Führungsgetriebe führen Punkte eines Körpers auf Bahnen. Erkennbar an drei Wellenenden mit Passfedern (S. 269).
][
*Kurz gefasst (aus der Karteikarte):*
- Übertragungsgetriebe leiten Leistung weiter (Drehmoment und Drehzahl) und wandeln sie gegebenenfalls.
- Führungsgetriebe führen Punkte eines Körpers auf bestimmten Bahnen.
#src[L-alt E1, Frage 1; nach B S. 269–290]
]

#aufgabe(titel: "Wo der Antrieb liegen kann", art: "verstehen", quelle: "13.2", herkunft: "eigen")[
#if not web [*Aufgabe 308* #linebreak()]
Warum kann der Antrieb nicht an der horizontalen Welle liegen?
][
*Antwort:* Beide horizontalen Wellenenden gehören zu einer Welle; Antrieb an beiden ist unmöglich, an einem nur bedingt sinnvoll, weil das andere Ende einfach mitdreht (S. 269).

#src[L-alt E1, Frage 2; nach B S. 269–290]
]

#aufgabe(titel: "Kraftweg im Spiralkegelgetriebe", art: "verstehen", quelle: "13.2", herkunft: "eigen")[
#if not web [*Aufgabe 309* #linebreak()]
Verfolge Kraftweg und Lagerung im Spiralkegelgetriebe.
][
*Antwort:* Die Antriebswelle ist mit zwei Schrägkugellagern gelagert. Das Getriebe lenkt vor allem um 90° um. Die O-Ringe tragen die Positionsnummern 77 bis 80.

#src[L-alt E1, offene Überarbeitung Frage 21; B S. 269–290]
]

#aufgabe(titel: "Positionsnummern der Lagerpaare", art: "verstehen", quelle: "13.3", herkunft: "eigen")[
#if not web [*Aufgabe 310* #linebreak()]
Warum haben die beiden Schrägkugellager zwei Positionsnummern, die beiden Rillenkugellager aber nur eine?
][
*Antwort:* Schrägkugellager haben eine Einbaurichtung; 43 und 44 sind gleiche Lager, aber unterschiedlich eingebaut. Rillenkugellager haben keine Einbaurichtung (S. 272).
][
*Kurz gefasst (aus der Karteikarte):*
- Schrägkugellager haben eine Einbaurichtung und werden hier spiegelbildlich eingebaut.
- Für die Montage sind es also verschiedene Positionen.
- Rillenkugellager haben keine Einbaurichtung.
#src[L-alt E1, Frage 3; nach B S. 269–290]
]

#aufgabe(titel: "Lücken in Positionsnummern", art: "verstehen", quelle: "13.3", herkunft: "eigen")[
#if not web [*Aufgabe 311* #linebreak()]
Nenne zwei Gründe für Lücken in den Positionsnummern einer Stückliste.
][
*Antwort:* Historisch (Teile geändert und neu nummeriert) oder bewusst freigelassen für spätere Ergänzungen (S. 276–277).
][
*Kurz gefasst (aus der Karteikarte):*
- Entweder historisch, weil Teile geändert und neu nummeriert wurden, oder bewusst freigelassen für spätere Ergänzungen.
#src[L-alt E1, Frage 4; nach B S. 269–290]
]

#aufgabe(titel: "Einheiten in der Stückliste", art: "verstehen", quelle: "13.3", herkunft: "eigen")[
#if not web [*Aufgabe 312* #linebreak()]
Welche Einheiten außer „Stück“ kann eine Stückliste enthalten?
][
*Antwort:* Z. B. Liter oder kg für eine Ölfüllung; grundsätzlich SI-Einheiten nach DIN 1301-1 (S. 277).

#src[L-alt E1, Frage 5; nach B S. 269–290]
]

#aufgabe(titel: "Zwei Positionsnummern für gleiche Lager", art: "verstehen", quelle: "13.3", herkunft: "eigen")[
#if not web [*Aufgabe 313* #linebreak()]
In einer Gesamtzeichnung tragen zwei gleiche Schrägkugellager die Positionsnummern 5 und 6. Warum zwei Nummern? Und wie heißt das Teil, mit dem man die beiden spielfrei verspannt?
][
*Modell / Annahmen:* Worst-Case-Maßkette beziehungsweise Zeichnungsinterpretation nach den genannten Funktionsflächen.

Schrägkugellager haben eine Einbaurichtung; gleiche Lager in verschiedener Richtung bekommen eigene Positionsnummern (S. 272). Verspannt wird mit Nutmutter und Sicherungsblech (Kapitel 9, S. 276).

*Prüfung:* Maßketten im ungünstigsten Grenzfall prüfen; aus verkleinerten Buchbildern keine Funktionsmaße abgreifen.

#src[L-alt G7; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

#aufgabe(titel: "Was die Nutmutter verspannt", art: "verstehen", quelle: "13.4", herkunft: "eigen")[
#if not web [*Aufgabe 314* #linebreak()]
Welche Bauteile verspannt die Nutmutter 52?
][
*Antwort:* Sicherungsblech 53, Innenring des einen Schrägkugellagers, Distanzring 21, Innenring des anderen Schrägkugellagers gegen die Wellenschulter der Ritzelwelle 16 (S. 276).

#src[L-alt E1, Frage 9; nach B S. 269–290]
]

#aufgabe(titel: "Zwei M5-Gewinde am Lagerhalter", art: "verstehen", quelle: "13.5", herkunft: "eigen")[
#if not web [*Aufgabe 315* #linebreak()]
Wozu dienen die zwei M5-Gewindebohrungen am Lagerhalter, und warum sind es zwei?
][
*Antwort:* Abdrückgewinde für die Demontage; zwei, damit der Lagerhalter nicht verkantet (S. 279).
][
*Kurz gefasst (aus der Karteikarte):*
- *Sie helfen bei der Demontage:* Schrauben drücken das Teil aus seinem Sitz heraus.
- Mit zwei Gewinden wird gleichmäßig gedrückt, und das Teil verkantet nicht.

*Merksatz:* Zwei Abdrückschrauben drücken gleichmäßig statt schief.
#src[L-alt E1, Frage 6; nach B S. 269–290]
]

#aufgabe(titel: "Spielpassung Ø40 H6 am Lagerhalter", art: "verstehen", quelle: "13.5", herkunft: "eigen")[
#if not web [*Aufgabe 316* #linebreak()]
Warum ist am Lagerhalter Ø40 H6 eine Spielpassung zulässig?
][
*Antwort:* Die Welle dreht, der Lagerhalter steht: Der Außenring hat Punktlast und darf locker sitzen (S. 279).
][
*Kurz gefasst (aus der Karteikarte):*
- Die Welle dreht, der Lagerhalter steht.
- Der Außenring hat also Punktlast und darf locker sitzen.
#src[L-alt E1, Frage 7; nach B S. 269–290]
]

#aufgabe(titel: "j6 an Ø50 und Ø55", art: "verstehen", quelle: "13.5", herkunft: "eigen")[
#if not web [*Aufgabe 317* #linebreak()]
Warum sind Ø50 und Ø55 am Lagerhalter mit j6 toleriert?
][
*Antwort:* Übergangspassung zur Zentrierung von Lagerhalter und Flanschlager, von Hand montierbar; die Verdrehsicherung übernehmen die Schrauben (S. 279).

#src[L-alt E1, Frage 8; nach B S. 269–290]
]

#aufgabe(titel: "Grenzmaße von Ø40 H6", art: "rechnen", quelle: "13.5", herkunft: "variante", vorlage: "Altklausur WS 20/21, Aufg. 4",
  ergebnis: [40,000 bis 40,016 mm],
  tipp: [Bei H ist das untere Abmaß null; das obere ist die Grundtoleranz.],
)[
#if not web [*Aufgabe 318* #linebreak()]
*Gegeben und Annahmen*

Bohrung Ø40 H6; unteres Abmaß EI = 0; IT6 im Bereich über 30 bis 50 mm beträgt 16 µm.

*Gesucht*

#enum(numbering: "a)",
[Bestimme Kleinstmaß und Größtmaß.],
)
][
*Feld H:* EI = 0, die Bohrung beginnt also genau am Nennmaß.
][
*Oberes Abmaß:* ES = EI + IT6 = 0 + 16 = +16 µm.
][
*Grenzmaße:* Kleinstmaß 40,000 mm, Größtmaß 40,016 mm.
][
*Prüfen:* T = 0,016 mm. Bei H7 wären es 25 µm, IT6 ist also feiner.
#src[L-alt E1, Frage 15; nach B S. 269–290]
]

#aufgabe(titel: "Paarung Ø50 H7/j6", art: "rechnen", quelle: "13.5", herkunft: "variante", vorlage: "Altklausur WS 20/21, Aufg. 4",
  ergebnis: [H7: 50,000 bis 50,025 mm; j6: 49,995 bis 50,011 mm; größtes Spiel 30 µm, größtes Übermaß 11 µm],
  tipp: [Größtes Spiel: größte Bohrung, kleinste Welle. Größtes Übermaß: kleinste Bohrung, größte Welle.],
)[
#if not web [*Aufgabe 319* #linebreak()]
*Gegeben und Annahmen*

Nennmaß 50 mm, Paarung H7/j6; H7: ES/EI = +25/0 µm, j6: es/ei = +11/−5 µm.

*Gesucht*

#enum(numbering: "a)",
[Bestimme beide Grenzmaße von Bohrung und Welle sowie größtes Spiel und größtes Übermaß.],
)
][
*Bohrung H7:* ES = +25 µm, EI = 0, also 50,000 bis 50,025 mm.
][
*Welle j6:* es = +11 µm, ei = −5 µm, also 49,995 bis 50,011 mm.
][
*Größtes Spiel:* $"ES" - "ei" = 25 - (-5) = +30 thin "µm"$.
][
*Größtes Übermaß:* $"EI" - "es" = 0 - 11 = -11 thin "µm"$.
][
*Prüfen:* Ein Wert positiv, einer negativ: Übergangspassung. $P_T = 41 thin "µm" = 25 + 16$. Das Ergebnis stimmt mit dem Buchbeispiel in Kapitel 6, S. 157 überein.
][
*Kurz gefasst (aus dem Quiz):*
- Übergangspassung. $P_O = "0,025" - (-"0,005") = +"0,030"$, $P_U = 0 - "0,011" = -"0,011"$. Vorzeichen +/− heißt Übergang.
][
*Typische Verwechslungen:*
- „Spielpassung“: Dann müssten Höchst- und Mindestpassung positiv sein. Die Mindestpassung ist aber negativ.
- „Übermaßpassung“: Dafür müsste auch die Höchstpassung negativ sein.
- „Das lässt sich ohne Istmaße nicht sagen.“: Die Passungsart folgt aus den Grenzmaßen. Erst die Istpassung braucht Istmaße.
#src[L-alt E1, Frage 16; nach B S. 269–290]
]

#aufgabe(titel: "Unbemaßte Mitte eines Flansches", art: "rechnen", quelle: "13.5", herkunft: "eigen",
  ergebnis: [Nennmaß 8 mm, Kleinstmaß 7,5 mm, Größtmaß 8,5 mm],
  tipp: [Das Restmaß wird am kleinsten, wenn das Gesamtmaß klein und die Teilmaße groß sind.],
)[
#if not web [*Aufgabe 320* #linebreak()]
*Gegeben und Annahmen*

Ein Flansch hat die Maße 24 (gesamt), 6 und 10 von beiden Seiten, alle mit ISO 2768-m. Die zugehörigen Allgemeintoleranzen sind: 24 ±0,2 mm; 6 ±0,1 mm; 10 ±0,2 mm.

*Gesucht*

#enum(numbering: "a)",
[Berechne Nennmaß, Kleinst- und Größtmaß der unbemaßten Mitte.],
)
][
*Bild:* Das unbemaßte Mittelstück ist, was übrig bleibt. Alle Abweichungen der anderen Maße sammeln sich darin.
][
*Nennmaß:* $24 - 6 - 10 = 8 thin "mm"$.
][
*Toleranzen nach ISO 2768-m:* 24 ± 0,2 (Bereich 6–30), 6 ± 0,1 (Bereich 3–6), 10 ± 0,2.
][
*Kleinstmaß:* kleinstes Gesamtmaß, größte Teilmaße: $"23,8" - "6,1" - "10,2" = "7,5" thin "mm"$.
][
*Größtmaß und Prüfung:* $"24,2" - "5,9" - "9,8" = "8,5" thin "mm"$. Die Spanne von 1,0 mm ist die Summe aller Toleranzen (0,4 + 0,2 + 0,4). Das Restmaß ist also viel ungenauer als jedes einzelne Maß.
#src[L-alt E1, Frage 17; nach B S. 269–290]
]

#aufgabe(titel: "Restmaß nach ISO 2768-m", art: "rechnen", quelle: "13.5", herkunft: "eigen",
  ergebnis: [Nennmaß 13 mm, zwischen 12,3 und 13,7 mm],
  tipp: [Ungünstigster Fall: Gesamtmaß an der einen Grenze, beide Teilmaße an der anderen.],
)[
#if not web [*Aufgabe 321* #linebreak()]
*Gegeben und Annahmen*

Ein Bauteil hat das Gesamtmaß 40 und von einer Seite die Maße 12 und 15. Alle angegebenen Maße sind nach ISO 2768-m toleriert. Zugehörige Toleranzen: Gesamtmaß 40 ±0,3 mm, Teilmaße 12 ±0,2 mm und 15 ±0,2 mm.

*Gesucht*

#enum(numbering: "a)",
[Wie groß kann das unbemaßte Restmaß höchstens und mindestens werden? (Kapitel 6, S. 144–146; Kapitel 13, S. 281)],
)
][
*Nennmaß:* $40 - 12 - 15 = 13 thin "mm"$.
][
*Toleranzen:* 40 liegt im Bereich 30–120: ±0,3. 12 und 15 liegen im Bereich 6–30: je ±0,2.
][
*Kleinstes Restmaß:* $"39,7" - "12,2" - "15,2" = "12,3" thin "mm"$.
][
*Größtes Restmaß:* $"40,3" - "11,8" - "14,8" = "13,7" thin "mm"$.
][
*Prüfen:* Die Spanne 1,4 mm ist $"0,6" + "0,4" + "0,4"$. Ist das Restmaß funktionswichtig, muss man es selbst bemaßen und ein anderes Maß weglassen.
#src[L-alt S5; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

#aufgabe(titel: "Unbemaßte Mitte bei Maßen 8 und 12", art: "rechnen", quelle: "13.5", herkunft: "eigen",
  ergebnis: [Nennmaß 10 mm, zwischen 9,4 und 10,6 mm],
  tipp: [Alle drei Maße liegen im Bereich 6 bis 30 mm.],
)[
#if not web [*Aufgabe 322* #linebreak()]
*Gegeben und Annahmen*

Flansch: Gesamtmaß 30 mm, von beiden Seiten 8 mm und 12 mm. Für alle drei Maße gilt hier nach ISO 2768-m jeweils ±0,2 mm.

*Gesucht*

#enum(numbering: "a)",
[Berechne Kleinst- und Größtmaß der unbemaßten Mitte.],
)
][
*Nennmaß:* $30 - 8 - 12 = 10 thin "mm"$.
][
*Toleranzen:* 30, 8 und 12 liegen alle im Bereich über 6 bis 30: je ±0,2 mm.
][
*Kleinstmaß:* $"29,8" - "8,2" - "12,2" = "9,4" thin "mm"$.
][
*Größtmaß:* $"30,2" - "7,8" - "11,8" = "10,6" thin "mm"$.
][
*Prüfen:* Spanne 1,2 mm = 3 · 0,4 mm. Drei Maße ergeben zusammen eine dreimal so große Unsicherheit.
#src[L-alt G6; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

#aufgabe(titel: "Passfeder nur am Tellerrad", art: "verstehen", quelle: "13.6", herkunft: "eigen")[
#if not web [*Aufgabe 323* #linebreak()]
Warum sitzt nur das Tellerrad mit Passfeder auf der Abtriebswelle, der Lagerring aber nicht?
][
*Antwort:* Das Tellerrad benötigt eine sichere Drehmomentübertragung über die Passfeder. H7/k6 allein ist als Übergangspassung kein garantierter Reibschluss. Die Aussage auf B S. 282 wird deshalb nicht als allgemeiner Drehmomentnachweis verwendet (S. 282).

#src[L-alt E1, Frage 10; nach B S. 269–290]
]

#aufgabe(titel: "Passfeder trotz H7/k6-Sitz", art: "verstehen", quelle: "13.6", herkunft: "eigen")[
#if not web [*Aufgabe 324* #linebreak()]
Warum braucht ein Zahnrad mit H7/k6-Sitz trotzdem eine Passfeder?
][
*Antwort:*
- H7/k6 ist eine Übergangspassung und garantiert keinen Presssitz.
- Das Drehmoment muss deshalb formschlüssig über die Passfeder übertragen werden.

*Merksatz:* Übergangspassung garantiert keinen Presssitz.
]

#aufgabe(titel: "Zwei Ansichten beim Flanschlager", art: "verstehen", quelle: "13.7", herkunft: "eigen")[
#if not web [*Aufgabe 325* #linebreak()]
Warum genügen beim Flanschlager zwei Ansichten, und warum ist eine Untersicht ungünstig?
][
*Antwort:* Vollschnitt zeigt alle Innenformen, Draufsicht die Bohrungen; aufgeklappte Schnittebenen bringen Senk- und Gewindebohrung in den Schnitt. In der Untersicht wäre der Senkdurchmesser nur verdeckt darstellbar (S. 284).

#src[L-alt E1, Frage 11; nach B S. 269–290]
]

#aufgabe(titel: "Rauheiten am Flanschlager verteilen", art: "verstehen", quelle: "13.7", herkunft: "eigen")[
#if not web [*Aufgabe 326* #linebreak()]
Nach welchem Prinzip werden die Rauheiten Rz 63, Rz 16 und Rz 10 am Flanschlager verteilt?
][
*Antwort:* Nach Funktion: funktionslos (aber sichtbar) Rz 63, Dichtfläche und Schraubenkopfauflage Rz 16, Lager-, RWDR-Sitz, Zentrierung und Außenmaß Rz 10 (S. 285–286).
][
*Kurz gefasst (aus der Karteikarte):*
- Nach der Funktion.
- Funktionslose, aber sichtbare Flächen bekommen eine grobe Rauheit.
- Dicht- und Auflageflächen bekommen eine mittlere.
- Lagersitze, Dichtringsitze und Zentrierungen bekommen die feinste.
#src[L-alt E1, Frage 12; nach B S. 269–290]
]

#aufgabe(titel: "Bezug für Rund- und Planlauf", art: "verstehen", quelle: "13.7", herkunft: "eigen")[
#if not web [*Aufgabe 327* #linebreak()]
Welcher Bezug wird für die Lauftoleranzen am Flanschlager gewählt, und warum Rund- und Planlauf?
][
*Antwort:* Die Sitzfläche des Wälzlagers. Gekrümmte Flächen erhalten Rundlauf, plane Flächen Planlauf (S. 288).
][
*Kurz gefasst (aus der Karteikarte):*
- Die Sitzfläche des Wälzlagers, weil sie die Drehachse festlegt.
- Gekrümmte Flächen bekommen Rundlauf, plane Flächen Planlauf.
#bild("b-flanschlager", [Bild 15-7: Vollständige Einzelteilzeichnung des Flanschlagers. B, S. 290 (PDF-S. 301).], height: 50mm)
#src[L-alt E1, Frage 13; nach B S. 269–290]
]

#aufgabe(titel: "Mindestinhalt des Schriftfelds", art: "verstehen", quelle: "13.7", herkunft: "eigen")[
#if not web [*Aufgabe 328* #linebreak()]
Was muss mindestens ins Schriftfeld einer Einzelteilzeichnung?
][
*Antwort:* Benennung, Maßstab, Zeichnungsnummer, Werkstoff, Bearbeiter/Datum, Prüfer/Freigabe, Eigentümer, Blattzahl (S. 289).

#src[L-alt E1, Frage 14; nach B S. 269–290]
]

#aufgabe(titel: "Ø24 H8 und allgemeine Angaben am Flanschlager", art: "verstehen", quelle: "13.7", herkunft: "eigen")[
#if not web [*Aufgabe 329* #linebreak()]
Welche Funktion hat Ø24 H8 im Flanschlager, und welche allgemeinen Angaben zeigt die Zeichnung?
][
*Antwort:* Ø24 H8 ist der Sitz des Radial-Wellendichtrings. Die Allgemeintoleranz lautet kurz ISO 2768-mK.

#src[L-alt E1, offene Überarbeitung Frage 22; B S. 269–290]
]

#aufgabe(titel: "Hilfsmaße in runden Klammern", art: "verstehen", quelle: "13.7", herkunft: "eigen")[
#if not web [*Aufgabe 330* #linebreak()]
Warum verwendet man Hilfsmaße in runden Klammern?
][
*Antwort:* ist ein Hilfsmaß und nicht maßgeblich. vermeidet eine Doppelbemaßung. wird nicht geprüft (abgeleitet).

#src[L-alt E1, offene Überarbeitung Frage 23; B S. 269–290]
]

#aufgabe(titel: "Einzelteilzeichnung des Lagerdeckels", art: "rechnen", quelle: "13.7", herkunft: "original", vorlage: "Altklausur WS 20/21, Aufg. 5", minuten: 23, platz: 22)[
#if not web [*Aufgabe 331* #linebreak()]
Erstellen Sie eine Zeichnung des Lagerdeckels Nr. 2 unter Berücksichtigung folgender Punkte (25 Punkte):
- Erstellen aller erforderlichen Ansichten (Lochkreis Befestigungsschrauben 4x)
- Vollständige Bemaßung
- Allgemeintoleranz ISO 2768 mk
- Angabe einer Form- und einer Lagetoleranz
- Eine allgemeine Oberflächeneintragung und eine abweichende in der Zeichnung
- Angabe des Kantenzustands
- Ausfüllen des Schriftfeldes
#bild("ak-lagerdeckel", [Originalausschnitt AK, PDF-S. 9: Lagerung mit Gehäuse 1, Lagerdeckel 2, Welle 3, Schrauben 7 u. a.; mit vorhandenen handschriftlichen Einträgen.], height: 120mm)
][
*Teil herauslösen:* Verfolge Pos. 2 in der Gesamtzeichnung: ein rotationssymmetrischer Deckel, der mit einem Bund in die Gehäusebohrung greift (Zentrierung), mit der Planfläche am Gehäuse anliegt und den Lageraußenring axial hält; vier Durchgangsbohrungen für die Schrauben Pos. 7 auf einem Lochkreis.
][
*Ansichten wählen:* Vorderansicht als Vollschnitt durch die Achse (zeigt Wanddicken, Bund und Innenkontur), dazu eine Seitenansicht in Achsrichtung für die Lage der vier Bohrungen auf dem Lochkreis. Mehr Ansichten braucht ein Drehteil nicht. Drehteil liegend, Achse waagrecht.
][
*Bemaßen:* Durchmesser mit Ø (Außen-Ø, Bund-Ø, Innen-Ø, Lochkreis-Ø, 4× Bohrungs-Ø), Längen fertigungsgerecht von einer Bezugsfläche (Anlagefläche) aus. Den Bund-Ø, der in die Gehäusebohrung passt, mit einer ISO-Toleranz versehen (z. B. f7 oder h7, damit er sich montieren lässt). Lochkreis: „4× Ø…“ und die Lage über die Mittellinien.
][
*Toleranzen:* Am Schriftfeld „ISO 2768-mK“ für alle nicht einzeln tolerierten Maße. Formtoleranz z. B. Ebenheit der Anlagefläche (kein Bezug nötig). Lagetoleranz z. B. Rechtwinkligkeit oder Planlauf der Anlagefläche zur Achse des Zentrierbunds (Bezug A am Bund-Ø). Toleranzwerte frei, aber sinnvoll wählen (z. B. 0,05 mm), denn die Aufgabe gibt keine vor.
][
*Oberflächen und Kanten:* Allgemeine Angabe neben dem Schriftfeld, z. B. Ra 6,3 mit dem Symbol in Klammern für die Ausnahmen; abweichend feiner am Zentrierbund und an der Anlagefläche, z. B. Ra 1,6. Kantenzustand nach ISO 13715 mit dem Kantensymbol, z. B. allgemein −0,3 (Außenkanten gratfrei gebrochen).
][
*Schriftfeld und Prüfung:* Benennung „Lagerdeckel“, Sachnummer, Werkstoff, Maßstab, Ersteller und Datum, Projektionsmethode 1. Prüfe am Ende: jedes Maß genau einmal, Maße eindeutig vom Bezug, jede geforderte Angabe vorhanden. Der Ausschnitt enthält keine Zahlenmaße; Maße nach der Zeichnung abschätzen und das auch so kennzeichnen.

#src[AK 5, PDF-S. 9–10; eigene Lösung mit B Buchkapitel 4–7 und 15]
]

#aufgabe(titel: "Lagerdeckel mit vier Bohrungen bemaßen (Variante)", art: "rechnen", quelle: "13.7", herkunft: "variante", vorlage: "Altklausur WS 20/21, Aufg. 5", minuten: 20, platz: 20,
  ergebnis: [b) Bohrungsmitten bei $(plus.minus "32,5"; plus.minus "32,5")$ mm; c) Ø110 ±0,3; 10 ±0,2; 4 ±0,1; 6 ±0,1; Ø92 ±0,3 mm; d) Ø72 f7: 71,940 bis 71,970 mm],
  tipp: [Lochkreisradius mal cos 45° ergibt beide Koordinaten.],
)[
#if not web [*Aufgabe 332* #linebreak()]
*Gegeben und Annahmen*

Lagerdeckel (Drehteil, S235JR) wie Pos. 2 der Altklausur, jetzt mit Maßen: Flansch Ø110 × 10 mm; Zentrierbund Ø72 f7, 4 mm lang (passt in die Gehäusebohrung Ø72 H7); innen eine Eindrehung Ø62, 6 mm tief, für den Lageraußenring. Vier Durchgangsbohrungen Ø9 auf Lochkreis Ø92, unter 45° zu den Mittellinien. Am Schriftfeld steht „ISO 2768-mK“. Auszug ISO 2768-m: über 3 bis 6 mm: ±0,1; über 6 bis 30: ±0,2; über 30 bis 120: ±0,3 mm. f7 im Bereich über 50 bis 80 mm: es = −30 µm, ei = −60 µm.

*Gesucht*

#enum(numbering: "a)",
[Welche Ansichten brauchst Du und warum?],
[Koordinaten der vier Bohrungsmitten (Ursprung in der Achse).],
[Grenzabweichungen für die Maße 110, 10, 4, 6 und Ø92 nach ISO 2768-m.],
[Grenzmaße des Zentrierbunds Ø72 f7 und warum f7 statt einer Übermaßtoleranz.],
[Schlage je eine Form- und eine Lagetoleranz sowie die Oberflächenangaben vor.],
)
][
*a) Ansichten:* Vorderansicht als Vollschnitt durch die Achse (Bund, Eindrehung, Flanschdicke werden sichtbar) und eine Seitenansicht für das Lochbild. Drehteil mit waagrechter Achse.
][
*b) Bohrungsmitten:* Radius $46$ mm, unter 45°: $46 dot cos 45° approx "32,5"$ mm. Also $(plus.minus "32,5"; plus.minus "32,5")$ mm. In der Zeichnung trotzdem nur „Ø92“ und „4× Ø9“ mit dem 45°-Winkel eintragen, die Koordinaten helfen beim Prüfen und Programmieren.
][
*c) Allgemeintoleranzen:* 110 → ±0,3 mm; 10 → ±0,2 mm; 4 → ±0,1 mm; 6 → ±0,1 mm (6 gehört noch zum Bereich über 3 bis 6); Ø92 → ±0,3 mm. Für genaue Lage der Bohrungen wäre eine Positionstoleranz besser als die Allgemeintoleranz.
][
*d) Zentrierbund:* $72 - "0,030" = "71,970"$ mm bis $72 - "0,060" = "71,940"$ mm. Mit H7 der Bohrung ergibt das eine Spielpassung (30 bis 90 µm): Der Deckel lässt sich von Hand einsetzen und zentriert trotzdem.
][
*e) Vorschlag:* Form: Ebenheit 0,05 mm der Anlagefläche. Lage: Planlauf (oder Rechtwinkligkeit) 0,05 mm der Anlagefläche zur Achse des Bunds (Bezug A am Ø72). Oberflächen: allgemein Ra 6,3 (mit Klammersymbol), abweichend Ra 1,6 an Bund und Anlagefläche. Kantenzustand −0,3 nach ISO 13715. Diese Werte sind Annahmen, keine Normwerte.
#src[Variante zu AK 5; Allgemeintoleranzen und ISO-Abmaße nach Lernskript 6.3/6.4 (B Tab. 7-3, 7-8)]
]

#aufgabe(titel: "Lagerdeckel mit sechs Bohrungen bemaßen (Variante)", art: "rechnen", quelle: "13.7", herkunft: "variante", vorlage: "Altklausur WS 20/21, Aufg. 5", minuten: 18, platz: 18,
  ergebnis: [b) (0; 65), (±56,3; ±32,5), (0; −65) mm; c) 65 mm Mittenabstand, 54 mm Steg; d) 4,5 mm Restwand; e) Ø150 ±0,5, Ø130 ±0,5, 12 ±0,2 mm],
  tipp: [Sechs Bohrungen teilen den Kreis in 60°-Schritte. Der Abstand zweier Nachbarn ist die Sehne $s = D dot sin(30°)$.],
)[
#if not web [*Aufgabe 333* #linebreak()]
*Gegeben und Annahmen*

Ein größerer Lagerdeckel: Flansch Ø150 × 12 mm, sechs Durchgangsbohrungen Ø11 gleichmäßig auf Lochkreis Ø130, die erste Bohrung auf der senkrechten Mittellinie oben. „ISO 2768-mK“ am Schriftfeld; Auszug ISO 2768-m: über 6 bis 30 mm ±0,2; über 120 bis 400 mm ±0,5 mm.

*Gesucht*

#enum(numbering: "a)",
[Wie gibst Du das Lochbild vereinfacht in der Zeichnung an?],
[Koordinaten aller sechs Bohrungsmitten.],
[Mittenabstand benachbarter Bohrungen und Stegbreite zwischen ihnen.],
[Restwanddicke zwischen Bohrung und Flanschaußenrand.],
[Allgemeintoleranzen für Ø150, Ø130 und 12.],
)
][
*a) Lochbild:* In der Seitenansicht Lochkreis Ø130 als schmale Strich-Punktlinie, eine Bohrung mit „6× Ø11“ bemaßen, die Teilung mit „6× 60° (= 360°)“ oder einfach „gleichmäßig verteilt“; die Lage der ersten Bohrung liegt auf der Mittellinie und braucht keinen Winkel.
][
*b) Koordinaten:* Radius 65 mm, Winkel 90°, 150°, 210°, 270°, 330°, 30°. $65 dot cos 30° approx "56,3"$ und $65 dot sin 30° = "32,5"$. Also (0; 65), (−56,3; 32,5), (−56,3; −32,5), (0; −65), (56,3; −32,5), (56,3; 32,5) mm.
][
*c) Abstand:* Bei sechs Bohrungen bilden die Mitten ein regelmäßiges Sechseck, die Seite ist gleich dem Radius: $130 dot sin 30° = 65$ mm. Steg zwischen den Bohrungsrändern: $65 - 11 = 54$ mm.
][
*d) Restwand:* $(150 - 130)\/2 - 11\/2 = 10 - "5,5" = "4,5"$ mm. Das ist dünn, aber noch fertigbar; bei Schraubenköpfen mit Scheibe prüfen, ob die Auflage über den Rand hinausragt.
][
*e) Allgemeintoleranzen:* Ø150 und Ø130 liegen über 120 bis 400 mm: ±0,5 mm; 12 liegt über 6 bis 30: ±0,2 mm. Prüfen: ±0,5 am Lochkreis ist grob, darum toleriert man die Bohrungslage besser mit einer Positionstoleranz.
#src[Variante zu AK 5; Teilungsangabe nach Lernskript 4.6, Allgemeintoleranzen nach 6.4]
]

#aufgabe(titel: "Toleranz von Ø52 −0,5", art: "rechnen", quelle: "13.7", herkunft: "eigen",
  ergebnis: [Toleranz 0,5 mm (51,5 bis 52,0 mm); nach ISO 2768-m wären es ±0,3, also 0,6 mm; ein Plusabmaß bringt nichts],
  tipp: [Überlege, aus welcher Richtung die Werkstatt an ein Außenmaß herankommt.],
)[
#if not web [*Aufgabe 334* #linebreak()]
*Gegeben und Annahmen*

Am Flanschlager steht Ø52 −0,5. Vergleichswert ISO 2768-m für 52 mm: ±0,3 mm.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist die Toleranz, und wie groß wäre sie nach ISO 2768-m?],
[Warum ist kein Plusabmaß nötig?],
)
][
*Angabe lesen:* Oberes Abmaß 0, unteres −0,5 mm. Das Maß liegt also zwischen 51,5 und 52,0 mm, die Toleranz ist 0,5 mm.
][
*Vergleich mit ISO 2768-m:* Ø52 liegt im Bereich 30–120, also ±0,3 mm. Das Toleranzfeld wäre 0,6 mm breit, aber symmetrisch um 52.
][
*Warum kein Plusabmaß:* An einem Außenmaß nimmt man Material weg, bis das Maß erreicht ist. Ein Maß über 52 mm hat keinen Nutzen und kostet nur Material; die einseitige Angabe sagt der Werkstatt: höchstens 52, gern etwas weniger (S. 288).
#src[L-alt E1, Frage 18; nach B S. 269–290]
]
