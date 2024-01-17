#!/bin/bash

TOUCHPAD_DEVICE="ASUP1413:00 093A:3F01 Touchpad"

# Check if the touchpad is enabled or disabled
TOUCHPAD_STATE=$(xinput list-props "$TOUCHPAD_DEVICE" | grep "Device Enabled" | awk '{print $NF}')

# Toggle the touchpad state
if [ "$TOUCHPAD_STATE" -eq 1 ]; then
    echo "Disabling touchpad..."
    xinput disable "$TOUCHPAD_DEVICE"
    echo "Touchpad disabled."
elif [ "$TOUCHPAD_STATE" -eq 0 ]; then
    echo "Enabling touchpad..."
    xinput enable "$TOUCHPAD_DEVICE"
    echo "Touchpad enabled."
else
    echo "Failed to determine touchpad state."
    exit 1
fi
