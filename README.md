# Meine Lernskripte

Webseite mit allen Lernskripten aus dem Studium. Die Typst-Dateien unter `skripte/` werden bei jedem Push
von einer GitHub Action zu PDFs kompiliert und auf GitHub Pages veröffentlicht.

- **Aktualisieren:** Doppelklick auf `Uni/Webseite/Webseite aktualisieren.command` (siehe `AGENTS.md`).
- **Lokal bauen:** `python3 build.py` (braucht `typst`), Ergebnis in `_site/`.
- **Aufbau:** `skripte/<Modul>/Lernskript aktuell/Typst-Dateien/main.typ`, genau ein aktuelles Skript je Modul; der Titel kommt aus `#set document(title: …)`.
