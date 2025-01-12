#!/bin/bash
current=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1)
new=$((current + 10))
if [ $new -gt 100 ]; then
    new=100
fi
pactl set-sink-mute @DEFAULT_SINK@ false
pactl set-sink-volume @DEFAULT_SINK@ ${new}%