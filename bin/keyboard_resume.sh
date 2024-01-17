#!/bin/bash
# Runs when system woken from suspend.
# Restores keyboard brightness to previous value.

brightness_file="home/ryu/bin/keyboard_brightness"

if [ ! -e "$brightness_file" ]; then
  echo "Error: Brightness file not found!"
  exit 1
fi

previous_brightness=$(cat "$brightness_file")

zenauracore brightness "$previous_brightness"
