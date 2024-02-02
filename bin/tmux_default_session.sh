#!/bin/bash

# Check if tmux is installed
if ! command -v tmux &> /dev/null; then
    echo "tmux is not installed. Please install tmux first."
    exit 1
fi

# Check if a tmux server is already running
if ! tmux has-session -t default &> /dev/null; then
    tmux new-session -d -s default
fi

alacritty msg create-window -e tmux a -t default || alacritty -e tmux a -t default
