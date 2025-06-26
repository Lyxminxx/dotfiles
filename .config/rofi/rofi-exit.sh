#!/bin/bash

chosen=$(printf " Lock\n Sleep\n Reboot\n Shutdown\n󰜉 Exit" | rofi -dmenu -i -p "Power Menu" -theme config)

case "$chosen" in
    " Lock")
        swaylock -C ~/.config/swaylock/config
        ;;
    " Sleep")
        swaylock -C ~/.config/swaylock/config && sleep 1 && systemctl suspend
        ;;
    " Reboot")
        systemctl reboot
        ;;
    " Shutdown")
        systemctl poweroff
        ;;
    "󰜉 Exit")
        swaymsg exit
        ;;
esac

