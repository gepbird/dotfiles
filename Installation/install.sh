#!/bin/bash

## Since there are user specific settings, force the user to run without sudo
if [ $USER = "root" ]; then
  echo "Run this script without sudo!"
  exit
fi 

## Refresh the temporary directory
rm -vrf temp
mkdir -v temp
cd temp

## Define an install process for every application

install_firefox() {
  if [ ! -d '/opt/firefox-dev' ]; then
    wget -vO firefox-dev.tar.bz2 "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64"
    tar xvf firefox-dev.tar.bz2
    sudo mv -vn firefox /opt/firefox-dev
  fi
  sudo cp -vn ../config/firefox-dev.desktop /usr/share/applications/firefox-dev.desktop
}

install_sublime_text() {
  wget -vO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
  sudo apt update -y
  sudo apt install -y sublime-text
}

install_discord() {
  sudo apt install -y discord
}

install_redshift() {
  sudo apt install -y redshift redshift-gtk
}

install_python() {
  sudo apt install -y python3-pip
  sudo apt install -y python-is-python3
  sudo apt install -y ipython3
}

install_postman() {
  if [ ! -d '/opt/postman' ]; then
    wget -vO Postman-linux-x64-8.10.0.tar.gz https://dl.pstmn.io/download/latest/linux64
    tar xvf Postman-linux-x64-8.10.0.tar.gz
    sudo mv -vn Postman /opt/postman
  fi
  sudo cp -vn ../config/postman.desktop /usr/share/applications/postman.desktop
}

install_flameshot() {
  sudo apt install -y flameshot
  # unbind default screenshot
  gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot-clip "[]"
  gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot-clip "[]"
  gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot "[]"
  gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot-clip "[]"
  gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot "[]"
  gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot "[]"
  # bind all monitor screenshot (gnome)
  gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot-clip "['Print']"
  # bind focused window screenshot (gnome)
  gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot-clip "['<Alt>Print']"
  # add insant and delayed (2 sec) screenshot (flameshot)
  gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "[
		'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot-instant/',
		'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot-delayed/'
	]"
  # bind instant screenshot (flameshot)
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot-instant/ name 'flameshot-insant'
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot-instant/ command 'flameshot gui'
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot-instant/ binding '<Ctrl>Print'
  # bind delayed screenshot (flameshot)
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot-delayed/ name 'flameshot-delayed'
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot-delayed/ command 'flameshot gui -d 2000'
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot-delayed/ binding '<Ctrl><Shift>Print'
}

install_vs_code() {
  sudo apt install -y code
}

install_java() {
  # java-8
  sudo apt install -y openjdk-8-jdk
  sudo ln -sf /usr/lib/jvm/java-8-openjdk-amd64/bin/java /bin/java-8
  # java-16
  sudo apt install -y openjdk-16-jdk
  sudo ln -sf /usr/lib/jvm/java-16-openjdk-amd64/bin/java /bin/java-16
  # java-17
  sudo apt install -y openjdk-17-jdk
  sudo ln -sf /usr/lib/jvm/java-17-openjdk-amd64/bin/java /bin/java-17
  # default java
  sudo ln -sf /bin/java-17 /bin/java
}

install_nodejs() {
  wget -v https://nodejs.org/dist/v17.3.0/node-v17.3.0-linux-x64.tar.xz
  tar xvf node-v17.3.0-linux-x64.tar.xz
  sudo mv -v node-v17.3.0-linux-x64 /opt/nodejs
  sudo ln -sf /opt/nodejs/bin/node /bin/node
  sudo ln -sf /opt/nodejs/bin/npm /bin/npm
}

install_yarn() {
  curl -v https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt update 
  sudo apt install -y yarn
}

install_csharp() {
  sudo apt install -y gnupg ca-certificates
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
  echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
  sudo apt update
  sudo apt install -y mono-devel
}

install_sqlite() {
  sudo apt install -y sqlite3
}

install_dbeaver() {
  sudo apt install -y dbeaver-ce
}

install_steam() {
  sudo apt install -y steam
}

install_lutris() {
  sudo apt install -y lutris
}

install_multimc() {
  if [[ ! `apt list --installed | grep multimc/now` ]]; then
    wget -v https://files.multimc.org/downloads/multimc_1.5-1.deb
    sudo apt install -y ./multimc_1.5-1.deb
  fi
}

install_filezilla() {
  sudo apt install -y filezilla
}

install_teams() {
  if [[ ! `apt list --installed | grep teams/stable` ]]; then
    wget -v https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_1.4.00.26453_amd64.deb 
    sudo apt install -y ./teams_1.4.00.26453_amd64.deb 
  fi
}

install_anydesk() {
  wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
  sudo bash -c 'echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list'
  sudo apt update
  sudo apt install -y anydesk
}

install_vim() {
  sudo apt install -y vim
  sudo apt install -y vim-gtk
  sudo apt install -y neovim
  curl -Lv https://spacevim.org/install.sh | bash
}

swap_caps_and_esc() {
  gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape']"
}

install_fman() {
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 45BCC825BC281C06D2A7F912B015FE599CFAF7EB
  sudo apt install -y apt-transport-https
  sudo echo "deb [arch=amd64] https://fman.io/updates/ubuntu/ stable main" | sudo tee /etc/apt/sources.list.d/fman.list
  sudo apt update
  sudo apt install -y fman
}

install_sshfs() {
  sudo apt install -y sshfs
}

terminal_autocomplete_case_insensitive() {
  sudo bash -c 'echo "set completion-ignore-case on" >> /etc/inputrc'
}

install_xampp() {
  if [ ! -d '/opt/lampp' ]; then
    wget -v https://www.apachefriends.org/xampp-files/8.0.12/xampp-linux-x64-8.0.12-0-installer.run
    sudo chmod +x xampp-linux-x64-8.0.12-0-installer.run
    sudo ./xampp-linux-x64-8.0.12-0-installer.run
    sudo ln -sf /opt/lampp/xampp /bin/xampp
  fi
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
  sudo apt install -y gir1.2-gtop-2.0 gir1.2-nm-1.0 gir1.2-clutter-1.0 gnome-shell-extension-system-monitor 
  gnome-shell-extension-tool -e system-monitor@paradoxxx.zero.gmail.com
}

## Call the install functions

sudo apt full-upgrade -y

if [ $# = 0 ]; then
################################################################
################################################################
################## CHOOSE YOUR TOOLS BELOW #####################
################################################################
################################################################
  install_firefox
  install_sublime_text
  install_discord
  install_redshift
  install_python
  install_postman
  install_flameshot
  install_vs_code
  install_java
  install_csharp
  install_sqlite
  install_dbeaver
  install_steam
  install_lutris
  install_multimc
  install_filezilla
  install_teams
  install_anydesk
  install_vim
  swap_caps_and_esc
  install_fman
  install_sshfs
  terminal_autocomplete_case_insensitive
  install_xampp
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
else
  for tool in $*
  do
    $tool
  done
fi

## Clean up
cd ..
sudo rm -vrf temp
