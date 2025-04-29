#!/bin/bash
pactl set-sink-mute @DEFAULT_SINK@ toggle

# Get current volume and mute status
current=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1)
is_muted=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -o "yes")

# Set notification based on mute status
if [ -n "$is_muted" ]; then
    dunstify -i "audio-volume-muted" -r 5000 -u normal "Volume Muted"
else
    # Select icon based on volume level
    if [ $current -lt 30 ]; then
        icon="audio-volume-low-symbolic"
    elif [ $current -lt 70 ]; then
        icon="audio-volume-medium-symbolic"
    else
        icon="audio-volume-high-symbolic"
    fi
    
    dunstify -i $icon -r 5000 -u normal "Volume: ${current}%" -h int:value:$current
fi