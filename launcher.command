# launcher.command
#!/bin/bash

# Get the directory where the script is located
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

# Use a flag file to detect if this is a restart
RESTART_FLAG="$DIR/.restart_flag"

# If this is a restart, remove the flag and continue
if [ -f "$RESTART_FLAG" ]; then
    rm "$RESTART_FLAG"
else
    # First run - check if UV needs to be installed
    if ! uv --version &> /dev/null; then
        echo "Installing uv..."
        curl -LsSf https://astral.sh/uv/install.sh | sh
        
        # Create restart flag
        touch "$RESTART_FLAG"
        
        # Create a new shell instance with the updated PATH
        echo "Refreshing environment..."
        exec "$SHELL" "$0"
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