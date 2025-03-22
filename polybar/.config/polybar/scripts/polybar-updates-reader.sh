#!/bin/bash

# This script reads the update count from cache file and formats it for polybar

# Cache file location
CACHE_FILE="$HOME/.cache/polybar-updates"

# Default value if cache doesn't exist
updates=0

# Check if cache file exists and read from it
if [ -f "$CACHE_FILE" ]; then
    # Read first line (the update count)
    updates=$(head -n 1 "$CACHE_FILE")
    
    # Ensure it's a valid number
    if ! [[ "$updates" =~ ^[0-9]+$ ]]; then
        updates=0
    fi
    
    # If cache is older than 1 hour, trigger a refresh in background
    cache_time=$(stat -c %Y "$CACHE_FILE")
    current_time=$(date +%s)
    if [ $((current_time - cache_time)) -gt 3600 ]; then
        # Run update checker in background
        "$HOME/.config/polybar/scripts/check-updates-service.sh" &>/dev/null &
    fi
else
    # Cache doesn't exist, create it in background
    "$HOME/.config/polybar/scripts/check-updates-service.sh" &>/dev/null &
fi

# Color the output based on number of updates
if [ "$updates" -gt 200 ]; then
    # Critical level - red
    echo "%{F#fc8362}󰚰 $updates%{F-}"
elif [ "$updates" -gt 100 ]; then
    # Warning level - yellow (using your color 1)
    echo "%{F#ffd88a}󰚰 $updates%{F-}"
else
    # Normal level - use your theme color for updates (color 2)
    echo "󰚰 $updates"
fi

# Clicking will force refresh the cache
if [ "$1" = "refresh" ]; then
    "$HOME/.config/polybar/scripts/check-updates-service.sh" &>/dev/null &
    echo "Refreshing..."
fi