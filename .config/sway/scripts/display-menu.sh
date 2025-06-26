#!/bin/bash

choice=$(printf "Laptop only\nExternal only\nMirror\nExtend" | rofi -dmenu -p "Choose display mode:")

case "$choice" in
    "Laptop only")
        swaymsg output DP-2 disable
        swaymsg output eDP-1 enable resolution 1920x1200 scale 1 position 0 0
        ;;
    "External only")
        swaymsg output eDP-1 disable
        swaymsg output DP-2 enable resolution 1920x1080 scale 1 position 0 0
        ;;
    "Mirror")
        swaymsg output eDP-1 enable resolution 1920x1200 scale 1 position 0 0
        swaymsg output DP-2 enable resolution 1920x1080 scale 1 position 0 0
        ;;
    "Extend")
        swaymsg output eDP-1 enable resolution 1920x1200 scale 1 position 0 0
        swaymsg output DP-2 enable resolution 1920x1080 scale 1 position 0 1200
        ;;
    *)
        echo "No valid choice made"
        ;;
esac