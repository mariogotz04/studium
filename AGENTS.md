# Lernskript-Webseite

Dieser Ordner (`Uni/Webseite/`) ist die Quelle der Webseite https://mariogotz04.github.io/studium/.
Sie listet alle Module und bietet jedes Lernskript als PDF an. Die PDFs werden auf GitHub aus den
`.typ`-Dateien kompiliert; hier liegt nur die Seite selbst.

## Nach jeder Änderung an einem Lernskript hochladen

Wenn du eine `.typ`-Datei (oder ein Bild in `abbildungen/`) eines Moduls geändert hast, lade sie danach hoch:

```bash
bash "<Pfad zum Uni-Ordner>/Webseite/Webseite aktualisieren.command"
```

Das Skript kopiert alle aktuellen Skripte in die Git-Kopie `~/Studium-Webseite`, committet und pusht.
GitHub baut die PDFs danach in 1–3 Minuten. Es braucht Netzwerkzugriff (git push zu github.com).
Melde dem Nutzer das Ergebnis (✅-Zeile oder Fehlermeldung).

Vorher prüfen, dass das Skript fehlerfrei kompiliert, falls `typst` installiert ist:
`typst compile "<Modul>/Lernskript aktuell/Typst/main.typ"`. Auf GitHub läuft Typst 0.15.1.

## Was hochgeladen wird

- Jeder Ordner mit `.typ`-Dateien im Uni-Ordner. Pro Ordner wird `main.typ` kompiliert; gibt es keine,
  wird jede `.typ`-Datei einzeln kompiliert. Der Titel auf der Seite kommt aus `#set document(title: "…")`.
- Nie hochgeladen werden: `Zum Löschen/`, `Unterlagen/`, `Sonstiges/`, `Physik Praktikum/` und dieser Ordner.
- Ein neues Modul erscheint automatisch, sobald es einen solchen Ordner hat.

## Dateien hier

- `vorlage.html` – Aussehen der Seite (die Daten werden bei `/*DATA*/null` eingesetzt).
- `build.py` – kompiliert die Skripte und baut die Seite (läuft auf GitHub).
- `.github/workflows/webseite.yml` – GitHub Action für Build und Veröffentlichung.
- `Webseite aktualisieren.command` – Upload (Doppelklick oder `bash`).

Änderungen an diesen Dateien werden ebenfalls mit dem Upload-Skript veröffentlicht.
Nicht direkt in `~/Studium-Webseite` arbeiten: Das Skript überschreibt dort alles mit dem Stand aus dem Uni-Ordner.
