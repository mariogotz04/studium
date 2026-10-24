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
  #text(size: 8pt, fill: muted)[Feynman-Lernskript · Stand 24.10.2026]
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

*Stand 24.10.2026:* Grundlagen der Finanzplanung bis Folie 54 sowie die Fallstudie Glasspinnerei aus der Vorlesung vom 21.10.2026. Neu: die Aufgaben 3 und 4 der Altklausur 2017 (Leverage, Cashflow, Innenfinanzierung) als Aufgaben 86–89 mit Lösungen; ihre Aufgaben 1 und 2 (Darlehen, Kreditsicherheiten, Kapitalerhöhung) folgen, sobald Kapitel B und C behandelt sind. Die Sachinhalte und Rechenfälle des Lernskripts vom 15.10. sind übernommen; die Lösungen stehen getrennt hinter den offenen Aufgaben. Fachliche Grundlage sind Deine Vorlesungsunterlagen, ergänzt um sichtbar gekennzeichnete Erklärhilfen und den Abgleich widersprüchlicher Insolvenzaussagen mit Primärquellen.

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
= Kapitel 1 · Grundlagen der Finanzplanung

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
#note("In der Altklausur 2017", [Aufgabe 4 verlangt genau diese beiden Wege an einer GuV (5 Punkte) und dazu zwei weitere Formen der Innenfinanzierung (1 Punkt). Übung: Aufgaben 88 und 89. K, PDF-S. 6.])
#src[V, PDF-S. 9 und 11–12 (Folien 18, 21–24); M, PDF-S. 3; L15, PDF-S. 8–10 und 14; K, PDF-S. 6. Varianten und Voraussetzungen: eigene Erklärhilfe.]

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
#note("In der Altklausur 2017", [Aufgabe 3 (11 von 40 Punkten im Aufgabenteil) prüft genau diesen Hebel: Gesamtkapitalrentabilität, vier EK-Rentabilitäten, Beschreibung des Effekts und Argumente gegen hohe Verschuldung. Übung: Aufgaben 86 und 87. K, PDF-S. 4–5.])
#src[V, PDF-S. 26–27 (Folien 51–53); N2, PDF-S. 11–12; L15, PDF-S. 23–24; K, PDF-S. 4–5. Herleitung, Gültigkeit und Kurven: eigene Erläuterung.]

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


#pagebreak()
== Verständnisfragen und Rechenaufgaben · Kapitel 1

Erkläre zuerst ohne Vorlage. Rechne mit Einheiten, nenne die Annahmen und prüfe das Ergebnis. Die Herkunft eigener Übungszahlen ist jeweils angegeben. Gleiche Sachinhalte früherer Auswahlfragen sind in diesen offenen Fragen und den Erklärungen enthalten.

// Altquelle A1
#block(breakable: false)[
*1 · übernommene Verständnisfrage*

#text("Nenne die drei Ziele der Finanzierung und das Sachziel mit seinen vier „richtig“.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A1. Verfahren: #stelle(<a-1-1>).]
]

// Altquelle A2
#block(breakable: false)[
*2 · übernommene Verständnisfrage*

#text("Erkläre das magische Dreieck. Nenne zu jeder Ecke ein Beispiel, warum sie mit einer anderen in Konflikt steht.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A2. Verfahren: #stelle(<a-1-1>).]
]

// Altquelle A3
#block(breakable: false)[
*3 · übernommene Verständnisfrage*

#text("Definiere Außen- und Innenfinanzierung in je einem Satz.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A3. Verfahren: #stelle(<a-1-2>).]
]

// Altquelle A4
#block(breakable: false)[
*4 · übernommene Verständnisfrage*

#text("Nenne die vier Unterschiede zwischen Außen- und Innenfinanzierung.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A4. Verfahren: #stelle(<a-1-2>).]
]

// Altquelle A5
#block(breakable: false)[
*5 · übernommene Verständnisfrage*

#text("„Es kommt immer auf die Gegenleistung an.“ Erkläre den Satz anhand von Zins, Gewinn, Rückzahlung, Stimmrechten und Kündigungsrecht.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A5. Verfahren: #stelle(<a-1-2>).]
]

// Altquelle A6
#block(breakable: false)[
*6 · übernommene Verständnisfrage*

#text("Warum kann eine Bank faktisch Einfluss auf ein Unternehmen nehmen, obwohl Fremdkapitalgeber keine Leitungsrechte haben?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A6. Verfahren: #stelle(<a-1-2>).]
]

// Altquelle A7
#block(breakable: false)[
*7 · übernommene Verständnisfrage*

#text("Nenne die sechs Merkmale, in denen sich Eigen- und Fremdkapital unterscheiden.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A7. Verfahren: #stelle(<a-1-2>).]
]

// Altquelle A8
#block(breakable: false)[
*8 · übernommene Verständnisfrage*

#text("Ordne den Finanzierungsformen nach Drukarczyk zu (Nr. 1–9): a) Bankkredit, b) Darlehen eines GmbHGesellschafters an seine GmbH, c) Kapitalerhöhung durch die bisherigen Gesellschafter, d) Aufnahme eines neuen Gesellschafters, e) Gewinn wird nicht ausgeschüttet, f) Verkauf einer nicht mehr benötigten Lagerhalle.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A8. Verfahren: #stelle(<a-1-2>).]
]

// Altquelle A9
#block(breakable: false)[
*9 · übernommene Verständnisfrage*

#text("Worin unterscheiden sich Eigenfinanzierung und Selbstfinanzierung?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A9. Verfahren: #stelle(<a-1-2>).]
]

// Altquelle A10
#block(breakable: false)[
*10 · übernommene Verständnisfrage*

#text("Definiere Liquidität. Warum hat das Liquiditätsziel die höchste Bedeutung in der Zielhierarchie?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A10. Verfahren: #stelle(<a-1-3>).]
]

// Altquelle A11
#block(breakable: false)[
*11 · übernommene Verständnisfrage*

#text("Erkläre an einem Beispiel, wie ein Unternehmen Gewinn machen und trotzdem zahlungsunfähig werden kann.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A11. Verfahren: #stelle(<a-1-3>).]
]

// Altquelle A12
#block(breakable: false)[
*12 · übernommene Verständnisfrage*

#text("Nenne die vier Liquiditätsquellen aus Folie 14 mit je einem Beispiel.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A12. Verfahren: #stelle(<a-1-3>).]
]

// Altquelle A13
#block(breakable: false)[
*13 · übernommene Verständnisfrage*

#text("Warum ist eine 4-jährige Bundesanleihe liquider als ein Sparbrief mit 2 Jahren Restlaufzeit?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A13. Verfahren: #stelle(<a-1-3>).]
]

// Altquelle A14
#block(breakable: false)[
*14 · übernommene Verständnisfrage*

#text("Warum ist die Bilanz nur bedingt geeignet, die Liquidität zu messen?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A14. Verfahren: #stelle(<a-1-3>).]
]

// Altquelle A15
#block(breakable: false)[
*15 · übernommene Verständnisfrage*

#text("Erkläre den Unterschied zwischen Aufwand und Auszahlung sowie zwischen Ertrag und Einzahlung mit je einem Beispiel.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A15. Verfahren: #stelle(<a-1-4>).]
]

// Altquelle A16
#block(breakable: false)[
*16 · übernommene Verständnisfrage*

#text("Warum werden bei der indirekten Cashflow-Methode die Abschreibungen zum Jahresüberschuss addiert?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A16. Verfahren: #stelle(<a-1-5>).]
]

// Altquelle A17
#block(breakable: false)[
*17 · übernommene Verständnisfrage*

#text("Über welche vier Fähigkeiten eines Unternehmens informiert der Cashflow?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A17. Verfahren: #stelle(<a-1-5>).]
]

// Altquelle A18
#block(breakable: false)[
*18 · übernommene Verständnisfrage*

#text("Nenne die drei Bereiche der Kapitalflussrechnung. Ist ein negativer Cashflow aus Investitionstätigkeit ein schlechtes Zeichen?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A18. Verfahren: #stelle(<a-1-6>).]
]

// Altquelle A19
#block(breakable: false)[
*19 · Vorlesungsaufgabe · XYZ GmbH 2008*

#text("GuV XYZ GmbH 2008 (Folie 22, Mio. €): Materialaufwand 1.540, Personalaufwand 1.600, Pensionsrückstellungen 200, Abschreibungen 100, Zinsaufwand 200, Jahresüberschuss 648; Umsatzerlöse 4.000, Zinsertrag 288. Berechne den Cashflow direkt und indirekt. Tipp: Prüfe zuerst, ob Aufwand + JÜ = Erträge.")
#src[V, PDF-S. 11, Folie 22; L15, PDF-S. 10 und 14. Verfahren: #stelle(<a-1-5>).]
]

// Altquelle A20
#block(breakable: false)[
*20 · eigene Übungsdaten aus dem Altstand*

#text("Kleinunternehmen: Umsatzerlöse 900 T€ (alle bezahlt), Materialaufwand 350 T€, Personalaufwand 280 T€, Abschreibungen 60 T€, Zuführung zu Pensionsrückstellungen 40 T€, Zinsaufwand 30 T€ (alles bezahlt). a) Jahresüberschuss? b) Cashflow indirekt? c) Kontrolle direkt?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A20. Verfahren: #stelle(<a-1-5>).]
]

// Altquelle A21
#block(breakable: false)[
*21 · eigene Übungsdaten aus dem Altstand*

#text("Pizzeria, Variante: Mario kauft einen Lieferwagen für 36.000 €, Nutzungsdauer 6 Jahre (lineare Abschreibung). Sein Gewinn beträgt 3.000 € pro Monat. a) Wie viel Geld bleibt monatlich zusätzlich in der Kasse, wenn er den Gewinn komplett entnimmt? b) Was hat er nach 6 Jahren angespart, und wofür reicht es?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A21. Verfahren: #stelle(<a-1-5>).]
]

// Altquelle A22
#block(breakable: false)[
*22 · eigene Übungsdaten aus dem Altstand*

#text("Zuordnung: Entscheide jeweils: Auszahlung? Aufwand? Einzahlung? Ertrag? (in dieser Periode) a) Barkauf einer Maschine für 100.000 € b) Abschreibung auf diese Maschine 20.000 € c) Lohnzahlung d) Zuführung zu einer Rückstellung e) Verkauf auf Ziel f) erhaltene Kundenanzahlung g) Kreditaufnahme h) Kredittilgung i) Kauf eines Grundstücks")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A22. Verfahren: #stelle(<a-1-4>).]
]

// Altquelle A23
#block(breakable: false)[
*23 · eigene Übungsdaten aus dem Altstand*

#text("Kapitalflussrechnung (T€): Jahresüberschuss 200, Abschreibungen 80, Erhöhung Pensionsrückstellungen 20, Erhöhung Forderungen L&L 30, Kauf einer Maschine 150, Verkauf eines Grundstücks 40, Kreditaufnahme 100, Tilgung 60, Dividendenzahlung 50, Kassenbestand am Periodenanfang 70. Berechne a) CF aus operativer Tätigkeit, b) CF aus Investitionstätigkeit, c) CF aus Finanzierungstätigkeit, d) den Kassenbestand am Periodenende, e) den Free Cashflow.")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A23. Verfahren: #stelle(<a-1-6>).]
]

// Altquelle A24
#block(breakable: false)[
*24 · eigene Übungsdaten aus dem Altstand*

#text("Free Cashflow: CF aus operativer Tätigkeit 1.250 T€, Investitionen in Sachanlagen 700 T€. Das Unternehmen möchte 200 T€ Dividende zahlen. a) Free Cashflow? b) Kann die Dividende aus dem Free Cashflow bezahlt werden? Was bleibt übrig?")
#src[L15, PDF-S. 10–15; ursprüngliche Aufgabe A24. Verfahren: #stelle(<a-1-6>).]
]

// Altquelle B1
#block(breakable: false)[
*25 · übernommene Verständnisfrage*

#text("Nenne die Aufgaben der Finanzplanung und die drei Prinzipien eines Finanzplans.")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B1. Verfahren: #stelle(<a-1-7>).]
]

// Altquelle B2
#block(breakable: false)[
*26 · übernommene Verständnisfrage*

#text("Was sind die Folgen von Über- bzw. Unterliquidität?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B2. Verfahren: #stelle(<a-1-7>).]
]

// Altquelle B3
#block(breakable: false)[
*27 · übernommene Verständnisfrage*

#text("Warum muss die Finanzplanung mit Produktions-, Absatz- und Investitionsplanung abgestimmt werden?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B3. Verfahren: #stelle(<a-1-7>).]
]

// Altquelle B4
#block(breakable: false)[
*28 · übernommene Verständnisfrage*

#text("Nenne die drei Insolvenzgründe mit Paragraf. Welcher gilt nur für juristische Personen?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B4. Verfahren: #stelle(<a-1-8>).]
]

// Altquelle B5
#block(breakable: false)[
*29 · übernommene Verständnisfrage*

#text("Wann ist ein Unternehmen nach der Rechtsprechung des BGH zahlungsunfähig?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B5. Verfahren: #stelle(<a-1-8>).]
]

// Altquelle B6
#block(breakable: false)[
*30 · übernommene Verständnisfrage*

#text("Erkläre den Unterschied zwischen Zahlungsunfähigkeit und Überschuldung mit eigenen Worten.")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B6. Verfahren: #stelle(<a-1-8>).]
]

// Altquelle B7
#block(breakable: false)[
*31 · übernommene Verständnisfrage*

#text("Wann liegt trotz rechnerischer Überschuldung kein Insolvenzgrund vor?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B7. Verfahren: #stelle(<a-1-8>).]
]

// Altquelle B8
#block(breakable: false)[
*32 · übernommene Verständnisfrage*

#text("Warum hilft bei Überschuldung kein neuer Bankkredit? Was hilft stattdessen?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B8. Verfahren: #stelle(<a-1-8>).]
]

// Altquelle B9
#block(breakable: false)[
*33 · übernommene Verständnisfrage*

#text("Wie lange hat die Geschäftsführung Zeit, den Insolvenzantrag zu stellen, und was droht bei Verspätung?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B9. Verfahren: #stelle(<a-1-8>).]
]

// Altquelle B10
#block(breakable: false)[
*34 · übernommene Verständnisfrage*

#text("Nenne die sechs Gruppen von Maßnahmen gegen ein Liquiditätsdefizit mit je einem Beispiel.")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B10. Verfahren: #stelle(<a-1-8>).]
]

// Altquelle B11
#block(breakable: false)[
*35 · übernommene Verständnisfrage*

#text("Welche Ausgänge kann ein Insolvenzverfahren nehmen? Was bedeutet „Abweisung mangels Masse“?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B11. Verfahren: #stelle(<a-1-8>).]
]

// Altquelle B12
#block(breakable: false)[
*36 · übernommene Verständnisfrage*

#text("Worin unterscheiden sich finanzwirtschaftliche Kennzahlen und Finanzplan?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B12. Verfahren: #stelle(<a-1-7>).]
]

// Altquelle B13
#block(breakable: false)[
*37 · übernommene Verständnisfrage*

#text("Nenne die drei Liquiditätsgrade mit Formel und Zielwert.")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B13. Verfahren: #stelle(<a-1-9>).]
]

// Altquelle B14
#block(breakable: false)[
*38 · übernommene Verständnisfrage*

#text("Formuliere die goldene Bilanzregel. Welche Kennzahl prüft sie, und welcher Wert sollte mindestens erreicht werden?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B14. Verfahren: #stelle(<a-1-10>).]
]

// Altquelle B15
#block(breakable: false)[
*39 · übernommene Verständnisfrage*

#text("Warum kann eine zu hohe, aber auch eine zu geringe Anlageintensität problematisch sein?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B15. Verfahren: #stelle(<a-1-10>).]
]

// Altquelle B16
#block(breakable: false)[
*40 · übernommene Verständnisfrage*

#text("Was sagt die Eigenkapitalquote aus, und welcher Zielwert gilt?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B16. Verfahren: #stelle(<a-1-10>).]
]

// Altquelle B17
#block(breakable: false)[
*41 · übernommene Verständnisfrage*

#text("Warum sollte die EK-Rentabilität deutlich über dem Marktzins für langfristige Anlagen liegen?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B17. Verfahren: #stelle(<a-1-11>).]
]

// Altquelle B18
#block(breakable: false)[
*42 · übernommene Verständnisfrage*

#text("Erkläre am Beispiel Hubert + Maier GmbH, warum das Risiko von Alternative B aus der Kapitalstruktur kommt.")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B18. Verfahren: #stelle(<a-1-11>).]
]

// Altquelle B19
#block(breakable: false)[
*43 · übernommene Verständnisfrage*

#text("Was ist der Leverage-Effekt, und unter welcher Bedingung tritt er auf?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B19. Verfahren: #stelle(<a-1-12>).]
]

// Altquelle B20
#block(breakable: false)[
*44 · übernommene Verständnisfrage*

#text("Was beschreibt der Risikoeffekt? Warum ist die höhere EK-Rendite „kein zusätzlicher Wert“?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B20. Verfahren: #stelle(<a-1-12>).]
]

// Altquelle B21
#block(breakable: false)[
*45 · übernommene Verständnisfrage*

#text("Warum ist eine vollständige Fremdfinanzierung trotz Leverage-Effekt keine gute Idee?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B21. Verfahren: #stelle(<a-1-12>).]
]

// Altquelle B22
#block(breakable: false)[
*46 · eigene Übungsdaten aus dem Altstand*

#text("Liquiditätsplan: Anfangsbestand Q1: 8.000 €. Einzahlungen Q1/Q2/Q3: 30.000 / 25.000 / 40.000 €. Auszahlungen: 35.000 / 34.000 / 31.000 €. Kontokorrentlinie 5.000 €. a) Endbestände je Quartal? b) In welchem Quartal reicht die Kreditlinie nicht? Um wie viel? c) Nenne zwei Maßnahmen.")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B22. Verfahren: #stelle(<a-1-7>).]
]

// Altquelle B23
#block(breakable: false)[
*47 · eigene Übungsdaten aus dem Altstand*

#text("Gewinn vs. Kasse: Ein Unternehmen startet mit 2.000 € auf dem Konto. Es erzielt einen (zahlungswirksamen) Gewinn von 3.000 €, schüttet 1.500 € aus, kauft eine Maschine für 4.000 € und nimmt einen Kredit über 1.000 € auf. a) Endbestand? b) Welche Vorgänge erscheinen in der GuV?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B23. Verfahren: #stelle(<a-1-7>).]
]

// Altquelle B24
#block(breakable: false)[
*48 · eigene Übungsdaten aus dem Altstand*

#text("BGH-Regel: Fällige Verbindlichkeiten 500.000 €. Innerhalb der nächsten drei Wochen kann das Unternehmen 430.000 € bezahlen. Ist es zahlungsunfähig? Welchem Zahlbetrag entsprechen 90 %? Warum ist das rechtlich noch keine sichere Freigrenze?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B24. Verfahren: #stelle(<a-1-8>).]
]

// Altquelle B25
#block(breakable: false)[
*49 · eigene Übungsdaten aus dem Altstand*

#text("Überschuldung : Bilanz einer GmbH: Anlagevermögen 300, Umlaufvermögen 200; Eigenkapital 60, Fremdkapital 440 (T€). a) Welchen Verlust kann die GmbH maximal verkraften? b) Durch eine außerplanmäßige Abschreibung entsteht ein Verlust von 80. Liegt eine bilanzielle Unterdeckung vor, und welche zusätzliche rechtliche Prüfung ist nötig? Wie hoch ist der nicht durch EK gedeckte Fehlbetrag? c) Nenne zwei Maßnahmen, um die Antragspflicht zu beseitigen.")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B25. Verfahren: #stelle(<a-1-8>).]
]

// Altquelle B26
#block(breakable: false)[
*50 · eigene Übungsdaten aus dem Altstand*

#text("Liquiditätsgrade: Kasse und Bank 40, Forderungen 120, Vorräte 140, kurzfristiges Fremdkapital 150 (T€). Berechne die drei Liquiditätsgrade und beurteile sie.")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B26. Verfahren: #stelle(<a-1-9>).]
]

// Altquelle B27
#block(breakable: false)[
*51 · eigene Übungsdaten aus dem Altstand*

#text("Kennzahlen-Check : Anlagevermögen 600, Umlaufvermögen 400; Eigenkapital 250, langfristiges FK 350, kurzfristiges FK 400 (T€). Jahresüberschuss 50, Umsatzerlöse 1.000, Cashflow 125. Berechne Anlagendeckung I und II, EK- und FK-Quote, Anlageintensität, EK-Rentabilität, Umsatzrentabilität, Schuldentilgungsfähigkeit (Verbindlichkeiten = gesamtes FK) und beurteile: Ist die goldene Bilanzregel erfüllt?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B27. Verfahren: #stelle(<a-1-10>).]
]

// Altquelle B28
#block(breakable: false)[
*52 · eigene Übungsdaten aus dem Altstand*

#text("Leverage : Ein Projekt erfordert 200.000 € Kapital und bringt einen Gewinn vor Zinsen von 24.000 €. FKZins 6 %. a) Gesamtkapitalrendite? b) EK-Rentabilität bei 100 % EK, 50 % EK und 25 % EK (rechne einmal direkt und einmal mit der Formel). c) Der Gewinn vor Zinsen sinkt auf 8.000 €. Wie hoch ist die EK-Rentabilität jetzt in den drei Fällen? Was zeigt das?")
#src[L15, PDF-S. 25–30; ursprüngliche Aufgabe B28. Verfahren: #stelle(<a-1-12>).]
]

== Vertiefende Verständnisfragen und Rechenaufgaben

Die zusätzlichen Rechenfälle aus dem Altstand werden als vollständige offene Aufgaben gestellt; danach folgen die Fragen zur Fallstudie.

// Altquelle Ü1
#block(breakable: false)[
*53 · eigene Übungsdaten aus dem Altstand*

#text("Cashflow indirekt: JÜ 250, Abschreibungen 90, Zuführung zu Rückstellungen 30, Auflösung von Rückstellungen 10 (T€). Berechne den Cashflow und begründe jedes Vorzeichen.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü1. Verfahren: #stelle(<a-1-5>).]
]

// Altquelle Ü2
#block(breakable: false)[
*54 · eigene Übungsdaten aus dem Altstand*

#text("Cashflow direkt: Einzahlungen aus Umsatz 1.200, Auszahlungen für Material 500, Personal 350, Zinsen 40 (T€). Berechne den Cashflow.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü2. Verfahren: #stelle(<a-1-5>).]
]

// Altquelle Ü3
#block(breakable: false)[
*55 · eigene Übungsdaten aus dem Altstand*

#text("Liquiditätsplan: Anfangsbestand 5.000 €, Einzahlungen 22.000 €, Auszahlungen 30.000 €, Kontokorrentlinie 6.000 €. Berechne Endbestand und freie Kreditlinie.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü3. Verfahren: #stelle(<a-1-7>).]
]

// Altquelle Ü4
#block(breakable: false)[
*56 · eigene Übungsdaten aus dem Altstand*

#text("Bilanzielles Verlustpolster: AV 120, UV 80, EK 40, FK 160 (T€). Ein Abschreibungsverlust von 50 entsteht. Berechne Vermögen, rechnerisches EK und Fehlbetrag; trenne den bilanziellen Befund von der rechtlichen Prüfung.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü4. Verfahren: #stelle(<a-1-8>).]
]

// Altquelle Ü5
#block(breakable: false)[
*57 · eigene Übungsdaten aus dem Altstand*

#text("EK-Quote und goldene Bilanzregel: EK 300, langfristiges FK 200, kurzfristiges FK 500, AV 450, Bilanzsumme 1.000 (T€). Berechne EK-Quote und Anlagendeckung II und vergleiche die Folienziele.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü5. Verfahren: #stelle(<a-1-10>).]
]

// Altquelle Ü6
#block(breakable: false)[
*58 · eigene Übungsdaten aus dem Altstand*

#text("Leverage: rG = 9 %, rf = 5 %, EK 40, FK 60. Berechne die Eigenkapitalrendite und erläutere den Zuschlag.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü6. Verfahren: #stelle(<a-1-12>).]
]

// Altquelle Ü7
#block(breakable: false)[
*59 · eigene Übungsdaten aus dem Altstand*

#text("Bäckerei (Teil A4): Ein Ofen kostet 48.000 €, Nutzungsdauer 8 Jahre (linear). Gewinn 4.000 € pro Monat, der komplett entnommen wird. Wie viel Geld bleibt monatlich zusätzlich in der Kasse, und was ist nach 8 Jahren angespart?")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü7. Verfahren: #stelle(<a-1-5>).]
]

// Altquelle Ü8
#block(breakable: false)[
*60 · eigene Übungsdaten aus dem Altstand*

#text("Kapitalflussrechnung (Teil A4): JÜ 120, Abschreibungen 40, Erhöhung Forderungen L&L 25, Erhöhung Verbindlichkeiten L&L 15, Kauf einer Maschine 90, Kreditaufnahme 50, Dividende 30, Kasse am Anfang 20 (T€). Berechne die drei Cashflows, den Kassenendbestand und den Free Cashflow.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü8. Verfahren: #stelle(<a-1-6>).]
]

// Altquelle Ü9
#block(breakable: false)[
*61 · eigene Übungsdaten aus dem Altstand*

#text("BGH-Regel (Teil A5): Fällige Verbindlichkeiten 800.000 €, in drei Wochen zahlbar 700.000 €. Zahlungsunfähig?")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü9. Verfahren: #stelle(<a-1-8>).]
]

// Altquelle Ü10
#block(breakable: false)[
*62 · eigene Übungsdaten aus dem Altstand*

#text("Liquiditätsgrade (Teil A5): Kasse 30, Forderungen 90, Vorräte 120, kurzfristiges FK 200 (T€). Berechne und beurteile die drei Grade.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü10. Verfahren: #stelle(<a-1-9>).]
]

// Altquelle Ü11
#block(breakable: false)[
*63 · eigene Übungsdaten aus dem Altstand*

#text("Leverage im schlechten Jahr (Teil A5): Gesamtkapital 500.000 € (EK 100.000, FK 400.000), Gewinn vor Zinsen 40.000 €, FK-Zins 10 %. EK-Rentabilität? Vergleiche mit reiner EK-Finanzierung.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü11. Verfahren: #stelle(<a-1-12>).]
]

// Altquelle Ü12
#block(breakable: false)[
*64 · eigene Übungsdaten aus dem Altstand*

#text("Liquiditätsplan einer Gründung (Teil A5): Kasse 10.000 €. Q1: Einzahlungen 15.000, Auszahlungen 28.000. Q2: 30.000 / 26.000. Q3: 35.000 / 25.000. Kontokorrentlinie 5.000 €. Endbestände, freie Kreditlinie je Quartal, Beurteilung.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü12. Verfahren: #stelle(<a-1-7>).]
]

// Altquelle Ü13
#block(breakable: false)[
*65 · eigene Übungsdaten aus dem Altstand*

#text("Bilanzanalyse (Teil A4/A5): AV 800; Vorräte 200, Forderungen 150, Kasse 50; EK 180, langfr. FK 520, kfr. FK 500 (T€). JÜ 27, Umsatz 1.500, Cashflow 100. Berechne Liquidität 1.–3. Grades, Anlagendeckung I und II, EKQuote, Anlageintensität, EK- und Umsatzrentabilität, Schuldentilgungsfähigkeit (gesamtes FK) und gib ein Gesamturteil.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü13. Verfahren: #stelle(<a-1-10>).]
]

// Altquelle Ü14
#block(breakable: false)[
*66 · eigene Übungsdaten aus dem Altstand*

#text("Kapitalstruktur und Risiko (Teil A5, wie Folie 49/50): Eine GmbH kauft eine Maschine für 150.000 € und behält 50.000 € in der Kasse. A: 200.000 € EK. B: 40.000 € EK + 160.000 € FK zu 8 % (Zinsen aus der Kasse bezahlt). Die Maschine verliert 30.000 € an Wert. Stelle beide Bilanzen zum Jahresende auf. Liegt Überschuldung vor?")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü14. Verfahren: #stelle(<a-1-11>).]
]

// Altquelle Ü15
#block(breakable: false)[
*67 · eigene Übungsdaten aus dem Altstand*

#text("Finanzierungsformen (Teil A2): Ordne zu (Nr. 1–9 nach Drukarczyk, außen/innen, EK/FK): a) Ausgabe neuer Aktien an neue Aktionäre, b) Gewinn wird einbehalten, c) Verkauf einer nicht mehr benötigten Halle, d) Ausgabe einer Anleihe, e) die bisherigen Gesellschafter erhöhen ihre Einlage.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü15. Verfahren: #stelle(<a-1-2>).]
]

// Altquelle Ü16
#block(breakable: false)[
*68 · eigene Übungsdaten aus dem Altstand*

#text("Insolvenzgründe (Teil A5): Bestimme Insolvenzgrund und passende Gegenmaßnahme. (i) GmbH: Vermögen 2,0 Mio. €, Schulden 2,3 Mio. €, keine positive Fortführungsprognose. (ii) Unternehmen kann in drei Wochen nur 70 % der fälligen Rechnungen bezahlen. (iii) GmbH erwartet, eine im März fällige Kreditrate nicht bezahlen zu können.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü16. Verfahren: #stelle(<a-1-8>).]
]

// Altquelle Ü17
#block(breakable: false)[
*69 · eigene Übungsdaten aus dem Altstand*

#text("Ein Unternehmen meldet: JÜ 60, Abschreibungen 40, Zuführung zu Pensionsrückstellungen 20. Bilanz: AV 700, UV 300 (davon flüssige Mittel 30, Forderungen 120), EK 200, FK 800 (davon kurzfristig 300) (T€). Beurteile die finanzielle Lage so vollständig wie möglich und schlage zwei Maßnahmen vor.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü17. Verfahren: #stelle(<a-1-10>).]
]

// Altquelle Ü18
#block(breakable: false)[
*70 · eigene Übungsdaten aus dem Altstand*

#text("Eine Gründerin sagt: „Mein Plan zeigt ab Jahr 1 Gewinn, einen Finanzplan brauche ich nicht.“ Nimm begründet Stellung.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü18. Verfahren: #stelle(<a-1-7>).]
]

// Altquelle Ü19
#block(breakable: false)[
*71 · eigene Übungsdaten aus dem Altstand*

#text("Ein Unternehmen mit rG = 12 % und rf = 7 % will die EK-Rendite steigern und die FK-Quote von 50 % auf 85 % erhöhen. Wie verändert sich die EK-Rentabilität? Welche Bedenken hast du?")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü19. Verfahren: #stelle(<a-1-12>).]
]

// Altquelle Ü20
#block(breakable: false)[
*72 · eigene Übungsdaten aus dem Altstand*

#text("Beurteile jeweils, ob das ein Warnsignal ist: a) negativer Cashflow aus Investitionstätigkeit bei hohem operativem Cashflow, b) Gewinn steigt, Kassenbestand sinkt, c) Anlagendeckung II von 80 %.")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü20. Verfahren: #stelle(<a-1-6>).]
]

// Altquelle Ü21
#block(breakable: false)[
*73 · eigene Übungsdaten aus dem Altstand*

#text("Ein Kunde deiner Bank ist bilanziell überschuldet und bittet um einen zusätzlichen Kredit, „um die Lücke zu schließen“. Was antwortest du?")
#src[L15, PDF-S. 31–34; ursprüngliche Aufgabe Ü21. Verfahren: #stelle(<a-1-8>).]
]

// Altquelle G1
#block(breakable: false)[
*74 · Glasspinnerei · eigene Frage zu den Originaldaten*

#text("Warum benötigt die Glasspinnerei gleichzeitig Finanzplan, Plan-GuV und Planbilanz? Erkläre die Rückkopplung über Zinsen, Steuern und Betriebskapital.")
#src[G, PDF-S. 4 und 7. Verfahren: #stelle(<a-1-13>).]
]

// Altquelle G2
#block(breakable: false)[
*75 · Glasspinnerei · eigene Frage zu den Originaldaten*

#text("Berechne den Nettoumsatz 2005 aus Menge und Preis. Warum kann die Mengensteigerung 2008 nicht unverändert mit 12,5 % fortgesetzt werden?")
#src[G, PDF-S. 3, 5 und 11. Verfahren: #stelle(<a-1-13>).]
]

// Altquelle G3
#block(breakable: false)[
*76 · Glasspinnerei · eigene Frage zu den Originaldaten*

#text("Berechne das erweiterte EBK 2004 aus Lager 23.529, Forderungen 31.564, Lieferverbindlichkeiten 18.884, Rückstellungen Lizenzen/Löhne 7.744 und Steuerrückstellungen 19.348 (T€). Vergleiche mit 2003: −10.914 T€.")
#src[G, PDF-S. 11–12. Verfahren: #stelle(<a-1-14>).]
]

// Altquelle G4
#block(breakable: false)[
*77 · Glasspinnerei · eigene Frage zu den Originaldaten*

#text("Berechne das erweiterte EBK 2005 und seine Änderung: Nettoumsatz 270.000 T€, LB 9 %, FLei 13 %, VLei 10 %, Lizenzrückstellungen 8.775 T€, Steuerrückstellungen 17.000 T€, EBK 2004 = 9.117 T€. Wie wirkt die Änderung auf den NOCF?")
#src[G, PDF-S. 8 und 11–12. Verfahren: #stelle(<a-1-14>).]
]

// Altquelle G5
#block(breakable: false)[
*78 · Glasspinnerei · eigene Frage zu den Originaldaten*

#text("Berechne NOCF vor Steuern 2005: Nettoumsatz 270.000, Material 72.000, Löhne 73.828, sonstige betriebliche Aufwendungen 83.359, ΔEBK −2.492 (je T€). Warum darf keine Abschreibung als Auszahlung abgezogen werden?")
#src[G, PDF-S. 11–12. Verfahren: #stelle(<a-1-14>).]
]

// Altquelle G6
#block(breakable: false)[
*79 · Glasspinnerei · eigene Frage zu den Originaldaten*

#text("Berechne die Abschreibung neuer Gebäude und Anlagen für 2005 sowie die jährlichen Restabschreibungen. Daten: Gebäude 30 Mio. €, zehn Jahre; Anlagen 55 Mio. €, vier Jahre; im Fall 75 % sofort, Rest linear über die verbleibende Zeit.")
#src[G, PDF-S. 4 und 13. Verfahren: #stelle(<a-1-15>).]
]

// Altquelle G7
#block(breakable: false)[
*80 · Glasspinnerei · eigene Frage zu den Originaldaten*

#text("Die Plan-GuV nennt 2005 einen Verlust 39.410 T€ und 2006 einen Gewinn vor Verlustverrechnung 45.377 T€. Berechne bei der Fall-Steuerquote von 50 % die Steuer 2006. NOCF vor Steuern 2006: 63.912 T€. Wie hoch ist er danach?")
#src[G, PDF-S. 14. Verfahren: #stelle(<a-1-15>).]
]

// Altquelle G8
#block(breakable: false)[
*81 · Glasspinnerei · eigene Frage zu den Originaldaten*

#text("Rechne den gesamten Finanzierungssaldo 2005: NOCF nach Steuern 43.305, bisherige Zinsen 3.214, neue Kredite 20.000 + 5.000, Investition 85.000, Dividende 3.120 (T€). Sonstige Tilgungs-/Rückzahlungsbeträge sind in der Falltabelle nicht angegeben. Vergleiche die Folgejahre.")
#src[G, PDF-S. 15. Verfahren: #stelle(<a-1-15>).]
]

// Altquelle G9
#block(breakable: false)[
*82 · Glasspinnerei · eigene Frage zu den Originaldaten*

#text("Leite die Bilanzwerte 2005 für Gebäude und Maschinen her. Erkläre außerdem, warum die zunächst unterstellten zusätzlichen Gesellschafterdarlehen keine gesicherte Lösung sind.")
#src[G, PDF-S. 16–19. Verfahren: #stelle(<a-1-16>).]
]

// Altquelle G10
#block(breakable: false)[
*83 · Glasspinnerei · eigene Frage zu den Originaldaten*

#text("Vergleiche die beiden Liquiditätsmaßnahmen 2005: 20 % der 85-Mio.-Investition auf 2006 verschieben und Forderungsquote bei 270 Mio. € Umsatz von 13 % auf 9,5 % senken. Wie groß ist die zusätzliche Verbesserung gegenüber dem Basisplan? Warum sind die genannten 11,9 Mio. € EBK-Freisetzung ein anderer Vergleich?")
#src[G, PDF-S. 20–21. Verfahren: #stelle(<a-1-17>).]
]

// Altquelle G11
#block(breakable: false)[
*84 · Glasspinnerei · eigene Frage zu den Originaldaten*

#text("Was ändert lineare statt 75-%-Sofortabschreibung bei den neuen Gebäuden? Vergleiche 39,41 Mio. € Verlustvortrag vorher mit dem neuen Betrag. Unterscheide dabei Buchwirkung, Steuerzeitpunkt und heutige Insolvenzprüfung.")
#src[G, PDF-S. 21–22. Verfahren: #stelle(<a-1-18>).]
]

// Altquelle G12
#block(breakable: false)[
*85 · Glasspinnerei · eigene Frage zu den Originaldaten*

#text("Formuliere die Schlussfolgerung der Glasspinnerei für einen Kreditgeber. Welche Rolle spielen Sonderabschreibungen, künftiger NOCF, die vorübergehende Finanzierungslücke und ein qualifizierter Rangrücktritt?")
#src[G, PDF-S. 18–24. Verfahren: #stelle(<a-1-18>).]
]

*Altklausur 2017 (K).* Übernommen sind die Aufgaben 3 und 4, weil ihr Stoff schon behandelt ist. Die Punkte stehen wie in der Klausur dabei.

// Altquelle K3a
#block(breakable: false)[
*86 · Klausur 2017, Aufgabe 3 a (8 Punkte)*

#text("Ein Investor plant eine Unternehmensgründung mit 800.000 € Gesamtkapital. Er kann 300.000 € bis 500.000 € Eigenkapital einbringen, der Rest ist Fremdkapital. Das Unternehmen erwartet jährlich einen Bruttogewinn (Gewinn vor Abzug der Fremdkapitalzinsen) von 70.000 €. Ermittle die Gesamtkapitalrentabilität (in %, 2 Nachkommastellen; 2 P.) und die Eigenkapitalrentabilität des Investors (6 P.) für: (1) 500.000 € EK / 300.000 € FK zu 6 %; (2) 300.000 € EK / 500.000 € FK zu 6 %; (3) 500.000 € EK / 300.000 € FK zu 10,5 %; (4) 300.000 € EK / 500.000 € FK zu 10,5 %.")
#src[K, PDF-S. 4 (Klausurseite 8). Verfahren: #stelle(<a-1-11>), #stelle(<a-1-12>).]
]

// Altquelle K3bc
#block(breakable: false)[
*87 · Klausur 2017, Aufgabe 3 b und c (3 Punkte)*

#text("b) Beschreibe den Leverage-Effekt anhand Deiner Ergebnisse aus Aufgabe 86 (2 P.). c) Nenne zwei betriebswirtschaftliche Aspekte, die gegen eine hohe Verschuldung eines Unternehmens sprechen (1 P.).")
#src[K, PDF-S. 5 (Klausurseite 9). Verfahren: #stelle(<a-1-12>), #stelle(<a-1-11>).]
]

// Altquelle K4a
#block(breakable: false)[
*88 · Klausur 2017, Aufgabe 4 (5 Punkte)*

#text("Die Rhein GmbH legt für 2015 diese GuV vor (Mio. €): Materialaufwand 21, Personalaufwand 23, Aufwand aus Zuführung zu Pensionsrückstellungen 4, Abschreibungen 7, sonstiger Aufwand 5, Jahresüberschuss 9; Umsatzerlöse 69. Berechne den Cashflow 2015 nach der direkten und nach der indirekten Methode. Alle zahlungswirksamen Positionen waren im Jahr der Verbuchung tatsächlich voll zahlungswirksam.")
#src[K, PDF-S. 6 (Klausurseite 10). Verfahren: #stelle(<a-1-5>).]
]

// Altquelle K4b
#block(breakable: false)[
*89 · Klausur 2017, Aufgabe 4 Zusatz (1 Punkt)*

#text("Nenne zwei weitere Formen der Innenfinanzierung, die einem Unternehmen neben der Selbstfinanzierung zur Verfügung stehen.")
#src[K, PDF-S. 6 (Klausurseite 10). Verfahren: #stelle(<a-1-2>), #stelle(<a-1-5>).]
]

#pagebreak()
== Lösungen Kapitel 1

Die Nummern entsprechen den Aufgaben. Rechenwerte aus eigenen Beispielen sind Übungsdaten; Rechtsfragen werden mit den sichtbaren Korrekturen in Abschnitt 1.8 beantwortet.

#block(breakable: false)[
#heading(level: 3, outlined: false)[1 · Lösung]
#text("Gewinn/Rentabilität, Liquidität, Sicherheit. Sachziel: finanzielle Mittel im notwendigen Umfang, in der erforderlichen Art, zum richtigen Zeitpunkt, am richtigen Ort.")
#nachschlagen[Lernskript, #stelle(<a-1-1>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[2 · Lösung]
#text("Rentabilität, Sicherheit, Liquidität lassen sich nicht gleichzeitig maximieren. Rentabel ↔ sicher: hohe Rendite meist mit hohem Risiko (Aktien vs. Sparbuch). Liquide ↔ rentabel: Bargeld bringt keine Zinsen. Sicher ↔ rentabel: sichere Anlagen bringen wenig. Wo man sich einordnet, hängt von der Risikoaversion ab.")
#nachschlagen[Lernskript, #stelle(<a-1-1>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[3 · Lösung]
#text("Außen: Mittel kommen über Finanzierungsverträge von Kapitalgebern außerhalb des Unternehmens. Innen: Mittel entstehen bzw. verbleiben durch Vorgänge innerhalb des Unternehmens (einbehaltene Gewinne, Abschreibungen, Rückstellungen).")
#nachschlagen[Lernskript, #stelle(<a-1-2>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[4 · Lösung]
#text("(1) Kapitalgeber außerhalb vs. Vorgänge innerhalb; (2) Beträge exakt festgelegt vs. Höhe zum Teil ungewiss; (3) Fristen exakt vs. zum Teil ungewiss; (4) Einzelakte zu vereinbarten Zeitpunkten vs. laufend, oft erst am Periodenende erkennbar.")
#nachschlagen[Lernskript, #stelle(<a-1-2>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[5 · Lösung]
#text("FK-Geber erhalten Zins, Rückzahlung und ein Kündigungsrecht, aber keinen Gewinnanteil und keine Stimmrechte. EK-Geber erhalten Gewinnanteil und Stimmrechte, aber keinen Zins und keinen Anspruch auf Rückzahlung. Ob etwas EK oder FK ist, entscheidet also die vereinbarte Gegenleistung.")
#nachschlagen[Lernskript, #stelle(<a-1-2>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[6 · Lösung]
#text("Über die Kündigungsdrohung: Wenn die Bank den Kredit kündigen oder nicht verlängern kann, muss das Unternehmen auf ihre Bedingungen eingehen.")
#nachschlagen[Lernskript, #stelle(<a-1-2>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[7 · Lösung]
#text("Erfolgsbeteiligung / keine; keine festen Zahlungsansprüche / fester Zins- und Tilgungsanspruch; Quotenanteil / Nominalanspruch; unbefristet / befristet; Haftung / keine Haftung; Mitwirkungsrechte / keine Leitungsrechte.")
#nachschlagen[Lernskript, #stelle(<a-1-2>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[8 · Lösung]
#text("a) 1 Fremdfinanzierung · b) 2 Gesellschafterdarlehen · c) 3 Eigenfinanzierung · d) 4 Beteiligungsfinanzierung · e) 6 offene Selbstfinanzierung · f) 9 Vermögensumschichtung.")
#nachschlagen[Lernskript, #stelle(<a-1-2>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[9 · Lösung]
#text("Eigenfinanzierung: bisherige Eigentümer legen neues Eigenkapital von außen ein (Außenfinanzierung). Selbstfinanzierung: Gewinne werden im Unternehmen einbehalten (Innenfinanzierung).")
#nachschlagen[Lernskript, #stelle(<a-1-2>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[10 · Lösung]
Liquidität heißt: fällige Zahlungen fristgerecht und betragsgenau erfüllen können. Dieses Ziel ist dauerhaft und existenziell; Zahlungsunfähigkeit kann ein Insolvenzverfahren auslösen. Gewinn ist dafür kein Ersatz, weil er andere Größen und Periodenzuordnungen erfasst.
#nachschlagen[Lernskript, #stelle(<a-1-3>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[11 · Lösung]
#text("Z. B. großer Auftrag auf Ziel: Ertrag und Gewinn sind gebucht, das Geld kommt erst in 90 Tagen. Löhne und Lieferanten müssen aber jetzt bezahlt werden. Reicht die Kasse nicht, ist das Unternehmen trotz Gewinn zahlungsunfähig.")
#nachschlagen[Lernskript, #stelle(<a-1-3>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[12 · Lösung]
#text("güterwirtschaftliche Liquidität (Vermögen verkaufen, z. B. Wertpapiere); zukünftige Liquidität (künftige Einzahlungsüberschüsse, z. B. Umsätze); verliehene Liquidität (Vermögen beleihen, z. B. Grundschuld auf das Firmengrundstück); antizipierte Liquidität (künftige Überschüsse beleihen, z. B. Kredit auf erwartete Cashflows).")
#nachschlagen[Lernskript, #stelle(<a-1-3>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[13 · Lösung]
#text("Die Bundesanleihe wird an der Börse gehandelt und kann börsentäglich verkauft werden. Der Sparbrief ist in der Regel nicht kündbar, man kommt erst nach Laufzeitende an das Geld.")
#nachschlagen[Lernskript, #stelle(<a-1-3>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[14 · Lösung]
Die Bilanz zeigt Vermögens- und Kapitalbestände an einem Stichtag; die GuV arbeitet mit Erträgen und Aufwendungen. Beides ergibt noch keinen Kalender künftiger Einzahlungen, Auszahlungen und Fälligkeiten. Für diese Frage braucht man den Zahlungsplan.
#nachschlagen[Lernskript, #stelle(<a-1-3>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[15 · Lösung]
#text("Aufwand = Werteverzehr einer Periode (GuV), Auszahlung = Abfluss von Geld. Beispiel: Abschreibung ist Aufwand ohne Auszahlung; Maschinenkauf ist Auszahlung, wird aber erst über Jahre zu Aufwand. Ertrag = Wertzuwachs, Einzahlung = Zufluss von Geld. Beispiel: Verkauf auf Ziel ist Ertrag, Einzahlung erst später; Kundenanzahlung ist Einzahlung, Ertrag erst später.")
#nachschlagen[Lernskript, #stelle(<a-1-4>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[16 · Lösung]
#text("Abschreibungen haben den Jahresüberschuss gemindert, aber in dieser Periode kein Geld gekostet. Um vom Gewinn zur Zahlungsgröße zu kommen, werden sie wieder addiert.")
#nachschlagen[Lernskript, #stelle(<a-1-5>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[17 · Lösung]
#text("Zahlungsüberschüsse erwirtschaften, Schulden tilgen (Kreditwürdigkeit), Gewinne ausschütten, Investitionen tätigen.")
#nachschlagen[Lernskript, #stelle(<a-1-5>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[18 · Lösung]
#text("Operative, Investitions- und Finanzierungstätigkeit. Ein negativer Investitions-Cashflow bezeichnet eine Netto-Mittelverwendung, beispielsweise für neue Anlagen. Ob sie sinnvoll und finanzierbar ist, muss separat geprüft werden; der negative Saldo allein ist weder gut noch schlecht.")
#nachschlagen[Lernskript, #stelle(<a-1-6>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[19 · Lösung]
*Modell:* Zahlungen und Erfolg unterscheiden sich nur durch die genannten Abschreibungen und die Zuführung zu Pensionsrückstellungen; Einheit Mio. €.

*1 · GuV prüfen:* $1540+1600+200+100+200+648=4288=4000+288$.

*2 · Direkt:* $4288-1540-1600-200=948$.

*3 · Indirekt:* $648+100+200=948$.

*Ergebnis: 948 Mio. €.* *Prüfung:* Beide Wege stimmen überein; die nicht zahlungswirksamen Aufwendungen werden direkt nicht abgezogen.
#nachschlagen[Lernskript, #stelle(<a-1-5>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[20 · Lösung]
*Modell:* Alle als bezahlt angegebenen Positionen sind zahlungswirksam; AfA und Rückstellungszuführung nicht. Einheit T€.

*1 · Erfolg:* $900-350-280-60-40-30=140$.

*2 · Indirekt:* $140+60+40=240$.

*3 · Direkt:* $900-350-280-30=240$.

*Ergebnis: JÜ 140 T€, CF 240 T€.* *Prüfung:* Die Differenz 100 T€ entspricht genau den beiden nicht zahlungswirksamen Aufwendungen.
#nachschlagen[Lernskript, #stelle(<a-1-5>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[21 · Lösung]
*Modell:* Lineare Abschreibung, bezahlte Umsätze, keine weiteren Abgrenzungen, keine Preissteigerung oder anderweitige Verwendung des zurückbehaltenen Geldes.

*1 · AfA:* $36000/6=6000$ €/Jahr, also $6000/12=500$ €/Monat.

*2 · Cashflow vor Entnahme:* $3000+500=3500$ €/Monat.

*3 · Nach Entnahme:* $3500-3000=500$ €/Monat; über 72 Monate $500 times 72=36000$ €.

*Ergebnis: 500 €/Monat zusätzlich; 36.000 € nach sechs Jahren.* *Prüfung:* Das reicht unter den Annahmen für einen gleich teuren Wagen, nicht automatisch bei höheren Preisen.
#nachschlagen[Lernskript, #stelle(<a-1-5>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[22 · Lösung]
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
#nachschlagen[Lernskript, #stelle(<a-1-4>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[23 · Lösung]
*Modell:* Drei-Bereiche-Zuordnung der Folien, keine weiteren Zahlungs-/Wechselkurseffekte. Alle Werte T€.

*1 · Operativ:* $200+80+20-30=270$.

*2 · Investition:* $-150+40=-110$.

*3 · Finanzierung:* $100-60-50=-10$.

*4 · Bestand:* $70+270-110-10=220$.

*5 · FCF nach der Definition von Folie 26:* $270-150=120$.

*Ergebnis: CF 270 / −110 / −10 T€; Ende 220 T€; FCF 120 T€.* *Prüfung:* Der Grundstücksverkauf von 40 steckt im Investitionssaldo, wird aber nicht als Minderung der hier definierten Anlagenzugänge beim FCF verwendet.
#nachschlagen[Lernskript, #stelle(<a-1-6>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[24 · Lösung]
*1 · FCF:* $1250-700=550$ T€.

*2 · Ausschüttung:* $550-200=350$ T€.

*Ergebnis: Die Dividende ist im vereinfachten Zahlungsmodell gedeckt; 350 T€ verbleiben.* *Prüfung:* Andere fällige Tilgungen und Ausschüttungsbeschränkungen sind damit nicht schon geprüft.
#nachschlagen[Lernskript, #stelle(<a-1-6>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[25 · Lösung]
#text("Aufgaben: Bedarf an Zahlungsmitteln ermitteln, Zahlungsfähigkeit sichern, optimale Finanzierungsart wählen, Defizite und Überschüsse sichtbar machen, EK-Bedarf ermitteln. Prinzipien: Vollständigkeit, Bruttoprinzip, Genauigkeit.")
#nachschlagen[Lernskript, #stelle(<a-1-7>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[26 · Lösung]
#text("Überliquidität: zu viel ungenutztes Geld, Zinsverluste, geringere Rentabilität. Unterliquidität: Zahlungsverpflichtungen können nicht erfüllt werden, Insolvenzrisiko.")
#nachschlagen[Lernskript, #stelle(<a-1-7>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[27 · Lösung]
#text("Weil Produktion, Absatz und Investitionen die Zahlungsströme bestimmen. Erst der Finanzplan zeigt, ob das Gesamtprogramm finanzierbar ist; wenn nicht, werden die Teilpläne angepasst.")
#nachschlagen[Lernskript, #stelle(<a-1-7>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[28 · Lösung]
#text("Zahlungsunfähigkeit (§ 17), drohende Zahlungsunfähigkeit (§ 18) und Überschuldung (§ 19 InsO). § 19 gilt für juristische Personen sowie die dort in Abs. 3 erfassten Personengesellschaften. Ein sinkender Umsatz allein ist kein eigener Insolvenzgrund.")
#nachschlagen[Lernskript, #stelle(<a-1-8>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[29 · Lösung]
#text("Die Folie rechnet mit der 90-%-/Dreiwochen-Orientierung. Präziser: Eine nicht beseitigte Lücke von 10 % oder mehr begründet nach dem BGH regelmäßig Zahlungsunfähigkeit; Ausnahmen und die weitere Entwicklung sind mitzubeurteilen. Genau 90 % sind keine rechtliche Freigrenze.")
#nachschlagen[Lernskript, #stelle(<a-1-8>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[30 · Lösung]
#text("Zahlungsunfähigkeit: Es fehlt jetzt Geld, um fällige Rechnungen zu bezahlen (Liquiditätsproblem). Überschuldung: Das Vermögen reicht nicht, um alle Schulden zu decken, das EK ist negativ (Vermögensproblem). Ein überschuldetes Unternehmen kann noch zahlen, ein zahlungsunfähiges kann noch Vermögen haben.")

*Präzisierung:* Ein bilanzieller Fehlbetrag und die rechtliche Überschuldung sind getrennt zu prüfen. Darlehen verschwinden nicht pauschal aus der Bilanz; beim Rangrücktritt gelten die Voraussetzungen von § 19.
#nachschlagen[Lernskript, #stelle(<a-1-8>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[31 · Lösung]
#text("Ein negatives handelsbilanzielles EK allein beweist keine rechtliche Überschuldung. § 19 berücksichtigt insbesondere die überwiegend wahrscheinliche Fortführung in den nächsten zwölf Monaten sowie die rechtlich passende Vermögens- und Verbindlichkeitsbewertung.")
#nachschlagen[Lernskript, #stelle(<a-1-8>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[32 · Lösung]
#text("Ein Kredit erhöht Vermögen (Kasse) und Schulden um denselben Betrag, die Lücke zwischen Vermögen und Schulden bleibt. Es braucht Eigenkapital (Kapitaleinlage, neuer EK-Geber), einen Rangrücktritt oder einen Lieferantenvergleich.")

*Präzisierung:* Ein bilanzieller Fehlbetrag und die rechtliche Überschuldung sind getrennt zu prüfen. Darlehen verschwinden nicht pauschal aus der Bilanz; beim Rangrücktritt gelten die Voraussetzungen von § 19.
#nachschlagen[Lernskript, #stelle(<a-1-8>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[33 · Lösung]
#text("Ohne schuldhaftes Zögern; nach § 15a Abs. 1 spätestens drei Wochen nach Eintritt der Zahlungsunfähigkeit bzw. sechs Wochen nach Eintritt der Überschuldung. Die einheitlichen drei Wochen der Folie 34 sind insoweit veraltet. Verspätete Antragstellung kann strafbar sein; drohende Zahlungsunfähigkeit allein löst diese Antragspflicht nicht aus.")
#nachschlagen[Lernskript, #stelle(<a-1-8>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[34 · Lösung]
#text("Vermögen außer der Reihe zu Geld machen (Sale-and-lease-back); Eingänge beschleunigen, Ausgänge verzögern (Mahnwesen verschärfen); spezielle Einlagen und Kredite beschaffen (längeres Lieferantenziel); Rentabilität für Liquidität opfern (Sofortzahler bevorzugen); Gesellschafter müssen Farbe bekennen (zusätzliche Einlagen); rigoros Auszahlungen kürzen (Personalabbau).")
#nachschlagen[Lernskript, #stelle(<a-1-8>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[35 · Lösung]
#text("Abweisung mangels Masse, Liquidation (Gläubiger erhalten eine Quote) oder Sanierung über einen Insolvenzplan; dazu Einstellung des Verfahrens. „Mangels Masse“: Das Vermögen reicht nicht einmal, um die Kosten des Verfahrens zu decken.")
#nachschlagen[Lernskript, #stelle(<a-1-8>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[36 · Lösung]
#text("Kennzahlen beschreiben die gegenwärtige Lage (aus der Bilanz, Stichtag). Der Finanzplan nimmt künftige Einund Auszahlungen vorweg.")
#nachschlagen[Lernskript, #stelle(<a-1-7>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[37 · Lösung]
#text("1. Grad: flüssige Mittel / kfr. FK, 10–30 %. 2. Grad: (flüssige Mittel + Forderungen) / kfr. FK, mind. 100 %. 3. Grad: Umlaufvermögen / kfr. FK, mind. 200 %.")
#nachschlagen[Lernskript, #stelle(<a-1-9>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[38 · Lösung]
#text("Anlagevermögen soll durch langfristig verfügbares Kapital finanziert werden. Geprüft mit der Anlagendeckung (II: (EK + langfr. FK) / AV); mindestens 100 %.")
#nachschlagen[Lernskript, #stelle(<a-1-10>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[39 · Lösung]
#text("Zu hoch: Das Anlagevermögen lässt sich in der Krise schwer verkaufen. Zu gering: Hinweis auf alte, stark abgeschriebene Anlagen.")
#nachschlagen[Lernskript, #stelle(<a-1-10>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[40 · Lösung]
#text("Anteil des EK an der Bilanzsumme; zeigt finanzielle Unabhängigkeit und Bonität. Zielwert mindestens 15–20 %.")
#nachschlagen[Lernskript, #stelle(<a-1-10>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[41 · Lösung]
#text("Weil der Gewinn zusätzlich das Unternehmensrisiko vergüten muss. Sonst könnte der Eigentümer sein Geld risikolos(er) anlegen.")
#nachschlagen[Lernskript, #stelle(<a-1-11>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[42 · Lösung]
#text("Bei A und B fällt das Grundstück gleich stark (gleiches Geschäftsrisiko). Bei A trägt das hohe EK den Verlust. Bei B kommen 8.000 € Zinsen dazu, und das kleine EK (20.000) reicht für 28.000 Verlust nicht: Überschuldung. Der Unterschied liegt nur in der Finanzierung.")
#nachschlagen[Lernskript, #stelle(<a-1-11>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[43 · Lösung]
#text("Hebelwirkung des FK zugunsten der EK-Rentabilität: Ist der FK-Zins kleiner als die Gesamtkapitalrendite, steigt die EK-Rentabilität mit zunehmender Verschuldung.")
#nachschlagen[Lernskript, #stelle(<a-1-12>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[44 · Lösung]
#text("Mit steigender Verschuldung wächst die Streuung der EK-Rendite (das Risiko). Die höhere Rendite ist nur die Entschädigung für dieses höhere Risiko, kein Geschenk.")
#nachschlagen[Lernskript, #stelle(<a-1-12>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[45 · Lösung]
#text("Mit EK = 0 ist die Leverage-Formel nicht definiert. Mit sinkendem EK werden das Verlustpolster kleiner und die Renditeschwankungen größer. Kreditzins, Kreditverfügbarkeit und Rückzahlungspflichten dürfen nicht als beliebig unverändert angenommen werden; bei rG < rf wirkt der Hebel negativ.")
#nachschlagen[Lernskript, #stelle(<a-1-12>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[46 · Lösung]
*Modell:* Negativer Kontostand wird durch Kontokorrent gedeckt, soweit die Linie reicht. Alle Werte €.

*1 · Q1:* $8000+30000-35000=3000$.

*2 · Q2:* $3000+25000-34000=-6000$.

*3 · Q3:* $-6000+40000-31000=3000$.

*Ergebnis: 3.000 / −6.000 / 3.000 €.* In Q2 übersteigt der Bedarf die Linie von 5.000 € um *1.000 €*. Die positive Q3-Position setzt die zwischenzeitliche Finanzierung voraus.

*Prüfung/Maßnahmen:* Vor Q2 zusätzliche Linie vereinbaren, Auszahlungen vertraglich strecken, Forderungen schneller einziehen oder Kundenvorauszahlungen vereinbaren.
#nachschlagen[Lernskript, #stelle(<a-1-7>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[47 · Lösung]
*Modell:* Der angegebene Gewinn von 3.000 € ist hier ausdrücklich voll zahlungswirksam.

*1 · Bestand rechnen:* $2000+3000-1500-4000+1000=500$ €.

*2 · Erfolg trennen:* Ausschüttung ist kein Aufwand, Maschinenkauf wird aktiviert (spätere AfA), Kredit ist kein Ertrag.

*Ergebnis: 500 € Kontobestand.* *Prüfung:* Ein Gewinn von 3.000 € bedeutet in diesem Fall keine Zunahme des Kontos um 3.000 €. Die ursprünglichen Erträge/Aufwendungen ergeben den Gewinn; er ist keine eigene Buchungsart.
#nachschlagen[Lernskript, #stelle(<a-1-7>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[48 · Lösung]
*1 · Deckungsquote:* $430000/500000 times 100%=86%$; die Lücke beträgt *14 %*.

*2 · Folienorientierung:* 86 % liegt unter 90 %, also ein deutlicher Hinweis auf Zahlungsunfähigkeit im Aufgabenmodell. 90 % entsprächen $"0,9" times 500000=450000$ €.

*Prüfung:* Auch bei genau 450.000 € bleibt eine Lücke von 10 %. Nach dem BGH ist das regelmäßig kritisch, keine sichere Freigrenze. Ausnahmen und die Entwicklung müssen gesondert beurteilt werden.
#nachschlagen[Lernskript, #stelle(<a-1-8>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[49 · Lösung]
*Modell:* Keine weiteren Wert-/Kapitaländerungen; Einheit T€.

*1 · Polster:* Das anfängliche EK von 60 trägt rechnerisch bis zu 60 Verlust.

*2 · Nach Abschreibung:* AV $300-80=220$, Vermögen $220+200=420$, Schulden 440, rechnerisches EK $60-80=-20$.

*Ergebnis: 20 T€ bilanzieller Fehlbetrag.* *Prüfung:* Rechtsüberschuldung erfordert die Prüfung nach § 19, insbesondere Fortführung und geeignete Bewertung. Als Ansätze kommen Einlage, Forderungsverzicht oder rechtlich geeigneter Nachrang in Betracht; ein neuer gewöhnlicher Kredit schließt die Vermögenslücke nicht.
#nachschlagen[Lernskript, #stelle(<a-1-8>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[50 · Lösung]
*1 · L1:* $40/150 times 100% approx "26,7"%$.

*2 · L2:* $(40+120)/150 times 100% approx "106,7"%$.

*3 · L3:* $(40+120+140)/150 times 100%=200%$.

*Ergebnis: 26,7 % / 106,7 % / 200 %.* Die Folienziele sind erreicht, beim dritten Grad genau. *Prüfung:* Gleicher Nenner, zunehmender Zähler; daraus folgt noch keine Garantie passender Fälligkeiten.
#nachschlagen[Lernskript, #stelle(<a-1-9>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[51 · Lösung]
*Modell:* Gesamtkapital $600+400=1000$ T€, FK $350+400=750$ T€; jährlicher CF 125 T€.

*1 · Deckung:* AD I $=250/600 times 100% approx "41,7"%$; AD II $=(250+350)/600 times 100%=100%$.

*2 · Struktur:* EK-Quote $25%$, FK-Quote $75%$, Anlageintensität $60%$.

*3 · Erfolg:* EK-Rentabilität $=50/250 times 100%=20%$; Umsatzrentabilität $=50/1000 times 100%=5%$.

*4 · Dauerkennzahlen:* Schuldentilgung $750/125=6$ Jahre; die „Selbstfinanzierungsquote“ der Folie wäre $600/125="4,8"$ Jahre.

*Ergebnis:* Goldene Bilanzregel gerade erfüllt. *Prüfung:* EK- und FK-Quote ergeben 100 %; Dauerkennzahlen sind keine Prozentwerte.
#nachschlagen[Lernskript, #stelle(<a-1-10>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[52 · Lösung]
*Modell:* Gesamtkapital 200.000 €, FK-Zins 6 %, keine Steuern; EK-Anteile 100 % / 50 % / 25 %.

*1 · Gutes Jahr:* $r_G=24000/200000 times 100%=12%$.

Direkt: $24000/200000=12%$, $(24000-6000)/100000=18%$, $(24000-9000)/50000=30%$.

Mit Formel: $12+(12-6) times 0=12$, $12+(12-6) times 1=18$, $12+(12-6) times 3=30$ (jeweils %).

*2 · Schlechtes Jahr:* $r_G=8000/200000 times 100%=4%$. EK-Renditen: *4 % / 2 % / −2 %*. Direkt $8000/200000$, $(8000-6000)/100000$, $(8000-9000)/50000$; die Formel liefert dieselben Werte.

*Prüfung:* Über 6 % Gesamtrendite hilft der Hebel, darunter schadet er. Die gleiche Verschuldung verstärkt beide Richtungen.
#nachschlagen[Lernskript, #stelle(<a-1-12>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[53 · Lösung]
*1 · Bereinigen:* $250+90+30-10=360$ T€.

*Ergebnis: 360 T€.* *Prüfung:* AfA und Zuführung wurden als nicht zahlungswirksamer Aufwand addiert; die ebenfalls nicht zahlungswirksame Auflösung als Ertrag abgezogen. Sonstige Abgrenzungen sind im Beispiel nicht gegeben.
#nachschlagen[Lernskript, #stelle(<a-1-5>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[54 · Lösung]
*1 · Zahlungen saldieren:* $1200-500-350-40=310$ T€.

*Ergebnis: 310 T€.* *Prüfung:* Nur ausdrücklich gegebene Zahlungen verwenden; keine zusätzliche Abschreibung abziehen.
#nachschlagen[Lernskript, #stelle(<a-1-5>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[55 · Lösung]
*1 · Kontostand:* $5000+22000-30000=-3000$ €.

*2 · Freie Linie:* $6000-3000=3000$ €.

*Ergebnis: 3.000 € Kontokorrent genutzt, 3.000 € noch verfügbar.* *Prüfung:* Die negative Kontoposition wird nicht noch einmal von der bereits verminderten freien Linie abgezogen.
#nachschlagen[Lernskript, #stelle(<a-1-7>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[56 · Lösung]
*1 · Vermögen:* $(120-50)+80=150$ T€.

*2 · Kapital:* FK 160 T€, EK $40-50=-10$ T€.

*Ergebnis: 10 T€ bilanzieller Fehlbetrag.* *Prüfung:* Der Abschreibungsverlust übersteigt das Polster. Die rechtliche Überschuldung erfordert zusätzlich § 19; bloßes negatives Buch-EK ist keine vollständige Rechtsprüfung.
#nachschlagen[Lernskript, #stelle(<a-1-8>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[57 · Lösung]
*1 · EK-Quote:* $300/1000 times 100%=30%$.

*2 · AD II:* $(300+200)/450 times 100% approx "111,1"%$.

*Ergebnis:* Die EK-Quote liegt über 15–20 %, die goldene Bilanzregel ist erfüllt. *Prüfung:* Verfügbares langfristiges Kapital 500 T€ übersteigt AV 450 T€ um 50 T€.
#nachschlagen[Lernskript, #stelle(<a-1-10>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[58 · Lösung]
*1 · Verschuldung:* $"FK"/"EK"=60/40="1,5"$.

*2 · Hebel:* $r_e=9%+(9%-5%) times "1,5"=15%$.

*Ergebnis: 15 %.* *Prüfung:* Positiver Renditeabstand 4 Prozentpunkte × 1,5 ergibt 6 Prozentpunkte Zuschlag.
#nachschlagen[Lernskript, #stelle(<a-1-12>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[59 · Lösung]
*Modell:* Lineare AfA; Gewinne vollständig entnommen; alle Umsätze bezahlt, keine Preissteigerung und keine anderweitige Verwendung.

*1 · AfA:* $48000/8=6000$ €/Jahr $=500$ €/Monat.

*2 · Mittel:* $4000+500=4500$ € Cashflow vor Entnahme; danach *500 € monatlich*.

*3 · Ansparen:* $500 times 96=48000$ €.

*Prüfung:* Nach acht Jahren entspricht der Betrag dem ursprünglichen Ofenpreis; Abschreibung selbst ist kein Geldzufluss.
#nachschlagen[Lernskript, #stelle(<a-1-5>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[60 · Lösung]
*Modell:* Alle Werte T€, Zuordnung nach Folie 24.

*1 · Operativ:* $120+40-25+15=150$.

*2 · Investition:* $-90$; *Finanzierung:* $50-30=20$.

*3 · Bestand:* $20+150-90+20=100$.

*4 · FCF:* $150-90=60$.

*Ergebnis: 150 / −90 / 20 T€; Ende 100 T€; FCF 60 T€.* *Prüfung:* Mehr Forderungen bindet Geld, mehr Lieferverbindlichkeiten lässt zunächst Geld im Unternehmen.
#nachschlagen[Lernskript, #stelle(<a-1-6>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[61 · Lösung]
*1 · Quote:* $700000/800000 times 100%="87,5"%$; Lücke 12,5 %.

*Ergebnis:* Regelmäßig kritischer Befund im Dreiwochenmodell. 90 % entsprächen 720.000 €. *Prüfung:* Auch dieser Grenzbetrag wäre keine sichere rechtliche Freigrenze; Abschnitt 1.8 beschreibt den Unterschied zur vereinfachten Folienregel.
#nachschlagen[Lernskript, #stelle(<a-1-8>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[62 · Lösung]
*1 · L1:* $30/200 times 100%=15%$.

*2 · L2:* $(30+90)/200 times 100%=60%$.

*3 · L3:* $(30+90+120)/200 times 100%=120%$.

*Ergebnis: 15 % / 60 % / 120 %.* *Prüfung:* Der erste Folienzielbereich wird erreicht, die beiden anderen unterschritten. Das ist ein Warnsignal für die kurzfristige Deckung; Fälligkeiten und Einbringlichkeit sind zusätzlich zu planen.
#nachschlagen[Lernskript, #stelle(<a-1-9>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[63 · Lösung]
*1 · Gesamtrendite:* $40000/500000 times 100%=8%$.

*2 · Zinsen:* $"0,10" times 400000=40000$ €; nach Zinsen bleibt null.

*3 · EK-Rendite:* $0/100000=0%$. Formel: $8%+(8%-10%) times 4=0%$.

*Ergebnis:* Mit reiner EK-Finanzierung wären es 8 %. *Prüfung:* Der Kredit kostet mehr als die Gesamtrendite; der Hebel wirkt negativ.
#nachschlagen[Lernskript, #stelle(<a-1-12>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[64 · Lösung]
*1 · Q1:* $10000+15000-28000=-3000$ €; freie Linie 2.000 €.

*2 · Q2:* $-3000+30000-26000=1000$ €; freie Linie 5.000 €.

*3 · Q3:* $1000+35000-25000=11000$ €; freie Linie 5.000 €.

*Ergebnis:* Q1 ist durch die vereinbarte Linie gedeckt; Q2 führt den Kredit zurück. *Prüfung:* Bei positivem Kontostand ist die ganze Linie frei, der Kontobestand kommt als eigener Bestand hinzu. Q3 kann Anlass sein, die benötigte Reserve und die Verwendung des Überschusses zu prüfen.
#nachschlagen[Lernskript, #stelle(<a-1-7>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[65 · Lösung]
*Modell:* Gesamtkapital $800+200+150+50=1200$ T€; FK 1.020 T€; jährlicher CF 100 T€.

*1 · Liquidität:* L1 $10%$, L2 $40%$, L3 $80%$.

*2 · Deckung:* AD I $180/800="22,5"%$, AD II $700/800="87,5"%$.

*3 · Struktur:* EK-Quote $15%$, FK-Quote $85%$, Anlageintensität $800/1200 approx "66,7"%$.

*4 · Erfolg/Dauer:* EK-Rentabilität $27/180=15%$, Umsatzrentabilität $27/1500="1,8"%$, Schuldentilgung $1020/100="10,2"$ Jahre.

*Ergebnis:* Die Folienziele L2/L3 und AD II werden verfehlt, das EK-Polster ist niedrig. *Prüfung:* Ein Teil des AV ist kurzfristig finanziert. Das Kennzahlenbild ist kritisch, beweist für sich aber keine fällige Zahlungslücke.
#nachschlagen[Lernskript, #stelle(<a-1-10>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[66 · Lösung]
*Modell:* Wertverlust 30.000 €, Zinsen aus der Kasse; keine sonstigen Veränderungen.

*1 · A:* Maschine 120.000 + Kasse 50.000 = Vermögen und EK *170.000 €*.

*2 · B:* Zins $"0,08" times 160000=12800$ €, Kasse 37.200 €, Vermögen $120000+37200=157200$ €. FK 160.000 €, rechnerisches EK $40000-30000-12800=-2800$ €.

*Ergebnis: B hat 2.800 € bilanziellen Fehlbetrag.* *Prüfung:* Geschäftsverlust identisch; unterschiedliche Finanzierung erzeugt Zinslast und kleineres Polster. Rechtliche Überschuldung gesondert prüfen.
#nachschlagen[Lernskript, #stelle(<a-1-11>). Für die Rechtsabgrenzung zusätzlich #stelle(<a-1-8>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[67 · Lösung]
a) Nr. 4 Beteiligungsfinanzierung: außen, EK. b) Nr. 6 offene Selbstfinanzierung: innen, EK. c) Nr. 9 Vermögensumschichtung: innen; der Verkauf ist keine neue EK-/FK-Aufnahme. d) Nr. 1 Fremdfinanzierung: außen, FK. e) Nr. 3 Eigenfinanzierung: außen, EK. *Prüfung:* Erst Herkunft, danach Rechte prüfen; nicht jede Innenmaßnahme ist eine neue Kapitalaufnahme.
#nachschlagen[Lernskript, #stelle(<a-1-2>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[68 · Lösung]
(i) Vermögenslücke 0,3 Mio. € und keine positive Fortführung: Hinweis auf Überschuldung nach § 19, bei passender rechtlicher Bewertung. Ansätze: Einlage, Forderungsverzicht, geeigneter Rangrücktritt. (ii) 30 % nicht begleichbare Lücke: regelmäßig Zahlungsunfähigkeit im vereinfachten Dreiwochenfall; zusätzliche Liquidität oder verbindliche Zahlungsvereinbarungen prüfen. (iii) Erwartete nicht erfüllbare Märzrate: drohende Zahlungsunfähigkeit (§ 18); frühzeitig Finanzplan und Gegenmaßnahmen entwickeln. *Prüfung:* Die Antragspflichten der drei Fälle sind nicht identisch.
#nachschlagen[Lernskript, #stelle(<a-1-8>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[69 · Lösung]
*1 · CF:* $60+40+20=120$ T€; rechnerische Tilgungsdauer $800/120 approx "6,7"$ Jahre.

*2 · Liquidität:* L1 $30/300=10%$, L2 $150/300=50%$, L3 $300/300=100%$.

*3 · Struktur:* langfristiges FK $800-300=500$; AD II $(200+500)/700=100%$; AD I ≈ 28,6 %; EK-Quote 20 %, FK-Quote 80 %, Anlageintensität 70 %.

*4 · Erfolg:* EK-Rentabilität $60/200=30%$; Umsatzrentabilität mangels Umsatzangabe nicht berechenbar.

*Ergebnis:* Langfristige Deckungsregel gerade erfüllt, kurzfristige Deckung nach den Folienzielen schwach. *Prüfung/Maßnahmen:* Kein automatischer Nachweis der Zahlungsunfähigkeit. Zahlungsplan aufstellen, Forderungseinzug/Factoring oder vereinbarte Lieferantenziele prüfen; ggf. Laufzeiten der Finanzierung anpassen.
#nachschlagen[Lernskript, #stelle(<a-1-10>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[70 · Lösung]
Gewinn ist keine Zahlungsplanung. Die Gründerin muss Anlauf- und Investitionszahlungen, Kundenzahlungsziele sowie Zins/Tilgung und Reserven erfassen. Im Folienbeispiel 39–40 stehen spätere Gewinne neben negativen Planbeständen. *Prüfung:* Der Finanzplan zeigt Zeitpunkt und Höhe der Lücke; erst eine zugesagte Finanzierung macht das Programm zahlungsfähig.
#nachschlagen[Lernskript, #stelle(<a-1-7>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[71 · Lösung]
*Modell:* $r_G=12%$ und $r_f=7%$ bleiben für die Rechnung konstant.

*1 · 50 % FK:* $r_e=12%+(12%-7%) times 50/50=17%$.

*2 · 85 % FK:* $r_e=12%+(12%-7%) times 85/15 approx "40,3"%$.

*Ergebnis: 17 % → 40,3 % im Modell.* *Prüfung:* EK-Quote sinkt auf 15 %, Verlustpolster wird klein. In der Praxis können Kreditzins und Bonität reagieren; fällt die Gesamtrendite unter den Kreditzins, wirkt der große Hebel gegen die Eigentümer.
#nachschlagen[Lernskript, #stelle(<a-1-12>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[72 · Lösung]
a) Hoher operativer CF und negativer Investitions-CF können selbst finanzierte Investitionen anzeigen; ohne Beträge, Fälligkeiten und Investitionsqualität ist kein pauschales Urteil möglich. b) Steigender Gewinn bei sinkender Kasse ist ein Anlass zur Überleitung, etwa wegen Forderungsaufbau oder Investitionen. c) AD II 80 % verfehlt die goldene Bilanzregel: Ein Teil des Anlagevermögens ist kurzfristig finanziert. *Prüfung:* Kennzahlen sind Warnhinweise und ersetzen nicht den Zahlungsplan.
#nachschlagen[Lernskript, #stelle(<a-1-6>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[73 · Lösung]
Ein gewöhnlicher Kredit vergrößert Vermögen und Schulden um denselben Betrag. Die rechnerische Unterdeckung verschwindet dadurch nicht. Einlage, Forderungsverzicht oder ein rechtlich geeigneter Nachrang sind andere Ansatzpunkte. *Prüfung:* Handelsbilanzieller Fehlbetrag und rechtliche Überschuldung sind getrennt zu prüfen; eine Antragspflicht darf weder allein aus dem Buch-EK behauptet noch bei tatsächlich vorliegendem Grund übergangen werden.
#nachschlagen[Lernskript, #stelle(<a-1-8>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[74 · Lösung]
Die Bilanz liefert die operative Kapitalbindung und Finanzierungsbestände. Die GuV liefert Kosten, Abschreibung, Zinsaufwand und die Steuerbasis. Der Finanzplan liefert Mittelbedarf und Kreditaufnahme; daraus folgen wiederum Zinsen. *Prüfung:* Ein isolierter Gewinn genügt für keine vollständige Kapitalbedarfsrechnung.
#nachschlagen[Lernskript, #stelle(<a-1-13>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[75 · Lösung]
*1 · Umsatz:* $20000 thin "t" times 13500 thin "€/t"=270000000$ € = *270 Mio. €*.

*2 · Kapazität:* $365 times 75=27375$ t/Jahr. Die Mengenreihe 20.000 → 22.500 → rund 25.313 würde bei nochmals 12,5 % darüberliegen. Die Tabelle begrenzt 2008 deshalb auf *27.375 t*.

*Prüfung:* Mengen- und Preisannahmen brauchen eine physische Kapazitätsprüfung.
#nachschlagen[Lernskript, #stelle(<a-1-13>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[76 · Lösung]
*1 · Bestand:* $23529+31564-18884-7744-19348=9117$ T€.

*2 · Änderung:* $9117-(-10914)=20031$ T€.

*Ergebnis: EBK 9,117 Mio. €, Zunahme 20,031 Mio. €.* *Prüfung:* Die positive Zunahme bindet Geld. Sie ist vom EBK-Bestand zu unterscheiden.
#nachschlagen[Lernskript, #stelle(<a-1-14>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[77 · Lösung]
*Modell:* Die ausdrücklich fortgeführte VLei-Quote ist 10 %, trotz des markierten Buchfehlers.

*1 · Bestände:* LB 24.300, FLei 35.100, VLei 27.000 T€.

*2 · EBK:* $24300+35100-27000-8775-17000=6625$ T€.

*3 · Änderung:* $6625-9117=-2492$ T€.

*Ergebnis: 2,492 Mio. € Freisetzung.* *Prüfung:* In der NOCF-Rechnung wird die negative Änderung abgezogen, wirkt also *positiv*.
#nachschlagen[Lernskript, #stelle(<a-1-14>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[78 · Lösung]
*1 · Operative Abgrenzung:* $270000-72000-73828-83359=40813$ T€.

*2 · Betriebskapital:* $40813-(-2492)=43305$ T€.

*Ergebnis: 43,305 Mio. € NOCF vor Steuern.* *Prüfung:* Die EBK-Freisetzung erhöht den Zahlungsbeitrag. Abschreibung ist keine laufende Auszahlung; ihre Steuerwirkung folgt über die Plan-GuV.
#nachschlagen[Lernskript, #stelle(<a-1-14>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[79 · Lösung]
*1 · Gebäude:* $30 times "0,75"="22,5"$ Mio. € sofort. Rest 7,5 Mio. € über neun Jahre: rund *0,833 Mio. €/Jahr*.

*2 · Anlagen:* $55 times "0,75"="41,25"$ Mio. € sofort. Rest 13,75 Mio. € über drei Jahre: rund *4,583 Mio. €/Jahr*.

*Prüfung:* Summe aller Abschreibungen über die jeweilige Nutzungsdauer entspricht den Anschaffungskosten. Es handelt sich um historische Fallannahmen.
#nachschlagen[Lernskript, #stelle(<a-1-15>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[80 · Lösung]
*Modell:* Vollständige Verlustverrechnung entsprechend der Falltabelle, keine heutige steuerrechtliche Behauptung.

*1 · Steuerbasis:* $45377-39410=5967$ T€.

*2 · Steuer:* $5967 times "0,5"="2983,5"$ T€, tabellarisch gerundet 2.984.

*3 · NOCF nach Steuer:* $63912-2984=60928$ T€.

*Ergebnis: rund 2,984 Mio. € Steuer und 60,928 Mio. € NOCF.* *Prüfung:* Nicht einfach 50 % des ganzen positiven Ergebnisses besteuern.
#nachschlagen[Lernskript, #stelle(<a-1-15>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[81 · Lösung]
*1 · Vorläufige Mittel:* $43305-3214=40091$ T€.

*2 · Alle gegebenen Entscheidungen:* $40091+20000+5000-85000-3120=-23029$ T€.

*Ergebnis: Bedarf 23,029 Mio. €.* Die Tabelle zeigt danach Überschüsse *50,594 / 48,108 / 59,915 Mio. €* für 2006–2008.

*Prüfung:* Die Investitionssumme ist nicht der verbleibende Außenfinanzierungsbedarf. Die Lücke 2005 muss trotzdem rechtzeitig gedeckt werden; spätere Überschüsse allein zahlen 2005 nicht.
#nachschlagen[Lernskript, #stelle(<a-1-15>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[82 · Lösung]
*1 · Gebäude:* $"38,805"-"3,259"+30-"22,5"="43,046"$ Mio. €.

*2 · Maschinen:* $"16,302"-10+55-"41,25"="20,052"$ Mio. €.

*3 · Darlehen:* Von 11 auf rund 34 Mio. € bedeutet rechnerisch rund 23 Mio. € zusätzliche Mittel. Die Eigentümer wollen laut Ausgangslage keine weiteren Mittel geben; die Annahme schließt die Lücke nur formal.

*Prüfung:* Geplante Aufnahme und verbindlich zugesagte Finanzierung sind zu unterscheiden.
#nachschlagen[Lernskript, #stelle(<a-1-16>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[83 · Lösung]
*1 · Investition:* $"0,20" times 85=17$ Mio. € Verschiebung.

*2 · Forderungen:* $("0,13"-"0,095") times 270="9,45"$ Mio. € weniger Bindung.

*3 · Verbesserung:* $17+"9,45"="26,45"$ Mio. €; gegenüber 23,029 Mio. € Bedarf rund *3,421 Mio. € Überschuss*.

*Prüfung:* Die rund 11,9 Mio. € beziehen sich auf das geänderte EBK gegenüber 2004, nicht auf die zusätzliche Wirkung gegenüber dem alten Plan 2005. Die 17 Mio. € werden im Folgejahr fällig.
#nachschlagen[Lernskript, #stelle(<a-1-17>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[84 · Lösung]
*1 · Aufwandsunterschied:* $"22,5"-3="19,5"$ Mio. €.

*2 · Verlustvortrag:* $"39,41"-"19,50"="19,91"$ Mio. €. Der Fall zeigt danach positives bilanzielles EK.

*Prüfung:* Das verschiebt einen steuerlichen Vorteil im historischen Modell und ändert keine bereits bezahlte Investitionssumme. Handelsbilanzielles EK, steuerlicher Effekt und Rechtsüberschuldung sind getrennt zu prüfen; für Letztere gilt insbesondere die aktuelle Zwölfmonatsbetrachtung des § 19.
#nachschlagen[Lernskript, #stelle(<a-1-18>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[85 · Lösung]
Der Kreditgeber braucht eine Überleitung: Der hohe bilanzielle Verlust stammt im Modell maßgeblich aus Sonderabschreibungen; das Kerngeschäft erwirtschaftet dennoch hohe Zahlungsüberschüsse. Die Lücke 2005 ist bei tragfähigen Annahmen vorübergehend, erfordert aber eine zugesagte Brücke. Ein geeigneter Nachrang kann für die Überschuldungsprüfung Bedeutung haben, ist jedoch keine automatische Löschung der Schuld oder Auffüllung handelsbilanziellen EK. *Prüfung:* Zukünftige Liquidität, Bilanzbild und rechtliche Voraussetzungen müssen gemeinsam erklärt werden.
#nachschlagen[Lernskript, #stelle(<a-1-18>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[86 · Lösung]
*Modell:* Gesamtkapital in allen Fällen 800.000 €; Bruttogewinn 70.000 € = Gewinn vor FK-Zinsen; Zinsen = Zinssatz × FK; keine Steuern.

*1 · Gesamtkapitalrentabilität:* $70000/800000 = "0,0875"$, also *8,75 %*. Sie ist in allen vier Fällen gleich, weil sich nur die Finanzierung ändert.

*2 · Zinsen in €, Gewinn nach Zinsen, EK-Rentabilität:*
#tab(columns: (0.5fr, 1fr, 1fr, 0.8fr, 1fr, 1.2fr, 1fr),
 th([Fall], [EK, €], [FK, €], [Zins], [Zinsen, €], [Gewinn nach Zinsen, €], [EK-Rendite]),
 [1], [500.000], [300.000], [6 %], [18.000], [52.000], [*10,40 %*],
 [2], [300.000], [500.000], [6 %], [30.000], [40.000], [*13,33 %*],
 [3], [500.000], [300.000], [10,5 %], [31.500], [38.500], [*7,70 %*],
 [4], [300.000], [500.000], [10,5 %], [52.500], [17.500], [*5,83 %*],
)
Rechenweg Fall 2: $(70000 - "0,06" times 500000)/300000 = 40000/300000 = "13,33" %$.

*Prüfung mit der Leverage-Formel:* Fall 2: $"8,75" + ("8,75" - 6) times 500/300 = "13,33"$ %. Fall 4: $"8,75" + ("8,75" - "10,5") times 500/300 = "5,83"$ %. Beide Wege stimmen überein.

#note("Fehler vermeiden", [Nicht den Zinssatz von einer Rendite abziehen (z. B. „14 % − 6 % = 8 %“). Die Zinsen fallen nur auf das FK an. Erst den Zinsbetrag in € abziehen, dann durch das EK teilen. Im Scan der Klausur steht genau dieser Fehler als handschriftliche Antwort und ist als falsch bewertet.], fill: sand)
#nachschlagen[Lernskript, #stelle(<a-1-12>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[87 · Lösung]
*b) Leverage-Effekt an den Ergebnissen:* Bei 6 % FK-Zins liegt die Gesamtkapitalrentabilität (8,75 %) *über* dem Zins. Mehr FK (FK/EK von 0,6 auf 1,67) hebt die EK-Rendite von 10,40 % auf 13,33 %. Bei 10,5 % liegt sie *unter* dem Zins. Derselbe Hebel senkt die EK-Rendite von 7,70 % auf 5,83 %. Die Richtung hängt am Vorzeichen von $r_G - r_f$, die Stärke am Verschuldungsgrad. Zugleich zeigt der Vergleich den *Risikoeffekt*: Steigt der Zins von 6 % auf 10,5 %, fällt die EK-Rendite bei FK/EK = 0,6 um 2,70 Prozentpunkte, bei FK/EK = 1,67 um 7,50 Prozentpunkte.

*c) Zwei Aspekte gegen hohe Verschuldung* (zwei genügen):
- Zins und Tilgung sind fest vereinbart und auch in schlechten Jahren fällig. Das erhöht die Gefahr der Zahlungsunfähigkeit.
- Wenig EK ist ein kleines Verlustpolster. Verluste führen schneller zur Überschuldung (vgl. Hubert + Maier, Alternative B).
- Risikoeffekt: Die EK-Rendite schwankt stärker; fällt $r_G$ unter $r_f$, wirkt der Hebel gegen die Eigentümer.
- Eine niedrige EK-Quote verschlechtert die Bonität. Neue Kredite können schwerer zu bekommen oder teurer werden (eigene Ergänzung; die Folien nennen die Bonitätswirkung der EK-Quote).

*Prüfung:* „Niemand finanziert mehr“ oder „Personal muss gekürzt werden“ (Antworten im Scan) sind keine begründeten Finanzierungsaspekte und wurden nur teilweise gewertet.
#nachschlagen[Lernskript, #stelle(<a-1-12>); #stelle(<a-1-11>); #stelle(<a-1-10>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[88 · Lösung]
*Modell:* Laut Aufgabe sind alle zahlungswirksamen Positionen 2015 voll bezahlt. Nicht zahlungswirksam sind die Abschreibungen (7) und die Zuführung zu den Pensionsrückstellungen (4).

*1 · Kontrolle der GuV:* $69 - (21 + 23 + 4 + 7 + 5) = 69 - 60 = 9$ Mio. € = Jahresüberschuss.

*2 · Direkte Methode:* $69 - 21 - 23 - 5 = 20$ Mio. €.

*3 · Indirekte Methode:* $9 + 7 + 4 = 20$ Mio. €.

*Ergebnis: Cashflow 2015 = 20 Mio. €* nach beiden Methoden. *Prüfung:* Der Unterschied zum Jahresüberschuss (11 Mio. €) entspricht genau den Aufwendungen ohne Auszahlung.
#nachschlagen[Lernskript, #stelle(<a-1-5>).]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[89 · Lösung]
Zwei der folgenden Formen:
- *Vermögensumschichtung:* nicht mehr benötigte Vermögensgegenstände entgeltlich verkaufen (Folie 9).
- *Finanzierung aus Abschreibungen:* Abschreibungsgegenwerte fließen über bezahlte Umsatzerlöse zurück (Pizzeria, Folie 21).
- *Finanzierung aus Rückstellungen:* Aufwand ist gebucht, die Auszahlung kommt erst später.

In Aufgabe 88 sind das genau die 7 Mio. € Abschreibungen und die 4 Mio. € Zuführung zu Pensionsrückstellungen. Ausführlich behandelt die Vorlesung beide Formen erst in Kapitel C (V, PDF-S. 108 und 111, Folien 215 und 221–222).

*Prüfung:* Außen- oder Fremdfinanzierung (Antwort im Scan) sind keine Innenfinanzierung, denn die Mittel kommen von außen.
#nachschlagen[Lernskript, #stelle(<a-1-2>); #stelle(<a-1-5>).]
]

#pagebreak()
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
