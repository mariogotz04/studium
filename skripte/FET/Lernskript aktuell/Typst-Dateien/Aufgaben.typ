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


#kapitel("Kapitel 1 · Grundbegriffe")

// 0-1
#aufgabe(titel: "Thermodynamik an der Fahrradpumpe", art: "verstehen", quelle: "1.0")[
Wie würdest du Thermodynamik an einer Fahrradpumpe erklären?
][
Bei der Pumpe verändert zugeführte Arbeit den Gaszustand. Temperatur, Druck und Volumen beschreiben die Folge; die Energiebilanz erklärt die Energiezufuhr.
]

// 0-2
#aufgabe(titel: "Geschlossen und adiabat", art: "verstehen", quelle: "1.1.3")[
Kann ein geschlossenes System Arbeit übertragen? Und ein adiabates?
][
Ja. Geschlossen verbietet nur Stofftransport; adiabat verbietet nur Wärmeübertragung.
]

// 0-3
#aufgabe(titel: "Konstantes Volumen und Arbeitsdichtheit", art: "verstehen", quelle: "1.1.3")[
Was ist der Unterschied zwischen konstantem Volumen und vollständiger Arbeitsdichtheit?
][
$dif V=0$ schließt Volumenarbeit aus. Rührer- und elektrische Arbeit müssen zusätzlich ausgeschlossen werden, wenn insgesamt keine Arbeit übertragen werden soll.
]

// 0-4
#aufgabe(titel: "Interne Ströme im Kraftwerk", art: "verstehen", quelle: "1.1.3")[
Warum sind interne Ströme in der Gesamtbilanz eines Kraftwerks nicht sichtbar?
][
Sie verlassen die gemeinsame Bilanzhülle nicht. Eine Abgabe des einen Teils ist die Aufnahme des anderen.
]

// 0-5
#aufgabe(titel: "Tank mit Zu- und Abfluss", art: "rechnen", quelle: "1.1.1",
  ergebnis: [$dif m\/dif t = -"0,5" thin "kg/s"$; leer nach $1000 thin "s" approx "16,7" thin "min"$],
  tipp: [Was im Tank bleibt, ist Zufluss minus Abfluss. Ist das Ergebnis positiv oder negativ?],
)[
Ein Tank enthält $500 thin "kg"$. Es fließen $2 thin "kg/s"$ hinein und $"2,5" thin "kg/s"$ hinaus. Bestimme Änderungsrate und Leerungszeit bei konstanten Strömen.
][
*Bild:* Der Tank ist wie ein Konto. Die Änderung pro Sekunde ist Einzahlung minus Auszahlung. Massenbilanz: $dif m\/dif t = dot(m)_"zu" - dot(m)_"ab"$.
][
*Änderungsrate:* $dif m\/dif t = 2 - "2,5" = -"0,5" thin "kg/s"$. Das Minus heißt: Der Tank verliert jede Sekunde ein halbes Kilogramm.
][
*Leerungszeit:* Bei konstanter Rate ist die Abnahme linear. $t = 500 thin "kg"\/"0,5" thin "kg/s" = 1000 thin "s" approx "16,7" thin "min"$.
][
*Prüfen:* kg geteilt durch kg/s ergibt s. Die Rechnung gilt nur, solange die Ströme wirklich konstant bleiben; ein füllstandsabhängiger Ausfluss würde langsamer werden.
]

// 0-6
#aufgabe(titel: "Stationär und trotzdem ungleich", art: "verstehen", quelle: "1.2")[
Warum kann eine stationäre Strömung räumliche Temperatur- und Geschwindigkeitsunterschiede besitzen?
][
Stationär bedeutet zeitlich unverändert am festen Ort. Ein Teilchen kann auf seinem Weg dennoch andere Werte durchlaufen.
]

// 0-7
#aufgabe(titel: "Extensiv, intensiv, spezifisch", art: "verstehen", quelle: "1.4")[
Erkläre extensiv, intensiv und spezifisch am Beispiel eines geteilten Wasserbehälters.
][
Gesamtmasse und Gesamtvolumen halbieren sich. Dichte, Temperatur und spezifisches Volumen bleiben bei Teilung eines homogenen Zustands gleich.
]

// 0-8
#aufgabe(titel: "Zustandsgröße und Prozessgröße", art: "verstehen", quelle: "1.6")[
Warum ist der Druck eine Zustandsgröße und die Arbeit eine Prozessgröße?
][
Der Druckunterschied zwischen zwei Zuständen hängt nur von deren Werten ab. Die Arbeit hängt zusätzlich vom Prozessweg ab, also von der Fläche unter der Kurve.
]

// 0-9
#aufgabe(titel: "Luft im starren Behälter erwärmen", art: "rechnen", quelle: "1.6.1",
  ergebnis: [$m approx "11,88" thin "kg"$, $p_2 approx "6,02" thin "bar"$ absolut],
  tipp: [Die ideale Gasgleichung braucht Kelvin und Pascal. Im starren Behälter bleiben Masse und Volumen gleich.],
)[
Luft: $V=2 thin "m"^3$, $p_1=5 thin "bar"$ absolut, $theta_1=20 thin "°C"$, $R="287,2" thin "J/(kg K)"$. Bestimme die Masse. Der geschlossene starre Behälter wird auf $80 thin "°C"$ erwärmt. Bestimme $p_2$.
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

// 0-10
#aufgabe(titel: "Absoluter Druck aus der Manometeranzeige", art: "rechnen", quelle: "1.7",
  ergebnis: [$p_"abs" = "3,16" thin "bar" = 316 thin 000 thin "Pa"$],
)[
Ein Manometer zeigt $"2,2" thin "bar"$, Umgebung $"0,96" thin "bar"$. Welcher Druck gehört in die Gasgleichung?
][
*Was misst ein Manometer?* Es vergleicht den Behälterdruck mit der Umgebung. Es zeigt den *Überdruck*, also wie viel mehr drinnen drückt als draußen.
][
*Absoluter Druck:* Die Gasgleichung beschreibt die Stöße aller Moleküle, gemessen vom Vakuum aus. $p_"abs" = p_"ü" + p_"amb" = "2,2" + "0,96" = "3,16" thin "bar"$.
][
*In Pascal:* $"3,16" thin "bar" = 316 thin 000 thin "Pa"$. *Prüfen:* Der absolute Druck ist immer größer als die Anzeige, solange ein Überdruck herrscht.
]

// 0-11
#aufgabe(titel: "Halber Rohrdurchmesser", art: "rechnen", quelle: "1.5",
  ergebnis: [Die Geschwindigkeit wird viermal so groß.],
)[
Bei stationärer inkompressibler Strömung halbiert sich der Rohrdurchmesser. Wie ändert sich die mittlere Geschwindigkeit?
][
*Kontinuität:* Stationär und inkompressibel heißt: Was vorne hineinfließt, muss hinten heraus. Der Volumenstrom $dot(V) = A c$ bleibt überall gleich.
][
*Fläche:* $A = pi d^2\/4$. Halber Durchmesser ergibt $(1\/2)^2 = 1\/4$ der Fläche.
][
*Geschwindigkeit:* Durch ein Viertel der Fläche muss derselbe Volumenstrom, also $c_2 = 4 c_1$.
][
*Prüfen:* Gartenschlauch: Daumen auf die Öffnung, und das Wasser spritzt schneller.
]

// 0-12
#aufgabe(titel: "Adiabates Rühren", art: "verstehen", quelle: "1.10")[
Warum kann adiabates Rühren die Temperatur erhöhen, und warum ist es irreversibel?
][
Rührarbeit wird in innere Energie umgewandelt. Die Umkehr der Drehrichtung kehrt die Dissipation nicht um; System und Umgebung lassen sich dadurch nicht spurlos zurücksetzen.
]

// 0-13
#aufgabe(titel: "Bestand und zeitlicher Mittelwert", art: "verstehen", quelle: "1.1.1")[
Warum lässt sich aus $dif m/dif t$ allein die aktuelle Behältermasse nicht bestimmen? Wann darfst du einen zeitlichen Mittelwert als arithmetischen Mittelwert der beiden Randwerte berechnen?
][
Eine Rate sagt nur, *wie schnell sich etwas ändert*. Den aktuellen Bestand erhältst du erst mit einer Anfangsbedingung:
$ m(t)=m_0+integral_0^t dot(m)_"netto" dif tau $
Der Mittelwert der beiden Randwerte ist nur bei *linearem* Zeitverlauf zugleich der Zeitmittelwert. Bei einer Parabel gilt das allgemein nicht; unterschiedlich lange Messintervalle brauchen Zeitgewichte.
]

// 0-14
#aufgabe(titel: "Ideales Gas, ideales Fluid, Beschleunigung", art: "verstehen", quelle: "1.2")[
Was unterscheidet ein ideales Gas von einem idealen Fluid? Kann ein stationär strömendes Teilchen beschleunigt sein?
][
*Ideales Gas:* $p v=R T$, veränderliche Dichte erlaubt. *Ideales Fluid in BS:* inkompressibel und reibungsfrei.

Ein Teilchen kann in einer stationären Düse beschleunigen, weil es räumlich verschiedene Geschwindigkeiten durchläuft. Am festen Ort bleiben die Werte zeitlich gleich: *konvektive Beschleunigung*.
]

// 0-15
#aufgabe(titel: "Zeitabhängige Massenbilanz", art: "rechnen", quelle: "1.1.1")[
*Zeitabhängiger Behälter, Ü 1.1:* Ein Behälter mit konstanter Fläche $A$ enthält anfangs $m_0=rho A h_0$. Es gelten $dot(m)_"zu"=z t$, $dot(m)_"ab"=a t$ und $rho="konstant"$. Bestimme $m(t)$, $h(t)$, die drei Fälle $z>a$, $z=a$, $z<a$, beide mittleren Massenströme und den mittleren Füllstand im Intervall $t_1$ bis $t_2$.
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

// 0-16
#aufgabe(titel: "Badewanne vollständig bilanzieren", art: "rechnen", quelle: "1.1.1")[
*Badewanne, Ü 1.2:* Anfangs leer, $400 thin "l"$ Inhalt, Zuflüsse $30 thin "l/min"$ und $"0,1" thin "l/s"$. Vom maximalen Abfluss $90 thin "l/min"$ bleiben 20 Prozent frei. Jedes Rostloch führt $"0,25" thin "l/min"$ ab. Berechne für ein Loch Massenänderung, Wasserinhalt als Zeitfunktion und Füllzeit. Bestimme den erforderlichen Überlauf bei vollständig blockiertem Bodenabfluss einschließlich Löchern sowie die maximal zulässige Lochzahl bei normalem Teilabfluss, damit der Pegel nicht sinkt. Nutze $rho=1 thin "kg/l"$ und konstante Ströme.
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

// 0-17
#aufgabe(titel: "Boiler, Mittelwert und Spitzenlast", art: "rechnen", quelle: "1.1.1")[
*Boiler, Ü 1.3:* $400 thin "l"$ Wasser sollen von 6 auf 80 °C erwärmt werden. Nutze $rho=1 thin "kg/l"$, die Mittelwerte $C_6="4,21037"$ und $C_80="4,18665" thin "kJ/(kg K)"$ mit Bezug auf 0 °C. Bestimme Energie und Leistung für 4 h, 6 h und 0,5 h. Für nachströmendes Kaltwasser mit 6 °C: Welche Dauerleistung deckt 1 l/min, welche 10 l/min? Warum kann ein Speicher den erforderlichen Spitzenwert der elektrischen Anschlussleistung verringern?
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

// 0-18
#aufgabe(titel: "Wasserbad mit knickfreiem Temperaturverlauf", art: "rechnen", quelle: "1.1.1")[
*Wasserbad, Ü 1.4, Tutorium und WZF:* Von 6 auf 70 °C wird mit 10 K/h geheizt. Die letzten 20 K bis 90 °C um 12:00 Uhr verlaufen parabolisch, am Übergang knickfrei und am Ende mit Steigung null. Bestimme Parabel, Übergangszeit, Einschaltzeit und spezifische Heizleistung mit $c=4200 thin "J/(kg K)"$. Es ist keine Wassermasse vorgegeben. Erläutere die Systemgrenze und die ideale Halteleistung.
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

// 0-19
#aufgabe(titel: "Gartenschlauch und Düse", art: "rechnen", quelle: "1.5")[
*Gartenschlauch, Ü 1.7:* 25 l füllen einen Eimer in 50 s. Der Schlauchdurchmesser beträgt 20 mm, die Düsenöffnung 8 mm. Bestimme Volumenstrom und beide Geschwindigkeiten. Wie lange dauert das Füllen mit einem anderen Schlauch bei $dot(m)="0,2" thin "kg/s"$? Nutze $rho=1000 thin "kg/m"^3$.
][
*Strategie:* Füllmenge / Zeit liefert den Volumenstrom; dann $c=dot(V)/A$.
$ dot(V)=25/50 thin "l/s"="0,5" thin "l/s"=5 times 10^(-4) thin "m"^3/"s" $
$ A_1=pi ("0,020" thin "m")^2/4="3,1416" times 10^(-4) thin "m"^2 $
$ A_2=pi ("0,008" thin "m")^2/4="5,0265" times 10^(-5) thin "m"^2 $
Somit *$c_1="1,59" thin "m/s"$* und *$c_2="9,95" thin "m/s"$*.

Anderer Schlauch: $dot(V)=dot(m)/rho="0,2" thin "l/s"$, also *$t=25/"0,2"=125 thin "s"$*. Die größere Geschwindigkeit in der Düse passt zum kleineren Querschnitt bei vorgegebenem Volumenstrom.
]

// 0-20
#aufgabe(titel: "Füllstandsabhängiger Ausfluss", art: "rechnen", quelle: "1.1.1")[
*Freier Ausfluss, vereinfachter Teil von Ü 1.5:* Ein offener zylindrischer Behälter mit $D=1 thin "m"$, Anfangshöhe $H="1,25" thin "m"$ und Auslassdurchmesser $d="12,5" thin "mm"$ wird reibungsfrei entleert. Vernachlässige Auslasshöhe, Luftdichte und Oberflächengeschwindigkeit wie in Teil b der Originalaufgabe. Leite $h(t)$ und die Leerungszeit her. Wann ist die Hälfte des Anfangsvolumens abgeflossen?
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

// 0-21
#aufgabe(titel: "Förderleistung und Wirkungsgrade", art: "rechnen", quelle: "1.1.1")[
*Förderpumpe, Ü 1.8:* Elektrisch werden 32 kW zugeführt, der Motor gibt 90 Prozent als Wellenleistung ab. Es gelten $dot(V)="0,125" thin "m"^3/"s"$, $rho=800 thin "kg/m"^3$, $Delta p=275 thin "kPa"$, $D_1=100 thin "mm"$, $D_2=150 thin "mm"$. Vernachlässige Höhen- und Temperaturänderung. Berechne Geschwindigkeiten, Netto-Förderleistung, Pumpenwirkungsgrad bezogen auf die Welle und Gesamtwirkungsgrad bezogen auf die elektrische Leistung.
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


#kapitel("Kapitel 2 · Stoffeigenschaften")

// 1-1
#aufgabe(titel: "Fünf Abschnitte der Erwärmung", art: "verstehen", quelle: "2.1")[
Erkläre die fünf Abschnitte der Erwärmung von Eis bis überhitztem Dampf. Warum kann eine Phasenumwandlung im Diagramm waagerecht oder senkrecht erscheinen?
][
Feststoff erwärmen, schmelzen, Flüssigkeit erwärmen, verdampfen, Dampf erwärmen. Beim Phasenwechsel bleibt $T$ unter den genannten isobaren Gleichgewichtsbedingungen konstant. Die Orientierung hängt davon ab, auf welcher Achse $T$ steht.
]

// 1-2
#aufgabe(titel: "Wann Q = m(h″ − h′) gilt", art: "verstehen", quelle: "2.1")[
Unter welchen Voraussetzungen gilt beim Verdampfen $Q=m(h''-h')$?
][
Reiner Stoff im Gleichgewicht bei konstantem Druck unterhalb des kritischen Drucks; vollständiger Wechsel von gesättigter Flüssigkeit zu gesättigtem Dampf. Für ein geschlossenes System: nur Volumenarbeit, keine wesentlichen äußeren Energieänderungen. Ein passender stationärer Verdampfer liefert dieselbe Wärmebeziehung bei entsprechender Vernachlässigung weiterer Beiträge.
]

// 1-3
#aufgabe(titel: "Unterkühlt, Nassdampf, Sattdampf, überhitzt", art: "verstehen", quelle: "2.4")[
Wodurch unterscheiden sich unterkühlte Flüssigkeit, Nassdampf, Sattdampf und überhitzter Dampf?
][
Unterkühlt: $T<T_s(p)$. Nassdampf: beide Phasen. Sattdampf: gesättigter Dampf am Rand $x=1$. Überhitzt: $T>T_s(p)$.
]

// 1-4
#aufgabe(titel: "Nassdampf: p und T reichen nicht", art: "verstehen", quelle: "2.9")[
Warum reichen $p$ und $T$ im Nassdampfgebiet nicht zur Festlegung des Mischungszustands?
][
Im Zweiphasengleichgewicht gilt $T=T_s(p)$. Die beiden Angaben sind gekoppelt; der Massenanteil der Phasen bleibt unbekannt.
]

// 1-5
#aufgabe(titel: "Dampfgehalt aus den Massen", art: "rechnen", quelle: "2.9",
  ergebnis: [$x = "0,25"$, $m' = "1,5" thin "kg"$],
)[
Ein Behälter enthält $2 thin "kg"$ Gemisch, darunter $"0,5" thin "kg"$ Dampf. Bestimme $x$ und die Flüssigkeitsmasse.
][
*Definition:* Der Dampfgehalt ist der *Massenanteil* des Dampfes am Gemisch: $x = m''\/m$.
][
*Einsetzen:* $x = "0,5"\/2 = "0,25"$. Ein Viertel der Masse ist Dampf.
][
*Flüssigkeit:* Der Rest ist Flüssigkeit, $m' = m - m'' = "1,5" thin "kg"$.
][
*Prüfen:* $x$ liegt zwischen 0 (nur Flüssigkeit) und 1 (nur Dampf). Volumenmäßig ist der Dampf trotzdem fast der ganze Behälter, weil er viel mehr Platz braucht.
]

// 1-6
#aufgabe(titel: "Enthalpie und Volumen im Nassdampf", art: "rechnen", quelle: "2.9",
  ergebnis: [$h = "1094,75" thin "kJ/kg"$, $v approx "0,50893" thin "m"^3\/"kg"$],
  tipp: [Ein Nassdampf-Wert liegt zwischen dem Flüssigkeits- und dem Dampfwert, und zwar beim Anteil $x$.],
)[
Gegeben: $h'="417,5"$, $h''=2675 thin "kJ/kg"$, $v'="0,001043"$, $v''="1,694" thin "m"^3/"kg"$. Bestimme $h$ und $v$ für $x="0,3"$.
][
*Mischungsregel verstehen:* 1 kg Nassdampf besteht aus $x$ kg Dampf und $1 - x$ kg Flüssigkeit. Jeder Teil bringt seinen spezifischen Wert mit: $h = (1 - x) h' + x h'' = h' + x(h'' - h')$. Das ist ein Hebel zwischen den beiden Randwerten.
][
*Enthalpie:* $h = "417,5" + "0,3" dot (2675 - "417,5") = "417,5" + "677,25" = "1094,75" thin "kJ/kg"$.
][
*Volumen:* $v = "0,001043" + "0,3" dot ("1,694" - "0,001043") approx "0,50893" thin "m"^3\/"kg"$.
][
*Prüfen:* Beide Werte liegen zwischen den Randwerten. Beim Volumen dominiert der Dampf fast völlig, obwohl nur 30 % der Masse Dampf sind.
]

// 1-7
#aufgabe(titel: "Dampfgehalt aus der Enthalpie", art: "rechnen", quelle: "2.9",
  ergebnis: [$x approx "0,631"$],
)[
Welcher Dampfgehalt ergibt sich aus $h=2200$, $h'=1827$ und $h''=2418 thin "kJ/kg"$?
][
*Hebelregel rückwärts:* Aus $h = h' + x(h'' - h')$ wird $x = (h - h')\/(h'' - h')$. Gefragt ist: Welcher Bruchteil des Wegs von $h'$ nach $h''$ ist schon zurückgelegt?
][
*Einsetzen:* $x = (2200 - 1827)\/(2418 - 1827) = 373\/591 approx "0,631"$.
][
*Prüfen:* $h$ liegt etwas über der Mitte zwischen 1827 und 2418, also muss $x$ etwas über 0,5 liegen.
]

// 1-8
#aufgabe(titel: "Überkritisch erwärmen", art: "verstehen", quelle: "2.6")[
Warum benötigt auch ein überkritischer Erwärmungsweg Energie, obwohl er keine gewöhnliche Verdampfungsenthalpie besitzt?
][
Seine Enthalpie steigt kontinuierlich. Es entfällt der separate latente Phasensprung, nicht der Energiebedarf für die Zustandsänderung.
]

// 1-9
#aufgabe(titel: "Isochor erwärmen: v gegen v_kr", art: "verstehen", quelle: "2.7")[
Welche Rolle spielt $v$ im Vergleich zu $v_"kr"$ beim isochoren Erwärmen von Nassdampf?
][
Bei $v>v_"kr"$ Austritt aus dem Zweiphasengebiet zur Dampfseite; bei $v<v_"kr"$ zur Flüssigkeitsseite. Nach vollständiger Raumausfüllung durch Flüssigkeit kann der Druck stark steigen.
]

// 1-10
#aufgabe(titel: "Realgasfaktor Z", art: "verstehen", quelle: "2.2")[
Was bedeutet $Z=1$ und warum darfst du $Z$ nicht für jeden Zustand eines realen Gases gleich wählen?
][
$Z=1$ ist die ideale thermische Gasbeziehung. Der reale Faktor hängt vom Zustand ab; eine unveränderte Übernahme kann falsche Stoffwerte liefern.
]

// 1-11
#aufgabe(titel: "Kritischer Punkt und Tripelpunkt", art: "verstehen", quelle: "2.4")[
Was verschwindet am kritischen Punkt? Was koexistiert am Tripelpunkt?
][
Kritischer Punkt: Unterschiede zwischen koexistierender Flüssigkeit und Dampf verschwinden. Tripelpunkt: feste, flüssige und gasförmige Phase koexistieren.
]

// 1-12
#aufgabe(titel: "Dampfdruckkurve und Schmelzkurve", art: "verstehen", quelle: "2.1")[
Warum steigt die Dampfdruckkurve, während die Schmelzkurve gewöhnlichen Eises im betrachteten Bereich fällt?
][
Clapeyron: positive Umwandlungsenthalpie geteilt durch $T$ und Volumenänderung. Verdampfung hat positive Volumenänderung; Schmelzen gewöhnlichen Eises hat negative.
]

// 1-13
#aufgabe(titel: "Wärmerohr", art: "verstehen", quelle: "1.1.3")[
Warum kann ein geschlossenes Wärmerohr Wärme transportieren, obwohl seine Gesamtmasse konstant bleibt?
][
Am warmen Ende nimmt Verdampfen Energie auf, am kalten gibt Kondensieren sie ab. Dampf und Kondensat zirkulieren *innerhalb* der geschlossenen Grenze. Stationär bleiben Gesamtmasse und gespeicherte Energie konstant; zugeführte und abgegebene Wärme gleichen sich aus.
]

// 1-14
#aufgabe(titel: "Tabellenbezug und einheitlicher Datensatz", art: "verstehen", quelle: "2.1")[
Eine Tabelle nennt bei 80 °C eine mittlere Wärmekapazität mit Bezug auf 0 °C. Darfst du diesen Wert unverändert für 6 → 80 °C verwenden? Warum dürfen Enthalpiewerte verschiedener Tabellen nicht ungeprüft kombiniert werden?
][
Der Mittelwert 0 → 80 °C enthält einen anderen Temperaturbereich. Für 6 → 80 °C wird die Enthalpiezunahme 0 → 6 °C von der Zunahme 0 → 80 °C abgezogen. Unterschiedliche Tabellen können verschiedene Referenznullpunkte für Enthalpie und Entropie verwenden; eine willkürliche Kombination erzeugt dann falsche Differenzen. Innerhalb eines konsistenten Datensatzes fällt ein gemeinsamer Bezugsnullpunkt bei der Differenzbildung heraus.
]

// 1-15
#aufgabe(titel: "Einfache und doppelte Interpolation", art: "rechnen", quelle: "2.10")[
*Interpolation, Ü 1.10 a und c:* Nutze die folgende verkürzte Originaltabelle für R134a. Bestimme bei 100 °C und 1130 kPa die Werte $v,h,s,c_p$. Bestimme außerdem bei 105,3 °C und 1100 kPa die Werte $v,h,c_p$ durch doppelte Interpolation und prüfe beide Reihenfolgen.
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

// 1-16
#aufgabe(titel: "Ammoniak: wenig Dampfmasse, viel Dampfvolumen", art: "rechnen", quelle: "2.9")[
*Ammoniak-Ampulle, Ü 2.3:* $V="14,8" thin "cm"^3$, $m="1,63" thin "g"$, $theta=-20 thin "°C"$. Verwende aus BT $v'="0,00150"$ und $v''="0,62280" thin "m"^3/"kg"$. Bestimme Dampfgehalt, Dampfvolumen und Flüssigkeitsvolumenanteil.
][
*Erst umrechnen:* $V="14,8" times 10^(-6) thin "m"^3$, $m="1,63" times 10^(-3) thin "kg"$. Das spezifische Gesamtvolumen ist:
$ v=V/m approx "0,00907975" thin "m"^3/"kg" $
Es liegt zwischen $v'$ und $v''$: Das Zweiphasenmodell ist plausibel. Mit der Hebelregel:
$ x=("0,00907975"-"0,00150")/("0,62280"-"0,00150") approx "0,01220" $
Das sind *1,22 Prozent der Masse*. Die Dampfmasse beträgt etwa $"0,01989" thin "g"$. Das Dampfvolumen folgt aus der Dampfmasse, nicht aus $x V$:
$ V''=x m v'' approx "12,385" thin "cm"^3 $
Somit $V'="14,8"-"12,385" approx "2,415" thin "cm"^3$. Die Flüssigkeit belegt rund *16,32 Prozent des Volumens*, der Dampf 83,68 Prozent. *Fehlerquelle:* 1,22 Prozent Dampfmasse mit 1,22 Prozent Dampfvolumen gleichsetzen. Leichte Abweichungen von gerundeten Buchergebnissen entstehen durch das Runden der Zwischenwerte.
]

// 1-17
#aufgabe(titel: "Sauerstoffflasche: ideal und real", art: "rechnen", quelle: "1.6.1")[
*Sauerstoffflasche, Auszug aus Ü 2.5 a–c und e:* $V="58,5" thin "l"$, Überdruck 232 bar bei $T_1=300 thin "K"$, Umgebung 1 bar, Abkühlung auf −18,3 °C. Nutze $R="259,8" thin "J/(kg K)"$. Berechne Masse und Enddruck zuerst ideal, dann mit $Z_1="0,958155"$ und dem für den Endzustand vorgegebenen $Z_2="0,85949475"$. Die Flasche bleibt dicht und starr.
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

// 1-18
#aufgabe(titel: "Fünf Energieanteile beim Erwärmen", art: "rechnen", quelle: "2.1")[
*Erwärmungskurve, vereinfachte Ü 2.2:* 1 kg Eis soll bei 1 bar von −15 °C bis zu 200 °C heißem Wasserdampf erwärmt werden. Rechne näherungsweise mit Schmelzen bei 0 °C, Sieden bei 99,603 °C, $c_"Eis"="2,04" thin "kJ/(kg K)"$, $r_"S"="333,5" thin "kJ/kg"$, mittlerem $c_"Wasser"="4,19030" thin "kJ/(kg K)"$, $r_"V"="2257,5" thin "kJ/kg"$ und angenommenem mittlerem $c_"Dampf"="2,0" thin "kJ/(kg K)"$. Bestimme alle fünf Energieanteile und die Summe. Erkläre die Form im Temperatur-Energie-Diagramm.
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

// 1-19
#aufgabe(titel: "Stickstoff: Volumenanteile und Förderung", art: "rechnen", quelle: "1.7")[
*Stickstoffgefäß, Auszug aus Ü 2.1 a–b:* Ein Volumen von $"0,05" thin "m"^3$ enthält bei 1 bar zu 90 Volumenprozent Flüssigkeit und zu 10 Prozent Dampf. Es gelten $v'_1="0,0012398"$, $v''_1="0,21947" thin "m"^3/"kg"$. Bestimme Teilmassen, Gesamtmasse, Dampfgehalt und mittleres spezifisches Volumen. Für das Anheben der Flüssigkeit um $"5,143" thin "m"$ gegen 1 bar Umgebung: Prüfe den erforderlichen Behälterdruck näherungsweise mit $v'("1,4" thin "bar")="0,0012611" thin "m"^3/"kg"$; bei diesem Druck ist $T_s="80,21" thin "K"$.
][
*Teilvolumina:* $V'="0,045" thin "m"^3$, $V''="0,005" thin "m"^3$. Wir teilen jeweils durch das spezifische Volumen der betreffenden Phase:
$ m'=V'/v' approx "36,296" thin "kg" quad quad m''=V''/v'' approx "0,022782" thin "kg" $
Also *$m approx "36,319" thin "kg"$*, $x=m''/m approx "0,0006273"$, also nur *0,06273 Prozent Dampfmasse*. Das spezifische Gesamtvolumen ist $v=V/m approx "0,0013767" thin "m"^3/"kg"$. Die zehn Volumenprozent Dampf sind eindeutig keine zehn Massenprozent.

*Anheben bis zum gerade noch ruhenden Austritt:* Der nötige Behälterüberdruck trägt die Flüssigkeitssäule:
$ p_2-p_0=rho'_2 g Delta z=g Delta z/v'_2 $
$ p_2 approx 1 thin "bar"+("9,81" times "5,143")/"0,0012611" thin "Pa" approx "1,400" thin "bar" $
Das ist mit dem verwendeten Sättigungswert bei 1,4 bar konsistent; dort ist $T_2="80,21" thin "K"$, also −192,94 °C. Die Flüssigkeitsdichte wird am Zustand 2 verwendet. Der Druck an der Behälteroberfläche muss *höher* als der Umgebungsdruck sein, damit die Säule aufsteigen kann. Für einen endlichen Ausfluss kämen Bewegungsenergie und reale Verluste hinzu. Die weiteren Entnahmeteile stehen jetzt in Lösung 26 dieses Kapitels, die vollständige Energiebilanz und Zustandsgrößentabelle in Kapitel 3, Lösung 9.
]

// 1-20
#aufgabe(titel: "Bottich mit genauer Wärmekapazität", art: "rechnen", quelle: "1.3")[
*Beheizter Bottich, Ü 2.9:* Wasser füllt einen Bottich mit 45 cm × 30 cm × 10 cm. Von 6 auf 86 °C, $rho=1 thin "kg/l"$, Heizleistung 1,8 kW, Verluste und Behälterwärmekapazität vernachlässigt. Die auf 0 °C bezogenen Mittelwerte bei 1 bar sind $C_6="4,21037"$, $C_86="4,18745" thin "kJ/(kg K)"$. Bestimme Masse, Energie und Aufheizzeit.
][
Das Volumen ist $V="0,45" times "0,30" times "0,10"="0,0135" thin "m"^3="13,5" thin "l"$. Damit $m="13,5" thin "kg"$. Bei vernachlässigter Verdunstung, Behälterwärmekapazität und Verlusten landet die elektrische Energie im Wasser.

Aus den auf 0 °C bezogenen Mittelwerten:
$ Delta h=("4,18745" times 86-"4,21037" times 6) thin "kJ/kg"="334,85848" thin "kJ/kg" $
$ E approx m Delta h="4520,58948" thin "kJ" $
Mit $P="1,8" thin "kJ/s"$ folgt *$Delta t=E/P approx 2511 thin "s" approx "41,86" thin "min"$*. Zum Vergleich: $overline(c)_(p,12)=Delta h/(80 thin "K") approx "4,18573" thin "kJ/(kg K)"$. Die Watt-Kilowatt-Umrechnung ist entscheidend: Kilojoule durch Kilowatt ergibt Sekunden.
]

// 1-21
#aufgabe(titel: "Verdampfer: Masse bleibt, Volumenstrom wächst", art: "rechnen", quelle: "1.5")[
*Verdampfer, Auszug aus Ü 1.14 a–b und c.1–3:* R134a strömt mit $A_1="0,76" thin "cm"^2$ und $c_1="0,035" thin "m/s"$ als Flüssigkeit ein. Nutze $v_1 approx "0,0007" thin "m"^3/"kg"$. Am Austritt: $A_2="3,04" thin "cm"^2$, $x_2="0,88"$, $v'_2="0,0007"$, $v''_2="0,1205" thin "m"^3/"kg"$ aus BT. Berechne Massenstrom, Austrittsgeschwindigkeit sowie die beiden Phasenvolumenströme. Modell: gemeinsame mittlere Phasengeschwindigkeit.
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

// 1-22
#aufgabe(titel: "Massenanteil und Molanteil", art: "verstehen", quelle: "2.12.2")[
Luft enthält „23 %“ und „21 %“ Sauerstoff. Wie passt das zusammen?
][
23 % ist der *Massenanteil* $xi_"O2"$, 21 % der *Molanteil* $psi_"O2"$. Sauerstoffmoleküle sind schwerer als der Durchschnitt der Luft ($32>"28,96" thin "kg/kmol"$), darum ist ihr Massenanteil größer: $xi=psi M_i/M_g="0,2099" dot 32/"28,964" approx "0,232"$.
]

// 1-23
#aufgabe(titel: "Stickstoff-Sauerstoff-Gemisch", art: "rechnen", quelle: "2.12.2",
  ergebnis: [$psi_"N2" approx "0,667"$, $psi_"O2" approx "0,333"$; $M_g approx "29,344" thin "kg/kmol"$; $xi_"N2" approx "0,6365"$, $xi_"O2" approx "0,3635"$; $R_g approx "283,3" thin "J/(kg K)"$],
  tipp: [Molanteile kommen direkt aus den kmol. Für die Massenanteile brauchst du zuerst die mittlere Molmasse.],
)[
*Gemisch:* 2 kmol N#sub[2] und 1 kmol O#sub[2] werden gemischt ($M_"N2"="28,016"$, $M_"O2"=32 thin "kg/kmol"$). Bestimme $psi_i$, $M_g$, $xi_i$ und $R_g$.
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

// 1-24
#aufgabe(titel: "Feuchter Stickstoff", art: "rechnen", quelle: "2.12.2",
  ergebnis: [$M_g = "27,08" thin "kg/kmol"$; $xi_"H2O" approx "0,093"$, $xi_"CO2" approx "0,049"$, $xi_"N2" approx "0,858"$],
)[
*Feuchter Stickstoff, BT Beispiel 3.9:* 100 kmol Gemisch enthalten 14 kmol Wasserdampf ($M=18$), 3 kmol CO#sub[2] ($M=44$), Rest N#sub[2] ($M=28 thin "kg/kmol"$). Bestimme $M_g$ und die Massenanteile.
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

// 1-25
#aufgabe(titel: "Partialdruck und Partialvolumen", art: "rechnen", quelle: "2.12.2")[
*Partialgrößen, eigenes Zahlenbeispiel nach N S. 2:* Ein ideales Gasgemisch enthält 25 Mol-% A bei $p_g=2 thin "bar"$ und $V_g=4 thin "m"^3$. Bestimme den Partialdruck und das Partialvolumen von A. Warum widersprechen sich die Aussagen „gleicher Druck“ und „kleinerer Druck“ hier nicht?
][
*Modell:* ideale Gase bei gemeinsamer Temperatur. $psi_A="0,25"$.
][
*Gesamtes Volumen festhalten:* $p_A=psi_A p_g="0,25" dot 2 thin "bar"$. Ergebnis: *$p_A="0,5" thin "bar"$*.
][
*Gemischdruck festhalten:* $V_A=psi_A V_g="0,25" dot 4 thin "m"^3$. Ergebnis: *$V_A=1 thin "m"^3$*.
][
*Prüfung:* Beide Anteile sind 25 Prozent; $p_A V_g=p_g V_A=2 thin "bar m"^3$. Beim Partialdruck füllt A allein 4 m³, beim Partialvolumen allein 1 m³. Deshalb gehören die beiden Druckaussagen zu verschiedenen gedanklichen Zuständen.
]

// 1-26
#aufgabe(titel: "Stickstoff: Restmasse und Nachverdampfen", art: "rechnen", quelle: "2.13.2")[
*Stickstoffgefäß, Ü 2.1 c–d; W23 und M2:* Verwende das Gefäß und die Werte aus „Stickstoff: Volumenanteile und Förderung“ und Abschnitt 2.13.2. Ab dem Entnahmebeginn soll der Druck bei 1,4 bar bleiben. Wie viel Flüssigkeit lässt sich maximal entnehmen, wenn am Ende nur Sattdampf im starren Gefäß bleibt? Wie viel muss für die Entnahme von 1 kg Flüssigkeit verdampfen? Zeige die Massen- und Volumenbilanz und deute das Vorzeichen von $Delta m$ und $Delta m''$.
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

// 1-27
#aufgabe(titel: "Sättigungstemperatur prüfen", art: "rechnen", quelle: "2.13.3")[
*R134a-Verdampfer, Ü 1.14 c.4–10; M1:* Ergänze „Verdampfer: Masse bleibt, Volumenstrom wächst“ mit den Stoffwerten aus 2.13.3. Bestimme am Austritt $h_2$, $dot(H)_2$, $u_2$, $s_2$, $dot(S)_2$ sowie die Enthalpieströme der Flüssigkeit und des Sattdampfes. Prüfe ihre Summe. Warum ist der Eintritt bei −20 °C und 164,2 kPa flüssig? Bestimme außerdem näherungsweise die Sättigungstemperatur durch Interpolation zwischen −15 °C bei 163,90 kPa und −10 °C bei 200,60 kPa.
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

// 1-28
#aufgabe(titel: "Temperatur rückwärts aus dem Volumen", art: "rechnen", quelle: "2.13.1")[
*Rückwärtige Interpolation, Ü 1.10 b; T22:* Bei $p=1200$ kPa ist $v="0,02300"$ m³/kg gegeben. Nutze die Tabelle zu „Einfache und doppelte Interpolation“ und bestimme die Temperatur. Welche Größe gehört auf die Eingabeachse, wenn die Temperatur gesucht wird? Prüfe anschließend durch Einsetzen in die vorwärts gerichtete Interpolation.
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


#kapitel("Kapitel 3 · Energiebilanzen: Erster Hauptsatz")

// 2-1
#aufgabe(titel: "Erster Hauptsatz mit der Teich-Analogie", art: "verstehen", quelle: "3.1")[
Erkläre einem Laien mit der Teich-Analogie, was der erste Hauptsatz aussagt und warum Wärme und Arbeit keine Zustandsgrößen sind.
][
Der Wasserstand (gespeicherte Energie) ändert sich um das, was durch die Bäche netto zu- oder abfließt. Ist das Wasser im Teich, weiß man nicht mehr, ob es als „Wärme“ oder „Arbeit“ kam: Gespeichert ist nur Energie. $Q$ und $W$ existieren nur während des Übertragens und hängen vom Weg ab.
]

// 2-2
#aufgabe(titel: "Enthalpie im offenen System", art: "verstehen", quelle: "3.1.1")[
Warum steht im 1. HS für offene Systeme die Enthalpie $h$, im geschlossenen System aber die innere Energie $u$?
][
Im offenen System muss Stoff gegen den Druck hinein- und hinausgeschoben werden. Diese Verschiebearbeit $p v$ steckt in $h=u+p v$. Im geschlossenen System fließt kein Stoff über die Grenze, also gibt es keine Verschiebearbeit.
]

// 2-3
#aufgabe(titel: "Druckarbeit und Volumenarbeit", art: "verstehen", quelle: "3.1.2")[
Welche Arbeit gehört zum offenen, welche zum geschlossenen System: $integral v dif p$ oder $-integral p dif v$? Wozu dient das Minuszeichen?
][
Offen: Druckarbeit $w_p=integral v dif p$ (Teil von $w_t$). Geschlossen: Volumenarbeit $w_v=-integral p dif v$ (Teil von $w_g$). Bei Kompression ist $dif v<0$; das Minus macht die zugeführte Arbeit positiv.
]

// 2-4
#aufgabe(titel: "Energiemenge und Wärmestrom", art: "verstehen", quelle: "3.1")[
Was unterscheidet die Energiemenge $Q_12$ von dem Wärmestrom $dot(Q)_12$? Welche Einheiten haben sie, und kann auch ein geschlossenes System einen Wärmestrom aufnehmen?
][
Die geschlossene Bilanz vergleicht hier eine Energiemenge zwischen zwei Zeitpunkten: $Q_12$ in kJ. Die offen-stationäre Bilanz verwendet einen Energiestrom: $dot(Q)_12=dot(m)q_12$ in kW. Der Punkt heißt „pro Zeit“; auch ein geschlossenes System kann einen Wärmestrom aufnehmen.
]

// 2-5
#aufgabe(titel: "Fallende Bleikugel erwärmt sich", art: "rechnen", quelle: "3.1.4")[
*Kugel, Variante:* Dieselbe Bleikugel ($c_"Pb"=130 thin "J/(kg K)"$) fällt aus $z_1=50 thin "m"$ mit $c_1=10 thin "m/s"$. Um wie viel erwärmt sie sich höchstens?
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

// 2-6
#aufgabe(titel: "Adiabate Turbine: Leistung mit Vorzeichen", art: "rechnen", quelle: "3.1.1")[
*Turbine (eigenes Zahlenbeispiel):* Eine adiabate Dampfturbine wird stationär mit $dot(m)=10 thin "kg/s"$ durchströmt, $h_1=3200 thin "kJ/kg"$, $h_2=2500 thin "kJ/kg"$. Änderungen von $c$ und $z$ sind vernachlässigbar. Bestimme $P$ und deute das Vorzeichen.
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

// 2-7
#aufgabe(titel: "Rührer im starren Behälter", art: "rechnen", quelle: "3.1.3")[
*Rührer:* In einen starren, adiabaten Behälter werden mit einem Rührer $50 thin "kJ"$ Arbeit eingebracht. Wie ändert sich $U$? Welcher Sonderfall aus 3.1.3 liegt vor, und warum ist es *kein* abgeschlossenes System?
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

// 2-8
#aufgabe(titel: "Düse: Enthalpie wird Bewegungsenergie", art: "rechnen", quelle: "3.1.1")[
*Düse:* In einer adiabaten Düse ohne technische Arbeit und ohne Höhenänderung sinkt die Enthalpie um $45 thin "kJ/kg"$. Eintrittsgeschwindigkeit $c_1=50 thin "m/s"$. Bestimme $c_2$.
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

// 2-9
#aufgabe(titel: "Stickstoff: Heizerenergie und Zustandsgrößen", art: "rechnen", quelle: "3.2.1")[
*Stickstoffgefäß, Ü 2.1 e–g; W23 und M2:* Verwende die Daten aus „Stickstoff: Restmasse und Nachverdampfen“ und Abschnitt 2.13.2. Bestimme die Heizerenergie für die Entnahme von 1 kg Flüssigkeit. Stelle für Zustand ② die 13 Größen $p,T,x,mu,v,h,u,s,m,V,H,U,S$ jeweils für Gesamtgemisch, gesättigte Flüssigkeit und Sattdampf zusammen, mit Einheit, Einordnung und Formelzusammenhang. Berechne danach $Delta H_23$ und $Delta S_23$. Prüfe, wie die Änderungen der Gesamtgrößen zu den spezifischen Größen und zur Energiezufuhr passen.
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

