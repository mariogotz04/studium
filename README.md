# Mein Studium

Lernplattform fürs Studium: Lernskripte, Aufgaben mit Lösungen in Schritten (vor allem die Aufgaben der Professoren), Verständnisfragen, Lernplan bis zur Klausur, Pomodoro-Timer, Vorlesungsplan, Fristen und To-dos. Die Typst-Dateien unter `skripte/` werden bei jedem Push
von einer GitHub Action zu PDFs kompiliert und auf GitHub Pages veröffentlicht.

- **Aktualisieren:** Doppelklick auf `Uni/Webseite/Webseite aktualisieren.command` (siehe `AGENTS.md`).
- **Lokal bauen:** `python3 build.py` (braucht `typst`), Ergebnis in `_site/`.
- **Aufbau:** `skripte/<Modul>/Lernskript aktuell/Typst-Dateien/main.typ`, genau ein aktuelles Skript je Modul; der Titel kommt aus `#set document(title: …)`.
- **Aufgaben:** `skripte/<Modul>/Lernskript aktuell/Typst-Dateien/Aufgaben.typ`, im Reiter „Lernen“. Jede Aufgabe trägt eine Herkunft: **Original** (Übungsblatt oder Altklausur des Professors, mit Fundstelle), **Von Claude erstellt · nach …** (Variante einer Original-Aufgabe) oder **Von Claude erstellt** (eigene Aufgabe, darunter alle Verständnisfragen). Details: `AGENTS.md` und Abschnitt 8.6 der Modul-AGENTS.md.
- **Quiz und Karteikarten gibt es seit 11.11.2026 nicht mehr.** Ihre Fragen stehen als Verständnisfragen (`art: "verstehen"`) in `Aufgaben.typ`; „Zeichne die Begriffslandkarte …“-Fragen wurden nicht übernommen. `build.py` liest `Quiz.md` und `Karteikarten.md` nicht mehr (`QUIZ_UND_KARTEN = False`).
- **Im Skript nachlesen:** Quellenlinks der Lernformate öffnen die passende Seite in der integrierten PDF-Ansicht und markieren die zur jeweiligen Antwort passende Textstelle gelb. Die Positionen werden beim Build neu ermittelt; beim nächsten Verweis wird die vorherige Markierung ersetzt.
- **Notizblatt:** Bei Verständnisfragen bei Bedarf ausklappen. Nur mit dem Apple Pencil beziehungsweise Stift schreiben; Finger und Handballen erzeugen keine Striche. Zwei Finger verschieben und zoomen die unendliche weiße Fläche. „Kleiner/Größer“ ändern die Blattansicht; Zoomknöpfe und „Zum Anfang“ helfen bei der Navigation. Radierer, Rückgängig und Leeren stehen darüber. Die Notizen bleiben beim Aufdecken und Größenwechsel erhalten und verschwinden beim Fragenwechsel. Sie werden nicht gespeichert. Auf kleinen Displays steht das Blatt oberhalb der Frage. Rechenaufgaben bleiben ohne Notizblatt.
- **Quellenzuordnung:** Unsichere Texttreffer werden nicht gelb markiert; dann öffnet sich der angegebene Abschnitt mit einem entsprechenden Hinweis. Prüfen: `python3 -m unittest test_quellen.py` (Integration mit PDF nach dem Build) und `node test_notizen.cjs`.
- **Lernplan:** Unter **Termine → Lernplan** verteilt die Webseite alle offenen Aufgaben jedes Moduls in Lernreihenfolge auf die Wochen bis zur Klausur, ohne Wochenzeitbudget. Die letzten 14 Tage vor jeder Klausur (einstellbar 0–28) sind Probephase mit Probeklausuren und dem erneuten Lösen nicht selbst gelöster Aufgaben. Neue Aufgaben werden automatisch ab der folgenden Woche eingeplant; die laufende Woche bleibt bis Sonntag stabil, Liegengebliebenes verteilt sich beim Wochenwechsel neu. Privat im Sync-Zustand unter `lernplan:aufgabenplan` und `einst:aufgabenplan`. Ausführlich: `Uni/Webseite/Lernplan-Vorschlag.md`.
- **Wochen-PDF:** „Aufgaben KW N als PDF“ auf der Startseite und im Lernplan: Deckblatt zum Abhaken, je Aufgabe die Stellung wie im Skript (aus `pdf/<Modul>_Blatt.pdf`, gebaut mit `--input blatt=1`), ein Link zur Lösung und karierter Schreibraum für GoodNotes. Quellcode: `lernplan.js`, `lernplan-ui.js`, `lernplan-pdf.js`; Prüfung: `node test_lernplan.cjs`.
- **Zeitanzeige:** Lernzeiten werden ab einer Stunde als Stunden und Minuten angezeigt, etwa `1 Std. 30 Min.`. Wochenplan, Startseite, Fachsummen, Probeklausuren, Pomodoro-Auswertungen und PDF nutzen dieselbe Darstellung.
- **Im Wochenplan weiterlernen:** Geöffnete und geschlossene Fachlisten bleiben gespeichert, auch nach Neuladen und Wochenwechsel. Aus einer dort gestarteten Übung führt „Zum Wochenplan“ zurück zur gewählten Woche und zum passenden Fach. Nach „Selbst gelöst“ kehren einzelne Aufgaben direkt dorthin zurück; bei Mix-Serien und Probeklausuren bleibt die Auswertung mit Rücklink sichtbar. Geschlossene Fächer bleiben geschlossen. Die Scrollposition wird je Woche im aktuellen Browser-Tab gemerkt.
- **Vorlesungsplan:** `Vorlesungsplan.pdf` (thabella-Export), wird von `build.py` eingelesen. Lokal braucht der Build dafür `pip install pypdf pdfplumber`.

Nach neuen Vorlesungsunterlagen werden Lernskript, Formelsammlung (nach Kapiteln, Überschriften „=== Formeln zu Kapitel N · …“), Aufgaben mit Lösungen und Hörskript gemeinsam geprüft und passend erweitert. Neue Übungsblätter und Altklausuren kommen als Original-Aufgaben dazu, gekennzeichnete Varianten ergänzen sie. Bestehende Antworten werden bei fachlichem Bedarf korrigiert; der Build veröffentlicht die gepflegten Quellen und aktualisiert ihre Seitenverweise.

## Hörzusammenfassungen

Unter Lernskripte gibt es je Modul eine Feynman-Hörzusammenfassung als EPUB und eine Leseansicht mit aufdeckbaren Denkfragen. Lade die EPUB herunter und importiere sie in ElevenReader. Halte bei Denkpausen selbst kurz an und höre die Auflösung erst nach Deiner eigenen Erklärung. Bei einem neuen Stand die neue Datei erneut importieren.

Die redaktionelle Quelle ist `Lernskript aktuell/Hoerskript.md` je Modul. Sie wird bei neuen Vorlesungsunterlagen mitgepflegt. Der Build erzeugt daraus EPUB-Dateien mit Kapitelnavigation und prüft Kapitel, Quellen sowie den abgeglichenen Skriptstand.


## Mein Lerntag

„Mein Warum“ erinnert an die persönliche Richtung. Unter „Meine Richtung“ lassen sich Vision, Identitätssatz, Anti-Vision und ein Wenn-dann-Plan speichern. Täglich wechselnde Zitate können favorisiert oder ausgeschaltet werden. Angezeigt werden nur Zitat und Name; Werkangaben und Quellen dienen intern der Prüfung. Die Eingaben liegen im privaten Lernstand und werden bei Anmeldung synchronisiert.

„Heute dran“ behält die Tagesauswahl und hakt Aufgaben nach Bewertung sowie Mix-Serien und Probeklausuren nach tatsächlichem Abschluss automatisch ab. Manuelle Haken bleiben möglich. Bearbeitet bedeutet nicht automatisch beherrscht.

Nach Abgabe einer Mix-Serie führt „Lösung Schritt für Schritt“ zur Lösung innerhalb derselben Serie. „Zur Mix-Übersicht“ öffnet wieder dieselben fünf Aufgaben mit ihren bisherigen Bewertungen und aufgedeckten Ergebnissen. Bewertungen in der Lösung zählen ebenfalls für die Serie; abgeschlossen ist sie nach Bewertung aller Aufgaben. Dasselbe gilt für die Auswertung einer Probeklausur. Prüfen: `node test_mix.cjs`.

Alle Rechenaufgaben stehen mit den benötigten Zahlenwerten, Einheiten und gegebenenfalls Tabellen/Skizzen direkt in der Aufgabe. Gegeben/Annahmen, Gesucht, Teilfragen und Aufgabennummern gliedern die Übungen. Zitatquellen werden zentral in `zitate.json` gepflegt.


Die Zitatdatenbank enthält zunächst 100 Zitate von 28 Personen. Angezeigte Tageszitate werden im privaten Lernstand gemerkt: zuerst unbenutzte Einträge, danach die am längsten nicht gezeigten. Auf der Seite „Meine Richtung“ lassen sich Zitate nach Text oder Person durchsuchen und favorisieren.

Ein GitHub-Workflow sucht wöchentlich nach weiteren passenden Zitaten in den Quellenabschnitten festgelegter Wikiquote-Autorenseiten und ergänzt bis zu zehn neue Einträge mit Werkangabe. Unsichere Zuschreibungen, Dubletten und redaktionell ausgeschlossene Einträge werden ausgelassen. Wenn die Quellen ausfallen oder nichts Neues passt, bleibt die Sammlung erhalten. Quellenprüfung erfolgt beim Import; beim Öffnen der Webseite sind keine Anfragen an Zitatdienste nötig. Online ergänzte Einträge bleiben in der veröffentlichten Datendatei und werden beim nächsten Build oder lokalen Upload übernommen. Der Workflow benötigt dafür keine Schreibrechte auf den Quellcode.

Prüfen: `python3 -m unittest test_zitate.py` und `node test_zitate.cjs`. Beide Prüfungen laufen im GitHub-Build.

Alle Module werden Abschnitt für Abschnitt der Reihe nach gelernt, etwa 1.1 vor 1.2 vor 1.10.
Erst wenn im aktuellen Abschnitt alle Aufgaben einschließlich der Verständnisfragen selbst gelöst sind, folgt der nächste.
Die Modulseite zeigt den nächsten Schritt und den passenden Skriptverweis. Neue Inhalte, freies Üben,
der Tagesabschluss (drei Verständnisfragen) sowie Mix/Probeklausur bleiben innerhalb des erreichten Stoffs.
Bereits gespeicherte Auswahlen werden erneut geprüft; Bewertungen späterer Inhalte bleiben erhalten und warten auf ihre Freigabe.
Erreichte Abschlüsse werden synchronisiert und bleiben bei späteren Wiederholungsfehlern erhalten.
Prüfen: `node test_lernpfad.cjs`, optional `node test_lernpfad.cjs /pfad/zur/gebauten/index.html` mit echten Moduldaten.
