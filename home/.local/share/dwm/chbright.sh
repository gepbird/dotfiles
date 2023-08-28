#!/bin/sh
backlight_control "$@"
msgTag="backlight"
light -T "$@" # multiply brightness by argument
percentage=$(light -G | cut -d '.' -f 1)
dunstify -a "changeBacklight" -u low -i audio-volume-high -h string:x-dunst-stack-tag:$msgTag -h int:value:"$percentage" "Brightness: ${percentage}%"
