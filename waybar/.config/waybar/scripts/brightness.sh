#!/usr/bin/env bash
set -euo pipefail

operation=$1

if [[ "$operation" == "+" ]]; then
    (brightnessctl -c backlight set +5%) > /dev/null
    exit 0
else if [[ "$operation" == "-" ]]; then
    state=$(brightnessctl -c backlight -m)
    IFS=',' read -ra info <<< "$state"
    percent="${info[3]}"
    if [[ "$percent" == "5%" ]]; then
        exit 0
    else
        (brightnessctl -c backlight set 5%-) > /dev/null 
        exit 0
    fi
    exit 0
else
    exit 1
fi
fi
