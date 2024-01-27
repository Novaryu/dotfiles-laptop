#!/bin/bash
# Runs when system woken from suspend.
# Resumes keyboard and
# Restores keyboard brightness to previous value.

keyboard_device="ASUSTeK Computer Inc. N-KEY Device"
brightness_file="home/ryu/bin/keyboard_brightness"

if [ ! -e "$brightness_file" ]; then
  echo "Error: Brightness file not found!"
  exit 1
fi

previous_brightness=$(cat "$brightness_file")

xinput enable "$keyboard_device"

sleep 0.01

zenauracore brightness "$previous_brightness"


