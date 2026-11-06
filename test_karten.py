"""Kartenstil und die Trennung von Antwort, Merksatz und Merkbild absichern."""
import re
import tempfile
import unittest
from pathlib import Path

import build


class KartenstilTest(unittest.TestCase):
    def test_begriffslandkarten_in_allen_modulen_entfernt(self):
        with tempfile.TemporaryDirectory() as tmp:
            md = Path(tmp) / 'Karteikarten.md'
            (Path(tmp) / 'Typst-Dateien').mkdir()
            (Path(tmp) / 'Typst-Dateien' / 'main.typ').write_text('')
            md.write_text('## Kapitel 1\n### Normale Frage\n- Antwort\nQuelle: 1.1\n'
                          '### Zeichne die Begriffslandkarte zu Kapitel 1 aus dem Kopf.\n- Übersicht\nQuelle: 1.1\n')
            for modul in ['FET', 'Finanzierung', 'GET', 'Investitionsrechnung', 'Konstruktion', 'Physik', 'technische Mechanik']:
                with self.subTest(modul=modul):
                    karten = build.karteikarten(md, modul)
                    self.assertEqual([k['q'] for k in karten], ['Normale Frage'])

    def test_liste_merksatz_und_merkbild_bleiben_getrennt(self):
        text, bild = build.antwort_html([
            '- **Zustand:** beschreibt die Momentaufnahme.',
            '- Der Prozess beschreibt den Weg.',
            '', '**Merksatz:** Zustand ist das Ziel, Prozess der Weg.',
            '', 'Bild: Zwei Wege führen zum selben Gipfel.',
        ])
        self.assertIn('</li></ul><p class="merksatz">', text)
        self.assertEqual(text.count('<li>'), 2)
        self.assertIn('<strong>Merksatz:</strong>', text)
        self.assertNotIn('Gipfel', text)
        self.assertIn('Gipfel', bild)

    def test_formeln_und_html_maskierung_bleiben_erhalten(self):
        text, bild = build.antwort_html(['- Bei $x < 1$ prüfen.', '', '**Merksatz:** <script> ist Text.'])
        self.assertIn('@@F', text)
        self.assertIn('&lt;script&gt;', text)
        self.assertNotIn('<script>', text)
        self.assertFalse(bild)

    def test_veroeffentlichte_modulquellen_halten_den_kartenstil_ein(self):
        root = Path(__file__).resolve().parent
        src = root / 'skripte' if (root / 'skripte').is_dir() else root.parent
        dateien = sorted(src.glob('*/Lernskript aktuell/Karteikarten.md'))
        self.assertGreaterEqual(len(dateien), 7)
        for datei in dateien:
            for frage, antwort in re.findall(r'(?ms)^### ([^\n]+)\n(.*?)(?=^#{1,3} |\Z)', datei.read_text()):
                with self.subTest(modul=datei.parts[-3], frage=frage):
                    zeilen = [z.strip() for z in antwort.splitlines() if z.strip()]
                    self.assertTrue(any(z.startswith('- ') for z in zeilen))
                    self.assertEqual(sum(z.startswith('Quelle:') for z in zeilen), 1)
                    self.assertEqual(antwort.count('$') % 2, 0, 'Unvollständige Formel')
                    for z in zeilen:
                        self.assertTrue(z.startswith(('- ', '**Merksatz:**', 'Bild:', 'Quelle:', 'Abbildung:', '$')), z)


if __name__ == '__main__':
    unittest.main()
