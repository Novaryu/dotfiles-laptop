#!/bin/bash
# Runs when system suspended.
# Suspends keyboard and
# Sets keyboard brightness to zero.

keyboard_device="ASUSTeK Computer Inc. N-KEY Device"

zenauracore brightness 0

sleep 0.01

xinput disable "$keyboard_device"

