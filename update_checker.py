
#!/usr/bin/env python3
import os
import json
import requests
import zipfile
import shutil
from datetime import datetime

# Konfiguration
LOCAL_VERSION_FILE = "version.json"
REMOTE_VERSION_URL = "https://raw.githubusercontent.com/dizir71/Video_Mac_LAN_Server/main/version.json"
DOWNLOAD_DIR = os.path.expanduser("~/Downloads/Video_Mac_LAN_Server_Update")
TARGET_DIR = os.path.expanduser("~/Video_Mac_LAN_Server")
ZIP_FILENAME = "update.zip"

def get_local_version():
    if not os.path.exists(LOCAL_VERSION_FILE):
        return "0.0.0"
    with open(LOCAL_VERSION_FILE, "r") as f:
        return json.load(f).get("version", "0.0.0")

def get_remote_version():
    try:
        response = requests.get(REMOTE_VERSION_URL)
        response.raise_for_status()
        return json.loads(response.text)
    except Exception as e:
        print("Fehler beim Abrufen der Remote-Version:", e)
        return None

def version_is_newer(remote, local):
    return tuple(map(int, remote.split("."))) > tuple(map(int, local.split(".")))

def download_and_extract(url):
    os.makedirs(DOWNLOAD_DIR, exist_ok=True)
    zip_path = os.path.join(DOWNLOAD_DIR, ZIP_FILENAME)

    print("Lade Update herunter...")
    with requests.get(url, stream=True) as r:
        r.raise_for_status()
        with open(zip_path, "wb") as f:
            for chunk in r.iter_content(chunk_size=8192):
                f.write(chunk)

    print("Entpacke Update...")
    with zipfile.ZipFile(zip_path, 'r') as zip_ref:
        zip_ref.extractall(DOWNLOAD_DIR)

    print("Ersetze alte Dateien...")
    if os.path.exists(TARGET_DIR):
        shutil.rmtree(TARGET_DIR)
    shutil.move(os.path.join(DOWNLOAD_DIR, "Video_Mac_LAN_Server"), TARGET_DIR)

def update_local_version(remote_data):
    with open(LOCAL_VERSION_FILE, "w") as f:
        json.dump(remote_data, f, indent=4)

def main():
    local_version = get_local_version()
    remote_data = get_remote_version()
    if not remote_data:
        return

    remote_version = remote_data.get("version", "0.0.0")
    print(f"Lokale Version: {local_version}, Remote-Version: {remote_version}")

    if version_is_newer(remote_version, local_version):
        print("Neue Version verfügbar. Update wird durchgeführt.")
        download_and_extract(remote_data.get("download"))
        update_local_version(remote_data)
        print("Update abgeschlossen. Bitte manuell neu starten.")
    else:
        print("Kein Update erforderlich.")

if __name__ == "__main__":
    main()
