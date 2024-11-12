#!/usr/bin/env bash

killall xidlehook

# Run xidlehook
xidlehook \
  `# Don't lock when there's a fullscreen application` \
  --not-when-fullscreen \
  `# Don't lock when there's audio playing` \
  --not-when-audio \
  `# Dim the screen after 60 seconds, undim if user becomes active` \
  --timer 600 \
    'brightnessctl --save; brightnessctl set 50%' \
    'brightnessctl --restore' \
  `# Undim & warn about suspension after 10 seconds` \
  --timer 10 \
    'notify-send "System will suspend in 10 seconds" -u critical' \
    'brightnessctl --restore' \
  `# Suspend the system after 10 seconds` \
  --timer 10 \
    'systemctl suspend' \
    'brightnessctl --restore' \
  &