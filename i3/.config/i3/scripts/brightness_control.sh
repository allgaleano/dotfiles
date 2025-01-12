#!/bin/bash

# Get the maximum brightness
max_brightness=$(brightnessctl m)

# Get current brightness
current_raw=$(brightnessctl g)

# Calculate current percentage (rounded)
current_percent=$(( (current_raw * 100 + max_brightness/2) / max_brightness ))

# Function to set brightness by percentage
set_brightness() {
    target_percent=$1
    # Ensure percentage is between 0 and 100
    if [ $target_percent -lt 0 ]; then
        target_percent=0
    elif [ $target_percent -gt 100 ]; then
        target_percent=100
    fi
    # Convert percentage to raw value
    target_raw=$(( (target_percent * max_brightness + 50) / 100 ))
    brightnessctl s $target_raw
}

# Check first argument for up/down
if [ "$1" = "up" ]; then
    set_brightness $((current_percent + 10))
elif [ "$1" = "down" ]; then
    set_brightness $((current_percent - 10))
fi