# Meine Lernskripte

Webseite mit allen Lernskripten aus dem Studium. Die Typst-Dateien unter `skripte/` werden bei jedem Push
von einer GitHub Action zu PDFs kompiliert und auf GitHub Pages veröffentlicht.

- **Aktualisieren:** Doppelklick auf `Webseite aktualisieren.command` im Uni-Ordner.
- **Lokal bauen:** `python3 build.py` (braucht `typst`), Ergebnis in `_site/`.
- **Aufbau:** `skripte/<Modul>/…/main.typ`; der Titel kommt aus `#set document(title: …)`.
