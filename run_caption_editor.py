import sys
import os
from pathlib import Path

def main():
    # Import the main script
    from caption_editor import create_interface

    # Get user's home directory
    home = str(Path.home())

    # Define common macOS paths
    allowed_paths = [
        os.path.join(home, "Downloads"),
        os.path.join(home, "Desktop"),
        os.path.join(home, "Documents"),
        home  # Allow access to home directory
    ]

    # Create and launch the interface
    interface = create_interface()
    interface.launch(allowed_paths=allowed_paths)

if __name__ == "__main__":
    main()
