#!/bin/bash

GAP_STATE_FILE="/tmp/sway-gaps-state"

# If the file doesn't exist, assume gaps are on
if [ ! -f "$GAP_STATE_FILE" ]; then
    echo "on" > "$GAP_STATE_FILE"
fi

STATE=$(cat "$GAP_STATE_FILE")

if [ "$STATE" = "on" ]; then
    swaymsg gaps inner all set 0
    swaymsg gaps outer all set 0
    echo "off" > "$GAP_STATE_FILE"
else
    swaymsg gaps inner all set 8
    swaymsg gaps outer all set 8
    echo "on" > "$GAP_STATE_FILE"
fi
