#!/bin/bash

if pgrep -x swayidle > /dev/null; then
    echo "󰾫"  # or maybe  for sleepy mode
else
    echo "󰛊"  # coffee icon for caffeine mode
fi
