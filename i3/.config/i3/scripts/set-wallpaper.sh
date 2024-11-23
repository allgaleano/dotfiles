#!/bin/bash

WALLPAPERS_DIR="$HOME/Media/Pictures/wallpapers"

if [ -z "$WALLPAPER" ]; then
    echo "Error: No wallpaper specified. Please set WALLPAPER environment variable"
    exit 1
fi

WALLPAPER_PATH="$WALLPAPERS_DIR/$WALLPAPER_NAME"

if [ ! -f "$WALLPAPER_PATH" ]; then
    echo "Error: Wallpaper $WALLPAPER_NAME not found in $WALLPAPERS_DIR"
    exit 1
fi

feh --bg-fill "$WALLPAPER_PATH"
