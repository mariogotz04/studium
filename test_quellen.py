"""Unsichere Worttreffer und die Kapitelübersichten als Quellen absichern."""
import os
import unittest
from pathlib import Path

import build


def block(text, p=2, top=120):
    return {"text": text, "wörter": build.suchwörter(text), "p": p, "w": 600, "h": 840,
            "z": [{"text": text, "x0": 60, "x1": 540, "top": top, "bottom": top + 14}]}


class QuellenTest(unittest.TestCase):
    def index(self, blöcke):
        index = build.Skriptstellen.__new__(build.Skriptstellen)
        index.abschnitte = [("Kapitel 1 · Zeichnungen", 1, 40), ("1.1 Projektionen", 2, 40)]
        index.blöcke = lambda titel: blöcke.get(titel, [])
        return index

    def test_ein_gemeinsames_wort_reicht_nicht(self):
        s = self.index({"1.1 Projektionen": [block("Eine technische Zeichnung zeigt die Parallelprojektion.")]})
        q = s.verweis(("1.1 Projektionen", 2), "Wozu dient die Zeichnung?",
                      "Die Zeichnung verbindet Positionsnummern und Stückliste.")
        self.assertNotIn("h", q)
        self.assertEqual(q["p"], 2)

    def test_passender_antworttext_statt_wiederholter_fragebegriffe(self):
        s = self.index({"1.1 Projektionen": [
            block("Zeichnung Zeichnung Zeichnung und Parallelprojektion Parallelprojektion."),
            block("Positionsnummern verknüpfen Bauteile und Stückliste eindeutig.", top=260),
        ]})
        q = s.verweis(("1.1 Projektionen", 2), "Zeichnung und Parallelprojektion?",
                      "Positionsnummern verknüpfen Bauteile und Stückliste eindeutig.")
        self.assertEqual(q["h"][0]["r"][0][1], round(260 / 840, 5))

    def test_begriffslandkarte_nimmt_gemeinsame_kapiteluebersicht(self):
        s = self.index({"Kapitel 1 · Zeichnungen": [
            block("→ Normen vereinbaren die Sprache.", 1),
            block("→ Positionsnummern verbinden Bauteil und Stückliste.", 1, 160),
        ], "1.1 Projektionen": [block("Die Parallelprojektion ist maßstäblich.")]})
        q = s.verweis(("1.1 Projektionen", 2), "Zeichne die Begriffslandkarte zu Kapitel 1 aus dem Kopf.",
                      "Normen vereinbaren die Sprache. Positionsnummern verbinden Bauteil und Stückliste.")
        self.assertEqual(q["t"], "Kapitel 1 · Zeichnungen")
        self.assertEqual(q["p"], 1)
        self.assertEqual(len(q["h"]), 2)

    def test_echtes_konstruktionsbeispiel(self):
        root = Path(__file__).resolve().parent
        site = Path(os.environ.get("QUELLEN_TEST_SITE", root / "_site"))
        pdf = next((site / "pdf").glob("Konstruktion_Lernskript_*.pdf"), None)
        if not pdf:
            self.skipTest("Integration nach dem Webseiten-Build")
        s = build.Skriptstellen(pdf)
        try:
            kapitel = next(a for a in s.abschnitte if a[0].startswith("Kapitel 1 ·"))
            abschnitt = next(a for a in s.abschnitte if a[0].startswith("1.1 "))
            q = s.verweis(abschnitt[:2], "Zeichne die Begriffslandkarte zu Kapitel 1 aus dem Kopf.",
                          "Die technische Zeichnung übermittelt Form und Funktion in einer vereinbarten Sprache. "
                          "Normen vereinheitlichen Zeichen und Angaben. Der Zweck entscheidet über Skizze, Einzelteil- "
                          "oder Gesamtzeichnung. Positionsnummern verbinden Bauteile mit der Stückliste.")
            self.assertEqual(q["p"], kapitel[1])
            self.assertEqual(len(q["h"]), 4)
            for h in q["h"]:
                for x, y, w, höhe in h["r"]:
                    self.assertTrue(0 <= x < x + w <= 1)
                    self.assertTrue(0 <= y < y + höhe <= 1)
                    self.assertLess(y, abschnitt[2] / s.zeilen(abschnitt[1])[1])
        finally:
            s.schließen()


if __name__ == "__main__":
    unittest.main()
