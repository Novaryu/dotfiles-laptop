#!/bin/bash

# Get the number of windows in the current tmux session
num_windows=$(tmux list-windows | wc -l)

# Get the current window index
current_window_index=$(tmux display-message -p '#I')

# Check if there is only one window
if [ "$num_windows" -eq 1 ]; then
	tmux respawn-window -k
else
	tmux kill-window
fi
