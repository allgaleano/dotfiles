#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch main bar
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar laptop 2>&1 | tee -a /tmp/polybar1.log & disown

# Check if HDMI is connected and launch second bar if it is
if xrandr | grep "HDMI-A-1-0 connected"; then
    polybar top_monitor 2>&1 | tee -a /tmp/polybar2.log & disown
fi

echo "Bars launched..."