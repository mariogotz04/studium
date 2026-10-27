# Mein Studium

Lernplattform fürs Studium: Lernskripte, Karteikarten, Aufgaben mit Lösungen in Schritten, Quiz, Pomodoro-Timer, Vorlesungsplan, Fristen und To-dos. Die Typst-Dateien unter `skripte/` werden bei jedem Push
von einer GitHub Action zu PDFs kompiliert und auf GitHub Pages veröffentlicht.

- **Aktualisieren:** Doppelklick auf `Uni/Webseite/Webseite aktualisieren.command` (siehe `AGENTS.md`).
- **Lokal bauen:** `python3 build.py` (braucht `typst`), Ergebnis in `_site/`.
- **Aufbau:** `skripte/<Modul>/Lernskript aktuell/Typst-Dateien/main.typ`, genau ein aktuelles Skript je Modul; der Titel kommt aus `#set document(title: …)`.
- **Karteikarten:** `skripte/<Modul>/Lernskript aktuell/Karteikarten.md`, unter „Lernen → Modul → Karteikarten“ neben Aufgaben, Quiz und Probeklausur. Jede Kartenrunde bleibt in einem Modul; „Heute dran“ sorgt weiterhin für Interleaving zwischen den Modulen.
- **Aufgaben:** `skripte/<Modul>/Lernskript aktuell/Typst-Dateien/Aufgaben.typ`, **Quiz:** `skripte/<Modul>/Lernskript aktuell/Quiz.md`, beide im Reiter „Lernen“.
- **Im Skript nachlesen:** Quellenlinks der Lernformate öffnen die passende Seite in der integrierten PDF-Ansicht und markieren die zur jeweiligen Antwort passende Textstelle gelb. Die Positionen werden beim Build neu ermittelt; beim nächsten Verweis wird die vorherige Markierung ersetzt.
- **Vorlesungsplan:** `Vorlesungsplan.pdf` (thabella-Export), wird von `build.py` eingelesen. Lokal braucht der Build dafür `pip install pypdf pdfplumber`.

Nach neuen Vorlesungsunterlagen werden Lernskript, Aufgaben mit Lösungen, Quiz mit Antworterklärungen und Karteikarten gemeinsam geprüft und passend erweitert. Bestehende Antworten werden bei fachlichem Bedarf korrigiert; der Build veröffentlicht die gepflegten Quellen und aktualisiert ihre Seitenverweise.

## Hörzusammenfassungen

Unter Lernskripte gibt es je Modul eine Feynman-Hörzusammenfassung als EPUB und eine Leseansicht mit aufdeckbaren Denkfragen. Lade die EPUB herunter und importiere sie in ElevenReader. Halte bei Denkpausen selbst kurz an und höre die Auflösung erst nach Deiner eigenen Erklärung. Bei einem neuen Stand die neue Datei erneut importieren.

Die redaktionelle Quelle ist `Lernskript aktuell/Hoerskript.md` je Modul. Sie wird bei neuen Vorlesungsunterlagen mitgepflegt. Der Build erzeugt daraus EPUB-Dateien mit Kapitelnavigation und prüft Kapitel, Quellen sowie den abgeglichenen Skriptstand.


## Mein Lerntag

„Mein Warum“ erinnert an die persönliche Richtung. Unter „Meine Richtung“ lassen sich Vision, Identitätssatz, Anti-Vision und ein Wenn-dann-Plan speichern. Täglich wechselnde Zitate können favorisiert oder ausgeschaltet werden. Angezeigt werden nur Zitat und Name; Werkangaben und Quellen dienen intern der Prüfung. Die Eingaben liegen im privaten Lernstand und werden bei Anmeldung synchronisiert.

„Heute dran“ behält die Tagesauswahl und hakt Aufgaben nach Bewertung, Quizrunden nach vollständiger Auswertung sowie Kartenrunden, Mix-Serien und Probeklausuren nach tatsächlichem Abschluss automatisch ab. Manuelle Haken bleiben möglich. Bearbeitet bedeutet nicht automatisch beherrscht.

Alle Rechenaufgaben stehen mit den benötigten Zahlenwerten, Einheiten und gegebenenfalls Tabellen/Skizzen direkt in der Aufgabe. Gegeben/Annahmen, Gesucht, Teilfragen und Aufgabennummern gliedern die Übungen. Zitatquellen werden zentral in `zitate.json` gepflegt.


Die Zitatdatenbank enthält zunächst 100 Zitate von 28 Personen. Angezeigte Tageszitate werden im privaten Lernstand gemerkt: zuerst unbenutzte Einträge, danach die am längsten nicht gezeigten. Auf der Seite „Meine Richtung“ lassen sich Zitate nach Text oder Person durchsuchen und favorisieren.

Ein GitHub-Workflow sucht wöchentlich nach weiteren passenden Zitaten in den Quellenabschnitten festgelegter Wikiquote-Autorenseiten und ergänzt bis zu zehn neue Einträge mit Werkangabe. Unsichere Zuschreibungen, Dubletten und redaktionell ausgeschlossene Einträge werden ausgelassen. Wenn die Quellen ausfallen oder nichts Neues passt, bleibt die Sammlung erhalten. Quellenprüfung erfolgt beim Import; beim Öffnen der Webseite sind keine Anfragen an Zitatdienste nötig. Online ergänzte Einträge bleiben in der veröffentlichten Datendatei und werden beim nächsten Build oder lokalen Upload übernommen. Der Workflow benötigt dafür keine Schreibrechte auf den Quellcode.

Prüfen: `python3 -m unittest test_zitate.py` und `node test_zitate.cjs`. Beide Prüfungen laufen im GitHub-Build.
