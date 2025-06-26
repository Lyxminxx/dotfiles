#!/bin/bash

# Your internal laptop screen
laptop="eDP-1"

# Get list of connected (active) outputs other than the laptop screen
external=$(swaymsg -t get_outputs | jq -r \
  --arg laptop "$laptop" \
  '.[] | select(.active and .name != $laptop) | .name')

if [ -n "$external" ]; then
  # External display(s) connected
  swaymsg output "$laptop" disable
  for monitor in $external; do
    swaymsg output "$monitor" mode 1920x1080 pos 0 0 enable
  done
else
  # No external displays, re-enable laptop screen
  swaymsg output "$laptop" mode 1920x1200 pos 0 0 enable
fi

