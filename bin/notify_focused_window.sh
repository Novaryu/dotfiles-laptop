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

# Grab the currently selected window character
char_between_pipes=$(echo "$window_list" | awk -F '|' '{print $2}')

# Use an additional symbol for 2-character window numbers
num_characters=$(echo -n "$char_between_pipes" | wc -c)
selected_character=" ▼ "

# Replace the window character with the selected character
delimiter_position=$(($(expr index "$window_list" "|")+1))
substring_before_delimiter="${window_list:0:delimiter_position-2}"
substring_after_delimiter="${window_list:delimiter_position+1}"
modified_window_list="${substring_before_delimiter}${selected_character}${substring_after_delimiter}"

# Replace all non-selected characters with another character
result=$(echo "$modified_window_list" | sed "s/[^$selected_character]/ /g")
# Remove the trailing character for 2-character window numbers
if [ $num_characters -eq 2 ]; then
	result="${result%?}"
fi

# Display notification
exec notify-send "$result" "$window_list" --expire-time=600 --replace-id=1
