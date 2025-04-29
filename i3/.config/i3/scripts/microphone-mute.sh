#!/bin/bash
pactl set-source-mute @DEFAULT_SOURCE@ toggle

# Get mute status
is_muted=$(pactl get-source-mute @DEFAULT_SOURCE@ | grep -o "yes")

# Set notification based on mute status
if [ -n "$is_muted" ]; then
    dunstify -i "microphone-disabled-symbolic" -r 5001 -u normal "Microphone OFF"
else
    dunstify -i "microphone-symbolic" -r 5001 -u normal "Microphone ON"
fi