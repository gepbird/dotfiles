#!/bin/bash

if [ "${XDG_VTNR}" -lt 4 ]; then
  redshift &
  dunst &
  dwmblocks &
  discord &
  flameshot &
fi
