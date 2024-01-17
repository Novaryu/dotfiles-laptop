#!/bin/bash


zenauracore initialize_keyboard
sleep 0.5
brightness_file="$HOME/bin/keyboard_brightness"
if [ ! -e "$brightness_file" ]; then
  echo "Error: Brightness file not found!"
  exit 1
fi
previous_brightness=$(cat "$brightness_file")
zenauracore brightness "$previous_brightness"
sleep 0.5
zenauracore rainbow 1
