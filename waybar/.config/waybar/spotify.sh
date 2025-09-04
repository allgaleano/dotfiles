#!/bin/bash

# This script checks the status of Spotify and formats the output for Waybar.

# Check if playerctl is installed
if ! command -v playerctl &> /dev/null; then
    echo "{\"text\":\"playerctl not found\", \"tooltip\":\"Install playerctl to use this module\"}"
    exit 1
fi

# Check the player status
PLAYER_STATUS=$(playerctl --player=spotify status 2>/dev/null)
EXIT_CODE=$?

# If the player is running, format the output
if [ $EXIT_CODE -eq 0 ]; then
    # Get metadata
    ARTIST=$(playerctl --player=spotify metadata artist)
    TITLE=$(playerctl --player=spotify metadata title)
    ALBUM=$(playerctl --player=spotify metadata album)
    
    # Truncate text to a maximum length to avoid Waybar overflow
    MAX_LEN=35
    if [ ${#TITLE} -gt $MAX_LEN ]; then
        TITLE="$(echo "$TITLE" | cut -c 1-$MAX_LEN)..."
    fi

    # Format the display text with a Spotify icon (requires a Nerd Font)
    TEXT="  $TITLE"
    TOOLTIP="$ARTIST - $ALBUM"
    
    # Set a CSS class based on the player status
    CLASS="playing"
    if [ "$PLAYER_STATUS" = "Paused" ]; then
        CLASS="paused"
    elif [ "$PLAYER_STATUS" = "Stopped" ]; then
        # If stopped, hide the module by outputting nothing
        echo ""
        exit 0
    fi
    
    # Output in JSON format for Waybar
    printf '{"text":"%s", "tooltip":"%s", "class":"%s"}\n' "$TEXT" "$TOOLTIP" "$CLASS"

else
    # If the player is not running, output nothing to hide the module
    echo ""
fi
