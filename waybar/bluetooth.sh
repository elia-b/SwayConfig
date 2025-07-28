#!/bin/bash

# Check if Bluetooth is powered on
powered=$(bluetoothctl show | grep "Powered: yes")
if [ -z "$powered" ]; then
    echo '{"text": "", "tooltip": " Off", "class": "off"}'
    exit 0
fi

# List connected devices
devices=$(bluetoothctl info | grep "Name:" | awk -F'Name: ' '{print $2}' | paste -sd ", " -)

batteries=$(upower -i "$(upower -e | grep -i headphones)" | grep -E "percentage" | awk '{print $2}' | tr -d '%' | paste -sd ", " -)

if [ -z "$devices" ]; then
    echo '{"text": "", "tooltip": " On", "class": "on"}'
else
    if [ "$batteries" -lt 15 ]; then
        echo "{\"text\": \" $batteries%\", \"tooltip\":\"$devices\" , \"class\": \"connected-critical\"}"
    elif [ "$batteries" -lt 30 ]; then
        echo "{\"text\": \" $batteries%\", \"tooltip\":\"$devices\" , \"class\": \"connected-warning\"}"
    else
        echo "{\"text\": \" $batteries%\", \"tooltip\":\"$devices\" , \"class\": \"connected\"}"
    fi
fi
