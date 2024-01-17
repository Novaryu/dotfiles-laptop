#!/bin/bash

sleep 0.1;

# Set the destination directory for temporary screenshots
TEMP_DIR="/tmp"

# Ensure the destination directory exists
mkdir -p "$TEMP_DIR"

# Define the temporary screenshot file name with timestamp
TEMP_FILENAME="screenshot_temp_$(date +%Y%m%d%H%M%S).png"

# Take the screenshot and save it to a temporary file
scrot -s "$TEMP_DIR/$TEMP_FILENAME"

# Copy the screenshot content to the clipboard
xclip -selection clipboard -t image/png -i "$TEMP_DIR/$TEMP_FILENAME"

# Clean up the temporary file
rm "$TEMP_DIR/$TEMP_FILENAME"

# Notify the user about the successful screenshot
notify-send "Screenshot" "Selection copied to clipboard" --expire-time 1000
