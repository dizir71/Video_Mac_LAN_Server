#!/bin/bash
echo "Aktiviere Servermodus: Mac bleibt wach im Netzbetrieb, schläft bei Akku."

# Im Netzbetrieb nicht schlafen
sudo pmset -c sleep 0
# Bei Akku wie gewohnt nach 10 Minuten schlafen
sudo pmset -b sleep 10

# Bestätigung anzeigen
pmset -g