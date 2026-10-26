// Kopf des Feynman-Lernskripts (Layout + Bausteine). Bilder liegen in abbildungen/. Keine Pakete erforderlich.
#set document(title: "Finanzierung – Feynman-Lernskript", author: "Lernzusammenfassung")
#let navy = rgb("244f70")
#let teal = rgb("16746d")
#let ink = rgb("24323d")
#let muted = rgb("627380")
#let pale = rgb("eef4f8")
#let mint = rgb("eef7f2")
#let sand = rgb("fff6e5")
#let vartheta = sym.theta.alt
#let seitenfuss = context [
  #line(length: 100%, stroke: 0.45pt + rgb("d7e1e8"))
  #v(1.5mm)
  #text(size: 8pt, fill: muted)[Feynman-Lernskript · Stand 26.10.2026]
  #h(1fr)
  #text(size: 9pt, fill: navy)[Seite #counter(page).display("1") von #counter(page).final().first()]
]
#set page(paper: "a4", margin: (left: 20mm, right: 19mm, top: 19mm, bottom: 20mm),
 header: [#text(size: 8pt, fill: muted)[Finanzierung #h(1fr) Sehen · Verstehen · Erklären]], footer: seitenfuss)
#set text(font: "Libertinus Serif", size: 11pt, lang: "de", fill: ink, hyphenate: true)
#set par(justify: false, leading: 0.5em, spacing: 0.55em)
#set heading(numbering: none)
#set list(indent: 1.1em, body-indent: 0.5em, spacing: 0.35em)
#set enum(indent: 1.25em, body-indent: 0.5em, spacing: 0.55em)
#set math.equation(numbering: none)
#show heading.where(level: 1): it => block(above: 0.5em, below: 0.8em, sticky: true)[
 #text(size: 24pt, weight: "bold", fill: navy, it.body)
 #v(1.5mm) #line(length: 100%, stroke: 1pt + navy)
]
#show heading.where(level: 2): it => block(above: 1em, below: 0.6em, sticky: true)[
 #text(size: 15pt, weight: "bold", fill: navy, it.body)
]
#show heading.where(level: 3): it => block(above: 0.7em, below: 0.35em, sticky: true)[
 #text(size: 11.5pt, weight: "bold", fill: teal, it.body)
]
#show math.equation.where(block: true): it => block(above: 0.45em, below: 0.45em, breakable: false)[#it]
#let note(title, body, fill: mint) = block(width: 100%, fill: fill, inset: (x: 9pt, y: 7pt),
 above: 0.5em, below: 0.5em, breakable: false)[#text(fill: teal, weight: "bold", title) #parbreak() #body]
#let src(body) = block(above: 0.35em, below: 0.4em)[#text(size: 8pt, fill: muted)[*Grundlage:* #body]]
#let nachschlagen(body) = block(above: 0.25em, below: 0.3em, breakable: false)[#text(size: 8.5pt, fill: teal)[*Nachschlagen:* #body]]
// Verweis auf eine Stelle in DIESEM Lernskript mit automatischer Seitenzahl (für neue Lösungen).
// Überschrift mit Label versehen, z. B. === 2.12 Neues Thema <a-2-12>, dann #nachschlagen[Lernskript, #stelle(<a-2-12>)]
#let stelle(ziel) = context {
  let el = query(ziel).first()
  link(ziel)[Abschnitt #el.body, S. #counter(page).at(el.location()).first()]
}
#let form(body) = block(width: 100%, fill: pale, inset: (x: 7pt, y: 5pt), above: 0.5em, below: 0.5em, breakable: false)[#body]
#let tab(..args) = {
 set text(size: 9.6pt)
 set par(leading: 0.4em, spacing: 0.25em, justify: false)
 table(inset: 6pt, stroke: 0.35pt + rgb("cfdae2"), ..args)
}
#let th(..cells) = table.header(..cells.pos().map(c => table.cell(fill: pale)[#strong(c)]))

// ─── Überblick-Ebenen und Chunkmaps (in allen Modulen gleich) ─────────────────
// Ebene 0: Seite „Das Modul auf einen Blick“ nach dem Wegweiser (Label <ueberblick>).
// Ebene 1: unter jeder Kapitelüberschrift (Label <a-n>) #überblick mit #idee-Links und eine #karte oder ein #ablauf.
// Ebene 2: die Abschnitte; am Ende jedes Abschnitts #hoch(<a-n>, [Kapitelübersicht]).
// Die Kästen sind keine Überschriften: Inhaltsverzeichnis und PDF-Lesezeichen bleiben unverändert.
#let chunk(titel, begriffe, ziel: none, fill: pale, stroke: navy) = {
  let kasten = block(width: 100%, fill: fill, stroke: 0.6pt + stroke, radius: 4pt, inset: (x: 6pt, y: 5pt), breakable: false)[
    #set par(leading: 0.35em, spacing: 0.35em, justify: false)
    #set text(hyphenate: true)
    #text(size: 9pt, weight: "bold", fill: navy, titel)
    #if begriffe != none [#parbreak() #text(size: 7.8pt, fill: muted, begriffe)]
  ]
  if ziel == none { kasten } else { link(ziel, kasten) }
}
#let pfeil(beschriftung: none, zeichen: sym.arrow.r) = align(center + horizon, stack(dir: ttb, spacing: 2pt,
  ..(if beschriftung != none { (text(size: 6.8pt, fill: teal, beschriftung),) } else { () }),
  text(size: 13pt, fill: teal, zeichen)))
// Chunkmap als Raster: #karte((1fr, auto, 1fr), chunk(..), pfeil(..), chunk(..))
#let karte(spalten, ..zellen) = block(width: 100%, breakable: false, above: 0.7em, below: 0.7em,
  grid(columns: spalten, column-gutter: 3pt, row-gutter: 7pt, align: center + horizon, ..zellen))
// Flussdiagramm von oben nach unten: #ablauf(chunk(..), entscheidung(..), chunk(..))
#let ablauf(breite: 80%, ..schritte) = block(width: 100%, breakable: false, above: 0.7em, below: 0.7em, align(center,
  stack(dir: ttb, spacing: 2pt, ..schritte.pos().enumerate().map(((i, x)) =>
    (if i > 0 { (text(size: 12pt, fill: teal, sym.arrow.b),) } else { () }) + (block(width: breite, x),)).flatten())))
#let entscheidung(frage, ja, nein) = stack(dir: ttb, spacing: 3pt,
  chunk(frage, none, fill: sand, stroke: teal),
  grid(columns: (1fr, 1fr), column-gutter: 8pt,
    [#align(center, text(size: 8pt, fill: teal)[#sym.arrow.b *ja*]) #ja],
    [#align(center, text(size: 8pt, fill: teal)[#sym.arrow.b *nein*]) #nein]))
#let idee(ziel, kern, satz) = [#link(ziel)[#text(fill: teal, weight: "bold", kern)] #satz]
#let überblick(titel, ..ideen) = block(width: 100%, fill: pale, inset: (x: 9pt, y: 7pt), above: 0.6em, below: 0.6em, breakable: false)[
  #text(fill: navy, weight: "bold", titel)
  #set list(marker: text(fill: teal, sym.arrow.r), spacing: 0.45em)
  #list(..ideen.pos())
]
#let hoch(ziel, wort) = block(above: 0.4em, below: 0.4em, align(right, text(size: 8.5pt, fill: teal, link(ziel)[#sym.arrow.t #wort])))

#let abbildungen = (
  "abgrenzung-auszahlung": "abbildungen/abgrenzung-auszahlung.svg",
  "abgrenzung-einzahlung": "abbildungen/abgrenzung-einzahlung.svg",
  "cashflow-bereiche": "abbildungen/cashflow-bereiche.svg",
  "cover": "abbildungen/cover.svg",
  "erfolg-zahlung": "abbildungen/erfolg-zahlung.svg",
  "finanzierungsformen-folie": "abbildungen/finanzierungsformen-folie.svg",
  "g-bilanz-aktiva": "abbildungen/g-bilanz-aktiva.svg",
  "g-bilanz-passiva": "abbildungen/g-bilanz-passiva.svg",
  "g-ebk-plan": "abbildungen/g-ebk-plan.svg",
  "g-finanzplan": "abbildungen/g-finanzplan.svg",
  "g-forderungen": "abbildungen/g-forderungen.svg",
  "g-guv-historie": "abbildungen/g-guv-historie.svg",
  "g-nocf-plan": "abbildungen/g-nocf-plan.svg",
  "g-nocf-steuern": "abbildungen/g-nocf-steuern.svg",
  "g-planbilanz": "abbildungen/g-planbilanz.svg",
  "g-steuer-guv": "abbildungen/g-steuer-guv.svg",
  "g-ueberleitung": "abbildungen/g-ueberleitung.svg",
  "insolvenz-historisch": "abbildungen/insolvenz-historisch.svg",
  "kapitalrisiko-folie": "abbildungen/kapitalrisiko-folie.svg",
  "leverage-kurven": "abbildungen/leverage-kurven.svg",
  "liquiditaetsarten-folie": "abbildungen/liquiditaetsarten-folie.svg",
  "liquiditaetsgrade": "abbildungen/liquiditaetsgrade.svg",
  "liquiditaetsverlauf": "abbildungen/liquiditaetsverlauf.svg",
  "map-cashflow": "abbildungen/map-cashflow.svg",
  "map-formen": "abbildungen/map-formen.svg",
  "map-glasspinnerei": "abbildungen/map-glasspinnerei.svg",
  "map-insolvenz": "abbildungen/map-insolvenz.svg",
  "map-kennzahlen": "abbildungen/map-kennzahlen.svg",
  "map-leverage": "abbildungen/map-leverage.svg",
  "map-liquiditaet": "abbildungen/map-liquiditaet.svg",
  "map-planung": "abbildungen/map-planung.svg",
  "map-ziele": "abbildungen/map-ziele.svg",
  "plan-und-bilanz": "abbildungen/plan-und-bilanz.svg",
  "siemens-free-cashflow": "abbildungen/siemens-free-cashflow.svg",
  "zieldreieck": "abbildungen/zieldreieck.svg",
)

#let bilddeutungen = (
  "abgrenzung-auszahlung": (titel: "Bild lesen", body: [#text("Die beiden Balken erfassen Auszahlungen und Aufwendungen derselben Periode. Nur der gemeinsame Bereich fällt zusammen. Die nummerierten Zuordnungen zeigen vor- und nachperiodisierte Vorgänge sowie Zahlungen ohne zugehörigen Aufwand; die Balkenlängen sind keine Eurobeträge.")]),
  "abgrenzung-einzahlung": (titel: "Bild lesen", body: [#text("Oben werden Einzahlungen, unten Erträge verglichen. Die Verbindungen führen etwa von einer Kundenanzahlung zum späteren Ertrag oder vom heutigen Zielverkauf zur späteren Einzahlung. Die gleiche Buchungsperiode ist nicht automatisch die gleiche Zahlungsperiode.")]),
  "cashflow-bereiche": (titel: "Bild lesen", body: [#text("Die drei oberen Kästen sind Tätigkeitsbereiche, keine aufeinanderfolgenden Jahre. Jeder Bereich trägt mit seinem eigenen Vorzeichen zur Änderung des Zahlungsmittelbestands bei. Ein negativer Investitionssaldo kann deshalb gleichzeitig mit einem positiven operativen Saldo auftreten.")]),
  "cover": (titel: "Bild lesen", body: [#text("Links fließen Kundenzahlungen und Kapital in den Betrieb. Rechts gehen Zahlungen an Lieferanten, Personal und Kapitalgeber hinaus. Der Geldbestand in der Mitte muss zu jedem Fälligkeitstermin reichen. Gewinn ist in dieser Zeichnung bewusst kein zusätzlicher Geldzufluss.")]),
  "erfolg-zahlung": (titel: "Bild lesen", body: [#text("Die waagerechte Linie steht für Zeit; die drei Kästen sind voneinander unabhängige Fälle. Beim Maschinenkauf fällt die Auszahlung früher an als die Abschreibung, beim Zielverkauf die Einzahlung später als der Ertrag. Der Kredit bringt Geld, ohne Umsatz zu sein.")]),
  "finanzierungsformen-folie": (titel: "Bild lesen", body: [#text("Links stehen die fünf Außenformen, rechts vier Innenformen. Die Ziffern sind die Nummern der Vorlesung, keine Rangfolge. Lies erst die Herkunft und danach die Rechte: Ein Gesellschafterdarlehen steht links und bleibt Fremdkapital.")]),
  "g-bilanz-aktiva": (titel: "Bild lesen", body: [#text("Die Spalten sind die historischen Jahre, die Werte Tausend Euro. Anlagen, Vorräte, Forderungen und Kasse haben verschiedene Liquidisierbarkeit. Die Bestände liefern die Ausgangsgrößen für spätere Bewegungsrechnungen; sie sind keine jährlichen Auszahlungen.")]),
  "g-bilanz-passiva": (titel: "Bild lesen", body: [#text("Hier wird dieselbe historische Bilanzsumme nach Kapitalquellen gegliedert. Unterscheide Eigenkapitalpositionen, Kredite, Lieferverbindlichkeiten und Rückstellungen. Neue Planung beginnt bei diesen Beständen und ihren noch folgenden Zahlungen.")]),
  "g-ebk-plan": (titel: "Bild lesen", body: [#text("Die ersten Zeilen leiten Bestände aus Umsatzquoten ab. Lieferverbindlichkeiten und Rückstellungen werden abgezogen, danach wird die jährliche Veränderung gebildet. Die Fußnote erweitert die kurze EBK-Definition um Lizenz- und Steuerrückstellungen.")]),
  "g-finanzplan": (titel: "Bild lesen", body: [#text("Die Zeilen schichten NOCF, alte Zinsen, neue Kredite, Zinsen/Tilgungen, Investitionen und Dividenden. Unten steht 2005 ein Bedarf, in den folgenden Jahren Überschüsse. Die Markierung Zahlungsunfähigkeit zeigt den unfinanzierten Engpass; mit rechtzeitiger gesicherter Finanzierung ist die Lage gesondert zu beurteilen.")]),
  "g-forderungen": (titel: "Bild lesen", body: [#text("Gleiche Planumsätze werden mit der niedrigeren Forderungsquote verbunden. Darunter folgen EBK und seine Änderung. Vergleiche einmal mit 2004 und einmal mit dem ursprünglichen Plan 2005: Diese unterschiedlichen Ausgangspunkte erzeugen unterschiedliche Freisetzungsbeträge.")]),
  "g-guv-historie": (titel: "Bild lesen", body: [#text("Erträge und Aufwendungen sind jahresweise nebeneinandergestellt, in T€. Die Tabelle liefert Kostenbasis und Steuer-/Gewinngrößen. Abschreibung und Jahresüberschuss dürfen nicht unmittelbar als Ein- oder Auszahlungen übernommen werden.")]),
  "g-nocf-plan": (titel: "Bild lesen", body: [#text("Die Spalten führen von 2004 bis 2008, die Zeilen von Menge und Preis über Kosten zu NOCF vor Steuern. In der Zeile ΔEBK wird die jährliche Änderung verwendet; ein negativer Wert erhöht den NOCF. 2008 wird die Produktionsmenge an der Fußnoten-Kapazität von 27.375 t begrenzt.")]),
  "g-nocf-steuern": (titel: "Bild lesen", body: [#text("Die kleine Tabelle zieht die Steuerzahlungen von den zuvor ermittelten operativen Überschüssen ab. 2005 bleibt wegen des Verlustes im Fall keine laufende Gewinnsteuer, später wirken die positiven Steuerbasen. Das Ergebnis ist noch nicht der frei verfügbare Kassenbestand.")]),
  "g-planbilanz": (titel: "Bild lesen", body: [#text("Links stehen die Anlagen- und Umlaufbestände, rechts die Finanzierung. Vergleiche 2004 und 2005: Zugänge und Abschreibungen ändern die Anlagen, die unterstellten Darlehen schließen formal die Kassenlücke. Ein negativer Eigenkapitalausweis erklärt sich aus dem hohen bilanziellen Verlust.")]),
  "g-steuer-guv": (titel: "Bild lesen", body: [#text("Die Spalten sind Planjahre, die Zeilen die steuerliche Erfolgsrechnung. Hohe Sonderabschreibungen erzeugen 2005 einen Verlust, der im Folgejahr verrechnet wird. Dadurch ist die modellierte Steuer 2006 nicht einfach die Hälfte des gesamten positiven Gewinns.")]),
  "g-ueberleitung": (titel: "Bild lesen", body: [#text("Die Tabelle startet mit dem Jahresergebnis, korrigiert nicht zahlungswirksame und bestandsbedingte Unterschiede und ergänzt die Finanzierungsschichten. Erst die letzte Zeile ergibt die Kassenänderung. Die gesondert angenommene Darlehenszufuhr ist dabei Teil der Rechnung.")]),
  "insolvenz-historisch": (titel: "Bild lesen", body: [#text("Oben sind regionale historische Verfahrensdauern, unten Fortführungswege bzw. Stilllegungen nach Verfahrensphasen dargestellt. Die Bezugsgruppen wechseln: Bereits geschlossene Unternehmen und noch aktive Unternehmen dürfen nicht zum selben Nenner vermischt werden. Die Grafik zeigt keine aktuelle Prognose.")]),
  "kapitalrisiko-folie": (titel: "Bild lesen", body: [#text("Die obere Reihe zeigt identische Anfangsvermögen mit verschiedener Finanzierung. Unten ist dasselbe Grundstück weniger wert. Bei B vermindert zusätzlich die Zinszahlung die Kasse. Der ausgewiesene Fehlbetrag ist ein rechnerischer Bilanzposten und kein Geldpolster.")]),
  "leverage-kurven": (titel: "Bild lesen", body: [#text("Waagerecht steht FK/EK, senkrecht die EK-Rendite in Prozent. Die grüne Gerade steigt bei Gesamtrendite 20 % über dem Kreditzins von 10 %. Die orange Gerade fällt bei Gesamtrendite 5 %. Die Steigung entsteht aus dem Renditeabstand, nicht aus zusätzlichem operativem Gewinn.")]),
  "liquiditaetsarten-folie": (titel: "Bild lesen", body: [#text("Die kleine Matrix ordnet vorhandenes Vermögen und künftige Überschüsse einerseits sowie originäre und abgeleitete Quellen andererseits. Die Liste rechts ordnet im Folienmodell Vermögen nach seiner Verflüssigung. Die Zeichnung liefert noch keine konkreten Zahlungstermine.")]),
  "liquiditaetsgrade": (titel: "Bild lesen", body: [#text("Die drei Brüche haben denselben Nenner. Von links nach rechts wird mehr Vermögen einbezogen: sofort verfügbare Mittel, zusätzlich Forderungen, dann das gesamte Umlaufvermögen. Der größere Zähler sagt noch nicht, wie schnell er zu Geld wird.")]),
  "liquiditaetsverlauf": (titel: "Bild lesen", body: [#text("Waagerecht stehen Anfang und Monatsenden, senkrecht Tsd. €. Die waagerechten Hilfslinien markieren Bestände, die rote Zahl den negativen Planbestand im zweiten Monat. Die Verbindungslinien erleichtern nur den Überblick; sie behaupten keinen gleichmäßigen Verlauf innerhalb eines Monats.")]),
  "map-cashflow": (titel: "Bild lesen", body: [#text("Links stehen die beiden Rechenwege, rechts die Bereichsgliederung und der freie Saldo nach Investitionen. Die Äste müssen dieselbe Periode und passende Abgrenzungen verwenden.")]),
  "map-formen": (titel: "Bild lesen", body: [#text("Das Zentrum erinnert an zwei unabhängige Fragen. Die oberen Äste ordnen nach Herkunft, die unteren nach Rechten. So wird der Gesellschafter als Person nicht mit seiner jeweiligen Kapitalrolle verwechselt.")]),
  "map-glasspinnerei": (titel: "Bild lesen", body: [#text("Die Zweige zeigen die Rückkopplung zwischen operativer Kapitalbindung, NOCF, Steuerbasis und Finanzplan. Einseitiges Betrachten nur der GuV oder nur der Investitionssumme übersieht einen Teil des Kapitalbedarfs.")]),
  "map-insolvenz": (titel: "Bild lesen", body: [#text("Drei Zweige unterscheiden gegenwärtige, drohende und vermögensbezogene Schwierigkeiten. Der vierte nennt mögliche Zahlungsmaßnahmen. Er ersetzt nicht die getrennte rechtliche Prüfung der einzelnen Befunde.")]),
  "map-kennzahlen": (titel: "Bild lesen", body: [#text("Jeder Zweig beantwortet eine andere Frage: kurzfristige Deckung, langfristige Finanzierung, Kapitalanteile oder Ertragskraft. Eine gute Rendite kann deshalb eine schlechte Liquiditätsdeckung nicht widerlegen.")]),
  "map-leverage": (titel: "Bild lesen", body: [#text("Die vier Äste verbinden Gesamtrendite, Kreditpreis, Verschuldung und Richtung des Hebels. Ein kleiner Renditeabstand wirkt bei großem FK/EK stark auf die Eigentümerrendite.")]),
  "map-liquiditaet": (titel: "Bild lesen", body: [#text("Die Äste trennen die Fähigkeit zu zahlen, die Veräußerbarkeit von Vermögen, eine Bestandsaufnahme und die zeitliche Planung. Erst ihr Zusammenspiel erklärt die Zahlungsbereitschaft.")]),
  "map-planung": (titel: "Bild lesen", body: [#text("Drei Zweige nennen Anforderungen an die Zahlungsprognose, der vierte die Abstimmung mit anderen Plänen. Ein formal richtig addierter Plan kann trotzdem ungeeignet sein, wenn Termine oder Annahmen nicht stimmen.")]),
  "map-ziele": (titel: "Bild lesen", body: [#text("Im Zentrum steht die Finanzierung. Die vier Zweige verbinden die drei Ziele mit der passenden Bereitstellung der Mittel. Die Äste sind zusammen zu prüfen, sie bilden keine zeitliche Reihenfolge.")]),
  "plan-und-bilanz": (titel: "Bild lesen", body: [#text("Oben stehen geplante Ein- und Auszahlungen, unten die daraus und aus der Erfolgsrechnung abgeleiteten Bilanzbestände. Folge den Periodenspalten: Eine negative Kassenposition und ein späterer Gewinn können nebeneinander stehen. Der Plan benennt damit einen noch zu deckenden Bedarf.")]),
  "siemens-free-cashflow": (titel: "Bild lesen", body: [#text("Die Spalten unterscheiden fortgeführte, nicht fortgeführte und zusammengefasste Aktivitäten. Operativer Cashflow und die angegebenen Anlagenzugänge ergeben die jeweilige Free-Cashflow-Zeile. Der sichtbare Rundungs-/Zahlendifferenzhinweis im Text darf beim Nachrechnen nicht verloren gehen.")]),
  "zieldreieck": (titel: "Bild lesen", body: [#text("Die Ecken sind Ziele, keine Zahlenachsen. Die Dreiecksfläche macht ihre gemeinsame Abstimmung sichtbar. Wer zusätzliche sofort verfügbare Mittel hält, gewinnt Reserve; diese Mittel können dann aber nicht gleichzeitig anders eingesetzt werden.")]),
)

#let bild(name, caption, height: 55mm) = block(width: 100%, breakable: false, above: 0.6em, below: 0.6em)[
 #align(center)[#image(abbildungen.at(name), format: "svg", width: 100%, height: height, fit: "contain")]
 #v(1.2mm)
 #align(center)[#text(size: 8.4pt, fill: muted, caption)]
 #let deutung = bilddeutungen.at(name, default: none)
 #if deutung != none [
  #v(2mm)
  #text(weight: "bold", fill: teal)[#deutung.titel.] #deutung.body
 ]
]

#align(center)[
#v(8mm)
#text(size: 11pt, tracking: 1pt, fill: teal)[VERSTEHEN · ERKLÄREN · ANWENDEN]
#v(6mm)
#text(size: 29pt, weight: "bold", fill: navy)[Finanzierung]
#v(4mm)
#text(size: 20pt, fill: navy)[Feynman-Lernskript]
#v(3mm)
#text(size: 12pt)[Zahlungen sehen. Zusammenhänge verstehen. Selbst erklären.]
#v(5mm)
#bild("cover", [Finanzielle Beziehungen eines Unternehmens. Eigene schematische Darstellung nach V, PDF-S. 3–6 und 12.], height: 65mm)
#v(4mm)
#text(size: 12pt, fill: teal)[Ziele → Zahlungsströme → Kapitalbedarf → Finanzierung]
]

#note("Dein Feynman-Schritt", [Erkläre ohne Vorlage: *Woher kommt das Geld? Wann wird es gebraucht? Warum genügt Gewinn allein nicht?* Zeichne die Zahlungsströme und prüfe Deine Erklärung anschließend an den Beispielen und Aufgaben.])

*Stand 26.10.2026:* Grundlagen der Finanzplanung bis Folie 54 sowie die Fallstudie Glasspinnerei aus der Vorlesung vom 21.10.2026. Neu: die Aufgaben 3 und 4 der Altklausur 2017 (Leverage, Cashflow, Innenfinanzierung) als Klausuraufgaben im Reiter „Lernen“ der Lernwebseite; ihre Aufgaben 1 und 2 (Darlehen, Kreditsicherheiten, Kapitalerhöhung) folgen, sobald Kapitel B und C behandelt sind. Die Sachinhalte und Rechenfälle des Lernskripts vom 15.10. sind übernommen; das Skript enthält nur die Erklärungen und im Anhang die Formelsammlung; alle Aufgaben mit Lösungen Schritt für Schritt und das Quiz stehen auf der Lernwebseite im Reiter „Lernen“. Fachliche Grundlage sind Deine Vorlesungsunterlagen, ergänzt um sichtbar gekennzeichnete Erklärhilfen und den Abgleich widersprüchlicher Insolvenzaussagen mit Primärquellen.

#pagebreak()
#heading(level: 1, outlined: false)[Wegweiser]
#block[
#set text(size: 9.5pt)
#set par(leading: 0.3em, spacing: 0.15em)
#outline(title: none, depth: 2, indent: auto)
]
#v(2mm)
#text(size: 8.5pt, fill: muted)[*Quellenkürzel:* V = „Skript Finanzierung.pdf“; N1 = „1VL Finanzierung.pdf“; N2 = „VL 14.10.pdf“; M = „eigenes Skript Finanzierung.pdf“; BAF = „01VL_BAF Finanzierung.pdf“; G = „Fallstudie Glasspinnerei Straubing AG.pdf“; L15 = altes Claude-Lernskript, Stand 15.10.2026; K = „Klausur 2017.pdf“ (Fotos von Teil II, Klausurseiten 5–10; Hochschule und Prüfer sind auf den Seiten nicht erkennbar; die handschriftlichen Antworten und Korrekturen im Scan werden nicht übernommen). „PDF-S.“ zählt ab der ersten Dateiseite. V hat zwei Folien pro PDF-Seite. Buchangaben auf Folien sind Sekundärnachweise; Bücher wurden nicht verwendet. Gesetzeslinks und BGH sind nur zur ausdrücklich markierten Fehlerklärung ergänzt (Abruf 22.10.2026). „Nachschlagen“ führt mit automatisch berechneter Seite in dieses Lernskript.]

#pagebreak()
#heading(level: 1, outlined: false, bookmarked: false)[Das Modul auf einen Blick] <ueberblick>

Jeder Kasten ist ein Link: Tippe ihn an, um ins Kapitel oder in den Abschnitt zu springen.

#karte((1fr,),
  chunk([Kapitel 1 · Grundlagen der Finanzplanung], [Finanzierungsformen · Liquidität · Erfolg und Zahlung · Cashflow · Finanzplan · Kennzahlen · Leverage · Fallstudie Glasspinnerei], ziel: <a-1>),
)

*Der rote Faden in Kapitel 1*

#karte((1fr, auto, 1fr, auto, 1fr, auto, 1fr, auto, 1fr),
  chunk([1.1–1.2 Ziele und Formen], [Herkunft · Rechte · Eigen- oder Fremdkapital], ziel: <a-1-1>),
  pfeil(),
  chunk([1.3–1.6 Liquidität und Cashflow], [Erfolg ≠ Zahlung · direkt und indirekt · Free Cashflow], ziel: <a-1-3>),
  pfeil(),
  chunk([1.7–1.8 Finanzplan], [Zahlungsfahrplan · Insolvenzgründe · Gegenmaßnahmen], ziel: <a-1-7>),
  pfeil(),
  chunk([1.9–1.12 Kennzahlen], [Liquiditätsgrade · Kapitalstruktur · Rentabilität · Leverage], ziel: <a-1-9>),
  pfeil(),
  chunk([1.13–1.18 Glasspinnerei], [EBK · NOCF · Planbilanz · Finanzierungslücke], ziel: <a-1-13>),
)

Das Modul fragt im Kern: *Ist genug Geld zum richtigen Zeitpunkt da, und woher kommt es?* Dafür trennst Du zuerst Erfolg von Zahlungen, denn Gewinn allein bezahlt keine Rechnung. Cashflow und Finanzplan zeigen, wann Geld fehlt; Kennzahlen und Leverage zeigen, wie riskant die Finanzierung ist. Die Fallstudie Glasspinnerei setzt alles zu einer Kapitalbedarfsrechnung zusammen.
#src[V, PDF-S. 1–3; G, PDF-S. 1 und 24; Zusammenführung aus Kapitel 1. Eigene Darstellung.]

#pagebreak()
= Kapitel 1 · Grundlagen der Finanzplanung <a-1>

#überblick([Kapitel 1 auf einen Blick],
  idee(<a-1-2>, [Herkunft und Rechte unterscheiden.], [Woher das Kapital kommt und welche Rechte daran hängen, ordnet jede Finanzierungsform ein.]),
  idee(<a-1-4>, [Erfolg ist nicht Zahlung.], [Gewinn kann entstehen, ohne dass Geld fließt, und umgekehrt; deshalb erst trennen, dann planen.]),
  idee(<a-1-5>, [Der Cashflow zeigt die Zahlungskraft.], [Direkt oder indirekt gerechnet ergibt er dieselbe Größe, aufgeteilt in drei Bereiche.]),
  idee(<a-1-7>, [Der Finanzplan ist ein Zahlungsfahrplan.], [Er zeigt Betrag und Termin jeder Lücke, bevor sie zur Insolvenz führt.]),
  idee(<a-1-12>, [Leverage hebelt Rendite und Risiko.], [Mehr Fremdkapital erhöht die Eigenkapitalrendite nur, solange die Gesamtrendite über dem Zins liegt.]),
  idee(<a-1-13>, [Die Fallstudie führt alles zusammen.], [Aus Absatz, Kosten, Steuern und Investitionen entsteht der Kapitalbedarf.]),
)

*So entsteht die Kapitalbedarfsrechnung der Glasspinnerei*

#ablauf(
  chunk([Absatzplanung], [Menge und Preis als Startpunkt, historische Daten], ziel: <a-1-13>),
  chunk([Kosten und Bestandsbindung], [EBK: Wachstum bindet Geld in Vorräten und Forderungen], ziel: <a-1-14>),
  chunk([Plan-GuV und NOCF], [Abschreibung und Steuer: Erfolg wird zu Zahlung], ziel: <a-1-15>),
  chunk([Finanzplan], [NOCF, Investitionen, Ausschüttungen, Kapitalaufnahme und Reserven ergeben den Kapitalbedarf], ziel: <a-1-15>),
  entscheidung([Ist der Kapitalbedarf gedeckt?],
    chunk([Planbilanz prüfen], [Verlust und Zahlungsdefizit getrennt lesen], ziel: <a-1-16>),
    chunk([Lücke schließen], [Finanzierungslücke gezielt verändern], ziel: <a-1-17>)),
)
#hoch(<ueberblick>, [Modul auf einen Blick])

Ein Unternehmen braucht Geld in passender Höhe *zum richtigen Zeitpunkt*. Deshalb beginnen wir mit Zielen und Finanzierungsformen, trennen dann Erfolg von Zahlungen und bauen daraus einen Finanzplan. Kennzahlen zeigen die Struktur; die Glasspinnerei verbindet alles zu einer Kapitalbedarfsrechnung. Die Reihenfolge folgt Teil A der Vorlesung, ergänzt um die behandelte Fallstudie.
#src[V, PDF-S. 1 und 3; G, PDF-S. 1 und 24.]

== 1.1 Ziele und Finanzierungsbegriff <a-1-1>

*Finanzierung* stellt die für die Unternehmenstätigkeit nötigen Mittel bereit: im notwendigen *Umfang*, in der erforderlichen *Art*, zum richtigen *Zeitpunkt* und am richtigen *Ort*. Das Sachziel lautet also nicht bloß „möglichst viel Geld“.

*Eigene Erklärhilfe aus dem Altstand:* Ein Maschinenbauer benötigt im März 500.000 € für eine Fräsmaschine mit zehnjähriger Nutzungsdauer. Betrag, langfristige Verfügbarkeit, Termin und die kaufende Gesellschaft müssen zusammenpassen. Ein erst im Juni zufließender Kredit löst den Zahlungsbedarf im März nicht.

#bild("zieldreieck", [Rentabilität, Sicherheit und Liquidität: eigene Darstellung nach V, PDF-S. 3–4 (Folien 6–7).], height: 45mm)

#tab(columns: (1fr, 2.8fr),
 th([Ziel], [Bedeutung und Konflikt]),
 [*Rentabilität*], [Das eingesetzte Kapital soll einen Ertrag erwirtschaften. Hohe erwartete Renditen sind häufig mit höheren Risiken verbunden.],
 [*Sicherheit*], [Unternehmen und Gläubiger sollen vor Verlusten geschützt sein. Sichere Anlagen sind im Vorlesungsvergleich meist weniger ertragreich.],
 [*Liquidität*], [Fällige Zahlungen müssen geleistet werden können. Viel ungenutztes Geld schafft Reserve, kann aber Rendite kosten.],
)

#note("In eigenen Worten", [Das *magische Dreieck* beschreibt einen Zielkonflikt. Alle drei Ziele lassen sich nicht beliebig gleichzeitig maximieren. Deine Notizen betonen: Zwischen „sicher“ und „rentabel“ gibt es keine pauschal richtige Wahl; die Risikoaversion spielt eine Rolle.])

*Eigene Vergleichshilfe aus L15:* Bargeld ist unmittelbar verfügbar; ein schwankender Wertpapierbestand verbindet Veräußerbarkeit mit Kursrisiko; eine Immobilie braucht im Regelfall Zeit für den Verkauf. Der Vergleich erklärt die verschiedenen Ziele, verspricht aber für keine Anlage Sicherheit oder Rendite. Inflation kann die Kaufkraft unverzinster Mittel mindern.

Finanzierungsmaßnahmen betreffen auch *Geldäquivalente*, etwa Sacheinlagen oder Rechte. Bei Verträgen sind Gegenleistungen entscheidend: Bedienung, Rückzahlung, Informations-, Kontroll-, Sicherungs- und Sanktionsrechte. Innenfinanzierung kann dagegen aus einbehaltenen Mitteln, zeitlichen Aufwands-/Zahlungsunterschieden und Ausschüttungssperren entstehen.
#bild("map-ziele", [Mindmap: das Sachziel mit den drei Finanzierungszielen verbinden. Eigene Darstellung nach V, PDF-S. 3–4.], height: 44mm)
#src[V, PDF-S. 3–4 (Folien 6–8); M, PDF-S. 1; BAF, PDF-S. 1; eigene Beispiele/Vergleiche aus L15, PDF-S. 3–4.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.2 Finanzierungsformen: Herkunft und Rechte trennen <a-1-2>

Zwei Fragen ordnen einen Finanzierungsvorgang: *Woher stammen die Mittel?* Und: *Welche Rechte erhält der Kapitalgeber?* Ein Eigentümer kann seiner Gesellschaft ein Darlehen geben. Der Geber ist Eigentümer, das Darlehen bleibt trotzdem Fremdkapital.

#bild("finanzierungsformen-folie", [Die neun Formen mit der Nummerierung der Originalfolie. V, PDF-S. 5, Folie 9.], height: 66mm)

#tab(columns: (0.45fr, 1.5fr, 2.5fr),
 th([Nr.], [Form], [Einordnung]),
 [1], [Fremdfinanzierung], [Außen: Fremdkapital von Gläubigern.],
 [2], [Gesellschafterdarlehen], [Außen: bisherige Eigentümer geben Fremdkapital.],
 [3], [Eigenfinanzierung], [Außen: bisherige Eigentümer legen Eigenkapital ein.],
 [4], [Beteiligungsfinanzierung], [Außen: neue Kapitalgeber legen Eigenkapital ein.],
 [5], [Hybride Finanzierung], [Außen: Eigentümer- und Gläubigerrechte werden kombiniert.],
 [6], [Offene Selbstfinanzierung], [Innen: Jahresüberschüsse werden einbehalten.],
 [7], [Stille Selbstfinanzierung I], [Innen: Finanzierung durch gesetzliche Gewinnermittlungsvorschriften.],
 [8], [Stille Selbstfinanzierung II], [Innen: Spielräume bei Ansatz und Bewertung nutzen.],
 [9], [Vermögensumschichtung], [Innen: nicht mehr benötigte Vermögensgegenstände entgeltlich verkaufen.],
)

*Außenfinanzierung* beruht auf Finanzierungsbeziehungen mit Kapitalgebern außerhalb des Unternehmens. *Innenfinanzierung* deckt den Bedarf aus Vorgängen im Unternehmen. Die Folien unterscheiden zusätzlich: außen festgelegte Beträge, abgegrenzte Fristen und vereinbarte Einzelakte; innen zum Teil ungewisse Beträge und Fristen sowie laufende, erst am Periodenende erkennbare Vorgänge.

*Eigene Erklärhilfe aus L15:* Ein Bankkredit über 200.000 € ab 1. März mit fünf Jahren Laufzeit ist vereinbart. Wie viel Gewinn im Unternehmen verbleibt, steht vorher noch nicht endgültig fest. Eigenfinanzierung durch eine Einlage von außen und Selbstfinanzierung aus einbehaltenen Gewinnen sind deshalb verschiedene Vorgänge.

#tab(columns: (1.15fr, 1.5fr, 1.5fr),
 th([Merkmal], [Eigenkapital (EK)], [Fremdkapital (FK)]),
 [Erfolg], [Erfolgsbeteiligung], [keine vertragliche Erfolgsbeteiligung im Grundmodell],
 [Zahlungsanspruch], [kein fester Zins-/Tilgungsanspruch], [fester Anspruch auf Zins und Tilgung],
 [Anspruchsart], [Quotenanteil], [Nominalanspruch],
 [Dauer], [unbefristet], [befristet],
 [Haftung], [trägt Verluste als Kapitalpolster], [keine Verlusthaftung wie EK],
 [Leitung], [Mitwirkungsrechte], [keine gesellschaftsrechtlichen Leitungsrechte],
)

#note("Fehler vermeiden", [„Keine Haftung“ des FK im Folienvergleich bedeutet kein vertragliches Tragen der Unternehmensverluste wie beim EK. Es bedeutet *keine garantierte Rückzahlung*: Im Insolvenzfall kann auch ein Gläubiger Geld verlieren. „Haftung“ des EK ist hier das Verlustpolster im Unternehmen, keine pauschale Aussage über das Privatvermögen. Eigene Präzisierung.], fill: sand)

*Eigener Vergleich aus L15:* 10.000 € für ein Café als Darlehen zu 5 % und Rückzahlung nach drei Jahren begründen Zahlungsansprüche. Eine Beteiligung von 20 % begründet stattdessen einen Anteil mit Mitwirkungs- und Erfolgsrechten. Die vertragliche Zahlungspflicht des Darlehens besteht auch in schlechten Jahren; die tatsächliche Erfüllung bleibt vom Schuldner abhängig.

Deine Notizen stellen Zins, Gewinnbeteiligung, Rückzahlung, Stimm- und Kündigungsrechte gegenüber. FK-Geber haben im Grundmodell keine Stimmrechte, können aber über vertragliche Kündigungs- oder Verlängerungsentscheidungen faktisch Einfluss ausüben. Eine Bank, die die Verlängerung einer Kreditlinie von Änderungen abhängig macht, illustriert diesen Unterschied.
#bild("map-formen", [Mindmap: Herkunft der Mittel und Rechtsstellung getrennt prüfen. Eigene Darstellung nach V, PDF-S. 4–6.], height: 45mm)
#src[V, PDF-S. 4–6 (Folien 8–11); M, PDF-S. 1–2; BAF, PDF-S. 1; L15, PDF-S. 4–5. Eigene Vergleiche und Präzisierungen sind gekennzeichnet.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.3 Liquidität: Betrag und Termin müssen passen <a-1-3>

*Liquidität* ist die Fähigkeit, gegenwärtige und zukünftige Zahlungsverpflichtungen *fristgerecht und betragsgenau* zu erfüllen. Sie ist existenziell und muss dauerhaft gesichert werden. *Liquiditätsstatus* bezeichnet die aktuelle, tagesgenaue Lage; ein *Liquiditätsplan* nimmt künftige Zahlungen vorweg.

Ein Gewinn garantiert die Zahlungsfähigkeit nicht. *Eigenes Beispiel aus L15:* Ein Handwerksbetrieb erbringt einen Auftrag über 80.000 €; der Kunde zahlt erst nach 90 Tagen. Erträge sind bereits entstanden, Löhne und Lieferanten müssen aber vorher bezahlt werden. Umgekehrt kann eine Verlustperiode noch durch vorhandenes Geld oder Kredite überbrückt werden.

#bild("liquiditaetsarten-folie", [Liquiditätsquellen und Liquidisierbarkeit. V, PDF-S. 7, Folie 14.], height: 67mm)

#tab(columns: (1fr, 1.45fr, 1.65fr),
 th([Quelle], [Vorhandenes Vermögen], [Künftige Überschüsse]),
 [Originär], [*Güterwirtschaftliche Liquidität*: Vermögen zu Geld machen.], [*Zukünftige Liquidität*: Überschüsse abwarten.],
 [Abgeleitet], [*Verliehene Liquidität*: Vermögen beleihen.], [*Antizipierte Liquidität*: künftige Überschüsse vorfinanzieren.],
)

*Liquidisierbarkeit* fragt, wie schnell und problemlos ein Vermögenswert zu Zahlungsmitteln wird. Die absteigende Reihenfolge der Folie lautet: Barmittel → Zentralbankguthaben → Sichtguthaben → zentralbankfähige und nicht zentralbankfähige Wechsel → Termin- und Sparguthaben → handelbare Wertpapiere → Forderungen → verkaufsfertige Waren → Hypotheken/Grundschulden → unbebaute und bebaute Grundstücke → Halbfabrikate → maschinelle Anlagen. Das ist die vereinfachte Einordnung der Vorlesung, keine universelle Rangliste aller Vertragsfälle.

Die Aufgabe auf Folien 15–16 vergleicht einen üblichen zweijährigen Sparbrief, eine vierjährige Bundesanleihe, Tagesgeld und einmonatiges Festgeld. Im angenommenen Vertragsfall ist der nicht vorzeitig kündbare Sparbrief am wenigsten liquide. Die börslich handelbare Anleihe kann trotz längerer Restlaufzeit früher verkauft werden; Verfügbarkeit und Verkaufspreis sind unterschiedliche Fragen.

Die *Bilanz* zeigt Vermögens- und Kapitalbestände am Stichtag; die *GuV* zeigt Erträge und Aufwendungen einer Periode. Die Bilanz liefert Anhaltspunkte, aber keinen vollständigen Kalender künftiger Zahlungsfälligkeiten. Der Siemens-Ausschnitt auf Folie 13 zeigt einen weiteren Zusammenhang: Bei Großprojekten kann die vom Hersteller bereitgestellte Finanzierung selbst ein Verkaufsargument werden.
#bild("map-liquiditaet", [Mindmap: Zahlungsfähigkeit, Vermögen und Plan unterscheiden. Eigene Darstellung nach V, PDF-S. 6–9.], height: 45mm)
#note("Selbst erklären", [Warum kann das längere Wertpapier liquider sein? *Weil der vorzeitige Verkauf möglich ist.* Entscheidend ist, wann Geld tatsächlich verfügbar wird, nicht allein das Laufzeitende.])
#src[V, PDF-S. 6–9 (Folien 12–17); M, PDF-S. 2; L15, PDF-S. 6–7. Handwerksbeispiel und Präzisierung zur Bilanz: eigene Erklärhilfe.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.4 Erfolg und Zahlung auseinanderhalten <a-1-4>

*Aufwand* erfasst den einer Periode zugerechneten Werteverzehr; *Auszahlung* den Abfluss von Zahlungsmitteln. *Ertrag* gehört zur Erfolgsrechnung; *Einzahlung* ist der Geldzufluss. Gleiche Vorgänge können in verschiedenen Perioden erfolgs- und zahlungswirksam sein.

#bild("erfolg-zahlung", [Drei Zeitvergleiche. Eigene Darstellung nach V, PDF-S. 10 (Folien 19–20).], height: 47mm)
#form[$ "Gewinn" = "Erträge" - "Aufwendungen" quad "Zahlungssaldo" = "Einzahlungen" - "Auszahlungen" $]
Beide Salden beziehen sich auf eine Periode, etwa einen Monat. Sie sind Geldbeträge, aber unterschiedliche Größen. Zahlungsfähigkeit ist darüber hinaus eine Frage der vorhandenen Mittel und der Fälligkeiten, kein bloßer Saldo.

#tab(columns: (1.5fr, 2.6fr),
 th([Fall], [Beispiel aus den Folien]),
 [Aufwand und Auszahlung jetzt], [Löhne, in derselben Periode gezahlte Zinsen.],
 [Auszahlung jetzt, Aufwand später], [Maschinenkauf, Abschreibung in künftigen Perioden.],
 [Aufwand jetzt, Auszahlung früher], [Abschreibung einer bereits bezahlten Anlage.],
 [Aufwand jetzt, Auszahlung später], [Zuführung zu einer Rückstellung.],
 [Auszahlung für früheren Aufwand], [Spätere Zahlung aus einer Rückstellung.],
 [Auszahlung ohne entsprechenden Aufwand], [Tilgung, Ausschüttung, Anschaffung eines Grundstücks oder einer Beteiligung im dargestellten Grundfall.],
 [Einzahlung und Ertrag jetzt], [Barverkauf.],
 [Ertrag jetzt, Einzahlung später], [Verkauf auf Ziel; eine Forderung entsteht.],
 [Einzahlung jetzt, Ertrag später], [Kundenanzahlung.],
 [Einzahlung für früheren Ertrag], [Bezahlung einer Forderung aus einer Vorperiode.],
 [Einzahlung ohne entsprechenden Ertrag], [Kreditaufnahme, Kapitaleinlage, Kreditrückzahlung an das Unternehmen, Grundstücksverkauf zum Buchwert.],
)

#bild("abgrenzung-auszahlung", [Originaldarstellung der Periodenabgrenzung: Auszahlungen und Aufwendungen. V, PDF-S. 10, Folie 19.], height: 67mm)
#bild("abgrenzung-einzahlung", [Originaldarstellung: Einzahlungen und Erträge. V, PDF-S. 10, Folie 20.], height: 67mm)

#note("Fehler vermeiden", [„Nie Aufwand“ beim Grundstückskauf beschreibt den Erwerbsvorgang im Folienmodell. Es schließt einen späteren Wertverlust nicht aus. Ebenso sind Tilgung und Kreditzins verschieden: Die Tilgung reduziert Schulden, der Zins ist Aufwand. Eigene Präzisierung.], fill: sand)

Eine *Rückstellung* erfasst eine ungewisse Verpflichtung; ihre Bildung kann schon Aufwand sein, obwohl die zugehörige Auszahlung später liegt. Im Folienbeispiel ist deshalb die Zuführung zur Pensionsrückstellung vom späteren Auszahlen zu trennen.
#src[V, PDF-S. 9–11 (Folien 18–22); M, PDF-S. 3; L15, PDF-S. 7–8 und 39. Eigene begriffliche Präzisierungen wie gekennzeichnet.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.5 Cashflow: zwei Wege zu derselben Zahlungsgröße <a-1-5>

Der *Cashflow* ist ein Zahlungsüberschuss für eine definierte Periode und einen definierten Tätigkeitsbereich. Die direkte Methode zählt die zugehörigen Ein- und Auszahlungen. Die indirekte Methode startet beim Jahresüberschuss und korrigiert dessen Unterschied zu den Zahlungen.

#form[$ "CF direkt" = "Einzahlungen" - "Auszahlungen" $]
#form[$ "CF indirekt (einfach)" = "JÜ" + "auszahlungsloser Aufwand" - "einzahlungsloser Ertrag" $]
Alle Größen in derselben Geldeinheit und Periode. Die zweite Gleichung ist das vereinfachte Modell von Folie 18. Für einen vollständigen operativen Cashflow sind gegebenenfalls weitere zahlungswirksame Abgrenzungen nötig, wie Folie 24 zeigt.

*Warum Abschreibungen addieren?* Sie haben den Gewinn vermindert, aber in dieser Periode kein Geld abfließen lassen. Das Addieren beseitigt nur diesen Unterschied. Eine Abschreibung erzeugt selbst keine Einzahlung.

*Marios Pizzeria, Folie 21:* 2.000 € monatlicher Gewinn und 2.500 € monatlicher Cashflow passen zusammen, wenn 6.000 € jährliche Abschreibung des Backofens den Unterschied ausmachen: $6000/12=500$ € pro Monat. Entnimmt Mario nur den Gewinn, bleiben 500 € zusätzlich zurück. Das sind *Abschreibungsgegenwerte*, sofern die Leistung verkauft und bezahlt wurde.

#note("Gültigkeit", [Die Ersatzbeschaffung funktioniert im Beispiel bei unveränderten Preisen, ohne sonstige Mittelverwendung und mit tatsächlich bezahlten Umsätzen. Die Abschreibung allein finanziert keinen neuen Ofen. Bei einem Lieferwagen für 36.000 € und sechs Jahren linearer Nutzung ergeben sich ebenfalls 500 €/Monat; bei 3.000 € Gewinn sind es im vereinfachten Fall 3.500 € Cashflow. Eigene Variante aus L15.], fill: sand)

#tab(columns: (1.1fr, 1fr, 1fr),
 th([XYZ GmbH], [2008, Mio. €], [2009, Mio. €]),
 [Erträge gesamt], [4.288], [6.400],
 [Material], [1.540], [2.800],
 [Personal], [1.600], [1.900],
 [Zinsen], [200], [520],
 [Pensionsrückstellungen], [200], [300],
 [Abschreibungen], [100], [500],
 [Jahresüberschuss], [648], [380],
 [*Cashflow*], [*948*], [*1.180*],
)
Für 2009 direkt: $6400-2800-1900-520=1180$. Indirekt: $380+500+300=1180$. Für 2008: $4288-1540-1600-200=948=648+100+200$. Die direkte Rechnung unterstellt wie die Aufgabe, dass die genannten zahlungswirksamen Aufwendungen und Erträge tatsächlich bezahlt sind.

Die Kapitalflussrechnung zeigt die Entwicklung der Liquidität sowie wichtige Investitions- und Finanzierungsvorgänge. Cashflows helfen zu beurteilen, ob das Unternehmen Überschüsse erwirtschaftet, Schulden tilgt, Gewinne ausschüttet und Investitionen finanziert.
#bild("map-cashflow", [Mindmap: Rechnung, Bereiche und Verwendung zusammenbringen. Eigene Darstellung nach V, PDF-S. 9–13.], height: 45mm)
#note("In der Altklausur 2017", [Aufgabe 4 verlangt genau diese beiden Wege an einer GuV (5 Punkte) und dazu zwei weitere Formen der Innenfinanzierung (1 Punkt). Übung auf der Lernwebseite: „Klausur: Cashflow der Rhein GmbH“ und „Klausur: weitere Formen der Innenfinanzierung“. K, PDF-S. 6.])
#src[V, PDF-S. 9 und 11–12 (Folien 18, 21–24); M, PDF-S. 3; L15, PDF-S. 8–10 und 14; K, PDF-S. 6. Varianten und Voraussetzungen: eigene Erklärhilfe.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.6 Drei Cashflow-Bereiche und Free Cashflow <a-1-6>

Die *Kapitalflussrechnung* trennt das Kerngeschäft, den Kauf und Verkauf längerfristigen Vermögens sowie die Kapitalbeziehungen zu Eigentümern und Gläubigern. Erst die Summe aller Bereiche erklärt die Änderung der Zahlungsmittel im vereinfachten Grundmodell.
#bild("cashflow-bereiche", [Drei Beiträge zu einer Bestandsänderung. Eigene Darstellung nach V, PDF-S. 12, Folie 24.], height: 46mm)

#tab(columns: (1.05fr, 2.9fr),
 th([Bereich], [Aufbau im Grundmodell der Vorlesung]),
 [*Operativ*], [JÜ + Abschreibungen/Zuführung zu Rückstellungen − Zuschreibungen/Auflösung von Rückstellungen − Zunahme Forderungen + Zunahme Verbindlichkeiten aus Lieferungen und Leistungen + erhaltene − geleistete Anzahlungen; jeweils zur passenden Periodenabgrenzung.],
 [*Investition*], [− Auszahlungen für Realinvestitionen und Finanzanlagen + Einzahlungen aus dem Verkauf von Vermögensgegenständen. Ein negativer Saldo zeigt Mittelverwendung, bewertet aber noch nicht den Investitionserfolg.],
 [*Finanzierung*], [+ Einzahlungen aus Gesellschaftsanteilen, festverzinslichen Wertpapieren und Krediten − Tilgung − Zins- und Dividendenzahlungen − Leasingraten (Zuordnung der Folie).],
)

#note("Folie präzise lesen", [Folie 24 führt die Erhöhung von Lieferverbindlichkeiten unter „Aufwendungen, die nicht Auszahlungen sind“. Die Bestandsänderung ist selbst kein Aufwand; sie korrigiert den Unterschied zwischen gebuchtem Aufwand und bezahltem Betrag. Bei Forderungen wirkt die Korrektur entgegengesetzt. Zinsen und Leasing werden hier nach dem Vorlesungsmodell eingeordnet. Eigene Präzisierung.], fill: sand)
#form[$ K_"Ende" = K_"Anfang" + "CF operativ" + "CF Investition" + "CF Finanzierung" $]
$K$ = Zahlungsmittelbestand; alle Werte in derselben Währung und Periode. Das Grundmodell enthält keine zusätzlichen Wechselkurs-/Bewertungseffekte.
#form[$ "Free Cashflow" = "CF operativ" - "Investitionsauszahlungen" $]
Die Investitionsauszahlungen meinen in Folie 26 Zugänge zu immateriellen Vermögenswerten und Sachanlagen als *positiven Abzugsbetrag*. Sie sind nicht automatisch der gesamte Investitions-Cashflow, in dem auch Verkäufe und weitere Positionen stehen.

#bild("siemens-free-cashflow", [Siemens 2018: Originalausschnitt des Free Cashflows. V, PDF-S. 13, Folie 26; dort Sekundärquelle Geschäftsbericht 2018, S. 27.], height: 54mm)
Für fortgeführte Aktivitäten nennt die Folie 8.415 Mio. € operativen Cashflow und 2.602 Mio. € Zugänge. Aus den angezeigten Zahlen folgen *5.813 Mio. €*, in der Tabelle stehen *5.814 Mio. €*. L15 erklärt das als Rundungsdifferenz. Ohne ungerundete Originaldaten ist diese Erklärung hier nicht nachprüfbar; der Unterschied von 1 Mio. € bleibt sichtbar.

Folie 25 nennt für fortgeführte Aktivitäten −3.741 Mio. € Investitions-Cashflow und −1.946 Mio. € Finanzierungs-Cashflow. Einschließlich nicht fortgeführter Aktivitäten lauten die drei Bereichssalden 8.425, −3.774 und −1.946 Mio. €. Ein negativer Investitions-Cashflow allein ist weder eine Erfolgsgarantie noch ein Insolvenzsignal.
#src[V, PDF-S. 12–13 (Folien 24–26); M, PDF-S. 3; L15, PDF-S. 9. Rechenvergleich und Präzisierungen: eigene Prüfung.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.7 Finanzplanung als Zahlungsfahrplan <a-1-7>

*Finanzplanung* plant, steuert und kontrolliert künftige Zahlungsströme und die Kapitalstruktur. Sie ermittelt Bedarf, sichert jederzeitige Zahlungsfähigkeit, wählt Finanzierungsarten, macht Defizite/Überschüsse sichtbar und bestimmt das erforderliche Eigenkapital als Verlustpolster.

#bild("map-planung", [Mindmap: drei Prinzipien und die Abstimmung der Teilpläne. Eigene Darstellung nach V, PDF-S. 14–15.], height: 45mm)

#tab(columns: (1fr, 2.8fr),
 th([Prinzip], [Was Du im Plan tust]),
 [Vollständigkeit], [Alle erwarteten Vorgänge mit Zahlungswirkung erfassen.],
 [Bruttoprinzip], [Ein- und Auszahlungen getrennt ausweisen, nicht vorab saldieren. Das ist die Bedeutung hier; nicht bloß „mit Umsatzsteuer“.],
 [Genauigkeit], [Realistische Annahmen für Betrag und Zeitpunkt verwenden.],
)

Produktions-, Absatz- und Investitionsplanung liefern den vorläufigen Unternehmensgesamtplan. Der Finanzplan prüft seine Finanzierbarkeit und gibt nötige Änderungen zurück. Die Folie unterscheidet kurzfristig bis ein Jahr, mittelfristig ein bis fünf Jahre und strategisch über fünf Jahre. Ein kurzfristiger Liquiditätsplan soll einen Engpass zeigen, *bevor* die Zahlung fällig wird.
#form[$ K_t = K_(t-1) + E_t - A_t $]
$K_t$ = Endbestand, $E_t$ = Einzahlungen, $A_t$ = Auszahlungen der Periode, z. B. in €. Der Endbestand wird zum Anfangsbestand der nächsten Periode. Eine negative Planposition bezeichnet einen Finanzierungsbedarf, keine tatsächlich negative Bargeldmenge.

Der einfache Plan enthält Anfangsbestand, Einzahlungen, Auszahlungen, Endbestand und noch ungenutzte Kreditlinien. Der ausführliche Fünfjahresplan auf Folie 31 trennt Einzahlungen, Auszahlungen einschließlich Investitionen, Finanzierung (EK, langfristige Kredite, Kontokorrent, Zuschüsse, vorhandene Barmittel) und Liquidität (Bestand, Kreditnutzung, Kreditlinie, Reserve).

Ein *Kontokorrentkredit* ist im hier verwendeten Modell die vereinbarte kurzfristige Kreditlinie des Geschäftskontos. Bei einer negativen Kontoposition ist die freie Linie = vereinbarte Linie − genutzter Kredit. *Verfügbare Liquidität* = positiver Geldbestand + freie Linie; Kreditnutzung und negativer Kontostand dürfen nicht doppelt abgezogen werden.

#tab(columns: (1.4fr, 1fr, 1fr, 1fr),
 th([Eigener Fall aus L15, €], [Januar], [Februar], [März]),
 [Anfang], [20.000], [20.000], [−5.000],
 [Einzahlungen], [50.000], [45.000], [60.000],
 [Auszahlungen], [50.000], [70.000], [64.000],
 [*Ende*], [*20.000*], [*−5.000*], [*−9.000*],
 [Freie Linie, Limit 10.000], [10.000], [5.000], [1.000],
)
Die Februar-Auszahlungen enthalten eine Investition von 15.000 €. Im März bleibt nur 1.000 € freie Linie. Der Plan macht eine passende längerfristige Finanzierung oder abgestimmte Zahlungsverlagerung frühzeitig prüfbar.

#bild("liquiditaetsverlauf", [Eigener zusätzlicher Planfall, alle Werte in Tsd. €: 20 → 8 → −8 → 18.], height: 53mm)

Deine Notiz zu Folie 31 zeigt denselben Unterschied: bei Anfang null und vereinfacht zahlungswirksamem Gewinn 1.000 €, Ausschüttung 500 €, Grundstückskauf 800 € und Kreditaufnahme 400 € verbleiben $1000-500-800+400=100$ €. Ausschüttung, Grundstückserwerb und Kredit verändern die Kasse, ohne in gleicher Höhe Gewinn oder Verlust zu sein.

#bild("plan-und-bilanz", [Finanzplan und Planbilanz aus der Vorlesung. V, PDF-S. 20 (Folien 39–40).], height: 103mm)
Im Gründungsfall werden 25.000 € EK eingebracht. Nach Anfangsinvestitionen/Gründungsaufwand bleiben 11.500 €. Am Ende der ersten laufenden Periode steht im Plan *−39.181 €*; bis Periode 5 bleiben negative Positionen, obwohl ab Periode 2 Gewinne entstehen. Der erste Verlust von 28.560 € übersteigt das EK; eine Finanzierung und ein Verlustpolster sind getrennt zu prüfen. Der ausgewiesene 30-%-Anteil eines weiteren Kapitalgebers und Förderdarlehen sind Lösungsansätze des Plans, keine bereits beschafften Mittel.
#note("Von Dir markiert", [Das rote X bei Folie 31 entfernt den Stoff nicht. Die Inhalte und das Zahlungsbeispiel bleiben enthalten. Die frühere Notiz „Glasspinnerei nächste VL“ ist durch die nachgereichte Fallstudie vom 21.10. überholt.])
#src[V, PDF-S. 14–16 und 20 (Folien 27–31, 39–40); N2, PDF-S. 1 und 6; M, PDF-S. 4; L15, PDF-S. 17–18 und 21. Planfälle/Erklärhilfen wie gekennzeichnet.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.8 Insolvenzgründe und Gegenmaßnahmen <a-1-8>

Ein Zahlungsengpass und ein negatives Eigenkapital sind verschiedene Befunde. Der erste fragt nach fälligen Zahlungen, der zweite zunächst nach Vermögen und Schulden. Die rechtliche Überschuldungsprüfung verlangt zusätzlich die Voraussetzungen des Gesetzes.
#bild("map-insolvenz", [Mindmap: die drei Befunde und mögliche Zahlungsmaßnahmen. Eigene Darstellung nach V, PDF-S. 16–18.], height: 45mm)

#tab(columns: (1.2fr, 2.8fr),
 th([Insolvenzgrund], [Kern und zeitlicher Blick]),
 [Zahlungsunfähigkeit, § 17], [Fällige Zahlungspflichten können nicht erfüllt werden; Zahlungseinstellung ist ein gesetzlicher Hinweis.],
 [Drohende Zahlungsunfähigkeit, § 18], [Die bestehenden Pflichten können voraussichtlich bei Fälligkeit nicht erfüllt werden. Der gesetzliche Prognosezeitraum beträgt in aller Regel 24 Monate.],
 [Überschuldung, § 19], [Vermögen deckt Verbindlichkeiten nicht, außer die Fortführung ist für die nächsten zwölf Monate überwiegend wahrscheinlich. Gilt für juristische Personen und die in § 19 Abs. 3 erfassten Personengesellschaften, z. B. die typische GmbH & Co. KG.],
)

#note("Widerspruch Folie ↔ Primärquelle", [Folie 32 vereinfacht zu „weniger als 90 % in drei Wochen“. Der BGH behandelt eine nicht beseitigte Lücke von *10 % oder mehr* regelmäßig als Zahlungsunfähigkeit, mit Ausnahmen. Genau 90 % Zahlung sind daher keine sichere Freigrenze. Die Aufgaben rechnen die Folienquote aus; das Ergebnis ersetzt keine vollständige rechtliche Prüfung. Eigene überprüfte Ergänzung.], fill: sand)

*Bilanzbeispiel Deiner Notiz:* AV 50 + UV 50 = Vermögen 100; FK 80, EK 20. Eine Abschreibung von 30 senkt AV auf 20 und rechnerisches EK auf −10. Vermögen 70 steht Schulden 80 gegenüber. Der nicht durch EK gedeckte Fehlbetrag ist 10. Eine zusätzliche Kreditaufnahme verändert Vermögen und Schulden gleich stark und beseitigt diese Differenz nicht.

#note("Folie 33 präzisieren", [Gesellschafterdarlehen werden nicht pauschal aus den Verbindlichkeiten gestrichen. § 19 Abs. 2 Satz 2 knüpft die Nichtberücksichtigung an den dort beschriebenen vereinbarten Nachrang. Ein *qualifizierter Rangrücktritt* kann für die Überschuldungsprüfung maßgeblich sein; er löscht die Schuld nicht und wird nicht automatisch zu handelsbilanziellem Eigenkapital. Eigene Korrektur des Altstands.], fill: sand)

*Antragspflicht:* Folie 34 nennt einheitlich höchstens drei Wochen. § 15a Abs. 1 unterscheidet dagegen *höchstens drei Wochen nach Eintritt der Zahlungsunfähigkeit* und *höchstens sechs Wochen nach Eintritt der Überschuldung*; jeweils ohne schuldhaftes Zögern. Die drohende Zahlungsunfähigkeit allein ist ein Eröffnungsgrund für den Schuldnerantrag nach § 18, kein Auslöser dieser Antragspflicht. Verspätete Antragstellung kann nach § 15a strafbar sein. Die alte pauschale Antragsfrist darf nicht als geltendes Recht gelernt werden.

Gegen einen Zahlungsengpass helfen im Folienmodell frische Mittel, Forderungsverkauf (*Factoring*) oder vereinbarte Zahlungsverschiebungen. Gegen eine rechnerische Unterdeckung helfen etwa Kapitaleinlage oder Forderungsverzicht (*Lieferantenvergleich*); ein rechtlich geeigneter Rangrücktritt ist gesondert zu prüfen. *Sale-and-lease-back* verkauft eigenes Anlagevermögen und mietet/least es zurück: sofortiger Zufluss, spätere laufende Zahlungen.

#tab(columns: (1.2fr, 2.7fr),
 th([Sechs Gruppen, Folie 35], [Beispiele aus dem Material]),
 [Vermögen verflüssigen], [Wertpapiere, entbehrliches Vermögen verkaufen; Sale-and-lease-back.],
 [Zahlungen verschieben], [Rechnungen sofort schreiben, Mahnwesen, Einzug sichern; Stundung, Tilgungsstreckung oder längere Ziele vereinbaren. Die Folie nennt auch spätes Bezahlen bis zur Klage; das ist eine Krisenbeschreibung, keine Empfehlung zum Vertragsbruch.],
 [Einlagen/Kredite], [Kundenvorauszahlungen, längere Lieferantenziele, private Darlehen/Geschäftsfreunde.],
 [Liquidität priorisieren], [Sofortzahler bevorzugen, im Folienfall Rentabilität für Liquidität aufgeben.],
 [Gesellschafterbeiträge], [Weniger Entnahmen/Vergütungen, zusätzliche Einlagen oder Kredite, private Sicherheiten, neue Gesellschafter.],
 [Auszahlungen kürzen], [Personalmaßnahmen über Fluktuation/Kündigungen, Spitzen über Mehrarbeit/Zeitverträge, Lagerbestände nutzen.],
)

*Ablauf nach Folie 36:* Insolvenzantrag beim zuständigen Gericht → vorläufige Verwaltung bzw. Prüfung → Eröffnung oder Abweisung mangels Masse → Forderungsanmeldung, Gläubigerversammlung und Verwaltung → Sanierung/Insolvenzplan oder Liquidation mit Gläubigerquote; eine Einstellung ist ebenfalls dargestellt. *Abweisung mangels Masse* bedeutet, dass die Verfahrenskosten nicht gedeckt sind. *Eigenverwaltung* lässt die bisherige Leitung unter Aufsicht weiterarbeiten. Bei drohender Zahlungsunfähigkeit ist nach § 18 der Schuldnerantrag zu unterscheiden; Gläubiger können nicht jeden dort genannten Grund gleichermaßen geltend machen.

#bild("insolvenz-historisch", [Historische IfM-Bonn-Abbildungen der Folien 37–38. V, PDF-S. 19; kein aktueller Insolvenzbericht.], height: 96mm)
Die zweite Grafik und der Altstand nennen 39 % bereits geschlossene Unternehmen bei Antragstellung; unter den übrigen werden 19 % übertragend und 4 % mit Insolvenzplan fortgeführt. Der Altstand fasst die Dauer juristischer Verfahren mit etwa 45–50 Monaten zusammen. Die Aussagen beziehen sich auf die historische Darstellung mit ihren jeweiligen Bezugsgruppen; daraus wird keine aktuelle Quote oder Kausalbehauptung abgeleitet.
#src[V, PDF-S. 16–20 (Folien 32–40); N2, PDF-S. 1–5; L15, PDF-S. 19–21 und 39–40. Rechtsabgleich (eigene Ergänzung): #link("https://www.gesetze-im-internet.de/inso/__17.html")[§ 17], #link("https://www.gesetze-im-internet.de/inso/__18.html")[§ 18], #link("https://www.gesetze-im-internet.de/inso/__19.html")[§ 19], #link("https://www.gesetze-im-internet.de/inso/__15a.html")[§ 15a InsO]; #link("https://juris.bundesgerichtshof.de/cgi-bin/rechtsprechung/document.py?Gericht=bgh&Art=en&nr=33452&Blank=1.pdf")[BGH, Urteil 24.05.2005, IX ZR 123/04, Leitsätze b–c, PDF-S. 1]. Abruf 22.10.2026.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.9 Liquiditätsgrade und ihre Grenzen <a-1-9>

Kennzahlen beschreiben die aus Beständen abgeleitete finanzielle Lage. Sie beantworten andere Fragen als ein zeitlich gegliederter Finanzplan. Die drei *Liquiditätsgrade* setzen verschieden weit gefasste Mittel ins Verhältnis zum kurzfristigen Fremdkapital.
#bild("liquiditaetsgrade", [Die Zähler werden weiter, der Nenner bleibt gleich. Eigene Darstellung nach V, PDF-S. 21, Folie 42.], height: 43mm)
#tab(columns: (1fr, 2.2fr, 1fr),
 th([Kennzahl], [Formel], [Folien-Zielwert]),
 [L1, Barliquidität], [$"flüssige Mittel" / "kurzfristiges FK" times 100%$], [10–30 %],
 [L2, einzugsbedingt], [$ ("flüssige Mittel" + "Forderungen") / "kurzfristiges FK" times 100% $], [mindestens 100 %],
 [L3, umsatzbedingt], [$ "Umlaufvermögen" / "kurzfristiges FK" times 100% $], [mindestens 200 %],
)
Geldeinheiten kürzen sich, das Ergebnis ist ein Prozentwert. Verwende für die Aufgabe jeweils die vorgegebenen kurzfristigen Forderungen und denselben Bilanzstichtag; der Nenner muss positiv sein.

#note("Selbst erklären", [Warum beweist ein hoher dritter Grad nicht, dass die Rechnung morgen bezahlt wird? *Weil Vorräte erst verkauft und Forderungen erst eingezogen werden müssen.* Bestände und Fälligkeiten können auseinanderfallen. Eigene Erklärhilfe.])
Höhere Deckung kann die Situation verbessern. Sehr viel sofort verfügbare Liquidität kann zugleich Rendite kosten. Die genannten Zielwerte sind die Orientierungen der Vorlesung, keine gesetzlichen Garantien.
#src[V, PDF-S. 21, Folie 42; N2, PDF-S. 6; L15, PDF-S. 21. Grenzen und Einheiten: eigene Erläuterung.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.10 Finanzierung, Vermögen und Kapitalstruktur messen <a-1-10>

Die *goldene Bilanzregel* verlangt, langfristig gebundenes Anlagevermögen durch langfristig verfügbares Kapital zu decken. Der eigene Vergleich des Altstands lautet: Ein Haus finanziert man im Plan nicht auf Dauer über den kurzfristigen Dispokredit. Das zugrunde liegende Prinzip heißt *Fristenkongruenz*.
#bild("map-kennzahlen", [Mindmap: Kennzahlen nach ihrer Frage sortieren. Eigene Darstellung nach V, PDF-S. 21–23 und 27.], height: 45mm)
#tab(columns: (1.25fr, 2.25fr, 1.3fr),
 th([Kennzahl], [Ansatz], [Deutung]),
 [Anlagendeckung I], [$"EK"/"AV" times 100%$], [EK-Deckung des AV],
 [Anlagendeckung II], [$("EK"+"langfristiges FK")/"AV" times 100%$], [mindestens 100 % als Folienregel],
 [Anlageintensität], [$"AV"/"Gesamtvermögen" times 100%$], [Vermögensbindung],
 [Eigenkapitalquote], [$"EK"/"Gesamtkapital" times 100%$], [Ziel laut Folie mindestens 15–20 %],
 [Fremdkapitalquote], [$"FK"/"Gesamtkapital" times 100%$], [zusammen mit EK-Quote 100 % im Zweiteilungsmodell],
 [Schuldentilgungsfähigkeit], [$"Verbindlichkeiten"/"Cashflow"$], [Jahre bei jährlichem positivem CF],
 [„Selbstfinanzierungsquote“], [$"Anlagevermögen"/"Cashflow"$], [Bezeichnung der Folie 44; dimensionsmäßig Jahre, keine Prozentquote],
)

$"AV"$ = Anlagevermögen. Bestände und Bezugsgrößen müssen zusammenpassen und Nenner positiv sein. 100 Schulden bei 25 jährlichem Cashflow ergeben rechnerisch vier Jahre. Das setzt konstanten, vollständig dafür verfügbaren Cashflow voraus; es ist keine zugesagte Tilgungsdauer. Entsprechend beschreibt AV/CF eine rechnerische Wiederbeschaffungsdauer und berücksichtigt keinen künftigen Preiswechsel.

Eine hohe Anlageintensität kann das rasche Verflüssigen erschweren. Eine niedrige kann auf alte, bereits stark abgeschriebene Anlagen hinweisen. Sie ist also nicht automatisch besser. Mehr EK bedeutet unter sonst gleichen Bedingungen ein größeres Verlustpolster und kann die Bonität (*Kreditwürdigkeit*) verbessern; die Quote allein bewertet nicht alle Kreditrisiken.
#note("Von Dir markiert", [Eigen- und Fremdkapitalquote sind in Deinen Notizen besonders hervorgehoben („am wichtigsten“ im Altstand). Die Nenner sind Gesamtkapital/Gesamtvermögen, nicht nur das Umlaufvermögen.])
#src[V, PDF-S. 22–23 (Folien 43–46); N2, PDF-S. 7–8; L15, PDF-S. 21–22 und 39–40. Einheiten, Grenzen und Hausvergleich: eigene Erläuterung.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.11 Rentabilität und das Risiko der Kapitalstruktur <a-1-11>

*Eigenkapitalrentabilität* bezieht den Jahresüberschuss auf das eingesetzte Eigenkapital. *Umsatzrentabilität* zeigt, welcher Anteil des Umsatzes als Jahresüberschuss verbleibt.
#form[$ r_e = "Jahresüberschuss"/"Eigenkapital" times 100% quad r_U = "Jahresüberschuss"/"Umsatzerlöse" times 100% $]
Beide sind Prozentwerte pro betrachteter Periode; EK und Umsatz müssen positive und passend definierte Bezugsgrößen sein. Laut Folie soll die EK-Rentabilität erheblich über dem marktüblichen Zins langfristiger Anlagen liegen, weil sie zusätzlich Unternehmensrisiko vergütet. Das ist eine Zielaussage, keine garantierte Rendite.

Die *Kapitalstruktur* beschreibt die Aufteilung in Eigen- und Fremdkapital. Wenig EK bedeutet ein kleines Verlustpolster; zusätzlich kommen beim FK feste Zinsansprüche hinzu. Die Folie vergleicht 80 %, 50 % und 25 % FK-Anteil: Bei gleichem Geschäftsrisiko steigt die finanzielle Verwundbarkeit mit der Verschuldung.

#note("Von Dir als nicht prüfungsrelevant markiert", [Folie 47 (Modigliani-Miller-Theorem) wird nicht vertieft. Ebenso bleibt die gestrichene Formel zum Unternehmensgesamtwert auf Folie 48 außerhalb der Lernaufgaben. Deine Hinweise an „Claude“ gelten gleichermaßen für Codex.])

#bild("kapitalrisiko-folie", [Gleiches Grundstück, unterschiedliche Finanzierung. V, PDF-S. 25, Folie 50.], height: 65mm)
*Hubert + Maier GmbH:* 100.000 € Gesamtkapital, davon 90.000 € für ein Grundstück und 10.000 € Kasse. Alternative A: 100.000 € EK; Alternative B: 20.000 € EK + 80.000 € FK zu 10 %. Das Grundstück fällt auf 70.000 €.

#tab(columns: (1.7fr, 1fr, 1fr),
 th([Jahresende, €], [A], [B]),
 [Grundstück], [70.000], [70.000],
 [Kasse nach Zinszahlung], [10.000], [2.000],
 [Vermögen], [80.000], [72.000],
 [Fremdkapital], [0], [80.000],
 [*Rechnerisches EK*], [*80.000*], [*−8.000*],
)
A verteilt 80.000 € EK hälftig auf Hubert und Maier, also je 40.000 €. Bei B bleiben die beiden Darlehensansprüche von je 40.000 € bestehen. Der *nicht durch Eigenkapital gedeckte Fehlbetrag* beträgt 8.000 €; er ist kein zusätzlich verwertbarer Vermögensgegenstand. Dasselbe Geschäftsrisiko trifft auf verschiedene Verlustpolster und Zinslasten. Die rechtlichen Voraussetzungen von Abschnitt 1.8 bleiben gesondert zu prüfen.
#src[V, PDF-S. 24–25 und 27 (Folien 48–50, 54); N2, PDF-S. 9–10 und 12; L15, PDF-S. 22–23. Prüfungsabgrenzung: Marios Hinweise/Bestätigung 22.10.2026.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.12 Leverage: Rendite und Risiko hebeln <a-1-12>

Der *Leverage-Effekt* beschreibt die Hebelwirkung der Verschuldung auf die Eigenkapitalrendite. Die Richtung hängt am Abstand zwischen Gesamtkapitalrendite $r_G$ und Fremdkapitalzins $r_f$. Der *Risikoeffekt* meint die größere Streuung der EK-Rendite bei höherer Verschuldung.
#form[$ r_G = r_e "EK"/("EK"+"FK") + r_f "FK"/("EK"+"FK") $]
#form[$ r_e = r_G + (r_G-r_f) "FK"/"EK" $]
$"FK"/"EK"$ ist der *Verschuldungsgrad*. Die Renditen müssen einheitlich als Dezimalzahlen oder Prozentwerte derselben Periode eingesetzt werden. Modell: gegebenes Gesamtkapital und $r_f$, keine zusätzlichen Steuereffekte, EK > 0. Eine vollständige FK-Finanzierung ist bei EK = 0 keine zulässige Einsetzung in diese Formel.

#bild("leverage-kurven", [Zwei eigene Hebelgeraden: $r_f=10%$, $r_G=20%$ bzw. $5%$. Nach V, PDF-S. 26.], height: 57mm)

Die Formel lässt sich aus der gewichteten Gesamtrendite herleiten: Mit $"EK"+"FK"$ multiplizieren, $r_f "FK"$ abziehen und durch EK teilen. So erhältst Du $r_e=r_G+(r_G-r_f)"FK"/"EK"$. Ist $r_G>r_f$, wächst $r_e$; bei Gleichheit ändert sie sich nicht; bei $r_G<r_f$ verstärkt das FK die schlechte Rendite.

*Folienbeispiel:* Gesamtkapital 100, Gewinn vor Zinsen 20. Ohne FK: 20/100 = 20 % EK-Rendite. Mit EK 50/FK 50 zu 10 %: Zinsen 5, Gewinn 15, EK-Rendite 15/50 = 30 %. *Die Quote steigt, der absolute Gewinn sinkt.* Mehr erwartete EK-Rendite ist im Modell mit höherem Risiko verbunden.

*Aktienbeispiel Deiner Mitschrift, ohne Zinsen gerechnet:* Mit 5.000 € EK sind bei +20 % Kursänderung 6.000 € vorhanden, bei −50 % noch 2.500 €. Mit zusätzlich 5.000 € FK werden 10.000 € angelegt: Bei +20 % bleiben nach 5.000 € Rückzahlung 7.000 € EK (+40 %), bei −50 % bleibt null (−100 %). Das ist eine schematische Erklärhilfe für beide Hebelrichtungen.
#bild("map-leverage", [Mindmap: Renditeabstand, Verschuldungsgrad und Risiko gemeinsam lesen. Eigene Darstellung nach V, PDF-S. 26–27.], height: 45mm)
#note("Fehler vermeiden", [Hohe EK-Rentabilität ist keine Begründung für beliebig viel Kredit. Zinszahlung und kleines Verlustpolster bleiben; im schlechten Jahr wirkt derselbe Hebel gegen die Eigentümer. Die Formel verspricht weder konstanten FK-Zins bei wachsender Verschuldung noch eine zusätzliche Wertschöpfung.], fill: sand)
#note("In der Altklausur 2017", [Aufgabe 3 (11 von 40 Punkten im Aufgabenteil) prüft genau diesen Hebel: Gesamtkapitalrentabilität, vier EK-Rentabilitäten, Beschreibung des Effekts und Argumente gegen hohe Verschuldung. Übung auf der Lernwebseite: „Klausur: Gründung mit 800.000 € Kapital“ und „Klausur: Leverage deuten und Risiken der Verschuldung“. K, PDF-S. 4–5.])
#src[V, PDF-S. 26–27 (Folien 51–53); N2, PDF-S. 11–12; L15, PDF-S. 23–24; K, PDF-S. 4–5. Herleitung, Gültigkeit und Kurven: eigene Erläuterung.]
#hoch(<a-1>, [Kapitelübersicht])

#pagebreak()
== 1.13 Glasspinnerei: den Kapitalbedarf gemeinsam planen <a-1-13>

*Ergänzung aus der Vorlesung vom 21.10.2026.* Die familiengeführte Glasspinnerei Straubing AG wächst, ihre Eigentümer wollen aber keine weiteren Einlagen leisten und erwarten jährliche Ausschüttungen. Der Finanzchef muss für 2005–2008 entscheiden: Wie viel Geld fehlt wann, obwohl das Kerngeschäft viel erwirtschaftet?

#bild("map-glasspinnerei", [Mindmap der integrierten Kapitalbedarfsrechnung. Eigene Darstellung nach G, PDF-S. 4 und 7–15.], height: 45mm)

Der Fall beschreibt etwa 90 % Marktanteil im regionalen Isolierfasersegment und bisher etwa 20 % jährliches Umsatzwachstum. Die Produktion läuft im Modell ganzjährig kontinuierlich: Rohstoffgemenge schmelzen → Glasstrom durch Düsen → Fasern auf das Band → Bindemittel/Walzen/Öfen oder Mineralölbehandlung. Vierjährige Ofenauskleidung und Kapazitätsausbau verbinden Produktion und Finanzplanung.

#tab(columns: (1.6fr, 2.6fr),
 th([Ausgangsdaten], [Fallannahme]),
 [Menge], [2004: 17.777 t; 2005: 20.000 t. Geplanter Ausbau +10 t/Tag auf maximal 75 t/Tag.],
 [Investition 2005], [85 Mio. €: 30 Mio. Gebäude + 55 Mio. Anlagen/Ausrüstung; Erweiterung von Ofen, Gebäude, Transportband und Lager.],
 [Planung], [Vier Jahre, 2005–2008; Menge zunächst rund +12,5 %; 2008 begrenzt auf die Kapazität 27.375 t/Jahr (365 × 75). Preis 2005: 13.500 €/t (+4,8 %), danach jährlich +9 %.],
 [Material], [Historisch 3.100 / 3.120 / 3.245 €/t (2002–2004). 2005 Preise +10,9 %, später +9 %, unveränderte Technik.],
 [Löhne], [Keine zusätzlichen Kräfte; 2005 +20 %, danach +11 % (Nachholen ausgebliebener Erhöhungen).],
 [Sonstiges / Eigentümer], [Sonstige betriebliche Aufwendungen jährlich +10 %; Ausschüttung jährlich 3,120 Mio. €.],
)

Menge × Preis ergibt Nettoumsatz. Der Materialbedarf hängt sowohl von der Menge als auch vom Preis je Tonne ab. Wer nur das Umsatzwachstum fortschreibt und die Kapitalbindung ignoriert, unterschätzt leicht den Finanzierungsbedarf.

*Drei Instrumente greifen ineinander:* Der Finanzplan braucht die Zahlungen, die Plan-GuV die Aufwendungen einschließlich Zinsen und Abschreibungen, die Planbilanz Bestände wie Lager, Forderungen und Verbindlichkeiten. Steuern stammen aus der GuV; Zinsen hängen von der Finanzierung ab, deren Höhe erst der Finanzplan zeigt. Das ist eine Abstimmungsschleife.
#src[G, PDF-S. 1–8 (Folien 2–16); die dort genannten Buchseiten sind nur Folien-Sekundärnachweise. Datierung der Behandlung: Mario, 22.10.2026.]

=== 1.13.1 Historische Daten als Startpunkt <a-1-13-1>
#bild("g-bilanz-aktiva", [Historische Aktiva 2002–2004, Originaltabelle in T€. G, PDF-S. 6, Folie 11.], height: 92mm)
#bild("g-bilanz-passiva", [Historische Passiva 2002–2004, Originaltabelle in T€. G, PDF-S. 6, Folie 12.], height: 92mm)
#bild("g-guv-historie", [Historische Gewinn- und Verlustrechnungen 2002–2004, T€. G, PDF-S. 7, Folie 13.], height: 92mm)
Die Bilanzsumme 2004 beträgt rund 137,5 Mio. €. Daran gemessen ist die Investition von 85 Mio. € groß. Die historischen Bilanzen liefern Bestände und Finanzierungsverpflichtungen; die GuV liefert die Basis für Preis-, Kosten- und Steuerplanung. Diese Daten werden hier als Originaltabellen erhalten.
#src[G, PDF-S. 6–7.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.14 EBK und NOCF: Wachstum bindet Geld <a-1-14>

Das *erforderliche Betriebskapital (EBK)* ist der Saldo operativ gebundener und operativ finanzierter Bestände. Vorräte und Forderungen binden Mittel; Lieferantenverbindlichkeiten und erhaltene Anzahlungen liefern einen Finanzierungsbeitrag. Eine Zunahme des EBK verbraucht Zahlungsmittel.
#form[$ "EBK" = "LB" + "FLei" + "Fa" + "GA" - ("VLei" + "EA") $]
#form[$ Delta "EBK"_t = "EBK"_t - "EBK"_(t-1) $]
LB = Lagerbestände; FLei = Forderungen aus Lieferungen und Leistungen; Fa = andere Forderungen; GA = geleistete Anzahlungen; VLei = Lieferverbindlichkeiten; EA = erhaltene Anzahlungen. EBK ist ein Geldbestand, $Delta "EBK"$ eine Änderung pro Planperiode. Der Fall zieht in der erweiterten historischen Tabelle außerdem kurzfristige Rückstellungen ab; Definitionen dürfen nicht vermischt werden.

#note("Fehler und Definitionen in der Quelle", [G, PDF-S. 8, nennt für VLei 10 % des Nettoumsatzes und merkt selbst an: eigentlich 12 %, aus Kontinuität wird mit 10 % gerechnet. Wir übernehmen *10 % für den Planfall* und markieren die Abweichung. In der NOCF-Zeile auf G, PDF-S. 9, steht typografisch „− EBK“; die Erläuterung und die Tabellen verwenden die *Änderung* $-Delta "EBK"$. Den ganzen Bestand jedes Jahr nochmals abzuziehen wäre falsch.], fill: sand)

#tab(columns: (1.3fr, 1fr, 1fr, 1fr),
 th([Historie, T€], [2002], [2003], [2004]),
 [Lager], [12.392], [19.733], [23.529],
 [Forderungen L&L], [21.362], [26.462], [31.564],
 [− Verbindlichkeiten L&L], [−24.821], [−30.591], [−18.884],
 [− Rückstellungen Lizenzen/Löhne], [−4.711], [−4.595], [−7.744],
 [− Steuerrückstellungen], [−15.916], [−21.923], [−19.348],
 [*EBK laut Tabelle*], [*−11.694*], [*−10.914*], [*9.117*],
 [*Änderung*], [–], [*+780*], [*+20.031*],
)
*Eigene Rechenprüfung:* 2004 addieren sich die angezeigten Einzelwerte zu 9.117 T€. Für 2002 ergeben die angezeigten Werte −11.694 T€, für 2003 −10.914 T€. Der Sprung 2004 zeigt, dass sich die Mittelbindung auch bei einem gewinnbringenden Unternehmen stark verändern kann.

Der *Net Operating Cashflow (NOCF)* isoliert den Zahlungsbeitrag des Kerngeschäfts. Das System der Fallstudie trennt ihn von Finanzanlagenerträgen, bereits in früheren Perioden festgelegten Finanzierungsvorgängen und neu geplanten Investitions-/Finanzierungsvorgängen. Diese feinere Gliederung ergänzt das Drei-Bereiche-Modell.
#form[
$ "NOCF" = "Nettoumsatz" - "Material" - "Löhne" $
$ quad - "sonst. betriebl. Aufwendungen" + "sonst. betriebl. Erträge" $
$ quad - "Steuerzahlungen" - Delta "EBK" $
]
Alle Ströme und die Bestandsänderung in derselben Periode/Geldeinheit; die Abgrenzung der betrieblichen Bestände muss zu den Kosten und Steuerzahlungen passen. Die Zinsen auf Kredite stehen in diesem System erst in der folgenden Finanzierungsschicht.

#bild("g-nocf-plan", [Tabelle 3.7: NOCF-Plan 2005–2008, T€. G, PDF-S. 11, Folie 22.], height: 94mm)
#bild("g-ebk-plan", [Tabelle 3.8: EBK im Plan und Bestandskorrekturen. G, PDF-S. 12, Folie 23.], height: 100mm)

Im vereinfachten Plan gilt für die drei Umsatzquoten zunächst $"LB"=9%"NU"$, $"FLei"=13%"NU"$, $"VLei"=10%"NU"$. Der bloße Saldo dieser drei Posten wäre 12 % des Umsatzes. Die Falltabelle enthält darüber hinaus Rückstellungen; deshalb ist ihr EBK nicht einfach jedes Jahr 12 % des Umsatzes. Über 2005–2008 nennt der Fall rund 16 Mio. € zusätzlichen Bedarf aus dem EBK-Wachstum.
#src[G, PDF-S. 8–12 (Folien 15–24). Formeln, Definitionen und selbst markierter Buchfehler aus den Folien; Rechen-/Notationsprüfung: eigene Ergänzung.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.15 Abschreibung, Steuer und Finanzplan zusammenführen <a-1-15>

Die Fallstudie rechnet mit einer historischen *Modell-Steuerbelastung von 50 %* und besonderen Abschreibungsannahmen. Diese Vorgaben werden als Fallannahmen von 2005–2008 verwendet, nicht als Aussage über heutiges Steuerrecht. Abschreibung ist kein unmittelbarer Geldabfluss, beeinflusst aber über den Gewinn die modellierten Steuerzahlungen.

#tab(columns: (1.3fr, 1.4fr, 1.7fr),
 th([Neue Investition, Mio. €], [Linear], [Beschleunigt im Fall]),
 [Gebäude 30, zehn Jahre], [3 pro Jahr], [22,5 im Jahr 2005; danach 7,5/9 ≈ 0,833 pro Jahr],
 [Anlagen 55, vier Jahre], [13,75 pro Jahr], [41,25 im Jahr 2005; danach 13,75/3 ≈ 4,583 pro Jahr],
)

Bestehende Anlagen verursachen ab 2005 13,259 Mio. € Abschreibung: 3,259 auf Gebäude und 10 auf Maschinen. Im Anschaffungsjahr kommen 63,750 Mio. € Sofortabschreibung der Neuanlagen hinzu. Die hohen Aufwendungen können einen bilanziellen Verlust auslösen, obwohl das Kerngeschäft hohe Zahlungsmittel generiert.

*Finanzierungsvorgaben:* 2005 ein langfristiger Kredit über 20 Mio. € zu 8 %, erste Zinsen 2006, Tilgung ab 2006 jährlich 2 Mio. €. Zusätzlich 5 Mio. € Kredit zu 8 %, Rückzahlung 2008, erste Zinsen ebenfalls 2006. Die Bezeichnung „kurzfristig“ für den dreijährigen Kredit stammt aus dem Fall. Die jährliche Ausschüttung von 3,120 Mio. € ist eine weitere Zahlung, kein Aufwand der GuV.

#bild("g-steuer-guv", [Tabelle 3.9: Plan-GuV und Steuerrechnung des Falls. G, PDF-S. 14, Folie 27.], height: 100mm)
#bild("g-nocf-steuern", [NOCF nach den modellierten Steuern. G, PDF-S. 14, Folie 28.], height: 51mm)

Nach dem NOCF werden Finanzanlagenausschüttungen, erhaltene Zinsen und Rückzahlungen auf Ausleihungen hinzugerechnet. Davon gehen Zinsen/Tilgungen auf Altkredite, Leasing-/Pacht-/Mietraten und weitere bereits festgelegte Finanzierungszahlungen ab. Danach folgen neue Kapitalaufnahme, außerordentliche Tilgung/Rückkäufe, Zinsen auf neue Kredite, Real- und Finanzinvestitionen, Ausschüttungen und Anlagenverkäufe. Die letzten Schritte unterscheiden Cashflow-Saldo, kurzfristig kündbare Verbindlichkeiten und Wertpapier-/Bankbestände bis zur Kasse im engeren Sinn.

#bild("g-finanzplan", [Tabelle 3.11: der gesamte Finanzplan 2005–2008. G, PDF-S. 15, Folie 29.], height: 104mm)
Für 2005 nennt der Fall einen *Finanzierungsbedarf von 23,03 Mio. €*. 85 Mio. € Investitionen minus 25 Mio. € neue Kredite sind eben noch nicht der endgültige Bedarf: Das Kerngeschäft und eine EBK-Freisetzung von etwa 2,5 Mio. € liefern weitere Mittel. Die späteren Planjahre zeigen hohe Überschüsse. Eine Zwischenfinanzierung ist im Modell daher denkbar, wenn die Bank die Prognosen für verlässlich hält.
#src[G, PDF-S. 9–10 und 12–15 (Folien 17–30). Historische Steuer- und Abschreibungsvorgaben ausschließlich als Fallannahmen.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.16 Planbilanz: Verlust und Zahlungsdefizit unterscheiden <a-1-16>

Die Planbilanz zeigt die Bestandsfolgen der getroffenen Entscheidungen. Hohe Abschreibungen senken Buchwerte und Eigenkapital, während der Finanzplan die tatsächlichen Zahlungswirkungen getrennt zeigt. Derselbe wirtschaftliche Vorgang kann deshalb bilanziell kritisch und operativ zahlungsstark erscheinen.
#bild("g-planbilanz", [Tabelle 3.12: Bilanz 2004 und Planbilanz 2005. G, PDF-S. 16, Folie 32.], height: 104mm)

#form[$ "Gebäude Ende" = "38,805" - "3,259" + 30 - "22,500" = "43,046" $]
#form[$ "Maschinen Ende" = "16,302" - 10 + 55 - "41,250" = "20,052" $]
Alle Angaben in Mio. €. Die 38,805/16,302 sind Anfangsbestände; 3,259/10 alte Abschreibungen; 30/55 Zugänge; 22,500/41,250 die neuen Abschreibungen. In den Originaltabellen stehen die entsprechenden Tausendwerte.

Langfristige Bankkredite steigen um 20 Mio. €, der weitere Bankkredit um 5 Mio. €. Die Planung schließt die verbleibende Lücke zunächst *formal* durch zusätzliche Gesellschafterdarlehen: 11 Mio. € Altbestand werden zu rund 34 Mio. €. Das ist eine Rechenannahme, obwohl die Eigentümer gerade kein weiteres Geld geben wollen.

Die Gewinnrücklagen sinken durch die gewünschte Ausschüttung um 3,120 Mio. € von 11,168 auf 8,048 Mio. €. Der hohe Verlustvortrag übersteigt im ursprünglichen Abschluss das ausgewiesene Eigenkapital. Der Kassenbestand verändert sich laut Überleitung um −29 T€ von 7,816 auf 7,787 Mio. €. Deshalb müssen Zahlungsrechnung und Bilanz gemeinsam gelesen werden.
#bild("g-ueberleitung", [Tabelle 3.13: Überleitung der Kassenänderung 2005, T€. G, PDF-S. 19, Folie 38.], height: 96mm)

#note("Begriff sauber halten", [Ein negativer handelsbilanzieller Eigenkapitalbetrag ist nicht automatisch die rechtliche Überschuldung. Der Fall weist selbst auf diese Trennung hin. Auch ein qualifizierter Rangrücktritt beseitigt nicht allein durch Umbenennen den handelsbilanziellen Verlust. Aussagen der historischen Fallfolie zur Ausschüttungszulässigkeit werden als damalige Diskussionsansätze verstanden, nicht als pauschale geltende Rechtsfolge.], fill: sand)
#src[G, PDF-S. 16–19 und 21–22 (Folien 31–38, 42–44); rechtliche begriffliche Präzisierung: eigene Ergänzung nach #link("https://www.gesetze-im-internet.de/inso/__19.html")[§ 19 InsO], Abruf 22.10.2026.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.17 Finanzierungslücke gezielt verändern <a-1-17>

Jetzt wird an den Annahmen gedreht. Entscheidend ist, *welche* Zahlung oder Kapitalbindung sich ändert und in *welcher* Periode die Wirkung eintritt. Ein späterer Mittelüberschuss bezahlt die Investitionsrechnung von 2005 erst, wenn eine Brücke vorhanden ist.

#tab(columns: (1.2fr, 2.7fr),
 th([Ansatz im Fall], [Wirkung und Grenze]),
 [Investitionen strecken], [Nur 80 % der 85 Mio. € in 2005, 20 % in 2006 zahlen: 17 Mio. € weniger Bedarf 2005, entsprechend mehr Zahlung 2006.],
 [Forderungen schneller einziehen], [FLei von 13 % auf 9,5 % des Nettoumsatzes senken. Bei 270 Mio. € Umsatz werden gegenüber dem Basisplan 9,45 Mio. € weniger gebunden.],
 [Kassenreserve einsetzen], [2004 rund 7,8 Mio. € Kasse; im Fall gelten rund 2 % des damaligen Nettoumsatzes ≈ 4,6 Mio. € als operativ nötig. Nur der darüberliegende Teil ist zusätzlich einsetzbar.],
 [Steuerrückzahlung], [Historische Fallannahme: Verlustrücktrag über zwei Jahre könnte bei Rückzahlung im Jahr 2005 Liquidität liefern. Betrag und Zeitpunkt müssen gesondert geplant werden.],
 [Zwischenkredit], [Verbleibende vorübergehende Lücke auf Basis verlässlicher künftiger Überschüsse und ggf. Sicherheiten finanzieren. Das ist abhängig von den Prognosen.],
)

#bild("g-forderungen", [Tabelle 3.14: EBK bei veränderten Forderungsquoten. G, PDF-S. 20, Folie 40.], height: 96mm)
Im Basisplan liegt EBK 2005 bei rund 6,6 Mio. €. Mit der neuen Forderungsquote werden es rund −2,8 Mio. €. Gegenüber EBK 2004 von 9,117 Mio. € werden damit rund 11,9 Mio. € freigesetzt. *Wichtig:* 11,9 Mio. € sind die neue Freisetzung gegenüber dem Vorjahr; die zusätzliche Verbesserung *gegenüber dem Basisplan* beträgt nur rund 9,45 Mio. €. Sie darf nicht noch einmal vollständig auf die alte Finanzierungslücke aufgeschlagen werden.

*Eigene Kontrollrechnung:* Die beiden Maßnahmen Investitionsstreckung und Forderungsabbau verbessern 2005 zusammen um $17+"9,45"="26,45"$ Mio. €. Das übersteigt die ursprüngliche Lücke von 23,03 Mio. € im Modell um rund 3,42 Mio. €. Ob die Kunden- und Lieferantenbedingungen durchsetzbar sind, bleibt eine Annahme des Falls.
#src[G, PDF-S. 20–21 (Folien 39–41). Vergleich der Ausgangsbasen und Kontrollrechnung: eigene Ergänzung aus den Folienwerten.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.18 Bilanzdarstellung, Alternativen und Fazit der Fallstudie <a-1-18>

Der Fall unterscheidet zwei Probleme: eine Finanzierungslücke von rund 23 Mio. € und ein negatives bilanzielles EK. Maßnahmen zur einen Größe verändern die andere nicht zwangsläufig. Deshalb muss der Finanzchef alternative Pläne durchrechnen und ihre Ursachen erläutern.

*Alternative Abschreibung:* Neue Gebäude linear statt sofort zu 75 % abzuschreiben senkt den Abschreibungsaufwand 2005 um $"22,5"-3="19,5"$ Mio. €. Der im Fall diskutierte Verlustvortrag sinkt von 39,41 auf 19,91 Mio. €. Der bilanzielle EK-Ausweis wird dadurch positiv; dafür verschiebt sich der steuerliche Vorteil. Der Fall sieht diese Änderung bei den Gebäuden als die kostengünstigere Darstellungsalternative gegenüber dem Verzicht auf die Sonderabschreibung der Maschinen.

*Alternative Nachrang:* Für bestehende Gesellschafterdarlehen von 11 Mio. € diskutiert der Fall einen unwiderruflichen qualifizierten Rangrücktritt; an anderer Stelle bezieht er alle alten und zunächst unterstellten neuen Darlehen von rund 34 Mio. € ein. Das sind verschiedene Bezugsgrößen. Der Rang kann für die Überschuldungsprüfung relevant sein; das Darlehen und seine vertraglichen Bedingungen bleiben zu prüfen.

#note("Historische Quelle und aktueller Begriff", [G, PDF-S. 21, beschreibt den Prognosehorizont als „bis Ende des nächsten Geschäftsjahres“. Der heutige § 19 Abs. 2 nennt *die nächsten zwölf Monate*. Der Falltext und das heutige Kriterium werden hier sichtbar getrennt. Die positive Fortführungsbeurteilung des Falls setzt die Finanzierung des prognostizierten Engpasses voraus.], fill: sand)

*Der Zusammenhang der Fallstudie:* Absatzplanung liefert Menge/Preis; daraus folgen Kosten und operative Bestandsbindungen. Die Plan-GuV liefert die Steuerbasis; die Finanzierungsentscheidungen liefern Zinsen und Tilgungen. Erst NOCF, Investitionen, Ausschüttungen, Kapitalaufnahme und verfügbare Reserven zusammen ergeben den Kapitalbedarf. Die Planbilanz erklärt zugleich Buchwerte und Verlustpolster.

Die Fallstudie bezeichnet Fortführungsbilanzen bei der Liquiditätsmessung als Mischform: Sie sind weder eine reine Liquidationswertrechnung noch eine direkte Barwertrechnung künftiger Zahlungen. Trotzdem liefern sie wichtige Rohdaten. Ein externer Kreditgeber muss erkennen können, ob der hohe Verlust aus den Sonderabschreibungen stammt und ob der Mittelbedarf nur vorübergehend ist. Ein bloßer Jahresfehlbetrag oder ein isolierter Cashflow genügt dafür nicht.

#note("Selbst erklären", [Wie kann die Glasspinnerei Verlust ausweisen und trotzdem einen hohen NOCF haben? *Weil die Abschreibung den Erfolg mindert, ohne in derselben Periode Geld abfließen zu lassen.* Steuerwirkung, Investitionszahlung und Betriebskapital müssen trotzdem vollständig in den Finanzplan.])
#src[G, PDF-S. 16 und 18–24 (Folien 31, 35–48); rechtlicher Abgleich: eigene Ergänzung nach #link("https://www.gesetze-im-internet.de/inso/__19.html")[§ 19 Abs. 2 InsO], Abruf 22.10.2026.]

*Der Zusammenhang in Kapitel 1.* Ziele bestimmen die Finanzierungsentscheidung. Herkunft und Rechte erklären die Kapitalformen. Erfolg und Zahlungen sind zu trennen, bevor Cashflow und Finanzplan aufgebaut werden. Kennzahlen und Leverage zeigen Deckung, Verlustpolster und Risiko; die Glasspinnerei führt diese Bausteine mit EBK, Steuern und Investitionen zu einer abgestimmten Kapitalbedarfsrechnung zusammen.
#src[V, PDF-S. 3–27; G, PDF-S. 4, 7–15 und 24. Eigene Zusammenfassung der genannten Abschnitte.]
#hoch(<a-1>, [Kapitelübersicht])


= Anhang
== Formelsammlung mit Voraussetzungen

Geldgrößen immer in derselben Währung und Periode einsetzen. Prozentgrößen einheitlich als Dezimalzahl oder Prozentwert verwenden; Bestandsgrößen und jährliche Zahlungsströme unterscheiden.

#tab(columns: (1.2fr, 1.9fr, 1.8fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Gewinn], [$"Erträge"-"Aufwendungen"$], [Erfolg einer Periode, €; V PDF-S. 9–10.],
 [Zahlungssaldo / CF direkt], [$"Einzahlungen"-"Auszahlungen"$], [Abgrenzung des CF-Bereichs festlegen, €/Periode; V PDF-S. 9.],
 [CF indirekt, einfach], [JÜ + auszahlungsloser Aufwand − einzahlungsloser Ertrag], [Vereinfachtes Modell ohne weitere Abgrenzungen; V PDF-S. 9.],
 [CF operativ, erweitert], [JÜ + nicht zahlungswirksamer Aufwand − nicht zahlungswirksamer Ertrag − ΔForderungen + ΔLieferverbindlichkeiten + erhaltene − geleistete Anzahlungen], [Korrekturen passend zu Periode und Bereich, keine Doppelzählung; V PDF-S. 12.],
 [Kassenbestand], [$K_t=K_(t-1)+"CF op"+"CF inv"+"CF fin"$], [Ohne zusätzliche Wechselkurs-/Bewertungseffekte, €; V PDF-S. 12.],
 [Free Cashflow], [$"CF operativ"-"Investitionsauszahlungen"$], [Hier Sachanlagen/immaterielle Zugänge; nicht automatisch gesamter Investitionssaldo; V PDF-S. 13.],
 [Liquiditätsplan], [$K_t=K_(t-1)+E_t-A_t$], [Ende wird nächster Anfang; gleiche Periode, €; V PDF-S. 15–16.],
 [Freie Kreditlinie], [Limit − genutzter Kontokorrentkredit], [≥ 0 bei eingehaltenem Limit; €; V PDF-S. 15–16.],
 [Verfügbare Liquidität], [Positiver Zahlungsmittelbestand + freie Kreditlinie], [Negative Kontoposition nicht doppelt abziehen; eigene Präzisierung aus V PDF-S. 15–16 / L15 PDF-S. 18.],
 [Lineare AfA], [$"Anschaffungskosten"/"Nutzungsdauer"$], [Ohne Restwert, €/Jahr; V PDF-S. 11 / G PDF-S. 13.],
 [Rechnerisches EK], [$"Vermögen"-"Schulden"$], [Bilanzielle Größe, keine vollständige Rechtsprüfung; V PDF-S. 17, § 19 InsO.],
 [Zahlungsdeckungsquote], [$"begleichbare Pflichten"/"fällige Pflichten" times 100%$], [Dreiwochenorientierung der Folie; 90 % keine sichere Freigrenze, vgl. Abschnitt 1.8; V PDF-S. 16.],
 [Liquidität 1. Grades], [$"flüssige Mittel"/"kurzfristiges FK" times 100%$], [Folienziel 10–30 %, Nenner > 0; V PDF-S. 21.],
 [Liquidität 2. Grades], [$("flüssige Mittel"+"Forderungen")/"kurzfristiges FK" times 100%$], [Folienziel ≥ 100 %; V PDF-S. 21.],
 [Liquidität 3. Grades], [$"Umlaufvermögen"/"kurzfristiges FK" times 100%$], [Folienziel ≥ 200 %; V PDF-S. 21.],
 [Anlagendeckung I], [$"EK"/"AV" times 100%$], [AV > 0; V PDF-S. 22.],
 [Anlagendeckung II], [$("EK"+"langfr. FK")/"AV" times 100%$], [Goldene Bilanzregel ≥ 100 %; V PDF-S. 22.],
 [Schuldentilgungsfähigkeit], [$"Verbindlichkeiten"/"Cashflow"$], [Jahre bei positivem jährlichem CF, unterstellter Verfügbarkeit; V PDF-S. 22.],
 [„Selbstfinanzierungsquote“ der Folie], [$"Anlagevermögen"/"Cashflow"$], [Dimensionsmäßig Jahre bei jährlichem CF, keine Prozentquote; V PDF-S. 22.],
 [Anlageintensität], [$"Anlagevermögen"/"Gesamtvermögen" times 100%$], [Positive Bezugsgröße, Bilanzstichtag; V PDF-S. 23.],
 [Eigenkapitalquote], [$"EK"/"Gesamtkapital" times 100%$], [Folienziel mindestens 15–20 %; V PDF-S. 23.],
 [Fremdkapitalquote], [$"FK"/"Gesamtkapital" times 100%$], [EK-Quote + FK-Quote = 100 % im Zweiteilungsmodell; V PDF-S. 23.],
 [EK-Rentabilität], [$"JÜ"/"EK" times 100%$], [EK > 0, gleiche Periode; V PDF-S. 27.],
 [Umsatzrentabilität], [$"JÜ"/"Umsatzerlöse" times 100%$], [Umsatz > 0, gleiche Periode; V PDF-S. 27.],
 [Gesamtrendite], [$r_G=r_e "EK"/("EK"+"FK")+r_f "FK"/("EK"+"FK")$], [Einheitliche Renditeeinheit, Folienmodell; V PDF-S. 26.],
 [Gesamtkapitalrentabilität (Altklausur)], [$("Gewinn vor FK-Zinsen")/"Gesamtkapital" times 100%$], [Gewinn nach Zinsen + FK-Zinsen; gleiche Periode; K, PDF-S. 4.],
 [Verschuldungsgrad], [$"FK"/"EK"$], [EK > 0; dimensionslos; V PDF-S. 26.],
 [Leverage], [$r_e=r_G+(r_G-r_f)"FK"/"EK"$], [EK > 0; gegebener FK-Zins, keine zusätzlichen Steuern im Modell; V PDF-S. 26.],
 [Nettoumsatz], [$"Menge" times "Preis je Einheit"$], [z. B. t × €/t = €; Kapazitätsgrenze beachten; G PDF-S. 5 und 11.],
 [EBK, kurze Definition], [$"LB"+"FLei"+"Fa"+"GA"-("VLei"+"EA")$], [Geldbestand, Abkürzungen Abschnitt 1.14; G PDF-S. 10.],
 [EBK, Glasspinnerei-Tabelle], [$"LB"+"FLei"-"VLei"-"RückL"-"RückSt"$], [Lizenz-/Steuerrückstellungen eingeschlossen, T€; G PDF-S. 12.],
 [EBK-Änderung], [$Delta "EBK"_t="EBK"_t-"EBK"_(t-1)$], [Positiv bindet, negativ setzt Mittel frei; G PDF-S. 10–12.],
 [NOCF], [Operativer Überschuss vor Steuer/EBK − Steuerzahlungen − ΔEBK], [Kosten-/Bestandsabgrenzungen müssen zusammenpassen; G PDF-S. 9–14.],
 [Sofort-AfA im Fall], [$"0,75" times "Anschaffungskosten"$], [Historische Fallannahme 2005; G PDF-S. 13.],
 [Rest-AfA im Fall], [$"0,25" times "Anschaffungskosten"/("Nutzungsdauer"-1)$], [Linear ab Folgejahr, historische Fallannahme; G PDF-S. 13.],
 [Steuer im Fall], [$"0,50" times "positive Steuerbasis nach Verlustverrechnung"$], [Nur historische Modellannahme, keine aktuelle Steuerregel; G PDF-S. 14.],
)

#note("Wichtige Zahlen", [*Folienorientierungen:* L1 10–30 %, L2 ≥ 100 %, L3 ≥ 200 %, AD II ≥ 100 %, EK-Quote mindestens 15–20 %. *Glasspinnerei:* Investition 85 Mio. € = 30 + 55; NOCF 2005 vor/nach laufender Modellsteuer 43,305 Mio. €; Finanzierungslücke 2005 23,029 Mio. €. Diese Werte gelten nur mit den genannten Voraussetzungen.])
#src[V, PDF-S. 9–27; G, PDF-S. 10–15; Voraussetzungen/Einheiten: eigene Erläuterung. Rechtsabgleich der Zahlungsquote und Überschuldung in Abschnitt 1.8.]
