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


#kapitel("Kapitel 1 · KLR und Deckungsbeitragsrechnung")

// 0-1
#aufgabe(titel: "Fixe und variable Kosten", art: "verstehen", quelle: "1.2")[
#if not web [*Aufgabe 1* #linebreak()]
*Begriffe:* Erkläre fixe und variable Kosten mit je zwei Beispielen aus Ü 1. Weshalb ist „je Stück“ allein noch kein Beweis für variable Kosten? (Ü, PDF-S. 1; L15, PDF-S. 11.)
][
*Fix/variabel:* Miete und Gehälter sind in Ü 1 monatlich fix; RHB-Stoffe und Akkordlohn werden je Packung verursacht. Aber $k_f=K_f/x$ ist ebenfalls ein Stückbetrag, obwohl sein Gesamtbetrag fix ist. Der Kostenanfall, nicht die Schreibweise allein, entscheidet.
]

// 0-2
#aufgabe(titel: "Mischkosten zerlegen", art: "verstehen", quelle: "1.2")[
#if not web [*Aufgabe 2* #linebreak()]
*Mischkosten:* Was musst Du vor dem Rechnen mit ihnen tun? Erkläre es am Grundpreis einer Stromrechnung. (Ü, PDF-S. 1, Randnotiz; L15, PDF-S. 4.)
][
*Mischkosten:* In einen festen Grundbetrag und einen mengenabhängigen Anteil zerlegen. Beim Strombeispiel ist der Grundpreis fix, der Verbrauchspreis je kWh variabel. Erst danach eine lineare Kostenfunktion aufstellen.
]

// 0-3
#aufgabe(titel: "Sprungfixe Kosten", art: "verstehen", quelle: "1.2")[
#if not web [*Aufgabe 3* #linebreak()]
*Sprungfix:* Was ändert sich beim Überschreiten der Grenze in der Randzeichnung? Warum ist ein unverändertes $K_f$ über die Grenze hinweg falsch? (Ü, PDF-S. 1.)
][
*Sprungfix:* Der feste Kostenblock steigt an einer Mengengrenze. Mehr Menge verteilt dann nicht nur dieselben Fixkosten; es kommen neue hinzu. Deshalb musst Du für den neuen Bereich ein neues $K_f$ ansetzen.
]

// 0-4
#aufgabe(titel: "Kapazität und Beschäftigungsgrad", art: "rechnen", quelle: "1.1")[
#if not web [*Aufgabe 4* #linebreak()]
*Kapazität:*

*Gegeben und Annahmen*

Kapazität 7 000 Stück pro Stunde; tatsächliche Produktion 4 900 Stück pro Stunde.

*Gesucht*

#enum(numbering: "a)",
[Erkläre, weshalb die Angabe „7 000 Stück“ allein unvollständig ist.],
[Berechne den Beschäftigungsgrad.],
)
][
*Kapazität:* Der Zeitbezug bestimmt das Leistungsvermögen. $4900/7000 dot 100 %=70 %$; 30 % sind in dieser Stunde ungenutzt. Eine Monatsmenge darfst Du nicht direkt durch eine Stundenkapazität teilen.
]

// 0-5
#aufgabe(titel: "Warum die Stückkosten sinken", art: "verstehen", quelle: "1.3")[
#if not web [*Aufgabe 5* #linebreak()]
*Stückkosten:* Warum sinkt $k(x)$ bei wachsender Menge? Kann $k$ bei positivem $K_f$ unter $k_v$ fallen? Was passiert bei $x=0$? (Ü 1, PDF-S. 1; L15, PDF-S. 4–5; Präzisierung.)
][
*Stückkosten:* Bei positivem $K_f$ sinkt $K_f/x$ mit wachsendem $x$. $k_v$ bleibt unverändert. Daher liegt $k=K_f/x+k_v$ bei endlichem $x>0$ über $k_v$. Bei $x=0$ ist die Division nicht definiert; $K(0)=K_f$ bleibt sinnvoll.
]

// 0-6
#aufgabe(titel: "Deckungsbeitrag mit dem Eimerbild", art: "verstehen", quelle: "1.4")[
#if not web [*Aufgabe 6* #linebreak()]
*Deckungsbeitrag:* Erkläre mit dem Eimerbild, was ein Stückdeckungsbeitrag ist und weshalb er noch nicht der Gewinn je Stück sein muss. (M, PDF-S. 2; L15, PDF-S. 5.)
][
*Stück-DB:* Der Eimer wird mit $e-k_v$ je Stück gefüllt. Dieser Betrag muss zuerst die Fixkosten mittragen. Gewinn je Stück ist erst $d b_"II"=d b_"I"-K_f/x$; er hängt von der Menge ab.
]

// 0-7
#aufgabe(titel: "Schreibweisen des Deckungsbeitrags", art: "verstehen", quelle: "1.4")[
#if not web [*Aufgabe 7* #linebreak()]
*Schreibweise:* Unterscheide $d b_"I",d b_"II",D B_"I",D B_"II"$ in der einstufigen Rechnung. Nenne Einheiten und Umrechnung. (M, PDF-S. 1–2; K, PDF-S. 1.)
][
*Stück und gesamt:* $d b_"I"=e-k_v$ und $d b_"II"=d b_"I"-k_f$ sind €/Stück. $D B_"I"=d b_"I" x$ und im einstufigen Schema $D B_"II"=D B_"I"-K_f=G$ sind €/Periode. Multipliziere Stückwerte mit der zugehörigen Menge; umgekehrt teile durch $x>0$.
]

// 0-8
#aufgabe(titel: "Gewinnschwelle herleiten", art: "verstehen", quelle: "1.5")[
#if not web [*Aufgabe 8* #linebreak()]
*Gewinnschwelle:* Leite $x_"BEP"$ aus $E=K$ her. Wann ist die Formel sinnvoll? Was gilt am exakten BEP für $G$ und $D B_"I"$? (M, PDF-S. 2; F, PDF-S. 5.)
][
*Herleitung:* $e x=K_f+k_v x => (e-k_v)x=K_f => x=K_f/(e-k_v)$. Für positive Fixkosten wird ein positiver Stück-DB benötigt. Am exakten Schnittpunkt ist $G=0$ und $D B_"I"=K_f$. Bei einer aufgerundeten ganzen Menge kann bereits ein kleiner Gewinn entstehen.
]

// 0-9
#aufgabe(titel: "Wo das Gewinnmaximum liegt", art: "verstehen", quelle: "1.5.1")[
#if not web [*Aufgabe 9* #linebreak()]
*Gewinnmaximum:* Unter welchen Voraussetzungen liegt es an der Kapazität? Was ändert sich bei negativem Stück-DB oder fehlender Nachfrage? (K, PDF-S. 1; L15, PDF-S. 6; eigene Präzisierung.)
][
*Maximum:* Bei positivem, konstantem Stück-DB und unveränderten Fixkosten wächst $G$ linear mit der verkauften Menge. Volle Kapazität ist nur dann das Maximum, wenn sie abgesetzt werden kann. Bei negativem DB verschlechtert mehr Menge das Ergebnis; geringere Nachfrage begrenzt den Absatz früher.
]

// 0-10
#aufgabe(titel: "Wie sich der BEP verschiebt", art: "verstehen", quelle: "1.5.1")[
#if not web [*Aufgabe 10* #linebreak()]
*Veränderungen:* Wie wirken höhere Fixkosten, höhere variable Stückkosten, höhere bzw. niedrigere Verkaufspreise auf den BEP? Begründe jeweils über den Stück-DB. (L15, PDF-S. 7, aus Ü abgeleitet.)
][
*BEP-Wirkung:* Höhere $K_f$: mehr Beiträge erforderlich, BEP steigt. Höhere $k_v$: weniger Beitrag je Stück, BEP steigt. Höheres $e$: mehr Beitrag, BEP sinkt. Niedrigeres $e$: weniger Beitrag, BEP steigt. Das gilt bei sonst gleichen Werten und weiterhin positivem Stück-DB.
]

// 0-11
#aufgabe(titel: "Kurz- und langfristige Preisuntergrenze", art: "verstehen", quelle: "1.6.2")[
#if not web [*Aufgabe 11* #linebreak()]
*Preisuntergrenzen:* Weshalb unterscheiden sich die kurz- und langfristige Grenze im einfachen Modell? Bedeutet $e_"Z"=k_v$ bereits einen zusätzlichen Gewinn? (Ergänzung aus L15, PDF-S. 8.)
][
*Preisgrenzen:* Kurzfristig sind bei den genannten Bedingungen nur die durch den Auftrag entstehenden Kosten zu decken. Bei $e_"Z"=k_v$ ist $Delta G=0$, kein zusätzlicher Gewinn. Langfristig muss die geplante Menge auch $K_f$ decken; im einfachen Modell daher $e>=k(x)$.
]

// 0-12
#aufgabe(titel: "Bedingungen für einen Zusatzauftrag", art: "verstehen", quelle: "1.6.2")[
#if not web [*Aufgabe 12* #linebreak()]
*Zusatzauftrag:* Welche Bedingungen brauchst Du für $Delta G=(e_"Z"-k_v)x_"Z"$? Nenne das Kundenrisiko und erkläre, warum nicht nochmals alle Fixkosten abgezogen werden. (Ü 1, PDF-S. 1.)
][
*Zusatzauftrag:* Freie Kapazität, keine Verdrängung, unveränderte Fixkosten und keine unberücksichtigten Zusatzkosten; der bisherige Verkaufspreis bleibt bestehen. $K_f$ fällt in beiden Alternativen ohnehin an und hebt sich im Differenzvergleich auf. Risiko: Bisherige Kunden fordern den niedrigeren Preis; außerdem ist Kapazität gebunden.
]

// 0-13
#aufgabe(titel: "Differenzenansatz für zwei Perioden", art: "verstehen", quelle: "1.7")[
#if not web [*Aufgabe 13* #linebreak()]
*Zwei Perioden:* Erkläre den Differenzenansatz für $k_v$. Welche Voraussetzungen und welche Gegenprobe sind nötig? (Ü 3, PDF-S. 2.)
][
*Zwei Perioden:* $(Delta K)/(Delta x)$ ist die Steigung der angenommenen gemeinsamen Kostenlinie. Vorausgesetzt sind derselbe Zeitraum, dasselbe $K_f$ und $k_v$ sowie verschiedene Mengen. Mit $K_f=K-k_v x$ müssen beide Perioden denselben festen Anteil liefern.
]

// 0-14
#aufgabe(titel: "BEP oberhalb der Kapazität", art: "verstehen", quelle: "1.8.1")[
#if not web [*Aufgabe 14* #linebreak()]
*Unerreichbare Schwelle:* Was bedeutet BEP > Kapazität? Nenne Stellschrauben und den Haken einer Erweiterung. (Ü 2, PDF-S. 2.)
][
*BEP über Kapazität:* Bei positivem Stück-DB reicht selbst Vollauslastung nicht zur Kostendeckung. Preis erhöhen, variable Kosten oder Fixkosten senken kann die Schwelle senken. Erweiterung erhöht die mögliche Menge, kann aber auch neue Fixkosten erzeugen; beide Wirkungen zusammen prüfen.
]

// 0-15
#aufgabe(titel: "Beschäftigungsgrad als Puffer", art: "verstehen", quelle: "1.5")[
#if not web [*Aufgabe 15* #linebreak()]
*Beschäftigungsgrad:* Warum lässt ein hoher BG am BEP wenig Puffer? Unterscheide theoretische Schwelle und kleinste ganze Menge ohne Verlust. (Ü 4, PDF-S. 2; Präzisierung.)
][
*Puffer:* Ein Absatzrückgang erreicht die Verlustzone schneller, wenn der BEP nahe an der Kapazität liegt. Die theoretische Schwelle kann zwischen zwei ganzen Stückzahlen liegen. Die kleinste ganze Menge ohne Verlust ist dann die nächsthöhere Zahl; ihren BG ausdrücklich als ganzzahligen Fall kennzeichnen.
]

// 0-16
#aufgabe(titel: "Von der KLR zur Investitionsrechnung", art: "verstehen", quelle: "1.8.2")[
#if not web [*Aufgabe 16* #linebreak()]
*Zusammenhang:* Wie helfen Kostenfunktion und DB beim späteren Beurteilen einer neuen Maschine? Beschreibe nur die Verbindung zur bisherigen Basis. (Gliederung, PDF-S. 1; L15, PDF-S. 1 und 13.)
][
*Verbindung:* Eine neue Maschine kann den festen Kostenblock, die variablen Stückkosten und die mögliche Menge verändern. Die KLR macht diese Folgen vergleichbar. Die Gliederung baut darauf später Kosten-, Gewinn-, Rentabilitäts- und Amortisationsrechnung auf; deren zusätzliche Regeln sind noch nicht Gegenstand dieses Skripts.
]

// 0-17
#aufgabe(titel: "Ein- und mehrstufige DB-Rechnung", art: "verstehen", quelle: "1.4")[
#if not web [*Aufgabe 17* #linebreak()]
*Stufen der DB-Rechnung:* Unterscheide das ein- und mehrstufige Abziehen von Fixkosten. Warum kann „DB II“ in beiden Schemata Unterschiedliches bedeuten? (Ü, PDF-S. 1, Randnotiz; L02, PDF-S. 5 und 11.)
][
*Ein-/mehrstufig:* Einstufig wird der gesamte Fixkostenblock vom gesamten DB abgezogen. Mehrstufig werden nacheinander Produkt-, Produktgruppen- und Unternehmensfixkosten abgezogen. Ein DB nach Produktfixkosten ist deshalb noch kein endgültiger Unternehmensgewinn. Die jeweilige Stufe muss benannt sein.
]

// 0-18
#aufgabe(titel: "Menge verdoppeln: was halbiert sich?", art: "verstehen", quelle: "1.3")[
#if not web [*Aufgabe 18* #linebreak()]
*Menge verdoppeln:* $K_f$ und $k_v$ bleiben gleich. Welche Größe halbiert sich: $K_f$, $k_f$ oder $k$? Begründe mit einer Formel. (Frühere Auswahlfrage, L15, PDF-S. 12–13, in offene Frage umgestellt.)
][
*Verdoppelung:* $k_f(2x)=K_f/(2x)=k_f(x)/2$; $K_f$ bleibt gleich. Insgesamt $k(2x)=k_f(x)/2+k_v$: Die gesamten Stückkosten halbieren sich bei positivem $k_v$ gerade nicht. Der variable Anteil bleibt bestehen.
]

// 0-19
#aufgabe(titel: "Gewinnschwelle berechnen", art: "rechnen", quelle: "1.5",
  ergebnis: [$x_"BEP" = 2000$ Stück/Monat],
  tipp: [Wie viel bleibt pro Stück übrig, um die Fixkosten zu bezahlen?],
)[
#if not web [*Aufgabe 19* #linebreak()]
*BEP rechnen:*

*Gegeben und Annahmen*

$K_f=50 000$ €/Monat, $k_v=20$ €/Stück, $e=45$ €/Stück.

*Gesucht*

#enum(numbering: "a)",
[Ermittle die Gewinnschwelle und prüfe den Gewinn dort. (Frühere Auswahlfrage, L15, PDF-S. 11/13, offen umgestellt.)],
)
][
*Eimerbild:* Jedes verkaufte Stück bringt 45 € herein; davon gehen sofort 20 € für die variablen Kosten weg. Der Rest, der Stückdeckungsbeitrag, füllt den Eimer der Fixkosten: $d b_"I" = e - k_v = 45 - 20 = 25$ €/Stück.
][
*Wann ist der Eimer voll?* Bei der Gewinnschwelle decken die Beiträge genau die Fixkosten: $x_"BEP" = K_f\/d b_"I" = 50 000\/25 = 2000$ Stück/Monat.
][
*Prüfen:* $E = 45 dot 2000 = 90 000$ €, $K = 50 000 + 20 dot 2000 = 90 000$ €, also $G = 0$. Jedes weitere Stück bringt 25 € Gewinn.
]

// 0-20
#aufgabe(titel: "Nettopreis aus dem Bruttopreis", art: "rechnen", quelle: "1.5",
  ergebnis: [$e = 200$ €/Stück],
  tipp: [Brutto ist netto plus 19 %, also netto mal 1,19.],
)[
#if not web [*Aufgabe 20* #linebreak()]
*Netto:*

*Gegeben und Annahmen*

Ein Preis beträgt 238 € brutto bei vorgegebenen 19 % Umsatzsteuer.

*Gesucht*

#enum(numbering: "a)",
[Welcher Betrag gehört als $e$ in die Erlösfunktion? (L15, PDF-S. 11/13, offen umgestellt.)],
)
][
*Warum netto?* Die Umsatzsteuer gehört nicht dem Unternehmen; sie wird nur eingesammelt und ans Finanzamt weitergegeben. In die Erlösfunktion gehört deshalb der Nettopreis.
][
*Rückrechnen:* Brutto $=$ Netto $dot "1,19"$. Also Netto $= 238\/"1,19" = 200$ €.
][
*Prüfen:* $200 dot "0,19" = 38$ € Steuer, zusammen 238 €. Falsch wäre $238 dot "0,81"$, weil sich die 19 % auf den Nettopreis beziehen, nicht auf den Bruttopreis.
]

// 0-21
#aufgabe(titel: "Beschäftigungsgrad an der Gewinnschwelle", art: "rechnen", quelle: "1.5.1",
  ergebnis: [$"BG" = 75 %$],
)[
#if not web [*Aufgabe 21* #linebreak()]
*BG am BEP:*

*Gegeben und Annahmen*

Die Monatskapazität beträgt 2 000 Stück, die Schwelle 1 500 Stück.

*Gesucht*

#enum(numbering: "a)",
[Berechne und deute den BG. (L15, PDF-S. 11/13, offen umgestellt.)],
)
][
*Definition:* Der Beschäftigungsgrad sagt, welchen Teil der Kapazität eine Menge nutzt: $"BG" = x\/x_"max" dot 100 %$.
][
*Einsetzen:* $"BG" = 1500\/2000 dot 100 % = 75 %$.
][
*Deuten:* Erst ab drei Vierteln der Kapazität wird Gewinn gemacht. Nur ein Viertel der Kapazität bleibt als Gewinnzone; sinkt der Absatz um mehr als 25 % unter Vollauslastung, entsteht Verlust.
]

// 0-22
#aufgabe(titel: "Kostenfunktion aus zwei Monaten", art: "rechnen", quelle: "1.7",
  ergebnis: [$k_v = 20$ €/Stück, $K_f = 100 000$ €],
  tipp: [Die Fixkosten sind in beiden Monaten gleich. Der Kostenunterschied kann also nur von den zusätzlichen Stücken kommen.],
)[
#if not web [*Aufgabe 22* #linebreak()]
*Kostensteigung:*

*Gegeben und Annahmen*

Monat 1: 10 000 Stück, $K=300 000$ €; Monat 2: 12 000 Stück, $K=340 000$ €.

*Gesucht*

#enum(numbering: "a)",
[Ermittle $k_v,K_f$ und prüfe beide Punkte. (L15, PDF-S. 12–13, offen umgestellt.)],
)
][
*Differenzenidee:* Zwischen den Monaten steigen die Kosten um 40 000 €, die Menge um 2000 Stück. Da die Fixkosten gleich bleiben, verursachen genau diese 2000 Stück die Mehrkosten.
][
*Variable Stückkosten:* $k_v = Delta K\/Delta x = 40 000\/2000 = 20$ €/Stück. Das ist die Steigung der Kostengeraden.
][
*Fixkosten:* Aus Monat 1: $K_f = K - k_v x = 300 000 - 20 dot 10 000 = 100 000$ €.
][
*Prüfen mit Monat 2:* $100 000 + 20 dot 12 000 = 340 000$ €. Beide Punkte liegen auf derselben Geraden.
]

// 0-23
#aufgabe(titel: "VL 1: vorwärts und rückwärts", art: "rechnen", quelle: "1.5")[
#if not web [*Aufgabe 23* #linebreak()]
*VL-1-Übung, K PDF-S. 2:*

*Gegeben und Annahmen*

$k_v=7$ €/Stück, $e=10$ €/Stück, $K_f=800$ € je betrachteter Periode, Kapazität 1 300 Stück.

*Gesucht*

#enum(numbering: "a)",
[Gewinnmaximum?],
[Exakter BEP und kleinste ganze Menge ohne Verlust?],
[Rechne wie in der Mitschrift rückwärts mit „BEP = 267“: Welches $k_v$ ergibt sich bei $e=10,K_f=800$? Welches $K_f$ bei $d b_"I"=3$? Erkläre die Rundungsabweichung.],
)
][
*Modell:* Gleiche betrachtete Periode, lineare Kosten, vollständiger Absatz bis maximal 1 300 Stück; $d b_"I"=10-7=3$ €/Stück.
][
*Gewinnmaximum:* $E(1300)=13 000$ €, $K(1300)=800+7 dot 1300=9900$ €. Damit *$G_"max"=+3100$ €*.
][
*Gewinnschwelle:* $x_"BEP"=800/3="266,666…"$ Stück. Kleinste ganze Menge ohne Verlust: *267 Stück*. Probe: $2670-2669=+1$ €; bei 266 Stück ist $G=-2$ €.
][
*Rückwärts mit 267:* Wird 267 als *exakte* Schwelle behandelt, folgt $k_v=10-800/267 approx "7,00375"$ €/Stück. Bei $d b_"I"=3$ folgt stattdessen $K_f=267 dot 3=801$ €. Die ursprünglichen Werte 7 € und 800 € erhältst Du exakt nur mit $800/3$ als Schwelle.
][
*Prüfung:* Die Abweichung von 1 € im Fixkostenrückschluss stammt aus der vorher aufgerundeten Menge; sie ist keine Änderung der tatsächlichen Ausgangskosten. Quelle: K, PDF-S. 2; L15, PDF-S. 9.
]

// 0-24
#aufgabe(titel: "Ü 1: Modelleisenbahn-Zubehör", art: "rechnen", quelle: "1.2")[
#if not web [*Aufgabe 24* #linebreak()]
*Ü 1 · Modelleisenbahn-Zubehör, PDF-S. 1:*

*Gegeben und Annahmen*

Kapazität 1 000 Verkaufspackungen/Monat, nur Auftragsproduktion.  Kostendaten: Gehälter 9 000 €/Monat, Miete 1 600 €/Monat, Nebenkosten 400 €/Monat, Fremdkapitalzinsen 3 000 €/Monat, Abschreibungen 6 000 €/Monat; RHB-Stoffe 6 €/Packung, Akkordlöhne 22 €/Packung und Energie 2 €/Packung. Alle genannten Monatsbeträge werden hier mengenunabhängig angesetzt.

*Gesucht*

#enum(numbering: "a)",
[Ordne alle acht Kostenarten zu, bilde $K(x)$ und fülle für $x=200,400,600,800,1000$ die Spalten $K_f,K_v,K,k$.],
[Gewinn bei 600 Packungen zu 70 € netto?],
[BEP und Skizze mit Umsatz an der Schwelle?],
[Gewinnmaximum?],
[Gewinn bei 800 Packungen?],
[Ausgehend von 800 Packungen: Preis allgemein auf 60 €, Nachfrage +200. Lieferbar und sinnvoll?],
[Alternativ 800 Packungen zu 70 € und einmalig 200 zusätzliche zu 35 €: annehmen? Welche Gefahr?],
)
][
*Modell:* Packungen pro Monat, Produktion gleich Absatz, Nettopreise; $K_f$ und $k_v$ bleiben bis 1 000 Packungen unverändert. Die beiden Preisentscheidungen sind Alternativen.
][
*Kosten aufteilen:* $K_f=9000+1600+400+3000+6000=20 000$ €/Monat. $k_v=6+22+2=30$ €/Packung. Somit $K(x)=20 000+30x$; die vollständige Kostentabelle steht in Abschnitt 1.3. Die dortigen fünf Zeilen sind die Lösung zu a).
][
*600 Packungen:* $E=70 dot 600=42 000$ €, $K=20 000+30 dot 600=38 000$ €. *$G=+4000$ €*. Gegenprobe: $(70-30) dot 600-20 000=+4000$ €.
][
*BEP und Skizze:* $d b_"I"=40$ €/Packung, $x_"BEP"=20 000/40=500$ Packungen; $E_"BEP"=70 dot 500=35 000$ €. Die Zeichnung in Abschnitt 1.5 zeigt $E=70x$ und $K=20 000+30x$ mit Schnittpunkt $(500;35 000)$.
][
*Maximum:* Positiver Stück-DB und vollständiger Absatz bis Kapazität: *$G(1000)=40 dot 1000-20 000=+20 000$ €*.
][
*800 Packungen:* $E=56 000$ €, $K=44 000$ €, somit *$G=+12 000$ €*.
][
*Allgemeine Preissenkung:* Die Randrechnung geht von 800 Packungen aus; $800+200=1000$ passen genau. Neu $E=60 dot 1000=60 000$ €, $K=50 000$ €, somit *$G_"neu"=+10 000$ €*. Gegenüber +12 000 € sind das −2 000 €: *unter diesen Bedingungen nicht senken*.
][
*Zusatzauftrag:* $800+200=1000$, ebenfalls lieferbar. Erlös $800 dot 70+200 dot 35=63 000$ €, Kosten 50 000 €, also *$G_"neu"=+13 000$ €*. Zusatzbeitrag $(35-30) dot 200=+1000$ €. *Rechnerisch annehmen*, sofern die bisherigen Preise bestehen und keine weiteren Kosten entstehen. Risiko: bisherige Kunden verlangen ebenfalls 35 €; dann wäre das Gesamtergebnis bei 1 000 Packungen −15 000 €.
][
#note("Quelle sichtbar korrigiert", [Bei der Zusatzrechnung steht in der Mitschrift sinngemäß „$E(200)=800 dot 35=7000$“. Zum Ergebnis 7 000 € passt *$200 dot 35$*. Das Endergebnis 63 000 € Gesamterlös stimmt; der Multiplikator war verschrieben.], fill: sand)

*Prüfung:* In der Grundrechnung bei Kapazität beträgt der Abstand zwischen Erlös 70 000 € und Kosten 50 000 € genau 20 000 €. Die Zusatzrechnung verändert nur 200 Preise, die allgemeine Senkung alle 1 000. Quelle: Ü, PDF-S. 1; L15, PDF-S. 9.
]

// 0-25
#aufgabe(titel: "Ü 2: Verlust, Preis und unerreichbarer BEP", art: "rechnen", quelle: "1.5")[
#if not web [*Aufgabe 25* #linebreak()]
*Ü 2 · Kosten und Verlust, PDF-S. 2; Foto Ü 2:*

*Gegeben und Annahmen*

Bei 3 000 Stück entstehen 75 000 € Gesamtkosten, darunter 30 000 € fixe Kosten. Der Verlust ist 12 000 €.

*Gesucht*

#enum(numbering: "a)",
[Ermittle $k_v,E,e$.],
[BEP rechnerisch und grafisch?],
[Beurteile die Kapazitätsgrenze von 4 500 Stück.],
[Eigene vertiefende Ableitung aus L15, PDF-S. 10: Wie müssten jeweils einzeln $e$, $k_v$ oder $K_f$ geändert werden, um bei 4 500 Stück mindestens kostendeckend zu sein?],
)
][
*Modell:* Einproduktfall und unveränderte lineare Kosten, Kapazität 4 500 Stück je betrachteter Periode. Verlust wird als $G=-12 000$ € eingesetzt.
][
*Variable Stückkosten:* $k_v=(75 000-30 000)/3000=15$ €/Stück.
][
*Erlös und Preis:* $E=G+K=-12 000+75 000=63 000$ €, $e=63 000/3000=21$ €/Stück. Probe: $63 000-75 000=-12 000$ €.
][
*Gewinnschwelle:* $x_"BEP"=30 000/(21-15)=5000$ Stück. Grafisch schneiden sich $E=21x$ und $K=30 000+15x$ bei 5 000 Stück und 105 000 €. Die Abbildung in Abschnitt 1.8.1 zeigt die rechnerische Fortsetzung außerhalb der Kapazität.
][
*Kapazität:* *$G(4500)=6 dot 4500-30 000=-3000$ €*. Mit den vorhandenen Zahlen ist Gewinn nicht möglich. Preis/Kosten ändern oder eine Kapazitätsänderung einschließlich neuer Kosten untersuchen.
][
*Einzelne Änderungen zur Kostendeckung bei 4 500:* Nötiger Stück-DB $30 000/4500=20/3$ €/Stück. Bei unverändertem $k_v=15$ ist $e>=65/3 approx "21,6667"$ €/Stück nötig; auf Cent *mindestens 21,67 €*. Bei unverändertem $e=21$ ist $k_v<=43/3 approx "14,3333"$ €/Stück nötig, auf Cent *höchstens 14,33 €*. Bei unverändertem Stück-DB von 6 € dürfen *$K_f<=27 000$ €* sein.
][
*Prüfung:* Mit 21,67 € erzielt der Betrieb bei 4 500 Stück +15 €; die Cent-Rundung liegt auf der kostendeckenden Seite. Die Änderungen sind drei getrennte Möglichkeiten. Quelle: Ü 2, PDF-S. 2; Foto Ü 2; d) eigene Ableitung wie L15, PDF-S. 10.
]

// 0-26
#aufgabe(titel: "Ü 3: Zwei Perioden und Erweiterung", art: "rechnen", quelle: "1.7")[
#if not web [*Aufgabe 26* #linebreak()]
*Ü 3 · Oktober/November, PDF-S. 2; Foto Ü 3:*

*Gegeben und Annahmen*

Oktober: 20 000 Stück bei $K=700 000$ €; November: 24 000 Stück bei $K=800 000$ €. $e=40$ €/Stück.

*Gesucht*

#enum(numbering: "a)",
[$k_v,K_v,K_f,k_f$ in beiden Monaten?],
[Betriebserfolg bei vollständigem Absatz?],
[BEP rechnerisch und grafisch?],
[Welchen Einfluss hat eine Erhöhung von $k_v$ auf 30 €/Stück?],
[Wieder mit $k_v=25$: Eine Erweiterung erhöht $K_f$ um 40 000 €. Welche Gesamt- und Zusatzmenge hält den Novembergewinn?],
)
][
*Modell:* In beiden Ausgangsmonaten gleiches $K_f$ und $k_v$, Preis 40 €/Stück und vollständiger Absatz. Änderungen in d) und e) werden getrennt vom Ausgangsfall untersucht.
][
*Kostenlinie:* $k_v=100 000/4000=25$ €/Stück. $K_f=700 000-25 dot 20 000=200 000$ €. Gegenprobe November: $800 000-25 dot 24 000=200 000$ €.
][
#tab(columns: (1.2fr, 1fr, 1fr, 1fr, 1fr, 1fr),
 th([Monat], [$K_v$ €], [$K_f$ €], [$k_f$ €/Stk], [$E$ €], [$G$ €]),
 [Oktober], [500 000], [200 000], [10,00], [800 000], [+100 000],
 [November], [600 000], [200 000], [8,33], [960 000], [+160 000],
)
$k_f$ für November ist gerundet; die Kosten und Gewinne werden mit ungerundeten Gesamtwerten berechnet. Zusammen ergeben die beiden Monate +260 000 €.

2. *BEP:* $d b_"I"=40-25=15$ €/Stück. $x_"BEP"=200 000/15="13 333,333…"$ Stück. Kleinste ganze Menge ohne Verlust: *13 334 Stück*. Der theoretische Umsatz am Schnittpunkt ist etwa 533 333,33 €.
#bild("bep-aufgabe3", [Kosten und Erlös der Ausgangsmonate; Eigene Darstellung nach Ü 3, PDF-S. 2. Die Linie bei 24 000 markiert hier die Novembermenge, keine nachgewiesene Kapazität.], height: 54mm)
3. *Variable Kosten steigen auf 30:* Neuer Stück-DB $40-30=10$ €/Stück. *BEP = 20 000 Stück*. Die theoretische Schwelle steigt von $13 333,333…$ auf 20 000, also um *50 %*.
4. *Erweiterung mit ursprünglichem $k_v=25$:* $K_(f,"neu")=240 000$ €. Für $G_"Ziel"=160 000$ € gilt $x=(240 000+160 000)/15="26 666,666…"$ Stück. Benötigt werden *26 667 Stück insgesamt*, also *2 667 mehr* als im November. Schnellweg: $40 000/15="2666,666…"$ zusätzliche Stück.

*Prüfung:* Bei 26 667 Stück ergibt sich $15 dot 26 667-240 000=160 005$ €. Bei 26 666 sind es nur 159 990 €. Die tatsächlich verfügbare neue Kapazität und der Absatz müssen mindestens 26 667 erlauben; diese Machbarkeit ist im Aufgabentext nicht beziffert. Quelle: Ü 3, PDF-S. 2; Foto Ü 3; L15, PDF-S. 10.
]

// 0-27
#aufgabe(titel: "Ü 4: Holzregale", art: "rechnen", quelle: "1.1")[
#if not web [*Aufgabe 27* #linebreak()]
*Ü 4 · Holzregale, PDF-S. 2; Foto Ü 4:*

*Gegeben und Annahmen*

Kapazität 1 200 Regale/Monat; $K_f=64 000$ €/Monat; $k_v=110$ €/Regal; Preis 214,20 € brutto, für diese Aufgabe 19 % Umsatzsteuer.

*Gesucht*

#enum(numbering: "a)",
[BEP?],
[BG der Gewinnschwelle, theoretisch und mit ganzen Regalen?],
[Betriebsergebnis bei 85 % BG? Ordne Deine rote Randbemerkung zur hohen Auslastung ein.],
)
][
*Modell:* Monatsbetrachtung, 19 % Umsatzsteuer laut verwendeter Aufgabenlösung; lineare Kosten und vollständiger Absatz der hergestellten Regale.
][
*Netto:* $e="214,20"/"1,19"=180$ €/Regal. Stück-DB $180-110=70$ €/Regal.
][
*BEP:* $64 000/70="914,2857…"$ Regale/Monat. Kleinste ganze Menge ohne Verlust: *915 Regale/Monat*.
][
*BG:* Theoretisch $(64 000/70)/1200 dot 100 % approx "76,19" %$. Mit ganzen Regalen *$915/1200 dot 100 %="76,25" %$*.
][
*85 % Auslastung:* $x="0,85" dot 1200=1020$ Regale. Erlös $180 dot 1020=183 600$ €, Kosten $64 000+110 dot 1020=176 200$ €, also *$G=+7400$ €*. Gegenprobe $70 dot 1020-64 000=+7400$ €.
][
*Prüfung und Einordnung:* 914 Stück ergeben −20 €, 915 Stück +50 €. Bei 1 020 Stück beträgt der Abstand zur ganzen Schwellenmenge 105 Regale. Deine rote Notiz fordert, Preis und Kosten bei hoher Auslastung zu prüfen. Ohne vorgegebenes Gewinnziel ist „zu niedrig“ keine rechnerisch beweisbare allgemeine Bewertung. Quelle: Ü 4 und rote Notizen, PDF-S. 2; Foto Ü 4; L15, PDF-S. 10.
]

// 0-28
#aufgabe(titel: "A13: Dreherei", art: "rechnen", quelle: "1.1")[
#if not web [*Aufgabe 28* #linebreak()]
*A13 · KLR, Aufgabe 3, erster Fall, PDF-S. 3:*

*Gegeben und Annahmen*

Kostenstelle Dreherei, Kapazität 10 000 Einheiten je Monat. Mai: 70 % BG, $K=466 000$ €; Juni: 80 %, $K=504 000$ €. Für Juli sind 85 % geplant.

*Gesucht*

#enum(numbering: "a)",
[Bestimme Juli-Menge, proportionale variable Stückkosten, Fixkosten, variable Gesamtkosten und Gesamtkosten. Nur der KLR-Teil wird verwendet.],
)
][
*Modell:* Gleiche Monatskostenstruktur von Mai bis Juli; kein Fixkostensprung. Die Kapazität von 10 000 Einheiten/Monat ist 100 %.
][
*Mengen:* Mai $x_1=7000$, Juni $x_2=8000$, Juli $x_3=8500$ Einheiten/Monat.
][
*Kostensteigung:* $k_v=(504 000-466 000)/(8000-7000)=38$ €/Einheit.
][
*Fixkosten:* $K_f=466 000-38 dot 7000=200 000$ €/Monat. Probe Juni: $504 000-38 dot 8000=200 000$ €.
][
*Juli:* $K_v=38 dot 8500=323 000$ € und *$K(8500)=200 000+323 000=523 000$ €*.
][
*Prüfung:* Juli liegt 500 Einheiten über Juni; Kostenanstieg $500 dot 38=19 000$ €, also $504 000+19 000=523 000$ €. Kein Erlös gegeben, daher kein Gewinn berechenbar. Quelle: A13, PDF-S. 3, erster KLR-Fall; identisch als Einzelseite 3.pdf abgelegt.
]

// 0-29
#aufgabe(titel: "A13: Kunststoffbehälter", art: "rechnen", quelle: "1.3")[
#if not web [*Aufgabe 29* #linebreak()]
*A13 · KLR, zweiter Fall, PDF-S. 3–4, Teile a–b:*

*Gegeben und Annahmen*

Ein Einproduktbetrieb stellt Kunststoffbehälter für Gartenabfälle her. Preis 200 €/Stück, Fertigungsmaterial 60 €/Stück, Fertigungslohn 20 €/Stück, jährliche Fixkosten 900 000 €.

*Gesucht*

#enum(numbering: "a)",
[Jährliche BEP-Menge und BEP-Umsatz?],
[Betriebsergebnis bei 10 000 Stück? Der Teil zur Umsatzrentabilität bleibt dem späteren Kennzahlenstoff vorbehalten.],
)
][
*Modell:* Jahresbetrachtung, Material und Fertigungslohn proportional, fixe Jahreskosten konstant; vollständiger Absatz.
][
*Stück-DB:* $k_v=60+20=80$ €/Stück; $d b_"I"=200-80=120$ €/Stück.
][
*Schwelle:* *$x_"BEP"=900 000/120=7500$ Stück/Jahr*. BEP-Umsatz *$E_"BEP"=200 dot 7500=1 500 000$ €/Jahr*.
][
*10 000 Stück:* $E=2 000 000$ €, $K=900 000+80 dot 10 000=1 700 000$ €. *$G=+300 000$ €/Jahr*.
][
*Prüfung:* Bei 7 500 Stück sind Erlös und Kosten je 1,5 Mio. €; 2 500 weitere Stück liefern $2500 dot 120=300 000$ € Gewinn. Eine Kapazitätsangabe fehlt, daher keine gesicherte Aussage zur maximalen Menge. Quelle: A13, PDF-S. 3–4, KLR-Fall, Teile a–b; Einzelseiten 3.pdf/4.pdf.
]

// 0-30
#aufgabe(titel: "A14 I.1: Fixkosten aus dem Gesamt-DB", art: "rechnen", quelle: "1.4")[
#if not web [*Aufgabe 30* #linebreak()]
*A14 · Aufgabe I.1, PDF-S. 2, KLR-Auszug:*

*Gegeben und Annahmen*

Die gesamten Deckungsbeiträge der Produkte A–E betragen 4 200 €, 6 460 €, 14 490 €, 6 608 € und 20 085 € im Monat. Das Betriebsergebnis ist +6 350 €.

*Gesucht*

#enum(numbering: "a)",
[Welche monatlichen Fixkosten hat der Betrieb? Die weiteren Teile zur Engpassplanung sind hier nicht enthalten.],
)
][
*Modell:* Die angegebenen DB sind Gesamtbeträge des Monats, keine Stückwerte. Das Betriebsergebnis entsteht nach einmaligem Abzug der gemeinsamen Fixkosten.
][
*Addieren:* $D B_"I"=4200+6460+14 490+6608+20 085=51 843$ €.
][
*Umstellen:* $G=D B_"I"-K_f => K_f=D B_"I"-G$.
][
*Ergebnis:* *$K_f=51 843-6350=45 493$ €/Monat*.
][
*Prüfung:* $51 843-45 493=+6350$ €. Herstellungsstunden werden für diesen Teil nicht gebraucht; relativer DB und Engpassprogramm sind spätere Teilaufgaben. Quelle: A14, PDF-S. 2, Aufgabe I.1; Einzelseite Controlling2.pdf.
]

// 0-31
#aufgabe(titel: "A18 I: Vollkosten und Deckungsbeitrag", art: "rechnen", quelle: "1.3")[
#if not web [*Aufgabe 31* #linebreak()]
*A18 · Aufgabe I, PDF-S. 1, DB-Übertragung:*

*Gegeben und Annahmen*

Drei Varianten einer Dienstkleidung werden vollständig verkauft. Die Werte stehen unten.

*Gesucht*

#enum(numbering: "a)",
[Berechne mit den gegebenen Vollkosten je Stück die Ergebnisse je Variante und insgesamt. Welche Variante sieht zunächst ungünstig aus?],
[Variable Stückkosten sind 35,70 €, 66,30 €, 102,00 €; gemeinsame Fixkosten 240 720 €. Bestimme die drei DB und den Gesamtgewinn.],
[Beurteile eine Streichung von Hansa bei unveränderten gemeinsamen Fixkosten. Die Bedingungen der Entscheidung sind ausdrücklich Teil dieser Übertragung.
#tab(columns: (1.3fr, 1fr, 1fr, 1fr),
 th([Variante], [Easy], [Hansa], [Pazifik]),
 [Menge in Stück], [2 500], [3 000], [3 750],
 [Preis €/Stück], [61,20], [112,20], [142,80],
 [Vollkosten €/Stück], [43,86], [114,24], [122,40],
)],
)
][
*Modell:* Gegebene Absatzmengen; für den Streichungsvergleich bleiben die gemeinsamen Fixkosten unverändert, keine Verdrängung oder zusätzlichen Folgewirkungen. Das ist eine Übertragung der bisherigen DB-Logik.
][
*Vollkosten:* Je Variante $G_j=(e_j-k_j)x_j$.
][
#tab(columns: (1.3fr, 1fr, 1fr, 1fr),
 th([Variante], [Easy], [Hansa], [Pazifik]),
 [Stückdifferenz €], [17,34], [−2,04], [20,40],
 [Ergebnis €], [+43 350], [−6 120], [+76 500],
 [Stück-DB €], [25,50], [45,90], [40,80],
 [Gesamt-DB €], [63 750], [137 700], [153 000],
)
2. *Gesamtergebnis:* Vollkostenrechnung $43 350-6120+76 500=113 730$ €. DB-Rechnung $63 750+137 700+153 000=354 450$ € Gesamt-DB; einmal Fixkosten abziehen: *$354 450-240 720=+113 730$ €*.
3. *Entscheidung:* Hansa sieht nach zugeordneten Vollkosten unvorteilhaft aus. Es liefert aber *137 700 € positiven Gesamt-DB*. Bei unveränderten gemeinsamen Fixkosten wäre nach Streichung $G=63 750+153 000-240 720=-23 970$ €. Daher *unter diesen Annahmen nicht streichen*.

#note("Handschrift prüfen", [Die handschriftlichen Teilkostenrechnungen auf A18, PDF-S. 1 ziehen bei jeder Variante den gesamten Fixkostenblock von 240 720 € ab und führen zur Auswahl nur einer Variante. Für das vorgegebene Sortiment mit gemeinsamen Fixkosten ist das mehrfaches Abziehen derselben Kosten. Die Rechnung oben korrigiert diesen Fehler sichtbar.], fill: sand)

*Prüfung:* Beide Gesamtverfahren liefern +113 730 €. Ohne Hansa fällt der Gewinn um exakt dessen DB von 137 700 €. Eine andere Entscheidung kann neue Annahmen über vermeidbare Fixkosten oder Engpässe verlangen; solche Angaben liegen hier nicht vor. Quelle: A18, PDF-S. 1; Rechenweg und bedingter Streichungsvergleich selbst ausgearbeitet.
]

// 0-32
#aufgabe(titel: "Alte Ü 1: BEP und Beschäftigungsgrad", art: "rechnen", quelle: "1.5")[
#if not web [*Aufgabe 32* #linebreak()]
*Alte Ü 1 · BEP und BG:*

*Gegeben und Annahmen*

$K_f=48 000$ €/Monat, $k_v=18$ €/Stück, $e=30$ €/Stück, Kapazität 5 000 Stück/Monat.

*Gesucht*

#enum(numbering: "a)",
[Ermittle Stück-DB, BEP und BG am BEP.],
)
][
Stück-DB $30-18=12$ €/Stück.
][
*BEP $48 000/12=4000$ Stück/Monat*.
][
*BG $4000/5000 dot 100 %=80 %$*.
][
*Prüfung:* $12 dot 4000-48 000=0$ €. 1 000 Stück Kapazität liegen über der Schwelle.
]

// 0-33
#aufgabe(titel: "Alte Ü 2: Zwei Perioden", art: "rechnen", quelle: "1.7")[
#if not web [*Aufgabe 33* #linebreak()]
*Alte Ü 2 · Zwei Perioden:*

*Gegeben und Annahmen*

Januar 8 000 Stück, $K=164 000$ €; Februar 10 000 Stück, $K=190 000$ €.

*Gesucht*

#enum(numbering: "a)",
[Ermittle $k_v,K_f$ und prüfe mit Februar.],
)
][
*Annahme:* unveränderte Kostenstruktur in beiden Monaten.
][
$k_v=(190 000-164 000)/(10 000-8000)=26 000/2000=13$ €/Stück.
][
*$K_f=164 000-13 dot 8000=60 000$ €/Monat*.
][
*Prüfung Februar:* $60 000+13 dot 10 000=190 000$ €. Steigung und Achsenabschnitt passen zu beiden Punkten.
]

// 0-34
#aufgabe(titel: "Alte Ü 3: Zusatzauftrag", art: "rechnen", quelle: "1.6.2")[
#if not web [*Aufgabe 34* #linebreak()]
*Alte Ü 3 · Zusatzauftrag:*

*Gegeben und Annahmen*

700 Stück zu 50 €, $k_v=32$ €, $K_f=9 000$ €, Kapazität 900 Stück je Periode. Ein Kunde will einmalig 150 Stück zu 38 €.

*Gesucht*

#enum(numbering: "a)",
[Prüfe Kapazität, Ergebnisänderung, Entscheidung und Risiko.],
)
][
*Annahmen:* bisheriger Preis bleibt, keine weiteren auftragsbedingten Kosten oder Verdrängung.
][
Kapazität $700+150=850<=900$: Auftrag passt.
][
*$Delta G=(38-32) dot 150=+900$ €*.
][
Ausgangsgewinn $18 dot 700-9000=3600$ €, neuer Gewinn *4 500 €*: unter den Annahmen annehmen.
][
*Prüfung:* Gesamterlös $700 dot 50+150 dot 38=40 700$ €, Kosten $9000+32 dot 850=36 200$ €, Differenz 4 500 €. Risiko: Stammkunden fordern den Zusatzpreis; Restkapazität nur 50 Stück.
]

// 0-35
#aufgabe(titel: "Alte Ü 4: Preis aus dem Verlust", art: "rechnen", quelle: "1.8")[
#if not web [*Aufgabe 35* #linebreak()]
*Alte Ü 4 · Preis aus Verlust:*

*Gegeben und Annahmen*

Bei 2 500 Stück entstehen 95 000 € Gesamtkosten, darunter 40 000 € Fixkosten. Verlust 7 500 €, Kapazität 3 000 Stück.

*Gesucht*

#enum(numbering: "a)",
[Bestimme $k_v,e$, BEP und eine begründete Entscheidung.],
)
][
*Modell:* lineare Kosten; Verlust $G=-7500$ €.
][
$k_v=(95 000-40 000)/2500=22$ €/Stück.
][
$E=-7500+95 000=87 500$ €; *$e=35$ €/Stück* und $d b_"I"=13$ €/Stück.
][
Exakte Schwelle $40 000/13 approx "3076,923"$; kleinste ganze Menge *3 077 Stück*, oberhalb Kapazität 3 000.
][
*Prüfung:* Bei Vollauslastung $13 dot 3000-40 000=-1000$ €. Daher so kein Gewinn möglich: Preis/Kosten ändern oder Erweiterung samt Kosten prüfen. Gegenprobe Ausgang: $35 dot 2500-95 000=-7500$ €.
]

// 0-36
#aufgabe(titel: "Alte Ü 5: Preissenkung", art: "rechnen", quelle: "1.6.1")[
#if not web [*Aufgabe 36* #linebreak()]
*Alte Ü 5 · Preissenkung:*

*Gegeben und Annahmen*

$K_f=30 000$ €, $k_v=20$ €, $e=50$ €, Absatz 1 200 Stück, Kapazität 1 500 Stück je Periode. Bei 45 € wären 1 600 Stück nachgefragt.

*Gesucht*

#enum(numbering: "a)",
[Ist die Senkung sinnvoll?],
)
][
*Modell:* neue Nachfrage 1 600, lieferbar höchstens 1 500; sonst unveränderte Kosten.
][
Alt $G=(50-20) dot 1200-30 000=+6000$ €.
][
Neu $G=(45-20) dot 1500-30 000=+7500$ €.
][
*Ergebnis: Senken erhöht hier den Gewinn um 1 500 €.* Prüfung: Neu $E=67 500$ €, $K=60 000$ €. Die nicht lieferbaren 100 Stück dürfen nicht in den Erlös eingehen. Die Nachfrageprognose ist Teil der Annahmen.
]

// 0-37
#aufgabe(titel: "Alte Ü 6: Zielgewinn", art: "rechnen", quelle: "1.8")[
#if not web [*Aufgabe 37* #linebreak()]
*Alte Ü 6 · Zielgewinn:*

*Gegeben und Annahmen*

$K_f=72 000$ €, $e=60$ €, $k_v=42$ €.

*Gesucht*

#enum(numbering: "a)",
[Welche Stückzahl bringt mindestens 18 000 € Gewinn im unveränderten Modell? Eine Kapazität ist hier nicht vorgegeben.],
)
][
Stück-DB $60-42=18$ €/Stück.
][
Zielmenge $(72 000+18 000)/18=5000$ Stück.
][
*Ergebnis: 5 000 Stück* bringen genau den Zielgewinn. Prüfung: $18 dot 5000-72 000=18 000$ €. Kapazität und Absatz sind nicht angegeben und müssten mindestens diese Menge ermöglichen.
]

// 0-38
#aufgabe(titel: "Alte Ü 7: Fahrradrahmen", art: "rechnen", quelle: "1.1")[
#if not web [*Aufgabe 38* #linebreak()]
*Alte Ü 7 / L02 Aufgabe A · Fahrradrahmen:*

*Gegeben und Annahmen*

Kapazität 2 000 Stück/Monat, $K_f=90 000$ €/Monat, $k_v=75$ €/Stück, Preis 154,70 € brutto bei 19 % Umsatzsteuer. Aktuell 1 800 Stück.

*Gesucht*

#enum(numbering: "a)",
[Netto, Stück-DB und BEP?],
[BG an der ganzen Schwellenmenge?],
[aktueller Gewinn?],
[Einmalig 150 Rahmen zu 85 € netto zusätzlich: annehmen und Risiko?],
[Alternativ allgemein 120 € netto, Nachfrage +300: sinnvoll?],
)
][
*Modell:* Monatswerte, 19 % Umsatzsteuer vorgegeben; Preisänderungen sind Alternativen.
][
*Netto und BEP:* $e="154,70"/"1,19"=130$ €/Stück; $d b_"I"=55$ €/Stück. $x_"BEP"=90 000/55 approx "1636,364"$; kleinste ganze Menge ohne Verlust *1 637 Rahmen*.
][
*BG:* $1637/2000 dot 100 %="81,85" %$ für ganze Stücke.
][
*Aktuell:* $55 dot 1800-90 000=+9000$ €.
][
*Zusatz:* 200 freie Plätze, 150 benötigt; *$Delta G=(85-75) dot 150=+1500$ €*. Rechnerisch annehmen, wenn bisherige Preise und Kostenbedingungen bleiben. Risiko: Preisforderung bisheriger Kunden. Neuer Gewinn +10 500 €.
][
*Allgemein 120 €:* Nachfrage $1800+300=2100$, Kapazität nur 2 000. $G=(120-75) dot 2000-90 000=0$ €; *nicht senken*, da schlechter als +9 000 €.
][
*Prüfung:* Bei 1 636 Rahmen ist $G=-20$ €, bei 1 637 +35 €. Die aufgerundete Schwelle und die Kapazität passen zusammen.
]

// 0-39
#aufgabe(titel: "Alte Ü 8: Zwei Monate", art: "rechnen", quelle: "1.7")[
#if not web [*Aufgabe 39* #linebreak()]
*Alte Ü 8 / L02 Aufgabe B · Zwei Monate:*

*Gegeben und Annahmen*

März 5 000 Stück und $K=180 000$ €; April 6 500 Stück und $K=210 000$ €. $e=36$ € netto.

*Gesucht*

#enum(numbering: "a)",
[$k_v,K_f$?],
[Gewinne und Besonderheit im März?],
[Menge für 40 000 € Gewinn?],
)
][
*Annahme:* gemeinsames lineares Kostenmodell.
][
$k_v=(210 000-180 000)/(6500-5000)=20$ €/Stück; *$K_f=80 000$ €/Monat*.
][
März $G=36 dot 5000-180 000=0$ €: genau der BEP. April $G=36 dot 6500-210 000=+24 000$ €.
][
Stück-DB $36-20=16$ €/Stück. Für 40 000 € Gewinn: *$x=(80 000+40 000)/16=7500$ Stück*.
][
*Prüfung:* Aprilkosten $80 000+20 dot 6500=210 000$ €; Zielprüfung $16 dot 7500-80 000=40 000$ €. Kapazität und Nachfrage für 7 500 fehlen.
]

// 0-40
#aufgabe(titel: "Alte Ü 9: Preis gesucht", art: "rechnen", quelle: "1.5")[
#if not web [*Aufgabe 40* #linebreak()]
*Alte Ü 9 / L13 Rechenaufgabe 19 · Preis gesucht:*

*Gegeben und Annahmen*

$K_f=120 000$ €, $k_v=45$ €, Kapazität 5 000 Stück je Periode.

*Gesucht*

#enum(numbering: "a)",
[Preis, damit 4 000 Stück exakt der BEP sind?],
[Preis für 40 000 € Gewinn bei 4 000 Stück?],
[Mit Preis b): BEP und BG?],
)
][
*Modell:* 4 000 Stück werden verkauft; $K_f,k_v$ bleiben unverändert.
][
Exakter BEP bei 4 000: $d b_"I"=120 000/4000=30$ €/Stück. *$e=45+30=75$ €/Stück*.
][
Für 40 000 € Gewinn bei derselben Menge: $d b_"I"=(120 000+40 000)/4000=40$ €/Stück. *$e=85$ €/Stück*.
][
Mit 85 €: $x_"BEP"=120 000/40=3000$ Stück; *BG = 60 %*.
][
*Prüfung:* Bei 4 000 Stück und 85 € ist $G=40 dot 4000-120 000=40 000$ €. Die Mengen passen in die Kapazität 5 000; ob Kunden 85 € zahlen, ist die Absatzannahme des Falls.
]

// 0-41
#aufgabe(titel: "Alte Ü 10: Zwei Kostenlinien", art: "rechnen", quelle: "1.3")[
#if not web [*Aufgabe 41* #linebreak()]
*Alte Ü 10 / L13 Rechenaufgabe 20 · Zwei lineare Kostenfunktionen:*

*Gegeben und Annahmen*

Fall 1: $K_1(x)=20 000+12x$; Fall 2: $K_2(x)=35 000+7x$, Kosten jeweils €/Periode, $x$ Stück/Periode. Bei welcher Menge sind die Kosten gleich?

*Gesucht*

#enum(numbering: "a)",
[Welcher Fall ist bei 2 000 bzw. 4 000 Stück günstiger? Dies ist eine algebraische KLR-Übertragung, noch keine Herleitung eines Investitionsverfahrens.],
)
][
*Modell:* Beide linearen Funktionen sind bereits gegeben und im betrachteten Mengenbereich gültig. Es wird ausschließlich deren Kostenhöhe verglichen.
][
Gleichsetzen: $20 000+12x=35 000+7x => 5x=15 000 => x=3000$ Stück.
][
Bei 2 000: $K_1=44 000$ €, $K_2=49 000$ €; *Fall 1 ist günstiger*.
][
Bei 4 000: $K_1=68 000$ €, $K_2=63 000$ €; *Fall 2 ist günstiger*.
][
*Prüfung:* Bei 3 000 Stück kosten beide 56 000 €. Fall 2 hat höhere Fixkosten, aber die geringere Steigung; daher wird er oberhalb des Schnittpunkts günstiger. Erlöse oder Investitionskennzahlen werden hier nicht beurteilt.
]

// 0-42
#aufgabe(titel: "Alte Ü 11: Gesamtfall", art: "rechnen", quelle: "1.2")[
#if not web [*Aufgabe 42* #linebreak()]
*Alte Ü 11 · Gesamtfall:*

*Gegeben und Annahmen*

März 4 000 Stück, $K=150 000$ €; April 5 000 Stück, $K=175 000$ €. Verkaufspreis 47,60 € brutto bei 19 % Umsatzsteuer, Kapazität 6 000 Stück/Monat.

*Gesucht*

#enum(numbering: "a)",
[$k_v,K_f$?],
[BEP und BG?],
[Aprilgewinn?],
[Zusätzlich zu 5 000 Stück ein Auftrag über 800 zu 30 € netto: annehmen?],
[Sind 50 000 € Monatsgewinn möglich?],
[Wie werden die Abschreibungen in diesem mengenunabhängigen Modell eingeordnet?],
)
][
*Modell:* Gleiche Kostenstruktur beider Monate; 19 % Umsatzsteuer; Zusatzauftrag ohne Verdrängung, neue Fixkosten oder sonstige Zusatzkosten.
][
*Kosten:* $k_v=25 000/1000=25$ €/Stück, $K_f=150 000-25 dot 4000=50 000$ €/Monat.
][
*Preis und Schwelle:* $e="47,60"/"1,19"=40$ €/Stück, $d b_"I"=15$ €/Stück. $x_"BEP"=50 000/15 approx "3333,333"$; *3 334 Stück* als kleinste ganze Menge ohne Verlust. BG dieser Menge $3334/6000 dot 100 % approx "55,57" %$.
][
*April:* $G=15 dot 5000-50 000=+25 000$ €.
][
*Zusatz:* $5000+800=5800<=6000$. *$Delta G=(30-25) dot 800=+4000$ €*, neuer Gewinn +29 000 €. Rechnerisch annehmen; Risiko der Preisdifferenzierung und verbleibende Kapazität 200 Stück beachten.
][
*Ziel:* $(50 000+50 000)/15 approx "6666,667"$, also 6 667 Stück erforderlich, mehr als 6 000 möglich. *50 000 € sind unter diesen Bedingungen nicht erreichbar*; maximal $15 dot 6000-50 000=40 000$ €.
][
*Abschreibungen:* In diesem einfachen mengenunabhängigen Ansatz sind sie fix. Daraus folgt keine allgemeine Aussage über jede Abschreibungsmethode.
][
*Prüfung:* Aprilkosten $50 000+25 dot 5000=175 000$ €; 3 333 Stück ergeben −5 €, 3 334 +10 €. Die Zusatz- und Zielrechnungen haben jeweils einen eigenen klaren Kapazitätstest.
]

