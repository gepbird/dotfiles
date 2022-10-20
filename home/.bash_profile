export _JAVA_AWT_WM_NONREPARENTING=1 # fix java apps blank screen
# auto startx on tty1-3
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -lt 4 ]; then
  exec startx
fi
