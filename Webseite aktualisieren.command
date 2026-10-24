#!/bin/bash
# Lädt die aktuellen Typst-Lernskripte aus dem Uni-Ordner auf die Webseite hoch.
# Doppelklick genügt. Die PDFs werden danach auf GitHub automatisch erzeugt (dauert 1–3 Minuten).

GITHUB_REPO="mariogotz04/studium"
WEBSEITE="https://mariogotz04.github.io/studium/"
ARBEITSKOPIE="$HOME/Studium-Webseite"

# Ordner mit diesen Namen werden nie hochgeladen (* statt Umlaut, weil macOS Umlaute
# unterschiedlich speichern kann).
AUSSCHLIESSEN=("Zum L*schen" "Unterlagen" "Sonstiges")

set -e
UNI="$(cd "$(dirname "$0")" && pwd)"
cd "$HOME"

fertig() { echo; read -n 1 -s -r -p "Taste drücken zum Schließen …"; echo; exit "${1:-0}"; }
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

# Alles neu aufbauen, damit gelöschte oder umbenannte Skripte auch online verschwinden.
rm -rf skripte
mkdir skripte

ausschluss=()
for name in "${AUSSCHLIESSEN[@]}"; do ausschluss+=(-not -path "*/$name/*"); done

echo "Suche Typst-Skripte in $UNI …"
find "$UNI" -name "*.typ" "${ausschluss[@]}" -not -path "*/.*" -print0 |
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
  done

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
open "https://github.com/$GITHUB_REPO/actions" 2>/dev/null || true
fertig 0
