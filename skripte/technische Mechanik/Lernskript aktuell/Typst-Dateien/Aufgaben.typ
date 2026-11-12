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

#kapitel("TM1 Kapitel 1 · Das Werkzeug für Klausuraufgaben")

#aufgabe(titel: "Wann nimmt man bei der Kraftzerlegung den Sinus und wann den Kosinus?", art: "verstehen", quelle: "1.3", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 1* #linebreak()]
Wann nimmt man bei der Kraftzerlegung den Sinus und wann den Kosinus?
][
*Antwort:*
- Das hängt davon ab, von welcher Achse aus der Winkel gemessen wird.
- Die Komponente an der Achse, an der der Winkel anliegt, bekommt den Kosinus.
- Die andere Komponente bekommt den Sinus.
- Deshalb zeichnet man den Winkel immer erst ein, bevor man zerlegt.
#align(center)[#image(abbildungen.at("tm1k2_mitschrift_zerlegung"), width: 60%)]
][
*Merksatz:* Anliegende Komponente: Kosinus; gegenüberliegende: Sinus.
]

#aufgabe(titel: "Seilkraft auf die Rolle A", art: "rechnen", quelle: "1.3", herkunft: "original", vorlage: "Altklausur SS 24, Aufg. 1 (Seilrolle)", minuten: 5,
  ergebnis: [$4F$ nach rechts und $8F$ nach unten],
  tipp: [Jedes Seilstück, das die Rolle verlässt, zieht mit der vollen Seilkraft an ihr. Zerlege das schräge Stück mit dem 3–4–5-Dreieck.],
)[
#if not web [*Aufgabe 2* #linebreak()]
*AK24 S. 8–9, Seilrolle:*

*Gegeben und Annahmen*

Die Seilkraft beträgt $5F$. Das schräge Seilstück bildet ein 3–4–5-Dreieck und läuft von A nach rechts unten. Das zweite Seilstück verlässt die ideale Rolle senkrecht nach unten; beide Seilzüge haben denselben Betrag. Die Rolle ist reibungsfrei.

*Gesucht*

#enum(numbering: "a)",
[Bestimme beide Komponenten und die gesamte Kraft des Seils auf die Rolle A.],
)
][
*Bild:* Schneide die Rolle frei. Wo ein Seil die Rolle verlässt, zieht es sie mit der Seilkraft in Seilrichtung, weg von der Rolle. An A gehen zwei Seilstücke ab: eines senkrecht nach unten, eines schräg nach rechts unten. Beide tragen dieselbe Kraft $5F$, weil ein ideales Seil über eine reibungsfreie Rolle die Kraft nicht ändert.
][
*Schräges Stück zerlegen:* Das Dreieck hat die Seiten 3, 4 und 5. Die 5 gehört zur Seilrichtung, also zur Kraft $5F$. Die waagerechte Seite 4 gibt $5F dot 4\/5 = 4F$ nach rechts, die senkrechte Seite 3 gibt $5F dot 3\/5 = 3F$ nach unten.
][
*Senkrechtes Stück:* Es zieht mit $5F$ gerade nach unten und hat keinen waagerechten Anteil.
][
*Addieren:* waagerecht $4F$ nach rechts; senkrecht $3F + 5F = 8F$ nach unten.
][
*Prüfen:* Das schräge Stück allein hat den Betrag $sqrt((4F)^2 + (3F)^2) = 5F$, so wie es sein muss. Der Gesamtbetrag wäre $sqrt(16 + 64) thin F approx "8,94" thin F$.
]

#aufgabe(titel: "Seilkraft auf die Rolle A (Variante)", art: "rechnen", quelle: "1.3", herkunft: "variante", vorlage: "Altklausur SS 24, Aufg. 1 (Seilrolle)", minuten: 4,
  ergebnis: [$12F$ nach rechts und $18F$ nach unten; Betrag $approx "21,63" F$],
)[
#if not web [*Aufgabe 3* #linebreak()]
*Gegeben und Annahmen*

Ideale, reibungsfreie Rolle A. Seilkraft $13F$. Ein Seilstück verlässt die Rolle schräg nach rechts unten entlang eines 5–12–13-Dreiecks (waagrechte Seite 12, senkrechte Seite 5), das andere senkrecht nach unten.

*Gesucht*

#enum(numbering: "a)",
[Komponenten und Betrag der Seilkraft auf die Rolle.],
)
][
*Schräges Stück:* $13F dot 12\/13 = 12F$ nach rechts, $13F dot 5\/13 = 5F$ nach unten.
][
*Senkrechtes Stück:* $13F$ nach unten.
][
*Summe:* $12F$ nach rechts, $18F$ nach unten; Betrag $sqrt(144 + 324) F approx "21,63" F$.
]

#aufgabe(titel: "Hebelarm richtig ablesen", art: "verstehen", quelle: "1.4", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 4* #linebreak()]
Warum darfst du den Hebelarm nicht einfach als Abstand vom Kraftangriffspunkt zum Bezugspunkt ablesen?
][
Nur der senkrechte Abstand zur Wirkungslinie ist der Hebelarm. Gleichwertig kannst du die Kraft zerlegen und die Komponenten mit ihren senkrechten Armen multiplizieren.
]

#aufgabe(titel: "Wie viele Gleichgewichtsbedingungen hat ein starrer Körper in der Ebene?", art: "verstehen", quelle: "1.4", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 5* #linebreak()]
Wie viele Gleichgewichtsbedingungen hat ein starrer Körper in der Ebene?
][
*Antwort:*
- *Drei:*
$ sum F_x = 0, quad sum F_y = 0, quad sum M = 0 $
- (um einen beliebigen Punkt).
- Deshalb kann man pro Körper höchstens drei Unbekannte bestimmen.
#align(center)[#image(abbildungen.at("tm1k01_momentdarst"), width: 60%)]
]

#aufgabe(titel: "Warum reicht ΣF = 0 allein nicht für Gleichgewicht?", art: "verstehen", quelle: "1.4", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 6* #linebreak()]
Warum reicht $sum F = 0$ allein nicht für Gleichgewicht?
][
*Antwort:*
- Zwei gleich große, entgegengesetzte Kräfte auf verschiedenen Wirkungslinien heben sich als Kräfte auf, bilden aber ein Kräftepaar.
- Das dreht den Körper.
- Erst mit $sum M = 0$ ist auch die Drehung ausgeschlossen.
#align(center)[#image(abbildungen.at("tm1k01_momentdarst"), width: 60%)]
][
*Merksatz:* Kräftegleichgewicht allein verhindert noch keine Drehung.
]

#aufgabe(titel: "Moment eines Hebels in Nm und Nmm", art: "rechnen", quelle: "1.4", herkunft: "eigen", minuten: 3,
  ergebnis: [$M = 600 thin "Nm" = 600000 thin "Nmm"$],
  tipp: [Moment ist Kraft mal senkrechter Hebelarm. Rechne erst in N und m, dann in mm um.],
)[
#if not web [*Aufgabe 7* #linebreak()]
*Eigene Aufgabe nach FS TM1 S. 22:*

*Gegeben und Annahmen*

Eine Kraft von 2 kN wirkt senkrecht auf einen Hebel mit 0,3 m Länge.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist das Moment in Nm und Nmm?],
)
][
*Hebelarm:* Die Kraft steht senkrecht auf dem Hebel. Damit ist die ganze Hebellänge der senkrechte Abstand zur Wirkungslinie, also $r = "0,3" thin "m"$.
][
*Rechnen:* $M = F dot r = 2000 thin "N" dot "0,3" thin "m" = 600 thin "Nm"$.
][
*Umrechnen:* 1 m sind 1000 mm, also $600 thin "Nm" = 600 dot 1000 thin "Nmm" = 600000 thin "Nmm"$. In Nmm wird die Zahl tausendmal größer, weil die Längeneinheit tausendmal kleiner ist.
][
*Prüfen:* Kraft mal Länge ergibt die Einheit eines Moments. Stünde die Kraft schräg, zählte nur ihr senkrechter Anteil.
]

#aufgabe(titel: "Gelenkkräfte im Gesamtsystem", art: "verstehen", quelle: "1.6", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 8* #linebreak()]
Warum sind Gelenkkräfte im Freikörperbild des Gesamtsystems nicht zu sehen?
][
Im Gesamtsystem bilden die Gelenkkräfte innere, gleich große Gegenkräfte. Betrachtet man die Teile einzeln, werden sie zu äußeren Kräften des jeweiligen Teils.
]

#aufgabe(titel: "Freischnitt des Rahmens 2018", art: "verstehen", quelle: "1.6", herkunft: "original", vorlage: "Altklausur 2018, Aufg. 1 b)", minuten: 2,
)[
#if not web [*Aufgabe 9* #linebreak()]
Für den Rahmen aus Altklausur 2018 (geändertes System: Festlager A und E, Gelenk G, $q_0$ von B bis C über die Länge $a$, G in der Mitte von B–C, $F$ mittig zwischen D und E, $M_0$ mittig zwischen A und B): Welche Lasten, Lager- und Verbindungsreaktionen trägst du in den Freischnitt der beiden Teile ein? Ersetze die Streckenlast durch ihre beiden Resultierenden mit richtiger Größe und richtigem Angriffspunkt.
][
*Linker Teil A–B–G:* $A_H$, $A_V$ in A; $M_0$ auf halber Höhe von A–B; Resultierende $q_0 a\/2$ nach unten, $a\/4$ rechts von B; Gelenkkräfte $G_H$, $G_V$ in G.
][
*Rechter Teil G–C–D–E:* Gegenkräfte $G_H$, $G_V$ in G (entgegengesetzt gerichtet); Resultierende $q_0 a\/2$ nach unten, $a\/4$ rechts von G; $F$ mittig zwischen D und E; $E_H$, $E_V$ in E. Die Streckenlast wird am Gelenk geteilt, weil jede Hälfte nur auf ihrem eigenen Teil wirkt.
]

#aufgabe(titel: "Wie geht man beim Freischneiden vor?", art: "verstehen", quelle: "1.6", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 10* #linebreak()]
Wie geht man beim Freischneiden vor?
][
*Antwort:*
- Den Körper gedanklich von allen Lagern und Nachbarkörpern trennen.
- An jeder Schnittstelle die Kräfte und Momente einzeichnen, die das Lager übertragen kann.
- Die Richtungen von Unbekannten frei annehmen.
- Ein negatives Ergebnis heißt nur, dass sie andersherum wirken.
- Alle eingeprägten Lasten einzeichnen und die Gleichgewichtsbedingungen aufstellen.
#align(center)[#image(abbildungen.at("tm1k01_gerber_frei"), width: 60%)]
][
*Merksatz:* Erst freischneiden, dann Gleichungen schreiben.
]

#aufgabe(titel: "Was sagt actio = reactio beim Freischneiden?", art: "verstehen", quelle: "1.6", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 11* #linebreak()]
Was sagt actio = reactio beim Freischneiden?
][
*Antwort:*
- An einer Schnittstelle wirken auf beide Körper gleich große, entgegengesetzte Kräfte.
- Sie greifen an verschiedenen Körpern an und heben sich deshalb in den Gleichgewichtsbedingungen eines einzelnen Körpers nicht auf.
#align(center)[#image(abbildungen.at("tm1k01_gerber_frei"), width: 60%)]
][
*Merksatz:* Actio und reactio gehören an zwei verschiedene Körper.
]

#aufgabe(titel: "In welche Richtung wirkt die Kraft eines Seils?", art: "verstehen", quelle: "1.6", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 12* #linebreak()]
In welche Richtung wirkt die Kraft eines Seils?
][
*Antwort:*
- Immer als Zugkraft entlang des Seils, vom Körper weg.
- Ein Seil kann nicht drücken und keine Querkraft übertragen.
][
*Merksatz:* Ein Seil zieht, es drückt nicht.
]

#kapitel("TM1 Kapitel 4 · Streckenlasten und Schwerpunkt")

#aufgabe(titel: "Angriffspunkt der Dreieckslast", art: "verstehen", quelle: "4.1", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 13* #linebreak()]
Wo greift die Resultierende einer Dreieckslast an, und von welcher Seite misst du?
][
Bei einem Drittel der Länge von der hohen Seite bzw. zwei Dritteln von der Nullseite. Das gilt für eine linear verlaufende Dreieckslast.
]

#aufgabe(titel: "Wie ersetzt man eine Streckenlast durch eine Einzelkraft?", art: "verstehen", quelle: "4.1", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 14* #linebreak()]
Wie ersetzt man eine Streckenlast durch eine Einzelkraft?
][
*Antwort:*
- Die Resultierende ist so groß wie die Fläche unter dem Lastbild.
- Sie greift im Schwerpunkt dieser Fläche an.
- Bei einer Rechtecklast liegt er in der Mitte, bei einer Dreieckslast bei einem Drittel von der hohen Seite.
#align(center)[#image(abbildungen.at("ak24-system"), width: 60%)]
][
*Merksatz:* Lastfläche gibt Kraft, ihr Schwerpunkt den Angriffspunkt.
]

#aufgabe(titel: "Darf man eine Streckenlast schon vor dem Schneiden zusammenfassen?", art: "verstehen", quelle: "4.1", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 15* #linebreak()]
Darf man eine Streckenlast schon vor dem Schneiden zusammenfassen?
][
*Antwort:*
- Für die Lagerreaktionen ja.
- *Für Schnittgrößen nicht:* Liegt der Schnitt mitten in der Streckenlast, gehört zu jedem Teil nur der Teil der Last, der auf ihm liegt.
- Diesen Teil fasst man dann neu zusammen.
#align(center)[#image(abbildungen.at("ak24-system"), width: 60%)]
][
*Merksatz:* Für Schnittgrößen zählt nur die Last auf dem freigeschnittenen Teil.
]

#aufgabe(titel: "Resultierende und Angriffspunkt einer Dreieckslast", art: "verstehen", quelle: "4.1", herkunft: "eigen", minuten: 3,
  tipp: [Die Resultierende ist die Fläche unter dem Lastbild, sie greift im Flächenschwerpunkt an.],
)[
#if not web [*Aufgabe 16* #linebreak()]
Eine Dreieckslast steigt über die Länge $L$ von 0 auf $q_0$. Wie groß ist die Resultierende und wo greift sie an?
][
*Antwort:* $q_0 L \/ 2$ bei $2L\/3$ von der Nullseite. Fläche des Dreiecks und sein Schwerpunkt, also näher an der hohen Seite.
][
*Typische Verwechslung:* $q_0 L$ bei $L\/2$: Das gilt für eine Rechtecklast. Die Dreiecksfläche ist nur halb so groß.
]

#aufgabe(titel: "Drei Streckenlasten zusammenfassen", art: "rechnen", quelle: "4.1", herkunft: "original", vorlage: "TM1-Übung 6, Aufg. 6.4", minuten: 15,
  ergebnis: [a) $R = 3\/4 q_0 L$ bei $x = 5\/9 L$; b) $R = 1\/2 q_0 L$ bei $x = 4\/9 L$; c) $R = 2\/pi q_0 L approx "0,637" q_0 L$ bei $x = 2\/pi L approx "0,637" L$],
  tipp: [Die Resultierende ist die Fläche unter $q(x)$, ihr Angriffspunkt der Flächenschwerpunkt. Bei c) hilft partielle Integration.],
)[
#if not web [*Aufgabe 17* #linebreak()]
Bestimmen Sie die Funktion $q(x)$, die Resultierende und ihren Angriffspunkt (Schwerpunkt) für die folgenden Streckenlasten.
#align(center)[#image(abbildungen.at("tm1k4_ue64"), width: 60%)]

*Gegeben und Annahmen*

Alle Lasten wirken über die Länge $L$, $x$ von links. a) trapezförmig von $q_0\/2$ links auf $q_0$ rechts; b) dachförmig, von 0 links auf die Spitze $q_0$ bei $x = L\/3$ und wieder auf 0 rechts; c) Viertelsinus, von 0 links auf $q_0$ rechts.

*Gesucht*

#enum(numbering: "a)",
[$q(x)$, Resultierende $R$ und Angriffspunkt für die Trapezlast.],
[dasselbe für die Dachlast.],
[dasselbe für die Viertelsinuslast.],
)
][
*Prinzip:* $R = integral_0^L q(x) dif x$ und $x_R = integral_0^L x q(x) dif x \/ R$. Bei geraden Lastbildern geht es schneller mit Rechteck- und Dreiecksflächen.
][
*a) Trapez:* $q(x) = q_0\/2 + q_0 x\/(2L)$. Rechteck $q_0 L\/2$ bei $L\/2$, Dreieck $q_0 L\/4$ bei $2L\/3$. $R = 3\/4 q_0 L$; $x_R = (q_0 L^2\/4 + q_0 L^2\/6)\/(3\/4 q_0 L) = (5\/12)\/(3\/4) L = 5\/9 L$.
][
*b) Dach:* Fläche eines Dreiecks mit Grundseite $L$ und Höhe $q_0$: $R = q_0 L\/2$. Der Schwerpunkt eines Dreiecks liegt beim Mittelwert der Ecken: $x_R = (0 + L\/3 + L)\/3 = 4\/9 L$. Abschnittsweise: $q = 3q_0 x\/L$ für $x <= L\/3$, $q = 3q_0 (L - x)\/(2L)$ für $x >= L\/3$.
][
*c) Viertelsinus:* $q(x) = q_0 sin(pi x\/(2L))$. $R = q_0 [-2L\/pi cos(pi x\/(2L))]_0^L = 2\/pi q_0 L$. Partielle Integration: $integral_0^L x sin(pi x\/(2L)) dif x = (2L\/pi)^2 = 4L^2\/pi^2$. Also $x_R = (4 q_0 L^2\/pi^2)\/(2 q_0 L\/pi) = 2L\/pi approx "0,637" L$.
][
*Prüfen:* In a) und c) ist die Last rechts größer, also liegt $x_R$ rechts der Mitte. In b) liegt die Spitze links, also $x_R < L\/2$. Alle drei Ergebnisse passen.
]

#aufgabe(titel: "Trapezlast zusammenfassen", art: "rechnen", quelle: "4.1", herkunft: "variante", vorlage: "TM1-Übung 6, Aufg. 6.4", minuten: 6,
  ergebnis: [$F_R = 9 thin "kN"$ bei $x_R = 5\/3 thin "m" approx "1,67" thin "m"$],
  tipp: [Zerlege die Last in ein Rechteck und ein Dreieck. Jede Teillast greift im Schwerpunkt ihrer Fläche an.],
)[
#if not web [*Aufgabe 18* #linebreak()]
*Eigene Zahlen nach P1 Aufgabe 6.4:*

*Gegeben und Annahmen*

$q(x)=q_0(1+x/L)$ mit $q_0=2 "kN/m"$, $L=3 "m"$.

*Gesucht*

#enum(numbering: "a)",
[Bestimme Resultierende und Angriffspunkt.],
)
][
*Bild:* Die Last beginnt links mit $q_0 = 2 thin "kN/m"$ und steigt linear bis rechts auf $2q_0 = 4 thin "kN/m"$. Das ist ein Trapez: unten ein Rechteck der Höhe $q_0$, darauf ein Dreieck, das von 0 auf $q_0$ ansteigt.
][
*Rechteck:* $F_1 = q_0 L = 2 dot 3 = 6 thin "kN"$, Angriff in der Mitte bei $x_1 = "1,5" thin "m"$.
][
*Dreieck:* $F_2 = q_0 L\/2 = 3 thin "kN"$. Die hohe Seite liegt rechts, also greift $F_2$ ein Drittel von rechts an: $x_2 = 2L\/3 = 2 thin "m"$.
][
*Resultierende:* $F_R = F_1 + F_2 = 9 thin "kN"$. Ihr Ort folgt aus gleichem Moment um den linken Rand: $x_R = (6 dot "1,5" + 3 dot 2)\/9 = 15\/9 = 5\/3 thin "m"$.
][
*Prüfen:* Rechts ist die Last größer, also muss $x_R$ rechts der Mitte 1,5 m liegen. Mit 1,67 m stimmt das.
]

#aufgabe(titel: "Aussparung im Schwerpunkt", art: "verstehen", quelle: "4.2", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 19* #linebreak()]
Warum muss eine Aussparung sowohl in der Flächensumme als auch in der Momentsumme abgezogen werden?
][
Die Aussparung enthält kein Material und darf weder Fläche noch deren statisches Moment beitragen. Nur den Nenner zu ändern würde einen falschen Schwerpunkt ergeben.
]

#aufgabe(titel: "Wie bestimmt man den Schwerpunkt einer zusammengesetzten Fläche?", art: "verstehen", quelle: "4.2", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 20* #linebreak()]
Wie bestimmt man den Schwerpunkt einer zusammengesetzten Fläche?
][
*Antwort:*
- Man zerlegt sie in einfache Teilflächen mit bekannten Schwerpunkten und bildet das flächengewichtete Mittel:
- $ x_S = (sum A_i x_i)/(sum A_i) $ Löcher und Ausschnitte zählt man als negative Flächen.
#align(center)[#image(abbildungen.at("tm2k4_wzf0806_ue10"), width: 60%)]
][
*Merksatz:* Flächen gewichten, Löcher negativ zählen.
]

#aufgabe(titel: "Was hilft eine Symmetrieachse beim Schwerpunkt?", art: "verstehen", quelle: "4.2", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 21* #linebreak()]
Was hilft eine Symmetrieachse beim Schwerpunkt?
][
*Antwort:*
- Der Schwerpunkt liegt auf jeder Symmetrieachse.
- Bei einer Achse muss man nur noch eine Koordinate berechnen, bei zwei Achsen liegt er im Schnittpunkt.
#align(center)[#image(abbildungen.at("tm2k4_wzf0806_ue10"), width: 60%)]
]

#aufgabe(titel: "Schwerpunkt eines Rechtecks mit Loch", art: "rechnen", quelle: "4.2", herkunft: "original", vorlage: "TM2-Übung 10, Aufg. 10.1 (Schwerpunkt)", minuten: 5,
  ergebnis: [$z'_S = 19a\/6 approx "3,17" a$ von oben, $y'_S = 0$],
  tipp: [Das Loch zählt als negative Fläche, sowohl im Nenner als auch im Zähler.],
)[
#if not web [*Aufgabe 22* #linebreak()]
*P1 S. 1 / P2 S. 41, Grundidee:*

*Gegeben und Annahmen*

Ein äußeres Rechteck $4a times 6a$ hat eine mittige rechteckige Aussparung $2a times 3a$. Ihre Oberkante liegt um $a$ unter der äußeren Oberkante.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $z'_S$ von oben.],
)
][
*Bild:* Nimm das volle Rechteck und zieh das Loch ab. Das Loch ist wie eine Fläche mit negativem Gewicht. Beide Teile liegen links-rechts symmetrisch, deshalb ist $y'_S = 0$; gesucht ist nur die Höhe.
][
*Außenrechteck:* $A_1 = 4a dot 6a = 24a^2$, sein Schwerpunkt liegt auf halber Höhe, $z'_1 = 3a$.
][
*Loch:* $A_2 = -(2a dot 3a) = -6a^2$. Es beginnt bei $a$ und ist $3a$ hoch, seine Mitte liegt also bei $z'_2 = a + "1,5" a = "2,5" a$.
][
*Zusammensetzen:* $z'_S = (A_1 z'_1 + A_2 z'_2)\/(A_1 + A_2) = (72a^3 - 15a^3)\/(18a^2) = 57a\/18 = 19a\/6 approx "3,17" a$.
][
*Prüfen:* Das Loch sitzt in der oberen Hälfte, oben fehlt also Material. Der Schwerpunkt muss deshalb etwas unter der Mitte $3a$ liegen, und $"3,17" a$ tut das.
]

#aufgabe(titel: "Schwerpunkt eines Rechtecks mit Loch (Variante)", art: "rechnen", quelle: "4.2", herkunft: "variante", vorlage: "TM2-Übung 10, Aufg. 10.1 (Schwerpunkt)", minuten: 4,
  ergebnis: [$z'_S = "4,2" a$ von oben, $y'_S = 0$],
)[
#if not web [*Aufgabe 23* #linebreak()]
*Gegeben und Annahmen*

Ein Rechteck $6a$ breit und $8a$ hoch hat eine mittige rechteckige Aussparung $2a$ breit und $4a$ hoch. Die Oberkante der Aussparung liegt um $a$ unter der äußeren Oberkante. $z'$ zählt von der Oberkante nach unten.

*Gesucht*

#enum(numbering: "a)",
[Lage $z'_S$ des Schwerpunkts.],
)
][
*Teilflächen:* Außen $A_1 = 48a^2$ bei $z'_1 = 4a$. Loch $A_2 = -8a^2$, Mitte bei $z'_2 = a + 2a = 3a$.
][
*Rechnen:* $z'_S = (48 dot 4 - 8 dot 3) a^3 \/ (40 a^2) = 168\/40 a = "4,2" a$. Symmetrie gibt $y'_S = 0$.
][
*Prüfen:* Das Loch liegt über der Mitte $4a$, also wandert der Schwerpunkt nach unten unter $4a$. $"4,2" a$ passt.
]

#aufgabe(titel: "Schwerpunkte dreier Profile", art: "rechnen", quelle: "4.2", herkunft: "original", vorlage: "TM1-Übung 6, Aufg. 6.1", minuten: 15,
  ergebnis: [a) $x_S = "22,5" "mm"$, $y_S = "12,8" "mm"$; b) $x_S = 13 "mm"$, $y_S = "12,8" "mm"$; c) $x_S = -"12,5" "mm"$, $y_S = -"5,6" "mm"$],
  tipp: [Zerlege jedes Profil in Rechtecke und Halbkreise. Bei c) ist es am einfachsten, volle Flächen zu nehmen und das Innere als negative Fläche abzuziehen.],
)[
#if not web [*Aufgabe 24* #linebreak()]
Ermitteln Sie für die dargestellten Profile die Lage der Flächenschwerpunkte.
#align(center)[#image("abbildungen/ue1_6_1.png", width: 100%)]

*Gegeben und Annahmen*

Maße in mm wie in der Skizze. a) Fuß $45 times 4$, Steg $5 times 20$, Kopf $15 times 8$, alles symmetrisch zur senkrechten Mittelachse. b) Dieselben Rechtecke, Steg und Kopf aber bündig am linken Rand; Ursprung unten links. c) Linke Wand 10 breit und 60 hoch, unterer Gurt 10 dick, rechts ein Halbkreisring mit Innenradius 20 und Wanddicke 10 (Außenradius 30); Ursprung im Kreismittelpunkt, $x$ nach rechts, $y$ nach oben.

*Gesucht*

#enum(numbering: "a)",
[Schwerpunkt des T-Profils.],
[Schwerpunkt des L-förmigen Profils.],
[Schwerpunkt des U-Profils mit Halbkreis.],
)
][
*Bild:* Ein Schwerpunkt ist der flächengewichtete Mittelwert der Teilschwerpunkte: $x_S = sum A_i x_i \/ sum A_i$. Du brauchst also nur Teilflächen, deren Schwerpunkt du kennst (Rechteck: Mitte; Halbkreis: $4r\/(3pi)$ vom Mittelpunkt).
][
*a) T-Profil:* Wegen der Symmetrie liegt $x_S$ auf der Mittelachse, also $x_S = "22,5" "mm"$ vom linken Rand. Für $y$ (von unten): Fuß $A_1 = 180$, $y_1 = 2$; Steg $A_2 = 100$, $y_2 = 4 + 10 = 14$; Kopf $A_3 = 120$, $y_3 = 24 + 4 = 28$. $y_S = (360 + 1400 + 3360)\/400 = 5120\/400 = "12,8" "mm"$.
][
*b) L-Profil:* Die $y$-Werte sind dieselben wie in a), deshalb wieder $y_S = "12,8" "mm"$. Für $x$ vom linken Rand: Fuß $x_1 = "22,5"$, Steg $x_2 = "2,5"$, Kopf $x_3 = "7,5"$. $x_S = (180 dot "22,5" + 100 dot "2,5" + 120 dot "7,5")\/400 = 5200\/400 = 13 "mm"$.
][
*c) Zerlegen mit negativen Flächen:* Volles Rechteck $[-50, 0] times [-30, 30]$: $A_1 = 3000$ bei $(-25; 0)$. Voller Halbkreis $R = 30$: $A_2 = pi 30^2\/2 = "1413,7"$ bei $x_2 = 4 dot 30\/(3pi) = "12,73"$. Abziehen: inneres Rechteck $[-40, 0] times [-20, 30]$: $A_3 = -2000$ bei $(-20; 5)$; innerer Halbkreis $r = 20$: $A_4 = -"628,3"$ bei $x_4 = "8,49"$.
][
*c) Ausrechnen:* $A = 3000 + "1413,7" - 2000 - "628,3" = "1785,4" "mm"^2$. $sum A_i x_i = -75000 + 18000 + 40000 - 5333 = -22333$, also $x_S = -"12,5" "mm"$. Nur das innere Rechteck liegt außermittig in $y$: $sum A_i y_i = -2000 dot 5 = -10000$, also $y_S = -"5,6" "mm"$.
][
*Prüfen:* In c) fehlt oben innen Material, deshalb rutscht der Schwerpunkt unter die $x$-Achse. Die dicke linke Wand zieht ihn nach links. Beide Vorzeichen passen.
]

#aufgabe(titel: "Schwerpunkte von T- und L-Profil (Variante)", art: "rechnen", quelle: "4.2", herkunft: "variante", vorlage: "TM1-Übung 6, Aufg. 6.1", minuten: 8,
  ergebnis: [T-Profil: $x_S = 30 "mm"$, $y_S approx "17,65" "mm"$; L-Profil: $x_S approx "18,03" "mm"$, $y_S approx "17,65" "mm"$],
  tipp: [Die Höhenlagen der Teilflächen ändern sich beim Verschieben nach links nicht, also auch $y_S$ nicht.],
)[
#if not web [*Aufgabe 25* #linebreak()]
*Gegeben und Annahmen*

Aufbau wie in Übung 6.1 a) und b), aber mit anderen Maßen (in mm): Fuß $60 times 6$, Steg $6 times 30$, Kopf $20 times 10$. Beim T-Profil liegen Steg und Kopf mittig, beim L-Profil bündig am linken Rand. Ursprung unten links.

*Gesucht*

#enum(numbering: "a)",
[Schwerpunkt des T-Profils.],
[Schwerpunkt des L-Profils.],
)
][
*Teilflächen:* Fuß $A_1 = 360$ bei $y_1 = 3$; Steg $A_2 = 180$ bei $y_2 = 6 + 15 = 21$; Kopf $A_3 = 200$ bei $y_3 = 36 + 5 = 41$. Gesamt $A = 740 "mm"^2$.
][
*a) T-Profil:* Symmetrie gibt $x_S = 30 "mm"$. $y_S = (1080 + 3780 + 8200)\/740 = 13060\/740 approx "17,65" "mm"$.
][
*b) L-Profil:* $y_S$ bleibt $"17,65" "mm"$, weil nur seitlich verschoben wird. $x$-Lagen: Fuß 30, Steg 3, Kopf 10. $x_S = (10800 + 540 + 2000)\/740 = 13340\/740 approx "18,03" "mm"$.
][
*Prüfen:* Steg und Kopf sitzen links, also muss $x_S$ links der Fußmitte (30 mm) liegen. 18 mm passt.
]

#aufgabe(titel: "Fünfeckfläche mit Rechteckausschnitt", art: "rechnen", quelle: "4.2", herkunft: "original", vorlage: "TM1-Übung 6, Aufg. 6.2", minuten: 10,
  ergebnis: [$x_S = 98\/26 approx "3,77"$, $y_S = 85\/39 approx "2,18"$ (Längeneinheit der Skizze)],
  tipp: [Rechteck unten, zwei Dreiecke darüber, Ausschnitt mit negativer Fläche.],
)[
#if not web [*Aufgabe 26* #linebreak()]
Gesucht ist die Lage des Schwerpunktes der dargestellten Fläche mit einem Rechteckausschnitt.
#align(center)[#image(abbildungen.at("tm1k4_ue62"), width: 50%)]

*Gegeben und Annahmen*

Ursprung unten links. Die Fläche ist unten 7 breit, links und rechts 2 hoch; die Spitze liegt bei $x = 5$ in der Höhe $y = 6$. Der Ausschnitt reicht von $x = 3$ bis $x = 4$ und von $y = 1$ bis $y = 3$.

*Gesucht*

#enum(numbering: "a)",
[Koordinaten $x_S$, $y_S$ des Flächenschwerpunkts.],
)
][
*Zerlegen:* Rechteck $7 times 2$ unten; darüber das linke Dreieck $(0;2)$, $(5;2)$, $(5;6)$ und das rechte Dreieck $(5;2)$, $(7;2)$, $(5;6)$; der Ausschnitt zählt negativ. Ein Dreiecksschwerpunkt ist der Mittelwert seiner drei Ecken.
][
*Tabelle:* Rechteck $A_1 = 14$, $("3,5"; 1)$. Linkes Dreieck $A_2 = 5 dot 4\/2 = 10$, $(10\/3; 10\/3)$. Rechtes Dreieck $A_3 = 2 dot 4\/2 = 4$, $(17\/3; 10\/3)$. Ausschnitt $A_4 = -2$, $("3,5"; 2)$. Gesamt $A = 26$.
][
*Ausrechnen:* $sum A x = 49 + "33,33" + "22,67" - 7 = 98$, also $x_S = 98\/26 approx "3,77"$. $sum A y = 14 + "33,33" + "13,33" - 4 = "56,67"$, also $y_S = "56,67"\/26 = 85\/39 approx "2,18"$.
][
*Prüfen:* Die Spitze liegt rechts der Mitte, deshalb liegt $x_S$ über $"3,5"$. Das meiste Material liegt unten, deshalb ist $y_S$ klein gegen die Höhe 6.
]

#aufgabe(titel: "Fünfeckfläche mit Ausschnitt (Variante)", art: "rechnen", quelle: "4.2", herkunft: "variante", vorlage: "TM1-Übung 6, Aufg. 6.2", minuten: 8,
  ergebnis: [$x_S = "115,5"\/27 approx "4,28"$, $y_S = "50,5"\/27 approx "1,87"$],
)[
#if not web [*Aufgabe 27* #linebreak()]
*Gegeben und Annahmen*

Eine Fläche wie in Übung 6.2, aber: unten 8 breit, links und rechts 2 hoch, Spitze bei $x = 6$ in der Höhe $y = 5$. Ein Rechteckausschnitt reicht von $x = 4$ bis $x = 5$ und von $y = 1$ bis $y = 2$. Ursprung unten links.

*Gesucht*

#enum(numbering: "a)",
[Koordinaten $x_S$, $y_S$ des Schwerpunkts.],
)
][
*Zerlegen:* Rechteck $8 times 2$: $A_1 = 16$ bei $(4; 1)$. Linkes Dreieck $(0;2)$, $(6;2)$, $(6;5)$: $A_2 = 6 dot 3\/2 = 9$ bei $(4; 3)$. Rechtes Dreieck $(6;2)$, $(8;2)$, $(6;5)$: $A_3 = 3$ bei $(20\/3; 3)$. Ausschnitt $A_4 = -1$ bei $("4,5"; "1,5")$.
][
*Ausrechnen:* $A = 27$. $sum A x = 64 + 36 + 20 - "4,5" = "115,5"$, $x_S approx "4,28"$. $sum A y = 16 + 27 + 9 - "1,5" = "50,5"$, $y_S approx "1,87"$.
][
*Prüfen:* Die Spitze bei $x = 6$ zieht den Schwerpunkt rechts über die Mitte 4; das Loch rechts der Mitte verschiebt ihn nur wenig zurück.
]

#aufgabe(titel: "Loch so setzen, dass der Schwerpunkt passt", art: "rechnen", quelle: "4.2", herkunft: "original", vorlage: "TM1-Übung 6, Aufg. 6.3", minuten: 10,
  ergebnis: [$y approx "36,3" "cm"$ (Lochmitte über der Unterkante)],
  tipp: [Schreibe die Schwerpunktformel mit dem Loch als negativer Fläche hin und löse nach der unbekannten Lochlage auf.],
)[
#if not web [*Aufgabe 28* #linebreak()]
In welchem Abstand $y$ muss das Loch in die abgebildete Platte eingeschnitten werden, wenn der Schwerpunkt die eingezeichnete Lage haben soll?
#align(center)[#image(abbildungen.at("tm1k4_ue63"), width: 40%)]

*Gegeben und Annahmen*

Fuß $40 times 10 "cm"$, darauf mittig ein Steg $20 times 50 "cm"$. Kreisloch $d = 15 "cm"$ auf der Mittelachse. Der Schwerpunkt soll bei $y_S = 25 "cm"$ über der Unterkante liegen; $y$ ist die Höhe der Lochmitte über der Unterkante.

*Gesucht*

#enum(numbering: "a)",
[Der Abstand $y$.],
)
][
*Bild:* In $x$ ist alles symmetrisch, nur die Höhe zählt. Das Loch ist eine negative Fläche mit unbekannter Lage $y$, alle anderen Größen sind bekannt.
][
*Teilflächen:* Fuß $A_1 = 400 "cm"^2$ bei $y_1 = 5$; Steg $A_2 = 1000 "cm"^2$ bei $y_2 = 10 + 25 = 35$; Loch $A_3 = pi dot "7,5"^2 = "176,7" "cm"^2$ bei $y$.
][
*Ansatz:* $y_S (A_1 + A_2 - A_3) = A_1 y_1 + A_2 y_2 - A_3 y$. Aufgelöst: $y = (A_1 y_1 + A_2 y_2 - y_S (A_1 + A_2 - A_3))\/A_3 = (2000 + 35000 - 25 dot "1223,3")\/"176,7" approx "36,3" "cm"$.
][
*Prüfen:* Ohne Loch läge der Schwerpunkt bei $37000\/1400 = "26,4" "cm"$. Um ihn auf 25 cm zu senken, muss oben Material weg, also muss das Loch über 26,4 cm sitzen. 36,3 cm passt, und das Loch (36,3 ± 7,5) liegt ganz im Steg.
]

#aufgabe(titel: "Lochlage für einen vorgegebenen Schwerpunkt (Variante)", art: "rechnen", quelle: "4.2", herkunft: "variante", vorlage: "TM1-Übung 6, Aufg. 6.3", minuten: 8,
  ergebnis: [$y approx "53,6" "cm"$],
)[
#if not web [*Aufgabe 29* #linebreak()]
*Gegeben und Annahmen*

Platte wie in Übung 6.3, aber: Fuß $50 times 10 "cm"$, Steg $20 times 60 "cm"$ (mittig), Kreisloch $d = 12 "cm"$ auf der Mittelachse. Der Schwerpunkt soll bei $y_S = 28 "cm"$ über der Unterkante liegen.

*Gesucht*

#enum(numbering: "a)",
[Höhe $y$ der Lochmitte über der Unterkante.],
)
][
*Teilflächen:* Fuß $A_1 = 500$ bei $y_1 = 5$; Steg $A_2 = 1200$ bei $y_2 = 10 + 30 = 40$; Loch $A_3 = pi dot 6^2 = "113,1" "cm"^2$.
][
*Auflösen:* $y = (2500 + 48000 - 28 (1700 - "113,1"))\/"113,1" = (50500 - "44433")\/"113,1" approx "53,6" "cm"$.
][
*Prüfen:* Ohne Loch: $50500\/1700 = "29,7" "cm"$. Das Loch muss oberhalb davon sitzen, um den Schwerpunkt auf 28 cm zu senken. Es reicht von 47,6 bis 59,6 cm und liegt damit im Steg (10 bis 70 cm).
]

#kapitel("TM1 Kapitel 5 · Lagerreaktionen und statische Bestimmtheit")

#aufgabe(titel: "Was Loslager, Gelenk und Einspannung übertragen", art: "verstehen", quelle: "5.1", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 30* #linebreak()]
Welche Reaktionen liefern ein seitliches Loslager, ein inneres Drehgelenk und eine feste Einspannung?
][
Seitliches Loslager: eine horizontale Kraft. Drehgelenk: zwei Kraftkomponenten, kein Moment. Einspannung: zwei Kräfte und ein Moment.
]

#aufgabe(titel: "Was bedeutet die Wertigkeit eines Lagers?", art: "verstehen", quelle: "5.1", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 31* #linebreak()]
Was bedeutet die Wertigkeit eines Lagers?
][
*Antwort:*
- Die Anzahl der Reaktionen, die es übertragen kann:
- *Loslager:* 1 (Kraft senkrecht zur Gleitebene)
- *Festlager:* 2 (zwei Kräfte)
- *Feste Einspannung:* 3 (zwei Kräfte und ein Moment)
#align(center)[#image(abbildungen.at("tm1k2_lager1"), width: 60%)]
][
*Merksatz:* Eben: Loslager eins, Festlager zwei, Einspannung drei.
][
*Bild:* Ein Lager überträgt genau die Bewegungen, die es verhindert. Was es zulässt (Gleiten, Drehen), kostet nichts.
]

#aufgabe(titel: "Reaktionen einer festen Einspannung", art: "verstehen", quelle: "5.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 32* #linebreak()]
Wie viele unbekannte Reaktionen liefert eine feste Einspannung in der Ebene?
][
*Antwort:* 3. Zwei Kräfte und ein Moment, weil beide Verschiebungen und die Drehung gesperrt sind.
][
*Typische Verwechslung:* 1: Das ist ein Loslager oder eine Pendelstütze.
]

#aufgabe(titel: "Abzählkriterium reicht nicht", art: "verstehen", quelle: "5.3.2", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 33* #linebreak()]
Warum beweist $r+v=3n$ allein noch keine statische Bestimmtheit?
][
Die Gleichungen können geometrisch abhängig sein, etwa bei ungünstig angeordneten Reaktionslinien. Deshalb müssen Beweglichkeit und wirksame Bindungen zusätzlich anschaulich geprüft werden.
]

#aufgabe(titel: "Statische Bestimmtheit des Rahmens 2018", art: "verstehen", quelle: "5.3.2", herkunft: "original", vorlage: "Altklausur 2018, Aufg. 1 a)", minuten: 2,
)[
#if not web [*Aufgabe 34* #linebreak()]
Rahmen A–B–G–C–D–E mit fester Einspannung bei A, Parallelführung bei E und Gelenk bei G. Ist das System statisch bestimmt? Prüfe formal (Gleichung erfüllt?) und anschaulich (beweglich, unbeweglich, vorspannbar?).
#align(center)[#image(abbildungen.at("ak_2018_rahmen"), width: 80%)]
][
*Formal:* Zwei Teilkörper (A–B–G und G–C–D–E) liefern $3 n = 6$ Gleichungen. Unbekannte: Einspannung 3, Parallelführung 2, Gelenk 2, zusammen $r + v = 7$. $7 > 6$: einfach statisch unbestimmt.
][
*Anschaulich:* Das System ist unbeweglich und vorspannbar: Wird es zwischen A und E zusammengedrückt, entstehen Kräfte ohne äußere Last. Deshalb rechnet die Klausur danach mit einem geänderten System (Festlager in A und E) weiter, das mit $2 + 2 + 2 = 6$ bestimmt ist.
]

#aufgabe(titel: "Bestimmtheit des Rahmens SS 2016", art: "verstehen", quelle: "5.3.2", herkunft: "original", vorlage: "Altklausur SS 16, Aufg. 1 a)", minuten: 2,
)[
#if not web [*Aufgabe 35* #linebreak()]
Ein Rahmen hat in A eine Parallelführung, in C eine Pendelstütze und in G ein Gelenk. Ist das System statisch bestimmt?
#align(center)[#image(abbildungen.at("ak_ss16_rahmen"), width: 75%)]
][
*Abzählen:* Lager $2 + 1 = 3$, Gelenk 2, zusammen 5 Unbekannte. Zwei Teilkörper brauchen $3 dot 2 = 6$.
][
*Folgerung:* $5 < 6$: Das System ist beweglich (es kann sich waagerecht verschieben) und taugt nicht als Tragwerk. Die Klausur rechnet deshalb mit Festlagern in A und C und einem Querkraftgelenk in G weiter.
]

#aufgabe(titel: "Bestimmtheit des Gelenkträgers SS 24", art: "verstehen", quelle: "5.3.2", herkunft: "original", vorlage: "Altklausur SS 24, Aufg. 1 a)", minuten: 2,
)[
#if not web [*Aufgabe 36* #linebreak()]
Das System aus Altklausur SS 24 besteht aus zwei starren Teilen (T-Träger und Scheibe), die im Gelenk G verbunden sind. Die Lager übertragen zusammen vier Reaktionen. Ist das System statisch bestimmt?
#align(center)[#image(abbildungen.at("ak24-system"), width: 80%)]
][
*Abzählen:* $n = 2$ Teile, Gelenk $v = 2$, Lager $r = 4$. Bedingung $r + v = 3 n$: $4 + 2 = 6 = 3 dot 2$. Formal erfüllt.
][
*Geometrie prüfen:* Die Zählung ist nur notwendig. Erst wenn kein Teil verschieblich ist (keine drei Lagerkräfte durch einen Punkt, nicht alle parallel), ist das System wirklich statisch bestimmt. Das ist hier der Fall, deshalb lassen sich alle sechs Reaktionen eindeutig ausrechnen.
]

#aufgabe(titel: "Abzählen bei zwei Teilkörpern mit vier Lager- und zwei Gelenkreaktionen", art: "verstehen", quelle: "5.3.2", herkunft: "eigen", minuten: 3,
  tipp: [$r + v = 3n$],
)[
#if not web [*Aufgabe 37* #linebreak()]
Ein System aus zwei Teilkörpern ($n = 2$) hat $r = 4$ äußere Lagerreaktionen und $v = 2$ Gelenkreaktionen. Was folgt?
][
*Antwort:* Die Abzählbedingung $r + v = 3n$ ist erfüllt, die Geometrie muss noch geprüft werden. $4 + 2 = 6 = 3 dot 2$. Erst wenn das System unbeweglich ist, ist es statisch bestimmt.
][
*Typische Verwechslung:* Es ist sicher statisch bestimmt.: Die Abzählbedingung ist nur notwendig. Ob die Lagerung geometrisch wirksam ist, muss man zusätzlich prüfen.
]

#aufgabe(titel: "Wie geht man bei einem System aus mehreren Körpern mit Gelenk vor?", art: "verstehen", quelle: "5.3.3", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 38* #linebreak()]
Wie geht man bei einem System aus mehreren Körpern mit Gelenk vor?
][
*Antwort:*
- Man schneidet am Gelenk auf und stellt für jeden Teilkörper die drei Gleichgewichtsbedingungen auf.
- Am besten beginnt man mit Momentengleichungen um Punkte, durch die viele Unbekannte gehen.
- Am Ende prüft man das Ergebnis am Gesamtsystem.
]

#aufgabe(titel: "Warum prüft man die Lagerreaktionen am Gesamtsystem?", art: "verstehen", quelle: "5.3.3", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 39* #linebreak()]
Warum prüft man die Lagerreaktionen am Gesamtsystem?
][
*Antwort:*
- Das Gesamtsystem liefert drei unabhängige Kontrollgleichungen, die man nicht zum Lösen gebraucht hat.
- Geht dort etwas nicht auf, steckt irgendwo ein Vorzeichen- oder Hebelarmfehler.
]

#aufgabe(titel: "Momentenbezugspunkt geschickt wählen", art: "verstehen", quelle: "5.3.3", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 40* #linebreak()]
Wie wählst Du den Momentenbezugspunkt bei der Berechnung von Lagerreaktionen geschickt?
][
*Antwort:* So, dass möglichst viele unbekannte Kräfte durch den Punkt gehen. Kräfte durch den Bezugspunkt erzeugen kein Moment. So bleibt im Idealfall nur eine Unbekannte übrig.
][
*Typische Verwechslung:* Immer im linken Lager: Eine feste Regel gibt es nicht. Es kommt auf die Lage der Unbekannten an.
]

#aufgabe(titel: "Balken mit fünf Lasten auf zwei Lagern", art: "rechnen", quelle: "5.3.3", herkunft: "original", vorlage: "TM1-Übung 7, Aufg. 7.1", minuten: 10,
  ergebnis: [$B_H = -"1,41" "kN"$ (zeigt nach links), $B_V = "6,30" "kN"$, $A_V = "7,11" "kN"$],
  tipp: [B ist das Festlager. Die Momentensumme um A enthält $A_V$ nicht, damit hast du sofort $B_V$.],
)[
#if not web [*Aufgabe 41* #linebreak()]
Berechnen Sie für den abgebildeten Balken die Lagerreaktionen.
#align(center)[#image(abbildungen.at("tm1k5_ue71"), width: 60%)]

*Gegeben und Annahmen*

$F_1 = 4 "kN"$, $F_2 = 2 "kN"$, $F_3 = 3 "kN"$, $M_0 = 4 "kNm"$, $q_0 = 5 "kN/m"$, $a = 1 "m"$, $alpha = 45°$. A ist ein Loslager (nur senkrecht), B ein Festlager am rechten Ende ($x = 3a$). $F_1$ wirkt senkrecht nach unten genau über A, $F_2$ bei $x = a$ schräg nach rechts unten unter $alpha$ gegen den Balken, $q_0$ von $a$ bis $2a$, $F_3$ bei $2a$ senkrecht nach unten, $M_0$ im Uhrzeigersinn bei B.

*Gesucht*

#enum(numbering: "a)",
[Die Lagerreaktionen $A_V$, $B_H$ und $B_V$.],
)
][
*Bild:* Freischneiden: bei A eine senkrechte Kraft $A_V$ nach oben, bei B $B_H$ nach rechts und $B_V$ nach oben (Ansatzrichtungen frei, das Vorzeichen zeigt am Ende die wahre Richtung). Die Streckenlast wird durch $q_0 a = 5 "kN"$ in ihrer Mitte bei $"1,5" a$ ersetzt.
][
*$F_2$ zerlegen:* waagerecht $F_2 cos 45° = "1,414" "kN"$ nach rechts, senkrecht $F_2 sin 45° = "1,414" "kN"$ nach unten.
][
*Waagerecht:* $B_H + "1,414" = 0$, also $B_H = -"1,41" "kN"$. Das Minus heißt: $B_H$ zeigt nach links.
][
*Momente um A (gegen den Uhrzeigersinn positiv):* $-"1,414" dot 1 - 5 dot "1,5" - 3 dot 2 - 4 + 3 B_V = 0$. $F_1$ greift in A an und hat keinen Hebelarm. $B_V = "18,91"\/3 = "6,30" "kN"$.
][
*Senkrecht:* $A_V = F_1 + "1,414" + 5 + F_3 - B_V = 4 + "1,414" + 5 + 3 - "6,30" = "7,11" "kN"$.
][
*Prüfen:* Momente um B: $3 dot (F_1 - A_V) + 2 dot "1,414" + "1,5" dot 5 + 1 dot 3 - 4 = 3 dot (-"3,11") + "2,83" + "7,5" + 3 - 4 approx 0$. Passt.
]

#aufgabe(titel: "Balken mit fünf Lasten (Variante)", art: "rechnen", quelle: "5.3.3", herkunft: "variante", vorlage: "TM1-Übung 7, Aufg. 7.1", minuten: 8,
  ergebnis: [$B_H = -2 "kN"$, $B_V approx "6,15" "kN"$, $A_V approx "8,31" "kN"$],
)[
#if not web [*Aufgabe 42* #linebreak()]
*Gegeben und Annahmen*

Balken wie in Übung 7.1 (Loslager A links, Festlager B bei $3a$), aber $F_1 = 3 "kN"$, $F_2 = 4 "kN"$ unter $alpha = 60°$ gegen den Balken (nach rechts unten), $F_3 = 2 "kN"$, $M_0 = 3 "kNm"$ im Uhrzeigersinn bei B, $q_0 = 4 "kN/m"$ von $a$ bis $2a$, $a = "1,5" "m"$.

*Gesucht*

#enum(numbering: "a)",
[$A_V$, $B_H$, $B_V$.],
)
][
*Zerlegen:* $F_2$ waagerecht $4 cos 60° = 2 "kN"$ (rechts), senkrecht $4 sin 60° = "3,464" "kN"$ (unten). Streckenlast $q_0 a = 6 "kN"$ bei $"1,5" a = "2,25" "m"$.
][
*Waagerecht:* $B_H = -2 "kN"$ (nach links).
][
*Momente um A:* $-"3,464" dot "1,5" - 6 dot "2,25" - 2 dot 3 - 3 + B_V dot "4,5" = 0$, also $B_V = ("5,196" + "13,5" + 6 + 3)\/"4,5" approx "6,15" "kN"$.
][
*Senkrecht:* $A_V = 3 + "3,464" + 6 + 2 - "6,15" approx "8,31" "kN"$.
][
*Prüfen:* Die Summe aller senkrechten Lasten ist $"14,46" "kN"$, und $A_V + B_V = "14,46" "kN"$. Passt.
]

#aufgabe(titel: "Winkelträger und Pendelstabsystem", art: "rechnen", quelle: "5.3.3", herkunft: "original", vorlage: "TM1-Übung 7, Aufg. 7.2", minuten: 12,
  ergebnis: [a) $A_H = -F$, $A_V = -c\/a dot F$, $B_V = c\/a dot F$; b) $B = F$, $S_1 = -sqrt(2) F$ (Druck), $S_2 = F$ (Zug)],
  tipp: [In b) schneiden sich beide Pendelstäbe im selben Gelenkpunkt. Die Momentensumme um diesen Punkt liefert $B$ allein.],
)[
#if not web [*Aufgabe 43* #linebreak()]
Bestimmen Sie die Lagerreaktionen für die in a) und b) dargestellten Systeme.
#align(center)[#image(abbildungen.at("tm1k5_ue72"), width: 95%)]

*Gegeben und Annahmen*

a) Waagerechter Balken mit Festlager A links und Loslager B im Abstand $a$; nach weiteren $b$ steigt bei C ein senkrechter Arm der Höhe $c$ auf, oben greift $F$ waagerecht nach rechts an. b) Starrer Körper, der im Punkt K (Höhe $a$ über dem Boden) von zwei Pendelstäben gehalten wird: ein senkrechter Stab nach unten und ein Stab unter 45° nach links unten zu einem Bodenlager im Abstand $a$. Senkrecht über K, $a$ höher, greift $F$ waagerecht nach links an. Rechts liegt der Körper bei B ($2a$ rechts von K, auf Bodenhöhe) auf einem Loslager; $a$ weiter rechts wirkt $F$ senkrecht nach unten. Stabkräfte als Zug positiv.

*Gesucht*

#enum(numbering: "a)",
[$A_H$, $A_V$, $B_V$ für System a).],
[$S_1$ (Schrägstab), $S_2$ (senkrechter Stab) und $B$ für System b).],
)
][
*a) Gleichgewicht:* Waagerecht: $A_H + F = 0$, also $A_H = -F$. Momente um A: $F$ greift in der Höhe $c$ an und dreht im Uhrzeigersinn: $-F c + B_V a = 0$, also $B_V = c\/a dot F$. Senkrecht: $A_V = -B_V = -c\/a dot F$ (A wird nach unten gezogen).
][
*b) Freischneiden:* Pendelstäbe übertragen nur Kräfte in Stabrichtung. Schneide sie durch und setze $S_1$ und $S_2$ als Zug an (vom Körper weg zeigend). So bleiben drei Unbekannte: $S_1$, $S_2$, $B$.
][
*b) Momente um K:* Beide Stabkräfte gehen durch K und fallen heraus. Mit K als Ursprung: linke Kraft $F$ in der Höhe $+a$ nach links: $+F a$; Kraft $F$ bei $(3a; -a)$ nach unten: $-3 F a$; $B$ bei $(2a; -a)$ nach oben: $+2 a B$. Also $F a - 3 F a + 2 a B = 0$ und $B = F$.
][
*b) Kräfte:* Waagerecht: $-F - S_1\/sqrt(2) = 0$, also $S_1 = -sqrt(2) F$ (Druck). Senkrecht: $B - F - S_2 - S_1\/sqrt(2) = 0$, also $S_2 = F - F + F = F$ (Zug).
][
*Prüfen:* Die Kurzlösung des Blattes nennt $S_1 = sqrt(2) F$ und $S_2 = -F$: gleiche Beträge, nur mit anderer Ansatzrichtung. Anschaulich drückt der Schrägstab den Körper gegen die linke Kraft nach rechts, also Druck; das passt.
]

#aufgabe(titel: "Winkelträger und Pendelstabsystem (Variante)", art: "rechnen", quelle: "5.3.3", herkunft: "variante", vorlage: "TM1-Übung 7, Aufg. 7.2", minuten: 10,
  ergebnis: [a) $A_H = -6 "kN"$, $A_V = -"4,5" "kN"$, $B_V = "4,5" "kN"$; b) $B = "2,5" F$, $S_1 = -sqrt(2) F$, $S_2 = "1,5" F$],
)[
#if not web [*Aufgabe 44* #linebreak()]
*Gegeben und Annahmen*

Systeme wie in Übung 7.2. a) $a = 2 "m"$, $b = 1 "m"$, $c = "1,5" "m"$, $F = 6 "kN"$. b) Gleiche Geometrie, links oben wirkt $F$ nach links, am rechten Ende aber $2F$ nach unten. Stabkräfte als Zug positiv.

*Gesucht*

#enum(numbering: "a)",
[$A_H$, $A_V$, $B_V$ in System a).],
[$S_1$, $S_2$, $B$ in System b).],
)
][
*a):* $A_H = -6 "kN"$. Momente um A: $-6 dot "1,5" + 2 B_V = 0$, $B_V = "4,5" "kN"$, und $A_V = -"4,5" "kN"$.
][
*b) Momente um K:* $F a - 3a dot 2F + 2a B = 0$, also $B = "2,5" F$.
][
*b) Kräfte:* Waagerecht wie vorher $S_1 = -sqrt(2) F$. Senkrecht: $"2,5" F - 2F - S_2 + F = 0$, also $S_2 = "1,5" F$.
][
*Prüfen:* Nur die rechte Last hat sich verdoppelt; der Schrägstab hält weiterhin nur die waagerechte Kraft, deshalb bleibt $S_1$ gleich.
]

#aufgabe(titel: "Rahmen mit ungleich hohen Lagern", art: "rechnen", quelle: "5.3.3", herkunft: "original", vorlage: "TM1-Übung 7, Aufg. 7.3", minuten: 10,
  ergebnis: [$A_H = "598,1" "N"$, $A_V = "598,1" "N"$, $B = "901,9" "N"$],
  tipp: [Lege den Ursprung in A. Dann steht B bei $(2a; -a)$, die obere Ecke rechts bei $(2a; 2a)$.],
)[
#if not web [*Aufgabe 45* #linebreak()]
Für den nebenstehenden Rahmen sind die Lagerreaktionen zu ermitteln.
#align(center)[#image(abbildungen.at("tm1k5_ue73"), width: 40%)]

*Gegeben und Annahmen*

$alpha = 60°$, $F_1 = 2000 "N"$, $F_2 = 3000 "N"$, $a = 5 "m"$. Riegel der Länge $2a$. Festlager A unter der linken Stütze, $2a$ unter dem Riegel; Loslager B (senkrechte Kraft) unter der rechten Stütze, $3a$ unter dem Riegel. $F_1$ wirkt waagerecht nach rechts an der linken oberen Ecke, $F_2$ an der rechten oberen Ecke schräg nach links unten, unter $alpha$ gegen die Senkrechte.

*Gesucht*

#enum(numbering: "a)",
[$A_H$, $A_V$ und $B$.],
)
][
*Zerlegen:* $F_2$ waagerecht $3000 sin 60° = 2598 "N"$ nach links, senkrecht $3000 cos 60° = 1500 "N"$ nach unten.
][
*Waagerecht:* $A_H + 2000 - 2598 = 0$, also $A_H = "598,1" "N"$ nach rechts.
][
*Momente um A:* $F_1$ bei $(0; 2a)$: $-2a dot 2000 = -20000 "Nm"$. $F_2$ bei $(2a; 2a)$: $2a dot (-1500) - 2a dot (-2598) = +10981 "Nm"$. $B$ bei $(2a; -a)$: $+2a B = 10 B$. Summe null: $B = (20000 - 10981)\/10 = "901,9" "N"$.
][
*Senkrecht:* $A_V + B - 1500 = 0$, also $A_V = "598,1" "N"$.
][
*Prüfen:* Dass $A_H = A_V$ herauskommt, ist Zufall der Zahlen. Kontrolle mit Momenten um B ergibt ebenfalls null.
]

#aufgabe(titel: "Rahmen mit ungleich hohen Lagern (Variante)", art: "rechnen", quelle: "5.3.3", herkunft: "variante", vorlage: "TM1-Übung 7, Aufg. 7.3", minuten: 8,
  ergebnis: [$A_H = -500 "N"$, $A_V approx -500 "N"$, $B approx 2232 "N"$],
)[
#if not web [*Aufgabe 46* #linebreak()]
*Gegeben und Annahmen*

Rahmen wie in Übung 7.3, aber $alpha = 30°$ (gegen die Senkrechte), $F_1 = 1500 "N"$, $F_2 = 2000 "N"$, $a = 4 "m"$.

*Gesucht*

#enum(numbering: "a)",
[$A_H$, $A_V$, $B$.],
)
][
*Zerlegen:* $F_2$: waagerecht $2000 sin 30° = 1000 "N"$ nach links, senkrecht $2000 cos 30° = 1732 "N"$ nach unten.
][
*Waagerecht:* $A_H = 1000 - 1500 = -500 "N"$, zeigt also nach links.
][
*Momente um A:* $-2a dot 1500 - 2a dot 1732 + 2a dot 1000 + 2a B = 0$, also $B = 1500 + 1732 - 1000 = 2232 "N"$.
][
*Senkrecht:* $A_V = 1732 - 2232 = -500 "N"$: A wird nach unten gezogen. Das ist möglich, weil $F_1$ den Rahmen um B kippen will.
]

#aufgabe(titel: "Eingespannter gekröpfter Träger", art: "rechnen", quelle: "5.3.3", herkunft: "original", vorlage: "TM1-Übung 7, Aufg. 7.4", minuten: 8,
  ergebnis: [$A_H = -12 "kN"$, $A_V = 118 "kN"$, $M_A = 344 "kNm"$ (gegen den Uhrzeigersinn)],
  tipp: [Ersetze beide Streckenlasten durch ihre Resultierenden in der Mitte ihrer Länge.],
)[
#if not web [*Aufgabe 47* #linebreak()]
Der eingespannte, gekröpfte Träger ist wie abgebildet belastet. Zu bestimmen sind die Lagerreaktionen in der Einspannstelle A.
#align(center)[#image(abbildungen.at("tm1k5_ue74"), width: 45%)]

*Gegeben und Annahmen*

$F_1 = 10 "kN"$, $F_2 = 8 "kN"$, $q_1 = 3 "kN/m"$, $q_2 = 20 "kN/m"$, $a = 4 "m"$, $b = 5 "m"$, $c = 3 "m"$. Senkrechte Stütze der Höhe $a$ über A mit waagerechter Last $q_1$ (nach rechts), waagerechter Arm der Länge $b$ mit $q_2$ nach unten. $F_1$ wirkt im Abstand $c$ von der Stütze nach unten, $F_2$ am Armende nach unten.

*Gesucht*

#enum(numbering: "a)",
[$A_H$, $A_V$, $M_A$.],
)
][
*Resultierende:* $R_1 = q_1 a = 12 "kN"$ nach rechts in halber Stützenhöhe ($2 "m"$). $R_2 = q_2 b = 100 "kN"$ nach unten bei $b\/2 = "2,5" "m"$ rechts der Stütze.
][
*Kräfte:* Waagerecht: $A_H + 12 = 0$, also $A_H = -12 "kN"$. Senkrecht: $A_V = 100 + 10 + 8 = 118 "kN"$.
][
*Moment um A:* Alle Lasten drehen im Uhrzeigersinn: $12 dot 2 + 100 dot "2,5" + 10 dot 3 + 8 dot 5 = 24 + 250 + 30 + 40 = 344 "kNm"$. Die Einspannung muss also $M_A = 344 "kNm"$ gegen den Uhrzeigersinn aufbringen.
][
*Prüfen:* Größter Beitrag ist die große Streckenlast. Ein Fehler bei ihrem Hebelarm ($b\/2$, nicht $b$) wäre der häufigste Fehler hier.
]

#aufgabe(titel: "Eingespannter gekröpfter Träger (Variante)", art: "rechnen", quelle: "5.3.3", herkunft: "variante", vorlage: "TM1-Übung 7, Aufg. 7.4", minuten: 6,
  ergebnis: [$A_H = -6 "kN"$, $A_V = 50 "kN"$, $M_A = 117 "kNm"$],
)[
#if not web [*Aufgabe 48* #linebreak()]
*Gegeben und Annahmen*

Träger wie in Übung 7.4 mit $F_1 = 6 "kN"$, $F_2 = 4 "kN"$, $q_1 = 2 "kN/m"$, $q_2 = 10 "kN/m"$, $a = 3 "m"$, $b = 4 "m"$, $c = 2 "m"$.

*Gesucht*

#enum(numbering: "a)",
[$A_H$, $A_V$, $M_A$.],
)
][
*Resultierende:* $R_1 = 6 "kN"$ bei $"1,5" "m"$ Höhe, $R_2 = 40 "kN"$ bei $2 "m"$.
][
*Kräfte:* $A_H = -6 "kN"$, $A_V = 40 + 6 + 4 = 50 "kN"$.
][
*Moment:* $M_A = 6 dot "1,5" + 40 dot 2 + 6 dot 2 + 4 dot 4 = 9 + 80 + 12 + 16 = 117 "kNm"$ gegen den Uhrzeigersinn.
]

#aufgabe(titel: "Gekröpfter Träger mit seitlichem Lager", art: "rechnen", quelle: "5.3.3", herkunft: "original", vorlage: "TM1-Übung 7, Aufg. 7.5", minuten: 8,
  ergebnis: [$A_V = "3,5" "kN"$, $B_H = -"5,75" "kN"$ (nach links), $A_H = "2,75" "kN"$ (nach rechts)],
)[
#if not web [*Aufgabe 49* #linebreak()]
Ein gekröpfter Träger ist wie abgebildet gelagert und wird mit zwei Kräften und einer Streckenlast belastet. Zu bestimmen sind die Lagerreaktionen.
#align(center)[#image(abbildungen.at("tm1k5_ue75"), width: 45%)]

*Gegeben und Annahmen*

$F_1 = 3 "kN"$, $F_2 = "1,5" "kN"$, $q = 1 "kN/m"$, $a = 1 "m"$. Festlager A im Ursprung. Ein Schrägstab führt zum Knick bei $(a; a)$, dort greift $F_1$ waagerecht nach rechts an. Von dort läuft ein waagerechter Teil bis $(3a; a)$ mit $q$ nach unten; am Ende wirkt $F_2$ nach unten. Ein senkrechter Arm führt hoch bis $(3a; 2a)$, wo das Lager B nur eine waagerechte Kraft aufnimmt.

*Gesucht*

#enum(numbering: "a)",
[$A_H$, $A_V$, $B_H$.],
)
][
*Senkrecht:* B nimmt nichts Senkrechtes auf: $A_V = q dot 2a + F_2 = 2 + "1,5" = "3,5" "kN"$.
][
*Momente um A:* $F_1$ bei Höhe $a$: $-3 dot 1$; Streckenlast $2 "kN"$ bei $x = 2a$: $-2 dot 2$; $F_2$ bei $x = 3a$: $-"1,5" dot 3$; $B_H$ (Ansatz nach rechts) bei Höhe $2a$: $-2 B_H$. Summe: $-3 - 4 - "4,5" - 2 B_H = 0$, also $B_H = -"5,75" "kN"$ (nach links).
][
*Waagerecht:* $A_H + 3 - "5,75" = 0$, also $A_H = "2,75" "kN"$ nach rechts.
][
*Prüfen:* Das Lösungsblatt schreibt $A_H = -"2,75" "kN"$ mit Ansatz nach links und vermerkt, dass die Kraft nach rechts wirkt. Das ist dasselbe Ergebnis.
]

#aufgabe(titel: "Gekröpfter Träger mit seitlichem Lager (Variante)", art: "rechnen", quelle: "5.3.3", herkunft: "variante", vorlage: "TM1-Übung 7, Aufg. 7.5", minuten: 6,
  ergebnis: [$A_V = 9 "kN"$, $B_H = -"11,5" "kN"$, $A_H = "9,5" "kN"$],
)[
#if not web [*Aufgabe 50* #linebreak()]
*Gegeben und Annahmen*

Träger wie in Übung 7.5 mit $F_1 = 2 "kN"$, $F_2 = 3 "kN"$, $q = 2 "kN/m"$, $a = "1,5" "m"$.

*Gesucht*

#enum(numbering: "a)",
[$A_H$, $A_V$, $B_H$.],
)
][
*Senkrecht:* $A_V = 2 dot 3 + 3 = 9 "kN"$.
][
*Momente um A:* $-2 dot "1,5" - 6 dot 3 - 3 dot "4,5" - 3 B_H = 0$, also $B_H = -"34,5"\/3 = -"11,5" "kN"$.
][
*Waagerecht:* $A_H = -F_1 - B_H = -2 + "11,5" = "9,5" "kN"$.
]

#aufgabe(titel: "Stufentragwerk mit Pendelstab", art: "rechnen", quelle: "5.3.3", herkunft: "original", vorlage: "TM1-Übung 7, Aufg. 7.6", minuten: 15,
  ergebnis: [$S = q_0 a$, $B_H = q_0 a\/2$, $A_H = -q_0 a\/2$, $E_H = F_H = 3\/4 q_0 a$, $F_V = 2 q_0 a$],
  tipp: [Der senkrechte Stab C–D ist ein Pendelstab. Schneide ihn durch: Er überträgt nur eine Kraft $S$ in Stabrichtung.],
)[
#if not web [*Aufgabe 51* #linebreak()]
Bestimmen Sie die Lager- und Gelenkreaktionen für das dargestellte mehrteilige Tragwerk.
#align(center)[#image(abbildungen.at("tm1k5_ue76"), width: 45%)]

*Gegeben und Annahmen*

Teil 1: Stütze A–B (Höhe $a$) und Riegel B–C (Länge $a$) mit $q_0$. A und B sind nur waagerecht gehalten. Von C geht ein senkrechter Pendelstab nach oben zu D. Teil 2: Riegel D–E (Länge $a$) mit $q_0$ und Stütze E–F (Höhe $2a$). E ist waagerecht gehalten, F ist ein Festlager.

*Gesucht*

#enum(numbering: "a)",
[Pendelstabkraft $S$ und die Lagerkräfte $A_H$, $B_H$, $E_H$, $F_H$, $F_V$.],
)
][
*Teil 1 freischneiden:* Lasten: $R = q_0 a$ in der Mitte von B–C. Reaktionen: $A_H$, $B_H$ waagerecht und $S$ senkrecht bei C (Ansatz nach oben, also Druck im Stab).
][
*Teil 1 Gleichgewicht:* Senkrecht: $S - R = 0$, also $S = q_0 a$. Momente um A: $-B_H a - R a\/2 + S a = 0$, also $B_H = S - R\/2 = q_0 a\/2$. Waagerecht: $A_H + B_H = 0$, $A_H = -q_0 a\/2$.
][
*Teil 2 freischneiden:* Bei D drückt der Stab mit $S$ nach unten. Dazu $R = q_0 a$ in der Mitte von D–E, $E_H$ bei E, $F_H$ und $F_V$ bei F.
][
*Teil 2 Gleichgewicht:* Senkrecht: $F_V = S + R = 2 q_0 a$. Momente um F: $-2a E_H + R dot a\/2 + S a = 0$, also $E_H = 3\/4 q_0 a$. Waagerecht: $E_H - F_H = 0$, $F_H = 3\/4 q_0 a$.
][
*Prüfen:* Teil 1 hat drei Unbekannte, deshalb fängt man dort an. Teil 2 bekommt $S$ als bekannte Last. Insgesamt 6 Gleichungen für 6 Unbekannte.
]

#aufgabe(titel: "Stufentragwerk mit Pendelstab (Variante)", art: "rechnen", quelle: "5.3.3", herkunft: "variante", vorlage: "TM1-Übung 7, Aufg. 7.6", minuten: 12,
  ergebnis: [$S = 2 q_0 a$, $B_H = q_0 a$, $A_H = -q_0 a$, $E_H = F_H = "1,25" q_0 a$, $F_V = 3 q_0 a$],
)[
#if not web [*Aufgabe 52* #linebreak()]
*Gegeben und Annahmen*

Tragwerk wie in Übung 7.6, aber auf dem Riegel B–C liegt $2 q_0$, auf dem Riegel D–E weiterhin $q_0$.

*Gesucht*

#enum(numbering: "a)",
[$S$, $A_H$, $B_H$, $E_H$, $F_H$, $F_V$.],
)
][
*Teil 1:* $R_1 = 2 q_0 a$ in der Mitte von B–C. Senkrecht: $S = R_1 = 2 q_0 a$. Momente um A: $-B_H a - R_1 a\/2 + S a = 0$, also $B_H = 2 q_0 a - q_0 a = q_0 a$, und $A_H = -q_0 a$.
][
*Teil 2:* $R_2 = q_0 a$. Senkrecht: $F_V = S + R_2 = 3 q_0 a$. Momente um F: $-2a E_H + R_2 a\/2 + S a = 0$, also $E_H = ("0,5" + 2)\/2 q_0 a = "1,25" q_0 a = F_H$.
][
*Prüfen:* Nur die Last auf Teil 1 hat sich verdoppelt; sie erreicht Teil 2 ausschließlich über den Pendelstab.
]

#aufgabe(titel: "Dreigelenkrahmen unter Gleichstreckenlast", art: "rechnen", quelle: "5.3.3", herkunft: "original", vorlage: "TM1-Übung 8, Aufg. 8.1", minuten: 12,
  ergebnis: [$A_V = B_V = 4 "kN"$, $A_H = B_H = 2 "kN"$ (beide nach innen), $C_H = 2 "kN"$, $C_V = 0$],
  tipp: [Gesamtsystem für die senkrechten Kräfte, dann eine Hälfte um das Gelenk C für die waagerechte Kraft.],
)[
#if not web [*Aufgabe 53* #linebreak()]
Bestimmen Sie die Lager- und Gelenkreaktionen für den dargestellten Dreigelenkbogen.
#align(center)[#image("abbildungen/ue1_8_1.png", width: 50%)]

*Gegeben und Annahmen*

Festlager A und B am Boden im Abstand $2a$, Stützen der Höhe $a$, Riegel mit Gelenk C in der Mitte. Gleichstreckenlast $q = "2,0" "kN/m"$ auf dem ganzen Riegel, $a = "2,00" "m"$.

*Gesucht*

#enum(numbering: "a)",
[Lagerkräfte in A und B, Gelenkkraft in C.],
)
][
*Bestimmtheit:* 2 Teile, $3 dot 2 = 6$ Gleichungen; Lager $2 + 2$ und Gelenk 2 ergeben 6 Unbekannte. Statisch bestimmt.
][
*Gesamtsystem:* Gesamtlast $q dot 2a = 8 "kN"$ in der Mitte. Momente um A: $-8 dot a + B_V dot 2a = 0$, also $B_V = 4 "kN"$, und $A_V = 4 "kN"$.
][
*Linke Hälfte um C:* Last $R = q a = 4 "kN"$ bei $a\/2$ links von C. Mit A bei $(-a; -a)$ relativ zu C: $-a A_V + a A_H + R a\/2 = 0$, also $A_H = A_V - R\/2 = 2 "kN"$ (Ansatz nach rechts, also nach innen).
][
*Rest:* Waagerecht im Gesamtsystem: $B_H = 2 "kN"$ nach innen. An der linken Hälfte: $C_H = -A_H$ betragsmäßig $2 "kN"$, $C_V = R - A_V = 0$.
][
*Prüfen:* Wegen der Symmetrie muss $C_V = 0$ sein. Der Horizontalschub $q a^2\/(2 a) = 2 "kN"$ ist typisch für Dreigelenkrahmen.
]

#aufgabe(titel: "Dreigelenkrahmen mit halbseitiger Last (Variante)", art: "rechnen", quelle: "5.3.3", herkunft: "variante", vorlage: "TM1-Übung 8, Aufg. 8.1", minuten: 10,
  ergebnis: [$A_V = "4,5" "kN"$, $B_V = "1,5" "kN"$, $A_H = B_H = "1,5" "kN"$ (nach innen), Gelenkkraft $C$: $"1,5" "kN"$ waagerecht und $"1,5" "kN"$ senkrecht],
  tipp: [Die rechte Hälfte ist unbelastet. Ihre Lagerkraft in B muss deshalb genau durch C zeigen.],
)[
#if not web [*Aufgabe 54* #linebreak()]
*Gegeben und Annahmen*

Dreigelenkrahmen wie in Übung 8.1 ($a = 2 "m"$), aber $q = 3 "kN/m"$ liegt nur auf der linken Riegelhälfte A–C.

*Gesucht*

#enum(numbering: "a)",
[Alle Lager- und Gelenkkräfte.],
)
][
*Gesamtsystem:* $R = q a = 6 "kN"$ bei $x = a\/2 = 1 "m"$. Momente um A: $-6 dot 1 + B_V dot 4 = 0$, also $B_V = "1,5" "kN"$, $A_V = "4,5" "kN"$.
][
*Rechte Hälfte um C:* Nur $B_V$ und $B_H$ greifen an. Mit B bei $(a; -a)$ relativ zu C: $a B_V + a B_H = 0$, also $B_H = -"1,5" "kN"$, d. h. $"1,5" "kN"$ nach links (nach innen).
][
*Rest:* Waagerecht im Gesamtsystem: $A_H = "1,5" "kN"$ nach rechts. An der rechten Hälfte: $C$ überträgt $"1,5" "kN"$ waagerecht und $"1,5" "kN"$ senkrecht (die Gegenkräfte zu $B$).
][
*Prüfen:* Die Kraft in B zeigt unter 45° genau auf C: ein unbelastetes Teil mit zwei Gelenken wirkt wie ein Pendelstab.
]

#aufgabe(titel: "Zweiteiliges Tragwerk mit Parallelführung", art: "rechnen", quelle: "5.3.3", herkunft: "original", vorlage: "TM1-Übung 8, Aufg. 8.2", minuten: 12,
  ergebnis: [$B_H = 1\/6 q_0 a$, $B_V = 0$, $C_H = 1\/3 q_0 a$, $C_V = 0$, $A_H = 1\/6 q_0 a$, $M_A = M_0 - 1\/12 q_0 a^2$],
  tipp: [Die Parallelführung A nimmt eine waagerechte Kraft und ein Moment auf, aber keine senkrechte Kraft.],
)[
#if not web [*Aufgabe 55* #linebreak()]
An dem nebenstehend dargestellten Tragwerk wirkt auf den Teilkörper BC eine dreiecksförmige Streckenlast. Im Bereich AB greift ein Einzelmoment $M_0$ an. Wie groß sind die Lagerreaktionen in A und C sowie die Gelenkreaktionen in B? (Hinweis: Lager A nimmt Momente auf!)
#align(center)[#image("abbildungen/ue1_8_2.png", width: 30%)]

*Gegeben und Annahmen*

Senkrechter Stab C–B der Länge $a$, C ist ein Festlager unten. Die Dreieckslast wirkt waagerecht nach rechts, $q_0$ bei C und 0 bei B. In B ein Gelenk; von B steigt ein Schrägstab zum Lager A an, das $a$ rechts und $a\/2$ höher liegt (Parallelführung an der Wand, senkrecht verschieblich). $M_0$ wirkt auf A–B im Uhrzeigersinn.

*Gesucht*

#enum(numbering: "a)",
[Gelenkkräfte in B, Lagerkräfte in C und A, Einspannmoment $M_A$.],
)
][
*Last ersetzen:* $R = q_0 a\/2$, Angriff im Schwerpunkt des Dreiecks, $a\/3$ über C (dort, wo die Last groß ist).
][
*Teil A–B senkrecht:* In A gibt es keine senkrechte Kraft und auf A–B wirkt keine senkrechte Last. Also $B_V = 0$, und damit am Teil B–C auch $C_V = 0$.
][
*Teil B–C, Momente um C:* $R dot a\/3 - B_H a = 0$, also $B_H = R\/3 = q_0 a\/6$ (am Stab B–C nach links). Waagerecht: $C_H = R - B_H = q_0 a\/3$ nach links.
][
*Teil A–B:* In B wirkt die Gegenkraft $q_0 a\/6$ nach rechts. Waagerecht: $A_H = q_0 a\/6$ nach links. Momente um A: die Kraft in B hat den Hebelarm $a\/2$ (Höhenunterschied) und liefert $q_0 a^2\/12$. Mit $M_0$ im Uhrzeigersinn: $M_A = M_0 - q_0 a^2\/12$.
][
*Prüfen:* Ohne Streckenlast nähme die Parallelführung genau $M_0$ auf. Die Streckenlast entlastet sie um $q_0 a^2\/12$.
]

#aufgabe(titel: "Zweiteiliges Tragwerk mit umgedrehter Dreieckslast (Variante)", art: "rechnen", quelle: "5.3.3", herkunft: "variante", vorlage: "TM1-Übung 8, Aufg. 8.2", minuten: 10,
  ergebnis: [$B_H = 1\/3 q_0 a$, $C_H = 1\/6 q_0 a$, $B_V = C_V = 0$, $A_H = 1\/3 q_0 a$, $M_A = M_0 - 1\/6 q_0 a^2$],
)[
#if not web [*Aufgabe 56* #linebreak()]
*Gegeben und Annahmen*

Tragwerk wie in Übung 8.2, aber die Dreieckslast ist umgedreht: 0 bei C und $q_0$ bei B (weiterhin nach rechts).

*Gesucht*

#enum(numbering: "a)",
[$B_H$, $B_V$, $C_H$, $C_V$, $A_H$, $M_A$.],
)
][
*Last:* $R = q_0 a\/2$ jetzt $2a\/3$ über C.
][
*Teil B–C:* Wie vorher $B_V = C_V = 0$. Momente um C: $R dot 2a\/3 = B_H a$, also $B_H = q_0 a\/3$, und $C_H = R - B_H = q_0 a\/6$.
][
*Teil A–B:* $A_H = q_0 a\/3$; Moment der Gelenkkraft um A: $q_0 a\/3 dot a\/2 = q_0 a^2\/6$, also $M_A = M_0 - q_0 a^2\/6$.
][
*Prüfen:* Die Last sitzt jetzt näher am Gelenk B, deshalb übernimmt B mehr und C weniger.
]

#aufgabe(titel: "Gleichgewicht einer Scheibe aufstellen", art: "rechnen", quelle: "5.3.3", herkunft: "original", vorlage: "Altklausur 2018, Aufg. 1 c)", minuten: 6,
  tipp: [Für jede Kraft: Moment $= Delta x dot F_V - Delta y dot F_H$, mit $Delta x$, $Delta y$ vom Bezugspunkt zum Angriffspunkt.],
)[
#if not web [*Aufgabe 57* #linebreak()]
Abb. 3 zeigt den Freischnitt einer Scheibe. Stellen Sie die geforderten Gleichgewichtsbedingungen auf. Verwenden Sie dabei das dargestellte globale H-V-Koordinatensystem.
#align(center)[#image("abbildungen/ak_2018_scheibe.png", width: 60%)]

*Gegeben und Annahmen*

Ursprung in E (unten links), H nach rechts, V nach oben. Punkte: A $(0; a)$, F $(0; a\/2)$, B $(a; a)$, C $(3a\/2; a\/2)$, D $(3a\/2; 0)$. In A: $A_H$ nach links und $F_1$ unter $alpha$ gegen die Waagerechte nach rechts oben. In B: $F_2$ unter $alpha$ gegen die Senkrechte nach rechts oben. In E: $E_H$ nach links, $E_V$ nach oben. Freie Momente: $M_1$ gegen den Uhrzeigersinn, $M_2$ im Uhrzeigersinn. $alpha eq.not 45°$.

*Gesucht*

#enum(numbering: "a)",
[$sum F_H = 0$, $sum F_V = 0$.],
[Momentensummen um C, um D und um F.],
)
][
*Kräfte:* $sum F_H: -A_H + F_1 cos alpha + F_2 sin alpha - E_H = 0$. $sum F_V: F_1 sin alpha + F_2 cos alpha + E_V = 0$.
][
*Um C:* $A_H a\/2 - F_1 (3a\/2 sin alpha + a\/2 cos alpha) - F_2 (a\/2 cos alpha + a\/2 sin alpha) - E_H a\/2 - 3a\/2 E_V + M_1 - M_2 = 0$.
][
*Um D:* $A_H a - F_1 (3a\/2 sin alpha + a cos alpha) - F_2 (a\/2 cos alpha + a sin alpha) - 3a\/2 E_V + M_1 - M_2 = 0$. $E_H$ fällt heraus, weil es auf der Höhe von D liegt.
][
*Um F:* $A_H a\/2 - F_1 a\/2 cos alpha + F_2 (a cos alpha - a\/2 sin alpha) - E_H a\/2 + M_1 - M_2 = 0$. $E_V$ und die senkrechte Komponente von $F_1$ fallen heraus, weil sie durch die Senkrechte durch F gehen.
][
*Prüfen:* Freie Momente gehen in jede Momentensumme gleich ein, egal um welchen Punkt. Jede Gleichung kontrolliert man, indem man die Drehrichtung jeder Kraft anschaulich prüft.
]

#aufgabe(titel: "Gleichgewicht einer Scheibe mit Zahlen (Variante)", art: "rechnen", quelle: "5.3.3", herkunft: "variante", vorlage: "Altklausur 2018, Aufg. 1 c)", minuten: 8,
  ergebnis: [$E_V approx -"3,60" "kN"$, $A_H approx "1,13" "kN"$, $E_H approx "2,10" "kN"$],
)[
#if not web [*Aufgabe 58* #linebreak()]
*Gegeben und Annahmen*

Scheibe wie in Altklausur 2018, Aufg. 1 c), mit $F_1 = 2 "kN"$, $F_2 = 3 "kN"$, $alpha = 30°$, $M_1 = 1 "kNm"$, $M_2 = 2 "kNm"$, $a = 2 "m"$.

*Gesucht*

#enum(numbering: "a)",
[$E_V$, $A_H$, $E_H$.],
)
][
*Senkrecht:* $E_V = -(2 sin 30° + 3 cos 30°) = -(1 + "2,598") = -"3,60" "kN"$, also nach unten.
][
*Momente um F:* $A_H dot 1 - 2 cos 30° dot 1 + 3 (2 cos 30° - sin 30°) - E_H dot 1 + 1 - 2 = 0$, also $A_H - E_H = "1,732" - "3,696" + 1 = -"0,964"$.
][
*Waagerecht:* $A_H + E_H = 2 cos 30° + 3 sin 30° = "3,232"$. Beide Gleichungen zusammen: $A_H = "1,13" "kN"$, $E_H = "2,10" "kN"$.
][
*Prüfen:* Eingesetzt in die Momentensumme um D ergibt sich null. Passt.
]

#aufgabe(titel: "Sechs Lagerreaktionen am Gelenkträger", art: "rechnen", quelle: "5.4", herkunft: "original", vorlage: "Altklausur SS 24, Aufg. 1 (Lagerreaktionen)", minuten: 14,
  ergebnis: [$G_V = 4q_0a$, $B_H = 3q_0a$, $G_H = 7q_0a$, $C_V = 4q_0a$, $D_H = -11q_0a\/2$, $C_H = 3q_0a\/2$],
  tipp: [Schneide am Gelenk G. Beginne mit dem Teil, an dem nur drei Unbekannte hängen.],
)[
#if not web [*Aufgabe 59* #linebreak()]
*AK24 S. 1, 3–7:*

*Gegeben und Annahmen*

Zwei starre Teilkörper, ideale Lager, Geometrie und Abstände wie in der beigefügten Skizze. $F_(R 1)=4q_0a$, $F_(R 2)=3q_0a$, $F=-4q_0a$; $q_0$ und $a$ bleiben symbolisch. Pfeilansatz am T-Träger: $G_H$ rechts, $G_V$ oben, $B_H$ links. An der Scheibe: Gegenkräfte im Gelenk, $D_H$ und $C_H$ links, $C_V$ oben.
#align(center)[#image(abbildungen.at("ak24-system"), width: 100%)]

*Gesucht*

#enum(numbering: "a)",
[Stelle für beide Teilkörper je drei unabhängige Gleichgewichte auf.],
[Bestimme alle sechs Reaktionen als Vielfache von $q_0a$ und prüfe das Gesamtsystem.],
)
][
*Modell:* starre Teilkörper, ideale Lager; Vorzeichen und Pfeile wie in 5.4. Zwei Körper mit je drei Gleichungen geben sechs Gleichungen für sechs Unbekannte. Am Gelenk G wirken auf beide Teile gleich große, entgegengesetzte Kräfte $G_H$, $G_V$.
][
*Gleichgewicht am T-Träger:*
$ G_V-4q_0a=0, quad F-B_H+G_H=0, quad 24q_0a^2+3a F-4a B_H=0 $
Die Momentengleichung bezieht sich auf G; so fallen $G_H$ und $G_V$ heraus. Aus der dritten Gleichung mit $F = -4q_0a$: $24q_0a^2 - 12q_0a^2 = 4a B_H$, also *$B_H = 3q_0a$*. Dann $G_H = B_H - F = 7q_0a$ und $G_V = 4q_0a$.
][
*Gleichgewicht an der Scheibe:*
$ C_V-G_V=0, quad -G_H-D_H-C_H+3q_0a=0, quad 2a G_V+6a G_H+8a D_H-6q_0a^2=0 $
Die Momentensumme bezieht sich auf C. Mit den bekannten Gelenkkräften: $8q_0a^2 + 42q_0a^2 + 8a D_H - 6q_0a^2 = 0$, also *$D_H = -11q_0a\/2$*. Dann $C_V = 4q_0a$ und $C_H = -7 + 11\/2 + 3 = 3\/2$, also *$C_H = 3q_0a\/2$*.
][
*Deuten:* $D_H$ ist negativ, D wirkt also entgegen seinem Ansatzpfeil nach rechts. Ein negatives Ergebnis ist kein Fehler, sondern zeigt nur die wahre Richtung.
][
*Prüfen am Gesamtsystem:* vertikal $-4+4=0$; horizontal $-4-3+11/2-3/2+3=0$ (jeweils in $q_0a$). Alle Reaktionen haben die Einheit $q_0a$, also Kraft.
]

#aufgabe(titel: "Sechs Lagerreaktionen am Gelenkträger (Variante)", art: "rechnen", quelle: "5.4", herkunft: "variante", vorlage: "Altklausur SS 24, Aufg. 1 (Lagerreaktionen)", minuten: 12,
  ergebnis: [$G_V = 4 q_0 a$, $B_H = 9\/2 q_0 a$, $G_H = 13\/2 q_0 a$, $C_V = 4 q_0 a$, $D_H = -41\/8 q_0 a$, $C_H = 13\/8 q_0 a$],
)[
#if not web [*Aufgabe 60* #linebreak()]
*Gegeben und Annahmen*

System wie in der AK24-Skizze (T-Träger und Scheibe, Gelenk G) mit denselben Streckenlasten ($F_(R 1) = 4 q_0 a$ mit Hebel $6a$ um G, $F_(R 2) = 3 q_0 a$ mit Hebel $2a$ um C), aber Einzelkraft $F = -2 q_0 a$. Pfeilansatz wie im Original.
#align(center)[#image(abbildungen.at("ak24-system"), width: 100%)]

*Gesucht*

#enum(numbering: "a)",
[Alle sechs Reaktionen als Vielfache von $q_0 a$.],
)
][
*T-Träger:* $G_V = 4 q_0 a$. Moment um G: $24 q_0 a^2 + 3a F - 4a B_H = 0$, also $B_H = (24 - 6)\/4 q_0 a = 9\/2 q_0 a$. $G_H = B_H - F = 13\/2 q_0 a$.
][
*Scheibe:* $C_V = G_V = 4 q_0 a$. Moment um C: $8 + 39 + 8 D_H\/(q_0 a) - 6 = 0$, also $D_H = -41\/8 q_0 a$. Waagrecht: $C_H = -G_H - D_H + 3 q_0 a = 13\/8 q_0 a$.
][
*Prüfen:* Gesamtsystem waagrecht $-2 - 9\/2 + 41\/8 - 13\/8 + 3 = 0$, senkrecht $-4 + 4 = 0$.
]

#kapitel("TM1 Kapitel 6 · Fachwerke: Nullstäbe und Ritterschnitt")

#aufgabe(titel: "Voraussetzungen des idealen Fachwerks", art: "verstehen", quelle: "6.1", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 61* #linebreak()]
Welche drei Voraussetzungen brauchst du für ein ideales Fachwerk?
][
Gerade, zwischen den Knoten unbelastete Stäbe; ideale Gelenke; äußere Kräfte greifen an Knoten an. Dann sind die Stäbe Zwei-Kräfte-Körper.
]

#aufgabe(titel: "Was sagt die Abzählbedingung 2k = s + r beim Fachwerk?", art: "verstehen", quelle: "6.1", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 62* #linebreak()]
Was sagt die Abzählbedingung $2k = s + r$ beim Fachwerk?
][
*Antwort:*
- Jeder Knoten liefert zwei Gleichgewichtsbedingungen ($2k$ Gleichungen).
- Unbekannt sind $s$ Stabkräfte und $r$ Lagerreaktionen.
- Gilt $2k = s + r$, ist das Fachwerk notwendig statisch bestimmt.
- Wie bei jeder Abzählung ist das nicht hinreichend.
]

#aufgabe(titel: "Nullstab heißt nicht überflüssig", art: "verstehen", quelle: "6.3.1", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 63* #linebreak()]
Warum ist „Stabkraft null“ nicht gleichbedeutend mit „Stab überflüssig“?
][
Nullstäbe können die Form stabilisieren und unter geänderter Last beansprucht werden. Im konkreten System müssen Stabilität und Belastungsfall geprüft werden.
]

#aufgabe(titel: "Nullstäbe und Ritterschnitt am Fachwerk 2018", art: "verstehen", quelle: "6.3.1", herkunft: "original", vorlage: "Altklausur 2018, Aufg. 1 g)", minuten: 4,
)[
#if not web [*Aufgabe 64* #linebreak()]
Fachwerk wie im Bild (A Festlager, B Loslager, $F$ in Knoten II und $2F$ in Knoten VI, 13 Stäbe über drei Felder der Breite $a$). a) Wie viele Nullstäbe hat das Fachwerk? Gib für jede der drei Nullstabregeln einen Stab an. b) Wie bestimmst du $S_6$, $S_7$ und $S_8$ am schnellsten? Keine Gleichgewichte aufstellen.
#align(center)[#image(abbildungen.at("ak_2018_fachwerk"), width: 70%)]
][
*a) Nullstäbe:* Vier. Knoten I: Stäbe 1 und 2 (Regel 1: unbelasteter Knoten mit zwei Stäben, die nicht auf einer Linie liegen). Knoten IV: Stab 5 (Regel 3: unbelasteter Knoten mit drei Stäben, zwei davon (4 und 8) auf einer Linie). Knoten VII (Lager B): Stab 10 (Regel 2: die äußere Kraft wirkt in Richtung von Stab 13).
][
*b) Ritterschnitt:* Schneide senkrecht durch die Stäbe 6, 7 und 8. Es sind drei Unbekannte, die nicht durch einen gemeinsamen Punkt gehen, also liefern drei Gleichgewichte am abgeschnittenen Teil alle drei Kräfte.
]

#aufgabe(titel: "Nullstäbe und Knotengleichgewicht SS 2016", art: "verstehen", quelle: "6.3.1", herkunft: "original", vorlage: "Altklausur SS 16, Aufg. 1 g)", minuten: 4,
)[
#if not web [*Aufgabe 65* #linebreak()]
Fachwerk wie im Bild (A Festlager, B waagerecht gestützt, Kraft $F$ in Knoten VI in Richtung von Stab 7). a) Bestimme alle Nullstäbe mit Begründung. b) Stelle die Gleichgewichtsbedingungen am Knoten II auf (Zugstäbe positiv).
#align(center)[#image(abbildungen.at("ak_ss16_fachwerk"), width: 60%)]
][
*a) Nullstäbe:* Stäbe 6 und 9 (Knoten V, Regel 1). Stab 1 (Knoten I, Regel 2: die Lagerkraft $B$ wirkt in Richtung von Stab 2). Stab 8 (Knoten VI, Regel 2: $F$ wirkt in Richtung von Stab 7). Stab 5 (Knoten IV, Regel 3); danach hat Knoten IV nur noch einen tragenden Stab, also ist auch Stab 4 ein Nullstab.
][
*b) Knoten II:* $arrow.r: A_H + S_3 cos alpha + S_4 = 0$, $arrow.t: A_V + S_1 + S_3 sin alpha = 0$.
]

#aufgabe(titel: "Wie erkennt man Nullstäbe?", art: "verstehen", quelle: "6.3.1", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 66* #linebreak()]
Wie erkennt man Nullstäbe?
][
*Antwort:*
- *Unbelasteter Knoten, zwei nicht kollineare Stäbe:* beide sind Nullstäbe.
- *Unbelasteter Knoten, drei Stäbe:* Liegen zwei auf einer Linie, ist der dritte ein Nullstab.
- *Zwei Stäbe, äußere Last entlang eines Stabs:* der andere ist ein Nullstab.
]

#aufgabe(titel: "Wo beginnt man beim Knotenpunktverfahren?", art: "verstehen", quelle: "6.3.1", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 67* #linebreak()]
Wo beginnt man beim Knotenpunktverfahren?
][
*Antwort:*
- An einem Knoten mit höchstens zwei unbekannten Stabkräften, denn ein Knoten liefert nur zwei Gleichungen.
- Danach geht man Knoten für Knoten weiter.
][
*Merksatz:* Zwei Knotengleichungen brauchen höchstens zwei unbekannte Stabkräfte.
]

#aufgabe(titel: "Dritter Stab am unbelasteten Knoten mit zwei Stäben auf einer Linie", art: "verstehen", quelle: "6.3.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 68* #linebreak()]
Ein unbelasteter Fachwerkknoten verbindet drei Stäbe, zwei davon liegen auf einer Linie. Was gilt für den dritten Stab?
][
*Antwort:* Er ist ein Nullstab. Das Gleichgewicht quer zur Linie der beiden kollinearen Stäbe lässt nur $S_3 = 0$ zu (Nullstabregel 3).
][
*Typische Verwechslung:* Er trägt die doppelte Kraft der anderen.: Quer zu den kollinearen Stäben hat er keinen Partner, der ihn ausgleichen könnte.
]

#aufgabe(titel: "Quadratfachwerk auf der Spitze", art: "rechnen", quelle: "6.3.1", herkunft: "original", vorlage: "TM1-Übung 8, Aufg. 8.3", minuten: 15,
  ergebnis: [$S_1 = sqrt(2) F$, $S_2 = 3F$, $S_3 = S_5 = -2 sqrt(2) F$, $S_4 = -sqrt(2) F$; $A_H = -2F$, $A_V = -3F$, $B = 4F$],
  tipp: [Erst die Lagerkräfte am Gesamtsystem, dann Knoten mit höchstens zwei unbekannten Stäben: I, dann III, zuletzt II.],
)[
#if not web [*Aufgabe 69* #linebreak()]
Berechnen Sie für das dargestellte Fachwerk die Stabkräfte und die Lagerreaktionen mit dem Knotenpunktverfahren.
#align(center)[#image("abbildungen/ue1_8_3.png", width: 40%)]

*Gegeben und Annahmen*

Ein auf die Spitze gestelltes Quadrat mit Seitenlänge $a$: Knoten IV links (Festlager A), I oben, II rechts, III unten (Loslager B, senkrechte Kraft). Stäbe: 1 (IV–I), 2 (IV–II, waagerechte Diagonale), 3 (IV–III), 4 (I–II), 5 (II–III). Lasten: $2F$ waagerecht nach rechts an I, $F$ nach unten an II. Alle Stäbe als Zug angesetzt (Kraft vom Knoten weg).

*Gesucht*

#enum(numbering: "a)",
[Lagerreaktionen $A_H$, $A_V$, $B$.],
[Stabkräfte $S_1$ bis $S_5$.],
)
][
*Gesamtsystem:* Mit $s = a\/sqrt(2)$ liegt I bei $(s; s)$, II bei $(2s; 0)$, III bei $(s; -s)$. Waagerecht: $A_H = -2F$. Momente um IV: $-s dot 2F - 2s dot F + s B = 0$, also $B = 4F$. Senkrecht: $A_V = F - B = -3F$.
][
*Knoten I:* Stab 1 zeigt nach links unten, Stab 4 nach rechts unten (je 45°). Senkrecht: $-S_1 - S_4 = 0$. Waagerecht: $(-S_1 + S_4)\/sqrt(2) + 2F = 0$. Also $S_1 = sqrt(2) F$ (Zug), $S_4 = -sqrt(2) F$ (Druck).
][
*Knoten III:* Stab 3 nach links oben, Stab 5 nach rechts oben, $B = 4F$ nach oben. Waagerecht: $S_3 = S_5$. Senkrecht: $(S_3 + S_5)\/sqrt(2) + 4F = 0$, also $S_3 = S_5 = -2 sqrt(2) F$.
][
*Knoten II:* Waagerecht: $-S_2 - S_4\/sqrt(2) - S_5\/sqrt(2) = 0$, also $S_2 = F + 2F = 3F$ (Zug).
][
*Prüfen:* Knoten IV muss mit $A_H$, $A_V$ im Gleichgewicht sein: waagerecht $S_1\/sqrt(2) + S_2 + S_3\/sqrt(2) - 2F = F + 3F - 2F - 2F = 0$. Passt.
]

#aufgabe(titel: "Quadratfachwerk auf der Spitze (Variante)", art: "rechnen", quelle: "6.3.1", herkunft: "variante", vorlage: "TM1-Übung 8, Aufg. 8.3", minuten: 12,
  ergebnis: [$S_1 = F\/sqrt(2)$, $S_2 = 3F$, $S_3 = S_5 = -5\/sqrt(2) F$, $S_4 = -F\/sqrt(2)$; $A_H = -F$, $A_V = -3F$, $B = 5F$],
)[
#if not web [*Aufgabe 70* #linebreak()]
*Gegeben und Annahmen*

Fachwerk wie in Übung 8.3, aber an I wirkt $F$ waagerecht nach rechts und an II $2F$ nach unten. Zug positiv.

*Gesucht*

#enum(numbering: "a)",
[Lagerreaktionen und alle Stabkräfte.],
)
][
*Gesamtsystem:* $A_H = -F$. Momente um IV: $-s F - 2s dot 2F + s B = 0$, $B = 5F$; $A_V = 2F - 5F = -3F$.
][
*Knoten I:* $S_4 = -S_1$ und $-2 S_1\/sqrt(2) + F = 0$: $S_1 = F\/sqrt(2)$, $S_4 = -F\/sqrt(2)$.
][
*Knoten III:* $S_3 = S_5$ und $2 S_3\/sqrt(2) + 5F = 0$: $S_3 = S_5 = -5F\/sqrt(2) approx -"3,54" F$.
][
*Knoten II:* $S_2 = -(S_4 + S_5)\/sqrt(2) = (1\/2 + 5\/2) F = 3F$.
]

#aufgabe(titel: "Fachwerk mit Spitze und zwei Lasten", art: "rechnen", quelle: "6.3.1", herkunft: "original", vorlage: "TM1-Übung 8, Aufg. 8.4", minuten: 15,
  ergebnis: [$S_1 = "223,6"$, $S_2 = -"282,8"$, $S_3 = 100$, $S_4 = 400$, $S_5 = -"424,3"$, $S_6 = -200$, $S_7 = 300$ (kN); $A_H = -300$, $A_V = -400$, $B_V = 500 "kN"$],
)[
#if not web [*Aufgabe 71* #linebreak()]
Für das abgebildete Fachwerk sind alle Stabkräfte sowie die Lagerreaktionen zu bestimmen.
#align(center)[#image("abbildungen/ue1_8_4.png", width: 45%)]

*Gegeben und Annahmen*

Knoten V $(0; 0)$ Festlager A, IV $(a; 0)$ Loslager B, III $(0; a)$, II $(a; a)$, I $(2a; 2a)$. Stäbe: 1 (III–I), 2 (II–I), 3 (III–II), 4 (V–III), 5 (III–IV), 6 (II–IV), 7 (V–IV). $F_1 = 100 "kN"$ nach unten an I, $F_2 = 300 "kN"$ nach rechts an II. Zug positiv.

*Gesucht*

#enum(numbering: "a)",
[Lagerreaktionen.],
[Stabkräfte $S_1$ bis $S_7$.],
)
][
*Gesamtsystem:* Waagerecht $A_H = -300 "kN"$. Momente um V: $-2a dot 100 - a dot 300 + a B_V = 0$, $B_V = 500 "kN"$. Senkrecht $A_V = 100 - 500 = -400 "kN"$.
][
*Knoten I:* Stab 1 zeigt in Richtung $(-2; -1)\/sqrt(5)$, Stab 2 in $(-1; -1)\/sqrt(2)$. Waagerecht: $-2 S_1\/sqrt(5) - S_2\/sqrt(2) = 0$. Senkrecht: $-S_1\/sqrt(5) - S_2\/sqrt(2) - 100 = 0$. Differenz: $S_1 = 100 sqrt(5) = "223,6" "kN"$, dann $S_2 = -200 sqrt(2) = -"282,8" "kN"$.
][
*Knoten II:* Waagerecht: $S_2\/sqrt(2) - S_3 + 300 = 0$, also $S_3 = 100 "kN"$. Senkrecht: $S_2\/sqrt(2) - S_6 = 0$, also $S_6 = -200 "kN"$.
][
*Knoten IV:* Senkrecht: $S_6 + S_5\/sqrt(2) + 500 = 0$, $S_5 = -300 sqrt(2) = -"424,3" "kN"$. Waagerecht: $-S_5\/sqrt(2) - S_7 = 0$, $S_7 = 300 "kN"$.
][
*Knoten V:* Senkrecht: $S_4 + A_V = 0$, $S_4 = 400 "kN"$. Waagerecht zur Kontrolle: $S_7 + A_H = 300 - 300 = 0$. Passt.
]

#aufgabe(titel: "Fachwerk mit Spitze und zwei Lasten (Variante)", art: "rechnen", quelle: "6.3.1", herkunft: "variante", vorlage: "TM1-Übung 8, Aufg. 8.4", minuten: 12,
  ergebnis: [$S_1 = "447,2"$, $S_2 = -"565,7"$, $S_3 = -300$, $S_4 = 300$, $S_5 = -"141,4"$, $S_6 = -400$, $S_7 = 100$ (kN); $A_H = -100$, $A_V = -300$, $B_V = 500 "kN"$],
)[
#if not web [*Aufgabe 72* #linebreak()]
*Gegeben und Annahmen*

Fachwerk wie in Übung 8.4, aber $F_1 = 200 "kN"$ (nach unten an I) und $F_2 = 100 "kN"$ (nach rechts an II).

*Gesucht*

#enum(numbering: "a)",
[Lagerreaktionen und alle Stabkräfte.],
)
][
*Gesamtsystem:* $A_H = -100$. Momente um V: $-2a dot 200 - a dot 100 + a B_V = 0$, $B_V = 500$; $A_V = 200 - 500 = -300 "kN"$.
][
*Knoten I:* $S_1 = 200 sqrt(5) = "447,2"$, $S_2 = -2 S_1 sqrt(2)\/sqrt(5) = -400 sqrt(2) = -"565,7" "kN"$.
][
*Knoten II:* $S_3 = S_2\/sqrt(2) + 100 = -300$, $S_6 = S_2\/sqrt(2) = -400 "kN"$.
][
*Knoten IV und V:* $S_5 = -sqrt(2)(S_6 + 500) = -100 sqrt(2) = -"141,4"$, $S_7 = -S_5\/sqrt(2) = 100$, $S_4 = -A_V = 300 "kN"$. Kontrolle waagerecht an V: $100 - 100 = 0$.
]

#aufgabe(titel: "Fachwerkträger mit neun Stäben", art: "rechnen", quelle: "6.3.1", herkunft: "original", vorlage: "TM1-Übung 8, Aufg. 8.5", minuten: 20,
  ergebnis: [$S_1 = -"2,61" F$, $S_2 = S_6 = "3,33" F$, $S_3 = 2F$, $S_4 = -"0,67" F$, $S_5 = S_8 = -"1,86" F$, $S_7 = "0,83" F$, $S_9 = "1,67" F$; $A_H = -F$, $A_V = "1,167" F$, $B_V = "0,833" F$],
  tipp: [Knoten I und VI haben nach den Lagerkräften nur zwei unbekannte Stäbe. Knoten III gibt $S_3$ sofort.],
)[
#if not web [*Aufgabe 73* #linebreak()]
Berechnen Sie für das dargestellte Fachwerk alle Stabkräfte und die Lagerreaktionen.
#align(center)[#image("abbildungen/ue1_8_5.png", width: 55%)]

*Gegeben und Annahmen*

Untergurt I $(0; 0)$ Festlager A, III $(2a; 0)$, V $(4a; 0)$, VI $(6a; 0)$ Loslager B; Obergurt II $(2a; a)$, IV $(4a; a)$. Stäbe: 1 (I–II), 2 (I–III), 3 (II–III), 4 (II–IV), 5 (II–V), 6 (III–V), 7 (IV–V), 8 (IV–VI), 9 (V–VI). $2F$ nach unten an III, $F$ nach rechts an IV. Zug positiv.

*Gesucht*

#enum(numbering: "a)",
[Lagerreaktionen.],
[Alle Stabkräfte.],
)
][
*Gesamtsystem:* $A_H = -F$. Momente um I: $-2a dot 2F - a dot F + 6a B_V = 0$, also $B_V = 5\/6 F$, $A_V = 2F - 5\/6 F = 7\/6 F$.
][
*Knoten I:* Stab 1 in Richtung $(2; 1)\/sqrt(5)$. Senkrecht: $S_1\/sqrt(5) + 7\/6 F = 0$, $S_1 = -7 sqrt(5)\/6 F = -"2,61" F$. Waagerecht: $2 S_1\/sqrt(5) + S_2 - F = 0$, $S_2 = 10\/3 F$.
][
*Knoten III:* Senkrecht: $S_3 = 2F$. Waagerecht: $S_6 = S_2 = 10\/3 F$.
][
*Knoten VI:* Stab 8 in Richtung $(-2; 1)\/sqrt(5)$. Senkrecht: $S_8\/sqrt(5) + 5\/6 F = 0$, $S_8 = -5 sqrt(5)\/6 F = -"1,86" F$. Waagerecht: $S_9 = -2 S_8\/sqrt(5) = 5\/3 F$.
][
*Knoten V und IV:* An V waagerecht: $-2 S_5\/sqrt(5) - S_6 + S_9 = 0$, also $S_5 = -5 sqrt(5)\/6 F$; senkrecht: $S_7 = -S_5\/sqrt(5) = 5\/6 F$. An IV waagerecht: $-S_4 + 2 S_8\/sqrt(5) + F = 0$, $S_4 = -2\/3 F$.
][
*Prüfen:* Knoten II ist noch frei und dient als Kontrolle: senkrecht $-S_1\/sqrt(5) - S_3 - S_5\/sqrt(5) = 7\/6 F - 2F + 5\/6 F = 0$. Passt.
]

#aufgabe(titel: "Fachwerkträger mit neun Stäben (Variante)", art: "rechnen", quelle: "6.3.1", herkunft: "variante", vorlage: "TM1-Übung 8, Aufg. 8.5", minuten: 15,
  ergebnis: [$S_1 = -"0,745" F$, $S_2 = S_6 = 8\/3 F$, $S_3 = F$, $S_4 = 2\/3 F$, $S_5 = S_8 = -"1,49" F$, $S_7 = 2\/3 F$, $S_9 = 4\/3 F$; $A_H = -2F$, $A_V = F\/3$, $B_V = 2\/3 F$],
)[
#if not web [*Aufgabe 74* #linebreak()]
*Gegeben und Annahmen*

Fachwerk wie in Übung 8.5, aber an III wirkt $F$ nach unten und an IV $2F$ nach rechts. Zug positiv.

*Gesucht*

#enum(numbering: "a)",
[Lagerreaktionen und alle Stabkräfte.],
)
][
*Gesamtsystem:* $A_H = -2F$. Momente um I: $-2a F - a dot 2F + 6a B_V = 0$, $B_V = 2\/3 F$, $A_V = F\/3$.
][
*Knoten I und III:* $S_1 = -sqrt(5)\/3 F = -"0,745" F$; $S_2 = 2F - 2 S_1\/sqrt(5) = 2F + 2\/3 F = 8\/3 F$. An III: $S_3 = F$, $S_6 = 8\/3 F$.
][
*Knoten VI:* $S_8 = -2 sqrt(5)\/3 F = -"1,49" F$, $S_9 = 4\/3 F$.
][
*Knoten V und IV:* $S_5 = (S_9 - S_6) sqrt(5)\/2 = -2 sqrt(5)\/3 F$, $S_7 = 2\/3 F$. An IV: $S_4 = 2 S_8\/sqrt(5) + 2F = -4\/3 F + 2F = 2\/3 F$.
][
*Prüfen:* Knoten II senkrecht: $sqrt(5)\/3 dot 1\/sqrt(5) F - F + 2\/3 F = 0$. Passt.
]

#aufgabe(titel: "Wann verwendet man den Ritterschnitt, und wo darf man schneiden?", art: "verstehen", quelle: "6.3.3", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 75* #linebreak()]
Wann verwendet man den Ritterschnitt, und wo darf man schneiden?
][
*Antwort:*
- *Ziel:* einzelne Stabkräfte im Inneren des Fachwerks bestimmen.
- Fachwerk in zwei Teile schneiden; im üblichen ebenen Ritterschnitt höchstens drei unbekannte Stabkräfte schneiden.
- Diese Stäbe dürfen nicht alle durch denselben Punkt gehen oder alle parallel verlaufen.
- Moment um den Schnittpunkt zweier Stäbe bilden → dritte Stabkraft direkt bestimmen.
#align(center)[#image(abbildungen.at("ak24-fachwerk-schnitt"), width: 60%)]
]

#aufgabe(titel: "Warum nimmt man unbekannte Stabkräfte zunächst als Zug an?", art: "verstehen", quelle: "6.3.3", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 76* #linebreak()]
Warum nimmt man unbekannte Stabkräfte zunächst als Zug an?
][
*Antwort:*
- Damit die Vorzeichen eindeutig sind.
- Ist das Ergebnis positiv, ist der Stab ein Zugstab.
- Ist es negativ, ist er ein Druckstab.
- So muss man nicht vorher raten.
#align(center)[#image(abbildungen.at("ak24-fachwerk-schnitt"), width: 60%)]
][
*Merksatz:* Zug angenommen: Plus bleibt Zug, Minus wird Druck.
]

#aufgabe(titel: "Einzelne Stabkraft beim Ritterschnitt am schnellsten bestimmen", art: "verstehen", quelle: "6.3.3", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 77* #linebreak()]
Ein Ritterschnitt trennt drei unbekannte Stäbe. Wie bestimmst Du eine einzelne Stabkraft am schnellsten?
][
*Antwort:* Mit dem Moment um den Schnittpunkt der beiden anderen Stabkräfte. Die anderen zwei Kräfte gehen durch diesen Punkt und fallen heraus. Übrig bleibt nur die gesuchte.
][
*Typische Verwechslung:* Mit der Kraftsumme in Richtung der gesuchten Kraft: Dann stehen meist noch die anderen beiden Unbekannten in der Gleichung.
]

#aufgabe(titel: "Nullstäbe und Ritterschnitt", art: "rechnen", quelle: "6.3.3", herkunft: "original", vorlage: "Altklausur SS 24, Aufg. 1 (Fachwerk)", minuten: 10,
  ergebnis: [Nullstäbe 1, 2, 9; $S_6 = 5F$ (Zug), $S_7 = 0$, $S_8 = -10F$ (Druck)],
  tipp: [Für den Ritterschnitt: Lege den Momentenbezugspunkt in den Schnittpunkt zweier unbekannter Stäbe.],
)[
#if not web [*Aufgabe 78* #linebreak()]
*AK24 S. 8, 13, 15–16:*

*Gegeben und Annahmen*

Ideales Fachwerk mit Nummerierung und Geometrie der beigefügten Skizze. Am oberen Teil: $D=10F$ nach rechts, $G_H=10F$ nach links und $G_V=5F$ nach unten.
#align(center)[#image(abbildungen.at("ak24-fachwerk-schnitt"), width: 100%)]

*Gesucht*

#enum(numbering: "a)",
[Erkenne die Nullstäbe 1, 2 und 9 und ordne die Regeln zu.],
[Führe einen Ritterschnitt durch die Stäbe 6, 7 und 8 und bestimme die drei Stabkräfte.],
)
][
*Nullstäbe:* Stäbe *1 und 2* treffen sich am unbelasteten oberen rechten Knoten, und nur diese zwei Stäbe sind dort; sie liegen nicht auf einer Linie. Regel 1: beide sind null. Stab *9* sitzt am unbelasteten rechten Zwischenknoten, an dem zwei Vertikalstäbe kollinear durchlaufen. Regel 3: der dritte Stab ist null.
][
*Warum trotzdem da:* 1 und 2 bilden einen unbelasteten Anbau. Stab 9 stabilisiert das Innere und darf nicht einfach entfernt werden, sonst wird das Fachwerk beweglich.
][
*Schnitt ansetzen:* Schneide durch 6, 7 und 8 und betrachte den oberen Teil. Alle Schnittkräfte werden als Zug angesetzt: 6 und 8 nach unten, 7 schräg links unten. Ein positives Ergebnis heißt dann Zug.
][
*Moment um den rechten oberen belasteten Knoten:* Dort schneiden sich 7 und 8, beide fallen heraus.
$-D dot 2a+G_V dot 2a+S_6 dot 2a=0 => S_6=D-G_V=5F$.
][
*Kräfte waagerecht und senkrecht:* Waagerecht trägt nur 7 bei: $D-G_H-S_7 cos 45°=0 => S_7=0$. Senkrecht: $-G_V-S_6-S_8=0 => S_8=-5F-5F=-10F$.
][
*Deuten und prüfen:* 6 ist Zugstab, 7 ist bei diesen Reaktionen Nullstab, 8 ist Druckstab. Probe senkrecht: $-5F-5F-(-10F)=0$.
]

#aufgabe(titel: "Nullstäbe und Ritterschnitt (Variante)", art: "rechnen", quelle: "6.3.3", herkunft: "variante", vorlage: "Altklausur SS 24, Aufg. 1 (Fachwerk)", minuten: 8,
  ergebnis: [Nullstäbe 1, 2, 9; $S_6 = 8F$ (Zug), $S_7 = 2 sqrt(2) F approx "2,83" F$ (Zug), $S_8 = -14F$ (Druck)],
)[
#if not web [*Aufgabe 79* #linebreak()]
*Gegeben und Annahmen*

Fachwerk wie AK24 (Skizze). Am oberen Teil wirken jetzt $D = 12F$ nach rechts, $G_H = 10F$ nach links, $G_V = 4F$ nach unten. Stab 7 unter $45°$.
#align(center)[#image(abbildungen.at("ak24-fachwerk-schnitt"), width: 100%)]

*Gesucht*

#enum(numbering: "a)",
[Nullstäbe; Ritterschnitt durch 6, 7, 8.],
)
][
*Nullstäbe:* Die Geometrie ist unverändert, also wieder 1, 2 (Regel 1) und 9 (Regel 3).
][
*Moment um den Schnittpunkt von 7 und 8:* $-D dot 2a + G_V dot 2a + S_6 dot 2a = 0$, also $S_6 = 12F - 4F = 8F$.
][
*Waagrecht:* $D - G_H - S_7 cos 45° = 0$, also $S_7 = 2F\/cos 45° = 2 sqrt(2) F$.
][
*Senkrecht:* $-G_V - S_6 - S_8 - S_7 sin 45° = 0$, also $S_8 = -4F - 8F - 2F = -14F$.
]

#aufgabe(titel: "Drei Stabkräfte mit dem Ritterschnitt", art: "rechnen", quelle: "6.3.3", herkunft: "original", vorlage: "TM1-Übung 9, Aufg. 9.1", minuten: 10,
  ergebnis: [$S_4 = -2\/3 F$, $S_5 = -5 sqrt(5)\/6 F approx -"1,86" F$, $S_6 = 10\/3 F$],
  tipp: [Momentenpunkt für $S_6$ ist der Schnittpunkt von Stab 4 und 5 (Knoten II), für $S_4$ der Schnittpunkt von 5 und 6 (Knoten V).],
)[
#if not web [*Aufgabe 80* #linebreak()]
Bestimmen Sie für die Stäbe 4, 5 und 6 aus Aufgabe 8.5 die Stabkräfte durch Anwendung des Ritterschen Schnittverfahrens.
#align(center)[#image(abbildungen.at("tm1k6_ue91"), width: 55%)]

*Gegeben und Annahmen*

Fachwerk aus Übung 8.5; Lagerkräfte bekannt: $A_H = -F$ (nach links), $A_V = 7\/6 F$. Last $2F$ an III. Zug positiv.

*Gesucht*

#enum(numbering: "a)",
[$S_4$, $S_5$, $S_6$.],
)
][
*Schnitt:* Schneide durch die Stäbe 4, 5 und 6 und betrachte den linken Teil (Knoten I, II, III). Er trägt $A_H$, $A_V$, $2F$ und die drei Stabkräfte. Drei Unbekannte, nicht durch einen Punkt: lösbar.
][
*$S_6$ aus Momenten um II $(2a; a)$:* $A_H$ bei $(0; 0)$: $-a F$. $A_V$: $-2a dot 7\/6 F$. $2F$ bei III liegt senkrecht unter II: kein Moment. $S_6$ (bei III, nach rechts): $+a S_6$. Also $S_6 = (1 + 7\/3) F = 10\/3 F$.
][
*$S_4$ aus Momenten um V $(4a; 0)$:* $A_V$: $-4a dot 7\/6 F$; $2F$ bei III: $+2a dot 2F$; $S_4$ (bei II nach rechts, Höhe $a$): $-a S_4$. Also $S_4 = (4 - 14\/3) F = -2\/3 F$.
][
*$S_5$ aus der senkrechten Summe:* Stab 5 zeigt von II nach rechts unten, $(2; -1)\/sqrt(5)$. $7\/6 F - 2F - S_5\/sqrt(5) = 0$, also $S_5 = -5 sqrt(5)\/6 F approx -"1,86" F$.
][
*Prüfen:* Alle drei Werte stimmen mit dem Knotenverfahren aus 8.5 überein. Der Ritterschnitt braucht dafür nur drei Gleichungen statt sechs Knoten.
]

#aufgabe(titel: "Ritterschnitt am Fachwerkträger (Variante)", art: "rechnen", quelle: "6.3.3", herkunft: "variante", vorlage: "TM1-Übung 9, Aufg. 9.1", minuten: 8,
  ergebnis: [$S_4 = -2F$, $S_5 = -sqrt(5) F$, $S_6 = 4F$ (mit $A_H = 0$, $A_V = 2F$, $B_V = F$)],
)[
#if not web [*Aufgabe 81* #linebreak()]
*Gegeben und Annahmen*

Fachwerk aus Übung 8.5, aber als einzige Last wirkt $3F$ nach unten an Knoten III. Zug positiv.

*Gesucht*

#enum(numbering: "a)",
[Lagerkräfte.],
[$S_4$, $S_5$, $S_6$ mit dem Ritterschnitt.],
)
][
*Lager:* $A_H = 0$. Momente um I: $-2a dot 3F + 6a B_V = 0$, $B_V = F$, $A_V = 2F$.
][
*Um II:* $-2a dot 2F + a S_6 = 0$, $S_6 = 4F$.
][
*Um V:* $-4a dot 2F + 2a dot 3F - a S_4 = 0$, $S_4 = -2F$.
][
*Senkrecht:* $2F - 3F - S_5\/sqrt(5) = 0$, $S_5 = -sqrt(5) F$.
]

#kapitel("TM1 Kapitel 7 · Schnittgrößen punktweise bestimmen")

#aufgabe(titel: "Was sind N, Q und M?", art: "verstehen", quelle: "7.1", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 82* #linebreak()]
Was sind N, Q und M?
][
*Antwort:*
- Die inneren Kräfte, die ein Balken an einer Schnittstelle überträgt:
- $N$, die Normalkraft, wirkt entlang der Achse (Zug oder Druck).
- $Q$, die Querkraft, wirkt senkrecht zur Achse.
- $M$, das Biegemoment, biegt den Balken.
#align(center)[#image(abbildungen.at("tm1k01_mitschrift_schnitt"), width: 60%)]
][
*Merksatz:* N längs, Q quer, M biegt.
]

#aufgabe(titel: "Wozu braucht man die gestrichelte Bezugsfaser?", art: "verstehen", quelle: "7.1", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 83* #linebreak()]
Wozu braucht man die gestrichelte Bezugsfaser?
][
*Antwort:*
- Sie legt fest, wo die positive Seite ist.
- Ein positives Moment dehnt die Faser auf der gestrichelten Seite.
- Ohne Bezugsfaser wäre das Vorzeichen von M nicht eindeutig.
#align(center)[#image(abbildungen.at("tm1k01_mitschrift_schnitt"), width: 60%)]
]

#aufgabe(titel: "Warum zeigen die positiven Schnittgrößen an beiden Schnittufern in entgegengesetzte Richtungen?", art: "verstehen", quelle: "7.1", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 84* #linebreak()]
Warum zeigen die positiven Schnittgrößen an beiden Schnittufern in entgegengesetzte Richtungen?
][
*Antwort:*
- *Wegen actio = reactio:* Positives und negatives Schnittufer sind zwei Seiten desselben Schnitts.
- Was der linke Teil auf den rechten ausübt, übt der rechte entgegengesetzt auf den linken aus.
#align(center)[#image(abbildungen.at("tm1k01_mitschrift_schnitt"), width: 60%)]
]

#aufgabe(titel: "Gerberträger mit schräger Kraft", art: "rechnen", quelle: "7.2.6", herkunft: "original", vorlage: "TM1-Übung 12, Aufg. 12.1", minuten: 20,
  ergebnis: [$G_H = sqrt(3)\/2 F$, $A_H = -sqrt(3)\/2 F$, $C = G_V = F\/4$, $B = 3\/2 q_0 a + F\/2$, $A_V = -1\/2 q_0 a - F\/4$; $N = sqrt(3)\/2 F$ von A bis zur Kraft, danach 0],
  tipp: [Der rechte Teil G–C trägt nur die schräge Kraft in seiner Mitte. Mit ihm beginnen.],
)[
#if not web [*Aufgabe 85* #linebreak()]
Berechnen Sie für den dargestellten Gelenkbalken (Gerberträger) die Lager- und Gelenkreaktionen, den Normalkraft-, Querkraft- und Momentenverlauf punktweise sowie $Q(x_2)$ und $M(x_2)$ im Bereich II mit der Streckenlast.
#align(center)[#image(abbildungen.at("tm1k7_ue121"), width: 55%)]

*Gegeben und Annahmen*

Festlager A bei 0, Loslager B bei $a$, $q_0$ von B bis zum Gelenk G bei $2a$, $F$ unter 30° gegen den Balken nach rechts unten bei $2a + b$, Loslager C bei $2a + 2b$.

*Gesucht*

#enum(numbering: "a)",
[Lager- und Gelenkreaktionen.],
[$N$, $Q$, $M$ punktweise; $Q(x_2)$, $M(x_2)$ in B–G.],
)
][
*Teil G–C:* $F$ zerlegt: senkrecht $F sin 30° = F\/2$, waagerecht $sqrt(3)\/2 F$. Die Kraft sitzt mittig, also $C = G_V = F\/4$. C ist ein Loslager, deshalb muss das Gelenk die ganze waagerechte Komponente aufnehmen: $G_H = sqrt(3)\/2 F$.
][
*Teil A–G:* Im Gelenk wirken die Gegenkräfte. Waagerecht: $A_H = -sqrt(3)\/2 F$. Momente um A: $B a - q_0 a dot "1,5" a - F\/4 dot 2a = 0$, $B = 3\/2 q_0 a + F\/2$. Senkrecht: $A_V = q_0 a + F\/4 - B = -1\/2 q_0 a - F\/4$.
][
*Punktweise:* $N$: Die waagerechte Kraftkomponente zieht den Balken von A bis zur Kraft, $N = sqrt(3)\/2 F$; rechts der Kraft $N = 0$. $Q$: von A bis B $Q = A_V$; rechts von B $Q = A_V + B = q_0 a + F\/4$; bei G $Q = F\/4$; rechts der Kraft $-F\/4$. $M$: $M(B) = A_V a = -(q_0 a^2\/2 + F a\/4)$, $M(G) = 0$, unter der Kraft $M = F b\/4$.
][
*Bereich II ($x_2$ ab B):* $Q(x_2) = q_0 a + F\/4 - q_0 x_2$, $M(x_2) = M(B) + (q_0 a + F\/4) x_2 - q_0 x_2^2\/2$. Kontrolle $M(a) = 0$ am Gelenk.
][
*Prüfen:* Im Lösungsblatt steht als Zwischenschritt $-F sin 30°$; richtig ist $-1\/2 F sin 30°$. Das Endergebnis $-F\/4$ stimmt.
]

#aufgabe(titel: "Gerberträger mit schräger Kraft (Variante)", art: "rechnen", quelle: "7.2.6", herkunft: "variante", vorlage: "TM1-Übung 12, Aufg. 12.1", minuten: 15,
  ergebnis: [$G_H = F\/sqrt(2)$, $A_H = -F\/sqrt(2)$, $C = G_V = F\/(2 sqrt(2))$, $B = 3\/2 q_0 a + F\/sqrt(2)$, $A_V = -1\/2 q_0 a - F\/(2 sqrt(2))$],
)[
#if not web [*Aufgabe 86* #linebreak()]
*Gegeben und Annahmen*

Gerberträger wie in Übung 12.1, aber $F$ greift unter 45° gegen den Balken an.

*Gesucht*

#enum(numbering: "a)",
[Lager- und Gelenkreaktionen, $N$ und $Q$ bereichsweise.],
)
][
*Teil G–C:* Komponenten je $F\/sqrt(2)$. $C = G_V = F\/(2 sqrt(2))$, $G_H = F\/sqrt(2)$.
][
*Teil A–G:* $A_H = -F\/sqrt(2)$. $B a = "1,5" q_0 a^2 + F\/(2 sqrt(2)) dot 2a$, $B = 3\/2 q_0 a + F\/sqrt(2)$. $A_V = q_0 a + F\/(2 sqrt(2)) - B = -1\/2 q_0 a - F\/(2 sqrt(2))$.
][
*Schnittgrößen:* $N = F\/sqrt(2)$ von A bis zur Kraft, danach 0. $Q$: $A_V$ bis B, dann $q_0 a + F\/(2 sqrt(2))$ linear fallend auf $F\/(2 sqrt(2))$ bei G, nach der Kraft $-F\/(2 sqrt(2))$.
]

#aufgabe(titel: "Rahmen mit Loslager und Festlager", art: "rechnen", quelle: "7.2.6", herkunft: "original", vorlage: "TM1-Übung 12, Aufg. 12.2", minuten: 20,
  ergebnis: [$B_H = F$, $A = -F\/2$, $B_V = 3\/2 F$; Riegel: $Q_2 = -F\/2 - F x_2\/a$, $M_2 = -F x_2\/2 - F x_2^2\/(2a)$, $M(D) = -F a$],
)[
#if not web [*Aufgabe 87* #linebreak()]
Der Rahmen ist durch die Kraft $F$ und eine Streckenlast $q_0 = F\/a$ belastet. Bestimmen Sie die Verläufe von Normal- und Querkraft sowie den Momentenverlauf (punktweise) und im Riegel den genauen Verlauf $Q_2 (x_2)$ und $M_2 (x_2)$. Es gilt $b = 3\/4 a$.
#align(center)[#image(abbildungen.at("tm1k7_ue122"), width: 40%)]

*Gegeben und Annahmen*

Stütze 1 (Höhe $b$) über dem Loslager A (senkrechte Kraft), Riegel 2 von C nach D (Länge $a$) mit $q_0$, Stütze 3 von D nach unten (Höhe $a$) zum Festlager B. $F$ wirkt waagerecht nach rechts bei C. Gestrichelte Faser innen.

*Gesucht*

#enum(numbering: "a)",
[Lagerkräfte.],
[$N$, $Q$, $M$ an den Ecken; $Q_2 (x_2)$, $M_2 (x_2)$.],
)
][
*Lager:* Waagerecht: $B_H = F$ nach links. Momente um B (A liegt $a$ links, C liegt $a$ über B): $-a A - a F + F dot a\/2 = 0$, also $A = -F\/2$ (A zieht nach unten). Senkrecht: $B_V = F - A = 3\/2 F$.
][
*Stütze 1:* $N = -A = F\/2$ (Zug), $Q = 0$, $M = 0$ bis C.
][
*Riegel (ab C):* $N = -F$ (Druck, $F$ wird bis B weitergeleitet). $Q_2 = A - q_0 x_2 = -F\/2 - F x_2\/a$, also $Q(C) = -F\/2$, $Q(D) = -3\/2 F$. $M_2 = -F x_2\/2 - F x_2^2\/(2a)$, $M(D) = -F a$ (Zug außen).
][
*Stütze 3:* $N = -B_V = -3\/2 F$, $Q = F$ (aus $B_H$), $M$ linear von $-F a$ bei D auf 0 bei B.
][
*Prüfen:* An der Ecke D muss das Moment im Riegel und in der Stütze gleich sein: beide $-F a$. Passt.
]

#aufgabe(titel: "Rahmen mit Loslager und Festlager (Variante)", art: "rechnen", quelle: "7.2.6", herkunft: "variante", vorlage: "TM1-Übung 12, Aufg. 12.2", minuten: 15,
  ergebnis: [$B_H = 2F$, $A = -3\/2 F$, $B_V = 5\/2 F$; Riegel $N = -2F$, $Q_2 = -3\/2 F - F x_2\/a$, $M_2 = -3\/2 F x_2 - F x_2^2\/(2a)$, $M(D) = -2 F a$],
)[
#if not web [*Aufgabe 88* #linebreak()]
*Gegeben und Annahmen*

Rahmen wie in Übung 12.2 ($q_0 = F\/a$), aber bei C wirkt $2F$ waagerecht nach rechts, und die Stütze 1 ist $b = a\/2$ hoch.

*Gesucht*

#enum(numbering: "a)",
[Lagerkräfte, Schnittgrößen an den Ecken, $Q_2$ und $M_2$.],
)
][
*Lager:* $B_H = 2F$ nach links. Momente um B: $-a A - a dot 2F + F a\/2 = 0$, $A = -3\/2 F$; $B_V = F - A = 5\/2 F$. Die Höhe $b$ spielt keine Rolle, weil A nur senkrecht trägt.
][
*Stütze 1 und Riegel:* Stütze: $N = 3\/2 F$ (Zug). Riegel: $N = -2F$, $Q_2 = -3\/2 F - F x_2\/a$, $M_2 = -3\/2 F x_2 - F x_2^2\/(2a)$, $M(D) = -2 F a$.
][
*Stütze 3:* $N = -5\/2 F$, $Q = 2F$, $M$ von $-2 F a$ bei D linear auf 0 bei B.
]

#aufgabe(titel: "Rahmen mit Gelenk in der Ecke", art: "rechnen", quelle: "7.2.6", herkunft: "original", vorlage: "TM1-Übung 12, Aufg. 12.3", minuten: 20,
  ergebnis: [$A_H = -F$, $G_H = B_H = 0$, $G_V = B_V = 5\/4 F$, $A_V = -F\/4$; Riegel: $Q = -F x_2\/a - F\/4$, $M = -F x_2^2\/(2a) - F x_2\/4 + 3\/4 F a$],
  tipp: [Die rechte Stütze hat oben ein Gelenk, unten ein Festlager und keine Last: Sie ist ein Pendelstab.],
)[
#if not web [*Aufgabe 89* #linebreak()]
Der Rahmen aus Aufgabe 12.2 wird mit einem Gelenk G versehen; dafür wird das Loslager A in ein Festlager umgewandelt. Bestimmen Sie $N$, $Q$ und $M$ punktweise und im Riegel den genauen Verlauf $Q_2 (x_2)$, $M_2 (x_2)$. Es gilt $q_0 = F\/a$, $b = 3\/4 a$.
#align(center)[#image(abbildungen.at("tm1k7_ue123"), width: 40%)]

*Gegeben und Annahmen*

Wie Übung 12.2, aber Festlager A unter Stütze 1 (Höhe $b$), Gelenk G an der rechten oberen Ecke, Festlager B unter Stütze 3.

*Gesucht*

#enum(numbering: "a)",
[Lager- und Gelenkkräfte.],
[Schnittgrößen an den Ecken, $Q_2$ und $M_2$ im Riegel.],
)
][
*Pendelstab:* Stütze G–B ist unbelastet und an beiden Enden gelenkig, also trägt sie nur senkrecht: $G_H = B_H = 0$.
][
*Lager:* Waagerecht: $A_H = -F$. Momente um G am linken Teil (A liegt $a$ links und $b = 3a\/4$ unter G): $-a A_V - 3\/4 a F + F dot a\/2 = 0$, $A_V = -F\/4$. Senkrecht: $G_V = F - A_V = 5\/4 F = B_V$.
][
*Stütze 1 bei C:* $N = -A_V = F\/4$, $Q = F$, $M = F b = 3\/4 F a$.
][
*Riegel:* $N = 0$ (F und $A_H$ heben sich auf), $Q_2 = A_V - q_0 x_2 = -F\/4 - F x_2\/a$, $M_2 = 3\/4 F a - F x_2\/4 - F x_2^2\/(2a)$. Bei G: $Q = -5\/4 F$, $M = 0$.
][
*Prüfen:* $M_2 (a) = 3\/4 F a - F a\/4 - F a\/2 = 0$, wie es das Gelenk verlangt.
]

#aufgabe(titel: "Rahmen mit Gelenk in der Ecke (Variante)", art: "rechnen", quelle: "7.2.6", herkunft: "variante", vorlage: "TM1-Übung 12, Aufg. 12.3", minuten: 15,
  ergebnis: [$A_H = -2F$, $A_V = -F\/2$, $G_V = B_V = 3\/2 F$, $G_H = B_H = 0$; Riegel $M_2 = F a - F x_2\/2 - F x_2^2\/(2a)$],
)[
#if not web [*Aufgabe 90* #linebreak()]
*Gegeben und Annahmen*

Rahmen wie in Übung 12.3 ($q_0 = F\/a$), aber bei C wirkt $2F$ waagerecht nach rechts und $b = a\/2$.

*Gesucht*

#enum(numbering: "a)",
[Lager- und Gelenkkräfte, Schnittgrößen an C, $M_2 (x_2)$.],
)
][
*Lager:* Stütze G–B ist Pendelstab: $G_H = B_H = 0$, also $A_H = -2F$. Momente um G am linken Teil (A liegt $a$ links und $a\/2$ unter G): $-a A_V - a\/2 dot 2F + F a\/2 = 0$, $A_V = -F\/2$. $G_V = B_V = F + F\/2 = 3\/2 F$.
][
*Bei C:* Stütze $N = F\/2$, $Q = 2F$, $M = 2F dot b = F a$.
][
*Riegel:* $Q_2 = -F\/2 - F x_2\/a$, $M_2 = F a - F x_2\/2 - F x_2^2\/(2a)$; Kontrolle $M_2 (a) = 0$.
]

#aufgabe(titel: "Schnittgrößen am Rahmen 2018", art: "rechnen", quelle: "7.2.6", herkunft: "original", vorlage: "Altklausur 2018, Aufg. 1 d) e)", minuten: 18,
  ergebnis: [d) je $F_R = 2 "kN"$, $"0,5" "m"$ rechts von B bzw. G. e) (N; Q; M in kN, kNm): A–B unter $M_0$: $-3$; $-2$; $-2$. Rechts von B: $-2$; 3; $-2$. Rechts von G: $-2$; 1; 0. Links von C: $-2$; $-1$; 0. C–D über D: $-1$; 2; 4. D–E links von F: $-2$; $-1$; 3],
  tipp: [Schneide immer so, dass der Teil mit A übrig bleibt, und summiere dessen Kräfte. Positives $M$ zieht die gestrichelte Faser (innen).],
)[
#if not web [*Aufgabe 91* #linebreak()]
Bei einem Rahmen-System (konstante Streckenlast $q_0$ von B bis C, Kraft $F$ mittig zwischen D und E, Moment $M_0$ mittig zwischen A und B, Festlager bei A, Gelenk bei G, Festlager bei E) ergeben sich die Lagerreaktionen aus der Tabelle. d) Bestimmen Sie Größe und Angriffspunkt der Resultierenden der Streckenlast in B–G und G–C. e) Berechnen Sie punktweise unter Beachtung der gestrichelten Faser $N$, $Q$ und $M$ an sechs Stellen.
#align(center)[#image(abbildungen.at("ak_2018_rahmen"), width: 75%)]

*Gegeben und Annahmen*

$a = 2 "m"$, $q_0 = 2 "kN/m"$, $F = 2 "kN"$, $M_0 = 2 "kNm"$ (im Uhrzeigersinn). A $(0; 0)$, B $(0; a)$, G $(a\/2; a)$, C $(a; a)$, D $(a; 0)$, E $(2a; 0)$. $A_H = 2 "kN"$ nach rechts, $A_V = 3 "kN"$, $E_H = 2 "kN"$ nach links, $E_V = 3 "kN"$. Gestrichelte Faser innen (rechts der Stütze A–B, unter dem Riegel, links der Stütze C–D, unter D–E).

*Gesucht*

#enum(numbering: "a)",
[Resultierende der Streckenlast links und rechts von G.],
[$N$, $Q$, $M$: A–B unter $M_0$; rechts von B; rechts von G; links von C; C–D über D; D–E links von F.],
)
][
*d) Resultierende:* Jede Hälfte ist $a\/2 = 1 "m"$ lang: $F_R = q_0 dot 1 = 2 "kN"$, jeweils in ihrer Mitte, also $"0,5" "m"$ rechts von B und $"0,5" "m"$ rechts von G.
][
*A–B unter $M_0$:* Unterer Teil trägt $A_V = 3$ nach oben und $A_H = 2$ nach rechts. $N = -3 "kN"$ (Druck), $Q = -2 "kN"$, $M = -A_H dot 1 "m" = -2 "kNm"$ (Zug außen).
][
*Riegel:* Rechts von B: $N = -A_H = -2$, $Q = A_V = 3$, $M = -A_H a + M_0 = -4 + 2 = -2 "kNm"$. Rechts von G: $Q = 3 - 2 = 1$, $M = 0$ (Gelenk). Links von C: $Q = 3 - 4 = -1$, $M = -2 + 3 dot 2 - 2 dot 2 = 0$. Im Riegel gilt $M(x) = -2 + 3x - x^2$, größter Wert $"0,25" "kNm"$ bei $x = "1,5" "m"$.
][
*C–D über D:* Oberhalb des Schnitts bleiben senkrecht $A_V - q_0 a = -1 "kN"$, also 1 kN nach unten, das drückt auf die Stütze: $N = -1$, $Q = A_H = 2$, $M = 0 + 2 dot 2 = 4 "kNm"$ (Zug innen).
][
*D–E links von F:* $N = -2$, $Q = A_V - 4 = -1$, $M = 4 - 1 dot 1 = 3 "kNm"$. Kontrolle von rechts: $E_V dot 1 = 3 "kNm"$. Passt.
]

#aufgabe(titel: "Schnittgrößen am Rahmen 2018 (Variante)", art: "rechnen", quelle: "7.2.6", herkunft: "variante", vorlage: "Altklausur 2018, Aufg. 1 d) e)", minuten: 18,
  ergebnis: [$A_H = "3,5"$, $A_V = "4,5"$, $E_H = -"3,5"$, $E_V = "5,5" "kN"$. (N; Q; M): unter $M_0$: $-"4,5"$; $-"3,5"$; $-"3,5"$. Rechts von B: $-"3,5"$; $"4,5"$; $-3$. Rechts von G: $-"3,5"$; $"1,5"$; 0. Links von C: $-"3,5"$; $-"1,5"$; 0. Über D: $-"1,5"$; $"3,5"$; 7. Links von F: $-"3,5"$; $-"1,5"$; $"5,5"$],
)[
#if not web [*Aufgabe 92* #linebreak()]
*Gegeben und Annahmen*

Rahmen wie in Altklausur 2018 (Festlager A und E, Gelenk G), aber $q_0 = 3 "kN/m"$, $F = 4 "kN"$, $M_0 = 4 "kNm"$ (im Uhrzeigersinn), $a = 2 "m"$. Gleiche Faser und Vorzeichen.

*Gesucht*

#enum(numbering: "a)",
[Lagerreaktionen.],
[$N$, $Q$, $M$ an denselben sechs Stellen.],
)
][
*Lager:* Momente um A: $-6 dot 1 - 4 dot 3 + 4 E_V - 4 = 0$, $E_V = "5,5" "kN"$; $A_V = 10 - "5,5" = "4,5" "kN"$. Rechter Teil um G: $-3 dot "0,5" - 4 dot 2 + 3 dot "5,5" + 2 E_H = 0$, $E_H = -"3,5" "kN"$ (nach links), also $A_H = "3,5" "kN"$.
][
*Stütze und Riegel:* Unter $M_0$: $N = -"4,5"$, $Q = -"3,5"$, $M = -"3,5"$. Rechts von B: $N = -"3,5"$, $Q = "4,5"$, $M = -7 + 4 = -3$. Rechts von G: $Q = "4,5" - 3 = "1,5"$, $M = 0$. Links von C: $Q = -"1,5"$, $M = -3 + 9 - 6 = 0$.
][
*C–D und D–E:* Über D: oberhalb bleiben $"4,5" - 6 = -"1,5" "kN"$ (nach unten), also $N = -"1,5"$ (Druck); $Q = "3,5"$, $M = "3,5" dot 2 = 7 "kNm"$. Links von F: $N = -"3,5"$, $Q = "4,5" - 6 = -"1,5"$, $M = 7 - "1,5" = "5,5" "kNm"$; von rechts $E_V dot 1 = "5,5"$. Passt.
]

#aufgabe(titel: "Schnittgrößen am Rahmen mit Querkraftgelenk SS 2016", art: "rechnen", quelle: "7.2.6", herkunft: "original", vorlage: "Altklausur SS 16, Aufg. 1 d) e)", minuten: 18,
  ergebnis: [(N; Q; M in kN, kNm): A–B unter $M_0$: $-1$; $"0,5"$; $"0,5"$. Unter B: $-1$; $"0,5"$; 0. Rechts von B: $"0,5"$; 1; 0. Rechts von F: $"0,5"$; 0; 1. Rechts von G: $"0,5"$; 0; 1. Mitte G–C: $"0,5"$; $-"0,5"$; $5\/6$],
  tipp: [Ein Querkraftgelenk (Parallelführung im Balken) überträgt $N$ und $M$, aber keine Querkraft.],
)[
#if not web [*Aufgabe 93* #linebreak()]
Bei einem weiteren System (dachförmige Streckenlast im Bereich G–C, Kraft $F$ mittig zwischen B und G, Moment $M_0$ mittig zwischen A und B, Festlager bei A, Querkraftgelenk bei G, Festlager bei C) ergeben sich die Lagerreaktionen aus der Tabelle. Bestimmen Sie punktweise $N$, $Q$ und $M$ an sechs Stellen.
#align(center)[#image(abbildungen.at("ak_ss16_rahmen"), width: 75%)]

*Gegeben und Annahmen*

$a = 2 "m"$, $q_0 = 1 "kN/m"$, $F = 1 "kN"$, $M_0 = 1 "kNm"$. A $(0; 0)$, B $(0; a)$, Riegel von B nach C $(2a; a)$; $F$ bei $x = a\/2$, G bei $x = a$, Dachlast von G bis C mit der Spitze $q_0$ in der Mitte. $A_H = "0,5" "kN"$ (nach links), $A_V = 1 "kN"$, $C_H = "0,5" "kN"$ (nach rechts), $C_V = 1 "kN"$. Faser innen.

*Gesucht*

#enum(numbering: "a)",
[$N$, $Q$, $M$: A–B unter $M_0$; unter B; rechts von B; rechts von F; rechts von G; Mitte G–C.],
)
][
*Stütze A–B:* $N = -A_V = -1$. $A_H$ zeigt nach links (von der Faser weg), also $Q = "0,5"$. Unter $M_0$: $M = "0,5" dot 1 = "0,5" "kNm"$ (Zug innen). Über $M_0$ springt $M$ um $M_0 = 1$: unter B $M = "0,5" dot 2 - 1 = 0$.
][
*Riegel bis G:* $N = -A_H$ mit Vorzeichen: $"0,5"$ (Zug). Rechts von B: $Q = A_V = 1$, $M = 0$. Rechts von F: $Q = 1 - 1 = 0$, $M = 1 dot 1 = 1 "kNm"$.
][
*Bei G:* Das Querkraftgelenk erzwingt $Q = 0$; das passt, weil zwischen F und G keine Last liegt. $M$ bleibt 1 kNm.
][
*Mitte G–C:* Die halbe Dachlast ist $1\/2 dot 1 dot 1 = "0,5" "kN"$ mit Schwerpunkt $1\/3 "m"$ vor der Mitte. $Q = -"0,5"$, $M = 1 - "0,5" dot 1\/3 = 5\/6 "kNm"$.
][
*Prüfen:* Von C aus: $C_V = 1$ trägt die Dachlast $q_0 a\/2 = 1 "kN"$ ganz, deshalb ist die Querkraft im Gelenk null.
]

#aufgabe(titel: "Rahmen mit Querkraftgelenk (Variante)", art: "rechnen", quelle: "7.2.6", herkunft: "variante", vorlage: "Altklausur SS 16, Aufg. 1 d) e)", minuten: 15,
  ergebnis: [$A_H = -"1,5"$ (links), $A_V = 2$, $C_H = "1,5"$, $C_V = 3$ (kN). (N; Q; M): unter $M_0$: $-2$; $"1,5"$; $"1,5"$. Unter B: $-2$; $"1,5"$; 1. Rechts von B: $"1,5"$; 2; 1. Rechts von F: $"1,5"$; 0; 3. Rechts von G: $"1,5"$; 0; 3. Mitte G–C: $"1,5"$; $-"1,5"$; $"2,5"$],
)[
#if not web [*Aufgabe 94* #linebreak()]
*Gegeben und Annahmen*

System wie in Altklausur SS 2016 (Festlager A und C, Querkraftgelenk G), aber $q_0 = 3 "kN/m"$, $F = 2 "kN"$, $M_0 = 2 "kNm"$ (gleicher Drehsinn), $a = 2 "m"$.

*Gesucht*

#enum(numbering: "a)",
[Lagerreaktionen.],
[$N$, $Q$, $M$ an denselben sechs Stellen.],
)
][
*Lager:* Querkraftgelenk: Der Teil G–C trägt seine Dachlast $q_0 a\/2 = 3 "kN"$ allein, $C_V = 3$. $A_V = F = 2 "kN"$. Momente um A: $-2 dot 1 - 3 dot 3 + 3 dot 4 - 2 C_H + 2 = 0$, $C_H = "1,5"$; $A_H = -"1,5" "kN"$.
][
*Stütze:* $N = -2$, $Q = "1,5"$; unter $M_0$: $M = "1,5"$; unter B: $M = 3 - 2 = 1$.
][
*Riegel:* $N = "1,5"$. Rechts von B: $Q = 2$, $M = 1$. Rechts von F: $Q = 0$, $M = 1 + 2 = 3$; ebenso rechts von G. Mitte G–C: $Q = -"1,5"$, $M = 3 - "1,5" dot 1\/3 = "2,5" "kNm"$.
]

#aufgabe(titel: "Sprünge bei Einzelkraft und Einzelmoment", art: "verstehen", quelle: "7.3", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 95* #linebreak()]
Welche Größe springt an einer Einzelkraft, welche an einem Einzelmoment?
][
Eine quer gerichtete Einzelkraft erzeugt einen Sprung in Q; M bleibt stetig und knickt. Ein Einzelmoment erzeugt einen Sprung in M; Q bleibt unverändert.
]

#aufgabe(titel: "Drehgelenk und Querkraftgelenk", art: "verstehen", quelle: "7.3", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 96* #linebreak()]
Wie unterscheiden sich Drehgelenk und Querkraftgelenk für die Schnittgrößen?
][
Drehgelenk: M=0, N und Q möglich. Querkraftgelenk: Q=0, N und M möglich. Das gilt ohne eine dort zusätzlich eingeleitete entsprechende Last.
]

#aufgabe(titel: "Wie hängen q, Q und M zusammen?", art: "verstehen", quelle: "7.3", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 97* #linebreak()]
Wie hängen q, Q und M zusammen?
][
*Antwort:*
$ Q' = -q, quad M' = Q $
- Die Streckenlast ist die negative Steigung des Querkraftverlaufs, und die Querkraft ist die Steigung des Momentenverlaufs.
- Ohne Streckenlast ist $Q$ also konstant und $M$ linear.
- Bei konstanter Streckenlast ist $Q$ linear und $M$ eine Parabel.
][
*Merksatz:* q steuert die Q-Steigung; Q steuert die M-Steigung.
]

#aufgabe(titel: "Wo hat der Momentenverlauf sein Extremum?", art: "verstehen", quelle: "7.3", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 98* #linebreak()]
Wo hat der Momentenverlauf sein Extremum?
][
*Antwort:*
- Dort, wo die Querkraft null wird bzw. ihr Vorzeichen wechselt, denn $M' = Q$.
- Das gilt auch an einem Sprung von $Q$ über null hinweg, zum Beispiel unter einer Einzelkraft.
][
*Merksatz:* Q wechselt das Vorzeichen, M hat ein Extremum.
]

#aufgabe(titel: "Was passiert mit N und Q an einer rechtwinkligen Rahmenecke?", art: "verstehen", quelle: "7.3", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 99* #linebreak()]
Was passiert mit N und Q an einer rechtwinkligen Rahmenecke?
][
*Antwort:*
- Sie tauschen die Rollen.
- Was im einen Stab Querkraft ist, wird im anderen Stab Normalkraft, und umgekehrt.
- Das Moment läuft ohne äußeres Moment unverändert um die Ecke.
]

#aufgabe(titel: "Balken mit drei Einzelkräften", art: "rechnen", quelle: "7.3", herkunft: "original", vorlage: "TM1-Übung 9, Aufg. 9.2", minuten: 10,
  ergebnis: [$A = 3\/2 F$, $B = 1\/2 F$; $Q = 3\/2 F, 1\/2 F, -3\/2 F, -1\/2 F$; $M = 3\/2 x F$, $(a + x\/2) F$, $(5a - 3\/2 x) F$, $(2a - x\/2) F$],
  tipp: [Zwischen Einzelkräften ist $Q$ konstant und $M$ linear. An jeder Kraft springt $Q$ um den Kraftbetrag.],
)[
#if not web [*Aufgabe 100* #linebreak()]
Der Balken in der Abbildung wird durch die drei Kräfte $F_1 = F$, $F_2 = 2F$, $F_3 = -F$ belastet. Gesucht sind der Querkraft- und Momentenverlauf $Q(x)$ und $M(x)$.
#align(center)[#image(abbildungen.at("tm1k7_ue92"), width: 45%)]

*Gegeben und Annahmen*

Festlager A bei $x = 0$, Loslager B bei $x = 4a$. $F_1$ bei $a$, $F_2$ bei $2a$, $F_3$ bei $3a$; positive Kräfte zeigen nach unten, $F_3 = -F$ wirkt also nach oben.

*Gesucht*

#enum(numbering: "a)",
[Lagerkräfte $A$ und $B$.],
[$Q(x)$ und $M(x)$ in allen vier Feldern.],
)
][
*Lager:* Momente um B: $4a A - 3a F - 2a dot 2F + a F = 0$, also $A = 6\/4 F = 3\/2 F$. Senkrecht: $B = F + 2F - F - 3\/2 F = 1\/2 F$.
][
*Querkraft:* Von links: $Q = A = 3\/2 F$ bis $a$; nach $F_1$: $1\/2 F$; nach $F_2$: $-3\/2 F$; nach $F_3$ (nach oben, also $Q$ steigt): $-1\/2 F$. Am Ende springt $B$ die Querkraft auf null.
][
*Moment:* $M$ ist das Integral von $Q$, beginnend mit $M(0) = 0$: $M = 3\/2 F x$ ($0 <= x <= a$), $M = (a + x\/2) F$ ($a$ bis $2a$), $M = (5a - 3\/2 x) F$ ($2a$ bis $3a$), $M = (2a - x\/2) F$ ($3a$ bis $4a$).
][
*Prüfen:* $M(4a) = 0$ am Loslager. Größtes Moment bei $2a$: $M = 2 F a$, dort wechselt $Q$ das Vorzeichen.
]

#aufgabe(titel: "Balken mit drei Einzelkräften (Variante)", art: "rechnen", quelle: "7.3", herkunft: "variante", vorlage: "TM1-Übung 9, Aufg. 9.2", minuten: 8,
  ergebnis: [$A = 7\/4 F$, $B = 1\/4 F$; $Q = 7\/4 F, -1\/4 F, -5\/4 F, -1\/4 F$; $M(a) = 7\/4 F a$, $M(2a) = 3\/2 F a$, $M(3a) = 1\/4 F a$],
)[
#if not web [*Aufgabe 101* #linebreak()]
*Gegeben und Annahmen*

Balken wie in Übung 9.2 (A bei 0, B bei $4a$), aber $F_1 = 2F$ bei $a$, $F_2 = F$ bei $2a$, $F_3 = -F$ (nach oben) bei $3a$.

*Gesucht*

#enum(numbering: "a)",
[$A$, $B$, $Q(x)$ und die Momente an den Lastpunkten.],
)
][
*Lager:* Momente um B: $4a A = 2F dot 3a + F dot 2a - F dot a = 7 F a$, $A = 7\/4 F$; $B = 2F + F - F - 7\/4 F = 1\/4 F$.
][
*Querkraft:* $7\/4 F$, nach $F_1$: $-1\/4 F$, nach $F_2$: $-5\/4 F$, nach $F_3$: $-1\/4 F$.
][
*Momente:* $M(a) = 7\/4 F a$, $M(2a) = 7\/4 F a - 1\/4 F a = 3\/2 F a$, $M(3a) = 3\/2 F a - 5\/4 F a = 1\/4 F a$, $M(4a) = 0$. Größtes Moment bei $a$, wo $Q$ das Vorzeichen wechselt.
]

#aufgabe(titel: "Träger mit Kragarm", art: "rechnen", quelle: "7.3", herkunft: "original", vorlage: "TM1-Übung 9, Aufg. 9.3", minuten: 10,
  ergebnis: [$A = "8,18" "kN"$, $B = "41,82" "kN"$; $M_("max") = "49,1" "kNm"$ bei 6 m, $M_("min") = -60 "kNm"$ über B, $M = 0$ bei $x = "8,25" "m"$],
)[
#if not web [*Aufgabe 102* #linebreak()]
Für den abgebildeten Träger sind der Querkraft- und Biegemomentenverlauf $Q(x)$ und $M(x)$ zu berechnen und zu skizzieren. (Werte an einigen markanten Stellen berechnen, Verlauf dazwischen nach Anschauung.)
#align(center)[#image(abbildungen.at("tm1k7_ue93"), width: 55%)]

*Gegeben und Annahmen*

Festlager bei $x = 0$, 30 kN bei $x = 6 "m"$, Loslager B bei $x = 11 "m"$, 20 kN am Kragende bei $x = 14 "m"$, beide Lasten nach unten.

*Gesucht*

#enum(numbering: "a)",
[Lagerkräfte.],
[$Q$ und $M$ an den markanten Stellen, Nullstelle von $M$.],
)
][
*Lager:* Momente um A: $-30 dot 6 + 11 B - 20 dot 14 = 0$, $B = 460\/11 = "41,82" "kN"$. $A = 50 - "41,82" = "8,18" "kN"$.
][
*Querkraft:* $"8,18"$ bis 6 m, dann $"8,18" - 30 = -"21,82"$ bis B, dann $-"21,82" + "41,82" = 20 "kN"$ auf dem Kragarm.
][
*Moment:* $M(6) = "8,18" dot 6 = "49,1" "kNm"$. $M(11) = "49,1" - "21,82" dot 5 = -60 "kNm"$ (Kontrolle vom Kragarm: $-20 dot 3 = -60$). Nullstelle: $"49,1" - "21,82" (x - 6) = 0$ bei $x = "8,25" "m"$.
][
*Prüfen:* Am Kragende ist $M = 0$. Das negative Moment über B kommt allein vom Kragarm.
]

#aufgabe(titel: "Träger mit Kragarm (Variante)", art: "rechnen", quelle: "7.3", herkunft: "variante", vorlage: "TM1-Übung 9, Aufg. 9.3", minuten: 8,
  ergebnis: [$A = "15,5" "kN"$, $B = "39,5" "kN"$; $M(5) = "77,5" "kNm"$, $M(B) = -45 "kNm"$, $M = 0$ bei $x approx "8,16" "m"$],
)[
#if not web [*Aufgabe 103* #linebreak()]
*Gegeben und Annahmen*

Träger wie in Übung 9.3, aber 40 kN bei $x = 5 "m"$, Loslager B bei $x = 10 "m"$, 15 kN am Kragende bei $x = 13 "m"$.

*Gesucht*

#enum(numbering: "a)",
[Lagerkräfte, markante Momente, Nullstelle von $M$.],
)
][
*Lager:* $B = (40 dot 5 + 15 dot 13)\/10 = "39,5" "kN"$, $A = 55 - "39,5" = "15,5" "kN"$.
][
*Querkraft:* $"15,5"$; nach 40 kN: $-"24,5"$; nach B: $+15 "kN"$.
][
*Moment:* $M(5) = "77,5" "kNm"$; $M(10) = "77,5" - "24,5" dot 5 = -45 "kNm"$ ($= -15 dot 3$). Nullstelle bei $5 + "77,5"\/"24,5" approx "8,16" "m"$.
]

#aufgabe(titel: "Dreieckslast auf dem Einfeldbalken", art: "rechnen", quelle: "7.3", herkunft: "original", vorlage: "TM1-Übung 9, Aufg. 9.4", minuten: 12,
  ergebnis: [$Q = q_0 l\/6 - q_0 x^2\/(2l)$, $M = q_0 l x\/6 - q_0 x^3\/(6l)$; $Q = 0$ bei $x = l\/sqrt(3)$; $M_("max") = q_0 l^2\/(9 sqrt(3))$],
  tipp: [Die Teilresultierende links vom Schnitt ist die Dreiecksfläche $q_0 x^2\/(2l)$ mit Angriff bei $x\/3$ vor dem Schnitt.],
)[
#if not web [*Aufgabe 104* #linebreak()]
Der gelagerte Balken ist mit einer dreieckförmigen Streckenlast belastet. a) Bestimmen Sie $Q(x)$ und $M(x)$ mittels Teilresultierender. b) Skizzieren Sie beide Verläufe. c) Wo ist $Q = 0$? d) Berechnen Sie Ort und Größe von $M_("max")$.
#align(center)[#image(abbildungen.at("tm1k7_ue94"), width: 40%)]

*Gegeben und Annahmen*

Gelenkig gelagerter Einfeldbalken der Länge $l$, Last $q(x) = q_0 x\/l$ (links 0, rechts $q_0$).

*Gesucht*

#enum(numbering: "a)",
[$Q(x)$ und $M(x)$.],
[Skizze.],
[Nullstelle von $Q$.],
[$M_("max")$.],
)
][
*Lager:* Gesamtlast $q_0 l\/2$ bei $2l\/3$. $A = q_0 l\/6$, $B = q_0 l\/3$.
][
*Teilresultierende:* Links vom Schnitt bei $x$ liegt die Last $q_0 x^2\/(2l)$, ihr Schwerpunkt $x\/3$ vor dem Schnitt. Also $Q = A - q_0 x^2\/(2l)$ und $M = A x - q_0 x^2\/(2l) dot x\/3 = q_0 l x\/6 - q_0 x^3\/(6l)$.
][
*Skizze:* $Q$ ist eine nach unten geöffnete Parabel von $q_0 l\/6$ bis $-q_0 l\/3$; $M$ ist kubisch, null an beiden Enden, mit dem Maximum rechts der Mitte.
][
*Maximum:* $Q = 0$ bei $x^2 = l^2\/3$, also $x = l\/sqrt(3) approx "0,577" l$. Eingesetzt: $M_("max") = q_0 l^2\/(6 sqrt(3)) - q_0 l^2\/(18 sqrt(3)) = q_0 l^2\/(9 sqrt(3)) approx "0,064" q_0 l^2$.
]

#aufgabe(titel: "Fallende Dreieckslast auf dem Einfeldbalken (Variante)", art: "rechnen", quelle: "7.3", herkunft: "variante", vorlage: "TM1-Übung 9, Aufg. 9.4", minuten: 10,
  ergebnis: [$A = q_0 l\/3$, $B = q_0 l\/6$; $Q = q_0 l\/3 - q_0 x + q_0 x^2\/(2l)$; $Q = 0$ bei $x = (1 - 1\/sqrt(3)) l approx "0,423" l$; $M_("max") = q_0 l^2\/(9 sqrt(3))$],
)[
#if not web [*Aufgabe 105* #linebreak()]
*Gegeben und Annahmen*

Einfeldbalken der Länge $l$ wie in Übung 9.4, aber die Dreieckslast fällt: $q(x) = q_0 (1 - x\/l)$, links $q_0$, rechts 0.

*Gesucht*

#enum(numbering: "a)",
[$Q(x)$, $M(x)$, Ort und Größe von $M_("max")$.],
)
][
*Lager:* Last $q_0 l\/2$ bei $l\/3$: $A = q_0 l\/3$, $B = q_0 l\/6$.
][
*Integrieren:* $Q = A - integral_0^x q dif x = q_0 l\/3 - q_0 x + q_0 x^2\/(2l)$, $M = q_0 l x\/3 - q_0 x^2\/2 + q_0 x^3\/(6l)$.
][
*Maximum:* $Q = 0$ ergibt $x^2 - 2 l x + 2l^2\/3 = 0$, im Balken $x = l (1 - 1\/sqrt(3)) approx "0,423" l$. Wegen der Spiegelsymmetrie zur Aufgabe 9.4 ist $M_("max") = q_0 l^2\/(9 sqrt(3))$.
]

#aufgabe(titel: "Trapezlast auf dem Einfeldbalken", art: "rechnen", quelle: "7.3", herkunft: "original", vorlage: "TM1-Übung 10, Aufg. 10.1", minuten: 15,
  ergebnis: [$A = 2\/3 q_0 l$, $B = 5\/6 q_0 l$; $Q = 2\/3 q_0 l - q_0 x - q_0 x^2\/(2l)$; $M_("max") approx "0,19" q_0 l^2$ bei $x approx "0,53" l$],
)[
#if not web [*Aufgabe 106* #linebreak()]
Ein beidseitig gelenkig gelagerter Balken wird durch eine trapezförmig verteilte Streckenlast belastet ($q_1 = 2 q_0$). Gesucht: a) $Q(x)$ und $M(x)$, b) Ort und Größe des maximalen Biegemoments, c) Skizze, d) Lagerreaktionen aus $Q$ und $M$.
#align(center)[#image(abbildungen.at("tm1k7_ue101"), width: 40%)]

*Gegeben und Annahmen*

Länge $l$, $q(x) = q_0 (1 + x\/l)$.

*Gesucht*

#enum(numbering: "a)",
[$Q(x)$, $M(x)$.],
[$M_("max")$.],
[Skizze.],
[$A$ und $B$.],
)
][
*Integrieren:* $Q = -integral q dif x = -q_0 x - q_0 x^2\/(2l) + C_1$, $M = -q_0 x^2\/2 - q_0 x^3\/(6l) + C_1 x + C_2$.
][
*Randbedingungen:* Gelenkige Lager tragen kein Moment: $M(0) = 0$ gibt $C_2 = 0$. $M(l) = 0$: $-q_0 l^2\/2 - q_0 l^2\/6 + C_1 l = 0$, $C_1 = 2\/3 q_0 l$.
][
*Maximum:* $Q = 0$: $x^2 + 2 l x - 4\/3 l^2 = 0$, $x = l(-1 + sqrt(7\/3)) approx "0,528" l$. $M_("max") approx "0,188" q_0 l^2$.
][
*Lager und Skizze:* $A = Q(0) = 2\/3 q_0 l$, $B = -Q(l) = 5\/6 q_0 l$. Kontrolle: $A + B = 3\/2 q_0 l$ = Trapezfläche. $Q$ ist eine fallende Parabel, $M$ kubisch mit Maximum etwas rechts der Mitte.
]

#aufgabe(titel: "Steilere Trapezlast (Variante)", art: "rechnen", quelle: "7.3", herkunft: "variante", vorlage: "TM1-Übung 10, Aufg. 10.1", minuten: 12,
  ergebnis: [$A = 5\/6 q_0 l$, $B = 7\/6 q_0 l$; $M_("max") approx "0,252" q_0 l^2$ bei $x approx "0,541" l$],
)[
#if not web [*Aufgabe 107* #linebreak()]
*Gegeben und Annahmen*

Balken wie in Übung 10.1, aber $q_1 = 3 q_0$: $q(x) = q_0 (1 + 2x\/l)$.

*Gesucht*

#enum(numbering: "a)",
[$Q(x)$, $M(x)$, $A$, $B$, $M_("max")$.],
)
][
*Integrieren:* $Q = -q_0 x - q_0 x^2\/l + C_1$, $M = -q_0 x^2\/2 - q_0 x^3\/(3l) + C_1 x$ (mit $M(0) = 0$).
][
*$M(l) = 0$:* $C_1 = (1\/2 + 1\/3) q_0 l = 5\/6 q_0 l = A$. $B = -Q(l) = -(5\/6 - 2) q_0 l = 7\/6 q_0 l$.
][
*Maximum:* $x^2 + l x - 5\/6 l^2 = 0$, $x = l(-3 + sqrt(39))\/6 approx "0,541" l$; $M_("max") approx "0,252" q_0 l^2$.
]

#aufgabe(titel: "Balken mit Parallelführung, Moment und Kraft", art: "rechnen", quelle: "7.3", herkunft: "original", vorlage: "TM1-Übung 10, Aufg. 10.2", minuten: 15,
  ergebnis: [$Q = F + q_0 l - q_0 x$, $M = -M_0 + (F + q_0 l) x - q_0 x^2\/2$; $A = F + q_0 l$, $M_B = F l + q_0 l^2\/2 - M_0$; Extremum von $M$ bei $x = l + F\/q_0$ nur für $F < 0$ im Balken],
  tipp: [Die Parallelführung B überträgt keine Querkraft senkrecht zur Führung. Am rechten Rand ist deshalb $Q(l) = F$.],
)[
#if not web [*Aufgabe 108* #linebreak()]
Ein Balken mit Lagerung gemäß Abbildung wird durch eine konstante Streckenlast $q_0$ sowie links durch ein Einzelmoment $M_0$ und rechts durch eine Einzelkraft $F$ belastet. a) $Q(x)$ und $M(x)$. b) Ort und Größe der maximalen Querkraft und des maximalen Moments für $F > 0$ und $F < 0$. c) Skizze. d) Lagerreaktionen aus $Q$ und $M$.
#align(center)[#image(abbildungen.at("tm1k7_ue102"), width: 40%)]

*Gegeben und Annahmen*

Länge $l$. A: gelenkiges Lager mit dem Moment $M_0$, so angesetzt, dass $M(0) = -M_0$. B: Parallelführung an der Wand (senkrecht verschieblich, nimmt ein Moment auf), dort greift $F$ nach oben positiv an, sodass $Q(l) = F$.

*Gesucht*

#enum(numbering: "a)",
[$Q(x)$, $M(x)$.],
[Extremwerte für $F > 0$ und $F < 0$.],
[Skizze für beide Fälle.],
[$A$ und $M_B$.],
)
][
*Integrieren:* $Q = -q_0 x + C_1$, $M = -q_0 x^2\/2 + C_1 x + C_2$.
][
*Randbedingungen:* $M(0) = -M_0$ gibt $C_2 = -M_0$. $Q(l) = F$ gibt $C_1 = F + q_0 l$.
][
*Extremwerte:* $Q$ fällt linear: größter Wert $F + q_0 l$ bei $x = 0$, kleinster $F$ bei $x = l$. $M$ hat sein Extremum bei $Q = 0$, also $x = l + F\/q_0$. Für $F > 0$ liegt das außerhalb, $M$ steigt bis $M(l) = F l + q_0 l^2\/2 - M_0$. Für $F < 0$ (und $abs(F) < q_0 l$) liegt es im Balken: $M_("max") = q_0\/2 (l + F\/q_0)^2 - M_0$.
][
*Lagerreaktionen:* $A = Q(0) = F + q_0 l$; Moment in der Parallelführung $M_B = M(l) = F l + q_0 l^2\/2 - M_0$.
]

#aufgabe(titel: "Balken mit Parallelführung (Variante)", art: "rechnen", quelle: "7.3", herkunft: "variante", vorlage: "TM1-Übung 10, Aufg. 10.2", minuten: 10,
  ergebnis: [$Q = 4 - 2x$ (kN), $M = -2 + 4x - x^2$ (kNm); $M_("max") = 2 "kNm"$ bei $x = 2 "m"$; $A = 4 "kN"$, $M_B = 1 "kNm"$],
)[
#if not web [*Aufgabe 109* #linebreak()]
*Gegeben und Annahmen*

System wie in Übung 10.2 mit $q_0 = 2 "kN/m"$, $l = 3 "m"$, $M_0 = 2 "kNm"$, $F = -2 "kN"$ (zeigt also entgegen der Ansatzrichtung).

*Gesucht*

#enum(numbering: "a)",
[$Q(x)$, $M(x)$, Extremwert von $M$, $A$, $M_B$.],
)
][
*Konstanten:* $C_1 = F + q_0 l = -2 + 6 = 4 "kN"$, $C_2 = -2 "kNm"$. Also $Q = 4 - 2x$ und $M = -2 + 4x - x^2$.
][
*Extremum:* $Q = 0$ bei $x = 2 "m"$ (liegt im Balken, weil $F < 0$): $M = -2 + 8 - 4 = 2 "kNm"$.
][
*Lager:* $A = Q(0) = 4 "kN"$, $M_B = M(3) = -2 + 12 - 9 = 1 "kNm"$. Kontrolle $Q(3) = -2 = F$.
]

#aufgabe(titel: "Mehrfeldträger mit Streckenlast und zwei Kräften", art: "rechnen", quelle: "7.3", herkunft: "original", vorlage: "TM1-Übung 10, Aufg. 10.3", minuten: 15,
  ergebnis: [$A = "2,85" F$, $B = "3,15" F$; $Q = 0$ bei $x = "4,85" a$, $M_("max") approx "9,26" F a$],
)[
#if not web [*Aufgabe 110* #linebreak()]
Für den abgebildeten Mehrfeldträger sollen der Querkraft- und Momentenverlauf berechnet und skizziert werden. Wie groß ist das maximale Biegemoment? (Gleichgewicht abschnittsweise, Streckenlast mittels Teilresultierender.)
#align(center)[#image(abbildungen.at("tm1k7_ue103"), width: 55%)]

*Gegeben und Annahmen*

Festlager A bei 0, Loslager B bei $10a$. $F$ bei $2a$, $q_0 = F\/a$ von $3a$ bis $6a$, $2F$ bei $8a$, alles nach unten.

*Gesucht*

#enum(numbering: "a)",
[Lagerkräfte, $Q$ und $M$ an den Feldgrenzen, $M_("max")$.],
)
][
*Lager:* Streckenlast $3F$ bei $"4,5" a$. Momente um A: $10 a B = F dot 2a + 3F dot "4,5" a + 2F dot 8a = "31,5" F a$, $B = "3,15" F$; $A = 6F - "3,15" F = "2,85" F$.
][
*Querkraft:* $"2,85" F$ bis $2a$; $"1,85" F$ bis $3a$; dann linear fallend bis $"1,85" F - 3F = -"1,15" F$ bei $6a$; konstant bis $8a$; nach $2F$: $-"3,15" F$ bis B.
][
*Maximum:* $Q = 0$ im Lastbereich: $"1,85" F - F (x - 3a)\/a = 0$, $x = "4,85" a$. $M = "2,85" F dot "4,85" a - F dot "2,85" a - F\/a dot ("1,85" a)^2\/2 approx "9,26" F a$.
][
*Prüfen:* $M(8a) = B dot 2a = "6,3" F a$ von rechts. Von links: $M(6a) = "9,26" F a - F\/a dot ("1,15" a)^2 \/2 = "8,6" F a$, dann $-"1,15" F dot 2a$ gibt $"6,3" F a$. Passt.
]

#aufgabe(titel: "Mehrfeldträger mit Streckenlast (Variante)", art: "rechnen", quelle: "7.3", herkunft: "variante", vorlage: "TM1-Übung 10, Aufg. 10.3", minuten: 12,
  ergebnis: [$A = "3,5" F$, $B = "2,5" F$; $Q = 0$ bei $x = "4,5" a$, $M_("max") = "9,125" F a$],
)[
#if not web [*Aufgabe 111* #linebreak()]
*Gegeben und Annahmen*

Träger der Länge $10a$ (A bei 0, B bei $10a$) mit $F$ bei $a$, $q_0 = F\/a$ von $2a$ bis $6a$ und $F$ bei $8a$, alles nach unten.

*Gesucht*

#enum(numbering: "a)",
[$A$, $B$, Ort und Größe von $M_("max")$.],
)
][
*Lager:* Streckenlast $4F$ bei $4a$. $10 a B = F a + 4F dot 4a + F dot 8a = 25 F a$, $B = "2,5" F$, $A = 6F - "2,5" F = "3,5" F$.
][
*Querkraft:* $"3,5" F$ bis $a$, $"2,5" F$ bis $2a$, dann fallend; null bei $x = 2a + "2,5" a = "4,5" a$.
][
*Maximum:* $M = "3,5" F dot "4,5" a - F dot "3,5" a - F\/a dot ("2,5" a)^2\/2 = "15,75" - "3,5" - "3,125" = "9,125" F a$.
]

#aufgabe(titel: "Belastung aus der Momentenlinie", art: "rechnen", quelle: "7.3", herkunft: "original", vorlage: "TM1-Übung 10, Aufg. 10.4", minuten: 12,
  ergebnis: [$A = 6 "kN"$; Einzelmoment $6 "kNm"$ bei 2 m; 10 kN nach unten bei 4 m; $B = 9 "kN"$; $q = 5 "kN/m"$ von 6 bis 8 m; 5 kN nach oben am Ende. $Q$: 6, 6, $-4$, dann von 5 linear auf $-5$, dann $-5 "kN"$],
  tipp: [$Q$ ist die Steigung von $M$. Ein Knick in $M$ ist eine Einzelkraft, ein Sprung ein Einzelmoment, eine Parabel eine Gleichstreckenlast.],
)[
#if not web [*Aufgabe 112* #linebreak()]
Gegeben sind ein Balken und eine Momentenlinie. Gesucht ist die dazugehörige Belastung sowie der Querkraftverlauf (mit Zahlen). Der Momentenverlauf ist positiv.
#align(center)[#image("abbildungen/ue1_10_4.png", width: 80%)]

*Gegeben und Annahmen*

Festlager A bei 0, Lager B bei 6 m, freies Ende bei 10 m. $M$: linear von 0 auf 12 kNm bei 2 m, Sprung auf 6, linear auf 18 bei 4 m, linear auf 10 bei 6 m, Parabel (symmetrisch zur Mitte) von 10 bei 6 m auf 10 bei 8 m, dann linear auf 0 bei 10 m; am Übergang bei 8 m gleiche Steigung.

*Gesucht*

#enum(numbering: "a)",
[Die Belastung (Lager, Kräfte, Momente, Streckenlast).],
[$Q(x)$ mit Zahlen.],
)
][
*Steigungen ablesen:* 0–2 m: $12\/2 = 6 "kN"$. 2–4 m: $(18 - 6)\/2 = 6 "kN"$. 4–6 m: $(10 - 18)\/2 = -4 "kN"$. 8–10 m: $(0 - 10)\/2 = -5 "kN"$.
][
*Parabel:* Gleiche Steigung bei 8 m heißt $Q(8) = -5$. Symmetrie zur Mitte 7 m gibt $Q(6^+) = +5$. $Q$ fällt also linear um 10 kN auf 2 m: $q = 5 "kN/m"$. Scheitel: $M(7) = 10 + 5 - "2,5" = "12,5" "kNm"$.
][
*Lasten zuordnen:* Bei 0: $Q$ springt von 0 auf 6, also $A = 6 "kN"$. Bei 2 m: $M$ springt um 6 kNm nach unten, also ein Einzelmoment von 6 kNm. Bei 4 m: $Q$ fällt von 6 auf $-4$, also 10 kN nach unten. Bei 6 m: $Q$ steigt von $-4$ auf $+5$, also $B = 9 "kN"$. Bei 10 m: $Q$ springt von $-5$ auf 0, also 5 kN nach oben.
][
*Prüfen:* Senkrecht: $6 + 9 + 5 - 10 - 5 dot 2 = 0$. Passt.
]

#aufgabe(titel: "Belastung aus der Momentenlinie (Variante)", art: "rechnen", quelle: "7.3", herkunft: "variante", vorlage: "TM1-Übung 10, Aufg. 10.4", minuten: 10,
  ergebnis: [$A = 4 "kN"$; Einzelmoment 4 kNm bei 2 m; 7 kN nach unten bei 4 m; $B = 6 "kN"$; $q = 3 "kN/m"$ von 6 bis 8 m; 3 kN nach oben am Ende; $M_("max")$ der Parabel $"7,5" "kNm"$],
)[
#if not web [*Aufgabe 113* #linebreak()]
*Gegeben und Annahmen*

Balken wie in Übung 10.4 (A bei 0, B bei 6 m, Ende bei 10 m). Positive Momentenlinie: linear von 0 auf 8 kNm bei 2 m, Sprung auf 4 kNm, linear auf 12 bei 4 m, linear auf 6 bei 6 m, symmetrische Parabel von 6 (bei 6 m) auf 6 (bei 8 m), dann linear auf 0 bei 10 m, mit gleicher Steigung bei 8 m.

*Gesucht*

#enum(numbering: "a)",
[Belastung und $Q(x)$.],
)
][
*Steigungen:* $Q = 4$ (0–2 m), $4$ (2–4 m), $-3$ (4–6 m), $-3$ (8–10 m).
][
*Parabel:* $Q(8) = -3$, symmetrisch $Q(6^+) = +3$: $q = 6\/2 = 3 "kN/m"$; Scheitel $M(7) = 6 + 3 - "1,5" = "7,5" "kNm"$.
][
*Lasten:* $A = 4 "kN"$, Einzelmoment 4 kNm bei 2 m, 7 kN nach unten bei 4 m, $B = 3 + 3 = 6 "kN"$, 3 kN nach oben am Ende. Kontrolle: $4 - 7 + 6 - 6 + 3 = 0$.
]

#aufgabe(titel: "Gelenkträger unter Dreieckslast", art: "rechnen", quelle: "7.3", herkunft: "original", vorlage: "TM1-Übung 11, Aufg. 11.1", minuten: 15,
  ergebnis: [$Q = 7\/24 q_0 l - q_0 x^2\/(2l)$, $M = -q_0 x^3\/(6l) + 7\/24 q_0 l x - 1\/8 q_0 l^2$; $M_("max") approx "0,0235" q_0 l^2$ bei $x approx "0,764" l$; $A_z = 7\/24 q_0 l$, $M_A = 1\/8 q_0 l^2$, $B_z = 5\/24 q_0 l$],
  tipp: [Die Last läuft stetig über das Gelenk, deshalb genügt ein Feld. Das Gelenk liefert nur die Zusatzbedingung $M(l\/2) = 0$.],
)[
#if not web [*Aufgabe 114* #linebreak()]
Für den dargestellten Gelenkträger unter Dreieckslast ($a = l\/2$) sind zu bestimmen: $Q$- und $M$-Verlauf (durch Integration), Ort und Größe des maximalen Biegemoments, Lagerreaktionen in A und B (aus $Q$ und $M$), Skizze.
#align(center)[#image(abbildungen.at("tm1k7_ue111"), width: 45%)]

*Gegeben und Annahmen*

Einspannung A bei $x = 0$, Gelenk G bei $x = l\/2$, Loslager B bei $x = l$. $q(x) = q_0 x\/l$.

*Gesucht*

#enum(numbering: "a)",
[$Q(x)$, $M(x)$.],
[$M_("max")$.],
[$A_z$, $M_A$, $B_z$.],
)
][
*Integrieren:* $Q = -q_0 x^2\/(2l) + C_1$, $M = -q_0 x^3\/(6l) + C_1 x + C_2$.
][
*Bedingungen:* Loslager $M(l) = 0$: $-q_0 l^2\/6 + C_1 l + C_2 = 0$. Gelenk $M(l\/2) = 0$: $-q_0 l^2\/48 + C_1 l\/2 + C_2 = 0$. Subtrahieren: $C_1 = 7\/24 q_0 l$, dann $C_2 = -1\/8 q_0 l^2$.
][
*Maximum:* $Q = 0$ bei $x = l sqrt(7\/12) approx "0,764" l$; $M_("max") approx "0,0235" q_0 l^2$.
][
*Lager:* $A_z = Q(0) = 7\/24 q_0 l$, $M_A = -M(0) = 1\/8 q_0 l^2$ (Einspannmoment), $B_z = -Q(l) = (1\/2 - 7\/24) q_0 l = 5\/24 q_0 l$. Kontrolle: $A_z + B_z = q_0 l\/2$.
]

#aufgabe(titel: "Gelenkträger unter Dreieckslast (Variante)", art: "rechnen", quelle: "7.3", herkunft: "variante", vorlage: "TM1-Übung 11, Aufg. 11.1", minuten: 12,
  ergebnis: [$C_1 = A_z = 13\/54 q_0 l$, $M_A = 2\/27 q_0 l^2$, $B_z = 7\/27 q_0 l$; $M_("max") approx "0,0373" q_0 l^2$ bei $x approx "0,694" l$],
)[
#if not web [*Aufgabe 115* #linebreak()]
*Gegeben und Annahmen*

Gelenkträger wie in Übung 11.1, aber das Gelenk liegt bei $x = l\/3$.

*Gesucht*

#enum(numbering: "a)",
[$Q(x)$, $M(x)$, Lagerreaktionen, $M_("max")$.],
)
][
*Bedingungen:* $M(l) = 0$: $-q_0 l^2\/6 + C_1 l + C_2 = 0$. $M(l\/3) = 0$: $-q_0 l^2\/162 + C_1 l\/3 + C_2 = 0$. Subtrahieren: $2\/3 C_1 l = (1\/6 - 1\/162) q_0 l^2 = 26\/162 q_0 l^2$, also $C_1 = 13\/54 q_0 l$ und $C_2 = -2\/27 q_0 l^2$.
][
*Lager:* $A_z = 13\/54 q_0 l$, $M_A = 2\/27 q_0 l^2$, $B_z = q_0 l\/2 - A_z = 7\/27 q_0 l$.
][
*Maximum:* $x = l sqrt(26\/54) = l sqrt(39)\/9 approx "0,694" l$, $M_("max") approx "0,0373" q_0 l^2$.
]

#aufgabe(titel: "Gelenkbalken mit Einspannung, Kraft, Last und Moment", art: "rechnen", quelle: "7.3", herkunft: "original", vorlage: "TM1-Übung 11, Aufg. 11.2", minuten: 20,
  ergebnis: [$A = 1017 "kN"$, $M_A = 9400 "kNm"$, $B = 583 "kN"$, Gelenkkraft 317 kN; $M_("min") = -9400 "kNm"$ an A; im Bereich III $M_("max") approx 334 "kNm"$ bei $x_3 approx "2,11" "m"$],
  tipp: [Fang rechts vom Gelenk an: Bereich III hat $M = 0$ am Gelenk und $M = -M_0$ am Lager B.],
)[
#if not web [*Aufgabe 116* #linebreak()]
Für einen Gelenkbalken gemäß Abbildung sind zu bestimmen: $Q$- und $M$-Verlauf (durch Integration, Koordinaten $x_1$, $x_2$, $x_3$), Ort und Größe von $M_("max")$ und $Q_("max")$, Lager- und Gelenkreaktionen, Skizze.
#align(center)[#image(abbildungen.at("tm1k7_ue112"), width: 60%)]

*Gegeben und Annahmen*

Einspannung A, $F = 700 "kN"$ nach $a = 8 "m"$, Gelenk G nach weiteren $b = 4 "m"$, dann $q_0 = 150 "kN/m"$ auf $c = 6 "m"$ bis zum Loslager B, dort das Moment $M_0 = 800 "kNm"$ mit $M(B) = -M_0$.

*Gesucht*

#enum(numbering: "a)",
[Lager- und Gelenkreaktionen.],
[$Q$ und $M$ in den drei Bereichen, Extremwerte.],
)
][
*Bereich III ($x_3$ ab G):* $Q_3 = Q_G - q_0 x_3$, $M_3 = Q_G x_3 - q_0 x_3^2\/2$ (Gelenk: $M = 0$). Bedingung $M_3(c) = -800$: $6 Q_G - 150 dot 18 = -800$, $Q_G = "316,7" "kN"$. $B = -Q_3(c) = 900 - "316,7" = "583,3" "kN"$.
][
*Bereiche I und II:* Links vom Gelenk ist $Q = Q_G = "316,7" "kN"$ (Bereich II), vor der Kraft $Q = "316,7" + 700 = "1016,7" "kN" = A$. $M$ am Gelenk null: $M(8) = -"316,7" dot 4 = -"1266,7" "kNm"$, $M(0) = -"1266,7" - "1016,7" dot 8 = -9400 "kNm"$, also $M_A = 9400 "kNm"$.
][
*Extrema:* $Q_("max") = 1017 "kN"$ in Bereich I. $M_("min") = -9400 "kNm"$ an A. In Bereich III ist $Q_3 = 0$ bei $x_3 = "316,7"\/150 = "2,11" "m"$: $M_("max") = "316,7"^2\/300 approx 334 "kNm"$.
][
*Prüfen:* $M_3(6) = "316,7" dot 6 - 75 dot 36 = -800$. Das Lösungsblatt nennt „3,34 kNm“; richtig sind etwa 334 kNm.
]

#aufgabe(titel: "Gelenkbalken mit Einspannung (Variante)", art: "rechnen", quelle: "7.3", herkunft: "variante", vorlage: "TM1-Übung 11, Aufg. 11.2", minuten: 15,
  ergebnis: [$Q_G = 130 "kN"$, $B = 370 "kN"$, $A = 630 "kN"$, $M_A = 4170 "kNm"$; $M(a) = -390 "kNm"$; $M_("max") = "84,5" "kNm"$ bei $x_3 = "1,3" "m"$],
)[
#if not web [*Aufgabe 117* #linebreak()]
*Gegeben und Annahmen*

Gelenkbalken wie in Übung 11.2 mit $F = 500 "kN"$, $a = 6 "m"$, $b = 3 "m"$, $q_0 = 100 "kN/m"$, $c = 5 "m"$, $M_0 = 600 "kNm"$ ($M(B) = -M_0$).

*Gesucht*

#enum(numbering: "a)",
[Lager- und Gelenkkräfte, $M_A$, Extremwerte.],
)
][
*Bereich III:* $5 Q_G - 100 dot 25\/2 = -600$, $Q_G = 130 "kN"$; $B = 500 - 130 = 370 "kN"$.
][
*Links:* $A = 130 + 500 = 630 "kN"$. $M(6) = -130 dot 3 = -390 "kNm"$, $M(0) = -390 - 630 dot 6 = -4170$, also $M_A = 4170 "kNm"$.
][
*Feldmaximum:* $x_3 = 130\/100 = "1,3" "m"$, $M = 130^2\/200 = "84,5" "kNm"$.
]

#aufgabe(titel: "Kran auf einer Brücke", art: "rechnen", quelle: "7.3", herkunft: "original", vorlage: "TM1-Übung 11, Aufg. 11.3", minuten: 15,
  ergebnis: [$A = G\/l (81\/80 l - x)$, $B = G\/l (x - l\/80)$; $M_("max") = "0,2438" G l$ unter der Vorderachse bei $x = 81\/160 l$],
  tipp: [Das größte Moment liegt immer unter einer Achse. Schreibe es als Funktion von $x$ und leite ab.],
)[
#if not web [*Aufgabe 118* #linebreak()]
Über eine Brücke der Länge $l$ fährt ein Kran vom Gewicht $G$. Die Vorderachse ist mit $3\/4 G$, die Hinterachse mit $1\/4 G$ belastet. Der Achsabstand beträgt $l\/20$. a) Lagerreaktionen als Funktion von $x$. b) Maximales Biegemoment: qualitativer Verlauf, Eckwerte als Funktion von $x$, Position mit der größten Belastung und Ort des Maximums.
#align(center)[#image(abbildungen.at("tm1k7_ue113"), width: 45%)]

*Gegeben und Annahmen*

Einfeldbalken A–B, Länge $l$. Vorderachse $V = 3\/4 G$ bei $x$, Hinterachse $H = 1\/4 G$ bei $x - l\/20$.

*Gesucht*

#enum(numbering: "a)",
[$A(x)$ und $B(x)$.],
[$M_V (x)$, $M_H (x)$ und ihr Maximum.],
)
][
*Lager:* Momente um A: $l B = V x + H (x - l\/20) = G x - G l\/80$, also $B = G\/l (x - l\/80)$; $A = G - B = G\/l (81\/80 l - x)$.
][
*Momentenverlauf:* Zwei Einzelkräfte: $M$ ist dreieckig mit Knicken unter den Achsen, null in A und B. Unter der Vorderachse: $M_V = B (l - x) = G\/l (l - x)(x - l\/80)$.
][
*Maximum unter V:* $dif M_V\/dif x = 0$: $l - 2x + l\/80 = 0$, $x = 81\/160 l$. $M_V = G\/l (79\/160 l)(79\/160 l) = (79\/160)^2 G l approx "0,2438" G l$.
][
*Unter H:* $M_H = A (x - l\/20)$, maximal $"0,2316" G l$ bei $x = 85\/160 l$. Kleiner, also tritt $M_("max") = "0,2438" G l$ unter der Vorderachse auf, wenn sie bei $81\/160 l$ steht.
]

#aufgabe(titel: "Kran auf einer Brücke (Variante)", art: "rechnen", quelle: "7.3", herkunft: "variante", vorlage: "TM1-Übung 11, Aufg. 11.3", minuten: 12,
  ergebnis: [$M_("max") = (29\/60)^2 G l approx "0,2336" G l$ unter der Vorderachse bei $x = 31\/60 l$ (unter der Hinterachse höchstens $"0,2178" G l$)],
)[
#if not web [*Aufgabe 119* #linebreak()]
*Gegeben und Annahmen*

Kranbrücke wie in Übung 11.3, aber Vorderachse $2\/3 G$, Hinterachse $1\/3 G$, Achsabstand $l\/10$.

*Gesucht*

#enum(numbering: "a)",
[$B(x)$, $M_V (x)$ und das größte Moment.],
)
][
*Lager:* $l B = 2\/3 G x + 1\/3 G (x - l\/10) = G (x - l\/30)$, $B = G\/l (x - l\/30)$.
][
*Unter V:* $M_V = G\/l (l - x)(x - l\/30)$; Maximum bei $x = (l + l\/30)\/2 = 31\/60 l$: $M_V = (29\/60)^2 G l approx "0,2336" G l$.
][
*Unter H:* $M_H = A (x - l\/10)$ mit $A = G - B$; Maximum $"0,2178" G l$ bei $x approx "0,567" l$. Also bleibt die Vorderachse maßgebend.
]

#aufgabe(titel: "Momentenmaximum aus Q(x)", art: "rechnen", quelle: "7.3", herkunft: "eigen", minuten: 5,
  ergebnis: [$M(x) = 6x - x^2$ in kNm; Maximum bei $x = 3 thin "m"$ mit $M = 9 thin "kNm"$],
  tipp: [M ist die Stammfunktion von Q. Wo Q null wird, hat M einen Extremwert.],
)[
#if not web [*Aufgabe 120* #linebreak()]
*Eigene Aufgabe nach neuer Lösung TM1 Nr. 10 S. 1–2:*

*Gegeben und Annahmen*

$Q(x)=6-2x$ in kN bei $x$ in m, $M(0)=0$.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $M(x)$ und die innere Extremstelle.],
)
][
*Bild:* Q ist die Steigung von M. Solange Q positiv ist, steigt M; wird Q negativ, fällt M wieder. Der Gipfel liegt genau dort, wo Q das Vorzeichen wechselt.
][
*Integrieren:* $M(x) = integral (6 - 2x) thin d x = 6x - x^2 + C$. Mit $M(0) = 0$ ist $C = 0$.
][
*Extremstelle:* $Q(x) = 6 - 2x = 0$ ergibt $x = 3 thin "m"$.
][
*Wert:* $M(3) = 18 - 9 = 9 thin "kNm"$. Q wechselt dort von positiv nach negativ, also ist es ein Maximum.
][
*Prüfen:* Die Ableitung $d M\/d x = 6 - 2x$ gibt wieder Q. kN mal m ergibt kNm.
]

#aufgabe(titel: "Schnittgrößen im Abschnitt A bis E", art: "rechnen", quelle: "7.4", herkunft: "original", vorlage: "Altklausur SS 24, Aufg. 1 (Schnittgrößen A–E)", minuten: 8,
  ergebnis: [Nach A: $N=-4F$, $Q=-8F$, $M=0$. Vor E: $N=-4F$, $Q=-8F$, $M=-32F a$],
  tipp: [Ohne Last im Abschnitt bleiben N und Q konstant, und M ändert sich linear mit der Steigung Q.],
)[
#if not web [*Aufgabe 121* #linebreak()]
*AK24 S. 8–10:*

*Gegeben und Annahmen*

Gerader, zwischen A und E unbelasteter Riegelabschnitt, Länge $4a$. An A wirkt die resultierende Seilkraft mit $4F$ nach rechts und $8F$ nach unten, ohne eingeprägtes Moment. $x$ läuft von A nach E. Die Bezugsfaser liegt unten; benutze die zugehörige positive Schnittuferkonvention.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $N,Q,M$ unmittelbar nach A und unmittelbar vor E.],
[Prüfe die Verläufe im unbelasteten Abschnitt.],
)
][
*Bild:* Schneide den Träger direkt hinter A und betrachte das Stück bis zum Schnitt. Im Lager A greifen die Lagerkräfte an, aber kein Moment, denn A ist ein Gelenklager.
][
*Direkt nach A:* Die Lagerkräfte gehen unmittelbar in die Schnittgrößen über: *$N=-4F$* (Druck), *$Q=-8F$*. Ein Gelenklager kann kein Moment übertragen, also *$M=0$*.
][
*Zwischen A und E:* Im Abschnitt greift keine Last an. Damit ändern sich N und Q nicht, und $M$ wächst linear mit der Steigung $d M\/d x = Q = -8F$.
][
*Direkt vor E:* Der Abschnitt ist $4a$ lang, also $M = 0 + (-8F) dot 4a = -32F a$. N und Q bleiben *$-4F$* und *$-8F$*.
][
*Prüfen:* konstantes Q, lineares M ohne Knick. Das Vorzeichen von M passt zum negativen Q: das Moment fällt von null aus ab.
]

#aufgabe(titel: "Schnittgrößen im Abschnitt A bis E (Variante)", art: "rechnen", quelle: "7.4", herkunft: "variante", vorlage: "Altklausur SS 24, Aufg. 1 (Schnittgrößen A–E)", minuten: 6,
  ergebnis: [Nach A: $N = -12F$, $Q = -18F$, $M = 0$; vor E: $N = -12F$, $Q = -18F$, $M = -54 F a$],
)[
#if not web [*Aufgabe 122* #linebreak()]
*Gegeben und Annahmen*

Unbelasteter Riegelabschnitt A–E der Länge $3a$; an A wirkt die Seilkraft $12F$ nach rechts und $18F$ nach unten, kein Moment. Bezugsfaser unten, Konvention wie im Original.

*Gesucht*

#enum(numbering: "a)",
[$N$, $Q$, $M$ direkt nach A und direkt vor E.],
)
][
*Nach A:* $N = -12F$ (Druck), $Q = -18F$, $M = 0$ (Gelenklager).
][
*Im Abschnitt:* keine Last, also $N$, $Q$ konstant und $M$ linear mit Steigung $Q$.
][
*Vor E:* $M = -18F dot 3a = -54 F a$.
]

#aufgabe(titel: "Schnittgrößen rechts vom Gelenk E", art: "rechnen", quelle: "7.4", herkunft: "original", vorlage: "Altklausur SS 24, Aufg. 1 (Schnittgrößen rechts von E)", minuten: 8,
  ergebnis: [$N=10F$, $Q=-5F$, $M=20F a$],
  tipp: [Am rechten Schnittufer zeigen die positiven Schnittgrößen andersherum als am linken. Zeichne sie zuerst ein.],
)[
#if not web [*Aufgabe 123* #linebreak()]
*AK24 S. 13–14:*

*Gegeben und Annahmen*

Betrachte nur den rechten Teil des Riegels E–G. Am Gelenk wirken auf den T-Träger $G_H=10F$ nach rechts und $G_V=5F$ nach oben. Die Länge E–G beträgt $4a$.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $N,Q,M$ unmittelbar rechts von E; Bezugsfaser unten.],
)
][
*Pfeile festlegen:* Am rechten Teil ist das negative Schnittufer. Hier zeigen die positiven Schnittgrößen so: N nach links, Q nach oben, M im Uhrzeigersinn (Bezugsfaser unten).
][
*Waagerecht:* Am Teil wirken nur $G_H = 10F$ nach rechts und N nach links: $N = 10F$. Positiv, also Zug.
][
*Senkrecht:* $G_V = 5F$ nach oben und Q nach oben: $Q + 5F = 0$, also $Q = -5F$.
][
*Moment um den Schnitt bei E:* $G_V$ hat den Arm $4a$ und dreht um E gegen den Uhrzeigersinn. Das Schnittmoment muss das ausgleichen: $M = 5F dot 4a = 20F a$.
][
*Prüfen:* Die positive Gelenkkraft nach oben mit Arm $4a$ wird vom Schnittmoment genau aufgehoben. Die Einheiten sind Kraft und Kraft mal Länge.
]

#aufgabe(titel: "Schnittgrößen rechts vom Gelenk E (Variante)", art: "rechnen", quelle: "7.4", herkunft: "variante", vorlage: "Altklausur SS 24, Aufg. 1 (Schnittgrößen rechts von E)", minuten: 6,
  ergebnis: [$N = 8F$, $Q = -3F$, $M = 15 F a$],
)[
#if not web [*Aufgabe 124* #linebreak()]
*Gegeben und Annahmen*

Rechter Riegelteil E–G der Länge $5a$; am Gelenk G wirken $G_H = 8F$ nach rechts und $G_V = 3F$ nach oben. Bezugsfaser unten.

*Gesucht*

#enum(numbering: "a)",
[$N$, $Q$, $M$ direkt rechts von E.],
)
][
*Pfeile:* negatives Schnittufer: $N$ nach links, $Q$ nach oben, $M$ im Uhrzeigersinn.
][
*Kräfte:* $N = 8F$ (Zug); $Q + 3F = 0$, also $Q = -3F$.
][
*Moment um E:* $M = 3F dot 5a = 15 F a$.
]

#kapitel("TM1 Kapitel 9 · Haftreibung als kurzer Klausurbaustein")

#aufgabe(titel: "Richtung der Haftkraft", art: "verstehen", quelle: "9.2", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 125* #linebreak()]
Welche Richtung hat die Haftkraft, und wann darfst du die Grenzgleichung verwenden?
][
Entgegen der drohenden Relativbewegung. Gleichheit gilt nur im Grenzfall; sonst prüft man die Ungleichung.
]

#aufgabe(titel: "Ist die Haftreibungskraft immer μ₀·N?", art: "verstehen", quelle: "9.2", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 126* #linebreak()]
Ist die Haftreibungskraft immer $mu_0 N$?
][
*Antwort:*
- Nein.
- Sie stellt sich so ein, wie es das Gleichgewicht verlangt, und ist meist kleiner.
- $mu_0 N$ ist nur die Obergrenze, die Haftgrenze.
- Erst wenn diese erreicht ist, gilt $H = mu_0 N$.
#align(center)[#image(abbildungen.at("ak_ss16_klotz"), width: 60%)]
][
*Merksatz:* Haftreibung passt sich an; $mu_0 N$ ist nur die Grenze.
][
*Bild:* Wie ein Freund, der dagegenhält: Er drückt genau so stark wie du, bis seine Kraft nicht mehr reicht.
]

#aufgabe(titel: "Was bedeutet es, wenn die Normalkraft negativ herauskommt?", art: "verstehen", quelle: "9.2", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 127* #linebreak()]
Was bedeutet es, wenn die Normalkraft negativ herauskommt?
][
*Antwort:*
- Der Kontakt müsste ziehen.
- Das kann eine Auflage nicht, also hebt der Körper an dieser Stelle ab.
- Die Annahme »liegt auf« war falsch, und man muss neu rechnen.
#align(center)[#image(abbildungen.at("ak_ss16_klotz"), width: 60%)]
][
*Merksatz:* Eine normale Auflage kann drücken, nicht ziehen.
]

#aufgabe(titel: "Wie unterscheiden sich Haftreibung und Gleitreibung?", art: "verstehen", quelle: "9.2", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 128* #linebreak()]
Wie unterscheiden sich Haftreibung und Gleitreibung?
][
*Antwort:*
- Haftreibung wirkt, solange nichts rutscht, und passt sich bis $mu_0 N$ an: $abs(H) <= mu_0 N$.
- Gleitreibung wirkt, sobald es rutscht, und ist fest $R = mu N$ mit $mu < mu_0$.
- Deshalb ist es schwerer, etwas loszureißen, als es in Bewegung zu halten.
#align(center)[#image(abbildungen.at("ak_ss16_klotz"), width: 60%)]
]

#aufgabe(titel: "Klotz auf der schiefen Ebene mit waagerechter Kraft", art: "rechnen", quelle: "9.2", herkunft: "original", vorlage: "TM1-Übung 13, Aufg. 13.1", minuten: 15,
  ergebnis: [$G (sin alpha - mu_0 cos alpha)\/(cos alpha + mu_0 sin alpha) <= F <= G (sin alpha + mu_0 cos alpha)\/(cos alpha - mu_0 sin alpha)$, mit $mu_0 = tan rho_0$: $G tan(alpha - rho_0) <= F <= G tan(alpha + rho_0)$],
  tipp: [Zwei Grenzfälle: Der Klotz will hinaufrutschen (Haftkraft zeigt hangabwärts) oder hinunterrutschen (Haftkraft zeigt hangaufwärts).],
)[
#if not web [*Aufgabe 129* #linebreak()]
Ein Körper vom Gewicht $G$ befindet sich auf einer rauen schiefen Ebene. a) Innerhalb welcher Grenzen muss die horizontal angreifende Kraft $F$ liegen, damit der Körper in Ruhe bleibt? b) Ersetzen Sie $mu_0$ durch den Reibwinkel $rho_0$ und vereinfachen Sie. c) Grafische Lösung mit dem Reibwinkel.
#align(center)[#image("abbildungen/ue1_13_1.png", width: 35%)]

*Gegeben und Annahmen*

Neigung $alpha$, Haftzahl $mu_0 = tan rho_0$, $F$ waagerecht gegen den Hang. Koordinaten: $x$ hangaufwärts, $y$ senkrecht zur Ebene.

*Gesucht*

#enum(numbering: "a)",
[Untere und obere Grenze von $F$.],
[Form mit $rho_0$.],
[Grafische Deutung.],
)
][
*Zerlegen:* $F$ hat hangaufwärts $F cos alpha$ und in die Ebene $F sin alpha$. $G$ hat hangabwärts $G sin alpha$ und in die Ebene $G cos alpha$. Also $N = G cos alpha + F sin alpha$.
][
*Obere Grenze (will hinauf):* $H = mu_0 N$ zeigt hangabwärts: $F cos alpha - G sin alpha - mu_0 (G cos alpha + F sin alpha) = 0$, also $F_("max") = G (sin alpha + mu_0 cos alpha)\/(cos alpha - mu_0 sin alpha)$.
][
*Untere Grenze (will hinunter):* $H$ zeigt hangaufwärts: $F cos alpha - G sin alpha + mu_0 N = 0$, also $F_("min") = G (sin alpha - mu_0 cos alpha)\/(cos alpha + mu_0 sin alpha)$.
][
*b) Mit $rho_0$:* $mu_0 = sin rho_0\/cos rho_0$ einsetzen, mit $cos rho_0$ erweitern und die Additionstheoreme nutzen: $F_("max") = G tan(alpha + rho_0)$, $F_("min") = G tan(alpha - rho_0)$.
][
*c) Grafisch:* Die Resultierende aus $N$ und $H$ darf höchstens um $rho_0$ von der Flächennormalen abweichen (Reibkegel). Zusammen mit $G$ (senkrecht) und $F$ (waagerecht) bildet sie ein geschlossenes Krafteck; die Grenzlagen des Kegels liefern genau $G tan(alpha plus.minus rho_0)$.
]

#aufgabe(titel: "Klotz auf der schiefen Ebene (Variante)", art: "rechnen", quelle: "9.2", herkunft: "variante", vorlage: "TM1-Übung 13, Aufg. 13.1", minuten: 8,
  ergebnis: [$rho_0 = "16,7"°$; $"72,9" "N" <= F <= "445,5" "N"$],
)[
#if not web [*Aufgabe 130* #linebreak()]
*Gegeben und Annahmen*

Anordnung wie in Übung 13.1 mit $G = 500 "N"$, $alpha = 25°$, $mu_0 = "0,3"$.

*Gesucht*

#enum(numbering: "a)",
[Bereich der waagerechten Kraft $F$, in dem der Klotz haftet.],
)
][
*Reibwinkel:* $rho_0 = arctan "0,3" = "16,7"°$.
][
*Grenzen:* $F_("min") = 500 tan("8,3"°) = "72,9" "N"$, $F_("max") = 500 tan("41,7"°) = "445,5" "N"$.
][
*Prüfen:* Ohne $F$ würde der Klotz rutschen, weil $alpha > rho_0$. Deshalb braucht es eine Mindestkraft.
]

#aufgabe(titel: "Walze in der Ecke anheben", art: "rechnen", quelle: "9.2", herkunft: "original", vorlage: "TM1-Übung 13, Aufg. 13.2", minuten: 12,
  ergebnis: [$F = G (mu_0^2 + mu_0)\/(2 mu_0^2 + mu_0 + 1)$],
  tipp: [Damit sich die Walze dreht, müssen beide Kontaktstellen gleichzeitig rutschen: $H_1 = mu_0 N_1$ und $H_2 = mu_0 N_2$.],
)[
#if not web [*Aufgabe 131* #linebreak()]
Wie groß muss die Kraft $F$ sein, damit die Walze mit der Gewichtskraft $G$ und dem Radius $r$ in Bewegung gesetzt wird? Der Haftreibungskoeffizient $mu_0$ ist an Wand und Boden gleich. Nur der Fall $F > 0$.
#align(center)[#image("abbildungen/ue1_13_2.png", width: 30%)]

*Gegeben und Annahmen*

Walze in einer Ecke: Wand links, Boden unten. $F$ greift rechts am Rand senkrecht nach oben an (Hebelarm $r$ um den Mittelpunkt M).

*Gesucht*

#enum(numbering: "a)",
[Die Kraft $F$, bei der die Walze zu rutschen beginnt.],
)
][
*Freischneiden:* Wand: $N_1$ nach rechts, $H_1$ nach oben. Boden: $N_2$ nach oben, $H_2$ nach links. Dazu $G$ und $F$. $F$ will die Walze gegen den Uhrzeigersinn drehen; die Haftkräfte wirken dagegen.
][
*Gleichgewicht:* Waagerecht: $N_1 = H_2$. Senkrecht: $H_1 + N_2 + F - G = 0$. Momente um M: $F r - H_1 r - H_2 r = 0$, also $F = H_1 + H_2$.
][
*Grenzfall:* $H_2 = mu_0 N_2$, $N_1 = mu_0 N_2$, $H_1 = mu_0 N_1 = mu_0^2 N_2$. Damit $F = (mu_0^2 + mu_0) N_2$ und senkrecht $N_2 (1 + 2 mu_0^2 + mu_0) = G$.
][
*Ergebnis:* $F = G (mu_0^2 + mu_0)\/(2 mu_0^2 + mu_0 + 1)$. Kontrolle: für $mu_0 = 0$ genügt $F = 0$, weil eine glatte Walze sich ohne Widerstand dreht.
]

#aufgabe(titel: "Walze in der Ecke anheben (Variante)", art: "rechnen", quelle: "9.2", herkunft: "variante", vorlage: "TM1-Übung 13, Aufg. 13.2", minuten: 6,
  ergebnis: [$N_2 approx "727,3" "N"$, $F approx "227,3" "N"$],
)[
#if not web [*Aufgabe 132* #linebreak()]
*Gegeben und Annahmen*

Walze wie in Übung 13.2 mit $G = 1000 "N"$ und $mu_0 = "0,25"$.

*Gesucht*

#enum(numbering: "a)",
[Bodennormalkraft $N_2$ und Grenzkraft $F$.],
)
][
*Normalkraft:* $N_2 = G\/(2 mu_0^2 + mu_0 + 1) = 1000\/"1,375" = "727,3" "N"$.
][
*Kraft:* $F = (mu_0^2 + mu_0) N_2 = "0,3125" dot "727,3" = "227,3" "N"$.
]

#aufgabe(titel: "Wie hoch kann man auf die Leiter steigen?", art: "rechnen", quelle: "9.2", herkunft: "original", vorlage: "TM1-Übung 13, Aufg. 13.3", minuten: 10,
  ergebnis: [$h = mu_0 L cos alpha \/ tan alpha = "2,1" "m"$ für Vater und Tochter (unabhängig von $G$)],
)[
#if not web [*Aufgabe 133* #linebreak()]
Wie hoch (über dem Boden) kann ein Mann mit 85 kg auf eine 5 m lange Leiter steigen, die unter $alpha = 30°$ an einer glatten Wand lehnt, bis diese bei $mu_0 = "0,28"$ zum Boden zu rutschen beginnt? Wie hoch kann seine Tochter mit 25 kg steigen? (Gewicht der Leiter vernachlässigt.)
#align(center)[#image("abbildungen/ue1_13_3.png", width: 30%)]

*Gegeben und Annahmen*

$L = 5 "m"$, $alpha = 30°$ gegen die senkrechte Wand, Wand glatt, Boden rau mit $mu_0 = "0,28"$. Person $G$ in der Höhe $h$.

*Gesucht*

#enum(numbering: "a)",
[Grenzhöhe $h$ für beide Personen.],
)
][
*Kräfte:* Wand: nur $N_W$ waagerecht. Boden: $N_B$ nach oben, $H_B$ zur Wand hin. Senkrecht: $N_B = G$. Waagerecht: $H_B = N_W$.
][
*Momente um den Fußpunkt:* Die Person steht waagerecht $h tan alpha$ vom Fuß entfernt, die Wandkraft greift in der Höhe $L cos alpha$ an: $N_W L cos alpha = G h tan alpha$.
][
*Grenzfall:* $H_B = mu_0 N_B = mu_0 G$, also $mu_0 G L cos alpha = G h tan alpha$ und $h = mu_0 L cos alpha\/tan alpha = "0,28" dot 5 dot "0,866"\/"0,577" = "2,1" "m"$.
][
*Deutung:* $G$ kürzt sich heraus: Die Tochter kommt genauso hoch wie der Vater. Schwerer heißt mehr Normalkraft und damit mehr möglicher Haftung, im selben Verhältnis.
]

#aufgabe(titel: "Grenzhöhe auf der Leiter (Variante)", art: "rechnen", quelle: "9.2", herkunft: "variante", vorlage: "TM1-Übung 13, Aufg. 13.3", minuten: 6,
  ergebnis: [$h approx "4,65" "m"$ (Leiterkopf bei $"5,64" "m"$)],
)[
#if not web [*Aufgabe 134* #linebreak()]
*Gegeben und Annahmen*

Leiter wie in Übung 13.3, aber $L = 6 "m"$, $alpha = 20°$ gegen die Wand, $mu_0 = "0,3"$.

*Gesucht*

#enum(numbering: "a)",
[Grenzhöhe $h$.],
)
][
*Formel:* $h = mu_0 L cos alpha\/tan alpha = "0,3" dot 6 dot "0,940"\/"0,364" approx "4,65" "m"$.
][
*Prüfen:* Der Leiterkopf liegt bei $L cos alpha = "5,64" "m"$; die Grenze liegt darunter, also ist sie erreichbar. Je steiler die Leiter, desto höher kommt man.
]

#aufgabe(titel: "Balken an der Wand mit Stütze", art: "rechnen", quelle: "9.2", herkunft: "original", vorlage: "Altklausur 2018, Aufg. 1 h)", minuten: 6,
  ergebnis: [$S = G\/(2 sin alpha)$, $N = G\/(2 tan alpha)$, $H = G\/2$; $mu_(0,"min") = tan alpha$],
)[
#if not web [*Aufgabe 135* #linebreak()]
Ein Balken (Länge $l$, Gewicht $G$) und ein gewichtsloser Stab (Länge $l\/2$) bilden das gezeigte System. Zwischen Balken und Wand herrscht Haftung. Wie groß muss bei gegebenem Winkel $alpha$ der Haftungskoeffizient $mu_0$ mindestens sein, damit sich der Balken gerade nicht bewegt? Vervollständigen Sie den Freischnitt und stellen Sie die Gleichgewichte im vorgegebenen $x$-$y$-System auf.
#align(center)[#image("abbildungen/ak_2018_haftung.png", width: 75%)]

*Gegeben und Annahmen*

Der Balken lehnt mit dem unteren Ende A an einer senkrechten Wand und steigt unter $alpha$ an. In seiner Mitte (bei $l\/2$) greifen $G$ und der Stab an; der Stab führt unter $alpha$ gegen die Waagerechte nach rechts unten zu einem Festlager und drückt den Balken mit $S$ nach links oben. $x$ waagerecht, $y$ senkrecht.

*Gesucht*

#enum(numbering: "a)",
[$sum M_A$, $sum F_x$, $sum F_y$, Grenzhaftbedingung.],
[Mindestwert von $mu_0$.],
)
][
*Freischnitt:* In A wirken die Wandnormalkraft $N$ (waagerecht, von der Wand weg nach rechts) und die Haftkraft $H$ (senkrecht). In der Mitte $G$ nach unten und $S$ in Richtung $(-cos alpha; sin alpha)$.
][
*Gleichgewichte:* $sum M_A: -G l\/2 cos alpha + S l\/2 (cos alpha sin alpha + sin alpha cos alpha) = 0$, also $S = G\/(2 sin alpha)$. $sum F_x: N - S cos alpha = 0$, $N = G\/(2 tan alpha)$. $sum F_y: H + S sin alpha - G = 0$, $H = G\/2$.
][
*Grenzhaftung:* $abs(H) <= mu_0 N$. Also $mu_0 >= H\/N = (G\/2)\/(G\/(2 tan alpha)) = tan alpha$.
][
*Deutung:* Je flacher der Balken, desto kleiner darf $mu_0$ sein. $G$ und $l$ kürzen sich heraus.
]

#aufgabe(titel: "Balken an der Wand mit Stütze (Variante)", art: "rechnen", quelle: "9.2", herkunft: "variante", vorlage: "Altklausur 2018, Aufg. 1 h)", minuten: 6,
  ergebnis: [$S = 3G\/(4 sin alpha)$, $N = 3G\/(4 tan alpha)$, $H = G\/4$; $mu_(0,"min") = tan alpha\/3 approx "0,28"$ für $alpha = 40°$],
)[
#if not web [*Aufgabe 136* #linebreak()]
*Gegeben und Annahmen*

System wie in Altklausur 2018, Aufg. 1 h), aber durch eine Zusatzlast liegt der Schwerpunkt des Balkens (Gesamtgewicht $G$) bei $3l\/4$ von A. Der Stab greift weiterhin bei $l\/2$ unter $alpha$ an. $alpha = 40°$.

*Gesucht*

#enum(numbering: "a)",
[$S$, $N$, $H$ und den Mindestwert von $mu_0$.],
)
][
*Momente um A:* $G dot 3l\/4 cos alpha = S l\/2 dot 2 sin alpha cos alpha$, also $S = 3G\/(4 sin alpha)$.
][
*Kräfte:* $N = S cos alpha = 3G\/(4 tan alpha)$; $H = G - S sin alpha = G\/4$.
][
*Grenze:* $mu_0 >= (G\/4)\/(3G\/(4 tan alpha)) = tan alpha\/3 = "0,28"$. Der weiter oben liegende Schwerpunkt drückt den Balken stärker gegen die Wand und braucht weniger Haftung.
]

#aufgabe(titel: "Klotz mit Seil über eine Rolle", art: "rechnen", quelle: "9.2", herkunft: "original", vorlage: "Altklausur SS 16, Aufg. 1 h)", minuten: 6,
  ergebnis: [$N = G_1 - G_2 sin alpha$; $F_("max") = mu_0 G_1 + G_2 (cos alpha - mu_0 sin alpha)$],
)[
#if not web [*Aufgabe 137* #linebreak()]
Ein Klotz $G_1$ liegt auf rauer Unterlage (Haftzahl $mu_0$) und ist über ein Seil unter dem Winkel $alpha$ und eine Rolle mit dem Gewicht $G_2$ verbunden; nach links zieht $F$. Schneide den Klotz frei, stelle die nötigen Gleichgewichte auf und bestimme die größte zulässige Kraft $F$.
#align(center)[#image(abbildungen.at("ak_ss16_klotz"), width: 60%)]

*Gegeben und Annahmen*

Das Seil zieht am Klotz mit $G_2$ unter $alpha$ nach rechts oben. $F$ zieht waagerecht nach links.

*Gesucht*

#enum(numbering: "a)",
[Freischnitt und Gleichgewichte.],
[$F_("max")$.],
)
][
*Senkrecht:* $N + G_2 sin alpha - G_1 = 0$, also $N = G_1 - G_2 sin alpha$.
][
*Waagerecht im Grenzfall:* Der Klotz will nach links rutschen, die Haftkraft $H_0 = mu_0 N$ zeigt nach rechts: $-F + G_2 cos alpha + mu_0 N = 0$.
][
*Ergebnis:* $F_("max") = mu_0 G_1 + G_2 (cos alpha - mu_0 sin alpha)$. Ein Momentengleichgewicht ist nicht nötig, solange der Klotz nicht kippt.
]

#aufgabe(titel: "Klotz mit Seil über eine Rolle (Variante)", art: "rechnen", quelle: "9.2", herkunft: "variante", vorlage: "Altklausur SS 16, Aufg. 1 h)", minuten: 5,
  ergebnis: [$N = 160 "N"$, $F_("max") approx "133,3" "N"$],
)[
#if not web [*Aufgabe 138* #linebreak()]
*Gegeben und Annahmen*

Anordnung wie in Altklausur SS 2016, Aufg. 1 h), mit $G_1 = 200 "N"$, $G_2 = 80 "N"$, $alpha = 30°$, $mu_0 = "0,4"$.

*Gesucht*

#enum(numbering: "a)",
[$N$ und $F_("max")$.],
)
][
*Normalkraft:* $N = 200 - 80 dot "0,5" = 160 "N"$.
][
*Grenzkraft:* $F_("max") = 80 cos 30° + "0,4" dot 160 = "69,3" + 64 = "133,3" "N"$.
]

#aufgabe(titel: "Haftet der Klotz noch?", art: "rechnen", quelle: "9.2", herkunft: "eigen", minuten: 5,
  ergebnis: [Bei 20 N haftet er ($H = 20 thin "N" <= 30 thin "N"$), bei 35 N nicht],
  tipp: [Erst die nötige Haftkraft aus dem Gleichgewicht, dann mit der Grenze $mu_0 N$ vergleichen.],
)[
#if not web [*Aufgabe 139* #linebreak()]
*Eigene Zahlen zum Modell der älteren Klausur:*

*Gegeben und Annahmen*

Ein Klotz wiegt 100 N auf horizontalem Boden, $mu_0="0,3"$. Ein waagerechter Seilzug beträgt zunächst 20 N, dann 35 N.

*Gesucht*

#enum(numbering: "a)",
[Ist Haften möglich?],
)
][
*Bild:* Die Haftkraft ist keine feste Zahl. Sie ist so groß, wie sie sein muss, um den Klotz festzuhalten, aber höchstens $mu_0 N$. Erst wenn mehr nötig wäre, rutscht der Klotz.
][
*Normalkraft:* Senkrecht wirken nur Gewicht und Boden, also $N = 100 thin "N"$. Die Grenze ist $H_("max") = mu_0 N = "0,3" dot 100 = 30 thin "N"$.
][
*Zug 20 N:* Gleichgewicht waagerecht verlangt $H = 20 thin "N"$. Wegen $20 <= 30$ ist Haften möglich, und die Haftkraft beträgt genau 20 N, nicht 30 N.
][
*Zug 35 N:* Nötig wären $H = 35 thin "N" > 30 thin "N"$. Die Haftung reicht nicht, der Klotz gleitet. Ab dann gilt ein eigenes Modell mit Gleitreibung.
][
*Die Falle:* $H = mu_0 N$ ist nur der Grenzfall. Wer immer 30 N einsetzt, erhält bei 20 N Zug ein falsches Kräftegleichgewicht.
]

#kapitel("TM2 Kapitel 1 · Zug, Druck und Wärmedehnung")

#aufgabe(titel: "Was beschreiben Spannung und Dehnung?", art: "verstehen", quelle: "TM2 1.1", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 140* #linebreak()]
Was beschreiben Spannung und Dehnung?
][
*Antwort:*
- Die Spannung $sigma = N\/A$ ist die Kraft pro Fläche im Material.
- Die Dehnung $epsilon$ ist die relative Längenänderung $Delta l\/l$.
- Beide machen Bauteile unterschiedlicher Größe vergleichbar.
#align(center)[#image(abbildungen.at("ak_stab_ax"), width: 60%)]
][
*Merksatz:* Spannung zählt Kraft je Fläche, Dehnung Änderung je Länge.
]

#aufgabe(titel: "Woraus setzt sich die Dehnung bei Last und Temperaturänderung zusammen?", art: "verstehen", quelle: "TM2 1.1", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 141* #linebreak()]
Woraus setzt sich die Dehnung bei Last und Temperaturänderung zusammen?
][
*Antwort:*
$ epsilon = sigma/E + alpha_T Delta T $
- Der erste Teil kommt aus der Kraft (Hooke), der zweite aus der Wärmedehnung.
- Beide addieren sich.
#align(center)[#image(abbildungen.at("ak_stab_ax"), width: 60%)]
]

#aufgabe(titel: "Zulässige Kraft für drei Stabquerschnitte", art: "rechnen", quelle: "TM2 1.1", herkunft: "original", vorlage: "TM2-Übung 1, Aufg. 1.1", minuten: 5,
  ergebnis: [a) $"31,4" "kN"$, b) $"23,6" "kN"$, c) $40 "kN"$],
)[
#if not web [*Aufgabe 142* #linebreak()]
Mit welcher Kraft dürfen die drei Stäbe belastet werden, wenn die Zugfestigkeit $100 "N/mm"^2$ beträgt?
#align(center)[#image(abbildungen.at("tm2k1_ue11"), width: 55%)]

*Gegeben und Annahmen*

a) Vollkreis $D = 20 "mm"$, b) Kreisring $D_a = 20 "mm"$, $D_i = 10 "mm"$, c) Quadrat mit Seite $20 "mm"$. Gleichmäßig verteilte Zugspannung $sigma = F\/A$.

*Gesucht*

#enum(numbering: "a)",
[Höchstzulässige Kraft für jeden Querschnitt.],
)
][
*Ansatz:* Aus $sigma = F\/A <= sigma_("zul")$ folgt $F_("max") = sigma_("zul") A$. Nur die tragende Fläche zählt.
][
*Flächen:* a) $A = pi 20^2\/4 = "314,2" "mm"^2$; b) $A = pi (20^2 - 10^2)\/4 = "235,6" "mm"^2$; c) $A = 400 "mm"^2$.
][
*Kräfte:* a) $"31,4" "kN"$, b) $"23,6" "kN"$, c) $40 "kN"$.
][
*Prüfen:* Das Loch im Ring nimmt ein Viertel der Kreisfläche weg, also tragt der Ring 75 % der Vollwelle.
]

#aufgabe(titel: "Zulässige Kraft für drei Querschnitte (Variante)", art: "rechnen", quelle: "TM2 1.1", herkunft: "variante", vorlage: "TM2-Übung 1, Aufg. 1.1", minuten: 4,
  ergebnis: [a) $"54,3" "kN"$, b) $"35,8" "kN"$, c) $"38,9" "kN"$],
)[
#if not web [*Aufgabe 143* #linebreak()]
*Gegeben und Annahmen*

$sigma_("zul") = 120 "N/mm"^2$. a) Vollkreis $D = 24 "mm"$, b) Ring $D_a = 24 "mm"$, $D_i = 14 "mm"$, c) Quadrat $18 times 18 "mm"$.

*Gesucht*

#enum(numbering: "a)",
[Zulässige Zugkraft für jeden Querschnitt.],
)
][
*Flächen:* a) $"452,4" "mm"^2$, b) $pi (576 - 196)\/4 = "298,5" "mm"^2$, c) $324 "mm"^2$.
][
*Kräfte:* $F = 120 A$: a) $"54,3" "kN"$, b) $"35,8" "kN"$, c) $"38,9" "kN"$.
]

#aufgabe(titel: "Mast unter Eigengewicht", art: "rechnen", quelle: "TM2 1.1", herkunft: "original", vorlage: "TM2-Übung 1, Aufg. 1.2", minuten: 5,
  ergebnis: [$sigma(x) = -rho g (L - x)$; am Boden $-"0,245" "N/mm"^2$],
  tipp: [Schneide bei $x$ und betrachte das Stück darüber. Es drückt mit seinem Gewicht auf den Schnitt.],
)[
#if not web [*Aufgabe 144* #linebreak()]
Ein senkrechter Mast (Kreiszylinder) steht unter Eigengewicht. Geben Sie $sigma(x)$ an.
#align(center)[#image(abbildungen.at("tm2k1_ue12"), width: 15%)]

*Gegeben und Annahmen*

$rho = "2,5" "kg/dm"^3$, $D = 30 "cm"$, $L = 10 "m"$, $x$ vom Boden nach oben, $g = "9,81" "m/s"^2$.

*Gesucht*

#enum(numbering: "a)",
[$sigma(x)$ und den größten Betrag.],
)
][
*Schnitt bei $x$:* Oberhalb liegt das Stück der Länge $L - x$ mit dem Gewicht $rho g A (L - x)$. Es drückt, also $N = -rho g A (L - x)$.
][
*Spannung:* $sigma = N\/A = -rho g (L - x)$. Die Fläche kürzt sich heraus, $D$ wird gar nicht gebraucht.
][
*Zahlen:* $rho g = 2500 dot "9,81" = 24525 "N/m"^3 = "2,45" dot 10^(-5) "N/mm"^3$. Am Boden: $sigma = -"2,45" dot 10^(-5) dot 10000 = -"0,245" "N/mm"^2$.
]

#aufgabe(titel: "Stahlmast unter Eigengewicht (Variante)", art: "rechnen", quelle: "TM2 1.1", herkunft: "variante", vorlage: "TM2-Übung 1, Aufg. 1.2", minuten: 4,
  ergebnis: [$sigma(0) = -"0,616" "N/mm"^2$, $sigma(4 "m") = -"0,308" "N/mm"^2$],
)[
#if not web [*Aufgabe 145* #linebreak()]
*Gegeben und Annahmen*

Zylindrischer Stahlmast, $rho = "7,85" "kg/dm"^3$, $L = 8 "m"$, $x$ vom Boden nach oben.

*Gesucht*

#enum(numbering: "a)",
[$sigma$ am Boden und bei $x = 4 "m"$.],
)
][
*Formel:* $sigma = -rho g (L - x)$ mit $rho g = 77009 "N/m"^3 = "7,70" dot 10^(-5) "N/mm"^3$.
][
*Werte:* Boden: $-"7,70" dot 10^(-5) dot 8000 = -"0,616" "N/mm"^2$; Mitte: die Hälfte, $-"0,308" "N/mm"^2$.
]

#aufgabe(titel: "Maschinenteil mit veränderlicher Breite", art: "rechnen", quelle: "TM2 1.1", herkunft: "original", vorlage: "TM2-Übung 1, Aufg. 1.3", minuten: 12,
  ergebnis: [$sigma(x) = -F\/(a d (1 + x\/h)) - gamma (x + x^2\/(2h))\/(1 + x\/h)$; bei $x = 4 "m"$: a) $-"0,231"$, b) $-"1,875"$, c) $-"2,106" "N/mm"^2$],
)[
#if not web [*Aufgabe 146* #linebreak()]
Ein Maschinenteil wird durch Eigengewicht und die Kraft $F$ belastet. Bestimmen Sie $sigma(x)$ und die Werte bei $x = 4000 "mm"$ für a) nur Eigengewicht, b) nur $F$, c) beides.
#align(center)[#image(abbildungen.at("tm2k1_ue13"), width: 40%)]

*Gegeben und Annahmen*

Breite $b(x) = a (1 + x\/h)$ von $a$ oben auf $2a$ unten, Dicke $d$, $x$ von oben nach unten. $F = 150 "kN"$, $gamma = "0,077" "N/cm"^3$, $a = 250 "mm"$, $h = 4000 "mm"$, $d = 160 "mm"$.

*Gesucht*

#enum(numbering: "a)",
[$sigma(x)$ allgemein.],
[Werte bei $x = h$ für die drei Fälle.],
)
][
*Fläche:* $A(x) = a d (1 + x\/h)$.
][
*Gewicht über dem Schnitt:* $G(x) = gamma integral_0^x A dif xi = gamma a d (x + x^2\/(2h))$. Normalkraft $N = -F - G(x)$ (Druck).
][
*Spannung:* $sigma = N\/A = -F\/(a d (1 + x\/h)) - gamma (x + x^2\/(2h))\/(1 + x\/h)$.
][
*Werte bei $x = h$:* $gamma = "7,7" dot 10^(-5) "N/mm"^3$. a) $-gamma dot "1,5" h\/2 = -"0,231"$; b) $-150000\/(2 dot 250 dot 160) = -"1,875"$; c) Summe $-"2,106" "N/mm"^2$.
][
*Prüfen:* Das Eigengewicht spielt hier kaum eine Rolle (gut 10 %). Die Kraftspannung nimmt nach unten ab, weil die Fläche wächst.
]

#aufgabe(titel: "Maschinenteil mit veränderlicher Breite (Variante)", art: "rechnen", quelle: "TM2 1.1", herkunft: "variante", vorlage: "TM2-Übung 1, Aufg. 1.3", minuten: 8,
  ergebnis: [bei $x = h$: Eigengewicht $-"0,173"$, Kraft $-"2,083"$, zusammen $-"2,257" "N/mm"^2$],
)[
#if not web [*Aufgabe 147* #linebreak()]
*Gegeben und Annahmen*

Teil wie in Übung 1.3 mit $F = 100 "kN"$, $a = 200 "mm"$, $h = 3000 "mm"$, $d = 120 "mm"$, $gamma = "0,077" "N/cm"^3$.

*Gesucht*

#enum(numbering: "a)",
[$sigma$ am Fuß ($x = h$) aus Eigengewicht, aus $F$ und gesamt.],
)
][
*Eigengewicht:* $-gamma (h + h\/2)\/2 = -"7,7" dot 10^(-5) dot 2250 = -"0,173" "N/mm"^2$.
][
*Kraft:* $-100000\/(2 dot 200 dot 120) = -"2,083" "N/mm"^2$.
][
*Summe:* $-"2,257" "N/mm"^2$.
]

#aufgabe(titel: "Wärmedehnung ohne Spannung", art: "verstehen", quelle: "TM2 1.4", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 148* #linebreak()]
Kann ein erwärmter Stab länger werden, obwohl seine Spannung null ist?
][
Ja: freie Wärmeausdehnung $Delta l=alpha_T Delta T l$. Ohne Behinderung entsteht keine mechanische Spannung.
]

#aufgabe(titel: "Was ist der Unterschied zwischen Dehnung und Verschiebung?", art: "verstehen", quelle: "TM2 1.4", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 149* #linebreak()]
Was ist der Unterschied zwischen Dehnung und Verschiebung?
][
*Antwort:*
- Die Dehnung ist lokal, also wie stark ein kleines Stück gestreckt wird.
- Die Verschiebung ist, wie weit sich ein Punkt bewegt.
- Sie ergibt sich durch Aufsummieren (Integrieren) der Dehnungen über die Länge.
]

#aufgabe(titel: "Längenänderung eines gezogenen Stabs", art: "verstehen", quelle: "TM2 1.4", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 150* #linebreak()]
Ein Stab hat $l = 1000$ mm, $A = 100$ mm², $E = 200.000$ N/mm² und wird mit $N = 20$ kN gezogen. Wie groß ist die Längenänderung?
][
*Antwort:* 1 mm. $Delta l = N l \/ (E A) = 20000 dot 1000 \/ (200000 dot 100) = 1$ mm.
][
*Typische Verwechslung:* 0,01 mm: Hier fehlt ein Faktor 100. Prüfe, ob die Kraft in N umgerechnet ist.
]

#aufgabe(titel: "Stab mit veränderlichem Querschnitt", art: "rechnen", quelle: "TM2 1.4", herkunft: "original", vorlage: "Altklausur SS 16, Aufg. 2 (PrüfungenTM2 S. 12)", minuten: 8,
  ergebnis: [$sigma(x) = -F(l+x)\/(2l A_0)$, $Delta l = -3F l\/(4E A_0)$],
  tipp: [Die Normalkraft ist überall gleich, nur die Fläche ändert sich. Die Längenänderung ist das Integral der Dehnung.],
)[
#if not web [*Aufgabe 151* #linebreak()]
*Ältere Klausur, PrüfungenTM2 S. 12:*

*Gegeben und Annahmen*

$A(x)=2l A_0/(l+x)$, konstantes E, Druckkraft F am Ende.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $sigma(x)$ und $Delta l$ ohne Temperaturänderung.],
)
][
*Bild:* Bei $x = 0$ ist $A = 2A_0$, bei $x = l$ nur noch $A_0$. Die gleiche Kraft läuft durch einen immer dünneren Stab, die Spannung nimmt also zum Ende hin zu.
][
*Normalkraft:* Ohne Streckenlast ist N überall gleich. Druck heißt $N = -F$.
][
*Spannung:* $sigma(x) = N\/A(x) = -F(l+x)\/(2l A_0)$. Bei $x=0$ ist $sigma = -F\/(2A_0)$, bei $x=l$ ist $sigma = -F\/A_0$.
][
*Längenänderung:* Jedes Stückchen $d x$ dehnt sich um $epsilon thin d x = sigma\/E thin d x$. Also
$ Delta l = integral_0^l (-F(l+x))\/(2l E A_0) thin d x = -F\/(2l E A_0) dot (l^2 + l^2\/2) = -(3F l)\/(4E A_0). $
][
*Prüfen:* Druck gibt eine Verkürzung, also negativ. Zum Vergleich: ein Stab mit überall $A_0$ verkürzte sich um $F l\/(E A_0)$, einer mit $2A_0$ um die Hälfte. $3\/4$ liegt dazwischen. Die Einheit $N l\/(E A)$ ist eine Länge.
]

#aufgabe(titel: "Stab mit veränderlichem Querschnitt (Variante)", art: "rechnen", quelle: "TM2 1.4", herkunft: "variante", vorlage: "Altklausur SS 16, Aufg. 2 (PrüfungenTM2 S. 12)", minuten: 6,
  ergebnis: [$sigma(x) = -F (l + 2x)\/(3 l A_0)$, $Delta l = -2 F l\/(3 E A_0)$; Gefahr: Knicken],
)[
#if not web [*Aufgabe 152* #linebreak()]
*Gegeben und Annahmen*

Stab der Länge $l$, links eingespannt, rechts Druckkraft $F$, Querschnitt $A(x) = 3 l A_0\/(l + 2x)$ (links $3 A_0$, rechts $A_0$), konstantes $E$.

*Gesucht*

#enum(numbering: "a)",
[$sigma(x)$, $Delta l$ und die weitere Gefahr außer zu hoher Spannung.],
)
][
*Spannung:* $N = -F$ überall, $sigma = -F (l + 2x)\/(3 l A_0)$, am rechten Ende $-F\/A_0$.
][
*Längenänderung:* $Delta l = integral_0^l sigma\/E dif x = -F\/(3 l E A_0) [l x + x^2]_0^l = -2 F l\/(3 E A_0)$.
][
*Gefahr:* Ein schlanker Druckstab kann ausknicken, bevor die Spannung kritisch wird.
]

#aufgabe(titel: "Förderseil im Schacht", art: "rechnen", quelle: "TM2 1.4", herkunft: "original", vorlage: "TM2-Übung 2, Aufg. 2.1", minuten: 15,
  ergebnis: [$A_("erf") = "987,1" "mm"^2$, $u(l) = "852,8" "mm"$, Reißlänge $"20,78" "km"$ (Bruch oben)],
  tipp: [Die Normalkraft ist oben am größten: Last plus ganzes Seilgewicht.],
)[
#if not web [*Aufgabe 153* #linebreak()]
Ein Stahlförderseil der Länge $l = 1150 "m"$ trägt am Ende die Last $F = 110 "kN"$. 1) Welcher Querschnitt ist für $sigma_("zul") = 200 "N/mm"^2$ nötig? 2) Wie weit verschiebt sich das Seilende? 3) Wie lang darf das Seil ohne Last höchstens sein ($R_m = 1600 "N/mm"^2$), und wo reißt es?
#align(center)[#image(abbildungen.at("tm2k1_ue21"), width: 30%)]

*Gegeben und Annahmen*

$rho = 7850 "kg/m"^3$, $E = "2,1" dot 10^5 "N/mm"^2$, $g = "9,81" "m/s"^2$. $x$ vom Seilende nach oben.

*Gesucht*

#enum(numbering: "a)",
[$A_("erf")$.],
[Verschiebung $u$ des Seilendes.],
[Reißlänge und Bruchstelle.],
)
][
*Normalkraft:* $N(x) = F + rho g A x$, größter Wert oben: $sigma_("max") = F\/A + rho g l$.
][
*Querschnitt:* $rho g l = "7,70" dot 10^(-5) dot 1150000 = "88,6" "N/mm"^2$. $A = F\/(sigma_("zul") - rho g l) = 110000\/"111,4" = "987,1" "mm"^2$.
][
*Verschiebung:* $u = integral_0^l N\/(E A) dif x = F l\/(E A) + rho g l^2\/(2 E) = "610,3" + "242,5" = "852,8" "mm"$.
][
*Reißlänge:* Ohne Last ist $sigma_("max") = rho g l$. $l_("Reiß") = R_m\/(rho g) = 1600\/"7,70" dot 10^(-5) "mm" = "20,78" "km"$. Das Seil reißt oben an der Aufhängung, weil dort das ganze Gewicht hängt.
]

#aufgabe(titel: "Förderseil im Schacht (Variante)", art: "rechnen", quelle: "TM2 1.4", herkunft: "variante", vorlage: "TM2-Übung 2, Aufg. 2.1", minuten: 12,
  ergebnis: [$A_("erf") approx "722,7" "mm"^2$, $u approx "622,9" "mm"$, Reißlänge $approx "19,5" "km"$],
)[
#if not web [*Aufgabe 154* #linebreak()]
*Gegeben und Annahmen*

Seil wie in Übung 2.1, aber $l = 900 "m"$, $F = 80 "kN"$, $sigma_("zul") = 180 "N/mm"^2$, $R_m = 1500 "N/mm"^2$.

*Gesucht*

#enum(numbering: "a)",
[$A_("erf")$, $u(l)$, Reißlänge.],
)
][
*Querschnitt:* $rho g l = "69,3" "N/mm"^2$; $A = 80000\/(180 - "69,3") = "722,7" "mm"^2$.
][
*Verschiebung:* $u = 80000 dot 900000\/("2,1" dot 10^5 dot "722,7") + "7,70" dot 10^(-5) dot 900000^2\/(2 dot "2,1" dot 10^5) = "474,4" + "148,5" = "622,9" "mm"$.
][
*Reißlänge:* $1500\/"7,70" dot 10^(-5) "mm" = "19,5" "km"$.
]

#aufgabe(titel: "Verschiebung im Maschinenteil mit Wärme", art: "rechnen", quelle: "TM2 1.4", herkunft: "original", vorlage: "TM2-Übung 2, Aufg. 2.2", minuten: 12,
  ergebnis: [$Delta l = -F h ln 2\/(E a d) = -"0,0495" "mm"$; mit $Delta T = 50 °C$: $Delta l = +"2,3505" "mm"$],
  tipp: [$integral dif x\/(1 + x\/h) = h ln(1 + x\/h)$.],
)[
#if not web [*Aufgabe 155* #linebreak()]
Maschinenteil aus Übung 1.3, jetzt ohne Eigengewicht. 1) Bestimmen Sie $u(x)$ und $Delta l$ infolge $F$. 2) Zusätzlich wird das Teil um $50 °C$ erwärmt ($alpha_T = "1,2" dot 10^(-5) "1/K"$).

*Gegeben und Annahmen*

$F = 150 "kN"$, $a = 250 "mm"$, $h = 4000 "mm"$, $d = 160 "mm"$, $E = "2,1" dot 10^5 "N/mm"^2$, $A(x) = a d (1 + x\/h)$, unten fest aufgelagert.

*Gesucht*

#enum(numbering: "a)",
[Längenänderung infolge $F$.],
[Längenänderung mit Erwärmung.],
)
][
*Dehnung:* $epsilon(x) = N\/(E A) = -F\/(E a d (1 + x\/h))$.
][
*Integrieren:* $Delta l = integral_0^h epsilon dif x = -F h\/(E a d) ln 2 = -150000 dot 4000 dot "0,693"\/("2,1" dot 10^5 dot 40000) = -"0,0495" "mm"$.
][
*Wärme:* Freie Wärmedehnung $alpha_T Delta T h = "1,2" dot 10^(-5) dot 50 dot 4000 = "2,4" "mm"$. Weil das Teil oben frei ist, überlagern sich beide: $Delta l = -"0,0495" + "2,4" = "2,3505" "mm"$.
]

#aufgabe(titel: "Verschiebung im Maschinenteil mit Wärme (Variante)", art: "rechnen", quelle: "TM2 1.4", herkunft: "variante", vorlage: "TM2-Übung 2, Aufg. 2.2", minuten: 8,
  ergebnis: [$Delta l_F = -"0,0413" "mm"$; mit $40 °C$: $Delta l = "1,3987" "mm"$],
)[
#if not web [*Aufgabe 156* #linebreak()]
*Gegeben und Annahmen*

Teil wie in Übung 2.2 mit $F = 100 "kN"$, $a = 200 "mm"$, $h = 3000 "mm"$, $d = 120 "mm"$, Erwärmung um $40 °C$.

*Gesucht*

#enum(numbering: "a)",
[$Delta l$ aus $F$ und gesamt.],
)
][
*Kraft:* $Delta l_F = -100000 dot 3000 ln 2\/("2,1" dot 10^5 dot 24000) = -"0,0413" "mm"$.
][
*Wärme:* $"1,2" dot 10^(-5) dot 40 dot 3000 = "1,44" "mm"$; zusammen $"1,3987" "mm"$.
]

#aufgabe(titel: "Probestab mit blockierter Prüfmaschine", art: "rechnen", quelle: "TM2 1.4", herkunft: "original", vorlage: "TM2-Übung 2, Aufg. 2.3", minuten: 12,
  ergebnis: [$F = "117,8" "kN"$; $Delta l = "0,303" "mm"$; nach Erwärmung $Delta l_("ges") = "0,303" "mm"$, $epsilon_("ges") = "3,03" dot 10^(-3)$, $sigma_("ges") approx 384 "N/mm"^2$],
  tipp: [Ist die Maschine blockiert, bleibt die Länge fest. Die Wärmedehnung muss dann durch eine kleinere elastische Dehnung ausgeglichen werden.],
)[
#if not web [*Aufgabe 157* #linebreak()]
Ein Probestab wird geprüft. 1) Welche Prüfkraft braucht die Maschine, wenn der Stab bis $1000 "N/mm"^2$ belastet werden soll (50 % Zuschlag)? 2) Längenänderung bei $F = 50 "kN"$? 3) Die Maschine blockiert bei 50 kN, der Stab wird um $100 °C$ erwärmt: $Delta l_("ges")$, $epsilon_("ges")$, $sigma_("ges")$?
#align(center)[#image(abbildungen.at("tm2k1_ue23"), width: 40%)]

*Gegeben und Annahmen*

$L = 100 "mm"$, $d = 10 "mm"$, $E = "2,1" dot 10^5 "N/mm"^2$, $alpha_T = "1,2" dot 10^(-5) "1/K"$.

*Gesucht*

#enum(numbering: "a)",
[Prüfkraft.],
[$Delta l$ bei 50 kN.],
[Größen nach der Erwärmung.],
)
][
*Prüfkraft:* $A = "78,54" "mm"^2$, $F = "1,5" dot 1000 dot "78,54" = "117,8" "kN"$.
][
*Längenänderung:* $Delta l = F L\/(E A) = 50000 dot 100\/("2,1" dot 10^5 dot "78,54") = "0,303" "mm"$.
][
*Blockiert:* Die Länge bleibt, also $Delta l_("ges") = "0,303" "mm"$ und $epsilon_("ges") = "3,03" dot 10^(-3)$.
][
*Spannung:* $epsilon_("ges") = sigma\/E + alpha_T Delta T$, also $sigma = E (epsilon_("ges") - alpha_T Delta T) = "636,6" - 252 approx 384 "N/mm"^2$. Die Erwärmung baut einen Teil der Zugspannung ab.
]

#aufgabe(titel: "Probestab mit blockierter Prüfmaschine (Variante)", art: "rechnen", quelle: "TM2 1.4", herkunft: "variante", vorlage: "TM2-Übung 2, Aufg. 2.3", minuten: 10,
  ergebnis: [$F = "60,3" "kN"$; $Delta l = "0,227" "mm"$; nach Erwärmung $epsilon = "2,84" dot 10^(-3)$, $sigma approx 395 "N/mm"^2$],
)[
#if not web [*Aufgabe 158* #linebreak()]
*Gegeben und Annahmen*

Probestab $L = 80 "mm"$, $d = 8 "mm"$; Prüfspannung $800 "N/mm"^2$ mit 50 % Zuschlag; Blockade bei $F = 30 "kN"$, dann Erwärmung um $80 °C$. Stahl wie in Übung 2.3.

*Gesucht*

#enum(numbering: "a)",
[Prüfkraft, $Delta l$ bei 30 kN, Dehnung und Spannung nach der Erwärmung.],
)
][
*Prüfkraft:* $A = "50,27" "mm"^2$, $F = "1,5" dot 800 dot "50,27" = "60,3" "kN"$.
][
*Längenänderung:* $Delta l = 30000 dot 80\/("2,1" dot 10^5 dot "50,27") = "0,227" "mm"$, $epsilon = "2,84" dot 10^(-3)$.
][
*Spannung:* $sigma = 30000\/"50,27" - "2,1" dot 10^5 dot "1,2" dot 10^(-5) dot 80 = "596,8" - "201,6" approx 395 "N/mm"^2$.
]

#aufgabe(titel: "Starrer Balken auf drei Stäben", art: "rechnen", quelle: "TM2 1.4", herkunft: "original", vorlage: "TM2-Übung 4, Aufg. 4.2", minuten: 12,
  ergebnis: [$S_1 = S_2 = -G\/(4 cos alpha)$, $S_3 = -G\/2$; $beta approx G l\/(a E A) dot (2 cos^3 alpha - 1)\/(4 cos^3 alpha)$],
  tipp: [Erst die Stabkräfte (statisch bestimmt), dann die Absenkung jedes Auflagerpunkts, zuletzt der Winkel aus dem Unterschied.],
)[
#if not web [*Aufgabe 159* #linebreak()]
Ein starrer Balken (Gewicht $G$) wird auf 3 gewichtslosen, elastischen Stäben gleicher Dehnsteifigkeit $E A$ gelagert. Der Winkel zwischen Stab 1 und 2 beträgt $2 alpha$, die Länge von Stab 3 ist $l$. Welchen Neigungswinkel $beta$ hat der Balken nach der Montage?
#align(center)[#image(abbildungen.at("tm2k1_ue42"), width: 40%)]

*Gegeben und Annahmen*

Balken der Länge $3a$, Schwerpunkt in der Mitte. Die Stäbe 1 und 2 treffen sich unter dem Balken bei $x = a$, Stab 3 (senkrecht) greift bei $x = 2a$ an. Stab 1 und 2 sind um $alpha$ gegen die Senkrechte geneigt, ihre Höhe ist $l$.

*Gesucht*

#enum(numbering: "a)",
[Stabkräfte.],
[Neigungswinkel $beta$.],
)
][
*Auflagerkräfte:* $G$ greift bei $"1,5" a$ an, genau zwischen den beiden Auflagerpunkten: Jeder trägt $G\/2$.
][
*Stabkräfte:* Am Punkt bei $a$ teilen sich die Stäbe 1 und 2 symmetrisch: $2 S cos alpha = -G\/2$, $S_1 = S_2 = -G\/(4 cos alpha)$. Stab 3: $S_3 = -G\/2$.
][
*Absenkungen:* Stab 1 (Länge $l\/cos alpha$) wird um $G l\/(4 E A cos^2 alpha)$ kürzer; bei symmetrischem V senkt sich der Knoten um $w_A = Delta l_1\/cos alpha = G l\/(4 E A cos^3 alpha)$. Stab 3: $w_B = G l\/(2 E A)$.
][
*Winkel:* $beta approx (w_B - w_A)\/a = G l\/(a E A) dot (2 cos^3 alpha - 1)\/(4 cos^3 alpha)$. Für $cos^3 alpha > 1\/2$ senkt sich die Seite bei Stab 3 stärker.
]

#aufgabe(titel: "Starrer Balken auf drei Stäben (Variante)", art: "rechnen", quelle: "TM2 1.4", herkunft: "variante", vorlage: "TM2-Übung 4, Aufg. 4.2", minuten: 10,
  ergebnis: [$alpha = "26,57"°$, $w_A approx "0,333" "mm"$, $w_B approx "0,476" "mm"$, $beta approx "1,43" dot 10^(-4) "rad" approx "0,0082"°$],
)[
#if not web [*Aufgabe 160* #linebreak()]
*Gegeben und Annahmen*

Anordnung wie in Übung 4.2 mit $G = 20 "kN"$, $l = 2 "m"$, $a = 1 "m"$ (damit $tan alpha = a\/l = "0,5"$), Stahlstäbe mit $A = 200 "mm"^2$, $E = "2,1" dot 10^5 "N/mm"^2$.

*Gesucht*

#enum(numbering: "a)",
[$w_A$, $w_B$, $beta$.],
)
][
*Winkel:* $alpha = arctan "0,5" = "26,57"°$, $cos^3 alpha = "0,7155"$. $E A = 42 dot 10^6 "N"$.
][
*Absenkungen:* $w_A = 20000 dot 2000\/(4 dot 42 dot 10^6 dot "0,7155") = "0,333" "mm"$, $w_B = 20000 dot 2000\/(2 dot 42 dot 10^6) = "0,476" "mm"$.
][
*Neigung:* $beta = ("0,476" - "0,333")\/1000 = "1,43" dot 10^(-4) "rad" = "0,0082"°$.
]

#aufgabe(titel: "Die fehlende Verträglichkeitsbedingung", art: "verstehen", quelle: "TM2 1.6", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 161* #linebreak()]
Welche Gleichung fehlt bei einem statisch unbestimmten Stabsystem zusätzlich zum Gleichgewicht?
][
Eine geometrische Verträglichkeitsbedingung, z. B. vorgegebene Gesamtlängenänderung oder gleiche Verschiebung an einer Verbindung.
]

#aufgabe(titel: "Wie löst man ein statisch unbestimmtes Stabproblem?", art: "verstehen", quelle: "TM2 1.6", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 162* #linebreak()]
Wie löst man ein statisch unbestimmtes Stabproblem?
][
*Antwort:*
- Gleichgewicht aufstellen.
- Elastizitätsgesetz für jeden Stab (mit Temperaturanteil).
- Verträglichkeitsbedingung aus der Geometrie formulieren.
- Alles zusammen nach den Unbekannten auflösen.
]

#aufgabe(titel: "Was ist Knicken?", art: "verstehen", quelle: "TM2 1.6", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 163* #linebreak()]
Was ist Knicken?
][
*Antwort:*
- Ein schlanker Druckstab weicht ab einer kritischen Last seitlich aus, obwohl die Spannung noch weit unter der Festigkeit liegt.
- Es ist ein Stabilitätsversagen, kein Festigkeitsversagen.
- Deshalb prüft man schlanke Druckstäbe zusätzlich auf Knicken.
][
*Merksatz:* Knicken ist Ausweichen, nicht Materialbruch.
]

#aufgabe(titel: "Abgesetzter Zylinder zwischen zwei Wänden", art: "rechnen", quelle: "TM2 1.6", herkunft: "original", vorlage: "TM2-Übung 3, Aufg. 3.1", minuten: 12,
  ergebnis: [$F_A = F_B = "61,4" "kN"$ (Druck), $u_C = -"0,0394" "mm"$],
  tipp: [Verträglichkeit: Die Gesamtlänge bleibt gleich, also $Delta l_1 + Delta l_2 = 0$.],
)[
#if not web [*Aufgabe 164* #linebreak()]
Ein abgesetzter Stahlzylinder sitzt spielfrei zwischen den festen Lagern A und B und wird um 50 K erwärmt. Wie groß sind die Lagerkräfte, und wie verschiebt sich der Absatz C?
#align(center)[#image(abbildungen.at("tm2k1_ue31"), width: 45%)]

*Gegeben und Annahmen*

$A_1 = 400 "mm"^2$ ($l_1 = 300 "mm"$, links), $A_2 = 600 "mm"^2$ ($l_2 = 350 "mm"$, rechts), $E = "2,1" dot 10^5 "N/mm"^2$, $alpha_T = "1,2" dot 10^(-5) "1/K"$.

*Gesucht*

#enum(numbering: "a)",
[Normalkraft und Lagerkräfte.],
[Verschiebung von C.],
)
][
*Statik:* Ohne äußere Last ist $N$ in beiden Teilen gleich. Ein Gleichgewicht für zwei Lagerkräfte: einfach statisch unbestimmt.
][
*Verträglichkeit:* $Delta l_i = N l_i\/(E A_i) + alpha_T Delta T l_i$, Summe null: $N = -alpha_T Delta T (l_1 + l_2)\/(l_1\/(E A_1) + l_2\/(E A_2)) = -"0,39"\/("3,571" dot 10^(-6) + "2,778" dot 10^(-6)) = -"61,4" "kN"$.
][
*Verschiebung von C:* $u_C = Delta l_1 = -61425 dot 300\/(84 dot 10^6) + "0,18" = -"0,219" + "0,180" = -"0,0394" "mm"$, also nach links.
][
*Prüfen:* Der dünne Teil wird stärker gestaucht als er sich wärmt; der dicke Teil dehnt sich um den gleichen Betrag. C wandert zum dünnen Teil hin.
]

#aufgabe(titel: "Abgesetzter Zylinder zwischen zwei Wänden (Variante)", art: "rechnen", quelle: "TM2 1.6", herkunft: "variante", vorlage: "TM2-Übung 3, Aufg. 3.1", minuten: 10,
  ergebnis: [$N approx -"40,1" "kN"$, $u_C approx -"0,0392" "mm"$],
)[
#if not web [*Aufgabe 165* #linebreak()]
*Gegeben und Annahmen*

Zylinder wie in Übung 3.1 mit $A_1 = 300 "mm"^2$, $l_1 = 250 "mm"$, $A_2 = 500 "mm"^2$, $l_2 = 400 "mm"$, Erwärmung um 40 K.

*Gesucht*

#enum(numbering: "a)",
[Lagerkräfte und $u_C$.],
)
][
*Verträglichkeit:* $N = -"1,2" dot 10^(-5) dot 40 dot 650\/(250\/(63 dot 10^6) + 400\/(105 dot 10^6)) = -"0,312"\/("7,778" dot 10^(-6)) = -"40,1" "kN"$.
][
*Verschiebung:* $u_C = -40114 dot 250\/(63 dot 10^6) + "0,12" = -"0,159" + "0,120" = -"0,0392" "mm"$.
]

#aufgabe(titel: "Stahlbetonsäule mit und ohne Erwärmung", art: "rechnen", quelle: "TM2 1.6", herkunft: "original", vorlage: "TM2-Übung 3, Aufg. 3.2", minuten: 15,
  ergebnis: [$F_("St") = "45,1" "kN"$, $F_B = "454,9" "kN"$, $sigma_("St") = -"35,9"$, $sigma_B = -"5,13" "N/mm"^2$; mit Erwärmung $F_("St") = "69,1" "kN"$, $F_B = "430,9" "kN"$],
  tipp: [Stahl und Beton werden gleich stark gestaucht. Das ist die Verträglichkeitsbedingung.],
)[
#if not web [*Aufgabe 166* #linebreak()]
Eine Betonsäule $30 times 30 "cm"$ mit vier Rundstählen $d = 20 "mm"$ wird mit $F = 500 "kN"$ belastet. Wie teilt sich die Kraft auf, welche Spannungen entstehen? Dann wird die Säule zusätzlich um $50 °C$ erwärmt.
#align(center)[#image(abbildungen.at("tm2k1_ue32"), width: 35%)]

*Gegeben und Annahmen*

$E_("St") = 21 dot 10^6 "N/cm"^2$, $E_B = 3 dot 10^6 "N/cm"^2$, $alpha_("St") = "1,2" dot 10^(-5)$, $alpha_B = "1,0" dot 10^(-5) "1/K"$.

*Gesucht*

#enum(numbering: "a)",
[Kraftaufteilung und Spannungen.],
[Kraftaufteilung mit Erwärmung.],
)
][
*Flächen und Steifigkeiten:* $A_("St") = "12,57" "cm"^2$, $A_B = 900 - "12,57" = "887,4" "cm"^2$. $(E A)_("St") = "263,9" dot 10^6 "N"$, $(E A)_B = "2662,3" dot 10^6 "N"$.
][
*Ohne Wärme:* Gleiche Stauchung heißt Kraft im Verhältnis der Steifigkeiten: $F_("St") = F dot "263,9"\/"2926,2" = "45,1" "kN"$, $F_B = "454,9" "kN"$. Spannungen: $sigma_("St") = -"35,9"$, $sigma_B = -"5,13" "N/mm"^2$.
][
*Mit Wärme:* Stahl dehnt sich mehr und zieht Last an. $-F_("St")\/(E A)_("St") + alpha_("St") Delta T = -F_B\/(E A)_B + alpha_B Delta T$ mit $F_B = F - F_("St")$: $F_("St") (1\/(E A)_("St") + 1\/(E A)_B) = (alpha_("St") - alpha_B) Delta T + F\/(E A)_B = "2,878" dot 10^(-4)$, also $F_("St") = "69,1" "kN"$, $F_B = "430,9" "kN"$.
][
*Prüfen:* Der Stahl trägt bei 1,4 % der Fläche rund 9 % der Last, weil er siebenmal steifer ist.
]

#aufgabe(titel: "Stahlbetonsäule (Variante)", art: "rechnen", quelle: "TM2 1.6", herkunft: "variante", vorlage: "TM2-Übung 3, Aufg. 3.2", minuten: 12,
  ergebnis: [$F_("St") = "64,0" "kN"$, $F_B = "736,0" "kN"$, $sigma_("St") = -"32,6"$, $sigma_B = -"4,66" "N/mm"^2$; mit Erwärmung $F_("St") = "94,4" "kN"$, $F_B = "705,6" "kN"$],
)[
#if not web [*Aufgabe 167* #linebreak()]
*Gegeben und Annahmen*

Säule $40 times 40 "cm"$ mit vier Stählen $d = 25 "mm"$, $F = 800 "kN"$, danach Erwärmung um $40 °C$. Werkstoffwerte wie in Übung 3.2.

*Gesucht*

#enum(numbering: "a)",
[Kraftaufteilung und Spannungen, mit und ohne Erwärmung.],
)
][
*Steifigkeiten:* $A_("St") = "19,63" "cm"^2$, $A_B = "1580,4" "cm"^2$; $(E A)_("St") = "412,3" dot 10^6 "N"$, $(E A)_B = "4741,1" dot 10^6 "N"$.
][
*Ohne Wärme:* $F_("St") = 800 dot "412,3"\/"5153,4" = "64,0" "kN"$, $F_B = "736,0" "kN"$; $sigma_("St") = -"32,6"$, $sigma_B = -"4,66" "N/mm"^2$.
][
*Mit Wärme:* $F_("St") = ("0,2" dot 10^(-5) dot 40 + 800000\/(4741 dot 10^6))\/(1\/("412,3" dot 10^6) + 1\/(4741 dot 10^6)) = "94,4" "kN"$, $F_B = "705,6" "kN"$.
]

#aufgabe(titel: "Erwärmter Kegelstumpf zwischen Federn", art: "rechnen", quelle: "TM2 1.6", herkunft: "original", vorlage: "TM2-Übung 3, Aufg. 3.3", minuten: 12,
  ergebnis: [$Delta l = alpha_T Delta T l\/(1 + 4 c l\/(E pi d D))$ nach rechts],
  tipp: [Für einen linear konischen Stab gilt $integral_0^l dif x\/A(x) = 4l\/(pi d D)$.],
)[
#if not web [*Aufgabe 168* #linebreak()]
Ein konischer Stab (Durchmesser von $D$ an der Wand auf $d$ an der Platte, Länge $l$) ist parallel zu Federn (Gesamtsteifigkeit $c$) zwischen Wand und Platte eingebaut. Der Stab wird um $Delta T$ erwärmt. Wie verschiebt sich der rechte Querschnitt?
#align(center)[#image(abbildungen.at("tm2k1_ue33"), width: 40%)]

*Gegeben und Annahmen*

Stab: $E$, $alpha_T$. Die Platte ist nur über Stab und Federn gehalten; Federn spannungsfrei vor der Erwärmung.

*Gesucht*

#enum(numbering: "a)",
[Verschiebung $Delta l$ der Platte.],
)
][
*Gleichgewicht an der Platte:* Der Stab drückt mit $N$ (Druck), die Federn ziehen mit $c Delta l$ zurück: $-N = c Delta l$.
][
*Stabverlängerung:* $Delta l = N\/E integral dif x\/A + alpha_T Delta T l = 4 N l\/(E pi d D) + alpha_T Delta T l$.
][
*Einsetzen:* $Delta l = -4 c Delta l l\/(E pi d D) + alpha_T Delta T l$, also $Delta l = alpha_T Delta T l\/(1 + 4 c l\/(E pi d D))$.
][
*Prüfen:* Für $c -> 0$ dehnt sich der Stab frei; für $c -> infinity$ bleibt die Platte stehen.
]

#aufgabe(titel: "Erwärmter Kegelstumpf zwischen Federn (Variante)", art: "rechnen", quelle: "TM2 1.6", herkunft: "variante", vorlage: "TM2-Übung 3, Aufg. 3.3", minuten: 8,
  ergebnis: [$Delta l approx "0,558" "mm"$ (frei wären $"0,600" "mm"$)],
)[
#if not web [*Aufgabe 169* #linebreak()]
*Gegeben und Annahmen*

Anordnung wie in Übung 3.3: Stahl ($E = "2,1" dot 10^5 "N/mm"^2$, $alpha_T = "1,2" dot 10^(-5) "1/K"$), $D = 40 "mm"$, $d = 20 "mm"$, $l = 500 "mm"$, $c = 2 dot 10^4 "N/mm"$, $Delta T = 100 "K"$.

*Gesucht*

#enum(numbering: "a)",
[Verschiebung der Platte.],
)
][
*Kennzahl:* $4 c l\/(E pi d D) = 4 dot 2 dot 10^4 dot 500\/("2,1" dot 10^5 dot pi dot 800) = "0,0758"$.
][
*Ergebnis:* $Delta l = "1,2" dot 10^(-5) dot 100 dot 500\/"1,0758" = "0,558" "mm"$.
]

#aufgabe(titel: "Kolbenschraube mit Hülse verspannen", art: "rechnen", quelle: "TM2 1.6", herkunft: "original", vorlage: "TM2-Übung 4, Aufg. 4.1", minuten: 25,
  ergebnis: [a) $F_V = "38,98" "kN"$, $Delta l_1 = "0,236" "mm"$, $Delta l_2 = "0,097" "mm"$; b) Schraube $"41,89" "kN"$, Hülse $"31,89" "kN"$; c) $sigma_V = 450$, $sigma_B = 484$, $sigma_a = plus.minus "16,8" "N/mm"^2$, zulässig; d) $F_V = "41,09" "kN"$],
  tipp: [Schraube und Hülse sind hintereinander verspannt: Die Mutterdrehung $n h$ teilt sich in Verlängerung der Schraube und Stauchung der Hülse.],
)[
#if not web [*Aufgabe 170* #linebreak()]
Ein Kolben besteht aus Stahl-Oberteil und Aluminium-Unterteil, verbunden durch 4 Stiftschrauben. a) Die Muttern werden angelegt und um 120° angezogen: Vorspannkraft $F_V$, $Delta l_1$, $Delta l_2$. b) Betriebskraft 10 kN je Schraube (Angriff an den Auflagen): Kraft in der Schraube. c) Spannung im Kernquerschnitt ($d_k = "10,5" "mm"$); zulässig sind 640 N/mm² statisch und $plus.minus 40 "N/mm"^2$ als Wechselanteil. d) Das Al-Unterteil wird 80 °C, die Schrauben 120 °C warm (Montage bei 20 °C): neue Vorspannkraft?
#align(center)[#image(abbildungen.at("tm2k1_ue41"), width: 50%)]

*Gegeben und Annahmen*

Gewinde M12×1 ($h = 1 "mm"$), Dehnschaft $d_s = 10 "mm"$, $l = 100 "mm"$, Stahl $E_1 = "2,1" dot 10^5 "N/mm"^2$, $alpha_1 = "1,2" dot 10^(-5) "1/K"$. Hülse (Al) $d_i = 13$, $d_a = 30 "mm"$, Länge $l$, $E_2 = "0,7" dot 10^5 "N/mm"^2$, $alpha_2 = "2,3" dot 10^(-5) "1/K"$.

*Gesucht*

#enum(numbering: "a)",
[$F_V$, $Delta l_1$, $Delta l_2$.],
[Schraubenkraft unter Betriebslast.],
[Spannungen und Zulässigkeit.],
[Vorspannkraft bei Erwärmung.],
)
][
*Steifigkeiten:* $c_1 = E_1 A_s\/l = "2,1" dot 10^5 dot "78,54"\/100 = "1,649" dot 10^5 "N/mm"$; $c_2 = "0,7" dot 10^5 dot "574,0"\/100 = "4,019" dot 10^5 "N/mm"$.
][
*a) Vorspannung:* Drehung $120°$ entspricht $n h = 1\/3 "mm"$ $= Delta l_1 + Delta l_2 = F_V (1\/c_1 + 1\/c_2)$. $F_V = "0,3333"\/("8,551" dot 10^(-6)) = "38,98" "kN"$; $Delta l_1 = F_V\/c_1 = "0,236" "mm"$, $Delta l_2 = "0,097" "mm"$.
][
*b) Betriebskraft:* Die Schraube bekommt den Anteil $c_1\/(c_1 + c_2) = "0,291"$ der Betriebskraft: $F_S = "38,98" + "2,91" = "41,89" "kN"$; die Hülse wird um $"7,09" "kN"$ entlastet auf $"31,89" "kN"$.
][
*c) Spannungen:* $A_k = "86,6" "mm"^2$: $sigma_V = 450 "N/mm"^2 < 640$; $sigma_B = 484 "N/mm"^2$; Wechselanteil $(484 - 450)\/2 = "16,8" < 40 "N/mm"^2$. Beides zulässig.
][
*d) Wärme:* Die Schraube dehnt sich frei um $alpha_1 dot 100 dot l = "0,12" "mm"$, die Hülse um $alpha_2 dot 60 dot l = "0,138" "mm"$. Die Hülse wächst mehr und spannt nach: $F_V = ("0,3333" - "0,12" + "0,138")\/("8,551" dot 10^(-6)) = "41,09" "kN"$.
]

#aufgabe(titel: "Kolbenschraube mit Hülse verspannen (Variante)", art: "rechnen", quelle: "TM2 1.6", herkunft: "variante", vorlage: "TM2-Übung 4, Aufg. 4.1", minuten: 20,
  ergebnis: [a) $F_V = "29,24" "kN"$, $Delta l_1 = "0,177" "mm"$, $Delta l_2 = "0,073" "mm"$; b) Schraube $"31,56" "kN"$, Hülse $"23,56" "kN"$; c) $sigma_V = 338$, $sigma_B = 365$, $sigma_a = plus.minus "13,4" "N/mm"^2$; d) $F_V = "33,91" "kN"$],
)[
#if not web [*Aufgabe 171* #linebreak()]
*Gegeben und Annahmen*

Kolben wie in Übung 4.1, aber die Mutter wird nur um 90° angezogen, die Betriebskraft je Schraube ist 8 kN, und im Betrieb wird die Hülse 100 °C, die Schraube 140 °C warm (Montage bei 20 °C).

*Gesucht*

#enum(numbering: "a)",
[$F_V$, $Delta l_1$, $Delta l_2$; Schraubenkraft im Betrieb; Spannungen; Vorspannkraft warm.],
)
][
*a):* $n h = "0,25" "mm"$, $F_V = "0,25"\/("8,551" dot 10^(-6)) = "29,24" "kN"$; $Delta l_1 = "0,177"$, $Delta l_2 = "0,073" "mm"$.
][
*b):* $F_S = "29,24" + "0,291" dot 8 = "31,56" "kN"$, Hülse $"29,24" - "0,709" dot 8 = "23,56" "kN"$.
][
*c):* $sigma_V = 29235\/"86,6" = 338$, $sigma_B = 365$, $sigma_a = "13,4" "N/mm"^2$, alles zulässig.
][
*d):* Schraube frei $"1,2" dot 10^(-5) dot 120 dot 100 = "0,144" "mm"$, Hülse $"2,3" dot 10^(-5) dot 80 dot 100 = "0,184" "mm"$: $F_V = ("0,25" - "0,144" + "0,184")\/("8,551" dot 10^(-6)) = "33,91" "kN"$.
]

#aufgabe(titel: "Zu kurzer Stab: drei Montagevarianten", art: "rechnen", quelle: "TM2 1.6", herkunft: "original", vorlage: "TM2-Übung 4, Aufg. 4.3", minuten: 20,
  ergebnis: [a) $F = "0,2612" delta E A\/l$; b) $Z = delta E A\/l$; c) $Delta T = delta\/(2 l alpha_T)$; d) $u_C = "0,793" delta$, $S_3 = "0,2071" delta E A\/l$, $S_1 = sqrt(2) S_3$ (hier Druck), $S_2 = -S_3$],
  tipp: [Knoten C hat zwei Freiheitsgrade. Eine waagerechte Kraft verschiebt ihn auch etwas senkrecht, weil Stab 1 schräg ist.],
)[
#if not web [*Aufgabe 172* #linebreak()]
Der um $delta$ zu kurz geratene Stab 3 soll mit dem Knoten C verbunden werden ($delta << l$). Alle Stäbe haben gleiches $E A$ und $alpha_T$. a) C wird durch eine Kraft $F$ nach rechts verschoben: Größe von $F$? b) Das linke Ende von Stab 3 wird durch $Z$ nach links gezogen: Größe von $Z$? c) Stab 1 wird erwärmt, bis C weit genug wandert: $Delta T$? d) Verschiebung von C und Stabkräfte nach der Montage.
#align(center)[#image(abbildungen.at("tm2k1_ue43"), width: 60%)]

*Gegeben und Annahmen*

Knoten C bei $(l; l)$. Stab 1 von $(0; 0)$ nach C (unter 45°, Länge $sqrt(2) l$), Stab 2 senkrecht von $(l; 0)$ nach C (Länge $l$), Stab 3 waagerecht von C zur Wand bei $x = 2l$ (Soll-Länge $l$).

*Gesucht*

#enum(numbering: "a)",
[$F$.],
[$Z$.],
[$Delta T$.],
[$u_C$ und Stabkräfte nach der Montage.],
)
][
*Steifigkeit von C:* Stab 1 liefert $E A\/(sqrt(2) l) dot 1\/2 [1, 1; 1, 1]$, Stab 2 nur senkrecht $E A\/l$. Gesamt $K = E A\/l ["0,3536", "0,3536"; "0,3536", "1,3536"]$. Bei waagerechter Kraft ist die wirksame Steifigkeit $K_(11) - K_(12)^2\/K_(22) = ("0,3536" - "0,0924") E A\/l = "0,2612" E A\/l$.
][
*a) und b):* $F = "0,2612" delta E A\/l$. Zieht man stattdessen Stab 3 lang, muss nur dieser um $delta$ gedehnt werden: $Z = delta E A\/l$.
][
*c) Erwärmung:* C soll ohne Kraft um $delta$ nach rechts wandern, Stab 2 bleibt gleich lang ($v = 0$). Dann muss Stab 1 um $delta cos 45° = delta\/sqrt(2)$ länger werden: $alpha_T Delta T sqrt(2) l = delta\/sqrt(2)$, $Delta T = delta\/(2 l alpha_T)$.
][
*d) Nach der Montage:* Stab 3 zieht mit $S_3$, C weicht um $u_C = S_3\/("0,2612" E A\/l)$ aus, und Stab 3 wird um $S_3 l\/(E A)$ gedehnt: $u_C + S_3 l\/(E A) = delta$. Also $S_3 = delta E A\/l\/("3,828" + 1) = "0,2071" delta E A\/l$ und $u_C = "0,793" delta$. Knotengleichgewicht: $S_1 = -sqrt(2) S_3$ (Druck), $S_2 = +S_3$ (Zug); im Lösungsblatt stehen die Beträge mit anderer Ansatzrichtung.
]

#aufgabe(titel: "Zu kurzer Stab mit doppelter Länge (Variante)", art: "rechnen", quelle: "TM2 1.6", herkunft: "variante", vorlage: "TM2-Übung 4, Aufg. 4.3", minuten: 12,
  ergebnis: [$F = "0,2612" delta E A\/l$ (unverändert), $Z = delta E A\/(2l)$, $S_3 approx "0,1716" delta E A\/l$, $u_C approx "0,657" delta$],
)[
#if not web [*Aufgabe 173* #linebreak()]
*Gegeben und Annahmen*

Anordnung wie in Übung 4.3, aber die Wand steht bei $x = 3l$, Stab 3 hat also die Soll-Länge $2l$ und ist um $delta$ zu kurz.

*Gesucht*

#enum(numbering: "a)",
[$F$, $Z$, $S_3$ und $u_C$ nach der Montage.],
)
][
*a) und b):* Die Steifigkeit von C hängt nicht von Stab 3 ab: $F = "0,2612" delta E A\/l$. Stab 3 ist doppelt so lang und halb so steif: $Z = delta E A\/(2l)$.
][
*d):* $S_3 (l\/("0,2612" E A) + 2l\/(E A)) = delta$, also $S_3 = delta E A\/l\/("3,828" + 2) = "0,1716" delta E A\/l$, $u_C = "0,1716"\/"0,2612" delta = "0,657" delta$.
]

#aufgabe(titel: "Erwärmter Stab stützt einen Kragarm", art: "rechnen", quelle: "TM2 1.7", herkunft: "original", vorlage: "Altklausur SS 24, Aufg. 2 (Wärmedehnung)", minuten: 12,
  ergebnis: [$X approx "188,93" thin "N"$ Druck, Balkenende $"0,29989" thin "mm"$ nach oben, $M_A = -X l = -188929 thin "Nmm"$],
  tipp: [Der Stab will sich um $alpha_T Delta T a$ verlängern. Diese Länge teilen sich die Stauchung des Stabes und die Durchbiegung des Balkens.],
)[
#if not web [*Aufgabe 174* #linebreak()]
*AK24 S. 18, 24:*

*Gegeben und Annahmen*

Verwende $a=250 "mm"$, $l=1000 "mm"$, $A=2000 "mm"^2$, $I=10^6 "mm"^4$, $E=210000 "N/mm"^2$, $alpha_T=12 dot 10^(-6) "1/K"$, $Delta T=100 "K"$. Ein vertikaler Stab der Länge $a$ stützt das freie Ende eines horizontalen Kragarms der Länge $l$. Der Stab wird um $Delta T$ erwärmt, der Balken nicht. Beide sind linear elastisch, der Balken schubstarr; keine weitere Last.
#align(center)[#image(abbildungen.at("ak24-waerme"), width: 100%)]

*Gesucht*

#enum(numbering: "a)",
[Bestimme X, die Verschiebung und das Einspannmoment.],
)
][
*Bild:* Der Stab wird warm und möchte länger werden. Der Kragarm hält dagegen wie eine weiche Feder. Es stellt sich eine Kraft X ein, bei der beide zusammenpassen: der Stab wird etwas zusammengedrückt, der Balken etwas hochgebogen.
][
*Freie Wärmedehnung:* Ohne Behinderung wäre der Stab $alpha_T Delta T a = 12 dot 10^(-6) dot 100 dot 250 = "0,300" thin "mm"$ länger.
][
*Nachgiebigkeiten:* Wie viel gibt jedes Teil pro Newton nach? Stab: $a\/(E A) = "5,952" dot 10^(-7) thin "mm/N"$. Kragarm mit Endkraft: $l^3\/(3E I) = "1,5873" dot 10^(-3) thin "mm/N"$. Der Balken ist rund 2700-mal weicher.
][
*Verträglichkeit:* Stauchung plus Balkenweg ergeben die freie Dehnung:
$ X dot (a/(E A) + l^3/(3E I)) = "0,300" thin "mm" => X = "0,300"/("1,58790" dot 10^(-3)) approx "188,93" thin "N". $
][
*Verschiebung und Moment:* Das Balkenende geht um $X l^3\/(3E I) approx "0,29989" thin "mm"$ nach oben; mit w nach unten ist w negativ. Aus dem eingezeichneten Momentenansatz in AK24 folgt *$M_A=-X l=-188929 "Nmm"$*.
][
*Prüfen:* Stauchung des Stabes $X a\/(E A) approx "0,0001125" thin "mm"$; zusammen mit 0,29989 mm ergibt das 0,300 mm. *Achtung:* Die Formel auf AK24 S. 24 ist richtig, der dortige Zahlenwert 1851,765 N passt aber nicht zu den gedruckten Daten.
]

#aufgabe(titel: "Erwärmter Stab stützt einen Kragarm (Variante)", art: "rechnen", quelle: "TM2 1.7", herkunft: "variante", vorlage: "Altklausur SS 24, Aufg. 2 (Wärmedehnung)", minuten: 10,
  ergebnis: [$X approx "283,2" "N"$ Druck, Balkenende $"0,2877" "mm"$ nach oben, $|M_A| = X l approx 226590 "Nmm"$],
)[
#if not web [*Aufgabe 175* #linebreak()]
*Gegeben und Annahmen*

Aufbau wie AK24: senkrechter Stab (Länge $a = 300 "mm"$, $A = 1500 "mm"^2$) stützt das freie Ende eines Kragarms ($l = 800 "mm"$, $I = 8 dot 10^5 "mm"^4$). $E = 210000 "N/mm"^2$, $alpha_T = 12 dot 10^(-6) "1/K"$, nur der Stab wird um $Delta T = 80 "K"$ erwärmt.

*Gesucht*

#enum(numbering: "a)",
[Kraft $X$, Verschiebung des Balkenendes, Einspannmoment.],
)
][
*Freie Dehnung:* $alpha_T Delta T a = "0,288" "mm"$.
][
*Nachgiebigkeiten:* Stab $a\/(E A) = "9,52" dot 10^(-7) "mm/N"$, Balken $l^3\/(3 E I) = "1,0159" dot 10^(-3) "mm/N"$.
][
*Verträglichkeit:* $X = "0,288"\/("1,01683" dot 10^(-3)) = "283,2" "N"$.
][
*Folgen:* Balkenende $X l^3\/(3 E I) = "0,2877" "mm"$ nach oben; $|M_A| = X l = 226590 "Nmm"$.
]

#kapitel("TM2 Kapitel 2 · Spannungszustand und Mohrscher Kreis")

#aufgabe(titel: "Was ist ein ebener Spannungszustand?", art: "verstehen", quelle: "TM2 2.1", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 176* #linebreak()]
Was ist ein ebener Spannungszustand?
][
*Antwort:*
- *Alle Spannungen liegen in einer Ebene:* $sigma_x$, $sigma_y$ und $tau_(x y)$.
- Senkrecht dazu ist alles null.
- Das gilt näherungsweise für dünne Bleche und freie Oberflächen.
]

#aufgabe(titel: "Warum hängen die Spannungen davon ab, wie man schneidet?", art: "verstehen", quelle: "TM2 2.1", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 177* #linebreak()]
Warum hängen die Spannungen davon ab, wie man schneidet?
][
*Antwort:*
- Spannung ist Kraft pro Schnittfläche.
- Dreht man die Schnittfläche, verteilt sich dieselbe innere Kraft anders auf Normal- und Schubanteil.
- Derselbe Spannungszustand sieht in einem gedrehten Koordinatensystem anders aus.
]

#aufgabe(titel: "Eingespannter Blechstreifen unter Zug", art: "rechnen", quelle: "TM2 2.1", herkunft: "original", vorlage: "TM2-Übung 5, Aufg. 5.1", minuten: 12,
  ergebnis: [a) $sigma_x = 100$, $sigma_y = tau_(x y) = 0 thin "N/mm"^2$; b) $Delta l = "0,476" "mm"$, $Delta b = -"0,0143" "mm"$, $Delta t = -"0,000143" "mm"$; c) 45°-Schnitt: $sigma = 50$, $|tau| = 50 thin "N/mm"^2$],
  tipp: [Der Spannungsvektor ist $arrow(t) = S arrow(n)$. Die Normalspannung ist sein Anteil in Richtung $arrow(n)$, der Rest ist Schub.],
)[
#if not web [*Aufgabe 178* #linebreak()]
Ein Blechstreifen wird zwischen zwei Spannvorrichtungen eingespannt und durch eine Kraft $F$ belastet. Die lokale Störung der Spannungsverteilung durch die Einspannung ist nicht zu berücksichtigen (homogener ebener Spannungszustand).
#align(center)[#image(abbildungen.at("tm2k2_ue51"), width: 55%)]

*Gegeben und Annahmen*

$t = 1 "mm"$, $b = 100 "mm"$, $l = 1 "m"$, $F = 10 "kN"$, $E = "2,1" dot 10^5 "N/mm"^2$, $nu = "0,3"$.

*Gesucht*

#enum(numbering: "a)",
[$sigma_x$, $sigma_y$, $tau_(x y)$ und der Spannungstensor $S$.],
[Längenänderung sowie Änderung von Breite $b$ und Dicke $t$.],
[Spannungsvektoren, Normal- und Schubspannung für Schnitte senkrecht zur $x$-Achse, senkrecht zur $y$-Achse und unter 45°.],
)
][
*Spannungen:* Die Kraft verteilt sich gleichmäßig auf $A = b t = 100 "mm"^2$, also $sigma_x = F\/A = 100 "N/mm"^2$. Quer und als Schub wirkt nichts: $sigma_y = tau_(x y) = 0$. Damit $S = mat(100, 0; 0, 0) "N/mm"^2$.
][
*Längenänderung:* $epsilon_x = sigma_x\/E = "4,76" dot 10^(-4)$, also $Delta l = epsilon_x l = "0,476" "mm"$.
][
*Querkontraktion:* Breite und Dicke werden um $nu epsilon_x$ kürzer: $Delta b = -"0,3" dot "4,76" dot 10^(-4) dot 100 = -"0,0143" "mm"$, $Delta t = -"0,000143" "mm"$.
][
*Schnitte senkrecht zu den Achsen:* Mit $arrow(n) = (1, 0)$ ist $arrow(t) = (100, 0)$: $sigma = 100$, $tau = 0$. Mit $arrow(n) = (0, 1)$ ist $arrow(t) = (0, 0)$: der Längsschnitt ist spannungsfrei.
][
*45°-Schnitt:* $arrow(n) = ("0,7071", "0,7071")$ gibt $arrow(t) = S arrow(n) = ("70,71", 0)$. Normalanteil $sigma = arrow(t) dot arrow(n) = 50$, Schubanteil $|tau| = sqrt("70,71"^2 - 50^2) = 50 "N/mm"^2$. Die Transformation $sigma = sigma_x cos^2 45° = 50$, $tau = -sigma_x\/2 dot sin 90° = -50$ liefert dasselbe; das Vorzeichen hängt nur von der Zählrichtung von $tau$ ab.
][
*Prüfen:* Unter 45° ist der Schub am größten und gleich $sigma_x\/2$. Das passt zum Mohrschen Kreis mit Radius 50.
]

#aufgabe(titel: "Blechstreifen unter Zug (Variante)", art: "rechnen", quelle: "TM2 2.1", herkunft: "variante", vorlage: "TM2-Übung 5, Aufg. 5.1", minuten: 10,
  ergebnis: [$sigma_x = 125 "N/mm"^2$; $Delta l = "0,714" "mm"$, $Delta b = -"0,0143" "mm"$, $Delta t = -"0,000268" "mm"$; 45°: $arrow(t) = ("88,39", 0)$, $sigma = "62,5"$, $|tau| = "62,5" thin "N/mm"^2$],
)[
#if not web [*Aufgabe 179* #linebreak()]
*Gegeben und Annahmen*

Blechstreifen wie in Übung 5.1, aber $F = 15 "kN"$, $b = 80 "mm"$, $t = "1,5" "mm"$, $l = "1,2" "m"$, $E = "2,1" dot 10^5 "N/mm"^2$, $nu = "0,3"$. Homogener ebener Spannungszustand.

*Gesucht*

#enum(numbering: "a)",
[Spannungstensor.],
[$Delta l$, $Delta b$, $Delta t$.],
[Spannungsvektor, $sigma$ und $tau$ im 45°-Schnitt.],
)
][
*Spannung:* $A = 80 dot "1,5" = 120 "mm"^2$, also $sigma_x = 15000\/120 = 125 "N/mm"^2$ und $S = mat(125, 0; 0, 0) "N/mm"^2$.
][
*Verformung:* $epsilon_x = 125\/210000 = "5,95" dot 10^(-4)$. $Delta l = "0,714" "mm"$, $Delta b = -"0,3" epsilon_x dot 80 = -"0,0143" "mm"$, $Delta t = -"0,3" epsilon_x dot "1,5" = -"0,000268" "mm"$.
][
*45°-Schnitt:* $arrow(t) = S arrow(n) = (125 dot "0,7071", 0) = ("88,39", 0)$. $sigma = 125 cos^2 45° = "62,5"$, $|tau| = 125\/2 dot sin 90° = "62,5" thin "N/mm"^2$.
]

#aufgabe(titel: "Hauptrichtung im Mohrschen Kreis", art: "verstehen", quelle: "TM2 2.2", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 180* #linebreak()]
Was bedeutet „Hauptrichtung“, und wie erkennst du sie im Kreis?
][
In der Hauptrichtung verschwindet die Schubspannung. Im Kreis liegen die Hauptspannungen deshalb auf der horizontalen Achse.
]

#aufgabe(titel: "Warum kann die größte Schubspannung größer sein als der Radius des Mohrschen Kreises?", art: "verstehen", quelle: "TM2 2.2", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 181* #linebreak()]
Warum kann die größte Schubspannung größer sein als der Radius des Mohrschen Kreises?
][
*Antwort:*
- Im ebenen Spannungszustand ist die dritte Hauptspannung $sigma_3 = 0$.
- Haben $sigma_1$ und $sigma_2$ dasselbe Vorzeichen, liegt der größte Kreis zwischen 0 und der betragsgrößten Hauptspannung.
- Dann ist
$ tau_max = abs(sigma_1)/2 quad "und nicht" quad (sigma_1 - sigma_2)/2 $
][
*Merksatz:* Für das räumliche Schubmaximum die dritte Hauptspannung mitdenken.
]

#aufgabe(titel: "Hauptspannungen aus zwei Normalspannungen und einer Schubspannung", art: "verstehen", quelle: "TM2 2.2", herkunft: "eigen", minuten: 3,
  tipp: [$sigma_("1,2") = (sigma_x + sigma_y)\/2 plus.minus sqrt(((sigma_x - sigma_y)\/2)^2 + tau_(x y)^2)$],
)[
#if not web [*Aufgabe 182* #linebreak()]
Gegeben sind $sigma_x = 80$, $sigma_y = 20$ und $tau_(x y) = 40$ (N/mm²). Wie groß sind die Hauptspannungen?
][
*Antwort:* 100 und 0 N/mm². Mittelpunkt 50, Radius $sqrt(30^2 + 40^2) = 50$, also $sigma_("1,2") = 50 plus.minus 50$.
][
*Typische Verwechslung:* 80 und 20 N/mm²: Das sind die Normalspannungen im gegebenen Achsensystem. Wegen der Schubspannung sind es keine Hauptspannungen.
]

#aufgabe(titel: "Spannungen in einer schrägen Schweißnaht", art: "rechnen", quelle: "TM2 2.2", herkunft: "original", vorlage: "TM2-Übung 5, Aufg. 5.2", minuten: 8,
  ergebnis: [$sigma(phi) = sigma_x cos^2 phi = "37,5" "N/mm"^2$, $tau(phi) = -sigma_x\/2 dot sin 2phi = -"21,65" "N/mm"^2$],
  tipp: [Schneide ein Dreieck mit der Naht als Hypotenuse frei. Die Fläche der Naht ist $A\/cos phi$, wenn $A$ die Querschnittsfläche ist.],
)[
#if not web [*Aufgabe 183* #linebreak()]
Bei einem zusammengeschweißten Blechstreifen ist die Spannung $sigma_x$ gegeben. Wie groß sind die Normalspannung $sigma(phi)$ und die Schubspannung $tau(phi)$ in der Schweißnaht?
#align(center)[#image(abbildungen.at("tm2k2_ue52"), width: 50%)]

*Gegeben und Annahmen*

Einachsiger Zug $sigma_x$, $sigma_y = tau_(x y) = 0$. Die Nahtnormale ist um $phi$ gegen die $x$-Achse gedreht. Zahlen: $sigma_x = 50 "N/mm"^2$, $phi = 30°$.

*Gesucht*

#enum(numbering: "a)",
[Allgemeine Lösung mit Gleichgewicht am Schnitt und mit den Transformationsgleichungen.],
[Zahlenwerte für $sigma_x = 50 "N/mm"^2$ und $phi = 30°$.],
)
][
*Gleichgewicht am Schnitt:* Auf die Querschnittsfläche $A$ wirkt $F = sigma_x A$. Die Naht hat die Fläche $A\/cos phi$. Zerlegt man $F$ in Richtung der Nahtnormalen ($F cos phi$) und längs der Naht ($F sin phi$), folgt $sigma = F cos phi \/ (A\/cos phi) = sigma_x cos^2 phi$ und $|tau| = sigma_x sin phi cos phi$.
][
*Transformation:* Mit $sigma_y = tau_(x y) = 0$ werden die Gleichungen zu $sigma(phi) = sigma_x\/2 (1 + cos 2phi) = sigma_x cos^2 phi$ und $tau(phi) = -sigma_x\/2 dot sin 2phi$. Das Vorzeichen zeigt die Zählrichtung im gedrehten System.
][
*Zahlen:* $sigma = 50 dot "0,75" = "37,5" "N/mm"^2$, $tau = -25 dot sin 60° = -"21,65" "N/mm"^2$.
][
*Prüfen:* Für $phi = 0$ ergibt sich der Querschnitt ($sigma = sigma_x$, $tau = 0$). Bei $phi = 45°$ ist der Schub mit $sigma_x\/2$ am größten.
]

#aufgabe(titel: "Schräge Schweißnaht (Variante)", art: "rechnen", quelle: "TM2 2.2", herkunft: "variante", vorlage: "TM2-Übung 5, Aufg. 5.2", minuten: 5,
  ergebnis: [$sigma = "46,95" "N/mm"^2$, $tau = -"39,39" "N/mm"^2$],
)[
#if not web [*Aufgabe 184* #linebreak()]
*Gegeben und Annahmen*

Geschweißter Blechstreifen wie in Übung 5.2, $sigma_x = 80 "N/mm"^2$, Nahtwinkel $phi = 40°$, sonst spannungsfrei.

*Gesucht*

#enum(numbering: "a)",
[$sigma(phi)$ und $tau(phi)$ in der Naht.],
)
][
*Formeln:* Bei einachsigem Zug gilt $sigma(phi) = sigma_x cos^2 phi$ und $tau(phi) = -sigma_x\/2 dot sin 2phi$.
][
*Zahlen:* $cos^2 40° = "0,5868"$, also $sigma = "46,95" "N/mm"^2$. $tau = -40 dot sin 80° = -"39,39" "N/mm"^2$.
][
*Prüfen:* $sigma^2 + tau^2 = (sigma_x cos phi)^2$: $"46,95"^2 + "39,39"^2 = "3756" approx ("61,28")^2$, und $80 cos 40° = "61,28"$. Passt.
]

#aufgabe(titel: "Warum der Kreiswinkel halbiert wird", art: "verstehen", quelle: "TM2 2.2.3", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 185* #linebreak()]
Warum musst du einen am Kreis gemessenen Winkel halbieren?
][
Die Transformationsgleichungen enthalten den doppelten Winkel 2φ. Außerdem ist der Drehsinn im Kreis entgegengesetzt zum Bauteilwinkel, wenn P wie hier eingetragen wird.
]

#aufgabe(titel: "Wie liest man den Mohrschen Kreis?", art: "verstehen", quelle: "TM2 2.2.3", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 186* #linebreak()]
Wie liest man den Mohrschen Kreis?
][
*Antwort:*
- Jeder Punkt auf dem Kreis ist ein Schnitt mit $(sigma, tau)$.
- Der Mittelpunkt liegt bei $(sigma_x + sigma_y)\/2$.
- Die Schnittpunkte mit der $sigma$-Achse sind die Hauptspannungen.
- Der Radius ist die größte Schubspannung in der Ebene.
#align(center)[#image(abbildungen.at("tm2k2_fs_kreis"), width: 60%)]
]

#aufgabe(titel: "Mohrschen Spannungskreis konstruieren", art: "verstehen", quelle: "TM2 2.2.3", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 187* #linebreak()]
Wie konstruierst Du den Mohrschen Spannungskreis?
][
*Antwort:* Die Punkte $(sigma_x, tau_(x y))$ und $(sigma_y, -tau_(x y))$ eintragen, sie bilden einen Durchmesser.; Beide Achsen im gleichen Maßstab zeichnen. Der Mittelpunkt liegt bei $((sigma_x + sigma_y)\/2, 0)$, der Kreis geht durch beide Punkte. Sonst wird der Kreis zur Ellipse und alle Ablesungen werden falsch.
][
*Typische Verwechslung:* Ein Winkel $phi$ am Bauteil entspricht $phi$ im Kreis.: Im Kreis ist der Winkel doppelt so groß, $2 phi$, mit entgegengesetztem Drehsinn in dieser Konvention.
]

#aufgabe(titel: "Mohrscher Kreis mit Hauptspannungen", art: "rechnen", quelle: "TM2 2.2.3", herkunft: "original", vorlage: "TM2-Übung 6, Aufg. 6.2", minuten: 12,
  ergebnis: [$sigma_M = "27,5"$, $R = "62,5"$, $sigma_1 = 90$, $sigma_2 = -35 thin "N/mm"^2$, $phi_1 = -"18,435"°$],
  tipp: [Mittelpunkt ist der Mittelwert von $sigma_x$ und $sigma_y$. Der Radius kommt aus Pythagoras mit halber Differenz und $tau_(x y)$.],
)[
#if not web [*Aufgabe 188* #linebreak()]
*AK24 S. 24–25 / Übung 6.2:*

*Gegeben und Annahmen*

$sigma_x="77,5"$, $sigma_y=-"22,5"$, $tau_(x y)=-"37,5"$ N/mm².

*Gesucht*

#enum(numbering: "a)",
[Zeichne den Kreis und bestimme Mittelpunkt, Radius, Hauptspannungen und die Richtung von $sigma_1$.],
)
][
*Bild:* Jeder Schnittwinkel durch das Bauteil ist ein Punkt auf dem Kreis. Die Hauptspannungen sind die beiden Punkte, an denen der Kreis die waagerechte Achse schneidet, denn dort ist $tau = 0$.
][
*Mittelpunkt:* $sigma_M = (sigma_x + sigma_y)\/2 = ("77,5" - "22,5")\/2 = "27,5" thin "N/mm"^2$.
][
*Radius:* Halbe Differenz $("77,5" + "22,5")\/2 = 50$. Damit $R = sqrt(50^2 + "37,5"^2) = "62,5" thin "N/mm"^2$.
][
*Hauptspannungen:* $sigma_1 = sigma_M + R = 90 thin "N/mm"^2$, $sigma_2 = sigma_M - R = -35 thin "N/mm"^2$.
][
*Richtung:* $tan 2phi_1 = 2tau_(x y)\/(sigma_x - sigma_y) = -75\/100$, also $2phi_1 = -"36,87"°$ und *$phi_1 = -"18,435"°$* (gleichwertig 161,565°). Die zweite Hauptrichtung steht senkrecht dazu: 71,565°. Einsetzen in die Transformation gibt 90 N/mm² und $tau = 0$.
][
*Prüfen:* $sigma_1 + sigma_2 = 55 = sigma_x + sigma_y$, die Summe bleibt bei jeder Drehung gleich. Die Handskizze in AK24 S. 25 liefert nur grobe Werte (88 und −36); die Rechnung ist die Kontrolle.
]

#aufgabe(titel: "Mohrscher Kreis mit Hauptspannungen (Variante)", art: "rechnen", quelle: "TM2 2.2.3", herkunft: "variante", vorlage: "TM2-Übung 6, Aufg. 6.2", minuten: 10,
  ergebnis: [$sigma_M = 20$, $R = 50$, $sigma_1 = 70$, $sigma_2 = -30 thin "N/mm"^2$, $phi^* = "18,43"°$, $tau_("max") = 50 "N/mm"^2$, $phi^(**) = "63,43"°$],
)[
#if not web [*Aufgabe 189* #linebreak()]
*Gegeben und Annahmen*

Ebener Spannungszustand $sigma_x = 60$, $sigma_y = -20$, $tau_(x y) = 30 thin "N/mm"^2$.

*Gesucht*

#enum(numbering: "a)",
[Hauptnormalspannungen und Richtung von $sigma_1$.],
[Hauptschubspannung, $sigma_M$ und Richtung.],
)
][
*Kreis:* $sigma_M = (60 - 20)\/2 = 20$. Halbe Differenz 40, also $R = sqrt(40^2 + 30^2) = 50 "N/mm"^2$.
][
*Hauptspannungen:* $sigma_1 = 20 + 50 = 70$, $sigma_2 = 20 - 50 = -30 "N/mm"^2$.
][
*Richtung:* $tan 2phi^* = 60\/80$, also $phi^* = "18,43"°$. Einsetzen: $sigma_xi = 20 + 40 cos "36,87"° + 30 sin "36,87"° = 70$, also gehört $phi^*$ zu $sigma_1$.
][
*Hauptschub:* $tau_("max") = R = 50 "N/mm"^2$ bei $phi^(**) = phi^* + 45° = "63,43"°$; dort wirkt $sigma_M = 20 "N/mm"^2$.
][
*Prüfen:* $sigma_1 + sigma_2 = 40 = sigma_x + sigma_y$.
]

#aufgabe(titel: "Hauptspannungen am geschweißten Blechstreifen", art: "rechnen", quelle: "TM2 2.2.3", herkunft: "original", vorlage: "TM2-Übung 6, Aufg. 6.1", minuten: 10,
  ergebnis: [$sigma_1 = 50$, $sigma_2 = 0$, $phi^* = 0°$; $tau_("max") = plus.minus 25$, $sigma_M = 25 thin "N/mm"^2$, $phi^(**) = 45°$; Naht ($30°$): $sigma = "37,5"$, $tau = -"21,65" thin "N/mm"^2$],
  tipp: [Ohne Schub sind $x$ und $y$ schon Hauptrichtungen. Der Kreis geht dann durch den Ursprung.],
)[
#if not web [*Aufgabe 190* #linebreak()]
Bestimmen Sie für den Blechstreifen aus Aufgabe 5.2 ($sigma_x = 50 "N/mm"^2$) die Hauptwerte rechnerisch und mit dem Mohrschen Kreis.
#align(center)[#image(abbildungen.at("tm2k2_ue52"), width: 45%)]

*Gegeben und Annahmen*

$sigma_x = 50 "N/mm"^2$, $sigma_y = tau_(x y) = 0$; Schweißnaht unter $phi = 30°$.

*Gesucht*

#enum(numbering: "a)",
[Hauptnormalspannungen $sigma_1$, $sigma_2$ und Hauptspannungsrichtungen.],
[Hauptschubspannung $tau_("max")$, Richtung und zugehörige Normalspannung $sigma_M$.],
[Mohrscher Kreis; daraus die Werte grafisch und $sigma$, $tau$ in der Naht.],
)
][
*Hauptrichtungen:* $tan 2phi^* = 2tau_(x y)\/(sigma_x - sigma_y) = 0$, also $phi^* = 0°, 90°, dots$ Ohne Schub sind $x$ und $y$ bereits die Hauptachsen.
][
*Hauptspannungen:* $sigma_1 = sigma_x = 50 "N/mm"^2$, $sigma_2 = sigma_y = 0$.
][
*Hauptschub:* $tau_("max") = plus.minus (sigma_1 - sigma_2)\/2 = plus.minus 25 "N/mm"^2$, in den Richtungen $phi^(**) = phi^* plus.minus 45° = 45°$. Dort wirkt zusätzlich $sigma_M = (sigma_1 + sigma_2)\/2 = 25 "N/mm"^2$.
][
*Mohrscher Kreis:* Mittelpunkt $(25, 0)$, Radius 25; er geht durch $(0, 0)$ und $(50, 0)$. Der höchste Punkt $(25, 25)$ ist der Hauptschub.
][
*Naht:* Im Kreis dreht man um $2phi = 60°$ von $(50, 0)$ aus: $sigma = 25 + 25 cos 60° = "37,5"$, $tau = -25 sin 60° = -"21,65" "N/mm"^2$, genau wie in 5.2.
]

#aufgabe(titel: "Hauptspannungen bei zweiachsigem Zug (Variante)", art: "rechnen", quelle: "TM2 2.2.3", herkunft: "variante", vorlage: "TM2-Übung 6, Aufg. 6.1", minuten: 8,
  ergebnis: [$sigma_1 = 60$, $sigma_2 = 20$, $phi^* = 0°$; $tau_("max") = plus.minus 20$, $sigma_M = 40$; bei $30°$: $sigma = 50$, $tau = -"17,32" thin "N/mm"^2$],
)[
#if not web [*Aufgabe 191* #linebreak()]
*Gegeben und Annahmen*

Blechstreifen mit Naht unter $phi = 30°$, jetzt zweiachsig belastet: $sigma_x = 60 "N/mm"^2$, $sigma_y = 20 "N/mm"^2$, $tau_(x y) = 0$.

*Gesucht*

#enum(numbering: "a)",
[Hauptspannungen und -richtungen.],
[$tau_("max")$, $sigma_M$ und Richtung.],
[$sigma$ und $tau$ in der Naht mit dem Mohrschen Kreis.],
)
][
*Hauptwerte:* Kein Schub, also $phi^* = 0°$: $sigma_1 = 60$, $sigma_2 = 20 "N/mm"^2$.
][
*Hauptschub:* $tau_("max") = plus.minus (60 - 20)\/2 = plus.minus 20$, $sigma_M = 40 "N/mm"^2$, unter $45°$.
][
*Kreis und Naht:* Mittelpunkt 40, Radius 20. Drehung um $60°$ von $(60, 0)$ aus: $sigma = 40 + 20 cos 60° = 50$, $tau = -20 sin 60° = -"17,32" "N/mm"^2$.
][
*Prüfen:* Gegenüber 6.1 ist der Kreis nur verschoben und kleiner geworden. Der Querzug verringert den Schub in der Naht.
]

#aufgabe(titel: "Kernlochbohrer unter Anpresskraft und Torsion", art: "rechnen", quelle: "TM2 2.2.3", herkunft: "original", vorlage: "TM2-Übung 7, Aufg. 7.1", minuten: 15,
  ergebnis: [a) $sigma_x = -20 "N/mm"^2$; b) $tau_(x y) = 30 "N/mm"^2$; c) $sigma_1 = "21,62"$, $sigma_2 = -"41,62"$ (bei $phi^* = -"35,78"°$), $tau_("max") = "31,62"$, $sigma_M = -10 thin "N/mm"^2$, $phi^(**) = "9,22"°$],
  tipp: [Dünnwandiges Rohr: $A = d_m pi t$. Das Moment wird über den Hebel $r_m$ zur Umfangskraft.],
)[
#if not web [*Aufgabe 192* #linebreak()]
Ein Kernlochbohrer kann als dünnwandiges Rohr betrachtet werden. Die Bohrkrone wird am oberen Ende durch die Anpresskraft $F_x$ und das Antriebsmoment $M_t$ belastet. Eigengewicht wird nicht berücksichtigt. Betrachtet wird ein sehr kleiner, näherungsweise ebener Ausschnitt der Rohrwand.
#align(center)[#image(abbildungen.at("tm2k2_ue71"), width: 45%)]

*Gegeben und Annahmen*

$d_m = 100 "mm"$, $t = 2 "mm"$, $F_x = "12,57" "kN"$ (Druck), $M_t = "0,943" "kNm"$. $x$ in Längsrichtung, $y$ in Umfangsrichtung.

*Gesucht*

#enum(numbering: "a)",
[Die Normalspannung infolge der Anpresskraft (mit Vorzeichen).],
[Die Schubspannung infolge des Torsionsmoments.],
[Hauptspannungen, Hauptschubspannungen und Richtungen.],
[Kontrolle von a) bis c) mit dem Mohrschen Kreis.],
)
][
*Normalspannung:* Die Kraft drückt auf den Ringquerschnitt $A = d_m pi t = "628,3" "mm"^2$: $sigma_x = -12570\/"628,3" = -20 "N/mm"^2$. In Umfangsrichtung wirkt nichts, $sigma_y = 0$.
][
*Schubspannung:* Das Moment wird über $r_m = 50 "mm"$ zur Umfangskraft $M_t\/r_m = 18860 "N"$. Verteilt auf $A$: $tau_(x y) = 18860\/"628,3" = +30 "N/mm"^2$ (positiv nach der Definition im Bild).
][
*Hauptrichtung:* $tan 2phi^* = 2 dot 30\/(-20 - 0) = -3$, also $phi^* = -"35,78"°$. Einsetzen: $sigma_xi = -10 - 10 cos(-"71,57"°) + 30 sin(-"71,57"°) = -"41,62"$. Bei $phi^*$ liegt also $sigma_2$.
][
*Hauptspannungen:* $R = sqrt(10^2 + 30^2) = "31,62"$, $sigma_1 = -10 + "31,62" = "21,62"$, $sigma_2 = -"41,62" "N/mm"^2$.
][
*Hauptschub:* $tau_("max") = R = "31,62" "N/mm"^2$ bei $phi^(**) = phi^* + 45° = "9,22"°$, zugehörig $sigma_M = -10 "N/mm"^2$.
][
*Mohrscher Kreis:* Punkte $(-20, 30)$ und $(0, -30)$, Mittelpunkt $(-10, 0)$, Radius 31,62. Die Achsenschnittpunkte $"21,62"$ und $-"41,62"$ bestätigen c).
]

#aufgabe(titel: "Bohrrohr unter Druck und Torsion (Variante)", art: "rechnen", quelle: "TM2 2.2.3", herkunft: "variante", vorlage: "TM2-Übung 7, Aufg. 7.1", minuten: 12,
  ergebnis: [$sigma_x = -"12,73"$, $tau_(x y) = "29,84"$; $sigma_1 = "24,15"$, $sigma_2 = -"36,88"$ (bei $phi^* = -"38,98"°$), $tau_("max") = "30,51"$, $sigma_M = -"6,37" thin "N/mm"^2$, $phi^(**) = "6,02"°$],
)[
#if not web [*Aufgabe 193* #linebreak()]
*Gegeben und Annahmen*

Dünnwandiges Bohrrohr wie in Übung 7.1: $d_m = 80 "mm"$, $t = "2,5" "mm"$, Anpresskraft $F_x = 8 "kN"$ (Druck), Moment $M_t = "0,75" "kNm"$.

*Gesucht*

#enum(numbering: "a)",
[$sigma_x$ und $tau_(x y)$ in der Rohrwand.],
[Hauptspannungen, $tau_("max")$, $sigma_M$ und Richtungen.],
)
][
*Fläche:* $A = 80 pi dot "2,5" = "628,3" "mm"^2$.
][
*Spannungen:* $sigma_x = -8000\/"628,3" = -"12,73" "N/mm"^2$; $tau_(x y) = (750000\/40)\/"628,3" = "29,84" "N/mm"^2$.
][
*Kreis:* $sigma_M = -"6,37"$, $R = sqrt("6,37"^2 + "29,84"^2) = "30,51"$. Damit $sigma_1 = "24,15"$, $sigma_2 = -"36,88" "N/mm"^2$.
][
*Richtungen:* $tan 2phi^* = 2 dot "29,84"\/(-"12,73") = -"4,69"$, $phi^* = -"38,98"°$; dort liegt $sigma_2$. $phi^(**) = "6,02"°$ mit $tau_("max") = "30,51" "N/mm"^2$.
]

#kapitel("TM2 Kapitel 3 · Dehnungen, Elastizitätsgesetz und DMS")

#aufgabe(titel: "Achse des Verzerrungskreises", art: "verstehen", quelle: "TM2 3.1", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 194* #linebreak()]
Welche Größe steht auf der senkrechten Achse des Verzerrungskreises?
][
Die halbe Gleitung γ/2. Wer γ einträgt, erhält einen falschen Radius und falsche Hauptdehnungen.
]

#aufgabe(titel: "Was ist der Unterschied zwischen Dehnung und Gleitung?", art: "verstehen", quelle: "TM2 3.1", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 195* #linebreak()]
Was ist der Unterschied zwischen Dehnung und Gleitung?
][
*Antwort:*
- Die Dehnung $epsilon$ ändert Längen.
- Die Gleitung $gamma$ ändert den Winkel zwischen zwei ursprünglich senkrechten Linien, aus dem Rechteck wird ein Parallelogramm.
#align(center)[#image(abbildungen.at("tm2k3_reine"), width: 60%)]
]

#aufgabe(titel: "Was sagt das Hookesche Gesetz im ebenen Fall?", art: "verstehen", quelle: "TM2 3.1", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 196* #linebreak()]
Was sagt das Hookesche Gesetz im ebenen Fall?
][
*Antwort:*
- Die Dehnung in einer Richtung kommt aus der eigenen Spannung minus der Querkontraktion durch die andere:
$ epsilon_x = (sigma_x - nu sigma_y)/E $
- Die Gleitung kommt nur aus der Schubspannung: $gamma = tau\/G$.
#align(center)[#image(abbildungen.at("tm2k3_reine"), width: 60%)]
]

#aufgabe(titel: "Hauptdehnungen aus drei Messwerten (Altklausur 2018)", art: "rechnen", quelle: "TM2 3.1", herkunft: "original", vorlage: "Altklausur 2018, Aufg. 2 k)", minuten: 8,
  ergebnis: [$epsilon_1 = "0,547" "‰"$ (bei $"121,7"°$), $epsilon_2 = -"0,347" "‰"$ (bei $"31,7"°$)],
  tipp: [Rechne mit $gamma\/2$. Prüfe durch Einsetzen, welche Hauptdehnung zum berechneten Winkel gehört.],
)[
#if not web [*Aufgabe 197* #linebreak()]
*Ältere Klausur SS 2018, S. 11:*

*Gegeben und Annahmen*

Gemessen: $epsilon_x = -"0,10" "‰"$, $epsilon_y = "0,30" "‰"$, $gamma_(x y) = -"0,80" "‰"$.

*Gesucht*

#enum(numbering: "a)",
[Hauptdehnungen und ihre Richtungen.],
)
][
*Kreis:* Mittelpunkt $(epsilon_x + epsilon_y)\/2 = "0,1" "‰"$. Radius $sqrt("0,2"^2 + "0,4"^2) = "0,447" "‰"$, weil auf der senkrechten Achse $gamma\/2 = -"0,4"$ steht.
][
*Hauptdehnungen:* $epsilon_1 = "0,1" + "0,447" = "0,547" "‰"$, $epsilon_2 = "0,1" - "0,447" = -"0,347" "‰"$.
][
*Richtung:* $tan 2phi^* = gamma_(x y)\/(epsilon_x - epsilon_y) = -"0,8"\/(-"0,4") = 2$, $phi^* = "31,7"°$.
][
*Zuordnen:* $epsilon("31,7"°) = "0,1" - "0,2" cos "63,4"° - "0,4" sin "63,4"° = -"0,347" "‰"$. Bei $"31,7"°$ liegt also $epsilon_2$, und $epsilon_1$ bei $"121,7"°$.
]

#aufgabe(titel: "Hauptdehnungen aus drei Messwerten (Variante)", art: "rechnen", quelle: "TM2 3.1", herkunft: "variante", vorlage: "Altklausur 2018, Aufg. 2 k)", minuten: 6,
  ergebnis: [$epsilon_1 = "0,324" "‰"$ bei $"22,5"°$, $epsilon_2 = -"0,524" "‰"$],
)[
#if not web [*Aufgabe 198* #linebreak()]
*Gegeben und Annahmen*

$epsilon_x = "0,20" "‰"$, $epsilon_y = -"0,40" "‰"$, $gamma_(x y) = "0,60" "‰"$.

*Gesucht*

#enum(numbering: "a)",
[Hauptdehnungen und Richtung von $epsilon_1$.],
)
][
*Kreis:* Mittelpunkt $-"0,1" "‰"$, Radius $sqrt("0,3"^2 + "0,3"^2) = "0,424" "‰"$.
][
*Hauptdehnungen:* $epsilon_1 = "0,324" "‰"$, $epsilon_2 = -"0,524" "‰"$.
][
*Richtung:* $tan 2phi^* = "0,6"\/"0,6" = 1$, $phi^* = "22,5"°$. Einsetzen: $-"0,1" + "0,3" cos 45° + "0,3" sin 45° = "0,324"$, also liegt dort $epsilon_1$.
]

#aufgabe(titel: "DMS-Messung mit Musterlösung", art: "rechnen", quelle: "TM2 3.1", herkunft: "original", vorlage: "Altklausur PrüfungenTM2 S. 11 (DMS)", minuten: 8,
  ergebnis: [$epsilon_1 approx "0,44" "‰"$ (bei $-54°$), $epsilon_2 approx -"0,61" "‰"$ (bei $36°$)],
  tipp: [Zuerst Mittelpunkt und Radius. Dann mit dem Winkel einsetzen, um die Zuordnung zu sehen.],
)[
#if not web [*Aufgabe 199* #linebreak()]
*Altklausur mit Musterlösung (PrüfungenTM2.pdf S. 11):*

*Gegeben und Annahmen*

DMS-Messung: $epsilon_x = -"0,25" "‰"$, $epsilon_y = "0,075" "‰"$, $gamma_(x y) = -1 "‰"$.

*Gesucht*

#enum(numbering: "a)",
[Hauptdehnungen und Hauptrichtung.],
)
][
*Kreis:* Mittelpunkt $(-"0,25" + "0,075")\/2 = -"0,0875" "‰"$. Radius $sqrt("0,1625"^2 + "0,5"^2) = "0,526" "‰"$.
][
*Hauptdehnungen:* $epsilon_1 = "0,438" approx "0,44" "‰"$, $epsilon_2 = -"0,613" approx -"0,61" "‰"$.
][
*Richtung:* $tan 2phi^* = -1\/(-"0,325") = "3,08"$, $phi^* = "36,0"°$. Einsetzen gibt $-"0,613"$: dort liegt $epsilon_2$, $epsilon_1$ liegt senkrecht dazu bei $-54°$.
]

#aufgabe(titel: "DMS-Messung mit Musterlösung (Variante)", art: "rechnen", quelle: "TM2 3.1", herkunft: "variante", vorlage: "Altklausur PrüfungenTM2 S. 11 (DMS)", minuten: 6,
  ergebnis: [$epsilon_1 = "0,511" "‰"$ bei $"28,15"°$, $epsilon_2 = -"0,211" "‰"$],
)[
#if not web [*Aufgabe 200* #linebreak()]
*Gegeben und Annahmen*

$epsilon_x = "0,35" "‰"$, $epsilon_y = -"0,05" "‰"$, $gamma_(x y) = "0,6" "‰"$.

*Gesucht*

#enum(numbering: "a)",
[Hauptdehnungen und Hauptrichtung.],
)
][
*Kreis:* Mittelpunkt $"0,15" "‰"$, Radius $sqrt("0,2"^2 + "0,3"^2) = "0,361" "‰"$: $epsilon_1 = "0,511"$, $epsilon_2 = -"0,211" "‰"$.
][
*Richtung:* $tan 2phi^* = "0,6"\/"0,4" = "1,5"$, $phi^* = "28,15"°$; Einsetzen liefert $epsilon_1$.
]

#aufgabe(titel: "Dickenänderung trotz ebenem Spannungszustand", art: "verstehen", quelle: "TM2 3.2", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 201* #linebreak()]
Warum ist die dritte Dehnung trotz verschwindender dritter Spannung meist nicht null?
][
Durch die Querkontraktion wirken die Spannungen in x und y auch auf die Dicke des Blechs.
]

#aufgabe(titel: "Drei Hauptdehnungen aus Hauptspannungen", art: "rechnen", quelle: "TM2 3.2", herkunft: "original", vorlage: "Altklausur 2018, Aufg. 2 l)", minuten: 3,
  ergebnis: [$epsilon_1 = "0,37619" "‰"$, $epsilon_2 = -"0,24286" "‰"$, $epsilon_3 = -"0,05714" "‰"$],
  tipp: [Jede Dehnung: eigene Spannung minus $nu$ mal die beiden anderen, alles durch E.],
)[
#if not web [*Aufgabe 202* #linebreak()]
*Ältere Klausur SS 2018, S. 11:*

*Gegeben und Annahmen*

$sigma_1=70$, $sigma_2=-30 "N/mm"^2$, $sigma_3=0$, $E=210000 "N/mm"^2$, $nu="0,3"$.

*Gesucht*

#enum(numbering: "a)",
[Berechne die drei Hauptdehnungen.],
)
][
*Bild:* Zug in eine Richtung macht das Material dort länger und quer dazu schmaler. Jede Dehnung setzt sich deshalb aus der eigenen Spannung und der Querkontraktion durch die anderen zusammen.
][
*Erste Richtung:* $epsilon_1 = (sigma_1 - nu(sigma_2 + sigma_3))\/E = (70 + 9)\/210000 = "0,37619" "‰"$. Der Druck in Richtung 2 macht Richtung 1 zusätzlich länger.
][
*Zweite Richtung:* $epsilon_2 = (-30 - "0,3" dot 70)\/210000 = -51\/210000 = -"0,24286" "‰"$.
][
*Dritte Richtung:* $epsilon_3 = (0 - "0,3" dot (70 - 30))\/210000 = -12\/210000 = -"0,05714" "‰"$. Obwohl $sigma_3 = 0$, wird das Blech dünner.
][
*Prüfen:* N/mm² durch N/mm² ist dimensionslos. Die negative dritte Dehnung bedeutet Dickenabnahme, passend zur überwiegend auf Zug belasteten Ebene.
]

#aufgabe(titel: "Drei Hauptdehnungen aus Hauptspannungen (Variante)", art: "rechnen", quelle: "TM2 3.2", herkunft: "variante", vorlage: "Altklausur 2018, Aufg. 2 l)", minuten: 3,
  ergebnis: [$epsilon_1 = "0,486" "‰"$, $epsilon_2 = -"0,319" "‰"$, $epsilon_3 = -"0,071" "‰"$],
)[
#if not web [*Aufgabe 203* #linebreak()]
*Gegeben und Annahmen*

$sigma_1 = 90$, $sigma_2 = -40 "N/mm"^2$, $sigma_3 = 0$, $E = 210000 "N/mm"^2$, $nu = "0,3"$.

*Gesucht*

#enum(numbering: "a)",
[Die drei Hauptdehnungen.],
)
][
*Richtung 1:* $epsilon_1 = (90 + 12)\/210000 = "0,486" "‰"$.
][
*Richtung 2:* $epsilon_2 = (-40 - 27)\/210000 = -"0,319" "‰"$.
][
*Richtung 3:* $epsilon_3 = -"0,3" dot 50\/210000 = -"0,071" "‰"$.
]

#aufgabe(titel: "Verformungstensor am gezogenen Blechstreifen", art: "rechnen", quelle: "TM2 3.2", herkunft: "original", vorlage: "TM2-Übung 8, Aufg. 8.1", minuten: 12,
  ergebnis: [$epsilon_x = "0,476" dot 10^(-3)$, $epsilon_y = epsilon_z = -"0,143" dot 10^(-3)$, alle $gamma = 0$; $Delta l = "0,476" "mm"$, $Delta b = -"0,0143" "mm"$, $Delta t = -"0,143" dot 10^(-3) "mm"$; 45°: $epsilon_xi = "0,1665" dot 10^(-3)$, $gamma_(xi eta) = "0,619" dot 10^(-3)$],
  tipp: [Im Verzerrungskreis steht auf der senkrechten Achse $gamma\/2$. Unter 45° liest man den Mittelpunkt und den Radius ab.],
)[
#if not web [*Aufgabe 204* #linebreak()]
Wie in Aufgabe 5.1 wird ein Blechstreifen zwischen zwei Spannvorrichtungen eingespannt und durch eine Kraft $F$ belastet. Homogener Spannungs- und Verformungszustand.
#align(center)[#image(abbildungen.at("tm2k3_ue81"), width: 55%)]

*Gegeben und Annahmen*

$t = 1 "mm"$, $b = 100 "mm"$, $l = 1 "m"$, $F = 10 "kN"$, $E = "2,1" dot 10^5 "N/mm"^2$, $nu = "0,3"$. Aus 5.1: $sigma_x = 100 "N/mm"^2$, sonst keine Spannungen.

*Gesucht*

#enum(numbering: "a)",
[Dehnungen $epsilon_x$, $epsilon_y$, $epsilon_z$, Gleitungen und der Verformungstensor $V$.],
[Änderung von Länge, Breite und Dicke.],
[$epsilon_xi$ und $gamma_(xi eta)$ für $xi$ in $x$-Richtung, in $y$-Richtung und um 45° nach unten geneigt.],
)
][
*Elastizitätsgesetz:* $epsilon_x = sigma_x\/E = "0,476" dot 10^(-3)$. Quer dazu nur Querkontraktion: $epsilon_y = epsilon_z = -nu epsilon_x = -"0,143" dot 10^(-3)$. Ohne Schubspannung gibt es keine Gleitung.
][
*Tensor:* $V = mat(epsilon_x, 0, 0; 0, epsilon_y, 0; 0, 0, epsilon_z) = mat("0,476", 0, 0; 0, -"0,143", 0; 0, 0, -"0,143") dot 10^(-3)$.
][
*Längen:* $Delta l = epsilon_x l = "0,476" "mm"$, $Delta b = epsilon_y b = -"0,0143" "mm"$, $Delta t = epsilon_z t = -"0,143" dot 10^(-3) "mm"$.
][
*Richtungen x und y:* Dort ist $epsilon_xi = epsilon_x$ bzw. $epsilon_y$, und $gamma_(xi eta) = 0$, weil das schon die Hauptrichtungen sind.
][
*45°:* $epsilon_xi = (epsilon_x + epsilon_y)\/2 = "0,1665" dot 10^(-3)$. Die Gleitung ist maximal: $|gamma_(xi eta)| = epsilon_x - epsilon_y = "0,619" dot 10^(-3) "rad"$. Das Vorzeichen hängt davon ab, ob man nach oben oder nach unten dreht.
][
*Prüfen:* Der Verzerrungskreis hat Mittelpunkt $"0,1665" dot 10^(-3)$ und Radius $"0,3095" dot 10^(-3)$; $gamma\/2$ am höchsten Punkt ist gleich dem Radius.
]

#aufgabe(titel: "Verformungstensor am Blechstreifen (Variante)", art: "rechnen", quelle: "TM2 3.2", herkunft: "variante", vorlage: "TM2-Übung 8, Aufg. 8.1", minuten: 8,
  ergebnis: [$epsilon_x = "0,595" dot 10^(-3)$, $epsilon_y = epsilon_z = -"0,179" dot 10^(-3)$; $Delta l = "0,714" "mm"$; 45°: $epsilon_xi = "0,208" dot 10^(-3)$, $|gamma_(xi eta)| = "0,774" dot 10^(-3)$],
)[
#if not web [*Aufgabe 205* #linebreak()]
*Gegeben und Annahmen*

Blechstreifen wie in der Variante zu 5.1: $sigma_x = 125 "N/mm"^2$, $l = "1,2" "m"$, $E = "2,1" dot 10^5 "N/mm"^2$, $nu = "0,3"$.

*Gesucht*

#enum(numbering: "a)",
[$epsilon_x$, $epsilon_y$, $epsilon_z$ und $Delta l$.],
[$epsilon_xi$ und $gamma_(xi eta)$ unter 45°.],
)
][
*Dehnungen:* $epsilon_x = 125\/210000 = "0,595" dot 10^(-3)$, $epsilon_y = epsilon_z = -"0,3" epsilon_x = -"0,179" dot 10^(-3)$. $Delta l = epsilon_x dot 1200 = "0,714" "mm"$.
][
*45°:* $epsilon_xi = ("0,595" - "0,179")\/2 dot 10^(-3) = "0,208" dot 10^(-3)$, $|gamma_(xi eta)| = "0,595" + "0,179" = "0,774" dot 10^(-3)$.
]

#aufgabe(titel: "Hauptdehnungen zum Spannungszustand aus Aufgabe 6.2", art: "rechnen", quelle: "TM2 3.2", herkunft: "original", vorlage: "TM2-Übung 8, Aufg. 8.2", minuten: 12,
  ergebnis: [$epsilon_x = "0,401" dot 10^(-3)$, $epsilon_y = -"0,218" dot 10^(-3)$, $epsilon_z = -"0,079" dot 10^(-3)$, $gamma_(x y) = -"0,464" dot 10^(-3)$; $epsilon_1 = "0,478" dot 10^(-3)$ bei $-"18,43"°$, $epsilon_2 = -"0,295" dot 10^(-3)$ bei $"71,57"°$],
  tipp: [Erst Hookesches Gesetz, dann denselben Kreis wie bei Spannungen, nur mit $gamma\/2$ statt $tau$.],
)[
#if not web [*Aufgabe 206* #linebreak()]
Wie in Aufgabe 6.2 liegt in einem Bauteil ein allgemeiner ebener Spannungszustand vor.

*Gegeben und Annahmen*

$sigma_x = "77,5"$, $sigma_y = -"22,5"$, $tau_(x y) = -"37,5" thin "N/mm"^2$; $E = "2,1" dot 10^5 "N/mm"^2$, $nu = "0,3"$, $G = E\/(2(1 + nu)) = 80769 "N/mm"^2$.

*Gesucht*

#enum(numbering: "a)",
[Dehnungen und Gleitungen $epsilon_x$, $epsilon_y$, $gamma_(x y)$ (sowie $epsilon_z$, $gamma_(x z)$, $gamma_(y z)$).],
[Hauptdehnungen und Winkel der Hauptdehnungsebenen; Vergleich mit den Hauptspannungsrichtungen aus 6.2.],
)
][
*Hookesches Gesetz:* $epsilon_x = ("77,5" + "0,3" dot "22,5")\/E = "0,401" dot 10^(-3)$, $epsilon_y = (-"22,5" - "0,3" dot "77,5")\/E = -"0,218" dot 10^(-3)$, $epsilon_z = -"0,3" dot 55\/E = -"0,079" dot 10^(-3)$.
][
*Gleitung:* $gamma_(x y) = tau_(x y)\/G = -"37,5"\/80769 = -"0,464" dot 10^(-3)$. Ohne Schub aus der Ebene sind $gamma_(x z) = gamma_(y z) = 0$.
][
*Kreis:* Mittelpunkt $"0,0917" dot 10^(-3)$, Radius $sqrt("0,3095"^2 + "0,232"^2) dot 10^(-3) = "0,387" dot 10^(-3)$. Also $epsilon_1 = "0,478" dot 10^(-3)$, $epsilon_2 = -"0,295" dot 10^(-3)$.
][
*Richtung:* $tan 2phi^* = gamma_(x y)\/(epsilon_x - epsilon_y) = -"0,75"$, also $phi^* = -"18,43"°$; Einsetzen gibt $epsilon_1$. $epsilon_2$ liegt bei $"71,57"°$.
][
*Vergleich:* Das ist genau die Richtung von $sigma_1$ aus 6.2. Bei isotropem Material fallen Hauptspannungs- und Hauptdehnungsrichtungen zusammen.
]

#aufgabe(titel: "Hauptdehnungen aus einem Spannungszustand (Variante)", art: "rechnen", quelle: "TM2 3.2", herkunft: "variante", vorlage: "TM2-Übung 8, Aufg. 8.2", minuten: 10,
  ergebnis: [$epsilon_x = "0,233" dot 10^(-3)$, $epsilon_y = -"0,200" dot 10^(-3)$, $epsilon_z = -"0,014" dot 10^(-3)$, $gamma_(x y) = "0,310" dot 10^(-3)$; $epsilon_1 = "0,283" dot 10^(-3)$ bei $"17,77"°$, $epsilon_2 = -"0,250" dot 10^(-3)$],
)[
#if not web [*Aufgabe 207* #linebreak()]
*Gegeben und Annahmen*

$sigma_x = 40$, $sigma_y = -30$, $tau_(x y) = 25 thin "N/mm"^2$; $E = "2,1" dot 10^5 "N/mm"^2$, $nu = "0,3"$.

*Gesucht*

#enum(numbering: "a)",
[$epsilon_x$, $epsilon_y$, $epsilon_z$, $gamma_(x y)$.],
[Hauptdehnungen und Richtung.],
)
][
*Hooke:* $epsilon_x = (40 + 9)\/E = "0,233" dot 10^(-3)$, $epsilon_y = (-30 - 12)\/E = -"0,200" dot 10^(-3)$, $epsilon_z = -"0,3" dot 10\/E = -"0,014" dot 10^(-3)$, $gamma_(x y) = 25\/80769 = "0,310" dot 10^(-3)$.
][
*Kreis:* Mittelpunkt $"0,0167" dot 10^(-3)$, Radius $sqrt("0,2167"^2 + "0,155"^2) dot 10^(-3) = "0,266" dot 10^(-3)$: $epsilon_1 = "0,283" dot 10^(-3)$, $epsilon_2 = -"0,250" dot 10^(-3)$.
][
*Richtung:* $tan 2phi^* = "0,310"\/"0,433" = "0,714"$, $phi^* = "17,77"°$, dort liegt $epsilon_1$.
][
*Prüfen:* Die Hauptspannungen sind $"48,01"$ und $-"38,01" "N/mm"^2$. $("48,01" + "0,3" dot "38,01")\/E = "0,283" dot 10^(-3)$ bestätigt $epsilon_1$.
]

#aufgabe(titel: "Allseitig behinderter Quader unter Erwärmung", art: "rechnen", quelle: "TM2 3.2", herkunft: "original", vorlage: "TM2-Übung 9, Aufg. 9.3", minuten: 12,
  ergebnis: [$sigma_x = sigma_y = sigma_z = -630 "N/mm"^2$, $F = 1008 "kN"$],
  tipp: [Alle drei Dehnungen müssen null sein. Wegen der Symmetrie sind $sigma_x = sigma_y$; setze das in die Gleichung für $epsilon_z$ ein.],
)[
#if not web [*Aufgabe 208* #linebreak()]
Ein Stahlquader mit quadratischer Grundfläche passt im unbelasteten Zustand genau in einen Hohlraum mit starren Wänden. Zwischen Quader und Seitenflächen tritt keine Reibung auf. Der Quader wird gleichmäßig erwärmt und gleichzeitig durch eine Kraft $F$ belastet, die gleichmäßig an der Deckfläche verteilt ist. Wie groß muss $F$ sein, damit sich der Quader in $z$-Richtung nicht ausdehnt?
#align(center)[#image(abbildungen.at("tm2k3_ue93"), width: 35%)]

*Gegeben und Annahmen*

$h = 60 "mm"$, $a times a = 40 times 40 "mm"$, $E = "2,1" dot 10^5 "N/mm"^2$, $nu = "0,3"$, $alpha_T = "1,2" dot 10^(-5) 1\/"°C"$, $Delta T = 100 "°C"$.

*Gesucht*

#enum(numbering: "a)",
[Spannungen im Quader und die Kraft $F$.],
)
][
*Bedingungen:* Starre Wände und $z$ fest: $epsilon_x = epsilon_y = epsilon_z = 0$. Ohne Reibung gibt es keine Gleitungen.
][
*Elastizitätsgesetz mit Wärme:* $epsilon_x = (sigma_x - nu(sigma_y + sigma_z))\/E + alpha_T Delta T = 0$, ebenso zyklisch für $y$ und $z$.
][
*Symmetrie:* Gleichung $x$ minus Gleichung $y$ gibt $(1 + nu)(sigma_x - sigma_y) = 0$, also $sigma_x = sigma_y$. Weil alle drei Richtungen gleich behindert sind, folgt ebenso $sigma_z = sigma_x$.
][
*Spannung:* $sigma (1 - 2nu)\/E = -alpha_T Delta T$, also $sigma = -E alpha_T Delta T\/(1 - 2nu) = -210000 dot "1,2" dot 10^(-3)\/"0,4" = -630 "N/mm"^2$.
][
*Kraft:* $F = |sigma_z| a^2 = 630 dot 1600 = 1008 "kN"$.
][
*Prüfen:* Der Faktor $1\/(1 - 2nu) = "2,5"$ zeigt, wie stark die Querbehinderung die Spannung erhöht. Bei freien Seitenwänden wären es nur $E alpha_T Delta T = 252 "N/mm"^2$.
]

#aufgabe(titel: "Aluminiumquader in starrem Hohlraum (Variante)", art: "rechnen", quelle: "TM2 3.2", herkunft: "variante", vorlage: "TM2-Übung 9, Aufg. 9.3", minuten: 8,
  ergebnis: [$sigma = -"378,8" "N/mm"^2$, $F = "340,9" "kN"$],
)[
#if not web [*Aufgabe 209* #linebreak()]
*Gegeben und Annahmen*

Aufbau wie in Übung 9.3, aber Aluminiumquader mit $a times a = 30 times 30 "mm"$, $E = 70000 "N/mm"^2$, $nu = "0,33"$, $alpha_T = "2,3" dot 10^(-5) 1\/"°C"$, $Delta T = 80 "°C"$. Reibungsfreie starre Wände.

*Gesucht*

#enum(numbering: "a)",
[Kraft $F$, damit sich der Quader in $z$-Richtung nicht ausdehnt.],
)
][
*Ansatz:* Alle Dehnungen null, also $sigma_x = sigma_y = sigma_z = -E alpha_T Delta T\/(1 - 2nu)$.
][
*Zahlen:* $sigma = -70000 dot "1,84" dot 10^(-3)\/"0,34" = -"378,8" "N/mm"^2$, $F = "378,8" dot 900 = "340,9" "kN"$.
]

#aufgabe(titel: "Hauptdehnungen, Hauptspannungen und Dickenänderung (SS 16)", art: "rechnen", quelle: "TM2 3.2", herkunft: "original", vorlage: "Altklausur SS 16 (PrüfungenTM2 S. 13, Dehnungen)", minuten: 12,
  ergebnis: [a) $epsilon_1 = "0,615" "‰"$, $epsilon_2 = -"0,415" "‰"$, $phi^* = "30,5"°$ (Richtung von $epsilon_2$); b) $sigma_1 = "110,8"$, $sigma_2 = -"50,8" thin "N/mm"^2$, $epsilon_3 = -"0,086" "‰"$],
  tipp: [Für b) gilt im ebenen Spannungszustand $sigma_1 = E\/(1 - nu^2)(epsilon_1 + nu epsilon_2)$ und $epsilon_3 = -nu\/(1 - nu)(epsilon_1 + epsilon_2)$.],
)[
#if not web [*Aufgabe 210* #linebreak()]
*Altklausur SS 2016, Musterlösung (PrüfungenTM2.pdf S. 13):*

*Gegeben und Annahmen*

a) $epsilon_x = -"0,15" "‰"$, $epsilon_y = "0,35" "‰"$, $gamma_(x y) = -"0,9" "‰"$. b) $epsilon_1 = "0,6" "‰"$, $epsilon_2 = -"0,4" "‰"$, $E = "2,1" dot 10^5 "N/mm"^2$, $nu = "0,3"$, ebener Spannungszustand.

*Gesucht*

#enum(numbering: "a)",
[Hauptdehnungen und Richtung.],
[Hauptspannungen und $epsilon_3$.],
)
][
*Kreis:* Mittelpunkt $"0,1" "‰"$, Radius $sqrt("0,25"^2 + "0,45"^2) = "0,515" "‰"$. Also $epsilon_1 = "0,615"$, $epsilon_2 = -"0,415" "‰"$.
][
*Richtung:* $tan 2phi^* = -"0,9"\/(-"0,5") = "1,8"$, $phi^* = "30,5"°$. Einsetzen gibt $-"0,415"$: Dort liegt $epsilon_2$.
][
*Hauptspannungen:* $E\/(1 - nu^2) = 230769 "N/mm"^2$. $sigma_1 = 230769 ("0,6" - "0,12") dot 10^(-3) = "110,8"$, $sigma_2 = 230769(-"0,4" + "0,18") dot 10^(-3) = -"50,8" "N/mm"^2$.
][
*Dickenrichtung:* $sigma_3 = 0$ heißt nicht $epsilon_3 = 0$: $epsilon_3 = -nu(sigma_1 + sigma_2)\/E = -"0,3" dot 60\/210000 = -"0,086" "‰"$, gleich $-nu\/(1 - nu)(epsilon_1 + epsilon_2)$.
]

#aufgabe(titel: "Hauptdehnungen, Hauptspannungen und Dickenänderung (Variante)", art: "rechnen", quelle: "TM2 3.2", herkunft: "variante", vorlage: "Altklausur SS 16 (PrüfungenTM2 S. 13, Dehnungen)", minuten: 10,
  ergebnis: [a) $epsilon_1 = "0,497" "‰"$ bei $"31,7"°$, $epsilon_2 = -"0,397" "‰"$; b) $sigma_1 = "101,5"$, $sigma_2 = -"11,5" thin "N/mm"^2$, $epsilon_3 = -"0,129" "‰"$],
)[
#if not web [*Aufgabe 211* #linebreak()]
*Gegeben und Annahmen*

a) $epsilon_x = "0,25" "‰"$, $epsilon_y = -"0,15" "‰"$, $gamma_(x y) = "0,8" "‰"$. b) $epsilon_1 = "0,5" "‰"$, $epsilon_2 = -"0,2" "‰"$, $E = "2,1" dot 10^5 "N/mm"^2$, $nu = "0,3"$.

*Gesucht*

#enum(numbering: "a)",
[Hauptdehnungen und Richtung.],
[Hauptspannungen und $epsilon_3$.],
)
][
*Kreis:* Mittelpunkt $"0,05"$, Radius $sqrt("0,2"^2 + "0,4"^2) = "0,447" "‰"$: $epsilon_1 = "0,497"$, $epsilon_2 = -"0,397" "‰"$. $tan 2phi^* = 2$, $phi^* = "31,7"°$; Einsetzen gibt $epsilon_1$.
][
*Spannungen:* $sigma_1 = 230769 ("0,5" - "0,06") dot 10^(-3) = "101,5"$, $sigma_2 = 230769 (-"0,2" + "0,15") dot 10^(-3) = -"11,5" "N/mm"^2$.
][
*Dicke:* $epsilon_3 = -"0,3"\/"0,7" dot "0,3" = -"0,129" "‰"$.
]

#aufgabe(titel: "Wozu dient eine DMS-Rosette mit 0°, 45° und 90°?", art: "verstehen", quelle: "TM2 3.3", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 212* #linebreak()]
Wozu dient eine DMS-Rosette mit 0°, 45° und 90°?
][
*Antwort:*
- Ein Dehnungsmessstreifen misst nur die Dehnung in seiner Richtung.
- Mit drei Richtungen kann man $epsilon_x$, $epsilon_y$ und $gamma_(x y)$ bestimmen.
- Daraus folgen die Hauptdehnungen und mit Hooke die Spannungen.
#align(center)[#image(abbildungen.at("tm2k3_dms_anordnung"), width: 60%)]
]

#aufgabe(titel: "Liegen Hauptspannungs- und Hauptdehnungsrichtungen gleich?", art: "verstehen", quelle: "TM2 3.3", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 213* #linebreak()]
Liegen Hauptspannungs- und Hauptdehnungsrichtungen gleich?
][
*Antwort:*
- Bei isotropem Material ja.
- Ohne Schubspannung gibt es keine Gleitung, also sind die Richtungen ohne Schub in beiden Fällen dieselben.
#align(center)[#image(abbildungen.at("tm2k3_dms_anordnung"), width: 60%)]
]

#aufgabe(titel: "Gleitung aus einer 0°/45°/90°-Rosette", art: "verstehen", quelle: "TM2 3.3", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 214* #linebreak()]
Bei einer 0°/45°/90°-Rosette misst Du $epsilon_0$, $epsilon_45$ und $epsilon_90$. Wie bestimmst Du die Gleitung?
][
*Antwort:* $gamma_(x y) = 2 epsilon_45 - epsilon_0 - epsilon_90$. Aus $epsilon_45 = (epsilon_x + epsilon_y)\/2 + gamma\/2$ folgt diese Formel durch Umstellen.
][
*Typische Verwechslung:* $gamma_(x y) = epsilon_45$: Der 45°-DMS enthält auch Anteile von $epsilon_x$ und $epsilon_y$, die man abziehen muss.
]

#aufgabe(titel: "DMS-Rosette unter 0°, 45° und 90°", art: "rechnen", quelle: "TM2 3.3", herkunft: "original", vorlage: "TM2-Übung 8, Aufg. 8.3", minuten: 15,
  ergebnis: [$gamma_(x y) = "1,94" dot 10^(-3)$; $epsilon_1 = "1,643" dot 10^(-3)$, $sigma_1 = "315,3" "N/mm"^2$ (bei $"65,45"°$); $epsilon_2 = -"0,923" dot 10^(-3)$, $sigma_2 = -"99,3" "N/mm"^2$ (bei $-"24,55"°$)],
  tipp: [Streifen a misst $epsilon_x$, c misst $epsilon_y$. Der 45°-Streifen b liefert $gamma_(x y) = 2 epsilon_b - epsilon_a - epsilon_c$.],
)[
#if not web [*Aufgabe 215* #linebreak()]
Bei der experimentellen Spannungsanalyse werden an der Oberfläche eines Körpers mit einer DMS-Rosette die Dehnungen in drei Richtungen a, b und c gemessen. Bestimmen Sie Betrag und Richtung der Hauptdehnungen und Hauptspannungen.
#align(center)[#image(abbildungen.at("tm2k3_ue83"), width: 40%)]

*Gegeben und Annahmen*

$epsilon_a = -"0,048" %$ (in $x$), $epsilon_b = "0,133" %$ (unter 45°), $epsilon_c = "0,120" %$ (in $y$). $E = "2,1" dot 10^5 "N/mm"^2$, $nu = "0,3"$, ebener Spannungszustand an der Oberfläche.

*Gesucht*

#enum(numbering: "a)",
[Hauptdehnungen mit Richtungen.],
[Hauptspannungen.],
)
][
*Gleitung:* Aus $epsilon_xi(45°) = (epsilon_x + epsilon_y)\/2 + gamma_(x y)\/2$ folgt $gamma_(x y) = 2 dot "1,33" - (-"0,48" + "1,20") = "1,94"$ (alles in $10^(-3)$).
][
*Richtung:* $tan 2phi^* = gamma_(x y)\/(epsilon_x - epsilon_y) = "1,94"\/(-"1,68")$, also $phi^* = -"24,55"°$.
][
*Hauptdehnungen:* Einsetzen bei $phi^*$: $epsilon_xi = "0,36" - "0,84" cos(-"49,1"°) + "0,97" sin(-"49,1"°) = -"0,923" dot 10^(-3) = epsilon_2$. Die andere: $epsilon_1 = 2 dot "0,36" + "0,923" = "1,643" dot 10^(-3)$ bei $-"24,55"° + 90° = "65,45"°$.
][
*Hauptspannungen:* $E\/(1 - nu^2) = 230769 "N/mm"^2$. $sigma_1 = 230769 ("1,643" - "0,3" dot "0,923") dot 10^(-3) = "315,3" "N/mm"^2$, $sigma_2 = 230769 (-"0,923" + "0,3" dot "1,643") dot 10^(-3) = -"99,3" "N/mm"^2$.
][
*Prüfen:* $epsilon_1 + epsilon_2 = "0,72" = epsilon_a + epsilon_c$. Die Hauptspannungen liegen in denselben Richtungen wie die Hauptdehnungen.
]

#aufgabe(titel: "DMS-Rosette auswerten", art: "rechnen", quelle: "TM2 3.3", herkunft: "variante", vorlage: "TM2-Übung 8, Aufg. 8.3", minuten: 12,
  ergebnis: [$gamma = "1,0" "‰"$, $epsilon_1 = "0,77134" "‰"$, $epsilon_2 = -"0,42134" "‰"$, Richtung $"28,49"°$, $sigma_1 approx "148,83"$, $sigma_2 approx -"43,83" thin "N/mm"^2$],
  tipp: [Bei der 0-45-90-Rosette gilt $gamma_(x y) = 2epsilon_45 - epsilon_0 - epsilon_90$. Im Kreis steht $gamma\/2$ auf der senkrechten Achse.],
)[
#if not web [*Aufgabe 216* #linebreak()]
*WZF-Rosette, Zahlen passend zu Beispiel 1 (eigene bereinigte Aufbereitung):*

*Gegeben und Annahmen*

$epsilon_0="0,5" "‰"$, $epsilon_45="0,675" "‰"$, $epsilon_90=-"0,15" "‰"$. Für die Spannungen: $E=210000 thin "N/mm"^2$, $nu="0,3"$; ebener Spannungszustand, isotrop und linear elastisch, kein Temperaturanteil.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $epsilon_x$, $epsilon_y$, $gamma_(x y)$, Hauptdehnungen, die Richtung von $epsilon_1$ sowie die Hauptspannungen mit $E=210000 "N/mm"^2$, $nu="0,3"$.],
)
][
*Messwerte deuten:* Der 0°-Streifen misst direkt $epsilon_x = "0,5" "‰"$, der 90°-Streifen $epsilon_y = -"0,15" "‰"$. Der 45°-Streifen enthält zusätzlich die Gleitung: $gamma = 2 dot "0,675" - "0,5" + "0,15" = "1,0" "‰"$.
][
*Kreis:* Mittelpunkt $(epsilon_x + epsilon_y)\/2 = "0,175" "‰"$. Radius $sqrt("0,325"^2 + "0,5"^2) = "0,59634" "‰"$; senkrecht steht $gamma\/2 = "0,5"$, nicht $gamma$.
][
*Hauptdehnungen und Richtung:* $epsilon_1 = "0,175" + "0,59634" = "0,77134" "‰"$, $epsilon_2 = "0,175" - "0,59634" = -"0,42134" "‰"$. Aus $tan 2phi = gamma\/(epsilon_x - epsilon_y) = 1\/"0,65"$ folgt $phi = "28,49"°$.
][
*Spannungen:* Im ebenen Spannungszustand gilt $sigma_1 = E\/(1-nu^2) dot (epsilon_1 + nu epsilon_2)$. Mit Dehnungen als reine Zahlen ($"‰" = 10^(-3)$): $sigma_1 = 230769 dot "0,64494" dot 10^(-3) approx "148,83" thin "N/mm"^2$, entsprechend $sigma_2 approx -"43,83" thin "N/mm"^2$.
][
*Prüfen:* $epsilon_1 + epsilon_2 = "0,35" "‰" = epsilon_x + epsilon_y$. Die WZF-Mitschrift S. 6 nennt einmal 0,1675 ‰; das passt nicht zur dortigen Gleitung. Hier wird die passend bezeichnete Rosette mit 0,675 ‰ verwendet.
]

#kapitel("TM2 Kapitel 4 · Biegung, FTM und Biegelinie")

#aufgabe(titel: "Einheiten von I und W", art: "verstehen", quelle: "TM2 4.2", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 217* #linebreak()]
Warum haben Flächenträgheitsmomente die Einheit mm⁴ und Widerstandsmomente mm³?
][
I enthält Fläche mal Abstand², also mm²·mm². W=I/Randabstand hat mm³.
]

#aufgabe(titel: "Wie ist die Biegespannung über den Querschnitt verteilt?", art: "verstehen", quelle: "TM2 4.2", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 218* #linebreak()]
Wie ist die Biegespannung über den Querschnitt verteilt?
][
*Antwort:*
- *Linear:* null in der neutralen Faser, die durch den Schwerpunkt geht, und am größten am Rand.
- Auf einer Seite herrscht Zug, auf der anderen Druck:
$ sigma = M/I z $
#align(center)[#image(abbildungen.at("tm2k4_spannungsverlauf"), width: 60%)]
][
*Merksatz:* Neutrale Faser null, am Rand maximal.
][
*Bild:* Biegt man einen Schaumstoffbalken, wird die eine Seite länger, die andere kürzer, und in der Mitte bleibt eine Linie gleich lang.
]

#aufgabe(titel: "Was ist das Widerstandsmoment, und welcher Rand ist maßgebend?", art: "verstehen", quelle: "TM2 4.2", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 219* #linebreak()]
Was ist das Widerstandsmoment, und welcher Rand ist maßgebend?
][
*Antwort:*
- $W = I\/z_max$.
- Es verknüpft direkt Moment und größte Randspannung:
- $ sigma_max = M/W $ Maßgebend ist der Rand mit dem größten Abstand vom Schwerpunkt.
- Bei unsymmetrischen Profilen sind beide Ränder unterschiedlich weit weg.
#align(center)[#image(abbildungen.at("tm2k4_spannungsverlauf"), width: 60%)]
]

#aufgabe(titel: "Größte Biegespannung an der Einspannung", art: "rechnen", quelle: "TM2 4.2", herkunft: "original", vorlage: "Altklausur SS 24, Aufg. 2 (Biegespannung)", minuten: 6,
  ergebnis: [$abs(sigma_("max")) approx "20,416" thin "N/mm"^2$ am oberen Rand an der Einspannung],
  tipp: [Die größte Spannung sitzt am Rand, der am weitesten von der Schwerachse entfernt ist.],
)[
#if not web [*Aufgabe 220* #linebreak()]
*AK24 S. 24, eigene Nachrechnung mit den gedruckten Daten:*

*Gegeben und Annahmen*

Verwende $X="188,929" "N"$, $l=1000 "mm"$, $I=10^6 "mm"^4$. Randkoordinaten relativ zum Hilfsursprung: oben −50 mm, unten +150 mm; Schwerpunkt $z'_S="58,061096" thin "mm"$. Der links eingespannte Kragarm wird am freien Ende allein durch X belastet. Der vorgegebene I-Wert dieser Aufgabe bleibt maßgebend.

*Gesucht*

#enum(numbering: "a)",
[Bestimme den maximalen Betrag der Biegespannung am Querschnitt aus der Aufgabe „Schwerpunkt und Steiner am zusammengesetzten Querschnitt“.],
)
][
*Bild:* Beim Biegen ist die Schwerachse spannungsfrei, nach außen wächst die Spannung linear. Es zählt also der größere der beiden Randabstände.
][
*Randabstände:* Der obere Rand liegt bei $z' = -50 thin "mm"$, der untere bei $150 thin "mm"$. Vom Schwerpunkt 58,061 mm aus sind das oben $108,061 thin "mm"$ und unten $91,939 thin "mm"$. Oben ist weiter weg.
][
*Größtes Moment:* Beim Kragarm mit Endkraft sitzt es an der Einspannung: $abs(M_A) = X l = "188929,15" thin "Nmm"$.
][
*Spannung:* $abs(sigma_("max")) = abs(M_A)\/I dot abs(z_("oben")) = "188929,15" dot "108,061"\/10^6 approx "20,416" thin "N/mm"^2$, gerechnet mit dem in der Aufgabe gedruckten I.
][
*Prüfen:* Nmm mal mm durch mm⁴ ergibt N/mm². Die auf AK24 S. 24 berechnete Spannung beruht auf dem dort falschen X und einem nicht passenden Randabstand.
]

#aufgabe(titel: "Größte Biegespannung an der Einspannung (Variante)", art: "rechnen", quelle: "TM2 4.2", herkunft: "variante", vorlage: "Altklausur SS 24, Aufg. 2 (Biegespannung)", minuten: 5,
  ergebnis: [$|sigma_("max")| = "4,29" "N/mm"^2$ am oberen Rand an der Einspannung],
)[
#if not web [*Aufgabe 221* #linebreak()]
*Gegeben und Annahmen*

Kragarm $l = 800 "mm"$, Endkraft $X = 250 "N"$. Querschnitt aus der Variante zum AK24-Querschnitt: $z'_S = "46,45" "mm"$, $I_y = 4027650 "mm"^4$, oberer Rand $z' = -40$, unterer Rand $z' = 120 "mm"$.

*Gesucht*

#enum(numbering: "a)",
[Größte Biegespannung.],
)
][
*Randabstände:* oben $40 + "46,45" = "86,45" "mm"$, unten $120 - "46,45" = "73,55" "mm"$: oben ist maßgebend.
][
*Moment:* $|M_A| = X l = 200000 "Nmm"$.
][
*Spannung:* $sigma = 200000 dot "86,45"\/4027650 = "4,29" "N/mm"^2$.
]

#aufgabe(titel: "Kragträger mit dünnwandigem Hutprofil", art: "rechnen", quelle: "TM2 4.2", herkunft: "original", vorlage: "TM2-Übung 9, Aufg. 9.1", minuten: 12,
  ergebnis: [a) $z_S = a$ unter der Oberkante; b) $I_y = 16\/3 dot a^3 t$; c) $sigma_("max") = "7,5" F\/(a t)$ an der Einspannung, $z = plus.minus a$; d) $overline(tau) = F\/(8 a t) = sigma_("max")\/60$],
  tipp: [Dünnwandig: Ein waagrechtes Blech hat praktisch keinen Eigenanteil, nur Steiner. Ein senkrechtes Blech der Höhe $h$ hat $t h^3\/12$.],
)[
#if not web [*Aufgabe 222* #linebreak()]
Ein einseitig eingespannter Balken wird an seinem rechten Ende mit der Kraft $F$ belastet. Die Wanddicke $t$ ist sehr klein gegenüber den sonstigen Abmessungen, Ausdrücke wie $a + t$ dürfen durch $a$ ersetzt werden.
#align(center)[#image(abbildungen.at("tm2k4_ue91"), width: 85%)]

*Gegeben und Annahmen*

Länge $40 a$, Hutquerschnitt: Deckblech $2a$, zwei Stege der Höhe $2a$, zwei Fußbleche der Breite $a$, überall Wanddicke $t$. $z$ nach unten.

*Gesucht*

#enum(numbering: "a)",
[Lage des Flächenschwerpunkts.],
[Flächenträgheitsmoment um die $y$-Achse (dünnwandig, wo zulässig).],
[Größte Biegespannung und ihr Ort.],
[Vergleichsweise die mittlere Schubspannung $overline(tau)$.],
)
][
*Schwerpunkt:* Von der Oberkante aus: Deckblech $2 a t$ bei $z = 0$, Stege $4 a t$ bei $z = a$, Fußbleche $2 a t$ bei $z = 2a$. $z_S = (0 + 4a^2 t + 4a^2 t)\/(8 a t) = a$. Wegen der Symmetrie liegt $S$ auf der Mittellinie.
][
*Trägheitsmoment:* Deckblech nur Steiner $2at dot a^2$; Stege Eigenanteil $2 dot t(2a)^3\/12 = 4\/3 a^3 t$, Steiner null; Fußbleche $2 a t dot a^2$. Zusammen $I_y = (2 + 4\/3 + 2) a^3 t = 16\/3 dot a^3 t$.
][
*Größte Spannung:* Das Moment ist an der Einspannung am größten: $|M| = 40 F a$. Beide Ränder liegen $a$ von $S$ entfernt: $sigma_("max") = 40 F a dot a\/(16\/3 a^3 t) = "7,5" F\/(a t)$, oben Zug, unten Druck.
][
*Schub:* $overline(tau) = Q\/A = F\/(8 a t)$. Das ist $1\/60$ von $sigma_("max")$: Bei langen Balken entscheidet die Biegung.
]

#aufgabe(titel: "Kragträger mit höherem Hutprofil (Variante)", art: "rechnen", quelle: "TM2 4.2", herkunft: "variante", vorlage: "TM2-Übung 9, Aufg. 9.1", minuten: 10,
  ergebnis: [$z_S = "1,5" a$; $I_y = "13,5" a^3 t$; $sigma_("max") = "3,33" F\/(a t)$; $overline(tau) = F\/(10 a t) = sigma_("max")\/"33,3"$],
)[
#if not web [*Aufgabe 223* #linebreak()]
*Gegeben und Annahmen*

Kragträger der Länge $30 a$ mit Endkraft $F$. Dünnwandiges Hutprofil (Wanddicke $t$): Deckblech $2a$, Stege der Höhe $3a$, Fußbleche je $a$.

*Gesucht*

#enum(numbering: "a)",
[Schwerpunkt und $I_y$.],
[$sigma_("max")$ und $overline(tau)$.],
)
][
*Schwerpunkt:* $A = (2 + 6 + 2) a t = 10 a t$. $z_S = (6 dot "1,5" + 2 dot 3) a^2 t\/(10 a t) = "1,5" a$, genau in halber Höhe.
][
*Trägheitsmoment:* Deckblech $2 a t ("1,5" a)^2 = "4,5" a^3 t$, Stege $2 t (3a)^3\/12 = "4,5" a^3 t$, Fußbleche $"4,5" a^3 t$. $I_y = "13,5" a^3 t$.
][
*Spannungen:* $|M| = 30 F a$, $z_("max") = "1,5" a$: $sigma_("max") = 30 dot "1,5"\/"13,5" dot F\/(a t) = "3,33" F\/(a t)$. $overline(tau) = F\/(10 a t)$.
]

#aufgabe(titel: "Stahlstange mit zwei Kräften bemessen", art: "rechnen", quelle: "TM2 4.2", herkunft: "original", vorlage: "TM2-Übung 9, Aufg. 9.2", minuten: 15,
  ergebnis: [$F_A = "1,2"$, $F_B = "6,8" "kN"$; $M = "2,16"$ und $-"2,4" "kNm"$; a) $r = "2,94" "cm"$; b) $R = "3,24" "cm"$, $r_i = "2,30" "cm"$; c) $"39,7" %$ Ersparnis; d) $overline(tau) = "1,4"$ bzw. $"2,32" "N/mm"^2$],
  tipp: [Bemessen wird mit dem Betrag des größten Moments. Beim Hohlkreis ist $W = pi (R^4 - r_i^4)\/(4R)$.],
)[
#if not web [*Aufgabe 224* #linebreak()]
Eine Stahlstange trägt zwei Kräfte. Bestimmen Sie punktweise den Querkraft- und Biegemomentverlauf und bemessen Sie dann den Querschnitt (nur Biegemoment berücksichtigen).
#align(center)[#image(abbildungen.at("tm2k4_ue92"), width: 60%)]

*Gegeben und Annahmen*

Festlager $A$ bei $x = 0$, $5 "kN"$ bei $"1,8" "m"$, Loslager $B$ bei $"3,0" "m"$, $3 "kN"$ am Ende bei $"3,8" "m"$; $sigma_("zul") = 12 "kN/cm"^2$.

*Gesucht*

#enum(numbering: "a)",
[Q- und M-Verlauf punktweise; Radius für eine Vollkreisfläche.],
[Hohlkreis mit 10 % größerem Außendurchmesser als in a): Innenradius.],
[Material- bzw. Gewichtsersparnis von b) gegenüber a).],
[Mittlere Schubspannung für a) und b) im Vergleich zu $sigma_("max")$.],
)
][
*Lager:* $sum M_A = 0$: $F_B dot 3 = 5 dot "1,8" + 3 dot "3,8"$, also $F_B = "6,8" "kN"$ und $F_A = 8 - "6,8" = "1,2" "kN"$.
][
*Verläufe:* $Q = "1,2"$, dann $-"3,8"$, hinter $B$ $+3 "kN"$. $M = 0$; $"1,2" dot "1,8" = "2,16" "kNm"$ unter der 5-kN-Last; $M_B = -3 dot "0,8" = -"2,4" "kNm"$; am Ende 0. Maßgebend ist $|M| = "2,4" "kNm"$.
][
*Vollkreis:* $W = M\/sigma_("zul") = 240 "kNcm"\/12 = 20 "cm"^3 = pi r^3\/4$, also $r = "2,94" "cm"$.
][
*Hohlkreis:* $R = "1,1" r = "3,24" "cm"$. Aus $pi(R^4 - r_i^4)\/(4R) = 20$ folgt $r_i^4 = R^4 - 80 R\/pi = "27,3"$, $r_i = "2,30" "cm"$.
][
*Ersparnis:* $A_a = pi "2,94"^2 = "27,15" "cm"^2$, $A_b = pi("3,24"^2 - "2,30"^2) = "16,36" "cm"^2$: $"39,7" %$ weniger Material.
][
*Schub:* Mit $|Q|_("max") = "3,8" "kN"$: $overline(tau)_a = 3800\/2715 = "1,4"$, $overline(tau)_b = 3800\/1636 = "2,32" "N/mm"^2$. Beides ist winzig gegen $sigma_("max") = 120 "N/mm"^2$.
]

#aufgabe(titel: "Stange mit Kragende bemessen (Variante)", art: "rechnen", quelle: "TM2 4.2", herkunft: "variante", vorlage: "TM2-Übung 9, Aufg. 9.2", minuten: 12,
  ergebnis: [$F_A = "0,67"$, $F_B = "5,33" "kN"$; $|M|_("max") = 2 "kNm"$ bei $B$; $r = "2,77" "cm"$; $R = "3,05" "cm"$, $r_i = "2,15" "cm"$; Ersparnis $"39,3" %$],
)[
#if not web [*Aufgabe 225* #linebreak()]
*Gegeben und Annahmen*

Festlager $A$ bei $0$, $4 "kN"$ bei $"2,0" "m"$, Loslager $B$ bei $"3,0" "m"$, $2 "kN"$ am Ende bei $"4,0" "m"$; $sigma_("zul") = 12 "kN/cm"^2$.

*Gesucht*

#enum(numbering: "a)",
[Lagerkräfte und größtes Moment.],
[Radius des Vollkreises; Hohlkreis mit $R = "1,1" r$; Materialersparnis.],
)
][
*Lager:* $F_B dot 3 = 4 dot 2 + 2 dot 4$, $F_B = "5,33" "kN"$, $F_A = "0,67" "kN"$.
][
*Momente:* unter der 4-kN-Last $"0,67" dot 2 = "1,33" "kNm"$, bei $B$ $-2 dot 1 = -2 "kNm"$. Maßgebend $|M| = 2 "kNm"$.
][
*Vollkreis:* $W = 200\/12 = "16,67" "cm"^3$, $r = (4W\/pi)^(1\/3) = "2,77" "cm"$.
][
*Hohlkreis:* $R = "3,05" "cm"$, $r_i = (R^4 - 4 W R\/pi)^(1\/4) = "2,15" "cm"$. Ersparnis $1 - (R^2 - r_i^2)\/r^2 = "39,3" %$.
]

#aufgabe(titel: "Wann braucht man den Satz von Steiner?", art: "verstehen", quelle: "TM2 4.3", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 226* #linebreak()]
Wann braucht man den Satz von Steiner?
][
*Antwort:*
- Wenn man das Trägheitsmoment einer Teilfläche um eine Achse braucht, die nicht durch ihren eigenen Schwerpunkt geht:
- $ I = I_"eigen" + a^2 A $ Der Steiner-Anteil ist immer positiv.
#align(center)[#image(abbildungen.at("ak24-querschnitt"), width: 60%)]
][
*Merksatz:* Parallel verschieben: Eigenmoment plus Steiner-Anteil.
]

#aufgabe(titel: "Was folgt aus einer Symmetrieachse für das Deviationsmoment?", art: "verstehen", quelle: "TM2 4.3", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 227* #linebreak()]
Was folgt aus einer Symmetrieachse für das Deviationsmoment?
][
*Antwort:*
- Eine Symmetrieachse ist eine Hauptachse, also ist $I_(y z) = 0$.
- Dann biegt sich der Balken genau in der Ebene der Last, ohne schief auszuweichen.
#align(center)[#image(abbildungen.at("ak24-querschnitt"), width: 60%)]
]

#aufgabe(titel: "Flächenträgheitsmoment eines hochkant stehenden Rechtecks", art: "verstehen", quelle: "TM2 4.3", herkunft: "eigen", minuten: 3,
  tipp: [Die Abmessung quer zur Biegeachse geht in die dritte Potenz.],
)[
#if not web [*Aufgabe 228* #linebreak()]
Ein Rechteck hat $b = 20$ mm und $h = 60$ mm. Wie groß ist $I_y$ um die waagerechte Schwerpunktachse?
][
*Antwort:* 360.000 mm⁴. $I_y = b h^3 \/ 12 = 20 dot 60^3 \/ 12 = 360000$ mm⁴.
][
*Typische Verwechslung:* 40.000 mm⁴: Das ist $h b^3 \/ 12$, also $I_z$. Bei $I_y$ steht die Höhe in der dritten Potenz.
]

#aufgabe(titel: "Schwerpunkt und Steiner am zusammengesetzten Querschnitt", art: "rechnen", quelle: "TM2 4.3", herkunft: "original", vorlage: "Altklausur SS 24, Aufg. 2 (Querschnitt)", minuten: 12,
  ergebnis: [$z'_S = "58,061096" thin "mm"$, $y'_S = 0$, $I_y = "9833140,605" thin "mm"^4$, $I_(y z) = 0$],
  tipp: [Arbeite mit einer Tabelle: Fläche, Schwerpunktlage, Abstand zum Gesamtschwerpunkt, Eigenanteil, Steineranteil.],
)[
#if not web [*Aufgabe 229* #linebreak()]
*AK24 S. 18–23:*

*Gegeben und Annahmen*

Querschnitt gemäß Skizze: Radius $r=50 thin "mm"$, konstante Wanddicke $t="3,75" thin "mm"$; äußeres Rechteck $2r times 3r$ und äußerer Halbkreis, innere Aussparung aus Rechteck und Halbkreis. Hilfsursprung in der Mitte der Durchmesserlinie; $z'$ nach unten.
#align(center)[#image(abbildungen.at("ak24-querschnitt"), width: 100%)]

*Gesucht*

#enum(numbering: "a)",
[Bestimme die vier vorzeichenbehafteten Teilflächen und ihre $z'$-Schwerpunktkoordinaten.],
[Berechne Gesamtschwerpunkt und $I_y$ mit Steiner.],
[Prüfe $I_(y z)$.],
)
][
*Modell:* Rechteck 1 minus Rechteck 2 plus Halbkreis 3 minus Halbkreis 4; exakte Geometrie. Abgezogene Teile bekommen negative Fläche und negativen Eigenanteil.
][
*Flächen und Teil-Schwerpunkte:*
#tab(columns: 3, th([Teil], [$A_i$ / mm²], [$z'_(S i)$ / mm]),
 [1], [15000], [75], [2], [−13528,125], [73,125], [3], [3926,990817], [−21,220659], [4], [−3360,031518], [−19,629110],)
][
*Schwerpunkt:* $A = sum A_i = "2038,834299" thin "mm"^2$ und $z'_S = sum A_i z'_(S i) \/ A = "58,061096" thin "mm"$. Wegen der Symmetrie zur z-Achse ist $y'_S = 0$.
][
*Steiner:* Jeder Teil trägt seinen Eigenanteil plus $A_i d_i^2$ mit $d_i = z'_(S i) - z'_S$ bei. Die Eigenanteile mit Vorzeichen sind 28 125 000; −24 112 825,9277; 685 981,0040; −502 202,6736 mm⁴. Zusammen mit $sum A_i d_i^2$ folgt *$I_y="9833140,605" "mm"^4$*.
][
*Deviationsmoment:* Alle Teilschwerpunkte liegen auf der Symmetrieachse, ihre y-Abstände sind null. Deshalb ist *$I_(y z)=0$*.
][
*Prüfen:* Der Schwerpunkt liegt innerhalb der äußeren Höhe. Die Zwischenrechnung AK24 S. 22 nennt 9 832 269,405; mit ungerundeten Ausgangsdaten ergibt sich der hier angegebene Wert, der auch auf S. 23 steht.
]

#aufgabe(titel: "Schwerpunkt und Steiner am zusammengesetzten Querschnitt (Variante)", art: "rechnen", quelle: "TM2 4.3", herkunft: "variante", vorlage: "Altklausur SS 24, Aufg. 2 (Querschnitt)", minuten: 12,
  ergebnis: [$z'_S = "46,45" "mm"$, $y'_S = 0$, $I_y approx 4027650 "mm"^4$, $I_(y z) = 0$],
)[
#if not web [*Aufgabe 230* #linebreak()]
*Gegeben und Annahmen*

Dünnwandiges Profil wie AK24, aber $r = 40 "mm"$, $t = 3 "mm"$: äußeres Rechteck $2r times 3r$ unter der Durchmesserlinie plus äußerer Halbkreis darüber, innen Rechteck $(2r - 2t) times (3r - t)$ und Halbkreis $r - t$ ausgespart. Ursprung in der Mitte der Durchmesserlinie, $z'$ nach unten.

*Gesucht*

#enum(numbering: "a)",
[Teilflächen und Schwerpunkt.],
[$I_y$ mit Steiner, $I_(y z)$.],
)
][
*Teilflächen:* $9600$ bei $60$; $-74 dot 117 = -8658$ bei $"58,5"$; Halbkreis $"2513,27"$ bei $-"16,98"$; $-"2150,42"$ bei $-"15,70"$.
][
*Schwerpunkt:* $A = "1304,85"$, $z'_S = "46,45" "mm"$.
][
*$I_y$:* Eigenanteile $11520000$; $-9876614$; $280978$; $-205702$. Steiner $1762876$; $-1257398$; $10110353$; $-8306840$. Summe $I_y approx 4027650 "mm"^4$; $I_(y z) = 0$ (Symmetrie).
]

#aufgabe(titel: "Hauptträgheitsmomente", art: "rechnen", quelle: "TM2 4.3", herkunft: "original", vorlage: "Altklausur unbekannt, Aufg. 2 (Hauptachsen)", minuten: 5,
  ergebnis: [$I_1 approx "412315,46" thin "mm"^4$, $I_2 approx "107684,54" thin "mm"^4$, $phi_1 approx "11,599"°$],
  tipp: [Das funktioniert wie der Mohrsche Kreis für Spannungen: Mittelwert, Radius, Mittelwert plus und minus Radius.],
)[
#if not web [*Aufgabe 231* #linebreak()]
*Ältere Klausur, Datum unbekannt, Prüfung_unbekannt S. 1–2:*

*Gegeben und Annahmen*

$I_y=400000$, $I_z=120000$, $I_(y z)=60000 "mm"^4$.

*Gesucht*

#enum(numbering: "a)",
[Bestimme Hauptmomente und eine zu I₁ gehörige Achsenrichtung.],
)
][
*Bild:* Dreht man die Achsen, ändern sich $I_y$, $I_z$ und $I_(y z)$ wie Spannungen beim Drehen eines Elements. Die Hauptachsen sind die Lage, in der $I_(y z)$ verschwindet.
][
*Mittelwert und Radius:* $(I_y + I_z)\/2 = 260000 thin "mm"^4$. Halbe Differenz $140000$. $R = sqrt(140000^2 + 60000^2) approx "152315,46" thin "mm"^4$.
][
*Hauptmomente:* $I_1 = 260000 + R approx "412315,46" thin "mm"^4$, $I_2 = 260000 - R approx "107684,54" thin "mm"^4$.
][
*Richtung:* $tan 2phi = 2I_(y z)\/(I_y - I_z) = 120000\/280000$, also $2phi approx "23,199"°$ und *$phi_1 approx "11,599"°$*. Einsetzen in die Transformationsformel für $I_eta$ ergibt $I_1$ und bestätigt die Zuordnung.
][
*Prüfen:* $I_1 + I_2 = 520000 = I_y + I_z$. Das größte Hauptmoment ist größer als jedes der Ausgangsmomente, das kleinste kleiner.
]

#aufgabe(titel: "Hauptträgheitsmomente (Variante)", art: "rechnen", quelle: "TM2 4.3", herkunft: "variante", vorlage: "Altklausur unbekannt, Aufg. 2 (Hauptachsen)", minuten: 5,
  ergebnis: [$I_1 = 328062$, $I_2 = 71938 "mm"^4$, $phi_1 = -"19,33"°$],
)[
#if not web [*Aufgabe 232* #linebreak()]
*Gegeben und Annahmen*

$I_y = 300000$, $I_z = 100000$, $I_(y z) = -80000 "mm"^4$.

*Gesucht*

#enum(numbering: "a)",
[Hauptmomente und Richtung von $I_1$.],
)
][
*Kreis:* Mittelwert $200000$, Radius $sqrt(100000^2 + 80000^2) = 128062 "mm"^4$.
][
*Hauptmomente:* $I_1 = 328062$, $I_2 = 71938 "mm"^4$.
][
*Richtung:* $tan 2phi = -160000\/200000$, $phi_1 = -"19,33"°$; Einsetzen bestätigt $I_1$.
]

#aufgabe(titel: "Flächenträgheitsmomente eines Rechtecks mit Loch", art: "rechnen", quelle: "TM2 4.3", herkunft: "original", vorlage: "TM2-Übung 10, Aufg. 10.1 (FTM)", minuten: 10,
  ergebnis: [$z'_S = 19\/6 a$; $I_y = "65,5" a^4$, $I_z = 30 a^4$, $I_(y z) = 0$; $W_y = "20,68" a^3$, $W_z = 15 a^3$],
  tipp: [Das Loch zählt mit negativer Fläche und negativem Eigenanteil. Beim Widerstandsmoment den größeren Randabstand nehmen.],
)[
#if not web [*Aufgabe 233* #linebreak()]
Für den skizzierten Hohlquerschnitt bestimme man die Trägheitsmomente bezüglich des $y$-$z$-Systems durch den Flächenschwerpunkt und die Widerstandsmomente.
#align(center)[#image(abbildungen.at("tm2k4_ue10"), width: 40%)]

*Gegeben und Annahmen*

Rechteck $4a$ breit, $6a$ hoch; rechteckiges Loch $2a times 3a$, mittig, Oberkante $a$ unter der Außenkante. Hilfs-KS $y'$-$z'$ an der Oberkante.

*Gesucht*

#enum(numbering: "a)",
[Schwerpunkt, $I_y$, $I_z$, $I_(y z)$.],
[$W_y$ und $W_z$.],
)
][
*Schwerpunkt:* $A = 24 a^2 - 6 a^2 = 18 a^2$. $z'_S = (24 dot 3 - 6 dot "2,5") a^3\/(18 a^2) = 57\/18 a = 19\/6 a$. $y'_S$ liegt auf der Symmetrieachse.
][
*$I_y$:* Außen $4 dot 6^3\/12 + 24 (1\/6)^2 = 72 + "0,667"$; Loch $-(2 dot 3^3\/12 + 6 (2\/3)^2) = -("4,5" + "2,667")$. $I_y = "65,5" a^4$.
][
*$I_z$ und $I_(y z)$:* Beide Schwerpunkte liegen auf der $z$-Achse, also kein Steiner: $I_z = 6 dot 4^3\/12 - 3 dot 2^3\/12 = 32 - 2 = 30 a^4$. $I_(y z) = 0$ wegen der Symmetrie.
][
*Widerstandsmomente:* Größter Randabstand in $z$ ist $19\/6 a$: $W_y = "65,5"\/(19\/6) a^3 = "20,68" a^3$. In $y$: $W_z = 30\/2 a^3 = 15 a^3$.
]

#aufgabe(titel: "Flächenträgheitsmomente eines Rechtecks mit Loch (Variante)", art: "rechnen", quelle: "TM2 4.3", herkunft: "variante", vorlage: "TM2-Übung 10, Aufg. 10.1 (FTM)", minuten: 8,
  ergebnis: [$z'_S = 13\/3 a$; $I_y = "149,33" a^4$, $I_z = 40 a^4$; $W_y = "34,46" a^3$, $W_z = 20 a^3$],
)[
#if not web [*Aufgabe 234* #linebreak()]
*Gegeben und Annahmen*

Rechteck $4a$ breit, $8a$ hoch; mittiges Loch $2a times 4a$, Oberkante $a$ unter der Außenkante.

*Gesucht*

#enum(numbering: "a)",
[Schwerpunkt, $I_y$, $I_z$, $I_(y z)$, $W_y$, $W_z$.],
)
][
*Schwerpunkt:* $A = 32 - 8 = 24 a^2$, $z'_S = (32 dot 4 - 8 dot 3)\/24 a = 13\/3 a$.
][
*$I_y$:* $4 dot 8^3\/12 + 32 (1\/3)^2 - (2 dot 4^3\/12 + 8 (4\/3)^2) = "170,67" + "3,56" - "10,67" - "14,22" = "149,33" a^4$.
][
*$I_z$, $W$:* $I_z = 8 dot 64\/12 - 4 dot 8\/12 = 40 a^4$, $I_(y z) = 0$. Unterer Rand $8 - "4,33" = "3,67" a$, oberer $"4,33" a$: $W_y = "149,33"\/"4,33" = "34,46" a^3$, $W_z = 20 a^3$.
]

#aufgabe(titel: "Quadrat mit schräg ausgespartem Schlitz", art: "rechnen", quelle: "TM2 4.3", herkunft: "original", vorlage: "TM2-Übung 10, Aufg. 10.2", minuten: 12,
  ergebnis: [$S$ in der Mitte; Hauptachsen unter $45°$; $I_1 = 21\/256 dot a^4$ (Achse längs des Schlitzes), $I_2 = a^4\/16$ (Achse quer zum Schlitz)],
  tipp: [Ein Quadrat hat um jede Schwerachse dasselbe $I = a^4\/12$. Rechne deshalb gleich im gedrehten System des Schlitzes.],
)[
#if not web [*Aufgabe 235* #linebreak()]
Für den skizzierten Hohlquerschnitt bestimme man den Flächenschwerpunkt, die Hauptträgheitsmomente und die Hauptachsen.
#align(center)[#image(abbildungen.at("tm2k4_ue102"), width: 35%)]

*Gegeben und Annahmen*

Quadrat mit Seite $a$; mittig ein rechteckiger Schlitz $b times c$ mit $b = a\/4$ (Breite) und $c = a$ (Länge), um $45°$ gedreht.

*Gesucht*

#enum(numbering: "a)",
[Schwerpunkt.],
[Hauptachsen und Hauptträgheitsmomente.],
)
][
*Schwerpunkt:* Quadrat und Schlitz haben denselben Mittelpunkt, also liegt $S$ dort. Steineranteile fallen alle weg.
][
*Hauptachsen:* Der Querschnitt ist symmetrisch zu den beiden $45°$-Achsen. Symmetrieachsen sind Hauptachsen.
][
*Achse längs des Schlitzes:* Quadrat $a^4\/12$, Schlitz $c b^3\/12 = a (a\/4)^3\/12 = a^4\/768$. $I = a^4\/12 - a^4\/768 = 63\/768 a^4 = 21\/256 a^4 approx "0,0820" a^4$.
][
*Achse quer zum Schlitz:* Schlitz $b c^3\/12 = a^4\/48$. $I = a^4\/12 - a^4\/48 = a^4\/16 = "0,0625" a^4$.
][
*Prüfen:* Im $y$-$z$-System gilt $I_y = I_z = 111\/1536 a^4$ und $|I_(y z)| = 15\/1536 a^4$; Mittelwert plus/minus $|I_(y z)|$ gibt wieder $21\/256$ und $1\/16$. Der lange Schlitz liegt weit von der Querachse entfernt und schwächt deshalb die Biegung um sie stärker.
]

#aufgabe(titel: "Quadrat mit schrägem Schlitz (Variante)", art: "rechnen", quelle: "TM2 4.3", herkunft: "variante", vorlage: "TM2-Übung 10, Aufg. 10.2", minuten: 8,
  ergebnis: [Hauptachsen unter $45°$; $I_1 = "0,0828" a^4$, $I_2 = "0,0748" a^4$; im $y$-$z$-System $I_y = I_z = "0,0788" a^4$, $|I_(y z)| = "0,0040" a^4$],
)[
#if not web [*Aufgabe 236* #linebreak()]
*Gegeben und Annahmen*

Quadrat $a times a$ mit mittigem, um $45°$ gedrehtem Schlitz $b = a\/5$, $c = 4a\/5$.

*Gesucht*

#enum(numbering: "a)",
[Hauptträgheitsmomente.],
[$I_y$, $I_z$, $|I_(y z)|$ im achsparallelen System.],
)
][
*Gedrehtes System:* längs des Schlitzes $a^4\/12 - (4\/5)(1\/5)^3 a^4\/12 = 621\/7500 a^4 = "0,0828" a^4$; quer $a^4\/12 - (1\/5)(4\/5)^3 a^4\/12 = 561\/7500 a^4 = "0,0748" a^4$.
][
*Zurückdrehen um 45°:* $I_y = I_z = ("0,0828" + "0,0748")\/2 = "0,0788" a^4$, $|I_(y z)| = ("0,0828" - "0,0748")\/2 = "0,0040" a^4$.
]

#aufgabe(titel: "Z-Profil genau und dünnwandig", art: "rechnen", quelle: "TM2 4.3", herkunft: "original", vorlage: "TM2-Übung 10, Aufg. 10.3", minuten: 18,
  ergebnis: [a) $S$ in der Profilmitte; b) $I_y = 226 dot 10^5$, $I_z = "36,7" dot 10^5$, $I_(y z) = "68,1" dot 10^5 "mm"^4$; c) dünnwandig $I_y = 225 dot 10^5$, $I_z = "36,6" dot 10^5$, $I_(y z) = "68,4" dot 10^5 "mm"^4$; d) $phi^* = "17,87"°$, $I_1 = "247,95" dot 10^5$, $I_2 = "14,75" dot 10^5 "mm"^4$],
  tipp: [Das Z-Profil ist punktsymmetrisch. Die Gurte liegen in diagonal gegenüberliegenden Vierteln, deshalb ist $I_(y z) != 0$.],
)[
#if not web [*Aufgabe 237* #linebreak()]
Berechnen Sie (bzw. bestimmen Sie durch begründete Anschauung) für den gegebenen Querschnitt zunächst genau (linkes Bild), dann dünnwandig (rechtes Bild).
#align(center)[#image(abbildungen.at("tm2k4_ue103"), width: 75%)]

*Gegeben und Annahmen*

Genau: Höhe 200 mm, Steg 10 mm dick, Gurte $70 times 13$ mm oben links und unten rechts. Dünnwandig: Mittellinien mit Steg 187 mm ($t = 10$) und Gurten 75 mm ($t = 13$). Maße in mm, $I_(y z) = -integral y z thin d A$.

*Gesucht*

#enum(numbering: "a)",
[Lage des Flächenschwerpunkts.],
[Tensor der Flächenträgheitsmomente im $y$-$z$-System durch $S$.],
[a) und b) mit dünnwandiger Näherung.],
[Hauptachsen und Hauptträgheitsmomente (nur genau).],
)
][
*Schwerpunkt:* Punktsymmetrie, also $S$ in der Mitte. Rechnung: $y'_S = (910 dot 115 + 2000 dot 75 + 910 dot 35)\/3820 = 75$, $z'_S = (910 dot "6,5" + 2000 dot 100 + 910 dot "193,5")\/3820 = 100$ mm.
][
*$I_y$:* Gurte je $70 dot 13^3\/12 + 910 dot "93,5"^2 = 12816 + 7955448$, Steg $10 dot 200^3\/12 = 6666667$. $I_y = 226 dot 10^5 "mm"^4$.
][
*$I_z$ und $I_(y z)$:* Gurte je $13 dot 70^3\/12 + 910 dot 40^2$, Steg $200 dot 10^3\/12$: $I_z = "36,7" dot 10^5$. $I_(y z) = -sum A y_S z_S = -2 dot 910 dot 40 dot (-"93,5") = "68,1" dot 10^5 "mm"^4$. Tensor $mat(226, "68,1"; "68,1", "36,7") dot 10^5 "mm"^4$.
][
*Dünnwandig:* Gurte $13 dot 75$ mit Schwerpunkt $"37,5"$ mm neben dem Steg, $plus.minus "93,5"$ mm in der Höhe; Steg $10 dot 187$. Ergebnis $I_y = 225 dot 10^5$, $I_z = "36,6" dot 10^5$, $I_(y z) = "68,4" dot 10^5 "mm"^4$, kaum Unterschied.
][
*Hauptachsen:* $tan 2phi^* = 2 dot "68,1"\/(226 - "36,7")$, $phi^* = "17,87"°$. $I_("1,2") = "131,35" plus.minus sqrt("94,65"^2 + "68,1"^2) = ("131,35" plus.minus "116,60") dot 10^5$: $I_1 = "247,95" dot 10^5$, $I_2 = "14,75" dot 10^5 "mm"^4$.
][
*Zuordnen:* Einsetzen von $phi^*$ in die Transformation liefert $I_1$. Anschaulich: Um die Achse längs der Diagonale durch die Gurte ist der Biegewiderstand am größten.
]

#aufgabe(titel: "Z-Profil mit schmaleren Gurten (Variante)", art: "rechnen", quelle: "TM2 4.3", herkunft: "variante", vorlage: "TM2-Übung 10, Aufg. 10.3", minuten: 14,
  ergebnis: [$S$ in der Mitte; $I_y = "140,66" dot 10^5$, $I_z = "21,04" dot 10^5$, $I_(y z) = "41,13" dot 10^5 "mm"^4$; $phi^* = "17,26"°$, $I_1 = "153,43" dot 10^5$, $I_2 = "8,27" dot 10^5 "mm"^4$],
)[
#if not web [*Aufgabe 238* #linebreak()]
*Gegeben und Annahmen*

Z-Profil (genau): Höhe 180 mm, Steg 8 mm dick, Gurte $60 times 12$ mm oben links und unten rechts. $I_(y z) = -integral y z thin d A$.

*Gesucht*

#enum(numbering: "a)",
[Schwerpunkt und Trägheitstensor.],
[Hauptrichtung und Hauptträgheitsmomente.],
)
][
*Schwerpunkt:* Punktsymmetrisch, $S$ in der Mitte. Gurtschwerpunkte je $34$ mm seitlich und $84$ mm über bzw. unter $S$.
][
*Tensor:* $I_y = 2(60 dot 12^3\/12 + 720 dot 84^2) + 8 dot 180^3\/12 = "140,66" dot 10^5$; $I_z = 2(12 dot 60^3\/12 + 720 dot 34^2) + 180 dot 8^3\/12 = "21,04" dot 10^5$; $I_(y z) = -2 dot 720 dot 34 dot (-84) = "41,13" dot 10^5 "mm"^4$.
][
*Hauptwerte:* $tan 2phi^* = "82,25"\/"119,62"$, $phi^* = "17,26"°$. $I_("1,2") = "80,85" plus.minus "72,58"$, also $I_1 = "153,43" dot 10^5$, $I_2 = "8,27" dot 10^5 "mm"^4$.
]

#aufgabe(titel: "Dickwandiger C-Querschnitt mit Hauptachsen", art: "rechnen", quelle: "TM2 4.3", herkunft: "original", vorlage: "TM2-Übung 10, Aufg. 10.4", minuten: 15,
  ergebnis: [$y'_S = 31$, $z'_S = 39 "mm"$; $I_y = 988500$, $I_z = 288500$, $I_(y z) = 126000 "mm"^4$; $phi^* = "9,9"°$, $I_1 = 1010490$, $I_2 = 266510 "mm"^4$],
  tipp: [Zerlege in drei Rechtecke und schreibe eine Tabelle mit $A$, $y_S$, $z_S$, Eigenanteil und Steiner.],
)[
#if not web [*Aufgabe 239* #linebreak()]
Für den dargestellten (nicht dünnwandigen) Trägerquerschnitt sind der Schwerpunkt sowie die Hauptträgheitsmomente mit Richtung zu bestimmen.
#align(center)[#image(abbildungen.at("tm2k4_ue104"), width: 85%)]

*Gegeben und Annahmen*

Teil 1: oberer Gurt $30 times 10$ mm; Teil 2: Steg $10 times 60$ mm (die oberen 10 mm gehören zum Gurt); Teil 3: unterer Gurt $60 times 10$ mm. Hilfs-KS $y'$ nach links, $z'$ nach unten, Ursprung oben rechts. $I_(y z) = -integral y z thin d A$.

*Gesucht*

#enum(numbering: "a)",
[Schwerpunkt im $y'$-$z'$-System.],
[$I_y$, $I_z$, $I_(y z)$ durch $S$.],
[Hauptträgheitsmomente mit Richtung.],
)
][
*Tabelle:* $A_i = 300, 600, 600 "mm"^2$; $y'_i = 45, 25, 30$; $z'_i = 5, 30, 65$ mm.
][
*Schwerpunkt:* $y'_S = (13500 + 15000 + 18000)\/1500 = 31$, $z'_S = (1500 + 18000 + 39000)\/1500 = 39 "mm"$.
][
*Trägheitsmomente:* Abstände zu $S$: $(14, -34)$, $(-6, -9)$, $(-1, 26)$. $I_y = 2500 + 346800 + 180000 + 48600 + 5000 + 405600 = 988500$; $I_z = 22500 + 58800 + 5000 + 21600 + 180000 + 600 = 288500$; $I_(y z) = -sum A y z = 142800 - 32400 + 15600 = 126000 "mm"^4$.
][
*Hauptwerte:* $tan 2phi^* = 252000\/700000$, $phi^* = "9,9"°$. $I_("1,2") = 638500 plus.minus sqrt(350000^2 + 126000^2) = 638500 plus.minus 371990$.
][
*Ergebnis und Prüfung:* $I_1 = 1010490$, $I_2 = 266510 "mm"^4$; $I_1$ gehört zu $phi^*$ (Einsetzen). $I_1 + I_2 = I_y + I_z$.
]

#aufgabe(titel: "Dickwandiger C-Querschnitt (Variante)", art: "rechnen", quelle: "TM2 4.3", herkunft: "variante", vorlage: "TM2-Übung 10, Aufg. 10.4", minuten: 12,
  ergebnis: [$y'_S = 35$, $z'_S = "38,53" "mm"$; $I_y = 1172990$, $I_z = 494167$, $I_(y z) = 150000 "mm"^4$; $phi^* = "11,92"°$, $I_1 = 1204658$, $I_2 = 462498 "mm"^4$],
)[
#if not web [*Aufgabe 240* #linebreak()]
*Gegeben und Annahmen*

Aufbau wie Übung 10.4, Ursprung oben rechts, $y'$ nach links, $z'$ nach unten: Teil 1 Gurt $40 times 10$ ($y'$ 30…70, $z'$ 0…10), Teil 2 Steg $10 times 60$ ($y'$ 20…30, $z'$ 0…60), Teil 3 Gurt $70 times 10$ ($y'$ 0…70, $z'$ 60…70). Maße in mm.

*Gesucht*

#enum(numbering: "a)",
[Schwerpunkt, $I_y$, $I_z$, $I_(y z)$.],
[Hauptträgheitsmomente und Richtung.],
)
][
*Schwerpunkt:* $A = 400 + 600 + 700 = 1700$. $y'_S = (20000 + 15000 + 24500)\/1700 = 35$, $z'_S = (2000 + 18000 + 45500)\/1700 = "38,53" "mm"$.
][
*Trägheitsmomente:* Abstände $(15, -"33,53")$, $(-10, -"8,53")$, $(0, "26,47")$. $I_y = 1172990$, $I_z = 494167$, $I_(y z) = 201176 - 51176 + 0 = 150000 "mm"^4$.
][
*Hauptwerte:* $tan 2phi^* = 300000\/678823$, $phi^* = "11,92"°$; $I_("1,2") = 833578 plus.minus 371080$: $I_1 = 1204658$, $I_2 = 462498 "mm"^4$.
]

#aufgabe(titel: "Kreisquerschnitt mit zwei Aussparungen (Altklausur 2018)", art: "rechnen", quelle: "TM2 4.3", herkunft: "original", vorlage: "Altklausur 2018, Aufg. 2 a)–e) (FTM)", minuten: 20,
  ergebnis: [a) $y'_S = "29,48"$, $z'_S = "28,96" "mm"$; b) Kreis $pi a^4\/4$, Dreieck $a^4\/288$, $a^4\/72$, $|I_(y z)| = a^4\/288$, Rechteck $a^4\/96$, $a^4\/24$; c) $I_(y z) approx -7265 "mm"^4$; d) nein; e) $I_1 = 596600$, $I_2 = 580400 "mm"^4$, $phi^* = -"32,2"°$],
  tipp: [Aussparungen mit negativer Fläche. Beim rechtwinkligen Dreieck gibt es ein Eigen-Deviationsmoment $b^2 h^2\/72$, das man leicht vergisst.],
)[
#if not web [*Aufgabe 241* #linebreak()]
*Altklausur SS 2018, S. 8–9:* Ein Träger mit dem skizzierten Querschnitt ist einseitig eingespannt.
#align(center)[#image(abbildungen.at("ak_2018_ftm"), width: 70%)]
#align(center)[#image(abbildungen.at("ak_2018_ftm_tab"), width: 60%)]

*Gegeben und Annahmen*

Kreis ① mit $R = a$, Mittelpunkt $(a, a)$ im Hilfs-KS ($y'$ nach links, $z'$ nach unten). Ausgespart: rechtwinkliges Dreieck ② mit den Katheten $a$ (waagrecht, auf $z' = a$ von $y' = a\/2$ bis $3a\/2$) und $a\/2$ (senkrecht bei $y' = 3a\/2$), darunter Rechteck ③ $a times a\/2$ ($y'$ von $a\/2$ bis $3a\/2$, $z'$ von $a$ bis $3a\/2$). $a = 30 "mm"$. Tabellenwerte: $A = 2830; -225; -450 "mm"^2$, $y' = 30; 35; 30$, $z' = 30; 25; "37,5"$. $I_(y z) = -integral y z thin d A$.

*Gesucht*

#enum(numbering: "a)",
[Schwerpunkt aus der Tabelle.],
[Eigen-FTM der Teilflächen allgemein.],
[Steiner-Anteile von $I_(y z)$ und $I_(y z)$ gesamt.],
[Sind $y$ und $z$ Hauptachsen?],
[Hauptträgheitsmomente und Richtung mit $I_y = 592000$, $I_z = 585000$, $I_(y z) = -7300 "mm"^4$.],
)
][
*Schwerpunkt:* $A = 2830 - 225 - 450 = 2155$. $y'_S = (84900 - 7875 - 13500)\/2155 = "29,48"$, $z'_S = (84900 - 5625 - 16875)\/2155 = "28,96" "mm"$.
][
*Eigenanteile:* Kreis $I_y = I_z = pi a^4\/4$. Dreieck ($b = a$, $h = a\/2$): $I_y = b h^3\/36 = a^4\/288$, $I_z = h b^3\/36 = a^4\/72$, $|I_(y z)| = b^2 h^2\/72 = a^4\/288$. Rechteck: $a (a\/2)^3\/12 = a^4\/96$ und $a^4\/24$.
][
*Steiner für $I_(y z)$:* Abstände zu $S$ aus der Tabelle: $("0,5"; 1)$, $("5,5"; -4)$, $("0,5"; "8,5")$. $-A y z$: $-1415$, $-4950$ (Aussparung), $+"1912,5"$.
][
*$I_(y z)$ gesamt:* Dazu das abgezogene Eigen-Deviationsmoment des Dreiecks $-a^4\/288 = -"2812,5"$: $I_(y z) approx -1415 - 4950 + 1912 - 2812 = -7265 "mm"^4$. Er ist nicht null, also sind $y$, $z$ keine Hauptachsen; der Querschnitt hat keine Symmetrieachse.
][
*Hauptwerte:* Mittelwert $588500$, Radius $sqrt(3500^2 + 7300^2) = 8096$. $I_1 = 596600$, $I_2 = 580400 "mm"^4$. $tan 2phi^* = -14600\/7000$, $phi^* = -"32,2"°$; Einsetzen gibt $I_1$.
][
*Prüfen:* Die beiden Hauptmomente liegen sehr nah beieinander, weil die Aussparungen gegenüber dem Kreis klein sind.
]

#aufgabe(titel: "Kreisquerschnitt mit zwei Aussparungen (Variante)", art: "rechnen", quelle: "TM2 4.3", herkunft: "variante", vorlage: "Altklausur 2018, Aufg. 2 a)–e) (FTM)", minuten: 18,
  ergebnis: [$y'_S = "39,30"$, $z'_S = "38,61" "mm"$; $I_y = 1869850$, $I_z = 1848760$, $I_(y z) = -22950 "mm"^4$; $I_1 = 1884560$, $I_2 = 1834050 "mm"^4$, $phi^* = -"32,7"°$],
)[
#if not web [*Aufgabe 242* #linebreak()]
*Gegeben und Annahmen*

Gleiche Geometrie wie in der Altklausur 2018, aber $a = 40 "mm"$: Kreis $R = a$ um $(a, a)$; Dreieck mit Ecken $(a\/2, a)$, $(3a\/2, a)$, $(3a\/2, a\/2)$ ausgespart; Rechteck $y'$ $a\/2$…$3a\/2$, $z'$ $a$…$3a\/2$ ausgespart. $I_(y z) = -integral y z thin d A$.

*Gesucht*

#enum(numbering: "a)",
[Schwerpunkt.],
[$I_y$, $I_z$, $I_(y z)$ vollständig mit Steiner.],
[Hauptträgheitsmomente und Richtung.],
)
][
*Tabelle:* Kreis $"5026,5" "mm"^2$ bei $(40; 40)$; Dreieck $-400$ bei $("46,67"; "33,33")$; Rechteck $-800$ bei $(40; 50)$.
][
*Schwerpunkt:* $A = "3826,5"$, $y'_S = "39,30"$, $z'_S = "38,61" "mm"$.
][
*Eigenanteile:* Kreis $2010619$; Dreieck $I_y = -8889$, $I_z = -35556$, $I_(y z) = -8889$; Rechteck $I_y = -26667$, $I_z = -106667$.
][
*Steiner:* Abstände $("0,70"; "1,39")$, $("7,36"; -"5,27")$, $("0,70"; "11,39")$. $I_y = 1869850$, $I_z = 1848760$, $I_(y z) = -4882 - 15531 + 6352 - 8889 = -22950 "mm"^4$.
][
*Hauptwerte:* Mittelwert $1859307$, Radius $25257$: $I_1 = 1884560$, $I_2 = 1834050 "mm"^4$; $phi^* = -"32,7"°$.
]

#aufgabe(titel: "Zusammengesetzter Querschnitt mit Halbkreis (Altklausur)", art: "rechnen", quelle: "TM2 4.3", herkunft: "original", vorlage: "Altklausur unbekannt, Aufg. 2 (Querschnitt)", minuten: 18,
  ergebnis: [a) $A = "628,32"$; $-800$; $1200 "mm"^2$, $y' = 0; 0; -5$, $z' = -"8,49"; 10; 20$; b) $y'_S = -"5,83"$, $z'_S = "10,37" "mm"$; c) $I_y approx 405500 "mm"^4$; e) $sigma = "21,0" "N/mm"^2$ (Zug, unten)],
  tipp: [Der Halbkreisschwerpunkt liegt $4R\/(3pi)$ von der Durchmesserlinie. Sein Eigenanteil um die eigene Schwerachse ist $(pi\/8 - 8\/(9pi)) R^4$.],
)[
#if not web [*Aufgabe 243* #linebreak()]
*Altklausur, Datum unbekannt, mit Musterlösung (Prüfung_unbekannt S. 1–2):*
#align(center)[#image(abbildungen.at("ak_unb_ftm"), width: 70%)]

*Gegeben und Annahmen*

$t = 10$, $b = 20$, $h = 40$ mm. Halbkreis ① ($R = 20$ mm) über der Durchmesserlinie $z' = 0$, Mittelpunkt im Ursprung. Rechteck ③ $(b + t) times h$ mit $y'$ von $-20$ bis $10$, $z'$ von 0 bis 40. Aussparung ② $b times h$ mit $y'$ von $-10$ bis $10$, $z'$ von $-10$ bis $30$. $z'$ nach unten.

*Gesucht*

#enum(numbering: "a)",
[$A_i$, $y'_i$, $z'_i$.],
[Schwerpunkt.],
[$I_y$ mit Steiner.],
[Biegespannung an der Einspannung bei $M = 50 "Nm"$, $I_y = 56000 "mm"^4$ und $z = "23,5" "mm"$ (unten).],
)
][
*Teilflächen:* ① $pi 20^2\/2 = "628,32"$ bei $(0; -"8,49")$; ② $-800$ bei $(0; 10)$; ③ $1200$ bei $(-5; 20)$.
][
*Schwerpunkt:* $A = "1028,3"$. $y'_S = (0 + 0 - 6000)\/"1028,3" = -"5,83"$, $z'_S = (-5333 - 8000 + 24000)\/"1028,3" = "10,37" "mm"$.
][
*$I_y$:* ① $17563 + "628,32" dot "18,86"^2 = 17563 + 223516$; ② $-(106667 + 800 dot "0,37"^2) = -(106667 + 111)$; ③ $160000 + 1200 dot "9,63"^2 = 160000 + 111214$. Summe $approx 405500 "mm"^4$.
][
*Spannung:* $sigma = M z\/I_y = 50000 dot "23,5"\/56000 = "21,0" "N/mm"^2$, Zug am unteren Rand. Die gedruckte Angabe $30000 "mm"^4$ ist im Bogen von Hand auf $56000$ korrigiert.
]

#aufgabe(titel: "Zusammengesetzter Querschnitt mit Halbkreis (Variante)", art: "rechnen", quelle: "TM2 4.3", herkunft: "variante", vorlage: "Altklausur unbekannt, Aufg. 2 (Querschnitt)", minuten: 15,
  ergebnis: [$y'_S = -"6,65"$, $z'_S = "15,21" "mm"$; $I_y = 618300 "mm"^4$; $sigma = "4,50" "N/mm"^2$ (Zug, unten)],
)[
#if not web [*Aufgabe 244* #linebreak()]
*Gegeben und Annahmen*

Wie in der Altklausur, aber $h = 50 "mm"$: Halbkreis $R = 20$ über $z' = 0$; Rechteck ③ $y'$ $-20$…$10$, $z'$ 0…50; Aussparung ② $y'$ $-10$…$10$, $z'$ $-10$…$40$. Biegemoment $M = 80 "Nm"$ (unten Zug).

*Gesucht*

#enum(numbering: "a)",
[Schwerpunkt und $I_y$.],
[Spannung am unteren Rand.],
)
][
*Teilflächen:* ① $"628,32"$ bei $(0; -"8,49")$; ② $-1000$ bei $(0; 15)$; ③ $1500$ bei $(-5; 25)$. $A = "1128,3"$.
][
*Schwerpunkt:* $y'_S = -7500\/"1128,3" = -"6,65"$, $z'_S = (-5333 - 15000 + 37500)\/"1128,3" = "15,21" "mm"$.
][
*$I_y$:* $17561 + 352999 - 208333 - 46 + 312500 + 143638 = 618300 "mm"^4$.
][
*Spannung:* Unterer Rand $50 - "15,21" = "34,79" "mm"$: $sigma = 80000 dot "34,79"\/618300 = "4,50" "N/mm"^2$.
]

#aufgabe(titel: "Querschnitt mit Halbkreis- und Dreiecksaussparung (SS 16)", art: "rechnen", quelle: "TM2 4.3", herkunft: "original", vorlage: "Altklausur SS 16 (PrüfungenTM2 S. 28, FTM)", minuten: 18,
  ergebnis: [a) $A = 2400; -"353,4"; -450 "mm"^2$, $y' = 20; "33,63"; 10$, $z' = 30; 20; 50$; b) $y'_S = "19,8"$, $z'_S = "26,6" "mm"$; c) $I_y approx 444000 "mm"^4$; d) nein; e) $I_1 approx 494600$, $I_2 approx 130400 "mm"^4$, $phi^* = -"21,9"°$],
  tipp: [Der Halbkreis sitzt mit dem Durchmesser am Rand. Sein Schwerpunkt liegt $4r\/(3pi) = "6,37" "mm"$ innen.],
)[
#if not web [*Aufgabe 245* #linebreak()]
*Altklausur SS 2016, Musterlösung (PrüfungenTM2 S. 28):*
#align(center)[#image(abbildungen.at("ak_ss16_ftm"), width: 70%)]

*Gegeben und Annahmen*

Rechteck ① $40 times 60$ mm ($h = 60$); ausgespart Halbkreis ② ($r = 15$ mm, Durchmesser am rechten Rand bei $y' = 40$, Mitte bei $z' = 20$) und Dreieck ③ mit Ecken $(0; 60)$, $(30; 60)$, $(0; 30)$. $I_(y z) = -integral y z thin d A$.

*Gesucht*

#enum(numbering: "a)",
[$A_i$, $y'_i$, $z'_i$.],
[Schwerpunkt.],
[$I_y$ mit Steiner.],
[Sind $y$, $z$ Hauptachsen?],
[Hauptträgheitsmomente mit $I_y = 444000$, $I_z = 181000$, $I_(y z) = -126000 "mm"^4$.],
)
][
*Teilflächen:* ① $2400$ bei $(20; 30)$; ② $-"353,4"$ bei $(40 - "6,37"; 20) = ("33,63"; 20)$; ③ $-450$ bei $(10; 50)$.
][
*Schwerpunkt:* $A = "1596,6"$. $y'_S = (48000 - 11886 - 4500)\/"1596,6" = "19,8"$, $z'_S = (72000 - 7069 - 22500)\/"1596,6" = "26,6" "mm"$.
][
*$I_y$:* ① $720000 + 27744$; ② $-(19880 + 15394)$; ③ $-(22500 + 246402)$. $I_y approx 444000 "mm"^4$ (die Musterlösung hatte zuerst 528000 und hat korrigiert).
][
*Hauptachsen?* Nein, der Querschnitt ist unsymmetrisch, $I_(y z) != 0$.
][
*Hauptwerte:* Mittelwert $312500$, Radius $sqrt(131500^2 + 126000^2) = 182120$. $I_1 approx 494600$, $I_2 approx 130400 "mm"^4$. $tan 2phi^* = -252000\/263000$, $phi^* = -"21,9"°$.
]

#aufgabe(titel: "Querschnitt mit Halbkreis- und Dreiecksaussparung (Variante)", art: "rechnen", quelle: "TM2 4.3", herkunft: "variante", vorlage: "Altklausur SS 16 (PrüfungenTM2 S. 28, FTM)", minuten: 15,
  ergebnis: [$y'_S = "25,07"$, $z'_S = "27,51" "mm"$; $I_y = 628680$, $I_z = 372960$, $I_(y z) = -190020 "mm"^4$; $I_1 = 729850$, $I_2 = 271790 "mm"^4$, $phi^* = -"28,0"°$],
)[
#if not web [*Aufgabe 246* #linebreak()]
*Gegeben und Annahmen*

Wie SS 16, aber Rechteck $50 times 60$ mm: Halbkreis $r = 15$ mit Durchmesser am rechten Rand ($y' = 50$, $z' = 20$) ausgespart, Dreieck $(0; 60)$, $(30; 60)$, $(0; 30)$ ausgespart. $I_(y z) = -integral y z thin d A$.

*Gesucht*

#enum(numbering: "a)",
[Schwerpunkt, $I_y$, $I_z$, $I_(y z)$.],
[Hauptträgheitsmomente und Richtung.],
)
][
*Teilflächen:* $3000$ bei $(25; 30)$, $-"353,4"$ bei $("43,63"; 20)$, $-450$ bei $(10; 50)$. $A = "2196,6"$.
][
*Schwerpunkt:* $y'_S = "25,07"$, $z'_S = "27,51" "mm"$.
][
*Trägheitsmomente:* Eigenanteile Rechteck $900000$/$625000$, Halbkreis $-19880$/$-5556$, Dreieck $-22500$/$-22500$ mit Eigen-$I_(y z) = +11250$. Mit Steiner: $I_y = 628680$, $I_z = 372960$, $I_(y z) = -190020 "mm"^4$.
][
*Hauptwerte:* Mittelwert $500820$, Radius $229030$: $I_1 = 729850$, $I_2 = 271790 "mm"^4$; $phi^* = -"28,0"°$.
]

#aufgabe(titel: "Halbring mit Steg: Schwerpunkt und Durchbiegung", art: "rechnen", quelle: "TM2 4.3", herkunft: "original", vorlage: "Altklausur PrüfungenTM2 S. 25–29 (Profil, Biegung)", minuten: 15,
  ergebnis: [a) $A = "628,32"; -"353,43"; 200 "mm"^2$, $y' = -"13,49"; -"11,37"; -"2,5"$; b) $y'_S = -"10,44" "mm"$, $z'_S = 0$; c) $I_z approx 30600 "mm"^4$; d) ja; e) $w = "33,2" "mm"$],
  tipp: [Halbring = großer Halbkreis minus kleiner Halbkreis. Beide Schwerpunkte liegen $4R\/(3pi)$ vom gemeinsamen Mittelpunkt.],
)[
#if not web [*Aufgabe 247* #linebreak()]
*Altklausur mit Musterlösung (PrüfungenTM2 S. 25–29):* Ein abgewinkeltes Profil ist einseitig eingespannt.
#align(center)[#image(abbildungen.at("ak_p25_profil"), width: 85%)]

*Gegeben und Annahmen*

Querschnitt: Halbring ($r_i = 15$, $t = 5$ mm, Mittelpunkt bei $y' = -5$, nach $-y'$ gewölbt) und Steg $t times h = 5 times 40$ mm ($y'$ von $-5$ bis 0, symmetrisch zu $z' = 0$). $l_2 = 1 "m"$, $F_1 = "0,9" "kN"$, $E = "2,1" dot 10^5 "N/mm"^2$.

*Gesucht*

#enum(numbering: "a)",
[$A_i$ und $y'_i$.],
[Schwerpunkt.],
[$I_z$.],
[Sind $y$, $z$ Hauptachsen?],
[Durchbiegung durch $F_1$ am Ende von $l_2$ mit $I = 43000 "mm"^4$.],
)
][
*Teilflächen:* Außen-Halbkreis $R = 20$: $"628,32"$ bei $y' = -5 - "8,49" = -"13,49"$; innen $r_i = 15$: $-"353,43"$ bei $-5 - "6,37" = -"11,37"$; Steg $200$ bei $-"2,5"$.
][
*Schwerpunkt:* $y'_S = (-8475 + 4018 - 500)\/"474,89" = -"10,44" "mm"$; $z'_S = 0$ aus Symmetrie.
][
*$I_z$:* $(17561 + 5845) - (5556 + 306) + ("416,7" + 12609) approx 30600 "mm"^4$.
][
*Hauptachsen:* Ja, $z' = 0$ ist Symmetrieachse, also $I_(y z) = 0$.
][
*Durchbiegung:* Kragarm mit Endkraft: $w = F_1 l_2^3\/(3 E I) = 900 dot 10^9\/(3 dot "2,1" dot 10^5 dot 43000) = "33,2" "mm"$.
]

#aufgabe(titel: "Halbring mit Steg (Variante)", art: "rechnen", quelle: "TM2 4.3", herkunft: "variante", vorlage: "Altklausur PrüfungenTM2 S. 25–29 (Profil, Biegung)", minuten: 12,
  ergebnis: [$y'_S = -"12,39" "mm"$; $I_z approx 59710 "mm"^4$; $w = "5,42" "mm"$],
)[
#if not web [*Aufgabe 248* #linebreak()]
*Gegeben und Annahmen*

Halbring $r_i = 20$, $t = 5$ mm (Mittelpunkt bei $y' = -5$), Steg $5 times 50$ mm ($y'$ $-5$…0). Kragarm $l_2 = "0,8" "m"$, $F_1 = "0,6" "kN"$, $E = "2,1" dot 10^5 "N/mm"^2$, $I = 90000 "mm"^4$.

*Gesucht*

#enum(numbering: "a)",
[Schwerpunkt und $I_z$.],
[Enddurchbiegung.],
)
][
*Teilflächen:* $R = 25$: $"981,75"$ bei $-"15,61"$; $r_i = 20$: $-"628,32"$ bei $-"13,49"$; Steg $250$ bei $-"2,5"$. $A = "603,4"$.
][
*Schwerpunkt:* $y'_S = -"12,39" "mm"$.
][
*$I_z$:* $(42874 + 10192) - (17561 + 760) + (521 + 24445) = 59710 "mm"^4$.
][
*Durchbiegung:* $w = 600 dot 800^3\/(3 dot "2,1" dot 10^5 dot 90000) = "5,42" "mm"$.
]

#aufgabe(titel: "Randbedingungen an Einspannung und freiem Ende", art: "verstehen", quelle: "TM2 4.4", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 249* #linebreak()]
Welche Bedingungen gelten an einer Einspannung und an einem unbelasteten freien Ende?
][
Einspannung: w=0 und w′=0. Unbelastetes freies Ende: Q=0 und M=0. Endlasten verändern die statischen Randbedingungen.
]

#aufgabe(titel: "Randbedingungen für die Biegelinie aufstellen", art: "verstehen", quelle: "TM2 4.4", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 250* #linebreak()]
*Eigene Übungsaufgabe nach FS TM2 S. 29 und älteren Klausuren:* Ein Balken der Länge L ist links eingespannt und rechts gelenkig gelagert. Eine linear abfallende Last hat links q₀ und rechts null. Schreibe q(x) und die vier Randbedingungen für die vierfache Integration auf; noch nicht integrieren.
][
*$q(x)=q_0(1-x/L)$*. Einspannung links: *$w(0)=0$, $w'(0)=0$*. Gelenkiges Endlager rechts ohne Endmoment: *$w(L)=0$, $M(L)=0$*, also bei konstantem EI auch $w''(L)=0$. Prüfung: vier unabhängige Bedingungen für vier Integrationskonstanten.
]

#aufgabe(titel: "Wie hängen Biegelinie und Moment zusammen?", art: "verstehen", quelle: "TM2 4.4", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 251* #linebreak()]
Wie hängen Biegelinie und Moment zusammen?
][
*Antwort:*
$ E I w'' = -M $
- Die Krümmung der Biegelinie ist proportional zum Moment.
- Zweimal integrieren liefert die Durchbiegung.
- Die Integrationskonstanten kommen aus den Randbedingungen.
][
*Merksatz:* Moment → Krümmung → zweimal integrieren.
]

#aufgabe(titel: "Was braucht man, wenn die Biegelinie in Bereiche aufgeteilt ist?", art: "verstehen", quelle: "TM2 4.4", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 252* #linebreak()]
Was braucht man, wenn die Biegelinie in Bereiche aufgeteilt ist?
][
*Antwort:*
- *Übergangsbedingungen:* An der Grenze müssen Durchbiegung und Neigung von beiden Seiten gleich sein.
- Der Balken hat dort keinen Sprung und keinen Knick.
- An einem Gelenk darf die Neigung springen.
]

#aufgabe(titel: "Was ist Superposition bei der Biegelinie?", art: "verstehen", quelle: "TM2 4.4", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 253* #linebreak()]
Was ist Superposition bei der Biegelinie?
][
*Antwort:*
- Bei linear elastischem Verhalten darf man Lastfälle einzeln berechnen, zum Beispiel aus der Biegelinientabelle, und die Durchbiegungen addieren.
- Das spart das Integrieren für jeden Fall.
][
*Merksatz:* Superposition braucht lineares Verhalten.
]

#aufgabe(titel: "Kragarm mit Endkraft und Moment", art: "rechnen", quelle: "TM2 4.4", herkunft: "original", vorlage: "Altklausur SS 24, Aufg. 2 (Biegelinie)", minuten: 10,
  ergebnis: [$w(2a) = 8F a^3\/(3E I) + 3M_0 a^2\/(2E I)$],
  tipp: [Rechne beide Lasten getrennt und addiere. Hinter dem Moment läuft die Biegelinie als Gerade weiter.],
)[
#if not web [*Aufgabe 254* #linebreak()]
*AK24 S. 25–26:*

*Gegeben und Annahmen*

Kragarm mit Gesamtlänge L=2a, Endkraft F nach unten und einem im Uhrzeigersinn wirkenden Moment M₀ bei x=a.

*Gesucht*

#enum(numbering: "a)",
[Bestimme die Enddurchbiegung durch Superposition.],
)
][
*Modell:* konstantes EI, kleine Verformungen; w nach unten positiv. Bei linearem Verhalten darf man Lastfälle einzeln rechnen und die Durchbiegungen addieren.
][
*Endkraft allein:* Tabellenfall Kragarm mit Endkraft über die Länge $2a$: $w_F = F(2a)^3\/(3E I) = 8F a^3\/(3E I)$.
][
*Moment allein, bis x = a:* Zwischen Einspannung und $a$ wirkt das konstante Moment $M_0$. Die Stelle $a$ senkt sich um $M_0 a^2\/(2E I)$ und hat dort die Neigung $M_0 a\/(E I)$.
][
*Moment allein, ab x = a:* Hinter dem Moment ist das Stück momentenfrei und bleibt gerade. Über die restliche Länge $a$ kommt also Neigung mal Länge dazu: $M_0 a\/(E I) dot a$. Zusammen $w_M = M_0 a^2\/(2E I) + M_0 a^2\/(E I) = 3M_0 a^2\/(2E I)$.
][
*Addieren und prüfen:* $w(2a) = 8F a^3\/(3E I) + 3M_0 a^2\/(2E I)$. Dreht $M_0$ andersherum, wird sein Beitrag abgezogen. Beide Summanden haben die Einheit Länge; bei $M_0 = 0$ bleibt der Kragarm mit Endkraft.
]

#aufgabe(titel: "Kragarm mit Endkraft und Moment (Variante)", art: "rechnen", quelle: "TM2 4.4", herkunft: "variante", vorlage: "Altklausur SS 24, Aufg. 2 (Biegelinie)", minuten: 8,
  ergebnis: [$w(3a) = 9 F a^3\/(E I) + 4 M_0 a^2\/(E I)$],
)[
#if not web [*Aufgabe 255* #linebreak()]
*Gegeben und Annahmen*

Kragarm der Länge $3a$, Endkraft $F$ nach unten, Moment $M_0$ im Uhrzeigersinn bei $x = 2a$ (biegt wie im Original nach unten); $E I$ konstant.

*Gesucht*

#enum(numbering: "a)",
[Enddurchbiegung durch Superposition.],
)
][
*Endkraft:* $F (3a)^3\/(3 E I) = 9 F a^3\/(E I)$.
][
*Moment bis 2a:* Absenkung $M_0 (2a)^2\/(2 E I) = 2 M_0 a^2\/(E I)$, Neigung $2 M_0 a\/(E I)$.
][
*Rest als Gerade:* $+ 2 M_0 a\/(E I) dot a$. Zusammen $w(3a) = 9 F a^3\/(E I) + 4 M_0 a^2\/(E I)$.
]

#aufgabe(titel: "Biegelinie unter einem Endmoment", art: "rechnen", quelle: "TM2 4.4", herkunft: "original", vorlage: "TM2-Übung 11, Aufg. 11.1", minuten: 12,
  ergebnis: [$w(x) = M_0 l^2\/(6 E I) (-(x\/l)^3 + x\/l)$; $w_("max") = M_0 l^2\/(9 sqrt(3) E I)$ bei $x = l\/sqrt(3)$],
  tipp: [Das Moment wächst linear von 0 auf $M_0$. Zweimal integrieren, beide Lager geben $w = 0$.],
)[
#if not web [*Aufgabe 256* #linebreak()]
Ein beidseitig gelenkig gelagerter Balken (konstante Biegesteifigkeit $E I$) ist durch ein Endmoment $M_0$ belastet.
#align(center)[#image("abbildungen/ue2_11_1.png", width: 50%)]

*Gegeben und Annahmen*

Länge $l$, Lager bei $x = 0$ und $x = l$, $M_0$ am rechten Ende, $w$ nach unten positiv.

*Gesucht*

#enum(numbering: "a)",
[Die Biegelinie.],
[Größte Durchbiegung und ihre Stelle.],
)
][
*Moment:* Lagerkräfte $plus.minus M_0\/l$, also $M(x) = M_0 x\/l$.
][
*Integrieren:* $E I w'' = -M_0 x\/l$, $E I w' = -M_0 x^2\/(2l) + C_1$, $E I w = -M_0 x^3\/(6l) + C_1 x + C_2$.
][
*Randbedingungen:* $w(0) = 0$ gibt $C_2 = 0$; $w(l) = 0$ gibt $C_1 = M_0 l\/6$. Also $w(x) = M_0 l^2\/(6 E I)(x\/l - (x\/l)^3)$.
][
*Maximum:* $w' = 0$: $1 - 3(x\/l)^2 = 0$, $x = l\/sqrt(3)$. Einsetzen: $w_("max") = M_0 l^2\/(6 E I) dot 2\/(3 sqrt(3)) = M_0 l^2\/(9 sqrt(3) E I)$.
][
*Prüfen:* Das Maximum liegt etwas rechts der Mitte ($"0,577" l$), zum belasteten Ende hin. Einheit: Nmm·mm²/(N/mm²·mm⁴) = mm.
]

#aufgabe(titel: "Balken mit gleichen Endmomenten (Variante)", art: "rechnen", quelle: "TM2 4.4", herkunft: "variante", vorlage: "TM2-Übung 11, Aufg. 11.1", minuten: 8,
  ergebnis: [$w(x) = M_0 x (l - x)\/(2 E I)$; $w_("max") = M_0 l^2\/(8 E I)$ bei $x = l\/2$],
)[
#if not web [*Aufgabe 257* #linebreak()]
*Gegeben und Annahmen*

Gelenkig gelagerter Balken (Länge $l$, $E I$ konstant), an beiden Enden ein Moment $M_0$, das den Balken nach unten durchbiegt (unten Zug). $w$ nach unten positiv.

*Gesucht*

#enum(numbering: "a)",
[Biegelinie und größte Durchbiegung.],
)
][
*Moment:* Die Lagerkräfte sind null, also $M(x) = M_0$ überall.
][
*Integrieren:* $E I w'' = -M_0$; mit $w(0) = w(l) = 0$ folgt $w = M_0 x(l - x)\/(2 E I)$.
][
*Maximum:* Symmetrie, also in der Mitte: $w(l\/2) = M_0 l^2\/(8 E I)$. Das ist gut 3,6-mal so viel wie bei nur einem Endmoment.
]

#aufgabe(titel: "Beidseitig eingespannter Balken unter Streckenlast", art: "rechnen", quelle: "TM2 4.4", herkunft: "original", vorlage: "TM2-Übung 11, Aufg. 11.2", minuten: 14,
  ergebnis: [$M(x) = q_0 l^2\/12 dot (-6 (x\/l)^2 + 6 x\/l - 1)$; an den Enden $-q_0 l^2\/12$, in der Mitte $q_0 l^2\/24$],
  tipp: [Statisch unbestimmt: viermal integrieren und die vier Einspannbedingungen $w = w' = 0$ an beiden Enden nutzen.],
)[
#if not web [*Aufgabe 258* #linebreak()]
Für den beiderseits eingespannten und durch eine konstante Streckenlast $q_0$ belasteten Balken ermittle man den Verlauf des Biegemoments $M(x)$.
#align(center)[#image("abbildungen/ue2_11_2.png", width: 45%)]

*Gegeben und Annahmen*

Länge $l$, $E I$ konstant, $q_0$ nach unten, $x$ vom linken Ende.

*Gesucht*

#enum(numbering: "a)",
[$M(x)$ sowie Einspann- und Feldmoment.],
)
][
*Ansatz:* $E I w'''' = q_0$. Viermal integrieren: $E I w = q_0 x^4\/24 + C_1 x^3\/6 + C_2 x^2\/2 + C_3 x + C_4$.
][
*Randbedingungen:* $w(0) = w'(0) = 0$ gibt $C_3 = C_4 = 0$. Wegen der Symmetrie ist $Q(l\/2) = 0$, also $C_1 = -q_0 l\/2$; aus $w(l) = 0$ folgt $C_2 = q_0 l^2\/12$.
][
*Moment:* $M = -E I w'' = -(q_0 x^2\/2 - q_0 l x\/2 + q_0 l^2\/12) = q_0 l^2\/12 (-6 xi^2 + 6 xi - 1)$ mit $xi = x\/l$.
][
*Prüfen:* $M(0) = M(l) = -q_0 l^2\/12$, $M(l\/2) = q_0 l^2\/24$. Der Abstand zwischen Einspann- und Feldmoment ist $q_0 l^2\/8$, wie beim Einfeldträger.
]

#aufgabe(titel: "Eingespannt-gelenkiger Balken unter Streckenlast (Variante)", art: "rechnen", quelle: "TM2 4.4", herkunft: "variante", vorlage: "TM2-Übung 11, Aufg. 11.2", minuten: 12,
  ergebnis: [$M(x) = q_0 l^2\/8 dot (-4 xi^2 + 5 xi - 1)$; $M(0) = -q_0 l^2\/8$, $M_("Feld,max") = 9 q_0 l^2\/128$ bei $xi = 5\/8$],
)[
#if not web [*Aufgabe 259* #linebreak()]
*Gegeben und Annahmen*

Balken der Länge $l$, links ($x = 0$) eingespannt, rechts gelenkig gelagert, konstante Streckenlast $q_0$, $E I$ konstant.

*Gesucht*

#enum(numbering: "a)",
[$M(x)$, Einspannmoment und größtes Feldmoment.],
)
][
*Ansatz:* $E I w = q_0 x^4\/24 + C_1 x^3\/6 + C_2 x^2\/2 + C_3 x + C_4$ mit $w(0) = w'(0) = 0$, $w(l) = 0$, $M(l) = 0$.
][
*Konstanten:* $C_3 = C_4 = 0$; aus den beiden rechten Bedingungen $C_1 = -5 q_0 l\/8$, $C_2 = q_0 l^2\/8$.
][
*Moment:* $M = -E I w'' = q_0 l^2\/8 (-4 xi^2 + 5 xi - 1)$. $M(0) = -q_0 l^2\/8$; $M' = 0$ bei $xi = 5\/8$ mit $M = 9 q_0 l^2\/128$.
]

#aufgabe(titel: "Kragträger gleicher Festigkeit unter Streckenlast", art: "rechnen", quelle: "TM2 4.4", herkunft: "original", vorlage: "TM2-Übung 11, Aufg. 11.3", minuten: 15,
  ergebnis: [a) $h(x) = sqrt(3 q_0\/(sigma_0 b)) dot x$; b) $w(x) = q_0 l^3\/(2 E I_0) (x ln(x\/l) - x + l)$, am freien Ende $w(0) = q_0 l^4\/(2 E I_0)$ mit $I_0 = I(l)$],
  tipp: [Mit $x$ vom freien Ende ist $M = q_0 x^2\/2$. Weil $h$ proportional zu $x$ ist, wächst $I$ mit $x^3$: $I(x) = I_0 (x\/l)^3$.],
)[
#if not web [*Aufgabe 260* #linebreak()]
Ein einseitig eingespannter Träger mit Rechteckquerschnitt ist durch eine konstante Streckenlast $q_0$ belastet. $E I$ ist hier nicht konstant.
#align(center)[#image("abbildungen/ue2_11_3.png", width: 55%)]

*Gegeben und Annahmen*

Länge $l$, Breite $b$ konstant, Elastizitätsmodul $E$; $x$ vom freien Ende zur Einspannung. Abkürzung $I_0 = I(x = l)$.

*Gesucht*

#enum(numbering: "a)",
[Verlauf $h(x)$, damit die Randspannung überall gleich $sigma_0$ ist.],
[Absenkung am freien Balkenende.],
)
][
*Gleiche Festigkeit:* $sigma = M\/W = (q_0 x^2\/2)\/(b h^2\/6) = 3 q_0 x^2\/(b h^2) = sigma_0$. Also $h(x) = x sqrt(3 q_0\/(b sigma_0))$.
][
*Steifigkeit:* $I = b h^3\/12 prop x^3$, also $I(x) = I_0 (x\/l)^3$.
][
*Krümmung:* $w'' = M\/(E I) = (q_0 x^2\/2) l^3\/(E I_0 x^3) = q_0 l^3\/(2 E I_0 x)$ (Vorzeichen so, dass $w$ nach unten positiv ist).
][
*Integrieren:* $w' = q_0 l^3\/(2 E I_0) ln(x\/l)$ wegen $w'(l) = 0$; dann $w = q_0 l^3\/(2 E I_0)(x ln(x\/l) - x + l)$ wegen $w(l) = 0$.
][
*Endabsenkung:* $x ln x -> 0$ für $x -> 0$, also $w(0) = q_0 l^4\/(2 E I_0)$. Das ist das Vierfache des prismatischen Trägers mit $q_0 l^4\/(8 E I_0)$, weil der Träger zur Spitze hin weich wird.
]

#aufgabe(titel: "Kragträger gleicher Festigkeit unter Endkraft (Variante)", art: "rechnen", quelle: "TM2 4.4", herkunft: "variante", vorlage: "TM2-Übung 11, Aufg. 11.3", minuten: 12,
  ergebnis: [a) $h(x) = sqrt(6 F x\/(b sigma_0))$; b) $w(0) = 2 F l^3\/(3 E I_0)$],
)[
#if not web [*Aufgabe 261* #linebreak()]
*Gegeben und Annahmen*

Kragträger der Länge $l$ mit Rechteckquerschnitt (Breite $b$ konstant), Kraft $F$ am freien Ende; $x$ vom freien Ende; $I_0 = I(l)$.

*Gesucht*

#enum(numbering: "a)",
[$h(x)$ für überall gleiche Randspannung $sigma_0$.],
[Absenkung am freien Ende.],
)
][
*Höhe:* $sigma = F x\/(b h^2\/6) = sigma_0$, also $h = sqrt(6 F x\/(b sigma_0))$, $I = I_0 (x\/l)^(3\/2)$.
][
*Krümmung:* $w'' = F x\/(E I_0 (x\/l)^(3\/2)) = F l^(3\/2)\/(E I_0) x^(-1\/2)$.
][
*Integrieren:* $w' = 2 F l^(3\/2)\/(E I_0)(sqrt(x) - sqrt(l))$, $w = F l^(3\/2)\/(E I_0)(4\/3 x^(3\/2) - 2 sqrt(l) x + 2\/3 l^(3\/2))$; $w(0) = 2 F l^3\/(3 E I_0)$, doppelt so viel wie beim prismatischen Träger.
]

#aufgabe(titel: "Absenkung am Gelenk eines Mehrfeldträgers", art: "rechnen", quelle: "TM2 4.4", herkunft: "original", vorlage: "TM2-Übung 11, Aufg. 11.4", minuten: 15,
  ergebnis: [$X = 8 F\/9 + 7 q_0 a\/72$; $w_G = 8\/27 dot F a^3\/(E I) + 7\/216 dot q_0 a^4\/(E I)$],
  tipp: [Schneide im Gelenk und setze die Gelenkkraft $X$ an. Beide Kragarme müssen sich am Gelenk gleich weit absenken.],
)[
#if not web [*Aufgabe 262* #linebreak()]
Bestimmen Sie für den skizzierten Träger mit Hilfe der Superposition (Tabelle der Grundlastfälle) die Absenkung am Gelenk $G$. Das System ist statisch unbestimmt.
#align(center)[#image(abbildungen.at("tm2k4_ue11_4"), width: 55%)]

*Gegeben und Annahmen*

$A$ eingespannt, Gelenk $G$ bei $x = a$ mit Kraft $F$, $B$ eingespannt bei $x = 3a$; $q_0$ auf dem Stück $2a$ bis $3a$; $E I$ konstant.

*Gesucht*

#enum(numbering: "a)",
[Gelenkkraft $X$ und Absenkung $w_G$.],
)
][
*Zerlegen:* Links ein Kragarm der Länge $a$ mit Endkraft $X$. Rechts ein Kragarm der Länge $2a$ mit Endkraft $F - X$ und $q_0$ auf dem Stück an der Einspannung.
][
*Linker Teil:* $w_G = X a^3\/(3 E I)$.
][
*Rechter Teil:* Endkraft: $(F - X)(2a)^3\/(3 E I)$. Streckenlast an der Einspannung (Länge $a$): Endpunkt der Last senkt sich um $q_0 a^4\/(8 E I)$ und dreht um $q_0 a^3\/(6 E I)$; dazu Hebel $a$: zusammen $7 q_0 a^4\/(24 E I)$.
][
*Verträglichkeit:* $X\/3 = 8(F - X)\/3 + 7 q_0 a\/24$, also $3X = 8F\/3 + 7 q_0 a\/24$ und $X = 8F\/9 + 7 q_0 a\/72$.
][
*Absenkung:* $w_G = X a^3\/(3 E I) = 8\/27 dot F a^3\/(E I) + 7\/216 dot q_0 a^4\/(E I)$. Der kurze linke Arm ist steifer und übernimmt den größten Teil von $F$.
]

#aufgabe(titel: "Gelenkträger aus zwei Kragarmen (Variante)", art: "rechnen", quelle: "TM2 4.4", herkunft: "variante", vorlage: "TM2-Übung 11, Aufg. 11.4", minuten: 12,
  ergebnis: [$X = F\/9 + q_0 a\/24$; $w_G = 8\/27 dot F a^3\/(E I) + 1\/9 dot q_0 a^4\/(E I)$],
)[
#if not web [*Aufgabe 263* #linebreak()]
*Gegeben und Annahmen*

$A$ eingespannt bei $x = 0$, Gelenk $G$ bei $x = 2a$ mit Kraft $F$, $B$ eingespannt bei $x = 3a$; $q_0$ auf dem ganzen rechten Stück $2a$ bis $3a$; $E I$ konstant.

*Gesucht*

#enum(numbering: "a)",
[Gelenkkraft $X$ (auf den linken Arm) und $w_G$.],
)
][
*Linker Arm (Länge 2a):* $w_G = X (2a)^3\/(3 E I) = 8 X a^3\/(3 E I)$.
][
*Rechter Arm (Länge a):* $w_G = (F - X) a^3\/(3 E I) + q_0 a^4\/(8 E I)$.
][
*Gleichsetzen:* $8X\/3 = (F - X)\/3 + q_0 a\/8$, $X = F\/9 + q_0 a\/24$. Damit $w_G = 8\/27 dot F a^3\/(E I) + 1\/9 dot q_0 a^4\/(E I)$.
]

#aufgabe(titel: "Kragträger mit veränderlichem Trägheitsmoment", art: "rechnen", quelle: "TM2 4.4", herkunft: "original", vorlage: "Altklausur 2018, Aufg. 2 j)", minuten: 12,
  ergebnis: [$M = -F(l - x)$; $w' = F\/(E I_0 l) (l^2 x - x^3\/3)$; $w = F\/(E I_0 l) (l^2 x^2\/2 - x^4\/12)$; $w(l) = 5 F l^3\/(12 E I_0)$],
  tipp: [Setze $I(x)$ direkt in $w'' = -M\/(E I)$ ein. Der Bruch $(l - x)(l + x)$ wird zu $l^2 - x^2$.],
)[
#if not web [*Aufgabe 264* #linebreak()]
*Altklausur SS 2018, S. 10:* Ein links eingespannter Kragträger wird nach rechts dünner und am freien Ende durch $F$ belastet.
#align(center)[#image(abbildungen.at("ak_2018_ix"), width: 50%)]

*Gegeben und Annahmen*

Länge $l$, $I(x) = I_0 l\/(l + x)$, $x$ ab Einspannung, $E$ konstant, $w$ nach unten positiv.

*Gesucht*

#enum(numbering: "a)",
[$M(x)$.],
[$w'(x)$ und $w(x)$.],
[Absenkung am freien Ende.],
)
][
*Moment:* Schnitt bei $x$, rechtes Stück: $M(x) = -F(l - x)$ (oben Zug).
][
*Krümmung:* $w'' = -M\/(E I) = F(l - x)(l + x)\/(E I_0 l) = F(l^2 - x^2)\/(E I_0 l)$.
][
*Integrieren:* Mit $w'(0) = 0$: $w' = F\/(E I_0 l)(l^2 x - x^3\/3)$. Mit $w(0) = 0$: $w = F\/(E I_0 l)(l^2 x^2\/2 - x^4\/12)$.
][
*Ende:* $w(l) = F l^3\/(E I_0)(1\/2 - 1\/12) = 5 F l^3\/(12 E I_0)$. Prüfen: mehr als beim prismatischen Träger ($F l^3\/(3 E I_0)$), weil er zum Ende hin weicher wird.
]

#aufgabe(titel: "Kragträger mit veränderlichem Trägheitsmoment (Variante)", art: "rechnen", quelle: "TM2 4.4", herkunft: "variante", vorlage: "Altklausur 2018, Aufg. 2 j)", minuten: 10,
  ergebnis: [$w' = F x (12 l^2 - 3 l x - 2 x^2)\/(12 E I_0 l)$; $w(l) = 3 F l^3\/(8 E I_0)$],
)[
#if not web [*Aufgabe 265* #linebreak()]
*Gegeben und Annahmen*

Kragträger wie in der Altklausur 2018, aber $I(x) = I_0 dot 2l\/(2l + x)$; Endkraft $F$, Länge $l$.

*Gesucht*

#enum(numbering: "a)",
[$w'(x)$ und $w(l)$.],
)
][
*Krümmung:* $w'' = F(l - x)(2l + x)\/(2 E I_0 l) = F(2l^2 - l x - x^2)\/(2 E I_0 l)$.
][
*Integrieren:* $w' = F\/(2 E I_0 l)(2l^2 x - l x^2\/2 - x^3\/3) = F x(12 l^2 - 3 l x - 2 x^2)\/(12 E I_0 l)$.
][
*Ende:* $w(l) = F\/(2 E I_0 l)(l^4 - l^4\/6 - l^4\/12) = 3 F l^3\/(8 E I_0)$, zwischen $1\/3$ (prismatisch) und $5\/12$ (Original).
]

#aufgabe(titel: "Randbedingungen am Dreifeldträger mit Gelenk", art: "rechnen", quelle: "TM2 4.4", herkunft: "original", vorlage: "Altklausur 2018, Aufg. 2 m)", minuten: 12,
  ergebnis: [RB: $w_I(0) = w'_I(0) = 0$, $w_(I I I)(2a) = 0$, $M_(I I I)(2a) = 0$; ÜB bei $a\/2$ und $a$ (siehe Lösung); $q_I = 2 q_0 (1 - 2x\/a)$, $q_(I I I) = q_0 x\/(2a)$; einfach statisch unbestimmt, statisch bestimmt durch Entfernen von $C$],
  tipp: [Am Gelenk ist $M = 0$ und $w$ stetig, aber $w'$ darf springen. Am Loslager ist $w = 0$, $w'$ und $M$ laufen durch.],
)[
#if not web [*Aufgabe 266* #linebreak()]
*Altklausur SS 2018, S. 11:*
#align(center)[#image(abbildungen.at("ak_2018_dreifeld"), width: 70%)]

*Gegeben und Annahmen*

$A$ feste Einspannung bei $x = 0$, Gelenk $G$ bei $a\/2$ mit Kraft $F$, Loslager $B$ bei $a$, Loslager $C$ bei $2a$. Feld I: Dreieckslast von $2 q_0$ bei $A$ auf 0 bei $G$. Feld III: Last von $q_0\/2$ bei $B$ auf $q_0$ bei $C$. Gemeinsame Koordinate $x$ ab $A$ für I und II, für III ab $B$.

*Gesucht*

#enum(numbering: "a)",
[Rand- und Übergangsbedingungen.],
[$q(x)$ je Feld.],
[Statische Bestimmtheit; wie wird das System statisch bestimmt?],
)
][
*Ränder:* Einspannung: $w_I(0) = 0$, $w'_I(0) = 0$. Loslager am Ende: $w_(I I I)(2a) = 0$, $M_(I I I)(2a) = 0$.
][
*Gelenk bei a/2:* $w_I = w_(I I)$, $M_I = 0$, $M_(I I) = 0$, $Q_I - F = Q_(I I)$ (die Kraft springt in die Querkraft). Die Neigung darf springen.
][
*Lager B bei a:* $w_(I I) = 0$, $w_(I I I) = 0$, $w'_(I I) = w'_(I I I)$, $M_(I I) = M_(I I I)$. Die Querkraft springt um die Lagerkraft.
][
*Lasten:* $q_I = 2 q_0 (1 - 2x\/a)$, $q_(I I) = 0$, $q_(I I I) = q_0\/2 (1 + x\/a)$ mit $x$ ab $B$ (die Klausurlösung schreibt bei gemeinsamer Koordinate ab $A$ $q_(I I I) = q_0 x\/(2a)$).
][
*Bestimmtheit:* Lagerreaktionen $3 + 1 + 1 = 5$, Gelenkkräfte 2, zusammen 7 Unbekannte bei $2 dot 3 = 6$ Gleichungen: einfach statisch unbestimmt. Entfernt man Lager $C$ und ersetzt es durch eine unbekannte Kraft $X$, wird das System statisch bestimmt.
]

#aufgabe(titel: "Randbedingungen am Dreifeldträger mit Gelenk (Variante)", art: "rechnen", quelle: "TM2 4.4", herkunft: "variante", vorlage: "Altklausur 2018, Aufg. 2 m)", minuten: 10,
  ergebnis: [RB: $w_I(0) = w'_I(0) = 0$, $w_(I I I)(3a) = 0$, $M_(I I I)(3a) = 0$; ÜB bei $a$: $w_I = w_(I I)$, $M_I = M_(I I) = 0$, $Q_I - F = Q_(I I)$; bei $2a$: $w_(I I) = w_(I I I) = 0$, $w'_(I I) = w'_(I I I)$, $M_(I I) = M_(I I I)$; $q_I = q_0 (1 - x\/a)$, $q_(I I I) = q_0$; einfach statisch unbestimmt],
)[
#if not web [*Aufgabe 267* #linebreak()]
*Gegeben und Annahmen*

$A$ Einspannung bei $x = 0$, Gelenk $G$ bei $a$ mit Kraft $F$, Loslager $B$ bei $2a$, Loslager $C$ bei $3a$. Feld I: Dreieckslast von $q_0$ bei $A$ auf 0 bei $G$; Feld II unbelastet; Feld III konstant $q_0$. $x$ ab $A$.

*Gesucht*

#enum(numbering: "a)",
[Rand- und Übergangsbedingungen, $q(x)$, statische Bestimmtheit.],
)
][
*Ränder:* $w_I(0) = 0$, $w'_I(0) = 0$; $w_(I I I)(3a) = 0$, $M_(I I I)(3a) = 0$.
][
*Gelenk bei a:* $w_I = w_(I I)$, $M_I = 0$, $M_(I I) = 0$, $Q_I - F = Q_(I I)$.
][
*Lager bei 2a:* $w_(I I) = 0$, $w_(I I I) = 0$, $w'_(I I) = w'_(I I I)$, $M_(I I) = M_(I I I)$.
][
*Lasten und Zählung:* $q_I = q_0(1 - x\/a)$, $q_(I I) = 0$, $q_(I I I) = q_0$. Unbekannte $5 + 2 = 7 > 6$: einfach statisch unbestimmt.
]

#aufgabe(titel: "Randbedingungen bei Parallelführung und Endmoment", art: "rechnen", quelle: "TM2 4.4", herkunft: "original", vorlage: "Altklausur unbekannt, Aufg. 2 k)", minuten: 8,
  ergebnis: [$Q(0) = 0$, $w'(0) = 0$, $w(L) = 0$, $M(L) = -M_0$ (Vorzeichen nach Drehsinn); $q(x) = q_0 (1 - x\/L)$],
  tipp: [Eine Parallelführung lässt Verschieben quer zu, aber kein Drehen und überträgt keine Querkraft.],
)[
#if not web [*Aufgabe 268* #linebreak()]
*Altklausur, Datum unbekannt, mit Musterlösung (Prüfung_unbekannt S. 4):*
#align(center)[#image(abbildungen.at("ak_unb_balken"), width: 50%)]

*Gegeben und Annahmen*

Balken der Länge $L$: in $A$ ($x = 0$) Parallelführung, in $B$ ($x = L$) Festlager mit dem eingeprägten Moment $M_0$; Dreieckslast von $q_0$ bei $A$ auf 0 bei $B$.

*Gesucht*

#enum(numbering: "a)",
[Randbedingungen und $q(x)$ für die vierfache Integration.],
[Skizze der Biegelinie.],
)
][
*Lager A:* Die Parallelführung verhindert Drehen, also $w'(0) = 0$; sie überträgt keine Querkraft: $Q(0) = 0$.
][
*Lager B:* Festlager: $w(L) = 0$. Das Moment am Ende ist das eingeprägte: $M(L) = -M_0$ (Vorzeichen nach Drehsinn von $M_0$).
][
*Last:* $q(x) = q_0 (1 - x\/L)$.
][
*Biegelinie:* Bei $A$ waagrechte Tangente, bei $B$ $w = 0$. Je nach Größe von $M_0$ gegenüber der Last biegt sich der Balken nach unten oder nach oben; im Bogen sind zwei Varianten ① und ② skizziert.
]

#aufgabe(titel: "Randbedingungen bei Einspannung und Endmoment (Variante)", art: "rechnen", quelle: "TM2 4.4", herkunft: "variante", vorlage: "Altklausur unbekannt, Aufg. 2 k)", minuten: 6,
  ergebnis: [$w(0) = 0$, $w'(0) = 0$, $w(L) = 0$, $M(L) = -M_0$; $q(x) = q_0 x\/L$; einfach statisch unbestimmt],
)[
#if not web [*Aufgabe 269* #linebreak()]
*Gegeben und Annahmen*

Balken der Länge $L$: bei $x = 0$ feste Einspannung, bei $x = L$ Loslager mit eingeprägtem Moment $M_0$; Dreieckslast von 0 bei $x = 0$ auf $q_0$ bei $x = L$.

*Gesucht*

#enum(numbering: "a)",
[Randbedingungen, $q(x)$ und statische Bestimmtheit.],
)
][
*Einspannung:* $w(0) = 0$, $w'(0) = 0$.
][
*Loslager mit Moment:* $w(L) = 0$, $M(L) = -M_0$ (Vorzeichen nach Drehsinn).
][
*Last und Zählung:* $q(x) = q_0 x\/L$. Lagerreaktionen $3 + 1 = 4 > 3$: einfach statisch unbestimmt; die vier RB reichen trotzdem für die vier Konstanten.
]

#aufgabe(titel: "Randbedingungen am Zweifeldträger mit Dachlast (SS 16)", art: "rechnen", quelle: "TM2 4.4", herkunft: "original", vorlage: "Altklausur SS 16 (PrüfungenTM2 S. 13–14, Biegelinie)", minuten: 10,
  ergebnis: [RB: $M_I(0) = 0$, $Q_I(0) = F$ (Vorzeichen nach Richtung von $F$), $w_(I I)(2a) = 0$, $w'_(I I)(2a) = 0$; ÜB bei $a$: $w_I = w_(I I) = 0$, $w'_I = w'_(I I)$, $M_I = M_(I I)$; $q_I = q_0 (1 + x\/a)$, $q_(I I) = 2 q_0 (2 - x\/a)$; einfach statisch unbestimmt],
  tipp: [Am freien Ende kennt man $M$ und $Q$, an der Einspannung $w$ und $w'$.],
)[
#if not web [*Aufgabe 270* #linebreak()]
*Altklausur SS 2016, Musterlösung (PrüfungenTM2 S. 13–14):*
#align(center)[#image(abbildungen.at("ak_p13_zweifeld"), width: 60%)]

*Gegeben und Annahmen*

$A$ freies Ende mit Kraft $F$ ($x = 0$), $B$ Loslager bei $a$, $C$ feste Einspannung bei $2a$. Streckenlast von $q_0$ bei $A$ auf $2 q_0$ bei $B$, dann linear auf 0 bei $C$. $x$ ab $A$.

*Gesucht*

#enum(numbering: "a)",
[Rand- und Übergangsbedingungen.],
[$q(x)$ je Bereich.],
[Statische Bestimmtheit.],
)
][
*Freies Ende:* Kein Moment, aber die Kraft: $M_I(0) = 0$, $Q_I(0) = F$ (Vorzeichen nach Richtung von $F$).
][
*Einspannung:* $w_(I I)(2a) = 0$, $w'_(I I)(2a) = 0$.
][
*Lager B:* $w_I(a) = 0$, $w_(I I)(a) = 0$, $w'_I = w'_(I I)$, $M_I = M_(I I)$; die Querkraft springt um die Lagerkraft.
][
*Lasten und Zählung:* $q_I = q_0 (1 + x\/a)$, $q_(I I) = 2 q_0 (2 - x\/a)$. Lagerreaktionen $3 + 1 = 4 > 3$: einfach statisch unbestimmt.
]

#aufgabe(titel: "Randbedingungen am Zweifeldträger (Variante)", art: "rechnen", quelle: "TM2 4.4", herkunft: "variante", vorlage: "Altklausur SS 16 (PrüfungenTM2 S. 13–14, Biegelinie)", minuten: 8,
  ergebnis: [RB: $M_I(0) = 0$, $Q_I(0) = F$ (Vorzeichen nach Richtung), $w_(I I)(3a) = w'_(I I)(3a) = 0$; ÜB bei $2a$: $w_I = w_(I I) = 0$, $w'_I = w'_(I I)$, $M_I = M_(I I)$; $q_I = q_0$, $q_(I I) = q_0 (3 - x\/a)$],
)[
#if not web [*Aufgabe 271* #linebreak()]
*Gegeben und Annahmen*

Freies Ende $A$ mit Kraft $F$ bei $x = 0$, Loslager $B$ bei $2a$, Einspannung $C$ bei $3a$. Bereich I konstante Last $q_0$, Bereich II linear von $q_0$ bei $B$ auf 0 bei $C$.

*Gesucht*

#enum(numbering: "a)",
[Rand- und Übergangsbedingungen, $q(x)$, Bestimmtheit.],
)
][
*Ränder:* $M_I(0) = 0$, $Q_I(0) = F$; $w_(I I)(3a) = 0$, $w'_(I I)(3a) = 0$.
][
*Lager B:* $w_I(2a) = w_(I I)(2a) = 0$, $w'_I = w'_(I I)$, $M_I = M_(I I)$.
][
*Lasten:* $q_I = q_0$, $q_(I I) = q_0 (3 - x\/a)$. $4 > 3$ Reaktionen: einfach statisch unbestimmt.
]

#aufgabe(titel: "Randbedingungen bei Trapezlast (SS 14)", art: "rechnen", quelle: "TM2 4.4", herkunft: "original", vorlage: "Altklausur SS 14 (PrüfungenTM2 S. 41)", minuten: 6,
  ergebnis: [$w(0) = 0$, $M(0) = 0$, $w(l) = 0$, $w'(l) = 0$; $q(x) = q_0 (1 + x\/(2l))$],
  tipp: [Loslager: $w$ und $M$ null. Einspannung: $w$ und $w'$ null.],
)[
#if not web [*Aufgabe 272* #linebreak()]
*Altklausur SS 2014 (PrüfungenTM2 S. 41):*

*Gegeben und Annahmen*

Balken der Länge $l$: $A$ Loslager bei $x = 0$, $B$ feste Einspannung bei $x = l$; Trapezlast von $q_0$ bei $A$ auf $"1,5" q_0$ bei $B$.

*Gesucht*

#enum(numbering: "a)",
[Randbedingungen und $q(x)$.],
)
][
*Loslager:* Es verhindert die Absenkung, lässt Drehen zu und nimmt kein Moment auf: $w(0) = 0$, $M(0) = 0$.
][
*Einspannung:* $w(l) = 0$, $w'(l) = 0$.
][
*Last:* Linear von $q_0$ auf $"1,5" q_0$: $q(x) = q_0 (1 + x\/(2l))$. Prüfen: $q(l) = "1,5" q_0$.
]

#aufgabe(titel: "Randbedingungen bei Trapezlast (Variante)", art: "rechnen", quelle: "TM2 4.4", herkunft: "variante", vorlage: "Altklausur SS 14 (PrüfungenTM2 S. 41)", minuten: 5,
  ergebnis: [$w(0) = w'(0) = 0$, $w(l) = 0$, $M(l) = 0$; $q(x) = q_0 (2 - x\/l)$],
)[
#if not web [*Aufgabe 273* #linebreak()]
*Gegeben und Annahmen*

Balken der Länge $l$: feste Einspannung bei $x = 0$, Loslager bei $x = l$; Trapezlast von $2 q_0$ bei $x = 0$ auf $q_0$ bei $x = l$.

*Gesucht*

#enum(numbering: "a)",
[Randbedingungen und $q(x)$.],
)
][
*Einspannung:* $w(0) = 0$, $w'(0) = 0$.
][
*Loslager:* $w(l) = 0$, $M(l) = 0$.
][
*Last:* $q(x) = q_0 (2 - x\/l)$; $q(0) = 2 q_0$, $q(l) = q_0$.
]

#kapitel("TM2 Kapitel 5 · Torsion: Spannung und Verdrehung")

#aufgabe(titel: "Wie ist die Schubspannung bei Torsion einer Vollwelle verteilt?", art: "verstehen", quelle: "TM2 5.1", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 274* #linebreak()]
Wie ist die Schubspannung bei Torsion einer Vollwelle verteilt?
][
*Antwort:*
- *Linear über den Radius:* null in der Mitte, am größten am Rand:
- $ tau = M_T/I_p r $ Das Material in der Mitte trägt wenig, deshalb sind Hohlwellen leichter bei fast gleicher Tragfähigkeit.
]

#aufgabe(titel: "Ist das Torsionsträgheitsmoment I_T immer gleich dem polaren Trägheitsmoment I_p?", art: "verstehen", quelle: "TM2 5.1", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 275* #linebreak()]
Ist das Torsionsträgheitsmoment $I_T$ immer gleich dem polaren Trägheitsmoment $I_p$?
][
*Antwort:*
- Nein, nur beim Kreis- und Kreisringquerschnitt.
- Bei anderen Querschnitten verwölben sich die Querschnitte, und $I_T$ ist kleiner als $I_p$.
][
*Merksatz:* Torsionsträgheitsmoment und polares Flächenträgheitsmoment stimmen nur bei Kreis und Kreisring überein.
]

#aufgabe(titel: "Welche zwei Nachweise führt man bei Torsion?", art: "verstehen", quelle: "TM2 5.1", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 276* #linebreak()]
Welche zwei Nachweise führt man bei Torsion?
][
*Antwort:*
- Den Spannungsnachweis ($tau_max <= tau_"zul"$) und den Verformungsnachweis ($Delta theta <= Delta theta_"zul"$).
- Beide getrennt, denn ein Bauteil kann fest genug, aber zu weich sein, oder umgekehrt.
][
*Merksatz:* Fest genug und steif genug getrennt prüfen.
]

#aufgabe(titel: "Mindestdurchmesser einer Welle", art: "rechnen", quelle: "TM2 5.1", herkunft: "original", vorlage: "TM2-Übung 12, Aufg. 12.1", minuten: 6,
  ergebnis: [$d_("min") approx "58,84" thin "mm"$],
  tipp: [Setze $tau_("max") = M_T\/W_T$ gleich der zulässigen Spannung und löse nach d auf. Rechne $M_T$ vorher in Nmm um.],
)[
#if not web [*Aufgabe 277* #linebreak()]
*Eigene Zahlen zum Modell Übung 12.1:*

*Gegeben und Annahmen*

Vollwelle mit $M_T=1800 "Nm"$, zulässiger Schubspannung $tau_("zul")=45 "N/mm"^2$.

*Gesucht*

#enum(numbering: "a)",
[Welcher Mindestdurchmesser folgt nur aus der Spannung?],
)
][
*Bild:* Eine dickere Welle verteilt das Moment auf mehr Material weiter außen. $W_T$ wächst mit $d^3$, deshalb hilft schon ein etwas größerer Durchmesser stark.
][
*Bedingung:* $tau_("max") = M_T\/W_T <= tau_("zul")$ mit $W_T = pi d^3\/16$ für die Vollwelle. Umgestellt: $d >= (16M_T\/(pi tau_("zul")))^(1\/3)$.
][
*Einheiten angleichen:* $M_T = 1800 thin "Nm" = 1800000 thin "Nmm"$, damit alles in N und mm steht.
][
*Rechnen:* $16 dot 1800000\/(pi dot 45) approx 203718 thin "mm"^3$. Die Kubikwurzel gibt *$d_("min") approx "58,84" thin "mm"$*.
][
*Prüfen:* Unter der Wurzel steht mm³, heraus kommt mm. Eine zusätzliche Grenze für die Verdrehung kann einen größeren Durchmesser verlangen.
]

#aufgabe(titel: "Mindestdurchmesser einer Welle (Variante)", art: "rechnen", quelle: "TM2 5.1", herkunft: "variante", vorlage: "TM2-Übung 12, Aufg. 12.1", minuten: 5,
  ergebnis: [$d_("min") approx "50,78" "mm"$],
)[
#if not web [*Aufgabe 278* #linebreak()]
*Gegeben und Annahmen*

Vollwelle mit $M_T = 900 "Nm"$, $tau_("zul") = 35 "N/mm"^2$.

*Gesucht*

#enum(numbering: "a)",
[Mindestdurchmesser aus der Spannung.],
)
][
*Bedingung:* $d >= (16 M_T\/(pi tau_("zul")))^(1\/3)$ mit $M_T = 900000 "Nmm"$.
][
*Rechnen:* $16 dot 900000\/(pi 35) = 130963 "mm"^3$, Kubikwurzel $d_("min") approx "50,78" "mm"$.
]

#aufgabe(titel: "Welle nach Verdrehung bemessen, voll und hohl", art: "rechnen", quelle: "TM2 5.1", herkunft: "original", vorlage: "TM2-Übung 12, Aufg. 12.1 b)–c)", minuten: 18,
  ergebnis: [a) $d = "58,84" "mm"$; b) $d = "85,13" "mm"$; c) Hohlwelle $t = 10 "mm"$: dünnwandig $d_a = "60,46"$ (Spannung) bzw. $"96,92" "mm"$ (Verdrehung), dickwandig $d_a approx 64$ bzw. $"96,6" "mm"$; Fläche voll $5692$, hohl $approx 2720 "mm"^2$],
  tipp: [Die Verdrehbedingung lautet $theta' = M_T\/(G I_T) <= theta'_("zul")$. Den Winkel vorher in rad pro mm umrechnen.],
)[
#if not web [*Aufgabe 279* #linebreak()]
Eine Stahlwelle mit Kreisquerschnitt wird durch ein Torsionsmoment $M_T$ belastet. Dimensionieren Sie den Durchmesser für die folgenden Anforderungen.
#align(center)[#image("abbildungen/ue2_12_1.png", width: 50%)]

*Gegeben und Annahmen*

$M_T = 1800 "Nm"$, $G = 80000 "N/mm"^2$, $tau_("zul") = 45 "N/mm"^2$, zulässige Verdrehung je Länge $"0,25" "°/m"$. Hohlwelle mit Wandstärke $10 "mm"$.

*Gesucht*

#enum(numbering: "a)",
[Durchmesser aus der Schubspannung.],
[Durchmesser aus der Verdrehung je Länge.],
[Dasselbe für die Hohlwelle, dickwandig und dünnwandig gerechnet; Vergleich der Querschnittsflächen.],
)
][
*Spannung (Vollwelle):* $W_T = pi d^3\/16$, also $d = (16 M_T\/(pi tau_("zul")))^(1\/3) = "58,84" "mm"$.
][
*Verdrehung umrechnen:* $"0,25" "°/m" = "0,25" dot pi\/180\/1000 = "4,363" dot 10^(-6) "rad/mm"$.
][
*Verdrehung (Vollwelle):* $I_T = pi d^4\/32$: $d = (32 M_T\/(pi G theta'))^(1\/4) = "85,13" "mm"$. Maßgebend ist die Verdrehung.
][
*Hohlwelle dünnwandig:* $W_T = 2 pi r_m^2 t$, $I_T = 2 pi r_m^3 t$. Spannung: $r_m = sqrt(M_T\/(2 pi tau t)) = "25,23"$, $d_a = 2 r_m + t = "60,46" "mm"$. Verdrehung: $r_m = (M_T\/(2 pi G theta' t))^(1\/3) = "43,46"$, $d_a = "96,92" "mm"$.
][
*Hohlwelle dickwandig:* $I_T = pi(d_a^4 - d_i^4)\/32$ mit $d_i = d_a - 20$; durch Probieren: Spannung $d_a approx 64 "mm"$, Verdrehung $d_a approx "96,6" "mm"$.
][
*Vergleich:* Vollwelle $pi "85,13"^2\/4 = 5692 "mm"^2$, Hohlwelle $pi("96,6"^2 - "76,6"^2)\/4 approx 2720 "mm"^2$ (dünnwandig gerechnet fast gleich). Die Hohlwelle spart über die Hälfte des Materials.
]

#aufgabe(titel: "Welle nach Verdrehung bemessen (Variante)", art: "rechnen", quelle: "TM2 5.1", herkunft: "variante", vorlage: "TM2-Übung 12, Aufg. 12.1 b)–c)", minuten: 15,
  ergebnis: [Vollwelle: $d = "63,38"$ (Spannung), $"88,30" "mm"$ (Verdrehung); Hohlwelle $t = 8$: dünnwandig $d_a = "71,08"$ / $"106,30" "mm"$, dickwandig $"74,29"$ / $"106,08" "mm"$; Flächen $6124$ zu $2465 "mm"^2$],
)[
#if not web [*Aufgabe 280* #linebreak()]
*Gegeben und Annahmen*

$M_T = 2500 "Nm"$, $G = 80000 "N/mm"^2$, $tau_("zul") = 50 "N/mm"^2$, zulässige Verdrehung $"0,3" "°/m"$; Hohlwelle mit $t = 8 "mm"$.

*Gesucht*

#enum(numbering: "a)",
[Vollwelle nach Spannung und nach Verdrehung.],
[Hohlwelle dünn- und dickwandig gerechnet, Flächenvergleich.],
)
][
*Vollwelle:* $d = (16 dot "2,5" dot 10^6\/(pi 50))^(1\/3) = "63,38" "mm"$; $theta' = "5,236" dot 10^(-6) "rad/mm"$, $d = (32 M_T\/(pi G theta'))^(1\/4) = "88,30" "mm"$.
][
*Dünnwandig:* $r_m = sqrt(M_T\/(2 pi tau t)) = "31,54"$, $d_a = "71,08"$; $r_m = (M_T\/(2 pi G theta' t))^(1\/3) = "49,15"$, $d_a = "106,30" "mm"$.
][
*Dickwandig:* durch Probieren $d_a = "74,29"$ bzw. $"106,08" "mm"$; maßgebend $"106,1" "mm"$.
][
*Flächen:* voll $pi "88,30"^2\/4 = 6124 "mm"^2$, hohl $pi("106,08"^2 - "90,08"^2)\/4 = 2465 "mm"^2$.
]

#aufgabe(titel: "Konischer Stab unter Torsion", art: "rechnen", quelle: "TM2 5.1", herkunft: "original", vorlage: "TM2-Übung 12, Aufg. 12.2", minuten: 12,
  ergebnis: [$tau(x) = 2 M_T\/(pi a^3 (2 - x\/l)^3)$; $theta(x) = 2 M_T l\/(3 G pi a^4) (1\/(2 - x\/l)^3 - 1\/8)$],
  tipp: [Zuerst $r(x)$ aufschreiben. $theta' = M_T\/(G I_T(x))$ einmal integrieren, an der Einspannung ist $theta = 0$.],
)[
#if not web [*Aufgabe 281* #linebreak()]
Ein konischer Stab mit linear veränderlichem Radius wird durch das Torsionsmoment $M_T$ belastet. Zu bestimmen sind die Verdrehung und die Randspannung als Funktionen von $x$.
#align(center)[#image("abbildungen/ue2_12_2.png", width: 50%)]

*Gegeben und Annahmen*

Eingespannt bei $x = 0$ mit Durchmesser $4a$, freies Ende bei $x = l$ mit Durchmesser $2a$; $M_T$ am freien Ende; $G$ konstant.

*Gesucht*

#enum(numbering: "a)",
[Randspannung $tau(x)$.],
[Verdrehung $theta(x)$.],
)
][
*Radius:* Linear von $2a$ auf $a$: $r(x) = a(2 - x\/l)$.
][
*Spannung:* $tau = M_T r\/I_T = 2 M_T\/(pi r^3) = 2 M_T\/(pi a^3 (2 - x\/l)^3)$. Am dünnen Ende ist sie achtmal so groß wie an der Einspannung.
][
*Verdrillung:* $theta' = M_T\/(G pi r^4\/2) = 2 M_T\/(G pi a^4 (2 - x\/l)^4)$.
][
*Integrieren:* Mit $theta(0) = 0$: $theta(x) = 2 M_T l\/(3 G pi a^4) ((2 - x\/l)^(-3) - 1\/8)$. Am Ende $theta(l) = 7 M_T l\/(12 G pi a^4)$.
]

#aufgabe(titel: "Stärker konischer Stab unter Torsion (Variante)", art: "rechnen", quelle: "TM2 5.1", herkunft: "variante", vorlage: "TM2-Übung 12, Aufg. 12.2", minuten: 10,
  ergebnis: [$tau(x) = 2 M_T\/(pi a^3 (3 - 2x\/l)^3)$; $theta(x) = M_T l\/(3 G pi a^4) ((3 - 2x\/l)^(-3) - 1\/27)$; $theta(l) = 26 M_T l\/(81 G pi a^4)$],
)[
#if not web [*Aufgabe 282* #linebreak()]
*Gegeben und Annahmen*

Konischer Stab, eingespannt bei $x = 0$ mit Radius $3a$, freies Ende bei $x = l$ mit Radius $a$, Moment $M_T$ am Ende, $G$ konstant.

*Gesucht*

#enum(numbering: "a)",
[$tau(x)$ und $theta(x)$.],
)
][
*Radius:* $r(x) = a(3 - 2x\/l)$.
][
*Spannung:* $tau = 2 M_T\/(pi r^3) = 2 M_T\/(pi a^3 (3 - 2x\/l)^3)$.
][
*Verdrehung:* $theta' = 2 M_T\/(G pi a^4 (3 - 2x\/l)^4)$; integriert mit $theta(0) = 0$: $theta = M_T l\/(3 G pi a^4)((3 - 2x\/l)^(-3) - 1\/27)$.
]

#aufgabe(titel: "Materialfläche und Mittellinienfläche", art: "verstehen", quelle: "TM2 5.2", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 283* #linebreak()]
Welche zwei unterschiedlichen Geometriegrößen sind Materialfläche A und Mittellinienfläche Aₘ?
][
A ist die tatsächlich vorhandene Materialfläche. Aₘ ist die vom mittleren Wandverlauf eingeschlossene Fläche und enthält bei einem Hohlprofil überwiegend den Hohlraum.
]

#aufgabe(titel: "Ort der größten Torsionsspannung", art: "verstehen", quelle: "TM2 5.2", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 284* #linebreak()]
Wo liegt die größte Torsionsspannung bei geschlossenen bzw. offenen dünnwandigen Profilen?
][
Geschlossen: dünnste Wand. Offen im schmalen Rechteckstreifenmodell: dickster Teil. Die Voraussetzungen der jeweiligen Formel gehören zur Antwort.
]

#aufgabe(titel: "Was ist der Schubfluss bei einem dünnwandigen geschlossenen Profil?", art: "verstehen", quelle: "TM2 5.2", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 285* #linebreak()]
Was ist der Schubfluss bei einem dünnwandigen geschlossenen Profil?
][
*Antwort:*
- $T = tau t$ ist entlang des Umfangs konstant (Bredt).
- Wo die Wand dünner ist, muss $tau$ deshalb größer sein.
- Die größte Schubspannung sitzt an der dünnsten Stelle.
#align(center)[#image(abbildungen.at("ak24-querschnitt"), width: 60%)]
][
*Merksatz:* Geschlossen und dünnwandig: dünnste Wand, größte Schubspannung.
][
*Bild:* Wasser in einem Ringkanal: Die Menge pro Sekunde ist überall gleich, an engen Stellen fließt es schneller.
]

#aufgabe(titel: "Dreieckiger Hohlquerschnitt: Wanddicken festlegen", art: "rechnen", quelle: "TM2 5.2", herkunft: "original", vorlage: "TM2-Übung 12, Aufg. 12.4", minuten: 18,
  ergebnis: [$tau_("max") = 2 M_T\/(sqrt(3) a^2 delta_1)$ in der dünnen Wand $delta_1$; $theta(l) = 4 M_T l (2 delta_1 + delta_2)\/(3 G a^3 delta_1 delta_2)$; $delta_1 = "0,1" "cm"$, $delta_2 = "0,2" "cm"$],
  tipp: [Erst $delta_1$ aus der Spannung (sie hängt nur von $t_("min")$ ab), dann $delta_2$ aus der Verdrehung.],
)[
#if not web [*Aufgabe 286* #linebreak()]
Gegeben ist ein dreieckiger, dünnwandiger Hohlquerschnitt ($delta_1 < delta_2$). Er ist links so eingespannt, dass er sich nicht verdrehen kann (Verschiebungen in $x$-Richtung möglich), und durch $M_T$ belastet.
#align(center)[#image("abbildungen/ue2_12_4.png", width: 35%)]

*Gegeben und Annahmen*

Gleichseitiges Dreieck mit Seitenlänge $a$ (Mittellinie): eine Seite Wanddicke $delta_1$, zwei Seiten $delta_2$. $G = "0,8" dot 10^7 "N/cm"^2$, $M_T = 350 sqrt(3) "Ncm"$, $tau_("zul") = 7000 "N/cm"^2$, $l = 100 "cm"$, $a = 1 "cm"$, Verdrillwinkel am Ende höchstens $7 sqrt(3)\/60 "rad"$.

*Gesucht*

#enum(numbering: "a)",
[Formeln für $tau_("max")$, ihren Ort und die Verdrehung.],
[$delta_1$ und $delta_2$ für die gegebenen Grenzen.],
)
][
*Bredt:* $A_m = sqrt(3) a^2\/4$. $tau_("max") = M_T\/(2 A_m t_("min")) = 2 M_T\/(sqrt(3) a^2 delta_1)$, in der dünnsten Wand $delta_1$.
][
*Torsionsträgheitsmoment:* $integral.cont d s\/t = a\/delta_1 + 2a\/delta_2 = a(2 delta_1 + delta_2)\/(delta_1 delta_2)$, $I_T = (2 A_m)^2\/integral.cont = 3 a^3 delta_1 delta_2\/(4(2 delta_1 + delta_2))$.
][
*Verdrehung:* $theta(l) = M_T l\/(G I_T) = 4 M_T l (2 delta_1 + delta_2)\/(3 G a^3 delta_1 delta_2)$.
][
*Dicke aus Spannung:* $delta_1 = 2 M_T\/(sqrt(3) a^2 tau_("zul")) = 2 dot 350 sqrt(3)\/(sqrt(3) dot 7000) = "0,1" "cm"$.
][
*Dicke aus Verdrehung:* Umgestellt $delta_2 = 8 M_T l delta_1\/(3 G a^3 delta_1 theta - 4 M_T l) = 48497\/(485 000 - 242 487) = "0,2" "cm"$.
]

#aufgabe(titel: "Dreieckiger Hohlquerschnitt (Variante)", art: "rechnen", quelle: "TM2 5.2", herkunft: "variante", vorlage: "TM2-Übung 12, Aufg. 12.4", minuten: 14,
  ergebnis: [$delta_1 = "0,0802" "cm"$, $delta_2 = "0,219" "cm"$],
)[
#if not web [*Aufgabe 287* #linebreak()]
*Gegeben und Annahmen*

Dreieckiger Hohlquerschnitt wie Übung 12.4 (eine Seite $delta_1$, zwei Seiten $delta_2$), $a = "1,2" "cm"$, $l = 120 "cm"$, $M_T = 600 "Ncm"$, $G = "0,8" dot 10^7 "N/cm"^2$, $tau_("zul") = 6000 "N/cm"^2$, Verdrillwinkel am Ende höchstens $"0,15" "rad"$.

*Gesucht*

#enum(numbering: "a)",
[$delta_1$ und $delta_2$.],
)
][
*Spannung:* $delta_1 = 2 dot 600\/(sqrt(3) dot "1,44" dot 6000) = "0,0802" "cm"$.
][
*Verdrehung:* $3 G a^3 delta_1 theta = 3 dot "0,8" dot 10^7 dot "1,728" dot "0,0802" dot "0,15" = 498 900$; $4 M_T l = 288 000$; $8 M_T l delta_1 = 46 190$. $delta_2 = 46190\/(498900 - 288000) = "0,219" "cm"$.
]

#aufgabe(titel: "Geschlossenes Profil aus Halbring und Steg: Torsion und Druck", art: "rechnen", quelle: "TM2 5.2", herkunft: "original", vorlage: "Altklausur PrüfungenTM2 S. 29 (Torsion)", minuten: 15,
  ergebnis: [a) geschlossen; b) $A_m = "568,6" "mm"^2$, $W_T = 5686 "mm"^3$, $I_T approx 68070 "mm"^4$; c) $sigma = -"21,1" "N/mm"^2$, $Delta l = -"0,10" "mm"$, Gefahr Knicken; d) $M_T = 450 "Nm"$, $Delta theta = "0,0818" "rad" = "4,69"°$; e) $tau = "79,2" "N/mm"^2$ am ganzen Umfang],
  tipp: [$A_m$ ist die von der Mittellinie umschlossene Fläche, nicht die Materialfläche. Die Druckspannung rechnet dagegen mit der Materialfläche.],
)[
#if not web [*Aufgabe 288* #linebreak()]
*Altklausur mit Musterlösung (PrüfungenTM2 S. 29):* Profil aus der Biegeaufgabe (Halbring mit Steg), einseitig eingespannt.
#align(center)[#image(abbildungen.at("ak_p25_profil"), width: 85%)]

*Gegeben und Annahmen*

$r_i = 15$, $t = 5$, $h = 40$ mm, Materialfläche $A = "474,89" "mm"^2$; Mittellinie: Halbkreis $r_m = "17,5" "mm"$, Steg-Mittellinie $35 "mm"$, zwei kurze Verbindungsstücke je $"2,5" "mm"$. $l_1 = "0,5" "m"$, $l_2 = 1 "m"$, $F_1 = "0,9" "kN"$, $F_2 = 10 "kN"$ (Druck längs $l_2$), $E = "2,1" dot 10^5$, $G = "0,808" dot 10^5 "N/mm"^2$.

*Gesucht*

#enum(numbering: "a)",
[Offen oder geschlossen?],
[$A_m$, $W_T$, $I_T$.],
[Druckspannung und $Delta l$ durch $F_2$ auf $l_2$; welche Gefahr?],
[$M_T$ aus $F_1$ und Verdrehung über $l_2$ in Grad.],
[Wo und wie groß ist $tau_("max")$?],
)
][
*Art:* Halbring und Steg bilden eine geschlossene Zelle.
][
*Kennwerte:* $A_m = 1\/2 pi "17,5"^2 + "2,5" dot 35 = "568,6" "mm"^2$. $W_T = 2 A_m t = 5686 "mm"^3$. $integral.cont d s\/t = (pi "17,5" + 35 + 5)\/5 = 19$, $I_T = (2 A_m)^2\/19 approx 68070 "mm"^4$.
][
*Druck:* $sigma = -10000\/"474,89" = -"21,1" "N/mm"^2$, $Delta l = sigma l_2\/E = -"0,10" "mm"$. Ein schlanker Druckstab kann knicken.
][
*Torsion:* $F_1$ greift mit Hebel $l_1$ an: $M_T = 900 dot 500 = 450 "Nm"$. $Delta theta = M_T l_2\/(G I_T) = 450000 dot 1000\/(80800 dot 68070) = "0,0818" "rad" = "4,69"°$.
][
*Größte Schubspannung:* $tau = M_T\/W_T = 450000\/5686 = "79,2" "N/mm"^2$, am ganzen Umfang gleich, weil $t$ konstant ist, und über die ganze Länge, weil $M_T$ konstant ist.
]

#aufgabe(titel: "Geschlossenes Profil aus Halbring und Steg (Variante)", art: "rechnen", quelle: "TM2 5.2", herkunft: "variante", vorlage: "Altklausur PrüfungenTM2 S. 29 (Torsion)", minuten: 12,
  ergebnis: [$A_m = "907,7" "mm"^2$, $W_T = 9077 "mm"^3$, $I_T approx 136540 "mm"^4$; $sigma = -"19,9" "N/mm"^2$, $Delta l = -"0,076" "mm"$; $M_T = 300 "Nm"$, $Delta theta = "1,25"°$; $tau = "33,0" "N/mm"^2$],
)[
#if not web [*Aufgabe 289* #linebreak()]
*Gegeben und Annahmen*

Halbring $r_i = 20$, $t = 5$ mm mit Steg $5 times 50$ mm; Materialfläche $"603,4" "mm"^2$; Mittellinie: Halbkreis $r_m = "22,5"$, Steg $45$, Verbindungsstücke $2 times "2,5" "mm"$. $l_1 = "0,5" "m"$, $l_2 = "0,8" "m"$, $F_1 = "0,6" "kN"$, $F_2 = 12 "kN"$, $E = "2,1" dot 10^5$, $G = "0,808" dot 10^5 "N/mm"^2$.

*Gesucht*

#enum(numbering: "a)",
[$A_m$, $W_T$, $I_T$.],
[Druckspannung und $Delta l$.],
[$M_T$, Verdrehung und $tau_("max")$.],
)
][
*Kennwerte:* $A_m = 1\/2 pi "22,5"^2 + "2,5" dot 45 = "907,7"$; $W_T = 9077 "mm"^3$; $integral.cont d s\/t = ("70,69" + 45 + 5)\/5 = "24,14"$, $I_T = "1815,4"^2\/"24,14" = 136540 "mm"^4$.
][
*Druck:* $sigma = -12000\/"603,4" = -"19,9" "N/mm"^2$, $Delta l = -"19,9" dot 800\/210000 = -"0,076" "mm"$.
][
*Torsion:* $M_T = 600 dot 500 = 300 "Nm"$; $Delta theta = 300000 dot 800\/(80800 dot 136540) = "0,0218" "rad" = "1,25"°$; $tau = 300000\/9077 = "33,0" "N/mm"^2$.
]

#aufgabe(titel: "Kreisring mit Dreiecksanbau unter Torsion und Druck", art: "rechnen", quelle: "TM2 5.2", herkunft: "original", vorlage: "Altklausur unbekannt, Aufg. 2 (Torsion, S. 3)", minuten: 12,
  ergebnis: [a) geschlossen, $tau_("max")$ bei $t_("min") = t_2$; b) $I_T approx 98600 "mm"^4$, $W_T = 5511 "mm"^3$; c) $sigma = -"22,3" "N/mm"^2$, $Delta l = -"0,106" "mm"$, Gefahr Knicken],
  tipp: [Bei geschlossenen Profilen ist der Schubfluss konstant; die dünnste Wand hat die größte Spannung.],
)[
#if not web [*Aufgabe 290* #linebreak()]
*Altklausur, Datum unbekannt, mit Musterlösung (Prüfung_unbekannt S. 3):*
#align(center)[#image(abbildungen.at("ak_unb_torsion"), width: 70%)]

*Gegeben und Annahmen*

Symmetrisches Profil aus Kreisring und dreieckigem Anbau: $r_i = 15$, $t_1 = 5$, $t_2 = "3,5"$ mm, $l = 1 "m"$, $F_2 = 10 "kN"$ (Druck). Vorgegeben: $A_m = "787,3" "mm"^2$, $integral.cont d s\/t = "25,14"$, Materialfläche $A = "449,3" "mm"^2$, $E = "2,1" dot 10^5 "N/mm"^2$.

*Gesucht*

#enum(numbering: "a)",
[Offen oder geschlossen? Wo liegt $tau_("max")$?],
[$I_T$ und $W_T$.],
[Druckspannung, $Delta l$ und Gefahr.],
)
][
*Art:* Ring und Dreieck schließen eine Zelle, also geschlossen. Der Schubfluss $T = M_T\/(2 A_m)$ ist überall gleich; $tau = T\/t$ ist am größten in den dünnen Dreiecksseiten $t_2$.
][
*Kennwerte:* $I_T = (2 A_m)^2\/integral.cont = "1574,6"^2\/"25,14" approx 98600 "mm"^4$; $W_T = 2 A_m t_("min") = 2 dot "787,3" dot "3,5" = 5511 "mm"^3$.
][
*Druck:* $sigma = -10000\/"449,3" = -"22,3" "N/mm"^2$; $Delta l = sigma l\/E = -"0,106" "mm"$; der schlanke Stab kann knicken.
]

#aufgabe(titel: "Kreisring mit Dreiecksanbau (Variante)", art: "rechnen", quelle: "TM2 5.2", herkunft: "variante", vorlage: "Altklausur unbekannt, Aufg. 2 (Torsion, S. 3)", minuten: 8,
  ergebnis: [$I_T approx 115710 "mm"^4$, $W_T = 5400 "mm"^3$; $sigma = -24 "N/mm"^2$, $Delta l = -"0,137" "mm"$],
)[
#if not web [*Aufgabe 291* #linebreak()]
*Gegeben und Annahmen*

Geschlossenes Profil mit $A_m = 900 "mm"^2$, $integral.cont d s\/t = 28$, dünnste Wand $t_("min") = 3 "mm"$, Materialfläche $500 "mm"^2$; Länge $"1,2" "m"$, Druckkraft $12 "kN"$, $E = "2,1" dot 10^5 "N/mm"^2$.

*Gesucht*

#enum(numbering: "a)",
[$I_T$ und $W_T$.],
[Druckspannung und $Delta l$.],
)
][
*Kennwerte:* $I_T = 1800^2\/28 = 115710 "mm"^4$, $W_T = 2 dot 900 dot 3 = 5400 "mm"^3$.
][
*Druck:* $sigma = -12000\/500 = -24 "N/mm"^2$, $Delta l = -24 dot 1200\/210000 = -"0,137" "mm"$.
]

#aufgabe(titel: "Dreiecksprofile bei Biegung und Torsion (Altklausur 2018)", art: "verstehen", quelle: "TM2 5.3", herkunft: "original", vorlage: "Altklausur 2018, Aufg. 2 h)",
  ergebnis: [a) $S$ auf der Symmetrieachse nahe der dicken Wand; $sigma_("max")$ in den am weitesten entfernten Ecken; b) geschlossen: $tau_("max")$ in den dünnen Wänden $t_2$; offen: in der dicken Wand $t_1$; c) das geschlossene Profil],
  tipp: [Geschlossen: $tau = M_T\/(2 A_m t)$, also groß bei kleinem $t$. Offen: $tau = M_T t\/I_T$, also groß bei großem $t$.],
)[
#if not web [*Aufgabe 292* #linebreak()]
*Altklausur SS 2018, S. 10:* Profile aus Rechtecken mit den Dicken $t_1 >> t_2$ (ohne Rechnung).
#align(center)[#image(abbildungen.at("ak_2018_torsion"), width: 75%)]

a) Bild links, Biegung um $y$: Wo liegen $S$ und die größte Biegespannung? b) Bild Mitte (geschlossen) und rechts (offen), Torsion: Wo liegt jeweils $tau_("max")$? c) Welcher Querschnitt hat bei gleichem $M_T$ deutlich kleinere Verdrehung und Spannung?
][
*Biegung:* Die dicke Wand zieht den Schwerpunkt auf der Symmetrieachse zu sich. Die größte Biegespannung sitzt am weitesten von der Biegeachse $y$ entfernt, in den äußeren Ecken.
][
*Geschlossen:* Der Schubfluss $T$ ist konstant, $tau = T\/t$: Maximum in den dünnen Wänden $t_2$.
][
*Offen:* Jede Wand trägt wie ein schmales Rechteck, $tau = M_T t\/I_T$: Maximum in der dicken Wand $t_1$.
][
*Vergleich:* Das geschlossene Profil ist um Größenordnungen steifer und weniger beansprucht, weil $I_T$ mit $A_m^2$ statt mit $t^3$ wächst. Typische Verwechslung: beim offenen Profil die dünnste Wand als gefährdet ansehen.
]

#aufgabe(titel: "Warum verdreht sich ein geschlitztes Rohr so viel stärker als ein geschlossenes?", art: "verstehen", quelle: "TM2 5.3", herkunft: "eigen", minuten: 2)[
#if not web [*Aufgabe 293* #linebreak()]
Warum verdreht sich ein geschlitztes Rohr so viel stärker als ein geschlossenes?
][
*Antwort:*
- Im geschlossenen Profil läuft der Schubfluss einmal um den ganzen Umfang und nutzt die große eingeschlossene Fläche.
- Im offenen Profil fließt der Schub nur hin und zurück innerhalb der dünnen Wand.
- $I_T$ schrumpft dadurch drastisch, oft um mehrere Größenordnungen.
#align(center)[#image(abbildungen.at("ak_2018_torsion"), width: 60%)]
][
*Merksatz:* Ein Schlitz unterbricht den umlaufenden Schubfluss.
][
*Bild:* Ein geschlossener Ring wirkt zusammen; der Schlitz macht daraus einen offenen Streifen. Die genaue Steifigkeit liefert das passende Modell.
]

#aufgabe(titel: "Ringprofil mit ungleichen Wandhälften, geschlossen und geschlitzt", art: "rechnen", quelle: "TM2 5.3", herkunft: "original", vorlage: "TM2-Übung 12, Aufg. 12.3", minuten: 15,
  ergebnis: [a) $I_T = 8\/3 pi R_m^3 delta$, $tau_("max") = M_T\/(2 pi R_m^2 delta)$ im dünnen Teil; b) $I_T = 3 pi R_m delta^3$, $tau_("max") = 2 M_T\/(3 pi R_m delta^2)$ im dicken Teil; c) $tau_b\/tau_a = 4 R_m\/(3 delta) >> 1$, $theta_b\/theta_a = 8 R_m^2\/(9 delta^2) >>> 1$],
  tipp: [Geschlossen: Bredt mit $integral.cont d s\/t$. Offen: Summe $h t^3\/3$, und die größte Spannung sitzt in der dicksten Wand.],
)[
#if not web [*Aufgabe 294* #linebreak()]
Ein Profil der Länge $L$ mit dem skizzierten Querschnitt ($delta << R_m$) wird durch ein Torsionsmoment $M_T$ um die Längsachse belastet.
#align(center)[#image("abbildungen/ue2_12_3.png", width: 35%)]

*Gegeben und Annahmen*

Kreisring mit Mittelradius $R_m$; obere Hälfte Wanddicke $delta$, untere Hälfte $2 delta$.

*Gesucht*

#enum(numbering: "a)",
[$I_T$ und $tau_("max")$ (Größe und Ort) für den ungeschlitzten Querschnitt.],
[Dasselbe mit Längsschlitz bei $B$.],
[Vergleich von $tau_("max")$ und Verdrehung b) zu a).],
)
][
*Geschlossen:* $A_m = pi R_m^2$, $integral.cont d s\/t = pi R_m\/delta + pi R_m\/(2delta) = 3 pi R_m\/(2delta)$. $I_T = (2 A_m)^2\/integral.cont = 8\/3 pi R_m^3 delta$.
][
*Spannung geschlossen:* Der Schubfluss ist überall gleich, also $tau$ am größten bei der kleinsten Dicke: $tau_("max") = M_T\/(2 A_m delta) = M_T\/(2 pi R_m^2 delta)$ im dünnen Teil.
][
*Geschlitzt:* Zwei offene Rechtecke $pi R_m times delta$ und $pi R_m times 2delta$: $I_T = 1\/3 pi R_m (delta^3 + 8 delta^3) = 3 pi R_m delta^3$. $tau_("max") = M_T t_("max")\/I_T = 2 M_T\/(3 pi R_m delta^2)$ im dicken Teil.
][
*Vergleich:* $tau_b\/tau_a = 2 M_T\/(3 pi R_m delta^2) dot 2 pi R_m^2 delta\/M_T = 4 R_m\/(3 delta)$. $theta_b\/theta_a = I_(T a)\/I_(T b) = 8 R_m^2\/(9 delta^2)$. Bei $R_m = 20 delta$ also etwa 27-mal mehr Spannung und 356-mal mehr Verdrehung.
]

#aufgabe(titel: "Ringprofil mit ungleichen Wandhälften (Variante)", art: "rechnen", quelle: "TM2 5.3", herkunft: "variante", vorlage: "TM2-Übung 12, Aufg. 12.3", minuten: 12,
  ergebnis: [a) $I_T = 3 pi R_m^3 delta$, $tau_("max") = M_T\/(2 pi R_m^2 delta)$ (dünne Hälfte); b) $I_T = 28\/3 pi R_m delta^3$, $tau_("max") = 9 M_T\/(28 pi R_m delta^2)$ (dicke Hälfte); c) $tau_b\/tau_a = 9 R_m\/(14 delta)$, $theta_b\/theta_a = 9 R_m^2\/(28 delta^2)$],
)[
#if not web [*Aufgabe 295* #linebreak()]
*Gegeben und Annahmen*

Kreisring mit Mittelradius $R_m$, eine Hälfte mit Wanddicke $delta$, die andere mit $3 delta$ ($delta << R_m$), Torsionsmoment $M_T$.

*Gesucht*

#enum(numbering: "a)",
[$I_T$ und $tau_("max")$ geschlossen.],
[$I_T$ und $tau_("max")$ geschlitzt.],
[Verhältnisse b) zu a).],
)
][
*Geschlossen:* $integral.cont d s\/t = pi R_m\/delta + pi R_m\/(3delta) = 4 pi R_m\/(3 delta)$, $I_T = 4 pi^2 R_m^4\/(4 pi R_m\/(3delta)) = 3 pi R_m^3 delta$; $tau_("max") = M_T\/(2 pi R_m^2 delta)$.
][
*Geschlitzt:* $I_T = 1\/3 pi R_m (delta^3 + 27 delta^3) = 28\/3 pi R_m delta^3$; $tau_("max") = M_T dot 3delta\/I_T = 9 M_T\/(28 pi R_m delta^2)$.
][
*Vergleich:* $tau_b\/tau_a = 9 R_m\/(14 delta)$, $theta_b\/theta_a = 3 pi R_m^3 delta\/(28\/3 pi R_m delta^3) = 9 R_m^2\/(28 delta^2)$.
]

#aufgabe(titel: "Zwei U-Profile für Biegung und Torsion anordnen", art: "verstehen", quelle: "TM2 5.4", herkunft: "original", vorlage: "Altklausur SS 16 (PrüfungenTM2 S. 12, U-Profile)",
  ergebnis: [a) Rücken an Rücken zu einem I-Profil; b) Öffnungen zueinander zu einem geschlossenen Kasten verschweißt],
  tipp: [Biegung: Fläche weit weg von der Biegeachse. Torsion: eine geschlossene Zelle mit großer umschlossener Fläche.],
)[
#if not web [*Aufgabe 296* #linebreak()]
*Altklausur SS 2016, Musterlösung (PrüfungenTM2 S. 12):* Zwei U-Profile sollen zu einem Träger verschweißt werden. Wie ordnest du sie an a) für möglichst großen Widerstand gegen Biegung um die $y$-Achse, b) gegen Torsion?
#align(center)[#image(abbildungen.at("ak_u_profile"), width: 70%)]
][
*Biegung:* Rücken an Rücken entsteht ein I-Profil. Die Flansche liegen weit von der $y$-Achse, $I_y$ wächst mit $z^2$, also ist $W_y$ groß.
][
*Torsion:* Mit den Öffnungen zueinander entsteht ein geschlossener Kasten. Dann gilt Bredt: $I_T = 4 A_m^2\/integral.cont d s\/t$ ist viel größer als bei zwei offenen Profilen mit $sum h t^3\/3$.
][
*Typische Verwechslung:* Die I-Form ist zwar gut für Biegung, bleibt aber offen und damit torsionsweich.
]

#aufgabe(titel: "Torsion eines geschlossenen dünnwandigen Profils", art: "rechnen", quelle: "TM2 5.4", herkunft: "original", vorlage: "Altklausur SS 24, Aufg. 2 (Torsion)", minuten: 10,
  ergebnis: [$A_m = "17895,02" thin "mm"^2$, $L_m = "543,69" thin "mm"$, $W_T approx "134212,65" thin "mm"^3$, $I_T approx "8834967,9" thin "mm"^4$, $tau_("max") approx "149,02" thin "N/mm"^2$, $Delta theta approx "1,60"°$],
  tipp: [Für geschlossene dünne Profile gilt Bredt: $W_T = 2A_m t$ und $I_T = 4A_m^2 t\/L_m$. $A_m$ ist die von der Mittellinie umschlossene Fläche.],
)[
#if not web [*Aufgabe 297* #linebreak()]
*AK24 S. 18, 23:*

*Gegeben und Annahmen*

Verwende den Querschnitt mit r=50 mm und t=3,75 mm. Konstante Wanddicke; Querschnittsgeometrie mit äußeren Abmessungen 2r und 3r plus Halbkreis wie in der Skizze.
#align(center)[#image(abbildungen.at("ak24-querschnitt"), width: 100%)]

*Gesucht*

#enum(numbering: "a)",
[Bestimme Aₘ, Lₘ, Iₜ und Wₜ.],
[Berechne für $M_T=20 "kNm"$, $l=1000 "mm"$, $G=81000 "N/mm"^2$ maximale Schubspannung und Verdrehung in Grad.],
)
][
*Modell:* einzellig, geschlossen, überall gleiche dünne Wand; ungestörte Saint-Venant-Torsion. Der Schubfluss läuft wie Wasser im Ring um das Profil, überall gleich groß.
][
*Mittellinie:* Gemessen wird in der Wandmitte. Daraus folgen *$A_m="17895,0201" "mm"^2$* und *$L_m="543,6891" "mm"$*. $A_m$ enthält den Hohlraum, nicht nur das Material.
][
*Kennwerte nach Bredt:* *$W_T=2A_m t="134212,6506" "mm"^3$* und *$I_T=4A_m^2t/L_m="8834967,904" "mm"^4$*.
][
*Spannung:* $M_T = 20 thin "kNm" = 2 dot 10^7 thin "Nmm"$. $tau_("max") = M_T\/W_T approx "149,017" thin "N/mm"^2$. Bei konstanter Wanddicke ist der Betrag am ganzen Umfang gleich.
][
*Verdrehung:* $Delta theta = M_T l\/(G I_T) = 2 dot 10^10\/(81000 dot "8834967,9") approx "0,0279473" thin "rad"$. Mal $180°\/pi$ ergibt *$"1,6013"°$*.
][
*Prüfen:* Der Ausdruck vor der Umrechnung ist dimensionslos, wie ein Winkel sein muss. Die Ausarbeitung auf AK24 S. 23 nennt eine zu kleine Gradzahl und einen abweichenden Iₜ-Wert; hier wird die Mittellinie vollständig berücksichtigt.
]

#aufgabe(titel: "Torsion eines geschlossenen dünnwandigen Profils (Variante)", art: "rechnen", quelle: "TM2 5.4", herkunft: "variante", vorlage: "Altklausur SS 24, Aufg. 2 (Torsion)", minuten: 10,
  ergebnis: [$A_m = "11452,8" "mm"^2$, $L_m = "434,95" "mm"$, $W_T = 68717 "mm"^3$, $I_T approx 3618800 "mm"^4$, $tau_("max") = "116,4" "N/mm"^2$, $Delta theta = "1,25"°$],
)[
#if not web [*Aufgabe 298* #linebreak()]
*Gegeben und Annahmen*

AK24-Querschnitt mit $r = 40 "mm"$, $t = 3 "mm"$ (Rechteck $2r times 3r$ plus Halbkreis, konstante Wanddicke). $M_T = 8 "kNm"$, $l = 800 "mm"$, $G = 81000 "N/mm"^2$.

*Gesucht*

#enum(numbering: "a)",
[$A_m$, $L_m$, $W_T$, $I_T$.],
[$tau_("max")$ und Verdrehung in Grad.],
)
][
*Mittellinie:* $r_m = "38,5"$, Rechteckhöhe bis zur Mittellinie $3r - t\/2 = "118,5" "mm"$. $A_m = 77 dot "118,5" + pi "38,5"^2\/2 = "11452,8" "mm"^2$, $L_m = 2 dot "118,5" + 77 + pi "38,5" = "434,95" "mm"$.
][
*Bredt:* $W_T = 2 A_m t = 68717 "mm"^3$, $I_T = 4 A_m^2 t\/L_m = 3618800 "mm"^4$.
][
*Ergebnisse:* $tau = 8 dot 10^6\/68717 = "116,4" "N/mm"^2$; $Delta theta = 8 dot 10^6 dot 800\/(81000 dot 3618800) = "0,02183" "rad" = "1,25"°$.
]
