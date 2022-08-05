#!/bin/sh
if [ "${XDG_VTNR}" -lt 4 ]; then
  # disable palm rejection
  xinput set-prop `xinput list | grep Touchpad | rg -o "id=\d+" | sed "s/id=//g"` "libinput Disable While Typing Enabled" 0
  xset r rate 250 30
  xset -dpms
  xset s off
  xset b off
  setxkbmap -option "caps:swapescape"
  redshift &
  dunst &
  dwmblocks &
  discord &
fi
