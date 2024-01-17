#!/bin/bash

pactl set-sink-mute @DEFAULT_SINK@ toggle

sleep 0.001

muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '/Mute:/ {print $2}')
echo $muted
if [ "$muted" == "yes" ]; then
    notify-send -r 1 --expire-time 500 "Volume" "🔇  Mute  🔇"
else
    notify-send -r 1 --expire-time 500 "Volume" "🔈 Unmute 🔈"
fi
