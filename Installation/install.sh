#!/bin/sh

## Go into root and create a temporary directory
sudo mkdir temp
sudo chown $USER temp
cd temp

## Define an install process for every application

firefox_dev() {
  wget -O firefox-dev.tar.bz2 "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64"
  tar xvf firefox-dev.tar.bz2
  sudo mv firefox /opt/firefox-dev
  sudo cp ../config/firefox-dev.desktop /usr/share/applications/firefox-dev.desktop
}

sublime_text() {
  wget -O - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
  sudo apt update
  sudo apt install -y sublime-text
}

discord() {
  sudo apt install -y discord
}

redshift() {
  cp ../config/redshift.conf ~/.config/redshift.conf
  sudo apt install -y redshift redshift-gtk
}

python() {
  sudo apt install -y python3-pip
  sudo apt install -y python-is-python3
  sudo apt install -y ipython3
}

postman() {
  wget -O Postman-linux-x64-8.10.0.tar.gz https://dl.pstmn.io/download/latest/linux64
  tar xvf Postman-linux-x64-8.10.0.tar.gz
  sudo mv Postman /opt/postman
  sudo cp ../config/postman.desktop /usr/share/applications/postman.desktop
}

flameshot() {
  sudo apt install -y flameshot
  # unbind default screenshot
  gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot-clip "[]"
  gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot-clip "[]"
  gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot "[]"
  gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot-clip "[]"
  gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot "[]"
  gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot "[]"
  # add insant and delay (2 sec) screenshot
  gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "[
		'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot-instant/',
		'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot-delayed/'
	]"
  # bind instant screenshot
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot-instant/ name 'flameshot-insant'
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot-instant/ command 'flameshot gui'
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot-instant/ binding '<Ctrl>Print'
  # bind delayed screenshot
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot-delayed/ name 'flameshot-delayed'
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot-delayed/ command 'flameshot gui -d 2000'
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot-delayed/ binding '<Ctrl><Shift>Print'
}

vs_code() {
  sudo apt install -y code
}

java() {
  # install java 8 and MOVE it to java-8
  sudo apt install -y openjdk-8-jdk
  sudo ln -s /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java /etc/alternatives/java-8
  sudo ln -s /etc/alternatives/java-8 /bin/java-8
  # install java 17 and COPY it to java-8
  sudo apt install -y openjdk-17-jdk
  sudo ln -s /usr/lib/jvm/java-17-openjdk-amd64/bin/java /etc/alternatives/java-17
  sudo ln -s /etc/alternatives/java-17 /bin/java-17
  # overall it make 'java-8', 'java-17' and 'java' which is 17
}

sqlite() {
  sudo apt install -y sqlite3
}

dbeaver() {
  sudo apt install -y dbeaver-ce
}

steam() {
  sudo apt install -y steam
}

lutris() {
  sudo apt install -y lutris
}

multimc() {
  wget https://files.multimc.org/downloads/multimc_1.5-1.deb
  sudo apt install -y ./multimc_1.5-1.deb
  rm multimc_1.5-1.deb
}

filezilla() {
  sudo apt install -y filezilla
}

ms_teams() {
  sudo apt install -y teams
}

vim() {
  sudo apt install -y neovim
  curl -sLf https://spacevim.org/install.sh | bash
}

anydesk() {
  wget https://download.anydesk.com/linux/anydesk_6.1.1-1_amd64.deb
  sudo dpkg -i anydesk_6.1.1-1_amd64.deb 
}

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
  gsettings set org.gnome.settings-daemon.plugins.media-keys search "['<Super>Tab']"           # show all apps and type to search
  gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Super>Left']"               # resize window and fit to left
  gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Super>Right']"             # resize window and fit to right
  gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>Up']"              # toggle maximize window
  gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>Down']"                    # minimize window
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

terminal_autocomplete_case_insensitive() {
  sudo echo "set completion-ignore-case on" >>/etc/inputrc
}

## Call the install functions

sudo apt full-upgrade

################################################################
################################################################
################## CHOOSE YOUR TOOLS BELOW #####################
################################################################
################################################################

firefox_dev
sublime_text
discord
redshift
python
postman
flameshot
vs_code
java
sqlite
dbeaver
steam
lutris
multimc
filezilla
ms_teams
vim
anydesk
gnome_keyboard_shortcuts
gnome_tweaks
gnome_extension_panel_osd
gnome_extension_no_annoyance
gnome_extension_system_monitor
terminal_autocomplete_case_insensitive

################################################################
################################################################
######################## END OF TOOLS ##########################
################################################################
################################################################

## Clean up
cd ..
sudo rm -rf temp
