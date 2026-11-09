# Mein Studium

Lernplattform fürs Studium: Lernskripte, Karteikarten, Aufgaben mit Lösungen in Schritten, Quiz, Pomodoro-Timer, Vorlesungsplan, Fristen und To-dos. Die Typst-Dateien unter `skripte/` werden bei jedem Push
von einer GitHub Action zu PDFs kompiliert und auf GitHub Pages veröffentlicht.

- **Aktualisieren:** Doppelklick auf `Uni/Webseite/Webseite aktualisieren.command` (siehe `AGENTS.md`).
- **Lokal bauen:** `python3 build.py` (braucht `typst`), Ergebnis in `_site/`.
- **Aufbau:** `skripte/<Modul>/Lernskript aktuell/Typst-Dateien/main.typ`, genau ein aktuelles Skript je Modul; der Titel kommt aus `#set document(title: …)`.
- **Karteikarten:** `skripte/<Modul>/Lernskript aktuell/Karteikarten.md`, unter „Lernen → Modul → Karteikarten“ neben Aufgaben, Quiz und Probeklausur. Jede Kartenrunde bleibt in einem Modul; „Heute dran“ sorgt weiterhin für Interleaving zwischen den Modulen.
- **Kartenstil:** kurze Stichpunkte mit einem Gedanken je Punkt, gezielte Merksätze und passende Alltagsbilder. Formeln und Gültigkeitsbedingungen bleiben erhalten. Das gilt laut Abschnitt 8.5 aller Modul-AGENTS.md auch für neue Vorlesungsinhalte. `python3 -m unittest test_karten.py` prüft Quellenstil und Darstellung von Liste, Merksatz und Merkbild.
- **Aufgaben:** `skripte/<Modul>/Lernskript aktuell/Typst-Dateien/Aufgaben.typ`, **Quiz:** `skripte/<Modul>/Lernskript aktuell/Quiz.md`, beide im Reiter „Lernen“.
- **Im Skript nachlesen:** Quellenlinks der Lernformate öffnen die passende Seite in der integrierten PDF-Ansicht und markieren die zur jeweiligen Antwort passende Textstelle gelb. Die Positionen werden beim Build neu ermittelt; beim nächsten Verweis wird die vorherige Markierung ersetzt.
- **Notizblatt:** Bei Karteikarten, Verständnisfragen und Quiz bei Bedarf ausklappen. Nur mit dem Apple Pencil beziehungsweise Stift schreiben; Finger und Handballen erzeugen keine Striche. Zwei Finger verschieben und zoomen die unendliche weiße Fläche. „Kleiner/Größer“ ändern die Blattansicht; Zoomknöpfe und „Zum Anfang“ helfen bei der Navigation. Radierer, Rückgängig und Leeren stehen darüber. Die Notizen bleiben beim Aufdecken und Größenwechsel erhalten und verschwinden beim Fragenwechsel. Sie werden nicht gespeichert. Auf kleinen Displays steht das Blatt oberhalb der Frage. Rechenaufgaben bleiben ohne Notizblatt.
- **Fragetypen:** „Zeichne die Begriffslandkarte …“-Fragen werden zentral aus allen Modulen herausgefiltert. Andere Karten und ihre Lernstand-IDs bleiben erhalten.
- **Quellenzuordnung:** Unsichere Texttreffer werden nicht gelb markiert; dann öffnet sich der angegebene Abschnitt mit einem entsprechenden Hinweis. Prüfen: `python3 -m unittest test_quellen.py` (Integration mit PDF nach dem Build) und `node test_notizen.cjs`.
- **Wochenplan:** Unter **Termine → Lernplan** ein Wochenbudget in Stunden, Klausuren, Einheitenlänge, Pausen und Reserve wählen; Vorschau prüfen und bewusst übernehmen. Die Aufgabenliste ist nach Fächern gegliedert und enthält Fortschritt, geschätzte Restzeit sowie Startknöpfe. Innerhalb der Woche teilst du deine Lerntage selbst ein; die Abschnittsreihenfolge bleibt erhalten. Start zeigt dieselben offenen Wochenziele. Bestehende Tagespläne werden mit ihrem bisherigen Gesamtbudget und Lernstand nach Wochen dargestellt; die ursprüngliche Planversion bleibt erhalten.
- **Wochenbudget und Nachplanung:** Lern-/Pausenbudget und Reserve sind getrennt sichtbar. Die Bedarfsschätzung und Vorschau beachten Klausurfristen, freie Tage und Wiederholungsphasen; Einheiten bekommen ausschließlich eine Zielwoche. Für Klausuren mitten in der Woche und den Beginn von Wiederholungen erscheinen konkrete Grenzen. Offene Ziele bleiben bis Sonntag stabil und werden zum Wochenwechsel vor späteren Aufgaben neu verteilt. Die Reserve darf dabei genutzt werden; das gesamte Wochenbudget bleibt die Grenze. Ziele ohne passende Woche bleiben sichtbar offen. Wochenzuordnungen liegen privat und atomar unter `lernplan:wochen:<Version>`, getrennt von älteren Tagesdaten. PDF und Startseite nutzen dieselben Zuordnungen. Die PDF ist eine nach Fächern gegliederte Wochenliste zum Abhaken, mit Ziel- und Quellenlinks. Quellcode: `lernplan.js`, `lernplan-ui.js`, `lernplan-pdf.js`; Prüfung: `node test_lernplan.cjs`.
- **Zeitanzeige:** Lernzeiten und Budgets werden ab einer Stunde als Stunden und Minuten angezeigt, etwa `1 Std. 30 Min.`. Wochenplan, Startseite, Fachsummen, Probeklausuren, Pomodoro-Auswertungen und PDF nutzen dieselbe Darstellung.
- **Im Wochenplan weiterlernen:** Geöffnete und geschlossene Fachlisten bleiben gespeichert, auch nach Neuladen und Wochenwechsel. Aus einer dort gestarteten Übung führt „Zum Wochenplan“ zurück zur gewählten Woche und zum passenden Fach. Nach „Selbst gelöst“ kehren einzelne Aufgaben direkt dorthin zurück; bei Quiz, Karten und Probeklausuren bleibt die Auswertung mit Rücklink sichtbar. Geschlossene Fächer bleiben geschlossen. Die Scrollposition wird je Woche im aktuellen Browser-Tab gemerkt.
- **Vorlesungsplan:** `Vorlesungsplan.pdf` (thabella-Export), wird von `build.py` eingelesen. Lokal braucht der Build dafür `pip install pypdf pdfplumber`.

Nach neuen Vorlesungsunterlagen werden Lernskript, Aufgaben mit Lösungen, Quiz mit Antworterklärungen und Karteikarten gemeinsam geprüft und passend erweitert. Bestehende Antworten werden bei fachlichem Bedarf korrigiert; der Build veröffentlicht die gepflegten Quellen und aktualisiert ihre Seitenverweise.

## Hörzusammenfassungen

Unter Lernskripte gibt es je Modul eine Feynman-Hörzusammenfassung als EPUB und eine Leseansicht mit aufdeckbaren Denkfragen. Lade die EPUB herunter und importiere sie in ElevenReader. Halte bei Denkpausen selbst kurz an und höre die Auflösung erst nach Deiner eigenen Erklärung. Bei einem neuen Stand die neue Datei erneut importieren.

Die redaktionelle Quelle ist `Lernskript aktuell/Hoerskript.md` je Modul. Sie wird bei neuen Vorlesungsunterlagen mitgepflegt. Der Build erzeugt daraus EPUB-Dateien mit Kapitelnavigation und prüft Kapitel, Quellen sowie den abgeglichenen Skriptstand.


## Mein Lerntag

„Mein Warum“ erinnert an die persönliche Richtung. Unter „Meine Richtung“ lassen sich Vision, Identitätssatz, Anti-Vision und ein Wenn-dann-Plan speichern. Täglich wechselnde Zitate können favorisiert oder ausgeschaltet werden. Angezeigt werden nur Zitat und Name; Werkangaben und Quellen dienen intern der Prüfung. Die Eingaben liegen im privaten Lernstand und werden bei Anmeldung synchronisiert.

„Heute dran“ behält die Tagesauswahl und hakt Aufgaben nach Bewertung, Quizrunden nach vollständiger Auswertung sowie Kartenrunden, Mix-Serien und Probeklausuren nach tatsächlichem Abschluss automatisch ab. Manuelle Haken bleiben möglich. Bearbeitet bedeutet nicht automatisch beherrscht.

Nach Abgabe einer Mix-Serie führt „Lösung Schritt für Schritt“ zur Lösung innerhalb derselben Serie. „Zur Mix-Übersicht“ öffnet wieder dieselben fünf Aufgaben mit ihren bisherigen Bewertungen und aufgedeckten Ergebnissen. Bewertungen in der Lösung zählen ebenfalls für die Serie; abgeschlossen ist sie nach Bewertung aller Aufgaben. Dasselbe gilt für die Auswertung einer Probeklausur. Prüfen: `node test_mix.cjs`.

Alle Rechenaufgaben stehen mit den benötigten Zahlenwerten, Einheiten und gegebenenfalls Tabellen/Skizzen direkt in der Aufgabe. Gegeben/Annahmen, Gesucht, Teilfragen und Aufgabennummern gliedern die Übungen. Zitatquellen werden zentral in `zitate.json` gepflegt.


Die Zitatdatenbank enthält zunächst 100 Zitate von 28 Personen. Angezeigte Tageszitate werden im privaten Lernstand gemerkt: zuerst unbenutzte Einträge, danach die am längsten nicht gezeigten. Auf der Seite „Meine Richtung“ lassen sich Zitate nach Text oder Person durchsuchen und favorisieren.

Ein GitHub-Workflow sucht wöchentlich nach weiteren passenden Zitaten in den Quellenabschnitten festgelegter Wikiquote-Autorenseiten und ergänzt bis zu zehn neue Einträge mit Werkangabe. Unsichere Zuschreibungen, Dubletten und redaktionell ausgeschlossene Einträge werden ausgelassen. Wenn die Quellen ausfallen oder nichts Neues passt, bleibt die Sammlung erhalten. Quellenprüfung erfolgt beim Import; beim Öffnen der Webseite sind keine Anfragen an Zitatdienste nötig. Online ergänzte Einträge bleiben in der veröffentlichten Datendatei und werden beim nächsten Build oder lokalen Upload übernommen. Der Workflow benötigt dafür keine Schreibrechte auf den Quellcode.

Prüfen: `python3 -m unittest test_zitate.py` und `node test_zitate.cjs`. Beide Prüfungen laufen im GitHub-Build.

Alle Module werden Abschnitt für Abschnitt der Reihe nach gelernt, etwa 1.1 vor 1.2 vor 1.10.
Erst wenn im aktuellen Abschnitt alle Aufgaben selbst gelöst, alle Quizfragen richtig und alle Karteikarten gelernt sind, folgt der nächste.
Die Modulseite zeigt den nächsten Schritt und den passenden Skriptverweis. Neue Inhalte, fällige Karten, freies Üben,
Quiz einschließlich Tagesabschluss sowie Mix/Probeklausur bleiben innerhalb des erreichten Stoffs.
Bereits gespeicherte Auswahlen werden erneut geprüft; Bewertungen späterer Inhalte bleiben erhalten und warten auf ihre Freigabe.
Erreichte Abschlüsse werden synchronisiert und bleiben bei späteren Wiederholungsfehlern erhalten.
Prüfen: `node test_lernpfad.cjs`, optional `node test_lernpfad.cjs /pfad/zur/gebauten/index.html` mit echten Moduldaten.
