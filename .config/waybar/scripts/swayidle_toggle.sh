#!/bin/bash

STATE_FILE="/tmp/swayidle_state"

# Check if swayidle is running
if pgrep -x swayidle > /dev/null; then
    # Kill it to disable idle stuff
    killall swayidle
    echo "off" > "$STATE_FILE"
    notify-send "☕ Caffeine Mode" "Swayidle disabled"
else
    # Restart swayidle
    swayidle -w \
        before-sleep 'swaymsg exec "swaylock -f"' \
        timeout 300 'swaymsg exec "swaylock -f"' \
        timeout 600 'swaymsg "output * power off"' \
        resume 'swaymsg "output * power on"' &
    echo "on" > "$STATE_FILE"
    notify-send "💤 Idle Mode" "Swayidle enabled"
fi
