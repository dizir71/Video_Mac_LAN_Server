#!/bin/bash

REPO_DIR=~/Desktop/GitHub/Video_Mac_LAN_Server
cd "$REPO_DIR" || exit

# Aktuelle Zeitstempel
echo "🔄 Synchronisation gestartet: $(date)"

# Git-Pull mit Rebase (holt Änderungen vom Remote)
git pull --rebase origin master

# Änderungen erkennen und committen, falls vorhanden
if [[ -n $(git status --porcelain) ]]; then
    echo "📦 Änderungen gefunden – Commit wird erstellt"
    git add .
    git commit -m "Auto-Sync: $(date '+%Y-%m-%d %H:%M:%S')"
    git push origin master
else
    echo "✅ Keine Änderungen – nichts zu tun"
fi

echo "🕓 Synchronisation beendet: $(date)"
