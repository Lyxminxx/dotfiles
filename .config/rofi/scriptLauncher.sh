#!/bin/bash

SCRIPT_DIR="$HOME/.config/rofi/scripts"

# Find executable scripts with .sh extension
scripts=$(find "$SCRIPT_DIR" -maxdepth 1 -type f -executable -name "*.sh" -printf "%f\n")

# Remove .sh and capitalize first letter
menu_items=$(echo "$scripts" | sed 's/\.sh$//' | sed 's/^./\U&/')

# Show menu with capitalized names
chosen=$(echo "$menu_items" | rofi -dmenu -p "Run Script")

[ -z "$chosen" ] && exit 1

# Convert chosen back to lowercase first letter + rest (to match file name)
# Because original filenames are lowercase
# So just lowercase the first letter again:
script_name="$(echo $chosen | sed 's/^./\L&/')"

script_to_run="$SCRIPT_DIR/$script_name.sh"

# Run it in background
"$script_to_run" &

