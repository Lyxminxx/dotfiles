#!/bin/bash

# This is for Linux with upower. If you're using something else, let me know.
BATTERY=$(upower -e | grep BAT | head -n1)
INFO=$(upower -i "$BATTERY")

PERCENT=$(echo "$INFO" | grep "percentage" | awk '{print $2}')
STATE=$(echo "$INFO" | grep "state" | awk '{print $2}')
TIME=$(echo "$INFO" | grep -E "time to empty|time to full" | awk -F: '{print $2 ":" $3}' | xargs)

HEALTH=$(echo "$INFO" | grep "capacity" | awk '{print $2}')

MESSAGE="Battery: $PERCENT
Status: $STATE
Health: $HEALTH"

if [[ $STATE == "charging" ]]; then
    MESSAGE+="
Time to full: $TIME"
elif [[ $STATE == "discharging" ]]; then
    MESSAGE+="
Time to empty: $TIME"
fi

notify-send "󱐋 Battery Info" "$MESSAGE"
