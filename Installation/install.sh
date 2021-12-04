#!/bin/sh

## Since there are user specific settings, force the user to run without sudo
if [ $USER = "root" ]
then
  echo "Run this script without sudo!"
  exit
fi 

## Go into root and create a temporary directory
mkdir temp
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
  sudo apt update -y
  sudo apt install -y sublime-text
}

discord() {
  sudo apt install -y discord
}

redshift() {
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
  sudo sudo mv Postman /opt/postman
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
  # install java 16 and COPY it to java-8
  sudo apt install -y openjdk-16-jdk
  sudo ln -s /usr/lib/jvm/java-16-openjdk-amd64/bin/java /etc/alternatives/java-16
  sudo ln -s /etc/alternatives/java-16 /bin/java-16
  # overall it make 'java-8', 'java-16' and 'java' which is 16
}

csharp() {
  wget https://download.visualstudio.microsoft.com/download/pr/17b6759f-1af0-41bc-ab12-209ba0377779/e8d02195dbf1434b940e0f05ae086453/dotnet-sdk-6.0.100-linux-x64.tar.gz
  mkdir dotnet
  tar xvf dotnet-sdk-6.0.100-linux-x64.tar.gz -C dotnet
  sudo mv dotnet /opt
  sudo ln -s /opt/dotnet/dotnet /bin/dotnet
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
}

filezilla() {
  sudo apt install -y filezilla
}

ms_teams() {
  wget https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_1.4.00.26453_amd64.deb 
  sudo apt install -y ./teams_1.4.00.26453_amd64.deb 
}

vim() {
  sudo apt install -y neovim
  curl -sLf https://spacevim.org/install.sh | bash
}

swap_caps_and_esc() {
  gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape']"
}

anydesk() {
  wget https://download.anydesk.com/linux/anydesk_6.1.1-1_amd64.deb
  sudo apt install -y ./anydesk_6.1.1-1_amd64.deb 
}

fman() {
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 45BCC825BC281C06D2A7F912B015FE599CFAF7EB
  sudo apt install -y apt-transport-https
  sudo echo "deb [arch=amd64] https://fman.io/updates/ubuntu/ stable main" | sudo tee /etc/apt/sources.list.d/fman.list
  sudo apt update
  sudo apt install fman
}

sshfs() {
  sudo apt install -y sshfs
}

terminal_autocomplete_case_insensitive() {
  sudo echo bash -c '"set completion-ignore-case on" >> /etc/inputrc'
}

xampp() {
  wget https://www.apachefriends.org/xampp-files/8.0.12/xampp-linux-x64-8.0.12-0-installer.run
  sudo chmod +x xampp-linux-x64-8.0.12-0-installer.run
  sudo ./xampp-linux-x64-8.0.12-0-installer.run
  sudo ln -s /opt/lampp/xampp /bin/xampp
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
  gsettings set org.gnome.shell.keybindings toggle-application-view "['<Super>']"              # applications search
  gsettings set org.gnome.shell.keybindings toggle-overview "['<Super>Tab']"                   # show workspaces
  gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Super>Left', '<Super>h']"   # resize window and fit to left
  gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Super>Right', '<Super>l']" # resize window and fit to right
  gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>Up', '<Super>k']"  # toggle maximize window
  gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>Down', '<Super>j']"        # minimize window
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

## Call the install functions

sudo apt full-upgrade -y

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
csharp
sqlite
dbeaver
steam
lutris
multimc
filezilla
ms_teams
vim
swap_caps_and_esc
anydesk
fman
sshfs
terminal_autocomplete_case_insensitive
xampp
gnome_keyboard_shortcuts
gnome_tweaks
gnome_extension_panel_osd
gnome_extension_no_annoyance
gnome_extension_system_monitor
################################################################
################################################################
######################## END OF TOOLS ##########################
################################################################
################################################################

## Clean up
cd ..
sudo rm -rf temp
