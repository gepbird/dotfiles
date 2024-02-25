#!/bin/sh
msgTag="backlight"
@light@ -T "$@" # multiply brightness by argument
percentage=$(@light@ -G | @hck@ -d'\.' -f1)
@dunstify@ -a "changeBacklight" -u low -i audio-volume-high -h string:x-dunst-stack-tag:$msgTag -h int:value:"$percentage" "Brightness: ${percentage}%"
