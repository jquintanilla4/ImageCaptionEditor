# Image Caption Editor

Simple desktop-friendly UI to view PNG images in a folder and edit/save their captions as matching `.txt` files.

## Quick Start (macOS)

- Double‑click `launcher.command`.
- On first run it:
  - Installs `uv` (lightweight Python toolchain manager).
  - Creates `.venv` using Python 3.11.
  - Installs `gradio`.
  - Launches the app in your default browser.
- If macOS warns the file is from the internet, right‑click `launcher.command` → Open.

Terminal alternative:

- `chmod +x launcher.command && ./launcher.command`

## Using the App

- Browse to select a folder containing `.png` files.
- The image appears on the left; edit the caption on the right.
- Use `Save Caption` to write a `.txt` next to the image (same name, `.png` → `.txt`).
- Navigate with `← Previous` / `Next →`, or type an image number and click `Jump`.
- `Clear All Fields` resets the UI.

Notes:

- Currently supports `.png` images. Add more formats in `caption_editor.py` if needed.
- Files stay local; no data is uploaded.

## Other Platforms

There is no one‑click launcher for Windows/Linux, but you can run it with Python:

- Ensure Python 3.11+ is installed.
- In this folder, run:
  - `python -m venv .venv && source .venv/bin/activate` (Windows: ` .venv\\Scripts\\activate`)
  - `pip install gradio`
  - `python run_caption_editor.py`

Alternatively with `uv`:

- `uv venv --python 3.11`
- `source .venv/bin/activate` (Windows: ` .venv\\Scripts\\activate`)
- `uv pip install gradio`
- `python run_caption_editor.py`

## Folder Access

- The macOS launcher starts with access to common paths: `~/Downloads`, `~/Desktop`, `~/Documents`, and your home folder. You can browse to any subfolder within those.
- To change allowed paths, edit `run_caption_editor.py` (`allowed_paths`).

## Troubleshooting

- uv not found: Ensure `~/.local/bin` is on your `PATH`. For zsh add `export PATH="$HOME/.local/bin:$PATH"` to `~/.zshrc`.
- Permission/Gatekeeper: Right‑click `launcher.command` → Open once, then double‑click works.
- No browser window: The terminal prints a local URL (http://127.0.0.1:7860). Open it manually.
- Folder dialog fails: macOS requires Accessibility/Automation permissions for AppleScript prompts. Re‑try after accepting prompts.
- Network required on first run to download Python 3.11 (if missing) and install dependencies.

## Project Layout

- `launcher.command`: macOS launcher that installs `uv`, creates `.venv`, installs deps, and runs the app.
- `run_caption_editor.py`: Entry point that sets allowed paths and launches the Gradio UI.
- `caption_editor.py`: UI, navigation, and caption read/write logic.

## Development

- Add formats: update `glob` in `ImageCaptionEditor.load_folder` in `caption_editor.py`.
- Change UI labels/behavior: edit components and callbacks in `create_interface()`.
- If you prefer plain `pip`, you can skip `uv` and manage the venv yourself.
