#!/usr/bin/env bash

killall xidlehook

# Run xidlehook
xidlehook \
  `# Don't lock when there's a fullscreen application` \
  --not-when-fullscreen \
  `# Don't lock when there's audio playing` \
  --not-when-audio \
  --timer 600 \
    'dunstctl close' \
  --timer 1 \
    'notify-send "System will suspend in 10 seconds" -u critical' \
    'dunstctl close' \
  `# Suspend the system after 10 seconds` \
  --timer 10 \
    'systemctl suspend' \
    'dunstctl close' \
  &