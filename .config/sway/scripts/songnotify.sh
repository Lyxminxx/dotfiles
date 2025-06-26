#!/bin/bash

# Get initial song
current=""

while true; do
    new=$(playerctl metadata --format '{{artist}} - {{title}}' 2>/dev/null)

    if [[ "$new" != "$current" && -n "$new" ]]; then
        current="$new"
        notify-send "󰽴 Now Playing" "$new"
    fi

    sleep 2
done
