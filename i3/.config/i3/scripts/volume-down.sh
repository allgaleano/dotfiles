#!/bin/bash
current=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1)
new=$((current - 10))
if [ $new -lt 0 ]; then
    new=0
fi
pactl set-sink-mute @DEFAULT_SINK@ false
pactl set-sink-volume @DEFAULT_SINK@ ${new}%

# Get mute status
is_muted=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -o "yes")

# Select icon based on volume level
if [ -n "$is_muted" ]; then
    icon="audio-volume-muted-symbolic"
elif [ $new -lt 30 ]; then
    icon="audio-volume-low-symbolic"
elif [ $new -lt 70 ]; then
    icon="audio-volume-medium-symbolic"
else
    icon="audio-volume-high-symbolic"
fi

# Send notification
dunstify -i $icon -r 5000 -u normal "Volume: ${new}%" -h int:value:$new