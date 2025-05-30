from flask import Flask, render_template, request, redirect, send_from_directory, abort
from pathlib import Path
import mimetypes
import shutil

app = Flask(__name__)
BASE_DIR = Path.home() / "Videos"

@app.route("/", defaults={"req_path": ""}, methods=["GET", "POST"])
@app.route("/<path:req_path>", methods=["GET", "POST"])
def dir_listing(req_path):
    abs_path = (BASE_DIR / req_path).resolve()

    if not abs_path.exists():
        return abort(404)

    if abs_path.is_file():
        return send_from_directory(abs_path.parent, abs_path.name)

    if request.method == "POST" and "file" in request.files:
        f = request.files["file"]
        target_path = abs_path / f.filename
        f.save(target_path)
        return redirect(request.path)

    files = []
    for p in sorted(abs_path.iterdir()):
        mime = mimetypes.guess_type(str(p))[0] or ""
        preview = None
        if p.is_dir():
            preview_img = p / "index.jpg"
            if preview_img.exists():
                preview = (Path(req_path) / p.name / "index.jpg").as_posix()
        files.append({
            "name": p.name,
            "href": (Path(req_path) / p.name).as_posix(),
            "is_dir": p.is_dir(),
            "is_video": mime.startswith("video"),
            "preview": preview
        })

    return render_template("index.html", items=files)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)