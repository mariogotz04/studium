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
- **Lernreihe (Mario, 06.11.2026):** Jedes Modul wird Abschnitt für Abschnitt der Reihe nach gelernt (`lernreihe()` in
  vorlage.html). `Quelle:`/`quelle:` gliedert ein Kapitel in Abschnitte wie 1.1, 1.2 und 1.10; Unterabschnitte wie 1.1.2 gehören zu 1.1.
  Ein Abschnitt ist abgeschlossen, wenn alle Aufgaben selbst gelöst (grün), alle Quizfragen richtig
  und alle Karteikarten einmal gelernt sind. Die vollständig bearbeitete Folge ab Modulbeginn wird privat unter `lernpfad:<Modul>:<Kapitel>:<Abschnitt>` synchronisiert.
  Wiederholungsfehler setzen einen erreichten Abschluss nicht zurück. „Heute dran“, alle Kartenstarts (auch fällige Wiederholungen und freies Üben),
  Quiz einschließlich Tagesabschluss, Aufgaben, Mix-Serie und Probeklausur nehmen nur den aktuellen bzw. schon erreichten Abschnitt.
  Früher angeklickter späterer Stoff wartet unter Erhalt seiner Bewertungen und Termine. Gespeicherte IDs und Tagespläne werden erneut geprüft;
  gültige Ziele und bereits fertige Tageszeilen bleiben erhalten. Die Modulseite zeigt den aktuellen Abschnitt, offene Inhalte und einen Weiter-Button samt Skriptverweis.
  Eine nicht selbst gelöste Aufgabe bleibt dran. Das Kapitel kommt aus der Überschrift (`#kapitel`, `## `),
  bei Sammelüberschriften („Kapitel 7–12“, „TM1 · Statik“) aus `Quelle:`/`quelle:`. Darum Kapitelüberschriften immer
  mit „Kapitel N“ benennen und jede Aufgabe, Quizfrage und Karte mit Quelle versehen.

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
- `pruefungen.json` – Prüfungsanmeldung (Termine, Uhrzeit, Dauer, angemeldet ja/nein) und Notenblatt; eingesetzt bei `/*PRUEFUNGEN*/null`.
- `Vorlesungsplan.pdf` – aktueller Stundenplan als PDF-Export aus thabella (Mario legt ihn hier ab).
- `build.py` – kompiliert die Skripte und baut die Seite (läuft auf GitHub).
- `.github/workflows/webseite.yml` – Build/Veröffentlichung und wöchentliche Ergänzung der Zitatdatenbank; diese lokale Quelle wird mit hochgeladen.
- `Webseite aktualisieren.command` – Upload (Doppelklick oder `bash`).

Änderungen an diesen Dateien werden ebenfalls mit dem Upload-Skript veröffentlicht.
## Karteikarten

- **Kartenstil in allen Modulen (Mario, 06.11.2026):** Antworten grundsätzlich als kurze Stichpunkte (meist 2–5, ein Gedanke je Punkt), einfache Formulierungen und sparsame fette Schlüsselbegriffe. Vergleiche parallel und Abläufe als Schrittfolgen. Gilt auch für neue Vorlesungsinhalte und jede Erweiterung einer Rückseite.
- **Entfernter Fragetyp (Mario, 06.11.2026):** Keine „Zeichne die Begriffslandkarte …“-Fragen mehr anbieten, auch nicht in neuen Modulen. `build.py` filtert diesen Typ zentral aus älteren und künftigen Kartenquellen, bevor IDs, Lernpfad und Tagesvorschläge auf der Seite verwendet werden. Die übrigen Karten-IDs und gespeicherten Bewertungen bleiben erhalten. Diese Vorgabe ersetzt frühere Regeln zur Aufnahme solcher Karten.
- Bei typischen Verwechslungen gezielt eine eigene Zeile `**Merksatz:** …` ergänzen; `build.py` stellt sie als eigenen hervorgehobenen Absatz dar. Passende sprachliche Alltagsanalogien über `Bild: …` als separates Merkbild anzeigen, vorhandene Fachabbildungen nutzen. Keine beliebigen Bilder erzwingen. Eigene Lernhilfen im Dateikommentar kennzeichnen; Analogien ersetzen keine Fachquelle oder Gültigkeitsbedingung.
- Bei der Kürzung Formeln, Vorzeichen, Einheiten, Annahmen und Einschränkungen erhalten. Fragen, Kapitel und Quellen möglichst unverändert lassen, damit IDs und Lernstand bestehen bleiben. Nach Pflege die Trennung von Liste, Merksatz und Merkbild, Quellenlinks und iPad-Darstellung prüfen. Die verbindliche redaktionelle Regel steht zusätzlich in Abschnitt 8.5 aller Modul-AGENTS.md.
- Quelle: je Modul `Lernskript aktuell/Karteikarten.md`. `## …` beginnt ein Kapitel, `### Frage` eine Karte,
  alles darunter ist die Rückseite. Eine Zeile `Bild: …` wird als Merkbild (Analogie) angezeigt.
- Jede Karte bekommt eine Zeile `Quelle: 1.3` (Abschnittsnummer im Lernskript, bei TM2 z. B. `Quelle: TM2 1.6`).
  `build.py` sucht den Abschnitt in den PDF-Lesezeichen und zeigt auf der Karte einen Link „Lernskript S. N“.
  Die Seite stimmt so auch, wenn das Lernskript wächst. Wird der Abschnitt nicht gefunden, warnt der Build.
- Alle Quellenlinks bei Karteikarten, Rechenaufgaben, Verständnisfragen und Quizantworten (auch in der
  Auswertung von Quiz, Probeklausur und Mix-Serie) öffnen die integrierte PDF-Ansicht im Browser und in der
  Home-Bildschirm-App. `build.py` ordnet anhand von Frage und Antwort bzw. Lösungsweg eine Textstelle innerhalb
  des angegebenen Abschnitts zu und speichert relative Zeilenrechtecke im jeweiligen Quellenfeld `h`.
  Die Seitenangabe zeigt auf die gefundene Stelle. Bei jedem Build werden die Positionen aus der aktuellen PDF
  neu bestimmt. Nur die Markierungen des angeklickten Verweises werden gelb eingeblendet und beim Schließen
  oder Navigieren entfernt; die herunterladbare PDF bleibt unverändert. Eine Zuordnung ohne Texttreffer öffnet
  den Abschnitt ohne Markierung. Keine dauerhaft eingefärbten PDFs erzeugen und keine Markierungen im Lernstand speichern.
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
  fällige Karten kommen zuerst, neue Karten in numerischer Abschnittsreihenfolge. Freies Üben mischt ausschließlich erreichten Stoff.
  Der Lernstand wird synchronisiert (siehe unten) und lässt sich zusätzlich auf
  der Seite eines Moduls als Datei sichern und laden.
- Im Antwortfeld darf Scrollen oder Wischen keine Karte bewerten und keinen Kartenwechsel auslösen.
  Bewertungen erfolgen bewusst über die Bewertungsbuttons oder die vorhandenen Tastaturkürzel 1–4.
  Keine automatische Bewertung durch Touch- oder Wischgesten einbauen; das gilt auch beim freien Üben.

## Flüchtiges Notizblatt und zuverlässige Quellen

- Karteikarten, Verständnisfragen und Quiz bieten ein zunächst eingeklapptes weißes Notizblatt rechts neben der Frage. Unter 800 px steht es über dem Inhalt. Ausschließlich Stifteingaben (`pointerType === "pen"`, insbesondere Apple Pencil) erzeugen Striche; Finger und Handballen niemals. Radierer, Rückgängig und Leeren bleiben verfügbar. Rechenaufgaben erhalten kein Blatt.
- Die Fläche ist in Weltkoordinaten unbegrenzt verschiebbar; zwei Finger verschieben und zoomen den Ausschnitt (20–500 %). Einzelne Finger bewegen das Blatt nicht. Während des Schreibens und bis zum Abheben aufliegender Kontakte sind Fingergesten gesperrt. Kontextmenü, Textauswahl und iOS-Touch-Callout im Notizblatt unterbinden. „Kleiner/Größer“ ändern die Ansichtsgröße ohne Striche zu verzerren; Zoomknöpfe und „Zum Anfang“ ergänzen die Gesten. Jede neue Frage startet wieder eingeklappt.
- Striche liegen ausschließlich im Arbeitsspeicher. Beim Aufdecken einer Antwort, eines Tipps oder Lösungsschritts, bei Quizauswahl, Ein-/Ausklappen und Größenwechsel erhalten; beim Bewerten einer Karte/Aufgabe, Fragenwechsel, Rundenende oder Verlassen der Übung verwerfen. Niemals Browser-Speicher, Export oder Sync für Notizen verwenden.
- Allgemeine Quellenmarkierungen erfordern mehrere passende Antwortbegriffe und ausreichende Textabdeckung. Bei unsicherem Treffer nur den Abschnitt öffnen und dies im Viewer anzeigen. Die Zuordnung alter Begriffslandkarten zur Kapitelübersicht bleibt intern abwärtskompatibel; dieser Fragetyp wird nicht mehr veröffentlicht.
- `node test_notizen.cjs` prüft Zeichnen und Lebensdauer; `python3 -m unittest test_quellen.py` prüft falsche Worttreffer und nach dem Build das echte Konstruktionsbeispiel. Beide laufen in CI.

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

## Prüfungen und Noten

- `pruefungen.json` hält die Prüfungsanmeldung aus dem Prüfungsportal und das Notenblatt der THD. Gibt Mario eine neue
  Prüfungsanmeldung, ein neues Notenblatt oder Screenshots davon, diese Datei aktualisieren und hochladen.
- `pruefungen[]`: `titel` (wie im Portal), `module` (Modulnamen der Webseite, z. B. `["Investitionsrechnung", "Finanzierung"]`
  für Investition und Finanzierung; leer, wenn es kein Modul auf der Seite gibt), `angemeldet`, `datum` (JJJJ-MM-TT),
  `zeit`, `dauer` (Minuten), `pruefer`, `nummer` (Anmeldenummer), `ects`, optional `versuch` und `hinweis`.
  Praktikum Physik bleibt draußen (wie auf der ganzen Seite).
- Angemeldete Prüfungen erscheinen automatisch als Klausur-Frist mit Countdown, steuern die Tagesvorschläge und stehen
  auf den Lernskript-Karten und im Kopf der Lernen-Seite. Eigene Klausur-Fristen am selben Tag zum selben Modul werden ausgeblendet.
- `noten`: `stand`, `schnitt` und `ects` wie auf dem Notenblatt, `faecher[]` mit `fach`, `note` (Zahl oder „bestanden“),
  `semester`, `ects`, optional `hinweis`. Angezeigt im Reiter Termine unter „Prüfungen & Noten“.

## Synchronisation

- Lernstand, Fristen, To-dos und Einstellungen liegen im Browser und werden über Supabase (Projekt „studium“,
  Tabelle `zustand`, eine Zeile je Eintrag, neuere Änderung gewinnt) zwischen Marios Geräten abgeglichen.
  Anmeldung per E-Mail-Link unter „Sync“ oben rechts. Nichts davon steht im Repository.

## Automatischer Lernplan (freigegeben am 06.11.2026)

- Unter **Termine → Lernplan** (`#termine/lernplan`): erst ein veränderbares Beispielbudget, anschließend Vorschau und bewusstes Übernehmen. Kein persönlicher Plan ohne übernommene Einstellungen. Gemeinsame Klausuren erhalten eine gemeinsame Gruppe; freie Tage, Vorlesungen, Schwerpunkt, Lern-/Pausenzeiten und 20 % Puffer berücksichtigen. Ungedeckte Einheiten und verkürzte Wiederholungsphasen sichtbar ausweisen, keine stille Überbuchung.
- `lernplan.js` enthält die reine Plan-/Statuslogik, `lernplan-ui.js` den Adapter zur bestehenden Lernplattform und `lernplan-pdf.js` die lokale PDF-Erzeugung. `vendor/` enthält fest versionierte Bibliotheken, eine einbettbare Schrift und Lizenzen. Build und Upload müssen alle Dateien mitnehmen; Asset-Inhalte bestimmen die Version in den Script-Adressen.
- Private Daten ausschließlich im bestehenden DB-/Sync-Zustand: `einst:lernplan` verweist auf `lernplan:version:<ID>`. Planpunkte behalten stabile Ziel-IDs. Zwei neueste Versionen erhalten; historische erledigte Einheiten und der aktuelle Tag werden bei Neuplanung übernommen. Pro Einheit getrennte `lernplan:manuell:<ID>` und monotone `lernplan:abschluss:<ID>`; Verschiebungen unter `lernplan:datum:<Version>:<ID>`, tägliche fällige Ergänzungen unter `lernplan:extra:<Version>:<ID>`, Tageswechsel unter `lernplan:tag:<Version>`. Niemals private Pläne im Build erzeugen oder veröffentlichen.
- „Heute dran“ übernimmt bei aktivem Plan dieselben Tagesziele. Aufgabenhaken erst nach „selbst gelöst“, Quiz/Karten gemäß vorhandenen Bewertungen; Wiederholungsrunden erst nach tatsächlichem Abschluss in ihrer Wiederholungsphase. Manuell bedeutet eigene Bearbeitung und setzt keinen Lernpfadabschluss. Aufgaben aus jedem Einstieg zählen. Erreichte Einheiten bleiben abgeschlossen; neue Inhalte werden als offen eingeplant. Die bestehende Abschnittsfreigabe niemals umgehen.
- Beim Tageswechsel nicht erledigte Einheiten automatisch neu verteilen, bei Bedarf auch offene Folgetage verschieben. Tagesbudget einschließlich Pausen, freie Tage, Abschnittsreihenfolge und Klausurgrenzen einhalten. Fertige Einheiten an ihrem bisherigen Datum erhalten. Reicht die Zeit nicht, das Ziel ausdrücklich ohne Termin führen und den verbleibenden Bedarf zeigen. Neue Ziele nicht stillschweigend überspringen.
- Die automatische Nachplanung läuft beim Öffnen von Start/Lernplan, beim Aktivieren der App und während einer geöffneten Ansicht spätestens innerhalb von 30 Sekunden nach Tageswechsel. Laufende Übungen und Formulare erhalten; beim Zurückkehren auf Start/Lernplan nachholen. Bei geschlossener App erfolgt die Prüfung beim nächsten Öffnen. Innerhalb desselben Tages bleibt die Auswahl stabil.
- `lernplan:automatik:<Version>` speichert ab Schema 2 die vollständige automatische Terminverteilung als einen zusammenhängenden Sync-Eintrag (`day`, `dates`, `note`). Ein explizites `null` in `dates` bedeutet ohne Termin und darf nicht auf das alte Datum zurückfallen. Alte `lernplan:datum:<Version>:<ID>`-Werte beim ersten Lauf übernehmen. Neu fällige, freigegebene Karten nur im verbleibenden Budget ergänzen. Termin-/Quellenänderungen benötigen weiterhin eine bewusste Vorschau und Übernahme.
- Gesamt-/Wochen-PDF mit eingebetteter Schrift, Checkboxen, Kapitelstand, Zeitstempel/Version und klickbaren Ziel-/Skriptlinks aus dem aktuellen privaten Plan erzeugen. Quellen aus dem aktuellen Katalog nehmen. Vorhandene Downloads bleiben Momentaufnahmen. Im Viewer bei verändertem Fortschritt Aktualisierung anbieten, das gelesene Dokument nicht automatisch schließen oder ersetzen. Alte Ziel-Links verständlich ins Modul führen.
- `node test_lernplan.cjs` läuft auch in CI und prüft Kapazität, Reihenfolge, Gruppen, Status, Historie, Wiederholungen und Nachholen. PDF-Layout und Interaktion zusätzlich im Browser mit isolierten Testdaten prüfen.

## Motivation und persönliche Richtung

- Start zeigt „Mein Warum“ mit dem nächsten offenen Tagesziel und kleinem Einstieg. `#richtung` öffnet den Editor für Warum, Vision, Identitätssatz, Anti-Vision und Wenn-dann-Plan. Alles ist freiwillig und abschaltbar; Anti-Vision bleibt eingeklappt.
- Private Eingaben und Zitatfavoriten nur unter `einst:richtung` im bestehenden Browser-/Supabase-Zustand speichern, niemals in Git oder Modulquellen. Tagesreflexionen gehören zu `abschluss:<Tag>`.
- `zitate.json` enthält die gemeinsame Zitatdatenbank. Werk, HTTPS-Quelle und ggf. Übersetzung/Original bleiben interne Belege. Auf der Oberfläche ausdrücklich nur Zitat und Name anzeigen: keine Quellenlinks, Werkangaben oder aufklappbaren Originalfassungen. Favoriten und Ausblenden erhalten; die Sammlung ist durchsuchbar und lädt weitere Einträge portionsweise.
- `tagesZitat` speichert die Tagesauswahl unter `zitat:tag:<Datum>` im privaten Sync-Zustand. Gleiches Zitat am selben Tag; zuerst alle unbenutzten Einträge verwenden, danach den am längsten nicht gezeigten. Neue Einträge vor Wiederholungen berücksichtigen und, soweit möglich, die Person wechseln. Favoritenfilter bleibt optional; bei leerem Filter auf die Sammlung zurückfallen.
- `zitate_aktualisieren.py` liest regelmäßig ausschließlich die Quellenabschnitte einer festgelegten Liste deutschsprachiger, gemeinfreier Autoren bei Wikiquote. Nur vollständige, thematisch passende Zitate mit Werkangabe übernehmen, keine bloßen/zweifelhaften Zuschreibungen, Fremdzitate über die Person oder erkennbare Übersetzungen ohne Originalbeleg. Texte niemals generieren oder frei ergänzen. Doppelte und sehr ähnliche Fassungen vermeiden; redaktionelle Ausschlüsse stehen dauerhaft in `zitate_filter.json`.
- `.github/workflows/webseite.yml` ergänzt sonntags um 05:23 UTC sowie bei manuellem Workflowstart bis zu zehn passende neue Internetfundstellen, baut die Seite und erhält neue Einträge in der öffentlichen Pages-Datei `zitate.json`. Der Quellcode-Workflow behält `contents: read` und führt keine automatischen Git-Commits/Pushes aus. Kein Geheimnis/API-Schlüssel nötig. Bei Quellenausfällen oder fehlenden neuen passenden Fundstellen bleibt die vorhandene Sammlung unverändert; sie funktioniert unabhängig von den Quellenservern.
- Reine Webseitenänderungen können mit `bash "Webseite aktualisieren.command" --nur-webseite` veröffentlicht werden; die bereits veröffentlichten Modulquellen bleiben dann in der Git-Kopie bestehen. So werden parallele, noch nicht fertige Modulbearbeitungen nicht mitveröffentlicht. Ohne Option gilt weiterhin der vollständige Standardupload.
- Vor jedem lokalen Upload führt das Upload-Skript die online hinzugekommenen Zitate in die iCloud-Quelldatei zurück, damit sie nicht durch einen älteren Stand ersetzt werden. Die veröffentlichte Datei enthält ausschließlich öffentliche Zitate und interne Belege, keinen Lernstand. Jeder Build übernimmt zuerst diese Sammlung; Netz-/Datenfehler brechen vor einer Veröffentlichung ab, um keinen älteren Grundbestand auszuliefern. Parser-/Importtests in `test_zitate.py`, Auswahl-/Darstellungstests in `test_zitate.cjs` müssen auch in CI bestehen.
- Fortschrittsfeedback nur aus gespeicherten Bewertungen ableiten, z. B. heute selbst gelöst nach vorher „mit Hilfe“. Reflexionen nach Lernrunden und im Tagesabschluss fördern eigenes Handeln und Strategieprüfung. Keine Behauptung, Anstrengung beweise Gehirnwachstum.

## Stabile Tagesliste und automatische Abschlüsse

- `tagesplan:<Tag>` speichert die vorgeschlagene Liste und Karten-IDs beim ersten Aufruf; während des Tages weder fertige Zeilen austauschen noch neue Vorschläge nachschieben.
  Ausnahme: offene Vorschläge außerhalb des aktuellen Lernpfads bei Migration oder Quelländerungen bereinigen; gesperrte IDs entfernen bzw. zum aktuellen Schritt desselben Moduls führen. Fertige Tageshistorie erhalten. Planversion 3.
- `aktiv:<Tag>:<Art>:<Modul>:<ID>` hält wirkliche Bearbeitungen fest, auch beim Einstieg über die Modulnavigation. Aufgabe erst nach Selbsteinschätzung (auch „nicht geschafft“); Quiz nach Auswertung aller Fragen einschließlich Freitext; Karten nach abgeschlossenen Runden, die alle Zielkarten umfassen; Mix/Probe nach Abgabe und Bewertung sämtlicher Aufgaben.
- Automatisches Abhaken bedeutet bearbeitet, nicht beherrscht. Unsichere Inhalte bleiben in den bestehenden Wiederholungsplänen. Manuelles Überschreiben mit Zeitstempel unter `erledigt:<Tag>` erhalten. Aktivitäten gehören zum Tag des Runden-/Aufgabenstarts.
- In der Auswertung von Mix-Serie und Probeklausur bleibt die Schritt-für-Schritt-Lösung im selben Versuch. Zurück führt zur Übersicht derselben Aufgaben; Pfeile wechseln nur innerhalb dieser Auswahl. Bewertungen aus Übersicht und Lösung gemeinsam speichern, offene Bewertungen weiterzählen und den Versuch erst nach allen Bewertungen abschließen. `node test_mix.cjs` prüft diesen Ablauf.

## Selbstständige Übungsaufgaben in allen Modulen

- Alle Rechenaufgaben direkt mit Gegeben/Annahmen, Gesucht und Teilfragen a), b), c) schreiben; Zahlen, Einheiten, Konstanten, Tabellenwerte und erforderliche Abbildungen stehen in derselben Aufgabe. Keine Suche nach Daten in anderen Aufgaben verlangen. Quellen- und Modellannahmen korrekt erhalten.
- Fortlaufende Nummer je Modul liefert `build.py` als `nr`; im Druck enthält der erste Aufgabenblock die bedingte Nummer `#if not web [*Aufgabe N* #linebreak()]`. Mix/Probe zeigen ihre eigene neutrale Nummerierung.
- Aufgabentitel unverändert lassen; sie bestimmen die Lernstand-ID. Layoutänderungen brauchen keine neuen fachlichen Antworten. Quellenmarkierung und bewusste Kartenbewertung gelten in allen sieben und künftigen Modulen.

## Änderungsprotokoll

### 06.11.2026 · Automatische Nachplanung bei verpassten Einheiten
- Unerledigte Einheiten am nächsten Lerntag automatisch einplanen und offene Folgetage nötigenfalls mitverschieben. Einmalige Tagesprüfung, auch beim Wiederöffnen und während einer geöffneten Start-/Planansicht; laufende Übungen bleiben erhalten.
- Budget, Pausen, freie Tage, Reihenfolge und Klausurtermin beachten; fertige Historie und Ziel-IDs erhalten. Unmögliche Termine bleiben sichtbar offen. Startseite, Wochenplan und neu erzeugte PDFs nutzen dieselben aktualisierten Termine.
- Die gesamte automatische Terminverteilung wird gemeinsam synchronisiert; alte Verschiebungen werden migriert. Hinweis auf die automatische Anpassung und ursprüngliche Lerntage ergänzt.
- Validiert: fünf JavaScript-Suiten und 17 Python-Tests; echter Mitternachtswechsel per Browser-Testuhr, belegte Folgetage, freie Tage, feste erledigte Historie, laufende Übungen, erneutes Öffnen, Altplan-Migration, atomarer Geräteabgleich und explizite Nulltermine geprüft. Aktualisierte Lerntage in der erzeugten PDF sowie iPad-/Mobilansicht visuell kontrolliert. Unverändert 235 Lernpfadabschnitte mit echten Moduldaten geprüft.
- Sicherung: `../Sonstiges/Lernplattform-Sicherungen/2026-11-06_vor_Automatischer_Nachplanung/`.

### 06.11.2026 · Verknüpfter Lernplan und PDF
- Freigegebenen Entwurf umgesetzt: Budgets, Vorschau, Wochen-/Tagesplan, Klausurgruppen, Fortschritt, Tagesvorschläge, Neuplanung und PDF-Export. Kapitel bleiben an die bestehenden Lernpfadregeln gebunden.
- PDFs werden privat im Browser erstellt. Keine persönlichen Pläne oder Beispielbewertungen in den öffentlichen Modulquellen.
- Mario hat die Veröffentlichung des neuen Lernplan-Features einschließlich Code, Tests und PDF-Bibliotheken ausdrücklich freigegeben. Nur Webseitenänderungen mit `--nur-webseite` hochladen; persönliche Pläne bleiben privat.
- Validiert: vollständiger Build aller sieben Module ohne Warnungen, 17 Python-Tests und fünf JavaScript-Suiten; bestehender Lernpfad mit 235 Abschnitten erhalten. Browserprüfungen mit echten Moduldaten, sechs Klausuren/sieben Modulen, externen Bewertungen, zwei isolierten Geräteprofilen, Tageswechsel, Neuplanung, neuen Quellen, entfernten Zielen und iPad-/Mobilformaten bestanden. Gesamt-/Wochen-PDF mit eingebetteter Schrift, Links, Aktualisierungshinweis und simuliertem iPad-Teilen geprüft; sämtliche PDF-Seiten auf Druckränder und Stichproben visuell geprüft. Physischer Safari-/Apple-Pencil-Test bleibt geräteabhängig.
- Sicherung: `../Sonstiges/Lernplattform-Sicherungen/2026-11-06_vor_Lernplan/`.

### 06.11.2026 · Unendliches Pencil-Notizblatt und Lernplanentwurf
- Notizblatt standardmäßig eingeklappt, drei Ansichtsgrößen, unendliche Zeichenfläche mit Zwei-Finger-Zoom und Verschieben. Weltkoordinaten erhalten Schrift und Proportionen beim Größenwechsel. Nur der Stift schreibt; aufliegende Hände zeichnen und verschieben während des Schreibens nicht. Textauswahl und Kontextmenü im gesamten Blatt unterbunden.
- Begriffslandkarten-Fragen werden in sämtlichen Modulen zentral beim Build entfernt. Übrige Karten und ihre IDs bleiben erhalten; bestehende Tagesplanprüfung entfernt nicht mehr vorhandene offene Ziele.
- `Lernplan-Vorschlag.md` beschreibt die geplante Verknüpfung von Klausuren, Lernpfad, Aufgaben, Tagesvorschlägen und aktualisierten PDF-Exporten. Noch keine Implementierung dieses Features; Freigabe durch Mario steht aus.
- Validiert: vollständiger Build aller sieben Module ohne Warnungen; 17 Python-Tests und alle vier JavaScript-Suiten bestanden. 39 Fragen entfernt, übrige 603 Karten-IDs und alle Aufgaben-/Quizdaten erhalten; Lernpfad weiterhin mit 235 Abschnitten geprüft. Isolierter Chrome-Test mit simulierten nativen Stift-/Touch-Ereignissen und iPad-/Mobilformaten bestanden. Ein physischer Apple-Pencil-/Safari-Test steht noch aus. Nach ausdrücklicher Freigabe von Mario nur die Webseite (`--nur-webseite`) veröffentlicht, Commit `e40980a`; GitHub-Pages-Build erfolgreich.
- Sicherung: `../Sonstiges/Lernplattform-Sicherungen/2026-11-06_vor_Zoom_und_Stifteingabe/`.

### 06.11.2026 · Notizblatt und korrigierte Quellenmarkierungen
- Flüchtiges weißes Zeichenblatt für Karten, Verständnisfragen und Quiz; Stift, Radierer, Rückgängig und Leeren. Beim Aufdecken erhalten, beim Fragenwechsel und Verlassen verwerfen. Rechenaufgaben bleiben ohne Blatt.
- Begriffslandkarten führen zur zusammengehörigen Kapitelübersicht. Wiederholte allgemeine Wörter überstimmen keine fehlenden Antwortbegriffe mehr; unsichere Treffer öffnen den Abschnitt ohne Markierung mit Hinweis.
- Validiert: vollständiger Build aller sieben Module ohne Warnungen, 16 Python-Tests und alle JavaScript-Suiten; Lernpfad mit 235 echten Abschnitten. Browserprüfung mit echten PDFs, Quellenmarkierungen, Zeichnen, Radieren, Aufdecken, Fragenwechsel sowie iPad quer/hoch und Mobilansicht. Alle 642 Karten- und 1212 Aufgaben-/Quiz-IDs sowie Lernpfadabschnitte unverändert.
- Sicherung: `../Sonstiges/Lernplattform-Sicherungen/2026-11-06_vor_Notizblatt_Quellenkorrektur/`. Veröffentlichung ausschließlich der Webseite (`--nur-webseite`).

### 06.11.2026 · Kurze Kartenantworten und dauerhafte Stilregeln
- Alle 642 Rückseiten in sieben Modulen als Stichpunkte gegliedert; dichte Erklärungen und Begriffslandkarten vereinfacht. 246 eigene Merksätze und 19 weitere sprachliche Merkbilder ergänzt (jetzt 60); vorhandene Fachabbildungen erhalten.
- Fragen, Kapitel, Quellen und vorhandene Gleichungen beim Abgleich erhalten. Merksätze werden separat hervorgehoben. Abschnitt 8.5 aller sieben Modul-AGENTS.md und diese Regeln gelten auch für neue Vorlesungsinhalte.
- Vollständiger lokaler Build ohne Warnungen (7 Skripte und Aufgaben, 746 gesetzte Formeln), 12 Python-Tests und bestehende JavaScript-Tests bestanden; Lernpfad mit den echten Daten über alle 235 Abschnitte geprüft. Browserprüfung aller sieben Module mit echten Bildern/Formeln, Quellenlinks, bewusstem Bewerten und iPad-/Mobilansicht erfolgreich. `test_karten.py` läuft auch in CI.
- Sicherung der ursprünglichen Karten: `../Sonstiges/Lernplattform-Sicherungen/2026-11-06_vor_Kartenstichpunkten/`.

### 06.11.2026 · Verbindlicher Lernpfad in allen Modulen
- Abschnitte nach Quellenangaben numerisch ordnen; einheitliche Freigabe für neue/fällige/freie Karten, Quiz, Tagesabschluss, Aufgaben und Mix/Probe.
- Gespeicherte Tagespläne und Start-IDs prüfen; spätere Lernstände erhalten, abgeschlossene Abschnitte bei Wiederholungsfehlern offen halten.
- `node test_lernpfad.cjs` prüft alle sieben Module und die Migration. Optional prüft ein zweites Argument die Moduldaten einer gebauten `index.html` vollständig.

### 27.10.2026 · Motivation, vollständige Aufgaben, automatische Tagesliste
- „Meine Richtung“, belegte Zitate mit Favoriten, Reflexionen und konkrete Fortschrittsanzeige ergänzt; persönliche Daten bleiben privat.
- 688 Aufgaben in sieben Modulen nummeriert, darunter 260 Rechenaufgaben mit Gegeben/Gesucht und ergänzten Eingabedaten, Tabellen oder Skizzen; bestehende Titel und Lösungen erhalten.
- Tagesliste bleibt stabil und hakt tatsächliche Abschlüsse automatisch ab. Regeln in allen sieben Modul-AGENTS.md ergänzt.
- Validierung: vollständiger Build aller sieben Lernskripte und Aufgaben ohne Fehler/Warnungen; 688 Aufgaben-/215 Quiz-/462 Karten-IDs und bestehende Lösungsschritte unverändert, Quellenmarkierungen für alle gültig. Abschlussgrenzen, manuelle Haken und Tageswechsel automatisiert geprüft; Scroll-Regressionsprüfung (16 Gesten, 4 Bewertungsbuttons), iPad-/Mobilansicht und PDF-Stichproben aller Module geprüft. Veröffentlichung mit dem bestehenden Upload-Skript.


### 27.10.2026 · Große Zitatdatenbank mit Internetergänzung
- Sammlung auf 100 Zitate von 28 Personen erweitert; 96 gefundene ungeeignete/zweifelhafte oder doppelte Einträge dauerhaft ausgeschlossen. Quellen/Werkangaben intern erhalten, Anzeige auf Zitat und Name reduziert.
- Tageshistorie verhindert vorzeitige Wiederholungen und hält die Wahl nach Neuladen/Erweiterungen stabil. Suchbare Sammlung, portionsweises Nachladen und Favoriten erhalten.
- Wöchentlicher Import mit Werkbelegen, Ausfallrückfall, automatischer Veröffentlichung und sicherer Zusammenführung bei lokalen Uploads ergänzt. Sicherung: `../Sonstiges/Lernplattform-Sicherungen/2026-10-27_vor_Zitatdatenbank/`.
- Validiert: Parser-/Importtests und JavaScript-Tests für vollständigen Umlauf, Tagesstabilität, Datenbankwachstum, Favoriten und reduzierte Anzeige bestanden. Echter Internetimport gegen eine Testkopie ergänzt genau 10 weitere freigegebene Einträge. Gesamtbuild aller 7 Module ohne Fehler/Warnungen; Browserprüfung von Suche, Favoriten, Entwurfserhalt und Anzeige nur mit Zitat/Name bestanden.

### 03.11.2026 · Prüfungsanmeldung und Notenblatt
- `pruefungen.json` mit den 6 angemeldeten Klausuren des WS 2026/27 (TM 26.01., I&F 28.01., GET 02.02., Konstruktion 04.02., Physik 2 09.02., FET 11.02.) und dem Notenblatt vom 03.11.2026 (Ø 2,8, 52 ECTS).
- Klausuren laufen als Fristen mit Countdown und in die Tagesvorschläge ein; neuer Bereich „Prüfungen & Noten“ im Reiter Termine; Klausurdatum auf Lernskript-Karten und Lernen-Seite.
