#!/bin/bash

DOCK_CAM="/dev/video4"
LAPTOP_CAM="/dev/video0"

if [ -e "$DOCK_CAM" ]; then
    CAM="$DOCK_CAM"
else
    CAM="$LAPTOP_CAM"
fi

exec mpv av://v4l2:$CAM \
    --profile=low-latency \
    --untimed \
    --no-border \
    --force-window=immediate \
    --title="cam" \
    --vf=hflip \
    --autofit=100%x100%

