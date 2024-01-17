#!/bin/bash

direction=$1  # Accepts "up" or "down" as the first argument

if [ "$direction" == "up" ]; then
    amixer -c 1 sset 'PGA1.0 1 Master' 2dB+
    # pactl set-sink-volume @DEFAULT_SINK@ +10%
elif [ "$direction" == "down" ]; then
    amixer -c 1 sset 'PGA1.0 1 Master' 2dB-
    # pactl set-sink-volume @DEFAULT_SINK@ -10%
else
    echo "Usage: $0 [up|down]"
    exit 1
fi

sleep 0.001

volume_percent=$(amixer -c 1 sget 'PGA1.0 1 Master' | awk -F'[][%]' '/dB/ {print $2; exit}')
# volume_percent=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '/Volume:/ {print $5}' | tr -d '%')
exec notify-send -r 1 --expire-time 500 "🔈 $volume_percent% 🔈"
