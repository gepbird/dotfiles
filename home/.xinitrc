#!/bin/sh
 
# dbus
systemctl --user import-environment DISPLAY XAUTHORITY
dbus-update-activation-environment DISPLAY XAUTHORITY

# for autostarting gui apps
GTK3_MODULES="xapp-gtk3-module"
export GTK3_MODULES

# disable palm rejection
xinput set-prop `xinput list | grep Touchpad | rg -o "id=\d+" | sed "s/id=//g"` "libinput Disable While Typing Enabled" 0
# fast key repeat
xset r rate 250 30
# disable screensaver
xset -dpms
xset s off
xset b off
# switch caps and esc
setxkbmap -option "caps:swapescape"

# auto start apps
redshift &
dunst &
dwmblocks &
dvm run stable &

while true; do
  dwm 2> ~/.cache/dwm.log
done
