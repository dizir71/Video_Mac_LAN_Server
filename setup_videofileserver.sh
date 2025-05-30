#!/bin/bash

set -e

echo "🔧 Starte Initial-Setup für VideoFileserver..."

# Zielverzeichnis
TARGET="$HOME/videofileserver_ui"
mkdir -p "$TARGET"

# Ursprungsverzeichnis (wo das Skript entpackt wurde)
SOURCE="$(cd "$(dirname "$0")"; pwd)"

# Alle Dateien kopieren
echo "📂 Kopiere Dateien nach: $TARGET"
cp -R "$SOURCE"/* "$TARGET"

# Plists in LaunchAgents installieren
mkdir -p "$HOME/Library/LaunchAgents"
cp "$TARGET/local.videofileserver.plist" "$HOME/Library/LaunchAgents/"
cp "$TARGET/local.videofileserver.indexer.plist" "$HOME/Library/LaunchAgents/"

# Plists aktivieren
launchctl load "$HOME/Library/LaunchAgents/local.videofileserver.plist"
launchctl load "$HOME/Library/LaunchAgents/local.videofileserver.indexer.plist"

# Indexierungsskript anpassen: JSON-Erstellung einbinden
if ! grep -q generate_index_json.py "$TARGET/auto_index_watch.sh"; then
  echo -e "\n# JSON Index erzeugen" >> "$TARGET/auto_index_watch.sh"
  echo "python3 $TARGET/generate_index_json.py" >> "$TARGET/auto_index_watch.sh"
fi

echo "✅ Setup abgeschlossen. Der Server wird bei jedem Login automatisch gestartet."
echo "📂 Zugriff unter: http://localhost:8080"