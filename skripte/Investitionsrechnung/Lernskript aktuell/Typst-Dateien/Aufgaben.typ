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


#kapitel("Kapitel 1 · KLR und Deckungsbeitragsrechnung")

#aufgabe(titel: "Groß- und Kleinbuchstaben in der KLR", art: "verstehen", quelle: "1.1", herkunft: "eigen")[
#if not web [*Aufgabe 1* #linebreak()]
Was bedeuten in der Kostenrechnung Groß- und Kleinbuchstaben, etwa $K$ und $k$? Warum darfst Du sie nicht direkt addieren?
][
*Bezugsgröße:* Großbuchstaben stehen für Beträge der *gesamten* Menge einer Periode (z. B. $K(x)$ in €/Monat), Kleinbuchstaben für Beträge *je Stück* (z. B. $k(x)$ in €/Stück). Ein Gesamtbetrag und ein Stückbetrag haben verschiedene Einheiten; addieren darfst Du erst, nachdem Du den Stückbetrag mit der Menge multipliziert hast.

*Merksatz:* Groß rechnet gesamt, klein rechnet je Stück.
]

#aufgabe(titel: "Brutto oder netto in der KLR", art: "verstehen", quelle: "1.1", herkunft: "eigen")[
#if not web [*Aufgabe 2* #linebreak()]
Ein Regal kostet 214,20 € brutto bei 19 % Umsatzsteuer. Mit welchem Preis rechnest Du in der Erlösfunktion, und warum? Welche Rechenfehler liegen nahe?
][
*Netto:* $e="214,20"/"1,19"=180$ €. In der KLR wird immer netto gerechnet, weil die Umsatzsteuer kein Erlös des Betriebs ist; sie wird ans Finanzamt weitergegeben.

*Typische Verwechslungen:* 214,20 € (Steuer nicht herausgerechnet); 173,50 € (19 % *vom Bruttopreis* abgezogen – die 19 % beziehen sich aber auf den Nettopreis); 254,90 € (Steuer zusätzlich aufgeschlagen).
]

#aufgabe(titel: "Ü 4: Holzregale", herkunft: "original", vorlage: "Übung 08 KLR, Aufg. 4", minuten: 15, art: "rechnen", quelle: "1.1")[
#if not web [*Aufgabe 3* #linebreak()]
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

#aufgabe(titel: "Nettopreis aus dem Bruttopreis", herkunft: "variante", vorlage: "Übung 08 KLR, Aufg. 4", minuten: 4, art: "rechnen", quelle: "1.1",
  ergebnis: [$e = 200$ €/Stück],
  tipp: [Brutto ist netto plus 19 %, also netto mal 1,19.],
)[
#if not web [*Aufgabe 4* #linebreak()]
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

#aufgabe(titel: "Alte Ü 7: Fahrradrahmen", herkunft: "variante", vorlage: "Übung 08 KLR, Aufg. 4", minuten: 20, art: "rechnen", quelle: "1.1")[
#if not web [*Aufgabe 5* #linebreak()]
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

#aufgabe(titel: "A13: Dreherei", herkunft: "original", vorlage: "Altklausur SS 13, Aufg. 3", minuten: 12, art: "rechnen", quelle: "1.1")[
#if not web [*Aufgabe 6* #linebreak()]
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

#aufgabe(titel: "Kapazität und Beschäftigungsgrad", herkunft: "eigen", minuten: 4, art: "rechnen", quelle: "1.1")[
#if not web [*Aufgabe 7* #linebreak()]
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
][
*Ergänzung · typische Fehler:* 30 % ist die *freie* Kapazität, 143 % entsteht durch vertauschten Bruch. Weil beide Werte sich auf dieselbe Stunde beziehen, ist der BG ohne Monatsangabe berechenbar.

*Merksatz:* Gleiche Mengen brauchen denselben Zeitmaßstab.
]

#aufgabe(titel: "Fixe und variable Kosten", herkunft: "eigen", art: "verstehen", quelle: "1.2")[
#if not web [*Aufgabe 8* #linebreak()]
*Begriffe:* Erkläre fixe und variable Kosten mit je zwei Beispielen aus Ü 1. Weshalb ist „je Stück“ allein noch kein Beweis für variable Kosten? (Ü, PDF-S. 1; L15, PDF-S. 11.)
][
*Fix/variabel:* Miete und Gehälter sind in Ü 1 monatlich fix; RHB-Stoffe und Akkordlohn werden je Packung verursacht. Aber $k_f=K_f/x$ ist ebenfalls ein Stückbetrag, obwohl sein Gesamtbetrag fix ist. Der Kostenanfall, nicht die Schreibweise allein, entscheidet.
][
*Ergänzung · Test und Zuordnung:* Frag bei jeder Position: Ändert sich der Gesamtbetrag, wenn ich eine Packung mehr herstelle? In Ü 1 sind Akkordlöhne (22 €/Packung), RHB-Stoffe (6 €/Packung) und Energie (2 €/Packung) variabel; Gehälter, Miete, Nebenkosten, Fremdkapitalzinsen und die hier zeitabhängig angesetzten Abschreibungen sind fix. *Typische Verwechslung:* Abschreibungen oder Zinsen „wegen der Maschine“ für variabel halten.

*Merksatz:* Fix bleibt im Bereich gleich; variabel wächst mit der Menge. „Je Stück“ beschreibt die Angabe, nicht das Kostenverhalten.

*Bild:* Handyvertrag: Grundgebühr ist fix, jede Minute variabel.
]

#aufgabe(titel: "Mischkosten zerlegen", herkunft: "eigen", art: "verstehen", quelle: "1.2")[
#if not web [*Aufgabe 9* #linebreak()]
*Mischkosten:* Was musst Du vor dem Rechnen mit ihnen tun? Erkläre es am Grundpreis einer Stromrechnung. (Ü, PDF-S. 1, Randnotiz; L15, PDF-S. 4.)
][
*Mischkosten:* In einen festen Grundbetrag und einen mengenabhängigen Anteil zerlegen. Beim Strombeispiel ist der Grundpreis fix, der Verbrauchspreis je kWh variabel. Erst danach eine lineare Kostenfunktion aufstellen.
][
*Merksatz:* Mischkosten erst zerlegen, dann rechnen.

*Bild:* Ein Taxipreis aus Grundpreis und Kilometerpreis: Ein Teil fällt einmal an, ein Teil wächst mit der Fahrt.
]

#aufgabe(titel: "Sprungfixe Kosten", herkunft: "eigen", art: "verstehen", quelle: "1.2")[
#if not web [*Aufgabe 10* #linebreak()]
*Sprungfix:* Was ändert sich beim Überschreiten der Grenze in der Randzeichnung? Warum ist ein unverändertes $K_f$ über die Grenze hinweg falsch? (Ü, PDF-S. 1.)
][
*Sprungfix:* Der feste Kostenblock steigt an einer Mengengrenze. Mehr Menge verteilt dann nicht nur dieselben Fixkosten; es kommen neue hinzu. Deshalb musst Du für den neuen Bereich ein neues $K_f$ ansetzen.
][
*Ergänzung · Beispiel:* Ab 9 000 Stück braucht ein Betrieb eine zweite Maschine, deren Miete monatlich fest anfällt: Das sind *sprungfixe* Kosten. *Typische Verwechslungen:* keine variablen Kosten (sie ändern sich nicht mit jedem Stück), keine Mischkosten (die haben gleichzeitig fixen und variablen Anteil) und keine Stückkosten (das ist eine Bezugsgröße, keine Kostenart).

*Merksatz:* Sprungfix heißt: gleich bis zur nächsten Stufe.

*Bild:* Treppe statt Rampe.
]

#aufgabe(titel: "Ü 1: Modelleisenbahn-Zubehör", herkunft: "original", vorlage: "Übung 08 KLR, Aufg. 1", minuten: 35, art: "rechnen", quelle: "1.2")[
#if not web [*Aufgabe 11* #linebreak()]
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
*Kosten aufteilen:* $K_f=9000+1600+400+3000+6000=20 000$ €/Monat. $k_v=6+22+2=30$ €/Packung. Somit $K(x)=20 000+30x$; die Kosten je Menge sind:
#tab(columns: (1fr,1fr,1fr,1fr,1fr), th([$x$],[$K_f$ €],[$K_v$ €],[$K$ €],[$k$ €/Pack.]),
 [200],[20 000],[6 000],[26 000],[130,00], [400],[20 000],[12 000],[32 000],[80,00], [600],[20 000],[18 000],[38 000],[63,33], [800],[20 000],[24 000],[44 000],[55,00], [1 000],[20 000],[30 000],[50 000],[50,00])
][
*600 Packungen:* $E=70 dot 600=42 000$ €, $K=20 000+30 dot 600=38 000$ €. *$G=+4000$ €*. Gegenprobe: $(70-30) dot 600-20 000=+4000$ €.
][
*BEP und Skizze:* $d b_"I"=40$ €/Packung, $x_"BEP"=20 000/40=500$ Packungen; $E_"BEP"=70 dot 500=35 000$ €. Die Geraden sind $E=70x$ und $K=20 000+30x$ mit Schnittpunkt $(500;35 000)$.
#bild("bep-aufgabe1", [Eigene Darstellung nach Ü 1, PDF-S. 1.], height: 55mm)
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

#aufgabe(titel: "Alte Ü 11: Gesamtfall", herkunft: "variante", vorlage: "Übung 08 KLR, Aufg. 3", minuten: 20, art: "rechnen", quelle: "1.2")[
#if not web [*Aufgabe 12* #linebreak()]
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

#aufgabe(titel: "Warum die Stückkosten sinken", herkunft: "eigen", art: "verstehen", quelle: "1.3")[
#if not web [*Aufgabe 13* #linebreak()]
*Stückkosten:* Warum sinkt $k(x)$ bei wachsender Menge? Kann $k$ bei positivem $K_f$ unter $k_v$ fallen? Was passiert bei $x=0$? (Ü 1, PDF-S. 1; L15, PDF-S. 4–5; Präzisierung.)
][
*Stückkosten:* Bei positivem $K_f$ sinkt $K_f/x$ mit wachsendem $x$. $k_v$ bleibt unverändert. Daher liegt $k=K_f/x+k_v$ bei endlichem $x>0$ über $k_v$. Bei $x=0$ ist die Division nicht definiert; $K(0)=K_f$ bleibt sinnvoll.
][
*Ergänzung · Fixkostendegression:* Gemeint ist, dass die *fixen Kosten je Stück* sinken, weil sich derselbe Block auf mehr Stücke verteilt (200 Packungen: 100 €/Packung, 1 000 Packungen: 20 €/Packung). *Typische Verwechslungen:* „Die Fixkosten sinken“ (der Gesamtbetrag bleibt), „$k_v$ sinkt“ (im linearen Modell konstant), „Stückkosten sinken bis null“ (sie nähern sich höchstens $k_v$). Bei $x=0$ fallen die Fixkosten trotzdem an, $K(0)=K_f$; nur die Division durch null ist nicht möglich – nicht weil Kosten verschwinden oder negativ würden.

*Merksatz:* Mehr Stücke teilen sich denselben Fixkostenblock.

*Bild:* Eine WG teilt die Miete: Zu viert zahlt jeder weniger als zu zweit, das Essen pro Person wird dadurch aber nicht billiger.
]

#aufgabe(titel: "Menge verdoppeln: was halbiert sich?", herkunft: "eigen", art: "verstehen", quelle: "1.3")[
#if not web [*Aufgabe 14* #linebreak()]
*Menge verdoppeln:* $K_f$ und $k_v$ bleiben gleich. Welche Größe halbiert sich: $K_f$, $k_f$ oder $k$? Begründe mit einer Formel. (Frühere Auswahlfrage, L15, PDF-S. 12–13, in offene Frage umgestellt.)
][
*Verdoppelung:* $k_f(2x)=K_f/(2x)=k_f(x)/2$; $K_f$ bleibt gleich. Insgesamt $k(2x)=k_f(x)/2+k_v$: Die gesamten Stückkosten halbieren sich bei positivem $k_v$ gerade nicht. Der variable Anteil bleibt bestehen.
][
*Ergänzung:* $K_f$ bleibt gleich, $k_f$ halbiert sich, $k$ sinkt, aber nicht auf die Hälfte, weil $k_v$ gleich bleibt.
]

#aufgabe(titel: "Stückkosten bei 400 Packungen", art: "verstehen", quelle: "1.3", herkunft: "eigen")[
#if not web [*Aufgabe 15* #linebreak()]
Fixkosten 20 000 €/Monat, variable Kosten 30 € je Packung. Wie hoch sind die Stückkosten bei 400 Packungen? Erkläre, warum 30 €, 50 € oder 32 000 € falsch sind.
][
*Rechnung:* $k=K_f/x+k_v=20 000/400+30=50+30=80$ €/Packung.

*Typische Verwechslungen:* 30 € sind nur $k_v$ (Fixanteil fehlt). 50 € gelten bei 1 000 Packungen; bei 400 verteilen sich die Fixkosten auf weniger Stücke. 32 000 € sind die Gesamtkosten $K(400)$, nicht die Kosten je Stück.
]

#aufgabe(titel: "Die Kostenfunktion lesen", art: "verstehen", quelle: "1.3", herkunft: "eigen")[
#if not web [*Aufgabe 16* #linebreak()]
Was beschreibt die Kostenfunktion $K(x)=K_f+k_v x$, wie sieht sie im Diagramm aus und wann gilt sie?
][
*Bedeutung:* Die Gesamtkosten einer Periode: ein fester Block $K_f$ plus für jedes Stück die variablen Kosten $k_v$. Im Diagramm eine Gerade, die bei $K_f$ beginnt und mit der Steigung $k_v$ ansteigt.

*Gültigkeit:* nur solange die Fixkosten im Mengenbereich gleich bleiben (kein Sprung) und die variablen Kosten proportional sind.
]

#aufgabe(titel: "A13: Kunststoffbehälter", herkunft: "original", vorlage: "Altklausur SS 13, Aufg. 4", minuten: 12, art: "rechnen", quelle: "1.3")[
#if not web [*Aufgabe 17* #linebreak()]
*A13 · KLR, zweiter Fall, PDF-S. 3–4, Teile a–b:*

*Gegeben und Annahmen*

Ein Einproduktbetrieb stellt Kunststoffbehälter für Gartenabfälle her. Preis 200 €/Stück, Fertigungsmaterial 60 €/Stück, Fertigungslohn 20 €/Stück, jährliche Fixkosten 900 000 €.

*Gesucht*

#enum(numbering: "a)",
[Jährliche BEP-Menge und BEP-Umsatz?],
[Betriebsergebnis und Umsatzrendite bei 10 000 Stück? Die Umsatzrendite ist in 2.4.1 eingeordnet.],
)
][
*Modell:* Jahresbetrachtung, Material und Fertigungslohn proportional, fixe Jahreskosten konstant; vollständiger Absatz.
][
*Stück-DB:* $k_v=60+20=80$ €/Stück; $d b_"I"=200-80=120$ €/Stück.
][
*Schwelle:* *$x_"BEP"=900 000/120=7500$ Stück/Jahr*. BEP-Umsatz *$E_"BEP"=200 dot 7500=1 500 000$ €/Jahr*.
][
*10 000 Stück:* $E=2 000 000$ €, $K=900 000+80 dot 10 000=1 700 000$ €. *$G=+300 000$ €/Jahr*. Die Umsatzrendite ist $300000/2000000 dot 100 %=15 %$; sie bezieht den Gewinn auf den Umsatz, siehe Abschnitt 2.4.1.
][
*Prüfung:* Bei 7 500 Stück sind Erlös und Kosten je 1,5 Mio. €; 2 500 weitere Stück liefern $2500 dot 120=300 000$ € Gewinn. Eine Kapazitätsangabe fehlt, daher keine gesicherte Aussage zur maximalen Menge. Quelle: A13, PDF-S. 3–4, KLR-Fall, Teile a–b; Einzelseiten 3.pdf/4.pdf.
]

#aufgabe(titel: "A18 I: Vollkosten und Deckungsbeitrag", herkunft: "original", vorlage: "Altklausur WS 18/19, Aufg. I", minuten: 10, art: "rechnen", quelle: "1.3")[
#if not web [*Aufgabe 18* #linebreak()]
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

#aufgabe(titel: "Alte Ü 10: Zwei Kostenlinien", herkunft: "variante", vorlage: "Datei 04 (kritische Auslastung)", minuten: 8, art: "rechnen", quelle: "1.3")[
#if not web [*Aufgabe 19* #linebreak()]
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

#aufgabe(titel: "Deckungsbeitrag mit dem Eimerbild", herkunft: "eigen", art: "verstehen", quelle: "1.4")[
#if not web [*Aufgabe 20* #linebreak()]
*Deckungsbeitrag:* Erkläre mit dem Eimerbild, was ein Stückdeckungsbeitrag ist und weshalb er noch nicht der Gewinn je Stück sein muss. (M, PDF-S. 2; L15, PDF-S. 5.)
][
*Stück-DB:* Der Eimer wird mit $e-k_v$ je Stück gefüllt. Dieser Betrag muss zuerst die Fixkosten mittragen. Gewinn je Stück ist erst $d b_"II"=d b_"I"-K_f/x$; er hängt von der Menge ab.
][
*Merksatz:* Der Deckungsbeitrag deckt zuerst die Fixkosten – er ist noch kein Gewinn. Erst wenn alle Deckungsbeiträge zusammen die Fixkosten übersteigen, entsteht Gewinn.

*Bild:* Die Fixkosten sind ein leerer Eimer. Jedes verkaufte Stück schüttet seinen Deckungsbeitrag hinein; erst wenn der Eimer voll ist, entsteht Gewinn.
]

#aufgabe(titel: "Schreibweisen des Deckungsbeitrags", herkunft: "eigen", art: "verstehen", quelle: "1.4")[
#if not web [*Aufgabe 21* #linebreak()]
*Schreibweise:* Unterscheide $d b_"I",d b_"II",D B_"I",D B_"II"$ in der einstufigen Rechnung. Nenne Einheiten und Umrechnung. (M, PDF-S. 1–2; K, PDF-S. 1.)
][
*Stück und gesamt:* $d b_"I"=e-k_v$ und $d b_"II"=d b_"I"-k_f$ sind €/Stück. $D B_"I"=d b_"I" x$ und im einstufigen Schema $D B_"II"=D B_"I"-K_f=G$ sind €/Periode. Multipliziere Stückwerte mit der zugehörigen Menge; umgekehrt teile durch $x>0$.
]

#aufgabe(titel: "Ein- und mehrstufige DB-Rechnung", herkunft: "eigen", art: "verstehen", quelle: "1.4")[
#if not web [*Aufgabe 22* #linebreak()]
*Stufen der DB-Rechnung:* Unterscheide das ein- und mehrstufige Abziehen von Fixkosten. Warum kann „DB II“ in beiden Schemata Unterschiedliches bedeuten? (Ü, PDF-S. 1, Randnotiz; L02, PDF-S. 5 und 11.)
][
*Ein-/mehrstufig:* Einstufig wird der gesamte Fixkostenblock vom gesamten DB abgezogen. Mehrstufig werden nacheinander Produkt-, Produktgruppen- und Unternehmensfixkosten abgezogen. Ein DB nach Produktfixkosten ist deshalb noch kein endgültiger Unternehmensgewinn. Die jeweilige Stufe muss benannt sein.
][
*Ergänzung:* Mehrstufig ordnet man die Fixkosten erst dem Produkt (erzeugnisfix), dann der Produktgruppe (gruppenfix) und zuletzt dem Unternehmen zu. Deshalb kann „DB II“ je nach Schema etwas anderes bedeuten – das Wiederholungsblatt, Aufg. 5, rechnet genau so.
]

#aufgabe(titel: "Stückdeckungsbeitrag aus Preis und variablen Kosten", art: "verstehen", quelle: "1.4", herkunft: "eigen")[
#if not web [*Aufgabe 23* #linebreak()]
Eine Packung bringt netto 70 €, die variablen Kosten betragen 30 € je Packung. Wie hoch ist der Stückdeckungsbeitrag und wofür steht er? Woran erkennst Du die falschen Ergebnisse 100 €, 70 € und 20 €?
][
*Antwort:* $d b_"I"=e-k_v=70-30=40$ €/Packung. Diesen Betrag trägt jede Packung zur Deckung der Fixkosten bei.

*Typische Verwechslungen:* 100 € = addiert statt subtrahiert; 70 € = nur der Preis; 20 € = zusätzlich Fixkosten je Stück abgezogen, das wäre $d b_"II"$ bei 1 000 Stück und hängt von der Menge ab.
]

#aufgabe(titel: "Gewinn über den Deckungsbeitrag", art: "verstehen", quelle: "1.4", herkunft: "eigen")[
#if not web [*Aufgabe 24* #linebreak()]
Welche Gleichungen beschreiben im einstufigen Schema den Gewinn richtig, und warum sind $G=d b_"I"-K_f$ und $G=(e-k_v)x-K_f x$ falsch?
][
*Richtig:* $G=E(x)-K(x)$ (Grunddefinition) und der Schnellweg $G=d b_"I" dot x-K_f=D B_"I"-K_f$: Stück-DB mal Menge, dann die Fixkosten *genau einmal* abziehen. Beides ist dieselbe Rechnung.
][
*Falsch:* $d b_"I"-K_f$ mischt €/Stück mit €/Periode (die Menge fehlt). $K_f x$ würde die Fixkosten mit jedem Stück vervielfachen, obwohl sie einmal je Periode anfallen.
]

#aufgabe(titel: "Viel Umsatz und trotzdem Verlust", art: "verstehen", quelle: "1.4", herkunft: "eigen")[
#if not web [*Aufgabe 25* #linebreak()]
Warum kann ein Betrieb viel verkaufen und trotzdem Verlust machen?
][
*Reihenfolge der Deckung:* Jedes Stück bezahlt erst seine eigenen variablen Kosten. Der Rest, der Deckungsbeitrag, muss dann noch die Fixkosten decken. Ist der Deckungsbeitrag je Stück zu klein oder die Menge zu gering, bleibt trotz hohem Umsatz ein Verlust.

*Merksatz:* Umsatz füllt erst Kostenlücken, dann entsteht Gewinn.
#bild("deckungsbalken", [Vom Erlös zum Deckungsbeitrag.], height: 40mm)
]

#aufgabe(titel: "A14 I.1: Fixkosten aus dem Gesamt-DB", herkunft: "original", vorlage: "Altklausur WS 14/15, Aufg. I.1", minuten: 8, art: "rechnen", quelle: "1.4")[
#if not web [*Aufgabe 26* #linebreak()]
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

#aufgabe(titel: "A14 I.1: Fixkosten aus dem Gesamt-DB (Variante)", art: "rechnen", quelle: "1.4", herkunft: "variante", vorlage: "Altklausur WS 14/15, Aufg. I.1", minuten: 5,
  ergebnis: [$K_f=34 000$ €/Monat])[
#if not web [*Aufgabe 27* #linebreak()]
*Gegeben und Annahmen*

Die monatlichen Gesamt-Deckungsbeiträge der Produkte A–D betragen 3 800 €, 7 250 €, 12 600 € und 9 150 €. Das Betriebsergebnis ist ein *Verlust* von 1 200 €.

*Gesucht*

#enum(numbering: "a)",
[Wie hoch sind die monatlichen Fixkosten?],
)
][
*Summe der DB:* $3800+7250+12 600+9150=32 800$ €.
][
*Umstellen mit Vorzeichen:* $G=D B-K_f => K_f=D B-G=32 800-(-1200)=34 000$ €.
][
*Prüfen:* $32 800-34 000=-1200$ € ✓. Typischer Fehler: Verlust ohne Minuszeichen einsetzen (ergäbe 31 600 €).
]

#aufgabe(titel: "Wiederholung 1: Deckungsbeiträge dreier Produkte", art: "rechnen", quelle: "1.4", herkunft: "original", vorlage: "Wiederholungsblatt KLR/DBR, Aufg. 1", minuten: 8,
  ergebnis: [$d b_"I"$: 1,50 / 1,00 / 4,50 €/Stück; $D B_"I"$: 4 500 / 2 000 / 18 000 €; gesamt 24 500 €; $D B_"II"=+9 500$ €.])[
#if not web [*Aufgabe 28* #linebreak()]
*Gegeben und Annahmen*

Ein Industriebetrieb stellt drei Produkte her. Die fixen Kosten der Periode betragen insgesamt 15 000 €.
#tab(columns: (2fr, 1fr, 1fr, 1fr),
 th([], [Produkt A], [Produkt B], [Produkt C]),
 [Absatz in Stück], [3 000], [2 000], [4 000],
 [Verkaufspreis €/Stück], [3,50], [5,00], [11,50],
 [Variable Kosten gesamt €], [6 000], [8 000], [28 000],
)

*Gesucht*

#enum(numbering: "a)",
[den Stückdeckungsbeitrag $d b_"I"$ der drei Produkte,],
[den Deckungsbeitrag $D B_"I"$ pro Periode je Produkt,],
[den gesamten $D B_"I"$ der Periode,],
[den $D B_"II"$ der Periode.],
)
][
*Variable Stückkosten zuerst:* Die variablen Kosten sind als Periodensumme gegeben. Für den Stück-DB brauchst Du Euro je Stück, also teilen: $k_(v,A)=6000/3000=2$, $k_(v,B)=8000/2000=4$, $k_(v,C)=28000/4000=7$ €/Stück.
][
*Stückdeckungsbeiträge:* $d b_"I"=e-k_v$: A $"3,50"-2="1,50"$, B $5-4=1$, C $"11,50"-7="4,50"$ €/Stück. Jedes Stück schüttet diesen Betrag in den gemeinsamen Fixkosten-Eimer.
][
*Periodenbeiträge:* $D B_"I"=d b_"I" dot x$: A $"1,50" dot 3000=4500$ €, B $1 dot 2000=2000$ €, C $"4,50" dot 4000=18 000$ €. Gesamt *24 500 €*.
][
*DB II:* Die Fixkosten sind gemeinsame Kosten und werden genau *einmal* vom Gesamt-DB abgezogen: $D B_"II"=24 500-15 000=+9 500$ €. Das ist im einstufigen Schema der Periodengewinn.
][
*Prüfen:* Erlös $10 500+10 000+46 000=66 500$ €, Kosten $42 000+15 000=57 000$ €, Differenz 9 500 € ✓.
]

#aufgabe(titel: "Wiederholung 1: Deckungsbeiträge (Variante)", art: "rechnen", quelle: "1.4", herkunft: "variante", vorlage: "Wiederholungsblatt KLR/DBR, Aufg. 1", minuten: 8,
  ergebnis: [$d b_"I"$: 1,50 / 3,00 / 4,00 €/Stück; $D B_"I"$ gesamt 24 500 €; $D B_"II"=+4 500$ €.])[
#if not web [*Aufgabe 29* #linebreak()]
*Gegeben und Annahmen*

Ein Betrieb verkauft drei Produkte X, Y, Z. Gemeinsame Fixkosten der Periode: 20 000 €.
#tab(columns: (2fr, 1fr, 1fr, 1fr),
 th([], [X], [Y], [Z]),
 [Absatz in Stück], [5 000], [3 000], [2 000],
 [Verkaufspreis €/Stück], [4,00], [8,00], [15,00],
 [Variable Kosten gesamt €], [12 500], [15 000], [22 000],
)

*Gesucht*

#enum(numbering: "a)",
[$d b_"I"$ je Produkt,],
[$D B_"I"$ je Produkt und gesamt,],
[$D B_"II"$ der Periode. Welches Produkt trägt am meisten zur Fixkostendeckung bei?],
)
][
*Variable Stückkosten:* X $12 500/5000="2,50"$, Y $15 000/3000=5$, Z $22 000/2000=11$ €/Stück.
][
*Stück-DB:* X $4-"2,50"="1,50"$, Y $8-5=3$, Z $15-11=4$ €/Stück.
][
*Perioden-DB:* X 7 500 €, Y 9 000 €, Z 8 000 €; gesamt *24 500 €*. Den größten Beitrag liefert *Y* (9 000 €), obwohl Z den höchsten Stück-DB hat: Es zählt Stück-DB *mal Menge*.
][
*DB II und Prüfung:* $24 500-20 000=+4 500$ €. Probe: Erlös $20 000+24 000+30 000=74 000$ €, Kosten $49 500+20 000=69 500$ € ✓.
]

#aufgabe(titel: "Wiederholung 5: Mehrstufige DB-Rechnung", art: "rechnen", quelle: "1.4", herkunft: "original", vorlage: "Wiederholungsblatt KLR/DBR, Aufg. 5", minuten: 15,
  ergebnis: [Betriebserfolg +150 000 €; Reihenfolge nach Stück-DB: C, B, A, D.])[
#if not web [*Aufgabe 30* #linebreak()]
*Gegeben und Annahmen*

Ein Industriebetrieb bietet vier Produkte in zwei Produktgruppen an (alle Werte je Periode):
#tab(columns: (2fr, 1fr, 1fr, 1fr, 1fr),
 th([], [A (Gr. I)], [B (Gr. I)], [C (Gr. II)], [D (Gr. II)]),
 [Absatzmenge Stück], [3 000], [2 000], [1 000], [4 000],
 [Erlös $E$ in €], [290 000], [360 000], [180 000], [450 000],
 [$K_v$ in €], [130 000], [170 000], [70 000], [280 000],
 [Erzeugnisfixe Kosten €], [40 000], [50 000], [20 000], [70 000],
)
Erzeugnisgruppenfixe Kosten: Gruppe I 150 000 €, Gruppe II 60 000 €. Unternehmensfixe Kosten: 90 000 €. Kein Engpass angegeben.

*Gesucht*

#enum(numbering: "a)",
[Ermittle den Betriebserfolg mit der mehrstufigen Deckungsbeitragsrechnung.],
[Lege die Reihenfolge fest, in der die Produkte (bevorzugt) zu produzieren sind.],
)
][
*Stufe 1 · DB I:* $E-K_v$: A 160 000, B 190 000, C 110 000, D 170 000 €. Das deckt erst einmal nur die variablen Kosten jedes Produkts.
][
*Stufe 2 · DB II:* minus erzeugnisfixe Kosten (die nur wegen dieses Produkts anfallen): A 120 000, B 140 000, C 90 000, D 100 000 €.
][
*Stufe 3 · DB III:* minus gruppenfixe Kosten je Gruppe: Gruppe I $260 000-150 000=110 000$ €, Gruppe II $190 000-60 000=130 000$ €.
][
*Betriebserfolg:* $110 000+130 000-90 000=+150 000$ €. Gegenprobe: Gesamterlös 1 280 000 € minus $K_v$ 650 000 € minus alle Fixkosten $180 000+210 000+90 000=480 000$ € ergibt 150 000 € ✓.
][
*Reihenfolge:* Ohne Engpass entscheidet der Stück-DB I: A $160 000/3000 approx "53,33"$, B $190 000/2000=95$, C $110 000/1000=110$, D $170 000/4000="42,50"$ €/Stück. Reihenfolge *C, B, A, D*. Alle Produkte haben positive DB II; keines sollte gestrichen werden. Gäbe es einen Engpass (z. B. Maschinenstunden), würde man stattdessen den DB je Engpasseinheit verwenden.
]

#aufgabe(titel: "Wiederholung 5: Mehrstufige DB-Rechnung (Variante)", art: "rechnen", quelle: "1.4", herkunft: "variante", vorlage: "Wiederholungsblatt KLR/DBR, Aufg. 5", minuten: 12,
  ergebnis: [DB III: Gruppe I 80 000 €, Gruppe II 20 000 €; Betriebserfolg +50 000 €; Reihenfolge P2, P1, P3.])[
#if not web [*Aufgabe 31* #linebreak()]
*Gegeben und Annahmen*

Drei Produkte, P1 und P2 bilden Gruppe I, P3 bildet Gruppe II (Werte je Periode):
#tab(columns: (2fr, 1fr, 1fr, 1fr),
 th([], [P1], [P2], [P3]),
 [Absatz Stück], [2 000], [1 500], [3 000],
 [Erlös €], [200 000], [240 000], [270 000],
 [$K_v$ €], [90 000], [140 000], [180 000],
 [Erzeugnisfixe Kosten €], [30 000], [40 000], [50 000],
)
Gruppenfixe Kosten: Gruppe I 60 000 €, Gruppe II 20 000 €; unternehmensfixe Kosten 50 000 €. Kein Engpass.

*Gesucht*

#enum(numbering: "a)",
[DB I, DB II, DB III und den Betriebserfolg.],
[Reihenfolge der Produkte. Lohnt Gruppe II noch?],
)
][
*DB I:* P1 110 000, P2 100 000, P3 90 000 €.
][
*DB II:* P1 80 000, P2 60 000, P3 40 000 €.
][
*DB III und Erfolg:* Gruppe I $140 000-60 000=80 000$ €, Gruppe II $40 000-20 000=20 000$ €. Betriebserfolg $100 000-50 000=+50 000$ €.
][
*Reihenfolge und Urteil:* Stück-DB I: P1 55, P2 $100 000/1500 approx "66,67"$, P3 30 €/Stück → *P2, P1, P3*. Gruppe II deckt ihre eigenen Fixkosten und trägt 20 000 € zu den Unternehmensfixkosten bei. Ohne sie fiele der Erfolg (bei unveränderten Unternehmensfixkosten) auf +30 000 €; sie bleibt also.
]

#aufgabe(titel: "Wiederholung 2: Produkt streichen?", art: "rechnen", quelle: "1.4", herkunft: "original", vorlage: "Wiederholungsblatt KLR/DBR, Aufg. 2", minuten: 12,
  ergebnis: [Vollkosten: B streichen (−20 000 €). DB-Rechnung: $D B_"I"(B)=+60 000$ €; ohne B fällt das Betriebsergebnis von 210 000 auf 150 000 €. B behalten.])[
#if not web [*Aufgabe 32* #linebreak()]
*Gegeben und Annahmen*

Ein Industriebetrieb hat für den Monat April 2014 folgende Daten (in €):
#tab(columns: (2fr, 1fr, 1fr, 1fr, 1fr),
 th([], [Gesamt], [A], [B], [C]),
 [Selbstkosten des Umsatzes], [760 000], [320 000], [140 000], [300 000],
 [Umsatzerlöse], [970 000], [470 000], [120 000], [380 000],
 [Betriebsergebnis], [210 000], [150 000], [−20 000], [80 000],
)
Die Selbstkosten enthalten Fixkosten von 450 000 €. Die variablen Selbstkosten betragen für A 150 000 €, für B 60 000 €, für C 100 000 €. Die Fixkosten fallen auch ohne B unverändert an.

*Gesucht*

#enum(numbering: "a)",
[Welche Entscheidung über die drei Produkte würde man nur mit den obigen (Vollkosten-)Informationen treffen?],
[Wie verändert sich das Betriebsergebnis, wenn B nicht mehr produziert wird?],
[Berechne das Betriebsergebnis mit der Deckungsbeitragsrechnung.],
)
][
*Vollkostensicht:* B zeigt −20 000 €. Nur mit dieser Tabelle würde man B *streichen*.
][
*DB-Rechnung:* $D B_"I"=E-K_v$: A $470 000-150 000=320 000$ €, B $120 000-60 000=60 000$ €, C $380 000-100 000=280 000$ €. Summe 660 000 €; minus Fixkosten einmal: $660 000-450 000=+210 000$ € ✓ (wie die Gesamtspalte).
][
*Ohne B:* Der DB von B (60 000 €) fällt weg, die 450 000 € Fixkosten bleiben. $600 000-450 000=+150 000$ €. Das Ergebnis *sinkt um 60 000 €*.
][
*Entscheidung:* B *behalten*. Der Verlust in der Vollkostenspalte entsteht nur, weil B ein Anteil der ohnehin anfallenden Fixkosten zugerechnet wurde. Solange B einen positiven DB liefert und die Fixkosten nicht abbaubar sind, verbessert B das Gesamtergebnis.
]

#aufgabe(titel: "Wiederholung 2: Produkt streichen? (Variante)", art: "rechnen", quelle: "1.4", herkunft: "variante", vorlage: "Wiederholungsblatt KLR/DBR, Aufg. 2", minuten: 10,
  ergebnis: [$D B_"I"$: 300 000 / 60 000 / 160 000 €; ohne B sinkt das Ergebnis von 140 000 auf 80 000 €.])[
#if not web [*Aufgabe 33* #linebreak()]
*Gegeben und Annahmen*

Monatswerte in €:
#tab(columns: (2fr, 1fr, 1fr, 1fr, 1fr),
 th([], [Gesamt], [A], [B], [C]),
 [Selbstkosten], [830 000], [400 000], [180 000], [250 000],
 [Umsatzerlöse], [970 000], [520 000], [150 000], [300 000],
 [Ergebnis], [140 000], [120 000], [−30 000], [50 000],
)
Darin enthalten sind Fixkosten von 380 000 €, die bei Streichung eines Produkts unverändert bleiben. Variable Selbstkosten: A 220 000 €, B 90 000 €, C 140 000 €.

*Gesucht*

#enum(numbering: "a)",
[DB je Produkt und Betriebsergebnis mit der DB-Rechnung.],
[Ergebnis ohne B und Empfehlung.],
)
][
*DB I:* A $520 000-220 000=300 000$, B $150 000-90 000=60 000$, C $300 000-140 000=160 000$ €. Summe 520 000 €; minus 380 000 € = *+140 000 €* ✓.
][
*Ohne B:* $460 000-380 000=+80 000$ €, also 60 000 € weniger.
][
*Empfehlung:* B behalten; sein „Verlust“ von −30 000 € ist ein Effekt der Fixkostenverteilung. Typische Verwechslung: Vollkostenergebnis je Produkt mit vermeidbarem Ergebnis gleichsetzen.
]

#aufgabe(titel: "A18 I: Vollkosten und Deckungsbeitrag (Variante)", art: "rechnen", quelle: "1.4", herkunft: "variante", vorlage: "Altklausur WS 18/19, Aufg. I", minuten: 12,
  ergebnis: [Vollkosten: +20 000 / −10 000 / +45 000 €; DB 72 000 / 60 000 / 97 500 €; ohne Komfort −5 000 € statt +55 000 €.])[
#if not web [*Aufgabe 34* #linebreak()]
*Gegeben und Annahmen*

#tab(columns: (2fr, 1fr, 1fr, 1fr),
 th([], [Basic], [Komfort], [Premium]),
 [Absatz Stück], [4 000], [2 000], [1 500],
 [Preis €/Stück], [40], [90], [150],
 [Vollkosten €/Stück], [35], [95], [120],
 [Variable Kosten €/Stück], [22], [60], [85],
)
Gemeinsame Fixkosten 174 500 €; sie bleiben bei Streichung einer Variante gleich.

*Gesucht*

#enum(numbering: "a)",
[Ergebnis je Variante nach Vollkosten und gesamt; welche Entscheidung legt das nahe?],
[DB je Variante und Gesamtgewinn mit der DB-Rechnung,],
[Ergebnis ohne Komfort. Empfehlung?],
)
][
*a) Vollkosten:* Basic $5 dot 4000=+20 000$, Komfort $-5 dot 2000=-10 000$, Premium $30 dot 1500=+45 000$ €; gesamt +55 000 €. Nahe läge: Komfort streichen.
][
*b) DB:* Basic $18 dot 4000=72 000$, Komfort $30 dot 2000=60 000$, Premium $65 dot 1500=97 500$ €; Summe 229 500 €; $-174 500 => +55 000$ € ✓.
][
*c) Ohne Komfort:* $72 000+97 500-174 500=-5 000$ €. Komfort *behalten* – es deckt 60 000 € Fixkosten mit.
]

#aufgabe(titel: "Gewinnschwelle herleiten", herkunft: "eigen", art: "verstehen", quelle: "1.5")[
#if not web [*Aufgabe 35* #linebreak()]
*Gewinnschwelle:* Leite $x_"BEP"$ aus $E=K$ her. Wann ist die Formel sinnvoll? Was gilt am exakten BEP für $G$ und $D B_"I"$? (M, PDF-S. 2; F, PDF-S. 5.)
][
*Herleitung:* $e x=K_f+k_v x => (e-k_v)x=K_f => x=K_f/(e-k_v)$. Für positive Fixkosten wird ein positiver Stück-DB benötigt. Am exakten Schnittpunkt ist $G=0$ und $D B_"I"=K_f$. Bei einer aufgerundeten ganzen Menge kann bereits ein kleiner Gewinn entstehen.
][
*Merksatz:* Gewinnschwelle: Fixkosten gerade gedeckt. Anschaulich: Wie viele Deckungsbeiträge brauche ich, um den Fixkosten-Eimer zu füllen?
]

#aufgabe(titel: "Beschäftigungsgrad als Puffer", herkunft: "eigen", art: "verstehen", quelle: "1.5")[
#if not web [*Aufgabe 36* #linebreak()]
*Beschäftigungsgrad:* Warum lässt ein hoher BG am BEP wenig Puffer? Unterscheide theoretische Schwelle und kleinste ganze Menge ohne Verlust. (Ü 4, PDF-S. 2; Präzisierung.)
][
*Puffer:* Ein Absatzrückgang erreicht die Verlustzone schneller, wenn der BEP nahe an der Kapazität liegt. Die theoretische Schwelle kann zwischen zwei ganzen Stückzahlen liegen. Die kleinste ganze Menge ohne Verlust ist dann die nächsthöhere Zahl; ihren BG ausdrücklich als ganzzahligen Fall kennzeichnen.
][
*Ergänzung · Zahlenbeispiel Ü 4:* Bei 85 % Auslastung werden 1 020 Regale verkauft, die Schwelle liegt bei 915. Nur 105 Regale Abstand: Ein Absatzrückgang von gut 10 % führt schon in den Verlust. Ein hoher BG an der Gewinnschwelle (gut 76 %) heißt, dass man fast die ganze Kapazität braucht, nur um keinen Verlust zu machen. Preis, variable Kosten und Fixkosten prüfen.
]

#aufgabe(titel: "Typische Fehler bei der BEP-Formel", art: "verstehen", quelle: "1.5", herkunft: "eigen")[
#if not web [*Aufgabe 37* #linebreak()]
Fixkosten 20 000 €, Preis 70 €, variable Kosten 30 € je Packung. Wo liegt die Gewinnschwelle? Welche Denkfehler stecken hinter 286, 667 und 200 Packungen?
][
*Antwort:* $x_"BEP"=K_f/(e-k_v)=20 000/40=500$ Packungen. Wie viele Beiträge zu 40 € füllen den Fixkosten-Eimer?

*Typische Verwechslungen:* 286 = durch den Preis geteilt; 667 = durch $k_v$ geteilt; 200 = durch $e+k_v$ geteilt. Entscheidend ist nur der Beitrag je Stück.
]

#aufgabe(titel: "Gewinnschwelle bei ganzen Stückzahlen", art: "verstehen", quelle: "1.5", herkunft: "eigen")[
#if not web [*Aufgabe 38* #linebreak()]
Die exakte Gewinnschwelle liegt bei 914,29 Regalen (Stück-DB 70 €, $K_f$ 64 000 €). Welche ganze Stückzahl ist die kleinste ohne Verlust, und wie rundest Du allgemein?
][
*Aufrunden:* 914 Regale ergeben noch −20 €, *915* schon +50 €. Bei nicht ganzzahliger Schwelle wird aufgerundet, weil ein angebrochenes Stück keine volle Kostenlücke deckt. Eine bereits ganzzahlige Schwelle bleibt, wie sie ist.

*Typische Verwechslung:* abrunden (Verlust) oder „914,29 Regale verkaufen“ – Bruchteile werden nicht verkauft; die exakte Schwelle ist ein theoretischer Wert.
]

#aufgabe(titel: "Wann es keine Gewinnschwelle gibt", art: "verstehen", quelle: "1.5", herkunft: "eigen")[
#if not web [*Aufgabe 39* #linebreak()]
Unter welchen Bedingungen gibt es (bei positiven Fixkosten) keine erreichbare Gewinnschwelle?
][
*Stück-DB null oder negativ:* Bei $e=k_v$ deckt der Preis nur die variablen Kosten, bei $e<k_v$ nicht einmal diese. Dann bringt mehr Menge keinen Beitrag zu den Fixkosten bzw. vergrößert den Verlust; $x_"BEP"=K_f/d b_"I"$ ist nicht positiv oder nicht definiert.

*Merksatz:* Ohne positiven Stückbeitrag hilft mehr Menge nicht zur Gewinnschwelle.
]

#aufgabe(titel: "Ein Break-Even-Diagramm lesen", art: "verstehen", quelle: "1.5", herkunft: "eigen")[
#if not web [*Aufgabe 40* #linebreak()]
#bild("bep-aufgabe1", [Erlös- und Kostengerade aus Ü 1.], height: 50mm)
Erkläre, wie man dieses Break-Even-Diagramm liest: Achsen, Verlauf der beiden Geraden, Schnittpunkt, Gewinn- und Verlustzone, Kapazität.
][
*Lesen:* Waagerecht die Menge, senkrecht Euro je Periode. Die Erlösgerade startet im Ursprung mit Steigung $e$, die Kostengerade bei $K_f$ mit Steigung $k_v$. Der Schnittpunkt ist der BEP (hier 500 Packungen, 35 000 €). Rechts davon ist der senkrechte Abstand der Geraden der Gewinn, links der Verlust. Die Kapazität ist eine senkrechte Grenze; dort liegt bei positivem Stück-DB der größte Gewinn.
]

#aufgabe(titel: "VL 1: vorwärts und rückwärts", herkunft: "original", vorlage: "VL-1-Übung (KLR.pdf, S. 2)", minuten: 15, art: "rechnen", quelle: "1.5")[
#if not web [*Aufgabe 41* #linebreak()]
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

#aufgabe(titel: "Alte Ü 9: Preis gesucht", herkunft: "variante", vorlage: "VL-1-Übung (KLR.pdf, S. 2)", minuten: 10, art: "rechnen", quelle: "1.5")[
#if not web [*Aufgabe 42* #linebreak()]
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

#aufgabe(titel: "Ü 2: Verlust, Preis und unerreichbarer BEP", herkunft: "original", vorlage: "Übung 08 KLR, Aufg. 2", minuten: 20, art: "rechnen", quelle: "1.5")[
#if not web [*Aufgabe 43* #linebreak()]
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
*Gewinnschwelle:* $x_"BEP"=30 000/(21-15)=5000$ Stück. Grafisch schneiden sich $E=21x$ und $K=30 000+15x$ bei 5 000 Stück und 105 000 €. Die Kostenlinie ist außerhalb der Kapazität nur rechnerisch fortgesetzt.
#bild("bep-ausserhalb", [Eigene Darstellung nach Ü 2, PDF-S. 2.], height: 55mm)
][
*Kapazität:* *$G(4500)=6 dot 4500-30 000=-3000$ €*. Mit den vorhandenen Zahlen ist Gewinn nicht möglich. Preis/Kosten ändern oder eine Kapazitätsänderung einschließlich neuer Kosten untersuchen.
][
*Einzelne Änderungen zur Kostendeckung bei 4 500:* Nötiger Stück-DB $30 000/4500=20/3$ €/Stück. Bei unverändertem $k_v=15$ ist $e>=65/3 approx "21,6667"$ €/Stück nötig; auf Cent *mindestens 21,67 €*. Bei unverändertem $e=21$ ist $k_v<=43/3 approx "14,3333"$ €/Stück nötig, auf Cent *höchstens 14,33 €*. Bei unverändertem Stück-DB von 6 € dürfen *$K_f<=27 000$ €* sein.
][
*Prüfung:* Mit 21,67 € erzielt der Betrieb bei 4 500 Stück +15 €; die Cent-Rundung liegt auf der kostendeckenden Seite. Die Änderungen sind drei getrennte Möglichkeiten. Quelle: Ü 2, PDF-S. 2; Foto Ü 2; d) eigene Ableitung wie L15, PDF-S. 10.
]

#aufgabe(titel: "Gewinnschwelle berechnen", herkunft: "variante", vorlage: "Übung 08 KLR, Aufg. 1", minuten: 6, art: "rechnen", quelle: "1.5",
  ergebnis: [$x_"BEP" = 2000$ Stück/Monat],
  tipp: [Wie viel bleibt pro Stück übrig, um die Fixkosten zu bezahlen?],
)[
#if not web [*Aufgabe 44* #linebreak()]
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

#aufgabe(titel: "Alte Ü 1: BEP und Beschäftigungsgrad", herkunft: "variante", vorlage: "Übung 08 KLR, Aufg. 4", minuten: 6, art: "rechnen", quelle: "1.5")[
#if not web [*Aufgabe 45* #linebreak()]
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

#aufgabe(titel: "A13: Kunststoffbehälter (Variante)", art: "rechnen", quelle: "1.5", herkunft: "variante", vorlage: "Altklausur SS 13, Aufg. 4", minuten: 10,
  ergebnis: [BEP 8 000 Stück, BEP-Umsatz 1,2 Mio. €; bei 10 000 Stück $G=+150 000$ €, Umsatzrendite 10 %.])[
#if not web [*Aufgabe 46* #linebreak()]
*Gegeben und Annahmen*

Ein Einproduktbetrieb stellt Gartenbänke her: Preis 150 €/Stück, Fertigungsmaterial 45 €/Stück, Fertigungslohn 30 €/Stück, jährliche Fixkosten 600 000 €. Vollständiger Absatz.

*Gesucht*

#enum(numbering: "a)",
[Break-Even-Menge und jährlicher Break-Even-Umsatz,],
[Betriebsergebnis bei 10 000 Stück,],
[Umsatzrentabilität bei 10 000 Stück.],
)
][
*Stück-DB:* $k_v=45+30=75$ €, $d b_"I"=150-75=75$ €/Stück.
][
*a):* $x_"BEP"=600 000/75=8000$ Stück; $E_"BEP"=150 dot 8000=1 200 000$ €.
][
*b):* $G=75 dot 10 000-600 000=+150 000$ €.
][
*c):* $150 000/1 500 000 dot 100 %=10 %$. Prüfe: 2 000 Stück über dem BEP mal 75 € = 150 000 € ✓.
]

#aufgabe(titel: "Wo das Gewinnmaximum liegt", herkunft: "eigen", art: "verstehen", quelle: "1.5.1")[
#if not web [*Aufgabe 47* #linebreak()]
*Gewinnmaximum:* Unter welchen Voraussetzungen liegt es an der Kapazität? Was ändert sich bei negativem Stück-DB oder fehlender Nachfrage? (K, PDF-S. 1; L15, PDF-S. 6; eigene Präzisierung.)
][
*Maximum:* Bei positivem, konstantem Stück-DB und unveränderten Fixkosten wächst $G$ linear mit der verkauften Menge. Volle Kapazität ist nur dann das Maximum, wenn sie abgesetzt werden kann. Bei negativem DB verschlechtert mehr Menge das Ergebnis; geringere Nachfrage begrenzt den Absatz früher.
][
*Ergänzung:* Bei unbegrenzter Nachfrage liegt das Maximum an der *Kapazitätsgrenze* – weil jedes Stück den Gewinn um $d b_"I"$ erhöht. Nicht an der Gewinnschwelle (dort $G=0$) und nicht bei einer beliebigen Auslastung. Die Stückkosten sind dort zwar am niedrigsten, das Argument ist aber der Deckungsbeitrag.

*Merksatz:* Ein positiver Stückbeitrag hilft nur bei verkäuflicher Menge.
]

#aufgabe(titel: "Wie sich der BEP verschiebt", herkunft: "eigen", art: "verstehen", quelle: "1.5.1")[
#if not web [*Aufgabe 48* #linebreak()]
*Veränderungen:* Wie wirken höhere Fixkosten, höhere variable Stückkosten, höhere bzw. niedrigere Verkaufspreise auf den BEP? Begründe jeweils über den Stück-DB. (L15, PDF-S. 7, aus Ü abgeleitet.)
][
*BEP-Wirkung:* Höhere $K_f$: mehr Beiträge erforderlich, BEP steigt. Höhere $k_v$: weniger Beitrag je Stück, BEP steigt. Höheres $e$: mehr Beitrag, BEP sinkt. Niedrigeres $e$: weniger Beitrag, BEP steigt. Das gilt bei sonst gleichen Werten und weiterhin positivem Stück-DB.
][
*Ergänzung · typische Fehler:* Steigen die variablen Stückkosten, *steigt* der BEP, weil der Stück-DB kleiner wird. Falsch wären „sinkt“ (Richtung vertauscht), „bleibt gleich, nur $K_f$ zählt“ (der BEP hängt auch vom Stück-DB ab) und „wird negativ“ (bei DB ≤ 0 gibt es nur keine erreichbare Schwelle mehr). Alles läuft über $x_"BEP"=K_f/d b_"I"$.
]

#aufgabe(titel: "Beschäftigungsgrad an der Gewinnschwelle", herkunft: "variante", vorlage: "Übung 08 KLR, Aufg. 4", minuten: 4, art: "rechnen", quelle: "1.5.1",
  ergebnis: [$"BG" = 75 %$],
)[
#if not web [*Aufgabe 49* #linebreak()]
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

#aufgabe(titel: "A14 I.2–3: Relativer DB und Engpassprogramm", art: "rechnen", quelle: "1.6", herkunft: "original", vorlage: "Altklausur WS 14/15, Aufg. I.2–3", minuten: 22,
  ergebnis: [Rel. DB: C 46, B 38, E 32,5, D 29,5, A 20 €/h; Programm C, B, 415 h E; DB 34 437,50 €, Ergebnis −11 055,50 €.])[
#if not web [*Aufgabe 50* #linebreak()]
*Gegeben und Annahmen*

Ein Industriebetrieb fertigt fünf Produkte. Werte des vergangenen Monats:
#tab(columns: (1fr, 1.5fr, 1.5fr),
 th([Produkt], [Herstellungszeit h], [Deckungsbeitrag $D B_"I"$ €]),
 [A], [210], [4 200],
 [B], [170], [6 460],
 [C], [315], [14 490],
 [D], [224], [6 608],
 [E], [618], [20 085],
)
Das Betriebsergebnis betrug 6 350 €; die monatlichen Fixkosten sind daraus 45 493 € (Teil I.1). Wegen eines Anlagenausfalls sinkt die Kapazität auf 900 Stunden je Monat. Annahmen: Fixkosten unverändert, Produkte beliebig teilbar, Absatz je Produkt höchstens wie im Vormonat, DB je Stunde konstant.

*Gesucht*

#enum(numbering: "a)",
[Ermittle den relativen DB je Stunde und eine Rangfolge.],
[Ermittle das optimale Produktionsprogramm für 900 Stunden und dessen Betriebsergebnis.],
)
][
*Warum je Stunde?* Wenn die Stunden knapp sind, zählt nicht, was ein Produkt insgesamt bringt, sondern was es *je verbrauchter Engpassstunde* bringt.
][
*a) Relativer DB:* A $4200/210=20$, B $6460/170=38$, C $14 490/315=46$, D $6608/224="29,5"$, E $20 085/618="32,5"$ €/h. Rang: *C, B, E, D, A*.
][
*b) Stunden verteilen:* C 315 h (Rest 585), B 170 h (Rest 415), E nur noch 415 von 618 h. D und A entfallen. Vorher wurden 1 537 h benötigt.
][
*Ergebnis:* DB $=14 490+6460+415 dot "32,5"=14 490+6460+13 487,5=34 437,50$ €. Betriebsergebnis $34 437,50-45 493=-11 055,50$ €.
][
*Einordnen:* Trotz optimalem Programm entsteht Verlust, weil die Fixkosten bleiben. Jede andere Verteilung wäre schlechter, z. B. E vor C. Prüfe: $315+170+415=900$ h ✓.
]

#aufgabe(titel: "A14 I.2–3: Engpassprogramm (Variante)", art: "rechnen", quelle: "1.6", herkunft: "variante", vorlage: "Altklausur WS 14/15, Aufg. I.2–3", minuten: 18,
  ergebnis: [Rang B 40, D 32, A 30, C 25 €/h; Programm B, D, 50 h A; DB 21 100 €; Ergebnis +1 100 €.])[
#if not web [*Aufgabe 51* #linebreak()]
*Gegeben und Annahmen*

#tab(columns: (1fr, 1.5fr, 1.5fr),
 th([Produkt], [Fertigungszeit h/Monat], [$D B_"I"$ €/Monat]),
 [A], [100], [3 000],
 [B], [250], [10 000],
 [C], [160], [4 000],
 [D], [300], [9 600],
)
Fixkosten 20 000 €/Monat. Die Kapazität sinkt von 810 auf 600 Stunden. Produkte teilbar, Absatz höchstens wie bisher, DB je Stunde konstant.

*Gesucht*

#enum(numbering: "a)",
[Bisheriges Betriebsergebnis,],
[Rangfolge nach relativem DB,],
[optimales Programm für 600 h und neues Betriebsergebnis.],
)
][
*a):* $26 600-20 000=+6 600$ €.
][
*b):* A 30, B 40, C 25, D 32 €/h → *B, D, A, C*.
][
*c):* B 250 h, D 300 h, A 50 h (= 600 h). DB $10 000+9 600+50 dot 30=21 100$ €; Ergebnis $+1 100$ €. Typischer Fehler: nach absolutem DB sortieren (B, D, C, A) – dann bekäme C Stunden, die bei A mehr bringen.
]

#aufgabe(titel: "Fehler bei der allgemeinen Preissenkung", art: "verstehen", quelle: "1.6.1", herkunft: "eigen")[
#if not web [*Aufgabe 52* #linebreak()]
Ein Betrieb senkt den Preis für *alle* Kunden, um mehr zu verkaufen. Welcher Fehler passiert dabei oft, und wie vergleichst Du richtig?
][
*Typischer Fehler:* Nur die zusätzliche Menge zum neuen Preis rechnen und vergessen, dass auch alle bisherigen Kunden weniger zahlen. Man verliert Deckungsbeitrag auf der alten Menge, und die Zusatzmenge muss das erst ausgleichen.

*Richtig:* Gesamtgewinn vorher gegen Gesamtgewinn nachher, mit Kapazität und Nachfrage als Grenze. Nicht der Bruttopreis oder doppelte Fixkosten sind hier das Problem, sondern der Preis der alten Menge.

*Merksatz:* Eine allgemeine Preissenkung trifft auch die bisherigen Stücke.
]

#aufgabe(titel: "Alte Ü 5: Preissenkung", herkunft: "variante", vorlage: "Übung 08 KLR, Aufg. 1", minuten: 8, art: "rechnen", quelle: "1.6.1")[
#if not web [*Aufgabe 53* #linebreak()]
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

#aufgabe(titel: "Bedingungen für einen Zusatzauftrag", herkunft: "eigen", art: "verstehen", quelle: "1.6.2")[
#if not web [*Aufgabe 54* #linebreak()]
*Zusatzauftrag:* Welche Bedingungen brauchst Du für $Delta G=(e_"Z"-k_v)x_"Z"$? Nenne das Kundenrisiko und erkläre, warum nicht nochmals alle Fixkosten abgezogen werden. (Ü 1, PDF-S. 1.)
][
*Zusatzauftrag:* Freie Kapazität, keine Verdrängung, unveränderte Fixkosten und keine unberücksichtigten Zusatzkosten; der bisherige Verkaufspreis bleibt bestehen. $K_f$ fällt in beiden Alternativen ohnehin an und hebt sich im Differenzvergleich auf. Risiko: Bisherige Kunden fordern den niedrigeren Preis; außerdem ist Kapazität gebunden.
][
*Ergänzung · Zahlenbeispiel:* 200 Packungen zu 35 € bei $k_v=30$ €: $Delta G=(35-30) dot 200=+1000$ €. Falsch wären „sinkt, weil 35 € unter den Stückkosten liegen“ (Fixkosten sind ohnehin da), „+7 000 €“ (das ist nur der Erlös) und „bleibt gleich“. *Risiken:* Stammkunden fordern ebenfalls 35 € – bei 35 € für alle 1 000 Packungen wären es −15 000 €; außerdem bindet der Auftrag Kapazität, die für besser bezahlte Aufträge fehlen könnte. Nicht automatisch steigen dagegen die Fixkosten, und der DB der Stammkunden bleibt, solange sie den alten Preis zahlen.

*Merksatz:* Zusatzauftrag: zusätzliche Erlöse minus zusätzliche Kosten.
]

#aufgabe(titel: "Zusatzauftrag bei bestehendem Verlust", art: "verstehen", quelle: "1.6.2", herkunft: "eigen")[
#if not web [*Aufgabe 55* #linebreak()]
Muss ein Betrieb seine Fixkosten schon gedeckt haben, damit ein Zusatzauftrag sinnvoll ist?
][
*Nein:* Jeder positive zusätzliche Deckungsbeitrag $(e_"Z"-k_v)x_"Z"$ verbessert das Ergebnis – auch wenn er nur einen bestehenden Verlust verkleinert. Die Fixkosten fallen ohnehin an.
]

#aufgabe(titel: "Alte Ü 3: Zusatzauftrag", herkunft: "variante", vorlage: "Übung 08 KLR, Aufg. 1", minuten: 8, art: "rechnen", quelle: "1.6.2")[
#if not web [*Aufgabe 56* #linebreak()]
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

#aufgabe(titel: "Kurz- und langfristige Preisuntergrenze", herkunft: "eigen", art: "verstehen", quelle: "1.6.3")[
#if not web [*Aufgabe 57* #linebreak()]
*Preisuntergrenzen:* Weshalb unterscheiden sich die kurz- und langfristige Grenze im einfachen Modell? Bedeutet $e_"Z"=k_v$ bereits einen zusätzlichen Gewinn? (Ergänzung aus L15, PDF-S. 8.)
][
*Preisgrenzen:* Kurzfristig sind bei den genannten Bedingungen nur die durch den Auftrag entstehenden Kosten zu decken. Bei $e_"Z"=k_v$ ist $Delta G=0$, kein zusätzlicher Gewinn. Langfristig muss die geplante Menge auch $K_f$ decken; im einfachen Modell daher $e>=k(x)$.
][
*Merksatz:* Kurzfristig (freie Kapazität, Fixkosten unverändert) liegt die Preisuntergrenze bei den *variablen* Stückkosten $e>=k_v$, langfristig bei den *gesamten* Stückkosten $e>=k$. Kurzfristig variabel decken, langfristig alle Kosten.
]

#aufgabe(titel: "Wiederholung 3: Preisuntergrenzen und Zusatzauftrag", art: "rechnen", quelle: "1.6.3", herkunft: "original", vorlage: "Wiederholungsblatt KLR/DBR, Aufg. 3", minuten: 10,
  ergebnis: [$k_v=40$ €, $d b_"I"=36$ €; PUG kurzfristig 40 €, langfristig 70 €; BEP 10 000 Stück; Zusatzauftrag +15 000 € → annehmen (bei freier Kapazität).])[
#if not web [*Aufgabe 58* #linebreak()]
*Gegeben und Annahmen*

Ein Ein-Produkt-Unternehmen produziert und verkauft in einer Periode 12 000 Stück. $K_f=360 000$ €, $K_v=480 000$ € je Periode. Marktpreis 76,00 €/Stück. Für den Zusatzauftrag gelte: freie Kapazität vorhanden, keine zusätzlichen Fixkosten, der bisherige Preis bleibt bestehen.

*Gesucht*

#enum(numbering: "a)",
[$d b_"I"$,],
[kurzfristige und langfristige Preisuntergrenze,],
[BEP,],
[Soll ein Zusatzauftrag über 1 000 Stück zu 55,00 €/Stück angenommen werden?],
)
][
*Stückwerte:* $k_v=480 000/12 000=40$ €/Stück; $d b_"I"=76-40=36$ €/Stück.
][
*Preisuntergrenzen:* Kurzfristig muss ein Preis nur die zusätzlich entstehenden Kosten decken: *40 €* (= $k_v$). Langfristig müssen auch die Fixkosten verdient werden: $k=(360 000+480 000)/12 000=70$ €/Stück.
][
*BEP:* $360 000/36=10 000$ Stück. Bei 12 000 Stück liegt der Betrieb 2 000 Stück darüber; $G=36 dot 12 000-360 000=+72 000$ €.
][
*Zusatzauftrag:* $Delta G=(55-40) dot 1000=+15 000$ €. 55 € liegen unter den Vollkosten 70 €, aber über der kurzfristigen PUG. *Annehmen*, sofern Kapazität frei ist und Stammkunden nicht ebenfalls 55 € verlangen.
]

#aufgabe(titel: "Wiederholung 3: Preisuntergrenzen (Variante)", art: "rechnen", quelle: "1.6.3", herkunft: "variante", vorlage: "Wiederholungsblatt KLR/DBR, Aufg. 3", minuten: 10,
  ergebnis: [$k_v=40$ €; PUG 40 € / 70 €; BEP 5 333,33 → 5 334 Stück; Zusatzauftrag −1 000 € → ablehnen.])[
#if not web [*Aufgabe 59* #linebreak()]
*Gegeben und Annahmen*

8 000 Stück je Periode, $K_f=240 000$ €, $K_v=320 000$ €, Preis 85 €/Stück. Ein Kunde bietet einmalig 500 Stück zu 38 €/Stück; Kapazität ist frei, keine weiteren Kosten.

*Gesucht*

#enum(numbering: "a)",
[$k_v$, $d b_"I"$, kurz- und langfristige PUG,],
[BEP (exakt und ganzzahlig),],
[Entscheidung über den Zusatzauftrag.],
)
][
*Stückwerte:* $k_v=40$ €, $d b_"I"=45$ €. PUG kurzfristig 40 €, langfristig $560 000/8000=70$ €.
][
*BEP:* $240 000/45 approx "5 333,33"$ → kleinste ganze Menge ohne Verlust *5 334 Stück*.
][
*Zusatzauftrag:* $Delta G=(38-40) dot 500=-1000$ €. Der Preis liegt *unter* der kurzfristigen PUG: Jedes Stück kostet mehr, als es bringt. *Ablehnen.*
]

#aufgabe(titel: "Wiederholung 4: Eigenfertigung oder Fremdbezug", art: "rechnen", quelle: "1.6.3", herkunft: "original", vorlage: "Wiederholungsblatt KLR/DBR, Aufg. 4", minuten: 8,
  ergebnis: [Kurzfristig Eigenfertigung: 64 € < 75 €, Ersparnis 22 000 €.])[
#if not web [*Aufgabe 60* #linebreak()]
*Gegeben und Annahmen*

Ein Industriebetrieb kann ein Erzeugnis auf Maschine A selbst herstellen oder beim Lieferanten kaufen.
#tab(columns: (2fr, 1fr),
 th([Daten], []),
 [Benötigte Menge], [2 000 Stück],
 [Freie Kapazität der Maschine A], [2 300 Stück],
 [$k_v$], [64,00 €/Stück],
 [$k_f$ (verrechnete Fixkosten je Stück)], [28,00 €/Stück],
 [Einstandspreis beim Lieferanten], [75,00 €/Stück],
)
Die Fixkosten der Maschine fallen in beiden Fällen an.

*Gesucht*

#enum(numbering: "a)",
[Ist Eigenfertigung oder Fremdbezug günstiger? Begründe.],
)
][
*Kapazität prüfen:* 2 000 benötigt, 2 300 frei → Eigenfertigung möglich.
][
*Relevante Kosten:* Die Fixkosten fallen ohnehin an und ändern sich durch die Entscheidung nicht. Vergleiche daher nur $k_v=64$ € mit dem Einstandspreis 75 €.
][
*Entscheidung:* Eigenfertigung spart $(75-64) dot 2000=22 000$ €. *Typische Verwechslung:* Vollkosten $64+28=92$ € > 75 € würden zum Fremdbezug verleiten; dann bliebe die Maschine aber leer stehen und ihre Fixkosten fielen trotzdem an. Langfristig (Fixkosten abbaubar) wäre neu zu rechnen.
]

#aufgabe(titel: "Wiederholung 4: Eigenfertigung oder Fremdbezug (Variante)", art: "rechnen", quelle: "1.6.3", herkunft: "variante", vorlage: "Wiederholungsblatt KLR/DBR, Aufg. 4", minuten: 8,
  ergebnis: [1 200 Stück selbst, 300 Stück kaufen: 77 400 € statt 87 000 € bei reinem Fremdbezug.])[
#if not web [*Aufgabe 61* #linebreak()]
*Gegeben und Annahmen*

Benötigt werden 1 500 Stück; die eigene Maschine hat nur 1 200 Stück freie Kapazität. $k_v=50$ €/Stück, verrechnete $k_f=20$ €/Stück (Fixkosten fallen ohnehin an), Einstandspreis 58 €/Stück. Zusätzliche Kapazität ist kurzfristig nicht verfügbar.

*Gesucht*

#enum(numbering: "a)",
[Wie viel sollte selbst gefertigt, wie viel gekauft werden?],
[Vergleiche die entscheidungsrelevanten Kosten mit reinem Fremdbezug.],
)
][
*Vergleich je Stück:* 50 € (variabel, eigen) < 58 € (Kauf) → so viel wie möglich selbst fertigen.
][
*Aufteilung:* 1 200 selbst, die fehlenden 300 kaufen.
][
*Kosten:* $1200 dot 50+300 dot 58=77 400$ € gegenüber $1500 dot 58=87 000$ €. Ersparnis 9 600 € $=(58-50) dot 1200$.
]

#aufgabe(titel: "Differenzenansatz für zwei Perioden", herkunft: "eigen", art: "verstehen", quelle: "1.7")[
#if not web [*Aufgabe 62* #linebreak()]
*Zwei Perioden:* Erkläre den Differenzenansatz für $k_v$. Welche Voraussetzungen und welche Gegenprobe sind nötig? (Ü 3, PDF-S. 2.)
][
*Zwei Perioden:* $(Delta K)/(Delta x)$ ist die Steigung der angenommenen gemeinsamen Kostenlinie. Vorausgesetzt sind derselbe Zeitraum, dasselbe $K_f$ und $k_v$ sowie verschiedene Mengen. Mit $K_f=K-k_v x$ müssen beide Perioden denselben festen Anteil liefern.
][
*Ergänzung · warum dasselbe $K_f$:* Man nimmt an, dass beide Beobachtungen auf *derselben* Kostenlinie liegen. Die Steigung wird gerade aus den zwei Punkten bestimmt, also liefern beide denselben Achsenabschnitt; kommt etwas anderes heraus, ist verrechnet. Zwei Punkte beweisen aber nicht, dass das Modell in jedem anderen Monat gilt.

*Bild:* Stromrechnung bei 300 und 400 kWh: Die Differenz zeigt den Preis pro kWh, der Rest ist die Grundgebühr.
]

#aufgabe(titel: "Zwei Perioden: typische Rechenfehler", art: "verstehen", quelle: "1.7", herkunft: "eigen")[
#if not web [*Aufgabe 63* #linebreak()]
Im Oktober kosten 20 000 Stück 700 000 €, im November 24 000 Stück 800 000 €. a) Wie hoch sind die variablen Stückkosten? b) Wie hoch sind die Fixkosten? Erkläre jeweils, warum 35 €, 33,33 € bzw. 500 000 € und 100 000 € falsch sind.
][
*a):* $k_v=(800 000-700 000)/(24 000-20 000)=25$ €/Stück. Falsch: 35 € und 33,33 € sind die *gesamten* Stückkosten eines Monats (Fixkosten noch enthalten); 100 000 € ist nur die Kostendifferenz, noch nicht durch die Mengendifferenz geteilt.
][
*b):* $K_f=700 000-25 dot 20 000=200 000$ €; November liefert denselben Wert. Falsch: 500 000 € sind die variablen Kosten im Oktober, 100 000 € die Kostendifferenz; 0 € würde gleiche Stückkosten in beiden Monaten verlangen.
]

#aufgabe(titel: "Ü 3: Zwei Perioden und Erweiterung", herkunft: "original", vorlage: "Übung 08 KLR, Aufg. 3", minuten: 25, art: "rechnen", quelle: "1.7")[
#if not web [*Aufgabe 64* #linebreak()]
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

#aufgabe(titel: "Alte Ü 2: Zwei Perioden", herkunft: "variante", vorlage: "Übung 08 KLR, Aufg. 3", minuten: 6, art: "rechnen", quelle: "1.7")[
#if not web [*Aufgabe 65* #linebreak()]
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

#aufgabe(titel: "Alte Ü 8: Zwei Monate", herkunft: "variante", vorlage: "Übung 08 KLR, Aufg. 3", minuten: 12, art: "rechnen", quelle: "1.7")[
#if not web [*Aufgabe 66* #linebreak()]
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

#aufgabe(titel: "Kostenfunktion aus zwei Monaten", herkunft: "variante", vorlage: "Altklausur SS 13, Aufg. 3", minuten: 8, art: "rechnen", quelle: "1.7",
  ergebnis: [$k_v = 20$ €/Stück, $K_f = 100 000$ €],
  tipp: [Die Fixkosten sind in beiden Monaten gleich. Der Kostenunterschied kann also nur von den zusätzlichen Stücken kommen.],
)[
#if not web [*Aufgabe 67* #linebreak()]
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

#aufgabe(titel: "Zielgewinn: wie viele Packungen?", art: "verstehen", quelle: "1.8", herkunft: "eigen")[
#if not web [*Aufgabe 68* #linebreak()]
Fixkosten 20 000 €, Stückdeckungsbeitrag 40 €. Wie viele Packungen brauchst Du für 8 000 € Zielgewinn? Was haben 200, 500 und 300 Packungen falsch gemacht?
][
*Antwort:* $x_"Ziel"=(K_f+G_"Ziel")/d b_"I"=28 000/40=700$ Packungen; danach Kapazität und Absatz prüfen.

*Typische Verwechslungen:* 200 deckt nur den Zielgewinn, 500 ist der BEP (Zielgewinn null), 300 hat den Zielgewinn abgezogen statt addiert.
]

#aufgabe(titel: "Alte Ü 4: Preis aus dem Verlust", herkunft: "variante", vorlage: "Übung 08 KLR, Aufg. 2", minuten: 10, art: "rechnen", quelle: "1.8")[
#if not web [*Aufgabe 69* #linebreak()]
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

#aufgabe(titel: "Alte Ü 6: Zielgewinn", herkunft: "variante", vorlage: "Übung 08 KLR, Aufg. 3", minuten: 5, art: "rechnen", quelle: "1.8")[
#if not web [*Aufgabe 70* #linebreak()]
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

#aufgabe(titel: "BEP oberhalb der Kapazität", herkunft: "eigen", art: "verstehen", quelle: "1.8.1")[
#if not web [*Aufgabe 71* #linebreak()]
*Unerreichbare Schwelle:* Was bedeutet BEP > Kapazität? Nenne Stellschrauben und den Haken einer Erweiterung. (Ü 2, PDF-S. 2.)
][
*BEP über Kapazität:* Bei positivem Stück-DB reicht selbst Vollauslastung nicht zur Kostendeckung. Preis erhöhen, variable Kosten oder Fixkosten senken kann die Schwelle senken. Erweiterung erhöht die mögliche Menge, kann aber auch neue Fixkosten erzeugen; beide Wirkungen zusammen prüfen.
][
*Ergänzung · Ü 2:* Schwelle 5 000 Stück, Kapazität 4 500. Stellschrauben: Preis erhöhen, variable Stückkosten senken, Fixkosten senken (jeweils größerer Stück-DB bzw. weniger zu deckende Kosten). *Keine* Lösung: einfach mehr als 4 500 Stück produzieren ohne etwas zu ändern – die Kapazität ist die Grenze, und eine Erweiterung kann neue Fixkosten bringen.
]

#aufgabe(titel: "Von der KLR zur Investitionsrechnung", herkunft: "eigen", art: "verstehen", quelle: "1.8.2")[
#if not web [*Aufgabe 72* #linebreak()]
*Zusammenhang:* Wie helfen Kostenfunktion und DB beim späteren Beurteilen einer neuen Maschine? Beschreibe nur die Verbindung zur bisherigen Basis. (Gliederung, PDF-S. 1; L15, PDF-S. 1 und 13.)
][
*Verbindung:* Eine neue Maschine kann den festen Kostenblock, die variablen Stückkosten und die mögliche Menge verändern. Die KLR macht diese Folgen vergleichbar. Die Gliederung baut darauf später Kosten-, Gewinn-, Rentabilitäts- und Amortisationsrechnung auf; deren zusätzliche Regeln jetzt in Kapitel 2 erklärt werden.
]

#aufgabe(titel: "Fahrplan für KLR-Textaufgaben", art: "verstehen", quelle: "1.8.2", herkunft: "eigen")[
#if not web [*Aufgabe 73* #linebreak()]
Beschreibe einen Fahrplan, mit dem Du jede KLR-Textaufgabe angehst.
][
*Schritte:* 1. *Basis:* Netto? Gleiche Periode? 2. *Modell:* Was ist fix, was variabel? Kommen neue Kosten dazu? 3. *Ansatz:* Kosten, Erlöse und DB trennen, nach der gesuchten Größe umstellen. 4. *Machbarkeit:* Passt die Menge in Kapazität und Nachfrage? 5. *Prüfung:* Einheiten, Vorzeichen, Rundung. 6. *Entscheidung:* begründetes Ja oder Nein mit Bedingungen.
]

#aufgabe(titel: "Vorzeichen beim Ergebnis", art: "verstehen", quelle: "1.8.2", herkunft: "eigen")[
#if not web [*Aufgabe 74* #linebreak()]
Warum solltest Du ein Ergebnis immer mit Vorzeichen schreiben?
][
*Klarheit:* Dann ist sofort erkennbar, ob ein Gewinn oder Verlust vorliegt, z. B. $G=+4000$ € oder $G=-3000$ €. Beim Rückwärtsrechnen (z. B. $E=G+K$ oder $K_f=D B-G$) setzt Du einen Verlust so automatisch richtig negativ ein.
]

#aufgabe(titel: "A14 III: Betriebsabrechnungsbogen", art: "rechnen", quelle: "1.8.2", herkunft: "original", vorlage: "Altklausur WS 14/15, Aufg. III", minuten: 30,
  ergebnis: [Verrechnungssätze 280 €/tkm und 4,50 €/Mahlzeit; GK Material 169 950, Fertigung 1 959 195, Verwaltung 571 937,40, Vertrieb 419 420,76 €; Zuschläge 10,3 % / 198,5 % / 12,0 % / 8,8 %; Betriebsergebnis 392 496,84 €.])[
#if not web [*Aufgabe 75* #linebreak()]
*Gegeben und Annahmen*

Gemeinkostensummen im BAB eines Industriebetriebs (in €):
#tab(columns: (1fr, 1fr, 1fr, 1.2fr, 1fr, 1fr),
 th([Fuhrpark], [Kantine], [Material], [Fertigung], [Verwaltung], [Vertrieb]),
 [303 800,00], [13 880,00], [131 300,00], [1 864 055,00], [530 637,40], [276 830,76],
)
Fuhrpark und Kantine sind Hilfskostenstellen; sie werden nach erbrachten Leistungen umgelegt:
#tab(columns: (1.5fr, 1fr, 1fr),
 th([Empfänger], [Fuhrpark tkm], [Kantine Mahlzeiten]),
 [Kantine], [34], [–],
 [Material], [130], [500],
 [Fertigung], [298], [2 600],
 [Verwaltung], [125], [1 400],
 [Vertrieb], [498], [700],
)
Materialeinzelkosten 1 650 000 €, Fertigungseinzelkosten 987 000 €, Umsatzerlöse 6 150 000 €. Keine Bestandsveränderungen. Zuschlagsbasis für Verwaltung und Vertrieb sind die Herstellkosten.

*Gesucht*

#enum(numbering: "a)",
[Führe die Umlage der Hilfskostenstellen durch und ermittle die Gemeinkostensummen der Hauptkostenstellen.],
[Berechne die Zuschlagssätze (auf eine Nachkommastelle).],
[Ermittle Herstellkosten, Selbstkosten und Betriebsergebnis.],
)
][
*Reihenfolge wählen:* Der Fuhrpark beliefert auch die Kantine, die Kantine aber nicht den Fuhrpark. Deshalb zuerst den Fuhrpark umlegen, dann die Kantine samt ihrem Fuhrparkanteil (Stufenleiterverfahren). Sonst ginge ein Teil der Fuhrparkkosten verloren.
][
*Fuhrpark:* $1085$ tkm insgesamt; Satz $303 800/1085=280$ €/tkm. Kantine erhält $34 dot 280=9520$ €, Material 36 400, Fertigung 83 440, Verwaltung 35 000, Vertrieb 139 440 €.
][
*Kantine:* $(13 880+9520)/5200=23 400/5200="4,50"$ €/Mahlzeit. Material 2 250, Fertigung 11 700, Verwaltung 6 300, Vertrieb 3 150 €. *Typischer Fehler:* $13 880/5200 approx "2,67"$ ohne den Fuhrparkanteil.
][
*a) Hauptstellen:* Material $131 300+36 400+2250=169 950$ €; Fertigung $1 864 055+83 440+11 700=1 959 195$ €; Verwaltung $530 637,40+35 000+6300=571 937,40$ €; Vertrieb $276 830,76+139 440+3150=419 420,76$ €. Summe 3 120 503,16 € = alle Gemeinkosten ✓.
][
*b) Zuschläge:* MGK $169 950/1 650 000 approx "10,3" %$; FGK $1 959 195/987 000 approx "198,5" %$. Herstellkosten $1 650 000+169 950+987 000+1 959 195=4 766 145$ €. VwGK $571 937,40/4 766 145 approx "12,0" %$; VtGK $419 420,76/4 766 145 approx "8,8" %$.
][
*c) Ergebnis:* Selbstkosten $4 766 145+571 937,40+419 420,76=5 757 503,16$ €. Betriebsergebnis $6 150 000-5 757 503,16=+392 496,84$ €.
]

#aufgabe(titel: "A14 III: Betriebsabrechnungsbogen (Variante)", art: "rechnen", quelle: "1.8.2", herkunft: "variante", vorlage: "Altklausur WS 14/15, Aufg. III", minuten: 25,
  ergebnis: [3 €/kWh, 67,50 €/h; GK 72 375 / 457 250 / 99 350 / 75 025 €; Zuschläge 14,5 % / 152,4 % / 7,5 % / 5,6 %; Betriebsergebnis +96 000 €.])[
#if not web [*Aufgabe 76* #linebreak()]
*Gegeben und Annahmen*

Primäre Gemeinkosten in €: Energie 48 000, Reparatur 21 000 (Hilfsstellen); Material 60 000, Fertigung 410 000, Verwaltung 95 000, Vertrieb 70 000.
#tab(columns: (1.5fr, 1fr, 1fr),
 th([Empfänger], [Energie kWh], [Reparatur h]),
 [Reparatur], [2 000], [–],
 [Material], [3 000], [50],
 [Fertigung], [9 000], [300],
 [Verwaltung], [1 000], [20],
 [Vertrieb], [1 000], [30],
)
Materialeinzelkosten 500 000 €, Fertigungseinzelkosten 300 000 €, Umsatzerlöse 1 600 000 €; keine Bestandsveränderungen. Verwaltung und Vertrieb auf Basis der Herstellkosten.

*Gesucht*

#enum(numbering: "a)",
[Umlage der Hilfsstellen (Stufenleiterverfahren) und Gemeinkosten der Hauptstellen,],
[Zuschlagssätze (eine Nachkommastelle),],
[Selbstkosten und Betriebsergebnis.],
)
][
*Energie zuerst* (beliefert Reparatur): $48 000/16 000=3$ €/kWh. Reparatur erhält 6 000 €.
][
*Reparatur:* $(21 000+6000)/400="67,50"$ €/h.
][
*a):* Material $60 000+9000+3375=72 375$; Fertigung $410 000+27 000+20 250=457 250$; Verwaltung $95 000+3000+1350=99 350$; Vertrieb $70 000+3000+2025=75 025$ €. Summe 704 000 € ✓.
][
*b):* MGK $72 375/500 000 approx "14,5" %$; FGK $457 250/300 000 approx "152,4" %$; HK $=1 329 625$ €; VwGK $approx "7,5" %$; VtGK $approx "5,6" %$.
][
*c):* Selbstkosten $1 329 625+99 350+75 025=1 504 000$ €; Betriebsergebnis $+96 000$ €.
]

#aufgabe(titel: "A18 IV: Teilkosten-BAB im Anbauverfahren", art: "rechnen", quelle: "1.8.2", herkunft: "original", vorlage: "Altklausur WS 18/19, Aufg. IV (BAB)", minuten: 20,
  ergebnis: [4,40 €/m³, 876 €/t; var. GK 205 880,20 / 4 572 760,10 / 566 468,40 / 1 036 925,20 €; Zuschläge 8,5 % / 190,5 % / 5,9 % / 10,8 %; var. HK 9 601 159,30 €, var. SK 11 204 552,90 €; Betriebsergebnis +400 447,10 €.])[
#if not web [*Aufgabe 77* #linebreak()]
*Gegeben und Annahmen*

Teilkosten-BAB eines Chemiebetriebs, Gemeinkostensummen in €:
#tab(columns: (1.6fr, 1fr, 1fr),
 th([Kostenstelle], [variabel], [fix]),
 [Kläranlage (Hilfsstelle)], [256 740,00], [1 221 000,00],
 [Müllverbrennung (Hilfsstelle)], [700 800,00], [1 855 000,00],
 [Material], [14 624,20], [1 274 000,00],
 [Fertigung], [4 117 412,10], [4 825 000,00],
 [Verwaltung], [282 636,40], [1 228 000,00],
 [Vertrieb], [1 009 821,20], [817 000,00],
)
Umlage Kläranlage nach Abwasser (m³): Material 10 020, Fertigung 24 250, Verwaltung 22 300, Vertrieb 1 780. Umlage Müllverbrennung nach nicht recycelbarem Abfall (t): Material 168, Fertigung 398, Verwaltung 212, Vertrieb 22. Materialeinzelkosten 2 422 120,00 €, Fertigungseinzelkosten 2 400 399,00 €, Umsatzerlöse 22 825 000,00 €. Keine Bestandsveränderungen.

*Gesucht*

#enum(numbering: "a)",
[Führe die innerbetriebliche Leistungsverrechnung nach dem Anbauverfahren auf Teilkostenbasis durch und ermittle die Summen der (variablen) Gemeinkosten.],
[Berechne die Zuschlagssätze für die Teilkostenkalkulation (eine Nachkommastelle) und weise variable Herstell- und Selbstkosten aus.],
[Berechne das Betriebsergebnis der Teilkostenrechnung.],
)
][
*Was heißt das?* *Anbauverfahren:* Hilfsstellen geben nur an Hauptstellen ab (keine Lieferungen untereinander). *Teilkostenbasis:* Umgelegt werden nur die *variablen* Kosten; die Fixkosten bleiben als Block stehen und werden am Ende einmal abgezogen.
][
*Verrechnungssätze:* Kläranlage $256 740/58 350="4,40"$ €/m³; Müllverbrennung $700 800/800=876$ €/t.
][
*a) Variable GK der Hauptstellen:* Material $14 624,20+44 088+147 168=205 880,20$; Fertigung $4 117 412,10+106 700+348 648=4 572 760,10$; Verwaltung $282 636,40+98 120+185 712=566 468,40$; Vertrieb $1 009 821,20+7832+19 272=1 036 925,20$ €. Summe 6 382 033,90 € = alle variablen GK ✓.
][
*b) Zuschläge:* variable MGK $205 880,20/2 422 120 approx "8,5" %$; variable FGK $4 572 760,10/2 400 399 approx "190,5" %$. Variable Herstellkosten $2 422 120+205 880,20+2 400 399+4 572 760,10=9 601 159,30$ €. Variable VwGK $566 468,40/9 601 159,30 approx "5,9" %$; variable VtGK $approx "10,8" %$. Variable Selbstkosten 11 204 552,90 €.
][
*c) Betriebsergebnis:* Fixkosten gesamt $1 221 000+1 855 000+1 274 000+4 825 000+1 228 000+817 000=11 220 000$ €. $22 825 000-11 204 552,90-11 220 000=+400 447,10$ €. Umsatz minus variable Selbstkosten ist der DB (11 620 447,10 €).
]

#aufgabe(titel: "A18 IV: Teilkosten-BAB (Variante)", art: "rechnen", quelle: "1.8.2", herkunft: "variante", vorlage: "Altklausur WS 18/19, Aufg. IV (BAB)", minuten: 18,
  ergebnis: [5 €/m³, 20 €/h; var. GK 15 000 / 176 000 / 15 000 / 24 500 €; Zuschläge 3,8 % / 70,4 % / 1,8 % / 2,9 %; var. SK 880 500 €; Betriebsergebnis +201 500 €.])[
#if not web [*Aufgabe 78* #linebreak()]
*Gegeben und Annahmen*

#tab(columns: (1.6fr, 1fr, 1fr),
 th([Kostenstelle], [variabel €], [fix €]),
 [Wasserversorgung (Hilfsstelle)], [30 000], [50 000],
 [Reinigung (Hilfsstelle)], [12 000], [18 000],
 [Material], [8 000], [40 000],
 [Fertigung], [150 000], [220 000],
 [Verwaltung], [9 500], [60 000],
 [Vertrieb], [21 000], [30 000],
)
Wasser (m³): Material 1 000, Fertigung 4 000, Verwaltung 500, Vertrieb 500. Reinigung (h): Material 100, Fertigung 300, Verwaltung 150, Vertrieb 50. MEK 400 000 €, FEK 250 000 €, Umsatz 1 500 000 €. Anbauverfahren, Teilkostenbasis.

*Gesucht*

#enum(numbering: "a)",
[variable GK der Hauptstellen,],
[Zuschlagssätze, variable HK und SK,],
[Betriebsergebnis.],
)
][
*Sätze:* $30 000/6000=5$ €/m³; $12 000/600=20$ €/h.
][
*a):* Material $8000+5000+2000=15 000$; Fertigung $150 000+20 000+6000=176 000$; Verwaltung $9500+2500+3000=15 000$; Vertrieb $21 000+2500+1000=24 500$ €.
][
*b):* MGK $15 000/400 000 approx "3,8" %$; FGK $176 000/250 000="70,4" %$; var. HK $841 000$ €; VwGK $approx "1,8" %$, VtGK $approx "2,9" %$; var. SK $880 500$ €.
][
*c):* Fixkosten 418 000 €; $1 500 000-880 500-418 000=+201 500$ €.
]

#kapitel("Kapitel 2 · Statische Investitionsrechnung")

#aufgabe(titel: "Lineare Abschreibung je Jahr", art: "verstehen", quelle: "2.1", herkunft: "eigen")[
#if not web [*Aufgabe 79* #linebreak()]
Eine Maschine kostet 140 000 €, hält sieben Jahre und hat Restwert null. Wie hoch ist die lineare Abschreibung pro Jahr? Warum sind 140 000 € und 70 000 € keine Abschreibung?
][
*Antwort:* $A=(140 000-0)/7=20 000$ €/Jahr. 140 000 € ist der einmalige Kaufbetrag, kein jährlicher Wertverbrauch; 70 000 € ist die mittlere Kapitalbindung, die Basis der kalkulatorischen Zinsen.
]

#aufgabe(titel: "Kapitaldienst und Betriebskosten abgrenzen", art: "verstehen", quelle: "2.1", herkunft: "eigen")[
#if not web [*Aufgabe 80* #linebreak()]
Was gehört in den vorliegenden Aufgaben zum Kapitaldienst, was zu den Betriebskosten? Betriebskosten sind ausdrücklich ohne Abschreibung und Zinsen angegeben: Was fehlt bis zu den Gesamtkosten?
][
*Abgrenzung:* Kapitaldienst = kalkulatorische Abschreibung + kalkulatorische Zinsen. Betriebskosten = sonstige Fixkosten + variable Kosten. Zusammen ergeben sie die Jahresgesamtkosten.
][
*Was fehlt:* Der Kapitaldienst muss *einmal* addiert werden. Ist er bereits als Betrag vorgegeben, werden Abschreibung und Zinsen nicht nochmals aufgeschlagen. *Typische Verwechslung:* Kaufbetrag plus Betriebskosten – Kaufbetrag und Jahreskosten haben verschiedene Zeitbezüge.

*Merksatz:* Schon enthaltene Abschreibung und Zinsen nicht doppelt addieren.
]

#aufgabe(titel: "Kaufbetrag auf Nutzungsjahre verteilen", art: "verstehen", quelle: "2.1", herkunft: "eigen")[
#if not web [*Aufgabe 81* #linebreak()]
Warum wird der Kaufbetrag einer Maschine nicht als voller jährlicher Kostenbetrag angesetzt?
][
*Mehrere Jahre:* Die Anschaffung dient mehreren Nutzungsjahren. Die lineare Abschreibung verteilt den Wertverbrauch auf diese Jahre; der kalkulatorische Zins bewertet zusätzlich die durchschnittliche Kapitalbindung. So entstehen vergleichbare Jahreskosten.
]

#aufgabe(titel: "Warum mit mittlerer Kapitalbindung rechnen?", art: "verstehen", quelle: "2.1", herkunft: "eigen")[
#if not web [*Aufgabe 82* #linebreak()]
Warum rechnet man bei linearem Kapitalabbau mit der durchschnittlichen Kapitalbindung, und warum ist das bei Restwert null die Hälfte der Anschaffungskosten?
][
*Mittelwert:* Am Anfang ist mehr Kapital gebunden als am Ende. Bei linearer Entwicklung ist der Mittelwert aus Anfang ($A K$) und Ende ($R W$) die passende durchschnittliche Bindung: $(A K+R W)/2$; bei $R W=0$ also $A K/2$. Das gilt für dieses Modell, nicht automatisch für jede andere Geldanlage.

*Merksatz:* Linearer Kapitalabbau: Anfang und Ende mitteln.
]

#aufgabe(titel: "Maschine 20: Kapitaldienst und Aussagegrenze", herkunft: "original", vorlage: "Datei 05 (Kapitaldienst), Aufg. 20", minuten: 10, art: "rechnen", quelle: "2.1")[
#if not web [*Aufgabe 83* #linebreak()]
*Gegeben und Annahmen*

Anschaffung 140 000 €, Nutzungsdauer 7 Jahre, Auslastung 28 000 Stück/Jahr. Fixe Kosten ohne Abschreibungen und Zinsen 15 000 €/Jahr; variable Gesamtkosten bei dieser Menge 180 000 €/Jahr; Kalkulationszins 10 % pro Jahr. Lineare Abschreibung und kontinuierliche Kapitalrückflüsse, Restwertannahme 0 €. Kein Erlös und kein anderes Angebot gegeben.

*Gesucht*

#enum(numbering: "a)",
[Ermittle Kapitaldienst, Betriebskosten und Gesamtkosten je Jahr.],
[Kannst Du die Investition als vorteilhaft beurteilen?],
)
#src[KD, Aufgabe 20, PDF-S. 1–2.]
][
*Kapitaldienst:* $A=140000/7=20000$ €/Jahr; $Z=140000/2 dot "0,10"=7000$ €/Jahr. Daher $K D=27000$ €/Jahr. Der Kaufbetrag ist keine jährliche Betriebskostenposition.
][
*Betriebskosten:* $B K=15000+180000=195000$ €/Jahr. Abschreibung und Zinsen sind laut Aufgabe in diesen Werten noch nicht enthalten.
][
*Gesamtkosten:* $K=27000+195000=222000$ €/Jahr. Rechnerische Stückkosten $222000/28000 approx "7,93"$ €/Stück.
][
*Aussage prüfen:* Ohne Erlös oder Vergleichsangebot/Kostenobergrenze ist kein Vorteilhaftigkeitsurteil möglich. Die Kostenbasis ist berechnet; daraus folgt allein noch kein Gewinn.
]

#aufgabe(titel: "Maschine 20: Kapitaldienst (Variante)", art: "rechnen", quelle: "2.1", herkunft: "variante", vorlage: "Datei 05 (Kapitaldienst), Aufg. 20", minuten: 8,
  ergebnis: [$K D=18 600$ €, $B K=122 000$ €, $K=140 600$ €/Jahr, ca. 7,03 €/Stück.])[
#if not web [*Aufgabe 84* #linebreak()]
*Gegeben und Annahmen*

Eine Maschine kostet 90 000 €, Nutzungsdauer 6 Jahre, Auslastung 20 000 Stück/Jahr. Fixkosten *ohne* Abschreibungen und Zinsen 12 000 €/Jahr, variable Kosten 110 000 €/Jahr, Kalkulationszins 8 %. Lineare Abschreibung, kontinuierliche Kapitalrückflüsse, Restwert 0.

*Gesucht*

#enum(numbering: "a)",
[Kapitaldienst,],
[Betriebskosten und Gesamtkosten je Jahr,],
[Kannst Du sagen, ob die Maschine vorteilhaft ist?],
)
][
*a):* $A=90 000/6=15 000$ €, $Z=45 000 dot "0,08"=3600$ €; $K D=18 600$ €/Jahr.
][
*b):* $B K=12 000+110 000=122 000$ €; $K=140 600$ €/Jahr, also $approx "7,03"$ €/Stück.
][
*c):* Nein – ohne Erlös oder Vergleichsangebot gibt es keinen Maßstab.
]

#aufgabe(titel: "Datei 11: Kapitalkosten mit und ohne Restwert", art: "rechnen", quelle: "2.1", herkunft: "original", vorlage: "Datei 11, Aufg. Kapitalkosten", minuten: 6,
  ergebnis: [$A=218 750$ €/Jahr (mit RW); $Z=100 000$ € ohne RW, $112 500$ € mit RW.])[
#if not web [*Aufgabe 85* #linebreak()]
*Gegeben und Annahmen*

Eine Investition verursacht Anschaffungskosten von 2 000 000 €. Nutzungsdauer 8 Jahre, Kalkulationszinssatz 10 % pro Jahr. Lineare Abschreibung, durchschnittliche Kapitalbindung $(A K+R W)/2$.

*Gesucht*

#enum(numbering: "a)",
[Kalkulatorische Abschreibung bei einem möglichen Restwert von 250 000 €,],
[kalkulatorische Zinsen ohne Restwert und mit 250 000 € Restwert.],
)
][
*a) Abschreibung:* Abgeschrieben wird nur, was an Wert verloren geht: $(2 000 000-250 000)/8=218 750$ €/Jahr.
][
*b) Zinsen ohne RW:* Im Mittel ist die Hälfte gebunden: $2 000 000/2 dot "0,10"=100 000$ €/Jahr.
][
*Zinsen mit RW:* Der Restwert bleibt bis zum Ende gebunden, deshalb steigt die mittlere Bindung: $(2 000 000+250 000)/2 dot "0,10"=112 500$ €/Jahr.
][
*Prüfen:* Ein Restwert *senkt* die Abschreibung (vorher 250 000 €/Jahr), *erhöht* aber die Zinsen. Kapitaldienst mit RW: $218 750+112 500=331 250$ €/Jahr.
]

#aufgabe(titel: "Datei 11: Kapitalkosten (Variante)", art: "rechnen", quelle: "2.1", herkunft: "variante", vorlage: "Datei 11, Aufg. Kapitalkosten", minuten: 6,
  ergebnis: [$A=90 000$ €/Jahr; $Z=24 000$ € ohne RW, $26 400$ € mit RW; Kapitaldienst mit RW 116 400 €/Jahr.])[
#if not web [*Aufgabe 86* #linebreak()]
*Gegeben und Annahmen*

Anschaffungskosten 600 000 €, Nutzungsdauer 6 Jahre, Kalkulationszins 8 % pro Jahr, möglicher Restwert 60 000 €. Lineare Abschreibung, Bindung $(A K+R W)/2$.

*Gesucht*

#enum(numbering: "a)",
[Abschreibung mit Restwert,],
[Zinsen ohne und mit Restwert,],
[Kapitaldienst mit Restwert.],
)
][
*a):* $(600 000-60 000)/6=90 000$ €/Jahr.
][
*b):* ohne RW $300 000 dot "0,08"=24 000$ €; mit RW $330 000 dot "0,08"=26 400$ €/Jahr.
][
*c):* $90 000+26 400=116 400$ €/Jahr.
]

#aufgabe(titel: "Wann die Kostenvergleichsrechnung genügt", art: "verstehen", quelle: "2.2", herkunft: "eigen")[
#if not web [*Aufgabe 87* #linebreak()]
Bei gleicher Jahresmenge und gleichwertiger Leistung sind die Gesamtkosten von Anlage A niedriger. Was folgt daraus in der KVR – und was folgt *nicht*? Wann begründet die KVR allgemein eine Wahl?
][
*Folgerung:* A ist nach dem Kostenkriterium vorteilhafter; bei gleicher Menge haben Gesamt- und Stückkosten dieselbe Rangfolge.

*Nicht daraus:* dass A auch bei anderen Verkaufspreisen den höheren Gewinn hat, und dass man den Kaufbetrag nochmals als Jahreskosten addieren müsste.

*Bedingung:* gleichwertige Leistung und passende Mengenbasis; unterschiedliche Erlöse gehören in die GVR.
]

#aufgabe(titel: "Ungleiche Mengen im Kostenvergleich", art: "verstehen", quelle: "2.2", herkunft: "eigen")[
#if not web [*Aufgabe 88* #linebreak()]
Warum ist der Vergleich „100 000 Brötchen aus Normalo gegen 150 000 aus Back de luxe“ kein bloßer Gesamtkostenvergleich gleicher Leistung, und warum reichen niedrige Stückkosten nicht als vollständiges Gewinnurteil?
][
*Mengen verschieden:* Gesamtkosten verschiedener Mengen sind nicht vergleichbar; Stückkosten zeigen die Kosten je Einheit. Zusätzlich müssen Kapazität und Absatz passen – Normalo kann 150 000 Stück allein nicht herstellen.

*Kein Gewinnurteil:* Der Jahresgewinn hängt auch von verkaufter Menge und Nettoerlös ab. Eine hohe Kapazität bringt erst durch passenden Absatz zusätzlichen Erlös.
]

#aufgabe(titel: "Kosten ohne Erlös und ohne Vergleich", art: "verstehen", quelle: "2.2", herkunft: "eigen")[
#if not web [*Aufgabe 89* #linebreak()]
Ein einzelnes Angebot hat bekannte Jahreskosten, aber keinen Erlös und kein Vergleichsangebot. Welche Aussage über die Vorteilhaftigkeit ist begründet?
][
*Antwort:* Die Kosten sind bestimmbar, die Vorteilhaftigkeit allein daraus nicht – es fehlt eine Vergleichs- oder Erfolgsbasis. *Typische Verwechslungen:* „Jede Anlage mit Kosten ist unvorteilhaft“ (Kosten sagen nichts über die Gegenleistung) oder „man nimmt automatisch an“.
]

#aufgabe(titel: "Backofen 23: Kosten bei gleicher Jahresmenge", herkunft: "original", vorlage: "Backofen-Blatt 031, Aufg. 23", minuten: 15, art: "rechnen", quelle: "2.2", ergebnis: [Normalo-Back; 19 320 gegenüber 21 430 €/Jahr.])[
#if not web [*Aufgabe 90* #linebreak()]
*Gegeben und Annahmen*

#tab(columns: (2fr, 1fr, 1fr),
 th([Jahresdaten], [Normalo-Back], [Back de luxe]),
 [Anschaffungskosten €], [18 000], [32 000],
 [Nutzungsdauer / Restwert], [5 Jahre / 0 €], [5 Jahre / 0 €],
 [Kalkulationszins pro Jahr], [8 %], [8 %],
 [Material €/Brötchen], [0,10], [0,08],
 [Variable Energie €/Brötchen], [0,02], [0,01],
 [Fixe Energie €/Jahr], [1 500], [1 900],
 [Reparaturen €/Jahr], [1 000], [2 000],
 [Raumkosten €/Jahr], [500], [850],
)
Lineare Abschreibung, mittlere Kapitalbindung $(A K+R W)/2$, konstante Jahreswerte. Produzierte Mengen werden vollständig verkauft. Sonstige Steuern und zusätzliche Zahlungen werden nicht angesetzt.
Geplante Jahresmenge für beide: 100 000 Brötchen.

*Gesucht*

#enum(numbering: "a)",
[Berechne Abschreibung, kalkulatorische Zinsen, fixe und variable Kosten je Ofen.],
[Bestimme Gesamtkosten und die günstigere Alternative bei gleichwertiger Leistung.],
)
#src[B31, Aufgabe 23, PDF-S. 1–3; B27, PDF-S. 1–2; selbst nachgerechnet.]
][
*Kapitaldienst bilden:* Der Kaufbetrag wird auf fünf Jahre verteilt; Zinsen beziehen sich auf den Mittelwert. Normalo: $A=18000/5=3600$ €/Jahr, $Z=9000 dot "0,08"=720$ €/Jahr. Back: $A=32000/5=6400$ €/Jahr, $Z=16000 dot "0,08"=1280$ €/Jahr.
][
*Fixkosten sammeln:* Normalo $K_f=3600+720+1500+1000+500=7320$ €/Jahr. Back $K_f=6400+1280+1900+2000+850=12430$ €/Jahr. Abschreibung und Zinsen sind darin bereits enthalten.
][
*Mengenabhängige Kosten:* Normalo $k_v="0,10"+"0,02"="0,12"$ €/Brötchen, also $K_v=12000$ €/Jahr. Back $k_v="0,08"+"0,01"="0,09"$ €/Brötchen, also $K_v=9000$ €/Jahr.
][
*Entscheiden und prüfen:* $K_N=7320+12000=19320$ €/Jahr, $K_B=12430+9000=21430$ €/Jahr. Normalo ist um *2 110 €/Jahr günstiger*. Gegenprobe Stückkosten: 0,1932 gegenüber 0,2143 €/Brötchen bei derselben Menge. Das Urteil setzt vergleichbare Leistung/Erlöse voraus.
]

#aufgabe(titel: "Backofen 23: Kostenvergleich (Variante)", art: "rechnen", quelle: "2.2", herkunft: "variante", vorlage: "Backofen-Blatt 031, Aufg. 23", minuten: 12,
  ergebnis: [Standard 20 720 €/Jahr, Premium 22 820 €/Jahr → Standard um 2 100 € günstiger.])[
#if not web [*Aufgabe 91* #linebreak()]
*Gegeben und Annahmen*

Ein Café vergleicht zwei Kaffeeautomaten bei 40 000 Bechern/Jahr, gleiche Qualität.
#tab(columns: (2fr, 1fr, 1fr),
 th([], [Standard], [Premium]),
 [Anschaffungskosten €], [24 000], [40 000],
 [Nutzungsdauer / Restwert], [6 J. / 0 €], [6 J. / 4 000 €],
 [Kalkulationszins], [6 %], [6 %],
 [Sonstige Fixkosten €/Jahr], [2 000], [3 500],
 [Variable Kosten €/Becher], [0,35], [0,30],
)
Lineare Abschreibung, $D=(A K+R W)/2$.

*Gesucht*

#enum(numbering: "a)",
[Abschreibung, Zinsen, Fix- und Gesamtkosten je Automat,],
[günstigere Alternative.],
)
][
*Standard:* $A=4000$, $D=12 000$, $Z=720$; $K_f=6720$; $K=6720+"0,35" dot 40 000=20 720$ €/Jahr.
][
*Premium:* $A=(40 000-4000)/6=6000$, $D=22 000$, $Z=1320$; $K_f=10 820$; $K=10 820+12 000=22 820$ €/Jahr.
][
*Entscheiden:* Standard um 2 100 €/Jahr günstiger (0,518 gegenüber 0,5705 €/Becher). Der Restwert senkt die Abschreibung des Premiums, erhöht aber seine Zinsen.
]

#aufgabe(titel: "Backofen 24: Kosten bei unterschiedlicher Leistung", herkunft: "original", vorlage: "Backofen-Blatt 031, Aufg. 24", minuten: 12, art: "rechnen", quelle: "2.2")[
#if not web [*Aufgabe 92* #linebreak()]
*Gegeben und Annahmen*

#tab(columns: (2fr, 1fr, 1fr),
 th([Jahresdaten], [Normalo-Back], [Back de luxe]),
 [Anschaffungskosten €], [18 000], [32 000],
 [Nutzungsdauer / Restwert], [5 Jahre / 0 €], [5 Jahre / 0 €],
 [Kalkulationszins pro Jahr], [8 %], [8 %],
 [Material €/Brötchen], [0,10], [0,08],
 [Variable Energie €/Brötchen], [0,02], [0,01],
 [Fixe Energie €/Jahr], [1 500], [1 900],
 [Reparaturen €/Jahr], [1 000], [2 000],
 [Raumkosten €/Jahr], [500], [850],
)
Lineare Abschreibung, mittlere Kapitalbindung $(A K+R W)/2$, konstante Jahreswerte. Produzierte Mengen werden vollständig verkauft. Sonstige Steuern und zusätzliche Zahlungen werden nicht angesetzt.
Normalo kann jährlich nur 100 000, Back de luxe 150 000 Brötchen herstellen. 150 000 Brötchen wären absetzbar. Kostenstruktur wie in der Tabelle.

*Gesucht*

#enum(numbering: "a)",
[Vergleiche die Stückkosten bei jeweils voll genutzter Kapazität.],
[Beurteile die Wahl und die Bedeutung der Kapazitätsgrenze.],
)
#src[B31, Aufgabe 24, PDF-S. 1 und 3; B27, PDF-S. 1–2.]
][
*Vergleichsbasis wählen:* Die Jahresmengen sind verschieden. Ein bloßer Vergleich zweier Gesamtkosten sagt dann nicht, welcher Ofen dieselbe Leistung günstiger bereitstellt. Berechne zunächst Kosten je Brötchen.
][
*Normalo berechnen:* $K_f=18000/5+9000 dot "0,08"+1500+1000+500=7320$ €/Jahr. $k_N=7320/100000+"0,12"="0,1932"$ €/Brötchen.
][
*Back berechnen:* $K_f=32000/5+16000 dot "0,08"+1900+2000+850=12430$ €/Jahr. $K_B=12430+"0,09" dot 150000=25930$ €/Jahr. $k_B=25930/150000 approx "0,17287"$ €/Brötchen.
][
*Entscheiden und prüfen:* Back de luxe hat bei dieser Auslastung niedrigere Stückkosten und schafft die absetzbaren 150 000 Stück. Normalo kann diese Menge allein nicht liefern. Ob beide Erlöse dieselbe Gewinnentscheidung ergeben, ist ohne Preise nicht berechnet; die KVR setzt eine passende Leistungsbasis voraus.
]

#aufgabe(titel: "Backofen 24: Unterschiedliche Kapazität (Variante)", art: "rechnen", quelle: "2.2", herkunft: "variante", vorlage: "Backofen-Blatt 031, Aufg. 24", minuten: 10,
  ergebnis: [Standard 0,518 €/Becher bei 40 000; Premium ca. 0,480 €/Becher bei 60 000 → Premium.])[
#if not web [*Aufgabe 93* #linebreak()]
*Gegeben und Annahmen*

Automaten wie folgt: Standard $K_f=6720$ €/Jahr, $k_v="0,35"$ €/Becher, Kapazität 40 000 Becher/Jahr. Premium $K_f=10 820$ €/Jahr, $k_v="0,30"$ €/Becher, Kapazität 60 000 Becher/Jahr. 60 000 Becher wären absetzbar. ($K_f$ enthält Abschreibung, kalkulatorische Zinsen und sonstige Fixkosten.)

*Gesucht*

#enum(numbering: "a)",
[Stückkosten bei jeweils voller Kapazität,],
[Beurteilung.],
)
][
*Vergleichsbasis:* Ungleiche Mengen → Stückkosten vergleichen.
][
*Rechnen:* Standard $20 720/40 000="0,518"$ €; Premium $(10 820+18 000)/60 000 approx "0,480"$ € je Becher.
][
*Urteil:* Premium hat niedrigere Stückkosten und deckt die Nachfrage; Standard schafft nur 40 000. Ein Gewinnurteil braucht zusätzlich die Preise.
]

#aufgabe(titel: "Maschine 21: Zwei Angebote mit gleichem Output", herkunft: "original", vorlage: "Datei 05 (Kapitaldienst), Aufg. 21", minuten: 12, art: "rechnen", quelle: "2.2")[
#if not web [*Aufgabe 94* #linebreak()]
*Gegeben und Annahmen*

Zwei Angebote mit je 7 Jahren Nutzungsdauer, 28 000 Stück/Jahr und 10 % Kalkulationszins pro Jahr. Lineare Abschreibung, kontinuierliche Rückflüsse, Restwert jeweils 0 € als Modellannahme. Identische Leistung und Erlösbasis.
#tab(columns: (2fr,1fr,1fr),
 th([Daten], [Angebot 1], [Angebot 2]),
 [Anschaffungskosten €], [140 000], [161 000],
 [Sonstige Fixkosten €/Jahr], [15 000], [14 000],
 [Variable Gesamtkosten €/Jahr], [180 000], [165 000],
)

*Gesucht*

#enum(numbering: "a)",
[Vergleiche Kapitaldienst, Betriebs- und Gesamtkosten tabellarisch.],
[Welche Alternative ist nach der KVR vorteilhafter?],
)
#src[KD, Aufgaben 20–21, PDF-S. 1–3.]
][
*Kapitaldienst beider Anlagen:* Angebot 1: $A=20000$, $Z=7000$, $K D=27000$ €/Jahr. Angebot 2: $A=161000/7=23000$, $Z=80500 dot "0,10"=8050$, $K D=31050$ €/Jahr.
][
*Jahresvergleich:*
#tab(columns: (1.7fr,1fr,1fr), th([€/Jahr],[Angebot 1],[Angebot 2]), [Kapitaldienst],[27 000],[31 050], [Betriebskosten],[195 000],[179 000], [Gesamtkosten],[222 000],[210 050])
][
*Entscheiden:* Angebot 2 spart $222000-210050=11950$ €/Jahr. Trotz höherem Kaufbetrag ist es bei gleicher Leistung im Kostenvergleich vorteilhafter.
][
*Prüfen:* Höherer Kapitaldienst 4 050 € wird durch 16 000 € niedrigere Betriebskosten mehr als ausgeglichen: $16000-4050=11950$ €/Jahr. Ein isolierter Blick auf den Kaufpreis hätte die Betriebskostenvorteile übersehen.
]

#aufgabe(titel: "Maschine 21: Zwei Angebote (Variante)", art: "rechnen", quelle: "2.2", herkunft: "variante", vorlage: "Datei 05 (Kapitaldienst), Aufg. 21", minuten: 10,
  ergebnis: [Angebot 1: 140 600 €/Jahr; Angebot 2: 131 320 €/Jahr → Angebot 2 um 9 280 €/Jahr günstiger.])[
#if not web [*Aufgabe 95* #linebreak()]
*Gegeben und Annahmen*

Beide Angebote: Nutzungsdauer 6 Jahre, 20 000 Stück/Jahr, Kalkulationszins 8 %, Restwert 0, gleiche Leistung.
#tab(columns: (2fr, 1fr, 1fr),
 th([], [Angebot 1], [Angebot 2]),
 [Anschaffungskosten €], [90 000], [108 000],
 [Fixkosten ohne A und Z €/Jahr], [12 000], [11 000],
 [Variable Kosten €/Jahr], [110 000], [98 000],
)

*Gesucht*

#enum(numbering: "a)",
[Kapitaldienst, Betriebskosten und Gesamtkosten beider Angebote,],
[Welches Angebot ist nach der KVR vorteilhafter?],
)
][
*Angebot 1:* $K D=15 000+3600=18 600$, $B K=122 000$, $K=140 600$ €/Jahr.
][
*Angebot 2:* $A=18 000$, $Z=54 000 dot "0,08"=4320$, $K D=22 320$; $B K=109 000$; $K=131 320$ €/Jahr.
][
*Entscheiden:* Angebot 2 spart 9 280 €/Jahr; der höhere Kapitaldienst (+3 720 €) wird durch 13 000 € niedrigere Betriebskosten mehr als ausgeglichen.
]

#aufgabe(titel: "Datei 12: Kostenvergleich dreier Anlagen", art: "rechnen", quelle: "2.2", herkunft: "original", vorlage: "Datei 12 (Statische Verfahren), KVR-Beispiel", minuten: 20,
  ergebnis: [Jahreskosten A 55 000, B 53 750, C 52 000 € → C; Stückkosten bei 10 000/7 000/8 500 LE: 5,50 / 6,31 / 5,64 € → A; $x_"krit"(A,C)=6 250$ Stück.])[
#if not web [*Aufgabe 96* #linebreak()]
*Gegeben und Annahmen*

Kostenvergleich ohne Liquidationserlöse (Restwert 0), Kalkulationszins 10 %, lineare Abschreibung, Bindung $A K/2$. Kapazität je 10 000 Stück/Jahr.
#tab(columns: (2fr, 1fr, 1fr, 1fr),
 th([], [Anlage A], [Anlage B], [Anlage C]),
 [Anschaffungskosten €], [120 000], [110 000], [150 000],
 [Nutzungsdauer Jahre], [10], [8], [10],
 [Sonstige Fixkosten €/Jahr], [2 000], [2 500], [2 500],
 [Personalkosten €/Jahr], [26 000], [24 000], [19 200],
 [Fertigungsmaterial €/Jahr], [5 000], [5 000], [5 000],
 [Sonstige variable Kosten €/Jahr], [4 000], [3 000], [2 800],
)
Die variablen Jahreskosten gelten bei 10 000 Stück und sind proportional zur Menge.

*Gesucht*

#enum(numbering: "a)",
[Ermittle Fixkosten, variable Kosten und Gesamtkosten je Jahr. Welche Anlage wird bei 10 000 Stück gekauft?],
[Die Auslastungen seien nun A 10 000, B 7 000 und C 8 500 Leistungseinheiten. Berechne die Stückkosten.],
[Stelle die Kostenfunktionen der beiden kostengünstigsten Anlagen A und C auf und ermittle die kritische Menge.],
)
][
*Kapitalkosten:* A: $A=12 000$, $Z=60 000 dot "0,10"=6000$; B: $A=13 750$, $Z=5500$; C: $A=15 000$, $Z=7500$ €/Jahr.
][
*a) Jahreskosten:* $K_f$: A $20 000$, B $21 750$, C $25 000$ €. $K_v$: A $35 000$, B $32 000$, C $27 000$ €. Gesamt: A 55 000, B 53 750, C 52 000 € → *C*.
][
*b) Stückkosten:* Erst $k_v$ je Stück: A 3,50, B 3,20, C 2,70 €. Die Fixkosten bleiben, die variablen Kosten passen sich der Menge an. A: $55 000/10 000="5,50"$; B: $(21 750+"3,2" dot 7000)/7000=44 150/7000 approx "6,31"$; C: $(25 000+"2,7" dot 8500)/8500=47 950/8500 approx "5,64"$ €/Stück → *A* am günstigsten. *Typischer Fehler:* $K_v$ von 10 000 Stück unverändert durch 7 000 teilen – dann wären auch variable Kosten „fix“.
][
*c) Kritische Menge:* $K_A=20 000+"3,5"x$, $K_C=25 000+"2,7"x$. $x_"krit"=(25 000-20 000)/("3,5"-"2,7")=6250$ Stück/Jahr. Unterhalb ist A günstiger (niedrige Fixkosten), oberhalb C (niedrige Steigung).
][
*Prüfen:* Bei 6 250 Stück kosten beide 41 875 €/Jahr ✓.
]

#aufgabe(titel: "Datei 12: Kostenvergleich (Variante)", art: "rechnen", quelle: "2.2", herkunft: "variante", vorlage: "Datei 12 (Statische Verfahren), KVR-Beispiel", minuten: 18,
  ergebnis: [Jahreskosten X 42 600, Y 40 100, Z 39 800 € → Z; Stückkosten bei 8 000/6 000/7 000: 5,33 / 5,70 / 5,34 €; $x_"krit"(Y,Z)=7 400$ Stück.])[
#if not web [*Aufgabe 97* #linebreak()]
*Gegeben und Annahmen*

Restwert 0, Kalkulationszins 8 %, Bindung $A K/2$, Kapazität je 8 000 Stück/Jahr; variable Jahreskosten gelten bei 8 000 Stück und sind proportional.
#tab(columns: (2fr, 1fr, 1fr, 1fr),
 th([], [X], [Y], [Z]),
 [Anschaffungskosten €], [90 000], [100 000], [130 000],
 [Nutzungsdauer Jahre], [9], [10], [10],
 [Sonstige Fixkosten €/Jahr], [3 000], [2 500], [2 000],
 [Personalkosten €/Jahr], [20 000], [18 000], [14 000],
 [Material €/Jahr], [4 000], [4 000], [4 000],
 [Sonstige variable Kosten €/Jahr], [2 000], [1 600], [1 600],
)

*Gesucht*

#enum(numbering: "a)",
[Gesamtkosten bei 8 000 Stück und Wahl,],
[Stückkosten bei X 8 000, Y 6 000, Z 7 000 Stück,],
[kritische Menge zwischen Y und Z.],
)
][
*a):* $K_f$: X $10 000+3600+3000=16 600$, Y $10 000+4000+2500=16 500$, Z $13 000+5200+2000=20 200$ €. $K_v$: 26 000 / 23 600 / 19 600 €. Gesamt 42 600 / 40 100 / 39 800 € → *Z*.
][
*b):* $k_v$: 3,25 / 2,95 / 2,45 €. X $42 600/8000 approx "5,33"$; Y $(16 500+"2,95" dot 6000)/6000="5,70"$; Z $(20 200+"2,45" dot 7000)/7000 approx "5,34"$ €/Stück. X knapp vor Z.
][
*c):* $(20 200-16 500)/("2,95"-"2,45")=7400$ Stück/Jahr; darüber Z, darunter Y günstiger.
]

#aufgabe(titel: "Warum die GVR die teurere Anlage wählen kann", art: "verstehen", quelle: "2.3", herkunft: "eigen")[
#if not web [*Aufgabe 98* #linebreak()]
Bei 100 000 Stück erlöst Back de luxe 5 000 € mehr und kostet 2 110 € mehr pro Jahr. Wie ändert sich der Gewinn? Warum kann die GVR bei Qualitätsunterschieden aussagekräftiger sein als die KVR?
][
*Rechnung:* Mehrerlös minus Mehrkosten: $5000-2110=+2890$ €/Jahr. Typische Fehler: nur die Mehrkosten (−2 110 €) oder nur den Mehrerlös (+5 000 €) sehen.
][
*Begründung:* Qualität kann höhere Preise ermöglichen. Die GVR betrachtet Erlöse *minus* vollständige Jahreskosten; die KVR kann den Mehrerlös nicht bewerten. Deshalb kann der Qualitätsmehrerlös die Mehrkosten der teureren Anlage übertreffen.
]

#aufgabe(titel: "Bausteine des Jahresgewinnvergleichs", art: "verstehen", quelle: "2.3", herkunft: "eigen")[
#if not web [*Aufgabe 99* #linebreak()]
Welche Größen gehören in einen Jahresgewinnvergleich mit unterschiedlichen Absatzmengen, und warum genügt der Gewinn je Stück nicht?
][
*Bausteine:* jeweils absetzbare Menge und Nettoerlös je Stück (ergibt den Jahreserlös) sowie die vollständigen Jahreskosten einschließlich kalkulatorischer Kapitalpositionen. *Nicht:* nur der Gewinn je Stück ohne Menge – das wäre ein anderer Maßstab als der gesamte Jahresgewinn.
]

#aufgabe(titel: "Positiver Gewinn nach kalkulatorischen Zinsen", art: "verstehen", quelle: "2.3", herkunft: "eigen")[
#if not web [*Aufgabe 100* #linebreak()]
Was bedeutet ein positiver Gewinn *nach* kalkulatorischen Zinsen im Investitionsmodell?
][
*Bedeutung:* Die Erlöse decken Betriebskosten, Abschreibung *und* die angesetzte kalkulatorische Verzinsung des Kapitals. Der positive Rest liegt über dieser Kostenbasis – gültig für die vorgegebenen Mengen, Preise und Jahresannahmen.
]

#aufgabe(titel: "Backofen 25: Gewinn durch unterschiedliche Qualität", herkunft: "original", vorlage: "Backofen-Blatt 031, Aufg. 25", minuten: 10, art: "rechnen", quelle: "2.3", ergebnis: [Normalo +5 680, Back de luxe +8 570 €/Jahr; GVR: Back de luxe.])[
#if not web [*Aufgabe 101* #linebreak()]
*Gegeben und Annahmen*

#tab(columns: (2fr, 1fr, 1fr),
 th([Jahresdaten], [Normalo-Back], [Back de luxe]),
 [Anschaffungskosten €], [18 000], [32 000],
 [Nutzungsdauer / Restwert], [5 Jahre / 0 €], [5 Jahre / 0 €],
 [Kalkulationszins pro Jahr], [8 %], [8 %],
 [Material €/Brötchen], [0,10], [0,08],
 [Variable Energie €/Brötchen], [0,02], [0,01],
 [Fixe Energie €/Jahr], [1 500], [1 900],
 [Reparaturen €/Jahr], [1 000], [2 000],
 [Raumkosten €/Jahr], [500], [850],
)
Lineare Abschreibung, mittlere Kapitalbindung $(A K+R W)/2$, konstante Jahreswerte. Produzierte Mengen werden vollständig verkauft. Sonstige Steuern und zusätzliche Zahlungen werden nicht angesetzt.
Beide Öfen verkaufen 100 000 Stück/Jahr. Normalo erzielt 0,25 €/Brötchen netto, Back de luxe mit Vollkornbrötchen 0,30 €/Stück netto.

*Gesucht*

#enum(numbering: "a)",
[Berechne die Jahresgewinne und die Gewinndifferenz.],
[Erkläre, warum das Urteil vom reinen Kostenvergleich abweicht.],
)
#src[B31, Aufgabe 25, PDF-S. 1 und 3; B27, PDF-S. 2.]
][
*Jahreskosten aufbauen:* Aus den Daten folgen $K_N=7320+"0,12" dot 100000=19320$ €/Jahr und $K_B=12430+"0,09" dot 100000=21430$ €/Jahr; beide enthalten Abschreibung und kalkulatorische Zinsen.
][
*Erlöse bestimmen:* $E_N="0,25" dot 100000=25000$ €/Jahr; $E_B="0,30" dot 100000=30000$ €/Jahr. Die bessere Qualität ist hier über den vorgegebenen Preis erfasst.
][
*Gewinne vergleichen:* $G_N=25000-19320=+5680$ €/Jahr; $G_B=30000-21430=+8570$ €/Jahr. Back de luxe erzielt *2 890 €/Jahr mehr Gewinn*.
][
*Prüfen:* Mehrerlös 5 000 € minus Mehrkosten 2 110 € ergibt dieselben 2 890 €. Deshalb bevorzugt die GVR Back de luxe, obwohl die KVR bei gleicher Menge Normalo bevorzugt.
]

#aufgabe(titel: "Backofen 25: Gewinnvergleich (Variante)", art: "rechnen", quelle: "2.3", herkunft: "variante", vorlage: "Backofen-Blatt 031, Aufg. 25", minuten: 8,
  ergebnis: [Standard +3 280 €, Premium +5 180 €/Jahr → Premium (+1 900 €).])[
#if not web [*Aufgabe 102* #linebreak()]
*Gegeben und Annahmen*

Beide Automaten verkaufen 40 000 Becher/Jahr. Jahreskosten (inkl. Abschreibung und kalkulatorischer Zinsen): Standard 20 720 €, Premium 22 820 €. Premium-Kaffee lässt sich zu 0,70 €/Becher verkaufen, Standard zu 0,60 € (netto).

*Gesucht*

#enum(numbering: "a)",
[Gewinne und Gewinndifferenz,],
[Warum weicht das Urteil vom Kostenvergleich ab?],
)
][
*Erlöse:* 24 000 € bzw. 28 000 €/Jahr.
][
*Gewinne:* Standard $+3280$ €, Premium $+5180$ €/Jahr; Premium +1 900 €.
][
*Erklären:* Mehrerlös 4 000 € > Mehrkosten 2 100 €. Die KVR sieht den Qualitätspreis nicht.
]

#aufgabe(titel: "Blatt 09.3: Pizzaöfen Roma und Florenz", herkunft: "original", vorlage: "Blatt 09 (Controlling-Aufgaben), Aufg. 3", minuten: 15, art: "rechnen", quelle: "2.3")[
#if not web [*Aufgabe 103* #linebreak()]
*Gegeben und Annahmen*

Beide Pizzaöfen haben 8 Jahre Nutzungsdauer, 0 € Restwert, 10 % Kalkulationszins pro Jahr, 5 € Nettoerlös je Pizza und 2,50 € variable Kosten je Pizza. Lineare Abschreibung; mittlere Bindung halbe Anschaffungskosten. Jahresmengen sind vollständig absetzbar.
#tab(columns: (2fr,1fr,1fr), th([Daten], [Roma], [Florenz]),
 [Anschaffung €], [100 000], [65 000],
 [Geplanter Absatz Stück/Jahr], [50 000], [40 000],
 [Sonstige Fixkosten €/Jahr], [55 000], [45 000],
)
Für den BEP von Roma bleiben dessen Kosten und Preis unverändert; Mengen unmittelbar über der Schwelle sind technisch möglich.

*Gesucht*

#enum(numbering: "a)",
[Welche Form des Gewinnvergleichs ist bei diesen Mengen anzuwenden?],
[Welcher Ofen ist nach Jahresgewinn vorzuziehen?],
[Wie viele Pizzas braucht Roma zur Kostendeckung bzw. für einen positiven Gewinn?],
)
#src[C09, Aufgabe 3, PDF-S. 3–4; letzte Pizza zur positiven Gewinnzone präzisiert.]
][
*Basis wählen:* Wegen verschiedener verkaufter Jahresmengen werden die gesamten Jahresgewinne verglichen. Ein Vergleich allein der Gewinne je Pizza würde einen anderen Maßstab verwenden.
][
*Fixkosten vollständig erfassen:* Roma: $A=100000/8=12500$, $Z=50000 dot "0,10"=5000$ €/Jahr; $K_f=55000+12500+5000=72500$ €/Jahr. Florenz: $A=65000/8=8125$, $Z=32500 dot "0,10"=3250$ €/Jahr; $K_f=45000+8125+3250=56375$ €/Jahr.
][
*Jahresgewinne:* Roma $G_R=(5-"2,50") dot 50000-72500=+52500$ €/Jahr. Florenz $G_F="2,50" dot 40000-56375=+43625$ €/Jahr. Roma ist nach GVR um *8 875 €/Jahr* besser.
][
*Gewinnschwelle Roma:* $x_"BEP"=72500/"2,50"=29000$ Pizzas/Jahr. Genau dort ist $G=0$. Für *positiven* Gewinn braucht Roma bei ganzen Pizzas mindestens *29 001*; dann bleiben 2,50 € Gewinn.
][
*Prüfen:* Roma $E=250000$, $K=197500$ €; Florenz $E=200000$, $K=156375$ €. Beide Differenzen bestätigen die Gewinne. Der Kapitaldienst von Florenz ist $8125+3250=11375$ €/Jahr und enthält bereits beide Kapitalpositionen.
]

#aufgabe(titel: "Blatt 09.3: Pizzaöfen (Variante)", art: "rechnen", quelle: "2.3", herkunft: "variante", vorlage: "Blatt 09 (Controlling-Aufgaben), Aufg. 3", minuten: 12,
  ergebnis: [Napoli +67 200 €, Milano +50 800 €/Jahr; BEP Napoli 24 000, positiver Gewinn ab 24 001 Pizzas.])[
#if not web [*Aufgabe 104* #linebreak()]
*Gegeben und Annahmen*

Beide Öfen: 10 Jahre, Restwert 0, Zins 8 %, Erlös 6,00 €/Pizza, $k_v$ 2,80 €/Pizza, Bindung $A K/2$.
#tab(columns: (2fr, 1fr, 1fr),
 th([], [Napoli], [Milano]),
 [Anschaffung €], [120 000], [80 000],
 [Absatz Pizzas/Jahr], [45 000], [35 000],
 [Sonstige Fixkosten €/Jahr], [60 000], [50 000],
)

*Gesucht*

#enum(numbering: "a)",
[Jahresgewinne und Wahl,],
[Gewinnschwelle von Napoli und erste Pizza mit Gewinn.],
)
][
*Fixkosten:* Napoli $60 000+12 000+4800=76 800$; Milano $50 000+8000+3200=61 200$ €.
][
*a):* Napoli $"3,2" dot 45 000-76 800=67 200$; Milano $"3,2" dot 35 000-61 200=50 800$ € → Napoli.
][
*b):* $76 800/"3,2"=24 000$ Pizzas ($G=0$); positiver Gewinn ab *24 001*.
]

#aufgabe(titel: "Datei 12: Gewinnvergleich dreier Anlagen", art: "rechnen", quelle: "2.3", herkunft: "original", vorlage: "Datei 12 (Statische Verfahren), GVR-Beispiel", minuten: 15,
  ergebnis: [Gewinne A 136 000, B 128 250, C 141 000 € → C; kritische Gewinnmenge A/C 5 000 Stück.])[
#if not web [*Aufgabe 105* #linebreak()]
*Gegeben und Annahmen*

Alle drei Anlagen haben 10 000 Stück/Jahr Kapazität; Beschäftigungsgrad 100 %, vollständiger Absatz.
#tab(columns: (2fr, 1fr, 1fr, 1fr),
 th([], [A], [B], [C]),
 [$k_v$ €/Stück], [3,50], [3,20], [2,70],
 [$K_f$ €/Jahr], [20 000], [21 750], [25 000],
 [Preis $e$ €/Stück], [19,10], [18,20], [19,30],
)

*Gesucht*

#enum(numbering: "a)",
[Welche Anlage hat den höchsten Jahresgewinn?],
[Berechne die kritische Menge zwischen A und C im Gewinnvergleich und interpretiere sie.],
)
][
*a) Gewinne bei 10 000 Stück:* A $191 000-35 000-20 000=136 000$ €; B $182 000-32 000-21 750=128 250$ €; C $193 000-27 000-25 000=141 000$ € → *C*.
][
*b) Gewinnfunktionen:* $G_A=("19,10"-"3,50")x-20 000="15,6"x-20 000$; $G_C=("19,30"-"2,70")x-25 000="16,6"x-25 000$.
][
*Gleichsetzen:* $"15,6"x-20 000="16,6"x-25 000 => x=5000$ Stück/Jahr.
][
*Interpretieren:* Unter 5 000 Stück verdient A mehr, darüber C. Hier unterscheiden sich die Preise; deshalb müssen die *Gewinne*, nicht die Kosten gleichgesetzt werden (Kostengleichheit läge bei 6 250 Stück). Probe bei 5 000: $G_A=G_C=58 000$ € – kein Nullgewinn.
]

#aufgabe(titel: "Datei 12: Gewinnvergleich (Variante)", art: "rechnen", quelle: "2.3", herkunft: "variante", vorlage: "Datei 12 (Statische Verfahren), GVR-Beispiel", minuten: 12,
  ergebnis: [Gewinne X 29 400, Y 30 300, Z 33 000 € → Z; kritische Gewinnmenge X/Z 4 000 Stück.])[
#if not web [*Aufgabe 106* #linebreak()]
*Gegeben und Annahmen*

8 000 Stück/Jahr, vollständiger Absatz.
#tab(columns: (2fr, 1fr, 1fr, 1fr),
 th([], [X], [Y], [Z]),
 [$k_v$ €/Stück], [3,25], [2,95], [2,45],
 [$K_f$ €/Jahr], [16 600], [16 500], [20 200],
 [Preis €/Stück], [9,00], [8,80], [9,10],
)

*Gesucht*

#enum(numbering: "a)",
[Jahresgewinne und Wahl,],
[kritische Gewinnmenge zwischen X und Z.],
)
][
*a):* X $5,75 dot 8000-16 600=29 400$; Y $5,85 dot 8000-16 500=30 300$; Z $6,65 dot 8000-20 200=33 000$ € → *Z*.
][
*b):* $"5,75"x-16 600="6,65"x-20 200 => "0,9"x=3600 => x=4000$ Stück. Darüber Z, darunter X.
]

#aufgabe(titel: "Datei 12: Ersatzinvestition", art: "rechnen", quelle: "2.3", herkunft: "original", vorlage: "Datei 12 (Statische Verfahren), Ersatzinvestition", minuten: 6,
  ergebnis: [$G_"alt"=6 000$ €, $G_"neu"=9 300$ €; Gewinndifferenz +3 300 € zugunsten des neuen Objekts.])[
#if not web [*Aufgabe 107* #linebreak()]
*Gegeben und Annahmen*

#tab(columns: (2fr, 1fr, 1fr),
 th([], [altes Objekt], [neues Objekt]),
 [Produzierte und verkaufte Stück], [10 000], [10 000],
 [Preis $e$ €/Stück], [3,00], [4,00],
 [$k_v$ €/Stück], [1,50], [0,47],
 [$K_f$ €/Jahr], [9 000], [26 000],
)
Die Fixkosten enthalten jeweils alle Kapital- und sonstigen Fixkosten.

*Gesucht*

#enum(numbering: "a)",
[Errechne die Gewinndifferenz. Lohnt der Ersatz?],
)
][
*Alt:* $("3,00"-"1,50") dot 10 000-9000=+6000$ €.
][
*Neu:* $("4,00"-"0,47") dot 10 000-26 000=35 300-26 000=+9300$ €.
][
*Differenz:* $+3300$ €/Jahr zugunsten des neuen Objekts → Ersatz lohnt im GVR-Sinn. Der Mehrgewinn kommt aus höherem Preis und niedrigeren variablen Kosten, die die um 17 000 € höheren Fixkosten übertreffen.
]

#aufgabe(titel: "Datei 12: Ersatzinvestition (Variante)", art: "rechnen", quelle: "2.3", herkunft: "variante", vorlage: "Datei 12 (Statische Verfahren), Ersatzinvestition", minuten: 8,
  ergebnis: [Bei 8 000 Stück: alt 8 800 €, neu 6 200 € → nicht ersetzen; Ersatz lohnt ab 10 000 Stück.])[
#if not web [*Aufgabe 108* #linebreak()]
*Gegeben und Annahmen*

Altes Objekt: Preis 5,00 €, $k_v$ 2,40 €, $K_f$ 12 000 €/Jahr. Neues Objekt: Preis 5,50 € (bessere Qualität), $k_v$ 1,60 €, $K_f$ 25 000 €/Jahr. Absatz 8 000 Stück/Jahr, für beide gleich.

*Gesucht*

#enum(numbering: "a)",
[Gewinndifferenz bei 8 000 Stück,],
[ab welcher Absatzmenge lohnt der Ersatz?],
)
][
*a):* Alt $"2,60" dot 8000-12 000=8800$ €; neu $"3,90" dot 8000-25 000=6200$ €. Differenz −2 600 € → *nicht ersetzen*.
][
*b):* $Delta G=("3,90"-"2,60")x-13 000="1,3"x-13 000>=0 => x>=10 000$ Stück. Erst ab 10 000 Stück trägt der höhere Stück-DB die zusätzlichen Fixkosten.
]

#aufgabe(titel: "Zinsen für die Rentabilität zurückaddieren", art: "verstehen", quelle: "2.4", herkunft: "eigen")[
#if not web [*Aufgabe 109* #linebreak()]
Ein GVR-Gewinn ist bereits nach kalkulatorischen Zinsen angegeben. Welcher Zähler passt zur Verzinsung des gesamten durchschnittlich gebundenen Kapitals, und warum?
][
*Zähler:* $G+Z$. Der Gewinn ist schon um die kalkulatorischen Zinsen gemindert; für den Erfolg vor diesen Zinsen werden sie zurückaddiert und dann durch die mittlere Kapitalbindung geteilt.

*Typische Verwechslungen:* $G-Z$ zieht die Zinsen doppelt ab; nur der Erlös ignoriert alle Kosten. Ist der Gewinn schon *vor* Zinsen gegeben, wäre erneutes Addieren doppelt.

*Merksatz:* Zinsen nur zurückaddieren, wenn sie vorher abgezogen wurden.
]

#aufgabe(titel: "Differenzinvestition: dasselbe Budget vergleichen", art: "verstehen", quelle: "2.4", herkunft: "eigen")[
#if not web [*Aufgabe 110* #linebreak()]
Was muss bei einer billigeren Anlage geschehen, bevor Du dasselbe Gesamtbudget rentabilitätsmäßig vergleichst? Wovon hängt das Ergebnis dann ab?
][
*Differenzinvestition:* Bei der billigeren Anlage bleibt Budget frei. Dessen Alternativverwendung muss mit Ertrag und Kapitalbindung festgelegt und zur billigeren Anlage addiert werden. Erst dann vergleichst Du dasselbe Gesamtbudget; ein isolierter Prozentsatz bildet die Budgetverwendung nicht ab. Das Ergebnis hängt vom angenommenen Ertrag und der Bindung dieser Zusatzanlage ab.

*Merksatz:* Gleicher Budgetvergleich braucht auch die freie Restanlage.
]

#aufgabe(titel: "Differenzertrag nicht halbieren", art: "verstehen", quelle: "2.4", herkunft: "eigen")[
#if not web [*Aufgabe 111* #linebreak()]
Der Backofen-Aufgabentext nennt 2 000 € Jahresertrag der Differenzanlage. Darf dieser Ertrag zu 1 000 € werden, weil die mittlere Kapitalbindung halb so hoch ist wie der Kaufbetrag?
][
*Nein:* Durchschnittliche Kapitalbindung (Nenner) und Jahresertrag (Zähler) sind verschiedene Größen. Der Nenner folgt aus dem Kapitalverlauf; ein ausdrücklich gegebener Jahresertrag bleibt unverändert. Auch „sonst läge die Rendite zu hoch“ ist kein Grund, einen gegebenen Wert zu ändern. Genau hier weicht die Backofen-Mitschrift vom Aufgabentext ab.

*Merksatz:* Ein halbierter Kapitalnenner halbiert nicht den Jahresertrag.
]

#aufgabe(titel: "Backofen 26: Rentabilität mit Differenzinvestition", herkunft: "original", vorlage: "Backofen-Blatt 031, Aufg. 26", minuten: 15, art: "rechnen", quelle: "2.4", ergebnis: [Mit gedrucktem Differenzertrag: 52,50 % für Normalo plus Alternative, 61,5625 % für Back.])[
#if not web [*Aufgabe 112* #linebreak()]
*Gegeben und Annahmen*

#tab(columns: (2fr, 1fr, 1fr),
 th([Jahresdaten], [Normalo-Back], [Back de luxe]),
 [Anschaffungskosten €], [18 000], [32 000],
 [Nutzungsdauer / Restwert], [5 Jahre / 0 €], [5 Jahre / 0 €],
 [Kalkulationszins pro Jahr], [8 %], [8 %],
 [Material €/Brötchen], [0,10], [0,08],
 [Variable Energie €/Brötchen], [0,02], [0,01],
 [Fixe Energie €/Jahr], [1 500], [1 900],
 [Reparaturen €/Jahr], [1 000], [2 000],
 [Raumkosten €/Jahr], [500], [850],
)
Lineare Abschreibung, mittlere Kapitalbindung $(A K+R W)/2$, konstante Jahreswerte. Produzierte Mengen werden vollständig verkauft. Sonstige Steuern und zusätzliche Zahlungen werden nicht angesetzt.
Je 100 000 Stück/Jahr; Nettopreise 0,25 / 0,30 €/Stück. Als geprüfte Jahreswerte nach kalkulatorischen Zinsen gelten $G_N=5680$ €, $G_B=8570$ €, $Z_N=720$ €, $Z_B=1280$ €. Das freie Kapital der billigeren Alternative beträgt 14 000 €. Laut Aufgabentext erzielt dessen Alternativverwendung 2 000 € Ertrag; angenommen ist ein jährlicher Ertrag vor kalkulatorischen Zinsen. Für den gemeinsamen Budgetvergleich wird wie in der Mitschrift die durchschnittliche Differenzbindung mit 7 000 € angesetzt.

*Gesucht*

#enum(numbering: "a)",
[Berechne zuerst die isolierten Rentabilitäten.],
[Vergleiche beide Alternativen bei gemeinsamem Budget und dem gedruckten Differenzertrag.],
[Prüfe die Mitschrift: 1 000 € Differenzertrag und 52,9 %.],
)
#src[B31, Aufgabe 26, PDF-S. 1 und 4; Jahresbezug als Modellannahme; Quellenabweichung selbst geprüft.]
][
*Gewinngröße abstimmen:* Für die Verzinsung vor kalkulatorischen Zinsen werden diese zurückaddiert. Normalo $G_N+Z_N=6400$ €/Jahr, Back $G_B+Z_B=9850$ €/Jahr.
][
*Isolierte Prozentsätze:* $R_N=6400/9000 dot 100 % approx "71,11" %$; $R_B=9850/16000 dot 100 %="61,5625" %$. Die isolierte Rangfolge bevorzugt Normalo; sie sagt noch nichts über den Ertrag des freien Budgets.
][
*Differenz einbeziehen:* Beide Budgetvarianten haben jetzt 16 000 € mittlere Bindung. $R_("N+Diff")=(6400+2000)/(9000+7000) dot 100 %="52,50" %$. Back de luxe bleibt bei 61,5625 % und ist im vorgegebenen Budgetvergleich besser.
][
*Quelle sichtbar prüfen:* In der Mitschrift stehen 1 000 € statt der gedruckten 2 000 €. Mit 1 000 € ergäbe die notierte Formel *46,25 %*, nicht 52,9 %. Keine der beiden Zahlen wird still übernommen. Die Halbierung der Kapitalbindung erlaubt nicht, einen gegebenen Jahresertrag zu halbieren.
][
*Plausibilität:* Der kleine isolierte Nenner begünstigte Normalo. Erst die festgelegte Alternative für das freie Kapital macht den Gesamtbudgetvergleich möglich. Die Entscheidung hängt ausdrücklich von diesem Differenzmodell ab.
]

#aufgabe(titel: "Backofen 26: Rentabilität (Variante)", art: "rechnen", quelle: "2.4", herkunft: "variante", vorlage: "Backofen-Blatt 031, Aufg. 26", minuten: 12,
  ergebnis: [Isoliert 33,3 % (Standard) vs. 29,5 % (Premium); mit Differenzanlage Standard 23,6 % < 29,5 % → Premium.])[
#if not web [*Aufgabe 113* #linebreak()]
*Gegeben und Annahmen*

Jahreswerte nach kalkulatorischen Zinsen: Standard $G=3280$ €, $Z=720$ €, $D=12 000$ €. Premium $G=5180$ €, $Z=1320$ €, $D=22 000$ €. Wählt man Standard, wird das freie Budget so angelegt, dass durchschnittlich 10 000 € gebunden sind; Ertrag 1 200 €/Jahr (vor kalkulatorischen Zinsen).

*Gesucht*

#enum(numbering: "a)",
[isolierte Rentabilitäten $(G+Z)/D$,],
[Vergleich bei gleichem Budget.],
)
][
*a):* Standard $4000/12 000 approx "33,3" %$; Premium $6500/22 000 approx "29,5" %$.
][
*b):* Standard + Differenz: $(4000+1200)/(12 000+10 000) approx "23,6" %$ < 29,5 % → *Premium*. Der kleine Nenner hat Standard isoliert begünstigt.
]

#aufgabe(titel: "Schaltmodule 032: Vier statische Verfahren", herkunft: "original", vorlage: "Blatt 032 Schaltmodule", minuten: 30, art: "rechnen", quelle: "2.4", ergebnis: [KVR: A; GVR und RVR: B; AVR nach B31: B knapp vor A.])[
#if not web [*Aufgabe 114* #linebreak()]
*Gegeben und Annahmen*

Beide Anlagen: Nutzungsdauer 10 Jahre, Kapazität je 15 000 Module/Jahr, geplante Auslastung 80 %, Kalkulationszins 9 % pro Jahr. Mittlere Bindung ist ausdrücklich die Hälfte der Anschaffungskosten. Ein Restwert ist nicht angegeben; für die lineare Abschreibung wird 0 € angenommen. Alle Stücke werden verkauft, Werte bleiben im Jahresmodell konstant.
#tab(columns: (2fr,1fr,1fr),
 th([Daten], [Anlage A], [Anlage B]),
 [Anschaffungskosten €], [300 000], [360 000],
 [Sonstige Fixkosten €/Jahr], [32 000], [38 000],
 [Variable Kosten €/Stück], [24,00], [25,00],
 [Nettopreis €/Stück], [36,80], [40,50],
)
Für den Budgetvergleich der RVR verwende die Differenzanlage wie in der Mitschrift: 60 000 € Anfangskapital, 30 000 € durchschnittlich gebunden, Ertrag 5 400 €/Jahr (9 % des Anfangskapitals). AVR wie B31 mit $G+A$.

*Gesucht*

#enum(numbering: "a)",
[Ermittle Planmenge, Kosten und KVR-Urteil.],
[Berechne Jahresgewinne und GVR-Urteil.],
[Bestimme isolierte und budgetgleiche Rentabilitäten.],
[Berechne die Amortisationszeiten und beurteile die Verfahren.],
)
#src[S32, Aufgabenstellung PDF-S. 1 und Mitschrift S. 2–3; AVR vollständig ergänzt; B31, S. 4 für deren Konvention.]
][
*Planmenge:* $x="0,80" dot 15000=12000$ Module/Jahr. Kapazität und Auslastung gelten für beide; Preise unterscheiden sich wegen der Qualität.
][
*Kapitaldienst:* A: $A_A=300000/10=30000$, $Z_A=150000 dot "0,09"=13500$ €/Jahr. B: $A_B=36000$, $Z_B=180000 dot "0,09"=16200$ €/Jahr.
][
*Kostenvergleich:* $K_(f,A)=30000+13500+32000=75500$, $K_(f,B)=36000+16200+38000=90200$ €/Jahr. $K_A=75500+24 dot 12000=363500$, $K_B=90200+25 dot 12000=390200$ €/Jahr. KVR bevorzugt *A*, um 26 700 €/Jahr günstiger; die unterschiedlichen Erlöse bleiben dabei unberücksichtigt.
][
*Gewinnvergleich:* $E_A="36,80" dot 12000=441600$, $E_B="40,50" dot 12000=486000$ €/Jahr. $G_A=+78100$, $G_B=+95800$ €/Jahr. GVR bevorzugt *B*, Mehrgewinn 17 700 €/Jahr.
][
*Isolierte Rentabilitäten:* $R_A=(78100+13500)/150000 dot 100 % approx "61,07" %$; $R_B=(95800+16200)/180000 dot 100 % approx "62,22" %$. Gewinne sind vor dem Teilen um die kalkulatorischen Zinsen bereinigt.
][
*Differenzanlage:* $R_("A+Diff")=(91600+5400)/(150000+30000) dot 100 % approx "53,89" %$. B bleibt bei 62,22 %. Im vorgegebenen Budgetmodell ist *B* besser. Der Ertrag 5 400 € folgt hier dem Mitschriftmodell; 9 % auf die mittlere Differenzbindung wären eine andere Annahme.
][
*Amortisation:* $t_A=300000/(78100+30000) approx "2,7752"$ Jahre; $t_B=360000/(95800+36000) approx "2,7314"$ Jahre. Beide unter zehn Jahren, B etwas schneller. „AVR = gleich“ in S32, S. 3 ist kein exaktes Ergebnis.
][
*Verfahren beurteilen und prüfen:* KVR ignoriert den Qualitätsmehrerlös und ist deshalb allein unzureichend. GVR bevorzugt den höheren Jahresgewinn; RVR bezieht ihn auf Kapital und Alternativverwendung. AVR ergänzt die Rückgewinnungsdauer, erfasst aber nicht den gesamten späteren Erfolg. Mehrerlös 44 400 minus Mehrkosten 26 700 ergibt als Gegenprobe 17 700 € Mehrgewinn. Alle Verfahren beruhen auf den genannten statischen Annahmen.
]

#aufgabe(titel: "Schaltmodule 032: Vier Verfahren (Variante)", art: "rechnen", quelle: "2.4", herkunft: "variante", vorlage: "Blatt 032 Schaltmodule", minuten: 25,
  ergebnis: [KVR: C (238 000 vs. 240 100 €); GVR: D (+12 900 €); RVR isoliert 70,0 % vs. 70,4 %, budgetgleich C 61,0 % → D; AVR: D 2,29 vs. C 2,30 Jahre.])[
#if not web [*Aufgabe 115* #linebreak()]
*Gegeben und Annahmen*

Zwei Anlagen: Nutzungsdauer 8 Jahre, Kapazität je 20 000 Stück/Jahr, Auslastung 75 %, Kalkulationszins 8 %, Restwert 0, mittlere Bindung $A K/2$, alle Stück verkauft.
#tab(columns: (2fr, 1fr, 1fr),
 th([], [Anlage C], [Anlage D]),
 [Anschaffungskosten €], [200 000], [240 000],
 [Sonstige Fixkosten €/Jahr], [25 000], [28 000],
 [Variable Kosten €/Stück], [12,00], [11,50],
 [Nettopreis €/Stück], [20,00], [21,00],
)
Differenzanlage bei Wahl von C: 40 000 € Anfangskapital, 20 000 € durchschnittlich gebunden, Ertrag 3 200 €/Jahr. AVR mit Rückfluss $G+A$.

*Gesucht*

#enum(numbering: "a)",
[Planmenge, Kosten, KVR-Urteil,],
[Gewinne, GVR-Urteil,],
[Rentabilitäten isoliert und budgetgleich,],
[Amortisationszeiten und Gesamturteil.],
)
][
*a):* $x=15 000$. C: $A=25 000$, $Z=8000$, $K_f=58 000$, $K=238 000$ €. D: $A=30 000$, $Z=9600$, $K_f=67 600$, $K=240 100$ €. KVR → *C* (2 100 € günstiger).
][
*b):* $E_C=300 000$, $E_D=315 000$; $G_C=62 000$, $G_D=74 900$ € → *D*.
][
*c):* $R_C=70 000/100 000=70,0 %$; $R_D=84 500/120 000 approx "70,4" %$. Budgetgleich: $(70 000+3200)/120 000=61,0 %$ → *D*.
][
*d):* $t_C=200 000/87 000 approx "2,30"$; $t_D=240 000/104 900 approx "2,29"$ Jahre → D knapp. *Gesamt:* Nur die KVR spricht für C, weil sie den höheren Preis von D übersieht.
]

#aufgabe(titel: "Altklausur SS 13: Rentabilität zweier Anlagen", art: "rechnen", quelle: "2.4", herkunft: "original", vorlage: "Altklausur SS 13, Aufg. 6", minuten: 15,
  ergebnis: [$G_"I"=25 900$ €, $G_"II"=24 000$ €; $R_"I" approx "32,2" %$, $R_"II"=30 %$ → Anlage I.])[
#if not web [*Aufgabe 116* #linebreak()]
*Gegeben und Annahmen*

#tab(columns: (2fr, 1fr, 1fr),
 th([], [Anlage I], [Anlage II]),
 [Anschaffungskosten €], [208 000], [210 000],
 [Nutzungsdauer Jahre], [6], [6],
 [Liquidationserlös (Restwert) €], [25 000], [30 000],
 [Kapazitätsauslastung Stück/Jahr], [22 000], [24 000],
 [Verkaufspreis €/Teil], [10,00], [10,00],
 [Variable Kosten €/Teil], [3,80], [4,00],
 [Angestrebte Mindestverzinsung], [10 %], [10 %],
 [Fixkosten ohne Abschreibung €/Jahr], [80 000], [90 000],
)
Die kalkulatorischen Zinsen sind in den Fixkosten bereits enthalten. Lineare Abschreibung; durchschnittliche Kapitalbindung $D=(A K+R W)/2$; alle Teile werden verkauft.

*Gesucht*

#enum(numbering: "a)",
[Gewinn für I und II,],
[Rentabilität für I und II und Entscheidung.],
)
][
*Abschreibung:* $A=(A K-R W)/n$: I $(208 000-25 000)/6=30 500$ €, II $(210 000-30 000)/6=30 000$ € je Jahr. Sie fehlt noch in den Fixkosten und muss dazu.
][
*a) Gewinne:* I: $E=220 000$, $K_v=83 600$, $G=220 000-83 600-80 000-30 500=25 900$ €. II: $E=240 000$, $K_v=96 000$, $G=240 000-96 000-90 000-30 000=24 000$ €. Die kalkulatorischen Zinsen stecken schon in den 80 000 bzw. 90 000 € und werden nicht nochmals abgezogen.
][
*Zinsen herausrechnen:* $D_"I"=(208 000+25 000)/2=116 500$ €, $Z_"I"=11 650$ €. $D_"II"=120 000$ €, $Z_"II"=12 000$ €.
][
*b) Rentabilität:* Weil die Zinsen den Gewinn schon gemindert haben, zählt für die Verzinsung des gebundenen Kapitals $G+Z$: $R_"I"=(25 900+11 650)/116 500 approx "32,2" %$, $R_"II"=(24 000+12 000)/120 000=30,0 %$. Beide übertreffen die geforderten 10 %; *Anlage I* verzinst das Kapital besser.
][
*Prüfen:* Würde man nur $G/D$ rechnen, ergäben sich 22,2 % und 20,0 % – das ist die Rendite *über* die bereits verrechneten 10 % hinaus. Die Rangfolge bleibt gleich; für einen Vergleich mit einer Mindestverzinsung musst Du aber die passende Abgrenzung benennen.
]

#aufgabe(titel: "Altklausur SS 13: Rentabilität zweier Anlagen (Variante)", art: "rechnen", quelle: "2.4", herkunft: "variante", vorlage: "Altklausur SS 13, Aufg. 6", minuten: 15,
  ergebnis: [$G_"I"=37 000$ €, $G_"II"=22 400$ €; $R_"I" approx "56,3" %$, $R_"II" approx "32,4" %$ → Anlage I.])[
#if not web [*Aufgabe 117* #linebreak()]
*Gegeben und Annahmen*

#tab(columns: (2fr, 1fr, 1fr),
 th([], [Anlage I], [Anlage II]),
 [Anschaffungskosten €], [150 000], [180 000],
 [Nutzungsdauer Jahre], [5], [5],
 [Restwert €], [10 000], [20 000],
 [Absatz Stück/Jahr], [30 000], [32 000],
 [Preis €/Stück], [8,00], [8,00],
 [Variable Kosten €/Stück], [3,50], [3,80],
 [Fixkosten ohne Abschreibung, inkl. kalk. Zinsen 10 % €/Jahr], [70 000], [80 000],
)
Lineare Abschreibung; $D=(A K+R W)/2$.

*Gesucht*

#enum(numbering: "a)",
[Gewinne,],
[Rentabilitäten (Erfolg vor kalkulatorischen Zinsen bezogen auf $D$) und Entscheidung.],
)
][
*Abschreibung:* I $140 000/5=28 000$ €, II $160 000/5=32 000$ €/Jahr.
][
*Gewinne:* I $240 000-105 000-70 000-28 000=37 000$ €; II $256 000-121 600-80 000-32 000=22 400$ €.
][
*Zinsen:* $D_"I"=80 000$ €, $Z_"I"=8 000$ €; $D_"II"=100 000$ €, $Z_"II"=10 000$ €.
][
*Rentabilität:* $R_"I"=45 000/80 000 approx "56,3" %$, $R_"II"=32 400/100 000="32,4" %$. *Anlage I.* Plausibel: weniger Kapital, höherer Gewinn.
]

#aufgabe(titel: "A14 IV: Rentabilitätsvergleichsrechnung", art: "rechnen", quelle: "2.4", herkunft: "original", vorlage: "Altklausur WS 14/15, Aufg. IV", minuten: 30,
  ergebnis: [$K=55 000$ €, $G=10 000$ €/Jahr; $R=(G+Z)/D=16 000/60 000 approx "26,7" %$ > 25 % → durchführen.])[
#if not web [*Aufgabe 118* #linebreak()]
*Gegeben und Annahmen*

Ein Industriebetrieb prüft eine Investition: Anschaffungskosten einer maschinellen Anlage 120 000 € netto, kein Liquidationserlös, Nutzungsdauer 10 Jahre. Pro Jahr werden 10 000 Erzeugnisse produziert und abgesetzt. Neben kalkulatorischen Abschreibungen und kalkulatorischen Zinsen (Zinssatz 10 %) fallen sonstige fixe Kosten von 2 000 €/Jahr an. Variable Kosten 3,50 €/Erzeugnis, Preis 6,50 € netto. Der Investor erwartet eine Mindestverzinsung von 25 %. (Dieselbe Aufgabe steht als Beispiel in Datei 12.)

*Gesucht*

#enum(numbering: "a)",
[Welche Entscheidung triffst Du mit der Rentabilitätsrechnung? Begründe mathematisch.],
)
][
*Jahreskosten:* $A=120 000/10=12 000$ €; $D=120 000/2=60 000$ €; $Z=6000$ €. $K=12 000+6000+2000+"3,50" dot 10 000=55 000$ €/Jahr.
][
*Gewinn:* $E="6,50" dot 10 000=65 000$ €; $G=65 000-55 000=10 000$ €/Jahr (nach kalkulatorischen Zinsen).
][
*Rentabilität:* Für die Verzinsung des gebundenen Kapitals die abgezogenen kalkulatorischen Zinsen zurückaddieren: $R=(10 000+6000)/60 000 dot 100 % approx "26,7" %$.
][
*Entscheiden:* 26,7 % > 25 % → *durchführen*. Achtung Abgrenzung: Die Formelsammlung schreibt $R=G/D$; setzt Du den Gewinn *nach* kalkulatorischen Zinsen ein, erhältst Du 16,7 % – das ist nur die Verzinsung *über* die bereits verrechneten 10 % hinaus und darf nicht mit der Mindestverzinsung von 25 % verglichen werden. Schreib in der Klausur dazu, welche Gewinngröße Du verwendest.
]

#aufgabe(titel: "A14 IV: Rentabilitätsrechnung (Variante)", art: "rechnen", quelle: "2.4", herkunft: "variante", vorlage: "Altklausur WS 14/15, Aufg. IV", minuten: 15,
  ergebnis: [$G=1 280$ €/Jahr; $R=(1 280+3 520)/44 000 approx "10,9" %$ < 20 % → nicht durchführen.])[
#if not web [*Aufgabe 119* #linebreak()]
*Gegeben und Annahmen*

Anschaffungskosten 80 000 €, Restwert 8 000 €, Nutzungsdauer 8 Jahre, 12 000 Stück/Jahr produziert und verkauft. Kalkulatorischer Zins 8 %, sonstige Fixkosten 3 000 €/Jahr, $k_v$ 5,60 €, Preis 7,00 € netto. Mindestverzinsung 20 %. Lineare Abschreibung, $D=(A K+R W)/2$.

*Gesucht*

#enum(numbering: "a)",
[Gewinn und Rentabilität; Entscheidung.],
)
][
*Kosten:* $A=72 000/8=9000$ €, $D=44 000$ €, $Z=3520$ €; $K=9000+3520+3000+67 200=82 720$ €.
][
*Gewinn:* $84 000-82 720=1280$ €/Jahr.
][
*Rentabilität:* $(1280+3520)/44 000 approx "10,9" %$ < 20 % → *nicht durchführen*, obwohl der Gewinn positiv ist: Ein positiver Gewinn zeigt nur, dass 8 % verdient werden, nicht 20 %.
]

#aufgabe(titel: "Umsatzrendite aus Gewinn und Umsatz", art: "verstehen", quelle: "2.4.1", herkunft: "eigen")[
#if not web [*Aufgabe 120* #linebreak()]
Ein Betrieb hat 300 000 € Jahresgewinn und 2 000 000 € Jahresumsatz. Wie hoch ist die Umsatzrendite? Warum sind „300 000 €“ und „666,67 %“ falsche Antworten?
][
*Antwort:* $300 000/2 000 000 dot 100 %=15 %$; beide Beträge gehören zum selben Jahr. 300 000 € ist der Gewinnbetrag, keine Verhältniszahl; 666,67 % entsteht, wenn Gewinn und Umsatz vertauscht werden.
]

#aufgabe(titel: "Drei Renditen, drei Nenner", art: "verstehen", quelle: "2.4.1", herkunft: "eigen")[
#if not web [*Aufgabe 121* #linebreak()]
Was unterscheidet Eigenkapital-, Gesamtkapital- und Umsatzrendite?
][
*Nenner und Frage:* EK-Rendite: Gewinn für die Eigentümer (nach FK-Zinsen) je mittlerem Eigenkapital. GK-Rendite: Erfolg *vor* FK-Zinsen je mittlerem Gesamtkapital – unabhängig von der Finanzierung. Umsatzrendite: klar abgegrenzter Gewinn je Umsatz derselben Periode. Verschiedene Nenner beantworten verschiedene Fragen.
]

#aufgabe(titel: "Umsatzrendite ist kein Cashflow", art: "verstehen", quelle: "2.4.1", herkunft: "eigen")[
#if not web [*Aufgabe 122* #linebreak()]
Warum ist eine Umsatzrendite kein Cashflow? Trenne die beiden Größen.
][
*Trennung:* Die Rendite ist ein Verhältnis (Gewinn/Umsatz in %), der Cashflow ein Zahlungsüberschuss in Euro je Periode. Der Gewinn enthält z. B. Abschreibungen und kalkulatorische Positionen, die keine Auszahlungen sind; deshalb ist er nicht automatisch ein Zahlungsüberschuss. *Typische Verwechslung:* „Gewinn enthält nur Zahlungen“.

*Merksatz:* Rendite ist ein Verhältnis, Cashflow ein Zahlungsbetrag.
]

#aufgabe(titel: "Altklausur SS 13: Bilanzkennzahlen", art: "rechnen", quelle: "2.4.1", herkunft: "original", vorlage: "Altklausur SS 13, Aufg. 1", minuten: 15,
  ergebnis: [Anlagenintensität 70,1 %; EK-Quote 58,2 %; Deckungsgrad I 83,0 %, II 127,7 % (goldene Regel eingehalten); Liquidität I/II/III 57,1 / 157,1 / 285,7 %.])[
#if not web [*Aufgabe 123* #linebreak()]
*Gegeben und Annahmen*

Bilanz einer Kapitalgesellschaft zum 31.12. (in €):
#tab(columns: (2fr, 1fr, 2fr, 1fr),
 th([Aktiva], [€], [Passiva], [€]),
 [Sachanlagen], [410 000], [Gezeichnetes Kapital], [300 000],
 [Finanzanlagen], [60 000], [Gewinnrücklage], [90 000],
 [Vorräte], [90 000], [Langfristiges FK], [210 000],
 [Forderungen], [70 000], [Kurzfristiges FK], [70 000],
 [Flüssige Mittel], [40 000], [], [],
 [Summe], [670 000], [Summe], [670 000],
)
Kennzahlen laut Formelsammlung: Anlagenintensität $= "AV"/"GV"$; Grad der finanziellen Unabhängigkeit $= "EK"/"GK"$; Deckungsgrad I $= "EK"/"AV"$, II $= ("EK"+"lgfr. FK")/"AV"$; Liquidität I $= "flüssige Mittel"/"kfr. FK"$, II $= ("flüssige Mittel"+"Forderungen")/"kfr. FK"$, III $= "UV"/"kfr. FK"$ (jeweils mal 100 %).

*Gesucht*

#enum(numbering: "a)",
[Anlagenintensität,],
[finanzielle Unabhängigkeit,],
[Deckung des Anlagevermögens. Ist die goldene Bilanzregel eingehalten?],
[Liquidität 1., 2. und 3. Grades mit kurzer Interpretation.],
)
][
*Blöcke bilden:* AV $=410 000+60 000=470 000$ €; UV $=90 000+70 000+40 000=200 000$ €; EK $=300 000+90 000=390 000$ €; FK $=280 000$ €. Erst die Summen, dann die Brüche – so verhinderst Du, dass eine Position fehlt.
][
*a) und b):* Anlagenintensität $470/670 dot 100 % approx "70,1" %$. EK-Quote $390/670 dot 100 % approx "58,2" %$: Gut die Hälfte des Kapitals gehört den Eigentümern.
][
*c) Deckung:* DG I $390/470 approx "83,0" %$, DG II $(390+210)/470 approx "127,7" %$. Die goldene Bilanzregel verlangt, dass langfristig gebundenes Vermögen langfristig finanziert ist (DG II ≥ 100 %). *Eingehalten*: Das AV ist vollständig durch EK und langfristiges FK gedeckt, sogar mit Überschuss.
][
*d) Liquidität:* I $40/70 approx "57,1" %$, II $110/70 approx "157,1" %$, III $200/70 approx "285,7" %$. Die sofort verfügbaren Mittel decken gut die Hälfte der kurzfristigen Schulden; mit Forderungen sind sie 1,6-fach gedeckt (Faustregel II ≥ 100 % erfüllt), mit dem gesamten UV fast dreifach. *Grenze:* Stichtagswerte – über Fälligkeitstermine sagen sie nichts.
]

#aufgabe(titel: "Altklausur SS 13: Bilanzkennzahlen (Variante)", art: "rechnen", quelle: "2.4.1", herkunft: "variante", vorlage: "Altklausur SS 13, Aufg. 1", minuten: 12,
  ergebnis: [AI 65,2 %; EK-Quote 39,1 %; DG I 60,0 %, DG II 116,7 %; Liquidität I/II/III 22,7 / 77,3 / 145,5 %.])[
#if not web [*Aufgabe 124* #linebreak()]
*Gegeben und Annahmen*

Bilanz in T€: Sachanlagen 520, Finanzanlagen 80, Vorräte 150, Forderungen 120, flüssige Mittel 50 (Summe 920). Gezeichnetes Kapital 250, Rücklagen 110, langfristiges FK 340, kurzfristiges FK 220 (Summe 920). Kennzahlen wie in der Formelsammlung: AI $="AV"/"GV"$, EK-Quote $="EK"/"GK"$, DG I $="EK"/"AV"$, DG II $=("EK"+"lgfr. FK")/"AV"$, Liquidität I–III mit flüssigen Mitteln, plus Forderungen, bzw. gesamtem UV im Zähler und kurzfristigem FK im Nenner.

*Gesucht*

#enum(numbering: "a)",
[Anlagenintensität und EK-Quote,],
[Deckungsgrade I und II; goldene Bilanzregel?],
[Liquidität I–III. Wo liegt das Problem?],
)
][
*Blöcke:* AV 600, UV 320, EK 360, lgfr. FK 340, kfr. FK 220 T€.
][
*a):* AI $600/920 approx "65,2" %$; EK-Quote $360/920 approx "39,1" %$.
][
*b):* DG I $360/600=60 %$; DG II $700/600 approx "116,7" %$ → goldene Bilanzregel eingehalten, weil EK plus langfristiges FK das AV übersteigen.
][
*c):* I $50/220 approx "22,7" %$, II $170/220 approx "77,3" %$, III $320/220 approx "145,5" %$. *Problem:* Liquidität II liegt unter 100 %: Flüssige Mittel und Forderungen reichen nicht für die kurzfristigen Schulden; erst wenn auch Vorräte verkauft werden, ist Deckung da. Langfristig solide finanziert, kurzfristig angespannt.
]

#aufgabe(titel: "Altklausur SS 13: Kennzahlen aus der GuV", art: "rechnen", quelle: "2.4.1", herkunft: "original", vorlage: "Altklausur SS 13, Aufg. 2", minuten: 15,
  ergebnis: [Jahresüberschuss 40 000 €; EK-Rentabilität 20 %; Unternehmensrentabilität ca. 13,5 %; Umsatzrendite ca. 6,7 %; Cashflow 175 000 €.])[
#if not web [*Aufgabe 125* #linebreak()]
*Gegeben und Annahmen*

Aus der Buchhaltung (in €): Umsatzerlöse 600 000; Materialaufwand 190 000; Personalaufwand 130 000; Fremdkapitalzinsen 25 000; Abschreibungen auf Sachanlagen 120 000; Zuführungen zu langfristigen Rückstellungen 15 000; Summe anderer Aufwendungen/Kosten 80 000. Durchschnittliches Eigenkapital 200 000; durchschnittliches Fremdkapital 280 000; durchschnittlicher Forderungsbestand 30 000. Der Gewinn (Jahresüberschuss) ist gesucht. Außerordentliche Posten gibt es keine, der bereinigte Jahresüberschuss ist also der Jahresüberschuss.

Formelsammlung: EK-Rentabilität $="ber. JÜ"/(diameter "EK")$; Unternehmensrentabilität $=("ber. JÜ"+"FK-Zinsen")/(diameter "GK")$; Umsatzrentabilität $="ber. JÜ"/E$; Cashflow $="JÜ"+"Abschreibungen"+"Zuführung lgfr. Rückstellungen"$.

*Gesucht*

#enum(numbering: "a)",
[Eigenkapitalrentabilität,],
[Unternehmensrentabilität. Warum wird diese Rendite berechnet?],
[Umsatzrendite. Was bedeutet das Ergebnis konkret?],
[Cashflow,],
[Formuliere allgemein, was der Cashflow inhaltlich darstellt und wozu er verwendet werden kann.],
)
][
*Gewinn bestimmen:* $"JÜ"=600 000-190 000-130 000-25 000-120 000-15 000-80 000=40 000$ €. Alle Aufwendungen inklusive FK-Zinsen sind abgezogen.
][
*a) EK-Rentabilität:* $40 000/200 000 dot 100 %=20 %$. Jeder Euro Eigenkapital hat 20 Cent Gewinn gebracht.
][
*b) Unternehmensrentabilität:* $(40 000+25 000)/(200 000+280 000) dot 100 % approx "13,5" %$. Die FK-Zinsen werden zurückaddiert, weil sie der „Lohn“ der Fremdkapitalgeber sind. *Warum:* Sie misst die Verzinsung des *gesamten* eingesetzten Kapitals, unabhängig davon, wie es finanziert ist – damit lassen sich Unternehmen mit unterschiedlicher Kapitalstruktur vergleichen, und man sieht, ob sich zusätzliches FK lohnt (Rendite > FK-Zins).
][
*c) Umsatzrendite:* $40 000/600 000 dot 100 % approx "6,7" %$: Von jedem Euro Umsatz bleiben knapp 7 Cent Gewinn.
][
*d) Cashflow:* $40 000+120 000+15 000=175 000$ €. Abschreibungen und Zuführungen zu langfristigen Rückstellungen haben den Gewinn gemindert, aber im Jahr kein Geld gekostet. Der Forderungsbestand wird hier nicht gebraucht.
][
*e) Aussage:* Der Cashflow ist der im Jahr *selbst erwirtschaftete Zahlungsüberschuss* aus der laufenden Tätigkeit (Innenfinanzierungskraft). Er steht für Investitionen, Schuldentilgung und Gewinnausschüttung zur Verfügung. *Typische Verwechslung:* Cashflow (Euro) ist keine Rendite (Prozent).
]

#aufgabe(titel: "Altklausur SS 13: Kennzahlen aus der GuV (Variante)", art: "rechnen", quelle: "2.4.1", herkunft: "variante", vorlage: "Altklausur SS 13, Aufg. 2", minuten: 12,
  ergebnis: [JÜ 55 000 €; EK-Rentabilität 22 %; Unternehmensrentabilität ca. 14,2 %; Umsatzrendite ca. 6,1 %; Cashflow 215 000 €.])[
#if not web [*Aufgabe 126* #linebreak()]
*Gegeben und Annahmen*

In €: Umsatzerlöse 900 000; Materialaufwand 310 000; Personalaufwand 260 000; FK-Zinsen 30 000; Abschreibungen 140 000; Zuführung zu langfristigen Rückstellungen 20 000; sonstiger Aufwand 85 000. Durchschnittliches EK 250 000, durchschnittliches FK 350 000. Keine außerordentlichen Posten. Formeln wie in der Formelsammlung (EK-Rentabilität $="JÜ"/(diameter "EK")$, Unternehmensrentabilität $=("JÜ"+"FK-Zinsen")/(diameter "GK")$, Umsatzrendite $="JÜ"/E$, Cashflow $="JÜ"+"Abschr."+"Zuführung lgfr. Rückst."$).

*Gesucht*

#enum(numbering: "a)",
[Jahresüberschuss,],
[EK-, Unternehmens- und Umsatzrentabilität,],
[Cashflow. Warum ist er größer als der Jahresüberschuss?],
)
][
*JÜ:* $900 000-310 000-260 000-30 000-140 000-20 000-85 000=55 000$ €.
][
*Renditen:* EK $55/250=22 %$; Unternehmen $(55+30)/600 approx "14,2" %$; Umsatz $55/900 approx "6,1" %$.
][
*Cashflow:* $55 000+140 000+20 000=215 000$ €. Größer, weil Abschreibungen und Rückstellungszuführungen den Gewinn mindern, ohne im Jahr Geld abfließen zu lassen.
]

#aufgabe(titel: "A14 II: Bilanzkennzahlen", art: "rechnen", quelle: "2.4.1", herkunft: "original", vorlage: "Altklausur WS 14/15, Aufg. II", minuten: 30,
  ergebnis: [EK-Rentabilität ca. 12,8 %, GK-Rentabilität ca. 7,3 %; FK-Quote ca. 56,1 %; Vorratsquote ca. 21,1 %; Deckungsgrad II 187,5 % (goldene Regel eingehalten, auch mit eisernem Vorrat: 145,2 %); Liquidität II 175 %.])[
#if not web [*Aufgabe 127* #linebreak()]
*Gegeben und Annahmen*

Aufbereitete Bilanz einer Kapitalgesellschaft (in TEUR):
#tab(columns: (2fr, 1fr, 2fr, 1fr),
 th([Aktiva], [TEUR], [Passiva], [TEUR]),
 [Sachanlagen], [2 700], [Gezeichnetes Kapital], [1 500],
 [Finanzanlagen], [900], [Gewinnrücklagen], [1 800],
 [Waren], [1 800], [Bilanzgewinn], [450],
 [Forderungen aus LuL], [1 500], [Langfristige Bankdarlehen], [3 000],
 [Bank], [1 200], [Verbindlichkeiten aus LuL], [1 800],
 [Kasse], [450], [], [],
 [Summe], [8 550], [Summe], [8 550],
)
FK-Zinsen des Jahres 150 TEUR. Der Bilanzgewinn wird nicht ausgeschüttet (er ist der Jahresgewinn). Eiserner Vorrat 1 050 TEUR. Eigenkapital des Vorjahres 3 300 TEUR, Bilanzsumme des Vorjahres 7 950 TEUR. Renditen auf Durchschnittskapital: EK-Rentabilität $="Gewinn"/(diameter "EK")$, GK-Rentabilität $=("Gewinn"+"FK-Zinsen")/(diameter "GK")$; FK-Quote $="FK"/"GK"$; Vorratsquote $="Vorräte"/"GV"$; DG II $=("EK"+"lgfr. FK")/"AV"$; Liquidität II $=("flüssige Mittel"+"Forderungen")/"kfr. FK"$.

*Gesucht*

#enum(numbering: "a)",
[EK- und GK-Rentabilität. Warum wird die GK-Rendite berechnet?],
[Fremdkapitalquote (Grad der Verschuldung),],
[Vorratsquote,],
[Deckungsgrad II. Ist die goldene Bilanzregel eingehalten?],
[Liquidität II mit Interpretation.],
)
][
*Blöcke:* EK $=1500+1800+450=3750$; FK $=3000+1800=4800$; AV $=3600$; flüssige Mittel $=1650$ TEUR.
][
*a) Renditen:* $diameter"EK"=(3750+3300)/2=3525$ → $450/3525 approx "12,8" %$. $diameter"GK"=(8550+7950)/2=8250$ → $(450+150)/8250 approx "7,3" %$. *Warum GK:* Sie zeigt, wie gut das *gesamte* Kapital arbeitet, unabhängig von der Finanzierung. Liegt sie über dem FK-Zinssatz (hier rund $150/4800 approx "3,1" %$), steigert zusätzliches FK die EK-Rendite (Leverage).
][
*b) und c):* FK-Quote $4800/8550 approx "56,1" %$. Vorratsquote $1800/8550 approx "21,1" %$.
][
*d) Deckung:* DG II $(3750+3000)/3600="187,5" %$. Goldene Bilanzregel *eingehalten*: Das langfristig gebundene AV ist langfristig finanziert. Selbst mit eisernem Vorrat (der ebenfalls dauerhaft gebunden ist): $6750/(3600+1050) approx "145,2" %$.
][
*e) Liquidität II:* $(450+1200+1500)/1800=175 %$. Die kurzfristigen Verbindlichkeiten sind durch flüssige Mittel und Forderungen 1,75-fach gedeckt → gute kurzfristige Zahlungsfähigkeit (Faustregel ≥ 100 %). Grenze: Stichtagsgröße, Forderungen könnten ausfallen.
]

#aufgabe(titel: "A14 II: Bilanzkennzahlen (Variante)", art: "rechnen", quelle: "2.4.1", herkunft: "variante", vorlage: "Altklausur WS 14/15, Aufg. II", minuten: 20,
  ergebnis: [EK-Rent. 16,0 %, GK-Rent. ca. 7,9 %; FK-Quote 65 %; Vorratsquote 25 %; DG II 120 %; Liquidität II 62,5 %.])[
#if not web [*Aufgabe 128* #linebreak()]
*Gegeben und Annahmen*

Bilanz in TEUR: Sachanlagen 900, Finanzanlagen 100, Vorräte 500, Forderungen 300, Bank/Kasse 200 (Summe 2 000). Gezeichnetes Kapital 400, Rücklagen 220, Jahresgewinn (nicht ausgeschüttet) 80, langfristige Darlehen 500, kurzfristige Verbindlichkeiten 800 (Summe 2 000). FK-Zinsen 70 TEUR. Vorjahr: EK 300, Bilanzsumme 1 800 TEUR. Formeln wie in der Originalaufgabe.

*Gesucht*

#enum(numbering: "a)",
[EK- und GK-Rentabilität,],
[FK-Quote und Vorratsquote,],
[Deckungsgrad II und Liquidität II mit kurzer Beurteilung.],
)
][
*Blöcke:* EK 700, FK 1 300, AV 1 000, flüssige Mittel 200 TEUR.
][
*a):* $diameter"EK"=500$ → $80/500=16,0 %$. $diameter"GK"=1900$ → $150/1900 approx "7,9" %$.
][
*b):* FK-Quote $1300/2000=65 %$; Vorratsquote $500/2000=25 %$.
][
*c):* DG II $(700+500)/1000=120 %$ → goldene Regel eingehalten. Liquidität II $(200+300)/800="62,5" %$ → kurzfristig angespannt: Ohne Verkauf der Vorräte reichen die Mittel nicht für die kurzfristigen Schulden.
]

#aufgabe(titel: "A18 III: Bilanzkennzahlen im Zweijahresvergleich", art: "rechnen", quelle: "2.4.1", herkunft: "original", vorlage: "Altklausur WS 18/19, Aufg. III", minuten: 10,
  ergebnis: [20X2: Anlagenintensität 61,8 %; EK-Quote 41,6 %; Verschuldungsgrad 140,2 %; EK-Rentabilität 8,7 %.])[
#if not web [*Aufgabe 129* #linebreak()]
*Gegeben und Annahmen*

Bilanzen der DRUBS GmbH zum 31.12. (in T€):
#tab(columns: (2.2fr, 1fr, 1fr, 2.2fr, 1fr, 1fr),
 th([Aktiva], [20X2], [20X1], [Passiva], [20X2], [20X1]),
 [Sachanlagen], [81 350], [71 210], [Gezeichnetes Kapital], [32 300], [28 900],
 [Finanzanlagen], [14 350], [20 220], [Kapitalrücklage], [10 650], [8 250],
 [RHB-Stoffe], [12 760], [13 980], [Gewinnrücklagen], [16 290], [12 700],
 [Unfertige/fertige Erzeugnisse], [16 440], [19 360], [Jahresüberschuss], [5 240], [6 120],
 [Forderungen], [21 900], [20 830], [Rückstellungen langfristig], [15 340], [11 480],
 [Bank, Kasse], [8 100], [9 600], [Rückstellungen kurzfristig], [6 700], [7 100],
 [], [], [], [Verbindlichkeiten langfristig], [55 290], [51 310],
 [], [], [], [Verbindlichkeiten kurzfristig], [13 090], [29 340],
 [Gesamtvermögen], [154 900], [155 200], [Gesamtkapital], [154 900], [155 200],
)
GuV-Auszug (T€): Umsatzerlöse 135 770 (20X2) / 142 920 (20X1); Zinsen und ähnliche Aufwendungen 5 160 / 6 940. Kennzahlen 20X1: Anlagenintensität 58,9 %, EK-Quote 36,1 %, Verschuldungsgrad 177,3 %, EK-Rentabilität 11,5 %. Formeln: AI $="AV"/"GV"$; EK-Quote $="EK"/"GK"$; Verschuldungsgrad $="FK"/"EK"$; EK-Rentabilität $="JÜ"/(diameter "EK")$ mit $diameter"EK"$ als Mittel aus Anfangs- und Endbestand.

*Gesucht*

#enum(numbering: "a)",
[Bestimme für 20X2 (eine Nachkommastelle) Anlagenintensität, EK-Quote, Verschuldungsgrad und EK-Rentabilität.],
[Welche Folgerungen ziehst Du im Vergleich mit 20X1?],
)
][
*Blöcke 20X2:* AV $=81 350+14 350=95 700$. EK $=32 300+10 650+16 290+5240=64 480$ (der nicht ausgeschüttete Jahresüberschuss gehört zum EK). FK $=15 340+6700+55 290+13 090=90 420$ (Rückstellungen sind Fremdkapital). Gegenprobe: $64 480+90 420=154 900$ ✓.
][
*Kennzahlen:* AI $95 700/154 900 approx "61,8" %$. EK-Quote $64 480/154 900 approx "41,6" %$. Verschuldungsgrad $90 420/64 480 approx "140,2" %$. EK-Rentabilität: $diameter"EK"=(64 480+55 970)/2=60 225$ → $5240/60 225 approx "8,7" %$.
][
*Kontrolle mit 20X1:* Dieselben Definitionen liefern für 20X1 58,9 %, 36,1 % und 177,3 % – genau die vorgegebenen Werte. So prüfst Du, ob Rückstellungen und Jahresüberschuss richtig zugeordnet sind. *Handschrift prüfen:* Die Randrechnung mit EK 59 240 lässt den Jahresüberschuss weg und ergibt deshalb zu niedrige Werte.
][
*b) Folgerungen:* Die Finanzierung ist solider geworden (EK-Quote 36,1 → 41,6 %, Verschuldungsgrad 177 → 140 %), auch weil kurzfristige Verbindlichkeiten stark abgebaut wurden. Die Anlagenintensität stieg (mehr Sachanlagen, weniger flexibel). Die EK-Rentabilität sank von 11,5 auf 8,7 %: weniger Gewinn bei mehr Eigenkapital, bei gleichzeitig gesunkenem Umsatz.
]

#aufgabe(titel: "A18 III: Bilanzkennzahlen (Variante)", art: "rechnen", quelle: "2.4.1", herkunft: "variante", vorlage: "Altklausur WS 18/19, Aufg. III", minuten: 10,
  ergebnis: [AI 58,3 %; EK-Quote 40,0 %; Verschuldungsgrad 150,0 %; EK-Rentabilität 13,3 %.])[
#if not web [*Aufgabe 130* #linebreak()]
*Gegeben und Annahmen*

Bilanz 20X2 in T€: Sachanlagen 60 000, Finanzanlagen 10 000, Vorräte 25 000, Forderungen 20 000, Bank 5 000 (Summe 120 000). Gezeichnetes Kapital 20 000, Rücklagen 22 000, Jahresüberschuss 6 000, Rückstellungen 12 000, langfristige Verbindlichkeiten 40 000, kurzfristige Verbindlichkeiten 20 000. EK Ende 20X1: 42 000 T€. Vergleichswerte 20X1: AI 55,0 %, EK-Quote 37,5 %, Verschuldungsgrad 166,7 %, EK-Rentabilität 12,0 %. Formeln wie in der Originalaufgabe.

*Gesucht*

#enum(numbering: "a)",
[die vier Kennzahlen für 20X2,],
[kurze Beurteilung der Entwicklung.],
)
][
*Blöcke:* AV 70 000; EK $20 000+22 000+6000=48 000$; FK $12 000+40 000+20 000=72 000$ T€.
][
*a):* AI $70/120 approx "58,3" %$; EK-Quote $48/120=40,0 %$; VG $72/48=150,0 %$; EK-Rent. $6000/45 000 approx "13,3" %$.
][
*b):* Mehr EK-Anteil und weniger Verschuldung, gleichzeitig höhere Rentabilität – eine günstige Entwicklung; die höhere Anlagenintensität macht das Unternehmen etwas unflexibler.
]

#aufgabe(titel: "A18 II: Intensitäten aus der GuV", art: "rechnen", quelle: "2.4.1", herkunft: "original", vorlage: "Altklausur WS 18/19, Aufg. II (lesbarer Teil)", minuten: 6,
  ergebnis: [Materialintensität 32,6 %, Personalintensität 25,3 %, Abschreibungsintensität 30,0 %.])[
#if not web [*Aufgabe 131* #linebreak()]
*Gegeben und Annahmen*

Gewinn-und-Verlust-Konto (in T€), Soll-Seite: Materialaufwand 890 (davon Rohstoffe 750), Personalaufwand 690 (davon Personalnebenkosten 160), Abschreibungen 820, sonstiger betrieblicher Aufwand 610, Zinsaufwand 10. Haben-Seite: Umsatzerlöse 2 730 sowie Bestandsveränderungen, aktivierte Eigenleistungen, sonstige betriebliche Erträge, Erträge aus Beteiligungen und Zinserträge. Formelsammlung: Material-, Personal-, Abschreibungsintensität $=$ jeweiliger Aufwand / Umsatzerlöse. Prozentangaben auf eine Nachkommastelle.

*Gesucht*

#enum(numbering: "a)",
[Material-, Personal- und Abschreibungsintensität.],
)
#text(size: 8.5pt)[Hinweis: Im Scan ist die Haben-Seite abgeschnitten; der Umsatz 2 730 T€ stammt aus Deiner Randrechnung. Umsatzrentabilität und Cashflow aus der Originalaufgabe lassen sich deshalb hier nicht rechnen – sie übst Du in der Variante.]
][
*Bezugsgröße:* Laut Formelsammlung immer die Umsatzerlöse – so wird jede Aufwandsart als Anteil am Umsatz vergleichbar.
][
*Rechnen:* Material $890/2730 approx "32,6" %$; Personal $690/2730 approx "25,3" %$; Abschreibungen $820/2730 approx "30,0" %$.
][
*Deuten:* Knapp ein Drittel des Umsatzes wird für Material, ein weiteres knappes Drittel für Abschreibungen aufgewandt – ein sehr anlagenintensives Unternehmen.
]

#aufgabe(titel: "A18 II: Kennzahlen aus der GuV (Variante)", art: "rechnen", quelle: "2.4.1", herkunft: "variante", vorlage: "Altklausur WS 18/19, Aufg. II (lesbarer Teil)", minuten: 10,
  ergebnis: [JÜ 260 T€; Umsatzrentabilität 8,1 %; Cashflow 690 T€; Intensitäten 40,6 / 28,1 / 12,5 %.])[
#if not web [*Aufgabe 132* #linebreak()]
*Gegeben und Annahmen*

GuV in T€. Aufwand: Material 1 300 (davon Rohstoffe 1 050), Personal 900 (davon Personalnebenkosten 210), Abschreibungen 400, sonstiger betrieblicher Aufwand 450 (darin 30 Zuführung zu langfristigen Rückstellungen), Zinsaufwand 70. Ertrag: Umsatzerlöse 3 200, Bestandserhöhung 100, sonstige betriebliche Erträge 60, Zinserträge 20. Keine außerordentlichen Posten. Formelsammlung: Umsatzrentabilität $="ber. JÜ"/E$; Cashflow $="JÜ"+"Abschreibungen"+"Zuführung lgfr. Rückstellungen"$; Intensitäten $="Aufwand"/"Umsatzerlöse"$.

*Gesucht*

#enum(numbering: "a)",
[Jahresüberschuss und Umsatzrentabilität,],
[Cashflow (indirekt),],
[Material-, Personal- und Abschreibungsintensität.],
)
][
*a):* Erträge 3 380, Aufwand 3 120 → JÜ 260 T€. Umsatzrentabilität $260/3200 approx "8,1" %$.
][
*b):* $260+400+30=690$ T€.
][
*c):* $1300/3200 approx "40,6" %$; $900/3200 approx "28,1" %$; $400/3200="12,5" %$.
]

#aufgabe(titel: "Investitionsverfahren: unterschiedliche Empfehlungen erklären", herkunft: "eigen", art: "verstehen", quelle: "2.5")[
#if not web [*Aufgabe 133* #linebreak()]
Erkläre in eigenen Worten, weshalb ein Ofen mit höherem Jahresgewinn trotzdem eine längere Amortisationszeit haben kann. Welche Frage beantworten KVR, GVR, RVR und AVR jeweils? Warum genügt eine einzelne Kennzahl nicht für jedes Investitionsurteil?
#src[B31, Aufgaben 23–27, PDF-S. 1–5; S32, PDF-S. 1–3; eigene Zusammenführung.]
][
*Fragen unterscheiden:* KVR: Welche vergleichbare Leistung kostet weniger? GVR: Welche Alternative liefert mehr Jahresgewinn? RVR: Wie hoch ist der passende Jahreserfolg bezogen auf die durchschnittliche Kapitalbindung? AVR: Nach welcher Zeit ist der eingesetzte Betrag rechnerisch ausgeglichen?
][
*Zusammenhang erklären:* Ein höherer Gewinn erhöht den Rückfluss, ein höherer Kaufbetrag erhöht aber zugleich den zurückzugewinnenden Betrag. Wenn der Kaufbetrag stärker steigt, kann die Zeit länger sein. Back de luxe liefert deshalb in B31 mehr Gewinn, amortisiert sich aber später.
][
*Grenzen nennen:* Mengen, Erlöse, Kapitalbasis und Gewinn-/Rückflussabgrenzung müssen passen. Die AVR ignoriert den späteren Erfolg; die KVR ignoriert Preisunterschiede. Statische Jahresdurchschnitte bilden außerdem keine zeitlich genaue Zahlungsfolge ab.
][
*Ergänzung · Backofen-Zahlen:* Normalo amortisiert sich in etwa 1,94 Jahren, Back de luxe in 2,14 Jahren. Richtig ist: Normalo ist nach dem Amortisationskriterium besser, und Back de luxe kann trotzdem den höheren Jahresgewinn erzielen. Falsch wäre: „Normalo ist damit automatisch über die ganze Nutzungsdauer gewinnreicher.“ Eine kurze Amortisationszeit sagt nicht, wie viel Erfolg danach noch entsteht, und die genaue zeitliche Lage der Zahlungen geht in die statische Durchschnittsmethode nicht ein; deshalb ergänzt sie ein Gewinn- oder Rentabilitätsurteil.

*Merksatz:* Mehr Gewinn kann trotzdem längere Rückgewinnung bedeuten.
]

#aufgabe(titel: "Rückfluss in der Amortisationsrechnung", art: "verstehen", quelle: "2.5", herkunft: "eigen")[
#if not web [*Aufgabe 134* #linebreak()]
Welche Rückflussgröße verwendet die Backofen-Mitschrift für die AVR, und warum wird die Abschreibung zum Gewinn addiert?
][
*Konvention:* GVR-Gewinn plus Abschreibung, $G+A$. Die Abschreibung hat den Gewinn gemindert, ist im jeweiligen Jahr aber keine Auszahlung. Weil der Gewinn dabei schon nach kalkulatorischen Zinsen abgegrenzt ist, musst Du die Konvention benennen. *Typische Verwechslungen:* nur der Gewinn (Abschreibung fehlt) oder Erlös plus Anschaffungskosten.
]

#aufgabe(titel: "Gewinn plus Abschreibung ist kein geprüfter Cashflow", art: "verstehen", quelle: "2.5", herkunft: "eigen")[
#if not web [*Aufgabe 135* #linebreak()]
Warum darf man den Rückfluss „Gewinn plus Abschreibung“ nicht ohne Prüfung als tatsächlichen Cashflow bezeichnen?
][
*Abgrenzung:* Es kommt auf die Gewinnabgrenzung an. In der Backofen-Mitschrift enthält der Gewinn bereits kalkulatorische Zinsen als Abzug. Für einen Rückfluss vor diesen rein kalkulatorischen Zinsen wäre (bei sonst zahlungswirksamen Positionen) auch $Z$ zurückzuaddieren, also $G+A+Z$. Man muss die Konvention nennen und durchhalten.
]

#aufgabe(titel: "Backofen 27: Amortisationszeiten vergleichen", herkunft: "original", vorlage: "Backofen-Blatt 031, Aufg. 27", minuten: 10, art: "rechnen", quelle: "2.5", ergebnis: [B31-Konvention: Normalo ca. 1,94 Jahre, Back ca. 2,14 Jahre.])[
#if not web [*Aufgabe 136* #linebreak()]
*Gegeben und Annahmen*

#tab(columns: (2fr, 1fr, 1fr),
 th([Jahresdaten], [Normalo-Back], [Back de luxe]),
 [Anschaffungskosten €], [18 000], [32 000],
 [Nutzungsdauer / Restwert], [5 Jahre / 0 €], [5 Jahre / 0 €],
 [Kalkulationszins pro Jahr], [8 %], [8 %],
 [Material €/Brötchen], [0,10], [0,08],
 [Variable Energie €/Brötchen], [0,02], [0,01],
 [Fixe Energie €/Jahr], [1 500], [1 900],
 [Reparaturen €/Jahr], [1 000], [2 000],
 [Raumkosten €/Jahr], [500], [850],
)
Lineare Abschreibung, mittlere Kapitalbindung $(A K+R W)/2$, konstante Jahreswerte. Produzierte Mengen werden vollständig verkauft. Sonstige Steuern und zusätzliche Zahlungen werden nicht angesetzt.
Jahresmenge je 100 000 Stück, Nettopreise 0,25 / 0,30 €. Geprüfte Gewinne nach kalkulatorischen Zinsen: Normalo 5 680 €/Jahr, Back 8 570 €/Jahr. Diese Gewinne sind Durchschnittswerte. Verwende wie B31 den Rückfluss $G+A$; keine Differenzinvestition.

*Gesucht*

#enum(numbering: "a)",
[Berechne Rückfluss und Amortisationszeit beider Öfen.],
[Prüfe die Nutzungsdauer und erkläre den Unterschied zur Gewinnentscheidung.],
)
#src[B31, Aufgabe 27, PDF-S. 1 und 4; Abgrenzung ergänzend erklärt.]
][
*Rückflusskonvention wählen:* In B31 wird die Abschreibung zum gegebenen Gewinn zurückaddiert. Normalo $A=3600$, Back $A=6400$ €/Jahr. Abschreibung ist Wertverbrauch, keine laufende Auszahlung.
][
*Rückflüsse bestimmen:* Normalo $r_N=5680+3600=9280$ €/Jahr; Back $r_B=8570+6400=14970$ €/Jahr. Es sind vereinfachte Rückflüsse nach kalkulatorischen Zinsen, keine ungeprüft gleichzusetzenden Zahlungsüberschüsse.
][
*Zeiten berechnen:* $t_N=18000/9280 approx "1,9397"$ Jahre; $t_B=32000/14970 approx "2,1376"$ Jahre. Nach diesem Kriterium wird *Normalo* bevorzugt.
][
*Prüfen und einordnen:* Beide Zeiten liegen unter fünf Jahren. Back hat zwar einen höheren Jahresgewinn, muss aber einen deutlich größeren Kaufbetrag zurückverdienen. Die AVR bewertet die Rückgewinnungszeit; Gewinne nach dieser Zeit gehen nicht in die Kennzahl ein. Bei der ausdrücklich anderen Abgrenzung vor kalkulatorischen Zinsen wären $G+A+Z$ und damit 1,80 bzw. etwa 1,97 Jahre anzusetzen.
]

#aufgabe(titel: "Backofen 27: Amortisation (Variante)", art: "rechnen", quelle: "2.5", herkunft: "variante", vorlage: "Backofen-Blatt 031, Aufg. 27", minuten: 8,
  ergebnis: [Standard ca. 3,30 Jahre, Premium ca. 3,22 Jahre → Premium knapp schneller.])[
#if not web [*Aufgabe 137* #linebreak()]
*Gegeben und Annahmen*

Standard: AK 24 000 €, RW 0, $A=4000$ €/Jahr, $G=3280$ €/Jahr. Premium: AK 40 000 €, RW 4 000 €, $A=6000$ €/Jahr, $G=5180$ €/Jahr. Nutzungsdauer je 6 Jahre. Rückfluss wie im Backofen-Blatt: $G+A$; $t=(A K-R W)/(G+A)$.

*Gesucht*

#enum(numbering: "a)",
[Amortisationszeiten und Urteil.],
)
][
*Rückflüsse:* Standard $7280$, Premium $11 180$ €/Jahr.
][
*Zeiten:* Standard $24 000/7280 approx "3,30"$ Jahre; Premium $36 000/11 180 approx "3,22"$ Jahre.
][
*Urteil:* Premium knapp schneller, beide deutlich unter 6 Jahren. Anders als beim Backofen gewinnt hier die teurere Anlage auch die AVR, weil der Restwert den zurückzugewinnenden Betrag senkt.
]

#aufgabe(titel: "Ganzzahlige Bereiche an der kritischen Menge", art: "verstehen", quelle: "2.6", herkunft: "eigen")[
#if not web [*Aufgabe 138* #linebreak()]
Zwei Kostenlinien schneiden sich bei exakt 10 967,7419 Stück/Jahr; Objekt 1 ist rechts davon günstiger. Welcher Bereich gilt bei ganzen Stückzahlen, und warum sind „bei 10 968 gleich teuer“ und „Objekt 1 erst ab 10 969“ falsch?
][
*Antwort:* Objekt 2 bis einschließlich 10 967, Objekt 1 ab 10 968, denn 10 968 liegt schon rechts der exakten Grenze (Objekt 1 dort 0,40 € günstiger). Gleich teuer sind beide nur am nicht ganzzahligen Schnittpunkt; „ab 10 969“ überspringt die erste günstigere Menge.
]

#aufgabe(titel: "Kritische Menge ist keine Gewinnschwelle", art: "verstehen", quelle: "2.6", herkunft: "eigen")[
#if not web [*Aufgabe 139* #linebreak()]
An einer kritischen Kostenmenge sind die Kosten zweier Anlagen gleich. Ist dort automatisch der Gewinn null? Was unterscheidet beide Schnittpunkte?
][
*Nein:* Gleichgesetzt werden die Kosten *zweier Anlagen*, nicht Erlös und Kosten *einer* Anlage. Am Kosten-Schnittpunkt können beide Anlagen Gewinn, null oder Verlust erzielen. Nur die Gewinnschwelle verlangt Erlös = Kosten.

*Merksatz:* Kritische Menge vergleicht Anlagen; Gewinnschwelle vergleicht Erlös und Kosten.
#bild("kritische-auslastung", [Kostenvergleich mit kritischer Menge.], height: 45mm)
]

#aufgabe(titel: "Steigung aus variablen Jahreskosten", art: "verstehen", quelle: "2.6", herkunft: "eigen")[
#if not web [*Aufgabe 140* #linebreak()]
Bei 20 000 Stück entstehen 295 000 € variable Jahreskosten. Welche Steigung gehört in die lineare Kostenfunktion, und warum musst Du vorher umrechnen?
][
*Antwort:* $295 000/20 000="14,75"$ €/Stück. Die Steigung wird mit der Stückzahl multipliziert und muss deshalb Euro je Stück sein; ein Jahresgesamtbetrag enthält die Menge schon. *Typische Verwechslungen:* 295 000 €/Stück (Menge doppelt berücksichtigt) oder 20 000 (die Stückzahl selbst).

*Merksatz:* Die Steigung braucht Euro je Stück, keinen Jahresgesamtbetrag.
]

#aufgabe(titel: "Gleiche kritische Menge in KVR und GVR", art: "verstehen", quelle: "2.6", herkunft: "eigen")[
#if not web [*Aufgabe 141* #linebreak()]
Wann haben Kostenvergleich und Gewinnvergleich dieselbe kritische Menge, und was musst Du bei verschiedenen Preisen tun?
][
*Gleicher Stückerlös:* Erzielen beide Alternativen bei derselben Menge denselben Stückerlös, fällt der Erlös beim Gleichsetzen der Gewinne heraus – die kritische Menge ist dieselbe. Bei verschiedenen Preisen müssen die Gewinnfunktionen mit ihren eigenen Erlösen gleichgesetzt werden (Beispiel Datei 12: Kosten gleich bei 6 250, Gewinne gleich bei 5 000 Stück).
]

#aufgabe(titel: "Kritische Auslastung: 47 000 und 30 000 Euro Fixkosten", herkunft: "original", vorlage: "Datei 04 (kritische Auslastung)", minuten: 15, art: "rechnen", quelle: "2.6", ergebnis: [Exakt 10 967,7419… Stück/Jahr; Objekt 1 ab 10 968 günstiger.])[
#if not web [*Aufgabe 142* #linebreak()]
*Gegeben und Annahmen*

Objekt 1: Fixkosten 47 000 €/Jahr, variable Gesamtkosten 295 000 €/Jahr bei 20 000 Stück/Jahr. Objekt 2: Fixkosten 30 000 €/Jahr, variable Gesamtkosten 326 000 €/Jahr bei derselben Menge. Beide Kostenstrukturen sind linear und im untersuchten Bereich gültig. Leistung gleichwertig; Mengen 6 000, 18 000 und 20 000 Stück/Jahr sind für beide möglich und absetzbar.

*Gesucht*

#enum(numbering: "a)",
[Ermittle die beiden Kostenfunktionen und die exakte kritische Jahresmenge.],
[Entscheide bei ganzen Stückzahlen sowie bei 6 000, 18 000 und 20 000 Stück.],
[Zeichne die Kostenlinien und unterscheide den Schnittpunkt vom BEP.],
)
#src[KR, PDF-S. 1–3; Rundung und Randnotiz selbst geprüft.]
][
*Einheiten herstellen:* $k_(v,1)=295000/20000="14,75"$ €/Stück; $k_(v,2)=326000/20000="16,30"$ €/Stück. Deshalb $K_1=47000+"14,75"x$, $K_2=30000+"16,30"x$, jeweils €/Jahr.
][
*Gleichsetzen:* $47000+"14,75"x=30000+"16,30"x => x=17000/"1,55"="10967,7419…"$ Stück/Jahr. Der Schnittpunkt hat etwa 208 774,19 €/Jahr Kosten.
][
*Ganze Mengen richtig zuordnen:* $K_1-K_2=17000-"1,55"x$. Bei 10 967: +1,15 €, Objekt 2 günstiger; bei 10 968: −0,40 €, Objekt 1 günstiger. Gleichheit besteht nur an der exakten nicht ganzzahligen Grenze.
][
*Testmengen:* Bei 6 000: $K_1=135500$, $K_2=127800$ €, also Objekt 2. Bei 18 000: $K_1=312500$, $K_2=323400$ €, also Objekt 1. Bei 20 000: 342 000 gegenüber 356 000 €, also Objekt 1 mit 14 000 € Vorteil.
][
*Grafik und Bedeutung:*
#bild("kritische-auslastung", [Eigene Darstellung nach KR, PDF-S. 2–3.], height: 57mm)
Beide Linien sind Kostenfunktionen, keine ist eine Erlösfunktion. Der Schnittpunkt ist ein Wechsel des Kostenvorteils und sagt nicht, dass ein Gewinn null wäre.
]

#aufgabe(titel: "Blatt 09.1: Investitionsobjekte und kritische Menge", herkunft: "original", vorlage: "Blatt 09 (Controlling-Aufgaben), Aufg. 1", minuten: 12, art: "rechnen", quelle: "2.6")[
#if not web [*Aufgabe 143* #linebreak()]
*Gegeben und Annahmen*

Beide Objekte haben 20 000 Stück/Jahr Kapazität und erlösen netto 18 €/Stück. Objekt 1: vollständige Fixkosten 32 500 €/Jahr, variable Kosten 14 €/Stück. Objekt 2: vollständige Fixkosten 29 000 €/Jahr, variable Kosten 14,25 €/Stück. Kosten linear, keine weiteren Kosten; alle produzierten Stücke sind absetzbar. Für den ersten Vergleich wird volle Kapazitätsauslastung angenommen, da keine andere Planmenge genannt ist.

*Gesucht*

#enum(numbering: "a)",
[Vergleiche Kosten und Gewinne bei Vollauslastung.],
[Bestimme die kritische Menge und den jeweils günstigeren Bereich.],
)
#src[C09, Aufgabe 1, PDF-S. 1–2; Vergleichsannahme und Bereichseinordnung ausdrücklich ergänzt.]
][
*Vergleichsmenge ausdrücklich festlegen:* Kapazität allein ist noch keine Planmenge. Hier wird wie in der Mitschrift zunächst mit $x=20000$ Stück/Jahr gerechnet.
][
*Jahresvergleich:* $E_1=E_2=18 dot 20000=360000$ €/Jahr. $K_1=32500+14 dot 20000=312500$, $K_2=29000+"14,25" dot 20000=314000$ €/Jahr. Daher $G_1=+47500$, $G_2=+46000$ €/Jahr; Objekt 1 ist um 1 500 € besser.
][
*Kritische Menge:* $32500+14x=29000+"14,25"x => "0,25"x=3500 => x=14000$ Stück/Jahr. Gleichwertige Erlöse fallen im Vergleich der Gewinne heraus.
][
*Prüfen und entscheiden:* Bei 14 000 Stück kosten beide 228 500 €, erlösen 252 000 € und gewinnen *23 500 €*. Das ist kein BEP. Unter 14 000 ist Objekt 2 günstiger, darüber bis Kapazität Objekt 1. Ohne Planmenge ist eine allgemeingültige Wahl nicht möglich.
]

#aufgabe(titel: "Blatt 09.1: Kritische Menge (Variante)", art: "rechnen", quelle: "2.6", herkunft: "variante", vorlage: "Blatt 09 (Controlling-Aufgaben), Aufg. 1", minuten: 10,
  ergebnis: [Bei 15 000 Stück $G_1=60 000$, $G_2=58 500$ €; $x_"krit"=12 000$ Stück/Jahr.])[
#if not web [*Aufgabe 144* #linebreak()]
*Gegeben und Annahmen*

Zwei Objekte, je 15 000 Stück/Jahr Kapazität, Erlös 25 €/Stück. Objekt 1: Fixkosten 45 000 €/Jahr, $k_v$ 18,00 €. Objekt 2: Fixkosten 39 000 €/Jahr, $k_v$ 18,50 €. Vollauslastung, alle Stück absetzbar.

*Gesucht*

#enum(numbering: "a)",
[Gewinne bei Vollauslastung,],
[kritische Menge und Bereiche.],
)
][
*a):* $E=375 000$ €; $K_1=315 000$, $K_2=316 500$ € → $G_1=60 000$, $G_2=58 500$ €.
][
*b):* $45 000+18x=39 000+"18,5"x => x=12 000$. Unter 12 000 Objekt 2, darüber Objekt 1. Bei 12 000 Gewinn beider 39 000 € – kein BEP.
]

#aufgabe(titel: "Blatt 09.2: Erweiterungsmaschine und Auslastungswechsel", herkunft: "original", vorlage: "Blatt 09 (Controlling-Aufgaben), Aufg. 2", minuten: 20, art: "rechnen", quelle: "2.6", ergebnis: [a bei 12 000 und 8 000; kritische Menge ca. 7 344,83 Stück/Jahr.])[
#if not web [*Aufgabe 145* #linebreak()]
*Gegeben und Annahmen*

Zwei Maschinen: je 8 Jahre Nutzungsdauer, 12 000 Stück/Jahr Kapazität, Nettopreis 8 €/Stück. Kapitaldienst und Betriebskosten sind bei Vollauslastung gegeben; Kapitaldienst bleibt fix. In den Betriebskosten enthaltene Fixanteile gelten auch bei anderen Mengen, der Rest ist proportional.
#tab(columns: (2fr,1fr,1fr), th([Daten], [a], [b]),
 [Anschaffung €], [80 000], [70 000],
 [Kapitaldienst €/Jahr], [14 000], [12 250],
 [Betriebskosten bei 12 000 €/Jahr], [62 000], [66 000],
 [davon fix €/Jahr], [3 400], [1 600],
)
Die genannten Kapitaldienste enthalten Abschreibung und Zinsen vollständig; sie werden nicht erneut berechnet. Alle hergestellten Stücke werden verkauft.

*Gesucht*

#enum(numbering: "a)",
[Beurteile Angebot a allein und im Vergleich mit b bei 12 000 Stück/Jahr.],
[Berechne Gewinne bei 8 000 Stück/Jahr.],
[Ermittle die kritische Menge rechnerisch und grafisch.],
)
#src[C09, Aufgabe 2 a–d, PDF-S. 1–3 und 5. Fehlende c-Lösung ergänzt, Rundungs-/Vorzeichenfehler sichtbar korrigiert.]
][
*Vollauslastung:* Gemeinsamer Erlös $8 dot 12000=96000$ €/Jahr. $K_a=14000+62000=76000$, $K_b=12250+66000=78250$ €/Jahr. Gewinne +20 000 und +17 750 €/Jahr. Angebot a verdient unter diesen Annahmen einen positiven Gewinn und ist relativ zu b um 2 250 €/Jahr besser.
][
*Kostenfunktionen aufbauen:* $K_(f,a)=14000+3400=17400$, $K_(f,b)=12250+1600=13850$ €/Jahr. $k_(v,a)=(62000-3400)/12000=293/60="4,88333…"$ €/Stück; $k_(v,b)=(66000-1600)/12000=161/30="5,36666…"$ €/Stück. Brüche bis zum Ende behalten.
][
*8 000 Stück:* $E=64000$ €/Jahr. $K_a=17400+(293/60) dot 8000 approx "56466,67"$, $K_b=13850+(161/30) dot 8000 approx "56783,33"$ €/Jahr. Somit $G_a approx +"7533,33"$, $G_b approx +"7216,67"$ €/Jahr. a ist um etwa 316,67 € besser.
][
*Kritische Menge:* $17400+(293/60)x=13850+(161/30)x$. Also $3550=(29/60)x$ und $x=213000/29 approx "7344,8276"$ Stück/Jahr. Bei ganzen Mengen ist b bis 7 344 günstiger, a ab 7 345.
][
*Grafik und Quellenprüfung:*
#bild("kritisch-erweiterung", [Eigene Darstellung nach C09, PDF-S. 1, 3 und 5.], height: 57mm)
Der Schnittpunkt liegt innerhalb beider Kapazitäten. Die Mitschrift rundet die Steigungen früh auf 4,88 und 5,37 und erhält etwa 7 245. Das ist eine Rundungsverschiebung; mit ungerundeten Werten gilt 7 344,8276. Für Gewinn gilt zudem $G=e x-K_f-k_v x$: Das Plus vor $k_v x$ auf S. 5 ist ein Vorzeichenfehler.
][
*Gegenprobe:* Bei 12 000 liefern die Funktionen wieder 76 000 und 78 250 €/Jahr. Am Schnittpunkt liefern beide denselben Gewinn von etwa 5 491,38 €/Jahr; auch dieser Schnittpunkt ist kein Nullgewinn.
]

#aufgabe(titel: "Blatt 09.2: Erweiterungsmaschine (Variante)", art: "rechnen", quelle: "2.6", herkunft: "variante", vorlage: "Blatt 09 (Controlling-Aufgaben), Aufg. 2", minuten: 18,
  ergebnis: [Bei 10 000: a +35 000, b +34 000 €; bei 6 000: a +13 400, b +14 600 €; $x_"krit" approx 8 181,8$ Stück/Jahr.])[
#if not web [*Aufgabe 146* #linebreak()]
*Gegeben und Annahmen*

Zwei Maschinen, je 6 Jahre, Kapazität 10 000 Stück/Jahr, Preis 12 €/Stück. Kapitaldienst a 15 000 €, b 12 000 €/Jahr (fix). Betriebskosten bei 10 000 Stück: a 70 000 € (davon fix 4 000 €), b 74 000 € (davon fix 2 500 €); der Rest ist proportional. Alles wird verkauft.

*Gesucht*

#enum(numbering: "a)",
[Gewinne bei 10 000 Stück,],
[Gewinne bei 6 000 Stück,],
[kritische Menge.],
)
][
*Kostenfunktionen:* $K_(f,a)=19 000$, $k_(v,a)=66 000/10 000="6,60"$; $K_(f,b)=14 500$, $k_(v,b)="7,15"$ €.
][
*a):* $E=120 000$; $K_a=85 000$, $K_b=86 000$ → $G_a=35 000$, $G_b=34 000$ €.
][
*b):* $E=72 000$; $K_a=58 600$, $K_b=57 400$ → $G_a=13 400$, $G_b=14 600$ € – jetzt b besser.
][
*c):* $19 000+"6,6"x=14 500+"7,15"x => x=4500/"0,55" approx 8181,8$ Stück/Jahr; ganzzahlig b bis 8 181, a ab 8 182.
]

#aufgabe(titel: "A18 IV: Kritische Auslastung Spritzguss oder Drehen", art: "rechnen", quelle: "2.6", herkunft: "original", vorlage: "Altklausur WS 18/19, Aufg. IV (Investitionsrechnung)", minuten: 10,
  ergebnis: [$x_"krit"=2 750$ Stück/Monat; bei 3 200 Stück Spritzguss 43 600 € < Drehmaschine 45 400 € → Spritzguss.])[
#if not web [*Aufgabe 147* #linebreak()]
*Gegeben und Annahmen*

Ein Zulieferer kann ein Bauteil im Spritzgussverfahren oder auf einer Drehmaschine herstellen. Geplanter Absatz 3 200 Bauteile/Monat.
#tab(columns: (2fr, 1fr, 1fr),
 th([€], [Spritzguss], [Drehmaschine]),
 [Fixkosten pro Monat], [18 000,00], [7 000,00],
 [Variable Stückkosten], [8,00], [12,00],
)

*Gesucht*

#enum(numbering: "a)",
[Ermittle die monatliche kritische Auslastung (Rechenweg nachvollziehbar).],
[Für welches Verfahren entscheidest Du Dich bei 3 200 Bauteilen/Monat? Begründe.],
)
][
*a) Gleichsetzen:* $18 000+8x=7000+12x => 4x=11 000 => x_"krit"=2750$ Stück/Monat.
][
*b) Bei 3 200 Stück:* Spritzguss $18 000+8 dot 3200=43 600$ €, Drehmaschine $7000+12 dot 3200=45 400$ €.
][
*Entscheiden:* 3 200 > 2 750, also lohnt der höhere Fixkostenblock wegen 4 € geringerer Stückkosten: *Spritzguss*, 1 800 €/Monat günstiger. Bei gleicher Qualität und gleichem Erlös genügt der Kostenvergleich.
]

#aufgabe(titel: "A18 IV: Kritische Auslastung (Variante)", art: "rechnen", quelle: "2.6", herkunft: "variante", vorlage: "Altklausur WS 18/19, Aufg. IV (Investitionsrechnung)", minuten: 8,
  ergebnis: [$x_"krit"=3 500$ Stück/Monat; bei 4 000 Laser (24 000 €), bei 3 000 Stanze (20 000 €).])[
#if not web [*Aufgabe 148* #linebreak()]
*Gegeben und Annahmen*

Laserschneiden: Fixkosten 12 000 €/Monat, 3 €/Stück. Stanzen: Fixkosten 5 000 €/Monat, 5 €/Stück. Gleiche Qualität.

*Gesucht*

#enum(numbering: "a)",
[kritische Menge,],
[Entscheidung bei 4 000 und bei 3 000 Stück/Monat.],
)
][
*a):* $12 000+3x=5000+5x => x=3500$ Stück/Monat.
][
*b):* 4 000: Laser 24 000 €, Stanze 25 000 € → Laser. 3 000: Laser 21 000 €, Stanze 20 000 € → Stanze. Die Entscheidung kippt an der kritischen Menge.
]
