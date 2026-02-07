#!/bin/bash

# Check if Bluetooth is powered on
powered=$(bluetoothctl show | grep "Powered: yes")
if [ -z "$powered" ]; then
    echo '{"text": "", "tooltip": " Off", "class": "off"}'
    exit 0
fi

# List connected devices
devices=$(bluetoothctl info | grep "Name:" | awk -F'Name: ' '{print $2}' | paste -sd ", " -)

batteries=$(bluetoothctl info | grep "Battery Percentage" | sed 's/.*(\(.*\))/\1/' | paste -sd ", " -)

if [ -z "$devices" ]; then
    echo '{"text": "", "tooltip": " On", "class": "on"}'
else
    first_battery=$(echo "$batteries" | cut -d',' -f1 | tr -d ' ')
    if [ -n "$first_battery" ] && [ "$first_battery" -lt 15 ]; then
        echo "{\"text\": \" $batteries%\", \"tooltip\":\"$devices\" , \"class\": \"connected-critical\"}"
    elif [ -n "$first_battery" ] && [ "$first_battery" -lt 30 ]; then
        echo "{\"text\": \" $batteries%\", \"tooltip\":\"$devices\" , \"class\": \"connected-warning\"}"
    else
        echo "{\"text\": \" $batteries%\", \"tooltip\":\"$devices\" , \"class\": \"connected\"}"
    fi
fi
