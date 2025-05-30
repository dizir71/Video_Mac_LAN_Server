#!/bin/bash

clear
echo "────────────────────────────"
echo " VIDEOSERVER SETUP (macOS)"
echo "────────────────────────────"
echo "[1] Menüleisten-App (GUI via Platypus)"
echo "[2] Autostart per LaunchAgent (.plist)"
echo "[3] Nur manuelles Starten"
echo "────────────────────────────"
read -p "> Deine Wahl (1-3): " choice

# Festlegen der Installationsverzeichnisse
PLIST_SRC="./com.videofileserver.autostart.plist"
PLIST_DST="$HOME/Library/LaunchAgents/com.videofileserver.autostart.plist"
SCRIPT_PATH="$(pwd)/video_server.py"

# Menü-Auswahl
case $choice in
  1)
    echo "⚙️  Menüleisten-App ausgewählt. Anleitung zur Erstellung:"
    echo "→ Platypus herunterladen: https://sveinbjorn.org/platypus"
    echo "→ Script: $SCRIPT_PATH"
    echo "→ Interface: 'Status Item'"
    echo "→ Icon: optional"
    echo "→ Save as .app und zu /Applications hinzufügen"
    ;;
  2)
    echo "🔁 Installiere Autostart (.plist) nach ~/Library/LaunchAgents"
    cp "$PLIST_SRC" "$PLIST_DST"
    launchctl unload "$PLIST_DST" 2>/dev/null
    launchctl load "$PLIST_DST"
    echo "✅ Autostart aktiviert. Wird beim nächsten Login automatisch ausgeführt."
    ;;
  3)
    echo "❗ Kein Autostart. Du kannst den Server manuell starten mit:"
    echo "   python3 video_server.py"
    ;;
  *)
    echo "❌ Ungültige Eingabe."
    exit 1
    ;;
esac

# .env anlegen
read -p "🔐 Möchtest du einen Passwortschutz aktivieren? (j/n): " pass_choice
if [ "$pass_choice" == "j" ]; then
  read -p "Benutzername: " user
  read -sp "Passwort: " pass
  echo ""
  echo "USE_AUTH=true" > .env
  echo "AUTH_USERNAME=$user" >> .env
  echo "AUTH_PASSWORD=$pass" >> .env
  echo "✅ .env Datei erstellt."
else
  echo "USE_AUTH=false" > .env
  echo "ℹ️  Kein Passwortschutz aktiv."
fi

# Indexierung initialisieren
echo "🔍 Initialisiere Indexdaten…"
python3 generate_index_json.py

# Abschluss
echo "✅ Setup abgeschlossen. Du kannst den Server jetzt starten:"
echo "   python3 video_server.py"
