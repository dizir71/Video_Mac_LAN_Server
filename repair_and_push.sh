#!/bin/bash

# Verzeichnis setzen
PROJECT_DIR="$HOME/Desktop/GitHub/Video_Mac_LAN_Server"
ZIP_NAME="Video_Mac_LAN_Server_v1.0.1_final.zip"
MNT_PATH="/mnt/data/$ZIP_NAME"
VERSION_FILE="$PROJECT_DIR/version.json"

cd "$PROJECT_DIR" || exit 1

echo "🛠️ Starte Reparaturvorgang im Verzeichnis: $PROJECT_DIR"

# 1. Versionsnummer updaten (1.0.1 → falls nicht vorhanden)
echo "{\"version\": \"1.0.1\", \"updated\": \"$(date '+%Y-%m-%d %H:%M:%S')\"}" > "$VERSION_FILE"

# 2. Alles zum Commit vorbereiten
git add .
git commit -m "🔄 Auto-Update: Zusammenführung & Version 1.0.1 ($(date '+%d.%m.%Y %H:%M'))"

# 3. Upstream aktualisieren (vorher Pull zur Sicherheit)
git pull --rebase origin main

# 4. Push nach GitHub
git push -u origin main

# 5. ZIP-Datei erstellen
zip -r "$ZIP_NAME" . -x "*.git*" "*.DS_Store" "*.zip"

# 6. ZIP ins Downloadverzeichnis /mnt/data/ kopieren
cp "$ZIP_NAME" "$MNT_PATH"

echo "✅ ZIP-Datei erstellt und in $MNT_PATH gespeichert"
echo "📦 Inhalt: $ZIP_NAME"
echo "🕒 Fertig um $(date '+%H:%M:%S')"
