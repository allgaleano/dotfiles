#!/bin/sh
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
then
    echo "%{F#666666}󰂲 OFF"
else
    if [ $(bluetoothctl info | grep "Connected: yes" | wc -c) -eq 0 ]
    then
        echo "%{F#39cfed}󰂯 %{F#ffffff}ON"
    else
        device_name=$(bluetoothctl info | grep "Name" | cut -d ":" -f2 | xargs)
        echo "%{F#39cfed}󰂯 %{F#ffffff}$device_name"
    fi
fi

