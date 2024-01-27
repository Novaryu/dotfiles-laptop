#!/bin/bash

# Set the path to the brightness file
battery_file="/sys/class/power_supply/BAT0/capacity"

# Read the current brightness value
current_battery=$(cat $battery_file)

notify-send -r 1 --expire-time 1000 "Battery" "🔋 $current_battery% 🔋"
