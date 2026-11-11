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


#kapitel("Kapitel 5 · Schwingungen")

#aufgabe(titel: "Eigenkreisfrequenz aus der Schwingungsgleichung", art: "verstehen", quelle: "5.0", herkunft: "eigen")[
#if not web [*Aufgabe 1* #linebreak()]
Ein Federpendel gehorcht $dot.double(x)+25 x=0$ (Koeffizient in s⁻²). Wie groß ist die Eigenkreisfrequenz, und warum?
][
*Ablesen:* Aus $dot.double(x)+a x=0$ mit $a>0$ folgt $omega_0=sqrt(a)$, hier $omega_0=sqrt(25)=5 thin "rad/s"$. Denn $a$ entspricht $D\/m=omega_0^2$.
][
*Typische Verwechslungen:* 25 rad/s ist $omega_0^2$, die Wurzel fehlt. 0,8 Hz $approx 5\/(2pi)$ wäre die Frequenz $f$, nicht die Kreisfrequenz. 12,5 rad/s entsteht durch Halbieren statt Wurzelziehen.
#src[Quizfrage zu 5.0; V, PDF-S. 146–150.]
]

#aufgabe(titel: "Frequenz, Kreisfrequenz und Periodendauer", art: "verstehen", quelle: "5.0", herkunft: "eigen")[
#if not web [*Aufgabe 2* #linebreak()]
Wie hängen $f$, $omega$ und $T$ zusammen, und was ist der Unterschied zwischen $f$ und $omega$?
][
*Zusammenhang:* $omega=2pi f$ und $T=1\/f=2pi\/omega$. $f$ zählt vollständige Schwingungen pro Sekunde (Hz), $omega$ den durchlaufenen Winkel pro Sekunde (rad/s). Es sind zwei Zahlen für denselben Takt: Bei 2 Hz durchläuft der Sinus $4pi$ Radiant pro Sekunde.
][
*Typische Verwechslungen:* $omega=f$ oder $omega=f\/(2pi)$ setzen den Faktor $2pi$ falsch; $T$ ist der Kehrwert von $f$, nicht $2pi\/f$ und auch nicht $omega$ (s gegen rad/s). Merksatz: $f$ zählt Umläufe, $omega$ zählt Winkel pro Zeit.
#src[Quizfrage und Karteikarte zu 5.0; V, PDF-S. 146–150.]
]

#aufgabe(titel: "Warum das Federpendel durch die Ruhelage schwingt", art: "verstehen", quelle: "5.0", herkunft: "eigen")[
#if not web [*Aufgabe 3* #linebreak()]
Warum schwingt ein Federpendel immer wieder durch die Ruhelage hindurch, statt dort stehen zu bleiben?
][
*Ablauf:* Die ausgelenkte Feder zieht die Masse zur Ruhelage zurück. Dort hat die Masse ihre größte Geschwindigkeit und fliegt wegen ihrer Trägheit darüber hinaus. Jetzt bremst die Feder sie ab und zieht zurück. Ohne Dämpfung wiederholt sich das ewig. Merksatz: Die Feder zieht zurück, die Trägheit trägt darüber hinaus.
][
*Bild:* Wie eine Schaukel: Am tiefsten Punkt bleibt sie nicht stehen, sondern schwingt weiter.
#src[Karteikarte zu 5.0; V, PDF-S. 146–150.]
]

#aufgabe(titel: "Wovon die Eigenfrequenz des Federpendels abhängt", art: "verstehen", quelle: "5.0", herkunft: "eigen")[
#if not web [*Aufgabe 4* #linebreak()]
Wovon hängt die Eigenfrequenz eines Federpendels ab, und wovon nicht?
][
*Formel deuten:* $omega_0=sqrt(D/m)$. Eine härtere Feder (größeres $D$) macht die Schwingung schneller, eine größere Masse langsamer. Die Amplitude spielt im linearen Modell keine Rolle. Merksatz: Härtere Feder schneller, größere Masse langsamer.
#src[Karteikarte zu 5.0; V, PDF-S. 146–150.]
]

#aufgabe(titel: "Federsitz: Masse aus der Periodendauer", art: "rechnen", quelle: "5.0", herkunft: "original", vorlage: "Altklausur WS 17/18, Aufg. 1", minuten: 15, platz: 14,
  ergebnis: [a) $D approx 780 thin "N/m"$, $T_2 approx "1,80" thin "s"$; b) $Delta T approx "12,7" thin "ms"$; c) keine Änderung der Periodendauer],
)[
#if not web [*Aufgabe 5* #linebreak()]
*Body Mass Measurement Device*

*Gegeben und Annahmen*

In der Schwerelosigkeit kann die Masse nicht über die Gewichtskraft bestimmt werden. Die NASA hat dafür das „Body Mass Measurement Device“ (BMMD) entwickelt: einen Sitz bekannter Masse $m_S=4 thin "kg"$, der horizontal an eine Feder (Federkonstante $D$) gehängt ist und reibungsfrei auf Schienen gleitet. Setzt sich ein Astronaut auf den Sitz, kann seine Masse $m$ aus der Schwingungsdauer bestimmt werden. Stell dir das BMMD als einfaches Federpendel mit Zusatzmasse $m$ vor.

*Gesucht*

#enum(numbering: "a)",
[Bei Astronaut Pete mit $m_p=75 thin "kg"$ misst das Gerät die Schwingungsdauer $T_1=2 thin "s"$. Was zeigt es bei Astronautin Mary mit $m_m=60 thin "kg"$ an?],
[Wie genau muss die Schwingungsdauer bestimmt werden können, um eine Gewichtsabnahme von 1 kg bei Pete feststellen zu können?],
[Was ändert sich an den Messungen, wenn sich die Raumstation im Einflussbereich eines Planeten befindet?],
)
][
*Modell wählen:* Horizontaler linearer Federoszillator; schwingende Masse ist Körpermasse plus Sitzmasse. Damit $T=2pi sqrt((m+m_S)/D)$.
][
*Feder kalibrieren:* Aus Petes Messung $D=4pi^2 (m_p+m_S)/T_1^2=4pi^2 dot 79 thin "kg"\/(2 thin "s")^2 approx "779,7" thin "N/m"$.
][
*Mary:* $T_2=2pi sqrt(64 thin "kg"\/"779,7" thin "N/m")=2 thin "s" dot sqrt(64\/79) approx "1,80" thin "s"$. Das Gerät zeigt also 1,80 s an.
][
*Auflösung b):* Pete mit 74 kg: $T_3=2 thin "s" dot sqrt(78\/79) approx "1,98730" thin "s"$. Der Unterschied ist $Delta T approx "0,0127" thin "s"="12,7" thin "ms"$; die Zeitmessung muss also etwa auf 10 ms genau sein. Die Rundung auf „1,99 s“ allein reicht dafür nicht.
][
*c) Schwerefeld:* Eine konstante zusätzliche Kraft verschiebt nur die Gleichgewichtslage; $D$ und die schwingende Masse bleiben gleich. Die Periodendauer und damit die Messung ändern sich im Idealmodell nicht.
][
*Prüfen:* Weniger Masse ergibt eine kürzere Periodendauer; Einheit $sqrt("kg"\/("N/m"))=sqrt("s"^2)="s"$.
#src[Altklausur Physik 1 WIW WS 17/18, Aufg. 1, mit Musterlösung (K17/18, PDF-S. 1–2, als Bild gelesen); eigene überprüfte Rechnung.]
]

#aufgabe(titel: "BMMD mit schwererem Sitz (Variante)", art: "rechnen", quelle: "5.0", herkunft: "variante", vorlage: "Altklausur WS 17/18, Aufg. 1", minuten: 12,
  ergebnis: [a) $D approx 710 thin "N/m"$, $T approx "2,015" thin "s"$; b) $Delta T approx "6,3" thin "ms"$],
)[
#if not web [*Aufgabe 6* #linebreak()]
*Gegeben und Annahmen*

Ein BMMD in der Raumstation besteht aus einem horizontal an einer Feder befestigten, reibungsfrei gleitenden Sitz mit $m_S=5 thin "kg"$. Es wird als einfaches Federpendel mit Zusatzmasse $m$ (Astronaut) modelliert. Bei Astronautin Ana ($m_A=82 thin "kg"$) misst es $T_1="2,2" thin "s"$.

*Gesucht*

#enum(numbering: "a)",
[Bestimme die Federkonstante $D$ und die Schwingungsdauer bei Astronaut Ben mit $m_B=68 thin "kg"$.],
[Wie genau muss die Schwingungsdauer gemessen werden, um bei Ana eine Abnahme von 0,5 kg zu erkennen?],
)
][
*Modell:* $T=2pi sqrt((m+m_S)/D)$, Sitz schwingt mit.
][
*Kalibrieren:* $D=4pi^2 dot 87 thin "kg"\/("2,2" thin "s")^2 approx "709,6" thin "N/m"$.
][
*Ben:* $T_B=2pi sqrt(73\/"709,6") thin "s" approx "2,015" thin "s"$ (gleich: $"2,2" thin "s" dot sqrt(73\/87)$).
][
*Auflösung:* Mit 81,5 kg: $T="2,2" thin "s" dot sqrt("86,5"\/87) approx "2,1937" thin "s"$. Unterschied $approx "0,0063" thin "s"="6,3" thin "ms"$.
][
*Prüfen:* Halbe Massenänderung bei ähnlicher Gesamtmasse halbiert ungefähr die Zeitänderung gegenüber dem Original (12,7 ms für 1 kg).
#src[Eigene Variante nach Altklausur WS 17/18, Aufg. 1.]
]

#aufgabe(titel: "Wie eine Schwebung entsteht", art: "verstehen", quelle: "5.4.1", herkunft: "eigen")[
#if not web [*Aufgabe 7* #linebreak()]
Wann entsteht eine Schwebung, und warum wird der Ton abwechselnd lauter und leiser?
][
*Bedingung:* Eine Schwebung entsteht, wenn zwei Schwingungen mit *fast gleicher Frequenz* überlagert werden. Ihre Phasen verschieben sich langsam gegeneinander.
][
*Ursache des Laut-Leise:* Sind beide gerade im Takt (gleiche Phase), verstärken sich die Auslenkungen; sind sie gegeneinander (Gegenphase), schwächen sie sich ab und löschen sich bei gleichen Amplituden aus. Dadurch ändert sich der Betrag der Hülle periodisch. Merksatz: Fast gleicher Takt erzeugt langsames Laut-und-leise.
][
*Bild:* Zwei Läufer mit fast gleichem Tempo laufen eine Weile nebeneinander, dann auseinander und treffen sich nach jeder Überrundung wieder.
#src[L, Fragen 1 und 22, PDF-S. 8–11; LB, PDF-S. 1; Karteikarte zu 5.4.1, Abbildung schwebung-quelle.]
]

#aufgabe(titel: "Träger, Hülle und Schwebungsfrequenz", art: "verstehen", quelle: "5.4.1", herkunft: "eigen")[
#if not web [*Aufgabe 8* #linebreak()]
Unterscheide $omega_m$, $omega_d$, $f_s$ und $T_s$. Warum ist die hörbare Schwebungsfrequenz doppelt so groß wie die Frequenz der vorzeichenbehafteten Kosinushülle?
][
*Größen trennen:* Der Träger hat $omega_m=(omega_1+omega_2)/2$. Die Kosinushülle hat $omega_d=abs(omega_1-omega_2)/2$. Hörbar ist $f_s=abs(f_1-f_2)$ mit $T_s=1/f_s$.
][
*Faktor zwei begründen:* Die Hülle $2A cos(Delta omega t\/2)$ wechselt zwischen $+2A$ und $-2A$. Laut ist es bei *beiden* Extremen, denn das Ohr hört den Betrag. Pro Periode der Kosinushülle gibt es also zwei Lautstärkemaxima. Merksatz: Für die Lautstärke zählt der Betrag der Hülle.
#src[L, Fragen 2–3 und K2–K5, PDF-S. 8, 10 und 15; Karteikarte zu 5.4.1.]
]

#aufgabe(titel: "Saite mit der Stimmgabel stimmen", art: "verstehen", quelle: "5.4.1", herkunft: "eigen")[
#if not web [*Aufgabe 9* #linebreak()]
Beschreibe das Stimmen einer Saite mit einer Stimmgabel. Wie verändert sich die Schwebung, wenn sich die Saite dem Referenzton nähert, und was sagt eine langsamer werdende Schwebung aus?
][
*Vorgehen:* Saite und Stimmgabel klingen gleichzeitig. Man hört die Schwebung mit $f_s=abs(f_1-f_2)$.
][
*Annäherung:* Nähert sich die Saite dem Referenzton, wird die Differenz kleiner: Die Schwebung wird *langsamer*, $T_s$ wächst. Bei gleicher Frequenz verschwindet sie im Idealmodell ganz. Wird sie beim Nachspannen langsamer, ist man auf dem richtigen Weg.
][
*Typische Verwechslungen:* „Die Schwebung wird schneller“ vertauscht die Richtung. „Sie wird lauter“ verwechselt Rhythmus und Lautstärke: Die Lautstärke der Maxima hängt an den Amplituden, nicht an der Frequenzdifferenz. Aus der Differenz allein erkennt man außerdem nicht, welcher Ton höher ist.
#src[L, Frage 4, PDF-S. 8 und 10; LB, PDF-S. 1; Quizfrage und Karteikarte zu 5.4.1.]
]

#aufgabe(titel: "Schwebung bei ungleichen Amplituden", art: "verstehen", quelle: "5.4.1", herkunft: "eigen")[
#if not web [*Aufgabe 10* #linebreak()]
Braucht eine Schwebung gleiche Amplituden? Wann löschen sich die beiden Schwingungen im Schwebungsminimum vollständig aus, und was passiert bei exakt gleichen Frequenzen?
][
*Amplituden:* Gleiche Amplituden sind für das periodische An- und Abschwellen nicht nötig. Nur bei $A_1=A_2$ ist im Minimum $abs(A_1-A_2)=0$, also vollständige Auslöschung; sonst bleibt ein Restminimum und die Schwebung ist weniger ausgeprägt.
][
*Gleiche Frequenzen:* Dann bleibt die Phasendifferenz konstant; es entsteht keine langsame Schwebung. Typische Verwechslung: Die Frequenzdifferenz bestimmt den Rhythmus, nicht die Tiefe des Minimums.
#src[L, Frage 22, PDF-S. 9 und 11; Quizfrage und Karteikarte zu 5.4.1; eigene Erläuterung.]
]

#aufgabe(titel: "Was man bei 440 Hz und 442 Hz hört", art: "verstehen", quelle: "5.4.1", herkunft: "eigen")[
#if not web [*Aufgabe 11* #linebreak()]
Zwei Stimmgabeln mit 440 Hz und 442 Hz klingen gleichzeitig. Was hört man, und warum?
][
*Höreindruck:* Einen Ton von etwa 441 Hz (Träger, $f_m=(f_1+f_2)/2$), der zweimal pro Sekunde lauter und leiser wird ($f_s=abs(f_1-f_2)=2 thin "Hz"$). Die 2 Hz sind kein eigener Ton, sondern der Rhythmus der Lautstärke.
][
*Typische Verwechslungen:* Ein 2-Hz-Ton wäre gar nicht hörbar. Zwei getrennte Töne hört man bei so nahen Frequenzen nicht, sie verschmelzen. 882 Hz entsteht nicht: Die Auslenkungen addieren sich, nicht die Frequenzen.
#src[Quizfrage und Karteikarte zu 5.4.1.]
]

#aufgabe(titel: "Schwebungsdauer bei 440 Hz und 442 Hz", art: "verstehen", quelle: "5.4.1", herkunft: "eigen")[
#if not web [*Aufgabe 12* #linebreak()]
Wie lang ist die Schwebungsdauer $T_s$ bei 440 Hz und 442 Hz? Begründe, warum nicht 1 s herauskommt.
][
*Rechnen:* $f_s=abs(f_1-f_2)=2 thin "Hz"$, also $T_s=1\/f_s="0,5" thin "s"$.
][
*Typische Verwechslungen:* 1 s wäre die Periode der Kosinushülle mit $(f_1-f_2)\/2=1 thin "Hz"$; ihr Betrag hat aber pro Periode zwei Maxima. 2 s entsteht, wenn man $T_s=f_s$ setzt statt den Kehrwert zu nehmen. 0,0023 s ist die Periode des schnellen 441-Hz-Trägers.
#src[Quizfrage zu 5.4.1.]
]

#aufgabe(titel: "Fledermausdetektor", art: "rechnen", quelle: "5.4.1", herkunft: "original", vorlage: "Aufgabensammlung 1.3, Teil 2", minuten: 4,
  ergebnis: [Man hört die Schwebung mit $f_s=1 thin "kHz"$.],
)[
#if not web [*Aufgabe 13* #linebreak()]
*Doppler-Fledermäuse, Teil 2*

*Gegeben und Annahmen*

Fledermäuse stoßen Ultraschallrufe aus. Ein Großer Abendsegler ruft mit der konstanten Frequenz $f_A=20 thin "kHz"$ und ruht. In einem Fledermausdetektor werden die Rufe aufgenommen und in Echtzeit dem Signal eines lokalen Oszillators überlagert. Du kannst dann die Schwebung hören. Der Detektor ist auf $f_D=21 thin "kHz"$ eingestellt.

*Gesucht*

#enum(numbering: "a)",
[Was hörst du im Detektor?],
)
][
*Modell wählen:* Zwei harmonische Signale mit nahen Frequenzen werden addiert. Das ist eine Schwebung; hörbar ist der Unterschied der Frequenzen, der ursprünglich unhörbare Ultraschall wird so in den Hörbereich geholt.
][
*Rechnen:* $f_s=abs(f_D-f_A)=abs(21-20) thin "kHz"=1 thin "kHz"$. Du hörst einen Ton von 1 kHz.
][
*Prüfen:* 1 kHz liegt im Hörbereich, 20 kHz und 21 kHz nicht. Der Träger mit 20,5 kHz bleibt unhörbar; 1 kHz darf nicht mit ihm verwechselt werden. Ein Doppler-Effekt tritt nicht auf, weil die Fledermaus ruht.
#src[AS 1.3, Teil 2, PDF-S. 12; Lösung 4.3, PDF-S. 48.]
]

#aufgabe(titel: "Zwergfledermaus im Detektor (Variante)", art: "rechnen", quelle: "5.4.1", herkunft: "variante", vorlage: "Aufgabensammlung 1.3, Teil 2", minuten: 5,
  ergebnis: [a) 2 kHz; b) 44,5 kHz oder 45,5 kHz],
)[
#if not web [*Aufgabe 14* #linebreak()]
*Gegeben und Annahmen*

Eine ruhende Zwergfledermaus ruft mit konstant 45 kHz. Ein Fledermausdetektor überlagert die Rufe in Echtzeit mit dem Signal seines lokalen Oszillators; hörbar ist die Schwebung.

*Gesucht*

#enum(numbering: "a)",
[Was hörst du, wenn der Oszillator auf 47 kHz eingestellt ist?],
[Auf welche Oszillatorfrequenzen musst du den Detektor einstellen, damit du einen Ton von 500 Hz hörst?],
)
][
*Modell:* Überlagerung zweier naher Frequenzen; hörbar ist $f_s=abs(f_D-f_A)$.
][
*a) Rechnen:* $f_s=abs(47-45) thin "kHz"=2 thin "kHz"$.
][
*b) Rückwärts:* $abs(f_D-45 thin "kHz")="0,5" thin "kHz"$ hat zwei Lösungen: $f_D="44,5" thin "kHz"$ oder $f_D="45,5" thin "kHz"$. Die Schwebung verrät nur den Betrag des Unterschieds.
][
*Prüfen:* Beide Ergebnisse liegen 500 Hz neben 45 kHz; 2 kHz und 500 Hz sind hörbar, 45 kHz nicht.
#src[Eigene Variante nach AS 1.3, Teil 2, PDF-S. 12.]
]

#aufgabe(titel: "Schwebung zweier Stimmgabeln", art: "rechnen", quelle: "5.4.1", herkunft: "eigen",
  ergebnis: [$f_m = "441,5" thin "Hz"$, $T_s approx "0,333" thin "s"$, $omega_d approx "9,42" thin "s"^(-1)$, 30 Schwebungen in 10 s],
  tipp: [Der Träger liegt in der Mitte der beiden Frequenzen, die hörbare Schwebung beim Abstand.],
)[
#if not web [*Aufgabe 15* #linebreak()]
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

#aufgabe(titel: "Saite zu tief oder zu hoch?", art: "rechnen", quelle: "5.4.1", herkunft: "eigen",
  ergebnis: [438 Hz oder 442 Hz möglich; es war 438 Hz],
  tipp: [Die Schwebung verrät nur den Abstand, nicht die Richtung. Was macht Spannen mit der Frequenz?],
)[
#if not web [*Aufgabe 16* #linebreak()]
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

#aufgabe(titel: "Schwebung bei 300 und 304 Hz", art: "rechnen", quelle: "5.4.1", herkunft: "eigen",
  ergebnis: [$f_m = 302 thin "Hz"$, $T_s = "0,25" thin "s"$, $omega_d = 4 pi thin "s"^(-1)$],
)[
#if not web [*Aufgabe 17* #linebreak()]
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

#aufgabe(titel: "Schwebungen pro Minute", art: "rechnen", quelle: "5.4.1", herkunft: "eigen",
  ergebnis: [$f_m = 514 thin "Hz"$, $T_s = "0,25" thin "s"$, 240 Schwebungen pro Minute],
)[
#if not web [*Aufgabe 18* #linebreak()]
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

#aufgabe(titel: "Zweite Orgelpfeife bestimmen", art: "rechnen", quelle: "5.4.1", herkunft: "eigen",
  ergebnis: [217 Hz oder 223 Hz],
)[
#if not web [*Aufgabe 19* #linebreak()]
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

#aufgabe(titel: "Verstimmung beim Klavier", art: "rechnen", quelle: "5.4.1", herkunft: "eigen",
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

#aufgabe(titel: "Träger und Anschwellrhythmus", art: "rechnen", quelle: "5.4.1", herkunft: "eigen",
  ergebnis: [$f_m = 258 thin "Hz"$, $f_s = 4 thin "Hz"$, $T_s = "0,25" thin "s"$],
)[
#if not web [*Aufgabe 21* #linebreak()]
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

#aufgabe(titel: "Frequenz- und Kreisfrequenzdifferenz", art: "rechnen", quelle: "5.4.1", herkunft: "eigen",
  ergebnis: [$abs(f_1 - f_2) = 2 thin "Hz"$, $abs(omega_1 - omega_2) = 4 pi thin "s"^(-1) approx "12,566" thin "s"^(-1)$],
)[
#if not web [*Aufgabe 22* #linebreak()]
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

#aufgabe(titel: "Bewegungsgleichungen gekoppelter Pendel", art: "verstehen", quelle: "5.4.2", herkunft: "eigen")[
#if not web [*Aufgabe 23* #linebreak()]
Stelle beide Bewegungsgleichungen für zwei identische gekoppelte Federpendel auf. Warum hängt die Kraft der mittleren Feder vom Unterschied der Auslenkungen ab?
][
*Gleichungen:* $m dot.double(x)_1=-D x_1-D_k(x_1-x_2)$ und $m dot.double(x)_2=-D x_2-D_k(x_2-x_1)$.
][
*Begründung:* Die Kopplungsfeder wird nur gedehnt oder gestaucht, wenn sich der Abstand der Massen ändert, also um $x_2-x_1$. Bewegen sich beide gleich weit, bleibt sie entspannt. Merksatz: Die Kopplungsfeder spürt den Unterschied der Auslenkungen.
#src[L, Frage 5 und K7, PDF-S. 8, 10 und 15; Karteikarte zu 5.4.2.]
]

#aufgabe(titel: "Summe und Differenz als neue Koordinaten", art: "verstehen", quelle: "5.4.2", herkunft: "eigen")[
#if not web [*Aufgabe 24* #linebreak()]
Mit welchen Hilfsgrößen entkoppelt man die Bewegungsgleichungen zweier gekoppelter Pendel, und warum funktionieren gerade diese? Beschreibe auch den Weg zurück zu $x_1$ und $x_2$.
][
*Hilfsgrößen:* $psi_1=x_1+x_2$ und $psi_2=x_1-x_2$. Addieren und Subtrahieren der beiden Gleichungen liefert zwei unabhängige harmonische Gleichungen, jede wie ein einzelnes Federpendel.
][
*Rückweg:* Nach dem getrennten Lösen gilt $x_1=(psi_1+psi_2)/2$ und $x_2=(psi_1-psi_2)/2$.
][
*Typische Verwechslungen:* Produkt oder Quotient ($x_1 x_2$, $x_1\/x_2$) machen die Gleichungen nichtlinear. $x_1$, $x_2$ selbst sind gerade die gekoppelten Koordinaten, und Geschwindigkeiten statt Auslenkungen lösen die Kopplung auch nicht.
#src[L, Frage 6 und K8, PDF-S. 8, 10 und 15; LB, Frage 4, PDF-S. 2; Quizfrage und Karteikarte zu 5.4.2.]
]

#aufgabe(titel: "Gleichtakt und Gegentakt", art: "verstehen", quelle: "5.4.2", herkunft: "eigen")[
#if not web [*Aufgabe 25* #linebreak()]
Vergleiche Gleich- und Gegentakt zweier gleicher, über $D_k$ gekoppelter Federpendel: Wie bewegen sich die Massen, was macht die mittlere Feder, woher kommt $2D_k$, und welche Mode ist schneller?
][
*Gleichtakt:* $x_1=x_2$, der Abstand bleibt gleich, die Kopplungsfeder ungedehnt: $omega_"gl"=sqrt(D/m)$ wie beim einzelnen Pendel.
][
*Gegentakt:* $x_1=-x_2$; zu einer Massenauslenkung $x$ gehört eine Dehnung der Kopplungsfeder um $2x$. Daraus die zusätzliche Rückstellung $2D_k$ und $omega_"gg"=sqrt((D+2D_k)/m)>omega_"gl"$ für $D_k>0$.
][
*Typische Verwechslungen:* Die Gegentaktfrequenz ist nicht kleiner, sondern größer. Und die Kopplungsfeder ist im Gegentakt nicht zu jedem Zeitpunkt maximal gedehnt: Beim Durchgang durch die Ruhelage ist ihre Dehnung null. Merksatz: Gleichtakt schont die Kopplungsfeder, Gegentakt spannt sie.
#src[L, Fragen 7 und 24, PDF-S. 8–10; LB, Frage 3, PDF-S. 2; Quizfrage und Karteikarte zu 5.4.2.]
]

#aufgabe(titel: "Überlagerung oder Kopplung?", art: "verstehen", quelle: "5.4.2", herkunft: "eigen")[
#if not web [*Aufgabe 26* #linebreak()]
Was ist der Unterschied zwischen der Überlagerung und der Kopplung zweier Schwingungen?
][
*Unterschied:* Bei der Überlagerung addiert man zwei Bewegungen, die sich gegenseitig nicht beeinflussen (z. B. Schwebung). Bei der Kopplung wirkt ein Schwinger auf den anderen, etwa über eine Feder zwischen zwei Pendeln, die Kräfte und Energie überträgt. Merksatz: Überlagerung addiert; Kopplung beeinflusst sich gegenseitig.
#src[Karteikarte zu 5.4.2, Abbildung pendel-quelle.]
]

#aufgabe(titel: "Was ist eine Eigenmode?", art: "verstehen", quelle: "5.4.2", herkunft: "eigen")[
#if not web [*Aufgabe 27* #linebreak()]
Was ist eine Eigenmode? Nenne die beiden Eigenmoden zweier gekoppelter Pendel.
][
*Begriff:* Eine feste gemeinsame Schwingungsform aller beteiligten Massen: Alle schwingen mit derselben Frequenz, und das Verhältnis ihrer Amplituden bleibt gleich. Bei zwei gekoppelten Pendeln sind das Gleichtakt und Gegentakt.
#src[Karteikarte zu 5.4.2, Abbildung pendel-quelle.]
]

#aufgabe(titel: "Eigenfrequenzen gekoppelter Federpendel", art: "rechnen", quelle: "5.4.2", herkunft: "eigen")[
#if not web [*Aufgabe 28* #linebreak()]
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

#aufgabe(titel: "Austauschdauer gekoppelter Pendel", art: "rechnen", quelle: "5.4.2", herkunft: "eigen",
  ergebnis: [$omega_"gl" = 10 thin "s"^(-1)$, $omega_"gg" approx "10,488" thin "s"^(-1)$, $T_s approx "12,87" thin "s"$],
  tipp: [Im Gleichtakt bleibt die Kopplungsfeder ungedehnt, im Gegentakt wirkt sie doppelt.],
)[
#if not web [*Aufgabe 29* #linebreak()]
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

#aufgabe(titel: "Federkonstanten aus gemessenen Frequenzen", art: "rechnen", quelle: "5.4.2", herkunft: "eigen",
  ergebnis: [$D = 36 thin "N/m"$, $D_k = "3,125" thin "N/m"$, $T_s approx "12,57" thin "s"$],
)[
#if not web [*Aufgabe 30* #linebreak()]
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

#aufgabe(titel: "Kopplungsfeder für 5 s Austausch", art: "rechnen", quelle: "5.4.2", herkunft: "eigen",
  ergebnis: [$D_k approx "5,342" thin "N/m"$],
  tipp: [Aus $T_s$ bekommst du die nötige Differenz der Eigenkreisfrequenzen.],
)[
#if not web [*Aufgabe 31* #linebreak()]
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

#aufgabe(titel: "Energieaustausch zwischen zwei Pendeln", art: "verstehen", quelle: "5.4.3", herkunft: "eigen")[
#if not web [*Aufgabe 32* #linebreak()]
Pendel 1 wird ausgelenkt und losgelassen, das gekoppelte Pendel 2 ist anfangs in Ruhe. Was beobachtest du? Erkläre den Wechsel der Hüllkurven und die Bedeutung von $T_s$.
][
*Beobachtung:* Die Schwingung wandert langsam zu Pendel 2 hinüber, bis Pendel 1 fast ruht, und dann wieder zurück. Merksatz: Energie wandert hin und zurück, nicht nur von eins nach zwei.
][
*Erklärung:* Der Anfangszustand regt beide Eigenmoden an. Ihre leicht verschiedenen Frequenzen überlagern sich zu einer Schwebung: $x_1$ hat die Hülle $cos(Delta omega t\/2)$, $x_2$ die Hülle $sin(Delta omega t\/2)$. Nach etwa $T_s\/2$ schwingt fast nur Pendel 2; ein vollständiger Zyklus dauert $T_s=2pi/(omega_"gg"-omega_"gl")$. Eine einzelne Auslenkung null ist kein Beweis für Energie null.
][
*Bild:* Zwei verbundene Schaukeln: Eine wird ruhiger, während die andere stärker schwingt; später kehrt es sich um.
#src[L, Frage 8 und K11, PDF-S. 8, 10 und 16; LB, Frage 5, PDF-S. 2; Quizfrage und Karteikarte zu 5.4.3, Abbildung alt-kopplung.]
]

#aufgabe(titel: "Härtere oder weichere Kopplungsfeder", art: "verstehen", quelle: "5.4.3", herkunft: "eigen")[
#if not web [*Aufgabe 33* #linebreak()]
Die Kopplungsfeder wird steifer (oder weicher). Was passiert mit beiden Eigenkreisfrequenzen und mit der Austauschdauer $T_s$?
][
*Frequenzen:* Ein härteres $D_k$ lässt den Gleichtakt unverändert und erhöht den Gegentakt. Die Differenz $omega_"gg"-omega_"gl"$ wächst, $T_s$ wird *kürzer*: Der Energieaustausch läuft schneller.
][
*Umgekehrt und Grenzfall:* Weichere Kopplung verlängert $T_s$; für $D_k=0$ sind die Schwinger entkoppelt und es gibt keinen Austausch.
][
*Typische Verwechslungen:* „Beide Frequenzen steigen gleich stark“ ist falsch, weil $omega_"gl"$ gar nicht von $D_k$ abhängt. „$T_s$ wird null“ ist ebenfalls falsch: $T_s$ wird kleiner, bleibt aber endlich.
#src[L, Frage 25 und Üben 13a, PDF-S. 9, 11 und 13–14; LB, Frage 6, PDF-S. 2; Quizfrage und Karteikarte zu 5.4.3.]
]

#aufgabe(titel: "Drei Pendel und die lange Kette", art: "verstehen", quelle: "5.4.3", herkunft: "eigen")[
#if not web [*Aufgabe 34* #linebreak()]
Wie viele Eigenmoden besitzen $N$ linear gekoppelte Schwinger mit je einem Freiheitsgrad, etwa drei Pendel? Was ist beim Übergang zu einer langen Kette der neue Gedanke?
][
*Anzahl:* $N$ Schwinger mit je einem Freiheitsgrad haben $N$ Eigenmoden; drei Pendel also drei.
][
*Schritt zur Welle:* Bei sehr vielen hintereinander gekoppelten Gliedern wird die Störung von Nachbar zu Nachbar weitergereicht. Das führt von der gemeinsamen Schwingungsform zur räumlichen Ausbreitung einer Welle.
#src[LB, Frage 7, PDF-S. 2; L, K12, PDF-S. 16; V1, PDF-S. 6–7; Karteikarte zu 5.4.3.]
]

#aufgabe(titel: "Kopplungsfeder für 10 s Austausch", art: "rechnen", quelle: "5.4.3", herkunft: "eigen")[
#if not web [*Aufgabe 35* #linebreak()]
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


#kapitel("Kapitel 6 · Wellen")

#aufgabe(titel: "Von gekoppelten Pendeln zur Welle", art: "verstehen", quelle: "6.1", herkunft: "eigen")[
#if not web [*Aufgabe 36* #linebreak()]
Was ist eine Welle, und was wandert dabei eigentlich? Erkläre den Übergang von vielen gekoppelten Pendeln zur Welle und beschreibe, was die einzelnen Seilstücke tun, wenn ein Wellenberg über ein Seil läuft.
][
*Weitergabe:* Eine Welle ist eine sich ausbreitende Störung. Die Kopplung überträgt Schwingungszustand und Energie an benachbarte Schwinger. Was wandert, ist das Muster, nicht das Material.
][
*Seilstücke:* Sie bewegen sich nur um ihre Ruhelage, beim Seil senkrecht zur Ausbreitungsrichtung (transversal). Typische Verwechslungen: Sie laufen nicht mit dem Berg mit; parallele Bewegung wäre eine Longitudinalwelle; ganz in Ruhe gäbe es keine Welle. Merksatz: Das Muster wandert, die Teilchen schwingen am Ort.
][
*Bild:* Stadionwelle: Die Menschen bleiben auf ihren Plätzen, nur das Aufstehen wandert durchs Stadion.
#src[L, Frage 9 und K13, PDF-S. 8, 11 und 16; LB, PDF-S. 1; Quizfrage und Karteikarte zu 6.1, Abbildung wellenarten-quelle.]
]

#aufgabe(titel: "Longitudinal und transversal", art: "verstehen", quelle: "6.1", herkunft: "eigen")[
#if not web [*Aufgabe 37* #linebreak()]
Was unterscheidet longitudinale von transversalen Wellen? Welche Art ist Schall in Luft, welche eine Welle auf einem gespannten Seil? Warum trägt Luft im behandelten Modell keine mechanische Scherwelle?
][
*Begriffe:* Longitudinal: Teilchen schwingen in Ausbreitungsrichtung, es entstehen Verdichtungen und Verdünnungen. Transversal: Teilchen schwingen quer zur Ausbreitung.
][
*Beispiele:* Schall in Luft ist eine *Longitudinalwelle* (Dichte-/Druckwelle), die Seilwelle eine *Transversalwelle*. Festkörper können beide Arten tragen.
][
*Begründung:* Transversalwellen im Inneren eines Mediums brauchen eine seitliche Rückstellkraft (Scherkraft). Luft hat im Modell keine solche elastische Scher-Rückstellwirkung. Merksatz: Longitudinal längs, transversal quer.
#src[L, Fragen 10 und 26, PDF-S. 8–11; LB, Fragen 8–9, PDF-S. 2; Quizfrage (Lückentext) und Karteikarte zu 6.1.]
]

#aufgabe(titel: "Muss eine Welle periodisch sein?", art: "verstehen", quelle: "6.1", herkunft: "eigen")[
#if not web [*Aufgabe 38* #linebreak()]
Muss eine Welle periodisch sein? Nenne ein Beispiel.
][
*Antwort:* Nein. Ein einzelner Knall oder ein einmaliges Zupfen erzeugt einen *Puls*, also eine einzelne wandernde Störung. Harmonische Wellen sind nur ein besonders nützlicher Spezialfall.
#src[Karteikarte zu 6.1, Abbildung wellenarten-quelle.]
]

#aufgabe(titel: "Welle in einer Pendelkette", art: "rechnen", quelle: "6.1", herkunft: "eigen",
  ergebnis: [$c = "2,5" thin "m/s"$, $lambda = "0,5" thin "m"$, longitudinal],
)[
#if not web [*Aufgabe 39* #linebreak()]
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

#aufgabe(titel: "Laufrichtung von u(x − ct) und u(x + ct)", art: "verstehen", quelle: "6.1.1", herkunft: "eigen")[
#if not web [*Aufgabe 40* #linebreak()]
In welche Richtung laufen $u(x-c t)$ und $u(x+c t)$? Begründe über einen Punkt gleicher Phase. Welche Modellvoraussetzung steckt in dieser Schreibweise?
][
*Fester Wellenberg:* Ein bestimmter Berg hat ein festes Argument $a$. Bei $u(x-c t)$ folgt $x=a+c t$: Sein Ort wächst, Lauf nach $+x$. Bei $u(x+c t)$ folgt $x=a-c t$: Lauf nach $-x$. Merksatz: Minus im Argument läuft nach plus $x$.
][
*Voraussetzung und Verwechslungen:* Die Form $u$ wird unverändert mit konstantem $c$ verschoben. Die Richtung steckt allein im Vorzeichen vor $c t$, nicht in der Form von $u$. Eine stehende Welle hätte die Form $f(x) g(t)$.
#src[L, Fragen 11 und 27, PDF-S. 8–11; LB, Frage 10, PDF-S. 2; Quizfrage und Karteikarte zu 6.1.1.]
]

#aufgabe(titel: "λ f = c herleiten", art: "verstehen", quelle: "6.2", herkunft: "eigen")[
#if not web [*Aufgabe 41* #linebreak()]
Warum gilt $c=lambda f$? Was legt die Quelle fest, was das Medium? Wie ändert sich $lambda$, wenn bei gleichem $f$ das Medium ein größeres $c$ erlaubt?
][
*Herleitung:* In einer Periodendauer $T$ rückt ein Wellenberg genau um eine Wellenlänge vor: $c=lambda\/T=lambda f$.
][
*Rollen:* Die Quelle gibt den Takt $f$ vor, das Medium die Geschwindigkeit $c$. Daraus folgt $lambda=c\/f$. Bei gleichem $f$ wächst $lambda$ proportional zu $c$; beim Übergang in ein anderes Medium bleibt $f$ gleich, $c$ und $lambda$ ändern sich. Merksatz: Die Quelle gibt den Takt, das Medium das Tempo.
#src[L, Frage 13 und Üben 13d, PDF-S. 8, 11 und 13–14; Karteikarten zu 6.2.]
]

#aufgabe(titel: "Warum harmonische Wellen?", art: "verstehen", quelle: "6.2", herkunft: "eigen")[
#if not web [*Aufgabe 42* #linebreak()]
Warum untersucht die Vorlesung harmonische Wellen, obwohl auch einzelne Pulse auftreten? Was sagt das Fourier-Theorem dabei aus?
][
Harmonische Wellen sind Bausteine, aus deren Überlagerung nicht sinusförmige Signale dargestellt werden können. Ein Puls muss selbst keine Sinusform besitzen. Das Theorem macht die einzelnen Anteile nützlich, nicht jede Gesamtwelle harmonisch.

#src[L, Frage 14 und K24, PDF-S. 8, 11 und 16; V1, PDF-S. 11.]
]

#aufgabe(titel: "Wellenlänge und Periodendauer unterscheiden", art: "verstehen", quelle: "6.2", herkunft: "eigen")[
#if not web [*Aufgabe 43* #linebreak()]
Was ist der Unterschied zwischen Wellenlänge und Periodendauer?
][
*Raum und Zeit:* Die Wellenlänge $lambda$ ist die räumliche Wiederholung: der Abstand zweier gleicher Punkte in einer Momentaufnahme. Die Periodendauer $T$ ist die zeitliche Wiederholung: wie lange ein fester Ort für eine Schwingung braucht. Merksatz: $lambda$ wiederholt im Raum, $T$ wiederholt in der Zeit.
#src[Karteikarte zu 6.2, Abbildung alt-harmwelle.]
]

#aufgabe(titel: "Wellenlänge des Kammertons in Luft", art: "verstehen", quelle: "6.2", herkunft: "eigen")[
#if not web [*Aufgabe 44* #linebreak()]
Schall mit $c=343 thin "m/s"$ und $f=440 thin "Hz"$: Wie groß ist die Wellenlänge, und an welchen Fehlern erkennst du falsche Ergebnisse?
][
*Rechnen:* $lambda=c\/f=343\/440 thin "m" approx "0,78" thin "m"$.
][
*Typische Verwechslungen:* 1,28 m entsteht aus $f\/c$ (Einheit wäre gar keine Länge). 150 920 entsteht aus $c dot f$ (Einheit m/s², keine Länge). 343 m ist die Strecke, die der Schall in einer Sekunde zurücklegt.
#src[Quizfrage zu 6.2.]
]

#aufgabe(titel: "Luft in Wasser: Was bleibt gleich?", art: "verstehen", quelle: "6.2", herkunft: "eigen")[
#if not web [*Aufgabe 45* #linebreak()]
Eine Schallwelle läuft von Luft in Wasser. Welche der Größen Frequenz, Wellenlänge und Ausbreitungsgeschwindigkeit bleibt gleich, und warum?
][
*Antwort:* Die *Frequenz* bleibt gleich: Die Quelle gibt den Takt vor, und zwischen ruhenden Medien wird er unverändert weitergegeben.
][
*Folgerung:* $c$ hängt vom Medium ab und ist im Wasser größer. Wegen $lambda=c\/f$ muss sich dann auch $lambda$ ändern (sie wird größer). Typische Verwechslung: „Frequenz und Wellenlänge bleiben“ ist unmöglich, wenn sich $c$ ändert.
#src[Quizfrage zu 6.2.]
]

#aufgabe(titel: "Wann erreicht die Welle die Ente?", art: "rechnen", quelle: "6.2", herkunft: "original", vorlage: "Übung 10, Aufg. 2", minuten: 4,
  ergebnis: [$t approx "4,2" thin "s"$],
  tipp: [Die Amplitude ist eine Ablenkung; für die Laufzeit brauchst du nur die Geschwindigkeit.],
)[
#if not web [*Aufgabe 46* #linebreak()]
*Wasserwellen*

*Gegeben und Annahmen*

Kinder werfen ein Steinchen nach einer Ente im Teich, treffen aber nicht: Der Stein fällt 5 m von der Ente entfernt ins Wasser und erzeugt eine ungedämpfte, sinusförmige Wasserwelle mit Amplitude $A=5 thin "cm"$, Frequenz $f=3 thin "Hz"$ und Wellenlänge $lambda="0,4" thin "m"$.

*Gesucht*

#enum(numbering: "a)",
[Nach welcher Zeit erreichen die Wellen die Ente?],
)
][
*Geschwindigkeit:* $c=lambda f="0,4" dot 3 thin "m/s"="1,2" thin "m/s"$.
][
*Laufzeit:* $t=s\/c=5\/"1,2" thin "s" approx "4,17" thin "s" approx "4,2" thin "s"$.
][
*Prüfen:* Die Amplitude wird nicht gebraucht; sie sagt, wie hoch die Ente schaukelt, nicht wann. Gut vier Sekunden bei 1,2 m/s sind etwa fünf Meter.
#src[Ü 10.2, PDF-S. 1; R, PDF-S. 1.]
]

#aufgabe(titel: "Steinwurf am Steg (Variante)", art: "rechnen", quelle: "6.2", herkunft: "variante", vorlage: "Übung 10, Aufg. 2", minuten: 5,
  ergebnis: [a) $c="1,5" thin "m/s"$, $t=6 thin "s"$; b) 15 Wellenlängen],
)[
#if not web [*Aufgabe 47* #linebreak()]
*Gegeben und Annahmen*

Ein Stein fällt 9 m von einem Steg entfernt in einen ruhigen See. Er erzeugt eine ungedämpfte Sinuswelle mit Amplitude 3 cm, Frequenz 2,5 Hz und Wellenlänge 0,6 m.

*Gesucht*

#enum(numbering: "a)",
[Nach welcher Zeit erreicht die erste Welle den Steg?],
[Wie viele Wellenlängen passen in diesem Moment zwischen Einschlagstelle und Steg?],
)
][
*Geschwindigkeit:* $c=lambda f="0,6" dot "2,5" thin "m/s"="1,5" thin "m/s"$.
][
*Laufzeit:* $t=9\/"1,5" thin "s"=6 thin "s"$.
][
*Wellenlängen:* $9\/"0,6"=15$. Kontrolle über die Zeit: In 6 s erzeugt die Quelle $6 dot "2,5"=15$ Schwingungen, jede schiebt eine Wellenlänge hinaus.
][
*Prüfen:* Die Amplitude bleibt wieder ungenutzt; sie bestimmt die Höhe, nicht das Tempo.
#src[Eigene Variante nach Ü 10.2.]
]

#aufgabe(titel: "Wellenlängen des Hörbereichs", art: "rechnen", quelle: "6.2", herkunft: "eigen",
  ergebnis: [1,7 cm bis 17 m],
)[
#if not web [*Aufgabe 48* #linebreak()]
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

#aufgabe(titel: "Geschwindigkeit eines Pulses", art: "rechnen", quelle: "6.2", herkunft: "eigen",
  ergebnis: [$c = 24 thin "m/s"$, $lambda = 3 thin "m"$],
)[
#if not web [*Aufgabe 49* #linebreak()]
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

#aufgabe(titel: "Kenngrößen einer 50-Hz-Welle", art: "rechnen", quelle: "6.2", herkunft: "eigen",
  ergebnis: [$c = 200 thin "m/s"$, $T = 20 thin "ms"$, $k = pi\/2 thin "m"^(-1)$, $omega = 100 pi thin "s"^(-1)$],
)[
#if not web [*Aufgabe 50* #linebreak()]
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

#aufgabe(titel: "Wellenfunktion nach +x lesen", art: "rechnen", quelle: "6.2", herkunft: "eigen",
  ergebnis: [$lambda = 1 thin "m"$, $f = 50 thin "Hz"$, $c = 50 thin "m/s"$, Laufrichtung $+x$],
)[
#if not web [*Aufgabe 51* #linebreak()]
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

#aufgabe(titel: "Wellenfunktion nach −x aufstellen", art: "rechnen", quelle: "6.2", herkunft: "eigen",
  ergebnis: [$psi(x,t) = 1 thin "cm" · sin((2pi\/3) thin "m"^(-1) x + 8 pi thin "s"^(-1) t)$],
)[
#if not web [*Aufgabe 52* #linebreak()]
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

#aufgabe(titel: "Welle nach −x mit maximaler Schnelle", art: "rechnen", quelle: "6.2", herkunft: "eigen",
  ergebnis: [$lambda = 4 thin "m"$, $f = 10 thin "Hz"$, $c = 40 thin "m/s"$, Richtung $-x$, $s_"max" approx "0,314" thin "m/s"$],
)[
#if not web [*Aufgabe 53* #linebreak()]
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

#aufgabe(titel: "Zwei Lautsprecher mit 680 und 684 Hz", art: "rechnen", quelle: "6.2", herkunft: "eigen",
  ergebnis: [$lambda_1 = "0,500" thin "m"$, $lambda_2 approx "0,49708" thin "m"$; $f_m = 682 thin "Hz"$, $T_s = "0,25" thin "s"$],
)[
#if not web [*Aufgabe 54* #linebreak()]
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

#aufgabe(titel: "Schnelle und Ausbreitungsgeschwindigkeit", art: "verstehen", quelle: "6.2.1", herkunft: "eigen")[
#if not web [*Aufgabe 55* #linebreak()]
Unterscheide Schnelle $s$ und Ausbreitungsgeschwindigkeit $c$. Wo ist die Schnelle eines Teilchens am größten, wo null, und wie kann ein Teilchen gerade stillstehen, obwohl die Welle weiterläuft?
][
*Unterschied:* Die Schnelle $s=partial psi\/partial t$ ist die Geschwindigkeit eines Teilchens am Ort; $c$ ist die Geschwindigkeit, mit der das Muster wandert. Ein Luftteilchen fliegt nicht mit 343 m/s zum Zuhörer. Merksatz: Teilchentempo ist nicht Mustertempo.
][
*Maximum und Null:* Am Umkehrpunkt (maximale Auslenkung) ist $s=0$; beim Durchgang durch die Ruhelage ist $abs(s)$ maximal, $s_"max"=psi_0 omega$. Die Phase wandert trotzdem mit $c$ weiter, weil benachbarte Orte zeitversetzt denselben Zustand annehmen.
][
*Typische Verwechslung:* „$s$ ist immer größer als $c$“: Es gibt keinen festen Zusammenhang; $s_"max"$ hängt von Amplitude und Frequenz ab, $c$ vom Medium.
#src[L, Frage 12 und Üben 13c, PDF-S. 8, 11 und 13–14; LB, Frage 12, PDF-S. 2; Quizfrage und Karteikarten zu 6.2.1.]
]

#aufgabe(titel: "Was sind Wellenfronten?", art: "verstehen", quelle: "6.2.1", herkunft: "eigen")[
#if not web [*Aufgabe 56* #linebreak()]
Was sind Wellenfronten? Reicht gleiche Auslenkung als Kriterium?
][
*Begriff:* Wellenfronten verbinden Punkte mit gleichem Schwingungszustand, also gleicher Phase. Gleiche Auslenkung allein reicht nicht; auch die Bewegungsrichtung muss passen.
#src[Karteikarte zu 6.2.1, Abbildung schnelle-quelle.]
]

#aufgabe(titel: "Wellenfunktion ablesen", art: "rechnen", quelle: "6.2.1", herkunft: "eigen")[
#if not web [*Aufgabe 57* #linebreak()]
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

#aufgabe(titel: "Wellengeschwindigkeit auf der Saite verdoppeln", art: "verstehen", quelle: "6.3", herkunft: "eigen")[
#if not web [*Aufgabe 58* #linebreak()]
Die Zugkraft einer Saite wird vervierfacht. Wie ändert sich die Ausbreitungsgeschwindigkeit? Welche Änderung der Dichte würde dasselbe bewirken?
][
*Formel:* $c=sqrt(F\/(rho A))$. Vierfache Zugkraft ergibt $sqrt(4)=2$, also doppelte Geschwindigkeit. Bei festem $F$ und $A$ müsste $rho$ auf ein Viertel sinken; vierfache Dichte würde $c$ halbieren. Merksatz: Vierfach unter der Wurzel ergibt doppelt davor.
][
*Typische Verwechslungen:* „Vervierfacht sich“ übersieht die Wurzel. „Halbiert sich“ oder „bleibt gleich“ widerspricht dem Stimmen: Gerade über die Spannung ändert man $c$ und damit den Ton.
#src[Eigene Verständnisfrage aus VB, PDF-S. 10, Gl. 6.4; Quizfrage und Karteikarte zu 6.3.]
]

#aufgabe(titel: "Steifigkeit und Dichte bestimmen das Tempo", art: "verstehen", quelle: "6.3", herkunft: "eigen")[
#if not web [*Aufgabe 59* #linebreak()]
Warum hängt die Wellengeschwindigkeit von Steifigkeit und Dichte des Mediums ab?
][
*Weitergabe:* Die Nachbarteilchen müssen sich die Bewegung weitergeben. Starke Rückstellkräfte (Steifigkeit, Spannung) beschleunigen die Weitergabe, große Trägheit (Dichte) bremst sie. Deshalb steht in den Formeln meist $sqrt("Steifigkeit"\/"Dichte")$, etwa $c=sqrt(F\/(rho A))$ oder $c=sqrt(K\/rho)$.
#src[Karteikarte zu 6.3, Abbildung saite-quelle.]
]

#aufgabe(titel: "Schallgeschwindigkeit im idealen Gas", art: "verstehen", quelle: "6.3", herkunft: "eigen")[
#if not web [*Aufgabe 60* #linebreak()]
Wovon hängt die Schallgeschwindigkeit in einem idealen Gas ab?
][
*Formel:* $c=sqrt(kappa R T\/m_"mol")$. Bei demselben Gas hängt sie nur von der absoluten Temperatur ab: $c prop sqrt(T)$, $T$ in Kelvin. Wärmere Luft leitet Schall schneller (etwa 330 m/s bei 0 °C, 343 m/s bei 20 °C).
#src[Karteikarte zu 6.3.]
]

#aufgabe(titel: "Celsius statt Kelvin bei der Schallgeschwindigkeit", art: "verstehen", quelle: "6.3", herkunft: "eigen")[
#if not web [*Aufgabe 61* #linebreak()]
In Luft beträgt die Schallgeschwindigkeit bei 0 °C etwa 330 m/s. Warum darf man für 20 °C nicht einfach mit $sqrt(20\/0)$ rechnen?
][
*Absolute Temperatur:* Im Verhältnis $c_2\/c_1=sqrt(T_2\/T_1)$ steht die Temperatur in Kelvin. Celsiuswerte sind verschoben: 0 °C sind 273,15 K. Also $sqrt("293,15"\/"273,15") approx "1,036"$ und $c approx 342 thin "m/s"$, passend zu 343 m/s aus dem Skript.
#src[Quizfrage zu 6.3.]
]

#aufgabe(titel: "Ton von Wasser in Luft", art: "rechnen", quelle: "6.3", herkunft: "original", vorlage: "Übung 10, Aufg. 1", minuten: 4,
  ergebnis: [Frequenz bleibt 256 Hz, Wellenlänge wird kürzer: $lambda_"Wasser" approx "5,86" thin "m"$, $lambda_"Luft" approx "1,33" thin "m"$ (Antwort b)],
)[
#if not web [*Aufgabe 62* #linebreak()]
*Wellenlänge, Frequenz und Ausbreitungsgeschwindigkeit*

*Gegeben und Annahmen*

Schall breitet sich mit 340 m/s in Luft und 1500 m/s in Wasser aus. Unter Wasser wird ein Ton von 256 Hz erzeugt, der in die Luft übertritt.

*Gesucht*

#enum(numbering: "a)",
[Was geschieht in Luft mit Frequenz und Wellenlänge? (Im Original Auswahl: Frequenz höher/dieselbe/niedriger, Wellenlänge gleich/kürzer/länger.) Begründe.],
[Berechne zur Kontrolle die Wellenlänge in Wasser und in Luft.],
)
][
*Frequenz:* Die Grenzfläche wird im Takt der Quelle angestoßen und gibt genau diesen Takt weiter: $f=256 thin "Hz"$ in beiden Medien.
][
*Wellenlängen:* $lambda_"Wasser"=1500\/256 thin "m" approx "5,859" thin "m"$, $lambda_"Luft"=340\/256 thin "m" approx "1,328" thin "m"$. Die Welle wird kürzer, weil sie in Luft langsamer ist. Richtige Antwort also: Frequenz dieselbe, Wellenlänge kürzer.
][
*Prüfen:* Das Verhältnis der Wellenlängen ist $340\/1500$, genau das Verhältnis der Geschwindigkeiten.
#src[Ü 10.1, PDF-S. 1; R, PDF-S. 1.]
]

#aufgabe(titel: "Echolot in Wasser und Luft", art: "rechnen", quelle: "6.3", herkunft: "variante", vorlage: "Übung 10, Aufg. 1",
  ergebnis: [Wasser 2,96 cm, Luft 6,8 mm],
)[
#if not web [*Aufgabe 63* #linebreak()]
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

#aufgabe(titel: "Klavierstimmer: Zugkraft erhöhen", art: "rechnen", quelle: "6.3", herkunft: "original", vorlage: "Übung 10, Aufg. 4", minuten: 10,
  ergebnis: [Zugkraft um etwa 2,3 % erhöhen; $c_"nach"\/c_"vor"=440\/435 approx "1,0115"$],
)[
#if not web [*Aufgabe 64* #linebreak()]
*Klavierstimmer*

*Gegeben und Annahmen*

Ein Klavierstimmer stimmt die a-Saite eines Klaviers, indem er auf die Schwebung zwischen der angeschlagenen Saite und seiner Stimmgabel (Kammerton a, 440 Hz) hört. Zu Beginn ist die Saite verstimmt; er hört eine Schwebung mit der Schwebungsdauer 0,2 s. Die Saite war zu Beginn zu wenig gespannt, ihre Frequenz lag unter 440 Hz. Sie schwingt in ihrer Grundmode; Länge und Masse je Länge bleiben gleich.

*Gesucht*

#enum(numbering: "a)",
[Um welchen Prozentsatz muss er die Zugkraft erhöhen, damit die Saite mit 440 Hz schwingt und die Schwebung verschwindet?],
[Berechne das Verhältnis der Ausbreitungsgeschwindigkeiten auf der Saite vor und nach dem Stimmen.],
)
][
*Frequenz vorher:* $f_s=1\/T_s=5 thin "Hz"$. Weil die Saite zu tief liegt: $f_"vor"=435 thin "Hz"$.
][
*Geschwindigkeiten:* Grundmode $f=c\/(2L)$ mit festem $L$, also $c prop f$: $c_"nach"\/c_"vor"=440\/435 approx "1,0115"$.
][
*Zugkraft:* $c=sqrt(F\/(rho A))$ ergibt $F prop c^2$: $F_"nach"\/F_"vor"=(440\/435)^2 approx "1,0231"$. Die Zugkraft muss um etwa *2,3 %* steigen.
][
*Prüfen:* Die Geschwindigkeit steigt nur um etwa 1,15 %, weil sie von der Wurzel der Kraft abhängt.
#src[Ü 10.4, PDF-S. 2; R, PDF-S. 2–3.]
]

#aufgabe(titel: "Gitarrensaite zu hoch gestimmt (Variante)", art: "rechnen", quelle: "6.3", herkunft: "variante", vorlage: "Übung 10, Aufg. 4", minuten: 10,
  ergebnis: [Zugkraft um etwa 2,4 % senken; $c_"nach"\/c_"vor" approx "0,988"$],
)[
#if not web [*Aufgabe 65* #linebreak()]
*Gegeben und Annahmen*

Eine Gitarrensaite soll auf 330 Hz gestimmt werden. Mit einer 330-Hz-Stimmgabel hörst du eine Schwebung mit der Schwebungsdauer 0,25 s. Die Saite ist zu stark gespannt, ihre Frequenz liegt also über 330 Hz. Sie schwingt in der Grundmode; Länge und Masse je Länge bleiben gleich.

*Gesucht*

#enum(numbering: "a)",
[Um wie viel Prozent musst du die Zugkraft verändern (erhöhen oder senken)?],
[Wie ändert sich die Ausbreitungsgeschwindigkeit auf der Saite?],
)
][
*Frequenz vorher:* $f_s=1\/"0,25" thin "s"=4 thin "Hz"$; die Saite liegt darüber: $f_"vor"=334 thin "Hz"$.
][
*Geschwindigkeit:* $c prop f$: $c_"nach"\/c_"vor"=330\/334 approx "0,988"$, also etwa 1,2 % langsamer.
][
*Zugkraft:* $F prop c^2$: $F_"nach"\/F_"vor"=(330\/334)^2 approx "0,976"$. Die Zugkraft muss um etwa *2,4 %* *gesenkt* werden.
][
*Prüfen:* Richtung stimmt: Zu hoher Ton verlangt weniger Spannung. Die relative Kraftänderung ist ungefähr doppelt so groß wie die relative Frequenzänderung.
#src[Eigene Variante nach Ü 10.4.]
]

#aufgabe(titel: "Abendsegler: Wellenlänge bei 30 °C", art: "rechnen", quelle: "6.3", herkunft: "original", vorlage: "Aufgabensammlung 1.3, Teil 1", minuten: 6,
  ergebnis: [$lambda_(30) approx "1,733" thin "cm"$],
)[
#if not web [*Aufgabe 66* #linebreak()]
*Doppler-Fledermäuse, Teil 1*

*Gegeben und Annahmen*

Fledermäuse stoßen kurze Ultraschallrufe aus, die sich mit Schallgeschwindigkeit ausbreiten. Ein Großer Abendsegler ruft mit der konstanten Frequenz $f_A=20 thin "kHz"$. Bei 10 °C Außentemperatur haben die Rufe eine Wellenlänge von 1,675 cm. Luft als ideales Gas mit konstanter Zusammensetzung.

*Gesucht*

#enum(numbering: "a)",
[Wie groß wäre die Wellenlänge bei 30 °C?],
)
][
*Modell:* $c=sqrt(kappa R T\/m_"mol")$; bei gleichem Gas gilt $c_2\/c_1=sqrt(T_2\/T_1)$ mit $T$ in Kelvin. Die Frequenz bleibt, die Fledermaus ruft weiter mit 20 kHz.
][
*Geschwindigkeit bei 10 °C:* $c_1=lambda_1 f="0,01675" dot 20000 thin "m/s"=335 thin "m/s"$.
][
*Temperatur umrechnen:* $T_1="283,15" thin "K"$, $T_2="303,15" thin "K"$; $c_2=335 dot sqrt("303,15"\/"283,15") thin "m/s" approx "346,63" thin "m/s"$.
][
*Wellenlänge:* $lambda_2=c_2\/f approx "0,017331" thin "m" approx "1,733" thin "cm"$.
][
*Prüfen:* Wärmer heißt schneller, bei gleichem Takt also längere Welle. Mit Celsius statt Kelvin käme Unsinn heraus ($sqrt(30\/10)$).
#src[AS 1.3, Teil 1, PDF-S. 12; Lösung 4.3, PDF-S. 48.]
]

#aufgabe(titel: "Ultraschall bei Frost (Variante)", art: "rechnen", quelle: "6.3", herkunft: "variante", vorlage: "Aufgabensammlung 1.3, Teil 1", minuten: 6,
  ergebnis: [$lambda_(20) approx "8,58" thin "mm"$, $c_(-10) approx 325 thin "m/s"$, $lambda_(-10) approx "8,12" thin "mm"$],
)[
#if not web [*Aufgabe 67* #linebreak()]
*Gegeben und Annahmen*

Ein Ultraschall-Abstandssensor sendet 40 kHz. Bei 20 °C beträgt die Schallgeschwindigkeit in Luft 343 m/s. Luft als ideales Gas gleicher Zusammensetzung.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist die Wellenlänge bei 20 °C?],
[Wie groß sind Schallgeschwindigkeit und Wellenlänge bei −10 °C?],
)
][
*a) Wellenlänge:* $lambda=343\/40000 thin "m" approx "8,58" thin "mm"$.
][
*b) Kelvin:* $T_1="293,15" thin "K"$, $T_2="263,15" thin "K"$. $c_2=343 dot sqrt("263,15"\/"293,15") thin "m/s" approx "325,0" thin "m/s"$.
][
*Wellenlänge bei Frost:* $lambda_2=325\/40000 thin "m" approx "8,12" thin "mm"$.
][
*Prüfen:* Kälter heißt langsamer und kürzer; die Änderung beträgt nur gut 5 %, weil die Wurzel aus dem Kelvin-Verhältnis eingeht.
#src[Eigene Variante nach AS 1.3, Teil 1.]
]

#aufgabe(titel: "Intensität und Leistung", art: "verstehen", quelle: "6.4", herkunft: "eigen")[
#if not web [*Aufgabe 68* #linebreak()]
Was ist die Intensität einer Welle, und wie unterscheidet sie sich von der Leistung? Wie hängt sie von Amplitude und Frequenz ab, und was passiert bei doppelter Amplitude?
][
*Begriff:* Intensität ist Leistung pro senkrechter Fläche, $I=P\/F$ in W/m². Eine größere Empfangsfläche fängt mehr Leistung ein, die Intensität selbst bleibt dabei gleich.
][
*Abhängigkeit:* $I=1/2 rho c omega^2 u^2$: quadratisch in Amplitude und Frequenz. Doppelte Amplitude ergibt Faktor $2^2=4$. Merksatz: Doppelte Amplitude bedeutet vierfache Intensität.
][
*Typische Verwechslungen:* „Verdoppelt sich“ übersieht das Quadrat. „Bleibt gleich wegen Energieerhaltung“: Größere Amplitude heißt mehr transportierte Energie pro Zeit und Fläche. Die Wurzel gehört zu $c$, nicht zu $I$.
#src[Eigene Verständnisfrage aus VB, PDF-S. 13–14; Quizfrage und Karteikarten zu 6.4.]
]

#aufgabe(titel: "Dreifache Amplitude, neunfache Intensität", art: "rechnen", quelle: "6.4", herkunft: "eigen",
  ergebnis: [$I_2 = 18 thin "W/m²"$, $P = "0,9" thin "W"$],
  tipp: [Wie hängt die Intensität von der Amplitude ab?],
)[
#if not web [*Aufgabe 69* #linebreak()]
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

#aufgabe(titel: "Bedingung für Auslöschung", art: "verstehen", quelle: "6.5", herkunft: "original", vorlage: "Altklausur WS 15/16, Frage 12", minuten: 2,
  ergebnis: [$Delta x=(2k+1) lambda\/2$ mit $k=0,1,2,dots$],
)[
#if not web [*Aufgabe 70* #linebreak()]
*Kurzfrage (1 Punkt)*

Gegeben sind zwei Punkte, von denen Elementarwellen gleicher Wellenlänge $lambda$ ausgehen. Wie muss der Gangunterschied $Delta x$ der Wellen an Stellen sein, an denen destruktive Interferenz, d. h. Auslöschung, stattfindet? Begründe deine Antwort (in der Klausur standen vier Formeln zur Auswahl: $k lambda\/2$, $(2k+1)lambda\/2$, $k lambda$, $(2k+1)lambda$).
][
*Phase aus Weg:* Bei gleichphasigen Quellen gilt $Delta phi=2pi Delta x\/lambda$. Auslöschung braucht Berg auf Tal, also $Delta phi=pi, 3pi, 5pi, dots$
][
*Bedingung:* Daraus $Delta x=(2k+1) lambda\/2$ mit $k=0,1,2,dots$, also ungerade Vielfache der halben Wellenlänge. Ganze Wellenlängen ($k lambda$) liefern dagegen Maxima. Vollständige Auslöschung braucht zusätzlich gleiche Amplituden am Ort. Merksatz: Ganze Wellenlängen verstärken; ungerade halbe löschen bei gleichen Amplituden aus.
][
*Typische Verwechslungen:* $k lambda\/2$ (die in der Vorlage angekreuzte und als falsch gewertete Antwort) enthält auch gerade Vielfache, also Maxima. $Delta x=lambda\/4$ ergibt einen Zwischenfall mit Amplitude $sqrt(2)A$; $Delta x=0$ ist gleichphasig, also ein Maximum. $(2k+1)lambda$ sind ganze Wellenlängen.
#src[Prüfung Physik 1 WS 2015/16 (Prüfung Phy_1, PDF-S. 4, Frage 12); Ü 10.5; Quizfrage und Karteikarte zu 6.5.]
]

#aufgabe(titel: "Vierfache Intensität durch Interferenz", art: "verstehen", quelle: "6.5", herkunft: "eigen")[
#if not web [*Aufgabe 71* #linebreak()]
Zwei gleich starke, gleichphasige Wellen treffen am selben Ort zusammen. Wie groß ist dort die Intensität im Vergleich zu einer einzelnen Welle? Ist das Energie aus dem Nichts?
][
*Zuerst Auslenkungen addieren:* $A+A=2A$. Die Intensität hängt quadratisch von der Amplitude ab: $(2A)^2=4A^2$, also $I_"res"=4 I_"einzeln"$.
][
*Energie:* Keine neue Energie: An anderen Orten löschen sich die Wellen aus, die Energie wird nur umverteilt. Typische Verwechslungen: „Doppelt so groß“ addiert Intensitäten statt Auslenkungen; „null“ wäre der destruktive Fall mit $Delta phi=pi$.
#src[Quizfrage zu 6.5; Karteikarte zu 6.4, Abbildung energie-quelle.]
]

#aufgabe(titel: "Wenn sich zwei Wellen treffen", art: "verstehen", quelle: "6.5", herkunft: "eigen")[
#if not web [*Aufgabe 72* #linebreak()]
Was passiert, wenn sich zwei Wellen treffen, und was danach?
][
*Superposition:* An jedem Ort addieren sich die Auslenkungen; danach laufen beide ungestört weiter. Berg auf Berg gibt doppelte Höhe (konstruktiv), Berg auf Tal löscht sich aus (destruktiv), wenn die Amplituden gleich sind.
#src[Karteikarte zu 6.5, Abbildung interferenz-quelle.]
]

#aufgabe(titel: "Knoten und Bäuche der stehenden Welle", art: "verstehen", quelle: "6.6", herkunft: "eigen")[
#if not web [*Aufgabe 73* #linebreak()]
Was sind Knoten und Bäuche? Leite aus $2A sin(k x)cos(omega t)$ die Abstände benachbarter Knoten und von Knoten zu Bauch her. Transportiert eine stehende Welle Energie?
][
*Begriffe:* Knoten ruhen immer, Bäuche schwingen mit der größten Amplitude. Merksatz: Knoten ruht, Bauch schwingt maximal.
][
*Abstände:* Knoten bei $k x=j pi$, also im Abstand $pi\/k=lambda\/2$. Bäuche liegen dazwischen: Knoten–Bauch $lambda\/4$. Typische Verwechslungen: $lambda$ steht zwar im Fließtext der Vorlesung, ist aber ein Quellenfehler; $lambda\/4$ ist der Abstand Knoten–Bauch.
][
*Energie:* Im Idealfall kein Nettotransport: Die beiden gegenläufigen Teilwellen transportieren gleich viel Energie in entgegengesetzte Richtungen. Schwingungsenergie ist trotzdem vorhanden.
#src[Eigene Verständnisfrage aus VB, PDF-S. 17–19; Quellenfehler im Text korrigiert; Quizfrage und Karteikarten zu 6.6.]
]

#aufgabe(titel: "Wie eine stehende Welle entsteht", art: "verstehen", quelle: "6.6", herkunft: "eigen")[
#if not web [*Aufgabe 74* #linebreak()]
Wie entsteht eine stehende Welle, und was bedeutet „stehend“?
][
*Entstehung:* Zwei gleich starke Wellen mit gleicher Frequenz laufen gegeneinander, typisch eine Welle und ihre Reflexion. Ihre Summe ist $u=2A sin(k x)cos(omega t)$.
][
*Deutung:* Das Ortsmuster $sin(k x)$ bleibt stehen; die Teilchen schwingen darin weiter auf und ab, mit ortsabhängiger Amplitude.
#src[Karteikarte zu 6.6, Abbildung stehend-quelle.]
]

#aufgabe(titel: "Reflexion am festen und losen Ende", art: "verstehen", quelle: "6.6.1", herkunft: "eigen")[
#if not web [*Aufgabe 75* #linebreak()]
Ein Wellenberg läuft auf ein festes Seilende zu. Wie kommt er zurück? Was ist am losen Ende anders? Begründe den Knoten am festen Ende.
][
*Festes Ende:* Der Punkt kann sich nicht bewegen, dort liegt ein Knoten. Damit die Summe von hin- und rücklaufender Welle dort jederzeit null bleibt, kommt der Berg als *Tal* zurück (invertiert).
][
*Loses Ende:* Der Punkt darf frei schwingen, dort liegt ein Bauch; der Berg kommt als Berg zurück. Merksatz: Fest wirft den Berg als Tal zurück, lose als Berg.
][
*Typische Verwechslungen:* Das feste Ende „schluckt“ die Welle im Idealmodell nicht, und die Amplitude verdoppelt sich nicht; nur das Vorzeichen dreht sich.
#src[Eigene Verständnisfrage aus VB, PDF-S. 18; Quizfrage und Karteikarte zu 6.6.1, Abbildung reflexion-quelle.]
]

#aufgabe(titel: "Grundfrequenz einer Saite mit zwei festen Enden", art: "verstehen", quelle: "6.7.1", herkunft: "eigen")[
#if not web [*Aufgabe 76* #linebreak()]
Eine Saite der Länge $L="0,5" thin "m"$ ist an beiden Enden fest, $c=200 thin "m/s"$. Wie hoch ist die Grundfrequenz, und welche Fehlerquellen gibt es?
][
*Rechnen:* Fest–fest: In die Saite passt eine halbe Wellenlänge, $L=lambda_1\/2$. Also $f_1=c\/(2L)=200\/1 thin "Hz"=200 thin "Hz"$.
][
*Typische Verwechslungen:* 100 Hz wäre $c\/(4L)$, also fest–lose. 400 Hz ($c\/L$) ist schon die zweite Mode. 50 Hz ($c\/(8L)$) passt zu keiner Randbedingung.
#src[Quizfrage zu 6.7.1.]
]

#aufgabe(titel: "Warum nur bestimmte Wellenlängen auf die Saite passen", art: "verstehen", quelle: "6.7.1", herkunft: "eigen")[
#if not web [*Aufgabe 77* #linebreak()]
Warum passen auf eine beidseitig eingespannte Saite nur bestimmte Wellenlängen?
][
*Randbedingung:* Beide Enden müssen Knoten sein. Dazwischen passen nur ganze Vielfache einer halben Wellenlänge: $L=n lambda\/2$, also $f_n=n c\/(2L)$. Damit Grundton und Obertöne $2f_1$, $3f_1$, …
#src[Karteikarte zu 6.7.1, Abbildung mode-fest-quelle.]
]

#aufgabe(titel: "Was sich beim Stimmen einer Saite ändert", art: "verstehen", quelle: "6.7.1", herkunft: "eigen")[
#if not web [*Aufgabe 78* #linebreak()]
Was ändert sich beim Stimmen einer Saite, und was bleibt gleich?
][
*Ändern:* Man ändert die Zugkraft, damit die Wellengeschwindigkeit $c$ und alle Eigenfrequenzen gleichzeitig.
][
*Bleibt:* Die erlaubten Wellenlängen $lambda_n=2L\/n$ bleiben gleich, denn die Länge bleibt gleich.
#src[Karteikarte zu 6.7.1.]
]

#aufgabe(titel: "Kranführer: Seilschwingung und Last", art: "rechnen", quelle: "6.7.1", herkunft: "original", vorlage: "Aufgabensammlung 1.4", minuten: 20, platz: 16,
  ergebnis: [$lambda_1=30 thin "m"$, $c=600 thin "m/s"$, Obertöne 40/60/80 Hz, $m_1 approx "12,9" thin "t"$, danach $approx "16,7" thin "Hz"$ und $approx "25,1" thin "Hz"$],
)[
#if not web [*Aufgabe 79* #linebreak()]
*Überqualifizierter Kranführer*

*Gegeben und Annahmen*

Ein Kran hat eine Last am $L_1=15 thin "m"$ langen Seil hängen. Durch die sehr träge Last können beide Seilenden als fest angesehen werden („Saite mit zwei festen Enden“). Es geht um stehende Wellen, nicht um ein Pendel. $g="9,81" thin "m/s²"$; das Eigengewicht des Seils wird gegenüber der Last vernachlässigt.

*Gesucht*

#enum(numbering: "a)",
[Wind regt das Seil zum Schwingen in seiner Grundmode an. Wie groß ist die Wellenlänge $lambda_1$ der Grundmode?],
[Der Kranführer hört einen Ton von $f=20 thin "Hz"$. Wie groß ist die Ausbreitungsgeschwindigkeit $c$ auf dem Seil?],
[Gleichzeitig schwingen die ersten 3 Obertöne mit. Welche Frequenzen hört er zusätzlich? Zeichne die Moden.],
[Am Armaturenbrett steht „Stahlseil, Durchmesser $d=8 thin "mm"$“, Dichte $rho_"Stahl"=7000 thin "kg/m³"$. Er ruft: „Das ist zu viel! 30 % abladen!“ Wie groß war die Masse $m_1$ der Last?],
[Welchen Grundton hört er nach dem Abladen?],
[Er hebt die Last ($m_2="0,7" m_1$) an, das Seil verkürzt sich auf $L_2=10 thin "m"$. Welchen Ton hört er jetzt?],
)
][
*Grundmode:* Fest–fest, $lambda_1=2L_1=30 thin "m"$.
][
*Geschwindigkeit:* $c=lambda_1 f=30 dot 20 thin "m/s"=600 thin "m/s"$.
][
*Obertöne:* $f_n=n c\/(2L)$ mit $n=2,3,4$: *40, 60 und 80 Hz*; Moden mit 2, 3 und 4 halben Wellen.
][
*Lastmasse:* Die Seilkraft ist die Gewichtskraft, $F=m_1 g$, und $c=sqrt(F\/(rho A))$. Mit $A=pi d^2\/4 approx "5,027" dot 10^(-5) thin "m²"$: $m_1=c^2 rho A\/g approx 12900 thin "kg"$ (etwa 12,9 t).
][
*Nach dem Abladen:* $c_2=c sqrt("0,7") approx 502 thin "m/s"$; bei 15 m ist $f_1=502\/30 thin "Hz" approx "16,7" thin "Hz"$.
][
*Kürzeres Seil:* $lambda_1=20 thin "m"$, $f_1=502\/20 thin "Hz" approx "25,1" thin "Hz"$.
][
*Prüfen:* Weniger Spannung senkt $c$, kürzere Länge erhöht bei gleichem $c$ die Frequenz.
#src[AS 1.4 und 4.4, PDF-S. 13 und 50–51; ASN, PDF-S. 1–2.]
]

#aufgabe(titel: "Kranseil mit neuer Last (Variante)", art: "rechnen", quelle: "6.7.1", herkunft: "variante", vorlage: "Aufgabensammlung 1.4", minuten: 18,
  ergebnis: [$c=480 thin "m/s"$, $m approx "14,4" thin "t"$, danach $approx "10,7" thin "Hz"$ und $approx "17,9" thin "Hz"$],
)[
#if not web [*Aufgabe 80* #linebreak()]
*Gegeben und Annahmen*

Eine Last hängt an einem 20 m langen Stahlseil (Durchmesser 10 mm, Dichte 7800 kg/m³). Beide Enden gelten als fest. Das Seil summt im Grundton mit 12 Hz. $g="9,81" thin "m/s²"$, Seileigengewicht vernachlässigt.

*Gesucht*

#enum(numbering: "a)",
[Bestimme die Ausbreitungsgeschwindigkeit und die Frequenzen der ersten drei Obertöne.],
[Wie groß ist die Masse der Last?],
[20 % der Last werden abgeladen. Welchen Grundton hört man jetzt? Danach wird das Seil auf 12 m eingezogen: Welcher Grundton entsteht?],
)
][
*Geschwindigkeit:* $lambda_1=2L=40 thin "m"$, $c=40 dot 12 thin "m/s"=480 thin "m/s"$. Obertöne 24, 36 und 48 Hz.
][
*Masse:* $A=pi ("0,01" thin "m")^2\/4 approx "7,854" dot 10^(-5) thin "m²"$. $m=c^2 rho A\/g=480^2 dot 7800 dot "7,854" dot 10^(-5)\/"9,81" thin "kg" approx 14400 thin "kg"$.
][
*Abladen:* $c'=480 sqrt("0,8") thin "m/s" approx "429,3" thin "m/s"$; bei 20 m: $f_1="429,3"\/40 thin "Hz" approx "10,7" thin "Hz"$.
][
*Kürzer:* $lambda_1=24 thin "m"$, $f_1="429,3"\/24 thin "Hz" approx "17,9" thin "Hz"$.
][
*Prüfen:* $c$ hängt nur über die Wurzel von der Last ab: 20 % weniger Last senkt den Ton um gut 10 %.
#src[Eigene Variante nach AS 1.4.]
]

#aufgabe(titel: "Moden bei einem festen und einem losen Ende", art: "verstehen", quelle: "6.7.2", herkunft: "eigen")[
#if not web [*Aufgabe 81* #linebreak()]
Ein Rohr ist an einem Ende geschlossen und am anderen offen (oder eine Zunge einseitig eingespannt). Welche Moden und Frequenzen kommen vor, und warum?
][
*Randbedingung:* Zwischen Knoten und Bauch passt in der Grundmode eine Viertelwellenlänge; jede weitere Mode fügt eine halbe Wellenlänge hinzu. Es passen nur ungerade Vielfache: $L=n lambda\/4$, $f_n=n c\/(4L)$ mit $n=1,3,5,dots$, also $f_1, 3f_1, 5f_1, dots$ Merksatz: Fest–lose: Viertelwelle plus halbe Wellen.
][
*Typische Verwechslungen:* $f_1, 2f_1, 3f_1$ gilt für fest–fest und lose–lose. Zweierpotenzen haben keine Randbedingung. „Nur $f_1$“ ist falsch, es gibt höhere Moden.
#src[Quizfrage und Karteikarte zu 6.7.2, Abbildung mode-gemischt-quelle.]
]

#aufgabe(titel: "Die zweite Mode bei fest–lose", art: "verstehen", quelle: "6.7.2", herkunft: "eigen")[
#if not web [*Aufgabe 82* #linebreak()]
Bei einem festen und einem losen Ende fragt eine Aufgabe nach der „zweiten Mode“. Welches $n$ setzt du in $f_n=n c\/(4L)$ ein?
][
*Zählweise:* Erlaubt sind nur $n=1,3,5,dots$ Die zweite tatsächlich vorhandene Mode hat also $n=3$.
][
*Typische Verwechslungen:* $n=2$ (und jedes gerade $n$) ist bei fest–lose gar nicht möglich; $n=1$ ist die Grundmode.
#src[Quizfrage zu 6.7.2.]
]

#aufgabe(titel: "Klapperkiste: Resonanzdrehzahlen", art: "rechnen", quelle: "6.7.2", herkunft: "original", vorlage: "Übung 10, Aufg. 3 = Aufgabensammlung 1.1 (Klausur SS 19)", minuten: 18, platz: 16,
  ergebnis: [$c=24 thin "m/s"$; 2700, 4500, 6300 U/min; nach der Reparatur 1800, 3600, 5400 U/min],
)[
#if not web [*Aufgabe 83* #linebreak()]
*Klapperkiste*

*Gegeben und Annahmen*

An einem Auto klappert das Hitzeschild gegen den Katalysator. Es ist ein Blech der Länge $L=40 thin "cm"$, das nur noch an *einem* Ende festgeschraubt ist (die andere Halteschraube ist durchgerostet, dieses Ende ist frei). Auf dem Blech entstehen stehende Wellen. Je Motorumdrehung wird das Blech einmal angestoßen. Die Ausbreitungsgeschwindigkeit $c$ der Biegewellen ändert sich durch eine zweite Schraube nicht.

*Gesucht*

#enum(numbering: "a)",
[Zeichne die ersten 3 Schwingungsmoden des Blechs. Das Klappern tritt zum ersten Mal bei 900 U/min auf. Wie groß ist $c$?],
[Wo treten im Drehzahlbereich bis 6500 U/min nochmal starke Klappergeräusche auf?],
[Die Werkstatt ersetzt die fehlende Schraube (beide Enden fest). Das Klappern tritt nur bei etwas höheren Drehzahlen auf. Bei welcher Drehzahl zum ersten Mal?],
[Zeichne wieder die ersten 3 Moden. Wo treten bis 6500 U/min jetzt starke Klappergeräusche auf?],
)
][
*Modell wählen:* Ein festes und ein loses Ende: Knoten an der Schraube, Bauch am freien Ende. Erste drei Moden $n=1,3,5$ mit $L=n lambda\/4$ (Skizze: Viertelwelle, Dreiviertelwelle, Fünfviertelwelle).
][
*Ausbreitungsgeschwindigkeit:* $lambda_1=4L="1,6" thin "m"$, $f_1=900\/60 thin "Hz"=15 thin "Hz"$, also $c=lambda_1 f_1=24 thin "m/s"$.
][
*Weitere Resonanzen:* $f_n=n c\/(4L)$ mit ungeradem $n$: 45, 75, 105 Hz, also *2700, 4500 und 6300 U/min*; $n=9$ (8100 U/min) liegt außerhalb.
][
*Nach der Reparatur:* Zwei feste Enden, $L=n lambda\/2$ mit $n=1,2,3$ (Skizze: halbe, ganze, anderthalb Wellen). $lambda_1=2L="0,8" thin "m"$, $f_1=24\/"0,8" thin "Hz"=30 thin "Hz"$: erstes Klappern bei *1800 U/min*.
][
*Weitere Resonanzen:* 60 und 90 Hz, also *3600 und 5400 U/min*; 7200 U/min liegt außerhalb.
][
*Prüfen:* Die Grundwellenlänge halbiert sich, bei gleichem $c$ verdoppelt sich die Grundfrequenz. Der Ersatzwert 25 m/s aus der Aufgabensammlung wird nicht gebraucht.
#src[Ü 10.3, PDF-S. 1–2; R, PDF-S. 1–2; AS 1.1 und 4.1, PDF-S. 9–10 und 43–45.]
]

#aufgabe(titel: "Auspuffblech: Resonanzdrehzahlen (Variante)", art: "rechnen", quelle: "6.7.2", herkunft: "variante", vorlage: "Übung 10, Aufg. 3 = Aufgabensammlung 1.1 (Klausur SS 19)", minuten: 15,
  ergebnis: [$c=24 thin "m/s"$; 3600 und 6000 U/min; nach der Reparatur 2400 und 4800 U/min],
)[
#if not web [*Aufgabe 84* #linebreak()]
*Gegeben und Annahmen*

Ein 30 cm langes Abdeckblech am Auspuff ist nur noch an einem Ende festgeschraubt, das andere Ende ist frei. Je Motorumdrehung wird es einmal angestoßen. Das erste Klappern tritt bei 1200 U/min auf. Die Ausbreitungsgeschwindigkeit der Biegewellen ändert sich durch eine zusätzliche Schraube nicht.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $c$ und alle weiteren Klapperdrehzahlen bis 7000 U/min.],
[Das freie Ende wird wieder festgeschraubt. Bei welchen Drehzahlen bis 7000 U/min klappert es jetzt?],
)
][
*Modell:* Fest–lose: $L=n lambda\/4$, $n=1,3,5,dots$
][
*Geschwindigkeit:* $lambda_1=4 dot "0,3" thin "m"="1,2" thin "m"$, $f_1=1200\/60 thin "Hz"=20 thin "Hz"$, $c=24 thin "m/s"$.
][
*Weitere Resonanzen:* $3f_1=60 thin "Hz"$ (3600 U/min), $5f_1=100 thin "Hz"$ (6000 U/min); $7f_1$ entspricht 8400 U/min und liegt außerhalb.
][
*Fest–fest:* $lambda_1=2L="0,6" thin "m"$, $f_1=24\/"0,6" thin "Hz"=40 thin "Hz"$: 2400 U/min, dann 4800 U/min; 7200 U/min liegt knapp außerhalb.
][
*Prüfen:* Fest–lose hat nur ungerade Vielfache, fest–fest alle Vielfachen der jeweils doppelt so hohen Grundfrequenz.
#src[Eigene Variante nach Ü 10.3 / AS 1.1.]
]

#aufgabe(titel: "Lüftungsblech mit gebrochener Schraube (Variante)", art: "rechnen", quelle: "6.7.2", herkunft: "variante", vorlage: "Übung 10, Aufg. 3 = Aufgabensammlung 1.1 (Klausur SS 19)", minuten: 15,
  ergebnis: [$c=25 thin "m/s"$; danach 750, 2250, 3750, 5250 U/min],
)[
#if not web [*Aufgabe 85* #linebreak()]
*Gegeben und Annahmen*

Ein 50 cm langes Blech in einer Lüftungsanlage ist an beiden Enden festgeschraubt. Der Antriebsmotor stößt es einmal je Umdrehung an. Das erste Klappern tritt bei 1500 U/min auf, das nächste bei 3000 U/min. Dann bricht eine Schraube, das Ende ist frei; $c$ bleibt gleich.

*Gesucht*

#enum(numbering: "a)",
[Bestimme die Ausbreitungsgeschwindigkeit $c$ und prüfe, ob die zweite Resonanz zum Modell passt.],
[Bei welchen Drehzahlen bis 6000 U/min klappert es nach dem Schraubenbruch?],
)
][
*Modell vorher:* Fest–fest, $lambda_1=2L=1 thin "m"$, $f_1=1500\/60 thin "Hz"=25 thin "Hz"$, also $c=25 thin "m/s"$.
][
*Zweite Resonanz prüfen:* $f_2=2f_1=50 thin "Hz"$ entspricht 3000 U/min, passt.
][
*Nach dem Bruch:* Fest–lose, $lambda_1=4L=2 thin "m"$, $f_1=25\/2 thin "Hz"="12,5" thin "Hz"$ (750 U/min). Ungerade Vielfache: 37,5 Hz, 62,5 Hz, 87,5 Hz, also *750, 2250, 3750 und 5250 U/min*; 6750 U/min liegt außerhalb.
][
*Prüfen:* Mit losem Ende passt die doppelte Grundwellenlänge, die Grundfrequenz halbiert sich; deshalb beginnt das Klappern jetzt schon bei niedriger Drehzahl.
#src[Eigene Variante nach Ü 10.3 / AS 1.1, umgekehrte Reparatur.]
]

#aufgabe(titel: "Kalimba: Zungenlänge und Obertöne", art: "rechnen", quelle: "6.7.2", herkunft: "original", vorlage: "Aufgabensammlung 1.2", minuten: 15,
  ergebnis: [$lambda_0="0,4" thin "m"$, $c=176 thin "m/s"$, Obertöne 1320 Hz und 2200 Hz, $l_1 approx "8,9" thin "cm"$],
)[
#if not web [*Aufgabe 86* #linebreak()]
*Kalimba*

*Gegeben und Annahmen*

Eine Kalimba (Lamellophon) ist ein afrikanisches Musikinstrument, bei dem verschieden lange Zungen mit den Fingern angezupft werden. Jede Zunge ist an einem Ende eingespannt, das andere Ende ist frei. Auf den Zungen bilden sich stehende Transversalwellen aus; alle Zungen bestehen aus demselben Material.

*Gesucht*

#enum(numbering: "a)",
[Zeichne die ersten 3 Schwingungsmoden der einseitig eingespannten Zunge.],
[Eine Zunge schwingt in der Grundmode mit $f_0=440 thin "Hz"$ und hat die Länge $l_0=10 thin "cm"$. Welche Wellenlänge $lambda_0$ besitzt die Grundmode?],
[Wie hoch ist die Ausbreitungsgeschwindigkeit für Transversalwellen auf den Zungen? Wie könntest du sie ändern?],
[Die höheren Moden schwingen beim Zupfen leicht mit und sind als Obertöne hörbar. Welche Frequenzen haben die ersten 2 Obertöne?],
[Die nächstkürzere Zunge soll mit $f_1=495 thin "Hz"$ (Ton h) in der Grundmode schwingen. Welche Länge muss sie haben?],
)
][
*Modell:* Fest–lose: Knoten an der Einspannung, Bauch am freien Ende; Moden $n=1,3,5$ (Viertelwelle, Dreiviertelwelle, Fünfviertelwelle).
][
*Grundwellenlänge:* $lambda_0=4 l_0="0,4" thin "m"$.
][
*Geschwindigkeit:* $c=lambda_0 f_0="0,4" dot 440 thin "m/s"=176 thin "m/s"$. Ändern lässt sie sich über das Material: steiferes Material erhöht, dichteres senkt $c$. (Die Musterlösung nennt auch Verkürzen; das ändert im verwendeten Modell aber die Eigenfrequenz, nicht $c$.)
][
*Obertöne:* $f_n=n c\/(4l_0)$ mit $n=3,5$: *1320 Hz und 2200 Hz*.
][
*Neue Zunge:* Gleiches Material, gleiches $c$: $l_1=c\/(4 f_1)=176\/(4 dot 495) thin "m" approx "0,0889" thin "m" approx "8,9" thin "cm"$.
][
*Prüfen:* Höherer Ton verlangt kürzere Zunge; etwa 1 cm kürzer, wie in der Musterlösung.
#src[AS 1.2 und 4.2, PDF-S. 11 und 46–47; eigene Präzisierung zur Änderung von $c$.]
]

#aufgabe(titel: "Spieluhr-Zunge (Variante)", art: "rechnen", quelle: "6.7.2", herkunft: "variante", vorlage: "Aufgabensammlung 1.2", minuten: 12,
  ergebnis: [$lambda_1="0,32" thin "m"$, $c approx 167 thin "m/s"$, Obertöne 1569 Hz und 2615 Hz, $L approx "7,1" thin "cm"$],
)[
#if not web [*Aufgabe 87* #linebreak()]
*Gegeben und Annahmen*

Der Stahlkamm einer großen Spieluhr hat einseitig eingespannte Zungen (anderes Ende frei) aus gleichem Material. Eine Zunge ist 8 cm lang und klingt im Grundton mit 523 Hz.

*Gesucht*

#enum(numbering: "a)",
[Bestimme die Wellenlänge der Grundmode und die Ausbreitungsgeschwindigkeit.],
[Welche Frequenzen haben die ersten zwei Obertöne?],
[Wie lang muss eine Zunge für den Grundton 587 Hz sein?],
)
][
*Modell:* Fest–lose, $L=n lambda\/4$, $n=1,3,5$.
][
*Grundmode:* $lambda_1=4 dot "0,08" thin "m"="0,32" thin "m"$, $c="0,32" dot 523 thin "m/s" approx "167,4" thin "m/s"$.
][
*Obertöne:* $3 dot 523=1569 thin "Hz"$ und $5 dot 523=2615 thin "Hz"$ (nicht $2f_1$: gerade Vielfache gibt es bei fest–lose nicht).
][
*Neue Länge:* $L=c\/(4f)="167,36"\/(4 dot 587) thin "m" approx "0,0713" thin "m" approx "7,1" thin "cm"$.
][
*Prüfen:* $L f$ ist konstant: $8 dot 523 approx "7,13" dot 587$.
#src[Eigene Variante nach AS 1.2.]
]

#aufgabe(titel: "Akusto-optische Anordnung", art: "rechnen", quelle: "6.7.2", herkunft: "original", vorlage: "Aufgabensammlung 1.6", minuten: 20, platz: 16,
  ergebnis: [$d approx 75 thin "µm"$, $lambda_S=150 thin "µm"$, $c=750 thin "m/s"$, $n=267$, 133 innere Knoten; nächste Mode 5,0375 MHz, $lambda approx "148,9" thin "µm"$; $alpha_1$ wird größer],
)[
#if not web [*Aufgabe 88* #linebreak()]
*Akusto-optisches Spektrometer*

*Gegeben und Annahmen*

Ein Ultraschall-Lautsprecher mit $f="5,00" thin "MHz"$ und ein Reflektor im Abstand $L="10,0125" thin "mm"$ erzeugen in einem Medium eine stehende Ultraschallwelle mit einem Knoten am einen und einem Bauch am anderen Ende, Wellenlänge $lambda_S$ („Saite mit einem festen und einem losen Ende“). Sie ändert periodisch den optischen Brechungsindex, sodass das Medium wie ein optisches Gitter mit Gitterkonstante $d=lambda_S\/2$ wirkt. Ein Laserstrahl ($lambda_L=630 thin "nm"$) fällt senkrecht durch das Medium auf einen Schirm in $x_S=1 thin "m"$ Entfernung. Hinweis: Die Maxima eines Gitters liegen unter denselben Winkeln wie beim Doppelspalt, $sin(alpha_j)=j lambda\/d$ (Fernfeld).

*Gesucht*

#enum(numbering: "a)",
[Der Abstand zwischen 0. und 1. Beugungsordnung auf dem Schirm beträgt $y_1="8,4" thin "mm"$. Wie groß sind $d$ und $lambda_S$? (Ersatzwert $d=75 thin "µm"$)],
[Wie groß ist die Schallgeschwindigkeit im Medium?],
[Wie viele Wellenknoten hat die stehende Welle, welche Modennummer $n$? (Ersatzwert $n=267$)],
[Die Frequenz wird erhöht. Bei welcher Frequenz liegt die nächste Mode, welche Wellenlänge hat sie?],
[Was ändert sich dadurch am Schirm: Wird $alpha_1$ größer oder kleiner?],
)
][
*a) Winkel und Gitterkonstante:* $tan(alpha_1)=y_1\/x_S="0,0084"$, $alpha_1 approx "0,481"°$. Mit $sin(alpha_1)=lambda_L\/d$: $d=630 dot 10^(-9) thin "m"\/sin(alpha_1) approx 75 thin "µm"$, also $lambda_S=2d=150 thin "µm"$.
][
*b) Schallgeschwindigkeit:* $c=lambda_S f=150 dot 10^(-6) dot 5 dot 10^6 thin "m/s"=750 thin "m/s"$.
][
*c) Modennummer:* Fest–lose, $L=n lambda_S\/4$: $n=4 dot "10,0125"\/"0,150"=267$ (ungerade, passt). Knoten liegen im Abstand $lambda_S\/2$ ab dem Knotenende: $L\/(lambda_S\/2)="133,5"$, also 133 Knoten im Medium nach der Zählung der Musterlösung; zählt man den Randknoten am festen Ende mit, sind es 134.
][
*d) Nächste Mode:* Nur ungerade $n$, also $n=269$: $f=269 c\/(4L)=269 dot 750\/(4 dot "0,0100125") thin "Hz" approx "5,0375" thin "MHz"$, $lambda_S=4L\/269 approx "148,9" thin "µm"$.
][
*e) Schirmbild:* $lambda_S$ wird kleiner, damit auch $d$; wegen $sin(alpha_1)=lambda_L\/d$ wird $alpha_1$ *größer*, die 1. Ordnung wandert nach außen.
][
*Prüfen:* $n$ springt um 2, weil gerade $n$ an beiden Enden Knoten verlangen würden. Die Gitterformel ist hier nur als Maxima-Bedingung wie beim Doppelspalt (Abschnitt 6.8.3) benutzt; Gitter selbst folgen erst in der Optik.
#src[AS 1.6 und 4.6, PDF-S. 15 und 54–55; eigene Rechnung.]
]

#aufgabe(titel: "Ultraschall in Wasser als Gitter (Variante)", art: "rechnen", quelle: "6.7.2", herkunft: "variante", vorlage: "Aufgabensammlung 1.6", minuten: 18,
  ergebnis: [$d approx 250 thin "µm"$, $c approx 1500 thin "m/s"$, $n=81$, 40 Knoten (41 mit Randknoten), nächste Mode $approx "3,074" thin "MHz"$, $lambda approx 488 thin "µm"$],
)[
#if not web [*Aufgabe 89* #linebreak()]
*Gegeben und Annahmen*

In einem Wasserbecken erzeugen ein Ultraschallgeber mit $f=3 thin "MHz"$ und ein Reflektor im Abstand $L="10,125" thin "mm"$ eine stehende Welle mit Knoten an einem und Bauch am anderen Ende. Das Wasser wirkt wie ein Gitter mit $d=lambda_S\/2$. Ein Laser mit $lambda_L=633 thin "nm"$ erzeugt auf einem Schirm in 2 m Entfernung die 1. Ordnung im Abstand $y_1="5,064" thin "mm"$ von der 0. Ordnung. Maxima wie beim Doppelspalt: $sin(alpha_1)=lambda_L\/d$.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $d$, $lambda_S$ und die Schallgeschwindigkeit im Wasser.],
[Bestimme die Modennummer $n$ und die Zahl der Knoten.],
[Bei welcher Frequenz liegt die nächsthöhere Mode, und welche Wellenlänge hat sie?],
)
][
*Gitterkonstante:* $tan(alpha_1)="5,064"\/2000 approx "0,002532"$; $d=633 dot 10^(-9)\/sin(alpha_1) thin "m" approx 250 thin "µm"$, $lambda_S=500 thin "µm"$.
][
*Schallgeschwindigkeit:* $c=500 dot 10^(-6) dot 3 dot 10^6 thin "m/s"=1500 thin "m/s"$, ein typischer Wert für Wasser.
][
*Mode:* $n=4L\/lambda_S=4 dot "10,125"\/"0,5"=81$ (ungerade). $L\/(lambda_S\/2)="40,5"$: 40 Knoten im Medium, 41 mit dem Randknoten am festen Ende.
][
*Nächste Mode:* $n=83$: $f=83 dot 1500\/(4 dot "0,010125") thin "Hz" approx "3,074" thin "MHz"$, $lambda_S=4L\/83 approx 488 thin "µm"$.
][
*Prüfen:* Frequenz steigt im Verhältnis $83\/81$; die Wellenlänge sinkt im Kehrwert-Verhältnis, $c$ bleibt gleich.
#src[Eigene Variante nach AS 1.6.]
]

#aufgabe(titel: "Eigenmoden der drei Randfälle", art: "verstehen", quelle: "6.7.3", herkunft: "eigen")[
#if not web [*Aufgabe 90* #linebreak()]
Skizziere je drei Moden für fest–fest, fest–lose und lose–lose. Begründe die erlaubten Ordnungen und unterscheide Mode und Oberton.
][
Fest–fest: $sin(n pi x/L)$ mit $n=1,2,3$. Lose–lose: $cos(n pi x/L)$ mit $n=1,2,3$. Fest–lose: $sin(n pi x/(2L))$ mit $n=1,3,5$. Die Enden liefern Knoten oder Bäuche. Die Grundmode ist die niedrigste schwingende Mode; Obertöne sind die darüberliegenden. Siehe die Modenskizze in Abschnitt 6.7.3.

#src[Eigene Frage aus VB, PDF-S. 20–22; Ü 10.3; AS 1.1–1.2.]
]

#aufgabe(titel: "Moden bei zwei losen Enden", art: "verstehen", quelle: "6.7.3", herkunft: "eigen")[
#if not web [*Aufgabe 91* #linebreak()]
Welche Moden passen bei zwei losen Enden? Was ist anders als bei zwei festen Enden?
][
*Wellenlängen:* An beiden losen Enden liegt ein Bauch. Erlaubt sind wie bei fest–fest $L=n lambda\/2$ mit $n=1,2,3,dots$
][
*Unterschied:* Das Ortsbild ist anders: Knoten liegen innen, Bäuche an den Rändern ($cos(n pi x\/L)$ statt $sin$).
#src[Karteikarte zu 6.7.3.]
]

#aufgabe(titel: "Knotenlinien auf dem Trommelfell", art: "verstehen", quelle: "6.7.4", herkunft: "eigen",
  tipp: [Übertrage den Begriff des ruhenden Knotens von einer Strecke auf eine Fläche.],
  ergebnis: [Knotenlinien bleiben immer unausgelenkt; der Sand macht das Muster sichtbar.],
)[
#if not web [*Aufgabe 92* #linebreak()]
Was sind Knotenlinien einer zweidimensionalen Eigenmode? Warum sammelt sich feiner Sand bei einer schwingenden Platte auf bestimmten Linien? Was unterscheidet diese Linien von einer Linie, die nur in einer Momentaufnahme gerade Auslenkung null hat?
#src[V26, PDF-S. 1–2, Abb. 6.10–6.11.]
][
*Begriff klären:* Eine Knotenlinie besteht aus Punkten, die während der ganzen Schwingung ruhen. Zwischen den Linien bewegen sich die Flächenbereiche. Form und Randbedingungen der Fläche bestimmen die möglichen Eigenmoden.
][
*Experiment erklären:* Von schwingenden Bereichen wird Sand fortbewegt; an den ruhenden Linien sammelt er sich bevorzugt. Das Muster zeigt die Eigenmode, weder eine Wellenfront einer laufenden Welle noch die Bahn eines einzelnen Sandkorns.
][
*Abgrenzen:* Beim gemeinsamen Nulldurchgang einer stehenden Mode können auch schwingende Bereiche kurz unausgelenkt sein. Ein einzelnes Foto bei Auslenkung null beweist deshalb noch keine Knotenlinie. Auf der Knotenlinie ist die Amplitude null, nicht maximal. Merksatz: Ein Knoten bleibt ruhig, nicht nur für einen Augenblick.
#src[Quizfragen und Karteikarten zu 6.7.4, Abbildung membran-knoten-quelle.]
]

#aufgabe(titel: "Kugelwelle: Intensität und Amplitude im Abstand", art: "verstehen", quelle: "6.8.1", herkunft: "eigen")[
#if not web [*Aufgabe 93* #linebreak()]
Eine verlustfreie Kugelwelle wird im doppelten Abstand gemessen. Warum sinkt die Intensität auch ohne Absorption, wie ändern sich Intensität und Amplitude, und wurde Leistung vernichtet?
][
*Fläche:* Dieselbe Leistung verteilt sich auf Kugelflächen $4pi r^2$: $I=P\/(4pi r^2)$, $I prop 1\/r^2$. Doppelter Abstand ergibt ein Viertel der Intensität. Merksatz: Gleiche Leistung auf größerer Kugelfläche wird dünner verteilt.
][
*Amplitude:* Bei festem Medium und Takt gilt $I prop u^2$, also $u prop 1\/r$: Die Amplitude halbiert sich. Merksatz: Doppelte Entfernung: halbe Amplitude, viertel Intensität.
][
*Leistung:* Die gesamte Leistung durch die größere Kugelfläche bleibt gleich. „Drei Viertel wurden vernichtet“ ist falsch; nur die Leistung je Fläche sinkt.
#src[Quizfrage und Karteikarten zu 6.8.1, Abbildung map-raumwellen.]
]

#aufgabe(titel: "Zylinderwelle nimmt langsamer ab", art: "verstehen", quelle: "6.8.1", herkunft: "eigen")[
#if not web [*Aufgabe 94* #linebreak()]
Bei welcher idealisierten Quelle fällt die Intensität ohne Absorption wie $1\/r$ statt wie $1\/r^2$, und warum?
][
*Linienquelle:* Bei einer sehr langen Linienquelle wächst der Zylindermantel einer festen Quellenlänge nur proportional zu $r$; daher $I prop 1\/r$.
][
*Abgrenzung:* Bei der isotropen Punktquelle wächst die Kugelfläche mit $r^2$ ($I prop 1\/r^2$); bei der verlustfreien ebenen Welle wächst die Fläche nicht, $I$ bleibt konstant. Eine reale endliche Linienquelle wirkt nicht beliebig weit weg noch wie eine unendlich lange.
#src[Quizfrage und Karteikarte zu 6.8.1.]
]

#aufgabe(titel: "Ebene, Kugel- und Zylinderwellen", art: "verstehen", quelle: "6.8.1", herkunft: "eigen")[
#if not web [*Aufgabe 95* #linebreak()]
Wie unterscheiden sich ebene, Kugel- und Zylinderwellen?
][
*Fronten und Quellen:* Ihre Fronten sind parallele Ebenen, konzentrische Kugelflächen bzw. Zylindermäntel. Dazu passen eine idealisierte flächige, punktförmige bzw. lange linienförmige Quelle. Die Geometrie entscheidet, wie sich die Leistung beim Ausbreiten auf Flächen verteilt.
#src[Karteikarte zu 6.8.1, Abbildung map-raumwellen.]
]

#aufgabe(titel: "Kugelwelle bei doppeltem Abstand", art: "rechnen", quelle: "6.8.1", herkunft: "eigen",
  ergebnis: [$I_2/I_1=1/4$, $u_2/u_1=1/2$; gesamte Leistung unverändert],
  tipp: [Vergleiche zuerst die Kugelflächen, dann die Intensitäten.],
)[
#if not web [*Aufgabe 96* #linebreak()]
*Gegeben und Annahmen*
Eine kompakte Quelle strahlt im Kugelwellenmodell gleichmäßig in alle Richtungen. Es gibt keine Absorption oder Reflexion; Frequenz und Medium sind konstant. Zwei Messorte liegen bei $r_1=r>0$ und $r_2=2r$; die insgesamt abgestrahlte Leistung ist $P$.

*Gesucht*
#enum(numbering: "a)")[Bestimme $I_2/I_1$.][Bestimme das Verhältnis der Auslenkungsamplituden $u_2/u_1$.][Geht auf dem Weg Leistung verloren?]
#src[Eigene Verhältnisaufgabe nach V26, PDF-S. 4–5 und VB, PDF-S. 13–14.]
][
*Fläche bestimmen:* Die Kugelfläche ist $A=4pi r^2$. Mit doppeltem Radius wird sie viermal so groß; dieselbe Leistung muss diese größere Fläche durchqueren.
][
*Intensität berechnen:* $I_2/I_1=(r_1/r_2)^2=(1/2)^2=1/4$. Die Einheit W/m² kürzt sich im Verhältnis heraus.
][
*Amplitude ableiten:* Bei gleichem Medium und Takt ist $I prop u^2$. Deshalb $u_2/u_1=sqrt(1/4)=1/2$.
][
*Energie prüfen:* $I_2 A_2=(I_1/4)(4A_1)=I_1 A_1=P$. Die Intensität sinkt geometrisch, nicht durch einen Leistungsverlust.
]

#aufgabe(titel: "Zylinderwelle und Kugelwelle vergleichen", art: "rechnen", quelle: "6.8.1", herkunft: "eigen",
  ergebnis: [Zylinder: $I_2/I_1=1/2$; Kugel: $I_2/I_1=1/4$],
  tipp: [Bei derselben betrachteten Quellenlänge wächst der Zylindermantel linear mit dem Radius.],
)[
#if not web [*Aufgabe 97* #linebreak()]
*Gegeben und Annahmen*
Vergleiche zwei verlustfreie Idealmodelle im selben Medium: eine sehr lange Linienquelle und eine isotrope Punktquelle. Für beide wird der Abstand von $r$ auf $2r$ vergrößert. Beim Zylindermodell wird dieselbe Quellenlänge $ell$ und deren konstante Leistung betrachtet; Endeffekte bleiben unberücksichtigt.

*Gesucht*
#enum(numbering: "a)")[Bestimme für beide Modelle $I(2r)/I(r)$.][Erkläre, warum die Abnahme verschieden ist.]
#src[Eigene Verhältnisaufgabe nach V26, PDF-S. 4–5.]
][
*Geometrie wählen:* Der Zylindermantel ist $2pi r ell$. Doppeltes $r$ verdoppelt ihn. Die Kugelfläche $4pi r^2$ vervierfacht sich dagegen.
][
*Leistung verteilen:* Aus $I=P/A$ folgt für den Zylinder $I(2r)/I(r)=1/2$, für die Kugel $1/4$. Bei beiden bleibt die jeweilige gesamte Leistung gleich.
][
*Gültigkeit prüfen:* Eine endliche Linienquelle wirkt nicht bei beliebig großem Abstand weiterhin wie eine unendlich lange Linie. Die unterschiedlichen Potenzen sind geometrische Idealmodelle, kein unterschiedlicher Energieerhaltungssatz.
]

#aufgabe(titel: "Eine neue Wellenfront konstruieren", art: "verstehen", quelle: "6.8.2", herkunft: "eigen",
  ergebnis: [Elementarwellen mit Radius $c Delta t$; die neue Front ist die gemeinsame vordere Einhüllende.],
)[
#if not web [*Aufgabe 98* #linebreak()]
Was sagt das Huygenssche Prinzip über eine Wellenfront? Erkläre die Konstruktion einer neuen Front aus einer alten Front in einem homogenen Medium. Warum ist ihr Abstand nicht automatisch eine Wellenlänge? Was ergänzt Fresnel?
#src[V26, PDF-S. 7, Abb. 6.18; eigene Anwendung von $r=c Delta t$.]
][
*Startpunkte wählen:* Jeder Punkt der alten Front dient als Ausgangspunkt einer Elementarwelle. Alle müssen für denselben Zeitraum $Delta t$ weiterentwickelt werden.
][
*Front verbinden:* Nach dieser Zeit haben sie den Radius $c Delta t$. Die gemeinsame vordere Einhüllende bildet die neue Front. Eine Wellenlänge wird nur bei $Delta t=T$ erreicht. Typische Verwechslung: Die Linie durch die Mittelpunkte ist die alte Front, nicht die neue. Merksatz: Aus vielen kleinen Wellen baut sich die nächste Front.
][
*Auslenkungen überlagern:* Fresnel ergänzt die Superposition aller Elementarwellen mit ihren Phasen. Die Einhüllende beschreibt nur die Geometrie; für Intensitäten addiert man Auslenkungen mit Phasen, nicht einfach Intensitäten.
#src[Quizfrage und Karteikarten zu 6.8.2, Abbildungen huygens-quelle und map-huygens.]
]

#aufgabe(titel: "Zeitstabiles Interferenzmuster", art: "verstehen", quelle: "6.8.2", herkunft: "eigen")[
#if not web [*Aufgabe 99* #linebreak()]
„Gleiche Frequenz bedeutet, dass die gemeinsame Auslenkung zeitlich stillsteht.“ Stimmt das? Was ist bei einem zeitstabilen Interferenzmuster eigentlich stabil?
][
*Antwort:* Nein. Bei gleicher Frequenz und *fester relativer Phase* bleiben die Orte von Verstärkung und Auslöschung bzw. die gemittelte Intensitätsverteilung ortsfest. Die momentane Auslenkung schwingt weiterhin.
][
*Typische Verwechslungen:* Gleiche Frequenz beseitigt die Schwingung nicht, garantiert aber allein auch noch keine feste relative Phase. Ein zeitstabiles Muster ist durchaus möglich.
#src[Quizfrage und Karteikarte zu 6.8.2.]
]

#aufgabe(titel: "Phase ist keine zusätzliche Weglänge", art: "verstehen", quelle: "6.8.3", herkunft: "eigen",
  tipp: [Vergleiche die Einheiten von Metern und Radiant.],
  ergebnis: [$Delta phi=2pi Delta s/lambda+Delta phi_0$; äquivalente Wegverschiebung $lambda Delta phi_0/(2pi)$],
)[
#if not web [*Aufgabe 100* #linebreak()]
In Gl. 6.19 werden eine Phasenverschiebung und zwei Weglängen direkt addiert. Wie kombiniert man eine Anfangsphasendifferenz $Delta phi_0$ korrekt mit einer Wegdifferenz $Delta s$? Ist die Anfangsphase bei gleicher Frequenz unwichtig?
#src[V26, PDF-S. 6–8, insbesondere Gl. 6.19; eigene Dimensionsprüfung.]
][
*Einheiten vergleichen:* Weglängen stehen in Metern, die Anfangsphase in Radiant. $Delta s+Delta phi_0$ ist ohne Umrechnung keine sinnvolle Größe.
][
*Umrechnen:* Eine Wellenlänge entspricht $2pi$ rad: $Delta phi=2pi Delta s/lambda+Delta phi_0$. Alternativ entspricht die Anfangsphase der Wegverschiebung $lambda Delta phi_0/(2pi)$.
][
*Rolle der Anfangsphase:* Gleiche Frequenz legt die relative Anfangsphase nicht fest; sie kann Maxima und Minima vertauschen (z. B. Gegentakt). Bleibt sie fest, bleibt das gemittelte Interferenzmuster ortsfest.
#src[Quizfrage und Karteikarte zu 6.8.3.]
]

#aufgabe(titel: "Doppelspalt ohne Fernfeld rechnen?", art: "verstehen", quelle: "6.8.3", herkunft: "eigen",
  ergebnis: [Im Nahfeld beide Wege exakt berechnen; $d sin(alpha)$ ist eine Fernfeldnäherung.],
)[
#if not web [*Aufgabe 101* #linebreak()]
Zwei gleichphasige Quellen liegen im Abstand $d$. Wann darfst du $Delta s approx d sin(alpha)$ benutzen? Wie gehst du sonst vor, und warum garantiert eine Gegenphase noch keine vollständige Stille?
#src[V26, PDF-S. 8–10; ÜN, PDF-S. 3 zu Ü 10.5.]
][
*Näherung prüfen:* Nur im Fernfeld: Der Beobachtungsabstand muss viel größer als $d$ sein, damit die beiden Wege nahezu parallel verlaufen. Gleiche Frequenz ist eine Interferenzvoraussetzung, aber keine Fernfeldbedingung. Bei Ü 10.5 ist 3 m gegenüber 2,6 m kein Fernfeld.
][
*Exakte Wege wählen:* Im Nahfeld berechnest du $s_1$ und $s_2$ aus der Geometrie, etwa mit Pythagoras, und vergleichst $abs(s_1-s_2)$ mit ganzen oder ungeraden halben Wellenlängen.
][
*Amplitude berücksichtigen:* Gegenphase erzeugt ein Minimum. Nur bei gleichen Amplituden am Beobachtungsort ist die Summe null; sonst bleibt eine Restamplitude. Die Doppelspalt-Minimawinkel gelten zudem nicht ungeprüft für Mehrfachspalte. Merksatz: Gegenphase reicht nur mit gleichen Amplituden zur vollständigen Auslöschung.
#src[Quizfrage und Karteikarten zu 6.8.3, Abbildung doppelspalt-quelle.]
]

#aufgabe(titel: "Interferenz zweier Lautsprecher", art: "rechnen", quelle: "6.8.3", herkunft: "original", vorlage: "Übung 10, Aufg. 5", minuten: 12,
  ergebnis: [$f approx 134 thin "Hz"$ (genau 133,6 Hz)],
)[
#if not web [*Aufgabe 102* #linebreak()]
*Interferenz*

*Gegeben und Annahmen*

Zwei Lautsprecher im Abstand $L="2,6" thin "m"$ strahlen phasengleich harmonische Wellen ab. Ein Hörer steht auf einer Linie parallel zur Verbindungslinie der Lautsprecher im Abstand $a=3 thin "m"$, zunächst im Punkt $P_0$ genau gegenüber der Mitte zwischen den Lautsprechern. Bewegt er sich entlang dieser Linie auf den Punkt $P_1$ zu, nimmt die Lautstärke ab und erreicht in $P_1$ das erste Minimum. $P_1$ liegt 1,8 m von $P_0$ entfernt. Die Schallgeschwindigkeit beträgt 340 m/s.

*Gesucht*

#enum(numbering: "a)",
[Welche Frequenz $f$ haben die Wellen?],
)
][
*Modell:* Gleichphasige Quellen gleicher Frequenz; das erste Minimum gehört zum Gangunterschied $lambda\/2$. Die Wege werden exakt mit Pythagoras bestimmt (3 m ist kein Fernfeld gegenüber 2,6 m).
][
*Wege:* Quer zur Linie liegen die Lautsprecher bei $plus.minus "1,3" thin "m"$. Vom näheren: $l_1=sqrt(3^2+("1,8"-"1,3")^2) thin "m" approx "3,0414" thin "m"$, vom ferneren: $l_2=sqrt(3^2+("1,8"+"1,3")^2) thin "m" approx "4,3139" thin "m"$.
][
*Gangunterschied:* $Delta l approx "1,2726" thin "m"=lambda\/2$, also $lambda approx "2,5451" thin "m"$.
][
*Frequenz:* $f=c\/lambda=340\/"2,5451" thin "Hz" approx "133,6" thin "Hz" approx 134 thin "Hz"$.
][
*Prüfen:* Im Aufgabentext steht „Abstand zwischen $P_1$ und $P_2$“; gemeint ist laut Skizze und Lösung der Abstand $P_0 P_1$. Die handschriftliche Lösung kommt durch frühes Runden auf 133 Hz.
#src[Ü 10.5, PDF-S. 2; R, PDF-S. 3; ÜN, PDF-S. 3; eigene geometrisch überprüfte Rechnung.]
]

#aufgabe(titel: "Interferenz zweier Lautsprecher (Variante)", art: "rechnen", quelle: "6.8.3", herkunft: "variante", vorlage: "Übung 10, Aufg. 5", minuten: 12,
  ergebnis: [$Delta l approx "0,560" thin "m"$, $lambda approx "1,120" thin "m"$, $f approx 304 thin "Hz"$],
)[
#if not web [*Aufgabe 103* #linebreak()]
*Gegeben und Annahmen*

Zwei gleichphasige Lautsprecher stehen 2,0 m auseinander. Ein Hörer geht auf einer dazu parallelen Linie im Abstand 4,0 m. Er startet in $P_0$ genau gegenüber der Mitte und hört das erste Minimum in $P_1$, 1,2 m von $P_0$ entfernt. $c=340 thin "m/s"$.

*Gesucht*

#enum(numbering: "a)",
[Bestimme die Frequenz der Lautsprecher.],
)
][
*Modell:* Erstes Minimum bei $Delta l=lambda\/2$; Wege exakt mit Pythagoras.
][
*Wege:* Lautsprecher quer bei $plus.minus 1 thin "m"$. $l_1=sqrt(4^2+"0,2"^2) thin "m" approx "4,0050" thin "m"$, $l_2=sqrt(4^2+"2,2"^2) thin "m" approx "4,5651" thin "m"$.
][
*Wellenlänge:* $Delta l approx "0,5601" thin "m"$, also $lambda approx "1,1202" thin "m"$.
][
*Frequenz:* $f=340\/"1,1202" thin "Hz" approx "303,5" thin "Hz" approx 304 thin "Hz"$.
][
*Prüfen:* Fernfeldnäherung $d sin(alpha)=2 dot "1,2"\/sqrt(16+"1,44") approx "0,575" thin "m"$ läge hier nur knapp daneben, weil 4 m schon deutlich größer als 2 m sind.
#src[Eigene Variante nach Ü 10.5.]
]

#aufgabe(titel: "Gegenphasige Lautsprecher (Variante)", art: "rechnen", quelle: "6.8.3", herkunft: "variante", vorlage: "Übung 10, Aufg. 5", minuten: 8,
  ergebnis: [In $P_0$ Minimum, in $P_1$ Maximum],
)[
#if not web [*Aufgabe 104* #linebreak()]
*Gegeben und Annahmen*

Gleiche Anordnung wie in Übung 10, Aufg. 5: Lautsprecher 2,6 m auseinander, Hörerlinie im Abstand 3 m, $P_0$ gegenüber der Mitte, $P_1$ 1,8 m daneben, $f approx "133,6" thin "Hz"$, $c=340 thin "m/s"$. Jetzt wird ein Lautsprecher umgepolt: Die Quellen schwingen *gegenphasig* ($Delta phi_0=pi$). Gleiche Amplituden am Hörerort angenommen.

*Gesucht*

#enum(numbering: "a)",
[Was hört der Hörer jetzt in $P_0$ und in $P_1$? Begründe mit der Gesamtphase.],
)
][
*Gesamtphase:* $Delta phi=2pi Delta l\/lambda+Delta phi_0$ mit $Delta phi_0=pi$.
][
*In $P_0$:* $Delta l=0$, also $Delta phi=pi$: Berg trifft Tal, *Minimum* (Auslöschung).
][
*In $P_1$:* $Delta l=lambda\/2$ (aus der Originalaufgabe), also $Delta phi=pi+pi=2pi$: gleichphasig, *Maximum*.
][
*Prüfen:* Umpolen vertauscht genau Maxima und Minima; die Lagen bleiben, nur die Rollen wechseln.
#src[Eigene Variante nach Ü 10.5 und V26, Gl. 6.19 (korrigierte Form).]
]

#aufgabe(titel: "Schiffe versenken: Auslöschung", art: "rechnen", quelle: "6.8.3", herkunft: "original", vorlage: "Aufgabensammlung 1.5", minuten: 15,
  ergebnis: [$lambda="0,5" thin "m"$; Moritz 2 Hz und 0,5 m; gleichphasig $y approx "1,6" thin "m"$, gegenphasig $y approx "2,3" thin "m"$],
)[
#if not web [*Aufgabe 105* #linebreak()]
*Schiffe versenken*

*Gegeben und Annahmen*

Max und Moritz sind am Teich. Moritz' Schiffchen schwimmt bei $x=5 thin "m"$, $y=0$. Max patscht bei $x=0$, $y=0$ mit $f=2 thin "Hz"$ ins Wasser und erzeugt Kreiswellen. Moritz will die Wellen von Max am Ort des Schiffs durch destruktive Interferenz auslöschen und patscht selbst an einer Stelle auf der $y$-Achse. Gleiche Amplituden am Schiff angenommen.

*Gesucht*

#enum(numbering: "a)",
[Die erste Kreiswelle erreicht das Schiff nach 5 s. Wie groß ist ihre Wellenlänge?],
[Welche Wellenlänge und Frequenz muss die Welle von Moritz haben?],
[An welcher Stelle auf der $y$-Achse muss Moritz stehen, wenn er mit Max im Gleichtakt patscht?],
[Wo muss er stehen, wenn er im Gegentakt patscht?],
)
Für c) und d) gibt es viele Lösungen; gesucht ist jeweils die, bei der Max und Moritz nicht am selben Ort sind, ihr Abstand aber kleinstmöglich ist.
][
*Wellenlänge:* $c=5 thin "m"\/5 thin "s"=1 thin "m/s"$, $lambda=c\/f="0,5" thin "m"$.
][
*Moritz:* Ebenfalls 2 Hz und 0,5 m, sonst wandert die Phasendifferenz und es gibt keine dauerhafte Auslöschung.
][
*Gleichtakt:* Wegunterschied ungerades Vielfaches von $lambda\/2$, kleinster: $sqrt(y^2+25)=5+"0,25"$. $y=sqrt("5,25"^2-25) thin "m" approx "1,60" thin "m"$.
][
*Gegentakt:* Die Anfangsphase $pi$ liefert schon Gegenphase; der Weg muss ein ganzes Vielfaches von $lambda$ beitragen, kleinster von null verschiedener: $sqrt(y^2+25)=5+"0,5"$. $y=sqrt("5,5"^2-25) thin "m" approx "2,29" thin "m"$.
][
*Prüfen:* $y=0$ wäre beim Gegentakt der Ort von Max selbst und ist ausgeschlossen. Gleiche Amplituden sind für vollständige Auslöschung nötig; Interferenz an sich gibt es auch bei ungleichen.
#src[AS 1.5 und 4.5, PDF-S. 14 und 52–53; ASN, PDF-S. 3–4.]
]

#aufgabe(titel: "Schiffe versenken (Variante)", art: "rechnen", quelle: "6.8.3", herkunft: "variante", vorlage: "Aufgabensammlung 1.5", minuten: 12,
  ergebnis: [$c="1,5" thin "m/s"$, $lambda=1 thin "m"$; gleichphasig $y="2,5" thin "m"$, gegenphasig $y approx "3,61" thin "m"$],
)[
#if not web [*Aufgabe 106* #linebreak()]
*Gegeben und Annahmen*

Ein Spielzeugboot liegt bei $x=6 thin "m"$, $y=0$. Anna patscht bei $(0,0)$ mit 1,5 Hz; ihre erste Welle erreicht das Boot nach 4 s. Ben will die Wellen am Boot auslöschen und patscht mit gleicher Frequenz auf der $y$-Achse. Gleiche Amplituden am Boot angenommen.

*Gesucht*

#enum(numbering: "a)",
[Bestimme Ausbreitungsgeschwindigkeit und Wellenlänge.],
[Kleinster Abstand Bens von Anna auf der $y$-Achse bei gleichphasigem und bei gegenphasigem Patschen?],
)
][
*Welle:* $c=6\/4 thin "m/s"="1,5" thin "m/s"$, $lambda=c\/f=1 thin "m"$.
][
*Gleichphasig:* Weg Bens $=6+"0,5"="6,5" thin "m"$, also $y=sqrt("6,5"^2-36) thin "m"=sqrt("6,25") thin "m"="2,5" thin "m"$.
][
*Gegenphasig:* Weg $=6+1=7 thin "m"$, also $y=sqrt(49-36) thin "m"=sqrt(13) thin "m" approx "3,61" thin "m"$.
][
*Prüfen:* Gegenphasig braucht einen ganzen, gleichphasig einen halben Wellenlängenunterschied; deshalb steht Ben im Gegentakt weiter weg.
#src[Eigene Variante nach AS 1.5.]
]

#aufgabe(titel: "Warum hinter der Kante noch Wellen ankommen", art: "verstehen", quelle: "6.8.4", herkunft: "eigen",
  ergebnis: [Beugung und Interferenz der Elementarwellen erklären Wellen im geometrischen Schatten.],
)[
#if not web [*Aufgabe 107* #linebreak()]
Wie heißt die Ausbreitung einer Welle in den geometrischen Schatten eines Hindernisses? Erkläre mit Huygens, warum dort trotzdem eine Welle auftreten kann. Liefert die Kante dafür neue Energie?
#src[V26, PDF-S. 7 und 11, Abb. 6.22.]
][
*Begriff:* Das ist *Beugung*. Die ungehinderten Frontpunkte an Öffnung oder Kante tragen Elementarwellen bei, die sich auch in den geometrischen Schatten ausbreiten.
][
*Superposition berücksichtigen:* Am Beobachtungsort addieren sich die Auslenkungen der Beiträge mit ihren Phasen; so entstehen stärkere und schwächere Bereiche. Die Kante erzeugt keine zusätzliche Energie, sondern verändert das Ausbreitungsmuster.
#src[Quizfrage und Karteikarte zu 6.8.4, Abbildung beugung-quelle.]
]

#aufgabe(titel: "Beugung und Interferenz zusammen denken", art: "verstehen", quelle: "6.8.4", herkunft: "eigen")[
#if not web [*Aufgabe 108* #linebreak()]
Wie hängen Beugung und Interferenz zusammen?
][
*Zwei Blickwinkel:* Beugung beschreibt, dass die Welle nicht auf gerade Strahlen beschränkt bleibt. Das Beugungsbild entsteht durch Interferenz der Elementarwellen mit ihren Phasen. Es sind zwei Blickwinkel auf dieselbe Ausbreitung.
][
*Typische Verwechslungen:* Die Kante erzeugt keine neue Energie. Und Interferenz kann gerade im geometrischen Schatten auftreten.
#src[Quizfrage und Karteikarte zu 6.8.4.]
]

#aufgabe(titel: "Brechung ohne Änderung des Quelltakts", art: "verstehen", quelle: "6.8.5", herkunft: "eigen",
  ergebnis: [$f_2=f_1$; bei $c_2<c_1$ wird $lambda$ kleiner und die Normale zum Lot hin gebrochen.],
)[
#if not web [*Aufgabe 109* #linebreak()]
Eine Welle trifft schräg auf eine ruhende Grenze zu einem langsameren Medium. Erkläre die Änderung von Frequenz, Wellenlänge und Richtung. Was gilt bei senkrechtem Einfall und bei der Reflexion?
#src[V26, PDF-S. 12–13, Gl. 6.22–6.24.]
][
*Takt erhalten:* An der ruhenden Grenzfläche bleibt die Frequenz gleich. Mit $lambda=c/f$ verkleinert sich die Wellenlänge: $lambda_2\/lambda_1=c_2\/c_1$. Typische Verwechslung: Nicht die Frequenz sinkt mit der Geschwindigkeit, sondern die Wellenlänge.
][
*Winkel begründen:* Aus $sin(alpha_2)=(c_2/c_1)sin(alpha_1)$ folgt ein kleinerer Winkel zum Lot: Die Wellennormale wird zum Lot hin gebrochen; bei senkrechtem Einfall bleiben beide Winkel null. Merksatz: Langsameres Medium: kürzere Welle, gleicher Takt.
][
*Reflexion abgrenzen:* Der reflektierte Anteil bleibt im ursprünglichen Medium. Seine Richtung liegt auf der anderen Seite des Lots, der Winkelbetrag ist gleich dem Einfallswinkel.
#src[Quizfrage und Karteikarte zu 6.8.5, Abbildung brechung-quelle.]
]

#aufgabe(titel: "Winkel immer zum Lot", art: "verstehen", quelle: "6.8.5", herkunft: "eigen")[
#if not web [*Aufgabe 110* #linebreak()]
Von welcher Linie aus werden Einfalls-, Reflexions- und Brechungswinkel gemessen, und warum ist das wichtig?
][
*Lot:* Gemessen wird zwischen Ausbreitungsrichtung (Wellennormale) und dem Lot auf die Grenzfläche. Bei Reflexion sind Ein- und Ausfallswinkel betragsgleich; auch das Brechungsgesetz nutzt Winkel zum Lot. Merksatz: Winkel immer zum Lot messen.
][
*Typische Verwechslungen:* Winkel zur Oberfläche sind Ergänzungswinkel. Die Wellenfront steht senkrecht zur Ausbreitungsrichtung; Front und Normale dürfen nicht verwechselt werden. Solche Winkel darf man nicht unverändert in dieselben Formeln einsetzen.
#src[Quizfrage und Karteikarte zu 6.8.5, Abbildung reflexion-3d-quelle.]
]

#aufgabe(titel: "Doppler bei einer heranfahrenden Schallquelle", art: "verstehen", quelle: "6.9.1", herkunft: "original", vorlage: "Altklausur WS 15/16, Frage 11", minuten: 2,
  ergebnis: [Die Person hört eine höhere Frequenz als $f_0$.],
)[
#if not web [*Aufgabe 111* #linebreak()]
*Kurzfrage (1 Punkt)*

Eine Schallquelle, die einen Ton mit der Frequenz $f_0$ aussendet, bewegt sich auf eine Person zu. Was trifft für die Frequenz $f$ der Schallwelle zu, die von der Person wahrgenommen wird: Sind $f$ und $f_0$ gleich, weil die Luft sich nicht bewegt, hört die Person eine höhere oder eine niedrigere Frequenz als $f_0$? Begründe.
][
*Antwort:* Die Person nimmt eine *höhere* Frequenz als $f_0$ wahr: $f=f_0\/(1-v_S\/c)>f_0$ für $0<v_S<c$.
][
*Begründung:* Die Quelle rückt zwischen zwei Emissionen weiter; vor ihr liegen die Fronten enger beieinander. Bei gleichem $c$ treffen mehr Fronten pro Sekunde ein.
][
*Typische Verwechslungen:* „Gleich, weil die Luft ruht“: Das ruhende Medium hält $c$ fest, nicht die Frontabstände. „Der Schall läuft vor der Quelle mit $c+v_S$“: falsch, $c$ bleibt. „Die Quelle schwingt schneller“: Ihr eigener Takt bleibt konstant.
#src[Prüfung Physik 1 WS 2015/16 (Prüfung Phy_1, PDF-S. 4, Frage 11); V26, PDF-S. 14–15; Quizfrage zu 6.9.1.]
]

#aufgabe(titel: "Doppler: Warum nicht die Schallgeschwindigkeit steigt", art: "verstehen", quelle: "6.9.1", herkunft: "eigen",
  ergebnis: [Die Quelle verändert die Frontabstände, nicht $c$ im ruhenden Medium.],
)[
#if not web [*Aufgabe 112* #linebreak()]
Eine Quelle nähert sich einem ruhenden Empfänger mit konstantem eigenen Takt. Was verursacht den Doppler-Effekt, obwohl die Schallgeschwindigkeit gleich bleibt? Wie prüfst du das richtige Vorzeichen, und warum darf die Formel nicht auf Licht übertragen werden?
#src[V26, PDF-S. 14–15 bis zur Endmarkierung.]
][
*Frontabstand erklären:* Zwischen zwei Emissionen rückt die Quelle um $v_S/f_S$ weiter. Vor ihr liegen die Fronten nur $(c-v_S)/f_S$ auseinander, hinter ihr $(c+v_S)/f_S$. Bei unverändertem $c$ zählt der ruhende Empfänger vorne mehr, hinten weniger Fronten pro Sekunde. Merksatz: Vorne rücken die Fronten zusammen, hinten auseinander.
][
*Vorzeichen prüfen:* Annäherung muss den Ton erhöhen: $f_"an"=f_S/(1-v_S/c)$ mit Nenner kleiner als eins. Entfernen senkt ihn: $f_"ent"=f_S/(1+v_S/c)$. Für $v_S=0$ müssen beide wieder $f_S$ ergeben. Merksatz: Annäherung höher, Entfernung tiefer.
][
*Gültigkeit abgrenzen:* Die Formel benutzt Geschwindigkeiten relativ zum Ausbreitungsmedium. Für Licht ist eine relativistische Beschreibung nötig; die hier behandelte Formel gilt dafür nicht.
#src[Karteikarten zu 6.9.1, Abbildungen doppler-quelle und map-doppler.]
]

#aufgabe(titel: "Voraussetzungen der Dopplerformel", art: "verstehen", quelle: "6.9.1", herkunft: "eigen")[
#if not web [*Aufgabe 113* #linebreak()]
Welche Voraussetzungen hat die behandelte Dopplerformel für die bewegte Quelle?
][
*Voraussetzungen:* Empfänger und Medium ruhen. Der Sender bewegt sich mit $v_S<c$ auf den Empfänger zu oder von ihm weg; die Beträge gelten entlang der Verbindungslinie. Nicht auf Licht übertragen. Bei bewegtem Empfänger oder im seitlichen Moment der Vorbeifahrt die Formel nicht ungeprüft verwenden.
#src[Karteikarte zu 6.9.1.]
]

#aufgabe(titel: "Raserei: Geschwindigkeit aus der Quint", art: "rechnen", quelle: "6.9.1", herkunft: "original", vorlage: "Übung 10, Aufg. 6", minuten: 10,
  ergebnis: [$v_S=c/5="68,6" thin "m/s" approx 247 thin "km/h"$],
  tipp: [Bilde den Quotienten der beiden gehörten Frequenzen. Die unbekannte Senderfrequenz kürzt sich.],
)[
#if not web [*Aufgabe 114* #linebreak()]
*Raserei*

*Gegeben und Annahmen*

Du stehst an der Kreuzung, Porsche-Manfred fährt sportlich mit heulendem Motor (7000 U/min) an dir vorbei. Deine musikalische Begleiterin sagt: „Das war eine Quint! Der war also mit xxx Sachen unterwegs!“ Eine Quint ist ein Tonsprung um den Faktor $3\/2$; das Verhältnis der gehörten Frequenzen bei Annäherung und Entfernung beträgt also $f_"an"\/f_"ent"=3\/2$. Die Schallgeschwindigkeit in Luft beträgt 343 m/s. Du und die Luft ruhen.

*Gesucht*

#enum(numbering: "a)",
[Wie schnell war Porsche-Manfred (in m/s und km/h)?],
[Wird die Motordrehzahl für die Rechnung gebraucht? Begründe.],
)
][
*Modell wählen:* Der Sender bewegt sich, der Empfänger ruht. $f_"an"=f_S/(1-v_S/c)$ und $f_"ent"=f_S/(1+v_S/c)$ mit derselben Senderfrequenz.
][
*Quotient bilden:* Mit $beta=v_S/c$: $3/2=(1+beta)/(1-beta)$. Die unbekannte Senderfrequenz kürzt sich; deshalb brauchen wir weder die 7000 U/min noch eine Annahme über die Impulse pro Umdrehung (Teil b).
][
*Auflösen:* $3(1-beta)=2(1+beta)$, also $beta=1/5$ und $v_S=343/5 thin "m/s"="68,6" thin "m/s"$.
][
*Umrechnen:* $"68,6" dot "3,6" thin "km/h" approx 247 thin "km/h"$.
][
*Prüfen:* $v_S/c="0,2"<1$, Unterschall. $f_"an"/f_S="1,25"$, $f_"ent"/f_S=5/6$, Verhältnis 1,5. Voraussetzung: gleichbleibender Quelltakt und Bewegung entlang der Verbindungslinie, nicht der seitliche Moment der Vorbeifahrt.
#src[Ü 10.6, PDF-S. 2; ÜN, PDF-S. 4; V26, PDF-S. 14–15; Quizfrage (Freitext) zu 6.9.1.]
]

#aufgabe(titel: "Krankenwagen: Geschwindigkeit aus dem Tonsprung (Variante)", art: "rechnen", quelle: "6.9.1", herkunft: "variante", vorlage: "Übung 10, Aufg. 6", minuten: 10,
  ergebnis: [$v_S=c\/11 approx "30,9" thin "m/s" approx 111 thin "km/h"$; 770 Hz und 641,7 Hz],
)[
#if not web [*Aufgabe 115* #linebreak()]
*Gegeben und Annahmen*

Ein Krankenwagen fährt mit konstanter Geschwindigkeit an dir vorbei; du und die Luft ruhen, $c=340 thin "m/s"$. Das Verhältnis der gehörten Frequenzen bei Annäherung und Entfernung ist $f_"an"\/f_"ent"="1,2"$ (eine kleine Terz).

*Gesucht*

#enum(numbering: "a)",
[Wie schnell fährt der Krankenwagen?],
[Die Sirene sendet $f_S=700 thin "Hz"$. Welche Frequenzen hörst du bei Annäherung und Entfernung?],
)
][
*Quotient:* $"1,2"=(1+beta)\/(1-beta)$ mit $beta=v_S\/c$; $f_S$ kürzt sich.
][
*Auflösen:* $"1,2"-"1,2" beta=1+beta$, also $beta="0,2"\/"2,2"=1\/11$. $v_S=340\/11 thin "m/s" approx "30,9" thin "m/s" approx 111 thin "km/h"$.
][
*Frequenzen:* $f_"an"=700\/(1-1\/11) thin "Hz"=770 thin "Hz"$, $f_"ent"=700\/(1+1\/11) thin "Hz" approx "641,7" thin "Hz"$.
][
*Prüfen:* $770\/"641,7" approx "1,2"$; Annäherung höher, Entfernung tiefer.
#src[Eigene Variante nach Ü 10.6.]
]

#aufgabe(titel: "Vorbeifahrender Zug: gehörte Töne (Variante)", art: "rechnen", quelle: "6.9.1", herkunft: "variante", vorlage: "Übung 10, Aufg. 6", minuten: 8,
  ergebnis: [$f_"an" approx "566,7" thin "Hz"$, $f_"ent" approx "447,4" thin "Hz"$, Verhältnis $approx "1,27"$],
)[
#if not web [*Aufgabe 116* #linebreak()]
*Gegeben und Annahmen*

Ein Zug fährt mit 144 km/h geradlinig an einer ruhenden Person vorbei und hupt mit konstant 500 Hz. Die Luft ruht, $c=340 thin "m/s"$.

*Gesucht*

#enum(numbering: "a)",
[Welche Frequenzen hört die Person bei Annäherung und bei Entfernung?],
[Welches Frequenzverhältnis $f_"an"\/f_"ent"$ ergibt sich? Ist der Tonsprung größer oder kleiner als eine Quint (1,5)?],
)
][
*Umrechnen:* $v_S=144\/"3,6" thin "m/s"=40 thin "m/s"$, $v_S\/c approx "0,1176"$.
][
*Annäherung:* $f_"an"=500\/(1-"0,1176") thin "Hz" approx "566,7" thin "Hz"$.
][
*Entfernung:* $f_"ent"=500\/(1+"0,1176") thin "Hz" approx "447,4" thin "Hz"$.
][
*Verhältnis:* $(1+beta)\/(1-beta)=380\/300 approx "1,27"$: kleiner als eine Quint, weil der Zug langsamer ist als der Porsche (247 km/h).
#src[Eigene Variante nach Ü 10.6, Rechenrichtung umgekehrt.]
]

#aufgabe(titel: "Fledermaus fliegt über den Detektor", art: "rechnen", quelle: "6.9.1", herkunft: "original", vorlage: "Aufgabensammlung 1.3, Teil 3", minuten: 8,
  ergebnis: [Annäherung: $f_E approx 21049 thin "Hz"$, man hört etwa 49 Hz; Entfernung: $f_E approx 19051 thin "Hz"$, man hört etwa 1949 Hz],
)[
#if not web [*Aufgabe 117* #linebreak()]
*Doppler-Fledermäuse, Teil 3*

*Gegeben und Annahmen*

Ein Großer Abendsegler ruft mit konstant $f_A=20 thin "kHz"$. Ein ruhender Fledermausdetektor überlagert die empfangenen Rufe in Echtzeit mit seinem lokalen Oszillator ($f_D=21 thin "kHz"$); hörbar ist die Schwebung. Die Fledermaus fliegt mit $v_A=61 thin "km/h"$ über dich hinweg. Rechne mit $c=340 thin "m/s"$; Luft und Detektor ruhen.

*Gesucht*

#enum(numbering: "a)",
[Was hörst du im Detektor, während die Fledermaus auf dich zufliegt, und was, während sie sich entfernt?],
)
][
*Modell:* Bewegte Quelle, ruhender Empfänger, Bewegung entlang der Verbindungslinie: $f_E=f_S\/(1 minus.plus v_S\/c)$. $v_A=61\/"3,6" thin "m/s" approx "16,94" thin "m/s"$.
][
*Annäherung:* $f_E=20000\/(1-"16,94"\/340) thin "Hz" approx 21049 thin "Hz"$. Schwebung mit dem Oszillator: $abs(21049-21000) thin "Hz" approx 49 thin "Hz"$.
][
*Entfernung:* $f_E=20000\/(1+"16,94"\/340) thin "Hz" approx 19051 thin "Hz"$. Schwebung: $abs(21000-19051) thin "Hz" approx 1949 thin "Hz"$.
][
*Prüfen:* Beim Vorbeiflug springt der gehörte Ton von etwa 49 Hz auf etwa 1,95 kHz. Ohne Bewegung wären es 1 kHz (Teil 2). Die Musterlösung nennt 48,72 Hz und 1949,2 Hz; die kleine Abweichung kommt vom Runden von $v_A$.
#src[AS 1.3, Teil 3, PDF-S. 12; Lösung 4.3, PDF-S. 48–49; V26, PDF-S. 14–15.]
]

#aufgabe(titel: "Fledermaus mit 36 km/h im Detektor (Variante)", art: "rechnen", quelle: "6.9.1", herkunft: "variante", vorlage: "Aufgabensammlung 1.3, Teil 3", minuten: 8,
  ergebnis: [Annäherung $approx 46364 thin "Hz"$, hörbar $approx 1364 thin "Hz"$; Entfernung $approx 43714 thin "Hz"$, hörbar $approx 1286 thin "Hz"$],
)[
#if not web [*Aufgabe 118* #linebreak()]
*Gegeben und Annahmen*

Eine Zwergfledermaus ruft mit konstant 45 kHz und fliegt mit 36 km/h geradlinig über einen ruhenden Detektor hinweg. Der Detektor ist genau auf 45 kHz eingestellt und macht die Schwebung hörbar. $c=340 thin "m/s"$, Luft ruht.

*Gesucht*

#enum(numbering: "a)",
[Welche Frequenzen empfängt der Detektor bei Annäherung und Entfernung, und welche Töne hörst du?],
[Was hörst du, solange die Fledermaus über dem Detektor an einem Ast hängt?],
)
][
*Umrechnen:* $v_S=10 thin "m/s"$, $v_S\/c approx "0,0294"$.
][
*Annäherung:* $f_E=45000\/(1-10\/340) thin "Hz" approx 46364 thin "Hz"$; hörbar $approx 1364 thin "Hz"$.
][
*Entfernung:* $f_E=45000\/(1+10\/340) thin "Hz" approx 43714 thin "Hz"$; hörbar $approx 1286 thin "Hz"$.
][
*Ruhend:* Gleiche Frequenzen, keine Schwebung, also nichts Hörbares. Prüfen: Die beiden hörbaren Töne liegen nah beieinander, aber nicht symmetrisch, weil $1\/(1-beta)$ und $1\/(1+beta)$ nicht gleich weit von 1 entfernt sind.
#src[Eigene Variante nach AS 1.3, Teil 3.]
]
