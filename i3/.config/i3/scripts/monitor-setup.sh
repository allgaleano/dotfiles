#!/bin/bash

# Get the list of connected displays
PRIMARY=$(xrandr | grep "eDP" | grep " connected" | cut -d" " -f1)
SECONDARY=$(xrandr | grep "HDMI\|DP" | grep " connected" | cut -d" " -f1)

# Check if external monitor is connected
if [[ ! -z "$SECONDARY" ]]; then
    # External monitor is connected
    xrandr --output "$SECONDARY" --auto --above "$PRIMARY"
else
    # Only laptop display
    xrandr --output "$PRIMARY" --auto
fi
