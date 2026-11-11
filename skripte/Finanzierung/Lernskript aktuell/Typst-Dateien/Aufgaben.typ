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


#kapitel("Kapitel 1 · Grundlagen der Finanzplanung")

#aufgabe(titel: "Ziele der Finanzierung und Sachziel", art: "verstehen", quelle: "1.1", herkunft: "eigen")[
#if not web [*Aufgabe 1* #linebreak()]
#text("Nenne die drei Ziele der Finanzierung und das Sachziel mit seinen vier „richtig“.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A1. Verfahren: #stelle(<a-1-1>).]
][
#text("Gewinn/Rentabilität, Liquidität, Sicherheit. Sachziel: finanzielle Mittel im notwendigen Umfang, in der erforderlichen Art, zum richtigen Zeitpunkt, am richtigen Ort.")
][
*Ergänzung aus der Karteikarte „Was ist die Aufgabe der Finanzierung?“:*
- Mittel in der *richtigen Höhe und Art* bereitstellen.
- Sie müssen am *richtigen Ort und Termin* verfügbar sein.
- Geld im Juni hilft nicht bei einer Zahlung im März.

*Merksatz:* Das richtige Geld muss auch rechtzeitig da sein.

#align(center, image("abbildungen/zieldreieck.svg", width: 75%))
]

#aufgabe(titel: "Das magische Dreieck", art: "verstehen", quelle: "1.1", herkunft: "eigen")[
#if not web [*Aufgabe 2* #linebreak()]
#text("Erkläre das magische Dreieck. Nenne zu jeder Ecke ein Beispiel, warum sie mit einer anderen in Konflikt steht.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A2. Verfahren: #stelle(<a-1-1>).]
][
#text("Rentabilität, Sicherheit, Liquidität lassen sich nicht gleichzeitig maximieren. Rentabel ↔ sicher: hohe Rendite meist mit hohem Risiko (Aktien vs. Sparbuch). Liquide ↔ rentabel: Bargeld bringt keine Zinsen. Sicher ↔ rentabel: sichere Anlagen bringen wenig. Wo man sich einordnet, hängt von der Risikoaversion ab.")
][
*Ergänzung aus der Karteikarte „Was ist das magische Dreieck der Finanzierung?“:*
- Drei Ziele, die sich gegenseitig im Weg stehen:
- *Rentabilität:* Das Kapital soll Ertrag bringen.
- *Sicherheit:* Schutz vor Verlusten.
- *Liquidität:* Fällige Zahlungen müssen geleistet werden können.
- Hohe Rendite heißt meist mehr Risiko, viel Bargeld als Reserve kostet Rendite.
- Alle drei gleichzeitig maximieren geht nicht.

*Merksatz:* Rendite, Sicherheit, Liquidität ziehen an drei Ecken.

#align(center, image("abbildungen/zieldreieck.svg", width: 75%))
][
*Bild:* Ein Dreieck mit drei gespannten Gummibändern: Eine Ecke weit zu ziehen belastet die anderen Ziele.
][
*Antwort:* Kontrollfrage: „Welche drei Ziele bilden das magische Dreieck der Finanzierung?“ Rentabilität, Sicherheit, Liquidität. Genau diese drei stehen im Zielkonflikt: Rendite kostet meist Sicherheit, Liquiditätsreserven kosten Rendite.
][
*Typische Verwechslungen:*
- „Rentabilität, Wachstum, Liquidität“: Wachstum ist kein Ziel des Dreiecks. An seiner Stelle steht die Sicherheit vor Verlusten.
- „Liquidität, Solvenz, Bonität“: Das sind verwandte Begriffe rund um die Zahlungsfähigkeit, aber nicht das Zieldreieck. Die Rendite fehlt ganz.
- „Umfang, Zeitpunkt, Ort“: Das sind Merkmale des Finanzierungsbegriffs (was bereitgestellt wird), keine konkurrierenden Ziele.
][
*Antwort:* Kontrollfrage: „Warum heißt das Dreieck „magisch“?“ Weil die Ziele im Konflikt stehen und nicht alle gleichzeitig maximal erreichbar sind. Hohe Rendite geht meist mit mehr Risiko einher, viel Kasse sichert Liquidität, bringt aber kaum Ertrag.
][
*Typische Verwechslungen:*
- „Weil sich alle drei Ziele mit guter Planung gleichzeitig maximieren lassen.“: Genau das geht nicht. Wer alle drei zugleich maximieren will, verlangt etwas Unmögliches, daher der Name.
- „Weil nur eines der drei Ziele für Unternehmen wirklich zählt.“: Alle drei zählen. Liquidität ist sogar existenziell. Es geht um die Abwägung zwischen ihnen.
- „Weil es von der Risikoaversion unabhängig immer eine richtige Lösung gibt.“: Umgekehrt: Zwischen sicher und rentabel gibt es keine pauschal richtige Wahl, die Risikoneigung entscheidet mit.
]

#aufgabe(titel: "Kredit kommt zu spät: welches Teilziel?", art: "verstehen", quelle: "1.1", herkunft: "eigen", tipp: [Geh die vier Merkmale Umfang, Art, Zeitpunkt und Ort einzeln durch.])[
#if not web [*Aufgabe 3* #linebreak()]
Ein Maschinenbauer braucht im März 500.000 € für eine Fräsmaschine. Die Bank sagt den Kredit in voller Höhe zu, das Geld fließt aber erst im Juni. Welches Teilziel der Finanzierung ist verfehlt? Begründe mit den vier Merkmalen des Sachziels.
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Antwort:* Der Zeitpunkt. Finanzierung heißt Mittel in passendem Umfang, passender Art, zum richtigen Zeitpunkt und am richtigen Ort. Ein Kredit im Juni löst den Zahlungsbedarf im März nicht.
][
*Typische Verwechslungen:*
- „Der Umfang“: Der Betrag stimmt, es sind volle 500.000 €. Am Betrag liegt das Problem nicht.
- „Die Rentabilität“: Rentabilität ist ein Ziel im magischen Dreieck, kein Bestandteil des Finanzierungsbegriffs. Über die Kosten des Kredits sagt die Frage nichts.
- „Die Art der Mittel“: Zur Laufzeit des zugesagten Kredits macht der Fragetext keine Angabe. Der verspätete Geldzufluss belegt hier den Fehler beim Zeitpunkt.
]

#aufgabe(titel: "Begriffslandkarte Kapitel 1", art: "verstehen", quelle: "1.1", herkunft: "eigen")[
#if not web [*Aufgabe 4* #linebreak()]
Zeichne die Begriffslandkarte zu Kapitel 1 aus dem Kopf: Welche Begriffe gehören dazu und wie hängen sie zusammen?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- *Ziele → Finanzierungsformen:* Herkunft innen/außen; Rechte Eigen-/Fremdkapital.
- *Erfolg von Zahlung trennen → Cashflow:* direkt/indirekt, drei Bereiche, Free Cashflow.
- *Finanzplan:* Zahlungen terminieren, Lücken und Insolvenzgefahr früh erkennen.
- *Kennzahlen und Leverage:* Deckung, Kapitalstruktur, Rentabilität und Risiko beurteilen.
- *Aktienkennzahlen:* Buch-/Ertragswert vom Marktpreis trennen.
- *Working Capital:* Bilanzpuffer; *Bindungsdauer:* operativen Finanzierungsbedarf bestimmen.
- *Glasspinnerei:* Absatz → EBK → NOCF → Finanzplan → Kapitalbedarf → Planbilanz.
][
*Bild:* Wie eine Reiseplanung: Erst klären, wer zahlt, dann wann das Geld gebraucht wird, dann ob die Kasse unterwegs reicht.
]

#aufgabe(titel: "Vier Unterschiede: außen und innen", art: "verstehen", quelle: "1.2", herkunft: "original", vorlage: "Vorlesung PDF-S. 6, Folie 11, Aufgabe")[
#if not web [*Aufgabe 5* #linebreak()]
#text("Nenne die vier Unterschiede zwischen Außen- und Innenfinanzierung.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A4. Verfahren: #stelle(<a-1-2>).]
][
#text("(1) Kapitalgeber außerhalb vs. Vorgänge innerhalb; (2) Beträge exakt festgelegt vs. Höhe zum Teil ungewiss; (3) Fristen exakt vs. zum Teil ungewiss; (4) Einzelakte zu vereinbarten Zeitpunkten vs. laufend, oft erst am Periodenende erkennbar.")
]

#aufgabe(titel: "Sechs Merkmale von Eigen- und Fremdkapital", art: "verstehen", quelle: "1.2", herkunft: "original", vorlage: "Vorlesung PDF-S. 5, Folie 10, Aufgabe")[
#if not web [*Aufgabe 6* #linebreak()]
#text("Nenne die sechs Merkmale, in denen sich Eigen- und Fremdkapital unterscheiden.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A7. Verfahren: #stelle(<a-1-2>).]
][
#text("Erfolgsbeteiligung / keine; keine festen Zahlungsansprüche / fester Zins- und Tilgungsanspruch; Quotenanteil / Nominalanspruch; unbefristet / befristet; Haftung / keine Haftung; Mitwirkungsrechte / keine Leitungsrechte.")
]

#aufgabe(titel: "Klausur: weitere Formen der Innenfinanzierung", art: "verstehen", quelle: "1.2", herkunft: "original", vorlage: "Altklausur 2017, Aufg. 4 (Zusatzfrage)", minuten: 2)[
#if not web [*Aufgabe 7* #linebreak()]
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

#aufgabe(titel: "Außen- und Innenfinanzierung definieren", art: "verstehen", quelle: "1.2", herkunft: "eigen")[
#if not web [*Aufgabe 8* #linebreak()]
#text("Definiere Außen- und Innenfinanzierung in je einem Satz.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A3. Verfahren: #stelle(<a-1-2>).]
][
#text("Außen: Mittel kommen über Finanzierungsverträge von Kapitalgebern außerhalb des Unternehmens. Innen: Mittel entstehen bzw. verbleiben durch Vorgänge innerhalb des Unternehmens (einbehaltene Gewinne, Abschreibungen, Rückstellungen).")
]

#aufgabe(titel: "Es kommt auf die Gegenleistung an", art: "verstehen", quelle: "1.2", herkunft: "eigen")[
#if not web [*Aufgabe 9* #linebreak()]
#text("„Es kommt immer auf die Gegenleistung an.“ Erkläre den Satz anhand von Zins, Gewinn, Rückzahlung, Stimmrechten und Kündigungsrecht.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A5. Verfahren: #stelle(<a-1-2>).]
][
#text("FK-Geber erhalten Zins, Rückzahlung und ein Kündigungsrecht, aber keinen Gewinnanteil und keine Stimmrechte. EK-Geber erhalten Gewinnanteil und Stimmrechte, aber keinen Zins und keinen Anspruch auf Rückzahlung. Ob etwas EK oder FK ist, entscheidet also die vereinbarte Gegenleistung.")
]

#aufgabe(titel: "Einfluss der Bank ohne Leitungsrechte", art: "verstehen", quelle: "1.2", herkunft: "eigen")[
#if not web [*Aufgabe 10* #linebreak()]
#text("Warum kann eine Bank faktisch Einfluss auf ein Unternehmen nehmen, obwohl Fremdkapitalgeber keine Leitungsrechte haben?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A6. Verfahren: #stelle(<a-1-2>).]
][
#text("Über die Kündigungsdrohung: Wenn die Bank den Kredit kündigen oder nicht verlängern kann, muss das Unternehmen auf ihre Bedingungen eingehen.")
]

#aufgabe(titel: "Finanzierungsformen nach Drukarczyk zuordnen", art: "verstehen", quelle: "1.2", herkunft: "eigen")[
#if not web [*Aufgabe 11* #linebreak()]
#text("Ordne den Finanzierungsformen nach Drukarczyk zu (Nr. 1–9): a) Bankkredit, b) Darlehen eines GmbHGesellschafters an seine GmbH, c) Kapitalerhöhung durch die bisherigen Gesellschafter, d) Aufnahme eines neuen Gesellschafters, e) Gewinn wird nicht ausgeschüttet, f) Verkauf einer nicht mehr benötigten Lagerhalle.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A8. Verfahren: #stelle(<a-1-2>).]
][
#text("a) 1 Fremdfinanzierung · b) 2 Gesellschafterdarlehen · c) 3 Eigenfinanzierung · d) 4 Beteiligungsfinanzierung · e) 6 offene Selbstfinanzierung · f) 9 Vermögensumschichtung.")
]

#aufgabe(titel: "Eigenfinanzierung und Selbstfinanzierung", art: "verstehen", quelle: "1.2", herkunft: "eigen")[
#if not web [*Aufgabe 12* #linebreak()]
#text("Worin unterscheiden sich Eigenfinanzierung und Selbstfinanzierung?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A9. Verfahren: #stelle(<a-1-2>).]
][
#text("Eigenfinanzierung: bisherige Eigentümer legen neues Eigenkapital von außen ein (Außenfinanzierung). Selbstfinanzierung: Gewinne werden im Unternehmen einbehalten (Innenfinanzierung).")
][
*Ergänzung aus der Karteikarte „Was ist Selbstfinanzierung, und wie unterscheidet sie sich von Eigenfinanzierung durch Einlagen?“:*
- *Selbstfinanzierung:* Gewinne werden einbehalten statt ausgeschüttet, das ist Innenfinanzierung.
- *Eigenfinanzierung durch Einlage:* Eigentümer bringen von außen neues Kapital ein, das ist Außenfinanzierung.
- Beides ist Eigenkapital, aber die Herkunft ist verschieden.

*Merksatz:* Einbehalten kommt von innen; Einlegen kommt von außen.

#align(center, image("abbildungen/finanzierungsformen-folie.svg", width: 75%))
]

#aufgabe(titel: "Finanzierungsformen außen, innen, EK, FK", art: "verstehen", quelle: "1.2", herkunft: "eigen")[
#if not web [*Aufgabe 13* #linebreak()]
#text("Finanzierungsformen (Teil A2): Ordne zu (Nr. 1–9 nach Drukarczyk, außen/innen, EK/FK): a) Ausgabe neuer Aktien an neue Aktionäre, b) Gewinn wird einbehalten, c) Verkauf einer nicht mehr benötigten Halle, d) Ausgabe einer Anleihe, e) die bisherigen Gesellschafter erhöhen ihre Einlage.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü15. Verfahren: #stelle(<a-1-2>).]
][
a) Nr. 4 Beteiligungsfinanzierung: außen, EK. b) Nr. 6 offene Selbstfinanzierung: innen, EK. c) Nr. 9 Vermögensumschichtung: innen; der Verkauf ist keine neue EK-/FK-Aufnahme. d) Nr. 1 Fremdfinanzierung: außen, FK. e) Nr. 3 Eigenfinanzierung: außen, EK. *Prüfung:* Erst Herkunft, danach Rechte prüfen; nicht jede Innenmaßnahme ist eine neue Kapitalaufnahme.
]

#aufgabe(titel: "Gesellschafterdarlehen einordnen", art: "verstehen", quelle: "1.2", herkunft: "eigen", tipp: [Stell zwei Fragen getrennt: Woher kommt das Geld? Welche Rechte bekommt der Geber?])[
#if not web [*Aufgabe 14* #linebreak()]
Ein Gesellschafter gibt seiner GmbH ein Darlehen. Ist das Eigen- oder Fremdkapital, Außen- oder Innenfinanzierung? Begründe mit Herkunft und Rechten.
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Fremdkapital.
- Der Geber ist zwar Eigentümer, aber das Darlehen gibt ihm Gläubigerrechte: Zins und Rückzahlung.
- Person und Kapitalrolle muss man auseinanderhalten.

*Merksatz:* Die Rechte zählen, nicht der Name des Geldgebers.

#align(center, image("abbildungen/finanzierungsformen-folie.svg", width: 75%))
][
*Antwort:* Kontrollfrage: „Ein Gesellschafter gibt seiner GmbH ein Darlehen. Wie ist dieser Vorgang einzuordnen?“ Außenfinanzierung mit Fremdkapital (Gesellschafterdarlehen). Das Geld kommt von außerhalb des Unternehmens, und es entsteht ein Rückzahlungsanspruch. Der Geber ist Eigentümer, das Darlehen bleibt trotzdem Fremdkapital.
][
*Typische Verwechslungen:*
- „Eigenfinanzierung, weil der Geldgeber Eigentümer ist.“: Hier wird die Herkunft mit der Rechtsstellung verwechselt. Bei Eigenfinanzierung legt der Eigentümer Eigenkapital ein, hier gibt er aber ein Darlehen.
- „Innenfinanzierung, weil der Gesellschafter zum Unternehmen gehört.“: Innenfinanzierung entsteht aus Vorgängen im Unternehmen, etwa einbehaltenen Gewinnen. Der Gesellschafter ist ein externer Kapitalgeber.
- „Beteiligungsfinanzierung“: Beteiligungsfinanzierung heißt, dass neue Kapitalgeber Eigenkapital einlegen. Hier gibt ein bisheriger Eigentümer Fremdkapital.
]

#aufgabe(titel: "Formen der Innenfinanzierung erkennen", art: "verstehen", quelle: "1.2", herkunft: "eigen")[
#if not web [*Aufgabe 15* #linebreak()]
Welche Finanzierungsformen gehören zur Innenfinanzierung? Prüfe dabei auch Beteiligungsfinanzierung durch einen neuen Gesellschafter und hybride Finanzierung und begründe jeweils.
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Antwort:* Zutreffend sind:
- Offene Selbstfinanzierung durch einbehaltene Jahresüberschüsse: Der Gewinn bleibt im Unternehmen, es fließt kein neues Geld von außen zu.
- Vermögensumschichtung durch den Verkauf nicht mehr benötigter Anlagen: Gebundenes Vermögen wird zu Geld gemacht. Die Mittel entstehen aus dem Unternehmen selbst.
- Stille Selbstfinanzierung über Ansatz- und Bewertungsspielräume: Bewertungsspielräume senken den ausgewiesenen Gewinn und damit Ausschüttungen. So bleiben Mittel im Unternehmen.
][
*Typische Verwechslungen:*
- „Beteiligungsfinanzierung durch einen neuen Gesellschafter“: Ein neuer Gesellschafter bringt Geld von außen ein. Das ist Außenfinanzierung mit Eigenkapital.
- „Hybride Finanzierung“: Hybride Finanzierung kombiniert Eigentümer- und Gläubigerrechte eines externen Kapitalgebers und zählt zur Außenfinanzierung.
]

#aufgabe(titel: "Fremdkapital im Grundmodell", art: "verstehen", quelle: "1.2", herkunft: "eigen")[
#if not web [*Aufgabe 16* #linebreak()]
Was gilt im Grundmodell der Vorlesung für Fremdkapital? Gehe auf Erfolgsbeteiligung, Befristung und Zahlungsanspruch, Rückzahlungssicherheit und Stimmrechte ein.
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Antwort:* Fremdkapital ist befristet und begründet einen festen Nominalanspruch auf Zins und Tilgung. FK ist befristet, der Anspruch hängt nicht vom Gewinn ab. Ob er tatsächlich erfüllt wird, hängt aber vom Schuldner ab.
][
*Typische Verwechslungen:*
- „Fremdkapitalgeber sind am Erfolg beteiligt und tragen Verluste wie Eigentümer.“: Erfolgsbeteiligung und Verlusthaftung kennzeichnen das Eigenkapital. FK hat einen festen Zins- und Tilgungsanspruch.
- „Ein Fremdkapitalgeber bekommt sein Geld garantiert zurück.“: „Keine Haftung“ heißt nur, dass FK nicht vertraglich die Verluste trägt. In der Insolvenz kann auch ein Gläubiger Geld verlieren.
- „Fremdkapitalgeber haben gesellschaftsrechtliche Stimmrechte.“: Stimm- und Leitungsrechte gehören zum Eigenkapital. FK-Geber haben höchstens faktischen Einfluss, etwa über Kündigung oder Verlängerung.
]

#aufgabe(titel: "Zwei Fragen zur Einordnung", art: "verstehen", quelle: "1.2", herkunft: "eigen")[
#if not web [*Aufgabe 17* #linebreak()]
Nach welchen zwei Fragen ordnet man einen Finanzierungsvorgang?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- *Herkunft:* von außen → Außenfinanzierung; aus dem Unternehmen → Innenfinanzierung.
- *Rechte:* Eigentümerrechte → Eigenkapital; Gläubigerrechte → Fremdkapital.
- Beide Fragen getrennt beantworten.

*Merksatz:* Herkunft und Rechte getrennt prüfen.

#align(center, image("abbildungen/finanzierungsformen-folie.svg", width: 75%))
]

#aufgabe(titel: "Eigenkapital und Fremdkapital im Vergleich", art: "verstehen", quelle: "1.2", herkunft: "eigen")[
#if not web [*Aufgabe 18* #linebreak()]
Was unterscheidet Eigenkapital von Fremdkapital?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- *Eigenkapital:* Beteiligung am Gewinn und Verlust, Mitspracherechte, keine feste Rückzahlung, dient als Verlustpolster.
- *Fremdkapital:* fester Anspruch auf Zins und Tilgung, keine Gewinnbeteiligung, im Grundmodell keine Stimmrechte.
- Gläubiger haben aber über Kündigung oder Verlängerung faktisch Einfluss.

#align(center, image("abbildungen/finanzierungsformen-folie.svg", width: 75%))
][
*Bild:* Darlehen für ein Café: fester Zins, egal wie es läuft. Beteiligung: Anteil am Gewinn und Mitsprache, aber auch am Risiko.
]

#aufgabe(titel: "„Fremdkapital haftet nicht“ richtig lesen", art: "verstehen", quelle: "1.2", herkunft: "eigen")[
#if not web [*Aufgabe 19* #linebreak()]
Heißt „Fremdkapital haftet nicht“, dass der Gläubiger sein Geld sicher zurückbekommt?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Nein.
- Es heißt nur, dass Fremdkapital nicht vertraglich die Verluste trägt wie Eigenkapital.
- In der Insolvenz kann auch ein Gläubiger Geld verlieren.

#align(center, image("abbildungen/finanzierungsformen-folie.svg", width: 75%))
]

#aufgabe(titel: "Planbarkeit von Außen- und Innenfinanzierung", art: "verstehen", quelle: "1.2", herkunft: "eigen")[
#if not web [*Aufgabe 20* #linebreak()]
Was unterscheidet Außen- und Innenfinanzierung in der Planbarkeit?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Außenfinanzierung ist vertraglich festgelegt: Betrag, Frist und Termin sind bekannt (z. B. Kredit über 200.000 € ab 1.
- März).
- Innenfinanzierung entsteht laufend im Unternehmen, Betrag und Zeitpunkt stehen oft erst am Periodenende fest.

#align(center, image("abbildungen/finanzierungsformen-folie.svg", width: 75%))
]

#aufgabe(titel: "Vorlesung: Anlage mit der geringsten Liquidität", art: "verstehen", quelle: "1.3", herkunft: "original", vorlage: "Vorlesung PDF-S. 8, Folie 15, Aufgabe", minuten: 4)[
#if not web [*Aufgabe 21* #linebreak()]
Welche der folgenden Anlagen weist die geringste Liquidität auf? Begründe für jede der vier Anlagen, wie schnell du an dein Geld kommst.
- üblicher Sparbrief über 4 % p. a. mit einer Restlaufzeit von 2 Jahren
- Bundesanleihe mit einer Restlaufzeit von 4 Jahren
- Tagesgeld
- Festgeld mit einer Restlaufzeit von einem Monat
#src[V, PDF-S. 8, Folien 15–16 (Quelle der Folie: Pfeifer, Aufgabenbuch, Aufg. 1.3.7).]
][
*Maßstab festlegen:* Liquidität einer Anlage heißt hier: Wie schnell und sicher wird sie wieder zu Geld? Nicht die Restlaufzeit allein zählt, sondern ob man vorher verkaufen oder kündigen kann.
][
*Antwort:* Der *Sparbrief* ist am wenigsten liquide. Sparbriefe sind in der Regel nicht kündbar; an das Geld kommst du erst nach der Restlaufzeit von zwei Jahren.
][
*Die anderen begründen:* Die Bundesanleihe wird an der Börse gehandelt und lässt sich börsentäglich verkaufen, trotz vier Jahren Restlaufzeit. Tagesgeld ist täglich verfügbar. Beim Festgeld wartest du nur noch einen Monat.
][
*Prüfen:* Die längste Restlaufzeit (Anleihe) ist nicht automatisch die geringste Liquidität. Entscheidend ist die Liquidisierbarkeit über einen Markt bzw. ein Kündigungsrecht.
]

#aufgabe(titel: "Bundesanleihe gegen Sparbrief", art: "verstehen", quelle: "1.3", herkunft: "variante", vorlage: "Vorlesung PDF-S. 8, Folie 15, Aufgabe")[
#if not web [*Aufgabe 22* #linebreak()]
#text("Warum ist eine 4-jährige Bundesanleihe liquider als ein Sparbrief mit 2 Jahren Restlaufzeit?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A13. Verfahren: #stelle(<a-1-3>).]
][
#text("Die Bundesanleihe wird an der Börse gehandelt und kann börsentäglich verkauft werden. Der Sparbrief ist in der Regel nicht kündbar, man kommt erst nach Laufzeitende an das Geld.")
][
*Ergänzung aus der Karteikarte „Warum kann eine Anleihe mit vier Jahren Laufzeit liquider sein als ein Sparbrief mit zwei Jahren?“:*
- Die Anleihe ist an der Börse handelbar und kann jederzeit verkauft werden.
- Der Sparbrief ist nicht vorzeitig kündbar.
- Es zählt, wann man tatsächlich an das Geld kommt, nicht das Laufzeitende.

#align(center, image("abbildungen/liquiditaetsarten-folie.svg", width: 75%))
][
*Antwort:* Kontrollfrage: „Warum kann eine vierjährige Bundesanleihe liquider sein als ein zweijähriger Sparbrief?“ Weil die Anleihe börslich gehandelt wird und vorzeitig verkauft werden kann, der Sparbrief aber nicht kündbar ist. Liquidisierbarkeit fragt, wie schnell ein Wert zu Geld wird. Der Sparbrief bindet bis zum Ende, die Anleihe lässt sich jederzeit verkaufen, wenn auch mit Kursrisiko.
][
*Typische Verwechslungen:*
- „Weil die Anleihe höher verzinst ist.“: Der Zins beantwortet die Frage nach der Rendite, nicht nach der Verfügbarkeit.
- „Weil eine längere Laufzeit immer liquider ist.“: Eine längere Laufzeit macht ein Papier normalerweise weniger liquide. Entscheidend ist hier etwas anderes.
- „Weil Staatsanleihen kein Kursrisiko haben.“: Auch Anleihen schwanken im Kurs. Verfügbarkeit und Verkaufspreis sind zwei verschiedene Fragen.
]

#aufgabe(titel: "Liquidität als oberstes Ziel", art: "verstehen", quelle: "1.3", herkunft: "eigen")[
#if not web [*Aufgabe 23* #linebreak()]
#text("Definiere Liquidität. Warum hat das Liquiditätsziel die höchste Bedeutung in der Zielhierarchie?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A10. Verfahren: #stelle(<a-1-3>).]
][
Liquidität heißt: fällige Zahlungen fristgerecht und betragsgenau erfüllen können. Dieses Ziel ist dauerhaft und existenziell; Zahlungsunfähigkeit kann ein Insolvenzverfahren auslösen. Gewinn ist dafür kein Ersatz, weil er andere Größen und Periodenzuordnungen erfasst.
][
*Ergänzung aus der Karteikarte „Was ist Liquidität?“:*
- Die Fähigkeit, gegenwärtige und künftige Zahlungen fristgerecht und in voller Höhe zu leisten.
- Es zählen Betrag *und* Termin.
- Liquidität ist existenziell, ohne sie droht Insolvenz.

*Merksatz:* Zahlungsfähig heißt: genug Geld zum richtigen Termin.

#align(center, image("abbildungen/liquiditaetsarten-folie.svg", width: 75%))
][
*Antwort:* Kontrollfrage: „Liquidität ist die Fähigkeit, Zahlungsverpflichtungen \_\_\_ und \_\_\_ zu erfüllen.“ Liquidität ist die Fähigkeit, Zahlungsverpflichtungen *fristgerecht* und *betragsgenau* zu erfüllen.
][
*Erklärung:* Liquidität verlangt beides: Die Zahlung muss zum Fälligkeitstermin erfolgen, und zwar in voller Höhe. Eine Teilzahlung oder eine verspätete Zahlung reicht nicht.
]

#aufgabe(titel: "Gewinn und trotzdem zahlungsunfähig", art: "verstehen", quelle: "1.3", herkunft: "eigen")[
#if not web [*Aufgabe 24* #linebreak()]
#text("Erkläre an einem Beispiel, wie ein Unternehmen Gewinn machen und trotzdem zahlungsunfähig werden kann.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A11. Verfahren: #stelle(<a-1-3>).]
][
#text("Z. B. großer Auftrag auf Ziel: Ertrag und Gewinn sind gebucht, das Geld kommt erst in 90 Tagen. Löhne und Lieferanten müssen aber jetzt bezahlt werden. Reicht die Kasse nicht, ist das Unternehmen trotz Gewinn zahlungsunfähig.")
][
*Ergänzung aus der Karteikarte „Warum garantiert ein Gewinn keine Zahlungsfähigkeit?“:*
- Der Gewinn kann schon entstanden sein, bevor das Geld da ist.
- *Beispiel:* Ein Auftrag über 80.000 € ist erledigt, aber der Kunde zahlt erst in 90 Tagen.
- Löhne und Lieferanten müssen vorher bezahlt werden.
- Umgekehrt kann man einen Verlust mit vorhandenem Geld überbrücken.

*Merksatz:* Gewinn auf Papier bezahlt keine heutige Rechnung.
][
*Bild:* Eine offene Kundenrechnung ist noch kein Geld auf dem Konto.
][
*Antwort:* Kontrollfrage: „Ein Betrieb erzielt im Jahr einen hohen Gewinn und wird trotzdem zahlungsunfähig. Wie kann das passieren?“ Die Erträge sind gebucht, die Kunden zahlen aber erst später, während Löhne und Lieferanten schon fällig sind. Genau das zeigt das Handwerksbeispiel: 80.000 € Auftrag, Zahlung nach 90 Tagen. Liquidität heißt fristgerecht und betragsgenau zahlen können.
][
*Typische Verwechslungen:*
- „Gar nicht, denn Gewinn bedeutet immer, dass genug Geld da ist.“: Gewinn ist eine Erfolgsgröße. Ob Geld da ist, hängt davon ab, wann tatsächlich gezahlt wird.
- „Weil Abschreibungen in derselben Periode Geld abfließen lassen.“: Abschreibungen mindern den Gewinn, lassen aber kein Geld abfließen. Sie würden eher den umgekehrten Effekt erklären.
- „Weil Zahlungsunfähigkeit nur bei Verlusten eintreten kann.“: Zahlungsunfähigkeit hängt an Fälligkeiten und verfügbaren Mitteln, nicht am Gewinn. Umgekehrt kann man Verlustjahre mit vorhandenem Geld überbrücken.
]

#aufgabe(titel: "Vier Liquiditätsquellen", art: "verstehen", quelle: "1.3", herkunft: "eigen")[
#if not web [*Aufgabe 25* #linebreak()]
#text("Nenne die vier Liquiditätsquellen aus Folie 14 mit je einem Beispiel.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A12. Verfahren: #stelle(<a-1-3>).]
][
#text("güterwirtschaftliche Liquidität (Vermögen verkaufen, z. B. Wertpapiere); zukünftige Liquidität (künftige Einzahlungsüberschüsse, z. B. Umsätze); verliehene Liquidität (Vermögen beleihen, z. B. Grundschuld auf das Firmengrundstück); antizipierte Liquidität (künftige Überschüsse beleihen, z. B. Kredit auf erwartete Cashflows).")
]

#aufgabe(titel: "Warum die Bilanz Liquidität schlecht misst", art: "verstehen", quelle: "1.3", herkunft: "eigen")[
#if not web [*Aufgabe 26* #linebreak()]
#text("Warum ist die Bilanz nur bedingt geeignet, die Liquidität zu messen?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A14. Verfahren: #stelle(<a-1-3>).]
][
Die Bilanz zeigt Vermögens- und Kapitalbestände an einem Stichtag; die GuV arbeitet mit Erträgen und Aufwendungen. Beides ergibt noch keinen Kalender künftiger Einzahlungen, Auszahlungen und Fälligkeiten. Für diese Frage braucht man den Zahlungsplan.
]

#aufgabe(titel: "Grundstück beleihen: welche Liquidität?", art: "verstehen", quelle: "1.3", herkunft: "eigen")[
#if not web [*Aufgabe 27* #linebreak()]
Ein Unternehmen beleiht ein Grundstück, um an Geld zu kommen. Welche Liquiditätsart nutzt es? Grenze sie von den anderen drei Liquiditätsquellen ab.
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Antwort:* Verliehene Liquidität. Vorhandenes Vermögen wird beliehen, die Quelle ist also abgeleitet. Das ist die verliehene Liquidität.
][
*Typische Verwechslungen:*
- „Güterwirtschaftliche Liquidität“: Güterwirtschaftlich hieße, das Grundstück zu verkaufen. Hier bleibt es im Eigentum und dient nur als Sicherheit.
- „Antizipierte Liquidität“: Antizipiert heißt, künftige Überschüsse vorzufinanzieren. Hier wird aber vorhandenes Vermögen genutzt.
- „Zukünftige Liquidität“: Zukünftige Liquidität heißt, auf Überschüsse zu warten. Beim Beleihen kommt das Geld sofort, nur eben geliehen.
]

#aufgabe(titel: "Liquidisierbarkeit", art: "verstehen", quelle: "1.3", herkunft: "eigen")[
#if not web [*Aufgabe 28* #linebreak()]
Was bedeutet Liquidisierbarkeit?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Wie schnell und problemlos ein Vermögensgegenstand zu Geld gemacht werden kann.
- Bargeld ist sofort verfügbar, Forderungen müssen erst eingezogen, Waren verkauft, Grundstücke und Maschinen mühsam veräußert werden.

#align(center, image("abbildungen/liquiditaetsarten-folie.svg", width: 75%))
]

#aufgabe(titel: "Aufwand, Auszahlung, Ertrag, Einzahlung", art: "verstehen", quelle: "1.4", herkunft: "eigen")[
#if not web [*Aufgabe 29* #linebreak()]
#text("Erkläre den Unterschied zwischen Aufwand und Auszahlung sowie zwischen Ertrag und Einzahlung mit je einem Beispiel.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A15. Verfahren: #stelle(<a-1-4>).]
][
#text("Aufwand = Werteverzehr einer Periode (GuV), Auszahlung = Abfluss von Geld. Beispiel: Abschreibung ist Aufwand ohne Auszahlung; Maschinenkauf ist Auszahlung, wird aber erst über Jahre zu Aufwand. Ertrag = Wertzuwachs, Einzahlung = Zufluss von Geld. Beispiel: Verkauf auf Ziel ist Ertrag, Einzahlung erst später; Kundenanzahlung ist Einzahlung, Ertrag erst später.")
][
*Ergänzung aus der Karteikarte „Was ist der Unterschied zwischen Aufwand und Auszahlung?“:*
- Aufwand ist der Werteverzehr, der einer Periode zugerechnet wird (Erfolgsrechnung).
- Auszahlung ist der tatsächliche Geldabfluss.
- Beides kann in verschiedenen Perioden liegen.
- *Beispiel:* Eine Maschine wird heute bezahlt (Auszahlung), aber über Jahre abgeschrieben (Aufwand).

*Merksatz:* Aufwand verbraucht Wert, Auszahlung bewegt Geld.

#align(center, image("abbildungen/erfolg-zahlung.svg", width: 75%))
]

#aufgabe(titel: "Auszahlung, Aufwand, Einzahlung oder Ertrag?", art: "verstehen", quelle: "1.4", herkunft: "eigen")[
#if not web [*Aufgabe 30* #linebreak()]
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

#aufgabe(titel: "Auszahlung ohne Aufwand, Einzahlung ohne Ertrag", art: "verstehen", quelle: "1.4", herkunft: "eigen", tipp: [Frag bei jedem Vorgang: Fließt Geld herein? Steigt der Erfolg in dieser Periode?])[
#if not web [*Aufgabe 31* #linebreak()]
Nenne Beispiele für Auszahlungen ohne Aufwand und für Einzahlungen ohne entsprechenden Ertrag. Begründe jeweils, warum der Erfolg nicht berührt wird.
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- *Auszahlung ohne Aufwand:* Kredittilgung, Gewinnausschüttung, Kauf eines Grundstücks.
- *Einzahlung ohne Ertrag:* Kreditaufnahme, Kapitaleinlage, Bezahlung einer alten Forderung aus der Vorperiode.

#align(center, image("abbildungen/erfolg-zahlung.svg", width: 75%))
][
*Antwort:* Kontrollfrage: „Welche Vorgänge sind Einzahlungen ohne entsprechenden Ertrag?“ Zutreffend sind:
- Aufnahme eines Bankkredits: Geld kommt herein, aber es entsteht eine gleich hohe Schuld. Kein Ertrag.
- Kapitaleinlage eines Gesellschafters: Die Einlage erhöht das Eigenkapital direkt und läuft nicht über die GuV.
- Kundenanzahlung vor der Lieferung: Die Einzahlung kommt jetzt, der Ertrag erst mit der Lieferung später. In der Periode der Anzahlung gibt es also keinen Ertrag.
][
*Typische Verwechslungen:*
- „Barverkauf von Waren“: Beim Barverkauf fallen Einzahlung und Ertrag zusammen.
- „Verkauf auf Ziel“: Hier entsteht ein Ertrag, aber noch keine Einzahlung. Es ist genau umgekehrt.
]

#aufgabe(titel: "Kredittilgung: Aufwand oder Auszahlung?", art: "verstehen", quelle: "1.4", herkunft: "eigen")[
#if not web [*Aufgabe 32* #linebreak()]
Ein Unternehmen tilgt einen Kredit über 10.000 €. Ist das Aufwand, Auszahlung, beides oder keins von beidem? Begründe.
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Antwort:* Auszahlung ohne entsprechenden Aufwand. Das Geld fließt ab, aber das Vermögen sinkt genauso wie die Schulden. Ein Werteverzehr entsteht nicht.
][
*Typische Verwechslungen:*
- „Aufwand und Auszahlung“: Nur der Zins wäre Aufwand. Die Tilgung reduziert lediglich die Schulden.
- „Aufwand jetzt, Auszahlung später“: Das wäre etwa die Zuführung zu einer Rückstellung. Die Tilgung ist sofort zahlungswirksam.
- „Weder Aufwand noch Auszahlung“: Es fließt tatsächlich Geld vom Konto ab, also ist es eine Auszahlung.
]

#aufgabe(titel: "Abschreibungen im indirekten Cashflow", art: "verstehen", quelle: "1.5", herkunft: "eigen")[
#if not web [*Aufgabe 33* #linebreak()]
#text("Warum werden bei der indirekten Cashflow-Methode die Abschreibungen zum Jahresüberschuss addiert?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A16. Verfahren: #stelle(<a-1-5>).]
][
#text("Abschreibungen haben den Jahresüberschuss gemindert, aber in dieser Periode kein Geld gekostet. Um vom Gewinn zur Zahlungsgröße zu kommen, werden sie wieder addiert.")
][
*Ergänzung aus der Karteikarte „Wie berechnet man den Cashflow indirekt, und warum addiert man Abschreibungen?“:*
- *Einfaches Modell:* Jahresüberschuss + auszahlungslose Aufwendungen − einzahlungslose Erträge.
- Beispiel: Abschreibungen zum Gewinn zurückaddieren.
- Sie mindern den Gewinn, verursachen in dieser Periode aber keinen Geldabfluss.
- Das Addieren korrigiert diese Differenz; die Abschreibung selbst erzeugt kein Geld.
- Vollständiger operativer Cashflow: zusätzlich Bestände und Zahlungsabgrenzungen berücksichtigen.

*Merksatz:* Abschreibung zurückaddieren korrigiert den Gewinn, erzeugt aber kein Geld.
][
*Antwort:* Kontrollfrage: „Warum addiert man bei der indirekten Cashflow-Rechnung die Abschreibungen zum Jahresüberschuss?“ Weil sie den Gewinn gemindert haben, ohne in dieser Periode Geld abfließen zu lassen. Das Addieren macht nur den Unterschied zwischen Erfolg und Zahlung rückgängig.
][
*Typische Verwechslungen:*
- „Weil Abschreibungen eine Einzahlung erzeugen.“: Eine Abschreibung erzeugt selbst kein Geld. Das ist ein häufiger Denkfehler.
- „Weil Abschreibungen zum Finanzierungs-Cashflow gehören.“: Abschreibungen sind eine Korrektur im operativen Bereich, kein Finanzierungsvorgang.
- „Weil man damit die Ersatzinvestition schon bezahlt hat.“: Die Abschreibung allein finanziert keinen neuen Ofen. Dafür müssen die Umsätze tatsächlich bezahlt sein und die Mittel im Unternehmen bleiben.
]

#aufgabe(titel: "Was der Cashflow verrät", art: "verstehen", quelle: "1.5", herkunft: "eigen")[
#if not web [*Aufgabe 34* #linebreak()]
#text("Über welche vier Fähigkeiten eines Unternehmens informiert der Cashflow?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A17. Verfahren: #stelle(<a-1-5>).]
][
#text("Zahlungsüberschüsse erwirtschaften, Schulden tilgen (Kreditwürdigkeit), Gewinne ausschütten, Investitionen tätigen.")
]

#aufgabe(titel: "Pizzeria: Gewinn, Abschreibung und Kasse", art: "verstehen", quelle: "1.5", herkunft: "eigen", tipp: [Cashflow indirekt = Jahresüberschuss + auszahlungsloser Aufwand. Achte auf die Periode.])[
#if not web [*Aufgabe 35* #linebreak()]
Marios Pizzeria macht 2.000 € Gewinn im Monat; der Backofen wird mit 6.000 € im Jahr abgeschrieben. Wie hoch ist der Cashflow im Monat (vereinfachtes Modell), und was zeigt das Beispiel über Gewinn, Abschreibung und Cashflow?
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- *Gewinn:* 2.000 € je Monat.
- *Abschreibung des Backofens:* 500 €; mindert den Gewinn, ohne aktuellen Geldabfluss.
- *Cashflow im Beispiel:* 2.500 €.
- Entnimmt Mario nur 2.000 €, bleiben monatlich 500 € für einen späteren Ersatzofen.
- Voraussetzung: Umsätze sind bezahlt und Preise bleiben gleich.
][
*Antwort:* Kontrollfrage: „Marios Pizzeria macht 2.000 € Gewinn im Monat, der Backofen wird mit 6.000 € im Jahr abgeschrieben. Wie hoch ist der Cashflow im Monat (vereinfachtes Modell)?“ 2.500 €. $6000 \/ 12 = 500$ € Abschreibung pro Monat. $2000 + 500 = 2500$ €, weil die Abschreibung zahlungslos ist.
][
*Typische Verwechslungen:*
- „1.500 €“: Die Abschreibung wurde abgezogen statt addiert. Sie hat den Gewinn schon gemindert, ohne dass Geld abgeflossen ist.
- „2.000 €“: Gewinn und Cashflow sind nicht dasselbe. Die Abschreibung fehlt.
- „8.000 €“: Hier wurde die Jahresabschreibung zum Monatsgewinn addiert. Beide Größen müssen dieselbe Periode haben.
]

#aufgabe(titel: "XYZ GmbH 2009: Cashflow indirekt", art: "verstehen", quelle: "1.5", herkunft: "eigen")[
#if not web [*Aufgabe 36* #linebreak()]
Die XYZ GmbH hat 2009 einen Jahresüberschuss von 380, Abschreibungen von 500 und eine Zuführung zu Pensionsrückstellungen von 300 (Mio. €). Wie hoch ist der Cashflow nach der indirekten Methode? Begründe die Vorzeichen.
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Antwort:* 1.180 Mio. €. $380 + 500 + 300 = 1180$. Das passt zur direkten Rechnung $6400 - 2800 - 1900 - 520 = 1180$.
][
*Typische Verwechslungen:*
- „380 Mio. €“: Das ist nur der Jahresüberschuss. Die zahlungslosen Aufwendungen fehlen.
- „880 Mio. €“: Die Abschreibungen sind addiert, aber die Zuführung zur Rückstellung fehlt. Auch sie ist Aufwand ohne Auszahlung in dieser Periode.
- „−420 Mio. €“: Hier wurden die zahlungslosen Aufwendungen abgezogen statt addiert.
]

#aufgabe(titel: "Was ist der Cashflow?", art: "verstehen", quelle: "1.5", herkunft: "eigen")[
#if not web [*Aufgabe 37* #linebreak()]
Was ist der Cashflow?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Der Zahlungsüberschuss eines festgelegten Tätigkeitsbereichs und einer Periode: zugehörige Einzahlungen minus Auszahlungen.
- Der operative Cashflow hilft einzuschätzen, was das Geschäft für Investitionen, Tilgung und Ausschüttung erwirtschaftet.
- Kreditaufnahmen sind dagegen Finanzierungs-Cashflow und keine selbst erwirtschafteten Mittel.
]

#aufgabe(titel: "Klausur: Cashflow der Rhein GmbH", art: "rechnen", quelle: "1.5", herkunft: "original", vorlage: "Altklausur 2017, Aufg. 4", minuten: 5)[
#if not web [*Aufgabe 38* #linebreak()]
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

#aufgabe(titel: "Jahresüberschuss und Cashflow eines Kleinunternehmens", art: "rechnen", quelle: "1.5", herkunft: "variante", vorlage: "Altklausur 2017, Aufg. 4")[
#if not web [*Aufgabe 39* #linebreak()]
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

#aufgabe(titel: "Cashflow indirekt mit Rückstellungen", art: "rechnen", quelle: "1.5", herkunft: "variante", vorlage: "Altklausur 2017, Aufg. 4")[
#if not web [*Aufgabe 40* #linebreak()]
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

#aufgabe(titel: "Cashflow direkt", art: "rechnen", quelle: "1.5", herkunft: "variante", vorlage: "Altklausur 2017, Aufg. 4")[
#if not web [*Aufgabe 41* #linebreak()]
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

#aufgabe(titel: "Vorlesung: Marios Pizzeria – Gewinn oder Kasse?", art: "rechnen", quelle: "1.5", herkunft: "original", vorlage: "Vorlesung PDF-S. 11, Folie 21, Beispiel", minuten: 6, ergebnis: [Beide haben recht: Gewinn 2.000 €, Cashflow 2.500 € je Monat; 500 € bleiben monatlich für einen neuen Ofen.])[
#if not web [*Aufgabe 42* #linebreak()]
*Gegeben und Annahmen*

Marios Pizzeria läuft gut. Sein Steuerberater hat ihm ausgerechnet, dass er monatlich 2.000 € verdient. „Das stimmt gar nicht“, meint Mario, „am Monatsende habe ich immer viel mehr in der Kasse: 2.500 €.“ Der Backofen wird jährlich mit 6.000 € abgeschrieben. Alle Umsätze und übrigen Aufwendungen sind im selben Monat bezahlt.

*Gesucht*

#enum(numbering: "a)",
[Wer hat recht? Erkläre, welche Größe der Steuerberater und welche Mario meint.],
[Weise den Unterschied von 500 € rechnerisch nach.],
[Mario entnimmt monatlich den Gewinn. Was passiert mit dem Rest, und wofür kann er ihn verwenden?],
)
#src[V, PDF-S. 11, Folie 21 (Quelle der Folie: Rollwage 2006); Lernskript 1.5.]
][
*Größen unterscheiden:* Der Steuerberater ermittelt den (handels- oder steuerrechtlichen) *Gewinn* = Erträge − Aufwendungen. Mario sieht den *Cashflow*, also den Einzahlungsüberschuss, der am Periodenende an liquiden Mitteln übrig bleibt. Beide haben recht, sie meinen verschiedene Größen.
][
*Unterschied nachrechnen:* Die Abschreibung ist Aufwand ohne Auszahlung: $6000/12=500$ € je Monat. Cashflow indirekt $=2000+500=2500$ €.
][
*Verwendung:* Entnimmt Mario monatlich 2.000 €, bleiben jeden Monat 500 € zusätzlich in der Kasse. Damit kann er am Ende der Nutzungsdauer einen neuen Backofen kaufen: *Finanzierung aus Abschreibungsgegenwerten* (Innenfinanzierung).
][
*Prüfen:* Die Abschreibung selbst bringt kein Geld. Das Geld kommt über die bezahlten Umsätze herein; die Abschreibung sorgt nur dafür, dass dieser Teil nicht als Gewinn ausgewiesen und entnommen wird.
]

#aufgabe(titel: "Pizzeria: Lieferwagen und Abschreibung", art: "rechnen", quelle: "1.5", herkunft: "variante", vorlage: "Vorlesung PDF-S. 11, Folie 21, Beispiel")[
#if not web [*Aufgabe 43* #linebreak()]
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

#aufgabe(titel: "Bäckerei: Ofen und Abschreibung", art: "rechnen", quelle: "1.5", herkunft: "variante", vorlage: "Vorlesung PDF-S. 11, Folie 21, Beispiel")[
#if not web [*Aufgabe 44* #linebreak()]
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

#aufgabe(titel: "Vorlesung: Cashflow der XYZ GmbH 2009", art: "rechnen", quelle: "1.5", herkunft: "original", vorlage: "Vorlesung PDF-S. 11, Folie 22, Beispiel", minuten: 6, ergebnis: [Cashflow 2009 = 1.180 Mio. € (direkt und indirekt)])[
#if not web [*Aufgabe 45* #linebreak()]
*Gegeben und Annahmen*

GuV der XYZ GmbH 2009 in Mio. €: Aufwand: Materialaufwand 2.800, Personalaufwand 1.900, Pensionsrückstellungen (Zuführung) 300, Abschreibungen 500, Zinsaufwand 520, Jahresüberschuss 380; Summe 6.400. Ertrag: Umsatzerlöse 6.000, Zinsertrag 400; Summe 6.400. Alle Erträge und alle übrigen Aufwendungen sind im Jahr voll zahlungswirksam.

*Gesucht*

#enum(numbering: "a)",
[Ermittle den Cashflow 2009 nach der direkten Methode.],
[Ermittle den Cashflow 2009 nach der indirekten Methode.],
)
#src[V, PDF-S. 11, Folie 22; Lernskript 1.5.]
][
*Zahlungswirksamkeit klären:* Abschreibungen (500) und Zuführung zu Pensionsrückstellungen (300) sind Aufwand ohne Auszahlung in diesem Jahr. Alles andere ist Zahlung.
][
*Direkt:* Einzahlungen (Umsätze und Zinserträge) $6000+400=6400$; minus Auszahlungen $2800+1900+520$: $6400-2800-1900-520=1180$ Mio. €.
][
*Indirekt:* Jahresüberschuss plus auszahlungsloser Aufwand: $380+500+300=1180$ Mio. €.
][
*Prüfen:* Beide Wege liefern 1.180 Mio. €. Die GuV ist stimmig: $2800+1900+300+500+520+380=6400$.
]

#aufgabe(titel: "Cashflow der XYZ GmbH direkt und indirekt", art: "rechnen", quelle: "1.5", herkunft: "variante", vorlage: "Vorlesung PDF-S. 11, Folie 22, Beispiel")[
#if not web [*Aufgabe 46* #linebreak()]
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

#aufgabe(titel: "Drei Bereiche der Kapitalflussrechnung", art: "verstehen", quelle: "1.6", herkunft: "eigen")[
#if not web [*Aufgabe 47* #linebreak()]
#text("Nenne die drei Bereiche der Kapitalflussrechnung. Ist ein negativer Cashflow aus Investitionstätigkeit ein schlechtes Zeichen?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A18. Verfahren: #stelle(<a-1-6>).]
][
#text("Operative, Investitions- und Finanzierungstätigkeit. Ein negativer Investitions-Cashflow bezeichnet eine Netto-Mittelverwendung, beispielsweise für neue Anlagen. Ob sie sinnvoll und finanzierbar ist, muss separat geprüft werden; der negative Saldo allein ist weder gut noch schlecht.")
][
*Ergänzung aus der Karteikarte „Welche drei Bereiche hat die Kapitalflussrechnung?“:*
- *Operativ:* Zahlungen aus dem Kerngeschäft.
- *Investition:* Kauf und Verkauf von Anlagen und Finanzanlagen.
- *Finanzierung:* Zahlungen mit Eigentümern und Gläubigern (Kredite, Tilgung, Dividenden).
- Zusammen erklären sie die Veränderung des Zahlungsmittelbestands.

#align(center, image("abbildungen/cashflow-bereiche.svg", width: 75%))
][
*Ergänzung aus der Karteikarte „Ist ein negativer Investitions-Cashflow ein Warnsignal?“:*
- Nicht automatisch.
- Er zeigt nur, dass das Unternehmen Geld in Anlagen steckt.
- Bei hohem operativem Cashflow kann das ganz gesund sein.
- Ob die Investition gut ist, sagt er nicht.

#align(center, image("abbildungen/cashflow-bereiche.svg", width: 75%))
]

#aufgabe(titel: "Warnsignal oder nicht?", art: "verstehen", quelle: "1.6", herkunft: "eigen")[
#if not web [*Aufgabe 48* #linebreak()]
#text("Beurteile jeweils, ob das ein Warnsignal ist: a) negativer Cashflow aus Investitionstätigkeit bei hohem operativem Cashflow, b) Gewinn steigt, Kassenbestand sinkt, c) Anlagendeckung II von 80 %.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü20. Verfahren: #stelle(<a-1-6>).]
][
a) Hoher operativer CF und negativer Investitions-CF können selbst finanzierte Investitionen anzeigen; ohne Beträge, Fälligkeiten und Investitionsqualität ist kein pauschales Urteil möglich. b) Steigender Gewinn bei sinkender Kasse ist ein Anlass zur Überleitung, etwa wegen Forderungsaufbau oder Investitionen. c) AD II 80 % verfehlt die goldene Bilanzregel: Ein Teil des Anlagevermögens ist kurzfristig finanziert. *Prüfung:* Kennzahlen sind Warnhinweise und ersetzen nicht den Zahlungsplan.
]

#aufgabe(titel: "Free Cashflow definieren", art: "verstehen", quelle: "1.6", herkunft: "eigen")[
#if not web [*Aufgabe 49* #linebreak()]
Wie ist der Free Cashflow in der Vorlesung definiert, und was sagt er aus?
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Operativer Cashflow minus Investitionsauszahlungen in Anlagen.
- Das ist das Geld, das nach den nötigen Investitionen frei bleibt, z. B. für Tilgung oder Ausschüttung.

*Merksatz:* Free Cashflow: nach Investitionen frei.

#align(center, image("abbildungen/siemens-free-cashflow.svg", width: 75%))
][
*Antwort:* Kontrollfrage: „Wie ist der Free Cashflow in der Vorlesung definiert?“ Operativer Cashflow minus Investitionsauszahlungen in Sachanlagen und immaterielle Vermögenswerte. Siemens 2018: $8415 - 2602 = 5813$ Mio. €, die Folientabelle nennt 5814. Ohne ungerundete Daten ist die Ursache der Differenz von 1 Mio. € nicht belegt.
][
*Typische Verwechslungen:*
- „Operativer Cashflow plus Investitions-Cashflow plus Finanzierungs-Cashflow“: Die Summe aller drei Bereiche erklärt die Änderung des Zahlungsmittelbestands, nicht den Free Cashflow.
- „Jahresüberschuss minus Ausschüttungen“: Das wäre der einbehaltene Gewinn, also offene Selbstfinanzierung. Mit Zahlungen hat das nur indirekt zu tun.
- „Operativer Cashflow minus gesamter Investitions-Cashflow inklusive Verkäufen“: Die Folie zieht nur die Zugänge ab, nicht den ganzen Investitions-Cashflow, in dem auch Verkaufserlöse stecken.
]

#aufgabe(titel: "Dividende in der Kapitalflussrechnung", art: "verstehen", quelle: "1.6", herkunft: "eigen")[
#if not web [*Aufgabe 50* #linebreak()]
Wohin gehört eine Dividendenzahlung in der Kapitalflussrechnung nach dem Modell der Vorlesung? Begründe, warum sie dort und nicht in einem anderen Bereich steht.
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Antwort:* Finanzierungs-Cashflow. Zins- und Dividendenzahlungen, Tilgungen und Kapitalaufnahmen gehören zum Finanzierungsbereich.
][
*Typische Verwechslungen:*
- „Operativer Cashflow“: Die Dividende hat mit dem Kerngeschäft nichts zu tun, sie betrifft die Beziehung zu den Eigentümern.
- „Investitions-Cashflow“: Der Investitionsbereich betrifft Kauf und Verkauf längerfristigen Vermögens.
- „Sie erscheint gar nicht, weil sie kein Aufwand ist.“: Die Kapitalflussrechnung erfasst Zahlungen, nicht Aufwand. Die Dividende ist eine Auszahlung.
]

#aufgabe(titel: "Kapitalflussrechnung mit Kassenbestand", art: "rechnen", quelle: "1.6", herkunft: "eigen")[
#if not web [*Aufgabe 51* #linebreak()]
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

#aufgabe(titel: "Free Cashflow und Dividende", art: "rechnen", quelle: "1.6", herkunft: "eigen")[
#if not web [*Aufgabe 52* #linebreak()]
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

#aufgabe(titel: "Kapitalflussrechnung mit Forderungen und Verbindlichkeiten", art: "rechnen", quelle: "1.6", herkunft: "eigen")[
#if not web [*Aufgabe 53* #linebreak()]
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

#aufgabe(titel: "Aufgaben und Prinzipien der Finanzplanung", art: "verstehen", quelle: "1.7", herkunft: "eigen")[
#if not web [*Aufgabe 54* #linebreak()]
#text("Nenne die Aufgaben der Finanzplanung und die drei Prinzipien eines Finanzplans.")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B1. Verfahren: #stelle(<a-1-7>).]
][
#text("Aufgaben: Bedarf an Zahlungsmitteln ermitteln, Zahlungsfähigkeit sichern, optimale Finanzierungsart wählen, Defizite und Überschüsse sichtbar machen, EK-Bedarf ermitteln. Prinzipien: Vollständigkeit, Bruttoprinzip, Genauigkeit.")
][
*Ergänzung aus der Karteikarte „Welche drei Grundsätze gelten für einen Finanzplan?“:*
- *Vollständigkeit:* alle Vorgänge mit Zahlungswirkung erfassen.
- *Bruttoprinzip:* Ein- und Auszahlungen getrennt zeigen, nicht vorher saldieren.
- *Realismus / Termingenauigkeit:* realistische Beträge und Zeitpunkte.

#align(center, image("abbildungen/plan-und-bilanz.svg", width: 75%))
]

#aufgabe(titel: "Über- und Unterliquidität", art: "verstehen", quelle: "1.7", herkunft: "eigen")[
#if not web [*Aufgabe 55* #linebreak()]
#text("Was sind die Folgen von Über- bzw. Unterliquidität?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B2. Verfahren: #stelle(<a-1-7>).]
][
#text("Überliquidität: zu viel ungenutztes Geld, Zinsverluste, geringere Rentabilität. Unterliquidität: Zahlungsverpflichtungen können nicht erfüllt werden, Insolvenzrisiko.")
]

#aufgabe(titel: "Finanzplanung abstimmen", art: "verstehen", quelle: "1.7", herkunft: "eigen")[
#if not web [*Aufgabe 56* #linebreak()]
#text("Warum muss die Finanzplanung mit Produktions-, Absatz- und Investitionsplanung abgestimmt werden?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B3. Verfahren: #stelle(<a-1-7>).]
][
#text("Weil Produktion, Absatz und Investitionen die Zahlungsströme bestimmen. Erst der Finanzplan zeigt, ob das Gesamtprogramm finanzierbar ist; wenn nicht, werden die Teilpläne angepasst.")
]

#aufgabe(titel: "Kennzahlen und Finanzplan", art: "verstehen", quelle: "1.7", herkunft: "eigen")[
#if not web [*Aufgabe 57* #linebreak()]
#text("Worin unterscheiden sich finanzwirtschaftliche Kennzahlen und Finanzplan?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B12. Verfahren: #stelle(<a-1-7>).]
][
#text("Bilanzkennzahlen zeigen Bestandsrelationen eines Stichtags; Rentabilitätskennzahlen verbinden einen Periodenerfolg mit einer passenden Bezugsgröße. Der Finanzplan nimmt künftige Ein- und Auszahlungen nach Termin vorweg. Kennzahlen eignen sich für Zielvorgaben sowie Soll-Ist-, Zeit- und Branchenvergleiche, ersetzen aber keinen Fälligkeitsplan.")
]

#aufgabe(titel: "Gewinn ersetzt keinen Finanzplan", art: "verstehen", quelle: "1.7", herkunft: "eigen")[
#if not web [*Aufgabe 58* #linebreak()]
#text("Eine Gründerin sagt: „Mein Plan zeigt ab Jahr 1 Gewinn, einen Finanzplan brauche ich nicht.“ Nimm begründet Stellung.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü18. Verfahren: #stelle(<a-1-7>).]
][
Gewinn ist keine Zahlungsplanung. Die Gründerin muss Anlauf- und Investitionszahlungen, Kundenzahlungsziele sowie Zins/Tilgung und Reserven erfassen. Im Folienbeispiel 39–40 stehen spätere Gewinne neben negativen Planbeständen. *Prüfung:* Der Finanzplan zeigt Zeitpunkt und Höhe der Lücke; erst eine zugesagte Finanzierung macht das Programm zahlungsfähig.
]

#aufgabe(titel: "Freie Kreditlinie im Februar", art: "verstehen", quelle: "1.7", herkunft: "eigen", tipp: [Erst $K_t = K_(t-1) + E_t - A_t$, dann von der Linie den genutzten Teil abziehen.])[
#if not web [*Aufgabe 59* #linebreak()]
Ein Finanzplan beginnt den Februar mit 20.000 €, Einzahlungen sind 45.000 €, Auszahlungen 70.000 €. Der Kontokorrentrahmen beträgt 10.000 €. Wie viel freie Linie bleibt am Monatsende?
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Antwort:* 5.000 €. $K_t = 20000 + 45000 - 70000 = -5000$ €. Freie Linie = vereinbarte Linie minus genutzter Kredit $= 10000 - 5000 = 5000$ €.
][
*Typische Verwechslungen:*
- „10.000 €“: Die Linie ist ja schon teilweise genutzt, weil der Endbestand negativ ist.
- „15.000 €“: Der negative Stand wurde zur Linie addiert statt abgezogen.
- „0 €“: Die Linie ist nur zur Hälfte ausgeschöpft. Doppelt abziehen darf man den negativen Stand nicht.
]

#aufgabe(titel: "Bruttoprinzip in der Finanzplanung", art: "verstehen", quelle: "1.7", herkunft: "eigen")[
#if not web [*Aufgabe 60* #linebreak()]
Was bedeutet das Bruttoprinzip in der Finanzplanung, und warum ist es wichtig?
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Antwort:* Ein- und Auszahlungen werden getrennt ausgewiesen und nicht vorab saldiert. Nur so sieht man, wie groß die einzelnen Ströme sind und wo ein Risiko liegt.
][
*Typische Verwechslungen:*
- „Alle Beträge werden inklusive Umsatzsteuer geplant.“: Das ist die naheliegende Verwechslung, aber hier ist etwas anderes gemeint.
- „Alle erwarteten Zahlungsvorgänge müssen erfasst werden.“: Das ist das Prinzip der Vollständigkeit.
- „Beträge und Zeitpunkte sollen realistisch geschätzt werden.“: Das ist das Prinzip der Genauigkeit.
]

#aufgabe(titel: "Was leistet ein Finanzplan?", art: "verstehen", quelle: "1.7", herkunft: "eigen")[
#if not web [*Aufgabe 61* #linebreak()]
Was leistet ein Finanzplan?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Er plant künftige Ein- und Auszahlungen Periode für Periode und zeigt, wann Geld fehlt oder übrig ist.
- So sieht man einen Engpass, bevor die Zahlung fällig wird, und kann rechtzeitig Finanzierung organisieren.
- *Fortschreibung:*
$ "Endbestand" = "Anfangsbestand" + "Einzahlungen" - "Auszahlungen" $

*Merksatz:* Finanzplanung fragt immer auch: Wann?

#align(center, image("abbildungen/plan-und-bilanz.svg", width: 75%))
]

#aufgabe(titel: "Negativer Endbestand im Finanzplan", art: "verstehen", quelle: "1.7", herkunft: "eigen")[
#if not web [*Aufgabe 62* #linebreak()]
Was bedeutet ein negativer Endbestand im Finanzplan?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Einen Finanzierungsbedarf, den man decken muss.
- Es ist keine tatsächlich negative Bargeldmenge.
- Ein späterer Überschuss hilft nicht, wenn das Geld schon vorher fehlt.

*Merksatz:* Ein späteres Plus heilt kein früheres Zahlungsloch.

#align(center, image("abbildungen/plan-und-bilanz.svg", width: 75%))
][
*Bild:* Ein voller Kühlschrank morgen hilft nicht, wenn heute gekocht werden muss.
]

#aufgabe(titel: "Verfügbare Liquidität mit Kontokorrent", art: "verstehen", quelle: "1.7", herkunft: "eigen")[
#if not web [*Aufgabe 63* #linebreak()]
Wie berechnet man die verfügbare Liquidität mit einem Kontokorrentkredit?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Positiver Kontostand plus freie Kreditlinie.
- Ist das Konto schon im Minus, ist die freie Linie $= "vereinbarte Linie" - "genutzter Betrag"$.
- Nicht doppelt abziehen.

#align(center, image("abbildungen/liquiditaetsverlauf.svg", width: 75%))
]

#aufgabe(titel: "Vorlesung: Monatsfinanzplan mit zwei Abwandlungen", art: "rechnen", quelle: "1.7", herkunft: "original", vorlage: "Vorlesung PDF-S. 34, Folie 67, Übungsaufgabe 2", ergebnis: [Grundfall 3.050 / 1.900 / 2.450 €; Abwandlung 50 / −1.100 / −550 €; Linie im Februar um 100 € zu klein.])[
#if not web [*Aufgabe 64* #linebreak()]
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

#aufgabe(titel: "Liquiditätsplan über drei Quartale", art: "rechnen", quelle: "1.7", herkunft: "variante", vorlage: "Vorlesung PDF-S. 34, Folie 67, Übungsaufgabe 2")[
#if not web [*Aufgabe 65* #linebreak()]
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

#aufgabe(titel: "Endbestand und freie Kreditlinie", art: "rechnen", quelle: "1.7", herkunft: "variante", vorlage: "Vorlesung PDF-S. 34, Folie 67, Übungsaufgabe 2")[
#if not web [*Aufgabe 66* #linebreak()]
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

#aufgabe(titel: "Liquiditätsplan einer Gründung", art: "rechnen", quelle: "1.7", herkunft: "variante", vorlage: "Vorlesung PDF-S. 34, Folie 67, Übungsaufgabe 2")[
#if not web [*Aufgabe 67* #linebreak()]
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

#aufgabe(titel: "Vorlesung: Gewinn 1.000 €, Kasse 100 €", art: "rechnen", quelle: "1.7", herkunft: "original", vorlage: "Vorlesung PDF-S. 16, Folie 31, Beispiel (Notiz)", minuten: 6, ergebnis: [Endbestand 100 €])[
#if not web [*Aufgabe 68* #linebreak()]
*Gegeben und Annahmen*

Beispiel aus der Vorlesung zum Finanzplan: Ein Unternehmen startet mit 0 € auf dem Konto. In der Periode erzielt es einen Gewinn von 1.000 €, der vereinfacht voll zahlungswirksam ist. Es schüttet 500 € aus, kauft ein Grundstück für 800 € und nimmt einen Kredit über 400 € auf. Keine weiteren Vorgänge.

*Gesucht*

#enum(numbering: "a)",
[Wie hoch ist der Kontoendbestand?],
[Welche der Vorgänge sind Auszahlungen ohne Aufwand bzw. Einzahlungen ohne Ertrag?],
[Erkläre, warum man aus dem Gewinn allein nicht auf den Kassenbestand schließen kann.],
)
#src[V, PDF-S. 16 (Folie 31), handschriftliches Beispiel der Vorlesung; Lernskript 1.7.]
][
*Zahlungen fortschreiben:* Ein Finanzplan zählt nur Geldbewegungen: $0+1000-500-800+400=100$ €. Endbestand *100 €*.
][
*Erfolg und Zahlung trennen:* Ausschüttung (500 €): Geld geht vom Konto, ist aber kein Aufwand, sondern Gewinnverwendung. Grundstückskauf (800 €): Auszahlung, taucht in der GuV nicht auf, weil nur Geld in Anlagevermögen getauscht wird (Grundstücke werden nicht planmäßig abgeschrieben). Kredit (400 €): Einzahlung ohne Ertrag, denn er muss zurückgezahlt werden.
][
*Prüfen:* Gewinn 1.000 €, aber nur 100 € auf dem Konto. Merksatz der Vorlesung: Nicht jede Auszahlung ist Aufwand, nicht jede Einzahlung ist Ertrag. Darum braucht man neben der GuV einen Finanzplan.
]

#aufgabe(titel: "Gewinn gegen Kasse", art: "rechnen", quelle: "1.7", herkunft: "variante", vorlage: "Vorlesung PDF-S. 16, Folie 31, Beispiel (Notiz)")[
#if not web [*Aufgabe 69* #linebreak()]
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

#aufgabe(titel: "Drei Insolvenzgründe", art: "verstehen", quelle: "1.8", herkunft: "eigen")[
#if not web [*Aufgabe 70* #linebreak()]
#text("Nenne die drei Insolvenzgründe mit Paragraf. Welcher gilt nur für juristische Personen?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B4. Verfahren: #stelle(<a-1-8>).]
][
#text("Zahlungsunfähigkeit (§ 17), drohende Zahlungsunfähigkeit (§ 18) und Überschuldung (§ 19 InsO). § 19 gilt für juristische Personen sowie die dort in Abs. 3 erfassten Personengesellschaften. Ein sinkender Umsatz allein ist kein eigener Insolvenzgrund.")
]

#aufgabe(titel: "Zahlungsunfähigkeit nach dem BGH", art: "verstehen", quelle: "1.8", herkunft: "eigen")[
#if not web [*Aufgabe 71* #linebreak()]
#text("Wann ist ein Unternehmen nach der Rechtsprechung des BGH zahlungsunfähig?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B5. Verfahren: #stelle(<a-1-8>).]
][
#text("Die Folie rechnet mit der 90-%-/Dreiwochen-Orientierung. Präziser: Eine nicht beseitigte Lücke von 10 % oder mehr begründet nach dem BGH regelmäßig Zahlungsunfähigkeit; Ausnahmen und die weitere Entwicklung sind mitzubeurteilen. Genau 90 % sind keine rechtliche Freigrenze.")
]

#aufgabe(titel: "Zahlungsunfähigkeit und Überschuldung", art: "verstehen", quelle: "1.8", herkunft: "eigen")[
#if not web [*Aufgabe 72* #linebreak()]
#text("Erkläre den Unterschied zwischen Zahlungsunfähigkeit und Überschuldung mit eigenen Worten.")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B6. Verfahren: #stelle(<a-1-8>).]
][
#text("Zahlungsunfähigkeit: Es fehlt jetzt Geld, um fällige Rechnungen zu bezahlen (Liquiditätsproblem). Überschuldung: Das Vermögen reicht nicht, um alle Schulden zu decken, das EK ist negativ (Vermögensproblem). Ein überschuldetes Unternehmen kann noch zahlen, ein zahlungsunfähiges kann noch Vermögen haben.")

*Präzisierung:* Ein bilanzieller Fehlbetrag und die rechtliche Überschuldung sind getrennt zu prüfen. Darlehen verschwinden nicht pauschal aus der Bilanz; beim Rangrücktritt gelten die Voraussetzungen von § 19.
]

#aufgabe(titel: "Rechnerisch überschuldet, aber kein Insolvenzgrund", art: "verstehen", quelle: "1.8", herkunft: "eigen")[
#if not web [*Aufgabe 73* #linebreak()]
#text("Wann liegt trotz rechnerischer Überschuldung kein Insolvenzgrund vor?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B7. Verfahren: #stelle(<a-1-8>).]
][
#text("Ein negatives handelsbilanzielles EK allein beweist keine rechtliche Überschuldung. § 19 berücksichtigt insbesondere die überwiegend wahrscheinliche Fortführung in den nächsten zwölf Monaten sowie die rechtlich passende Vermögens- und Verbindlichkeitsbewertung.")
]

#aufgabe(titel: "Warum ein Kredit gegen Überschuldung nicht hilft", art: "verstehen", quelle: "1.8", herkunft: "eigen")[
#if not web [*Aufgabe 74* #linebreak()]
#text("Warum hilft bei Überschuldung kein neuer Bankkredit? Was hilft stattdessen?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B8. Verfahren: #stelle(<a-1-8>).]
][
#text("Ein Kredit erhöht Vermögen (Kasse) und Schulden um denselben Betrag, die Lücke zwischen Vermögen und Schulden bleibt. Es braucht Eigenkapital (Kapitaleinlage, neuer EK-Geber), einen Rangrücktritt oder einen Lieferantenvergleich.")

*Präzisierung:* Ein bilanzieller Fehlbetrag und die rechtliche Überschuldung sind getrennt zu prüfen. Darlehen verschwinden nicht pauschal aus der Bilanz; beim Rangrücktritt gelten die Voraussetzungen von § 19.
][
*Ergänzung aus der Karteikarte „Warum beseitigt ein zusätzlicher Kredit keine Überschuldung?“:*
- Der Kredit erhöht das Vermögen (Kasse) und die Schulden um genau denselben Betrag.
- Die Lücke zwischen Vermögen und Schulden bleibt gleich.
- Er kann aber einen Zahlungsengpass überbrücken.

*Merksatz:* Mehr Kredit erhöht Kasse und Schulden zugleich.
][
*Bild:* Auf beiden Seiten einer Waage kommt dieselbe Menge hinzu: Die Differenz bleibt.
][
*Antwort:* Kontrollfrage: „Ein Unternehmen hat Vermögen von 70 und Schulden von 80. Es nimmt einen zusätzlichen Kredit über 20 auf. Was ändert das an der Unterdeckung?“ Nichts, der Fehlbetrag bleibt bei 10. $90 - 100 = -10$. Ein Kredit hilft gegen einen Zahlungsengpass, nicht gegen eine rechnerische Unterdeckung.
][
*Typische Verwechslungen:*
- „Sie verschwindet, weil jetzt mehr Vermögen da ist.“: Das Vermögen steigt um 20, die Schulden aber auch um 20. Die Differenz bleibt.
- „Sie wird größer, weil die Schulden steigen.“: Die Schulden steigen, aber das Vermögen steigt gleich mit, vor Zinsen bleibt der Fehlbetrag gleich.
- „Sie halbiert sich.“: Dafür gibt es keinen Rechenweg. Gegen Unterdeckung helfen etwa Einlage oder Forderungsverzicht.
]

#aufgabe(titel: "Frist für den Insolvenzantrag", art: "verstehen", quelle: "1.8", herkunft: "eigen")[
#if not web [*Aufgabe 75* #linebreak()]
#text("Wie lange hat die Geschäftsführung Zeit, den Insolvenzantrag zu stellen, und was droht bei Verspätung?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B9. Verfahren: #stelle(<a-1-8>).]
][
#text("Ohne schuldhaftes Zögern; nach § 15a Abs. 1 spätestens drei Wochen nach Eintritt der Zahlungsunfähigkeit bzw. sechs Wochen nach Eintritt der Überschuldung. Die einheitlichen drei Wochen der Folie 34 sind insoweit veraltet. Verspätete Antragstellung kann strafbar sein; drohende Zahlungsunfähigkeit allein löst diese Antragspflicht nicht aus.")
][
*Ergänzung aus der Karteikarte „Welche Fristen gelten für den Insolvenzantrag?“:*
- Ohne schuldhaftes Zögern, spätestens drei Wochen nach Eintritt der Zahlungsunfähigkeit und sechs Wochen nach Eintritt der Überschuldung.
- Drohende Zahlungsunfähigkeit allein löst keine Antragspflicht aus, erlaubt aber einen eigenen Antrag.
]

#aufgabe(titel: "Sechs Maßnahmen gegen ein Liquiditätsdefizit", art: "verstehen", quelle: "1.8", herkunft: "eigen")[
#if not web [*Aufgabe 76* #linebreak()]
#text("Nenne die sechs Gruppen von Maßnahmen gegen ein Liquiditätsdefizit mit je einem Beispiel.")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B10. Verfahren: #stelle(<a-1-8>).]
][
#text("Vermögen außer der Reihe zu Geld machen (Sale-and-lease-back); Eingänge beschleunigen, Ausgänge verzögern (Mahnwesen verschärfen); spezielle Einlagen und Kredite beschaffen (längeres Lieferantenziel); Rentabilität für Liquidität opfern (Sofortzahler bevorzugen); Gesellschafter müssen Farbe bekennen (zusätzliche Einlagen); rigoros Auszahlungen kürzen (Personalabbau).")
]

#aufgabe(titel: "Ausgänge eines Insolvenzverfahrens", art: "verstehen", quelle: "1.8", herkunft: "eigen")[
#if not web [*Aufgabe 77* #linebreak()]
#text("Welche Ausgänge kann ein Insolvenzverfahren nehmen? Was bedeutet „Abweisung mangels Masse“?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B11. Verfahren: #stelle(<a-1-8>).]
][
#text("Abweisung mangels Masse, Liquidation (Gläubiger erhalten eine Quote) oder Sanierung über einen Insolvenzplan; dazu Einstellung des Verfahrens. „Mangels Masse“: Das Vermögen reicht nicht einmal, um die Kosten des Verfahrens zu decken.")
]

#aufgabe(titel: "Insolvenzgrund und Gegenmaßnahme", art: "verstehen", quelle: "1.8", herkunft: "eigen")[
#if not web [*Aufgabe 78* #linebreak()]
#text("Insolvenzgründe (Teil A5): Bestimme Insolvenzgrund und passende Gegenmaßnahme. (i) GmbH: Vermögen 2,0 Mio. €, Schulden 2,3 Mio. €, keine positive Fortführungsprognose. (ii) Unternehmen kann in drei Wochen nur 70 % der fälligen Rechnungen bezahlen. (iii) GmbH erwartet, eine im März fällige Kreditrate nicht bezahlen zu können.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü16. Verfahren: #stelle(<a-1-8>).]
][
(i) Vermögenslücke 0,3 Mio. € und keine positive Fortführung: Hinweis auf Überschuldung nach § 19, bei passender rechtlicher Bewertung. Ansätze: Einlage, Forderungsverzicht, geeigneter Rangrücktritt. (ii) 30 % nicht begleichbare Lücke: regelmäßig Zahlungsunfähigkeit im vereinfachten Dreiwochenfall; zusätzliche Liquidität oder verbindliche Zahlungsvereinbarungen prüfen. (iii) Erwartete nicht erfüllbare Märzrate: drohende Zahlungsunfähigkeit (§ 18); frühzeitig Finanzplan und Gegenmaßnahmen entwickeln. *Prüfung:* Die Antragspflichten der drei Fälle sind nicht identisch.
]

#aufgabe(titel: "Neuer Kredit bei Überschuldung", art: "verstehen", quelle: "1.8", herkunft: "eigen")[
#if not web [*Aufgabe 79* #linebreak()]
#text("Ein Kunde deiner Bank ist bilanziell überschuldet und bittet um einen zusätzlichen Kredit, „um die Lücke zu schließen“. Was antwortest du?")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü21. Verfahren: #stelle(<a-1-8>).]
][
Ein gewöhnlicher Kredit vergrößert Vermögen und Schulden um denselben Betrag. Die rechnerische Unterdeckung verschwindet dadurch nicht. Einlage, Forderungsverzicht oder ein rechtlich geeigneter Nachrang sind andere Ansatzpunkte. *Prüfung:* Handelsbilanzieller Fehlbetrag und rechtliche Überschuldung sind getrennt zu prüfen; eine Antragspflicht darf weder allein aus dem Buch-EK behauptet noch bei tatsächlich vorliegendem Grund übergangen werden.
]

#aufgabe(titel: "Zahlungsengpass oder Überschuldung: passende Maßnahme", art: "verstehen", quelle: "1.8", herkunft: "eigen")[
#if not web [*Aufgabe 80* #linebreak()]
Welche Maßnahmen helfen gegen einen Zahlungsengpass, welche gegen eine rechnerische Unterdeckung (negatives Eigenkapital)? Begründe den Unterschied.
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- *Zahlungsengpass:* frisches Geld, Forderungen verkaufen (Factoring), Zahlungen verschieben, Sale-and-lease-back, Mahnwesen verbessern.
- *Überschuldung:* Kapitaleinlage, Forderungsverzicht von Gläubigern, eventuell ein qualifizierter Rangrücktritt.
][
*Antwort:* Kontrollfrage: „Welche Maßnahme hilft gegen eine rechnerische Unterdeckung (negatives Eigenkapital), nicht nur gegen einen Zahlungsengpass?“ Forderungsverzicht der Gläubiger (Lieferantenvergleich). Die Schulden sinken, ohne dass Vermögen abfließt. Damit schrumpft der Fehlbetrag.
][
*Typische Verwechslungen:*
- „Factoring“: Factoring macht Forderungen schneller zu Geld. Vermögen und Schulden bleiben im Saldo gleich.
- „Stundung einer Lieferantenrechnung“: Das verschiebt nur den Zahlungstermin. Die Schuld bleibt bestehen.
- „Ein zusätzlicher Kontokorrentkredit“: Mehr Kredit erhöht Kasse und Schulden gleichermaßen und ändert die Differenz nicht.
]

#aufgabe(titel: "Insolvenzgründe: Aussagen prüfen", art: "verstehen", quelle: "1.8", herkunft: "eigen")[
#if not web [*Aufgabe 81* #linebreak()]
Prüfe die folgenden vier Aussagen zu den Insolvenzgründen und begründe jeweils, ob sie stimmen: (1) Zahlungsunfähigkeit (§ 17) liegt vor, wenn fällige Zahlungspflichten nicht erfüllt werden können. (2) Bei drohender Zahlungsunfähigkeit (§ 18) beträgt der Prognosezeitraum in aller Regel 24 Monate. (3) Ein negatives bilanzielles Eigenkapital ist automatisch eine Überschuldung im Sinne von § 19. (4) Bei Überschuldung muss der Antrag spätestens nach drei Wochen gestellt werden.
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Antwort:* Zutreffend sind:
- Zahlungsunfähigkeit (§ 17) liegt vor, wenn fällige Zahlungspflichten nicht erfüllt werden können: Das ist der Kern von § 17. Zahlungseinstellung ist dafür ein gesetzlicher Hinweis.
- Bei drohender Zahlungsunfähigkeit (§ 18) beträgt der Prognosezeitraum in aller Regel 24 Monate: § 18 blickt in die Zukunft: Können die Pflichten voraussichtlich bei Fälligkeit nicht erfüllt werden?
][
*Typische Verwechslungen:*
- „Ein negatives bilanzielles Eigenkapital ist automatisch eine Überschuldung im Sinne von § 19.“: Nicht automatisch: § 19 verlangt zusätzlich, dass die Fortführung in den nächsten zwölf Monaten nicht überwiegend wahrscheinlich ist.
- „Bei Überschuldung muss der Antrag spätestens nach drei Wochen gestellt werden.“: § 15a nennt für die Überschuldung höchstens sechs Wochen. Drei Wochen gelten bei Zahlungsunfähigkeit.
]

#aufgabe(titel: "Drei Insolvenzgründe abgrenzen", art: "verstehen", quelle: "1.8", herkunft: "eigen")[
#if not web [*Aufgabe 82* #linebreak()]
Was unterscheidet Zahlungsunfähigkeit, drohende Zahlungsunfähigkeit und Überschuldung?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- *Zahlungsunfähig:* fällige Zahlungen können jetzt nicht geleistet werden.
- *Drohend zahlungsunfähig:* voraussichtlich bei Fälligkeit nicht, Prognose meist 24 Monate.
- *Überschuldet:* Vermögen deckt die Schulden nicht, außer die Fortführung ist für die nächsten zwölf Monate überwiegend wahrscheinlich.
- Zahlungsengpass und negatives Eigenkapital sind verschiedene Befunde.
]

#aufgabe(titel: "Sale-and-lease-back", art: "verstehen", quelle: "1.8", herkunft: "eigen")[
#if not web [*Aufgabe 83* #linebreak()]
Was ist Sale-and-lease-back?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Man verkauft eigenes Anlagevermögen, z. B. ein Gebäude, und mietet oder least es sofort zurück.
- Das bringt sofort Geld, dafür fallen später laufende Leasingraten an.
]

#aufgabe(titel: "Vorlesung: Verlustpolster und Überschuldung in der Bilanz", art: "rechnen", quelle: "1.8", herkunft: "original", vorlage: "Vorlesung PDF-S. 17, Folie 33, Beispiel (Notiz)", minuten: 8, ergebnis: [Polster 20; nach AfA 30: Vermögen 70 < Schulden 80, Fehlbetrag 10])[
#if not web [*Aufgabe 84* #linebreak()]
*Gegeben und Annahmen*

Beispiel aus der Vorlesung zur Überschuldung (Werte in T€): Aktiva: Anlagevermögen 50, Umlaufvermögen 50. Passiva: Eigenkapital 20, Fremdkapital 80. Im Laufe des Jahres entsteht eine Abschreibung von 30 auf das Anlagevermögen; sonst ändert sich nichts.

*Gesucht*

#enum(numbering: "a)",
[Liegt vor der Abschreibung eine Überschuldung vor? Wie viel Verlust kann sich das Unternehmen bilanziell leisten?],
[Stelle die Bilanz nach der Abschreibung auf. Wie hoch ist der nicht durch Eigenkapital gedeckte Fehlbetrag?],
[Warum kann das Unternehmen die Lücke nicht mit einem Bankkredit schließen? Was hilft stattdessen?],
)
#src[V, PDF-S. 17 (Folie 33), handschriftliches Beispiel der Vorlesung; Lernskript 1.8.]
][
*Ausgangslage prüfen:* Vermögen $50+50=100$, Schulden 80. Da $80<100$, ist die Bilanz in Ordnung: keine Überschuldung. Das EK von 20 ist das *Verlustpolster*: Bis zu 20 Verlust kann das Unternehmen tragen, bevor das EK aufgebraucht ist.
][
*Abschreibung buchen:* Die AfA von 30 läuft als Aufwand durch die GuV und mindert das EK: $20-30=-10$. Das AV sinkt auf $50-30=20$.
][
*Bilanz nach der AfA:* Aktiva: AV 20, UV 50, nicht durch EK gedeckter Fehlbetrag 10; Summe 80. Passiva: EK 0, FK 80; Summe 80. Vermögen 70 < Schulden 80: *rechnerische Überschuldung, Fehlbetrag 10*.
][
*Gegenmaßnahme begründen:* Ein Kredit erhöht Kasse und Schulden um denselben Betrag; die Lücke von 10 bleibt. Bei Überschuldung muss man laut Vorlesung einen EK-Geber finden (Kapitaleinlage) bzw. Forderungsverzicht oder Rangrücktritt erreichen.
][
*Prüfen:* Rechnerische Überschuldung ist ein Warnsignal. Ob ein Insolvenzgrund nach § 19 InsO vorliegt, hängt zusätzlich von der Fortführungsprognose für zwölf Monate ab (Lernskript 1.8).
]

#aufgabe(titel: "Verlustpolster und bilanzielle Unterdeckung", art: "rechnen", quelle: "1.8", herkunft: "variante", vorlage: "Vorlesung PDF-S. 17, Folie 33, Beispiel (Notiz)")[
#if not web [*Aufgabe 85* #linebreak()]
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

#aufgabe(titel: "Bilanzielles Verlustpolster", art: "rechnen", quelle: "1.8", herkunft: "variante", vorlage: "Vorlesung PDF-S. 17, Folie 33, Beispiel (Notiz)")[
#if not web [*Aufgabe 86* #linebreak()]
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

#aufgabe(titel: "BGH-Regel mit 430.000 €", art: "rechnen", quelle: "1.8", herkunft: "eigen")[
#if not web [*Aufgabe 87* #linebreak()]
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

#aufgabe(titel: "BGH-Regel mit 800.000 €", art: "rechnen", quelle: "1.8", herkunft: "eigen")[
#if not web [*Aufgabe 88* #linebreak()]
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

#aufgabe(titel: "Drei Liquiditätsgrade", art: "verstehen", quelle: "1.9", herkunft: "eigen")[
#if not web [*Aufgabe 89* #linebreak()]
#text("Nenne die drei Liquiditätsgrade mit Formel und Zielwert.")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B13. Verfahren: #stelle(<a-1-9>).]
][
#text("1. Grad: flüssige Mittel / kfr. FK, 10–30 %. 2. Grad: (flüssige Mittel + Forderungen) / kfr. FK, mind. 100 %. 3. Grad: Umlaufvermögen / kfr. FK, mind. 200 %.")
][
*Ergänzung aus der Karteikarte „Was messen die drei Liquiditätsgrade?“:*
- Immer geteilt durch das kurzfristige Fremdkapital:
- \*\*1.
- *Grad:*\*\* nur flüssige Mittel (Ziel 10–30 %).
- \*\*2.
- *Grad:*\*\* flüssige Mittel + Forderungen (mindestens 100 %).
- \*\*3.
- *Grad:*\*\* gesamtes Umlaufvermögen (mindestens 200 %).

*Merksatz:* Liquiditätsgrad 1: Kasse; 2: plus Forderungen; 3: plus übriges Umlaufvermögen.

#align(center, image("abbildungen/liquiditaetsgrade.svg", width: 75%))
][
*Antwort:* Kontrollfrage: „Die Barliquidität (Liquidität 1. Grades) ist \_\_\_ geteilt durch das kurzfristige Fremdkapital. Der Zielwert laut Folie liegt bei 10 bis \_\_\_ Prozent.“ Die Barliquidität (Liquidität 1. Grades) ist *flüssige Mittel* geteilt durch das kurzfristige Fremdkapital. Der Zielwert laut Folie liegt bei 10 bis *30* Prozent.
][
*Erklärung:* L1 = flüssige Mittel durch kurzfristiges FK, Ziel 10–30 %. L2 nimmt die Forderungen dazu (mindestens 100 %), L3 das ganze Umlaufvermögen (mindestens 200 %). Zu viel Barliquidität kostet Rendite.
]

#aufgabe(titel: "Hoher Liquiditätsgrad 3 und die Rechnung von morgen", art: "verstehen", quelle: "1.9", herkunft: "eigen", tipp: [Was steckt im Umlaufvermögen, und wie schnell wird es zu Geld?])[
#if not web [*Aufgabe 90* #linebreak()]
Ein Unternehmen hat einen dritten Liquiditätsgrad von 250 %. Ist damit sicher, dass es morgen eine fällige Rechnung bezahlen kann? Begründe.
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Vorräte müssen erst verkauft und Forderungen erst eingezogen werden.
- Die Kennzahl vergleicht Bestände an einem Stichtag, sie kennt keine Fälligkeiten.
- Dafür braucht man den Finanzplan.

*Merksatz:* Ein Stichtagsbestand kennt keine morgigen Fälligkeiten.

#align(center, image("abbildungen/liquiditaetsgrade.svg", width: 75%))
][
*Musterantwort:* Kontrollfrage: „Ein Unternehmen hat einen dritten Liquiditätsgrad von 250 %. Ist damit sicher, dass es morgen eine fällige Rechnung bezahlen kann?“ Nein. Der dritte Grad setzt das ganze Umlaufvermögen, also auch Vorräte und Forderungen, ins Verhältnis zum kurzfristigen Fremdkapital. Vorräte müssen erst verkauft und Forderungen erst eingezogen werden. Die Kennzahl ist eine Bestandsgröße an einem Stichtag und zeigt keine Fälligkeiten. Ob morgen gezahlt werden kann, zeigt nur ein Finanz- bzw. Liquiditätsplan.
]

#aufgabe(titel: "Goldene Bilanzregel", art: "verstehen", quelle: "1.10", herkunft: "eigen")[
#if not web [*Aufgabe 91* #linebreak()]
#text("Formuliere die goldene Bilanzregel. Welche Kennzahl prüft sie, und welcher Wert sollte mindestens erreicht werden?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B14. Verfahren: #stelle(<a-1-10>).]
][
#text("Anlagevermögen soll durch langfristig verfügbares Kapital finanziert werden. Geprüft mit der Anlagendeckung (II: (EK + langfr. FK) / AV); mindestens 100 %.")
][
*Ergänzung aus der Karteikarte „Was sagt die goldene Bilanzregel?“:*
- Langfristig gebundenes Anlagevermögen soll mit langfristig verfügbarem Kapital finanziert werden (Fristenkongruenz).
- Geprüft mit der Anlagendeckung II, mindestens 100 %:
$ "Anlagendeckung II" = ("EK" + "langfristiges FK")/"AV" $

*Merksatz:* Lange gebunden braucht lange finanziert.
][
*Bild:* Ein Haus finanziert man nicht dauerhaft über den Dispokredit.
][
*Antwort:* Kontrollfrage: „Was verlangt die goldene Bilanzregel?“ Langfristig gebundenes Anlagevermögen soll durch langfristig verfügbares Kapital gedeckt sein. Das ist Fristenkongruenz: Ein Haus finanziert man nicht dauerhaft über den Dispo.
][
*Typische Verwechslungen:*
- „Das Eigenkapital muss mindestens 50 % des Gesamtkapitals betragen.“: Eine solche Quote nennt die Vorlesung nicht. Als Ziel für die EK-Quote stehen 15 bis 20 %.
- „Umlaufvermögen soll doppelt so hoch sein wie das kurzfristige Fremdkapital.“: Das ist der Zielwert für die Liquidität 3. Grades, nicht die goldene Bilanzregel.
- „Das Anlagevermögen soll vollständig mit Fremdkapital finanziert werden.“: Wenn es langfristiges FK ist, zählt es zur Deckung, aber die Regel verlangt keine reine FK-Finanzierung.
]

#aufgabe(titel: "Anlageintensität zu hoch oder zu gering", art: "verstehen", quelle: "1.10", herkunft: "eigen")[
#if not web [*Aufgabe 92* #linebreak()]
#text("Warum kann eine zu hohe, aber auch eine zu geringe Anlageintensität problematisch sein?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B15. Verfahren: #stelle(<a-1-10>).]
][
#text("Zu hoch: Das Anlagevermögen lässt sich in der Krise schwer verkaufen. Zu gering: Hinweis auf alte, stark abgeschriebene Anlagen.")
][
*Ergänzung aus der Karteikarte „Ist eine niedrige Anlageintensität automatisch gut?“:*
- Nein.
- Sie kann bedeuten, dass das Unternehmen flexibel ist, aber auch, dass die Anlagen alt und stark abgeschrieben sind.
- Eine Kennzahl allein bewertet nichts.
]

#aufgabe(titel: "Eigenkapitalquote", art: "verstehen", quelle: "1.10", herkunft: "eigen")[
#if not web [*Aufgabe 93* #linebreak()]
#text("Was sagt die Eigenkapitalquote aus, und welcher Zielwert gilt?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B16. Verfahren: #stelle(<a-1-10>).]
][
#text("Anteil des EK an der Bilanzsumme; zeigt finanzielle Unabhängigkeit und Bonität. Zielwert mindestens 15–20 %.")
][
*Ergänzung aus der Karteikarte „Was sagt die Eigenkapitalquote aus?“:*
- $"EK-Quote" = "EK" \/ "Gesamtkapital"$.
- Sie zeigt, wie groß das Verlustpolster ist.
- Mehr Eigenkapital heißt mehr Sicherheit und meist bessere Kreditwürdigkeit.
- Zielwert laut Folie mindestens 15–20 %.
]

#aufgabe(titel: "Schuldentilgungsdauer deuten", art: "verstehen", quelle: "1.10", herkunft: "eigen")[
#if not web [*Aufgabe 94* #linebreak()]
Ein Unternehmen hat 100 Mio. € Verbindlichkeiten und einen jährlichen Cashflow von 25 Mio. €. Was sagt die Schuldentilgungsdauer (Verbindlichkeiten / Cashflow) aus, und was sagt sie nicht?
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- In wie vielen Jahren das Unternehmen seine Schulden rechnerisch aus dem Cashflow tilgen könnte.
- 100 Schulden bei 25 Cashflow pro Jahr gibt vier Jahre.
- Das setzt voraus, dass der ganze Cashflow dafür verfügbar ist und konstant bleibt.
][
*Antwort:* Kontrollfrage: „Ein Unternehmen hat 100 Mio. € Verbindlichkeiten und einen jährlichen Cashflow von 25 Mio. €. Was sagt die Schuldentilgungsfähigkeit?“ Rechnerisch vier Jahre. $100 \/ 25 = 4$ Jahre, vorausgesetzt, der Cashflow bleibt konstant und steht vollständig für die Tilgung bereit.
][
*Typische Verwechslungen:*
- „25 %“: Die Kennzahl ist kein Prozentwert, sondern ein Verhältnis von Bestand zu Jahresstrom, also eine Zeit.
- „0,25 Jahre“: Zähler und Nenner sind vertauscht. Es sind Verbindlichkeiten durch Cashflow.
- „Das Unternehmen tilgt garantiert in vier Jahren.“: Die Zahl ist nur rechnerisch. Sie verspricht keine tatsächliche Tilgungsdauer.
]

#aufgabe(titel: "EK-Rentabilität über dem Marktzins", art: "verstehen", quelle: "1.11", herkunft: "eigen")[
#if not web [*Aufgabe 95* #linebreak()]
#text("Warum sollte die EK-Rentabilität deutlich über dem Marktzins für langfristige Anlagen liegen?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B17. Verfahren: #stelle(<a-1-11>).]
][
#text("Weil der Gewinn zusätzlich das Unternehmensrisiko vergüten muss. Sonst könnte der Eigentümer sein Geld risikolos(er) anlegen.")
]

#aufgabe(titel: "Hubert + Maier: Risiko aus der Kapitalstruktur", art: "verstehen", quelle: "1.11", herkunft: "eigen")[
#if not web [*Aufgabe 96* #linebreak()]
#text("Erkläre am Beispiel Hubert + Maier GmbH, warum das Risiko von Alternative B aus der Kapitalstruktur kommt.")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B18. Verfahren: #stelle(<a-1-11>).]
][
#text("Bei A und B fällt das Grundstück gleich stark (gleiches Geschäftsrisiko). Bei A trägt das hohe EK den Verlust. Bei B kommen 8.000 € Zinsen dazu, und das kleine EK (20.000) reicht für 28.000 Verlust nicht: bilanzieller Fehlbetrag von 8.000 €. Eine rechtliche Überschuldung ist zusätzlich nach Abschnitt 1.8 zu prüfen. Der Unterschied liegt nur in der Finanzierung.")
][
*Ergänzung aus der Karteikarte „Was zeigt das Beispiel Hubert + Maier GmbH (100 % EK oder 20 % EK + 80 % FK)?“:*
- Dasselbe Grundstück, dasselbe Geschäftsrisiko, aber andere Folgen bei einem Wertverlust.
- Mit viel Fremdkapital fallen zusätzlich Zinsen an, und das kleine Eigenkapital ist schnell aufgebraucht.
- Die Darlehen bleiben bestehen, bei 100 % EK tragen die Eigentümer den Verlust allein.

#align(center, image("abbildungen/kapitalrisiko-folie.svg", width: 75%))
][
*Antwort:* Kontrollfrage: „Bei der Hubert + Maier GmbH fällt das Grundstück von 90.000 € auf 70.000 €. Alternative B hat 20.000 € EK und 80.000 € FK zu 10 %. Wie hoch ist das rechnerische Eigenkapital am Jahresende?“ −8.000 €. Vermögen $70000 + 2000$ Kasse nach $8000$ Zinsen $= 72000$; minus $80000$ FK ergibt $-8000$ €.
][
*Typische Verwechslungen:*
- „0 €“: Hier wurde nur der Wertverlust von 20.000 € vom EK abgezogen. Die Zinsen von 8.000 € fehlen.
- „80.000 €“: Das ist Alternative A ohne Fremdkapital.
- „72.000 €“: Das ist das Vermögen. Die Schulden von 80.000 € müssen noch abgezogen werden.
]

#aufgabe(titel: "EK-Rentabilität und Umsatzrentabilität", art: "verstehen", quelle: "1.11", herkunft: "eigen")[
#if not web [*Aufgabe 97* #linebreak()]
Was unterscheidet Eigenkapitalrentabilität und Umsatzrentabilität?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
$ "EK-Rentabilität" = "Jahresüberschuss"/"Eigenkapital" $
- Wie gut verzinst sich das Geld der Eigentümer?
- Sie soll deutlich über dem Marktzins liegen, weil sie das Risiko vergüten muss.
$ "Umsatzrentabilität" = "Jahresüberschuss"/"Umsatz" $
- Wie viel vom Umsatz bleibt als Gewinn hängen?

#align(center, image("abbildungen/kapitalrisiko-folie.svg", width: 75%))
]

#aufgabe(titel: "Vorlesung: Hubert + Maier GmbH in zwei Bilanzen", art: "rechnen", quelle: "1.11", herkunft: "original", vorlage: "Vorlesung PDF-S. 25, Folien 49–50, Beispiel Hubert + Maier", minuten: 12, ergebnis: [A: EK 80.000 €; B: EK 0, Fehlbetrag 8.000 €])[
#if not web [*Aufgabe 98* #linebreak()]
*Gegeben und Annahmen*

Die Hubert + Maier GmbH beabsichtigt am 01.01.01, für 90.000 € ein Grundstück zu kaufen. Hubert und Maier wollen die GmbH mit 100.000 € Kapital ausstatten; was nicht ins Grundstück fließt, bleibt in der Kasse. Zwei Finanzierungsalternativen:
- Alternative A: 100.000 € EK (Hubert und Maier je 50.000 €).
- Alternative B: 20.000 € EK (je 10.000 €) und 80.000 € FK mit 10 % Zinsen p. a. (je 40.000 € von Hubert und Maier als Darlehen).
Im Jahr 01 ist das Grundstück wegen Altlasten nur noch 70.000 € wert. Die Zinsen werden aus der Kasse bezahlt. Sonst geschieht nichts.

*Gesucht*

#enum(numbering: "a)",
[Stelle für beide Alternativen die Bilanz zum 01.01.01 auf.],
[Stelle beide Bilanzen zum 31.12.01 auf.],
[Wie entwickelt sich die GmbH in beiden Fällen? Woher kommt das Risiko in Alternative B?],
)
#src[V, PDF-S. 25, Folien 49–50; Notiz der Vorlesung („Risiko kommt aus der Kapitalstruktur, Geschäftsrisiko ist dasselbe“).]
][
*Anfangsbilanzen:* In beiden Fällen Aktiva: Grundstück 90.000, Kasse 10.000 = 100.000 €. A: Passiva EK Hubert 50.000, EK Maier 50.000. B: EK Hubert 10.000, EK Maier 10.000, FK Hubert 40.000, FK Maier 40.000. Die Aktivseite ist gleich, nur die Finanzierung unterscheidet sich.
][
*Alternative A zum 31.12.:* Grundstück 70.000, Kasse 10.000 = 80.000 €. Der Wertverlust von 20.000 € mindert das EK: je 40.000 €. Kein Problem, das Polster reicht.
][
*Alternative B zum 31.12.:* Zinsen $80000 times "0,10"=8000$ € aus der Kasse: Kasse $10000-8000=2000$ €. Vermögen $70000+2000=72000$ €. Schulden 80.000 €. Verlust $20000+8000=28000$ € > EK 20.000 €. EK = 0, auf der Aktivseite steht ein *nicht durch EK gedeckter Fehlbetrag von 8.000 €*; Bilanzsumme 80.000 €.
][
*Deuten:* Das Geschäftsrisiko (Altlasten, −20.000 €) ist in A und B gleich. In B kommen die Zinsen hinzu, und das kleine EK kann den Verlust nicht tragen: Hang zur Überschuldung. Das zusätzliche Risiko kommt also allein aus der Kapitalstruktur.
][
*Prüfen:* Summe Aktiva = Summe Passiva in allen vier Bilanzen. Ob B rechtlich überschuldet ist, hängt noch von § 19 InsO ab; dass die Darlehen von den Gesellschaftern stammen, ändert ohne vereinbarten Rangrücktritt nichts daran, dass sie Schulden sind.
]

#aufgabe(titel: "Kapitalstruktur und Risiko in zwei Bilanzen", art: "rechnen", quelle: "1.11", herkunft: "variante", vorlage: "Vorlesung PDF-S. 25, Folien 49–50, Beispiel Hubert + Maier")[
#if not web [*Aufgabe 99* #linebreak()]
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

#aufgabe(titel: "Klausur: Leverage deuten und Risiken der Verschuldung", art: "verstehen", quelle: "1.12", herkunft: "original", vorlage: "Altklausur 2017, Aufg. 3 b–c", minuten: 3)[
#if not web [*Aufgabe 100* #linebreak()]
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

#aufgabe(titel: "Leverage-Effekt", art: "verstehen", quelle: "1.12", herkunft: "eigen")[
#if not web [*Aufgabe 101* #linebreak()]
#text("Was ist der Leverage-Effekt, und unter welcher Bedingung tritt er auf?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B19. Verfahren: #stelle(<a-1-12>).]
][
#text("Hebelwirkung des FK zugunsten der EK-Rentabilität: Ist der FK-Zins kleiner als die Gesamtkapitalrendite, steigt die EK-Rentabilität mit zunehmender Verschuldung.")
][
*Ergänzung aus der Karteikarte „Was ist der Leverage-Effekt?“:*
- Mehr Fremdkapital hebelt die Eigenkapitalrendite:
$ r_e = r_G + (r_G - r_f) dot "FK"/"EK" $
- Verdient das Gesamtkapital mehr als der Kreditzins kostet ($r_G > r_f$), steigt die EK-Rendite mit jeder Verschuldung.
- Ist $r_G < r_f$, drückt derselbe Hebel die EK-Rendite nach unten.

*Merksatz:* Der Kredithebel wirkt nach oben und nach unten.

#align(center, image("abbildungen/leverage-kurven.svg", width: 75%))
][
*Bild:* Ein Hebel verstärkt in beide Richtungen.
]

#aufgabe(titel: "Risikoeffekt", art: "verstehen", quelle: "1.12", herkunft: "eigen")[
#if not web [*Aufgabe 102* #linebreak()]
#text("Was beschreibt der Risikoeffekt? Warum ist die höhere EK-Rendite „kein zusätzlicher Wert“?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B20. Verfahren: #stelle(<a-1-12>).]
][
#text("Mit steigender Verschuldung wächst die Streuung der EK-Rendite (das Risiko). Die höhere Rendite ist nur die Entschädigung für dieses höhere Risiko, kein Geschenk.")
]

#aufgabe(titel: "Warum nicht vollständig fremdfinanzieren", art: "verstehen", quelle: "1.12", herkunft: "eigen")[
#if not web [*Aufgabe 103* #linebreak()]
#text("Warum ist eine vollständige Fremdfinanzierung trotz Leverage-Effekt keine gute Idee?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B21. Verfahren: #stelle(<a-1-12>).]
][
#text("Mit EK = 0 ist die Leverage-Formel nicht definiert. Mit sinkendem EK werden das Verlustpolster kleiner und die Renditeschwankungen größer. Kreditzins, Kreditverfügbarkeit und Rückzahlungspflichten dürfen nicht als beliebig unverändert angenommen werden; bei rG < rf wirkt der Hebel negativ.")
][
*Ergänzung aus der Karteikarte „Warum ist eine hohe Eigenkapitalrendite kein Grund für beliebig viel Kredit?“:*
- Der Hebel wirkt auch im schlechten Jahr, dann gegen die Eigentümer.
- Die Zinsen müssen immer gezahlt werden, und das Verlustpolster wird kleiner.
- Mit steigender Verschuldung steigt meist auch der Kreditzins.
- Das ist der Risikoeffekt.

#align(center, image("abbildungen/leverage-kurven.svg", width: 75%))
][
*Musterantwort:* Kontrollfrage: „Der Leverage-Effekt steigert die EK-Rendite. Nenne zwei Argumente, warum ein Unternehmen trotzdem nicht beliebig viel Fremdkapital aufnehmen sollte.“ 1. Risikoeffekt: Mit höherer Verschuldung schwankt die EK-Rendite stärker. Fällt die Gesamtkapitalrendite unter den FK-Zins, kehrt sich der Hebel um. 2. Zinsen und Tilgung sind fest und müssen auch in schlechten Jahren gezahlt werden, das gefährdet die Liquidität. 3. Das Verlustpolster (EK) wird kleiner, schon ein moderater Verlust kann das EK aufzehren. 4. Mit steigender Verschuldung steigt meist auch der FK-Zins, die Bonität sinkt.
]

#aufgabe(titel: "Leverage mit 50 EK und 50 FK", art: "verstehen", quelle: "1.12", herkunft: "eigen", tipp: [$r_e = r_G + (r_G - r_f) "FK"\/"EK"$])[
#if not web [*Aufgabe 104* #linebreak()]
Ohne Fremdkapital erwirtschaftet ein Unternehmen mit 100 Gesamtkapital einen Gewinn vor Zinsen von 20. Jetzt wird es zu 50 EK und 50 FK zu 10 % finanziert. Wie hoch ist die EK-Rendite?
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Antwort:* 30 %. Zinsen $50 dot "0,1" = 5$, Gewinn $15$, $15 \/ 50 = 30 %$. Auch mit der Formel: $r_e = "0,2" + ("0,2" - "0,1") dot 1 = "0,3"$.
][
*Typische Verwechslungen:*
- „20 %“: Das ist die Gesamtkapitalrendite. Der Hebel durch das FK fehlt.
- „40 %“: Hier wurden die Zinsen vergessen: 20 durch 50 wären 40 %.
- „15 %“: 15 ist der absolute Gewinn, nicht die Rendite. Er muss noch durch das EK geteilt werden.
]

#aufgabe(titel: "Wann Verschuldung die EK-Rendite senkt", art: "verstehen", quelle: "1.12", herkunft: "eigen")[
#if not web [*Aufgabe 105* #linebreak()]
Wann verringert zusätzliche Verschuldung die Eigenkapitalrendite? Begründe mit der Leverage-Formel.
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Antwort:* Wenn die Gesamtkapitalrendite kleiner als der Fremdkapitalzins ist. Dann ist $(r_G - r_f)$ negativ, und jeder zusätzliche Euro FK drückt die EK-Rendite weiter.
][
*Typische Verwechslungen:*
- „Wenn die Gesamtkapitalrendite größer als der Fremdkapitalzins ist.“: Dann wirkt der Hebel positiv und die EK-Rendite steigt.
- „Wenn der Verschuldungsgrad über 1 liegt.“: Die Höhe des Verschuldungsgrads bestimmt nur die Stärke des Hebels, nicht seine Richtung.
- „Nie, Verschuldung erhöht die EK-Rendite immer.“: Der Hebel wirkt in beide Richtungen. Im schlechten Jahr arbeitet er gegen die Eigentümer.
]

#aufgabe(titel: "Klausur: Gründung mit 800.000 € Kapital", art: "rechnen", quelle: "1.12", herkunft: "original", vorlage: "Altklausur 2017, Aufg. 3 a", minuten: 8)[
#if not web [*Aufgabe 106* #linebreak()]
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

#aufgabe(titel: "Leverage im guten und schlechten Jahr", art: "rechnen", quelle: "1.12", herkunft: "variante", vorlage: "Altklausur 2017, Aufg. 3 a")[
#if not web [*Aufgabe 107* #linebreak()]
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

#aufgabe(titel: "Vorlesung: Leverage beim Aktienkauf mit Kredit", art: "rechnen", quelle: "1.12", herkunft: "original", vorlage: "Vorlesung PDF-S. 26, Folie 51, Beispiel Leverage-Effekt (Notiz)", minuten: 8, ergebnis: [Ohne FK: +20 % / −50 %; mit FK: +40 % / −100 %])[
#if not web [*Aufgabe 108* #linebreak()]
*Gegeben und Annahmen*

Beispiel aus der Vorlesung: Du hast 5.000 € Eigenkapital und kaufst Aktien. Fall 1: Der Kurs steigt um 20 %. Fall 2: Der Kurs fällt um 50 %. Variante mit Kredit: Du nimmst zusätzlich 5.000 € Fremdkapital auf und legst 10.000 € in Aktien an. Zinsen werden vereinfachend vernachlässigt; am Ende wird der Kredit zurückgezahlt.

*Gesucht*

#enum(numbering: "a)",
[Wie viel ist dein Depot in beiden Fällen ohne Kredit wert? Wie ändert sich dein EK in Prozent?],
[Wie viel bleibt dir mit Kredit nach Rückzahlung der 5.000 €? Wie ändert sich dein EK in Prozent?],
[Was zeigt das Beispiel über Leverage- und Risikoeffekt?],
)
#src[V, PDF-S. 26 (Folie 51), handschriftliches Beispiel der Vorlesung; Lernskript 1.12.]
][
*Ohne Kredit:* $5000 times "1,2"=6000$ € (+20 %) bzw. $5000 times "0,5"=2500$ € (−50 %). Die EK-Rendite entspricht genau der Kursänderung.
][
*Mit Kredit:* Depot $10000 times "1,2"=12000$ €; nach Rückzahlung $12000-5000=7000$ €, also $+2000/5000=+40%$. Im schlechten Fall $10000 times "0,5"=5000$ €; die 5.000 € gehen an den FK-Geber, dir bleiben *0 €* (−100 %).
][
*Deuten:* Das FK verdoppelt hier die Wirkung auf dein EK (FK/EK = 1): +20 % werden zu +40 % (Leverage-Effekt), −50 % zu −100 % (Risikoeffekt). Der Kreditgeber bekommt seinen festen Betrag zurück, die ganze Schwankung trägt das EK.
][
*Prüfen:* Mit Zinsen wäre die Rechnung für dich in beiden Fällen schlechter; der Hebel wirkt nur positiv, solange die Rendite über dem Zinssatz liegt.
]

#aufgabe(titel: "Leverage beim Aktienkauf mit Zinsen (Variante)", art: "rechnen", quelle: "1.12", herkunft: "variante", vorlage: "Vorlesung PDF-S. 26, Folie 51, Beispiel Leverage-Effekt (Notiz)", minuten: 10, ergebnis: [Ohne Zinsen +37,5 % / −75 %; mit 4 % Zinsen +31,5 % / −81 %])[
#if not web [*Aufgabe 109* #linebreak()]
*Gegeben und Annahmen*

Du hast 8.000 € Eigenkapital und nimmst 12.000 € Kredit auf; du kaufst für 20.000 € Aktien. Nach einem Jahr ist der Kurs entweder um 15 % gestiegen (Fall 1) oder um 30 % gefallen (Fall 2). Danach verkaufst du und zahlst den Kredit zurück. Keine Gebühren, keine Steuern, keine Dividenden.

*Gesucht*

#enum(numbering: "a)",
[EK-Änderung in Prozent für beide Fälle, wenn nur 8.000 € ohne Kredit angelegt werden.],
[EK-Änderung in Prozent für beide Fälle mit Kredit, zunächst ohne Zinsen.],
[Wie ändern sich die Ergebnisse von b), wenn der Kredit 4 % Zinsen p. a. kostet?],
)
#src[Eigene Variante zum handschriftlichen Leverage-Beispiel (V, PDF-S. 26, Folie 51); Lernskript 1.12.]
][
*Ohne Kredit:* $8000 times "1,15"=9200$ € (+15 %), $8000 times "0,70"=5600$ € (−30 %). Ohne FK entspricht die EK-Rendite der Kursänderung.
][
*Mit Kredit, ohne Zinsen:* Fall 1: $20000 times "1,15"=23000$ €, nach Rückzahlung $23000-12000=11000$ €, EK-Änderung $3000/8000=+"37,5"%$. Fall 2: $20000 times "0,70"=14000$ €, Rest $2000$ €, EK-Änderung $-6000/8000=-75%$. Der Hebel ist $1+"FK"/"EK"=1+"1,5"="2,5"$: $15% times "2,5"="37,5"%$ und $-30% times "2,5"=-75%$.
][
*Mit 4 % Zinsen:* Zinsen $12000 times "0,04"=480$ €. Fall 1: $11000-480=10520$ €, also $+2520/8000=+"31,5"%$. Fall 2: $2000-480=1520$ €, also $-6480/8000=-81%$.
][
*Prüfen:* Die Zinsen kosten in beiden Fällen $480/8000=6$ Prozentpunkte EK-Rendite. Im guten Fall bleibt der Hebel positiv (Kursrendite 15 % > 4 %), im schlechten Fall verstärkt er den Verlust.
]

#aufgabe(titel: "Vorlesung: Zahlenbeispiel Leverage-Effekt", art: "rechnen", quelle: "1.12", herkunft: "original", vorlage: "Vorlesung PDF-S. 27, Folie 53, Zahlenbeispiel Leverage-Effekt", minuten: 6, ergebnis: [100 % EK: 20 %; 50 % FK: 30 %; Gewinn sinkt von 20 auf 15])[
#if not web [*Aufgabe 110* #linebreak()]
*Gegeben und Annahmen*

Ein Unternehmen hat ein Gesamtkapital von 100 und erzielt einen Gewinn vor Zinsen von 20. Fall 1: 100 % Eigenkapitalfinanzierung. Fall 2: 50 % Fremdkapital (50) zu 10 % Zinsen, 50 % Eigenkapital. Keine Steuern.

*Gesucht*

#enum(numbering: "a)",
[Gewinn und Eigenkapitalrentabilität in beiden Fällen.],
[Kontrolliere Fall 2 mit der Leverage-Formel.],
[Was ist gestiegen, was gesunken? Was zeigt das Beispiel?],
)
#src[V, PDF-S. 27, Folie 53 (Zahlenbeispiel Leverage-Effekt); Lernskript 1.12.]
][
*Fall 1:* Gewinn 20, EK 100: $r_e=20/100=20%$.
][
*Fall 2:* Zinsen $50 times "0,10"=5$, Gewinn nach Zinsen $20-5=15$, EK 50: $r_e=15/50=30%$.
][
*Formel:* $r_G=20/100=20%$, $r_e=r_G+(r_G-r_f) "FK"/"EK"=20%+(20%-10%) times 50/50=30%$.
][
*Deuten:* Die EK-Rentabilität ist durch die FK-Finanzierung gestiegen (20 % → 30 %), der Gewinn aber gesunken (20 → 15), weil Zinsen anfallen. Der Hebel wirkt, weil die Gesamtkapitalrendite (20 %) über dem FK-Zins (10 %) liegt.
]

#aufgabe(titel: "Leverage-Formel anwenden", art: "rechnen", quelle: "1.12", herkunft: "variante", vorlage: "Vorlesung PDF-S. 27, Folie 53, Zahlenbeispiel Leverage-Effekt")[
#if not web [*Aufgabe 111* #linebreak()]
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

#aufgabe(titel: "Leverage im schlechten Jahr", art: "rechnen", quelle: "1.12", herkunft: "variante", vorlage: "Vorlesung PDF-S. 27, Folie 53, Zahlenbeispiel Leverage-Effekt")[
#if not web [*Aufgabe 112* #linebreak()]
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

#aufgabe(titel: "FK-Quote von 50 auf 85 Prozent", art: "rechnen", quelle: "1.12", herkunft: "variante", vorlage: "Vorlesung PDF-S. 27, Folie 53, Zahlenbeispiel Leverage-Effekt")[
#if not web [*Aufgabe 113* #linebreak()]
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

#aufgabe(titel: "Glasspinnerei: Finanzplan, Plan-GuV, Planbilanz", art: "verstehen", quelle: "1.13", herkunft: "original", vorlage: "Fallstudie Glasspinnerei, PDF-S. 4 und 7 (Planungsverbund)")[
#if not web [*Aufgabe 114* #linebreak()]
#text("Warum benötigt die Glasspinnerei gleichzeitig Finanzplan, Plan-GuV und Planbilanz? Erkläre die Rückkopplung über Zinsen, Steuern und Betriebskapital.")
#src[G, PDF-S. 4 und 7. Verfahren: #stelle(<a-1-13>).]
][
Die Bilanz liefert die operative Kapitalbindung und Finanzierungsbestände. Die GuV liefert Kosten, Abschreibung, Zinsaufwand und die Steuerbasis. Der Finanzplan liefert Mittelbedarf und Kreditaufnahme; daraus folgen wiederum Zinsen. *Prüfung:* Ein isolierter Gewinn genügt für keine vollständige Kapitalbedarfsrechnung.
][
*Ergänzung aus der Karteikarte „Warum braucht man Finanzplan, Plan-GuV und Planbilanz zusammen?“:*
- Der Finanzplan braucht die Zahlungen, die Plan-GuV liefert Aufwendungen, Abschreibungen und damit die Steuern, die Planbilanz zeigt Bestände wie Lager und Forderungen.
- Die Zinsen hängen wiederum von der Finanzierung ab, die erst der Finanzplan zeigt.
- Das ist eine Abstimmungsschleife.
]

#aufgabe(titel: "Glasspinnerei: Nettoumsatz und Kapazität", art: "rechnen", quelle: "1.13", herkunft: "original", vorlage: "Fallstudie Glasspinnerei, PDF-S. 3, 5 und 11 (Umsatz und Kapazität)")[
#if not web [*Aufgabe 115* #linebreak()]
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

#aufgabe(titel: "Dämmstoffwerk: Umsatz und Kapazität (Variante)", art: "rechnen", quelle: "1.13", herkunft: "variante", vorlage: "Fallstudie Glasspinnerei, PDF-S. 3, 5 und 11 (Umsatz und Kapazität)", minuten: 8, ergebnis: [2025: 137,2 Mio. €; 2027 begrenzt auf 17.520 t])[
#if not web [*Aufgabe 116* #linebreak()]
*Gegeben und Annahmen*

Ein Dämmstoffwerk setzt 2025 14.000 t zu 9.800 €/t ab. Geplant ist ein Mengenwachstum von 15 % pro Jahr und eine Preissteigerung von 5 % pro Jahr. Die Anlage läuft an 365 Tagen und schafft höchstens 48 t pro Tag.

*Gesucht*

#enum(numbering: "a)",
[Nettoumsatz 2025.],
[Absatzmengen 2026 und 2027 laut Wachstumsannahme; prüfe die Kapazität.],
[Nettoumsatz 2026.],
)
#src[Eigene Variante zur Umsatz- und Kapazitätsrechnung der Fallstudie Glasspinnerei (G, PDF-S. 3, 5, 11); Lernskript 1.13.]
][
*Umsatz 2025:* $14000 thin "t" times 9800 thin "€/t"=137200000$ € = *137,2 Mio. €*.
][
*Mengen:* 2026 $14000 times "1,15"=16100$ t; 2027 $16100 times "1,15"=18515$ t. Kapazität $48 times 365=17520$ t/Jahr. 2027 ist das Wachstum nicht voll möglich; die Planmenge wird auf *17.520 t* begrenzt.
][
*Umsatz 2026:* Preis $9800 times "1,05"=10290$ €/t; Umsatz $16100 times 10290 approx "165,67"$ Mio. €.
][
*Prüfen:* Wie in der Fallstudie gehört zu jeder Mengenplanung die Kapazitätsprüfung; sonst plant man Umsätze, die die Anlage nicht liefern kann.
]

#aufgabe(titel: "Aufbau des EBK", art: "verstehen", quelle: "1.14", herkunft: "eigen")[
#if not web [*Aufgabe 117* #linebreak()]
Wie ist das erforderliche Betriebskapital (EBK) aufgebaut? Nenne die Positionen, die Kapital binden, und die, die Mittel freisetzen.
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- *EBK:* Geld, das im Kerngeschäft gebunden ist.
- *Addieren:* Lagerbestände, Forderungen, geleistete Anzahlungen.
- *Abziehen:* Lieferantenverbindlichkeiten, erhaltene Anzahlungen.
- EBK steigt → Geld wird gebunden; EBK sinkt → Geld wird frei.

*Merksatz:* Mehr operative Bindung: weniger frei verfügbares Geld.

#align(center, image("abbildungen/g-nocf-plan.svg", width: 75%))
][
*Antwort:* Kontrollfrage: „Wie ist das erforderliche Betriebskapital (EBK) aufgebaut?“ Lagerbestände + Forderungen + geleistete Anzahlungen − (Lieferverbindlichkeiten + erhaltene Anzahlungen). Vorräte und Forderungen binden Geld, Lieferantenkredit und Kundenanzahlungen finanzieren mit.
][
*Typische Verwechslungen:*
- „Anlagevermögen + Umlaufvermögen − Eigenkapital“: Das Anlagevermögen gehört nicht ins EBK. Es geht nur um operativ gebundene Bestände.
- „Lagerbestände + Lieferverbindlichkeiten − Forderungen“: Die Vorzeichen sind vertauscht: Forderungen binden Geld, Verbindlichkeiten setzen es frei.
- „Jahresüberschuss + Abschreibungen“: Das ist die einfache indirekte Cashflow-Formel, keine Bestandsgröße.
]

#aufgabe(titel: "EBK-Zunahme und NOCF", art: "verstehen", quelle: "1.14", herkunft: "eigen")[
#if not web [*Aufgabe 118* #linebreak()]
Die Glasspinnerei wächst stark. Wie wirkt eine Zunahme des EBK auf den Net Operating Cashflow, und warum?
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Antwort:* Sie verringert ihn, weil zusätzliche Mittel in Lager und Forderungen gebunden werden. Im NOCF steht $- Delta "EBK"$. Wachstum bindet Geld, über 2005–2008 rund 16 Mio. €.
][
*Typische Verwechslungen:*
- „Sie erhöht ihn, weil mehr Vermögen im Unternehmen ist.“: Mehr Vorräte und Forderungen heißt, mehr Geld steckt fest. Das ist kein Geldzufluss.
- „Gar nicht, weil das EBK nur in der Bilanz steht.“: Die Änderung des Bestands ist zahlungswirksam und fließt in den NOCF ein.
- „Sie erhöht ihn nur, wenn auch der Gewinn steigt.“: Der Gewinn ändert nichts an der Richtung: Eine Zunahme des EBK verbraucht Geld.
]

#aufgabe(titel: "Wachstum bindet Geld", art: "verstehen", quelle: "1.14", herkunft: "eigen")[
#if not web [*Aufgabe 119* #linebreak()]
Warum braucht ein wachsendes, profitables Unternehmen trotzdem zusätzliches Geld?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- *Wachstum bindet Kapital:* Mehr Umsatz heißt mehr Lager und mehr offene Forderungen, außerdem müssen Investitionen vorab bezahlt werden.
- Der Gewinn kommt erst später als Geld herein.

*Merksatz:* Wachstum kann Geld binden, bevor es Geld bringt.

#align(center, image("abbildungen/g-nocf-plan.svg", width: 75%))
]

#aufgabe(titel: "Was ist der NOCF?", art: "verstehen", quelle: "1.14", herkunft: "eigen")[
#if not web [*Aufgabe 120* #linebreak()]
Was ist der Net Operating Cashflow (NOCF)?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- *NOCF:* Zahlungsbeitrag des Kerngeschäfts.
- Vom Umsatz Material, Löhne und sonstige betriebliche Aufwendungen abziehen.
- Sonstige Erträge addieren; Steuerzahlungen und die Zunahme des EBK abziehen.
- Zinsen und neue Kredite erst in der nächsten Stufe des Finanzplans berücksichtigen.

#align(center, image("abbildungen/g-nocf-plan.svg", width: 75%))
]

#aufgabe(titel: "EBK-Änderung statt EBK-Bestand", art: "verstehen", quelle: "1.14", herkunft: "eigen")[
#if not web [*Aufgabe 121* #linebreak()]
Warum muss man beim NOCF die Änderung des EBK abziehen und nicht das ganze EBK?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Nur der Zuwachs bindet in diesem Jahr zusätzliches Geld.
- Das bisherige EBK ist schon in den Vorjahren gebunden worden.
- Es jedes Jahr komplett abzuziehen würde es mehrfach zählen.

*Merksatz:* Die Änderung ist neu gebunden; der Altbestand nicht noch einmal.

#align(center, image("abbildungen/g-nocf-plan.svg", width: 75%))
]

#aufgabe(titel: "Glasspinnerei: erweitertes EBK 2004", art: "rechnen", quelle: "1.14", herkunft: "original", vorlage: "Fallstudie Glasspinnerei, PDF-S. 11 (EBK, Tab. 3.6)")[
#if not web [*Aufgabe 122* #linebreak()]
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

#aufgabe(titel: "Glasspinnerei: erweitertes EBK 2003 (Variante)", art: "rechnen", quelle: "1.14", herkunft: "variante", vorlage: "Fallstudie Glasspinnerei, PDF-S. 11 (EBK, Tab. 3.6)", minuten: 6, ergebnis: [EBK 2003 = −10.914 T€; Änderung +780 T€])[
#if not web [*Aufgabe 123* #linebreak()]
*Gegeben und Annahmen*

Glasspinnerei Straubing AG, Werte in T€, Jahr 2003: Lagerbestände 19.733, Forderungen aus Lieferungen und Leistungen 26.462, Verbindlichkeiten aus Lieferungen und Leistungen 30.591, Rückstellungen für Lizenzgebühren und Löhne 4.595, Rückstellungen für Steuerzahlungen 21.923. Andere Forderungen und erhaltene Anzahlungen: keine. Erweitertes EBK 2002: −11.694 T€.

*Gesucht*

#enum(numbering: "a)",
[Erweitertes EBK 2003 (Rückstellungen wie in der Fallstudie als Mittel freisetzende Positionen).],
[Änderung gegenüber 2002. Bindet sie Kapital oder setzt sie Mittel frei?],
)
#src[Eigene Variante mit den Werten 2003 aus Tabelle 3.6 der Fallstudie (G, PDF-S. 11); Lernskript 1.14.]
][
*EBK:* $19733+26462-30591-4595-21923=-10914$ T€. Negativ: Lieferanten und Rückstellungen finanzieren mehr, als in Lager und Forderungen gebunden ist.
][
*Änderung:* $Delta "EBK"=-10914-(-11694)=+780$ T€. Positiv bedeutet: 0,78 Mio. € zusätzlich gebundenes Kapital, das den NOCF mindert.
][
*Prüfen:* Der Wert stimmt mit Tabelle 3.6 der Fallstudie überein (−10.914; Δ 780).
]

#aufgabe(titel: "Glasspinnerei: erweitertes EBK 2005", art: "rechnen", quelle: "1.14", herkunft: "original", vorlage: "Fallstudie Glasspinnerei, PDF-S. 8 und 11–12 (EBK 2005)")[
#if not web [*Aufgabe 124* #linebreak()]
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

#aufgabe(titel: "Dämmstoffwerk: EBK aus Umsatzquoten (Variante)", art: "rechnen", quelle: "1.14", herkunft: "variante", vorlage: "Fallstudie Glasspinnerei, PDF-S. 8 und 11–12 (EBK 2005)", minuten: 8, ergebnis: [EBK 6,5 Mio. €; Δ EBK +2,5 Mio. € (bindet Geld)])[
#if not web [*Aufgabe 125* #linebreak()]
*Gegeben und Annahmen*

Ein Dämmstoffwerk plant für das nächste Jahr einen Nettoumsatz von 150 Mio. €. Lagerbestände 8 %, Forderungen aus L. u. L. 12 %, Verbindlichkeiten aus L. u. L. 9 % des Nettoumsatzes. Rückstellungen für Lizenzen/Löhne 4 Mio. €, Steuerrückstellungen 6 Mio. €. Erweitertes EBK des Vorjahres 4 Mio. €.

*Gesucht*

#enum(numbering: "a)",
[Erweitertes EBK des Planjahres.],
[Änderung und Wirkung auf den NOCF.],
)
#src[Eigene Variante zur EBK-Planung der Fallstudie Glasspinnerei (G, PDF-S. 8, 11–12); Lernskript 1.14.]
][
*Bestände:* LB $150 times "0,08"=12$; FLei $150 times "0,12"=18$; VLei $150 times "0,09"="13,5"$ Mio. €.
][
*EBK:* $12+18-"13,5"-4-6="6,5"$ Mio. €.
][
*Änderung:* $Delta "EBK"="6,5"-4="2,5"$ Mio. €. Positiv: Das Wachstum bindet 2,5 Mio. € zusätzlich; im NOCF wird dieser Betrag abgezogen.
][
*Prüfen:* Nicht der EBK-Bestand (6,5), sondern nur die Änderung (2,5) belastet die Zahlungen dieses Jahres.
]

#aufgabe(titel: "Glasspinnerei: NOCF vor Steuern 2005", art: "rechnen", quelle: "1.14", herkunft: "original", vorlage: "Fallstudie Glasspinnerei, PDF-S. 11–12 (NOCF 2005)")[
#if not web [*Aufgabe 126* #linebreak()]
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

#aufgabe(titel: "Dämmstoffwerk: NOCF vor Steuern (Variante)", art: "rechnen", quelle: "1.14", herkunft: "variante", vorlage: "Fallstudie Glasspinnerei, PDF-S. 11–12 (NOCF 2005)", minuten: 6, ergebnis: [NOCF vor Steuern 32,5 Mio. €])[
#if not web [*Aufgabe 127* #linebreak()]
*Gegeben und Annahmen*

Planjahr eines Dämmstoffwerks, Werte in Mio. €: Nettoumsatz 150, Materialaufwand 45, Löhne und Gehälter 40, sonstige betriebliche Aufwendungen 30 (alles zahlungswirksam), Abschreibungen 12, Zunahme des erweiterten EBK 2,5.

*Gesucht*

#enum(numbering: "a)",
[NOCF vor Steuern.],
[Warum werden die Abschreibungen nicht abgezogen, die EBK-Zunahme aber schon?],
)
#src[Eigene Variante zur NOCF-Rechnung der Fallstudie Glasspinnerei (G, PDF-S. 9 und 11–12); Lernskript 1.14.]
][
*Operativer Überschuss:* $150-45-40-30=35$ Mio. €.
][
*EBK-Korrektur:* $35-"2,5"="32,5"$ Mio. €.
][
*Begründen:* Abschreibungen sind Aufwand ohne Auszahlung, sie gehören nicht in eine Zahlungsrechnung (sie wirken erst über die Steuer). Die EBK-Zunahme dagegen ist Geld, das in Lager und Forderungen gebunden wird und daher die Kasse belastet.
]

#aufgabe(titel: "Glasspinnerei: Sonderabschreibungen", art: "rechnen", quelle: "1.15", herkunft: "original", vorlage: "Fallstudie Glasspinnerei, PDF-S. 4 und 13 (Sonderabschreibung)")[
#if not web [*Aufgabe 128* #linebreak()]
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

#aufgabe(titel: "Dämmstoffwerk: Sonderabschreibung (Variante)", art: "rechnen", quelle: "1.15", herkunft: "variante", vorlage: "Fallstudie Glasspinnerei, PDF-S. 4 und 13 (Sonderabschreibung)", minuten: 6, ergebnis: [Halle 9 Mio. € sofort, danach ca. 0,429 Mio. €/Jahr; Anlagen 6 Mio. € sofort, danach 0,5 Mio. €/Jahr])[
#if not web [*Aufgabe 129* #linebreak()]
*Gegeben und Annahmen*

Ein Dämmstoffwerk investiert in eine Lagerhalle (12 Mio. €, Nutzungsdauer 8 Jahre) und in Anlagen (8 Mio. €, Nutzungsdauer 5 Jahre). Wie in der Fallstudie dürfen 75 % im Anschaffungsjahr abgeschrieben werden; der Rest wird linear über die restliche Nutzungsdauer verteilt.

*Gesucht*

#enum(numbering: "a)",
[Abschreibung im Anschaffungsjahr und jährliche Restabschreibung für beide Investitionen.],
[Vergleiche mit rein linearer Abschreibung im ersten Jahr.],
)
#src[Eigene Variante zur Sonderabschreibung der Fallstudie Glasspinnerei (G, PDF-S. 4 und 13); Lernskript 1.15.]
][
*Halle:* $12 times "0,75"=9$ Mio. € sofort. Rest 3 Mio. € über 7 Jahre: $3/7 approx "0,429"$ Mio. €/Jahr.
][
*Anlagen:* $8 times "0,75"=6$ Mio. € sofort. Rest 2 Mio. € über 4 Jahre: $"0,5"$ Mio. €/Jahr.
][
*Vergleich:* Linear wären es im ersten Jahr $12/8="1,5"$ und $8/5="1,6"$, zusammen 3,1 Mio. € statt 15 Mio. €. Die Sonderabschreibung verschiebt Aufwand (und Steuerersparnis) nach vorn.
][
*Prüfen:* Über die Nutzungsdauer summiert ergibt jede Methode genau die Anschaffungskosten: $9+7 times 3/7=12$ und $6+4 times "0,5"=8$.
]

#aufgabe(titel: "Glasspinnerei: Steuer mit Verlustverrechnung", art: "rechnen", quelle: "1.15", herkunft: "original", vorlage: "Fallstudie Glasspinnerei, PDF-S. 14 (Steuern)")[
#if not web [*Aufgabe 130* #linebreak()]
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

#aufgabe(titel: "Dämmstoffwerk: Steuer nach Verlustvortrag (Variante)", art: "rechnen", quelle: "1.15", herkunft: "variante", vorlage: "Fallstudie Glasspinnerei, PDF-S. 14 (Steuern)", minuten: 6, ergebnis: [Steuer Jahr 2: 4 Mio. €; NOCF nach Steuern 26 Mio. €; Steuer Jahr 3: 9 Mio. €])[
#if not web [*Aufgabe 131* #linebreak()]
*Gegeben und Annahmen*

Ein Dämmstoffwerk hat im Jahr 1 wegen Sonderabschreibungen einen steuerlichen Verlust von 12 Mio. €. Im Jahr 2 beträgt der Gewinn vor Verlustverrechnung 20 Mio. €, im Jahr 3 18 Mio. €. Steuersatz wie im Fall 50 %, unbeschränkter Verlustvortrag. NOCF vor Steuern im Jahr 2: 30 Mio. €.

*Gesucht*

#enum(numbering: "a)",
[Steuerzahlung im Jahr 2 und NOCF nach Steuern.],
[Steuerzahlung im Jahr 3.],
)
#src[Eigene Variante zur Steuerrechnung der Fallstudie Glasspinnerei (G, PDF-S. 14); historische Modellannahme 50 %; Lernskript 1.15.]
][
*Verlust verrechnen:* Steuerbasis Jahr 2 $20-12=8$ Mio. €; Steuer $8 times "0,5"=4$ Mio. €.
][
*NOCF nach Steuern:* $30-4=26$ Mio. €.
][
*Jahr 3:* Der Verlustvortrag ist verbraucht; Steuer $18 times "0,5"=9$ Mio. €.
][
*Prüfen:* Ohne Verlustvortrag hätte das Werk in Jahr 2 schon 10 Mio. € Steuer gezahlt. Der Verlust aus Jahr 1 spart später $12 times "0,5"=6$ Mio. € Steuer.
]

#aufgabe(titel: "Glasspinnerei: Finanzierungssaldo 2005", art: "rechnen", quelle: "1.15", herkunft: "original", vorlage: "Fallstudie Glasspinnerei, PDF-S. 15 (Finanzplan 2005)")[
#if not web [*Aufgabe 132* #linebreak()]
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

#aufgabe(titel: "Dämmstoffwerk: Finanzierungssaldo (Variante)", art: "rechnen", quelle: "1.15", herkunft: "variante", vorlage: "Fallstudie Glasspinnerei, PDF-S. 15 (Finanzplan 2005)", minuten: 6, ergebnis: [Finanzierungslücke 11 Mio. €])[
#if not web [*Aufgabe 133* #linebreak()]
*Gegeben und Annahmen*

Planjahr eines Dämmstoffwerks, Werte in Mio. €: NOCF nach Steuern 32,5; Zinsen auf Altkredite 1,5; Aufnahme eines neuen Bankkredits 10; Investitionsauszahlungen 50; gewünschte Ausschüttung 2. Keine Tilgungen und keine weiteren Zahlungen.

*Gesucht*

#enum(numbering: "a)",
[Vorläufig verfügbare Mittel und Cashflow-Überschuss/-Defizit.],
[Warum ist das Defizit deutlich kleiner als die Investitionssumme?],
)
#src[Eigene Variante zum Finanzplan der Fallstudie Glasspinnerei (G, PDF-S. 9–10 und 15); Lernskript 1.15.]
][
*Vorläufig verfügbare Mittel:* $"32,5"-"1,5"=31$ Mio. €.
][
*Entscheidungen der Periode:* $31+10-50-2=-11$ Mio. €: *Finanzierungslücke 11 Mio. €*.
][
*Deuten:* Die Investition von 50 Mio. € wird zum großen Teil aus dem NOCF (Innenfinanzierung) und dem neuen Kredit gedeckt. Nur die verbleibenden 11 Mio. € müssen zusätzlich beschafft werden, und zwar rechtzeitig in diesem Jahr.
]

#aufgabe(titel: "Negatives Buch-EK und rechtliche Überschuldung", art: "verstehen", quelle: "1.16", herkunft: "eigen")[
#if not web [*Aufgabe 134* #linebreak()]
Ist ein negatives Eigenkapital in der Bilanz automatisch eine rechtliche Überschuldung?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Nein.
- Die Bilanz bewertet zu Buchwerten mit Fortführungsannahme.
- Die rechtliche Überschuldungsprüfung hat eigene Voraussetzungen, z. B. die Fortführungsprognose und eventuelle Rangrücktritte.

#align(center, image("abbildungen/g-planbilanz.svg", width: 75%))
]

#aufgabe(titel: "Glasspinnerei: Bilanzwerte und Gesellschafterdarlehen", art: "rechnen", quelle: "1.16", herkunft: "original", vorlage: "Fallstudie Glasspinnerei, PDF-S. 16–19 (Planbilanz)")[
#if not web [*Aufgabe 135* #linebreak()]
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

#aufgabe(titel: "Dämmstoffwerk: Buchwerte nach Sonderabschreibung (Variante)", art: "rechnen", quelle: "1.16", herkunft: "variante", vorlage: "Fallstudie Glasspinnerei, PDF-S. 16–19 (Planbilanz)", minuten: 6, ergebnis: [Gebäude 21,5 Mio. €; Maschinen 8 Mio. €])[
#if not web [*Aufgabe 136* #linebreak()]
*Gegeben und Annahmen*

Dämmstoffwerk, Werte in Mio. €: Gebäude-Anfangsbuchwert 20, Abschreibung auf bisherige Gebäude 1,5, neuer Gebäudezugang 12 mit 75 % Sofortabschreibung. Maschinen-Anfangsbuchwert 9, Abschreibung auf bisherige Maschinen 3, neuer Maschinenzugang 8 mit 75 % Sofortabschreibung.

*Gesucht*

#enum(numbering: "a)",
[Bilanzwerte von Gebäuden und Maschinen am Jahresende.],
[Warum steigt der Buchwert der Gebäude weniger als die Investition?],
)
#src[Eigene Variante zur Planbilanz der Fallstudie Glasspinnerei (G, PDF-S. 16–17); Lernskript 1.16.]
][
*Gebäude:* $20-"1,5"+12-9="21,5"$ Mio. €.
][
*Maschinen:* $9-3+8-6=8$ Mio. €.
][
*Deuten:* Von 12 Mio. € Gebäudeinvestition werden 9 Mio. € sofort als Aufwand gebucht. Der Buchwert bildet nur noch den Rest ab; das Geld ist trotzdem in voller Höhe abgeflossen.
]

#aufgabe(titel: "Investition strecken: Wirkung 2005", art: "verstehen", quelle: "1.17", herkunft: "eigen")[
#if not web [*Aufgabe 137* #linebreak()]
Im Fall Glasspinnerei werden 2005 nur 80 % der 85 Mio. € Investition gezahlt, der Rest 2006. Um wie viel sinkt der Finanzierungsbedarf 2005, und was ist dabei zu beachten?
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Antwort:* 17 Mio. €. $20 % dot 85 = 17$ Mio. €. Diese Zahlung verschiebt sich nach 2006, dort steigt der Bedarf entsprechend.
][
*Typische Verwechslungen:*
- „68 Mio. €“: 68 Mio. € sind die 80 %, die 2005 noch gezahlt werden. Gefragt ist die Entlastung.
- „23,03 Mio. €“: Das ist die ursprüngliche Finanzierungslücke 2005, nicht die Wirkung der Streckung.
- „0 €, weil die Investition insgesamt gleich bleibt.“: Insgesamt ja, aber der Finanzplan schaut auf die Periode. 2005 fließen 17 Mio. € weniger ab.
]

#aufgabe(titel: "Forderungsquote senken: welche Verbesserung zählt?", art: "verstehen", quelle: "1.17", herkunft: "eigen")[
#if not web [*Aufgabe 138* #linebreak()]
Die Forderungsquote sinkt von 13 % auf 9,5 % des Nettoumsatzes von 270 Mio. €. Gegenüber 2004 werden rund 11,9 Mio. € freigesetzt. Welchen Betrag darf man als zusätzliche Verbesserung gegenüber dem Basisplan ansetzen?
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Antwort:* 9,45 Mio. €. $("0,13" - "0,095") dot 270 = "9,45"$ Mio. €. Nur das ist die Verbesserung gegenüber dem Basisplan.
][
*Typische Verwechslungen:*
- „11,9 Mio. €“: Das ist die Freisetzung gegenüber dem Vorjahr. Ein Teil davon steckt schon im Basisplan und darf nicht doppelt gezählt werden.
- „35,1 Mio. €“: Das sind die vollen 13 % vom Umsatz, also die gesamten Forderungen im Basisplan, nicht die Veränderung.
- „2,5 Mio. €“: Das ist ungefähr die EBK-Freisetzung, die schon im Basisplan enthalten ist.
]

#aufgabe(titel: "Hebel gegen eine Finanzierungslücke", art: "verstehen", quelle: "1.17", herkunft: "eigen")[
#if not web [*Aufgabe 139* #linebreak()]
Mit welchen Hebeln kann man eine Finanzierungslücke verkleinern?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Investitionszahlungen strecken (z. B. 20 % erst im Folgejahr).
- Forderungen abbauen, also Kunden schneller zahlen lassen.
- Überschüssige Kasse über dem operativen Mindestbestand einsetzen.
- Steuerrückzahlung aus Verlustrücktrag.
- Eine Zwischenfinanzierung, wenn die Bank den künftigen Überschüssen vertraut.

#align(center, image("abbildungen/g-forderungen.svg", width: 75%))
]

#aufgabe(titel: "Glasspinnerei: zwei Liquiditätsmaßnahmen", art: "rechnen", quelle: "1.17", herkunft: "original", vorlage: "Fallstudie Glasspinnerei, PDF-S. 20–21 (Maßnahmen gegen das Defizit)")[
#if not web [*Aufgabe 140* #linebreak()]
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

#aufgabe(titel: "Dämmstoffwerk: zwei Liquiditätsmaßnahmen (Variante)", art: "rechnen", quelle: "1.17", herkunft: "variante", vorlage: "Fallstudie Glasspinnerei, PDF-S. 20–21 (Maßnahmen gegen das Defizit)", minuten: 8, ergebnis: [Verbesserung 18 Mio. €; aus 11 Mio. € Lücke werden 7 Mio. € Überschuss])[
#if not web [*Aufgabe 141* #linebreak()]
*Gegeben und Annahmen*

Ein Dämmstoffwerk hat im Planjahr eine Finanzierungslücke von 11 Mio. €. Investitionssumme 50 Mio. €; der Lieferant akzeptiert, dass 30 % erst im Folgejahr gezahlt werden. Außerdem soll der Forderungsbestand von 12 % auf 10 % des Nettoumsatzes von 150 Mio. € sinken (Zahlungsziele kürzen); alles andere bleibt gleich.

*Gesucht*

#enum(numbering: "a)",
[Wirkung beider Maßnahmen auf den Finanzierungsbedarf des Planjahres.],
[Neuer Saldo und mögliche Nachteile der Maßnahmen.],
)
#src[Eigene Variante zu den Maßnahmen a) und b) der Fallstudie Glasspinnerei (G, PDF-S. 20–21); Lernskript 1.17.]
][
*Investition strecken:* $50 times "0,30"=15$ Mio. € fließen erst im Folgejahr ab.
][
*Forderungen senken:* $("0,12"-"0,10") times 150=3$ Mio. € weniger gebunden; das EBK sinkt, der NOCF steigt um 3 Mio. €.
][
*Neuer Saldo:* $-11+15+3=+7$ Mio. €.
][
*Nachteile:* Die 15 Mio. € werden im Folgejahr fällig und müssen dort eingeplant sein. Kürzere Zahlungsziele können Kunden verärgern und Umsatz kosten.
]

#aufgabe(titel: "Glasspinnerei: Schlussfolgerung für den Kreditgeber", art: "verstehen", quelle: "1.18", herkunft: "original", vorlage: "Fallstudie Glasspinnerei, PDF-S. 18–24 (Fazit)")[
#if not web [*Aufgabe 142* #linebreak()]
#text("Formuliere die Schlussfolgerung der Glasspinnerei für einen Kreditgeber. Welche Rolle spielen Sonderabschreibungen, künftiger NOCF, die vorübergehende Finanzierungslücke und ein qualifizierter Rangrücktritt?")
#src[G, PDF-S. 18–24. Verfahren: #stelle(<a-1-18>).]
][
Der Kreditgeber braucht eine Überleitung: Der hohe bilanzielle Verlust stammt im Modell maßgeblich aus Sonderabschreibungen; das Kerngeschäft erwirtschaftet dennoch hohe Zahlungsüberschüsse. Die Lücke 2005 ist bei tragfähigen Annahmen vorübergehend, erfordert aber eine zugesagte Brücke. Ein geeigneter Nachrang kann für die Überschuldungsprüfung Bedeutung haben, ist jedoch keine automatische Löschung der Schuld oder Auffüllung handelsbilanziellen EK. *Prüfung:* Zukünftige Liquidität, Bilanzbild und rechtliche Voraussetzungen müssen gemeinsam erklärt werden.
]

#aufgabe(titel: "Glasspinnerei: Verlust und hoher NOCF", art: "verstehen", quelle: "1.18", herkunft: "eigen", tipp: [Welche große Aufwandsposition ist zahlungslos?])[
#if not web [*Aufgabe 143* #linebreak()]
Wie kann die Glasspinnerei 2005 einen hohen bilanziellen Verlust ausweisen und trotzdem viel Geld aus dem Kerngeschäft (hohen NOCF) erwirtschaften?
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Die hohen Sonderabschreibungen auf die Neuanlagen mindern den Gewinn stark, aber es fließt dafür in dem Jahr kein Geld ab.
- Der NOCF bleibt hoch.
- Verlust und Zahlungsdefizit sind zwei verschiedene Probleme.
][
*Musterantwort:* Kontrollfrage: „Wie kann die Glasspinnerei 2005 einen hohen bilanziellen Verlust ausweisen und trotzdem einen hohen NOCF haben?“ Die Neuanlagen werden 2005 sofort stark abgeschrieben (63,75 Mio. € zusätzlich). Abschreibungen mindern den Gewinn, lassen in dieser Periode aber kein Geld abfließen. Der NOCF misst die Zahlungen aus dem Kerngeschäft (Umsatz minus Material, Löhne, sonstige Aufwendungen, Steuerzahlungen und EBK-Änderung) und enthält keine Abschreibung. Deshalb kann das Kerngeschäft viel Geld bringen, während die GuV einen Verlust zeigt.
]

#aufgabe(titel: "Zwei Probleme der Glasspinnerei", art: "verstehen", quelle: "1.18", herkunft: "eigen")[
#if not web [*Aufgabe 144* #linebreak()]
Die Glasspinnerei hat 2005 zwei getrennte Probleme. Welche sind das, und warum muss man sie getrennt lösen?
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Antwort:* Zutreffend sind:
- Eine Finanzierungslücke von rund 23 Mio. € im Jahr 2005: Das ist das Zahlungsproblem: Investition und Ausschüttung übersteigen die Mittel des Jahres.
- Ein negatives bilanzielles Eigenkapital durch die hohen Sonderabschreibungen: Das ist das Bilanzproblem. Die Sofortabschreibung erzeugt einen Verlustvortrag, der das EK übersteigt.
][
*Typische Verwechslungen:*
- „Ein negativer NOCF im Kerngeschäft“: Das Kerngeschäft ist zahlungsstark. Der NOCF ist nicht das Problem.
- „Ein fehlender Absatzmarkt“: Mit etwa 90 % Marktanteil und 20 % Wachstum fehlt es nicht am Markt.
][
*Erklärung:* Maßnahmen gegen die eine Größe ändern die andere nicht zwangsläufig. Lineare Abschreibung der Gebäude macht das EK positiv, schließt aber die Lücke nicht. Investitionsstreckung schließt die Lücke, ändert am EK wenig.
]

#aufgabe(titel: "Glasspinnerei: lineare statt Sofortabschreibung", art: "rechnen", quelle: "1.18", herkunft: "original", vorlage: "Fallstudie Glasspinnerei, PDF-S. 21–22 (lineare Abschreibung)")[
#if not web [*Aufgabe 145* #linebreak()]
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

#aufgabe(titel: "Dämmstoffwerk: lineare statt Sofortabschreibung (Variante)", art: "rechnen", quelle: "1.18", herkunft: "variante", vorlage: "Fallstudie Glasspinnerei, PDF-S. 21–22 (lineare Abschreibung)", minuten: 6, ergebnis: [Aufwand 7,5 Mio. € geringer; Verlustvortrag 2,5 Mio. €])[
#if not web [*Aufgabe 146* #linebreak()]
*Gegeben und Annahmen*

Ein Dämmstoffwerk hat eine Lagerhalle für 12 Mio. € gekauft (Nutzungsdauer 8 Jahre) und 75 % sofort abgeschrieben. Dadurch weist es einen Verlustvortrag von 10 Mio. € aus, der das bilanzielle Eigenkapital übersteigt. Alternative: Die Halle wird von Beginn an linear abgeschrieben.

*Gesucht*

#enum(numbering: "a)",
[Abschreibung im ersten Jahr bei beiden Methoden und Unterschied.],
[Verlustvortrag bei linearer Abschreibung.],
[Was ändert sich an den Zahlungen des ersten Jahres, was nicht?],
)
#src[Eigene Variante zur Maßnahme a) gegen den bilanziellen Fehlbetrag der Fallstudie Glasspinnerei (G, PDF-S. 22); Lernskript 1.18.]
][
*Abschreibungen:* Sofort $12 times "0,75"=9$ Mio. €, linear $12/8="1,5"$ Mio. €; Unterschied $"7,5"$ Mio. €.
][
*Verlustvortrag:* $10-"7,5"="2,5"$ Mio. €.
][
*Zahlungen:* Die Investitionsauszahlung von 12 Mio. € bleibt gleich. Es ändert sich nur der Zeitpunkt der Steuerersparnis: Mit linearer AfA verschiebt sich der Steuervorteil in spätere Jahre (entgangener Zinsvorteil).
][
*Prüfen:* Ob die bilanzielle Unterdeckung damit verschwindet, hängt vom EK ab; die Insolvenzprüfung nach § 19 InsO ist davon getrennt.
]

#aufgabe(titel: "Annahmen im Ertragswertkurs", art: "verstehen", quelle: "1.19", herkunft: "eigen", tipp: [Frage, welche Zukunftsannahme hinter Gewinn geteilt durch Zinssatz steht.])[
#if not web [*Aufgabe 147* #linebreak()]
Welche Annahmen stecken im Ertragswertkurs der behandelten Aktienaufgabe, und warum ist er damit ein vereinfachtes Modell?
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Der künftig erwartete Jahresgewinn bleibt unbegrenzt konstant und wird durch einen positiven Kalkulationszins geteilt.
- Erst anschließend wird der so vereinfachte Ertragswert auf die Aktien verteilt.
- Das Modell berücksichtigt keine eigene Wachstumsrate und ist keine umfassende Unternehmensbewertung.

#align(center, image("abbildungen/map-aktien.svg", width: 75%))
][
*Antwort:* Kontrollfrage: „Warum ist der Ertragswertkurs der Folienaufgabe ein vereinfachtes Modell?“ Er setzt einen gleichbleibenden künftigen Jahresgewinn ohne Wachstumsrate und einen positiven Kalkulationszins voraus. Gewinn durch Zinssatz kapitalisiert eine unbegrenzte konstante Gewinnreihe.
][
*Typische Verwechslungen:*
- „Er entspricht immer dem Börsenkurs.“: Der Marktpreis kann von einem Modellwert abweichen.
- „Er berücksichtigt automatisch jede künftige Investition und jedes Risiko einzeln.“: Diese umfassende Einzelplanung enthält die einfache Formel nicht.
]

#aufgabe(titel: "Nenner der Gewinnrendite", art: "verstehen", quelle: "1.19", herkunft: "eigen", tipp: [Trenne Marktpreis, Nominalwert und Bilanzkapital.])[
#if not web [*Aufgabe 148* #linebreak()]
Welche Größe steckt im Nenner der Gewinnrendite zum Börsenkurs, und womit darf man sie nicht verwechseln?
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Antwort:* Börsenkurs je Aktie. Gewinn je Aktie wird auf den Marktpreis bezogen.
][
*Typische Verwechslungen:*
- „Bilanzielles Eigenkapital des Unternehmens“: Das wäre bei passendem Gesamtgewinn eine andere Rendite, die JÜ/EK-Rentabilität.
- „Grundkapital je Aktie“: Der Nominalwert ist nicht der Marktpreis.
]

#aufgabe(titel: "13,3 % sind keine EK-Rentabilität", art: "verstehen", quelle: "1.19", herkunft: "eigen", tipp: [Vergleiche zuerst die Nenner beider Formeln.])[
#if not web [*Aufgabe 149* #linebreak()]
Warum dürfen die 13,3 % aus Gewinn je Aktie geteilt durch Börsenkurs nicht ohne Weiteres als JÜ/EK-Rentabilität bezeichnet werden?
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Musterantwort:* Der Börsenkurs ist die Marktpreis-Basis einer Aktie. JÜ/EK bezieht den gesamten Jahresüberschuss auf bilanzielles Eigenkapital. Die Nenner und im konkreten Foliendatensatz sogar die Gewinnangaben sind verschieden.
]

#aufgabe(titel: "Nominalwert, Bilanzkurs und Börsenkurs", art: "verstehen", quelle: "1.19", herkunft: "eigen")[
#if not web [*Aufgabe 150* #linebreak()]
Warum sind Nominalwert, korrigierter Bilanzkurs und Börsenkurs einer Aktie verschiedene Größen?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Der Nominalwert beschreibt den Anteil am Grundkapital.
- Der korrigierte Bilanzkurs verteilt bilanzielles Eigenkapital plus stille Reserven auf die Aktien.
- Der Börsenkurs ist der Marktpreis
- er muss mit keinem der beiden anderen Werte übereinstimmen.

*Merksatz:* Nennwert, Bilanzwert und Marktpreis beantworten verschiedene Fragen.

#align(center, image("abbildungen/map-aktien.svg", width: 75%))
]

#aufgabe(titel: "KGV, Gewinnrendite und EK-Rentabilität", art: "verstehen", quelle: "1.19", herkunft: "eigen")[
#if not web [*Aufgabe 151* #linebreak()]
Was unterscheidet KGV, Gewinnrendite zum Kurs und Eigenkapitalrentabilität?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Das KGV ist Börsenkurs geteilt durch Gewinn je Aktie.
- Sein Kehrwert ist bei passender Periode die Gewinnrendite zum Kurs.
- Eigenkapitalrentabilität setzt dagegen den Jahresüberschuss zum bilanziellen Eigenkapital ins Verhältnis.
- Die Folie benennt die Gewinnrendite ungenau als Eigenkapitalrendite.
]

#aufgabe(titel: "Dividendenrendite und Gewinnrendite", art: "verstehen", quelle: "1.19", herkunft: "eigen")[
#if not web [*Aufgabe 152* #linebreak()]
Warum sind Dividendenrendite und Gewinnrendite nicht dasselbe?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Die Dividendenrendite bezieht die Ausschüttung je Aktie auf den Börsenkurs
- die Gewinnrendite verwendet den Gewinn je Aktie.
- Ein Teil des Gewinns kann im Unternehmen bleiben.
- Beide Kennzahlen erfassen für sich keine spätere Kursänderung.

*Merksatz:* Ausschüttung und erwirtschafteter Gewinn sind nicht dasselbe.
]

#aufgabe(titel: "Vorlesung: fundamentale Aktienkennzahlen", art: "rechnen", quelle: "1.19", herkunft: "original", vorlage: "Vorlesung PDF-S. 28–30, Folien 56–59, Übung Aktienkennzahlen", ergebnis: [Bilanzkurs 2,98 €; Ertragswertkurs 2,90 €; KGV 7,5; Gewinnrendite 13,33 %; Dividendenrendite 2,5 %; Cashflow Ratio 6,62.], tipp: [Erst die Aktienzahl aus Grundkapital und Nominalwert bestimmen. Danach immer fragen: Welche Größe steht im Nenner?])[
#if not web [*Aufgabe 153* #linebreak()]
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

#aufgabe(titel: "Aktienkennzahlen der Donau AG (Variante)", art: "rechnen", quelle: "1.19", herkunft: "variante", vorlage: "Vorlesung PDF-S. 28–30, Folien 56–59, Übung Aktienkennzahlen", minuten: 14, ergebnis: [100.000 Aktien; Bilanzkurs 9,50 €; Ertragswertkurs 7,50 €; KGV 18; Gewinnrendite 5,56 %; Dividendenrendite 2,22 %; Cashflow Ratio 7,5; JÜ/EK 7,69 %])[
#if not web [*Aufgabe 154* #linebreak()]
*Gegeben und Annahmen*

Bilanz der Donau AG in T€: Aktiva: Grundstück 500, Maschinen 300, Umlaufvermögen 400 (Summe 1.200). Passiva: Grundkapital 500, gesetzliche Rücklagen 60, freie Rücklagen 40, Jahresüberschuss 50, Fremdkapital 550 (Summe 1.200). Zusatzangaben: Cashflow 120 T€, stille Reserven 300 T€, durchschnittlicher künftiger Gewinn 60 T€ pro Jahr (konstant, unbegrenzt), Kalkulationszinsfuß 8 %, Nominalwert der Aktie 5 €, Börsenkurs 9,00 €, Dividende je Aktie 0,20 €. Gewinn je Aktie = JÜ / Aktienzahl.

*Gesucht*

#enum(numbering: "a)",
[Aktienzahl, bilanzielles EK und korrigierter Bilanzkurs.],
[Ertragswertkurs, Gewinn je Aktie, KGV und Gewinnrendite zum Kurs.],
[Dividendenrendite und Cashflow Ratio.],
[Eigenkapitalrentabilität (JÜ/EK) und Vergleich mit der Gewinnrendite.],
)
#src[Eigene Variante zur Übung „Fundamentale Aktienkennzahlen“ (V, PDF-S. 28–30, Folien 56–59); Lernskript 1.19.]
][
*Aktienzahl:* $N=500000 thin "€" / 5 thin "€"=100000$ Aktien. Bilanzielles EK $500+60+40+50=650$ T€.
][
*Korrigierter Bilanzkurs:* Korrigiertes EK $650+300=950$ T€, je Aktie $950000/100000="9,50"$ €. Das ist mehr als der Börsenkurs von 9,00 €.
][
*Ertragswertkurs:* Ertragswert $60000/"0,08"=750000$ €, je Aktie $750000/100000="7,50"$ €.
][
*Gewinn je Aktie, KGV, Gewinnrendite:* EPS $50000/100000="0,50"$ €. KGV $"9,00"/"0,50"=18$. Gewinnrendite $"0,50"/"9,00" approx "5,56"%$ (Kehrwert des KGV).
][
*Dividendenrendite und Cashflow Ratio:* $"0,20"/"9,00" approx "2,22"%$. CF je Aktie $120000/100000="1,20"$ €, Cashflow Ratio $"9,00"/"1,20"="7,5"$.
][
*EK-Rentabilität vergleichen:* $50/650 approx "7,69"%$. Sie bezieht den Gewinn auf das bilanzielle EK, die Gewinnrendite (5,56 %) auf den Börsenkurs. Verschiedene Nenner, verschiedene Aussagen.
]

#aufgabe(titel: "Klausur: Kapitalerhöhung der Metall AG", art: "rechnen", quelle: "1.19", herkunft: "original", vorlage: "Altklausur 2017, Aufg. 2", minuten: 10, ergebnis: [GK 40 Mio. €; Kapitalrücklage 60 Mio. €; EK 122 Mio. €; Zufluss 26 Mio. €; Bezugsrecht 0,15 €; Mischkurs 3,05 €], tipp: [Erst die Zahl der jungen Aktien aus dem Bezugsverhältnis bestimmen. Nennwert geht ins Grundkapital, der Aufpreis (Agio) in die Kapitalrücklage.])[
#if not web [*Aufgabe 155* #linebreak()]
*Gegeben und Annahmen*

Die Metall AG hat zum 31.12.2015 folgendes Eigenkapital, das auf Aktien mit dem Nennwert von 1 € entfällt: Grundkapital (gezeichnetes Kapital) 30 Mio. €, Kapitalrücklagen 44 Mio. €, Gewinnrücklagen 22 Mio. €. Zur Finanzierung größerer Investitionen plant die Metall AG 2016 eine Kapitalerhöhung gegen Einlagen mit einem Bezugsverhältnis von 3 : 1 (3 alte Aktien berechtigen zum Bezug von 1 junger Aktie). Die Aktien werden vor der Kapitalerhöhung mit 3,20 € an der Börse gehandelt. Junge Aktien werden zu 2,60 € je Aktie ausgegeben. Kosten der Emission werden vernachlässigt.

*Gesucht* (Werte nach der Kapitalerhöhung, 10 Punkte)

#enum(numbering: "a)",
[Grundkapital (gezeichnetes Kapital)],
[Kapitalrücklagen],
[Eigenkapital],
[Mittelzufluss aus der Kapitalerhöhung],
[Rechnerischer Wert des Bezugsrechts],
[Rechnerischer Kurs der Aktien nach der Kapitalerhöhung (Mischkurs)],
)
#src[K, PDF-S. 3 (Klausurseite 7). Das Thema Kapitalerhöhung und Bezugsrecht gehört zu Kapitel C der Vorlesung (Eigenfinanzierung), das im Lernskript noch nicht ausgearbeitet ist; Abschnitt 1.19 liefert Grundkapital, Nennwert und Aktienzahl. Eigene Lösung; die handschriftlichen Antworten im Scan sind falsch und werden nicht übernommen.]
][
*Aktienzahlen bestimmen:* Alte Aktien $N_"alt"=30 thin "Mio. €" / 1 thin "€"=30$ Mio. Stück. Bei 3 : 1 kommen $30/3=10$ Mio. junge Aktien hinzu.
][
*a) Grundkapital:* Jede junge Aktie erhöht das Grundkapital um ihren Nennwert: $30+10 times 1=40$ Mio. €.
][
*b) Kapitalrücklagen:* Der Betrag über dem Nennwert (Agio) geht in die Kapitalrücklage: $("2,60"-"1,00") times 10$ Mio. $=16$ Mio. €; neu $44+16=60$ Mio. €.
][
*c) Eigenkapital:* $40+60+22=122$ Mio. €. Kontrolle: altes EK $30+44+22=96$ Mio. € plus Zufluss 26 Mio. € = 122 Mio. €. Die Gewinnrücklagen bleiben unverändert.
][
*d) Mittelzufluss:* $10$ Mio. Aktien $times "2,60"$ € $=26$ Mio. € (= Erhöhung GK 10 + Agio 16).
][
*e) Bezugsrecht:* $B=(K_"alt"-K_"neu")/(m/n+1)=("3,20"-"2,60")/(3/1+1)="0,60"/4="0,15"$ €. Nicht einfach 3,20 − 2,60 = 0,60 €: Der Kursvorteil der jungen Aktie verteilt sich auf die drei alten Aktien, die man für eine junge braucht, und die junge selbst.
][
*f) Mischkurs:* $(3 times "3,20"+1 times "2,60")/4="12,20"/4="3,05"$ €. Kontrolle: $"3,20"-"0,15"="3,05"$ €. Nicht der einfache Durchschnitt (2,90 €), denn es gibt dreimal so viele alte wie junge Aktien.
]

#aufgabe(titel: "Kapitalerhöhung der Holz AG (Variante)", art: "rechnen", quelle: "1.19", herkunft: "variante", vorlage: "Altklausur 2017, Aufg. 2", minuten: 10, ergebnis: [GK 25 Mio. €; Kapitalrücklage 25 Mio. €; EK 60 Mio. €; Zufluss 15 Mio. €; Bezugsrecht 0,30 €; Mischkurs 4,20 €])[
#if not web [*Aufgabe 156* #linebreak()]
*Gegeben und Annahmen*

Die Holz AG hat Aktien mit einem Nennwert von 1 €. Eigenkapital vor der Kapitalerhöhung: Grundkapital 20 Mio. €, Kapitalrücklagen 15 Mio. €, Gewinnrücklagen 10 Mio. €. Geplant ist eine Kapitalerhöhung gegen Einlagen im Bezugsverhältnis 4 : 1. Börsenkurs vor der Erhöhung 4,50 €, Ausgabekurs der jungen Aktien 3,00 €. Keine Emissionskosten.

*Gesucht*

#enum(numbering: "a)",
[Grundkapital, Kapitalrücklagen und Eigenkapital nach der Kapitalerhöhung.],
[Mittelzufluss.],
[Rechnerischer Wert des Bezugsrechts und Mischkurs.],
[Zeige, dass ein Altaktionär mit 4 Aktien durch die Kapitalerhöhung nichts verliert, wenn er sein Bezugsrecht verkauft.],
)
#src[Eigene Variante zu Altklausur 2017, Aufgabe 2 (K, PDF-S. 3).]
][
*Junge Aktien:* $20 "Mio. alte Aktien" \/ 4 = 5$ Mio. junge Aktien.
][
*Bilanzpositionen:* GK $20+5=25$ Mio. €. Agio $("3,00"-"1,00") times 5=10$ Mio. €, Kapitalrücklagen $15+10=25$ Mio. €. EK $25+25+10=60$ Mio. € (vorher 45 Mio. € plus 15 Mio. € Zufluss).
][
*Zufluss:* $5$ Mio. $times "3,00"$ € $=15$ Mio. €.
][
*Bezugsrecht und Mischkurs:* $B=("4,50"-"3,00")/(4+1)="0,30"$ €. Mischkurs $(4 times "4,50"+"3,00")/5="4,20"$ € $="4,50"-"0,30"$.
][
*Vermögen des Altaktionärs prüfen:* Vorher $4 times "4,50"=18$ €. Nachher 4 Aktien zu 4,20 € $="16,80"$ € plus Verkauf von 4 Bezugsrechten zu 0,30 € $="1,20"$ €, zusammen 18 €. Das Bezugsrecht gleicht den Kursverlust genau aus (Verwässerungsschutz).
]

#aufgabe(titel: "Kurzfristige statt langfristiger Schulden", art: "verstehen", quelle: "1.20", herkunft: "eigen", tipp: [Setze die Veränderung nur im kurzfristigen Fremdkapital ein.])[
#if not web [*Aufgabe 157* #linebreak()]
Wie wirkt der Ersatz langfristiger Schulden durch gleich hohe kurzfristige Schulden bei unverändertem Umlaufvermögen auf das Working Capital? Begründe.
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Antwort:* Es sinkt. WC ist UV minus kurzfristiges FK; der abzuziehende Betrag steigt.
][
*Typische Verwechslungen:*
- „Es steigt.“: Das Vorzeichen des kurzfristigen FK ist negativ.
- „Es bleibt zwingend gleich, weil das gesamte FK gleich bleibt.“: Die Fristigkeit ist gerade Teil der Definition.
]

#aufgabe(titel: "Kapitalbindungsdauer definieren", art: "verstehen", quelle: "1.20", herkunft: "eigen", tipp: [Zeichne Auszahlung und Kundeneingang auf einer Zeitachse.])[
#if not web [*Aufgabe 158* #linebreak()]
Von wann bis wann reicht die Kapitalbindungsdauer einer Kostenart? Wie wirkt ein längeres Lieferantenziel auf die Materialbindung?
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Antwort:* Sie reicht vom tatsächlichen Auszahlungstag der jeweiligen Kostenart bis zur Kundenzahlung. Deshalb können Löhne und Material verschiedene Dauern haben.
][
*Typische Verwechslungen:*
- „Sie ist für alle Kosten gleich der Fertigungszeit.“: Lager, Debitorenfrist und Auszahlungstermin fehlen dann.
- „Ein längeres Lieferantenziel verlängert immer die Materialbindung.“: Eine spätere Materialzahlung verkürzt unter den Modellannahmen die Zeit bis zur Kundenzahlung.
]

#aufgabe(titel: "Hohes Working Capital, trotzdem Zahlungslücke", art: "verstehen", quelle: "1.20", herkunft: "eigen", tipp: [Frage, ob das Umlaufvermögen schon Geld ist.])[
#if not web [*Aufgabe 159* #linebreak()]
Warum kann ein hohes Working Capital trotzdem mit einer Zahlungslücke morgen zusammenfallen?
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Musterantwort:* Es ist ein Bilanzsaldo und kann in Vorräten oder noch unbezahlten Forderungen stecken. Ob morgen gezahlt werden kann, hängt von tatsächlichen verfügbaren Mitteln und Fälligkeiten ab.
]

#aufgabe(titel: "Was misst Working Capital?", art: "verstehen", quelle: "1.20", herkunft: "eigen")[
#if not web [*Aufgabe 160* #linebreak()]
Was misst Working Capital in dieser Vorlesung?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- *Working Capital:* Umlaufvermögen minus kurzfristiges Fremdkapital.
- Ein Bestandsbetrag am Bilanzstichtag, kein reiner Kontostand.
- Bei vollständiger Bilanzgliederung: langfristiges Kapital minus Anlagevermögen.
- Zeigt damit den langfristig finanzierten Teil des Umlaufvermögens.

#align(center, image("abbildungen/map-working-capital.svg", width: 75%))
]

#aufgabe(titel: "Working Capital und EBK unterscheiden", art: "verstehen", quelle: "1.20", herkunft: "eigen")[
#if not web [*Aufgabe 161* #linebreak()]
Warum sind Working Capital und das EBK der Glasspinnerei nicht automatisch gleich?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Working Capital zieht das gesamte kurzfristige Fremdkapital vom Umlaufvermögen ab.
- Das EBK grenzt dagegen bestimmte operative Bindungen und Finanzierungsbeiträge ab
- die Fallstudie erweitert diese um bestimmte Rückstellungen.
- Nur gleiche Begriffe mit gleicher Abgrenzung dürften gleichgesetzt werden.
]

#aufgabe(titel: "Zielkonflikt beim Working Capital", art: "verstehen", quelle: "1.20", herkunft: "eigen")[
#if not web [*Aufgabe 162* #linebreak()]
Welchen Zielkonflikt zeigt die Finanzierung des Working Capitals?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Ein langfristig finanzierter Puffer kann das Anschlussfinanzierungsrisiko mindern.
- Wenn kurzfristige Schulden wie in der Folie günstiger sind, kann ihr höherer Anteil Zinskosten sparen, aber den Puffer verkleinern.
- Die unterstellte Zinsrelation ist kein allgemeines Marktgesetz.

#align(center, image("abbildungen/map-working-capital.svg", width: 75%))
]

#aufgabe(titel: "Eigene Bindungsdauer je Kostenart", art: "verstehen", quelle: "1.20", herkunft: "eigen")[
#if not web [*Aufgabe 163* #linebreak()]
Warum braucht jede Kostenart eine eigene Kapitalbindungsdauer?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Geld wird erst ab ihrer tatsächlichen Auszahlung vorfinanziert und bleibt bis zur Kundenzahlung gebunden.
- Material kann wegen des Lieferantenziels später bezahlt werden als unmittelbar fällige Gemeinkosten.
- Gleiche Jahreskosten können daher verschieden viel Kapitalbedarf erzeugen.

*Merksatz:* Vorfinanzierung beginnt bei Auszahlung und endet bei Kundenzahlung.

#align(center, image("abbildungen/kapitalbindung-zeit.svg", width: 75%))
]

#aufgabe(titel: "Vorlesung: maximaler Kapitalbedarf des Umlaufvermögens", art: "rechnen", quelle: "1.20", herkunft: "original", vorlage: "Vorlesung PDF-S. 31–32, Folien 61–63, Aufgabe", ergebnis: [341.250 €], tipp: [Zeichne den Tag der Kundenzahlung und ziehe für jede Kostenart ihren Auszahlungstag ab.])[
#if not web [*Aufgabe 164* #linebreak()]
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

#aufgabe(titel: "Kapitalbedarf des Umlaufvermögens eines Möbelherstellers (Variante)", art: "rechnen", quelle: "1.20", herkunft: "variante", vorlage: "Vorlesung PDF-S. 31–32, Folien 61–63, Aufgabe", minuten: 15, ergebnis: [339.000 €])[
#if not web [*Aufgabe 165* #linebreak()]
*Gegeben und Annahmen*

Ein Möbelhersteller mit beschaffungssynchroner Fertigung hat einen Umsatz von 2,16 Mio. €/Jahr. Anteil der Kosten am Umsatz: Material 35 %, Löhne 30 %, Herstellgemeinkosten (HGK) 10 %, Verwaltungs- und Vertriebsgemeinkosten (VVGK) 5 %. Das Material wird bei Produktionsbeginn geliefert und nach 30 Tagen bezahlt (Kreditorenfrist). Löhne fallen durchschnittlich 10 Tage nach Produktionsbeginn an, HGK unmittelbar bei Produktionsbeginn, VVGK 40 Tage nach Produktionsbeginn. Fertigungszeit 40 Tage, Lagerdauer der Enderzeugnisse 20 Tage, Debitorenfrist 30 Tage. Gleichmäßige Tagesausgaben, Rechenjahr 360 Tage.

*Gesucht*

#enum(numbering: "a)",
[Wann zahlt der Kunde (Tage nach Produktionsbeginn)? Bindungsdauer jeder Kostenart.],
[Tagesausgaben je Kostenart und maximaler Kapitalbedarf für das Umlaufvermögen.],
)
#src[Eigene Variante zur Aufgabe auf V, PDF-S. 31–32 (Folien 61–63); Lernskript 1.20.]
][
*Zeitachse:* Kundenzahlung nach $40+20+30=90$ Tagen.
][
*Bindungsdauern:* Kapital ist gebunden vom Tag der Auszahlung bis zur Kundenzahlung. Material $90-30=60$ Tage; Löhne $90-10=80$ Tage; HGK $90-0=90$ Tage; VVGK $90-40=50$ Tage.
][
*Tagesausgaben:* Material $2160000 times "0,35"/360=2100$ €/Tag; Löhne $2160000 times "0,30"/360=1800$ €/Tag; HGK $2160000 times "0,10"/360=600$ €/Tag; VVGK $2160000 times "0,05"/360=300$ €/Tag.
][
*Kapitalbedarf:* $2100 times 60+1800 times 80+600 times 90+300 times 50=126000+144000+54000+15000=339000$ €.
][
*Prüfen:* Einheit €/Tag × Tage = €. Die übrigen 20 % des Umsatzes sind Gewinn und binden kein Kapital. Ein längeres Lieferantenziel würde nur die Materialbindung verkürzen.
]

#aufgabe(titel: "Vorlesung: Finanzplan als Primärplan", art: "verstehen", quelle: "1.21", herkunft: "original", vorlage: "Vorlesung PDF-S. 32, Folie 64, Übungsaufgabe 1")[
#if not web [*Aufgabe 166* #linebreak()]
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

#aufgabe(titel: "Vorlesung: Funktionen finanzwirtschaftlicher Kennzahlen", art: "verstehen", quelle: "1.21", herkunft: "original", vorlage: "Vorlesung PDF-S. 36, Folie 72, Übungsaufgabe 4")[
#if not web [*Aufgabe 167* #linebreak()]
Wofür können Rentabilität, Liquidität, Verschuldungsgrad und Anlagendeckung verwendet werden? Nenne mindestens fünf Funktionen und erläutere eine Grenze ihrer Aussagekraft.
#src[V, PDF-S. 36–37, Folien 72–73; N28, PDF-S. 10–11, Übungsaufgabe 4.]
][
*Funktionen benennen:* Zielvorgaben/Führung, Soll-Ist-Kontrolle, Zeitvergleich, Branchenvergleich, Konkurrenzanalyse, Analyse von Kapitalstruktur und Kapitalbedarf. Standardisierte Definitionen vereinfachen die Kontrolle.
][
*Vergleich begründen:* Eine Abweichung zeigt einen Prüfbedarf. Erst konsistente Bezugsgrößen und die Untersuchung ihrer Ursachen erlauben eine belastbare Bewertung.
][
*Grenze erklären:* Bestandsquoten zeigen keine vollständigen künftigen Fälligkeiten. Ein hoher Liquiditätsgrad kann trotz unbezahlter Vorräte/Forderungen mit einem zeitlichen Engpass zusammenfallen. Für die Zahlungstermine braucht man den Finanzplan.
]

#aufgabe(titel: "Vorlesung: Aussagekraft und Grenzen des Cashflows", art: "verstehen", quelle: "1.21", herkunft: "original", vorlage: "Vorlesung PDF-S. 39, Folie 77, Übungsaufgabe 6")[
#if not web [*Aufgabe 168* #linebreak()]
Erkläre, was der betriebliche Cashflow über Innenfinanzierung aussagt, warum er den Gewinn ergänzt und welche Grenzen seine Verwendung hat.
#src[V, PDF-S. 39, Folien 77–78; N28, PDF-S. 13, Übungsaufgabe 6.]
][
*Zahlungskraft erklären:* Der operative Cashflow beschreibt Mittel aus der betrieblichen Tätigkeit. Er hilft einzuschätzen, ob das Unternehmen Investitionen, Tilgungen und Ausschüttungen aus dem Geschäft tragen kann.
][
*Gewinn ergänzen:* Abschreibungen und Rückstellungsänderungen können Erfolg und Zahlung auseinanderfallen lassen. Die indirekte Rechnung korrigiert passende Unterschiede; eine Abschreibung erzeugt selbst keine Einzahlung.
][
*Grenzen nennen:* Abgrenzung und vollständige Informationen sind nötig; gerade nicht börsennotierte Unternehmen veröffentlichen sie oft nicht vollständig. Fälligkeiten, Investitionsbedarf und Risiken sind zusätzlich zu prüfen. Ein Kredit-Cashflow ist kein selbst erwirtschafteter operativer Überschuss.
]

#aufgabe(titel: "Wann wird der Finanzplan zum Primärplan?", art: "verstehen", quelle: "1.21", herkunft: "eigen", tipp: [Welcher Bereich begrenzt die anderen?])[
#if not web [*Aufgabe 169* #linebreak()]
Wann wird der Finanzplan zum Primärplan?
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Wenn die Beschaffung von Finanzierung zum Engpass wird.
- Dann bestimmt der finanzierbare Rahmen, was Absatz, Produktion und Investition überhaupt vorsehen können.
- Der knappste Bereich begrenzt das Gesamtprogramm.

#align(center, image("abbildungen/map-finanzkontrolle.svg", width: 75%))
][
*Antwort:* Kontrollfrage: „Wann wird der Finanzplan zum Primärplan?“ Wenn die Finanzbeschaffung den möglichen Umfang der übrigen Teilpläne begrenzt. Der finanzielle Engpass setzt dann den Rahmen.
][
*Typische Verwechslungen:*
- „Sobald der Jahresgewinn positiv ist.“: Gewinn bedeutet weder automatisch ausreichende Liquidität noch einen Engpass.
- „Nur wenn keine Produktionsplanung vorhanden ist.“: Die Pläne bleiben bestehen und müssen an den finanzierbaren Rahmen angepasst werden.
]

#aufgabe(titel: "Einkauf auf Kredit ist keine Auszahlung", art: "verstehen", quelle: "1.21.1", herkunft: "eigen", tipp: [Trenne Beschaffung und Bankbewegung.])[
#if not web [*Aufgabe 170* #linebreak()]
Warum ist ein Einkauf auf Kredit keine sofortige Auszahlung?
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Zunächst entsteht eine Verbindlichkeit
- das Geld bleibt bis zur Bezahlung auf dem Konto.
- Die spätere Zahlung vermindert dann Geld und Verbindlichkeit.
- Wer Beschaffung, Aufwand und Zahlung zusammenzählt, kann denselben Vorgang mehrfach erfassen.
][
*Antwort:* Kontrollfrage: „Warum darf ein Wareneinkauf auf Kredit nicht sofort als Auszahlung verbucht werden?“ Zunächst entsteht eine Verbindlichkeit; Geld fließt erst bei Zahlung ab. Beschaffung und Bezahlung sind verschiedene Zeitpunkte.
][
*Typische Verwechslungen:*
- „Weil Wareneinkäufe niemals Geld kosten.“: Die spätere Bezahlung ist sehr wohl eine Auszahlung.
- „Weil eine Verbindlichkeit immer einen Ertrag erzeugt.“: Die Schuldentstehung ist kein Verkaufserlös.
]

#aufgabe(titel: "Nettomonetäres UV und Kassenbestand", art: "verstehen", quelle: "1.21.1", herkunft: "eigen")[
#if not web [*Aufgabe 171* #linebreak()]
Was unterscheidet nettomonetäres Umlaufvermögen vom Kassenbestand?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Nettomonetäres Umlaufvermögen umfasst liquide Mittel plus kurzfristige Forderungen minus kurzfristige Verbindlichkeiten.
- Der Kassen- bzw. Zahlungsmittelbestand umfasst die Forderungen und Verbindlichkeiten nicht.
- Für die erweiterte Bestandsgröße müssen ihre vollständigen Bestände bekannt sein.
]

#aufgabe(titel: "Vorlesung: Quartalsplan und Zahlungsbegriffe", art: "rechnen", quelle: "1.21.1", herkunft: "original", vorlage: "Vorlesung PDF-S. 35, Folie 69, Übungsaufgabe 3", ergebnis: [Folienrechnung: Ende 315 / 170 / −645 T€. Eigene reine Zahlungsvariante: 915 / 1.390 / 1.475 T€. Nettomonetäres UV aus den Angaben nicht eindeutig bestimmt.])[
#if not web [*Aufgabe 172* #linebreak()]
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

#aufgabe(titel: "Quartalsplan eines Händlers (Variante)", art: "rechnen", quelle: "1.21.1", herkunft: "variante", vorlage: "Vorlesung PDF-S. 35, Folie 69, Übungsaufgabe 3", minuten: 12, ergebnis: [Salden +160 / −40 / −100 T€; Bestände 210 / 170 / 70 T€])[
#if not web [*Aufgabe 173* #linebreak()]
*Gegeben und Annahmen*

Ein Händler plant drei Quartale, alle Werte in T€, Anfangsbestand an liquiden Mitteln 50. Die Tabelle nennt:
#tab(columns: (2.2fr,1fr,1fr,1fr), th([Zeile],[Q1],[Q2],[Q3]),
[Barverkäufe],[300],[250],[200],
[Eingänge von Kundenforderungen],[400],[350],[300],
[Zinserträge (gutgeschrieben)],[20],[20],[20],
[Barlöhne],[120],[120],[130],
[Miete (bezahlt)],[30],[30],[30],
[Wareneinkauf auf Ziel (Rechnung noch offen)],[450],[400],[500],
[Bezahlte Lieferantenrechnungen],[400],[500],[450],
[Zinsen (bezahlt)],[10],[10],[10],
)

*Gesucht*

#enum(numbering: "a)",
[Stelle den Liquiditätsplan auf: Einzahlungen, Auszahlungen, Saldo und Bestand je Quartal.],
[Welche Zeile gehört nicht in den Liquiditätsplan, und welchen Fehler würde man machen, wenn man sie mitzählt?],
[Ab wann wird eine Finanzierungsmaßnahme nötig, wenn der Bestand nie unter 100 T€ fallen soll?],
)
#src[Eigene Variante zu Übungsaufgabe 3 (V, PDF-S. 35–36, Folien 69–71); Lernskript 1.21.1.]
][
*Einzahlungen:* Q1 $300+400+20=720$; Q2 $250+350+20=620$; Q3 $200+300+20=520$ T€.
][
*Auszahlungen:* Nur echte Geldabflüsse: Q1 $120+30+400+10=560$; Q2 $120+30+500+10=660$; Q3 $130+30+450+10=620$ T€.
][
*Saldo und Bestand:* Salden $+160$, $-40$, $-100$. Bestände $50+160=210$, $210-40=170$, $170-100=70$ T€.
][
*Falsche Zeile:* Der Wareneinkauf auf Ziel ist noch nicht bezahlt; er erhöht die Verbindlichkeiten, nicht die Auszahlungen. Bezahlt wird er erst über die Zeile „Bezahlte Lieferantenrechnungen“. Wer ihn mitzählt, rechnet den Einkauf doppelt und erhält z. B. in Q1 einen Saldo von $720-1010=-290$ T€.
][
*Mindestbestand:* Q1 und Q2 liegen über 100 T€; in Q3 fehlen $100-70=30$ T€. Die Maßnahme (z. B. Kreditlinie, späteres Zahlungsziel) muss vor dem dritten Quartal vereinbart sein.
]

#aufgabe(titel: "Sanitärfall: Durchschnittskapital", art: "verstehen", quelle: "1.21.2", herkunft: "eigen", tipp: [Jahresstrom und Stichtagsbestand sind verschiedene Bezugsebenen.])[
#if not web [*Aufgabe 174* #linebreak()]
Warum nutzt die Sanitärgeschäft-Aufgabe für die Rentabilität durchschnittliches Kapital, für die EK-Quote aber den Stichtagswert?
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Ein Jahresgewinn fällt über die Periode an, während das Endkapital bereits den ganzen Gewinn enthält.
- Unter der ausdrücklichen Annahme gleichmäßigen Gewinnanfalls wird nur der halbe Gewinnanteil im durchschnittlich eingesetzten Kapital berücksichtigt.
- Andere Änderungen des Kapitals wären gesondert zu erfassen.
][
*Musterantwort:* Kontrollfrage: „Warum braucht die Sanitärlösung für ihre Rentabilität andere Kapitalwerte als für ihre Stichtags-EK-Quote?“ Die Rentabilität bezieht einen Jahresgewinn auf das durchschnittlich eingesetzte Kapital. Die Folie unterstellt gleichmäßigen Gewinnanfall und setzt daher nur den halben Gewinnanteil im Durchschnitt an. Die EK-Quote verwendet dagegen den ganzen EK-Endbestand zum Bilanzstichtag.
]

#aufgabe(titel: "Netto-GK-Rentabilität ist keine Leverage-Gesamtrendite", art: "verstehen", quelle: "1.21.2", herkunft: "eigen")[
#if not web [*Aufgabe 175* #linebreak()]
Warum ist die Netto-Gesamtkapitalrentabilität der Sanitärlösung keine Leverage-Gesamtrendite?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Die Nettozahl der Folie verwendet den Gewinn nach Zinsen im Zähler.
- Für die Leverage-Gesamtrendite wird dagegen der Gewinn vor Fremdkapitalzinsen benötigt.
- Ohne die Zinsangabe kann man die zweite Größe nicht aus der ersten herauslesen.
]

#aufgabe(titel: "Vorlesung: Darlehen für das Sanitärgeschäft beurteilen", art: "rechnen", quelle: "1.21.2", herkunft: "original", vorlage: "Vorlesung PDF-S. 37, Folie 74, Übungsaufgabe 5", ergebnis: [EK-Rentabilität 8,61 %, Netto-GK 5,65 %; L1/L2/L3 226,32 / 236,84 / 710,53 %; EK-Quote 66,56 %; AD I/II 83,85 / 122,31 %.])[
#if not web [*Aufgabe 176* #linebreak()]
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

#aufgabe(titel: "Liquiditätsgrade berechnen", art: "rechnen", quelle: "1.9", herkunft: "variante", vorlage: "Vorlesung PDF-S. 37, Folie 74, Übungsaufgabe 5")[
#if not web [*Aufgabe 177* #linebreak()]
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

#aufgabe(titel: "Kennzahlen-Check", art: "rechnen", quelle: "1.10", herkunft: "variante", vorlage: "Vorlesung PDF-S. 37, Folie 74, Übungsaufgabe 5")[
#if not web [*Aufgabe 178* #linebreak()]
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

#aufgabe(titel: "EK-Quote und goldene Bilanzregel", art: "rechnen", quelle: "1.10", herkunft: "variante", vorlage: "Vorlesung PDF-S. 37, Folie 74, Übungsaufgabe 5")[
#if not web [*Aufgabe 179* #linebreak()]
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

#aufgabe(titel: "Liquiditätsgrade beurteilen", art: "rechnen", quelle: "1.9", herkunft: "variante", vorlage: "Vorlesung PDF-S. 37, Folie 74, Übungsaufgabe 5")[
#if not web [*Aufgabe 180* #linebreak()]
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

#aufgabe(titel: "Bilanzanalyse mit allen Kennzahlen", art: "rechnen", quelle: "1.10", herkunft: "variante", vorlage: "Vorlesung PDF-S. 37, Folie 74, Übungsaufgabe 5")[
#if not web [*Aufgabe 181* #linebreak()]
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

#aufgabe(titel: "Finanzielle Lage vollständig beurteilen", art: "rechnen", quelle: "1.10", herkunft: "variante", vorlage: "Vorlesung PDF-S. 37, Folie 74, Übungsaufgabe 5")[
#if not web [*Aufgabe 182* #linebreak()]
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

#aufgabe(titel: "Darlehen für einen Malerbetrieb beurteilen (Variante)", art: "rechnen", quelle: "1.21.2", herkunft: "variante", vorlage: "Vorlesung PDF-S. 37, Folie 74, Übungsaufgabe 5", minuten: 18, ergebnis: [EK-Rentabilität 10,91 %, Netto-GK 6,19 %; L1/L2/L3 91,67 / 133,33 / 183,33 %; EK-Quote 58 %; AD I/II 74,36 / 112,82 %])[
#if not web [*Aufgabe 183* #linebreak()]
*Gegeben und Annahmen*

Eine Bekannte bittet dich um ein Darlehen von 20.000 € für ihren Malerbetrieb. Bilanz zum 31.12. in €: Aktiva: Werkstatt 60.000, Fahrzeuge 18.000, Materiallager 6.000, Forderungen (Debitoren) 5.000, Kasse 1.000, Bank 10.000 (Summe 100.000). Passiva: gezeichnetes Kapital 40.000, Rücklagen 12.000, Gewinnvortrag 6.000, kurzfristiger Bankkredit 4.000, langfristiger Bankkredit 30.000, Lieferantenkredit 8.000 (Summe 100.000). Annahmen wie in der Vorlesungslösung: Der Gewinnvortrag ist der Jahresgewinn, er ist gleichmäßig über das Jahr entstanden; alle anderen Positionen waren das ganze Jahr unverändert.

*Gesucht*

#enum(numbering: "a)",
[EK-Rentabilität und Netto-Gesamtkapitalrentabilität auf Basis des durchschnittlichen Kapitals.],
[Liquidität 1.–3. Grades, Eigenfinanzierungsgrad (EK-Quote), Anlagendeckungsgrad I und II.],
[Würdest du das Darlehen gewähren? Was würdest du außer der Bilanz noch prüfen?],
)
#src[Eigene Variante zu Übungsaufgabe 5 (V, PDF-S. 37–38, Folien 74–76); Lernskript 1.10, 1.21.2.]
][
*Gliedern:* EK $40000+12000+6000=58000$ €; AV $60000+18000=78000$ €; UV $6000+5000+1000+10000=22000$ €; kurzfristiges FK $4000+8000=12000$ €; langfristiges FK 30.000 €.
][
*Durchschnittskapital:* Der Gewinn wächst im Jahr von 0 auf 6.000 €, im Mittel 3.000 €. Mittleres EK $52000+3000=55000$ €, mittleres GK $94000+3000=97000$ €.
][
*Rentabilitäten:* EK $6000/55000 approx "10,91"%$; Netto-GK $6000/97000 approx "6,19"%$ (ohne Zinsaufwand, wie in der Vorlesungslösung).
][
*Liquidität:* Flüssige Mittel $1000+10000=11000$ €. L1 $11000/12000 approx "91,67"%$; L2 $16000/12000 approx "133,33"%$; L3 $22000/12000 approx "183,33"%$.
][
*Struktur:* EK-Quote $58000/100000=58%$. AD I $58000/78000 approx "74,36"%$; AD II $(58000+30000)/78000 approx "112,82"%$: goldene Bilanzregel erfüllt.
][
*Urteil:* Solide EK-Quote, AV langfristig gedeckt, L2 über 100 %; L3 knapp unter dem Folienziel 200 %, L1 deutlich über 30 % (viel ungenutztes Geld). Ein Darlehen erscheint vertretbar, z. B. gesichert über die Werkstatt. Zusätzlich prüfen: Auftragslage, Kreditwürdigkeit der Person, Branchen- und Baukonjunktur, künftiger Finanzplan mit Zins und Tilgung.
]


#kapitel("Kapitel 2 · Fremdfinanzierung")

#aufgabe(titel: "Gläubigerrisiko trotz festem Zahlungsanspruch", art: "verstehen", quelle: "2.1", herkunft: "eigen")[
#if not web [*Aufgabe 184* #linebreak()]
Eine Bank vereinbart feste Zins- und Tilgungszahlungen. Warum besteht trotzdem Risiko? Erkläre Informationsasymmetrie, spätere Entscheidungen des Schuldners und eine unerwartete Veränderung des Umfelds.
#src[V, PDF-S. 40–41, Folien 80–82; eigene Erklärfrage.]
][
*Anspruch und Erfüllung trennen:* Der Vertrag begründet die Pflicht. Ob genügend Mittel zur Erfüllung entstehen, ist eine wirtschaftliche Frage.
][
*Information prüfen:* Der Schuldner kennt sein Geschäft oft genauer. Der Gläubiger kann Einzahlungen überschätzen oder bereits bestehende weitere Kredite übersehen.
][
*Nachträgliche Veränderungen erklären:* Riskante Investitionen, zusätzliche Verschuldung und Ausschüttungen können den Puffer verkleinern; ein unerwarteter Markteinbruch kann beide Seiten überraschen. Deshalb werden Unternehmen, Märkte und Gesamtwirtschaft beurteilt.
][
*Ergänzung aus der Karteikarte „Warum besteht trotz fest vereinbarter Zins- und Tilgungsansprüche ein Gläubigerrisiko?“:*
- Der Vertrag begründet die Pflicht, aber das Unternehmen muss die nötigen Mittel erst erwirtschaften.
- Informationen können fehlen, Schuldnerentscheidungen können das Risiko erhöhen und das Umfeld kann sich unerwartet ändern.
- Ein fester Anspruch ist deshalb keine garantierte Erfüllung.

*Merksatz:* Ein Anspruch ist noch keine sichere Zahlung.

#align(center, image("abbildungen/map-glaeubigerrisiko.svg", width: 75%))
][
*Antwort:* Kontrollfrage: „Welche Vorgänge können das Risiko eines bestehenden Gläubigers nachträglich erhöhen?“ Zutreffend sind:
- Zusätzliche Verschuldung und Ausschüttung vorhandener Mittel: Mehr Ansprüche und weniger Puffer können die Rückzahlung gefährden.
- Unerwarteter Einbruch des Absatzmarkts: Dadurch können erwartete Einzahlungen ausfallen.
][
*Typische Verwechslungen:*
- „Der bloße Fortbestand des vertraglichen Rückzahlungsanspruchs garantiert Risikofreiheit.“: Ein Anspruch garantiert keine tatsächliche Erfüllung.
]

#aufgabe(titel: "Drei Informationsbereiche des Gläubigers", art: "verstehen", quelle: "2.1", herkunft: "eigen", tipp: [Denke vom einzelnen Betrieb nach außen.])[
#if not web [*Aufgabe 185* #linebreak()]
Welche drei Informationsbereiche untersucht der Gläubiger laut Vorlesung?
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Musterantwort:* Unternehmen und Schuldner einschließlich Liquiditätslage, die Märkte des Unternehmens und die gesamtwirtschaftliche Entwicklung. Sie ergänzen sich, weil ein gutes Einzelunternehmen ebenfalls von Markt- und Umfeldrisiken betroffen sein kann.
]

#aufgabe(titel: "Informationsasymmetrie im Kreditverhältnis", art: "verstehen", quelle: "2.1", herkunft: "eigen")[
#if not web [*Aufgabe 186* #linebreak()]
Was bedeutet Informationsasymmetrie im Kreditverhältnis?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Die beiden Vertragsseiten haben unterschiedlich viele oder unterschiedlich genaue Informationen.
- Der Schuldner kennt sein Geschäft häufig besser als der Gläubiger.
- Deshalb prüft die Bank Unternehmensdaten, Markt und Gesamtwirtschaft
- ein Restrisiko bleibt.
]

#aufgabe(titel: "Begriffslandkarte Kapitel 2", art: "verstehen", quelle: "2.1", herkunft: "eigen")[
#if not web [*Aufgabe 187* #linebreak()]
Zeichne die Begriffslandkarte zu Kapitel 2 aus dem Kopf: Welche Begriffe gehören dazu und wie hängen sie zusammen?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- *Finanzierungsbedarf → Kreditverhältnis:* feste Ansprüche und Risiken der Gläubiger.
- *Bonität, Sicherheiten, Rating:* Risiken einschätzen; Bankkapital beeinflusst die Kreditvergabe.
- *Vertrag:* Betrag, Tilgung, Zins, Laufzeit, Sicherheiten und Covenants.
- *Zinstage und Zinstermine:* Zahlungen vergleichbar machen.
- *Rückführung:* Tilgung, Kündigung und mögliche Vorfälligkeitsentschädigung.
- *Altklausur:* verbindet Tilgungsformen, Disagio und Sicherheitenbegriffe.
]

#aufgabe(titel: "Kreditfähigkeit und Kreditwürdigkeit prüfen", art: "verstehen", quelle: "2.2", herkunft: "eigen")[
#if not web [*Aufgabe 188* #linebreak()]
Ein Betrieb legt eine gute Bilanz und eine Halle als Sicherheit vor. Reicht das für eine Kreditentscheidung? Trenne Kreditfähigkeit, persönliche und wirtschaftliche Kreditwürdigkeit und Sicherheit; nenne passende Unterlagen.
#src[V, PDF-S. 42–43, Folien 83–86; eigene Erklärfrage.]
][
*Kreditfähigkeit prüfen:* Kann der Antragsteller wirksam handeln, und ist die handelnde Person vertretungsbefugt? Dafür können Handelsregister und Gesellschaftsvertrag wichtig sein.
][
*Kreditwürdigkeit prüfen:* Persönlich zählen Verlässlichkeit und bisheriges Zahlungsverhalten; wirtschaftlich zählen künftige Erträge, Cashflow, Finanzplan, Auftragsbestand und Markt. Ein Jahresabschluss beschreibt die Vergangenheit und ersetzt den künftigen Schuldendienstplan nicht.
][
*Sicherheit ergänzen:* Wert und Rang der Halle sowie bestehende Belastungen prüfen. Eine Sicherheit begrenzt möglichen Verlust, garantiert aber weder rechtliche Wirksamkeit des Vertrags noch laufende Zins-/Tilgungszahlungen. § 18 KWG nicht pauschal ohne seine Voraussetzungen auf jeden Fall übertragen.
][
*Ergänzung aus der Karteikarte „Was unterscheidet Kreditfähigkeit und Kreditwürdigkeit?“:*
- Kreditfähigkeit fragt nach dem wirksamen Vertragsschluss und den nötigen Befugnissen.
- Kreditwürdigkeit fragt nach persönlicher Verlässlichkeit und wirtschaftlicher Zahlungskraft.
- Jemand kann einen Vertrag wirksam schließen und trotzdem eine schlechte Rückzahlungsprognose haben.

*Merksatz:* Kreditfähig: Vertrag können. Kreditwürdig: Rückzahlung zutrauen.

#align(center, image("abbildungen/map-bonitaet.svg", width: 75%))
][
*Antwort:* Kontrollfrage: „Was prüft die Kreditfähigkeit?“ Ob ein Kreditvertrag rechtswirksam geschlossen werden kann. Vertretung und Befugnisse gehören dazu.
][
*Typische Verwechslungen:*
- „Nur ob der Jahresgewinn hoch ist.“: Das gehört eher zur wirtschaftlichen Kreditwürdigkeit.
- „Nur ob ein Grundstück vorhanden ist.“: Das ist eine mögliche Sicherheit und ersetzt die Fähigkeit zum Vertragsschluss nicht.
]

#aufgabe(titel: "Gute Bilanz reicht der Bank nicht", art: "verstehen", quelle: "2.2", herkunft: "eigen", tipp: [Wann müssen die vertraglichen Zahlungen geleistet werden?])[
#if not web [*Aufgabe 189* #linebreak()]
Warum prüft eine Bank trotz guter Bilanz auch Aufträge und künftige Finanzpläne?
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Musterantwort:* Die Bilanz zeigt eine vergangene Stichtagslage. Aufträge und Finanzpläne helfen einzuschätzen, ob bei den künftigen Fälligkeiten Geld für Zins und Tilgung entsteht. Wirtschaftliche Kreditwürdigkeit braucht diese Zukunftssicht.
]

#aufgabe(titel: "Sicherheit ersetzt keine Bonitätsprüfung", art: "verstehen", quelle: "2.2", herkunft: "eigen")[
#if not web [*Aufgabe 190* #linebreak()]
Warum ersetzt eine werthaltige Sicherheit keine wirtschaftliche Bonitätsprüfung?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Die Sicherheit kann im Sicherungsfall zusätzlichen Rückgriff ermöglichen.
- Sie zeigt aber nicht, ob laufend genug Geld für Zins und Tilgung entsteht.
- Außerdem sind Wert, Rang und Verwertbarkeit selbst zu prüfen.

*Merksatz:* Sicherheit ersetzt keine laufende Zahlungsfähigkeit.
]

#aufgabe(titel: "Rating und Basel-Quoten richtig vergleichen", art: "verstehen", quelle: "2.3", herkunft: "eigen")[
#if not web [*Aufgabe 191* #linebreak()]
Unterscheide internes und externes Rating. Warum kann man 7 % hartes Kernkapital, 10,5 % Gesamtkapital und 3 % Leverage Ratio nicht als drei vergleichbare Unternehmens-EK-Quoten lesen?
#src[V, PDF-S. 43–44 und 49, Folien 85–88 und 97; Präzisierungen nach den Primärquellen in Abschnitt 2.3.]
][
*Urheber unterscheiden:* Intern bewertet die Bank ihren Kunden; extern bewertet eine Agentur Schuldner-/Emittentenrisiken. Eine gute Note ist keine Garantie, und die Skalen verschiedener Agenturen sind nicht wortgleich.
][
*Risikogewichtete Quoten erklären:* Im einfachen Basel-III-Schema ergeben 4,5 % Mindest-CET1 plus 2,5 % Kapitalerhaltungspuffer 7 %; 8 % Mindestgesamtkapital plus derselbe Puffer ergeben 10,5 %. Nenner sind RWA.
][
*Leverage Ratio abgrenzen:* Kernkapital geteilt durch die nicht risikogewichtete Gesamtrisikopositionsmessgröße, mindestens 3 %. Andere Kapitaldefinition und anderer Nenner als EK/Bilanzsumme eines Unternehmens; außerdem gibt es in der Praxis weitere Anforderungen.
]

#aufgabe(titel: "Bank-Leverage-Ratio und Verschuldungsgrad", art: "verstehen", quelle: "2.3", herkunft: "eigen", tipp: [Vergleiche Zähler und Nenner, bevor Du Prozentwerte vergleichst.])[
#if not web [*Aufgabe 192* #linebreak()]
Was misst die Leverage Ratio einer Bank, und warum ist sie etwas anderes als der Verschuldungsgrad eines Unternehmens?
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Die Bank-Leverage-Ratio setzt Kernkapital zu einer nicht risikogewichteten Gesamtrisikopositionsmessgröße ins Verhältnis.
- Der Unternehmens-Verschuldungsgrad lautet dagegen Fremdkapital geteilt durch Eigenkapital.
- Auch die risikogewichteten Basel-Kapitalquoten haben wieder einen anderen Nenner.
][
*Antwort:* Kontrollfrage: „Welche Aussage über die Bank-Leverage-Ratio stimmt?“ Sie verwendet einen nicht risikogewichteten Nenner und ergänzt die risikogewichteten Kapitalquoten. Deshalb ist sie nicht direkt mit 7 % oder 10,5 % auf RWA vergleichbar.
][
*Typische Verwechslungen:*
- „Sie ist Fremdkapital geteilt durch Eigenkapital des kreditnehmenden Unternehmens.“: Das ist der Unternehmens-Verschuldungsgrad.
- „Sie ist eine garantierte Eigenkapitalrendite der Bank.“: Die Quote ist eine Kapital-/Risikopositionsrelation, keine Rendite.
]

#aufgabe(titel: "8-%-Unterlegung bei 150 % Risikogewicht", art: "verstehen", quelle: "2.3", herkunft: "eigen", tipp: [150 Prozent als Faktor 1,5 einsetzen.])[
#if not web [*Aufgabe 193* #linebreak()]
Eine Bank vergibt im vereinfachten Folienmodell 100 Mio. € Kredit bei 150 % Risikogewicht. Wie hoch ist die 8-%-Unterlegung? Begründe den Rechenweg.
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Antwort:* 12 Mio. €. 100 Mio. × 1,5 × 0,08 = 12 Mio. €.
][
*Typische Verwechslungen:*
- „8 Mio. €“: Dabei wurde das Risikogewicht von 150 % übergangen.
- „150 Mio. €“: Das ist der risikogewichtete Betrag vor Anwendung der 8 %.
]

#aufgabe(titel: "Internes und externes Rating", art: "verstehen", quelle: "2.3", herkunft: "eigen")[
#if not web [*Aufgabe 194* #linebreak()]
Was unterscheidet internes und externes Rating?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Intern beurteilt die kreditgebende Bank ihren Kunden.
- Extern beurteilt eine Ratingagentur einen Schuldner oder Emittenten.
- Die Noten verdichten Kreditrisiken
- sie sind weder eine Garantie noch bei allen Agenturen gleich bezeichnet.

#align(center, image("abbildungen/map-rating.svg", width: 75%))
]

#aufgabe(titel: "Kredit auf der Aktivseite der Bank", art: "verstehen", quelle: "2.3", herkunft: "eigen")[
#if not web [*Aufgabe 195* #linebreak()]
Warum steht ein Unternehmenskredit auf der Aktivseite der Bank?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Für den Kunden ist der Kredit eine Schuld, für die Bank ist er eine Forderung auf künftige Zahlungen.
- Das Bank-Eigenkapital steht auf der Passivseite als Verlustpuffer.
- Eine Eigenkapitalunterlegung ist keine zusätzliche Eigenkapitaleinlage beim Kunden.

*Merksatz:* Kundenschuld ist Bankforderung.
]

#aufgabe(titel: "Höheres Risikogewicht, mehr Bank-EK", art: "verstehen", quelle: "2.3", herkunft: "eigen")[
#if not web [*Aufgabe 196* #linebreak()]
Wie verändert ein höheres Risikogewicht den Kapitalbedarf der Bank im Folienmodell?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Bei gleichem Kredit steigt die erforderliche Unterlegung, weil die Bank 8 Prozent des risikogewichteten Betrags vorhalten soll.
- Bei fest verfügbarem Bank-Eigenkapital sinkt das rechnerisch mögliche Kreditvolumen.
- Das gilt innerhalb des vereinfachten Modells ohne weitere bindende Anforderungen.
]

#aufgabe(titel: "Vorlesung: Basel-II-Unterlegung und Kreditvolumen", art: "rechnen", quelle: "2.3", herkunft: "original", vorlage: "Vorlesung PDF-S. 44, Folie 87, Übung Basel II", ergebnis: [12 Mio. € Unterlegung; 31,25 Mrd. € rechnerisches Kreditvolumen.])[
#if not web [*Aufgabe 197* #linebreak()]
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

#aufgabe(titel: "Basel-Unterlegung für einen Mittelstandskredit (Variante)", art: "rechnen", quelle: "2.3", herkunft: "variante", vorlage: "Vorlesung PDF-S. 44, Folie 87, Übung Basel II", minuten: 6, ergebnis: [3 Mio. € Unterlegung; 25 Mrd. € Kreditvolumen])[
#if not web [*Aufgabe 198* #linebreak()]
*Gegeben und Annahmen*

Eine Regionalbank hat Eigenkapital von 1,2 Mrd. €. Sie vergibt einem Mittelständler einen Kredit über 50 Mio. € mit einem Risikogewicht von 75 %. Vereinfachtes Folienmodell: Unterlegung = Kreditbetrag × 8 % × Risikogewicht; keine Puffer oder weiteren Grenzen.

*Gesucht*

#enum(numbering: "a)",
[Wie viel Eigenkapital muss die Bank für diesen Kredit unterlegen?],
[Welches Kreditvolumen kann sie insgesamt vergeben, wenn das durchschnittliche Risikogewicht 60 % beträgt?],
[Wie ändert sich a), wenn sich das Rating des Kunden verschlechtert und das Risikogewicht auf 150 % steigt?],
)
#src[Eigene Variante zur Basel-II-Übung (V, PDF-S. 44, Folie 87); Lernskript 2.3.]
][
*Risikogewichtete Aktiva:* $50 times "0,75"="37,5"$ Mio. €.
][
*Unterlegung:* $"37,5" times "0,08"=3$ Mio. € (6 % des Nominalkredits).
][
*Volumen:* $"1,2"/("0,08" times "0,6")="1,2"/"0,048"=25$ Mrd. €. Kontrolle: $25 times "0,6" times "0,08"="1,2"$.
][
*Schlechteres Rating:* $50 times "1,5" times "0,08"=6$ Mio. €: doppelt so viel Eigenkapital. Darum verlangt die Bank bei schlechter Bonität höhere Zinsen oder lehnt ab.
]

#aufgabe(titel: "Länder-Ratings und Anleiherenditen", art: "verstehen", quelle: "2.4", herkunft: "eigen", tipp: [Eine Note und ein Marktpreis entstehen auf verschiedene Weise.])[
#if not web [*Aufgabe 199* #linebreak()]
Warum sind die historischen Länder-Ratings und die Anleiherenditen keine identischen Größen?
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Musterantwort:* Ein Rating ist eine verdichtete Einschätzung des Kreditrisikos. Die Marktrendite folgt aus Preis und Zahlungsansprüchen der Anleihe und kann auch von anderen Marktbedingungen beeinflusst werden. Eine historische Korrelation ist keine feste zeitlose Umrechnung.
]

#aufgabe(titel: "Kreditverluste und Finanzierung anderer Unternehmen", art: "verstehen", quelle: "2.4", herkunft: "eigen")[
#if not web [*Aufgabe 200* #linebreak()]
Wie können Kreditverluste die Finanzierung anderer Unternehmen erschweren?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Verluste und Wertberichtigungen schwächen das Bankkapital.
- Unsicherheit über die Lage anderer Banken kann das Vertrauen und die Refinanzierung beeinträchtigen.
- Dann kann die Kreditvergabe eingeschränkt oder teurer werden, auch für andere Unternehmen.

#align(center, image("abbildungen/krisen-kette.svg", width: 75%))
]

#aufgabe(titel: "Staatsschuldenquote richtig lesen", art: "verstehen", quelle: "2.4", herkunft: "eigen")[
#if not web [*Aufgabe 201* #linebreak()]
Warum ist eine höhere Staatsschuldenquote nicht allein ein Beweis für neue Schulden?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Die Quote setzt den Schuldenbestand zum Bruttoinlandsprodukt ins Verhältnis.
- Sie kann durch höhere Schulden steigen, aber auch durch einen Rückgang des Bruttoinlandsprodukts.
- Deshalb müssen Zähler und Nenner getrennt betrachtet werden.

*Merksatz:* Eine Quote steigt durch größeren Zähler oder kleineren Nenner.
]

#aufgabe(titel: "Krisenmechanismus und Anleihekauf erklären", art: "verstehen", quelle: "2.4.1", herkunft: "eigen")[
#if not web [*Aufgabe 202* #linebreak()]
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

#aufgabe(titel: "Anleihekauf der Notenbank: Wer erhält das Geld?", art: "verstehen", quelle: "2.4.1", herkunft: "eigen", tipp: [Zeichne das erste und das zweite Geschäft getrennt.])[
#if not web [*Aufgabe 203* #linebreak()]
Wer erhält bei einem Staatsanleihekauf der Notenbank am Sekundärmarkt das Geld?
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Der bisherige Inhaber erhält den Kaufpreis, über die Bankabwicklung.
- Der Staat erhielt Geld bei der früheren Ausgabe der Anleihe.
- Diese beiden Geschäfte müssen getrennt werden
- beim späteren Ankauf entsteht Zentralbankgeld, aber kein unmittelbarer Emissionserlös des Staates.

#align(center, image("abbildungen/anleihekauf-schema.svg", width: 75%))
][
*Antwort:* Kontrollfrage: „Wer erhält den Kaufpreis, wenn die Notenbank eine bestehende Staatsanleihe am Sekundärmarkt kauft?“ Der bisherige Inhaber über die Bankabwicklung. Die Emission ist bereits erfolgt; der jetzige Verkäufer bekommt den Gegenwert.
][
*Typische Verwechslungen:*
- „Zwingend der Staat als Erlös einer neuen Anleihe“: Das verwechselt Emission und späteren Handel.
- „Niemand, weil nur der Börsenkurs steigt“: Es gibt eine tatsächliche Kaufpreiszahlung gegen Übertragung des Wertpapiers.
]

#aufgabe(titel: "Kreditvertrag mit Covenants gestalten", art: "verstehen", quelle: "2.5", herkunft: "eigen")[
#if not web [*Aufgabe 204* #linebreak()]
Nenne die sechs verhandlungsrelevanten Merkmalsgruppen des Kreditvertrags. Erkläre anschließend an einem selbst formulierten Covenant den Zweck, die Berichtspflicht, eine mögliche Folge eines Verstoßes und den Nachteil für den Schuldner.
#src[V, PDF-S. 53–54, Folien 105–108; eigene Anwendung.]
][
*Vertragsgruppen nennen:* Auszahlungs-/Rückzahlungsbetrag, Tilgungsstruktur, Zinssatz einschließlich Terminen/Bindung, Laufzeit, Sicherheiten und sonstige Vereinbarungen.
][
*Covenant formulieren:* Eigener Fall ohne zusätzliche Zahlen: Der Schuldner muss ein positives Net Working Capital halten und nach vereinbarter Definition regelmäßig darüber berichten. Zweck ist ein rechtzeitig sichtbarer Mindestpuffer.
][
*Folgen und Grenze erklären:* Bei Verstoß greifen die vereinbarten Neuverhandlungen, Anpassungen oder Sanktionen. Das kann Zinsanpassung oder Fälligstellung umfassen, ist aber kein automatischer Insolvenzbeweis. Der Schuldner verliert Entscheidungsspielraum, beispielsweise für Ausschüttung oder weitere Verschuldung.
]

#aufgabe(titel: "Covenants: Schutz und Preis", art: "verstehen", quelle: "2.5", herkunft: "eigen", tipp: [Denke an Risikobegrenzung während der Laufzeit.])[
#if not web [*Aufgabe 205* #linebreak()]
Wie schützen Covenants den Gläubiger, und welchen Preis zahlt der Schuldner dafür?
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Sie begrenzen bestimmte Finanzierungs-, Investitions- oder Ausschüttungsentscheidungen und verlangen Berichte über die Einhaltung.
- So kann eine Risikoerhöhung früh sichtbar werden und vertragliche Folgen auslösen.
- Gleichzeitig verliert der Schuldner Entscheidungsspielraum
- ein Verstoß ist nicht automatisch eine Insolvenz.
][
*Antwort:* Kontrollfrage: „Welche Funktion hat ein Covenant im Kreditvertrag?“ Risikoänderungen durch Grenzen und Berichtspflichten früh sichtbar machen und begrenzen. Dazu können Verschuldungs-, Ausschüttungs- oder Investitionsgrenzen vereinbart werden.
][
*Typische Verwechslungen:*
- „Dem Kreditnehmer immer gesellschaftsrechtliche Stimmrechte in der Bank geben“: Covenants sind Nebenbedingungen des Kredits, keine Beteiligungsrechte.
- „Jeden Verstoß automatisch mit Insolvenz gleichsetzen“: Die vertraglichen Folgen und die wirtschaftliche Lage sind gesondert zu prüfen.
]

#aufgabe(titel: "Zinsbindungsfrist und Gesamtlaufzeit", art: "verstehen", quelle: "2.5", herkunft: "eigen", tipp: [Frage, ob das Darlehen am Ende der Zinsbindung schon vollständig getilgt ist.])[
#if not web [*Aufgabe 206* #linebreak()]
Warum sind Zinsbindungsfrist und Gesamtlaufzeit nicht automatisch gleich?
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Musterantwort:* Der feste Zins kann nur für einen Teil der gesamten Rückzahlungsdauer gelten. Danach muss der Zinssatz neu vereinbart oder nach Vertragsregeln angepasst werden, obwohl noch Restschuld besteht.
]

#aufgabe(titel: "Sechs Merkmalsgruppen des Kreditvertrags", art: "verstehen", quelle: "2.5", herkunft: "eigen")[
#if not web [*Aufgabe 207* #linebreak()]
Welche sechs Merkmalsgruppen bestimmen einen Kreditvertrag?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Auszahlungs- und Rückzahlungsbetrag, Tilgungsstruktur, Zinsbedingungen, Laufzeit, Sicherheiten und sonstige Vereinbarungen.
- Zinsbindung ist dabei nicht automatisch die gesamte Laufzeit.
- Ein Nominalzins allein beschreibt die Belastung noch nicht vollständig.

#align(center, image("abbildungen/map-kreditvertrag.svg", width: 75%))
]

#aufgabe(titel: "Zinstagemethode und Zinsbetrag", art: "verstehen", quelle: "2.6", herkunft: "eigen", tipp: [Vergleiche die beiden Brüche bei gleichem Zähler.])[
#if not web [*Aufgabe 208* #linebreak()]
Warum beeinflusst die Zinstagemethode den Zinsbetrag bei gleichen Kalenderdaten? Erkläre insbesondere, warum actual/360 bei denselben 352 Tagen mehr Zins ergibt als actual/365.
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Sie bestimmt sowohl die Zahl der angesetzten Zinstage als auch die Jahresbasis.
- 30-Tage-Methoden und tatsächliche Kalendertage können andere Zähler liefern
- 360, 365 oder die tatsächliche Jahreslänge andere Nenner.
- Beides muss zur vereinbarten Konvention passen.

#align(center, image("abbildungen/map-zinszeit.svg", width: 75%))
][
*Antwort:* Kontrollfrage: „Warum ergibt actual/360 bei denselben 352 tatsächlichen Tagen mehr Zins als actual/365?“ Der kleinere Nenner erzeugt einen größeren Jahresbruchteil. 352/360 ist größer als 352/365.
][
*Typische Verwechslungen:*
- „Weil actual/360 mehr Kalendertage zählt.“: Der Zähler ist in beiden Fällen 352.
- „Weil der Nominalzins automatisch erhöht wird.“: Der Jahreszinssatz bleibt gleich; der Zeitbruchteil ändert sich.
]

#aufgabe(titel: "30/360 und 30E/360 im Dezember-Endfall", art: "verstehen", quelle: "2.6", herkunft: "eigen", tipp: [Die Differenz entsteht an der Monatsendregel.])[
#if not web [*Aufgabe 209* #linebreak()]
Warum liefern 30/360 und 30E/360 im behandelten Dezember-Endfall verschiedene Zinstage?
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Musterantwort:* Die konkret gezeigten Varianten behandeln den 31.12. unterschiedlich. 30E/360 setzt ihn auf den 30., die andere Variante belässt ihn hier beim 31. Deshalb ist der Zähler um einen Tag verschieden.
]

#aufgabe(titel: "Vorlesung: Zinstage 14.01.–31.12.2016", art: "rechnen", quelle: "2.6", herkunft: "original", vorlage: "Vorlesung PDF-S. 55, Folie 109, Beispiel Zinstage", ergebnis: [Endkapital: 2.057,83 / 2.057,67 / 2.057,86 / 2.058,67 / 2.057,70 € in der Reihenfolge a).])[
#if not web [*Aufgabe 210* #linebreak()]
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

#aufgabe(titel: "Zinstage 01.03.–31.08.2017 (Variante)", art: "rechnen", quelle: "2.6", herkunft: "variante", vorlage: "Vorlesung PDF-S. 55, Folie 109, Beispiel Zinstage", minuten: 12, ergebnis: [Endkapital 30/360: 5.050,00 €; 30E/360: 5.049,72 €; act/365: 5.050,14 €; act/360: 5.050,83 €; act/act: 5.050,14 €])[
#if not web [*Aufgabe 211* #linebreak()]
*Gegeben und Annahmen*

Du legst 5.000 € vom 01.03.2017 bis zum 31.08.2017 zu einem einfachen Jahreszins von 2 % an. 2017 ist kein Schaltjahr. Anfangstag nicht mitzählen, Endtag mitzählen. Konventionen wie in der Vorlesungslösung: 30E/360 setzt einen 31. immer auf den 30.; die verwendete 30/360-Variante setzt den Endtag 31 nur dann auf 30, wenn der Anfangstag 30 oder 31 ist. Kein Zinseszins.

*Gesucht*

#enum(numbering: "a)",
[Zinstage und Jahresbruchteil nach 30/360, 30E/360, actual/365, actual/360 und actual/actual.],
[Zinsbetrag und Endkapital je Methode, auf Cent gerundet.],
)
#src[Eigene Variante zum Zinstage-Beispiel (V, PDF-S. 55, Folien 109–110); Lernskript 2.6.]
][
*Grundformel:* $Z=K_0 i t/B$ mit $K_0 i=5000 times "0,02"=100$ € Zins für ein volles Jahr.
][
*30-Tage-Methoden:* 30E/360: Endtag 31 → 30: $30 times (8-3)+(30-1)=179$ Tage. 30/360: Anfangstag 1 ist nicht 30/31, also bleibt der Endtag 31: $30 times 5+(31-1)=180$ Tage.
][
*Tatsächliche Tage:* März 30 (2.–31.), April 30, Mai 31, Juni 30, Juli 31, August 31: $30+30+31+30+31+31=183$ Tage.
][
*Zinsen:*
#tab(columns: (1.5fr,1fr,1fr,1fr), th([Methode],[Bruchteil],[Zins €],[Ende €]),
[30/360],[$180/360$],[50,00],[5.050,00],
[30E/360],[$179/360$],[49,72],[5.049,72],
[actual/365],[$183/365$],[50,14],[5.050,14],
[actual/360],[$183/360$],[50,83],[5.050,83],
[actual/actual],[$183/365$],[50,14],[5.050,14],)
][
*Prüfen:* actual/actual ist in einem Nicht-Schaltjahr gleich actual/365. actual/360 liefert den höchsten Zins, weil 183 tatsächliche Tage durch nur 360 geteilt werden.
]

#aufgabe(titel: "Vom Monatszins zum effektiven Jahreszins", art: "verstehen", quelle: "2.7", herkunft: "eigen", tipp: [Zinsfaktor ist 1 plus Periodenzins.])[
#if not web [*Aufgabe 212* #linebreak()]
Warum darf man einen Monatszins nicht einfach mit zwölf multiplizieren? Wie wird bei Wiederanlage daraus der effektive Jahreszins?
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Bleiben die monatlich gutgeschriebenen Zinsen angelegt, werden sie später selbst verzinst.
- Dann ergibt sich der Jahresfaktor aus zwölf multiplizierten Monatsfaktoren.
- Zwölfmal Monatszins ignoriert diesen Zinseszins.

*Merksatz:* Wiederangelegte Zinsen verdienen selbst Zinsen.

#align(center, image("abbildungen/zinsfaktoren.svg", width: 75%))
][
*Bild:* Schneeballbild: Nicht nur der Startbetrag wächst, auch das bereits Hinzugekommene wächst mit.
][
*Antwort:* Kontrollfrage: „Wie wird bei Wiederanlage aus einem Monatszins der effektive Jahreszins?“ Zwölf Monatsfaktoren multiplizieren und anschließend 1 abziehen. Jeder Faktor verzinst auch zuvor gutgeschriebene Zinsen.
][
*Typische Verwechslungen:*
- „Immer nur Monatszins mal zwölf“: Das ignoriert den Zinseszins der monatlichen Gutschriften.
- „Jahreszins durch zwölf teilen und dann vergleichen“: Gesucht ist die Umrechnung vom Monat zum Jahr, nicht umgekehrt.
]

#aufgabe(titel: "Einjahresvergleich über drei Jahre", art: "verstehen", quelle: "2.7", herkunft: "eigen", tipp: [Was passiert, wenn der Zinssatz nur bis zur nächsten Gutschrift garantiert ist?])[
#if not web [*Aufgabe 213* #linebreak()]
Wann bleibt die bessere Einjahresanlage auch über drei Jahre besser?
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Wenn die verglichenen positiven Jahresfaktoren unverändert gelten und die Zinsen wiederangelegt werden.
- Dann wird jeder Faktor hoch drei genommen und die Reihenfolge bleibt gleich.
- Bei veränderlichen Zinsen oder anderen Kosten muss neu verglichen werden.
][
*Musterantwort:* Kontrollfrage: „Welche Annahme ist nötig, damit die bessere Einjahresanlage auch über drei Jahre besser bleibt?“ Die positiven Jahresfaktoren müssen unverändert gelten, die Zinsen werden wiederangelegt und keine weiteren Unterschiede wie Gebühren kommen hinzu. Bei veränderlichen Zinssätzen muss der gesamte neue Zahlungsweg verglichen werden.
]

#aufgabe(titel: "Vorlesung: jährliche und monatliche Zinsgutschrift", art: "rechnen", quelle: "2.7", herkunft: "original", vorlage: "Vorlesung PDF-S. 56, Folie 111, Beispiel Zinstermine", ergebnis: [Angebot 2: etwa 3,0108 % effektiver Jahreszins; unter den Annahmen für ein und drei Jahre etwas besser.])[
#if not web [*Aufgabe 214* #linebreak()]
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

#aufgabe(titel: "Vierteljährliche gegen jährliche Zinsgutschrift (Variante)", art: "rechnen", quelle: "2.7", herkunft: "variante", vorlage: "Vorlesung PDF-S. 56, Folie 111, Beispiel Zinstermine", minuten: 8, ergebnis: [Angebot B effektiv ca. 2,381 % < 2,4 %; Angebot A ist für 1 und 3 Jahre besser])[
#if not web [*Aufgabe 215* #linebreak()]
*Gegeben und Annahmen*

Clara kann Geld anlegen: Angebot A: 2,4 % Zinsen jährlich. Angebot B: 0,59 % Zinsen pro Quartal, die jeweils gutgeschrieben und mitverzinst werden. Zinssätze bleiben unverändert, keine Gebühren und Steuern.

*Gesucht*

#enum(numbering: "a)",
[Effektiver Jahreszins von Angebot B. Welches Angebot ist für ein Jahr besser?],
[Ändert sich die Entscheidung bei einer Anlage über drei Jahre? Begründe mit den Faktoren.],
[Warum ist der Vergleich „4 × 0,59 % = 2,36 % < 2,4 %“ hier zwar im Ergebnis richtig, aber methodisch falsch?],
)
#src[Eigene Variante zum Zinstermine-Beispiel (V, PDF-S. 56, Folien 111–112); Lernskript 2.7.]
][
*Jahresfaktor B:* $"1,0059"^4 approx "1,023810"$, effektiv ca. 2,381 %. A hat den Faktor 1,024. *A ist besser.*
][
*Drei Jahre:* A $"1,024"^3 approx "1,073742"$; B $"1,0059"^12 approx "1,073143"$. A bleibt besser, weil der größere Jahresfaktor auch hoch drei größer bleibt (gleiche, unveränderte Zinssätze vorausgesetzt).
][
*Methode:* Einfaches Multiplizieren mit 4 ignoriert den Zinseszins innerhalb des Jahres. Richtig ist das Potenzieren des Quartalsfaktors. Hier ist B selbst mit Zinseszins (2,381 %) schlechter, im Vorlesungsbeispiel war es umgekehrt.
]

#aufgabe(titel: "Darlehenspflichten und passende Kündigungsregel", art: "verstehen", quelle: "2.8", herkunft: "eigen")[
#if not web [*Aufgabe 216* #linebreak()]
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

#aufgabe(titel: "Start des Zehnjahres-Kündigungsrechts", art: "verstehen", quelle: "2.8", herkunft: "eigen", tipp: [Suche das gesetzliche Ereignis für den Fristbeginn.])[
#if not web [*Aufgabe 217* #linebreak()]
Woran knüpft § 489 das Zehnjahres-Kündigungsrecht an, und warum ist der Unterschriftstag nicht automatisch der richtige Start?
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- § 489 knüpft grundsätzlich an den vollständigen Empfang des Darlehens an.
- Eine spätere neue Vereinbarung über Rückzahlung oder Sollzins kann den maßgeblichen Zeitpunkt ersetzen.
- Danach ist zusätzlich die Kündigungsfrist einzuhalten.
][
*Antwort:* Kontrollfrage: „Woran knüpft § 489 das Zehnjahres-Kündigungsrecht grundsätzlich an?“ An den vollständigen Empfang des Darlehens; eine relevante spätere Neuvereinbarung kann den Zeitpunkt ersetzen. Danach kommt noch die Kündigungsfrist von sechs Monaten hinzu.
][
*Typische Verwechslungen:*
- „Immer an die erste Unterschrift, unabhängig von Auszahlung und Neuvereinbarungen“: Der Vertragsabschluss ist nicht automatisch der maßgebliche Start.
- „An jede beliebige jährliche Zinszahlung“: Eine normale Zinszahlung startet die Frist nicht jährlich neu.
]

#aufgabe(titel: "Außerordentliche Kündigung durch den Kreditgeber", art: "verstehen", quelle: "2.8", herkunft: "eigen", tipp: [Die Norm verbindet Verschlechterung und Rückzahlungsrisiko.])[
#if not web [*Aufgabe 218* #linebreak()]
Warum reicht für die außerordentliche Kündigung durch den Kreditgeber nicht jede kleine Wertschwankung einer Sicherheit?
#src[Umgewandelt aus Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Musterantwort:* § 490 Abs. 1 verlangt eine wesentliche eingetretene oder drohende Verschlechterung, durch die die Rückzahlung auch unter Verwertung der Sicherheit gefährdet wird. Anlass und Rückzahlungsgefährdung sind zusammen zu prüfen.
]

#aufgabe(titel: "Hauptpflichten beim Darlehensvertrag", art: "verstehen", quelle: "2.8", herkunft: "eigen")[
#if not web [*Aufgabe 219* #linebreak()]
Welche Hauptpflichten entstehen beim Darlehensvertrag?
#src[Umgewandelt aus Karteikarte (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Der Geber stellt den vereinbarten Geldbetrag bereit.
- Der Nehmer zahlt einen geschuldeten Zins und erstattet das Darlehen bei Fälligkeit zurück.
- Zins ist der Preis der Überlassung
- Tilgung vermindert die Schuld.

#align(center, image("abbildungen/map-darlehensrecht.svg", width: 75%))
]

#aufgabe(titel: "Vorfälligkeitsentschädigung wirtschaftlich erklären", art: "verstehen", quelle: "2.9", herkunft: "eigen")[
#if not web [*Aufgabe 220* #linebreak()]
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

#aufgabe(titel: "Wiederanlagezins und Vorfälligkeitsentschädigung", art: "verstehen", quelle: "2.9", herkunft: "eigen", tipp: [Vergleiche den alten Ertrag mit der möglichen neuen Anlage.])[
#if not web [*Aufgabe 221* #linebreak()]
Warum kann ein niedrigerer Wiederanlagezins eine Vorfälligkeitsentschädigung erhöhen?
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Die Bank erhält ihr Geld früher zurück, kann damit aber möglicherweise weniger verdienen als mit den vereinbarten Kredit-Zahlungen.
- Ein niedrigerer Wiederanlagezins kann diesen wirtschaftlichen Nachteil vergrößern.
- Zuerst muss trotzdem ein Entschädigungsanspruch bestehen
- ersparte Kosten sind zu berücksichtigen.

#align(center, image("abbildungen/map-vorfaelligkeit.svg", width: 75%))
][
*Antwort:* Kontrollfrage: „Wie wirkt ein niedrigerer Wiederanlagezins unter sonst gleichen Bedingungen auf den Zinsnachteil einer vorzeitigen Rückzahlung?“ Er kann den Nachteil der Bank vergrößern. Zurückerhaltene Mittel verdienen dann weniger als die ursprünglich geplanten Zahlungen.
][
*Typische Verwechslungen:*
- „Er beseitigt zwingend jeden Nachteil.“: Das wäre eher bei günstigerer Wiederanlage denkbar.
- „Er beweist ohne weitere Prüfung einen pauschalen Gebührenanspruch.“: Anspruchsgrund, Zahlungen und ersparte Kosten bleiben zu prüfen.
]

#aufgabe(titel: "Aktiv-Aktiv und Aktiv-Passiv unterscheiden", art: "verstehen", quelle: "2.9", herkunft: "eigen", tipp: [Welche Wiederanlage bildet die jeweilige Vergleichsseite?])[
#if not web [*Aufgabe 222* #linebreak()]
Was unterscheidet Aktiv-Aktiv- und Aktiv-Passiv-Vergleich?
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Aktiv-Aktiv vergleicht den alten Kredit mit einem neuen Kreditgeschäft.
- Aktiv-Passiv betrachtet eine Wiederanlage in laufzeitentsprechenden Hypothekenpfandbriefen.
- In beiden Fällen darf nur ein sachgerecht bestimmter Nachteil ersetzt werden, ohne doppelte Zählung desselben Schadens.
][
*Musterantwort:* Kontrollfrage: „Was ist der Unterschied zwischen Aktiv-Aktiv- und Aktiv-Passiv-Vergleich?“ Aktiv-Aktiv vergleicht mit einem neuen Kreditgeschäft. Aktiv-Passiv vergleicht mit einer Wiederanlage in laufzeitentsprechenden Hypothekenpfandbriefen. Dabei müssen Zahlungsstruktur und ersparte Kosten berücksichtigt werden.
]

#aufgabe(titel: "Ratendarlehen und Annuität: was ist konstant?", art: "verstehen", quelle: "2.10.1", herkunft: "eigen", tipp: [Annuität ist die Summe der beiden Zahlungsanteile.])[
#if not web [*Aufgabe 223* #linebreak()]
Was bleibt beim Ratendarlehen konstant, was beim Annuitätendarlehen?
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Beim Ratendarlehen bleibt die Tilgung konstant
- mit fallender Restschuld sinken Zinsen und Gesamtzahlung.
- Beim Annuitätendarlehen bleibt die Gesamtzahlung konstant
- der Zinsanteil sinkt und der Tilgungsanteil steigt.
- Endfällige Tilgung führt die Schuld dagegen erst am Laufzeitende zurück.

*Merksatz:* Rate hält Tilgung fest; Annuität hält die Gesamtzahlung fest.

#align(center, image("abbildungen/map-tilgung.svg", width: 75%))
][
*Antwort:* Kontrollfrage: „Was bleibt beim Annuitätendarlehen des behandelten Modells konstant?“ Die Gesamtzahlung aus Zins und Tilgung. Mit sinkender Restschuld sinkt der Zinsanteil; der Tilgungsanteil steigt.
][
*Typische Verwechslungen:*
- „Der Tilgungsanteil jeder Zahlung“: Das kennzeichnet das Ratendarlehen.
- „Die Restschuld bis zum letzten Tag“: Das kennzeichnet die endfällige Tilgung.
]

#aufgabe(titel: "Klausur: Annuitätendarlehen der Inn GmbH", art: "rechnen", quelle: "2.10.1", herkunft: "original", vorlage: "Altklausur 2017, Aufg. 1 a", minuten: 6, ergebnis: [Annuität ungerundet 21.522,16 €/Jahr, Tabelle 21.522 €; Zinsen gerundet insgesamt 6.088 €.])[
#if not web [*Aufgabe 224* #linebreak()]
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

#aufgabe(titel: "Annuitätendarlehen der Isar GmbH (Variante)", art: "rechnen", quelle: "2.10.1", herkunft: "variante", vorlage: "Altklausur 2017, Aufg. 1 a", minuten: 8, ergebnis: [Annuität 21.621 €; Zinsen gesamt 4.863 €])[
#if not web [*Aufgabe 225* #linebreak()]
*Gegeben und Annahmen*

Die Isar GmbH nimmt am 01.01. ein Annuitätendarlehen über 60.000 € auf, Auszahlung 100 %, Zinssatz 4 % p. a. fest, Laufzeit 3 Jahre, Zahlung jeweils am Jahresende. Zinsen auf die Restschuld zu Jahresbeginn. Alle Tabellenwerte auf volle Euro runden; ein Rundungsrest im letzten Jahr ist zu vernachlässigen.

*Gesucht*

#enum(numbering: "a)",
[Annuität.],
[Tilgungsplan für die drei Jahre (Restschuld Jahresbeginn, Zinsen, Tilgung, Annuität, Restschuld Jahresende).],
[Summe der Zinsen.],
)
#src[Eigene Variante zu Altklausur 2017, Aufgabe 1 a (K, PDF-S. 1); Lernskript 2.10.1.]
][
*Annuität:* $A=60000 frac("0,04" times "1,04"^3,"1,04"^3-1) approx "21620,91"$ €, gerundet 21.621 €.
][
*Plan:*
#tab(columns: (0.7fr,1fr,1fr,1fr,1fr,1fr), th([Jahr],[Anfang €],[Zins €],[Tilgung €],[Annuität €],[Ende €]),
[1],[60.000],[2.400],[19.221],[21.621],[40.779],
[2],[40.779],[1.631],[19.990],[21.621],[20.789],
[3],[20.789],[832],[20.789],[21.621],[0],)
Tilgung = Annuität − Zins; Zins = 4 % der Anfangsschuld.
][
*Zinsen gesamt:* $2400+1631+832=4863$ €. Kontrolle: Tilgungen $19221+19990+20789=60000$ €.
]

#aufgabe(titel: "Klausur: Ratendarlehen der Inn GmbH", art: "rechnen", quelle: "2.10.1", herkunft: "original", vorlage: "Altklausur 2017, Aufg. 1 b", minuten: 4, ergebnis: [Tilgung 20.000 €/Jahr; Zahlungen 22.400 / 21.800 / 21.200 / 20.600 €; Gesamtzinsen 6.000 €.])[
#if not web [*Aufgabe 226* #linebreak()]
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

#aufgabe(titel: "Ratendarlehen der Isar GmbH (Variante)", art: "rechnen", quelle: "2.10.1", herkunft: "variante", vorlage: "Altklausur 2017, Aufg. 1 b", minuten: 6, ergebnis: [Tilgung 20.000 €/Jahr; Zahlungen 22.400 / 21.600 / 20.800 €; Zinsen 4.800 €])[
#if not web [*Aufgabe 227* #linebreak()]
*Gegeben und Annahmen*

Die Isar GmbH nimmt am 01.01. ein Tilgungsdarlehen (Ratendarlehen) über 60.000 € auf, Auszahlung 100 %, 4 % p. a. fest, Laufzeit 3 Jahre, gleiche jährliche Tilgung, Zinsen auf die Restschuld zu Jahresbeginn, Zahlung am Jahresende.

*Gesucht*

#enum(numbering: "a)",
[Tilgungsplan mit Restschuld, Zinsen, Tilgung, Summe aus Zins und Tilgung und Restschuld Jahresende.],
[Vergleiche die Gesamtzinsen mit dem Annuitätendarlehen gleicher Konditionen (4.863 €) und erkläre den Unterschied.],
)
#src[Eigene Variante zu Altklausur 2017, Aufgabe 1 b (K, PDF-S. 1); Lernskript 2.10.1.]
][
*Tilgung:* $60000/3=20000$ € pro Jahr (Tilgungssatz 33,3 % der Anfangsschuld).
][
*Plan:*
#tab(columns: (0.7fr,1fr,1fr,1fr,1fr,1fr), th([Jahr],[Anfang €],[Zins €],[Tilgung €],[Summe €],[Ende €]),
[1],[60.000],[2.400],[20.000],[22.400],[40.000],
[2],[40.000],[1.600],[20.000],[21.600],[20.000],
[3],[20.000],[800],[20.000],[20.800],[0],)
][
*Vergleich:* Zinsen $2400+1600+800=4800$ € < 4.863 €. Beim Ratendarlehen sinkt die Schuld schon im ersten Jahr stärker (20.000 statt 19.221 €), deshalb fallen später weniger Zinsen an; dafür ist die Anfangsbelastung höher.
]

#aufgabe(titel: "Disagio und Effektivzins", art: "verstehen", quelle: "2.10.2", herkunft: "eigen", tipp: [Unterscheide erhaltenes Geld und Nominalschuld.])[
#if not web [*Aufgabe 228* #linebreak()]
Warum kann ein Disagio den Effektivzins über den Nominalzins heben, und warum steht in der Praktikerformel die Auszahlung im Nenner?
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Der Schuldner erhält weniger Geld, während sich Nominalzinsen und vereinbarte Rückzahlung weiterhin auf die höhere Schuld beziehen.
- Der Auszahlungsabzug ist deshalb eine zusätzliche Belastung.
- Die Praktikerformel verteilt ihn nur näherungsweise auf die Laufzeit.

*Merksatz:* Weniger Auszahlung bei gleicher Schuld macht die Finanzierung teurer.
][
*Antwort:* Kontrollfrage: „Warum verwendet die Praktikerformel für den Effektivzins mit Disagio die Auszahlung im Nenner?“ Weil sie die jährliche Näherungsbelastung auf das tatsächlich erhaltene Geld bezieht. Nominalzinsen plus verteiltes Disagio belasten einen kleineren Zufluss.
][
*Typische Verwechslungen:*
- „Weil nur die Auszahlung später zurückgezahlt wird.“: Im Klausurfall wird der Nominalbetrag zurückgezahlt.
- „Weil die Formel dadurch eine exakte gesetzliche Effektivzinsberechnung wird.“: Sie bleibt eine vereinfachende Näherung für den angegebenen Fall.
]

#aufgabe(titel: "Klausur: Effektivzins mit zwei Prozent Disagio", art: "rechnen", quelle: "2.10.2", herkunft: "original", vorlage: "Altklausur 2017, Aufg. 1 c", minuten: 2, ergebnis: [Auszahlung 78.400 €; näherungsweise 3,57 % p. a.])[
#if not web [*Aufgabe 229* #linebreak()]
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

#aufgabe(titel: "Effektivzins mit drei Prozent Disagio (Variante)", art: "rechnen", quelle: "2.10.2", herkunft: "variante", vorlage: "Altklausur 2017, Aufg. 1 c", minuten: 4, ergebnis: [Auszahlung 58.200 €; ca. 5,15 % p. a.])[
#if not web [*Aufgabe 230* #linebreak()]
*Gegeben und Annahmen*

Endfälliges Darlehen über nominal 60.000 €, Nominalzins 4 % p. a., Laufzeit 3 Jahre, Auszahlungsdisagio 3 %. Jährliche Zinszahlung, Rückzahlung von 60.000 € am Ende, keine weiteren Kosten.

*Gesucht*

#enum(numbering: "a)",
[Auszahlungsbetrag.],
[Effektiver Jahreszins nach der Praktikerformel (2 Nachkommastellen).],
[Wie ändert sich der Effektivzins qualitativ, wenn die Laufzeit bei gleichem Disagio 6 Jahre beträgt?],
)
#src[Eigene Variante zu Altklausur 2017, Aufgabe 1 c (K, PDF-S. 2); Lernskript 2.10.2.]
][
*Auszahlung:* $60000 times (1-"0,03")=58200$ €.
][
*Praktikerformel:* Zins $60000 times "0,04"=2400$ € pro Jahr; Disagio $1800/3=600$ € pro Jahr. $i_"eff" approx (2400+600)/58200 approx "0,0515"="5,15"%$.
][
*Längere Laufzeit:* Das Disagio verteilt sich auf mehr Jahre ($1800/6=300$ € pro Jahr), der Effektivzins sinkt: $(2400+300)/58200 approx "4,64"%$.
]

#aufgabe(titel: "Klausur: Sicherheiten nach zwei Kriterien einordnen", art: "verstehen", quelle: "2.10.3", herkunft: "original", vorlage: "Altklausur 2017, Aufg. 1 d", minuten: 2)[
#if not web [*Aufgabe 231* #linebreak()]
Nenne je eine Personal- und Realsicherheit sowie je ein akzessorisches und fiduziarisches Sicherungsmittel. Erkläre die beiden Einteilungen, statt nur vier Wörter aufzuzählen.
#src[Altklausur 2017, Aufgabe 1 d, zweimal 1 Punkt; K, PDF-S. 2 (Klausurseite 6). Eigene Lösung mit Rechtsabgleich in Abschnitt 2.10.]
][
*Rückgriff unterscheiden:* Personalsicherheit: beispielsweise Bürgschaft, also zusätzlicher Anspruch gegen einen Bürgen. Realsicherheit: beispielsweise Grundschuld, also Sicherung an einem Vermögenswert.
][
*Forderungsbindung unterscheiden:* Akzessorisch: Bürgschaft, deren Umfang vom jeweiligen Bestand der Hauptverbindlichkeit abhängt. Fiduziarisches Beispiel: Sicherungsgrundschuld; ihr dinglicher Bestand setzt die Forderung nicht voraus, der Sicherungsvertrag verbindet sie mit dem Kredit.
][
*Prüfen:* Dieselbe Bürgschaft ist zugleich personal und akzessorisch. Die Sicherungsgrundschuld ist zugleich real und fiduziarisch. „Real“ bedeutet nicht automatisch „akzessorisch“. Die handschriftlichen falschen Zuordnungen im Scan werden nicht übernommen.
]

#aufgabe(titel: "Zwei Einteilungen von Sicherheiten", art: "verstehen", quelle: "2.10.3", herkunft: "eigen", tipp: [Prüfe zuerst Person oder Sache, danach die Bindung an die Forderung.])[
#if not web [*Aufgabe 232* #linebreak()]
Warum sind „personal oder real“ und „akzessorisch oder fiduziarisch“ zwei verschiedene Einteilungen? Ordne Bürgschaft, Grundschuld und Hypothek ein.
#src[Umgewandelt aus Karteikarte und Quizfrage (Lernplattform); Grundlage: Lernskript-Abschnitt.]
][
*Kurz erklärt:*
- Personal oder real fragt, ob eine weitere Person oder ein Vermögenswert als Sicherheit dient.
- Akzessorisch oder fiduziarisch fragt nach der rechtlichen Verbindung zur gesicherten Forderung.
- Eine Bürgschaft ist personal und akzessorisch
- eine Sicherungsgrundschuld real und fiduziarisch.
][
*Antwort:* Kontrollfrage: „Welche Zuordnungen von Sicherheiten passen zur Altklausur-Ergänzung?“ Zutreffend sind:
- Bürgschaft: personal und akzessorisch: Zusätzliche Person; Bindung an die Hauptverbindlichkeit.
- Sicherungsgrundschuld: real und fiduziarisch: Vermögenswert als Sicherheit; Verbindung zur Forderung durch Sicherungsvereinbarung.
][
*Typische Verwechslungen:*
- „Jede Realsicherheit ist allein deshalb akzessorisch“: Die Art des Rückgriffs und die Forderungsbindung sind getrennte Kriterien.
]
