#!/bin/bash

# This script checks for updates and writes the output in JSON format
# to a temporary file for Waybar to read.

# Define the cache file path
CACHE_FILE="/tmp/waybar-updates.json"

# Get official updates with better error handling
official_updates=0
checkupdates_output=$(checkupdates 2>&1)
checkupdates_exit=$?

if [ $checkupdates_exit -eq 0 ]; then
    official_updates=$(echo "$checkupdates_output" | grep -c '^')
elif [ $checkupdates_exit -eq 2 ]; then
    # Exit code 2 means no updates available
    official_updates=0
else
    # Other errors - log but continue
    echo "checkupdates failed with exit code $checkupdates_exit" >&2
    official_updates=0
fi

# Get AUR updates
aur_updates=0
yay_output=$(yay -Qua 2>&1)
yay_exit=$?

if [ $yay_exit -eq 0 ]; then
    aur_updates=$(echo "$yay_output" | grep -c '^')
else
    # yay failed - continue with 0
    aur_updates=0
fi

# Calculate total
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