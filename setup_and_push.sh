#!/bin/bash
echo "📦 Starte Einrichtung von Video_Mac_LAN_Server ..."
git init
git remote add origin git@github.com:dizir71/Video_Mac_LAN_Server.git
git branch -M main
git add .
git commit -m '🚀 Initial upload – macOS LAN Video Server'
git push -u origin main
echo "✅ Upload abgeschlossen."
