## Gnome configurations saved for the current user, so make sure it's not root
if [ $USER = "root" ]
then
  echo "Run this script without sudo"
  exit
fi

gnome_keyboard_shortcuts() {
  # unbind conflict keys
  gsettings set org.gnome.desktop.wm.keybindings switch-input-source "[]"
  gsettings set org.gnome.desktop.wm.keybindings switch-applications "[]"
  gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "[]"
  gsettings set org.gnome.shell.extensions.pop-shell focus-left "[]"
  gsettings set org.gnome.shell.extensions.pop-shell focus-right "[]"
  gsettings set org.gnome.shell.extensions.pop-shell focus-up "[]"
  gsettings set org.gnome.shell.extensions.pop-shell focus-down "[]"
  # bind keys
  gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"                 # alt tab menu
  gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']" # alt tab menu go backwards
#  gsettings set org.gnome.settings-daemon.plugins.media-keys search "['<Super>']"           # show all apps and type to search
  gsettings set org.gnome.shell.keybindings toggle-application-view "['<Super>']"
  gsettings set org.gnome.shell.extensions.pop-shell activate-launcher "['<Super>Tab']"
  gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Super>Left', '<Super>h']"               # resize window and fit to left
  gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Super>Right', '<Super>l']"             # resize window and fit to right
  gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>Up', '<Super>k']"              # toggle maximize window
  gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>Down', '<Super>j']"                    # minimize window
}

gnome_tweaks() {
  sudo apt install -y gnome-tweaks
}

gnome_extension_panel_osd() {
  sudo apt install -y gnome-shell-extension-panel-osd
  gnome-shell-extension-tool -e panel-osd@berend.de.schouwer.gmail.com
  gsettings set org.gnome.shell.extensions.panel-osd x-pos 98
  gsettings set org.gnome.shell.extensions.panel-osd y-pos 2
  gsettings set org.gnome.shell.extensions.panel-osd force-expand true
}

gnome_extension_no_annoyance() {
  sudo apt install -y gnome-shell-extension-no-annoyance
  gnome-shell-extension-tool -e noannoyance@sindex.com
}

gnome_extension_multi_monitor() {
  sudo apt install -y gnome-shell-extension-multi-monitors
  gnome-shell-extension-tool -e multi-monitors-add-on@spin83
}

gnome_extension_system_monitor() {
  sudo apt install -y gir1.2-gtop-2.0 gir1.2-nm-1.0 gir1.2-clutter-1.0 gnome-system-monitor
  gnome-shell-extension-tool -e system-monitor@paradoxxx.zero.gmail.com
}

gnome_keyboard_shortcuts
gnome_tweaks
gnome_extension_panel_osd
gnome_extension_no_annoyance
gnome_extension_system_monitor

