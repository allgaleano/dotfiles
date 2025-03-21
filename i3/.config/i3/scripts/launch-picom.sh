#!/bin/bash
# Kill all instances of picom
killall -q picom

# Wait until the processes have been shut down
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done

# Launch picom
picom --config ~/.config/picom/picom.conf &