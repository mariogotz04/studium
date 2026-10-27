#!/usr/bin/env python3
"""Ergänzt Lernzitate aus deutschsprachigen Wikiquote-Werkbelegen.

Nur die Quellenabschnitte der festgelegten, gemeinfreien deutschsprachigen
Autoren werden gelesen. Zuschreibungen und Zitate über eine Person bleiben aus.
Keine KI-generierten Texte, Übersetzungen oder ausführbarer Inhalt aus dem Netz.
"""
import argparse
from collections import Counter
from datetime import date
from difflib import SequenceMatcher
import hashlib
from html.parser import HTMLParser
import json
from pathlib import Path
import re
import sys
import time
from urllib.parse import quote, urlparse
from urllib.request import Request, urlopen
from urllib.error import HTTPError

ROOT = Path(__file__).resolve().parent
SAMMLUNG_URL = "https://mariogotz04.github.io/studium/zitate.json"
AUTOREN = (
    "Johann Wolfgang von Goethe", "Friedrich Schiller", "Georg Christoph Lichtenberg",
    "Marie von Ebner-Eschenbach", "Arthur Schopenhauer", "Friedrich Nietzsche",
    "Immanuel Kant", "Gotthold Ephraim Lessing", "Wilhelm von Humboldt",
    "Alexander von Humboldt", "Hermann von Helmholtz", "Max Planck",
    "Albert Einstein", "Theodor Fontane", "Novalis", "Heinrich Heine",
    "Friedrich Hebbel", "Jean Paul", "Ludwig Feuerbach", "Friedrich Rückert",
    "David Hilbert", "Carl Friedrich Gauß", "Wilhelm Ostwald", "Ernst Mach",
    "Rudolf Virchow",
    "Rainer Maria Rilke", "Franz Kafka", "Stefan Zweig", "Käthe Kollwitz",
    "Kurt Tucholsky", "Johann Heinrich Pestalozzi", "Georg Wilhelm Friedrich Hegel",
    "Gottfried Wilhelm Leibniz", "Johann Gottlieb Fichte", "Friedrich Fröbel",
)
THEMEN = re.compile(r"\b(?:lern\w*|wissen\w*|wissensch\w*|bildung\w*|studier\w*|erkennt\w*|üb(?:en|ung)\w*|neugier\w*|anfang\w*|anfangen|tätig\w*|arbeit\w*|denk\w*|erfahr\w*|versteh\w*|erfolg\w*|ziel\w*|ausdauer\w*|beharr\w*|begab\w*|talent\w*|verstand\w*|fähig\w*|fleiß\w*|fleiss\w*|fortschritt\w*|entdeck\w*|forsch\w*|leist\w*|geduld\w*|beginnen)\b", re.I)
UNSICHER = re.compile(r"zugeschrieben|fälschlich|unbelegt|angeblich|nicht nachweisbar|nicht belegt|nicht gefunden|umstritten|apokryph|zitiert nach|zit\. nach|übersetz|übertrag|übers\.", re.I)
UNPASSEND = re.compile(r"\b(?:krieg|gott|religion|christ|teufel|weib|frauen|jude|juden|rasse|dumm|dummen|dummheit|narr|narren|affe|affen|tod|sterben|hass|veracht|feind|feinde|sklav|verbrech|hölle|hure|sau|knecht|untertan|volk|völker|politik|partei|liebe|heirat|ehe|sterb|krank|mohr|tor|toren|thor|thoren|eifersucht|gewalt|gift|ruin|anheuchel|theolog|sakrament|theismus|metaphys|gehorsam|gehorch|uniform|minderwert|verzagen|beethoven|bayreuth|kolumbus|limonade|portwein|thröne|altäre|schmutz|skorpion)\w*", re.I)


def normal(text):
    return re.sub(r"\s+", " ", text).strip()


def fingerabdruck(z):
    return re.sub(r"[\W_]+", "", (z["autor"] + z["text"]).casefold())


def prüfen(liste):
    if not isinstance(liste, list):
        raise ValueError("Eine Zitatliste wird erwartet")
    ids, texte = set(), set()
    for z in liste:
        if not isinstance(z, dict) or not all(isinstance(z.get(k), str) and z[k].strip() for k in ("id", "text", "autor", "werk", "quelle")):
            raise ValueError("Zitat ohne vollständigen internen Beleg")
        if urlparse(z["quelle"]).scheme != "https" or not urlparse(z["quelle"]).hostname:
            raise ValueError("Ungültige Quellenadresse")
        if z["id"] in ids or fingerabdruck(z) in texte:
            raise ValueError("Doppeltes Zitat")
        ids.add(z["id"]); texte.add(fingerabdruck(z))
    return liste


class Seite(HTMLParser):
    """Kleine DOM-Struktur: nur Text und Bibliografie werden später übernommen."""
    def __init__(self, html):
        super().__init__(convert_charrefs=True)
        self.wurzel = {"tag": "root", "attrs": {}, "kinder": []}
        self.stack = [self.wurzel]
        self.feed(html)

    def handle_starttag(self, tag, attrs):
        n = {"tag": tag, "attrs": dict(attrs), "kinder": []}
        self.stack[-1]["kinder"].append(n)
        if tag not in {"br", "hr", "img", "meta", "link", "input", "wbr", "source", "area", "base", "embed", "param", "track", "col"}:
            self.stack.append(n)

    def handle_endtag(self, tag):
        for i in range(len(self.stack) - 1, 0, -1):
            if self.stack[i]["tag"] == tag:
                del self.stack[i:]
                break

    def handle_data(self, data):
        self.stack[-1]["kinder"].append(data)


def text(n):
    if isinstance(n, str):
        return n
    if n["tag"] in {"script", "style", "sup", "ul", "ol"} or "mw-editsection" in n["attrs"].get("class", ""):
        return ""
    return "".join(text(k) for k in n["kinder"])


def knoten(n):
    if isinstance(n, dict):
        yield n
        for k in n["kinder"]:
            yield from knoten(k)


def kandidaten(html, autor, url):
    dom = Seite(html).wurzel
    haupt = next((n for n in knoten(dom) if "mw-parser-output" in n["attrs"].get("class", "").split()), None)
    if not haupt:
        raise ValueError("Wikiquote-Inhaltsbereich fehlt")
    aktiv, kapitel = False, ""
    for n in knoten(haupt):
        if n["tag"] == "h2":
            titel = normal(text(n))
            aktiv = titel in {"Überprüft", "Zitate mit Quellenangabe"}
            kapitel = ""
        elif n["tag"] in {"h3", "h4"}:
            kapitel = normal(text(n))
        elif n["tag"] == "li" and aktiv:
            zeile = normal(text(n))
            m = re.match(r'^"(.+?)"\s*[-–—]\s*(.+)$', zeile) or re.match(r'^„(.+?)“\s*[-–—]\s*(.+)$', zeile)
            if not m:
                continue
            wortlaut, beleg = m.groups()
            wortlaut = normal(wortlaut.replace("//", " "))
            if not 35 <= len(wortlaut) <= 300 or not THEMEN.search(wortlaut):
                continue
            if UNSICHER.search(zeile) or UNPASSEND.search(wortlaut) or any(x in wortlaut for x in ("http", "[", "]", "{{", "<", ">", "...", "…", '"')):
                continue
            # Eine Werkangabe mit Fundstelle, nicht bloß eine Zuschreibung.
            if len(beleg) < 15 or wortlaut[-1] not in ".!?":
                continue
            z = {"id": "netz-" + hashlib.sha256((autor + "|" + wortlaut).encode()).hexdigest()[:16],
                 "text": wortlaut, "autor": autor, "werk": normal((kapitel + " · " if kapitel else "") + beleg),
                 "quelle": url, "hinzugefuegt": date.today().isoformat(), "belegart": "Werkangabe im Quellenabschnitt von Wikiquote"}
            yield z


def abrufen(autor, cache=None):
    url = "https://de.wikiquote.org/wiki/" + quote(autor.replace(" ", "_"))
    request = Request(url, headers={"User-Agent": "StudiumLernzitate/1.0 (https://github.com/mariogotz04/studium)", "Accept": "text/html"})
    with urlopen(request, timeout=25) as r:
        if urlparse(r.url).hostname != "de.wikiquote.org":
            raise ValueError("Unerwartete Weiterleitung")
        html = r.read(3_000_001)
        if len(html) > 3_000_000:
            raise ValueError("Quellenseite zu groß")
    if cache:
        cache.mkdir(parents=True, exist_ok=True)
        (cache / (autor + ".html")).write_bytes(html)
    return list(kandidaten(html.decode("utf-8"), autor, url))


def veröffentlichte_sammlung():
    """Public Pages-Datei erhält automatische Ergänzungen ohne Schreibrecht auf Git."""
    request = Request(SAMMLUNG_URL, headers={"User-Agent": "StudiumLernzitate/1.0", "Cache-Control": "no-cache"})
    try:
        with urlopen(request, timeout=25) as r:
            if urlparse(r.url).hostname != "mariogotz04.github.io":
                raise ValueError("Unerwartete Weiterleitung der Zitatdatenbank")
            daten = r.read(5_000_001)
    except HTTPError as e:
        if e.code == 404:
            # Erstveröffentlichung: bisher gab es nur im HTML eingebettete Zitate.
            return []
        raise
    if len(daten) > 5_000_000:
        raise ValueError("Veröffentlichte Zitatdatenbank zu groß")
    return prüfen(json.loads(daten))


def ergänzen(bestand, neu, limit):
    bestand = prüfen(list(bestand))
    ids = {z["id"] for z in bestand}; gesehen = {fingerabdruck(z) for z in bestand}
    anzahl = Counter(z["autor"] for z in bestand)
    ausgeschlossen = set(json.loads((ROOT / "zitate_filter.json").read_text(encoding="utf-8"))["ausgeschlossen"])
    übrig = []
    for z in neu:
        prüfen([z]); fp = fingerabdruck(z)
        ähnlich = any(x["autor"] == z["autor"] and SequenceMatcher(None, x["text"].casefold(), z["text"].casefold()).ratio() > 0.9 for x in bestand + übrig)
        if z["id"] not in ausgeschlossen and z["id"] not in ids and fp not in gesehen and not ähnlich:
            übrig.append(z); ids.add(z["id"]); gesehen.add(fp)
    # Neue Autoren und unterschiedlich vertretene Stimmen bevorzugen.
    hinzu = []
    while übrig and len(hinzu) < limit:
        übrig.sort(key=lambda z: (anzahl[z["autor"]], z["id"]))
        z = übrig.pop(0); hinzu.append(z); anzahl[z["autor"]] += 1
    return prüfen(bestand + hinzu)


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--datei", type=Path, default=ROOT / "zitate.json")
    p.add_argument("--limit", type=int, default=10)
    gruppe = p.add_mutually_exclusive_group()
    gruppe.add_argument("--merge-from", type=Path, help="Zwei vorhandene Sammlungen lokal zusammenführen; kein Netzwerkzugriff")
    gruppe.add_argument("--merge-public", action="store_true", help="Bereits veröffentlichte öffentliche Zitatdaten erhalten")
    p.add_argument("--cache", type=Path, help="HTML nur für lokale Prüfungen zwischenspeichern")
    args = p.parse_args()
    if not 1 <= args.limit <= 1000:
        p.error("limit muss zwischen 1 und 1000 liegen")
    bestand = prüfen(json.loads(args.datei.read_text(encoding="utf-8")))
    neu = []
    if args.merge_public:
        # Bei Netz-/Datenfehlern abbrechen, damit eine Veröffentlichung nicht auf
        # einen älteren Grundbestand zurückfällt. Die bestehende Seite bleibt online.
        neu = veröffentlichte_sammlung()
        limit = len(neu)
    elif args.merge_from:
        if args.merge_from.exists():
            neu = prüfen(json.loads(args.merge_from.read_text(encoding="utf-8")))
        limit = len(neu)
    else:
        for autor in AUTOREN:
            try:
                neu.extend(abrufen(autor, args.cache))
            except Exception as e:
                print(f"Quelle derzeit nicht verfügbar: {autor}: {e}", file=sys.stderr)
            time.sleep(0.2)
        limit = args.limit
    ergebnis = ergänzen(bestand, neu, limit)
    if len(ergebnis) > len(bestand):
        tmp = args.datei.with_suffix(".tmp")
        tmp.write_text(json.dumps(ergebnis, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
        tmp.replace(args.datei)
    print(f"Zitate: {len(ergebnis)} insgesamt, {len(ergebnis)-len(bestand)} ergänzt aus {len(neu)} passenden Fundstellen.")


if __name__ == "__main__":
    main()
