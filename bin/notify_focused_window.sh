#!/bin/bash

# Run i3-msg and capture its output
json_data=$(i3-msg -t get_workspaces 2>&1)

# Check if the command was successful
if [ $? -ne 0 ]; then
    echo "Error running i3-msg: $json_data"
    exit 1
fi

# Parse the output
window_list=$(~/bin/cpp/parse_i3 "$json_data")

exec notify-send "$window_list" --expire-time=600 --replace-id=1
