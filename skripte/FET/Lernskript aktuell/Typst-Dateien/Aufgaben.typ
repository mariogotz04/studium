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

#kapitel("Kapitel 1 · Grundbegriffe")

#aufgabe(titel: "Thermodynamik an der Fahrradpumpe", art: "verstehen", quelle: "1.0", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 1* #linebreak()]
Wie würdest du Thermodynamik an einer Fahrradpumpe erklären?
][
*Kurz gesagt:* Bei der Pumpe verändert zugeführte Arbeit den Gaszustand. Temperatur, Druck und Volumen beschreiben die Folge; die Energiebilanz erklärt die Energiezufuhr.
]

#aufgabe(titel: "Was die Thermodynamik beschreibt", art: "verstehen", quelle: "1.0", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 2* #linebreak()]
Was beschreibt die Thermodynamik, und wie geht sie dabei vor?
][
*Antwort:*

- *Thema:* Zustand, Masse und Energie einer Anlage, etwa Pumpe, Wasserkocher oder Turbine.
- *Blick von außen:* messbare Größen statt einzelner Moleküle.
- *Vorgehen:* Systemgrenze → Massen- und Energiebilanz → Stoffmodell.
- *Ergebnis:* Zusammenhänge zwischen Druck, Temperatur und Volumen.
]

#aufgabe(titel: "System und Systemgrenze", art: "verstehen", quelle: "1.1", herkunft: "eigen", minuten: 3,
  tipp: [Frag dich, was genau die Grenze überquert.])[
#if not web [*Aufgabe 3* #linebreak()]
Was ist ein thermodynamisches System, und warum ist die Systemgrenze so wichtig?
][
*Antwort:*

- *System:* der Ausschnitt, den ich untersuche.
- *Systemgrenze:* trennt diesen Ausschnitt von seiner Umgebung.
- *Bilanz:* erfasst die Übertragungen über genau diese Grenze.
- *Boiler, nur Wasser betrachtet:* Energie kommt als Wärme vom Heizstab.
- *Boiler, Wasser und Heizstab betrachtet:* Energie kommt als elektrische Arbeit über das Kabel.

#align(center)[#image("abbildungen/boundary.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Erst die Grenze, dann die Bilanz.
][
*Bild:* Eine Bilanz ist die Buchhaltung eines Ausschnitts. Erst muss klar sein, wessen Konto ich führe.
][
*Typische Verwechslung:*

- „Als Wärme vom Heizstab“: So wäre es, wenn nur das Wasser das System wäre. Dann überquert die Energie die Grenze zwischen Heizstab und Wasser als Wärme.
- „Gar nicht, weil die Energie im System bleibt“: Die Energie kommt von außen aus dem Netz, also überquert sie die Grenze.
]

#aufgabe(titel: "Altklausur WS 05/06: Kurzfrage 1", art: "verstehen", quelle: "1.1.1", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 05/06, Kurzfrage 1 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 4* #linebreak()]
Notiere für ein endliches System die instationäre Massenbilanz und leite die stationäre Kontinuitätsgleichung her.
][
*Antwort:* $dif m_"Sys"/dif t=sum dot(m)_"ein"-sum dot(m)_"aus"$. Stationär verschwindet der Speicherterm. Für einen Ein- und Austritt: $dot(m)=rho_1 A_1 c_1=rho_2 A_2 c_2$. Die Flächenmittelwerte und Dichten müssen zum jeweiligen Querschnitt gehören.
]

#aufgabe(titel: "Altklausur WS 04/05: Kurzfrage 8", art: "verstehen", quelle: "1.1.1", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 04/05, Kurzfrage 8 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 5* #linebreak()]
Gib als Formel oder in Worten das allgemeine instationäre Gesetz der Massenerhaltung für endliche Systeme an.
][
*Antwort:* $dif m_"Sys"/dif t=sum dot(m)_"ein"-sum dot(m)_"aus"$. Stationär verschwindet der Speicherterm. Für einen Ein- und Austritt: $dot(m)=rho_1 A_1 c_1=rho_2 A_2 c_2$. Die Flächenmittelwerte und Dichten müssen zum jeweiligen Querschnitt gehören.
]

#aufgabe(titel: "Altklausur WS 02/03: Kurzfrage 8", art: "verstehen", quelle: "1.1.1", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 02/03, Kurzfrage 8 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 6* #linebreak()]
Gib die instationäre Kontinuitätsgleichung für endliche Systeme an.
][
*Antwort:* $dif m_"Sys"/dif t=sum dot(m)_"ein"-sum dot(m)_"aus"$. Stationär verschwindet der Speicherterm. Für einen Ein- und Austritt: $dot(m)=rho_1 A_1 c_1=rho_2 A_2 c_2$. Die Flächenmittelwerte und Dichten müssen zum jeweiligen Querschnitt gehören.
]

#aufgabe(titel: "Bestand und zeitlicher Mittelwert", art: "verstehen", quelle: "1.1.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 7* #linebreak()]
Warum lässt sich aus $dif m/dif t$ allein die aktuelle Behältermasse nicht bestimmen? Wann darfst du einen zeitlichen Mittelwert als arithmetischen Mittelwert der beiden Randwerte berechnen?
][
*Kurz gesagt:* Eine Rate sagt nur, *wie schnell sich etwas ändert*. Den aktuellen Bestand erhältst du erst mit einer Anfangsbedingung:
$ m(t)=m_0+integral_0^t dot(m)_"netto" dif tau $
Der Mittelwert der beiden Randwerte ist nur bei *linearem* Zeitverlauf zugleich der Zeitmittelwert. Bei einer Parabel gilt das allgemein nicht; unterschiedlich lange Messintervalle brauchen Zeitgewichte.
][
*Ausführlich:*

- *Bilanz:* Änderung des Bestands = Zufluss − Abfluss.
- Die Rate (z. B. kg/s) sagt, wie schnell sich etwas ändert.
- Der Bestand (kg) sagt, wie viel gerade drin ist.
- Aus der Rate allein kenne ich den Bestand nicht: Ich brauche zusätzlich den Anfangsbestand.

#align(center)[#image("abbildungen/bath.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Bestand ist „wie viel“, Rate ist „wie schnell“.
][
*Bild:* Badewanne. Gleich viel Zu- und Abfluss hält den Wasserstand konstant, obwohl ständig anderes Wasser hindurchfließt.
]

#aufgabe(titel: "Stationär in der Bilanz", art: "verstehen", quelle: "1.1.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 8* #linebreak()]
Was bedeutet „stationär“ für eine Bilanz, und was bedeutet es nicht?
][
*Antwort:*

- *Stationär heißt:* Am festen Ort ändert sich nichts mit der Zeit.
- Die Speicherterme (z. B. $(dif m)/(dif t)$) sind null.
- Die Ströme verschwinden dabei nicht.
- Ein Durchlauferhitzer ist stationär, obwohl ständig Wasser durchfließt und Energie zugeführt wird.

#align(center)[#image("abbildungen/bath.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Stationär heißt: Speicheränderung null, Ströme möglich.
][
*Bild:* Ein laufendes Förderband kann gleich voll bleiben, obwohl ständig Material hindurchläuft.
]

#aufgabe(titel: "Vorzeichen in ΔU = Q + W", art: "verstehen", quelle: "1.1.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 9* #linebreak()]
Ein geschlossenes System bekommt 100 J Wärme und gibt 40 J Arbeit ab. Wie groß ist $Delta U$? Begründe deine Antwort.
][
*Antwort:* 60 J

$Delta U = Q + W = 100 + (-40)$. Abgegebene Arbeit zählt in der Zufuhrkonvention negativ.
][
*Typische Verwechslung:*

- „140 J“: Hier wurde die abgegebene Arbeit als Zufuhr gezählt.
- „−60 J“: Die Vorzeichen sind vertauscht. Es kommt mehr Energie hinein als hinaus.
- „100 J, weil Arbeit die innere Energie nicht ändert“: Arbeit überträgt Energie genauso wie Wärme. Beide gehen in $Delta U$ ein.
]

#aufgabe(titel: "Tank mit Zu- und Abfluss", art: "rechnen", quelle: "1.1.1", herkunft: "eigen", minuten: 5,
  ergebnis: [$dif m\/dif t = -"0,5" thin "kg/s"$; leer nach $1000 thin "s" approx "16,7" thin "min"$],
  tipp: [Was im Tank bleibt, ist Zufluss minus Abfluss. Ist das Ergebnis positiv oder negativ?],
)[
#if not web [*Aufgabe 10* #linebreak()]
*Gegeben und Annahmen*

Ein Tank enthält $500 thin "kg"$. Es fließen $2 thin "kg/s"$ hinein und $"2,5" thin "kg/s"$ hinaus.

*Gesucht*

#enum(numbering: "a)",
[Bestimme Änderungsrate und Leerungszeit bei konstanten Strömen.],
)
][
*Bild:* Der Tank ist wie ein Konto. Die Änderung pro Sekunde ist Einzahlung minus Auszahlung. Massenbilanz: $dif m\/dif t = dot(m)_"zu" - dot(m)_"ab"$.
][
*Änderungsrate:* $dif m\/dif t = 2 - "2,5" = -"0,5" thin "kg/s"$. Das Minus heißt: Der Tank verliert jede Sekunde ein halbes Kilogramm.
][
*Leerungszeit:* Bei konstanter Rate ist die Abnahme linear. $t = 500 thin "kg"\/"0,5" thin "kg/s" = 1000 thin "s" approx "16,7" thin "min"$.
][
*Prüfen:* kg geteilt durch kg/s ergibt s. Die Rechnung gilt nur, solange die Ströme wirklich konstant bleiben; ein füllstandsabhängiger Ausfluss würde langsamer werden.
]

#aufgabe(titel: "Zeitabhängige Massenbilanz", art: "rechnen", quelle: "1.1.1", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 1.1", minuten: 10)[
#if not web [*Aufgabe 11* #linebreak()]
*Zeitabhängiger Behälter, Ü 1.1:*

*Gegeben und Annahmen*

Ein Behälter mit konstanter Fläche $A$ enthält anfangs $m_0=rho A h_0$. Es gelten $dot(m)_"zu"=z t$, $dot(m)_"ab"=a t$ und $rho="konstant"$.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $m(t)$, $h(t)$, die drei Fälle $z>a$, $z=a$, $z<a$, beide mittleren Massenströme und den mittleren Füllstand im Intervall $t_1$ bis $t_2$.],
)
][
*Modell:* offener Behälter, $rho,A,z,a$ konstant; $m_0=rho A h_0$. Gesucht: Bestand, Pegel, Mittelwerte.
][
*Bilanz aufstellen und integrieren:*
$ (dif m)/(dif t)=(z-a)t quad => quad m=m_0+(z-a)t^2/2 $
*2 · Masse in Füllstand übersetzen:*
$ h=h_0+(z-a)t^2/(2 rho A) $
Für $t>0$: $z>a$ bedeutet Anstieg, $z=a$ konstanten Pegel, $z<a$ Abnahme.
][
*Zeitmittelwerte:* Integral durch Intervalllänge teilen:
$ overline(dot(m))_"zu"=z(t_1+t_2)/2 quad overline(dot(m))_"ab"=a(t_1+t_2)/2 $
$ overline(h)=h_0+(z-a)/(6 rho A)(t_1^2+t_1t_2+t_2^2) $
Dahinter steckt $overline(h)=integral_(t_1)^(t_2)h(t)dif t/(t_2-t_1)$ und die Integration von $t^2$ zu $t^3/3$.
][
*Prüfung:* Bei $z=a$ bleiben Masse und Pegel konstant. $(z-a)t^2$ hat die Einheit kg. Nach Erreichen von $h=0$ ist die Formel nicht als negativer realer Pegel gültig.
]

#aufgabe(titel: "Badewanne vollständig bilanzieren", art: "rechnen", quelle: "1.1.1", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 1.2", minuten: 12)[
#if not web [*Aufgabe 12* #linebreak()]
*Badewanne, Ü 1.2:*

*Gegeben und Annahmen*

Anfangs leer, $400 thin "l"$ Inhalt, Zuflüsse $30 thin "l/min"$ und $"0,1" thin "l/s"$. Vom maximalen Abfluss $90 thin "l/min"$ bleiben 20 Prozent frei. Jedes Rostloch führt $"0,25" thin "l/min"$ ab.

*Gesucht*

#enum(numbering: "a)",
[Berechne für ein Loch Massenänderung, Wasserinhalt als Zeitfunktion und Füllzeit.],
[Bestimme den erforderlichen Überlauf bei vollständig blockiertem Bodenabfluss einschließlich Löchern sowie die maximal zulässige Lochzahl bei normalem Teilabfluss, damit der Pegel nicht sinkt. Nutze $rho=1 thin "kg/l"$ und konstante Ströme.],
)
][
*Strategie:* alle Ströme in l/min. Bei konstanter Dichte genügt die Volumenbilanz.
#tab(columns: (1.5fr, 1fr),
 th([Beitrag], [Volumenstrom]),
 [Zuläufe], [$30+6=36 thin "l/min"$],
 [20 % freier Bodenabfluss], [$"0,2" times 90=18 thin "l/min"$],
 [Ein Rostloch], [$"0,25" thin "l/min"$],
 [Netto], [*17,75 l/min*],
)
$ (dif m)/(dif t)="17,75" thin "kg/min"="0,29583" thin "kg/s" $
Anfangs leer, $t$ in Minuten und vor dem Vollwerden:
$ V(t)="17,75"t thin "l" quad m(t)="17,75"t thin "kg" $
$ t_"voll"=400/"17,75" approx "22,54" thin "min" approx 1352 thin "s" $

*Überlauf:* Sind alle Bodenöffnungen blockiert, muss er den gesamten Zufluss *36 l/min = 0,6 l/s* abführen.

*Lochzahl bei normalem Teilabfluss:* $36-18-"0,25"n>=0$ ergibt $n<=72$. 72 Löcher halten den Pegel gerade konstant. *Fehlerquelle:* 80 % verdeckt bedeutet nur 20 % frei.
]

#aufgabe(titel: "Boiler, Mittelwert und Spitzenlast", art: "rechnen", quelle: "1.1.1", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 1.3", minuten: 15)[
#if not web [*Aufgabe 13* #linebreak()]
*Boiler, Ü 1.3:*

*Gegeben und Annahmen*

$400 thin "l"$ Wasser sollen von 6 auf 80 °C erwärmt werden. Nutze $rho=1 thin "kg/l"$, die Mittelwerte $C_6="4,21037"$ und $C_80="4,18665" thin "kJ/(kg K)"$ mit Bezug auf 0 °C.

*Gesucht*

#enum(numbering: "a)",
[Bestimme Energie und Leistung für 4 h, 6 h und 0,5 h. Für nachströmendes Kaltwasser mit 6 °C: Welche Dauerleistung deckt 1 l/min, welche 10 l/min?],
[Warum kann ein Speicher den erforderlichen Spitzenwert der elektrischen Anschlussleistung verringern?],
)
][
#bild("boiler", [Energie wird im warmen Wasser gespeichert und kann eine kurzzeitige Spitzenlast abdecken. Eigens erzeugte Illustration.], height: 47mm)
*Modell:* Wasser und Heizer geschlossen und nach außen adiabat; Verluste und Behälterwärmekapazität vernachlässigt. $m=400 thin "kg"$. Den Flüssigkeits-Energieanstieg nähern wir durch die isobare Enthalpiedifferenz an.
][
*Tabellenbezug 0 °C berücksichtigen:*
$ Delta h="4,18665" times 80-"4,21037" times 6="309,66978" thin "kJ/kg" $
*2 · Energiemenge:* $W_"el" approx m Delta h="123,87" thin "MJ"$.
][
*Leistung = Energie / Zeit:*
#tab(columns: (1fr, 1fr, 1fr),
 th([4 h], [6 h], [0,5 h]),
 [8,60 kW], [5,73 kW], [68,82 kW],
)
*4 · Dauernde Nachspeisung:* $P=dot(m)Delta h$ ergibt *5,16 kW bei 1 l/min* und *51,61 kW bei 10 l/min*.

*Speicherwirkung:*
$ (dif U)/(dif t)=P_"el"-dot(m)(h_"aus"-h_"ein") $
Kurzzeitig kann die Entnahme mehr Leistung verlangen als der Heizer liefert; dann sinkt die gespeicherte Energie. Die mögliche Dauer hängt von Volumen, Temperatur und Wiederaufladung ab.

Ein Mittelwert von 1 l/min legt die Kurvenform nicht fest. Ein möglicher Verlauf ist 10 l/min während 10 % der Zeit. Allgemein: $overline(dot(V))=sum_i dot(V)_i Delta t_i/(sum_i Delta t_i)$.

*Abgleich:* Konstantes $c=4194 thin "J/(kg K)"$ aus der Handschrift ergibt 124,144 MJ. Das ist eine andere Stoffwertnäherung; hier bleibt die Tabellenmethode einheitlich.
]

#aufgabe(titel: "Boiler mit 300 Litern (Variante)", art: "rechnen", quelle: "1.1.1", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 1.3", minuten: 10,
  ergebnis: [$W approx "92,90" thin "MJ"$; $"8,60" thin "kW"$ (3 h), $"25,81" thin "kW"$ (1 h); Dauerleistung $"10,32" thin "kW"$ bzw. $"77,42" thin "kW"$])[
#if not web [*Aufgabe 14* #linebreak()]
*Gegeben und Annahmen*

Ein Boiler soll 300 l Wasser von 6 °C auf 80 °C erwärmen; $rho = 1 thin "kg/l"$. Mittlere Wärmekapazitäten mit Bezug auf 0 °C: $C_6 = "4,21037"$ und $C_80 = "4,18665" thin "kJ/(kg K)"$. Boiler adiabat und geschlossen, Behälterwärmekapazität vernachlässigt.

*Gesucht*

#enum(numbering: "a)",
[Die nötige Energie sowie die Heizleistung für eine Aufheizzeit von 3 h und von 1 h.],
[Welche Dauerleistung braucht ein Durchlaufbetrieb mit 2 l/min beziehungsweise 15 l/min Kaltwasser von 6 °C auf 80 °C?],
)
][
*Enthalpiedifferenz mit Tabellenbezug:* Die Mittelwerte gelten jeweils ab 0 °C, also
$ Delta h = "4,18665" dot 80 - "4,21037" dot 6 = "309,67" thin "kJ/kg" $
Energie: $W = m Delta h = 300 dot "309,67" thin "kJ" approx "92,90" thin "MJ"$.
][
*Leistung = Energie durch Zeit:* 3 h: $92 thin 901\/10 thin 800 thin "kW" approx "8,60" thin "kW"$; 1 h: $approx "25,81" thin "kW"$.
][
*Durchlauf:* $P = dot(m) Delta h$ mit $dot(m) = 2\/60$ bzw. $15\/60 thin "kg/s"$: $approx "10,32" thin "kW"$ bzw. $approx "77,42" thin "kW"$. Ein Speicher erlaubt einen kleineren Heizer, weil er Energie über längere Zeit sammelt.
]

#aufgabe(titel: "Wasserbad mit knickfreiem Temperaturverlauf", art: "rechnen", quelle: "1.1.1", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 1.4", minuten: 15)[
#if not web [*Aufgabe 15* #linebreak()]
*Wasserbad, Ü 1.4, Tutorium und WZF:*

*Gegeben und Annahmen*

Von 6 auf 70 °C wird mit 10 K/h geheizt. Die letzten 20 K bis 90 °C um 12:00 Uhr verlaufen parabolisch, am Übergang knickfrei und am Ende mit Steigung null.

*Gesucht*

#enum(numbering: "a)",
[Bestimme Parabel, Übergangszeit, Einschaltzeit und spezifische Heizleistung mit $c=4200 thin "J/(kg K)"$. Es ist keine Wassermasse vorgegeben.],
[Erläutere die Systemgrenze und die ideale Halteleistung.],
)
][
*Zeitkoordinate:* $t$ in Stunden seit Mitternacht; $vartheta$ ist der Celsius-Zahlenwert. Die Parabel endet um $t_3=12 thin "h"$ mit Steigung null:
$ vartheta_"II"=90-a(t-t_3)^2 quad (dif vartheta_"II")/(dif t)=-2a(t-t_3) $
Mit $Delta t=t_3-t_2$ verlangen 20 K Zunahme und der knickfreie Anschluss:
$ a Delta t^2=20 quad quad 2a Delta t=10/"h" $
Division ergibt $Delta t=4 thin "h"$, also *Übergang 08:00 Uhr* und $a="1,25"/"h"^2$.

Die lineare Phase braucht $(70-6)/10="6,4" thin "h"$. *Einschalten: 01:36 Uhr.*
#tab(columns: (1fr, 2.2fr),
 th([Zeit], [Celsius-Zahlenwert]),
 [bis 01:36], [$vartheta=6$],
 [01:36–08:00], [$vartheta=6+(10/"h")(t-"1,6" thin "h")$],
 [08:00–12:00], [$vartheta=90-("1,25"/"h"^2)(t-12 thin "h")^2$],
 [ab 12:00], [$vartheta=90$],
)
*Leistung:* $P/m=c dif theta/dif t$; 10 K/h zuerst in K/s umrechnen.
$ P_"I"/m=4200 times 10/3600="11,67" thin "W/kg" $
$ P_"II"/m="11,67" thin "W/kg" (12 thin "h"-t)/(4 thin "h") $
Vor Beginn und beim ideal adiabaten Halten: null. Ohne Masse keine gesamte Leistung in Watt.

*Prüfung:* Um 08:00 Uhr stimmen 70 °C und 10 K/h beider Ansätze überein; um 12:00 Uhr gelten 90 °C und Steigung null. Real muss Halteleistung Wärmeverluste ausgleichen. Die adiabate äußere Grenze umfasst Wasser und Heizer; Elektrizität führt Arbeit zu.
]

#aufgabe(titel: "Füllstandsabhängiger Ausfluss", art: "rechnen", quelle: "1.1.1", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 1.5", minuten: 12)[
#if not web [*Aufgabe 16* #linebreak()]
*Freier Ausfluss, vereinfachter Teil von Ü 1.5:*

*Gegeben und Annahmen*

Ein offener zylindrischer Behälter mit $D=1 thin "m"$, Anfangshöhe $H="1,25" thin "m"$ und Auslassdurchmesser $d="12,5" thin "mm"$ wird reibungsfrei entleert. Vernachlässige Auslasshöhe, Luftdichte und Oberflächengeschwindigkeit wie in Teil b der Originalaufgabe. Verwende $g="9,81" thin "m/s"^2$.

*Gesucht*

#enum(numbering: "a)",
[Leite $h(t)$ und die Leerungszeit her. Wann ist die Hälfte des Anfangsvolumens abgeflossen?],
)
][
*Modell:* großer offener Zylinder, kleine Öffnung auf Bodenniveau, konstante Dichte, keine Verluste, gleiche Umgebungsdrücke. Der lokale Ausfluss wird quasistationär modelliert.
][
*Bernoulli:* $c_0=sqrt(2 g h)$.
][
*Speicherung:* $rho A dif h/dif t=-rho A_0c_0$; $rho$ kürzt sich.
][
*Variablen trennen und integrieren:*
$ integral_H^(h(t)) (dif h)/sqrt(h)=-(A_0/A)sqrt(2g)integral_0^t dif t $
$ 2(sqrt(h)-sqrt(H))=-(A_0/A)sqrt(2g)t $
$ h(t)=(sqrt(H)-(A_0/A)sqrt(g/2)t)^2 $
*4 · Leerlaufen bei $h=0$:*
$ A/A_0=(D/d)^2=6400 $
$ t_"leer"=(A/A_0)sqrt(2H/g) approx 3231 thin "s"="53,85" thin "min" $
Halbes abgeflossenes Volumen bedeutet im Zylinder $h=H/2$:
$ t_(1/2)=t_"leer"(1-1/sqrt(2)) approx 946 thin "s"="15,77" thin "min" $
*Prüfung:* Die erste Hälfte fließt wegen der größeren Druckhöhe schneller ab. Die Formel endet beim Leerlaufen; danach bleibt $h=0$. Die originale Auslasshöhe von 10 mm ist hier ausdrücklich vernachlässigt.
]

#aufgabe(titel: "Regentonne mit Bodenklappe und Zufluss", art: "rechnen", quelle: "1.1.1", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 1.6", minuten: 35,
  ergebnis: [$hat(t) approx 181 thin "s"$; $z_1 approx "1,80" thin "m"$, $z_2 approx "0,20" thin "m"$; konstanter Füllstand bei $dot(V)_"zu" approx 522 thin "l/min"$; stationärer Zustand erst für $t -> infinity$],
  tipp: [Die Massenbilanz liefert $A thin dif z\/dif t = dot(V)_"zu" - A_"ab" sqrt(2 g z)$. Wo wird die rechte Seite null?])[
#if not web [*Aufgabe 17* #linebreak()]
*Gegeben und Annahmen*

In der zylindrischen Regentonne (Durchmesser $D = 1 thin "m"$) von Kleingartenbesitzer Hansi Harke steht der Wasserspiegel anfangs bei $z(t=0) = z_0 = 1 thin "m"$. Am Boden der Tonne wird plötzlich eine kreisrunde Klappe vom Durchmesser $d = 5 thin "cm"$ geöffnet, wodurch gemäß der Ausflussformel von Torricelli Wasser mit der füllstandsabhängigen Geschwindigkeit $w_"ab" (z) = sqrt(2 g z)$ nach unten austritt. Gleichzeitig mit dem Öffnen der Bodenklappe fließt der Wasserstrom $dot(V)_"zu" >= 0$ in die Regentonne. Reibungs- und Beschleunigungseffekte seien ebenso vernachlässigbar wie Wirbel infolge der Absenkung der Wasseroberfläche. $g = "9,81" thin "m/s"^2$, $rho = "konst."$

*Gesucht*

#enum(numbering: "a)",
[Fertige eine Systemskizze mit den wesentlichen Informationen an.],
[Stelle die Massenbilanz auf und leite daraus die Differenzialgleichung (DGL) für den Füllstand $z(t)$ her.],
[Zunächst gilt $dot(V)_"zu" = 0$. Vereinfache die DGL und zeige, dass die (auch für $dot(V)_"zu" != 0$ gültige) Umkehrfunktion
$ t(z) = (2 A)/(sqrt(2 g) A_"ab") (sqrt(z_0) - sqrt(z)) + (dot(V)_"zu" A)/(g A_"ab"^2) ln((sqrt(z_0) - dot(V)_"zu"\/(sqrt(2 g) A_"ab"))/(sqrt(z) - dot(V)_"zu"\/(sqrt(2 g) A_"ab"))) $
eine Lösung für $dot(V)_"zu" = 0$ ist.],
[Berechne die Dauer $hat(t)$ für die Entleerung.],
[Skizziere den Füllstand $z(t)$ über der Zeit.],
[Nun fließt mit dem Öffnen gleichzeitig $dot(V)_"zu" != 0$ zu. Welche stationären Zustände sind möglich, wenn die Tonne nicht überläuft? Diskutiere die Fälle anschaulich anhand der DGL.],
[Ermittle die stationären Füllstände $z_1$ und $z_2$ für die Zuflüsse $alpha$) $dot(V)_"zu1" = "700,11" thin "l/min"$ und $beta$) $dot(V)_"zu2" = "233,37" thin "l/min"$.],
[Welche Bedingung muss für einen konstanten Füllstand $z(t) = z_0$ erfüllt sein? Was gilt dann für die Systemmasse $m$?],
[Nach welcher Zeit $t^*$ wird bei den Zuflüssen aus g) der stationäre Zustand jeweils erreicht?],
[Ergänze das Füllstandsdiagramm um die Verläufe für $alpha$) und $beta$).],
)
][
*Skizze und Größen:* Zylinder mit Fläche $A = pi D^2\/4 = "0,7854" thin "m"^2$, Spiegelhöhe $z(t)$, oben Zufluss $dot(V)_"zu"$, unten die Klappe mit $A_"ab" = pi d^2\/4 = "1,9635" times 10^(-3) thin "m"^2$ und dem Strahl $w_"ab" = sqrt(2 g z)$. Die Systemgrenze umschließt das Wasser in der Tonne; über sie treten nur die beiden Massenströme.
][
*Massenbilanz und DGL:* Die Masse in der Tonne ist $m = rho A z$. Änderung des Bestands = Zufluss − Abfluss:
$ (dif m)/(dif t) = rho A (dif z)/(dif t) = rho dot(V)_"zu" - rho A_"ab" sqrt(2 g z) $
$ (dif z)/(dif t) = (dot(V)_"zu" - A_"ab" sqrt(2 g z))/A $
Die rechte Seite hängt nur von $z$ ab: Je höher der Spiegel, desto schneller der Abfluss.
][
*Lösung für $dot(V)_"zu" = 0$:* Der Logarithmusterm hat den Vorfaktor $dot(V)_"zu"$ und fällt weg; im Argument steht dann $sqrt(z_0)\/sqrt(z)$, also nichts Unendliches. Es bleibt
$ t(z) = (2 A)/(sqrt(2 g) A_"ab") (sqrt(z_0) - sqrt(z)) $
*Probe durch Ableiten:* $dif t\/dif z = -A\/(sqrt(2 g) A_"ab" sqrt(z))$. Der Kehrwert ist $dif z\/dif t = -A_"ab" sqrt(2 g z)\/A$, genau die DGL ohne Zufluss. Außerdem gilt $t(z_0) = 0$, die Anfangsbedingung passt.
][
*Entleerungsdauer:* Leer heißt $z = 0$:
$ hat(t) = (2 A sqrt(z_0))/(sqrt(2 g) A_"ab") = (2 dot "0,7854" dot 1)/("4,429" dot "1,9635" times 10^(-3)) thin "s" approx 181 thin "s" $
*Skizze e):* $z(t) = (sqrt(z_0) - sqrt(2 g) A_"ab" t\/(2A))^2$ ist ein Parabelast: anfangs steil fallend, bei $hat(t)$ mit waagerechter Tangente auf null.
][
*Stationäre Zustände:* Stationär heißt $dif z\/dif t = 0$, also Zufluss = Abfluss:
$ dot(V)_"zu" = A_"ab" sqrt(2 g z_s) quad => quad z_s = 1/(2 g) (dot(V)_"zu"/A_"ab")^2 $
- Ist $z_0 < z_s$, überwiegt anfangs der Zufluss: Der Spiegel steigt und nähert sich $z_s$ von unten.
- Ist $z_0 > z_s$, überwiegt der Abfluss: Der Spiegel sinkt auf $z_s$.
- Ist $z_0 = z_s$, bleibt er stehen.
Je näher $z$ an $z_s$ kommt, desto kleiner wird die Differenz der Ströme und desto langsamer ändert sich $z$.
][
*Zahlen für g):* $sqrt(2 g) A_"ab" = "8,697" times 10^(-3) thin "m"^(2,5)/"s"$.
$ alpha): dot(V)_"zu1" = "700,11" thin "l/min" = "0,011669" thin "m"^3/"s" => z_1 = ("0,011669"/"8,697" times 10^(-3))^2 thin "m" approx "1,80" thin "m" $
$ beta): dot(V)_"zu2" = "233,37" thin "l/min" = "0,0038895" thin "m"^3/"s" => z_2 approx "0,20" thin "m" $
Bei $alpha$) steigt der Spiegel von 1 m auf 1,8 m, bei $beta$) sinkt er auf 0,2 m.
][
*Konstanter Füllstand:* $z(t) = z_0$ verlangt $z_s = z_0$:
$ dot(V)_"zu" = A_"ab" sqrt(2 g z_0) = "8,697" times 10^(-3) thin "m"^3/"s" approx 522 thin "l/min" $
Dann ist $dif m\/dif t = 0$: Die Masse $m = rho A z_0 approx 785 thin "kg"$ bleibt konstant, obwohl ständig Wasser hindurchströmt.
][
*Zeit bis zum stationären Zustand:* Setze in $t(z)$ den Wert $z = z_s$ ein. Dann wird der Nenner im Logarithmus $sqrt(z_s) - dot(V)_"zu"\/(sqrt(2 g) A_"ab") = 0$, und der Logarithmus geht gegen unendlich:
$ t^* -> infinity $
Der Spiegel nähert sich $z_s$ nur asymptotisch, weil die treibende Differenz $dot(V)_"zu" - A_"ab" sqrt(2 g z)$ mit der Annäherung selbst verschwindet. *Diagramm j):* Kurve $alpha$) steigt von 1 m und schmiegt sich von unten an 1,8 m an; Kurve $beta$) fällt von 1 m und schmiegt sich von oben an 0,2 m an. Die Kurve ohne Zufluss erreicht dagegen nach 181 s die Null.
]

#aufgabe(titel: "Regentonne mit kleinerer Klappe (Variante)", art: "rechnen", quelle: "1.1.1", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 1.6", minuten: 15,
  ergebnis: [$hat(t) approx 198 thin "s"$; $z_s = "1,5" thin "m"$ bei $approx 409 thin "l/min"$; $z_s = "0,3" thin "m"$ bei $approx 183 thin "l/min"$; Haltezufluss $approx 366 thin "l/min"$])[
#if not web [*Aufgabe 18* #linebreak()]
*Gegeben und Annahmen*

Eine zylindrische Tonne ($D = "0,8" thin "m"$) ist bis $z_0 = "1,2" thin "m"$ gefüllt. Am Boden wird eine Klappe mit $d = 4 thin "cm"$ geöffnet; das Wasser tritt mit $w_"ab" = sqrt(2 g z)$ aus. Reibung und Beschleunigung sind vernachlässigbar, $g = "9,81" thin "m/s"^2$.

*Gesucht*

#enum(numbering: "a)",
[Die Entleerungsdauer ohne Zufluss.],
[Welcher Zufluss in l/min stellt einen stationären Füllstand von 1,5 m ein, welcher einen von 0,3 m?],
[Welcher Zufluss hält den Füllstand genau bei $z_0$?],
)
][
*Flächen und Entleerung:* $A = pi dot "0,8"^2\/4 = "0,5027" thin "m"^2$, $A_"ab" = pi dot "0,04"^2\/4 = "1,2566" times 10^(-3) thin "m"^2$. Ohne Zufluss liefert die integrierte Massenbilanz
$ hat(t) = (2 A sqrt(z_0))/(sqrt(2 g) A_"ab") = (2 dot "0,5027" dot sqrt("1,2"))/("4,429" dot "1,2566" times 10^(-3)) thin "s" approx 198 thin "s" $
][
*Stationäre Füllstände:* Stationär ist Zufluss = Abfluss, $dot(V)_"zu" = A_"ab" sqrt(2 g z_s)$, mit $A_"ab" sqrt(2 g) = "5,566" times 10^(-3) thin "m"^(2,5)/"s"$:
$ z_s = "1,5" thin "m": dot(V)_"zu" = "6,817" times 10^(-3) thin "m"^3/"s" approx 409 thin "l/min" $
$ z_s = "0,3" thin "m": dot(V)_"zu" = "3,049" times 10^(-3) thin "m"^3/"s" approx 183 thin "l/min" $
Im ersten Fall steigt der Spiegel von 1,2 m an, im zweiten sinkt er; beide Werte werden nur asymptotisch erreicht.
][
*Füllstand halten:* $dot(V)_"zu" = A_"ab" sqrt(2 g z_0) = "5,566" times 10^(-3) dot sqrt("1,2") thin "m"^3/"s" = "6,097" times 10^(-3) thin "m"^3/"s" approx 366 thin "l/min"$. Die Masse in der Tonne bleibt dann konstant.
]

#aufgabe(titel: "Förderleistung und Wirkungsgrade", art: "rechnen", quelle: "1.1.1", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 1.8", minuten: 12)[
#if not web [*Aufgabe 19* #linebreak()]
*Förderpumpe, Ü 1.8:*

*Gegeben und Annahmen*

Elektrisch werden 32 kW zugeführt, der Motor gibt 90 Prozent als Wellenleistung ab. Es gelten $dot(V)="0,125" thin "m"^3/"s"$, $rho=800 thin "kg/m"^3$, $Delta p=275 thin "kPa"$, $D_1=100 thin "mm"$, $D_2=150 thin "mm"$. Vernachlässige Höhen- und Temperaturänderung. Verwende $g="9,81" thin "m/s"^2$.

*Gesucht*

#enum(numbering: "a)",
[Berechne Geschwindigkeiten, Netto-Förderleistung, Pumpenwirkungsgrad bezogen auf die Welle und Gesamtwirkungsgrad bezogen auf die elektrische Leistung.],
)
][
*Modell:* Höhen- und Temperaturänderung vernachlässigt. Gesucht ist die Nettoleistung für Druck *und* Bewegungsenergie.
][
*Motor:* $P_"Welle"="0,9" times 32="28,8" thin "kW"$.
][
*Strömung:* $c=dot(V)/(pi D^2/4)$ liefert $c_1="15,92"$, $c_2="7,07" thin "m/s"$. Massenstrom: $dot(m)=800 times "0,125"=100 thin "kg/s"$.
][
*Förderleistung:*
$ Delta dot(E)=dot(V)Delta p+dot(m)(c_2^2-c_1^2)/2 $
$ Delta dot(E)="34,375" thin "kW"-"10,163" thin "kW"="24,21" thin "kW" $
Die Erweiterung senkt die Geschwindigkeit und damit den kinetischen Anteil. Nur $dot(V)Delta p$ zu verwenden wäre hier unvollständig.
][
*Wirkungsgrade:*
$ eta_"Pumpe"="24,21"/"28,8" approx "0,841" quad eta_"gesamt"="24,21"/32 approx "0,757" $
*Energiefluss:* 32 kW elektrisch → 28,8 kW Welle → 24,21 kW Fluid. Verluste: 3,2 kW im Motor, 4,59 kW in der Pumpe. Der Gesamtwirkungsgrad ist das Produkt der beiden Teilwirkungsgrade.
]

#aufgabe(titel: "Förderpumpe für Öl (Variante)", art: "rechnen", quelle: "1.1.1", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 1.8", minuten: 10,
  ergebnis: [$c_1 approx "13,26"$, $c_2 approx "7,46" thin "m/s"$; $Delta dot(E) approx "26,83" thin "kW"$; $eta_"Pumpe" approx "0,729"$; $eta_"ges" approx "0,671"$])[
#if not web [*Aufgabe 20* #linebreak()]
*Gegeben und Annahmen*

Einem Pumpenmotor werden 40 kW elektrisch zugeführt; er gibt 92 % als Wellenleistung ab. Gefördert werden $dot(V) = "0,15" thin "m"^3/"s"$ eines inkompressiblen Öls ($rho = 850 thin "kg/m"^3$) mit der Druckerhöhung $Delta p = 230 thin "kPa"$. Saugseitiger Durchmesser $D_1 = 120 thin "mm"$, druckseitiger $D_2 = 160 thin "mm"$. Höhen- und Temperaturänderungen vernachlässigt.

*Gesucht*

#enum(numbering: "a)",
[Die Strömungsgeschwindigkeiten in Saug- und Druckleitung.],
[Die Netto-Förderleistung.],
[Pumpen- und Gesamtwirkungsgrad.],
)
][
*Geschwindigkeiten:* $c = dot(V)\/(pi D^2\/4)$: $c_1 approx "13,26" thin "m/s"$, $c_2 approx "7,46" thin "m/s"$.
][
*Förderleistung:* $dot(m) = "127,5" thin "kg/s"$.
$ Delta dot(E) = dot(V) Delta p + dot(m)(c_2^2 - c_1^2)/2 = "34,50" - "7,67" thin "kW" approx "26,83" thin "kW" $
Die Verzögerung im weiteren Druckrohr verringert die kinetische Energie, das muss mitgezählt werden.
][
*Wirkungsgrade:* Welle $"0,92" dot 40 = "36,8" thin "kW"$. $eta_"Pumpe" = "26,83"\/"36,8" approx "0,729"$, $eta_"ges" = "26,83"\/40 approx "0,671" = "0,92" dot "0,729"$.
]

#aufgabe(titel: "Drei Wege der Energie über die Grenze", art: "verstehen", quelle: "1.1.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 21* #linebreak()]
Auf welchen drei Wegen kann Energie über eine Systemgrenze kommen?
][
*Antwort:*

- *Arbeit:* durch Bewegung, z. B. Kolben, Welle oder elektrischer Strom.
- *Wärme:* wegen eines Temperaturunterschieds.
- *Mit Stoff:* strömende Masse bringt ihre Energie mit.
- Das sind Arten der Übertragung, keine verschiedenen Energiearten im Stoff.
- Gespeichert wird z. B. innere Energie.

#align(center)[#image("abbildungen/transfers.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Enthalpie anschaulich", art: "verstehen", quelle: "1.1.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 22* #linebreak()]
Was ist die Enthalpie anschaulich, und warum nutzt man sie bei durchströmten Systemen?
][
*Antwort:*

- *Enthalpie:* $h = u + p v$.
- \*\*$u$:\*\* innere Energie, die der Stoff mitbringt.
- \*\*$p v$:\*\* Verschiebearbeit, um den Stoff gegen den Druck hineinzuschieben.
- In der Strömungsbilanz steckt beides bereits in der Enthalpie.
- Verschiebearbeit deshalb nicht noch einmal als Arbeit addieren.

#align(center)[#image("abbildungen/transfers.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Enthalpie nimmt die Verschiebearbeit schon mit.
][
*Bild:* Wer in eine volle U-Bahn einsteigt, bringt nicht nur sich selbst mit, sondern muss auch Platz schieben. Die Enthalpie zählt beides.
]

#aufgabe(titel: "Kurzfrage: Offenes und geschlossenes System", art: "verstehen", quelle: "1.1.3", herkunft: "original", vorlage: "Leistungsnachweis WS 13/14, Kurzfrage 6", minuten: 3)[
#if not web [*Aufgabe 23* #linebreak()]
Was versteht man unter einem a) offenen System, b) geschlossenen System?
][
*Antwort:* a) Ein abgegrenzter Raum (Kontrollraum), über dessen Grenze Masse strömt. b) Eine abgegrenzte, feste Stoffmenge; über die Grenze tritt keine Masse.
][
*Wichtig:* Beide können Energie als Wärme und Arbeit austauschen. Erst das abgeschlossene System tauscht gar nichts mit der Umgebung aus.
]

#aufgabe(titel: "Altklausur WS 99/00 LN: Kurzfrage 1", art: "verstehen", quelle: "1.1.3", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 99/00 LN, Kurzfrage 1 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 24* #linebreak()]
Wie ist bei einem geschlossenen adiabaten System die Systemgrenze für Masse, Volumenarbeit, innere Energie und Wärme einzuordnen? Begründe auch, wenn die Frage unzutreffend ist.
][
*Antwort:* Masse: undurchlässig wegen „geschlossen“. Wärme: undurchlässig wegen „adiabat“. Volumenarbeit: bei beweglicher Grenze möglich, nicht durch „adiabat“ ausgeschlossen. Innere Energie ist eine Zustandsgröße im System und keine eigene Art des Grenztransports; sie kann sich durch Arbeit ändern.
]

#aufgabe(titel: "Geschlossen und adiabat", art: "verstehen", quelle: "1.1.3", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 25* #linebreak()]
Kann ein geschlossenes System Arbeit übertragen? Und ein adiabates?
][
*Kurz gesagt:* Ja. Geschlossen verbietet nur Stofftransport; adiabat verbietet nur Wärmeübertragung.
]

#aufgabe(titel: "Konstantes Volumen und Arbeitsdichtheit", art: "verstehen", quelle: "1.1.3", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 26* #linebreak()]
Was ist der Unterschied zwischen konstantem Volumen und vollständiger Arbeitsdichtheit?
][
*Kurz gesagt:* $dif V=0$ schließt Volumenarbeit aus. Rührer- und elektrische Arbeit müssen zusätzlich ausgeschlossen werden, wenn insgesamt keine Arbeit übertragen werden soll.
]

#aufgabe(titel: "Interne Ströme im Kraftwerk", art: "verstehen", quelle: "1.1.3", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 27* #linebreak()]
Warum sind interne Ströme in der Gesamtbilanz eines Kraftwerks nicht sichtbar?
][
*Kurz gesagt:* Sie verlassen die gemeinsame Bilanzhülle nicht. Eine Abgabe des einen Teils ist die Aufnahme des anderen.
][
*Ausführlich:*

- Wenn ich die Grenze um beide Teilsysteme lege, verlassen diese Ströme die Grenze nie.
- Was das eine Teilsystem abgibt, nimmt das andere auf.
- In der Gesamtbilanz heben sie sich deshalb auf.

#align(center)[#image("abbildungen/boundary.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Innen umgebucht ist außen nicht zugeflossen.
][
*Bild:* Zwei Abteilungen überweisen sich Geld. Für das ganze Unternehmen ist das keine Einnahme von außen.
]

#aufgabe(titel: "Wärmerohr", art: "verstehen", quelle: "1.1.3", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 28* #linebreak()]
Warum kann ein geschlossenes Wärmerohr Wärme transportieren, obwohl seine Gesamtmasse konstant bleibt?
][
*Kurz gesagt:* Am warmen Ende nimmt Verdampfen Energie auf, am kalten gibt Kondensieren sie ab. Dampf und Kondensat zirkulieren *innerhalb* der geschlossenen Grenze. Stationär bleiben Gesamtmasse und gespeicherte Energie konstant; zugeführte und abgegebene Wärme gleichen sich aus.
][
*Ausführlich:*

- Am warmen Ende verdampft das Fluid, am kalten Ende kondensiert es und gibt dort die Verdampfungsenergie ab.
- Die Flüssigkeit läuft in einer Kapillarstruktur zurück.
- Innen zirkuliert Masse, aber über die äußere Grenze geht keine.

#align(center)[#image("abbildungen/heatpipe.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Offen, geschlossen, adiabat, starr, abgeschlossen", art: "verstehen", quelle: "1.1.3", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 29* #linebreak()]
Was bedeuten offen, geschlossen, adiabat, starr und abgeschlossen?
][
*Antwort:*

- *Offen:* Masse darf über die Grenze.
- *Geschlossen:* keine Masse über die Grenze.
- *Adiabat:* keine Wärme über die Grenze, Arbeit bleibt möglich.
- *Starr:* Volumen bleibt gleich, also keine Volumenarbeit.
- *Abgeschlossen:* weder Masse noch Energie über die Grenze.
- Jede Eigenschaft wird einzeln geprüft.
- Aus einem Wort folgen nicht automatisch die anderen.
][
*Merksatz:* Geschlossen sperrt Masse, adiabat sperrt Wärme.
]

#aufgabe(titel: "Starres adiabates Gefäß wird wärmer", art: "verstehen", quelle: "1.1.3", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 30* #linebreak()]
Kann ein geschlossenes, starres, adiabates Gefäß wärmer werden?
][
*Antwort:*

- Ja.
- Geschlossen verbietet nur Stoffaustausch, adiabat nur Wärme, starr nur Volumenarbeit.
- Über einen Heizstab oder Rührer kann trotzdem elektrische oder Wellenarbeit zugeführt werden.
][
*Merksatz:* Keine Wärme heißt nicht: keine Energiezufuhr.
][
*Typische Verwechslung:*

- „Seine innere Energie kann sich nicht ändern.“: Der elektrische Anschluss kann Arbeit zuführen. Adiabat verbietet nur Wärme, starr nur Volumenarbeit.
- „Es ist ein abgeschlossenes System.“: Abgeschlossen hieße: weder Wärme noch Arbeit noch Masse. Die elektrische Arbeit ist hier aber möglich.
]

#aufgabe(titel: "Altklausur WS 05/06: Wärmezufluss zum Ottomotor", art: "rechnen", quelle: "1.1.5", herkunft: "original", minuten: 6, vorlage: "Altklausur WS 05/06, Kurzfrage 12, PDF-S. 2")[
#if not web [*Aufgabe 31* #linebreak()]
*Gegeben:* Ein Ottomotor leistet 100 kW bei Gesamtwirkungsgrad $eta_"ges"="0,25"$. *Gesucht:* erforderlicher Wärmezufluss.
][
*Nutzen auf Aufwand beziehen:* $eta=P/dot(Q)_"zu"$, also $dot(Q)_"zu"=100/"0,25"=400$ kW. Von den 400 kW werden 100 kW zur Nutzleistung; 300 kW bleiben als sonstige Abgabe.
]

#aufgabe(titel: "Altklausur WS 05/06: Wärmezufluss zum Ottomotor (Variante)", art: "rechnen", quelle: "1.1.5", herkunft: "variante", minuten: 6, vorlage: "Altklausur WS 05/06, Kurzfrage 12, PDF-S. 2")[
#if not web [*Aufgabe 32* #linebreak()]
*Von KI erstellt.* *Gegeben:* Derselbe Modellansatz, 90 kW Nutzleistung und Gesamtwirkungsgrad 0,30. *Gesucht:* Wärmezufluss und sonstige Abgabe.
][
*Bilanz:* $dot(Q)_"zu"=90/"0,30"=300$ kW. Sonstige Abgabe: $300-90=210$ kW. Wirkungsgrad ist dimensionslos.
]

#aufgabe(titel: "Altklausur WS 04/05: Kurzfrage 1", art: "verstehen", quelle: "1.2", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 04/05, Kurzfrage 1 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 33* #linebreak()]
Wie lautet die Bedingung für die Eigenschaft „stationär“ als Formel oder in Worten?
][
*Antwort:* Am festgehaltenen Ort gilt $partial (dots)/partial t=0$. Die Speicherterme der Massen- und Energiebilanz verschwinden. Räumliche Unterschiede und durchfließende Stoff-/Energieströme sind weiterhin möglich; stationär bedeutet nicht überall derselbe Zustand.
]

#aufgabe(titel: "Stationär und trotzdem ungleich", art: "verstehen", quelle: "1.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 34* #linebreak()]
Warum kann eine stationäre Strömung räumliche Temperatur- und Geschwindigkeitsunterschiede besitzen?
][
*Kurz gesagt:* Stationär bedeutet zeitlich unverändert am festen Ort. Ein Teilchen kann auf seinem Weg dennoch andere Werte durchlaufen.
]

#aufgabe(titel: "Ideales Gas, ideales Fluid, Beschleunigung", art: "verstehen", quelle: "1.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 35* #linebreak()]
Was unterscheidet ein ideales Gas von einem idealen Fluid? Kann ein stationär strömendes Teilchen beschleunigt sein?
][
*Ideales Gas:* $p v=R T$, veränderliche Dichte erlaubt. *Ideales Fluid in BS:* inkompressibel und reibungsfrei.

Ein Teilchen kann in einer stationären Düse beschleunigen, weil es räumlich verschiedene Geschwindigkeiten durchläuft. Am festen Ort bleiben die Werte zeitlich gleich: *konvektive Beschleunigung*.
][
*Ausführlich:*

- *Stationär heißt nur:* Am festen Ort ändert sich nichts mit der Zeit.
- Ein Teilchen wandert aber von Ort zu Ort, z. B. in einer Düse von einem langsamen in einen schnellen Bereich.
- Es wird also beschleunigt, obwohl das Strömungsbild gleich bleibt.
][
*Ausführlich:*

- *Ideales Gas:* gehorcht $p v = R T$, seine Dichte darf sich ändern.
- *Ideales Fluid (Strömungslehre):* inkompressibel und reibungsfrei.
- Aus der Gasgleichung folgt keine Reibungsfreiheit, das sind zwei verschiedene Modelle.
][
*Merksatz:* Ideales Gas und ideales Fluid sind verschiedene Modellbrillen.
]

#aufgabe(titel: "Gleichgewicht oder stationär", art: "verstehen", quelle: "1.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 36* #linebreak()]
Was ist der Unterschied zwischen Gleichgewicht und stationärem Zustand?
][
*Antwort:*

- *Gleichgewicht:* keine antreibenden Unterschiede; von selbst verändert sich nichts.
- *Stationär:* an einem festen Ort bleiben die Werte zeitlich gleich.
- Trotzdem können ständig Masse und Energie zu- und abfließen.
- *Durchlauferhitzer:* dauerhaft kalter Eintritt, warmer Austritt → stationär, aber kein Gleichgewicht.
][
*Merksatz:* Stationär ist zeitlich gleich; Gleichgewicht ist ohne Antrieb.
][
*Typische Verwechslung:*

- „Gleichgewicht, weil sich nichts mehr ändert“: Im Gleichgewicht gäbe es keinen antreibenden Temperaturunterschied. Hier besteht ein großer Unterschied zwischen Ein- und Austritt.
- „Homogen, weil überall dieselbe Temperatur herrscht“: Die Temperatur ist am Eintritt und Austritt verschieden, also nicht homogen.
]

#aufgabe(titel: "Kurzfrage: Nullter Hauptsatz", art: "verstehen", quelle: "1.3", herkunft: "original", vorlage: "Leistungsnachweis WS 13/14, Kurzfrage 10", minuten: 3)[
#if not web [*Aufgabe 37* #linebreak()]
Wie lautet der nullte Hauptsatz der Thermodynamik?
][
*Antwort:* Stehen zwei Systeme jeweils mit einem dritten im thermischen Gleichgewicht, so stehen sie auch untereinander im thermischen Gleichgewicht. Sie haben dieselbe Temperatur.
][
*Bedeutung:* Erst dieser Satz macht Temperaturmessung möglich: Das Thermometer ist das dritte System, das mit dem Messobjekt ins Gleichgewicht kommt.
]

#aufgabe(titel: "Altklausur WS 00/01: Kurzfrage 5", art: "verstehen", quelle: "1.3", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 00/01, Kurzfrage 5 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 38* #linebreak()]
Wie lautet der nullte Hauptsatz der Thermodynamik?
][
*Antwort:* Sind A und B jeweils mit C im thermischen Gleichgewicht, sind auch A und B miteinander im thermischen Gleichgewicht. Dadurch lässt sich Temperatur als Vergleichsgröße definieren und mit einem Thermometer messen.
]

#aufgabe(titel: "Nullter Hauptsatz und Temperaturmessung", art: "verstehen", quelle: "1.3", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 39* #linebreak()]
Was sagt der nullte Hauptsatz, und warum braucht man ihn zum Temperaturmessen?
][
*Antwort:*

- Sind A und C gleich warm und B und C gleich warm, dann sind auch A und B gleich warm.
- Nur deshalb kann ein Thermometer C Temperaturen vergleichen, ohne dass A und B sich berühren.

#align(center)[#image("abbildungen/expansion.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Ein Thermometer ist der gemeinsame Vergleichspartner.
]

#aufgabe(titel: "Bottich mit genauer Wärmekapazität", art: "rechnen", quelle: "1.3", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.9", minuten: 10)[
#if not web [*Aufgabe 40* #linebreak()]
*Beheizter Bottich, Ü 2.9:*

*Gegeben und Annahmen*

Wasser füllt einen Bottich mit 45 cm × 30 cm × 10 cm. Von 6 auf 86 °C, $rho=1 thin "kg/l"$, Heizleistung 1,8 kW, Verluste und Behälterwärmekapazität vernachlässigt. Die auf 0 °C bezogenen Mittelwerte bei 1 bar sind $C_6="4,21037"$, $C_86="4,18745" thin "kJ/(kg K)"$.

*Gesucht*

#enum(numbering: "a)",
[Bestimme Masse, Energie und Aufheizzeit.],
)
][
Das Volumen ist $V="0,45" times "0,30" times "0,10"="0,0135" thin "m"^3="13,5" thin "l"$. Damit $m="13,5" thin "kg"$. Bei vernachlässigter Verdunstung, Behälterwärmekapazität und Verlusten landet die elektrische Energie im Wasser.

Aus den auf 0 °C bezogenen Mittelwerten:
$ Delta h=("4,18745" times 86-"4,21037" times 6) thin "kJ/kg"="334,85848" thin "kJ/kg" $
$ E approx m Delta h="4520,58948" thin "kJ" $
Mit $P="1,8" thin "kJ/s"$ folgt *$Delta t=E/P approx 2511 thin "s" approx "41,86" thin "min"$*. Zum Vergleich: $overline(c)_(p,12)=Delta h/(80 thin "K") approx "4,18573" thin "kJ/(kg K)"$. Die Watt-Kilowatt-Umrechnung ist entscheidend: Kilojoule durch Kilowatt ergibt Sekunden.
]

#aufgabe(titel: "Kurzfrage: Was spezifische Zustandsgrößen sind", art: "verstehen", quelle: "1.4", herkunft: "original", vorlage: "Leistungsnachweis SS 14, Kurzfrage 7", minuten: 3)[
#if not web [*Aufgabe 41* #linebreak()]
Was sind spezifische Zustandsgrößen: extensive, intensive, thermische, auf die Masse bezogene oder auf die Stoffmenge bezogene Zustandsgrößen?
][
*Antwort:* auf die Masse bezogene Zustandsgrößen, z. B. $v = V\/m$, $u = U\/m$, $h = H\/m$.
][
*Abgrenzung:* Auf die Stoffmenge bezogene heißen molar. Spezifische Größen verhalten sich bei Teilung eines homogenen Systems wie intensive Größen, sind aber aus extensiven Größen abgeleitet.
]

#aufgabe(titel: "Kurzfrage: Welche Größen sich beim Teilen ändern", art: "verstehen", quelle: "1.4", herkunft: "original", vorlage: "Leistungsnachweis WS 13/14, Kurzfrage 3", minuten: 3)[
#if not web [*Aufgabe 42* #linebreak()]
Ein geschlossenes System wird geteilt. Welche Zustandsgrößen ändern ihren Wert: intensive, extensive, molare, spezifische oder keine der genannten?
][
*Antwort:* nur die extensiven, z. B. $m$, $V$, $U$, $H$, $S$. Sie halbieren sich bei Halbierung eines homogenen Systems.
][
*Warum:* Intensive Größen wie $p$ und $T$ sowie spezifische und molare Größen sind Verhältnisse zweier extensiver Größen; Zähler und Nenner halbieren sich gemeinsam.
]

#aufgabe(titel: "Kurzfrage: Intensive und extensive Größen nennen", art: "verstehen", quelle: "1.4", herkunft: "original", vorlage: "Leistungsnachweis WS 19/20, Aufg. 0a", minuten: 3)[
#if not web [*Aufgabe 43* #linebreak()]
Nenne vier intensive und vier extensive Zustandsgrößen mit Einheiten.
][
*Intensiv:* Druck $p$ in Pa, Temperatur $T$ in K, Dichte $rho$ in kg/m³, spezifisches Volumen $v$ in m³/kg (ebenso $u$, $h$, $s$ je kg).
][
*Extensiv:* Masse $m$ in kg, Volumen $V$ in m³, innere Energie $U$ in J, Enthalpie $H$ in J, Entropie $S$ in J/K. Prüfung: Extensive Größen verdoppeln sich, wenn man zwei gleiche Systeme zusammenlegt; intensive bleiben gleich.
]

#aufgabe(titel: "Altklausur WS 05/06: Kurzfrage 2", art: "verstehen", quelle: "1.4", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 05/06, Kurzfrage 2 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 44* #linebreak()]
Nenne je zwei Beispiele mit Einheiten für a) extensive Prozessgrößen, b) intensive Prozessgrößen, c) extensive Zustandsgrößen, d) intensive Zustandsgrößen.
][
*Antwort:* Extensive Prozessgrößen: $Q,W$ in J; spezifische Prozessgrößen: $q,w$ in J/kg (die Vorlage nennt diese „intensiv“). Extensive Zustandsgrößen: $U,H,S,V,m$ in J, J, J/K, m³, kg; intensive Zustandsgrößen z. B. $p,T,rho,u,h$ in Pa, K, kg/m³, J/kg, J/kg; spezifische Zustandsgrößen etwa $u,h,s,v,c_p$ in J/kg, J/kg, J/(kg K), m³/kg, J/(kg K). Beim Teilen eines homogenen Systems ändern sich extensive Größen; intensive, spezifische und molare Zustandsgrößen bleiben gleich. Wärme und Arbeit beschreiben Übertragungen, keine im Zustand gespeicherten Mengen.
]

#aufgabe(titel: "Altklausur WS 04/05: Kurzfrage 2", art: "verstehen", quelle: "1.4", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 04/05, Kurzfrage 2 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 45* #linebreak()]
Nenne je zwei Beispiele mit Einheiten für a) extensive Prozessgrößen, b) intensive Prozessgrößen, c) extensive Zustandsgrößen, d) intensive Zustandsgrößen.
][
*Antwort:* Extensive Prozessgrößen: $Q,W$ in J; spezifische Prozessgrößen: $q,w$ in J/kg (die Vorlage nennt diese „intensiv“). Extensive Zustandsgrößen: $U,H,S,V,m$ in J, J, J/K, m³, kg; intensive Zustandsgrößen z. B. $p,T,rho,u,h$ in Pa, K, kg/m³, J/kg, J/kg; spezifische Zustandsgrößen etwa $u,h,s,v,c_p$ in J/kg, J/kg, J/(kg K), m³/kg, J/(kg K). Beim Teilen eines homogenen Systems ändern sich extensive Größen; intensive, spezifische und molare Zustandsgrößen bleiben gleich. Wärme und Arbeit beschreiben Übertragungen, keine im Zustand gespeicherten Mengen.
]

#aufgabe(titel: "Altklausur WS 03/04: Kurzfrage 1", art: "verstehen", quelle: "1.4", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 03/04, Kurzfrage 1 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 46* #linebreak()]
Wie hängen spezifische und molare Größen zusammen? Gib Formel und Beispiel an.
][
*Antwort:* Eine molare Größe ist die spezifische Größe mal Molmasse: $U_m=M u$, entsprechend $H_m=M h$ oder $V_m=M v$. Beispielsweise kg/kmol mal kJ/kg ergibt kJ/kmol. Nicht mit der gesamten inneren Energie $U=m u=n U_m$ verwechseln.
]

#aufgabe(titel: "Altklausur WS 02/03: Kurzfrage 1", art: "verstehen", quelle: "1.4", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 02/03, Kurzfrage 1 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 47* #linebreak()]
Nenne jeweils fünf thermodynamische Größen mit Einheiten folgender Art: a) intensiv, b) extensiv, c) spezifisch.
][
*Antwort:* Extensive Prozessgrößen: $Q,W$ in J; spezifische Prozessgrößen: $q,w$ in J/kg (die Vorlage nennt diese „intensiv“). Extensive Zustandsgrößen: $U,H,S,V,m$ in J, J, J/K, m³, kg; intensive Zustandsgrößen z. B. $p,T,rho,u,h$ in Pa, K, kg/m³, J/kg, J/kg; spezifische Zustandsgrößen etwa $u,h,s,v,c_p$ in J/kg, J/kg, J/(kg K), m³/kg, J/(kg K). Beim Teilen eines homogenen Systems ändern sich extensive Größen; intensive, spezifische und molare Zustandsgrößen bleiben gleich. Wärme und Arbeit beschreiben Übertragungen, keine im Zustand gespeicherten Mengen.
]

#aufgabe(titel: "Altklausur WS 01/02: Kurzfrage 2", art: "verstehen", quelle: "1.4", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 01/02, Kurzfrage 2 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 48* #linebreak()]
Nenne intensive Zustandsgrößen und extensive Prozessgrößen.
][
*Antwort:* Extensive Prozessgrößen: $Q,W$ in J; spezifische Prozessgrößen: $q,w$ in J/kg (die Vorlage nennt diese „intensiv“). Extensive Zustandsgrößen: $U,H,S,V,m$ in J, J, J/K, m³, kg; intensive Zustandsgrößen z. B. $p,T,rho,u,h$ in Pa, K, kg/m³, J/kg, J/kg; spezifische Zustandsgrößen etwa $u,h,s,v,c_p$ in J/kg, J/kg, J/(kg K), m³/kg, J/(kg K). Beim Teilen eines homogenen Systems ändern sich extensive Größen; intensive, spezifische und molare Zustandsgrößen bleiben gleich. Wärme und Arbeit beschreiben Übertragungen, keine im Zustand gespeicherten Mengen.
]

#aufgabe(titel: "Altklausur WS 99/00 PF: Kurzfrage 1", art: "verstehen", quelle: "1.4", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 99/00 PF, Kurzfrage 1 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 49* #linebreak()]
Ein geschlossenes System wird geteilt. Welche Zustandsgrößen ändern ihren Wert und warum?
][
*Antwort:* Extensive Prozessgrößen: $Q,W$ in J; spezifische Prozessgrößen: $q,w$ in J/kg (die Vorlage nennt diese „intensiv“). Extensive Zustandsgrößen: $U,H,S,V,m$ in J, J, J/K, m³, kg; intensive Zustandsgrößen z. B. $p,T,rho,u,h$ in Pa, K, kg/m³, J/kg, J/kg; spezifische Zustandsgrößen etwa $u,h,s,v,c_p$ in J/kg, J/kg, J/(kg K), m³/kg, J/(kg K). Beim Teilen eines homogenen Systems ändern sich extensive Größen; intensive, spezifische und molare Zustandsgrößen bleiben gleich. Wärme und Arbeit beschreiben Übertragungen, keine im Zustand gespeicherten Mengen.
]

#aufgabe(titel: "Altklausur Übungsklausur WS 99/00: Kurzfrage 1", art: "verstehen", quelle: "1.4", herkunft: "original", minuten: 3, vorlage: "Altklausur Übungsklausur WS 99/00, Kurzfrage 1 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 50* #linebreak()]
Ordne Druck, Wärme, Enthalpie, Arbeit und Volumen den kalorischen Zustandsgrößen, thermischen Zustandsgrößen oder „keine Zustandsgröße“ zu.
][
*Antwort:* Thermische Zustandsgrößen: Druck und Volumen. Kalorische Zustandsgröße: Enthalpie. Keine Zustandsgrößen: Wärme und Arbeit, denn sie beschreiben Energieübertragungen auf einem Prozessweg.
]

#aufgabe(titel: "Extensiv, intensiv, spezifisch", art: "verstehen", quelle: "1.4", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 51* #linebreak()]
Erkläre extensiv, intensiv und spezifisch am Beispiel eines geteilten Wasserbehälters.
][
*Kurz gesagt:* Gesamtmasse und Gesamtvolumen halbieren sich. Dichte, Temperatur und spezifisches Volumen bleiben bei Teilung eines homogenen Zustands gleich.
][
*Ausführlich:*

- *Teilungstest:* Ich teile einen homogenen Behälter gedanklich in zwei Hälften.
- *Extensiv* (m, V, U, H): halbiert sich, hängt an der Menge.
- *Intensiv* ($p$, $T$, $rho$): bleibt gleich.
- *Spezifisch* ($v = V\/m$, $u$, $h$): Größe pro kg.
- Bleibt auch gleich, weil Zähler und Nenner gleich schrumpfen.
- Spezifische Größen trennen die Stoffeigenschaft von der Menge.

#align(center)[#image("abbildungen/division.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Extensiv zählt die Menge, spezifisch zählt je Kilogramm.
][
*Bild:* Zwei gleiche Wasserportionen: doppelte Masse und Energie, aber dieselbe Temperatur.
]

#aufgabe(titel: "Molmassen von SF6 und Tetrafluordichlorethan", art: "rechnen", quelle: "1.4", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.7", minuten: 5,
  ergebnis: [$M_("SF"_6) approx "146,05" thin "kg/kmol"$; $M_("C"_2"F"_4"Cl"_2) approx "170,91" thin "kg/kmol"$])[
#if not web [*Aufgabe 52* #linebreak()]
*Gegeben und Annahmen*

Molare Massen der Elemente in kg/kmol: $M_"S" = "32,06"$, $M_"F" = "18,998"$, $M_"C" = "12,011"$, $M_"Cl" = "35,45"$.

*Gesucht*

#enum(numbering: "a)",
[Bestimme die Molmassen der chemischen Verbindungen Schwefelhexafluorid (SF#sub[6]) und Tetrafluordichlorethan (CF#sub[2]Cl–CF#sub[2]Cl).],
)
][
*Prinzip:* Die molare Masse einer Verbindung ist die Summe der molaren Massen aller Atome in einem Molekül. Ein Kilomol Moleküle enthält von jeder Atomsorte so viele Kilomol, wie die Formel angibt.
][
*SF#sub[6]:* ein Schwefel- und sechs Fluoratome:
$ M = "32,06" + 6 dot "18,998" approx "146,05" thin "kg/kmol" $
*CF#sub[2]Cl–CF#sub[2]Cl* = C#sub[2]F#sub[4]Cl#sub[2]: zwei C, vier F, zwei Cl:
$ M = 2 dot "12,011" + 4 dot "18,998" + 2 dot "35,45" approx "170,91" thin "kg/kmol" $
Beide Gase sind rund fünf- bis sechsmal so schwer wie Luft ($"28,96" thin "kg/kmol"$); ihre spezifische Gaskonstante $R = R_m\/M$ ist entsprechend klein.
]

#aufgabe(titel: "Molmassen von Propan und R134a (Variante)", art: "rechnen", quelle: "1.4", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.7", minuten: 5,
  ergebnis: [$M_("C"_3"H"_8) approx "44,10" thin "kg/kmol"$, $R approx "188,5" thin "J/(kg K)"$; $M_"R134a" approx "102,03" thin "kg/kmol"$, $R approx "81,5" thin "J/(kg K)"$])[
#if not web [*Aufgabe 53* #linebreak()]
*Gegeben und Annahmen*

$M_"C" = "12,011"$, $M_"H" = "1,008"$, $M_"F" = "18,998" thin "kg/kmol"$; $R_m = "8314,3" thin "J/(kmol K)"$.

*Gesucht*

#enum(numbering: "a)",
[Die molaren Massen von Propan (C#sub[3]H#sub[8]) und dem Kältemittel R134a (CH#sub[2]F–CF#sub[3]).],
[Die spezifischen Gaskonstanten beider Stoffe.],
)
][
*Atome zählen:* Propan hat 3 C und 8 H, R134a = C#sub[2]H#sub[2]F#sub[4] hat 2 C, 2 H und 4 F:
$ M_("C"_3"H"_8) = 3 dot "12,011" + 8 dot "1,008" approx "44,10" thin "kg/kmol" $
$ M_"R134a" = 2 dot "12,011" + 2 dot "1,008" + 4 dot "18,998" approx "102,03" thin "kg/kmol" $
][
*Gaskonstanten:* $R = R_m\/M$:
$ R_("C"_3"H"_8) = "8314,3"/"44,10" approx "188,5" thin "J/(kg K)" quad quad R_"R134a" = "8314,3"/"102,03" approx "81,5" thin "J/(kg K)" $
Je schwerer das Molekül, desto kleiner die spezifische Gaskonstante: Ein Kilogramm enthält weniger Moleküle.
]

#aufgabe(titel: "Kurzfrage: Energieformen der Bernoulli-Gleichung", art: "verstehen", quelle: "1.5", herkunft: "original", vorlage: "Leistungsnachweis SS 13, Kurzfrage 2", minuten: 3)[
#if not web [*Aufgabe 54* #linebreak()]
Welche Energieformen berücksichtigt die Bernoulli-Gleichung?
][
*Antwort:* Druckenergie $p$, kinetische Energie $rho w^2\/2$ und potentielle Energie $rho g z$, jeweils je Volumen. Entlang eines Stromfadens bleibt ihre Summe für ein reibungsfreies, inkompressibles, stationär strömendes Fluid konstant.
][
*Was fehlt:* Innere Energie und Wärme kommen nicht vor. Temperaturänderungen und Reibungswärme erfasst erst der erste Hauptsatz mit der Enthalpie.
]

#aufgabe(titel: "Kurzfrage: Prinzip hinter der Kontinuitätsgleichung", art: "verstehen", quelle: "1.5", herkunft: "original", vorlage: "Leistungsnachweis WS 13/14, Kurzfrage 13", minuten: 3)[
#if not web [*Aufgabe 55* #linebreak()]
Welches physikalische Prinzip steckt in der Kontinuitätsgleichung?
][
*Antwort:* die Massenerhaltung. Stationär gilt $dot(m) = rho A w = "konst."$ entlang der Strömung.
][
*Folge:* Bei konstanter Dichte wird ein Fluid im engeren Querschnitt schneller, $A_1 w_1 = A_2 w_2$.
]

#aufgabe(titel: "Kontinuität an der Düse", art: "verstehen", quelle: "1.5", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 56* #linebreak()]
Was sagt die Kontinuitätsgleichung, und warum wird Wasser in einer engen Düse schneller?
][
*Antwort:*

- Stationär ohne weitere Zu- oder Abflüsse geht durch jeden Querschnitt dieselbe Masse pro Sekunde: $rho A c = "konstant"$.
- Bei konstanter Dichte heißt das $A c = "konstant"$.
- Wird die Fläche kleiner, muss die Geschwindigkeit steigen.
- Halber Durchmesser gibt ein Viertel der Fläche und die vierfache Geschwindigkeit.

#align(center)[#image("abbildungen/hose.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Bei gleicher Dichte: engerer Querschnitt, höheres Tempo.
][
*Bild:* Gartenschlauch mit Daumen auf der Öffnung.
]

#aufgabe(titel: "Bernoulli-Gleichung und ihre Grenzen", art: "verstehen", quelle: "1.5", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 57* #linebreak()]
Was beschreibt die Bernoulli-Gleichung, und wann gilt sie?
][
*Antwort:*

- $p/rho + c^2/2 + g z = "konstant"$.
- Entlang einer Stromlinie tauschen Druck-, Bewegungs- und Lageenergie untereinander aus.
- Sie gilt nur stationär, inkompressibel, reibungsfrei und ohne Maschinenarbeit.

#align(center)[#image("abbildungen/bernoulli.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Bild:* Ein Wasserbehälter: Die Höhe des Wasserspiegels wird am Auslass zu Geschwindigkeit ($c = sqrt(2 g h)$).
]

#aufgabe(titel: "Behälter leert sich immer langsamer", art: "verstehen", quelle: "1.5", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 58* #linebreak()]
Warum fließt die erste Hälfte eines Behälters schneller aus als die zweite?
][
*Antwort:*

- Die Ausflussgeschwindigkeit hängt von der Füllhöhe ab ($c approx sqrt(2 g h)$).
- Am Anfang drückt eine hohe Wassersäule, später nur noch eine niedrige.
- Der Ausfluss wird also immer langsamer, und die Kurve $h(t)$ flacht ab.

#align(center)[#image("abbildungen/drain-plot.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Halber Rohrdurchmesser", art: "rechnen", quelle: "1.5", herkunft: "eigen", minuten: 3,
  ergebnis: [Die Geschwindigkeit wird viermal so groß.],
)[
#if not web [*Aufgabe 59* #linebreak()]
*Gegeben und Annahmen*

Bei stationärer inkompressibler Strömung halbiert sich der Rohrdurchmesser.

*Gesucht*

#enum(numbering: "a)",
[Wie ändert sich die mittlere Geschwindigkeit?],
)
][
*Kontinuität:* Stationär und inkompressibel heißt: Was vorne hineinfließt, muss hinten heraus. Der Volumenstrom $dot(V) = A c$ bleibt überall gleich.
][
*Fläche:* $A = pi d^2\/4$. Halber Durchmesser ergibt $(1\/2)^2 = 1\/4$ der Fläche.
][
*Geschwindigkeit:* Durch ein Viertel der Fläche muss derselbe Volumenstrom, also $c_2 = 4 c_1$.
][
*Prüfen:* Gartenschlauch: Daumen auf die Öffnung, und das Wasser spritzt schneller.
][
*Typische Verwechslung:*

- „Sie verdoppelt sich.“: Das gälte, wenn die Fläche linear mit dem Durchmesser ginge. Sie geht aber mit $d^2$.
- „Sie halbiert sich.“: Im engeren Querschnitt muss dieselbe Masse pro Sekunde durch, also schneller, nicht langsamer.
- „Sie bleibt gleich, nur der Druck ändert sich.“: Die Kontinuität verlangt eine höhere Geschwindigkeit. Dass sich auch der Druck ändert, beschreibt Bernoulli zusätzlich.
]

#aufgabe(titel: "Verdampfer: Masse bleibt, Volumenstrom wächst", art: "rechnen", quelle: "1.5", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 1.14 a–c3", minuten: 15)[
#if not web [*Aufgabe 60* #linebreak()]
*Verdampfer, Auszug aus Ü 1.14 a–b und c.1–3:*

*Gegeben und Annahmen*

R134a strömt mit $A_1="0,76" thin "cm"^2$ und $c_1="0,035" thin "m/s"$ als Flüssigkeit ein. Nutze $v_1 approx "0,0007" thin "m"^3/"kg"$. Am Austritt: $A_2="3,04" thin "cm"^2$, $x_2="0,88"$, $v'_2="0,0007"$, $v''_2="0,1205" thin "m"^3/"kg"$ aus BT.

*Gesucht*

#enum(numbering: "a)",
[Berechne Massenstrom, Austrittsgeschwindigkeit sowie die beiden Phasenvolumenströme. Modell: gemeinsame mittlere Phasengeschwindigkeit.],
)
][
*Methode:* Am Eintritt bestimmen wir aus Fläche, Geschwindigkeit und spezifischem Volumen den Massenstrom. Stationär bleibt dieser erhalten. Am Austritt verwenden wir die Nassdampfmischung.

$ A_1="0,76" times 10^(-4) thin "m"^2 quad quad A_2="3,04" times 10^(-4) thin "m"^2 $
$ dot(m)=A_1 c_1/v_1="0,0038" thin "kg/s" $
$ v_2=v'_2+x_2(v''_2-v'_2)="0,0007"+"0,88"("0,1205"-"0,0007")="0,106124" thin "m"^3/"kg" $
$ c_2=dot(m)v_2/A_2 approx "1,327" thin "m/s" $
Die Teilvolumenströme sind:
$ dot(V)''_2=x_2 dot(m)v''_2 approx "0,000402952" thin "m"^3/"s" $
$ dot(V)'_2=(1-x_2)dot(m)v'_2 approx "0,0000003192" thin "m"^3/"s" $
Ihre Summe beträgt $"0,0004032712" thin "m"^3/"s"$, rund 0,4033 l/s. Trotz größerer Austrittsfläche steigt die Geschwindigkeit gegenüber 0,035 m/s stark, weil das Verdampfen das spezifische Volumen noch stärker erhöht. Am Eintritt wird $v_1$ nach dem Buchbeispiel durch den Flüssigkeits-Sättigungswert gleicher Temperatur angenähert; das ist keine Anwendung der idealen Gasgleichung auf Flüssigkeit.
]

#aufgabe(titel: "Behälter durch eine Bodenöffnung entleeren", art: "rechnen", quelle: "1.5", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 1.5", minuten: 25,
  ergebnis: [$w_0=sqrt(2 g (h-h_0))$ (Torricelli); $t approx 3218 thin "s" approx "53,6" thin "min"$; $t_(1\/2) approx 943 thin "s" approx "15,7" thin "min"$],
  tipp: [Welche Energie hat ein Teilchen am Wasserspiegel, welche im Austrittsstrahl? Danach: Was fließt pro Sekunde aus, und um wie viel sinkt dabei der Spiegel?])[
#if not web [*Aufgabe 61* #linebreak()]
*Gegeben und Annahmen*

Ein zylindrischer, oben offener, mit Wasser der Dichte $rho_W$ gefüllter Behälter (Durchmesser $D = 1 thin "m"$, Spiegelhöhe $H = "1,25" thin "m"$) soll durch Öffnen eines kreisförmigen Verschlusses (Durchmesser $d = "12,5" thin "mm"$, Höhe $h_0 = 10 thin "mm"$ über dem Behälterboden) in die Umgebung (Luftdichte $rho_L$) entleert werden. Auf dem Spiegel und am Austritt herrscht der Umgebungsdruck. Die Strömung ist reibungsfrei und quasistationär; $g = "9,81" thin "m/s"^2$.

*Gesucht*

#enum(numbering: "a)",
[Leite aus energetischen Überlegungen eine Gleichung (1) für die Ausflussgeschwindigkeit $w_0$ in Abhängigkeit der Spiegelhöhe $h$ und anderer maßgeblicher Parameter ab.],
[Vereinfache Gl. (1) unter den Bedingungen $h_0 << H$, $d << D$ und $rho_L << rho_W$. Welche aus der Strömungsmechanik bekannte Gleichung (2) erhältst du?],
[Berechne mithilfe einer Massenbilanz und Gl. (2) die Zeit $t$, bis der Behälter entleert ist.],
[Welche Zeit $t_(1\/2)$ vergeht, bis der Behälter zur Hälfte entleert ist? Interpretiere das Ergebnis.],
)
][
*Energiebilanz entlang des Weges vom Spiegel zur Öffnung:* Ein Wasserteilchen am Spiegel (Höhe $h$, Geschwindigkeit $w$) gelangt zur Öffnung (Höhe $h_0$, Geschwindigkeit $w_0$). Reibungsfrei und stationär gilt Bernoulli. Der Druck am Spiegel ist $p_infinity$; am Austritt herrscht der Umgebungsdruck in der Höhe $h_0$. Weil die Luftsäule außen vom Spiegel bis zur Öffnung um $rho_L g (h-h_0)$ schwerer drückt, ist der Außendruck an der Öffnung $p_infinity + rho_L g (h-h_0)$:
$ p_infinity + rho_W/2 w^2 + rho_W g h = p_infinity + rho_L g (h-h_0) + rho_W/2 w_0^2 + rho_W g h_0 $
Mit der Kontinuität $w A = w_0 A_0$, also $w = w_0 (d\/D)^2$:
$ w_0 = sqrt((2 g (h-h_0)(1 - rho_L\/rho_W))/(1-(d\/D)^4)) quad "(1)" $
][
*Vereinfachen:* Bei $d << D$ wird $(d\/D)^4 approx 0$, bei $rho_L << rho_W$ wird $rho_L\/rho_W approx 0$, bei $h_0 << H$ darf man $h-h_0 approx h$ setzen:
$ w_0 = sqrt(2 g h) quad "(2)" $
Das ist die *Ausflussformel von Torricelli*: Das Wasser tritt so schnell aus, als wäre es frei aus der Höhe $h$ gefallen. Für die Zahlenrechnung behalten wir $h - h_0$ bei, denn ganz entleert ist der Behälter nur bis zur Öffnung.
][
*Massenbilanz:* Was durch die Öffnung austritt, fehlt im Behälter:
$ rho_W A (dif h)/(dif t) = - rho_W A_0 w_0 = - rho_W A_0 sqrt(2 g (h-h_0)) $
Trennen der Veränderlichen und Integrieren von $h = H$ bis $h = h_0$:
$ t = A/A_0 sqrt(2/g) sqrt(H-h_0) = (D/d)^2 sqrt((2(H-h_0))/g) $
$ (D/d)^2 = (1000/"12,5")^2 = 6400 quad quad sqrt((2 dot "1,24")/"9,81") = "0,5028" thin "s" $
$ t approx 3218 thin "s" approx "53,6" thin "min" $
][
*Halbe Entleerung:* Das ablassbare Volumen liegt zwischen $H$ und $h_0$. Halb leer ist der Behälter bei $h - h_0 = (H-h_0)\/2$:
$ t_(1\/2) = A/A_0 sqrt(2/g)(sqrt(H-h_0) - sqrt((H-h_0)/2)) = t (1 - 1/sqrt(2)) approx "0,293" thin t approx 943 thin "s" approx "15,7" thin "min" $
*Deutung:* Die erste Hälfte fließt in knapp 30 % der Zeit aus. Bei hohem Spiegel ist der Druck an der Öffnung groß und der Strahl schnell; je tiefer der Spiegel, desto langsamer der Ausfluss. Darum dauert die zweite Hälfte mehr als doppelt so lang.
]

#aufgabe(titel: "Behälter entleeren mit kleinerer Öffnung (Variante)", art: "rechnen", quelle: "1.5", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 1.5", minuten: 15,
  ergebnis: [$w_0(H) approx "4,41" thin "m/s"$; $t approx 2875 thin "s" approx "47,9" thin "min"$; $t_(1\/2) approx 842 thin "s" approx "14,0" thin "min"$])[
#if not web [*Aufgabe 62* #linebreak()]
*Gegeben und Annahmen*

Ein oben offener Zylinder ($D = "0,8" thin "m"$) ist bis $H = "1,0" thin "m"$ mit Wasser gefüllt. In $h_0 = 10 thin "mm"$ Höhe über dem Boden wird eine kreisrunde Öffnung mit $d = 10 thin "mm"$ geöffnet. Reibungsfrei, quasistationär, $d << D$, Luftdichte vernachlässigbar, $g = "9,81" thin "m/s"^2$.

*Gesucht*

#enum(numbering: "a)",
[Die Ausflussgeschwindigkeit unmittelbar nach dem Öffnen.],
[Die Zeit, bis der Behälter bis zur Öffnung entleert ist.],
[Die Zeit, bis die Hälfte des ablassbaren Wassers ausgeflossen ist.],
)
][
*Torricelli am Anfang:* Bernoulli vom Spiegel zur Öffnung mit $w approx 0$ am Spiegel ($d << D$) gibt
$ w_0 = sqrt(2 g (H - h_0)) = sqrt(2 dot "9,81" dot "0,99") approx "4,41" thin "m/s" $
][
*Massenbilanz integrieren:* $A thin dif h\/dif t = -A_0 sqrt(2 g (h-h_0))$ liefert
$ t = (D/d)^2 sqrt((2 (H-h_0))/g) = 80^2 dot sqrt((2 dot "0,99")/"9,81") = 6400 dot "0,4493" thin "s" approx 2875 thin "s" approx "47,9" thin "min" $
Das Flächenverhältnis $(D\/d)^2$ bestimmt die Zeit: Eine viermal kleinere Öffnungsfläche hieße viermal so lange.
][
*Halbe Menge:* Bei $h - h_0 = (H-h_0)\/2$ gilt
$ t_(1\/2) = t (1 - 1/sqrt(2)) approx 842 thin "s" approx "14,0" thin "min" $
Wie im Original fließt die erste Hälfte in rund 29 % der Gesamtzeit aus, weil der treibende Wasserdruck mit dem Spiegel abnimmt.
]

#aufgabe(titel: "Gartenschlauch und Düse", art: "rechnen", quelle: "1.5", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 1.7", minuten: 8)[
#if not web [*Aufgabe 63* #linebreak()]
*Gartenschlauch, Ü 1.7:*

*Gegeben und Annahmen*

25 l füllen einen Eimer in 50 s. Der Schlauchdurchmesser beträgt 20 mm, die Düsenöffnung 8 mm.

*Gesucht*

#enum(numbering: "a)",
[Bestimme Volumenstrom und beide Geschwindigkeiten.],
[Wie lange dauert das Füllen mit einem anderen Schlauch bei $dot(m)="0,2" thin "kg/s"$? Nutze $rho=1000 thin "kg/m"^3$.],
)
][
*Strategie:* Füllmenge / Zeit liefert den Volumenstrom; dann $c=dot(V)/A$.
$ dot(V)=25/50 thin "l/s"="0,5" thin "l/s"=5 times 10^(-4) thin "m"^3/"s" $
$ A_1=pi ("0,020" thin "m")^2/4="3,1416" times 10^(-4) thin "m"^2 $
$ A_2=pi ("0,008" thin "m")^2/4="5,0265" times 10^(-5) thin "m"^2 $
Somit *$c_1="1,59" thin "m/s"$* und *$c_2="9,95" thin "m/s"$*.

Anderer Schlauch: $dot(V)=dot(m)/rho="0,2" thin "l/s"$, also *$t=25/"0,2"=125 thin "s"$*. Die größere Geschwindigkeit in der Düse passt zum kleineren Querschnitt bei vorgegebenem Volumenstrom.
]

#aufgabe(titel: "Gartenschlauch mit engerer Düse (Variante)", art: "rechnen", quelle: "1.5", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 1.7", minuten: 6,
  ergebnis: [$dot(V) = "0,4" thin "l/s"$; $c_1 approx "1,99" thin "m/s"$; $c_2 approx "14,1" thin "m/s"$; $t approx "33,3" thin "s"$])[
#if not web [*Aufgabe 64* #linebreak()]
*Gegeben und Annahmen*

Ein Schlauch mit 16 mm Innendurchmesser füllt eine 10-l-Gießkanne in 25 s. Die Düse am Ende hat 6 mm Öffnung. Wasser: $rho = 1000 thin "kg/m"^3$.

*Gesucht*

#enum(numbering: "a)",
[Volumenstrom und mittlere Geschwindigkeiten in Schlauch und Düse.],
[Füllzeit mit einem Schlauch, der $dot(m) = "0,3" thin "kg/s"$ liefert.],
)
][
*Volumenstrom und Geschwindigkeiten:* $dot(V) = 10\/25 = "0,4" thin "l/s" = 4 times 10^(-4) thin "m"^3/"s"$. $c_1 = dot(V)\/(pi dot "0,016"^2\/4) approx "1,99" thin "m/s"$, $c_2 = dot(V)\/(pi dot "0,006"^2\/4) approx "14,1" thin "m/s"$.
][
*Anderer Schlauch:* $dot(V) = "0,3" thin "l/s"$, also $t = 10\/"0,3" approx "33,3" thin "s"$.
]

#aufgabe(titel: "Kurzfrage: Druck, Wärme, Entropie, Arbeit, Volumen einordnen", art: "verstehen", quelle: "1.6", herkunft: "original", vorlage: "Leistungsnachweis SS 13, Kurzfrage 12", minuten: 3)[
#if not web [*Aufgabe 65* #linebreak()]
Ordne Druck, Wärme, Entropie, Arbeit und Volumen ein: thermische Zustandsgröße, kalorische Zustandsgröße oder keine Zustandsgröße?
][
*Antwort:* thermisch: Druck, Volumen. Kalorisch: Entropie. Keine Zustandsgröße: Wärme und Arbeit.
][
*Warum:* Thermische Zustandsgrößen sind direkt messbar ($p$, $v$, $T$). Kalorische ($u$, $h$, $s$) werden aus ihnen berechnet. Wärme und Arbeit hängen vom Prozessweg ab; sie sind Prozessgrößen, keine Eigenschaften eines Zustands.
]

#aufgabe(titel: "Kurzfrage: Zustandsgrößen zuordnen", art: "verstehen", quelle: "1.6", herkunft: "original", vorlage: "Leistungsnachweis WS 13/14, Kurzfrage 1", minuten: 3)[
#if not web [*Aufgabe 66* #linebreak()]
Ordne zu, welche Größen thermische oder kalorische Zustandsgrößen sind: $Q$ [kJ], $s$ [kJ/(kg K)], $T$ [°C], $v$, $U$ [kJ], $w_t$ [kJ/kg].
][
*Antwort:* thermisch: $T$ und $v$. Kalorisch: $s$ und $U$. Keine Zustandsgrößen: $Q$ und $w_t$.
][
*Achtung bei der Einheit:* Das spezifische Volumen hat die Einheit m³/kg; kg/m³ wäre die Dichte (ebenfalls thermisch). Wärme und technische Arbeit sind Prozessgrößen.
]

#aufgabe(titel: "Kurzfrage: Arbeit und Wärme vergleichen", art: "verstehen", quelle: "1.6", herkunft: "original", vorlage: "Leistungsnachweis WS 19/20, Aufg. 0b", minuten: 3)[
#if not web [*Aufgabe 67* #linebreak()]
Was haben Arbeit und Wärme gemeinsam, was unterscheidet sie?
][
*Gemeinsam:* Beide sind Prozessgrößen. Sie beschreiben Energie, die während eines Prozesses über die Systemgrenze übertragen wird, Einheit J; keines von beiden ist im System gespeichert.
][
*Unterschied:* Wärme wird allein durch einen Temperaturunterschied übertragen und trägt Entropie mit. Arbeit wird durch andere Ursachen (Kräfte, Volumenänderung, Welle, Strom) übertragen und trägt keine Entropie. Arbeit lässt sich vollständig in Wärme umwandeln, Wärme nicht vollständig in Arbeit.
]

#aufgabe(titel: "Altklausur WS 03/04: Kurzfrage 2", art: "verstehen", quelle: "1.6", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 03/04, Kurzfrage 2 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 68* #linebreak()]
Was versteht man unter a) Zustandsgrößen und b) Prozessgrößen?
][
*Antwort:* Zustandsgrößen hängen vom aktuellen Zustand ab (z. B. p,T,U,H,S). Ihre Differenz wird allein durch Anfang und Ende festgelegt. Prozessgrößen beschreiben Übertragungen auf einem Weg (z. B. Q,W); zwei Wege zwischen denselben Zuständen können unterschiedliche Werte liefern.
]

#aufgabe(titel: "Altklausur WS 00/01: Kurzfrage 4", art: "verstehen", quelle: "1.6", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 00/01, Kurzfrage 4 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 69* #linebreak()]
Erläutere die Begriffe Zustandsgröße, Prozessgröße, intensive Zustandsgröße und extensive Zustandsgröße.
][
*Antwort:* Zustandsgrößen hängen vom aktuellen Zustand ab (z. B. p,T,U,H,S). Ihre Differenz wird allein durch Anfang und Ende festgelegt. Prozessgrößen beschreiben Übertragungen auf einem Weg (z. B. Q,W); zwei Wege zwischen denselben Zuständen können unterschiedliche Werte liefern. Intensive Zustandsgrößen wie p und T bleiben beim Teilen eines homogenen Systems gleich; extensive wie U, H, S, V und m ändern sich mit der betrachteten Systemgröße.
]

#aufgabe(titel: "Zustandsgröße und Prozessgröße", art: "verstehen", quelle: "1.6", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 70* #linebreak()]
Warum ist der Druck eine Zustandsgröße und die Arbeit eine Prozessgröße?
][
*Kurz gesagt:* Der Druckunterschied zwischen zwei Zuständen hängt nur von deren Werten ab. Die Arbeit hängt zusätzlich vom Prozessweg ab, also von der Fläche unter der Kurve.
][
*Ausführlich:*

- Zustandsgrößen ($p$, $T$, $U$, $H$) beschreiben eine Momentaufnahme.
- Ihre Änderung hängt nur von Anfang und Ende ab, nicht vom Weg.
- Prozessgrößen (Wärme Q, Arbeit W) gibt es nur während eines Vorgangs.
- Sie hängen vom Weg ab.

#align(center)[#image("abbildungen/states.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Zustand: Wo bin ich? Prozess: Wie kam ich dorthin?
][
*Bild:* Der Höhenunterschied zwischen Tal und Gipfel ist fest. Wie weit ich laufe, hängt vom Weg ab.
]

#aufgabe(titel: "Was sich im Kreisprozess ändert", art: "verstehen", quelle: "1.6", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 71* #linebreak()]
Was ändert sich im Kreisprozess, und was nicht?
][
*Antwort:*

- Alle Zustandsgrößen kehren zum Anfangswert zurück, ihre Gesamtänderung ist null.
- Trotzdem kann netto Wärme aufgenommen und Arbeit abgegeben werden.
- Genau so funktioniert eine Wärmekraftmaschine.

#align(center)[#image("abbildungen/states.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Der Zustand kommt zurück, die Übertragungen können bleiben.
][
*Bild:* Eine Rundfahrt endet am Start; der verbrauchte Treibstoff kommt dadurch nicht zurück.
]

#aufgabe(titel: "Kurzfrage: Gaskonstante von Helium", art: "verstehen", quelle: "1.6.1", herkunft: "original", vorlage: "Leistungsnachweis SS 14, Kurzfrage 13", minuten: 3)[
#if not web [*Aufgabe 72* #linebreak()]
Welchen Wert hat näherungsweise die spezifische Gaskonstante von Helium ($M_"He" = 4 thin "kg/kmol"$): 0,48, 0,287 oder 2,08 kJ/(kg K)? Begründe.
][
*Rechnung:* $R = R_m\/M = "8,314"\/4 thin "kJ/(kg K)" approx "2,08" thin "kJ/(kg K)"$.
][
*Typische Verwechslung:* 0,287 kJ/(kg K) gehört zu Luft ($M approx 29$). Leichte Moleküle haben eine große spezifische Gaskonstante, weil ein Kilogramm sehr viele Moleküle enthält.
]

#aufgabe(titel: "Kurzfrage: Ideale Gasgleichung in differenzieller Form", art: "verstehen", quelle: "1.6.1", herkunft: "original", vorlage: "Leistungsnachweis WS 11/12, Aufg. 0a", minuten: 3)[
#if not web [*Aufgabe 73* #linebreak()]
Leite für die ideale Gasgleichung die differenzielle Form aus der extensiven Form her. Nimm konstante Systemmasse an.
][
*Ausgangspunkt:* $p V = m R T$ mit $m, R = "konst."$
][
*Differenzieren:* Produktregel links: $p thin dif V + V thin dif p = m R thin dif T$. Teilt man durch $p V = m R T$, folgt die logarithmische Form $(dif p)\/p + (dif V)\/V = (dif T)\/T$. Sie zeigt, wie kleine relative Änderungen von Druck und Volumen die Temperatur ändern.
]

#aufgabe(titel: "Zwei Angaben für den Zustand", art: "verstehen", quelle: "1.6.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 74* #linebreak()]
Wie viele Angaben legen den Zustand eines einfachen reinen Stoffes fest?
][
*Antwort:*

- Im einphasigen Gleichgewicht reichen zwei unabhängige intensive Angaben, z. B. $p$ und $T$.
- Die Zustandsfläche ist die Landkarte aller erlaubten Kombinationen, z. B. $p = p(v, T)$.
]

#aufgabe(titel: "Grenzen des idealen Gasmodells", art: "verstehen", quelle: "1.6.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 75* #linebreak()]
Wann gilt das ideale Gasmodell nicht mehr gut?
][
*Antwort:*

- Es vernachlässigt das Eigenvolumen der Moleküle und ihre Anziehung.
- Bei hoher Dichte oder nahe der Kondensation wird das spürbar.
- Verdünnter Dampf kann dagegen näherungsweise ideal sein.
]

#aufgabe(titel: "Luft im starren Behälter erwärmen", art: "rechnen", quelle: "1.6.1", herkunft: "eigen", minuten: 8,
  ergebnis: [$m approx "11,88" thin "kg"$, $p_2 approx "6,02" thin "bar"$ absolut],
  tipp: [Die ideale Gasgleichung braucht Kelvin und Pascal. Im starren Behälter bleiben Masse und Volumen gleich.],
)[
#if not web [*Aufgabe 76* #linebreak()]
*Gegeben und Annahmen*

Luft: $V=2 thin "m"^3$, $p_1=5 thin "bar"$ absolut, $theta_1=20 thin "°C"$, $R="287,2" thin "J/(kg K)"$.

*Gesucht*

#enum(numbering: "a)",
[Bestimme die Masse. Der geschlossene starre Behälter wird auf $80 thin "°C"$ erwärmt.],
[Bestimme $p_2$.],
)
][
*Einheiten vorbereiten:* Die Gasgleichung $p V = m R T$ funktioniert nur mit absoluten Größen: $p_1 = 5 thin "bar" = 5 dot 10^5 thin "Pa"$, $T_1 = "293,15" thin "K"$, $T_2 = "353,15" thin "K"$.
][
*Masse:* $m = p_1 V\/(R T_1) = (5 dot 10^5 dot 2)\/("287,2" dot "293,15") thin "kg" approx "11,88" thin "kg"$.
][
*Was beim Erwärmen gleich bleibt:* Geschlossen heißt gleiche Masse, starr heißt gleiches Volumen. In $p V = m R T$ ändern sich also nur $p$ und $T$, und zwar im gleichen Verhältnis: $p_2\/p_1 = T_2\/T_1$.
][
*Enddruck:* $p_2 = 5 thin "bar" dot "353,15"\/"293,15" approx "6,02" thin "bar"$ absolut.
][
*Prüfen:* 60 K mehr sind etwa 20 % mehr absolute Temperatur, also etwa 20 % mehr Druck. Wer mit 80/20 in °C rechnet, bekäme den falschen Faktor 4.
]

#aufgabe(titel: "Sauerstoffflasche: ideal und real", art: "rechnen", quelle: "1.6.1", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.5 a–c, e", minuten: 15)[
#if not web [*Aufgabe 77* #linebreak()]
*Sauerstoffflasche, Auszug aus Ü 2.5 a–c und e:*

*Gegeben und Annahmen*

$V="58,5" thin "l"$, Überdruck 232 bar bei $T_1=300 thin "K"$, Umgebung 1 bar, Abkühlung auf −18,3 °C. Nutze $R="259,8" thin "J/(kg K)"$.

*Gesucht*

#enum(numbering: "a)",
[Berechne Masse und Enddruck zuerst ideal, dann mit $Z_1="0,958155"$ und dem für den Endzustand vorgegebenen $Z_2="0,85949475"$. Die Flasche bleibt dicht und starr.],
)
][
*Vorbereitung:* $p_1=232+1=233 thin "bar"$ absolut; $V="0,0585" thin "m"^3$; $T_2="254,85" thin "K"$. Die geschlossene starre Flasche hat konstante Masse und konstantes spezifisches Volumen.

*Ideales Modell:*
$ m=p_1 V/(R T_1) approx "17,49" thin "kg" $
$ p_2=p_1 T_2/T_1 approx "197,93" thin "bar" " absolut" $
Der zugehörige Überdruck ist etwa 196,93 bar.

*Reales Modell:* Mit $p V=m Z R T$ ist die anfängliche Masse
$ m=p_1 V/(Z_1 R T_1) approx "18,25" thin "kg" $
Da das spezifische Volumen unverändert bleibt, gilt
$ p_2/p_1=(Z_2 T_2)/(Z_1 T_1) quad => quad p_2 approx "177,55" thin "bar" " absolut" $
Der Endüberdruck ist etwa 176,55 bar. Hier ist $Z_2$ bereits als zum Endzustand gehörend vorgegeben. Ohne diese Vorgabe wäre seine Druckabhängigkeit bei der Bestimmung von $p_2$ zu berücksichtigen. *Prüfung:* Der Druck sinkt beim Abkühlen. In der realen Rechnung ändert sich zusätzlich $Z$; deshalb gilt nicht mehr einfach $p/T="konstant"$.
]

#aufgabe(titel: "Kleine Sauerstoffflasche, ideal gerechnet (Variante)", art: "rechnen", quelle: "1.6.1", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.5 a–c, e", minuten: 10,
  ergebnis: [$v approx "0,00423" thin "m"^3/"kg"$; $m approx "9,45" thin "kg"$; $p_2 approx "161,5" thin "bar"$ absolut ($"160,5" thin "bar"$ Überdruck); $V approx "7,36" thin "m"^3$])[
#if not web [*Aufgabe 78* #linebreak()]
*Gegeben und Annahmen*

Eine Sauerstoffflasche mit 40 l zeigt 180 bar Überdruck bei 295 K; Umgebungsdruck 1 bar. Sauerstoff als ideales Gas, $R = "259,8" thin "J/(kg K)"$. Die Flasche ist starr und dicht.

*Gesucht*

#enum(numbering: "a)",
[Spezifisches Volumen und Masse der Füllung.],
[Den Druck nach Abkühlen auf −10 °C.],
[Welches Volumen nimmt der Sauerstoff nach dem Ablassen bei 1 bar und 300 K ein, wenn er sich nicht mit Luft mischt?],
)
][
*Füllung:* $p_1 = 181 thin "bar"$ absolut. $v = R T_1\/p_1 = "259,8" dot 295\/(181 times 10^5) approx "0,00423" thin "m"^3/"kg"$; $m = V\/v approx "9,45" thin "kg"$.
][
*Abkühlen:* starr und dicht, also isochor: $p_2 = p_1 T_2\/T_1 = 181 dot "263,15"\/295 approx "161,5" thin "bar"$ absolut, angezeigt werden rund 160,5 bar.
][
*Ablassen:* $V = m R T\/p = "9,45" dot "259,8" dot 300\/10^5 thin "m"^3 approx "7,36" thin "m"^3$, rund 180-mal das Flaschenvolumen.
]

#aufgabe(titel: "Gas im Kolbenzylinder: wie viel dichter vorher?", art: "rechnen", quelle: "1.6.1", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.6", minuten: 5,
  ergebnis: [$rho_1\/rho_2 = T_2\/T_1 approx "1,239"$])[
#if not web [*Aufgabe 79* #linebreak()]
*Gegeben und Annahmen*

Ein Zylinder, der oben mit einem frei beweglichen Kolben gasdicht abgeschlossen ist, wird bei einer Temperatur von $"15,4" thin "°C"$ gefüllt. Dann erwärmt sich der Zylinder mit seiner Gasfüllung auf $"84,3" thin "°C"$. Das Gas verhält sich ideal.

*Gesucht*

#enum(numbering: "a)",
[Wie viel mal dichter war das Gas vor der Erwärmung?],
)
][
*Was bleibt konstant?* Der frei bewegliche Kolben stellt immer dasselbe Kräftegleichgewicht ein: Der Gasdruck bleibt gleich (isobar). Die Masse bleibt gleich, weil der Kolben gasdicht ist.
][
*Gasgleichung als Verhältnis:* Aus $p = rho R T$ folgt bei gleichem $p$ und $R$:
$ rho_1/rho_2 = T_2/T_1 = ("84,3" + "273,15")/("15,4" + "273,15") = "357,45"/"288,55" approx "1,239" $
Das Gas war vorher rund 1,24-mal so dicht. Mit Celsius-Werten ($"84,3"\/"15,4" approx "5,5"$) käme ein unsinniges Ergebnis heraus: Verhältnisse brauchen Kelvin.
]

#aufgabe(titel: "Gas im Kolbenzylinder von 20 auf 120 Grad (Variante)", art: "rechnen", quelle: "1.6.1", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.6", minuten: 4,
  ergebnis: [$rho_1\/rho_2 approx "1,341"$; $V_2\/V_1 approx "1,341"$])[
#if not web [*Aufgabe 80* #linebreak()]
*Gegeben und Annahmen*

Ideales Gas unter einem frei beweglichen, dichten Kolben wird von $20 thin "°C"$ auf $120 thin "°C"$ erwärmt.

*Gesucht*

#enum(numbering: "a)",
[Das Dichteverhältnis vorher zu nachher.],
[Um welchen Faktor wächst das Volumen?],
)
][
*Isobar und gleiche Masse:* Der frei bewegliche Kolben hält den Druck konstant. Mit $p = rho R T$:
$ rho_1/rho_2 = T_2/T_1 = "393,15"/"293,15" approx "1,341" $
][
*Volumen:* Gleiche Masse heißt $rho V = "konst."$, also $V_2\/V_1 = rho_1\/rho_2 approx "1,341"$. Das Gas dehnt sich um gut ein Drittel aus, obwohl sich die Celsius-Temperatur versechsfacht hat.
]

#aufgabe(titel: "Kurzfrage: Hydrostatisches Paradoxon", art: "verstehen", quelle: "1.7", herkunft: "original", vorlage: "Leistungsnachweis WS 13/14, Kurzfrage 14; ebenso SS 13, Kurzfrage 3", minuten: 3)[
#if not web [*Aufgabe 81* #linebreak()]
Was versteht man unter dem hydrostatischen Paradoxon?
][
*Antwort:* Der Druck am Boden eines Gefäßes hängt nur von der Höhe der Flüssigkeitssäule über dem Boden (und von $rho$, $g$, $p_infinity$) ab, nicht von der Form des Gefäßes oder der Flüssigkeitsmenge: $p = p_infinity + rho g h$.
][
*Warum das paradox wirkt:* Ein schmales, hohes Gefäß enthält wenig Wasser, erzeugt aber am Boden denselben Druck wie ein breites mit viel Wasser gleicher Höhe. Die Gefäßwände nehmen die Gewichtsunterschiede auf.
]

#aufgabe(titel: "Kurzfrage: Druck als Energiedichte", art: "verstehen", quelle: "1.7", herkunft: "original", vorlage: "Leistungsnachweis SS 13, Kurzfrage 10", minuten: 3)[
#if not web [*Aufgabe 82* #linebreak()]
Zeige, dass der Druck die Einheit einer Energiedichte hat.
][
*Einheiten umformen:* $1 thin "Pa" = 1 thin "N/m"^2 = 1 thin ("N m")\/"m"^3 = 1 thin "J/m"^3$.
][
*Bedeutung:* Druck ist Energie je Volumen. Darum stehen in der Bernoulli-Gleichung $p$, $rho w^2\/2$ und $rho g z$ gleichberechtigt nebeneinander, und $p v$ ist eine spezifische Energie (Verschiebearbeit je kg).
]

#aufgabe(titel: "Kurzfrage: Überdruck", art: "verstehen", quelle: "1.7", herkunft: "original", vorlage: "Leistungsnachweis WS 13/14, Kurzfrage 4", minuten: 3)[
#if not web [*Aufgabe 83* #linebreak()]
Was versteht man unter dem Begriff Überdruck?
][
*Antwort:* Der Überdruck ist die Differenz zwischen absolutem Druck und Umgebungsdruck, wenn diese positiv ist: $p_e = p_"abs" - p_"amb" > 0$. Ein Manometer zeigt ihn an.
][
*Gegenstück:* Ist der absolute Druck kleiner als der Umgebungsdruck, spricht man von Unterdruck. In Gasgleichung und Entropieformeln gehört immer der absolute Druck.
]

#aufgabe(titel: "Druck und Temperatur für die Gasgleichung", art: "verstehen", quelle: "1.7", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 84* #linebreak()]
Welchen Druck und welche Temperatur brauche ich in der idealen Gasgleichung?
][
*Antwort:*

- Immer den *Absolutdruck* (vom Vakuum aus gemessen) und die Temperatur in *Kelvin*.
- Ein Manometer zeigt meist Überdruck an, dazu kommt der Umgebungsdruck: $p_"abs" = p_e + p_"amb"$.

#align(center)[#image("abbildungen/manometer.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Gasgleichung: absoluter Druck und Kelvin.
]

#aufgabe(titel: "Hydrostatischer Druck im ruhenden Wasser", art: "verstehen", quelle: "1.7", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 85* #linebreak()]
Warum hat ruhendes Wasser unten einen höheren Druck als oben?
][
*Antwort:*

- Jede Schicht muss das Gewicht des Wassers darüber tragen.
- *Der Druck wächst deshalb mit der Tiefe:* $p = p_0 + rho g h$.
- Etwa 10 m Wasser entsprechen 1 bar.
- Mechanisches Gleichgewicht heißt also Kräftegleichgewicht, nicht überall gleicher Druck.

#align(center)[#image("abbildungen/manometer.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Hydraulische Presse hebt ein Auto", art: "rechnen", quelle: "1.7", herkunft: "original", vorlage: "Prüfung SS 24, Aufg. 3.1–3.3", minuten: 10,
  ergebnis: [$F_1 approx 14 thin 715 thin "N"$; $F_2 approx 1635 thin "N"$; $Delta s_2 = "0,45" thin "m"$])[
#if not web [*Aufgabe 86* #linebreak()]
*Gegeben und Annahmen*

Ein Auto wurde auf der hydraulischen Presse angehoben. Gegeben ist: $m = 1500 thin "kg"$ (Masse des Autos), $d_1 = 150 thin "mm"$ (Kolben unter dem Auto), $d_2 = 50 thin "mm"$ (Kolben, an dem die Kraft $F_2$ angreift), $p_infinity = 1 thin "bar"$, $rho_"Öl" = 900 thin "kg/m"^3$, $g = "9,81" thin "m/s"^2$. Das Öl ist inkompressibel.

*Gesucht*

#enum(numbering: "a)",
[Die Gewichtskraft des Fahrzeuges $F_1$.],
[Die angelegte Kraft $F_2$. Treffe die übliche Annahme: Vernachlässige den hydrostatischen Druck des Hydrauliköls.],
[Das Auto wurde um $Delta s_1 = 5 thin "cm"$ angehoben. Wie groß war die Verschiebung $Delta s_2$ des zweiten Kolbens?],
)
][
*Gewichtskraft:* $F_1 = m g = 1500 dot "9,81" thin "N" = 14 thin 715 thin "N"$.
][
*Gleicher Druck an beiden Kolben:* Ohne hydrostatischen Anteil herrscht im Öl überall derselbe Überdruck. Der Umgebungsdruck wirkt auf beide Kolben von außen und hebt sich heraus:
$ p_e = F_1/A_1 = F_2/A_2 quad => quad F_2 = F_1 (d_2/d_1)^2 = 14 thin 715 dot (50/150)^2 thin "N" = 1635 thin "N" $
Der Überdruck beträgt $p_e = F_1\/A_1 = 14 thin 715\/("0,017671") thin "Pa" approx "8,33" thin "bar"$. Die Presse verkleinert die Kraft im Verhältnis der Flächen, nicht der Durchmesser.
][
*Volumen bleibt erhalten:* Das inkompressible Öl, das der kleine Kolben verdrängt, schiebt den großen hoch: $A_1 Delta s_1 = A_2 Delta s_2$.
$ Delta s_2 = Delta s_1 (d_1/d_2)^2 = 5 thin "cm" dot 9 = 45 thin "cm" $
*Energieprobe:* $F_2 Delta s_2 = 1635 dot "0,45" thin "J" approx 736 thin "J" = F_1 Delta s_1$. Die Presse spart Kraft, aber keine Arbeit.
]

#aufgabe(titel: "Hydraulische Presse mit größerem Kolben (Variante)", art: "rechnen", quelle: "1.7", herkunft: "variante", vorlage: "Prüfung SS 24, Aufg. 3.1–3.3", minuten: 8,
  ergebnis: [$F_1 = 11 thin 772 thin "N"$; $F_2 approx 471 thin "N"$; $Delta s_2 = 1 thin "m"$])[
#if not web [*Aufgabe 87* #linebreak()]
*Gegeben und Annahmen*

Eine hydraulische Presse hebt ein Auto mit $m = 1200 thin "kg"$. Kolbendurchmesser unter dem Auto $d_1 = 200 thin "mm"$, am Betätigungskolben $d_2 = 40 thin "mm"$. Der hydrostatische Druck des Öls wird vernachlässigt; das Öl ist inkompressibel; $g = "9,81" thin "m/s"^2$.

*Gesucht*

#enum(numbering: "a)",
[Die Gewichtskraft $F_1$ und die nötige Kraft $F_2$.],
[Den Weg $Delta s_2$, wenn das Auto um $Delta s_1 = 4 thin "cm"$ steigt.],
)
][
*Kräfte:* $F_1 = 1200 dot "9,81" thin "N" = 11 thin 772 thin "N"$. Gleicher Überdruck an beiden Kolben:
$ F_2 = F_1 (d_2/d_1)^2 = 11 thin 772 dot (40/200)^2 thin "N" approx 471 thin "N" $
][
*Wege:* Gleiches verdrängtes Volumen, $A_1 Delta s_1 = A_2 Delta s_2$:
$ Delta s_2 = 4 thin "cm" dot (200/40)^2 = 100 thin "cm" = 1 thin "m" $
Probe: $471 dot 1 approx 11 thin 772 dot "0,04" approx 471 thin "J"$. Die Arbeit an beiden Kolben ist gleich.
]

#aufgabe(titel: "Absoluter Druck aus der Manometeranzeige", art: "rechnen", quelle: "1.7", herkunft: "eigen", minuten: 3,
  ergebnis: [$p_"abs" = "3,16" thin "bar" = 316 thin 000 thin "Pa"$],
)[
#if not web [*Aufgabe 88* #linebreak()]
*Gegeben und Annahmen*

Ein Manometer zeigt $"2,2" thin "bar"$, Umgebung $"0,96" thin "bar"$.

*Gesucht*

#enum(numbering: "a)",
[Welcher Druck gehört in die Gasgleichung?],
)
][
*Was misst ein Manometer?* Es vergleicht den Behälterdruck mit der Umgebung. Es zeigt den *Überdruck*, also wie viel mehr drinnen drückt als draußen.
][
*Absoluter Druck:* Die Gasgleichung beschreibt die Stöße aller Moleküle, gemessen vom Vakuum aus. $p_"abs" = p_"ü" + p_"amb" = "2,2" + "0,96" = "3,16" thin "bar"$.
][
*In Pascal:* $"3,16" thin "bar" = 316 thin 000 thin "Pa"$. *Prüfen:* Der absolute Druck ist immer größer als die Anzeige, solange ein Überdruck herrscht.
][
*Typische Verwechslung:*

- „2,2 bar“: Das ist der Überdruck gegenüber der Umgebung. Die Gasgleichung braucht den Druck ab Vakuum.
- „1,24 bar“: Hier wurde die Umgebung abgezogen statt addiert.
]

#aufgabe(titel: "Stickstoff: Volumenanteile und Förderung", art: "rechnen", quelle: "1.7", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.1 a–b", minuten: 12)[
#if not web [*Aufgabe 89* #linebreak()]
*Stickstoffgefäß, Auszug aus Ü 2.1 a–b:*

*Gegeben und Annahmen*

Ein Volumen von $"0,05" thin "m"^3$ enthält bei 1 bar zu 90 Volumenprozent Flüssigkeit und zu 10 Prozent Dampf. Es gelten $v'_1="0,0012398"$, $v''_1="0,21947" thin "m"^3/"kg"$. Verwende $g="9,81" thin "m/s"^2$.

*Gesucht*

#enum(numbering: "a)",
[Bestimme Teilmassen, Gesamtmasse, Dampfgehalt und mittleres spezifisches Volumen. Für das Anheben der Flüssigkeit um $"5,143" thin "m"$ gegen 1 bar Umgebung: Prüfe den erforderlichen Behälterdruck näherungsweise mit $v'("1,4" thin "bar")="0,0012611" thin "m"^3/"kg"$; bei diesem Druck ist $T_s="80,21" thin "K"$.],
)
][
*Teilvolumina:* $V'="0,045" thin "m"^3$, $V''="0,005" thin "m"^3$. Wir teilen jeweils durch das spezifische Volumen der betreffenden Phase:
$ m'=V'/v' approx "36,296" thin "kg" quad quad m''=V''/v'' approx "0,022782" thin "kg" $
Also *$m approx "36,319" thin "kg"$*, $x=m''/m approx "0,0006273"$, also nur *0,06273 Prozent Dampfmasse*. Das spezifische Gesamtvolumen ist $v=V/m approx "0,0013767" thin "m"^3/"kg"$. Die zehn Volumenprozent Dampf sind eindeutig keine zehn Massenprozent.

*Anheben bis zum gerade noch ruhenden Austritt:* Der nötige Behälterüberdruck trägt die Flüssigkeitssäule:
$ p_2-p_0=rho'_2 g Delta z=g Delta z/v'_2 $
$ p_2 approx 1 thin "bar"+("9,81" times "5,143")/"0,0012611" thin "Pa" approx "1,400" thin "bar" $
Das ist mit dem verwendeten Sättigungswert bei 1,4 bar konsistent; dort ist $T_2="80,21" thin "K"$, also −192,94 °C. Die Flüssigkeitsdichte wird am Zustand 2 verwendet. Der Druck an der Behälteroberfläche muss *höher* als der Umgebungsdruck sein, damit die Säule aufsteigen kann. Für einen endlichen Ausfluss kämen Bewegungsenergie und reale Verluste hinzu. Die weiteren Entnahmeteile stehen jetzt in Lösung 26 dieses Kapitels, die vollständige Energiebilanz und Zustandsgrößentabelle in Kapitel 3, Lösung 9.
]

#aufgabe(titel: "Kelvin und Celsius: Differenz und Verhältnis", art: "verstehen", quelle: "1.8", herkunft: "eigen", minuten: 3,
  tipp: [Rechne die Temperaturen in Kelvin um.])[
#if not web [*Aufgabe 90* #linebreak()]
Warum sind Temperaturdifferenzen in K und °C gleich, Verhältnisse aber nicht?
][
*Antwort:*

- Celsius und Kelvin haben *gleiche Schrittweiten*, aber *verschiedene Nullpunkte*.
- Umrechnung: $T\/"K" = theta\/"°C" + "273,15"$.
- *Differenzen:* 10 °C Unterschied entsprechen 10 K.
- *Verhältnisse:* nur mit Kelvin bilden.
- 60 °C gegenüber 20 °C sind etwa 333 K gegenüber 293 K: rund 14 % mehr, nicht dreimal so viel.

#align(center)[#image("abbildungen/kelvin.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „Ja, weil sich die Temperatur verdreifacht.“: 60 °C ist nicht das Dreifache von 20 °C, wenn man in Kelvin rechnet. Verhältnisse brauchen absolute Temperaturen.
- „Nein, bei konstantem Volumen bleibt auch der Druck konstant.“: Isochor heißt, das Volumen bleibt gleich. Der Druck steigt mit der Temperatur.
]

#aufgabe(titel: "Gleiche Zustände, verschiedene Arbeit", art: "verstehen", quelle: "1.9", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 91* #linebreak()]
Warum kann bei gleichem Anfangs- und Endzustand unterschiedlich viel Arbeit übertragen werden?
][
*Antwort:*

- Die Volumenarbeit ist die Fläche unter der Kurve im $p$-$V$-Diagramm.
- Verschiedene Wege zwischen denselben Punkten haben verschiedene Flächen.
- $Delta U$ ist gleich, aber die Aufteilung in Wärme und Arbeit nicht.

#align(center)[#image("abbildungen/path-work.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Vorzeichen der Volumenarbeit", art: "verstehen", quelle: "1.9", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 92* #linebreak()]
Welches Vorzeichen hat die Volumenarbeit bei Expansion und Kompression, und warum?
][
*Antwort:*

- $W_v = -integral p dif V$.
- Bei Expansion ist $dif V > 0$, also $W_v < 0$: Das Gas gibt Arbeit ab.
- Bei Kompression ist $W_v > 0$: Arbeit wird zugeführt.
- Das Minus sorgt dafür, dass in der Zufuhrkonvention Zugeführtes positiv zählt.

#align(center)[#image("abbildungen/path-work.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* In der Zufuhrkonvention: rein positiv, raus negativ.
][
*Typische Verwechslung:*

- „Positiv: Das Gas gibt Arbeit ab.“: Abgegebene Arbeit ist in der Zufuhrkonvention negativ.
- „Positiv: Dem Gas wird Arbeit zugeführt.“: Das gilt bei Kompression, wenn $dif V < 0$ ist.
]

#aufgabe(titel: "Adiabates Rühren", art: "verstehen", quelle: "1.10", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 93* #linebreak()]
Warum kann adiabates Rühren die Temperatur erhöhen, und warum ist es irreversibel?
][
*Kurz gesagt:* Rührarbeit wird in innere Energie umgewandelt. Die Umkehr der Drehrichtung kehrt die Dissipation nicht um; System und Umgebung lassen sich dadurch nicht spurlos zurücksetzen.
][
*Ausführlich:*

- Die Rührarbeit wird durch Reibung zu innerer Energie, das Gas wird wärmer.
- Dreht man den Rührer rückwärts, kühlt das Gas nicht ab, sondern wird noch wärmer.
- Die Dissipation lässt sich nicht umkehren.

#align(center)[#image("abbildungen/reversibility.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Bild:* Umrühren im Kaffee macht ihn minimal wärmer. Rückwärtsrühren macht ihn nicht wieder kälter.
]

#aufgabe(titel: "Reversibel und irreversibel", art: "verstehen", quelle: "1.10", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 94* #linebreak()]
Was bedeutet reversibel, und was macht einen Vorgang irreversibel?
][
*Antwort:*

- *Reversibel:* System *und* Umgebung lassen sich ohne bleibende Spuren zurücksetzen.
- Reibung und Wärmeübertragung über einen endlichen Temperaturunterschied verhindern das.
- Die Energie bleibt erhalten, aber man bekommt sie nicht auf demselben Weg vollständig zurück.

#align(center)[#image("abbildungen/reversibility.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Quasistatisch ist nicht reversibel", art: "verstehen", quelle: "1.10", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 95* #linebreak()]
Was bedeutet quasistatisch, und ist quasistatisch dasselbe wie reversibel?
][
*Antwort:*

- *Quasistatisch:* eine gedachte Folge von Gleichgewichtszuständen, also sehr langsam.
- *Das ist nicht dasselbe wie reversibel:* Ein langsamer Kolben mit Reibung ist quasistatisch, aber wegen der Reibung trotzdem irreversibel.

#align(center)[#image("abbildungen/reversibility.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Langsam allein macht einen Vorgang nicht umkehrbar.
]

#aufgabe(titel: "Was ein Energieverlust wirklich ist", art: "verstehen", quelle: "1.10", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 96* #linebreak()]
Was bedeutet ein „Energieverlust“ in der Technik wirklich?
][
*Antwort:*

- Die Energie verschwindet nicht.
- Sie wird z. B. durch Reibung zu innerer Energie oder geht an die Umgebung, wo sie nicht mehr nutzbar ist.
- Die Energiebilanz sagt, wie viel.
- Ob ein Vorgang umkehrbar ist, braucht eine zusätzliche Aussage.

#align(center)[#image("abbildungen/reversibility.svg", width: 100%, height: 55mm, fit: "contain")]
]

#kapitel("Kapitel 2 · Stoffeigenschaften")

#aufgabe(titel: "Fünf Abschnitte der Erwärmung", art: "verstehen", quelle: "2.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 97* #linebreak()]
Erkläre die fünf Abschnitte der Erwärmung von Eis bis überhitztem Dampf. Warum kann eine Phasenumwandlung im Diagramm waagerecht oder senkrecht erscheinen?
][
*Kurz gesagt:* Feststoff erwärmen, schmelzen, Flüssigkeit erwärmen, verdampfen, Dampf erwärmen. Beim Phasenwechsel bleibt $T$ unter den genannten isobaren Gleichgewichtsbedingungen konstant. Die Orientierung hängt davon ab, auf welcher Achse $T$ steht.
][
*Ausführlich:*

- Auf den schrägen Abschnitten wird eine einzelne Phase wärmer (fühlbare Wärme).
- Auf den waagerechten Plateaus fließt weiter Energie zu, aber sie verändert nur den Phasenanteil (latente Wärme).
- Bei konstantem Druck bleibt die Temperatur dabei konstant.
- Ein Plateau heißt also nicht „Heizung aus“.

#align(center)[#image("abbildungen/warming.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Beim Phasenwechsel ändert sich die Menge der Phasen, nicht zwingend die Temperatur.
][
*Bild:* Eine Heizung kann beim Sieden weiterlaufen, obwohl das Thermometer stehen bleibt.
]

#aufgabe(titel: "Wann Q = m(h″ − h′) gilt", art: "verstehen", quelle: "2.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 98* #linebreak()]
Unter welchen Voraussetzungen gilt beim Verdampfen $Q=m(h''-h')$?
][
*Kurz gesagt:* Reiner Stoff im Gleichgewicht bei konstantem Druck unterhalb des kritischen Drucks; vollständiger Wechsel von gesättigter Flüssigkeit zu gesättigtem Dampf. Für ein geschlossenes System: nur Volumenarbeit, keine wesentlichen äußeren Energieänderungen. Ein passender stationärer Verdampfer liefert dieselbe Wärmebeziehung bei entsprechender Vernachlässigung weiterer Beiträge.
][
*Ausführlich:*

- Reiner Stoff, Gleichgewicht, konstanter Druck unter dem kritischen Druck, vollständiger Wechsel von gesättigter Flüssigkeit zu Sattdampf.
- Im geschlossenen System nur Volumenarbeit und keine nennenswerten Änderungen von Bewegungs- und Lageenergie.

#align(center)[#image("abbildungen/five-states.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Dampfdruckkurve und Schmelzkurve", art: "verstehen", quelle: "2.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 99* #linebreak()]
Warum steigt die Dampfdruckkurve, während die Schmelzkurve gewöhnlichen Eises im betrachteten Bereich fällt?
][
*Kurz gesagt:* Clapeyron: positive Umwandlungsenthalpie geteilt durch $T$ und Volumenänderung. Verdampfung hat positive Volumenänderung; Schmelzen gewöhnlichen Eises hat negative.
][
*Ausführlich:*

- *Clapeyron:*
$ (dif p)/(dif T) = (Delta h)/(T Delta v) $
- Beim Verdampfen ist $Delta h > 0$ und $Delta v > 0$, also steigt die Kurve.
- Eis braucht mehr Platz als Wasser.
- Beim Schmelzen ist $Delta v < 0$, also fällt die Schmelzkurve: Mehr Druck lässt Eis eher schmelzen.

#align(center)[#image("abbildungen/triple.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „Beim Schmelzen wird Energie frei, beim Verdampfen verbraucht.“: Beide Umwandlungen brauchen Energie, $Delta h > 0$.
- „Weil Eis bei 0 °C schmilzt und Wasser bei 100 °C siedet.“: Die Lage der Kurven sagt nichts über ihre Steigung.
]

#aufgabe(titel: "Tabellenbezug und einheitlicher Datensatz", art: "verstehen", quelle: "2.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 100* #linebreak()]
Eine Tabelle nennt bei 80 °C eine mittlere Wärmekapazität mit Bezug auf 0 °C. Darfst du diesen Wert unverändert für 6 → 80 °C verwenden? Warum dürfen Enthalpiewerte verschiedener Tabellen nicht ungeprüft kombiniert werden?
][
*Kurz gesagt:* Der Mittelwert 0 → 80 °C enthält einen anderen Temperaturbereich. Für 6 → 80 °C wird die Enthalpiezunahme 0 → 6 °C von der Zunahme 0 → 80 °C abgezogen. Unterschiedliche Tabellen können verschiedene Referenznullpunkte für Enthalpie und Entropie verwenden; eine willkürliche Kombination erzeugt dann falsche Differenzen. Innerhalb eines konsistenten Datensatzes fällt ein gemeinsamer Bezugsnullpunkt bei der Differenzbildung heraus.
][
*Ausführlich:*

- Der Tabellenwert $C_theta$ gilt für das Intervall von 0 °C bis $theta$.
- Für 6 → 80 °C rechnet man daher
$ C_80 dot 80 - C_6 dot 6 quad "und nicht" quad C_80 dot 74 $
- Das Intervall ist ein anderes.

#align(center)[#image("abbildungen/warming.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Ausführlich:*

- Enthalpien haben einen willkürlich gewählten Nullpunkt.
- Verschiedene Tabellen haben oft verschiedene Nullpunkte.
- Nur Differenzen aus demselben Datensatz sind sinnvoll.
- Deshalb können Tabellenwerte sogar negativ sein.
][
*Merksatz:* Enthalpiedifferenzen brauchen denselben Nullpunkt.
][
*Bild:* Höhenangaben vergleichen: Beide müssen sich auf denselben Meeresspiegel beziehen.
][
*Typische Verwechslung:*

- „$Delta h = C_80 dot 74 thin "K"$“: $C_80$ gilt für den Bereich 0 bis 80 °C, nicht für 6 bis 80 °C.
- „$Delta h = (C_80 + C_6)\/2 dot 74 thin "K"$“: Der Mittelwert zweier Tabellenwerte ist kein Mittelwert über das richtige Intervall.
]

#aufgabe(titel: "Temperatur während des Siedens", art: "verstehen", quelle: "2.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 101* #linebreak()]
Wasser wird bei konstantem Druck erhitzt und beginnt zu sieden. Was passiert mit der Temperatur, solange noch Flüssigkeit da ist? Begründe deine Antwort.
][
*Antwort:* Sie bleibt konstant; die Energie geht in den Phasenwechsel.

Bei einem reinen Stoff sind im Zweiphasengebiet Druck und Temperatur gekoppelt. Die zugeführte Energie ist latent.
][
*Typische Verwechslung:*

- „Sie steigt weiter, aber langsamer.“: Isobar und im Gleichgewicht bleibt sie bei einem reinen Stoff konstant, bis alles verdampft ist.
- „Sie sinkt, weil das Verdampfen Energie verbraucht.“: Verdampfen braucht Energie, aber die wird zugeführt. Die Temperatur bleibt auf der Siedetemperatur.
]

#aufgabe(titel: "Fünf Energieanteile beim Erwärmen", art: "rechnen", quelle: "2.1", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.2", minuten: 15)[
#if not web [*Aufgabe 102* #linebreak()]
*Erwärmungskurve, vereinfachte Ü 2.2:*

*Gegeben und Annahmen*

1 kg Eis soll bei 1 bar von −15 °C bis zu 200 °C heißem Wasserdampf erwärmt werden.

*Gesucht*

#enum(numbering: "a)",
[Rechne näherungsweise mit Schmelzen bei 0 °C, Sieden bei 99,603 °C, $c_"Eis"="2,04" thin "kJ/(kg K)"$, $r_"S"="333,5" thin "kJ/kg"$, mittlerem $c_"Wasser"="4,19030" thin "kJ/(kg K)"$, $r_"V"="2257,5" thin "kJ/kg"$ und angenommenem mittlerem $c_"Dampf"="2,0" thin "kJ/(kg K)"$.],
[Bestimme alle fünf Energieanteile und die Summe.],
[Erkläre die Form im Temperatur-Energie-Diagramm.],
)
][
*Modell:* Isobarer Gleichgewichtsweg mit nur Volumenarbeit und vernachlässigbaren äußeren Energieänderungen. Jede Phase wird mit den angegebenen mittleren Wärmekapazitäten berechnet. Das ist eine vereinfachte Rechenvariante, keine zusätzliche exakte Dampftafel.

#tab(columns: (1.5fr, 2fr, 0.8fr),
 th([Schritt], [Ansatz], [Energie / kJ]),
 [Eis −15 → 0 °C], [$1 times "2,04" times 15$], [30,6],
 [Schmelzen], [$1 times "333,5"$], [333,5],
 [Wasser 0 → 99,603 °C], [$1 times "4,19030" times "99,603"$], [417,37],
 [Verdampfen], [$1 times "2257,5"$], [2257,5],
 [Dampf 99,603 → 200 °C], [$1 times "2,0" times (200-"99,603")$], [200,79],
)
Insgesamt *$Q approx "3239,76" thin "kJ" approx "3,240" thin "MJ"$*. Der größte Anteil ist die Verdampfung. Im Temperatur-über-Energie-Diagramm steigen drei Abschnitte an; beim Schmelzen und Verdampfen verläuft die Kurve horizontal. Bei konstanter zugeführter Leistung entspricht die Energieachse bis auf einen Skalierungsfaktor einer Zeitachse.

*Tabellenmethode:* sensible Anteile durch konsistente Enthalpiedifferenzen ersetzen. Die fünf Beiträge einmal zählen; die Verdampfungsenthalpie kommt zusätzlich zur Flüssigkeitserwärmung hinzu.
]

#aufgabe(titel: "Kurzfrage: Ursachen für reales Gasverhalten", art: "verstehen", quelle: "2.2", herkunft: "original", vorlage: "Leistungsnachweis WS 19/20, Aufg. 0d", minuten: 3)[
#if not web [*Aufgabe 103* #linebreak()]
Durch welche physikalischen Effekte entstehen Abweichungen vom Verhalten des idealen Gases?
][
*Antwort:* Das Eigenvolumen der Moleküle und die Anziehungskräfte zwischen ihnen. Das ideale Gas nimmt punktförmige Moleküle ohne Wechselwirkung an.
][
*Wann es wichtig wird:* bei hohem Druck und tiefer Temperatur, also kleinem spezifischem Volumen und in der Nähe der Kondensation. Van der Waals korrigiert genau diese beiden Effekte mit $a$ und $b$.
]

#aufgabe(titel: "Altklausur WS 05/06: Kurzfrage 8", art: "verstehen", quelle: "2.2", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 05/06, Kurzfrage 8 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 104* #linebreak()]
Wo im T-s-Diagramm für Wasser liegt das Gültigkeitsgebiet für ideales Gas? Welche Voraussetzungen sind dafür erforderlich?
][
*Antwort:* Ideales Gas ist näherungsweise bei kleiner Dichte und ausreichend großem Abstand von Sättigung und kritischer Region brauchbar. Im T-s-Diagramm liegt der geeignete Bereich weit im überhitzten Dampf, besonders bei niedrigem Druck. Die bloße Angabe „gasförmig“ genügt nicht; $Z=p v/(R T)$ prüft die Abweichung vom idealen Wert eins.
]

#aufgabe(titel: "Altklausur WS 02/03: Kurzfrage 7", art: "verstehen", quelle: "2.2", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 02/03, Kurzfrage 7 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 105* #linebreak()]
Wozu dient der Realgasfaktor?
][
*Antwort:* Ideales Gas ist näherungsweise bei kleiner Dichte und ausreichend großem Abstand von Sättigung und kritischer Region brauchbar. Im T-s-Diagramm liegt der geeignete Bereich weit im überhitzten Dampf, besonders bei niedrigem Druck. Die bloße Angabe „gasförmig“ genügt nicht; $Z=p v/(R T)$ prüft die Abweichung vom idealen Wert eins.
]

#aufgabe(titel: "Realgasfaktor Z", art: "verstehen", quelle: "2.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 106* #linebreak()]
Was bedeutet $Z=1$ und warum darfst du $Z$ nicht für jeden Zustand eines realen Gases gleich wählen?
][
*Kurz gesagt:* $Z=1$ ist die ideale thermische Gasbeziehung. Der reale Faktor hängt vom Zustand ab; eine unveränderte Übernahme kann falsche Stoffwerte liefern.
][
*Ausführlich:*

- $Z = (p v)/(R T)$ sagt, wie stark ein reales Gas von der idealen Gasgleichung abweicht.
- $Z = 1$ heißt ideal.
- $Z$ hängt vom Zustand ab und muss für jeden Zustand neu bestimmt werden.
- Er ist ein Korrekturfaktor für die thermische Zustandsgleichung, kein Wirkungsgrad.

#align(center)[#image("abbildungen/oxygen.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „$Z < 1$ bedeutet, dass das Gas weniger Energie enthält.“: $Z$ korrigiert nur die thermische Zustandsgleichung. Für Energien braucht man kalorische Stoffwerte.
- „Nahe der Kondensation ist $Z$ immer genau 1.“: Gerade dort weicht das Verhalten oft stark vom idealen Gas ab.
]

#aufgabe(titel: "Altklausur WS 05/06: Kurzfrage 10", art: "verstehen", quelle: "2.3", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 05/06, Kurzfrage 10 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 107* #linebreak()]
Skizziere ein p-v-Diagramm von Wasser für gasförmige, flüssige und feste Phasen und beschrifte wichtige Punkte, Linien und Diagrammbereiche.
][
*Skizze erklären:* p senkrecht, v waagerecht. Siede- und Taulinie schließen das Flüssig-Dampf-Koexistenzgebiet ein und treffen sich im kritischen Punkt. Links liegt Flüssigkeit, rechts Dampf; zu kleinen Temperaturen gehören außerdem Feststoff und dessen Koexistenzbereiche. Die Tripellinie verbindet die drei Phasen bei Tripeldruck und Tripeltemperatur. Jede Bereichs- und Linienbeschriftung muss zur Achsenwahl passen.
]

#aufgabe(titel: "Altklausur WS 04/05: Kurzfrage 10", art: "verstehen", quelle: "2.3", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 04/05, Kurzfrage 10 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 108* #linebreak()]
Skizziere ein p-v-Diagramm von Wasser für gasförmige, flüssige und feste Phasen und beschrifte wichtige Punkte, Linien und Diagrammbereiche.
][
*Skizze erklären:* p senkrecht, v waagerecht. Siede- und Taulinie schließen das Flüssig-Dampf-Koexistenzgebiet ein und treffen sich im kritischen Punkt. Links liegt Flüssigkeit, rechts Dampf; zu kleinen Temperaturen gehören außerdem Feststoff und dessen Koexistenzbereiche. Die Tripellinie verbindet die drei Phasen bei Tripeldruck und Tripeltemperatur. Jede Bereichs- und Linienbeschriftung muss zur Achsenwahl passen.
]

#aufgabe(titel: "Altklausur WS 01/02: Kurzfrage 3", art: "verstehen", quelle: "2.3", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 01/02, Kurzfrage 3 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 109* #linebreak()]
Skizziere ein p-V-Diagramm von Wasser für gasförmige, flüssige und feste Phasen und beschrifte wichtige Punkte und Diagrammbereiche.
][
*Skizze erklären:* p senkrecht, v waagerecht. Siede- und Taulinie schließen das Flüssig-Dampf-Koexistenzgebiet ein und treffen sich im kritischen Punkt. Links liegt Flüssigkeit, rechts Dampf; zu kleinen Temperaturen gehören außerdem Feststoff und dessen Koexistenzbereiche. Die Tripellinie verbindet die drei Phasen bei Tripeldruck und Tripeltemperatur. Jede Bereichs- und Linienbeschriftung muss zur Achsenwahl passen.
]

#aufgabe(titel: "Sättigung: Druck und Temperatur gekoppelt", art: "verstehen", quelle: "2.3", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 110* #linebreak()]
Was ist die Sättigung, und warum sind dort Druck und Temperatur gekoppelt?
][
*Antwort:*

- Im Gleichgewicht von Flüssigkeit und Dampf eines reinen Stoffes gehört zu jedem Druck genau eine Siedetemperatur: $T = T_s (p)$.
- Damit weiß ich aber noch nicht, wie viel Flüssigkeit und wie viel Dampf da sind.
- Dafür brauche ich eine weitere Angabe, z. B. den Dampfgehalt $x$.

#align(center)[#image("abbildungen/pvt.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Sättigung koppelt Druck und Temperatur; x beschreibt die Massenaufteilung.
][
*Bild:* Die Sättigung ist wie eine Schiene: Der Druck legt die Temperatur fest, wie weit man auf der Schiene ist, sagt erst x.
]

#aufgabe(titel: "Kurzfrage: Sattdampf und unterkühlte Flüssigkeit", art: "verstehen", quelle: "2.4", herkunft: "original", vorlage: "Leistungsnachweis SS 13, Kurzfrage 15", minuten: 3)[
#if not web [*Aufgabe 111* #linebreak()]
Was versteht man unter a) Sattdampf, b) unterkühlter Flüssigkeit?
][
*Antwort:* a) Sattdampf ist Dampf auf der Taulinie, $x = 1$: Bei weiterem Wärmeentzug beginnt er zu kondensieren. b) Unterkühlte Flüssigkeit liegt links der Siedelinie: Ihre Temperatur ist kleiner als die Siedetemperatur beim herrschenden Druck, $T < T_s (p)$.
][
*Typische Verwechslung:* $x = 0$ ist siedende (gesättigte) Flüssigkeit auf der Siedelinie, nicht unterkühlte Flüssigkeit. Im unterkühlten Gebiet ist $x$ gar nicht definiert.
]

#aufgabe(titel: "Kurzfrage: Aussagen zum kritischen Punkt", art: "verstehen", quelle: "2.4", herkunft: "original", vorlage: "Leistungsnachweis WS 13/14, Kurzfrage 5", minuten: 3)[
#if not web [*Aufgabe 112* #linebreak()]
Welche Aussagen gelten im kritischen Punkt eines Stoffes, und warum? Die Verdampfungsenthalpie ist minimal; die Dichten von Flüssigkeit und Gas sind gleich; die kritische Isotherme hat einen Wendepunkt; die Entropien von Flüssigkeit und Gas sind gleich.
][
*Antwort:* Alle vier gelten. Am kritischen Punkt fallen Siede- und Taulinie zusammen: $v' = v''$ (gleiche Dichte), $s' = s''$ und $h' = h''$, also $r = h'' - h' = 0$, den kleinstmöglichen Wert.
][
*Isotherme:* Die kritische Isotherme hat dort einen Wendepunkt mit waagerechter Tangente (Sattelpunkt) im p,v-Diagramm. Oberhalb gibt es keinen Phasenübergang mit getrennten Phasen mehr.
]

#aufgabe(titel: "Kurzfrage: Verdampfungsenthalpie am kritischen Punkt", art: "verstehen", quelle: "2.4", herkunft: "original", vorlage: "Leistungsnachweis WS 11/12, Aufg. 0b", minuten: 3)[
#if not web [*Aufgabe 113* #linebreak()]
Wie ist die Verdampfungsenthalpie definiert? Was folgt für ihren Wert am kritischen Punkt?
][
*Definition:* $r = h'' - h'$ beim selben Druck (und damit derselben Sättigungstemperatur): die Enthalpie, die 1 kg siedende Flüssigkeit zum vollständigen Verdampfen isobar aufnimmt.
][
*Kritischer Punkt:* Dort sind gesättigte Flüssigkeit und gesättigter Dampf nicht mehr unterscheidbar, $h' = h''$, also $r = 0$.
]

#aufgabe(titel: "Altklausur WS 05/06: Kurzfrage 6", art: "verstehen", quelle: "2.4", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 05/06, Kurzfrage 6 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 114* #linebreak()]
Erläutere den Unterschied zwischen Flüssigkeit und Dampf oberhalb des kritischen Punktes.
][
*Antwort:* Am kritischen Punkt werden gesättigte Flüssigkeit und gesättigter Dampf ununterscheidbar: $v'=v''$, $rho'=rho''$, $s'=s''$, $h'=h''$ und die Verdampfungsenthalpie geht gegen null. Oberhalb der kritischen Temperatur gibt es keine durch Druckerhöhung herstellbare Flüssig-Dampf-Phasengrenze. Der kritische Druck ist kein maximal möglicher Druck; der Tripelpunkt ist ein anderer Zustand.
]

#aufgabe(titel: "Altklausur WS 03/04: Kurzfrage 5", art: "verstehen", quelle: "2.4", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 03/04, Kurzfrage 5 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 115* #linebreak()]
Was versteht man unter a) Sattdampf und b) unterkühlter Flüssigkeit?
][
*Antwort:* Sattdampf ist gerade vollständig verdampft und liegt auf der Taulinie ($x=1$). Unterkühlte Flüssigkeit hat bei gleichem Druck eine niedrigere Temperatur als die Sättigungstemperatur. Nassdampf ist ein Gleichgewichtsgemisch aus gesättigter Flüssigkeit und gesättigtem Dampf mit $0<x<1$.
]

#aufgabe(titel: "Altklausur WS 02/03: Kurzfrage 4", art: "verstehen", quelle: "2.4", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 02/03, Kurzfrage 4 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 116* #linebreak()]
Was versteht man unter Nassdampf?
][
*Antwort:* Sattdampf ist gerade vollständig verdampft und liegt auf der Taulinie ($x=1$). Unterkühlte Flüssigkeit hat bei gleichem Druck eine niedrigere Temperatur als die Sättigungstemperatur. Nassdampf ist ein Gleichgewichtsgemisch aus gesättigter Flüssigkeit und gesättigtem Dampf mit $0<x<1$.
]

#aufgabe(titel: "Altklausur WS 99/00 PF: Kurzfrage 5", art: "verstehen", quelle: "2.4", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 99/00 PF, Kurzfrage 5 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 117* #linebreak()]
Welche Aussagen zu Verdampfungsenthalpie, Dichte, kritischer Isotherme und Entropie von Flüssigkeit und Gas gelten am kritischen Punkt?
][
*Antwort:* Am kritischen Punkt werden gesättigte Flüssigkeit und gesättigter Dampf ununterscheidbar: $v'=v''$, $rho'=rho''$, $s'=s''$, $h'=h''$ und die Verdampfungsenthalpie geht gegen null. Oberhalb der kritischen Temperatur gibt es keine durch Druckerhöhung herstellbare Flüssig-Dampf-Phasengrenze. Im üblichen glatten p-v-Modell besitzt die kritische Isotherme dort einen waagerechten Wendepunkt: erste und zweite Ableitung nach v verschwinden. Der kritische Druck ist kein maximal möglicher Druck; der Tripelpunkt ist ein anderer Zustand.
]

#aufgabe(titel: "Altklausur WS 99/00 LN: Kurzfrage 4", art: "verstehen", quelle: "2.4", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 99/00 LN, Kurzfrage 4 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 118* #linebreak()]
Was gilt am kritischen Punkt für Verflüssigung, Dichte, Verdampfungsenthalpie, Druck und koexistierende Phasen? Grenze ihn vom Tripelpunkt ab.
][
*Antwort:* Am kritischen Punkt werden gesättigte Flüssigkeit und gesättigter Dampf ununterscheidbar: $v'=v''$, $rho'=rho''$, $s'=s''$, $h'=h''$ und die Verdampfungsenthalpie geht gegen null. Oberhalb der kritischen Temperatur gibt es keine durch Druckerhöhung herstellbare Flüssig-Dampf-Phasengrenze. Der kritische Druck ist kein maximal möglicher Druck; der Tripelpunkt ist ein anderer Zustand.
]

#aufgabe(titel: "Unterkühlt, Nassdampf, Sattdampf, überhitzt", art: "verstehen", quelle: "2.4", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 119* #linebreak()]
Wodurch unterscheiden sich unterkühlte Flüssigkeit, Nassdampf, Sattdampf und überhitzter Dampf?
][
*Kurz gesagt:* Unterkühlt: $T<T_s(p)$. Nassdampf: beide Phasen. Sattdampf: gesättigter Dampf am Rand $x=1$. Überhitzt: $T>T_s(p)$.
][
*Ausführlich:*

- *Unterkühlte Flüssigkeit:* $T < T_s (p)$.
- *Siedelinie:* gesättigte Flüssigkeit, $x = 0$.
- *Nassdampf:* beide Phasen zugleich, 0 \< x \< 1.
- *Taulinie / Sattdampf:* $x = 1$.
- *Überhitzter Dampf:* $T > T_s (p)$.
- „Unterkühlt“ und „überhitzt“ beziehen sich auf die Siedetemperatur, nicht auf das Gefühl warm oder kalt.

#align(center)[#image("abbildungen/phase-dome.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Kritischer Punkt und Tripelpunkt", art: "verstehen", quelle: "2.4", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 120* #linebreak()]
Was verschwindet am kritischen Punkt? Was koexistiert am Tripelpunkt?
][
*Kurz gesagt:* Kritischer Punkt: Unterschiede zwischen koexistierender Flüssigkeit und Dampf verschwinden. Tripelpunkt: feste, flüssige und gasförmige Phase koexistieren.
][
*Ausführlich:*

- Am Tripelpunkt existieren fest, flüssig und gasförmig gleichzeitig im Gleichgewicht (Wasser: 0,01 °C, 612 Pa).
- Am kritischen Punkt verschwindet dagegen der Unterschied zwischen Flüssigkeit und Dampf.
- Der eine Punkt hat drei unterscheidbare Phasen, der andere gar keine Phasengrenze mehr.

#align(center)[#image("abbildungen/triple.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Was am kritischen Punkt geschieht", art: "verstehen", quelle: "2.4", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 121* #linebreak()]
Was passiert am kritischen Punkt?
][
*Antwort:*

- Flüssigkeit und Dampf werden ununterscheidbar: $v'' - v'$ und die Verdampfungsenthalpie gehen gegen null.
- Die Flüssig-Dampf-Grenze endet dort.
- *Wasser:* etwa 220,6 bar und 647 K.

#align(center)[#image("abbildungen/phase-dome.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „Dort bestehen Eis, Wasser und Dampf nebeneinander.“: Das ist der Tripelpunkt, nicht der kritische Punkt.
- „Die Verdampfungsenthalpie ist dort am größten.“: Sie wird zum kritischen Punkt hin kleiner und verschwindet dort.
]

#aufgabe(titel: "Kurzfrage: Was beim isobaren Kondensieren konstant bleibt", art: "verstehen", quelle: "2.5", herkunft: "original", vorlage: "Leistungsnachweis WS 13/14, Kurzfrage 2", minuten: 3)[
#if not web [*Aufgabe 122* #linebreak()]
Welche Zustandsgrößen bleiben beim isobaren Kondensieren konstant?
][
*Antwort:* Druck und Temperatur, solange beide Phasen vorhanden sind; ebenso die Sättigungswerte $v'$, $v''$, $h'$, $h''$, $s'$, $s''$.
][
*Was sich ändert:* der Dampfgehalt $x$ und damit $v$, $h$, $u$, $s$ des Gemisches. Die abgeführte Wärme senkt nicht die Temperatur, sondern verwandelt Dampf in Flüssigkeit.
]

#aufgabe(titel: "Altklausur WS 05/06: Kurzfrage 5", art: "verstehen", quelle: "2.5", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 05/06, Kurzfrage 5 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 123* #linebreak()]
Welche Zustandsgröße bleibt beim isobaren Kondensieren außer dem Druck gleich?
][
*Antwort:* Bei einem reinen Stoff im Phasengleichgewicht bleiben Druck und Sättigungstemperatur gekoppelt. Beim isobaren Kondensieren bleibt deshalb auch T konstant, solange beide Phasen vorhanden sind. Enthalpie, Entropie und spezifisches Volumen ändern sich mit dem Dampfgehalt.
]

#aufgabe(titel: "Altklausur WS 04/05: Kurzfrage 5", art: "verstehen", quelle: "2.5", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 04/05, Kurzfrage 5 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 124* #linebreak()]
Wie hängt die Verdampfungsenthalpie von der Temperatur ab?
][
*Antwort:* Entlang der Flüssig-Dampf-Sättigung nimmt die Verdampfungsenthalpie bei steigender Temperatur bzw. steigendem Sättigungsdruck ab und geht am kritischen Punkt gegen null. Gemeint ist $h''-h'$ bei derselben Sättigung, keine Differenz beliebiger Tabellenpunkte.
]

#aufgabe(titel: "Altklausur WS 03/04: Kurzfrage 6", art: "verstehen", quelle: "2.5", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 03/04, Kurzfrage 6 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 125* #linebreak()]
Wie hängt die Verdampfungsenthalpie vom Druck ab?
][
*Antwort:* Entlang der Flüssig-Dampf-Sättigung nimmt die Verdampfungsenthalpie bei steigender Temperatur bzw. steigendem Sättigungsdruck ab und geht am kritischen Punkt gegen null. Gemeint ist $h''-h'$ bei derselben Sättigung, keine Differenz beliebiger Tabellenpunkte.
]

#aufgabe(titel: "Altklausur WS 02/03: Kurzfrage 5", art: "verstehen", quelle: "2.5", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 02/03, Kurzfrage 5 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 126* #linebreak()]
Wie hängt die Verdampfungsenthalpie von der Temperatur ab?
][
*Antwort:* Entlang der Flüssig-Dampf-Sättigung nimmt die Verdampfungsenthalpie bei steigender Temperatur bzw. steigendem Sättigungsdruck ab und geht am kritischen Punkt gegen null. Gemeint ist $h''-h'$ bei derselben Sättigung, keine Differenz beliebiger Tabellenpunkte.
]

#aufgabe(titel: "Warum Verdampfen viel Energie braucht", art: "verstehen", quelle: "2.5", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 127* #linebreak()]
Warum braucht das Verdampfen von Wasser so viel Energie?
][
*Antwort:*

- Beim Verdampfen müssen die Moleküle voneinander gelöst werden, und das Volumen wächst stark.
- Für 1 kg Wasser braucht das Verdampfen etwa 2257 kJ, das Erwärmen von 0 auf 100 °C nur etwa 417 kJ.

#align(center)[#image("abbildungen/five-states.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Isobares Verdampfen im Zylinder", art: "verstehen", quelle: "2.5", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 128* #linebreak()]
Was passiert beim isobaren Verdampfen in einem Zylinder mit Kolben?
][
*Antwort:*

- Unterkühlte Flüssigkeit wird bis zur Siedetemperatur warm.
- Dann verdampft sie bei gleichem Druck und gleicher Temperatur, der Dampfanteil und das Volumen wachsen stark, der Kolben hebt sich.
- Erst wenn alles verdampft ist, steigt die Temperatur des Dampfes wieder.

#align(center)[#image("abbildungen/five-states.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Überkritisch erwärmen", art: "verstehen", quelle: "2.6", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 129* #linebreak()]
Warum benötigt auch ein überkritischer Erwärmungsweg Energie, obwohl er keine gewöhnliche Verdampfungsenthalpie besitzt?
][
*Kurz gesagt:* Seine Enthalpie steigt kontinuierlich. Es entfällt der separate latente Phasensprung, nicht der Energiebedarf für die Zustandsänderung.
][
*Ausführlich:*

- Oberhalb des kritischen Drucks gibt es keinen Siedevorgang mit zwei Phasen.
- Die Eigenschaften ändern sich fließend von flüssigkeitsähnlich zu gasähnlich.
- Der Energiebedarf bleibt aber, die Enthalpie steigt weiter.
- Es fehlt nur der sprunghafte Phasenwechsel.

#align(center)[#image("abbildungen/supercritical.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Isochor erwärmen: v gegen v_kr", art: "verstehen", quelle: "2.7", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 130* #linebreak()]
Welche Rolle spielt $v$ im Vergleich zu $v_"kr"$ beim isochoren Erwärmen von Nassdampf?
][
*Kurz gesagt:* Bei $v>v_"kr"$ Austritt aus dem Zweiphasengebiet zur Dampfseite; bei $v<v_"kr"$ zur Flüssigkeitsseite. Nach vollständiger Raumausfüllung durch Flüssigkeit kann der Druck stark steigen.
][
*Ausführlich:*

- Im starren, geschlossenen Behälter bleibt $v = V\/m$ konstant.
- Ist $v$ größer als $v_"kr"$, verlässt der Stoff das Nassdampfgebiet zur Dampfseite.
- Ist $v$ kleiner, endet er auf der Flüssigkeitsseite, danach kann der Druck stark steigen.
- Mehr Wärme heißt also nicht immer mehr Dampf.

#align(center)[#image("abbildungen/isochoric.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „Zur Dampfseite, weil Erhitzen immer mehr Dampf erzeugt.“: Das gilt nur für $v > v_"kr"$. Mehr Wärme heißt nicht bei jeder Randbedingung mehr Dampf.
- „Genau durch den kritischen Punkt.“: Das ist der idealisierte Grenzfall $v = v_"kr"$.
]

#aufgabe(titel: "Altklausur WS 99/00 PF: Kurzfrage 4", art: "verstehen", quelle: "2.9", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 99/00 PF, Kurzfrage 4 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 131* #linebreak()]
Wie stellt sich eine Nassdampfisotherme eines realen Stoffes im p-T-Diagramm dar? Begründe die Darstellung.
][
*Antwort:* Bei fester Sättigungstemperatur ist auch der Sättigungsdruck fest. Verschiedene Dampfgehalte haben daher im p-T-Diagramm denselben Punkt auf der Dampfdruckkurve. Das Zweiphasengebiet ist dort keine Fläche.
]

#aufgabe(titel: "Altklausur WS 99/00 PF: Kurzfrage 6", art: "verstehen", quelle: "2.9", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 99/00 PF, Kurzfrage 6 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 132* #linebreak()]
In $h=h'+x(h''-h')$ kommt der Druck nicht ausdrücklich vor. Warum hängt die Enthalpie dennoch vom Zustand ab? Welche Besonderheit hat die Darstellung $h(p,T)$ im Nassdampfgebiet?
][
*Antwort:* $h=h'(p)+x[h''(p)-h'(p)]$ enthält p über die Sättigungswerte h′ und h″. Im Nassdampf sind p und T gekoppelt und nicht unabhängig; $h(p,T)$ allein ist dort ohne Phasenanteil nicht eindeutig. Man braucht z. B. p und x.
]

#aufgabe(titel: "Nassdampf: p und T reichen nicht", art: "verstehen", quelle: "2.9", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 133* #linebreak()]
Warum reichen $p$ und $T$ im Nassdampfgebiet nicht zur Festlegung des Mischungszustands?
][
*Kurz gesagt:* Im Zweiphasengleichgewicht gilt $T=T_s(p)$. Die beiden Angaben sind gekoppelt; der Massenanteil der Phasen bleibt unbekannt.
]

#aufgabe(titel: "Dampfgehalt ist kein Volumenanteil", art: "verstehen", quelle: "2.9", herkunft: "eigen", minuten: 3,
  tipp: [Dampf braucht pro Kilogramm viel mehr Raum als Flüssigkeit.])[
#if not web [*Aufgabe 134* #linebreak()]
Was ist der Dampfgehalt x, und warum ist er kein Volumenanteil?
][
*Antwort:*

- $x = m_"Dampf" \/ m_"gesamt"$.
- Weil Dampf pro kg viel mehr Platz braucht, kann wenig Dampfmasse den größten Teil des Volumens füllen.
- *Beispiel Ammoniak-Ampulle:* 1,2 % der Masse sind Dampf, aber 84 % des Volumens.
- Aus „halb mit Dampf gefüllt“ folgt also nicht „halbe Masse Dampf“.

#align(center)[#image("abbildungen/mass-volume.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Dampfgehalt wiegt Masse, er misst keinen Füllstand.
][
*Bild:* Eine große leere Schachtel und ein kleines Metallstück: viel Platz bedeutet nicht viel Masse.
]

#aufgabe(titel: "Herkunft der Mischungsregel", art: "verstehen", quelle: "2.9", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 135* #linebreak()]
Woher kommt die Mischungsregel y = y′ + x·(y″ − y′)?
][
*Antwort:*

- Jede Phase trägt zum Volumen und zu den Energiegrößen des Gemisches bei.
- Durch die Gesamtmasse teilen → spezifische Größe des Gemisches.
- *Gewichtung:* Flüssigkeit mit $(1 - x)$, Dampf mit $x$.
- Gilt für $v$, $u$, $h$ und $s$.
- Nicht auf $p$ und $T$ anwenden.

#align(center)[#image("abbildungen/mass-volume.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Hebelregel im p-v-Diagramm", art: "verstehen", quelle: "2.9", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 136* #linebreak()]
Was sagt die Hebelregel im p-v-Diagramm?
][
*Antwort:*

- Im Nassdampfgebiet eine waagerechte Verbindung zwischen den Randwerten ziehen.
- *Zähler:* Abstand vom Flüssigkeitsrand $v'$ zum Gemischpunkt $v$.
- *Nenner:* gesamte Breite $v'' - v'$.
$ x = (v - v')/(v'' - v') $
- In der Mitte gilt $x = "0,5"$.

#align(center)[#image("abbildungen/lever.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Nassdampfwerte auf Plausibilität prüfen", art: "verstehen", quelle: "2.9", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 137* #linebreak()]
Wie prüfe ich, ob ein berechneter Nassdampfwert plausibel ist?
][
*Antwort:*

- Für $0 <= x <= 1$ müssen $v$, $h$, $u$ und $s$ zwischen ihren Randwerten ($'$ und $''$) liegen.
- Ein $x > 1$ ist kein Nassdampf mehr, dann ist der Dampf überhitzt und die Mischungsregel gilt nicht.
]

#aufgabe(titel: "Mischungsregel nur im Nassdampf", art: "verstehen", quelle: "2.9", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 138* #linebreak()]
Warum darfst du die Mischungsregel nicht für überhitzten Dampf mit $x > 1$ verwenden?
][
*Antwort:* Die Mischungsregel gewichtet die Sättigungswerte beider Phasen mit ihren Massenanteilen $1 - x$ und $x$. Sie gilt nur im Nassdampfgebiet, also für $0 <= x <= 1$. Überhitzter Dampf ist einphasig und liegt nicht auf der Sättigung; seine Werte stammen aus der Tabelle für überhitzten Dampf bei $p$ und $T$. Ein $x > 1$ ist dort keine sinnvolle Größe.
]

#aufgabe(titel: "Dampfgehalt aus den Massen", art: "rechnen", quelle: "2.9", herkunft: "eigen", minuten: 3,
  ergebnis: [$x = "0,25"$, $m' = "1,5" thin "kg"$],
)[
#if not web [*Aufgabe 139* #linebreak()]
*Gegeben und Annahmen*

Ein Behälter enthält $2 thin "kg"$ Gemisch, darunter $"0,5" thin "kg"$ Dampf.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $x$ und die Flüssigkeitsmasse.],
)
][
*Definition:* Der Dampfgehalt ist der *Massenanteil* des Dampfes am Gemisch: $x = m''\/m$.
][
*Einsetzen:* $x = "0,5"\/2 = "0,25"$. Ein Viertel der Masse ist Dampf.
][
*Flüssigkeit:* Der Rest ist Flüssigkeit, $m' = m - m'' = "1,5" thin "kg"$.
][
*Prüfen:* $x$ liegt zwischen 0 (nur Flüssigkeit) und 1 (nur Dampf). Volumenmäßig ist der Dampf trotzdem fast der ganze Behälter, weil er viel mehr Platz braucht.
]

#aufgabe(titel: "Enthalpie und Volumen im Nassdampf", art: "rechnen", quelle: "2.9", herkunft: "eigen", minuten: 6,
  ergebnis: [$h = "1094,75" thin "kJ/kg"$, $v approx "0,50893" thin "m"^3\/"kg"$],
  tipp: [Ein Nassdampf-Wert liegt zwischen dem Flüssigkeits- und dem Dampfwert, und zwar beim Anteil $x$.],
)[
#if not web [*Aufgabe 140* #linebreak()]
*Gegeben und Annahmen*

Gegeben: $h'="417,5"$, $h''=2675 thin "kJ/kg"$, $v'="0,001043"$, $v''="1,694" thin "m"^3/"kg"$.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $h$ und $v$ für $x="0,3"$.],
)
][
*Mischungsregel verstehen:* 1 kg Nassdampf besteht aus $x$ kg Dampf und $1 - x$ kg Flüssigkeit. Jeder Teil bringt seinen spezifischen Wert mit: $h = (1 - x) h' + x h'' = h' + x(h'' - h')$. Das ist ein Hebel zwischen den beiden Randwerten.
][
*Enthalpie:* $h = "417,5" + "0,3" dot (2675 - "417,5") = "417,5" + "677,25" = "1094,75" thin "kJ/kg"$.
][
*Volumen:* $v = "0,001043" + "0,3" dot ("1,694" - "0,001043") approx "0,50893" thin "m"^3\/"kg"$.
][
*Prüfen:* Beide Werte liegen zwischen den Randwerten. Beim Volumen dominiert der Dampf fast völlig, obwohl nur 30 % der Masse Dampf sind.
]

#aufgabe(titel: "Dampfgehalt aus der Enthalpie", art: "rechnen", quelle: "2.9", herkunft: "eigen", minuten: 4,
  ergebnis: [$x approx "0,631"$],
)[
#if not web [*Aufgabe 141* #linebreak()]
*Gegeben und Annahmen*

$h=2200 thin "kJ/kg"$, $h'=1827 thin "kJ/kg"$, $h''=2418 thin "kJ/kg"$; Nassdampf im Sättigungszustand.

*Gesucht*

#enum(numbering: "a)",
[Bestimme den Dampfgehalt $x$.],
)
][
*Hebelregel rückwärts:* Aus $h = h' + x(h'' - h')$ wird $x = (h - h')\/(h'' - h')$. Gefragt ist: Welcher Bruchteil des Wegs von $h'$ nach $h''$ ist schon zurückgelegt?
][
*Einsetzen:* $x = (2200 - 1827)\/(2418 - 1827) = 373\/591 approx "0,631"$.
][
*Prüfen:* $h$ liegt etwas über der Mitte zwischen 1827 und 2418, also muss $x$ etwas über 0,5 liegen.
]

#aufgabe(titel: "Ammoniak: wenig Dampfmasse, viel Dampfvolumen", art: "rechnen", quelle: "2.9", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.3", minuten: 10)[
#if not web [*Aufgabe 142* #linebreak()]
*Ammoniak-Ampulle, Ü 2.3:*

*Gegeben und Annahmen*

$V="14,8" thin "cm"^3$, $m="1,63" thin "g"$, $theta=-20 thin "°C"$. Verwende aus BT $v'="0,00150"$ und $v''="0,62280" thin "m"^3/"kg"$.

*Gesucht*

#enum(numbering: "a)",
[Bestimme Dampfgehalt, Dampfvolumen und Flüssigkeitsvolumenanteil.],
)
][
*Erst umrechnen:* $V="14,8" times 10^(-6) thin "m"^3$, $m="1,63" times 10^(-3) thin "kg"$. Das spezifische Gesamtvolumen ist:
$ v=V/m approx "0,00907975" thin "m"^3/"kg" $
Es liegt zwischen $v'$ und $v''$: Das Zweiphasenmodell ist plausibel. Mit der Hebelregel:
$ x=("0,00907975"-"0,00150")/("0,62280"-"0,00150") approx "0,01220" $
Das sind *1,22 Prozent der Masse*. Die Dampfmasse beträgt etwa $"0,01989" thin "g"$. Das Dampfvolumen folgt aus der Dampfmasse, nicht aus $x V$:
$ V''=x m v'' approx "12,385" thin "cm"^3 $
Somit $V'="14,8"-"12,385" approx "2,415" thin "cm"^3$. Die Flüssigkeit belegt rund *16,32 Prozent des Volumens*, der Dampf 83,68 Prozent. *Fehlerquelle:* 1,22 Prozent Dampfmasse mit 1,22 Prozent Dampfvolumen gleichsetzen. Leichte Abweichungen von gerundeten Buchergebnissen entstehen durch das Runden der Zwischenwerte.
]

#aufgabe(titel: "Ammoniak in einer größeren Ampulle (Variante)", art: "rechnen", quelle: "2.9", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.3", minuten: 8,
  ergebnis: [$x approx "0,0105"$; $V'' approx "16,29" thin "cm"^3$; Flüssigkeit $approx "18,6" %$ des Volumens])[
#if not web [*Aufgabe 143* #linebreak()]
*Gegeben und Annahmen*

Eine Glasampulle mit $20 thin "cm"^3$ enthält $"2,5" thin "g"$ Ammoniak bei −20 °C im Nassdampfzustand. Dampftafel: $v' = "0,00150"$, $v'' = "0,62280" thin "m"^3/"kg"$.

*Gesucht*

#enum(numbering: "a)",
[Dampfgehalt und Dampfvolumen.],
[Welchen Anteil des Rauminhalts nimmt die Flüssigkeit ein?],
)
][
*Dampfgehalt:* $v = V\/m = 20 times 10^(-6)\/"2,5" times 10^(-3) = "0,008" thin "m"^3/"kg"$, zwischen $v'$ und $v''$. $x = ("0,008" - "0,0015")\/("0,6228" - "0,0015") approx "0,0105"$.
][
*Volumina:* $V'' = x m v'' approx "0,01046" dot "2,5" times 10^(-3) dot "0,6228" thin "m"^3 approx "16,29" thin "cm"^3$; die Flüssigkeit füllt $"3,71" thin "cm"^3$, also rund 18,6 %. Gut 1 % der Masse belegt über 80 % des Raums.
]

#aufgabe(titel: "Ammoniak im Wärmeübertrager: Volumenströme und Rohrdurchmesser", art: "rechnen", quelle: "2.9", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.4", minuten: 15,
  ergebnis: [$dot(V)_1 approx "0,355" thin "l/s"$, $dot(V)_2 approx "2,160" thin "l/s"$; beide $-30 thin "°C"$; $phi_1 approx "99,14" %$, $phi_2 approx "99,99" %$; $d >= "18,5" thin "mm"$])[
#if not web [*Aufgabe 144* #linebreak()]
*Gegeben und Annahmen*

Durch einen Wärmeübertrager strömen stündlich 8,78 kg Ammoniak bei $p = "1,195" thin "bar"$. An seinem Eintritt sind bereits 15 % des Stromes in Dampf übergegangen, am Ende sind noch 8 % flüssig. Der Druck ist im ganzen Apparat gleich. Dampftafel NH#sub[3] bei 1,195 bar: $vartheta_s = -30 thin "°C"$, $v' = "1,475" times 10^(-3) thin "m"^3/"kg"$, $v'' = "0,9626" thin "m"^3/"kg"$. Beide Phasen strömen mit derselben mittleren Geschwindigkeit.

*Gesucht*

#enum(numbering: "a)",
[Für welche Volumenströme müssen die Strömungsquerschnitte an Ein- und Austritt bemessen werden?],
[Welche Temperaturen hat der Stoffstrom an Ein- und Austritt?],
[Bestimme die volumetrischen Dampfgehalte am Ein- und Austritt.],
[Dimensioniere den konstanten Rohrinnendurchmesser, wenn die maximale Strömungsgeschwindigkeit 8 m/s nicht übersteigen darf.],
)
][
*Dampfgehalte und spezifische Volumina:* „15 % in Dampf übergegangen“ heißt $x_1 = "0,15"$; „noch 8 % flüssig“ heißt $x_2 = "0,92"$. Mischungsregel:
$ v_1 = v' + x_1 (v'' - v') = "0,145644" thin "m"^3/"kg" quad quad v_2 = "0,885710" thin "m"^3/"kg" $
][
*Volumenströme:* $dot(m) = "8,78"\/3600 thin "kg/s" = "2,4389" times 10^(-3) thin "kg/s"$:
$ dot(V)_1 = dot(m) v_1 approx "3,552" times 10^(-4) thin "m"^3/"s" quad quad dot(V)_2 = dot(m) v_2 approx "2,160" times 10^(-3) thin "m"^3/"s" $
Der Massenstrom bleibt, der Volumenstrom wächst um das Sechsfache, weil Dampf viel mehr Raum braucht.
][
*Temperaturen:* Ein- und Austritt liegen im Nassdampfgebiet beim selben Druck. Dort ist die Temperatur an den Druck gekoppelt: $vartheta_1 = vartheta_2 = vartheta_s (1,195 thin "bar") = -30 thin "°C"$. Die zugeführte Wärme verdampft Flüssigkeit, statt die Temperatur zu heben.
][
*Volumetrische Dampfgehalte:* Anteil des Dampfvolumens am Gesamtvolumen, $phi = x v''\/v$:
$ phi_1 = ("0,15" dot "0,9626")/"0,145644" approx "0,9914" quad quad phi_2 = ("0,92" dot "0,9626")/"0,885710" approx "0,9999" $
Schon am Eintritt füllt der Dampf über 99 % des Querschnitts, obwohl er nur 15 % der Masse ausmacht.
][
*Rohrdurchmesser:* Die größte Geschwindigkeit tritt beim größten Volumenstrom auf, also am Austritt. Aus $dot(V)_2 = pi d^2\/4 dot w_"max"$:
$ d = sqrt((4 dot(V)_2)/(pi w_"max")) = sqrt((4 dot "2,160" times 10^(-3))/(pi dot 8)) thin "m" approx "18,5" thin "mm" $
Der Innendurchmesser muss mindestens 18,5 mm betragen; am Eintritt ist das Rohr dann reichlich bemessen.
]

#aufgabe(titel: "Ammoniak im Wärmeübertrager mit 12 kg/h (Variante)", art: "rechnen", quelle: "2.9", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.4", minuten: 12,
  ergebnis: [$dot(V)_1 approx "0,646" thin "l/s"$, $dot(V)_2 approx "3,048" thin "l/s"$; $phi_1 approx "99,39" %$, $phi_2 approx "99,99" %$; $d >= "25,4" thin "mm"$])[
#if not web [*Aufgabe 145* #linebreak()]
*Gegeben und Annahmen*

12 kg/h Ammoniak strömen isobar bei $p = "1,195" thin "bar"$ durch einen Verdampfer. Eintritt $x_1 = "0,20"$, Austritt $x_2 = "0,95"$. Dampftafel: $vartheta_s = -30 thin "°C"$, $v' = "1,475" times 10^(-3)$, $v'' = "0,9626" thin "m"^3/"kg"$. Beide Phasen strömen gleich schnell; die Geschwindigkeit darf 6 m/s nicht überschreiten.

*Gesucht*

#enum(numbering: "a)",
[Die Volumenströme an Ein- und Austritt.],
[Die volumetrischen Dampfgehalte.],
[Den kleinsten zulässigen konstanten Rohrdurchmesser.],
)
][
*Volumenströme:* $dot(m) = 12\/3600 = "3,333" times 10^(-3) thin "kg/s"$;
$ v_1 = v' + "0,20"(v''-v') = "0,19370" thin "m"^3/"kg" quad v_2 = "0,91454" thin "m"^3/"kg" $
$ dot(V)_1 = dot(m) v_1 approx "6,457" times 10^(-4) thin "m"^3/"s" quad dot(V)_2 = dot(m) v_2 approx "3,048" times 10^(-3) thin "m"^3/"s" $
][
*Volumetrische Dampfgehalte:* $phi = x v''\/v$: $phi_1 = "0,2" dot "0,9626"\/"0,19370" approx "0,9939"$, $phi_2 approx "0,9999"$. Die Temperatur bleibt überall bei $-30 thin "°C"$.
][
*Durchmesser:* maßgebend ist der Austritt:
$ d = sqrt((4 dot "3,048" times 10^(-3))/(pi dot 6)) thin "m" approx "25,4" thin "mm" $
]

#aufgabe(titel: "Nassdampf im Tropfenabscheider entwässern", art: "rechnen", quelle: "2.9", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.19", minuten: 10,
  ergebnis: [$dot(m)_"ab" = dot(m)_1 (x_2 - x_1)\/x_2$; $dot(m)_2 = dot(m)_1 x_1\/x_2$])[
#if not web [*Aufgabe 146* #linebreak()]
*Gegeben und Annahmen*

Ein Massenstrom $dot(m)_1$ an Nassdampf soll vom Dampfgehalt $x_1$ auf den Dampfgehalt $x_2$ isobar in einem Abscheider mechanisch (z. B. mittels Tropfenabscheider) entwässert werden. Abgeschieden wird nur gesättigte Flüssigkeit; der Betrieb ist stationär.

*Gesucht*

#enum(numbering: "a)",
[Skizziere die Zustände ① und ② in einem p,v-, in einem p,T- und in einem T,s-Diagramm.],
[Berechne den abgeschiedenen Wasserstrom $dot(m)_"ab" (x_1, x_2, dot(m)_1)$ als Funktion der angegebenen Größen.],
[Wie groß ist der Massenstrom $dot(m)_2$ des entwässerten Dampfes?],
)
][
*a) Skizzen:* Isobar im Nassdampfgebiet heißt auch isotherm. Im p,v-Diagramm liegen ① und ② auf derselben Waagerechten, ② weiter rechts (größeres $x$, größeres $v$). Im p,T-Diagramm fallen beide auf denselben Punkt der Dampfdruckkurve. Im T,s-Diagramm liegen sie auf derselben Waagerechten, ② rechts von ①. Der abgeschiedene Strom liegt auf der Siedelinie.
][
*b) Bilanz der Dampfmasse:* Der Abscheider entfernt nur Flüssigkeit; der Dampfmassenstrom bleibt:
$ x_1 dot(m)_1 = x_2 dot(m)_2 $
Gesamtmassenbilanz $dot(m)_1 = dot(m)_2 + dot(m)_"ab"$:
$ dot(m)_"ab" = dot(m)_1 - dot(m)_1 x_1/x_2 = dot(m)_1 (x_2 - x_1)/x_2 $
][
*c) Entwässerter Dampf:* $dot(m)_2 = dot(m)_1 x_1\/x_2$. Probe: Für $x_2 = x_1$ wird nichts abgeschieden; für $x_2 = 1$ geht die gesamte Flüssigkeit $(1 - x_1) dot(m)_1$ ab.
]

#aufgabe(titel: "Tropfenabscheider mit Zahlen (Variante)", art: "rechnen", quelle: "2.9", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.19", minuten: 5,
  ergebnis: [$dot(m)_2 approx "4,337" thin "kg/s"$; $dot(m)_"ab" approx "0,663" thin "kg/s"$])[
#if not web [*Aufgabe 147* #linebreak()]
*Gegeben und Annahmen*

5 kg/s Nassdampf mit $x_1 = "0,85"$ werden isobar in einem Tropfenabscheider auf $x_2 = "0,98"$ entwässert. Abgeschieden wird nur gesättigte Flüssigkeit.

*Gesucht*

#enum(numbering: "a)",
[Den Massenstrom des entwässerten Dampfes.],
[Den abgeschiedenen Wasserstrom.],
)
][
*Dampf bleibt erhalten:* $dot(m)_2 = dot(m)_1 x_1\/x_2 = 5 dot "0,85"\/"0,98" approx "4,337" thin "kg/s"$.
][
*Abgeschieden:* $dot(m)_"ab" = dot(m)_1 - dot(m)_2 approx "0,663" thin "kg/s"$. Probe: Flüssigkeit vorher $"0,75" thin "kg/s"$, nachher $"4,337" dot "0,02" approx "0,087" thin "kg/s"$; die Differenz ist $"0,663" thin "kg/s"$.
]

#aufgabe(titel: "Kurzfrage: Warum Dampftafeln keine innere Energie nennen", art: "verstehen", quelle: "2.10", herkunft: "original", vorlage: "Leistungsnachweis SS 13, Kurzfrage 11", minuten: 3)[
#if not web [*Aufgabe 148* #linebreak()]
Warum werden in Dampftafeln $T$, $p$, $v$, $h$, $s$ (für die Zustände ′ und ″) angegeben und die innere Energie $u$ oft nicht?
][
*Antwort:* $u$ lässt sich jederzeit aus den Tabellenwerten berechnen: $u = h - p v$. Ein eigener Tabelleneintrag wäre überflüssig.
][
*Warum gerade h:* Technisch wichtige Anlagen sind meist offene, durchströmte Systeme; ihre Energiebilanz enthält die Enthalpie. Für geschlossene Behälter rechnet man $u$ aus $h$ selbst nach.
]

#aufgabe(titel: "Vorgehen beim Ablesen der Dampftafel", art: "verstehen", quelle: "2.10", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 149* #linebreak()]
Wie gehe ich beim Ablesen der Dampftafel vor?
][
*Antwort:*

- *Erst das Zustandsgebiet bestimmen:* Bei gegebenem Druck $T_s (p)$ nachschlagen und mit $T$ vergleichen.
- *Unterkühlt oder überhitzt:* $p$-$T$-Tabelle.
- *Nassdampf:* Sättigungstafel plus $x$.
- Interpolieren schließt nur Lücken zwischen nahen Tabellenwerten im selben Gebiet, nie über Phasengrenzen hinweg.
][
*Merksatz:* Erst das Gebiet, dann die Tabelle.
]

#aufgabe(titel: "Enthalpie bei 200 bar und x = 0,8", art: "verstehen", quelle: "2.10", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 150* #linebreak()]
Bei 200 bar und $x = "0,8"$ ist $h' = 1827$ und $h'' = 2418 thin "kJ/kg"$. Wie groß ist $h$? Zeige, wie du ihn bestimmst, und prüfe das Ergebnis auf Plausibilität.
][
*Antwort:* 2299,8 kJ/kg

$h = h' + x (h'' - h') = 1827 + "0,8" dot 591$.
][
*Typische Verwechslung:*

- „1945,2 kJ/kg“: Hier wurde mit $1 - x$ statt mit $x$ gewichtet.
- „1934,4 kJ/kg“: Das ist $"0,8" dot 2418$, also nur der Dampfanteil ohne die Flüssigkeit.
- „2122,5 kJ/kg“: Das ist der einfache Mittelwert. Er gälte nur bei $x = "0,5"$.
]

#aufgabe(titel: "Altklausur WS 03/04: innere Energie aus der Dampftafel", art: "rechnen", quelle: "2.10", herkunft: "original", minuten: 6, vorlage: "Altklausur WS 03/04, Kurzfrage 7, PDF-S. 1")[
#if not web [*Aufgabe 151* #linebreak()]
*Gegeben:* Überhitztes Wasser bei 800 °C und 100 bar: $v="0,04858"$ m³/kg, $h=4112$ kJ/kg, $s="7,406"$ kJ/(kg K). *Gesucht:* spezifische innere Energie.
][
*Enthalpie zerlegen:* $u=h-p v$. $100$ bar = $10 000$ kPa; kPa·m³/kg = kJ/kg. Also $u=4112-10 000 dot "0,04858"="3626,2"$ kJ/kg. Die Entropie wird hierfür nicht benötigt.
]

#aufgabe(titel: "Altklausur WS 03/04: innere Energie aus der Dampftafel (Variante)", art: "rechnen", quelle: "2.10", herkunft: "variante", minuten: 6, vorlage: "Altklausur WS 03/04, Kurzfrage 7, PDF-S. 1")[
#if not web [*Aufgabe 152* #linebreak()]
*Von KI erstellt.* *Gegeben:* Ein eigener Übungszustand mit $p=80$ bar, $v="0,050"$ m³/kg und $h=3500$ kJ/kg; die Werte sind Vorgaben für die Enthalpiezerlegung, keine behauptete Dampftafelzeile. *Gesucht:* $u$.
][
*Einheiten zuerst:* $p=8000$ kPa. $u=3500-8000 dot "0,050"=3100$ kJ/kg. $p v>0$ erklärt $u<h$.
]

#aufgabe(titel: "Einfache und doppelte Interpolation", art: "rechnen", quelle: "2.10", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 1.10 a, c", minuten: 12)[
#if not web [*Aufgabe 153* #linebreak()]
*Interpolation, Ü 1.10 a und c:*

*Gegeben und Annahmen*

R134a, überhitzter Dampf. Verwende die folgenden Originalwerte aus Ü 1.10 (PDF-S. 7). Zwischen den Punkten wird linear interpoliert.
#tab(columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
 th([p / kPa], [θ / °C], [v / m³/kg], [h / kJ/kg], [s / kJ/(kg K)], [c_p / kJ/(kg K)]),
 [1000], [100], [0,02756], [483,5], [1,8997], [1,0409],
 [1200], [100], [0,02245], [481,2], [1,8802], [1,0630],
 [1000], [110], [0,02859], [493,9], [1,9273], [1,0459],
 [1200], [110], [0,02335], [491,8], [1,9083], [1,0644],
)

*Gesucht*

#enum(numbering: "a)",
[Bestimme bei 100 °C und 1130 kPa $v,h,s,c_p$.],
[Bestimme bei 105,3 °C und 1100 kPa $v,h,c_p$ durch doppelte Interpolation.],
[Prüfe die beiden möglichen Interpolationsreihenfolgen.],
)
][
*Bei 100 °C:* Der Druckanteil beträgt $f_p=(1130-1000)/(1200-1000)="0,65"$. Für jede Eigenschaft gilt $y=y_1000+"0,65"(y_1200-y_1000)$. Daraus:
- $v="0,0242385" thin "m"^3/"kg"$.
- $h="482,005" thin "kJ/kg"$.
- $s="1,887025" thin "kJ/(kg K)"$.
- $c_p="1,055265" thin "kJ/(kg K)"$.

*Bei 105,3 °C und 1100 kPa:* $f_T=("105,3"-100)/(110-100)="0,53"$, $f_p="0,5"$. Zunächst innerhalb beider Druckspalten nach Temperatur:
#tab(columns: (1fr, 1fr, 1fr),
 th([Größe bei 105,3 °C], [1000 kPa], [1200 kPa]),
 [$v$ / m³/kg], [0,0281059], [0,0229270],
 [$h$ / kJ/kg], [489,012], [486,818],
 [$c_p$ / kJ/(kg K)], [1,043550], [1,063742],
)
Bei 1100 kPa liegt der Druck genau in der Mitte. Mitteln der beiden Spalten liefert *$v="0,02551645" thin "m"^3/"kg"$*, *$h="487,915" thin "kJ/kg"$* und *$c_p="1,053646" thin "kJ/(kg K)"$*.

Kontrolle in umgekehrter Reihenfolge: Bei 100 °C ergeben sich $v="0,025005"$, $h="482,35"$, $c_p="1,05195"$; bei 110 °C $v="0,025970"$, $h="492,85"$, $c_p="1,05515"$ in den jeweiligen Tabelleneinheiten. Mit 53 Prozent des Temperaturabstands entstehen dieselben Endwerte. *Prüfung:* Alle Resultate liegen zwischen den zugehörigen Eckwerten; zusätzliche Stellen dienen dem Rechenabgleich und bedeuten keine höhere Messgenauigkeit.
]

#aufgabe(titel: "Kurzfrage: Was den Tripelpunkt kennzeichnet", art: "verstehen", quelle: "2.11", herkunft: "original", vorlage: "Leistungsnachweis SS 14, Kurzfrage 12", minuten: 3)[
#if not web [*Aufgabe 154* #linebreak()]
Was ist charakteristisch für den Tripelpunkt?
][
*Antwort:* Feste, flüssige und gasförmige Phase stehen im thermodynamischen Gleichgewicht nebeneinander. Bei einem reinen Stoff gibt es dafür nur ein Wertepaar aus Druck und Temperatur (Wasser: $"0,01" thin "°C"$, $611 thin "Pa"$).
][
*Zusatz:* Hier treffen sich Dampfdruck-, Schmelz- und Sublimationskurve. Die Verdampfungsenthalpie ist am Tripelpunkt am größten und fällt bis zum kritischen Punkt auf null.
]

#aufgabe(titel: "Was van der Waals korrigiert", art: "verstehen", quelle: "2.12.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 155* #linebreak()]
Welche Schwächen der idealen Gasgleichung korrigiert van der Waals?
][
*Antwort:*

- *Zwei Dinge:* Die Moleküle ziehen sich an (Term $a\/v^2$, verringert den Druck auf die Wand), und sie haben ein Eigenvolumen (Term $-b$, nimmt Platz weg).
- Je dichter das Gas, desto wichtiger werden beide Korrekturen.
]

#aufgabe(titel: "Altklausur WS 04/05: Kurzfrage 11", art: "verstehen", quelle: "2.12.2", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 04/05, Kurzfrage 11 (Import 12.11.2026, PDF-S. 2)")[
#if not web [*Aufgabe 156* #linebreak()]
Was versteht man unter dem Dalton’schen Gesetz?
][
*Antwort:* In einem Gemisch idealer Gase ist der Gesamtdruck die Summe der Partialdrücke: $p_g=sum p_i$. Jedes Einzelgas verhält sich bei gemeinsamer Temperatur so, als würde es allein das Gesamtvolumen einnehmen. Daher $p_i=psi_i p_g$; der Molanteil stimmt beim idealen Gas mit dem Partialvolumenanteil bei gleichem p,T überein.
]

#aufgabe(titel: "Altklausur WS 02/03: Kurzfrage 13", art: "verstehen", quelle: "2.12.2", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 02/03, Kurzfrage 13 (Import 12.11.2026, PDF-S. 2)")[
#if not web [*Aufgabe 157* #linebreak()]
Welcher Zusammenhang gilt zwischen Molanteilen und Raumanteilen im idealen Gas?
][
*Antwort:* In einem Gemisch idealer Gase ist der Gesamtdruck die Summe der Partialdrücke: $p_g=sum p_i$. Jedes Einzelgas verhält sich bei gemeinsamer Temperatur so, als würde es allein das Gesamtvolumen einnehmen. Daher $p_i=psi_i p_g$; der Molanteil stimmt beim idealen Gas mit dem Partialvolumenanteil bei gleichem p,T überein.
]

#aufgabe(titel: "Massenanteil und Molanteil", art: "verstehen", quelle: "2.12.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 158* #linebreak()]
Luft enthält „23 %“ und „21 %“ Sauerstoff. Wie passt das zusammen?
][
*Kurz gesagt:* 23 % ist der *Massenanteil* $xi_"O2"$, 21 % der *Molanteil* $psi_"O2"$. Sauerstoffmoleküle sind schwerer als der Durchschnitt der Luft ($32>"28,96" thin "kg/kmol"$), darum ist ihr Massenanteil größer: $xi=psi M_i/M_g="0,2099" dot 32/"28,964" approx "0,232"$.
][
*Ausführlich:*

- 23 % ist der Massenanteil $xi$, 21 % der Molanteil $psi$.
- Sauerstoff-Moleküle sind schwerer als Stickstoff-Moleküle, deshalb ist ihr Massenanteil größer.
- Eine Prozentangabe braucht immer ihre Bezugsgröße.

#align(center)[#image("abbildungen/mixing.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „Das sind 21 Massen-%.“: Nach Masse sind es rund 23 %, weil Sauerstoff schwerer ist als Stickstoff.
- „Massen- und Molanteil sind bei Luft gleich.“: Sie wären nur gleich, wenn alle Komponenten dieselbe Molmasse hätten.
]

#aufgabe(titel: "Partialdruck oder Partialvolumen: der Unterschied", art: "verstehen", quelle: "2.12.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 159* #linebreak()]
Was ist der Unterschied zwischen Partialdruck und Partialvolumen in einem Gasgemisch?
][
*Antwort:*

- *Partialdruck:* der Druck, den eine Komponente allein im ganzen Gemischvolumen hätte.
- Die Partialdrücke addieren sich zum Gesamtdruck.
- *Partialvolumen:* das Volumen, das eine Komponente allein beim Gemischdruck einnähme.
- Die Partialvolumina addieren sich zum Gesamtvolumen.
- *Bei idealen Gasen gilt beides:* $p_i\/p = V_i\/V = psi_i$ (Molanteil).

#align(center)[#image("abbildungen/mixing.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Feuchter Stickstoff", art: "rechnen", quelle: "2.12.2", herkunft: "variante", vorlage: "Lehrbuch BT, Beispiel 3.9", minuten: 10,
  ergebnis: [$M_g = "27,08" thin "kg/kmol"$; $xi_"H2O" approx "0,093"$, $xi_"CO2" approx "0,049"$, $xi_"N2" approx "0,858"$],
)[
#if not web [*Aufgabe 160* #linebreak()]
*Feuchter Stickstoff, BT Beispiel 3.9:*

*Gegeben und Annahmen*

100 kmol Gemisch enthalten 14 kmol Wasserdampf ($M=18$), 3 kmol CO#sub[2] ($M=44$), Rest N#sub[2] ($M=28 thin "kg/kmol"$).

*Gesucht*

#enum(numbering: "a)",
[Bestimme $M_g$ und die Massenanteile.],
)
][
*Rest bestimmen:* $n_"N2" = 100 - 14 - 3 = 83 thin "kmol"$.
][
*Massen aus Stoffmengen:* $m_i = n_i M_i$: N#sub[2] $83 dot 28 = 2324 thin "kg"$, H#sub[2]O $14 dot 18 = 252 thin "kg"$, CO#sub[2] $3 dot 44 = 132 thin "kg"$. Zusammen $2708 thin "kg"$.
][
*Mittlere Molmasse:* Gesamtmasse durch Gesamtstoffmenge: $M_g = 2708\/100 = "27,08" thin "kg/kmol"$.
][
*Massenanteile:* $xi_"H2O" = 252\/2708 approx "0,093"$, $xi_"CO2" = 132\/2708 approx "0,049"$, $xi_"N2" = 2324\/2708 approx "0,858"$.
][
*Prüfen:* Die Anteile summieren sich zu 1. Wasser ist leichter als der Durchschnitt (18 < 27,08), deshalb ist sein Massenanteil (9,3 %) kleiner als sein Molanteil (14 %).
]

#aufgabe(titel: "Stickstoff-Sauerstoff-Gemisch", art: "rechnen", quelle: "2.12.2", herkunft: "eigen", minuten: 10,
  ergebnis: [$psi_"N2" approx "0,667"$, $psi_"O2" approx "0,333"$; $M_g approx "29,344" thin "kg/kmol"$; $xi_"N2" approx "0,6365"$, $xi_"O2" approx "0,3635"$; $R_g approx "283,3" thin "J/(kg K)"$],
  tipp: [Molanteile kommen direkt aus den kmol. Für die Massenanteile brauchst du zuerst die mittlere Molmasse.],
)[
#if not web [*Aufgabe 161* #linebreak()]
*Gemisch:*

*Gegeben und Annahmen*

2 kmol N#sub[2] und 1 kmol O#sub[2] werden gemischt ($M_"N2"="28,016"$, $M_"O2"=32 thin "kg/kmol"$). Universelle Gaskonstante für diese Rechnung: $R_m="8314,3" thin "J/(kmol K)"$.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $psi_i$, $M_g$, $xi_i$ und $R_g$.],
)
][
*Molanteile zählen Teilchen:* Insgesamt 3 kmol. $psi_"N2" = 2\/3 approx "0,6667"$, $psi_"O2" = 1\/3 approx "0,3333"$.
][
*Mittlere Molmasse:* Wie viel wiegt ein „durchschnittliches“ Kilomol Gemisch? Jede Sorte trägt ihren Teilchenanteil mal ihre Molmasse bei: $M_g = sum psi_i M_i = "0,6667" dot "28,016" + "0,3333" dot 32 approx "29,344" thin "kg/kmol"$.
][
*Massenanteile:* Eine Sorte, die schwerer ist als der Durchschnitt, hat einen größeren Massen- als Molanteil: $xi_i = psi_i M_i\/M_g$. $xi_"N2" = "0,6667" dot "28,016"\/"29,344" approx "0,6365"$, $xi_"O2" approx "0,3635"$.
][
*Gaskonstante:* $R_g = R_m\/M_g = "8314,3"\/"29,344" approx "283,3" thin "J/(kg K)"$.
][
*Prüfen auf zweitem Weg:* Massengewichtet: $sum xi_i R_i = "0,6365" dot "296,8" + "0,3635" dot "259,8" approx "283,3" thin "J/(kg K)"$. Beide Anteile summieren sich jeweils zu 1.
]

#aufgabe(titel: "Partialdruck und Partialvolumen", art: "rechnen", quelle: "2.12.2", herkunft: "eigen", minuten: 6)[
#if not web [*Aufgabe 162* #linebreak()]
*Partialgrößen, eigenes Zahlenbeispiel nach N S. 2:*

*Gegeben und Annahmen*

Ein ideales Gasgemisch enthält 25 Mol-% A bei $p_g=2 thin "bar"$ und $V_g=4 thin "m"^3$.

*Gesucht*

#enum(numbering: "a)",
[Bestimme den Partialdruck und das Partialvolumen von A.],
[Warum widersprechen sich die Aussagen „gleicher Druck“ und „kleinerer Druck“ hier nicht?],
)
][
*Modell:* ideale Gase bei gemeinsamer Temperatur. $psi_A="0,25"$.
][
*Gesamtes Volumen festhalten:* $p_A=psi_A p_g="0,25" dot 2 thin "bar"$. Ergebnis: *$p_A="0,5" thin "bar"$*.
][
*Gemischdruck festhalten:* $V_A=psi_A V_g="0,25" dot 4 thin "m"^3$. Ergebnis: *$V_A=1 thin "m"^3$*.
][
*Prüfung:* Beide Anteile sind 25 Prozent; $p_A V_g=p_g V_A=2 thin "bar m"^3$. Beim Partialdruck füllt A allein 4 m³, beim Partialvolumen allein 1 m³. Deshalb gehören die beiden Druckaussagen zu verschiedenen gedanklichen Zuständen.
]

#aufgabe(titel: "Gemisch aus Luft, Methan und Ethan", art: "rechnen", quelle: "2.12.2", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.8", minuten: 12,
  ergebnis: [$psi$: 0,531 / 0,432 / 0,037; $xi$: 0,657 / 0,296 / 0,047; $M approx "23,42" thin "kg/kmol"$; $R approx 355 thin "J/(kg K)"$])[
#if not web [*Aufgabe 163* #linebreak()]
*Gegeben und Annahmen*

Ein Gemisch besteht aus 10,4 kmol trockener Luft, 8,46 kmol Methan (CH#sub[4]) und 0,72 kmol Ethan (C#sub[2]H#sub[6]). Molmassen: Luft $"28,96"$, Methan $"16,04"$, Ethan $"30,07" thin "kg/kmol"$; $R_m = "8314,3" thin "J/(kmol K)"$. Alle Komponenten verhalten sich wie ideale Gase.

*Gesucht*

#enum(numbering: "a)",
[Bestimme in tabellarischer Rechnung die Mol- und Massenanteile der Komponenten.],
[Bestimme die Molmasse des Gemisches.],
[Bestimme die Gaskonstante des Gemisches.],
)
][
*Tabelle aufstellen:* Molanteil $psi_i = n_i\/n$, Masse $m_i = n_i M_i$, Massenanteil $xi_i = m_i\/m$. Gesamtstoffmenge $n = "19,58" thin "kmol"$.
#tab(columns: (1.2fr, 1fr, 1fr, 1fr, 1fr),
 th([Komponente], [$n_i$ in kmol], [$psi_i$], [$m_i$ in kg], [$xi_i$]),
 [Luft], [10,40], [0,5312], [301,18], [0,6568],
 [Methan], [8,46], [0,4321], [135,70], [0,2959],
 [Ethan], [0,72], [0,0368], [21,65], [0,0472],
 [Summe], [19,58], [1,0000], [458,53], [1,0000],
)
Methan stellt 43 % der Moleküle, aber nur 30 % der Masse, weil es leichter ist als der Durchschnitt.
][
*Molmasse:* Gesamtmasse durch Gesamtstoffmenge, gleichwertig $M = sum psi_i M_i$:
$ M = m/n = "458,53"/"19,58" thin "kg/kmol" approx "23,42" thin "kg/kmol" $
][
*Gaskonstante:* $R = R_m\/M = "8314,3"\/"23,42" thin "J/(kg K)" approx 355 thin "J/(kg K)"$. Probe über die Massenanteile: $R = sum xi_i R_i$ liefert denselben Wert.
]

#aufgabe(titel: "Gemisch aus Luft, Methan und Kohlendioxid (Variante)", art: "rechnen", quelle: "2.12.2", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.8", minuten: 10,
  ergebnis: [$psi$: 0,5 / 0,3 / 0,2; $xi$: 0,515 / 0,171 / 0,313; $M approx "28,09" thin "kg/kmol"$; $R approx 296 thin "J/(kg K)"$])[
#if not web [*Aufgabe 164* #linebreak()]
*Gegeben und Annahmen*

Ideales Gasgemisch aus 5 kmol Luft ($M = "28,96"$), 3 kmol Methan ($"16,04"$) und 2 kmol CO#sub[2] ($"44,01" thin "kg/kmol"$); $R_m = "8314,3" thin "J/(kmol K)"$.

*Gesucht*

#enum(numbering: "a)",
[Mol- und Massenanteile in einer Tabelle.],
[Molmasse und Gaskonstante des Gemisches.],
)
][
*Tabelle:* $n = 10 thin "kmol"$.
#tab(columns: (1.2fr, 1fr, 1fr, 1fr, 1fr),
 th([Komponente], [$n_i$ in kmol], [$psi_i$], [$m_i$ in kg], [$xi_i$]),
 [Luft], [5], [0,5], [144,80], [0,5154],
 [Methan], [3], [0,3], [48,12], [0,1713],
 [CO#sub[2]], [2], [0,2], [88,02], [0,3133],
 [Summe], [10], [1,0], [280,94], [1,0000],
)
Das schwere CO#sub[2] hat nur 20 % der Moleküle, aber 31 % der Masse.
][
*Gemischgrößen:* $M = "280,94"\/10 thin "kg/kmol" approx "28,09" thin "kg/kmol"$ und $R = "8314,3"\/"28,09" thin "J/(kg K)" approx 296 thin "J/(kg K)"$. Zufällig liegt das Gemisch fast bei Luft: Das leichte Methan und das schwere CO#sub[2] gleichen sich aus.
]

#aufgabe(titel: "Temperatur rückwärts aus dem Volumen", art: "rechnen", quelle: "2.13.1", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 1.10 b", minuten: 8)[
#if not web [*Aufgabe 165* #linebreak()]
*Rückwärtige Interpolation, Ü 1.10 b; T22:*

*Gegeben und Annahmen*

R134a, $p=1200 thin "kPa"$, gesuchter Zustand mit $v="0,02300" thin "m"^3/"kg"$. Tabellenpunkte bei demselben Druck: $v_1="0,02245" thin "m"^3/"kg"$ bei 100 °C und $v_2="0,02335" thin "m"^3/"kg"$ bei 110 °C. Lineare Näherung im selben einphasigen Gebiet.

*Gesucht*

#enum(numbering: "a)",
[Bestimme die Temperatur durch rückwärtige Interpolation.],
[Ordne bekannte und gesuchte Größe den Eingabe- und Ausgabeachsen zu.],
[Prüfe das Ergebnis durch vorwärts gerichtetes Einsetzen.],
)
][
*Modell:* R134a bei konstant 1200 kPa, einphasig; lineare Näherung zwischen 100 und 110 °C.
][
*Gesuchte und bekannte Größe zuordnen:* Eingabe ist $v$, Ausgabe ist $vartheta$. Der Abstandsanteil lautet
$ f=frac("0,02300"-"0,02245", "0,02335"-"0,02245")="0,611111"... $
][
*Temperatur bestimmen:* $vartheta=100+f(110-100)$ °C.
][
*Ergebnis: $vartheta approx "106,11"$ °C.*
][
*Rückwärts prüfen:* $v="0,02245"+"0,611111"... dot ("0,02335"-"0,02245")="0,02300"$ m³/kg. Der bekannte Wert liegt zwischen den Randwerten, die Temperatur ebenfalls.
]

#aufgabe(titel: "Entnahme: mehr Flüssigkeit verschwindet", art: "verstehen", quelle: "2.13.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 166* #linebreak()]
Warum verschwindet beim Entnehmen von Flüssigkeit aus einem Stickstoffgefäß mehr Flüssigkeit, als entnommen wird?
][
*Antwort:*

- Das Gefäßvolumen bleibt gleich.
- Wo vorher Flüssigkeit war, entsteht Platz, und den füllt Dampf.
- Dafür verdampft ein Teil der Flüssigkeit.
- Die neue Dampfmasse bleibt im Gefäß, die entnommene Flüssigkeit geht hinaus.

#align(center)[#image("abbildungen/stickstoff-zustaende.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „Das spezifische Volumen bleibt konstant, weil der Behälter starr ist.“: Starr heißt $V$ konstant. Weil $m$ sinkt, wächst $v = V\/m$.
- „Die entnommene Masse ist die verdampfte Masse.“: Entnommen wird Flüssigkeit; verdampft ist ein anderer, viel kleinerer Teil.
]

#aufgabe(titel: "Starrer Behälter, aber v ändert sich", art: "verstehen", quelle: "2.13.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 167* #linebreak()]
Warum bleibt in einem starren Behälter v nicht konstant, wenn Masse austritt?
][
*Antwort:*

- $v = V\/m$.
- $V$ bleibt gleich, aber $m$ sinkt.
- Also wird $v$ größer.
- „Starr“ heißt nur, dass das Gesamtvolumen $V$ konstant ist.

#align(center)[#image("abbildungen/stickstoff-zustaende.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Starr hält V fest, nicht automatisch V je Kilogramm.
]

#aufgabe(titel: "Stickstoff: Restmasse und Nachverdampfen", art: "rechnen", quelle: "2.13.2", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.1 c–d", minuten: 15)[
#if not web [*Aufgabe 168* #linebreak()]
*Stickstoffgefäß, Ü 2.1 c–d; W23 und M2:*

*Gegeben und Annahmen*

Starres Stickstoffgefäß: $V="0,05" thin "m"^3$, Masse bei Entnahmebeginn $m_2="36,31895896" thin "kg"$. Während der Entnahme bleibt $p="1,4" thin "bar"$ konstant. Es tritt gesättigte Flüssigkeit aus; für den zweiten Teil werden $1 thin "kg"$ entnommen.
#tab(columns: (1fr, 1fr, 1fr),
 th([Größe bei 1,4 bar], [Flüssigkeit ′], [Sattdampf ″]),
 [v / m³/kg], [0,0012611], [0,16082],
 [h / kJ/kg], [−116,15], [79,245],
 [s / kJ/(kg K)], [2,9081], [5,3442],
)

*Gesucht*

#enum(numbering: "a)",
[Wie viel Flüssigkeit lässt sich höchstens entnehmen, wenn am Ende nur Sattdampf im Gefäß bleibt?],
[Wie viel Flüssigkeit muss während der Entnahme von 1 kg nachverdampfen?],
[Zeige Massen- und Volumenbilanz und deute die Vorzeichen von $Delta m$ und $Delta m''$.],
)
][
*Modell:* starrer Behälter, ab Zustand ② isobar bei 1,4 bar, Sättigungswerte aus der Originaltabelle. Aus „Stickstoff: Volumenanteile und Förderung“: $m_2=m_1 approx "36,318959"$ kg.
][
*Maximalentnahme:* Am Ende ist nur Sattdampf vorhanden. Deshalb $m_"Rest"=V/v''="0,05"/"0,16082" approx "0,310907"$ kg.
][
*Ergebnis: $m_"entn,max"=m_2-m_"Rest" approx "36,0081"$ kg.* Die Änderung des Gefäßbestands ist entsprechend negativ. Das ist die ideale Obergrenze unter den Modellannahmen.
][
*Für 1 kg Entnahme:* $Delta m=-1$ kg und $v'Delta m'+v''Delta m''=0$, während $Delta m'+Delta m''=-1$ kg gilt. Daraus:
$ Delta m''=frac("0,0012611", "0,16082"-"0,0012611") dot 1 thin "kg" $
*Ergebnis: $Delta m'' approx "0,00790366" thin "kg"="7,904" thin "g"$.*
][
*Flüssigkeitsbestand prüfen:* $Delta m'=-1-"0,00790366"=-"1,00790366"$ kg. Davon treten 1 kg aus und rund 7,904 g verdampfen im Gefäß.
][
*Prüfung:* $Delta m''>0$, obwohl $Delta m<0$. Beide Volumenänderungen gleichen sich aus. Frühes Runden von $m''_2$ und $m''_3$ auf 0,026 und 0,034 kg erzeugt die gröbere Differenz 8 g; M2 zeigt genau diese Rundungsfalle.
]

#aufgabe(titel: "Druckbehälter drückt gesättigtes Wasser durch eine Steigleitung", art: "rechnen", quelle: "2.13.2", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.12", minuten: 25,
  ergebnis: [$p_1 = 1 thin "bar"$, $vartheta_1 = "99,63" thin "°C"$; $m_"ges" approx "43,13" thin "kg"$, $v_1 approx "1,159" times 10^(-3) thin "m"^3/"kg"$; $p_2 approx "1,658" thin "bar"$, $vartheta_2 approx "114,3" thin "°C"$; $Delta m_"max" approx "43,08" thin "kg"$; $approx 1 thin "g"$ Dampf je kg; $Q_"zu,23" approx "2,22" thin "kJ"$],
  tipp: [Der Dampf über dem Wasser muss die Wassersäule von 7 m tragen und zusätzlich gegen den Umgebungsdruck drücken. Und: Wer füllt den Raum, den das entnommene Wasser frei macht?])[
#if not web [*Aufgabe 169* #linebreak()]
*Gegeben und Annahmen*

In einem bis auf die elektrische Heizung H adiabaten Druckbehälter mit Volumen $V = "0,05" thin "m"^3$ befinden sich Wasser (90 % des Behältervolumens) und Wasserdampf im Gleichgewicht bei $p_1 = 1 thin "bar"$. Das Gefäß ist am Boden an eine Entnahmeleitung angeschlossen, deren Ausflussöffnung $Delta z = 7 thin "m"$ über dem Flüssigkeitsspiegel liegt. Zur Entnahme gesättigten Wassers wird die Heizung eingeschaltet. Der entstehende Dampf steigt im Behälter (nicht in der Entnahmeleitung) nach oben und drückt so gesättigtes Wasser über die Entnahmeleitung zur Ausflussöffnung. Umgebungsdruck $p_infinity = 1 thin "bar"$, $g = "9,81" thin "m/s"^2$. Die Höhe des Wasserspiegels kann bei der Entnahme näherungsweise als konstant angenommen werden. Die Fluidmasse im Steigrohr und das Volumen der Entnahmeleitung sind vernachlässigbar. Für die Dichte der Wassersäule gilt $rho = 1\/v'(1 thin "bar")$.

Dampftafel Wasser, Sättigung:
#tab(columns: (1fr, 1fr, 1.3fr, 1fr, 1fr),
 th([$p$ in bar], [$vartheta_s$ in °C], [$v'$ in m³/kg], [$v''$ in m³/kg], [$r$ in kJ/kg]),
 [1,0], [99,63], [$"1,0434" times 10^(-3)$], [1,694], [2258],
 [1,6], [113,3], [$"1,0547" times 10^(-3)$], [1,091], [2221],
 [1,8], [116,9], [$"1,0579" times 10^(-3)$], [0,9772], [2211],
)

*Gesucht*

#enum(numbering: "a)",
[Bestimme den Druck $p_1$ und die Temperatur $vartheta_1$. Skizziere sämtliche Zustände in einem p,v- und einem p,T-Diagramm.],
[Wie groß sind die Masse $m_"ges"$ im Behälter und das spezifische Volumen $v_1$ des Nassdampfes?],
[Welcher Druck $p_2$ muss im Behälter herrschen, damit das gesättigte Wasser im Entnahmerohr gerade bis zur Ausflussöffnung steht? Welche Temperatur $vartheta_2$ herrscht dann?],
[Wie viel flüssiges Wasser kann maximal entnommen werden?],
[Wie viel Wasser muss zur Entnahme von 1 kg flüssigem Wasser ($2 -> 3$) verdampfen?],
[Welche Wärme $Q_"zu,23"$ muss dabei durch die Heizung zugeführt werden?],
)
][
*Zustand 1:* Wasser und Dampf im Gleichgewicht sind Nassdampf. Der Druck ist gegeben, $p_1 = 1 thin "bar"$, und legt die Temperatur fest: $vartheta_1 = vartheta_s (1 thin "bar") = "99,63" thin "°C"$.

*Skizzen:* Im p,v-Diagramm liegt ① im Nassdampfgebiet nahe der Siedelinie (kleines $v$). Beim Heizen steigt der Druck bei praktisch gleichem $v$ auf $p_2$ (②). Während der Entnahme bleibt der Druck $p_2$, die Masse sinkt, und $v$ wandert waagerecht nach rechts (③). Im p,T-Diagramm liegen alle Zustände auf der Dampfdruckkurve: ① bei 1 bar, ② und ③ zusammen bei $p_2$.
][
*Massen und spezifisches Volumen:* Flüssigkeit füllt $"0,045" thin "m"^3$, Dampf $"0,005" thin "m"^3$:
$ m' = ("0,045")/("1,0434" times 10^(-3)) thin "kg" approx "43,128" thin "kg" quad quad m'' = ("0,005")/"1,694" thin "kg" approx "2,95" thin "g" $
$ m_"ges" approx "43,131" thin "kg" quad quad v_1 = V/m_"ges" approx "1,159" times 10^(-3) thin "m"^3/"kg" $
Der Dampf füllt 10 % des Raumes, hat aber nur 0,007 % der Masse.
][
*Druck für die Entnahme:* Das Rohr ist am Behälterboden angeschlossen, der Spiegel im Behälter steht $Delta z$ unter der Öffnung. Hydrostatik von der Öffnung ($p_infinity$) bis zum Spiegel im Behälter:
$ p_2 = p_infinity + rho g Delta z = 10^5 thin "Pa" + ("9,81" dot 7)/("1,0434" times 10^(-3)) thin "Pa" approx "1,658" thin "bar" $
Zwischen 1,6 und 1,8 bar linear interpoliert: $vartheta_2 = "113,3" + ("0,058"\/"0,2") dot "3,6" approx "114,3" thin "°C"$.
][
*Maximale Entnahme:* Entnommen werden kann, bis keine Flüssigkeit mehr im Behälter ist. Dann füllt gesättigter Dampf bei $p_2$ das ganze Volumen. Interpoliert: $v''(p_2) approx "1,0579" thin "m"^3/"kg"$.
$ m_"Rest" = V/(v''(p_2)) = "0,05"/"1,0579" thin "kg" approx "0,047" thin "kg" quad => quad Delta m_"max" = m_"ges" - m_"Rest" approx "43,08" thin "kg" $
][
*Verdampfte Masse je kg Entnahme:* Druck und Temperatur bleiben bei $p_2$. Das entnommene Kilogramm macht das Volumen $1 thin "kg" dot v'$ frei. Dieses Volumen muss neu gebildeter Dampf füllen. Verdampft die Masse $m_d$, wächst das Dampfvolumen um $m_d (v'' - v')$:
$ m_d (v'' - v') = 1 thin "kg" dot v' quad => quad m_d = v'/(v'' - v') = ("1,0556" times 10^(-3))/("1,0579" - "0,0011") thin "kg" approx "1,0" thin "g" $
Mit $v'(p_2) approx "1,0556" times 10^(-3) thin "m"^3/"kg"$ interpoliert.
][
*Wärme:* Energiebilanz des instationären offenen Behälters bei konstantem $p$ und $T$: $Q_"zu,23" = Delta U + m_"aus" h'$. Setzt man $u = h - p v$ ein und nutzt die Volumenbedingung aus e), bleibt genau die Verdampfungswärme der neu gebildeten Dampfmasse:
$ Q_"zu,23" = m_d r(p_2) approx "0,999" times 10^(-3) thin "kg" dot 2218 thin "kJ/kg" approx "2,22" thin "kJ" $
Mit $r(p_2)$ zwischen 2221 und 2211 kJ/kg interpoliert. Die Entnahme kostet sehr wenig Energie, weil nur rund ein Gramm verdampfen muss.
]

#aufgabe(titel: "Druckbehälter mit 7,5 m Steigleitung (Variante)", art: "rechnen", quelle: "2.13.2", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.12", minuten: 20,
  ergebnis: [$m_"ges" approx "65,18" thin "kg"$; $p_2 approx "1,705" thin "bar"$, $vartheta_2 approx "115,2" thin "°C"$; $Delta m_"max" approx "65,10" thin "kg"$; $Q approx "2,27" thin "kJ"$ je kg])[
#if not web [*Aufgabe 170* #linebreak()]
*Gegeben und Annahmen*

Ein bis auf die Heizung adiabater Behälter mit $V = "0,08" thin "m"^3$ enthält bei $p_1 = 1 thin "bar"$ Nassdampf, die Flüssigkeit füllt 85 % des Volumens. Eine Steigleitung führt vom Boden zu einer Öffnung $Delta z = "7,5" thin "m"$ über dem Flüssigkeitsspiegel; außen $p_infinity = 1 thin "bar"$. Spiegelhöhe näherungsweise konstant, Rohrvolumen vernachlässigbar, $rho = 1\/v'(1 thin "bar")$, $g = "9,81" thin "m/s"^2$. Dampftafel wie im Original:
#tab(columns: (1fr, 1fr, 1.3fr, 1fr, 1fr),
 th([$p$ in bar], [$vartheta_s$ in °C], [$v'$ in m³/kg], [$v''$ in m³/kg], [$r$ in kJ/kg]),
 [1,0], [99,63], [$"1,0434" times 10^(-3)$], [1,694], [2258],
 [1,6], [113,3], [$"1,0547" times 10^(-3)$], [1,091], [2221],
 [1,8], [116,9], [$"1,0579" times 10^(-3)$], [0,9772], [2211],
)

*Gesucht*

#enum(numbering: "a)",
[Gesamtmasse und spezifisches Volumen im Zustand 1.],
[Druck und Temperatur, bei denen das Wasser gerade die Öffnung erreicht.],
[Die maximal entnehmbare Flüssigkeitsmasse.],
[Die Heizwärme je entnommenem Kilogramm.],
)
][
*Massen:* $m' = "0,068"\/("1,0434" times 10^(-3)) approx "65,172" thin "kg"$, $m'' = "0,012"\/"1,694" approx "7,1" thin "g"$, also $m_"ges" approx "65,18" thin "kg"$ und $v_1 = "0,08"\/"65,18" approx "1,227" times 10^(-3) thin "m"^3/"kg"$.
][
*Druck und Temperatur:* $p_2 = 10^5 + "9,81" dot "7,5"\/("1,0434" times 10^(-3)) thin "Pa" approx "1,705" thin "bar"$. Interpoliert: $vartheta_2 approx "113,3" + ("0,105"\/"0,2") dot "3,6" approx "115,2" thin "°C"$.
][
*Maximale Entnahme:* $v''(p_2) approx "1,0312" thin "m"^3/"kg"$, Restdampf $"0,08"\/"1,0312" approx "0,078" thin "kg"$, also $Delta m_"max" approx "65,10" thin "kg"$.
][
*Wärme je kg:* Das freie Volumen $v' approx "1,0564" times 10^(-3) thin "m"^3$ füllt neuer Dampf: $m_d = v'\/(v''-v') approx "1,025" thin "g"$. Mit $r(p_2) approx 2216 thin "kJ/kg"$ folgt $Q approx "2,27" thin "kJ"$. Höherer Druck verkleinert $v''$, darum muss etwas mehr verdampfen als im Original.
]

#aufgabe(titel: "Sättigungstemperatur prüfen", art: "rechnen", quelle: "2.13.3", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 1.14 c4–c10", minuten: 15)[
#if not web [*Aufgabe 171* #linebreak()]
*R134a-Verdampfer, Ü 1.14 c.4–10; M1:*

*Gegeben und Annahmen*

R134a-Verdampfer, stationär. $p_1=p_2="164,2" thin "kPa"$, $vartheta_1=-20 thin "°C"$, $x_2="0,88"$, $dot(m)="0,0038" thin "kg/s"$, $v_2="0,106124" thin "m"^3/"kg"$. Stoffwerte aus M1: $h'="180,25"$, $h''="389,83" thin "kJ/kg"$, $s'="0,9259"$, $s''="1,73787" thin "kJ/(kg K)"$. Für die Sättigungstemperatur: −15 °C bei 163,90 kPa; −10 °C bei 200,60 kPa.

*Gesucht*

#enum(numbering: "a)",
[Bestimme am Austritt $h_2$, $dot(H)_2$, $u_2$, $s_2$ und $dot(S)_2$.],
[Berechne die Enthalpieströme von Flüssigkeit und Sattdampf und prüfe ihre Summe.],
[Interpoliere die Sättigungstemperatur bei 164,2 kPa und erkläre damit den flüssigen Eintrittszustand.],
)
][
*Modell:* stationär, Nassdampf bei 164,2 kPa, $x_2="0,88"$, $dot(m)="0,0038"$ kg/s. Aus der Verdampfer-Aufgabe: $v_2="0,106124"$ m³/kg. Alle Randwerte aus derselben Zeile von M1.
][
*Enthalpie und innere Energie:*
$ h_2="180,25"+"0,88"("389,83"-"180,25")="364,6804" thin "kJ/kg" $
$ u_2=h_2-p_2v_2="364,6804"-"164,2" dot "0,106124" approx "347,2548" thin "kJ/kg" $
][
*Entropie und Ströme:*
$ s_2="0,9259"+"0,88"("1,73787"-"0,9259")="1,6404336" thin "kJ/(kg K)" $
#tab(columns: (1.6fr, 1.8fr, 1fr),
 th([Gesuchte Größe], [Ansatz], [Ergebnis]),
 [Nassdampfenthalpiestrom], [$dot(H)_2=dot(m)h_2$], [1,38579 kW],
 [Entropiestrom], [$dot(S)_2=dot(m)s_2$], [0,00623365 kW/K],
 [Flüssigkeitsenthalpiestrom], [$dot(H)'_2=dot(m)(1-x_2)h'$], [0,082194 kW],
 [Sattdampfenthalpiestrom], [$dot(H)''_2=dot(m)x_2h''$], [1,30359 kW],
)
*Prüfung:* $"0,082194"+"1,303592"="1,385786"$ kW. $u$ und $h$ sind spezifische Größen, ihre Ströme haben einen Zeitbezug. kPa·m³/kg ergibt kJ/kg; beim Entropiestrom bleibt zusätzlich „pro Kelvin“ erhalten.
][
*Interpolieren:* $vartheta_s=-15+("164,2"-"163,90")/("200,60"-"163,90") dot 5 approx -"14,9591"$ °C.
][
*Ergebnis: $vartheta_s approx -"14,96"$ °C.* Am Eintritt ist $vartheta_1=-20$ °C kleiner als $vartheta_s$; dort liegt unterkühlte Flüssigkeit vor. Am Austritt bestimmt zusätzlich der gegebene Dampfgehalt die Nassdampfmischung.
][
*Prüfung:* 164,2 kPa liegt knapp über 163,90 kPa, die Temperatur daher knapp über −15 °C. Zwischen den nahe gelegenen Sättigungspunkten wird linear angenähert; der Eintrittswert $v_1$ ist eine Flüssigkeitsnäherung.
]

#aufgabe(titel: "Tripelgefäß mit 1 kg Eis: Phasenbilanz und Heizdauer", art: "rechnen", quelle: "2.14", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.11", minuten: 25,
 ergebnis: [$V="0,0226901"$ m³; Eis verschwindet; $Q_01 approx "333,501713"$ kJ; $Delta t_01 approx "33350,17"$ s = 9,26394 h; $p_2 approx "915,67"$ Pa.],
 tipp: [Beim Schmelzen bleiben p und V gleich. Berechne die neuen Phasenmassen und nutze dann die Änderung der Gesamtenthalpie.])[
#if not web [*Aufgabe 172* #linebreak()]
*Gegeben und Annahmen:* Ü 2.11: Geschlossenes starres Gefäß, anfangs 1 kg Wasser, 1 kg Eis und 0,0001 kg Wasserdampf im Gleichgewicht. Zugeführter Wärmestrom 10 W; keine weitere Arbeit, äußere Speicherenergien und Behälterwärmekapazität vernachlässigt. Zustand ①: erste Phase gerade verschwunden. Danach Erwärmung bis $T_2=280$ K. Am Tripelpunkt gelten $T_"Tr"="273,16"$ K, $p_"Tr"="611,657"$ Pa:
#tab(columns: (1fr, 1.15fr, 1.2fr, 1.2fr), th([Phase], [$v$ / m³/kg], [$h$ / kJ/kg], [$s$ / kJ/(kg K)]),
 [Wasser ′], [0,0010002], [0,000611783], [0],
 [Dampf ″], [205,99], [2500,9], [9,1555],
 [Eis ‴], [0,0010909], [−333,5], [−1,2209],
)
Alle Phasenwerte haben denselben Tabellenbezug; $U=H-p V$. Die Steigung der Dampfdruckkurve wird laut Aufgabe in der Umgebung des Tripelpunktes näherungsweise konstant angenommen. $1$ kJ = $1000$ J; $1$ h = $3600$ s.
*Gesucht:*
#enum(numbering: "a)")[Anfangsdruck und Anfangstemperatur.][Gefäßvolumen und spezifisches Gesamtvolumen.][Verschwindende Phase, Wärme und Dauer bis Zustand ①.][Näherungsdruck bei 280 K; Einordnung des Zustandswegs.]
#src[Ü 2.11, PDF-S. 15; M211, PDF-S. 1.]
][
*Tripelzustand erkennen:* Drei Phasen desselben Stoffes im Gleichgewicht liefern $T_0="273,16"$ K = 0,01 °C und $p_0="611,657"$ Pa. Die zugeführte Wärme ändert zunächst ihre Mengen, während Druck und Temperatur gleich bleiben.
][
*Gesamtmengen addieren:* $m=1+1+"0,0001"="2,0001"$ kg. Das Volumen enthält alle drei Beiträge:
$V=1 dot "0,0010002"+"0,0001" dot "205,99"+1 dot "0,0010909"="0,0226901"$ m³.
Damit $v=V/m approx "0,011344483"$ m³/kg. Die Dampfmasse ist sehr klein, ihr Volumenbeitrag ist dagegen der größte.
][
*Verschwindende Phase und Endmassen bestimmen:* Bei Wärmezufuhr schmilzt Eis. Mit $m'_1+m''_1=m$ und $m'_1v'+m''_1v''=V$ folgt
$ m''_1=frac(V-m v',v''-v') approx "0,000100440315"$ kg und $m'_1 approx "1,999999560"$ kg.
Beide Mengen sind positiv; damit ist ein eisfreier Flüssig-Dampf-Endzustand möglich. Etwas zusätzliches Wasser verdampft und füllt das beim Schmelzen frei werdende Volumen.
][
*Speicheränderung aus Enthalpien berechnen:* $H_0=1 dot "0,000611783"+"0,0001" dot "2500,9"-"333,5" approx -"333,249298"$ kJ. Mit den neuen Massen ist $H_1=m'_1h'+m''_1h'' approx "0,252414749"$ kJ. Solange p und V gleich bleiben, ist $Delta(p V)=0$, also $Delta U=Delta H$. Daher
$Q_01=H_1-H_0 approx "333,501713"$ kJ.
Das starre Gefäß allein würde $Q=Delta H$ nicht erlauben; die zusätzliche Druckkonstanz bis zum Ende des Tripelabschnitts ist wesentlich.
][
*Leistung in Dauer umrechnen:* $Delta t_01=Q_01/dot(Q)="333501,713" thin "J"/(10 thin "J/s") approx "33350,17"$ s $approx "9,26394"$ h. Die Größenkontrolle $1 thin "kg" dot "333,5" thin "kJ/kg"$ stimmt fast mit der gesamten Schmelzwärme überein. M211 rundet V vorzeitig auf 0,0227 m³ und erhält rund 333,5025 kJ; die kleine Abweichung ist eine Rundungsfolge.
][
*Clapeyron und Diagramm prüfen:* $frac(dif p_s,dif T)=(s''-s')/(v''-v') approx "44,44655"$ Pa/K; die Entropiewerte vorher mit 1000 in J/(kg K) umrechnen. Mit $Delta T=280-"273,16"="6,84"$ K folgt
$p_2 approx "611,657"+"44,44655" dot "6,84" approx "915,67"$ Pa $= "9,1567"$ mbar.
Das ist die verlangte lineare Näherung, keine genaue Dampftafelablesung. Zustand ⓪ und ① liegen im p-v- und p-T-Diagramm übereinander. Danach folgt die geschlossene Isochore im p-v-Diagramm senkrecht nach oben; im p-T-Diagramm folgt sie der Flüssig-Dampf-Grenze.
]

#aufgabe(titel: "Tripelgefäß: drei Phasen, Wärme und Schmelzdauer", art: "rechnen", quelle: "2.14", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.13", minuten: 25,
 ergebnis: [$V approx "0,00103307"$ m³; $H_1 approx -"33,339935"$ kJ; $Q_12 approx "33,35017"$ kJ; $Delta t approx "9,26394"$ h; $p_3 approx "922,786"$ Pa.],
 tipp: [Solange drei Phasen koexistieren, bleiben p und T auf ihren Tripelwerten. Die neuen Teilmassen nach dem Schmelzen folgen aus zwei Bilanzen.])[
#if not web [*Aufgabe 173* #linebreak()]
*Gegeben und Annahmen:* Ü 2.13: Ein geschlossenes starres Gefäß enthält anfangs 100 g flüssiges Wasser, 100 g Eis und 4 mg Wasserdampf im Gleichgewicht. Konstant zugeführter Wärmestrom $dot(Q)=1$ W; keine weitere Arbeit, äußere Energien und Gefäßwärmekapazität vernachlässigt. Wasser-Tripelwerte $T_"Tr"="273,16"$ K, $p_"Tr"="611,66"$ Pa. $1$ g = $10^(-3)$ kg, $1$ mg = $10^(-6)$ kg; $1$ kJ = $1000$ J.
#tab(columns: (1.2fr, 1fr, 1fr, 1fr, 1fr),
 th([Phase], [$v$ m³/kg], [$u$ kJ/kg], [$h$ kJ/kg], [$s$ kJ/(kg K)]),
 [Flüssigkeit ′], [0,0010002], [0], [$"611,783" dot 10^(-6)$], [0],
 [Dampf ″], [205,99], [2374,9], [2500,9], [9,1555],
 [Eis ‴], [0,0010909], [−333,5], [−333,5], [−1,2209],
)
Für eine konsistente Nachrechnung aus den gerundeten Tabellenwerten $H=sum m_i h_i$ und dann $U=H-p V$ verwenden. Nach Verschwinden des Eises entsteht ein Flüssig-Dampf-Gemisch. Für die spätere Druckabschätzung gilt die Clapeyron-Steigung am Tripelpunkt näherungsweise konstant; $T_3="280,16"$ K.

*Gesucht:*
#enum(numbering: "a)")[Ordne den Anfangszustand zu und nenne Druck und Temperatur.][Berechne Masse, Volumen und spezifisches Gesamtvolumen.][Berechne $H_1$ und $U_1$.][Bestimme nach dem Schmelzen die beiden Teilmassen, die nötige Wärme und die Dauer.][Schätze $p_3$ mithilfe von Clapeyron.][Skizziere ①–②–③ im p-v- und p-T-Diagramm.]
#src[Ü 2.13, PDF-S. 16; R30, PDF-S. 3–4; M13, PDF-S. 1–5. Rundungsstrategie und vollständige Konstanten ergänzt.]
][
*Anfangszustand erkennen:* Drei koexistierende Wasserphasen im Gleichgewicht bedeuten Tripelzustand: $T_1="273,16"$ K = 0,01 °C und $p_1="611,66"$ Pa. Die Energiezufuhr ändert zunächst die Phasenmengen, nicht p und T.
][
*Gesamtgrößen addieren:* $m="0,1"+"0,1"+4 dot 10^(-6)="0,200004"$ kg. $V="0,1" dot "0,0010002"+4 dot 10^(-6) dot "205,99"+"0,1" dot "0,0010909"="0,00103307"$ m³. Damit $v=V/m approx "0,005165247"$ m³/kg. Nur die Gesamtgrößen werden addiert.
][
*Anfangsenergie konsistent aufbauen:* $H_1="0,1" dot "0,000611783"+4 dot 10^(-6) dot "2500,9"+"0,1" dot (-"333,5") approx -"33,339935"$ kJ. $p_1V="611,66" dot "0,00103307" approx "0,631888"$ J = 0,000631888 kJ. Somit $U_1=H_1-p_1V approx -"33,340567"$ kJ. Negative Bestände folgen aus dem gewählten Nullniveau.
][
*Ende des Schmelzens bilanzieren:* Bei Zustand ② ist kein Eis mehr vorhanden, p und T sind noch Tripelwerte. $m'_2+m''_2=m$ und $m'_2v'+m''_2v''=V$. Durch Einsetzen folgt $m''_2=(V-m v')/(v''-v') approx "4,044031" dot 10^(-6)$ kg; $m'_2 approx "0,199999956"$ kg. Etwas zusätzliche Masse ist verdampft, um das beim Schmelzen frei werdende Volumen auszufüllen.
][
*Wärme und Zeit berechnen:* $H_2=m'_2h'+m''_2h'' approx "0,010236075"$ kJ; $U_2=H_2-p_1V approx "0,009604187"$ kJ. Starr und ohne weitere Arbeit gilt $Q_12=U_2-U_1 approx "33,350171"$ kJ. $Delta t="33350,171" thin "J"/(1 thin "J/s") approx 33350$ s = 9,26394 h. Mit den gerundeten Stoffwerten genügt die Angabe etwa 9,264 h.
][
*Clapeyron mit Einheiten einsetzen:* Die tabellierte Entropiedifferenz ist $"9155,5"$ J/(kg K). $a=(s''-s')/(v''-v')="9155,5"/("205,99"-"0,0010002") approx "44,44655"$ Pa/K. Mit $Delta T=7$ K folgt $p_3 approx "611,66"+"44,44655" dot 7 approx "922,786"$ Pa = 9,22786 mbar. Das ist die geforderte lineare Näherung, kein exakter Dampftafelwert.
][
*Zustandsweg und Plausibilität prüfen:* ① und ② besitzen dasselbe p, T und v und liegen in beiden Diagrammen übereinander. Erst der Weg nach ③ steigt im p-v-Diagramm senkrecht; im p-T-Diagramm folgt er der Flüssig-Dampf-Grenze. Die etwa 33,35 kJ werden hauptsächlich zum Schmelzen von 0,1 kg Eis benötigt; $"0,1" dot "333,5"="33,35"$ kJ liefert eine unabhängige Größenkontrolle.
#align(center)[#image("abbildungen/tripel-isochor.svg", width: 100%)]
]

#aufgabe(titel: "Tripelgemisch erwärmt sich nicht", art: "verstehen", quelle: "2.14.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 174* #linebreak()]
Warum kann sich ein Eis-Wasser-Dampf-Gemisch trotz Wärmezufuhr zunächst nicht erwärmen?
][
*Antwort:*

- Solange alle drei Phasen im Gleichgewicht vorhanden sind, bleiben Druck und Temperatur auf ihren Tripelwerten.
- Die zugeführte Energie verändert zunächst die Phasenmengen.
- Erst nach dem Verschwinden einer Phase kann der weitere Weg den Tripelzustand verlassen.

#align(center)[#image("abbildungen/map-tripel.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „Alle drei Teilmassen bleiben unverändert.“: Gerade die Teilmassen ändern sich beim Schmelzen und der begleitenden Umverteilung.
- „Die innere Energie bleibt wegen des konstanten Volumens gleich.“: Ein starres Volumen streicht die Volumenarbeit, nicht die Wirkung zugeführter Wärme.
]

#aufgabe(titel: "Schmelzen im Tripelgefäß: ein Punkt im p-v-Diagramm", art: "verstehen", quelle: "2.14.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 175* #linebreak()]
Warum liegen Anfang und Ende des Schmelzens im starren Tripelgefäß im p-v-Diagramm auf demselben Punkt?
][
*Antwort:*

- Masse und Gesamtvolumen bleiben konstant, damit auch das spezifische Volumen.
- Solange der Tripelzustand besteht, bleibt außerdem der Druck gleich.
- Die Phasenanteile können sich ändern, obwohl die Diagrammkoordinaten gleich bleiben.

#align(center)[#image("abbildungen/tripel-isochor.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Teilmassen nach dem Schmelzen neu berechnen", art: "verstehen", quelle: "2.14.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 176* #linebreak()]
Warum müssen nach dem Schmelzen im Tripelgefäß die Teilmassen neu berechnet werden?
][
*Antwort:*

- Eis, Flüssigkeit und Dampf ändern während der Wärmezufuhr ihre Anteile.
- Nach dem Verschwinden des Eises gelten eine Massenbilanz und eine Volumenbilanz für die beiden übrigen Phasen.
- Erst mit diesen neuen Teilmassen lässt sich die Endenergie und daraus die nötige Wärme bestimmen.

#align(center)[#image("abbildungen/map-tripel.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Schmelzen im starren Gefäß: Rechnen mit ΔH", art: "verstehen", quelle: "2.14.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 177* #linebreak()]
Warum darf beim Schmelzen im geschlossenen starren Tripelgefäß mit der Änderung der Gesamtenthalpie gerechnet werden?
][
*Antwort:*

- Die Wärme ändert zunächst die gesamte innere Energie.
- Weil sowohl der Tripeldruck als auch das Gesamtvolumen konstant bleiben, ändert sich ihr Produkt nicht.
- Aus $U=H-p V$ folgt dann $Delta U=Delta H$.
- Erst nach Verlassen des Tripelzustands muss der Druck-Volumen-Anteil wieder geprüft werden.

#align(center)[#image("abbildungen/map-tripel.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „Ein starres Gefäß garantiert immer $Delta H=Delta U$, auch bei veränderlichem Druck.“: Konstantes Volumen allein streicht die Änderung von pV nicht. Zusätzlich muss der Druck konstant bleiben.
- „Enthalpie ist grundsätzlich der im Stoff gespeicherte Wärmebestand.“: Wärme ist eine Übertragung. Enthalpie ist eine Zustandsgröße und nur unter passenden Bedingungen mit einer Wärmemenge verknüpft.
]

#aufgabe(titel: "Wärme bei starrer Erwärmung des Tripelgemisches", art: "verstehen", quelle: "2.14.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 178* #linebreak()]
Ein Tripelgemisch wird in einem starren, geschlossenen Gefäß ohne weitere Arbeit erwärmt. Welcher Änderung einer Gesamtgröße entspricht die zugeführte Wärme $Q$, und warum?
][
*Antwort:* Bei der starren geschlossenen Erwärmung eines Tripelgemisches ohne weitere Arbeit gilt $Q$ = *Änderung der inneren Energie*. Nenne die geänderte Gesamtgröße in Worten.
][
*Warum:* Aus dem ersten Hauptsatz bleibt bei unveränderten äußeren Energien die Änderung von U. Die Teilmassen des Endzustands müssen davor neu bestimmt werden.
]

#aufgabe(titel: "Linear genäherte Dampfdruckkurve einordnen", art: "verstehen", quelle: "2.14.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 179* #linebreak()]
In Ü 2.11 wird die Dampfdruckkurve am Tripelpunkt linear angenähert. Wie ist der so berechnete Druck bei 280 K einzuordnen, und worauf beruht die Näherung?
][
*Antwort:* Als Näherung mit konstant angenommener lokaler Clapeyron-Steigung.

Genau diese Annahme gibt die Aufgabe vor. Die reale Dampfdruckkurve besitzt keine überall gleiche Steigung.
][
*Typische Verwechslung:*

- „Als exakter Tabellenwert für jede beliebige höhere Temperatur.“: Eine lokale lineare Näherung ersetzt keine genaue Stoffwerttabelle außerhalb ihres Gültigkeitsbereichs.
- „Als Druckanstieg ohne den anfänglichen Tripeldruck.“: Die Steigung mal Temperaturdifferenz liefert zunächst nur die Druckänderung; der Anfangsdruck wird addiert.
]

#aufgabe(titel: "Eis und Dampf im starren Behälter vollständig verdampfen", art: "rechnen", quelle: "2.14.2", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.14", minuten: 25,
  ergebnis: [$p_1 approx "6,11" thin "mbar"$, $x_1 approx "0,225"$; $v_2 approx "46,5" thin "m"^3/"kg"$, $vartheta_2 approx "23,9" thin "°C"$, $p_2 approx "29,9" thin "mbar"$, $h_2 approx 2545 thin "kJ/kg"$; $W_"el" approx 137 thin "kJ"$, $w_"el" approx 2129 thin "kJ/kg"$])[
#if not web [*Aufgabe 180* #linebreak()]
*Gegeben und Annahmen*

In einem adiabaten geschlossenen Behälter mit konstantem Volumen $V = 3 thin "m"^3$ befinden sich 50 g Eis ($u_"Eis" = -"333,5" thin "kJ/kg"$; $rho_"Eis" = "916,80" thin "kg/m"^3$) von 0 °C im Gleichgewicht mit Wasserdampf (Zustand ①). Die Temperatur wird durch die Zufuhr von Energie durch eine elektrische Heizung so lange erhöht, bis nur noch Dampf im Behälter ist (Zustand ②). Die Wärmekapazität des Behälters wird vernachlässigt. Der Dampf füllt anfangs den vom Eis nicht belegten Raum.

Dampftafel Wasser im Sättigungszustand (IAPWS-IF97):
#tab(columns: (1.2fr, 1fr, 1fr, 1fr, 1fr, 1fr),
 th([$vartheta_s$ in °C], [0], [10], [20], [25], [30]),
 [$p_s$ in bar], [0,0061121], [0,012282], [0,023392], [0,031697], [0,042467],
 [$v''$ in m³/kg], [206,14], [106,31], [57,761], [43,341], [32,882],
 [$h''$ in kJ/kg], [2500,89], [2519,23], [2537,47], [2546,54], [2555,58],
)

*Gesucht*

#enum(numbering: "a)",
[Welcher Druck $p_1$ und welcher Dampfgehalt $x_1$ herrschen im Zustand ①?],
[Skizziere die Zustandsänderung ① → ② im p,v-Diagramm des Wassers.],
[Bestimme spezifisches Volumen, Druck, Temperatur und Enthalpie im Zustand ②.],
[Welche elektrische und welche spezifische elektrische Energie ist von ① nach ② zuzuführen?],
)
][
*Zustand ①:* Eis und Dampf im Gleichgewicht bei 0 °C liegen praktisch am Tripelpunkt; der Druck ist der Sättigungsdruck $p_1 = "0,0061121" thin "bar" approx "6,11" thin "mbar"$. Dampfmasse aus dem freien Volumen:
$ V_"Eis" = "0,05"/"916,8" thin "m"^3 = "5,454" times 10^(-5) thin "m"^3 quad quad m'' = (V - V_"Eis")/(v''(0 thin "°C")) = "2,99995"/"206,14" thin "kg" approx "14,55" thin "g" $
$ m = "0,05" + "0,01455" = "0,06455" thin "kg" quad quad x_1 = m''/m approx "0,225" $
][
*p,v-Diagramm:* Der Behälter ist starr und geschlossen, also bleibt $v = V\/m$ konstant: Der Weg ist eine senkrechte Isochore. Sie startet auf der Tripellinie zwischen Eis- und Dampfrand, steigt durch das Nassdampfgebiet (nach dem Schmelzen Wasser + Dampf) und endet bei ② auf der Taulinie, wo $v'' = v$ ist.
][
*Zustand ②:* $v_2 = V\/m = 3\/"0,06455" approx "46,47" thin "m"^3/"kg"$. Gesättigter Dampf mit diesem $v''$ liegt zwischen 20 °C (57,761) und 25 °C (43,341). Interpolationsanteil $f = ("46,47" - "57,761")\/("43,341" - "57,761") approx "0,783"$:
$ vartheta_2 approx 20 + "0,783" dot 5 approx "23,9" thin "°C" quad p_2 approx "0,0299" thin "bar" quad h_2 approx "2544,6" thin "kJ/kg" $
Die lineare Interpolation in $v''$ ist eine Näherung, weil $v''$ stark nichtlinear mit der Temperatur fällt.
][
*Energie:* Starr, geschlossen, adiabat: Die elektrische Arbeit erhöht nur die innere Energie, $W_"el" = m(u_2 - u_1)$. Mit $u = h - p v$:
$ u''(0 thin "°C") = "2500,89" - 611 dot "206,14"\/1000 approx "2374,9" thin "kJ/kg" $
$ u_1 = (1 - x_1) u_"Eis" + x_1 u'' approx "0,775" dot (-"333,5") + "0,225" dot "2374,9" approx "277,1" thin "kJ/kg" $
$ u_2 = h_2 - p_2 v_2 approx "2544,6" - 2989 dot "46,47"\/1000 approx "2405,6" thin "kJ/kg" $
$ W_"el" = m (u_2 - u_1) approx "0,06455" dot "2128,6" thin "kJ" approx 137 thin "kJ" quad quad w_"el" = u_2 - u_1 approx 2129 thin "kJ/kg" $
Fast die ganze Energie geht in Schmelzen und Verdampfen der 50 g Eis.
]

#aufgabe(titel: "Eis und Dampf in einem kleineren Behälter (Variante)", art: "rechnen", quelle: "2.14.2", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.14", minuten: 20,
  ergebnis: [$x_1 approx "0,168"$; $v_2 approx "34,66" thin "m"^3/"kg"$, $vartheta_2 approx "29,1" thin "°C"$, $p_2 approx "40,6" thin "mbar"$; $W_"el" approx 165 thin "kJ"$])[
#if not web [*Aufgabe 181* #linebreak()]
*Gegeben und Annahmen*

Ein starrer, adiabater, geschlossener Behälter mit $V = "2,5" thin "m"^3$ enthält 60 g Eis von 0 °C ($u_"Eis" = -"333,5" thin "kJ/kg"$, $rho_"Eis" = "916,8" thin "kg/m"^3$) im Gleichgewicht mit Wasserdampf, der den übrigen Raum füllt. Eine elektrische Heizung führt Energie zu, bis nur noch Dampf vorhanden ist. Dampftafel wie im Original (Sättigung, 0 bis 30 °C):
#tab(columns: (1.2fr, 1fr, 1fr, 1fr, 1fr, 1fr),
 th([$vartheta_s$ in °C], [0], [10], [20], [25], [30]),
 [$p_s$ in bar], [0,0061121], [0,012282], [0,023392], [0,031697], [0,042467],
 [$v''$ in m³/kg], [206,14], [106,31], [57,761], [43,341], [32,882],
 [$h''$ in kJ/kg], [2500,89], [2519,23], [2537,47], [2546,54], [2555,58],
)

*Gesucht*

#enum(numbering: "a)",
[Dampfgehalt im Anfangszustand.],
[Temperatur und Druck, wenn das letzte Wasser verdampft ist.],
[Die zuzuführende elektrische Energie.],
)
][
*Anfang:* $V_"Eis" = "0,06"\/"916,8" = "6,54" times 10^(-5) thin "m"^3$, $m'' = ("2,5" - V_"Eis")\/"206,14" approx "12,13" thin "g"$, $m approx "72,13" thin "g"$, $x_1 approx "0,168"$.
][
*Ende:* $v_2 = "2,5"\/"0,07213" approx "34,66" thin "m"^3/"kg"$ liegt zwischen 25 °C (43,341) und 30 °C (32,882); $f approx "0,830"$:
$ vartheta_2 approx "29,1" thin "°C" quad p_2 approx "0,0406" thin "bar" quad h_2 approx "2554,0" thin "kJ/kg" $
Weniger Volumen je kg heißt dichterer Sattdampf und damit höhere Endtemperatur als im Original.
][
*Energie:* $u_1 = "0,832" dot (-"333,5") + "0,168" dot "2374,9" approx "121,9" thin "kJ/kg"$, $u_2 = "2554,0" - 4064 dot "34,66"\/1000 approx "2413,2" thin "kJ/kg"$.
$ W_"el" = m (u_2 - u_1) approx "0,07213" dot "2291,3" thin "kJ" approx 165 thin "kJ" $
]

#aufgabe(titel: "Massenstrom allein legt den Durchmesser nicht fest", art: "verstehen", quelle: "2.15.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 182* #linebreak()]
Warum legt ein Massenstrom den Durchmesser einer Dampfleitung noch nicht allein fest?
][
*Antwort:*

- Man braucht außerdem das spezifische Volumen des Dampfes und die vorgesehene mittlere Geschwindigkeit.
- Das spezifische Volumen wandelt den Massenstrom in einen Volumenstrom um.
- Erst aus Volumenstrom und Geschwindigkeit folgt der freie Querschnitt.
][
*Merksatz:* Massefluss → Volumenfluss → Querschnitt.
]

#aufgabe(titel: "Heißdampfleitung: lichten Durchmesser bestimmen", art: "rechnen", quelle: "2.15.1", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.15", minuten: 10,
 ergebnis: [$d approx "0,08037"$ m = 80,37 mm.], tipp: [Die Kontinuität benötigt das spezifische Volumen des realen Heißdampfes.])[
#if not web [*Aufgabe 183* #linebreak()]
*Gegeben und Annahmen:* Stationärer Heißdampfstrom $dot(m)=8$ t/h bei $p=5$ MPa = 50 bar, $vartheta=500$ °C und mittlerer Geschwindigkeit $c=30$ m/s; kreisförmiger Leitungsquerschnitt. Tabellenwert bei genau diesem Zustand: $v="0,06849"$ m³/kg. $1$ t = $1000$ kg, $1$ h = $3600$ s.

*Gesucht:*
#enum(numbering: "a)")[Berechne den nötigen freien Querschnitt.][Bestimme den lichten Durchmesser und prüfe die Einheit.]
#src[Ü 2.15, PDF-S. 17; T29, PDF-S. 1; BT A.8, S. 492 / PDF-S. 507.]
][
*Massenstrom umrechnen:* $dot(m)=8000/3600=20/9$ kg/s. Der Volumenstrom ist $dot(V)=dot(m)v approx "0,1522"$ m³/s; er ist keine zusätzliche Masse.
][
*Querschnitt aus der Kontinuität bestimmen:* $A=dot(V)/c=dot(m)v/c approx "0,00507333"$ m². Ein langsamerer zulässiger Strom bräuchte bei gleichem Massenstrom einen größeren Querschnitt.
][
*Durchmesser berechnen:* $A=pi d^2/4$ ergibt $d=sqrt(4 dot(m)v/(pi c)) approx "0,0803714"$ m = 80,37 mm.
][
*Prüfen:* kg/s mal m³/kg geteilt durch m/s ergibt m²; die Wurzel daraus m. Mit dem zurückgerechneten Querschnitt ergibt sich wieder ungefähr 30 m/s. Gemeint ist der freie innere Durchmesser, ohne Wandstärke.
]

#aufgabe(titel: "Heißdampfleitung für 12 t/h (Variante)", art: "rechnen", quelle: "2.15.1", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.15", minuten: 8,
  ergebnis: [$dot(V) approx "0,228" thin "m"^3/"s"$; $A approx "9,13" times 10^(-3) thin "m"^2$; $d approx "107,8" thin "mm"$])[
#if not web [*Aufgabe 184* #linebreak()]
*Gegeben und Annahmen*

12 t/h Heißdampf mit 50 bar und 500 °C ($v = "0,06849" thin "m"^3/"kg"$ aus der Dampftafel) sollen mit höchstens 25 m/s durch eine Rohrleitung mit Kreisquerschnitt strömen.

*Gesucht*

#enum(numbering: "a)",
[Volumenstrom und freien Querschnitt.],
[Den lichten Durchmesser.],
)
][
*Volumenstrom:* $dot(m) = 12 thin 000\/3600 = "3,333" thin "kg/s"$; $dot(V) = dot(m) v approx "0,2283" thin "m"^3/"s"$; $A = dot(V)\/c approx "9,132" times 10^(-3) thin "m"^2$.
][
*Durchmesser:* $d = sqrt(4 A\/pi) approx "0,1078" thin "m" = "107,8" thin "mm"$. Mehr Dampf und langsamere Strömung verlangen ein deutlich weiteres Rohr als im Original.
]

#aufgabe(titel: "Halbes Volumen ist nicht halbe Dampfmasse", art: "verstehen", quelle: "2.15.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 185* #linebreak()]
Warum enthält eine volumetrisch halb mit Dampf gefüllte Kesseltrommel nicht zur Hälfte Dampfmasse?
][
*Antwort:*

- Dampf braucht pro Kilogramm viel mehr Raum als Flüssigkeit.
- Gleiche Teilvolumina liefern deshalb verschiedene Teilmassen.
- Der Dampfgehalt wird aus den Massen gebildet, nachdem jede Teilmasse über ihr spezifisches Volumen berechnet wurde.

#align(center)[#image("abbildungen/dampftrommel-anteile.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „Der Dampfgehalt ist genau 50 Prozent.“: Der Dampfgehalt ist ein Massenanteil, kein Volumenanteil.
- „Die beiden spezifischen Enthalpien werden ohne Gewichtung addiert.“: Erst Masse mal spezifische Enthalpie ergibt die addierbare Gesamtenergie.
]

#aufgabe(titel: "Kesseltrommel: halbes Volumen, anderer Massenanteil", art: "rechnen", quelle: "2.15.2", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.16", minuten: 12,
 ergebnis: [$m approx "3212,306"$ kg; $x approx "3,15803" thin "%"$; $H approx "3,876483"$ GJ.],
 tipp: [Berechne die Teilmassen aus den Teilvolumina; erst danach den Dampfgehalt.])[
#if not web [*Aufgabe 186* #linebreak()]
*Gegeben und Annahmen:* Geschlossene Kesseltrommel mit $V="8,0"$ m³, zur Hälfte des Volumens mit gesättigtem Wasser und zur Hälfte mit Sattdampf bei 5,0 MPa = 50 bar gefüllt. Sättigungstemperatur 263,9 °C. Stoffwerte derselben Sättigung: $v''="0,03943"$ m³/kg, $h'=1155$ kJ/kg und $h''=2794$ kJ/kg. Für $v'$ dieselbe im Tutorium vorgegebene Temperaturinterpolation verwenden:
#tab(columns: (1fr, 1fr), th([Temperatur °C], [$v'$ dm³/kg]), [260], [1,2756], [265], [1,2887])
$1$ dm³ = $10^(-3)$ m³, $1$ GJ = $10^6$ kJ.

*Gesucht:*
#enum(numbering: "a)")[Berechne $v'$ und die beiden Teilmassen.][Bestimme Gesamtmasse und Dampfgehalt.][Berechne H sowie die prozentualen Massen- und Volumenanteile.]
#src[Ü 2.16, PDF-S. 17; T29, PDF-S. 2–3. Tabellen und Rundungen wie dort.]
][
*Flüssigkeitsvolumen interpolieren:* $f=("263,9"-260)/(265-260)="0,78"$. Damit $v'=["1,2756"+"0,78"("1,2887"-"1,2756")]dot 10^(-3)="0,001285818"$ m³/kg. dm³ dürfen nicht ungeändert als m³ eingesetzt werden.
][
*Teilmassen aufbauen:* $V'=V''=4$ m³. $m'=4/v' approx "3110,86017"$ kg und $m''=4/"0,03943" approx "101,44560"$ kg. Die gleichen Volumina enthalten sehr unterschiedliche Massen.
][
*Dampf-Massenanteil bestimmen:* $m=m'+m'' approx "3212,30577"$ kg; $x=m''/m approx "0,0315803"="3,15803" thin "%"$. Der Flüssigkeitsmassenanteil beträgt etwa 96,84197 %. Beide Volumenanteile bleiben genau 50 %.
][
*Gesamte Enthalpie bilden:* $H=m'h'+m''h'' approx "3110,86017" dot 1155+"101,44560" dot 2794 approx "3876482,50"$ kJ = 3,876483 GJ. Erst Masse mal spezifischer Wert ist eine extensive Energie.
][
*Abgleich und Plausibilität:* In T29 steht im Produkt einmal 1150 statt des zuvor genannten 1155 kJ/kg. Verwendet wird durchgängig der Tabellenwert 1155. Die große Flüssigkeitsmasse und der kleine Dampf-Massenanteil passen zum enormen Unterschied zwischen $v'$ und $v''$.
]

#aufgabe(titel: "Kesseltrommel mit 40 Prozent Wasservolumen (Variante)", art: "rechnen", quelle: "2.15.2", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.16", minuten: 10,
  ergebnis: [$m approx "3263,0" thin "kg"$; $x approx "4,66" %$; $H approx "4,018" thin "GJ"$])[
#if not web [*Aufgabe 187* #linebreak()]
*Gegeben und Annahmen*

Eine geschlossene Kesseltrommel mit $10 thin "m"^3$ ist bei 50 bar zu 40 % ihres Volumens mit gesättigtem Wasser und zu 60 % mit Sattdampf gefüllt. Stoffwerte: $v' = "0,001285818" thin "m"^3/"kg"$, $v'' = "0,03943" thin "m"^3/"kg"$, $h' = 1155$, $h'' = 2794 thin "kJ/kg"$.

*Gesucht*

#enum(numbering: "a)",
[Teilmassen, Gesamtmasse und Dampfgehalt.],
[Die gesamte Enthalpie.],
)
][
*Massen:* $m' = 4\/"0,001285818" approx "3110,9" thin "kg"$, $m'' = 6\/"0,03943" approx "152,2" thin "kg"$, $m approx "3263,0" thin "kg"$, $x = m''\/m approx "0,0466"$. 60 % des Volumens sind nur 4,7 % der Masse.
][
*Enthalpie:* $H = m' h' + m'' h'' approx "3110,9" dot 1155 + "152,2" dot 2794 thin "kJ" approx "4,018" thin "GJ"$.
]

#aufgabe(titel: "Überhitzer: verschiedene Zustandswege", art: "verstehen", quelle: "2.15.3", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 188* #linebreak()]
Warum führt derselbe Heizvorgang im abgesperrten Überhitzer bei verschiedenen Anfangs-Dampfgehalten auf verschiedene Zustandswege?
][
*Antwort:*

- Jede Füllung besitzt ein anderes spezifisches Volumen.
- Nach dem Absperren bleiben Masse und Gesamtvolumen fest, also verläuft jede Füllung auf ihrer eigenen Isochore.
- Deshalb erreicht sie die Sattdampflinie und später bestimmte Druckgrenzen an anderen Zuständen.

#align(center)[#image("abbildungen/ueberhitzer-wege.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Wärme für die abgesperrte Überhitzerfüllung", art: "verstehen", quelle: "2.15.3", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 189* #linebreak()]
Für eine abgesperrte starre Überhitzerfüllung ändert sich der Druck. Mit welcher Formel berechnest du die benötigte Wärme bei unveränderten äußeren Energien, und warum genügt $Q=m(h_2-h_1)$ nicht?
][
*Antwort:* $Q=m[(h_2-h_1)-v(p_2-p_1)]$

Wärme ändert hier U. Der Druck-Volumen-Anteil verbindet u mit h und bleibt bei veränderlichem Druck erhalten.
][
*Typische Verwechslung:*

- „$Q=m(h_2-h_1)$ unabhängig vom Druckverlauf“: Die Änderung von pv wurde weggelassen. Konstantes v bedeutet nicht konstantes pv.
- „$Q=0$, weil keine Volumenarbeit übertragen wird.“: Die starre Wand verhindert Volumenarbeit, aber nicht Wärmeübertragung.
]

#aufgabe(titel: "Abgesperrter Überhitzer: zwei Füllungen und ihre Isochoren", art: "rechnen", quelle: "2.15.3", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.17", minuten: 30,
 ergebnis: [α: $p_2="11,5"$ bar, $vartheta_2="186,05"$ °C, $vartheta_3 approx "657,895"$ °C, $p_4 approx "24,3114"$ bar, $Q_14 approx "7849,57"$ kJ. β: $p_2 approx "1,12008"$ bar, $vartheta_2 approx "102,8201"$ °C, $p_4 approx "4,10573"$ bar, $Q_14 approx "258,226"$ kJ; Öffnungstemperatur bei 25 bar außerhalb der mitgegebenen Tabelle.],
 tipp: [Für jede Füllung bleibt ihr eigenes $v$ konstant. Bei starrer Erwärmung wird $Delta U$ benötigt, nicht allein $Delta H$.])[
#if not web [*Aufgabe 190* #linebreak()]
*Gegeben und Annahmen:* Ü 2.17: Zwei alternativ betrachtete geschlossene, starre Überhitzerfüllungen bei $p_1="0,1"$ MPa = 1 bar: α mit $x_1="0,10"$, β mit $x_1="0,90"$. Anfangswerte wie im Tutorium gerundet: $v'="0,00100"$, $v''="1,69400"$ m³/kg, $h'="417,5"$, $h''=2675$ kJ/kg. Das Sicherheitsventil öffnet bei 25 bar. Zusätzlich wird die hypothetisch geschlossene Erwärmung bis 600 °C betrachtet. Kein weiterer Arbeitsbeitrag, äußere Energien und Wandwärmekapazität vernachlässigt. Geometrie: 28 Rohrschlangen mit je 18 m Länge und 32 mm Innendurchmesser, Sammlervolumen 0,1 m³. $p$ in kPa mal $v$ in m³/kg ergibt kJ/kg; 1 bar = 100 kPa.

*Benötigte Tabellenauszüge (wie T29):*
#tab(columns: (1fr, 1fr, 1fr),
 th([$p$ bar], [Sättigungs-°C], [$v''$ m³/kg]),
 [1,1], [102,32], [1,549], [1,2], [104,81], [1,428],
 [11], [184,1], [0,1774], [12], [188,0], [0,1632],
)
#tab(columns: (1fr, 1fr, 1fr, 1fr),
 th([$p$ bar], [Temperatur °C], [$v$ m³/kg], [$h$ kJ/kg]),
 [25], [650], [0,1688], [3799], [25], [700], [0,1783], [3913],
 [25], [800], [0,1971], [4147],
 [1], [600], [4,0280], [3705], [5], [600], [0,8039], [3701],
 [10], [600], [0,4010], [3697], [25], [600], [0,1592], [3685],
)
Die 25-bar-Tabelle endet hier bei 800 °C. Innerhalb der mitgegebenen Stützstellen linear interpolieren; keine extrapolierte β-Öffnungstemperatur erfinden.

*Gesucht:*
#enum(numbering: "a)")[Berechne beide festen spezifischen Volumina und die Zustände beim erstmaligen Erreichen von Sattdampf.][Bestimme die Öffnungstemperatur für α; prüfe die Bestimmbarkeit für β.][Bestimme die hypothetischen Drücke bei 600 °C.][Berechne das Gefäßvolumen, beide Massen und beide Wärmemengen bis 600 °C. Ordne ein, ob vorher das Ventil öffnen würde.]
#src[Ü 2.17, PDF-S. 17; T29, PDF-S. 3–7. Vollständige Tabellen und Modellgrenze ergänzt; Nachrechnung ohne vorzeitige Zwischenrundung.]
][
*Je Füllung die Isochore bestimmen:* $v=v'+x(v''-v')$. Daraus $v_α="0,1703"$ und $v_β="1,5247"$ m³/kg. Diese Werte bleiben bis zur Ventilöffnung bei geschlossenem System unverändert; α und β dürfen nicht vermischt werden.
][
*Sattdampfzustände rückwärts interpolieren:* Gesucht ist jeweils $v''=v_1$. Für α liegt 0,1703 genau zwischen 0,1774 bei 11 bar und 0,1632 bei 12 bar. Daher $p_(2,α)="11,5"$ bar und $vartheta_(2,α)="186,05"$ °C. Für β ist $f=("1,5247"-"1,549")/("1,428"-"1,549") approx "0,200826"$; daraus $p_(2,β) approx "1,120083"$ bar und $vartheta_(2,β) approx "102,8201"$ °C.
][
*Ventilöffnung prüfen:* Bei α wird bei 25 bar nach $v="0,1703"$ zwischen 650 und 700 °C interpoliert: $vartheta_(3,α)=650+50("0,1703"-"0,1688")/("0,1783"-"0,1688") approx "657,895"$ °C. Bei β wird $v="1,5247"$ benötigt; selbst bei 800 °C gibt die Tabelle nur 0,1971 m³/kg. Die gesuchte Temperatur ist daraus nicht belastbar bestimmbar; dieser Datenmangel ist auch in T29 benannt.
][
*Druck und Enthalpie bei 600 °C für α bestimmen:* Bei dieser Temperatur liegt $v_α$ zwischen den 10- und 25-bar-Stützstellen. $f_α=("0,1703"-"0,4010")/("0,1592"-"0,4010") approx "0,9540943"$. Daher $p_(4,α)=10+15 f_α approx "24,311414"$ bar und $h_(4,α)=3697+f_α(3685-3697) approx "3685,550868"$ kJ/kg.
][
*Druck und Enthalpie bei 600 °C für β bestimmen:* Hier wird zwischen 1 und 5 bar interpoliert. $f_β=("1,5247"-"4,0280")/("0,8039"-"4,0280") approx "0,7764337"$. Damit $p_(4,β)=1+4 f_β approx "4,105735"$ bar und $h_(4,β)=3705+f_β(3701-3705) approx "3701,894265"$ kJ/kg. Die beiden Endenthalpien sind verschieden.
][
*Geometrie und Massen berechnen:* $V="0,1"+28 pi("0,032")^2/4 dot 18 approx "0,505340851"$ m³. $m_α=V/v_α approx "2,9673567"$ kg, $m_β=V/v_β approx "0,33143625"$ kg. Die anfänglichen Enthalpien aus der Mischungsregel sind $h_(1,α)="643,25"$ und $h_(1,β)="2449,25"$ kJ/kg.
][
*Innere Energie statt Enthalpie allein bilanzieren:* Starr und geschlossen ist $Q_14=m[(h_4-h_1)-100v(p_4-p_1)]$, wenn die Zahlenwerte der Drücke in bar eingesetzt werden. Für α: $u_1="626,22"$, $u_4 approx "3271,527481"$ kJ/kg, also $Q_(14,α) approx "7849,57095"$ kJ. Für β: $u_1="2296,78"$, $u_4 approx "3075,892860"$ kJ/kg, also $Q_(14,β) approx "258,22624"$ kJ.
][
*Rundung und Modellgrenze prüfen:* T29 nennt ungefähr 7846 kJ für α und 252,23 kJ für β. Die Rechnung hier führt die mitgegebenen Stützstellen ohne Zwischenrundung und mit getrenntem $h_4$ durch; ihre Resultate sind damit nachvollziehbar. Beide berechneten 600-°C-Drücke liegen unter 25 bar. Die reale Fortsetzung nach einer späteren Ventilöffnung wäre ein offenes System und keine weitere geschlossene Isochore.
]

#kapitel("Kapitel 3 · Energiebilanzen: Erster Hauptsatz")

#aufgabe(titel: "Altklausur WS 03/04: Kurzfrage 9", art: "verstehen", quelle: "3.1", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 03/04, Kurzfrage 9 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 191* #linebreak()]
Gib als Formel oder in Worten das allgemeine Prinzip der instationären Energiegleichung für endliche Systeme an.
][
*Antwort:* Zeitliche Änderung der gespeicherten Gesamtenergie = zugeführte Energie minus abgeführte Energie. Stoffströme tragen Enthalpie sowie Bewegungs- und Lageenergie. Hinzu kommen Wärme und technische Arbeit. Stationär entfällt der Speicherterm; bei einem Ein-/Austritt gilt $dot(Q)+P_t=dot(m)[Delta h+Delta(c^2/2)+g Delta z]$.
]

#aufgabe(titel: "Altklausur Übungsklausur WS 99/00: Kurzfrage 11", art: "verstehen", quelle: "3.1", herkunft: "original", minuten: 3, vorlage: "Altklausur Übungsklausur WS 99/00, Kurzfrage 11 (Import 12.11.2026, PDF-S. 2)")[
#if not web [*Aufgabe 192* #linebreak()]
Wie lautet der erste Hauptsatz für einen stationären Fließprozess?
][
*Antwort:* Zeitliche Änderung der gespeicherten Gesamtenergie = zugeführte Energie minus abgeführte Energie. Stoffströme tragen Enthalpie sowie Bewegungs- und Lageenergie. Hinzu kommen Wärme und technische Arbeit. Stationär entfällt der Speicherterm; bei einem Ein-/Austritt gilt $dot(Q)+P_t=dot(m)[Delta h+Delta(c^2/2)+g Delta z]$.
]

#aufgabe(titel: "Erster Hauptsatz mit der Teich-Analogie", art: "verstehen", quelle: "3.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 193* #linebreak()]
Erkläre einem Laien mit der Teich-Analogie, was der erste Hauptsatz aussagt und warum Wärme und Arbeit keine Zustandsgrößen sind.
][
*Kurz gesagt:* Der Wasserstand (gespeicherte Energie) ändert sich um das, was durch die Bäche netto zu- oder abfließt. Ist das Wasser im Teich, weiß man nicht mehr, ob es als „Wärme“ oder „Arbeit“ kam: Gespeichert ist nur Energie. $Q$ und $W$ existieren nur während des Übertragens und hängen vom Weg ab.
][
*Ausführlich:*

- Sie existieren nur während der Übertragung über die Grenze.
- Ist die Energie einmal im System, ist sie einfach Energie, man sieht ihr nicht mehr an, ob sie als Wärme oder Arbeit kam.

#align(center)[#image("abbildungen/hs-overview.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Wärme und Arbeit sind Übertragungswege, keine Speicheretiketten.
][
*Bild:* Teich mit Bächen: Die Bäche sind Wärme und Arbeit, der Wasserstand ist die gespeicherte Energie. Der Teich weiß nicht, aus welchem Bach sein Wasser kam.
]

#aufgabe(titel: "Energiemenge und Wärmestrom", art: "verstehen", quelle: "3.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 194* #linebreak()]
Was unterscheidet die Energiemenge $Q_12$ von dem Wärmestrom $dot(Q)_12$? Welche Einheiten haben sie, und kann auch ein geschlossenes System einen Wärmestrom aufnehmen?
][
*Kurz gesagt:* Die geschlossene Bilanz vergleicht hier eine Energiemenge zwischen zwei Zeitpunkten: $Q_12$ in kJ. Die offen-stationäre Bilanz verwendet einen Energiestrom: $dot(Q)_12=dot(m)q_12$ in kW. Der Punkt heißt „pro Zeit“; auch ein geschlossenes System kann einen Wärmestrom aufnehmen.
][
*Ausführlich:*

- $Q_12$ ist eine Energiemenge in J oder kJ, übertragen zwischen zwei Zeitpunkten.
- $dot(Q)_12$ ist ein Wärmestrom in W oder kW, also Energie pro Zeit.
- Der Punkt bezeichnet den Zeitbezug, nicht die Systemart.
- Auch ein geschlossenes System kann einen Wärmestrom aufnehmen.

#align(center)[#image("abbildungen/hs-overview.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Der Punkt auf Q macht aus Energie einen Strom.
]

#aufgabe(titel: "Erster Hauptsatz in einem Satz", art: "verstehen", quelle: "3.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 195* #linebreak()]
Was sagt der erste Hauptsatz in einem Satz?
][
*Antwort:*

- Die Änderung der gespeicherten Energie eines Systems ist gleich der Summe der Energie, die als Wärme, Arbeit und mit Stoffströmen über die Grenze kommt.
- Energie geht nicht verloren und entsteht nicht.
- Er sagt aber nicht, welche Prozessgröße in welche Zustandsänderung umgewandelt wird.

#align(center)[#image("abbildungen/hs-overview.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Vorgehen bei Aufgaben zum ersten Hauptsatz", art: "verstehen", quelle: "3.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 196* #linebreak()]
Wie gehe ich bei einer Aufgabe zum ersten Hauptsatz vor?
][
*Antwort:*

- System und Zustände ① und ② festlegen.
- Offen oder geschlossen?
- Danach h oder u wählen.
- Alle Terme hinschreiben.
- Erst dann mit den Annahmen streichen (stationär, adiabat, reibfrei, ruhend).
- Stoffwerte einsetzen.
]

#aufgabe(titel: "Enthalpie im offenen System", art: "verstehen", quelle: "3.1.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 197* #linebreak()]
Warum steht im 1. HS für offene Systeme die Enthalpie $h$, im geschlossenen System aber die innere Energie $u$?
][
*Kurz gesagt:* Im offenen System muss Stoff gegen den Druck hinein- und hinausgeschoben werden. Diese Verschiebearbeit $p v$ steckt in $h=u+p v$. Im geschlossenen System fließt kein Stoff über die Grenze, also gibt es keine Verschiebearbeit.
][
*Ausführlich:*

- Im offenen System muss der Stoff hinein- und hinausgeschoben werden.
- Diese Verschiebearbeit $p v$ steckt in $h = u + p v$.
- Im geschlossenen System geht keine Masse über die Grenze, es gibt keine Verschiebearbeit.
- Deshalb reicht $u$.

#align(center)[#image("abbildungen/hs-open.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „Weil durchströmte Systeme keine innere Energie haben.“: Der Stoff hat innere Energie. $h$ enthält sie und zusätzlich $p v$.
- „Weil die Enthalpie bei Strömungen immer konstant ist.“: Sie ändert sich, wenn Wärme oder technische Arbeit übertragen wird.
]

#aufgabe(titel: "Stoffstromenergie aus Enthalpie, Bewegung und Lage", art: "verstehen", quelle: "3.1.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 198* #linebreak()]
Welche Energieformen stehen in der Stoffstromenergie e = h + c²/2 + g·z?
][
*Antwort:*

- \*\*$h$:\*\* innere Energie plus Verschiebearbeit, jeweils je kg.
- \*\*$c^2\/2$:\*\* Bewegungsenergie je kg.
- \*\*$g z$:\*\* Lageenergie je kg.
- *Einheitenfalle:* $c^2\/2$ und $g z$ ergeben J/kg.
- Für eine Bilanz in kJ/kg diese Beiträge durch 1000 teilen.

#align(center)[#image("abbildungen/hs-open.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Adiabate Turbine: Leistung mit Vorzeichen", art: "rechnen", quelle: "3.1.1", herkunft: "eigen", minuten: 4)[
#if not web [*Aufgabe 199* #linebreak()]
*Turbine (eigenes Zahlenbeispiel):*

*Gegeben und Annahmen*

Eine adiabate Dampfturbine wird stationär mit $dot(m)=10 thin "kg/s"$ durchströmt, $h_1=3200 thin "kJ/kg"$, $h_2=2500 thin "kJ/kg"$. Änderungen von $c$ und $z$ sind vernachlässigbar.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $P$ und deute das Vorzeichen.],
)
][
*Modell:* offen, stationär, ein Ein- und Austritt; $dot(Q)=0$, Änderungen von Bewegungs- und Lageenergie vernachlässigt.
][
*Bilanz vereinfachen:* $dot(Q)+P=dot(m)[Delta h+Delta(c^2/2)+g Delta z]$ ergibt $P=dot(m)(h_2-h_1)$.
][
*Einsetzen:* $P=10 thin "kg/s" dot (2500-3200) thin "kJ/kg"$.
][
*Ergebnis: $P=-7000 thin "kW"=-7 thin "MW"$.* Die Turbine gibt 7 MW ab.
][
*Prüfung:* kg/s mal kJ/kg ergibt kW. Sinkende Enthalpie und negative Zufuhrleistung passen zusammen; der Betrag der Abgabeleistung ist positiv.
]

#aufgabe(titel: "Düse: Enthalpie wird Bewegungsenergie", art: "rechnen", quelle: "3.1.1", herkunft: "eigen", minuten: 5)[
#if not web [*Aufgabe 200* #linebreak()]
*Düse:*

*Gegeben und Annahmen*

In einer adiabaten Düse ohne technische Arbeit und ohne Höhenänderung sinkt die Enthalpie um $45 thin "kJ/kg"$. Eintrittsgeschwindigkeit $c_1=50 thin "m/s"$.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $c_2$.],
)
][
*Modell:* offen, stationär, adiabat; keine technische Arbeit und keine Höhenänderung.
][
*Bilanz vereinfachen:* $h_2-h_1+(c_2^2-c_1^2)/2=0$.
][
*Einheiten angleichen:* $h_2-h_1=-45 thin "kJ/kg"=-45000 thin "J/kg"$.
][
*Auflösen:* $c_2=sqrt(c_1^2-2(h_2-h_1))=sqrt(50^2+2 dot 45000) thin "m/s"$.
][
*Ergebnis: $c_2 approx "304,1" thin "m/s"$.*
][
*Prüfung:* J/kg entspricht m²/s². Der Enthalpieabfall erhöht die Geschwindigkeit; ein Faktor 1000 darf vor der Wurzel nicht fehlen.
]

#aufgabe(titel: "Wasserwirbelbremse am Pkw-Motor", art: "rechnen", quelle: "3.1.1", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 3.1", minuten: 10,
  ergebnis: [$P_e approx "21,33" thin "kW"$; $dot(H)_2 - dot(H)_1 approx "19,23" thin "kW"$; $approx "9,8" %$ als Wärme an die Umgebung])[
#if not web [*Aufgabe 201* #linebreak()]
*Gegeben und Annahmen*

Der Motor eines Pkw wird an einer Wasserwirbelbremse untersucht. Bei einer Drehzahl von $4200 thin "min"^(-1)$ wird ein Drehmoment von $M = "48,5" thin "N m"$ gemessen. Das Wasser erwärmt sich in der Bremse von 12 °C auf 37,5 °C, wobei der Volumenstrom mit 10,8 l/min gemessen wurde. Wasser: $rho = 1000 thin "kg/m"^3$, $c = "4,19" thin "kJ/(kg K)"$, inkompressibel. Stationärer Betrieb.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist die effektive Leistung des Motors?],
[Welcher Energiestrom dient der Erhöhung der Enthalpie des Wassers, wenn die Änderung der kinetischen Energie vernachlässigt werden kann?],
[Wie viel Prozent des zugeführten Energiestroms wird als Wärme an die Umgebung abgegeben?],
)
][
*Wellenleistung:* Leistung = Drehmoment mal Winkelgeschwindigkeit, $omega = 2 pi n$ mit $n = 4200\/60 = 70 thin "s"^(-1)$:
$ P_e = 2 pi n M = 2 pi dot 70 dot "48,5" thin "W" approx "21,33" thin "kW" $
Diese Leistung fließt über die Welle in die Bremse.
][
*Enthalpiestrom des Wassers:* $dot(m) = rho dot(V) = "10,8"\/60 thin "kg/s" = "0,18" thin "kg/s"$. Für inkompressibles Wasser bei nahezu gleichem Druck ist $Delta h = c Delta T$:
$ dot(m)(h_2 - h_1) = "0,18" dot "4,19" dot "25,5" thin "kW" approx "19,23" thin "kW" $
][
*Wärmeverlust:* Stationäre Energiebilanz der Bremse: $0 = P_e + dot(Q) - dot(m)(h_2 - h_1)$. Daraus
$ dot(Q) = "19,23" - "21,33" thin "kW" approx -"2,10" thin "kW" quad quad abs(dot(Q))/P_e approx "9,8" % $
Das negative Vorzeichen heißt: Die Bremse gibt Wärme an die Umgebung ab. Rund 90 % der Motorleistung landen im Kühlwasser.
]

#aufgabe(titel: "Wasserwirbelbremse bei 3000 Umdrehungen (Variante)", art: "rechnen", quelle: "3.1.1", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 3.1", minuten: 8,
  ergebnis: [$P_e approx "29,85" thin "kW"$; $dot(m) Delta h approx "26,19" thin "kW"$; Wärmeabgabe $approx "3,66" thin "kW" approx "12,3" %$])[
#if not web [*Aufgabe 202* #linebreak()]
*Gegeben und Annahmen*

Ein Motor wird an einer Wasserwirbelbremse bei $3000 thin "min"^(-1)$ und $M = 95 thin "N m"$ gemessen. 25 l/min Wasser ($rho = 1000 thin "kg/m"^3$, $c = "4,19" thin "kJ/(kg K)"$) erwärmen sich von 15 °C auf 30 °C. Stationär, kinetische Energie vernachlässigbar.

*Gesucht*

#enum(numbering: "a)",
[Die Motorleistung.],
[Den Enthalpiestrom, den das Wasser aufnimmt.],
[Den Wärmestrom an die Umgebung und seinen Anteil an der Motorleistung.],
)
][
*Leistung:* $P_e = 2 pi dot 50 thin "s"^(-1) dot 95 thin "N m" approx "29,85" thin "kW"$.
][
*Wasser:* $dot(m) = 25\/60 thin "kg/s" = "0,4167" thin "kg/s"$; $dot(m) c Delta T = "0,4167" dot "4,19" dot 15 thin "kW" approx "26,19" thin "kW"$.
][
*Bilanz:* $dot(Q) = dot(m) Delta h - P_e approx -"3,66" thin "kW"$, also gehen rund 12,3 % der Leistung als Wärme an die Umgebung. Probe: Der Anteil ist positiv und kleiner als 100 %, die Messung ist plausibel.
]

#aufgabe(titel: "Elektrokalorischer Durchflussmesser für Stickstoff", art: "rechnen", quelle: "3.1.1", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 3.3", minuten: 12,
  ergebnis: [$dot(m) approx 578 thin "kg/h"$; $dot(V)_2 approx "0,141" thin "m"^3/"s"$; $w_2 approx "17,96" thin "m/s"$])[
#if not web [*Aufgabe 203* #linebreak()]
*Gegeben und Annahmen*

In einer Rohrstrecke mit 100 mm Durchmesser, in der Stickstoff (N#sub[2]) von Umgebungstemperatur strömt, soll der Massenstrom mithilfe eines elektrokalorischen Durchflussmengenmessers ermittelt werden. In das Rohr ist über dem Querschnitt ein elektrischer Widerstandsheizer, der 500 W aufnimmt, eingebaut. Durch diese Energiezufuhr steigt die Temperatur des N#sub[2] von $vartheta_1 = 20 thin "°C"$ um $Delta vartheta = 3 thin "K"$ bei gleich bleibendem Druck von 0,1 MPa. Die Wärmeverluste an die Umgebung seien vernachlässigbar klein. Stickstoff als ideales Gas: $R = "296,8" thin "J/(kg K)"$, $kappa = "1,4"$. Änderungen von kinetischer und potentieller Energie werden in der Energiebilanz vernachlässigt.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist der Massenstrom in kg/h?],
[Wie groß ist der Volumenstrom nach der Erwärmung in m³/s?],
[Wie groß ist die Strömungsgeschwindigkeit nach dem Heizen in m/s?],
)
][
*Wärmekapazität:* Für das ideale Gas gilt $c_p = kappa R\/(kappa - 1) = "1,4" dot "296,8"\/"0,4" approx "1038,8" thin "J/(kg K)"$.
][
*Energiebilanz des Messabschnitts:* Stationär, adiabat nach außen, keine Wellenarbeit. Die elektrische Leistung erhöht nur den Enthalpiestrom:
$ P_"el" = dot(m) c_p Delta T quad => quad dot(m) = 500/("1038,8" dot 3) thin "kg/s" approx "0,1604" thin "kg/s" approx 578 thin "kg/h" $
Darum misst das Gerät den Massenstrom: Aus der bekannten Heizleistung und der gemessenen Temperaturerhöhung folgt $dot(m)$.
][
*Volumenstrom nach dem Heizen:* Gasgleichung mit $T_2 = "296,15" thin "K"$:
$ dot(V)_2 = (dot(m) R T_2)/p = ("0,1604" dot "296,8" dot "296,15")/10^5 thin "m"^3/"s" approx "0,141" thin "m"^3/"s" $
][
*Geschwindigkeit:* $A = pi dot "0,1"^2\/4 = "7,854" times 10^(-3) thin "m"^2$, also $w_2 = dot(V)_2\/A approx "17,96" thin "m/s"$. Probe: Die kinetische Energie $w^2\/2 approx "0,16" thin "kJ/kg"$ ist klein gegen $c_p Delta T approx "3,1" thin "kJ/kg"$, die Vernachlässigung war berechtigt.
]

#aufgabe(titel: "Durchflussmesser mit 800 W Heizleistung (Variante)", art: "rechnen", quelle: "3.1.1", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 3.3", minuten: 10,
  ergebnis: [$dot(m) approx 693 thin "kg/h"$; $dot(V)_2 approx "0,170" thin "m"^3/"s"$; $w_2 approx "33,8" thin "m/s"$])[
#if not web [*Aufgabe 204* #linebreak()]
*Gegeben und Annahmen*

Stickstoff ($R = "296,8" thin "J/(kg K)"$, $kappa = "1,4"$) strömt bei 1 bar durch ein Rohr mit 80 mm Innendurchmesser. Ein Heizer nimmt 800 W auf und erwärmt das Gas ohne Verluste von 20 °C um 4 K bei konstantem Druck.

*Gesucht*

#enum(numbering: "a)",
[Den Massenstrom in kg/h.],
[Volumenstrom und Geschwindigkeit nach dem Heizer.],
)
][
*Massenstrom:* $c_p = "1038,8" thin "J/(kg K)"$; $dot(m) = 800\/("1038,8" dot 4) thin "kg/s" approx "0,1925" thin "kg/s" approx 693 thin "kg/h"$.
][
*Nach dem Heizer:* $T_2 = "297,15" thin "K"$; $dot(V)_2 = dot(m) R T_2\/p approx "0,1698" thin "m"^3/"s"$; $A = pi dot "0,08"^2\/4 = "5,027" times 10^(-3) thin "m"^2$; $w_2 approx "33,8" thin "m/s"$. Das engere Rohr macht die Strömung fast doppelt so schnell wie im Original.
]

#aufgabe(titel: "Kurzfrage: Erster Hauptsatz für den Dampfdrucktopf", art: "verstehen", quelle: "3.1.2", herkunft: "original", vorlage: "Leistungsnachweis SS 13, Kurzfrage 7", minuten: 3)[
#if not web [*Aufgabe 205* #linebreak()]
Notiere den ersten Hauptsatz für das Erwärmen von Hühnersuppe in einem dichten Dampfdrucktopf.
][
*System:* Topfinhalt, geschlossen (dicht) und starr. Keine Volumenarbeit, keine sonstige Arbeit; äußere Energien ändern sich nicht.
][
*Antwort:* $m (u_2 - u_1) = Q_12$ beziehungsweise $U_2 - U_1 = Q_12$ mit $W_12 = 0$. Die zugeführte Wärme erhöht nur die innere Energie; Druck und Temperatur steigen dabei gemeinsam auf der Dampfdruckkurve.
]

#aufgabe(titel: "Altklausur WS 04/05: Kurzfrage 7", art: "verstehen", quelle: "3.1.2", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 04/05, Kurzfrage 7 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 206* #linebreak()]
Notiere den ersten Hauptsatz für das Erwärmen von Hühnersuppe in einem dichten Dampfdrucktopf.
][
*Bilanz erklären:* Für den dichten, starren und ruhenden Drucktopf ohne Rührer oder andere Arbeit gilt $Q_12=U_2-U_1$. Bei Ausströmen über ein Ventil ist das System offen; zusätzlich muss die ausgetragene Enthalpie bilanziert werden. „Dicht“ und „Dampfaustritt“ dürfen nicht gleichzeitig ohne Anpassung der Grenze vorausgesetzt werden.
]

#aufgabe(titel: "Altklausur WS 00/01: Kurzfrage 9", art: "verstehen", quelle: "3.1.2", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 00/01, Kurzfrage 9 (Import 12.11.2026, PDF-S. 2)")[
#if not web [*Aufgabe 207* #linebreak()]
Wie lautet der erste Hauptsatz für die Verdampfung von Wasser in einem Druckkessel?
][
*Bilanz erklären:* Für den dichten, starren und ruhenden Drucktopf ohne Rührer oder andere Arbeit gilt $Q_12=U_2-U_1$. Bei Ausströmen über ein Ventil ist das System offen; zusätzlich muss die ausgetragene Enthalpie bilanziert werden. „Dicht“ und „Dampfaustritt“ dürfen nicht gleichzeitig ohne Anpassung der Grenze vorausgesetzt werden.
]

#aufgabe(titel: "Altklausur WS 99/00 LN: Kurzfrage 9", art: "verstehen", quelle: "3.1.2", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 99/00 LN, Kurzfrage 9 (Import 12.11.2026, PDF-S. 2)")[
#if not web [*Aufgabe 208* #linebreak()]
Wie lautet der erste Hauptsatz für die Verdampfung von Wasser in einem Druckkessel?
][
*Bilanz erklären:* Für den dichten, starren und ruhenden Drucktopf ohne Rührer oder andere Arbeit gilt $Q_12=U_2-U_1$. Bei Ausströmen über ein Ventil ist das System offen; zusätzlich muss die ausgetragene Enthalpie bilanziert werden. „Dicht“ und „Dampfaustritt“ dürfen nicht gleichzeitig ohne Anpassung der Grenze vorausgesetzt werden.
]

#aufgabe(titel: "Druckarbeit und Volumenarbeit", art: "verstehen", quelle: "3.1.2", herkunft: "eigen", minuten: 3,
  tipp: [Im geschlossenen System ändert sich das Volumen, im offenen fließt Stoff durch eine Maschine mit festem Volumen.])[
#if not web [*Aufgabe 209* #linebreak()]
Welche Arbeit gehört zum offenen, welche zum geschlossenen System: $integral v dif p$ oder $-integral p dif v$? Wozu dient das Minuszeichen?
][
*Kurz gesagt:* Offen: Druckarbeit $w_p=integral v dif p$ (Teil von $w_t$). Geschlossen: Volumenarbeit $w_v=-integral p dif v$ (Teil von $w_g$). Bei Kompression ist $dif v<0$; das Minus macht die zugeführte Arbeit positiv.
][
*Ausführlich:*

- *Offen (durchströmt):* technische Arbeit, mit der Druckarbeit $integral v dif p$.
- Das Maschinenvolumen ändert sich nicht, aber der Druck.
- *Geschlossen:* Gesamtarbeit, mit der Volumenarbeit $-integral p dif v$.
- Der Kolben verschiebt sich, das Volumen ändert sich.

#align(center)[#image("abbildungen/hs-closed.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Starrer Wassertank: Restwasser vollständig verdampfen", art: "rechnen", quelle: "3.1.2", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 3.4", minuten: 15,
  ergebnis: [$m approx "48,48" thin "kg"$, $v approx "0,02063" thin "m"^3/"kg"$; Enddruck $approx "89,6" thin "bar"$; $Q_12 approx "102,8" thin "MJ"$])[
#if not web [*Aufgabe 210* #linebreak()]
*Gegeben und Annahmen*

Ein starrer Wassertank mit Volumen $1 thin "m"^3$ enthält beim Druck 1 bar $"0,05" thin "m"^3$ Wasser und $"0,95" thin "m"^3$ Dampf im Gleichgewicht. Der Tank ist geschlossen; äußere Energien ändern sich nicht.

Dampftafel Wasser, Sättigung:
#tab(columns: (1fr, 1.3fr, 1fr, 1fr, 1fr),
 th([$p$ in bar], [$v'$ in m³/kg], [$v''$ in m³/kg], [$h'$ in kJ/kg], [$h''$ in kJ/kg]),
 [1], [$"1,0434" times 10^(-3)$], [1,694], [417,5], [2676],
 [85], [], [0,02193], [], [2753],
 [90], [], [0,02050], [], [2745],
)

*Gesucht*

#enum(numbering: "a)",
[Welche Wärme muss man zuführen, um den Rest des Wassers vollständig zu verdampfen?],
)
][
*Modell:* Starr und geschlossen: Masse und Volumen bleiben, also bleibt auch $v = V\/m$. Keine Arbeit, also $Q_12 = m(u_2 - u_1)$. Der Endzustand ist der Punkt, an dem die Isochore die Taulinie trifft: gesättigter Dampf mit $v'' = v$.
][
*Masse und spezifisches Volumen:*
$ m' = "0,05"/("1,0434" times 10^(-3)) approx "47,920" thin "kg" quad m'' = "0,95"/"1,694" approx "0,561" thin "kg" quad m approx "48,481" thin "kg" $
$ v = 1/"48,481" approx "0,020627" thin "m"^3/"kg" $
*Richtung prüfen:* $v approx "0,0206"$ liegt über $v_"kr" approx "0,0031" thin "m"^3/"kg"$, also verlässt die Isochore das Nassdampfgebiet auf der Dampfseite. Das Wasser verdampft tatsächlich vollständig.
][
*Innere Energie am Anfang:* $u = h - p v$ für jede Phase, $p = 10^5 thin "Pa"$:
$ U_1 = m'(h' - p v') + m''(h'' - p v'') approx "47,920" dot "417,40" + "0,561" dot "2506,6" thin "kJ" approx 21 thin 407 thin "kJ" $
][
*Endzustand interpolieren:* $v'' = "0,020627"$ liegt zwischen 85 bar (0,02193) und 90 bar (0,02050); Anteil $f approx "0,911"$:
$ p_2 approx "89,56" thin "bar" quad h_2'' approx "2745,7" thin "kJ/kg" quad u_2 = h_2'' - p_2 v approx "2745,7" - "184,7" approx "2561,0" thin "kJ/kg" $
][
*Wärme:* $Q_12 = m u_2 - U_1 approx "48,481" dot "2561,0" - 21 thin 407 thin "kJ" approx 102 thin 750 thin "kJ" approx "102,8" thin "MJ"$. Fast die ganze Wärme verdampft die 48 kg Wasser; dabei steigt der Druck im starren Tank auf rund 90 bar.
]

#aufgabe(titel: "Starrer Tank mit 1,5 m³ verdampfen (Variante)", art: "rechnen", quelle: "3.1.2", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 3.4", minuten: 12,
  ergebnis: [$m approx "71,76" thin "kg"$; $p_2 approx "88,6" thin "bar"$; $Q_12 approx 152 thin "MJ"$])[
#if not web [*Aufgabe 211* #linebreak()]
*Gegeben und Annahmen*

Ein starrer, geschlossener Tank mit $"1,5" thin "m"^3$ enthält bei 1 bar $"0,074" thin "m"^3$ Wasser, der Rest ist Dampf im Gleichgewicht. Dampftafel wie im Original:
#tab(columns: (1fr, 1.3fr, 1fr, 1fr, 1fr),
 th([$p$ in bar], [$v'$ in m³/kg], [$v''$ in m³/kg], [$h'$ in kJ/kg], [$h''$ in kJ/kg]),
 [1], [$"1,0434" times 10^(-3)$], [1,694], [417,5], [2676],
 [85], [], [0,02193], [], [2753],
 [90], [], [0,02050], [], [2745],
)

*Gesucht*

#enum(numbering: "a)",
[Den Enddruck, wenn gerade alles Wasser verdampft ist.],
[Die dazu nötige Wärme.],
)
][
*Massen:* $m' = "0,074"\/("1,0434" times 10^(-3)) approx "70,922" thin "kg"$, $m'' = "1,426"\/"1,694" approx "0,842" thin "kg"$, $m approx "71,764" thin "kg"$, $v = "1,5"\/m approx "0,020902" thin "m"^3/"kg"$.
][
*Endzustand:* Taulinie mit $v'' = v$: $f = ("0,020902" - "0,02193")\/("0,02050" - "0,02193") approx "0,719"$, also $p_2 approx "88,6" thin "bar"$, $h'' approx "2747,2" thin "kJ/kg"$, $u_2 = h'' - p_2 v approx "2562,1" thin "kJ/kg"$.
][
*Wärme:* $U_1 approx 31 thin 713 thin "kJ"$ ($u_1 approx "441,9" thin "kJ/kg"$); $Q_12 = m u_2 - U_1 approx 183 thin 864 - 31 thin 713 thin "kJ" approx 152 thin "MJ"$. Mehr Wasser im größeren Tank braucht entsprechend mehr Wärme; der Enddruck ändert sich kaum, weil $v$ fast gleich bleibt.
]

#aufgabe(titel: "Starrer Tank: Nassdampf bis zur reinen Flüssigkeit heizen", art: "rechnen", quelle: "3.1.2", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 3.5", minuten: 15,
  ergebnis: [$m approx "122,0" thin "kg"$; $U_1 approx 104 thin 976 thin "kJ"$; Endzustand $approx "217,5" thin "bar"$, $"372,7" thin "°C"$; $Q_12 approx 127 thin 780 thin "kJ"$])[
#if not web [*Aufgabe 212* #linebreak()]
*Gegeben und Annahmen*

Ein starrer Wassertank mit Volumen $"0,3" thin "m"^3$ enthält Nassdampf bei 15 bar, wobei 99 % der Gesamtmasse in flüssiger Form vorliegen. Der Tank ist geschlossen; äußere Energien ändern sich nicht.

Dampftafel Wasser: bei 15 bar $vartheta_s = "198,28" thin "°C"$, $v' = "1,1538" times 10^(-3)$, $v'' = "0,1316482" thin "m"^3/"kg"$, $h' = "844,6"$, $h'' = 2790 thin "kJ/kg"$. Siedelinie, interpoliert für $v' = "2,4587" times 10^(-3) thin "m"^3/"kg"$: $p = "217,5" thin "bar"$, $vartheta = "372,72" thin "°C"$, $h' = "1961,1" thin "kJ/kg"$.

*Gesucht*

#enum(numbering: "a)",
[Welche Wärme muss man zuführen, wenn der Tank ausschließlich Wasser enthalten soll?],
)
][
*Modell:* Starr und geschlossen: $v$ bleibt konstant, $Q_12 = m(u_2 - u_1)$. Ausschließlich Wasser heißt: Die Isochore erreicht die Siedelinie, $v' = v$. Das geht nur, wenn $v < v_"kr"$ ist.
][
*Zustand ①:* 99 % flüssig heißt $x = "0,01"$:
$ v = v' + x(v'' - v') approx "2,4587" times 10^(-3) thin "m"^3/"kg" quad m = "0,3"/v approx "122,01" thin "kg" $
$ h_1 = h' + x(h'' - h') = "864,05" thin "kJ/kg" quad u_1 = h_1 - p v = "864,05" - "3,69" approx "860,37" thin "kJ/kg" $
$ U_1 = m u_1 approx 104 thin 976 thin "kJ" $
Wegen $v approx "2,46" times 10^(-3) < v_"kr" approx "3,1" times 10^(-3) thin "m"^3/"kg"$ steigt der Flüssigkeitsspiegel beim Heizen, bis der Dampf verschwindet.
][
*Zustand ②:* Siedelinie mit $v' = "2,4587" times 10^(-3)$: $p_2 = "217,5" thin "bar"$, $vartheta_2 = "372,72" thin "°C"$, $h' = "1961,1" thin "kJ/kg"$.
$ u_2 = h' - p_2 v' = "1961,1" - "217,5" times 10^5 dot "2,4587" times 10^(-3)\/1000 approx "1907,6" thin "kJ/kg" $
][
*Wärme:* $Q_12 = m(u_2 - u_1) approx "122,01" dot ("1907,6" - "860,37") thin "kJ" approx 127 thin 780 thin "kJ"$. Der Tank endet nahe dem kritischen Punkt bei über 200 bar: Ein geschlossener, fast voller Behälter wird beim Heizen gefährlich.
]

#aufgabe(titel: "Dissipation im ersten Hauptsatz", art: "verstehen", quelle: "3.1.3", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 213* #linebreak()]
Was bedeutet Dissipation J₁₂ im ersten Hauptsatz?
][
*Antwort:*

- Ein Teil der zugeführten Arbeit wird durch Reibung oder Turbulenz direkt zu innerer Energie, statt das Volumen zu ändern.
- Er wirkt wie Wärmezufuhr, ist aber über die Grenze als Arbeit gekommen.
- Man darf ihn deshalb nicht noch einmal als Wärme addieren.

#align(center)[#image("abbildungen/hs-special.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Erster Hauptsatz im abgeschlossenen System", art: "verstehen", quelle: "3.1.3", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 214* #linebreak()]
Was bleibt vom ersten Hauptsatz für ein abgeschlossenes, ruhendes System übrig?
][
*Antwort:*

- Weder Wärme noch Arbeit noch Masse gehen über die Grenze.
- *Also ändert sich die Energie nicht:* $Delta U = 0$, wenn das System auch ruht und seine Höhe gleich bleibt.

#align(center)[#image("abbildungen/hs-special.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Rührer im starren Behälter", art: "rechnen", quelle: "3.1.3", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 215* #linebreak()]
*Rührer:*

*Gegeben und Annahmen*

In einen starren, adiabaten Behälter werden mit einem Rührer $50 thin "kJ"$ Arbeit eingebracht.

*Gesucht*

#enum(numbering: "a)",
[Wie ändert sich $U$?],
[Welcher Sonderfall aus 3.1.3 liegt vor, und warum ist es *kein* abgeschlossenes System?],
)
][
*Modell:* geschlossen, adiabat und starr; gleiche äußere Bewegungs- und Lageenergie vor und nach dem Rühren. Der Endzustand wird nach dem Abklingen der Strömung betrachtet.
][
*Energie über die Grenze zählen:* $Q_12=0$, $W_(v 12)=0$, aber $W_(g,12)=+50 thin "kJ"$ durch die Rührerwelle.
][
*Bilanz:* $Delta U=Q_12+W_(g,12)=0+50 thin "kJ"$.
][
*Ergebnis: $Delta U=+50 thin "kJ"$.* Es ist der Sonderfall mit Dissipation; im Modell gilt $J_12=50 thin "kJ"$.
][
*Prüfung:* Die Rührarbeit wird nur einmal gezählt. Starr bedeutet keine Volumenarbeit, nicht keine Wellenarbeit; wegen der Arbeitszufuhr ist das System nicht abgeschlossen.
]

#aufgabe(titel: "Warum sich die Bleikugel erwärmt", art: "verstehen", quelle: "3.1.4", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 216* #linebreak()]
Warum erwärmt sich eine Bleikugel beim Aufschlag?
][
*Antwort:*

- Ihre Lage- und Bewegungsenergie wird beim Aufprall durch Verformung zu innerer Energie.
- Im idealen Modell geht nichts an Boden oder Luft, dann steigt ihre Temperatur um $(c^2\/2 + g z)\/c_"Pb"$.
- Real geht ein Teil an Boden und Umgebung.

#align(center)[#image("abbildungen/ball.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Bleikugel: Temperaturanstieg abschätzen", art: "verstehen", quelle: "3.1.4", herkunft: "eigen", minuten: 3,
  tipp: [Erst System und Zustände ① und ② festlegen, dann alle Terme des 1. HS aufschreiben und streichen.])[
#if not web [*Aufgabe 217* #linebreak()]
Eine Bleikugel fällt aus 30 m Höhe mit 30 m/s Anfangsgeschwindigkeit auf den Boden. Alle Energie bleibt in der Kugel, $c_"Pb" = 130 thin "J/(kg K)"$. Um wie viel erwärmt sie sich? Begründe deine Antwort.
][
*Antwort:* Um etwa 5,7 K

$Delta T = (c_1^2\/2 + g z_1)\/c_"Pb" = (450 + "294,3")\/130$.
][
*Typische Verwechslung:*

- „Um etwa 0,0057 K“: So käme es heraus, wenn man $c_"Pb"$ als 130 kJ/(kg K) einsetzt. Blei hat aber rund 0,13 kJ/(kg K).
- „Um etwa 2,3 K“: Das ist nur die Lageenergie. Die kinetische Anfangsenergie fehlt.
- „Das hängt von der Masse der Kugel ab.“: Die Masse kürzt sich heraus, weil alle Energien pro Kilogramm gerechnet werden.
]

#aufgabe(titel: "Was der erste Hauptsatz sagt und was nicht", art: "verstehen", quelle: "3.1.4", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 218* #linebreak()]
Was sagt der erste Hauptsatz über die Zustandsänderungen eines Systems aus, und was sagt er nicht? Erlaubt er, Wärme stets vollständig in Arbeit umzuwandeln, und gilt er nur für reversible Prozesse?
][
*Antwort:* Er sagt, wie groß die Summe der Zustandsänderungen ist, aber nicht, welche Prozessgröße in welche Zustandsänderung übergeht.

Er ist eine Bilanz. Wohin die Energie im Einzelnen geht, bestimmen das Modell und die Stoffwerte.
][
*Typische Verwechslung:*

- „Er sagt, dass Wärme immer vollständig in Arbeit umgewandelt werden kann.“: Das folgt aus der Bilanz nicht; dafür braucht man den zweiten Hauptsatz.
- „Er gilt nur für reversible Prozesse.“: Energieerhaltung gilt auch bei irreversiblen Prozessen.
]

#aufgabe(titel: "Fallende Bleikugel erwärmt sich", art: "rechnen", quelle: "3.1.4", herkunft: "variante", vorlage: "Vorlesungsbeispiel 3.1.4 (Bleikugel)", minuten: 6)[
#if not web [*Aufgabe 219* #linebreak()]
*Kugel, Variante:*

*Gegeben und Annahmen*

Eine Bleikugel mit $c_"Pb"=130 thin "J/(kg K)"$ fällt aus $z_1=50 thin "m"$ mit Anfangsgeschwindigkeit $c_1=10 thin "m/s"$. $g="9,81" thin "m/s"^2$. Für die maximale Erwärmung werden Lage- und Bewegungsenergie vollständig in innere Energie der Kugel umgewandelt; Endgeschwindigkeit und Endhöhe sind null.

*Gesucht*

#enum(numbering: "a)",
[Bestimme die höchstmögliche Temperaturerhöhung und prüfe die Energiebilanz.],
)
][
*Modell:* geschlossen, konstante Wärmekapazität; kein Rückprall und keine Energieabgabe an Boden und Umgebung. Die gesamte anfängliche äußere Energie erwärmt die Kugel.
][
*Vollständige Bilanz vereinfachen:* $Delta u+Delta(c^2/2)+g Delta z=q_12+w_12$. Mit $q_12=w_12=c_2=z_2=0$ folgt $c_"Pb" Delta T=c_1^2/2+g z_1$.
][
*Einsetzen:* $Delta T=(10^2/2+"9,81" dot 50)/130 thin "K"="540,5"/130 thin "K"$.
][
*Ergebnis: $Delta T approx "4,16" thin "K"$.*
][
*Prüfung:* J/kg geteilt durch J/(kg K) ergibt K; die Masse kürzt sich. Energieabgabe an die Umgebung senkt die mögliche Erwärmung. Innere Dissipation bei der Verformung ist nicht pauschal eine Energieabgabe.
]

#aufgabe(titel: "Entnahme aus einem Behälter: Q = ΔU reicht nicht", art: "verstehen", quelle: "3.2.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 220* #linebreak()]
Warum reicht beim Entnehmen aus einem Behälter Q = ΔU nicht?
][
*Antwort:*

- Während der Entnahme ist der Behälterinhalt ein offenes, instationäres System.
- Die austretende Masse nimmt ihre Enthalpie mit.
- *Richtig ist:* $Delta U = Q - m_"entn" h'$.
- Wer das vergisst, lässt den Energietransport mit der Masse weg.
]

#aufgabe(titel: "Druckflasche mit R12 nachfüllen", art: "rechnen", quelle: "3.2.1", herkunft: "original", vorlage: "Leistungsnachweis WS 11/12, Aufg. 1", minuten: 25,
  ergebnis: [$m_1 approx "0,0102" thin "kg"$; $m_2 approx "2,139" thin "kg"$, $Delta m_12 approx "2,129" thin "kg"$; $Delta H_(e,12) approx 811 thin "kJ"$; $Q_12 approx -345 thin "kJ"$],
  tipp: [Wie im Stickstoffbeispiel: Die einströmende Masse bringt ihre Enthalpie mit. In der Flasche selbst zählt die innere Energie.])[
#if not web [*Aufgabe 221* #linebreak()]
*Gegeben und Annahmen*

Eine Druckflasche (Volumen $V = 2 thin "l"$) wird mit Kältemittel R12 nachgefüllt. Die anfängliche Restmenge habe den Zustand ① ($t_1 = 20 thin "°C"$; $p_1 = "1,005" thin "bar"$). Das R12 in der Zuleitung habe den Zustand (e) ($t_e = 50 thin "°C"$; $p_e = "6,541" thin "bar"$). Das Ventil V1 wird geöffnet, darauf strömt R12 in die Flasche. Nach dem Schließen des Ventils V1 herrscht in der Flasche der Nassdampfzustand ② ($t_2 = 20 thin "°C"$), wobei flüssiges R12 80 % des Volumens einnimmt. In den Zuständen ① und ② ist das Ventil jeweils geschlossen. Äußere Energien werden vernachlässigt.

Dampftafel R12 (Auszug), Sättigung:
#tab(columns: (1fr, 1fr, 1.3fr, 1fr, 1fr, 1fr),
 th([$t$ in °C], [$p$ in bar], [$v'$ in m³/kg], [$v''$ in m³/kg], [$h'$ in kJ/kg], [$h''$ in kJ/kg]),
 [−29,944], [1,0050], [0,00067224], [0,160210], [172,71], [338,97],
 [20,000], [5,6642], [0,00075252], [0,031119], [219,14], [361,36],
 [50,000], [12,166], [0,00082438], [0,014333], [249,71], [372,24],
)
Überhitzter Zustand:
#tab(columns: (1fr, 1fr, 1fr, 1fr),
 th([$t$ in °C], [$p$ in bar], [$v$ in m³/kg], [$h$ in kJ/kg]),
 [20], [1,005], [0,19656], [368,26],
 [50], [5,6642], [0,035784], [381,66],
 [50], [6,541], [0,030476], [380,57],
)

*Gesucht*

#enum(numbering: "a)",
[Welche Masse $m_1$ an R12 enthält die Flasche vor der Neubefüllung?],
[Welche Masse $m_2$ befindet sich nach der Befüllung in der Flasche? Welche Masse $Delta m_12$ ist eingeströmt? Rechne ab jetzt weiter mit $Delta m_12 = "2,131" thin "kg"$.],
[Bestimme die vom eingeströmten R12 mitgeführte extensive Enthalpie $Delta H_(e,12)$. Rechne ab jetzt weiter mit $Delta H_(e,12) = "810,995" thin "kJ"$.],
[Um den Zustand ② zu erreichen, muss die Flasche beim Füllen gekühlt werden. Fertige für den 1. HS eine Skizze an mit den extensiven Energiemengen an den Systemgrenzen.],
[Welche Wärme $Q_12$ ist abzuführen?],
)
][
*Zustand ①:* Bei 1,005 bar siedet R12 schon bei −29,9 °C; mit 20 °C ist es überhitzt. Tabelle für den überhitzten Zustand:
$ m_1 = V/v_1 = "0,002"/"0,19656" thin "kg" approx "0,0102" thin "kg" $
][
*Zustand ②:* Nassdampf bei 20 °C; Flüssigkeit füllt $"1,6" thin "l"$, Dampf $"0,4" thin "l"$:
$ m' = ("1,6" times 10^(-3))/"0,00075252" approx "2,1262" thin "kg" quad m'' = ("0,4" times 10^(-3))/"0,031119" approx "0,0129" thin "kg" $
$ m_2 approx "2,1390" thin "kg" quad quad Delta m_12 = m_2 - m_1 approx "2,129" thin "kg" $
Die Aufgabe rechnet mit dem gerundeten Vorgabewert 2,131 kg weiter.
][
*Mitgeführte Enthalpie:* Der Zuleitungszustand (e) ist überhitzt (6,541 bar, 50 °C):
$ Delta H_(e,12) = Delta m_12 h_e = "2,131" dot "380,57" thin "kJ" approx "810,99" thin "kJ" $
][
*Skizze:* Systemgrenze um den Flascheninhalt. Über die Grenze treten: der einströmende Massenstrom mit $Delta H_(e,12)$ (hinein) und die Wärme $Q_12$ (hinaus, Kühlung). Keine Arbeit, da die Flasche starr ist. Im Inneren ändert sich $U_2 - U_1$.
][
*Erster Hauptsatz für das Füllen:* $U_2 - U_1 = Q_12 + Delta H_(e,12)$. Innere Energien mit $u = h - p v$:
$ U_1 = m_1 (h_1 - p_1 v_1) = "0,0102" dot ("368,26" - "19,75") thin "kJ" approx "3,55" thin "kJ" $
$ u' = "219,14" - 566 thin 420 dot "0,00075252"\/1000 approx "218,71" thin "kJ/kg" quad u'' approx "343,73" thin "kJ/kg" $
$ U_2 = m' u' + m'' u'' approx "465,03" + "4,42" approx "469,45" thin "kJ" $
$ Q_12 = U_2 - U_1 - Delta H_(e,12) approx "469,45" - "3,55" - "811,00" thin "kJ" approx -345 thin "kJ" $
Minus heißt Abfuhr: Die Flasche muss rund 345 kJ Wärme abgeben, sonst würde das einströmende warme R12 den Inhalt über 20 °C aufheizen.
]

#aufgabe(titel: "Druckflasche mit R12, 3 Liter und 70 Prozent Flüssigkeit (Variante)", art: "rechnen", quelle: "3.2.1", herkunft: "variante", vorlage: "Leistungsnachweis WS 11/12, Aufg. 1", minuten: 20,
  ergebnis: [$m_1 approx "0,0153" thin "kg"$; $m_2 approx "2,820" thin "kg"$; $Delta H_e approx 1067 thin "kJ"$; $Q_12 approx -452 thin "kJ"$])[
#if not web [*Aufgabe 222* #linebreak()]
*Gegeben und Annahmen*

Eine 3-l-Druckflasche enthält R12 bei 1,005 bar und 20 °C. Aus einer Zuleitung (6,541 bar, 50 °C) strömt R12 ein, bis in der geschlossenen Flasche Nassdampf von 20 °C herrscht und die Flüssigkeit 70 % des Volumens füllt. Die Flasche ist starr; äußere Energien werden vernachlässigt. Dampftafel R12: 20 °C Sättigung $p = "5,6642" thin "bar"$, $v' = "0,00075252"$, $v'' = "0,031119" thin "m"^3/"kg"$, $h' = "219,14"$, $h'' = "361,36" thin "kJ/kg"$; überhitzt bei 1,005 bar und 20 °C: $v = "0,19656" thin "m"^3/"kg"$, $h = "368,26" thin "kJ/kg"$; bei 6,541 bar und 50 °C: $h = "380,57" thin "kJ/kg"$.

*Gesucht*

#enum(numbering: "a)",
[Anfangs- und Endmasse sowie die eingeströmte Masse.],
[Die mit dem Zustrom eingebrachte Enthalpie.],
[Die abzuführende Wärme.],
)
][
*Massen:* $m_1 = "0,003"\/"0,19656" approx "0,0153" thin "kg"$; $m' = "0,0021"\/"0,00075252" approx "2,7906" thin "kg"$; $m'' = "0,0009"\/"0,031119" approx "0,0289" thin "kg"$; $m_2 approx "2,8195" thin "kg"$; $Delta m approx "2,8043" thin "kg"$.
][
*Enthalpie des Zustroms:* $Delta H_e = Delta m h_e approx "2,8043" dot "380,57" thin "kJ" approx 1067 thin "kJ"$.
][
*Wärme:* $U_1 approx "0,0153" dot "348,51" approx "5,32" thin "kJ"$; $U_2 = m' dot "218,71" + m'' dot "343,73" approx "620,29" thin "kJ"$.
$ Q_12 = U_2 - U_1 - Delta H_e approx "620,29" - "5,32" - "1067,23" thin "kJ" approx -452 thin "kJ" $
]

#aufgabe(titel: "Stickstoff: Heizerenergie und Zustandsgrößen", art: "rechnen", quelle: "3.2.1", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.1 e–g", minuten: 20)[
#if not web [*Aufgabe 223* #linebreak()]
*Stickstoffgefäß, Ü 2.1 e–g; W23 und M2:*

*Gegeben und Annahmen*

Starres Stickstoffgefäß. Zu Beginn (Zustand ②): $V="0,050" thin "m"^3$, $m_2="36,31895896" thin "kg"$, $p_2="1,4" thin "bar"$. Entnommen wird $m_"entn"=1 thin "kg"$ gesättigte Flüssigkeit bei konstantem $p_3=p_2$; die Sättigungstemperatur beträgt 80,21 K.
#tab(columns: (1fr, 1fr, 1fr),
 th([Größe bei 1,4 bar], [Flüssigkeit ′], [Sattdampf ″]),
 [v / m³/kg], [0,0012611], [0,16082],
 [h / kJ/kg], [−116,15], [79,245],
 [s / kJ/(kg K)], [2,9081], [5,3442],
)
Heizerspeicherung, Änderungen von Bewegungs-/Lageenergie und weitere Verluste werden vernachlässigt. Kein Zufluss, keine weitere Arbeitsübertragung. Alle Stoffwerte stammen aus derselben Originaltabelle von Ü 2.1.

*Gesucht*

#enum(numbering: "a)",
[Bestimme die während der Entnahme nachverdampfende Masse und die zugeführte Heizerenergie.],
[Stelle für Zustand ② die 13 Größen $p,T,x,mu,v,h,u,s,m,V,H,U,S$ für Gemisch, Flüssigkeit und Dampf zusammen: mit Einheit, Einordnung und Formelzusammenhang.],
[Berechne Zustand ③ sowie $Delta H_23$ und $Delta S_23$.],
[Prüfe und erkläre die Vorzeichen der Gesamtänderungen und den Zusammenhang mit spezifischen Größen und Energiezufuhr.],
)
][
*Modell:* starrer Gefäßinhalt, offen und instationär beim Entnehmen; $p_2=p_3="1,4"$ bar, $V="0,05"$ m³. Flüssigkeit tritt aus. Heizerspeicherung, äußere Energieänderungen und weitere Verluste werden wie in M2 vernachlässigt. Für Stoffwerte verwenden wir durchgehend die gedruckte Originaltabelle aus Ü 2.1.
][
*Verdampfte Masse und Energiezufuhr:*
Aus „Stickstoff: Restmasse und Nachverdampfen“: $Delta m'' approx "0,007903664"$ kg. Bei 1,4 bar ist $h''-h'="79,245"-(-"116,15")="195,395"$ kJ/kg.
$ Q_"zu,23"=Delta m''(h''-h') approx "0,007903664" dot "195,395" thin "kJ" $
*Ergebnis: $Q_"zu,23" approx "1,54434"$ kJ.* Bei der Grenze um Stickstoff und Heizer ist dies die zugeführte elektrische Arbeit. Ohne eine Entnahmedauer lässt sich keine feste Leistung angeben; bei konstanter Leistung wäre $P_"el"=Q_"zu,23"/Delta t$.
][
*Prüfung:* kg mal kJ/kg ergibt kJ. Die Energie gehört zur nachverdampfenden Masse von rund 7,904 g, nicht zur gesamten Entnahme von 1 kg.
][
*Zustand ② aufbauen:*
$m_2=m_1 approx "36,31895896"$ kg. Da bis zum Entnahmebeginn kein Stoff austritt, ist
$ v_2=V/m_2 approx "0,00137669144" thin "m"^3/"kg" $
$ x_2=frac(v_2-v', v''-v') approx "0,0007244437" quad mu_2=frac(x_2 v'', v_2) approx "0,0846268" $
Das sind *0,07244 Massen-% Dampf*, aber *8,4627 Volumen-% Dampf*. $h_2=h'+x_2(h''-h')$, $s_2=s'+x_2(s''-s')$, $u_2=h_2-p_2v_2$. Die extensiven Werte folgen anschließend durch Multiplikation mit den jeweiligen Massen.

Die Phasenspalten beschreiben jeweils den reinen gesättigten Teilzustand. Daher sind ihre eigenen Dampfanteile 0 beziehungsweise 1. Zahlen sind für die Darstellung gerundet; die Summenkontrollen verwenden ungerundete Zwischenwerte.
#tab(columns: (0.65fr, 0.85fr, 1.15fr, 1.15fr, 1.15fr),
 th([Größe], [Einheit], [Gesamtgemisch], [Flüssigkeit ′], [Dampf ″]),
 [$p$], [bar], [1,4], [1,4], [1,4],
 [$T$], [K], [80,21], [80,21], [80,21],
 [$x$], [1], [0,000724444], [0], [1],
 [$mu$], [1], [0,0846268], [0], [1],
 [$v$], [m³/kg], [0,00137669], [0,0012611], [0,16082],
 [$h$], [kJ/kg], [−116,00845], [−116,15], [79,245],
 [$u$], [kJ/kg], [−116,20118], [−116,326554], [56,7302],
 [$s$], [kJ/(kg K)], [2,9098648], [2,9081], [5,3442],
 [$m$], [kg], [36,318959], [36,292648], [0,0263110],
 [$V$], [m³], [0,0500000], [0,0457687], [0,00423134],
 [$H$], [kJ], [−4213,3060], [−4215,3911], [2,08502],
 [$U$], [kJ], [−4220,3060], [−4221,7987], [1,49263],
 [$S$], [kJ/K], [105,68326], [105,54265], [0,140611],
)
*Prüfung:* Die fünf extensiven Zeilen addieren sich aus den Phasenspalten. Für den gesamten Inhalt gilt $U_2=H_2-p_2V=-"4213,3060"-7=-"4220,3060"$ kJ, denn $p_2=140$ kPa. Negative Energiewerte sind mit dem vorgegebenen Bezugsnullpunkt vereinbar.
][
*Zustand ③ nach 1 kg Entnahme:*
$ m_3=m_2-1 thin "kg" approx "35,318959" thin "kg" $
$ v_3=V/m_3 approx "0,0014156703" thin "m"^3/"kg" quad x_3=frac(v_3-v',v''-v') approx "0,000968735" $
Mit derselben Sättigungszeile: $h_3 approx -"115,960714"$ kJ/kg und $s_3 approx "2,91045993"$ kJ/(kg K).
][
*Ergebnis:*
$ Delta H_23=m_3 h_3-m_2 h_2 approx +"117,6943" thin "kJ" $
$ Delta S_23=m_3 s_3-m_2 s_2 approx -"2,88885" thin "kJ/K" $
][
*Energiebilanz kontrollieren:* Bei konstantem $p,V$ ist $Delta U_23=Delta H_23$. Daher
$ Delta U_23+m_"entn" h'="117,69434"+1 dot (-"116,15") thin "kJ"="1,54434" thin "kJ"=Q_"zu,23" $
*Prüfung:* Die kleine Heizerenergie und die deutlich größere Änderung der gespeicherten Enthalpie widersprechen sich nicht: Zusätzlich verlässt Masse das System. $s_3>s_2$, gleichzeitig $S_3<S_2$, weil die verbleibende Masse kleiner ist.
]

#aufgabe(titel: "Entropie steigt: bezogen worauf?", art: "verstehen", quelle: "3.2.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 224* #linebreak()]
Warum muss man bei „die Entropie steigt“ immer die Bezugsgröße nennen?
][
*Antwort:*

- Die spezifische Entropie $s$ (pro kg) und die gesamte Entropie $S = m s$ können sich verschieden verhalten.
- Nach einer Entnahme kann $s$ des Restes steigen, während $S$ sinkt, weil weniger Masse da ist.
][
*Merksatz:* Je Kilogramm und insgesamt sind zwei verschiedene Fragen.
][
*Typische Verwechslung:*

- „Ja, $S$ und $s$ ändern sich immer in dieselbe Richtung.“: $S = m s$. Wenn die Masse sinkt, kann $S$ trotz größerem $s$ kleiner werden.
- „Nein, die Entropie sinkt bei einer Entnahme immer.“: Ob $S$ sinkt, hängt davon ab, wie stark $m$ sinkt und $s$ steigt.
]

#aufgabe(titel: "Adiabate Wasserturbine erwärmt das Wasser", art: "verstehen", quelle: "3.3.1", herkunft: "eigen", minuten: 3,
  tipp: [Trenne innere Energie im austretenden Stoff von Wärmeübertragung.])[
#if not web [*Aufgabe 225* #linebreak()]
Warum kann sich Wasser in einer adiabaten Turbine erwärmen?
][
*Antwort:*

- Adiabat bedeutet nur, dass keine Wärme über die Grenze übertragen wird.
- Wird nicht die gesamte Gefälleenergie als Wellenarbeit abgegeben, kann der Rest die innere Energie des Wassers erhöhen.
- Diese Energie verlässt die Turbine mit dem erwärmten Wasser
- sie ist kein Wärmeverlust nach außen.

#align(center)[#image("abbildungen/turbine-energie.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „Die Temperatur muss gleich bleiben, weil die Turbine adiabat ist.“: Keine Wärmeübertragung bedeutet nicht unveränderte innere Energie oder unveränderte Temperatur.
- „Der Rest ist zwangsläufig ein Wärmestrom an die Umgebung.“: Ein solcher Wärmestrom widerspräche der hier angenommenen adiabaten Grenze.
]

#aufgabe(titel: "Turbinenwirkungsgrad mit Betrag", art: "verstehen", quelle: "3.3.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 226* #linebreak()]
Warum verwendet der Turbinenwirkungsgrad den Betrag der Wellenleistung?
][
*Antwort:*

- In der Zufuhrkonvention ist die abgegebene Wellenleistung negativ.
- Der Wirkungsgrad vergleicht jedoch einen positiven Nutzen mit einem positiven Aufwand.
- Deshalb wird hier der Betrag der Wellenleistung durch die verfügbare Gefälleleistung geteilt.

#align(center)[#image("abbildungen/turbine-energie.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Altklausur WS 01/02: adiabater Wasserfall", art: "rechnen", quelle: "3.3.1", herkunft: "original", minuten: 6, vorlage: "Altklausur WS 01/02, Kurzfrage 8, PDF-S. 1")[
#if not web [*Aufgabe 227* #linebreak()]
*Gegeben:* 100 m hoher adiabater Wasserfall. $g$ und $c_p$ sind sinnvoll abzuschätzen. *Gesucht:* Temperaturerhöhung. Lege fest, an welchen Stellen die Strömungsgeschwindigkeiten verglichen werden.
][
*Annahmen ergänzen:* $g="9,81"$ m/s², $c_p=4180$ J/(kg K); gleicher Umgebungsdruck, keine Arbeitsabgabe und Vergleich vor dem Fall mit beruhigtem Wasser nach dem Aufprall. Dann ist die Gefälleenergie vollständig dissipiert.
][
*Energie umrechnen:* $c_p Delta T=g H$, daher $Delta T="9,81" dot 100/4180 approx "0,23469"$ K. Direkt im schnellen Fallstrahl steckt ein Teil der Energie noch als Bewegungsenergie; dort gilt dieser gesamte Temperaturanstieg noch nicht.
]

#aufgabe(titel: "Altklausur WS 01/02: adiabater Wasserfall (Variante)", art: "rechnen", quelle: "3.3.1", herkunft: "variante", minuten: 6, vorlage: "Altklausur WS 01/02, Kurzfrage 8, PDF-S. 1")[
#if not web [*Aufgabe 228* #linebreak()]
*Von KI erstellt.* *Gegeben:* 60 m Fallhöhe, $g="9,81"$ m/s², $c_p=4200$ J/(kg K), gleiche Annahmen wie im Original. *Gesucht:* Temperaturerhöhung nach vollständiger Beruhigung.
][
*Bilanz:* $Delta T="9,81" dot 60/4200 approx "0,14014"$ K. Die Masse kürzt sich heraus.
]

#aufgabe(titel: "Pumpspeicherturbine: Wirkungsgrad und Wassererwärmung", art: "rechnen", quelle: "3.3.1", herkunft: "original", vorlage: "Vorlesung 27.10., Beispiel S. 9", minuten: 12,
 ergebnis: [$eta approx "89,2" thin "%"$; $Delta T approx "0,0253" thin "K"$; $P_"Rest"=848 thin "kW"$.],
 tipp: [Bilanz zwischen den freien Wasserspiegeln: $c Delta T-g H=P_t/dot(m)$.])[
#if not web [*Aufgabe 229* #linebreak()]
*Gegeben und Annahmen:* Eine adiabate Turbine gibt 7000 kW Wellenleistung ab, also $P_t=-7000$ kW. Durchfluss $dot(V)=8$ m³/s, Höhendifferenz $H=z_1-z_2=100$ m; $rho=1000$ kg/m³, $c=4190$ J/(kg K), $g="9,81"$ m/s². Beide freien Wasserspiegel stehen unter demselben Umgebungsdruck; Geschwindigkeitsänderungen werden vernachlässigt. Wasser inkompressibel, Stoffwerte konstant; stationär, keine zusätzliche Energieabgabe nach außen.

*Gesucht:*
#enum(numbering: "a)")[Bestimme Massenstrom und Gefälleleistung.][Berechne den Wirkungsgrad und die nicht als Wellenarbeit genutzte Leistung.][Berechne den Temperaturanstieg des Wassers und erkläre ihn trotz adiabater Grenze.]
#src[N27, PDF-S. 9; Einheiten und vollständige Modellannahmen redaktionell ergänzt.]
][
*Bezugsgröße festlegen:* Der Wasserstrom trägt die Energie. $dot(m)=rho dot(V)=1000 dot 8=8000 thin "kg/s"$. Ein hoher Massenstrom macht auch einen kleinen Energieunterschied pro kg als Leistung sichtbar.
][
*Verfügbare Leistung bestimmen:* Pro kg stehen $g H="9,81" dot 100=981$ J/kg Lageenergie zur Verfügung. Somit $P_"Gefälle"=dot(m)g H=8000 dot 981=7848000$ W = 7848 kW.
][
*Nutzen ins Verhältnis setzen:* Nutzen ist der positive Betrag der Wellenleistung, nicht ihr negatives Bilanzvorzeichen. $eta=7000/7848 approx "0,891947"= "89,1947" thin "%"$. Die verbleibende Leistung beträgt $P_"Rest"=7848-7000=848$ kW.
][
*Energiebilanz aufstellen:* Zwischen den freien Wasserspiegeln ist $Delta p=0$, deshalb $Delta h approx c Delta T$. Adiabat gilt $c Delta T+g(z_2-z_1)=w_t$. Mit $w_t=P_t/dot(m)=-7000000/8000=-875$ J/kg wird daraus $c Delta T-981=-875$ J/kg.
][
*Temperatur berechnen:* $Delta T=(981-875)/4190=106/4190 approx "0,0252983"$ K. Die nicht abgegebene mechanische Energie bleibt als innere Energie im Wasser; sie ist kein Wärmestrom über die adiabate Grenze.
][
*Prüfen:* $8000 thin "kg/s" dot 4190 thin "J/(kg K)" dot "0,0252983" thin "K" approx 848000$ W. Zusammen mit 7 MW Wellenabgabe ergibt dies die 7,848 MW Gefälleleistung. Der Wirkungsgrad liegt zwischen null und eins, die Wassererwärmung ist positiv und klein.
]

#aufgabe(titel: "Pumpspeicherturbine mit 140 m Fallhöhe (Variante)", art: "rechnen", quelle: "3.3.1", herkunft: "variante", vorlage: "Vorlesung 27.10., Beispiel S. 9", minuten: 10,
  ergebnis: [$P_"Gefälle" approx "13,73" thin "MW"$; $eta approx "0,874"$; $Delta T approx "0,041" thin "K"$])[
#if not web [*Aufgabe 230* #linebreak()]
*Gegeben und Annahmen*

Eine adiabate Wasserturbine gibt 12 000 kW Wellenleistung ab ($P_t = -12 thin 000 thin "kW"$) bei $dot(V) = 10 thin "m"^3/"s"$ und einer Höhendifferenz der freien Wasserspiegel von 140 m. $rho = 1000 thin "kg/m"^3$, $c = 4190 thin "J/(kg K)"$, $g = "9,81" thin "m/s"^2$. Beide Spiegel stehen unter Umgebungsdruck; kinetische Energien vernachlässigt; der Rest der Gefälleleistung bleibt im Wasser.

*Gesucht*

#enum(numbering: "a)",
[Gefälleleistung und Wirkungsgrad.],
[Die Erwärmung des Wassers.],
)
][
*Gefälleleistung:* $P_"Gefälle" = rho dot(V) g H = 1000 dot 10 dot "9,81" dot 140 thin "W" approx "13,73" thin "MW"$; $eta = abs(P_t)\/P_"Gefälle" approx "0,874"$.
][
*Erwärmung:* Stationäre adiabate Bilanz: $0 = P_t + dot(m)[c Delta T - g H]$, also $Delta T = ("13 734" - "12 000")\/(10 thin 000 dot "4,19") thin "K" approx "0,041" thin "K"$. Messbar klein, aber genau dort steckt der Verlust.
]

#aufgabe(titel: "Kurzfrage: Wärmezufuhr eines Ottomotors", art: "verstehen", quelle: "3.3.2", herkunft: "original", vorlage: "Leistungsnachweis SS 14, Kurzfrage 10; ebenso WS 13/14, Kurzfrage 8", minuten: 3)[
#if not web [*Aufgabe 231* #linebreak()]
Ein Ottomotor mit Gesamtwirkungsgrad $eta_"ges" = "0,25"$ leistet $P = 100 thin "kW"$. Wie groß ist der erforderliche Wärmezufluss $dot(Q)$? Wie groß wäre er bei $eta_"ges" = "0,20"$?
][
*Wirkungsgrad:* Nutzen durch Aufwand, $eta = P\/dot(Q)$, also $dot(Q) = P\/eta$.
][
*Zahlen:* $dot(Q) = 100\/"0,25" thin "kW" = 400 thin "kW"$; bei $eta = "0,20"$ sind es $500 thin "kW"$. Drei Viertel beziehungsweise vier Fünftel der zugeführten Energie gehen als Abwärme weg.
]

#aufgabe(titel: "Dampfkessel und Turbine bilanzieren", art: "verstehen", quelle: "3.3.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 232* #linebreak()]
Wie unterscheiden sich die Energiebilanzen von Dampfkessel und adiabater Turbine?
][
*Antwort:*

- Im stationären Kessel ohne technische Arbeit erhöht die Wärmezufuhr die Enthalpie des Stroms.
- In der adiabaten Turbine führt die Enthalpieabnahme zur Wellenabgabe.
- Beide Vereinfachungen setzen hier vernachlässigte Änderungen von Bewegungs- und Lageenergie voraus.

#align(center)[#image("abbildungen/kraftwerk-enthalpie.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Wärmezufuhr im stationären Dampfkessel", art: "verstehen", quelle: "3.3.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 233* #linebreak()]
Im stationären Dampfkessel gibt es keine technische Arbeit; äußere Energieänderungen sind vernachlässigt. Wie berechnest du die spezifische Wärmezufuhr, und warum?
][
*Antwort:* Die spezifische Wärmezufuhr ist $q_12=h_2-h_1$.

Ohne technische Arbeit erhöht die Wärmezufuhr die Enthalpie des Stroms.
][
*Typische Verwechslung:*

- „Die spezifische Wärmezufuhr ist grundsätzlich $h_2$.“: Benötigt wird der Unterschied zwischen Ein- und Austritt, nicht der Endwert allein.
- „Die spezifische Wärmezufuhr ist $h_1-h_2$.“: Beim Heizen nimmt die Enthalpie zu; die Wärmezufuhr zählt positiv.
]

#aufgabe(titel: "Wirkungsgrad der offenen Dampfanlage deuten", art: "verstehen", quelle: "3.3.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 234* #linebreak()]
Wie wird beim Wirkungsgrad der offenen Dampfanlage die abgegebene Wellenleistung eingesetzt, welche Verluste erfasst die Rechnung nicht, und was sagt der Zahlenwert über einen vollständigen geschlossenen Dampfkreislauf aus?
][
*Antwort:*

- Die abgegebene Wellenleistung wird als positiver Nutzen eingesetzt. Das Bilanzvorzeichen der Abgabe ist negativ, der Nutzen im Wirkungsgrad wird als positiver Betrag verwendet.
- Nicht angegebene Pumpen- und Generatorverluste sind in dieser Rechnung nicht erfasst. Der Wert gehört zum ausdrücklich beschriebenen offenen Anlagenmodell.
][
*Typische Verwechslung:*

- „Derselbe Zahlenwert beweist die Effizienz eines vollständigen geschlossenen Dampfkreislaufs.“: Ein solcher Kreislauf mit seinen weiteren Komponenten wurde hier nicht bilanziert.
]

#aufgabe(titel: "Offene Dampfanlage: Kesselwärme und Turbinenleistung", art: "rechnen", quelle: "3.3.2", herkunft: "original", vorlage: "Vorlesung 27.10., Beispiel S. 11", minuten: 10,
 ergebnis: [$q_12=3022$ kJ/kg; $w_(t,23)=-800$ kJ/kg; $dot(Q)_12 approx "83,94"$ MW; $P_23 approx -"22,22"$ MW; $eta approx "26,47" thin "%"$.],
 tipp: [Kessel ①–② ohne Wellenarbeit und Turbine ②–③ ohne Wärme getrennt bilanzieren.])[
#if not web [*Aufgabe 235* #linebreak()]
*Gegeben und Annahmen:* Stationäre offene Dampfanlage mit Kessel ①–② und anschließender adiabater Turbine ②–③, $dot(m)=100$ t/h; $1$ t = $1000$ kg, $1$ h = $3600$ s. $h_1=128$, $h_2=3150$, $h_3=2350$ kJ/kg. Der Kessel überträgt keine technische Arbeit. Änderungen von Bewegungs- und Lageenergie sind vernachlässigt; weitere Anlagenverluste werden nicht angesetzt.
#align(center)[#image("abbildungen/kraftwerk-enthalpie.svg", width: 100%)]
*Gesucht:*
#enum(numbering: "a)")[Berechne die spezifische Kesselwärme und Turbinenarbeit.][Bestimme zugehörige Wärme- und Wellenleistung.][Berechne das Verhältnis abgegebener Wellenleistung zu zugeführter Kesselwärme und benenne seine Modellgrenze.]
#src[N27, PDF-S. 11; Fließschema eigene Darstellung, Annahmen ausdrücklich formuliert.]
][
*Massenstrom umrechnen:* $dot(m)=100 dot 1000/3600 approx "27,77778"$ kg/s. kJ/kg mal kg/s liefert kJ/s und damit kW.
][
*Kessel bilanzieren:* Ohne technische Arbeit und äußere Energieänderung wird die Wärmezufuhr zur Enthalpiezunahme. $q_12=h_2-h_1=3150-128=3022$ kJ/kg, positiv als Zufuhr.
][
*Turbine bilanzieren:* Adiabat wird die Enthalpieabnahme als Wellenarbeit abgegeben. $w_(t,23)=h_3-h_2=2350-3150=-800$ kJ/kg. Das Minus kennzeichnet Abgabe.
][
*Leistungen bilden:* $dot(Q)_12="27,77778" dot 3022 approx "83944,44"$ kW = 83,94444 MW; $P_23="27,77778" dot (-800) approx -"22222,22"$ kW = −22,22222 MW. Gerechnet wird mit ungerundetem Massenstrom.
][
*Anlagenverhältnis berechnen:* $eta=abs(P_23)/dot(Q)_12=800/3022 approx "0,264725"= "26,4725" thin "%"$. Der Massenstrom kürzt sich; entscheidend sind die spezifischen Energiedifferenzen.
][
*Prüfen und eingrenzen:* 800 kJ/kg Wellenabgabe sind weniger als 3022 kJ/kg Kesselzufuhr. Die Enthalpie am Austritt ist gegenüber dem Eintritt weiterhin um 2222 kJ/kg höher; die Gesamtbilanz stimmt mit $3022-800=2222$. Pumpen und Generator sind nicht bilanziert; ein geschlossener Dampfkreislauf wurde nicht berechnet.
]

#aufgabe(titel: "Offene Dampfanlage mit 150 t/h (Variante)", art: "rechnen", quelle: "3.3.2", herkunft: "variante", vorlage: "Vorlesung 27.10., Beispiel S. 11", minuten: 8,
  ergebnis: [$dot(Q)_12 = "131,25" thin "MW"$; $P_t = -"37,5" thin "MW"$; $eta approx "0,286"$])[
#if not web [*Aufgabe 236* #linebreak()]
*Gegeben und Annahmen*

Stationäre offene Dampfanlage mit Kessel ①–② und adiabater Turbine ②–③, $dot(m) = 150 thin "t/h"$. $h_1 = 150$, $h_2 = 3300$, $h_3 = 2400 thin "kJ/kg"$. Der Kessel überträgt keine technische Arbeit; äußere Energien vernachlässigt.

*Gesucht*

#enum(numbering: "a)",
[Den Kesselwärmestrom und die Turbinenleistung.],
[Das Verhältnis von abgegebener Wellenleistung zu Kesselwärme.],
)
][
*Kessel und Turbine:* $dot(m) = "41,67" thin "kg/s"$. Kessel: $dot(Q)_12 = dot(m)(h_2 - h_1) = "131,25" thin "MW"$. Turbine: $P_t = dot(m)(h_3 - h_2) = -"37,5" thin "MW"$ (Abgabe).
][
*Verhältnis:* $abs(P_t)\/dot(Q)_12 = 900\/3150 approx "0,286"$. Pumpe und Kondensator fehlen in dieser offenen Anlage; der Wert ist kein Wirkungsgrad eines geschlossenen Kreisprozesses.
]

#aufgabe(titel: "Spezifische Arbeit und Leistung", art: "verstehen", quelle: "3.4.1", herkunft: "eigen", minuten: 3,
  tipp: [kJ/kg muss zu kJ/s werden.])[
#if not web [*Aufgabe 237* #linebreak()]
Warum sind spezifische Arbeit und Leistung verschiedene Größen?
][
*Antwort:*

- Die spezifische Arbeit ist eine Energie pro Masse.
- Die Leistung ist dagegen Energie pro Zeit.
- Bei einem stationären Stoffstrom macht erst die Multiplikation mit dem Massenstrom aus der spezifischen technischen Arbeit eine Leistung: $P=dot(m) w_t$.
]

#aufgabe(titel: "Zwei Verdichtungswege, verschiedene Arbeit", art: "verstehen", quelle: "3.4.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 238* #linebreak()]
Warum können zwei Verdichtungen mit denselben Endzuständen unterschiedliche Arbeit benötigen?
][
*Antwort:*

- Die Volumenarbeit hängt vom Druck während der Volumenänderung ab.
- Verschiedene Wege besitzen verschiedene Flächen im Druck-Volumen-Diagramm, auch wenn Anfang und Ende gleich sind.
- Die Änderung der inneren Energie ist dabei gleich
- unterschiedliche Arbeitsbeträge werden in der Energiebilanz durch unterschiedliche Wärmemengen ausgeglichen.

#align(center)[#image("abbildungen/arbeit-zwei-wege.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „Auf beiden Wegen muss die Volumenarbeit gleich sein.“: Arbeit ist eine Prozessgröße und hängt von der Fläche unter dem jeweiligen Druck-Volumen-Weg ab.
- „Auf beiden Wegen muss $Q=0$ sein.“: Bei $Delta U=0$ folgt $Q=-W_v$. Gleiche Endtemperatur bedeutet nicht fehlenden Wärmeaustausch.
]

#aufgabe(titel: "Verdichtung auf zwei Wegen: gleicher Endzustand, andere Arbeit", art: "rechnen", quelle: "3.4.2", herkunft: "original", vorlage: "Vorlesung 27.10., Beispiel S. 14–16", minuten: 15,
 ergebnis: [$W_"I"/(p_1 V_1)=ln(10) approx "2,302585"$; $W_"II"/(p_1 V_1)="0,9"$; $W_"I"/W_"II" approx "2,5584"$. Beide Wege: $Q=-W_v$.],
 tipp: [Rechne normiert auf $p_1 V_1$. Dann werden keine zusätzlichen Druck- oder Volumenwerte benötigt.])[
#if not web [*Aufgabe 239* #linebreak()]
*Gegeben und Annahmen:* Geschlossene Portion eines idealen Gases, quasistatisch und ohne Dissipation, ruhend bei gleicher Höhe. Verdichtungsverhältnis $epsilon=V_1/V_2=10$, Endtemperatur gleich Anfangstemperatur. Weg I: isotherm ①–②. Weg II: zunächst isobar bei $p_1$ von $V_1$ auf $V_2$, danach isochor bis zum selben Zustand ②. $p_1 V_1$ dient als positive Energie-Bezugsgröße; Zahlenwerte für $p_1$ und $V_1$ sind nicht nötig.
#align(center)[#image("abbildungen/arbeit-zwei-wege.svg", width: 100%)]
*Gesucht:*
#enum(numbering: "a)")[Berechne beide Arbeiten jeweils geteilt durch $p_1 V_1$.][Bestimme das Verhältnis der Arbeiten.][Begründe die Änderung der inneren Energie und die Netto-Wärme jedes Wegs.]
#src[N27, PDF-S. 14–16; normierte Aufgabenfassung zur dortigen Angabe $epsilon=10$.]
][
*Isothermen Weg integrieren:* $p(V)=p_1 V_1/V$. Deshalb $W_"I"=-integral_(V_1)^(V_2) p_1 V_1/V dif V=p_1 V_1 ln(V_1/V_2)$. Normiert folgt $W_"I"/(p_1 V_1)=ln(10) approx "2,302585"$.
][
*Zweiten Weg zerlegen:* Isobar ist $W=-p_1(V_2-V_1)$. Das isochore Teilstück hat $dif V=0$ und trägt keine Volumenarbeit bei. Damit $W_"II"/(p_1 V_1)=1-V_2/V_1=1-1/10="0,9"$.
][
*Arbeitsaufwand vergleichen:* $W_"I"/W_"II"=ln(10)/"0,9" approx "2,55843"$. Beim zweiten Weg wird nur auf niedrigem Druckniveau verdichtet; die anschließende Drucksteigerung geschieht ohne Volumenänderung.
][
*Wärme aus der Bilanz bestimmen:* Beim idealen Gas hängt $U$ nur von $T$ ab. Gleiche Anfangs- und Endtemperatur ergibt auf beiden Wegen $Delta U=0$. Also gilt $0=Q+W_v$, folglich $Q_"I"=-W_"I"$ und $Q_"II"=-W_"II"$. Beide Nettowärmemengen sind negativ.
][
*Prüfen:* $p_1 V_1$ hat die Einheit Pa·m³ = J; die normierten Arbeiten und ihr Verhältnis sind einheitenlos. Kompressionsarbeiten sind positiv. Gleiche Änderung einer Zustandsgröße bedeutet nicht gleiche Prozessgrößen; die unterschiedlichen Arbeiten werden durch unterschiedliche Wärmemengen ausgeglichen.
]

#aufgabe(titel: "Expansion: Gesamtarbeit und nutzbare Arbeit unterscheiden", art: "verstehen", quelle: "3.4.3", herkunft: "eigen", minuten: 3,
 tipp: [Welche Fläche liegt im p-V-Diagramm unter dem Umgebungsdruck?])[
#if not web [*Aufgabe 240* #linebreak()]
Ein Gas expandiert quasistatisch von $V_1$ nach $V_2>V_1$ gegen einen konstanten Umgebungsdruck $p_"∞"$. Erkläre mit der Zufuhrkonvention, warum die nutzbare Arbeitsabgabe kleiner ist als die gesamte Volumenarbeitsabgabe und wie sich beide rechnerisch unterscheiden.
#src[N27, PDF-S. 17; eigene Verständnisfrage.]
][
*Gesamte Grenzarbeit erfassen:* $W_v=-integral_(V_1)^(V_2)p dif V$ verwendet den absoluten Systemdruck und ist bei Expansion negativ. Sie enthält auch das Verdrängen der Umgebung.
][
*Umgebungsanteil abziehen:* Als positiver Verdrängungsaufwand gilt $W_"∞"=p_"∞"(V_2-V_1)$. Die vorzeichenbehaftete Nutzarbeit ist $W_(v,n)=W_v+W_"∞"=-integral(p-p_"∞")dif V$. Bei Expansion mit $p>p_"∞"$ ist sie ebenfalls negativ, aber dem Betrag nach kleiner.
][
*Grenzfall prüfen:* Bei einer Expansion genau auf Umgebungsdruckniveau verschwindet der zusätzliche Nutzanteil. Arbeit gegen die Umgebung findet trotzdem statt. Das erklärt, weshalb Gesamtarbeit und Nutzarbeit verschiedene Größen sind.
][
*Ausführlich:*

- Ein Teil der Volumenarbeit verdrängt die Umgebung gegen ihren Druck.
- Nur der darüber hinausgehende Anteil kann zusätzlich genutzt werden.
- Bei konstantem Umgebungsdruck gilt in der Zufuhrkonvention $W_(v,n)=W_v+p_"∞"(V_2-V_1)$
- bei Expansion sind beide Abgaben negativ, der Nutzbetrag ist kleiner.

#align(center)[#image("abbildungen/arbeit-nutzanteil.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „$W_(v,n)=W_v-p_"∞"(V_2-V_1)$“: Das würde den Betrag der Abgabe vergrößern, obwohl ein Anteil zum Verdrängen der Umgebung benötigt wird.
- „$W_(v,n)=W_v$ unabhängig vom Umgebungsdruck.“: Der Umgebungsanteil wird damit übersehen; gleich sind die Größen nur in passenden Grenzfällen.
]

#aufgabe(titel: "Wann die technische Arbeit gleich ∫v dp ist", art: "verstehen", quelle: "3.5", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 241* #linebreak()]
Wann ist die technische Arbeit gleich dem Integral von v über den Druck?
][
*Antwort:*

- Wenn Dissipation und Änderungen von Bewegungs- und Lageenergie vernachlässigt werden dürfen.
- Allgemein enthält die technische Arbeit zusätzlich diese Beiträge.
- Das Druckintegral allein ist daher eine begründete Vereinfachung und keine allgemeine Definition aller technischen Arbeit.

#align(center)[#image("abbildungen/map-arbeit.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „Das Maschinengehäuse hat ein unverändertes Volumen; weitere Annahmen sind unnötig.“: Die Gehäusegröße allein streicht weder Dissipation noch äußere Energieänderungen des Stoffstroms.
]

#aufgabe(titel: "Druckarbeit und Volumenarbeit verknüpfen", art: "verstehen", quelle: "3.5.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 242* #linebreak()]
Wie hängen Druckarbeit und Volumenarbeit desselben Zustandswegs zusammen?
][
*Antwort:*

- Es gilt $w_p=w_v+p_2 v_2-p_1 v_1$.
- Der Unterschied entsteht durch die Verschiebearbeiten an Ein- und Austritt.
- Verglichen werden derselbe Zustandsweg und dieselbe Massenbasis
- reale offene und geschlossene Maschinen müssen nicht automatisch denselben Weg durchlaufen.

#align(center)[#image("abbildungen/arbeit-verschiebung.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Isotherm: Druckarbeit gleich Volumenarbeit", art: "verstehen", quelle: "3.5.1", herkunft: "eigen", minuten: 3,
  tipp: [Nutze die Produktänderung von Druck und spezifischem Volumen.])[
#if not web [*Aufgabe 243* #linebreak()]
Erkläre, warum Druckarbeit und Volumenarbeit bei einem isothermen Weg eines idealen Gases gleich sein können.
][
*Antwort:* Für dieselbe Gasportion und denselben Weg gilt $w_p=w_v+Delta(p v)$. Beim idealen Gas ist $p v=R T$; isotherm bleibt dieses Produkt konstant. Deshalb verschwindet der Zusatzterm. Ohne diese Voraussetzung sind beide Arbeiten nicht grundsätzlich gleich.
]

#aufgabe(titel: "Flüssigkeitspumpe: Arbeit trotz nahezu konstantem Volumen", art: "verstehen", quelle: "3.5.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 244* #linebreak()]
Eine ideale, stationär betriebene Pumpe erhöht den Druck einer näherungsweise inkompressiblen Flüssigkeit. Dissipation sowie Änderungen von Bewegungs- und Lageenergie werden vernachlässigt. Warum benötigt sie Arbeit, obwohl sich das spezifische Volumen kaum ändert? Vergleiche Druck- und Volumenarbeit desselben Zustandswegs.
#src[N27, PDF-S. 18–19; eigene Verständnisfrage.]
][
*Passende Arbeitsform wählen:* Der Stoff durchströmt ein offenes System. Ohne Dissipation und äußere Energieänderungen gilt $w_t=w_p=integral v dif p$. Bei konstantem $v$ wird daraus $w_p=v(p_2-p_1)>0$.
][
*Verschiebearbeit mitnehmen:* Für denselben Weg ist $w_v=-integral p dif v approx 0$, aber $w_p=w_v+Delta(p v) approx v Delta p$. Gerade der Unterschied der Verschiebearbeiten an Ein- und Austritt bleibt erhalten.
][
*Plausibilität prüfen:* Der höhere Austrittsdruck erfordert zugeführte Wellenarbeit. Die starre Gehäusegröße ist dafür kein Gegenargument. Die Aussage $dif v approx 0$ darf nur das Volumenintegral vereinfachen, nicht das Druckintegral streichen.
][
*Ausführlich:*

- Die Pumpe erhöht den Druck des hindurchströmenden Stoffes.
- Bei annähernd konstantem spezifischem Volumen bleibt $w_p=v(p_2-p_1)$ positiv, obwohl die Volumenarbeit entlang dieses Wegs annähernd null ist.
- Den Unterschied erklärt die Änderung von $p v$.

#align(center)[#image("abbildungen/arbeit-verschiebung.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „$w_p approx 0$, weil $dif v approx 0$ ist.“: Verwechselt werden Druckarbeit mit Integral über dp und Volumenarbeit mit Integral über dv.
- „Druckarbeit und Volumenarbeit müssen auf jedem Weg denselben Wert haben.“: Der Unterschied ist $Delta(p v)$; er verschwindet nicht allgemein.
]

#aufgabe(titel: "Wärme und Enthalpie: Übertragung ist kein Speicher", art: "verstehen", quelle: "3.6", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 245* #linebreak()]
Jemand sagt: „Ein warmer Stoff enthält Wärme, und bei jedem Heizvorgang ist die zugeführte Wärme gleich seiner Enthalpie.“ Erkläre die beiden Begriffsfehler und nenne die Bedingungen, unter denen $Q=Delta H$ gelten kann.
#src[N27, PDF-S. 20; eigene Verständnisfrage, Bilanzverknüpfung mit 3.3.2.]
][
*Übertragung und Zustand trennen:* Wärme $Q$ ist Energieübertragung infolge eines Temperaturunterschieds. Der Stoff besitzt innere Energie $U$ und Enthalpie $H=U+p V$ als Zustandsgrößen. Eine übertragene Wärmemenge ist kein im Stoff vorhandener Wärmebestand.
][
*Änderung statt Bestand vergleichen:* Auch wenn Wärme die Enthalpie verändert, ist $Q$ nicht einfach der gesamte Endwert $H_2$. Bei einer passenden Bilanz kann $Q=H_2-H_1$ gelten, also die Änderung und nicht der Bestand.
][
*Bedingungen benennen:* Für ein geschlossenes, ruhendes System bei konstantem Druck, alleiniger quasistatischer Volumenarbeit und unveränderter Höhe folgt $Q=Delta U+p Delta V=Delta H$. Für einen stationären Kessel ohne technische Arbeit und ohne Änderungen äußerer Energie gilt entsprechend $dot(Q)=dot(m) Delta h$. Weitere Arbeits- oder Energiebeiträge würden diese Vereinfachung ändern.
][
*Ausführlich:*

- Wärme beschreibt Energieübertragung wegen eines Temperaturunterschieds.
- Der Stoff speichert innere Energie und besitzt Enthalpie als Zustandsgröße.
- Eine zugeführte Wärmemenge kann diese Zustandsgrößen verändern, ist aber kein eigener gespeicherter Wärmebestand.

#align(center)[#image("abbildungen/map-waerme-enthalpie.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Ein Stoff speichert innere Energie; Wärme beschreibt die Übertragung.
][
*Typische Verwechslung:*

- „Ein warmer Stoff besitzt einen Bestand an Wärme, der gleich seiner Enthalpie ist.“: Gespeichert wird Zustandsenergie. Wärme ist kein eigener Bestand, und die Enthalpie ist nicht allgemein eine übertragene Wärmemenge.
- „Jede Wärmezufuhr ist gleich dem Endwert der Enthalpie.“: Selbst wenn eine passende Bilanz Wärme und Enthalpie verknüpft, betrifft sie eine Änderung und benötigt Voraussetzungen.
]

#aufgabe(titel: "Kurzfrage: Innere Energie und Enthalpie beim realen und idealen Gas", art: "verstehen", quelle: "3.6.1", herkunft: "original", vorlage: "Leistungsnachweis WS 13/14, Kurzfrage 9", minuten: 3)[
#if not web [*Aufgabe 246* #linebreak()]
Worin liegt der Unterschied für innere Energie $U$ und Enthalpie $H$ zwischen realem und idealem Gas?
][
*Antwort:* Beim realen Gas hängen sie von zwei Zustandsgrößen ab, z. B. $U = U(T, V)$ und $H = H(T, p)$. Beim idealen Gas hängen sie nur von der Temperatur ab: $Delta U = m c_v Delta T$, $Delta H = m c_p Delta T$ (bei konstanten Wärmekapazitäten).
][
*Warum:* Im idealen Gas gibt es keine Anziehungskräfte zwischen den Molekülen. Ihr Abstand, also das Volumen, speichert deshalb keine Energie.
]

#aufgabe(titel: "Altklausur WS 03/04: Kurzfrage 10", art: "verstehen", quelle: "3.6.1", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 03/04, Kurzfrage 10 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 247* #linebreak()]
Worin besteht bei spezifischer innerer Energie und spezifischer Enthalpie der Hauptunterschied zwischen realem Stoffverhalten und idealem Gas?
][
*Antwort:* Beim idealen Gas hängen u und h nur von T ab; $dif u=c_v(T)dif T$, $dif h=c_p(T)dif T$. Reale Stoffe brauchen allgemein eine zweite unabhängige Zustandsgröße, etwa $u(T,v)$ oder $h(T,p)$. Unabhängig vom Stoffmodell gilt $h=u+p v$.
]

#aufgabe(titel: "Altklausur WS 01/02: Kurzfrage 6", art: "verstehen", quelle: "3.6.1", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 01/02, Kurzfrage 6 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 248* #linebreak()]
Worin liegt bei innerer Energie und Enthalpie der Unterschied zwischen realem und idealem Gas?
][
*Antwort:* Beim idealen Gas hängen u und h nur von T ab; $dif u=c_v(T)dif T$, $dif h=c_p(T)dif T$. Reale Stoffe brauchen allgemein eine zweite unabhängige Zustandsgröße, etwa $u(T,v)$ oder $h(T,p)$. Unabhängig vom Stoffmodell gilt $h=u+p v$.
]

#aufgabe(titel: "Altklausur Übungsklausur WS 99/00: Kurzfrage 2", art: "verstehen", quelle: "3.6.1", herkunft: "original", minuten: 3, vorlage: "Altklausur Übungsklausur WS 99/00, Kurzfrage 2 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 249* #linebreak()]
Von welcher Größe hängt die spezifische innere Energie eines idealen Gases ab? Begründe, warum Volumen und Masse keine zusätzlichen unabhängigen Einflussgrößen sind.
][
*Antwort:* Beim idealen Gas hängen u und h nur von T ab; $dif u=c_v(T)dif T$, $dif h=c_p(T)dif T$. Reale Stoffe brauchen allgemein eine zweite unabhängige Zustandsgröße, etwa $u(T,v)$ oder $h(T,p)$. Unabhängig vom Stoffmodell gilt $h=u+p v$.
]

#aufgabe(titel: "Reale Fluide: nicht nur die Temperatur", art: "verstehen", quelle: "3.6.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 250* #linebreak()]
Warum darf man bei realen Fluiden Energieunterschiede nicht grundsätzlich nur aus der Temperatur berechnen?
][
*Antwort:*

- Beim idealen Gas hängen innere Energie und Enthalpie nur von der Temperatur ab.
- Reale Fluide benötigen im Allgemeinen weitere Zustandsangaben und passende Tabellen.
- Auch konstante Wärmekapazitäten sind eine Modellannahme für den betrachteten Bereich.

#align(center)[#image("abbildungen/map-waerme-enthalpie.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „Jedes reale Fluid unabhängig von Druck und Phase“: Reale Fluide benötigen im Allgemeinen weitere Zustandsangaben und passende Tabellen.
- „Jeden Stoff allein deshalb, weil die Systemwand starr ist“: Die Wandbedingung ersetzt kein kalorisches Stoffmodell.
]

#aufgabe(titel: "Wann Δh gleich Δu ist", art: "verstehen", quelle: "3.6.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 251* #linebreak()]
Wann sind die Änderungen der spezifischen Enthalpie und der inneren Energie gleich?
][
*Antwort:*

- Wenn sich das Produkt aus Druck und spezifischem Volumen nicht ändert.
- Allgemein gilt $Delta u=Delta h-Delta(p v)$.
- Bei veränderlicher Masse muss man davon die Aussage über Gesamtgrößen unterscheiden: Konstantes gesamtes $p V$ bedeutet $Delta U=Delta H$.
]

#aufgabe(titel: "Druckluftmotor: Adiabate und Isotherme mit Gaswechsel", art: "rechnen", quelle: "3.7", herkunft: "original", vorlage: "Vorlesung 27.10., Beispiel S. 21", minuten: 25,
 ergebnis: [Je Arbeitsspiel: adiabat $W_v approx -"249,24"$ J, $W_"Verschiebung" approx -"99,70"$ J, $W_p approx -"348,94"$ J, $Q=0$; isotherm $W_v=W_p approx -"534,94"$ J, $W_"Verschiebung"=0$, $Q approx +"534,94"$ J. Bei einem Arbeitsspiel/Umdrehung: $P_"ad" approx -"3,489"$ kW, $P_"isoth" approx -"5,349"$ kW.],
 tipp: [Zuerst Absolutdruck und Kelvin bilden. Expansionsarbeit allein ist noch nicht die gesamte Gaswechselarbeit.])[
#if not web [*Aufgabe 252* #linebreak()]
*Gegeben und Annahmen:* Druckluftmotor ohne Totvolumen, vollständiger Gasaustausch und keine Dissipation. $p_(1,"ü")="22,3"$ bar, $p_2=p_"∞"="0,91"$ bar, $vartheta_1="24,8"$ °C, $V_1="71,16"$ cm³; Drehzahl $N=600$ U/min. $1$ bar = $10^5$ Pa, $1$ cm³ = $10^(-6)$ m³. Vergleiche reversible adiabate und isotherme Expansion einer gleich großen Anfangsportion bis zum selben Enddruck. Füllung bei $p_1$, Ausschiebung bei $p_2$, jeweils konstant; äußere Energien vernachlässigt.

*Stoffmodell aus dem Tafelanschrieb N28:* ideales Gas mit konstanten Werten $R="287,2"$ J/(kg K), $kappa="1,4"$. Konsistent daraus $c_v=R/(kappa-1)=718$ J/(kg K), $c_p=kappa c_v="1005,2"$ J/(kg K). Für die Leistungsrechnung wie im Tafelanschrieb *ein Arbeitsspiel je Umdrehung* verwenden; N28, PDF-S. 7, setzt entsprechend $dot(m)=m N/60$ an.
#align(center)[#image("abbildungen/druckluftmotor-pv.svg", width: 100%)]
*Gesucht:*
#enum(numbering: "a)")[Bestimme Absolutdruck, Anfangstemperatur und Masse je Arbeitsspiel.][Berechne für beide Modelle Endvolumen und Endtemperatur.][Bestimme Expansions-Volumenarbeit, Netto-Verschiebearbeit, Druckarbeit und Wärmezufuhr je Arbeitsspiel.][Berechne die mittlere Leistung unter der genannten Arbeitsspielannahme und erkläre den Unterschied.]
#src[N27, PDF-S. 21; Luftwerte R und κ: BT A.4, S. 482 / PDF-S. 497, als konstantes Modell. N28, PDF-S. 4–7, bestätigt Stoffwerte und Arbeitsspielansatz. Eigene vollständige Nachrechnung.]
][
*Zustandsdaten absolut einsetzen:* $p_1="22,3"+"0,91"="23,21"$ bar = $2321000$ Pa; $p_2=91000$ Pa; $T_1="24,8"+"273,15"="297,95"$ K; $V_1="71,16" dot 10^(-6)$ m³. Überdruck wäre für Gasgleichung und Druckverhältnis falsch.
][
*Masse bestimmen:* $m=p_1 V_1/(R T_1)="165,16236"/("287,2" dot "297,95") approx "0,001930115"$ kg. Das sind etwa 1,930 g pro Füllung, nicht ein Massenstrom. $p_1 V_1="165,16236"$ J ist die Energie-Bezugsgröße.
][
*Reversible Adiabate beschreiben:* $Q=0$, $p_1 V_1^kappa=p_2 V_2^kappa$. Deshalb $V_2=V_1(p_1/p_2)^(1/kappa) approx "719,4065"$ cm³. Außerdem $T_2=T_1(p_2/p_1)^((kappa-1)/kappa) approx "118,0995"$ K. Die starke Abkühlung folgt aus dem hier idealisierten konstanten Stoffmodell; sie ist kein gemessener Motorwert.
][
*Adiabate Arbeitsanteile trennen:* $W_(v,"ad")=(p_2 V_2-p_1 V_1)/(kappa-1) approx -"249,2409"$ J. Die Füllung liefert $-p_1 V_1=-"165,1624"$ J, die Ausschiebung erfordert $+p_2 V_2 approx +"65,4660"$ J. Damit $W_("Verschiebung,ad") approx -"99,6964"$ J.
][
*Adiabate Gesamtarbeit bilden:* $W_(p,"ad")=W_(v,"ad")+W_("Verschiebung,ad") approx -"348,9373"$ J. Kontrolle über die offene Beschreibung: $m c_p(T_2-T_1) approx -"348,9373"$ J. Die Enthalpiedifferenz erfasst die Verschiebearbeit bereits; diese darf nicht ein zweites Mal dazuaddiert werden.
][
*Isothermen Endzustand bestimmen:* $T_(2*)=T_1="297,95"$ K und $V_(2*)=p_1 V_1/p_2 approx "1814,9710"$ cm³. Die isotherme Expansion endet wegen der Wärmezufuhr bei deutlich größerem Volumen als die Adiabate.
][
*Isotherme Arbeit und Wärme berechnen:* $W_(v,"isoth")=-p_1 V_1 ln(p_1/p_2) approx -"534,9434"$ J. Weil $p_2 V_(2*)=p_1 V_1$, ist die Netto-Verschiebearbeit null; $W_(p,"isoth")=W_(v,"isoth")$. Mit $Delta U=0$ folgt $Q_"isoth"=-W_(v,"isoth") approx +"534,9434"$ J. Der höhere Arbeitsbetrag benötigt also Wärmezufuhr.
][
*Arbeitsspiele in Leistung umrechnen:* Unter der ausdrücklich ergänzten Annahme gilt $f=600/60=10$ s⁻¹. $P_"ad"=f W_(p,"ad") approx -"3489,373"$ W = −3,489373 kW; $P_"isoth" approx -"5349,434"$ W = −5,349434 kW. Bei $a$ Arbeitsspielen pro Umdrehung wären beide Leistungen mit $a$ zu multiplizieren.
][
*Einheiten, Vorzeichen und Grenzen prüfen:* Pa·m³ ergibt J, Arbeit mal s⁻¹ ergibt W. Abgegebene Arbeiten und Leistungen sind negativ, isotherme Wärme ist positiv, adiabate Wärme null. Die Expansionsarbeit erfüllt $Delta U=Q+W_v$; die Gaswechselarbeit erfüllt $Delta H=Q+W_p$. Isotherm ist $Delta U=Delta H=0$, adiabat sind beide negativ. Ein Totvolumen, reale Reibung oder veränderliche Stoffwerte würden das Modell verändern.
]

#aufgabe(titel: "Isotherme gegen Adiabate im Druckluftmotor", art: "verstehen", quelle: "3.7.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 253* #linebreak()]
Warum gibt die isotherme Expansion im Druckluftmotor mehr Arbeit ab als die reversible Adiabate?
][
*Antwort:*

- Bei der isothermen Expansion wird Wärme zugeführt, damit die Temperatur trotz Arbeitsabgabe gleich bleibt.
- Die Adiabate erhält keine Wärme
- ihre Arbeit verringert die innere Energie und die Temperatur sinkt.
- Das größere isotherme Arbeitsvermögen benötigt deshalb zusätzliche Energiezufuhr.

#align(center)[#image("abbildungen/druckluftmotor-vergleich.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „Das Wort isotherm bedeutet, dass keinerlei Energie übertragen wird.“: Isotherm beschreibt die Temperatur, nicht die Abwesenheit von Energieübertragung.
- „Die zusätzliche Arbeit entsteht ohne weiteren Energieaufwand.“: Die notwendige Wärmezufuhr würde damit in der Energiebilanz fehlen.
]

#aufgabe(titel: "Gaswechselarbeit des Druckluftmotors", art: "verstehen", quelle: "3.7.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 254* #linebreak()]
Warum reicht beim Druckluftmotor die Expansionsarbeit allein nicht für die Arbeit des ganzen Gaswechsels?
][
*Antwort:*

- Die Füllung bei hohem Druck und die Ausschiebung bei niedrigem Druck übertragen ebenfalls Arbeit.
- Ohne Totvolumen ergibt ihre Summe mit der Expansionsarbeit die Druckarbeit des Zyklus: $W_"Zyklus"=W_v-p_1 V_1+p_2 V_2$.
- Diese Verschiebearbeit ist in einer Enthalpiebilanz bereits enthalten.

#align(center)[#image("abbildungen/druckluftmotor-vergleich.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „Die Enthalpiebilanz erfordert zusätzlich eine zweite Addition derselben Verschiebearbeit.“: Die Enthalpie enthält den pv-Anteil bereits. Eine erneute Addition würde ihn doppelt zählen.
]

#aufgabe(titel: "Drehzahl und Arbeitsspiele", art: "verstehen", quelle: "3.7.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 255* #linebreak()]
Warum genügt die Drehzahl eines Motors allein nicht, um aus der Arbeit je Zyklus die Leistung zu berechnen?
][
*Antwort:*

- Man braucht die Zahl der Arbeitsspiele pro Zeit.
- Die Drehzahl liefert zunächst nur Umdrehungen pro Zeit
- zusätzlich muss bekannt sein, wie viele Arbeitsspiele zu einer Umdrehung gehören.
- Erst dann gilt $P=f W_"Zyklus"$ mit der richtigen Zyklusfrequenz.
]

#aufgabe(titel: "Überdruck und Celsius umrechnen", art: "verstehen", quelle: "3.7.2", herkunft: "eigen", minuten: 3,
  tipp: [Ein Druckverhältnis aus Überdrücken ist nicht das Verhältnis der absoluten Zustandsdrücke.])[
#if not web [*Aufgabe 256* #linebreak()]
Warum müssen beim Druckluftmotor Überdruck und Celsius vor dem Einsetzen in die Gasgleichung umgerechnet werden?
][
*Antwort:* Die Gasgleichung und die verwendeten Zustandsverhältnisse benötigen absolute Drücke und Kelvin. Zum Überdruck wird der Umgebungsdruck addiert; zur Celsius-Temperatur werden 273,15 addiert. Im Vorlesungsbeispiel sind das 23,21 bar absolut und 297,95 Kelvin.
]

#aufgabe(titel: "Altklausur WS 05/06: Kurzfrage 4", art: "verstehen", quelle: "3.8.1", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 05/06, Kurzfrage 4 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 257* #linebreak()]
a) Warum ist die spezifische Wärmekapazität bei konstantem Druck größer als bei konstantem Volumen? b) Gib für ideales Gas den Zusammenhang zwischen den beiden als Formel an.
][
*Antwort:* Bei isobarer Erwärmung expandiert das Gas und verrichtet zusätzlich Volumenarbeit. Bei isochorer Erwärmung entfällt diese. Für ideales Gas gilt $c_p-c_v=R>0$. Beide Wärmekapazitäten in J/(kg K); bei veränderlichen Wärmekapazitäten gilt die Beziehung zustandsweise.
]

#aufgabe(titel: "Altklausur WS 01/02: Kurzfrage 5", art: "verstehen", quelle: "3.8.1", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 01/02, Kurzfrage 5 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 258* #linebreak()]
Warum ist die isobare Wärmekapazität größer als die isochore? Wie lautet der Zusammenhang für ein ideales Gas?
][
*Antwort:* Bei isobarer Erwärmung expandiert das Gas und verrichtet zusätzlich Volumenarbeit. Bei isochorer Erwärmung entfällt diese. Für ideales Gas gilt $c_p-c_v=R>0$. Beide Wärmekapazitäten in J/(kg K); bei veränderlichen Wärmekapazitäten gilt die Beziehung zustandsweise.
]

#aufgabe(titel: "Altklausur Übungsklausur WS 99/00: Kurzfrage 9", art: "verstehen", quelle: "3.8.1", herkunft: "original", minuten: 3, vorlage: "Altklausur Übungsklausur WS 99/00, Kurzfrage 9 (Import 12.11.2026, PDF-S. 2)")[
#if not web [*Aufgabe 259* #linebreak()]
Vergleiche bei gleicher Gasmasse und gleicher Anfangs- und Endtemperatur die Wärmezufuhr bei isobarer und isochorer Erwärmung. Welche ist größer und warum?
][
*Antwort:* Bei isobarer Erwärmung expandiert das Gas und verrichtet zusätzlich Volumenarbeit. Bei isochorer Erwärmung entfällt diese. Für ideales Gas gilt $c_p-c_v=R>0$. Beide Wärmekapazitäten in J/(kg K); bei veränderlichen Wärmekapazitäten gilt die Beziehung zustandsweise.
]

#aufgabe(titel: "Warum c_p größer als c_v ist", art: "verstehen", quelle: "3.8.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 260* #linebreak()]
Warum braucht das ideale Gas bei gleichem Temperaturanstieg isobar mehr Wärme als isochor?
][
*Antwort:*

- Bei konstantem Volumen wird keine Volumenarbeit abgegeben.
- Bei konstantem Druck dehnt sich das Gas beim Erwärmen aus und gibt zusätzlich Arbeit ab.
- Deshalb gilt im passenden reibfreien Modell $c_p=c_v+R>c_v$.

#align(center)[#image("abbildungen/waermekapazitaet-kolben.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „Weil isochore Erwärmung die Temperatur nicht ändern kann.“: Bei festem Volumen kann die Temperatur steigen; stattdessen steigt der Druck.
- „Weil die gleiche Gasportion isobar automatisch schwerer wird.“: Verglichen wird dieselbe geschlossene Masse. Der Unterschied stammt nicht aus zusätzlicher Masse.
]

#aufgabe(titel: "Kalorische Beziehungen auf jedem Weg", art: "verstehen", quelle: "3.8.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 261* #linebreak()]
Gelten die kalorischen Stoffbeziehungen beim idealen Gas nur auf isochoren beziehungsweise isobaren Wegen?
][
*Antwort:*

- Nein.
- Beim idealen Gas hängen innere Energie und Enthalpie nur von der Temperatur ab
- die beiden Stoffbeziehungen gelten auch auf anderen Wegen.
- Erst die Gleichsetzung der Wärme mit diesen Energieänderungen benötigt passende Prozessbedingungen.
]

#aufgabe(titel: "Gesamte, spezifische und molare Wärmekapazität", art: "verstehen", quelle: "3.8.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 262* #linebreak()]
Wie unterscheiden sich gesamte, spezifische und molare Wärmekapazität?
][
*Antwort:*

- Die gesamte Wärmekapazität gehört zu einer konkreten Portion und hat die Einheit Energie pro Kelvin.
- Spezifisch bedeutet je Masse, molar je Stoffmenge.
- Verbunden werden sie über Masse beziehungsweise Stoffmenge und Molmasse: $C_p=m c_p=n C_(m,p)$ und $C_(m,p)=M c_p$.

#align(center)[#image("abbildungen/map-waermekapazitaet.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Einheit der molaren Wärmekapazität", art: "verstehen", quelle: "3.8.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 263* #linebreak()]
Welche Einheit gehört zur molaren isobaren Wärmekapazität bei Stoffmenge in kmol? Begründe deine Antwort.
][
*Antwort:* kJ/(kmol K)

Der molare Bezug ist pro Stoffmenge. Mit der Molmasse wird daraus der spezifische Bezug.
][
*Typische Verwechslung:*

- „kJ/(kg K)“: Das ist die spezifische Wärmekapazität je Masse.
- „kJ/K“: Das ist die gesamte Wärmekapazität einer konkreten Portion.
]

#aufgabe(titel: "Altklausur WS 01/02: Kurzfrage 4", art: "verstehen", quelle: "3.8.2", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 01/02, Kurzfrage 4 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 264* #linebreak()]
Was ist der Unterschied zwischen a) mittlerer und b) wahrer Wärmekapazität?
][
*Antwort:* Die wahre Wärmekapazität beschreibt die lokale Ableitung, z. B. $c_p(T)=dif h/dif T$. Die mittlere Wärmekapazität über ein Intervall erfüllt $overline(c)_(p,12)=(h_2-h_1)/(T_2-T_1)$. Ein Tabellenmittel ab 0 °C ist nicht automatisch das Mittel zwischen zwei beliebigen Temperaturen.
]

#aufgabe(titel: "Mittlere Wärmekapazität zwischen zwei Temperaturen", art: "verstehen", quelle: "3.8.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 265* #linebreak()]
Warum ist das Mittel 0 bis 800 Grad nicht das Mittel 400 bis 1200 Grad?
][
*Antwort:*

- Gleiche Bereichsbreite bedeutet nicht dieselben Temperaturen oder dieselbe Wärmekapazität.
- Aus seit 0 Grad tabellierten Mittelwerten werden zuerst die Energiezunahmen zu beiden Endtemperaturen gebildet und voneinander abgezogen.
- Erst danach wird durch die Breite des gesuchten Bereichs geteilt.

#align(center)[#image("abbildungen/waermekapazitaet-mittel.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „Den Tabellenwert seit 0 bis 800 °C ablesen.“: Die gleiche Breite macht zwei verschiedene Temperaturbereiche nicht gleich.
- „Die beiden Tabellenwerte einfach arithmetisch mitteln.“: Tabelliert sind bereits unterschiedliche integrale Mittel. Ihre bloße Mittelung bildet das Zielintervall nicht ab.
]

#aufgabe(titel: "Luft von 400 bis 1200 Grad: passende Wärmekapazitäten", art: "rechnen", quelle: "3.8.2", herkunft: "original", vorlage: "Vorlesung 3.11., Beispiel S. 4–8", minuten: 12,
 ergebnis: [$overline(C)_(m,p,12)="33,27"$ kJ/(kmol K); $overline(c)_(p,12) approx "1,14922"$, $overline(c)_(v,12) approx "0,862038"$ kJ/(kg K); $kappa_12 approx "1,33315"$.],
 tipp: [Die zwei Tabellenwerte beziehen sich jeweils auf 0 °C. Subtrahiere die zugehörigen Enthalpiezunahmen.])[
#if not web [*Aufgabe 266* #linebreak()]
*Gegeben und Annahmen:* Ideale Luft von $vartheta_1=400$ °C bis $vartheta_2=1200$ °C. T-4 beziehungsweise BT A.5 gibt molare Mittelwerte seit 0 °C an:
#tab(columns: (1fr, 1fr), th([Bereich], [$overline(C)_(m,p)$ kJ/(kmol K)]), [0–400 °C], [29,79], [0–1200 °C], [32,11])
Innerhalb dieses Datensatzes $M="28,95"$ kg/kmol verwenden; universelle Gaskonstante $R_m="8,314"$ kJ/(kmol K), also $R=R_m/M$. Der gesuchte κ-Wert ist das Verhältnis der *hier berechneten Bereichsmittel*, kein universell konstanter Luftwert.

*Gesucht:*
#enum(numbering: "a)")[Berechne die molaren Bereichsmittel für p und v.][Rechne beide in spezifische Wärmekapazitäten um.][Bestimme κ und begründe, warum der Tabellenwert seit 0–800 °C oder der Standardwert 1,4 nicht einfach eingesetzt werden darf.]
#src[N03, PDF-S. 4–8; BT A.5, S. 483 / PDF-S. 498. Konsistente Gaskonstante ausdrücklich angegeben.]
][
*Die Bezugsbereiche auseinanderhalten:* Ein Tabellenmittel multipliziert mit seinem Bereich ergibt die molare Enthalpiezunahme seit 0 °C. Die Differenz $"32,11" dot 1200-"29,79" dot 400=26616$ kJ/kmol gehört zum gesuchten Bereich von 800 K.
][
*Isobares Bereichsmittel bilden:* $overline(C)_(m,p,12)=26616/(1200-400)="33,27"$ kJ/(kmol K). Das Mittel 0–800 °C umfasst andere Temperaturen und ist trotz derselben Breite nicht dasselbe.
][
*Isochore Größe und Mengenbezug umrechnen:* $overline(C)_(m,v,12)="33,27"-"8,314"="24,956"$ kJ/(kmol K). Durch Division durch M folgen $overline(c)_(p,12)="33,27"/"28,95" approx "1,1492228"$ und $overline(c)_(v,12)="24,956"/"28,95" approx "0,8620380"$ kJ/(kg K).
][
*Verhältnis bilden und prüfen:* $kappa_12="33,27"/"24,956" approx "1,333146"$. Es ist größer als eins, weil $c_p-c_v=R>0$. Die Differenz der spezifischen Werte ist $"8,314"/"28,95" approx "0,2871848"$ kJ/(kg K). 1,4 gehört zum konstanten Vergleichsmodell beziehungsweise zum Tabellenwert bei 0 °C; der Vorlesungsbereich wird damit nicht ersetzt.
]

#aufgabe(titel: "Altklausur WS 04/05: Kurzfrage 4", art: "verstehen", quelle: "3.9", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 04/05, Kurzfrage 4 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 267* #linebreak()]
Was gilt nach einem vollständigen Umlauf im Kreisprozess für a) die Summe der Zustandsgrößenänderungen (Beispiel), b) Wärme, c) Arbeit, d) Wärme plus Arbeit?
][
*Antwort:* Nach einem Umlauf ist jede Zustandsgröße wieder am Anfangswert: etwa $Delta U=Delta H=Delta S=0$. Die Netto-Wärme und die Netto-Arbeit können einzeln ungleich null sein; in Zufuhrkonvention gilt $Q_"netto"+W_"netto"=0$, wenn auch die äußere Speicherenergie zum Anfangswert zurückkehrt.
]

#aufgabe(titel: "Altklausur WS 00/01: Kurzfrage 2", art: "verstehen", quelle: "3.9", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 00/01, Kurzfrage 2 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 268* #linebreak()]
Formuliere den ersten Hauptsatz für einen Kreisprozess.
][
*Antwort:* Nach einem Umlauf ist jede Zustandsgröße wieder am Anfangswert: etwa $Delta U=Delta H=Delta S=0$. Die Netto-Wärme und die Netto-Arbeit können einzeln ungleich null sein; in Zufuhrkonvention gilt $Q_"netto"+W_"netto"=0$, wenn auch die äußere Speicherenergie zum Anfangswert zurückkehrt.
]

#aufgabe(titel: "Kreisprozess: Zustandsrückkehr und Nettoarbeit", art: "verstehen", quelle: "3.9", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 269* #linebreak()]
Eine Dampfkraftanlage besteht aus Pumpe, Kessel, Turbine und Kondensator und läuft stationär. Erkläre, warum im vollständigen Umlauf Zustandsänderungen verschwinden, trotzdem Nettoarbeit abgegeben wird und die Pumpenleistung dabei mitgezählt werden muss. Ordne ein Perpetuum mobile erster Art ein.
#src[N03, PDF-S. 12–14; eigene Verständnisfrage.]
][
*Zustand von Übertragung trennen:* Nach einem Umlauf kehrt das Arbeitsmittel in denselben Zustand zurück. Daher sind die gesamten Änderungen von U und H null. Wärme und Arbeit sind dagegen Prozessgrößen und können während des Umlaufs ungleich null übertragen werden.
][
*Gesamtbilanz aufstellen:* In der Zufuhrkonvention gilt $Q_"zu"+Q_"ab"+W_"netto"=0$. Die abgegebene Nettoarbeit entsteht aus Turbinenabgabe abzüglich Pumpenaufnahme; interne Stoffströme treten in der Gesamtbilanz zweimal mit entgegengesetzten Vorzeichen auf.
][
*Grenzfall beurteilen:* Dauerhafte Arbeit ohne gleichwertige andere Energiezufuhr oder Speicherabnahme wäre ein Perpetuum mobile erster Art. Es verletzt die Energieerhaltung. Die Rückkehr des Zustands liefert selbst keine Energie.
][
*Ausführlich:*

- Das Arbeitsmittel kehrt nach dem Umlauf zu seinen Anfangswerten zurück.
- Wärme und Arbeit sind aber Übertragungen entlang des Wegs und können netto bestehen bleiben.
- Ihre vorzeichenbehaftete Summe muss sich nach dem ersten Hauptsatz ausgleichen.

#align(center)[#image("abbildungen/kreisprozess-energie.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „Die Pumpenaufnahme darf bei der Nettoleistung grundsätzlich ignoriert werden.“: Die Nutzabgabe ist Turbinenabgabe abzüglich der zugehörigen Pumpenaufnahme.
]

#aufgabe(titel: "Kurzfrage: Bilanz nach einem vollständigen Umlauf", art: "verstehen", quelle: "3.9.1", herkunft: "original", vorlage: "Leistungsnachweis SS 13, Kurzfrage 14", minuten: 3)[
#if not web [*Aufgabe 270* #linebreak()]
Was gilt nach dem vollständigen Umlauf in einem Kreisprozess für die Summen der Änderungen von a) einer Zustandsgröße, b) der Wärme, c) der Arbeit, d) Wärme plus Arbeit?
][
*Antwort:* a) $sum Delta h_i = 0$ (ebenso für $u$, $s$, $p$ …). b) $sum q_i != 0$. c) $sum w_i != 0$. d) $sum (q_i + w_i) = 0$.
][
*Warum:* Das Arbeitsmittel kehrt in den Anfangszustand zurück, also verschwindet jede Zustandsänderung. Wärme und Arbeit sind Prozessgrößen; einzeln bleibt netto etwas übrig, aber nach dem ersten Hauptsatz heben sie sich gegenseitig auf. Genau so gibt ein Kraftwerk netto Arbeit ab.
]

#aufgabe(titel: "Rechtsläufig und linksläufig", art: "verstehen", quelle: "3.9.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 271* #linebreak()]
Wie unterscheiden sich rechtsläufiger und linksläufiger Kreisprozess in ihrer Energienutzung?
][
*Antwort:*

- Der rechtsläufige Wärmekraftprozess gibt netto Arbeit ab.
- Beim linksläufigen Prozess wird Arbeit zugeführt, um Wärme von einem niedrigeren auf ein höheres Temperaturniveau zu übertragen.
- Pumpenaufnahme und Turbinenabgabe dürfen in einer Gesamtbilanz nicht verwechselt werden.

#align(center)[#image("abbildungen/kreisprozess-energie.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Perpetuum mobile erster Art", art: "verstehen", quelle: "3.9.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 272* #linebreak()]
Eine Maschine soll dauernd Arbeit abgeben, ohne andere Energie aufzunehmen oder einen Speicher abzubauen. Welche Art von Perpetuum mobile wäre das, und warum ist sie unmöglich?
][
*Antwort:* Eine Maschine soll dauernd Arbeit abgeben, ohne andere Energie aufzunehmen oder einen Speicher abzubauen. Das wäre ein Perpetuum mobile *erster* Art.
][
*Warum:* Die Behauptung verletzt den ersten Hauptsatz. Ein geschlossener Kreis des Arbeitsmittels ist keine Energiequelle.
]

#aufgabe(titel: "Dampfkraftwerk mit Zwischenüberhitzung", art: "rechnen", quelle: "3.9.2", herkunft: "original", vorlage: "Prüfung SS 24, Aufg. 1", minuten: 45,
  ergebnis: [$h_4 approx "3064,2" thin "kJ/kg"$; $eta_(s,T 2) approx "0,865"$; $dot(m) approx "17,39" thin "kg/s"$; $dot(Q)_23 approx "63,74" thin "MW"$, $dot(Q)_45 approx "5,20" thin "MW"$, $P_"SP" approx 292 thin "kW"$, $P_T approx -"25,91" thin "MW"$; $eta_"th" approx "0,372"$],
  tipp: [Gehe Zustand für Zustand vor: Jede Komponente liefert eine Bedingung (isentrop, isobar, Gütegrad, Dampfgehalt), mit der du die Tabelle liest.])[
#if not web [*Aufgabe 273* #linebreak()]
*Gegeben und Annahmen*

Gegeben ist ein Dampfkraftwerk mit einem Dampferzeugerdruck von 145 bar, in dem Dampf auf eine Temperatur von 525 °C überhitzt wird (Zustand ③). Der überhitzte Dampf wird in einem zweistufigen Turbinenprozess entspannt. In der 1. Turbinenstufe wird der Dampf auf einen Druck von 45 bar entspannt (④). Der isentrope Wirkungsgrad der ersten Turbinenstufe beträgt $eta_(s,T 1) = "0,95"$. Vor dem Eintritt in die 2. Turbine wird der Dampf erneut dem Dampferzeuger zugeführt und auf eine Temperatur von 450 °C zwischenüberhitzt (⑤). In der 2. Turbinenstufe wird der Dampf dann auf den Kondensationsdruck von 0,12 bar entspannt (⑥). Dabei stellt sich ein Dampfmassengehalt von $x = "0,9"$ ein. Im Kondensator wird der Dampf kondensiert und das Kondensat um 5 K unterkühlt (①). Die Kompression in der Speisepumpe (① → ②) wird als isentrop angenommen und die Druckabhängigkeit der Dichte des Speisewassers wird vernachlässigt. In den Kondensator wird sekundärseitig ein Kühlwasserstrom von $dot(m)_"KW" = 200 thin "kg/s"$ mit einer Temperatur von 20 °C bei näherungsweise Umgebungsdruck eingeleitet, der den Kondensator mit 65 °C wieder verlässt. $c_("H"_2"O") = "4,186" thin "kJ/(kg K)"$. Kinetische und potentielle Energien sowie Druckverluste werden vernachlässigt.

Wasserdampftafel, Sättigungszustand:
#tab(columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
 th([$p$ in bar], [$t$ in °C], [$h'$ in kJ/kg], [$h''$ in kJ/kg], [$s'$ in kJ/(kg K)], [$s''$ in kJ/(kg K)]),
 [0,12], [49,4], [206,91], [2590,29], [0,6963], [8,0850],
 [45], [257,4], [1122,14], [2798,00], [2,8613], [6,0198],
 [145], [339,5], [1590,51], [2624,81], [3,6538], [5,3422],
)
Wasserdampftafel, ungesättigter Zustand:
#tab(columns: (1fr, 1fr, 1fr, 1fr),
 th([$p$ in bar], [$t$ in °C], [$h$ in kJ/kg], [$s$ in kJ/(kg K)]),
 [0,12], [40,0], [167,55], [0,5724],
 [0,12], [44,4], [186,01], [0,6310],
 [0,12], [50,0], [2591,41], [8,0885],
 [45], [300,0], [2944,10], [6,2852],
 [45], [336,9], [3047,19], [6,4597],
 [45], [343,3], [3064,21], [6,4874],
 [45], [450,0], [3324,05], [6,8767],
 [45], [500,0], [3440,18], [7,0320],
 [145], [44,9], [200,60], [0,6310],
 [145], [49,4], [219,31], [0,6894],
 [145], [525,0], [3387,67], [6,4597],
 [145], [530,0], [3401,43], [6,4768],
)

*Gesucht*

#enum(numbering: "a)",
[Skizziere den Kreisprozess sowie die Zustände im T,s-Diagramm.],
[Berechne die Zustandsgrößen $p$, $t$, $h$ und $s$ der einzelnen Zustände ① bis ⑥ und trage sie in eine Tabelle ein.],
[Welchen isentropen Wirkungsgrad hat die 2. Turbinenstufe?],
[Wie groß ist der Wassermassenstrom $dot(m)$, der durch den Primärkreis fließt?],
[Ab jetzt gilt $dot(m) = 20 thin "kg/s"$. Berechne die im Kessel zugeführten Wärmeströme (② → ③ und ④ → ⑤), die Leistung $P_"SP"$, die der Speisewasserpumpe zugeführt werden muss, und die Leistung $P_T$, die die beiden Turbinenstufen abgeben.],
[Wie groß ist der thermische Wirkungsgrad des Kreisprozesses?],
)
][
*T,s-Skizze:* ① liegt links der Siedelinie bei 0,12 bar (unterkühlt). Die isentrope Pumpe führt fast senkrecht und kaum sichtbar nach ② auf 145 bar. Die Isobare 145 bar steigt durch das Flüssigkeitsgebiet, läuft waagerecht durch das Nassdampfgebiet bei 339,5 °C und steigt im Überhitzungsgebiet bis ③ (525 °C). Die Turbine 1 führt leicht nach rechts geneigt (Entropiezunahme wegen $eta_s < 1$) nach ④ auf 45 bar. Die Zwischenüberhitzung folgt der 45-bar-Isobare bis ⑤ (450 °C). Turbine 2 führt nach rechts unten ins Nassdampfgebiet nach ⑥ ($x = "0,9"$). Der Kondensator folgt der waagerechten 0,12-bar-Isobare und etwas darüber hinaus bis ①.
][
*Zustände ① bis ③:*
- ① 0,12 bar, $t = "49,4" - 5 = "44,4" thin "°C"$: Tabelle $h_1 = "186,01" thin "kJ/kg"$, $s_1 = "0,6310" thin "kJ/(kg K)"$.
- ② isentrop auf 145 bar, $s_2 = s_1 = "0,6310"$: Tabelle $t_2 = "44,9" thin "°C"$, $h_2 = "200,60" thin "kJ/kg"$. Probe mit $w_t = v Delta p approx "0,00101" dot 14 thin 488 thin "kJ/kg" approx "14,6" thin "kJ/kg"$.
- ③ 145 bar, 525 °C: $h_3 = "3387,67" thin "kJ/kg"$, $s_3 = "6,4597" thin "kJ/(kg K)"$.
][
*Zustände ④ bis ⑥:*
- ④: isentroper Vergleich bei 45 bar mit $s = "6,4597"$: $h_(4s) = "3047,19" thin "kJ/kg"$. Mit dem Gütegrad $h_4 = h_3 - eta_(s,T 1)(h_3 - h_(4s)) = "3387,67" - "0,95" dot "340,48" approx "3064,21" thin "kJ/kg"$; Tabelle: $t_4 = "343,3" thin "°C"$, $s_4 = "6,4874"$.
- ⑤ 45 bar, 450 °C: $h_5 = "3324,05" thin "kJ/kg"$, $s_5 = "6,8767"$.
- ⑥ 0,12 bar, $x = "0,9"$, $t_6 = "49,4" thin "°C"$: $h_6 = "206,91" + "0,9" dot "2383,38" approx "2351,95" thin "kJ/kg"$, $s_6 = "0,6963" + "0,9" dot "7,3887" approx "7,3461" thin "kJ/(kg K)"$.
][
*Gütegrad der Stufe 2:* Isentroper Vergleich ab ⑤ auf 0,12 bar: $x_(6s) = (s_5 - s')\/(s'' - s') = ("6,8767" - "0,6963")\/"7,3887" approx "0,8365"$, $h_(6s) approx "2200,5" thin "kJ/kg"$.
$ eta_(s,T 2) = (h_5 - h_6)/(h_5 - h_(6s)) = "972,10"/"1123,52" approx "0,865" $
][
*Massenstrom aus dem Kondensator:* Der Kondensator ist nach außen adiabat; die Enthalpieabgabe des Dampfes nimmt das Kühlwasser auf:
$ dot(m)_"KW" c (t_"aus" - t_"ein") = dot(m)(h_6 - h_1) quad => quad dot(m) = (200 dot "4,186" dot 45)/("2351,95" - "186,01") thin "kg/s" approx "17,39" thin "kg/s" $
][
*Leistungen mit $dot(m) = 20 thin "kg/s"$:*
$ dot(Q)_23 = dot(m)(h_3 - h_2) approx "63,74" thin "MW" quad dot(Q)_45 = dot(m)(h_5 - h_4) approx "5,20" thin "MW" $
$ P_"SP" = dot(m)(h_2 - h_1) approx 292 thin "kW" quad P_T = dot(m)[(h_4 - h_3) + (h_6 - h_5)] approx -"25,91" thin "MW" $
Das Minus zeigt die Abgabe (Zufuhrkonvention).
][
*Thermischer Wirkungsgrad:* Nutzen ist die Nettoleistung, Aufwand die im Kessel zugeführte Wärme:
$ eta_"th" = (-(P_T + P_"SP")) / (dot(Q)_23 + dot(Q)_45) = ("25,91" - "0,29")/("63,74" + "5,20") approx "0,372" $
Probe: Die Kondensatorwärme $dot(m)(h_1 - h_6) approx -"43,32" thin "MW"$ schließt die Energiebilanz des Kreisprozesses auf null.
]

#aufgabe(titel: "Dampfkraftwerk mit besserer Hochdruckturbine (Variante)", art: "rechnen", quelle: "3.9.2", herkunft: "variante", vorlage: "Prüfung SS 24, Aufg. 1", minuten: 35,
  ergebnis: [$h_4 approx "3057,4" thin "kJ/kg"$, $t_4 approx "340,7" thin "°C"$; $eta_(s,T 2) approx "0,823"$; $dot(m) approx "19,86" thin "kg/s"$; mit 25 kg/s: $dot(Q)_"zu" approx "86,34" thin "MW"$, $P_T approx -"31,37" thin "MW"$; $eta_"th" approx "0,359"$])[
#if not web [*Aufgabe 274* #linebreak()]
*Gegeben und Annahmen*

Dampfkraftwerk mit denselben Drücken und Temperaturen wie im Original: Frischdampf ③ 145 bar, 525 °C; Turbine 1 bis 45 bar, jetzt mit $eta_(s,T 1) = "0,97"$; Zwischenüberhitzung auf ⑤ 45 bar, 450 °C; Turbine 2 bis 0,12 bar, wo sich jetzt $x_6 = "0,92"$ einstellt; Kondensat 5 K unterkühlt; Speisepumpe isentrop. Kühlwasser: $250 thin "kg/s"$ von 18 °C auf 60 °C, $c = "4,186" thin "kJ/(kg K)"$. Dampftafel wie im Original (Auszug):
#tab(columns: (1fr, 1fr, 1fr, 1fr),
 th([$p$ in bar], [$t$ in °C], [$h$ in kJ/kg], [$s$ in kJ/(kg K)]),
 [0,12], [44,4], [186,01], [0,6310],
 [45], [336,9], [3047,19], [6,4597],
 [45], [343,3], [3064,21], [6,4874],
 [45], [450,0], [3324,05], [6,8767],
 [145], [44,9], [200,60], [0,6310],
 [145], [525,0], [3387,67], [6,4597],
)
Sättigung 0,12 bar: $t = "49,4" thin "°C"$, $h' = "206,91"$, $h'' = "2590,29" thin "kJ/kg"$, $s' = "0,6963"$, $s'' = "8,0850" thin "kJ/(kg K)"$.

*Gesucht*

#enum(numbering: "a)",
[Zustand ④ ($h$, $t$, $s$) und Zustand ⑥ ($h$, $s$).],
[Den isentropen Wirkungsgrad der Stufe 2.],
[Den Primärmassenstrom aus der Kondensatorbilanz.],
[Mit $dot(m) = 25 thin "kg/s"$: Kesselwärme, Pumpen- und Turbinenleistung sowie den thermischen Wirkungsgrad.],
)
][
*Zustand ④:* $h_4 = "3387,67" - "0,97" dot "340,48" approx "3057,40" thin "kJ/kg"$. Zwischen den Tabellenzeilen 336,9 °C und 343,3 °C liegt der Anteil $f = ("3057,40" - "3047,19")\/"17,02" approx "0,600"$: $t_4 approx "340,7" thin "°C"$, $s_4 approx "6,4763" thin "kJ/(kg K)"$.

*Zustand ⑥:* $h_6 = "206,91" + "0,92" dot "2383,38" approx "2399,62" thin "kJ/kg"$, $s_6 approx "7,4939" thin "kJ/(kg K)"$.
][
*Stufe 2:* $h_(6s) approx "2200,5" thin "kJ/kg"$ wie im Original (gleiches ⑤ und gleicher Enddruck):
$ eta_(s,T 2) = ("3324,05" - "2399,62")/("3324,05" - "2200,53") approx "0,823" $
Weil ⑥ beim höheren Dampfgehalt mehr Enthalpie behält, gibt Stufe 2 weniger Arbeit ab als im Original; ihr Gütegrad sinkt.
][
*Massenstrom:* $dot(m) = 250 dot "4,186" dot 42\/("2399,62" - "186,01") thin "kg/s" approx "19,86" thin "kg/s"$.
][
*Leistungen mit 25 kg/s:* $dot(Q)_23 = 25 dot "3187,07" approx "79,68" thin "MW"$, $dot(Q)_45 = 25 dot "266,65" approx "6,67" thin "MW"$, $P_"SP" = 25 dot "14,59" approx 365 thin "kW"$, $P_T = 25[("3057,40" - "3387,67") + ("2399,62" - "3324,05")] approx -"31,37" thin "MW"$.
$ eta_"th" = ("31,37" - "0,36")/("79,68" + "6,67") approx "0,359" $
Die bessere Hochdruckstufe wird durch die schlechtere Niederdruckstufe mehr als aufgezehrt.
]

#aufgabe(titel: "Altklausur Übungsklausur WS 99/00: Kurzfrage 8", art: "verstehen", quelle: "3.10", herkunft: "original", minuten: 3, vorlage: "Altklausur Übungsklausur WS 99/00, Kurzfrage 8 (Import 12.11.2026, PDF-S. 2)")[
#if not web [*Aufgabe 275* #linebreak()]
Wie ändern sich bei der adiabaten Drosselung eines idealen Gases Temperatur, Druck, Enthalpie und Entropie? Nenne die Modellannahmen.
][
*Antwort:* Stationär, adiabat, ohne technische Arbeit und ohne wesentliche äußere Energieänderung bleibt h konstant. Beim idealen Gas bleibt damit T konstant; p sinkt und s steigt bei einer Druckabsenkung. Die Drosselung ist irreversibel.
]

#aufgabe(titel: "Düse und Drossel: gleiche Bilanz, andere Vereinfachung", art: "verstehen", quelle: "3.10", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 276* #linebreak()]
Vergleiche eine adiabate Düse gleicher Ein-/Austrittshöhe mit einer adiabaten Drossel, bei der außerdem die äußeren Geschwindigkeiten etwa gleich sind. Beide übertragen keine technische Arbeit und werden stationär betrachtet. Welche Energiegröße bleibt jeweils erhalten? Sind beide deswegen reversibel?
#src[N04, PDF-S. 1; eigene Verständnisfrage.]
][
*Vollständige Ausgangsbilanz nennen:* $h_2-h_1+(c_2^2-c_1^2)/2+g(z_2-z_1)=0$. Adiabat und ohne technische Arbeit sind Aussagen über die äußeren Übertragungen, nicht über innere Irreversibilität.
][
*Düsenfall vereinfachen:* Bei gleicher Höhe bleibt $h+c^2/2$ gleich. Eine Geschwindigkeitszunahme kann daher aus einem Enthalpieabfall stammen. Die Enthalpie allein ist nicht allgemein konstant.
][
*Drosselfall vereinfachen:* Bei zusätzlich etwa gleicher Geschwindigkeit folgt $h_2 approx h_1$. Der Druck darf trotzdem fallen. Die Drossel ist irreversibel; das wird später mit positiver Entropieerzeugung sichtbar. Eine idealisierte Düse kann zusätzlich reversibel modelliert werden, doch ihre Energiebilanz allein beweist das nicht.
][
*Ausführlich:*

- Ohne technische Arbeit und bei gleicher Höhe bleibt die Summe aus Enthalpie und spezifischer Bewegungsenergie gleich.
- Wird der Strom schneller, kann seine Enthalpie sinken.
- Adiabat streicht den Wärmestrom und streicht nicht den Geschwindigkeitsbeitrag.

#align(center)[#image("abbildungen/stroemung-duese-drossel.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Düse: mehr Tempo kann weniger Enthalpie bedeuten.
][
*Ausführlich:*

- Druckabbau und innere Irreversibilität sind auch ohne äußere Arbeitsabgabe möglich.
- Bei vernachlässigten äußeren Energieänderungen bleibt die Enthalpie gleich, während die Entropie zunimmt.
- Die Energiebilanz allein beweist deshalb keine Reversibilität.

#align(center)[#image("abbildungen/stroemung-duese-drossel.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Gleiche Enthalpie beweist keine Reversibilität.
][
*Typische Verwechslung:*

- „Die Enthalpie muss gleich bleiben, weil keine Wärme übertragen wird.“: Adiabat streicht nur den Wärmestrom; die Bewegungsenergie bleibt Teil der Bilanz.
- „Die Düse erzeugt zusätzliche Energie durch den kleineren Querschnitt.“: Der Querschnitt beeinflusst die Strömung, erzeugt aber keine Energie.
][
*Typische Verwechslung:*

- „Enthalpiekonstanz beweist Reversibilität.“: Reversibilität wird dadurch nicht bewiesen; die Drossel ist ein typisches Gegenbeispiel.
- „Bei jedem realen Fluid bleibt automatisch auch die Temperatur gleich.“: Die Enthalpie eines realen Fluids hängt im Allgemeinen nicht allein von der Temperatur ab.
]

#aufgabe(titel: "Isenthalp heißt nicht isotherm", art: "verstehen", quelle: "3.10", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 277* #linebreak()]
Warum bedeutet isenthalpe Drosselung bei einem realen Fluid nicht automatisch konstante Temperatur?
][
*Antwort:*

- Die Enthalpie eines realen Fluids hängt im Allgemeinen von mehr als der Temperatur ab.
- Daher können sich Druck und Temperatur ändern, obwohl die Enthalpie gleich bleibt.
- Nur beim idealen Gas mit Enthalpie als reiner Temperaturfunktion folgt unter diesen Bedingungen auch gleiche Temperatur.
]

#aufgabe(titel: "Diffusor im Strahltriebwerk", art: "rechnen", quelle: "3.10", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 1.9", minuten: 12,
  ergebnis: [$dot(m) approx "78,7" thin "kg/s"$; $vartheta_2 approx "29,9" thin "°C"$])[
#if not web [*Aufgabe 278* #linebreak()]
*Gegeben und Annahmen*

In das Triebwerk im Jet von Steven Starfighter strömt bei einer Fluggeschwindigkeit von $w_1 = 720 thin "km/h"$ Luft mit einer Temperatur von $vartheta_1 = 10 thin "°C"$ bei einem Druck von $p = "0,8" thin "bar"$ in einen Diffusor mit der Querschnittsfläche $A = "0,4" thin "m"^2$ ein. Aufgrund des sich erweiternden Strömungsquerschnitts ist die Austrittsgeschwindigkeit $w_2$ deutlich geringer als die Eintrittsgeschwindigkeit ($w_2 << w_1$). Stark vereinfacht kann die Luft (ideales Gas, $R = "287,1" thin "J/(kg K)"$, $c_p = "1,004" thin "kJ/(kg K)"$) als inkompressibel betrachtet werden. Der Diffusor ist adiabat, ohne technische Arbeit und ohne Höhenänderung.

*Gesucht*

#enum(numbering: "a)",
[Berechne den eintretenden Luftmassenstrom $dot(m)$.],
[Mit welcher Temperatur $vartheta_2$ tritt die Luft aus dem Diffusor aus? Hinweis: Stelle eine geeignete Energiebilanz am System auf.],
)
][
*Dichte am Eintritt:* Gasgleichung mit $T_1 = "283,15" thin "K"$:
$ rho = p/(R T_1) = ("0,8" times 10^5)/("287,1" dot "283,15") thin "kg/m"^3 approx "0,984" thin "kg/m"^3 $
][
*Massenstrom:* $w_1 = 720\/"3,6" = 200 thin "m/s"$:
$ dot(m) = rho A w_1 = "0,984" dot "0,4" dot 200 thin "kg/s" approx "78,7" thin "kg/s" $
][
*Energiebilanz:* Stationär, adiabat, ohne technische Arbeit und ohne Höhenänderung:
$ 0 = dot(m) [(h_2 - h_1) + (w_2^2 - w_1^2)/2] quad => quad h_2 - h_1 = (w_1^2 - w_2^2)/2 approx w_1^2/2 $
Mit $Delta h = c_p Delta T$:
$ T_2 - T_1 = w_1^2/(2 c_p) = (200^2)/(2 dot 1004) thin "K" approx "19,9" thin "K" quad => quad vartheta_2 approx "29,9" thin "°C" $
Der Diffusor bremst die Luft ab; ihre Bewegungsenergie wird Enthalpie. Das ist die Umkehrung der Düse.
]

#aufgabe(titel: "Diffusor bei 540 km/h und Frost (Variante)", art: "rechnen", quelle: "3.10", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 1.9", minuten: 10,
  ergebnis: [$dot(m) approx "47,7" thin "kg/s"$; $vartheta_2 approx "6,2" thin "°C"$])[
#if not web [*Aufgabe 279* #linebreak()]
*Gegeben und Annahmen*

Luft ($R = "287,1" thin "J/(kg K)"$, $c_p = "1,004" thin "kJ/(kg K)"$) strömt mit $w_1 = 540 thin "km/h"$, $vartheta_1 = -5 thin "°C"$ und $p = "0,7" thin "bar"$ durch die Eintrittsfläche $A = "0,35" thin "m"^2$ in einen adiabaten Diffusor ohne technische Arbeit. Am Austritt ist $w_2 << w_1$; Dichteänderungen werden für den Massenstrom vernachlässigt.

*Gesucht*

#enum(numbering: "a)",
[Den Luftmassenstrom.],
[Die Austrittstemperatur.],
)
][
*Massenstrom:* $rho = "0,7" times 10^5\/("287,1" dot "268,15") approx "0,909" thin "kg/m"^3$; $w_1 = 150 thin "m/s"$; $dot(m) = rho A w_1 approx "47,7" thin "kg/s"$.
][
*Temperatur:* $Delta T = w_1^2\/(2 c_p) = 150^2\/2008 thin "K" approx "11,2" thin "K"$, also $vartheta_2 approx "6,2" thin "°C"$. Bei halbem Quadrat der Geschwindigkeit erwärmt sich die Luft nur etwa halb so stark wie im Original.
]

#aufgabe(titel: "Überdruckventil: isentropen Austritt mit der Dampftafel bestimmen", art: "rechnen", quelle: "3.10", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 2.18", minuten: 15,
 ergebnis: [$h_2 approx "3586,774"$ kJ/kg; $vartheta_2 approx "566,423"$ °C; $c_2 approx "748,634"$ m/s.],
 tipp: [Bestimme zuerst am Enddruck den Enthalpiewert bei unveränderter spezifischer Entropie.])[
#if not web [*Aufgabe 280* #linebreak()]
*Gegeben und Annahmen:* Ü 2.18: Dampf strömt aus einem großen Kessel durch ein Überdruckventil. $h_1=3867$ kJ/kg und $s_1="7,166"$ kJ/(kg K); am engsten Querschnitt $p_2=50$ bar, näherungsweise Lavalzustand. Der lokale Ausfluss wird stationär, adiabat und isentrop modelliert; keine technische Arbeit, gleiche Höhe und vernachlässigte Anfangsgeschwindigkeit. $1$ kJ/kg = $1000$ J/kg. Eingangszustand aus demselben Datensatz: $p_1=100$ bar, $vartheta_1=700$ °C, $v_1="0,04355"$ m³/kg.
#tab(columns: (1fr, 1fr, 1fr, 1fr),
 th([Bei 50 bar: °C], [$v$ m³/kg], [$h$ kJ/kg], [$s$ kJ/(kg K)]),
 [550], [0,07360], [3549], [7,121], [600], [0,07862], [3664], [7,258],
)
*Gesucht:*
#enum(numbering: "a)")[Berechne Zustand ② aus den Tabellenwerten.][Bestimme die Geschwindigkeit.][Beschreibe den Weg im p-v-Diagramm.]
#src[N04, PDF-S. 1 verweist auf Ü 2.18; Ü, PDF-S. 17; BT A.8, S. 492 / PDF-S. 507.]
][
*Isentropie nutzen:* $s_2=s_1="7,166"$ kJ/(kg K). Bei 50 bar liegt dieser Wert zwischen den beiden Tabellenzeilen. Der Interpolationsanteil ist $f=("7,166"-"7,121")/("7,258"-"7,121") approx "0,3284672"$.
][
*Endzustand aus derselben Interpolation bilden:* $h_2=3549+f(3664-3549) approx "3586,773723"$ kJ/kg, $vartheta_2=550+50f approx "566,42336"$ °C und $v_2="0,07360"+f("0,07862"-"0,07360") approx "0,0752489"$ m³/kg.
][
*Energiebilanz in Geschwindigkeit umrechnen:* $c_2=sqrt(2(h_1-h_2))$ verlangt die Enthalpiedifferenz in J/kg. $c_2=sqrt(2 dot 1000 dot (3867-"3586,773723")) approx "748,6338"$ m/s. Das Modell verlangt keinen zusätzlichen idealen Gasansatz für den realen Dampf.
][
*Weg und Einheit prüfen:* Von ① nach ② fällt p von 100 auf 50 bar und v steigt von 0,04355 auf etwa 0,07525 m³/kg; die Kurve läuft nach rechts unten bei konstantem s. J/kg entspricht m²/s²; die Wurzel ergibt m/s. Die hohe Geschwindigkeit passt zum vorgegebenen näherungsweisen Lavalzustand; dieser wurde nicht unabhängig über eine Schallgeschwindigkeitsgleichung hergeleitet.
]

#aufgabe(titel: "Nassdampf auf 1 bar drosseln", art: "rechnen", quelle: "3.10", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.18 a–c, e, f", minuten: 20,
  ergebnis: [$h_2 = h_1 approx "2757,1" thin "kJ/kg"$; $vartheta_2 approx "140,2" thin "°C"$, überhitzt; $v_2 approx "1,890" thin "m"^3/"kg"$; $s_2 approx "7,568" thin "kJ/(kg K)"$; Energieverlust null; $p^* approx "6,15" thin "bar"$; $d_2\/d_1 approx "3,14"$])[
#if not web [*Aufgabe 281* #linebreak()]
*Gegeben und Annahmen*

23 kg/s an Nassdampf von 180 °C mit einem Dampfgehalt von 0,99 werden in einer chemischen Anlage adiabat auf 1 bar gedrosselt, wobei die Strömungsgeschwindigkeiten vor und nach der Drosselstelle gleich sein sollen.

Dampftafel Wasser, Sättigung:
#tab(columns: (0.9fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
 th([$vartheta_s$ °C], [$p_s$ bar], [$v'$ dm³/kg], [$v''$ m³/kg], [$h'$ kJ/kg], [$h''$ kJ/kg], [$s'$ kJ/(kg K)], [$s''$ kJ/(kg K)]),
 [99,61], [1,0], [1,0431], [1,694], [417,4], [2674,9], [1,303], [7,359],
 [140,18], [3,63], [1,0799], [0,5061], [589,9], [2733,7], [1,741], [6,928],
 [151,83], [5,0], [1,0926], [0,3748], [640,2], [2748,1], [1,861], [6,821],
 [158,83], [6,0], [1,1006], [0,3156], [670,5], [2756,1], [1,931], [6,759],
 [164,95], [7,0], [1,1080], [0,2728], [697,1], [2762,7], [1,992], [6,707],
 [180], [10,026], [1,1274], [0,1939], [763,2], [2777,2], [2,140], [6,584],
)
Überhitzter Dampf bei 1 bar:
#tab(columns: (1fr, 1fr, 1fr, 1fr),
 th([$vartheta$ in °C], [$v$ in m³/kg], [$h$ in kJ/kg], [$s$ in kJ/(kg K)]),
 [130], [1,841], [2736,7], [7,518],
 [140], [1,889], [2756,7], [7,567],
 [150], [1,937], [2776,6], [7,615],
)

*Gesucht*

#enum(numbering: "a)",
[Skizziere diese Zustandsänderung in einem p,v- und in einem $vartheta$,s-Diagramm.],
[Berechne den Endzustand ($p_2$, $v_2$, $vartheta_2$, $x_2$, $h_2$, $s_2$) des Dampfes nach der Drosselung.],
[Wie groß ist der Energieverlust bei diesem Vorgang?],
[Bei welchem Enddruck $p^*$ wäre der Dampf gerade zu 100 % trocken?],
[Wie groß müsste das Durchmesserverhältnis der Rohrleitungen vor und nach der Drossel eigentlich sein?],
)
][
*Drosselbilanz:* Stationär, adiabat, keine Arbeit, gleiche Geschwindigkeit: $h_2 = h_1$.
$ h_1 = "763,2" + "0,99" dot "2014,0" approx "2757,1" thin "kJ/kg" quad v_1 approx "0,19197" thin "m"^3/"kg" quad s_1 approx "6,540" thin "kJ/(kg K)" $
][
*Endzustand:* Bei 1 bar ist $h'' = "2674,9" < h_2$: Der Dampf ist nach der Drossel überhitzt, ein Dampfgehalt $x_2$ ist nicht mehr definiert (einphasig). Zwischen 140 °C und 150 °C interpoliert, Anteil $f = ("2757,06" - "2756,7")\/"19,9" approx "0,018"$:
$ p_2 = 1 thin "bar" quad vartheta_2 approx "140,2" thin "°C" quad v_2 approx "1,890" thin "m"^3/"kg" quad s_2 approx "7,568" thin "kJ/(kg K)" $
*Skizzen:* Im p,v-Diagramm springt der Zustand von ① knapp links der Taulinie bei 10 bar nach rechts unten über die Taulinie ins Überhitzungsgebiet bei 1 bar. Im $vartheta$,s-Diagramm liegt ② rechts von ①: niedrigere Temperatur, höhere Entropie. Die Drossel ist kein durchlaufener Gleichgewichtsweg; man zeichnet nur die Endpunkte, gestrichelt verbunden.
][
*Energieverlust:* Keiner. Die Enthalpie bleibt erhalten, äußere Energien ändern sich nicht. Was verloren geht, ist Arbeitsfähigkeit: Die Entropie steigt um $s_2 - s_1 approx "1,028" thin "kJ/(kg K)"$, also werden $dot(m)(s_2 - s_1) approx "23,7" thin "kW/K"$ Entropie erzeugt.
][
*Trockener Dampf:* Gesucht ist der Druck, bei dem $h''(p^*) = h_1 = "2757,06" thin "kJ/kg"$. Das liegt zwischen 6 bar (2756,1) und 7 bar (2762,7):
$ p^* approx 6 + ("2757,06" - "2756,1")/("2762,7" - "2756,1") thin "bar" approx "6,15" thin "bar" $
][
*Durchmesserverhältnis:* Gleicher Massenstrom und gleiche Geschwindigkeit verlangen $A_2\/A_1 = v_2\/v_1$:
$ d_2/d_1 = sqrt(v_2/v_1) = sqrt("1,890"/"0,19197") approx "3,14" $
Ohne diese Erweiterung wäre die Annahme gleicher Geschwindigkeiten nicht haltbar.
]

#aufgabe(titel: "Nassdampf mit x = 0,985 drosseln (Variante)", art: "rechnen", quelle: "3.10", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.18 a–c, e, f", minuten: 15,
  ergebnis: [$h_2 approx "2747,0" thin "kJ/kg"$; $vartheta_2 approx "135,1" thin "°C"$; $s_2 approx "7,543" thin "kJ/(kg K)"$; $p^* approx "4,89" thin "bar"$; $d_2\/d_1 approx "3,13"$])[
#if not web [*Aufgabe 282* #linebreak()]
*Gegeben und Annahmen*

15 kg/s Nassdampf von 180 °C ($p = "10,026" thin "bar"$) mit $x_1 = "0,985"$ werden adiabat auf 1 bar gedrosselt, gleiche Geschwindigkeit vor und nach der Drossel. Dampftafel (Auszug): 180 °C: $v' = "1,1274" thin "dm"^3/"kg"$, $v'' = "0,1939" thin "m"^3/"kg"$, $h' = "763,2"$, $h'' = "2777,2" thin "kJ/kg"$, $s' = "2,140"$, $s'' = "6,584" thin "kJ/(kg K)"$. Sättigung 3,63 bar: $h'' = "2733,7"$; 5,0 bar: $h'' = "2748,1" thin "kJ/kg"$; 1 bar: $h'' = "2674,9" thin "kJ/kg"$. Überhitzt bei 1 bar: 130 °C: $v = "1,841"$, $h = "2736,7"$, $s = "7,518"$; 140 °C: $v = "1,889"$, $h = "2756,7"$, $s = "7,567"$.

*Gesucht*

#enum(numbering: "a)",
[Den Endzustand nach der Drossel.],
[Die erzeugte Entropie je Sekunde.],
[Den Druck, bei dem der Dampf gerade trocken wäre.],
[Das nötige Durchmesserverhältnis.],
)
][
*Endzustand:* $h_2 = h_1 = "763,2" + "0,985" dot "2014,0" approx "2747,0" thin "kJ/kg" > h''(1 thin "bar")$: überhitzt. Interpoliert zwischen 130 und 140 °C, $f approx "0,514"$: $vartheta_2 approx "135,1" thin "°C"$, $v_2 approx "1,866" thin "m"^3/"kg"$, $s_2 approx "7,543" thin "kJ/(kg K)"$.
][
*Entropie:* $s_1 approx "6,517"$; $dot(m)(s_2 - s_1) approx 15 dot "1,026" approx "15,4" thin "kW/K"$.
][
*Trocken:* $h'' = "2747,0"$ zwischen 3,63 und 5,0 bar: $p^* approx "3,63" + "1,37" dot ("2747,0" - "2733,7")\/"14,4" approx "4,89" thin "bar"$. Nasserer Dampf muss tiefer gedrosselt werden, bis er trocken ist.
][
*Durchmesser:* $v_1 approx "0,19101" thin "m"^3/"kg"$; $d_2\/d_1 = sqrt("1,866"\/"0,19101") approx "3,13"$.
]

#aufgabe(titel: "Registerwärmestrom in der Gesamtbilanz", art: "verstehen", quelle: "3.11", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 283* #linebreak()]
Warum verschwindet der Registerwärmestrom aus der Gesamtbilanz des Lufterhitzers?
][
*Antwort:*

- Er liegt vollständig innerhalb der Grenze um Wasser, Luft und Lüfter.
- Was das Wasser abgibt, erhält die Luft mit dem entgegengesetzten Bilanzvorzeichen.
- In der Gesamtbilanz bleiben die Enthalpieänderungen beider Stoffströme und die von außen zugeführte Lüfterleistung.

#align(center)[#image("abbildungen/lufterhitzer-grenzen.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Zwei Stoffströme: Enthalpieänderungen gewichten", art: "verstehen", quelle: "3.11", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 284* #linebreak()]
Warum darf man bei zwei verschiedenen Stoffströmen die spezifischen Enthalpieänderungen nicht einfach addieren?
][
*Antwort:*

- Sie beziehen sich auf jeweils ein Kilogramm ihres eigenen Stoffes.
- Erst die Multiplikation mit dem jeweiligen Massenstrom ergibt vergleichbare Leistungen.
- Unterschiedliche Massenströme müssen deshalb bis zur Bildung dieser Enthalpieströme getrennt bleiben.

#align(center)[#image("abbildungen/lufterhitzer-grenzen.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Erst mit dem Massenstrom werden aus Größen je kg vergleichbare Leistungen.
]

#aufgabe(titel: "Adiabater Lufterhitzer: was trotzdem übertragen wird", art: "verstehen", quelle: "3.11", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 285* #linebreak()]
Ein Lufterhitzer ist nach außen adiabat. Welche Energieübertragungen sind trotzdem möglich, und wie fasst du die Enthalpieänderungen der beiden Stoffströme zusammen?
][
*Antwort:*

- Im Inneren überträgt Wasser Wärme an Luft. Die Adiabatie betrifft die äußere Gesamtgrenze und verhindert keinen inneren Austausch.
- Über die äußere Grenze wird Lüfterarbeit zugeführt. Adiabat bedeutet keine Wärmeübertragung; Arbeit ist eine andere Übertragungsform.
][
*Typische Verwechslung:*

- „Alle spezifischen Enthalpieänderungen werden ohne ihre Massenströme addiert.“: Verschiedene spezifische Bezüge müssen zuerst in vergleichbare extensive Leistungen umgerechnet werden.
]

#aufgabe(titel: "Lufterhitzer: Wasser, Luft und Lüfter gemeinsam bilanzieren", art: "rechnen", quelle: "3.11", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 3.2", minuten: 15,
 ergebnis: [$dot(Q)_"WL"=21$ kW; $vartheta_"L2" approx "35,5644"$ °C.],
 tipp: [Die Gesamtgrenze ist adiabat. Der Wärmestrom zwischen Wasser und Luft ist darin intern.])[
#if not web [*Aufgabe 286* #linebreak()]
*Gegeben und Annahmen:* Ü 3.2: Luftstrom 1600 kg/h, Eintritt −13 °C; zugeführte Lüfterleistung 0,8 kW. Wasserstrom 900 kg/h; Wasser kühlt von 90 °C mit $h_"W1"=377$ kJ/kg auf 70 °C mit $h_"W2"=293$ kJ/kg ab. Luft als ideales Gas mit konstantem $c_p="1,010"$ kJ/(kg K) wie in M32. Das Gesamtgerät ist nach außen adiabat; die Lüfterleistung gelangt vollständig zur Luftseite. Stationär, keine relevante Änderung von Bewegungs- und Lageenergie, keine Mischung der beiden Stoffe; 1 h = 3600 s.
#align(center)[#image("abbildungen/lufterhitzer-grenzen.svg", width: 100%)]
*Gesucht:*
#enum(numbering: "a)")[Bestimme den vom Wasser zur Luft übertragenen Wärmestrom.][Bestimme die Luft-Austrittstemperatur.][Kontrolliere das Ergebnis mit der Gesamtbilanz.]
#src[R30, PDF-S. 1–2; M32, PDF-S. 1; Ü 3.2, PDF-S. 20.]
][
*Wasserseite wählen:* $dot(m)_W=900/3600="0,25"$ kg/s. Für das Wasser ist der Wärmestrom eine Abgabe: $dot(m)_W(h_"W2"-h_"W1")=-dot(Q)_"WL"$. Daher $dot(Q)_"WL"=-"0,25"(293-377)=21$ kW in Richtung Luft.
][
*Luftseite bilanzieren:* $dot(m)_L=1600/3600=4/9$ kg/s. Die Luft erhält die Registerwärme und die Lüfterleistung: $dot(m)_L c_p(T_"L2"-T_"L1")=21+"0,8"="21,8"$ kW. Die beiden Massenströme sind verschieden und dürfen nicht vorzeitig gekürzt werden.
][
*Temperatur berechnen:* $Delta T_L="21,8"/((4/9)dot "1,010") approx "48,56436"$ K. Die Celsius-Temperaturdifferenz besitzt denselben Zahlenwert: $vartheta_"L2"=-13+"48,56436" approx "35,56436"$ °C. Gerundet sind das etwa 36 °C, wie in der Mitschrift.
][
*Gesamtgrenze als Kontrolle verwenden:* $dot(m)_W Delta h_W+dot(m)_L Delta h_L=-21+"21,8"="0,8"$ kW. Der interne Wärmestrom fällt heraus; nur die Lüfterarbeit kommt von außen hinzu. Das erklärt, warum ein nach außen adiabates Gesamtgerät im Inneren trotzdem Wärme überträgt.
]

#aufgabe(titel: "Lufterhitzer mit stärkerem Wasserstrom (Variante)", art: "rechnen", quelle: "3.11", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 3.2", minuten: 10,
  ergebnis: [$dot(Q)_"WL" = 28 thin "kW"$; $vartheta_"L2" approx "41,7" thin "°C"$])[
#if not web [*Aufgabe 287* #linebreak()]
*Gegeben und Annahmen*

Ein nach außen adiabater Lufterhitzer saugt 2000 kg/h Außenluft von −10 °C mit einem Lüfter von 1,0 kW an. Im Register kühlen 1200 kg/h Wasser von 90 °C ($h = 377 thin "kJ/kg"$) auf 70 °C ($h = 293 thin "kJ/kg"$) ab. Luft: $c_p = "1,010" thin "kJ/(kg K)"$; die Lüfterleistung geht ganz in die Luft; kinetische Energie vernachlässigt.

*Gesucht*

#enum(numbering: "a)",
[Den Wärmestrom vom Wasser an die Luft.],
[Die Austrittstemperatur der Luft.],
)
][
*Wasserseite:* $dot(m)_W = 1200\/3600 = "0,3333" thin "kg/s"$; $dot(Q)_"WL" = dot(m)_W (377 - 293) = 28 thin "kW"$.
][
*Luftseite:* $dot(m)_L c_p Delta T = 28 + "1,0" = 29 thin "kW"$ mit $dot(m)_L = "0,5556" thin "kg/s"$: $Delta T approx "51,7" thin "K"$, also $vartheta_"L2" approx "41,7" thin "°C"$. Probe Gesamtbilanz: $-28 + 29 = 1 thin "kW"$, genau die Lüfterleistung.
]

#aufgabe(titel: "Zwei Nassdampfströme isobar mischen", art: "rechnen", quelle: "3.11", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.17", minuten: 10,
  ergebnis: [$x approx "0,910"$; $h approx "2595,9" thin "kJ/kg"$; $vartheta = "179,89" thin "°C"$; $s approx "6,185" thin "kJ/(kg K)"$])[
#if not web [*Aufgabe 288* #linebreak()]
*Gegeben und Annahmen*

2 t Dampf pro Stunde mit einem Druck von 10 bar und einem Dampfgehalt von 88 % werden mit 1,5 t Dampf pro Stunde von ebenfalls 10 bar und einem Dampfgehalt von 95 % isobar und nach außen hin adiabat gemischt. Keine technische Arbeit, äußere Energien vernachlässigt.

Dampftafel Wasser bei 10 bar: $vartheta_s = "179,89" thin "°C"$, $v' = "1,1272" thin "dm"^3/"kg"$, $v'' = "0,1943" thin "m"^3/"kg"$, $h' = "762,7"$, $h'' = "2777,2" thin "kJ/kg"$, $s' = "2,138"$, $s'' = "6,585" thin "kJ/(kg K)"$.

*Gesucht*

#enum(numbering: "a)",
[Wie groß sind die spezifische Enthalpie, der Dampfgehalt, die Temperatur und die Entropie des Dampfstroms nach der Mischung?],
)
][
*Massen- und Energiebilanz:* $dot(m)_3 = "3,5" thin "t/h"$. Stationär, adiabat, ohne Arbeit: $dot(m)_3 h_3 = dot(m)_1 h_1 + dot(m)_2 h_2$. Weil $h$ im Nassdampf linear in $x$ ist, mischt sich auch der Dampfgehalt massengewichtet:
$ x_3 = (2 dot "0,88" + "1,5" dot "0,95")/"3,5" = "0,910" $
][
*Zustandsgrößen nach der Mischung:* Der Druck bleibt 10 bar, also liegt der Mischstrom bei $vartheta_3 = "179,89" thin "°C"$ im Nassdampfgebiet.
$ h_3 = "762,7" + "0,91" dot "2014,5" approx "2595,9" thin "kJ/kg" quad s_3 = "2,138" + "0,91" dot "4,447" approx "6,185" thin "kJ/(kg K)" $
Probe: Die Entropie des Gemisches ist hier gleich dem Mittel der Eintrittsentropien, weil beide Ströme dieselbe Temperatur haben. Die Mischung erzeugt keine Entropie.
]

#aufgabe(titel: "Nassdampfströme 3 und 1 t/h mischen (Variante)", art: "rechnen", quelle: "3.11", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.17", minuten: 8,
  ergebnis: [$x = "0,88"$; $h approx "2535,5" thin "kJ/kg"$; $s approx "6,051" thin "kJ/(kg K)"$])[
#if not web [*Aufgabe 289* #linebreak()]
*Gegeben und Annahmen*

3 t/h Nassdampf mit $x = "0,85"$ und 1 t/h mit $x = "0,97"$, beide bei 10 bar, werden isobar und adiabat gemischt. Dampftafel 10 bar: $vartheta_s = "179,89" thin "°C"$, $h' = "762,7"$, $h'' = "2777,2" thin "kJ/kg"$, $s' = "2,138"$, $s'' = "6,585" thin "kJ/(kg K)"$.

*Gesucht*

#enum(numbering: "a)",
[Dampfgehalt, Enthalpie, Temperatur und Entropie nach der Mischung.],
)
][
*Bilanz:* $x_3 = (3 dot "0,85" + 1 dot "0,97")\/4 = "0,88"$.
][
*Zustand:* $h_3 = "762,7" + "0,88" dot "2014,5" approx "2535,5" thin "kJ/kg"$, $s_3 = "2,138" + "0,88" dot "4,447" approx "6,051" thin "kJ/(kg K)"$, $vartheta_3 = "179,89" thin "°C"$.
]

#aufgabe(titel: "Dampfkochtopf: konstant und doch instationär", art: "verstehen", quelle: "3.12", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 290* #linebreak()]
Warum ist ein Dampfkochtopf bei konstantem Druck und konstanter Temperatur trotzdem instationär?
][
*Antwort:*

- Dampf strömt hinaus und die Masse im Topf nimmt ab.
- Die Stoffwerte der einzelnen Phasen bleiben bei gleichem Sättigungsdruck zwar konstant, aber ihre Mengen ändern sich.
- Daher ändern sich die gesamten Speichergrößen wie die innere Energie.

#align(center)[#image("abbildungen/kochtopf-phasen.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Gleiches p und T bedeuten nicht: gleicher Gesamtbestand.
][
*Bild:* Ein Topf kann bei gleicher Siedetemperatur immer leerer werden.
][
*Typische Verwechslung:*

- „Der Vorgang ist wegen konstantem p und T automatisch stationär.“: Die Masse im Kontrollraum nimmt ab; der Speicherterm bleibt in der instationären Bilanz.
]

#aufgabe(titel: "Dampfkochtopf: Massen- und Energiebilanz", art: "rechnen", quelle: "3.12", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 3.6", minuten: 25,
 ergebnis: [$dot(m)_"aus" approx "0,000237269"$ kg/s; $c approx "38,904"$ m/s; $w_"VS"="173,85"$ kJ/kg; $e_"aus" approx "2693,75675"$ kJ/kg; $dot(E)_"aus" approx "639,145"$ W; $Q_01 approx "1269,111"$ kJ; $dot(Q) approx "528,796"$ W; $P_"el" approx "1,000"$ kW.],
 tipp: [Der konstante Druck hält die Sättigungswerte gleich, aber nicht den gesamten Energiespeicher. Das verlorene Flüssigkeitsvolumen wird zum neuen Dampfraum.])[
#if not web [*Aufgabe 291* #linebreak()]
*Gegeben und Annahmen:* Ü 3.6: Im ansonsten adiabaten starren Dampfkochtopf werden bei konstantem Absolutdruck $p="0,15"$ MPa = 150 kPa in 40 min insgesamt 0,6 l Flüssigkeit verdampft. Der entstehende Dampf strömt durch das Überdruckventil; freier Durchmesser $d=3$ mm. Flüssigkeit und Dampf im Topf sind während des ganzen betrachteten Abschnitts im Sättigungsgleichgewicht; keine Zuströmung, keine technische Arbeit. Änderungen äußerer Speicherenergien, Lageenergien und Wärmekapazität des Topfes vernachlässigen. Konstanter Heiz- und Ausströmvorgang im vorgegebenen Modell. Den austretenden Dampf mit den angegebenen Sattdampfwerten beschreiben:
#tab(columns: (1fr, 1fr, 1fr), th([Größe], [Flüssigkeit ′], [Dampf ″]),
 [$v$ / m³/kg], [0,0010527], [1,159],
 [$h$ / kJ/kg], [467,1], [2693],
)
Gesamtwirkungsgrad der elektrischen Kochplatte bis zur Wärmezufuhr im Topf $eta_"ges"="0,5288"$. Er erfasst bereits die in der Originalaufgabe genannten Verluste. $u=h-p v$; $1$ l = $10^(-3)$ m³, $1$ mm = $10^(-3)$ m, $1$ kJ = 1000 J.
*Gesucht:*
#enum(numbering: "a)")[p-v-Zustandsweg und entweichender Massenstrom.][Geschwindigkeit am gewählten Austrittsquerschnitt.][Spezifische Ausströmverschiebearbeit.][Spezifische Gesamtenergie des austretenden Stoffstroms.][Ausströmender Energiestrom.][Zugeführte Wärme und zeitlich konstanter Wärmestrom.][Erforderliche elektrische Kochplattenleistung.]
#src[Ü 3.6, PDF-S. 21; M36, PDF-S. 1–3; Schema: eigene Darstellung.]
][
*System und Zustandsweg wählen:* Starr ist die äußere Grenze, offen und instationär ist ihr Inhalt. Der Druck und damit die Sättigungstemperatur bleiben gleich, solange beide Phasen vorhanden sind. Die Masse sinkt; daher wächst $v=V/m$. Im p-v-Diagramm bewegt sich der Restgemischzustand auf einer Isobare nach rechts innerhalb der Dampfglocke. Das ist keine geschlossene Isochore.
#align(center)[#image("abbildungen/kochtopf-phasen.svg", width: 85%)]
][
*Massenbilanz über beide Phasen aufstellen:* $Delta V'=-"0,0006"$ m³ und $Delta V''=+"0,0006"$ m³; $Delta t=2400$ s. Deshalb $Delta m'=Delta V'/v' approx -"0,569962952"$ kg und $Delta m''=Delta V''/v'' approx "0,000517688"$ kg. Die neu im Topf verbleibende Dampfmasse wird von der verdampften Flüssigkeitsmasse abgezogen:
$m_"aus"=-(Delta m'+Delta m'') approx "0,569445265"$ kg,
$dot(m)_"aus"=m_"aus"/2400 approx "2,37268860" dot 10^(-4)$ kg/s.
Nur $-Delta m'$ zu verwenden, würde den kleinen Zuwachs des Dampfinhalts übersehen.
][
*Kontinuität für den Querschnitt nutzen:* $A=pi("0,003" thin "m")^2/4 approx "7,06858" dot 10^(-6)$ m². Mit $dot(V)_"aus"=dot(m)_"aus"v''$ folgt $c=dot(m)_"aus"v''/A approx "38,903779"$ m/s. Einheiten: kg/s mal m³/kg geteilt durch m² ergibt m/s. Die Sattdampfwerte gehören zum gewählten Querschnitt des Aufgabenmodells; ein weiterer Druckabbau außerhalb dieser Grenze ist hier nicht berechnet.
][
*Verschiebearbeit einordnen:* Beim Austritt muss der Stoff gegen den Druck über die Grenze geschoben werden. Der positive Abgabebetrag je kg ist $w_"VS,aus"=p v''=150 thin "kPa" dot "1,159" thin "m"^3/"kg"="173,85"$ kJ/kg. In einer reinen Zufuhrbilanz wäre diese Abgabe negativ. Der Beitrag ist in der Enthalpie bereits enthalten.
][
*Energie je kg und Energiestrom trennen:* Bei vernachlässigter Lageenergie ist $e_"aus"=h''+c^2/2$. Der Geschwindigkeitsanteil beträgt $c^2/2 approx "756,752"$ J/kg $= "0,756752"$ kJ/kg. Somit $e_"aus" approx "2693,756752"$ kJ/kg. Nicht zusätzlich noch einmal $p v''$ addieren! Mit dem Massenstrom folgt $dot(E)_"aus"=dot(m)_"aus"e_"aus" approx "0,639144595"$ kJ/s $= "639,144595"$ W. In 2400 s verlassen damit $E_"aus" approx "1533,947027"$ kJ die Grenze.
][
*Speicheränderung ausdrücklich berechnen:* Die Phasen haben unveränderte Stoffwerte, aber veränderte Massen. Aus $u'=h'-p v'="466,942095"$ und $u''=h''-p v''="2519,15"$ kJ/kg folgt
$Delta U=Delta m' u'+Delta m''u'' approx -"264,835562"$ kJ.
Kontrolle: Wegen des gleichen gesamten pV liefert auch $Delta H=Delta m'h'+Delta m''h''$ denselben Wert. Die Speicheränderung je Zeit ist etwa −110,348151 W; konstantes p und T machen den entleerenden Topf nicht stationär.
][
*Instationäre Energiebilanz lösen:* $Delta U=Q_01-E_"aus"$. Daher $Q_01=Delta U+E_"aus" approx -"264,835562"+"1533,947027"="1269,111465"$ kJ und $dot(Q)=Q_01/2400 approx "528,796444"$ W. Der austretende Energiestrom ist größer als der Wärmestrom, weil zusätzlich gespeicherte Energie mit dem Stoff abgegeben wird. M36 rundet den Massenstrom früh auf 2,373 · 10⁻⁴ kg/s und erhält 528,852 W bzw. 1269,244 kJ; wir behalten ungerundete Zwischenwerte bei.
][
*Unabhängig prüfen und Kochplatte bestimmen:* Die verdampfte Flüssigkeit braucht $(-Delta m')(h''-h') approx "1268,680536"$ kJ. Dazu kommt die mit dem austretenden Dampf abgeführte Bewegungsenergie $m_"aus" c^2/2 approx "0,430929"$ kJ. Zusammen sind das wieder 1269,111465 kJ. Für die Kochplatte ist der Nutzen die Wärmezufuhr im Topf:
$P_"el"=dot(Q)/eta_"ges"="528,796444"/"0,5288" approx "999,993"$ W $approx 1$ kW.
Einheiten und Bilanz schließen; der Gesamtwirkungsgrad wird genau einmal berücksichtigt.
]

#aufgabe(titel: "Austretende Dampfmasse und verschwundene Flüssigkeit", art: "verstehen", quelle: "3.12.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 292* #linebreak()]
Warum ist die ausströmende Dampfmasse etwas kleiner als die verschwundene Flüssigkeitsmasse?
][
*Antwort:*

- Der sinkende Flüssigkeitsspiegel schafft zusätzlichen Dampfraum.
- Ein kleiner Teil der verdampften Masse bleibt im Topf und füllt diesen Raum.
- Nur der übrige Dampf überquert die äußere Grenze.

#align(center)[#image("abbildungen/kochtopf-phasen.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „Der Rest wird beim Verdampfen vernichtet.“: Gesamtmasse bleibt erhalten. Sie verteilt sich auf den Restbestand und die ausgetretene Masse.
- „Weil ein starrer Topf grundsätzlich keine Masse abgeben kann.“: Starr beschreibt die Geometrie. Das offene Ventil erlaubt weiterhin Stoffaustausch.
]

#aufgabe(titel: "Energiestrom größer als die Heizleistung", art: "verstehen", quelle: "3.12.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 293* #linebreak()]
Warum kann der ausströmende Energiestrom eines Dampfkochtopfs größer als seine Heizleistung sein?
][
*Antwort:*

- Die gespeicherte innere Energie im Topf nimmt ab.
- Der ausströmende Stoff trägt deshalb sowohl die zugeführte Energie als auch Energie aus dem sinkenden Bestand hinaus.
- Die Bilanz lautet $dot(Q)=frac(dif U_"Sys",dif t)+dot(E)_"aus"$
- bei negativer Speicheränderung ist die Heizleistung kleiner als der ausströmende Energiestrom.

#align(center)[#image("abbildungen/kochtopf-energie.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Verschiebearbeit steckt schon in h", art: "verstehen", quelle: "3.12.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 294* #linebreak()]
Warum wird beim Dampfaustritt die Verschiebearbeit nicht zusätzlich zur Enthalpie addiert?
][
*Antwort:*

- Die Enthalpie enthält bereits innere Energie und Druck-Volumen-Anteil: $h=u+p v$.
- Die mitgeführte Energie ist bei vernachlässigter Lageenergie deshalb $e=h+c^2/2$.
- Wer noch einmal $p v$ addiert, zählt dieselbe Verschiebearbeit doppelt.

#align(center)[#image("abbildungen/kochtopf-energie.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* h enthält pv bereits: nicht doppelt zählen.
][
*Typische Verwechslung:*

- „$e_"aus"=h''+p v''+c^2/2$“: Das zählt die Verschiebearbeit doppelt, denn $h''=u''+p v''$.
- „$e_"aus"=u''$ unabhängig von Druck und Strömungsgeschwindigkeit.“: Dann fehlen die Verschiebearbeit und die Bewegungsenergie des austretenden Stoffes.
]

#aufgabe(titel: "Heizleistung aus Energiestrom und Speicheränderung", art: "verstehen", quelle: "3.12.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 295* #linebreak()]
Der ausströmende Energiestrom beträgt rund 639 W, die Speicheränderung im Topf −110 W. Welche Heizleistung folgt ohne weitere Arbeit? Begründe deine Antwort.
][
*Antwort:* Rund 529 W

$dot(Q)=frac(dif U,dif t)+dot(E)_"aus"$. Ein Teil der Austrittsenergie stammt aus dem abnehmenden Speicher.
][
*Typische Verwechslung:*

- „Rund 749 W“: Hier wird die negative Speicheränderung als positive zusätzliche Anforderung behandelt; das Vorzeichen ist vertauscht.
- „Rund 639 W, weil der Speicher bei konstantem Druck immer gleich bleibt.“: Druckkonstanz macht den entleerenden Topf nicht stationär. Der Speicherterm darf nicht gestrichen werden.
]

#kapitel("Kapitel 4 · Zweiter Hauptsatz und Zustandsdiagramme")

#aufgabe(titel: "Altklausur WS 01/02: Kurzfrage 7", art: "verstehen", quelle: "4.1", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 01/02, Kurzfrage 7 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 296* #linebreak()]
Wann ist in der Thermodynamik ein Prozess reversibel?
][
*Antwort:* Ein reversibler Prozess lässt sich so umkehren, dass System und gesamte Umgebung gemeinsam in den Anfangszustand zurückkehren, ohne bleibende Änderungen. Es wird keine Entropie erzeugt. Quasistatik allein genügt nicht, wenn etwa Reibung auftritt.
]

#aufgabe(titel: "Altklausur Übungsklausur WS 99/00: Kurzfrage 6", art: "verstehen", quelle: "4.1", herkunft: "original", minuten: 3, vorlage: "Altklausur Übungsklausur WS 99/00, Kurzfrage 6 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 297* #linebreak()]
Ist ein Kreisprozess grundsätzlich reversibel, wenn die Entropie des Arbeitsmittels nach allen Zustandsänderungen ihren Ausgangswert wieder erreicht? Begründe.
][
*Antwort:* Nach jedem stationär wiederholten Kreisprozess kehrt der Arbeitsstoff in denselben Zustand und damit zu derselben Entropie zurück. Das gilt auch bei Irreversibilität: Erzeugte Entropie wird an die Umgebung abgegeben. Reversibilität verlangt zusätzlich, dass für System plus Umgebung keine Entropie erzeugt wird.
]

#aufgabe(titel: "Energieerhaltung reicht nicht", art: "verstehen", quelle: "4.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 298* #linebreak()]
Warum reicht die Energieerhaltung allein nicht aus, um einen Prozess als möglich zu beurteilen?
][
*Antwort:*

- Sie verlangt den Ausgleich aller Energiebeiträge, legt aber die mögliche Richtung noch nicht vollständig fest.
- Ein Rührer kann Fluid erwärmen
- Abkühlen allein hebt das antreibende Gewicht nicht wieder an.
- Der zweite Hauptsatz prüft zusätzlich Irreversibilität und Entropieerzeugung.

#align(center)[#image("abbildungen/joule-prozess.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „Weil beim Rühren Energie vernichtet wird.“: Die Arbeit erhöht die innere Energie. Energie wird nicht vernichtet.
- „Weil ein Fluid überhaupt keine Arbeit abgeben kann.“: Fluide können in passenden Prozessen Arbeit abgeben. Hier ist die behauptete selbsttätige Umkehr das Problem.
]

#aufgabe(titel: "Reversibilität mit Umgebung prüfen", art: "verstehen", quelle: "4.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 299* #linebreak()]
Warum muss man bei Reversibilität die Umgebung mitbetrachten?
][
*Antwort:*

- Reversibel wäre eine gemeinsame Rückkehr von System und Umgebung ohne bleibende Änderung.
- Dass nur das System wieder denselben Zustand erreicht, genügt nicht.
- Die dafür eingesetzte Arbeit oder Wärme kann die Umgebung dauerhaft verändert haben.

#align(center)[#image("abbildungen/joule-prozess.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „Ja; allein der Systemzustand entscheidet.“: Damit würde gerade die für die Rückführung veränderte Umgebung ausgeblendet.
- „Ja; sobald der Prozess nur langsam genug ablief.“: Langsamkeit beseitigt vorhandene Reibung oder andere Irreversibilitäten nicht automatisch.
]

#aufgabe(titel: "Kurzfrage: Wann die Entropie eines Systems abnehmen kann", art: "verstehen", quelle: "4.2", herkunft: "original", vorlage: "Leistungsnachweis SS 14, Kurzfrage 14", minuten: 3)[
#if not web [*Aufgabe 300* #linebreak()]
Unter welchen Bedingungen kann die Entropie eines Systems abnehmen?
][
*Antwort:* Wenn mit abgeführter Wärme oder mit austretender Masse mehr Entropie hinausgeht, als im Inneren erzeugt wird und zufließt. Beispiel: Ein abkühlender Körper gibt Wärme ab, seine Entropie sinkt.
][
*Warum das kein Widerspruch ist:* Der zweite Hauptsatz verlangt nur $S_"irr" >= 0$. Die Entropie eines einzelnen offenen oder wärmedurchlässigen Systems darf sinken; die Umgebung nimmt dann mindestens so viel auf.
]

#aufgabe(titel: "Altklausur WS 02/03: Kurzfrage 12", art: "verstehen", quelle: "4.2", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 02/03, Kurzfrage 12 (Import 12.11.2026, PDF-S. 2)")[
#if not web [*Aufgabe 301* #linebreak()]
Durch welche Vorgänge ändert sich die Entropie in einem System?
][
*Antwort:* Wärme transportiert Entropie über die Grenze; Stoffströme tragen sie mit sich; Irreversibilität erzeugt sie im Inneren. Entropie des Systems kann sinken, wenn mehr abgeführt als erzeugt bzw. zugeführt wird. Die Erzeugung selbst bleibt nichtnegativ.
]

#aufgabe(titel: "Altklausur WS 01/02: Kurzfrage 12", art: "verstehen", quelle: "4.2", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 01/02, Kurzfrage 12 (Import 12.11.2026, PDF-S. 2)")[
#if not web [*Aufgabe 302* #linebreak()]
Wie kann die Entropie eines abgeschlossenen Systems, das sich im Gleichgewicht befindet, verändert werden?
][
*Antwort:* Ein abgeschlossenes System tauscht weder Masse noch Energie mit der Umgebung aus. Im stabilen thermodynamischen Gleichgewicht hat es für die gegebenen Randbedingungen maximale Entropie. Ohne Änderung dieser Randbedingungen lässt sich seine Entropie nicht weiter verändern.
]

#aufgabe(titel: "Altklausur WS 00/01: Kurzfrage 6", art: "verstehen", quelle: "4.2", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 00/01, Kurzfrage 6 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 303* #linebreak()]
Unter welchen Bedingungen kann die Entropie eines Systems abnehmen?
][
*Antwort:* Wärme transportiert Entropie über die Grenze; Stoffströme tragen sie mit sich; Irreversibilität erzeugt sie im Inneren. Entropie des Systems kann sinken, wenn mehr abgeführt als erzeugt bzw. zugeführt wird. Die Erzeugung selbst bleibt nichtnegativ.
]

#aufgabe(titel: "Altklausur WS 99/00 LN: Kurzfrage 6", art: "verstehen", quelle: "4.2", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 99/00 LN, Kurzfrage 6 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 304* #linebreak()]
In welchem thermodynamischen System kann die gesamte Entropie niemals abnehmen? Warum gilt das nicht für jedes geschlossene oder offene System?
][
*Antwort:* In einem abgeschlossenen System nimmt die gesamte Entropie niemals ab: $Delta S=S_"erz">=0$. Geschlossene Systeme können bei Wärmeabfuhr Entropie verlieren, offene zusätzlich mit Stoffabfuhr. Für spezifisches s in einem offenen System folgt aus einer positiven Gesamterzeugung allein kein pauschales Monotoniegesetz.
]

#aufgabe(titel: "Altklausur Übungsklausur WS 99/00: Kurzfrage 5", art: "verstehen", quelle: "4.2", herkunft: "original", minuten: 3, vorlage: "Altklausur Übungsklausur WS 99/00, Kurzfrage 5 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 305* #linebreak()]
Verlangt der zweite Hauptsatz bei jeder Zustandsänderung, dass die Entropie des betrachteten Systems zunimmt oder gleichbleibt? Begründe.
][
*Antwort:* Wärme transportiert Entropie über die Grenze; Stoffströme tragen sie mit sich; Irreversibilität erzeugt sie im Inneren. Entropie des Systems kann sinken, wenn mehr abgeführt als erzeugt bzw. zugeführt wird. Die Erzeugung selbst bleibt nichtnegativ.
]

#aufgabe(titel: "Wege der Entropieänderung", art: "verstehen", quelle: "4.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 306* #linebreak()]
Wodurch kann sich die Entropie eines Systems ändern?
][
*Antwort:*

- Entropie kann mit Wärme und bei offenen Systemen mit Stoff über die Grenze transportiert werden.
- Außerdem kann sie im Inneren durch irreversible Vorgänge entstehen.
- Eine Speicheränderung ist deshalb nicht automatisch gleich der Erzeugung.

#align(center)[#image("abbildungen/entropie-bilanz.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Entropieänderung = Transport plus Erzeugung.
]

#aufgabe(titel: "Kurzfrage: Entropie im geschlossenen System konstant halten", art: "verstehen", quelle: "4.2.1", herkunft: "original", vorlage: "Leistungsnachweis WS 11/12, Aufg. 0f", minuten: 3)[
#if not web [*Aufgabe 307* #linebreak()]
Was ist zu tun, um die Entropie in einem geschlossenen System konstant zu halten, in dem $alpha$) ausschließlich reversible Prozesse ablaufen; $beta$) irreversible Prozesse ablaufen? $gamma$) Wenn nach $beta$) die Entropie im System konstant bleibt: Wie kann man rechnerisch zeigen, dass es sich insgesamt doch um einen irreversiblen Prozess handelt?
][
*Entropiebilanz:* $Delta S = integral (dif Q)\/T + S_"irr"$ mit $S_"irr" >= 0$.
][
*$alpha$) reversibel:* $S_"irr" = 0$. Die Entropie bleibt konstant, wenn netto kein Entropietransport mit Wärme stattfindet, also adiabat (oder $integral dif Q\/T = 0$).
][
*$beta$) irreversibel:* Die erzeugte Entropie muss mit Wärme abgeführt werden: $integral dif Q\/T = -S_"irr" < 0$.
][
*$gamma$) Nachweis:* System und Umgebung gemeinsam bilanzieren. Die Umgebung nimmt die Wärme auf und gewinnt Entropie $-Q\/T_U > 0$; die Gesamtentropie steigt um $S_"irr" > 0$. Das zeigt die Irreversibilität.
]

#aufgabe(titel: "Kurzfrage: Entropie eines abgeschlossenen Systems im Gleichgewicht ändern", art: "verstehen", quelle: "4.2.1", herkunft: "original", vorlage: "Leistungsnachweis WS 19/20, Aufg. 0e", minuten: 3)[
#if not web [*Aufgabe 308* #linebreak()]
Durch welche Maßnahmen kann die Entropie eines abgeschlossenen Systems, das sich im Gleichgewicht befindet, verändert werden?
][
*Antwort:* Nur indem man die Abgeschlossenheit aufhebt: durch Wärme- oder Stoffaustausch mit der Umgebung. Mit abgeführter Wärme oder austretender Masse sinkt die Entropie, mit Zufuhr steigt sie.
][
*Warum sonst nichts geht:* Im Gleichgewicht laufen keine irreversiblen Ausgleichsvorgänge mehr ab, $S_"irr" = 0$; die Entropie hat ihr Maximum erreicht. Arbeit allein ist in einem abgeschlossenen System ausgeschlossen.
]

#aufgabe(titel: "Wann die Entropie nie abnimmt", art: "verstehen", quelle: "4.2.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 309* #linebreak()]
Unter welchen Bedingungen darf die Entropie eines Systems niemals abnehmen?
][
*Antwort:*

- Für ein adiabates geschlossenes System kann die Gesamtentropie nur zunehmen oder im reversiblen Grenzfall gleich bleiben.
- Bei Wärmeabgabe darf seine Entropie dagegen sinken.
- Bei Stoffaustausch muss zusätzlich der Entropietransport mit der Masse bilanziert werden.

#align(center)[#image("abbildungen/map-entropie.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Typische Verwechslung:*

- „Bei jedem starren System, unabhängig von Wärme- und Stoffaustausch.“: Starrheit allein verhindert diese Entropietransporte nicht.
- „Bei jedem offenen System allein wegen der Durchströmung.“: Offene Systeme müssen den mit Masse transportierten Entropiestrom mitbilanzieren.
]

#aufgabe(titel: "Was über Entropie immer gilt", art: "verstehen", quelle: "4.2.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 310* #linebreak()]
Welche Aussage über die Entropie gilt ohne jede weitere Einschränkung, und warum gelten viele ähnlich klingende Aussagen nicht allgemein?
][
*Antwort:* Die innere Entropieerzeugung ist nichtnegativ.

Transport kann die Systementropie senken; die Erzeugung im Inneren wird dadurch nicht negativ.
][
*Typische Verwechslung:*

- „Die Entropie jedes einzelnen Systems steigt bei jedem Vorgang.“: Ein System kann durch Wärme- oder Stoffabgabe Entropie verlieren.
- „Wärmeabgabe erzeugt grundsätzlich negative Entropie.“: Wärmeabgabe ist ein negativer Transportbeitrag, keine negative innere Erzeugung.
]

#aufgabe(titel: "Bremsender Wagen: Entropiezunahme der Umgebung", art: "rechnen", quelle: "4.2.1", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.1 (Entropieteil)", minuten: 6,
  ergebnis: [$Q approx 289 thin "kJ"$; $Delta S approx "1,06" thin "kJ/K"$])[
#if not web [*Aufgabe 311* #linebreak()]
*Gegeben und Annahmen*

Ein Wagen von 1 t Masse wird gebremst, wobei seine Geschwindigkeit von 100 km/h auf 50 km/h abnimmt. Die entwickelte Reibungswärme strömt an die Umgebung, deren Temperatur 0 °C beträgt. Bremsen und Wagen sind danach wieder im Ausgangszustand; die Umgebung ist so groß, dass ihre Temperatur konstant bleibt.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist die Entropiezunahme bei diesem Vorgang?],
)
][
*Energie:* Die Bewegungsenergie, die der Wagen verliert, wird über Reibung zu innerer Energie der Bremsen und strömt als Wärme an die Umgebung:
$ Q = m/2 (w_1^2 - w_2^2) = 500 dot ("27,78"^2 - "13,89"^2) thin "J" approx 289 thin "kJ" $
][
*Entropie:* Wagen und Bremsen enden im Ausgangszustand, ihre Entropie ändert sich nicht. Die Umgebung nimmt $Q$ bei konstanter Temperatur auf:
$ Delta S = Q/T_infinity = "289,35"/"273,15" thin "kJ/K" approx "1,06" thin "kJ/K" $
Diese Entropie ist im Bremsvorgang erzeugt worden: Geordnete Bewegung wurde ungeordnete Molekülbewegung, und das lässt sich nicht von selbst umkehren.
]

#aufgabe(titel: "Bremsender Transporter bei 20 Grad (Variante)", art: "rechnen", quelle: "4.2.1", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.1 (Entropieteil)", minuten: 5,
  ergebnis: [$Q approx 781 thin "kJ"$; $Delta S approx "2,67" thin "kJ/K"$])[
#if not web [*Aufgabe 312* #linebreak()]
*Gegeben und Annahmen*

Ein Transporter mit 1,5 t wird von 120 km/h auf 30 km/h abgebremst. Die Reibungswärme geht an die Umgebung mit konstant 20 °C; die Bremsen kühlen wieder auf ihren Anfangszustand ab.

*Gesucht*

#enum(numbering: "a)",
[Die an die Umgebung abgegebene Wärme.],
[Die erzeugte Entropie.],
)
][
*Wärme:* $Q = 750 dot ("33,33"^2 - "8,33"^2) thin "J" approx 781 thin "kJ"$.
][
*Entropie:* $Delta S = Q\/T_infinity = 781\/"293,15" thin "kJ/K" approx "2,67" thin "kJ/K"$. Bei wärmerer Umgebung erzeugt dieselbe Wärme etwas weniger Entropie, weil sie durch ein größeres $T$ geteilt wird.
]

#aufgabe(titel: "Wärme von 500 auf 20 Grad: Entropie der Übertragung", art: "rechnen", quelle: "4.2.1", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.4 a", minuten: 5,
  ergebnis: [$Delta S_"ges" approx +"2,12" thin "kJ/K"$])[
#if not web [*Aufgabe 313* #linebreak()]
*Gegeben und Annahmen*

Von einem sehr großen Behälter mit der konstanten Temperatur $vartheta_B = 500 thin "°C"$ fließen $abs(Q_B) = 1000 thin "kJ"$ Wärme an die Umgebung der Temperatur $vartheta_infinity = 20 thin "°C"$. Beide Temperaturen bleiben konstant.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist die gesamte Entropieänderung durch diesen Wärmeübergang?],
)
][
*Zwei Wärmespeicher:* Bei konstanter Temperatur ist $Delta S = Q\/T$. Der Behälter gibt ab, die Umgebung nimmt auf:
$ Delta S_B = -1000/"773,15" thin "kJ/K" approx -"1,293" thin "kJ/K" quad Delta S_infinity = 1000/"293,15" thin "kJ/K" approx +"3,411" thin "kJ/K" $
][
*Summe:* $Delta S_"ges" approx +"2,12" thin "kJ/K"$. Dieselbe Wärme bringt bei tiefer Temperatur mehr Entropie mit als sie bei hoher Temperatur abführt; darum läuft Wärme von selbst nur von warm nach kalt.
]

#aufgabe(titel: "Wärme von 800 auf 25 Grad (Variante)", art: "rechnen", quelle: "4.2.1", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.4 a", minuten: 4,
  ergebnis: [$Delta S_"ges" approx +"4,84" thin "kJ/K"$])[
#if not web [*Aufgabe 314* #linebreak()]
*Gegeben und Annahmen*

Ein großer Speicher mit konstant 800 °C gibt 2000 kJ Wärme an die Umgebung mit konstant 25 °C ab.

*Gesucht*

#enum(numbering: "a)",
[Die gesamte Entropieänderung.],
)
][
*Bilanz:* $Delta S = -2000\/"1073,15" + 2000\/"298,15" thin "kJ/K" approx -"1,864" + "6,708" approx +"4,84" thin "kJ/K"$. Größeres Temperaturgefälle und mehr Wärme: deutlich mehr Entropieerzeugung als im Original.
]

#aufgabe(titel: "Entropieerzeugung in der stationären Turbine", art: "verstehen", quelle: "4.2.2", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 315* #linebreak()]
Warum kann in einer stationären adiabaten Turbine Entropie erzeugt werden, obwohl im Gerät nichts gespeichert wird?
][
*Antwort:*

- Stationär bleibt der Entropiespeicher zeitlich gleich.
- Die im Inneren erzeugte Entropie kann laufend mit dem austretenden Stoff abgeführt werden.
- Dann besitzt der austretende Stoff eine größere spezifische Entropie als der eintretende.

#align(center)[#image("abbildungen/entropie-bilanz.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Stationär heißt nicht: keine Entropieerzeugung.
][
*Typische Verwechslung:*

- „Die Entropie im Gerät muss immer weiter anwachsen.“: Stationär bleibt der Speicher gleich; Erzeugung und Abtransport können sich ausgleichen.
- „Die Entropieerzeugung muss null sein, weil die Turbine adiabat ist.“: Adiabat streicht den Wärme-Entropietransport und verbietet keine innere Erzeugung.
]

#aufgabe(titel: "Kurzfrage: Aussagen der Gibbs'schen Fundamentalgleichung", art: "verstehen", quelle: "4.2.3", herkunft: "original", vorlage: "Leistungsnachweis WS 11/12, Aufg. 0e", minuten: 3)[
#if not web [*Aufgabe 316* #linebreak()]
Welche Aussagen liefert die Gibbs'sche Fundamentalgleichung?
][
*Gleichung:* $T thin dif s = dif u + p thin dif v = dif h - v thin dif p$.
][
*Aussagen:* Sie verknüpft die Entropie mit messbaren bzw. berechenbaren Zustandsgrößen. Weil sie nur Zustandsgrößen enthält, gilt sie für jede Zustandsänderung zwischen Gleichgewichtszuständen, auch für irreversible; man integriert dazu über einen gedachten reversiblen Ersatzweg. Für reversible Prozesse folgt $dif q = T thin dif s$.
]

#aufgabe(titel: "Gibbs'sche Fundamentalgleichung", art: "verstehen", quelle: "4.2.3", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 317* #linebreak()]
Was verbindet die Gibbs'sche Fundamentalgleichung?
][
*Antwort:*

- Verbindet *Temperatur und Entropieänderung* mit Änderungen anderer Zustandsgrößen.
- Möglich sind die Paare *innere Energie und Volumen* oder *Enthalpie und Druck*.
- Für einen einfachen kompressiblen Stoff:
$ T dif s=dif u+p dif v=dif h-v dif p $
- Das ist eine Zustandsbeziehung; der tatsächliche Prozess muss dafür nicht reversibel gewesen sein.

#align(center)[#image("abbildungen/map-entropie.svg", width: 100%, height: 55mm, fit: "contain")]
]

#aufgabe(titel: "Kelvin und absolute Drücke in der Entropie", art: "verstehen", quelle: "4.3.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 318* #linebreak()]
Warum müssen in Entropieformeln Kelvin und absolute Drücke verwendet werden?
][
*Antwort:*

- Die Logarithmen vergleichen absolute Zustandsgrößen.
- Ein Quotient von Celsius-Temperaturen oder von Überdrücken ist kein entsprechendes absolutes Verhältnis.
- Deshalb kann er auch bei scheinbar plausiblen Zahlen eine falsche Entropiedifferenz liefern.
][
*Typische Verwechslung:*

- „Celsius-Temperaturen und Überdrücke reichen grundsätzlich aus.“: Ihre Quotienten sind im Allgemeinen andere Zahlenverhältnisse und liefern falsche Logarithmen.
- „Beliebige gemischte Druckeinheiten, solange die Zahlen positiv sind.“: Die Einheiten müssen sich innerhalb jedes Verhältnisses kürzen.
]

#aufgabe(titel: "Abkühlender Stahlblock und zweiter Hauptsatz", art: "verstehen", quelle: "4.3.1", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 319* #linebreak()]
Warum verletzt die sinkende Entropie eines abkühlenden Stahlblocks nicht den zweiten Hauptsatz?
][
*Antwort:*

- Der Block gibt Wärme und damit Entropie an die Umgebung ab.
- Seine Entropie darf deshalb sinken, weil er nicht adiabat ist.
- Beim vollständigen Vergleich erhält die Umgebung mehr Entropie, als der Block verliert
- die positive Gesamtänderung zeigt die Irreversibilität.
][
*Typische Verwechslung:*

- „Nur das Vorzeichen der Blockentropie.“: Die negative Änderung eines nichtadiabaten Teilsystems ist für sich kein Verstoß.
- „Nur der Energieausgleich; Entropie ist dafür überflüssig.“: Gleiche Energiebeträge bei Abgabe und Aufnahme sagen noch nicht, ob ein Prozess reversibel ist.
]

#aufgabe(titel: "Stirlingluft: isotherme Verdichtung mit Dissipation", art: "rechnen", quelle: "4.3.1", herkunft: "original", vorlage: "Vorlesung 4.11., Aufg. IV-1", minuten: 15,
 ergebnis: [$Delta S approx -"0,606738"$ J/K; $W_12=240$ J, $W_v=190$ J; $p_2 approx 4$ bar absolut; $S_"erz" approx "0,159668"$ J/K.],
 tipp: [Beim idealen Gas ist isotherm $Delta U=0$. Die gesamte Arbeit enthält auch die dissipierten 50 J.])[
#if not web [*Aufgabe 320* #linebreak()]
*Gegeben und Annahmen:* N04, IV-1: $m="1523,917"$ mg ideale Luft wird bei 40 °C von $p_1=1$ bar absolut isotherm verdichtet. Dissipationsarbeit $J_12=50$ J; an der Systemgrenze werden 240 J Wärme abgeführt, also $Q_12=-240$ J. Geschlossene konstante Masse, quasistatisches Volumenarbeitsmodell, keine Änderung äußerer Energien. Konstantes $R="287,2"$ J/(kg K); $T="313,15"$ K. $1$ mg = $10^(-6)$ kg und $1$ bar = $10^5$ Pa. Das Folienmodell schreibt $Delta S=(Q_12+J_12)/T$ und $W_12=W_v+J_12$.

*Gesucht:*
#enum(numbering: "a)")[Berechne die gesamte und spezifische Entropieänderung.][Bestimme die zugeführte Gesamtarbeit und ihren Volumenarbeitsanteil.][Bestimme den Enddruck.][Kontrolliere die Entropiedifferenz aus den Zustandsgrößen und erkläre ihr negatives Vorzeichen trotz positiver Erzeugung.]
#src[N04, PDF-S. 10, IV-1; Stoffkonstante N28, PDF-S. 4 beziehungsweise BT A.4, S. 482 / PDF-S. 497.]
][
*Masse und Temperatur absolut einsetzen:* $m="0,001523917"$ kg und $T="313,15"$ K. Für das isotherme ideale Gas ist $Delta U=0$, unabhängig davon, dass zusätzlich Dissipation auftritt.
][
*Entropie aus den Prozessbeiträgen berechnen:* $Delta S=(-240+50)/"313,15" approx -"0,606737985"$ J/K. Die spezifische Änderung ist $Delta s=Delta S/m approx -"398,14372"$ J/(kg K). Der Wärme-Entropieabfluss überwiegt die positive Erzeugung $S_"erz"=50/"313,15" approx "0,15966789"$ J/K.
][
*Arbeit mit dem ersten Hauptsatz bestimmen:* $0=Q_12+W_12$ ergibt $W_12=+240$ J. Davon sind 50 J Dissipationsarbeit. Somit $W_v=W_12-J_12=190$ J. Nur diese 190 J werden im Volumenarbeitsintegral zur Verdichtung verwendet.
][
*Enddruck aus der Volumenarbeit berechnen:* Für den isothermen idealen Gasweg gilt $W_v=m R T ln(p_2/p_1)$. Daher $p_2=p_1 exp(W_v/(m R T)) approx "4,00000"$ bar absolut. Würden fälschlich 240 J statt 190 J in das Integral gesetzt, wäre der berechnete Druck zu groß.
][
*Entropie über den Zustand kontrollieren:* Isotherm ist $Delta s=-R ln(p_2/p_1) approx -"287,2" ln(4) approx -"398,14372"$ J/(kg K). Mit m folgt dieselbe Gesamtänderung. $Delta S<0$ verletzt den zweiten Hauptsatz nicht: Die Luft ist nicht adiabat; Wärme und Entropie verlassen sie. Die innere Erzeugung bleibt positiv.
]

#aufgabe(titel: "Abkühlender Stahlblock: Entropie von Block und Umgebung", art: "rechnen", quelle: "4.3.1", herkunft: "original", vorlage: "Vorlesung 4.11., Aufg. IV-2", minuten: 12,
 ergebnis: [$vartheta_2=499$ °C; $Delta S_"Block" approx -"10,19208"$ kJ/K; $Delta S_"Umgebung" approx "26,88044"$ kJ/K; $Delta S_"gesamt" approx "16,68836"$ kJ/K, irreversibel.],
 tipp: [Die Umgebung wird als großes Reservoir bei konstanter Temperatur modelliert; der Block kühlt sich ab.])[
#if not web [*Aufgabe 321* #linebreak()]
*Gegeben und Annahmen:* N04, IV-2: Stahlblock mit Volumen 1 m³, Masse 7880 kg und konstanter Wärmekapazität $c="0,5"$ kJ/(kg K). Anfangstemperatur 501 °C; er gibt 7880 kJ Wärme an die große Umgebung bei konstant 20 °C ab. Block näherungsweise inkompressibel; keine Arbeit, keine Änderung äußerer Energien. $T_1="774,15"$ K und $T_"Umg"="293,15"$ K. Das betrachtete Gesamtsystem aus Block und Reservoir tauscht im Modell keine weitere Energie oder Entropie aus.

*Gesucht:*
#enum(numbering: "a)")[Berechne die Endtemperatur des Blocks.][Bestimme seine spezifische und gesamte Entropieänderung.][Berechne die Änderung der Umgebungsentropie.][Bilde die Gesamtänderung und beurteile die Reversibilität.]
#src[N04, PDF-S. 10, IV-2; Formeln N04, PDF-S. 8.]
][
*Temperatur aus der Energiebilanz bestimmen:* Für den Block ist $Q=-7880$ kJ. Mit $m c(T_2-T_1)=Q$ folgt $T_2="774,15"-7880/(7880 dot "0,5")="772,15"$ K, also $vartheta_2=499$ °C. Der große Temperaturunterschied zur Umgebung ist weiterhin vorhanden.
][
*Entropieänderung des Blocks berechnen:* $Delta s=c ln(T_2/T_1)="0,5" ln("772,15"/"774,15") approx -"0,001293411"$ kJ/(kg K). $Delta S_"Block"=m Delta s approx -"10,192077"$ kJ/K. In den Logarithmus dürfen keine Celsius-Temperaturen eingesetzt werden.
][
*Entropieaufnahme der Umgebung bestimmen:* Das große Reservoir erhält 7880 kJ bei unverändertem $T_"Umg"$. Daher $Delta S_"Umgebung"=7880/"293,15" approx "26,880437"$ kJ/K, positiv als Aufnahme.
][
*Gesamtprozess beurteilen:* $Delta S_"gesamt"=-"10,192077"+"26,880437" approx "16,688360"$ kJ/K. Die positive Gesamtänderung entspricht der Entropieerzeugung dieses nach außen abgeschlossenen Modells. Der Prozess ist irreversibel, obwohl die Energieabgabe und -aufnahme betragsgleich sind.
]

#aufgabe(titel: "Abkühlender Stahlblock von 600 Grad (Variante)", art: "rechnen", quelle: "4.3.1", herkunft: "variante", vorlage: "Vorlesung 4.11., Aufg. IV-2", minuten: 10,
  ergebnis: [$vartheta_2 = 596 thin "°C"$; $Delta S_"Block" approx -"10,56" thin "kJ/K"$; $Delta S_"Umg" approx +"31,93" thin "kJ/K"$; $Delta S_"ges" approx +"21,37" thin "kJ/K"$])[
#if not web [*Aufgabe 322* #linebreak()]
*Gegeben und Annahmen*

Ein Stahlblock mit 5000 kg ($c = "0,46" thin "kJ/(kg K)"$, konstant, inkompressibel) hat 600 °C und gibt 9200 kJ Wärme an die große Umgebung mit konstant 15 °C ab. Keine Arbeit.

*Gesucht*

#enum(numbering: "a)",
[Die Endtemperatur des Blocks.],
[Die Entropieänderungen von Block, Umgebung und gesamt.],
)
][
*Endtemperatur:* $Delta T = Q\/(m c) = -9200\/2300 thin "K" = -4 thin "K"$, also $vartheta_2 = 596 thin "°C"$.
][
*Entropie:* Block $Delta S = m c ln(T_2\/T_1) = 2300 ln("869,15"\/"873,15") approx -"10,56" thin "kJ/K"$. Umgebung $9200\/"288,15" approx +"31,93" thin "kJ/K"$. Gesamt $approx +"21,37" thin "kJ/K" > 0$: Die Abkühlung über das große Temperaturgefälle ist irreversibel.
]

#aufgabe(titel: "Stickstoff in der adiabaten Drossel", art: "rechnen", quelle: "4.3.1", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.6", minuten: 8,
  ergebnis: [$Delta T = 0$; $Delta h = 0$; $Delta s approx +"0,478" thin "kJ/(kg K)"$])[
#if not web [*Aufgabe 323* #linebreak()]
*Gegeben und Annahmen*

Ein konstanter Massenstrom an Stickstoff ($R = "296,8" thin "J/(kg K)"$) fließt durch ein adiabates Drosselventil, wobei sein Druck von 10 bar auf 2 bar absinkt. Die Strömungsgeschwindigkeit vor der Drosselstelle ist gleich der Strömungsgeschwindigkeit dahinter (Querschnittserweiterung). Der Stickstoff verhält sich in dem betrachteten Zustandsgebiet wie ein ideales Gas.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist die Änderung der Temperatur, der spezifischen Enthalpie und der spezifischen Entropie?],
)
][
*Energiebilanz der Drossel:* Stationär, adiabat, keine technische Arbeit, gleiche Geschwindigkeit, gleiche Höhe: $h_2 = h_1$, also $Delta h = 0$. Beim idealen Gas hängt $h$ nur von $T$ ab; daraus folgt $Delta T = 0$.
][
*Entropie:* Ideales Gas mit $T_2 = T_1$:
$ Delta s = c_p ln(T_2/T_1) - R ln(p_2/p_1) = -"0,2968" ln("0,2") thin "kJ/(kg K)" approx +"0,478" thin "kJ/(kg K)" $
Die Entropie steigt, obwohl weder Wärme noch Arbeit übertragen wird: Die Drossel ist irreversibel; der Druckabbau wird ungenutzt verwirbelt.
]

#aufgabe(titel: "Luft in der Drossel von 12 auf 3 bar (Variante)", art: "rechnen", quelle: "4.3.1", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.6", minuten: 5,
  ergebnis: [$Delta T = 0$, $Delta h = 0$, $Delta s approx +"0,398" thin "kJ/(kg K)"$])[
#if not web [*Aufgabe 324* #linebreak()]
*Gegeben und Annahmen*

Luft (ideales Gas, $R = "287,1" thin "J/(kg K)"$) wird stationär in einem adiabaten Ventil von 12 bar auf 3 bar gedrosselt; die Geschwindigkeiten vor und hinter dem Ventil sind gleich.

*Gesucht*

#enum(numbering: "a)",
[Die Änderungen von Temperatur, Enthalpie und Entropie.],
)
][
*Drossel:* $h_2 = h_1$, und für das ideale Gas folgt $T_2 = T_1$.
][
*Entropie:* $Delta s = -R ln(p_2\/p_1) = "0,2871" ln 4 approx +"0,398" thin "kJ/(kg K)"$.
]

#aufgabe(titel: "Druckluft in der Drossel: Entropie und Rohrdurchmesser", art: "rechnen", quelle: "4.3.1", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.7", minuten: 10,
  ergebnis: [$Delta s approx +"0,785" thin "kJ/(kg K)"$; $d_b\/d_a approx "3,92"$])[
#if not web [*Aufgabe 325* #linebreak()]
*Gegeben und Annahmen*

Druckluft (ideales Gas, $R = "287,2" thin "J/(kg K)"$) von $p_a = 20 thin "bar"$ strömt kontinuierlich durch ein adiabates Drosselventil und expandiert dabei auf $p_b = "1,3" thin "bar"$. Die Geschwindigkeit vor und nach der Drossel sei ungefähr gleich.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist die gesamte spezifische Entropieänderung durch die Drosselung?],
[Bestimme das Verhältnis der Rohrdurchmesser nach und vor der Drossel.],
)
][
*Entropie:* Wie bei jeder adiabaten Drossel eines idealen Gases ohne Geschwindigkeitsänderung ist $T_b = T_a$:
$ Delta s = R ln(p_a/p_b) = "0,2872" ln("20"/"1,3") thin "kJ/(kg K)" approx "0,785" thin "kJ/(kg K)" $
Die Drossel ist adiabat; diese Entropie ist vollständig im Ventil erzeugt.
][
*Durchmesser:* Gleicher Massenstrom und gleiche Geschwindigkeit: $rho_a A_a = rho_b A_b$. Bei gleicher Temperatur ist $rho tilde p$:
$ A_b/A_a = p_a/p_b quad => quad d_b/d_a = sqrt(20/"1,3") approx "3,92" $
Das Rohr hinter der Drossel muss fast viermal so weit sein, sonst würde die entspannte Luft stark beschleunigt.
]

#aufgabe(titel: "Druckluft von 16 auf 1,5 bar drosseln (Variante)", art: "rechnen", quelle: "4.3.1", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.7", minuten: 8,
  ergebnis: [$Delta s approx +"0,680" thin "kJ/(kg K)"$; $d_b\/d_a approx "3,27"$])[
#if not web [*Aufgabe 326* #linebreak()]
*Gegeben und Annahmen*

Druckluft ($R = "287,2" thin "J/(kg K)"$, ideales Gas) wird stationär und adiabat von 16 bar auf 1,5 bar gedrosselt. Die Geschwindigkeit soll vor und hinter der Drossel gleich sein.

*Gesucht*

#enum(numbering: "a)",
[Die spezifische Entropieänderung.],
[Das nötige Durchmesserverhältnis.],
)
][
*Entropie:* $T$ bleibt gleich; $Delta s = "0,2872" ln(16\/"1,5") approx "0,680" thin "kJ/(kg K)"$.
][
*Durchmesser:* $d_b\/d_a = sqrt(16\/"1,5") approx "3,27"$.
]

#aufgabe(titel: "Altklausur WS 04/05: Kondensationswärme und Entropie", art: "rechnen", quelle: "4.3.2", herkunft: "original", minuten: 6, vorlage: "Altklausur WS 04/05, Kurzfrage 6, PDF-S. 1")[
#if not web [*Aufgabe 327* #linebreak()]
*Gegeben:* Sattdampf kondensiert vollständig bei 20 °C, Verdampfungsenthalpie 1500 kJ/kg. Eine Gesamtmasse ist nicht gegeben. *Gesucht:* a) freiwerdende Wärme, b) Entropieänderung des Fluids.
][
*Mengenbezug festlegen:* Ohne Masse ist die Antwort spezifisch: $q=-1500$ kJ/kg (Abgabe); für eine Masse m: $Q=m q$.
][
*Sättigungsbeziehung:* $T="293,15"$ K. $Delta s=-1500/"293,15" approx -"5,11683"$ kJ/(kg K). Die Umgebung nimmt bei reversibler Übertragung denselben Entropiebetrag auf.
]

#aufgabe(titel: "Altklausur WS 04/05: Kondensationswärme und Entropie (Variante)", art: "rechnen", quelle: "4.3.2", herkunft: "variante", minuten: 6, vorlage: "Altklausur WS 04/05, Kurzfrage 6, PDF-S. 1")[
#if not web [*Aufgabe 328* #linebreak()]
*Von KI erstellt.* *Gegeben:* 2 kg eines Sattdampfes kondensieren bei 30 °C. Als KI-Übungswerte gelten $r=1400$ kJ/kg und vollständige Kondensation. *Gesucht:* Wärmeabgabe und Entropieänderung.
][
*Spezifisch und gesamt:* $Q=-2 dot 1400=-2800$ kJ. $Delta S=-2800/"303,15" approx -"9,23635"$ kJ/K. Der Fluidverlust ist kein Verstoß gegen den zweiten Hauptsatz.
]

#aufgabe(titel: "Entropie von siedendem Wasser und kaltem Eis", art: "rechnen", quelle: "4.3.2", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.2", minuten: 10,
  ergebnis: [$s'(1 thin "bar") approx "1,303" thin "kJ/(kg K)"$; $s_"Eis" (-30 thin "°C") approx -"1,458" thin "kJ/(kg K)"$])[
#if not web [*Aufgabe 329* #linebreak()]
*Gegeben und Annahmen*

Die Entropie des flüssigen Wassers ist am Tripelpunkt null, d. h. $s'_"Tr" = s'(vartheta = "0,01" thin "°C") = 0$. Spezifische Wärmekapazität von Wasser $c_W = "4,19" thin "kJ/(kg K)"$, von Eis $c_E = "2,04" thin "kJ/(kg K)"$, spezifische Schmelzwärme von Eis $r_S = Delta h_f = "333,5" thin "kJ/kg"$. Wasser und Eis werden als inkompressibel mit konstanter Wärmekapazität betrachtet; die Siedetemperatur bei 1 bar ist $"99,63" thin "°C"$.

*Gesucht*

#enum(numbering: "a)",
[Wie groß ist dann die Entropie von siedendem Wasser bei $p = 1 thin "bar"$?],
[Wie groß ist die Entropie von Eis bei $vartheta = -30 thin "°C"$?],
)
][
*Inkompressibler Stoff:* Entlang eines reversiblen Erwärmungsweges gilt $dif s = c thin dif T\/T$, integriert $Delta s = c ln(T_2\/T_1)$. Der Druck spielt dafür keine Rolle.
$ s'(1 thin "bar") = c_W ln("372,78"/"273,16") = "4,19" dot "0,3109" thin "kJ/(kg K)" approx "1,303" thin "kJ/(kg K)" $
][
*Eis:* Zwei Schritte vom Bezugspunkt aus. Erstens Erstarren am Tripelpunkt: Die Schmelzwärme wird bei konstanter Temperatur abgegeben, $Delta s = -r_S\/T_"Tr" = -"333,5"\/"273,16" approx -"1,2209" thin "kJ/(kg K)"$. Zweitens das Eis abkühlen:
$ Delta s = c_E ln("243,15"/"273,16") approx -"0,2374" thin "kJ/(kg K)" quad => quad s_"Eis" approx -"1,458" thin "kJ/(kg K)" $
Negative Werte sind kein Widerspruch: Der Nullpunkt ist hier willkürlich am Tripelpunkt festgelegt.
]

#aufgabe(titel: "Entropie von warmem Wasser und Eis bei −20 Grad (Variante)", art: "rechnen", quelle: "4.3.2", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.2", minuten: 8,
  ergebnis: [$s(60 thin "°C") approx "0,832" thin "kJ/(kg K)"$; $s_"Eis" (-20 thin "°C") approx -"1,376" thin "kJ/(kg K)"$])[
#if not web [*Aufgabe 330* #linebreak()]
*Gegeben und Annahmen*

Bezugspunkt: $s' = 0$ für flüssiges Wasser am Tripelpunkt (0,01 °C). $c_W = "4,19"$, $c_E = "2,04" thin "kJ/(kg K)"$, $r_S = "333,5" thin "kJ/kg"$; beide Phasen inkompressibel.

*Gesucht*

#enum(numbering: "a)",
[Die spezifische Entropie von Wasser bei 60 °C.],
[Die spezifische Entropie von Eis bei −20 °C.],
)
][
*Wasser:* $s = c_W ln("333,15"\/"273,16") = "4,19" dot "0,1985" approx "0,832" thin "kJ/(kg K)"$.
][
*Eis:* Erstarren $-"1,2209"$ plus Abkühlen $c_E ln("253,15"\/"273,16") approx -"0,1552"$, zusammen $s_"Eis" approx -"1,376" thin "kJ/(kg K)"$. Wärmeres Eis hat mehr Entropie: Der Wert liegt über den $-"1,458" thin "kJ/(kg K)"$ des Eises bei −30 °C.
]

#aufgabe(titel: "Wasser im Solebad gefrieren: Entropiebilanz", art: "rechnen", quelle: "4.3.2", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.3", minuten: 15,
  ergebnis: [$Delta S_W approx -"35,37" thin "kJ/K"$; $Delta S_S approx +"37,18" thin "kJ/K"$; $Delta S_"ges" approx +"1,80" thin "kJ/K"$])[
#if not web [*Aufgabe 331* #linebreak()]
*Gegeben und Annahmen*

$n_W = 1 thin "kmol"$ Wasser ($M_W = "18,02" thin "kg/kmol"$) von $vartheta_W = 50 thin "°C"$ wird in einem sehr großen Solebad von $vartheta_S = -5 thin "°C"$ zu Eis von $vartheta_E = -5 thin "°C"$ gefroren ($c_"Eis" = "2,04" thin "kJ/(kg K)"$, $r_S = "333,5" thin "kJ/kg"$; für flüssiges Wasser $c_W = "4,19" thin "kJ/(kg K)"$; Erstarren bei 0 °C). Die Sole sei thermisch von der Umgebung entkoppelt.

*Gesucht*

#enum(numbering: "a)",
[Berechne die Entropieänderung des Wassers $Delta S_W$.],
[Berechne die Entropieänderung der Sole $Delta S_S$.],
[Berechne die Entropieänderung des gesamten Systems $Delta S_"ges"$.],
)
][
*Wasser in drei Schritten:* $m = "18,02" thin "kg"$. Abkühlen auf 0 °C, Erstarren bei 0 °C, Eis auf −5 °C abkühlen. Entropie ist eine Zustandsgröße, also darf man über diesen gedachten reversiblen Weg rechnen:
$ Delta S_W = m [c_W ln("273,15"/"323,15") - r_S/"273,15" + c_"Eis" ln("268,15"/"273,15")] $
$ = "18,02" dot (-"0,7043" - "1,2209" - "0,0377") thin "kJ/K" approx -"35,37" thin "kJ/K" $
][
*Sole:* Sie nimmt die ganze abgegebene Wärme bei konstant 268,15 K auf:
$ Q = m (c_W dot 50 + r_S + c_"Eis" dot 5) = "18,02" dot "553,2" thin "kJ" approx 9969 thin "kJ" $
$ Delta S_S = Q/T_S = 9969/"268,15" thin "kJ/K" approx "37,18" thin "kJ/K" $
][
*Gesamt:* $Delta S_"ges" = Delta S_W + Delta S_S approx +"1,80" thin "kJ/K" > 0$. Das Gesamtsystem ist abgeschlossen; die positive Bilanz zeigt die Irreversibilität der Wärmeübertragung über ein endliches Temperaturgefälle. Dass das Wasser Entropie verliert, ist erlaubt: Es gibt Wärme ab.
]

#aufgabe(titel: "Zwei Kilomol Wasser im kälteren Solebad (Variante)", art: "rechnen", quelle: "4.3.2", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.3", minuten: 12,
  ergebnis: [$Delta S_W approx -"62,48" thin "kJ/K"$; $Delta S_S approx +"65,68" thin "kJ/K"$; $Delta S_"ges" approx +"3,20" thin "kJ/K"$])[
#if not web [*Aufgabe 332* #linebreak()]
*Gegeben und Annahmen*

2 kmol Wasser ($M = "18,02" thin "kg/kmol"$) von 30 °C werden in einem sehr großen, nach außen isolierten Solebad von −10 °C zu Eis von −10 °C gefroren. $c_W = "4,19"$, $c_"Eis" = "2,04" thin "kJ/(kg K)"$, $r_S = "333,5" thin "kJ/kg"$ bei 0 °C.

*Gesucht*

#enum(numbering: "a)",
[Die Entropieänderung des Wassers.],
[Die Entropieänderung der Sole und die Gesamtänderung.],
)
][
*Wasser:* $m = "36,04" thin "kg"$:
$ Delta S_W = m [c_W ln("273,15"/"303,15") - "333,5"/"273,15" + c_"Eis" ln("263,15"/"273,15")] approx "36,04" dot (-"0,4366" - "1,2209" - "0,0761") approx -"62,48" thin "kJ/K" $
][
*Sole und Summe:* $Q = "36,04"("4,19" dot 30 + "333,5" + "2,04" dot 10) thin "kJ" approx 17 thin 285 thin "kJ"$, $Delta S_S = Q\/"263,15" approx "65,68" thin "kJ/K"$; $Delta S_"ges" approx +"3,20" thin "kJ/K"$. Das größere Temperaturgefälle und die doppelte Masse vergrößern die Entropieerzeugung.
]

#aufgabe(titel: "Zwei heiße Körper: mit und ohne Umgebungskontakt", art: "rechnen", quelle: "4.3.2", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.8 a, b, d–f", minuten: 25,
  ergebnis: [Mit Umgebung: beide 0 °C, $Delta S_"ges" approx +"275,4" thin "kJ/K"$; adiabat gekoppelt: $vartheta_3 = 1000 thin "°C"$, $Delta S approx +"10,16" thin "kJ/K"$; $vartheta_4 approx "900,7" thin "°C"$],
  tipp: [Für jeden Körper gilt $Delta U = m c Delta T$ und $Delta S = m c ln(T_2\/T_1)$. Die Umgebung ist ein Wärmespeicher mit konstanter Temperatur.])[
#if not web [*Aufgabe 333* #linebreak()]
*Gegeben und Annahmen*

Zwei starre Körper ($K_A$: Masse $m_A = 100 thin "kg"$, spezifische Wärmekapazität $c_A = "1,0" thin "kJ/(kg K)"$, Anfangstemperatur $vartheta_(A,1) = 1200 thin "°C"$; $K_B$: $m_B = 50 thin "kg"$, $c_B = "0,5" thin "kJ/(kg K)"$, $vartheta_(B,1) = 200 thin "°C"$) stehen im thermischen Kontakt zueinander und jeweils mit der Umgebung (Umgebungstemperatur $vartheta_infinity = 0 thin "°C"$, sehr große Umgebung). Die Wärmekapazitäten sind konstant.

*Gesucht*

#enum(numbering: "a)",
[Skizziere die Temperaturverläufe über der Zeit und berechne die Endtemperaturen $vartheta_(A,2)$ und $vartheta_(B,2)$.],
[Berechne für die Teilsysteme und für die gesamte Anordnung die Änderungen der inneren Energie, der Entropie und die übertragenen Wärmen.],
[Für die folgende Vergleichsrechnung werden die beiden thermisch gekoppelten Körper als adiabat zur Umgebung betrachtet. Skizziere die Temperaturverläufe über der Zeit und berechne die Endtemperaturen $vartheta_(A,3)$ und $vartheta_(B,3)$.],
[Berechne für die Teilsysteme und für die gesamte Anordnung (adiabat) die Änderungen der inneren Energie, der Entropie und die übertragenen Wärmen.],
[Bestimme die Endtemperatur $vartheta_4$ so, dass die Entropieänderung der gesamten Anordnung null ergibt.],
)
][
*a) Mit Umgebung:* Wärme fließt so lange, bis alles die Umgebungstemperatur hat: $vartheta_(A,2) = vartheta_(B,2) = 0 thin "°C"$. Verlauf: $K_A$ fällt steil und dann immer flacher auf 0 °C. $K_B$ wird anfangs von $K_A$ eventuell kurz gewärmt, fällt dann aber ebenfalls asymptotisch auf 0 °C. Beide Kurven nähern sich der Umgebungstemperatur von oben.
][
*b) Energie und Entropie mit Umgebung:* Wärmekapazitäten $C_A = 100 thin "kJ/K"$, $C_B = 25 thin "kJ/K"$.
$ Delta U_A = C_A Delta T_A = -120 thin 000 thin "kJ" quad Delta U_B = -5000 thin "kJ" $
Starr und ohne Arbeit gilt für jeden Körper $Q = Delta U$; die Umgebung erhält $Q_infinity = +125 thin 000 thin "kJ"$.
$ Delta S_A = C_A ln("273,15"/"1473,15") approx -"168,51" thin "kJ/K" quad Delta S_B = C_B ln("273,15"/"473,15") approx -"13,73" thin "kJ/K" $
$ Delta S_infinity = (125 thin 000)/"273,15" thin "kJ/K" approx +"457,62" thin "kJ/K" quad Delta S_"ges" approx +"275,4" thin "kJ/K" $
Die gesamte innere Energie der Anordnung (Körper + Umgebung) bleibt gleich, die Entropie steigt stark.
][
*d) Adiabat gekoppelt:* Nur die beiden Körper tauschen Wärme. Die abgegebene Wärme von $K_A$ nimmt $K_B$ auf, bis beide gleich warm sind:
$ C_A (T_3 - T_(A,1)) + C_B (T_3 - T_(B,1)) = 0 quad => quad vartheta_3 = (100 dot 1200 + 25 dot 200)/125 thin "°C" = 1000 thin "°C" $
Verlauf: $K_A$ fällt von 1200 °C, $K_B$ steigt von 200 °C; beide treffen sich asymptotisch bei 1000 °C.
][
*e) Bilanzen adiabat:* $Delta U_A = Q_A = -20 thin 000 thin "kJ"$, $Delta U_B = Q_B = +20 thin 000 thin "kJ"$, gesamt null.
$ Delta S_A = 100 ln("1273,15"/"1473,15") approx -"14,59" thin "kJ/K" quad Delta S_B = 25 ln("1273,15"/"473,15") approx +"24,75" thin "kJ/K" $
$ Delta S_"ges" approx +"10,16" thin "kJ/K" > 0 $
Auch ohne Umgebung ist der Ausgleich irreversibel; $K_B$ gewinnt mehr Entropie, als $K_A$ verliert, weil es die Wärme bei tieferer Temperatur aufnimmt.
][
*f) Entropieneutral:* Gesucht ist $T_4$ mit $C_A ln(T_4\/T_(A,1)) + C_B ln(T_4\/T_(B,1)) = 0$:
$ T_4 = exp((C_A ln T_(A,1) + C_B ln T_(B,1))/(C_A + C_B)) approx "1173,8" thin "K" quad => quad vartheta_4 approx "900,7" thin "°C" $
$T_4$ liegt unter $T_3$: Bei reversiblem Ausgleich bliebe weniger innere Energie in den Körpern. Die Differenz könnte als Arbeit abgegeben werden.
]

#aufgabe(titel: "Zwei Körper aus Stahl und Keramik (Variante)", art: "rechnen", quelle: "4.3.2", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.8 a, b, d–f", minuten: 20,
  ergebnis: [Mit Umgebung: $Delta S_"ges" approx +"125,1" thin "kJ/K"$; adiabat: $vartheta_3 approx "678,3" thin "°C"$, $Delta S approx +"10,75" thin "kJ/K"$; $vartheta_4 approx "580,9" thin "°C"$])[
#if not web [*Aufgabe 334* #linebreak()]
*Gegeben und Annahmen*

Körper A: $m = 80 thin "kg"$, $c = "0,9" thin "kJ/(kg K)"$, 900 °C. Körper B: $m = 60 thin "kg"$, $c = "0,46" thin "kJ/(kg K)"$, 100 °C. Beide starr, konstante Wärmekapazitäten. Umgebung: sehr groß, 10 °C.

*Gesucht*

#enum(numbering: "a)",
[Beide Körper kühlen in Kontakt mit der Umgebung vollständig ab: Wärmen und gesamte Entropieänderung.],
[Beide Körper gleichen sich adiabat zur Umgebung aus: Endtemperatur und gesamte Entropieänderung.],
[Bei welcher gemeinsamen Endtemperatur wäre die Entropieänderung null?],
)
][
*a) Mit Umgebung:* $C_A = 72$, $C_B = "27,6" thin "kJ/K"$; $Q_A = -64 thin 080 thin "kJ"$, $Q_B = -2484 thin "kJ"$, $Q_infinity = +66 thin 564 thin "kJ"$.
$ Delta S_"ges" = 72 ln("283,15"/"1173,15") + "27,6" ln("283,15"/"373,15") + (66 thin 564)/"283,15" approx -"102,35" - "7,62" + "235,08" approx +"125,1" thin "kJ/K" $
][
*b) Adiabat:* $T_3 = (72 dot "1173,15" + "27,6" dot "373,15")\/"99,6" approx "951,5" thin "K" = "678,3" thin "°C"$.
$ Delta S = 72 ln("951,46"/"1173,15") + "27,6" ln("951,46"/"373,15") approx -"15,08" + "25,83" = +"10,75" thin "kJ/K" $
][
*c) Entropieneutral:* $T_4 = exp((72 ln "1173,15" + "27,6" ln "373,15")\/"99,6") approx "854,1" thin "K" = "580,9" thin "°C"$. Wieder liegt $T_4$ unter $T_3$.
]

#aufgabe(titel: "Kurzfrage: Isentroper Gütegrad einer Entspannungsmaschine", art: "verstehen", quelle: "4.3.3", herkunft: "original", vorlage: "Leistungsnachweis SS 13, Kurzfrage 9", minuten: 3)[
#if not web [*Aufgabe 335* #linebreak()]
Der Gütegrad $eta_G$ (isentroper Wirkungsgrad) einer Entspannungsmaschine stellt ein Verhältnis dar. Welches, und warum?
][
*Antwort:* gewonnene Arbeit zu theoretisch (isentrop) gewinnbarer Arbeit: $eta_s = (h_1 - h_2)\/(h_1 - h_(2s))$ bei gleichem Eintrittszustand und gleichem Enddruck.
][
*Typische Verwechslung:* Arbeit zu zugeführter Wärme wäre ein thermischer Wirkungsgrad eines Kreisprozesses. Bei einer Verdichtung steht das Verhältnis umgekehrt: theoretisch nötige zu tatsächlich zugeführter Arbeit.
]

#aufgabe(titel: "Altklausur Übungsklausur WS 99/00: Kurzfrage 4", art: "verstehen", quelle: "4.3.3", herkunft: "original", minuten: 3, vorlage: "Altklausur Übungsklausur WS 99/00, Kurzfrage 4 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 336* #linebreak()]
Welches Verhältnis beschreibt der isentrope Gütegrad einer Entspannungsmaschine? Erläutere die Vergleichszustände.
][
*Antwort:* Für die adiabate Entspannungsmaschine vergleicht der isentrope Gütegrad die reale Arbeitsabgabe mit der isentrop möglichen bei gleichem Anfangszustand und gleichem Austrittsdruck: $eta_("is,T")=(h_1-h_2)/(h_1-h_(2s))$. Die Größen sind positive Arbeitsbeträge im Quotienten.
]

#aufgabe(titel: "Realer Turbinenaustritt liegt höher", art: "verstehen", quelle: "4.3.3", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 337* #linebreak()]
Warum ist der reale Austritt einer adiabaten Turbine enthalpiereicher als der isentrope Vergleich bei gleichem Enddruck?
][
*Antwort:*

- Die reale Turbine gibt wegen innerer Irreversibilität weniger Wellenarbeit ab.
- Die entsprechend größere Energie bleibt mit dem austretenden Stoff erhalten.
- Gleichzeitig steigt seine spezifische Entropie
- der isentrope Vergleich besitzt unveränderte spezifische Entropie.
][
*Typische Verwechslung:*

- „Eine vernichtete Energiemenge in Höhe der Vergleichsverlustleistung.“: Die entgangene Arbeit ist kein Energieverlust aus der Gesamtbilanz; der Austrittszustand enthält die Energie.
]

#aufgabe(titel: "Entgangene Leistung und Dissipation", art: "verstehen", quelle: "4.3.3", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 338* #linebreak()]
Warum ist entgangene isentrope Wellenleistung nicht automatisch dieselbe Größe wie eine genaue Dissipationsarbeit?
][
*Antwort:*

- Die entgangene Wellenleistung ist eine Vergleichsdifferenz zwischen realem und isentropem Prozess mit gleichen Randzustandsvorgaben.
- Eine genaue Dissipationsarbeit enthält dagegen ein Integral entlang des inneren Prozesswegs.
- Ohne diesen Weg darf sie nicht mit einer erfundenen mittleren Temperatur aus der Entropiedifferenz berechnet werden.
]

#aufgabe(titel: "Dampfturbine und Blockade: isentroper Vergleich und Entropie", art: "rechnen", quelle: "4.3.3", herkunft: "original", vorlage: "Vorlesung 4.11., Aufg. IV-3", minuten: 20,
 ergebnis: [Betrieb: $vartheta_2 approx 220$ °C, $w_t approx -"574,048"$ kJ/kg, $P_t approx -"1148,095"$ kW, Vergleichsverlust etwa 95,994 kW. Blockade: $h_2=h_1 approx "3449,045"$ kJ/kg, $vartheta_2 approx "486,469"$ °C, $P_t=0$.],
 tipp: [Zuerst den Einlasszustand aus p und s ermitteln, danach den isentropen Vergleichszustand am Enddruck.])[
#if not web [*Aufgabe 339* #linebreak()]
*Gegeben und Annahmen:* N04, IV-3: Stationärer Dampfstrom $dot(m)=2$ kg/s bei $p_1=100$ bar und $s_1="6,692"$ kJ/(kg K). Enddruck 10 bar; isentroper Turbinen-Gütegrad $eta_"is"="0,92284"$. Die Turbine ist adiabat; Änderungen von Bewegungs- und Lageenergie werden vernachlässigt. Bei einer anschließenden Blockade strömt der Dampf im vereinfachten Modell ohne technische Arbeitsabgabe durch das Gerät. Folgender konsistenter Tabellenauszug steht zur Verfügung:
#tab(columns: (1fr, 1fr, 1fr, 1fr),
 th([p bar], [Temperatur °C], [h kJ/kg], [s kJ/(kg K)]),
 [100], [500], [3375], [6,599], [100], [550], [3500], [6,756],
 [10], [200], [2827], [6,692], [10], [210], [2851], [6,743], [10], [220], [2875], [6,791],
 [10], [450], [3371], [7,619], [10], [500], [3478], [7,763],
)
Verwende lineare Interpolation zwischen den jeweiligen Stützstellen. Als aus dem Gütegrad berechenbare *Vergleichsverlustleistung* ist $P_"Verlust"=abs(P_"is")-abs(P_t)$ gemeint. Eine genaue Dissipationsarbeit entlang eines tatsächlichen inneren Prozesswegs ist dadurch noch nicht vorgegeben.

*Gesucht:*
#enum(numbering: "a)")[Bestimme Anfangstemperatur, Anfangsenthalpie und isentropen Endzustand.][Berechne den realen Endzustand, spezifische technische Arbeit, Leistung, Vergleichsverlust und Entropieerzeugungsstrom.][Bestimme nach Blockade Endzustand und Leistung sowie die Zunahme des Entropiestroms.][Ordne die in der Folie verlangte „dissipierte Leistung“ fachlich ein.]
#src[N04, PDF-S. 10, IV-3; BT A.8, S. 490 und 492 / PDF-S. 505 und 507; Gütegrad BT 6.3, S. 191 / PDF-S. 210. Bedeutung des Verlustbegriffs ausdrücklich abgegrenzt.]
][
*Einlasszustand aus den Tabellen bestimmen:* Bei 100 bar liegt $s_1="6,692"$ zwischen 6,599 und 6,756. $f_1=("6,692"-"6,599")/("6,756"-"6,599") approx "0,5923567"$. Somit $vartheta_1=500+50f_1 approx "529,61783"$ °C und $h_1=3375+125f_1 approx "3449,044586"$ kJ/kg.
][
*Isentropen Vergleich aufbauen:* Bei 10 bar und unverändertem $s_(2s)="6,692"$ steht direkt in der Tabelle $vartheta_(2s)=200$ °C, $h_(2s)=2827$ kJ/kg. Die maximal verglichene spezifische Abgabe beträgt $h_1-h_(2s) approx "622,044586"$ kJ/kg; $P_"is"=2(2827-h_1) approx -"1244,08917"$ kW.
][
*Reale Enthalpie mit dem Gütegrad bestimmen:* $h_2=h_1-eta_"is"(h_1-h_(2s)) approx "2874,996960"$ kJ/kg. Die reale Enthalpie liegt höher als die isentrope Vergleichsenthalpie, weil weniger Wellenarbeit abgegeben wird.
][
*Realen Endzustand und Entropie zuordnen:* Zwischen den 10-bar-Zeilen bei 210 und 220 °C ist $f_2=(h_2-2851)/(2875-2851) approx "0,9998733"$. Damit $vartheta_2 approx "219,99873"$ °C und $s_2 approx "6,7909939"$ kJ/(kg K). $dot(S)_"erz"=dot(m)(s_2-s_1) approx "0,19798784"$ kW/K. Positive Erzeugung passt zur adiabaten irreversiblen Turbine.
][
*Arbeit und Vergleichsverlust berechnen:* $w_t=h_2-h_1 approx -"574,047626"$ kJ/kg; $P_t=dot(m)w_t approx -"1148,09525"$ kW. Die Leistungsminderung gegenüber dem isentropen Vergleich ist $P_"Verlust"="1244,08917"-"1148,09525" approx "95,99392"$ kW. Diese Energie ist nicht vernichtet; die reale Austrittsenthalpie ist entsprechend höher.
][
*Blockade als Drossel modellieren:* Ohne technische Arbeit, Wärmeaustausch und äußere Energieänderung gilt $h_(2B)=h_1 approx "3449,044586"$ kJ/kg. Am Enddruck 10 bar folgt zwischen den Zeilen 450 und 500 °C $f_B=(h_1-3371)/(3478-3371) approx "0,7293887"$. Daher $vartheta_(2B) approx "486,46943"$ °C und $s_(2B) approx "7,7240320"$ kJ/(kg K), während $P_(t,B)=0$.
][
*Entropie und Verlust bei Blockade einordnen:* $dot(S)_("erz,B")=2(s_(2B)-s_1) approx "2,0640639"$ kW/K. Die gesamte ideale Vergleichsabgabe von etwa 1244,089 kW wird nun nicht als Wellenleistung gewonnen. Wird mit „dissipierter Leistung“ diese entgangene Vergleichsleistung gemeint, ist das der berechenbare Wert. Eine genaue Größe $dot(m)integral T dif s$ verlangt zusätzlich den inneren Zustandsweg; der Folienauftrag liefert ihn nicht. Sie wird deshalb nicht mit einer erfundenen Temperatur aus $Delta s$ gebildet.
]

#aufgabe(titel: "Kurzfrage: Isolinien durch einen Punkt im p,v-Diagramm", art: "verstehen", quelle: "4.4", herkunft: "original", vorlage: "Leistungsnachweis SS 13, Kurzfrage 1", minuten: 3)[
#if not web [*Aufgabe 340* #linebreak()]
Skizziere in einem p,v-Diagramm die durch einen Punkt $P_1$ laufende Isochore, Isobare, Isotherme und Isentrope eines idealen Gases. Beschrifte die Linien.
][
*Antwort:* Die Isobare ist waagerecht ($p = "konst."$), die Isochore senkrecht ($v = "konst."$). Die Isotherme ist eine Hyperbel $p v = "konst."$, fällt also nach rechts. Die Isentrope $p v^kappa = "konst."$ fällt mit $kappa > 1$ steiler als die Isotherme.
][
*Warum die Isentrope steiler ist:* Bei adiabater Expansion bezahlt das Gas die abgegebene Arbeit aus seiner inneren Energie und kühlt ab. Bei gleichem Volumenzuwachs sinkt der Druck deshalb stärker als bei der Isotherme, bei der Wärme nachfließt.
]

#aufgabe(titel: "Kurzfrage: Isobares Überhitzen im T,s-Diagramm", art: "verstehen", quelle: "4.4", herkunft: "original", vorlage: "Leistungsnachweis SS 14, Kurzfrage 9", minuten: 3)[
#if not web [*Aufgabe 341* #linebreak()]
a) Skizziere in einem T,s-Diagramm die Wärme, die erforderlich ist, um H#sub[2]O vom Umgebungszustand isobar zu überhitzen. b) Welche Beziehung besteht zwischen Wärme, Entropie und Temperatur beziehungsweise zwischen Wärme und Enthalpie?
][
*a) Skizze:* Die Isobare steigt im Flüssigkeitsgebiet bis zur Siedelinie, verläuft im Nassdampfgebiet waagerecht bei $T_s$ und steigt im Überhitzungsgebiet steiler an. Die Fläche unter dieser Linie bis zur $s$-Achse ist die zugeführte spezifische Wärme; das größte Stück ist das Rechteck der Verdampfung.
][
*b) Formeln:* Reversibel gilt $dif q = T thin dif s$, also $q = integral T thin dif s$. Isobar ohne technische Arbeit und Dissipation gilt $q_12 = h_2 - h_1$.
]

#aufgabe(titel: "Zustandsdiagramme: Achsen und Isolinien selbst zeichnen", art: "verstehen", quelle: "4.4", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 342* #linebreak()]
Zeichne die Achsen eines T-s-, h-s- und lg(p)-h-Diagramms. Trage jeweils die unmittelbar horizontalen oder vertikalen Isolinien ein. Erkläre, welche Größe bei Isotherme, Isobare, Isochore, Isentrope, Isenthalpe und Isovapore konstant bleibt. Wann darf die Fläche unter einem T-s-Weg als Wärme gelesen werden?
#src[N04, PDF-S. 11; N28, PDF-S. 4, Markierung zur Prüfung; eigene Verständnisaufgabe.]
][
*Achsen zuerst festlegen:* T-s: s nach rechts, T nach oben. h-s: s nach rechts, h nach oben. lg(p)-h: h nach rechts, logarithmischer Absolutdruck nach oben. Erst aus diesen Achsen folgt die geometrische Form einer konstanten Koordinate.
][
*Unmittelbare Isolinien zeichnen:* Im T-s-Diagramm ist die Isentrope senkrecht und die Isotherme waagerecht. Im h-s-Diagramm ist die Isentrope senkrecht und die Isenthalpe waagerecht. Im lg(p)-h-Diagramm ist die Isenthalpe senkrecht und die Isobare waagerecht. Andere Linienformen hängen vom Stoff und vom Zustandsgebiet ab.
][
*Konstant gehaltene Größe benennen:* Isotherme T, Isobare p, Isochore v, Isentrope s, Isenthalpe h, Isovapore x im Zweiphasengebiet. Eine Isentrope ist keine überall senkrechte Linie; das hängt von den gewählten Achsen ab.
][
*Wärmefläche begrenzen:* Bei reversiblem Weg gilt $delta q_"rev"=T dif s$, also $q_"rev"=integral T dif s$. Bei einem irreversiblen tatsächlichen Weg enthält die Entropiezunahme zusätzlich Erzeugung; die Fläche ist dann nicht ungeprüft die tatsächlich übertragene Wärme.
#align(center)[#image("abbildungen/zustandsdiagramme-achsen.svg", width: 75%)]
][
*Ausführlich:*

- Eine Isentrope hält die spezifische Entropie konstant.
- Senkrecht ist sie nur dann unmittelbar, wenn diese Entropie die waagerechte Achse bildet, etwa im T-s- oder h-s-Diagramm.
- Bei anderen Achsen muss ihre Form aus dem Stoffdiagramm abgelesen werden.

#align(center)[#image("abbildungen/zustandsdiagramme-achsen.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* Senkrecht ist eine Isentrope nur bei s auf der waagerechten Achse.
][
*Ausführlich:*

- Sie verbindet Zustände mit gleichem Dampf-Massenanteil.
- Dieser Anteil beschreibt ein Flüssig-Dampf-Gemisch im Zweiphasengebiet.
- Er ist kein fortsetzbarer Dampfgehalt eines einphasig überhitzten Gases.
][
*Typische Verwechslung:*

- „Jede Isentrope unabhängig von Stoff und Gebiet.“: Senkrechte Isentropen ergeben sich unmittelbar bei s als waagerechter Achse, nicht allgemein in diesem Diagramm.
- „Eine Isobare.“: Ein konstanter Druck hält hier die senkrechte Koordinate fest und ergibt eine waagerechte Linie.
]

#aufgabe(titel: "Fläche unter dem T-s-Weg", art: "verstehen", quelle: "4.4", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 343* #linebreak()]
Wann ist die Fläche unter einem T-s-Weg unmittelbar die übertragene spezifische Wärme?
][
*Antwort:*

- Bei einem reversiblen Weg gilt $delta q_"rev"=T dif s$.
- Dann liefert die Fläche das Integral dieser Wärme.
- Bei einem irreversiblen Weg enthält die Entropieänderung zusätzlich Erzeugung
- die Fläche darf deshalb nicht ungeprüft als tatsächliche Wärmezufuhr gelesen werden.

#align(center)[#image("abbildungen/zustandsdiagramme-achsen.svg", width: 100%, height: 55mm, fit: "contain")]
][
*Merksatz:* T-s-Fläche als Wärme: nur mit geprüftem reversiblen Weg.
][
*Typische Verwechslung:*

- „Ja; jede Entropieänderung entsteht ausschließlich durch Wärme.“: Entropie kann auch im Inneren erzeugt und bei offenen Systemen mit Stoff transportiert werden.
- „Ja; sobald nur die Endtemperaturen bekannt sind.“: Die tatsächliche Wärme hängt auch vom Prozessweg und seinen Bedingungen ab.
]

#aufgabe(titel: "R134a-Zustand im lg(p)-h-Diagramm ablesen", art: "rechnen", quelle: "4.4", herkunft: "original", minuten: 8, vorlage: "Vorlesung 10.11., Folie 04-10 / PDF-S. 5")[
#if not web [*Aufgabe 344* #linebreak()]
*Gegeben:* Das Originaldiagramm enthält den durch einen blauen Kreis markierten R134a-Zustand. Die farbigen Beispiel-Isolinien sind zusätzliche Orientierung, nicht alle gehen durch diesen Kreis.
#image("abbildungen/r134a-angabe.svg", width: 100%)
*Gesucht:* Lies $p,h,vartheta,s,v,x$ ab. Nenne das Zustandsgebiet und eine angemessene Ablesegenauigkeit.
][
*Achsen lesen:* $h$ steht waagerecht, der Absolutdruck senkrecht logarithmisch. Der Kreis liegt bei ungefähr $h=450$ kJ/kg und $p=5$ bar. Die blaue 6-bar-Linie liegt etwas darüber; sie bezeichnet nicht den Kreis.
][
*Weitere Linien verfolgen:* Im Auflösungsbereich der Vorlage ergeben sich etwa 50–60 °C, $s$ ungefähr 1,85–1,90 kJ/(kg K) und $v$ etwa 0,05 m³/kg (50 dm³/kg). Diese Werte sind grafische Näherungen; die hervorgehobenen Linien 40 °C, 1,9 kJ/(kg K) und 100 dm³/kg müssen nicht durch den Zustand laufen.
][
*Gebiet prüfen:* Der Zustand liegt rechts der Taulinie im überhitzten Dampf. $x$ ist dort nicht definiert. Den Dampfgehalt als eins zu schreiben würde fälschlich einen Sättigungszustand behaupten. Grundlage: N10, PDF-S. 5.
]

#aufgabe(titel: "R134a bei 10 bar und 300 kJ je kg (Variante)", art: "rechnen", quelle: "4.4", herkunft: "variante", minuten: 8, vorlage: "Vorlesung 10.11., Folie 04-10 / PDF-S. 5")[
#if not web [*Aufgabe 345* #linebreak()]
*Von KI erstellt.* *Gegeben:* Dasselbe R134a-Diagramm, diesmal ein Zustand bei $p=10$ bar und $h=300$ kJ/kg.
#image("abbildungen/r134a-angabe.svg", width: 100%)
*Gesucht:* a) Markiere den neuen Punkt und benenne das Gebiet. b) Lies Temperatur und ungefähren Dampfgehalt ab. c) Begründe, warum $p,T$ allein $h$ dort nicht festlegen.
][
*Punkt bestimmen:* Die 300-kJ/kg-Senkrechte mit der 10-bar-Waagerechten schneiden. Der Punkt liegt innerhalb der Sättigungsglocke, also im Nassdampfgebiet.
][
*Linien ablesen:* Die Sättigungstemperatur liegt bei etwa 40 °C. Die x-Linien geben ungefähr $x=0,25$–$0,30$; keine höhere Genauigkeit aus dieser Grafik behaupten.
][
*Freiheitsgrad erklären:* Im Nassdampf sind Druck und Temperatur gekoppelt. Erst $x$ oder eine andere zusätzliche Stoffgröße legt den Phasenanteil und damit die Enthalpie fest. Das bleibt dieselbe Ablesemethode wie im Original.
]

#aufgabe(titel: "Druckbehälter mit Nassdampf von 180 auf 100 Grad abkühlen", art: "rechnen", quelle: "4.4", herkunft: "original", vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.16", minuten: 20,
  ergebnis: [Vorher: $p = "10,026" thin "bar"$, $x approx "0,409"$; nachher: $p = "1,0142" thin "bar"$, $x approx "0,0473"$; $Q approx -"24,7" thin "MJ"$])[
#if not web [*Aufgabe 346* #linebreak()]
*Gegeben und Annahmen*

In einem Druckbehälter von $2 thin "m"^3$ Inhalt befinden sich insgesamt 25 kg flüssiges Wasser und Dampf bei 180 °C. Durch Wärmeabfuhr sinkt die Temperatur im Behälter auf 100 °C. Der Behälter ist starr und geschlossen.

Dampftafel Wasser im Sättigungszustand (IAPWS-IF97):
#tab(columns: (0.9fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
 th([$vartheta_s$ °C], [$p_s$ bar], [$v'$ dm³/kg], [$v''$ m³/kg], [$h'$ kJ/kg], [$h''$ kJ/kg], [$s'$ kJ/(kg K)], [$s''$ kJ/(kg K)]),
 [100], [1,0142], [1,0435], [1,672], [419,1], [2675,6], [1,307], [7,354],
 [180], [10,026], [1,1274], [0,1939], [763,2], [2777,2], [2,140], [6,584],
)

*Gesucht*

#enum(numbering: "a)",
[Skizziere die Zustandsänderung in einem p,v- und in einem T,s-Diagramm.],
[Wie groß sind Druck und Dampfgehalt im Behälter vor und nach der Wärmeabfuhr?],
[Welche Wärme wird bei dieser Zustandsänderung abgegeben?],
[Markiere die abgegebene Wärme im T,s-Diagramm.],
)
][
*a) Skizzen:* Starr und geschlossen heißt $v = V\/m = "0,08" thin "m"^3/"kg" = "konst."$. Im p,v-Diagramm ist der Weg eine senkrechte Linie im Nassdampfgebiet von der 180-°C-Isotherme hinunter zur 100-°C-Isotherme. Im T,s-Diagramm führt er von ① nach links unten, weil Wärme abgeführt wird und die Entropie sinkt; beide Punkte liegen im Nassdampfgebiet auf der Isochore $v = "0,08"$.
][
*b) Druck und Dampfgehalt:* Im Nassdampfgebiet ist der Druck der Sättigungsdruck. Dampfgehalt aus $v = v' + x(v'' - v')$:
$ x_1 = ("0,08" - "0,0011274")/("0,1939" - "0,0011274") approx "0,409" quad p_1 = "10,026" thin "bar" $
$ x_2 = ("0,08" - "0,0010435")/("1,672" - "0,0010435") approx "0,0473" quad p_2 = "1,0142" thin "bar" $
Beim Abkühlen kondensiert der größte Teil des Dampfes.
][
*c) Wärme:* Erster Hauptsatz für das geschlossene starre System: $Q_12 = m(u_2 - u_1) = m(h_2 - h_1) - V(p_2 - p_1)$.
$ h_1 = "763,2" + "0,409" dot "2014,0" approx "1587,2" thin "kJ/kg" quad h_2 = "419,1" + "0,0473" dot "2256,5" approx "525,7" thin "kJ/kg" $
$ Q_12 approx 25 dot ("525,7" - "1587,2") - 2 dot ("101,42" - "1002,6") thin "kJ" approx -26 thin 537 + 1802 approx -24 thin 735 thin "kJ" $
Es werden rund 24,7 MJ Wärme abgegeben.
][
*d) Fläche im T,s-Diagramm:* Bei reversibler Wärmeabfuhr ist $q = integral T thin dif s$. Die abgegebene Wärme ist die Fläche unter dem Weg ①→② bis zur $s$-Achse. Mit $s_1 approx "3,958"$ und $s_2 approx "1,593" thin "kJ/(kg K)"$ liegt sie zwischen diesen beiden Entropiewerten.
]

#aufgabe(titel: "Kleinerer Druckbehälter mit 20 kg Nassdampf (Variante)", art: "rechnen", quelle: "4.4", herkunft: "variante", vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.16", minuten: 15,
  ergebnis: [$x_1 approx "0,383"$; $x_2 approx "0,0443"$; $Q approx -"19,0" thin "MJ"$])[
#if not web [*Aufgabe 347* #linebreak()]
*Gegeben und Annahmen*

Ein starrer Behälter mit $"1,5" thin "m"^3$ enthält 20 kg Wasser und Dampf bei 180 °C. Er wird auf 100 °C abgekühlt. Dampftafel wie im Original:
#tab(columns: (0.9fr, 1fr, 1fr, 1fr, 1fr, 1fr),
 th([$vartheta_s$ °C], [$p_s$ bar], [$v'$ dm³/kg], [$v''$ m³/kg], [$h'$ kJ/kg], [$h''$ kJ/kg]),
 [100], [1,0142], [1,0435], [1,672], [419,1], [2675,6],
 [180], [10,026], [1,1274], [0,1939], [763,2], [2777,2],
)

*Gesucht*

#enum(numbering: "a)",
[Dampfgehalte vor und nach dem Abkühlen.],
[Die abgegebene Wärme.],
)
][
*Dampfgehalte:* $v = "1,5"\/20 = "0,075" thin "m"^3/"kg"$; $x_1 = ("0,075" - "0,0011274")\/"0,19277" approx "0,383"$; $x_2 = ("0,075" - "0,0010435")\/"1,67096" approx "0,0443"$.
][
*Wärme:* $h_1 approx "1535,0"$, $h_2 approx "519,0" thin "kJ/kg"$;
$ Q = m(h_2 - h_1) - V(p_2 - p_1) approx 20 dot (-"1016,0") + "1,5" dot "901,2" thin "kJ" approx -18 thin 970 thin "kJ" approx -"19,0" thin "MJ" $
]
#aufgabe(titel: "Altklausur WS 02/03: Kurzfrage 11", art: "verstehen", quelle: "4.5", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 02/03, Kurzfrage 11 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 348* #linebreak()]
Wie heißt eine Zustandsänderung mit konstanter Entropie und unter welchen Annahmen ist sie vorstellbar?
][
*Antwort:* Konstante spezifische Entropie heißt isentrop. Ein adiabater reversibler Prozess erfüllt das; alternativ kann im irreversiblen Prozess Entropieabfuhr durch Kühlung die Erzeugung gerade kompensieren. Allein $Delta s=0$ beweist deshalb keine Reversibilität.
]

#aufgabe(titel: "T-s-Flächen: wann Wärme und wann Zustandsdifferenz?", art: "verstehen", quelle: "4.5", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 349* #linebreak()]
*Von KI erstellt.* Wann entspricht eine T-s-Fläche der Wärme, der Dissipation, einer Änderung der inneren Energie oder einer Enthalpieänderung? Warum kann ein isentroper Prozess trotzdem irreversibel sein?
][
*Antwort:*
- Intern reversibel: Fläche = Wärme.
- Adiabat mit Fluidreibung im Folienmodell: Fläche = Dissipation.
- Isochorer Gleichgewichtsweg: Fläche = $Delta u$; isobarer Gleichgewichtsweg: Fläche = $Delta h$.
- Isentrop mit Kühlung: abgeführte Wärme kann die Dissipation gerade ausgleichen.
*Begründung:* $T dif s=dif u+p dif v=dif h-v dif p$ und im Folienmodell $T dif s=delta q+delta j$. Grundlage: N10, PDF-S. 7–8.
][
*Typische Verwechslung:* Isentrop heißt $Delta s=0$, reversibel verlangt außerdem keine Entropieerzeugung. Eine starre Wand verhindert weder Wärmeleitung noch sämtliche inneren Reibungsvorgänge.
]

#aufgabe(titel: "Altklausur WS 03/04: Kurzfrage 4", art: "verstehen", quelle: "4.6", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 03/04, Kurzfrage 4 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 350* #linebreak()]
a) Skizziere im T-s-Diagramm die erforderliche Wärme, um Wasser vom Umgebungszustand isobar zu überhitzen. b) Welche Formel verbindet Wärme, Entropie und Temperatur bzw. Wärme und Enthalpie?
][
*Skizze erklären:* Im T-s-Diagramm zuerst die Isobare von der unterkühlten Flüssigkeit bis zur Siedelinie verfolgen, dann die waagerechte Verdampfung bis zur Taulinie, anschließend den ansteigenden Überhitzungsast. Im intern reversiblen Modell gilt $q=integral T dif s=Delta h$; die Temperatur der Energiefläche ist in Kelvin einzusetzen.
]

#aufgabe(titel: "Altklausur WS 99/00 LN: Kurzfrage 5", art: "verstehen", quelle: "4.6", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 99/00 LN, Kurzfrage 5 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 351* #linebreak()]
Welche Kurvensteigung liefert die Clausius-Clapeyron-Gleichung? Gib auch die Beziehung an.
][
*Antwort:* Die Clausius-Clapeyron-Gleichung liefert die Steigung der Dampfdruckkurve im p-T-Diagramm: $dif p_s/dif T=(h''-h')/[T(v''-v')]$. Sie beschreibt keine allgemeine Steigung beliebiger Isolinien im T-s-Diagramm.
]

#aufgabe(titel: "Übung 4.20: Zustände und Wege im T-s-Diagramm", art: "rechnen", quelle: "4.6", herkunft: "original", minuten: 25, vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.20; Vorlesung 10.11., Folien 04-14–15")[
#if not web [*Aufgabe 352* #linebreak()]
*Gegeben:* Originaldiagramm mit sechs Zuständen und den Zielpunkten A–D bzw. KP. Alle nötigen Isolinien und Ausgangsdaten stehen in der Abbildung.
#image("abbildungen/a420-angabe.svg", width: 100%)
*Gesucht:* a) Ergänze die Liste $p,v,vartheta,h,s,x$. b) Zeichne $integral T(s)dif s$ für 1→A, 2→B, 3→C, 4→D, 5→2, 6→KP. Nenne technische Beispiele und die Rolle von Wärme und Reibung. Grafische Näherungen genügen.
][
*Zustände ablesen:* Erst die jeweils gegebenen zwei unabhängigen Größen schneiden, dann die übrigen Linien verfolgen. Näherungswerte der Folienlösung:
#tab(columns: (auto,auto,auto,auto,auto,auto,auto),th([Nr.],[$p$ / bar],[$v$ / m³/kg],[$vartheta$ / °C],[$h$ / kJ/kg],[$s$ / kJ/(kg K)],[$x$]),
[1],[10],[0,04],[185],[1200],[3],[0,2],
[2],[9],[0,2],[170],[2000],[5],[0,65],
[3],[1],[1,7],[100],[2600],[7,4],[1],
[4],[49],[0,05],[300],[2850],[6,2],[–],
[5],[1000],[0,002],[455],[2000],[4,1],[–],
[6],[0,1],[10],[45],[1650],[5,2],[0,6])
Die Werte sind Ablesewerte, keine konsistent auf viele Stellen berechnete Dampftafel. Zustand 5 ist bei $p>p_"kr"$ und $T>T_"kr"$ *überkritisch*; das Folienwort „überhitzt“ ist dafür ungenau.
][
*1→A und 2→B:* 1→A folgt einer Isobare durch Verdampfung und Überhitzung; bei intern reversiblem Verlauf Wärmezufuhr, Fläche positiv. 2→B folgt einer Isochore im starren Gefäß, Kondensation und Wärmeabfuhr; Fläche negativ und gleich $Delta u$. Die Flächen bis zur $s$-Achse schraffieren; für Energiewerte zählt der Nullpunkt 0 K.
][
*3→C und 4→D:* 3→C ist isentrop nach oben: reversible adiabate Verdichtung oder gekühlte Verdichtung mit gerade kompensierter Entropieerzeugung. Fläche null. 4→D verläuft zu kleinerem Druck und größerer Entropie, z. B. eine reale Expansion mit Wärmezufuhr und/oder Reibung. Die Fläche allein trennt $q$ und $j$ nicht.
][
*5→2 und 6→KP:* 5→2 ist eine Drossel bei $h=2000$ kJ/kg: $q=0$, keine technische Arbeit, positive Entropieerzeugung. 6→KP folgt ungefähr $x=0,6$ zur kritischen Region; $p,T$ steigen und $v$ sinkt. Im reibungsfreien Vergleich einer Kolbenkompression wird Wärme abgeführt; nahe KP endet die Unterscheidung der Phasen.
][
*Plausibilität:* Ein Dampfgehalt steht nur im Zweiphasengebiet bzw. auf dessen Grenzlinien. Ein einzelnes T-s-Bild beweist ohne Prozessannahmen weder Wärmezufuhr noch Reibungsfreiheit. Grundlage: N10, PDF-S. 9–10; grafische Werte originalgetreu, Zustandsbezeichnung 5 fachlich präzisiert.
]

#aufgabe(titel: "T-s-Zustände mit geändertem Dampfgehalt (Variante)", art: "rechnen", quelle: "4.6", herkunft: "variante", minuten: 12, vorlage: "Übungsaufgaben WS 23/24, Aufg. 4.20; Vorlesung 10.11., Folien 04-14–15")[
#if not web [*Aufgabe 353* #linebreak()]
*Von KI erstellt.* *Gegeben und Annahmen:* Wasser bei 10 bar, Sättigungstemperatur 179,9 °C. Für diesen KI-Übungsdatensatz gelten gerundet $h'=763$ kJ/kg, $h''=2778$ kJ/kg, $s'="2,138"$ kJ/(kg K), $s''="6,585"$ kJ/(kg K), $v'="0,001127"$ m³/kg und $v''="0,1944"$ m³/kg. Die Gleichgewichtserwärmung erfolgt isobar und intern reversibel von $x_1="0,3"$ auf $x_2="0,8"$.
*Gesucht:* a) $h,s,v$ beider Zustände. b) Skizze im T-s-Diagramm. c) Wärme aus Enthalpie und aus T-s-Fläche; erkläre die kleine Abweichung.
][
*Mischungsregel:* Für jede Stoffgröße gilt $y=y'+x(y''-y')$. Damit: $h_1="1367,5"$, $h_2=2375$ kJ/kg; $s_1="3,4721"$, $s_2="5,6956"$ kJ/(kg K); $v_1="0,0591089"$, $v_2="0,1557454"$ m³/kg.
][
*Weg und Fläche:* Im Nassdampf liegen die Zustände auf derselben waagerechten Isotherme bei $T="453,05"$ K. Der Pfeil zeigt nach rechts. $q=Delta h="1007,5"$ kJ/kg. Über die Fläche: $T Delta s="453,05" dot "2,2235" approx "1007,36"$ kJ/kg.
][
*Abweichung prüfen:* Die 0,14 kJ/kg entstehen aus den ausdrücklich gerundeten und daher nicht exakt thermodynamisch konsistenten Übungswerten. Die Fläche mit 179,9 statt 453,05 zu multiplizieren wäre dagegen ein echter Temperaturfehler. Datensatz von KI zu Übungszwecken gerundet, gleiche Methode wie 4.20.
]

#aufgabe(titel: "Altklausur WS 02/03: Kurzfrage 6", art: "verstehen", quelle: "4.7", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 02/03, Kurzfrage 6 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 354* #linebreak()]
Nenne vier technische Apparate, deren Funktion näherungsweise auf einer ideal isobaren Zustandsänderung beruht.
][
*Antwort:* Dampferzeuger, Kondensator/Verflüssiger, Verdampfer und Wärmeübertrager werden im einfachen Modell näherungsweise isobar gerechnet. Reale Druckverluste werden dabei vernachlässigt. Die Druckkonstanz ist eine Modellannahme und keine durch den Bauteilnamen garantierte Eigenschaft.
]

#aufgabe(titel: "Altklausur WS 01/02: Kurzfrage 9", art: "verstehen", quelle: "4.7", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 01/02, Kurzfrage 9 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 355* #linebreak()]
Welche Aufgabe hat die Zwischenüberhitzung in einem Dampfkraftprozess?
][
*Antwort:* Zwischenüberhitzung hebt die Dampftemperatur zwischen Turbinenstufen wieder an. Dadurch lässt sich die mittlere Wärmezufuhrtemperatur erhöhen und am Austritt ein höherer Dampfgehalt erreichen; die Turbine wird weniger durch Nässe belastet. Ob und wie stark der thermische Wirkungsgrad steigt, ist mit den konkreten Druck- und Temperaturdaten zu prüfen.
]

#aufgabe(titel: "Altklausur WS 01/02: Kurzfrage 10", art: "verstehen", quelle: "4.7", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 01/02, Kurzfrage 10 (Import 12.11.2026, PDF-S. 2)")[
#if not web [*Aufgabe 356* #linebreak()]
Skizziere einen reversiblen Carnot-Prozess im p-v- und T-s-Diagramm und leite damit den Carnot-Wirkungsgrad her.
][
*Herleitung:* Zwei Isothermen bei $T_H,T_K$ und zwei Isentropen schließen im T-s-Diagramm ein Rechteck ein. $q_"zu"=T_H Delta s$, $abs(q_"ab")=T_K Delta s$, also $eta_C=1-T_K/T_H$. Im p-v-Diagramm verbinden zwei Isothermen die jeweils steileren reversiblen Adiabaten; die Umlaufrichtung ist für die Wärmekraftmaschine rechtsläufig. Alle Temperaturen in Kelvin.
]

#aufgabe(titel: "Altklausur WS 01/02: Kurzfrage 11", art: "verstehen", quelle: "4.7", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 01/02, Kurzfrage 11 (Import 12.11.2026, PDF-S. 2)")[
#if not web [*Aufgabe 357* #linebreak()]
Zu welchem Zweck wird in der Praxis der Carnot-Prozess verwendet?
][
*Antwort:* Der Carnot-Prozess ist ein reversibler theoretischer Vergleich für die maximal erreichbare Arbeitsausbeute zwischen zwei festen Temperaturniveaus. Er dient zur Beurteilung realer Anlagen, nicht als Beschreibung einer tatsächlich verlustfreien Maschine.
]

#aufgabe(titel: "Altklausur WS 00/01: Kurzfrage 8", art: "verstehen", quelle: "4.7", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 00/01, Kurzfrage 8 (Import 12.11.2026, PDF-S. 2)")[
#if not web [*Aufgabe 358* #linebreak()]
Skizziere einen reversiblen Carnot-Prozess im T-s-Diagramm und leite damit den Carnot-Wirkungsgrad her.
][
*Herleitung:* Zwei Isothermen bei $T_H,T_K$ und zwei Isentropen schließen im T-s-Diagramm ein Rechteck ein. $q_"zu"=T_H Delta s$, $abs(q_"ab")=T_K Delta s$, also $eta_C=1-T_K/T_H$. Im p-v-Diagramm verbinden zwei Isothermen die jeweils steileren reversiblen Adiabaten; die Umlaufrichtung ist für die Wärmekraftmaschine rechtsläufig. Alle Temperaturen in Kelvin.
]

#aufgabe(titel: "Altklausur WS 99/00 PF: Kurzfrage 7", art: "verstehen", quelle: "4.7", herkunft: "original", minuten: 3, vorlage: "Altklausur WS 99/00 PF, Kurzfrage 7 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 359* #linebreak()]
Eine Erfindung verspricht, aus 100 MW zugeführtem Wärmestrom bei 1000 °C eine elektrische Leistung von 100 MW zu liefern. Was hältst du davon?
][
*Antwort:* Eine zyklisch arbeitende Wärmekraftmaschine kann zwischen einer endlichen heißen Temperatur und einer kälteren Umgebung nicht die gesamte zugeführte Wärme in Arbeit umwandeln. Der erste Hauptsatz allein würde die Bilanz zulassen; der zweite verlangt Wärmeabfuhr und begrenzt den Wirkungsgrad durch Carnot. Ohne Angabe des kalten Reservoirs lässt sich kein genauer Prozentwert berechnen.
]

#aufgabe(titel: "Altklausur Übungsklausur WS 99/00: Kurzfrage 3", art: "verstehen", quelle: "4.7", herkunft: "original", minuten: 3, vorlage: "Altklausur Übungsklausur WS 99/00, Kurzfrage 3 (Import 12.11.2026, PDF-S. 1)")[
#if not web [*Aufgabe 360* #linebreak()]
Vergleiche beim Wärmepumpenprozess zugeführte und abgeführte Wärme. Warum sind die Beträge verschieden?
][
*Antwort:* Eine Wärmepumpe gibt an der warmen Seite mehr Wärme ab, als sie an der kalten Seite aufnimmt. Die Differenz ist der zugeführte Arbeitsaufwand: $abs(Q_"warm")=Q_"kalt"+W_"zu"$. Energie wird weder erzeugt noch vervielfacht.
]

#aufgabe(titel: "Altklausur Übungsklausur WS 99/00: Kurzfrage 14", art: "verstehen", quelle: "4.7", herkunft: "original", minuten: 3, vorlage: "Altklausur Übungsklausur WS 99/00, Kurzfrage 14 (Import 12.11.2026, PDF-S. 2)")[
#if not web [*Aufgabe 361* #linebreak()]
Was sind die vier Hauptanlagenkomponenten des Clausius-Rankine-Prozesses? Skizziere den Prozess im p-v- und T-s-Diagramm und kennzeichne isotherme und isobare Abschnitte.
][
*Antwort:* Speisepumpe → Dampferzeuger → Turbine → Kondensator. Im T-s-Bild ideal zwei Isentropen für Pumpe/Turbine und zwei Isobaren für Wärmezufuhr/-abfuhr; reale adiabate Maschinenwege gehen zu größerem s. Im p-v-Bild steigt beim Pumpen der Druck bei fast gleichem Flüssigkeitsvolumen; Verdampfung vergrößert v stark, Expansion senkt p und vergrößert v, Kondensation verkleinert v. Wärmezu- und -abfuhr an den Wärmeübertragern, Arbeitszu-/-abgabe an Pumpe/Turbine markieren.
]

#aufgabe(titel: "Rankine und Plank an den Bauteilen erklären", art: "verstehen", quelle: "4.7", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 362* #linebreak()]
*Von KI erstellt.* Beschreibe die vier Hauptbauteile des Rankine- und des Plank-Prozesses. Welcher Prozess liefert Arbeit, welcher braucht sie? Was ändert sich zwischen idealer Turbine, realer Turbine und Drossel?
][
*Antwort:*
- Rankine: Pumpe → Dampferzeuger → Turbine → Kondensator; Nettoarbeitsabgabe.
- Plank: Verdampfer → Verdichter → Verflüssiger → Drossel; Arbeitszufuhr.
- Ideal adiabate Turbine: $s$ konstant. Reale adiabate Turbine: $s$ steigt, kleinere Arbeitsabgabe.
- Adiabate Drossel ohne äußere Energieänderung: $h$ konstant und keine technische Arbeit.
*Begründung:* Jeder Bauteil vereinfacht dieselbe stationäre Energie- und Entropiebilanz anders. Grundlage: N10, PDF-S. 12–13.
][
*Typische Verwechslung:* Ein im Lehrbild idealisierter Plank-Prozess enthält trotzdem eine irreversible Drossel; er ist deshalb kein Carnot-Prozess.
]

#aufgabe(titel: "Carnot-Rechteck und Kelvin-Verhältnis erklären", art: "verstehen", quelle: "4.7", herkunft: "eigen", minuten: 3)[
#if not web [*Aufgabe 363* #linebreak()]
*Von KI erstellt.* Warum hat der Carnot-Kreisprozess im T-s-Diagramm die Form eines Rechtecks? Leite seinen Wirkungsgrad her und erkläre, warum Celsius-Verhältnisse ungeeignet sind.
][
*Antwort:*
- Zwei Isothermen bilden die waagerechten Seiten; zwei Isentropen die senkrechten.
- $q_"zu"=T_H Delta s$, $abs(q_"ab")=T_K Delta s$.
- $eta_C=(q_"zu"-abs(q_"ab"))/q_"zu"=1-T_K/T_H$.
- Die Temperatur muss vom absoluten Nullpunkt aus zählen, also in Kelvin.
*Begründung:* Die Nettoarbeitsabgabe ist die eingeschlossene reversible T-s-Fläche. Grundlage: N11, PDF-S. 1–2; Herleitung aus dem gezeigten Rechteck.
]

#aufgabe(titel: "Altklausur WS 03/04: Kaffee als Wärmequelle", art: "rechnen", quelle: "4.7", herkunft: "original", minuten: 6, vorlage: "Altklausur WS 03/04, Kurzfrage 8, PDF-S. 1")[
#if not web [*Aufgabe 364* #linebreak()]
*Originalfrage:* An einem kalten Tag (0 °C) kochst du Kaffee. Wie viel Prozent davon könntest du theoretisch in Strom umwandeln? *Einordnung:* Nenne die für eine eindeutige Rechnung nötige Zusatzannahme und berechne damit den reversiblen Anfangsvergleich.
][
*Fehlende Angabe sichtbar machen:* Die heiße Temperatur wird in der Frage nicht ausdrücklich genannt. Die historische Lösung verwendet frisch siedenden Kaffee bei 100 °C als konstantes heißes Niveau. Das ist eine zusätzliche Modellannahme; beim Abkühlen wäre der Wirkungsgrad fortlaufend kleiner.
][
*Carnot-Vergleich:* $T_H="373,15"$ K, $T_K="273,15"$ K. $eta_C=1-"273,15"/"373,15" approx "26,7989"$ %. Das gilt für zugeführte Wärme bei diesem festen heißen Niveau; der Kaffee selbst ist keine Energiemenge mit eindeutig vorgegebenem Nullpunkt.
]

#aufgabe(titel: "Altklausur WS 03/04: Kaffee als Wärmequelle (Variante)", art: "rechnen", quelle: "4.7", herkunft: "variante", minuten: 6, vorlage: "Altklausur WS 03/04, Kurzfrage 8, PDF-S. 1")[
#if not web [*Aufgabe 365* #linebreak()]
*Von KI erstellt.* *Gegeben:* Zwei konstante Reservoirs bei 90 °C und 10 °C. *Gesucht:* maximaler Wärmekraftmaschinen-Wirkungsgrad.
][
*Kelvin-Verhältnis:* $eta_C=1-"283,15"/"363,15" approx "22,0295"$ %. Reale elektrische Umsetzung hat weitere Verluste.
]

#aufgabe(titel: "Altklausur WS 99/00: Bügeleisen und Carnot", art: "rechnen", quelle: "4.7", herkunft: "original", minuten: 6, vorlage: "Altklausur WS 99/00 PF, Kurzfrage 8, PDF-S. 2")[
#if not web [*Aufgabe 366* #linebreak()]
*Gegeben:* Carnot-Maschine zwischen Bügeleisen (127 °C; gerundet 400 K) und Unterlage (27 °C; gerundet 300 K). *Gesucht:* maximaler Wirkungsgrad; begründe die verwendete Temperaturskala.
][
*Gegebene Kelvinwerte verwenden:* $eta_C=1-300/400="0,25"=25$ %. Die Celsiuswerte sind im Original passend auf ganze Kelvin gerundet. Die Energieflächen und ihre Verhältnisse beziehen sich auf den absoluten Nullpunkt.
]

#aufgabe(titel: "Altklausur WS 99/00: Bügeleisen und Carnot (Variante)", art: "rechnen", quelle: "4.7", herkunft: "variante", minuten: 6, vorlage: "Altklausur WS 99/00 PF, Kurzfrage 8, PDF-S. 2")[
#if not web [*Aufgabe 367* #linebreak()]
*Von KI erstellt.* *Gegeben:* Carnot-Maschine zwischen 450 K und 300 K; Wärmezufuhr pro Umlauf 900 J. *Gesucht:* maximaler Wirkungsgrad, Nettoarbeit und Wärmeabfuhr.
][
*Bilanz:* $eta_C=1-300/450=1/3$. Nettoarbeitsabgabe 300 J; Wärmeabgabe 600 J. $900/450=600/300=2$ J/K bestätigt den reversiblen Entropieausgleich.
]

#aufgabe(titel: "Carnot-Vergleich bei 500 und 20 Grad", art: "rechnen", quelle: "4.7", herkunft: "eigen", minuten: 8)[
#if not web [*Aufgabe 368* #linebreak()]
*Von KI erstellt.* *Gegeben und Annahmen:* Reversible Wärmekraftmaschine zwischen 500 °C und 20 °C; pro Umlauf nimmt sie 1200 kJ Wärme auf. Genau zwei konstante Reservoirtemperaturen.
*Gesucht:* a) Wirkungsgrad, b) Nettoarbeitsabgabe und Wärmeabfuhr, c) Entropiebilanz pro Umlauf.
][
*Kelvin und Vergleich:* $T_H="773,15"$ K, $T_K="293,15"$ K. $eta_C=1-"293,15"/"773,15" approx "0,620837"$ = 62,08 %.
][
*Energie aufteilen:* $abs(W_"netto")=eta_C Q_"zu" approx "745,004"$ kJ und $abs(Q_"ab") approx "454,996"$ kJ. In Zufuhrkonvention: $W_"netto"<0$, $Q_"ab"<0$.
][
*Entropie prüfen:* $Q_"zu"/T_H approx "1,552092"$ kJ/K und $abs(Q_"ab")/T_K$ sind gleich. Der Arbeitsstoff kehrt zum Anfangszustand zurück, und im reversiblen Gesamtprozess entsteht keine Entropie. Grundlage: eigene Zahlenvariante der N11-Flächenbeziehung.
]

