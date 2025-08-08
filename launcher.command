#!/usr/bin/env bash
# launcher.command

set -euo pipefail

# Get the directory where the script is located
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

# Ensure common install locations are on PATH for this session
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# Check if uv is available; if not, install it and update PATH
if ! command -v uv >/dev/null 2>&1; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    # The installer typically places uv in ~/.local/bin; ensure it's on PATH now
    export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
    if ! command -v uv >/dev/null 2>&1; then
        echo "uv installation completed but not found on PATH."
        echo "Please ensure ~/.local/bin is in your PATH and re-run."
        read -p "Press Enter to close..."
        exit 1
    fi
fi

# Check if virtual environment exists
if [ ! -d "$DIR/.venv" ]; then
    echo "First-time setup..."
    
    echo "Creating virtual environment with Python 3.11..."
    uv venv --python 3.11
    
    echo "Installing dependencies..."
    uv pip install gradio
else
    echo "Environment already set up, launching application..."
fi

# Activate virtual environment and run
source .venv/bin/activate
python "$DIR/run_caption_editor.py"

# Keep the terminal window open
read -p "Press Enter to close..."
