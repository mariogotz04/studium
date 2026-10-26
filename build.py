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
import re
import shutil
import subprocess
import sys
from datetime import date, datetime, timezone
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


def karteikarten(md, modul, abschnitte=(), skript=None):
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
                karte["s"] = {"t": treffer[0], "p": treffer[1]}
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


def main():
    if OUT.exists():
        shutil.rmtree(OUT)
    (OUT / "pdf").mkdir(parents=True)

    modules, failed, abschnitte = [], [], {}
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
        modules.append({
            "name": module,
            "title": doc_title(typ),
            "file": f"pdf/{pdf.name}",
            "download": f"{name}.pdf",
            "pages": page_count(pdf),
            "size": pdf.stat().st_size,
            "updated": datum.isoformat(),
        })

    decks = []
    for md in sorted(SRC.glob("*/Lernskript aktuell/Karteikarten.md")):
        modul = md.relative_to(SRC).parts[0]
        karten = karteikarten(md, modul, abschnitte.get(modul, []))
        print(f"→ {modul}: {len(karten)} Karteikarten, {sum(1 for k in karten if 'i' in k)} mit Abbildung, "
              f"{sum(1 for k in karten if 's' in k)} mit Seitenangabe")
        if karten:
            pdf = next((m["file"] for m in modules if m["name"] == modul), "")
            decks.append({"name": modul, "pdf": pdf, "cards": karten})

    data = sorted(modules, key=lambda m: m["name"].lower())
    decks.sort(key=lambda d: d["name"].lower())
    einsetzen = lambda x: json.dumps(x, ensure_ascii=False).replace("</", "<\\/")
    page = (TEMPLATE.read_text(encoding="utf-8")
            .replace("/*DATA*/null", einsetzen(data))
            .replace("/*KARTEN*/null", einsetzen(decks)))
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
