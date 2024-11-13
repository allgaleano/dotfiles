#!/usr/bin/env bash

killall xidlehook

# Run xidlehook
xidlehook \
  `# Don't lock when there's a fullscreen application` \
  --not-when-fullscreen \
  `# Don't lock when there's audio playing` \
  --not-when-audio \
  `# Dim the screen after 10 minutes, undim if user becomes active` \
  --timer 600 \
    'brightnessctl --save; brightnessctl set 50%' \
    'dunstctl close; brightnessctl --restore' \
  `# Undim & warn about suspension after 10 seconds` \
  --timer 1 \
    'notify-send "System will suspend in 10 seconds" -u critical' \
    'dunstctl close; brightnessctl --restore' \
  `# Suspend the system after 10 seconds` \
  --timer 10 \
    'systemctl suspend' \
    'dunstctl close; brightnessctl --restore' \
  &