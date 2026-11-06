#!/bin/bash

# 1. Ensure the directory exists
TARGET_DIR="/home/roshand/Pictures/Screenshots"
mkdir -p "$TARGET_DIR"

# 2. Generate a clean timestamp string
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
FILE_PATH="$TARGET_DIR/Screenshot_$TIMESTAMP.png"

# 3. Capture based on the execution flag
if [ "$1" == "area" ]; then
    grim -g "$(slurp)" "$FILE_PATH"
else
    grim "$FILE_PATH"
fi

# 4. If the file was successfully written, push it straight to the clipboard
if [ -f "$FILE_PATH" ]; then
    wl-copy < "$FILE_PATH"
fi
