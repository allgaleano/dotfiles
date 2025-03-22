#!/bin/bash

# This script checks for system and AUR updates and writes the count to a cache file
# Run this script periodically via cron or systemd timer

# Cache file location
CACHE_FILE="$HOME/.cache/polybar-updates"

# Make sure cache directory exists
mkdir -p "$(dirname "$CACHE_FILE")"

# Check system updates
if ! updates_arch=$(checkupdates 2> /dev/null | wc -l); then
    updates_arch=0
fi

# Check AUR updates
if ! updates_aur=$(yay -Qua 2> /dev/null | wc -l); then
    updates_aur=0
fi

# Calculate total
total_updates=$((updates_arch + updates_aur))

# Write to cache file
echo "$total_updates" > "$CACHE_FILE"

# Optional: add timestamp (useful for debugging)
echo "Last checked: $(date)" >> "$CACHE_FILE"
 
#  The script checks for system updates using  checkupdates  and AUR updates using  yay -Qua . The total number of updates is then written to a cache file. 
#  The script can be run periodically using a cron job or a systemd timer. 
#  To run the script every hour using a cron job, open the crontab file: 
#  crontab -e
 
#  Add the following line to the file: 
#  0 * * * * /path/to/checkupdates.sh
 
#  Replace  /path/to/checkupdates.sh  with the actual path to the script. 
#  Save the file and exit the editor. 
#  The script will now run every hour and write the number of updates to the cache file. 
#  Step 3: Display the update count in Polybar 
#  Now that the script is in place, we can display the update count in Polybar. 
#  Open the Polybar configuration file: 
#  Add the following module to the configuration file: 
#  [module/updates]