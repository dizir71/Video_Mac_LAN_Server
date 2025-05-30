#!/bin/bash

echo "🔐 GitHub SSH Setup für diesen Mac"

# Verzeichnis sicherstellen
mkdir -p ~/.ssh
chmod 700 ~/.ssh

read -p "Füge jetzt deinen privaten SSH-Schlüssel ein (BEGIN ... END): Drücke Enter, wenn du bereit bist." dummy

nano ~/.ssh/id_ed25519

# Setze Rechte
chmod 600 ~/.ssh/id_ed25519

# Erzeuge öffentlichen Schlüssel, falls nicht vorhanden
ssh-keygen -y -f ~/.ssh/id_ed25519 > ~/.ssh/id_ed25519.pub

# SSH-Agent starten & Schlüssel laden
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Verbindung testen
echo "🧪 Teste Verbindung zu GitHub..."
ssh -T git@github.com

echo "✅ Fertig! Du kannst jetzt mit 'git push -u origin master' arbeiten."
