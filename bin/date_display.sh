line1="$(date '+%a, %b %d, %Y')"
line2="$(date '+%I:%M %p')"

notify-send --expire-time 1000 -r 1 "$line1" "⏱ $line2 ⏱"
