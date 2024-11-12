#!/bin/bash

# Get the variables from i3 config
FM=$(grep "set \$fm" ~/.config/i3/config | awk '{print $3}')
SM=$(grep "set \$sm" ~/.config/i3/config | awk '{print $3}')

# Kill existing polybar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Setup monitors
if xrandr | grep "$SM connected"; then
    xrandr --output $FM --primary --mode 1920x1080 --rate 144 --dpi 96 --output $SM --mode 2560x1440 --rate 144 --above $FM --dpi 96
    
    polybar laptop 2>&1 | tee -a /tmp/polybar1.log & disown
    polybar top_monitor 2>&1 | tee -a /tmp/polybar2.log & disown
else
    xrandr --output $FM --primary --mode 1920x1080 --rate 144 --dpi 96 --output $SM --off
    
    polybar laptop 2>&1 | tee -a /tmp/polybar1.log & disown
fi

# Reapply wallpaper after monitor configuration
sleep 1  # Small delay to ensure monitor setup is complete
~/.config/i3/scripts/set-wallpaper.sh

echo "Monitors configured and Polybar launched..."