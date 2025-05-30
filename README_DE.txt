
📦 VIDEOSERVER INSTALLATION – DEUTSCH

1. Entpacken Sie die ZIP-Datei.
2. Öffnen Sie das Terminal, navigieren Sie zum Ordner und führen Sie aus:
   ./install_videofileserver.sh

3. Wählen Sie:
   [1] Menüleisten-App (.app mit GUI)
   [2] Autostart (.plist, silent)
   [3] Manuell starten

4. Optional: Passwortschutz konfigurieren

5. Indexdaten werden automatisch erstellt.
6. Starten Sie den Server:
   python3 video_server.py

Funktionen:
✅ Video-Vorschau (MP4, AVI, MKV)
✅ FireTV-kompatibel
✅ Auth (HTTP Basic möglich)
✅ Autostart oder Menüleisten-App
✅ index.json alle 6h automatisch


🔧 Interaktives Setup-Formular: Öffnen Sie die Datei `Videoserver_Setup_Formular.html` im Browser zur geführten Konfiguration.
