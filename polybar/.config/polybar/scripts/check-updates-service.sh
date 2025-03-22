#!/bin/bash

# This script checks for system and AUR updates and writes the count to a cache file
# Run this script periodically via cron or systemd timer

# Cache file location
CACHE_FILE="$HOME/.cache/polybar-updates"

# Make sure cache directory exists
mkdir -p "$(dirname "$CACHE_FILE")"

# Check system updates
if ! updates_arch=$(checkupdates 2> /dev/null | wc -l); then
    updates_arch=0
fi

# Check AUR updates
if ! updates_aur=$(yay -Qua 2> /dev/null | wc -l); then
    updates_aur=0
fi

# Calculate total
total_updates=$((updates_arch + updates_aur))

# Write to cache file
echo "$total_updates" > "$CACHE_FILE"

# Optional: add timestamp (useful for debugging)
echo "Last checked: $(date)" >> "$CACHE_FILE"
