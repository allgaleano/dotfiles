#!/bin/bash
case $1 in
    up)
        brightnessctl s 10%+
        ;;
    down)
        brightnessctl s 10%-
        ;;
esac

# Calculate percentage manually since -P flag doesn't exist in brightnessctl 0.5
current=$(brightnessctl g)
max=$(brightnessctl m)
brightness=$((current * 100 / max))

notify-send -h string:x-canonical-private-synchronous:brightness -h int:value:$brightness "Brightness: ${brightness}%"