# Lernskript-Webseite

Dieser Ordner (`Uni/Webseite/`) ist die Quelle der Webseite https://mariogotz04.github.io/studium/.
Sie listet alle Module, bietet jedes Lernskript als PDF an und hat einen zweiten Reiter **Karteikarten**
zum Üben der Verständnisfragen jedes Moduls. Die PDFs werden auf GitHub aus den
`.typ`-Dateien kompiliert; hier liegt nur die Seite selbst.

## Nach jeder Änderung an einem Lernskript hochladen

Wenn du eine `.typ`-Datei (oder ein Bild in `abbildungen/`) oder die `Karteikarten.md` eines Moduls geändert hast, lade sie danach hoch:

```bash
bash "<Pfad zum Uni-Ordner>/Webseite/Webseite aktualisieren.command"
```

Das Skript kopiert alle aktuellen Skripte in die Git-Kopie `~/Studium-Webseite`, committet und pusht.
GitHub baut die PDFs danach in 1–3 Minuten. Es braucht Netzwerkzugriff (git push zu github.com).
Melde dem Nutzer das Ergebnis (✅-Zeile oder Fehlermeldung).

Vorher prüfen, dass das Skript fehlerfrei kompiliert, falls `typst` installiert ist:
`typst compile "<Modul>/Lernskript aktuell/Typst-Dateien/main.typ"`. Auf GitHub läuft Typst 0.15.1.

## Was hochgeladen wird

- Pro Modul **nur das aktuelle Lernskript**: `<Modul>/Lernskript aktuell/Typst-Dateien/main.typ` mit seinen Bildern.
  Online steht also immer genau eine PDF je Modul, mit dem neuesten Stand; jeder Upload ersetzt die alte.
  Alte Stände, Sicherungen oder Kopien (auch in anderen Ordnern) werden nie hochgeladen.
  Die Seite zeigt je Modul: Modulname (Ordnername) · Lernskript · Stand. Der Stand kommt aus der Zeile
  „Stand TT.MM.JJJJ“ im Kopf von `main.typ`; diese also bei jeder Änderung aktualisieren.
  Die PDF heißt beim Download z. B. `FET Lernskript Stand 24.10.2026.pdf`.
- Pro Modul außerdem `<Modul>/Lernskript aktuell/Karteikarten.md`, falls vorhanden (Format: Kommentar oben in der Datei).
- Nie hochgeladen werden: `Zum Löschen/`, `Unterlagen/`, `Sonstiges/`, `Physik Praktikum/` und dieser Ordner.
- Ein neues Modul erscheint automatisch, sobald es `Lernskript aktuell/Typst-Dateien/main.typ` hat.

## Dateien hier

- `vorlage.html` – Aussehen der Seite (die Daten werden bei `/*DATA*/null` eingesetzt, die Karteikarten bei `/*KARTEN*/null`).
- `build.py` – kompiliert die Skripte und baut die Seite (läuft auf GitHub).
- Die GitHub Action (`.github/workflows/webseite.yml`) liegt nur im Repository auf GitHub, nicht hier.
- `Webseite aktualisieren.command` – Upload (Doppelklick oder `bash`).

Änderungen an diesen Dateien werden ebenfalls mit dem Upload-Skript veröffentlicht.
## Karteikarten

- Quelle: je Modul `Lernskript aktuell/Karteikarten.md`. `## …` beginnt ein Kapitel, `### Frage` eine Karte,
  alles darunter ist die Rückseite. Eine Zeile `Bild: …` wird als Merkbild (Analogie) angezeigt.
- Jede Karte bekommt eine Zeile `Quelle: 1.3` (Abschnittsnummer im Lernskript, bei TM2 z. B. `Quelle: TM2 1.6`).
  `build.py` sucht den Abschnitt in den PDF-Lesezeichen und zeigt auf der Karte einen Link „Lernskript S. N“.
  Die Seite stimmt so auch, wenn das Lernskript wächst. Wird der Abschnitt nicht gefunden, warnt der Build.
- Gibt es im Lernskript eine passende Abbildung, `Abbildung: name` (oder `name1, name2`) ergänzen; `name` ist die
  Datei `Typst-Dateien/abbildungen/<name>.svg`. Die Bildunterschrift wird aus `#bild("name", [...])` übernommen.
- Formeln in den Antworten in Typst-Schreibweise zwischen `$…$` schreiben (z. B. `$c = sqrt(2 g h)$`), eine Zeile nur
  mit `$ … $` wird abgesetzt. `build.py` setzt sie mit Typst als SVG (Ordner `f/`), sie sehen aus wie im Lernskript.
  Den Fragetext dafür nicht ändern (Lernstand hängt daran), Formeln gehören in die Antwort.
- Startseite der Karteikarten: „fällige lernen“ mischt fällige Karten aller Module (reihum, höchstens die eingestellte
  Anzahl pro Runde). Auf der Modulseite gibt es „Nur fällige“ ohne neue Karten.
  Die Karteikarten sind für das iPad und Bedienung mit dem Finger gemacht (keine Tastatur).
- `build.py` liest die Dateien ein; jede Karte bekommt eine ID aus Modul und Fragetext. Den Fragetext deshalb
  nur ändern, wenn nötig, sonst beginnt die Karte wieder als neu.
- Wiederholung wie bei Anki (SM-2): Bewertung Nochmal/Schwer/Gut/Leicht, Abstände wachsen mit der Leichtigkeit,
  jede Runde wird gemischt. Der Lernstand liegt im Browser (localStorage) des jeweiligen Geräts und lässt sich auf
  der Seite eines Moduls als Datei sichern und auf einem anderen Gerät laden.

Nicht direkt in `~/Studium-Webseite` arbeiten: Das Skript überschreibt dort alles mit dem Stand aus dem Uni-Ordner.
