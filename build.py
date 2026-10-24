#!/usr/bin/env python3
"""Kompiliert das aktuelle Lernskript jedes Moduls zu einer PDF und baut die Webseite in _site/.

Aufbau: skripte/<Modul>/Lernskript aktuell/Typst-Dateien/main.typ (genau ein Skript je Modul).
Andere .typ-Dateien, etwa alte Stände, werden nie veröffentlicht.
"""
import json
import re
import shutil
import subprocess
import sys
import unicodedata
from datetime import date, datetime, timezone
from pathlib import Path
from zoneinfo import ZoneInfo

ROOT = Path(__file__).resolve().parent
SRC = ROOT / "skripte"
OUT = ROOT / "_site"
TEMPLATE = ROOT / "vorlage.html"
BERLIN = ZoneInfo("Europe/Berlin")


def dateiname(text):
    """Modulname für Dateinamen: Umlaute umschreiben, Leer- und Sonderzeichen zu _."""
    for a, b in {"ä": "ae", "ö": "oe", "ü": "ue", "Ä": "Ae", "Ö": "Oe", "Ü": "Ue", "ß": "ss"}.items():
        text = text.replace(a, b)
    text = unicodedata.normalize("NFKD", text).encode("ascii", "ignore").decode()
    return re.sub(r"[^A-Za-z0-9]+", "_", text).strip("_") or "Modul"


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


def page_count(pdf):
    return len(re.findall(rb"/Type\s*/Page[^s]", pdf.read_bytes()))


def main():
    if OUT.exists():
        shutil.rmtree(OUT)
    (OUT / "pdf").mkdir(parents=True)

    modules, failed = [], []
    for typ in find_entrypoints():
        rel = typ.relative_to(SRC)
        module = rel.parts[0]
        datum = stand(typ)
        name = f"{dateiname(module)}_Lernskript_Stand_{datum:%d.%m.%Y}.pdf"
        pdf = OUT / "pdf" / name
        print(f"→ {rel}")
        result = subprocess.run(["typst", "compile", "--root", str(typ.parent), str(typ), str(pdf)],
                                capture_output=True, text=True)
        if result.returncode != 0:
            print(result.stderr, file=sys.stderr)
            failed.append(str(rel))
            continue
        modules.append({
            "name": module,
            "title": doc_title(typ),
            "file": f"pdf/{name}",
            "pages": page_count(pdf),
            "size": pdf.stat().st_size,
            "updated": datum.isoformat(),
        })

    data = sorted(modules, key=lambda m: m["name"].lower())
    page = TEMPLATE.read_text(encoding="utf-8").replace(
        "/*DATA*/null", json.dumps(data, ensure_ascii=False).replace("</", "<\\/"))
    (OUT / "index.html").write_text(page, encoding="utf-8")
    (OUT / ".nojekyll").touch()

    print(f"\n{len(modules)} Lernskripte erzeugt.")
    # Ein kaputtes Skript soll die anderen nicht blockieren: Seite trotzdem bauen, Fehler im Action-Log markieren.
    for f in failed:
        print(f"::error title=Typst-Fehler::{f} konnte nicht kompiliert werden", file=sys.stderr)


if __name__ == "__main__":
    main()
