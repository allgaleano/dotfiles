#!/bin/sh
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
then
    echo "󰂲 OFF"
else
    if [ $(bluetoothctl info | grep "Connected: yes" | wc -c) -eq 0 ]
    then
        echo "󰂯 ON"
    else
        device_name=$(bluetoothctl info | grep "Name" | cut -d ":" -f2 | xargs)
        battery_info=$(bluetoothctl info | grep "Battery Percentage")
        
        if [ -n "$battery_info" ]; then
            percentage=$(echo "$battery_info" | grep -o '[0-9]\+' | tail -1)
            if [ "$percentage" -ge 95 ]; then
                battery_icon=""
            elif [ "$percentage" -ge 75 ]; then
                battery_icon=""
            elif [ "$percentage" -ge 50 ]; then
                battery_icon=""
            elif [ "$percentage" -ge 25 ]; then
                battery_icon=""
            else
                battery_icon=""
            fi
            echo "󰂯 $device_name $battery_icon $percentage%"
        else
            echo "󰂯 $device_name"
        fi
    fi
fi