#!/bin/bash

# Set the path to the brightness file
brightness_file="/sys/class/backlight/intel_backlight/brightness"

# Define the minimum and maximum brightness values
min_brightness=6
max_brightness=400

# Read the current brightness value
current_brightness=$(cat $brightness_file)

# Function to adjust brightness
adjust_brightness() {
  local direction=$1
  local step=25

  if [ "$direction" == "up" ] && [ "$current_brightness" -lt 50 ]; then
	step=4
  fi

  if [ "$direction" == "down" ] && [ "$current_brightness" -le 50 ]; then
	step=4
  fi

  if [ "$direction" == "up" ]; then
    new_brightness=$((current_brightness + step))
  elif [ "$direction" == "down" ]; then
    new_brightness=$((current_brightness - step))
  else
    echo "Invalid argument. Use 'up' or 'down'."
    exit 1
  fi

  # Ensure the new brightness is within the specified range
  if [ $new_brightness -gt $max_brightness ]; then
    new_brightness=$max_brightness
  elif [ $new_brightness -lt $min_brightness ]; then
    new_brightness=$min_brightness
  fi

  # Update the brightness
  echo $new_brightness > $brightness_file
  echo "Brightness adjusted to $new_brightness."
  let percent=new_brightness/4
  exec notify-send -r 1 --expire-time 500 "Brightness" "🔆 $percent% 🔆"
  # exec notify-send -r 1 --expire-time 500 "🔆 $new_brightness 🔆"
}

# Check if an argument is provided
if [ $# -eq 1 ]; then
  adjust_brightness $1
else
  echo "Usage: $0 [up|down]"
  exit 1
fi

