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


#kapitel("TM1 Kapitel 1 · Das Werkzeug für Klausuraufgaben")

// 0-1
#aufgabe(titel: "Hebelarm richtig ablesen", art: "verstehen", quelle: "1.4")[
Warum darfst du den Hebelarm nicht einfach als Abstand vom Kraftangriffspunkt zum Bezugspunkt ablesen?
][
Nur der senkrechte Abstand zur Wirkungslinie ist der Hebelarm. Gleichwertig kannst du die Kraft zerlegen und die Komponenten mit ihren senkrechten Armen multiplizieren.
]

// 0-2
#aufgabe(titel: "Gelenkkräfte im Gesamtsystem", art: "verstehen", quelle: "1.6")[
Warum sind Gelenkkräfte im Freikörperbild des Gesamtsystems nicht zu sehen?
][
Im Gesamtsystem bilden die Gelenkkräfte innere, gleich große Gegenkräfte. Betrachtet man die Teile einzeln, werden sie zu äußeren Kräften des jeweiligen Teils.
]

// 0-3
#aufgabe(titel: "Seilkraft auf die Rolle A", art: "rechnen", quelle: "1.3",
  ergebnis: [$4F$ nach rechts und $8F$ nach unten],
  tipp: [Jedes Seilstück, das die Rolle verlässt, zieht mit der vollen Seilkraft an ihr. Zerlege das schräge Stück mit dem 3–4–5-Dreieck.],
)[
*AK24 S. 8–9, Seilrolle:* Die Seilkraft beträgt $5F$. Das schräge Seilstück bildet ein 3–4–5-Dreieck und läuft von A nach rechts unten. Bestimme beide Komponenten und die gesamte Kraft des Seils auf die Rolle A.
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

// 0-4
#aufgabe(titel: "Moment eines Hebels in Nm und Nmm", art: "rechnen", quelle: "1.4",
  ergebnis: [$M = 600 thin "Nm" = 600000 thin "Nmm"$],
  tipp: [Moment ist Kraft mal senkrechter Hebelarm. Rechne erst in N und m, dann in mm um.],
)[
*Eigene Aufgabe nach FS TM1 S. 22:* Eine Kraft von 2 kN wirkt senkrecht auf einen Hebel mit 0,3 m Länge. Wie groß ist das Moment in Nm und Nmm?
][
*Hebelarm:* Die Kraft steht senkrecht auf dem Hebel. Damit ist die ganze Hebellänge der senkrechte Abstand zur Wirkungslinie, also $r = "0,3" thin "m"$.
][
*Rechnen:* $M = F dot r = 2000 thin "N" dot "0,3" thin "m" = 600 thin "Nm"$.
][
*Umrechnen:* 1 m sind 1000 mm, also $600 thin "Nm" = 600 dot 1000 thin "Nmm" = 600000 thin "Nmm"$. In Nmm wird die Zahl tausendmal größer, weil die Längeneinheit tausendmal kleiner ist.
][
*Prüfen:* Kraft mal Länge ergibt die Einheit eines Moments. Stünde die Kraft schräg, zählte nur ihr senkrechter Anteil.
]


#kapitel("TM1 Kapitel 4 · Streckenlasten und Schwerpunkt")

// 1-1
#aufgabe(titel: "Angriffspunkt der Dreieckslast", art: "verstehen", quelle: "4.1")[
Wo greift die Resultierende einer Dreieckslast an, und von welcher Seite misst du?
][
Bei einem Drittel der Länge von der hohen Seite bzw. zwei Dritteln von der Nullseite. Das gilt für eine linear verlaufende Dreieckslast.
]

// 1-2
#aufgabe(titel: "Aussparung im Schwerpunkt", art: "verstehen", quelle: "4.2")[
Warum muss eine Aussparung sowohl in der Flächensumme als auch in der Momentsumme abgezogen werden?
][
Die Aussparung enthält kein Material und darf weder Fläche noch deren statisches Moment beitragen. Nur den Nenner zu ändern würde einen falschen Schwerpunkt ergeben.
]

// 1-3
#aufgabe(titel: "Trapezlast zusammenfassen", art: "rechnen", quelle: "4.1",
  ergebnis: [$F_R = 9 thin "kN"$ bei $x_R = 5\/3 thin "m" approx "1,67" thin "m"$],
  tipp: [Zerlege die Last in ein Rechteck und ein Dreieck. Jede Teillast greift im Schwerpunkt ihrer Fläche an.],
)[
*Eigene Zahlen nach P1 Aufgabe 6.4:* $q(x)=q_0(1+x/L)$ mit $q_0=2 "kN/m"$, $L=3 "m"$. Bestimme Resultierende und Angriffspunkt.
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

// 1-4
#aufgabe(titel: "Schwerpunkt eines Rechtecks mit Loch", art: "rechnen", quelle: "4.2",
  ergebnis: [$z'_S = 19a\/6 approx "3,17" a$ von oben, $y'_S = 0$],
  tipp: [Das Loch zählt als negative Fläche, sowohl im Nenner als auch im Zähler.],
)[
*P1 S. 1 / P2 S. 41, Grundidee:* Ein äußeres Rechteck $4a times 6a$ hat eine mittige rechteckige Aussparung $2a times 3a$. Ihre Oberkante liegt um $a$ unter der äußeren Oberkante. Bestimme $z'_S$ von oben.
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


#kapitel("TM1 Kapitel 5 · Lagerreaktionen und statische Bestimmtheit")

// 2-1
#aufgabe(titel: "Was Loslager, Gelenk und Einspannung übertragen", art: "verstehen", quelle: "5.1")[
Welche Reaktionen liefern ein seitliches Loslager, ein inneres Drehgelenk und eine feste Einspannung?
][
Seitliches Loslager: eine horizontale Kraft. Drehgelenk: zwei Kraftkomponenten, kein Moment. Einspannung: zwei Kräfte und ein Moment.
]

// 2-2
#aufgabe(titel: "Abzählkriterium reicht nicht", art: "verstehen", quelle: "5.3.2")[
Warum beweist $r+v=3n$ allein noch keine statische Bestimmtheit?
][
Die Gleichungen können geometrisch abhängig sein, etwa bei ungünstig angeordneten Reaktionslinien. Deshalb müssen Beweglichkeit und wirksame Bindungen zusätzlich anschaulich geprüft werden.
]

// 2-3
#aufgabe(titel: "Sechs Lagerreaktionen am Gelenkträger", art: "rechnen", quelle: "5.4",
  ergebnis: [$G_V = 4q_0a$, $B_H = 3q_0a$, $G_H = 7q_0a$, $C_V = 4q_0a$, $D_H = -11q_0a\/2$, $C_H = 3q_0a\/2$],
  tipp: [Schneide am Gelenk G. Beginne mit dem Teil, an dem nur drei Unbekannte hängen.],
)[
*AK24 S. 1, 3–7:* Stelle für das System in 5.4 mit dem dort festgelegten Pfeilsystem alle sechs Gleichgewichtsbedingungen auf. Verwende $F_(R 1)=4q_0a$, $F_(R 2)=3q_0a$. Bestimme für $F=-4q_0a$ die sechs Reaktionen als Vielfache von $q_0a$.
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


#kapitel("TM1 Kapitel 6 · Fachwerke: Nullstäbe und Ritterschnitt")

// 3-1
#aufgabe(titel: "Voraussetzungen des idealen Fachwerks", art: "verstehen", quelle: "6.1")[
Welche drei Voraussetzungen brauchst du für ein ideales Fachwerk?
][
Gerade, zwischen den Knoten unbelastete Stäbe; ideale Gelenke; äußere Kräfte greifen an Knoten an. Dann sind die Stäbe Zwei-Kräfte-Körper.
]

// 3-2
#aufgabe(titel: "Nullstab heißt nicht überflüssig", art: "verstehen", quelle: "6.3.1")[
Warum ist „Stabkraft null“ nicht gleichbedeutend mit „Stab überflüssig“?
][
Nullstäbe können die Form stabilisieren und unter geänderter Last beansprucht werden. Im konkreten System müssen Stabilität und Belastungsfall geprüft werden.
]

// 3-3
#aufgabe(titel: "Nullstäbe und Ritterschnitt", art: "rechnen", quelle: "6.3.3",
  ergebnis: [Nullstäbe 1, 2, 9; $S_6 = 5F$ (Zug), $S_7 = 0$, $S_8 = -10F$ (Druck)],
  tipp: [Für den Ritterschnitt: Lege den Momentenbezugspunkt in den Schnittpunkt zweier unbekannter Stäbe.],
)[
*AK24 S. 8, 13, 15–16:* Bestimme die Nullstäbe 1, 2 und 9 und ordne die Regeln zu. Schneide anschließend durch die Stäbe 6, 7 und 8. Gegeben am oberen Teilfachwerk: $D=10F$ nach rechts, $G_H=10F$ nach links und $G_V=5F$ nach unten. Berechne $S_6$, $S_7$, $S_8$.
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


#kapitel("TM1 Kapitel 7 · Schnittgrößen punktweise bestimmen")

// 4-1
#aufgabe(titel: "Sprünge bei Einzelkraft und Einzelmoment", art: "verstehen", quelle: "7.3")[
Welche Größe springt an einer Einzelkraft, welche an einem Einzelmoment?
][
Eine quer gerichtete Einzelkraft erzeugt einen Sprung in Q; M bleibt stetig und knickt. Ein Einzelmoment erzeugt einen Sprung in M; Q bleibt unverändert.
]

// 4-2
#aufgabe(titel: "Drehgelenk und Querkraftgelenk", art: "verstehen", quelle: "7.3")[
Wie unterscheiden sich Drehgelenk und Querkraftgelenk für die Schnittgrößen?
][
Drehgelenk: M=0, N und Q möglich. Querkraftgelenk: Q=0, N und M möglich. Das gilt ohne eine dort zusätzlich eingeleitete entsprechende Last.
]

// 4-3
#aufgabe(titel: "Schnittgrößen im Abschnitt A bis E", art: "rechnen", quelle: "7.4",
  ergebnis: [Nach A: $N=-4F$, $Q=-8F$, $M=0$. Vor E: $N=-4F$, $Q=-8F$, $M=-32F a$],
  tipp: [Ohne Last im Abschnitt bleiben N und Q konstant, und M ändert sich linear mit der Steigung Q.],
)[
*AK24 S. 8–10:* Bestimme $N,Q,M$ unmittelbar nach A und unmittelbar vor E im Abschnitt A–E.
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

// 4-4
#aufgabe(titel: "Schnittgrößen rechts vom Gelenk E", art: "rechnen", quelle: "7.4",
  ergebnis: [$N=10F$, $Q=-5F$, $M=20F a$],
  tipp: [Am rechten Schnittufer zeigen die positiven Schnittgrößen andersherum als am linken. Zeichne sie zuerst ein.],
)[
*AK24 S. 13–14:* Betrachte nur den rechten Teil des Riegels E–G. Am Gelenk wirken auf den T-Träger $G_H=10F$ nach rechts und $G_V=5F$ nach oben. Die Länge E–G beträgt $4a$. Bestimme $N,Q,M$ unmittelbar rechts von E; Bezugsfaser unten.
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

// 4-5
#aufgabe(titel: "Momentenmaximum aus Q(x)", art: "rechnen", quelle: "7.3",
  ergebnis: [$M(x) = 6x - x^2$ in kNm; Maximum bei $x = 3 thin "m"$ mit $M = 9 thin "kNm"$],
  tipp: [M ist die Stammfunktion von Q. Wo Q null wird, hat M einen Extremwert.],
)[
*Eigene Aufgabe nach neuer Lösung TM1 Nr. 10 S. 1–2:* $Q(x)=6-2x$ in kN bei $x$ in m, $M(0)=0$. Bestimme $M(x)$ und die innere Extremstelle.
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


#kapitel("TM1 Kapitel 9 · Haftreibung als kurzer Klausurbaustein")

// 5-1
#aufgabe(titel: "Richtung der Haftkraft", art: "verstehen", quelle: "9.2")[
Welche Richtung hat die Haftkraft, und wann darfst du die Grenzgleichung verwenden?
][
Entgegen der drohenden Relativbewegung. Gleichheit gilt nur im Grenzfall; sonst prüft man die Ungleichung.
]

// 5-2
#aufgabe(titel: "Haftet der Klotz noch?", art: "rechnen", quelle: "9.2",
  ergebnis: [Bei 20 N haftet er ($H = 20 thin "N" <= 30 thin "N"$), bei 35 N nicht],
  tipp: [Erst die nötige Haftkraft aus dem Gleichgewicht, dann mit der Grenze $mu_0 N$ vergleichen.],
)[
*Eigene Zahlen zum Modell der älteren Klausur:* Ein Klotz wiegt 100 N auf horizontalem Boden, $mu_0="0,3"$. Ein waagerechter Seilzug beträgt zunächst 20 N, dann 35 N. Ist Haften möglich?
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

// 6-1
#aufgabe(titel: "Wärmedehnung ohne Spannung", art: "verstehen", quelle: "TM2 1.4")[
Kann ein erwärmter Stab länger werden, obwohl seine Spannung null ist?
][
Ja: freie Wärmeausdehnung $Delta l=alpha_T Delta T l$. Ohne Behinderung entsteht keine mechanische Spannung.
]

// 6-2
#aufgabe(titel: "Die fehlende Verträglichkeitsbedingung", art: "verstehen", quelle: "TM2 1.6")[
Welche Gleichung fehlt bei einem statisch unbestimmten Stabsystem zusätzlich zum Gleichgewicht?
][
Eine geometrische Verträglichkeitsbedingung, z. B. vorgegebene Gesamtlängenänderung oder gleiche Verschiebung an einer Verbindung.
]

// 6-3
#aufgabe(titel: "Stab mit veränderlichem Querschnitt", art: "rechnen", quelle: "TM2 1.4",
  ergebnis: [$sigma(x) = -F(l+x)\/(2l A_0)$, $Delta l = -3F l\/(4E A_0)$],
  tipp: [Die Normalkraft ist überall gleich, nur die Fläche ändert sich. Die Längenänderung ist das Integral der Dehnung.],
)[
*Ältere Klausur, PrüfungenTM2 S. 12:* $A(x)=2l A_0/(l+x)$, konstantes E, Druckkraft F am Ende. Bestimme $sigma(x)$ und $Delta l$ ohne Temperaturänderung.
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

// 6-4
#aufgabe(titel: "Erwärmter Stab stützt einen Kragarm", art: "rechnen", quelle: "TM2 1.7",
  ergebnis: [$X approx "188,93" thin "N"$ Druck, Balkenende $"0,29989" thin "mm"$ nach oben, $M_A = -X l = -188929 thin "Nmm"$],
  tipp: [Der Stab will sich um $alpha_T Delta T a$ verlängern. Diese Länge teilen sich die Stauchung des Stabes und die Durchbiegung des Balkens.],
)[
*AK24 S. 18, 24:* Verwende $a=250 "mm"$, $l=1000 "mm"$, $A=2000 "mm"^2$, $I=10^6 "mm"^4$, $E=210000 "N/mm"^2$, $alpha_T=12 dot 10^(-6) "1/K"$, $Delta T=100 "K"$. Bestimme X, die Verschiebung und das Einspannmoment.
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


#kapitel("TM2 Kapitel 2 · Spannungszustand und Mohrscher Kreis")

// 7-1
#aufgabe(titel: "Hauptrichtung im Mohrschen Kreis", art: "verstehen", quelle: "TM2 2.2")[
Was bedeutet „Hauptrichtung“, und wie erkennst du sie im Kreis?
][
In der Hauptrichtung verschwindet die Schubspannung. Im Kreis liegen die Hauptspannungen deshalb auf der horizontalen Achse.
]

// 7-2
#aufgabe(titel: "Warum der Kreiswinkel halbiert wird", art: "verstehen", quelle: "TM2 2.2.3")[
Warum musst du einen am Kreis gemessenen Winkel halbieren?
][
Die Transformationsgleichungen enthalten den doppelten Winkel 2φ. Außerdem ist der Drehsinn im Kreis entgegengesetzt zum Bauteilwinkel, wenn P wie hier eingetragen wird.
]

// 7-3
#aufgabe(titel: "Mohrscher Kreis mit Hauptspannungen", art: "rechnen", quelle: "TM2 2.2.3",
  ergebnis: [$sigma_M = "27,5"$, $R = "62,5"$, $sigma_1 = 90$, $sigma_2 = -35 thin "N/mm"^2$, $phi_1 = -"18,435"°$],
  tipp: [Mittelpunkt ist der Mittelwert von $sigma_x$ und $sigma_y$. Der Radius kommt aus Pythagoras mit halber Differenz und $tau_(x y)$.],
)[
*AK24 S. 24–25 / Übung 6.2:* $sigma_x="77,5"$, $sigma_y=-"22,5"$, $tau_(x y)=-"37,5"$ N/mm². Zeichne den Kreis und bestimme Mittelpunkt, Radius, Hauptspannungen und die Richtung von $sigma_1$.
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


#kapitel("TM2 Kapitel 3 · Dehnungen, Elastizitätsgesetz und DMS")

// 8-1
#aufgabe(titel: "Achse des Verzerrungskreises", art: "verstehen", quelle: "TM2 3.1")[
Welche Größe steht auf der senkrechten Achse des Verzerrungskreises?
][
Die halbe Gleitung γ/2. Wer γ einträgt, erhält einen falschen Radius und falsche Hauptdehnungen.
]

// 8-2
#aufgabe(titel: "Dickenänderung trotz ebenem Spannungszustand", art: "verstehen", quelle: "TM2 3.2")[
Warum ist die dritte Dehnung trotz verschwindender dritter Spannung meist nicht null?
][
Durch die Querkontraktion wirken die Spannungen in x und y auch auf die Dicke des Blechs.
]

// 8-3
#aufgabe(titel: "DMS-Rosette auswerten", art: "rechnen", quelle: "TM2 3.3",
  ergebnis: [$gamma = "1,0" "‰"$, $epsilon_1 = "0,77134" "‰"$, $epsilon_2 = -"0,42134" "‰"$, Richtung $"28,49"°$, $sigma_1 approx "148,83"$, $sigma_2 approx -"43,83" thin "N/mm"^2$],
  tipp: [Bei der 0-45-90-Rosette gilt $gamma_(x y) = 2epsilon_45 - epsilon_0 - epsilon_90$. Im Kreis steht $gamma\/2$ auf der senkrechten Achse.],
)[
*WZF-Rosette, Zahlen passend zu Beispiel 1 (eigene bereinigte Aufbereitung):* $epsilon_0="0,5" "‰"$, $epsilon_45="0,675" "‰"$, $epsilon_90=-"0,15" "‰"$. Bestimme $epsilon_x$, $epsilon_y$, $gamma_(x y)$, Hauptdehnungen, die Richtung von $epsilon_1$ sowie die Hauptspannungen mit $E=210000 "N/mm"^2$, $nu="0,3"$.
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

// 8-4
#aufgabe(titel: "Drei Hauptdehnungen aus Hauptspannungen", art: "rechnen", quelle: "TM2 3.2",
  ergebnis: [$epsilon_1 = "0,37619" "‰"$, $epsilon_2 = -"0,24286" "‰"$, $epsilon_3 = -"0,05714" "‰"$],
  tipp: [Jede Dehnung: eigene Spannung minus $nu$ mal die beiden anderen, alles durch E.],
)[
*Ältere Klausur SS 2018, S. 11:* $sigma_1=70$, $sigma_2=-30 "N/mm"^2$, $sigma_3=0$, $E=210000 "N/mm"^2$, $nu="0,3"$. Berechne die drei Hauptdehnungen.
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


#kapitel("TM2 Kapitel 4 · Biegung, FTM und Biegelinie")

// 9-1
#aufgabe(titel: "Einheiten von I und W", art: "verstehen", quelle: "TM2 4.2")[
Warum haben Flächenträgheitsmomente die Einheit mm⁴ und Widerstandsmomente mm³?
][
I enthält Fläche mal Abstand², also mm²·mm². W=I/Randabstand hat mm³.
]

// 9-2
#aufgabe(titel: "Randbedingungen an Einspannung und freiem Ende", art: "verstehen", quelle: "TM2 4.4")[
Welche Bedingungen gelten an einer Einspannung und an einem unbelasteten freien Ende?
][
Einspannung: w=0 und w′=0. Unbelastetes freies Ende: Q=0 und M=0. Endlasten verändern die statischen Randbedingungen.
]

// 9-3
#aufgabe(titel: "Schwerpunkt und Steiner am zusammengesetzten Querschnitt", art: "rechnen", quelle: "TM2 4.3",
  ergebnis: [$z'_S = "58,061096" thin "mm"$, $y'_S = 0$, $I_y = "9833140,605" thin "mm"^4$, $I_(y z) = 0$],
  tipp: [Arbeite mit einer Tabelle: Fläche, Schwerpunktlage, Abstand zum Gesamtschwerpunkt, Eigenanteil, Steineranteil.],
)[
*AK24 S. 18–23:* Bestimme für den Querschnitt in 4.3 die vier vorzeichenbehafteten Flächen, ihre z′-Schwerpunktkoordinaten, den Gesamtschwerpunkt und $I_y$. Prüfe $I_(y z)$.
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

// 9-4
#aufgabe(titel: "Größte Biegespannung an der Einspannung", art: "rechnen", quelle: "TM2 4.2",
  ergebnis: [$abs(sigma_("max")) approx "20,416" thin "N/mm"^2$ am oberen Rand an der Einspannung],
  tipp: [Die größte Spannung sitzt am Rand, der am weitesten von der Schwerachse entfernt ist.],
)[
*AK24 S. 24, eigene Nachrechnung mit den gedruckten Daten:* Verwende $X="188,929" "N"$, $l=1000 "mm"$, $I=10^6 "mm"^4$. Bestimme den maximalen Betrag der Biegespannung am Querschnitt aus der Aufgabe „Schwerpunkt und Steiner am zusammengesetzten Querschnitt“.
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

// 9-5
#aufgabe(titel: "Kragarm mit Endkraft und Moment", art: "rechnen", quelle: "TM2 4.4",
  ergebnis: [$w(2a) = 8F a^3\/(3E I) + 3M_0 a^2\/(2E I)$],
  tipp: [Rechne beide Lasten getrennt und addiere. Hinter dem Moment läuft die Biegelinie als Gerade weiter.],
)[
*AK24 S. 25–26:* Kragarm mit Gesamtlänge L=2a, Endkraft F nach unten und einem im Uhrzeigersinn wirkenden Moment M₀ bei x=a. Bestimme die Enddurchbiegung durch Superposition.
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

// 9-6
#aufgabe(titel: "Randbedingungen für die Biegelinie aufstellen", art: "verstehen", quelle: "TM2 4.4")[
*Eigene Übungsaufgabe nach FS TM2 S. 29 und älteren Klausuren:* Ein Balken der Länge L ist links eingespannt und rechts gelenkig gelagert. Eine linear abfallende Last hat links q₀ und rechts null. Schreibe q(x) und die vier Randbedingungen für die vierfache Integration auf; noch nicht integrieren.
][
*$q(x)=q_0(1-x/L)$*. Einspannung links: *$w(0)=0$, $w'(0)=0$*. Gelenkiges Endlager rechts ohne Endmoment: *$w(L)=0$, $M(L)=0$*, also bei konstantem EI auch $w''(L)=0$. Prüfung: vier unabhängige Bedingungen für vier Integrationskonstanten.
]

// 9-7
#aufgabe(titel: "Hauptträgheitsmomente", art: "rechnen", quelle: "TM2 4.3",
  ergebnis: [$I_1 approx "412315,46" thin "mm"^4$, $I_2 approx "107684,54" thin "mm"^4$, $phi_1 approx "11,599"°$],
  tipp: [Das funktioniert wie der Mohrsche Kreis für Spannungen: Mittelwert, Radius, Mittelwert plus und minus Radius.],
)[
*Ältere Klausur, Datum unbekannt, Prüfung_unbekannt S. 1–2:* $I_y=400000$, $I_z=120000$, $I_(y z)=60000 "mm"^4$. Bestimme Hauptmomente und eine zu I₁ gehörige Achsenrichtung.
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


#kapitel("TM2 Kapitel 5 · Torsion: Spannung und Verdrehung")

// 10-1
#aufgabe(titel: "Materialfläche und Mittellinienfläche", art: "verstehen", quelle: "TM2 5.2")[
Welche zwei unterschiedlichen Geometriegrößen sind Materialfläche A und Mittellinienfläche Aₘ?
][
A ist die tatsächlich vorhandene Materialfläche. Aₘ ist die vom mittleren Wandverlauf eingeschlossene Fläche und enthält bei einem Hohlprofil überwiegend den Hohlraum.
]

// 10-2
#aufgabe(titel: "Ort der größten Torsionsspannung", art: "verstehen", quelle: "TM2 5.2")[
Wo liegt die größte Torsionsspannung bei geschlossenen bzw. offenen dünnwandigen Profilen?
][
Geschlossen: dünnste Wand. Offen im schmalen Rechteckstreifenmodell: dickster Teil. Die Voraussetzungen der jeweiligen Formel gehören zur Antwort.
]

// 10-3
#aufgabe(titel: "Torsion eines geschlossenen dünnwandigen Profils", art: "rechnen", quelle: "TM2 5.4",
  ergebnis: [$A_m = "17895,02" thin "mm"^2$, $L_m = "543,69" thin "mm"$, $W_T approx "134212,65" thin "mm"^3$, $I_T approx "8834967,9" thin "mm"^4$, $tau_("max") approx "149,02" thin "N/mm"^2$, $Delta theta approx "1,60"°$],
  tipp: [Für geschlossene dünne Profile gilt Bredt: $W_T = 2A_m t$ und $I_T = 4A_m^2 t\/L_m$. $A_m$ ist die von der Mittellinie umschlossene Fläche.],
)[
*AK24 S. 18, 23:* Verwende den Querschnitt mit r=50 mm und t=3,75 mm. Bestimme Aₘ, Lₘ, Iₜ und Wₜ. Berechne für $M_T=20 "kNm"$, $l=1000 "mm"$, $G=81000 "N/mm"^2$ maximale Schubspannung und Verdrehung in Grad.
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

// 10-4
#aufgabe(titel: "Mindestdurchmesser einer Welle", art: "rechnen", quelle: "TM2 5.1",
  ergebnis: [$d_("min") approx "58,84" thin "mm"$],
  tipp: [Setze $tau_("max") = M_T\/W_T$ gleich der zulässigen Spannung und löse nach d auf. Rechne $M_T$ vorher in Nmm um.],
)[
*Eigene Zahlen zum Modell Übung 12.1:* Vollwelle mit $M_T=1800 "Nm"$, zulässiger Schubspannung $tau_("zul")=45 "N/mm"^2$. Welcher Mindestdurchmesser folgt nur aus der Spannung?
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

