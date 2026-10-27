# Lernskript-Webseite

Dieser Ordner (`Uni/Webseite/`) ist die Quelle der Webseite https://mariogotz04.github.io/studium/.
Sie ist Marios Lernplattform mit vier Reitern:

- **Start:** Uhr, heutiger und morgiger Vorlesungsplan, „Heute dran“ (täglich wechselnde Lernvorschläge aus Plan,
  Klausurterminen und Lernstand), Countdown zur nächsten Klausur, Fristen, To-dos.
- **Lernskripte:** jedes Lernskript als PDF sowie eine Feynman-Hörzusammenfassung als EPUB; Leseansicht mit aufdeckbaren Denkpausen. Die PDF enthält weiterhin nur Zusammenfassung und Formelsammlung.
- **Lernen:** Rechenaufgaben und Verständnisfragen mit Lösung Schritt für Schritt, ein Quiz je Modul, Pomodoro-Timer,
  Karteikarten je Modul als Auswahl neben Aufgaben, Quiz und Probeklausur (Wiederholung wie bei Anki),
  je Modul eine Probeklausur (Aufgaben aus verschiedenen Kapiteln, gemischt, ohne Titel, mit Uhr, Standard 80 % der
  Klausurdauer) und eine Mix-Serie (5 Aufgaben aus 5 Kapiteln, ohne Uhr). Die Zeit je Aufgabe kommt aus dem optionalen
  Feld `minuten:` in `Aufgaben.typ`, sonst wird sie nach der Zahl der Lösungsschritte geschätzt.
- **Klausurtyp je Modul** (Transfer / Gemischt / Abfrage, plus Dauer): einstellbar beim Eintragen einer Klausur und in der
  Probeklausur. Standard: Finanzierung und Investitionsrechnung gemischt, alle anderen Transfer. Er gewichtet „Heute dran“
  (Transfer: mehr Rechnen und Probeklausuren, Abfrage: mehr Quiz und Karteikarten). „Heute dran“ enthält immer mindestens
  zwei Module. Ab 17 Uhr erscheint auf der Startseite der Tagesabschluss (frei aufschreiben, dann 5 Quizfragen aus den
  heutigen Modulen).
- **Termine:** Fristen und Klausuren mit Countdown, To-dos, Wochenplan.

Die PDFs und die Aufgaben werden auf GitHub aus den `.typ`-Dateien gesetzt; hier liegt nur die Seite selbst.

## Nach jeder Änderung an einem Lernskript hochladen

Wenn du eine `.typ`-Datei (auch `Aufgaben.typ`), ein Bild in `abbildungen/`, die `Karteikarten.md`, `Quiz.md` oder `Hoerskript.md` eines Moduls
oder den Vorlesungsplan geändert hast, lade sie danach hoch:

```bash
bash "<Pfad zum Uni-Ordner>/Webseite/Webseite aktualisieren.command"
```

Das Skript kopiert alle aktuellen Skripte in die Git-Kopie `~/Studium-Webseite`, committet und pusht.
GitHub baut die PDFs danach in 1–3 Minuten. Es braucht Netzwerkzugriff (git push zu github.com).
Melde dem Nutzer das Ergebnis (✅-Zeile oder Fehlermeldung).

Vorher prüfen, dass Skript und Aufgaben fehlerfrei kompilieren, falls `typst` installiert ist:
`typst compile "<Modul>/Lernskript aktuell/Typst-Dateien/main.typ"` und dasselbe mit `Aufgaben.typ`
(ergibt eine PDF mit allen Aufgaben und Lösungen). Auf GitHub läuft Typst 0.15.1.

## Was hochgeladen wird

- Pro Modul **nur das aktuelle Lernskript**: `<Modul>/Lernskript aktuell/Typst-Dateien/main.typ` mit seinen Bildern.
  Online steht also immer genau eine PDF je Modul, mit dem neuesten Stand; jeder Upload ersetzt die alte.
  Alte Stände, Sicherungen oder Kopien (auch in anderen Ordnern) werden nie hochgeladen.
  Die Seite zeigt je Modul: Modulname (Ordnername) · Lernskript · Stand. Der Stand kommt aus der Zeile
  „Stand TT.MM.JJJJ“ im Kopf von `main.typ`; diese also bei jeder Änderung aktualisieren.
  Die PDF heißt beim Download z. B. `FET Lernskript Stand 24.10.2026.pdf`.
- Pro Modul außerdem `Typst-Dateien/Aufgaben.typ` (Aufgaben, Format im Kopf der Datei), `Lernskript aktuell/Karteikarten.md`
  und `Lernskript aktuell/Quiz.md`, falls vorhanden (Format jeweils als Kommentar oben in der Datei). Dazu `Lernskript aktuell/Hoerskript.md` als Quelle der EPUB-Hörfassung.
- `Vorlesungsplan.pdf` aus diesem Ordner (siehe unten).
- Nie hochgeladen werden: `Zum Löschen/`, `Unterlagen/`, `Sonstiges/`, `Physik Praktikum/` und dieser Ordner.
- Ein neues Modul erscheint automatisch, sobald es `Lernskript aktuell/Typst-Dateien/main.typ` hat.

## Dateien hier

- `vorlage.html` – Aussehen und Verhalten der Seite (eingesetzt werden die Skripte bei `/*DATA*/null`, die Karteikarten bei
  `/*KARTEN*/null`, Aufgaben und Quiz bei `/*LERNEN*/null`, der Vorlesungsplan bei `/*PLAN*/null`).
- `Vorlesungsplan.pdf` – aktueller Stundenplan als PDF-Export aus thabella (Mario legt ihn hier ab).
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
- Karteikarten liegen unter **Lernen → Modul → Karteikarten**, neben Aufgaben, Quiz und Probeklausur.
  Jede Runde bleibt in einem Modul. Es gibt keinen separaten Karteikarten-Reiter und keine Kartenrunde über alle Module.
  Auf der Modulseite gibt es „Nur fällige“ ohne neue Karten; „Heute dran“ verlinkt fällige Karten je Modul.
  Modulwechsel im Lerntag übernimmt die bestehende Interleaving-Auswahl von „Heute dran“.
  Alte Adressen `#karteikarten/<Modul>` werden zu `#lernen/<Modul>/karteikarten` weitergeleitet, `#karteikarten` zu `#lernen`.
  Die Karteikarten sind für das iPad und Bedienung mit dem Finger gemacht (keine Tastatur).
- `build.py` liest die Dateien ein; jede Karte bekommt eine ID aus Modul und Fragetext. Den Fragetext deshalb
  nur ändern, wenn nötig, sonst beginnt die Karte wieder als neu.
- Wiederholung wie bei Anki (SM-2): Bewertung Nochmal/Schwer/Gut/Leicht, Abstände wachsen mit der Leichtigkeit,
  jede Runde wird gemischt. Der Lernstand wird synchronisiert (siehe unten) und lässt sich zusätzlich auf
  der Seite eines Moduls als Datei sichern und laden.

Nicht direkt in `~/Studium-Webseite` arbeiten: Das Skript überschreibt dort alles mit dem Stand aus dem Uni-Ordner.

## Lernen: Aufgaben

- Quelle: je Modul `Lernskript aktuell/Typst-Dateien/Aufgaben.typ`, direkt neben `main.typ` (sie importiert dessen
  Befehle wie `#bild`, `#tab`, `#note`). Aufbau und Regeln stehen im Kopf der Datei; den Kopf nicht ändern.
- Jede Aufgabe ist `#aufgabe(titel: …, art: "rechnen" | "verstehen", quelle: "1.5", ergebnis: […], tipp: […])[Aufgabe][Schritt 1][Schritt 2]…`.
  Auf der Webseite deckt Mario jeden Schritt einzeln auf; deshalb jeden Schritt für sich verständlich schreiben:
  fette Kurzüberschrift, dann *warum* man so vorgeht (Feynman-Stil, Alltagsbild wo es hilft), dann die Rechnung,
  am Ende eine Prüfung (Einheit, Größenordnung, Grenzfall).
- `build.py` setzt jede Aufgabe, jeden Tipp, jedes Ergebnis und jeden Schritt als eigenes SVG (`_site/a/`) und
  erzeugt zusätzlich eine PDF mit allen Lösungen. Außerhalb von `#aufgabe` und `#kapitel` darf nichts stehen,
  sonst stimmt die Zuordnung nicht (der Build meldet dann „Aufgaben fehlerhaft“).
- Ob eine Aufgabe gelöst ist, hängt am Titel. Titel deshalb nicht ohne Grund ändern.

## Lernen: Quiz

- Quelle: je Modul `Lernskript aktuell/Quiz.md`. Format steht oben in der Datei: Einfach- und Mehrfachauswahl mit
  einer Erklärung zu *jeder* Antwort, Lückentext und Freitext (Musterantwort). Wie bei NotebookLM.
- Gute Quizfragen prüfen Verständnis und typische Denkfehler; die falschen Antworten sollen plausibel sein
  und ihre Erklärung sagt, wo genau der Denkfehler liegt.

## Alle Lernformate wachsen mit den Vorlesungsunterlagen

- Nach jeder Einarbeitung neuer Vorlesungsunterlagen das Lernskript **und** `Aufgaben.typ` (Rechenaufgaben und
  Verständnisfragen samt Ergebnis, Tipp und Lösungsschritten), `Quiz.md` (richtige Antworten, Musterantworten und
  Erklärungen jeder Option) sowie `Karteikarten.md` (Rückseiten, Quellen, Abbildungen) und `Hoerskript.md` (hörgerechte Erklärungen und Denkpausen mit Auflösung) gemeinsam abgleichen.
- Zu neu behandeltem Stoff passende Aufgaben, Quizfragen und Karten ergänzen; fehlende Dateien im vorgesehenen
  Format anlegen. Vorhandene Antworten nur ändern, wenn sie falsch, unvollständig oder durch die Unterlagen überholt sind.
  Eine reine Layout- oder Übersichtsänderung erfordert keine neuen fachlichen Antworten.
- Titel und Fragetexte möglichst unverändert lassen, damit der Lernstand erhalten bleibt. Abschnittsverweise nach
  jeder Skriptänderung prüfen; Seitenzahlen werden beim Build aus der aktuellen PDF neu bestimmt.
- Alle Formate zusammen prüfen und mit dem Upload-Skript veröffentlichen. Das ist redaktionelle Pflege durch die KI
  bei der Bearbeitung der Unterlagen; der Webseiten-Build selbst erzeugt keine neuen Fragen.

## Hörzusammenfassungen als EPUB

- Je Modul `Lernskript aktuell/Hoerskript.md` redaktionell pflegen; Format und Regeln in Modul-AGENTS.md, Abschnitt 8.9. Bei neuen Unterlagen zusammen mit den übrigen Lernformaten erweitern, keine bloße PDF-Textextraktion.
- `build.py` erzeugt daraus genau **ein Downloadformat: EPUB 3**, unter `_site/epub/`. Dazu dieselben Inhalte als Leseansicht unter Lernskripte, in der Denkpausen eine aufdeckbare Auflösung haben. Keine TXT-Alternative.
- Kopf mit `Stand:` und `Skriptstand:`; ein Modulüberblick und alle vorhandenen Skriptkapitel in gleicher Reihenfolge. Je Kapitel gültige `Quelle:`-Abschnitte und mindestens ein `### Denkpause`/`### Auflösung`-Paar. Der Build weist fehlende Kapitel, ungültige Quellen, unvollständige Paare und einen nicht abgeglichenen Skriptstand zurück.
- Hörtext in einfachen gesprochenen Sätzen, Formeln in Worten, Abkürzungen erklären. EPUB ohne JavaScript, fremde Medien oder festes Seitenlayout, mit deutscher Sprachkennung und Kapitelnavigation. ElevenReader kann die Denkpausen nicht automatisch als echte Wartezeit ausführen: Mario hält selbst an; danach folgt die Auflösung. Bei einem neuen Stand erneut importieren.
- EPUB-Downloads haben ihren eigenen MIME-Typ `application/epub+zip`; die Home-Bildschirm-App kann Dateien über das Teilen-Menü sichern/übergeben. EPUBs nicht mit dem PDF-Viewer öffnen.

## Vorlesungsplan

- `Vorlesungsplan.pdf` in diesem Ordner ist der PDF-Export des Stundenplans aus thabella (WIW-3A). Bei Änderungen
  oder einem neuen Semester einfach die Datei ersetzen und hochladen.
- `build.py` liest die farbigen Kästchen (Tag, Uhrzeit, Fach, Dozent, Raum, Art laut Legende) und die Hinweise im
  Tageskopf (Feiertage, vorlesungsfrei). Welches Fach zu welchem Modul gehört, steht in `PLAN_MODULE` in `build.py`;
  bei einem neuen Fach dort eine Zeile ergänzen. Als „Prüfung“ markierte Termine erscheinen automatisch als Frist.

## Synchronisation

- Lernstand, Fristen, To-dos und Einstellungen liegen im Browser und werden über Supabase (Projekt „studium“,
  Tabelle `zustand`, eine Zeile je Eintrag, neuere Änderung gewinnt) zwischen Marios Geräten abgeglichen.
  Anmeldung per E-Mail-Link unter „Sync“ oben rechts. Nichts davon steht im Repository.
