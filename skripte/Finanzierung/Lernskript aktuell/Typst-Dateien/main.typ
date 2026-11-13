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
  #text(size: 8pt, fill: muted)[Feynman-Lernskript · Stand 13.11.2026]
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
  "zinsstruktur-folie": "abbildungen/zinsstruktur-folie.svg",
  "buergschaft-folie": "abbildungen/buergschaft-folie.svg",
  "annuitaet-folie": "abbildungen/annuitaet-folie.svg",
  "bewertungsmethoden-folie": "abbildungen/bewertungsmethoden-folie.svg",
  "wacc-folie": "abbildungen/wacc-folie.svg",
  "map-refinanzierung": "abbildungen/map-refinanzierung.svg",
  "map-sicherheiten": "abbildungen/map-sicherheiten.svg",
  "map-kurzfristig": "abbildungen/map-kurzfristig.svg",
  "map-leasing": "abbildungen/map-leasing.svg",
  "map-anleihen": "abbildungen/map-anleihen.svg",
  "map-selbstfinanzierung": "abbildungen/map-selbstfinanzierung.svg",
  "map-kapitalerhoehung": "abbildungen/map-kapitalerhoehung.svg",
  "map-bewertung": "abbildungen/map-bewertung.svg",
  "map-aktien": "abbildungen/map-aktien.svg",
  "map-working-capital": "abbildungen/map-working-capital.svg",
  "map-finanzkontrolle": "abbildungen/map-finanzkontrolle.svg",
  "map-glaeubigerrisiko": "abbildungen/map-glaeubigerrisiko.svg",
  "map-bonitaet": "abbildungen/map-bonitaet.svg",
  "map-rating": "abbildungen/map-rating.svg",
  "map-kreditvertrag": "abbildungen/map-kreditvertrag.svg",
  "map-zinszeit": "abbildungen/map-zinszeit.svg",
  "map-darlehensrecht": "abbildungen/map-darlehensrecht.svg",
  "map-vorfaelligkeit": "abbildungen/map-vorfaelligkeit.svg",
  "map-tilgung": "abbildungen/map-tilgung.svg",
  "kapitalbindung-zeit": "abbildungen/kapitalbindung-zeit.svg",
  "krisen-kette": "abbildungen/krisen-kette.svg",
  "anleihekauf-schema": "abbildungen/anleihekauf-schema.svg",
  "zinsfaktoren": "abbildungen/zinsfaktoren.svg",
  "krise-staat-historisch": "abbildungen/krise-staat-historisch.svg",
  "krise-geldpolitik-historisch": "abbildungen/krise-geldpolitik-historisch.svg",
  "krise-konjunktur-historisch": "abbildungen/krise-konjunktur-historisch.svg",

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
  "zinsstruktur-folie": (titel: "Bild lesen", body: [Links die drei Idealformen: Die obere Kurve (invers) fällt mit der Laufzeit, die untere (normal) steigt, die waagerechte Linie wäre horizontal. Rechts stehen echte Kurven der Bundesbank, waagerecht 1–10 Jahre Laufzeit, senkrecht der Zins in % p. a. Die Farben sind Stichtage: 1973 (rot) und 1990/91 (gelb, grün) waren hoch und flach bzw. invers, 2005 (violett) niedrig und normal. Das Niveau und die Form ändern sich also über die Zeit.]),
  "buergschaft-folie": (titel: "Bild lesen", body: [Drei Beteiligte: Kreditgeber oben, Bürge links unten, Schuldner rechts unten. Die Pfeile tragen die Nummern der Liste rechts. Lies sie in Reihenfolge: Verträge (1, 2), Kredit (3), Ausfall (4), Zahlung des Bürgen (5), Forderungsübergang (6) und zuletzt der Rückgriff des Bürgen auf den Schuldner (7). Der Bürge trägt also das Risiko, dass der Schuldner auch ihm nicht zahlen kann.]),
  "annuitaet-folie": (titel: "Bild lesen", body: [Waagerecht die Zeit, senkrecht Zahlungen in €. Die Säule D über der Achse ist die Auszahlung des Darlehens, die gleich langen Säulen darunter die Raten. In jeder Rate wird der obere Teil Z (Zins) kleiner und der untere Teil T (Tilgung) größer, weil die Restschuld sinkt.]),
  "bewertungsmethoden-folie": (titel: "Bild lesen", body: [Die vier Spalten sind Verfahrensfamilien, die Zeilen beantworten Wesen, Prinzip (Einzel- oder Gesamtbewertung), Varianten, Vorteile und Nachteile. Lies spaltenweise: Der Substanzwert schaut auf das vorhandene Vermögen (Vergangenheit), Ertragswert/DCF auf künftige Zahlungen, Multiplikatoren auf Vergleichsunternehmen, Realoptionen auf Handlungsspielräume.]),
  "wacc-folie": (titel: "Bild lesen", body: [Von rechts nach links lesen: Die Free Cashflows (Rechenschema rechts oben) werden mit dem WACC abgezinst (Schrägstrich = geteilt); das ergibt den Barwert, den Enterprise Value. Davon wird der Marktwert des Fremdkapitals abgezogen und der Wert des nicht betriebsnotwendigen Vermögens addiert. Ergebnis links ist der Wert des Eigenkapitals.]),
  "map-refinanzierung": (titel: "Bild lesen", body: [Oben: Zinsen je Laufzeit und das Ziel der Notenbank. Unten: zwei Instrumente, mit denen die Notenbank Liquidität und Zinsen der Banken steuert. Die Prozentangaben sind Folienwerte.]),
  "map-sicherheiten": (titel: "Bild lesen", body: [Die oberen Äste fragen, ob eine Person oder eine Sache haftet. Unten links steht die zweite, unabhängige Frage nach der Bindung an die Forderung, unten rechts die typische Verteilung auf Kreditgeber.]),
  "map-kurzfristig": (titel: "Bild lesen", body: [Jeder Ast ist eine Finanzierungsform mit ihrem Kernmerkmal. Lieferantenkredit und Kontokorrent liefern Zeit bzw. Geld, der Avalkredit nur Haftung, Factoring und Lombard machen Vermögen zu Geld.]),
  "map-leasing": (titel: "Bild lesen", body: [Drei Äste unterscheiden die Vertragsformen nach Laufzeit, Risiko und Eigentum. Der vierte Ast erinnert daran, dass die Entscheidung über Barwerte nach Steuern fällt, nicht über die Höhe der Raten.]),
  "map-anleihen": (titel: "Bild lesen", body: [Die Äste ordnen Anleihen nach ihrer Ausstattung: klassisch mit festem Zins, mit Recht auf Aktien, mit Gewinnbeteiligung oder mit besonderer Zins- bzw. Währungsregel.]),
  "map-selbstfinanzierung": (titel: "Bild lesen", body: [Oben die beiden Formen der Selbstfinanzierung aus einbehaltenem Gewinn, unten Finanzierung aus Aufwand ohne gleichzeitige Auszahlung und aus Verkauf von Vermögen. Alle vier kommen ohne neue Kapitalgeber aus.]),
  "map-kapitalerhoehung": (titel: "Bild lesen", body: [Drei Äste zeigen Formen der Kapitalerhöhung, nur die oberen beiden bringen neues Geld. Der Ast unten rechts ist die Gegenrichtung, die Herabsetzung des Kapitals.]),
  "map-bewertung": (titel: "Bild lesen", body: [Der linke obere Ast bewertet einzeln das vorhandene Vermögen, die anderen bewerten das Unternehmen als Ganzes: über abgezinste künftige Zahlungen oder über Marktpreise vergleichbarer Firmen.]),
  "map-aktien": (titel: "Bild lesen", body: [Die vier Äste ordnen Vermögen, künftigen Gewinn, Kursrelationen und Ausschüttung. Jede Rechnung braucht ihren eigenen Nenner; Nominalwert, Buchwert und Börsenkurs sind verschiedene Größen.]),
  "map-working-capital": (titel: "Bild lesen", body: [Der linke obere Ast definiert den Bilanzpuffer, die anderen zeigen Zielkonflikt und operative Zahlungsdauer. Die Höhe des Puffers ist keine unmittelbare Aussage über den Kontostand.]),
  "map-finanzkontrolle": (titel: "Bild lesen", body: [Die Äste verbinden Zahlungsplanung und Engpass mit Zielen und Datenabgrenzung. Ein Soll-Ist-Vergleich ist nur sinnvoll, wenn dieselbe Größe nach derselben Definition gemessen wird.]),
  "map-glaeubigerrisiko": (titel: "Bild lesen", body: [Der Anspruch steht fest, Information und Umwelt sind dagegen unvollständig bekannt. Folge den anderen Ästen: Schuldnerentscheidungen können den Rückzahlungspuffer nach Vertragsabschluss verändern.]),
  "map-bonitaet": (titel: "Bild lesen", body: [Jeder Ast beantwortet eine andere Frage: Vertrag schließen können, verlässlich handeln, wirtschaftlich zahlen können und im Sicherungsfall zusätzliche Werte nutzen. Keine dieser Prüfungen ersetzt die übrigen.]),
  "map-rating": (titel: "Bild lesen", body: [Oben werden die beiden Urheber einer Note unterschieden. Unten stehen deren Verwendung im Risikomodell und die Kapitalregeln der Bank. Die Note ist keine Garantie und der Bankpuffer kein Eigenkapital des Kunden.]),
  "map-kreditvertrag": (titel: "Bild lesen", body: [Links stehen Geldbeträge und Sicherheiten, rechts Zins/Zeit und Verhaltensgrenzen. Ein Vertrag muss in allen vier Richtungen gelesen werden; ein günstiger Nominalzins allein genügt nicht.]),
  "map-zinszeit": (titel: "Bild lesen", body: [Die oberen Äste bestimmen Zähler und Nenner des Jahresbruchteils. Der untere linke Ast führt zum einfachen Zins, der rechte zum Zinseszins bei wiederholter Wiederanlage.]),
  "map-darlehensrecht": (titel: "Bild lesen", body: [Die Äste trennen Vertragspflichten, ordentlichen Ausstieg, besonderen Anlass und Fristen. Die richtige Kündigungsregel hängt vom konkreten Fall ab, nicht allein vom Wunsch nach einem billigeren Kredit.]),
  "map-vorfaelligkeit": (titel: "Bild lesen", body: [Erst links oben den Anspruch prüfen. Dann bestimmen Zinsvergleich und Methode den wirtschaftlichen Nachteil; ersparte Kosten mindern ihn. Keine der vier Boxen ist eine pauschale Gebührenzusage.]),
  "map-tilgung": (titel: "Bild lesen", body: [Drei Äste zeigen unterschiedliche Zahlungsprofile. Der vierte erinnert an die tatsächliche Auszahlung: Bei gleicher Nominalschuld kann ein Disagio die wirtschaftliche Belastung erhöhen.]),
  "kapitalbindung-zeit": (titel: "Bild lesen", body: [Waagerecht verläuft die Zeit von Produktionsbeginn bis Kundenzahlung. Jeder Balken startet bei der tatsächlichen Auszahlung einer Kostenart und endet beim Geldzufluss. Längere Balken bedeuten längere Bindung, nicht automatisch höhere Gesamtkosten.]),
  "krisen-kette": (titel: "Bild lesen", body: [Die Pfeile zeigen einen möglichen wirtschaftlichen Verstärkungsmechanismus, keine Zahlenachse und keinen zwingenden Ablauf jeder Krise. Wertverluste schwächen Kapital, Misstrauen erschwert Finanzierung; Stützungsmaßnahmen setzen an mehreren Stellen an.]),
  "anleihekauf-schema": (titel: "Bild lesen", body: [Die beiden Zeilen sind getrennte Geschäfte. Oben erhält der Staat Geld für eine neue Anleihe. Unten erhält der bisherige Inhaber Geld für eine bereits existierende Anleihe; die Notenbank schafft dabei Zentralbankgeld in der Bankabwicklung.]),
  "zinsfaktoren": (titel: "Bild lesen", body: [Die obere Zeile hat eine Zinsgutschrift je Jahr, die untere zwölf mit Wiederanlage. Die Faktoren werden nacheinander multipliziert. Die Kästen zeigen eine Rechenfolge, keinen linearen Zeit-/Zinsertragsverlauf.]),
  "krise-staat-historisch": (titel: "Bild lesen", body: [Oben stehen zwei historische Ratingkarten. Unten links verknüpft eine Tabelle Noten mit Marktrenditen; unten rechts laufen TARGET-Salden über die Zeit in Milliarden Euro. Kartenfarben sind Ratingklassen, keine Zinssätze. Alle Stände gehören um 2011.]),
  "krise-geldpolitik-historisch": (titel: "Bild lesen", body: [Oben links steht die Folienübersicht Basel III; oben rechts vergleicht die Grafik Kapitalquoten und Anleiherenditen. Unten links haben Käufe und Gesamtbestand verschiedene Skalen, unten rechts stehen Konjunkturindikatoren. Die Farben unterscheiden Reihen, nicht eine gemeinsame Einheit aller Teilbilder.]),
  "krise-konjunktur-historisch": (titel: "Bild lesen", body: [Oben links zeigen Wachstum und Vertrauen den Corona-Einbruch, oben rechts Finanzmarktstress und Ausfallversicherungskosten. Unten folgen Staatsschuldenquoten und der datierte Zinsaufschlag-Vergleich. Prozentpunkte des BIP-Wachstums, Prozent des BIP, Basispunkte und Indexstände dürfen nicht vermischt werden.]),

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

*Stand 13.11.2026:* Das komplette Vorlesungsskript (Folien 1–328) ist eingearbeitet. Kapitel 1 und Kapitel 2 bis Folie 116 sind in der Vorlesung behandelt (28.10. und 04.11.). Ab Abschnitt 2.11 folgen als *Vorgriff zum Selbststudium* der Rest der Fremdfinanzierung (Sondertilgung bis Hybridanleihen und Wechselkurs), Kapitel 3 Eigen- und Selbstfinanzierung, Kapitel 4 Unternehmensbewertung und Kapitel 5 Ausblick; diese Teile sind am Anfang jeweils markiert. Aufgabe 2 der Altklausur 2017 steht jetzt bei 3.7.1 (Bezugsrecht). Alle Musterlösungen der Folien sind nachgerechnet; Fehler in den Folien sind als „Fehler in der Folie“ gekennzeichnet. Folienwidersprüche und historische Annahmen (z. B. Leitzins 0 %, Mindestreserve 2 %) bleiben sichtbar markiert.

#pagebreak()
#heading(level: 1, outlined: false)[Wegweiser]
#block[
#set text(size: 9.5pt)
#set par(leading: 0.3em, spacing: 0.15em)
#outline(title: none, depth: 2, indent: auto)
]
#v(2mm)
#text(size: 8.5pt, fill: muted)[*Quellenkürzel:* N13 = „Skript Finanzierung komplett.pdf“ vom 13.11.2026 (165 PDF-Seiten, inhaltlich gleich N12 bis auf eine Markierung auf PDF-S. 67; Folien 117–328 entsprechen N13 PDF-S. 60–165 bzw. V PDF-S. 59–164); N12 = ältere Fassung derselben Datei vom 12.11. (liegt jetzt in „Zum Löschen“); V = „Skript Finanzierung.pdf“; N1 = „1VL Finanzierung.pdf“; N2 = „VL 14.10.pdf“; N28 = „Skript Finanzierung.pdf“ im Notizenordner (VL 28.10., 17 PDF-Seiten, Folien 53–86); N04 = „Skript Finanzierung VL 4.11.pdf“ (17 PDF-Seiten, Folien 85–116 mit handschriftlicher Zusatzseite auf PDF-S. 9); M = „eigenes Skript Finanzierung.pdf“; BAF = „01VL_BAF Finanzierung.pdf“; G = „Fallstudie Glasspinnerei Straubing AG.pdf“; L15 = altes Claude-Lernskript, Stand 15.10.2026; K = „Klausur 2017.pdf“ (Fotos von Teil II, Klausurseiten 5–10; Hochschule und Prüfer sind auf den Seiten nicht erkennbar; die handschriftlichen Antworten und Korrekturen im Scan werden nicht übernommen). „PDF-S.“ zählt ab der ersten Dateiseite. V hat zwei Folien pro PDF-Seite. Buchangaben auf Folien sind Sekundärnachweise; Bücher wurden nicht verwendet. Gesetzeslinks, BGH, BIS, Ratingagenturen und EZB sind nur zur ausdrücklich markierten Begriffs-/Fehlerklärung ergänzt (Abrufdatum jeweils am Abschnitt). „Nachschlagen“ führt mit automatisch berechneter Seite in dieses Lernskript.]

#pagebreak()
#heading(level: 1, outlined: false, bookmarked: false)[Das Modul auf einen Blick] <ueberblick>

Jeder Kasten ist ein Link: Tippe ihn an, um ins Kapitel oder in den Abschnitt zu springen.

#karte((1fr,),
  chunk([Kapitel 1 · Grundlagen der Finanzplanung], [Finanzierungsformen · Liquidität · Erfolg und Zahlung · Cashflow · Finanzplan · Kennzahlen · Leverage · Fallstudie Glasspinnerei · Aktienkennzahlen · Working Capital], ziel: <a-1>),
  chunk([Kapitel 2 · Fremdfinanzierung], [Gläubigerrisiko · Bonität und Rating · Basel · Kreditvertrag · Zinsrechnung · Kündigung · Vorfälligkeit · Altklausur · Sondertilgung · Zinsstruktur · EZB · Sicherheiten · kurz- und langfristige Kredite · Leasing · Anleihen · Wechselkurs], ziel: <a-2>),
  chunk([Kapitel 3 · Eigen- und Selbstfinanzierung (Vorgriff)], [Selbstfinanzierung · Abschreibungen und Rückstellungen · Rechtsform · Aktien und Börsengang · Ausschüttung · Kapitalerhaltung · Kapitalerhöhung und Bezugsrecht · Herabsetzung · Cash Pooling · Leverage und Finanzierungsregeln], ziel: <a-3>),
  chunk([Kapitel 4 · Unternehmensbewertung (Vorgriff)], [Anlässe · Methoden · Substanz- und Ertragswert · Goodwill · Kapitalwert · Steuern und Inflation · WACC · Multiplikatoren · Entscheidungswert], ziel: <a-4>),
  chunk([Kapitel 5 · Ausblick (Vorgriff)], [Kryptowährungen · digitaler Euro · elektronische Wertpapiere · DAOs · Smart Contracts], ziel: <a-5>),
)

*Der rote Faden von der Planung zum Kreditvertrag*

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

#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([1.19 Aktienkennzahlen], [Substanz · Ertrag · Marktpreis], ziel: <a-1-19>), pfeil(),
  chunk([1.20 Kapitalbindung], [Working Capital · Dauer der Vorfinanzierung], ziel: <a-1-20>), pfeil(),
  chunk([1.21 Finanzkontrolle], [Engpass · Vergleich · Bezugsgrößen], ziel: <a-1-21>),
)

Das Modul fragt im Kern: *Ist genug Geld zum richtigen Zeitpunkt da, und woher kommt es?* Dafür trennst Du zuerst Erfolg von Zahlungen, denn Gewinn allein bezahlt keine Rechnung. Cashflow und Finanzplan zeigen, wann Geld fehlt; Kennzahlen und Leverage zeigen, wie riskant die Finanzierung ist. Die Fallstudie Glasspinnerei setzt alles zu einer Kapitalbedarfsrechnung zusammen; Working Capital und Aktienkennzahlen ergänzen die Beurteilung. Kapitel 2 verfolgt anschließend den Weg vom Kreditrisiko über Bonität und Vertrag zur Zinsrechnung und Rückführung und stellt dann die einzelnen Kreditformen vom Lieferantenkredit bis zur Wandelanleihe vor. Kapitel 3 zeigt die Alternative ohne Rückzahlungspflicht: einbehaltene Gewinne und Eigenkapital. Kapitel 4 fragt schließlich, was ein ganzes Unternehmen wert ist, und nutzt dafür wieder Zahlungsströme und Kapitalkosten.
#src[V, PDF-S. 1–3; G, PDF-S. 1 und 24; V, PDF-S. 28–58; V, PDF-S. 59–164; Zusammenführung aus Kapiteln 1–5. Eigene Darstellung.]

#pagebreak()
= Kapitel 1 · Grundlagen der Finanzplanung <a-1>

#überblick([Kapitel 1 auf einen Blick],
  idee(<a-1-2>, [Herkunft und Rechte unterscheiden.], [Woher das Kapital kommt und welche Rechte daran hängen, ordnet jede Finanzierungsform ein.]),
  idee(<a-1-4>, [Erfolg ist nicht Zahlung.], [Gewinn kann entstehen, ohne dass Geld fließt, und umgekehrt; deshalb erst trennen, dann planen.]),
  idee(<a-1-5>, [Der Cashflow zeigt die Zahlungskraft.], [Direkt oder indirekt gerechnet ergibt er dieselbe Größe, aufgeteilt in drei Bereiche.]),
  idee(<a-1-7>, [Der Finanzplan ist ein Zahlungsfahrplan.], [Er zeigt Betrag und Termin jeder Lücke, bevor sie zur Insolvenz führt.]),
  idee(<a-1-19>, [Kennzahlen und Kapitalbindung richtig lesen.], [Leverage, Aktienkennzahlen und Working Capital brauchen klare Bezugsgrößen und Zeiträume.]),
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

#pagebreak()
== 1.19 Ergänzung vom 28.10.: fundamentale Aktienkennzahlen <a-1-19>

Eine Aktie hat mehrere Bezugsgrößen: ihren *Nominalwert* als Anteil am Grundkapital, den *Börsenkurs* als Marktpreis und rechnerische Werte aus Vermögen oder künftigen Gewinnen. Diese Größen beantworten verschiedene Fragen. Ein hoher Bilanzwert ist deshalb keine Zusage für einen bestimmten Börsenkurs.

#bild("map-aktien", [Mindmap: vier Blickrichtungen auf eine Aktie. Eigene Darstellung nach V, PDF-S. 28–30 (Folien 55–59).], height: 38mm)

Sei $N$ die Anzahl gleichartiger Aktien und $"NW"$ ihr Nominalwert. Dann gilt im Modell $N="Grundkapital"/"NW"$. *Bilanzielles Eigenkapital* umfasst hier Grundkapital, Rücklagen und Jahresüberschuss; Fremdkapital gehört nicht dazu. *Stille Reserven* sind im angesetzten Bilanzwert noch nicht sichtbare Vermögensmehrwerte bzw. entsprechende Bewertungsunterschiede.

#tab(columns: (1.2fr, 2.1fr, 1.8fr),
 th([Kennzahl], [Rechnung], [Frage / Voraussetzung]),
 [Korrigierter Bilanzkurs], [$("bilanzielles EK"+"stille Reserven")/N$], [Welcher korrigierte Substanzwert entfällt auf eine Aktie? €/Aktie.],
 [Ertragswertkurs], [$("künftiger Jahresgewinn"/i)/N$], [Welcher Wert folgt aus gleichbleibendem Gewinn auf unbegrenzte Zeit? $i>0$, hier keine Wachstumsrate.],
 [Kurs-Gewinn-Verhältnis, *KGV*], [$"Börsenkurs"/"Gewinn je Aktie"$], [Wie viele Jahresgewinne je Aktie entspricht der Kurs? Gleiche Periode, positiver Gewinn.],
 [Gewinnrendite zum Kurs], [$"Gewinn je Aktie"/"Börsenkurs" times 100%$], [Gewinn relativ zum Marktpreis; Kehrwert des KGV bei passender Abgrenzung.],
 [Dividendenrendite], [$"Dividende je Aktie"/"Börsenkurs" times 100%$], [Welche laufende Ausschüttung steht zum Kaufpreis im Verhältnis? Kein vollständiger Anlageertrag.],
 [Cashflow Ratio der Folie], [$"Börsenkurs"/("Cashflow"/N)$], [Kurs zu Cashflow je Aktie; gleiche Periode. Nicht die Dividendenrendite.],
)

Der *relative Bilanzkurs* setzt korrigiertes EK zum Grundkapital ins Verhältnis. Multipliziert mit dem Nominalwert ergibt er den absoluten Bilanzkurs in €/Aktie. Das ist das vereinfachte Modell dieser Folien, keine umfassende Unternehmensbewertung.

#note("Widersprüche der Musterlösung sichtbar halten", [Folie 59 nennt *Gewinn je Aktie / Börsenkurs* „Eigenkapitalrendite“. Die Rechnung ergibt eine *Gewinnrendite zum Börsenkurs*, nicht die in Abschnitt 1.11 definierte Jahresüberschuss/EK-Rentabilität. Außerdem passen die separat vorgegebenen 0,32 €/Aktie nicht zum bilanziellen Jahresüberschuss von 30 T€ bei 400.000 Aktien. Für KGV und Gewinnrendite werden die ausdrücklich gegebenen 0,32 € verwendet; die Unvereinbarkeit wird nicht weggerundet. Eigene Prüfung.], fill: sand)

Der Daimler-Ausschnitt 2016 zeigt Umsatz, EBIT, Konzernergebnis, Cashflow, Investitionen, Ergebnis und Dividende je Aktie nebeneinander. *EBIT* ist das Ergebnis vor Zinsen und Ertragsteuern; es ist weder Konzernergebnis noch Cashflow. Eine Dividende ist die Ausschüttung und muss nicht dem gesamten Gewinn je Aktie entsprechen. Die Tabelle illustriert historische Kennzahlen, keine aktuellen Kurse.
#src[V, PDF-S. 28–30 (Folien 55–59); N28, PDF-S. 2–4. Abgrenzungen und Widerspruchsprüfung: eigene Erläuterung der vorgegebenen Formeln und Zahlen; keine Buchquelle direkt verwendet.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.20 Ergänzung vom 28.10.: Working Capital und Bindungsdauer <a-1-20>

*Working Capital (WC)* ist hier der Überschuss des Umlaufvermögens über das kurzfristige Fremdkapital. Es zeigt einen Finanzierungspuffer in der Bilanz. Das *erforderliche Betriebskapital (EBK)* der Glasspinnerei grenzt dagegen bestimmte operative Bestände ab; die Begriffe sind bei diesen unterschiedlichen Definitionen nicht austauschbar.
#form[$ "WC" = "Umlaufvermögen" - "kurzfristiges FK" $]
WC ist ein Geldbestand am Stichtag, z. B. in €. Bei einer vollständig gegliederten Bilanz lässt sich dieselbe Differenz als $"EK"+"langfristiges FK"-"Anlagevermögen"$ schreiben. Positives WC bedeutet dann, dass langfristiges Kapital auch einen Teil des UV finanziert.

#bild("map-working-capital", [Mindmap: Sicherheit, Ertrag und operative Kapitalbindung. Eigene Darstellung nach V, PDF-S. 30–32 (Folien 60–63).], height: 44mm)

*Zielkonflikt:* Ein größerer langfristig finanzierter Puffer kann die Fristenlage entspannen. Er garantiert keine Zahlung am konkreten Fälligkeitstag, weil Vorräte und Forderungen erst zu Geld werden müssen. Die Folie unterstellt günstigere kurzfristige als langfristige Zinsen: Ein Ersatz langfristiger durch kurzfristige Schulden spart unter dieser Annahme Zinsen, verkleinert aber das WC und erhöht das Anschlussfinanzierungsrisiko. Diese Zinsrelation ist eine Modellannahme, kein allgemeines Marktgesetz.

*Operativer Kapitalbedarf* entsteht dagegen während der Zeit zwischen einer Auszahlung und dem zugehörigen Kundeneingang. Wie bei einem Auftrag, für den Material und Löhne bezahlt werden müssen, bevor der Kunde zahlt: Jede Kostenart hat ihren eigenen Beginn der Geldbindung.

#bild("kapitalbindung-zeit", [Zahlungszeitpunkte bestimmen die Bindung. Eigene schematische Darstellung nach V, PDF-S. 31–32; nicht maßstäblich.], height: 55mm)

#form[$ B_j = "Kundenzahlungstag" - "Auszahlungstag der Kostenart j" $]
#form[$ "Kapitalbedarf UV" = sum_j ("zahlungswirksame Jahreskosten"_j / "Tage je Jahr") B_j $]
$B_j$ = Bindungsdauer in Tagen; Jahreskosten in €/Jahr, Tageskosten in €/Tag. So ergibt €/Tag × Tage einen Geldbetrag. Das Folienmodell setzt gleichmäßige Tätigkeit, gleichmäßige tägliche Ausgaben und ein *360-Tage-Rechenjahr* voraus. Das Rechenjahr ist aus der Folienlösung erkennbar und wird in den Aufgaben ausdrücklich angegeben.

Bei beschaffungssynchroner Fertigung beginnt die Materialbereitstellung mit der Produktion. Fertigungszeit, Fertiglagerzeit und Debitorenfrist ergeben den Kundenzahlungstag. Die *Kreditorenfrist* verschiebt die Materialzahlung nach hinten und verkürzt deren Bindung. Löhne, Herstellgemeinkosten und Verwaltungs-/Vertriebsgemeinkosten können andere Zahlungstermine haben. „Herstellkosten unmittelbar“ in Folie 61 wird durch Grafik und Tabelle als *Herstellgemeinkosten* präzisiert; Material und Lohn werden separat gerechnet.
#src[V, PDF-S. 30–32 (Folien 60–63); N28, PDF-S. 4–6; EBK-Abgrenzung: G, PDF-S. 10–12. Umformung der Bilanzidentität und Modellgrenzen: eigene Erläuterung.]
#hoch(<a-1>, [Kapitelübersicht])

== 1.21 Ergänzung vom 28.10.: Finanzkontrolle und saubere Bezugsgrößen <a-1-21>

Die Finanzplanung ist normalerweise mit Absatz, Produktion und Investition abzustimmen. Wird die *Finanzbeschaffung zum Engpass*, wird sie zum *Primärplan*: Erst der finanzierbare Rahmen bestimmt, welches Produktions- oder Investitionsprogramm möglich ist. Der knappste Bereich begrenzt damit die übrige Planung.

#bild("map-finanzkontrolle", [Mindmap: Planen, kontrollieren und die richtige Größe wählen. Eigene Darstellung nach V, PDF-S. 32–39.], height: 44mm)

#tab(columns: (1.2fr, 2.8fr),
 th([Aufgabe], [Bedeutung]),
 [Kurzfristiges Cash Management], [Zahlungsbereitschaft sichern, Fehlbeträge vermeiden, Fristen ausschöpfen und vorübergehend nicht benötigte Mittel passend anlegen.],
 [Langfristige Planung], [Rechtzeitig tragfähige Finanzierung beschaffen, Zahlungsursachen erklären und künftige Geschäftstätigkeit auf ihre Finanzierbarkeit prüfen.],
 [Kennzahlen als Vorgaben], [Ziele für Rendite, Deckung und Kapitalstruktur formulieren; Soll und Ist vergleichen.],
 [Kennzahlen als Vergleich], [Entwicklung über die Zeit, Branche und Konkurrenz untersuchen; gleiche Definitionen und vergleichbare Daten verwenden.],
)

*Statische Kontrolle* beschreibt Bestandsrelationen eines Stichtags, besonders Liquiditäts- und Deckungsgrade. Rentabilitätskennzahlen verknüpfen dagegen einen Periodenerfolg mit einer Kapitalbezugsgröße. Eine Veränderung ist ein Anlass zur Ursachenprüfung; sie beweist allein weder gutes Management noch Zahlungsunfähigkeit. Der Finanzplan ergänzt die konkreten künftigen Termine.

=== 1.21.1 Zahlung, Aufwand und Nettogeldvermögen <a-1-21-1>

#form[$ "nettomonetäres UV" = "liquide Mittel" + "kurzfristige Forderungen" - "kurzfristige Verbindlichkeiten" $]
Ein Geldbestand, kein reiner Kassenbestand. Ein Wareneinkauf auf Ziel erhöht eine Verbindlichkeit, ohne sofort Geld auszuzahlen. Seine spätere Bezahlung vermindert Kasse und Verbindlichkeit zugleich. Wer Aufwand, Beschaffung und Zahlung mischt, kann denselben Vorgang mehrfach erfassen.

#note("Unklare Folienaufgabe 69–71", [Die Tabelle führt unter anderem „Lohnaufwand“, „Barlöhne“, „Wareneinkauf auf Kredit“ und „Lieferantenrechnungen“ zugleich als Ausgaben auf. Die Musterlösung addiert sämtliche Zeilen und nennt den Saldo Liquidität. Ob und wann diese Positionen tatsächlich bezahlt werden bzw. wie Forderungen/Verbindlichkeiten fortgeschrieben werden, ist nicht vollständig angegeben. Die Lernaufgabe zeigt das *Folienergebnis* und trennt es von einer ausdrücklich angenommenen reinen Zahlungsrechnung. Ohne Zusatzangaben ist daraus kein eindeutiger Bestand des nettomonetären UV ableitbar. Eigene Quellenprüfung.], fill: sand)

=== 1.21.2 Jahresgewinn und durchschnittliches Kapital <a-1-21-2>

In der Sanitärgeschäft-Aufgabe setzt die Lösung den *Gewinnvortrag* ausdrücklich mit dem Gewinn des betrachteten Jahres gleich und unterstellt einen gleichmäßigen Gewinnanfall. Der Gewinnanteil am durchschnittlich eingesetzten Kapital beträgt deshalb die Hälfte seines Endbestands; die übrigen Kapitalpositionen bleiben im Modell konstant.
#form[$ "durchschnittliches Kapital" = ("Anfangskapital" + "Endkapital") / 2 $]
Die so bezeichnete *Netto-Gesamtkapitalrentabilität* der Folie teilt den Gewinn nach Zinsen durch durchschnittliches GK. Die Gesamtkapitalrentabilität für den Leverage-Vergleich in Abschnitt 1.12 verwendet dagegen *Gewinn vor FK-Zinsen*. Ohne Zinsangabe lässt sich diese zweite Kennzahl aus der Sanitärbilanz nicht vollständig ermitteln. Vergleichbare Namen ersetzen keine Definition.

Cashflow ergänzt den Gewinn um den Blick auf Zahlungen und nicht zahlungswirksame Vorgänge. Sein operativer Teil hilft, Innenfinanzierungskraft einzuschätzen; freie Verwendbarkeit für Tilgung, Investition und Ausschüttung muss dennoch zusammen mit fälligen Zahlungen geprüft werden. Die Folie 78 weist auf lückenhafte veröffentlichte Informationen hin. Cashflow ist deshalb hilfreich, aber kein Ersatz für Ergebnis-, Risiko- und Liquiditätsanalyse.

#note("Von Dir notiert: Klausur", [Auf N28, PDF-S. 10, steht: *„50 % Rechnen, 50 % Fragen zum Hinschreiben“*. Die Lernplattform enthält deshalb sowohl Rechenfälle mit begründeten Schritten als auch offene Erklärfragen. Das ist Deine Vorlesungsnotiz, keine hier ergänzte Punkteverteilung einer konkreten Klausur.])
#src[V, PDF-S. 32–39 (Folien 64–78); N28, PDF-S. 6–13, Klausurnotiz PDF-S. 10. Abgrenzung der widersprüchlichen Tabellen und Kennzahlen: eigene Prüfung.]
#hoch(<a-1>, [Kapitelübersicht])

*Der Zusammenhang in Kapitel 1.* Ziele bestimmen die Finanzierungsentscheidung. Herkunft und Rechte erklären die Kapitalformen. Erfolg und Zahlungen sind zu trennen, bevor Cashflow und Finanzplan aufgebaut werden. Kennzahlen und Leverage zeigen Deckung, Verlustpolster und Risiko; die Glasspinnerei führt diese Bausteine mit EBK, Steuern und Investitionen zu einer abgestimmten Kapitalbedarfsrechnung zusammen. Aktienkennzahlen trennen Marktpreis, Substanz und Ertragswert; Working Capital und Bindungsdauer verbinden Bilanzpuffer mit operativem Kapitalbedarf. Die Finanzkontrolle prüft diese Größen mit konsistenten Definitionen.
#src[V, PDF-S. 3–39; G, PDF-S. 4, 7–15 und 24. Eigene Zusammenfassung der genannten Abschnitte.]
#hoch(<a-1>, [Kapitelübersicht])


#pagebreak()
= Kapitel 2 · Fremdfinanzierung <a-2>

#überblick([Kapitel 2 auf einen Blick],
 idee(<a-2-1>, [Anspruch und Ausfall trennen.], [Feste Ansprüche bleiben von der Leistungsfähigkeit und den Entscheidungen des Schuldners abhängig.]),
 idee(<a-2-2>, [Bonität begründen.], [Rechtliche Fähigkeit, persönliche Verlässlichkeit und wirtschaftliche Tragfähigkeit beantworten verschiedene Fragen.]),
 idee(<a-2-3>, [Risiko bewerten.], [Rating und Eigenkapitalunterlegung verbinden Ausfallrisiko mit dem Kreditgeschäft der Bank.]),
 idee(<a-2-5>, [Verträge gestalten.], [Betrag, Tilgung, Zins, Laufzeit, Sicherheiten und Covenants bestimmen den Zahlungsfahrplan.]),
 idee(<a-2-6>, [Zinsen vergleichbar machen.], [Tagekonvention und Zinstermine beeinflussen die tatsächlichen Zahlungen.]),
 idee(<a-2-8>, [Rückzahlung und Ausstieg prüfen.], [Vertragspflichten, Kündigungsrecht und Vorfälligkeitsentschädigung gehören zusammen.]),
 idee(<a-2-12>, [Kreditpreis verstehen (Vorgriff).], [Zinsstruktur, Bankrefinanzierung und EZB-Leitzins bestimmen, was Kredit kostet.]),
 idee(<a-2-14>, [Sicherheiten und Kreditformen (Vorgriff).], [Bürgschaft und Grundschuld sichern; kurzfristig Lieferanten- und Kontokorrentkredit, langfristig Darlehen, Leasing und Anleihen.]),
 idee(<a-2-20>, [Anleihen mit Aktienbezug (Vorgriff).], [Options- und Wandelanleihen verbinden Fremdkapital mit Eigenkapital.]),
)
#ablauf(
 chunk([Finanzierungsbedarf und Gläubigerrisiko], [Welcher Betrag wird wann gebraucht, wodurch könnte Rückzahlung ausfallen?], ziel: <a-2-1>),
 chunk([Bonität und Rating], [Unterlagen prüfen, Risiken einschätzen, Bankkapital berücksichtigen], ziel: <a-2-2>),
 chunk([Vertrag und Zinsrechnung], [Zahlungsströme und Handlungsgrenzen vereinbaren], ziel: <a-2-5>),
 chunk([Rückführung oder vorzeitiger Ausstieg], [Tilgung, Kündigungsrecht und möglichen Schaden prüfen], ziel: <a-2-9>),
 chunk([Kreditformen im Überblick (Vorgriff)], [Sicherheiten, kurz- und langfristige Fremdfinanzierung, Leasing, Anleihen], ziel: <a-2-14>),
)
#hoch(<ueberblick>, [Modul auf einen Blick])

Kapitel 1 hat den Kapitalbedarf bestimmt. Jetzt wird daraus ein Kreditverhältnis: Der Gläubiger muss die Rückzahlung einschätzen, der Schuldner muss Bedingungen und Zahlungen verstehen. Die Abschnitte 2.1–2.9 folgen den Vorlesungen vom 28.10. und 04.11. bis Folie 116; Abschnitt 2.10 ergänzt Aufgabe 1 der Altklausur. Ab 2.11 folgt der Rest des Kapitels (Folien 117–194) als Vorgriff zum Selbststudium: Sondertilgung, Zinsstruktur, Bankrefinanzierung, Sicherheiten, kurz- und langfristige Kreditformen, Leasing, Anleihen und Wechselkurs.
#src[V, PDF-S. 40–58 (Folien 79–116); N28, PDF-S. 14–17; N04, PDF-S. 1–17; K, PDF-S. 1–2.]

== 2.1 Fremdkapital und Risiken der Gläubiger <a-2-1>

*Fremdfinanzierung* begründet Ansprüche auf vereinbarte Zahlungen. „Verträge sind einzuhalten“ (*pacta sunt servanda*) beschreibt die Pflicht; es garantiert keine tatsächliche Erfüllung. Während der Laufzeit entscheidet im Grundmodell der Schuldner über das Unternehmen, obwohl diese Entscheidungen das Risiko des Gläubigers verändern.

#bild("map-glaeubigerrisiko", [Mindmap: Anspruch, Information und Entscheidungen. Eigene Darstellung nach V, PDF-S. 40–41.], height: 44mm)

#tab(columns: (1.15fr, 2.8fr),
 th([Gliederung von Krediten], [Worauf Du achtest]),
 [Kreditgeber], [Wer stellt die Mittel bereit? Beispielsweise Bank oder anderer vertraglicher Gläubiger.],
 [Fristigkeit], [Wie lange stehen die Mittel zur Verfügung? Passt das zur Bindung des Vermögens?],
 [Besicherung], [Welche zusätzlichen Rechte sollen den Ausfallverlust begrenzen?],
 [Zahlungsanspruch], [Wie sind Auszahlungsbetrag, Zins und Tilgung ausgestaltet?],
)

Die Einleitung nennt als historische Erklärungen für die Bedeutung des FK steuerliche Vorteile, Gläubigerschutz und höhere Kosten der EK-Beschaffung. Das sind Argumente der Folie mit Quelle 2007. Weder der damalige Trend „in den letzten 50 Jahren“ noch die pauschale Aussage über steuerlich abziehbare FK-Bestände wird hier als aktuelle uneingeschränkte Regel übernommen. Für das Verständnis zählt: Finanzierungskosten und Risiko beeinflussen die Kapitalwahl.

*Informationsasymmetrie* heißt: Schuldner und Gläubiger verfügen nicht über dieselben Informationen. Die Bank prüft daher das Unternehmen einschließlich Liquidität, seine Absatzmärkte und die Gesamtwirtschaft. Risiken bleiben durch überschätzte Einzahlungen, nicht offengelegte weitere Kredite, riskante Investitionen, zusätzliche Verschuldung, Ausschüttungen und unerwartete Umweltveränderungen.

*Eigene Erklärhilfe:* Ein Betrieb nimmt nach dem ersten Kredit einen zweiten auf und schüttet zugleich liquide Mittel aus. Der erste Anspruch bleibt nominell gleich, aber künftig stehen mehr Ansprüche einem geringeren Puffer gegenüber. Deshalb genügen die ursprünglichen guten Zahlen nicht für die gesamte Laufzeit.
#src[V, PDF-S. 40–41 (Folien 80–82); N28, PDF-S. 14–15. Beispiel und historische Einordnung: eigene Erläuterung.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.2 Bonität: Fähigkeit, Würdigkeit und Sicherheiten <a-2-2>

*Bonität* beschreibt hier die Einschätzung der Schuldnerqualität. Zunächst muss ein Kreditvertrag wirksam zustande kommen können; anschließend geht es darum, ob der Schuldner zuverlässig und wirtschaftlich leistungsfähig ist. Eine werthaltige Sicherheit ergänzt diese Prüfung.

#bild("map-bonitaet", [Mindmap: drei Prüfbereiche und ihre Belege. Eigene Darstellung nach V, PDF-S. 42–43.], height: 44mm)
#tab(columns: (1.2fr, 2.8fr),
 th([Begriff], [Kernfrage und Belege]),
 [*Kreditfähigkeit*], [Kann die Person bzw. Gesellschaft rechtswirksam einen Kreditvertrag schließen? Vertretung und erforderliche Befugnisse prüfen.],
 [Persönliche *Kreditwürdigkeit*], [Wie verlässlich erscheinen Schuldner bzw. Geschäftsführung? Erfahrung, bisheriges Zahlungsverhalten und Geschäftsbeziehung.],
 [Wirtschaftliche Kreditwürdigkeit], [Lassen Vermögen, Ertrag, Cashflow und Finanzplan Zins und Tilgung erwarten? Auch Markt und Auftragslage zählen.],
 [*Kreditsicherheit*], [Welche zusätzliche Person oder welcher verwertbare Vermögenswert steht im Sicherungsfall zur Verfügung? Das beseitigt das Ausfallrisiko nicht vollständig.],
)

Relevante Unterlagen sind Handelsregisterauszug und gegebenenfalls Gesellschaftsvertrag, Jahresabschluss, Lage- und Prüfungsberichte, Liquiditäts-/Finanzpläne, Investitions- und Cashflow-Rechnungen sowie Auftragsbestand, Steuerbescheide und Forderungs-/Verbindlichkeitslisten. Die Folie nennt auch den digitalen Finanzbericht im Datenstandard XBRL. Unterlagen müssen zusammenpassen: Ein hoher Gewinn hilft wenig, wenn der Finanzplan schon eine ungedeckte Rate zeigt.

Die Informationsliste auf Folie 86 enthält außerdem persönliche Merkmale, Wohnumfeld, Werdegang, wirtschaftliche Verhältnisse und Auskünfte über das Zahlungsverhalten. Sie wird als Sammlung der Vorlesung verstanden, nicht als Aussage, dass jede dort genannte Information in jedem Kreditfall erforderlich oder zulässig ist. Das Wort „entmündigt“ auf Folie 83 wird nicht als heutige Rechtskategorie gelernt; maßgeblich ist die Fähigkeit zum wirksamen Vertragsschluss im konkreten Fall.

#note("§ 18 KWG genauer als die Folie", [Die pauschale Aussage „verpflichtet zur regelmäßigen Prüfung aller Kreditnehmer“ ist zu weit. § 18 knüpft die Offenlegung insbesondere an einen Kredit von insgesamt *über 1,5 Mio. € oder über 10 % des Kernkapitals* und enthält Ausnahmen. Für die Vorlesungslogik merken: wirtschaftliche Verhältnisse anhand belastbarer Unterlagen offenlegen und fortlaufend beurteilen; den Gesetzesbereich nicht ohne Voraussetzungen verallgemeinern. Eigener Rechtsabgleich.], fill: sand)
#src[V, PDF-S. 42–43 (Folien 83–86); N28, PDF-S. 16–17; N04, PDF-S. 1. Rechtsabgleich: #link("https://www.gesetze-im-internet.de/kredwg/__18.html")[§ 18 KWG], Abruf 05.11.2026. Begriffliche Präzisierungen: eigene Erläuterung.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.3 Rating und Eigenkapitalunterlegung der Bank <a-2-3>

Ein *Rating* verdichtet die Beurteilung des Ausfallrisikos zu einer Note. Beim *internen Rating* beurteilt die Bank ihren Kunden selbst; beim *externen Rating* bewertet eine Ratingagentur einen Schuldner bzw. Emittenten. Das Ergebnis ist eine Risikoeinschätzung und keine Rückzahlungsgarantie.

#bild("map-rating", [Mindmap: Information wird zu Risikoeinschätzung und Kapitalbedarf. Eigene Darstellung nach V, PDF-S. 43–44 und 49.], height: 44mm)

Die Folie nennt intern Klassen von A (geringes Risiko) bis D (nicht mehr vertretbar). Extern nennt sie S&P, Moody’s und Fitch sowie nationale Agenturen als Beispiele. Die Notenskalen sind nicht identisch: *AAA* ist bei S&P/Fitch die höchste Stufe, *Aaa* bei Moody’s; die pauschale Zeile „A = beste Note“ ist daher nur eine vereinfachte Richtungsangabe. *BB bzw. Ba und schlechter* gehören im üblichen Langfristrating zum spekulativen Bereich. Länder-, Branchen- und Emittentenrisiko müssen auseinandergehalten werden.

*Bankbilanz verstehen:* Der Unternehmenskredit ist eine Forderung und damit ein Aktivposten der Bank. Eigenkapital steht auf ihrer Passivseite und trägt Verluste. Die Unterlegung meint einen Kapitalpuffer der Bank, keine zusätzliche Einzahlung von Eigenkapital in das kreditnehmende Unternehmen.
#form[$ "RWA" = "Kreditbetrag" times w $]
#form[$ "EK-Unterlegung" = "Kreditbetrag" times 8% times w $]
RWA = risikogewichtete Aktiva; $w$ = Risikogewicht als Faktor, z. B. 150 % = 1,5. Alle Kapitalbeträge in derselben Währung. Das ist das *vereinfachte Basel-II-Rechenmodell der Folie*: ein Kreditrisiko, ein vorgegebenes Gewicht, keine weiteren Puffer oder Risikokategorien.
#form[$ "maximales Kreditvolumen" = "verfügbares Bank-EK" / (8% times w_"durchschnittlich") $]
Gilt nur, wenn das gesamte vorgegebene EK dafür verfügbar ist und keine andere Grenze bindet. Ein höheres Risikogewicht erhöht bei gleichem Kredit den erforderlichen Puffer und senkt bei gegebenem EK das rechnerische Kreditvolumen.

#note("Basel III: gleiche Prozentzahl, anderer Nenner?", [Folie 97 nennt 7 % hartes Kernkapital und 10,5 % Gesamtkapital. Im vereinfachten Schema sind das *4,5 % bzw. 8 % Mindestquote plus 2,5 % Kapitalerhaltungspuffer*, bezogen auf RWA. Die *Leverage Ratio von mindestens 3 %* bezieht Kernkapital dagegen auf eine nicht risikogewichtete Gesamtrisikopositionsmessgröße. Sie ist kein Verschuldungsgrad FK/EK des Unternehmens. Zusätzliche bank- und länderspezifische Anforderungen sind in dieser Folienrechnung nicht enthalten. Eigene Präzisierung.], fill: sand)

Basel III wird in der Vorlesung als Reaktion auf die Finanzkrise eingeführt: mehr und belastbareres Kapital sowie eine zusätzliche Begrenzung der Verschuldung. Unterschiedliche Rechnungslegung, etwa US GAAP und IFRS, kann die Vergleichbarkeit von Bilanzsummen und Quoten beeinflussen. Die Folien liefern die Lernmodelle, keine vollständige Bankregulierung für jeden Fall.
#src[V, PDF-S. 43–44 und 49 (Folien 85–88, 97); N28, PDF-S. 17; N04, PDF-S. 1–2 und 7. Basel-Präzisierung: #link("https://www.bis.org/bcbs/publ/d570.pdf")[Basler Ausschuss, Basel III Monitoring Report, März 2024]; #link("https://www.bis.org/publications/fsi-summary-capital-buffers-basel-iii-executive-summary")[BIS, Kapitalpuffer]; #link("https://www.bankingsupervision.europa.eu/activities/srep/leverage-ratio-pillar-2-requirement/html/index.en.html")[EZB-Bankenaufsicht, Leverage Ratio]; #link("https://www.spglobal.com/ratings/en/credit-ratings/about/understanding-credit-ratings")[S&P, Ratingskala] und #link("https://www.moodys.com/web/en/us/solutions/ratings/understanding-ratings.html")[Moody’s, Ratingskala], Abruf 05.11.2026.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.4 Krisen, Staatsrisiko und Anleihekäufe einordnen <a-2-4>

Viele einzelne Kredite können dasselbe Risiko enthalten. Werden Ausfälle und Wertverluste gleichzeitig sichtbar, geraten Bankkapital, Vertrauen und Kreditvergabe gemeinsam unter Druck. Die historischen Abbildungen der Vorlesung zeigen diesen Zusammenhang aus verschiedenen Blickwinkeln.

#bild("krisen-kette", [Vom Kreditrisiko zur Finanzierungskrise. Eigene schematische Darstellung nach V, PDF-S. 45–52.], height: 46mm)

Die Folien schildern die Neubewertung amerikanischer Hypothekenrisiken ab 2007, den Weiterverkauf verbriefter Forderungen, Wertberichtigungen und den Zusammenbruch von Lehman Brothers 2008. Verluste schwächen das Bankkapital; Misstrauen kann die Refinanzierung zwischen Banken erschweren. Staatliche Garantien, Kapitalhilfen und Risikoübernahmen sollen den Kreislauf stabilisieren. Die Folien 94–96 zeigen historische Größen dazu; sie sind keine heutigen Ausgaben oder Prognosen.

#bild("krise-staat-historisch", [Historische Länder-Ratings und TARGET-Salden, Stand um 2011. Ausschnitte aus N04, PDF-S. 3–4 (Folien 89–92; V, PDF-S. 45–46).], height: 96mm)

*Rating und Anleiherendite* sind verschiedene Größen: Die Note verdichtet eine Risikoeinschätzung, die Marktrendite ergibt sich aus dem Preis und den Zahlungsansprüchen der Anleihe. Höheres wahrgenommenes Risiko kann einen höheren Renditeaufschlag verlangen. Der historische Ländervergleich beweist keine zeitlose exakte Zuordnung zwischen Note und Zins. *TARGET-Salden* in der Grafik sind Forderungs-/Verbindlichkeitspositionen im Euro-Zahlungsverkehr; sie sind nicht die Ratingnote eines Staates.

#bild("krise-geldpolitik-historisch", [Bankkapital, Zinsen und Anleihekäufe in historischen Zeitreihen bis 2020. Ausschnitte aus N04, PDF-S. 7–8 (Folien 98–100; V, PDF-S. 49–50).], height: 96mm)

Die Kapitalquoten-Grafik vergleicht *Tier-1-Kapital/RWA* 2008 und 2018; sie zeigt keine EK-Quote EK/Bilanzsumme eines normalen Unternehmens. Die Zinsgrafik zeigt Renditen verschiedener Staatsanleihen. Die Kaufprogramm-Grafik verwendet *zwei Skalen*: monatliche Käufe links, Bestandsvolumen rechts. Leitzinsen und EONIA stehen in einer eigenen Grafik. EONIA ist hier die historische Zeitreihe, kein aktueller Referenzzins.

#bild("krise-konjunktur-historisch", [Konjunktur-, Finanzmarkt- und Staatsschuldenindikatoren. Ausschnitte aus N04, PDF-S. 10–11 (Folien 101–104; V, PDF-S. 51–52).], height: 103mm)

Die Folien zeigen bereits vor Corona eine Abschwächung 2019, den Einbruch 2020 sowie höhere Finanzmarktstress- und Kreditausfallversicherungswerte im Frühjahr 2020. Der *CISS-Index* bündelt Stressindikatoren; er ist keine Ausfallwahrscheinlichkeit eines einzelnen Unternehmens. Die Schuldenstandsquote setzt Staatsschulden zum BIP ins Verhältnis; ein Anstieg kann durch höhere Schulden und/oder ein niedrigeres BIP entstehen. Folie 104 ergänzt historische Daten 2022–2025 und einen Renditeaufschlag-Vergleich aus Oktober 2026; diese Stände bleiben als datierte Unterrichtsbeispiele gekennzeichnet.

=== 2.4.1 Deine Skizze zum Anleihekaufprogramm <a-2-4-1>

Deine Zusatzseite zeigt eine Wertpapierausgabe gegen 100 € und anschließend einen Ankauf durch die Notenbank. Den entscheidenden Unterschied macht der *Verkäufer beim Ankauf*: Die Notenbank kauft Staatsanleihen im hier gemeinten Programm am Sekundärmarkt. Das neu geschaffene Zentralbankgeld geht an die verkaufende Bank bzw. über deren Bank an den bisherigen Inhaber, nicht als unmittelbarer Kaufpreis einer neuen Staatsanleihe direkt an den Staat.

#bild("anleihekauf-schema", [Zwei getrennte Geschäfte: Emission und späterer Ankauf. Eigene Darstellung zu N04, PDF-S. 9; mit EZB-Erklärung präzisiert.], height: 59mm)

„Geld drucken“ ist hier ein Bild für die Schaffung von Zentralbankgeld durch Gutschrift, nicht zwingend für zusätzliche Banknoten. Wertpapierkäufe können Kurse erhöhen, Renditen senken und Finanzierungsbedingungen lockern. Die Wirkung auf Kreditvergabe, Nachfrage und Inflation ist ein Übertragungsprozess und keine automatische Eins-zu-eins-Wirkung auf Verbraucherpreise.
#src[V, PDF-S. 45–52 (Folien 89–104); N04, PDF-S. 3–11, insbesondere handschriftliche Zusatzseite PDF-S. 9. Präzisierung Anleihekäufe: #link("https://www.ecb.europa.eu/ecb-and-you/explainers/tell-me-more/html/app.en.html")[EZB, Funktionsweise des APP] und #link("https://www.ecb.europa.eu/ecb-and-you/explainers/show-me/html/app_infographic.en.html")[EZB, Kaufmechanismus]; #link("https://www.ecb.europa.eu/ecb-and-you/explainers/tell-me-more/html/asset-purchase.en.html")[EZB, Sekundärmarkt], Abruf 05.11.2026. Historische Foliengrafiken, keine Aktualisierung ihrer Zeitreihen.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.5 Kreditvertrag: sechs Stellschrauben und Covenants <a-2-5>

Ein Kredit wird durch seinen *Zahlungsfahrplan* und die vereinbarten Rechte bestimmt. Derselbe Nominalzins kann mit anderen Auszahlungen, Tilgungen und Terminen zu einer anderen Belastung führen. Deshalb prüfst Du den Vertrag als Ganzes.

#bild("map-kreditvertrag", [Mindmap: Zahlungen und Rechte gemeinsam vereinbaren. Eigene Darstellung nach V, PDF-S. 53–54.], height: 44mm)
#tab(columns: (1.2fr, 2.8fr),
 th([Merkmal], [Worum verhandelt wird]),
 [Betrag], [*Nominalbetrag* als Bezugs-/Rückzahlungsbetrag und tatsächlicher *Auszahlungsbetrag*. Ein *Disagio* ist ein Abzug bei der Auszahlung.],
 [Tilgungsstruktur], [Endfällig, konstante Tilgung oder konstante Gesamtzahlung (Annuität); Sondertilgungen und tilgungsfreie Zeiten.],
 [Zins], [Zinstermine, Bindungsdauer, Nominalzins und vergleichbarer Effektivzins.],
 [Laufzeit], [Fristenkongruenz, Kündigung und Verlängerung. Zinsbindung und Gesamtlaufzeit sind verschiedene Fristen.],
 [Sicherheiten], [Bürgschaft, Abtretung, Pfandrechte oder Sicherungsübereignung; knapper Überblick in 2.10.],
 [Weitere Vereinbarungen], [Zweckbindung und Covenants begrenzen bestimmte Handlungen.],
)

*Zinsbindung* fixiert den Zinssatz für einen vereinbarten Zeitraum, gegebenenfalls bis zur vollständigen Tilgung. Ein variabler Zins passt sich nach den Vertragsbedingungen an das Marktniveau an. Bei der Wahl werden Zinsänderungsrisiko, erwartete gesamte Zinszahlungen und Inflation abgewogen; ein fester Satz beseitigt nicht jedes Finanzierungsrisiko. *Zweckbindung* verpflichtet zur Verwendung für das vereinbarte Projekt.

*Covenants* sind vertragliche Nebenbedingungen zum Schutz des Gläubigers. Sie sollen eine nachträgliche Risikoerhöhung früh anzeigen bzw. begrenzen: Die Bank vereinbart Grenzen, der Schuldner berichtet über deren Einhaltung, und ein Verstoß löst die vertraglich vorgesehenen Folgen aus.
#tab(columns: (1.2fr, 2.8fr),
 th([Bereich], [Beispiele der Folien]),
 [Finanzierung], [Verschuldungsgrenzen, Schutz des bisherigen Anspruchsrangs (me-first-rule), Grenzen für Finanzierungsleasing.],
 [Ausschüttung], [Dividenden und Aktienrückkäufe begrenzen; bestimmte Mittel für Investition oder Tilgung reservieren.],
 [Investition], [Verkauf betriebsnotwendiger Anlagen begrenzen, Übernahmen an Finanzierungsstandards knüpfen, positives Net Working Capital verlangen.],
 [Information und Folgen], [Berichtspflichten, eindeutige Kennzahlendefinitionen, wahrheitsgemäße Angaben; Neuverhandlung, Zinsanpassung oder Fälligstellung gemäß Vertrag.],
)
Eine *Cross-default-Klausel* kann einen vertraglich definierten Ausfall in einem anderen Kreditverhältnis auch für diesen Vertrag relevant machen. Covenants liefern ein Frühwarnsystem, beschränken zugleich das Entscheidungsfeld des Schuldners. Ein Verstoß ist nicht automatisch eine Insolvenz; entscheidend sind Vertragsinhalt, Heilungsmöglichkeiten und die tatsächliche Lage.
#src[V, PDF-S. 53–54 (Folien 105–108); N04, PDF-S. 12–13. Disagio und Tilgungsformen zusätzlich K, PDF-S. 1–2. Verbindende Beispiele/Abgrenzungen: eigene Erläuterung.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.6 Zinstage: dieselbe Zeit unterschiedlich zählen <a-2-6>

Bei einfacher unterjähriger Verzinsung bestimmt die *Zinstagemethode*, welcher Bruchteil eines Jahres bezahlt wird. Zähler und Nenner gehören zusammen: Tatsächliche Kalendertage geteilt durch 360 sind etwas anderes als tatsächliche Tage geteilt durch 365.

#bild("map-zinszeit", [Mindmap: Tage zählen, Jahresbasis wählen und erst dann rechnen. Eigene Darstellung nach V, PDF-S. 55–56.], height: 44mm)
#form[$ Z=K_0 i frac(t,B) quad K_"Ende"=K_0+Z $]
$K_0$ = Anfangskapital in €; $i$ = Jahreszinssatz als Dezimalzahl; $t$ = nach der Methode gezählte Zinstage; $B$ = Tage der Jahresbasis. $t/B$ ist dimensionslos. Gültig für die einfache zeitanteilige Verzinsung des Beispiels, ohne Zinseszins innerhalb dieses Zeitabschnitts.

#tab(columns: (1.2fr, 2.8fr),
 th([Methode], [Zähler und Jahresbasis im behandelten Beispiel]),
 [30E/360], [Jeder Monat 30 Tage; der 31. wird hier auf den 30. gesetzt. Jahresbasis 360.],
 [30/360], [30-Tage-Monate mit abweichender Monatsendregel; der 31.12. bleibt im konkreten Folienfall als 31. stehen. Jahresbasis 360.],
 [actual/365], [Tatsächlich verstrichene Tage / 365.],
 [actual/360], [Tatsächlich verstrichene Tage / 360.],
 [actual/actual, kalenderjährlich], [Tatsächliche Tage / tatsächliche Tage des Kalenderjahres; 2016 hat 366. Bei Jahreswechsel nach Jahren aufteilen.],
)

Bei 30-Tage-Methoden lässt sich der Zähler als $360(Y_2-Y_1)+30(M_2-M_1)+(D_2-D_1)$ schreiben, nachdem die Tage gemäß Konvention angepasst wurden. Die Namen 30/360 allein reichen für alle denkbaren Monatsendfälle nicht aus: hier gilt genau die im Foliensatz gezeigte Variante. Die Musteraufgabe zählt den Anfangstag nicht mit und den Endtag mit. Ein Wechsel der Konvention ändert den Zinsbetrag, obwohl Anfangs- und Enddatum gleich bleiben.
#src[V, PDF-S. 55 (Folien 109–110); N04, PDF-S. 14. Formel, Zählweise und Begrenzung auf die gezeigten Varianten: eigene Erläuterung der Musterlösung.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.7 Zinstermine und Zinseszins vergleichen <a-2-7>

Zinsen können jährlich oder öfter gutgeschrieben werden. Bleiben sie angelegt, werden auch die früher gutgeschriebenen Zinsen später verzinst: *Zinseszins*. Ein Monatszinssatz ist daher zuerst in einen Jahresfaktor umzurechnen, bevor Du ihn mit einem Jahreszins vergleichst.
#form[$ K_n=K_0(1+i)^n $]
#form[$ 1+i_"eff,Jahr"=(1+i_"Monat")^12 $]
$i$ = Zinssatz je Zinsperiode als Dezimalzahl; $n$ = Zahl genau dieser Perioden. Voraussetzungen: unveränderte Zinssätze, Wiederanlage der Zinsen und keine zusätzlichen Ein-/Auszahlungen, Steuern oder Gebühren im Vergleichsmodell.

#bild("zinsfaktoren", [Häufigere Zinsgutschriften wirken über die Wiederanlage. Eigene schematische Darstellung nach V, PDF-S. 56; keine Zahlenachse.], height: 43mm)

Zum Vergleich über drei Jahre wird der jeweilige *Jahresfaktor hoch drei* genommen. Sind beide positiv und für alle Jahre unverändert, bleibt die Reihenfolge gleich. Ein Vorteil im ersten Jahr sagt dagegen nichts Sicheres über drei Jahre, wenn die anschließenden Zinssätze variabel oder nur bis zur nächsten Gutschrift zugesagt sind.
#note("Fehler in der Lösungsformulierung", [Folie 112 schreibt im Begründungssatz „wenn Möglichkeit 1 für ein Jahr besser ist“. Ihr eigenes Ergebnis bevorzugt aber *Möglichkeit 2*. Die zutreffende Aussage lautet: *Die bei unveränderten Bedingungen bessere Einjahresalternative bleibt auch über drei Jahre besser.* Eigene Korrektur des Satzfehlers.], fill: sand)
#src[V, PDF-S. 56 (Folien 111–112); N04, PDF-S. 15. Faktorvergleich und Satzkorrektur: eigene Erläuterung.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.8 Darlehenspflichten und Kündigungsrechte <a-2-8>

Beim *Darlehensvertrag* muss der Darlehensgeber den vereinbarten Geldbetrag bereitstellen. Der Darlehensnehmer schuldet einen vereinbarten Zins und bei Fälligkeit die Rückzahlung. Zins ist der Preis der zeitweisen Geldüberlassung; Tilgung führt die Schuld zurück.

#bild("map-darlehensrecht", [Mindmap: Pflichten, Fristen und Anlass getrennt prüfen. Eigene Darstellung nach V, PDF-S. 57–58; Rechtsabgleich 05.11.2026.], height: 44mm)

Für Verbraucherdarlehen nennt die Folie vorvertragliche Informationen, etwa über Kreditart, effektiven Jahreszins und Widerruf. Das historische Datum 11.06.2010 beschreibt die damalige Reform. Die heutigen Informationspflichten ergeben sich insbesondere aus § 491a BGB in Verbindung mit Art. 247 EGBGB; der konkrete Darlehenstyp ist zu unterscheiden. Eine Unternehmensfinanzierung ist nicht allein wegen einer natürlichen Person im Hintergrund ein Verbraucherdarlehen.

#tab(columns: (1.25fr, 2.8fr),
 th([Fall], [Voraussetzungen und Frist]),
 [Variabler Zins, § 489 Abs. 2], [Darlehensnehmer kann mit drei Monaten Frist kündigen.],
 [Zinsbindung endet, § 489 Abs. 1 Nr. 1], [Wenn sie vor dem Rückzahlungstermin endet und keine neue Zinsvereinbarung besteht: ein Monat Frist, frühestens zum Ende der Bindung.],
 [Lange Zinsbindung, § 489 Abs. 1 Nr. 2], [Nach zehn Jahren seit *vollständigem Empfang* mit sechs Monaten Frist; eine spätere neue Vereinbarung über Zins oder Rückzahlung kann den Fristbeginn ersetzen.],
 [Gefährdete Rückzahlung, § 490 Abs. 1], [Wesentliche eingetretene oder drohende Verschlechterung von Vermögensverhältnissen oder Sicherheit, die die Rückzahlung auch unter Verwertung gefährdet: Kündigungsrecht des Gebers unter den gesetzlichen Voraussetzungen.],
 [Berechtigtes Interesse, § 490 Abs. 2], [Nehmer: gebundener Sollzins, Grund-/Schiffspfandrecht, sechs Monate seit vollständigem Empfang und berechtigtes Interesse; drei Monate Kündigungsfrist. Möglicher Schadenersatz für den vorzeitigen Ausstieg.],
)

#note("Fristbeginn nicht verwechseln", [Die zehn Jahre beziehen sich nicht pauschal auf die Unterschrift. Der vollständige Darlehensempfang und gegebenenfalls eine spätere relevante Neuvereinbarung sind entscheidend. Auch bei § 490 Abs. 2 sind die sechs Monate bis zur Kündigungsmöglichkeit von der zusätzlichen Kündigungsfrist zu trennen. § 489 Abs. 3 verlangt außerdem fristgerechte Rückzahlung nach Wirksamwerden der Kündigung.], fill: sand)
#src[V, PDF-S. 57–58 (Folien 113–115); N04, PDF-S. 16–17. Geprüfte Ergänzungen: #link("https://www.gesetze-im-internet.de/bgb/__488.html")[§ 488], #link("https://www.gesetze-im-internet.de/bgb/__489.html")[§ 489], #link("https://www.gesetze-im-internet.de/bgb/__490.html")[§ 490], #link("https://www.gesetze-im-internet.de/bgb/__491a.html")[§ 491a BGB]; Abruf 05.11.2026.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.9 Vorfälligkeitsentschädigung: den Schaden vergleichen <a-2-9>

Ein Festzins verschafft dem Schuldner Planungssicherheit. Die Bank richtet ihre Finanzierung und erwarteten Zinszahlungen auf die Vertragsdauer aus. Bei einem vorzeitigen Ausstieg kann deshalb ein *Zinsschaden* entstehen: Die zurückerhaltenen Mittel lassen sich möglicherweise nur zu einem niedrigeren Zins wieder anlegen.

#bild("map-vorfaelligkeit", [Mindmap: Rechtsgrund, Zinsvergleich und Kostenkorrektur. Eigene Darstellung nach V, PDF-S. 58.], height: 44mm)

Zuerst wird geprüft, *ob* ein Anspruch auf Entschädigung besteht. Eine ordentliche Kündigung nach § 489 ist anders einzuordnen als die vorzeitige Kündigung nach § 490 Abs. 2. Ein frei vereinbarter Aufhebungsvertrag ist wiederum eine eigene Fallgruppe. Nicht jede frühere Rückzahlung erzeugt automatisch dieselbe Gebühr.

#tab(columns: (1.15fr, 2.8fr),
 th([Methode der Folie], [Vergleich und Bedeutung]),
 [*Aktiv-Aktiv*], [Der alte Kredit wird mit einem möglichen neuen Kreditgeschäft verglichen. Wiederanlage-/Zinsmargeneffekte sind sachgerecht abzugrenzen, damit derselbe Nachteil nicht doppelt ersetzt wird.],
 [*Aktiv-Passiv*], [Die vertraglichen Zahlungen werden mit einer Wiederanlage in laufzeitentsprechenden Hypothekenpfandbriefen verglichen. Die rekonstruierten Zahlungsströme werden bewertet; ersparte Risiko- und Verwaltungskosten sind zu berücksichtigen.],
)

Ein niedrigerer Wiederanlagezins vergrößert unter sonst gleichen Bedingungen den Zinsnachteil; ein höherer kann diesen Nachteil beseitigen. Restlaufzeit, Restschuld, vertragliche Zahlungen und mögliche Sondertilgungen beeinflussen die Rechnung. Die bloße Zinsdifferenz ist deshalb noch keine vollständige Entschädigungsformel.

#note("Gebührenaussage der Folie begrenzen", [Folie 116 leitet bei fehlendem Zinsschaden eine Beschränkung auf eine Bearbeitungsgebühr ab. Daraus folgt *kein automatischer Gebührenanspruch in jedem Fall*. Anspruchsgrund, anwendbares Darlehensrecht und der tatsächlich ersatzfähige Schaden sind zuerst zu prüfen. In den Lernaufgaben wird nur der behandelte wirtschaftliche Vergleich verlangt; eine pauschale Gebührenregel wird nicht als Gesetz gelernt. Eigene Präzisierung.], fill: sand)
#src[V, PDF-S. 58 (Folien 115–116); N04, PDF-S. 17. Abgrenzung des Schadenersatzes nach #link("https://www.gesetze-im-internet.de/bgb/__490.html")[§ 490 Abs. 2 BGB], Kündigungsrechte nach #link("https://www.gesetze-im-internet.de/bgb/__489.html")[§ 489 BGB], Abruf 05.11.2026. Keine über die Folie hinausgehende konkrete Gebührenberechnung.]
#hoch(<a-2>, [Kapitelübersicht])

#pagebreak()
== 2.10 Ergänzung aus der Altklausur 2017: Tilgung, Effektivzins und Sicherheiten <a-2-10>

Die Altklausur-Aufgabe 1 führt die in Folie 105 genannten Vertragsmerkmale zu Rechenfällen zusammen. Diese Ergänzung stammt aus der Klausurquelle und ist als solche von der Vorlesungsgrenze bis Folie 116 getrennt. Fremde handschriftliche Antworten im Scan werden nicht als Musterlösung verwendet.

#bild("map-tilgung", [Mindmap: Rückzahlungsform, Auszahlung und Sicherung unterscheiden. Eigene Darstellung nach K, PDF-S. 1–2; V, PDF-S. 53.], height: 44mm)

=== 2.10.1 Drei Tilgungsformen <a-2-10-1>

Bei *endfälliger Tilgung* bleibt die Schuld bis zum Schluss bestehen; bei jährlicher Zinszahlung wird jedes Jahr derselbe Nominalbetrag verzinst. Beim *Ratendarlehen* ist die Tilgung konstant, deshalb sinken Restschuld und Zinsen. Beim *Annuitätendarlehen* ist die Gesamtzahlung aus Zins und Tilgung konstant; der Zinsanteil fällt und der Tilgungsanteil steigt.
#form[$ Z_t=i R_(t-1) quad T_t=A_t-Z_t quad R_t=R_(t-1)-T_t $]
$R$ = Restschuld, $Z$ = Zins, $T$ = Tilgung, $A$ = Gesamtzahlung in €; $i$ = Zins je Zahlungsperiode. Die Klausur verzinst die Restschuld *zu Jahresbeginn*, Zahlungen liegen am Jahresende.
#form[$ T_"Rate"=D/n quad A_"Annuität"=D frac(i(1+i)^n,(1+i)^n-1) $]
$D$ = Anfangsschuld in €; $n$ = Zahl der Jahreszahlungen; Annuitätenformel bei $i>0$, konstantem Zins, nachschüssiger jährlicher Zahlung und vollständiger Tilgung. Sie folgt daraus, dass der Barwert aller gleichen Jahreszahlungen der Anfangsschuld entspricht. Keine Sondertilgung oder Gebühren im Modell.

=== 2.10.2 Auszahlungsdisagio und näherungsweiser Effektivzins <a-2-10-2>

Beim Disagio erhält der Schuldner weniger Geld als den Nominalbetrag, zahlt aber auf die vereinbarte Basis Zinsen und muss den vereinbarten Betrag zurückzahlen. Deshalb kann der Nominalzins die jährliche Belastung unterschätzen.
#form[$ i_"eff,approx" = frac(i_"nom" D+(D-"Aus")/n,"Aus") $]
$"Aus"$ = Auszahlung in €; $D-"Aus"$ = Disagio in €; $n$ = Laufzeit in Jahren. Das ist die *Praktikerformel für das endfällige Darlehen der Altklausur*: jährlicher Nominalzins plus linear auf die Jahre verteiltes Disagio, bezogen auf die Auszahlung. Sie ist eine Näherung, nicht die exakte Rendite sämtlicher zeitlich diskontierter Zahlungen und nicht die gesetzliche Effektivzinsberechnung jedes Verbraucherkredits.

#pagebreak()
=== 2.10.3 Zwei unabhängige Einteilungen von Sicherheiten <a-2-10-3>

Eine *Personalsicherheit* gibt einen zusätzlichen Anspruch gegen eine Person, etwa einen Bürgen. Eine *Realsicherheit* erschließt einen Vermögenswert, etwa über eine Grundschuld. Davon unabhängig fragt *akzessorisch*: Ist das Sicherungsrecht rechtlich an den Bestand der gesicherten Forderung gebunden? Die Bürgschaft ist ein Beispiel dafür.

Eine Sicherungsgrundschuld setzt dagegen nicht kraft ihres dinglichen Bestands eine Forderung voraus; ihre Verbindung zum Kredit wird durch die Sicherungsvereinbarung hergestellt. Das ist das hier gesuchte Beispiel eines *fiduziarischen* Sicherungsmittels. „Personal/real“ und „akzessorisch/fiduziarisch“ sind also zwei verschiedene Fragen. Die spätere ausführliche Vorlesung zu Kreditsicherheiten wird hier nicht vorweggenommen.
#src[K, PDF-S. 1–2 (Klausurseiten 5–6), Aufgabe 1 a–d, insgesamt 13 Punkte; V, PDF-S. 53, Folie 105. Formeln und Herleitung: eigene Lösung zur Klausur. Rechtsabgleich der Beispiele: #link("https://www.gesetze-im-internet.de/bgb/__767.html")[§ 767] und #link("https://www.gesetze-im-internet.de/bgb/__1192.html")[§ 1192 BGB], Abruf 05.11.2026.]

#pagebreak()
#note("Ab hier Selbststudium (Vorgriff)", [Die Abschnitte 2.11 bis 2.21 und die Kapitel 3 bis 5 stammen aus den Folien 117–328 des vollständigen Vorlesungsskripts. Sie waren am 13.11.2026 laut Deinen Notizen noch nicht in der Vorlesung behandelt; Du hast Dir gewünscht, das komplette Skript schon jetzt selbst zu lernen. Wenn die Vorlesung später etwas anders gewichtet oder ergänzt, wird das an der passenden Stelle nachgetragen.], fill: sand)

== 2.11 Sondertilgung und Tilgungsplan <a-2-11>

Eine *Sondertilgung* ist eine Zahlung über die vereinbarte Tilgung hinaus. Sie ist nur erlaubt, wenn der Kreditvertrag ein *Sondertilgungsrecht* vorsieht. Dieses Recht ist eine Option: Bei sinkenden Zinsen ist es wertvoll, weil man teures Geld früher zurückgeben kann; bei steigenden Zinsen ist es eventuell wertlos. Sein Wert hängt von der Zinsentwicklung (Volatilität), der Laufzeit und der möglichen Höhe der Sondertilgung ab.

#tab(columns: (2fr, 1.2fr, 1.2fr),
 th([Darlehen 100.000 €, 4,5 %, Monatsrate 1.000 €], [Zinsen gesamt], [Laufzeit]),
 [ohne Sondertilgung], [25.569 €], [10 J. 6 Mon.],
 [Sondertilgung 1.000 € im 1. Jahr], [25.041 €], [10 J. 5 Mon.],
 [Sondertilgung 2.000 € im 1. Jahr], [24.521 €], [10 J. 3 Mon.],
 [Sondertilgung 5.000 € im 1. Jahr], [23.014 €], [9 J. 11 Mon.],
)
Die Folie folgert: Sondertilgungsrecht vereinbaren und *so früh und so oft wie möglich* ausüben. Der Grund: Jeder früh zurückgezahlte Euro wird für die gesamte Restlaufzeit nicht mehr verzinst. 5.000 € Sondertilgung sparen hier gut 2.500 € Zinsen. *Nachgerechnet* (eigene Prüfung, monatliche Verzinsung mit 4,5 %/12, Sondertilgung am Ende des ersten Jahres): Die Folienwerte stimmen bis auf Rundung (24.522 statt 24.521 €).

#note("Negative Tilgung", [Im Beispiel von Anton A. (Aufgaben) wird bei Alternative I fünf Jahre lang gar nichts gezahlt. Die Zinsen werden der Schuld zugeschlagen, die Restschuld wächst von 50.000 € auf 54.000 € und 58.320 €. Die Folie nennt das *negative Tilgung*: Ist die Annuität kleiner als die Zinsen, wird $T_t = A_t - Z_t$ negativ. Es gilt immer $Z_t + T_t = A_t$.])
#src[V, PDF-S. 59–61 (Folien 117–121); Tilgungsformeln siehe 2.10.1. Nachrechnung: eigene Prüfung.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.12 Zinsstrukturkurve <a-2-12>

Die *Zinsstrukturkurve* zeigt, welcher Zinssatz für welche Laufzeit (Anlage- bzw. Ausleihdauer) gilt. Waagerecht steht die Laufzeit, senkrecht der Zins.

#bild("zinsstruktur-folie", [Folie 123: idealtypische Kurven (links) und Zinsstrukturkurven der Bundesbank zu sechs Zeitpunkten 1973–2005 (rechts). Ausschnitt aus V, PDF-S. 62.], height: 62mm)

#tab(columns: (1fr, 2.6fr),
 th([Form], [Bedeutung]),
 [*Horizontal*], [Für alle Laufzeiten gilt derselbe Zins.],
 [*Normal*], [Kurze Laufzeiten haben niedrigere Zinsen als lange. Der Anleger verlangt für lange Bindung einen Aufschlag.],
 [*Invers*], [Kurze Laufzeiten haben höhere Zinsen als lange. Die Folie nennt sie einen *Vorboten einer Rezession*: Der Markt erwartet künftig sinkende Zinsen.],
)
#text("Für die Finanzierung heißt das: Ein langfristiger Festzins ist bei normaler Kurve teurer als ein kurzfristiger Kredit, dafür ist das Zinsänderungsrisiko für die Laufzeit ausgeschaltet. Das verbindet die Kurve mit Fristigkeit (2.5) und Sondertilgungsrecht (2.11).")
#src[V, PDF-S. 61–62 (Folien 122–123). Verbindung zu Fristigkeit und Sondertilgung: eigene Erläuterung.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.13 Refinanzierung der Banken und Geldpolitik der EZB <a-2-13>

Auch Banken müssen sich finanzieren, um Kredite vergeben zu können. Diese Mittelbeschaffung heißt *Refinanzierung*. Besonderheit: Banken refinanzieren sich überwiegend mit Fremdkapital (Einlagen, Schuldverschreibungen); Eigenkapital spielt dabei laut Folie nur eine untergeordnete Rolle.

#bild("map-refinanzierung", [Mindmap: Zinsen je Laufzeit und Refinanzierung über die Zentralbank. Eigene Darstellung nach V, PDF-S. 61–65.], height: 44mm)

Seit 1.1.1999 verantwortet die *Europäische Zentralbank (EZB)* die Geldpolitik im Euroraum. *Hauptziel ist Preisstabilität*: laut Folie ein Anstieg des Verbraucherpreisindex mittelfristig unter 2 % gegenüber dem Vorjahr. Weitere Aufgaben sind Devisengeschäfte, Verwaltung der Währungsreserven, funktionierende Zahlungssysteme, Banknotenausgabe, Statistik, Bankenaufsicht und internationale Zusammenarbeit.

#tab(columns: (1.1fr, 2.7fr),
 th([Geldpolitisches Instrument], [So wirkt es laut Folie]),
 [*Mindestreserve*], [Pflichteinlage der Geschäftsbanken bei der Zentralbank. Basis: Einlagen, Schuldverschreibungen, Geldmarktpapiere; Satz 2 % für die meisten Positionen; verzinst zum Hauptrefinanzierungssatz. Ein höherer Satz entzieht den Banken Liquidität, ein niedrigerer führt ihnen Liquidität zu.],
 [*Offenmarktgeschäfte: Hauptrefinanzierung*], [Jede Woche vergibt die Zentralbank gegen Sicherheiten im Ausschreibungsweg Kredite mit einer Woche Laufzeit. Wichtigstes Instrument zur Steuerung von Zinsen und Geldmarktliquidität. Ihr Satz ist der *Leitzins*.],
 [*Ständige Fazilitäten*], [Auf Initiative der Banken über Nacht; die Spitzenrefinanzierungsfazilität hat den früheren Lombardkredit der Bundesbank abgelöst (Folie 148).],
)

#note("Historische Folienwerte", [Die Folie nennt einen Leitzins von 0,00 % „seit März 2016“ und einen Mindestreservesatz von 2 %. Das sind *Stände aus der Quelle der Folie*, keine aktuellen Werte: Die EZB hat den Mindestreservesatz bereits 2012 auf 1 % gesenkt und die Leitzinsen ab 2022 deutlich erhöht und später wieder gesenkt. Für die Klausur lernst Du Wirkungsweise und Folienlogik; aktuelle Sätze nur, wenn sie in der Vorlesung genannt werden. Eigene Einordnung.], fill: sand)
Folie 129 zeigt einen Zeitungsausschnitt (bondguide.de, 28.09.2026) zur Refinanzierung; er enthält keinen zusätzlichen Lernstoff.
#src[V, PDF-S. 62–65 (Folien 124–129). Einordnung der Folienwerte: #link("https://www.ecb.europa.eu/mopo/implement/mr/html/index.de.html")[EZB, Mindestreserve], Abruf 13.11.2026.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.14 Kreditsicherheiten <a-2-14>

Ein Kreditgeber senkt sein Ausfallrisiko durch *Risikostreuung*, *Risikoteilung* und *Kreditbesicherung*. Sicherheiten stellt der Kreditnehmer selbst oder ein Dritter. Die Folie unterscheidet *Personensicherheiten* (schuldrechtlicher Anspruch gegen eine weitere Person, z. B. Bürgschaft) und *Sachsicherheiten* (dingliches Recht an einer Sache, z. B. Eigentumsvorbehalt).

#bild("map-sicherheiten", [Mindmap: Kreditsicherheiten nach Art, Forderungsbindung und Kreditgeber. Eigene Darstellung nach V, PDF-S. 65–70.], height: 44mm)

#tab(columns: (1fr, 1.4fr, 1.4fr),
 th([Entstehung], [Gesetzlich geregelt], [Gesetzlich nicht geregelt]),
 [gesetzlich (z. B. Vermieterpfandrecht)], [–], [–],
 [rechtsgeschäftlich], [Bürgschaft, Eigentumsvorbehalt, Grundpfandrechte (Grundschuld, Hypothek), Pfandrecht an beweglichen Sachen, Pfandrecht an Rechten/Forderungen], [Garantie, Sicherungsübereignung, Forderungszession, Patronatserklärung],
)

=== 2.14.1 Bürgschaft <a-2-14-1>

Bei der *Bürgschaft* verpflichtet sich der Bürge gegenüber dem Kreditgeber, für die Verbindlichkeit des Kreditnehmers einzustehen (§ 765 BGB). Hinter den Schuldner tritt eine zweite Person, von der der Gläubiger Zahlung verlangen kann, wenn der Schuldner nicht leistet.

#note("Von dir markiert: Akzessorietät", [Die Bürgschaft hängt vom *Bestehen einer Forderung* ab. Erlischt oder verringert sich die Hauptschuld, gilt das auch für die Bürgschaft. (Gelb markiert im Vollskript, N13, PDF-S. 67.)])

#tab(columns: (1.3fr, 2.6fr),
 th([Ausgestaltung], [Wann muss der Bürge zahlen?]),
 [*Ausfallbürgschaft*], [Nur für den Teil, den der Gläubiger trotz aller außergerichtlichen und gerichtlichen Mittel beim Hauptschuldner nicht eintreiben konnte.],
 [*Einfache (subsidiäre) Bürgschaft*], [Der Gläubiger muss zuerst den Schuldner in Anspruch nehmen; zahlt dieser nicht, kann er sich an den Bürgen wenden.],
 [*Selbstschuldnerische Bürgschaft*], [Der Bürge haftet „als Bürge und Zahler“, verzichtet auf die *Einrede der Vorausklage*. Der Gläubiger kann wählen, wen er zuerst in Anspruch nimmt; in der Praxis wird zuerst der Schuldner gemahnt.],
)

#bild("buergschaft-folie", [Folie 133: Ablauf einer Bürgschaft (Quelle der Folie: Bösch, Finanzwirtschaft, S. 206). Ausschnitt aus V, PDF-S. 67.], height: 60mm)

*Lesart der Nummern:* (1) Kreditvertrag zwischen Kreditgeber und Schuldner, (2) Bürgschaftsvertrag zwischen Kreditgeber und Bürge, (3) Auszahlung des Kredits, (4) keine Rückzahlung, (5) Zahlung des Bürgen, (6) Forderung geht auf den Bürgen über, (7) Rückgriff des Bürgen beim Schuldner. Im Beispiel der Folie bürgt die Hausbank für den Kaufpreis einer Maschine. Zahlt die Bank, geht die Kaufpreisforderung auf sie über; das Eigentum des Käufers an der Maschine bleibt davon unberührt.

=== 2.14.2 Grundpfandrechte, Eigentumsvorbehalt und Garantie <a-2-14-2>

*Grundpfandrechte* (Hypothek, Grundschuld) belasten ein Grundstück. Der Gläubiger kann letztlich Zwangsversteigerung bzw. Zwangsverwaltung verlangen, die der Schuldner dulden muss. Sie entstehen durch Einigung und Eintragung ins Grundbuch beim Amtsgericht.

#tab(columns: (1fr, 1.5fr, 1.5fr),
 th([], [Grundschuld], [Hypothek]),
 [Bindung an Forderung], [*nicht akzessorisch* (§ 1191 BGB): „bestimmte Geldsumme aus dem Grundstück“], [*akzessorisch*: besteht nur mit der Forderung],
 [Folge], [Forderung kann formlos ausgetauscht werden; die Grundschuld bleibt für neue Kredite nutzbar], [Mit Tilgung der Forderung erlischt die Sicherung insoweit],
)
Beispiel der Folie: Herr K. leiht sich 30.000 € für ein Auto; die Bank verlangt eine Grundschuld auf sein Grundstück. Zahlt er nicht, darf die Bank das Grundstück im Wege der Zwangsverwaltung bzw. -versteigerung verwerten.

Beim *Eigentumsvorbehalt (EV)* behält der Verkäufer das Eigentum an einer beweglichen Sache bis zur vollständigen Zahlung. Er ist bis dahin Kreditgeber und sichert sich durch das Recht, „seine Ware“ zurückzufordern, wenn der Käufer in Verzug gerät. Er ist das *klassische Sicherungsmittel des Lieferantenkredits*.
- *Verlängerter EV:* Wird die Ware weiterverarbeitet, erstreckt sich der EV auf das neue Produkt; wird dieses verkauft, gehen die Kaufpreisforderungen im Voraus an den Lieferanten über.
- *Anwartschaftsrecht:* Der Käufer erhält bei Lieferung noch nicht das Eigentum, aber ein Anwartschaftsrecht, das der Verkäufer nicht mehr einseitig zerstören kann; es gibt unter anderem ein Recht zum Besitz. Beispiel der Folie: Herr A kauft ein Auto für 10.000 € in Monatsraten zu 1.000 €; mit jeder Rate wächst sein Anwartschaftsrecht, im Oktober geht das Eigentum über. Das Anwartschaftsrecht entsteht schon durch die bedingte Übereignung, unabhängig von einer ersten Teilzahlung.

Beim *Garantievertrag* (gesetzlich nicht geregelt, aber anerkannt) verpflichtet sich ein Garant, für einen bestimmten Erfolg einzustehen oder einen künftigen Schaden zu übernehmen. *Unterschied zur Bürgschaft: Die Garantie ist nicht akzessorisch.* Der Garant zahlt auch, wenn die Forderung gar nicht besteht oder der Schuldner ein Leistungsverweigerungsrecht hätte. Im internationalen Handel ist die *Garantie auf erste Anforderung* üblich: „erst zahlen, dann prozessieren“, laut Folie besonders gefährlich für den Garanten.

#note("Fehler vermeiden", [Personal/real und akzessorisch/nicht akzessorisch sind zwei getrennte Fragen (siehe 2.10.3). Bürgschaft: personal und akzessorisch. Garantie: personal, aber nicht akzessorisch. Hypothek: real und akzessorisch. Grundschuld: real und nicht akzessorisch.], fill: sand)

=== 2.14.3 Welche Kreditgeber halten welche Sicherheiten? <a-2-14-3>

Die Folie 139 (Quelle: Gessner u. a., Konkursabwicklung) verteilt die gesicherten Forderungen in Konkursen auf Kreditgeber. Lesart der Gesamtsummen: *Kreditinstitute 62,7 %, Lieferanten 22,8 %, andere 14,4 %*. Banken stützen sich vor allem auf *Grundschulden* (32,9) und Sicherungsübereignung (12,2); Lieferanten auf den *Eigentumsvorbehalt* (12,5) und Forderungsabtretungen wie den verlängerten EV. Die Zahlen sind ein historisches Bild; die Zuordnung einzelner Zellen ist im Folien-Export nicht eindeutig lesbar, deshalb werden nur diese Kernaussagen gelernt.
#src[V, PDF-S. 65–70 (Folien 130–139); N13, PDF-S. 67 (Markierung). Gesetzesstellen nach Folie: §§ 765, 1191 BGB.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.15 Kurzfristige Fremdfinanzierung <a-2-15>

Die Folie nennt fünf kurzfristige Formen: Kunden- und Lieferantenkredit, Kontokorrentkredit, Avalkredit, Factoring und Lombardkredit.

#bild("map-kurzfristig", [Mindmap: fünf kurzfristige Finanzierungsformen. Eigene Darstellung nach V, PDF-S. 70–74.], height: 44mm)

=== 2.15.1 Kunden- und Lieferantenkredit <a-2-15-1>

Beim *Kundenkredit* (Anzahlung, Vorkasse) zahlt der Kunde einen Teil des Preises schon vor der Leistung, z. B. im Anlagen- oder Schiffbau. Bei schlechter Kreditwürdigkeit des Kunden verlangen Lieferanten oft Vorkasse. Beim *Lieferantenkredit* (Kauf auf Ziel) erhält der Kunde die Ware und zahlt später. Wer schnell zahlt (10–14 Tage), erhält *Skonto*. *Die Kosten des Lieferantenkredits sind der entgangene Skonto.* Vorteil: hohe Flexibilität. Nachteil: verglichen mit anderen Formen oft sehr teuer.

#form[$ i_"Skonto" = frac("Skontosatz", 1 - "Skontosatz") times frac(360, "Zahlungsziel" - "Skontofrist") $]
Ergebnis als Jahreszins (einfache Verzinsung, 360 Zinstage, deutsche Zinsrechnung). Bezugsgröße ist der *Betrag nach Skonto*, denn diesen Betrag „leiht“ man sich für die zusätzlichen Tage. Beispiel der Folie: „10 Tage 2 % Skonto oder 30 Tage netto“, 100.000 €: Für 20 Tage Kredit über 98.000 € zahlt man 2.000 € „Zinsen“, also $2000 = 98000 times i times 20/360$, $i approx "36,7" %$.

#note("Selbst erklären", [Warum ist ein Kontokorrentkredit zu 12 % immer noch günstiger als der Verzicht auf 2 % Skonto bei 20 Tagen Differenz? *Antwort:* Die 2 % fallen für nur 20 Tage an, aufs Jahr hochgerechnet etwa 36,7 %. Mit dem billigeren Kontokorrentkredit pünktlich zum Skontotermin zahlen lohnt sich.])

*Übungen 1–3 der Folien:* Bei der Stadelmann AG (2 % Skonto bei 20 Tagen, Ziel 60 Tage) kostet das Zahlungsziel $"0,02"/"0,98" times 360/40 approx "18,4" %$ pro Jahr: Je länger der zusätzliche Zeitraum, desto billiger der Lieferantenkredit. Die Kobit AG zeigt die Gegenrichtung, den *Kundenkredit*: Verzichtet sie auf Anzahlungen von 230.000 € (6 Monate früher) und 140.000 € (3 Monate früher), muss sie diese Beträge bei 2,5 % pro Vierteljahr selbst finanzieren: $230000 times "5" % + 140000 times "2,5" % = 11500 + 3500 = "15.000"$ € Preisaufschlag (einfache Verzinsung wie in der Folie). Warum nutzen viele Abnehmer Skonto trotzdem nicht? Keine anderen Kreditmöglichkeiten, die hohen Kosten werden nicht erkannt, schlechtes Cash Management (Termine verpasst) oder die liquiden Mittel bringen anderswo mehr Zins.
#src[V, PDF-S. 98–100 (Folien 195–200).]

=== 2.15.2 Kontokorrentkredit und Avalkredit <a-2-15-2>

Der *Kontokorrentkredit* ist der klassische kurzfristige Kredit auf dem laufenden Geschäftskonto. Jede Zahlung verändert den Saldo; ein negativer Saldo ist Kreditinanspruchnahme bis zum vereinbarten Limit. Vorteile: sehr flexibel, sichert die Zahlungsfähigkeit in angespannten Phasen und erleichtert das Ausnutzen von Skonto. Nachteil: hohe Kosten.

Beim *Avalkredit* übernimmt eine Bank eine Bürgschaft oder Garantie für ihren Kunden gegenüber einem Dritten. *Kein Kredit im Sinne von Geld:* Die Bank stellt ihre Kreditwürdigkeit zur Verfügung und zahlt nur, wenn der Kunde seine Verpflichtung nicht erfüllt. Wichtige Form: *Zollaval* (Finanzverwaltung stundet gegen Sicherheit). Vorteile: höhere Bonität gegenüber Dritten, keine Geldhinterlegung, nur *Avalprovision* statt Zinsen. Nachteil: Die Provision kostet auch dann, wenn der Kunde alles erfüllt.

=== 2.15.3 Factoring und Lombardkredit <a-2-15-3>

*Factoring* ist der laufende Verkauf kurzfristiger Forderungen (Höchstlaufzeit 90–120 Tage) an eine Factoringgesellschaft im Rahmen eines längerfristigen Vertrags. Es bündelt drei Funktionen:

#tab(columns: (1.2fr, 2.6fr),
 th([Funktion], [Inhalt und Kosten laut Folie]),
 [*Servicefunktion*], [Debitorenbuchhaltung, Mahnwesen, Inkasso; Gebühr 0,5–2,5 % der Rechnungsbeträge.],
 [*Finanzierungsfunktion*], [Der Factor bevorschusst die Forderungen und führt Liquidität zu; bankübliche Zinsen.],
 [*Delkrederefunktion*], [Beim *echten Factoring* trägt der Factor das Ausfallrisiko (Gebühr 0,2–0,5 %); beim *unechten Factoring* bleibt es beim Verkäufer.],
)
*Finanzierungseffekt:* In Forderungen gebundenes Kapital wird freigesetzt. Gegenüber dem Kontokorrentkredit: Verwaltungskosten sinken, der Zinsaufwand ist grundsätzlich niedriger, das Volumen potenziell höher. Nachteile: kein Leverage-Effekt, relativ hohe Gebühren, weniger Dispositionsfreiheit und eine mögliche Belastung der Kundenbeziehung, wenn der Factor mahnt. Beispiel der Folie: Bevorschussung bis 80 %, Rest nach Zahlung des Kunden, spätestens nach 90 Tagen; 1,5 % Gebühr plus Zinsen.

Der *Lombardkredit* ist ein kurzfristiger Kredit über einen festen Betrag, gesichert durch *Verpfändung* marktgängiger Sachen oder Rechte (Wertpapiere, Waren, Wechsel, Forderungen, Edelmetalle). Beliehen wird nur ein Prozentsatz des Zeitwerts. Kosten früher Lombardsatz (ca. 1–1,5 % über Diskontsatz, vor der EZB) plus Bewertung und Verwahrung, insgesamt etwa wie Kontokorrent; weniger flexibel als dieser. Bei der EZB durch die Spitzenrefinanzierungsfazilität abgelöst.

#note("Fehler vermeiden", [Factoring = Forderung *verkaufen* (sie verlässt die Bilanz). Lombard = Vermögen *verpfänden* (es bleibt Eigentum, der Kredit ist Fremdkapital). Aval = Bank *haftet*, zahlt aber zunächst kein Geld aus.], fill: sand)
#src[V, PDF-S. 70–74 (Folien 140–148). Skontoformel: V, PDF-S. 71 und 98 (Folien 142, 196). Vergleichskasten: eigene Erläuterung.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.16 Langfristige Fremdfinanzierung: Überblick und Darlehen <a-2-16>

#tab(columns: (1fr, 1fr),
 th([Traditionelle Instrumente], [Innovative Instrumente]),
 [1 Darlehen (Bankkredit) · 2 Schuldscheindarlehen · 3 Industrieobligation · 4 Gesellschafterdarlehen], [9 Null-Kupon-Anleihe · 10 Floating Rate Notes · 11 Indexanleihen · 12 Doppelwährungsanleihen],
 table.cell(colspan: 2)[*Hybridformen:* 5 Optionsanleihe · 6 Wandelanleihe · 7 Gewinnobligation · 8 Genussschein],
)
Das *Darlehen* mit Rückzahlung in festen Beträgen ist das typische Finanzierungsinstrument des Mittelstands. Geber sind Kreditinstitute, öffentliche Stellen (z. B. KfW, Landesbanken), Kapitalsammelstellen oder Privatpersonen; Merkmale wie in 2.5. Wichtig: Oft ist nur der Nominalzins angegeben; zum Vergleich braucht man den *Effektivzins*. Er hängt ab von Nominalzins, Auszahlungskurs, Provisionen und sonstigen Kosten (Praktikerformel in 2.10.2).

#bild("annuitaet-folie", [Folie 151: Tilgungsformen mit Abbildung Annuitätendarlehen (Quelle der Folie: Wöltje 2009). Ausschnitt aus V, PDF-S. 76.], height: 60mm)
Die drei Tilgungsformen sind in 2.10.1 mit Formeln erklärt: *endfällig* (Zinsdarlehen), *Tilgungsdarlehen* (Abzahlungs-/Ratendarlehen), *Annuitätendarlehen*.
#src[V, PDF-S. 75–76 (Folien 149–151); Formeln 2.10.1.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.17 Leasing <a-2-17>

*Leasing* ist laut Folie eine Sonderform der langfristigen Kreditfinanzierung: die zeitweise Überlassung eines beweglichen oder unbeweglichen Gegenstands gegen Entgelt. Rechtsgrundlage ist das Mietrecht im BGB. Anders als bei der Miete trägt beim (Finanzierungs-)Leasing oft der Leasingnehmer Wartung und Instandhaltung; Objekt und feste Nutzungsdauer werden auf ihn zugeschnitten.

#bild("map-leasing", [Mindmap: drei Leasingformen und der Vergleich mit dem Kreditkauf. Eigene Darstellung nach V, PDF-S. 76–83.], height: 44mm)

#tab(columns: (1.15fr, 1.5fr, 1.5fr),
 th([], [Finanzierungsleasing], [Operating-Leasing]),
 [Laufzeit], [unkündbare Grundmietzeit], [vergleichsweise kurz, i. d. R. von beiden kündbar],
 [Risiko, Wartung], [wirtschaftliches Risiko, Wartung und Instandhaltung beim Leasingnehmer (LN)], [Wartung und Instandhaltung beim Leasinggeber (LG)],
 [Eigentum], [bleibt beim LG (kann es steuerlich abschreiben); LN zahlt Raten je Periode], [beim LG],
 [Varianten], [ohne Option, mit Kauf- oder Verlängerungsoption, Mobilien/Immobilien, Voll-/Teilamortisation], [entspricht kurzfristigem Mietvertrag (§§ 535 ff. BGB)],
)
Beim *Sale-and-lease-back* verkauft der LN ein ihm gehörendes Objekt an den LG und least es sofort zurück (meist als Finanzierungsleasing). Er erhält den Kaufpreis und zahlt Leasingraten. Beispiel der Folie: Stahlunternehmen wie Klöckner verkauften in den Stahlkrisen der 1980er/90er Betriebsgrundstücke und mieteten sie zurück, als Kredite und Kapitalerhöhung nicht mehr möglich waren. Das ist eine *Vermögensumschichtung* (siehe 3.2).

#tab(columns: (1fr, 1fr),
 th([Pro Leasing], [Kontra Leasing]),
 [*Liquidität:* Raten verteilt statt Kaufpreis auf einmal. *Planungssicherheit:* Rate und Laufzeit fest. *Steuer:* Raten je nach Vertrag sofort als Betriebsausgabe abzugsfähig. *Flexibilität und Innovation.* *Investition ohne Kapital* (oft geringere Sicherheitsanforderungen). *Bilanz und Rating:* bessere Kennzahlen, z. B. EK zu AV. *Service und Marktübersicht des LG.*],
 [*Kein Eigentum:* kein Verkauf bei Geldbedarf. *Hohe Gesamtkosten:* LG kalkuliert Ausfallrisiko und Gewinn ein. *Vertragslaufzeit:* Raten auch bei Nichtnutzung. *Zahlung trotz Streit:* Gewährleistungsansprüche gegen den Hersteller muss der LN selbst geltend machen, Zahlung nicht einfach einstellen. *Kündigungsgefahr* bei Zahlungsverzug, ggf. plus Schadenersatz.],
)

=== 2.17.1 Leasing oder Kreditkauf: Barwertvergleich <a-2-17-1>

Leasing und Kreditkauf vergleicht man über den *Barwert der Nettoauszahlungen nach Steuern*. Beim Kreditkauf mindern Abschreibung und Zinsen die Steuer; beim Leasing mindern die Leasingraten die Steuer. Das Zahlenbeispiel der Folien (Perridon/Steiner/Rathgeber, Objekt 100.000 €, 5 Jahre, 8 % Kreditzins, GewSt 10,5 %, KSt 15 %, Diskontierung mit 5,96 %) kommt auf fast denselben Wert:

#tab(columns: (1.6fr, 1fr),
 th([Variante], [Barwert der Nettoauszahlungen]),
 [Kreditkauf: Tilgung 20.000 €/Jahr + Zinsen − Steuerentlastung aus AfA und (75 % der) Zinsen bei der GewSt bzw. AfA und Zinsen bei der KSt], [79.045 €],
 [Leasing: 3 Raten zu 36.505 € und 2 zu 5.000 €, abzüglich Steuerentlastung], [79.047 €],
)
Leasing ist damit hier praktisch gleich teuer. Nachgerechnet: Die Zeilen der Folie stimmen (z. B. Jahr 1 Kreditkauf: $20000 + 8000 - 2730 - 4200 = 21070$ €, abgezinst $21070 / "1,0596" approx 19885$ €). Der Satz 5,96 % entspricht $8 % times (1 - "0,255")$; die Folie nennt ihn ohne Herleitung (eigene Deutung).

Das englische Lehrbuchbeispiel *Greymare Bus Lines* (Brealey/Myers/Allen) zeigt dieselbe Logik: Ein Bus für 100.000 \$ kann gekauft oder für 8 Raten zu 16.900 \$ (erste sofort) geleast werden. Die Leasingrate ist steuerlich abzugsfähig (35 %: 5.920 \$ Ersparnis), dafür entfällt die Abschreibung. Abgezinst wird mit dem Kreditzins nach Steuern, $10 % times (1 - "0,35") = "6,5" %$. Die Bilanz zeigt: Die Leasingverpflichtung wirkt wie ein Kredit über den Bus.

*Kernaussagen der Folien 164–166:* Zahlen LG und LN denselben Steuersatz, ist jeder Vorteil des einen ein Nachteil des anderen: Im Beispiel verliert der LN 700 \$, der LG gewinnt 700 \$. Zahlt der LN keine Steuern, gewinnen beide (LN 820 \$), *auf Kosten des Staates*. Der gemeinsame Vorteil ist umso größer, je höher der Steuersatz des LG gegenüber dem des LN, je früher die Abschreibungen anfallen, je länger der Vertrag mit späten Raten und je höher der Zins.

#note("Nachgerechnet", [Mit den Tabellenwerten ergibt sich für Greymare ein Leasingwert von etwa −0,72 Tsd. \$ (abgezinst mit 6,5 %) und im Fall ohne Steuern $100 - sum_(t=0)^7 "16,9"/"1,1"^t approx +"0,82"$ Tsd. \$. Beide Folienaussagen (−700 \$ bzw. +820 \$) stimmen. Eigene Nachrechnung.])
#src[V, PDF-S. 76–83 (Folien 152–166). Nachrechnung Perridon-Beispiel und Greymare: eigene Prüfung.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.18 Schuldschein, Industrieobligation, Barwert und Stückzinsen <a-2-18>

Das *Schuldscheindarlehen* ist ein langfristiges Großdarlehen (1–50 Mio. €). Der Schuldschein ist *kein Wertpapier, sondern eine Beweisurkunde*: Ein Wertpapier (Aktie, Scheck, Anleihe) verkörpert ein Recht, eine Beweisurkunde (Quittung, Schuldschein) beweist nur eine Tatsache. Geber sind neben Banken vor allem Kapitalsammelstellen (Lebensversicherungen, Pensionskassen, Bausparkassen). Der Kreditnehmer braucht sehr gute Bonität und erstklassige Sicherheiten; der Geber kann das Darlehen leicht abtreten (Zession). Vorteile: geringe Kosten, schnelle Beschaffung. Nachteil: Die hohen Anforderungen schränken weitere Verschuldung ein.

*Industrieobligationen* sind Anleihen der gewerblichen Wirtschaft. Viele Anleger stellen kleine Beträge bereit (Teilschuldverschreibungen zu 100, 500, 1.000, 5.000 oder 10.000 €), sodass ein hoher Kapitalbedarf langfristig gedeckt wird. Sie verbriefen *Gläubigerrechte*: fester Zins zu festen Terminen, Tilgung zu einem bestimmten Zeitpunkt, Ansprüche *vor* denen der Aktionäre. Nachteil: hohe Ausgabekosten.

=== 2.18.1 Barwert und Kapitalwert einer Anleihe <a-2-18-1>

Den Wert künftiger Zahlungen heute misst der *Barwert (Present Value, PV)*: jede Zahlung mit dem Kalkulationszins abzinsen und addieren. Den Nettovorteil zeigt der *Kapitalwert (NPV)*: PV minus heutiger Kurs.
#form[$ "PV" = sum_(t=1)^n frac(Z_t, (1+i)^t) quad quad "NPV" = "PV" - "Kurs" $]
$Z_t$ = Zahlung im Jahr $t$ (Zins und ggf. Rückzahlung), $i$ = Kalkulationszins je Jahr. Beispiel der Folie bei 10 %: Anleihe 1 (12; 112) hat PV 103,47, Anleihe 2 (60; 60) PV 104,13. Bei einem Kurs von je 100 € ist Anleihe 2 vorzuziehen (NPV 4,13 statt 3,47 €).

=== 2.18.2 Stückzinsen beim Anleihekauf <a-2-18-2>

Wer eine Anleihe zwischen zwei Zinsterminen kauft, bekommt am nächsten Termin den vollen Jahreszins. Deshalb zahlt er dem Verkäufer die seit dem letzten Zinstermin aufgelaufenen *Stückzinsen*.
#form[$ "Kaufpreis" = "Kurs"/100 times "Nennwert" + "Nennwert" times i_"nom" times "Tage"/"Basis" $]
Tage seit dem letzten Zinstermin bis zum Valutatag nach der vereinbarten Zinsmethode (2.6), hier actual/actual ohne Schaltjahr, Basis 365. Beispiel der Folie: Nennwert 600 €, Kurs 95, Kupon 4 % am 10.4., Kauf am 21.5.: 41 Tage, Kaufpreis $570 + "2,70" = "572,70"$ €.
#src[V, PDF-S. 84–86 (Folien 167–171); Zinsmethoden 2.6.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.19 Gesellschafterdarlehen <a-2-19>

Gesellschafter geben ihrer Gesellschaft häufig Darlehen statt Eigenkapital, besonders in kleinen und mittleren Unternehmen und in Krisen, weil sie oft die einzige Geldquelle sind.

#tab(columns: (1fr, 1fr),
 th([Vorteile laut Folie], [Achtung]),
 [1 keine Kapitalbeschaffungskosten · 2 flexible Vertragsbedingungen · 3 geringeres Kündigungsrisiko · 4 Finanzierungsquelle, wenn Dritte nichts mehr geben · 5 bessere Position in der Insolvenz als Eigenkapitalgeber · 6 kurzfristige Beseitigung von Insolvenztatbeständen],
 [Früher konnten Gesellschafterdarlehen nach §§ 32a, 32b GmbHG in *funktionales Eigenkapital umqualifiziert* werden, wenn sie in der Krise gegeben oder stehen gelassen wurden (wenn ein ordentlicher Kaufmann Eigenkapital zugeführt hätte). Folge: keine Geltendmachung in der Insolvenz. *Seit 01.11.2008 (MoMiG):* keine Umqualifizierung mehr, sondern eine *Jahresfrist*.],
)
#note("Präzisierung", [Heute sind Forderungen aus Gesellschafterdarlehen in der Insolvenz *nachrangig* (§ 39 Abs. 1 Nr. 5 InsO), und Rückzahlungen im letzten Jahr vor dem Insolvenzantrag sind anfechtbar (§ 135 InsO), das meint die „Jahresfrist“. Punkt 5 der Folie („bessere Position als EK-Geber“) gilt also nur gegenüber Eigenkapital, nicht gegenüber anderen Gläubigern. Eigene Präzisierung.], fill: sand)
Aus der Übung 4 (Folie 202): Rechtlich ist das Aktionärsdarlehen Fremdkapital, betriebswirtschaftlich hat es Eigenkapitalzüge (*verdecktes Eigenkapital*), weil der Geber dem Unternehmen nahe steht. Ein überhöhter Zins kann eine *verdeckte Gewinnausschüttung* sein, die die übrigen Aktionäre benachteiligt.
#src[V, PDF-S. 86 und 101 (Folien 172, 201–202). Präzisierung: #link("https://www.gesetze-im-internet.de/inso/__39.html")[§ 39 InsO], #link("https://www.gesetze-im-internet.de/inso/__135.html")[§ 135 InsO], Abruf 13.11.2026.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.20 Hybride und innovative Anleihen <a-2-20>

#bild("map-anleihen", [Mindmap: Anleiheformen nach Ausstattung. Eigene Darstellung nach V, PDF-S. 87–93.], height: 44mm)

=== 2.20.1 Optionsanleihe und Wandelanleihe <a-2-20-1>

Die *Optionsanleihe* ist eine Anleihe plus *Optionsschein*: das Recht, innerhalb einer Frist Aktien zu einem festen *Bezugskurs* zu kaufen. Das Forderungsrecht der Anleihe bleibt bei Ausübung bestehen; Anleihe und Optionsschein können getrennt gehandelt werden. Weil spekulative Anleger über den Optionsschein überproportional von Kurssteigerungen profitieren (*Hebel*), akzeptieren sie einen niedrigeren Zins; das senkt die Finanzierungskosten.
#form[$ "rechnerischer Wert des Optionsscheins" = "Aktienkurs" - "Bezugskurs" quad ("je Aktie, wenn positiv") $]
Beispiel der Folie: Bezugskurs 400 €, Aktie 420 € → Wert 20 €. Steigt die Aktie um 10 % auf 462 €, steigt der Optionsschein auf 62 €, also um 210 %, 21-mal so stark.

Die *Wandelanleihe* verbrieft ein *Umtauschrecht* in Aktien (nach einer Sperrfrist). Bei Wandlung wird aus dem Gläubiger ein Eigenkapitalgeber; *die Anleihe erlischt*. Vorteil: Der Anleger profitiert von steigenden Kursen und akzeptiert dafür einen geringeren Zins. Problem: Für die Wandlung werden neue Aktien unter Ausschluss des Bezugsrechts ausgegeben (bedingte Kapitalerhöhung, 3.7), der Anteil der Altaktionäre wird *verwässert*.
#form[$ "Wandlungsverhältnis" = frac("Erhöhung der Aktienzahl", "Zahl der Wandelschuldverschreibungen") $]
Beispiel der Folie (Bösch): 100 Mio. € in 100.000 Stücken zu 1.000 €, Kupon 2 %, wandelbar in 10 Mio. Aktien mit 2 € Zuzahlung je Aktie. Wandlungsverhältnis 100: eine Anleihe + 200 € → 100 Aktien. Die Wandlung lohnt sich, sobald 100 Aktien mehr wert sind als 1.000 € + 200 €, also ab dem *kritischen Aktienkurs 12 €*. Darüber steigt der Preis der Wandelanleihe mit dem Aktienkurs (bei 14 €: 1.400 − 200 = 1.200 €).

#tab(columns: (1fr, 1fr, 1fr, 1.4fr),
 th([], [Aktie], [Anleihe], [Wandelanleihe]),
 [Beteiligung], [Teilhaberpapier], [Gläubigerpapier], [Gläubigerpapier],
 [Kapital], [EK], [FK], [vor Wandlung FK, danach EK],
 [Verzinsung], [schwankend], [fest], [fest, niedriger als Anleihe],
 [Rückzahlung], [nur Anteil am Liquidationserlös], [Anspruch auf Rückzahlung], [Rückzahlung oder Wandlung zu festem Preis in fester Frist],
 [Mitwirkung], [ja], [keine], [keine],
)

=== 2.20.2 Gewinnobligation und Genussschein <a-2-20-2>

Die *Gewinnobligation* zahlt zusätzlich zum festen Zins einen von der Dividende abhängigen Zusatzzins: Fremdkapital mit Erfolgsbeteiligung. Der *Genussschein* verbrieft Genussrechte, also Ansprüche am Reingewinn oder Liquidationserlös, aber als *Gläubigerrecht ohne Mitgliedschaftsrechte* (kein Stimmrecht), meist befristet. Beispiel der Folie: Genussscheine der Bertelsmann AG sind börsennotiert, während die Aktien in Privatbesitz sind. Vorteile: Haftungskapital wird beschafft (passiviert als Genussscheinkapital, keine Einlage); „Aktiensurrogat“ für nicht emissionsfähige Unternehmen. Besonderheit: gesetzlich nicht geregelt, jeder Genussschein ist anders, Risiken sind für Anleger schwer vergleichbar.

=== 2.20.3 Zerobond, Floater, Index- und Doppelwährungsanleihe <a-2-20-3>

Die *Null-Kupon-Anleihe (Zerobond)* zahlt keine laufenden Zinsen; sie wird weit unter dem Rückzahlungskurs ausgegeben, die Differenz ist der Zinsertrag. Für den Emittenten: keine laufende Liquiditätsbelastung, aber eine sehr hohe am Ende. Privatanleger versteuern erst bei Verkauf oder Einlösung (Zuflussprinzip), das stundet die Steuer.
#form[$ K_0 (1+r)^n = K_n quad arrow.r.double quad r = root(n, K_n/K_0) - 1 $]
$K_0$ = Kaufkurs, $K_n$ = Rückzahlung nach $n$ Jahren, $r$ = Rendite pro Jahr (Zinseszins). Beispiel der Folie: 7 Jahre, Kurs 65 %: $r = root(7, 100/65) - 1 approx "6,35" %$.

#tab(columns: (1.2fr, 2.6fr),
 th([Form], [Merkmal]),
 [*Floating Rate Notes*], [variabler Zins, alle 3 oder 6 Monate an einen Referenzzins angepasst (laut Folie LIBOR, EURIBOR) plus bonitätsabhängiger Auf- oder Abschlag. Der LIBOR wurde inzwischen eingestellt; heute dienen z. B. EURIBOR oder €STR (eigene Ergänzung).],
 [*Indexanleihen*], [Zins und/oder Tilgung hängen an einem benannten Index: Ölpreis, Inflationsrate, Aktienindex.],
 [*Doppelwährungsanleihen*], [an zwei Währungen gebunden: Zinsen meist in Euro, Rückzahlung in einer anderen, vertraglich festgelegten Währung. Währungsrisiko für den Anleger, dafür Zinsen über dem üblichen Kapitalmarktzins.],
)
#src[V, PDF-S. 87–93 (Folien 173–185); Vergleichstabelle nach Übung 5, V, PDF-S. 102 (Folie 204). LIBOR-Hinweis: eigene Ergänzung.]
#hoch(<a-2>, [Kapitelübersicht])

== 2.21 Exkurs: Bestimmungsfaktoren des Wechselkurses <a-2-21>

Die Doppelwährungsanleihe führt zur Frage, wovon Wechselkurse abhängen. Die Folien (nach Rübel, Monetäre Außenwirtschaft) nennen mehrere Erklärungsansätze:

#tab(columns: (1.3fr, 2.6fr),
 th([Ansatz], [Kernaussage]),
 [*Kaufkraftparität*], [Absolut: Wechselkurs = Verhältnis von In- zu Auslandspreisniveau. Relativ: Die prozentuale Wechselkursänderung entspricht der Differenz der Inflationsraten (solange Marktunvollkommenheiten konstant sind).],
 [*Produktivität*], [Das Land mit dem größeren Produktivitätsfortschritt bei handelbaren Gütern wertet real auf, das andere real ab.],
 [*Monetäre Theorie*], [Ungleichgewichte am Geldmarkt wirken auf den Devisenmarkt: Geldangebotsüberschuss → Abwertung, Geldnachfrageüberschuss → Aufwertung der Inlandswährung.],
 [*Finanzmarkttheorie*], [In- und ausländische Anlagen sind nicht vollkommen austauschbar. Wollen Anleger weniger Auslandsanlagen halten → Aufwertung; mehr → Abwertung der Inlandswährung.],
 [*Zinsparität*], [Bei vollkommener Austauschbarkeit bestimmen Zinsen und erwarteter Kurs den Kassakurs. Erwartete Abwertung oder höherer Auslandszins → Abwertung der Inlandswährung heute.],
 [*Überschießen*], [Zinsparität gilt sofort, Kaufkraftparität erst langfristig (träge Güterpreise). Nach einer Geldmengenerhöhung steigt der Kassakurs zunächst über seinen langfristigen Wert.],
 [*Weitere*], [Bei effizienten Märkten enthält der Terminkurs ggf. Risikoprämien; *spekulative Blasen* (immer größere Abweichung vom Fundamentalwert); technische Analyse, Herdenverhalten, Noise Trading.],
)
#note("Fehler vermeiden", [Bei Wechselkursen in Preisnotierung (Inlandswährung je Einheit Auslandswährung) bedeutet ein *steigender* Kurs eine *Abwertung* der Inlandswährung. Lies immer zuerst, welche Notierung gemeint ist. Eigene Erläuterung.], fill: sand)
#src[V, PDF-S. 93–97 (Folien 186–194).]
#hoch(<a-2>, [Kapitelübersicht])

== 2.22 Geldanlage aus Anlegersicht: Erträge, Kurse und Basispunkte <a-2-22>

Die Übungen 6–9 am Ende von Teil B wechseln die Perspektive: Was hat der *Anleger* von Anleihe, Aktie und Optionsschein?

#tab(columns: (1fr, 2fr),
 th([Begriff], [Bedeutung (Übungen 6, 7, 9)]),
 [Ertragsarten], [*Zinsen* (Sparkonto, Anleihe), *Dividenden* (nur Aktien), *Kursgewinne* (Wertsteigerung), *Währungsgewinne* (Fremdwährungsanlagen)],
 [Geld- und Briefkurs], [Gekauft wird zum *Briefkurs* (Ask), verkauft zum *Geldkurs* (Bid). Die Differenz heißt *Geld-Brief-Spanne* (Spread); wer sofort kauft und verkauft, verliert sie. Kleine Spanne = Markt schätzt den Wert einheitlich ein.],
 [Prozent und Prozentpunkte], [30 % → 33 % ist ein Anstieg um 10 *Prozent*, 30 % → 40 % um 10 *Prozentpunkte*.],
 [Basispunkte], [1 Basispunkt = 0,01 Prozentpunkte. 8 Basispunkte = 0,08 Prozentpunkte; 3 % plus 200 Basispunkte = 5 %.],
)

*Übung 8 (Herr Müller):* 800.000 € für ein Jahr; 5 % Optionsanleihe der Flama AG (Kurs mit Optionsschein 100 %, ohne 97,5 %, beides unverändert), je 2.000 € nominal ein Optionsschein auf eine Aktie zu 850 €; Aktie von 800 € auf 905 €, Dividende 40 €.

#tab(columns: (1.6fr, 1.6fr, 1fr),
 th([Variante], [Rechnung], [Gewinn]),
 [1.000 Aktien], [$1000 times (105 + 40)$], [145.000 €],
 [Optionsanleihe mit 400 Optionsscheinen], [Zins $5 % times 800000$ plus $400 times 5$ € Wertzuwachs der Scheine], [42.000 €],
 [Optionsanleihe ohne Schein (ca. 820.000 € nominal)], [$5 % times 820000$], [41.000 €],
 [16.000 Optionsscheine zu 50 €], [$16000 times 5$ €], [80.000 €],
)
Der Optionsschein kostet anfangs $(100 % - "97,5" %) times 2000 = 50$ € und ist am Jahresende $905 - 850 = 55$ € wert; daher 5 € Gewinn je Schein. Die Aktie bringt bei sicheren Daten den höchsten Gewinn. Weitere Kriterien: Wie sicher sind die Annahmen, welches Risiko will der Anleger tragen und wie schnell kommt er wieder an sein Geld?
#note("Nachgerechnet", [Für 800.000 € bekommt man bei 97,5 % genau $800000 / "0,975" approx "820.513"$ € nominal; die Folie rundet auf 820.000 €. Ein Kursrückgang des Optionsscheins hätte die Variante 4 (Hebel, vgl. 2.20.1) zur schlechtesten gemacht. Eigene Nachrechnung.], fill: sand)
#src[V, PDF-S. 103–107 (Folien 205–214).]
#hoch(<a-2>, [Kapitelübersicht])

#block(breakable: false)[
*Der Zusammenhang in Kapitel 2.* Feste Zahlungsansprüche erklären, warum der Gläubiger Bonität und Sicherheiten prüft. Rating und Bankkapital übersetzen Risiko in Bedingungen der Kreditvergabe; die Bank selbst refinanziert sich über Einlagen und die Zentralbank, deren Leitzins und die Zinsstruktur den Kreditpreis prägen. Der Vertrag legt Zahlungsfahrplan, Sicherheiten und Verhaltensgrenzen fest; Zinstage, Zinstermine, Auszahlung und Sondertilgungsrechte bestimmen die tatsächliche Belastung. Kurzfristig finanzieren Lieferantenkredit, Kontokorrent, Aval, Factoring und Lombard das Umlaufvermögen, langfristig Darlehen, Leasing, Schuldschein und Anleihen das Anlagevermögen. Hybride Anleihen verbinden Fremdkapital mit Aktienbezug und leiten zum Eigenkapital in Kapitel 3 über.
#src[V, PDF-S. 40–107; K, PDF-S. 1–2. Eigene Zusammenfassung des Kapitels.]
#hoch(<a-2>, [Kapitelübersicht])
]


#pagebreak()
#pagebreak()
= Kapitel 3 · Eigen- und Selbstfinanzierung <a-3>

#überblick([Kapitel 3 auf einen Blick],
 idee(<a-3-1>, [Gewinn behalten.], [Selbstfinanzierung ist einbehaltener Gewinn, offen als Rücklage oder still über stille Reserven.]),
 idee(<a-3-2>, [Aufwand ohne Auszahlung nutzen.], [Abschreibungen, Rückstellungen und Vermögensverkäufe setzen Geld frei, ohne neue Kapitalgeber.]),
 idee(<a-3-4>, [Rechtsform bestimmt die Regeln.], [Haftung, Mindestkapital und Kapitalerhaltung schützen die Gläubiger.]),
 idee(<a-3-5>, [Ausschüttung planen.], [Was ausgeschüttet wird, muss erst finanziert sein.]),
 idee(<a-3-7>, [Eigenkapital von außen.], [Kapitalerhöhung, Bezugsrecht, Kapitalherabsetzung und Cash Pooling im Konzern.]),
)
#karte((1fr, auto, 1fr, auto, 1fr),
 chunk([Innenfinanzierung], [offene und stille Selbstfinanzierung · Abschreibungen · Rückstellungen · Vermögensumschichtung], ziel: <a-3-1>),
 pfeil(beschriftung: [reicht nicht]),
 chunk([Außen: Eigenkapital], [Rechtsform · Mindestkapital · Kapitalerhöhung · Bezugsrecht], ziel: <a-3-4>),
 pfeil(beschriftung: [Gläubigerschutz]),
 chunk([Grenzen und Konzern], [Kapitalerhaltung · Ausschüttungsplan · Herabsetzung · Cash Pooling], ziel: <a-3-6>),
)
#hoch(<ueberblick>, [Modul auf einen Blick])

Kapitel 2 hat gezeigt, wie ein Unternehmen Geld leiht. Jetzt geht es um Geld, das nicht zurückgezahlt werden muss: einbehaltene Gewinne und Eigenkapital der Eigentümer. Die Lösungsstrategie: Erst fragen, ob der Zufluss von *innen* (Umsatzprozess) oder von *außen* (Eigentümer) kommt, dann, welche gesetzlichen Regeln für Ausschüttung und Kapital gelten. *Selbststudium:* Das Kapitel stammt aus den Folien 215–295 und war am 13.11.2026 noch nicht in der Vorlesung behandelt.
#src[V, PDF-S. 108–148 (Folien 215–295).]

== 3.1 Selbstfinanzierung: offen und still <a-3-1>

*Selbstfinanzierung* entsteht durch *Einbehaltung von Gewinnen (Thesaurierung)*. Gewinne, die weder als Ausschüttung an die Gesellschafter noch als Steuern abfließen, stehen dem Unternehmen zur Verfügung. Selbstfinanzierung ist zugleich *Eigen- und Innenfinanzierung* (vgl. 1.2).

#bild("map-selbstfinanzierung", [Mindmap: vier Wege der Innenfinanzierung. Eigene Darstellung nach V, PDF-S. 108–113.], height: 44mm)

#tab(columns: (1fr, 1.5fr, 1.5fr),
 th([], [Offene Selbstfinanzierung], [Stille Selbstfinanzierung]),
 [Erkennbar?], [im Jahresabschluss sichtbar, aus *versteuertem* Gewinn], [nicht sichtbar, beruht auf *stillen Reserven*],
 [Wo?], [Einzelfirma, OHG, KG: Kapitalkonten (ohne Entnahmen); GmbH, AG, KGaA, SE: Gewinnrücklagen, ggf. Gewinnvortrag], [Aktiv: Nichtaktivierung oder zu niedrige Bewertung; Passiv: zu hohe Wertansätze (Rückstellungen)],
 [Beispiel der Folie], [Ein zur Ausschüttung vorgesehener Bilanzgewinn wirkt bis zur Zahlung als *temporäre* Selbstfinanzierung: Bei Ausschüttung zum Jahresende arbeitet man im Schnitt mit etwa der Hälfte des Gewinns.], [AfA 20.000 € bei Wertverlust 16.000 € → Potenzial 4.000 €. Prozessrückstellung 20.000 €, nötig nur 14.000 € → Potenzial 6.000 €.],
)
Stille Reserven *mindern im Jahr der Bildung den ausgewiesenen Gewinn*. Das schont die Liquidität doppelt: Es muss weniger ausgeschüttet werden, und die Ertragsteuern sinken. Das ist eine *Steuerstundung*, denn die spätere Auflösung erhöht Gewinn und Steuer wieder.

#tab(columns: (1fr, 1.6fr, 1.6fr),
 th([Kriterium], [Vorteile], [Nachteile]),
 [Rentabilität], [keine Beschaffungs- und Zinskosten; Steuerstundung bringt zinslose Mittel], [keine externe Kontrolle → Gefahr weniger rentabler Projekte; Ertragsteuern schmälern den einbehaltenen Gewinn, kein Leverage-Effekt],
 [Liquidität], [keine Liquiditätsabflüsse], [Zufluss eng begrenzt (nur so viel, wie verdient wird)],
 [Sicherheit], [stärkt die Eigenkapitalbasis], [Gefahr riskanter Investitionen ohne Kontrolle],
 [Unabhängigkeit], [keine externen Kapitalgeber, keine Vorgaben, keine Sicherheiten, flexiblere Konditionen], [–],
)
#note("Fehler vermeiden", [Gewinn ist nicht gleich Geld (1.4). Einbehaltener Gewinn finanziert nur, wenn er als Zahlungsüberschuss tatsächlich im Unternehmen ist. Die Übung 3 nennt genau das als Problem: „Gewinne sind in der Regel nur als Buchgewinne vorhanden, nicht als liquide Mittel.“], fill: sand)
#src[V, PDF-S. 108–110 (Folien 216–220); V, PDF-S. 117 (Folie 233).]
#hoch(<a-3>, [Kapitelübersicht])

== 3.2 Finanzierung aus Abschreibungen, Rückstellungen und Vermögensumschichtung <a-3-2>

=== 3.2.1 Abschreibungen <a-3-2-1>

Abschreibungen erfassen den Wertverlust des Anlagevermögens als Aufwand, ohne dass in dieser Periode Geld abfließt. Ein *Finanzierungseffekt* entsteht, wenn die Abschreibungen in die Verkaufspreise einkalkuliert sind und die Umsatzerlöse mindestens die Selbstkosten decken. Dann fließen die Abschreibungen als Einzahlungen zurück:

#karte((1fr, auto, 1fr, auto, 1fr, auto, 1fr),
 chunk([Abschreibung buchen], none), pfeil(),
 chunk([als Produktkosten erfassen], none), pfeil(),
 chunk([Umsatzerlöse aus dem Verkauf], none), pfeil(),
 chunk([Rückfluss als Einzahlung], none),
)
Die Folie nennt zwei Effekte: den *Kapitalfreisetzungseffekt* (zurückgeflossene Abschreibungen sind bis zur Ersatzinvestition frei verfügbar) und den *Kapazitätserweiterungseffekt*: Werden die zurückgeflossenen Beträge sofort in gleichartige Anlagen investiert, wächst der Maschinenbestand ohne neues Kapital. In der Übung 1 (Expans AG, Aufgaben) wächst der Bestand von 10 auf bis zu 20 Maschinen, pendelt aber nach dem Ausscheiden der ersten Maschinen bei 14–15. Eine Umsatzsteigerung um 65 % (17 Maschinen) im 7. Jahr lässt sich deshalb nicht allein aus Abschreibungen finanzieren.
#note("Gültigkeit", [Der Kapazitätserweiterungseffekt setzt voraus: Abschreibungen werden über die Preise verdient, sofort reinvestiert, die Anlagen sind beliebig teilbar bzw. in ganzen Stück kaufbar, Preise bleiben gleich, und das Umlaufvermögen wächst nicht mit. Eigene Präzisierung.], fill: sand)

=== 3.2.2 Rückstellungen <a-3-2-2>

*Rückstellungen* sind ungewisse Verbindlichkeiten, unsicher nach Grund, Höhe und/oder Fälligkeit (statische Sicht). Dynamisch gesehen sind es Aufwendungen der jetzigen Periode, die erst später wahrscheinlich zu Auszahlungen führen; sie dienen der periodengerechten Aufwandszuordnung. Nach § 249 HGB zulässig sind u. a. Rückstellungen für ungewisse Verbindlichkeiten, drohende Verluste aus schwebenden Geschäften, unterlassene Instandhaltung und Abraumbeseitigung sowie Gewährleistungen. In der Bilanz (§ 266 Abs. 3 HGB) stehen drei Posten: *Pensionsrückstellungen*, *Steuerrückstellungen*, *sonstige Rückstellungen*. Fällt der Grund weg, werden sie gewinnerhöhend aufgelöst.

*Finanzierungswirkung:* Der Rückstellungsaufwand fließt über die Umsatzerlöse zurück, die Auszahlung kommt aber erst später. Der Effekt ist umso stärker, je höher das Volumen und je länger der Zeitraum zwischen Bildung und Inanspruchnahme. Er wirkt unabhängig von der Gewinnverwendung. Besonders wichtig sind *Pensionsrückstellungen* (langfristig, hohes Volumen).

=== 3.2.3 Vermögensumschichtung <a-3-2-3>

Bei der *Vermögensumschichtung* verkauft das Unternehmen Vermögen außerhalb des normalen Umsatzprozesses: Sachgüter (Grundstücke, Maschinen, Vorräte), immaterielle Güter (Patente, Lizenzen) oder Finanzwerte (Beteiligungen, Aktien). Zum Buchwert verkauft ist das ein *Aktivtausch*: Vermögen wird zu Bankguthaben, die Passivseite bleibt gleich. Werden mit dem Geld Schulden getilgt, entsteht eine *Bilanzverkürzung*, und die *Eigenkapitalquote steigt*.

#tab(columns: (1.4fr, 1fr, 1fr),
 th([Beispiel der Folie (Tsd. €)], [vor Verkauf], [nach Verkauf]),
 [Übrige Aktiva / Fuhrpark / Liquide Mittel], [430 / 130 / 140], [430 / 120 / 150],
 [Eigenkapital / Fremdkapital], [220 / 480], [220 / 480],
 [Bilanzsumme], [700], [700],
)
#src[V, PDF-S. 111–114 (Folien 221–227). Gültigkeitskasten: eigene Präzisierung.]
#hoch(<a-3>, [Kapitelübersicht])

== 3.3 Selbst-, Beteiligungs- oder Kreditfinanzierung? <a-3-3>

Die Übung 2 der Folien vergleicht die drei Grundformen. *Selbstfinanzierung* = einbehaltene Gewinne (innen); *Beteiligungsfinanzierung* = Eigentümer geben Kapital von außen (Eigenkapital); *Kreditfinanzierung* = Kapital wird geliehen (Fremdkapital).

#tab(columns: (1.8fr, 1fr, 1fr, 1fr),
 th([Merkmal laut Folie], [Selbst], [Beteiligung], [Kredit]),
 [Unabhängig von Kapitalgebern], [ja], [nein], [nein],
 [Beteiligungsverhältnisse unberührt], [ja], [nein], [ja],
 [auch in „schlechten Zeiten“ möglich], [bedingt], [nein], [bedingt],
 [keine Zinszahlungen], [ja], [ja], [nein],
 [keine Dividenden], [nein], [nein], [ja],
 [keine Rückzahlung], [ja], [ja], [nein],
 [begünstigt FK-Aufnahme], [ja], [ja], [nein],
 [steuerliche Vorteile], [bedingt], [nein], [ja],
 [Nachteil: kurzfristig geringere Rendite für Kapitalgeber], [ja], [ja], [nein],
 [Nachteil: geringere EK-Rendite (Leverage)], [ja], [ja], [nein],
)
*Bedeutung der Selbstfinanzierung (Übung 3):* Der wachsende Kapitalbedarf lässt sich nicht nur von außen decken (Börse unsicher, zu viel FK wird riskant und teuer). Beteiligungsverhältnisse bleiben gleich, die Liquidität wird geschont, stille Reserven stunden Steuern und vermeiden auf den einbehaltenen Teil die Doppelbesteuerung (Gesellschaft und Aktionär), und in Inflationszeiten erhält sie die Substanz. *Probleme:* verärgerte Aktionäre bei zu geringer Dividende, Gewinne oft nur als Buchgewinn vorhanden, sinkende EK-Rendite (negativer Leverage-Effekt). *Gefahren der verdeckten (stillen) Selbstfinanzierung:* Bei Verlusten werden stille Reserven aufgelöst, und Dividenden greifen die Substanz an; Verluste lassen sich verschleiern, die Risikobereitschaft steigt, die wahre Lage bleibt Anlegern verborgen.
#note("Typische Tabellenlücke", [Die Zellen der Folie 230 sind im Export teils verschoben; die Tabelle oben ist die eigene, inhaltlich geprüfte Zuordnung nach der Logik der drei Formen (z. B. Kredit: Zinsen ja, Dividenden nein, Rückzahlung ja). Lerne die Begründung, nicht die Tabelle auswendig.], fill: sand)
#src[V, PDF-S. 114–117 (Folien 228–233). Zellzuordnung Folie 230: eigene Rekonstruktion.]
#hoch(<a-3>, [Kapitelübersicht])

== 3.4 Rechtsform, Eigenkapital und Eigenkapitalbeschaffung <a-3-4>

Die Rechtsform legt die Finanzierungsregeln fest. Die Folie nennt neun Aspekte: Mindesteigenkapital, Haftung, Nachschusspflichten, Trennung von Eigentum und Geschäftsführung, Kapitalzuführung und Finanzierungsalternativen, Eigentumsrechte, Bilanzierungs- und Publizitätspflichten, Regeln für Gewinnentnahmen sowie Ein- und Austritt von Gesellschaftern.

#tab(columns: (1fr, 1.5fr, 1.5fr, 1.5fr),
 th([], [Einzelunternehmen], [GmbH], [AG]),
 [Haftung], [persönlich, unbeschränkt], [nur in Höhe der Stammeinlage], [nur in Höhe der Einlage (Aktie)],
 [Mindestkapital], [keines], [Stammkapital 25.000 €], [Grundkapital 50.000 €],
 [Gewinnentnahme], [unbeschränkt], [Ausschüttungssperren, Erhaltungsgebot § 30 GmbHG], [Ausschüttungssperren (z. B. § 150 AktG), Erhaltungsgebot § 57 AktG],
 [Leitung], [Eigentümer allein], [Geschäftsführer (können Gesellschafter sein)], [Trennung Eigentum / Kontrolle (Vorstand)],
 [Kapital, Wechsel], [Privatvermögen und nicht entnommene Überschüsse], [Nachschusspflicht vereinbar; Anteile nicht verbrieft, Übertragung notariell], [keine Nachschusspflicht; Aktien formlos übertragbar, Zugang zum Kapitalmarkt],
 [Organe, Publizität], [–], [Gesellschafterversammlung], [Hauptversammlung; umfangreiche Publizität],
)

*Eigenfinanzierung im engen Sinn:* Bisherige Eigentümer führen Eigenkapital von außen zu. Kommen neue Gesellschafter hinzu, spricht man von *Beteiligungsfinanzierung*. Eigenkapital sind die zeitlich unbegrenzt überlassenen Mittel der Eigentümer, von außen (Einlage) oder von innen (Gewinnverzicht).

#tab(columns: (1fr, 2.5fr),
 th([Begriff], [Zusammensetzung]),
 [Nominalkapital], [Grund- oder Stammkapital],
 [Rechnerisches EK], [Grund-/Stammkapital + Rücklagen ± Gewinn bzw. Verlust],
 [Effektives EK], [rechnerisches EK + *stille Reserven*],
)
Bei Kapitalgesellschaften sind die *Rücklagen das variable Eigenkapital*: Sie fangen Verluste auf, ohne das konstante Nominalkapital anzugreifen.

*Eigenkapitalbeschaffung* unterscheidet sich nach der Emissionsfähigkeit. *Nicht emissionsfähige* Unternehmen (Einzelunternehmen, OHG, KG, GmbH, „kleine AG“) müssen den Eintrittspreis eines neuen Gesellschafters aushandeln, ihn auf gewinnberechtigten Kapitalanteil und Aufgeld (*Agio*) aufteilen und Kontroll- und Gewinnrechte im Gesellschaftsvertrag regeln. *Emissionsfähige* Unternehmen (AG, KGaA) beschaffen Eigenkapital über die Börse.

=== 3.4.1 Aktien: Kauf, Aktienart und Börsengang <a-3-4-1>

*Aus Anlegersicht* verteuern Transaktionskosten den Aktienkauf. Der *Break-even-Kurs* ist der Kurs, ab dem Kauf- und Verkaufskosten verdient sind:
#form[$ "Break-even-Kurs" = "Kaufkurs" + frac("Kosten Kauf" + "Kosten Verkauf", "Stückzahl") $]
Kosten als Ordergebühr plus Handelsplatzentgelt; Mindest- und Höchstgebühren beachten; die Verkaufskosten hängen eigentlich vom Verkaufskurs ab (Folie: näherungsweise gleich). Beispiel der Folie: Kauf zu 40 €, bei 400 € Anlage Break-even 42 €, bei 4.000 € nur 40,32 €, weil die Mindestgebühr kleine Orders stark belastet.

#tab(columns: (1fr, 1.5fr, 1.5fr),
 th([], [Inhaberaktie], [Namensaktie]),
 [Rechtsstatus], [Inhaberpapier], [Orderpapier],
 [Übertragung], [durch bloße Übergabe], [mit Eintrag ins Aktienregister],
 [Eigentümer], [der Gesellschaft nicht bekannt], [der Gesellschaft bekannt],
)
*Vinkulierte Namensaktien* dürfen nur mit Zustimmung der Gesellschaft übertragen werden; so hält man unerwünschte Aktionäre fern. Betriebswirtschaftlich steuert die Aktienart *Unabhängigkeit* (Einfluss), *Aktionärsbindung* und *Handelbarkeit* (Inhaberaktien erreichen ein breiteres Publikum).

Beim *Going Public* wird eine private AG zur Publikumsgesellschaft. Der Ausgabepreis entsteht entweder als *fester Ausgabekurs* oder im *Bookbuilding-Verfahren* (Auktionsprinzip: Zeichner nennen Menge und Preis, der endgültige Preis wird nach der Zeichnungsfrist festgelegt).

#tab(columns: (0.8fr, 1.6fr, 1.6fr),
 th([], [Fester Ausgabekurs], [Bookbuilding]),
 [Vorteile], [geringes Risiko; „Geschenke“ an künftige Aktionäre über niedrigen Kurs; mehr Einfluss; einfacher; Mitarbeiterbeteiligung planbar], [berücksichtigt Kapitalmarktlage; vermeidet zu hohen oder zu niedrigen Kurs; Preisvorstellungen der Anleger fließen ein],
 [Nachteile], [Marktstimmung schwer zu schätzen; zu hoch → nicht alles platzierbar; zu niedrig → Agio verschenkt, Zeichner verärgert], [höheres Risiko; tendenziell höhere Kurse; kaum kurzfristige Börsengewinne; kein Einfluss des Unternehmens auf den Preis],
)
#src[V, PDF-S. 117–120 (Folien 234–239); V, PDF-S. 139–141 (Folien 277–281).]
#hoch(<a-3>, [Kapitelübersicht])

== 3.5 Ausschüttungspolitik <a-3-5>

*Ausschüttung* ist der Teil des Gewinns, der an die Anteilseigner verteilt wird (AG: Dividende, GmbH: Gewinnausschüttung). *Dividendenpolitik* umfasst alle Ziele und Maßnahmen dazu: ob und wie viel ausgeschüttet wird. Grundsatzentscheidung: *kontinuierliche (stabile)* oder *variable (gewinnorientierte)* Dividende.

#tab(columns: (1fr, 1fr),
 th([Interne Bestimmungsgrößen], [Externe Bestimmungsgrößen]),
 [Gesetz und Satzung · künftiger Kapitalbedarf · Liquidität · bisherige Dividendenpolitik], [Wünsche der Aktionäre · Dividendenpolitik der Konkurrenz · Erträge der Anlagealternativen · Wirkung auf Gewerkschaften],
)
*Stabile Dividende:* verhindert spekulative Börsengeschäfte, passt zu langfristigen Anlegern. *Gewinnabhängige Dividende:* Die Aktie ist ein Risikopapier, der Aktionär soll am guten Geschäftsgang teilhaben; andere Faktoren können trotzdem berücksichtigt werden.

=== 3.5.1 Ausschüttung und Finanzplan: das Beispiel Value AG <a-3-5-1>

Eine Ausschüttung ist eine Auszahlung. Sie ist nur möglich, wenn der Finanzplan sie trägt. Die Folien rechnen mit der Value AG (Drukarczyk/Schüler): Umsatz und betriebliche Aufwendungen sind zahlungsgleich, Abschreibungen und Pensionszuführungen nicht. Die Steuern sind vereinfacht: Gewerbeertragsteuer 14 % auf Ergebnis vor Steuern plus 25 % der Zinsen, Körperschaftsteuer 15 % auf das Ergebnis vor Steuern, Abgeltungsteuer 25 % beim Aktionär.

#form[$ "entziehbarer Überschuss" &= "Umsatz" - "zahlungswirksame Aufwendungen" - "Zinsen" - "Steuern" \ &quad - "Investitionen" - Delta "NWC" - "Tilgung" - "Rentenzahlungen" $]
Alles in derselben Periode und Währung; nur Zahlungen, keine Abschreibungen oder Rückstellungszuführungen. Für Jahr 1 ergeben sich 1.420,2 T€ verfügbarer Zahlungsüberschuss. Die Folie teilt ihn in Abgeltungsteuer (531,9) und Ausschüttung (888,3) auf; das ist der entziehbare Überschuss, ohne neues Fremdkapital aufzunehmen.

Soll dagegen der *ganze Jahresüberschuss* (2.127,6 T€) ausgeschüttet werden (Vollausschüttung), reicht das Geld nicht: Es entsteht ein Finanzierungsdefizit von $"1420,2" - "2127,6" = -"707,4"$ T€, das durch Kredit gedeckt werden muss. Im Jahr 2 sind es 900 bzw. 750,2 T€.

#note("Fehler in der Folie", [Folie 248 nennt als „Thesaurierung“ 647,4 bzw. 551,0 T€. Aus den eigenen Zahlen der Folie folgt aber $"2127,6" - "531,9" - "888,3" = "707,4"$ T€ bzw. $"2200,3" - "550,1" - 900 = "750,2"$ T€, genau die „Rücklagenzuführung“ der großen Tabelle (Folie 245). Die Folienwerte sind um die NWC-Erhöhung (60 bzw. 199,2) zu klein. Außerdem wird die Abgeltungsteuer im Plan auf den vollen Jahresüberschuss gerechnet, obwohl nicht alles ausgeschüttet wird; das ist eine Vereinfachung der Quelle. Eigene Nachrechnung.], fill: sand)
#src[V, PDF-S. 120–126 (Folien 240–251). Nachrechnung: eigene Prüfung.]
#hoch(<a-3>, [Kapitelübersicht])

== 3.6 Mindestkapital und Kapitalerhaltung <a-3-6>

*GmbH:* Stammkapital mindestens 25.000 € (§ 5 Abs. 1 GmbHG); bei Gründung muss nur die Hälfte eingezahlt sein. Die bei der GmbH-Reform (MoMiG) geplante Senkung auf 10.000 € kam nicht. Alternativ die *UG (haftungsbeschränkt)* nach § 5a GmbHG mit theoretisch 1 € Mindestkapital („Mini-GmbH“). *AG:* Grundkapital mindestens 50.000 € (§ 7 AktG).

#note("Landläufiger Irrtum", [Das Stammkapital ist *keine Sicherungseinlage*, die auf dem Konto liegen bleibt. Das eingezahlte Kapital darf für Ausgaben im Rahmen des Unternehmenszwecks verwendet werden. Unzulässig ist nur die Rückzahlung an die Gesellschafter. Es kann auch durch Sacheinlagen erbracht werden. Tritt ein Gesellschafter vor voller Einzahlung aus, haften die übrigen.], fill: sand)

Die *Kapitalerhaltung* (§ 30 GmbHG) ist das Kernstück des Gläubigerschutzes: Das zur Erhaltung des Stammkapitals erforderliche Vermögen darf nicht an die Gesellschafter ausgezahlt werden. Gewinne werden nur ausgezahlt, wenn dabei das Stammkapital nicht angegriffen wird. Eingezahlte Nachschüsse dürfen zurückgezahlt werden.
#form[$ "Stammkapital angegriffen, wenn:" quad "Aktiva" - "Verbindlichkeiten" < "Nennbetrag des Stammkapitals" $]
Das Zitat der Folie (Hemmer/Wüst/Seuffert) betont: Die Regeln verhindern nicht, dass das Kapital durch Verluste verloren geht; sie verhindern nur, dass es durch offene oder verdeckte Ausschüttungen aufgebraucht wird.

#tab(columns: (1fr, 1fr),
 th([AG: sehr streng], [GmbH: flexibler]),
 [jede Einlagenrückgewähr verboten (§ 57 Abs. 1, 2 AktG); vor Auflösung nur Ausschüttung des Bilanzgewinns (§ 57 Abs. 3 AktG); Erwerb eigener Aktien grundsätzlich verboten (§§ 71–71e AktG)], [Stammkapital wird passiviert; ausschüttbar ist nur das Reinvermögen über dem Stammkapital (§ 29 GmbHG); eigene Anteile nur aus Vermögen über dem Stammkapital (§ 33 GmbHG)],
)
#src[V, PDF-S. 126–128 (Folien 252–256).]
#hoch(<a-3>, [Kapitelübersicht])

== 3.7 Kapitalerhöhung und Bezugsrecht <a-3-7>

Die *Kapitalerhöhung* (Eigenkapitalerhöhung) führt Eigenkapital von außen zu und ist damit *Eigen- und Außenfinanzierung*. Bisherige Gesellschafter stocken auf oder neue treten ein; die Motive sind finanziell und/oder strategisch.

#bild("map-kapitalerhoehung", [Mindmap: vier Formen der Kapitalerhöhung und die Kapitalherabsetzung. Eigene Darstellung nach V, PDF-S. 129–134.], height: 44mm)

#tab(columns: (1.3fr, 2.6fr),
 th([Form (AG)], [Merkmal]),
 [*1 Gegen Einlagen* (ordentliche, §§ 182–191 AktG)], [Neue Mittel als Geld- oder Sacheinlage durch neue Aktien. Satzungsänderung, Tagesordnung der HV, bei Ausgabe über Nennwert Mindest-Bezugskurs im Beschluss, Eintragung ins Handelsregister. *Sacheinlagen:* Wert muss geprüft werden (ökonomischer Wert, nicht Nominalwert); bei Gründung detaillierte Gründungsprüfung (§§ 23–53 AktG).],
 [*2 Bedingte* (§§ 192–201 AktG)], [Neue Aktien bis zur Hälfte des Grundkapitals, nur für drei Zwecke: Umtausch-/Bezugsrechte aus *Wandelanleihen*, Vorbereitung einer *Fusion*, Bezugsrechte für *Arbeitnehmer und Geschäftsführung*. Die jungen Aktien gehen an Nichtaktionäre; Altaktionäre haben kein Bezugsrecht.],
 [*3 Genehmigtes Kapital* (§§ 202–206 AktG)], [Ermächtigung des Vorstands für höchstens 5 Jahre („Blankovollmacht“) durch Satzung oder HV-Beschluss mit ¾-Mehrheit; höchstens 50 % des Grundkapitals; Ausgabe nur mit Zustimmung des Aufsichtsrats.],
 [*4 Aus Gesellschaftsmitteln* (§§ 207–220 AktG)], [*Kein neues Geld:* Kapital- oder Gewinnrücklagen werden in Grundkapital umgewandelt (Passivtausch). ¾-Mehrheit der HV, Eintragung, Bilanz festgestellt und geprüft, Stichtag höchstens 8 Monate vor Anmeldung (sonst Zwischenbilanz). Gesetzliche Rücklage + Kapitalrücklage müssen danach noch mindestens 10 % des Grundkapitals sein. Die Altaktionäre erhalten *Gratisaktien*; der Marktwert bleibt gleich, verteilt sich auf mehr Aktien, der Kurs sinkt.],
)
Bei der GmbH gibt es die Kapitalerhöhung gegen Einlagen (§§ 55–57b GmbHG: Übernahme neuer Stammeinlagen mit notarieller Beurkundung, vor Anmeldung mindestens ein Viertel eingezahlt) und aus Gesellschaftsmitteln (Umwandlung von Rücklagen).

=== 3.7.1 Bezugsrecht <a-3-7-1>

Das *Bezugsrecht* (§ 186 Abs. 1 AktG) gibt jedem Aktionär Anspruch auf den Anteil an den neuen Aktien, der seiner bisherigen Quote am Grundkapital entspricht. Zweck: ungewollte *Stimmrechtsverschiebungen* verhindern und *Vermögensnachteile* der Altaktionäre ausgleichen, die entstehen, wenn junge Aktien unter dem Börsenkurs ausgegeben werden. Ein *Bezugsrechtsausschluss* ist möglich, wenn er ordnungsgemäß in der Tagesordnung angekündigt ist, ¾ des vertretenen Grundkapitals zustimmen und der Vorstand einen schriftlichen Bericht über den Grund vorlegt.

Die Altklausur 2017 (Aufgabe 2) verlangt den *rechnerischen Wert des Bezugsrechts* und den *Mischkurs*. Die Folien nennen diese Formeln nicht; sie stehen hier als Klausurergänzung:
#form[$ B = frac(K_"alt" - K_"neu", m/n + 1) quad quad K_"misch" = frac(m K_"alt" + n K_"neu", m + n) = K_"alt" - B $]
$K_"alt"$ = Börsenkurs vor der Erhöhung, $K_"neu"$ = Ausgabekurs der jungen Aktien, $m : n$ = Bezugsverhältnis (m alte berechtigen zu n jungen Aktien), ohne Dividendennachteil und Kosten. Bilanziell geht der Nennwert der jungen Aktien ins Grundkapital, das Agio (Ausgabekurs − Nennwert) in die Kapitalrücklage.
#note("Selbst erklären", [Warum verliert ein Altaktionär nichts, obwohl der Kurs nach der Erhöhung sinkt? *Antwort:* Er kann sein Bezugsrecht verkaufen. Der Erlös gleicht den Kursrückgang genau aus, denn $K_"misch" = K_"alt" - B$.])
#src[V, PDF-S. 129–133 (Folien 257–265); Formeln Bezugsrecht/Mischkurs: Lösung zur Altklausur K, PDF-S. 3 (Aufgabe 2), nicht auf den Folien.]
#hoch(<a-3>, [Kapitelübersicht])

== 3.8 Kapitalherabsetzung <a-3-8>

*Kapitalherabsetzung* ist im weiteren Sinn jede Verringerung des Eigenkapitals, im engeren Sinn die Verringerung des gezeichneten Kapitals einer Kapitalgesellschaft, meist zur *Sanierung* in der Krise.

*Beispiel der Folie (Y-AG, Tsd. €):* AV 3.200, UV 3.000; gezeichnetes Kapital 4.000, FK 3.000, Jahresfehlbetrag 800. Nennwert 50 € je Aktie, Kurs 25 €. Die AG verkauft ein Grundstück (Buchwert 1.000) und kauft damit 40.000 eigene Aktien zu 25 € zurück, die eingezogen werden.

#tab(columns: (2fr, 1fr),
 th([Schritt], [Betrag]),
 [Grundkapital sinkt um den Nennbetrag (§ 238 AktG): $40000 times 50$ €], [2.000.000 €],
 [bezahlt wurden nur $40000 times 25$ €], [1.000.000 €],
 [Buchgewinn = (Nennwert − Kurs) × Stück → Kapitalrücklage (§§ 229, 232 AktG)], [1.000.000 €],
 [davon Ausgleich des Jahresfehlbetrags], [−800.000 €],
 [verbleibende Kapitalrücklage], [200.000 €],
)
Bilanz danach: AV 2.200, UV 3.000 = 5.200; gezeichnetes Kapital 2.000, Kapitalrücklage 200, FK 3.000 = 5.200. Der Verlust ist beseitigt, das Grundkapital passt wieder zum Vermögen.
#src[V, PDF-S. 133–134 (Folien 266–268).]
#hoch(<a-3>, [Kapitelübersicht])

== 3.9 Konzern und Cash Pooling <a-3-9>

Ein *Konzern* (§ 18 AktG) liegt vor, wenn ein herrschendes und ein oder mehrere abhängige Unternehmen unter *einheitlicher Leitung* stehen (Unterordnungskonzern), oder wenn rechtlich selbstständige, nicht abhängige Unternehmen einheitlich geleitet werden (Gleichordnungskonzern). Bei Beherrschungsvertrag oder Eingliederung wird einheitliche Leitung angenommen; bei Abhängigkeit wird ein Konzern vermutet.

*Rechtsfolgen:* umfassendes *Weisungsrecht* des herrschenden Unternehmens (§ 308 AktG), aber keine existenzgefährdenden Weisungen und keine Pflicht zur Befolgung bei offensichtlich fehlendem Konzerninteresse. Im Gegenzug übernimmt es die wirtschaftliche Verantwortung: *Ausgleich des Jahresfehlbetrags* der abhängigen AG (§ 302 AktG). Das Mutterunternehmen muss einen *Konzernabschluss* (konsolidiert) aufstellen (§ 290 HGB).

*Cash Pooling* ist die *Liquiditätsbündelung* im Konzern über das Cash Management der Mutter. Technisch verwaltet ein zentraler „Master Account“ Geldanlagen und Kredite der Töchter: Überschüssige Liquidität wird per Darlehen in die Mutter „gepumpt“, Unterdeckungen gleicht die Mutter durch Kredite aus.
#tab(columns: (1.3fr, 2.5fr),
 th([Vorgang bei der Tochter], [Bilanzwirkung]),
 [Geldanlage im Pool], [*Aktivtausch*: Konzernforderung statt Bankguthaben],
 [Kreditaufnahme zur Umfinanzierung], [*Passivtausch*: Konzernverbindlichkeit statt Bankverbindlichkeit],
 [Kreditaufnahme für Investitionen], [*Aktiv-Passiv-Mehrung*],
)
Vorteil: Die Mutter verwaltet die Liquidität zentral und damit kostensparend für alle Töchter (weniger teure Kontokorrentkredite bei gleichzeitigen Guthaben).
#src[V, PDF-S. 135–137 (Folien 269–273). Klammerzusatz zum Vorteil: eigene Erläuterung.]
#hoch(<a-3>, [Kapitelübersicht])

== 3.10 Kapitalstruktur: Rentabilität, Leverage und Finanzierungsregeln <a-3-10>

Die Übungen am Ende von Kapitel C wenden Kennzahlen aus 1.10–1.12 auf Finanzierungsentscheidungen an.

*Rentabilität mit Durchschnittskapital:* Fällt der Jahresgewinn gleichmäßig über das Jahr an, steigt auch das Eigenkapital gleichmäßig. Dann rechnet man mit dem *durchschnittlichen* Kapital (Anfang + halber Jahresgewinn). Fällt der Gewinn erst am Jahresende an, gilt das Anfangskapital.
#form[$ r_"GK" = frac("Gewinn" + "FK-Zinsen", "Ø Gesamtkapital") quad quad r_"EK" = frac("Gewinn", "Ø Eigenkapital") $]

*Break-even beim Leverage:* Ersetzt ein Unternehmen Eigenkapital durch Fremdkapital, lohnt sich das nur, wenn der Bruttogewinn (vor Zinsen) hoch genug ist. Gleichsetzen der EK-Renditen beider Varianten:
#form[$ frac(G - r_(f 1) "FK"_1, "EK"_1) = frac(G - r_(f 2) "FK"_2, "EK"_2) $]
$G$ = Bruttogewinn vor Zinsen und Steuern, $r_f$ = durchschnittlicher FK-Zins der Variante. Ein proportionaler Steuersatz $s$ kürzt sich heraus (Faktor $1-s$ auf beiden Seiten): Der Break-even hängt nicht vom Steuersatz ab. Darüber ist die stärker verschuldete Variante besser.

*Anleihe oder Kapitalerhöhung?* Die Folien beurteilen nach *Rentabilität* (Leverage spricht für FK, solange der Projektgewinn die Zinsen übersteigt), *Liquidität* (Anleihe belastet mit Zins und Rückzahlung, Dividenden sind anpassbar), *Risiko* (riskantes Projekt → eher EK), *Flexibilität* (starke EK-Basis erleichtert spätere Kredite), *Verfügungsmacht* (bei der Familien-AG bleibt sie mit EK der Familie gewahrt, bei breiter Kapitalerhöhung eher mit der Anleihe), *Finanzimage* und *Kapitalmarktlage*. Eine hohe Verschuldung kann Kreditwürdigkeit kosten, Fremdbestimmung und Liquiditätsbelastung bringen.

*Grenzen von Finanzierungsregeln* (z. B. goldene Bilanzregel, EK : FK zwischen 1 : 1 und 2 : 1): Sie sind nur allgemeine Hinweise, branchenabhängig, durch Gesetz und Kultur eingeschränkt, oft einseitig (nur Fristenkongruenz), vernachlässigen Kosten und Rentabilität, sagen wenig über die tatsächliche Liquidität und sind *statisch* (stichtagsbezogen).
#note("Fehler in der Quelle", [Bei der Koslin AG (Aufgabe 5) rechnet das Lehrbuch die neue 10-%-Anleihe mit nur 5 % Zins; der Professor hat das auf der Folie vermerkt („Fehler im Buch … Aber: Kontinuität“). Mit 10 % beträgt der Reingewinn 21 statt 23,5 Mio. €, die EK-Rendite 17,5 % statt 19,6 %; das Ergebnis (Anleihe hat die höhere EK-Rendite) bleibt. Bei der Schlux AG (Aufgabe 1 a) ergibt $(300 + 80)/3250$ 11,7 % statt der gedruckten 11,5 %. Eigene Nachrechnung.], fill: sand)
#src[V, PDF-S. 137–148 (Folien 274–295). Nachrechnung: eigene Prüfung.]
#hoch(<a-3>, [Kapitelübersicht])

#block(breakable: false)[
*Der Zusammenhang in Kapitel 3.* Zuerst finanziert sich ein Unternehmen aus eigener Kraft: über einbehaltene Gewinne, über Abschreibungen und Rückstellungen, deren Aufwand vor der Auszahlung über die Preise zurückfließt, und über den Verkauf von Vermögen. Reicht das nicht, kommt Eigenkapital von außen. Die Rechtsform legt fest, wie: Mindestkapital, Haftung und Kapitalerhaltung schützen die Gläubiger und begrenzen Ausschüttungen, die außerdem durch den Finanzplan gedeckt sein müssen. Bei der AG führen Kapitalerhöhung und Bezugsrecht neues Kapital zu, ohne die Altaktionäre zu benachteiligen; die Kapitalherabsetzung saniert in der Krise. Ob Eigen- oder Fremdkapital besser ist, entscheiden Leverage, Liquidität, Risiko und Kontrolle gemeinsam.
#src[V, PDF-S. 108–148. Eigene Zusammenfassung des Kapitels.]
#hoch(<a-3>, [Kapitelübersicht])
]


#pagebreak()
= Kapitel 4 · Unternehmensbewertung <a-4>

#überblick([Kapitel 4 auf einen Blick],
 idee(<a-4-1>, [Warum bewerten?], [Gesetz, Vertrag oder eigene Initiative (Kauf, Börsengang) verlangen einen Unternehmenswert.]),
 idee(<a-4-2>, [Vier Verfahrensfamilien.], [Substanzwert, Ertragswert/DCF, Multiplikatoren und Realoptionen.]),
 idee(<a-4-3>, [Unternehmen = Investition.], [Der Wert ist der Barwert künftiger Zahlungen, abgezinst mit den Kapitalkosten.]),
 idee(<a-4-4>, [WACC und Multiplikatoren.], [Free Cashflows mit dem Mischzins abzinsen oder mit Vergleichsunternehmen hochrechnen.]),
 idee(<a-4-6>, [Entscheidungswert.], [Höchstpreis des Käufers aus dem Vergleich mit seiner besten Alternative, nach Steuern und Inflation.]),
)
#karte((1fr, auto, 1fr, auto, 1fr),
 chunk([Anlass und Methode], [gesetzlich · vertraglich · unternehmerisch · Substanz oder Gesamtbewertung], ziel: <a-4-1>),
 pfeil(beschriftung: [Gesamtbewertung]),
 chunk([Kapitalwertkalkül], [Ertragswert · Goodwill · Steuern · Nominal- und Realrechnung], ziel: <a-4-3>),
 pfeil(beschriftung: [Praxis]),
 chunk([WACC und Vergleich], [Free Cashflow · Mischzins · Peer Group · Entscheidungswert], ziel: <a-4-4>),
)
#hoch(<ueberblick>, [Modul auf einen Blick])

Kapitel 3 hat gezeigt, wie Eigenkapital ins Unternehmen kommt. Wer Eigenkapital gibt oder ein ganzes Unternehmen kauft, muss wissen, was es wert ist. Die Lösungsstrategie: Ein Unternehmen ist für den Käufer eine *Investition*. Sein Wert ist das, was die künftigen Zahlungen heute wert sind, verglichen mit der besten Alternative. *Selbststudium:* Das Kapitel stammt aus den Folien 296–326 und war am 13.11.2026 noch nicht in der Vorlesung behandelt.
#src[V, PDF-S. 148–163 (Folien 296–326).]

== 4.1 Anlässe der Unternehmensbewertung <a-4-1>

Die Folie ordnet die Anlässe nach dem Auslöser:

#tab(columns: (1fr, 1fr, 1fr),
 th([Aufgrund gesetzlicher Regelungen], [Aufgrund vertraglicher Vereinbarungen], [Aufgrund unternehmerischer Initiativen]),
 [Abfindung von Minderheitsgesellschaftern bei Gewinnabführungs- und Beherrschungsvertrag (§ 305 AktG), bei Eingliederung durch Mehrheitsbeschluss (§ 320 AktG), bei Umwandlung (§§ 174, 190, 207 UmwG) und bei Verschmelzung (§§ 19, 29 UmwG)],
 [Austritt von Gesellschaftern aus einer Personengesellschaft (§ 738 BGB); Erbauseinandersetzungen (§ 2311 BGB); Abfindungsfälle im Familienrecht (§§ 1363–1390 BGB)],
 [Kauf oder Verkauf von Unternehmen(-steilen); Fusionen (§§ 2 ff. UmwG); Eintritt neuer Gesellschafter ohne Austritt anderer (Börsengang, Venture Capital); Gründung mit Einbringung von Anteilen; Mitarbeiterbeteiligungen; Investorenpflege],
)
Die Übung 1 (Rocca AG) fragt die Anlässe in Kurzform ab: *Kauf, Verkauf, Auflösung, Sanierung, Umwandlung, Erbgang, Fusion, Aufnahme neuer Gesellschafter, Ausscheiden von Gesellschaftern*. Die letzten beiden betreffen vor allem Personengesellschaften und die GmbH, weil dort kein Börsenkurs den Anteil bewertet.
#src[V, PDF-S. 149 (Folie 297, Quelle Drukarczyk 1998); V, PDF-S. 161 (Folie 322).]
#hoch(<a-4>, [Kapitelübersicht])

== 4.2 Moderne Methoden der Unternehmensbewertung <a-4-2>

#bild("map-bewertung", [Mindmap: die vier Verfahrensfamilien. Eigene Darstellung nach V, PDF-S. 149.], height: 44mm)

#bild("bewertungsmethoden-folie", [Folie 298: Methodenvergleich (Quellen auf der Folie: KPMG Corporate Finance 2000, Hayn 1998). Ausschnitt aus V, PDF-S. 149.])

#tab(columns: (1fr, 1.3fr, 1.3fr, 1.3fr),
 th([Methode], [Wesen und Prinzip], [Vorteile], [Nachteile]),
 [*Substanzwert*], [Vermögen einzeln bewerten, Schulden abziehen (*Einzelbewertung*); Varianten: Reproduktions- und Liquidationswert], [einfach, nachprüfbar, passt bei Liquidation], [vergangenheitsorientiert, immaterielles Vermögen fehlt],
 [*Ertragswert / DCF*], [künftige Erträge bzw. Free Cashflows mit risikoadäquatem Zins abzinsen (*Gesamtbewertung*); Ertragswertverfahren, WACC-, APV-, Equity-Ansatz], [zukunftsorientiert, theoretisch fundiert, breit akzeptiert, Risiko im Zins], [statisch: Handlungsspielräume (Realoptionen) fehlen],
 [*Multiplikatoren*], [Vergleich mit einer Peer Group (*Gesamtbewertung*); KGV-, EBIT-, Umsatz-Multiple], [einfach, marktnah], [Vergleichbarkeit begrenzt, Überbewertung möglich],
 [*Realoptionen*], [Unternehmen(-steile) als Optionen bewerten (Optionspreismethode); Invest-, Divest-, Flexibility-Options], [flexibel, dynamisch, bewertet Wachstumschancen], [sehr komplex, in der Praxis kaum durchführbar],
)

=== 4.2.1 Substanzwert, Ertragswert, Mittelwert und Goodwill <a-4-2-1>

Die Übungen der Folien rechnen mit drei einfachen Werten. Der *Substanzwert* ist das Vermögen zu *Wiederbeschaffungskosten (Tageswerten)* minus Fremdkapital, nicht der Buchwert der Bilanz. Der *Ertragswert* kapitalisiert einen gleichbleibenden Gewinn als ewige Rente:

#form[$ "Ertragswert" = "Gewinn pro Jahr" / i quad quad "Mittelwert" = ("Substanzwert" + "Ertragswert") / 2 $]
#form[$ "originärer Goodwill" = "Ertragswert" - "Substanzwert" $]

Der *Goodwill* fasst alles zusammen, was Gewinne bringt, aber nicht bilanziert werden darf: gutes Management und Fachkräfte, Standort, Ruf (Corporate Image), Kundenbeziehungen, Organisation, selbst geschaffene Patente, Kreditwürdigkeit, laufende Absatzverträge, moderne Verfahren, günstige Konkurrenzsituation, wirksame Werbung. Man unterscheidet nach den Einflussfaktoren *personen-* und *sachbezogenen*, nach der Entstehung *originären* (selbst geschaffenen, nicht bilanzierbar, sonst würde ein nicht realisierter Gewinn ausgewiesen) und *derivativen* (beim Kauf bezahlten) Goodwill.

*Beispiel Roboelec (Folie 300):* Die Bank bewertet mit 1.000.000 €, zu Wiederbeschaffungskosten wären es 20 % mehr. Der Gewinn beträgt dauerhaft 176.000 €, der Kalkulationszins 11 %.

#tab(columns: (1.4fr, 1fr),
 th([Größe], [Wert]),
 [Substanzwert (Wiederbeschaffung)], [$"1,0" dot "1,2" = "1,2"$ Mio. €],
 [Ertragswert], [$"0,176" / "0,11" = "1,6"$ Mio. €],
 [originärer Goodwill], [$"1,6" - "1,2" = "0,4"$ Mio. €],
)
Die 1 Mio. € der Bank taugt nicht als Preisforderung: Sie ist ein Substanzwert zu Buchwerten und damit zu tief. Der Preis bewegt sich zwischen 1,2 und 1,6 Mio. €, weil der Käufer die künftigen Gewinne bezahlt.
#note("Fehler vermeiden", [Für den Substanzwert immer die *Tageswerte* (Wiederbeschaffungskosten) nehmen und das *Fremdkapital abziehen* (Netto-Substanzwert). Bei der Schmid AG (Übung 2, Aufgaben) zählen Rückstellungen zum Fremdkapital, und nur das *Sachvermögen* (Anlagevermögen, Vorräte) wird um 40 % aufgewertet, nicht Debitoren und liquide Mittel.], fill: sand)
#src[V, PDF-S. 149 (Folie 298); V, PDF-S. 150–151 (Folien 300–302); V, PDF-S. 161–163 (Folien 321–326).]
#hoch(<a-4>, [Kapitelübersicht])

== 4.3 Kapitalwertkalkül <a-4-3>

Ertragswert- und DCF-Verfahren sind „Spezialfälle“ der Investitionsrechnung: Das Unternehmen ist das Investitionsobjekt, der Unternehmenswert der Kapitalwert. Die künftigen Zahlungen werden mit den Kapitalkosten $k$ abgezinst und zum Nettokapitalwert im Entscheidungszeitpunkt verdichtet.

#form[$ "NKW"_0 = -A_0 + sum_(t=1)^n "CF"_t / (1+k)^t + "RVE"_n / (1+k)^n $]
Dabei ist $A_0$ die Anfangsauszahlung und $"RVE"_n$ der Restverkaufserlös. Die Folie zeigt $A_0 = 1000$, Einzahlungen von 100, 120, 130, 120, 100 … und einen Restverkaufserlös von 50 in $t_n$.

*Beispiel 3 (Folie 312):* Anschaffung 100.000 GE, Überschüsse 60.000, 46.000 und 38.000 GE, Zins 10 %:
$ K_0 = -100000 + 60000 / "1,1" + 46000 / "1,1"^2 + 38000 / "1,1"^3 = "21.112 GE" $
Der Kapitalwert ist der Vermögenszuwachs in $t_0$ gegenüber der Anlage zum Kalkulationszins.

=== 4.3.1 Fremdfinanzierung: Netto- und Bruttomethode <a-4-3-1>

#tab(columns: (1fr, 1.5fr, 1.5fr),
 th([], [Nettomethode (Beispiel 4)], [Bruttomethode (Beispiel 5)]),
 [Idee], [Zahlungen *an die Eigentümer* (nach Zins und Tilgung) mit der Eigenkapitalrendite abzinsen], [Zahlungen *an alle Kapitalgeber* mit dem Mischzins abzinsen],
 [Daten], [Kredit 75.000 GE zu 8 %, Tilgung 25.000 GE pro Jahr; $D_t$: −25.000, +29.000, +17.000, +11.000], [50 % Fremdkapital zu 8 %, 50 % EK zu 10 %: $c = "0,5" dot "0,08" + "0,5" dot "0,10" = "0,09"$],
 [Ergebnis], [$K_0 = "23.678"$ GE (mit 10 %)], [$M_0 = "23.106"$ GE (mit 9 %)],
)
Die Fremdfinanzierung lohnt sich, weil der Kreditzins (8 %) unter der Renditeforderung der Eigentümer (10 %) liegt. Vereinfachend steigt die Renditeforderung trotz höherer Verschuldung nicht (vgl. Leverage-Risiko, 3.10).
#note("Fehler in der Folie", [Folie 313 nennt den Vorteil gegenüber Beispiel 3 mit 2.556 GE. Richtig ist $"23.678" - "21.112" = "2.566"$ GE. Eigene Nachrechnung.], fill: sand)

=== 4.3.2 Steuern <a-4-3-2>

Steuern mindern oder erhöhen die Zahlungen beim Eigner und damit seinen Entscheidungswert; Steuerzahlungen sind negative, Steuergutschriften positive Zielbeiträge wie Umsatzerlöse. Bei Kapitalgesellschaften beeinflussen sie vor allem Ausschüttungs- und Finanzierungspolitik (Mandl/Rabel 1997). Wichtig ist, *beide* Seiten des Vergleichs zu besteuern: die Unternehmenserträge und die Alternativrendite.

*Beispiel 6 (Folie 315):* Erträge 1.000 GE pro Jahr, Einkommensteuer 50 %; Alternative: Finanzanlage zu 6,5 % mit 25 % Kapitalertragsteuer.
$ P_max^"ohne Steuern" = 1000 / "0,065" = "15.385" quad quad P_max^"mit Steuern" = (1000 dot (1 - "0,5")) / ("0,065" dot (1 - "0,25")) = 500 / "0,04875" = "10.256" $
Weil die Alternativerträge nur halb so hoch besteuert werden, sinkt der Entscheidungswert um ein Drittel. Steuern wegzulassen wäre ein drastischer Bewertungsfehler.

=== 4.3.3 Inflation: Nominal- und Realrechnung <a-4-3-3>

Geldwertänderungen verändern die Kaufkraft der Erträge. Verlieren die Erträge an Kaufkraft, sinkt der Entscheidungswert; wachsen sie durch überdurchschnittliche Preiserhöhungen stärker als die Inflation, steigt er. Es gibt zwei gleichwertige Wege, die man *nicht mischen* darf:

#tab(columns: (1fr, 1.5fr, 1.5fr),
 th([], [Nominalrechnung], [Realrechnung]),
 [Beträge], [tatsächliche künftige Ein- und Auszahlungen, im Preisniveau der *jeweiligen* Periode], [kaufkraftkonstant, im Preisniveau des *Bewertungsstichtags*],
 [Zins], [nominelle Alternativrendite], [realer Zins],
 [Umrechnung], [Planwert $dot (1 + "Preissteigerung")^t$], [Nominalwert $div (1 + "Inflationsrate")^t$],
)

*Beispiel 7 und 8 (Folien 316–320):* Mengenplanung zum heutigen Preisniveau; Umsatz +3 % pro Jahr, Personalkosten +4 % pro Jahr, Zinsen unverändert, Inflation 2,5 %.

#tab(columns: (1.4fr, 1fr, 1fr, 1fr),
 th([GE], [$t_1$], [$t_2$], [$t_3$]),
 [Umsatz (Plan, heutige Preise)], [1.000], [1.150], [1.250],
 [Personalkosten (Plan)], [250], [280], [300],
 [Zinsen (Plan)], [540], [460], [410],
 [Umsatz nominal ($dot "1,03"^t$)], [1.030], [1.220], [1.366],
 [Personal nominal ($dot "1,04"^t$)], [260], [303], [337],
 [Zinsen nominal (kein Wachstum)], [540], [460], [410],
 [Umsatz real ($div "1,025"^t$)], [1.005], [1.161], [1.268],
 [Personal real], [254], [288], [313],
 [Zinsen real], [527], [438], [381],
)
Die Rechenwege der Folie: $1150 dot "1,03"^2 = 1220$; $300 dot "1,04"^3 = 337$; $1030 / "1,025" = 1005$; $460 / "1,025"^2 = 438$. Die Zinsen sind vertraglich fest, also nominal gleich dem Plan, real aber *sinkend*.
#note("Fehler in der Folie", [Die Tabelle auf Folie 317 nennt den nominalen Umsatz $t_1$ mit 1.020 und die nominalen Personalkosten $t_2$ mit 305. Richtig sind $1000 dot "1,03" = 1030$ (Folie 319 rechnet selbst mit 1.030) und $280 dot "1,04"^2 = "302,8" approx 303$. Auf Folie 320 steht für das reale Personal $t_1$ 253 statt $260 / "1,025" = "253,7" approx 254$. Außerdem heißt es dort „Fortführung des Beispiels 26“, gemeint ist Beispiel 7. Die Tabelle oben enthält die korrigierten Werte. Eigene Nachrechnung.], fill: sand)
#src[V, PDF-S. 152–160 (Folien 303–320, Quelle Mandl/Rabel 1997).]
#hoch(<a-4>, [Kapitelübersicht])

== 4.4 WACC-Ansatz <a-4-4>

Der *WACC* (Weighted Average Cost of Capital) ist das mit der Kapitalstruktur gewichtete Mittel aus Eigen- und Fremdkapitalkosten. Abgezinst werden die *entziehbaren Free Cashflows* der Planperioden.

#bild("wacc-folie", [Folie 308: Vom Free Cashflow zum Wert des Eigenkapitals (Quellen auf der Folie: KPMG 2000, Drukarczyk 1998). Ausschnitt aus V, PDF-S. 154.])

#form[$ "FCF" &= "EBIT" - "Steuern" plus.minus "nicht zahlungswirksame Aufwendungen/Erträge" \ &quad - "Investitionen AV" - "Investitionen Working Capital" $]
#form[$ k_"WACC" = k_E dot E / V + i dot F / V quad "mit" quad k_E = i + beta dot (r_M - i) quad "(Grundmodell ohne Steuern)" $]
#form[$ "Equity Value" = underbrace(sum "FCF"_t / (1 + k_"WACC")^t, "Enterprise Value") - "Marktwert FK" + "nicht betriebsnotwendiges Vermögen" $]
Dabei ist $E$ der Marktwert des Eigenkapitals, $F$ der des Fremdkapitals, $V = E + F$, $i$ der risikolose Zins bzw. Fremdkapitalzins, $r_M$ die Marktrendite und $beta$ das Risiko der Aktie relativ zum Markt (CAPM). Die Bruttomethode in Beispiel 5 ist ein WACC-Ansatz im Kleinen: $c = 9 %$ ist der gewichtete Mischzins.
#src[V, PDF-S. 154 (Folie 308).]
#hoch(<a-4>, [Kapitelübersicht])

== 4.5 Multiplikatoren-Methode <a-4-5>

#karte((1fr, auto, 1fr, auto, 1fr),
 chunk([1 · Peer Group], [geeignete Vergleichsunternehmen suchen]), pfeil(),
 chunk([2 · Multiplikator], [z. B. Umsatz, EBITDA, EBIT des Vergleichsunternehmens]), pfeil(),
 chunk([3 · Wert berechnen], [Multiplikator mal Kennzahl des eigenen Unternehmens]),
)
#form[$ "Multiplikator"_"VU" = "Marktwert"_"VU" / "Kennzahl"_"VU" quad quad "Equity Value"_X = "Multiplikator"_"VU" dot "Kennzahl"_X $]
VU ist das Vergleichsunternehmen, X das zu bewertende. Beispiel Umsatz-Multiple: $"Equity Value"_X = "Umsatzmultiple"_"VU" dot "Umsatz"_X$.

Die Folie 299 zeigt Branchen-Multiples (finance-magazin.de, Januar 2011). Ein Auszug:

#tab(columns: (1.6fr, 1fr, 1fr, 1fr, 1fr),
 th([Branche], [EBIT-Multiple Börse], [Umsatz-Multiple Börse], [EBIT-Multiple Small Cap], [Umsatz-Multiple Small Cap]),
 [Software], [16,5], [3,86], [6,2–8,2], [0,63–1,10],
 [Maschinen- und Anlagenbau], [13,1], [1,14], [5,2–7,1], [0,52–0,76],
 [Fahrzeugbau und -zubehör], [13,1], [0,60], [4,4–6,1], [0,36–0,64],
 [Bau und Handwerk], [9,9], [0,39], [4,1–5,5], [0,31–0,52],
)
Lies die Tabelle so: Ein kleiner Maschinenbauer mit 2 Mio. € EBIT wäre nach Experten-Multiples etwa $2 dot "5,2" = "10,4"$ bis $2 dot "7,1" = "14,2"$ Mio. € wert (eigenes Rechenbeispiel). Börsen-Multiples liegen deutlich höher als die für kleine, nicht börsennotierte Firmen; Software wird über Wachstumserwartungen viel höher bewertet als Bau.
#note("Merke", [Die Zahlen sind von 2011 und nur eine Momentaufnahme. Multiplikatoren ersetzen keine Planung, sondern prüfen, ob ein DCF-Wert marktüblich ist. Eigene Einordnung.], fill: sand)
#src[V, PDF-S. 150 (Folie 299); V, PDF-S. 155 (Folie 309).]
#hoch(<a-4>, [Kapitelübersicht])

== 4.6 Entscheidungswert als Alternativenvergleich <a-4-6>

Der *Entscheidungswert* $P_max$ ist der Höchstpreis, den ein Käufer gerade noch zahlen kann, ohne sich gegenüber seiner besten Alternative schlechter zu stellen. Bei unendlichem Horizont und gleichbleibenden Erträgen:

#form[$ P_max = ("Unternehmensertrag" - "entgangener Ertrag der Alternative") / "Alternativrendite" $]

#tab(columns: (1fr, 1.6fr, 1.2fr),
 th([Beispiel], [Daten], [Ergebnis]),
 [1 (Folie 310)], [Preis 600 GE, Ertrag 100 GE, Alternative 10 %], [$P_max = 100 / "0,1" = 1000$; 600 lohnt (100 statt 60 GE), 1.200 nicht (100 statt 120 GE)],
 [2 (Folie 311)], [Ertrag 4.000 GE, Wertpapiere 7 %, entgangene Tätigkeit 500 GE], [$P_max = (4000 - 500) / "0,07" = "50.000"$ GE],
 [6 (Folie 315)], [mit Steuern, siehe 4.3.2], [10.256 statt 15.385 GE],
)
Probe zu Beispiel 2: 50.000 GE zu 7 % bringen 3.500 GE Zinsen plus 500 GE aus der Tätigkeit, zusammen ebenso 4.000 GE. Der Käufer ist also bei 50.000 GE gerade indifferent.
#note("Fehler vermeiden", [Beim Entscheidungswert immer *Äquivalenz* prüfen: gleiche Sicherheit, gleiche Laufzeit, gleiche Besteuerung und gleiches Preisniveau der verglichenen Ströme (Mandl/Rabel). Wer nach Steuern rechnet, muss auch die Alternative nach Steuern rechnen.], fill: sand)
#src[V, PDF-S. 155–156 (Folien 310–311); V, PDF-S. 158 (Folie 315).]
#hoch(<a-4>, [Kapitelübersicht])

#block(breakable: false)[
*Der Zusammenhang in Kapitel 4.* Ein Unternehmen wird bewertet, wenn Gesetz, Vertrag oder eine Transaktion einen Preis verlangen. Der Substanzwert zählt nur das vorhandene Vermögen; Käufer zahlen aber für künftige Erträge, deshalb dominiert das Kapitalwertkalkül der Investitionsrechnung. Der Unterschied zwischen Ertrags- und Substanzwert ist der Goodwill. Wie in Kapitel 2 und 3 entscheiden Kapitalkosten und Kapitalstruktur: Netto- und Bruttomethode bzw. WACC verarbeiten den Fremdkapitalanteil, Steuern und Inflation müssen auf beiden Seiten des Alternativenvergleichs gleich behandelt werden. Multiplikatoren liefern die Marktprobe.
#src[V, PDF-S. 148–163. Eigene Zusammenfassung des Kapitels.]
#hoch(<a-4>, [Kapitelübersicht])
]

#pagebreak()
= Kapitel 5 · Ausblick: Digitale Finanzierung <a-5>

Die letzte Inhaltsfolie nennt fünf Entwicklungen, die die Finanzierung verändern, und eine offene Frage: Wie funktionieren *Haftung* und *Zwangsvollstreckung*, wenn Vermögen und Verträge nur noch digital existieren? Die Folie schließt: „Schaffung eines Rechtsrahmens dringend erforderlich!“ *Selbststudium:* Die Folie war am 13.11.2026 noch nicht behandelt; die Erläuterungen sind eigene Kurzdefinitionen, weil die Folie nur Stichworte enthält.

== 5.1 Fünf Entwicklungen und die Rechtsfrage <a-5-1>

#tab(columns: (1fr, 2fr),
 th([Stichwort der Folie], [Kurz erklärt (eigene Erläuterung)]),
 [*Kryptowährungen*], [privat ausgegebene digitale Werteinheiten auf einer Blockchain, ohne Zentralbank; stark schwankende Kurse],
 [*Digitaler Euro*], [geplantes digitales Zentralbankgeld der EZB, also eine Forderung gegen die Zentralbank wie Bargeld (vgl. 2.13)],
 [*Elektronische Wertpapiere*], [Wertpapiere ohne Papierurkunde, eingetragen in ein elektronisches Register (in Deutschland seit dem eWpG 2021)],
 [*DAOs*], [Decentralised Autonomous Organizations: Organisationen, deren Regeln als Code laufen und deren Mitglieder per Token abstimmen; Rechtsform und Haftung oft unklar],
 [*Smart Contracts*], [Programme, die vereinbarte Leistungen automatisch ausführen, z. B. Zahlung bei Eintritt einer Bedingung],
)
#note("Merke", [Verbindung zum Modul: Sicherheiten (2.14), Haftung nach Rechtsform (3.4) und Zwangsvollstreckung setzen voraus, dass klar ist, wem ein Vermögenswert gehört und wer haftet. Genau das ist bei Krypto-Werten und DAOs noch nicht überall geregelt. Eigene Einordnung.], fill: sand)
#src[V, PDF-S. 164 (Folie 327).]
#hoch(<a-5>, [Kapitelanfang])


#pagebreak()
= Anhang
== Formelsammlung mit Voraussetzungen

Geldgrößen immer in derselben Währung und Periode einsetzen. Prozentgrößen einheitlich als Dezimalzahl oder Prozentwert verwenden; Bestandsgrößen und jährliche Zahlungsströme unterscheiden.

=== Formeln zu Kapitel 1 · Grundlagen der Finanzplanung

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
 [Steuer im Fall], [50 % der positiven Steuerbasis nach Verlustverrechnung], [Nur historische Modellannahme, keine aktuelle Steuerregel; G PDF-S. 14.],
 [Aktienzahl], [$N="Grundkapital"/"Nominalwert je Aktie"$], [Gleichartige Aktien; Stück; V PDF-S. 28–30.],
 [Korrigierter Bilanzkurs], [$("EK"+"stille Reserven")/N$], [€/Aktie, korrigierte Substanzwerte; V PDF-S. 29.],
 [Ertragswertkurs], [$("künftiger Jahresgewinn"/i)/N$], [Konstanter unbegrenzter Gewinn, $i>0$; V PDF-S. 29.],
 [KGV / Gewinnrendite], [$"Kurs"/"Gewinn je Aktie"$; Kehrwert × 100 %], [Gewinnrendite zum Marktpreis ≠ JÜ/EK; V PDF-S. 30.],
 [Dividendenrendite], [$"Dividende je Aktie"/"Kurs" times 100%$], [Positive Kursbasis, keine Kursgewinne enthalten; V PDF-S. 30.],
 [Cashflow Ratio], [$"Kurs"/("CF"/N)$], [CF-Abgrenzung und Periode festlegen; V PDF-S. 30.],
 [Working Capital], [$"UV"-"kurzfristiges FK"$], [Bilanzstichtag; von operativem EBK unterscheiden; V PDF-S. 30.],
 [Kapitalbedarf UV], [$sum_j ("Jahresauszahlungen"_j/360) B_j$], [Gleichmäßige Tagesausgaben; $B_j$ Tage; V PDF-S. 31–32.],
 [Nettomonetäres UV], [Liquide Mittel + kurzfr. Forderungen − kurzfr. Verbindlichkeiten], [Bestandsgröße in €; keine reine Kasse; V PDF-S. 35–36, Abgrenzung 1.21.],
 [Durchschnittskapital], [$("Anfang"+"Ende")/2$], [Gleichmäßige Veränderung im Modell; V PDF-S. 38.],
)

=== Formeln zu Kapitel 2 · Fremdfinanzierung

#tab(columns: (1.2fr, 1.9fr, 1.8fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Bank-EK, Folienmodell], [$"Kredit" times 8% times w$], [Vereinfachtes Basel II, $w$ als Faktor; V PDF-S. 43–44.],
 [Kreditvolumen, Folienmodell], [$"Bank-EK"/(8% times w)$], [Nur diese Grenze bindet; $w>0$; V PDF-S. 43–44.],
 [Einfacher zeitanteiliger Zins], [$Z=K_0 i t/B$], [Konvention für $t$ und $B$ festlegen; V PDF-S. 55.],
 [Zinseszins], [$K_n=K_0(1+i)^n$], [Konstanter Periodenzins, Wiederanlage; V PDF-S. 56.],
 [Monats- zu Jahreszins], [$i_"Jahr"=(1+i_"Monat")^12-1$], [Ohne Gebühren/Steuern, Wiederanlage; V PDF-S. 56.],
 [Restschuld fortschreiben], [$R_t=R_(t-1)-T_t$; $Z_t=i R_(t-1)$], [Jährlich nachschüssig; €; K PDF-S. 1.],
 [Ratendarlehen], [$T=D/n$], [Konstante Tilgung, keine Sonderzahlung; K PDF-S. 1.],
 [Annuität], [$A=D frac(i(1+i)^n,(1+i)^n-1)$], [Konstanter Zins $i>0$, nachschüssig, vollständige Tilgung; K PDF-S. 1.],
 [Effektivzins, Praktikerformel], [$(i_"nom" D+(D-"Aus")/n)/"Aus"$], [Näherung für endfälligen Kredit mit Disagio; K PDF-S. 2.],
 [Skonto als Jahreszins], [$frac(s, 1-s) times frac(360, "Ziel" - "Skontofrist")$], [$s$ Skontosatz als Dezimalzahl, Tage; Vorgriff 2.15.1; V PDF-S. 70.],
 [Barwert einer Anleihe], [$"PV"=sum_(t=1)^n Z_t/(1+i)^t$; $"NPV"="PV"-"Kurs"$], [Marktzins $i$ je Periode, Rückzahlung im letzten $Z_t$; Vorgriff 2.18.1.],
 [Kaufpreis mit Stückzinsen], [$"Kurs"/100 times N + N i_"nom" "Tage"/"Basis"$], [Tage seit letztem Kupon, Zählweise beachten; Vorgriff 2.18.2.],
 [Optionsschein, rechnerisch], [$"Aktienkurs" - "Bezugskurs"$], [je Aktie, nur wenn positiv; Vorgriff 2.20.1.],
 [Wandlungsverhältnis], [$frac("neue Aktien", "Wandelanleihen")$], [Stückzahlen; Vorgriff 2.20.1.],
 [Rendite Zerobond], [$r=root(n, K_n/K_0)-1$], [Kauf $K_0$, Rückzahlung $K_n$ nach $n$ Jahren; Vorgriff 2.20.3.],
)

#note("Wichtige Zahlen", [*Folienorientierungen:* L1 10–30 %, L2 ≥ 100 %, L3 ≥ 200 %, AD II ≥ 100 %, EK-Quote mindestens 15–20 %. *Glasspinnerei:* Investition 85 Mio. € = 30 + 55; NOCF 2005 vor/nach laufender Modellsteuer 43,305 Mio. €; Finanzierungslücke 2005 23,029 Mio. €. *Basel-Folienmodell:* 8 % × Risikogewicht; Basel III mit Kapitalerhaltungspuffer 7 % CET1 und 10,5 % Gesamtkapital/RWA; Leverage Ratio mindestens 3 % mit anderer Bezugsgröße. Diese Werte gelten nur mit den genannten Voraussetzungen.])
#src[V, PDF-S. 9–56; G, PDF-S. 10–15; K, PDF-S. 1–2; Voraussetzungen/Einheiten: eigene Erläuterung. Rechtsabgleich der Zahlungsquote und Überschuldung in Abschnitt 1.8.]

=== Formeln zu Kapitel 3 · Eigen- und Selbstfinanzierung

#tab(columns: (1.2fr, 1.9fr, 1.8fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Break-even-Kurs einer Aktie], [$"Kaufkurs" + frac("Kosten Kauf" + "Kosten Verkauf", "Stückzahl")$], [€ je Aktie, ohne Steuern; 3.4.1.],
 [Entziehbarer Überschuss], [$"Umsatz" - "zahlungsw. Aufwand" - "Zinsen" - "Steuern" - "Invest." - Delta"NWC" - "Tilgung"$], [Obergrenze der Ausschüttung aus dem Finanzplan; 3.5.1.],
 [Kapitalerhaltung GmbH], [$"Aktiva" - "Verbindlichkeiten" < "Stammkapital"$ → angegriffen], [Buchwerte der Bilanz; 3.6.],
 [Bezugsrecht], [$B = frac(K_"alt" - K_"neu", m/n + 1)$], [Bezugsverhältnis $m:n$ (alt : neu), Dividendennachteil vernachlässigt; 3.7.1.],
 [Mischkurs], [$frac(m K_"alt" + n K_"neu", m+n) = K_"alt" - B$], [Kurs nach der Erhöhung; 3.7.1.],
 [Gesamtkapitalrendite], [$frac("Gewinn" + "FK-Zinsen", "Ø GK")$], [Durchschnitt aus Anfangs- und Endbestand; 3.10.],
 [Eigenkapitalrendite], [$frac("Gewinn", "Ø EK")$], [3.10.],
 [Break-even der Finanzierung], [$frac(G - r_(f 1) "FK"_1, "EK"_1) = frac(G - r_(f 2) "FK"_2, "EK"_2)$], [nach $G$ (Gewinn vor Zinsen) auflösen; 3.10.],
)

=== Formeln zu Kapitel 4 · Unternehmensbewertung

#tab(columns: (1.2fr, 1.9fr, 1.8fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Substanzwert], [$"Vermögen zu Tageswerten" - "Fremdkapital"$], [Rückstellungen zählen zum FK; 4.2.1.],
 [Ertragswert], [$"Gewinn"/i$], [gleichbleibender Gewinn, ewige Rente; 4.2.1.],
 [Mittelwert], [$("Substanzwert" + "Ertragswert")/2$], [4.2.1.],
 [Originärer Goodwill], [$"Ertragswert" - "Substanzwert"$], [nicht bilanzierbar; 4.2.1.],
 [Kapitalwert], [$-A_0 + sum "CF"_t/(1+k)^t + "RVE"_n/(1+k)^n$], [nachschüssig; 4.3.],
 [Mischzins (Bruttomethode)], [$c = "FK-Anteil" dot i_"FK" + "EK-Anteil" dot i_"EK"$], [konstante Kapitalstruktur; 4.3.1.],
 [Entscheidungswert mit Steuern], [$P_max = frac(E (1-s_"ESt"), i (1-s_"KESt"))$], [ewige Rente, beide Seiten besteuern; 4.3.2.],
 [Nominal / real], [$"Plan" dot (1+p)^t$ bzw. $"nominal" div (1+pi)^t$], [$p$ Preissteigerung, $pi$ Inflation; nicht mischen; 4.3.3.],
 [WACC], [$k_E E/V + i F/V$ mit $k_E = i + beta(r_M - i)$], [Grundmodell ohne Steuern, Marktwerte; 4.4.],
 [Equity Value (DCF)], [$sum "FCF"_t/(1+k_"WACC")^t - "FK" + "n.b. Vermögen"$], [4.4.],
 [Multiplikator], [$"Equity"_X = frac("Marktwert"_"VU", "Kennzahl"_"VU") dot "Kennzahl"_X$], [vergleichbare Peer Group; 4.5.],
 [Entscheidungswert], [$P_max = ("Ertrag" - "entgangener Alternativertrag")/i$], [ewige Rente, Äquivalenz; 4.6.],
)
#src[V, PDF-S. 108–163; Zusammenstellung der Formeln aus Kapitel 3 und 4 (Vorgriff). Voraussetzungen: eigene Erläuterung.]
