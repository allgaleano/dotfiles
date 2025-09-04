#!/bin/bash

# This script checks for available updates from official repositories and the AUR,
# and assigns a CSS class based on the total number of updates.

# Dependencies: checkupdates (from pacman-contrib), yay

# Get update counts
official_updates=$(checkupdates | wc -l)
aur_updates=$(yay -Qua | wc -l)
total_updates=$((official_updates + aur_updates))

# If there are no updates, output nothing to hide the module
if [ "$total_updates" -eq 0 ]; then
    echo ""
    exit 0
fi

# Set the CSS class based on the number of updates
if [ "$total_updates" -gt 400 ]; then
    class="critical" # High number of updates
elif [ "$total_updates" -gt 200 ]; then
    class="warning"  # Medium number of updates
else
    class="available" # Low number of updates
fi

# Prepare the tooltip with a breakdown of updates
TOOLTIP="Official: $official_updates\nAUR: $aur_updates"

# Prepare the display text with an icon and the total count
# Icon requires a Nerd Font
TEXT="$total_updates  "

# Output in JSON format for Waybar
printf '{"text":"%s", "tooltip":"%s", "class":"%s"}\n' "$TEXT" "$TOOLTIP" "$class"
