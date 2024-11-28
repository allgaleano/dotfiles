#!/bin/bash

# Get the variables from i3 config
FM=$(grep "set \$fm" ~/.config/i3/config | awk '{print $3}')
SM=$(grep "set \$sm" ~/.config/i3/config | awk '{print $3}')

log() {
	echo "[monitor-setup] $1"
}

log "Stopping all existing polybar instances..."
killall polybar 2> /dev/null

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Setup monitors
if xrandr | grep "$SM connected"; then
	log "External monitor detected, configuring dual display..."
    	xrandr --output $FM --primary --mode 1920x1080 --output $SM --mode 2560x1440 --rate 143.91 --above $FM
	
	log "Starting polybar on both displays..."
    	polybar laptop >/dev/null 2>&1 & 
    	polybar top_monitor >/dev/null 2>&1 & 
else
	log "Not external monitor detected, using laptop display only..."
    	xrandr --output $FM --primary --mode 1920x1080 --output $SM --off
    
	log "Starting polybar for laptop display..."
    	polybar laptop >/dev/null 2>&1  & 
fi

sleep 1  # Small delay to ensure monitor setup is complete
log "Applying wallpaper..."	
~/.config/i3/scripts/set-wallpaper.sh

log "Configuration complete!"
exit 0
