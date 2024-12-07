#!/bin/bash

# Modern power menu using rofi with consistent theming
# Make sure to place the theme file in ~/.config/rofi/power-menu.rasi

# Commands
poweroff_command="systemctl poweroff"
reboot_command="systemctl reboot"
logout_command="i3-msg exit"
hibernate_command="systemctl hibernate"
suspend_command="systemctl suspend"

# Options with icons
options=(
    "󰽥 Suspend"
    " Power Off"
    " Reboot"
    " Hibernate"
    "󰍃 Logout"
)

# Create the menu string
menu_string=$(printf '%s\n' "${options[@]}")

# Launch rofi with custom theme
chosen="$(echo -e "$menu_string" | rofi -dmenu -i -theme ~/.config/rofi/launchers/type-1/power-menu.rasi)"

# Handle the selection
case $chosen in
    "${options[0]}") $suspend_command ;;    # Suspend
    "${options[1]}") $poweroff_command ;;   # Power Off
    "${options[2]}") $reboot_command ;;     # Reboot
    "${options[3]}") $hibernate_command ;;  # Hibernate
    "${options[4]}") $logout_command ;;     # Logout
esac