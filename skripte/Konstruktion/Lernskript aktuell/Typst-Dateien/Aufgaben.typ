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


#kapitel("Kapitel 1 · Grundlagen und Zeichnungserstellung")

// 0-1
#aufgabe(titel: "Wozu eine Technische Zeichnung dient", art: "verstehen", quelle: "1.1")[
#if not web [*Aufgabe 1* #linebreak()]
Wozu dient eine Technische Zeichnung? Nenne drei Abteilungen, die mit ihr arbeiten.
][
Sie ist der eindeutige Informationsträger zwischen allen, die an einem Produkt arbeiten, auch extern (S. 1). Z. B. Fertigung, Qualitätssicherung, Einkauf (auch Montage, Arbeitsvorbereitung, Zulieferer).

#src[L-alt A1, Frage 1; nach B S. 1–16]
]

// 0-2
#aufgabe(titel: "Parallelprojektion statt Perspektive", art: "verstehen", quelle: "1.1")[
#if not web [*Aufgabe 2* #linebreak()]
Warum verwendet man für Technische Zeichnungen die senkrechte Parallelprojektion und keine Perspektive?
][
Nur bei ihr erscheinen Flächen parallel zur Bildebene in wahrer Größe, also maßstäblich. Perspektive verkürzt ferne Kanten, man könnte keine Maße abgreifen (S. 2).

#src[L-alt A1, Frage 2; nach B S. 1–16]
]

// 0-3
#aufgabe(titel: "DIN, EN, ISO und die Frage nach dem Gesetz", art: "verstehen", quelle: "1.2")[
#if not web [*Aufgabe 3* #linebreak()]
Was bedeuten DIN, DIN EN, DIN ISO und DIN EN ISO? Sind Normen Gesetze?
][
DIN = deutsche Norm, DIN EN = europäische Norm (CEN) als DIN übernommen, DIN ISO = internationale Norm (ISO, Genf) als DIN übernommen, DIN EN ISO = international, europäisch und deutsch zugleich. Normen sind Empfehlungen mit technisch-normativer Wirkung, aus sich heraus nicht rechtsverbindlich; wer sie anwendet, verhält sich ordnungsgemäß (S. 3).

#src[L-alt A1, Frage 3; nach B S. 1–16]
]

// 0-4
#aufgabe(titel: "Seitenverhältnis der A-Formate", art: "verstehen", quelle: "1.3")[
#if not web [*Aufgabe 4* #linebreak()]
Welches Seitenverhältnis haben die A-Formate, und warum gerade dieses?
][
1 : √2. Nur bei diesem Verhältnis hat die Hälfte eines Blattes wieder dieselbe Form. So kann man Zeichnungen ohne Verzerrung vergrößern oder verkleinern (S. 6).

#src[L-alt A1, Frage 4; nach B S. 1–16]
]

// 0-5
#aufgabe(titel: "Schriftfeld, Blattlage und Feldeinteilung", art: "verstehen", quelle: "1.3")[
#if not web [*Aufgabe 5* #linebreak()]
Wo steht das Schriftfeld, welche Formate sind hoch, welche quer, und wozu dient die Feldeinteilung am Blattrand? (#strong[B Übung 2.1])
][
Schriftfeld immer unten rechts. A4 nur hoch, alle anderen Formate nur quer. Die Feldeinteilung (Spalten Buchstaben, Zeilen Zahlen) erlaubt es, eine Stelle anzusprechen, z. B. „Feld B6“ (S. 6–7).

#src[L-alt A1, Frage 5; nach B S. 1–16]
]

// 0-6
#aufgabe(titel: "Vier Stufen der Erzeugnisgliederung", art: "verstehen", quelle: "1.4")[
#if not web [*Aufgabe 6* #linebreak()]
Nenne die vier Stufen der Erzeugnisgliederung.
][
Anlage/System → Gerät/Maschine/Apparat → Baugruppe → Einzelteile (S. 8, Bild 2-3).

#src[L-alt A1, Frage 6; nach B S. 1–16]
]

// 0-7
#aufgabe(titel: "Teil und Einzelteil", art: "verstehen", quelle: "1.4")[
#if not web [*Aufgabe 7* #linebreak()]
Was ist der Unterschied zwischen einem Teil und einem Einzelteil? Nenne ein Beispiel.
][
Teil: wird nicht weiter zerlegt, z. B. gekauftes Kugellager. Einzelteil: nicht zerstörungsfrei zerlegbar, z. B. Innenring des Lagers (S. 9).

#src[L-alt A1, Frage 7; nach B S. 1–16]
]

// 0-8
#aufgabe(titel: "Einzelteilzeichnung und Gesamtzeichnung", art: "verstehen", quelle: "1.4")[
#if not web [*Aufgabe 8* #linebreak()]
Was muss in einer Einzelteilzeichnung stehen, was in einer Gesamtzeichnung?  (#strong[B Übung 2.6/2.7])
][
Einzelteil: vollständige Bemaßung, Toleranzen, Oberflächen, Werkstoff, Maßstab, Schriftfeld. Gesamtzeichnung: zusammengebauter Zustand, Positionsnummern, Haupt- und Anschlussmaße, Stückliste (S. 9–11).

#src[L-alt A1, Frage 8; nach B S. 1–16]
]

// 0-9
#aufgabe(titel: "Bemaßung in der Gesamtzeichnung", art: "verstehen", quelle: "1.4")[
#if not web [*Aufgabe 9* #linebreak()]
Was wird in einer Gesamtzeichnung bemaßt, und wozu? (#strong[B Übung 2.12])
][
Nur Hauptmaße (welchen Platz das Erzeugnis insgesamt braucht) und Anschlussmaße (wie Anschluss- und Befestigungsteile bemessen sind). Sie dienen dem Einbau und der weiteren Montage, nicht der Fertigung der Einzelteile (S. 10–11).

#src[L-alt A1, Frage 9; nach B S. 1–16]
]

// 0-10
#aufgabe(titel: "Regeln für Positionsnummern", art: "verstehen", quelle: "1.5")[
#if not web [*Aufgabe 10* #linebreak()]
Nenne vier Regeln für Positionsnummern.
][
Mit 1 beginnend in Montagereihenfolge oder im Uhrzeigersinn; dünne Bezugslinie mit Punkt im Teil oder Pfeil an der Kontur, nicht parallel zu anderen Linien; doppelte Maßzahlhöhe, mind. 5 mm; identische Teile nur eine Nummer, nur einmal eingetragen (S. 11–12).

#src[L-alt A1, Frage 10; nach B S. 1–16]
]

// 0-11
#aufgabe(titel: "Warum die Stückliste so wichtig ist", art: "verstehen", quelle: "1.5")[
#if not web [*Aufgabe 11* #linebreak()]
Warum gilt die Stückliste als eines der wichtigsten Konstruktionsergebnisse?
][
Sie ist Grundlage für die Fertigungsvorbereitung und für Kalkulation, Bestellwesen und Lager: Ohne sie weiß niemand, welche Teile in welcher Menge bestellt oder gefertigt werden (S. 12).

#src[L-alt A1, Frage 11; nach B S. 1–16]
]

// 0-12
#aufgabe(titel: "Skizzenarten und Mittellinien", art: "verstehen", quelle: "1.6")[
#if not web [*Aufgabe 12* #linebreak()]
Welche zwei Arten von Skizzen gibt es? Warum beginnt man mit den Mittellinien? (#strong[B Übung 2.17/2.19])
][
Skizze zum Konstruieren (Ideen, Funktion) und Skizze als Vorlage für Zeichnung/Fertigung. Mittellinien legen Lage und Symmetrie fest; alle weiteren Linien hängen daran (S. 13–14).

#src[L-alt A1, Frage 12; nach B S. 1–16]
]

// 0-13
#aufgabe(titel: "Seitenlängen von A0, A1 und A4", art: "rechnen", quelle: "1.3",
  ergebnis: [A0 = 841 × 1189 mm, A1 = 594 × 841 mm, A4 = 210 × 297 mm],
  tipp: [Zwei Gleichungen: Fläche $x y = 1 thin "m"^2$ und Verhältnis $y = sqrt(2) x$. Jede nächste Stufe halbiert die lange Seite.],
)[
#if not web [*Aufgabe 13* #linebreak()]
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

// 0-14
#aufgabe(titel: "A4-Blätter auf A1 und Fläche von A3", art: "rechnen", quelle: "1.3",
  ergebnis: [8 A4-Blätter; A3 hat 0,125 m²],
  tipp: [Zähle die Halbierungsschritte zwischen den Formaten. Jeder Schritt halbiert die Fläche.],
)[
#if not web [*Aufgabe 14* #linebreak()]
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

// 0-15
#aufgabe(titel: "Wahre Größe in orthogonalen Ansichten", art: "verstehen", quelle: "1.1")[
#if not web [*Aufgabe 15* #linebreak()]
Erkläre, welche Flächen bei orthogonalen Ansichten in wahrer Größe erscheinen und warum eine einzige Ansicht oft nicht genügt.
][
Bei orthogonaler Projektion erscheinen Flächen parallel zur Bildebene in wahrer Größe; geneigte Flächen sind verkürzt. Weitere Ansichten ergänzen die fehlenden Raumrichtungen.

#src[L-alt A1, offene Überarbeitung Frage 15; B S. 1–16]
]

// 0-16
#aufgabe(titel: "Angaben in Gesamt- und Einzelteilzeichnung", art: "verstehen", quelle: "1.4")[
#if not web [*Aufgabe 16* #linebreak()]
Welche Angaben braucht eine Gesamtzeichnung, und welche gehören in die Einzelteilzeichnung?
][
Positionsnummern. Haupt- und Anschlussmaße. eine Stückliste oder einen Verweis darauf.

#src[L-alt A1, offene Überarbeitung Frage 16; B S. 1–16]
]

// 0-17
#aufgabe(titel: "Gleiche Schrauben in Zeichnung und Stückliste", art: "verstehen", quelle: "1.5")[
#if not web [*Aufgabe 17* #linebreak()]
Wie werden fünf gleiche Schrauben einer Baugruppe in Zeichnung und Stückliste identifiziert?
][
bekommen eine Positionsnummer, Menge 5 in der Stückliste.

#src[L-alt A1, offene Überarbeitung Frage 17; B S. 1–16]
]

// 0-18
#aufgabe(titel: "Fläche und Seitenlängen von A0 herleiten", art: "rechnen", quelle: "1.3",
  ergebnis: [1 m², ungefähr 841 × 1189 mm],
  tipp: [A0 ist über die Fläche definiert. Das Seitenverhältnis $1 : sqrt(2)$ legt dann beide Seiten fest.],
)[
#if not web [*Aufgabe 18* #linebreak()]
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

// 0-19
#aufgabe(titel: "Vier Zeichnungstypen und ihre Empfänger", art: "verstehen", quelle: "1.4")[
#if not web [*Aufgabe 19* #linebreak()]
Nenne vier Zeichnungstypen und erkläre für jeden, welcher Empfänger welche Information daraus gewinnt.
][
Einzelteilzeichnung: Fertigung erhält Form, Maße und Anforderungen eines Teils. Zusammenbauzeichnung: Montage erkennt Zuordnung und Zusammenwirken. Fertigungszeichnung: enthält alle für den betreffenden Fertigungsschritt nötigen Angaben. Sammelzeichnung: fasst mehrere zusammengehörige Einzelteile auf einem Blatt zusammen.

#src[AK 1a, PDF-S. 2; B S. 7–12]
]


#kapitel("Kapitel 2 · CAD und digitale Produktmodelle")

// 1-1
#aufgabe(titel: "CAD und sein Hauptvorteil", art: "verstehen", quelle: "2.6")[
#if not web [*Aufgabe 20* #linebreak()]
Wofür steht CAD, und worin liegt der Hauptvorteil? (#strong[B Übung 3.1])
][
Computer Aided Design = rechnerunterstütztes Konstruieren. Hauptvorteil: Durchgängigkeit der Daten von Entwicklung über Konstruktion bis Fertigung (S. 32).

#src[L-alt A2, Frage 1; nach B S. 17–38]
]

// 1-2
#aufgabe(titel: "Arten von CAD-Systemen", art: "verstehen", quelle: "2.2")[
#if not web [*Aufgabe 21* #linebreak()]
Welche grundsätzlichen Arten von CAD-Systemen gibt es, und wo werden linienbasierte Systeme noch eingesetzt? (#strong[B Übung 3.2])
][
Linien-, flächen- und volumenbasierte Systeme. Linienbasierte vor allem in der Elektrotechnik (Schaltpläne) (S. 25).

#src[L-alt A2, Frage 2; nach B S. 17–38]
]

// 1-3
#aufgabe(titel: "B-Rep und CSG", art: "verstehen", quelle: "2.3")[
#if not web [*Aufgabe 22* #linebreak()]
Erkläre den Unterschied zwischen B-Rep und CSG.
][
B-Rep: Volumen über Begrenzungsflächen plus Materialvektoren, Geometrie liegt explizit vor. CSG: Volumen als Folge Boolescher Operationen auf Grundkörpern (Baum), Flächen werden erst beim Evaluieren berechnet (S. 26–27).

#src[L-alt A2, Frage 3; nach B S. 17–38]
]

// 1-4
#aufgabe(titel: "Skizzenmodul und seine Bedingung", art: "verstehen", quelle: "2.4")[
#if not web [*Aufgabe 23* #linebreak()]
Wozu dient das Skizzenmodul, und welche Bedingung muss die Skizze erfüllen? (#strong[B Übung 3.3])
][
Es erzeugt auf einer Arbeitsebene den Umriss der Grundgeometrie, der dann extrudiert oder rotiert wird. Die Kontur muss ein geschlossener Linienzug sein (S. 27–28).

#src[L-alt A2, Frage 4; nach B S. 17–38]
]

// 1-5
#aufgabe(titel: "Warum trotz CAD noch gedruckt wird", art: "verstehen", quelle: "2.6")[
#if not web [*Aufgabe 24* #linebreak()]
Warum erstellt man trotz CAD und elektronischem Datenaustausch noch eine Technische Zeichnung und druckt sie aus? (#strong[B Übung 3.4])
][
Die Zeichnung dokumentiert den freigegebenen, abgestimmten Stand (Zeichnungs- und Revisionsnummer); Der Änderungsstand muss nachvollziehbar sein. Auf Papier können Parteien per Unterschrift zustimmen (paraphieren). Folgedokumente verweisen auf einen Zeichnungsstand (S. 33–34).

#src[L-alt A2, Frage 5; nach B S. 17–38]
]

// 1-6
#aufgabe(titel: "Vorhandene Bauteile ins CAD bringen", art: "verstehen", quelle: "2.1")[
#if not web [*Aufgabe 25* #linebreak()]
Wie kann man vorhandene Bauteile in ein CAD-System übertragen? (#strong[B Übung 3.5])
][
Abzeichnen und neu modellieren (bei einfachen Teilen meist am besten), Scannen von Zeichnungen, 3D-Scanner (Laser, Punktewolke), Photogrammetrie (bei komplexer, empfindlicher Geometrie) (S. 19–21).

#src[L-alt A2, Frage 6; nach B S. 17–38]
]

// 1-7
#aufgabe(titel: "Wann sich CAD lohnt", art: "verstehen", quelle: "2.6")[
#if not web [*Aufgabe 26* #linebreak()]
Für welche Konstruktionsart lohnt sich CAD am meisten, für welche am wenigsten? Begründe.
][
Am meisten: Variantenkonstruktion (parametrisierbare Modelle), dann Anpassungskonstruktion (Vorlagen schnell ändern). Am wenigsten: Neukonstruktion, weil CAD nicht beim Finden neuer Lösungen hilft (S. 32–33).

#src[L-alt A2, Frage 7; nach B S. 17–38]
]

// 1-8
#aufgabe(titel: "Austauschformate zuordnen", art: "verstehen", quelle: "2.5")[
#if not web [*Aufgabe 27* #linebreak()]
Ordne zu: 2D-Zeichnungsaustausch, 3D-Druck, vollständiges Produktmodell, Freiformflächen in der Autoindustrie.
][
DXF; STL; STEP; VDAFS (S. 31).

#src[L-alt A2, Frage 8; nach B S. 17–38]
]

// 1-9
#aufgabe(titel: "Fünf Anwendungen des Digital Mock-Up", art: "verstehen", quelle: "2.6")[
#if not web [*Aufgabe 28* #linebreak()]
Nenne die fünf Anwendungen des Digital Mock-Up mit je einem Satz.
][
Visualisierung (Gestalt von allen Seiten), Packaging (Platzverhältnisse), Clash & Clearance (Kollision, Freigängigkeit), Enveloping (Zusatzraum durch Schwingung/Wärme), Virtual Workshop (Platzbedarf bei Montage/Wartung) (S. 34–35).

#src[L-alt A2, Frage 9; nach B S. 17–38]
]

// 1-10
#aufgabe(titel: "Nachteile flächenbasierter Systeme", art: "verstehen", quelle: "2.4")[
#if not web [*Aufgabe 29* #linebreak()]
Welche Nachteile haben flächenbasierte Systeme gegenüber volumenbasierten?
][
Keine Volumenberechnung oder Kollisionsprüfung, oft keine Zeichnungsableitung und kein Datenbaum, kaum nachträglich änderbar, Lückenlosigkeit der Flächen nicht garantiert (S. 29–30).

#src[L-alt A2, Frage 10; nach B S. 17–38]
]

// 1-11
#aufgabe(titel: "Vom CAD-Modell zum 3D-Druck", art: "verstehen", quelle: "2.1")[
#if not web [*Aufgabe 30* #linebreak()]
Beschreibe den Ablauf vom CAD-Modell zum 3D-gedruckten Teil.
][
CAD-Modell → STL-Export → Zerlegen in Schichten (Slicen) mit Druckvorschau → schichtweiser Aufbau, ggf. mit Stützstrukturen (S. 22, Bild 3-6).

#src[L-alt A2, Frage 11; nach B S. 17–38]
]

// 1-12
#aufgabe(titel: "KI-Erklärungen zu Zeichnungen prüfen", art: "verstehen", quelle: "2.7")[
#if not web [*Aufgabe 31* #linebreak()]
Warum soll man Erklärungen einer KI zu einer Technischen Zeichnung immer prüfen?
][
Weil die KI nach Wahrscheinlichkeiten antwortet; im Buchtest waren Aussagen teils falsch, pauschal oder irreführend (S. 35–38).

#src[L-alt A2, Frage 12; nach B S. 17–38]
]

// 1-13
#aufgabe(titel: "CSG-Baum eines Flansches", art: "verstehen", quelle: "2.3")[
#if not web [*Aufgabe 32* #linebreak()]
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

// 1-14
#aufgabe(titel: "Würfel und Kugel verknüpfen", art: "verstehen", quelle: "2.3")[
#if not web [*Aufgabe 33* #linebreak()]
Was ergibt der Durchschnitt (∩) aus einem Würfel 40 × 40 × 40 und einer Kugel Ø50 mit gleichem Mittelpunkt? Was ergibt die Differenz Würfel \\ Kugel?
][
*Modell / Annahmen:* Idealisiertes CAD-Volumenmodell; Körperlage und Abmessungen sind wie in der Aufgabe angegeben.

Durchschnitt: Die Kugel (Radius 25) ragt über die Würfelflächen (Abstand 20 vom Mittelpunkt) hinaus. Übrig bleibt eine Kugel, die an den sechs Würfelseiten eben abgeflacht ist (sechs kreisförmige Flächen). Differenz Würfel \\ Kugel: Ein hohler Würfel, dessen Kanten und Ecken stehen bleiben (Kantenmitte 20·√2 ≈ 28,3 \> 25); jede Würfelseite bekommt ein kreisrundes Loch mit Radius √(25² − 20²) = 15.

*Prüfung:* Die Boolesche Operation muss das beabsichtigte Material liefern.

#src[L-alt A2, Frage 14; nach B S. 17–38]
]

// 1-15
#aufgabe(titel: "STL oder STEP wählen", art: "verstehen", quelle: "2.5")[
#if not web [*Aufgabe 34* #linebreak()]
Welches Austauschformat beschreibt Dreiecksflächen, welches ein umfassendes Produktmodell? Begründe die Wahl für 3D-Druck und Datenaustausch.
][
STL: Dreiecke. STEP: ganzes Produktmodell.

#src[L-alt A2, offene Überarbeitung Frage 15; B S. 17–38]
]

// 1-16
#aufgabe(titel: "Wie CSG ein Bauteil speichert", art: "verstehen", quelle: "2.3")[
#if not web [*Aufgabe 35* #linebreak()]
Wie speichert ein CSG-Modell ein Bauteil und wann entsteht daraus die explizite Begrenzungsgeometrie?
][
Sie speichern die Entstehungsgeschichte als Baum. Sie nutzen Grundkörper wie Quader, Zylinder, Kugel. Flächen werden beim Evaluieren abgeleitet.

#src[L-alt A2, offene Überarbeitung Frage 16; B S. 17–38]
]

// 1-17
#aufgabe(titel: "Freigabe, Revision und Folgedokumente", art: "verstehen", quelle: "2.6")[
#if not web [*Aufgabe 36* #linebreak()]
Welche Aufgabe erfüllen Freigabe, Revision und Folgedokumente im Dokumentationsablauf des Buchs?
][
Im Buch dient der freigegebene Zeichnungsstand zur nachvollziehbaren Änderungskontrolle. Sie trägt eine Revisionsnummer und Paraphen. Folgedokumente beziehen sich auf einen Zeichnungsstand.

#src[L-alt A2, offene Überarbeitung Frage 17; B S. 17–38]
]

// 1-18
#aufgabe(titel: "Clash und Clearance an einem Beispiel", art: "verstehen", quelle: "2.6")[
#if not web [*Aufgabe 37* #linebreak()]
Erkläre Clash & Clearance an einem eigenen Montagebeispiel.
][
Kollisionsprüfung und Prüfung der Freigängigkeit.

#src[L-alt A2, offene Überarbeitung Frage 18; B S. 17–38]
]


#kapitel("Kapitel 3 · Werkstücke darstellen")

// 2-1
#aufgabe(titel: "Natürlicher Maßstab, Verkleinerung, Vergrößerung", art: "verstehen", quelle: "3.1")[
#if not web [*Aufgabe 38* #linebreak()]
Was ist der natürliche Maßstab? Was bedeuten 1 : 5 und 5 : 1? (#strong[B Übung 4.1/4.2])
][
Natürlicher Maßstab 1 : 1: gezeichnete Länge = wirkliche Länge. 1 : 5: fünffach verkleinert (1 mm Papier = 5 mm Wirklichkeit). 5 : 1: fünffach vergrößert (S. 40).

#src[L-alt B1, Frage 1; nach B S. 39–64]
]

// 2-2
#aufgabe(titel: "Maßstäbe wählen und angeben", art: "verstehen", quelle: "3.1")[
#if not web [*Aufgabe 39* #linebreak()]
Dürfen Maßstäbe frei gewählt werden, und wo werden sie angegeben? (#strong[B Übung 4.3/4.4])
][
Nein, nur die Maßstäbe nach DIN ISO 5455 (Tab. 4-1). Hauptmaßstab im Schriftfeld; weitere bei der Einzelheit bzw. dem Schnitt, z. B. „Y 10:1“ (S. 40).

#src[L-alt B1, Frage 2; nach B S. 39–64]
]

// 2-3
#aufgabe(titel: "Linienarten zuordnen", art: "verstehen", quelle: "3.2")[
#if not web [*Aufgabe 40* #linebreak()]
Ordne die Linienart zu (#strong[B Übung 4.5]) : a) sichtbare Kanten, b) verdeckte Kanten, c) angrenzendes Werkstück, d) Lichtkanten, e) Rohteilkontur in Fertigteilzeichnung, f) Hinweislinien, g) Bruchkante, h) Mittellinie, i) wärmebehandelte Zone, j) Extremstellung beweglicher Teile, k) Schraffur.
][
a) 1 breite Volllinie; b) 5 schmale Strichlinie; c) 7 Strich-Zweipunktlinie; d) 4 schmale Volllinie; e) 7; f) 4; g) 8 Freihand-/Zickzacklinie; h) 6 schmale Strich-Punktlinie; i) 3 breite Strich-Punktlinie; j) 7; k) 4 (S. 41–43).

#src[L-alt B1, Frage 3; nach B S. 39–64]
]

// 2-4
#aufgabe(titel: "Strich-Punktlinie und Linienbreite auf A3", art: "verstehen", quelle: "3.2")[
#if not web [*Aufgabe 41* #linebreak()]
Was kann mit einer schmalen Strich-Punktlinie dargestellt werden? Welche Linienbreite haben Körperkanten auf A3? (#strong[B Übung 4.6/4.7])
][
Mittel- und Symmetrielinien, Lochkreise, Teilkreise von Zahnrädern, Bahnlinien. Körperkanten auf A3: Liniengruppe 0,5, also 0,5 mm (schmale Linien 0,25 mm) (S. 43).

#src[L-alt B1, Frage 4; nach B S. 39–64]
]

// 2-5
#aufgabe(titel: "Lage des Werkstücks in der Zeichnung", art: "verstehen", quelle: "3.3")[
#if not web [*Aufgabe 42* #linebreak()]
In welcher Lage wird ein Werkstück vorzugsweise dargestellt? Wie liegt ein Drehteil? (#strong[B Übung 4.8])
][
In Gebrauchslage, sonst in Fertigungslage; Drehteile waagrecht mit dem dünnen Ende nach rechts (S. 44).

#src[L-alt B1, Frage 5; nach B S. 39–64]
]

// 2-6
#aufgabe(titel: "Wie viele Ansichten nötig sind", art: "verstehen", quelle: "3.3")[
#if not web [*Aufgabe 43* #linebreak()]
Wie viele Ansichten muss eine Zeichnung haben? (#strong[B Übung 4.9])
][
So viele wie nötig, um das Teil eindeutig darzustellen: oft eine oder zwei, typisch drei, maximal sechs Standardansichten, bei Bedarf Zusatzansichten (S. 45–46).

#src[L-alt B1, Frage 6; nach B S. 39–64]
]

// 2-7
#aufgabe(titel: "Projektionsmethode 1 und 3", art: "verstehen", quelle: "3.3")[
#if not web [*Aufgabe 44* #linebreak()]
Unterscheide Projektionsmethode 1 und 3. Woran erkennt man auf der Zeichnung, welche gilt? (#strong[B Übung 4.10/4.11])
][
Methode 1: Draufsicht unten, Seitenansicht von links rechts. Methode 3: Draufsicht oben, Seitenansicht von links links. Kennzeichnung durch das Symbol der Projektionsmethode nahe dem Schriftfeld (Bild 4-6) (S. 46).

#src[L-alt B1, Frage 7; nach B S. 39–64]
]

// 2-8
#aufgabe(titel: "Pfeilmethode und Abweichen von Methode 1", art: "verstehen", quelle: "3.3")[
#if not web [*Aufgabe 45* #linebreak()]
Wann ist die Pfeilmethode sinnvoll? Wie geht man vor, wenn man von Methode 1 abweichen will? (#strong[B Übung 4.12/4.19])
][
Wenn Ansichten anders angeordnet werden sollen oder schräge Flächen unverkürzt gezeigt werden müssen. Vorgehen: Blickrichtung jeder Ansicht mit Pfeil und Großbuchstaben festlegen, Ansicht mit demselben Buchstaben bezeichnen (S. 46).

#src[L-alt B1, Frage 8; nach B S. 39–64]
]

// 2-9
#aufgabe(titel: "Fünf Grundregeln der Schraffur", art: "verstehen", quelle: "3.5")[
#if not web [*Aufgabe 46* #linebreak()]
Nenne die fünf Grundregeln der Schraffur.
][
Geneigte Linien; schmal; 45° zur Mittellinie/zum Hauptumriss; gleiches Muster für alle Schnittflächen eines Teils; keine verdeckten Kanten (S. 50).

#src[L-alt B1, Frage 9; nach B S. 39–64]
]

// 2-10
#aufgabe(titel: "Vollschnitt oder Halbschnitt", art: "verstehen", quelle: "3.5")[
#if not web [*Aufgabe 47* #linebreak()]
Wann wählt man einen Vollschnitt, wann einen Halbschnitt? Welche Hälfte ist beim Halbschnitt Ansicht?
][
Vollschnitt bei hohlen Teilen ohne wichtige Außenmerkmale; Halbschnitt bei symmetrischen Teilen, wenn außen auch etwas Darstellenswertes ist. Senkrechte Achse: linke Hälfte Ansicht; waagrechte Achse: obere Hälfte Ansicht (S. 53–54).

#src[L-alt B1, Frage 10; nach B S. 39–64]
]

// 2-11
#aufgabe(titel: "Was im Längsschnitt nicht geschnitten wird", art: "verstehen", quelle: "3.6")[
#if not web [*Aufgabe 48* #linebreak()]
Welche Teile werden im Längsschnitt nicht geschnitten, und warum?
][
Wellen, Stifte, Bolzen, Passfedern, Keile, Schrauben, Niete, Kugeln. Sie sind voll (ohne Hohlräume), ein Längsschnitt würde nichts Neues zeigen (S. 56).

#src[L-alt B1, Frage 11; nach B S. 39–64]
]

// 2-12
#aufgabe(titel: "Aneinanderstoßende Schnittflächen und Werkstoffe", art: "verstehen", quelle: "3.5")[
#if not web [*Aufgabe 49* #linebreak()]
Wie unterscheidet man in einer Zeichnung zwei aneinanderstoßende geschnittene Teile? Wie kann man Stahl von Glas unterscheiden? (#strong[B Übung 4.23])
][
Andere Schraffurrichtung (45° bleibt), sonst anderer Abstand. Stahl und Glas: mit unterschiedlichen, vorher definierten Schraffurmustern (Werkstoffschraffur nach Bild 4-15) (S. 50–51).

#src[L-alt B1, Frage 12; nach B S. 39–64]
]

// 2-13
#aufgabe(titel: "Abgeknickter Schnittverlauf", art: "verstehen", quelle: "3.7")[
#if not web [*Aufgabe 50* #linebreak()]
Wie wird ein abgeknickter Schnittverlauf gekennzeichnet?
][
Breite Strich-Punktlinie an Anfang, Ende und jedem Knickpunkt; Pfeile für die Blickrichtung an Anfang und Ende; Großbuchstaben „A–A“ an Anfang/Ende und über der Schnittdarstellung (S. 56–58).

#src[L-alt B1, Frage 13; nach B S. 39–64]
]

// 2-14
#aufgabe(titel: "Symmetrische Teile vereinfacht zeichnen", art: "verstehen", quelle: "3.4")[
#if not web [*Aufgabe 51* #linebreak()]
Wie können symmetrische Bauteile vereinfacht dargestellt werden? (#strong[B Übung 4.14])
][
Im Buchtext dafür vorgesehen: Halbschnitt (eine Hälfte Ansicht, eine Hälfte Schnitt) und eingeklappte Lochkreise. Ergänzung, nicht im Buchtext erklärt: Nach DIN EN ISO 128-3 darf man symmetrische Teile auch nur zur Hälfte oder zu einem Viertel zeichnen und die Symmetrielinie an den Enden mit zwei kurzen parallelen Strichen kennzeichnen. Das gilt für alle symmetrischen Teile, nicht nur für rotationssymmetrische.

#src[L-alt B1, Frage 14; nach B S. 39–64]
]

// 2-15
#aufgabe(titel: "Hebel im Maßstab 1 : 5", art: "rechnen", quelle: "3.1",
  ergebnis: [a) 72 mm (Breite 9,6 mm), b) 360, c) Maßstab 5 : 1],
  tipp: [Zeichenlänge = Maßstab mal wirkliche Länge. An der Maßlinie steht immer das wirkliche Maß.],
)[
#if not web [*Aufgabe 52* #linebreak()]
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

// 2-16
#aufgabe(titel: "Länge aus einer Zeichnung 1 : 2", art: "rechnen", quelle: "3.1",
  ergebnis: [74 mm; abgreifen ist trotzdem unzulässig],
  tipp: [Bei 1 : 2 ist das Bild halb so groß wie das Teil. Rechne zurück.],
)[
#if not web [*Aufgabe 53* #linebreak()]
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

// 2-17
#aufgabe(titel: "Stufenklotz nach Projektionsmethode 3", art: "verstehen", quelle: "3.3")[
#if not web [*Aufgabe 54* #linebreak()]
Skizziere den Stufenklotz aus der Abbildung in Abschnitt 3 nach Projektionsmethode 3. Wo liegen Draufsicht und Seitenansicht von links?
][
*Modell / Annahmen:* Maßstäbliche orthogonale Zeichnung; Maße beziehen sich auf das wirkliche Bauteil.

Methode 3: Draufsicht über der Vorderansicht (Rechteck 120 × 80 mit Linie bei der Stufe), Seitenansicht von links links neben der Vorderansicht (Quadrat mit verdeckter Linie auf halber Höhe).

*Prüfung:* Maßzahl und wirkliche Länge müssen übereinstimmen; alle Ansichten müssen denselben Körper zeigen.

#src[L-alt B1, Frage 17; nach B S. 39–64]
]

// 2-18
#aufgabe(titel: "Schmale und breite Linien", art: "verstehen", quelle: "3.2")[
#if not web [*Aufgabe 55* #linebreak()]
Welche Linien sind bei Bemaßung, Schraffur und Symmetrie schmal, und welche Konturen werden breit gezeichnet?
][
Maßlinien. Schraffur. Mittellinien.

#src[L-alt B1, offene Überarbeitung Frage 18; B S. 39–64]
]

// 2-19
#aufgabe(titel: "Lage der Draufsicht bei Methode 1", art: "verstehen", quelle: "3.3")[
#if not web [*Aufgabe 56* #linebreak()]
Wo liegt bei Projektionsmethode 1 die Draufsicht? Begründe die Lage durch gedankliches Aufklappen.
][
unter der Vorderansicht.

#src[L-alt B1, offene Überarbeitung Frage 19; B S. 39–64]
]

// 2-20
#aufgabe(titel: "Schnitt und Ansicht im Halbschnitt", art: "verstehen", quelle: "3.5")[
#if not web [*Aufgabe 57* #linebreak()]
Wie werden Schnitt und Ansicht im Halbschnitt getrennt und welche Hälfte wird bei senkrechter Achse geschnitten?
][
trennt die Mittellinie Schnitt und Ansicht. werden keine verdeckten Kanten gezeichnet. ist bei senkrechter Achse die linke Hälfte Ansicht.

#src[L-alt B1, offene Überarbeitung Frage 20; B S. 39–64]
]

// 2-21
#aufgabe(titel: "Gedrehter Profilschnitt", art: "verstehen", quelle: "3.7")[
#if not web [*Aufgabe 58* #linebreak()]
Wie wird ein in die Ansicht gedrehter Profilschnitt begrenzt?
][
schmaler Volllinie.

#src[L-alt B1, offene Überarbeitung Frage 21; B S. 39–64]
]

// 2-22
#aufgabe(titel: "Vergrößerte Einzelheit kennzeichnen", art: "verstehen", quelle: "3.4")[
#if not web [*Aufgabe 59* #linebreak()]
Wie kennzeichnest Du eine vergrößerte Einzelheit?
][
vom Ende des Alphabets.

#src[L-alt B1, offene Überarbeitung Frage 22; B S. 39–64]
]

// 2-23
#aufgabe(titel: "Zeichenlänge und Maßzahl bei 1 : 5", art: "rechnen", quelle: "3.1",
  ergebnis: [Zeichenlänge 48 mm, Maßzahl 240],
  tipp: [Zeichenlänge und Maßzahl sind zwei verschiedene Dinge.],
)[
#if not web [*Aufgabe 60* #linebreak()]
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

// 2-24
#aufgabe(titel: "Kantenlänge aus einer Zeichnung 1 : 2", art: "rechnen", quelle: "3.1",
  ergebnis: [Kante 170 mm, Maßzahl 170],
  tipp: [Bei einer Verkleinerung ist das Teil größer als das Bild.],
)[
#if not web [*Aufgabe 61* #linebreak()]
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

// 2-25
#aufgabe(titel: "Dreitafelprojektion und Projektionssymbole", art: "verstehen", quelle: "3.3")[
#if not web [*Aufgabe 62* #linebreak()]
Benenne die drei Ansichten der Dreitafelprojektion und erkläre die beiden Projektionssymbole aus AK 1c.
][
Vorderansicht, Draufsicht, Seitenansicht. Die Zeichen aus Kegelstumpf und Kreisansicht kennzeichnen Projektionsmethode 1 beziehungsweise 3. Bei Methode 1 steht die Kreisansicht rechts vom Kegelstumpf, bei Methode 3 links. Damit wird die Zuordnung der Ansichten am Schriftfeld festgelegt.

#src[AK 1b/1c, PDF-S. 2; B Bild 4-6, S. 46]
]

// 2-26
#aufgabe(titel: "Drei Ausnahmen im Längsschnitt", art: "verstehen", quelle: "3.6")[
#if not web [*Aufgabe 63* #linebreak()]
Nenne drei Beispiele, die im Längsschnitt nicht geschnitten dargestellt werden, und begründe die Ausnahme.
][
Beispiele: massive Welle, Schraube, Passfeder; außerdem Stifte, Bolzen, Niete und Wälzkörper. Die vereinfachte Darstellung hält die Baugruppe lesbar. Die Ausnahme betrifft die Längsschnittlage; ein notwendiger Querschnitt zur Darstellung einer Nut ist davon zu unterscheiden.

#src[AK 1d, PDF-S. 2; B S. 56]
]

// 2-27
#aufgabe(titel: "Geschnittener Kegel in drei Ansichten", art: "verstehen", quelle: "3.3")[
#if not web [*Aufgabe 64* #linebreak()]
Konstruiere Drauf- und Seitenansicht des geschnittenen Kegels aus AK 2a. Beschreibe Deinen Projektionsweg und überprüfe charakteristische Punkte.
#bild("ak-kegel", [Originalausschnitt AK, PDF-S. 5.], height: 69mm)
][
*Eigene Konstruktionslösung:* 1. Übertrage Achse und Grundkreisdurchmesser in Drauf- und Seitenansicht nach Methode 1. 2. Zerlege den Grundkreis in beispielsweise 12 gleiche Winkel und zeichne Mantellinien zur Spitze. 3. Bestimme in der gegebenen Vorderansicht die Schnittpunkte der Mantellinien mit der schrägen Schnittebene. 4. Projiziere diese Punkte entlang der zugehörigen Projektionslinien in Drauf- und Seitenansicht; gleiche Höhen und Kreiszuordnungen sichern die Lage. 5. Verbinde die Punkte zu einer glatten Schnittkurve, ziehe sichtbare Konturen breit und kennzeichne verdeckte sparsam. Prüfung: Symmetrie zur vertikalen Mittelebene bleibt erhalten; Scheitelpunkte müssen zu den höchsten/niedrigsten Schnittpunkten passen. Die Vorlage hat keine Maßzahlen: eine numerisch bemaßte Musterzeichnung wäre daraus nicht eindeutig ableitbar.

#src[AK 2a, PDF-S. 5; eigene Lösung mit B S. 43–47]
]

// 2-28
#aufgabe(titel: "Würfel in Isometrie und Dimetrie", art: "verstehen", quelle: "3.3")[
#if not web [*Aufgabe 65* #linebreak()]
Zeichne einen Würfel mit 30 mm Kantenlänge in technischer Isometrie und Dimetrie.
][
*Eigene Zeichenlösung:* 1. Isometrie: drei Achsen mit 120° gegenseitigem Winkel, eine senkrecht und zwei 30° zur Waagerechten. Trage je 30 mm ab und schließe den Würfel mit achsparallelen Kanten. 2. Übliche technische Dimetrie: eine senkrechte Achse, flache Achse ungefähr 7°, Tiefenachse ungefähr 42°; die Tiefenlänge wird halbiert, also 15 mm, die beiden anderen 30 mm. 3. Sichtbare Kanten nachziehen, verdeckte bei dieser Anschauungsskizze nur bei Bedarf. Prüfung: Kanten derselben Raumrichtung bleiben parallel. Dies sind die technischen Zeichenkonventionen; eine geometrisch streng verkürzte isometrische Projektion hat andere Zeichenlängen.

#src[AK 2b, PDF-S. 6; ergänzte Zeichenkonventionen]
]


#kapitel("Kapitel 4 · Bemaßung und Dokumentation")

// 3-1
#aufgabe(titel: "GPS und ihre drei Welten", art: "verstehen", quelle: "4.1")[
#if not web [*Aufgabe 66* #linebreak()]
Was versteht man unter GPS, und welche drei „Welten“ verbindet sie?
][
Geometrische Produktspezifikation: Gesamtkonzept aller Normen, die Idealgeometrie und zulässige Abweichungen festlegen (Maße, Form, Lage, Oberfläche, Kanten). Sie verbindet Spezifikation, Fertigung und Prüfung (GPS-Matrix mit 18 Merkmalen × 6 Kettengliedern, DIN EN ISO 14638) (S. 65–67).

#src[L-alt B2, Frage 1; nach B S. 65–106]
]

// 3-2
#aufgabe(titel: "Normschrift B", art: "verstehen", quelle: "4.2")[
#if not web [*Aufgabe 67* #linebreak()]
Was ist die Besonderheit der Normschrift B bei Größe und Linienbreite? (#strong[B Übung 5.1])
][
Linienbreite = 1/10 der Schrifthöhe; Größen 2,5/3,5/5/7 mm mit Stufensprung √2, damit beim Vergrößern/Verkleinern wieder Normgrößen entstehen (S. 67–68).

#src[L-alt B2, Frage 2; nach B S. 65–106]
]

// 3-3
#aufgabe(titel: "Grundregeln der Maßeintragung", art: "verstehen", quelle: "4.3")[
#if not web [*Aufgabe 68* #linebreak()]
Welche Maße müssen eingetragen werden, in welcher Einheit, auf welchen Zustand bezogen, und wie oft? (#strong[B Übung 5.2–5.5])
][
Alle zur Herstellung nötigen Maße (vollständig), in mm ohne Einheit, bezogen auf den dargestellten Endzustand, jedes Maß nur einmal (S. 69).

#src[L-alt B2, Frage 3; nach B S. 65–106]
]

// 3-4
#aufgabe(titel: "Abstände von Maß- und Maßhilfslinien", art: "verstehen", quelle: "4.3")[
#if not web [*Aufgabe 69* #linebreak()]
Nenne die Abstände: Maßlinie zur Kante, Maßlinien untereinander, Überstand der Maßhilfslinie.
][
Ca. 10 mm; mindestens 7 mm; 1–2 mm (S. 69).

#src[L-alt B2, Frage 4; nach B S. 65–106]
]

// 3-5
#aufgabe(titel: "Drehteil fertigungsgerecht bemaßen", art: "verstehen", quelle: "4.4")[
#if not web [*Aufgabe 70* #linebreak()]
Wie bemaßt man ein Drehteil fertigungsgerecht? Warum braucht man beim Umspannen zwei Bezugsebenen?
][
Axiale Maße von einer plangedrehten Bezugsebene aus, radiale als Durchmesser, Fasen/Radien/Einstiche separat. Nach dem Umspannen ist die zweite Stirnseite die neue Bezugsebene, von der aus die Maße dieser Seite abgelesen werden (S. 75–76).

#src[L-alt B2, Frage 5; nach B S. 65–106]
]

// 3-6
#aufgabe(titel: "Gewindebohrung bemaßen", art: "verstehen", quelle: "4.4")[
#if not web [*Aufgabe 71* #linebreak()]
Was wird bei einer Gewindebohrung bemaßt und was nicht?
][
Bemaßt: Gewinde-Nennmaß (z. B. M8), Tiefe der Kernlochbohrung, nutzbare Gewindelänge, Position. Nicht bemaßt: Kernlochdurchmesser (DIN 13) und Bohrerspitze (120°, nur gezeichnet) (S. 81–82).

#src[L-alt B2, Frage 6; nach B S. 65–106]
]

// 3-7
#aufgabe(titel: "Klammern und Rahmen an Maßen", art: "verstehen", quelle: "4.5")[
#if not web [*Aufgabe 72* #linebreak()]
Was bedeuten: ( ), \[ \], Rahmen mit runden Ecken, rechteckiger Rahmen? (Übung 5.6–5.9, 5.11)
][
( ) Hilfsmaß, ergibt sich aus anderen Maßen; \[ \] Roh- oder Vorbearbeitungsmaß; runder Rahmen: Prüfmaß; rechteckiger Rahmen: theoretisch genaues Maß ohne Toleranz (S. 86–91).

#src[L-alt B2, Frage 7; nach B S. 65–106]
]

// 3-8
#aufgabe(titel: "Maßzeichen Ø, M, Tr, R, S, SW und Co.", art: "verstehen", quelle: "4.5")[
#if not web [*Aufgabe 73* #linebreak()]
Was bedeuten die Zeichen Ø, M, Tr, R, S, SR, SW, □, t = 5? (#strong[B Übung 5.12/5.13])
][
Ø Durchmesser; M metrisches ISO-Gewinde; Tr Trapezgewinde; R Radius; S Kugel (SØ Kugeldurchmesser); SR Kugelradius; SW Schlüsselweite; □ Quadrat; t = 5 Dicke 5 mm (S. 82–90).

#src[L-alt B2, Frage 8; nach B S. 65–106]
]

// 3-9
#aufgabe(titel: "Wann eine Fase als 2 × 45° gilt", art: "verstehen", quelle: "4.5")[
#if not web [*Aufgabe 74* #linebreak()]
Wann darf man eine Fase als „2 × 45°“ angeben, wann nicht?
][
Nur bei 45°-Fasen dürfen Länge und Winkel gemeinsam stehen („2 × 45°“). Bei anderen Winkeln getrennt: Länge und Winkel (S. 89).

#src[L-alt B2, Frage 9; nach B S. 65–106]
]

// 3-10
#aufgabe(titel: "Parallel-, steigende und Koordinatenbemaßung", art: "verstehen", quelle: "4.6")[
#if not web [*Aufgabe 75* #linebreak()]
Erkläre Parallel-, steigende und Koordinatenbemaßung. Wofür ist die Koordinatenbemaßung praktisch?
][
Parallel: alle Maßlinien parallel bzw. konzentrisch. Steigend: eine Maßlinie je Richtung ab Ursprung 0, Pfeile an jeder Maßhilfslinie. Koordinaten: Punkte als x/y- oder Polarkoordinaten, oft in Tabelle; vereinfacht die NC-Programmierung (S. 94–95).

#src[L-alt B2, Frage 10; nach B S. 65–106]
]

// 3-11
#aufgabe(titel: "Pflichtfelder des Schriftfelds", art: "verstehen", quelle: "4.7")[
#if not web [*Aufgabe 76* #linebreak()]
Nenne die Pflichtfelder des Schriftfelds nach DIN EN ISO 7200.
][
Gesetzlicher Eigentümer, Sachnummer, Ausgabedatum, Blattnummer, Titel, genehmigende Person, Ersteller, Dokumentenart (S. 99–100).

#src[L-alt B2, Frage 11; nach B S. 65–106]
]

// 3-12
#aufgabe(titel: "Lose Stückliste und Stückliste auf der Zeichnung", art: "verstehen", quelle: "4.8")[
#if not web [*Aufgabe 77* #linebreak()]
Wie unterscheiden sich lose Stückliste und Stückliste auf der Zeichnung? (#strong[B Übung 5.19])
][
Lose Stückliste: eigene A4-Blätter, Überschrift oben, von oben nach unten gefüllt, muss bei Zeichnungsänderungen mitgepflegt werden, weil sie auf die Zeichnung verweist. Auf der Zeichnung: auf dem Schriftfeld, Überschrift unten, von unten nach oben (S. 102).

#src[L-alt B2, Frage 12; nach B S. 65–106]
]

// 3-13
#aufgabe(titel: "Kleine und große Zeichnungsänderungen", art: "verstehen", quelle: "4.8")[
#if not web [*Aufgabe 78* #linebreak()]
Wie geht man bei kleinen und bei großen Zeichnungsänderungen vor?
][
Klein: an der Stelle kennzeichnen (Buchstabe im Kreis), Änderungsindex/Ausgabedatum anpassen. Groß: neue Zeichnung, alte als „zurückgezogen“ kennzeichnen, lose Stückliste anpassen. Nach Freigabe/Verteilung zusätzlich betriebsinterne Abläufe (S. 102).

#src[L-alt B2, Frage 13; nach B S. 65–106]
]

// 3-14
#aufgabe(titel: "Teilungsangabe für acht Bohrungen", art: "verstehen", quelle: "4.6")[
#if not web [*Aufgabe 79* #linebreak()]
Ein Flansch hat 8 Bohrungen Ø9 gleichmäßig auf einem Lochkreis Ø100. Wie lautet die vereinfachte Teilungsangabe für die Winkel (erste bis letzte Bohrung)?
][
*Modell / Annahmen:* Bemaßung im Maschinenbau nach den im Kapitel benannten Normen.

Teilung = 360° / 8 = 45°;  von der 

1. bis zur 8. Bohrung: 7 Teilungen
Angabe: 7 × 45° (= 315°), dazu 8 × Ø9 und Lochkreis Ø100

*Prüfung:* Jedes Funktionsmerkmal ist eindeutig bemaßt und auf denselben Bezug zurückführbar.

#src[L-alt B2, Frage 14; nach B S. 65–106]
]

// 3-15
#aufgabe(titel: "Was wohin auf die Zeichnung gehört", art: "verstehen", quelle: "4.7")[
#if not web [*Aufgabe 80* #linebreak()]
Ordne zu (vgl. Übung 5.15): Wo stehen a) „Werkstoff S235JR“, b) „Maßstab 1:1“, c) „ISO 2768-mK“, d) Name des Erstellers, e) Sachnummer 311.234, f) Änderung einer Länge von 50 auf 70 mm?
][
*Modell / Annahmen:* Bemaßung im Maschinenbau nach den im Kapitel benannten Normen.

a) Werkstoff im Schriftfeld bzw. seiner Erweiterung; b) Maßstab in der Schriftfeld-Erweiterung (kein Pflichtfeld); c) Allgemeintoleranzen nahe/in der Erweiterung des Schriftfelds; d) Ersteller: Pflichtfeld im Schriftfeld; e) Sachnummer: Pflichtfeld; der Ersatzvermerk „ersetzt 311.200“ zusätzlich; f) an der Maßstelle mit Änderungszeichen (Buchstabe im Kreis), Änderungsindex im Schriftfeld erhöhen.

*Prüfung:* Jedes Funktionsmerkmal ist eindeutig bemaßt und auf denselben Bezug zurückführbar.

#src[L-alt B2, Frage 15; nach B S. 65–106]
]

// 3-16
#aufgabe(titel: "Fehler in einer Bemaßung finden", art: "verstehen", quelle: "4.3")[
#if not web [*Aufgabe 81* #linebreak()]
Finde die Fehler: Auf einer Zeichnung steht „Länge 120 mm“ an einer Maßlinie, „45“ an einem Winkel, das Maß 30 ist in Vorder- und Draufsicht eingetragen, und eine Mittellinie läuft durch die Maßzahl.
][
*Modell / Annahmen:* Bemaßung im Maschinenbau nach den im Kapitel benannten Normen.

„mm“ gehört nicht an die Maßzahl (und kein Wort „Länge“); Winkel braucht die Einheit „45°“; das Maß 30 darf nur einmal eingetragen werden; Maßzahlen dürfen von keiner Linie gekreuzt werden, die Mittellinie wird unterbrochen (S. 69–70).

*Prüfung:* Jedes Funktionsmerkmal ist eindeutig bemaßt und auf denselben Bezug zurückführbar.

#src[L-alt B2, Frage 16; nach B S. 65–106]
]

// 3-17
#aufgabe(titel: "Linienbreite, Leserichtung und Einheit", art: "verstehen", quelle: "4.3")[
#if not web [*Aufgabe 82* #linebreak()]
Erkläre Linienbreite, Leserichtung und Einheit bei der Maßeintragung.
][
Maßlinien sind schmale Volllinien. Maßzahlen werden von unten und von rechts gelesen. Winkel brauchen eine Einheit.

#src[L-alt B2, offene Überarbeitung Frage 17; B S. 65–106]
]

// 3-18
#aufgabe(titel: "Rohmaß und Hilfsmaß", art: "verstehen", quelle: "4.5")[
#if not web [*Aufgabe 83* #linebreak()]
Worin unterscheiden sich ein Rohmaß in eckigen Klammern und ein Hilfsmaß in runden Klammern?
][
ein Rohmaß.

#src[L-alt B2, offene Überarbeitung Frage 18; B S. 65–106]
]

// 3-19
#aufgabe(titel: "Identifikationsfelder im Schriftfeld", art: "verstehen", quelle: "4.7")[
#if not web [*Aufgabe 84* #linebreak()]
Nenne wichtige verpflichtende Identifikationsfelder eines Schriftfelds nach dem Buchbeispiel.
][
Titel. Sachnummer. Ersteller.

#src[L-alt B2, offene Überarbeitung Frage 19; B S. 65–106]
]

// 3-20
#aufgabe(titel: "Maße eines Frästeils und Bezugsflächen", art: "verstehen", quelle: "4.4")[
#if not web [*Aufgabe 85* #linebreak()]
Wie müssen die Maße eines Frästeils zu Werkzeugweg und Bezugsflächen passen?
][
mittige Nuten brauchen keine Lageangabe. der Fräserweg soll ablesbar sein. Flächen aus dem Werkzeugauslauf werden nicht bemaßt.

#src[L-alt B2, offene Überarbeitung Frage 20; B S. 65–106]
]

// 3-21
#aufgabe(titel: "Bemaßungsarten und Schriftfeld aus der Altklausur", art: "verstehen", quelle: "4.6")[
#if not web [*Aufgabe 86* #linebreak()]
Bestimme die drei Bemaßungsarten aus AK 1h und nenne vier Angaben eines Schriftfelds.
][
Die drei Darstellungen unterscheiden Kettenbemaßung (aufeinanderfolgende Abstände), Parallelbemaßung (Maße vom selben Bezug) und steigende Bemaßung (Werte ab markiertem Nullpunkt). Vier mögliche Schriftfeldangaben: Benennung, Zeichnungs-/Sachnummer, Ersteller, Freigabe-/Ausgabedatum; weitere sind Eigentümer und Blattangabe.

#src[AK 1h/1i, PDF-S. 4; B S. 94–95, 98–101]
]


#kapitel("Kapitel 5 · Oberflächen und Kanten")

// 4-1
#aufgabe(titel: "Gestaltabweichungen erster bis fünfter Ordnung", art: "verstehen", quelle: "5.2")[
#if not web [*Aufgabe 87* #linebreak()]
Nenne die Gestaltabweichungen 1. bis 5. Ordnung. Welche davon zählen zur Rauheit?
][
Formabweichung, 2. Welligkeit, 3. Rillen, 4. Riefen/Schuppen/Kuppen, 5. Gefügestruktur. Rauheit = 3. bis 5. Ordnung (S. 108–110).

#src[L-alt C1, Frage 1; nach B S. 107–130]
]

// 4-2
#aufgabe(titel: "Geometrische, wirkliche und Istoberfläche", art: "verstehen", quelle: "5.2")[
#if not web [*Aufgabe 88* #linebreak()]
Was unterscheidet geometrische Oberfläche, wirkliche Oberfläche und Istoberfläche?
][
Geometrisch: ideal laut Zeichnung. Wirklich: tatsächlich vorhandene Grenze zwischen Werkstück und Umgebung. Ist: gemessenes, angenähertes Abbild der wirklichen Oberfläche (S. 108–109).

#src[L-alt C1, Frage 2; nach B S. 107–130]
]

// 4-3
#aufgabe(titel: "P-, W- und R-Profil", art: "verstehen", quelle: "5.2")[
#if not web [*Aufgabe 89* #linebreak()]
Wie entstehen P-, W- und R-Profil? Was ist der Unterschied zwischen Einzelmessstrecke und Messstrecke?
][
Das gemessene Primärprofil (P) wird gefiltert: langwellige Anteile ergeben das Welligkeitsprofil (W), kurzwellige das Rauheitsprofil (R). Die Einzelmessstrecke ist die Auswertelänge für einen Kennwert; die Messstrecke besteht im Regelfall aus 5 Einzelmessstrecken (S. 110, 115).

#src[L-alt C1, Frage 3; nach B S. 107–130]
]

// 4-4
#aufgabe(titel: "Rp, Rv, Rz und Rt", art: "verstehen", quelle: "5.3")[
#if not web [*Aufgabe 90* #linebreak()]
Definiere Rp, Rv, Rz und Rt. Wann sind Rz und Rt verschieden?
][
Rp größte Spitze, Rv tiefstes Tal, Rz = Rp + Rv je Einzelmessstrecke, Rt = Rp + Rv über die ganze Messstrecke. Rt ist größer, wenn die höchste Spitze oder das tiefste Tal außerhalb der betrachteten Einzelmessstrecke liegt; ohne andere Angabe gelten sie als identisch (S. 110–111).

#src[L-alt C1, Frage 4; nach B S. 107–130]
]

// 4-5
#aufgabe(titel: "Ra anschaulich und der einzelne Kratzer", art: "verstehen", quelle: "5.3")[
#if not web [*Aufgabe 91* #linebreak()]
Was beschreibt Ra anschaulich? Warum reagiert Rz stärker auf einen einzelnen Kratzer als Ra?
][
Ra ist die Höhe eines Rechtecks mit gleicher Fläche wie alle Flächen zwischen Profil und Mittellinie. Ra mittelt über alle Punkte, ein einzelner Kratzer fällt kaum ins Gewicht; Rz wird direkt aus dem tiefsten Tal bestimmt (S. 110–111).

#src[L-alt C1, Frage 5; nach B S. 107–130]
]

// 4-6
#aufgabe(titel: "Ra, Rz oder RSm", art: "verstehen", quelle: "5.3")[
#if not web [*Aufgabe 92* #linebreak()]
Für welche Profile verwendet man Ra/Rz und für welche RSm? Nenne je ein Fertigungsverfahren.
][
Ra/Rz: aperiodische Profile (Schleifen, Erodieren). RSm: periodische Profile (Drehen, Fräsen, Stoßen) (S. 112).

#src[L-alt C1, Frage 6; nach B S. 107–130]
]

// 4-7
#aufgabe(titel: "Drei Oberflächensymbole", art: "verstehen", quelle: "5.4")[
#if not web [*Aufgabe 93* #linebreak()]
Erkläre die drei Oberflächensymbole nach DIN EN ISO 1302. Was ändert sich nach DIN EN ISO 21920-1?
][
Mit Linie am langen Schenkel: alle Verfahren zulässig. Zusätzlich Linie am kurzen Schenkel: Materialabtrag gefordert. Kreis: Materialabtrag unzulässig. 21920-1: ein zusätzlicher Balken, immer das vollständige Symbol, kein Grundsymbol und kein Rundum-Kreis mehr (S. 113).

#src[L-alt C1, Frage 7; nach B S. 107–130]
]

// 4-8
#aufgabe(titel: "Positionen a bis e am Oberflächensymbol", art: "verstehen", quelle: "5.5")[
#if not web [*Aufgabe 94* #linebreak()]
Was steht auf den Positionen a bis e am Oberflächensymbol? In welcher Einheit steht die Bearbeitungszugabe?
][
a: Filter/Einzelmessstrecke, Kenngröße, Grenzwert; b: weitere Anforderung; c: Verfahren, Behandlung, Beschichtung; d: Rillenrichtung; e: Bearbeitungszugabe in mm (S. 114, 117).

#src[L-alt C1, Frage 8; nach B S. 107–130]
]

// 4-9
#aufgabe(titel: "Zwei Leerzeichen hinter Rz1", art: "verstehen", quelle: "5.5")[
#if not web [*Aufgabe 95* #linebreak()]
Warum stehen zwischen „Rz1“ und dem Grenzwert zwei Leerzeichen?
][
Damit die Anzahl der Einzelmessstrecken (z. B. 1) nicht mit dem Grenzwert verwechselt wird: „Rz1  3,2“ statt „Rz 13,2“ (S. 115).

#src[L-alt C1, Frage 9; nach B S. 107–130]
]

// 4-10
#aufgabe(titel: "Obere und untere Rauheitsgrenze", art: "verstehen", quelle: "5.5")[
#if not web [*Aufgabe 96* #linebreak()]
Wie begrenzt man eine Oberfläche nach oben und nach unten? Wann braucht man „U“ und „L“?
][
Zwei Werte übereinander, der größere oben. „U“ (upper) und „L“ (lower) sind nötig, wenn verschiedene Kenngrößen verwendet werden; bei gleicher Kenngröße dürfen sie entfallen (S. 115).

#src[L-alt C1, Frage 10; nach B S. 107–130]
]

// 4-11
#aufgabe(titel: "Die 16-%-Regel", art: "verstehen", quelle: "5.5")[
#if not web [*Aufgabe 97* #linebreak()]
Was besagt die 16 %-Regel, und wann gilt sie? Was gilt ohne Angabe nach DIN EN ISO 21920-1?
][
Nach DIN EN ISO 1302 ohne Zusatzangabe: annehmbar, wenn höchstens 16 % aller Messwerte den Grenzwert überschreiten. Nach 21920-1 gilt ohne Angabe Tmax: keine Überschreitung (S. 116).

#src[L-alt C1, Frage 11; nach B S. 107–130]
]

// 4-12
#aufgabe(titel: "Fertigungsverfahren in der Vergangenheitsform", art: "verstehen", quelle: "5.5")[
#if not web [*Aufgabe 98* #linebreak()]
Warum steht das Fertigungsverfahren auf Position c in der Vergangenheitsform?
][
Die Zeichnung beschreibt den Endzustand des Bauteils, deshalb „gedreht“, „geschliffen“ (S. 117).

#src[L-alt C1, Frage 12; nach B S. 107–130]
]

// 4-13
#aufgabe(titel: "Überwiegende Oberfläche mit Ausnahmen", art: "verstehen", quelle: "5.6")[
#if not web [*Aufgabe 99* #linebreak()]
Wie gibt man eine überwiegende Oberflächenbeschaffenheit mit Ausnahmen an?
][
Symbol mit Hauptangabe nahe am Teil bzw. über dem Schriftfeld, dahinter in Klammern die Ausnahmen (oder das Grundsymbol in Klammern); die abweichenden Flächen werden direkt am Teil gekennzeichnet (S. 119).

#src[L-alt C1, Frage 13; nach B S. 107–130]
]

// 4-14
#aufgabe(titel: "Örtlich gehärteten Bereich kennzeichnen", art: "verstehen", quelle: "5.7")[
#if not web [*Aufgabe 100* #linebreak()]
Wie kennzeichnet man einen örtlich gehärteten Bereich, und was gehört zur Angabe der Wärmebehandlung?
][
Bereich mit breiter Strichpunktlinie außerhalb der Kontur kennzeichnen und bemaßen. Angabe des Endzustands („einsatzgehärtet“ usw.) mit Härtewert und Plustoleranz nahe dem Schriftfeld, ggf. Messstellen und Wärmebehandlungsbild (S. 120–122).

#src[L-alt C1, Frage 14; nach B S. 107–130]
]

// 4-15
#aufgabe(titel: "Beschichtungen kennzeichnen", art: "verstehen", quelle: "5.8")[
#if not web [*Aufgabe 101* #linebreak()]
Mit welchen Linien kennzeichnet man partielle Beschichtung, unzulässige Beschichtung und zulässige Beschichtung?
][
Partiell: breite Strichpunktlinie. Nicht zulässig: schmale Strich-Zweipunktlinie. Zulässig, aber nicht nötig: breite Strichlinie. Die Bedeutung ist zu erklären (S. 123–124).

#src[L-alt C1, Frage 15; nach B S. 107–130]
]

// 4-16
#aufgabe(titel: "Kantenzustand mit Plus und Minus", art: "verstehen", quelle: "5.9")[
#if not web [*Aufgabe 102* #linebreak()]
Was bedeuten „+“, „−“ und „±“ beim Kantenzustand für Außen- und Innenkanten? Warum lohnt es sich, Kanten zu definieren?
][
Außenkante: + Grat zulässig, − gratfrei/Abtragung. Innenkante: + Übergang zulässig, − Abtragung. ± beides zulässig. Sinn: Verletzungsgefahr, Montage, Funktion (Anlage, Dichtung) und Kosten werden eindeutig geregelt (S. 124–126).

#src[L-alt C1, Frage 16; nach B S. 107–130]
]

// 4-17
#aufgabe(titel: "Rz und Rt aus Spitzen und Tälern", art: "rechnen", quelle: "5.3",
  ergebnis: [Rz = 8 µm (diese Einzelmessstrecke), Rt = 11 µm],
  tipp: [Rz schaut in eine Einzelmessstrecke, Rt auf die ganze Messstrecke.],
)[
#if not web [*Aufgabe 103* #linebreak()]
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

// 4-18
#aufgabe(titel: "Ra und Rz eines Rechteckprofils", art: "rechnen", quelle: "5.3",
  ergebnis: [Ra = 1,5 µm, Rz = 3 µm],
  tipp: [Ra ist der Mittelwert der Beträge der Abweichung von der Mittellinie.],
)[
#if not web [*Aufgabe 104* #linebreak()]
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

// 4-19
#aufgabe(titel: "Oberflächenangabe für spanlose Fläche", art: "verstehen", quelle: "5.5")[
#if not web [*Aufgabe 105* #linebreak()]
Baue die Angabe auf (Symbol beschreiben + Text): spanlos hergestellte Fläche mit Rz zwischen 2,5 µm und 4,5 µm (Buch 6.17).
][
*Modell / Annahmen:* Genannte Profilform und Normfassung; Längen des Profils und Höhen einheitlich behandeln.

Symbol mit #strong[Kreis] (Materialabtrag unzulässig) und zwei Werten übereinander: oben „Rz  4,5“, unten „Rz  2,5“ (gleiche Kenngröße, U/L dürfen entfallen; sonst „U Rz 4,5“ / „L Rz 2,5“) (S. 113, 115).

*Prüfung:* Ra und Rz sind Höhenwerte in µm; die genannte Normfassung und Auswertelänge müssen passen.

#src[L-alt C1, Frage 19; nach B S. 107–130]
]

// 4-20
#aufgabe(titel: "Oberflächenangabe für verzinkte Fläche", art: "verstehen", quelle: "5.5")[
#if not web [*Aufgabe 106* #linebreak()]
Baue die Angabe auf: beliebig hergestellte, verzinkte Fläche mit Ra ≤ 25 µm (Buch 6.18).
][
*Modell / Annahmen:* Genannte Profilform und Normfassung; Längen des Profils und Höhen einheitlich behandeln.

Symbol „alle Verfahren zulässig“ (nur Linie am langen Schenkel), Position a „Ra  25“ (einseitig = obere Grenze), Position c „verzinkt“ (S. 113–117).

*Prüfung:* Ra und Rz sind Höhenwerte in µm; die genannte Normfassung und Auswertelänge müssen passen.

#src[L-alt C1, Frage 20; nach B S. 107–130]
]

// 4-21
#aufgabe(titel: "Rauheit für Außenfläche, Lagersitz, Dichtfläche", art: "verstehen", quelle: "5.5")[
#if not web [*Aufgabe 107* #linebreak()]
Welche Grenzwerte forderst du für a) eine funktionslose Außenfläche, b) einen Wälzlagersitz auf einer Welle, c) eine dynamische Dichtfläche (Buch 6.21)?
][
*Modell / Annahmen:* Genannte Profilform und Normfassung; Längen des Profils und Höhen einheitlich behandeln.

a) Rz \> 100 µm bzw. Ra \> 12,5 µm (keine Angabe nötig, außer Sammelangabe). b) Rz ≤ 6,3 µm, Ra ≤ 1,6 µm. c) Rz 4–6,3 µm, Ra 0,4–0,8 µm (S. 117).

*Prüfung:* Ra und Rz sind Höhenwerte in µm; die genannte Normfassung und Auswertelänge müssen passen.

#src[L-alt C1, Frage 21; nach B S. 107–130]
]

// 4-22
#aufgabe(titel: "Oberflächen am Gehäusedeckel", art: "verstehen", quelle: "5.6")[
#if not web [*Aufgabe 108* #linebreak()]
Gehäusedeckel (Buch 6.12): Fläche 1 ist Auflage für Schraubenköpfe, Fläche 3 eine Durchgangsbohrung für Schrauben, Fläche 5 die Zentrierung zum Gehäuse, Flächen 6/7 berühren nichts. Ordne grob/fein zu und begründe kurz.
][
*Modell / Annahmen:* Genannte Profilform und Normfassung; Längen des Profils und Höhen einheitlich behandeln.

Fläche 1: fein (z. B. Ra 1,6), Schraubenkopfauflage. Fläche 3: grob, Schrauben berühren die Bohrung nicht und sie bestimmt die Lage nicht. Fläche 5: fein, Zentrierung bestimmt die Lage. Flächen 6/7: grob, keine Funktionsflächen. Fläche 4 (Auflage zum Gehäuse): fein; Fläche 2 (entsteht nur nebenbei): grob (S. 129).

*Prüfung:* Ra und Rz sind Höhenwerte in µm; die genannte Normfassung und Auswertelänge müssen passen.

#src[L-alt C1, Frage 22; nach B S. 107–130]
]

// 4-23
#aufgabe(titel: "Ra 0,8 auf allen Gussflächen", art: "verstehen", quelle: "5.5")[
#if not web [*Aufgabe 109* #linebreak()]
Kostenfrage: Ein Kollege schreibt auf alle Flächen eines Gussgehäuses „Ra 0,8“. Was sagst du ihm?
][
*Modell / Annahmen:* Genannte Profilform und Normfassung; Längen des Profils und Höhen einheitlich behandeln.

Unnötig teuer: Gussflächen ohne Funktion können roh bleiben (Kreissymbol oder Sammelangabe grob). Fein nur an Funktionsflächen wie Lagersitz oder Dichtfläche; Motto „so grob wie möglich, so fein wie nötig“ (S. 117–118).

*Prüfung:* Ra und Rz sind Höhenwerte in µm; die genannte Normfassung und Auswertelänge müssen passen.

#src[L-alt C1, Frage 23; nach B S. 107–130]
]

// 4-24
#aufgabe(titel: "Rz nach ISO 4287 und Rt", art: "verstehen", quelle: "5.3")[
#if not web [*Aufgabe 110* #linebreak()]
Definiere Rz nach der im Buch erläuterten älteren ISO-4287-Auswertung und grenze es von Rt ab.
][
Rz = Rp + Rv innerhalb einer Einzelmessstrecke. Rz entspricht dem früheren Ry. Rz bezieht sich auf das Rauheitsprofil.

#src[L-alt C1, offene Überarbeitung Frage 24; B S. 107–130]
]

// 4-25
#aufgabe(titel: "Kreis im Oberflächensymbol", art: "verstehen", quelle: "5.4")[
#if not web [*Aufgabe 111* #linebreak()]
Was fordert ein Kreis zwischen den Schenkeln eines Oberflächensymbols?
][
Materialabtrag unzulässig. Oberfläche bleibt z. B. im Gusszustand.

#src[L-alt C1, offene Überarbeitung Frage 25; B S. 107–130]
]

// 4-26
#aufgabe(titel: "Ra 6,3 nach alter und neuer Norm", art: "verstehen", quelle: "5.5")[
#if not web [*Aufgabe 112* #linebreak()]
Wie wird eine einzelne Angabe Ra 6,3 nach der älteren ISO 1302 interpretiert, und warum muss die Normfassung beachtet werden?
][
Nach der älteren ISO 1302 ist 6,3 µm die obere Grenze und ohne Zusatz gilt die 16-%-Regel. Nach der im Buch beschriebenen ISO 21920-1 gilt ohne Zusatz dagegen Tmax; deshalb sind Normfassung und Zusatz gemeinsam zu lesen.

#src[L-alt C1, offene Überarbeitung Frage 26; B S. 107–130]
]

// 4-27
#aufgabe(titel: "Rillenrichtungen C, R, X und P", art: "verstehen", quelle: "5.5")[
#if not web [*Aufgabe 113* #linebreak()]
Erkläre die Rillenrichtungssymbole C, R, X und P.
][
C. R. P. X.

#src[L-alt C1, offene Überarbeitung Frage 27; B S. 107–130]
]

// 4-28
#aufgabe(titel: "Scharfkantige Außenkante", art: "verstehen", quelle: "5.9")[
#if not web [*Aufgabe 114* #linebreak()]
Welche Größenordnung nennt das Buch für eine scharfkantige Außenkante?
][
50 µm.

#src[L-alt C1, offene Überarbeitung Frage 28; B S. 107–130]
]

// 4-29
#aufgabe(titel: "Ra und Rz bei ±3 µm", art: "rechnen", quelle: "5.3",
  ergebnis: [Ra = 3 µm, Rz = 6 µm],
  tipp: [Wie beim Rechteckprofil mit ±1,5 µm, nur mit doppelter Höhe.],
)[
#if not web [*Aufgabe 115* #linebreak()]
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


#kapitel("Kapitel 6 · Toleranzen und Passungen")

// 5-1
#aufgabe(titel: "Unabhängigkeitsprinzip und ISO 8015", art: "verstehen", quelle: "6.1")[
#if not web [*Aufgabe 116* #linebreak()]
Was besagt das Unabhängigkeitsprinzip? Was gilt, wenn „Tolerierung ISO 8015“ am Schriftfeld steht, und was, wenn die Angabe fehlt?
][
Alle Maß-, Form- und Lagetoleranzen sind unabhängig voneinander einzuhalten. Der Hinweis „Tolerierung ISO 8015“ macht das ausdrücklich; früher war er zwingend, weil ohne ihn die Hüllbedingung galt. Heute gilt ISO 8015 auch ohne Hinweis, der Vermerk ist nur noch sinnvoll gegen Missverständnisse (S. 132, 135).

#src[L-alt C2, Frage 1; nach B S. 131–168]
]

// 5-2
#aufgabe(titel: "Hüllbedingung", art: "verstehen", quelle: "6.1")[
#if not web [*Aufgabe 117* #linebreak()]
Erkläre die Hüllbedingung. Warum ist sie teurer als das Unabhängigkeitsprinzip?
][
Die Oberfläche des einzelnen Größenmaßelements muss die ideale Hülle am Maximum-Material-Maß einhalten. Eine Lageforderung zu anderen Elementen ist damit nicht allgemein festgelegt. Bei gleicher Maßtoleranz bleibt für Formabweichungen nur der nicht genutzte Rest; das erfordert höhere Genauigkeit (S. 133–134).

#src[L-alt C2, Frage 2; nach B S. 131–168]
]

// 5-3
#aufgabe(titel: "Die Zeichen Ⓜ, Ⓛ und Ⓔ", art: "verstehen", quelle: "6.1")[
#if not web [*Aufgabe 118* #linebreak()]
Was bedeuten Ⓜ, Ⓛ und Ⓔ hinter einer Angabe (Buch 7.14)?
][
Ⓜ Maximum-Material-Bedingung (ungenutzte Maßtoleranz darf für Form/Lage genutzt werden); Ⓛ Minimum-Material-Bedingung (z. B. Mindestwanddicke); Ⓔ Hüllbedingung für dieses Maß (S. 134–135).

#src[L-alt C2, Frage 3; nach B S. 131–168]
]

// 5-4
#aufgabe(titel: "Maximum-Material-Maß", art: "verstehen", quelle: "6.1")[
#if not web [*Aufgabe 119* #linebreak()]
Was ist das Maximum-Material-Maß bei Welle und Bohrung?
][
Welle: Höchstmaß. Bohrung: Mindestmaß (S. 133).

#src[L-alt C2, Frage 4; nach B S. 131–168]
]

// 5-5
#aufgabe(titel: "Gutmaß, Ausschussmaß und Grenzrachenlehre", art: "verstehen", quelle: "6.2")[
#if not web [*Aufgabe 120* #linebreak()]
Definiere Gutmaß und Ausschussmaß. Wie prüft man eine Welle mit der Grenzrachenlehre?
][
Gutmaß: Grenzmaß, das beim Abtragen zuerst erreicht wird (= Maximum-Material-Maß). Ausschussmaß: das andere; darüber hinaus entsteht Ausschuss. Die Welle muss durch die Gutseite der Rachenlehre passen und darf nicht durch die Ausschussseite gleiten (S. 138).

#src[L-alt C2, Frage 5; nach B S. 131–168]
]

// 5-6
#aufgabe(titel: "Buchstabe und Zahl bei H7", art: "verstehen", quelle: "6.3")[
#if not web [*Aufgabe 121* #linebreak()]
Was definieren bei „H7“ der Buchstabe und die Zahl? Wann Groß-, wann Kleinbuchstaben?
][
Buchstabe: Lage des Toleranzfelds zur Null-Linie; Zahl: Toleranzgrad (Größe des Felds). Großbuchstaben für Bohrungen/Außenteile, Kleinbuchstaben für Wellen/Innenteile (S. 139).

#src[L-alt C2, Frage 6; nach B S. 131–168]
]

// 5-7
#aufgabe(titel: "Nicht verwendete Toleranzbuchstaben", art: "verstehen", quelle: "6.3")[
#if not web [*Aufgabe 122* #linebreak()]
Welche Buchstaben werden nicht verwendet und warum?
][
i, l, o, q, w bzw. I, L, O, Q, W, um Verwechslungen (z. B. mit 1 und 0) zu vermeiden (S. 139).

#src[L-alt C2, Frage 7; nach B S. 131–168]
]

// 5-8
#aufgabe(titel: "Toleranzgrade und Drehen", art: "verstehen", quelle: "6.3")[
#if not web [*Aufgabe 123* #linebreak()]
Welche Toleranzgrade gibt es, und welche sind mit Drehen erreichbar (Buch 7.20)?
][
IT01, IT0, IT1 bis IT18 (20 Grade). Drehen liegt in Tab. 7-2 bei den mittleren Toleranzgraden #strong[5 bis 11]; laut Text kommen für normale spanende Verfahren vorwiegend 5 bis 13 zum Einsatz (S. 141).

#src[L-alt C2, Frage 8; nach B S. 131–168]
]

// 5-9
#aufgabe(titel: "Allgemeintoleranz ISO 2768-mK", art: "verstehen", quelle: "6.4")[
#if not web [*Aufgabe 124* #linebreak()]
Was bedeutet „ISO 2768-mK“? Für welche Maße gelten Allgemeintoleranzen nicht?
][
Allgemeintoleranzen Klasse m (mittel) für Längen und Winkel nach 2768-1, Klasse K für Form und Lage nach 2768-2. Nicht für Hilfsmaße in Klammern und theoretisch genaue Maße im Rahmen (S. 146, 153).

#src[L-alt C2, Frage 9; nach B S. 131–168]
]

// 5-10
#aufgabe(titel: "Form- und Lagetoleranzen", art: "verstehen", quelle: "6.5")[
#if not web [*Aufgabe 125* #linebreak()]
Was unterscheidet Form- von Lagetoleranzen? Nenne je drei Beispiele mit Symbol.
][
Reine Formforderungen: beispielsweise Geradheit, Ebenheit und Rundheit. Bezogene Forderungen: beispielsweise Parallelität, Rechtwinkligkeit und Rundlauf. Die Originalsymbole zeigt die Vektorübersicht in Abschnitt 6.5 (S. 146–150).

#src[L-alt C2, Frage 10; nach B S. 131–168]
]

// 5-11
#aufgabe(titel: "Lage des Bezugspfeils", art: "verstehen", quelle: "6.5")[
#if not web [*Aufgabe 126* #linebreak()]
Wann setzt man den Bezugspfeil in die Verlängerung der Maßlinie, wann nicht?
][
In Verlängerung der Maßlinie, wenn eine Achse oder Mittelebene toleriert wird; nicht in Verlängerung, wenn eine Fläche oder Linie toleriert wird (S. 151).

#src[L-alt C2, Frage 11; nach B S. 131–168]
]

// 5-12
#aufgabe(titel: "Lauf und Gesamtlauf", art: "verstehen", quelle: "6.5")[
#if not web [*Aufgabe 127* #linebreak()]
Worin unterscheiden sich Lauf- und Gesamtlauftoleranz? Wann Rundlauf, wann Planlauf?
][
Lauf: Messung in einzelnen Messebenen (Rundlauf, radial) bzw. Messzylindern (Planlauf, axial). Gesamtlauf: zusätzlich wird die Messuhr axial (Mantel) bzw. radial (Planfläche) über die ganze Fläche verschoben. Rundlauf für Mantelflächen, Planlauf für Stirnflächen (S. 150).

#src[L-alt C2, Frage 12; nach B S. 131–168]
]

// 5-13
#aufgabe(titel: "Passung und Grenzpassung", art: "verstehen", quelle: "6.6")[
#if not web [*Aufgabe 128* #linebreak()]
Definiere „Passung“ und „Grenzpassung“.
][
Passung: Maßdifferenz von Innen- und Außenpassfläche vor dem Fügen. Grenzpassung: Passung, wenn beide Passflächen an ihren Grenzmaßen liegen (Höchst- und Mindestpassung) (S. 153–154).

#src[L-alt C2, Frage 13; nach B S. 131–168]
]

// 5-14
#aufgabe(titel: "Spiel, Übergang und Übermaß", art: "verstehen", quelle: "6.6")[
#if not web [*Aufgabe 129* #linebreak()]
Woran erkennt man Spiel-, Übergangs- und Übermaßpassung?
][
Spiel: P#sub[O] und P#sub[U] ≥ 0; Übergang: P#sub[O] \> 0, P#sub[U] \< 0; Übermaß: beide ≤ 0 bzw. \< 0. Im Toleranzfeldbild: Bohrungsfeld über, überlappend mit bzw. unter dem Wellenfeld (S. 156).

#src[L-alt C2, Frage 14; nach B S. 131–168]
]

// 5-15
#aufgabe(titel: "Warum die Einheitsbohrung bevorzugt wird", art: "verstehen", quelle: "6.7")[
#if not web [*Aufgabe 130* #linebreak()]
Warum wird die Einheitsbohrung bevorzugt? Warum lässt man nicht alle Kombinationen zu?
][
Eine einheitliche Bohrung mit verschiedenen Wellen ist fertigungstechnisch einfacher und billiger. Die Begrenzung der Kombinationen spart Werkzeuge und Lehren (S. 157, 161).

#src[L-alt C2, Frage 15; nach B S. 131–168]
]

// 5-16
#aufgabe(titel: "Passungen H7/r6 und H7/h6 bei Ø50", art: "rechnen", quelle: "6.6",
  ergebnis: [H7/r6: Übermaß 9 bis 50 µm, PT = 41 µm. H7/h6: Spiel 0 bis 41 µm, PT = 41 µm],
  tipp: [Höchstpassung = größte Bohrung minus kleinste Welle, Mindestpassung = kleinste Bohrung minus größte Welle.],
)[
#if not web [*Aufgabe 131* #linebreak()]
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

// 5-17
#aufgabe(titel: "Passungen und Pass-Systeme zuordnen", art: "verstehen", quelle: "6.7")[
#if not web [*Aufgabe 132* #linebreak()]
Ordne zu: Passungsart und Pass-System für H7/r6; H7/n6; H7/h6; H11/h11; F8/h9; H7/j6; H8/x8; J7/h6; H7/k6; S7/h6; A11/h11; H7/f7 (Buch 7.3).
][
*Modell / Annahmen:* Worst-Case-Grenzmaße; keine statistische Verteilung voraussetzen.

Übermaß: H7/r6 (EB), H8/x8 (EB), S7/h6 (EW). Übergang: H7/n6 (EB), H7/j6 (EB), H7/k6 (EB), J7/h6 (EW). Spiel: H7/h6 und H11/h11 (beide Systeme), F8/h9 (EW), A11/h11 (EW), H7/f7 (EB) (S. 140, 158–163).

*Prüfung:* Toleranzen sind nicht negativ, und PO ist mindestens so groß wie PU. Abmaße in µm vor Addition zu mm umrechnen.

#src[L-alt C2, Frage 17; nach B S. 131–168]
]

// 5-18
#aufgabe(titel: "Grenzabmaße aus Tabelle 7-3", art: "rechnen", quelle: "6.3",
  ergebnis: [Ø120 h6: 0/−22 µm; Ø119 H11: +220/0 µm; Ø5 E9: +50/+20 µm; Ø25 F8: +53/+20 µm],
  tipp: [Erst den Nennmaßbereich suchen, dann in der Spalte der Toleranzklasse ablesen. Großbuchstabe heißt Bohrung.],
)[
#if not web [*Aufgabe 133* #linebreak()]
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

// 5-19
#aufgabe(titel: "Toleranzklassen aus Grenzabmaßen finden", art: "rechnen", quelle: "6.3",
  ergebnis: [Ø40 H7/r6, Übermaßpassung (PO = −9 µm, PU = −50 µm)],
  tipp: [Eine Bohrung, die das Nennmaß nicht unterschreiten darf, hat das Feld H.],
)[
#if not web [*Aufgabe 134* #linebreak()]
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

// 5-20
#aufgabe(titel: "Grenzmaße nach ISO 2768-m", art: "rechnen", quelle: "6.4",
  ergebnis: [8 ± 0,2 → 7,8 bis 8,2 mm; 45 ± 0,3 → 44,7 bis 45,3 mm; 250 ± 0,5 → 249,5 bis 250,5 mm],
  tipp: [Allgemeintoleranzen hängen nur vom Nennmaßbereich ab und sind symmetrisch.],
)[
#if not web [*Aufgabe 135* #linebreak()]
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

// 5-21
#aufgabe(titel: "Passungen für Fügen mit und ohne Sicherung", art: "verstehen", quelle: "6.7")[
#if not web [*Aufgabe 136* #linebreak()]
Welche Passungen schlägst du vor, wenn a) nach dem Fügen keine Verdrehsicherung nötig sein soll, b) eine Sicherung nötig ist, c) von Hand gefügt werden soll (Buch 7.5)?
][
*Modell / Annahmen:* Worst-Case-Grenzmaße; keine statistische Verteilung voraussetzen.

a) Übermaß, z. B. H7/r6 oder H7/s6; b) Übergang, z. B. H7/n6 oder H7/k6; c) H7/js6 (Schiebesitz) oder H7/h6 (Gleitsitz) (Tab. 7-14).

*Prüfung:* Toleranzen sind nicht negativ, und PO ist mindestens so groß wie PU. Abmaße in µm vor Addition zu mm umrechnen.

#src[L-alt C2, Frage 21; nach B S. 131–168]
]

// 5-22
#aufgabe(titel: "Toleranzrahmen für einen Lagersitz", art: "verstehen", quelle: "6.5")[
#if not web [*Aufgabe 137* #linebreak()]
Schreibe die Toleranzrahmen: a) Lagersitz Zylinderform 5 µm, b) Lagersitz Koaxialität 5 µm zur gemeinsamen Achse A–B, c) Anlageschulter Planlauf 7 µm zur Achse A–B (vgl. Buch 7.31).
][
*Modell / Annahmen:* Worst-Case-Grenzmaße; keine statistische Verteilung voraussetzen.

0,005   ◎Ø0,005A–B   ↗0,007A–B (Werte in mm; Bezugsdreiecke A und B an den Lagersitzachsen; Planlauf mit Lauf-Symbol, Pfeil auf die Schulterfläche) (S. 147–152).

*Prüfung:* Toleranzen sind nicht negativ, und PO ist mindestens so groß wie PU. Abmaße in µm vor Addition zu mm umrechnen.

#src[L-alt C2, Frage 22; nach B S. 131–168]
]

// 5-23
#aufgabe(titel: "Mikrometer und Millimeter umrechnen", art: "rechnen", quelle: "6.2",
  ergebnis: [30 µm = 0,030 mm; 20 mm = 20 000 µm],
  tipp: [1 mm = 1000 µm.],
)[
#if not web [*Aufgabe 138* #linebreak()]
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

// 5-24
#aufgabe(titel: "Feld h und Einheitswelle", art: "verstehen", quelle: "6.3")[
#if not web [*Aufgabe 139* #linebreak()]
Erkläre das Feld h und das System Einheitswelle.
][
oberes Abmaß = 0. gilt für Wellen. ist die Grundlage der Einheitswelle.

#src[L-alt C2, offene Überarbeitung Frage 24; B S. 131–168]
]

// 5-25
#aufgabe(titel: "Passtoleranz herleiten", art: "verstehen", quelle: "6.6")[
#if not web [*Aufgabe 140* #linebreak()]
Leite die Passtoleranz aus Bohrungs- und Wellentoleranz her.
][
ist die Summe der Maßtoleranzen von Bohrung und Welle. ist PO − PU.

#src[L-alt C2, offene Überarbeitung Frage 25; B S. 131–168]
]

// 5-26
#aufgabe(titel: "Welche Toleranzen einen Bezug brauchen", art: "verstehen", quelle: "6.5")[
#if not web [*Aufgabe 141* #linebreak()]
Welche Bezüge benötigen Parallelität, Rundlauf und Position? Vergleiche mit Ebenheit und Rundheit.
][
Parallelität. Rundlauf. Position.

#src[L-alt C2, offene Überarbeitung Frage 26; B S. 131–168]
]

// 5-27
#aufgabe(titel: "Passungsart aus PO und PU", art: "rechnen", quelle: "6.6",
  ergebnis: [Übergangspassung, PT = 0,041 mm],
  tipp: [Schau nur auf die Vorzeichen: positiv heißt Spiel, negativ Übermaß.],
)[
#if not web [*Aufgabe 142* #linebreak()]
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

// 5-28
#aufgabe(titel: "Standard-Tolerierungsgrundsatz", art: "verstehen", quelle: "6.1")[
#if not web [*Aufgabe 143* #linebreak()]
Welcher Tolerierungsgrundsatz wird im Buch als Standard nach ISO 8015 erläutert?
][
das Unabhängigkeitsprinzip. DIN EN ISO 8015.

#src[L-alt C2, offene Überarbeitung Frage 28; B S. 131–168]
]

// 5-29
#aufgabe(titel: "Grenzmaße von Ø25 H7", art: "rechnen", quelle: "6.3",
  ergebnis: [25,000 bis 25,021 mm, T = 0,021 mm],
  tipp: [H beginnt genau am Nennmaß.],
)[
#if not web [*Aufgabe 144* #linebreak()]
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

// 5-30
#aufgabe(titel: "Passung Ø25 H7/s6", art: "rechnen", quelle: "6.6",
  ergebnis: [PO = −14 µm, PU = −48 µm, Übermaßpassung],
  tipp: [Höchstpassung: größte Bohrung gegen kleinste Welle.],
)[
#if not web [*Aufgabe 145* #linebreak()]
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

// 5-31
#aufgabe(titel: "Passung Ø60 H7/k6", art: "rechnen", quelle: "6.6",
  ergebnis: [PO = +28 µm, PU = −21 µm, Übergangspassung],
  tipp: [Erst die Abmaße für Ø60 aus der Tabelle, dann die beiden Grenzfälle.],
)[
#if not web [*Aufgabe 146* #linebreak()]
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

// 5-32
#aufgabe(titel: "Passung Ø100 H8/h11", art: "rechnen", quelle: "6.6",
  ergebnis: [PO = +274 µm, PU = 0, Spielpassung],
  tipp: [H und h berühren beide die Nulllinie, von entgegengesetzten Seiten.],
)[
#if not web [*Aufgabe 147* #linebreak()]
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

// 5-33
#aufgabe(titel: "Passung Ø12 F8/h6", art: "rechnen", quelle: "6.6",
  ergebnis: [PO = +54 µm, PU = +16 µm, Spielpassung im System Einheitswelle],
  tipp: [Ist die Welle h, gehört die Paarung zum System Einheitswelle.],
)[
#if not web [*Aufgabe 148* #linebreak()]
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

// 5-34
#aufgabe(titel: "H7 und Allgemeintoleranz auf einer Zeichnung", art: "rechnen", quelle: "6.4",
  ergebnis: [Ø40 H7: 40,000 bis 40,025 mm; 25: 24,8 bis 25,2 mm; IT7 z. B. durch Reiben, Schleifen, Feindrehen],
  tipp: [Ein Maß mit eigener Toleranz folgt Tabelle 7-3, eines ohne folgt der Allgemeintoleranz im Schriftfeld.],
)[
#if not web [*Aufgabe 149* #linebreak()]
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

// 5-35
#aufgabe(titel: "Welle Ø50 j6 prüfen", art: "rechnen", quelle: "6.3",
  ergebnis: [Gut, denn 49,995 ≤ 50,008 ≤ 50,011 mm; Istabmaß +8 µm],
  tipp: [Erst die Grenzmaße bilden, dann prüfen, ob das Istmaß dazwischen liegt.],
)[
#if not web [*Aufgabe 150* #linebreak()]
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

// 5-36
#aufgabe(titel: "Grenzmaße und Passungen aus der Altklausur", art: "rechnen", quelle: "6.6",
  ergebnis: [H7/h6: Spiel 0 bis 34 µm; H7/j6: Übergang −9 bis +25 µm; H7/r6: Übermaß 7 bis 41 µm],
  tipp: [Rechne alles in µm und setze erst am Ende auf mm um. Dieselbe Bohrung, drei verschiedene Wellen.],
)[
#if not web [*Aufgabe 151* #linebreak()]
*Gegeben und Annahmen*

Nennmaß 30 mm; Grenzabmaße aus AK 4, jeweils oberes/unteres Abmaß: H7 +21/0 µm; h6 0/−13 µm; j6 +9/−4 µm; r6 +41/+28 µm.

*Gesucht*

#enum(numbering: "a)",
[Berechne Grenzmaße und Toleranzen aller vier Elemente und anschließend die Grenzpassungen und Passungsarten H7/h6, H7/j6 und H7/r6.],
)
][
*Modell:* Worst-Case-Grenzen, alle Angaben zunächst in µm; keine statistische Verteilung. Die Bohrung bleibt H7, nur die Welle wechselt. So siehst du, wie allein die Lage des Wellenfelds die Passungsart bestimmt.
][
*Grenzmaße:* H7: 30,000 bis 30,021 mm, T = 0,021 mm. h6: 29,987 bis 30,000 mm, T = 0,013 mm. j6: 29,996 bis 30,009 mm, T = 0,013 mm. r6: 30,028 bis 30,041 mm, T = 0,013 mm.
][
*H7/h6:* $P_O = 21 - (-13) = 34 thin "µm"$, $P_U = 0 - 0 = 0$. *Spielpassung.*
][
*H7/j6:* $P_O = 21 - (-4) = 25 thin "µm"$, $P_U = 0 - 9 = -9 thin "µm"$. *Übergangspassung.*
][
*H7/r6:* $P_O = 21 - 28 = -7 thin "µm"$, $P_U = 0 - 41 = -41 thin "µm"$. *Übermaßpassung.*
][
*Prüfen:* Alle drei haben $P_T = 34 thin "µm" = 21 + 13$, denn die Toleranzen sind gleich, nur die Lage verschiebt sich. Die im Original verkürzte letzte Paarungsbezeichnung wird hier als Ø30 H7/r6 gelesen.
#src[AK 4, PDF-S. 8; Tabellenwerte sind in AK vorgegeben]
]


#kapitel("Kapitel 7 · Gewinde und Schraubenverbindungen")

// 6-1
#aufgabe(titel: "Breite und schmale Linien am Gewinde", art: "verstehen", quelle: "7.1")[
#if not web [*Aufgabe 152* #linebreak()]
Welche Durchmesser werden bei Außen- und Innengewinde breit, welche schmal gezeichnet? Nenne eine Eselsbrücke.
][
Bolzen: Nenn-Ø breit, Kern-Ø schmal. Mutter: Kern-Ø breit, Nenn-Ø schmal. Eselsbrücke (eigene Ergänzung): breit ist die Kante, die den Körper begrenzt und die du mit dem Messschieber greifen kannst (S. 169–170).

#src[L-alt D1, Frage 1; nach B S. 169–196]
]

// 6-2
#aufgabe(titel: "Gewinde in axialer Ansicht", art: "verstehen", quelle: "7.1")[
#if not web [*Aufgabe 153* #linebreak()]
Wie sieht ein Gewinde in axialer Ansicht aus, und warum nur ein ¾-Kreis?
][
Bolzen: Nenn-Ø voller breiter Kreis, Kern-Ø schmaler ¾-Kreis; Mutter umgekehrt. Die Kernlinie windet sich durch die Steigung nach unten und ist nur etwa über 270° sichtbar (S. 171).

#src[L-alt D1, Frage 2; nach B S. 169–196]
]

// 6-3
#aufgabe(titel: "Welches Gewinde Vorrang hat", art: "verstehen", quelle: "7.1")[
#if not web [*Aufgabe 154* #linebreak()]
Welches Gewinde hat bei verschraubten Teilen Vorrang? Was bedeutet das für die Schraffur?
][
Das Bolzengewinde. Seine Kanten werden breit gezeichnet, die Schraffur der Mutter endet an der Körperkante des Bolzens (S. 170–171).

#src[L-alt D1, Frage 3; nach B S. 169–196]
]

// 6-4
#aufgabe(titel: "Nutzbare Länge, Auslauf und Überhang", art: "verstehen", quelle: "7.2")[
#if not web [*Aufgabe 155* #linebreak()]
Was ist die nutzbare Gewindelänge, der Gewindeauslauf und der Grundlochüberhang?
][
Nutzbare Länge: Anlagefläche bis letzter voller Gang (Ende als breite Linie). Auslauf: herstellungsbedingter Rest mit kleiner werdenden Gängen, ca. 2,5 · P. Grundlochüberhang: zusätzliche Bohrtiefe bei Innengewinden für das Schneiden (S. 172–173).

#src[L-alt D1, Frage 4; nach B S. 169–196]
]

// 6-5
#aufgabe(titel: "Feingewinde und Regelgewinde", art: "verstehen", quelle: "7.3")[
#if not web [*Aufgabe 156* #linebreak()]
Wie unterscheidet sich ein Feingewinde vom Regelgewinde, und wie erkennt man es an der Bezeichnung (Buch 8.3)?
][
Kleinere Steigung, gleiches 60°-Profil. In der Bezeichnung steht die Steigung („M16 × 1,5“); fehlt sie, ist es Regelgewinde (S. 175–176).

#src[L-alt D1, Frage 5; nach B S. 169–196]
]

// 6-6
#aufgabe(titel: "Linksgewinde kennzeichnen", art: "verstehen", quelle: "7.3")[
#if not web [*Aufgabe 157* #linebreak()]
Wie kennzeichnet man ein Linksgewinde (Buch 8.4)?
][
Mit dem Zusatz „-LH“, z. B. „M16 – LH“ (S. 176).

#src[L-alt D1, Frage 6; nach B S. 169–196]
]

// 6-7
#aufgabe(titel: "Trapez-, Säge- und Rundgewinde", art: "verstehen", quelle: "7.3")[
#if not web [*Aufgabe 158* #linebreak()]
Wofür nimmt man Trapez-, Säge- und Rundgewinde? Warum muss man beim Trapezgewinde immer die Steigung angeben?
][
Trapez: Bewegungsgewinde in beide Richtungen (Leitspindeln, Schraubstöcke). Säge: Last nur in einer Richtung (Pressen). Rund: Stöße, Schmutz, Blech (Glühlampen). Beim Trapezgewinde gehören zu jedem Ø zwei oder drei Steigungen (S. 177–179).

#src[L-alt D1, Frage 7; nach B S. 169–196]
]

// 6-8
#aufgabe(titel: "Was 6g am Gewinde bedeutet", art: "verstehen", quelle: "7.3")[
#if not web [*Aufgabe 159* #linebreak()]
Was bedeutet „6g“ an einem Gewinde, und warum steht die Zahl vorn?
][
Toleranzgrad 6, Lage g für ein Außengewinde. Die Zahl steht vorn, damit man die Angabe nicht mit einer normalen Rundpassung verwechselt, deren Werte anders sind (S. 180).

#src[L-alt D1, Frage 8; nach B S. 169–196]
]

// 6-9
#aufgabe(titel: "Dehnschraube und Passschraube", art: "verstehen", quelle: "7.4")[
#if not web [*Aufgabe 160* #linebreak()]
Was ist eine Dehnschraube, was eine Passschraube?
][
Dehnschraube: Schaft auf ca. 90 % des Gewinde-Ø verjüngt, dehnt sich beim Anziehen und wirkt als Feder. Passschraube: Schaft mit Passdurchmesser zur Bohrung; sie hält und positioniert zugleich (S. 184).

#src[L-alt D1, Frage 9; nach B S. 169–196]
]

// 6-10
#aufgabe(titel: "Unterlegscheiben und Federringe", art: "verstehen", quelle: "7.5")[
#if not web [*Aufgabe 161* #linebreak()]
Können Unterlegscheiben zu den Sicherungselementen gezählt werden (Buch 8.6)? Wie bewertet das Buch Federringe?
][
Nein, eine Unterlegscheibe ist keine Sicherung gegen Aufdrehen (S. 187). Federringe gelten bei Fachleuten als unwirksame Sicherung, weil Versuche die Vorspannung nicht sicher nachweisen konnten (S. 188).

#src[L-alt D1, Frage 10; nach B S. 169–196]
]

// 6-11
#aufgabe(titel: "Federring darstellen", art: "verstehen", quelle: "7.5")[
#if not web [*Aufgabe 162* #linebreak()]
Wie stellt man einen Federring dar und warum nie geschnitten?
][
Im zusammengepressten Zustand, Schlitzseite nach vorn, Schlitzneigung richtig. Geschnitten sähe er wie eine einfache Unterlegscheibe aus (S. 188).

#src[L-alt D1, Frage 11; nach B S. 169–196]
]

// 6-12
#aufgabe(titel: "Warum Normteile nicht bemaßt werden", art: "verstehen", quelle: "7.6")[
#if not web [*Aufgabe 163* #linebreak()]
Warum werden Normteile nicht bemaßt?
][
Ihre Maße sind durch die Norm festgelegt; die Normbezeichnung in der Stückliste reicht für Bestellung und Montage (S. 192).

#src[L-alt D1, Frage 12; nach B S. 169–196]
]

// 6-13
#aufgabe(titel: "Gewindedurchmesser von M10", art: "rechnen", quelle: "7.3",
  ergebnis: [$d_2 approx "9,026" thin "mm"$, $D_1 approx "8,376" thin "mm"$, $d_3 approx "8,160" thin "mm"$],
  tipp: [Alle drei Durchmesser sind Nenndurchmesser minus Faktor mal Steigung.],
)[
#if not web [*Aufgabe 164* #linebreak()]
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

// 6-14
#aufgabe(titel: "Mehrgängiges Trapezgewinde Tr40 × 14 P7", art: "rechnen", quelle: "7.3",
  ergebnis: [Steigung 14 mm, Teilung 7 mm, zweigängig; 42 mm nach 3 Umdrehungen],
  tipp: [Die Zahl hinter × ist die Steigung, die hinter P die Teilung.],
)[
#if not web [*Aufgabe 165* #linebreak()]
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

// 6-15
#aufgabe(titel: "Normbezeichnung von Schraube und Mutter", art: "verstehen", quelle: "7.6")[
#if not web [*Aufgabe 166* #linebreak()]
Bilde die Normbezeichnung: Sechskantschraube nach DIN EN ISO 4014, M12 Linksgewinde, Nennlänge 50 mm, Festigkeitsklasse 10.8 (Buch 8.8). Dazu die Sechskantmutter ISO 4032, M12 links, Festigkeitsklasse 10 (Buch 8.9).
][
*Modell / Annahmen:* Theoretisches Gewindeprofil beziehungsweise im Buch angegebene Zeichenrichtwerte; keine Festigkeitsbemessung.

Sechskantschraube ISO 4014 – M12 – LH × 50 – 10.8; Sechskantmutter ISO 4032 – M12 – LH – 10 (Aufbau nach DIN 962, S. 192–193). Hinweis: In der Praxis üblich ist die Festigkeitsklasse 10.9 (Ergänzung).

*Prüfung:* Durchmesser und Steigung haben dieselbe Einheit; ein Kerndurchmesser bleibt kleiner als der Nenndurchmesser.

#src[L-alt D1, Frage 15; nach B S. 169–196]
]

// 6-16
#aufgabe(titel: "Einschraublänge in Aluminium und Grauguss", art: "verstehen", quelle: "7.4")[
#if not web [*Aufgabe 167* #linebreak()]
Eine Stiftschraube M16 wird in ein Aluminiumgehäuse geschraubt. Wie lang muss das Einschraubende mindestens sein? Und in Grauguss?
][
*Modell / Annahmen:* Theoretisches Gewindeprofil beziehungsweise im Buch angegebene Zeichenrichtwerte; keine Festigkeitsbemessung.

Aluminium: L ≥ 2 · d = 32 mm. Grauguss: L ≥ 1,25 · 16 = 20 mm (Bild 8-22, S. 184).

*Prüfung:* Durchmesser und Steigung haben dieselbe Einheit; ein Kerndurchmesser bleibt kleiner als der Nenndurchmesser.

#src[L-alt D1, Frage 16; nach B S. 169–196]
]

// 6-17
#aufgabe(titel: "Festigkeitsklasse 10.9", art: "rechnen", quelle: "7.6",
  ergebnis: [$R_m = 1000 thin "N/mm"^2$, $R_("p0,2") = 900 thin "N/mm"^2$],
  tipp: [Erste Zahl mal 100 gibt die Zugfestigkeit, die zweite Zahl ist das Streckgrenzenverhältnis in Zehnteln.],
)[
#if not web [*Aufgabe 168* #linebreak()]
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

// 6-18
#aufgabe(titel: "Gewindeauslauf bei M16 schätzen", art: "rechnen", quelle: "7.2",
  ergebnis: [$x approx "2,5" P = 5 thin "mm"$, gleich dem Normwert],
  tipp: [Die Faustregel nimmt ein Vielfaches der Steigung. M16 hat P = 2 mm.],
)[
#if not web [*Aufgabe 169* #linebreak()]
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

// 6-19
#aufgabe(titel: "Linien an der geschnittenen Gewindebohrung", art: "verstehen", quelle: "7.1")[
#if not web [*Aufgabe 170* #linebreak()]
Welche Linienbreiten und Schraffurgrenzen gelten bei einer geschnittenen Gewindebohrung?
][
geht die Schraffur bis zum Kerndurchmesser. ist der Nenndurchmesser eine schmale Linie.

#src[L-alt D1, offene Überarbeitung Frage 19; B S. 169–196]
]

// 6-20
#aufgabe(titel: "Feingewinde an der Bezeichnung erkennen", art: "verstehen", quelle: "7.3")[
#if not web [*Aufgabe 171* #linebreak()]
Woran erkennst Du M20 × 1,5 und M8 × 1 als Feingewinde?
][
M20 × 1,5. M8 × 1.

#src[L-alt D1, offene Überarbeitung Frage 20; B S. 169–196]
]

// 6-21
#aufgabe(titel: "Mittlere Gewindetoleranzklassen", art: "verstehen", quelle: "7.3")[
#if not web [*Aufgabe 172* #linebreak()]
Welche mittleren Gewindetoleranzklassen verwendet das Buch ohne nähere Angabe?
][
6H/6g. die Toleranzklasse „mittel“.

#src[L-alt D1, offene Überarbeitung Frage 21; B S. 169–196]
]

// 6-22
#aufgabe(titel: "Kronenmutter, Sicherungsblech, selbstsichernde Mutter", art: "verstehen", quelle: "7.5")[
#if not web [*Aufgabe 173* #linebreak()]
Wie verhindern Kronenmutter mit Splint, Sicherungsblech und selbstsichernde Mutter ein Losdrehen?
][
Kronenmutter mit Splint. Sicherungsblech mit umgebogenem Lappen. selbstsichernde Mutter.

#src[L-alt D1, offene Überarbeitung Frage 22; B S. 169–196]
]

// 6-23
#aufgabe(titel: "Gewindedurchmesser von M20", art: "rechnen", quelle: "7.3",
  ergebnis: [$d_2 approx "18,376" thin "mm"$, $d_3 approx "16,933" thin "mm"$],
  tipp: [Gleiche Faktoren wie bei M10, nur mit P = 2,5 mm.],
)[
#if not web [*Aufgabe 174* #linebreak()]
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

// 6-24
#aufgabe(titel: "Gewindedurchmesser von M12", art: "rechnen", quelle: "7.3",
  ergebnis: [$d_2 approx "10,863"$, $d_3 approx "9,853"$, $D_1 approx "10,106" thin "mm"$],
  tipp: [Erst die drei Abzüge Faktor mal P ausrechnen, dann von 12 mm abziehen.],
)[
#if not web [*Aufgabe 175* #linebreak()]
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

// 6-25
#aufgabe(titel: "Schraube M10 in Grauguss", art: "rechnen", quelle: "7.4",
  ergebnis: [a) 12,5 mm, b) $d_3 approx "8,160" thin "mm"$, c) die Linien des Außengewindes],
  tipp: [Weichere Werkstoffe brauchen längere Einschraubtiefen. In der Verschraubung hat der Bolzen Vorrang.],
)[
#if not web [*Aufgabe 176* #linebreak()]
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

// 6-26
#aufgabe(titel: "Sackloch-Schraubverbindung zeichnen", art: "verstehen", quelle: "7.1")[
#if not web [*Aufgabe 177* #linebreak()]
Zeichne die Sackloch-Schraubverbindung aus AK 3. Verwende M20, Durchgangsbohrung 24 mm, vorgegebenen Kern-/Grunddurchmesser 17 mm, Schraubenlänge 50 mm, nutzbare Außen- und Innengewindelänge je 45 mm und Sacklochtiefe 65 mm.
#bild("ak-schraubverbindung", [Originalausschnitt AK, PDF-S. 7; mit vorhandenen handschriftlichen Einträgen.], height: 100mm)
][
Eigene Lösung: 1. Lege die gemeinsame Achse sowie Trenn- und Auflageflächen der beiden Bauteile fest. Zeichne die Durchgangsbohrung Ø24 im oberen Teil. 2. Trage die Schraubenlänge 50 mm ab der Kopfauflage ab; davon sind 45 mm nutzbares Außengewinde, 5 mm bleiben Schaft/Übergangsbereich nach Aufgabenvorgabe. 3. Im unteren Teil: Innengewinde M20 mit 45 mm nutzbarer Länge und vorgegebenem Grunddurchmesser 17 mm; Sacklochtiefe 65 mm separat ab dessen Eintrittsfläche eintragen. 4. Schraube im Längsschnitt ungeschraffiert; Bolzenkontur hat im Eingriff Vorrang. Nachbarteile entgegengesetzt schraffieren, freies Innengewinde bis zur breiten Kernlinie schraffieren. 5. Gewindeende, Auslauf und Bohrspitze getrennt darstellen. Prüfung: 65 mm Sacklochtiefe sind nicht 65 mm nutzbares Gewinde. Die Klemmteildicke ist in der Aufgabenzeichnung geometrisch vorgegeben, aber nicht numerisch bemaßt; daraus keine zusätzliche Zahl erfinden. Ø17 ist der explizite Zeichenwert der AK und keine allgemeine Kernlochbohrerempfehlung für M20.

#src[AK 3, PDF-S. 7; eigene Lösung mit B S. 169–173]
]


#kapitel("Kapitel 8 · Elemente an Achsen und Wellen")

// 7-1
#aufgabe(titel: "Genormte Wellenenden", art: "verstehen", quelle: "8.1")[
#if not web [*Aufgabe 178* #linebreak()]
Warum sind Wellenenden genormt? Welche Toleranzklasse gilt für ein Wellenende Ø40 nach DIN 748?
][
Damit nicht jede Kupplung eine Sonderanfertigung ist: gestufte Durchmesser mit zugeordneten Längen. Ø40 liegt unter 50 mm, also k6 (S. 199).

#src[L-alt D2, Frage 1; nach B S. 197–220]
]

// 7-2
#aufgabe(titel: "Freistich am Wellenabsatz", art: "verstehen", quelle: "8.2")[
#if not web [*Aufgabe 179* #linebreak()]
Welche drei Forderungen treffen am Wellenabsatz aufeinander, und wie löst der Freistich das Problem (Buch 9.4)?
][
Anlage (kleiner Radius, r₁ \< r₂), Fertigung (Werkzeugauslauf für Schleifscheibe) und Festigkeit (großer Radius gegen Kerbwirkung). Der Freistich bietet einen definierten Auslauf mit genormtem Radius; ein einfacher kleiner Radius würde Auslauf und Festigkeit nicht erfüllen (S. 199–200).

#src[L-alt D2, Frage 2; nach B S. 197–220]
]

// 7-3
#aufgabe(titel: "Freistich Form E oder F", art: "verstehen", quelle: "8.2")[
#if not web [*Aufgabe 180* #linebreak()]
Wann genügt Freistich Form E, wann braucht man Form F (Buch 9.5)?
][
E: keine besonderen Anforderungen an die Planfläche. F: Zylinder und Planfläche werden beide weiterbearbeitet, etwa bei einer Lageranlageschulter (S. 200).

#src[L-alt D2, Frage 3; nach B S. 197–220]
]

// 7-4
#aufgabe(titel: "Oberfläche im Freistichgrund", art: "verstehen", quelle: "8.2")[
#if not web [*Aufgabe 181* #linebreak()]
Welche Oberfläche hat ein Freistichgrund ohne Angabe (Buch 9.8)?
][
Geschlichtet: Rz1max 25 bzw. Ra 3,2 (S. 201).

#src[L-alt D2, Frage 4; nach B S. 197–220]
]

// 7-5
#aufgabe(titel: "Wozu Zentrierbohrungen dienen", art: "verstehen", quelle: "8.3")[
#if not web [*Aufgabe 182* #linebreak()]
Wofür braucht man Zentrierbohrungen? Reicht eine (Buch 9.9)?
][
Für die Führung der Welle im Reitstock beim Drehen, damit sie sich unter Schnittkräften nicht verformt. Eine reicht ohne Umspannen; wird umgespannt, braucht man an beiden Seiten eine (S. 202).

#src[L-alt D2, Frage 5; nach B S. 197–220]
]

// 7-6
#aufgabe(titel: "Zentrierbohrung Form A, B und R", art: "verstehen", quelle: "8.3")[
#if not web [*Aufgabe 183* #linebreak()]
Nenne die Formen A, B und R mit je einem Vorteil (Buch 9.10).
][
A: einfach, günstig. B: Schutzsenkung schützt die Zentrierflächen. R: gewölbt, gleicht Lagefehler aus, kein Kantentragen (S. 203).

#src[L-alt D2, Frage 6; nach B S. 197–220]
]

// 7-7
#aufgabe(titel: "Zentrierbohrung am Fertigteil", art: "verstehen", quelle: "8.3")[
#if not web [*Aufgabe 184* #linebreak()]
Nenne Beispiele, wann eine Zentrierbohrung am Fertigteil bleiben darf und wann nicht (Buch 9.14).
][
Darf/muss bleiben: wenn die Welle später nachgeschliffen oder zwischen Spitzen geprüft wird, oder die Bohrung die Funktion nicht stört (Beispiele: eigene Ergänzung). Darf nicht bleiben: wenn sie die Funktion stört, z. B. an einer Stirnfläche, die als Anlage oder Dichtfläche dient; dann wird die Welle länger gefertigt und gekürzt (S. 205).

#src[L-alt D2, Frage 7; nach B S. 197–220]
]

// 7-8
#aufgabe(titel: "Gestufte Passfederquerschnitte und Längen", art: "verstehen", quelle: "8.4")[
#if not web [*Aufgabe 185* #linebreak()]
Warum hat nicht jeder Wellendurchmesser einen eigenen Passfederquerschnitt, und warum sind die Längen gestuft (Buch 9.16, 9.18)?
][
Gestufte Querschnitte und Normlängen reduzieren die Vielfalt: weniger Fräser, Lagerhaltung und Kosten; die Feder ist ein Katalogteil (S. 207; Begründung abgeleitet).

#src[L-alt D2, Frage 8; nach B S. 197–220]
]

// 7-9
#aufgabe(titel: "Passfeder Form A in Nut N2", art: "verstehen", quelle: "8.4")[
#if not web [*Aufgabe 186* #linebreak()]
Passt eine Passfeder Form A in eine Nut N2 (Buch 9.17)?
][
Nein, nicht sinnvoll: N2 entsteht mit dem Scheibenfräser und hat auslaufende Enden für geradstirnige Federn (Form B). Für Form A gehört die Nut N1 vom Schaftfräser (S. 207).

#src[L-alt D2, Frage 9; nach B S. 197–220]
]

// 7-10
#aufgabe(titel: "Passfeder, Vielnut und Polygon", art: "verstehen", quelle: "8.5")[
#if not web [*Aufgabe 187* #linebreak()]
Wodurch unterscheiden sich Passfeder, Vielnut und Polygonprofil beim übertragbaren Drehmoment?
][
Passfeder: kleine bis mittlere Momente. Vielnut: wesentlich größere. Polygon: höchstes Moment bei gleichem Durchmesser (S. 206, 210, 216).

#src[L-alt D2, Frage 10; nach B S. 197–220]
]

// 7-11
#aufgabe(titel: "Passfeder für 50 und 51 mm", art: "verstehen", quelle: "8.4")[
#if not web [*Aufgabe 188* #linebreak()]
Welcher Passfederquerschnitt gilt für d = 50 mm und für d = 51 mm? Gib jeweils t₁ und t₂ an (Buch 9.19).
][
*Modell / Annahmen:* Genormte Zeichen- und Einbaumaße aus den genannten Buchtabellen; keine Drehmomentbemessung.

d = 50 mm  (über 44 bis 50):  14 x 9    t1 = 5,5 +0,2   t2 = 3,8 +0,2
d = 51 mm  (über 50 bis 58):  16 x 10   t1 = 6,0 +0,2   t2 = 4,3 +0,2

*Prüfung:* Querschnitt und Normbezeichnung müssen zum Durchmesserbereich der Tabelle passen.

#src[L-alt D2, Frage 11; nach B S. 197–220]
]

// 7-12
#aufgabe(titel: "Passfedernut normgerecht bemaßen", art: "verstehen", quelle: "8.4")[
#if not web [*Aufgabe 189* #linebreak()]
Wie wird die Nut einer Welle Ø58 normgerecht bemaßt? Welche Angaben gehören in die Zeichnung (vgl. Buch 9.20)?
][
*Modell / Annahmen:* Genormte Zeichen- und Einbaumaße aus den genannten Buchtabellen; keine Drehmomentbemessung.

Ø58 liegt in „über 50 bis 58“: Passfeder 16 × 10. In die Zeichnung: Wellen-Ø mit Toleranz (z. B. k6), Nutbreite 16 P9, Nuttiefe t₁ = 6#super[+0,2] von der Wellenoberfläche zum Nutgrund, Nutlänge mit Toleranz, Lage der Nut; dazu ein Schnitt als zweite Ansicht (S. 208–209).

*Prüfung:* Querschnitt und Normbezeichnung müssen zum Durchmesserbereich der Tabelle passen.

#src[L-alt D2, Frage 12; nach B S. 197–220]
]

// 7-13
#aufgabe(titel: "Bezeichnung von Freistich, Zentrierbohrung, Passfeder", art: "verstehen", quelle: "8.2")[
#if not web [*Aufgabe 190* #linebreak()]
Bilde die Bezeichnungen: a) Freistich Form F mit r = 0,8 und t₁ = 0,3; b) Zentrierbohrung Form A, d = 4 mm, D₁ = 8,5 mm; c) Passfeder Form A 16 × 10, Länge 56 mm.
][
*Modell / Annahmen:* Genormte Zeichen- und Einbaumaße aus den genannten Buchtabellen; keine Drehmomentbemessung.

a) DIN 509 – F0,8 × 0,3; b) ISO 6411 – A 4/8,5; c) Passfeder DIN 6885 – A 16 × 10 × 56.

*Prüfung:* Querschnitt und Normbezeichnung müssen zum Durchmesserbereich der Tabelle passen.

#src[L-alt D2, Frage 13; nach B S. 197–220]
]

// 7-14
#aufgabe(titel: "Bezeichnung von Vielnut- und Kerbzahnprofil", art: "verstehen", quelle: "8.5")[
#if not web [*Aufgabe 191* #linebreak()]
Bilde die Bezeichnungen: a) Vielnut-#strong[Nabe] nach DIN ISO 14 mit 10 Keilen, d = 72 mm, D = 78 mm (Buch 9.21); b) Kerbzahn-#strong[Welle] DIN 5481 mit d₁ = 50, d₃ = 55 (Buch 9.22); c) Polygon P3G für eine #strong[Nabe] mit Nenngröße 35 mm (Buch 9.26).
][
*Modell / Annahmen:* Genormte Zeichen- und Einbaumaße aus den genannten Buchtabellen; keine Drehmomentbemessung.

a) DIN ISO 14 – N 10 × 72 × 78; b) DIN 5481 – W 50 × 55, die Länge wird separat angegeben; c) Profil DIN 32711 – B P3G 35 (S. 210, 215, 217).

*Prüfung:* Querschnitt und Normbezeichnung müssen zum Durchmesserbereich der Tabelle passen.

#src[L-alt D2, Frage 14; nach B S. 197–220]
]

// 7-15
#aufgabe(titel: "Radiale Überdeckung beim Kerbzahnprofil", art: "rechnen", quelle: "8.5",
  ergebnis: [ungefähr 1,75 mm],
  tipp: [Die Zähne überdecken sich im Bereich zwischen dem kleinsten Durchmesser der Nabenzähne und dem größten der Wellenzähne.],
)[
#if not web [*Aufgabe 192* #linebreak()]
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

// 7-16
#aufgabe(titel: "DIN 509 F0,8 × 0,3 entschlüsseln", art: "verstehen", quelle: "8.2")[
#if not web [*Aufgabe 193* #linebreak()]
Entschlüssele DIN 509 – F0,8 × 0,3.
][
Freistich Form F. Radius 0,8 mm. Tiefe 0,3 mm.

#src[L-alt D2, offene Überarbeitung Frage 16; B S. 197–220]
]

// 7-17
#aufgabe(titel: "Wie eine Passfeder trägt", art: "verstehen", quelle: "8.4")[
#if not web [*Aufgabe 194* #linebreak()]
Wie trägt eine Passfeder und welche Länge bezeichnet die Normbezeichnung der Form A?
][
trägt mit den Seitenflächen. der Form A wird mit Gesamtlänge bezeichnet.

#src[L-alt D2, offene Überarbeitung Frage 17; B S. 197–220]
]

// 7-18
#aufgabe(titel: "Polygonprofil statt Passfeder", art: "verstehen", quelle: "8.5")[
#if not web [*Aufgabe 195* #linebreak()]
Warum kann ein Polygonprofil eine günstige Alternative zu einer Passfeder sein?
][
Polygonprofil.

#src[L-alt D2, offene Überarbeitung Frage 18; B S. 197–220]
]

// 7-19
#aufgabe(titel: "Passfeder für eine Welle Ø48", art: "verstehen", quelle: "8.4")[
#if not web [*Aufgabe 196* #linebreak()]
Auf eine Welle Ø48 soll eine Passfeder Form A mit l = 40 mm. Wie lautet die Normbezeichnung? (Kapitel 8, Tab. 9-3, S. 208–209)
][
*Modell / Annahmen:* Genormte Zeichen- und Einbaumaße aus den genannten Buchtabellen; keine Drehmomentbemessung.

48 mm liegt in „über 44 bis 50“ → b × h = 14 × 9: Passfeder DIN 6885 – A 14 × 9 × 40 (S. 208–209).

*Prüfung:* Querschnitt und Normbezeichnung müssen zum Durchmesserbereich der Tabelle passen.

#src[L-alt S4; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

// 7-20
#aufgabe(titel: "Elemente an Wellenenden", art: "verstehen", quelle: "8.2")[
#if not web [*Aufgabe 197* #linebreak()]
Nenne fünf mögliche Elemente an Achsen- und Wellenenden. Erkläre anschließend Freistich und Zentrierbohrung.
][
Beispiele: Passfedernut, Sicherungsringnut, Gewinde, Zentrierbohrung und Wellenabsatz mit Freistich. Ein Freistich schafft Werkzeugauslauf und Anlagefreiheit. Eine Zentrierbohrung führt die Werkstückspitze bei der Fertigung zwischen Spitzen beziehungsweise mit Reitstock. Die Auswahl muss zur Funktion der konkreten Welle passen.

#src[AK 1e–1g, PDF-S. 3; B Buchkapitel 9–10]
]


#kapitel("Kapitel 9 · Sicherungselemente")

// 8-1
#aufgabe(titel: "Wozu axiale Sicherungen", art: "verstehen", quelle: "9.1")[
#if not web [*Aufgabe 198* #linebreak()]
Warum braucht man überhaupt axiale Sicherungen (Buch 10.1)?
][
Formschlüssige Welle-Nabe-Verbindungen übertragen keine Axialkräfte; Welle und Nabe könnten axial wandern. Ein Wellenbund stützt nur einseitig ab (S. 221).

#src[L-alt D3, Frage 1; nach B S. 221–230]
]

// 8-2
#aufgabe(titel: "Weitere axiale Sicherungen für Wälzlager", art: "verstehen", quelle: "9.1")[
#if not web [*Aufgabe 199* #linebreak()]
Welche weiteren Möglichkeiten gibt es, ein Wälzlager axial zu sichern (Buch 10.2)?
][
Z. B. Wellenschulter und Distanzhülse, Lagerdeckel am Gehäuse, Klemmhülse/Spannhülse, Endscheibe mit Schraube an der Stirnseite, Presssitz (Beispiele als Ergänzung; im Buch werden Sicherungsring und Nutmutter behandelt).

#src[L-alt D3, Frage 2; nach B S. 221–230]
]

// 8-3
#aufgabe(titel: "Warum der Sicherungsring nicht rund ist", art: "verstehen", quelle: "9.1")[
#if not web [*Aufgabe 200* #linebreak()]
Warum hat ein Sicherungsring im ungespannten Zustand keine Kreisform?
][
Weil seine radiale Breite zu den Enden hin abnimmt: Eingebaut verformt er sich dadurch rund und liegt mit gleichmäßiger Vorspannung in der Nut (S. 221).

#src[L-alt D3, Frage 3; nach B S. 221–230]
]

// 8-4
#aufgabe(titel: "Nutbreite größer als Ringdicke", art: "verstehen", quelle: "9.1")[
#if not web [*Aufgabe 201* #linebreak()]
Warum ist die Nut breiter als der Ring, und wann wird das ungünstig (Buch 10.4/10.5)?
][
Damit der Ring trotz Toleranzen sicher in die Nut passt. Ungünstig wird es, wenn das Bauteil spielfrei sitzen muss: Es klappert, z. B. bei wechselnden Axialkräften oder präzisen Lagerungen (S. 222).

#src[L-alt D3, Frage 4; nach B S. 221–230]
]

// 8-5
#aufgabe(titel: "Sicherungsringe an Wellenenden", art: "verstehen", quelle: "9.1")[
#if not web [*Aufgabe 202* #linebreak()]
Warum gehören Sicherungsringe möglichst an Wellenenden?
][
Die Nut mit kleinem Radius hat eine hohe Kerbwirkung; an den Enden ist die Biegebeanspruchung gering (S. 222).

#src[L-alt D3, Frage 5; nach B S. 221–230]
]

// 8-6
#aufgabe(titel: "Sicherungsring in der Gesamtzeichnung", art: "verstehen", quelle: "9.1")[
#if not web [*Aufgabe 203* #linebreak()]
Wie wird ein Sicherungsring in der Gesamtzeichnung dargestellt?
][
Immer geschnitten, breite Seite oben im Schnitt, offene Seite unten in Ansicht in die Schnittebene gedreht, mit Umlaufkanten der Nut (S. 223–224).

#src[L-alt D3, Frage 6; nach B S. 221–230]
]

// 8-7
#aufgabe(titel: "Vorrang des Muttergewindes bei der Nutmutter", art: "verstehen", quelle: "9.2")[
#if not web [*Aufgabe 204* #linebreak()]
Warum hat bei der Nutmutter ausnahmsweise das Muttergewinde Vorrang?
][
Weil die Welle dort eine Nut hat und der Schnitt der Mutter über diese Nut reicht (S. 228).

#src[L-alt D3, Frage 7; nach B S. 221–230]
]

// 8-8
#aufgabe(titel: "Wellennut für das Sicherungsblech", art: "verstehen", quelle: "9.2")[
#if not web [*Aufgabe 205* #linebreak()]
Warum reicht die Wellennut für das Sicherungsblech bis unter das Lager?
][
Damit immer das Lager die Verschraubung axial begrenzt, nicht das Nutende (S. 228).

#src[L-alt D3, Frage 8; nach B S. 221–230]
]

// 8-9
#aufgabe(titel: "Sicherungsring oder Nutmutter", art: "verstehen", quelle: "9.2")[
#if not web [*Aufgabe 206* #linebreak()]
Was spricht für einen Sicherungsring, was für eine Nutmutter (Buch 10.3)?
][
Sicherungsring: einfach, billig, wenig Bauraum, schnelle Montage. Nutmutter: spielfrei und nachstellbar, höhere Axialkräfte, z. B. für Festlager (S. 222, 227).

#src[L-alt D3, Frage 9; nach B S. 221–230]
]

// 8-10
#aufgabe(titel: "Axialspiel am Sicherungsring für d = 40 mm", art: "rechnen", quelle: "9.1",
  ergebnis: [kleinstes Spiel 0,10 mm, größtes 0,30 mm],
  tipp: [Größtes Spiel: breiteste Nut mit dünnstem Ring. Kleinstes Spiel: schmalste Nut mit dickstem Ring.],
)[
#if not web [*Aufgabe 207* #linebreak()]
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

// 8-11
#aufgabe(titel: "Nuttiefe und Ringbezeichnung für d = 45 mm", art: "rechnen", quelle: "9.1",
  ergebnis: [t = 1,25 mm; Sicherungsring DIN 471 – 45 × 1,75],
  tipp: [Die Nuttiefe ist die halbe Differenz von Wellen- und Nutgrunddurchmesser.],
)[
#if not web [*Aufgabe 208* #linebreak()]
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

// 8-12
#aufgabe(titel: "Nutmutter und Sicherungsblech für M50 × 1,5", art: "verstehen", quelle: "9.2")[
#if not web [*Aufgabe 209* #linebreak()]
Bilde die Bezeichnungen für Nutmutter und Sicherungsblech für ein Wellengewinde M50 × 1,5.
][
*Modell / Annahmen:* Axialspiel aus unabhängigen Grenzmaßen von Nut und Ring.

Nutmutter DIN 981 – M50 × 1,5; Sicherungsblech DIN 5406 – A 50 (Tab. 10-3).

*Prüfung:* Größtes Spiel: größte Nut minus kleinster Ring; kleinstes Spiel umgekehrt.

#src[L-alt D3, Frage 12; nach B S. 221–230]
]

// 8-13
#aufgabe(titel: "Sicherungsringe darstellen, Nachteile der Nut", art: "verstehen", quelle: "9.1")[
#if not web [*Aufgabe 210* #linebreak()]
Wie werden Sicherungsringe dargestellt, und welche Nachteile der Nut sind zu beachten?
][
werden in Gesamtzeichnungen geschnitten dargestellt. haben die breite Seite oben in der Zeichnung. verursachen eine hohe Kerbwirkung in der Welle.

#src[L-alt D3, offene Überarbeitung Frage 13; B S. 221–230]
]

// 8-14
#aufgabe(titel: "Kraftweg bei Nutmutter und Sicherungsblech", art: "verstehen", quelle: "9.2")[
#if not web [*Aufgabe 211* #linebreak()]
Erkläre den Kraft- und Sicherungsweg von Nutmutter und Sicherungsblech.
][
Das Blech wird im Vollschnitt dargestellt. Eine äußere Nase greift in eine Nut der Mutter.

#src[L-alt D3, offene Überarbeitung Frage 14; B S. 221–230]
]

// 8-15
#aufgabe(titel: "Axialspiel aus Ring- und Nutmaßen", art: "rechnen", quelle: "9.1",
  ergebnis: [0,15 bis 0,36 mm],
  tipp: [Kombiniere jeweils die extremen Grenzmaße.],
)[
#if not web [*Aufgabe 212* #linebreak()]
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

// 8-16
#aufgabe(titel: "Axialspiel bei s = 1,2 mm", art: "rechnen", quelle: "9.1",
  ergebnis: [0,10 bis 0,30 mm],
  tipp: [Erst aus den Abmaßen die Grenzmaße bilden.],
)[
#if not web [*Aufgabe 213* #linebreak()]
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


#kapitel("Kapitel 10 · Wälzlager und Lageranordnungen")

// 9-1
#aufgabe(titel: "Gleitlager und Wälzlager", art: "verstehen", quelle: "10.1")[
#if not web [*Aufgabe 214* #linebreak()]
Was ist der grundlegende Unterschied zwischen Gleit- und Wälzlagern (Buch 11.1)?
][
Gleitlager: direkte Gleitbewegung zwischen Welle und Lager (mit Schmierfilm). Wälzlager: Wälzkörper rollen zwischen den Ringen ab, Rollreibung statt Gleitreibung (S. 231).

#src[L-alt D4, Frage 1; nach B S. 231–248]
]

// 9-2
#aufgabe(titel: "Aufbau eines Wälzlagers und der Käfig", art: "verstehen", quelle: "10.1")[
#if not web [*Aufgabe 215* #linebreak()]
Aus welchen Elementen besteht ein Wälzlager, und was macht der Käfig (Buch 11.2, 11.5)?
][
Innenring, Außenring, Wälzkörper, Käfig. Der Käfig hält die Wälzkörper auf Abstand und verteilt sie gleichmäßig (S. 232).

#src[L-alt D4, Frage 2; nach B S. 231–248]
]

// 9-3
#aufgabe(titel: "Wälzlager im Schnitt", art: "verstehen", quelle: "10.2")[
#if not web [*Aufgabe 216* #linebreak()]
Welche Regeln gelten für die Schnittdarstellung eines Wälzlagers?
][
Immer im Schnitt; beide Ringe gleiche Schraffur; Wälzkörper ungeschnitten; Käfig meist nicht gezeichnet; Kantenradien immer darstellen (S. 234–235).

#src[L-alt D4, Frage 3; nach B S. 231–248]
]

// 9-4
#aufgabe(titel: "Schrägkugel-, Vierpunkt- und Pendelkugellager", art: "verstehen", quelle: "10.3")[
#if not web [*Aufgabe 217* #linebreak()]
Was kennzeichnet ein Schrägkugellager, ein Vierpunktlager und ein Pendelkugellager? Gibt es einreihige Pendelkugellager (Buch 11.10–11.12)?
][
Schrägkugellager: niedrige und hohe Schulter, α = 40°, hohe Axialkraft in einer Richtung. Vierpunktlager: zwei Kreisbögen je Rille, vier Berührpunkte, geteilter Innenring, beidseitig axial. Pendelkugellager: hohlkugelige Außenbahn, gleicht bis 4° aus, immer zweireihig, also kein einreihiges (S. 235–236).

#src[L-alt D4, Frage 4; nach B S. 231–248]
]

// 9-5
#aufgabe(titel: "Zylinderrollenlager mit Axialkraft", art: "verstehen", quelle: "10.3")[
#if not web [*Aufgabe 218* #linebreak()]
Welche Zylinderrollenlager-Bauart kann geringe Axialkräfte übertragen (Buch 11.14)?
][
NJ (eine Richtung) oder NUP (beide Richtungen), weil dort Borde an beiden Ringen die Rollen führen (S. 237–238).

#src[L-alt D4, Frage 5; nach B S. 231–248]
]

// 9-6
#aufgabe(titel: "Kegelrollenlager paarweise", art: "verstehen", quelle: "10.3")[
#if not web [*Aufgabe 219* #linebreak()]
Welche Kräfte kann ein Kegelrollenlager aufnehmen, und warum baut man es paarweise ein (Buch 11.16)?
][
Radial und axial hoch, axial aber nur in einer Richtung; deshalb paarweise spiegelbildlich, Spiel über Nutmutter einstellbar (S. 239).

#src[L-alt D4, Frage 6; nach B S. 231–248]
]

// 9-7
#aufgabe(titel: "Fest- und Loslageranordnung", art: "verstehen", quelle: "10.6")[
#if not web [*Aufgabe 220* #linebreak()]
Warum darf man keine Festlager-Festlager- und keine Loslager-Loslager-Anordnung bauen (Buch 11.22, 11.23)?
][
Fest-Fest: Wärmedehnung der Welle verspannt die Lager. Los-Los: Die Welle wäre axial nicht geführt und könnte wandern, Axialkräfte würden nicht aufgenommen (S. 244; zweiter Teil abgeleitet).

#src[L-alt D4, Frage 7; nach B S. 231–248]
]

// 9-8
#aufgabe(titel: "Punktlast und Umfangslast", art: "verstehen", quelle: "10.5")[
#if not web [*Aufgabe 221* #linebreak()]
Definiere Punktlast und Umfangslast. Welcher Ring bekommt den festen Sitz?
][
Punktlast: Kraft wirkt immer auf dieselbe Ringstelle. Umfangslast: Kraft läuft relativ zum Ring um. Der Ring mit Umfangslast bekommt den festen Sitz (S. 245).

#src[L-alt D4, Frage 8; nach B S. 231–248]
]

// 9-9
#aufgabe(titel: "Sicherung von Los- und Festlager", art: "verstehen", quelle: "10.6")[
#if not web [*Aufgabe 222* #linebreak()]
Warum sichert man das Loslager oft mit einem Sicherungsring, das Festlager mit Nutmutter und Sicherungsblech (Buch 11.30)?
][
Das Loslager muss nur einen Ring leicht halten, dafür reicht ein billiger Sicherungsring. Das Festlager nimmt alle Axialkräfte auf und soll spielfrei sitzen; das schafft nur die Nutmutter (S. 227, 243–244; abgeleitet).

#src[L-alt D4, Frage 9; nach B S. 231–248]
]

// 9-10
#aufgabe(titel: "Pendelrollenlager als Festlager", art: "verstehen", quelle: "10.3")[
#if not web [*Aufgabe 223* #linebreak()]
Kann ein Pendelrollenlager als Festlager eingesetzt werden (Buch 11.31)?
][
Ja, es nimmt hohe radiale und axiale Kräfte auf; dann werden beide Ringe beidseitig fixiert (S. 239; abgeleitet).

#src[L-alt D4, Frage 10; nach B S. 231–248]
]

// 9-11
#aufgabe(titel: "Kurzzeichen 6208 und 6006", art: "verstehen", quelle: "10.4")[
#if not web [*Aufgabe 224* #linebreak()]
Entschlüssele die Kurzzeichen 6208 und 6006 (Lagerart, Bohrungsdurchmesser).
][
*Modell / Annahmen:* Statische Lastzuordnung zum jeweiligen Ring; Zeichenproportionen ersetzen keine Katalogmaße.

6208: einreihiges Rillenkugellager, Durchmesserreihe 2, d = 40 mm (D = 80, B = 18). 6006: einreihiges Rillenkugellager, Durchmesserreihe 0, d = 06 · 5 = 30 mm (S. 241; Regel ×5 als Ergänzung).

*Prüfung:* Die Sitzwahl folgt der Relativbewegung zwischen Last und Ring; Zeichnungsmaße sind keine Belastbarkeitswerte.

#src[L-alt D4, Frage 11; nach B S. 231–248]
]

// 9-12
#aufgabe(titel: "Proportionen eines Rillenkugellagers", art: "rechnen", quelle: "10.2",
  ergebnis: [H = 12,5 mm, DW ≈ 6,25 mm, HR ≈ 4,2 mm, R ≈ 1,4 mm],
  tipp: [Alles hängt an der Ringhöhe H = (D − d)/2.],
)[
#if not web [*Aufgabe 225* #linebreak()]
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

// 9-13
#aufgabe(titel: "Toleranzen für Welle und Gehäuse wählen", art: "verstehen", quelle: "10.5")[
#if not web [*Aufgabe 226* #linebreak()]
Getriebewelle Ø50, Kugellager, normale Last und Laufgenauigkeit, Welle dreht, Kraft steht still. Welche Toleranzen wählst du für Welle und Gehäuse (vgl. Buch 11.28)?
][
*Modell / Annahmen:* Statische Lastzuordnung zum jeweiligen Ring; Zeichenproportionen ersetzen keine Katalogmaße.

Innenring Umfangslast: Welle #strong[k6] (Kugellager bis 100 mm, normale Last). Außenring Punktlast: Gehäuse #strong[H7] (Loslager leicht verschiebbar, normale Laufgenauigkeit) (Tab. 11-1, 11-2).

*Prüfung:* Die Sitzwahl folgt der Relativbewegung zwischen Last und Ring; Zeichnungsmaße sind keine Belastbarkeitswerte.

#src[L-alt D4, Frage 13; nach B S. 231–248]
]

// 9-14
#aufgabe(titel: "Rad auf stehender Achse", art: "verstehen", quelle: "10.5")[
#if not web [*Aufgabe 227* #linebreak()]
Ein Rad mit stehender Achse: Der Außenring (in der Radnabe) dreht sich, die Last kommt von oben. Wo liegt Umfangslast, wo Punktlast? Welcher Ring braucht den festen Sitz?
][
*Modell / Annahmen:* Statische Lastzuordnung zum jeweiligen Ring; Zeichenproportionen ersetzen keine Katalogmaße.

Die Last steht still, der Außenring dreht sich: Außenring #strong[Umfangslast] → fester Sitz in der Nabe. Innenring auf der stehenden Achse: #strong[Punktlast] → loser Sitz erlaubt (S. 245).

*Prüfung:* Die Sitzwahl folgt der Relativbewegung zwischen Last und Ring; Zeichnungsmaße sind keine Belastbarkeitswerte.

#src[L-alt D4, Frage 14; nach B S. 231–248]
]

// 9-15
#aufgabe(titel: "Lager für Axialkräfte in beide Richtungen", art: "verstehen", quelle: "10.3")[
#if not web [*Aufgabe 228* #linebreak()]
Nenne drei Lagerbauarten, die Axialkräfte in beiden Richtungen aufnehmen können.
][
Rillenkugellager. Vierpunktlager. zweiseitig wirkendes Axial-Rillenkugellager.

#src[L-alt D4, offene Überarbeitung Frage 15; B S. 231–248]
]

// 9-16
#aufgabe(titel: "Festlager axial festlegen", art: "verstehen", quelle: "10.6")[
#if not web [*Aufgabe 229* #linebreak()]
Wie werden beide Ringe eines Festlagers axial festgelegt?
][
Bei der klassischen Festlager-Loslager-Anordnung sind Innen- und Außenring des Festlagers axial beidseitig festgelegt. Dieses Lager führt die Welle axial und nimmt ihre Axialkräfte auf; das Loslager lässt den Längenausgleich zu.

#src[L-alt D4, offene Überarbeitung Frage 16; B S. 231–248]
]

// 9-17
#aufgabe(titel: "Ringe und Wälzkörper im Schnitt", art: "verstehen", quelle: "10.2")[
#if not web [*Aufgabe 230* #linebreak()]
Wie werden Ringe und Wälzkörper in der Schnittdarstellung unterschieden?
][
werden Innen- und Außenring gleich schraffiert. werden Wälzkörper nicht schraffiert.

#src[L-alt D4, offene Überarbeitung Frage 17; B S. 231–248]
]

// 9-18
#aufgabe(titel: "Zeichenmaße für Lager 6210", art: "rechnen", quelle: "10.2",
  ergebnis: [d = 50 mm, H = 20 mm, DW ≈ 10 mm, HR ≈ 6,7 mm, R ≈ 2,2 mm],
  tipp: [Die letzten beiden Ziffern mal 5 ergeben ab 04 den Bohrungsdurchmesser.],
)[
#if not web [*Aufgabe 231* #linebreak()]
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

// 9-19
#aufgabe(titel: "Laufrad auf stehender Achse", art: "verstehen", quelle: "10.5")[
#if not web [*Aufgabe 232* #linebreak()]
Ein Laufrad dreht sich mit seinem Wälzlager auf einer stehenden Achse; die Radlast zeigt immer nach unten. Welcher Lagerring hat Umfangslast, und welcher Ring braucht deshalb den festen Sitz?
][
*Modell / Annahmen:* Statische Lastzuordnung zum jeweiligen Ring; Zeichenproportionen ersetzen keine Katalogmaße.

Die Last steht still, der Außenring dreht sich mit dem Rad unter ihr hindurch: Umfangslast am Außenring → Außenring fest im Rad. Der Innenring steht mit der Achse zur Last still: Punktlast → loser Sitz erlaubt (Regel S. 245).

*Prüfung:* Die Sitzwahl folgt der Relativbewegung zwischen Last und Ring; Zeichnungsmaße sind keine Belastbarkeitswerte.

#src[L-alt A7; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

// 9-20
#aufgabe(titel: "Lager 6006 auf einer Getriebewelle", art: "verstehen", quelle: "10.5")[
#if not web [*Aufgabe 233* #linebreak()]
Eine Getriebewelle trägt ein Rillenkugellager 6006. Die Welle dreht, die Zahnkraft steht still.a) Welcher Wellendurchmesser gehört zum Lagersitz? b) Welche Sitzart braucht der Innenring, und welche Toleranzklasse aus Kapitel 10 passt? c) Gib die Grenzmaße dieses Wellensitzes an.
][
*Modell / Annahmen:* Statische Lastzuordnung zum jeweiligen Ring; Zeichenproportionen ersetzen keine Katalogmaße.

a) 6006 → d = 6 · 5 = 30 mm. b) Innenring hat Umfangslast → fester Sitz, z. B. k6 (Kapitel 10, S. 245). c) Ø30 liegt in „über 18 bis 30“: k6 = +15/+2 µm → 30,002 … 30,015 mm.

*Prüfung:* Die Sitzwahl folgt der Relativbewegung zwischen Last und Ring; Zeichnungsmaße sind keine Belastbarkeitswerte.

#src[L-alt G1; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]


#kapitel("Kapitel 11 · Dichtungen")

// 10-1
#aufgabe(titel: "Drei Gründe für Dichtungen", art: "verstehen", quelle: "11.1")[
#if not web [*Aufgabe 234* #linebreak()]
Nenne drei Gründe für den Einsatz von Dichtungen. (vgl. Buch 12.1)
][
Stoffverluste vermeiden (Gase, Flüssigkeiten), Vermischung verschiedener Betriebsstoffe verhindern, Verschleiß durch Schmutz, Staub und Feuchtigkeit vermeiden (S. 249).

#src[L-alt D5, Frage 1; nach B S. 249–258]
]

// 10-2
#aufgabe(titel: "Einteilung von Dichtungen", art: "verstehen", quelle: "11.1")[
#if not web [*Aufgabe 235* #linebreak()]
Nach welchen zwei Merkmalen teilt man Dichtungen ein, und welche Kombination gibt es nicht?
][
Ruhende oder bewegte Bauteile sowie berührend oder berührungsfrei. Berührungsfreie Dichtungen an ruhenden Teilen gibt es nicht (S. 249).

#src[L-alt D5, Frage 2; nach B S. 249–258]
]

// 10-3
#aufgabe(titel: "Wie eine statische Dichtung dichtet", art: "verstehen", quelle: "11.2")[
#if not web [*Aufgabe 236* #linebreak()]
Wie funktioniert eine statische Dichtung, und welche zwei Voraussetzungen braucht sie?
][
Die Rauheitsspitzen der Bauteilfläche betten sich in den Dichtungswerkstoff ein. Voraussetzungen: weicherer Dichtungswerkstoff und eine Anpresskraft durch Schrauben oder Betriebsdruck (S. 249–250).

#src[L-alt D5, Frage 3; nach B S. 249–258]
]

// 10-4
#aufgabe(titel: "Faltenbalg, statisch oder dynamisch", art: "verstehen", quelle: "11.2")[
#if not web [*Aufgabe 237* #linebreak()]
Gehört ein Faltenbalg zu den dynamischen Dichtungen, weil er bewegte Teile abdichtet? (Buch 12.6)
][
Nein. Der Faltenbalg ist eine statische, hermetische Dichtung; er kann wegen seiner Form trotzdem bewegte Teile abdichten (S. 250).

#src[L-alt D5, Frage 4; nach B S. 249–258]
]

// 10-5
#aufgabe(titel: "Schraffur von Dichtungen", art: "verstehen", quelle: "11.3")[
#if not web [*Aufgabe 238* #linebreak()]
Mit welcher Schraffur zeichnet man eine Elastomerdichtung, eine Kupferdichtung und eine sehr dünne Flachdichtung? Was muss dann zusätzlich passieren?
][
Elastomer: Kreuzschraffur. Kupfer: 45°-Schraffur (oder NE-Metall-Schraffur, wenn der Werkstoff betont werden soll). Sehr dünn: geschwärzt. Dann muss der Werkstoff in der Stückliste stehen (S. 250).

#src[L-alt D5, Frage 5; nach B S. 249–258]
]

// 10-6
#aufgabe(titel: "Eingebauter O-Ring und Filzring", art: "verstehen", quelle: "11.4")[
#if not web [*Aufgabe 239* #linebreak()]
Was ist beim Zeichnen eines eingebauten O-Rings und eines eingebauten Filzrings zu beachten? (Buch 12.5)
][
O-Ring: verformt zeichnen, weil die Verformung die Anpresskraft erzeugt (S. 252). Filzring: zusammengedrückt in der konischen Nut, mit Abstand zum Nutgrund (S. 254).

#src[L-alt D5, Frage 6; nach B S. 249–258]
]

// 10-7
#aufgabe(titel: "Drei Teile eines RWDR", art: "verstehen", quelle: "11.6")[
#if not web [*Aufgabe 240* #linebreak()]
Aus welchen drei Teilen besteht ein RWDR, und wie wird jedes Teil im Schnitt dargestellt?
][
Kunststoffkörper mit Lippe (geschwärzt), Versteifungsring aus Metall (schraffiert), Feder (zwei kleine konzentrische Kreise) (S. 252–253).

#src[L-alt D5, Frage 7; nach B S. 249–258]
]

// 10-8
#aufgabe(titel: "Geringer Leckverlust beim RWDR", art: "verstehen", quelle: "11.5")[
#if not web [*Aufgabe 241* #linebreak()]
Warum hat ein RWDR einen geringen Leckverlust, obwohl er berührend dichtet?
][
An der Gleitfläche muss ein Schmierfilm des Mediums vorhanden sein, sonst verschleißt die Lippe schnell. Dieser Film führt langfristig zu geringer Leckage (S. 252).

#src[L-alt D5, Frage 8; nach B S. 249–258]
]

// 10-9
#aufgabe(titel: "Untere Rauheitsgrenze unter dem RWDR", art: "verstehen", quelle: "11.6")[
#if not web [*Aufgabe 242* #linebreak()]
Warum wird für die Welle unter einem RWDR auch eine #strong[untere] Rauheitsgrenze angegeben?
][
Eine zu glatte Welle lässt die Dichtlippe heiß laufen (S. 254).

#src[L-alt D5, Frage 9; nach B S. 249–258]
]

// 10-10
#aufgabe(titel: "Federnde Abdeckscheiben", art: "verstehen", quelle: "11.7")[
#if not web [*Aufgabe 243* #linebreak()]
Wofür werden federnde Abdeckscheiben verwendet, und wie werden sie gezeichnet?
][
Zur Abdichtung von Wälzlagern bei Fettschmierung. Sie sind aus Metall, aber so dünn, dass sie geschwärzt gezeichnet werden (S. 254–255).

#src[L-alt D5, Frage 10; nach B S. 249–258]
]

// 10-11
#aufgabe(titel: "Herstellerbezeichnung bei Stopfbuchsen", art: "verstehen", quelle: "11.8")[
#if not web [*Aufgabe 244* #linebreak()]
Warum muss bei einer Stopfbuchsenpackung die Herstellerbezeichnung in der Stückliste stehen?
][
Stopfbuchsen werden wegen ihrer Vielfalt meist nicht im Detail gezeichnet, die Zeichnung allein reicht also nicht zur Bestellung (S. 256).

#src[L-alt D5, Frage 11; nach B S. 249–258]
]

// 10-12
#aufgabe(titel: "Schutzdichtung und Strömungsdichtung", art: "verstehen", quelle: "11.9")[
#if not web [*Aufgabe 245* #linebreak()]
Was ist der Unterschied zwischen Schutz- und Strömungsdichtungen? (Buch 12.16)
][
Strömungsdichtungen werden bei einem Druckunterschied zwischen innen und außen gebraucht und bremsen das Medium z. B. durch ein Labyrinth ab; sie haben immer eine Leckmenge. Schutzdichtungen schützen vor Schmutz ohne nennenswerten Druckunterschied (S. 256–257; Schutzfunktion abgeleitet).

#src[L-alt D5, Frage 12; nach B S. 249–258]
]

// 10-13
#aufgabe(titel: "Dichtung vereinfacht darstellen", art: "verstehen", quelle: "11.10")[
#if not web [*Aufgabe 246* #linebreak()]
Wann darf eine Dichtung vereinfacht nach DIN ISO 9222 dargestellt werden?
][
Wenn alle Funktionen klar sind und die Dichtung von untergeordneter Bedeutung ist; sonst immer ausführlich (S. 257).

#src[L-alt D5, Frage 13; nach B S. 249–258]
]

// 10-14
#aufgabe(titel: "O-Ring-Bezeichnung entschlüsseln", art: "verstehen", quelle: "11.4")[
#if not web [*Aufgabe 247* #linebreak()]
Erkläre jedes Glied der Bezeichnung „O-Ring DIN 3771 – 13,2 x 1,8 – N – NBR70“.
][
*Modell / Annahmen:* Im Buch beschriebener Einbaufall; Tabellenwerte gelten für die bezeichnete Dichtung und Nut.

DIN 3771 = Norm, 13,2 = Innendurchmesser d1, 1,8 = Schnurstärke d2, N = Sortenmerkmal, NBR70 = Werkstoff mit Härte (S. 251; Bedeutung von N/NBR70 als Ergänzung).

*Prüfung:* Einbauraum, Toleranz und Oberflächenforderung müssen zur betreffenden Dichtung passen.

#src[L-alt D5, Frage 14; nach B S. 249–258]
]

// 10-15
#aufgabe(titel: "Nut für O-Ring mit d2 = 6 mm", art: "verstehen", quelle: "11.4")[
#if not web [*Aufgabe 248* #linebreak()]
Ein O-Ring mit d2 = 6 mm soll radial verformt in eine Rechtecknut. Welche Nuttiefe T und Nutbreite B gibst du an, und wie lautet die Breitenangabe mit Toleranz?
][
*Modell / Annahmen:* Im Buch beschriebener Einbaufall; Tabellenwerte gelten für die bezeichnete Dichtung und Nut.

Tab. 12-1, d2 = 6 mm:  T = 4,95 mm,  B = 7,8 mm
Breitenangabe nach Bild 12-3:  7,8 +0,2

*Prüfung:* Einbauraum, Toleranz und Oberflächenforderung müssen zur betreffenden Dichtung passen.

#src[L-alt D5, Frage 15; nach B S. 249–258]
]

// 10-16
#aufgabe(titel: "RWDR für Welle Ø30 bezeichnen", art: "verstehen", quelle: "11.6")[
#if not web [*Aufgabe 249* #linebreak()]
Bezeichne einen RWDR Form A für eine Welle Ø 30 mm, Gehäusebohrung Ø 47 mm, Breite 7 mm, Elastomer NB.
][
*Modell / Annahmen:* Im Buch beschriebener Einbaufall; Tabellenwerte gelten für die bezeichnete Dichtung und Nut.

Wellendichtring DIN 3760 – A 30 x 47 x 7 NB (Schema S. 254).

*Prüfung:* Einbauraum, Toleranz und Oberflächenforderung müssen zur betreffenden Dichtung passen.

#src[L-alt D5, Frage 16; nach B S. 249–258]
]

// 10-17
#aufgabe(titel: "Angaben an Welle und Bohrung für den RWDR", art: "verstehen", quelle: "11.6")[
#if not web [*Aufgabe 250* #linebreak()]
Der RWDR aus „RWDR für Welle Ø30 bezeichnen“ wird mit der Dichtlippe voran über das Wellenende geschoben. Liste alle Angaben auf, die du an Welle und Gehäusebohrung einträgst. (vgl. Buch 12.10)
][
*Modell / Annahmen:* Im Buch beschriebener Einbaufall; Tabellenwerte gelten für die bezeichnete Dichtung und Nut.

Welle: Fase 15° bis 25°, Kante gerundet und poliert, Ø30 h11, drallfrei geschliffen (Rundheit IT 8), Ra 0,2 bis 0,8 µm als obere und untere Grenze. Bohrung: Ø47 H8, Einführfase 5° bis 10°, Rmax ≤ 25 µm (S. 253–254).

*Prüfung:* Einbauraum, Toleranz und Oberflächenforderung müssen zur betreffenden Dichtung passen.

#src[L-alt D5, Frage 17; nach B S. 249–258]
]

// 10-18
#aufgabe(titel: "Filzring für Welle Ø50 bezeichnen", art: "verstehen", quelle: "11.7")[
#if not web [*Aufgabe 251* #linebreak()]
Bezeichne einen Filzring für eine Welle Ø 50 mm mit Filzhärte M5.
][
*Modell / Annahmen:* Im Buch beschriebener Einbaufall; Tabellenwerte gelten für die bezeichnete Dichtung und Nut.

Filzring DIN 5419 – 50 – M5 (S. 254).

*Prüfung:* Einbauraum, Toleranz und Oberflächenforderung müssen zur betreffenden Dichtung passen.

#src[L-alt D5, Frage 18; nach B S. 249–258]
]

// 10-19
#aufgabe(titel: "Dichtlippe eines RWDR schützen", art: "verstehen", quelle: "11.6")[
#if not web [*Aufgabe 252* #linebreak()]
Welche Montage- und Anschlussanforderungen schützen die Dichtlippe eines RWDR?
][
Die Feder wird als zwei kleine konzentrische Kreise gezeichnet. Bei Montage mit der Lippe nach hinten genügt an der Welle R ≥ 1 mm.

#src[L-alt D5, offene Überarbeitung Frage 19; B S. 249–258]
]

// 10-20
#aufgabe(titel: "Berührungsfreie Dichtungen", art: "verstehen", quelle: "11.9")[
#if not web [*Aufgabe 253* #linebreak()]
Warum eignen sich berührungsfreie Dichtungen für hohe Drehzahlen und weshalb sind sie nicht pauschal leckfrei?
][
sind praktisch verschleißfrei. eignen sich für hohe Drehzahlen. werden als Schutzdichtung aus Stahl mit 45°-Schraffur gezeichnet.

#src[L-alt D5, offene Überarbeitung Frage 20; B S. 249–258]
]

// 10-21
#aufgabe(titel: "Rechteck mit Diagonalkreuz", art: "verstehen", quelle: "11.10")[
#if not web [*Aufgabe 254* #linebreak()]
Wie liest Du die vereinfachte Dichtungsdarstellung mit Rechteck und Diagonalkreuz?
][
stammt aus DIN ISO 9222-1. wird in breiter Volllinie gezeichnet. kann durch einen Pfeil für die Dichtungsrichtung ergänzt werden.

#src[L-alt D5, offene Überarbeitung Frage 21; B S. 249–258]
]

// 10-22
#aufgabe(titel: "Nut für O-Ring mit d2 = 2 mm", art: "verstehen", quelle: "11.4")[
#if not web [*Aufgabe 255* #linebreak()]
Ein O-Ring mit d2 = 2 mm wird radial verformt eingebaut. Welche Nuttiefe und welche Nutbreite trägst du ein? (Kapitel 11, Tab. 12-1, S. 252)
][
*Modell / Annahmen:* Im Buch beschriebener Einbaufall; Tabellenwerte gelten für die bezeichnete Dichtung und Nut.

T = 1,5 mm, B = 2,6 mm, Eintrag der Breite mit 2,6 +0,2 (S. 251–252).

*Prüfung:* Einbauraum, Toleranz und Oberflächenforderung müssen zur betreffenden Dichtung passen.

#src[L-alt S6; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

// 10-23
#aufgabe(titel: "RWDR für Welle Ø40 bezeichnen", art: "verstehen", quelle: "11.6")[
#if not web [*Aufgabe 256* #linebreak()]
Bilde die Normbezeichnung eines Radial-Wellendichtrings Form A für Welle Ø40, Gehäuse Ø62, Breite 8 mm, Elastomer NB.
][
*Modell / Annahmen:* Im Buch beschriebener Einbaufall; Tabellenwerte gelten für die bezeichnete Dichtung und Nut.

Wellendichtring DIN 3760 – A 40 x 62 x 8 NB (Schema S. 254).

*Prüfung:* Einbauraum, Toleranz und Oberflächenforderung müssen zur betreffenden Dichtung passen.

#src[L-alt A8; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

// 10-24
#aufgabe(titel: "Welle Ø40 h11 unter dem RWDR", art: "rechnen", quelle: "11.6",
  ergebnis: [39,840 bis 40,000 mm; Rauheit als Ra 0,8 oben und Ra 0,2 unten im Symbol],
  tipp: [Unter einer Dichtlippe darf die Welle weder zu rau noch zu glatt sein.],
)[
#if not web [*Aufgabe 257* #linebreak()]
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


#kapitel("Kapitel 12 · Zahnräder")

// 11-1
#aufgabe(titel: "Einteilung der Zahnradgetriebe", art: "verstehen", quelle: "12.1")[
#if not web [*Aufgabe 258* #linebreak()]
Nach welchen zwei Merkmalen werden Zahnradgetriebe eingeteilt? Ordne Stirnrad-, Kegelrad- und Schneckengetriebe zu. (Buch 13.1)
][
Grobgestalt der Räder und Lage der Wellen. Parallel: Stirnrad; schneidend: Kegelrad; kreuzend: Schnecke, Schraubrad, Hypoid (S. 259–260).

#src[L-alt D6, Frage 1; nach B S. 259–268]
]

// 11-2
#aufgabe(titel: "Modul und kämmende Räder", art: "verstehen", quelle: "12.2")[
#if not web [*Aufgabe 259* #linebreak()]
Wie ist der Modul definiert, und warum müssen zwei kämmende Räder denselben Modul haben?
][
m = d/z. Beide Verzahnungen müssen von gleicher Art sein, sonst passen Teilung und Zahnform nicht zusammen (S. 260).

#src[L-alt D6, Frage 2; nach B S. 259–268]
]

// 11-3
#aufgabe(titel: "Keine vereinfachte Zahnraddarstellung", art: "verstehen", quelle: "12.3")[
#if not web [*Aufgabe 260* #linebreak()]
Warum gibt es für Zahnräder keine eigene „vereinfachte Darstellung“?
][
Die normgerechte Darstellung ist bereits symbolisch und damit vereinfacht; eine ausführliche Darstellung wäre eher nicht normgerecht (S. 259).

#src[L-alt D6, Frage 3; nach B S. 259–268]
]

// 11-4
#aufgabe(titel: "Zahnrad in der Ansicht erkennen", art: "verstehen", quelle: "12.3")[
#if not web [*Aufgabe 261* #linebreak()]
Woran erkennt man in einer Ansicht, dass eine Scheibe ein Zahnrad ist?
][
Nur an der strichpunktierten Teilkreislinie (S. 262).

#src[L-alt D6, Frage 4; nach B S. 259–268]
]

// 11-5
#aufgabe(titel: "Kopf-, Teil- und Fußkreis zeichnen", art: "verstehen", quelle: "12.3")[
#if not web [*Aufgabe 262* #linebreak()]
Mit welchen Linienarten werden Kopfkreis, Teilkreis und Fußkreis in der Ansicht gezeichnet?
][
Kopfkreis: breite Volllinie (Körperkante); Teilkreis: schmale Strichpunktlinie; Fußkreis: schmale Volllinie, nur bei Bedarf (S. 261–262).

#src[L-alt D6, Frage 5; nach B S. 259–268]
]

// 11-6
#aufgabe(titel: "Zähne im Achsschnitt", art: "verstehen", quelle: "12.3")[
#if not web [*Aufgabe 263* #linebreak()]
Wie werden die Zähne im Achsschnitt dargestellt, und wo endet die Schraffur?
][
Ungeschnitten; die Schraffur endet an der Fußlinie (S. 261).

#src[L-alt D6, Frage 6; nach B S. 259–268]
]

// 11-7
#aufgabe(titel: "Zähne im Vollschnitt bei z = 25", art: "verstehen", quelle: "12.3")[
#if not web [*Aufgabe 264* #linebreak()]
Wie viele Zähne zeichnet man im Vollschnitt eines Rads mit z = 25?
][
Zwei gegenüberliegende Zähne, auch bei ungerader Zähnezahl (S. 261).

#src[L-alt D6, Frage 7; nach B S. 259–268]
]

// 11-8
#aufgabe(titel: "Schrägverzahnung andeuten", art: "verstehen", quelle: "12.3")[
#if not web [*Aufgabe 265* #linebreak()]
Wie kann man eine Schrägverzahnung in der Zeichnung andeuten? Ist das Pflicht?
][
Durch drei schmale Volllinien in Form und Richtung der Zähne in einer achsparallelen Ansicht. Nicht Pflicht, aber die Steigung muss in den Fertigungsunterlagen stehen (S. 262).

#src[L-alt D6, Frage 8; nach B S. 259–268]
]

// 11-9
#aufgabe(titel: "Welches Rad vorne liegt", art: "verstehen", quelle: "12.4")[
#if not web [*Aufgabe 266* #linebreak()]
Welches Rad liegt „vorne“ bei: Stirnradpaar, Kegelradpaar, Schneckengetriebe? (Buch 13.6)
][
Stirnradpaar: Ritzel. Kegelradpaar: Ritzel vor Tellerrad. Schneckengetriebe: Schnecke (S. 262, 264, 265).

#src[L-alt D6, Frage 9; nach B S. 259–268]
]

// 11-10
#aufgabe(titel: "Teilkreis beim Kegelrad", art: "verstehen", quelle: "12.4")[
#if not web [*Aufgabe 267* #linebreak()]
Welchen Teilkreisdurchmesser zeichnet man beim Kegelrad, und warum?
][
Den mittleren Teilkreisdurchmesser, weil die Kegelräder damit berechnet werden (S. 264).

#src[L-alt D6, Frage 10; nach B S. 259–268]
]

// 11-11
#aufgabe(titel: "Verzahnungsqualität 1 bis 12", art: "verstehen", quelle: "12.5")[
#if not web [*Aufgabe 268* #linebreak()]
Was bedeutet Verzahnungsqualität 1 bzw. 12, und welche Qualitäten sind üblich?
][
1 = höchste, kaum herstellbare Genauigkeit; 12 = gröbste. Üblich sind 5 bis 8 (S. 265).

#src[L-alt D6, Frage 11; nach B S. 259–268]
]

// 11-12
#aufgabe(titel: "Getriebe-Passsystem DIN 3967", art: "verstehen", quelle: "12.5")[
#if not web [*Aufgabe 269* #linebreak()]
Wozu dient das Getriebe-Passsystem nach DIN 3967?
][
Es legt über Zahndickenabmaße das Flankenspiel des montierten Radpaars fest: nicht zu klein (Wärmedehnung), nicht zu groß (Stöße bei Lastwechsel) (S. 266).

#src[L-alt D6, Frage 12; nach B S. 259–268]
]

// 11-13
#aufgabe(titel: "Oberflächensymbol an der Zahnflanke", art: "verstehen", quelle: "12.6")[
#if not web [*Aufgabe 270* #linebreak()]
Wo wird das Oberflächensymbol für die Zahnflanken angetragen?
][
Auf die Strichpunktlinie des Teilkreises (S. 267).

#src[L-alt D6, Frage 13; nach B S. 259–268]
]

// 11-14
#aufgabe(titel: "Modul und Kopfkreis aus d und z", art: "rechnen", quelle: "12.2",
  ergebnis: [m = 3 mm, ha = 3 mm, da = 126 mm],
  tipp: [Der Modul ist Teilkreisdurchmesser geteilt durch Zähnezahl.],
)[
#if not web [*Aufgabe 271* #linebreak()]
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

// 11-15
#aufgabe(titel: "Maße eines Radpaars mit m = 2,5 mm", art: "rechnen", quelle: "12.2",
  ergebnis: [d1 = 45 mm, d2 = 135 mm, da1 = 50 mm, df1 = 38,75 mm, a = 90 mm],
  tipp: [Teilkreis $d = m z$; Kopf $h_a = m$; Fuß $h_f = m + c$; Achsabstand ist die Summe der Teilkreisradien.],
)[
#if not web [*Aufgabe 272* #linebreak()]
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

// 11-16
#aufgabe(titel: "Räder mit verschiedenem Modul", art: "verstehen", quelle: "12.2")[
#if not web [*Aufgabe 273* #linebreak()]
Ein Rad mit m = 4 mm soll mit einem Rad mit m = 5 mm gepaart werden. Geht das? Begründe.
][
*Modell / Annahmen:* Unverschobenes geradverzahntes Stirnrad, sofern nicht anders angegeben.

Nein. Kämmende Räder müssen den gleichen Modul haben (S. 260).

*Prüfung:* Alle Durchmesser in mm; Kopfkreis größer und Fußkreis kleiner als der Teilkreis.

#src[L-alt D6, Frage 16; nach B S. 259–268]
]

// 11-17
#aufgabe(titel: "Pflichtangaben am Stirnrad", art: "verstehen", quelle: "12.6")[
#if not web [*Aufgabe 274* #linebreak()]
Nenne die sechs Angaben nach DIN 3966-1, die direkt an der Darstellung eines Stirnrads mit Bohrung stehen müssen, und gib an, worauf sich die Lauftoleranzen beziehen. (vgl. Buch 13.7)
][
*Modell / Annahmen:* Unverschobenes geradverzahntes Stirnrad, sofern nicht anders angegeben.

Kopfkreisdurchmesser, Fußkreisdurchmesser (oder Zahnhöhe), Zahnbreite, Bezugselement (hier die Bohrung, toleriert), Lagetoleranzen wie Rund- und Planlauf, Oberflächenangabe der Flanken am Teilkreis. Die Lauftoleranzen beziehen sich auf die Bohrung als Bezug (S. 267).

*Prüfung:* Alle Durchmesser in mm; Kopfkreis größer und Fußkreis kleiner als der Teilkreis.

#src[L-alt D6, Frage 17; nach B S. 259–268]
]

// 11-18
#aufgabe(titel: "Verzahnungstabelle zusammenstellen", art: "verstehen", quelle: "12.6")[
#if not web [*Aufgabe 275* #linebreak()]
Stelle die Mindestinhalte der Verzahnungstabelle für ein Rad mit m = 2 mm, z = 30, Geradverzahnung, ohne Profilverschiebung zusammen. Welche Angaben fehlen dir noch?
][
*Modell / Annahmen:* Unverschobenes geradverzahntes Stirnrad, sofern nicht anders angegeben.

Außenverzahnung, m = 2 mm, z = 30, β = 0°, x = 0. Es fehlen noch: Bezugsprofil (z. B. DIN 867), Verzahnungsqualität mit Passsystem-Kennung, Achsabstand mit Abmaßen und Angaben zum Gegenrad (S. 267).

*Prüfung:* Alle Durchmesser in mm; Kopfkreis größer und Fußkreis kleiner als der Teilkreis.

#src[L-alt D6, Frage 18; nach B S. 259–268]
]

// 11-19
#aufgabe(titel: "Kopfkreis, Teilkreis und Schraffur", art: "verstehen", quelle: "12.3")[
#if not web [*Aufgabe 276* #linebreak()]
Erkläre Kopfkreis, Teilkreis und Schraffur in der Zahnradzeichnung.
][
Der Teilkreis wird als schmale Strichpunktlinie gezeichnet. Der Fußkreis darf in Ansichten als schmale Volllinie ergänzt werden. In der Ansicht reicht das Rad bis zum Kopfkreis.

#src[L-alt D6, offene Überarbeitung Frage 19; B S. 259–268]
]

// 11-20
#aufgabe(titel: "Radpaar im Achsschnitt", art: "verstehen", quelle: "12.4")[
#if not web [*Aufgabe 277* #linebreak()]
Welches Rad wird bei einem Radpaar im Achsschnitt vorn dargestellt und wie wird die Verdeckung gezeigt?
][
wird das Ritzel üblicherweise vorne liegend gezeichnet. wird die hintere Verzahnung teilweise verdeckt dargestellt.

#src[L-alt D6, offene Überarbeitung Frage 20; B S. 259–268]
]

// 11-21
#aufgabe(titel: "Qualitätsstufen einer Verzahnung", art: "verstehen", quelle: "12.5")[
#if not web [*Aufgabe 278* #linebreak()]
Was bedeuten die Qualitätsstufen einer Verzahnung nach dem Buch?
][
wird in 12 Stufen eingeteilt. liegt bei den meisten Getrieben zwischen 5 und 8. gehört in die Verzahnungstabelle.

#src[L-alt D6, offene Überarbeitung Frage 21; B S. 259–268]
]

// 11-22
#aufgabe(titel: "Stirnrad mit m = 2 mm und z = 40", art: "rechnen", quelle: "12.2",
  ergebnis: [d = 80 mm, da = 84 mm, df = 75 mm],
  tipp: [Fußhöhe ist Kopfhöhe plus Kopfspiel.],
)[
#if not web [*Aufgabe 279* #linebreak()]
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

// 11-23
#aufgabe(titel: "Radpaar mit Übersetzung 1 : 3", art: "rechnen", quelle: "12.2",
  ergebnis: [d1 = 60 mm, d2 = 180 mm, da1 = 66 mm, a = 120 mm, i = 3],
  tipp: [Die Übersetzung ist das Zähnezahlverhältnis.],
)[
#if not web [*Aufgabe 280* #linebreak()]
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

// 11-24
#aufgabe(titel: "Zahnrad mit Passfeder auf der Welle", art: "rechnen", quelle: "12.2",
  ergebnis: [a) da = 85 mm, b) Übergangspassung (PO = +19 µm, PU = −15 µm), c) die Passfeder überträgt das Drehmoment formschlüssig],
  tipp: [Eine Übergangspassung kann Spiel haben, sie hält also kein Moment sicher.],
)[
#if not web [*Aufgabe 281* #linebreak()]
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


#kapitel("Kapitel 13 · Zeichnungen lesen und erstellen")

// 12-1
#aufgabe(titel: "Übertragungs- und Führungsgetriebe", art: "verstehen", quelle: "13.1")[
#if not web [*Aufgabe 282* #linebreak()]
Was ist der Unterschied zwischen Übertragungs- und Führungsgetrieben? Woran erkennst du in Bild 14-1 ein Übertragungsgetriebe?
][
Übertragungsgetriebe leiten Leistung (Drehmoment, Drehzahl) weiter und wandeln sie ggf.; Führungsgetriebe führen Punkte eines Körpers auf Bahnen. Erkennbar an drei Wellenenden mit Passfedern (S. 269).

#src[L-alt E1, Frage 1; nach B S. 269–290]
]

// 12-2
#aufgabe(titel: "Wo der Antrieb liegen kann", art: "verstehen", quelle: "13.2")[
#if not web [*Aufgabe 283* #linebreak()]
Warum kann der Antrieb nicht an der horizontalen Welle liegen?
][
Beide horizontalen Wellenenden gehören zu einer Welle; Antrieb an beiden ist unmöglich, an einem nur bedingt sinnvoll, weil das andere Ende einfach mitdreht (S. 269).

#src[L-alt E1, Frage 2; nach B S. 269–290]
]

// 12-3
#aufgabe(titel: "Positionsnummern der Lagerpaare", art: "verstehen", quelle: "13.3")[
#if not web [*Aufgabe 284* #linebreak()]
Warum haben die beiden Schrägkugellager zwei Positionsnummern, die beiden Rillenkugellager aber nur eine?
][
Schrägkugellager haben eine Einbaurichtung; 43 und 44 sind gleiche Lager, aber unterschiedlich eingebaut. Rillenkugellager haben keine Einbaurichtung (S. 272).

#src[L-alt E1, Frage 3; nach B S. 269–290]
]

// 12-4
#aufgabe(titel: "Lücken in Positionsnummern", art: "verstehen", quelle: "13.3")[
#if not web [*Aufgabe 285* #linebreak()]
Nenne zwei Gründe für Lücken in den Positionsnummern einer Stückliste.
][
Historisch (Teile geändert und neu nummeriert) oder bewusst freigelassen für spätere Ergänzungen (S. 276–277).

#src[L-alt E1, Frage 4; nach B S. 269–290]
]

// 12-5
#aufgabe(titel: "Einheiten in der Stückliste", art: "verstehen", quelle: "13.3")[
#if not web [*Aufgabe 286* #linebreak()]
Welche Einheiten außer „Stück“ kann eine Stückliste enthalten?
][
Z. B. Liter oder kg für eine Ölfüllung; grundsätzlich SI-Einheiten nach DIN 1301-1 (S. 277).

#src[L-alt E1, Frage 5; nach B S. 269–290]
]

// 12-6
#aufgabe(titel: "Zwei M5-Gewinde am Lagerhalter", art: "verstehen", quelle: "13.5")[
#if not web [*Aufgabe 287* #linebreak()]
Wozu dienen die zwei M5-Gewindebohrungen am Lagerhalter, und warum sind es zwei?
][
Abdrückgewinde für die Demontage; zwei, damit der Lagerhalter nicht verkantet (S. 279).

#src[L-alt E1, Frage 6; nach B S. 269–290]
]

// 12-7
#aufgabe(titel: "Spielpassung Ø40 H6 am Lagerhalter", art: "verstehen", quelle: "13.5")[
#if not web [*Aufgabe 288* #linebreak()]
Warum ist am Lagerhalter Ø40 H6 eine Spielpassung zulässig?
][
Die Welle dreht, der Lagerhalter steht: Der Außenring hat Punktlast und darf locker sitzen (S. 279).

#src[L-alt E1, Frage 7; nach B S. 269–290]
]

// 12-8
#aufgabe(titel: "j6 an Ø50 und Ø55", art: "verstehen", quelle: "13.5")[
#if not web [*Aufgabe 289* #linebreak()]
Warum sind Ø50 und Ø55 am Lagerhalter mit j6 toleriert?
][
Übergangspassung zur Zentrierung von Lagerhalter und Flanschlager, von Hand montierbar; die Verdrehsicherung übernehmen die Schrauben (S. 279).

#src[L-alt E1, Frage 8; nach B S. 269–290]
]

// 12-9
#aufgabe(titel: "Was die Nutmutter verspannt", art: "verstehen", quelle: "13.4")[
#if not web [*Aufgabe 290* #linebreak()]
Welche Bauteile verspannt die Nutmutter 52?
][
Sicherungsblech 53, Innenring des einen Schrägkugellagers, Distanzring 21, Innenring des anderen Schrägkugellagers gegen die Wellenschulter der Ritzelwelle 16 (S. 276).

#src[L-alt E1, Frage 9; nach B S. 269–290]
]

// 12-10
#aufgabe(titel: "Passfeder nur am Tellerrad", art: "verstehen", quelle: "13.6")[
#if not web [*Aufgabe 291* #linebreak()]
Warum sitzt nur das Tellerrad mit Passfeder auf der Abtriebswelle, der Lagerring aber nicht?
][
Das Tellerrad benötigt eine sichere Drehmomentübertragung über die Passfeder. H7/k6 allein ist als Übergangspassung kein garantierter Reibschluss. Die Aussage auf B S. 282 wird deshalb nicht als allgemeiner Drehmomentnachweis verwendet (S. 282).

#src[L-alt E1, Frage 10; nach B S. 269–290]
]

// 12-11
#aufgabe(titel: "Zwei Ansichten beim Flanschlager", art: "verstehen", quelle: "13.7")[
#if not web [*Aufgabe 292* #linebreak()]
Warum genügen beim Flanschlager zwei Ansichten, und warum ist eine Untersicht ungünstig?
][
Vollschnitt zeigt alle Innenformen, Draufsicht die Bohrungen; aufgeklappte Schnittebenen bringen Senk- und Gewindebohrung in den Schnitt. In der Untersicht wäre der Senkdurchmesser nur verdeckt darstellbar (S. 284).

#src[L-alt E1, Frage 11; nach B S. 269–290]
]

// 12-12
#aufgabe(titel: "Rauheiten am Flanschlager verteilen", art: "verstehen", quelle: "13.7")[
#if not web [*Aufgabe 293* #linebreak()]
Nach welchem Prinzip werden die Rauheiten Rz 63, Rz 16 und Rz 10 am Flanschlager verteilt?
][
Nach Funktion: funktionslos (aber sichtbar) Rz 63, Dichtfläche und Schraubenkopfauflage Rz 16, Lager-, RWDR-Sitz, Zentrierung und Außenmaß Rz 10 (S. 285–286).

#src[L-alt E1, Frage 12; nach B S. 269–290]
]

// 12-13
#aufgabe(titel: "Bezug für Rund- und Planlauf", art: "verstehen", quelle: "13.7")[
#if not web [*Aufgabe 294* #linebreak()]
Welcher Bezug wird für die Lauftoleranzen am Flanschlager gewählt, und warum Rund- und Planlauf?
][
Die Sitzfläche des Wälzlagers. Gekrümmte Flächen erhalten Rundlauf, plane Flächen Planlauf (S. 288).

#src[L-alt E1, Frage 13; nach B S. 269–290]
]

// 12-14
#aufgabe(titel: "Mindestinhalt des Schriftfelds", art: "verstehen", quelle: "13.7")[
#if not web [*Aufgabe 295* #linebreak()]
Was muss mindestens ins Schriftfeld einer Einzelteilzeichnung?
][
Benennung, Maßstab, Zeichnungsnummer, Werkstoff, Bearbeiter/Datum, Prüfer/Freigabe, Eigentümer, Blattzahl (S. 289).

#src[L-alt E1, Frage 14; nach B S. 269–290]
]

// 12-15
#aufgabe(titel: "Grenzmaße von Ø40 H6", art: "rechnen", quelle: "13.5",
  ergebnis: [40,000 bis 40,016 mm],
  tipp: [Bei H ist das untere Abmaß null; das obere ist die Grundtoleranz.],
)[
#if not web [*Aufgabe 296* #linebreak()]
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

// 12-16
#aufgabe(titel: "Paarung Ø50 H7/j6", art: "rechnen", quelle: "13.5",
  ergebnis: [H7: 50,000 bis 50,025 mm; j6: 49,995 bis 50,011 mm; größtes Spiel 30 µm, größtes Übermaß 11 µm],
  tipp: [Größtes Spiel: größte Bohrung, kleinste Welle. Größtes Übermaß: kleinste Bohrung, größte Welle.],
)[
#if not web [*Aufgabe 297* #linebreak()]
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
#src[L-alt E1, Frage 16; nach B S. 269–290]
]

// 12-17
#aufgabe(titel: "Unbemaßte Mitte eines Flansches", art: "rechnen", quelle: "13.5",
  ergebnis: [Nennmaß 8 mm, Kleinstmaß 7,5 mm, Größtmaß 8,5 mm],
  tipp: [Das Restmaß wird am kleinsten, wenn das Gesamtmaß klein und die Teilmaße groß sind.],
)[
#if not web [*Aufgabe 298* #linebreak()]
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

// 12-18
#aufgabe(titel: "Toleranz von Ø52 −0,5", art: "rechnen", quelle: "13.7",
  ergebnis: [Toleranz 0,5 mm (51,5 bis 52,0 mm); nach ISO 2768-m wären es ±0,3, also 0,6 mm; ein Plusabmaß bringt nichts],
  tipp: [Überlege, aus welcher Richtung die Werkstatt an ein Außenmaß herankommt.],
)[
#if not web [*Aufgabe 299* #linebreak()]
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

// 12-19
#aufgabe(titel: "Lagerbezeichnungen 7203 B und 6006 C3", art: "verstehen", quelle: "10.4")[
#if not web [*Aufgabe 300* #linebreak()]
Entschlüssle die Lagerbezeichnungen 7203 B und 6006 C3 aus der Stückliste (Bauart, Bohrung). Nutze Abschnitt 10.4 dieses Lernskripts.
][
*Modell / Annahmen:* Worst-Case-Maßkette beziehungsweise Zeichnungsinterpretation nach den genannten Funktionsflächen.

6006 C3: Rillenkugellager (6), Bohrungskennzahl 06 → d = 6 · 5 = 30 mm, Nachsetzzeichen C3 = vergrößerte Lagerluft (vgl. Abschnitt 10.4 dieses Lernskripts). 7203 B: Schrägkugellager (Lagerart 7), Bohrungskennzahl 03 → d = 17 mm (Sonderfall: 00 = 10, 01 = 12, 02 = 15, 03 = 17 mm), Nachsetzzeichen B = Berührungswinkel 40°. Die Bedeutung von 7, 03, B und C3 ist Ergänzung aus DIN 623/Herstellerkatalogen; das Buch nennt nur die Bezeichnungen (S. 274).

*Prüfung:* Maßketten im ungünstigsten Grenzfall prüfen; aus verkleinerten Buchbildern keine Funktionsmaße abgreifen.

#src[L-alt E1, Frage 19; nach B S. 269–290]
]

// 12-20
#aufgabe(titel: "Bezeichnung von Passfeder und O-Ring", art: "verstehen", quelle: "8.4")[
#if not web [*Aufgabe 301* #linebreak()]
Formuliere die vollständige Normbezeichnung der Passfeder Pos. 68 und eines O-Rings Pos. 79 nach den Schemata in Abschnitt 8.4 und 11.4 dieses Lernskripts (Werkstoff NBR, Sortenmerkmal N, Härte 70 als Annahme).
][
*Modell / Annahmen:* Worst-Case-Maßkette beziehungsweise Zeichnungsinterpretation nach den genannten Funktionsflächen.

Passfeder DIN 6885 – A 6 × 6 × 25; O-Ring DIN 3771 – 24 x 3 – N – NBR70 (Stückliste S. 274 nennt „NBR / OR 24X3,0“; Sorte und Härte sind Annahmen).

*Prüfung:* Maßketten im ungünstigsten Grenzfall prüfen; aus verkleinerten Buchbildern keine Funktionsmaße abgreifen.

#src[L-alt E1, Frage 20; nach B S. 269–290]
]

// 12-21
#aufgabe(titel: "Kraftweg im Spiralkegelgetriebe", art: "verstehen", quelle: "13.2")[
#if not web [*Aufgabe 302* #linebreak()]
Verfolge Kraftweg und Lagerung im Spiralkegelgetriebe.
][
Die Antriebswelle ist mit zwei Schrägkugellagern gelagert. Das Getriebe lenkt vor allem um 90° um. Die O-Ringe tragen die Positionsnummern 77 bis 80.

#src[L-alt E1, offene Überarbeitung Frage 21; B S. 269–290]
]

// 12-22
#aufgabe(titel: "Ø24 H8 und allgemeine Angaben am Flanschlager", art: "verstehen", quelle: "13.7")[
#if not web [*Aufgabe 303* #linebreak()]
Welche Funktion hat Ø24 H8 im Flanschlager, und welche allgemeinen Angaben zeigt die Zeichnung?
][
Ø24 H8 ist der Sitz des Radial-Wellendichtrings. Die Allgemeintoleranz lautet kurz ISO 2768-mK.

#src[L-alt E1, offene Überarbeitung Frage 22; B S. 269–290]
]

// 12-23
#aufgabe(titel: "Hilfsmaße in runden Klammern", art: "verstehen", quelle: "13.7")[
#if not web [*Aufgabe 304* #linebreak()]
Warum verwendet man Hilfsmaße in runden Klammern?
][
ist ein Hilfsmaß und nicht maßgeblich. vermeidet eine Doppelbemaßung. wird nicht geprüft (abgeleitet).

#src[L-alt E1, offene Überarbeitung Frage 23; B S. 269–290]
]

// 12-24
#aufgabe(titel: "Restmaß nach ISO 2768-m", art: "rechnen", quelle: "13.5",
  ergebnis: [Nennmaß 13 mm, zwischen 12,3 und 13,7 mm],
  tipp: [Ungünstigster Fall: Gesamtmaß an der einen Grenze, beide Teilmaße an der anderen.],
)[
#if not web [*Aufgabe 305* #linebreak()]
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

// 12-25
#aufgabe(titel: "Unbemaßte Mitte bei Maßen 8 und 12", art: "rechnen", quelle: "13.5",
  ergebnis: [Nennmaß 10 mm, zwischen 9,4 und 10,6 mm],
  tipp: [Alle drei Maße liegen im Bereich 6 bis 30 mm.],
)[
#if not web [*Aufgabe 306* #linebreak()]
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

// 12-26
#aufgabe(titel: "Zwei Positionsnummern für gleiche Lager", art: "verstehen", quelle: "13.3")[
#if not web [*Aufgabe 307* #linebreak()]
In einer Gesamtzeichnung tragen zwei gleiche Schrägkugellager die Positionsnummern 5 und 6. Warum zwei Nummern? Und wie heißt das Teil, mit dem man die beiden spielfrei verspannt?
][
*Modell / Annahmen:* Worst-Case-Maßkette beziehungsweise Zeichnungsinterpretation nach den genannten Funktionsflächen.

Schrägkugellager haben eine Einbaurichtung; gleiche Lager in verschiedener Richtung bekommen eigene Positionsnummern (S. 272). Verspannt wird mit Nutmutter und Sicherungsblech (Kapitel 9, S. 276).

*Prüfung:* Maßketten im ungünstigsten Grenzfall prüfen; aus verkleinerten Buchbildern keine Funktionsmaße abgreifen.

#src[L-alt G7; eigenes Zahlenbeispiel, Tabellenwerte nach B]
]

// 12-27
#aufgabe(titel: "Einzelteilzeichnung des Lagerdeckels", art: "verstehen", quelle: "13.7")[
#if not web [*Aufgabe 308* #linebreak()]
Erstelle die Einzelteilzeichnung des Lagerdeckels Pos. 2 aus AK 5: erforderliche Ansichten, Lochkreis für vier Schrauben, vollständige Bemaßung, ISO 2768-mK, eine Form- und eine Lagetoleranz, allgemeine und abweichende Oberfläche, Kantenzustand und Schriftfeld.
#bild("ak-lagerdeckel", [Originalausschnitt AK, PDF-S. 9; mit vorhandenen handschriftlichen Einträgen.], height: 127mm)
][
Eigene Lösung als prüfbarer Zeichenweg: 1. Verfolge Pos. 2 in der Gesamtzeichnung und trenne sie gedanklich von Gehäuse, Schrauben und Lager. Verwende einen axialen Schnitt für Wanddicken, Stufen und Innenkontur sowie eine Stirnansicht für vier gleichmäßig verteilte Befestigungsbohrungen auf dem Lochkreis. 2. Bemaße Funktionsdurchmesser, axiale Stufen, Wanddicken und Lochkreis jeweils eindeutig von geeigneten Bezügen; Bohrungsanzahl 4× zuordnen. 3. Bestimme eine funktionelle Bezugsfläche, beispielsweise die Anlagefläche A, und gegebenenfalls die Zentrierachse B. Eine Ebenheit der Anlagefläche ist eine Formforderung; eine Rechtwinkligkeit oder Position zu A/B ist eine bezogene Lage-/Richtungsforderung. Werte müssen aus Aufgabenangabe oder Funktionsvorgabe stammen. 4. Trage ISO 2768-mK wie in der historischen AK gefordert ein, kennzeichne die abweichende Funktionsoberfläche separat und ergänze Kantenzustand und Schriftfeld. Prüfung: Der Ausschnitt enthält keine vollständigen Zahlenmaße und keine verbindlichen Werte für Rauheit, Form- und Lagetoleranz. Deshalb ist ein vollständig numerisch bestimmtes Einzelteil daraus nicht eindeutig lösbar; die handschriftlichen Ergänzungen sind keine amtlichen Lösungsvorgaben. Die geforderten Angaben und ihre Platzierung sind dagegen vollständig überprüfbar.

#src[AK 5, PDF-S. 9–10; eigene Lösung mit B Buchkapitel 4–7 und 15]
]

