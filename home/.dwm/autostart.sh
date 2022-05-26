#!/bin/sh
if [ "${XDG_VTNR}" -lt 4 ]; then
  setxkbmap -option "caps:swapescape"
  redshift &
  dunst &
  dwmblocks &
  discord &
  flameshot &
fi
