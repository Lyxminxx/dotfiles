#!/bin/bash
value=$(zenity --scale --text="Set Brightness" --min-value=1 --max-value=100 --value=50)
[[ $value ]] && brightnessctl set "$value%"
