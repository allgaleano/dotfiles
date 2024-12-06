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
        echo "󰂯 $device_name"
    fi
fi

