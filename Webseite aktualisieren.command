#!/bin/bash
# Lädt die aktuellen Typst-Lernskripte, Aufgaben, Quizfragen, Karteikarten, Hörtexte, den Vorlesungsplan und die Webseite aus dem Uni-Ordner auf GitHub hoch.
# Doppelklick genügt, oder im Terminal / von Codex: bash "Uni/Webseite/Webseite aktualisieren.command"
# Die PDFs werden danach auf GitHub automatisch erzeugt (dauert 1–3 Minuten).

GITHUB_REPO="mariogotz04/studium"
WEBSEITE="https://mariogotz04.github.io/studium/"
ARBEITSKOPIE="$HOME/Studium-Webseite"   # Git-Kopie bewusst außerhalb von iCloud
NUR_WEBSEITE=false
if [ "${1:-}" = "--nur-webseite" ]; then NUR_WEBSEITE=true;
elif [ "$#" -gt 0 ]; then echo "Unbekannte Option: $1"; exit 1; fi

# Ordner mit diesen Namen werden nie hochgeladen (* statt Umlaut, weil macOS Umlaute
# unterschiedlich speichern kann).
AUSSCHLIESSEN=("Zum L*schen" "Unterlagen" "Sonstiges" "Physik Praktikum" "Webseite")

# Diese Dateien aus Uni/Webseite gehören zur Seite selbst und werden mit hochgeladen.
SEITENDATEIEN=("vorlage.html" "build.py" "zitate.json" "zitate_aktualisieren.py" "zitate_filter.json" "test_zitate.py" "test_zitate.cjs" "test_mix.cjs" "README.md" "AGENTS.md" ".gitignore" ".github" "Webseite aktualisieren.command" "Vorlesungsplan.pdf")

set -e
SEITE="$(cd "$(dirname "$0")" && pwd)"
UNI="$(dirname "$SEITE")"
cd "$HOME"

# Ohne Terminal (z. B. Codex) nicht auf Tastendruck warten.
interaktiv() { [ -t 0 ] && [ -t 1 ]; }
fertig() {
  if interaktiv; then echo; read -n 1 -s -r -p "Taste drücken zum Schließen …"; echo; fi
  exit "${1:-0}"
}
trap 'echo; echo "❌ Da ist etwas schiefgelaufen (siehe oben)."; fertig 1' ERR

if ! command -v git >/dev/null; then
  echo "Git fehlt. macOS fragt gleich, ob die Entwicklerwerkzeuge installiert werden sollen: bitte bestätigen und das Skript danach erneut starten."
  xcode-select --install || true
  fertig 1
fi

if [ ! -d "$ARBEITSKOPIE/.git" ]; then
  echo "Erste Einrichtung: lade das Repository nach $ARBEITSKOPIE …"
  git clone "https://github.com/$GITHUB_REPO.git" "$ARBEITSKOPIE"
fi
cd "$ARBEITSKOPIE"
git pull --quiet --rebase

# Automatisch online hinzugekommene Zitate auch in der iCloud-Quelle erhalten.
# Zusammenführung ist rein lokal und überträgt keinerlei Lernstand.
python3 "$SEITE/zitate_aktualisieren.py" --merge-from "$ARBEITSKOPIE/zitate.json"
python3 "$SEITE/zitate_aktualisieren.py" --merge-public

for datei in "${SEITENDATEIEN[@]}"; do
  if [ -e "$SEITE/$datei" ]; then rm -rf "./$datei"; cp -Rp "$SEITE/$datei" "./$datei"; fi
done

# Alles neu aufbauen, damit gelöschte oder umbenannte Skripte auch online verschwinden.
if [ "$NUR_WEBSEITE" = false ]; then
rm -rf skripte
mkdir skripte

ausschluss=()
for name in "${AUSSCHLIESSEN[@]}"; do ausschluss+=(-not -path "$UNI/$name/*" -not -path "*/$name/*"); done

# Pro Modul wird nur das aktuelle Lernskript hochgeladen: <Modul>/Lernskript aktuell/Typst-Dateien/
# Alte Stände, Sicherungen und Kopien woanders im Ordner kommen nie auf die Webseite.
echo "Suche aktuelle Lernskripte in $UNI …"
find "$UNI" -mindepth 4 -maxdepth 4 -path "*/Lernskript aktuell/Typst-Dateien/main.typ" "${ausschluss[@]}" -print0 |
  xargs -0 -n1 dirname | sort -u |
  while read -r ordner; do
    ziel="skripte/${ordner#"$UNI"/}"
    echo "  • ${ordner#"$UNI"/}"
    # Nur Typst-Dateien und alles, was sie einbinden können (Bilder, Daten) – keine Word-Dateien o. Ä.
    (cd "$ordner" && find . -type f -not -path "*/.*" \( -iname "*.typ" -o -iname "*.svg" -o -iname "*.png" \
        -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" -o -iname "*.webp" -o -iname "*.bib" \
        -o -iname "*.csv" -o -iname "*.json" -o -iname "*.yaml" -o -iname "*.yml" -o -iname "*.toml" \) -print0 |
      while IFS= read -r -d "" datei; do
        mkdir -p "$ARBEITSKOPIE/$ziel/$(dirname "$datei")"
        cp -p "$datei" "$ARBEITSKOPIE/$ziel/$datei"
      done)
    # Karteikarten, Quiz und Hörtext des Moduls liegen daneben in Lernskript aktuell/.
    # (die Aufgaben stehen in Typst-Dateien/Aufgaben.typ und sind oben schon dabei)
    for md in Karteikarten.md Quiz.md Hoerskript.md; do
      if [ -f "$(dirname "$ordner")/$md" ]; then
        cp -p "$(dirname "$ordner")/$md" "$ARBEITSKOPIE/$(dirname "$ziel")/$md"
      fi
    done
  done
fi

git add -A
if git diff --cached --quiet; then
  echo
  echo "✅ Keine Änderungen – die Webseite ist schon aktuell."
  fertig 0
fi

git commit --quiet -m "Skripte aktualisiert am $(date '+%d.%m.%Y %H:%M')"
echo
echo "Lade hoch …"
git push --quiet
echo
echo "✅ Hochgeladen. In 1–3 Minuten sind die neuen PDFs hier:"
echo "   $WEBSEITE"
interaktiv && open "https://github.com/$GITHUB_REPO/actions" 2>/dev/null || true
fertig 0
