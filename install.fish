#!/bin/fish

## Since there are user specific settings, force the user to run without sudo
if test $USER = "root"
  echo "Run this script without sudo!"
  exit
end 

## Aliases
alias paci='paru -S --noconfirm --needed'
alias pacu='paru -Syy --noconfirm'

function link
  ./link.fish $argv[1]
end

set packages
function queue
  set packages $packages $argv[1]
end

## Define an install process for every application

function firefox
  queue community/firefox-developer-edition
end

function sublime_text
  queue aur/sublime-text-4
end

function discord
  queue community/discord
  link .config/autostart/discord.desktop
end

function redshift
  queue aur/redshift-gtk-git
  link .config/redshift.conf
  link .config/autostart/redshift-gtk.desktop
end

function fish
  link .config/fish/config.fish
  link .config/starship.toml
end

function python
  queue extra/python-pip
end

function postman
  queue aur/postman-bin
end

function flameshot
  paci community/flameshot
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
end

function git
  link .gitconfig
end

function vs_code
  queue aur/visual-studio-code-bin
  link .config/Code/User/settings.json
  link .config/Code/User/keybindings.json
  link .config/Code/User/.vimrc
end

function java
  # java-8
  sudo rm /bin/java
  paci extra/jdk8-openjdk
  sudo ln -sf /usr/lib/jvm/java-8-openjdk/bin/java /bin/java-8
  # java-17
  sudo rm /bin/java
  paci extra/jdk17-openjdk
  sudo ln -sf /usr/lib/jvm/java-17-openjdk/bin/java /bin/java-17
  # default java is 17
  sudo ln -sf /bin/java-17 /bin/java
end

function nodejs
  queue community/nodejs
end

function yarn
  queue community/yarn
end

function csharp
  queue community/dotnet-sdk
end

function sqlite
  queue core/sqlite
end

function dbeaver
  queue community/dbeaver
end

function wine
  queue multilib/wine
end

function steam
  queue multilib/steam
end

function heroic
  queue aur/heroic-games-launcher-bin
  link .config/heroic/config.json
  link .config/heroic/GamesConfig/CrabEA.json
end

function lutris
  queue community/lutris
end

function multimc
  queue aur/multimc-bin
end

function filezilla
  queue community/filezilla
  link .config/filezilla/sitemanager.xml
end

function teams
  queue aur/teams
end

function anydesk
  queue aur/anydesk-bin
end

function vim
  paci extra/vim
  paci community/neovim
  paci extra/xclip
  if ! test -d ~/.SpaceVim
    curl -Lv https://spacevim.org/install.sh | bash
    link .SpaceVim.d
  end
end

function swap_caps_and_esc
  gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape']"
end

function fman
  if ! grep -Fq '[fman]' /etc/pacman.conf
    sudo pacman-key --keyserver hkp://keyserver.ubuntu.com:80 -r 9CFAF7EB
    sudo pacman-key --lsign-key 9CFAF7EB
    echo -e '\n[fman]\nServer = https://fman.io/updates/arch' | sudo tee -a /etc/pacman.conf
    pacu
  end
  queue fman/fman
end

function obs
  queue community/obs-studio
end

function openshot
  queue community/openshot
end

function sshfs
  queue community/sshfs
end

function terminal_autocomplete_case_insensitive
  if ! grep -Fq 'set completion-ignore-case on' /etc/inputrc
    echo 'set completion-ignore-case on' | sudo tee -a /etc/inputrc
  end
end

function xampp
  queue aur/xampp
end

function gnome_keyboard_shortcuts
  # unbind conflict keys
  gsettings set org.gnome.desktop.wm.keybindings switch-input-source "[]"
  gsettings set org.gnome.desktop.wm.keybindings switch-applications "[]"
  gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "[]"
  # bind keys
  gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"                 # alt tab menu
  gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']" # alt tab menu go backwards
  gsettings set org.gnome.shell.keybindings toggle-application-view "['<Super>']"              # applications search
  gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Super>Left', '<Super>h']"   # resize window and fit to left
  gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Super>Right', '<Super>l']" # resize window and fit to right
  gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>Up', '<Super>k']"  # toggle maximize window
  gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>Down', '<Super>j']"        # minimize window
  gsettings set org.gnome.desktop.wm.keybindings close "['<Super>q']"                          # close window
  gsettings set org.gnome.settings-daemon.plugins.media-keys magnifier "['<Super>z']"          # turn on zoom
  gsettings set org.gnome.settings-daemon.plugins.media-keys magnifier-zoom-in "['<Super>.']"  # zoom in
  gsettings set org.gnome.settings-daemon.plugins.media-keys magnifier-zoom-out "['<Super>-']" # zoom out
end

function gnome
  paci gnome
  paci aur/chrome-gnome-shell
end

## Call the install functions

if ! test -n "$argv"
  ################################################################
  ################################################################
  ################## CHOOSE YOUR TOOLS BELOW #####################
  ################################################################
  ################################################################
  firefox
  sublime_text
  discord
  redshift
  fish
  python
  postman
  flameshot
  vs_code
  java
  csharp
  sqlite
  dbeaver
  wine
  steam
  heroic
  lutris
  multimc
  filezilla
  teams
  anydesk
  vim
  swap_caps_and_esc
  fman
  obs
  openshot
  sshfs
  terminal_autocomplete_case_insensitive
  xampp
  gnome_keyboard_shortcuts
  gnome
  ################################################################
  ################################################################
  ######################## END OF TOOLS ##########################
  ################################################################
  ################################################################
else
  for tool in $argv
    $tool
  end
end

# Install
if test -n "$packages"
  paci $packages
end
