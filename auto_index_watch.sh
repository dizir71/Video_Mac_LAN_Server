#!/bin/bash

# Konfiguration: Verzeichnisse, die indiziert werden sollen
WATCH_DIRS=(
    "$HOME/Videos"
    "$HOME/Videos/Serien"
    "$HOME/Videos/Filme"
)

LOGFILE="$HOME/videofileserver_index.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "[$TIMESTAMP] Starte Indexierung..." >> "$LOGFILE"

for DIR in "${WATCH_DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        echo "[$TIMESTAMP] Verzeichnisse in $DIR:" >> "$LOGFILE"
        find "$DIR" -type f \( -iname "*.mp4" -o -iname "*.mkv" -o -iname "*.avi" \) >> "$LOGFILE"
    else
        echo "[$TIMESTAMP] Nicht gefunden: $DIR" >> "$LOGFILE"
    fi
done

echo "[$TIMESTAMP] Indexierung abgeschlossen." >> "$LOGFILE"