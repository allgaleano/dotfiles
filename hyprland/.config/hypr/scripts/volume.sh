#!/bin/bash
case $1 in
    up)
        wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
        ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
esac

volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep MUTED)

if [ -n "$muted" ]; then
    notify-send -h string:x-canonical-private-synchronous:volume -h int:value:0 "Volume: Muted"
else
    notify-send -h string:x-canonical-private-synchronous:volume -h int:value:$volume "Volume: ${volume}%"
fi