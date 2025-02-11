#!/bin/bash

# Syncs the database of pkgs usign the mirror list
yay -Sy &>/dev/null

check_updates=$(checkupdates 2>/dev/null | wc -l)
if [ -z "check_updates" ]; then
	check_updates=0
fi

aur_updates=$(yay -Qua 2>/dev/null | wc -l)
if [ -z "aur_updates" ]; then
	aur_updates=0
fi

echo "$check_updates | $aur_updates"

