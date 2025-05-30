import os
import json
from pathlib import Path

WATCH_DIRS = [
    Path.home() / "Videos",
    Path.home() / "Videos/Serien",
    Path.home() / "Videos/Filme"
]

video_exts = {".mp4", ".mkv", ".avi", ".mov"}
all_videos = []

for folder in WATCH_DIRS:
    if folder.exists():
        for path in folder.rglob("*"):
            if path.suffix.lower() in video_exts:
                rel_path = path.relative_to(Path.home())
                all_videos.append({
                    "name": path.name,
                    "path": str(rel_path),
                    "size_MB": round(path.stat().st_size / (1024 * 1024), 2),
                    "modified": path.stat().st_mtime
                })

# Ausgabe als index.json im Basisverzeichnis
output_path = Path.home() / "Videos" / "index.json"
with open(output_path, "w") as f:
    json.dump(all_videos, f, indent=2)

print(f"index.json erstellt: {output_path}")