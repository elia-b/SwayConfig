#!/bin/bash

current_volume=$(/usr/bin/wpctl get-volume @DEFAULT_AUDIO_SINK@)

volume="$(echo $current_volume | cut -f 2 -d " " | sed 's/\.//g')"

if [[ $current_volume == *"MUTED"* ]]; then
    echo '{"text": " ", "class": "mute"}'
fi

if [ "$volume" -lt "100" ]; then
    volume="${volume:1}"
fi

if [ "$volume" -lt "10" ]; then
     volume="${volume:1}"
fi


if [ "$volume" -gt "99" ]; then
    echo "{\"text\": \"  $volume%\", \"class\": \"high\"}"
elif [ "$volume" -gt "65" ]; then
    echo "{\"text\": \"  $volume%\", \"class\": \"high\"}"
elif [ "$volume" -gt "30" ]; then
    echo "{\"text\": \"  $volume%\", \"class\": \"medium\"}"
elif [ "$volume" -gt "10" ]; then
    echo "{\"text\": \"  $volume%\", \"class\": \"low\"}"
elif [ "$volume" -gt "0" ]; then
    echo "{\"text\": \"  $volume%\", \"class\": \"low\"}"
elif [ "$volume" -lt "1" ]; then
    echo "{\"text\": \"  0%\", \"class\": \"low\"}"
fi
