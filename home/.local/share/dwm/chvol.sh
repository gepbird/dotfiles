#!/bin/sh
pactl "$@"
msgTag="volume"
volume=$(pactl get-sink-volume 0 | rg '\d+%' -o | sed 's/%//;1q')
muted=$(pactl get-sink-mute 0)
output="Volume: $volume%"
test "$muted" = 'Mute: yes' && output="$output (muted)"
dunstify -a "changeVolume" -u low -i audio-volume-high -h string:x-dunst-stack-tag:$msgTag -h int:value:"$volume" "$output"
