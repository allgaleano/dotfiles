#!/bin/bash

# Your specific monitor names
PRIMARY="eDP"
SECONDARY="HDMI-A-1-0"

# Check if external monitor is connected
if xrandr | grep "^$SECONDARY connected"; then
    # External monitor is connected
    xrandr --output $SECONDARY --auto --above $PRIMARY
    notify-send "Monitor Setup" "External monitor configured above laptop display"
else
    # Only laptop display
    xrandr --output $PRIMARY --auto
    notify-send "Monitor Setup" "Single monitor mode"
fi

