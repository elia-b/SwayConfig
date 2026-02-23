#!/bin/bash

# Check if Bluetooth is powered on
powered=$(echo show | bluetoothctl | grep "Powered: yes")
if [ -z "$powered" ]; then
    echo '{"text": "", "tooltip": " Off", "class": "off"}'
    exit 0
fi

# List connected devices
devices=$(echo info | bluetoothctl | grep "Name:" | awk -F'Name: ' '{print $2}' | paste -sd ", " -)

batteries=$(echo info | bluetoothctl | grep "Battery Percentage" | sed 's/.*(\(.*\))/\1/' | paste -sd ", " -)

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
