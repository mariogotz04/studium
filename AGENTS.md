# Lernskript-Webseite

Dieser Ordner (`Uni/Webseite/`) ist die Quelle der Webseite https://mariogotz04.github.io/studium/.
Sie ist Marios Lernplattform mit vier Reitern:

- **Start:** Uhr, heutiger und morgiger Vorlesungsplan, „Heute dran“ (täglich wechselnde Lernvorschläge aus Plan,
  Klausurterminen und Lernstand), Countdown zur nächsten Klausur, Fristen, To-dos.
- **Lernskripte:** jedes Lernskript als PDF. Die PDF enthält nur Zusammenfassung und Formelsammlung. Die frühere Hörzusammenfassung (EPUB, Leseansicht) gibt es seit 12.11.2026 nicht mehr.
- **Lernen:** Rechenaufgaben und Verständnisfragen mit Lösung Schritt für Schritt (vor allem Aufgaben der Professoren,
  gekennzeichnet als „Original“ bzw. „Von Claude erstellt“), Pomodoro-Timer,
  je Modul eine Probeklausur (Aufgaben aus verschiedenen Kapiteln, gemischt, ohne Titel, mit Uhr, Standard 80 % der
  Klausurdauer) und eine Mix-Serie (5 Aufgaben aus 5 Kapiteln, ohne Uhr). Die Zeit je Aufgabe kommt aus dem optionalen
  Feld `minuten:` in `Aufgaben.typ`, sonst wird sie nach der Zahl der Lösungsschritte geschätzt.
- **Klausurtyp je Modul** (Transfer / Gemischt / Abfrage, plus Dauer): einstellbar beim Eintragen einer Klausur und in der
  Probeklausur. Standard: Finanzierung und Investitionsrechnung gemischt, alle anderen Transfer. Er gewichtet „Heute dran“
  (Transfer: mehr Rechnen und Probeklausuren, Abfrage: mehr Verständnisfragen). „Heute dran“ enthält immer mindestens
  zwei Module. Ab 17 Uhr erscheint auf der Startseite der Tagesabschluss (frei aufschreiben, dann 3 Verständnisfragen aus den
  heutigen Modulen, bevorzugt schon bearbeitete).
- **Termine:** Fristen und Klausuren mit Countdown, To-dos, Lernplan mit Wochen-PDF „Aufgaben KW N“.
- **Quiz und Karteikarten gibt es seit 11.11.2026 nicht mehr** (Mario). Ihr Inhalt steht als Verständnisfragen in
  `Aufgaben.typ`; `build.py` liest `Quiz.md`/`Karteikarten.md` nicht mehr (`QUIZ_UND_KARTEN = False`). Die alten Dateien liegen je Modul
  unter `Zum Löschen/Quiz und Karteikarten (bis 11.11.2026)/`. Der Code für Quiz/Karten in vorlage.html ist nur noch abwärtskompatibel vorhanden.
- **Lernreihe (Mario, 06.11.2026):** Jedes Modul wird Abschnitt für Abschnitt der Reihe nach gelernt (`lernreihe()` in
  vorlage.html). `Quelle:`/`quelle:` gliedert ein Kapitel in Abschnitte wie 1.1, 1.2 und 1.10; Unterabschnitte wie 1.1.2 gehören zu 1.1.
  Ein Abschnitt ist abgeschlossen, wenn alle Aufgaben selbst gelöst (grün) sind. Die vollständig bearbeitete Folge ab Modulbeginn wird privat unter `lernpfad:<Modul>:<Kapitel>:<Abschnitt>` synchronisiert.
  Wiederholungsfehler setzen einen erreichten Abschluss nicht zurück. „Heute dran“,
  Tagesabschluss, Aufgaben, Mix-Serie und Probeklausur nehmen nur den aktuellen bzw. schon erreichten Abschnitt.
  Früher angeklickter späterer Stoff wartet unter Erhalt seiner Bewertungen und Termine. Gespeicherte IDs und Tagespläne werden erneut geprüft;
  gültige Ziele und bereits fertige Tageszeilen bleiben erhalten. Die Modulseite zeigt den aktuellen Abschnitt, offene Inhalte und einen Weiter-Button samt Skriptverweis.
  Eine nicht selbst gelöste Aufgabe bleibt dran. Das Kapitel kommt aus der Überschrift (`#kapitel`, `## `),
  bei Sammelüberschriften („Kapitel 7–12“, „TM1 · Statik“) aus `Quelle:`/`quelle:`. Darum Kapitelüberschriften immer
  mit „Kapitel N“ benennen und jede Aufgabe mit Quelle versehen. **Ausnahme Formelsammlung:** deren Unterabschnitte heißen
  `=== Formeln zu Kapitel N · …` und beginnen nicht mit „Kapitel“, damit sie nicht als Skriptkapitel zählen.

Die PDFs und die Aufgaben werden auf GitHub aus den `.typ`-Dateien gesetzt; hier liegt nur die Seite selbst.

## Nach jeder Änderung an einem Lernskript hochladen

Wenn du eine `.typ`-Datei (auch `Aufgaben.typ`), ein Bild in `abbildungen/` eines Moduls
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
- Pro Modul außerdem `Typst-Dateien/Aufgaben.typ` (Aufgaben, Format im Kopf der Datei; daraus entstehen die Web-Bausteine,
  die Lösungs-PDF und `<Modul>_Blatt.pdf` mit einer Seite je Aufgabenstellung für das Wochen-PDF).
- `Vorlesungsplan.pdf` aus diesem Ordner (siehe unten).
- Nie hochgeladen werden: `Zum Löschen/`, `Unterlagen/`, `Sonstiges/`, `Physik Praktikum/` und dieser Ordner.
- Ein neues Modul erscheint automatisch, sobald es `Lernskript aktuell/Typst-Dateien/main.typ` hat.

## Dateien hier

- `vorlage.html` – Aussehen und Verhalten der Seite (eingesetzt werden die Skripte bei `/*DATA*/null`, die Aufgaben bei
  `/*LERNEN*/null` (`/*KARTEN*/null` bleibt leer), der Vorlesungsplan bei `/*PLAN*/null`).
- `pruefungen.json` – Prüfungsanmeldung (Termine, Uhrzeit, Dauer, angemeldet ja/nein) und Notenblatt; eingesetzt bei `/*PRUEFUNGEN*/null`.
- `Vorlesungsplan.pdf` – aktueller Stundenplan als PDF-Export aus thabella (Mario legt ihn hier ab).
- `build.py` – kompiliert die Skripte und baut die Seite (läuft auf GitHub).
- `.github/workflows/webseite.yml` – Build/Veröffentlichung und wöchentliche Ergänzung der Zitatdatenbank; diese lokale Quelle wird mit hochgeladen.
- `Webseite aktualisieren.command` – Upload (Doppelklick oder `bash`).

Änderungen an diesen Dateien werden ebenfalls mit dem Upload-Skript veröffentlicht.
## Verständnisfragen (früher Karteikarten und Quiz)

- Alle Verständnis- und Theoriefragen stehen als `art: "verstehen"` in `Aufgaben.typ`, offen formuliert, Lösung in kurzen
  Stichpunkten, dazu bei Bedarf Schritte `*Typische Verwechslung:*`, `*Merksatz:*` und `*Bild:*` (Alltagsanalogie).
  Der Kartenstil vom 06.11.2026 (kurze Stichpunkte, parallele Vergleiche) gilt für diese Fragen weiter.
- Keine „Zeichne die Begriffslandkarte …“-Fragen, auch nicht umformuliert (Mario, 06.11. und 11.11.2026).
- Quellenlinks aller Aufgaben öffnen die integrierte PDF-Ansicht; `build.py` bestimmt die markierte Stelle bei jedem Build neu
  (Feld `h`), nur der angeklickte Verweis wird gelb eingeblendet. Keine dauerhaft eingefärbten PDFs erzeugen.

## Flüchtiges Notizblatt und zuverlässige Quellen

- Verständnisfragen bieten ein zunächst eingeklapptes weißes Notizblatt rechts neben der Frage. Unter 800 px steht es über dem Inhalt. Ausschließlich Stifteingaben (`pointerType === "pen"`, insbesondere Apple Pencil) erzeugen Striche; Finger und Handballen niemals. Radierer, Rückgängig und Leeren bleiben verfügbar. Rechenaufgaben erhalten kein Blatt.
- Die Fläche ist in Weltkoordinaten unbegrenzt verschiebbar; zwei Finger verschieben und zoomen den Ausschnitt (20–500 %). Einzelne Finger bewegen das Blatt nicht. Während des Schreibens und bis zum Abheben aufliegender Kontakte sind Fingergesten gesperrt. Kontextmenü, Textauswahl und iOS-Touch-Callout im Notizblatt unterbinden. „Kleiner/Größer“ ändern die Ansichtsgröße ohne Striche zu verzerren; Zoomknöpfe und „Zum Anfang“ ergänzen die Gesten. Jede neue Frage startet wieder eingeklappt.
- Striche liegen ausschließlich im Arbeitsspeicher. Beim Aufdecken einer Antwort, eines Tipps oder Lösungsschritts, bei Quizauswahl, Ein-/Ausklappen und Größenwechsel erhalten; beim Bewerten einer Karte/Aufgabe, Fragenwechsel, Rundenende oder Verlassen der Übung verwerfen. Niemals Browser-Speicher, Export oder Sync für Notizen verwenden.
- Allgemeine Quellenmarkierungen erfordern mehrere passende Antwortbegriffe und ausreichende Textabdeckung. Bei unsicherem Treffer nur den Abschnitt öffnen und dies im Viewer anzeigen. Die Zuordnung alter Begriffslandkarten zur Kapitelübersicht bleibt intern abwärtskompatibel; dieser Fragetyp wird nicht mehr veröffentlicht.
- `node test_notizen.cjs` prüft Zeichnen und Lebensdauer; `python3 -m unittest test_quellen.py` prüft falsche Worttreffer und nach dem Build das echte Konstruktionsbeispiel. Beide laufen in CI.

Nicht direkt in `~/Studium-Webseite` arbeiten: Das Skript überschreibt dort alles mit dem Stand aus dem Uni-Ordner.

## Lernen: Aufgaben

- Quelle: je Modul `Lernskript aktuell/Typst-Dateien/Aufgaben.typ`, direkt neben `main.typ` (sie importiert dessen
  Befehle wie `#bild`, `#tab`, `#note`). Aufbau und Regeln stehen im Kopf der Datei; den Kopf nicht ändern.
- Jede Aufgabe ist `#aufgabe(titel: …, art: "rechnen" | "verstehen", quelle: "1.5", herkunft: "original" | "variante" | "eigen", vorlage: "Übung 3, Aufg. 2", ergebnis: […], tipp: […], minuten: 15, platz: 12)[Aufgabe][Schritt 1][Schritt 2]…`.
- **Herkunft (Mario, 11.11.2026):** Aufgaben der Professoren (Übungen, Altklausuren) originalgetreu als `original` mit `vorlage`;
  Varianten nach einer Vorlage als `variante` (gleiche `vorlage`); alles andere `eigen`. Die Seite zeigt „Original · …“ bzw.
  ein Kästchen „Claude“, das Wochen-PDF die Herkunft in der Kopfzeile. `build.py` warnt, wenn `herkunft` fehlt.
- `platz:` (cm, optional) steuert den Schreibraum im Wochen-PDF; sonst schätzt `lernplan-pdf.js` ihn aus Art, Schritten und Minuten.
  Auf der Webseite deckt Mario jeden Schritt einzeln auf; deshalb jeden Schritt für sich verständlich schreiben:
  fette Kurzüberschrift, dann *warum* man so vorgeht (Feynman-Stil, Alltagsbild wo es hilft), dann die Rechnung,
  am Ende eine Prüfung (Einheit, Größenordnung, Grenzfall).
- `build.py` setzt jede Aufgabe, jeden Tipp, jedes Ergebnis und jeden Schritt als eigenes SVG (`_site/a/`) und
  erzeugt zusätzlich eine PDF mit allen Lösungen. Außerhalb von `#aufgabe` und `#kapitel` darf nichts stehen,
  sonst stimmt die Zuordnung nicht (der Build meldet dann „Aufgaben fehlerhaft“).
- Ob eine Aufgabe gelöst ist, hängt am Titel. Titel deshalb nicht ohne Grund ändern.

## Alle Lernformate wachsen mit den Vorlesungsunterlagen

- Nach jeder Einarbeitung neuer Vorlesungsunterlagen das Lernskript **und** `Aufgaben.typ` (neue Prof-Aufgaben als Original,
  Varianten, Verständnisfragen samt Ergebnis, Tipp und Lösungsschritten) gemeinsam abgleichen.
- Zu neu behandeltem Stoff passende Aufgaben ergänzen. Sie landen automatisch im Lernplan (ab der folgenden Woche). Vorhandene Antworten nur ändern, wenn sie falsch, unvollständig oder durch die Unterlagen überholt sind.
  Eine reine Layout- oder Übersichtsänderung erfordert keine neuen fachlichen Antworten.
- Titel und Fragetexte möglichst unverändert lassen, damit der Lernstand erhalten bleibt. Abschnittsverweise nach
  jeder Skriptänderung prüfen; Seitenzahlen werden beim Build aus der aktuellen PDF neu bestimmt.
- Alle Formate zusammen prüfen und mit dem Upload-Skript veröffentlichen. Das ist redaktionelle Pflege durch die KI
  bei der Bearbeitung der Unterlagen; der Webseiten-Build selbst erzeugt keine neuen Fragen.

## Hörzusammenfassung (entfallen seit 12.11.2026)

- Mario nutzt sie nicht. `build.py` erzeugt keine EPUB mehr, die Leseansicht `#hoeren/…` ist entfernt (alte Links führen zu den Lernskripten).
- `Hoerskript.md` liegt je Modul unter `Zum Löschen/Hoerskript (bis 12.11.2026)/` und wird nicht mehr gepflegt oder angelegt.

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

## Lernplan: Aufgabenplan ohne Zeitbudget (seit 11.11.2026)

- **Termine → Lernplan** (`#termine/lernplan`). Kein Wochenbudget mehr (Mario, 11.11.2026). `lernplan.js` verteilt **alle offenen
  Aufgaben** jedes Moduls in Lernreihenfolge gleichmäßig nach Bearbeitungszeit auf die Wochen von heute bis 14 Tage vor der
  Klausur (Stoffphase; angebrochene Wochen zählen anteilig). Die letzten 14 Tage (Probephase, einstellbar 0–28) enthalten je Klausur
  zwei Probeklausuren und zwei Wiederholungseinheiten für nicht selbst gelöste Aufgaben. Gemeinsame Klausuren (Inv+Fin) planen beide Module.
- **Automatisch:** Der Plan wird ohne Bestätigung neu berechnet, wenn sich die Woche, die Aufgaben (Signatur über alle Aufgaben-IDs)
  oder die Klausurtermine/Einstellungen ändern. Die laufende Woche bleibt stabil; neue Aufgaben kommen ab der nächsten Woche dazu.
  Erledigtes bleibt als Historie in seiner Woche; Offenes wandert zum Wochenwechsel in die restlichen Wochen.
  Deutlich überdurchschnittliche Wochen werden als Hinweis genannt.
- Privat im Sync-Zustand: Plan `lernplan:aufgabenplan` (mode `aufgaben`), Einstellungen `einst:aufgabenplan` `{probe, exams}`;
  `lernplan:manuell:<ID>` und `lernplan:abschluss:<ID>` bleiben. Alte `lernplan:version:*`-Pläne werden beim ersten neuen Plan gelöscht.
  Keine privaten Pläne in Modulquellen oder Git.
- **Wochen-PDF** (`lernplan-pdf.js`, pdf-lib im Browser, auch in der iPad-App): „Aufgaben KW N.pdf“ (bei anderem ISO-Jahr mit Jahr),
  A4, Deckblatt mit Kästchen je Modul, dann je Aufgabe Kopfzeile (Modul, Art, Abschnitt, Herkunft, Link „Lösung ansehen“),
  die Aufgabenstellung als Vektorgrafik aus `pdf/<Modul>_Blatt.pdf` und ein karierter Schreibbereich (5 mm) zum handschriftlichen
  Lösen in GoodNotes.
- `node test_lernplan.cjs` prüft Verteilung, Probephase, stabile Woche, neue Aufgaben, Wochenwechsel, gemeinsame Klausur und KW/Jahr.
  Dauern mit `Lernplan.duration` anzeigen. Alle Plan-/PDF-Dateien und `vendor/` gehören zum Upload.

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

- `tagesplan:<Tag>` speichert die vorgeschlagene Liste beim ersten Aufruf; während des Tages weder fertige Zeilen austauschen noch neue Vorschläge nachschieben.
  Ausnahme: offene Vorschläge außerhalb des aktuellen Lernpfads bei Migration oder Quelländerungen bereinigen; gesperrte IDs entfernen bzw. zum aktuellen Schritt desselben Moduls führen. Fertige Tageshistorie erhalten. Planversion 3.
- `aktiv:<Tag>:<Art>:<Modul>:<ID>` hält wirkliche Bearbeitungen fest, auch beim Einstieg über die Modulnavigation. Aufgabe erst nach Selbsteinschätzung (auch „nicht geschafft“); Mix/Probe nach Abgabe und Bewertung sämtlicher Aufgaben.
- Automatisches Abhaken bedeutet bearbeitet, nicht beherrscht. Unsichere Inhalte bleiben in den bestehenden Wiederholungsplänen. Manuelles Überschreiben mit Zeitstempel unter `erledigt:<Tag>` erhalten. Aktivitäten gehören zum Tag des Runden-/Aufgabenstarts.
- In der Auswertung von Mix-Serie und Probeklausur bleibt die Schritt-für-Schritt-Lösung im selben Versuch. Zurück führt zur Übersicht derselben Aufgaben; Pfeile wechseln nur innerhalb dieser Auswahl. Bewertungen aus Übersicht und Lösung gemeinsam speichern, offene Bewertungen weiterzählen und den Versuch erst nach allen Bewertungen abschließen. `node test_mix.cjs` prüft diesen Ablauf.

## Selbstständige Übungsaufgaben in allen Modulen

- Alle Rechenaufgaben direkt mit Gegeben/Annahmen, Gesucht und Teilfragen a), b), c) schreiben; Zahlen, Einheiten, Konstanten, Tabellenwerte und erforderliche Abbildungen stehen in derselben Aufgabe. Keine Suche nach Daten in anderen Aufgaben verlangen. Quellen- und Modellannahmen korrekt erhalten.
- Fortlaufende Nummer je Modul liefert `build.py` als `nr`; im Druck enthält der erste Aufgabenblock die bedingte Nummer `#if not web [*Aufgabe N* #linebreak()]`. Mix/Probe zeigen ihre eigene neutrale Nummerierung.
- Aufgabentitel unverändert lassen; sie bestimmen die Lernstand-ID. Layoutänderungen brauchen keine neuen fachlichen Antworten. Quellenmarkierung und bewusste Bewertung gelten in allen sieben und künftigen Modulen.

## Änderungsprotokoll

### 12.11.2026 · Hörzusammenfassung entfernt, Verständnisfragen 3 Minuten im Lernplan
- EPUB-Hörzusammenfassung und Leseansicht entfernt (Marios Wunsch); build.py ohne Hörskript-Abgleich, Hoerskript.md aus allen Modulen nach „Zum Löschen“.
- Lernplan: Verständnisfragen zählen pauschal 3 Minuten (`VERSTEHEN_MIN` in lernplan.js), Rechenaufgaben mit ihren `minuten:`.

### 12.11.2026 · Aufgaben der Professoren, Lernplan ohne Budget, Quiz/Karten entfallen
- Alle sieben Module: Übungs- und Altklausuraufgaben als Originale mit gekennzeichneten Varianten, Quiz- und Kartenfragen als Verständnisfragen (1.746 Aufgaben). Formelsammlungen nach Kapiteln (`=== Formeln zu Kapitel N`).
- Lernplan verteilt alle Aufgaben automatisch bis 14 Tage vor der Klausur, Wochen-PDF mit Schreibraum. Quiz/Karten aus Seite und Build entfernt, Tagesabschluss mit 3 Verständnisfragen.
- Offen: GET-Wechselstrom (kein Skriptkapitel), FET-Stoff ab Kapitel 5 (Exergie, Kreisprozesse, Rohrnetze). Sicherung: `../Sonstiges/Lernplattform-Sicherungen/2026-11-11_vor_Aufgaben-Umbau/`.

### 09.11.2026 · Fachlisten und Rückkehr zum Wochenplan
- Fachzustände dauerhaft speichern; Wochenposition und Übungsursprung pro Browser-Tab erhalten. Rücklinks und erfolgreiche Einzelaufgaben führen zur ursprünglichen Woche und zum passenden Fach. Karten, Quiz und Probeklausuren bieten den direkten Rückweg auch nach der Auswertung; die Probelösung bleibt im selben Versuch.
- Geprüft mit automatischen Navigations-/Lernpfadtests und isolierten Browserabläufen einschließlich Neuladen, Browser-Zurück und Desktop/iPad/Mobil.
- Sicherung: `../Sonstiges/Lernplattform-Sicherungen/2026-11-09_vor_Wochenplan_Rueckkehr/`.

### 09.11.2026 · Stunden und Minuten statt großer Minutenzahlen
- Gemeinsame Dauerformatierung `Lernplan.duration`: ab 60 Minuten Stunden und Restminuten, unter einer Stunde Minuten. Restzeiten, Wochenbudgetvergleiche, Fachsummen, Einheiten, offene Zeitbedarfe, Startseite und PDF entsprechend anzeigen. Probeklausur-/Klausurdauern und Pomodoro-Auswertungen verwenden dieselbe Darstellung. Numerische Einstellungen und gespeicherte Berechnungswerte behalten ihre bisherigen Einheiten.
- Beispiele: 90 → 1 Std. 30 Min.; 94 → 1 Std. 34 Min.; 1179 → 19 Std. 39 Min.; 1366 / 1460 → 22 Std. 46 Min. / 24 Std. 20 Min.
- Validiert: fünf JavaScript-Suiten, vollständiger Browserablauf auf Desktop/iPad/Mobil und gerenderte PDF-Seiten mit Wochenbudget sowie langer Probeklausur-Einheit geprüft.
- Sicherung: `../Sonstiges/Lernplattform-Sicherungen/2026-11-09_vor_Stundenanzeige/`.

### 09.11.2026 · Frei einteilbare Wochenziele
- Ein Wochenbudget in Stunden ersetzt die sieben Tagesbudgets. Konkrete Einheiten werden nach Fächern mit Fortschritt, Restzeit und Startknöpfen angezeigt. Start übernimmt die offenen Wochenziele; echte Klausurfristen und der Beginn von Wiederholungen stehen bei den betroffenen Einheiten.
- Neue Wochenplanung mit Reserve, Klausurgrenzen, freien Tagen, Abschnittsreihenfolge und einer Verteilung auf mehrere Fächer. Bestehende Tagespläne anhand ihrer effektiven Termine nach Wochen darstellen, ihre gespeicherte Version und Bewertungen dabei erhalten. Neuplanung weiterhin erst nach Vorschau übernehmen.
- Innerhalb der Woche keine automatische Verschiebung. Zum Wochenwechsel offene Vorwochenziele priorisiert nachholen, spätere offene Ziele bei Bedarf verschieben und das gesamte Wochenbudget einhalten. Erledigte Historie erhalten; nicht einplanbare Ziele ausdrücklich ohne Woche führen. Fällige Karten einmal pro Wochenstart nur im nachgewiesenen Restbudget ergänzen.
- Wochenzuordnungen getrennt von alten Tagesdaten atomar unter `lernplan:wochen:<Version>` speichern. Dadurch kann ein älteres Gerät die neue Zuordnung oder explizite Nullwochen nicht überschreiben. PDF-Export als Wochenlisten mit denselben Zielen, Fortschritt, Fristen und Quellenlinks.
- Validiert: fünf JavaScript-Suiten und 17 Python-Tests (ein Test ohne lokal gebaute PDFs übersprungen). Isolierter Browser mit veröffentlichten Moduldaten: Vorschau/Übernahme, manueller Fortschritt ohne Lernpfadfreigabe, Aufgabenstart, Startseite, unveränderte Ziele an Dienstag/Sonntag, echter Wochenwechsel, Budgetgrenzen, Historie, Altplan-Migration, ältere Tagesdaten, fällige Karten und erneutes Öffnen erfolgreich geprüft. Vollständiger Lernpfad mit sieben Modulen und 235 Abschnitten erhalten. Desktop/iPad/Mobil ohne Überbreite geprüft. Gesamt- und Wochen-PDF sowie echter Download nach dem Wochenwechsel auf Text, Links und Druckränder kontrolliert und repräsentative Seiten gerendert geprüft.
- Sicherung: `../Sonstiges/Lernplattform-Sicherungen/2026-11-09_vor_Wochenzielen/`.

### 09.11.2026 · Lernzeit und Reserve getrennt, Puffer einstellbar
- Wochenbudget einschließlich Reserve, maximal tatsächlich verplante Wochenzeit einschließlich Pausen und freigehaltene Reserve getrennt anzeigen. Die große Budgetzahl ist keine reine Lernzeit. Einzelne Einheiten und deren Zeitansätze bleiben bei geänderter Reserve gleich.
- Zeitreserve von 0 bis 50 % wählbar; Standard und bestehende Pläne bleiben bei 20 %. Grundplanung und Bedarfssuche verwenden denselben Wert. Änderungen zunächst als Vorschau prüfen und bewusst übernehmen; die persönliche Planung nicht durch eine reine Bedarfssuche verändern. Automatisches Nachholen darf wie bisher die Reserve nutzen. Die PDF nennt den gewählten Prozentsatz.
- Validiert: fünf JavaScript-Suiten einschließlich variabler/fehlender/Null-Reserve, unveränderter Ziele und Probeklausurzeiten, Kapazitätsgrenzen sowie getrennter Zeitanteile. Browserprüfung mit veröffentlichten Moduldaten bei 20 % und 5 %, vollständiger Planung und freier Wiederholungsphase, Neuberechnung, Übernahme und erneutem Öffnen sowie Desktop/iPad/Mobil erfolgreich. Der Lernpfad bleibt bei sieben Modulen und 235 Abschnitten erhalten.
- Sicherung: `../Sonstiges/Lernplattform-Sicherungen/2026-11-09_vor_Einstellbarem_Puffer/`.

### 09.11.2026 · Benötigte Lernminuten pro Woche
- Oberhalb des Lernplanformulars den Wochenbedarf, die eingetragene Summe und fehlende Minuten anzeigen. Richtwert mit dem bestehenden Planer für die aktuelle Tagesverteilung simulieren; Klausurgrenzen, freie Tage, optionale Vorlesungen, Pausen und 20 % Puffer beachten. Die vollständige Wiederholungsphase erhalten, sofern mit diesen Lerntagen möglich; Verkürzung oder unmögliche Planung sichtbar ausweisen.
- Bei Änderungen am Formular den Bedarf neu berechnen und die überholte Vorschau entfernen. Tagesminuten bleiben frei einteilbar; Berechnungen allein speichern keinen persönlichen Plan. Bei Nullbudget eine gleichmäßige Woche als Berechnungsgrundlage verwenden. Der Richtwert gilt für den bekannten Stoff, nicht als Garantie für künftige Ergänzungen.
- Eine bestehende Kollision der Tagesmarkierung „heute“ mit dem Raster der Startseite behoben; der aktuelle Lerntag bleibt auch auf dem iPad untereinander lesbar.
- Validiert: fünf JavaScript-Suiten einschließlich neuer Wochenbedarfsfälle und 17 Python-Tests (ein Test ohne lokal gebaute PDFs übersprungen). Browserprüfung mit allen veröffentlichten Moduldaten: Richtwert vollständig einplanbar, keine verkürzte Wiederholungsphase, automatische Neuberechnung, veraltete Vorschau verworfen, keine implizite Speicherung, Übernahme und erneutes Öffnen, Desktop/iPad/Mobil ohne horizontale Überbreite. Bestehender Lernpfad mit sieben Modulen und 235 Abschnitten erhalten.
- Sicherung: `../Sonstiges/Lernplattform-Sicherungen/2026-11-09_vor_Wochenbedarf/`.

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
