// Kopf des Feynman-Lernskripts (Layout + Bausteine). Bilder liegen in abbildungen/. Keine Pakete erforderlich.
#set document(title: "Investitionsrechnung und technisches Controlling – Feynman-Lernskript", author: "Lernzusammenfassung")
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
  #text(size: 8pt, fill: muted)[Feynman-Lernskript · Stand 22.10.2026]
  #h(1fr)
  #text(size: 9pt, fill: navy)[Seite #counter(page).display("1") von #counter(page).final().first()]
]
#set page(paper: "a4", margin: (left: 20mm, right: 19mm, top: 19mm, bottom: 20mm),
 header: [#text(size: 8pt, fill: muted)[Investitionsrechnung und technisches Controlling #h(1fr) Sehen · Verstehen · Erklären]], footer: seitenfuss)
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
  "bep-aufgabe1": "abbildungen/bep-aufgabe1.svg",
  "bep-aufgabe3": "abbildungen/bep-aufgabe3.svg",
  "bep-ausserhalb": "abbildungen/bep-ausserhalb.svg",
  "cover": "abbildungen/cover.svg",
  "deckungsbalken": "abbildungen/deckungsbalken.svg",
  "entscheidungsvergleich": "abbildungen/entscheidungsvergleich.svg",
  "map-begriffe": "abbildungen/map-begriffe.svg",
  "map-bep": "abbildungen/map-bep.svg",
  "map-deckung": "abbildungen/map-deckung.svg",
  "map-entscheidung": "abbildungen/map-entscheidung.svg",
  "map-kosten": "abbildungen/map-kosten.svg",
  "map-perioden": "abbildungen/map-perioden.svg",
  "map-stueck": "abbildungen/map-stueck.svg",
  "map-ueberblick": "abbildungen/map-ueberblick.svg",
  "original-bep": "abbildungen/original-bep.svg",
  "original-gewinn": "abbildungen/original-gewinn.svg",
  "original-merke": "abbildungen/original-merke.svg",
  "original-sprung": "abbildungen/original-sprung.svg",
  "stueckkosten": "abbildungen/stueckkosten.svg",
)

#let bilddeutungen = (
  "bep-aufgabe1": (titel: "Bild lesen", body: [Waagerecht steht die Monatsmenge, senkrecht Euro je Monat. Grün ist E(x), orange K(x), gestrichelt der Fixkostenbetrag. Ihr Schnittpunkt liegt bei 500 Packungen und 35 000 €. Bei 1 000 Packungen stehen 70 000 € Erlös 50 000 € Kosten gegenüber; der senkrechte Abstand beträgt 20 000 € Gewinn.]),
  "bep-aufgabe3": (titel: "Bild lesen", body: [Waagerecht steht die Monatsmenge, senkrecht stehen Euro je Monat. Der Schnittpunkt von E = 40x und K = 200 000 + 25x liegt bei 13 333,333… Stück. Die gestrichelte Senkrechte bei 24 000 zeigt die Novembermenge. Sie ist keine belegte Kapazitätsgrenze. Die größeren Abstände rechts des Schnittpunkts bedeuten höheren Gewinn.]),
  "bep-ausserhalb": (titel: "Bild lesen", body: [Die grüne Erlöslinie steigt stärker als die orange Kostenlinie, schneidet sie aber erst bei 5 000 Stück. Die senkrechte Kapazitätsgrenze liegt bereits bei 4 500. Dort ist die Kostenlinie noch 3 000 € höher. Die Fortsetzung nach rechts zeigt nur den rechnerischen Schnittpunkt, keine lieferbare Menge.]),
  "cover": (titel: "Bild lesen", body: [Lies von links nach rechts: Vom Nettoerlös 70 € gehen 30 € variable Kosten ab. Der grüne Rest von 40 € ist der Beitrag einer Packung. Unten wird daraus die Gesamtdeckung: 500 Beiträge decken 20 000 € Fixkosten. Diese Darstellung ist eine Kostenrechnung, kein Zeitverlauf von Zahlungen.]),
  "deckungsbalken": (titel: "Bild lesen", body: [Oben ist eine einzelne Packung in 30 € variable Kosten und 40 € Beitrag zerlegt. Unten steht der gesamte Beitrag von 600 Packungen: 24 000 €. Davon deckt der blaue Anteil 20 000 € Fixkosten; nur die letzten 4 000 € bleiben als Gewinn. Die beiden Balken verwenden verschiedene Bezugsgrößen.]),
  "entscheidungsvergleich": (titel: "Bild lesen", body: [Die Balkenhöhe zeigt den Monatsgewinn, keine Absatzmenge. Der bisherige Fall bringt 12 000 €. Der orange Balken der allgemeinen Preissenkung sinkt auf 10 000 €, obwohl mehr verkauft wird. Der separate Zusatzauftrag erhöht den Gewinn auf 13 000 €, weil die bisherigen 800 Packungen weiter 70 € erlösen.]),
  "map-begriffe": (titel: "Bild lesen", body: [Beginne im dunkelgrünen Zentrum. Die vier hellblauen Äste gehören zusammen: Gesamt und Stück unterscheiden, Kapazität mit Zeitbezug angeben und netto auf derselben Periodenbasis rechnen. Prüfe diese Begriffe vor jeder Formel.]),
  "map-bep": (titel: "Bild lesen", body: [Beginne im dunkelgrünen Zentrum. Die vier hellblauen Äste gehören zusammen: Den Schnittpunkt mit E = K begründen, Kf durch den positiven Stück-DB teilen, ganze Stücke korrekt runden und die Kapazität prüfen.]),
  "map-deckung": (titel: "Bild lesen", body: [Beginne im dunkelgrünen Zentrum. Die vier hellblauen Äste gehören zusammen: Vom Nettoerlös erst variable Kosten abziehen, den Stückbeitrag mit der Menge multiplizieren und dann die Fixkosten einmal abziehen. Erst der letzte Schritt liefert das Ergebnis.]),
  "map-entscheidung": (titel: "Bild lesen", body: [Beginne im dunkelgrünen Zentrum. Die vier hellblauen Äste gehören zusammen: Die Art der Preisänderung unterscheiden, freie Kapazität prüfen, die passende Ergebnisänderung berechnen und Kundenrisiken berücksichtigen.]),
  "map-kosten": (titel: "Bild lesen", body: [Beginne im dunkelgrünen Zentrum. Die vier hellblauen Äste gehören zusammen: Fixkosten, variable Kosten, Mischkosten und Sprünge auseinanderhalten. Die Kostenfunktion ist erst sinnvoll, wenn diese Einordnung und ihr Mengenbereich stimmen.]),
  "map-perioden": (titel: "Bild lesen", body: [Beginne im dunkelgrünen Zentrum. Die vier hellblauen Äste gehören zusammen: Zwei Beobachtungen vergleichen, daraus die Steigung ermitteln, den Fixkostenblock berechnen und mit der zweiten Periode gegenprüfen.]),
  "map-stueck": (titel: "Bild lesen", body: [Beginne im dunkelgrünen Zentrum. Die vier hellblauen Äste gehören zusammen: Von K(x) durch Teilen zu k(x) gelangen, dabei fixe und variable Stückanteile unterscheiden und die Kapazitätsgrenze beachten. Mehr Menge verteilt Fixkosten, beseitigt sie aber nicht.]),
  "map-ueberblick": (titel: "Bild lesen", body: [Beginne im dunkelgrünen Zentrum. Die vier hellblauen Äste gehören zusammen: Bezugsgröße klären, Kosten aufteilen, Beiträge zur Deckung sammeln und danach entscheiden. Gehe diesen Weg beim Erklären einer Aufgabe in derselben Reihenfolge durch.]),
  "original-bep": (titel: "Bild lesen", body: [Waagerecht steht die Stückzahl, senkrecht stehen Kosten und Erlös in Euro. Die rote Erlösgerade startet im Ursprung; die orange Kostenlinie startet oberhalb davon bei den Fixkosten. Am Schnittpunkt ist der Gewinn null. Die blaue Senkrechte begrenzt die Kapazität; der Abstand der Geraden dort ist der maximal mögliche Gewinn im gezeichneten linearen Modell.]),
  "original-gewinn": (titel: "Bild lesen", body: [Der grüne Rahmen hält den Zusatzauftrag getrennt vom bisherigen Absatz fest. Die Erlöse beider Mengen werden addiert, die Kosten der neuen Gesamtmenge einmal abgezogen. Die Randnotiz warnt davor, dass bisherige Kunden ebenfalls den niedrigen Preis fordern könnten. Den verschriebenen Faktor bei den 7 000 € korrigiert die Lösung sichtbar.]),
  "original-merke": (titel: "Bild lesen", body: [Die roten Zeilen markieren drei Arbeitsregeln: Großbuchstaben für Gesamtbeträge einer Menge, Kleinbuchstaben für einen Stückbetrag und Nettopreise für die Rechnung. Die Farbe zeigt hier Deine Hervorhebung, keine zusätzliche Kostenart.]),
  "original-sprung": (titel: "Bild lesen", body: [Waagerecht nimmt die Menge zu, senkrecht stehen Kosten. Die waagerechten Stufen zeigen feste Kosten innerhalb eines Bereichs; der senkrechte Sprung steht für den neuen Fixkostenblock ab der markierten Grenze. Er ist kein proportionaler Anstieg bei jedem Stück.]),
  "stueckkosten": (titel: "Bild lesen", body: [Waagerecht steht die monatliche Packungsmenge, senkrecht Euro je Packung. Die blaue Kurve zeigt k = 20 000/x + 30; die grün gestrichelte Linie den konstanten variablen Anteil von 30 €. Der Abstand zwischen Kurve und Linie ist der fixe Anteil je Packung. Er sinkt, weil dieselben Fixkosten auf mehr Packungen verteilt werden.]),
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
#v(7mm)
#text(size: 11pt, tracking: 1pt, fill: teal)[VERSTEHEN · ERKLÄREN · ANWENDEN]
#v(6mm)
#text(size: 27pt, weight: "bold", fill: navy)[Investitionsrechnung\ und technisches Controlling]
#v(4mm)
#text(size: 20pt, fill: navy)[Feynman-Lernskript]
#v(3mm)
#text(size: 12pt)[Zusammenhänge sehen. Grundlagen verstehen. Selbst erklären.]
#v(4mm)
#bild("cover", [Vom Verkaufserlös zum Deckungsbeitrag. Eigene Darstellung mit den Zahlen aus Ü 1, PDF-S. 1.], height: 61mm)
#v(3mm)
#text(size: 12pt, fill: teal)[Menge → Kosten → Deckungsbeitrag → Gewinn → Entscheidung]
]
#note("Dein Feynman-Schritt", [Erkläre ohne Vorlage: *Was kostet ein weiteres Stück? Was trägt es bei? Wann wird daraus Gewinn?* Zeichne dazu zwei Linien oder einen Geldfluss. Prüfe anschließend Erklärung, Einheiten und Annahmen.])

*Stand 22.10.2026.* Enthalten ist der von Dir bestätigte Stoff aus VL 1–2: Grundlagen der KLR und Deckungsbeitragsrechnung, einschließlich der Aufgaben 1–4 des Blatts „08 Übungsaufgaben: KLR“. Die fachlichen Inhalte der älteren Skripte sind zusammengeführt; passende Altklausurteile ergänzen die offenen Aufgaben. Spätere Investitionsverfahren und Controllingkennzahlen folgen erst nach Behandlung in der Vorlesung.
#src[Gliederung, PDF-S. 1–2; K, PDF-S. 1–2; Ü, PDF-S. 1–2; L15, PDF-S. 1 und 22; Umfang von Mario am 22.10.2026 bestätigt.]

#pagebreak()
#heading(level: 1, outlined: false)[Wegweiser]
#block[
#set text(size: 9.5pt)
#set par(leading: 0.3em, spacing: 0.15em)
#outline(title: none, depth: 2, indent: auto)
]
#v(2mm)
#text(size: 8.5pt, fill: muted)[*Quellenkürzel:* M = „KLR Skript eigenes Skript.pdf“, 2 S., vom 06.10.2026; K = „KLR.pdf“, 2 S., handschriftliche Grundlagen und VL-1-Übung; Ü = „VL2 Investition und Controlling.pdf“, 2 S., Blatt „08 Übungsaufgaben: KLR“ mit Notizen; Fotos Ü 2–4 = gleichnamige Originalfotos; F = „Formelsammlung.pdf“, 7 S.; A13 = „Controlling SS 13.pdf“; A14 = „Controlling WS 14-15.pdf“; A18 = „Controlling WS18-19.pdf“; L15 = „Stand 15.10.26_Lernskript_Investition.pdf“, 22 S.; L13 = Stand 13.10., 18 S.; L02 = „VL02_KLR_Grundlagen_Lernskript.pdf“, 15 S.; H = zugehörige frühere HTML-Skripte. Die alten Skripte liegen in „Zum Löschen/Alte Lernskript-Stände/“. „PDF-S.“ zählt ab der ersten Dateiseite. Alle „Nachschlagen“-Verweise führen mit automatisch berechneter Seite in dieses Lernskript. Eigene Erklärhilfen und Präzisierungen sind gekennzeichnet.]

#bild("map-ueberblick", [Die Denkkette des bisher behandelten Stoffs. Eigene Darstellung nach K und Ü, jeweils PDF-S. 1–2.], height: 47mm)

#pagebreak()
= Kapitel 1 · KLR und #box[Deckungsbeitragsrechnung]

Ein Betrieb kann viel verkaufen und trotzdem Verlust machen. Deshalb trennst Du zuerst die Kosten eines zusätzlichen Stücks von den Kosten, die ohnehin anfallen. Danach verbindest Du Preis, Menge und Kapazität zu einer nachvollziehbaren Entscheidung. Diese Grundlage steht in der Gliederung vor den eigentlichen Investitionsverfahren.
#src[Gliederung, PDF-S. 1; K, PDF-S. 1–2; Ü 1–4, PDF-S. 1–2. Einstieg: eigene Erklärung.]

== 1.1 Begriffe: erst die Bezugsgröße klären <a-1-1>

Ein Preis von 70 € je Packung und ein Monatsumsatz von 42 000 € sind unterschiedliche Größen. *Großbuchstaben* bezeichnen hier Beträge für die ganze betrachtete Menge, *Kleinbuchstaben* Beträge je Stück. Die *Periode* ist der gemeinsame Zeitraum, beispielsweise ein Monat.

#tab(columns: (0.8fr, 2.8fr, 1.25fr),
 th([Symbol], [Bedeutung], [Einheit]),
 [$x$], [hergestellte und verkaufte Menge im betrachteten Modell], [Stück/Periode],
 [Kap, $x_"max"$], [Kapazität: maximal mögliches Leistungsvermögen], [Stück/Periode],
 [BG], [Beschäftigungsgrad: Anteil der genutzten Kapazität], [%],
 [$K(x), K_f, K_v(x)$], [Gesamtkosten, fixe Kosten, variable Gesamtkosten], [€/Periode],
 [$k(x), k_f(x), k_v$], [gesamte, fixe und variable Kosten je Stück], [€/Stück],
 [$e$], [Nettoverkaufspreis je Stück], [€/Stück],
 [$E(x), G(x)$], [Erlös und Gewinn bzw. Betriebsergebnis], [€/Periode],
 [$d b_"I", d b_"II"$], [Stückdeckungsbeitrag und Ergebnis je Stück], [€/Stück],
 [$D B_"I", D B_"II"$], [Deckungsbeitrag gesamt und Ergebnis gesamt im einstufigen Schema], [€/Periode],
 [BEP; IB], [Break-Even-Point = Gewinnschwelle; Industriebetrieb], [Menge bzw. Betrieb],
)

*Kapazität braucht einen Zeitbezug:* 7 000 Stück pro Stunde sind etwas anderes als 7 000 Stück pro Monat. Bei 4 900 von 7 000 möglichen Stück pro Stunde sind 70 % ausgelastet; 30 % bleiben frei.
#form[$ "BG" = x/x_"max" dot 100 % $]
Zähler und Nenner müssen zur selben Periode gehören. Wenn in einer Aufgabe nur „Kap = 1 300 Stück“ steht, beziehst Du sie auf die dort betrachtete Periode; eine Stunde oder einen Monat ergänzt Du nicht ohne Beleg.

#bild("original-merke", [Deine roten Merksätze zu Groß-/Kleinschreibung und Nettopreisen. Ausschnitt M, PDF-S. 1.], height: 24mm)
#note("Von Dir markiert", [*Groß = gesamt, klein = je Stück. Immer Nettopreise.* Das sind die roten „Merke“-Zeilen aus Deiner Mitschrift.])

*Brutto in netto umrechnen:* In Ü 4 wird bei 19 % Umsatzsteuer aus 214,20 € brutto ein Nettoverkaufspreis von 180 €. Für diese Aufgabe gilt:
#form[$ e_"netto"=e_"brutto"/(1+"0,19")=("214,20" thin "€")/("1,19")=180 thin "€" $]
Die 19 % sind die Rechenannahme dieser Aufgaben. In den folgenden Erlösrechnungen wird mit dem Nettopreis gerechnet.
#bild("map-begriffe", [Mindmap: Bezugsgrößen vor dem Einsetzen prüfen. Eigene Darstellung nach M und K, jeweils PDF-S. 1.], height: 46mm)
#src[M, PDF-S. 1–2; K, PDF-S. 1–2; Ü 4, PDF-S. 2; Foto Ü 4; L15, PDF-S. 3. Klarstellung zur Periode: eigene Präzisierung.]

== 1.2 Fixe, variable, gemischte und sprungfixe Kosten <a-1-2>

*Fixe Kosten* bleiben innerhalb des betrachteten Beschäftigungsbereichs und Zeitraums gleich, etwa die hier vorgegebene Monatsmiete. *Variable Kosten* ändern sich mit der Menge. Im linearen Modell verursacht jede weitere Packung denselben variablen Betrag $k_v$.

*Eigene Erklärhilfe:* Beim Handyvertrag entspricht eine feste Grundgebühr dem fixen Anteil; jede zusätzlich berechnete Minute dem variablen Anteil. Bei einer Pizzeria sind Ladenmiete und Zutaten eine ähnliche Hilfe zum Einordnen. Welche Kosten tatsächlich fix sind, entscheidet aber immer das konkrete Modell.

#tab(columns: (2.1fr, 1fr, 1.8fr),
 th([Kosten aus Ü 1], [Ansatz], [Warum in dieser Aufgabe?]),
 [Gehälter 9 000 €], [$K_f$], [monatlicher Festbetrag],
 [Miete 1 600 €], [$K_f$], [nicht von Packungen abhängig],
 [Nebenkosten 400 €], [$K_f$], [als Monatsbetrag vorgegeben],
 [Fremdkapitalzinsen 3 000 €], [$K_f$], [mengenunabhängig angesetzt],
 [Abschreibungen 6 000 €], [$K_f$], [hier zeitabhängig angesetzt],
 [RHB-Stoffe 6 €/Packung], [$k_v$], [Roh-, Hilfs- und Betriebsstoffe je Packung],
 [Akkordlöhne 22 €/Packung], [$k_v$], [Bezahlung je erstellter Packung],
 [Energie 2 €/Packung], [$k_v$], [je Packung vorgegeben],
)
Damit ergeben sich *20 000 € Fixkosten pro Monat* und *30 € variable Kosten je Packung*. Die Eurobeträge je Monat und je Packung werden nicht direkt miteinander addiert.

*Mischkosten* enthalten beide Anteile. In Deiner Randnotiz steht deshalb: zuerst in variabel und fix aufteilen. Beispiel als eigene Erklärhilfe: Stromkosten aus Grundpreis und Verbrauchspreis.

*Sprungfixe Kosten* bleiben nur in einem Bereich konstant. Ab einer Grenze braucht man etwa eine weitere Maschine; damit beginnt ein neuer Fixkostenblock. Die Skizze auf Ü, PDF-S. 1 markiert einen Sprung bei 9 000 Stück.
#bild("original-sprung", [Sprungfixe Kosten aus Deiner Randnotiz; Ausschnitt Ü, PDF-S. 1.], height: 38mm)
#note("Fehler vermeiden", [Der *1-Stück-Test* ist eine Erklärhilfe: „Ändert sich dieser Betrag bei einem Stück mehr?“ Er gilt innerhalb desselben Bereichs. An einem Fixkostensprung reicht eine einzige Kostenfunktion mit unverändertem $K_f$ nicht mehr. „Je Stück“ allein beweist ebenfalls keine variable Kostenart: Auch fixe Kosten können rechnerisch auf Stücke verteilt sein.], fill: sand)
#bild("map-kosten", [Mindmap: Kosten zuerst richtig aufteilen. Eigene Darstellung nach Ü 1, PDF-S. 1.], height: 46mm)
#src[Ü 1 und Randnotizen, PDF-S. 1; L15, PDF-S. 4; L02, PDF-S. 2–3. Analogien und Modellgrenzen: eigene Erklärung/Präzisierung.]

== 1.3 Kostenfunktion und Stückkosten <a-1-3>

Die *Kostenfunktion* beantwortet: „Was kostet die ganze Menge?“ Die *Stückkosten* beantworten: „Wie viel davon entfällt rechnerisch auf ein Stück?“ Das ist dieselbe Kostenrechnung mit einer anderen Bezugsgröße.
#form[$ K_v(x)=k_v x quad K(x)=K_f+k_v x $]
$K_f$: €/Periode; $k_v$: €/Stück; $x$: Stück/Periode. Gültig bei unveränderten Fixkosten und proportionalen variablen Kosten innerhalb des betrachteten Bereichs.
#form[$ k(x)=K(x)/x=K_f/x+k_v=k_f(x)+k_v quad k_f(x)=K_f/x $]
$k,k_f,k_v$: €/Stück. Für die Division gilt $x>0$; bei $x=0$ sind Stückkosten nicht definiert, obwohl die Gesamtkosten $K(0)=K_f$ existieren.

#tab(columns: (0.8fr, 1fr, 1fr, 1fr, 1fr),
 th([$x$], [$K_f$ in €], [$K_v$ in €], [$K$ in €], [$k$ in €/Pack.]),
 [200], [20 000], [6 000], [26 000], [130,00],
 [400], [20 000], [12 000], [32 000], [80,00],
 [600], [20 000], [18 000], [38 000], [63,33],
 [800], [20 000], [24 000], [44 000], [55,00],
 [1 000], [20 000], [30 000], [50 000], [50,00],
)
Tabelle für Ü 1: $K_f=20 000$ €/Monat, $k_v=30$ €/Packung. Die Produktionsmengen sind Monatsmengen.

#bild("stueckkosten", [Fixkostendegression mit den Zahlen aus Ü 1, PDF-S. 1. Eigene Darstellung.], height: 58mm)
Die *Fixkostendegression*, in der Mitschrift „Gesetz der Massenproduktion“, verteilt dieselben Fixkosten auf mehr Stücke. Bei 200 Packungen sind es 100 € fixe Kosten je Packung, bei 1 000 nur 20 €. Der variable Anteil bleibt 30 € je Packung.

*Eigene Erklärhilfe:* Eine WG teilt 1 200 € Miete: zu zweit 600 €, zu viert 300 € pro Person. Das Essen pro Person wird durch das Teilen der Miete nicht automatisch billiger. Genauso sinkt $k_f$, während $k_v$ gleich bleibt.
#form[$ k_"min"=K_f/x_"max"+k_v quad k_(f,"min")=K_f/x_"max" $]
Im Modell mit $K_f>0$ und endlicher Kapazität liegen die minimalen Stückkosten *über* $k_v$. Ein mathematischer Grenzwert für unendlich große Mengen ist kein erreichbarer Betriebspunkt.
#note("Quelle sichtbar korrigiert", [In Deiner Kostentabelle steht bei 600 Packungen „63,30“. Die Rechnung ergibt $38 000/600="63,333…"$, auf Cent gerundet *63,33 €/Packung*. Der Originalscan bleibt unverändert.], fill: sand)
#bild("map-stueck", [Mindmap: vom Gesamtbetrag zum Betrag je Stück. Eigene Darstellung nach K, PDF-S. 1, und Ü 1, PDF-S. 1.], height: 46mm)
#src[M, PDF-S. 2; K, PDF-S. 1; Ü 1 mit Kostentabelle und Markierung „Gesetz der Massenproduktion“, PDF-S. 1; L15, PDF-S. 4–5; L02, PDF-S. 3–4. Grenzfall und WG: eigene Erklärung.]

== 1.4 Erlös, Gewinn und Deckungsbeitrag <a-1-4>

Ein verkauftes Stück bringt den Nettoerlös $e$. Nach Abzug seiner variablen Kosten bleibt der *Stückdeckungsbeitrag* $d b_"I"$. Er hilft, den festen Kostenblock zu bezahlen. Erst wenn der gesamte Deckungsbeitrag die Fixkosten übersteigt, ist das Betriebsergebnis positiv.
#form[$ E(x)=e x quad G(x)=E(x)-K(x) quad d b_"I"=e-k_v $]
$e,k_v,d b_"I"$: €/Stück; $E,K,G$: €/Periode. Produktion und Absatz werden in diesen Aufgaben gleichgesetzt; Nettoverkaufspreis und variable Stückkosten bleiben im jeweiligen Fall konstant.
#bild("deckungsbalken", [Ein Stück und die ganze Monatsmenge auseinanderhalten. Eigene Darstellung nach Ü 1, PDF-S. 1.], height: 55mm)

#tab(columns: (1fr, 1fr),
 th([Für die ganze Menge], [Für ein Stück, $x>0$]),
 [Erlöse $E(x)$], [Nettoverkaufspreis $e$],
 [− variable Gesamtkosten $K_v(x)$], [− variable Stückkosten $k_v$],
 [\= $D B_"I"=d b_"I" x$], [\= $d b_"I"$],
 [− fixe Gesamtkosten $K_f$], [− fixe Stückkosten $k_f=K_f/x$],
 [\= $D B_"II"=G$], [\= $d b_"II"=G/x$],
)
Die Mitschrift nennt $d b_"II"$ „GuV für ein Stück“ und $D B_"II"$ „GuV für $x$ Stück“. Gemeint ist hier der *Gewinn/Verlust*, also das Betriebsergebnis im vereinfachten Schema; „GuV“ ist in dieser Rechnung die Kurzbezeichnung Deiner Unterlagen.
#form[$ G(x)=d b_"I" x-K_f=D B_"I"-K_f=D B_"II" $]
Das ist der in der Randnotiz bezeichnete Schnellweg „Variante GBW“. Er ersetzt dieselbe Rechnung $E-K$; die Fixkosten werden dabei genau einmal abgezogen.

#note("Von Dir markiert · ★ Klausur", [Auf Ü 1 steht rot, dass man beim Ergebnis ein *Pluszeichen* ergänzen soll, damit der Gewinn erkennbar ist. Schreibe beispielsweise *$G=+4 000$ €* bzw. bei Verlust *$G=-3 000$ €*. Auch die grün umrandeten Rechenblöcke und die mehrstufige DB-Skizze sind übernommen.])

*Die mehrstufige Randnotiz:* Im einstufigen Schema werden alle Fixkosten gemeinsam abgezogen. Die mehrstufige Darstellung ordnet sie erst dem Produkt, dann der Produktgruppe und zuletzt dem Unternehmen zu. Die Bezeichnung „DB II“ hängt deshalb von der Stufe ab: Nach Abzug nur der Produktfixkosten ist sie noch nicht automatisch das gesamte Betriebsergebnis. Hier ist die kurze Einordnung aus Deinen Notizen und den alten Skripten gemeint.

*Eigene Erklärhilfe:* Stell Dir 20 000 € Fixkosten als leeren Eimer vor. Jede Packung zu 70 € bei 30 € variablen Kosten liefert 40 €. Nach 500 Packungen ist der Eimer rechnerisch gefüllt. Weitere Packungen liefern bei gleichbleibenden Bedingungen Gewinn. Das Bild erklärt die Kostendeckung; es beschreibt keinen tatsächlichen Zahlungsstrom.
#bild("map-deckung", [Mindmap: Deckungsbeitrag und Gewinn unterscheiden. Eigene Darstellung nach M, PDF-S. 2, und Ü 1, PDF-S. 1.], height: 46mm)
#note("Notation in den Quellen", [F, PDF-S. 4–5 verwendet „dB I“ und „DB I“ ohne überall klaren Stückbezug. Für den BEP teilst Du *Euro durch Euro je Stück*. Deshalb steht im Nenner der Stückdeckungsbeitrag, nicht der gesamte Monats-DB.], fill: sand)
#src[M, PDF-S. 1–2; K, PDF-S. 1; Ü 1, PDF-S. 1, grün umrandete Randrechnungen und rote Notiz; F, PDF-S. 4–5; L15, PDF-S. 5–6; L02, PDF-S. 5. Eimer und begriffliche Präzisierung: eigene Erklärung.]

== 1.5 Break-Even-Point und Beschäftigungsgrad <a-1-5>

Die *Gewinnschwelle* liegt dort, wo die Erlöse gerade alle Kosten decken. Bei einem positiven Stückdeckungsbeitrag fragst Du: Wie viele solcher Beiträge brauche ich, um $K_f$ zu decken?
#form[$ E(x)=K(x) => e x=K_f+k_v x => (e-k_v)x=K_f $]
#form[$ x_"BEP"=K_f/(e-k_v)=K_f/(d b_"I") quad E_"BEP"=e x_"BEP" $]
$x_"BEP"$: Stück/Periode; $E_"BEP"$: €/Periode. Voraussetzungen: lineares Modell, gleiche Periode, konstantes $e$, $k_v$, $K_f$ und $d b_"I">0$. Für $K_f>0$ und $d b_"I"<=0$ lässt sich durch zusätzliche Produktion keine Gewinnschwelle erreichen (eigene algebraische Präzisierung).

#bild("original-bep", [Deine BEP-Skizze mit Kapazitätsgrenze; Ausschnitt K, PDF-S. 1.], height: 48mm)
Die 3 500 Stück in der Originalskizze bezeichnen die *Gewinnschwellenmenge*. Ein *Gewinnschwellenumsatz* benötigt dagegen die Einheit Euro. Die Skizze liefert ohne Preisangabe keinen numerisch gesicherten Eurobetrag.

#bild("bep-aufgabe1", [BEP für Ü 1: 500 Packungen, 35 000 € Umsatz, Kapazität 1 000 Packungen pro Monat. Eigene Darstellung nach Ü, PDF-S. 1.], height: 59mm)
*So zeichnest Du selbst:* Waagerecht steht $x$, senkrecht stehen Eurobeträge. Zeichne $K_f$ waagerecht, $K(x)$ mit Startwert $K_f$ und Steigung $k_v$, $E(x)$ durch den Ursprung mit Steigung $e$. Der Schnittpunkt liefert die theoretische BEP-Menge. Die Kapazität zeichnest Du als senkrechte Grenze ein.

#note("Fehler vermeiden · exakt und ganzzahlig", [Die exakte Schwelle von Ü 4 ist $64 000/70="914,2857…"$ Regale. Bei ganzen Stückzahlen ist *915* die kleinste Menge ohne Verlust: 914 ergeben −20 €, 915 ergeben +50 €. Du rundest nur dann nach oben, wenn die exakte Menge nicht ganzzahlig ist. Ein schon ganzzahliger Wert bleibt unverändert.], fill: sand)

=== 1.5.1 Gewinnmaximum und Sicherheitsabstand <a-1-5-1>

Bei $d b_"I">0$ erhöht jedes weitere verkaufte Stück den Gewinn um $d b_"I"$. Wenn die gesamte Kapazität abgesetzt werden kann, liegt das Gewinnmaximum dieses linearen Modells an $x_"max"$:
#form[$ G_"max"=G(x_"max")=d b_"I" x_"max"-K_f $]
Ist die Nachfrage kleiner, begrenzt sie die verkaufbare Menge. Bei $d b_"I"=0$ wächst der Gewinn durch mehr Menge nicht, bei negativem Beitrag wird er schlechter. Das sind Grenzen der Aussage „Gewinnmaximum an der Kapazität“.

#form[$ "BG"_"BEP"=x_"BEP"/x_"max" dot 100 % $]
Bei Ü 4 liegt der *theoretische* BG der Schwelle bei etwa 76,19 %. Mit der kleinsten ganzen Stückzahl ohne Verlust sind es $915/1200 dot 100 %= "76,25" %$. Beide Werte haben eine klare Bedeutung; die Rechnung muss sagen, welchen sie verwendet.

#tab(columns: (1.4fr, 1.2fr, 1fr),
 th([Änderung, sonst gleich], [Stück-DB], [BEP-Menge]),
 [$K_f$ steigt], [bleibt gleich], [steigt],
 [$k_v$ steigt], [sinkt], [steigt],
 [$e$ steigt], [steigt], [sinkt],
 [$e$ sinkt], [sinkt], [steigt],
)
Ein hoher BG an der Gewinnschwelle lässt wenig Puffer gegen einen Absatzrückgang. In Ü 4 werden bei 85 % tatsächlich 1 020 Regale verkauft: nur 105 Stück mehr als die kleinste ganze Menge ohne Verlust.
#note("Von Dir markiert", [Bei Ü 4 steht rot sinngemäß: „Gewinn zu niedrig bei solch einer hohen Auslastung“; $K_f$, $k_v$ und $e$ prüfen. Die Rechnung liefert +7 400 €. Ob dieser Gewinn wirtschaftlich genügt, braucht zusätzlich ein Ziel; die Randnotiz ist ein Anlass zur Prüfung, kein allgemeiner Grenzwert.])
#bild("map-bep", [Mindmap: Schwelle, Rundung und Kapazität zusammen denken. Eigene Darstellung nach K, PDF-S. 1–2, und Ü, PDF-S. 1–2.], height: 46mm)
#src[K, PDF-S. 1–2; M, PDF-S. 1–2; Ü 1 und 4, PDF-S. 1–2; F, PDF-S. 5; L15, PDF-S. 6–7 und 10. Unterscheidung exakt/ganzzahlig, Randfälle und Nachfragegrenze: eigene Präzisierung.]

== 1.6 Entscheidungen: Preissenkung und Zusatzauftrag <a-1-6>

„Mehr verkaufen“ und „mehr verdienen“ sind nicht dasselbe. Entscheidend ist, ob der zusätzliche Beitrag größer ist als das, was die Entscheidung an anderer Stelle kostet. In Ü 1 werden deshalb zwei unterschiedliche Preisentscheidungen gerechnet.

=== 1.6.1 Preis für die gesamte Menge senken <a-1-6-1>

Bei einer allgemeinen Preissenkung erhalten auch die bisherigen Käufer den niedrigeren Preis. Du verlierst auf der alten Menge Deckungsbeitrag; die größere Absatzmenge muss das erst ausgleichen.

+ Rechne mit dem neuen Nettopreis und der *lieferbaren* neuen Menge.
+ Begrenze die Menge durch Kapazität und Nachfrage.
+ Vergleiche den gesamten Gewinn vorher und nachher.

#form[$ G_"alt"=(e_"alt"-k_v)x_"alt"-K_f quad G_"neu"=(e_"neu"-k_v)x_"neu"-K_f $]
Gültigkeit hier: $K_f$ und $k_v$ bleiben bei der Entscheidung unverändert. Bei neuen Kosten oder einem Fixkostensprung gehören diese in den Vergleich.

=== 1.6.2 Einmaliger Auftrag zu anderem Preis <a-1-6-2>

Beim Zusatzauftrag bleibt der Preis der bisherigen Menge unverändert. *Freie Kapazität* bedeutet hier: Der Auftrag verdrängt keine andere Produktion. Ändern sich die Fixkosten nicht und fallen keine weiteren auftragsbedingten Kosten an, gilt:
#form[$ Delta G=(e_"Z"-k_v)x_"Z" $]
$e_"Z"$: Zusatzpreis in €/Stück; $x_"Z"$: Zusatzmenge in Stück/Periode; $Delta G$: zusätzlicher Gewinn in €/Periode. Bei $e_"Z">k_v$ steigt der Gewinn, bei Gleichheit bleibt er gleich. Der Kernbetrieb muss seine Fixkosten dafür *nicht bereits vollständig gedeckt haben*: Ein positiver zusätzlicher DB kann auch einen bestehenden Verlust verkleinern (eigene Präzisierung des alten Skripts).

#bild("entscheidungsvergleich", [Gleiche Kostenstruktur, unterschiedliche Preisentscheidungen. Eigene Darstellung nach Ü 1, PDF-S. 1.], height: 58mm)

#note("Fehler vermeiden", [Beim Zusatzauftrag nicht $K_f$ ein zweites Mal abziehen. Bei einer allgemeinen Preissenkung dagegen nicht nur die 200 neuen Packungen zum neuen Preis rechnen: In Ü 1 zahlen dann *alle 1 000 Packungen* nur 60 €.], fill: sand)

*Risiko aus Deiner Notiz:* Bisherige Kunden könnten ebenfalls den niedrigeren Preis fordern. Die Preisdifferenzierung lässt sich dann nicht halten. Würden alle 1 000 Packungen nur 35 € erlösen, wäre $G=(35-30) dot 1000-20 000=-15 000$ €. Außerdem ist die Kapazität durch den Zusatzauftrag gebunden.

=== 1.6.3 Preisuntergrenzen im verwendeten Modell <a-1-6-3>

Als *eigene ergänzende Einordnung aus den alten Skripten* gilt kurzfristig bei freier Kapazität und unveränderten Fixkosten: $e_"Z"=k_v$ deckt gerade die variablen Kosten, erst darüber wächst der Gewinn. Langfristig muss die geplante Menge auch die Fixkosten tragen: Im einfachen Einproduktmodell ist dafür $e>=k(x)$ nötig. Das ist kein Freibrief für einen dauerhaft niedrigen Preis; Menge, Zusatzkosten und Verdrängung müssen zum Modell passen.

#bild("original-gewinn", [Zusatzauftrag und Kundenrisiko in Deiner grün umrandeten Randrechnung. Ausschnitt Ü, PDF-S. 1.], height: 53mm)

#note("In eigenen Worten", [„Für den Zusatzauftrag frage ich: *Was ändert sich durch ihn?* Für die allgemeine Preissenkung frage ich: *Was verdient der ganze Betrieb danach?*“ Eigene Erklärung nach Ü 1.])
#bild("map-entscheidung", [Mindmap: Kapazität, Vergleich und Risiko. Eigene Darstellung nach Ü 1, PDF-S. 1.], height: 46mm)
#src[Ü 1 mit grün umrandeten Rechnungen und Notiz „Preisdifferenzierung“, PDF-S. 1; L15, PDF-S. 7–9; L13, PDF-S. 7–9; L02, PDF-S. 7–9. Preisuntergrenzen, Bedingungen und Verlustverkleinerung: ausdrücklich ergänzte Erklärung/Präzisierung.]

== 1.7 Kosten aus zwei Perioden bestimmen <a-1-7>

Kennst Du Menge und Gesamtkosten aus zwei Perioden, kannst Du die Steigung der Kostenlinie bestimmen. *Wenn beide Perioden dieselbe lineare Kostenstruktur haben*, stammt die Kostendifferenz nur aus der Mengendifferenz.
#form[$ k_v=(K_2-K_1)/(x_2-x_1)=(Delta K)/(Delta x) quad K_f=K_1-k_v x_1 $]
$Delta K$: €/Periode; $Delta x$: Stück/Periode; $k_v$: €/Stück. Voraussetzungen: $x_2!=x_1$, gleicher Periodenbezug, unveränderte Fixkosten und variable Stückkosten, kein Struktur- oder Fixkostensprung.

Für Oktober und November in Ü 3 gilt:
$ k_v=(800 000-700 000)/(24 000-20 000)=25 thin "€/Stück" $.
Dann $K_f=700 000-25 dot 20 000=200 000$ €/Periode.
*Probe:* $800 000-25 dot 24 000=200 000$ €; beide Perioden liefern denselben Fixkostenblock.

#bild("map-perioden", [Mindmap: Differenz, Fixkosten, Gegenprobe. Eigene Darstellung nach Ü 3, PDF-S. 2.], height: 46mm)

*Eigene Erklärhilfe aus dem alten Skript:* Eine Stromrechnung kostet bei 300 kWh 110 €, bei 400 kWh 140 €. Die Steigung ist 30 €/100 kWh = 0,30 €/kWh. Der feste Anteil ist 110 € − 0,30 €/kWh · 300 kWh = 20 €. Das Beispiel zeigt nur das lineare Modell.
#note("Selbst erklären", [Warum muss bei beiden Perioden dasselbe $K_f$ herauskommen? *Weil Du gerade annimmst, dass beide Punkte zu derselben Kostenlinie gehören.* Zwei Beobachtungen allein beweisen noch nicht, dass das Modell auch in jedem anderen Monat gilt. Eigene Präzisierung.])
#src[Ü 3 und Randrechnungen, PDF-S. 2; Foto Ü 3; L15, PDF-S. 8 und 10; L02, PDF-S. 7–9. Strombeispiel und Aussage zur Modellprüfung: eigene Erklärung.]

== 1.8 Rückwärts rechnen, Ziele setzen und Ergebnisse prüfen <a-1-8>

Bei Textaufgaben ist oft nicht der Gewinn gesucht. Nutze dieselben Beziehungen rückwärts, statt für jede Formulierung eine neue Formel auswendig zu lernen.
#tab(columns: (1.6fr, 2fr, 1.8fr),
 th([Gegeben/gesucht], [Ansatz], [Prüfung]),
 [Kosten und Verlust; Erlös gesucht], [$E=G+K$, dann $e=E/x$], [Verlust als negatives $G$ einsetzen],
 [$K,K_f,x$; $k_v$ gesucht], [$k_v=(K-K_f)/x$], [Einheit €/Stück],
 [Zielgewinn $G_"Ziel"$], [$x_"Ziel"=(K_f+G_"Ziel")/(d b_"I")$], [ganze Menge, Kapazität, Absatz],
 [Theoretischer BEP und Stück-DB], [$K_f=x_"BEP" d b_"I"$], [keine gerundete Menge als exakte Schwelle behandeln],
)
Die Zielgewinnformel folgt durch Umstellen von $G=d b_"I" x-K_f$. Gültig ist sie bei positivem Stück-DB und derselben Kostenstruktur. Die Gewinnschwelle ist der Sonderfall $G_"Ziel"=0$.

=== 1.8.1 Wenn die Gewinnschwelle unerreichbar ist <a-1-8-1>

In Ü 2 liegt der theoretische Schnittpunkt bei 5 000 Stück, die Kapazität aber bei 4 500. Das Modell liefert dann selbst bei Vollauslastung noch −3 000 €.
#bild("bep-ausserhalb", [Die Gewinnschwelle liegt rechts der Kapazitätsgrenze. Eigene Darstellung nach Ü 2, PDF-S. 2. Die Linie über 4 500 Stück ist nur rechnerisch fortgesetzt.], height: 56mm)
Mögliche Stellschrauben sind Preis erhöhen, variable Stückkosten senken, Fixkosten senken oder Kapazität ändern. Eine Kapazitätserweiterung kann neue Fixkosten verursachen; danach musst Du *beide* Änderungen zusammen prüfen.

=== 1.8.2 Ein Ansatz für jede Textaufgabe <a-1-8-2>

+ *Basis:* Sind Preise netto, Mengen und Kosten auf dieselbe Periode bezogen?
+ *Modell:* Welche Kosten sind fix, welche je Stück variabel? Gibt es neue Kosten?
+ *Ansatz:* Kosten, Erlöse und DB sauber unterscheiden; gesuchte Größe durch Umstellen bestimmen.
+ *Machbarkeit:* Passt die errechnete Menge in Kapazität und Nachfrage?
+ *Prüfung:* Einheiten, Vorzeichen, Rundung und möglichst einen zweiten Rechenweg kontrollieren.
+ *Entscheidung:* Bei „Soll der IB …?“ ein begründetes Ja/Nein mit den passenden Bedingungen und dem Risiko angeben.

#note("Anschluss an das Modul", [Die Gliederung baut nach dieser Basis statische und dynamische Investitionsverfahren sowie Controlling auf. Schon jetzt kannst Du verstehen, warum eine neue Maschine fixe und variable Kosten verändern kann. Die zusätzlichen Verfahren werden hier noch nicht vorweg erklärt.])
#src[Ü 2–4, PDF-S. 2; K, PDF-S. 2, Rückwärtsaufgaben; Gliederung, PDF-S. 1–2; L15, PDF-S. 8–10 und 21–22; L02, PDF-S. 9–10 und 15. Geordneter Lösungsablauf: eigene Zusammenführung.]

#block(breakable: false)[
*Der Zusammenhang in Kapitel 1.* Erst klärst Du Periode und Bezugsgröße. Dann zerlegst Du Kosten und bildest Kosten- und Erlösfunktion. Der Stückdeckungsbeitrag verbindet jede einzelne Einheit mit dem gesamten Gewinn. Die Gewinnschwelle zeigt die nötige Menge; Kapazität und Nachfrage zeigen, ob sie erreichbar ist. Bei Entscheidungen prüfst Du schließlich die tatsächliche Änderung und ihre Bedingungen.
#src[Zusammenführung aus M und K, jeweils PDF-S. 1–2, sowie Ü 1–4, PDF-S. 1–2. Eigene Darstellung.]

]

== Verständnisfragen und Rechenaufgaben · Kapitel 1

Erkläre zunächst ohne Vorlage. Bei Rechnungen nennst Du Modell und Periode, zeigst den Weg und prüfst das Ergebnis. Die Lösungen stehen getrennt hinter allen Aufgaben. Die folgenden Fragen bündeln auch die früheren Karteikarten und Auswahlfragen als offene Aufgaben.

1. *Begriffe:* Erkläre fixe und variable Kosten mit je zwei Beispielen aus Ü 1. Weshalb ist „je Stück“ allein noch kein Beweis für variable Kosten? (Ü, PDF-S. 1; L15, PDF-S. 11.)
2. *Mischkosten:* Was musst Du vor dem Rechnen mit ihnen tun? Erkläre es am Grundpreis einer Stromrechnung. (Ü, PDF-S. 1, Randnotiz; L15, PDF-S. 4.)
3. *Sprungfix:* Was ändert sich beim Überschreiten der Grenze in der Randzeichnung? Warum ist ein unverändertes $K_f$ über die Grenze hinweg falsch? (Ü, PDF-S. 1.)
4. *Kapazität:* Weshalb reicht „7 000 Stück“ nicht als vollständige Kapazitätsangabe? Berechne den BG für 4 900 von 7 000 Stück pro Stunde. (K, PDF-S. 1.)
5. *Stückkosten:* Warum sinkt $k(x)$ bei wachsender Menge? Kann $k$ bei positivem $K_f$ unter $k_v$ fallen? Was passiert bei $x=0$? (Ü 1, PDF-S. 1; L15, PDF-S. 4–5; Präzisierung.)
6. *Deckungsbeitrag:* Erkläre mit dem Eimerbild, was ein Stückdeckungsbeitrag ist und weshalb er noch nicht der Gewinn je Stück sein muss. (M, PDF-S. 2; L15, PDF-S. 5.)
7. *Schreibweise:* Unterscheide $d b_"I",d b_"II",D B_"I",D B_"II"$ in der einstufigen Rechnung. Nenne Einheiten und Umrechnung. (M, PDF-S. 1–2; K, PDF-S. 1.)
8. *Gewinnschwelle:* Leite $x_"BEP"$ aus $E=K$ her. Wann ist die Formel sinnvoll? Was gilt am exakten BEP für $G$ und $D B_"I"$? (M, PDF-S. 2; F, PDF-S. 5.)
9. *Gewinnmaximum:* Unter welchen Voraussetzungen liegt es an der Kapazität? Was ändert sich bei negativem Stück-DB oder fehlender Nachfrage? (K, PDF-S. 1; L15, PDF-S. 6; eigene Präzisierung.)
10. *Veränderungen:* Wie wirken höhere Fixkosten, höhere variable Stückkosten, höhere bzw. niedrigere Verkaufspreise auf den BEP? Begründe jeweils über den Stück-DB. (L15, PDF-S. 7, aus Ü abgeleitet.)
11. *Preisuntergrenzen:* Weshalb unterscheiden sich die kurz- und langfristige Grenze im einfachen Modell? Bedeutet $e_"Z"=k_v$ bereits einen zusätzlichen Gewinn? (Ergänzung aus L15, PDF-S. 8.)
12. *Zusatzauftrag:* Welche Bedingungen brauchst Du für $Delta G=(e_"Z"-k_v)x_"Z"$? Nenne das Kundenrisiko und erkläre, warum nicht nochmals alle Fixkosten abgezogen werden. (Ü 1, PDF-S. 1.)
13. *Zwei Perioden:* Erkläre den Differenzenansatz für $k_v$. Welche Voraussetzungen und welche Gegenprobe sind nötig? (Ü 3, PDF-S. 2.)
14. *Unerreichbare Schwelle:* Was bedeutet BEP > Kapazität? Nenne Stellschrauben und den Haken einer Erweiterung. (Ü 2, PDF-S. 2.)
15. *Beschäftigungsgrad:* Warum lässt ein hoher BG am BEP wenig Puffer? Unterscheide theoretische Schwelle und kleinste ganze Menge ohne Verlust. (Ü 4, PDF-S. 2; Präzisierung.)
16. *Zusammenhang:* Wie helfen Kostenfunktion und DB beim späteren Beurteilen einer neuen Maschine? Beschreibe nur die Verbindung zur bisherigen Basis. (Gliederung, PDF-S. 1; L15, PDF-S. 1 und 13.)
17. *Stufen der DB-Rechnung:* Unterscheide das ein- und mehrstufige Abziehen von Fixkosten. Warum kann „DB II“ in beiden Schemata Unterschiedliches bedeuten? (Ü, PDF-S. 1, Randnotiz; L02, PDF-S. 5 und 11.)
18. *Menge verdoppeln:* $K_f$ und $k_v$ bleiben gleich. Welche Größe halbiert sich: $K_f$, $k_f$ oder $k$? Begründe mit einer Formel. (Frühere Auswahlfrage, L15, PDF-S. 12–13, in offene Frage umgestellt.)
19. *BEP rechnen:* $K_f=50 000$ €/Monat, $k_v=20$ €/Stück, $e=45$ €/Stück. Ermittle die Gewinnschwelle und prüfe den Gewinn dort. (Frühere Auswahlfrage, L15, PDF-S. 11/13, offen umgestellt.)
20. *Netto:* Ein Preis beträgt 238 € brutto bei vorgegebenen 19 % Umsatzsteuer. Welcher Betrag gehört als $e$ in die Erlösfunktion? (L15, PDF-S. 11/13, offen umgestellt.)
21. *BG am BEP:* Die Monatskapazität beträgt 2 000 Stück, die Schwelle 1 500 Stück. Berechne und deute den BG. (L15, PDF-S. 11/13, offen umgestellt.)
22. *Kostensteigung:* Monat 1: 10 000 Stück, $K=300 000$ €; Monat 2: 12 000 Stück, $K=340 000$ €. Ermittle $k_v,K_f$ und prüfe beide Punkte. (L15, PDF-S. 12–13, offen umgestellt.)

#heading(level: 3, outlined: false)[Vertiefende Verständnisfragen und Rechenaufgaben]

23. *VL-1-Übung, K PDF-S. 2:* $k_v=7$ €/Stück, $e=10$ €/Stück, $K_f=800$ € je betrachteter Periode, Kapazität 1 300 Stück. a) Gewinnmaximum? b) Exakter BEP und kleinste ganze Menge ohne Verlust? c) Rechne wie in der Mitschrift rückwärts mit „BEP = 267“: Welches $k_v$ ergibt sich bei $e=10,K_f=800$? Welches $K_f$ bei $d b_"I"=3$? Erkläre die Rundungsabweichung.

24. *Ü 1 · Modelleisenbahn-Zubehör, PDF-S. 1:* Kapazität 1 000 Verkaufspackungen/Monat, nur Auftragsproduktion. Die Kostendaten stehen in Abschnitt 1.2. a) Ordne alle acht Kostenarten zu, bilde $K(x)$ und fülle für $x=200,400,600,800,1000$ die Spalten $K_f,K_v,K,k$. b) Gewinn bei 600 Packungen zu 70 € netto? c) BEP und Skizze mit Umsatz an der Schwelle? d) Gewinnmaximum? e) Gewinn bei 800 Packungen? f) Ausgehend von 800 Packungen: Preis allgemein auf 60 €, Nachfrage +200. Lieferbar und sinnvoll? g) Alternativ 800 Packungen zu 70 € und einmalig 200 zusätzliche zu 35 €: annehmen? Welche Gefahr?

25. *Ü 2 · Kosten und Verlust, PDF-S. 2; Foto Ü 2:* Bei 3 000 Stück entstehen 75 000 € Gesamtkosten, darunter 30 000 € fixe Kosten. Der Verlust ist 12 000 €. a) Ermittle $k_v,E,e$. b) BEP rechnerisch und grafisch? c) Beurteile die Kapazitätsgrenze von 4 500 Stück. d) Eigene vertiefende Ableitung aus L15, PDF-S. 10: Wie müssten jeweils einzeln $e$, $k_v$ oder $K_f$ geändert werden, um bei 4 500 Stück mindestens kostendeckend zu sein?

26. *Ü 3 · Oktober/November, PDF-S. 2; Foto Ü 3:* Oktober: 20 000 Stück bei $K=700 000$ €; November: 24 000 Stück bei $K=800 000$ €. $e=40$ €/Stück. a) $k_v,K_v,K_f,k_f$ in beiden Monaten? b) Betriebserfolg bei vollständigem Absatz? c) BEP rechnerisch und grafisch? d) Welchen Einfluss hat eine Erhöhung von $k_v$ auf 30 €/Stück? e) Wieder mit $k_v=25$: Eine Erweiterung erhöht $K_f$ um 40 000 €. Welche Gesamt- und Zusatzmenge hält den Novembergewinn?

27. *Ü 4 · Holzregale, PDF-S. 2; Foto Ü 4:* Kapazität 1 200 Regale/Monat; $K_f=64 000$ €/Monat; $k_v=110$ €/Regal; Preis 214,20 € brutto, für diese Aufgabe 19 % Umsatzsteuer. a) BEP? b) BG der Gewinnschwelle, theoretisch und mit ganzen Regalen? c) Betriebsergebnis bei 85 % BG? Ordne Deine rote Randbemerkung zur hohen Auslastung ein.

28. *A13 · KLR, Aufgabe 3, erster Fall, PDF-S. 3:* Kostenstelle Dreherei, Kapazität 10 000 Einheiten je Monat. Mai: 70 % BG, $K=466 000$ €; Juni: 80 %, $K=504 000$ €. Für Juli sind 85 % geplant. Bestimme Juli-Menge, proportionale variable Stückkosten, Fixkosten, variable Gesamtkosten und Gesamtkosten. Nur der KLR-Teil wird verwendet.

29. *A13 · KLR, zweiter Fall, PDF-S. 3–4, Teile a–b:* Ein Einproduktbetrieb stellt Kunststoffbehälter für Gartenabfälle her. Preis 200 €/Stück, Fertigungsmaterial 60 €/Stück, Fertigungslohn 20 €/Stück, jährliche Fixkosten 900 000 €. a) Jährliche BEP-Menge und BEP-Umsatz? b) Betriebsergebnis bei 10 000 Stück? Der Teil zur Umsatzrentabilität bleibt dem späteren Kennzahlenstoff vorbehalten.

30. *A14 · Aufgabe I.1, PDF-S. 2, KLR-Auszug:* Die gesamten Deckungsbeiträge der Produkte A–E betragen 4 200 €, 6 460 €, 14 490 €, 6 608 € und 20 085 € im Monat. Das Betriebsergebnis ist +6 350 €. Welche monatlichen Fixkosten hat der Betrieb? Die weiteren Teile zur Engpassplanung sind hier nicht enthalten.

31. *A18 · Aufgabe I, PDF-S. 1, DB-Übertragung:* Drei Varianten einer Dienstkleidung werden vollständig verkauft. Die Werte stehen unten. a) Berechne mit den gegebenen Vollkosten je Stück die Ergebnisse je Variante und insgesamt. Welche Variante sieht zunächst ungünstig aus? b) Variable Stückkosten sind 35,70 €, 66,30 €, 102,00 €; gemeinsame Fixkosten 240 720 €. Bestimme die drei DB und den Gesamtgewinn. c) Beurteile eine Streichung von Hansa bei unveränderten gemeinsamen Fixkosten. Die Bedingungen der Entscheidung sind ausdrücklich Teil dieser Übertragung.
#tab(columns: (1.3fr, 1fr, 1fr, 1fr),
 th([Variante], [Easy], [Hansa], [Pazifik]),
 [Menge in Stück], [2 500], [3 000], [3 750],
 [Preis €/Stück], [61,20], [112,20], [142,80],
 [Vollkosten €/Stück], [43,86], [114,24], [122,40],
)

Die Aufgaben 32–42 stammen aus den älteren Lernskripten (*L15, PDF-S. 14–16*). Ihre Zahlen sind eigene Ergänzungen der früheren KI. Sie bleiben als offene Rechenaufgaben erhalten; die bisherigen Hilfestufen entfallen. Ü 10 wird ausschließlich als Vergleich zweier bereits vorgegebener linearer KLR-Funktionen verwendet.

32. *Alte Ü 1 · BEP und BG:* $K_f=48 000$ €/Monat, $k_v=18$ €/Stück, $e=30$ €/Stück, Kapazität 5 000 Stück/Monat. Ermittle Stück-DB, BEP und BG am BEP.
33. *Alte Ü 2 · Zwei Perioden:* Januar 8 000 Stück, $K=164 000$ €; Februar 10 000 Stück, $K=190 000$ €. Ermittle $k_v,K_f$ und prüfe mit Februar.
34. *Alte Ü 3 · Zusatzauftrag:* 700 Stück zu 50 €, $k_v=32$ €, $K_f=9 000$ €, Kapazität 900 Stück je Periode. Ein Kunde will einmalig 150 Stück zu 38 €. Prüfe Kapazität, Ergebnisänderung, Entscheidung und Risiko.
35. *Alte Ü 4 · Preis aus Verlust:* Bei 2 500 Stück entstehen 95 000 € Gesamtkosten, darunter 40 000 € Fixkosten. Verlust 7 500 €, Kapazität 3 000 Stück. Bestimme $k_v,e$, BEP und eine begründete Entscheidung.
36. *Alte Ü 5 · Preissenkung:* $K_f=30 000$ €, $k_v=20$ €, $e=50$ €, Absatz 1 200 Stück, Kapazität 1 500 Stück je Periode. Bei 45 € wären 1 600 Stück nachgefragt. Ist die Senkung sinnvoll?
37. *Alte Ü 6 · Zielgewinn:* $K_f=72 000$ €, $e=60$ €, $k_v=42$ €. Welche Stückzahl bringt mindestens 18 000 € Gewinn im unveränderten Modell? Eine Kapazität ist hier nicht vorgegeben.
38. *Alte Ü 7 / L02 Aufgabe A · Fahrradrahmen:* Kapazität 2 000 Stück/Monat, $K_f=90 000$ €/Monat, $k_v=75$ €/Stück, Preis 154,70 € brutto bei 19 % Umsatzsteuer. Aktuell 1 800 Stück. a) Netto, Stück-DB und BEP? b) BG an der ganzen Schwellenmenge? c) aktueller Gewinn? d) Einmalig 150 Rahmen zu 85 € netto zusätzlich: annehmen und Risiko? e) Alternativ allgemein 120 € netto, Nachfrage +300: sinnvoll?
39. *Alte Ü 8 / L02 Aufgabe B · Zwei Monate:* März 5 000 Stück und $K=180 000$ €; April 6 500 Stück und $K=210 000$ €. $e=36$ € netto. a) $k_v,K_f$? b) Gewinne und Besonderheit im März? c) Menge für 40 000 € Gewinn?
40. *Alte Ü 9 / L13 Rechenaufgabe 19 · Preis gesucht:* $K_f=120 000$ €, $k_v=45$ €, Kapazität 5 000 Stück je Periode. a) Preis, damit 4 000 Stück exakt der BEP sind? b) Preis für 40 000 € Gewinn bei 4 000 Stück? c) Mit Preis b): BEP und BG?
41. *Alte Ü 10 / L13 Rechenaufgabe 20 · Zwei lineare Kostenfunktionen:* Fall 1: $K_1(x)=20 000+12x$; Fall 2: $K_2(x)=35 000+7x$, Kosten jeweils €/Periode, $x$ Stück/Periode. Bei welcher Menge sind die Kosten gleich? Welcher Fall ist bei 2 000 bzw. 4 000 Stück günstiger? Dies ist eine algebraische KLR-Übertragung, noch keine Herleitung eines Investitionsverfahrens.
42. *Alte Ü 11 · Gesamtfall:* März 4 000 Stück, $K=150 000$ €; April 5 000 Stück, $K=175 000$ €. Verkaufspreis 47,60 € brutto bei 19 % Umsatzsteuer, Kapazität 6 000 Stück/Monat. a) $k_v,K_f$? b) BEP und BG? c) Aprilgewinn? d) Zusätzlich zu 5 000 Stück ein Auftrag über 800 zu 30 € netto: annehmen? e) Sind 50 000 € Monatsgewinn möglich? f) Wie werden die Abschreibungen in diesem mengenunabhängigen Modell eingeordnet?

#pagebreak()
== Lösungen Kapitel 1

=== Lösungen 1–22 · Erklären und kurz rechnen

#block(breakable: false)[
1. *Fix/variabel:* Miete und Gehälter sind in Ü 1 monatlich fix; RHB-Stoffe und Akkordlohn werden je Packung verursacht. Aber $k_f=K_f/x$ ist ebenfalls ein Stückbetrag, obwohl sein Gesamtbetrag fix ist. Der Kostenanfall, nicht die Schreibweise allein, entscheidet.
#nachschlagen[Lernskript, #stelle(<a-1-2>)#text[;] #stelle(<a-1-3>).]
]

#block(breakable: false)[
2. *Mischkosten:* In einen festen Grundbetrag und einen mengenabhängigen Anteil zerlegen. Beim Strombeispiel ist der Grundpreis fix, der Verbrauchspreis je kWh variabel. Erst danach eine lineare Kostenfunktion aufstellen.
#nachschlagen[Lernskript, #stelle(<a-1-2>)#text[;] #stelle(<a-1-7>).]
]

#block(breakable: false)[
3. *Sprungfix:* Der feste Kostenblock steigt an einer Mengengrenze. Mehr Menge verteilt dann nicht nur dieselben Fixkosten; es kommen neue hinzu. Deshalb musst Du für den neuen Bereich ein neues $K_f$ ansetzen.
#nachschlagen[Lernskript, #stelle(<a-1-2>).]
]

#block(breakable: false)[
4. *Kapazität:* Der Zeitbezug bestimmt das Leistungsvermögen. $4900/7000 dot 100 %=70 %$; 30 % sind in dieser Stunde ungenutzt. Eine Monatsmenge darfst Du nicht direkt durch eine Stundenkapazität teilen.
#nachschlagen[Lernskript, #stelle(<a-1-1>).]
]

#block(breakable: false)[
5. *Stückkosten:* Bei positivem $K_f$ sinkt $K_f/x$ mit wachsendem $x$. $k_v$ bleibt unverändert. Daher liegt $k=K_f/x+k_v$ bei endlichem $x>0$ über $k_v$. Bei $x=0$ ist die Division nicht definiert; $K(0)=K_f$ bleibt sinnvoll.
#nachschlagen[Lernskript, #stelle(<a-1-3>).]
]

#block(breakable: false)[
6. *Stück-DB:* Der Eimer wird mit $e-k_v$ je Stück gefüllt. Dieser Betrag muss zuerst die Fixkosten mittragen. Gewinn je Stück ist erst $d b_"II"=d b_"I"-K_f/x$; er hängt von der Menge ab.
#nachschlagen[Lernskript, #stelle(<a-1-4>).]
]

#block(breakable: false)[
7. *Stück und gesamt:* $d b_"I"=e-k_v$ und $d b_"II"=d b_"I"-k_f$ sind €/Stück. $D B_"I"=d b_"I" x$ und im einstufigen Schema $D B_"II"=D B_"I"-K_f=G$ sind €/Periode. Multipliziere Stückwerte mit der zugehörigen Menge; umgekehrt teile durch $x>0$.
#nachschlagen[Lernskript, #stelle(<a-1-4>).]
]

#block(breakable: false)[
8. *Herleitung:* $e x=K_f+k_v x => (e-k_v)x=K_f => x=K_f/(e-k_v)$. Für positive Fixkosten wird ein positiver Stück-DB benötigt. Am exakten Schnittpunkt ist $G=0$ und $D B_"I"=K_f$. Bei einer aufgerundeten ganzen Menge kann bereits ein kleiner Gewinn entstehen.
#nachschlagen[Lernskript, #stelle(<a-1-5>).]
]

#block(breakable: false)[
9. *Maximum:* Bei positivem, konstantem Stück-DB und unveränderten Fixkosten wächst $G$ linear mit der verkauften Menge. Volle Kapazität ist nur dann das Maximum, wenn sie abgesetzt werden kann. Bei negativem DB verschlechtert mehr Menge das Ergebnis; geringere Nachfrage begrenzt den Absatz früher.
#nachschlagen[Lernskript, #stelle(<a-1-5-1>).]
]

#block(breakable: false)[
10. *BEP-Wirkung:* Höhere $K_f$: mehr Beiträge erforderlich, BEP steigt. Höhere $k_v$: weniger Beitrag je Stück, BEP steigt. Höheres $e$: mehr Beitrag, BEP sinkt. Niedrigeres $e$: weniger Beitrag, BEP steigt. Das gilt bei sonst gleichen Werten und weiterhin positivem Stück-DB.
#nachschlagen[Lernskript, #stelle(<a-1-5-1>).]
]

#block(breakable: false)[
11. *Preisgrenzen:* Kurzfristig sind bei den genannten Bedingungen nur die durch den Auftrag entstehenden Kosten zu decken. Bei $e_"Z"=k_v$ ist $Delta G=0$, kein zusätzlicher Gewinn. Langfristig muss die geplante Menge auch $K_f$ decken; im einfachen Modell daher $e>=k(x)$.
#nachschlagen[Lernskript, #stelle(<a-1-6-2>)#text[;] #stelle(<a-1-6-3>).]
]

#block(breakable: false)[
12. *Zusatzauftrag:* Freie Kapazität, keine Verdrängung, unveränderte Fixkosten und keine unberücksichtigten Zusatzkosten; der bisherige Verkaufspreis bleibt bestehen. $K_f$ fällt in beiden Alternativen ohnehin an und hebt sich im Differenzvergleich auf. Risiko: Bisherige Kunden fordern den niedrigeren Preis; außerdem ist Kapazität gebunden.
#nachschlagen[Lernskript, #stelle(<a-1-6-2>).]
]

#block(breakable: false)[
13. *Zwei Perioden:* $(Delta K)/(Delta x)$ ist die Steigung der angenommenen gemeinsamen Kostenlinie. Vorausgesetzt sind derselbe Zeitraum, dasselbe $K_f$ und $k_v$ sowie verschiedene Mengen. Mit $K_f=K-k_v x$ müssen beide Perioden denselben festen Anteil liefern.
#nachschlagen[Lernskript, #stelle(<a-1-7>).]
]

#block(breakable: false)[
14. *BEP über Kapazität:* Bei positivem Stück-DB reicht selbst Vollauslastung nicht zur Kostendeckung. Preis erhöhen, variable Kosten oder Fixkosten senken kann die Schwelle senken. Erweiterung erhöht die mögliche Menge, kann aber auch neue Fixkosten erzeugen; beide Wirkungen zusammen prüfen.
#nachschlagen[Lernskript, #stelle(<a-1-8-1>).]
]

#block(breakable: false)[
15. *Puffer:* Ein Absatzrückgang erreicht die Verlustzone schneller, wenn der BEP nahe an der Kapazität liegt. Die theoretische Schwelle kann zwischen zwei ganzen Stückzahlen liegen. Die kleinste ganze Menge ohne Verlust ist dann die nächsthöhere Zahl; ihren BG ausdrücklich als ganzzahligen Fall kennzeichnen.
#nachschlagen[Lernskript, #stelle(<a-1-5>)#text[;] #stelle(<a-1-5-1>).]
]

#block(breakable: false)[
16. *Verbindung:* Eine neue Maschine kann den festen Kostenblock, die variablen Stückkosten und die mögliche Menge verändern. Die KLR macht diese Folgen vergleichbar. Die Gliederung baut darauf später Kosten-, Gewinn-, Rentabilitäts- und Amortisationsrechnung auf; deren zusätzliche Regeln sind noch nicht Gegenstand dieses Skripts.
#nachschlagen[Lernskript, #stelle(<a-1-8-2>).]
]

#block(breakable: false)[
17. *Ein-/mehrstufig:* Einstufig wird der gesamte Fixkostenblock vom gesamten DB abgezogen. Mehrstufig werden nacheinander Produkt-, Produktgruppen- und Unternehmensfixkosten abgezogen. Ein DB nach Produktfixkosten ist deshalb noch kein endgültiger Unternehmensgewinn. Die jeweilige Stufe muss benannt sein.
#nachschlagen[Lernskript, #stelle(<a-1-4>).]
]

#block(breakable: false)[
18. *Verdoppelung:* $k_f(2x)=K_f/(2x)=k_f(x)/2$; $K_f$ bleibt gleich. Insgesamt $k(2x)=k_f(x)/2+k_v$: Die gesamten Stückkosten halbieren sich bei positivem $k_v$ gerade nicht. Der variable Anteil bleibt bestehen.
#nachschlagen[Lernskript, #stelle(<a-1-3>).]
]

#block(breakable: false)[
19. *BEP:* $d b_"I"=45-20=25$ €/Stück. $x_"BEP"=50 000/25=2000$ Stück/Monat. Probe: $E=90 000$ €, $K=50 000+40 000=90 000$ €, also *$G=0$ €*. Eine Aussage zur Erreichbarkeit braucht zusätzlich die Kapazität.
#nachschlagen[Lernskript, #stelle(<a-1-5>).]
]

#block(breakable: false)[
20. *Netto:* $238/"1,19"=200$ €. Damit ist *$e=200$ €/Stück* in die Erlösfunktion einzusetzen. Prüfung: $200 dot "1,19"=238$ € brutto.
#nachschlagen[Lernskript, #stelle(<a-1-1>).]
]

#block(breakable: false)[
21. *BG:* $1500/2000 dot 100 %=75 %$. Drei Viertel der Monatskapazität sind an der Schwelle gebunden; die Kapazität liegt 500 Stück darüber. Das ist Kapazitätsspielraum, keine Zusage über die tatsächliche Nachfrage.
#nachschlagen[Lernskript, #stelle(<a-1-5-1>).]
]

#block(breakable: false)[
22. *Kostensteigung:* $k_v=(340 000-300 000)/(12 000-10 000)=20$ €/Stück. $K_f=300 000-20 dot 10 000=100 000$ €/Monat. Probe: $100 000+20 dot 12 000=340 000$ € und $100 000+20 dot 10 000=300 000$ €. Beide Punkte passen.
#nachschlagen[Lernskript, #stelle(<a-1-7>).]
]

#pagebreak()
=== Lösungen 23–31 · Vorlesung und Altklausuren

#heading(level: 3, outlined: false)[23 · VL 1: vorwärts und rückwärts]

*Modell:* Gleiche betrachtete Periode, lineare Kosten, vollständiger Absatz bis maximal 1 300 Stück; $d b_"I"=10-7=3$ €/Stück.

+ *Gewinnmaximum:* $E(1300)=13 000$ €, $K(1300)=800+7 dot 1300=9900$ €. Damit *$G_"max"=+3100$ €*.
+ *Gewinnschwelle:* $x_"BEP"=800/3="266,666…"$ Stück. Kleinste ganze Menge ohne Verlust: *267 Stück*. Probe: $2670-2669=+1$ €; bei 266 Stück ist $G=-2$ €.
+ *Rückwärts mit 267:* Wird 267 als *exakte* Schwelle behandelt, folgt $k_v=10-800/267 approx "7,00375"$ €/Stück. Bei $d b_"I"=3$ folgt stattdessen $K_f=267 dot 3=801$ €. Die ursprünglichen Werte 7 € und 800 € erhältst Du exakt nur mit $800/3$ als Schwelle.

*Prüfung:* Die Abweichung von 1 € im Fixkostenrückschluss stammt aus der vorher aufgerundeten Menge; sie ist keine Änderung der tatsächlichen Ausgangskosten. Quelle: K, PDF-S. 2; L15, PDF-S. 9.
#nachschlagen[Lernskript, #stelle(<a-1-5>)#text[;] #stelle(<a-1-8>).]

#heading(level: 3, outlined: false)[24 · Ü 1: Modelleisenbahn-Zubehör]

*Modell:* Packungen pro Monat, Produktion gleich Absatz, Nettopreise; $K_f$ und $k_v$ bleiben bis 1 000 Packungen unverändert. Die beiden Preisentscheidungen sind Alternativen.

+ *Kosten aufteilen:* $K_f=9000+1600+400+3000+6000=20 000$ €/Monat. $k_v=6+22+2=30$ €/Packung. Somit $K(x)=20 000+30x$; die vollständige Kostentabelle steht in Abschnitt 1.3. Die dortigen fünf Zeilen sind die Lösung zu a).
+ *600 Packungen:* $E=70 dot 600=42 000$ €, $K=20 000+30 dot 600=38 000$ €. *$G=+4000$ €*. Gegenprobe: $(70-30) dot 600-20 000=+4000$ €.
+ *BEP und Skizze:* $d b_"I"=40$ €/Packung, $x_"BEP"=20 000/40=500$ Packungen; $E_"BEP"=70 dot 500=35 000$ €. Die Zeichnung in Abschnitt 1.5 zeigt $E=70x$ und $K=20 000+30x$ mit Schnittpunkt $(500;35 000)$.
+ *Maximum:* Positiver Stück-DB und vollständiger Absatz bis Kapazität: *$G(1000)=40 dot 1000-20 000=+20 000$ €*.
+ *800 Packungen:* $E=56 000$ €, $K=44 000$ €, somit *$G=+12 000$ €*.
+ *Allgemeine Preissenkung:* Die Randrechnung geht von 800 Packungen aus; $800+200=1000$ passen genau. Neu $E=60 dot 1000=60 000$ €, $K=50 000$ €, somit *$G_"neu"=+10 000$ €*. Gegenüber +12 000 € sind das −2 000 €: *unter diesen Bedingungen nicht senken*.
+ *Zusatzauftrag:* $800+200=1000$, ebenfalls lieferbar. Erlös $800 dot 70+200 dot 35=63 000$ €, Kosten 50 000 €, also *$G_"neu"=+13 000$ €*. Zusatzbeitrag $(35-30) dot 200=+1000$ €. *Rechnerisch annehmen*, sofern die bisherigen Preise bestehen und keine weiteren Kosten entstehen. Risiko: bisherige Kunden verlangen ebenfalls 35 €; dann wäre das Gesamtergebnis bei 1 000 Packungen −15 000 €.

#note("Quelle sichtbar korrigiert", [Bei der Zusatzrechnung steht in der Mitschrift sinngemäß „$E(200)=800 dot 35=7000$“. Zum Ergebnis 7 000 € passt *$200 dot 35$*. Das Endergebnis 63 000 € Gesamterlös stimmt; der Multiplikator war verschrieben.], fill: sand)

*Prüfung:* In der Grundrechnung bei Kapazität beträgt der Abstand zwischen Erlös 70 000 € und Kosten 50 000 € genau 20 000 €. Die Zusatzrechnung verändert nur 200 Preise, die allgemeine Senkung alle 1 000. Quelle: Ü, PDF-S. 1; L15, PDF-S. 9.
#nachschlagen[Lernskript, #stelle(<a-1-2>)#text[;] #stelle(<a-1-3>)#text[;] #stelle(<a-1-4>)#text[;] #stelle(<a-1-5>)#text[;] #stelle(<a-1-6>).]

#heading(level: 3, outlined: false)[25 · Ü 2: Verlust, Preis und unerreichbarer BEP]

*Modell:* Einproduktfall und unveränderte lineare Kosten, Kapazität 4 500 Stück je betrachteter Periode. Verlust wird als $G=-12 000$ € eingesetzt.

+ *Variable Stückkosten:* $k_v=(75 000-30 000)/3000=15$ €/Stück.
+ *Erlös und Preis:* $E=G+K=-12 000+75 000=63 000$ €, $e=63 000/3000=21$ €/Stück. Probe: $63 000-75 000=-12 000$ €.
+ *Gewinnschwelle:* $x_"BEP"=30 000/(21-15)=5000$ Stück. Grafisch schneiden sich $E=21x$ und $K=30 000+15x$ bei 5 000 Stück und 105 000 €. Die Abbildung in Abschnitt 1.8.1 zeigt die rechnerische Fortsetzung außerhalb der Kapazität.
+ *Kapazität:* *$G(4500)=6 dot 4500-30 000=-3000$ €*. Mit den vorhandenen Zahlen ist Gewinn nicht möglich. Preis/Kosten ändern oder eine Kapazitätsänderung einschließlich neuer Kosten untersuchen.
+ *Einzelne Änderungen zur Kostendeckung bei 4 500:* Nötiger Stück-DB $30 000/4500=20/3$ €/Stück. Bei unverändertem $k_v=15$ ist $e>=65/3 approx "21,6667"$ €/Stück nötig; auf Cent *mindestens 21,67 €*. Bei unverändertem $e=21$ ist $k_v<=43/3 approx "14,3333"$ €/Stück nötig, auf Cent *höchstens 14,33 €*. Bei unverändertem Stück-DB von 6 € dürfen *$K_f<=27 000$ €* sein.

*Prüfung:* Mit 21,67 € erzielt der Betrieb bei 4 500 Stück +15 €; die Cent-Rundung liegt auf der kostendeckenden Seite. Die Änderungen sind drei getrennte Möglichkeiten. Quelle: Ü 2, PDF-S. 2; Foto Ü 2; d) eigene Ableitung wie L15, PDF-S. 10.
#nachschlagen[Lernskript, #stelle(<a-1-5>)#text[;] #stelle(<a-1-8>)#text[;] #stelle(<a-1-8-1>).]

#heading(level: 3, outlined: false)[26 · Ü 3: Zwei Perioden und Erweiterung]

*Modell:* In beiden Ausgangsmonaten gleiches $K_f$ und $k_v$, Preis 40 €/Stück und vollständiger Absatz. Änderungen in d) und e) werden getrennt vom Ausgangsfall untersucht.

+ *Kostenlinie:* $k_v=100 000/4000=25$ €/Stück. $K_f=700 000-25 dot 20 000=200 000$ €. Gegenprobe November: $800 000-25 dot 24 000=200 000$ €.

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
#nachschlagen[Lernskript, #stelle(<a-1-7>)#text[;] #stelle(<a-1-5>)#text[;] #stelle(<a-1-8>).]

#pagebreak()
#heading(level: 3, outlined: false)[27 · Ü 4: Holzregale]

*Modell:* Monatsbetrachtung, 19 % Umsatzsteuer laut verwendeter Aufgabenlösung; lineare Kosten und vollständiger Absatz der hergestellten Regale.

+ *Netto:* $e="214,20"/"1,19"=180$ €/Regal. Stück-DB $180-110=70$ €/Regal.
+ *BEP:* $64 000/70="914,2857…"$ Regale/Monat. Kleinste ganze Menge ohne Verlust: *915 Regale/Monat*.
+ *BG:* Theoretisch $(64 000/70)/1200 dot 100 % approx "76,19" %$. Mit ganzen Regalen *$915/1200 dot 100 %="76,25" %$*.
+ *85 % Auslastung:* $x="0,85" dot 1200=1020$ Regale. Erlös $180 dot 1020=183 600$ €, Kosten $64 000+110 dot 1020=176 200$ €, also *$G=+7400$ €*. Gegenprobe $70 dot 1020-64 000=+7400$ €.

*Prüfung und Einordnung:* 914 Stück ergeben −20 €, 915 Stück +50 €. Bei 1 020 Stück beträgt der Abstand zur ganzen Schwellenmenge 105 Regale. Deine rote Notiz fordert, Preis und Kosten bei hoher Auslastung zu prüfen. Ohne vorgegebenes Gewinnziel ist „zu niedrig“ keine rechnerisch beweisbare allgemeine Bewertung. Quelle: Ü 4 und rote Notizen, PDF-S. 2; Foto Ü 4; L15, PDF-S. 10.
#nachschlagen[Lernskript, #stelle(<a-1-1>)#text[;] #stelle(<a-1-5>)#text[;] #stelle(<a-1-5-1>).]

#heading(level: 3, outlined: false)[28 · A13: Dreherei]

*Modell:* Gleiche Monatskostenstruktur von Mai bis Juli; kein Fixkostensprung. Die Kapazität von 10 000 Einheiten/Monat ist 100 %.

+ *Mengen:* Mai $x_1=7000$, Juni $x_2=8000$, Juli $x_3=8500$ Einheiten/Monat.
+ *Kostensteigung:* $k_v=(504 000-466 000)/(8000-7000)=38$ €/Einheit.
+ *Fixkosten:* $K_f=466 000-38 dot 7000=200 000$ €/Monat. Probe Juni: $504 000-38 dot 8000=200 000$ €.
+ *Juli:* $K_v=38 dot 8500=323 000$ € und *$K(8500)=200 000+323 000=523 000$ €*.

*Prüfung:* Juli liegt 500 Einheiten über Juni; Kostenanstieg $500 dot 38=19 000$ €, also $504 000+19 000=523 000$ €. Kein Erlös gegeben, daher kein Gewinn berechenbar. Quelle: A13, PDF-S. 3, erster KLR-Fall; identisch als Einzelseite 3.pdf abgelegt.
#nachschlagen[Lernskript, #stelle(<a-1-1>)#text[;] #stelle(<a-1-7>).]

#heading(level: 3, outlined: false)[29 · A13: Kunststoffbehälter]

*Modell:* Jahresbetrachtung, Material und Fertigungslohn proportional, fixe Jahreskosten konstant; vollständiger Absatz.

+ *Stück-DB:* $k_v=60+20=80$ €/Stück; $d b_"I"=200-80=120$ €/Stück.
+ *Schwelle:* *$x_"BEP"=900 000/120=7500$ Stück/Jahr*. BEP-Umsatz *$E_"BEP"=200 dot 7500=1 500 000$ €/Jahr*.
+ *10 000 Stück:* $E=2 000 000$ €, $K=900 000+80 dot 10 000=1 700 000$ €. *$G=+300 000$ €/Jahr*.

*Prüfung:* Bei 7 500 Stück sind Erlös und Kosten je 1,5 Mio. €; 2 500 weitere Stück liefern $2500 dot 120=300 000$ € Gewinn. Eine Kapazitätsangabe fehlt, daher keine gesicherte Aussage zur maximalen Menge. Quelle: A13, PDF-S. 3–4, KLR-Fall, Teile a–b; Einzelseiten 3.pdf/4.pdf.
#nachschlagen[Lernskript, #stelle(<a-1-3>)#text[;] #stelle(<a-1-4>)#text[;] #stelle(<a-1-5>).]

#heading(level: 3, outlined: false)[30 · A14 I.1: Fixkosten aus dem Gesamt-DB]

*Modell:* Die angegebenen DB sind Gesamtbeträge des Monats, keine Stückwerte. Das Betriebsergebnis entsteht nach einmaligem Abzug der gemeinsamen Fixkosten.

+ *Addieren:* $D B_"I"=4200+6460+14 490+6608+20 085=51 843$ €.
+ *Umstellen:* $G=D B_"I"-K_f => K_f=D B_"I"-G$.
+ *Ergebnis:* *$K_f=51 843-6350=45 493$ €/Monat*.

*Prüfung:* $51 843-45 493=+6350$ €. Herstellungsstunden werden für diesen Teil nicht gebraucht; relativer DB und Engpassprogramm sind spätere Teilaufgaben. Quelle: A14, PDF-S. 2, Aufgabe I.1; Einzelseite Controlling2.pdf.
#nachschlagen[Lernskript, #stelle(<a-1-4>).]

#pagebreak()
#heading(level: 3, outlined: false)[31 · A18 I: Vollkosten und Deckungsbeitrag]

*Modell:* Gegebene Absatzmengen; für den Streichungsvergleich bleiben die gemeinsamen Fixkosten unverändert, keine Verdrängung oder zusätzlichen Folgewirkungen. Das ist eine Übertragung der bisherigen DB-Logik.

+ *Vollkosten:* Je Variante $G_j=(e_j-k_j)x_j$.

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
#nachschlagen[Lernskript, #stelle(<a-1-3>)#text[;] #stelle(<a-1-4>)#text[;] #stelle(<a-1-6-2>).]

#pagebreak()
=== Lösungen 32–42 · Übernommene Zusatzübungen

Alle Zahlen stammen aus L15, PDF-S. 14–16. Lösungen und Prüfungen sind neu nachgerechnet. Bei Aufgaben ohne bezifferte Kapazität wird die erforderliche Menge genannt; ihre tatsächliche Machbarkeit folgt daraus noch nicht.

#heading(level: 3, outlined: false)[32 · Alte Ü 1]
+ Stück-DB $30-18=12$ €/Stück.
+ *BEP $48 000/12=4000$ Stück/Monat*.
+ *BG $4000/5000 dot 100 %=80 %$*.
*Prüfung:* $12 dot 4000-48 000=0$ €. 1 000 Stück Kapazität liegen über der Schwelle.
#nachschlagen[Lernskript, #stelle(<a-1-5>)#text[;] #stelle(<a-1-5-1>).]

#heading(level: 3, outlined: false)[33 · Alte Ü 2]
*Annahme:* unveränderte Kostenstruktur in beiden Monaten.
+ $k_v=(190 000-164 000)/(10 000-8000)=26 000/2000=13$ €/Stück.
+ *$K_f=164 000-13 dot 8000=60 000$ €/Monat*.
*Prüfung Februar:* $60 000+13 dot 10 000=190 000$ €. Steigung und Achsenabschnitt passen zu beiden Punkten.
#nachschlagen[Lernskript, #stelle(<a-1-7>).]

#heading(level: 3, outlined: false)[34 · Alte Ü 3]
*Annahmen:* bisheriger Preis bleibt, keine weiteren auftragsbedingten Kosten oder Verdrängung.
+ Kapazität $700+150=850<=900$: Auftrag passt.
+ *$Delta G=(38-32) dot 150=+900$ €*.
+ Ausgangsgewinn $18 dot 700-9000=3600$ €, neuer Gewinn *4 500 €*: unter den Annahmen annehmen.
*Prüfung:* Gesamterlös $700 dot 50+150 dot 38=40 700$ €, Kosten $9000+32 dot 850=36 200$ €, Differenz 4 500 €. Risiko: Stammkunden fordern den Zusatzpreis; Restkapazität nur 50 Stück.
#nachschlagen[Lernskript, #stelle(<a-1-6-2>).]

#heading(level: 3, outlined: false)[35 · Alte Ü 4]
*Modell:* lineare Kosten; Verlust $G=-7500$ €.
+ $k_v=(95 000-40 000)/2500=22$ €/Stück.
+ $E=-7500+95 000=87 500$ €; *$e=35$ €/Stück* und $d b_"I"=13$ €/Stück.
+ Exakte Schwelle $40 000/13 approx "3076,923"$; kleinste ganze Menge *3 077 Stück*, oberhalb Kapazität 3 000.
*Prüfung:* Bei Vollauslastung $13 dot 3000-40 000=-1000$ €. Daher so kein Gewinn möglich: Preis/Kosten ändern oder Erweiterung samt Kosten prüfen. Gegenprobe Ausgang: $35 dot 2500-95 000=-7500$ €.
#nachschlagen[Lernskript, #stelle(<a-1-8>)#text[;] #stelle(<a-1-8-1>).]

#heading(level: 3, outlined: false)[36 · Alte Ü 5]
*Modell:* neue Nachfrage 1 600, lieferbar höchstens 1 500; sonst unveränderte Kosten.
+ Alt $G=(50-20) dot 1200-30 000=+6000$ €.
+ Neu $G=(45-20) dot 1500-30 000=+7500$ €.
*Ergebnis: Senken erhöht hier den Gewinn um 1 500 €.* Prüfung: Neu $E=67 500$ €, $K=60 000$ €. Die nicht lieferbaren 100 Stück dürfen nicht in den Erlös eingehen. Die Nachfrageprognose ist Teil der Annahmen.
#nachschlagen[Lernskript, #stelle(<a-1-6-1>).]

#heading(level: 3, outlined: false)[37 · Alte Ü 6]
+ Stück-DB $60-42=18$ €/Stück.
+ Zielmenge $(72 000+18 000)/18=5000$ Stück.
*Ergebnis: 5 000 Stück* bringen genau den Zielgewinn. Prüfung: $18 dot 5000-72 000=18 000$ €. Kapazität und Absatz sind nicht angegeben und müssten mindestens diese Menge ermöglichen.
#nachschlagen[Lernskript, #stelle(<a-1-8>).]

#heading(level: 3, outlined: false)[38 · Alte Ü 7: Fahrradrahmen]
*Modell:* Monatswerte, 19 % Umsatzsteuer vorgegeben; Preisänderungen sind Alternativen.
+ *Netto und BEP:* $e="154,70"/"1,19"=130$ €/Stück; $d b_"I"=55$ €/Stück. $x_"BEP"=90 000/55 approx "1636,364"$; kleinste ganze Menge ohne Verlust *1 637 Rahmen*.
+ *BG:* $1637/2000 dot 100 %="81,85" %$ für ganze Stücke.
+ *Aktuell:* $55 dot 1800-90 000=+9000$ €.
+ *Zusatz:* 200 freie Plätze, 150 benötigt; *$Delta G=(85-75) dot 150=+1500$ €*. Rechnerisch annehmen, wenn bisherige Preise und Kostenbedingungen bleiben. Risiko: Preisforderung bisheriger Kunden. Neuer Gewinn +10 500 €.
+ *Allgemein 120 €:* Nachfrage $1800+300=2100$, Kapazität nur 2 000. $G=(120-75) dot 2000-90 000=0$ €; *nicht senken*, da schlechter als +9 000 €.
*Prüfung:* Bei 1 636 Rahmen ist $G=-20$ €, bei 1 637 +35 €. Die aufgerundete Schwelle und die Kapazität passen zusammen.
#nachschlagen[Lernskript, #stelle(<a-1-1>)#text[;] #stelle(<a-1-5>)#text[;] #stelle(<a-1-6>).]

#heading(level: 3, outlined: false)[39 · Alte Ü 8: Zwei Monate]
*Annahme:* gemeinsames lineares Kostenmodell.
+ $k_v=(210 000-180 000)/(6500-5000)=20$ €/Stück; *$K_f=80 000$ €/Monat*.
+ März $G=36 dot 5000-180 000=0$ €: genau der BEP. April $G=36 dot 6500-210 000=+24 000$ €.
+ Stück-DB $36-20=16$ €/Stück. Für 40 000 € Gewinn: *$x=(80 000+40 000)/16=7500$ Stück*.
*Prüfung:* Aprilkosten $80 000+20 dot 6500=210 000$ €; Zielprüfung $16 dot 7500-80 000=40 000$ €. Kapazität und Nachfrage für 7 500 fehlen.
#nachschlagen[Lernskript, #stelle(<a-1-7>)#text[;] #stelle(<a-1-8>).]

#heading(level: 3, outlined: false)[40 · Alte Ü 9: Preis gesucht]
*Modell:* 4 000 Stück werden verkauft; $K_f,k_v$ bleiben unverändert.
+ Exakter BEP bei 4 000: $d b_"I"=120 000/4000=30$ €/Stück. *$e=45+30=75$ €/Stück*.
+ Für 40 000 € Gewinn bei derselben Menge: $d b_"I"=(120 000+40 000)/4000=40$ €/Stück. *$e=85$ €/Stück*.
+ Mit 85 €: $x_"BEP"=120 000/40=3000$ Stück; *BG = 60 %*.
*Prüfung:* Bei 4 000 Stück und 85 € ist $G=40 dot 4000-120 000=40 000$ €. Die Mengen passen in die Kapazität 5 000; ob Kunden 85 € zahlen, ist die Absatzannahme des Falls.
#nachschlagen[Lernskript, #stelle(<a-1-5>)#text[;] #stelle(<a-1-8>).]

#heading(level: 3, outlined: false)[41 · Alte Ü 10: Zwei Kostenlinien]
*Modell:* Beide linearen Funktionen sind bereits gegeben und im betrachteten Mengenbereich gültig. Es wird ausschließlich deren Kostenhöhe verglichen.
+ Gleichsetzen: $20 000+12x=35 000+7x => 5x=15 000 => x=3000$ Stück.
+ Bei 2 000: $K_1=44 000$ €, $K_2=49 000$ €; *Fall 1 ist günstiger*.
+ Bei 4 000: $K_1=68 000$ €, $K_2=63 000$ €; *Fall 2 ist günstiger*.
*Prüfung:* Bei 3 000 Stück kosten beide 56 000 €. Fall 2 hat höhere Fixkosten, aber die geringere Steigung; daher wird er oberhalb des Schnittpunkts günstiger. Erlöse oder Investitionskennzahlen werden hier nicht beurteilt.
#nachschlagen[Lernskript, #stelle(<a-1-3>)#text[;] #stelle(<a-1-5>) zum Gleichsetzen von Geraden.]

#heading(level: 3, outlined: false)[42 · Alte Ü 11: Gesamtfall]
*Modell:* Gleiche Kostenstruktur beider Monate; 19 % Umsatzsteuer; Zusatzauftrag ohne Verdrängung, neue Fixkosten oder sonstige Zusatzkosten.
+ *Kosten:* $k_v=25 000/1000=25$ €/Stück, $K_f=150 000-25 dot 4000=50 000$ €/Monat.
+ *Preis und Schwelle:* $e="47,60"/"1,19"=40$ €/Stück, $d b_"I"=15$ €/Stück. $x_"BEP"=50 000/15 approx "3333,333"$; *3 334 Stück* als kleinste ganze Menge ohne Verlust. BG dieser Menge $3334/6000 dot 100 % approx "55,57" %$.
+ *April:* $G=15 dot 5000-50 000=+25 000$ €.
+ *Zusatz:* $5000+800=5800<=6000$. *$Delta G=(30-25) dot 800=+4000$ €*, neuer Gewinn +29 000 €. Rechnerisch annehmen; Risiko der Preisdifferenzierung und verbleibende Kapazität 200 Stück beachten.
+ *Ziel:* $(50 000+50 000)/15 approx "6666,667"$, also 6 667 Stück erforderlich, mehr als 6 000 möglich. *50 000 € sind unter diesen Bedingungen nicht erreichbar*; maximal $15 dot 6000-50 000=40 000$ €.
+ *Abschreibungen:* In diesem einfachen mengenunabhängigen Ansatz sind sie fix. Daraus folgt keine allgemeine Aussage über jede Abschreibungsmethode.
*Prüfung:* Aprilkosten $50 000+25 dot 5000=175 000$ €; 3 333 Stück ergeben −5 €, 3 334 +10 €. Die Zusatz- und Zielrechnungen haben jeweils einen eigenen klaren Kapazitätstest.
#nachschlagen[Lernskript, #stelle(<a-1-2>)#text[;] #stelle(<a-1-7>)#text[;] #stelle(<a-1-5>)#text[;] #stelle(<a-1-6-2>)#text[;] #stelle(<a-1-8>).]

#pagebreak()
= Anhang
== Formelsammlung mit Voraussetzungen

Alle Beträge und Mengen beziehen sich auf dieselbe Periode. Es gilt das im Kapitel erläuterte lineare Einproduktmodell; für einen gegebenen Mehrproduktfall werden die Gesamt-DB addiert und gemeinsame Fixkosten einmal abgezogen.

#tab(columns: (1.35fr, 2fr, 2fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Kosten], [$K_v=k_v x$; $K=K_f+k_v x$], [proportionales $K_v$; gleiches $K_f,k_v$ im Bereich; €/Periode],
 [Stückkosten], [$k_f=K_f/x$; $k=K/x=k_f+k_v$], [$x>0$; €/Stück],
 [Nettopreis], [$e_"netto"=e_"brutto"/(1+s)$], [$s$ als Dezimalzahl vorgegeben; in Ü 4: 0,19],
 [Erlös], [$E(x)=e x$], [$e$ netto; vollständiger Absatz der Menge $x$],
 [Gewinn], [$G(x)=E(x)-K(x)$], [Vorzeichen; €/Periode],
 [Deckungsbeitrag I], [$d b_"I"=e-k_v$; $D B_"I"=d b_"I" x=E-K_v$], [Stück-DB €/Stück; Gesamt-DB €/Periode],
 [Ergebnis einstufig], [$D B_"II"=D B_"I"-K_f=G$; $d b_"II"=G/x=d b_"I"-k_f$], [Fixkosten einmal abziehen; Stückwert nur $x>0$],
 [Gewinn-Schnellweg], [$G=d b_"I" x-K_f$], [lineares Modell; €/Periode],
 [Exakter BEP], [$x_"BEP"=K_f/(d b_"I")$], [positiver Stück-DB; theoretische Menge],
 [Ganzzahlige Schwelle], [$x_"ganz"=ceil(x_"BEP")$], [kleinste ganze Menge mit $G>=0$; Kapazität prüfen],
 [BEP-Umsatz], [$E_"BEP"=e x_"BEP"$], [für exakten Schnittpunkt ungerundetes $x$],
 [Rückschluss Fixkosten], [$K_f=x_"BEP" d b_"I"$], [exakte Schwelle, keine vorher gerundete Menge],
 [Zielgewinn], [$x_"Ziel"=(K_f+G_"Ziel")/(d b_"I")$], [$d b_"I">0$; ganze Stücke nach oben, Absatz/Kapazität],
 [Gewinnmaximum], [$G_"max"=d b_"I" x_"max"-K_f$], [positiver Stück-DB; voller Absatz bis Kapazität],
 [Beschäftigungsgrad], [$"BG"=x/x_"max" dot 100 %$], [gleicher Zeitbezug; theoretisch/ganzzahlig benennen],
 [Zusatzauftrag], [$Delta G=(e_"Z"-k_v)x_"Z"$], [freie Kapazität, keine Verdrängung; keine weiteren Kosten],
 [Zwei Perioden], [$k_v=(K_2-K_1)/(x_2-x_1)$], [$x_2!=x_1$; gleiche lineare Kostenstruktur],
 [Fixkosten ermitteln], [$K_f=K-k_v x$], [Gegenprobe mit zweiter Periode],
 [Variable Stückkosten], [$k_v=(K-K_f)/x$], [$x>0$; €/Stück],
 [Erlös aus Ergebnis], [$E=G+K quad e=E/x$], [Verlust negativ; für Preis $x>0$],
)
#src[M und K, jeweils PDF-S. 1–2; Ü 1–4, PDF-S. 1–2; F, PDF-S. 5; L15, PDF-S. 19 und L02, PDF-S. 15. Zusammenstellung, Zielgewinn-Umstellung und Gültigkeitspräzisierungen: eigene Darstellung.]

#note("Wichtige Zahlen", [*Ü 1:* $K_f=20 000$ €/Monat, $k_v=30$ €/Packung, $e=70$ €/Packung → Stück-DB 40 €, BEP 500 Packungen, $G(800)=+12 000$ €. *Ü 4:* 214,20 € brutto / 1,19 = 180 € netto; Stück-DB 70 €; exakte Schwelle 914,2857… Regale, kleinste ganze Menge 915. *Prozent:* 85 % = 0,85. Zahlen sind Aufgabenwerte, keine allgemeinen Betriebskennzahlen.])
#src[Ü 1 und 4, PDF-S. 1–2; Foto Ü 4; Werte nachgerechnet.]
