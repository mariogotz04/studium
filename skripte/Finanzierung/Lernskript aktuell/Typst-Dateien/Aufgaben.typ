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


#kapitel("Kapitel 1 · Grundlagen der Finanzplanung")

// 0-1
#aufgabe(titel: "Ziele der Finanzierung und Sachziel", art: "verstehen", quelle: "1.1")[
#if not web [*Aufgabe 1* #linebreak()]
#text("Nenne die drei Ziele der Finanzierung und das Sachziel mit seinen vier „richtig“.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A1. Verfahren: #stelle(<a-1-1>).]
][
#text("Gewinn/Rentabilität, Liquidität, Sicherheit. Sachziel: finanzielle Mittel im notwendigen Umfang, in der erforderlichen Art, zum richtigen Zeitpunkt, am richtigen Ort.")
]

// 0-2
#aufgabe(titel: "Das magische Dreieck", art: "verstehen", quelle: "1.1")[
#if not web [*Aufgabe 2* #linebreak()]
#text("Erkläre das magische Dreieck. Nenne zu jeder Ecke ein Beispiel, warum sie mit einer anderen in Konflikt steht.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A2. Verfahren: #stelle(<a-1-1>).]
][
#text("Rentabilität, Sicherheit, Liquidität lassen sich nicht gleichzeitig maximieren. Rentabel ↔ sicher: hohe Rendite meist mit hohem Risiko (Aktien vs. Sparbuch). Liquide ↔ rentabel: Bargeld bringt keine Zinsen. Sicher ↔ rentabel: sichere Anlagen bringen wenig. Wo man sich einordnet, hängt von der Risikoaversion ab.")
]

// 0-3
#aufgabe(titel: "Außen- und Innenfinanzierung definieren", art: "verstehen", quelle: "1.2")[
#if not web [*Aufgabe 3* #linebreak()]
#text("Definiere Außen- und Innenfinanzierung in je einem Satz.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A3. Verfahren: #stelle(<a-1-2>).]
][
#text("Außen: Mittel kommen über Finanzierungsverträge von Kapitalgebern außerhalb des Unternehmens. Innen: Mittel entstehen bzw. verbleiben durch Vorgänge innerhalb des Unternehmens (einbehaltene Gewinne, Abschreibungen, Rückstellungen).")
]

// 0-4
#aufgabe(titel: "Vier Unterschiede: außen und innen", art: "verstehen", quelle: "1.2")[
#if not web [*Aufgabe 4* #linebreak()]
#text("Nenne die vier Unterschiede zwischen Außen- und Innenfinanzierung.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A4. Verfahren: #stelle(<a-1-2>).]
][
#text("(1) Kapitalgeber außerhalb vs. Vorgänge innerhalb; (2) Beträge exakt festgelegt vs. Höhe zum Teil ungewiss; (3) Fristen exakt vs. zum Teil ungewiss; (4) Einzelakte zu vereinbarten Zeitpunkten vs. laufend, oft erst am Periodenende erkennbar.")
]

// 0-5
#aufgabe(titel: "Es kommt auf die Gegenleistung an", art: "verstehen", quelle: "1.2")[
#if not web [*Aufgabe 5* #linebreak()]
#text("„Es kommt immer auf die Gegenleistung an.“ Erkläre den Satz anhand von Zins, Gewinn, Rückzahlung, Stimmrechten und Kündigungsrecht.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A5. Verfahren: #stelle(<a-1-2>).]
][
#text("FK-Geber erhalten Zins, Rückzahlung und ein Kündigungsrecht, aber keinen Gewinnanteil und keine Stimmrechte. EK-Geber erhalten Gewinnanteil und Stimmrechte, aber keinen Zins und keinen Anspruch auf Rückzahlung. Ob etwas EK oder FK ist, entscheidet also die vereinbarte Gegenleistung.")
]

// 0-6
#aufgabe(titel: "Einfluss der Bank ohne Leitungsrechte", art: "verstehen", quelle: "1.2")[
#if not web [*Aufgabe 6* #linebreak()]
#text("Warum kann eine Bank faktisch Einfluss auf ein Unternehmen nehmen, obwohl Fremdkapitalgeber keine Leitungsrechte haben?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A6. Verfahren: #stelle(<a-1-2>).]
][
#text("Über die Kündigungsdrohung: Wenn die Bank den Kredit kündigen oder nicht verlängern kann, muss das Unternehmen auf ihre Bedingungen eingehen.")
]

// 0-7
#aufgabe(titel: "Sechs Merkmale von Eigen- und Fremdkapital", art: "verstehen", quelle: "1.2")[
#if not web [*Aufgabe 7* #linebreak()]
#text("Nenne die sechs Merkmale, in denen sich Eigen- und Fremdkapital unterscheiden.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A7. Verfahren: #stelle(<a-1-2>).]
][
#text("Erfolgsbeteiligung / keine; keine festen Zahlungsansprüche / fester Zins- und Tilgungsanspruch; Quotenanteil / Nominalanspruch; unbefristet / befristet; Haftung / keine Haftung; Mitwirkungsrechte / keine Leitungsrechte.")
]

// 0-8
#aufgabe(titel: "Finanzierungsformen nach Drukarczyk zuordnen", art: "verstehen", quelle: "1.2")[
#if not web [*Aufgabe 8* #linebreak()]
#text("Ordne den Finanzierungsformen nach Drukarczyk zu (Nr. 1–9): a) Bankkredit, b) Darlehen eines GmbHGesellschafters an seine GmbH, c) Kapitalerhöhung durch die bisherigen Gesellschafter, d) Aufnahme eines neuen Gesellschafters, e) Gewinn wird nicht ausgeschüttet, f) Verkauf einer nicht mehr benötigten Lagerhalle.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A8. Verfahren: #stelle(<a-1-2>).]
][
#text("a) 1 Fremdfinanzierung · b) 2 Gesellschafterdarlehen · c) 3 Eigenfinanzierung · d) 4 Beteiligungsfinanzierung · e) 6 offene Selbstfinanzierung · f) 9 Vermögensumschichtung.")
]

// 0-9
#aufgabe(titel: "Eigenfinanzierung und Selbstfinanzierung", art: "verstehen", quelle: "1.2")[
#if not web [*Aufgabe 9* #linebreak()]
#text("Worin unterscheiden sich Eigenfinanzierung und Selbstfinanzierung?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A9. Verfahren: #stelle(<a-1-2>).]
][
#text("Eigenfinanzierung: bisherige Eigentümer legen neues Eigenkapital von außen ein (Außenfinanzierung). Selbstfinanzierung: Gewinne werden im Unternehmen einbehalten (Innenfinanzierung).")
]

// 0-10
#aufgabe(titel: "Liquidität als oberstes Ziel", art: "verstehen", quelle: "1.3")[
#if not web [*Aufgabe 10* #linebreak()]
#text("Definiere Liquidität. Warum hat das Liquiditätsziel die höchste Bedeutung in der Zielhierarchie?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A10. Verfahren: #stelle(<a-1-3>).]
][
Liquidität heißt: fällige Zahlungen fristgerecht und betragsgenau erfüllen können. Dieses Ziel ist dauerhaft und existenziell; Zahlungsunfähigkeit kann ein Insolvenzverfahren auslösen. Gewinn ist dafür kein Ersatz, weil er andere Größen und Periodenzuordnungen erfasst.
]

// 0-11
#aufgabe(titel: "Gewinn und trotzdem zahlungsunfähig", art: "verstehen", quelle: "1.3")[
#if not web [*Aufgabe 11* #linebreak()]
#text("Erkläre an einem Beispiel, wie ein Unternehmen Gewinn machen und trotzdem zahlungsunfähig werden kann.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A11. Verfahren: #stelle(<a-1-3>).]
][
#text("Z. B. großer Auftrag auf Ziel: Ertrag und Gewinn sind gebucht, das Geld kommt erst in 90 Tagen. Löhne und Lieferanten müssen aber jetzt bezahlt werden. Reicht die Kasse nicht, ist das Unternehmen trotz Gewinn zahlungsunfähig.")
]

// 0-12
#aufgabe(titel: "Vier Liquiditätsquellen", art: "verstehen", quelle: "1.3")[
#if not web [*Aufgabe 12* #linebreak()]
#text("Nenne die vier Liquiditätsquellen aus Folie 14 mit je einem Beispiel.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A12. Verfahren: #stelle(<a-1-3>).]
][
#text("güterwirtschaftliche Liquidität (Vermögen verkaufen, z. B. Wertpapiere); zukünftige Liquidität (künftige Einzahlungsüberschüsse, z. B. Umsätze); verliehene Liquidität (Vermögen beleihen, z. B. Grundschuld auf das Firmengrundstück); antizipierte Liquidität (künftige Überschüsse beleihen, z. B. Kredit auf erwartete Cashflows).")
]

// 0-13
#aufgabe(titel: "Bundesanleihe gegen Sparbrief", art: "verstehen", quelle: "1.3")[
#if not web [*Aufgabe 13* #linebreak()]
#text("Warum ist eine 4-jährige Bundesanleihe liquider als ein Sparbrief mit 2 Jahren Restlaufzeit?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A13. Verfahren: #stelle(<a-1-3>).]
][
#text("Die Bundesanleihe wird an der Börse gehandelt und kann börsentäglich verkauft werden. Der Sparbrief ist in der Regel nicht kündbar, man kommt erst nach Laufzeitende an das Geld.")
]

// 0-14
#aufgabe(titel: "Warum die Bilanz Liquidität schlecht misst", art: "verstehen", quelle: "1.3")[
#if not web [*Aufgabe 14* #linebreak()]
#text("Warum ist die Bilanz nur bedingt geeignet, die Liquidität zu messen?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A14. Verfahren: #stelle(<a-1-3>).]
][
Die Bilanz zeigt Vermögens- und Kapitalbestände an einem Stichtag; die GuV arbeitet mit Erträgen und Aufwendungen. Beides ergibt noch keinen Kalender künftiger Einzahlungen, Auszahlungen und Fälligkeiten. Für diese Frage braucht man den Zahlungsplan.
]

// 0-15
#aufgabe(titel: "Aufwand, Auszahlung, Ertrag, Einzahlung", art: "verstehen", quelle: "1.4")[
#if not web [*Aufgabe 15* #linebreak()]
#text("Erkläre den Unterschied zwischen Aufwand und Auszahlung sowie zwischen Ertrag und Einzahlung mit je einem Beispiel.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A15. Verfahren: #stelle(<a-1-4>).]
][
#text("Aufwand = Werteverzehr einer Periode (GuV), Auszahlung = Abfluss von Geld. Beispiel: Abschreibung ist Aufwand ohne Auszahlung; Maschinenkauf ist Auszahlung, wird aber erst über Jahre zu Aufwand. Ertrag = Wertzuwachs, Einzahlung = Zufluss von Geld. Beispiel: Verkauf auf Ziel ist Ertrag, Einzahlung erst später; Kundenanzahlung ist Einzahlung, Ertrag erst später.")
]

// 0-16
#aufgabe(titel: "Abschreibungen im indirekten Cashflow", art: "verstehen", quelle: "1.5")[
#if not web [*Aufgabe 16* #linebreak()]
#text("Warum werden bei der indirekten Cashflow-Methode die Abschreibungen zum Jahresüberschuss addiert?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A16. Verfahren: #stelle(<a-1-5>).]
][
#text("Abschreibungen haben den Jahresüberschuss gemindert, aber in dieser Periode kein Geld gekostet. Um vom Gewinn zur Zahlungsgröße zu kommen, werden sie wieder addiert.")
]

// 0-17
#aufgabe(titel: "Was der Cashflow verrät", art: "verstehen", quelle: "1.5")[
#if not web [*Aufgabe 17* #linebreak()]
#text("Über welche vier Fähigkeiten eines Unternehmens informiert der Cashflow?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A17. Verfahren: #stelle(<a-1-5>).]
][
#text("Zahlungsüberschüsse erwirtschaften, Schulden tilgen (Kreditwürdigkeit), Gewinne ausschütten, Investitionen tätigen.")
]

// 0-18
#aufgabe(titel: "Drei Bereiche der Kapitalflussrechnung", art: "verstehen", quelle: "1.6")[
#if not web [*Aufgabe 18* #linebreak()]
#text("Nenne die drei Bereiche der Kapitalflussrechnung. Ist ein negativer Cashflow aus Investitionstätigkeit ein schlechtes Zeichen?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A18. Verfahren: #stelle(<a-1-6>).]
][
#text("Operative, Investitions- und Finanzierungstätigkeit. Ein negativer Investitions-Cashflow bezeichnet eine Netto-Mittelverwendung, beispielsweise für neue Anlagen. Ob sie sinnvoll und finanzierbar ist, muss separat geprüft werden; der negative Saldo allein ist weder gut noch schlecht.")
]

// 0-19
#aufgabe(titel: "Cashflow der XYZ GmbH direkt und indirekt", art: "rechnen", quelle: "1.5")[
#if not web [*Aufgabe 19* #linebreak()]
*Gegeben und Annahmen*

GuV XYZ GmbH 2008 (Folie 22, Mio. €): Materialaufwand 1.540, Personalaufwand 1.600, Pensionsrückstellungen 200, Abschreibungen 100, Zinsaufwand 200, Jahresüberschuss 648; Umsatzerlöse 4.000, Zinsertrag 288.

*Gesucht*

#enum(numbering: "a)",
[Berechne den Cashflow direkt und indirekt. Tipp: Prüfe zuerst, ob Aufwand + JÜ = Erträge.],
)

#src[V, PDF-S. 11, Folie 22; L15, PDF-S. 10 und 14. Verfahren: #stelle(<a-1-5>).]
][
*Modell:* Zahlungen und Erfolg unterscheiden sich nur durch die genannten Abschreibungen und die Zuführung zu Pensionsrückstellungen; Einheit Mio. €.
][
*GuV prüfen:* $1540+1600+200+100+200+648=4288=4000+288$.
][
*Direkt:* $4288-1540-1600-200=948$.
][
*Indirekt:* $648+100+200=948$.
][
*Ergebnis: 948 Mio. €.* *Prüfung:* Beide Wege stimmen überein; die nicht zahlungswirksamen Aufwendungen werden direkt nicht abgezogen.
]

// 0-20
#aufgabe(titel: "Jahresüberschuss und Cashflow eines Kleinunternehmens", art: "rechnen", quelle: "1.5")[
#if not web [*Aufgabe 20* #linebreak()]
*Gegeben und Annahmen*

Kleinunternehmen: Umsatzerlöse 900 T€ (alle bezahlt), Materialaufwand 350 T€, Personalaufwand 280 T€, Abschreibungen 60 T€, Zuführung zu Pensionsrückstellungen 40 T€, Zinsaufwand 30 T€ (alles bezahlt).

*Gesucht*

#enum(numbering: "a)",
[Jahresüberschuss?],
[Cashflow indirekt?],
[Kontrolle direkt?],
)

#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A20. Verfahren: #stelle(<a-1-5>).]
][
*Modell:* Alle als bezahlt angegebenen Positionen sind zahlungswirksam; AfA und Rückstellungszuführung nicht. Einheit T€.
][
*Erfolg:* $900-350-280-60-40-30=140$.
][
*Indirekt:* $140+60+40=240$.
][
*Direkt:* $900-350-280-30=240$.
][
*Ergebnis: JÜ 140 T€, CF 240 T€.* *Prüfung:* Die Differenz 100 T€ entspricht genau den beiden nicht zahlungswirksamen Aufwendungen.
]

// 0-21
#aufgabe(titel: "Pizzeria: Lieferwagen und Abschreibung", art: "rechnen", quelle: "1.5")[
#if not web [*Aufgabe 21* #linebreak()]
*Gegeben und Annahmen*

Pizzeria, Variante: Mario kauft einen Lieferwagen für 36.000 €, Nutzungsdauer 6 Jahre (lineare Abschreibung). Sein Gewinn beträgt 3.000 € pro Monat.

*Gesucht*

#enum(numbering: "a)",
[Wie viel Geld bleibt monatlich zusätzlich in der Kasse, wenn er den Gewinn komplett entnimmt?],
[Was hat er nach 6 Jahren angespart, und wofür reicht es?],
)

#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A21. Verfahren: #stelle(<a-1-5>).]
][
*Modell:* Lineare Abschreibung, bezahlte Umsätze, keine weiteren Abgrenzungen, keine Preissteigerung oder anderweitige Verwendung des zurückbehaltenen Geldes.
][
*AfA:* $36000/6=6000$ €/Jahr, also $6000/12=500$ €/Monat.
][
*Cashflow vor Entnahme:* $3000+500=3500$ €/Monat.
][
*Nach Entnahme:* $3500-3000=500$ €/Monat; über 72 Monate $500 times 72=36000$ €.
][
*Ergebnis: 500 €/Monat zusätzlich; 36.000 € nach sechs Jahren.* *Prüfung:* Das reicht unter den Annahmen für einen gleich teuren Wagen, nicht automatisch bei höheren Preisen.
]

// 0-22
#aufgabe(titel: "Auszahlung, Aufwand, Einzahlung oder Ertrag?", art: "verstehen", quelle: "1.4")[
#if not web [*Aufgabe 22* #linebreak()]
#text("Zuordnung: Entscheide jeweils: Auszahlung? Aufwand? Einzahlung? Ertrag? (in dieser Periode) a) Barkauf einer Maschine für 100.000 € b) Abschreibung auf diese Maschine 20.000 € c) Lohnzahlung d) Zuführung zu einer Rückstellung e) Verkauf auf Ziel f) erhaltene Kundenanzahlung g) Kreditaufnahme h) Kredittilgung i) Kauf eines Grundstücks")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A22. Verfahren: #stelle(<a-1-4>).]
][
Im dargestellten Anschaffungs-/Buchungszeitpunkt gilt:
#tab(columns: (1.5fr, 2.7fr), th([Vorgang], [Zuordnung]),
[Maschine bar kaufen], [Auszahlung; Anschaffung ist noch kein sofortiger voller Aufwand.],
[Abschreibung], [Aufwand ohne aktuelle Auszahlung.],
[Lohnzahlung], [Auszahlung und Aufwand derselben Periode.],
[Rückstellung bilden], [Aufwand; Auszahlung später.],
[Verkauf auf Ziel], [Ertrag; Einzahlung später.],
[Kundenanzahlung], [Einzahlung; Ertrag später.],
[Kreditaufnahme], [Einzahlung, kein Ertrag.],
[Kredittilgung], [Auszahlung, kein Aufwand.],
[Grundstückskauf], [Auszahlung, Aktivtausch im Grundfall, kein Erwerbsaufwand.],
)
*Prüfung:* Grundstücke können später Wertminderungen erleiden; das ändert nicht die Zuordnung des ursprünglichen Kaufvorgangs.
]

// 0-23
#aufgabe(titel: "Kapitalflussrechnung mit Kassenbestand", art: "rechnen", quelle: "1.6")[
#if not web [*Aufgabe 23* #linebreak()]
*Gegeben und Annahmen*

Kapitalflussrechnung (T€): Jahresüberschuss 200, Abschreibungen 80, Erhöhung Pensionsrückstellungen 20, Erhöhung Forderungen L&L 30, Kauf einer Maschine 150, Verkauf eines Grundstücks 40, Kreditaufnahme 100, Tilgung 60, Dividendenzahlung 50, Kassenbestand am Periodenanfang 70.

*Gesucht*

#enum(numbering: "a)",
[Berechne],
[CF aus operativer Tätigkeit,],
[CF aus Investitionstätigkeit,],
[CF aus Finanzierungstätigkeit,],
[den Kassenbestand am Periodenende,],
[den Free Cashflow.],
)

#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A23. Verfahren: #stelle(<a-1-6>).]
][
*Modell:* Drei-Bereiche-Zuordnung der Folien, keine weiteren Zahlungs-/Wechselkurseffekte. Alle Werte T€.
][
*Operativ:* $200+80+20-30=270$.
][
*Investition:* $-150+40=-110$.
][
*Finanzierung:* $100-60-50=-10$.
][
*Bestand:* $70+270-110-10=220$.
][
*FCF nach der Definition von Folie 26:* $270-150=120$.
][
*Ergebnis: CF 270 / −110 / −10 T€; Ende 220 T€; FCF 120 T€.* *Prüfung:* Der Grundstücksverkauf von 40 steckt im Investitionssaldo, wird aber nicht als Minderung der hier definierten Anlagenzugänge beim FCF verwendet.
]

// 0-24
#aufgabe(titel: "Free Cashflow und Dividende", art: "rechnen", quelle: "1.6")[
#if not web [*Aufgabe 24* #linebreak()]
*Gegeben und Annahmen*

Free Cashflow: CF aus operativer Tätigkeit 1.250 T€, Investitionen in Sachanlagen 700 T€. Das Unternehmen möchte 200 T€ Dividende zahlen.

*Gesucht*

#enum(numbering: "a)",
[Free Cashflow?],
[Kann die Dividende aus dem Free Cashflow bezahlt werden? Was bleibt übrig?],
)

#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A24. Verfahren: #stelle(<a-1-6>).]
][
*FCF:* $1250-700=550$ T€.
][
*Ausschüttung:* $550-200=350$ T€.
][
*Ergebnis: Die Dividende ist im vereinfachten Zahlungsmodell gedeckt; 350 T€ verbleiben.* *Prüfung:* Andere fällige Tilgungen und Ausschüttungsbeschränkungen sind damit nicht schon geprüft.
]

// 0-25
#aufgabe(titel: "Aufgaben und Prinzipien der Finanzplanung", art: "verstehen", quelle: "1.7")[
#if not web [*Aufgabe 25* #linebreak()]
#text("Nenne die Aufgaben der Finanzplanung und die drei Prinzipien eines Finanzplans.")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B1. Verfahren: #stelle(<a-1-7>).]
][
#text("Aufgaben: Bedarf an Zahlungsmitteln ermitteln, Zahlungsfähigkeit sichern, optimale Finanzierungsart wählen, Defizite und Überschüsse sichtbar machen, EK-Bedarf ermitteln. Prinzipien: Vollständigkeit, Bruttoprinzip, Genauigkeit.")
]

// 0-26
#aufgabe(titel: "Über- und Unterliquidität", art: "verstehen", quelle: "1.7")[
#if not web [*Aufgabe 26* #linebreak()]
#text("Was sind die Folgen von Über- bzw. Unterliquidität?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B2. Verfahren: #stelle(<a-1-7>).]
][
#text("Überliquidität: zu viel ungenutztes Geld, Zinsverluste, geringere Rentabilität. Unterliquidität: Zahlungsverpflichtungen können nicht erfüllt werden, Insolvenzrisiko.")
]

// 0-27
#aufgabe(titel: "Finanzplanung abstimmen", art: "verstehen", quelle: "1.7")[
#if not web [*Aufgabe 27* #linebreak()]
#text("Warum muss die Finanzplanung mit Produktions-, Absatz- und Investitionsplanung abgestimmt werden?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B3. Verfahren: #stelle(<a-1-7>).]
][
#text("Weil Produktion, Absatz und Investitionen die Zahlungsströme bestimmen. Erst der Finanzplan zeigt, ob das Gesamtprogramm finanzierbar ist; wenn nicht, werden die Teilpläne angepasst.")
]

// 0-28
#aufgabe(titel: "Drei Insolvenzgründe", art: "verstehen", quelle: "1.8")[
#if not web [*Aufgabe 28* #linebreak()]
#text("Nenne die drei Insolvenzgründe mit Paragraf. Welcher gilt nur für juristische Personen?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B4. Verfahren: #stelle(<a-1-8>).]
][
#text("Zahlungsunfähigkeit (§ 17), drohende Zahlungsunfähigkeit (§ 18) und Überschuldung (§ 19 InsO). § 19 gilt für juristische Personen sowie die dort in Abs. 3 erfassten Personengesellschaften. Ein sinkender Umsatz allein ist kein eigener Insolvenzgrund.")
]

// 0-29
#aufgabe(titel: "Zahlungsunfähigkeit nach dem BGH", art: "verstehen", quelle: "1.8")[
#if not web [*Aufgabe 29* #linebreak()]
#text("Wann ist ein Unternehmen nach der Rechtsprechung des BGH zahlungsunfähig?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B5. Verfahren: #stelle(<a-1-8>).]
][
#text("Die Folie rechnet mit der 90-%-/Dreiwochen-Orientierung. Präziser: Eine nicht beseitigte Lücke von 10 % oder mehr begründet nach dem BGH regelmäßig Zahlungsunfähigkeit; Ausnahmen und die weitere Entwicklung sind mitzubeurteilen. Genau 90 % sind keine rechtliche Freigrenze.")
]

// 0-30
#aufgabe(titel: "Zahlungsunfähigkeit und Überschuldung", art: "verstehen", quelle: "1.8")[
#if not web [*Aufgabe 30* #linebreak()]
#text("Erkläre den Unterschied zwischen Zahlungsunfähigkeit und Überschuldung mit eigenen Worten.")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B6. Verfahren: #stelle(<a-1-8>).]
][
#text("Zahlungsunfähigkeit: Es fehlt jetzt Geld, um fällige Rechnungen zu bezahlen (Liquiditätsproblem). Überschuldung: Das Vermögen reicht nicht, um alle Schulden zu decken, das EK ist negativ (Vermögensproblem). Ein überschuldetes Unternehmen kann noch zahlen, ein zahlungsunfähiges kann noch Vermögen haben.")

*Präzisierung:* Ein bilanzieller Fehlbetrag und die rechtliche Überschuldung sind getrennt zu prüfen. Darlehen verschwinden nicht pauschal aus der Bilanz; beim Rangrücktritt gelten die Voraussetzungen von § 19.
]

// 0-31
#aufgabe(titel: "Rechnerisch überschuldet, aber kein Insolvenzgrund", art: "verstehen", quelle: "1.8")[
#if not web [*Aufgabe 31* #linebreak()]
#text("Wann liegt trotz rechnerischer Überschuldung kein Insolvenzgrund vor?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B7. Verfahren: #stelle(<a-1-8>).]
][
#text("Ein negatives handelsbilanzielles EK allein beweist keine rechtliche Überschuldung. § 19 berücksichtigt insbesondere die überwiegend wahrscheinliche Fortführung in den nächsten zwölf Monaten sowie die rechtlich passende Vermögens- und Verbindlichkeitsbewertung.")
]

// 0-32
#aufgabe(titel: "Warum ein Kredit gegen Überschuldung nicht hilft", art: "verstehen", quelle: "1.8")[
#if not web [*Aufgabe 32* #linebreak()]
#text("Warum hilft bei Überschuldung kein neuer Bankkredit? Was hilft stattdessen?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B8. Verfahren: #stelle(<a-1-8>).]
][
#text("Ein Kredit erhöht Vermögen (Kasse) und Schulden um denselben Betrag, die Lücke zwischen Vermögen und Schulden bleibt. Es braucht Eigenkapital (Kapitaleinlage, neuer EK-Geber), einen Rangrücktritt oder einen Lieferantenvergleich.")

*Präzisierung:* Ein bilanzieller Fehlbetrag und die rechtliche Überschuldung sind getrennt zu prüfen. Darlehen verschwinden nicht pauschal aus der Bilanz; beim Rangrücktritt gelten die Voraussetzungen von § 19.
]

// 0-33
#aufgabe(titel: "Frist für den Insolvenzantrag", art: "verstehen", quelle: "1.8")[
#if not web [*Aufgabe 33* #linebreak()]
#text("Wie lange hat die Geschäftsführung Zeit, den Insolvenzantrag zu stellen, und was droht bei Verspätung?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B9. Verfahren: #stelle(<a-1-8>).]
][
#text("Ohne schuldhaftes Zögern; nach § 15a Abs. 1 spätestens drei Wochen nach Eintritt der Zahlungsunfähigkeit bzw. sechs Wochen nach Eintritt der Überschuldung. Die einheitlichen drei Wochen der Folie 34 sind insoweit veraltet. Verspätete Antragstellung kann strafbar sein; drohende Zahlungsunfähigkeit allein löst diese Antragspflicht nicht aus.")
]

// 0-34
#aufgabe(titel: "Sechs Maßnahmen gegen ein Liquiditätsdefizit", art: "verstehen", quelle: "1.8")[
#if not web [*Aufgabe 34* #linebreak()]
#text("Nenne die sechs Gruppen von Maßnahmen gegen ein Liquiditätsdefizit mit je einem Beispiel.")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B10. Verfahren: #stelle(<a-1-8>).]
][
#text("Vermögen außer der Reihe zu Geld machen (Sale-and-lease-back); Eingänge beschleunigen, Ausgänge verzögern (Mahnwesen verschärfen); spezielle Einlagen und Kredite beschaffen (längeres Lieferantenziel); Rentabilität für Liquidität opfern (Sofortzahler bevorzugen); Gesellschafter müssen Farbe bekennen (zusätzliche Einlagen); rigoros Auszahlungen kürzen (Personalabbau).")
]

// 0-35
#aufgabe(titel: "Ausgänge eines Insolvenzverfahrens", art: "verstehen", quelle: "1.8")[
#if not web [*Aufgabe 35* #linebreak()]
#text("Welche Ausgänge kann ein Insolvenzverfahren nehmen? Was bedeutet „Abweisung mangels Masse“?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B11. Verfahren: #stelle(<a-1-8>).]
][
#text("Abweisung mangels Masse, Liquidation (Gläubiger erhalten eine Quote) oder Sanierung über einen Insolvenzplan; dazu Einstellung des Verfahrens. „Mangels Masse“: Das Vermögen reicht nicht einmal, um die Kosten des Verfahrens zu decken.")
]

// 0-36
#aufgabe(titel: "Kennzahlen und Finanzplan", art: "verstehen", quelle: "1.7")[
#if not web [*Aufgabe 36* #linebreak()]
#text("Worin unterscheiden sich finanzwirtschaftliche Kennzahlen und Finanzplan?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B12. Verfahren: #stelle(<a-1-7>).]
][
#text("Bilanzkennzahlen zeigen Bestandsrelationen eines Stichtags; Rentabilitätskennzahlen verbinden einen Periodenerfolg mit einer passenden Bezugsgröße. Der Finanzplan nimmt künftige Ein- und Auszahlungen nach Termin vorweg. Kennzahlen eignen sich für Zielvorgaben sowie Soll-Ist-, Zeit- und Branchenvergleiche, ersetzen aber keinen Fälligkeitsplan.")
]

// 0-37
#aufgabe(titel: "Drei Liquiditätsgrade", art: "verstehen", quelle: "1.9")[
#if not web [*Aufgabe 37* #linebreak()]
#text("Nenne die drei Liquiditätsgrade mit Formel und Zielwert.")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B13. Verfahren: #stelle(<a-1-9>).]
][
#text("1. Grad: flüssige Mittel / kfr. FK, 10–30 %. 2. Grad: (flüssige Mittel + Forderungen) / kfr. FK, mind. 100 %. 3. Grad: Umlaufvermögen / kfr. FK, mind. 200 %.")
]

// 0-38
#aufgabe(titel: "Goldene Bilanzregel", art: "verstehen", quelle: "1.10")[
#if not web [*Aufgabe 38* #linebreak()]
#text("Formuliere die goldene Bilanzregel. Welche Kennzahl prüft sie, und welcher Wert sollte mindestens erreicht werden?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B14. Verfahren: #stelle(<a-1-10>).]
][
#text("Anlagevermögen soll durch langfristig verfügbares Kapital finanziert werden. Geprüft mit der Anlagendeckung (II: (EK + langfr. FK) / AV); mindestens 100 %.")
]

// 0-39
#aufgabe(titel: "Anlageintensität zu hoch oder zu gering", art: "verstehen", quelle: "1.10")[
#if not web [*Aufgabe 39* #linebreak()]
#text("Warum kann eine zu hohe, aber auch eine zu geringe Anlageintensität problematisch sein?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B15. Verfahren: #stelle(<a-1-10>).]
][
#text("Zu hoch: Das Anlagevermögen lässt sich in der Krise schwer verkaufen. Zu gering: Hinweis auf alte, stark abgeschriebene Anlagen.")
]

// 0-40
#aufgabe(titel: "Eigenkapitalquote", art: "verstehen", quelle: "1.10")[
#if not web [*Aufgabe 40* #linebreak()]
#text("Was sagt die Eigenkapitalquote aus, und welcher Zielwert gilt?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B16. Verfahren: #stelle(<a-1-10>).]
][
#text("Anteil des EK an der Bilanzsumme; zeigt finanzielle Unabhängigkeit und Bonität. Zielwert mindestens 15–20 %.")
]

// 0-41
#aufgabe(titel: "EK-Rentabilität über dem Marktzins", art: "verstehen", quelle: "1.11")[
#if not web [*Aufgabe 41* #linebreak()]
#text("Warum sollte die EK-Rentabilität deutlich über dem Marktzins für langfristige Anlagen liegen?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B17. Verfahren: #stelle(<a-1-11>).]
][
#text("Weil der Gewinn zusätzlich das Unternehmensrisiko vergüten muss. Sonst könnte der Eigentümer sein Geld risikolos(er) anlegen.")
]

// 0-42
#aufgabe(titel: "Hubert + Maier: Risiko aus der Kapitalstruktur", art: "verstehen", quelle: "1.11")[
#if not web [*Aufgabe 42* #linebreak()]
#text("Erkläre am Beispiel Hubert + Maier GmbH, warum das Risiko von Alternative B aus der Kapitalstruktur kommt.")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B18. Verfahren: #stelle(<a-1-11>).]
][
#text("Bei A und B fällt das Grundstück gleich stark (gleiches Geschäftsrisiko). Bei A trägt das hohe EK den Verlust. Bei B kommen 8.000 € Zinsen dazu, und das kleine EK (20.000) reicht für 28.000 Verlust nicht: bilanzieller Fehlbetrag von 8.000 €. Eine rechtliche Überschuldung ist zusätzlich nach Abschnitt 1.8 zu prüfen. Der Unterschied liegt nur in der Finanzierung.")
]

// 0-43
#aufgabe(titel: "Leverage-Effekt", art: "verstehen", quelle: "1.12")[
#if not web [*Aufgabe 43* #linebreak()]
#text("Was ist der Leverage-Effekt, und unter welcher Bedingung tritt er auf?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B19. Verfahren: #stelle(<a-1-12>).]
][
#text("Hebelwirkung des FK zugunsten der EK-Rentabilität: Ist der FK-Zins kleiner als die Gesamtkapitalrendite, steigt die EK-Rentabilität mit zunehmender Verschuldung.")
]

// 0-44
#aufgabe(titel: "Risikoeffekt", art: "verstehen", quelle: "1.12")[
#if not web [*Aufgabe 44* #linebreak()]
#text("Was beschreibt der Risikoeffekt? Warum ist die höhere EK-Rendite „kein zusätzlicher Wert“?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B20. Verfahren: #stelle(<a-1-12>).]
][
#text("Mit steigender Verschuldung wächst die Streuung der EK-Rendite (das Risiko). Die höhere Rendite ist nur die Entschädigung für dieses höhere Risiko, kein Geschenk.")
]

// 0-45
#aufgabe(titel: "Warum nicht vollständig fremdfinanzieren", art: "verstehen", quelle: "1.12")[
#if not web [*Aufgabe 45* #linebreak()]
#text("Warum ist eine vollständige Fremdfinanzierung trotz Leverage-Effekt keine gute Idee?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B21. Verfahren: #stelle(<a-1-12>).]
][
#text("Mit EK = 0 ist die Leverage-Formel nicht definiert. Mit sinkendem EK werden das Verlustpolster kleiner und die Renditeschwankungen größer. Kreditzins, Kreditverfügbarkeit und Rückzahlungspflichten dürfen nicht als beliebig unverändert angenommen werden; bei rG < rf wirkt der Hebel negativ.")
]

// 0-46
#aufgabe(titel: "Liquiditätsplan über drei Quartale", art: "rechnen", quelle: "1.7")[
#if not web [*Aufgabe 46* #linebreak()]
*Gegeben und Annahmen*

Liquiditätsplan: Anfangsbestand Q1: 8.000 €. Einzahlungen Q1/Q2/Q3: 30.000 / 25.000 / 40.000 €. Auszahlungen: 35.000 / 34.000 / 31.000 €. Kontokorrentlinie 5.000 €.

*Gesucht*

#enum(numbering: "a)",
[Endbestände je Quartal?],
[In welchem Quartal reicht die Kreditlinie nicht? Um wie viel?],
[Nenne zwei Maßnahmen.],
)

#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B22. Verfahren: #stelle(<a-1-7>).]
][
*Modell:* Negativer Kontostand wird durch Kontokorrent gedeckt, soweit die Linie reicht. Alle Werte €.
][
*Q1:* $8000+30000-35000=3000$.
][
*Q2:* $3000+25000-34000=-6000$.
][
*Q3:* $-6000+40000-31000=3000$.
][
*Ergebnis: 3.000 / −6.000 / 3.000 €.* In Q2 übersteigt der Bedarf die Linie von 5.000 € um *1.000 €*. Die positive Q3-Position setzt die zwischenzeitliche Finanzierung voraus.
][
*Prüfung/Maßnahmen:* Vor Q2 zusätzliche Linie vereinbaren, Auszahlungen vertraglich strecken, Forderungen schneller einziehen oder Kundenvorauszahlungen vereinbaren.
]

// 0-47
#aufgabe(titel: "Gewinn gegen Kasse", art: "rechnen", quelle: "1.7")[
#if not web [*Aufgabe 47* #linebreak()]
*Gegeben und Annahmen*

Gewinn vs. Kasse: Ein Unternehmen startet mit 2.000 € auf dem Konto. Es erzielt einen (zahlungswirksamen) Gewinn von 3.000 €, schüttet 1.500 € aus, kauft eine Maschine für 4.000 € und nimmt einen Kredit über 1.000 € auf.

*Gesucht*

#enum(numbering: "a)",
[Endbestand?],
[Welche Vorgänge erscheinen in der GuV?],
)

#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B23. Verfahren: #stelle(<a-1-7>).]
][
*Modell:* Der angegebene Gewinn von 3.000 € ist hier ausdrücklich voll zahlungswirksam.
][
*Bestand rechnen:* $2000+3000-1500-4000+1000=500$ €.
][
*Erfolg trennen:* Ausschüttung ist kein Aufwand, Maschinenkauf wird aktiviert (spätere AfA), Kredit ist kein Ertrag.
][
*Ergebnis: 500 € Kontobestand.* *Prüfung:* Ein Gewinn von 3.000 € bedeutet in diesem Fall keine Zunahme des Kontos um 3.000 €. Die ursprünglichen Erträge/Aufwendungen ergeben den Gewinn; er ist keine eigene Buchungsart.
]

// 0-48
#aufgabe(titel: "BGH-Regel mit 430.000 €", art: "rechnen", quelle: "1.8")[
#if not web [*Aufgabe 48* #linebreak()]
*Gegeben und Annahmen*

BGH-Regel: Fällige Verbindlichkeiten 500.000 €. Innerhalb der nächsten drei Wochen kann das Unternehmen 430.000 € bezahlen.

*Gesucht*

#enum(numbering: "a)",
[Ist es zahlungsunfähig? Welchem Zahlbetrag entsprechen 90 %?],
[Warum ist das rechtlich noch keine sichere Freigrenze?],
)

#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B24. Verfahren: #stelle(<a-1-8>).]
][
*Deckungsquote:* $430000/500000 times 100%=86%$; die Lücke beträgt *14 %*.
][
*Folienorientierung:* 86 % liegt unter 90 %, also ein deutlicher Hinweis auf Zahlungsunfähigkeit im Aufgabenmodell. 90 % entsprächen $"0,9" times 500000=450000$ €.
][
*Prüfung:* Auch bei genau 450.000 € bleibt eine Lücke von 10 %. Nach dem BGH ist das regelmäßig kritisch, keine sichere Freigrenze. Ausnahmen und die Entwicklung müssen gesondert beurteilt werden.
]

// 0-49
#aufgabe(titel: "Verlustpolster und bilanzielle Unterdeckung", art: "rechnen", quelle: "1.8")[
#if not web [*Aufgabe 49* #linebreak()]
*Gegeben und Annahmen*

Überschuldung : Bilanz einer GmbH: Anlagevermögen 300, Umlaufvermögen 200; Eigenkapital 60, Fremdkapital 440 (T€).

*Gesucht*

#enum(numbering: "a)",
[Welchen Verlust kann die GmbH maximal verkraften?],
[Durch eine außerplanmäßige Abschreibung entsteht ein Verlust von 80. Liegt eine bilanzielle Unterdeckung vor, und welche zusätzliche rechtliche Prüfung ist nötig? Wie hoch ist der nicht durch EK gedeckte Fehlbetrag?],
[Nenne zwei Maßnahmen, um die Antragspflicht zu beseitigen.],
)

#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B25. Verfahren: #stelle(<a-1-8>).]
][
*Modell:* Keine weiteren Wert-/Kapitaländerungen; Einheit T€.
][
*Polster:* Das anfängliche EK von 60 trägt rechnerisch bis zu 60 Verlust.
][
*Nach Abschreibung:* AV $300-80=220$, Vermögen $220+200=420$, Schulden 440, rechnerisches EK $60-80=-20$.
][
*Ergebnis: 20 T€ bilanzieller Fehlbetrag.* *Prüfung:* Rechtsüberschuldung erfordert die Prüfung nach § 19, insbesondere Fortführung und geeignete Bewertung. Als Ansätze kommen Einlage, Forderungsverzicht oder rechtlich geeigneter Nachrang in Betracht; ein neuer gewöhnlicher Kredit schließt die Vermögenslücke nicht.
]

// 0-50
#aufgabe(titel: "Liquiditätsgrade berechnen", art: "rechnen", quelle: "1.9")[
#if not web [*Aufgabe 50* #linebreak()]
*Gegeben und Annahmen*

Liquiditätsgrade: Kasse und Bank 40, Forderungen 120, Vorräte 140, kurzfristiges Fremdkapital 150 (T€).

*Gesucht*

#enum(numbering: "a)",
[Berechne die drei Liquiditätsgrade und beurteile sie.],
)

#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B26. Verfahren: #stelle(<a-1-9>).]
][
*L1:* $40/150 times 100% approx "26,7"%$.
][
*L2:* $(40+120)/150 times 100% approx "106,7"%$.
][
*L3:* $(40+120+140)/150 times 100%=200%$.
][
*Ergebnis: 26,7 % / 106,7 % / 200 %.* Die Folienziele sind erreicht, beim dritten Grad genau. *Prüfung:* Gleicher Nenner, zunehmender Zähler; daraus folgt noch keine Garantie passender Fälligkeiten.
]

// 0-51
#aufgabe(titel: "Kennzahlen-Check", art: "rechnen", quelle: "1.10")[
#if not web [*Aufgabe 51* #linebreak()]
*Gegeben und Annahmen*

Kennzahlen-Check : Anlagevermögen 600, Umlaufvermögen 400; Eigenkapital 250, langfristiges FK 350, kurzfristiges FK 400 (T€). Jahresüberschuss 50, Umsatzerlöse 1.000, Cashflow 125.

*Gesucht*

#enum(numbering: "a)",
[Berechne Anlagendeckung I und II, EK- und FK-Quote, Anlageintensität, EK-Rentabilität, Umsatzrentabilität, Schuldentilgungsfähigkeit (Verbindlichkeiten = gesamtes FK) und beurteile: Ist die goldene Bilanzregel erfüllt?],
)

#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B27. Verfahren: #stelle(<a-1-10>).]
][
*Modell:* Gesamtkapital $600+400=1000$ T€, FK $350+400=750$ T€; jährlicher CF 125 T€.
][
*Deckung:* AD I $=250/600 times 100% approx "41,7"%$; AD II $=(250+350)/600 times 100%=100%$.
][
*Struktur:* EK-Quote $25%$, FK-Quote $75%$, Anlageintensität $60%$.
][
*Erfolg:* EK-Rentabilität $=50/250 times 100%=20%$; Umsatzrentabilität $=50/1000 times 100%=5%$.
][
*Dauerkennzahlen:* Schuldentilgung $750/125=6$ Jahre; die „Selbstfinanzierungsquote“ der Folie wäre $600/125="4,8"$ Jahre.
][
*Ergebnis:* Goldene Bilanzregel gerade erfüllt. *Prüfung:* EK- und FK-Quote ergeben 100 %; Dauerkennzahlen sind keine Prozentwerte.
]

// 0-52
#aufgabe(titel: "Leverage im guten und schlechten Jahr", art: "rechnen", quelle: "1.12")[
#if not web [*Aufgabe 52* #linebreak()]
*Gegeben und Annahmen*

Leverage : Ein Projekt erfordert 200.000 € Kapital und bringt einen Gewinn vor Zinsen von 24.000 €. FKZins 6 %.

*Gesucht*

#enum(numbering: "a)",
[Gesamtkapitalrendite?],
[EK-Rentabilität bei 100 % EK, 50 % EK und 25 % EK (rechne einmal direkt und einmal mit der Formel).],
[Der Gewinn vor Zinsen sinkt auf 8.000 €. Wie hoch ist die EK-Rentabilität jetzt in den drei Fällen? Was zeigt das?],
)

#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B28. Verfahren: #stelle(<a-1-12>).]
][
*Modell:* Gesamtkapital 200.000 €, FK-Zins 6 %, keine Steuern; EK-Anteile 100 % / 50 % / 25 %.
][
*Gutes Jahr:* $r_G=24000/200000 times 100%=12%$.

Direkt: $24000/200000=12%$, $(24000-6000)/100000=18%$, $(24000-9000)/50000=30%$.

Mit Formel: $12+(12-6) times 0=12$, $12+(12-6) times 1=18$, $12+(12-6) times 3=30$ (jeweils %).
][
*Schlechtes Jahr:* $r_G=8000/200000 times 100%=4%$. EK-Renditen: *4 % / 2 % / −2 %*. Direkt $8000/200000$, $(8000-6000)/100000$, $(8000-9000)/50000$; die Formel liefert dieselben Werte.
][
*Prüfung:* Über 6 % Gesamtrendite hilft der Hebel, darunter schadet er. Die gleiche Verschuldung verstärkt beide Richtungen.
]

// 0-53
#aufgabe(titel: "Cashflow indirekt mit Rückstellungen", art: "rechnen", quelle: "1.5")[
#if not web [*Aufgabe 53* #linebreak()]
*Gegeben und Annahmen*

Cashflow indirekt: JÜ 250, Abschreibungen 90, Zuführung zu Rückstellungen 30, Auflösung von Rückstellungen 10 (T€).

*Gesucht*

#enum(numbering: "a)",
[Berechne den Cashflow und begründe jedes Vorzeichen.],
)

#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü1. Verfahren: #stelle(<a-1-5>).]
][
*Bereinigen:* $250+90+30-10=360$ T€.
][
*Ergebnis: 360 T€.* *Prüfung:* AfA und Zuführung wurden als nicht zahlungswirksamer Aufwand addiert; die ebenfalls nicht zahlungswirksame Auflösung als Ertrag abgezogen. Sonstige Abgrenzungen sind im Beispiel nicht gegeben.
]

// 0-54
#aufgabe(titel: "Cashflow direkt", art: "rechnen", quelle: "1.5")[
#if not web [*Aufgabe 54* #linebreak()]
*Gegeben und Annahmen*

Cashflow direkt: Einzahlungen aus Umsatz 1.200, Auszahlungen für Material 500, Personal 350, Zinsen 40 (T€).

*Gesucht*

#enum(numbering: "a)",
[Berechne den Cashflow.],
)

#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü2. Verfahren: #stelle(<a-1-5>).]
][
*Zahlungen saldieren:* $1200-500-350-40=310$ T€.
][
*Ergebnis: 310 T€.* *Prüfung:* Nur ausdrücklich gegebene Zahlungen verwenden; keine zusätzliche Abschreibung abziehen.
]

// 0-55
#aufgabe(titel: "Endbestand und freie Kreditlinie", art: "rechnen", quelle: "1.7")[
#if not web [*Aufgabe 55* #linebreak()]
*Gegeben und Annahmen*

Liquiditätsplan: Anfangsbestand 5.000 €, Einzahlungen 22.000 €, Auszahlungen 30.000 €, Kontokorrentlinie 6.000 €.

*Gesucht*

#enum(numbering: "a)",
[Berechne Endbestand und freie Kreditlinie.],
)

#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü3. Verfahren: #stelle(<a-1-7>).]
][
*Kontostand:* $5000+22000-30000=-3000$ €.
][
*Freie Linie:* $6000-3000=3000$ €.
][
*Ergebnis: 3.000 € Kontokorrent genutzt, 3.000 € noch verfügbar.* *Prüfung:* Die negative Kontoposition wird nicht noch einmal von der bereits verminderten freien Linie abgezogen.
]

// 0-56
#aufgabe(titel: "Bilanzielles Verlustpolster", art: "rechnen", quelle: "1.8")[
#if not web [*Aufgabe 56* #linebreak()]
*Gegeben und Annahmen*

Bilanzielles Verlustpolster: AV 120, UV 80, EK 40, FK 160 (T€). Ein Abschreibungsverlust von 50 entsteht.

*Gesucht*

#enum(numbering: "a)",
[Berechne Vermögen, rechnerisches EK und Fehlbetrag; trenne den bilanziellen Befund von der rechtlichen Prüfung.],
)

#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü4. Verfahren: #stelle(<a-1-8>).]
][
*Vermögen:* $(120-50)+80=150$ T€.
][
*Kapital:* FK 160 T€, EK $40-50=-10$ T€.
][
*Ergebnis: 10 T€ bilanzieller Fehlbetrag.* *Prüfung:* Der Abschreibungsverlust übersteigt das Polster. Die rechtliche Überschuldung erfordert zusätzlich § 19; bloßes negatives Buch-EK ist keine vollständige Rechtsprüfung.
]

// 0-57
#aufgabe(titel: "EK-Quote und goldene Bilanzregel", art: "rechnen", quelle: "1.10")[
#if not web [*Aufgabe 57* #linebreak()]
*Gegeben und Annahmen*

EK-Quote und goldene Bilanzregel: EK 300, langfristiges FK 200, kurzfristiges FK 500, AV 450, Bilanzsumme 1.000 (T€).

*Gesucht*

#enum(numbering: "a)",
[Berechne EK-Quote und Anlagendeckung II und vergleiche die Folienziele.],
)

#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü5. Verfahren: #stelle(<a-1-10>).]
][
*EK-Quote:* $300/1000 times 100%=30%$.
][
*AD II:* $(300+200)/450 times 100% approx "111,1"%$.
][
*Ergebnis:* Die EK-Quote liegt über 15–20 %, die goldene Bilanzregel ist erfüllt. *Prüfung:* Verfügbares langfristiges Kapital 500 T€ übersteigt AV 450 T€ um 50 T€.
]

// 0-58
#aufgabe(titel: "Leverage-Formel anwenden", art: "rechnen", quelle: "1.12")[
#if not web [*Aufgabe 58* #linebreak()]
*Gegeben und Annahmen*

Leverage: rG = 9 %, rf = 5 %, EK 40, FK 60.

*Gesucht*

#enum(numbering: "a)",
[Berechne die Eigenkapitalrendite und erläutere den Zuschlag.],
)

#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü6. Verfahren: #stelle(<a-1-12>).]
][
*Verschuldung:* $"FK"/"EK"=60/40="1,5"$.
][
*Hebel:* $r_e=9%+(9%-5%) times "1,5"=15%$.
][
*Ergebnis: 15 %.* *Prüfung:* Positiver Renditeabstand 4 Prozentpunkte × 1,5 ergibt 6 Prozentpunkte Zuschlag.
]

// 0-59
#aufgabe(titel: "Bäckerei: Ofen und Abschreibung", art: "rechnen", quelle: "1.5")[
#if not web [*Aufgabe 59* #linebreak()]
*Gegeben und Annahmen*

Bäckerei (Teil A4): Ein Ofen kostet 48.000 €, Nutzungsdauer 8 Jahre (linear). Gewinn 4.000 € pro Monat, der komplett entnommen wird.

*Gesucht*

#enum(numbering: "a)",
[Wie viel Geld bleibt monatlich zusätzlich in der Kasse, und was ist nach 8 Jahren angespart?],
)

#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü7. Verfahren: #stelle(<a-1-5>).]
][
*Modell:* Lineare AfA; Gewinne vollständig entnommen; alle Umsätze bezahlt, keine Preissteigerung und keine anderweitige Verwendung.
][
*AfA:* $48000/8=6000$ €/Jahr $=500$ €/Monat.
][
*Mittel:* $4000+500=4500$ € Cashflow vor Entnahme; danach *500 € monatlich*.
][
*Ansparen:* $500 times 96=48000$ €.
][
*Prüfung:* Nach acht Jahren entspricht der Betrag dem ursprünglichen Ofenpreis; Abschreibung selbst ist kein Geldzufluss.
]

// 0-60
#aufgabe(titel: "Kapitalflussrechnung mit Forderungen und Verbindlichkeiten", art: "rechnen", quelle: "1.6")[
#if not web [*Aufgabe 60* #linebreak()]
*Gegeben und Annahmen*

Kapitalflussrechnung (Teil A4): JÜ 120, Abschreibungen 40, Erhöhung Forderungen L&L 25, Erhöhung Verbindlichkeiten L&L 15, Kauf einer Maschine 90, Kreditaufnahme 50, Dividende 30, Kasse am Anfang 20 (T€).

*Gesucht*

#enum(numbering: "a)",
[Berechne die drei Cashflows, den Kassenendbestand und den Free Cashflow.],
)

#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü8. Verfahren: #stelle(<a-1-6>).]
][
*Modell:* Alle Werte T€, Zuordnung nach Folie 24.
][
*Operativ:* $120+40-25+15=150$.
][
*Investition:* $-90$; *Finanzierung:* $50-30=20$.
][
*Bestand:* $20+150-90+20=100$.
][
*FCF:* $150-90=60$.
][
*Ergebnis: 150 / −90 / 20 T€; Ende 100 T€; FCF 60 T€.* *Prüfung:* Mehr Forderungen bindet Geld, mehr Lieferverbindlichkeiten lässt zunächst Geld im Unternehmen.
]

// 0-61
#aufgabe(titel: "BGH-Regel mit 800.000 €", art: "rechnen", quelle: "1.8")[
#if not web [*Aufgabe 61* #linebreak()]
*Gegeben und Annahmen*

Fällige Verbindlichkeiten 800 000 €; innerhalb von drei Wochen zahlbar 700 000 €. Historischer Übungsfall zur im Lernskript erläuterten BGH-Regel.

*Gesucht*

#enum(numbering: "a)",
[Berechne die Liquiditätslücke und ihren Anteil. Ordne den Befund ein und benenne die Grenzen einer rein rechnerischen Beurteilung.],
)

#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü9. Verfahren: #stelle(<a-1-8>).]
][
*Quote:* $700000/800000 times 100%="87,5"%$; Lücke 12,5 %.
][
*Ergebnis:* Regelmäßig kritischer Befund im Dreiwochenmodell. 90 % entsprächen 720.000 €. *Prüfung:* Auch dieser Grenzbetrag wäre keine sichere rechtliche Freigrenze; Abschnitt 1.8 beschreibt den Unterschied zur vereinfachten Folienregel.
]

// 0-62
#aufgabe(titel: "Liquiditätsgrade beurteilen", art: "rechnen", quelle: "1.9")[
#if not web [*Aufgabe 62* #linebreak()]
*Gegeben und Annahmen*

Liquiditätsgrade (Teil A5): Kasse 30, Forderungen 90, Vorräte 120, kurzfristiges FK 200 (T€).

*Gesucht*

#enum(numbering: "a)",
[Berechne und beurteile die drei Grade.],
)

#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü10. Verfahren: #stelle(<a-1-9>).]
][
*L1:* $30/200 times 100%=15%$.
][
*L2:* $(30+90)/200 times 100%=60%$.
][
*L3:* $(30+90+120)/200 times 100%=120%$.
][
*Ergebnis: 15 % / 60 % / 120 %.* *Prüfung:* Der erste Folienzielbereich wird erreicht, die beiden anderen unterschritten. Das ist ein Warnsignal für die kurzfristige Deckung; Fälligkeiten und Einbringlichkeit sind zusätzlich zu planen.
]

// 0-63
#aufgabe(titel: "Leverage im schlechten Jahr", art: "rechnen", quelle: "1.12")[
#if not web [*Aufgabe 63* #linebreak()]
*Gegeben und Annahmen*

Leverage im schlechten Jahr (Teil A5): Gesamtkapital 500.000 € (EK 100.000, FK 400.000), Gewinn vor Zinsen 40.000 €, FK-Zins 10 %. EK-Rentabilität?

*Gesucht*

#enum(numbering: "a)",
[Vergleiche mit reiner EK-Finanzierung.],
)

#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü11. Verfahren: #stelle(<a-1-12>).]
][
*Gesamtrendite:* $40000/500000 times 100%=8%$.
][
*Zinsen:* $"0,10" times 400000=40000$ €; nach Zinsen bleibt null.
][
*EK-Rendite:* $0/100000=0%$. Formel: $8%+(8%-10%) times 4=0%$.
][
*Ergebnis:* Mit reiner EK-Finanzierung wären es 8 %. *Prüfung:* Der Kredit kostet mehr als die Gesamtrendite; der Hebel wirkt negativ.
]

// 0-64
#aufgabe(titel: "Liquiditätsplan einer Gründung", art: "rechnen", quelle: "1.7")[
#if not web [*Aufgabe 64* #linebreak()]
*Gegeben und Annahmen*

Anfangskasse 10 000 €. Ein-/Auszahlungen: Q1 15 000/28 000 €, Q2 30 000/26 000 €, Q3 35 000/25 000 €. Kontokorrentlinie 5 000 €.

*Gesucht*

#enum(numbering: "a)",
[Bestimme Endbestand und freie Kreditlinie je Quartal und beurteile den Finanzierungsbedarf.],
)

#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü12. Verfahren: #stelle(<a-1-7>).]
][
*Q1:* $10000+15000-28000=-3000$ €; freie Linie 2.000 €.
][
*Q2:* $-3000+30000-26000=1000$ €; freie Linie 5.000 €.
][
*Q3:* $1000+35000-25000=11000$ €; freie Linie 5.000 €.
][
*Ergebnis:* Q1 ist durch die vereinbarte Linie gedeckt; Q2 führt den Kredit zurück. *Prüfung:* Bei positivem Kontostand ist die ganze Linie frei, der Kontobestand kommt als eigener Bestand hinzu. Q3 kann Anlass sein, die benötigte Reserve und die Verwendung des Überschusses zu prüfen.
]

// 0-65
#aufgabe(titel: "Bilanzanalyse mit allen Kennzahlen", art: "rechnen", quelle: "1.10")[
#if not web [*Aufgabe 65* #linebreak()]
*Gegeben und Annahmen*

Bilanzanalyse (Teil A4/A5): AV 800; Vorräte 200, Forderungen 150, Kasse 50; EK 180, langfr. FK 520, kfr. FK 500 (T€). JÜ 27, Umsatz 1.500, Cashflow 100.

*Gesucht*

#enum(numbering: "a)",
[Berechne Liquidität 1.–3. Grades, Anlagendeckung I und II, EKQuote, Anlageintensität, EK- und Umsatzrentabilität, Schuldentilgungsfähigkeit (gesamtes FK) und gib ein Gesamturteil.],
)

#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü13. Verfahren: #stelle(<a-1-10>).]
][
*Modell:* Gesamtkapital $800+200+150+50=1200$ T€; FK 1.020 T€; jährlicher CF 100 T€.
][
*Liquidität:* L1 $10%$, L2 $40%$, L3 $80%$.
][
*Deckung:* AD I $180/800="22,5"%$, AD II $700/800="87,5"%$.
][
*Struktur:* EK-Quote $15%$, FK-Quote $85%$, Anlageintensität $800/1200 approx "66,7"%$.
][
*Erfolg/Dauer:* EK-Rentabilität $27/180=15%$, Umsatzrentabilität $27/1500="1,8"%$, Schuldentilgung $1020/100="10,2"$ Jahre.
][
*Ergebnis:* Die Folienziele L2/L3 und AD II werden verfehlt, das EK-Polster ist niedrig. *Prüfung:* Ein Teil des AV ist kurzfristig finanziert. Das Kennzahlenbild ist kritisch, beweist für sich aber keine fällige Zahlungslücke.
]

// 0-66
#aufgabe(titel: "Kapitalstruktur und Risiko in zwei Bilanzen", art: "rechnen", quelle: "1.11")[
#if not web [*Aufgabe 66* #linebreak()]
*Gegeben und Annahmen*

Kapitalstruktur und Risiko (Teil A5, wie Folie 49/50): Eine GmbH kauft eine Maschine für 150.000 € und behält 50.000 € in der Kasse. A: 200.000 € EK. B: 40.000 € EK + 160.000 € FK zu 8 % (Zinsen aus der Kasse bezahlt). Die Maschine verliert 30.000 € an Wert.

*Gesucht*

#enum(numbering: "a)",
[Stelle beide Bilanzen zum Jahresende auf. Liegt Überschuldung vor?],
)

#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü14. Verfahren: #stelle(<a-1-11>).]
][
*Modell:* Wertverlust 30.000 €, Zinsen aus der Kasse; keine sonstigen Veränderungen.
][
*A:* Maschine 120.000 + Kasse 50.000 = Vermögen und EK *170.000 €*.
][
*B:* Zins $"0,08" times 160000=12800$ €, Kasse 37.200 €, Vermögen $120000+37200=157200$ €. FK 160.000 €, rechnerisches EK $40000-30000-12800=-2800$ €.
][
*Ergebnis: B hat 2.800 € bilanziellen Fehlbetrag.* *Prüfung:* Geschäftsverlust identisch; unterschiedliche Finanzierung erzeugt Zinslast und kleineres Polster. Rechtliche Überschuldung gesondert prüfen.
]

// 0-67
#aufgabe(titel: "Finanzierungsformen außen, innen, EK, FK", art: "verstehen", quelle: "1.2")[
#if not web [*Aufgabe 67* #linebreak()]
#text("Finanzierungsformen (Teil A2): Ordne zu (Nr. 1–9 nach Drukarczyk, außen/innen, EK/FK): a) Ausgabe neuer Aktien an neue Aktionäre, b) Gewinn wird einbehalten, c) Verkauf einer nicht mehr benötigten Halle, d) Ausgabe einer Anleihe, e) die bisherigen Gesellschafter erhöhen ihre Einlage.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü15. Verfahren: #stelle(<a-1-2>).]
][
a) Nr. 4 Beteiligungsfinanzierung: außen, EK. b) Nr. 6 offene Selbstfinanzierung: innen, EK. c) Nr. 9 Vermögensumschichtung: innen; der Verkauf ist keine neue EK-/FK-Aufnahme. d) Nr. 1 Fremdfinanzierung: außen, FK. e) Nr. 3 Eigenfinanzierung: außen, EK. *Prüfung:* Erst Herkunft, danach Rechte prüfen; nicht jede Innenmaßnahme ist eine neue Kapitalaufnahme.
]

// 0-68
#aufgabe(titel: "Insolvenzgrund und Gegenmaßnahme", art: "verstehen", quelle: "1.8")[
#if not web [*Aufgabe 68* #linebreak()]
#text("Insolvenzgründe (Teil A5): Bestimme Insolvenzgrund und passende Gegenmaßnahme. (i) GmbH: Vermögen 2,0 Mio. €, Schulden 2,3 Mio. €, keine positive Fortführungsprognose. (ii) Unternehmen kann in drei Wochen nur 70 % der fälligen Rechnungen bezahlen. (iii) GmbH erwartet, eine im März fällige Kreditrate nicht bezahlen zu können.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü16. Verfahren: #stelle(<a-1-8>).]
][
(i) Vermögenslücke 0,3 Mio. € und keine positive Fortführung: Hinweis auf Überschuldung nach § 19, bei passender rechtlicher Bewertung. Ansätze: Einlage, Forderungsverzicht, geeigneter Rangrücktritt. (ii) 30 % nicht begleichbare Lücke: regelmäßig Zahlungsunfähigkeit im vereinfachten Dreiwochenfall; zusätzliche Liquidität oder verbindliche Zahlungsvereinbarungen prüfen. (iii) Erwartete nicht erfüllbare Märzrate: drohende Zahlungsunfähigkeit (§ 18); frühzeitig Finanzplan und Gegenmaßnahmen entwickeln. *Prüfung:* Die Antragspflichten der drei Fälle sind nicht identisch.
]

// 0-69
#aufgabe(titel: "Finanzielle Lage vollständig beurteilen", art: "rechnen", quelle: "1.10")[
#if not web [*Aufgabe 69* #linebreak()]
*Gegeben und Annahmen*

Ein Unternehmen meldet: JÜ 60, Abschreibungen 40, Zuführung zu Pensionsrückstellungen 20. Bilanz: AV 700, UV 300 (davon flüssige Mittel 30, Forderungen 120), EK 200, FK 800 (davon kurzfristig 300) (T€).

*Gesucht*

#enum(numbering: "a)",
[Beurteile die finanzielle Lage so vollständig wie möglich und schlage zwei Maßnahmen vor.],
)

#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü17. Verfahren: #stelle(<a-1-10>).]
][
*CF:* $60+40+20=120$ T€; rechnerische Tilgungsdauer $800/120 approx "6,7"$ Jahre.
][
*Liquidität:* L1 $30/300=10%$, L2 $150/300=50%$, L3 $300/300=100%$.
][
*Struktur:* langfristiges FK $800-300=500$; AD II $(200+500)/700=100%$; AD I ≈ 28,6 %; EK-Quote 20 %, FK-Quote 80 %, Anlageintensität 70 %.
][
*Erfolg:* EK-Rentabilität $60/200=30%$; Umsatzrentabilität mangels Umsatzangabe nicht berechenbar.
][
*Ergebnis:* Langfristige Deckungsregel gerade erfüllt, kurzfristige Deckung nach den Folienzielen schwach. *Prüfung/Maßnahmen:* Kein automatischer Nachweis der Zahlungsunfähigkeit. Zahlungsplan aufstellen, Forderungseinzug/Factoring oder vereinbarte Lieferantenziele prüfen; ggf. Laufzeiten der Finanzierung anpassen.
]

// 0-70
#aufgabe(titel: "Gewinn ersetzt keinen Finanzplan", art: "verstehen", quelle: "1.7")[
#if not web [*Aufgabe 70* #linebreak()]
#text("Eine Gründerin sagt: „Mein Plan zeigt ab Jahr 1 Gewinn, einen Finanzplan brauche ich nicht.“ Nimm begründet Stellung.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü18. Verfahren: #stelle(<a-1-7>).]
][
Gewinn ist keine Zahlungsplanung. Die Gründerin muss Anlauf- und Investitionszahlungen, Kundenzahlungsziele sowie Zins/Tilgung und Reserven erfassen. Im Folienbeispiel 39–40 stehen spätere Gewinne neben negativen Planbeständen. *Prüfung:* Der Finanzplan zeigt Zeitpunkt und Höhe der Lücke; erst eine zugesagte Finanzierung macht das Programm zahlungsfähig.
]

// 0-71
#aufgabe(titel: "FK-Quote von 50 auf 85 Prozent", art: "rechnen", quelle: "1.12")[
#if not web [*Aufgabe 71* #linebreak()]
*Gegeben und Annahmen*

Ein Unternehmen mit rG = 12 % und rf = 7 % will die EK-Rendite steigern und die FK-Quote von 50 % auf 85 % erhöhen.

*Gesucht*

#enum(numbering: "a)",
[Wie verändert sich die EK-Rentabilität?],
[Welche Bedenken hast du?],
)

#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü19. Verfahren: #stelle(<a-1-12>).]
][
*Modell:* $r_G=12%$ und $r_f=7%$ bleiben für die Rechnung konstant.
][
*50 % FK:* $r_e=12%+(12%-7%) times 50/50=17%$.
][
*85 % FK:* $r_e=12%+(12%-7%) times 85/15 approx "40,3"%$.
][
*Ergebnis: 17 % → 40,3 % im Modell.* *Prüfung:* EK-Quote sinkt auf 15 %, Verlustpolster wird klein. In der Praxis können Kreditzins und Bonität reagieren; fällt die Gesamtrendite unter den Kreditzins, wirkt der große Hebel gegen die Eigentümer.
]

// 0-72
#aufgabe(titel: "Warnsignal oder nicht?", art: "verstehen", quelle: "1.6")[
#if not web [*Aufgabe 72* #linebreak()]
#text("Beurteile jeweils, ob das ein Warnsignal ist: a) negativer Cashflow aus Investitionstätigkeit bei hohem operativem Cashflow, b) Gewinn steigt, Kassenbestand sinkt, c) Anlagendeckung II von 80 %.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü20. Verfahren: #stelle(<a-1-6>).]
][
a) Hoher operativer CF und negativer Investitions-CF können selbst finanzierte Investitionen anzeigen; ohne Beträge, Fälligkeiten und Investitionsqualität ist kein pauschales Urteil möglich. b) Steigender Gewinn bei sinkender Kasse ist ein Anlass zur Überleitung, etwa wegen Forderungsaufbau oder Investitionen. c) AD II 80 % verfehlt die goldene Bilanzregel: Ein Teil des Anlagevermögens ist kurzfristig finanziert. *Prüfung:* Kennzahlen sind Warnhinweise und ersetzen nicht den Zahlungsplan.
]

// 0-73
#aufgabe(titel: "Neuer Kredit bei Überschuldung", art: "verstehen", quelle: "1.8")[
#if not web [*Aufgabe 73* #linebreak()]
#text("Ein Kunde deiner Bank ist bilanziell überschuldet und bittet um einen zusätzlichen Kredit, „um die Lücke zu schließen“. Was antwortest du?")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü21. Verfahren: #stelle(<a-1-8>).]
][
Ein gewöhnlicher Kredit vergrößert Vermögen und Schulden um denselben Betrag. Die rechnerische Unterdeckung verschwindet dadurch nicht. Einlage, Forderungsverzicht oder ein rechtlich geeigneter Nachrang sind andere Ansatzpunkte. *Prüfung:* Handelsbilanzieller Fehlbetrag und rechtliche Überschuldung sind getrennt zu prüfen; eine Antragspflicht darf weder allein aus dem Buch-EK behauptet noch bei tatsächlich vorliegendem Grund übergangen werden.
]

// 0-74
#aufgabe(titel: "Glasspinnerei: Finanzplan, Plan-GuV, Planbilanz", art: "verstehen", quelle: "1.13")[
#if not web [*Aufgabe 74* #linebreak()]
#text("Warum benötigt die Glasspinnerei gleichzeitig Finanzplan, Plan-GuV und Planbilanz? Erkläre die Rückkopplung über Zinsen, Steuern und Betriebskapital.")
#src[G, PDF-S. 4 und 7. Verfahren: #stelle(<a-1-13>).]
][
Die Bilanz liefert die operative Kapitalbindung und Finanzierungsbestände. Die GuV liefert Kosten, Abschreibung, Zinsaufwand und die Steuerbasis. Der Finanzplan liefert Mittelbedarf und Kreditaufnahme; daraus folgen wiederum Zinsen. *Prüfung:* Ein isolierter Gewinn genügt für keine vollständige Kapitalbedarfsrechnung.
]

// 0-75
#aufgabe(titel: "Glasspinnerei: Nettoumsatz und Kapazität", art: "rechnen", quelle: "1.13")[
#if not web [*Aufgabe 75* #linebreak()]
*Gegeben und Annahmen*

Glasspinnerei: Absatz 2005 20 000 t, Preis 13 500 €/t; Tageskapazität 75 t bei 365 Tagen im Jahr. Geplantes Mengenwachstum zunächst jährlich 12,5 %; 2006 22 500 t, 2007 rund 25 313 t.

*Gesucht*

#enum(numbering: "a)",
[Berechne den Nettoumsatz 2005.],
[Prüfe, ob das Mengenwachstum 2008 unverändert fortgesetzt werden kann.],
)

#src[G, PDF-S. 3, 5 und 11. Verfahren: #stelle(<a-1-13>).]
][
*Umsatz:* $20000 thin "t" times 13500 thin "€/t"=270000000$ € = *270 Mio. €*.
][
*Kapazität:* $365 times 75=27375$ t/Jahr. Die Mengenreihe 20.000 → 22.500 → rund 25.313 würde bei nochmals 12,5 % darüberliegen. Die Tabelle begrenzt 2008 deshalb auf *27.375 t*.
][
*Prüfung:* Mengen- und Preisannahmen brauchen eine physische Kapazitätsprüfung.
]

// 0-76
#aufgabe(titel: "Glasspinnerei: erweitertes EBK 2004", art: "rechnen", quelle: "1.14")[
#if not web [*Aufgabe 76* #linebreak()]
*Gegeben und Annahmen*

Glasspinnerei 2004, Werte in T€: Lager 23 529, Forderungen 31 564, Lieferverbindlichkeiten 18 884, Rückstellungen für Lizenzen/Löhne 7 744, Steuerrückstellungen 19 348. Erweitertes EBK 2003: −10 914 T€.

*Gesucht*

#enum(numbering: "a)",
[Berechne das erweiterte EBK 2004 und vergleiche mit 2003.],
)

#src[G, PDF-S. 11–12. Verfahren: #stelle(<a-1-14>).]
][
*Bestand:* $23529+31564-18884-7744-19348=9117$ T€.
][
*Änderung:* $9117-(-10914)=20031$ T€.
][
*Ergebnis: EBK 9,117 Mio. €, Zunahme 20,031 Mio. €.* *Prüfung:* Die positive Zunahme bindet Geld. Sie ist vom EBK-Bestand zu unterscheiden.
]

// 0-77
#aufgabe(titel: "Glasspinnerei: erweitertes EBK 2005", art: "rechnen", quelle: "1.14")[
#if not web [*Aufgabe 77* #linebreak()]
*Gegeben und Annahmen*

Glasspinnerei 2005: Nettoumsatz 270 000 T€, LB 9 %, FLei 13 %, VLei 10 %, Lizenzrückstellungen 8 775 T€, Steuerrückstellungen 17 000 T€, EBK 2004 9 117 T€.

*Gesucht*

#enum(numbering: "a)",
[Berechne das erweiterte EBK 2005 und seine Änderung.],
[Erkläre die Wirkung dieser Änderung auf den NOCF.],
)

#src[G, PDF-S. 8 und 11–12. Verfahren: #stelle(<a-1-14>).]
][
*Modell:* Die ausdrücklich fortgeführte VLei-Quote ist 10 %, trotz des markierten Buchfehlers.
][
*Bestände:* LB 24.300, FLei 35.100, VLei 27.000 T€.
][
*EBK:* $24300+35100-27000-8775-17000=6625$ T€.
][
*Änderung:* $6625-9117=-2492$ T€.
][
*Ergebnis: 2,492 Mio. € Freisetzung.* *Prüfung:* In der NOCF-Rechnung wird die negative Änderung abgezogen, wirkt also *positiv*.
]

// 0-78
#aufgabe(titel: "Glasspinnerei: NOCF vor Steuern 2005", art: "rechnen", quelle: "1.14")[
#if not web [*Aufgabe 78* #linebreak()]
*Gegeben und Annahmen*

Glasspinnerei 2005, Werte in T€: Nettoumsatz 270 000, Material 72 000, Löhne 73 828, sonstige betriebliche Aufwendungen 83 359, $Delta "EBK"=-2492$.

*Gesucht*

#enum(numbering: "a)",
[Berechne den NOCF vor Steuern.],
[Erkläre, weshalb keine Abschreibung als Auszahlung abgezogen wird.],
)

#src[G, PDF-S. 11–12. Verfahren: #stelle(<a-1-14>).]
][
*Operative Abgrenzung:* $270000-72000-73828-83359=40813$ T€.
][
*Betriebskapital:* $40813-(-2492)=43305$ T€.
][
*Ergebnis: 43,305 Mio. € NOCF vor Steuern.* *Prüfung:* Die EBK-Freisetzung erhöht den Zahlungsbeitrag. Abschreibung ist keine laufende Auszahlung; ihre Steuerwirkung folgt über die Plan-GuV.
]

// 0-79
#aufgabe(titel: "Glasspinnerei: Sonderabschreibungen", art: "rechnen", quelle: "1.15")[
#if not web [*Aufgabe 79* #linebreak()]
*Gegeben und Annahmen*

Glasspinnerei, historische Abschreibungsannahme: neue Gebäude 30 Mio. € bei zehn Jahren Nutzungsdauer; neue Anlagen 55 Mio. € bei vier Jahren. Im Fall werden 75 % sofort abgeschrieben, der Rest linear über die verbleibenden Jahre.

*Gesucht*

#enum(numbering: "a)",
[Berechne die Abschreibung 2005 und die jährlichen Restabschreibungen beider Investitionen.],
)

#src[G, PDF-S. 4 und 13. Verfahren: #stelle(<a-1-15>).]
][
*Gebäude:* $30 times "0,75"="22,5"$ Mio. € sofort. Rest 7,5 Mio. € über neun Jahre: rund *0,833 Mio. €/Jahr*.
][
*Anlagen:* $55 times "0,75"="41,25"$ Mio. € sofort. Rest 13,75 Mio. € über drei Jahre: rund *4,583 Mio. €/Jahr*.
][
*Prüfung:* Summe aller Abschreibungen über die jeweilige Nutzungsdauer entspricht den Anschaffungskosten. Es handelt sich um historische Fallannahmen.
]

// 0-80
#aufgabe(titel: "Glasspinnerei: Steuer mit Verlustverrechnung", art: "rechnen", quelle: "1.15")[
#if not web [*Aufgabe 80* #linebreak()]
*Gegeben und Annahmen*

Die Plan-GuV nennt 2005 einen Verlust 39.410 T€ und 2006 einen Gewinn vor Verlustverrechnung 45.377 T€.

*Gesucht*

#enum(numbering: "a)",
[Berechne bei der Fall-Steuerquote von 50 % die Steuer 2006. NOCF vor Steuern 2006: 63.912 T€.],
[Wie hoch ist er danach?],
)

#src[G, PDF-S. 14. Verfahren: #stelle(<a-1-15>).]
][
*Modell:* Vollständige Verlustverrechnung entsprechend der Falltabelle, keine heutige steuerrechtliche Behauptung.
][
*Steuerbasis:* $45377-39410=5967$ T€.
][
*Steuer:* $5967 times "0,5"="2983,5"$ T€, tabellarisch gerundet 2.984.
][
*NOCF nach Steuer:* $63912-2984=60928$ T€.
][
*Ergebnis: rund 2,984 Mio. € Steuer und 60,928 Mio. € NOCF.* *Prüfung:* Nicht einfach 50 % des ganzen positiven Ergebnisses besteuern.
]

// 0-81
#aufgabe(titel: "Glasspinnerei: Finanzierungssaldo 2005", art: "rechnen", quelle: "1.15")[
#if not web [*Aufgabe 81* #linebreak()]
*Gegeben und Annahmen*

Glasspinnerei 2005, Werte in T€: NOCF nach Steuern 43 305; bisherige Zinsen 3 214; neue Kredite 20 000 und 5 000; Investitionen 85 000; Dividende 3 120. In dieser Teilrechnung werden keine weiteren Tilgungs-/Rückzahlungen angesetzt. Zum Vergleich vorgegebene Finanzierungssalden 2006–2008: +50 594 / +48 108 / +59 915 T€.

*Gesucht*

#enum(numbering: "a)",
[Berechne den Finanzierungssaldo 2005.],
[Vergleiche den Saldo mit den vorgegebenen Folgejahren und erkläre die zeitliche Finanzierungslücke.],
)

#src[G, PDF-S. 15. Verfahren: #stelle(<a-1-15>).]
][
*Vorläufige Mittel:* $43305-3214=40091$ T€.
][
*Alle gegebenen Entscheidungen:* $40091+20000+5000-85000-3120=-23029$ T€.
][
*Ergebnis: Bedarf 23,029 Mio. €.* Die Tabelle zeigt danach Überschüsse *50,594 / 48,108 / 59,915 Mio. €* für 2006–2008.
][
*Prüfung:* Die Investitionssumme ist nicht der verbleibende Außenfinanzierungsbedarf. Die Lücke 2005 muss trotzdem rechtzeitig gedeckt werden; spätere Überschüsse allein zahlen 2005 nicht.
]

// 0-82
#aufgabe(titel: "Glasspinnerei: Bilanzwerte und Gesellschafterdarlehen", art: "rechnen", quelle: "1.16")[
#if not web [*Aufgabe 82* #linebreak()]
*Gegeben und Annahmen*

Glasspinnerei 2005, Werte in Mio. €: Gebäude-Anfangsbuchwert 38,805; Abschreibung bisheriger Gebäude 3,259; Gebäudezugang 30 mit 75 % Sofortabschreibung. Maschinen-Anfangsbuchwert 16,302; Abschreibung bisheriger Maschinen 10; Maschinenzugang 55 mit 75 % Sofortabschreibung. Bestehende Gesellschafterdarlehen 11; der Plan erhöht sie auf rund 34. Laut Ausgangslage wollen die Eigentümer keine weiteren Mittel geben.

*Gesucht*

#enum(numbering: "a)",
[Berechne die Bilanzwerte 2005 für Gebäude und Maschinen.],
[Erkläre, weshalb die zusätzlich geplanten Gesellschafterdarlehen keine gesicherte Finanzierung sind.],
)

#src[G, PDF-S. 16–19. Verfahren: #stelle(<a-1-16>).]
][
*Gebäude:* $"38,805"-"3,259"+30-"22,5"="43,046"$ Mio. €.
][
*Maschinen:* $"16,302"-10+55-"41,25"="20,052"$ Mio. €.
][
*Darlehen:* Von 11 auf rund 34 Mio. € bedeutet rechnerisch rund 23 Mio. € zusätzliche Mittel. Die Eigentümer wollen laut Ausgangslage keine weiteren Mittel geben; die Annahme schließt die Lücke nur formal.
][
*Prüfung:* Geplante Aufnahme und verbindlich zugesagte Finanzierung sind zu unterscheiden.
]

// 0-83
#aufgabe(titel: "Glasspinnerei: zwei Liquiditätsmaßnahmen", art: "rechnen", quelle: "1.17")[
#if not web [*Aufgabe 83* #linebreak()]
*Gegeben und Annahmen*

Glasspinnerei 2005: Investition 85 Mio. €, davon sollen 20 % auf 2006 verschoben werden. Bei 270 Mio. € Umsatz soll die Forderungsquote von 13 % auf 9,5 % sinken. Erweitertes EBK 2004: 9,117 Mio. €; Basisplan 2005: 6,625 Mio. €. Der bisherige Finanzierungssaldo 2005 beträgt −23,029 Mio. €. Unter den Maßnahmen wird eine EBK-Freisetzung von rund 11,9 Mio. € gegenüber 2004 genannt.

*Gesucht*

#enum(numbering: "a)",
[Berechne die zusätzliche Liquiditätsverbesserung beider Maßnahmen gegenüber dem Basisplan.],
[Unterscheide diese Verbesserung von der genannten EBK-Freisetzung im Maßnahmenplan.],
)

#src[G, PDF-S. 20–21. Verfahren: #stelle(<a-1-17>).]
][
*Investition:* $"0,20" times 85=17$ Mio. € Verschiebung.
][
*Forderungen:* $("0,13"-"0,095") times 270="9,45"$ Mio. € weniger Bindung.
][
*Verbesserung:* $17+"9,45"="26,45"$ Mio. €; gegenüber 23,029 Mio. € Bedarf rund *3,421 Mio. € Überschuss*.
][
*Prüfung:* Die rund 11,9 Mio. € beziehen sich auf das geänderte EBK gegenüber 2004, nicht auf die zusätzliche Wirkung gegenüber dem alten Plan 2005. Die 17 Mio. € werden im Folgejahr fällig.
]

// 0-84
#aufgabe(titel: "Glasspinnerei: lineare statt Sofortabschreibung", art: "rechnen", quelle: "1.18")[
#if not web [*Aufgabe 84* #linebreak()]
*Gegeben und Annahmen*

Neue Gebäude der Glasspinnerei: Anschaffung 30 Mio. €, Nutzungsdauer zehn Jahre. Historischer Basisfall: 75 % Sofortabschreibung und Verlustvortrag 39,41 Mio. €. Alternative: vollständige lineare Abschreibung von Beginn an.

*Gesucht*

#enum(numbering: "a)",
[Vergleiche beide Abschreibungsbeträge und bestimme den geänderten Verlustvortrag.],
[Unterscheide Buchwirkung, Steuerzeitpunkt, tatsächliche Auszahlung und die davon getrennte Insolvenzprüfung.],
)

#src[G, PDF-S. 21–22. Verfahren: #stelle(<a-1-18>).]
][
*Aufwandsunterschied:* $"22,5"-3="19,5"$ Mio. €.
][
*Verlustvortrag:* $"39,41"-"19,50"="19,91"$ Mio. €. Der Fall zeigt danach positives bilanzielles EK.
][
*Prüfung:* Das verschiebt einen steuerlichen Vorteil im historischen Modell und ändert keine bereits bezahlte Investitionssumme. Handelsbilanzielles EK, steuerlicher Effekt und Rechtsüberschuldung sind getrennt zu prüfen; für Letztere gilt insbesondere die aktuelle Zwölfmonatsbetrachtung des § 19.
]

// 0-85
#aufgabe(titel: "Glasspinnerei: Schlussfolgerung für den Kreditgeber", art: "verstehen", quelle: "1.18")[
#if not web [*Aufgabe 85* #linebreak()]
#text("Formuliere die Schlussfolgerung der Glasspinnerei für einen Kreditgeber. Welche Rolle spielen Sonderabschreibungen, künftiger NOCF, die vorübergehende Finanzierungslücke und ein qualifizierter Rangrücktritt?")
#src[G, PDF-S. 18–24. Verfahren: #stelle(<a-1-18>).]
][
Der Kreditgeber braucht eine Überleitung: Der hohe bilanzielle Verlust stammt im Modell maßgeblich aus Sonderabschreibungen; das Kerngeschäft erwirtschaftet dennoch hohe Zahlungsüberschüsse. Die Lücke 2005 ist bei tragfähigen Annahmen vorübergehend, erfordert aber eine zugesagte Brücke. Ein geeigneter Nachrang kann für die Überschuldungsprüfung Bedeutung haben, ist jedoch keine automatische Löschung der Schuld oder Auffüllung handelsbilanziellen EK. *Prüfung:* Zukünftige Liquidität, Bilanzbild und rechtliche Voraussetzungen müssen gemeinsam erklärt werden.
]

// 0-86
#aufgabe(titel: "Klausur: Gründung mit 800.000 € Kapital", art: "rechnen", quelle: "1.12")[
#if not web [*Aufgabe 86* #linebreak()]
*Gegeben und Annahmen*

Ein Investor plant eine Unternehmensgründung mit 800.000 € Gesamtkapital. Er kann 300.000 € bis 500.000 € Eigenkapital einbringen, der Rest ist Fremdkapital. Das Unternehmen erwartet jährlich einen Bruttogewinn (Gewinn vor Abzug der Fremdkapitalzinsen) von 70.000 €.

*Gesucht*

#enum(numbering: "a)",
[Ermittle die Gesamtkapitalrentabilität (in %, 2 Nachkommastellen; 2 P.) und die Eigenkapitalrentabilität des Investors (6 P.) für: (1) 500.000 € EK / 300.000 € FK zu 6 %; (2) 300.000 € EK / 500.000 € FK zu 6 %; (3) 500.000 € EK / 300.000 € FK zu 10,5 %; (4) 300.000 € EK / 500.000 € FK zu 10,5 %.],
)

#src[K, PDF-S. 4 (Klausurseite 8). Verfahren: #stelle(<a-1-11>), #stelle(<a-1-12>).]
][
*Modell:* Gesamtkapital in allen Fällen 800.000 €; Bruttogewinn 70.000 € = Gewinn vor FK-Zinsen; Zinsen = Zinssatz × FK; keine Steuern.
][
*Gesamtkapitalrentabilität:* $70000/800000 = "0,0875"$, also *8,75 %*. Sie ist in allen vier Fällen gleich, weil sich nur die Finanzierung ändert.
][
*Zinsen in €, Gewinn nach Zinsen, EK-Rentabilität:*
#tab(columns: (0.5fr, 1fr, 1fr, 0.8fr, 1fr, 1.2fr, 1fr),
 th([Fall], [EK, €], [FK, €], [Zins], [Zinsen, €], [Gewinn nach Zinsen, €], [EK-Rendite]),
 [1], [500.000], [300.000], [6 %], [18.000], [52.000], [*10,40 %*],
 [2], [300.000], [500.000], [6 %], [30.000], [40.000], [*13,33 %*],
 [3], [500.000], [300.000], [10,5 %], [31.500], [38.500], [*7,70 %*],
 [4], [300.000], [500.000], [10,5 %], [52.500], [17.500], [*5,83 %*],
)
Rechenweg Fall 2: $(70000 - "0,06" times 500000)/300000 = 40000/300000 = "13,33" %$.
][
*Prüfung mit der Leverage-Formel:* Fall 2: $"8,75" + ("8,75" - 6) times 500/300 = "13,33"$ %. Fall 4: $"8,75" + ("8,75" - "10,5") times 500/300 = "5,83"$ %. Beide Wege stimmen überein.

#note("Fehler vermeiden", [Nicht den Zinssatz von einer Rendite abziehen (z. B. „14 % − 6 % = 8 %“). Die Zinsen fallen nur auf das FK an. Erst den Zinsbetrag in € abziehen, dann durch das EK teilen. Im Scan der Klausur steht genau dieser Fehler als handschriftliche Antwort und ist als falsch bewertet.], fill: sand)
]

// 0-87
#aufgabe(titel: "Klausur: Leverage deuten und Risiken der Verschuldung", art: "verstehen", quelle: "1.12")[
#if not web [*Aufgabe 87* #linebreak()]
#text("b) Beschreibe den Leverage-Effekt anhand Deiner Ergebnisse aus „Klausur: Gründung mit 800.000 € Kapital“ (2 P.). c) Nenne zwei betriebswirtschaftliche Aspekte, die gegen eine hohe Verschuldung eines Unternehmens sprechen (1 P.).")
#src[K, PDF-S. 5 (Klausurseite 9). Verfahren: #stelle(<a-1-12>), #stelle(<a-1-11>).]
][
*b) Leverage-Effekt an den Ergebnissen:* Bei 6 % FK-Zins liegt die Gesamtkapitalrentabilität (8,75 %) *über* dem Zins. Mehr FK (FK/EK von 0,6 auf 1,67) hebt die EK-Rendite von 10,40 % auf 13,33 %. Bei 10,5 % liegt sie *unter* dem Zins. Derselbe Hebel senkt die EK-Rendite von 7,70 % auf 5,83 %. Die Richtung hängt am Vorzeichen von $r_G - r_f$, die Stärke am Verschuldungsgrad. Zugleich zeigt der Vergleich den *Risikoeffekt*: Steigt der Zins von 6 % auf 10,5 %, fällt die EK-Rendite bei FK/EK = 0,6 um 2,70 Prozentpunkte, bei FK/EK = 1,67 um 7,50 Prozentpunkte.

*c) Zwei Aspekte gegen hohe Verschuldung* (zwei genügen):
- Zins und Tilgung sind fest vereinbart und auch in schlechten Jahren fällig. Das erhöht die Gefahr der Zahlungsunfähigkeit.
- Wenig EK ist ein kleines Verlustpolster. Verluste führen schneller zur Überschuldung (vgl. Hubert + Maier, Alternative B).
- Risikoeffekt: Die EK-Rendite schwankt stärker; fällt $r_G$ unter $r_f$, wirkt der Hebel gegen die Eigentümer.
- Eine niedrige EK-Quote verschlechtert die Bonität. Neue Kredite können schwerer zu bekommen oder teurer werden (eigene Ergänzung; die Folien nennen die Bonitätswirkung der EK-Quote).

*Prüfung:* „Niemand finanziert mehr“ oder „Personal muss gekürzt werden“ (Antworten im Scan) sind keine begründeten Finanzierungsaspekte und wurden nur teilweise gewertet.
]

// 0-88
#aufgabe(titel: "Klausur: Cashflow der Rhein GmbH", art: "rechnen", quelle: "1.5")[
#if not web [*Aufgabe 88* #linebreak()]
*Gegeben und Annahmen*

Die Rhein GmbH legt für 2015 diese GuV vor (Mio. €): Materialaufwand 21, Personalaufwand 23, Aufwand aus Zuführung zu Pensionsrückstellungen 4, Abschreibungen 7, sonstiger Aufwand 5, Jahresüberschuss 9; Umsatzerlöse 69.

*Gesucht*

#enum(numbering: "a)",
[Berechne den Cashflow 2015 nach der direkten und nach der indirekten Methode. Alle zahlungswirksamen Positionen waren im Jahr der Verbuchung tatsächlich voll zahlungswirksam.],
)

#src[K, PDF-S. 6 (Klausurseite 10). Verfahren: #stelle(<a-1-5>).]
][
*Modell:* Laut Aufgabe sind alle zahlungswirksamen Positionen 2015 voll bezahlt. Nicht zahlungswirksam sind die Abschreibungen (7) und die Zuführung zu den Pensionsrückstellungen (4).
][
*Kontrolle der GuV:* $69 - (21 + 23 + 4 + 7 + 5) = 69 - 60 = 9$ Mio. € = Jahresüberschuss.
][
*Direkte Methode:* $69 - 21 - 23 - 5 = 20$ Mio. €.
][
*Indirekte Methode:* $9 + 7 + 4 = 20$ Mio. €.
][
*Ergebnis: Cashflow 2015 = 20 Mio. €* nach beiden Methoden. *Prüfung:* Der Unterschied zum Jahresüberschuss (11 Mio. €) entspricht genau den Aufwendungen ohne Auszahlung.
]

// 0-89
#aufgabe(titel: "Klausur: weitere Formen der Innenfinanzierung", art: "verstehen", quelle: "1.2")[
#if not web [*Aufgabe 89* #linebreak()]
#text("Nenne zwei weitere Formen der Innenfinanzierung, die einem Unternehmen neben der Selbstfinanzierung zur Verfügung stehen.")
#src[K, PDF-S. 6 (Klausurseite 10). Verfahren: #stelle(<a-1-2>), #stelle(<a-1-5>).]
][
Zwei der folgenden Formen:
- *Vermögensumschichtung:* nicht mehr benötigte Vermögensgegenstände entgeltlich verkaufen (Folie 9).
- *Finanzierung aus Abschreibungen:* Abschreibungsgegenwerte fließen über bezahlte Umsatzerlöse zurück (Pizzeria, Folie 21).
- *Finanzierung aus Rückstellungen:* Aufwand ist gebucht, die Auszahlung kommt erst später.

In „Klausur: Cashflow der Rhein GmbH“ sind das genau die 7 Mio. € Abschreibungen und die 4 Mio. € Zuführung zu Pensionsrückstellungen. Ausführlich behandelt die Vorlesung beide Formen erst in Kapitel C (V, PDF-S. 108 und 111, Folien 215 und 221–222).

*Prüfung:* Außen- oder Fremdfinanzierung (Antwort im Scan) sind keine Innenfinanzierung, denn die Mittel kommen von außen.
]



// Ergänzung VL 28.10./04.11.2026
#aufgabe(titel: "Vorlesung: fundamentale Aktienkennzahlen", art: "rechnen", quelle: "1.19", ergebnis: [Bilanzkurs 2,98 €; Ertragswertkurs 2,90 €; KGV 7,5; Gewinnrendite 13,33 %; Dividendenrendite 2,5 %; Cashflow Ratio 6,62.], tipp: [Erst die Aktienzahl aus Grundkapital und Nominalwert bestimmen. Danach immer fragen: Welche Größe steht im Nenner?])[
#if not web [*Aufgabe 90* #linebreak()]
*Gegeben und Annahmen*
Bilanz in T€: Grundstück 300, Maschinen 400, Umlaufvermögen 352; Grundkapital 400, gesetzliche Rücklagen 20, freie Rücklagen 42, Jahresüberschuss 30, FK 560. Zusätzlich: Cashflow 145 T€, stille Reserven 700 T€, erwarteter gleichbleibender Jahresgewinn 116 T€, Kalkulationszins 10 %, Nominalwert 1 €/Aktie, Börsenkurs 2,40 €, separat vorgegebener Gewinn je Aktie 0,32 €, Dividende je Aktie 0,06 €. Keine Wachstumsrate im Ertragswertmodell.
*Gesucht*
#enum(numbering: "a)")[Aktienzahl, bilanzielles EK und korrigierter Bilanzkurs.][Ertragswertkurs, KGV, Gewinnrendite zum Kurs, Dividendenrendite und Cashflow Ratio.][Vergleiche die Gewinnrendite zum Kurs mit JÜ/EK und prüfe die Konsistenz des vorgegebenen Gewinns je Aktie.]
#src[V, PDF-S. 28–30, Folien 56–59; N28, PDF-S. 2–4. Eigene Prüfung der Musterlösung.]
][
*Bezugsgrößen aufstellen:* Die 400 T€ Grundkapital sind 400.000 €. Bei 1 € Nominalwert gibt es $N=400000$ Aktien. Bilanzielles EK: $(400+20+42+30)=492$ T€. Der JÜ ist Bestandteil des EK und wird hier nicht weggelassen.
][
*Substanz auf Aktien verteilen:* Korrigiertes EK $492+700=1192$ T€. Bilanzkurs $1192000/400000="2,98"$ €/Aktie. Relativ sind es $1192/400=298%$ des Nominalwerts.
][
*Künftigen Gewinn kapitalisieren:* Bei konstanter ewiger Gewinnreihe beträgt der Ertragswert $116000/"0,10"=1160000$ €. Je Aktie $1160000/400000="2,90"$ €. Die Aussage 2,60 € auf Folie 57 ist falsch; Folie 58 rechnet selbst 2,90 €.
][
*Kursrelationen berechnen:* Für diese Kennzahlen gilt der separat angegebene Gewinn je Aktie: KGV $"2,40"/"0,32"="7,5"$. Gewinnrendite $"0,32"/"2,40" times 100% approx "13,33"%$. Dividendenrendite $"0,06"/"2,40" times 100%="2,5"%$.
][
*Cashflow auf dieselbe Stückzahl beziehen:* $145000/400000="0,3625"$ € CF/Aktie; Cashflow Ratio $"2,40"/"0,3625" approx "6,62"$. Kurs und CF je Aktie müssen in derselben Währung eingesetzt werden.
][
*Widerspruch prüfen:* JÜ/EK beträgt $30/492 times 100% approx "6,10"%$, nicht 13,33 %. Außerdem ergeben 30 T€ JÜ bei 400.000 Aktien nur 0,075 €/Aktie. Die gegebenen 0,32 € passen nicht dazu. Die Folienrechnung zu 13,3 % ist als Gewinnrendite zum Börsenkurs nachvollziehbar, ihre Bezeichnung „Eigenkapitalrendite“ ist mit Abschnitt 1.11 unvereinbar. Die Daten nicht still gleichsetzen.
]


// Ergänzung VL 28.10./04.11.2026
#aufgabe(titel: "Vorlesung: maximaler Kapitalbedarf des Umlaufvermögens", art: "rechnen", quelle: "1.20", ergebnis: [341.250 €], tipp: [Zeichne den Tag der Kundenzahlung und ziehe für jede Kostenart ihren Auszahlungstag ab.])[
#if not web [*Aufgabe 91* #linebreak()]
*Gegeben und Annahmen*
Umsatz 1,8 Mio. €/Jahr; davon Material 40 %, Lohn 25 %, Herstellgemeinkosten (HGK) 10 %, Verwaltungs-/Vertriebsgemeinkosten (VVGK) 10 %. Beschaffungssynchrone Fertigung, gleichmäßige Tagesausgaben und 360-Tage-Rechenjahr wie in der Folienlösung. Fertigung 60 Tage, Fertiglager 15 Tage, Debitorenfrist 45 Tage. Materialzahlung nach 60 Tagen Kreditorenfrist; Lohnzahlung 15 Tage nach Produktionsbeginn, HGK sofort, VVGK am Tag 60. Kundenzahlung nach Fertigung, Lager und Debitorenfrist. Keine weiteren Auszahlungen im Modell.
*Gesucht*
#enum(numbering: "a)")[Kundenzahlungstag und Bindungsdauer jeder Kostenart.][Jahres- und Tagesausgaben sowie maximalen UV-Kapitalbedarf.]
#src[V, PDF-S. 31–32, Folien 61–63; N28, PDF-S. 5–6. „Herstellkosten unmittelbar“ wird entsprechend Grafik/Tabelle als HGK interpretiert.]
][
*Zeitachse bestimmen:* Der Kunde zahlt $60+15+45=120$ Tage nach Produktionsbeginn. Bis dahin müssen die bereits bezahlten Kosten vorfinanziert werden. Die Auszahlung startet die jeweilige Bindung.
][
*Bindungsdauer ableiten:* Material $120-60=60$ Tage; Lohn $120-15=105$ Tage; HGK $120-0=120$ Tage; VVGK $120-60=60$ Tage. Die Kreditorenfrist verkürzt nur die zugehörige Materialbindung.
][
*Tagesausgaben bilden:* Material $1800000 times "0,40"/360=2000$ €/Tag; Lohn $1800000 times "0,25"/360=1250$ €/Tag; HGK und VVGK jeweils $180000/360=500$ €/Tag. Die Jahresbeträge sind 720.000 / 450.000 / 180.000 / 180.000 €. Umsatz ist nicht vollständig Auszahlung.
][
*Kostenartweise vorfinanzieren:* Material $2000 times 60=120000$ €; Lohn $1250 times 105=131250$ €; HGK $500 times 120=60000$ €; VVGK $500 times 60=30000$ €. Jeder Betrag hat die Einheit €/Tag × Tage = €.
][
*Addieren und prüfen:* $120000+131250+60000+30000=341250$ €. Das ist der maximale UV-Kapitalbedarf des gleichmäßigen Folienmodells. Er ist kein zusätzlicher Gewinn und nicht das pauschale Produkt aus allen Tageskosten und 120 Tagen, weil die Auszahlungstermine verschieden sind.
]


// Ergänzung VL 28.10./04.11.2026
#aufgabe(titel: "Vorlesung: Finanzplan als Primärplan", art: "verstehen", quelle: "1.21")[
#if not web [*Aufgabe 92* #linebreak()]
Nenne die kurzfristigen und langfristigen Aufgaben der Finanzplanung. Erkläre, wann der Finanzplan zum Primärplan wird und welchen Beitrag Kennzahlen leisten.
#src[V, PDF-S. 32–33, Folien 64–66; N28, PDF-S. 6–7, Übungsaufgabe 1.]
][
*Kurzfristig sichern:* Zahlungsbereitschaft erhalten, Fehlbeträge vermeiden, Fristen sinnvoll nutzen und vorübergehende Überschüsse passend anlegen. Die Fälligkeit ist entscheidend.
][
*Langfristig abstimmen:* Rechtzeitig geeignete Finanzierung beschaffen, Ursachen veränderter Zahlungsströme zeigen und das Geschäftsprogramm finanzierbar gestalten.
][
*Engpass erklären:* Wird die Kapitalbeschaffung knapp, setzt der Finanzplan den Rahmen für Absatz, Produktion und Investition. Dieser Minimumsektor begrenzt die anderen Teilpläne.
][
*Kennzahlen nutzen:* Ziele vorgeben, Soll und Ist sowie Zeiträume, Branche und Konkurrenz vergleichen. Sie ergänzen die Planung; Bestandsrelationen ersetzen keinen Terminplan.
]


// Ergänzung VL 28.10./04.11.2026
#aufgabe(titel: "Vorlesung: Monatsfinanzplan mit zwei Abwandlungen", art: "rechnen", quelle: "1.7", ergebnis: [Grundfall 3.050 / 1.900 / 2.450 €; Abwandlung 50 / −1.100 / −550 €; Linie im Februar um 100 € zu klein.])[
#if not web [*Aufgabe 93* #linebreak()]
*Gegeben und Annahmen*
Anfangsbestand am 1. Januar 0 € (wie in der Folienlösung), monatlich zu zahlende Miete 1.000 € und Löhne 450 €. Einzahlungen aus Umsatz: Januar 4.000 €, Februar 300 €, März 2.000 €; USt-Erstattung im Januar 500 €. Jahresabschreibung 5.000 €, ohne weitere Zahlungen dafür in diesen Monaten. Keine weiteren Ein-/Auszahlungen. Monatssalden-Modell; untermonatliche Fälligkeiten nicht vorgegeben.
*Gesucht*
#enum(numbering: "a)")[Monatssalden und fortgeschriebene Endbestände im Grundfall.][Dieselben Größen, wenn die Umsatzeinzahlung im Januar nur 1.000 € beträgt.][Reicht im abgewandelten Fall eine bisher ungenutzte Kontokorrentlinie von 1.000 €?]
#src[V, PDF-S. 34, Folien 67–68; N28, PDF-S. 8, Übungsaufgabe 2.]
][
*Zahlungsmodell wählen:* Miete und Löhne kosten zusammen $1000+450=1450$ €/Monat. Die Abschreibung ist Aufwand, keine zusätzliche aktuelle Auszahlung. Die USt-Erstattung ist dagegen ein Geldzufluss.
][
*Grundfall rechnen:* Januar $4000+500-1450=3050$ €; Februar $300-1450=-1150$ €; März $2000-1450=550$ €. Diese Werte sind die monatlichen Änderungen.
][
*Bestände fortschreiben:* Mit Anfang 0: Januar 3.050 €, Februar $3050-1150=1900$ €, März $1900+550=2450$ €. Im Monatsendmodell bleibt der Bestand positiv; daraus folgt ohne Termine kein Beweis für jeden einzelnen Tag.
][
*Abwandlung berechnen:* Januar $1000+500-1450=50$ €; danach Endbestände $50-1150=-1100$ € und $-1100+550=-550$ €. Der positive Märzsaldo beseitigt die frühere ungedeckte Lücke nicht rechtzeitig.
][
*Kreditlinie prüfen:* Der höchste Bedarf beträgt 1.100 € Ende Februar. Die Linie von 1.000 € reicht um 100 € nicht. Im März wären noch 550 € Kredit genutzt, falls die Februar-Lücke rechtzeitig zusätzlich gedeckt wird. Kreditaufnahme nicht als selbst erwirtschafteten Cashflow behandeln.
]


// Ergänzung VL 28.10./04.11.2026
#aufgabe(titel: "Vorlesung: Quartalsplan und widersprüchliche Ausgabenbegriffe", art: "rechnen", quelle: "1.21.1", ergebnis: [Folienrechnung: Ende 315 / 170 / −645 T€. Eigene reine Zahlungsvariante: 915 / 1.390 / 1.475 T€. Nettomonetäres UV aus den Angaben nicht eindeutig bestimmt.])[
#if not web [*Aufgabe 94* #linebreak()]
*Gegeben und Annahmen*
Alle Werte in T€, Anfang 80. Die Originaltabelle nennt:
#tab(columns: (2fr,1fr,1fr,1fr),th([Zeile],[Q1],[Q2],[Q3]),
[Barverkäufe],[450],[300],[300], [Debitoreneingänge],[500],[600],[200], [Gutschriftenerträge / in der Lösung Wertschriftenerträge],[150],[120],[100],
[Lohnaufwand],[100],[120],[100], [Barlöhne],[50],[30],[0], [Miete],[10],[10],[10], [Wareneinkauf auf Kredit],[500],[500],[800], [Lieferantenrechnungen],[200],[500],[500], [Zinsen],[5],[5],[5],)
*Gesucht*
#enum(numbering: "a)")[Rechne wie Folie 71: alle Einnahmenzeilen und alle Ausgabenzeilen jeweils addieren, Salden und Bestände fortschreiben.][Erkläre, warum das noch keinen eindeutig belegten Kassenbestand ergibt.][Rechne eine eigene reine Zahlungsvariante: Alle Einnahmenzeilen seien tatsächlich bezahlt; Auszahlungen seien ausschließlich Barlöhne, Miete, bezahlte Lieferantenrechnungen und Zinsen. Die anderen beiden Zeilen seien unbare Buchungen. Ist damit auch das nettomonetäre UV bestimmt?]
#src[V, PDF-S. 35–36, Folien 69–71; N28, PDF-S. 9–10, Übungsaufgabe 3. Teil c ist ausdrücklich eine eigene Abgrenzungsvariante.]
][
*Folienmodell abbilden:* Einzahlungen laut Summierung: $450+500+150=1100$, $300+600+120=1020$, $300+200+100=600$ T€. Die Lösung benennt die dritte Einnahmenzeile anders als die Aufgabe; hier bleibt der vorgegebene Betrag gleich.
][
*Alle Ausgabenzeilen summieren:* Q1 $100+50+10+500+200+5=865$; Q2 $120+30+10+500+500+5=1165$; Q3 $100+0+10+800+500+5=1415$ T€. Folien-Salden: $235$, $-145$, $-815$ T€.
][
*Folienbestände fortschreiben:* $80+235=315$, $315-145=170$, $170-815=-645$ T€. Das reproduziert die Musterlösung. Der negative Planwert bezeichnet in diesem Rechenschema einen Bedarf, keine negative Bargeldmenge.
][
*Abgrenzung prüfen:* Aufwand ist keine Zahlungsangabe. Einkauf auf Kredit führt zunächst zu einer Verbindlichkeit, nicht zur Auszahlung. Bei Lieferantenrechnungen ist ebenfalls der Zahlungsvorgang zu klären. Die Originalangaben trennen die Fortschreibung der Forderungen/Verbindlichkeiten und die tatsächlichen Zahlungen nicht hinreichend; alle Zeilen als Auszahlungen zu lernen wäre falsch.
][
*Reine Zahlungsvariante rechnen:* Auszahlungen $50+10+200+5=265$, $30+10+500+5=545$, $0+10+500+5=515$ T€. Salden 835 / 475 / 85 T€. Kasse Ende: 915 / 1.390 / 1.475 T€. Diese Ergebnisse gelten nur unter den ausdrücklich zusätzlichen Annahmen von c).
][
*Bestandsfrage offenhalten:* Für nettomonetäres UV sind zusätzlich liquide Mittel plus kurzfristige Forderungen minus kurzfristige Verbindlichkeiten nötig. Deren vollständige Anfangsbestände und Bewegungen fehlen. Weder −645 T€ noch 1.475 T€ dürfen ohne diese Daten als eindeutiger Endbestand des nettomonetären UV ausgegeben werden.
]


// Ergänzung VL 28.10./04.11.2026
#aufgabe(titel: "Vorlesung: Funktionen finanzwirtschaftlicher Kennzahlen", art: "verstehen", quelle: "1.21")[
#if not web [*Aufgabe 95* #linebreak()]
Wofür können Rentabilität, Liquidität, Verschuldungsgrad und Anlagendeckung verwendet werden? Nenne mindestens fünf Funktionen und erläutere eine Grenze ihrer Aussagekraft.
#src[V, PDF-S. 36–37, Folien 72–73; N28, PDF-S. 10–11, Übungsaufgabe 4.]
][
*Funktionen benennen:* Zielvorgaben/Führung, Soll-Ist-Kontrolle, Zeitvergleich, Branchenvergleich, Konkurrenzanalyse, Analyse von Kapitalstruktur und Kapitalbedarf. Standardisierte Definitionen vereinfachen die Kontrolle.
][
*Vergleich begründen:* Eine Abweichung zeigt einen Prüfbedarf. Erst konsistente Bezugsgrößen und die Untersuchung ihrer Ursachen erlauben eine belastbare Bewertung.
][
*Grenze erklären:* Bestandsquoten zeigen keine vollständigen künftigen Fälligkeiten. Ein hoher Liquiditätsgrad kann trotz unbezahlter Vorräte/Forderungen mit einem zeitlichen Engpass zusammenfallen. Für die Zahlungstermine braucht man den Finanzplan.
]


// Ergänzung VL 28.10./04.11.2026
#aufgabe(titel: "Vorlesung: Darlehen für das Sanitärgeschäft beurteilen", art: "rechnen", quelle: "1.21.2", ergebnis: [EK-Rentabilität 8,61 %, Netto-GK 5,65 %; L1/L2/L3 226,32 / 236,84 / 710,53 %; EK-Quote 66,56 %; AD I/II 83,85 / 122,31 %.])[
#if not web [*Aufgabe 96* #linebreak()]
*Gegeben und Annahmen*
Darlehenswunsch mindestens 15.000 €. Bilanz in €: Lagerhalle 40.000; Fahrzeuge 12.000; Materiallager 9.000; Debitoren 200; Kasse 300; Bank 4.000. Passiva: gezeichnetes Kapital 30.000, Rücklagen 10.000, Gewinnvortrag 3.600, kurzfristiger Bankkredit 1.500, langfristiger Bankkredit 20.000, Lieferantenkredit 400. Summe 65.500. Wie in der Folienlösung: Gewinnvortrag sei Jahresgewinn, im Jahr gleichmäßig entstanden; alle anderen Kapitalpositionen seien unverändert. Flüssige Mittel seien verfügbar, Forderungen kurzfristig. Zinsaufwand nicht angegeben.
*Gesucht*
#enum(numbering: "a)")[EK- und Netto-GK-Rentabilität bezogen auf Durchschnittskapital.][Liquidität 1.–3. Grades, Eigenfinanzierungsgrad/EK-Quote und Anlagendeckung I/II zum Bilanzstichtag.][Begründete vorläufige Kreditbeurteilung und zusätzliche Informationen. Ist die GK-Rentabilität vor FK-Zinsen berechenbar?]
#src[V, PDF-S. 37–38, Folien 74–76; N28, PDF-S. 11–12, Übungsaufgabe 5.]
][
*Bestände gliedern:* EK $30000+10000+3600=43600$ €, AV $40000+12000=52000$ €, UV $9000+200+300+4000=13500$ €, kurzfristiges FK $1500+400=1900$ €. Beide Bilanzseiten ergeben 65.500 €.
][
*Durchschnittskapital begründen:* Ohne den erst im Jahr entstandenen Gewinn betrug EK zu Beginn 40.000 €, GK 61.900 €. Bei gleichmäßigem Gewinnanfall ist der mittlere Gewinnanteil 1.800 €. Daher mittleres EK 41.800 €, mittleres GK 63.700 €.
][
*Rentabilitäten nach Folie berechnen:* EK $3600/41800 times 100% approx "8,61"%$; Netto-GK $3600/63700 times 100% approx "5,65"%$. Für eine Gesamtkapitalrentabilität vor FK-Zinsen müsste zum Gewinn der Zinsaufwand addiert werden; der fehlt. Die Nettozahl ist nicht identisch mit der Leverage-Gesamtrendite.
][
*Liquidität rechnen:* Flüssige Mittel $300+4000=4300$ €. L1 $4300/1900 times 100% approx "226,32"%$, L2 $4500/1900 times 100% approx "236,84"%$, L3 $13500/1900 times 100% approx "710,53"%$. Die hohen Quoten sind keine Garantie für die künftige Schuldendienstfähigkeit.
][
*Finanzierungsstruktur prüfen:* EK-Quote $43600/65500 times 100% approx "66,56"%$. AD I $43600/52000 times 100% approx "83,85"%$; AD II $(43600+20000)/52000 times 100% approx "122,31"%$. Langfristiges Kapital deckt AV im Bilanzbild.
][
*Kreditentscheidung begründen:* Die Folie sieht geringe Rentabilität und hohen Lagerbestand kritisch und nennt eine mögliche Besicherung über die Halle. Daraus folgt keine automatische Zusage oder Ablehnung: Aufträge, Margen, Lagerumschlag, Investitionszweck, künftigen Finanzplan mit Zins/Tilgung, persönliche/wirtschaftliche Kreditwürdigkeit und bereits bestehende Belastungen der Halle prüfen. Hohe Liquiditätsquoten allein beweisen kein schlechtes Management.
]


// Ergänzung VL 28.10./04.11.2026
#aufgabe(titel: "Vorlesung: Aussagekraft und Grenzen des Cashflows", art: "verstehen", quelle: "1.21")[
#if not web [*Aufgabe 97* #linebreak()]
Erkläre, was der betriebliche Cashflow über Innenfinanzierung aussagt, warum er den Gewinn ergänzt und welche Grenzen seine Verwendung hat.
#src[V, PDF-S. 39, Folien 77–78; N28, PDF-S. 13, Übungsaufgabe 6.]
][
*Zahlungskraft erklären:* Der operative Cashflow beschreibt Mittel aus der betrieblichen Tätigkeit. Er hilft einzuschätzen, ob das Unternehmen Investitionen, Tilgungen und Ausschüttungen aus dem Geschäft tragen kann.
][
*Gewinn ergänzen:* Abschreibungen und Rückstellungsänderungen können Erfolg und Zahlung auseinanderfallen lassen. Die indirekte Rechnung korrigiert passende Unterschiede; eine Abschreibung erzeugt selbst keine Einzahlung.
][
*Grenzen nennen:* Abgrenzung und vollständige Informationen sind nötig; gerade nicht börsennotierte Unternehmen veröffentlichen sie oft nicht vollständig. Fälligkeiten, Investitionsbedarf und Risiken sind zusätzlich zu prüfen. Ein Kredit-Cashflow ist kein selbst erwirtschafteter operativer Überschuss.
]


#kapitel("Kapitel 2 · Fremdfinanzierung")


// Ergänzung VL 28.10./04.11.2026
#aufgabe(titel: "Gläubigerrisiko trotz festem Zahlungsanspruch", art: "verstehen", quelle: "2.1")[
#if not web [*Aufgabe 98* #linebreak()]
Eine Bank vereinbart feste Zins- und Tilgungszahlungen. Warum besteht trotzdem Risiko? Erkläre Informationsasymmetrie, spätere Entscheidungen des Schuldners und eine unerwartete Veränderung des Umfelds.
#src[V, PDF-S. 40–41, Folien 80–82; eigene Erklärfrage.]
][
*Anspruch und Erfüllung trennen:* Der Vertrag begründet die Pflicht. Ob genügend Mittel zur Erfüllung entstehen, ist eine wirtschaftliche Frage.
][
*Information prüfen:* Der Schuldner kennt sein Geschäft oft genauer. Der Gläubiger kann Einzahlungen überschätzen oder bereits bestehende weitere Kredite übersehen.
][
*Nachträgliche Veränderungen erklären:* Riskante Investitionen, zusätzliche Verschuldung und Ausschüttungen können den Puffer verkleinern; ein unerwarteter Markteinbruch kann beide Seiten überraschen. Deshalb werden Unternehmen, Märkte und Gesamtwirtschaft beurteilt.
]


// Ergänzung VL 28.10./04.11.2026
#aufgabe(titel: "Kreditfähigkeit, Kreditwürdigkeit und Sicherheiten unterscheiden", art: "verstehen", quelle: "2.2")[
#if not web [*Aufgabe 99* #linebreak()]
Ein Betrieb legt eine gute Bilanz und eine Halle als Sicherheit vor. Reicht das für eine Kreditentscheidung? Trenne Kreditfähigkeit, persönliche und wirtschaftliche Kreditwürdigkeit und Sicherheit; nenne passende Unterlagen.
#src[V, PDF-S. 42–43, Folien 83–86; eigene Erklärfrage.]
][
*Kreditfähigkeit prüfen:* Kann der Antragsteller wirksam handeln, und ist die handelnde Person vertretungsbefugt? Dafür können Handelsregister und Gesellschaftsvertrag wichtig sein.
][
*Kreditwürdigkeit prüfen:* Persönlich zählen Verlässlichkeit und bisheriges Zahlungsverhalten; wirtschaftlich zählen künftige Erträge, Cashflow, Finanzplan, Auftragsbestand und Markt. Ein Jahresabschluss beschreibt die Vergangenheit und ersetzt den künftigen Schuldendienstplan nicht.
][
*Sicherheit ergänzen:* Wert und Rang der Halle sowie bestehende Belastungen prüfen. Eine Sicherheit begrenzt möglichen Verlust, garantiert aber weder rechtliche Wirksamkeit des Vertrags noch laufende Zins-/Tilgungszahlungen. § 18 KWG nicht pauschal ohne seine Voraussetzungen auf jeden Fall übertragen.
]


// Ergänzung VL 28.10./04.11.2026
#aufgabe(titel: "Vorlesung: Basel-II-Unterlegung und Kreditvolumen", art: "rechnen", quelle: "2.3", ergebnis: [12 Mio. € Unterlegung; 31,25 Mrd. € rechnerisches Kreditvolumen.])[
#if not web [*Aufgabe 100* #linebreak()]
*Gegeben und Annahmen*
Verfügbares Bank-EK 2,5 Mrd. €. Unternehmenskredit 100 Mio. €, Risikogewicht 150 %. Vereinfachtes Folienmodell: Unterlegung = Kreditbetrag × 8 % × Risikogewicht; keine weiteren Puffer, Risiken oder bindenden Grenzen. Für Teil b) sei das durchschnittliche Gewicht 100 %, das gesamte EK dafür verfügbar.
*Gesucht*
#enum(numbering: "a)")[EK-Unterlegung für den einzelnen Kredit.][Maximales gesamtes Kreditvolumen bei durchschnittlich 100 % Risikogewicht.][Erkläre, wem das unterlegte EK gehört.]
#src[V, PDF-S. 43–44, Folien 85 und 87; N04, PDF-S. 1–2.]
][
*Risikobetrag bestimmen:* 150 % als Faktor ist 1,5, nicht 150. RWA $100 times "1,5"=150$ Mio. €. Der Risikobetrag ist nicht die Auszahlung an den Kunden.
][
*Unterlegung rechnen:* $150 times "0,08"=12$ Mio. €. Das sind 12 % des Nominalkredits, weil die 8 % auf den risikogewichteten Betrag wirken.
][
*Volumenformel umstellen:* $"2,5"/("0,08" times 1)="31,25"$ Mrd. €. Kontrolle: 8 % von 31,25 Mrd. € sind 2,5 Mrd. €. Dieses theoretische Maximum gilt nur innerhalb der gegebenen Vereinfachungen.
][
*Bankbilanz erklären:* Der Kredit steht als Forderung auf der Aktivseite der Bank, das unterlegte EK als Verlustpuffer auf ihrer Passivseite. Der Kreditnehmer erhält dadurch keine zusätzliche EK-Einlage.
]


// Ergänzung VL 28.10./04.11.2026
#aufgabe(titel: "Rating und Basel-Quoten richtig vergleichen", art: "verstehen", quelle: "2.3")[
#if not web [*Aufgabe 101* #linebreak()]
Unterscheide internes und externes Rating. Warum kann man 7 % hartes Kernkapital, 10,5 % Gesamtkapital und 3 % Leverage Ratio nicht als drei vergleichbare Unternehmens-EK-Quoten lesen?
#src[V, PDF-S. 43–44 und 49, Folien 85–88 und 97; Präzisierungen nach den Primärquellen in Abschnitt 2.3.]
][
*Urheber unterscheiden:* Intern bewertet die Bank ihren Kunden; extern bewertet eine Agentur Schuldner-/Emittentenrisiken. Eine gute Note ist keine Garantie, und die Skalen verschiedener Agenturen sind nicht wortgleich.
][
*Risikogewichtete Quoten erklären:* Im einfachen Basel-III-Schema ergeben 4,5 % Mindest-CET1 plus 2,5 % Kapitalerhaltungspuffer 7 %; 8 % Mindestgesamtkapital plus derselbe Puffer ergeben 10,5 %. Nenner sind RWA.
][
*Leverage Ratio abgrenzen:* Kernkapital geteilt durch die nicht risikogewichtete Gesamtrisikopositionsmessgröße, mindestens 3 %. Andere Kapitaldefinition und anderer Nenner als EK/Bilanzsumme eines Unternehmens; außerdem gibt es in der Praxis weitere Anforderungen.
]


// Ergänzung VL 28.10./04.11.2026
#aufgabe(titel: "Krisenmechanismus und Anleihekauf erklären", art: "verstehen", quelle: "2.4.1")[
#if not web [*Aufgabe 102* #linebreak()]
Erkläre den Weg von Kreditverlusten zu schwächerer Bankfinanzierung. Unterscheide danach die Ausgabe einer Staatsanleihe von einem späteren Ankauf durch die Notenbank: Wer erhält jeweils den Kaufpreis?
#src[V, PDF-S. 45–52, Folien 89–104; N04, PDF-S. 9, eigene Skizze; EZB-Präzisierung in Abschnitt 2.4.]
][
*Verstärkungskette erklären:* Ausfälle und Wertberichtigungen belasten Bankkapital. Unsicherheit über die Verluste anderer Banken schwächt Vertrauen und kann Refinanzierung und Kreditvergabe erschweren. Staatshilfen und Geldpolitik setzen an unterschiedlichen Stellen an.
][
*Emission trennen:* Bei Ausgabe einer neuen Anleihe erhält der Staat den Kaufpreis vom Anleger; der Anleger erhält den Zahlungsanspruch aus der Anleihe.
][
*Sekundärmarktkauf erklären:* Die Notenbank kauft das bereits bestehende Papier vom bisherigen Inhaber. Die Bankabwicklung schafft Zentralbankgeld; der Verkäufer erhält den Gegenwert. Das ist keine unmittelbare Zahlung an den Staat für eine neue Anleihe.
][
*Grenzen der Skizze nennen:* „Geld drucken“ muss keine Ausgabe zusätzlicher Scheine bedeuten. Käufe können Renditen und Finanzierungsbedingungen beeinflussen, erzeugen aber nicht automatisch einen gleich großen Anstieg aller Verbraucherpreise. Historische Foliengrafiken nicht als aktuelle Werte ausgeben.
]


// Ergänzung VL 28.10./04.11.2026
#aufgabe(titel: "Kreditvertrag mit Covenants gestalten", art: "verstehen", quelle: "2.5")[
#if not web [*Aufgabe 103* #linebreak()]
Nenne die sechs verhandlungsrelevanten Merkmalsgruppen des Kreditvertrags. Erkläre anschließend an einem selbst formulierten Covenant den Zweck, die Berichtspflicht, eine mögliche Folge eines Verstoßes und den Nachteil für den Schuldner.
#src[V, PDF-S. 53–54, Folien 105–108; eigene Anwendung.]
][
*Vertragsgruppen nennen:* Auszahlungs-/Rückzahlungsbetrag, Tilgungsstruktur, Zinssatz einschließlich Terminen/Bindung, Laufzeit, Sicherheiten und sonstige Vereinbarungen.
][
*Covenant formulieren:* Eigener Fall ohne zusätzliche Zahlen: Der Schuldner muss ein positives Net Working Capital halten und nach vereinbarter Definition regelmäßig darüber berichten. Zweck ist ein rechtzeitig sichtbarer Mindestpuffer.
][
*Folgen und Grenze erklären:* Bei Verstoß greifen die vereinbarten Neuverhandlungen, Anpassungen oder Sanktionen. Das kann Zinsanpassung oder Fälligstellung umfassen, ist aber kein automatischer Insolvenzbeweis. Der Schuldner verliert Entscheidungsspielraum, beispielsweise für Ausschüttung oder weitere Verschuldung.
]


// Ergänzung VL 28.10./04.11.2026
#aufgabe(titel: "Vorlesung: Zinstage vom 14. Januar bis Jahresende", art: "rechnen", quelle: "2.6", ergebnis: [Endkapital: 2.057,83 / 2.057,67 / 2.057,86 / 2.058,67 / 2.057,70 € in der Reihenfolge a).])[
#if not web [*Aufgabe 104* #linebreak()]
*Gegeben und Annahmen*
Anlage 2.000 €, einfacher Jahreszins 3 %, 14.01.2016 bis 31.12.2016. Anfangstag nicht mitzählen, Endtag mitzählen. 2016 ist ein Schaltjahr mit 366 Tagen. Methoden wie in der Musterlösung: 30E/360 setzt den Endtag 31 auf 30; 30/360 belässt ihn in diesem konkreten Fall bei 31. Bei tatsächlichen Tagen Kalenderdifferenz verwenden. Kein unterjähriger Zinseszins, keine weiteren Zahlungen.
*Gesucht*
#enum(numbering: "a)")[Zinstage und Jahresbruchteil für 30/360, 30E/360, actual/365, actual/360 und actual/actual kalenderjährlich.][Jeweils Zinsbetrag und Endkapital, auf Cent gerundet.]
#src[V, PDF-S. 55, Folien 109–110; N04, PDF-S. 14.]
][
*Grundgleichung wählen:* $Z=K_0 i t/B$. Kapital und Jahreszins sind gleich; nur Tageszählung und Jahresbasis ändern sich. $2000 times "0,03"=60$ € ist der Zins für einen vollständigen Modelljahresbruchteil 1.
][
*30-Tage-Zähler bilden:* 30E/360: $30(12-1)+(30-14)=346$ Tage. Die hier verwendete 30/360-Variante: $30(12-1)+(31-14)=347$ Tage. Die beiden Methoden sind am Monatsende nicht gleich.
][
*Kalendertage zählen:* Vom 14.01. bis 31.12. sind es 352 verstrichene Tage. Derselbe Zähler steht über 365, 360 oder dem tatsächlichen Schaltjahr 366. Anfangs- und Endtag nicht beide mitzählen.
][
*Zinsen und Endwerte einsetzen:*
#tab(columns: (1.5fr,1fr,1fr,1fr),th([Methode],[Jahresbruchteil],[Zins €],[Ende €]),
[30/360],[$347/360$],[57,83],[2.057,83],
[30E/360],[$346/360$],[57,67],[2.057,67],
[actual/365],[$352/365$],[57,86],[2.057,86],
[actual/360],[$352/360$],[58,67],[2.058,67],
[actual/actual],[$352/366$],[57,70],[2.057,70],)
Die Bruchteile werden vor der Multiplikation nicht vorzeitig gerundet.
][
*Plausibilität prüfen:* Alle Bruchteile liegen unter 1, also alle Zinsen unter 60 €. Bei gleichen 352 Tagen ergibt der kleinere Nenner 360 den höheren Zins. Bei anderen Monatsendfällen ist die genaue vereinbarte 30/360-Variante erneut zu prüfen.
]


// Ergänzung VL 28.10./04.11.2026
#aufgabe(titel: "Vorlesung: jährliche und monatliche Zinsgutschrift", art: "rechnen", quelle: "2.7", ergebnis: [Angebot 2: etwa 3,0108 % effektiver Jahreszins; unter den Annahmen für ein und drei Jahre etwas besser.])[
#if not web [*Aufgabe 105* #linebreak()]
*Gegeben und Annahmen*
Angebot 1: jährliche Verzinsung 3 %. Angebot 2: monatliche Verzinsung 0,2475 % pro Monat. Albert legt für ein Jahr an, Beatrice für drei Jahre. Dasselbe beliebige positive Anfangskapital, unveränderte Zinssätze, Wiederanlage sämtlicher Zinsen, keine Gebühren, Steuern oder weiteren Zahlungen.
*Gesucht*
#enum(numbering: "a)")[Jahresfaktor und effektiven Jahreszins beider Angebote.][Vergleich für ein Jahr und für drei Jahre; Grenze bei veränderlichen Zinsen.]
#src[V, PDF-S. 56, Folien 111–112; N04, PDF-S. 15.]
][
*Gleichen Zeitraum herstellen:* Angebot 1 hat den Jahresfaktor $"1,03"$. Der Monatszins von Angebot 2 ist als Dezimalzahl $"0,002475"$; jeder Monatsfaktor beträgt daher $"1,002475"$.
][
*Wiederanlage berücksichtigen:* Jahresfaktor Angebot 2 $"1,002475"^12 approx "1,030107645"$. Effektiver Jahreszins rund 3,0107645 %. Er liegt geringfügig über 3 %, weil bereits gutgeschriebene Zinsen mitverzinst werden.
][
*Drei Jahre vergleichen:* Angebot 1: $"1,03"^3="1,092727"$. Angebot 2: $"1,002475"^36 approx "1,093069639"$. Beide Personen wählen unter den Modellannahmen Angebot 2. Die Faktoren multiplizieren das jeweilige Anfangskapital.
][
*Aussage prüfen:* Bei unveränderten positiven Jahresfaktoren bleibt deren Reihenfolge auch nach Hoch-drei erhalten. Der Satz auf Folie 112, der dabei „Möglichkeit 1“ als besser bezeichnet, ist ein Formulierungsfehler. Bei variablen Zinssätzen oder fehlender Wiederanlage muss neu gerechnet werden.
]


// Ergänzung VL 28.10./04.11.2026
#aufgabe(titel: "Darlehenspflichten und passende Kündigungsregel", art: "verstehen", quelle: "2.8")[
#if not web [*Aufgabe 106* #linebreak()]
Erkläre die Hauptpflichten nach § 488 BGB. Ordne danach zu: variabler Zins; Ende einer Zinsbindung ohne neue Zinsvereinbarung; mehr als zehn Jahre seit vollständigem Empfang bei Festzins; vorzeitiger Verkauf eines belasteten Grundstücks aus berechtigtem Interesse. Nenne jeweils die wesentlichen Bedingungen und Fristen.
#src[V, PDF-S. 57–58, Folien 113–115; Rechtsabgleich in Abschnitt 2.8.]
][
*Pflichten nennen:* Geber stellt den vereinbarten Betrag bereit; Nehmer zahlt geschuldeten Zins und erstattet das Darlehen bei Fälligkeit zurück.
][
*Ordentliche Fälle zuordnen:* Variabler Zins: drei Monate Frist nach § 489 Abs. 2. Ende einer früher als die Rückzahlung endenden Zinsbindung ohne Neuvereinbarung: ein Monat, frühestens zum Bindungsende. Lange Festzinsbindung: nach zehn Jahren seit vollständigem Empfang mit sechs Monaten Frist; eine relevante spätere Neuvereinbarung kann den Fristbeginn ersetzen.
][
*Besonderen Anlass zuordnen:* § 490 Abs. 2 verlangt gebundenen Sollzins, Grund-/Schiffspfandrecht, sechs Monate seit vollständigem Empfang und berechtigtes Interesse; drei Monate Kündigungsfrist. Dann kann ein ersatzfähiger Schaden als Vorfälligkeitsentschädigung hinzukommen.
][
*Prüfen:* Unterschrift und vollständiger Empfang sind nicht derselbe Zeitpunkt. Auch die Rückzahlung muss fristgerecht erfolgen. Den konkreten Fall erst unter die passende Regel einordnen, danach Frist und mögliche Entschädigung bestimmen.
]


// Ergänzung VL 28.10./04.11.2026
#aufgabe(titel: "Vorfälligkeitsentschädigung wirtschaftlich erklären", art: "verstehen", quelle: "2.9")[
#if not web [*Aufgabe 107* #linebreak()]
Warum kann eine vorzeitige Rückzahlung bei Festzins einen Schaden verursachen? Unterscheide Aktiv-Aktiv- und Aktiv-Passiv-Vergleich. Was bedeutet ein höherer Wiederanlagezins, und warum folgt aus der Folie kein pauschaler Gebührenanspruch?
#src[V, PDF-S. 58, Folien 115–116; N04, PDF-S. 17; rechtliche Präzisierung in Abschnitt 2.9.]
][
*Anspruch zuerst prüfen:* Der wirtschaftliche Zinsnachteil begründet nicht in jedem Kündigungsfall automatisch eine Forderung. Ordentliche Kündigung, besonderer vorzeitiger Ausstieg und einvernehmliche Aufhebung sind zu unterscheiden.
][
*Wirtschaftlichen Nachteil erklären:* Die Bank hatte mit den vereinbarten Zahlungen gerechnet. Muss sie zurückerhaltene Mittel zu einem niedrigeren Zins wieder anlegen, kann ein Nachteil entstehen; ein höherer Wiederanlagezins kann ihn vermindern oder beseitigen.
][
*Methoden trennen:* Aktiv-Aktiv vergleicht mit einem neuen Kreditgeschäft. Aktiv-Passiv rekonstruiert Zahlungen über laufzeitentsprechende Hypothekenpfandbriefe. Zahlungszeitpunkte, Restschuld und ersparte Risiko-/Verwaltungskosten gehören in die Betrachtung.
][
*Doppelzählung und Gebühr vermeiden:* Ein Nachteil darf nicht zweimal als Zinsschaden und noch einmal identischer Margenschaden ersetzt werden. Die Folienaussage über eine Bearbeitungsgebühr ist kein allgemeiner Automatismus; Rechtsgrund und tatsächlich ersatzfähiger Schaden sind zu prüfen.
]


// Ergänzung VL 28.10./04.11.2026
#aufgabe(titel: "Klausur: Annuitätendarlehen der Inn GmbH", art: "rechnen", quelle: "2.10.1", ergebnis: [Annuität ungerundet 21.522,16 €/Jahr, Tabelle 21.522 €; Zinsen gerundet insgesamt 6.088 €.])[
#if not web [*Aufgabe 108* #linebreak()]
*Gegeben und Annahmen*
Inn GmbH: Darlehen 80.000 € am 01.01.2017, Auszahlung 100 %, 3 % p. a. fest für vier Jahre, jährliche Zahlung am Jahresende. Zinsen jeweils auf die Restschuld zu Jahresbeginn. Annuität so bestimmen, dass das Darlehen in vier Jahren vollständig getilgt ist. Wie in der Klausur jede Tabellenzahl auf volle Euro runden; Rundungsrest vernachlässigen.
*Gesucht*
#enum(numbering: "a)")[Annuität und Tilgungsplan 2017–2020 mit Anfangsschuld, Zinsen, Tilgung, Gesamtzahlung und Endschuld.][Erkläre den Verlauf der Zins- und Tilgungsanteile.]
#src[Altklausur 2017, Aufgabe 1 a, 6 Punkte; K, PDF-S. 1 (Klausurseite 5). Eigene Lösung, fremde Handschrift nicht übernommen.]
][
*Modell wählen:* Bei der Annuität bleibt die Summe von Zins und Tilgung konstant. Die Schuld muss durch vier nachschüssige Jahreszahlungen abgebaut werden. $i="0,03"$, $n=4$, $D=80000$ €.
][
*Annuität berechnen:* $A=80000 frac("0,03" times "1,03"^4,"1,03"^4-1) approx "21522,16"$ €/Jahr. Für die Tabelle nach Klausurvorgabe auf 21.522 € runden.
][
*Erste Zeile begründen:* Zins $80000 times "0,03"=2400$ €. Von 21.522 € bleiben $21522-2400=19122$ € Tilgung; Restschuld $80000-19122=60878$ €. Nur die Tilgung vermindert die Schuld.
][
*Jährlich fortschreiben:*
#tab(columns: (0.8fr,1fr,1fr,1fr,1fr,1fr),th([Jahr],[Anfang €],[Zins €],[Tilgung €],[Zahlung €],[Ende €]),
[2017],[80.000],[2.400],[19.122],[21.522],[60.878],
[2018],[60.878],[1.826],[19.696],[21.522],[41.182],
[2019],[41.182],[1.235],[20.287],[21.522],[20.895],
[2020],[20.895],[627],[20.895],[21.522],[0],)
Jede Zeile benutzt die gerundete Anfangsschuld und rundet den Zins auf volle Euro.
][
*Prüfen:* Tilgungen $19122+19696+20287+20895=80000$ €. Zinsen insgesamt 6.088 €, vier Zahlungen 86.088 €. Die Restschuld sinkt; darum fällt der Zinsanteil und bei konstanter Zahlung steigt der Tilgungsanteil. Eine Rechnung mit ungerundeten Zwischenwerten kann geringfügig anders enden.
]


// Ergänzung VL 28.10./04.11.2026
#aufgabe(titel: "Klausur: Ratendarlehen der Inn GmbH", art: "rechnen", quelle: "2.10.1", ergebnis: [Tilgung 20.000 €/Jahr; Zahlungen 22.400 / 21.800 / 21.200 / 20.600 €; Gesamtzinsen 6.000 €.])[
#if not web [*Aufgabe 109* #linebreak()]
*Gegeben und Annahmen*
Darlehen 80.000 € am 01.01.2017, Auszahlung 100 %, 3 % p. a. fest, vier Jahre. Konstante jährliche Tilgung 25 % der Anfangsschuld; Zinsen auf die Restschuld zu Jahresbeginn, Zahlung am Jahresende. Keine weiteren Kosten.
*Gesucht*
#enum(numbering: "a)")[Tilgungsplan 2017–2020 mit Anfangsschuld, Zins, Tilgung, Gesamtzahlung und Endschuld.][Gesamtzinsen und Verlauf der Belastung.]
#src[Altklausur 2017, Aufgabe 1 b, 4 Punkte; K, PDF-S. 1 (Klausurseite 5). Eigene Lösung.]
][
*Tilgung festlegen:* 25 % beziehen sich hier auf die Anfangsschuld, also $80000 times "0,25"=20000$ €/Jahr. Nicht jährlich 25 % der sinkenden Restschuld tilgen; dann wäre sie nach vier Jahren noch nicht null.
][
*Restschuld verzinsen und fortschreiben:*
#tab(columns: (0.8fr,1fr,1fr,1fr,1fr,1fr),th([Jahr],[Anfang €],[Zins €],[Tilgung €],[Zahlung €],[Ende €]),
[2017],[80.000],[2.400],[20.000],[22.400],[60.000],
[2018],[60.000],[1.800],[20.000],[21.800],[40.000],
[2019],[40.000],[1.200],[20.000],[21.200],[20.000],
[2020],[20.000],[600],[20.000],[20.600],[0],)
][
*Prüfen und deuten:* Vier Tilgungen ergeben 80.000 €, Zinsen $2400+1800+1200+600=6000$ €. Die jährliche Gesamtzahlung fällt um 600 €. Gegenüber der Annuität ist die erste Zahlung höher, die Schuld sinkt anfangs schneller; dadurch entstehen in diesem Modell weniger Gesamtzinsen.
]


// Ergänzung VL 28.10./04.11.2026
#aufgabe(titel: "Klausur: Effektivzins mit zwei Prozent Disagio", art: "rechnen", quelle: "2.10.2", ergebnis: [Auszahlung 78.400 €; näherungsweise 3,57 % p. a.])[
#if not web [*Aufgabe 110* #linebreak()]
*Gegeben und Annahmen*
Endfälliges Darlehen: Nominalbetrag 80.000 €, 3 % p. a., vier Jahre, Auszahlungsdisagio 2 % des Nominalbetrags. Jährliche Zinszahlung, vollständige Nominalrückzahlung am Ende, keine anderen Kosten. Gesucht ist ausdrücklich die approximative Praktikerformel, nicht die exakte interne Rendite.
*Gesucht*
#enum(numbering: "a)")[Auszahlungsbetrag und approximativen effektiven Jahreszins auf zwei Nachkommastellen.]
#src[Altklausur 2017, Aufgabe 1 c, 1 Punkt; K, PDF-S. 2 (Klausurseite 6). Eigene Lösung.]
][
*Tatsächlichen Zufluss bestimmen:* Disagio $80000 times "0,02"=1600$ €, Auszahlung $80000-1600=78400$ €. Trotzdem werden die vereinbarten 80.000 € zurückgezahlt und verzinst.
][
*Jahresbelastung näherungsweise bilden:* Jährlicher Zins $80000 times "0,03"=2400$ €. Das Disagio wird in dieser Näherung gleichmäßig verteilt: $1600/4=400$ €/Jahr.
][
*Auf erhaltenes Geld beziehen:* $i_"eff,approx"=(2400+400)/78400 approx "0,035714"= "3,57"%$ p. a. Der Nenner ist die Auszahlung, nicht die Nominalschuld.
][
*Plausibilität prüfen:* Der Wert liegt über 3 %, weil zusätzlich zum Nominalzins das Disagio getragen wird. Die lineare Verteilung des Disagios vereinfacht die zeitliche Belastung; die Formel ist ausdrücklich nur eine Näherung.
]


// Ergänzung VL 28.10./04.11.2026
#aufgabe(titel: "Klausur: Sicherheiten nach zwei Kriterien einordnen", art: "verstehen", quelle: "2.10.3")[
#if not web [*Aufgabe 111* #linebreak()]
Nenne je eine Personal- und Realsicherheit sowie je ein akzessorisches und fiduziarisches Sicherungsmittel. Erkläre die beiden Einteilungen, statt nur vier Wörter aufzuzählen.
#src[Altklausur 2017, Aufgabe 1 d, zweimal 1 Punkt; K, PDF-S. 2 (Klausurseite 6). Eigene Lösung mit Rechtsabgleich in Abschnitt 2.10.]
][
*Rückgriff unterscheiden:* Personalsicherheit: beispielsweise Bürgschaft, also zusätzlicher Anspruch gegen einen Bürgen. Realsicherheit: beispielsweise Grundschuld, also Sicherung an einem Vermögenswert.
][
*Forderungsbindung unterscheiden:* Akzessorisch: Bürgschaft, deren Umfang vom jeweiligen Bestand der Hauptverbindlichkeit abhängt. Fiduziarisches Beispiel: Sicherungsgrundschuld; ihr dinglicher Bestand setzt die Forderung nicht voraus, der Sicherungsvertrag verbindet sie mit dem Kredit.
][
*Prüfen:* Dieselbe Bürgschaft ist zugleich personal und akzessorisch. Die Sicherungsgrundschuld ist zugleich real und fiduziarisch. „Real“ bedeutet nicht automatisch „akzessorisch“. Die handschriftlichen falschen Zuordnungen im Scan werden nicht übernommen.
]
