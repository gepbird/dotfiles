# swap caps and esc
setxkbmap -option "caps:swapescape"

exec dwm
# start xserver on tty1-3
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -lt 4 ]; then
  exec startx
fi
