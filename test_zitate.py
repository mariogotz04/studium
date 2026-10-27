"""Regressionsprüfungen für den automatischen Zitatimport (ohne Netzwerk)."""
import contextlib
import io
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch
from urllib.error import HTTPError

import zitate_aktualisieren as z


def eintrag(id_, text, autor="Testperson"):
    return {"id": id_, "text": text, "autor": autor, "werk": "Ein Testwerk, S. 12", "quelle": "https://example.org/werk"}


class ZitateTest(unittest.TestCase):
    def test_nur_belegte_eigenstaendige_lernzitate(self):
        html = '''<div class="mw-parser-output"><h2>Überprüft</h2><h3>Testwerk</h3><ul>
        <li>"Durch Lernen und Übung wächst unser Verständnis der Zusammenhänge." – Ein Testwerk, 1890, S. 12</li>
        <li>"Ein weiteres Lernzitat ohne jeden richtigen Beleg."</li>
        <li>"Dieses angebliche Zitat über das Lernen ist nicht belegt." – Testwerk, S. 15</li>
        <li>"Die Wissenschaft lehrt uns [weitere Ausführungen]." – Testwerk, S. 16</li>
        </ul><h2>Zugeschrieben</h2><ul>
        <li>"Dieses Zitat über Lernen und Übung darf nicht übernommen werden." – Testwerk, S. 17</li>
        </ul><h2>Zitate mit Bezug auf Testperson</h2><ul>
        <li>"Auch ein Zitat einer anderen Person über das Lernen gehört nicht hierher." – Testwerk, S. 18</li>
        </ul></div>'''
        daten = list(z.kandidaten(html, "Testperson", "https://example.org/werk"))
        self.assertEqual(len(daten), 1)
        self.assertEqual(daten[0]["text"], "Durch Lernen und Übung wächst unser Verständnis der Zusammenhänge.")
        self.assertIn("S. 12", daten[0]["werk"])

    def test_keine_gekürzten_zitate_durch_innere_anfuehrungszeichen(self):
        html = '''<div class="mw-parser-output"><h2>Überprüft</h2><ul>
        <li>"»Die Erkenntnis um ihrer selbst willen« – dieses Motto verlangt eine Erklärung." – Ein Testwerk, S. 12</li>
        </ul></div>'''
        daten = list(z.kandidaten(html, "Testperson", "https://example.org/werk"))
        self.assertEqual(len(daten), 1)
        self.assertTrue(daten[0]["text"].endswith("Erklärung."))

    def test_dubletten_varianten_limit_und_gesperrte_eintraege(self):
        basis = [eintrag("a", "Übung und Lernen helfen beim Verstehen komplexer Dinge.")]
        neu = [eintrag("b", "Übung und Lernen helfen beim Verstehen komplexer Dinge!"),
               eintrag("c", "Geduld und Ausdauer helfen uns, bei einer schwierigen Aufgabe zu bleiben.", "Andere Person"),
               eintrag("d", "Neue Fragen eröffnen uns ganz andere Perspektiven auf bekannte Probleme.", "Dritte Person")]
        aus = next(iter(json.loads((z.ROOT / "zitate_filter.json").read_text())["ausgeschlossen"]))
        neu.append(eintrag(aus, "Ein redaktionell ausgeschlossener Eintrag bleibt ausgeschlossen.", "Vierte Person"))
        ergebnis = z.ergänzen(basis, neu, 1)
        self.assertEqual(len(ergebnis), 2)
        self.assertEqual(ergebnis[0], basis[0])
        self.assertNotIn("b", [x["id"] for x in ergebnis])
        self.assertNotIn(aus, [x["id"] for x in ergebnis])
        self.assertEqual(z.ergänzen(ergebnis, ergebnis, 10), ergebnis)

    def test_schemavalidierung(self):
        for kaputt in [eintrag("a", ""), {**eintrag("a", "Text"), "quelle": "javascript:alert(1)"}]:
            with self.assertRaises(ValueError):
                z.prüfen([kaputt])
        with self.assertRaises(ValueError):
            z.prüfen([eintrag("a", "Gleicher Text"), eintrag("b", "Gleicher Text")])

    def test_ausfall_erhaelt_die_bestehende_datenbank(self):
        with tempfile.TemporaryDirectory() as ordner:
            p = Path(ordner) / "zitate.json"
            original = json.dumps([eintrag("a", "Ein bestehendes Zitat bleibt bei einem Netzausfall erhalten.")])
            p.write_text(original)
            with patch.object(z, "AUTOREN", ["Testperson"]), patch.object(z, "abrufen", side_effect=OSError("offline")), patch.object(z.time, "sleep"), patch("sys.argv", ["import", "--datei", str(p)]), contextlib.redirect_stdout(io.StringIO()), contextlib.redirect_stderr(io.StringIO()):
                z.main()
            self.assertEqual(p.read_text(), original)

    def test_upload_zusammenfuehrung_ohne_netzwerk(self):
        with tempfile.TemporaryDirectory() as ordner:
            lokal, online = Path(ordner) / "lokal.json", Path(ordner) / "online.json"
            a = eintrag("a", "Lokale Änderungen an einem bestehenden Eintrag haben Vorrang.")
            b = eintrag("b", "Ein online ergänzter Eintrag soll beim nächsten Upload bestehen bleiben.")
            lokal.write_text(json.dumps([a])); online.write_text(json.dumps([a, b]))
            with patch.object(z, "abrufen", side_effect=AssertionError("Kein Internet beim Zusammenführen")), patch("sys.argv", ["import", "--datei", str(lokal), "--merge-from", str(online)]), contextlib.redirect_stdout(io.StringIO()):
                z.main()
            self.assertEqual(json.loads(lokal.read_text()), [a, b])

    def test_public_merge_erhaelt_netzfehler_ohne_ueberschreiben(self):
        with tempfile.TemporaryDirectory() as ordner:
            p = Path(ordner) / "zitate.json"
            original = json.dumps([eintrag("a", "Der bestehende Bestand bleibt erhalten.")])
            p.write_text(original)
            with patch.object(z, "veröffentlichte_sammlung", side_effect=OSError("offline")), patch("sys.argv", ["import", "--datei", str(p), "--merge-public"]):
                with self.assertRaises(OSError):
                    z.main()
            self.assertEqual(p.read_text(), original)
            b = eintrag("b", "Die veröffentlichte Ergänzung bleibt beim nächsten Build erhalten.")
            with patch.object(z, "veröffentlichte_sammlung", return_value=[b]), patch("sys.argv", ["import", "--datei", str(p), "--merge-public"]), contextlib.redirect_stdout(io.StringIO()):
                z.main()
            self.assertEqual([x["id"] for x in json.loads(p.read_text())], ["a", "b"])

    def test_public_merge_nur_404_ist_ein_erster_start(self):
        with patch.object(z, "urlopen", side_effect=HTTPError(z.SAMMLUNG_URL, 404, "Not found", {}, None)):
            self.assertEqual(z.veröffentlichte_sammlung(), [])
        with patch.object(z, "urlopen", side_effect=HTTPError(z.SAMMLUNG_URL, 503, "Unavailable", {}, None)):
            with self.assertRaises(HTTPError):
                z.veröffentlichte_sammlung()

    def test_aktuelle_sammlung_vollstaendig(self):
        daten = z.prüfen(json.loads((z.ROOT / "zitate.json").read_text()))
        self.assertGreaterEqual(len(daten), 100)
        self.assertGreaterEqual(len({x["autor"] for x in daten}), 20)


if __name__ == "__main__":
    unittest.main()
