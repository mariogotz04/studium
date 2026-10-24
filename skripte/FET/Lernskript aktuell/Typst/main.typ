// Claude-Arbeitsfassung: Bilder liegen im Unterordner abbildungen/. Keine Pakete erforderlich.
// Dieses gesamte Projekt in Typst hochladen; diese .typ-Datei als Hauptdatei öffnen.
#set document(title: "Fluid- und Energietechnik – Feynman-Lernskript, anschauliche Fassung", author: "Lernzusammenfassung")
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
 header: [#text(size: 8pt, fill: muted)[Fluid- und Energietechnik #h(1fr) Sehen · Verstehen · Erklären]], footer: seitenfuss)
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
  "map-fet": "abbildungen/map-fet.svg",
  "map-tabellenmodell": "abbildungen/map-tabellenmodell.svg",
  "interpolation-invers": "abbildungen/interpolation-invers.svg",
  "stickstoff-zustaende": "abbildungen/stickstoff-zustaende.svg",
  "stickstoff-pv": "abbildungen/stickstoff-pv.svg",
  "verdampfer-stroeme": "abbildungen/verdampfer-stroeme.svg",
  "anomaly": "abbildungen/anomaly.svg",
  "bath": "abbildungen/bath.svg",
  "bernoulli": "abbildungen/bernoulli.svg",
  "boiler": "abbildungen/boiler.svg",
  "boundary": "abbildungen/boundary.svg",
  "continuity": "abbildungen/continuity.svg",
  "cover": "abbildungen/cover.svg",
  "division": "abbildungen/division.svg",
  "drain-plot": "abbildungen/drain-plot.svg",
  "energy-parts": "abbildungen/energy-parts.svg",
  "expansion": "abbildungen/expansion.svg",
  "five-states": "abbildungen/five-states.svg",
  "heating-power": "abbildungen/heating-power.svg",
  "heating-temperature": "abbildungen/heating-temperature.svg",
  "heatpipe": "abbildungen/heatpipe.svg",
  "hose": "abbildungen/hose.svg",
  "isochoric": "abbildungen/isochoric.svg",
  "kelvin": "abbildungen/kelvin.svg",
  "lever": "abbildungen/lever.svg",
  "manometer": "abbildungen/manometer.svg",
  "map-balance": "abbildungen/map-balance.svg",
  "map-heat": "abbildungen/map-heat.svg",
  "map-path": "abbildungen/map-path.svg",
  "map-ptw": "abbildungen/map-ptw.svg",
  "map-quality": "abbildungen/map-quality.svg",
  "map-state": "abbildungen/map-state.svg",
  "map-system": "abbildungen/map-system.svg",
  "map-water": "abbildungen/map-water.svg",
  "mass-volume": "abbildungen/mass-volume.svg",
  "oxygen": "abbildungen/oxygen.svg",
  "path-work": "abbildungen/path-work.svg",
  "phase-dome": "abbildungen/phase-dome.svg",
  "piston": "abbildungen/piston.svg",
  "pv-isolines": "abbildungen/pv-isolines.svg",
  "pvt": "abbildungen/pvt.svg",
  "reversibility": "abbildungen/reversibility.svg",
  "states": "abbildungen/states.svg",
  "supercritical": "abbildungen/supercritical.svg",
  "transfers": "abbildungen/transfers.svg",
  "triple": "abbildungen/triple.svg",
  "turbine": "abbildungen/turbine.svg",
  "warming": "abbildungen/warming.svg",
  "mixing": "abbildungen/mixing.svg",
  "map-mix": "abbildungen/map-mix.svg",
  "hs-overview": "abbildungen/hs-overview.svg",
  "hs-open": "abbildungen/hs-open.svg",
  "hs-closed": "abbildungen/hs-closed.svg",
  "hs-special": "abbildungen/hs-special.svg",
  "map-firstlaw": "abbildungen/map-firstlaw.svg",
  "ball": "abbildungen/ball.svg",
)

#let bilddeutungen = (
  "map-fet": (titel: "Die Mindmap lesen", body: [Die vier Äste bilden einen Rechenweg: Zuerst die Grenze festlegen, dann Ströme und Speicher bilanzieren, den Stoffzustand beschreiben und schließlich das Ergebnis prüfen. Dieselbe Kette verbindet Thermodynamik und die schon verwendeten Strömungsansätze.]),
  "map-tabellenmodell": (titel: "Die Mindmap lesen", body: [Vier Entscheidungen führen vom Zustand zur Rechnung. Erst die Phase erkennen, dann zwischen spezifischer Größe, Gesamtmenge und Strom unterscheiden. Der Tabellenwert verbindet anschließend das Stoffmodell mit der Bilanz; Einheiten und Bezugszustand müssen dazu passen.]),
  "interpolation-invers": (titel: "Die Achsenrolle wechseln", body: [Waagerecht steht das bekannte spezifische Volumen, senkrecht die gesuchte Temperatur bei festem Druck. Grün verbindet die zwei Tabellenpunkte geradlinig. Die orange Hilfslinie bei 0,02300 m³/kg trifft diese Gerade bei rund 106,11 °C. Die Gerade ist eine Näherung zwischen den Punkten.]),
  "stickstoff-zustaende": (titel: "Zwei verschiedene Wege", body: [Die Gefäßgröße bleibt in allen drei Bildern gleich; grün zeigt Flüssigkeit, hellblau den Dampfraum. Von ① nach ② wird geheizt, ohne Masse abzugeben. Von ② nach ③ verlassen 1 kg Flüssigkeit den Behälter; etwas Flüssigkeit verdampft und vergrößert den Dampfraum. Die Füllhöhen sind schematisch.]),
  "stickstoff-pv": (titel: "Großes V und kleines v auseinanderhalten", body: [Die senkrechte Achse zeigt Druck, die waagerechte das spezifische Volumen. Beim geschlossenen Vorheizen führt ①–② senkrecht nach oben. Während der isobaren Entnahme führt ②–③ nach rechts: Die Masse sinkt bei gleichem Gesamtvolumen. Die graue Dampfglocke dient nur der Orientierung.]),
  "verdampfer-stroeme": (titel: "Den Stoffstrom mitlesen", body: [Links tritt Flüssigkeit ein, rechts Nassdampf aus. Der Massenstrom ist gleich, während die Geschwindigkeit wegen des stark wachsenden spezifischen Volumens zunimmt. Der rote Pfeil führt Wärme zu. Aus x und der Sättigungstafel bestimmst du h, u und s; die Multiplikation mit dem Massenstrom liefert die Stromgrößen.]),
  "map-mix": (titel: "Die Mindmap lesen", body: [Die vier Äste verbinden die Gesamtmengen mit den Anteilen und den daraus berechneten Gemischgrößen. Entscheidend ist die Bezugsgröße: $xi$ gewichtet Massen, $psi$ Stoffmengen. Deshalb braucht die Umrechnung die Molmassen der Komponenten.]),
  "map-firstlaw": (titel: "Die Mindmap lesen", body: [Links oben steht die Energieerhaltung, rechts oben der offene und links unten der geschlossene Fall. Rechts unten erinnert das Vorzeichen an die Zufuhrkonvention. Druck- beziehungsweise Volumenarbeit sind dabei Beiträge zur gesamten Arbeit; weitere Beiträge und äußere Energieänderungen prüfst du vor dem Streichen.]),
  "mixing": (titel: "Vorher getrennt, nachher gemischt", body: [Oben liegen die Gase A und B getrennt nebeneinander, beide bei gleichem $p$ und $T$. Jedes nimmt sein Partialvolumen ein. Nach dem Entfernen der Membran füllt das Gemisch g das ganze Volumen $V_g=V_A+V_B$; Massen und Stoffmengen addieren sich.]),
  "hs-overview": (titel: "Örtlich oder zeitlich vorher", body: [Links strömt Stoff von ① nach ②: Die Zustände liegen an verschiedenen *Orten*. Rechts bleibt dieselbe Masse im Zylinder: ① und ② sind verschiedene *Zeitpunkte*. Die farbigen Pfeile über die gestrichelte Grenze sind die Prozessgrößen.]),
  "hs-open": (titel: "Was über die Grenze geht", body: [Grün und blau treten Enthalpiestrom und Massenstrom bei ① ein und bei ② aus, mit Höhen $z_1$ und $z_2$. Der schwarze Pfeil (Rad) ist die technische Arbeit $P$, der rote die Wärme $dot(Q)_12$. Die kleinen Kolben an Ein- und Austritt zeigen die Verschiebearbeit $p v$.]),
  "hs-closed": (titel: "Vom Zustand ① zum Zustand ②", body: [Von unten nach oben wird der Kolben verschoben: Bei jedem kleinen Schritt ändern sich $v$ um $dif v$ und die Lage um $dif z$, während $dif q$ und $dif w_g$ zugeführt werden. Die Summe aller Schritte ergibt den integrierten 1. HS.]),
  "hs-special": (titel: "Vier Grenzen, vier Fälle", body: [Oben Wirbel im Gas: Ein Teil der Arbeit wird dissipiert. Darunter reibfrei, nur Volumenarbeit und Wärme. Die schraffierte Wand bedeutet adiabat: nur noch $W_(v 12)$. Unten ganz umschlossen: abgeschlossenes System ohne jeden Austausch.]),
  "ball": (titel: "Drei Momentaufnahmen", body: [① Die Kugel hat Lage- und Bewegungsenergie. ② Im idealisierten Modell ruht sie am Boden: Die äußere Energie ist vollständig in ihre innere Energie übergegangen. ②\* ergänzt die reale Verformung. Sie ist ein innerer Vorgang und bedeutet nicht automatisch einen Energieverlust der Kugel; zusätzlich kann Energie an Boden und Umgebung übertragen werden.]),
  "boundary": (titel: "Die Grenze mitlesen", body: [Die gestrichelte Linie markiert den betrachteten Ausschnitt. Ein Energiepfeil gehört zur äußeren Bilanz, wenn er diese Linie kreuzt. Umschließt du beide Teilsysteme gemeinsam, liegt ihre gegenseitige Übertragung innerhalb der neuen Grenze. Was System 1 abgibt, nimmt System 2 auf; in der Gesamtbilanz heben sich diese Beiträge auf.]),
  "bath": (titel: "Von den Pfeilen zum Füllstand", body: [Die Pfeile stehen für Ströme, der Wanneninhalt für den gespeicherten Bestand. Gleiche Zu- und Abflüsse halten den Inhalt konstant, auch wenn ständig anderes Wasser hindurchfließt. Bei einem positiven Nettozufluss wächst der Inhalt. Der Überlauf wird erst relevant, sobald der Wasserstand seine Höhe erreicht.]),
  "transfers": (titel: "Drei Wege derselben Energie", body: [Links verschiebt ein Kolben die Grenze und überträgt dabei Arbeit. In der Mitte erreicht Energie das System wegen eines Temperaturunterschieds als Wärme. Rechts überschreitet die Masse selbst die Grenze und bringt Energie mit. Die Unterscheidung beschreibt den Grenzübertritt; sie bezeichnet keine verschiedenen gespeicherten „Energiearten“ im Wasser oder Gas.]),
  "expansion": (titel: "Was der gelbe Anteil bedeutet", body: [Die untere Länge ist die Ausgangslänge, die obere die erwärmte Länge. Gelb ist nur der Zuwachs $Delta L$, nicht die gesamte Endlänge. Bei gleichem Material und gleicher Temperaturänderung wächst ein doppelt so langer Stab ungefähr doppelt so stark. Deshalb steht $L_0$ als Faktor in der Formel.]),
  "heating-temperature": (titel: "Die Temperaturkurve lesen", body: [Waagerecht steht die Uhrzeit, senkrecht die Temperatur. Bis 01:36 Uhr bleibt das Bad bei 6 °C. Danach steigt die Temperatur mit konstanten 10 K/h. Ab 08:00 Uhr wird die Kurve zunehmend flacher; um 12:00 Uhr erreicht sie 90 °C mit Steigung null. „Knickfrei“ bedeutet am Übergang gleiche Temperatur und gleiche Steigung, nicht dieselbe Kurvenform.]),
  "heating-power": (titel: "Warum die Leistung sinkt", body: [Die senkrechte Achse zeigt Leistung je Kilogramm Wasser, nicht die gesamte Heizleistung. Eine konstante Temperatursteigung verlangt im Modell konstante Leistung. Im Parabelabschnitt sinkt die Steigung linear, also auch die Leistung. Die Fläche unter dieser Kurve entspricht der spezifischen Energiezufuhr; mit Stunden auf der Zeitachse ergibt sie zunächst Wh/kg.]),
  "division": (titel: "Der Teilungstest", body: [Denke dir den homogenen Inhalt in zwei gleiche Portionen geteilt. Jede Portion enthält die halbe Masse, das halbe Volumen und die halbe innere Energie. Temperatur und Dichte ändern sich durch diese gedankliche Aufteilung nicht. Auch $v=V/m$ bleibt gleich, weil Zähler und Nenner im selben Verhältnis kleiner werden.]),
  "continuity": (titel: "Was die Stromröhre zeigt", body: [Die Mantelfläche folgt den Stromlinien: Dort weist die Strömung entlang der Fläche und nicht durch sie hindurch. Im stationären Modell bleibt deshalb zwischen den beiden Querschnitten kein Netto-Massenstrom seitlich übrig. Durch jeden Querschnitt muss dieselbe Masse pro Sekunde treten, obwohl Fläche und Geschwindigkeit verschieden sein dürfen.]),
  "drain-plot": (titel: "Warum die Entleerung langsamer wird", body: [Waagerecht steht die Zeit, senkrecht die Füllhöhe. Anfangs ist die Kurve steil: Die große Druckhöhe treibt einen starken Ausfluss an. Beim Sinken des Spiegels nimmt die Ausflussgeschwindigkeit ab, und die Kurve flacht ab. Daher braucht die erste Volumenhälfte nur 15,77 Minuten; die zweite benötigt deutlich länger. Der Verlauf endet beim leeren Behälter.]),
  "states": (titel: "Momentaufnahme und Weg auseinanderhalten", body: [Links und rechts siehst du unterschiedliche Gaszustände. Aus den Bildern kannst du etwa die Änderung des Volumens erkennen. Du erfährst daraus aber noch nicht, wie viel Wärme und Arbeit während des Übergangs übertragen wurden. Dafür brauchst du den Prozessweg und die zugehörigen Randbedingungen.]),
  "pv-isolines": (titel: "Die Linien im p-v-Diagramm", body: [Waagerecht steht das spezifische Volumen, senkrecht der Druck. Die blaue Waagerechte hält $p$ fest; die orange Senkrechte hält $v$ fest. Auf der grünen Isotherme bleibt beim idealen Gas das Produkt $p v$ konstant: Größeres Volumen verlangt kleineren Druck. Ein Schnittpunkt bedeutet denselben Zustand; daraus folgt noch kein gemeinsamer Prozessweg.]),
  "kelvin": (titel: "Die Gerade richtig deuten", body: [Die Gerade verschiebt den Nullpunkt um 273,15, ohne die Schrittweite zu ändern. Darum sind Temperaturdifferenzen in Kelvin und Grad Celsius zahlenmäßig gleich. Verhältnisse ändern sich dagegen durch den verschobenen Nullpunkt: Von 20 auf 60 °C steigt die absolute Temperatur von 293,15 auf 333,15 K, also nur um etwa 14 Prozent.]),
  "path-work": (titel: "Gleiche Endpunkte, verschiedene Arbeitsbeträge", body: [Beide Wege führen von 2 bar und 1 m³ zu 1 bar und 2 m³. Links expandiert das Gas isotherm; rechts sinkt zuerst bei festem Volumen der Druck, danach expandiert es bei 1 bar. Links erfolgt die Expansion im Mittel gegen höheren Druck, daher ist die Fläche größer: etwa 138,6 statt 100 kJ. In der Zufuhrkonvention sind beide Arbeiten negativ.]),
  "reversibility": (titel: "Was die durchgestrichene Skizze aussagt", body: [Links kann Energie als Wärme zu- oder abgeführt werden. Rechts führt Rühren durch Dissipation zu einer Erwärmung. Die rote Durchstreichung zeigt die entscheidende Grenze: Durch bloßes Rückwärtsrühren entsteht keine Abkühlung, die dieselbe Energie vollständig als Arbeit zurückliefert. Energie bleibt erhalten, aber der Vorgang lässt sich nicht spurlos umkehren.]),
  "warming": (titel: "Warum die Kurve manchmal waagerecht bleibt", body: [Waagerecht steht bereits zugeführte Energie, senkrecht die Temperatur. Auf den ansteigenden Abschnitten wird eine einzelne Phase wärmer. Auf den Plateaus fließt weiterhin Energie zu; sie verändert bei konstantem Druck den Phasenanteil. Deshalb bedeutet eine waagerechte Kurve hier keine ausgeschaltete Heizung. Das lange Siedeplateau zeigt den großen Energiebedarf der Verdampfung.]),
  "energy-parts": (titel: "Die Balken sind einzelne Beiträge", body: [Jeder Balken zeigt die Energie eines eigenen Schritts für 1 kg Stoff. Es sind keine aufeinander aufaddierten Gesamtwerte. Die Summe aller fünf Balken beträgt etwa 3,24 MJ. Der Verdampfungsbalken ist besonders hoch: Das vollständig erwärmte flüssige Wasser ist energetisch noch weit vom vollständig verdampften Zustand entfernt.]),
  "oxygen": (titel: "Was die beiden Säulen vergleichen", body: [Beide Rechnungen starten bei 233 bar Absolutdruck und 300 K und kühlen auf 254,85 K ab. Im idealen Modell bestimmt das Temperaturverhältnis allein den Enddruck. Real ändert sich zusätzlich $Z$; das senkt hier den berechneten Enddruck auf 177,55 bar. Die Säulen vergleichen Modellvorhersagen, keine zwei direkt gemessenen Ergebnisse.]),
  "pvt": (titel: "Eine dreidimensionale Landkarte", body: [Jeder Punkt auf der Fläche steht für eine zulässige Kombination von $p,v,T$. Die kleineren Diagramme zeigen Projektionen auf jeweils zwei Achsen. Beim einphasigen idealen Gas bestimmen zwei unabhängige Angaben die dritte. Im Zweiphasengebiet gehören zu derselben Sättigung dagegen derselbe Druck und dieselbe Temperatur, während sich das spezifische Volumen mit dem Phasenanteil ändern kann.]),
  "phase-dome": (titel: "Die Dampfglocke lesen", body: [Die waagerechte Achse ist das spezifische Volumen, keine Zeitachse. Die grüne Begrenzung trennt die einphasigen Bereiche vom Gemisch. Entlang der blauen Isobare liegt Punkt 2 am Flüssigkeitsrand, Punkt 3 im Gemisch und Punkt 4 am Dampfrand. Zwischen 2 und 4 wachsen Dampfanteil und spezifisches Volumen, während Druck und Sättigungstemperatur gleich bleiben.]),
  "five-states": (titel: "Warum die Kolben nach oben wandern", body: [Die Skizzen vergleichen dieselbe Stoffmasse bei gleichem Druck. Beim Verdampfen wächst ihr Volumen stark, deshalb hebt der Stoff den Kolben. Zwischen den Zuständen 2 und 4 stammt die größere Ausdehnung aus dem wachsenden Dampfanteil, obwohl die Temperatur konstant bleibt. Erst nach vollständiger Verdampfung erhöht weiteres Heizen die Dampftemperatur.]),
  "supercritical": (titel: "Den Stoffstrom verfolgen", body: [Links erhöht die Pumpe den Druck der Flüssigkeit. Die beheizte Rohrschlange führt anschließend Energie zu; im beschriebenen Heizabschnitt liegt der Druck oberhalb des kritischen Drucks. Der Stoff passiert dabei keine gewöhnliche Flüssig-Dampf-Grenze. In der Turbine gibt er anschließend Wellenarbeit ab, die der Generator in elektrische Energie umwandelt.]),
  "isochoric": (titel: "Warum auch die Flüssigkeitsseite erreichbar ist", body: [Die beiden grünen Senkrechten halten unterschiedliche spezifische Volumina fest. Von 1b führt das Erwärmen rechts der kritischen Isochore zur Dampfseite. Von 1a links davon gelangt der Stoff zur Flüssigkeitsseite: Bei der höheren Sättigungstemperatur beansprucht die Flüssigkeit mehr Raum pro Kilogramm. Daher muss Wärmezufuhr hier nicht einfach den Dampfanteil vergrößern.]),
  "mass-volume": (titel: "Gleiche Balkenlänge, andere Bezugsgröße", body: [Beide Balken stellen jeweils 100 Prozent dar: oben die Gesamtmasse, unten das Gesamtvolumen. Grün bezeichnet in beiden Fällen Dampf. Sein winziger Massenanteil kann einen großen Volumenanteil besitzen, weil Dampf pro Kilogramm viel mehr Platz braucht. Deshalb darfst du aus „halb mit Dampf gefüllt“ nicht auf „halbe Masse als Dampf“ schließen.]),
  "lever": (titel: "Aus dem Abstand wird ein Anteil", body: [Vergleiche auf der horizontalen Zweiphasenlinie die Strecke vom Flüssigkeitsrand $v'$ zum Gemischwert $v$ mit der ganzen Strecke von $v'$ bis $v''$. Ihr Verhältnis ist $x$. In der Mitte beträgt der Dampfgehalt 0,5, unabhängig davon, wie ungleich die Teilvolumina sind. Für Zahlenrechnungen verwendest du die Stoffwerte; die Skizze ist nicht maßstäblich.]),
  "heatpipe": (titel: "Zwei Ströme halten den Kreislauf aufrecht", body: [Der Dampf transportiert Energie vom warmen zum kalten Ende. Dort kondensiert er und gibt Energie ab. Flüssigkeit kehrt in der Kapillarstruktur zurück. Durch die äußere Grenze fließt dabei keine Arbeitsfluidmasse, obwohl innen ständig Masse zirkuliert. Das veranschaulicht, warum „geschlossen“ und „ohne inneren Stofftransport“ verschiedene Aussagen sind.]),
  "triple": (titel: "Drei Phasen bei einer gemeinsamen Temperatur", body: [Die Farben unterscheiden Eis, flüssiges Wasser und Dampf; sie zeigen keine verschiedenen Temperaturen. Am Tripelpunkt besitzen alle drei Phasen im Gleichgewicht dieselbe Temperatur und denselben Druck. Bei gleicher Gesamtmasse führen andere Phasenanteile zu einem anderen Gesamtvolumen; die beiden Tripelpunktwerte bleiben dabei gleich.]),
  "anomaly": (titel: "Phasengrenzen statt Prozesskurven", body: [Waagerecht steht die Temperatur, senkrecht der Druck. Jede Linie zeigt Bedingungen, bei denen zwei Phasen koexistieren. Die Verdampfungsgrenze steigt nach rechts: Höhere Siedetemperatur gehört zu höherem Druck. Die Schmelzgrenze gewöhnlichen Eises fällt im gezeigten Bereich. Am Tripelpunkt treffen drei Grenzen zusammen; die Flüssig-Dampf-Grenze endet dagegen am kritischen Punkt.]),
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
#text(size: 29pt, weight: "bold", fill: navy)[Fluid- und\ Energietechnik]
#v(4mm)
#text(size: 20pt, fill: navy)[Feynman-Lernskript]
#v(3mm)
#text(size: 12pt)[Zusammenhänge sehen. Grundlagen verstehen. Selbst erklären.]
#v(5mm)
#bild("cover", [Schematische Illustration der Bauteile und Energieübertragungen im Modul. Eigens erzeugt; nicht maßstäblich.], height: 68mm)
#v(4mm)
#text(size: 12pt, fill: teal)[Systemgrenze → Bilanz → Stoffmodell → Anwendung]
]

#note("Dein Feynman-Schritt", [Sieh dir die Abbildung an. Erkläre dann ohne Vorlage: *Was passiert? Warum? Wann gilt die Formel?* Erst anschließend vergleichst du deine Erklärung mit dem Text und den Formeln.])

Stand: *24.10.2026*. Behandelt sind die Vorlesungsinhalte bis „Ende VL 21.10“ und die ergänzenden Übungen aus Tutorium und WZF bis 23.10.; die ältere Altklausurzuordnung und die Gesamtübersicht sind im Wegweiser eingeordnet. Lösungen stehen getrennt hinter den Aufgaben, im Anhang ausschließlich die Formelsammlung; die nur angekündigten Vorlesungsbeispiele zu Pumpspeicher und Strahltriebwerk bleiben offen.

#pagebreak()
#heading(level: 1, outlined: false)[Wegweiser]
#block[
#set text(size: 9.5pt)
#set par(leading: 0.3em, spacing: 0.15em)
#outline(title: none, depth: 2, indent: auto)
]
#v(2mm)
#text(size: 8.5pt, fill: muted)[*Quellenkürzel:* L = Lernskript 18.10.2026; N = Vorlesungsseiten 21.10.2026 mit deinen Notizen; V = Vorlesungsskript; Ü = Übungsaufgaben; T = Tutorium 15.10.2026; W = WZF 16.10.2026; R = handschriftliche Übungsrechnungen; T22 = Tutorium 22.10.2026; W23 = WZF 23.10.2026; M1 = Musterlösung Ü 1.14 (3 Seiten); M2 = Musterlösung Ü 2.1 (8 Seiten); B = FET Big Picture, Dennis Lehner, V06; K = ältere Altklausurübersicht „Kurzfragen“, Stand 26.11.2010; BT = Thermodynamik für Ingenieure; BS = Technische Strömungslehre. „PDF-S.“ zählt ab der ersten PDF-Seite; bei N ist „S.“ ebenfalls die PDF-Seite. Bestehende Nachschlagestellen bis 20.10. nennen Seiten von L; neue verlinkte Verweise berechnen Abschnitt und Seite im aktuellen Lernskript automatisch.]

#pagebreak()
#heading(level: 2, outlined: false)[FET als Zusammenhang]
Die Gesamtübersicht *Big Picture* verbindet Thermodynamik und Strömungsmechanik. Für den bisher behandelten Stoff ergibt sich dieselbe Denkkette: System wählen, Bilanz aufstellen, Zustand mit einem Stoffmodell beschreiben und das Ergebnis prüfen.
#bild("map-fet", [Zusammenhang des bisher behandelten Stoffes. Eigene Darstellung nach B, PDF-S. 2, 4–5, 8 und 18–20.], height: 43mm)
#tab(columns: (1fr, 2.2fr),
 th([Verbindung], [So nutzt du sie im Lernskript]),
 [Masse ↔ Volumenstrom], [$dot(m)=rho A c$ aus Kapitel 1 bleibt beim Verdampfen erhalten; $dot(V)$ ändert sich mit dem Stoffzustand in Kapitel 2.],
 [Stoffwert ↔ Energiebilanz], [$h=u+p v$ verbindet Kapitel 2 mit dem ersten Hauptsatz in Kapitel 3. Der Stickstoffbehälter zeigt zusätzlich eine offene, zeitabhängige Bilanz.],
 [Gesamtübersicht ↔ Vorlesungsstand], [B enthält auch spätere Themen wie Exergie, Kreisprozesse, Rohrreibungsverluste und Impulssatz. Ohne Nachweis ihrer Behandlung werden daraus hier keine zusätzlichen Lehrkapitel.],
)
#src[B, PDF-S. 2, 4–9 und 18–24; Zuordnung zum bisherigen Stand: eigene Darstellung.]

#heading(level: 2, outlined: false)[Ältere Altklausurübersicht · Thermodynamik]
Die Unterlage K ordnet Aufgaben aus alten Prüfungen zu. Ihr Stand ist *26.11.2010 (WS 10/11)*. Sie empfiehlt, bei den jüngeren Prüfungen dieser damaligen Auswahl zu beginnen. Die folgende Zuordnung übernimmt die Angaben vollständig; *PF* bedeutet Prüfung, *LN* Leistungsnachweis.
#note("Zeitlich einordnen", [Diese Liste dokumentiert die damalige Auswahl. Die Prüfungsform und der verbindliche Umfang für WS 2026/27 bleiben offen. Die hier genannten Originalprüfungen von 1999 bis 2006 liegen im aktuellen FET-Bestand nicht vor; die vorhandenen späteren Klausuren bleiben zusätzliche Quellen.], fill: sand)
#tab(columns: (1.5fr, 1.5fr, 0.8fr),
 th([Prüfung laut K], [Kurzfragen laut K], [Rechnen]),
 [WS 05/06 PF], [1–12; 21], [A1],
 [WS 04/05 PF], [1–10; 22], [A1],
 [WS 03/04 PF], [1–11; 22], [A1],
 [WS 02/03 PF], [1–12; 20; 21], [A1],
 [WS 01/02 PF], [1–12; 17], [A1],
 [WS 00/01 PF], [1–9; 15], [A1],
 [WS 99/00 PF], [1–10; 14], [A1],
 [WS 99/00 LN], [1–9; 14], [A1],
 [WS 99/00 Übungsklausur], [1–11; 14], [A1],
)
#src[K, PDF-S. 1, Abschnitt a; Abgleich der vorhandenen Prüfungsdateien am 24.10.2026.]

#pagebreak()
#heading(level: 2, outlined: false)[Ältere Altklausurübersicht · Strömungsmechanik]
Auch diese Tabelle gibt die *historische* Auswahl aus K wieder. Die Nummern sind Aufgaben- und Fragennummern der jeweiligen alten Prüfung; sie sind keine Abschnittsnummern dieses Lernskripts. „Nicht verlangt“ bezeichnet ausschließlich die damaligen Angaben der Quelle.
#tab(columns: (0.95fr, 1.55fr, 0.6fr, 1.6fr),
 th([Prüfung], [Kurzfragen laut K], [Rechnen], [Damals nicht verlangt]),
 [SS 06 PF], [1¹; 2–7; 9–13; 15], [A1–3], [4: Potentialströmung; 5: Umströmung],
 [WS 05/06 PF], [1¹; 2–12], [A1–3], [4: Potentialströmung; 5: Tragflügel],
 [SS 05 PF], [1¹; 2–13], [A1–3], [4: Potentialströmung; 5: Grenzschicht],
 [SS 05 LN], [Keine Kurzfragen gestellt], [A2], [4: Potentialströmung; 5: Grenzschicht],
 [WS 04/05 PF], [Laut K nicht bereitgestellt], [–], [–],
 [SS 04 PF], [1¹; 2; 8–13], [A1–3], [4: Potentialströmung; 5: Tragflügel],
 [WS 03/04 PF], [1¹; 2–15; 18], [A1–3], [4: Potentialströmung; 5: Grenzschicht],
 [SS 03 PF], [1¹; 2–16], [A1–3], [4: Potentialströmung; 5: Tragflügel],
 [WS 02/03 PF], [1¹; 2–12; 18; 20], [A1–3], [4: Potentialströmung; 5: Tragflügel],
 [SS 02 PF], [1¹; 2; 6; 7; 10–13], [A1–3], [4: Potentialströmung; 5: Tragflügel],
 [WS 01/02 PF], [1¹; 2–8; 10–13], [A2–3], [1: Umströmung mit Reibung; 4: Potentialströmung; 5: Tragflügel],
 [SS 01 PF], [1¹; 3–8; 10–13; 15], [A2–3], [1: Umströmung mit Reibung; 4: Potentialströmung; 5: Grenzschicht],
 [SS 01 LN], [Gruppe 1–3; Gruppe 8; Lösungsvergleich „Böswirth“ laut K], [A2–3], [1: Umströmung mit Reibung; 4: Potentialströmung; 5: Grenzschicht],
 [WS 00/01 PF], [Laut K nicht bereitgestellt], [–], [–],
 [SS 00 PF], [1¹; 2–6], [A2–3], [1: Ähnlichkeit; 4: Potentialströmung; 5: Grenzschicht],
 [SS 00 LN], [1–8¹; 9–17; 21; 28], [A2–3], [1: Ähnlichkeit; 4: Potentialströmung; 5: Umströmung, $c_w$],
)
#text(size: 9pt, fill: muted)[¹ In K auf die damals „bekannten Kennzahlen“ eingeschränkt. Beim SS 00 LN gilt der Zusatz für 1–8. „–“ kennzeichnet hier eine fehlende Angabe, keine ausgeschlossene Aufgabe.]

#note("So nutzt du die Zuordnung", [Suche beim Vorliegen einer Originalprüfung zuerst die passende Zeile, lies dann die tatsächlich gestellte Aufgabe und ordne sie einem bereits behandelten Zusammenhang zu. Ohne die Originalaufgabe lässt sich aus einer Nummer allein kein Inhalt und keine Musterlösung ableiten. Die Verständnis- und Rechenaufgaben dieses Skripts folgen weiterhin dem belegten Vorlesungsstand.])
Der Abschnitt *c) Wärmeübertragung* ist in K nur als Überschrift vorhanden; dazu enthält die Datei keine Aufgabenliste.
#src[K, PDF-S. 1, Abschnitte b–c; Anwendungshinweis: ergänzte Einordnung.]

#pagebreak()
= Kapitel 1 · Grundbegriffe

Wir bauen eine wiederverwendbare Lösungsstrategie auf: zuerst den betrachteten Ausschnitt festlegen, dann Masse und Energie bilanzieren. Zustandsgrößen und Stoffgesetze übersetzen das Bilanzergebnis anschließend in Druck, Temperatur oder Volumen. Die Prozessbedingungen entscheiden, welche Vereinfachungen erlaubt sind.

== 1.0 Was ist Thermodynamik?
Eine Fahrradpumpe erwärmt Luft durch Arbeit. Ein Wasserkocher erwärmt Wasser durch Energiezufuhr. Eine Turbine gewinnt Arbeit aus einem Stoffstrom. Wir verfolgen jeweils *Zustand, Masse und Energie*.

Ein *Fluid* ist eine Flüssigkeit oder ein Gas. Unter anhaltender Schubspannung fließt es; ein Festkörper kann eine statische Schubspannung tragen.

Wir beschreiben die Anlage von außen mit messbaren Größen, statt jedes Molekül einzeln zu verfolgen. Die Massenbilanz sagt, wie sich der Stoffbestand verändert. Die Energiebilanz sagt, welche Energieänderung zu den Übertragungen passt. Erst das Stoffmodell verknüpft diese Ergebnisse mit Druck, Temperatur und Volumen.

== 1.1 Das thermodynamische System
Das *System* ist der betrachtete Ausschnitt. Die reale oder gedachte Grenze trennt ihn von der *Umgebung*. Nur Übertragungen über diese Grenze gehören in seine äußere Bilanz.
#bild("boundary", [System und Umgebung; innere Übertragungen verschwinden in der gemeinsamen Gesamtbilanz. BT, PDF-S. 34.], height: 35mm)

*Beispiel Boiler:* Nur Wasser als System: Energie kommt vom Heizer als Wärme. Wasser *und* Heizer als System: Energie kommt über das Kabel als elektrische Arbeit. Die Grenze entscheidet über die Beschreibung.

#note("In eigenen Worten", [Eine Bilanz ist die Buchhaltung eines gewählten Ausschnitts. Ich muss zuerst wissen, *wo seine Grenze verläuft*.])
#src([L 1.0–1.1, PDF-S. 3–4; V PDF-S. 2–7.])

=== 1.1.1 Bilanzen
Eine Badewanne füllt sich, wenn mehr hinein- als hinausfließt. Eine *Rate* sagt, wie schnell sich der Bestand ändert; der *Bestand* sagt, wie viel gerade vorhanden ist.
#bild("bath", [Badewanne als anschauliche Bilanzhülle. Ausschnitt V, PDF-S. 8.], height: 47mm)
#form[$ (dif m_"Sys")/(dif t)=sum dot(m)_"ein"-sum dot(m)_"aus" $]
$m$: Masse in kg; $dot(m)$: Massenstrom in kg/s. Für die betrachteten Vorgänge wird keine Gesamtmasse erzeugt. Stationär ist die linke Seite null.

Aus der Rate wird der Bestand durch Aufsummieren über die Zeit:
$ m(t)=m_0+integral_0^t dot(m)_"netto" dif tau $
Die Anfangsmasse $m_0$ darf nicht fehlen. Bei konstanter Rate: $m=m_0+dot(m)_"netto"t$. Die orientierte Fläche unter der Netto-Stromkurve ist die Änderung der gespeicherten Masse.

*Energie, geschlossen:* Bei vernachlässigbarer Änderung von Bewegungs- und Lageenergie gilt in der Zufuhrkonvention:
$ Delta U=Q_12+W_12 $
Zufuhr zählt positiv. Beispiel: 100 J Wärme hinein und 40 J Arbeit hinaus ergeben $Delta U=60 thin "J"$. $W$ umfasst alle Arbeitsformen.

*Energie, stationär offen:* Ein Ein- und Austritt, gleicher Massenstrom:
$ dot(Q)+P_t=dot(m)[h_2-h_1+(c_2^2-c_1^2)/2+g(z_2-z_1)] $
$h$: Enthalpie je kg; $c$: Geschwindigkeit; $z$: Höhe; $P_t$: technische Zufuhrleistung. Nur vernachlässigbare Beiträge entfallen.
#bild("map-balance", [Mindmap: Wie Strom, Bestand und Erhaltung zusammenhängen. Eigene Darstellung.], height: 46mm)
#note("Fehler vermeiden", [*Joule* ist eine Energiemenge. *Watt* ist Energie pro Zeit: $1 thin "W"=1 thin "J/s"$. Stationär verschwinden die Speicheränderungen, nicht die Ströme.], fill: sand)
Die Bilanz ist zunächst eine Erhaltungsaussage, noch kein Stoffgesetz. Sie sagt beispielsweise, wie viel Energie im Wasser gespeichert wird. Um daraus die Temperaturänderung zu berechnen, brauchst du zusätzlich Masse und Wärmekapazität. Bei einem Gas können außerdem Volumenarbeit und eine andere Stoffbeziehung wichtig werden. Deshalb folgen auf die Bilanz immer Modellwahl und Zustandsbeschreibung.

#src([L 1.1.1, PDF-S. 4–6; V PDF-S. 8–9 und 17.])

=== 1.1.2 Wie Energie über die Systemgrenze kommt
#bild("transfers", [Arbeit durch Bewegung, Wärme wegen Temperaturunterschied und Energie mit strömender Masse. BT, PDF-S. 35.], height: 42mm)

*Wärme* ist Energieübertragung wegen eines Temperaturunterschieds. *Arbeit* umfasst etwa Kolben-, Wellen- und elektrische Übertragung. Beide sind Prozessgrößen; gespeichert wird beispielsweise innere Energie.

Ein Stoffstrom bringt innere Energie mit und muss gegen Druck in den Kontrollraum geschoben werden. Zusammen ergibt das *Enthalpie*:
$ H=U+p V quad quad h=u+p v quad quad dot(H)=dot(m)h $
$H$ in J, $h$ in J/kg. Die Schubarbeit $p v$ steckt bereits in $h$ und darf in der üblichen Strömungsbilanz nicht nochmals als Wellenarbeit addiert werden.

#tab(columns: (1fr, 2fr),
 th([Arbeitsform], [Ansatz und Voraussetzung]),
 [Volumenarbeit], [$W_v=-integral p dif V$; Systemdruck bei quasistatischer Grenzbewegung. Allgemein zählt der wirksame äußere Druck.],
 [Technische Arbeit], [$w_t=integral v dif p$; reversibel, Änderungen von Bewegungs- und Lageenergie vernachlässigt.],
)
*Innere Energie und Enthalpie einordnen.* Die innere Energie gehört zum Stoffzustand. Bei einem geschlossenen ruhenden Behälter betrachten wir ihre Änderung direkt. Bei einem durchströmten Kontrollraum erleichtert die Enthalpie das Rechnen, weil sie innere Energie und den zum Hinein- beziehungsweise Herausschieben gehörenden Druck-Volumen-Anteil zusammenfasst. Die Wahl ergibt sich aus dem Systemmodell.

#src([L 1.1.2, PDF-S. 6–7; V PDF-S. 10–11.])

=== 1.1.3 Arten von Systemen und Wahl der Systemgrenze
#bild("map-system", [Mindmap: Vier verschiedene Aussagen über die Systemgrenze. Eigene Darstellung.], height: 50mm)

Ein durchströmter Kompressor ist *offen*. Die eingeschlossene Luft bei geschlossenen Ventilen ist *geschlossen*. Eine bewegliche Grenze macht ein System also nicht automatisch offen.

*Starr* bedeutet geometrisch $dif V=0$: keine Volumenarbeit. Rührer oder elektrische Anschlüsse können trotzdem Arbeit übertragen. Die Begriffe „rigid/arbeitsdicht“ werden im vereinfachten Vorlesungsmodell enger verwendet; prüfe deshalb die tatsächlich erlaubten Übertragungen.

#note("Selbst erklären", [Kann ein geschlossenes, starres, adiabates Gefäß über einen Heizstab wärmer werden? Ja: Wenn der elektrische Anschluss zur Grenze gehört, führt er Arbeit zu.])
Die vier Eigenschaften in der Mindmap werden einzeln geprüft. „Geschlossen“ beantwortet die Frage nach dem Stoffaustausch; „adiabat“ die nach Wärmeübertragung. Erst zusammen mit der Beweglichkeit der Grenze und möglichen Arbeitsanschlüssen ergibt sich ein vollständiges Modell. Aus einem einzigen dieser Wörter darfst du deshalb nicht alle übrigen Randbedingungen ableiten.

#src([L 1.1.3, PDF-S. 7–8; V PDF-S. 12–15. Arbeitsformen ergänzend präzisiert.])

=== 1.1.5 Typische Berechnung: Kraftwerk
#grid(columns: (1fr, 1fr), gutter: 7mm,
 [#bild("turbine", [Turbine, Ausschnitt V, PDF-S. 24.], height: 44mm)],
 [*1538 MW Brennstoffleistung*\
 $arrow.r$ Umwandlung mit $eta="0,52"$\
 *800 MW elektrische Nutzleistung*\
 Rund 738 MW verlassen die Gesamtanlage auf anderen Wegen.]
)
$ eta_"el"=P_"el"/dot(Q)_B quad => quad dot(Q)_B=800/"0,52" approx 1538 thin "MW" $
Mit $H_u=50 thin "MJ/kg"$: $dot(m)_B=dot(Q)_B/H_u approx "30,8" thin "kg/s"$. Bei $rho_n="0,7175" thin "kg/m"^3$ folgt $dot(V)_n approx "42,9" thin "m"^3/"s"$.

Jahreskosten: $K_B=k_B dot(Q)_B t_B$. Nur bei *angenommenen* 8760 Volllaststunden und 3 €/GJ ergeben sich etwa 146 Mio. €. Die Leistung allein legt die Betriebszeit nicht fest.
#src([L 1.1.5, PDF-S. 9; V PDF-S. 16.])

== 1.2 Gleichgewicht und stationärer Zustand
#tab(columns: (1fr, 2fr),
 th([Begriff], [Anschauliche Bedeutung]),
 [Gleichgewicht], [Kein antreibendes Ungleichgewicht unter den Randbedingungen. Thermisch: Temperaturausgleich; mechanisch: Kräftegleichgewicht; chemisch: keine Nettoänderung durch Reaktion.],
 [Stationär], [Am festen Ort bleiben die Werte zeitlich gleich. Ein Durchlauferhitzer darf dauerhaft kalten Eintritt und warmen Austritt haben.],
 [Homogen / heterogen], [Räumlich einheitliche Eigenschaften / beispielsweise Flüssigkeit und Dampf gemeinsam.],
 [Isotrop / isentrop], [Richtungsunabhängig / Entropie konstant.],
)

*Teilchenreise:* Ein Teilchen wandert in einer stationären Düse von einem langsamen zu einem schnellen Bereich und beschleunigt. Das Strömungsbild am festen Ort bleibt trotzdem gleich.

Ein stationärer Zustand kann nur durch fortlaufenden Austausch aufrechterhalten werden, etwa durch Heizleistung und Wasserströmung im Durchlauferhitzer. Das ist etwas anderes als Gleichgewicht ohne antreibende Temperaturunterschiede. Auch „homogen“ beschreibt eine andere Eigenschaft: Ein ideal gerührtes Bad kann überall dieselbe Temperatur haben und sich trotzdem im Laufe der Zeit erwärmen.

#src([L 1.2, PDF-S. 9–11; V PDF-S. 17–18; BS 1.2, PDF-S. 18–20.])

== 1.3 Nullter Hauptsatz und Temperaturmessung
Ein Thermometer C kann Temperaturen vergleichen, weil gilt:
$ T_A=T_C quad "und" quad T_B=T_C quad => quad T_A=T_B $
Messbar ist beispielsweise Flüssigkeitsausdehnung, elektrischer Widerstand oder eine Thermoelementspannung.
#bild("expansion", [Erwärmen verlängert den Stab. Der gelbe Anteil ist die Längenänderung. V, PDF-S. 47.], height: 38mm)
$ Delta L=alpha_L L_0 Delta T quad quad Delta V=alpha_V V_0 Delta T $
Die Ausdehnungskoeffizienten haben die Einheit $1/"K"$. Näherung für kleine Änderungen und ausreichend konstante Koeffizienten; bei isotropen Feststoffen $alpha_V approx 3 alpha_L$. Faustregel: 1 m Stahl wird bei 100 K etwa 1 mm länger.

#heading(level: 3, outlined: false)[Vom Temperaturverlauf zur Heizleistung]
Die Steigung der Temperaturkurve ist das „Gaspedal“ der Erwärmung:
#form[$ P_"el" approx m c (dif theta)/(dif t) $]
Modell: Wasser und Heizer geschlossen und nach außen adiabat; konstantes $m,c$; zusätzliche Speicher, Rührleistung und Verluste vernachlässigt.
#bild("heating-temperature", [Ü 1.4: Temperatur steigt erst geradlinig, dann parabolisch bis zum flachen Ende. Eigene Auswertung nach T und W.], height: 54mm)
#bild("heating-power", [Die Leistung ist proportional zur Steigung oben. Ohne Wassermasse ist nur W/kg bestimmbar.], height: 50mm)
10 K/h ergeben mit $c=4200 thin "J/(kg K)"$ *11,67 W/kg*. Im ideal adiabaten Halteabschnitt gilt $P=0$; real gleicht eine Halteleistung die Wärmeverluste aus. Vollständige Rechnung: Lösung 18.
#src([L 1.3, PDF-S. 11–12; L 1.1.1, PDF-S. 5–6; Ü 1.4, PDF-S. 5; T PDF-S. 4–9 (neu abgelegte Datei mit Dateinamensbeginn „2024-09-13“, handschriftlich 15.10.2026); W PDF-S. 1–3.])

== 1.4 Stoffmenge, Masse, spezifische und molare Größen
#bild("division", [Gedankliche Teilung eines homogenen Systems. Gesamtmengen teilen sich; intensive Werte bleiben gleich. V, PDF-S. 25.], height: 45mm)
#tab(columns: (1.1fr, 1.4fr, 1fr),
 th([Größe], [Definition], [Einheit]),
 [Masse], [$m=n M=rho V$], [kg],
 [Dichte], [$rho=m/V$], [kg/m³],
 [Spezifisches Volumen], [$v=V/m=1/rho$], [m³/kg],
 [Spezifische Energie], [$u=U/m$, $h=H/m$], [kJ/kg],
 [Molares Volumen], [$V_m=V/n=M v$], [m³/kmol],
)
*Spezifisch* heißt pro Kilogramm, *molar* pro Stoffmenge. Bei $n$ in kmol muss $M$ in kg/kmol stehen. 1 kmol enthält etwa $"6,022" times 10^26$ Teilchen.
Ein Kilogramm Wasser und ein Kilogramm Luft haben dieselbe Masse, benötigen aber sehr unterschiedliche Volumina. Das erfasst $v$: Es ist keine zusätzliche Stoffmenge, sondern ein Volumen je Kilogramm. Solche spezifischen Größen trennen die Stoffeigenschaft von der Gesamtmenge. Aus $h$ wird beispielsweise erst durch Multiplikation mit $m$ die Gesamtenthalpie $H$.

#src([L 1.4, PDF-S. 12–13; V PDF-S. 21 und 25.])

== 1.5 Ströme und Kontinuitätsgleichung
#bild("continuity", [Eine Stromröhre begrenzt den transportierten Stoffstrom. BS, PDF-S. 19.], height: 46mm)
#form[$ dot(V)=A c quad dot(m)=rho A c quad J=dot(m)/A $]
$A$ in m², $c$ in m/s, $dot(V)$ in m³/s, $dot(m)$ in kg/s; Massenstromdichte $J$ in kg/(m² s).

Stationär ohne weitere Ein- oder Austritte bleibt der Massenstrom gleich:
$ rho_1 A_1 c_1=rho_2 A_2 c_2 $
Nur bei konstanter Dichte: $A_1c_1=A_2c_2$. Halber *Durchmesser* ergibt ein Viertel der Fläche und vierfache Geschwindigkeit.
#bild("hose", [Gartenschlauch mit enger Düse. Eigens erzeugte Illustration; nicht maßstäblich.], height: 48mm)
*Ü 1.7:* 25 l in 50 s ergeben 0,5 l/s. Bei 20 mm Durchmesser: 1,59 m/s; bei 8 mm: 9,95 m/s. Rechnung: Lösung 19.

Eine *Stromlinie* zeigt die momentane Geschwindigkeitsrichtung; eine *Bahnkurve* verfolgt ein Teilchen. Stationär stimmen beide überein. BS schreibt meist $w$, hier verwenden wir $c$ für die Geschwindigkeit.

#note("Zwei verschiedene Idealmodelle", [*Ideales Gas:* $p v=R T$, Dichte darf sich ändern. *Ideales Fluid in BS:* inkompressibel und reibungsfrei. Aus der Gasgleichung folgt keine Reibungsfreiheit.], fill: sand)
Die engere Düse erzeugt keine zusätzliche Masse. Bei fest vorgegebenem Volumenstrom muss sich das Fluid im kleineren Querschnitt schneller bewegen. Verändert sich die Dichte, wird die Aussage allgemeiner: Dieselbe Masse pro Sekunde kann an verschiedenen Orten unterschiedlich viel Volumen pro Sekunde beanspruchen. Das wird beim Verdampfer in Kapitel 2 besonders deutlich.

#src([L 1.5, PDF-S. 13–14; V PDF-S. 21–24; BS 1.2, PDF-S. 18–20.])

#heading(level: 3, outlined: false)[Brücke zur Strömungslehre: Bernoulli und Ausfluss]
Die Kontinuität erhält die Masse. Bernoulli beschreibt den Austausch von Druck-, Bewegungs- und Lageenergie:
$ p/rho+c^2/2+g z="konstant" $
Gültig entlang einer Stromlinie: stationär, inkompressibel, reibungsfrei, ohne Maschinenarbeit. Alle Summanden haben die Einheit J/kg.
#bild("bernoulli", [Höhe kann in Geschwindigkeit übergehen. BS, PDF-S. 49.], height: 46mm)

Großer offener Behälter, kleiner Auslass, gleiche Umgebungsdrücke und vernachlässigte Verluste:
$ c_0=sqrt(2 g h) quad quad A (dif h)/(dif t)=-A_0 sqrt(2 g h) $
Sinkt $h$, sinkt auch der Ausfluss. Der Behälter ist instationär, der lokale Ausfluss wird quasistationär modelliert.
#bild("drain-plot", [Ü 1.5, vereinfachtes Modell: Die erste Volumenhälfte fließt schneller ab als die zweite. Eigene Rechnung; Lösung 20.], height: 54mm)
#src([L: Kontinuität 1.5, PDF-S. 13–14, Druck 1.7, PDF-S. 19–20. Bernoulli ergänzt nach BS 2.1, PDF-S. 48–55; Ü 1.5, PDF-S. 5.])

== 1.6 Thermodynamische Zustandsgrößen
#bild("states", [Zwei Zustände sind zwei Momentaufnahmen. Der Pfeil beschreibt den Prozess dazwischen. V, PDF-S. 37.], height: 35mm)
*Zustandsgrößen* beschreiben das aktuelle System. Ihre Änderung hängt nur von den Endzuständen ab. *Wärme und Arbeit* beschreiben Übertragungen auf dem Weg.

#tab(columns: (1fr, 1.8fr),
 th([Einteilung], [Beispiele und Bedeutung]),
 [Extensiv], [$m,V,U,H,S$ addieren sich bei der Systemteilung.],
 [Intensiv], [$p,T,rho,v,h$ bleiben bei Teilung eines homogenen Zustands gleich.],
 [Thermisch], [$p,T,V$: Druck, Temperatur, Volumen.],
 [Kalorisch], [$U,H,S$: innere Energie, Enthalpie, Entropie.],
)
$U,H$ in J; $S$ in J/K; $s=S/m$ in J/(kg K). Entropie beschreibt später Prozessrichtung und Irreversibilität mit.

Im Kreisprozess kehrt jede Zustandsgröße zum Anfangswert zurück: $integral.cont dif Y=0$. Nettoübertragungen von Wärme oder Arbeit können trotzdem verbleiben.
#bild("map-state", [Mindmap: Zustand, Menge, Prozess und Stoffmodell unterscheiden. Eigene Darstellung.], height: 47mm)
Normzustand des Skripts: $p_n="1,01325" thin "bar"$, $T_n="273,15" thin "K"$. Ein Normvolumen braucht immer diesen Bezugszustand.
Bei einer Zustandsgröße reicht der Vergleich „Endwert minus Anfangswert“. Die innere Energie kann etwa durch Wärmeaufnahme oder durch zugeführte Arbeit steigen. Der gleiche Anstieg von $U$ verrät deshalb noch nicht, auf welchem Weg er zustande kam. Im Kreisprozess ist die Zustandsänderung insgesamt null; die einzelnen Übertragungen müssen es nicht sein.

#src([L 1.6, PDF-S. 14–16; V PDF-S. 25–26.])

#pagebreak()
=== 1.6.1 Zustandsfläche, ideales Gas und Zustandsdiagramme
Für einen einfachen reinen Stoff im einphasigen Gleichgewicht genügen zwei unabhängige intensive Angaben. Eine Zustandsfläche ist die Landkarte der zulässigen Kombinationen, etwa $p=p(v,T)$.
#grid(columns: (1fr, 1fr), gutter: 7mm,
 [#bild("piston", [Kolben-Gas-System, eigens erzeugte schematische Illustration.], height: 52mm)],
 [#form[$ p v=R T $\ $p V=m R T$]
 $p$: absolut in Pa; $T$: in K; $R$: in J/(kg K). Für Luft: $R="287,2" thin "J/(kg K)"$.

 *Bei 1 bar und 0 °C:* $v approx "0,7845" thin "m"^3/"kg"$, $rho approx "1,275" thin "kg/m"^3$.]
)
Für dieselbe geschlossene Gasmenge gilt $p_1V_1/T_1=p_2V_2/T_2$. Isochor folgt $p_2/p_1=T_2/T_1$. Differenziell: $dif p/p+dif v/v=dif T/T$.
#bild("pv-isolines", [Die Form im p-v-Diagramm folgt aus der jeweils konstanten Größe. Schematisch für ein ideales Gas.], height: 51mm)
Isentrop: $s$ konstant; beim idealen Gas mit konstanten Wärmekapazitäten steiler als die Isotherme. Isenthalp: $h$ konstant. Isovapor: $x$ konstant im Nassdampfgebiet.

#note("Gültigkeit", [Das ideale Gasmodell vernachlässigt Eigenvolumen und Wechselwirkungen. Nahe Kondensation oder bei hoher Dichte reicht es oft nicht aus. Ausreichend verdünnter Dampf kann dagegen näherungsweise ideal sein.], fill: sand)
Das ideale Gasmodell liefert eine anschauliche Ursache-Wirkungs-Beziehung: Bei festem Volumen führt Erwärmen zu höherem Druck. Vereinfacht stoßen die Teilchen stärker gegen die Wand. Bei gleichbleibender Temperatur verringert Vergrößern des Volumens dagegen den Druck. Entscheidend ist immer, welche Größe während der Änderung festgehalten wird; aus „Erwärmen“ allein folgt noch keine eindeutige Druckänderung.

#src([L 1.6.1, PDF-S. 16–19; V PDF-S. 27–33.])

== 1.7 Druck
#grid(columns: (0.9fr, 1.1fr), gutter: 6mm,
 [#bild("manometer", [U-Rohr-Manometer, V PDF-S. 35.], height: 63mm)],
 [Druck ist Normalkraft pro Fläche: $p=F_"normal"/A$.

 $1 thin "Pa"=1 thin "N/m"^2$; $1 thin "bar"=10^5 thin "Pa"$.

 *Absolutdruck* zählt vom Vakuum, *Überdruck* von der Umgebung:
 $p_"abs"=p_e+p_"amb"$

 Beispiel: 2,2 bar Überdruck + 0,96 bar Umgebung = *3,16 bar absolut*.]
)
Der Druckgradient trägt das Gewicht des ruhenden Wassers: Mechanisches Gleichgewicht verlangt Kräftegleichgewicht, nicht überall gleichen Druck.

Ruhende Flüssigkeit konstanter Dichte, Tiefe $h$ nach unten: $p=p_0+rho g h$. Bei Höhenkoordinate $z$ nach oben: $dif p/dif z=-rho g$.

Beim einfachen U-Rohr mit vernachlässigbarer Gasdichte: $abs(Delta p)=rho_M g Delta h$. Flüssige Messleitungen können einen Dichteunterschied statt nur $rho_M$ erfordern. Das Vorzeichen folgt aus dem Druckweg.

*Kolben:* 1 kg Zusatzmasse auf 1 cm² erzeugt $m g/A="0,981" thin "bar"$ Überdruck. Zehn Meter Wasser erzeugen ungefähr ein zusätzliches Bar.
Druck ist eine Zustandsgröße; die Druckdifferenz bestimmt, welche mechanische Wirkung zwischen zwei Seiten möglich ist. An einem Kolben zählt beispielsweise die Druckkraft jeder Seite. Für die Gasgleichung brauchst du dagegen den vom Vakuum aus gemessenen Absolutdruck. Die passende Druckangabe ergibt sich also aus der konkreten Gleichung.

#src([L 1.7, PDF-S. 19–20; V PDF-S. 34–35.])

== 1.8 Temperatur
#bild("kelvin", [Celsius und Kelvin haben dieselbe Schrittweite, aber verschiedene Nullpunkte. Eigene Darstellung.], height: 49mm)
$ T/"K"=theta/"°C"+"273,15" $
In der Gasgleichung und in Temperaturverhältnissen braucht man *Kelvin*. Eine Differenz von 10 °C entspricht 10 K. 60 °C ist nicht die dreifache absolute Temperatur von 20 °C.

Fahrenheit als Zahlenwert: $theta_C=(5/9)(theta_F-32)$. Somit entsprechen 68 °F genau 20 °C.
#src([L 1.8, PDF-S. 20–21; V PDF-S. 36.])

== 1.9 Zustandsänderungen und Prozessgrößen
Gleiche Endzustände erlauben verschiedene Wege. Die Zustandsänderung $Delta U$ ist gleich; Wärme und Arbeit können sich unterscheiden.
#bild("path-work", [Gleiche Punkte 1 und 2; unterschiedliche Flächen unter dem Weg. Geschlossene ideale Gasmenge, quasistatische Volumenarbeit. Eigene Zahlenillustration.], height: 54mm)
#form[$ W_v=-integral_(V_1)^(V_2) p dif V $]
Expansion hat $dif V>0$, also $W_v<0$: Arbeit verlässt das System. Kompression hat $W_v>0$. Im Bild ist der Arbeitsbetrag die Fläche; 1 bar·m³ = 100 kJ.

Isobar: $W_v=-p(V_2-V_1)$. Isotherm beim idealen Gas: $W_v=m R T ln(V_1/V_2)$.

Ein rechtsläufiger Kreisprozess expandiert bei höherem Druck und komprimiert bei niedrigerem Druck: Nettoarbeit nach außen, also negativ in der Zufuhrkonvention. Auch innere Ausgleichsvorgänge können Teilzustände ändern, ohne äußeren Austausch.
#src([L 1.9, PDF-S. 21–23; V PDF-S. 37–39.])

== 1.10 Modelle; reversibel und irreversibel
#bild("reversibility", [Heizen und Rühren verändern den Gaszustand. Rückwärtsrühren kann die dissipierte Arbeit nicht wieder zurückholen. V, PDF-S. 43.], height: 58mm)
*Reversibel* heißt: System *und Umgebung* ließen sich ohne bleibende Änderung zurücksetzen. Reibung und Wärmeübertragung über endliche Temperaturunterschiede verhindern das.

*Quasistatisch* heißt: gedachte Folge von Gleichgewichtszuständen. Ein langsamer Kolben mit Reibung kann quasistatisch und trotzdem irreversibel sein.

#tab(columns: (1fr, 1fr, 1fr, 1fr),
 th([isobar], [isochor], [isotherm], [adiabat]),
 [$p$ konstant], [$V$ konstant], [$T$ konstant], [$Q=0$],
)
Adiabat schließt Erwärmung durch Arbeit nicht aus. Energieerhaltung gilt auch bei irreversiblen Prozessen.
#bild("map-ptw", [Mindmap: Messgrößen, Arbeitsvorzeichen und Umkehrbarkeit. Eigene Darstellung.], height: 46mm)
Bei technischen „Verlusten“ verschwindet keine Energie. Reibung kann geordnete Bewegung in innere Energie umwandeln, die sich nicht vollständig auf demselben Weg zurückgewinnen lässt. Die Energiebilanz beantwortet die Mengenfrage. Ob ein Prozess umkehrbar ist, erfordert zusätzlich eine Aussage über seine Richtung und seine Wirkung auf die Umgebung.

#src([L 1.10, PDF-S. 23–25; V PDF-S. 40–43.])

*Der Zusammenhang in Kapitel 1.* Die Systemgrenze bestimmt die Übertragungen. Die Bilanz bestimmt die Speicherung beziehungsweise den Energieumsatz. Das Stoffmodell verbindet diese Größen mit dem Zustand. Der Prozessweg legt schließlich fest, welche Wärme und Arbeit zwischen den Zuständen übertragen werden.

#pagebreak()
== Verständnisfragen und Rechenaufgaben · Kapitel 1
#set enum(spacing: 0.85em)
Erkläre erst selbst. Bei Rechenfragen skizzierst du die Systemgrenze und schreibst die Annahmen auf. Die Lösungen folgen getrennt.

+ Wie würdest du Thermodynamik an einer Fahrradpumpe erklären?
+ Kann ein geschlossenes System Arbeit übertragen? Und ein adiabates?
+ Was ist der Unterschied zwischen konstantem Volumen und vollständiger Arbeitsdichtheit?
+ Warum sind interne Ströme in der Gesamtbilanz eines Kraftwerks nicht sichtbar?
+ Ein Tank enthält $500 thin "kg"$. Es fließen $2 thin "kg/s"$ hinein und $"2,5" thin "kg/s"$ hinaus. Bestimme Änderungsrate und Leerungszeit bei konstanten Strömen.
+ Warum kann eine stationäre Strömung räumliche Temperatur- und Geschwindigkeitsunterschiede besitzen?
+ Erkläre extensiv, intensiv und spezifisch am Beispiel eines geteilten Wasserbehälters.
+ Warum ist der Druck eine Zustandsgröße und die Arbeit eine Prozessgröße?
+ Luft: $V=2 thin "m"^3$, $p_1=5 thin "bar"$ absolut, $theta_1=20 thin "°C"$, $R="287,2" thin "J/(kg K)"$. Bestimme die Masse. Der geschlossene starre Behälter wird auf $80 thin "°C"$ erwärmt. Bestimme $p_2$.
+ Ein Manometer zeigt $"2,2" thin "bar"$, Umgebung $"0,96" thin "bar"$. Welcher Druck gehört in die Gasgleichung?
+ Bei stationärer inkompressibler Strömung halbiert sich der Rohrdurchmesser. Wie ändert sich die mittlere Geschwindigkeit?
+ Warum kann adiabates Rühren die Temperatur erhöhen, und warum ist es irreversibel?


#pagebreak()
#heading(level: 3, outlined: false)[Vertiefende Verständnisfragen und Rechenaufgaben]
Die folgenden Aufgaben verwenden die ergänzenden Unterlagen. Auszüge sind als solche markiert.
#block[
#set enum(start: 13)
+ Warum lässt sich aus $dif m/dif t$ allein die aktuelle Behältermasse nicht bestimmen? Wann darfst du einen zeitlichen Mittelwert als arithmetischen Mittelwert der beiden Randwerte berechnen?
+ Was unterscheidet ein ideales Gas von einem idealen Fluid? Kann ein stationär strömendes Teilchen beschleunigt sein?
+ *Zeitabhängiger Behälter, Ü 1.1:* Ein Behälter mit konstanter Fläche $A$ enthält anfangs $m_0=rho A h_0$. Es gelten $dot(m)_"zu"=z t$, $dot(m)_"ab"=a t$ und $rho="konstant"$. Bestimme $m(t)$, $h(t)$, die drei Fälle $z>a$, $z=a$, $z<a$, beide mittleren Massenströme und den mittleren Füllstand im Intervall $t_1$ bis $t_2$.
+ *Badewanne, Ü 1.2:* Anfangs leer, $400 thin "l"$ Inhalt, Zuflüsse $30 thin "l/min"$ und $"0,1" thin "l/s"$. Vom maximalen Abfluss $90 thin "l/min"$ bleiben 20 Prozent frei. Jedes Rostloch führt $"0,25" thin "l/min"$ ab. Berechne für ein Loch Massenänderung, Wasserinhalt als Zeitfunktion und Füllzeit. Bestimme den erforderlichen Überlauf bei vollständig blockiertem Bodenabfluss einschließlich Löchern sowie die maximal zulässige Lochzahl bei normalem Teilabfluss, damit der Pegel nicht sinkt. Nutze $rho=1 thin "kg/l"$ und konstante Ströme.
+ *Boiler, Ü 1.3:* $400 thin "l"$ Wasser sollen von 6 auf 80 °C erwärmt werden. Nutze $rho=1 thin "kg/l"$, die Mittelwerte $C_6="4,21037"$ und $C_80="4,18665" thin "kJ/(kg K)"$ mit Bezug auf 0 °C. Bestimme Energie und Leistung für 4 h, 6 h und 0,5 h. Für nachströmendes Kaltwasser mit 6 °C: Welche Dauerleistung deckt 1 l/min, welche 10 l/min? Warum kann ein Speicher den erforderlichen Spitzenwert der elektrischen Anschlussleistung verringern?
+ *Wasserbad, Ü 1.4, Tutorium und WZF:* Von 6 auf 70 °C wird mit 10 K/h geheizt. Die letzten 20 K bis 90 °C um 12:00 Uhr verlaufen parabolisch, am Übergang knickfrei und am Ende mit Steigung null. Bestimme Parabel, Übergangszeit, Einschaltzeit und spezifische Heizleistung mit $c=4200 thin "J/(kg K)"$. Es ist keine Wassermasse vorgegeben. Erläutere die Systemgrenze und die ideale Halteleistung.
+ *Gartenschlauch, Ü 1.7:* 25 l füllen einen Eimer in 50 s. Der Schlauchdurchmesser beträgt 20 mm, die Düsenöffnung 8 mm. Bestimme Volumenstrom und beide Geschwindigkeiten. Wie lange dauert das Füllen mit einem anderen Schlauch bei $dot(m)="0,2" thin "kg/s"$? Nutze $rho=1000 thin "kg/m"^3$.
+ *Freier Ausfluss, vereinfachter Teil von Ü 1.5:* Ein offener zylindrischer Behälter mit $D=1 thin "m"$, Anfangshöhe $H="1,25" thin "m"$ und Auslassdurchmesser $d="12,5" thin "mm"$ wird reibungsfrei entleert. Vernachlässige Auslasshöhe, Luftdichte und Oberflächengeschwindigkeit wie in Teil b der Originalaufgabe. Leite $h(t)$ und die Leerungszeit her. Wann ist die Hälfte des Anfangsvolumens abgeflossen?
+ *Förderpumpe, Ü 1.8:* Elektrisch werden 32 kW zugeführt, der Motor gibt 90 Prozent als Wellenleistung ab. Es gelten $dot(V)="0,125" thin "m"^3/"s"$, $rho=800 thin "kg/m"^3$, $Delta p=275 thin "kPa"$, $D_1=100 thin "mm"$, $D_2=150 thin "mm"$. Vernachlässige Höhen- und Temperaturänderung. Berechne Geschwindigkeiten, Netto-Förderleistung, Pumpenwirkungsgrad bezogen auf die Welle und Gesamtwirkungsgrad bezogen auf die elektrische Leistung.
]



#pagebreak()
== Lösungen Kapitel 1
#set enum(spacing: 0.65em)
+ Bei der Pumpe verändert zugeführte Arbeit den Gaszustand. Temperatur, Druck und Volumen beschreiben die Folge; die Energiebilanz erklärt die Energiezufuhr. #nachschlagen([Lernskript, Abschnitt 1.0, PDF-S. 3; Energieübertragung: Abschnitt 1.1.2, PDF-S. 6–7.])
+ Ja. Geschlossen verbietet nur Stofftransport; adiabat verbietet nur Wärmeübertragung. #nachschlagen([Lernskript, Abschnitt 1.1.3, PDF-S. 7–8.])
+ $dif V=0$ schließt Volumenarbeit aus. Rührer- und elektrische Arbeit müssen zusätzlich ausgeschlossen werden, wenn insgesamt keine Arbeit übertragen werden soll. #nachschlagen([Lernskript, Abschnitt 1.1.3, PDF-S. 7–8; Volumenarbeit: Abschnitt 1.9, PDF-S. 21–22. Die Unterscheidung zu anderen Arbeitsformen ist hier präzisiert.])
+ Sie verlassen die gemeinsame Bilanzhülle nicht. Eine Abgabe des einen Teils ist die Aufnahme des anderen. #nachschlagen([Lernskript, Abschnitt 1.1.3, PDF-S. 8, „Die Fragestellung bestimmt die Systemgrenze“.])
+ $dif m/dif t=-"0,5" thin "kg/s"$. Für die angenommene konstante Rate ist $t=500/"0,5"=1000 thin "s"="16,7" thin "min"$. #nachschlagen([Lernskript, Abschnitt 1.1.1, PDF-S. 4–5; entsprechende Kontrollaufgabe 13 mit Lösung auf PDF-S. 29.])
+ Stationär bedeutet zeitlich unverändert am festen Ort. Ein Teilchen kann auf seinem Weg dennoch andere Werte durchlaufen. #nachschlagen([Lernskript, Abschnitt 1.2, PDF-S. 9–11.])
+ Gesamtmasse und Gesamtvolumen halbieren sich. Dichte, Temperatur und spezifisches Volumen bleiben bei Teilung eines homogenen Zustands gleich. #nachschlagen([Lernskript, Abschnitt 1.4, PDF-S. 12–13; Abschnitt 1.6, PDF-S. 14–15.])
+ Der Druckunterschied zwischen zwei Zuständen hängt nur von deren Werten ab. Die Arbeit hängt zusätzlich vom Prozessweg ab, also von der Fläche unter der Kurve. #nachschlagen([Lernskript, Abschnitt 1.6, PDF-S. 14–16; Abschnitt 1.9, PDF-S. 21–23.])
+ $m=p_1 V/(R T_1)=10^6/("287,2" times "293,15") approx "11,88" thin "kg"$. Isochor: $p_2=p_1 T_2/T_1=5 times "353,15"/"293,15" approx "6,02" thin "bar"$ absolut. #nachschlagen([Lernskript, Abschnitt 1.6.1, PDF-S. 16–19; entsprechende Kontrollaufgaben 36–37 mit Lösungen auf PDF-S. 30.])
+ $p_"abs"="3,16" thin "bar"=316000 thin "Pa"$. #nachschlagen([Lernskript, Abschnitt 1.7, PDF-S. 19–20; entsprechende Kontrollaufgabe 38 mit Lösung auf PDF-S. 30.])
+ $A$ wird ein Viertel so groß. Wegen $A c="konstant"$ vervierfacht sich die Geschwindigkeit. #nachschlagen([Lernskript, Abschnitt 1.5, PDF-S. 13–14; entsprechende Verständnisfrage 26 mit Lösung auf PDF-S. 30.])
+ Rührarbeit wird in innere Energie umgewandelt. Die Umkehr der Drehrichtung kehrt die Dissipation nicht um; System und Umgebung lassen sich dadurch nicht spurlos zurücksetzen. #nachschlagen([Lernskript, Abschnitt 1.10, PDF-S. 23–25; entsprechende Verständnisfrage 33 mit Lösung auf PDF-S. 30.])


#block(breakable: false)[
#heading(level: 3, outlined: false)[13 · Bestand und zeitlicher Mittelwert]
Eine Rate sagt nur, *wie schnell sich etwas ändert*. Den aktuellen Bestand erhältst du erst mit einer Anfangsbedingung:
$ m(t)=m_0+integral_0^t dot(m)_"netto" dif tau $
Der Mittelwert der beiden Randwerte ist nur bei *linearem* Zeitverlauf zugleich der Zeitmittelwert. Bei einer Parabel gilt das allgemein nicht; unterschiedlich lange Messintervalle brauchen Zeitgewichte.
#nachschlagen([Lernskript, Abschnitt 1.1.1, PDF-S. 4–5, sowie Abschnitt 1.5, PDF-S. 13–14; vollständige Mittelwertherleitung zusätzlich in T PDF-S. 2–3 und Ü 1.1, PDF-S. 4.])
]


#block(breakable: false)[
#heading(level: 3, outlined: false)[14 · Die Modelle und die Beschleunigung]
*Ideales Gas:* $p v=R T$, veränderliche Dichte erlaubt. *Ideales Fluid in BS:* inkompressibel und reibungsfrei.

Ein Teilchen kann in einer stationären Düse beschleunigen, weil es räumlich verschiedene Geschwindigkeiten durchläuft. Am festen Ort bleiben die Werte zeitlich gleich: *konvektive Beschleunigung*.
#nachschlagen([Lernskript, Abschnitt 1.2, PDF-S. 9–11, und Abschnitt 1.6.1, PDF-S. 16–19. Die ausdrückliche Gegenüberstellung der Modelle ergänzt BS Abschnitt 1.2, Druck-S. 3–5 / PDF-S. 18–20.])
]


#block(breakable: false)[
#heading(level: 3, outlined: false)[15 · Zeitabhängige Massenbilanz]
*Modell:* offener Behälter, $rho,A,z,a$ konstant; $m_0=rho A h_0$. Gesucht: Bestand, Pegel, Mittelwerte.

*1 · Bilanz aufstellen und integrieren:*
$ (dif m)/(dif t)=(z-a)t quad => quad m=m_0+(z-a)t^2/2 $
*2 · Masse in Füllstand übersetzen:*
$ h=h_0+(z-a)t^2/(2 rho A) $
Für $t>0$: $z>a$ bedeutet Anstieg, $z=a$ konstanten Pegel, $z<a$ Abnahme.

*3 · Zeitmittelwerte:* Integral durch Intervalllänge teilen:
$ overline(dot(m))_"zu"=z(t_1+t_2)/2 quad overline(dot(m))_"ab"=a(t_1+t_2)/2 $
$ overline(h)=h_0+(z-a)/(6 rho A)(t_1^2+t_1t_2+t_2^2) $
Dahinter steckt $overline(h)=integral_(t_1)^(t_2)h(t)dif t/(t_2-t_1)$ und die Integration von $t^2$ zu $t^3/3$.

*Prüfung:* Bei $z=a$ bleiben Masse und Pegel konstant. $(z-a)t^2$ hat die Einheit kg. Nach Erreichen von $h=0$ ist die Formel nicht als negativer realer Pegel gültig.
#nachschlagen([Lernskript, Abschnitt 1.1.1, PDF-S. 4–5, und Ströme in Abschnitt 1.5, PDF-S. 13–14. Original: Ü Aufgabe 1.1, PDF-S. 4 / Druck-S. 1; ausführliche Tutoriumsrechnung T PDF-S. 1–3.])
]


#block(breakable: false)[
#heading(level: 3, outlined: false)[16 · Badewanne vollständig bilanzieren]
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
#nachschlagen([Lernskript, Abschnitt 1.1.1, PDF-S. 4–5, und Übungen in Abschnitt 1.3, PDF-S. 12; Original Ü Aufgabe 1.2, PDF-S. 4 / Druck-S. 1; R PDF-S. 1–2. Rechnung hier unabhängig mit den Originalströmen geprüft.])
]


#block(breakable: false)[
#heading(level: 3, outlined: false)[17 · Boiler, Mittelwert und Spitzenlast]
#bild("boiler", [Energie wird im warmen Wasser gespeichert und kann eine kurzzeitige Spitzenlast abdecken. Eigens erzeugte Illustration.], height: 47mm)
*Modell:* Wasser und Heizer geschlossen und nach außen adiabat; Verluste und Behälterwärmekapazität vernachlässigt. $m=400 thin "kg"$. Den Flüssigkeits-Energieanstieg nähern wir durch die isobare Enthalpiedifferenz an.

*1 · Tabellenbezug 0 °C berücksichtigen:*
$ Delta h="4,18665" times 80-"4,21037" times 6="309,66978" thin "kJ/kg" $
*2 · Energiemenge:* $W_"el" approx m Delta h="123,87" thin "MJ"$.

*3 · Leistung = Energie / Zeit:*
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
#nachschlagen([Lernskript, Abschnitt 1.1.1, PDF-S. 5–6, und Boilerbeispiel in Abschnitt 1.3, PDF-S. 12; Original Ü Aufgabe 1.3, PDF-S. 4, Stoffwerttabelle PDF-S. 19; R PDF-S. 2–3; BT Abschnitt 6.4, PDF-S. 213–214. Die genaue Mittelwertauswertung ist hier ergänzt.])
]


#block(breakable: false)[
#heading(level: 3, outlined: false)[18 · Wasserbad mit knickfreiem Temperaturverlauf]
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
#nachschlagen([Lernskript, Bilanzgrundlagen Abschnitt 1.1.1, PDF-S. 5–6, und Übungsbezug Abschnitt 1.3, PDF-S. 12. Die vollständige Rampenrechnung ergänzt Ü Aufgabe 1.4, PDF-S. 5 / Druck-S. 2; T PDF-S. 4–9 und W PDF-S. 1–3.])
]


#block(breakable: false)[
#heading(level: 3, outlined: false)[19 · Gartenschlauch und Düse]
*Strategie:* Füllmenge / Zeit liefert den Volumenstrom; dann $c=dot(V)/A$.
$ dot(V)=25/50 thin "l/s"="0,5" thin "l/s"=5 times 10^(-4) thin "m"^3/"s" $
$ A_1=pi ("0,020" thin "m")^2/4="3,1416" times 10^(-4) thin "m"^2 $
$ A_2=pi ("0,008" thin "m")^2/4="5,0265" times 10^(-5) thin "m"^2 $
Somit *$c_1="1,59" thin "m/s"$* und *$c_2="9,95" thin "m/s"$*.

Anderer Schlauch: $dot(V)=dot(m)/rho="0,2" thin "l/s"$, also *$t=25/"0,2"=125 thin "s"$*. Die größere Geschwindigkeit in der Düse passt zum kleineren Querschnitt bei vorgegebenem Volumenstrom.
#nachschlagen([Lernskript, Abschnitt 1.5, PDF-S. 13–14; Original Ü Aufgabe 1.7, PDF-S. 6 / Druck-S. 3; Kontinuität auch BS Abschnitt 1.2, Druck-S. 4–5 / PDF-S. 19–20.])
]


#block(breakable: false)[
#heading(level: 3, outlined: false)[20 · Füllstandsabhängiger Ausfluss]
*Modell:* großer offener Zylinder, kleine Öffnung auf Bodenniveau, konstante Dichte, keine Verluste, gleiche Umgebungsdrücke. Der lokale Ausfluss wird quasistationär modelliert.

*1 · Bernoulli:* $c_0=sqrt(2 g h)$.

*2 · Speicherung:* $rho A dif h/dif t=-rho A_0c_0$; $rho$ kürzt sich.

*3 · Variablen trennen und integrieren:*
$ integral_H^(h(t)) (dif h)/sqrt(h)=-(A_0/A)sqrt(2g)integral_0^t dif t $
$ 2(sqrt(h)-sqrt(H))=-(A_0/A)sqrt(2g)t $
$ h(t)=(sqrt(H)-(A_0/A)sqrt(g/2)t)^2 $
*4 · Leerlaufen bei $h=0$:*
$ A/A_0=(D/d)^2=6400 $
$ t_"leer"=(A/A_0)sqrt(2H/g) approx 3231 thin "s"="53,85" thin "min" $
Halbes abgeflossenes Volumen bedeutet im Zylinder $h=H/2$:
$ t_(1/2)=t_"leer"(1-1/sqrt(2)) approx 946 thin "s"="15,77" thin "min" $
*Prüfung:* Die erste Hälfte fließt wegen der größeren Druckhöhe schneller ab. Die Formel endet beim Leerlaufen; danach bleibt $h=0$. Die originale Auslasshöhe von 10 mm ist hier ausdrücklich vernachlässigt.
#nachschlagen([Lernskript: Massenbilanz Abschnitt 1.1.1, PDF-S. 4–5; Kontinuität Abschnitt 1.5, PDF-S. 13–14; Hydrostatik Abschnitt 1.7, PDF-S. 19–20. Die Bernoulli-/Torricelli-Herleitung steht dort nicht eigenständig: BS Abschnitt 2.1, Druck-S. 33–40 / PDF-S. 48–55; Ü Aufgabe 1.5 b–d, PDF-S. 5 / Druck-S. 2.])
]


#block(breakable: false)[
#heading(level: 3, outlined: false)[21 · Förderleistung und Wirkungsgrade]
*Modell:* Höhen- und Temperaturänderung vernachlässigt. Gesucht ist die Nettoleistung für Druck *und* Bewegungsenergie.

*1 · Motor:* $P_"Welle"="0,9" times 32="28,8" thin "kW"$.

*2 · Strömung:* $c=dot(V)/(pi D^2/4)$ liefert $c_1="15,92"$, $c_2="7,07" thin "m/s"$. Massenstrom: $dot(m)=800 times "0,125"=100 thin "kg/s"$.

*3 · Förderleistung:*
$ Delta dot(E)=dot(V)Delta p+dot(m)(c_2^2-c_1^2)/2 $
$ Delta dot(E)="34,375" thin "kW"-"10,163" thin "kW"="24,21" thin "kW" $
Die Erweiterung senkt die Geschwindigkeit und damit den kinetischen Anteil. Nur $dot(V)Delta p$ zu verwenden wäre hier unvollständig.

*4 · Wirkungsgrade:*
$ eta_"Pumpe"="24,21"/"28,8" approx "0,841" quad eta_"gesamt"="24,21"/32 approx "0,757" $
*Energiefluss:* 32 kW elektrisch → 28,8 kW Welle → 24,21 kW Fluid. Verluste: 3,2 kW im Motor, 4,59 kW in der Pumpe. Der Gesamtwirkungsgrad ist das Produkt der beiden Teilwirkungsgrade.
#nachschlagen([Lernskript, Energieübertragung Abschnitte 1.1.1–1.1.2, PDF-S. 5–7; Wirkungsgrad Abschnitt 1.1.5, PDF-S. 9; Kontinuität Abschnitt 1.5, PDF-S. 13–14. Original Ü Aufgabe 1.8, PDF-S. 7 / Druck-S. 4; Rechnung hier neu ausgeführt.])
]


#pagebreak()
= Kapitel 2 · Stoffeigenschaften

Die Bilanzmethode bleibt erhalten. Neu ist, dass Energiezufuhr auch die Phase des Stoffes verändern kann. Deshalb müssen wir vor der Rechnung erkennen, in welchem Zustandsgebiet der Stoff liegt. Die Diagramme liefern dafür die Orientierung; Stoffwerttabellen und Mischungsregeln liefern anschließend die Zahlen.

== 2.1 Die Erwärmungskurve: fest → flüssig → Dampf
Zugeführte Energie kann die Temperatur erhöhen (*fühlbar*) oder den Phasenanteil verändern (*latent*). Darum zeigt die Erwärmungskurve verschiedene Abschnitte.
#bild("warming", [1 kg Wasser bei 1 bar: vom Eis bei −15 °C bis zum Dampf bei 200 °C. Vereinfachte Rechenvariante aus Ü 2.2; Lösung 18.], height: 59mm)
#tab(columns: (1.1fr, 1.7fr),
 th([Was passiert?], [Wohin geht die Energie?]),
 [Einphasig erwärmen], [Temperatur steigt: näherungsweise $Q=m c Delta T$.],
 [Schmelzen / Verdampfen], [Phase wandelt sich um. Isobar im Gleichgewicht bleibt bei einem reinen Stoff die Temperatur konstant.],
)
#bild("energy-parts", [Energieanteile zur Kurve oben. Besonders viel Energie steckt in der Verdampfung. Eigene Rechnung.], height: 47mm)

Steht wie in der Mitschrift die Temperatur auf der waagerechten Achse, erscheint derselbe Phasenwechsel senkrecht. Hier steht die Temperatur auf der senkrechten Achse: Der Phasenwechsel ist waagerecht.

Beim isobaren Modell eines geschlossenen Systems mit nur Volumenarbeit und vernachlässigbaren äußeren Energieänderungen gilt $Q=Delta H$. Die Sättigungsenthalpiedifferenz ist $r=h''-h'$; vollständiges Verdampfen benötigt $Q=m r$.

#heading(level: 3, outlined: false)[Mittlere Wärmekapazität: den Tabellenbezug beachten]
Ein auf 0 °C bezogener Mittelwert $C_theta$ umfasst den Bereich 0 → $theta$. Für 6 → 80 °C zieht man den bereits vorhandenen Anteil ab:
$ Delta h=(C_80 times 80-C_6 times 6)(1 thin "K") $
80 und 6 sind hier ausdrücklich Celsius-Zahlenwerte. Allgemein gilt $Delta h=integral_(T_1)^(T_2)c_p(T)dif T=overline(c)_(p,12)Delta T$. Beim idealen Gas gilt zudem $dif u=c_v dif T$ und $dif h=c_p dif T$.
Nicht einfach den 0→80-Mittelwert mit 74 K multiplizieren. Das Intervall ist ein anderes. Beispiel Boiler: Lösung 17 in Kapitel 1; Bottich: Lösung 20 in Kapitel 2.
#bild("map-heat", [Mindmap: Wann steigt die Temperatur und wann verändert sich der Phasenanteil? Eigene Darstellung.], height: 46mm)
Die Wärmekapazität beschreibt den Energiebedarf je Temperaturänderung. Für dieselbe Masse bedeutet größeres $c$: Mehr Energie ist für ein Kelvin Erwärmung erforderlich. Während eines Phasenwechsels reicht diese Beschreibung nicht aus. Dann ändern sich die innere Struktur und gegebenenfalls das Volumen des Stoffes; die zusätzliche Phasenwechselenergie wird durch die passende Enthalpiedifferenz erfasst.

#src([L 2.1, PDF-S. 32–34; Ü 2.2, PDF-S. 13 und Tabelle PDF-S. 19; BT 6.4, PDF-S. 213–214.])

== 2.2 Ideales Gas als Teil des realen Verhaltens
Der *Realgasfaktor* misst die Abweichung von der idealen thermischen Beziehung:
#form[$ Z=(p v)/(R T) quad quad p V=m Z R T $]
Ideal gilt $Z=1$. Real hängt $Z$ vom Zustand ab. Hohe Dichte und die Nähe zur Kondensation machen Abweichungen oft bedeutsam.

Geschlossene starre Flasche, gleiche Gaszusammensetzung:
$ p_2/p_1=(Z_2 T_2)/(Z_1 T_1) $
#bild("oxygen", [Ü 2.5: dieselbe Abkühlaufgabe, zwei Stoffmodelle. Nur ideal gilt hier p/T = konstant. Eigene Rechnung; Lösung 17.], height: 50mm)
Ein vorgegebener $Z_2$ muss zum Endzustand gehören. Ohne diese Vorgabe kann wegen der Druckabhängigkeit eine gekoppelte Stoffwertsuche erforderlich sein.
$Z$ ist ein Korrekturfaktor der thermischen Zustandsgleichung, kein Wirkungsgrad. Ein Wert unter eins bedeutet bei gleichem $R,T$ ein kleineres Produkt $p v$ als im idealen Modell; ein Wert über eins ein größeres. Daraus folgt nicht pauschal „weniger“ oder „mehr“ Energie. Für Energiebilanzen brauchst du weiterhin kalorische Stoffwerte wie $u$ oder $h$.

#src([L 2.2, PDF-S. 35–36; V PDF-S. 71; Ü 2.5, PDF-S. 13.])

== 2.3 Verdampfen auf der Zustandsfläche
#bild("pvt", [Eine Zustandsfläche verknüpft p, v und T. Die Projektionen sind p-v-, T-v- und p-T-Diagramme. V, PDF-S. 52.], height: 73mm)
Im Flüssig-Dampf-Gleichgewicht eines reinen Stoffes sind Druck und Temperatur gekoppelt: $T=T_s(p)$. Der Phasenanteil ist dadurch noch nicht bekannt.

*Feynman-Bild:* Die Sättigung ist wie eine Schiene auf der Landkarte. Der Druck legt die zugehörige Temperatur fest; eine weitere Angabe sagt, wie viel Flüssigkeit und wie viel Dampf vorliegen.
#src([L 2.3, PDF-S. 36–37; V PDF-S. 52–53.])

== 2.4 Zustandsbereiche eines Fluids und kritischer Punkt
#bild("phase-dome", [Flüssig-Dampf-Gebiet im p-v-Diagramm, schematisch und ohne Stoffwertmaßstab. Eigene Darstellung.], height: 62mm)
#tab(columns: (1.1fr, 1.8fr),
 th([Bereich / Grenze], [Bedeutung]),
 [Unterkühlte Flüssigkeit], [$T<T_s(p)$ im betrachteten Flüssig-Dampf-Bereich.],
 [Siedelinie], [Gesättigte Flüssigkeit: $x=0$, Werte $v',h',u',s'$.],
 [Nassdampf], [Beide Phasen: $0<x<1$.],
 [Taulinie], [Trocken gesättigter Dampf: $x=1$, Werte $v'',h'',u'',s''$.],
 [Überhitzter Dampf], [$T>T_s(p)$.],
)
Am kritischen Punkt verschwinden der Unterschied $v''-v'$ und die Verdampfungsenthalpie. Konsistente gerundete Wasserwerte: $p_"kr" approx "220,64" thin "bar"$, $T_"kr" approx "647,1" thin "K"$, $v_"kr" approx "0,003106" thin "m"^3/"kg"$.

#note("Tabellen nicht mischen", [V verwendet daneben $v_"kr"="0,00317" thin "m"^3/"kg"$; BT enthält einen älteren kritischen Datensatz. Verwende innerhalb einer Rechnung den vorgegebenen Datensatz. „Unterkühlt“ und „überhitzt“ beziehen sich auf die Sättigung, nicht auf den menschlichen Wärmeindruck.], fill: sand)
Im Nassdampfgebiet verändern unterschiedliche Phasenanteile das spezifische Volumen, obwohl Druck und Temperatur dieselben bleiben. Am kritischen Punkt fallen die Stoffwerte der koexistierenden Phasen zusammen. Dort verlieren die getrennten Bezeichnungen „Flüssigkeitsanteil“ und „Dampfanteil“ ihre bisherige Bedeutung. Der kritische Punkt ist daher keine gewöhnliche Sättigung mit nur besonders hoher Temperatur.

#src([L 2.4, PDF-S. 37–38; V PDF-S. 54 und 68; älterer BT-Datensatz: Tabelle 3.2, PDF-S. 82.])

== 2.5 Isobares Verdampfen 1–2–3–4–5
#bild("five-states", [Ein passend belasteter beweglicher Kolben hält den Druck ungefähr konstant. BT, PDF-S. 73.], height: 55mm)
#tab(columns: (0.4fr, 1.2fr, 1.6fr),
 th([Nr.], [Zustand], [Beim Heizen]),
 [1], [Unterkühlte Flüssigkeit], [Temperatur steigt bis $T_s$.],
 [2], [Gesättigte Flüssigkeit], [$x=0$: Verdampfen beginnt.],
 [3], [Nassdampf], [$x$ wächst, $p,T$ bleiben gleich.],
 [4], [Sattdampf], [$x=1$: Verdampfen ist vollständig.],
 [5], [Überhitzter Dampf], [Temperatur steigt wieder.],
)
$ Q_(2,4)=m(h''-h')=m r $
Gültig unter den isobaren Modellbedingungen aus 2.1. Kondensieren gibt die entsprechende Energie ab. Wasser siedet bei 1 bar bei etwa 99,6 °C, bei rund 1,013 bar bei etwa 100 °C. Höherer Sättigungsdruck bedeutet höhere Sättigungstemperatur.
#src([L 2.5, PDF-S. 38–39; V PDF-S. 53–56; BT PDF-S. 72–74.])

== 2.6 Überkritischer Weg 1–a–b–5
#bild("supercritical", [Druckerhöhung, Erwärmen bei überkritischem Druck und anschließende Entspannung. BT, PDF-S. 76.], height: 57mm)
Oberhalb des kritischen Drucks gibt es beim Erwärmen keinen gewöhnlichen Siedevorgang mit zwei getrennten Phasen. Die Eigenschaften ändern sich kontinuierlich von flüssigkeitsähnlich zu gasähnlich.

*Kein latenter Phasensprung* bedeutet nicht *kein Energiebedarf*: Die Enthalpie steigt weiterhin. „Fluid“ ist der Oberbegriff für Flüssigkeiten und Gase, nicht erst die Bezeichnung eines überkritischen Zustands.
Der Unterschied zum isobaren Verdampfen ist der Weg auf der Zustandsfläche. Beim gewöhnlichen Sieden durchläuft man ein Gebiet mit zwei Phasen. Der Weg bei überkritischem Druck umgeht diese Koexistenz. Die Stoffeigenschaften ändern sich dabei weiterhin, deshalb sind auch hier Energiezufuhr und passende reale Stoffwerte erforderlich.

#src([L 2.6, PDF-S. 39–40; V PDF-S. 53 und 55–56; BT PDF-S. 75–76.])

== 2.7 Isochore Verdampfung: starrer Behälter
#bild("isochoric", [Senkrechte Wege bei konstantem spezifischem Volumen: Die Füllung bestimmt, welche Seite erreicht wird. V, PDF-S. 57; dessen kritischer Datensatz.], height: 65mm)
Geschlossen und starr: $m,V$ und damit $v=V/m$ bleiben konstant.

- $v>v_"kr"$: Austritt aus dem Nassdampfgebiet zur *Dampfseite*.
- $v<v_"kr"$: Austritt zur *Flüssigkeitsseite*. Danach kann der Druck stark steigen, weil Flüssigkeit wenig kompressibel ist.
- $v=v_"kr"$: idealisierter Weg zum kritischen Zustand.

Mehr Wärmezufuhr bedeutet deshalb nicht bei jeder Randbedingung mehr Dampf. Ein starker Druckanstieg ist möglich; eine Explosion folgt nicht zwangsläufig allein aus $v<v_"kr"$.
#src([L 2.7, PDF-S. 40; V PDF-S. 57.])

== 2.8 Polytrope Zustandsänderung mit Verdampfung
Im allgemeinen Folienbeispiel ändern sich $p,V,T$ gleichzeitig. Der Stoff erhält Wärme und gibt bei Expansion Volumenarbeit ab:
$ Delta U=Q_12+W_12 quad "mit" quad W_v<0 $
Die Wärme ist daher im Allgemeinen nicht allein gleich $Delta U$.

Eine mathematische Polytrope erfüllt $p v^n="konstant"$ bei konstantem $n$. Ein beliebiger realer Zweiphasenweg erfüllt das nicht automatisch. Die Folienbezeichnung erlaubt also nicht ungeprüft die Formeln idealer Gaspolytropen.
#bild("map-path", [Mindmap: Die festgehaltene Größe entscheidet über den Zustandsweg. Eigene Darstellung.], height: 48mm)
#src([L 2.8, PDF-S. 41; V PDF-S. 58. Engere Polytropendefinition ergänzend präzisiert.])

== 2.9 Nassdampf und Dampfgehalt
Der *Dampfgehalt* ist ein Massenanteil:
#form[$ x=m''/(m'+m'') quad m''=x m quad m'=(1-x)m $]
Weil Dampf pro Kilogramm viel mehr Raum braucht, kann wenig Dampfmasse den größten Teil eines Gefäßes ausfüllen.
#bild("mass-volume", [Ammoniak-Ampulle aus Ü 2.3: 1,22 % Dampfmasse belegen 83,68 % des Volumens. Eigene Rechnung; Lösung 16.], height: 48mm)

*Herleitung der Mischungsregel:* $V=m'v'+m''v''$. Durch $m$ teilen und $m''/m=x$ setzen:
$ v=(1-x)v'+x v''=v'+x(v''-v') $
Für $y=v,h,u,s$ gilt daher:
#form[$ y=y'+x(y''-y') quad => quad x=(y-y')/(y''-y') $]
Alle Randwerte gehören zur *gleichen Sättigung*. $p$ legt $T_s$ fest; zusätzlich braucht man beispielsweise $x$ oder einen Mischungswert.
#bild("lever", [Hebelregel: Der Abstand vom Flüssigkeitsrand relativ zur gesamten Zweiphasenbreite bestimmt x. V, PDF-S. 60.], height: 57mm)

*Volumenanteil statt Massenanteil:*
$ mu=V''/V=(x v'')/v $
Bei gegebenen Teilvolumina zuerst $m'=V'/v'$ und $m''=V''/v''$ berechnen. Erst danach $x=m''/(m'+m'')$ bilden.

In einer Zweiphasenströmung mit gemeinsamer mittlerer Geschwindigkeit gilt $dot(V)''=x dot(m)v''$, $dot(V)'=(1-x)dot(m)v'$ und $c=dot(m)v/A$. Phasengleiten erfordert ein anderes Modell.
#note("Plausibilitätsprüfung", [Bei $0<=x<=1$ liegen $v,h,u,s$ zwischen ihren Randwerten. $x>1$ ist keine zulässige Beschreibung überhitzten Dampfes mit der Nassdampfformel.], fill: sand)
Die Mischungsregel folgt daraus, dass sich die Gesamtmengen von Volumen, innerer Energie, Enthalpie und Entropie aus den Beiträgen beider Phasen addieren. Nach dem Teilen durch die Gesamtmasse entstehen Massen-Gewichte $1-x$ und $x$. Druck und Temperatur werden damit nicht zu frei mischbaren Größen: Beide Phasen besitzen bereits dieselben Sättigungswerte.

#src([L 2.9, PDF-S. 41–43; V PDF-S. 59–60; BT 3.4, PDF-S. 80–85.])

#heading(level: 3, outlined: false)[Anwendung: Wärmerohr]
#bild("heatpipe", [Am warmen Ende verdampft Fluid; am kalten Ende kondensiert es. Die Masse zirkuliert innerhalb der äußeren Grenze. BT, PDF-S. 86.], height: 38mm)
Das Wärmerohr ist nach außen *geschlossen* und kann dennoch Wärme transportieren. Stationär bleibt sein Energieinhalt konstant, weil Aufnahme und Abgabe einander ausgleichen.
#src([L 1.1.3, PDF-S. 7–8, und 2.5, PDF-S. 38–39; Anwendung ergänzt nach BT 3.4, PDF-S. 86.])

== 2.10 Dampftafel: Werte für Wasser ablesen
Die Dampftafel ist die Zahlenkarte des realen Stoffes. Zuerst kommt die Gebietsentscheidung:
#tab(columns: (1.1fr, 1.8fr),
 th([Angaben / Bereich], [Vorgehen]),
 [$p$ vorgegeben], [$T_s(p)$ nachsehen. Im Flüssig-Dampf-Bereich $T$ damit vergleichen.],
 [$T<T_s$ / $T>T_s$], [Unterkühlte Flüssigkeit / überhitzter Dampf: passende p-T-Tabelle.],
 [Sättigung / Nassdampf], [Sättigungstafel mit Strichwerten; zusätzlich $x$, $v$ oder $h$ nutzen.],
)

*Beispiel bei 200 bar und $x="0,8"$:* $h'=1827$, $h''=2418 thin "kJ/kg"$; $s'="4,015"$, $s''="4,941" thin "kJ/(kg K)"$.
$ h=1827+"0,8"(2418-1827)="2299,8" thin "kJ/kg" $
$ s="4,015"+"0,8"("4,941"-"4,015")="4,7558" thin "kJ/(kg K)" $
Mit den in L ergänzten Näherungen $v' approx "0,00204"$, $v''="0,005877" thin "m"^3/"kg"$ folgt $v approx "0,00511" thin "m"^3/"kg"$ und $u=h-p v approx 2198 thin "kJ/kg"$. Dabei $p=20000 thin "kPa"$ einsetzen: kPa·m³/kg = kJ/kg.

*Interpolation:* Ein Anteil $f$ am Eingabeabstand liefert denselben Anteil am Werteunterschied:
$ f=(a-a_1)/(a_2-a_1) quad quad y approx y_1+f(y_2-y_1) $
Bei zwei veränderlichen Tabellengrößen zunächst in beiden Spalten interpolieren, dann zwischen den Spalten. Die umgekehrte Reihenfolge liefert mit denselben vier Eckwerten dasselbe bilineare Ergebnis. Beispiel: Lösung 15.
#bild("map-quality", [Mindmap: Angaben, Phasenanteil und passende Stoffwerte zusammenführen. Eigene Darstellung.], height: 48mm)
#note("Tabellenfallen", [Einheiten angleichen: v′ kann in dm³/kg stehen, v″ in m³/kg. Enthalpie und Entropie nur aus einem einheitlichen Datensatz kombinieren. Nicht ungeprüft über Phasengrenzen interpolieren.], fill: sand)
Eine Tabellenrechnung beginnt mit zwei unabhängigen Informationen über den Zustand. Einphasig sind das häufig Druck und Temperatur. Im Nassdampf sind diese gekoppelt; dort brauchst du zusätzlich etwa den Dampfgehalt. Interpolieren schließt anschließend nur die Lücke zwischen nahen Tabellenwerten. Es ersetzt weder die Gebietsentscheidung noch eine fehlende Zustandsangabe.

#src([L 2.10, PDF-S. 43–44; V PDF-S. 61–63; Ü 1.10, PDF-S. 7; BT Tabelle 3.2, PDF-S. 82.])

== 2.11 Ergänzung aus der Vorlesung bis 20.10.
#heading(level: 3, outlined: false)[Wasseranomalie und Tripelpunkt]
Gewöhnliches Eis benötigt bei gleicher Masse mehr Volumen als flüssiges Wasser: Es ist weniger dicht und schwimmt. Flüssiges Wasser hat bei ungefähr Atmosphärendruck seine größte Dichte nahe 4 °C; das ist die verwandte Dichteanomalie innerhalb der Flüssigkeit.
#bild("triple", [Eis, flüssiges Wasser und Sattdampf können am Tripelpunkt zugleich im Gleichgewicht vorliegen. V, PDF-S. 68.], height: 52mm)
Wassertripelpunkt: ungefähr 0,01 °C, 273,16 K und 612 Pa. Im p-T-Diagramm ist er ein Punkt; mit zusätzlicher Volumenachse entsteht für unterschiedliche Phasenanteile eine Tripellinie.

#heading(level: 3, outlined: false)[Clapeyron: Warum eine Phasengrenze steigt oder fällt]
#bild("anomaly", [p-T-Diagramm von Wasser mit fallender Schmelzgrenze und steigender Verdampfungsgrenze. Ausschnitt V, PDF-S. 65.], height: 59mm)
#form[$ (dif p_s)/(dif T)=(Delta s)/(Delta v)=(Delta h)/(T Delta v) $]
Die Differenzen beziehen sich auf die beiden koexistierenden Phasen. Verdampfen: $Delta h>0$, $Delta v>0$; die Dampfdruckkurve steigt. Schmelzen gewöhnlichen Eises: $Delta h>0$, $Delta v<0$; die Schmelzkurve fällt im betrachteten Druckbereich. $T$ steht in Kelvin.
#bild("map-water", [Mindmap: Phasenwechsel, Volumenänderung und Steigung verknüpfen. Eigene Darstellung.], height: 48mm)
Fest → flüssig: *Schmelzen*; zurück: *Erstarren*. Fest → gasförmig: *Sublimieren*; zurück: *Desublimieren*.
Tripelpunkt und kritischer Punkt beantworten unterschiedliche Fragen. Am Tripelpunkt können drei unterscheidbare Phasen nebeneinander bestehen. Am kritischen Punkt verschwindet gerade der Unterschied zwischen Flüssigkeit und Dampf. Die Clapeyron-Gleichung verbindet dazu den Energiebedarf einer Umwandlung mit ihrer Volumenänderung und erklärt die Richtung der jeweiligen Grenzkurve.

#src([V PDF-S. 64–70; nächster Bezug in L: 2.1, PDF-S. 34, und 2.4–2.5, PDF-S. 37–39. Dichteanomalie bei 4 °C ergänzende Einordnung.])

== 2.12 Ergänzung aus der Vorlesung 21.10. <a-2-12>
=== 2.12.1 Weitere Zustandsgleichungen für reale Fluide <a-2-12-1>
Der Realgasfaktor aus 2.2 beschreibt die Abweichung der thermischen Gasgleichung für *einen bestimmten Zustand*. Liegt $Z$ als Tabellenwert vor, setzt du ihn in $p v=Z R T$ ein. Für einen anderen Zustand musst du $Z$ erneut prüfen; eine einzige Zahl ist kein Stoffgesetz für alle Drücke und Temperaturen. Weitere Gleichungen bilden das reale Verhalten näherungsweise nach:
#tab(columns: (1fr, 1.5fr, 1.7fr),
 th([Gleichung], [Form], [Idee]),
 [Van der Waals], [$(p+a/v^2)(v-b)=R T$], [$a$: Anziehung zwischen den Molekülen, $b$: Eigenvolumen. $a,b,R$ je Stoff aus Tabellen. Historisch bedeutend, nützlich bei wenig Messdaten.],
 [Virialgleichung], [$p=(R T)/v+B(T)/v^2+C(T)/v^3+D(T)/v^4+...$], [Erster Term = ideales Gas; die Virialkoeffizienten $B,C,D,...$ sind empirische Korrekturen und müssen gegeben sein.],
 [Computer-Gleichungen], [z. B. IAPWS 97 für Wasser], [Industriestandard; liefert Tabellen- und Programmwerte, nicht für Handrechnung.],
)
#note("In eigenen Worten", [Die ideale Gasgleichung tut so, als wären Moleküle punktförmig und würden sich nicht anziehen. Van der Waals bessert genau diese zwei Schwächen nach: Die Anziehung „zieht“ am Druck ($a/v^2$), das Eigenvolumen nimmt Platz weg ($-b$). Je kleiner $v$ (je dichter das Gas), desto wichtiger werden beide Korrekturen.])
#note("Gültigkeit der Folienaussage", [„Weit weg vom kritischen Punkt“ ist eine Orientierung, kein alleiniger Genauigkeitstest. $Z approx 1$ bedeutet nur eine kleine Abweichung der *thermischen* Beziehung am betrachteten Zustand. Es garantiert weder ideales Verhalten entlang eines ganzen Weges noch passende ideale Energiegrößen. Van der Waals liefert laut BT ein qualitatives Bild und zahlenmäßig Näherungen.], fill: sand)
#src([N S. 1 (Folie 02 Stoffeigenschaften 24, nach der Markierung „Ende 20.10“); BT 3.6, S. 80 (Gl. 3.23) und S. 82 (Gl. 3.27), PDF-S. 100–102; Stammbaum der Zustandsgleichungen BT Abb. 3.30, S. 83.])

=== 2.12.2 Stoffgemische <a-2-12-2>
Meist liegt ein Fluid *nicht* als reiner Stoff vor, sondern als *Gemisch*, zum Beispiel Luft. Die Vorlesung nutzt dafür die Vorstellung der *Partialvolumina*:
#bild("mixing", [Zwei Gase bei gleichem Druck und gleicher Temperatur, getrennt durch eine gedachte Membran. Wird sie entfernt, entsteht das Gemisch g mit $V_A+V_B=V_g$. Ausschnitt N S. 2 (Folie 02 Stoffeigenschaften 26).], height: 50mm)
Annahmen der Folie: $p$ und $T$ bleiben konstant, ideale Gase, keine chemischen Reaktionen. Deine Randnotiz „Partialdruck → Druck sinkt“ gehört zu einer zweiten gedanklichen Betrachtung:
#tab(columns: (1fr, 1.8fr),
 th([Betrachtung], [Was hältst du gleich?]),
 [*Partialvolumen* $V_i$], [Die Komponente ist allein bei Gemischdruck $p_g$ und Temperatur $T$. Ihre Teilvolumina addieren sich zu $V_g$; auf der Folie gilt vor dem Mischen $p_A=p_B=p_g$.],
 [*Partialdruck* $p_i$], [Die Komponente ist allein im *gesamten* Gemischvolumen $V_g$ bei Temperatur $T$. Ihr Druck ist bei $0<psi_i<1$ kleiner als $p_g$; die Partialdrücke addieren sich zu $p_g$.],
)
#form[$ p_i/p_g=V_i/V_g=psi_i quad quad p_g=sum p_i $]
$p_i,p_g$ in derselben Druckeinheit; $V_i,V_g$ in derselben Volumeneinheit. *Gültigkeit:* Gemisch idealer Gase, gemeinsames $T$, Partialgrößen wie oben definiert. Beispiel: rund 21 Mol-% Sauerstoff bedeuten bei 1 bar Gemischdruck etwa 0,21 bar Sauerstoff-Partialdruck (ergänzt).
#form[$ m_g=sum m_i quad quad n_g=sum n_i quad quad xi_i=m_i/m_g quad quad psi_i=n_i/n_g quad quad sum xi_i=sum psi_i=1 $]
#form[$ m_i=n_i M_i quad quad xi_i=psi_i M_i/M_g quad quad M_g=sum psi_i M_i quad quad R_g=sum xi_i R_i quad quad 1/M_g=sum xi_i/M_i $]
$xi_i$: Massenanteil, $psi_i$: Molanteil (Stoffmengenanteil), $M$ in kg/kmol, $R$ in J/(kg K). Die Beziehungen zwischen Massen, Stoffmengen und Molmassen folgen bereits aus den Definitionen. Die Gasgleichung und die Partialdruck-/Partialvolumenbeziehung verwenden zusätzlich das ideale Gasmodell.
#tab(columns: (1fr, 1fr, 1fr, 1fr, 1fr),
 th([Gas], [$M_i$ / kg/kmol], [$R_i$ / J/(kg K)], [$xi_i$ / Massen-%], [$psi_i$ / Mol-%]),
 [O#sub[2]], [32,0], [259,8], [23,20], [20,99],
 [N#sub[2]], [28,016], [296,8], [75,47], [78,03],
 [Ar + Rest], [39,944], [208,2], [1,33], [0,98],
 [Luft], [28,964], [287,0], [100,00], [100,00],
)
#note("Fehler vermeiden", [Luft enthält *23 Massen-%* oder *21 Mol-%* Sauerstoff. Eine Prozentangabe braucht immer ihre Bezugsgröße. Deine Notiz dazu: 100 kg + 50 kg ergeben Massenanteile 2/3 und 1/3; sind es zugleich gleich viele kmol (Molmasse doppelt so groß), sind die Molanteile 50 % und 50 %.], fill: sand)
#note("Quellen vergleichen", [Im Thermo-Buch sind in Gl. (3.30) und (3.31) die Zeichen vertauscht ($psi_i=m_i/m_g$, $xi_i=n_i/n_g$). Die Umrechnung (3.34) $xi_i=psi_i M_i/M_g$ und Beispiel 3.9 passen aber zur Folie: $xi$ = Massenanteil, $psi$ = Molanteil. Wir verwenden die Bedeutung der Folie.], fill: sand)
#bild("map-mix", [Mindmap: Mengen, Anteile und Gemischgrößen. Eigene Darstellung.], height: 46mm)
Ein Gemisch wird wie ein „Ersatzstoff“ behandelt: Kennt man die Anteile, ergeben sich eine scheinbare Molmasse $M_g$ und eine Gaskonstante $R_g$. Damit gilt für ein Gemisch idealer Gase wieder $p V=m_g R_g T$. Für Luft ist das genau der bekannte Wert $R approx 287 thin "J/(kg K)"$.
#src([N S. 2 (Folie 02 Stoffeigenschaften 26) mit Randnotizen; BT 3.7, S. 83–85 (Gl. 3.28–3.35, Beispiel 3.9), PDF-S. 103–105; Partialgrößen ergänzend erklärt nach BT 8.1–8.2, S. 240–243, PDF-S. 258–261. Ab Folie 27 nicht behandelt (N S. 3, Trennblatt).])

== 2.13 Ergänzung aus Tutorium und WZF 22.–23.10. <a-2-13>
Die neuen Übungen verbinden Tabellenlesen und Bilanzen. Drei Fragen steuern den Rechenweg: *In welchem Gebiet liegt der Stoff? Welche Bezugsgröße ist gemeint? Was bleibt im Prozess wirklich konstant?*

=== 2.13.1 Tabellenrichtung und rückwärtige Interpolation <a-2-13-1>
Eine *Sättigungstafel* nennt Strichwerte bei zusammengehörigem $p$ und $T_s$. Eine Tabelle für *einphasige* Zustände verwendet etwa $p$ und $T$ als unabhängige Angaben. Erst die Gebietsentscheidung, dann die passende Tabellenzeile: So beginnt das Tutorium vom 22.10.
#tab(columns: (1fr, 2fr),
 th([Gegebener Zustand], [Passende Tabelle]),
 [Sättigung, etwa $p$ und $x$], [Sättigungszeile und Mischungsregel. Nur $p,T_s$ legen $x$ noch nicht fest.],
 [Einphasig, etwa $p,T$], [Tabelle für überhitzten Dampf beziehungsweise unterkühlte Flüssigkeit. Werte im gleichen Gebiet interpolieren.],
)
Beim *rückwärtigen Interpolieren* ist der Stoffwert bekannt, die Temperatur wird gesucht. Du vertauschst dafür die Rolle von Eingabe und Ausgabe, nicht die physikalischen Größen.
#bild("interpolation-invers", [Rückwärtige Interpolation in Ü 1.10 b bei 1200 kPa. Eigene Darstellung nach T22, PDF-S. 2.], height: 55mm)
#form[$ vartheta=vartheta_1+frac(v-v_1, v_2-v_1)(vartheta_2-vartheta_1) $]
$v,v_1,v_2$ in m³/kg; $vartheta$ hier in °C. *Voraussetzung:* nahe Tabellenpunkte bei demselben Druck und im selben Zustandsgebiet; lineare Näherung. Bei $v="0,02300" thin "m"^3/"kg"$ zwischen $"0,02245"$ (100 °C) und $"0,02335"$ (110 °C) folgt *$vartheta approx "106,11" thin "°C"$*.
#note("Deine Tutoriumsnotiz", [Bei Ü 1.10 c steht „wird so nie drankommen“. Das bleibt als Hinweis aus T22 sichtbar. Es ist keine belegte Festlegung des aktuellen Prüfungsumfangs; die vorhandene Rechnung zur doppelten Interpolation bleibt als Verständnisbeispiel erhalten.], fill: sand)
#bild("map-tabellenmodell", [Mindmap: Zustand, Bezugsgröße, Tabellenwert und Bilanz verknüpfen. Eigene Darstellung.], height: 43mm)
#src[T22, PDF-S. 1–2; Ü 1.10, PDF-S. 7; passende Tabellen und Mischungsregel ergänzend BT 3.4, S. 61–65 / PDF-S. 81–85.]

=== 2.13.2 Stickstoffgefäß: Aufheizen und Entnehmen unterscheiden <a-2-13-2>
Wie bei einer Druckkanne erzeugt Verdampfen den Druck, der Flüssigkeit durch die Leitung hebt. Die Aufgabe betrachtet aber *verschiedene Prozesse*: Vor dem Austritt bleibt die Masse im Gefäß; beim Entnehmen sinkt sie.
#bild("stickstoff-zustaende", [Zustände ①–③ aus Ü 2.1. Eigene schematische Darstellung nach W23, PDF-S. 1–2, und M2, PDF-S. 1–2; nicht maßstäblich.], height: 55mm)
#tab(columns: (0.6fr, 1fr, 1fr, 1.6fr),
 th([Weg], [System], [Konstant], [Was ändert sich?]),
 [① → ②], [geschlossen], [$V,m$; daher $v=V/m$], [$p$ steigt von 1 auf etwa 1,4 bar; $T_s$ und die Phasenanteile ändern sich.],
 [② → ③], [offen, instationär], [$V,p$; daher $T_s$], [1 kg Flüssigkeit tritt aus. $m$ sinkt und $v=V/m$ wächst. Ein kleiner Teil verdampft.],
)
#bild("stickstoff-pv", [Weg im p-v-Diagramm. Eigene schematische Darstellung nach W23, PDF-S. 2; keine maßstäbliche Stoffwertkurve.], height: 48mm)
*Vorgegebene Stoffwerte* (gedruckte Stickstofftabelle aus Ü 2.1):
#tab(columns: (0.5fr, 0.7fr, 1fr, 0.9fr, 0.8fr, 0.8fr),
 th([$p$ / bar], [$T$ / K], [$v'$ / m³/kg], [$v''$ / m³/kg], [$h'$ / kJ/kg], [$h''$ / kJ/kg]),
 [1,0], [77,24], [0,0012398], [0,21947], [−122,25], [77,073],
 [1,4], [80,21], [0,0012611], [0,16082], [−116,15], [79,245],
)
Bei 1,4 bar sind außerdem $s'="2,9081"$ und $s''="5,3442" thin "kJ/(kg K)"$ vorgegeben. Negative Enthalpiewerte stammen aus dem Tabellen-Bezugsnullpunkt; für eine Bilanz müssen alle Werte aus demselben Datensatz kommen.

#heading(level: 3, outlined: false)[Warum mehr Flüssigkeit verschwindet, als entnommen wird]
Bei gleichem $p$ bleiben die Sättigungswerte $v',v''$ konstant. Die beiden extensiven Bilanzen lauten mit $Delta m=m_3-m_2$:
#form[$ Delta m'+Delta m''=Delta m quad "und" quad v' Delta m'+v'' Delta m''=Delta V=0 $]
Aus $Delta m'=Delta m-Delta m''$ folgt:
#form[$ Delta m''=frac(-v' Delta m, v''-v')=frac(v' m_"entn", v''-v') $]
$Delta m''$ ist die *Zunahme der Dampfmasse* in kg; $m_"entn">0$ die nach außen abgegebene Flüssigkeitsmasse. Es gilt $Delta m=-m_"entn"$. Die verdampfte Masse bleibt im Gefäß und beansprucht den frei werdenden Raum.
#note("Fehler vermeiden", [„Starrer Behälter“ bedeutet hier $V$ konstant. Beim Austritt von Masse bleibt $v=V/m$ gerade *nicht* konstant. Ebenso ist der Dampfgehalt $x$ ein Massenanteil; der Dampfvolumenanteil $mu=x v''/v$ ist eine andere Zahl.], fill: sand)
#src[W23, PDF-S. 1–2; M2, PDF-S. 1–2; Ü 2.1 mit Originaltabelle, PDF-S. 11; BT 3.4, Gl. (3.10)–(3.14), S. 60–62 / PDF-S. 80–82. Bezugsnullpunkt: BT 4.4, S. 108–109 / PDF-S. 128–129.]

=== 2.13.3 Verdampfer: Stoffwerte in Energieströme übersetzen <a-2-13-3>
Der Verdampfer aus Ü 1.14 erhält ständig dieselbe Masse pro Sekunde. Das Verdampfen verändert aber Volumenstrom, Geschwindigkeit und die mitgeführten Energiegrößen. Die neue Musterlösung ergänzt die bisher behandelten Teilaufgaben um $h,u,s$ und die Phasenströme.
#bild("verdampfer-stroeme", [R134a-Verdampfer nach Ü 1.14 und M1, PDF-S. 1–2. Eigene Darstellung; nicht maßstäblich.], height: 52mm)
*M1 gibt für den Austritt bei 164,2 kPa näherungsweise vor:*
#tab(columns: (1fr, 1fr, 1fr, 1fr),
 th([Stoffwert], [Einheit], [Flüssig, Strich], [Dampf, Doppelstrich]),
 [$v$], [m³/kg], [0,0007], [0,1205],
 [$h$], [kJ/kg], [180,25], [389,83],
 [$s$], [kJ/(kg K)], [0,9259], [1,73787],
)
Die Mischungsregel gilt jeweils für die *spezifischen* Werte. Erst danach macht $dot(m)$ daraus einen Strom:
#form[$ h=h'+x(h''-h') quad s=s'+x(s''-s') quad u=h-p v $]
#form[$ dot(H)=dot(m)h quad dot(S)=dot(m)s quad dot(H)'=dot(m)(1-x)h' quad dot(H)''=dot(m)x h'' $]
$dot(H)$ in kW, $dot(S)$ in kW/K, wenn $dot(m)$ in kg/s, $h$ in kJ/kg und $s$ in kJ/(kg K) stehen. Für $u=h-p v$: kPa·m³/kg = kJ/kg. *Gültigkeit:* zwei Phasen im selben Sättigungszustand; stationäre Phasenmassenströme mit bekanntem Dampfgehalt.
#note("Zustandsgebiet vor Interpolation", [Am Eintritt gilt $p_1="164,2"$ kPa und $vartheta_1=-20$ °C. Die Sättigungstemperatur liegt bei etwa −14,96 °C: Der Eintritt ist unterkühlte Flüssigkeit. Der Wert $v_1 approx "0,0007"$ m³/kg ist dafür eine Flüssigkeitsnäherung; die Sättigungstafel wird nicht mit einer idealen Gasgleichung ersetzt.], fill: sand)
#note("Musterlösung prüfen", [In M1 steht in der Enthalpierechnung einmal 389,9 statt des Tabellenwerts 389,83 kJ/kg. Wir rechnen durchgängig mit 389,83. Kleine Abweichungen bei $u$ entstehen zusätzlich durch das vorzeitige Runden von $v$. Die Kontrolle $dot(H)=dot(H)'+dot(H)''$ muss mit ungerundeten Zwischenwerten stimmen.], fill: sand)
#src[M1, PDF-S. 1–3; Ü 1.14, PDF-S. 10; BT 3.4, Beispiel 3.4, S. 64–65 / PDF-S. 84–85, und 4.4, Gl. (4.46), (4.49), S. 108 / PDF-S. 128. Tabellenwerte und Rundung nach M1; eigene Nachrechnung.]

*Der Zusammenhang in Kapitel 2.* Zuerst wird das Zustandsgebiet erkannt. Einphasig nutzt du das passende Stoffmodell oder eine p-T-Tabelle; im Nassdampf die Sättigungswerte und einen zusätzlichen Phasenanteil. Danach werden Stoffwerte in die Massen- und Energiebilanz eingesetzt. Der Vergleich von Verdampfer und Entnahmebehälter zeigt, wann ein Massenstrom konstant bleibt und wann sich der Bestand ändert. Die Darstellung im Diagramm hilft, den Rechenweg zu prüfen.

== Verständnisfragen und Rechenaufgaben · Kapitel 2
#set enum(spacing: 0.85em)
+ Erkläre die fünf Abschnitte der Erwärmung von Eis bis überhitztem Dampf. Warum kann eine Phasenumwandlung im Diagramm waagerecht oder senkrecht erscheinen?
+ Unter welchen Voraussetzungen gilt beim Verdampfen $Q=m(h''-h')$?
+ Wodurch unterscheiden sich unterkühlte Flüssigkeit, Nassdampf, Sattdampf und überhitzter Dampf?
+ Warum reichen $p$ und $T$ im Nassdampfgebiet nicht zur Festlegung des Mischungszustands?
+ Ein Behälter enthält $2 thin "kg"$ Gemisch, darunter $"0,5" thin "kg"$ Dampf. Bestimme $x$ und die Flüssigkeitsmasse.
+ Gegeben: $h'="417,5"$, $h''=2675 thin "kJ/kg"$, $v'="0,001043"$, $v''="1,694" thin "m"^3/"kg"$. Bestimme $h$ und $v$ für $x="0,3"$.
+ Welcher Dampfgehalt ergibt sich aus $h=2200$, $h'=1827$ und $h''=2418 thin "kJ/kg"$?
+ Warum benötigt auch ein überkritischer Erwärmungsweg Energie, obwohl er keine gewöhnliche Verdampfungsenthalpie besitzt?
+ Welche Rolle spielt $v$ im Vergleich zu $v_"kr"$ beim isochoren Erwärmen von Nassdampf?
+ Was bedeutet $Z=1$ und warum darfst du $Z$ nicht für jeden Zustand eines realen Gases gleich wählen?
+ Was verschwindet am kritischen Punkt? Was koexistiert am Tripelpunkt?
+ Warum steigt die Dampfdruckkurve, während die Schmelzkurve gewöhnlichen Eises im betrachteten Bereich fällt?


#pagebreak()
#heading(level: 3, outlined: false)[Vertiefende Verständnisfragen und Rechenaufgaben]
#block[
#set enum(start: 13)
+ Warum kann ein geschlossenes Wärmerohr Wärme transportieren, obwohl seine Gesamtmasse konstant bleibt?
+ Eine Tabelle nennt bei 80 °C eine mittlere Wärmekapazität mit Bezug auf 0 °C. Darfst du diesen Wert unverändert für 6 → 80 °C verwenden? Warum dürfen Enthalpiewerte verschiedener Tabellen nicht ungeprüft kombiniert werden?
+ *Interpolation, Ü 1.10 a und c:* Nutze die folgende verkürzte Originaltabelle für R134a. Bestimme bei 100 °C und 1130 kPa die Werte $v,h,s,c_p$. Bestimme außerdem bei 105,3 °C und 1100 kPa die Werte $v,h,c_p$ durch doppelte Interpolation und prüfe beide Reihenfolgen.
+ *Ammoniak-Ampulle, Ü 2.3:* $V="14,8" thin "cm"^3$, $m="1,63" thin "g"$, $theta=-20 thin "°C"$. Verwende aus BT $v'="0,00150"$ und $v''="0,62280" thin "m"^3/"kg"$. Bestimme Dampfgehalt, Dampfvolumen und Flüssigkeitsvolumenanteil.
+ *Sauerstoffflasche, Auszug aus Ü 2.5 a–c und e:* $V="58,5" thin "l"$, Überdruck 232 bar bei $T_1=300 thin "K"$, Umgebung 1 bar, Abkühlung auf −18,3 °C. Nutze $R="259,8" thin "J/(kg K)"$. Berechne Masse und Enddruck zuerst ideal, dann mit $Z_1="0,958155"$ und dem für den Endzustand vorgegebenen $Z_2="0,85949475"$. Die Flasche bleibt dicht und starr.
+ *Erwärmungskurve, vereinfachte Ü 2.2:* 1 kg Eis soll bei 1 bar von −15 °C bis zu 200 °C heißem Wasserdampf erwärmt werden. Rechne näherungsweise mit Schmelzen bei 0 °C, Sieden bei 99,603 °C, $c_"Eis"="2,04" thin "kJ/(kg K)"$, $r_"S"="333,5" thin "kJ/kg"$, mittlerem $c_"Wasser"="4,19030" thin "kJ/(kg K)"$, $r_"V"="2257,5" thin "kJ/kg"$ und angenommenem mittlerem $c_"Dampf"="2,0" thin "kJ/(kg K)"$. Bestimme alle fünf Energieanteile und die Summe. Erkläre die Form im Temperatur-Energie-Diagramm.
+ *Stickstoffgefäß, Auszug aus Ü 2.1 a–b:* Ein Volumen von $"0,05" thin "m"^3$ enthält bei 1 bar zu 90 Volumenprozent Flüssigkeit und zu 10 Prozent Dampf. Es gelten $v'_1="0,0012398"$, $v''_1="0,21947" thin "m"^3/"kg"$. Bestimme Teilmassen, Gesamtmasse, Dampfgehalt und mittleres spezifisches Volumen. Für das Anheben der Flüssigkeit um $"5,143" thin "m"$ gegen 1 bar Umgebung: Prüfe den erforderlichen Behälterdruck näherungsweise mit $v'("1,4" thin "bar")="0,0012611" thin "m"^3/"kg"$; bei diesem Druck ist $T_s="80,21" thin "K"$.
+ *Beheizter Bottich, Ü 2.9:* Wasser füllt einen Bottich mit 45 cm × 30 cm × 10 cm. Von 6 auf 86 °C, $rho=1 thin "kg/l"$, Heizleistung 1,8 kW, Verluste und Behälterwärmekapazität vernachlässigt. Die auf 0 °C bezogenen Mittelwerte bei 1 bar sind $C_6="4,21037"$, $C_86="4,18745" thin "kJ/(kg K)"$. Bestimme Masse, Energie und Aufheizzeit.
+ *Verdampfer, Auszug aus Ü 1.14 a–b und c.1–3:* R134a strömt mit $A_1="0,76" thin "cm"^2$ und $c_1="0,035" thin "m/s"$ als Flüssigkeit ein. Nutze $v_1 approx "0,0007" thin "m"^3/"kg"$. Am Austritt: $A_2="3,04" thin "cm"^2$, $x_2="0,88"$, $v'_2="0,0007"$, $v''_2="0,1205" thin "m"^3/"kg"$ aus BT. Berechne Massenstrom, Austrittsgeschwindigkeit sowie die beiden Phasenvolumenströme. Modell: gemeinsame mittlere Phasengeschwindigkeit.
]

#block(breakable: false)[
#text(size: 9pt, fill: muted)[R134a-Tabelle zu Aufgabe 15; alle Werte aus Ü Aufgabe 1.10, PDF-S. 7.]
#tab(columns: (0.8fr, 0.7fr, 1fr, 0.8fr, 1fr, 1fr),
 th([$p$ / kPa], [$theta$ / °C], [$v$ / m³/kg], [$h$ / kJ/kg], [$s$ / kJ/(kg K)], [$c_p$ / kJ/(kg K)]),
 [1000], [100], [0,02756], [483,5], [1,8997], [1,0409],
 [1000], [110], [0,02859], [493,9], [1,9273], [1,0459],
 [1200], [100], [0,02245], [481,2], [1,8802], [1,0630],
 [1200], [110], [0,02335], [491,8], [1,9083], [1,0644],
)
]

#heading(level: 3, outlined: false)[Ergänzung aus der Vorlesung 21.10.]
#block[
#set enum(start: 22)
+ Luft enthält „23 %“ und „21 %“ Sauerstoff. Wie passt das zusammen?
+ *Gemisch:* 2 kmol N#sub[2] und 1 kmol O#sub[2] werden gemischt ($M_"N2"="28,016"$, $M_"O2"=32 thin "kg/kmol"$). Bestimme $psi_i$, $M_g$, $xi_i$ und $R_g$.
+ *Feuchter Stickstoff, BT Beispiel 3.9:* 100 kmol Gemisch enthalten 14 kmol Wasserdampf ($M=18$), 3 kmol CO#sub[2] ($M=44$), Rest N#sub[2] ($M=28 thin "kg/kmol"$). Bestimme $M_g$ und die Massenanteile.
+ *Partialgrößen, eigenes Zahlenbeispiel nach N S. 2:* Ein ideales Gasgemisch enthält 25 Mol-% A bei $p_g=2 thin "bar"$ und $V_g=4 thin "m"^3$. Bestimme den Partialdruck und das Partialvolumen von A. Warum widersprechen sich die Aussagen „gleicher Druck“ und „kleinerer Druck“ hier nicht?
]




#heading(level: 3, outlined: false)[Ergänzungen aus den neuen Übungsunterlagen]
#block[
#set enum(start: 26)
+ *Stickstoffgefäß, Ü 2.1 c–d; W23 und M2:* Verwende das Gefäß und die Werte aus Aufgabe 19 und Abschnitt 2.13.2. Ab dem Entnahmebeginn soll der Druck bei 1,4 bar bleiben. Wie viel Flüssigkeit lässt sich maximal entnehmen, wenn am Ende nur Sattdampf im starren Gefäß bleibt? Wie viel muss für die Entnahme von 1 kg Flüssigkeit verdampfen? Zeige die Massen- und Volumenbilanz und deute das Vorzeichen von $Delta m$ und $Delta m''$.
+ *R134a-Verdampfer, Ü 1.14 c.4–10; M1:* Ergänze Aufgabe 21 mit den Stoffwerten aus 2.13.3. Bestimme am Austritt $h_2$, $dot(H)_2$, $u_2$, $s_2$, $dot(S)_2$ sowie die Enthalpieströme der Flüssigkeit und des Sattdampfes. Prüfe ihre Summe. Warum ist der Eintritt bei −20 °C und 164,2 kPa flüssig? Bestimme außerdem näherungsweise die Sättigungstemperatur durch Interpolation zwischen −15 °C bei 163,90 kPa und −10 °C bei 200,60 kPa.
+ *Rückwärtige Interpolation, Ü 1.10 b; T22:* Bei $p=1200$ kPa ist $v="0,02300"$ m³/kg gegeben. Nutze die Tabelle zu Aufgabe 15 und bestimme die Temperatur. Welche Größe gehört auf die Eingabeachse, wenn die Temperatur gesucht wird? Prüfe anschließend durch Einsetzen in die vorwärts gerichtete Interpolation.
]

#pagebreak()
== Lösungen Kapitel 2
#set enum(spacing: 0.65em)
+ Feststoff erwärmen, schmelzen, Flüssigkeit erwärmen, verdampfen, Dampf erwärmen. Beim Phasenwechsel bleibt $T$ unter den genannten isobaren Gleichgewichtsbedingungen konstant. Die Orientierung hängt davon ab, auf welcher Achse $T$ steht. #nachschlagen([Lernskript, Abschnitt 2.1, PDF-S. 32–34; zugehörige Kontrollfrage 1 mit Lösung auf PDF-S. 46.])
+ Reiner Stoff im Gleichgewicht bei konstantem Druck unterhalb des kritischen Drucks; vollständiger Wechsel von gesättigter Flüssigkeit zu gesättigtem Dampf. Für ein geschlossenes System: nur Volumenarbeit, keine wesentlichen äußeren Energieänderungen. Ein passender stationärer Verdampfer liefert dieselbe Wärmebeziehung bei entsprechender Vernachlässigung weiterer Beiträge. #nachschlagen([Lernskript, Abschnitt 2.1, PDF-S. 33–34; Abschnitt 2.5, PDF-S. 38–39. Die Prozessvoraussetzungen werden hier ausdrücklich ergänzt.])
+ Unterkühlt: $T<T_s(p)$. Nassdampf: beide Phasen. Sattdampf: gesättigter Dampf am Rand $x=1$. Überhitzt: $T>T_s(p)$. #nachschlagen([Lernskript, Abschnitt 2.4, PDF-S. 37–38; Abschnitt 2.5, PDF-S. 38–39.])
+ Im Zweiphasengleichgewicht gilt $T=T_s(p)$. Die beiden Angaben sind gekoppelt; der Massenanteil der Phasen bleibt unbekannt. #nachschlagen([Lernskript, Abschnitt 2.9, PDF-S. 41–43.])
+ $x="0,5"/2="0,25"$. Flüssigkeitsmasse $m'="1,5" thin "kg"$. #nachschlagen([Lernskript, Abschnitt 2.9, PDF-S. 42–43; entsprechende Kontrollaufgabe 15 mit Lösung auf PDF-S. 46.])
+ $h="417,5"+"0,3"(2675-"417,5")="1094,75" thin "kJ/kg"$. $v="0,001043"+"0,3"("1,694"-"0,001043") approx "0,50893" thin "m"^3/"kg"$. Beide Werte liegen zwischen den jeweiligen Randwerten. #nachschlagen([Lernskript, Abschnitt 2.9, PDF-S. 42–43; entsprechende Kontrollaufgabe 16 mit Lösung auf PDF-S. 47.])
+ $x=(2200-1827)/(2418-1827)=373/591 approx "0,631"$. #nachschlagen([Lernskript, Abschnitte 2.9–2.10, PDF-S. 42–44; entsprechende Kontrollaufgabe 18 mit Lösung auf PDF-S. 47.])
+ Seine Enthalpie steigt kontinuierlich. Es entfällt der separate latente Phasensprung, nicht der Energiebedarf für die Zustandsänderung. #nachschlagen([Lernskript, Abschnitt 2.6, PDF-S. 39–40.])
+ Bei $v>v_"kr"$ Austritt aus dem Zweiphasengebiet zur Dampfseite; bei $v<v_"kr"$ zur Flüssigkeitsseite. Nach vollständiger Raumausfüllung durch Flüssigkeit kann der Druck stark steigen. #nachschlagen([Lernskript, Abschnitt 2.7, PDF-S. 40.])
+ $Z=1$ ist die ideale thermische Gasbeziehung. Der reale Faktor hängt vom Zustand ab; eine unveränderte Übernahme kann falsche Stoffwerte liefern. #nachschlagen([Lernskript, Abschnitt 2.2, PDF-S. 35–36; entsprechende Kontrollfrage 25 mit Lösung auf PDF-S. 47.])
+ Kritischer Punkt: Unterschiede zwischen koexistierender Flüssigkeit und Dampf verschwinden. Tripelpunkt: feste, flüssige und gasförmige Phase koexistieren. #nachschlagen([Lernskript zum kritischen Punkt: Abschnitt 2.4, PDF-S. 37–38. Der Tripelpunkt wird dort nicht eigenständig behandelt: siehe Vorlesungsskript, PDF-S. 67–68, und hier Abschnitt 2.11.])
+ Clapeyron: positive Umwandlungsenthalpie geteilt durch $T$ und Volumenänderung. Verdampfung hat positive Volumenänderung; Schmelzen gewöhnlichen Eises hat negative. #nachschlagen([Lernskript zur Sättigung und zum Volumenverhalten beim Erstarren: Abschnitt 2.1, PDF-S. 34, und Abschnitte 2.4–2.5, PDF-S. 37–39. Die Clapeyron-Herleitung und Schmelzkurve sind neuere Ergänzungen: Vorlesungsskript, PDF-S. 64–70; hier Abschnitt 2.11.])


#block(breakable: false)[
#heading(level: 3, outlined: false)[13 · Wärmerohr]
Am warmen Ende nimmt Verdampfen Energie auf, am kalten gibt Kondensieren sie ab. Dampf und Kondensat zirkulieren *innerhalb* der geschlossenen Grenze. Stationär bleiben Gesamtmasse und gespeicherte Energie konstant; zugeführte und abgegebene Wärme gleichen sich aus.
#nachschlagen([Lernskript, Systemgrenze Abschnitt 1.1.3, PDF-S. 7–8; Verdampfen Abschnitt 2.5, PDF-S. 38–39. Die Anwendung Wärmerohr steht zusätzlich in BT Abschnitt 3.4, Druck-S. 66 / PDF-S. 86.])
]


#block(breakable: false)[
#heading(level: 3, outlined: false)[14 · Tabellenbezug und einheitlicher Datensatz]
Der Mittelwert 0 → 80 °C enthält einen anderen Temperaturbereich. Für 6 → 80 °C wird die Enthalpiezunahme 0 → 6 °C von der Zunahme 0 → 80 °C abgezogen. Unterschiedliche Tabellen können verschiedene Referenznullpunkte für Enthalpie und Entropie verwenden; eine willkürliche Kombination erzeugt dann falsche Differenzen. Innerhalb eines konsistenten Datensatzes fällt ein gemeinsamer Bezugsnullpunkt bei der Differenzbildung heraus.
#nachschlagen([Lernskript, Abschnitt 2.1, PDF-S. 33–34, und Abschnitt 2.10, PDF-S. 43–44. Mittelwertumrechnung zusätzlich BT Abschnitt 6.4, Druck-S. 194–195 / PDF-S. 213–214; Ü Vorbemerkungen PDF-S. 2 und Tabelle PDF-S. 19.])
]


#block(breakable: false)[
#heading(level: 3, outlined: false)[15 · Einfache und doppelte Interpolation]
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
#nachschlagen([Lernskript, Abschnitt 2.10, PDF-S. 43–44; Original Ü Aufgabe 1.10 a und c mit DuPont-Tabelle, PDF-S. 7 / Druck-S. 4. Doppelte Interpolation hier schrittweise ergänzt.])
]


#block(breakable: false)[
#heading(level: 3, outlined: false)[16 · Ammoniak: wenig Dampfmasse, viel Dampfvolumen]
*Erst umrechnen:* $V="14,8" times 10^(-6) thin "m"^3$, $m="1,63" times 10^(-3) thin "kg"$. Das spezifische Gesamtvolumen ist:
$ v=V/m approx "0,00907975" thin "m"^3/"kg" $
Es liegt zwischen $v'$ und $v''$: Das Zweiphasenmodell ist plausibel. Mit der Hebelregel:
$ x=("0,00907975"-"0,00150")/("0,62280"-"0,00150") approx "0,01220" $
Das sind *1,22 Prozent der Masse*. Die Dampfmasse beträgt etwa $"0,01989" thin "g"$. Das Dampfvolumen folgt aus der Dampfmasse, nicht aus $x V$:
$ V''=x m v'' approx "12,385" thin "cm"^3 $
Somit $V'="14,8"-"12,385" approx "2,415" thin "cm"^3$. Die Flüssigkeit belegt rund *16,32 Prozent des Volumens*, der Dampf 83,68 Prozent. *Fehlerquelle:* 1,22 Prozent Dampfmasse mit 1,22 Prozent Dampfvolumen gleichsetzen. Leichte Abweichungen von gerundeten Buchergebnissen entstehen durch das Runden der Zwischenwerte.
#nachschlagen([Lernskript, Abschnitt 2.9, PDF-S. 41–43; Original Ü Aufgabe 2.3, PDF-S. 13 / Druck-S. 10; Stoffwerte und entsprechendes Beispiel BT Abschnitt 3.4, Druck-S. 63–64 / PDF-S. 83–84.])
]


#block(breakable: false)[
#heading(level: 3, outlined: false)[17 · Sauerstoffflasche: idealer und realer Vergleich]
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
#nachschlagen([Lernskript, Abschnitt 1.6.1, PDF-S. 16–19; Absolutdruck Abschnitt 1.7, PDF-S. 19–20; Realgasfaktor Abschnitt 2.2, PDF-S. 35–36. Original Ü Aufgabe 2.5, hier Auszug a–c und e, PDF-S. 13 / Druck-S. 10.])
]


#block(breakable: false)[
#heading(level: 3, outlined: false)[18 · Fünf Energieanteile beim Erwärmen]
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
#nachschlagen([Lernskript, Abschnitt 2.1, PDF-S. 32–34, und Abschnitt 2.5, PDF-S. 38–39; Original Ü Aufgabe 2.2, PDF-S. 13 / Druck-S. 10; Mittelwert und Siedetemperatur Ü Tabelle PDF-S. 19. Hier vereinfachte Variante mit ausdrücklich vorgegebenem Dampfmittelwert.])
]


#block(breakable: false)[
#heading(level: 3, outlined: false)[19 · Stickstoff: Volumenanteile und hydrostatische Förderung]
*Teilvolumina:* $V'="0,045" thin "m"^3$, $V''="0,005" thin "m"^3$. Wir teilen jeweils durch das spezifische Volumen der betreffenden Phase:
$ m'=V'/v' approx "36,296" thin "kg" quad quad m''=V''/v'' approx "0,022782" thin "kg" $
Also *$m approx "36,319" thin "kg"$*, $x=m''/m approx "0,0006273"$, also nur *0,06273 Prozent Dampfmasse*. Das spezifische Gesamtvolumen ist $v=V/m approx "0,0013767" thin "m"^3/"kg"$. Die zehn Volumenprozent Dampf sind eindeutig keine zehn Massenprozent.

*Anheben bis zum gerade noch ruhenden Austritt:* Der nötige Behälterüberdruck trägt die Flüssigkeitssäule:
$ p_2-p_0=rho'_2 g Delta z=g Delta z/v'_2 $
$ p_2 approx 1 thin "bar"+("9,81" times "5,143")/"0,0012611" thin "Pa" approx "1,400" thin "bar" $
Das ist mit dem verwendeten Sättigungswert bei 1,4 bar konsistent; dort ist $T_2="80,21" thin "K"$, also −192,94 °C. Die Flüssigkeitsdichte wird am Zustand 2 verwendet. Der Druck an der Behälteroberfläche muss *höher* als der Umgebungsdruck sein, damit die Säule aufsteigen kann. Für einen endlichen Ausfluss kämen Bewegungsenergie und reale Verluste hinzu. Die weiteren Entnahmeteile stehen jetzt in Lösung 26 dieses Kapitels, die vollständige Energiebilanz und Zustandsgrößentabelle in Kapitel 3, Lösung 9.
#nachschlagen([Lernskript, Abschnitt 1.7, PDF-S. 19–20, und Abschnitt 2.9, PDF-S. 41–43; Original Ü Aufgabe 2.1 a–b mit Stickstofftabelle, PDF-S. 11 / Druck-S. 8.])
]


#block(breakable: false)[
#heading(level: 3, outlined: false)[20 · Bottich mit genauer Intervall-Wärmekapazität]
Das Volumen ist $V="0,45" times "0,30" times "0,10"="0,0135" thin "m"^3="13,5" thin "l"$. Damit $m="13,5" thin "kg"$. Bei vernachlässigter Verdunstung, Behälterwärmekapazität und Verlusten landet die elektrische Energie im Wasser.

Aus den auf 0 °C bezogenen Mittelwerten:
$ Delta h=("4,18745" times 86-"4,21037" times 6) thin "kJ/kg"="334,85848" thin "kJ/kg" $
$ E approx m Delta h="4520,58948" thin "kJ" $
Mit $P="1,8" thin "kJ/s"$ folgt *$Delta t=E/P approx 2511 thin "s" approx "41,86" thin "min"$*. Zum Vergleich: $overline(c)_(p,12)=Delta h/(80 thin "K") approx "4,18573" thin "kJ/(kg K)"$. Die Watt-Kilowatt-Umrechnung ist entscheidend: Kilojoule durch Kilowatt ergibt Sekunden.
#nachschlagen([Lernskript, Erwärmungsbeispiel Abschnitt 1.3, PDF-S. 12, und Abschnitt 2.1, PDF-S. 33–34; Original Ü Aufgabe 2.9, PDF-S. 14 / Druck-S. 11; Tabelle Ü PDF-S. 19; Mittelwertumrechnung BT Abschnitt 6.4, PDF-S. 213–214.])
]


#block(breakable: false)[
#heading(level: 3, outlined: false)[21 · Verdampfer: Masse bleibt, Volumenstrom wächst]
*Methode:* Am Eintritt bestimmen wir aus Fläche, Geschwindigkeit und spezifischem Volumen den Massenstrom. Stationär bleibt dieser erhalten. Am Austritt verwenden wir die Nassdampfmischung.

$ A_1="0,76" times 10^(-4) thin "m"^2 quad quad A_2="3,04" times 10^(-4) thin "m"^2 $
$ dot(m)=A_1 c_1/v_1="0,0038" thin "kg/s" $
$ v_2=v'_2+x_2(v''_2-v'_2)="0,0007"+"0,88"("0,1205"-"0,0007")="0,106124" thin "m"^3/"kg" $
$ c_2=dot(m)v_2/A_2 approx "1,327" thin "m/s" $
Die Teilvolumenströme sind:
$ dot(V)''_2=x_2 dot(m)v''_2 approx "0,000402952" thin "m"^3/"s" $
$ dot(V)'_2=(1-x_2)dot(m)v'_2 approx "0,0000003192" thin "m"^3/"s" $
Ihre Summe beträgt $"0,0004032712" thin "m"^3/"s"$, rund 0,4033 l/s. Trotz größerer Austrittsfläche steigt die Geschwindigkeit gegenüber 0,035 m/s stark, weil das Verdampfen das spezifische Volumen noch stärker erhöht. Am Eintritt wird $v_1$ nach dem Buchbeispiel durch den Flüssigkeits-Sättigungswert gleicher Temperatur angenähert; das ist keine Anwendung der idealen Gasgleichung auf Flüssigkeit.
#nachschlagen([Lernskript, Kontinuität Abschnitt 1.5, PDF-S. 13–14, und Nassdampf Abschnitt 2.9, PDF-S. 41–43; Original Ü Aufgabe 1.14 a–b und c.1–3, PDF-S. 10 / Druck-S. 7; BT Beispiel 3.4, Druck-S. 64–65 / PDF-S. 84–85. Die übrigen Teilaufgaben c.4–10 werden jetzt in Lösung 27 dieses Kapitels ergänzt.])
]


#block(breakable: false)[
#heading(level: 3, outlined: false)[22 · Massen- und Molanteil]
23 % ist der *Massenanteil* $xi_"O2"$, 21 % der *Molanteil* $psi_"O2"$. Sauerstoffmoleküle sind schwerer als der Durchschnitt der Luft ($32>"28,96" thin "kg/kmol"$), darum ist ihr Massenanteil größer: $xi=psi M_i/M_g="0,2099" dot 32/"28,964" approx "0,232"$.
#nachschlagen[Lernskript, #stelle(<a-2-12-2>)]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[23 · Stickstoff-Sauerstoff-Gemisch]
$psi_"N2"=2/3 approx "0,6667"$, $psi_"O2"=1/3 approx "0,3333"$. $M_g=sum psi_i M_i="0,6667" dot "28,016"+"0,3333" dot 32 approx "29,344" thin "kg/kmol"$. $xi_"N2"="0,6667" dot "28,016"/"29,344" approx "0,6365"$, $xi_"O2" approx "0,3635"$. $R_g=R_m/M_g="8314,3"/"29,344" approx "283,3" thin "J/(kg K)"$; Kontrolle: $sum xi_i R_i="0,6365" dot "296,8"+"0,3635" dot "259,8" approx "283,3" thin "J/(kg K)"$.
#nachschlagen[Lernskript, #stelle(<a-2-12-2>)]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[24 · Feuchter Stickstoff]
$n_"N2"=83 thin "kmol"$. Massen: $83 dot 28=2324$, $14 dot 18=252$, $3 dot 44=132 thin "kg"$; zusammen $2708 thin "kg"$. $M_g=2708/100="27,08" thin "kg/kmol"$. $xi_"H2O"=252/2708 approx "0,093"$, $xi_"CO2" approx "0,049"$, $xi_"N2" approx "0,858"$.
#nachschlagen[Lernskript, #stelle(<a-2-12-2>); BT Beispiel 3.9, S. 85 (PDF-S. 105).]
]


#block(breakable: false)[
#heading(level: 3, outlined: false)[25 · Partialdruck und Partialvolumen]
*Modell:* ideale Gase bei gemeinsamer Temperatur. $psi_A="0,25"$.

*1 · Gesamtes Volumen festhalten:* $p_A=psi_A p_g="0,25" dot 2 thin "bar"$. Ergebnis: *$p_A="0,5" thin "bar"$*.

*2 · Gemischdruck festhalten:* $V_A=psi_A V_g="0,25" dot 4 thin "m"^3$. Ergebnis: *$V_A=1 thin "m"^3$*.

*Prüfung:* Beide Anteile sind 25 Prozent; $p_A V_g=p_g V_A=2 thin "bar m"^3$. Beim Partialdruck füllt A allein 4 m³, beim Partialvolumen allein 1 m³. Deshalb gehören die beiden Druckaussagen zu verschiedenen gedanklichen Zuständen.
#nachschlagen[Lernskript, #stelle(<a-2-12-2>)]
]

#pagebreak()
#block(breakable: false)[
#heading(level: 3, outlined: false)[26 · Stickstoff: Restmasse und nachverdampfende Masse]
*Modell:* starrer Behälter, ab Zustand ② isobar bei 1,4 bar, Sättigungswerte aus der Originaltabelle. Aus Aufgabe 19: $m_2=m_1 approx "36,318959"$ kg.

*1 · Maximalentnahme:* Am Ende ist nur Sattdampf vorhanden. Deshalb $m_"Rest"=V/v''="0,05"/"0,16082" approx "0,310907"$ kg.

*Ergebnis: $m_"entn,max"=m_2-m_"Rest" approx "36,0081"$ kg.* Die Änderung des Gefäßbestands ist entsprechend negativ. Das ist die ideale Obergrenze unter den Modellannahmen.

*2 · Für 1 kg Entnahme:* $Delta m=-1$ kg und $v'Delta m'+v''Delta m''=0$, während $Delta m'+Delta m''=-1$ kg gilt. Daraus:
$ Delta m''=frac("0,0012611", "0,16082"-"0,0012611") dot 1 thin "kg" $
*Ergebnis: $Delta m'' approx "0,00790366" thin "kg"="7,904" thin "g"$.*

*3 · Flüssigkeitsbestand prüfen:* $Delta m'=-1-"0,00790366"=-"1,00790366"$ kg. Davon treten 1 kg aus und rund 7,904 g verdampfen im Gefäß.

*Prüfung:* $Delta m''>0$, obwohl $Delta m<0$. Beide Volumenänderungen gleichen sich aus. Frühes Runden von $m''_2$ und $m''_3$ auf 0,026 und 0,034 kg erzeugt die gröbere Differenz 8 g; M2 zeigt genau diese Rundungsfalle.
#nachschlagen[Lernskript, #stelle(<a-2-13-2>); W23, PDF-S. 2; M2, PDF-S. 1–2.]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[27 · Verdampfer: spezifische Werte und Ströme]
*Modell:* stationär, Nassdampf bei 164,2 kPa, $x_2="0,88"$, $dot(m)="0,0038"$ kg/s. Aus Aufgabe 21: $v_2="0,106124"$ m³/kg. Alle Randwerte aus derselben Zeile von M1.

*1 · Enthalpie und innere Energie:*
$ h_2="180,25"+"0,88"("389,83"-"180,25")="364,6804" thin "kJ/kg" $
$ u_2=h_2-p_2v_2="364,6804"-"164,2" dot "0,106124" approx "347,2548" thin "kJ/kg" $

*2 · Entropie und Ströme:*
$ s_2="0,9259"+"0,88"("1,73787"-"0,9259")="1,6404336" thin "kJ/(kg K)" $
#tab(columns: (1.6fr, 1.8fr, 1fr),
 th([Gesuchte Größe], [Ansatz], [Ergebnis]),
 [Nassdampfenthalpiestrom], [$dot(H)_2=dot(m)h_2$], [1,38579 kW],
 [Entropiestrom], [$dot(S)_2=dot(m)s_2$], [0,00623365 kW/K],
 [Flüssigkeitsenthalpiestrom], [$dot(H)'_2=dot(m)(1-x_2)h'$], [0,082194 kW],
 [Sattdampfenthalpiestrom], [$dot(H)''_2=dot(m)x_2h''$], [1,30359 kW],
)
*Prüfung:* $"0,082194"+"1,303592"="1,385786"$ kW. $u$ und $h$ sind spezifische Größen, ihre Ströme haben einen Zeitbezug. kPa·m³/kg ergibt kJ/kg; beim Entropiestrom bleibt zusätzlich „pro Kelvin“ erhalten.
#nachschlagen[Lernskript, #stelle(<a-2-13-3>); M1, PDF-S. 2.]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[27 · Zustandsgebiet und Sättigungstemperatur prüfen]
*3 · Interpolieren:* $vartheta_s=-15+("164,2"-"163,90")/("200,60"-"163,90") dot 5 approx -"14,9591"$ °C.

*Ergebnis: $vartheta_s approx -"14,96"$ °C.* Am Eintritt ist $vartheta_1=-20$ °C kleiner als $vartheta_s$; dort liegt unterkühlte Flüssigkeit vor. Am Austritt bestimmt zusätzlich der gegebene Dampfgehalt die Nassdampfmischung.

*Prüfung:* 164,2 kPa liegt knapp über 163,90 kPa, die Temperatur daher knapp über −15 °C. Zwischen den nahe gelegenen Sättigungspunkten wird linear angenähert; der Eintrittswert $v_1$ ist eine Flüssigkeitsnäherung.
#nachschlagen[Lernskript, #stelle(<a-2-13-3>); M1, PDF-S. 1 und 3.]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[28 · Die Temperatur rückwärts aus dem Volumen bestimmen]
*Modell:* R134a bei konstant 1200 kPa, einphasig; lineare Näherung zwischen 100 und 110 °C.

*1 · Gesuchte und bekannte Größe zuordnen:* Eingabe ist $v$, Ausgabe ist $vartheta$. Der Abstandsanteil lautet
$ f=frac("0,02300"-"0,02245", "0,02335"-"0,02245")="0,611111"... $

*2 · Temperatur bestimmen:* $vartheta=100+f(110-100)$ °C.

*Ergebnis: $vartheta approx "106,11"$ °C.*

*3 · Rückwärts prüfen:* $v="0,02245"+"0,611111"... dot ("0,02335"-"0,02245")="0,02300"$ m³/kg. Der bekannte Wert liegt zwischen den Randwerten, die Temperatur ebenfalls.
#nachschlagen[Lernskript, #stelle(<a-2-13-1>); T22, PDF-S. 2.]
]

#pagebreak()
= Kapitel 3 · Energiebilanzen: Erster Hauptsatz

Kapitel 1 hat die Bilanzhülle und die Prozessgrößen eingeführt, Kapitel 2 die Stoffwerte. Der erste Hauptsatz (1. HS) verbindet beides: Er sagt, wie viel sich die Energie eines Systems ändert, wenn Wärme und Arbeit über seine Grenze fließen. Im Buch ist das Kapitel 4.

== 3.1 Erster Hauptsatz: die Energiebilanz <a-3-1>
#bild("hs-overview", [Links ein offenes, stationär durchströmtes System (Brennkammer), rechts ein geschlossenes System (Zylinder). Ausschnitt N S. 5 (Folie 03 Erster Hauptsatz 2).], height: 80mm)
Die Folie stellt die beiden Grundfälle nebeneinander. *Offen:* Stoff strömt bei ① *örtlich vorher* ein und bei ② *örtlich nachher* aus; der innere Aufbau interessiert nicht. *Geschlossen:* Dieselbe Masse ist ① *zeitlich vorher* und ② *zeitlich nachher* im Zylinder.
#note("Dein Feynman-Schritt", [Stell dir einen Teich vor. Wasser fließt durch Bäche zu und ab (das sind Wärme und Arbeit), der Wasserstand ist die gespeicherte Energie. Der Teich weiß nicht, aus welchem Bach sein Wasser kam: Ist es einmal drin, ist es einfach Energie. Erkläre damit in zwei Sätzen, warum $Q$ und $W$ keine Zustandsgrößen sind.])
- *Zustandsgrößen* ($p, v, T, u, h, s, c, z$) beschreiben den Zustand an ① und ②. Deine Notiz: Zustandsgrößen sind *wegunabhängig*. Große Änderungen schreibt man $Delta p_12=p_2-p_1$, kleine $dif p, dif T, dif U$.
- *Prozessgrößen* (Arbeit, Wärme) bewirken die Zustandsänderung. Sie sind nur während des Prozesses da: endlicher Betrag $Q_12=m q_12$, $W_12=m w_12$; unendlich kleiner Betrag $delta Q$, $delta W$ (Folie: $dif Q$, $dif W_g$).
- *Kein Punkt* auf $Q_12$ in der geschlossenen Bilanz zwischen zwei Zeitpunkten (Notiz auf der Folie): $Q_12$ ist eine Energiemenge in kJ. Die offen-stationäre Bilanz betrachtet dagegen Ströme: $dot(Q)_12=dot(m) q_12$ und $P=dot(m) w_(t,12)$ in kW. Ein Wärmestrom $dot(Q)$ lässt sich auch bei einem geschlossenen System definieren; der Punkt bezeichnet den Zeitbezug, nicht die Systemart.
- *Vorzeichen:* zugeführte Wärme und Arbeit positiv, abgeführte negativ (Zufuhrkonvention wie in Kapitel 1).
#src([N S. 5 (Folie 03 Erster Hauptsatz 2) und S. 6 (Randnotiz); BT 4.1, S. 92–94, Teich-Analogie Abb. 4.7, S. 97 (PDF-S. 112–117).])

=== 3.1.1 Offenes, stationär durchströmtes System <a-3-1-1>
#bild("hs-open", [Offenes System mit Ein- und Austritt, Arbeit $P$ und Wärme $dot(Q)_12$. Ausschnitt N S. 6 (Folie 03 Erster Hauptsatz 3).], height: 78mm)
Instationär ändert sich die *gesamte gespeicherte Energie* um die Nettosumme der Energieströme:
$ (dif E_"sys")/(dif t)=dot(E)_1-dot(E)_2+dot(Q)_12+P $
$E_"sys"=U_"sys"+E_"kin,sys"+E_"pot,sys"$. N S. 6 schreibt links nur $U_"sys"$; das setzt vernachlässigbare Änderungen der gespeicherten äußeren Energien voraus. *Stationär* sind alle Speicheränderungen null und $dot(m)_1=dot(m)_2=dot(m)$ (ein Ein- und Austritt). Die mit einem Stoffstrom transportierte Energie einschließlich Verschiebearbeit ist:
$ e=h+c^2/2+g z quad "mit" quad h=u+p v $
#note("In eigenen Worten", [Warum steht hier $h$ und nicht $u$? Um Stoff in das System hineinzuschieben, muss der nachfolgende Stoff Arbeit leisten: die *Einströmarbeit* (Verschiebearbeit) $p_1 v_1$. Beim Austritt wird $p_2 v_2$ als Ausströmarbeit abgegeben. Die Enthalpie $h=u+p v$ packt diese Verschiebearbeit gleich mit in die Stoffenergie.])
#form[$ (h_2-h_1)+(c_2^2-c_1^2)/2+g(z_2-z_1)=q_12+w_(t,12) $
$ dot(H)_2-dot(H)_1+dot(m)[(c_2^2-c_1^2)/2+g(z_2-z_1)]=dot(Q)_12+P_12 $]
*Einheiten:* spezifisch J/kg oder einheitlich kJ/kg; Ströme entsprechend W oder kW. Mit $c$ in m/s, $z$ in m und $g$ in m/s² ergeben $c^2/2$ und $g z$ zunächst *J/kg*. Für eine Bilanz in kJ/kg teilst du diese Zahlenwerte durch 1000. $dot(m)$ steht in kg/s.
Links stehen die Änderungen der Zustandsgrößen (innere: Enthalpie; äußere: Bewegungs- und Lageenergie), rechts die Prozessgrößen: *Σ Änderung Zustandsgrößen = Σ Prozessgrößen*. $w_(t,12)$ heißt *technische Arbeit*; im Turbomaschinenbau auch *spezifische Stutzenarbeit* $Y_12$.

*Aufschlüsselung der technischen Arbeit* (Ausblick auf Kap. 3.2.2):
$ w_(t,12)=j_12+w_(p 12)+(c_2^2-c_1^2)/2+g(z_2-z_1) quad "mit" quad w_(p 12)=integral_1^2 v dif p $
$j_12$: spezifische Streu- oder *Dissipationsarbeit* (von dir markiert), $w_(p 12)$: spezifische *Druckarbeit*, dazu Beschleunigungs- und Hubarbeit.
#src([N S. 6–7 (Folie 03 Erster Hauptsatz 3–4); BT 4.1, Gl. (4.2), (4.3) und (4.9), S. 92–93, sowie 4.2, Gl. (4.32), S. 103 (PDF-S. 112–113 und 123). Speicherpräzisierung und Einheitenhinweis: ergänzte Einordnung.])

=== 3.1.2 Geschlossenes System <a-3-1-2>
#bild("hs-closed", [Geschlossenes System: Kolben von Zustand ① nach ②, dazwischen kleine Änderungen $dif v$, $dif q$, $dif w_g$. Ausschnitt N S. 8 (Folie 03 Erster Hauptsatz 5).], height: 75mm)
Kein Massenaustausch über die Grenze, also auch keine Ein- und Ausströmarbeit. Darum steht hier die *innere Energie* $u$. Differenziell gilt $dif E=delta Q+delta W_g$ mit $dif e=dif u+c dif c+g dif z$; integriert:
#form[$ (u_2-u_1)+(c_2^2-c_1^2)/2+g(z_2-z_1)=q_12+w_(g,12) $
$ U_2-U_1+m[(c_2^2-c_1^2)/2+g(z_2-z_1)]=Q_12+W_(g,12) $]
*Einheiten:* spezifisch J/kg oder einheitlich kJ/kg; mit $m$ in kg erhältst du J beziehungsweise kJ. Die Umrechnung der äußeren Energiebeiträge gilt wie in 3.1.1. $c$ bezeichnet hier die Bewegung des gesamten Systems, nicht die ungeordnete Teilchenbewegung im Stoff.
$W_(g,12)$ ist die *Gesamtarbeit* (Index g wird oft weggelassen). $c$ ist die Geschwindigkeit des bewegten Zylinders. Aufgeschlüsselt:
$ w_(g,12)=j_12+w_(v 12)+(c_2^2-c_1^2)/2+g(z_2-z_1) quad "mit" quad w_(v 12)=-integral_1^2 p dif v $
#note("Achtung! Minuszeichen bei der Volumenarbeit", [Deine Notiz: Bei Kompression wird $dif v$ negativ. Das Minus sorgt dafür, dass die *zugeführte* Arbeit trotzdem positiv herauskommt (Zufuhrkonvention). Expandiert das Gas, gibt es Arbeit ab: $w_v<0$.], fill: sand)
#note("Fehler vermeiden", [In deiner roten Randnotiz auf Folie 4 sind die Begriffe vertauscht. Richtig ist: *offenes* System → Druck(änderungs)arbeit $w_p=integral v dif p$ (steckt in $w_t$); *geschlossenes* System → Volumen(änderungs)arbeit $w_v=-integral p dif v$ (steckt in $w_g$). So stehen sie auch auf den Folien 4 und 6 und im Buch (Gl. 4.37/4.38, S. 104). Eselsbrücke: Im offenen System fließt Stoff durch, das Volumen der Maschine ändert sich nicht, wohl aber der Druck.], fill: sand)
#src([N S. 8–9 (Folie 03 Erster Hauptsatz 5–6) mit Randnotizen; BT 4.1, Gl. (4.11)–(4.12), S. 95, und 4.2, Gl. (4.37)–(4.38), S. 104 (PDF-S. 115 und 124).])

=== 3.1.3 Sonderfälle im geschlossenen System <a-3-1-3>
Für ein *ruhendes* System ($c_1=c_2=0$) konstanter Höhe ($dif z=0$) bleibt nur die innere Energie übrig. Je nach Annahme fallen weitere Terme weg:
#tab(columns: (1.3fr, 1.6fr),
  th([Fall], [1. HS, extensiv]),
  [Mit Dissipation $J_12$ (z. B. Turbulenz, innere Gasreibung)], [$m(u_2-u_1)=Q_12+J_12+W_(v 12)$],
  [„Reibfrei“: Rechenmodell ohne Dissipation, $J_12=0$], [$m(u_2-u_1)=Q_12+W_(v 12)$],
  [Reibfrei *und* adiabat ($Q_12=0$, $W_12=W_(v 12)$)], [$m(u_2-u_1)=W_(v 12)=m(-integral p dif v)$],
  [Abgeschlossenes System (weder Arbeit noch Wärme)], [$m(u_2-u_1)=0$, also $dif u=0$],
)
#bild("hs-special", [Skizzen zu den vier Fällen, von oben nach unten. Ausschnitt N S. 10 (Folie 03 Erster Hauptsatz 7).], height: 62mm)
Bei Dissipation dient nur ein Teil der übertragenen Arbeit $W_(g,12)$ der Volumenänderung; der Rest $J_12$ „wirkt wie Wärmezufuhr“.
Das beschreibt die *Wirkung* auf $U$: Die Energie hat die Grenze als Arbeit überquert. $J_12$ ist deshalb kein zusätzlicher Wärmestrom und wird nicht noch einmal neben der bereits vollständig erfassten Gesamtarbeit addiert. Für ein abgeschlossenes System gilt allgemein $Delta E_"sys"=0$; $Delta U=0$ folgt hier zusätzlich aus dem ruhenden System mit unveränderter Höhe.
#bild("map-firstlaw", [Mindmap: Der erste Hauptsatz auf einen Blick. Eigene Darstellung.], height: 46mm)
#src([N S. 10 (Folie 03 Erster Hauptsatz 7); BT 4.1, Gl. (4.10)–(4.13) und Abb. 4.5–4.6, S. 95–96 (PDF-S. 115–116). Allgemeine Energieaussage: ergänzende Einordnung mit N S. 8.])

=== 3.1.4 Beispiel: Erwärmung einer Kugel beim Aufschlag <a-3-1-4>
#bild("ball", [① Bleikugel in $z_1=30 thin "m"$ mit $c_1=30 thin "m/s"$; ② ideal starr am Boden in Ruhe; ②\* Realität: Kugel plattgedrückt (Verformungsarbeit). Ausschnitt N S. 12 (Tafelanschrieb).], height: 42mm)
*System:* die Kugel (geschlossen), von Zustand ① oberhalb des Bodens bis Zustand ② nach dem Aufprall. *Idealisierungen der Tafelrechnung:* Luftwiderstand, Energieabgabe an Boden und Umgebung sowie Rückprall werden vernachlässigt; die gesamte anfängliche äußere Energie erhöht $U$ der Kugel. Damit setzt das Modell $q_12=0$, $w_12=0$, $z_2=0$ und $c_2=0$:
$ c_"Pb" Delta T_12-c_1^2/2-g z_1=0 quad => quad Delta T_12=frac(c_1^2/2+g z_1, c_"Pb") $
$ Delta T_12=1/(130 thin "J/(kg K)")(30^2/2+"9,81" dot 30) thin "m"^2/"s"^2=("450"+"294,3")/130 thin "K" approx "5,73" thin "K" $
Einheitencheck: $1 thin "m"^2/"s"^2=1 thin "N m/kg"=1 thin "J/kg"$. Für feste Stoffe gilt $u_2-u_1=c Delta T$.
#note("Modell und Realität", [Die 5,73 K sind der idealisierte Temperaturanstieg mit dem verwendeten konstanten $c_"Pb"$. Reale Verformung ist nicht automatisch Energieabgabe: Dissipation *in der Kugel* kann sie erwärmen. Energie, die an Boden und Umgebung geht oder als andere Speicheränderung verbleibt, steht dagegen nicht vollständig für $m c Delta T$ zur Verfügung.], fill: sand)
#note("Fehler vermeiden", [In deinem Anschrieb steht $c_"Pb"=130 thin "kJ/(kg K)"$. Richtig ist $130 thin "J/(kg K)"$ (Blei, ca. 0,13 kJ/(kg K)). Nur mit J ergibt sich das Ergebnis 5,73 K; mit kJ wären es 0,0057 K.], fill: sand)
#note("★ Klausur", [„1. HS ist der richtige Ansatz in der Prüfung!!“ (von dir markiert). Immer zuerst System und Zustände ① und ② festlegen, dann alle Terme hinschreiben und erst danach streichen.], fill: sand)
*Hinweis zum 1. HS:* Er sagt nur, dass die Summe der Zustandsänderungen gleich der Summe der Prozessgrößen ist. Er sagt *nicht*, welche Prozessgröße in welche Zustandsänderung umgewandelt wird. Die Beispiele 2 (Pumpspeicherkraftwerk, adiabate Turbine, $P=7000 thin "kW"$) und 3 (Strahltriebwerk mit Nachbrenner und adiabater Düse) wurden nur genannt, noch nicht gerechnet.
#src([N S. 11 (Folie 03 Erster Hauptsatz 8) und S. 12 (Tafel, „Ende VL 21.10“). Einheitenkorrektur bei $c_"Pb"$: eigene Ergänzung.])


#pagebreak()
== 3.2 Ergänzung aus WZF 23.10.: der instationäre Stickstoffbehälter <a-3-2>
Eine unveränderte Behälterwand macht die Stickstoffentnahme nicht stationär: Im Gefäß bleibt nachher weniger Masse. Der erste Hauptsatz muss deshalb *Speicherung und Stoffaustritt* gleichzeitig erfassen. Das ist die Verbindung zwischen Stoffwerten aus 2.13 und der Energiebilanz.

=== 3.2.1 Die Systemgrenze entscheidet über die Energiezufuhr <a-3-2-1>
Wir legen die Grenze um den Gefäßinhalt, mit dem Flüssigkeitsaustritt am Gefäß. Bewegungs- und Lageenergieänderungen des gespeicherten Inhalts werden wie in M2 vernachlässigt. Die Entnahme erfolgt im Modell bei konstantem $p_2=p_3$; es gibt keinen Zufluss.
#tab(columns: (1fr, 2fr),
 th([Gewählte Grenze], [Energie des Heizers]),
 [Nur Stickstoff], [Der Heizer überträgt die Energiemenge als $Q_"zu,23"$ an den Stickstoff. So bezeichnet sie die Musterlösung. Die äußere Gefäßwand ist adiabat.],
 [Stickstoff und Heizer], [Elektrische Arbeit $W_"el,23"$ kommt über das Kabel hinein. Bei vernachlässigbarer Heizerspeicherung und ohne Verluste entspricht ihr Betrag $Q_"zu,23"$.],
)
Die Massenbilanz ist $Delta m=m_3-m_2=-m_"entn"$. Der austretende Stickstoff ist flüssig und trägt die spezifische Enthalpie $h'$ mit:
#form[$ U_3-U_2=Q_"zu,23"-m_"entn" h' $]
$U,Q$ in kJ, $m_"entn"$ in kg, $h'$ in kJ/kg. *Voraussetzungen:* starrer Behälter, konstante Austrittsenthalpie im isobaren Entnahmeabschnitt, keine weitere Arbeitsübertragung und vernachlässigte äußere Energien. $h'$ enthält bereits die Verschiebearbeit des Austritts.

Weil sowohl $p$ als auch das *gesamte* $V$ gleich bleiben, gilt $Delta(p V)=0$ und damit $Delta U=Delta H$. Mit $H=m'h'+m''h''$ ergibt sich:
$ Delta H=h' Delta m'+h'' Delta m''=-m_"entn" h'+Delta m''(h''-h') $
Eingesetzt in die Bilanz:
#form[$ Q_"zu,23"=Delta m''(h''-h') $]
Diese kurze Verdampfungsformel gilt *hier wegen der hergeleiteten Randbedingungen*. Sie darf bei einem beliebigen Entleerungsprozess nicht ungeprüft eingesetzt werden.
#note("Fehler vermeiden", [Die 1 kg Entnahme sind nicht die verdampfte Masse. Die neue Dampfmasse bleibt im Gefäß, während flüssiger Stickstoff austritt. Außerdem ist der Gefäßinhalt während der Entnahme kein geschlossenes System: $Q_"zu,23"=Delta U$ allein lässt den Enthalpietransport mit der entnommenen Masse weg.], fill: sand)
#src[W23, PDF-S. 2–3; M2, PDF-S. 2–3 (dort ausdrücklich instationäre Massen- und Energiebilanz); Enthalpiedefinition ergänzend BT 4.4, S. 107–108 / PDF-S. 127–128. Wahl der Heizergrenze: ergänzte Einordnung.]


#pagebreak()
=== 3.2.2 Die 39 Zustandsgrößen systematisch aufbauen <a-3-2-2>
Ü 2.1 f verlangt 13 Größen für *drei Betrachtungen*: das gesamte Nassdampfgemisch, die gesättigte Flüssigkeit und den Sattdampf. Du brauchst keine 39 voneinander unabhängigen Ansätze. Nutze denselben Rechenplan für jede Spalte.
#tab(columns: (0.9fr, 1.05fr, 2.1fr),
 th([Größen], [Einheiten], [Rechenplan und Bedeutung]),
 [$p,T$], [bar, K], [Beide Phasen sind im Sättigungsgleichgewicht: $p'=p''=p$, $T'=T''=T$. Thermische intensive Größen.],
 [$x,mu$], [1], [$x=m''/m$, $mu=V''/V=x v''/v$. Zusammensetzung, intensiv; reiner Flüssigkeitszustand: 0, reiner Dampfzustand: 1.],
 [$v$], [m³/kg], [$v=V/m=v'+x(v''-v')$. Thermische intensive Größe.],
 [$h,u,s$], [kJ/kg; kJ/(kg K)], [Kalorische intensive Größen: Mischungsregel für $h,s$; $u=h-p v$ mit konsistenten Einheiten.],
 [$m,V$], [kg; m³], [Extensiv: $m'=m(1-x)$, $m''=m x$; $V'=m'v'$, $V''=m''v''$. $V$ ist zugleich eine thermische Größe.],
 [$H,U,S$], [kJ; kJ/K], [Kalorisch und extensiv: $H=m h$, $U=m u$, $S=m s$; für jede Phase denselben Ansatz mit Strichwerten verwenden.],
)
*Additionsprüfung:* $m=m'+m''$, $V=V'+V''$, $H=H'+H''$, $U=U'+U''$, $S=S'+S''$. Die spezifischen Größen werden dagegen mit *Massenanteilen* gewichtet. $p$ und $T$ werden weder addiert noch zwischen den Phasen gemittelt.
#note("Bezugsgröße mitsprechen", [„Die Entropie steigt“ ist ohne Bezugsgröße unvollständig. Nach der Entnahme kann die spezifische Entropie $s$ des Restes größer und die gesamte Entropie $S=m s$ kleiner sein. Die Rechnung in Lösung 9 prüft beides anhand desselben Datensatzes.])
#src[Ü 2.1 f–g, PDF-S. 11–12; M2, PDF-S. 4 und 6–8; BT 3.4, S. 60–62 / PDF-S. 80–82, und 4.4, S. 108 / PDF-S. 128.]

*Der Zusammenhang in Kapitel 3.* Erst die Systemart festlegen: Strömt Stoff über die Grenze, arbeitest du mit Enthalpie $h$ und technischer Arbeit $w_t$; ist das System geschlossen, mit innerer Energie $u$ und Gesamtarbeit $w_g$. Dann alle Terme aufschreiben, die Annahmen (stationär, adiabat, reibfrei, ruhend) streichen lassen und die Stoffwerte aus Kapitel 2 einsetzen. Bei instationärer Entnahme bleibt zusätzlich der Speicherterm erhalten; der austretende Stoff trägt Enthalpie mit.

#pagebreak()
== Verständnisfragen und Rechenaufgaben · Kapitel 3
+ Erkläre einem Laien mit der Teich-Analogie, was der erste Hauptsatz aussagt und warum Wärme und Arbeit keine Zustandsgrößen sind.
+ Warum steht im 1. HS für offene Systeme die Enthalpie $h$, im geschlossenen System aber die innere Energie $u$?
+ Welche Arbeit gehört zum offenen, welche zum geschlossenen System: $integral v dif p$ oder $-integral p dif v$? Wozu dient das Minuszeichen?
+ Was unterscheidet die Energiemenge $Q_12$ von dem Wärmestrom $dot(Q)_12$? Welche Einheiten haben sie, und kann auch ein geschlossenes System einen Wärmestrom aufnehmen?

#heading(level: 3, outlined: false)[Vertiefende Verständnisfragen und Rechenaufgaben]
Eigene Anwendungsaufgaben zu den behandelten Bilanzen nach N S. 6, 8, 10 und 12. Die Turbine und Düse sind eigene Zahlenbeispiele, keine Lösungen der nur angekündigten Vorlesungsbeispiele 2 und 3.
#block[
#set enum(start: 5)
+ *Kugel, Variante:* Dieselbe Bleikugel ($c_"Pb"=130 thin "J/(kg K)"$) fällt aus $z_1=50 thin "m"$ mit $c_1=10 thin "m/s"$. Um wie viel erwärmt sie sich höchstens?
+ *Turbine (eigenes Zahlenbeispiel):* Eine adiabate Dampfturbine wird stationär mit $dot(m)=10 thin "kg/s"$ durchströmt, $h_1=3200 thin "kJ/kg"$, $h_2=2500 thin "kJ/kg"$. Änderungen von $c$ und $z$ sind vernachlässigbar. Bestimme $P$ und deute das Vorzeichen.
+ *Rührer:* In einen starren, adiabaten Behälter werden mit einem Rührer $50 thin "kJ"$ Arbeit eingebracht. Wie ändert sich $U$? Welcher Sonderfall aus 3.1.3 liegt vor, und warum ist es *kein* abgeschlossenes System?
+ *Düse:* In einer adiabaten Düse ohne technische Arbeit und ohne Höhenänderung sinkt die Enthalpie um $45 thin "kJ/kg"$. Eintrittsgeschwindigkeit $c_1=50 thin "m/s"$. Bestimme $c_2$.
+ *Stickstoffgefäß, Ü 2.1 e–g; W23 und M2:* Verwende die Daten aus Aufgabe 26 in Kapitel 2 und Abschnitt 2.13.2. Bestimme die Heizerenergie für die Entnahme von 1 kg Flüssigkeit. Stelle für Zustand ② die 13 Größen $p,T,x,mu,v,h,u,s,m,V,H,U,S$ jeweils für Gesamtgemisch, gesättigte Flüssigkeit und Sattdampf zusammen, mit Einheit, Einordnung und Formelzusammenhang. Berechne danach $Delta H_23$ und $Delta S_23$. Prüfe, wie die Änderungen der Gesamtgrößen zu den spezifischen Größen und zur Energiezufuhr passen.
]

#pagebreak()
== Lösungen Kapitel 3
+ Der Wasserstand (gespeicherte Energie) ändert sich um das, was durch die Bäche netto zu- oder abfließt. Ist das Wasser im Teich, weiß man nicht mehr, ob es als „Wärme“ oder „Arbeit“ kam: Gespeichert ist nur Energie. $Q$ und $W$ existieren nur während des Übertragens und hängen vom Weg ab. #nachschlagen[Lernskript, #stelle(<a-3-1>)]
+ Im offenen System muss Stoff gegen den Druck hinein- und hinausgeschoben werden. Diese Verschiebearbeit $p v$ steckt in $h=u+p v$. Im geschlossenen System fließt kein Stoff über die Grenze, also gibt es keine Verschiebearbeit. #nachschlagen[Lernskript, #stelle(<a-3-1-1>); #stelle(<a-3-1-2>)]
+ Offen: Druckarbeit $w_p=integral v dif p$ (Teil von $w_t$). Geschlossen: Volumenarbeit $w_v=-integral p dif v$ (Teil von $w_g$). Bei Kompression ist $dif v<0$; das Minus macht die zugeführte Arbeit positiv. #nachschlagen[Lernskript, #stelle(<a-3-1-2>)]
+ Die geschlossene Bilanz vergleicht hier eine Energiemenge zwischen zwei Zeitpunkten: $Q_12$ in kJ. Die offen-stationäre Bilanz verwendet einen Energiestrom: $dot(Q)_12=dot(m)q_12$ in kW. Der Punkt heißt „pro Zeit“; auch ein geschlossenes System kann einen Wärmestrom aufnehmen. #nachschlagen[Lernskript, #stelle(<a-3-1>)]

#block(breakable: false)[
#heading(level: 3, outlined: false)[5 · Kugel: äußere Energie wird innere Energie]
*Modell:* geschlossen, konstante Wärmekapazität; kein Rückprall und keine Energieabgabe an Boden und Umgebung. Die gesamte anfängliche äußere Energie erwärmt die Kugel.

*1 · Vollständige Bilanz vereinfachen:* $Delta u+Delta(c^2/2)+g Delta z=q_12+w_12$. Mit $q_12=w_12=c_2=z_2=0$ folgt $c_"Pb" Delta T=c_1^2/2+g z_1$.

*2 · Einsetzen:* $Delta T=(10^2/2+"9,81" dot 50)/130 thin "K"="540,5"/130 thin "K"$.

*Ergebnis: $Delta T approx "4,16" thin "K"$.*

*Prüfung:* J/kg geteilt durch J/(kg K) ergibt K; die Masse kürzt sich. Energieabgabe an die Umgebung senkt die mögliche Erwärmung. Innere Dissipation bei der Verformung ist nicht pauschal eine Energieabgabe.
#nachschlagen[Lernskript, #stelle(<a-3-1-4>)]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[6 · Adiabate Turbine: Leistung mit Vorzeichen]
*Modell:* offen, stationär, ein Ein- und Austritt; $dot(Q)=0$, Änderungen von Bewegungs- und Lageenergie vernachlässigt.

*1 · Bilanz vereinfachen:* $dot(Q)+P=dot(m)[Delta h+Delta(c^2/2)+g Delta z]$ ergibt $P=dot(m)(h_2-h_1)$.

*2 · Einsetzen:* $P=10 thin "kg/s" dot (2500-3200) thin "kJ/kg"$.

*Ergebnis: $P=-7000 thin "kW"=-7 thin "MW"$.* Die Turbine gibt 7 MW ab.

*Prüfung:* kg/s mal kJ/kg ergibt kW. Sinkende Enthalpie und negative Zufuhrleistung passen zusammen; der Betrag der Abgabeleistung ist positiv.
#nachschlagen[Lernskript, #stelle(<a-3-1-1>)]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[7 · Rührer im starren Behälter]
*Modell:* geschlossen, adiabat und starr; gleiche äußere Bewegungs- und Lageenergie vor und nach dem Rühren. Der Endzustand wird nach dem Abklingen der Strömung betrachtet.

*1 · Energie über die Grenze zählen:* $Q_12=0$, $W_(v 12)=0$, aber $W_(g,12)=+50 thin "kJ"$ durch die Rührerwelle.

*2 · Bilanz:* $Delta U=Q_12+W_(g,12)=0+50 thin "kJ"$.

*Ergebnis: $Delta U=+50 thin "kJ"$.* Es ist der Sonderfall mit Dissipation; im Modell gilt $J_12=50 thin "kJ"$.

*Prüfung:* Die Rührarbeit wird nur einmal gezählt. Starr bedeutet keine Volumenarbeit, nicht keine Wellenarbeit; wegen der Arbeitszufuhr ist das System nicht abgeschlossen.
#nachschlagen[Lernskript, #stelle(<a-3-1-3>)]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[8 · Düse: Enthalpie wird Bewegungsenergie]
*Modell:* offen, stationär, adiabat; keine technische Arbeit und keine Höhenänderung.

*1 · Bilanz vereinfachen:* $h_2-h_1+(c_2^2-c_1^2)/2=0$.

*2 · Einheiten angleichen:* $h_2-h_1=-45 thin "kJ/kg"=-45000 thin "J/kg"$.

*3 · Auflösen:* $c_2=sqrt(c_1^2-2(h_2-h_1))=sqrt(50^2+2 dot 45000) thin "m/s"$.

*Ergebnis: $c_2 approx "304,1" thin "m/s"$.*

*Prüfung:* J/kg entspricht m²/s². Der Enthalpieabfall erhöht die Geschwindigkeit; ein Faktor 1000 darf vor der Wurzel nicht fehlen.
#nachschlagen[Lernskript, #stelle(<a-3-1-1>)]
]

#pagebreak()
#heading(level: 3, outlined: false)[9 · Stickstoff: Heizerenergie und Zustandsgrößen]
*Modell:* starrer Gefäßinhalt, offen und instationär beim Entnehmen; $p_2=p_3="1,4"$ bar, $V="0,05"$ m³. Flüssigkeit tritt aus. Heizerspeicherung, äußere Energieänderungen und weitere Verluste werden wie in M2 vernachlässigt. Für Stoffwerte verwenden wir durchgehend die gedruckte Originaltabelle aus Ü 2.1.

#block(breakable: false)[
*1 · Verdampfte Masse und Energiezufuhr:*
Aus Kapitel 2, Lösung 26: $Delta m'' approx "0,007903664"$ kg. Bei 1,4 bar ist $h''-h'="79,245"-(-"116,15")="195,395"$ kJ/kg.
$ Q_"zu,23"=Delta m''(h''-h') approx "0,007903664" dot "195,395" thin "kJ" $
*Ergebnis: $Q_"zu,23" approx "1,54434"$ kJ.* Bei der Grenze um Stickstoff und Heizer ist dies die zugeführte elektrische Arbeit. Ohne eine Entnahmedauer lässt sich keine feste Leistung angeben; bei konstanter Leistung wäre $P_"el"=Q_"zu,23"/Delta t$.

*Prüfung:* kg mal kJ/kg ergibt kJ. Die Energie gehört zur nachverdampfenden Masse von rund 7,904 g, nicht zur gesamten Entnahme von 1 kg.
#nachschlagen[Lernskript, #stelle(<a-3-2-1>); W23, PDF-S. 3; M2, PDF-S. 2–3.]
]

#block(breakable: false)[
*2 · Zustand ② aufbauen:*
$m_2=m_1 approx "36,31895896"$ kg. Da bis zum Entnahmebeginn kein Stoff austritt, ist
$ v_2=V/m_2 approx "0,00137669144" thin "m"^3/"kg" $
$ x_2=frac(v_2-v', v''-v') approx "0,0007244437" quad mu_2=frac(x_2 v'', v_2) approx "0,0846268" $
Das sind *0,07244 Massen-% Dampf*, aber *8,4627 Volumen-% Dampf*. $h_2=h'+x_2(h''-h')$, $s_2=s'+x_2(s''-s')$, $u_2=h_2-p_2v_2$. Die extensiven Werte folgen anschließend durch Multiplikation mit den jeweiligen Massen.
#nachschlagen[Lernskript, #stelle(<a-2-13-2>); #stelle(<a-3-2-2>); M2, PDF-S. 6–7.]
]

#block(breakable: false)[
#heading(level: 3, outlined: false)[9 · Die 3 × 13 Zustandsgrößen bei Entnahmebeginn]
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
#nachschlagen[Lernskript, #stelle(<a-3-2-2>); Originaldaten Ü 2.1, PDF-S. 11; M2, PDF-S. 4 und 6–7; Werte hier konsistent neu gerechnet.]
]

#block(breakable: false)[
*3 · Zustand ③ nach 1 kg Entnahme:*
$ m_3=m_2-1 thin "kg" approx "35,318959" thin "kg" $
$ v_3=V/m_3 approx "0,0014156703" thin "m"^3/"kg" quad x_3=frac(v_3-v',v''-v') approx "0,000968735" $
Mit derselben Sättigungszeile: $h_3 approx -"115,960714"$ kJ/kg und $s_3 approx "2,91045993"$ kJ/(kg K).

*Ergebnis:*
$ Delta H_23=m_3 h_3-m_2 h_2 approx +"117,6943" thin "kJ" $
$ Delta S_23=m_3 s_3-m_2 s_2 approx -"2,88885" thin "kJ/K" $

*4 · Energiebilanz kontrollieren:* Bei konstantem $p,V$ ist $Delta U_23=Delta H_23$. Daher
$ Delta U_23+m_"entn" h'="117,69434"+1 dot (-"116,15") thin "kJ"="1,54434" thin "kJ"=Q_"zu,23" $
*Prüfung:* Die kleine Heizerenergie und die deutlich größere Änderung der gespeicherten Enthalpie widersprechen sich nicht: Zusätzlich verlässt Masse das System. $s_3>s_2$, gleichzeitig $S_3<S_2$, weil die verbleibende Masse kleiner ist.
#nachschlagen[Lernskript, #stelle(<a-3-2-1>); #stelle(<a-3-2-2>); M2, PDF-S. 3 und 8.]
]

#note("Abgleich mit den neuen Unterlagen", [M2 nennt gerundet $Delta H="117,679"$ kJ und $Delta S=-"2,887"$ kJ/K. Die konsistente Rechnung mit den gedruckten Ausgangswerten liefert die oben angegebenen Werte. Für den Zahlenvergleich sind Datensatz und Zwischenrundung maßgeblich. Wir verwenden durchgängig $h''="79,245"$ kJ/kg und $s''="5,3442"$ kJ/(kg K) aus der gedruckten Originaltabelle. Die Quelle bleibt unverändert.], fill: sand)
#src[Ü 2.1, PDF-S. 11; W23, PDF-S. 1–3; M2, PDF-S. 1–3 und 6–8. Eigene Nachrechnung mit ungerundeten Zwischenwerten.]

#pagebreak()
= Anhang

== Formelsammlung mit Voraussetzungen
Die Gleichungen sind mit der Zufuhrkonvention formuliert. $W$ und $P_t$ sind positiv bei Zufuhr zum System. In den Gasgleichungen ist $p$ der Absolutdruck, $T$ die Kelvin-Temperatur.

#tab(columns: (1.15fr, 1.8fr, 1.7fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Massenbilanz], [$dif m_"Sys"/dif t=sum dot(m)_"ein"-sum dot(m)_"aus"$], [Keine Erzeugung der Gesamtmasse. Stationär: linke Seite null.],
 [Energie, geschlossen], [$Delta U=Q_12+W_12$], [Keine wesentliche Änderung der äußeren Energien. Gesamte Arbeit zählen.],
 [Enthalpie], [$H=U+p V$, $h=u+p v$], [$"J"$ beziehungsweise $"J/kg"$.],
 [Enthalpiestrom], [$dot(H)=dot(m)h$], [$"kg/s" times "kJ/kg"="kW"$.],
 [Stationärer Strom], [$dot(Q)+P_t=dot(m)(h_2-h_1)$], [Ein Ein-/Austritt; äußere Energieänderungen vernachlässigt.],
 [Wirkungsgrad], [$eta=P_"Nutz"/P_"Aufwand"$], [Passende Nutzen- und Aufwandsdefinition.],
 [Wärmeausdehnung], [$Delta L=alpha_L L_0 Delta T$; $Delta V=alpha_V V_0 Delta T$], [Kleine Änderungen; passende, annähernd konstante Koeffizienten in 1/K.],
 [Lineare Interpolation], [$y=y_1+f(y_2-y_1)$; $f=(a-a_1)/(a_2-a_1)$], [Zwischen nahen Tabellenpunkten desselben Zustandsgebiets.],
 [Mittlere Wärmekapazität ab 0 °C], [$Delta h=(C_2 vartheta_2-C_1 vartheta_1)(1 thin "K")$], [$vartheta_i$ sind Celsius-Zahlenwerte; $C_i$ auf 0 °C bezogene Mittelwerte.],
 [Brennstoff], [$dot(m)_B=dot(Q)_B/H_u$], [Heizwert und Leistung in passenden Einheiten.],
 [Stoffmenge], [$m=n M$], [$n$ in kmol, $M$ in kg/kmol.],
 [Spezifisches Volumen], [$v=V/m=1/rho$], [$"m"^3/"kg"$.],
 [Kontinuität], [$dot(m)=rho A c$], [Passender mittlerer Querschnittswert.],
 [Stationär, Dichte konstant], [$A_1 c_1=A_2 c_2$], [Nicht ohne Dichteprüfung auf Gase übertragen.],
 [Ideales Gas], [$p v=R T$, $p V=m R T$], [Geeigneter Gaszustand; konsistente Einheiten.],
 [Isochor, ideales Gas], [$p_2/p_1=T_2/T_1$], [Geschlossen, gleiches Volumen und gleiche Gaszusammensetzung.],
 [Realgasfaktor], [$Z=p v/(R T)$], [Zustandsabhängig; ideal $Z=1$.],
 [Absolutdruck], [$p_"abs"=p_e+p_"amb"$], [Überdruck kann negativ sein.],
 [Hydrostatik], [$p=p_0+rho g h$], [Ruhende Flüssigkeit, konstante Dichte, Tiefe nach unten.],
 [U-Rohr, einfacher Fall], [$abs(Delta p)=rho_M g Delta h$], [Gasdichte vernachlässigt.],
 [Temperatur], [$T/"K"=theta/"°C"+"273,15"$], [Zahlenwertgleichung; Differenzen haben dieselbe Schrittweite.],
 [Volumenarbeit], [$W_v=-integral p dif V$], [Systemdruck bei quasistatischer Grenzbewegung.],
 [Isobare Volumenarbeit], [$W_v=-p(V_2-V_1)$], [Zusätzlich konstanter Druck.],
 [Isotherm, ideales Gas], [$W_v=m R T ln(V_1/V_2)$], [Geschlossene Masse, quasistatische Volumenarbeit.],
 [Reversible technische Arbeit], [$w_t=integral v dif p$], [Reversibel; Änderungen von Bewegungs- und Lageenergie vernachlässigt.],
 [Sensible Erwärmung], [$Q approx m c_p Delta T$], [Isobares Modell, nur Volumenarbeit, $c_p$ näherungsweise konstant.],
 [Verdampfungsenthalpie], [$r=h''-h'$], [Beide Werte bei derselben Sättigung.],
 [Dampfgehalt], [$x=m''/m$], [Flüssig-Dampf-Gemisch; Massenanteil.],
 [Mischungsregel], [$y=y'+x(y''-y')$], [Für $y=v,h,u,s$ bei gleichem Sättigungszustand.],
 [Dampfgehalt aus Stoffwert], [$x=(y-y')/(y''-y')$], [Nur im Zweiphasenmodell.],
 [Innere Energie], [$u=h-p v$], [Pa·m³/kg ergibt J/kg; kPa·m³/kg ergibt kJ/kg.],
 [Bestand aus Strömen], [$m=m_0+integral_0^t dot(m)_"netto" dif tau$], [Anfangsbedingung und gültiger Zeitbereich erforderlich.],
 [Zeitmittelwert], [$overline(y)=integral_(t_1)^(t_2)y(t)dif t/(t_2-t_1)$], [Diskret: Zeitabschnitte gewichten.],
 [Heizrampe], [$P_"el" approx m c "d"theta/"d"t$], [Geschlossen, adiabat; konstantes $m,c$; weitere Speicher vernachlässigt.],
 [Mittlere Wärmekapazität], [$Delta h=overline(c)_(p,12) Delta T$], [Intervall und Tabellenbezug beachten; isobare Stoffwertänderung.],
 [Reales Gas, isochor], [$p_2/p_1=Z_2 T_2/(Z_1 T_1)$], [Gleiche Masse und gleiches Volumen; $Z$ passend zum Zustand.],
 [Dampfvolumenanteil], [$mu=x v''/v$], [Nicht mit dem Massenanteil $x$ verwechseln.],
 [Bernoulli, ergänzend], [$p/rho+c^2/2+g z="konstant"$], [Entlang Stromlinie, stationär, inkompressibel, reibungsfrei; keine Maschinenarbeit.],
 [Torricelli, ergänzend], [$c_0=sqrt(2 g h)$], [Großer offener Behälter, kleine Öffnung, Verluste vernachlässigt.],
 [Clapeyron], [$dif p_s/dif T=Delta h/(T Delta v)$], [Entlang der Phasengrenze; Differenzen zwischen den Phasen.],
 [Gemisch: Anteile], [$xi_i=m_i/m_g$; $psi_i=n_i/n_g$; $sum xi_i=sum psi_i=1$], [$xi$ Massenanteil, $psi$ Molanteil; Bezugsgröße immer nennen.],
 [Gemisch: Umrechnung], [$xi_i=psi_i M_i/M_g$; $M_g=sum psi_i M_i$], [$M$ in kg/kmol.],
 [Gemisch: Partialgrößen], [$p_i=psi_i p_g$; $V_i=psi_i V_g$], [Ideale Gase bei gleichem $T$; Partialdruck bei $V_g$, Partialvolumen bei $p_g$.],
 [Gemisch idealer Gase], [$R_g=sum xi_i R_i$; $1/M_g=sum xi_i/M_i$; $p V=m_g R_g T$], [Ideale Gase, keine Reaktion; Luft: $M="28,964" thin "kg/kmol"$, $R approx 287 thin "J/(kg K)"$.],
 [Van der Waals], [$(p+a/v^2)(v-b)=R T$], [Reales Fluid; $a,b$ stoffabhängig aus Tabellen.],
 [1. HS offen, stationär], [$h_2-h_1+(c_2^2-c_1^2)/2+g(z_2-z_1)=q_12+w_(t,12)$], [Ein Ein-/Austritt, $dot(m)_1=dot(m)_2$. Alle Terme in J/kg oder einheitlich in kJ/kg.],
 [1. HS offen, extensiv], [$dot(H)_2-dot(H)_1+dot(m)[(c_2^2-c_1^2)/2+g Delta z]=dot(Q)_12+P_12$], [W bei J/kg, kW bei kJ/kg; $P=dot(m)w_t$, $dot(Q)=dot(m)q$.],
 [Technische Arbeit], [$w_t=j_12+integral v dif p+(c_2^2-c_1^2)/2+g(z_2-z_1)$], [$j_12$ Dissipation; $w_p=integral v dif p$ Druckarbeit (offen).],
 [1. HS geschlossen], [$u_2-u_1+(c_2^2-c_1^2)/2+g(z_2-z_1)=q_12+w_(g,12)$], [Konstante Masse; einheitlich J/kg oder kJ/kg. Extensiv alle Terme mit $m$ multiplizieren.],
 [Gesamtarbeit], [$w_g=j_12-integral p dif v+(c_2^2-c_1^2)/2+g(z_2-z_1)$], [Minus bei der Volumenarbeit: Kompression zählt positiv.],
 [Ruhend, reibfrei, adiabat], [$m(u_2-u_1)=W_(v 12)$], [$c_1=c_2=0$, $dif z=0$, $J_12=0$, $Q_12=0$.],
 [Abgeschlossenes System], [$Delta E_"sys"=0$; ruhend: $u_2-u_1=0$], [Kein Stoff-, Wärme- oder Arbeitsaustausch. Für $Delta u=0$ zusätzlich äußere Energien unverändert.],
 [Äußere Energie: Einheiten], [$Delta e_"kin"=(c_2^2-c_1^2)/2$; $Delta e_"pot"=g Delta z$], [Mit m/s und m zunächst J/kg; Zahlenwerte durch 1000 für kJ/kg.],
 [Rückwärtige Interpolation], [$vartheta=vartheta_1+frac(v-v_1,v_2-v_1)(vartheta_2-vartheta_1)$], [Gleicher Druck, gleiches Zustandsgebiet; lineare Näherung.],
 [Extensive Phasengröße], [$Y=m'y'+m''y''$], [$Y=V,H,U,S$; $y=v,h,u,s$. Beide Phasen bei gleicher Sättigung.],
 [Entropiestrom], [$dot(S)=dot(m)s$], [kg/s mal kJ/(kg K) ergibt kW/K.],
 [Isobare Flüssigkeitsentnahme], [$Delta m''=frac(v' m_"entn",v''-v')$], [Starrer Behälter, Sättigung, p konstant; Entnahme flüssig.],
 [Instationär, starr, Ausfluss], [$Delta U=E_"zu"-m_"entn" h_"aus"$], [Kein Zufluss; konstantes $h_"aus"$; äußere Energien vernachlässigt.],
 [Stickstoff: Heizerenergie], [$E_"zu"=Delta m''(h''-h')$], [Zusätzlich isobare gesättigte Flüssigkeitsentnahme wie in Ü 2.1.],
 [Fester Stoff], [$u_2-u_1=c Delta T$], [Inkompressibel; $c$ in J/(kg K).],
)

#note("Wichtige Zahlen", [
$R_"Luft"="287,2" thin "J/(kg K)"$; $g approx "9,81" thin "m/s"^2$.

$1 thin "bar"=10^5 thin "Pa"$; $1 thin "l"=10^(-3) thin "m"^3$; $1 thin "cm"^2=10^(-4) thin "m"^2$.

$1 thin "kWh"="3,6" thin "MJ"$; Wasser flüssig näherungsweise $rho=1000 thin "kg"/"m"^3$, $c approx "4,19" thin "kJ/(kg K)"$ für die hier gerechneten Überschläge.
])

