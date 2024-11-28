#!/bin/bash

WALLPAPERS_DIR="$HOME/Media/Pictures/wallpapers"
WALLPAPER_FILE="$HOME/.config/wallpaper"

WALLPAPER_NAME=$(cat $WALLPAPER_FILE)

if [ -z "$WALLPAPER_NAME" ]; then
    echo "Error: No wallpaper specified in $WALLPAPER_FILE."
    exit 1
fi

WALLPAPER_PATH="$WALLPAPERS_DIR/$WALLPAPER_NAME"

if [ ! -f "$WALLPAPER_PATH" ]; then
    echo "Error: Wallpaper $WALLPAPER_NAME not found in $WALLPAPERS_DIR"
    exit 1
fi

feh --bg-fill "$WALLPAPER_PATH"
