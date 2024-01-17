#!/bin/bash

# File path for brightness
brightness_file="$HOME/bin/keyboard_brightness"

# Check if the brightness file exists
if [ ! -e "$brightness_file" ]; then
  echo "Error: Brightness file not found!"
  exit 1
fi

# Read current brightness level
current_brightness=$(cat "$brightness_file")

# Increment brightness level
new_brightness=$(( (current_brightness + 1) % 4 ))

# Update brightness using zenauracore
zenauracore brightness "$new_brightness"

# Update the brightness file with the new value
echo "$new_brightness" > "$brightness_file"

echo "Brightness level updated to $new_brightness"

exec notify-send -r 1 --expire-time 500 "Keylight" " ⌨  $new_brightness/3  ⌨ "
