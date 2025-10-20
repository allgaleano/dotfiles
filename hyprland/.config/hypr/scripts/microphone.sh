#!/bin/bash
wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

muted=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep MUTED)

if [ -n "$muted" ]; then
    notify-send -h string:x-canonical-private-synchronous:microphone "Microphone: Muted"
else
    notify-send -h string:x-canonical-private-synchronous:microphone "Microphone: Active"
fi