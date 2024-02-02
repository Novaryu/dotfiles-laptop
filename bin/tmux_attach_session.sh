#!/bin/bash

session_name=$(zenity --entry --title "Tmux Session" --text "Enter the tmux session name \n(blank = default): ")

if [[ $? -eq 1 ]]; then
	# If the user pressed Cancel, exit the script
	exit 1
fi

if [ -z "$session_name" ]; then
    # If the session name is empty, run create_tmux_session with sensible defaults
    ~/bin/tmux_default_session.sh
else
    # If a session name is provided, check if it exists
    tmux has-session -t "$session_name" 2>/dev/null

    if [ $? != 0 ]; then
        # If session does not exist, create a new session with the provided name
		alacritty msg create-window -e tmux new-session -s "$session_name" || alacritty -e tmux new-session -s "$session_name"
    else
        # If session exists, attach to it
		alacritty msg create-window -e tmux a -t "$session_name" || alacritty -e tmux a -t "$session_name"
    fi
fi
