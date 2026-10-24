#!/usr/bin/env python3
"""Kompiliert alle Typst-Skripte unter skripte/ zu PDFs und baut die Webseite in _site/.

Aufbau: skripte/<Modul>/<beliebige Unterordner>/<datei>.typ
In jedem Ordner wird main.typ kompiliert; gibt es keine main.typ, wird jede .typ-Datei
des Ordners einzeln kompiliert.
"""
import json
import re
import shutil
import subprocess
import sys
import unicodedata
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parent
SRC = ROOT / "skripte"
OUT = ROOT / "_site"
TEMPLATE = ROOT / "vorlage.html"


def slug(text):
    text = unicodedata.normalize("NFKD", text.replace("ß", "ss"))
    text = text.encode("ascii", "ignore").decode()
    return re.sub(r"[^a-zA-Z0-9]+", "-", text).strip("-").lower() or "skript"


def find_entrypoints():
    entries = []
    for folder in sorted({p.parent for p in SRC.rglob("*.typ")}):
        main = folder / "main.typ"
        entries += [main] if main.exists() else sorted(folder.glob("*.typ"))
    return entries


def doc_title(typ):
    m = re.search(r'#set\s+document\([^)]*title:\s*"([^"]+)"', typ.read_text(encoding="utf-8"))
    return m.group(1) if m else (typ.parent.name if typ.stem == "main" else typ.stem)


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

    modules, failed, used = {}, [], set()
    for typ in find_entrypoints():
        rel = typ.relative_to(SRC)
        module = rel.parts[0]
        title = doc_title(typ)
        name = slug(title)
        while name in used:
            name += "-2"
        used.add(name)
        pdf = OUT / "pdf" / f"{name}.pdf"
        print(f"→ {rel}")
        result = subprocess.run(["typst", "compile", "--root", str(typ.parent), str(typ), str(pdf)],
                                capture_output=True, text=True)
        if result.returncode != 0:
            print(result.stderr, file=sys.stderr)
            failed.append(str(rel))
            continue
        modules.setdefault(module, []).append({
            "title": title,
            "file": f"pdf/{name}.pdf",
            "pages": page_count(pdf),
            "size": pdf.stat().st_size,
            "updated": last_change(typ.parent).isoformat(),
        })

    data = [{"name": m, "scripts": s} for m, s in sorted(modules.items(), key=lambda kv: kv[0].lower())]
    page = TEMPLATE.read_text(encoding="utf-8").replace(
        "/*DATA*/null", json.dumps(data, ensure_ascii=False).replace("</", "<\\/"))
    (OUT / "index.html").write_text(page, encoding="utf-8")
    (OUT / ".nojekyll").touch()

    print(f"\n{sum(len(s) for s in modules.values())} PDFs in {len(modules)} Modulen erzeugt.")
    # Ein kaputtes Skript soll die anderen nicht blockieren: Seite trotzdem bauen, Fehler im Action-Log markieren.
    for f in failed:
        print(f"::error title=Typst-Fehler::{f} konnte nicht kompiliert werden", file=sys.stderr)


if __name__ == "__main__":
    main()
