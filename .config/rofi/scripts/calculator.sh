#!/bin/bash

# Ask for expression to calculate
expr=$(rofi -dmenu -p "Calc: Enter expression")

# If empty or canceled
[ -z "$expr" ] && exit 1

# Evaluate expression safely with bc
# Using 'scale=4' for decimals precision
result=$(echo "scale=4; $expr" | bc -l 2>/dev/null)

# Check if result is valid number
if [[ $? -ne 0 || -z "$result" ]]; then
    notify-send "Calculator" "Invalid expression"
    exit 1
fi

notify-send "Calculator Result" "$expr = $result"

