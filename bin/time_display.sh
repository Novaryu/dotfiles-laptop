#!/bin/bash
time="$(date '+%H:%M')"

notify-send --expire-time 1000 -r 1 "Time" "$time"
