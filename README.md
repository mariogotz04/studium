# Mein Studium

Lernplattform fürs Studium: Lernskripte, Karteikarten, Aufgaben mit Lösungen in Schritten, Quiz, Pomodoro-Timer, Vorlesungsplan, Fristen und To-dos. Die Typst-Dateien unter `skripte/` werden bei jedem Push
von einer GitHub Action zu PDFs kompiliert und auf GitHub Pages veröffentlicht.

- **Aktualisieren:** Doppelklick auf `Uni/Webseite/Webseite aktualisieren.command` (siehe `AGENTS.md`).
- **Lokal bauen:** `python3 build.py` (braucht `typst`), Ergebnis in `_site/`.
- **Aufbau:** `skripte/<Modul>/Lernskript aktuell/Typst-Dateien/main.typ`, genau ein aktuelles Skript je Modul; der Titel kommt aus `#set document(title: …)`.
- **Karteikarten:** `skripte/<Modul>/Lernskript aktuell/Karteikarten.md`, unter „Lernen → Modul → Karteikarten“ neben Aufgaben, Quiz und Probeklausur. Jede Kartenrunde bleibt in einem Modul; „Heute dran“ sorgt weiterhin für Interleaving zwischen den Modulen.
- **Aufgaben:** `skripte/<Modul>/Lernskript aktuell/Typst-Dateien/Aufgaben.typ`, **Quiz:** `skripte/<Modul>/Lernskript aktuell/Quiz.md`, beide im Reiter „Lernen“.
- **Vorlesungsplan:** `Vorlesungsplan.pdf` (thabella-Export), wird von `build.py` eingelesen. Lokal braucht der Build dafür `pip install pypdf pdfplumber`.

Nach neuen Vorlesungsunterlagen werden Lernskript, Aufgaben mit Lösungen, Quiz mit Antworterklärungen und Karteikarten gemeinsam geprüft und passend erweitert. Bestehende Antworten werden bei fachlichem Bedarf korrigiert; der Build veröffentlicht die gepflegten Quellen und aktualisiert ihre Seitenverweise.
