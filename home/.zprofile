export _JAVA_AWT_WM_NONREPARENTING=1 # fix java apps blank screen
export GTK_THEME=Adwaita:dark # for GTK 3 and 4 apps
export QT_QPA_PLATFORMTHEME=gtk2 # for Qt 5 and 6 apps
# auto startx on tty1-3
if test -z "${DISPLAY}" && (test $(tty) = /dev/tty1 || test $(tty) = /dev/tty2 || test $(tty) = /dev/tty3) then
  exec startx
fi
