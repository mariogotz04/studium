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
#text("Nenne die drei Ziele der Finanzierung und das Sachziel mit seinen vier „richtig“.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A1. Verfahren: #stelle(<a-1-1>).]
][
#text("Gewinn/Rentabilität, Liquidität, Sicherheit. Sachziel: finanzielle Mittel im notwendigen Umfang, in der erforderlichen Art, zum richtigen Zeitpunkt, am richtigen Ort.")
]

// 0-2
#aufgabe(titel: "Das magische Dreieck", art: "verstehen", quelle: "1.1")[
#text("Erkläre das magische Dreieck. Nenne zu jeder Ecke ein Beispiel, warum sie mit einer anderen in Konflikt steht.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A2. Verfahren: #stelle(<a-1-1>).]
][
#text("Rentabilität, Sicherheit, Liquidität lassen sich nicht gleichzeitig maximieren. Rentabel ↔ sicher: hohe Rendite meist mit hohem Risiko (Aktien vs. Sparbuch). Liquide ↔ rentabel: Bargeld bringt keine Zinsen. Sicher ↔ rentabel: sichere Anlagen bringen wenig. Wo man sich einordnet, hängt von der Risikoaversion ab.")
]

// 0-3
#aufgabe(titel: "Außen- und Innenfinanzierung definieren", art: "verstehen", quelle: "1.2")[
#text("Definiere Außen- und Innenfinanzierung in je einem Satz.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A3. Verfahren: #stelle(<a-1-2>).]
][
#text("Außen: Mittel kommen über Finanzierungsverträge von Kapitalgebern außerhalb des Unternehmens. Innen: Mittel entstehen bzw. verbleiben durch Vorgänge innerhalb des Unternehmens (einbehaltene Gewinne, Abschreibungen, Rückstellungen).")
]

// 0-4
#aufgabe(titel: "Vier Unterschiede: außen und innen", art: "verstehen", quelle: "1.2")[
#text("Nenne die vier Unterschiede zwischen Außen- und Innenfinanzierung.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A4. Verfahren: #stelle(<a-1-2>).]
][
#text("(1) Kapitalgeber außerhalb vs. Vorgänge innerhalb; (2) Beträge exakt festgelegt vs. Höhe zum Teil ungewiss; (3) Fristen exakt vs. zum Teil ungewiss; (4) Einzelakte zu vereinbarten Zeitpunkten vs. laufend, oft erst am Periodenende erkennbar.")
]

// 0-5
#aufgabe(titel: "Es kommt auf die Gegenleistung an", art: "verstehen", quelle: "1.2")[
#text("„Es kommt immer auf die Gegenleistung an.“ Erkläre den Satz anhand von Zins, Gewinn, Rückzahlung, Stimmrechten und Kündigungsrecht.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A5. Verfahren: #stelle(<a-1-2>).]
][
#text("FK-Geber erhalten Zins, Rückzahlung und ein Kündigungsrecht, aber keinen Gewinnanteil und keine Stimmrechte. EK-Geber erhalten Gewinnanteil und Stimmrechte, aber keinen Zins und keinen Anspruch auf Rückzahlung. Ob etwas EK oder FK ist, entscheidet also die vereinbarte Gegenleistung.")
]

// 0-6
#aufgabe(titel: "Einfluss der Bank ohne Leitungsrechte", art: "verstehen", quelle: "1.2")[
#text("Warum kann eine Bank faktisch Einfluss auf ein Unternehmen nehmen, obwohl Fremdkapitalgeber keine Leitungsrechte haben?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A6. Verfahren: #stelle(<a-1-2>).]
][
#text("Über die Kündigungsdrohung: Wenn die Bank den Kredit kündigen oder nicht verlängern kann, muss das Unternehmen auf ihre Bedingungen eingehen.")
]

// 0-7
#aufgabe(titel: "Sechs Merkmale von Eigen- und Fremdkapital", art: "verstehen", quelle: "1.2")[
#text("Nenne die sechs Merkmale, in denen sich Eigen- und Fremdkapital unterscheiden.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A7. Verfahren: #stelle(<a-1-2>).]
][
#text("Erfolgsbeteiligung / keine; keine festen Zahlungsansprüche / fester Zins- und Tilgungsanspruch; Quotenanteil / Nominalanspruch; unbefristet / befristet; Haftung / keine Haftung; Mitwirkungsrechte / keine Leitungsrechte.")
]

// 0-8
#aufgabe(titel: "Finanzierungsformen nach Drukarczyk zuordnen", art: "verstehen", quelle: "1.2")[
#text("Ordne den Finanzierungsformen nach Drukarczyk zu (Nr. 1–9): a) Bankkredit, b) Darlehen eines GmbHGesellschafters an seine GmbH, c) Kapitalerhöhung durch die bisherigen Gesellschafter, d) Aufnahme eines neuen Gesellschafters, e) Gewinn wird nicht ausgeschüttet, f) Verkauf einer nicht mehr benötigten Lagerhalle.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A8. Verfahren: #stelle(<a-1-2>).]
][
#text("a) 1 Fremdfinanzierung · b) 2 Gesellschafterdarlehen · c) 3 Eigenfinanzierung · d) 4 Beteiligungsfinanzierung · e) 6 offene Selbstfinanzierung · f) 9 Vermögensumschichtung.")
]

// 0-9
#aufgabe(titel: "Eigenfinanzierung und Selbstfinanzierung", art: "verstehen", quelle: "1.2")[
#text("Worin unterscheiden sich Eigenfinanzierung und Selbstfinanzierung?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A9. Verfahren: #stelle(<a-1-2>).]
][
#text("Eigenfinanzierung: bisherige Eigentümer legen neues Eigenkapital von außen ein (Außenfinanzierung). Selbstfinanzierung: Gewinne werden im Unternehmen einbehalten (Innenfinanzierung).")
]

// 0-10
#aufgabe(titel: "Liquidität als oberstes Ziel", art: "verstehen", quelle: "1.3")[
#text("Definiere Liquidität. Warum hat das Liquiditätsziel die höchste Bedeutung in der Zielhierarchie?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A10. Verfahren: #stelle(<a-1-3>).]
][
Liquidität heißt: fällige Zahlungen fristgerecht und betragsgenau erfüllen können. Dieses Ziel ist dauerhaft und existenziell; Zahlungsunfähigkeit kann ein Insolvenzverfahren auslösen. Gewinn ist dafür kein Ersatz, weil er andere Größen und Periodenzuordnungen erfasst.
]

// 0-11
#aufgabe(titel: "Gewinn und trotzdem zahlungsunfähig", art: "verstehen", quelle: "1.3")[
#text("Erkläre an einem Beispiel, wie ein Unternehmen Gewinn machen und trotzdem zahlungsunfähig werden kann.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A11. Verfahren: #stelle(<a-1-3>).]
][
#text("Z. B. großer Auftrag auf Ziel: Ertrag und Gewinn sind gebucht, das Geld kommt erst in 90 Tagen. Löhne und Lieferanten müssen aber jetzt bezahlt werden. Reicht die Kasse nicht, ist das Unternehmen trotz Gewinn zahlungsunfähig.")
]

// 0-12
#aufgabe(titel: "Vier Liquiditätsquellen", art: "verstehen", quelle: "1.3")[
#text("Nenne die vier Liquiditätsquellen aus Folie 14 mit je einem Beispiel.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A12. Verfahren: #stelle(<a-1-3>).]
][
#text("güterwirtschaftliche Liquidität (Vermögen verkaufen, z. B. Wertpapiere); zukünftige Liquidität (künftige Einzahlungsüberschüsse, z. B. Umsätze); verliehene Liquidität (Vermögen beleihen, z. B. Grundschuld auf das Firmengrundstück); antizipierte Liquidität (künftige Überschüsse beleihen, z. B. Kredit auf erwartete Cashflows).")
]

// 0-13
#aufgabe(titel: "Bundesanleihe gegen Sparbrief", art: "verstehen", quelle: "1.3")[
#text("Warum ist eine 4-jährige Bundesanleihe liquider als ein Sparbrief mit 2 Jahren Restlaufzeit?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A13. Verfahren: #stelle(<a-1-3>).]
][
#text("Die Bundesanleihe wird an der Börse gehandelt und kann börsentäglich verkauft werden. Der Sparbrief ist in der Regel nicht kündbar, man kommt erst nach Laufzeitende an das Geld.")
]

// 0-14
#aufgabe(titel: "Warum die Bilanz Liquidität schlecht misst", art: "verstehen", quelle: "1.3")[
#text("Warum ist die Bilanz nur bedingt geeignet, die Liquidität zu messen?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A14. Verfahren: #stelle(<a-1-3>).]
][
Die Bilanz zeigt Vermögens- und Kapitalbestände an einem Stichtag; die GuV arbeitet mit Erträgen und Aufwendungen. Beides ergibt noch keinen Kalender künftiger Einzahlungen, Auszahlungen und Fälligkeiten. Für diese Frage braucht man den Zahlungsplan.
]

// 0-15
#aufgabe(titel: "Aufwand, Auszahlung, Ertrag, Einzahlung", art: "verstehen", quelle: "1.4")[
#text("Erkläre den Unterschied zwischen Aufwand und Auszahlung sowie zwischen Ertrag und Einzahlung mit je einem Beispiel.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A15. Verfahren: #stelle(<a-1-4>).]
][
#text("Aufwand = Werteverzehr einer Periode (GuV), Auszahlung = Abfluss von Geld. Beispiel: Abschreibung ist Aufwand ohne Auszahlung; Maschinenkauf ist Auszahlung, wird aber erst über Jahre zu Aufwand. Ertrag = Wertzuwachs, Einzahlung = Zufluss von Geld. Beispiel: Verkauf auf Ziel ist Ertrag, Einzahlung erst später; Kundenanzahlung ist Einzahlung, Ertrag erst später.")
]

// 0-16
#aufgabe(titel: "Abschreibungen im indirekten Cashflow", art: "verstehen", quelle: "1.5")[
#text("Warum werden bei der indirekten Cashflow-Methode die Abschreibungen zum Jahresüberschuss addiert?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A16. Verfahren: #stelle(<a-1-5>).]
][
#text("Abschreibungen haben den Jahresüberschuss gemindert, aber in dieser Periode kein Geld gekostet. Um vom Gewinn zur Zahlungsgröße zu kommen, werden sie wieder addiert.")
]

// 0-17
#aufgabe(titel: "Was der Cashflow verrät", art: "verstehen", quelle: "1.5")[
#text("Über welche vier Fähigkeiten eines Unternehmens informiert der Cashflow?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A17. Verfahren: #stelle(<a-1-5>).]
][
#text("Zahlungsüberschüsse erwirtschaften, Schulden tilgen (Kreditwürdigkeit), Gewinne ausschütten, Investitionen tätigen.")
]

// 0-18
#aufgabe(titel: "Drei Bereiche der Kapitalflussrechnung", art: "verstehen", quelle: "1.6")[
#text("Nenne die drei Bereiche der Kapitalflussrechnung. Ist ein negativer Cashflow aus Investitionstätigkeit ein schlechtes Zeichen?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A18. Verfahren: #stelle(<a-1-6>).]
][
#text("Operative, Investitions- und Finanzierungstätigkeit. Ein negativer Investitions-Cashflow bezeichnet eine Netto-Mittelverwendung, beispielsweise für neue Anlagen. Ob sie sinnvoll und finanzierbar ist, muss separat geprüft werden; der negative Saldo allein ist weder gut noch schlecht.")
]

// 0-19
#aufgabe(titel: "Cashflow der XYZ GmbH direkt und indirekt", art: "rechnen", quelle: "1.5")[
#text("GuV XYZ GmbH 2008 (Folie 22, Mio. €): Materialaufwand 1.540, Personalaufwand 1.600, Pensionsrückstellungen 200, Abschreibungen 100, Zinsaufwand 200, Jahresüberschuss 648; Umsatzerlöse 4.000, Zinsertrag 288. Berechne den Cashflow direkt und indirekt. Tipp: Prüfe zuerst, ob Aufwand + JÜ = Erträge.")
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
#text("Kleinunternehmen: Umsatzerlöse 900 T€ (alle bezahlt), Materialaufwand 350 T€, Personalaufwand 280 T€, Abschreibungen 60 T€, Zuführung zu Pensionsrückstellungen 40 T€, Zinsaufwand 30 T€ (alles bezahlt). a) Jahresüberschuss? b) Cashflow indirekt? c) Kontrolle direkt?")
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
#text("Pizzeria, Variante: Mario kauft einen Lieferwagen für 36.000 €, Nutzungsdauer 6 Jahre (lineare Abschreibung). Sein Gewinn beträgt 3.000 € pro Monat. a) Wie viel Geld bleibt monatlich zusätzlich in der Kasse, wenn er den Gewinn komplett entnimmt? b) Was hat er nach 6 Jahren angespart, und wofür reicht es?")
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
#text("Kapitalflussrechnung (T€): Jahresüberschuss 200, Abschreibungen 80, Erhöhung Pensionsrückstellungen 20, Erhöhung Forderungen L&L 30, Kauf einer Maschine 150, Verkauf eines Grundstücks 40, Kreditaufnahme 100, Tilgung 60, Dividendenzahlung 50, Kassenbestand am Periodenanfang 70. Berechne a) CF aus operativer Tätigkeit, b) CF aus Investitionstätigkeit, c) CF aus Finanzierungstätigkeit, d) den Kassenbestand am Periodenende, e) den Free Cashflow.")
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
#text("Free Cashflow: CF aus operativer Tätigkeit 1.250 T€, Investitionen in Sachanlagen 700 T€. Das Unternehmen möchte 200 T€ Dividende zahlen. a) Free Cashflow? b) Kann die Dividende aus dem Free Cashflow bezahlt werden? Was bleibt übrig?")
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
#text("Nenne die Aufgaben der Finanzplanung und die drei Prinzipien eines Finanzplans.")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B1. Verfahren: #stelle(<a-1-7>).]
][
#text("Aufgaben: Bedarf an Zahlungsmitteln ermitteln, Zahlungsfähigkeit sichern, optimale Finanzierungsart wählen, Defizite und Überschüsse sichtbar machen, EK-Bedarf ermitteln. Prinzipien: Vollständigkeit, Bruttoprinzip, Genauigkeit.")
]

// 0-26
#aufgabe(titel: "Über- und Unterliquidität", art: "verstehen", quelle: "1.7")[
#text("Was sind die Folgen von Über- bzw. Unterliquidität?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B2. Verfahren: #stelle(<a-1-7>).]
][
#text("Überliquidität: zu viel ungenutztes Geld, Zinsverluste, geringere Rentabilität. Unterliquidität: Zahlungsverpflichtungen können nicht erfüllt werden, Insolvenzrisiko.")
]

// 0-27
#aufgabe(titel: "Finanzplanung abstimmen", art: "verstehen", quelle: "1.7")[
#text("Warum muss die Finanzplanung mit Produktions-, Absatz- und Investitionsplanung abgestimmt werden?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B3. Verfahren: #stelle(<a-1-7>).]
][
#text("Weil Produktion, Absatz und Investitionen die Zahlungsströme bestimmen. Erst der Finanzplan zeigt, ob das Gesamtprogramm finanzierbar ist; wenn nicht, werden die Teilpläne angepasst.")
]

// 0-28
#aufgabe(titel: "Drei Insolvenzgründe", art: "verstehen", quelle: "1.8")[
#text("Nenne die drei Insolvenzgründe mit Paragraf. Welcher gilt nur für juristische Personen?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B4. Verfahren: #stelle(<a-1-8>).]
][
#text("Zahlungsunfähigkeit (§ 17), drohende Zahlungsunfähigkeit (§ 18) und Überschuldung (§ 19 InsO). § 19 gilt für juristische Personen sowie die dort in Abs. 3 erfassten Personengesellschaften. Ein sinkender Umsatz allein ist kein eigener Insolvenzgrund.")
]

// 0-29
#aufgabe(titel: "Zahlungsunfähigkeit nach dem BGH", art: "verstehen", quelle: "1.8")[
#text("Wann ist ein Unternehmen nach der Rechtsprechung des BGH zahlungsunfähig?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B5. Verfahren: #stelle(<a-1-8>).]
][
#text("Die Folie rechnet mit der 90-%-/Dreiwochen-Orientierung. Präziser: Eine nicht beseitigte Lücke von 10 % oder mehr begründet nach dem BGH regelmäßig Zahlungsunfähigkeit; Ausnahmen und die weitere Entwicklung sind mitzubeurteilen. Genau 90 % sind keine rechtliche Freigrenze.")
]

// 0-30
#aufgabe(titel: "Zahlungsunfähigkeit und Überschuldung", art: "verstehen", quelle: "1.8")[
#text("Erkläre den Unterschied zwischen Zahlungsunfähigkeit und Überschuldung mit eigenen Worten.")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B6. Verfahren: #stelle(<a-1-8>).]
][
#text("Zahlungsunfähigkeit: Es fehlt jetzt Geld, um fällige Rechnungen zu bezahlen (Liquiditätsproblem). Überschuldung: Das Vermögen reicht nicht, um alle Schulden zu decken, das EK ist negativ (Vermögensproblem). Ein überschuldetes Unternehmen kann noch zahlen, ein zahlungsunfähiges kann noch Vermögen haben.")

*Präzisierung:* Ein bilanzieller Fehlbetrag und die rechtliche Überschuldung sind getrennt zu prüfen. Darlehen verschwinden nicht pauschal aus der Bilanz; beim Rangrücktritt gelten die Voraussetzungen von § 19.
]

// 0-31
#aufgabe(titel: "Rechnerisch überschuldet, aber kein Insolvenzgrund", art: "verstehen", quelle: "1.8")[
#text("Wann liegt trotz rechnerischer Überschuldung kein Insolvenzgrund vor?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B7. Verfahren: #stelle(<a-1-8>).]
][
#text("Ein negatives handelsbilanzielles EK allein beweist keine rechtliche Überschuldung. § 19 berücksichtigt insbesondere die überwiegend wahrscheinliche Fortführung in den nächsten zwölf Monaten sowie die rechtlich passende Vermögens- und Verbindlichkeitsbewertung.")
]

// 0-32
#aufgabe(titel: "Warum ein Kredit gegen Überschuldung nicht hilft", art: "verstehen", quelle: "1.8")[
#text("Warum hilft bei Überschuldung kein neuer Bankkredit? Was hilft stattdessen?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B8. Verfahren: #stelle(<a-1-8>).]
][
#text("Ein Kredit erhöht Vermögen (Kasse) und Schulden um denselben Betrag, die Lücke zwischen Vermögen und Schulden bleibt. Es braucht Eigenkapital (Kapitaleinlage, neuer EK-Geber), einen Rangrücktritt oder einen Lieferantenvergleich.")

*Präzisierung:* Ein bilanzieller Fehlbetrag und die rechtliche Überschuldung sind getrennt zu prüfen. Darlehen verschwinden nicht pauschal aus der Bilanz; beim Rangrücktritt gelten die Voraussetzungen von § 19.
]

// 0-33
#aufgabe(titel: "Frist für den Insolvenzantrag", art: "verstehen", quelle: "1.8")[
#text("Wie lange hat die Geschäftsführung Zeit, den Insolvenzantrag zu stellen, und was droht bei Verspätung?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B9. Verfahren: #stelle(<a-1-8>).]
][
#text("Ohne schuldhaftes Zögern; nach § 15a Abs. 1 spätestens drei Wochen nach Eintritt der Zahlungsunfähigkeit bzw. sechs Wochen nach Eintritt der Überschuldung. Die einheitlichen drei Wochen der Folie 34 sind insoweit veraltet. Verspätete Antragstellung kann strafbar sein; drohende Zahlungsunfähigkeit allein löst diese Antragspflicht nicht aus.")
]

// 0-34
#aufgabe(titel: "Sechs Maßnahmen gegen ein Liquiditätsdefizit", art: "verstehen", quelle: "1.8")[
#text("Nenne die sechs Gruppen von Maßnahmen gegen ein Liquiditätsdefizit mit je einem Beispiel.")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B10. Verfahren: #stelle(<a-1-8>).]
][
#text("Vermögen außer der Reihe zu Geld machen (Sale-and-lease-back); Eingänge beschleunigen, Ausgänge verzögern (Mahnwesen verschärfen); spezielle Einlagen und Kredite beschaffen (längeres Lieferantenziel); Rentabilität für Liquidität opfern (Sofortzahler bevorzugen); Gesellschafter müssen Farbe bekennen (zusätzliche Einlagen); rigoros Auszahlungen kürzen (Personalabbau).")
]

// 0-35
#aufgabe(titel: "Ausgänge eines Insolvenzverfahrens", art: "verstehen", quelle: "1.8")[
#text("Welche Ausgänge kann ein Insolvenzverfahren nehmen? Was bedeutet „Abweisung mangels Masse“?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B11. Verfahren: #stelle(<a-1-8>).]
][
#text("Abweisung mangels Masse, Liquidation (Gläubiger erhalten eine Quote) oder Sanierung über einen Insolvenzplan; dazu Einstellung des Verfahrens. „Mangels Masse“: Das Vermögen reicht nicht einmal, um die Kosten des Verfahrens zu decken.")
]

// 0-36
#aufgabe(titel: "Kennzahlen und Finanzplan", art: "verstehen", quelle: "1.7")[
#text("Worin unterscheiden sich finanzwirtschaftliche Kennzahlen und Finanzplan?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B12. Verfahren: #stelle(<a-1-7>).]
][
#text("Kennzahlen beschreiben die gegenwärtige Lage (aus der Bilanz, Stichtag). Der Finanzplan nimmt künftige Einund Auszahlungen vorweg.")
]

// 0-37
#aufgabe(titel: "Drei Liquiditätsgrade", art: "verstehen", quelle: "1.9")[
#text("Nenne die drei Liquiditätsgrade mit Formel und Zielwert.")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B13. Verfahren: #stelle(<a-1-9>).]
][
#text("1. Grad: flüssige Mittel / kfr. FK, 10–30 %. 2. Grad: (flüssige Mittel + Forderungen) / kfr. FK, mind. 100 %. 3. Grad: Umlaufvermögen / kfr. FK, mind. 200 %.")
]

// 0-38
#aufgabe(titel: "Goldene Bilanzregel", art: "verstehen", quelle: "1.10")[
#text("Formuliere die goldene Bilanzregel. Welche Kennzahl prüft sie, und welcher Wert sollte mindestens erreicht werden?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B14. Verfahren: #stelle(<a-1-10>).]
][
#text("Anlagevermögen soll durch langfristig verfügbares Kapital finanziert werden. Geprüft mit der Anlagendeckung (II: (EK + langfr. FK) / AV); mindestens 100 %.")
]

// 0-39
#aufgabe(titel: "Anlageintensität zu hoch oder zu gering", art: "verstehen", quelle: "1.10")[
#text("Warum kann eine zu hohe, aber auch eine zu geringe Anlageintensität problematisch sein?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B15. Verfahren: #stelle(<a-1-10>).]
][
#text("Zu hoch: Das Anlagevermögen lässt sich in der Krise schwer verkaufen. Zu gering: Hinweis auf alte, stark abgeschriebene Anlagen.")
]

// 0-40
#aufgabe(titel: "Eigenkapitalquote", art: "verstehen", quelle: "1.10")[
#text("Was sagt die Eigenkapitalquote aus, und welcher Zielwert gilt?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B16. Verfahren: #stelle(<a-1-10>).]
][
#text("Anteil des EK an der Bilanzsumme; zeigt finanzielle Unabhängigkeit und Bonität. Zielwert mindestens 15–20 %.")
]

// 0-41
#aufgabe(titel: "EK-Rentabilität über dem Marktzins", art: "verstehen", quelle: "1.11")[
#text("Warum sollte die EK-Rentabilität deutlich über dem Marktzins für langfristige Anlagen liegen?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B17. Verfahren: #stelle(<a-1-11>).]
][
#text("Weil der Gewinn zusätzlich das Unternehmensrisiko vergüten muss. Sonst könnte der Eigentümer sein Geld risikolos(er) anlegen.")
]

// 0-42
#aufgabe(titel: "Hubert + Maier: Risiko aus der Kapitalstruktur", art: "verstehen", quelle: "1.11")[
#text("Erkläre am Beispiel Hubert + Maier GmbH, warum das Risiko von Alternative B aus der Kapitalstruktur kommt.")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B18. Verfahren: #stelle(<a-1-11>).]
][
#text("Bei A und B fällt das Grundstück gleich stark (gleiches Geschäftsrisiko). Bei A trägt das hohe EK den Verlust. Bei B kommen 8.000 € Zinsen dazu, und das kleine EK (20.000) reicht für 28.000 Verlust nicht: Überschuldung. Der Unterschied liegt nur in der Finanzierung.")
]

// 0-43
#aufgabe(titel: "Leverage-Effekt", art: "verstehen", quelle: "1.12")[
#text("Was ist der Leverage-Effekt, und unter welcher Bedingung tritt er auf?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B19. Verfahren: #stelle(<a-1-12>).]
][
#text("Hebelwirkung des FK zugunsten der EK-Rentabilität: Ist der FK-Zins kleiner als die Gesamtkapitalrendite, steigt die EK-Rentabilität mit zunehmender Verschuldung.")
]

// 0-44
#aufgabe(titel: "Risikoeffekt", art: "verstehen", quelle: "1.12")[
#text("Was beschreibt der Risikoeffekt? Warum ist die höhere EK-Rendite „kein zusätzlicher Wert“?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B20. Verfahren: #stelle(<a-1-12>).]
][
#text("Mit steigender Verschuldung wächst die Streuung der EK-Rendite (das Risiko). Die höhere Rendite ist nur die Entschädigung für dieses höhere Risiko, kein Geschenk.")
]

// 0-45
#aufgabe(titel: "Warum nicht vollständig fremdfinanzieren", art: "verstehen", quelle: "1.12")[
#text("Warum ist eine vollständige Fremdfinanzierung trotz Leverage-Effekt keine gute Idee?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B21. Verfahren: #stelle(<a-1-12>).]
][
#text("Mit EK = 0 ist die Leverage-Formel nicht definiert. Mit sinkendem EK werden das Verlustpolster kleiner und die Renditeschwankungen größer. Kreditzins, Kreditverfügbarkeit und Rückzahlungspflichten dürfen nicht als beliebig unverändert angenommen werden; bei rG < rf wirkt der Hebel negativ.")
]

// 0-46
#aufgabe(titel: "Liquiditätsplan über drei Quartale", art: "rechnen", quelle: "1.7")[
#text("Liquiditätsplan: Anfangsbestand Q1: 8.000 €. Einzahlungen Q1/Q2/Q3: 30.000 / 25.000 / 40.000 €. Auszahlungen: 35.000 / 34.000 / 31.000 €. Kontokorrentlinie 5.000 €. a) Endbestände je Quartal? b) In welchem Quartal reicht die Kreditlinie nicht? Um wie viel? c) Nenne zwei Maßnahmen.")
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
#text("Gewinn vs. Kasse: Ein Unternehmen startet mit 2.000 € auf dem Konto. Es erzielt einen (zahlungswirksamen) Gewinn von 3.000 €, schüttet 1.500 € aus, kauft eine Maschine für 4.000 € und nimmt einen Kredit über 1.000 € auf. a) Endbestand? b) Welche Vorgänge erscheinen in der GuV?")
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
#text("BGH-Regel: Fällige Verbindlichkeiten 500.000 €. Innerhalb der nächsten drei Wochen kann das Unternehmen 430.000 € bezahlen. Ist es zahlungsunfähig? Welchem Zahlbetrag entsprechen 90 %? Warum ist das rechtlich noch keine sichere Freigrenze?")
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
#text("Überschuldung : Bilanz einer GmbH: Anlagevermögen 300, Umlaufvermögen 200; Eigenkapital 60, Fremdkapital 440 (T€). a) Welchen Verlust kann die GmbH maximal verkraften? b) Durch eine außerplanmäßige Abschreibung entsteht ein Verlust von 80. Liegt eine bilanzielle Unterdeckung vor, und welche zusätzliche rechtliche Prüfung ist nötig? Wie hoch ist der nicht durch EK gedeckte Fehlbetrag? c) Nenne zwei Maßnahmen, um die Antragspflicht zu beseitigen.")
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
#text("Liquiditätsgrade: Kasse und Bank 40, Forderungen 120, Vorräte 140, kurzfristiges Fremdkapital 150 (T€). Berechne die drei Liquiditätsgrade und beurteile sie.")
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
#text("Kennzahlen-Check : Anlagevermögen 600, Umlaufvermögen 400; Eigenkapital 250, langfristiges FK 350, kurzfristiges FK 400 (T€). Jahresüberschuss 50, Umsatzerlöse 1.000, Cashflow 125. Berechne Anlagendeckung I und II, EK- und FK-Quote, Anlageintensität, EK-Rentabilität, Umsatzrentabilität, Schuldentilgungsfähigkeit (Verbindlichkeiten = gesamtes FK) und beurteile: Ist die goldene Bilanzregel erfüllt?")
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
#text("Leverage : Ein Projekt erfordert 200.000 € Kapital und bringt einen Gewinn vor Zinsen von 24.000 €. FKZins 6 %. a) Gesamtkapitalrendite? b) EK-Rentabilität bei 100 % EK, 50 % EK und 25 % EK (rechne einmal direkt und einmal mit der Formel). c) Der Gewinn vor Zinsen sinkt auf 8.000 €. Wie hoch ist die EK-Rentabilität jetzt in den drei Fällen? Was zeigt das?")
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
#text("Cashflow indirekt: JÜ 250, Abschreibungen 90, Zuführung zu Rückstellungen 30, Auflösung von Rückstellungen 10 (T€). Berechne den Cashflow und begründe jedes Vorzeichen.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü1. Verfahren: #stelle(<a-1-5>).]
][
*Bereinigen:* $250+90+30-10=360$ T€.
][
*Ergebnis: 360 T€.* *Prüfung:* AfA und Zuführung wurden als nicht zahlungswirksamer Aufwand addiert; die ebenfalls nicht zahlungswirksame Auflösung als Ertrag abgezogen. Sonstige Abgrenzungen sind im Beispiel nicht gegeben.
]

// 0-54
#aufgabe(titel: "Cashflow direkt", art: "rechnen", quelle: "1.5")[
#text("Cashflow direkt: Einzahlungen aus Umsatz 1.200, Auszahlungen für Material 500, Personal 350, Zinsen 40 (T€). Berechne den Cashflow.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü2. Verfahren: #stelle(<a-1-5>).]
][
*Zahlungen saldieren:* $1200-500-350-40=310$ T€.
][
*Ergebnis: 310 T€.* *Prüfung:* Nur ausdrücklich gegebene Zahlungen verwenden; keine zusätzliche Abschreibung abziehen.
]

// 0-55
#aufgabe(titel: "Endbestand und freie Kreditlinie", art: "rechnen", quelle: "1.7")[
#text("Liquiditätsplan: Anfangsbestand 5.000 €, Einzahlungen 22.000 €, Auszahlungen 30.000 €, Kontokorrentlinie 6.000 €. Berechne Endbestand und freie Kreditlinie.")
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
#text("Bilanzielles Verlustpolster: AV 120, UV 80, EK 40, FK 160 (T€). Ein Abschreibungsverlust von 50 entsteht. Berechne Vermögen, rechnerisches EK und Fehlbetrag; trenne den bilanziellen Befund von der rechtlichen Prüfung.")
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
#text("EK-Quote und goldene Bilanzregel: EK 300, langfristiges FK 200, kurzfristiges FK 500, AV 450, Bilanzsumme 1.000 (T€). Berechne EK-Quote und Anlagendeckung II und vergleiche die Folienziele.")
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
#text("Leverage: rG = 9 %, rf = 5 %, EK 40, FK 60. Berechne die Eigenkapitalrendite und erläutere den Zuschlag.")
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
#text("Bäckerei (Teil A4): Ein Ofen kostet 48.000 €, Nutzungsdauer 8 Jahre (linear). Gewinn 4.000 € pro Monat, der komplett entnommen wird. Wie viel Geld bleibt monatlich zusätzlich in der Kasse, und was ist nach 8 Jahren angespart?")
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
#text("Kapitalflussrechnung (Teil A4): JÜ 120, Abschreibungen 40, Erhöhung Forderungen L&L 25, Erhöhung Verbindlichkeiten L&L 15, Kauf einer Maschine 90, Kreditaufnahme 50, Dividende 30, Kasse am Anfang 20 (T€). Berechne die drei Cashflows, den Kassenendbestand und den Free Cashflow.")
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
#text("BGH-Regel (Teil A5): Fällige Verbindlichkeiten 800.000 €, in drei Wochen zahlbar 700.000 €. Zahlungsunfähig?")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü9. Verfahren: #stelle(<a-1-8>).]
][
*Quote:* $700000/800000 times 100%="87,5"%$; Lücke 12,5 %.
][
*Ergebnis:* Regelmäßig kritischer Befund im Dreiwochenmodell. 90 % entsprächen 720.000 €. *Prüfung:* Auch dieser Grenzbetrag wäre keine sichere rechtliche Freigrenze; Abschnitt 1.8 beschreibt den Unterschied zur vereinfachten Folienregel.
]

// 0-62
#aufgabe(titel: "Liquiditätsgrade beurteilen", art: "rechnen", quelle: "1.9")[
#text("Liquiditätsgrade (Teil A5): Kasse 30, Forderungen 90, Vorräte 120, kurzfristiges FK 200 (T€). Berechne und beurteile die drei Grade.")
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
#text("Leverage im schlechten Jahr (Teil A5): Gesamtkapital 500.000 € (EK 100.000, FK 400.000), Gewinn vor Zinsen 40.000 €, FK-Zins 10 %. EK-Rentabilität? Vergleiche mit reiner EK-Finanzierung.")
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
#text("Liquiditätsplan einer Gründung (Teil A5): Kasse 10.000 €. Q1: Einzahlungen 15.000, Auszahlungen 28.000. Q2: 30.000 / 26.000. Q3: 35.000 / 25.000. Kontokorrentlinie 5.000 €. Endbestände, freie Kreditlinie je Quartal, Beurteilung.")
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
#text("Bilanzanalyse (Teil A4/A5): AV 800; Vorräte 200, Forderungen 150, Kasse 50; EK 180, langfr. FK 520, kfr. FK 500 (T€). JÜ 27, Umsatz 1.500, Cashflow 100. Berechne Liquidität 1.–3. Grades, Anlagendeckung I und II, EKQuote, Anlageintensität, EK- und Umsatzrentabilität, Schuldentilgungsfähigkeit (gesamtes FK) und gib ein Gesamturteil.")
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
#text("Kapitalstruktur und Risiko (Teil A5, wie Folie 49/50): Eine GmbH kauft eine Maschine für 150.000 € und behält 50.000 € in der Kasse. A: 200.000 € EK. B: 40.000 € EK + 160.000 € FK zu 8 % (Zinsen aus der Kasse bezahlt). Die Maschine verliert 30.000 € an Wert. Stelle beide Bilanzen zum Jahresende auf. Liegt Überschuldung vor?")
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
#text("Finanzierungsformen (Teil A2): Ordne zu (Nr. 1–9 nach Drukarczyk, außen/innen, EK/FK): a) Ausgabe neuer Aktien an neue Aktionäre, b) Gewinn wird einbehalten, c) Verkauf einer nicht mehr benötigten Halle, d) Ausgabe einer Anleihe, e) die bisherigen Gesellschafter erhöhen ihre Einlage.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü15. Verfahren: #stelle(<a-1-2>).]
][
a) Nr. 4 Beteiligungsfinanzierung: außen, EK. b) Nr. 6 offene Selbstfinanzierung: innen, EK. c) Nr. 9 Vermögensumschichtung: innen; der Verkauf ist keine neue EK-/FK-Aufnahme. d) Nr. 1 Fremdfinanzierung: außen, FK. e) Nr. 3 Eigenfinanzierung: außen, EK. *Prüfung:* Erst Herkunft, danach Rechte prüfen; nicht jede Innenmaßnahme ist eine neue Kapitalaufnahme.
]

// 0-68
#aufgabe(titel: "Insolvenzgrund und Gegenmaßnahme", art: "verstehen", quelle: "1.8")[
#text("Insolvenzgründe (Teil A5): Bestimme Insolvenzgrund und passende Gegenmaßnahme. (i) GmbH: Vermögen 2,0 Mio. €, Schulden 2,3 Mio. €, keine positive Fortführungsprognose. (ii) Unternehmen kann in drei Wochen nur 70 % der fälligen Rechnungen bezahlen. (iii) GmbH erwartet, eine im März fällige Kreditrate nicht bezahlen zu können.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü16. Verfahren: #stelle(<a-1-8>).]
][
(i) Vermögenslücke 0,3 Mio. € und keine positive Fortführung: Hinweis auf Überschuldung nach § 19, bei passender rechtlicher Bewertung. Ansätze: Einlage, Forderungsverzicht, geeigneter Rangrücktritt. (ii) 30 % nicht begleichbare Lücke: regelmäßig Zahlungsunfähigkeit im vereinfachten Dreiwochenfall; zusätzliche Liquidität oder verbindliche Zahlungsvereinbarungen prüfen. (iii) Erwartete nicht erfüllbare Märzrate: drohende Zahlungsunfähigkeit (§ 18); frühzeitig Finanzplan und Gegenmaßnahmen entwickeln. *Prüfung:* Die Antragspflichten der drei Fälle sind nicht identisch.
]

// 0-69
#aufgabe(titel: "Finanzielle Lage vollständig beurteilen", art: "rechnen", quelle: "1.10")[
#text("Ein Unternehmen meldet: JÜ 60, Abschreibungen 40, Zuführung zu Pensionsrückstellungen 20. Bilanz: AV 700, UV 300 (davon flüssige Mittel 30, Forderungen 120), EK 200, FK 800 (davon kurzfristig 300) (T€). Beurteile die finanzielle Lage so vollständig wie möglich und schlage zwei Maßnahmen vor.")
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
#text("Eine Gründerin sagt: „Mein Plan zeigt ab Jahr 1 Gewinn, einen Finanzplan brauche ich nicht.“ Nimm begründet Stellung.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü18. Verfahren: #stelle(<a-1-7>).]
][
Gewinn ist keine Zahlungsplanung. Die Gründerin muss Anlauf- und Investitionszahlungen, Kundenzahlungsziele sowie Zins/Tilgung und Reserven erfassen. Im Folienbeispiel 39–40 stehen spätere Gewinne neben negativen Planbeständen. *Prüfung:* Der Finanzplan zeigt Zeitpunkt und Höhe der Lücke; erst eine zugesagte Finanzierung macht das Programm zahlungsfähig.
]

// 0-71
#aufgabe(titel: "FK-Quote von 50 auf 85 Prozent", art: "rechnen", quelle: "1.12")[
#text("Ein Unternehmen mit rG = 12 % und rf = 7 % will die EK-Rendite steigern und die FK-Quote von 50 % auf 85 % erhöhen. Wie verändert sich die EK-Rentabilität? Welche Bedenken hast du?")
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
#text("Beurteile jeweils, ob das ein Warnsignal ist: a) negativer Cashflow aus Investitionstätigkeit bei hohem operativem Cashflow, b) Gewinn steigt, Kassenbestand sinkt, c) Anlagendeckung II von 80 %.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü20. Verfahren: #stelle(<a-1-6>).]
][
a) Hoher operativer CF und negativer Investitions-CF können selbst finanzierte Investitionen anzeigen; ohne Beträge, Fälligkeiten und Investitionsqualität ist kein pauschales Urteil möglich. b) Steigender Gewinn bei sinkender Kasse ist ein Anlass zur Überleitung, etwa wegen Forderungsaufbau oder Investitionen. c) AD II 80 % verfehlt die goldene Bilanzregel: Ein Teil des Anlagevermögens ist kurzfristig finanziert. *Prüfung:* Kennzahlen sind Warnhinweise und ersetzen nicht den Zahlungsplan.
]

// 0-73
#aufgabe(titel: "Neuer Kredit bei Überschuldung", art: "verstehen", quelle: "1.8")[
#text("Ein Kunde deiner Bank ist bilanziell überschuldet und bittet um einen zusätzlichen Kredit, „um die Lücke zu schließen“. Was antwortest du?")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü21. Verfahren: #stelle(<a-1-8>).]
][
Ein gewöhnlicher Kredit vergrößert Vermögen und Schulden um denselben Betrag. Die rechnerische Unterdeckung verschwindet dadurch nicht. Einlage, Forderungsverzicht oder ein rechtlich geeigneter Nachrang sind andere Ansatzpunkte. *Prüfung:* Handelsbilanzieller Fehlbetrag und rechtliche Überschuldung sind getrennt zu prüfen; eine Antragspflicht darf weder allein aus dem Buch-EK behauptet noch bei tatsächlich vorliegendem Grund übergangen werden.
]

// 0-74
#aufgabe(titel: "Glasspinnerei: Finanzplan, Plan-GuV, Planbilanz", art: "verstehen", quelle: "1.13")[
#text("Warum benötigt die Glasspinnerei gleichzeitig Finanzplan, Plan-GuV und Planbilanz? Erkläre die Rückkopplung über Zinsen, Steuern und Betriebskapital.")
#src[G, PDF-S. 4 und 7. Verfahren: #stelle(<a-1-13>).]
][
Die Bilanz liefert die operative Kapitalbindung und Finanzierungsbestände. Die GuV liefert Kosten, Abschreibung, Zinsaufwand und die Steuerbasis. Der Finanzplan liefert Mittelbedarf und Kreditaufnahme; daraus folgen wiederum Zinsen. *Prüfung:* Ein isolierter Gewinn genügt für keine vollständige Kapitalbedarfsrechnung.
]

// 0-75
#aufgabe(titel: "Glasspinnerei: Nettoumsatz und Kapazität", art: "rechnen", quelle: "1.13")[
#text("Berechne den Nettoumsatz 2005 aus Menge und Preis. Warum kann die Mengensteigerung 2008 nicht unverändert mit 12,5 % fortgesetzt werden?")
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
#text("Berechne das erweiterte EBK 2004 aus Lager 23.529, Forderungen 31.564, Lieferverbindlichkeiten 18.884, Rückstellungen Lizenzen/Löhne 7.744 und Steuerrückstellungen 19.348 (T€). Vergleiche mit 2003: −10.914 T€.")
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
#text("Berechne das erweiterte EBK 2005 und seine Änderung: Nettoumsatz 270.000 T€, LB 9 %, FLei 13 %, VLei 10 %, Lizenzrückstellungen 8.775 T€, Steuerrückstellungen 17.000 T€, EBK 2004 = 9.117 T€. Wie wirkt die Änderung auf den NOCF?")
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
#text("Berechne NOCF vor Steuern 2005: Nettoumsatz 270.000, Material 72.000, Löhne 73.828, sonstige betriebliche Aufwendungen 83.359, ΔEBK −2.492 (je T€). Warum darf keine Abschreibung als Auszahlung abgezogen werden?")
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
#text("Berechne die Abschreibung neuer Gebäude und Anlagen für 2005 sowie die jährlichen Restabschreibungen. Daten: Gebäude 30 Mio. €, zehn Jahre; Anlagen 55 Mio. €, vier Jahre; im Fall 75 % sofort, Rest linear über die verbleibende Zeit.")
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
#text("Die Plan-GuV nennt 2005 einen Verlust 39.410 T€ und 2006 einen Gewinn vor Verlustverrechnung 45.377 T€. Berechne bei der Fall-Steuerquote von 50 % die Steuer 2006. NOCF vor Steuern 2006: 63.912 T€. Wie hoch ist er danach?")
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
#text("Rechne den gesamten Finanzierungssaldo 2005: NOCF nach Steuern 43.305, bisherige Zinsen 3.214, neue Kredite 20.000 + 5.000, Investition 85.000, Dividende 3.120 (T€). Sonstige Tilgungs-/Rückzahlungsbeträge sind in der Falltabelle nicht angegeben. Vergleiche die Folgejahre.")
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
#text("Leite die Bilanzwerte 2005 für Gebäude und Maschinen her. Erkläre außerdem, warum die zunächst unterstellten zusätzlichen Gesellschafterdarlehen keine gesicherte Lösung sind.")
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
#text("Vergleiche die beiden Liquiditätsmaßnahmen 2005: 20 % der 85-Mio.-Investition auf 2006 verschieben und Forderungsquote bei 270 Mio. € Umsatz von 13 % auf 9,5 % senken. Wie groß ist die zusätzliche Verbesserung gegenüber dem Basisplan? Warum sind die genannten 11,9 Mio. € EBK-Freisetzung ein anderer Vergleich?")
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
#text("Was ändert lineare statt 75-%-Sofortabschreibung bei den neuen Gebäuden? Vergleiche 39,41 Mio. € Verlustvortrag vorher mit dem neuen Betrag. Unterscheide dabei Buchwirkung, Steuerzeitpunkt und heutige Insolvenzprüfung.")
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
#text("Formuliere die Schlussfolgerung der Glasspinnerei für einen Kreditgeber. Welche Rolle spielen Sonderabschreibungen, künftiger NOCF, die vorübergehende Finanzierungslücke und ein qualifizierter Rangrücktritt?")
#src[G, PDF-S. 18–24. Verfahren: #stelle(<a-1-18>).]
][
Der Kreditgeber braucht eine Überleitung: Der hohe bilanzielle Verlust stammt im Modell maßgeblich aus Sonderabschreibungen; das Kerngeschäft erwirtschaftet dennoch hohe Zahlungsüberschüsse. Die Lücke 2005 ist bei tragfähigen Annahmen vorübergehend, erfordert aber eine zugesagte Brücke. Ein geeigneter Nachrang kann für die Überschuldungsprüfung Bedeutung haben, ist jedoch keine automatische Löschung der Schuld oder Auffüllung handelsbilanziellen EK. *Prüfung:* Zukünftige Liquidität, Bilanzbild und rechtliche Voraussetzungen müssen gemeinsam erklärt werden.
]

// 0-86
#aufgabe(titel: "Klausur: Gründung mit 800.000 € Kapital", art: "rechnen", quelle: "1.12")[
#text("Ein Investor plant eine Unternehmensgründung mit 800.000 € Gesamtkapital. Er kann 300.000 € bis 500.000 € Eigenkapital einbringen, der Rest ist Fremdkapital. Das Unternehmen erwartet jährlich einen Bruttogewinn (Gewinn vor Abzug der Fremdkapitalzinsen) von 70.000 €. Ermittle die Gesamtkapitalrentabilität (in %, 2 Nachkommastellen; 2 P.) und die Eigenkapitalrentabilität des Investors (6 P.) für: (1) 500.000 € EK / 300.000 € FK zu 6 %; (2) 300.000 € EK / 500.000 € FK zu 6 %; (3) 500.000 € EK / 300.000 € FK zu 10,5 %; (4) 300.000 € EK / 500.000 € FK zu 10,5 %.")
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
#text("Die Rhein GmbH legt für 2015 diese GuV vor (Mio. €): Materialaufwand 21, Personalaufwand 23, Aufwand aus Zuführung zu Pensionsrückstellungen 4, Abschreibungen 7, sonstiger Aufwand 5, Jahresüberschuss 9; Umsatzerlöse 69. Berechne den Cashflow 2015 nach der direkten und nach der indirekten Methode. Alle zahlungswirksamen Positionen waren im Jahr der Verbuchung tatsächlich voll zahlungswirksam.")
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

