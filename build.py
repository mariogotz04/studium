#!/usr/bin/env python3
"""Kompiliert das aktuelle Lernskript jedes Moduls zu einer PDF und baut die Webseite in _site/.

Aufbau: skripte/<Modul>/Lernskript aktuell/Typst-Dateien/main.typ (genau ein Skript je Modul).
Andere .typ-Dateien, etwa alte Stände, werden nie veröffentlicht.
Karteikarten: skripte/<Modul>/Lernskript aktuell/Karteikarten.md (Aufbau steht am Kopf jeder Datei).
Eine Karte kann mit „Quelle: 1.3“ auf einen Abschnitt des Lernskripts zeigen (die Seite wird beim Bauen
aus dem Inhaltsverzeichnis der PDF bestimmt) und mit „Abbildung: name“ ein Bild aus abbildungen/ zeigen.
Formeln stehen in Typst-Schreibweise zwischen Dollarzeichen ($c = sqrt(2 g h)$, eine Zeile nur mit
$ … $ wird abgesetzt). Sie werden mit Typst als SVG gesetzt und sehen so aus wie im Lernskript.
"""
import hashlib
import html
import json
import math
import re
import shutil
import subprocess
import sys
import uuid
import unicodedata
import zipfile
from collections import Counter
from datetime import date, datetime, timedelta, timezone
from pathlib import Path
from zoneinfo import ZoneInfo

ROOT = Path(__file__).resolve().parent
SRC = ROOT / "skripte"
OUT = ROOT / "_site"
TEMPLATE = ROOT / "vorlage.html"
BERLIN = ZoneInfo("Europe/Berlin")
UMLAUTE = str.maketrans({"ä": "ae", "ö": "oe", "ü": "ue", "Ä": "Ae", "Ö": "Oe", "Ü": "Ue", "ß": "ss"})


def titel_setzen(pdf, titel):
    """PDF-Titel (wird im Viewer und beim Speichern angezeigt) auf den Dateinamen setzen."""
    try:
        from pypdf import PdfReader, PdfWriter
    except ImportError:
        return
    writer = PdfWriter(clone_from=PdfReader(pdf))
    writer.add_metadata({"/Title": titel})
    with open(pdf, "wb") as f:
        writer.write(f)


def find_entrypoints():
    return sorted(SRC.glob("*/Lernskript aktuell/Typst-Dateien/main.typ"))


def doc_title(typ):
    m = re.search(r'#set\s+document\([^)]*title:\s*"([^"]+)"', typ.read_text(encoding="utf-8"))
    return m.group(1) if m else (typ.parent.name if typ.stem == "main" else typ.stem)


def stand(typ):
    """Stand aus dem Skript selbst („Stand 24.10.2026“), sonst Datum der letzten Änderung."""
    m = re.search(r"Stand\s+(\d{1,2})\.(\d{1,2})\.(\d{4})", typ.read_text(encoding="utf-8"))
    if m:
        return date(int(m.group(3)), int(m.group(2)), int(m.group(1)))
    return last_change(typ.parent).astimezone(BERLIN).date()


def last_change(path):
    """Datum des letzten Commits, der den Ordner geändert hat (Fallback: Dateizeit)."""
    try:
        out = subprocess.run(["git", "log", "-1", "--format=%cI", "--", str(path)],
                             cwd=ROOT, capture_output=True, text=True, check=True).stdout.strip()
        if out:
            return datetime.fromisoformat(out)
    except (subprocess.CalledProcessError, FileNotFoundError):
        pass
    return datetime.fromtimestamp(path.stat().st_mtime, tz=timezone.utc)


def gliederung(pdf):
    """Alle Überschriften der PDF (Lesezeichen) mit ihrer Seite, in Reihenfolge."""
    try:
        from pypdf import PdfReader
    except ImportError:
        return []
    reader, out = PdfReader(pdf), []

    def gehen(knoten):
        for k in knoten:
            if isinstance(k, list):
                gehen(k)
            else:
                out.append((k.title.strip(), reader.get_destination_page_number(k) + 1))
    gehen(reader.outline)
    return out


def abschnitt_finden(ref, abschnitte):
    """„1.3“ oder „TM2 1.1“ oder ein Titelanfang → (Titel, Seite) der passenden Überschrift."""
    for titel, seite in abschnitte:
        if titel == ref or titel.startswith(ref + " "):
            return titel, seite
    for titel, seite in abschnitte:
        if titel.lower().startswith(ref.lower()):
            return titel, seite
    return None


# Die Markierungen gehören zum jeweiligen Verweis, nicht zur PDF. Ihre relativen Zeilenrechtecke
# werden mit jeder neuen PDF neu ermittelt und passen dadurch auch nach Seitenverschiebungen.
STOPPWÖRTER = set("aber alle allem allen aller alles also als am an andere auch auf aus bei beim bis da "
                 "dabei dadurch daher damit dann das dass dem den denn der des die diese diesem diesen dieser "
                 "dieses doch dort du durch ein eine einem einen einer eines er es etwas für gegen gilt hat "
                 "haben hier ich im in ins ist ja kann kein keine keinen man mehr mit muss nach nicht noch "
                 "nur oder ohne pro richtig sein seine sich sie sind so sowie statt über um und uns unter vom "
                 "von vor warum was welche welcher welches wenn wer werden wie wieder wir wird wo zu zum zur "
                 "zwischen erklären erkläre beispiel frage antwort schritt prüfen gegeben gesucht bestimmen "
                 "bestimme berechne berechnen".split())


def suchtext(text):
    """HTML, Typst-Formelplatzhalter und PDF-Trennstriche für den Textvergleich auflösen."""
    text = re.sub(r"@@F([a-f0-9]+)@@", lambda m: FORMELN.get(m[1], ("",))[0], text)
    text = html.unescape(re.sub(r"<[^>]+>", " ", text))
    text = unicodedata.normalize("NFKC", text).casefold().replace("\u00ad", "")
    text = re.sub(r"(\w)[-‐]\s+(?=[a-zäöü])", r"\1", text)
    return text


def suchwörter(text):
    wörter = []
    for wort in re.findall(r"[^\W\d_]{3,}", suchtext(text)):
        if wort in STOPPWÖRTER:
            continue
        wort = wort.translate(UMLAUTE)
        # Einfache deutsche Flexion: „geschlossenes“ und „geschlossen“ sollen zusammenpassen.
        if len(wort) > 5:
            wort = re.sub(r"(?:ern|em|en|er|es|e|n|s)$", "", wort)
        wörter.append(wort)
    return Counter(wörter)


class Skriptstellen:
    """Antwortbezogene Textstellen innerhalb des angegebenen Abschnitts, samt PDF-Koordinaten."""

    def __init__(self, datei):
        import pdfplumber
        from pypdf import PdfReader
        self.pdf = pdfplumber.open(datei)
        reader = PdfReader(datei)
        self.abschnitte, self.seiten, self.blockcache = [], {}, {}

        def lesen(knoten):
            for k in knoten:
                if isinstance(k, list):
                    lesen(k)
                else:
                    p = reader.get_destination_page_number(k) + 1
                    höhe = float(reader.pages[p - 1].mediabox.height)
                    self.abschnitte.append((k.title.strip(), p, höhe - float(k.top or höhe)))
        lesen(reader.outline)

    def schließen(self):
        self.pdf.close()

    def zeilen(self, n):
        if n not in self.seiten:
            seite = self.pdf.pages[n - 1]
            zeilen = []
            for z in seite.extract_text_lines():
                if z["top"] < 40 or z["bottom"] > seite.height - 40:
                    continue    # Kopf, Fuß und Seitenzahl sind keine Antwortstellen.
                if max((float(c["size"]) for c in z["chars"]), default=0) < 9:
                    continue    # Kleine Quellenzeilen und Bildnachweise sind keine fachliche Erklärung.
                z = {k: z[k] for k in ("text", "x0", "x1", "top", "bottom")}
                if zeilen and z["top"] < zeilen[-1]["bottom"] - 1:
                    # Tief-/hochgestellte Formelteile werden oft als eigene überlappende Zeile gelesen.
                    alt = zeilen[-1]
                    alt.update(text=alt["text"] + " " + z["text"], x0=min(alt["x0"], z["x0"]),
                               x1=max(alt["x1"], z["x1"]), bottom=max(alt["bottom"], z["bottom"]))
                else:
                    zeilen.append(z)
            self.seiten[n] = (float(seite.width), float(seite.height), zeilen)
            seite.close()     # Die umfangreichen Zeichen-Caches pro Seite nicht im Speicher behalten.
        return self.seiten[n]

    def blöcke(self, titel):
        if titel in self.blockcache:
            return self.blockcache[titel]
        i = next((i for i, a in enumerate(self.abschnitte) if a[0] == titel), None)
        if i is None:
            return []
        _, anfang, oben = self.abschnitte[i]
        nr = re.match(r"(?:TM[12] )?\d+(?:\.\d+)*", titel)
        ende, unten = len(self.pdf.pages), float("inf")
        for t, p, y in self.abschnitte[i + 1:]:
            if nr and t.startswith(nr[0] + "."):
                continue     # Bei einem Oberabschnitt auch dessen Unterabschnitte durchsuchen.
            ende, unten = p, y
            break
        titeltexte = {suchtext(t) for t, _, _ in self.abschnitte}
        blöcke = []
        for p in range(anfang, ende + 1):
            w, h, zeilen = self.zeilen(p)
            block = []

            def ablegen():
                if block:
                    text = " ".join(z["text"] for z in block)
                    blöcke.append({"p": p, "w": w, "h": h, "z": block.copy(), "text": text,
                                   "wörter": suchwörter(text)})
                    block.clear()

            for z in zeilen:
                if (p == anfang and z["top"] < oben) or (p == ende and z["top"] >= unten):
                    continue
                normal = suchtext(z["text"])
                if normal in titeltexte or z["text"].startswith(("Grundlage:", "Zurück zur Kapitelübersicht", "↑")):
                    ablegen()
                    continue
                if block:
                    vorher = block[-1]
                    abstand = z["top"] - vorher["bottom"]
                    if (abstand > 4 or len(block) >= 6 or
                        (abstand > .8 and vorher["x1"] < w * .8 and z["x0"] < w * .16) or
                        abs(z["x0"] - vorher["x0"]) > w * .2):
                        ablegen()
                block.append(z)
            ablegen()
        self.blockcache[titel] = blöcke
        return blöcke

    def verweis(self, treffer, frage, antwort):
        quelle = {"t": treffer[0], "p": treffer[1]}
        blöcke = self.blöcke(treffer[0])
        if not blöcke:
            return quelle
        a, f = suchwörter(antwort), suchwörter(frage)
        häufigkeit = Counter(w for b in blöcke for w in b["wörter"])
        gewichte = {w: (2 if w in a else 1) * (1 + math.log(1 + len(blöcke) / (1 + häufigkeit[w])))
                    for w in a.keys() | f.keys()}

        def bewerten(b):
            wörter = b["wörter"]
            # Auch Komposita erkennen, etwa „Bauteilfunktion“ ↔ „Funktion“. Exakte Wörter bleiben stärker.
            punkte = sum(g * min(wörter[w] or (.35 if len(w) >= 6 and any(
                len(k) >= 6 and (w in k or k in w) for k in wörter) else 0), 2) for w, g in gewichte.items())
            # Längere gemeinsame Wortfolgen sind stärker als bloß gleiche Kapitelbegriffe.
            text = re.sub(r"\s+", " ", suchtext(b["text"]))
            for teil in re.split(r"[.!?;\n]", suchtext(antwort)):
                teil = teil.strip(" *-$")
                if len(teil.split()) >= 5 and teil in text:
                    punkte += 15
            return punkte / (1 + .035 * len(wörter))

        index = max(range(len(blöcke)), key=lambda i: bewerten(blöcke[i]))
        if bewerten(blöcke[index]) <= 0:
            return quelle     # Keine unpassende Stelle als vermeintliche Antwort markieren.
        auswahl = [blöcke[index]]
        def formelblock(b):
            return (len(b["z"]) <= 3 and len(b["wörter"]) <= 6 and
                    min(z["x0"] for z in b["z"]) > b["w"] * .22 and re.search(r"[=∑∫]", b["text"]))

        # Die angrenzende abgesetzte Formel mitnehmen: Bei Rechenaufgaben soll neben der
        # anschaulichen Erklärung auch der zugehörige mathematische Ansatz erkennbar sein.
        if index + 1 < len(blöcke):
            b, danach = blöcke[index], blöcke[index + 1]
            if ((b["text"].rstrip().endswith(":") or formelblock(danach)) and danach["p"] == b["p"] and
                danach["z"][0]["top"] - b["z"][-1]["bottom"] < 25):
                auswahl.append(danach)
        if index:
            b, davor = blöcke[index], blöcke[index - 1]
            if (formelblock(davor) and davor["p"] == b["p"] and
                b["z"][0]["top"] - davor["z"][-1]["bottom"] < 20):
                auswahl.insert(0, davor)
        quelle["p"] = auswahl[0]["p"]
        quelle["h"] = [{"p": b["p"], "r": [[round(z["x0"] / b["w"], 5),
                           round(z["top"] / b["h"], 5), round((z["x1"] - z["x0"]) / b["w"], 5),
                           round((z["bottom"] - z["top"]) / b["h"], 5)] for z in b["z"]]} for b in auswahl]
        return quelle


def bildunterschriften(typ):
    """Bildunterschriften aus #bild("name", [Text]) im Lernskript, ohne Typst-Befehle."""
    out = {}
    for m in re.finditer(r'#bild\("([^"]+)",\s*\[(.*?)\](?:,|\))', typ.read_text(encoding="utf-8")):
        t = re.sub(r"#[a-z.]+(\([^)]*\))?", "", m.group(2))
        t = re.sub(r"\$([^$]*)\$", lambda x: x.group(1).replace(" thin ", " ").replace('"', ""), t)
        out.setdefault(m.group(1), re.sub(r"[*_]", "", t).strip())
    return out


def page_count(pdf):
    return len(re.findall(rb"/Type\s*/Page[^s]", pdf.read_bytes()))


FORMELN = {}   # Platzhalter-Schlüssel → (Typst-Quelltext, abgesetzt?)


def formel(quelle, abgesetzt=False):
    """Formel zum Setzen vormerken und einen Platzhalter zurückgeben (wird nach dem Setzen ersetzt)."""
    schlüssel = hashlib.sha1(f"{abgesetzt}|{quelle}".encode()).hexdigest()[:12]
    FORMELN[schlüssel] = (quelle, abgesetzt)
    return f"@@F{schlüssel}@@"


SCHRIFT = 9.6   # pt, die einer Schrifthöhe auf der Webseite entsprechen (Formelschrift wirkt kleiner als Inter)
FORMEL_KOPF = """#set page(width: auto, height: auto, margin: (x: 0.6pt, y: 1.2pt), fill: none)
#set text(font: "Libertinus Serif", size: 11pt, lang: "de", fill: rgb("#1f2328"), top-edge: "bounds", bottom-edge: "bounds")
#let stütze = box(width: 0pt, hide[$($])
"""


def formeln_setzen(seite):
    """Alle vorgemerkten Formeln mit Typst als SVG setzen und die Platzhalter in seite ersetzen."""
    if not FORMELN:
        return seite
    ziel = OUT / "f"
    ziel.mkdir(parents=True, exist_ok=True)
    tmp = OUT / "_formeln"
    tmp.mkdir(exist_ok=True)
    schlüssel = list(FORMELN)
    zeile = lambda k: (f"$ {FORMELN[k][0]} $" if FORMELN[k][1] else f"#stütze#box(${FORMELN[k][0]}$)")

    def setzen(liste, name):
        (tmp / f"{name}.typ").write_text(FORMEL_KOPF + "\n#pagebreak()\n".join(zeile(k) for k in liste), encoding="utf-8")
        r = subprocess.run(["typst", "compile", str(tmp / f"{name}.typ"), str(tmp / (name + "-{p}.svg"))],
                           capture_output=True, text=True)
        return r.returncode == 0

    fertig = {}
    if setzen(schlüssel, "alle"):
        fertig = {k: tmp / f"alle-{i}.svg" for i, k in enumerate(schlüssel, 1)}
    else:   # einzeln setzen, damit eine fehlerhafte Formel nicht alle anderen mitnimmt
        for k in schlüssel:
            if setzen([k], k):
                fertig[k] = tmp / f"{k}-1.svg"
            else:
                print(f"::warning title=Formel fehlerhaft::${FORMELN[k][0]}$", file=sys.stderr)
    for k, (quelle, abgesetzt) in FORMELN.items():
        alt = html.escape(quelle)
        if k in fertig:
            svg = fertig[k].read_text(encoding="utf-8")
            höhe = float(re.search(r'height="([\d.]+)pt"', svg).group(1))
            (ziel / f"{k}.svg").write_text(svg, encoding="utf-8")
            img = f'<img class="formel" src="f/{k}.svg" alt="{alt}" style="height:{höhe / SCHRIFT:.3f}em">'
            ersatz = f'<span class="formel-block">{img}</span>' if abgesetzt else img
        else:
            ersatz = f"<code>{alt}</code>"
        seite = seite.replace(f"@@F{k}@@", json.dumps(ersatz, ensure_ascii=False)[1:-1].replace("</", "<\\/"))
    shutil.rmtree(tmp)
    return seite


def inline(text):
    """**fett**, *kursiv*, `Code` und $Formeln$ in HTML umwandeln (alles andere wird maskiert)."""
    text = re.sub(r"\$([^$\n]+)\$", lambda m: formel(m.group(1).strip()), text)
    t = html.escape(text, quote=False)
    t = re.sub(r"\*\*(.+?)\*\*", r"<strong>\1</strong>", t)
    t = re.sub(r"(?<![*\w])\*(?!\s)(.+?)(?<!\s)\*(?![*\w])", r"<em>\1</em>", t)
    return re.sub(r"`(.+?)`", r"<code>\1</code>", t)


def antwort_html(zeilen):
    """Absätze (Leerzeile), Listen (- …) und eine Merkbild-Zeile (Bild: …) in HTML umwandeln."""
    teile, absatz, liste, bild = [], [], [], []

    def leeren():
        if absatz:
            teile.append(f"<p>{inline(' '.join(absatz))}</p>")
            absatz.clear()
        if liste:
            teile.append("<ul>" + "".join(f"<li>{inline(x)}</li>" for x in liste) + "</ul>")
            liste.clear()

    for z in zeilen:
        z = z.strip()
        if not z:
            leeren()
        elif re.fullmatch(r"\$\s.*\s\$", z):    # $ … $ allein in der Zeile: abgesetzte Formel
            leeren()
            teile.append(formel(z[1:-1].strip(), abgesetzt=True))
        elif re.match(r"^Bild:\s*", z):
            leeren()
            bild.append(re.sub(r"^Bild:\s*", "", z))
        elif re.match(r"^[-•]\s+", z):
            if absatz:
                leeren()
            liste.append(re.sub(r"^[-•]\s+", "", z))
        elif liste and not absatz:
            liste[-1] += " " + z
        else:
            absatz.append(z)
    leeren()
    return "".join(teile), inline(" ".join(bild)) if bild else ""


def karteikarten(md, modul, abschnitte=(), skript=None, stellen=None):
    """Karteikarten.md lesen: ## Kapitel, ### Frage, darunter die Antwort (mit Quelle: und Abbildung:)."""
    karten, kapitel, karte = [], "", None
    ordner = md.parent / "Typst-Dateien" / "abbildungen"
    unterschriften = bildunterschriften(md.parent / "Typst-Dateien" / "main.typ")
    ziel = OUT / "img" / re.sub(r"[^A-Za-z0-9.-]+", "_", modul.translate(UMLAUTE))
    warnen = lambda titel, text: print(f"::warning title={titel}::{modul}: {text}", file=sys.stderr)

    def abschließen():
        if not karte or not karte["q"]:
            return
        zeilen, quelle, bilder = [], None, []
        for z in karte.pop("zeilen"):
            if m := re.match(r"^Quelle:\s*(.+)$", z.strip()):
                quelle = m.group(1).strip()
            elif m := re.match(r"^Abbildung:\s*(.+)$", z.strip()):
                bilder += [x.strip() for x in m.group(1).split(",") if x.strip()]
            else:
                zeilen.append(z)
        a, bild = antwort_html(zeilen)
        if not a:
            warnen("Karteikarte ohne Antwort", karte["q"])
            return
        karte.update(a=a, b=bild)
        if quelle:
            treffer = abschnitt_finden(quelle, abschnitte)
            if treffer:
                karte["s"] = (stellen.verweis(treffer, karte["q"], "\n".join(z for z in zeilen if not z.startswith("Bild:")))
                              if stellen else {"t": treffer[0], "p": treffer[1]})
            elif abschnitte:
                warnen("Quelle nicht im Lernskript", f"{quelle} ({karte['q']})")
        for name in bilder:
            datei = next(iter(sorted(ordner.glob(name + ".*"))), None) if ordner.is_dir() else None
            if not datei:
                warnen("Abbildung fehlt", f"{name} ({karte['q']})")
                continue
            ziel.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(datei, ziel / datei.name)
            karte.setdefault("i", []).append({"src": f"img/{ziel.name}/{datei.name}",
                                              "cap": inline(unterschriften.get(name, ""))})
        karten.append(karte)

    for z in md.read_text(encoding="utf-8").splitlines():
        if z.startswith("### "):
            abschließen()
            frage = z[4:].strip()
            # Die ID hängt nur am Fragetext: solange er gleich bleibt, bleibt der Lernfortschritt erhalten.
            karte = {"id": hashlib.sha1(f"{modul}|{frage}".encode()).hexdigest()[:10],
                     "k": kapitel, "q": inline(frage), "zeilen": []}
        elif z.startswith("## "):
            abschließen()
            karte, kapitel = None, z[3:].strip()
        elif karte is not None:
            karte["zeilen"].append(z)
    abschließen()
    return karten


# ───────────── Aufgaben (Reiter „Lernen“) ─────────────
# Quelle: skripte/<Modul>/Lernskript aktuell/Typst-Dateien/Aufgaben.typ (Aufbau steht im Kopf der Datei).
# Für die Webseite wird die Datei mit --input web=1 gesetzt: jede Seite ist ein Baustein (Aufgabe, Tipp,
# Ergebnis, Lösungsschritte) und wird als SVG eingebunden. Daneben entsteht eine PDF mit allen Lösungen.
AUFGABE_BREITE = 140 * 72 / 25.4   # Seitenbreite in pt (muss zu 140mm im Kopf von Aufgaben.typ passen)


def svg_größe(datei):
    kopf = datei.read_text(encoding="utf-8")[:400]
    b = re.search(r'width="([\d.]+)pt"', kopf)
    h = re.search(r'height="([\d.]+)pt"', kopf)
    return float(b.group(1)) if b else AUFGABE_BREITE, float(h.group(1)) if h else 0


def aufgaben(typ, modul, abschnitte, stellen=None):
    warnen = lambda titel, text: print(f"::warning title={titel}::{modul}: {text}", file=sys.stderr)
    r = subprocess.run(["typst", "query", "--root", str(typ.parent), "--input", "web=1", str(typ), "<aufgabe>",
                        "--field", "value"], capture_output=True, text=True)
    if r.returncode != 0:
        print(r.stderr, file=sys.stderr)
        print(f"::error title=Aufgaben fehlerhaft::{modul}: Aufgaben.typ lässt sich nicht setzen", file=sys.stderr)
        return None
    infos = json.loads(r.stdout)
    slug = re.sub(r"[^A-Za-z0-9.-]+", "_", modul.translate(UMLAUTE))
    ziel = OUT / "a" / slug
    ziel.mkdir(parents=True, exist_ok=True)
    r = subprocess.run(["typst", "compile", "--root", str(typ.parent), "--input", "web=1", str(typ),
                        str(ziel / "{p}.svg")], capture_output=True, text=True)
    if r.returncode != 0:
        print(r.stderr, file=sys.stderr)
        print(f"::error title=Aufgaben fehlerhaft::{modul}: Aufgaben.typ lässt sich nicht setzen", file=sys.stderr)
        return None
    seiten = sorted(ziel.glob("*.svg"), key=lambda p: int(p.stem))
    erwartet = sum(1 + i["schritte"] + i["tipp"] + i["ergebnis"] for i in infos)
    if len(seiten) != erwartet:
        print(f"::error title=Aufgaben fehlerhaft::{modul}: {len(seiten)} Seiten statt {erwartet} – steht etwas außerhalb von #aufgabe?",
              file=sys.stderr)
        return None
    pdf = OUT / "pdf" / f"{slug}_Aufgaben.pdf"
    subprocess.run(["typst", "compile", "--root", str(typ.parent), str(typ), str(pdf)], capture_output=True)

    texte = []
    if stellen:
        # Die SVGs enthalten Schrift als Pfade. Dieselben Bausteine einmal als temporäre PDF setzen,
        # damit auch Rechenwege und Verständnisantworten (nicht nur Aufgabentitel) zugeordnet werden.
        import pdfplumber
        textpdf = ziel / "_text.pdf"
        subprocess.run(["typst", "compile", "--root", str(typ.parent), "--input", "web=1", str(typ), str(textpdf)],
                       capture_output=True, check=True)
        try:
            with pdfplumber.open(textpdf) as dokument:
                for seite in dokument.pages:
                    texte.append(seite.extract_text() or "")
                    seite.close()
            if len(texte) != erwartet:
                raise ValueError(f"{modul}: Textbausteine für die Skriptmarkierungen stimmen nicht überein")
        finally:
            textpdf.unlink(missing_ok=True)

    def baustein(n):
        b, h = svg_größe(seiten[n])
        return {"src": f"a/{slug}/{seiten[n].name}", "w": round(b, 1), "h": round(h, 1)}

    liste, n, ids = [], 0, set()
    for info in infos:
        anfang = n
        id_ = hashlib.sha1(f"{modul}|{info['titel']}".encode()).hexdigest()[:10]
        if id_ in ids:
            warnen("Aufgabentitel doppelt", info["titel"])
        ids.add(id_)
        a = {"id": id_, "t": info["titel"], "art": info["art"], "k": info["kapitel"], "a": baustein(n)}
        n += 1
        if info["tipp"]:
            a["tipp"] = baustein(n); n += 1
        if info["ergebnis"]:
            a["erg"] = baustein(n); n += 1
        a["s"] = [baustein(n + i) for i in range(info["schritte"])]
        n += info["schritte"]
        if info.get("minuten"):
            a["min"] = info["minuten"]
        if info.get("quelle"):
            treffer = abschnitt_finden(str(info["quelle"]), abschnitte)
            if treffer:
                a["q"] = (stellen.verweis(treffer, info["titel"] + " " + texte[anfang], "\n".join(texte[anfang + 1:n]))
                          if stellen else {"t": treffer[0], "p": treffer[1]})
            elif abschnitte:
                warnen("Quelle nicht im Lernskript", f"{info['quelle']} ({info['titel']})")
        liste.append(a)
    return {"pdf": f"pdf/{pdf.name}" if pdf.exists() else "", "items": liste}


# ───────────── Quiz ─────────────
# Quelle: skripte/<Modul>/Lernskript aktuell/Quiz.md (Aufbau steht am Kopf jeder Datei).
SCHLÜSSEL = re.compile(r"^(Tipp|Quelle|Antwort|Erklärung):\s*(.*)$")


def quiz(md, modul, abschnitte, stellen=None):
    warnen = lambda titel, text: print(f"::warning title={titel}::{modul}: {text}", file=sys.stderr)
    fragen, kapitel, f = [], "", None
    text = re.sub(r"<!--.*?-->", "", md.read_text(encoding="utf-8"), flags=re.S)

    def abschließen():
        if not f:
            return
        z = f.pop("zeilen")
        opts, felder, feld = [], {}, None
        for zeile in z:
            s = zeile.strip()
            if m := re.match(r"^[-*]\s+\[( |x|X)\]\s+(.*)$", s):
                opts.append({"t": m.group(2), "ok": m.group(1) != " ", "e": []}); feld = "opt"
            elif s.startswith(">") and opts and feld == "opt":
                opts[-1]["e"].append(s[1:].strip())
            elif m := SCHLÜSSEL.match(s):
                feld = m.group(1); felder[feld] = [m.group(2)] if m.group(2) else []
            elif s and feld in ("Antwort", "Erklärung", "Tipp"):
                felder[feld].append(zeile)
            elif s and feld == "opt":
                opts[-1]["t"] += " " + s
            elif not s and feld in ("Antwort", "Erklärung", "Tipp"):
                felder[feld].append("")
        frage = f["roh"]
        if opts:
            richtig = sum(o["ok"] for o in opts)
            if not richtig:
                return warnen("Quizfrage ohne richtige Antwort", frage)
            f["typ"] = "einfach" if richtig == 1 else "mehrfach"
            f["o"] = [{"t": inline(o["t"]), "ok": o["ok"], "e": inline(" ".join(o["e"]))} for o in opts]
        elif "___" in frage:
            if "Antwort" not in felder:
                return warnen("Lückenfrage ohne Antwort", frage)
            f["typ"] = "lücke"
            f["ok"] = [x.strip() for x in " ".join(felder["Antwort"]).split("|") if x.strip()]
        elif "Antwort" in felder:
            f["typ"] = "frei"
            f["muster"] = antwort_html(felder["Antwort"])[0]
        else:
            return warnen("Quizfrage ohne Antwort", frage)
        teile = frage.split("___")
        f["q"] = inline(teile[0]) if len(teile) == 1 else [inline(t) for t in teile]
        if "Tipp" in felder:
            f["tipp"] = antwort_html(felder["Tipp"])[0]
        if "Erklärung" in felder:
            f["erkl"] = antwort_html(felder["Erklärung"])[0]
        if "Quelle" in felder:
            ref = " ".join(felder["Quelle"]).strip()
            treffer = abschnitt_finden(ref, abschnitte)
            if treffer:
                antwort = " ".join(felder.get("Antwort", []) + felder.get("Erklärung", []) +
                                   [o["t"] + " " + " ".join(o["e"]) for o in opts if o["ok"]])
                f["s"] = (stellen.verweis(treffer, frage, antwort)
                          if stellen else {"t": treffer[0], "p": treffer[1]})
            elif abschnitte:
                warnen("Quelle nicht im Lernskript", f"{ref} ({frage})")
        fragen.append(f)

    for z in text.splitlines():
        if z.startswith("### "):
            abschließen()
            roh = z[4:].strip()
            f = {"id": hashlib.sha1(f"{modul}|{roh}".encode()).hexdigest()[:10], "k": kapitel, "roh": roh, "zeilen": []}
        elif z.startswith("## "):
            abschließen()
            f, kapitel = None, z[3:].strip()
        elif f is not None:
            f["zeilen"].append(z)
    abschließen()
    for x in fragen:
        x.pop("roh", None)
    return fragen


# ───────────── Vorlesungsplan ─────────────
# Quelle: Vorlesungsplan.pdf (Export aus thabella, eine Woche je Seite). Gelesen werden die farbigen
# Kästchen: Lage = Tag und Uhrzeit, Farbe = Art (Legende), Text = Fach, Dozent, Raum.
PLAN_PDF = ROOT / "Vorlesungsplan.pdf"
# Fach im Plan → Modul der Webseite (erste passende Zeile gewinnt; None = kein Modul der Seite).
PLAN_MODULE = [("Praktikum Physik", None), ("Elektrotechnik", "GET"), ("Fluid", "FET"),
               ("Finanzierung", "Finanzierung"), ("Investitionsrechnung", "Investitionsrechnung"),
               ("Konstruktion", "Konstruktion"), ("Physik", "Physik"), ("Mechanik", "technische Mechanik")]
PLAN_ARTEN = {(0.671, 0.804, 0.937): "Vorlesung", (1.0, 0.827, 0.278): "Besprechung", (0.663, 0.855, 0.455): "Übung",
              (0.980, 0.714, 0.447): "Hybrid", (0.929, 0.498, 0.518): "Praktikum", (1.0, 0.396, 0.698): "Prüfung",
              (0.933, 0.961, 0.988): "Online", (0.749, 0.584, 0.875): "Sonstiges"}
TAGE = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"]


def stundenplan():
    if not PLAN_PDF.exists():
        return None
    try:
        import pdfplumber
    except ImportError:
        print("::warning title=Vorlesungsplan::pdfplumber fehlt, Plan wird übersprungen", file=sys.stderr)
        return None
    termine, hinweise, gesehen = [], {}, set()
    with pdfplumber.open(PLAN_PDF) as pdf:
        for seite in pdf.pages:
            wörter = seite.extract_words(use_text_flow=True)   # Reihenfolge wie gedruckt: übereinanderliegende Kästchen bleiben getrennt
            zr = re.search(r"Zeitraum:\s*(\d\d)\.(\d\d)\.(\d{4})", " ".join(w["text"] for w in wörter))
            if not zr:
                continue
            montag = date(int(zr.group(3)), int(zr.group(2)), int(zr.group(1)))
            köpfe = sorted((w for w in wörter if w["text"] in TAGE and w["top"] < 90), key=lambda w: w["x0"])
            if len(köpfe) != 7:
                continue
            kopf_y = köpfe[0]["top"]
            spalten = [k["x0"] - 6 for k in köpfe] + [seite.width]
            spalte = lambda x: next((i for i in range(7) if spalten[i] <= x < spalten[i + 1]), None)
            zeiten = sorted((w["top"], int(w["text"][:2]) * 60 + int(w["text"][3:5])) for w in wörter
                            if w["x0"] < 55 and re.fullmatch(r"\d\d\.\d\d", w["text"]))
            if len(zeiten) < 2:
                continue
            # Uhrzeit aus der Höhe: zwischen den Zeitmarken links linear, Kästchen beginnen ~2pt über der Marke
            # und enden ~7pt unter der Endmarke.
            def uhrzeit(y):
                for (y0, t0), (y1, t1) in zip(zeiten, zeiten[1:]):
                    if y <= y1 or (y1, t1) == zeiten[-1]:
                        t = t0 + (y - y0) * (t1 - t0) / (y1 - y0)
                        t = int(round(t / 5) * 5)
                        return f"{t // 60:02d}:{t % 60:02d}"
            # Hinweise im Tageskopf (Feiertag, vorlesungsfrei, Beginn/Ende der Vorlesungszeit). Ein Hinweis kann
            # über die nächste Spalte hinauslaufen: zusammenhängende Wörter gehören zum Tag des ersten Worts.
            kopfzeile = sorted((w for w in wörter if kopf_y + 6 < w["top"] < zeiten[0][0] - 3), key=lambda w: (round(w["top"]), w["x0"]))
            for j, w in enumerate(kopfzeile):
                v = kopfzeile[j - 1] if j else None
                if v and round(v["top"]) == round(w["top"]) and w["x0"] - v["x1"] < 8:
                    w["tag"] = v["tag"]
                elif (i := spalte(w["x0"])) is not None:
                    w["tag"] = (montag + timedelta(days=i)).isoformat()
                else:
                    w["tag"] = None
                if w["tag"]:
                    hinweise.setdefault(w["tag"], []).append(w)
            for r in seite.rects:
                farbe = r.get("non_stroking_color")
                if not isinstance(farbe, (tuple, list)) or len(farbe) != 3:
                    continue
                art = next((a for f, a in PLAN_ARTEN.items() if all(abs(x - y) < 0.01 for x, y in zip(farbe, f))), None)
                if not art or r["top"] < zeiten[0][0] - 5 or r["top"] > zeiten[-1][0] + 15:   # darunter: Legende
                    continue
                i = spalte(r["x0"] + 3)
                if i is None:
                    continue
                # Zeilen in Druckreihenfolge; nach der Raumzeile (WIW-…) beginnt ein anderes, überlappendes Kästchen.
                text, oben = [], None
                for w in wörter:
                    if r["x0"] - 1 <= w["x0"] and w["x1"] <= r["x1"] + 1 and r["top"] - 1 <= w["top"] and w["bottom"] <= r["bottom"] + 1:
                        if text and round(w["top"]) == oben:
                            text[-1] += " " + w["text"]
                        elif text and text[-1].startswith("WIW-"):
                            break
                        else:
                            text.append(w["text"]); oben = round(w["top"])
                if not text:
                    continue
                tag = (montag + timedelta(days=i)).isoformat()
                von, bis = uhrzeit(r["top"] + 2), uhrzeit(r["bottom"] - 7)
                raum = next((t for t in text if re.match(r"^WIW-\d", t)), "")
                rest = [t for t in text if t != raum]
                # Titel kann zweizeilig sein; die Zeile mit „Nachname, Vorname“ ist der Dozent.
                doz_i = next((k for k, t in enumerate(rest) if re.fullmatch(r"[\wäöüÄÖÜß-]+, [\wäöüÄÖÜß-]+", t)), len(rest))
                titel = " ".join(rest[:doz_i]) or " ".join(rest)
                doz = rest[doz_i] if doz_i < len(rest) else ""
                schlüssel = (tag, von, titel, doz)
                if schlüssel in gesehen:
                    continue
                gesehen.add(schlüssel)
                modul = next((m for k, m in PLAN_MODULE if k.lower() in titel.lower()), None)
                termine.append({"d": tag, "von": von, "bis": bis, "t": titel, "m": modul, "art": art,
                                "raum": raum.split(":", 1)[-1].strip() if raum else "", "doz": doz})
    tage = {}
    for tag, ws in hinweise.items():
        zeilen = {}
        for w in ws:
            zeilen.setdefault(round(w["top"]), []).append(w["text"])
        tage[tag] = " · ".join(" ".join(v) for _, v in sorted(zeilen.items()))
    termine.sort(key=lambda t: (t["d"], t["von"]))
    print(f"→ Vorlesungsplan: {len(termine)} Termine, {len(tage)} Tage mit Hinweis")
    return {"termine": termine, "tage": tage, "stand": datetime.fromtimestamp(PLAN_PDF.stat().st_mtime, BERLIN).date().isoformat()}


def baustand():
    """Zeitpunkt des Builds und letzte Änderung (für die Zeile „Stand der Seite“ unten auf der Seite)."""
    jetzt = datetime.now(ZoneInfo("Europe/Berlin"))
    r = subprocess.run(["git", "log", "-1", "--format=%s"], capture_output=True, text=True)
    return {"zeit": jetzt.strftime("%d.%m.%Y, %H:%M"), "was": r.stdout.strip()[:100] if r.returncode == 0 else ""}


def hoerkapitel(titel):
    """Stabile Kapitelkennung, auch für die getrennten TM1-/TM2-Kapitel."""
    m = re.match(r"^((?:TM[12] )?Kapitel \d+)\b", titel)
    return m.group(1) if m else None


def hoerskript_lesen(md, modul, skriptstand, abschnitte):
    """Redaktionellen Hörtext lesen; Denkpausen bleiben Frage/Auflösung-Paare."""
    if not md.exists():
        raise ValueError(f"{modul}: {md.name} fehlt; Hörfassung zusammen mit dem Lernskript pflegen")
    text = re.sub(r"<!--.*?-->", "", md.read_text(encoding="utf-8"), flags=re.S)
    meta, kapitel, aktuell, pause, bereich, puffer = {}, [], None, None, None, []

    def absatz():
        if not puffer:
            return
        s = " ".join(puffer).strip()
        puffer.clear()
        if "$" in s or re.search(r"#(?:let|form|bild)\b|\\(?:frac|sqrt)\b", s):
            raise ValueError(f"{modul}: Formeln im Hörtext in gesprochene Worte übersetzen: {s[:90]}")
        if bereich:
            pause[bereich].append(s)
        elif aktuell is not None:
            aktuell["blocks"].append({"type": "paragraph", "text": s})
        else:
            raise ValueError(f"{modul}: Text vor dem ersten Kapitel in {md.name}")

    for zeile in text.splitlines():
        z = zeile.strip()
        if z.startswith("## "):
            absatz()
            aktuell = {"id": f"kap-{len(kapitel)}", "title": z[3:], "blocks": [], "refs": []}
            kapitel.append(aktuell)
            pause, bereich = None, None
        elif z.startswith("### "):
            absatz()
            if aktuell is None:
                raise ValueError(f"{modul}: Zwischenüberschrift ohne Kapitel")
            titel = z[4:]
            if titel == "Denkpause":
                pause = {"type": "pause", "question": [], "answer": []}
                aktuell["blocks"].append(pause)
                bereich = "question"
            elif titel == "Auflösung":
                if pause is None or bereich != "question":
                    raise ValueError(f"{modul}: Auflösung ohne unmittelbar vorangehende Denkpause")
                bereich = "answer"
            else:
                pause, bereich = None, None
                aktuell["blocks"].append({"type": "heading", "text": titel})
        elif z.startswith("# "):
            if kapitel or "title" in meta:
                raise ValueError(f"{modul}: Genau ein Titel vor dem ersten Kapitel ist erforderlich")
            meta["title"] = z[2:]
        elif m := re.match(r"^(Stand|Skriptstand):\s*(.+)$", z):
            if aktuell is not None:
                raise ValueError(f"{modul}: Datumsfelder gehören vor die Kapitel")
            meta[m.group(1)] = datetime.strptime(m.group(2), "%d.%m.%Y").date()
        elif z.startswith("Quelle:"):
            absatz()
            if aktuell is None:
                raise ValueError(f"{modul}: Quellenangabe ohne Kapitel")
            aktuell["refs"] += [r.strip() for r in z[7:].split(",") if r.strip()]
        elif not z:
            absatz()
        else:
            puffer.append(z)
    absatz()
    if not all(k in meta for k in ("title", "Stand", "Skriptstand")):
        raise ValueError(f"{modul}: Titel, Stand oder Skriptstand fehlt in {md.name}")
    if meta["Skriptstand"] != skriptstand:
        raise ValueError(f"{modul}: Hörfassung mit Skriptstand {skriptstand:%d.%m.%Y} abgleichen und Skriptstand aktualisieren")
    erwartet = [hoerkapitel(t) for t, _ in abschnitte if hoerkapitel(t)]
    vorhanden = [hoerkapitel(k["title"]) for k in kapitel if hoerkapitel(k["title"])]
    if vorhanden != erwartet:
        raise ValueError(f"{modul}: Hörkapitel passen nicht zur Skriptgliederung: {vorhanden!r} statt {erwartet!r}")
    if not kapitel or hoerkapitel(kapitel[0]["title"]):
        raise ValueError(f"{modul}: Der Modulüberblick muss vor den Hörkapiteln stehen")
    for k in kapitel:
        if not k["blocks"]:
            raise ValueError(f"{modul}: Leeres Hörkapitel {k['title']}")
        pausen = [b for b in k["blocks"] if b["type"] == "pause"]
        if hoerkapitel(k["title"]) and (not pausen or not k["refs"]):
            raise ValueError(f"{modul}: {k['title']} braucht Denkpause mit Auflösung und Abschnittsquellen")
        for b in pausen:
            if not b["question"] or not b["answer"]:
                raise ValueError(f"{modul}: Unvollständige Denkpause in {k['title']}")
        k["sources"] = []
        for ref in k.pop("refs"):
            treffer = abschnitt_finden(ref, abschnitte)
            if not treffer:
                raise ValueError(f"{modul}: Hörtext-Quelle {ref!r} nicht im Lernskript gefunden")
            k["sources"].append({"t": treffer[0], "p": treffer[1]})
    return meta, kapitel


def hoerfassung(md, modul, skriptstand, abschnitte):
    """EPUB 3 ohne Bilder, Skripte oder Formelsatz: geeignet zum Vorlesen."""
    meta, kapitel = hoerskript_lesen(md, modul, skriptstand, abschnitte)
    name = f"{modul} Hörzusammenfassung Stand {meta['Stand']:%d.%m.%Y}"
    ziel = OUT / "epub"
    ziel.mkdir(parents=True, exist_ok=True)
    datei = ziel / (re.sub(r"[^A-Za-z0-9.-]+", "_", name.translate(UMLAUTE)) + ".epub")
    esc = html.escape
    pause_text = "Halte die Wiedergabe jetzt kurz an. Erkläre Deine Antwort in eigenen Worten. Wenn Du bereit bist, höre die Auflösung an."

    def dokument(titel, body):
        return ('<?xml version="1.0" encoding="UTF-8"?>\n<!DOCTYPE html>\n'
                '<html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops" '
                'lang="de-DE" xml:lang="de-DE"><head><meta charset="utf-8"/>'
                f'<title>{esc(titel)}</title><link rel="stylesheet" href="style.css"/></head><body>{body}</body></html>')

    dateien, manifest, spine = {}, [], []
    for i, k in enumerate(kapitel):
        body = f'<h1>{esc(k["title"])}</h1>'
        if i == 0:
            body += (f'<p>{esc(modul)}. Feynman-Hörzusammenfassung. Stand {meta["Stand"]:%d.%m.%Y}.</p>'
                     '<p>Diese Hörfassung erklärt den Stoff in Worten. Bei jeder Denkpause hältst Du selbst kurz an '
                     'und erklärst den Gedanken, bevor Du die Auflösung hörst. Formeln, genaue Zeichnungen und '
                     'sämtliche Originalquellen findest Du im Lernskript.</p>')
        for b in k["blocks"]:
            if b["type"] == "heading":
                body += f'<h2>{esc(b["text"])}</h2>'
            elif b["type"] == "paragraph":
                body += f'<p>{esc(b["text"])}</p>'
            else:
                body += '<section><h2>Denkpause</h2>' + ''.join(f'<p>{esc(p)}</p>' for p in b["question"])
                body += f'<p>{pause_text}</p><h2>Auflösung</h2>' + ''.join(f'<p>{esc(p)}</p>' for p in b["answer"]) + '</section>'
        pfad = f'kapitel-{i}.xhtml'
        dateien[pfad] = dokument(k["title"], body)
        manifest.append(f'<item id="k{i}" href="{pfad}" media-type="application/xhtml+xml"/>')
        spine.append(f'<itemref idref="k{i}"/>')
    nav = '<nav epub:type="toc" id="toc"><h1>Inhalt</h1><ol>'
    nav += ''.join(f'<li><a href="kapitel-{i}.xhtml">{esc(k["title"])}</a></li>' for i, k in enumerate(kapitel)) + '</ol></nav>'
    dateien["nav.xhtml"] = dokument("Inhalt", nav)
    dateien["style.css"] = 'body { line-height: 1.6; margin: 5%; } h1, h2 { line-height: 1.25; } p { margin: .8em 0; } .quelle { font-size: .85em; }'
    geändert = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
    kennung = uuid.uuid5(uuid.NAMESPACE_URL, "https://mariogotz04.github.io/studium/hoeren/" + modul)
    skriptname = f"{modul} Lernskript Stand {skriptstand:%d.%m.%Y}"
    skriptdatei = re.sub(r"[^A-Za-z0-9.-]+", "_", skriptname.translate(UMLAUTE)) + ".pdf"
    opf = ('<?xml version="1.0" encoding="UTF-8"?>'
           '<package xmlns="http://www.idpf.org/2007/opf" version="3.0" unique-identifier="buch-id" xml:lang="de-DE">'
           '<metadata xmlns:dc="http://purl.org/dc/elements/1.1/">'
           f'<dc:identifier id="buch-id">urn:uuid:{kennung}</dc:identifier><dc:title>{esc(name)}</dc:title>'
           '<dc:language>de-DE</dc:language><dc:creator>Lernplattform Studium</dc:creator>'
           f'<dc:source>https://mariogotz04.github.io/studium/pdf/{skriptdatei}</dc:source>'
           f'<meta property="dcterms:modified">{geändert}</meta></metadata><manifest>'
           '<item id="nav" href="nav.xhtml" media-type="application/xhtml+xml" properties="nav"/>'
           '<item id="stil" href="style.css" media-type="text/css"/>' + ''.join(manifest) + '</manifest><spine>'
           + ''.join(spine) + '</spine></package>')
    with zipfile.ZipFile(datei, "w") as z:
        z.writestr("mimetype", "application/epub+zip", compress_type=zipfile.ZIP_STORED)
        z.writestr("META-INF/container.xml", '<?xml version="1.0" encoding="UTF-8"?>'
                   '<container version="1.0" xmlns="urn:oasis:names:tc:opendocument:xmlns:container">'
                   '<rootfiles><rootfile full-path="EPUB/package.opf" media-type="application/oebps-package+xml"/></rootfiles></container>',
                   compress_type=zipfile.ZIP_DEFLATED)
        for pfad, inhalt in {"package.opf": opf, **dateien}.items():
            z.writestr("EPUB/" + pfad, inhalt, compress_type=zipfile.ZIP_DEFLATED)
    fragen = sum(b["type"] == "pause" for k in kapitel for b in k["blocks"])
    print(f"→ {modul}: Hörfassung mit {len(kapitel)-1} Kapiteln und {fragen} Denkpausen als EPUB")
    return {"file": f"epub/{datei.name}", "download": name + ".epub", "updated": meta["Stand"].isoformat(),
            "source_updated": skriptstand.isoformat(), "size": datei.stat().st_size, "questions": fragen, "chapters": kapitel}


def main():
    if OUT.exists():
        shutil.rmtree(OUT)
    (OUT / "pdf").mkdir(parents=True)

    modules, failed, abschnitte, stellen = [], [], {}, {}
    for typ in find_entrypoints():
        rel = typ.relative_to(SRC)
        module = rel.parts[0]
        datum = stand(typ)
        name = f"{module} Lernskript Stand {datum:%d.%m.%Y}"
        # Adresse ohne Leerzeichen/Umlaute (sonst %20 im Namen); den schönen Namen bekommt der Download.
        pdf = OUT / "pdf" / (re.sub(r"[^A-Za-z0-9.-]+", "_", name.translate(UMLAUTE)) + ".pdf")
        print(f"→ {rel}")
        result = subprocess.run(["typst", "compile", "--root", str(typ.parent), str(typ), str(pdf)],
                                capture_output=True, text=True)
        if result.returncode != 0:
            print(result.stderr, file=sys.stderr)
            failed.append(str(rel))
            continue
        abschnitte[module] = gliederung(pdf)
        titel_setzen(pdf, name)
        stellen[module] = Skriptstellen(pdf)
        modules.append({
            "name": module,
            "title": doc_title(typ),
            "file": f"pdf/{pdf.name}",
            "download": f"{name}.pdf",
            "pages": page_count(pdf),
            "size": pdf.stat().st_size,
            "updated": datum.isoformat(),
            "hoeren": hoerfassung(typ.parent.parent / "Hoerskript.md", module, datum, abschnitte[module]),
        })

    decks = []
    for md in sorted(SRC.glob("*/Lernskript aktuell/Karteikarten.md")):
        modul = md.relative_to(SRC).parts[0]
        karten = karteikarten(md, modul, abschnitte.get(modul, []), stellen=stellen.get(modul))
        print(f"→ {modul}: {len(karten)} Karteikarten, {sum(1 for k in karten if 'i' in k)} mit Abbildung, "
              f"{sum(1 for k in karten if 's' in k)} mit Seitenangabe")
        if karten:
            pdf = next((m["file"] for m in modules if m["name"] == modul), "")
            decks.append({"name": modul, "pdf": pdf, "cards": karten})

    lernen = []
    for modul in sorted({m["name"] for m in modules} | {p.relative_to(SRC).parts[0] for p in SRC.glob("*/Lernskript aktuell/*")}, key=str.lower):
        eintrag = {"name": modul, "pdf": next((m["file"] for m in modules if m["name"] == modul), "")}
        typ = SRC / modul / "Lernskript aktuell" / "Typst-Dateien" / "Aufgaben.typ"
        if typ.exists() and (a := aufgaben(typ, modul, abschnitte.get(modul, []), stellen=stellen.get(modul))):
            eintrag["aufgaben"], eintrag["apdf"] = a["items"], a["pdf"]
            print(f"→ {modul}: {len(a['items'])} Aufgaben ({sum(x['art'] == 'rechnen' for x in a['items'])} Rechenaufgaben)")
        md = SRC / modul / "Lernskript aktuell" / "Quiz.md"
        if md.exists():
            eintrag["quiz"] = quiz(md, modul, abschnitte.get(modul, []), stellen=stellen.get(modul))
            print(f"→ {modul}: {len(eintrag['quiz'])} Quizfragen")
        if "aufgaben" in eintrag or "quiz" in eintrag or any(d["name"] == modul for d in decks):
            lernen.append(eintrag)

    for index in stellen.values():
        index.schließen()

    data = sorted(modules, key=lambda m: m["name"].lower())
    decks.sort(key=lambda d: d["name"].lower())
    einsetzen = lambda x: json.dumps(x, ensure_ascii=False).replace("</", "<\\/")
    page = (TEMPLATE.read_text(encoding="utf-8")
            .replace("/*DATA*/null", einsetzen(data))
            .replace("/*KARTEN*/null", einsetzen(decks))
            .replace("/*LERNEN*/null", einsetzen(lernen))
            .replace("/*PLAN*/null", einsetzen(stundenplan()))
            .replace("/*BUILD*/null", einsetzen(baustand())))
    page = formeln_setzen(page)
    print(f"→ {len(FORMELN)} Formeln gesetzt")
    (OUT / "index.html").write_text(page, encoding="utf-8")
    (OUT / ".nojekyll").touch()

    print(f"\n{len(modules)} Lernskripte erzeugt.")
    # Ein kaputtes Skript soll die anderen nicht blockieren: Seite trotzdem bauen, Fehler im Action-Log markieren.
    for f in failed:
        print(f"::error title=Typst-Fehler::{f} konnte nicht kompiliert werden", file=sys.stderr)


if __name__ == "__main__":
    main()
