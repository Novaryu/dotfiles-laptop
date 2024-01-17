#!/bin/bash

sleep 0.01

# Set the destination directory for temporary screenshots
DIR="${HOME}/Pictures/Screenshots"

# Ensure the destination directory exists
mkdir -p "$DIR"

# Define the temporary screenshot file name with timestamp
FILENAME="screenshot_$(date +%Y%m%d%H%M%S).png"

sleep 0.01

# Take the screenshot and save it to a temporary file
scrot -F "$DIR/$FILENAME" -q 100

sleep 0.01

# Notify the user about the successful screenshot
notify-send "Screenshot" "Saved to $DIR" --expire-time 1000
