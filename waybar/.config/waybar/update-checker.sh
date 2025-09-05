#!/bin/bash

# This script checks for updates and writes the output in JSON format
# to a temporary file for Waybar to read.

# Define the cache file path
CACHE_FILE="/tmp/waybar-updates.json"

# Get update counts
official_updates=$(checkupdates 2>/dev/null | wc -l)
aur_updates=$(yay -Qua 2>/dev/null | wc -l)
total_updates=$((official_updates + aur_updates))

# If there are no updates, write an empty JSON object to the file
if [ "$total_updates" -eq 0 ]; then
    echo '{}' > "$CACHE_FILE"
    exit 0
fi

# Set the CSS class
if [ "$total_updates" -gt 400 ]; then
    class="critical"
elif [ "$total_updates" -gt 200 ]; then
    class="warning"
else
    class="available"
fi

# Prepare tooltip and text
TOOLTIP="Official: $official_updates\nAUR: $aur_updates"
TEXT="$total_updates  "

# Write the JSON output to the cache file
printf '{"text":"%s", "tooltip":"%s", "class":"%s"}\n' "$TEXT" "$TOOLTIP" "$class" > "$CACHE_FILE"