setterm -blength 0
# auto startx on tty1-3
if test -z "${DISPLAY}" && (test $(tty) = /dev/tty1 || test $(tty) = /dev/tty2 || test $(tty) = /dev/tty3) then
  exec startx
fi
