#!/bin/bash

STATE_FILE="$HOME/.cache/mako-dnd"
ICON_ON=" "
ICON_OFF=" "

# Only toggle when explicitly told
if [[ "$1" == "toggle" ]]; then
    if [[ -f "$STATE_FILE" ]]; then
        makoctl set-mode ""
        rm "$STATE_FILE"
    else
        makoctl set-mode do-not-disturb
        touch "$STATE_FILE"
    fi
fi

# Show icon only
[[ -f "$STATE_FILE" ]] && echo "$ICON_OFF" || echo "$ICON_ON"
