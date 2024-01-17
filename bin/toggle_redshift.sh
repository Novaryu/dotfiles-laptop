#!/bin/bash

if pgrep -x "redshift" > /dev/null
then
	echo 50 > /sys/class/backlight/intel_backlight/brightness
	zenauracore rainbow 1
    pkill redshift
else
	echo 20 > /sys/class/backlight/intel_backlight/brightness
	zenauracore static 331100
    redshift -l 34.6:135.5 &
fi
