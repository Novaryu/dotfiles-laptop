#!/bin/bash

TOUCHPAD_DEVICE="ASUP1413:00 093A:3F01 Touchpad"

# Check if the touchpad is enabled or disabled
TOUCHPAD_STATE=$(xinput list-props "$TOUCHPAD_DEVICE" | grep "Device Enabled" | awk '{print $NF}')

# Toggle the touchpad state
if [ "$TOUCHPAD_STATE" -eq 1 ]; then
    xinput disable "$TOUCHPAD_DEVICE"
    echo "Touchpad disabled."
	exec notify-send "Touchpad" "□ Inactive □" --expire-time=500 --replace-id=1
elif [ "$TOUCHPAD_STATE" -eq 0 ]; then
    xinput enable "$TOUCHPAD_DEVICE"
    echo "Touchpad enabled."
	exec notify-send "Touchpad" "■  Active  ■" --expire-time=500 --replace-id=1
else
    echo "Failed to determine touchpad state."
    exit 1
fi

exec notify-send "Touchpad:" "$TOUCHPAD_STATE" --expire-time=600 --replace-id=1
