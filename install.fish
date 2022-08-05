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

function link_su
  ./link.fish $argv[1] 1
end

set packages
function queue
  set packages $packages $argv[1]
end

## Define an install process for every application

function firefox
  queue community/firefox-developer-edition
end

function chromium
 queue extra/chromium
end

function sublime_text
  queue aur/sublime-text-4
end

function discord
  queue community/discord
end

function redshift
  queue aur/redshift-git
  link .config/redshift.conf
end

function nerdfonts
  paci ttf-iosevka-nerd
  ln -vsf /usr/share/fonts/TTF/Iosevka\ Nerd\ Font\ Complete.ttf \
  ~/.local/share/fonts/Iosevka\ Nerd\ Font\ Complete.ttf
end

function fish
  link .config/fish/config.fish
  link_su .config/fish/config.fish
  link .config/starship.toml
  link_su .config/starship.toml
  nerdfonts
end

function python
  queue extra/python-pip
end

function postman
  queue aur/postman-bin
end

function flameshot
  paci community/flameshot
end

function gitconfig
  link .gitconfig
end

function vscode
  queue aur/visual-studio-code-bin
  link .config/Code/User/settings.json
  link .config/Code/User/keybindings.json
  link .config/Code/User/.vimrc
  link .vscode/extensions/extension-manager.c#-profile-1.0.0
  link .vscode/extensions/extension-manager.cpp-profile-1.0.0
  link .vscode/extensions/extension-manager.flutter-profile-1.0.0
  link .vscode/extensions/extension-manager.java-profile-1.0.0
  link .vscode/extensions/extension-manager.laravel-profile-1.0.0
  link .vscode/extensions/extension-manager.php-profile-1.0.0
  link .vscode/extensions/extension-manager.python-profile-1.0.0
  link .vscode/extensions/extension-manager.quality-of-life-1.0.0
  link .vscode/extensions/extension-manager.scripting-profile-1.0.0
  link .vscode/extensions/extension-manager.viewers,-syntax-highlighters-1.0.0
  link .vscode/extensions/extension-manager.web-frontend-profile-1.0.0
end

function java
  # java-8
  sudo rm /bin/java
  paci extra/jdk8-openjdk
  sudo ln -sf /usr/lib/jvm/java-8-openjdk/bin/java /bin/java-8
  # java-18
  sudo rm /bin/java
  paci extra/jdk18-openjdk
  sudo ln -sf /usr/lib/jvm/java-18-openjdk/bin/java /bin/java-18
  # default java is 18
  sudo ln -sf /bin/java-18 /bin/java
end

function nodejs
  queue community/nodejs
end

function yarn
  queue community/yarn
end

function dotnet
  paci aur/dotnet-runtime-bin
  queue community/dotnet-sdk
end

function sqlite
  queue core/sqlite
end

function dbeaver
  queue community/dbeaver
end

function onlyoffice
  queue aur/onlyoffice-bin
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

function minecraft
  queue chaotic-aur/polymc
  queue aur/mcrcon
end

function osu
  queue aur/osu-lazer-git
  queue aur/opentabletdriver-git
end

function filezilla
  queue community/filezilla
  link .config/filezilla/sitemanager.xml
end

function teams
  queue aur/teams
end

function packet_tracer
  if ! paru -Q | grep -q packettracer
    git clone https://aur.archlinux.org/packettracer.git
    set deb_link 'https://www.netacad.com/portal/resources/file/7b1849d4-dd2c-4e4d-aded-195fd82feca9'
    set downloads_link 'https://www.netacad.com/portal/node/488'
    echo "-------------------------------------------------"
    echo "Log in to netacad and"
    echo " - download packet tracer version 8.1.1 from $deb_link"
    echo " - or choose another version from $downloads_link "
    echo "Wait for the download to complete"
    echo "If the script doesnt continue, try manually moving the downloaded deb file to "(pwd)"/packettracer"
    echo "-------------------------------------------------"
    echo "Waiting for the debian file..."
    xdg-open $deb_link 2>/dev/null
    set deb_file 'CiscoPacketTracer_[0-9]+_Ubuntu_64bit.deb'
    set detected_deb false
    # check if the deb file downloaded in ~/Downloads then move it to to the cloned AUR repo
    while true
      if ls ~/Downloads | grep -q $deb_file
        if ! ls ~/Downloads | grep -q $deb_file.part
          mv ~/Downloads/CiscoPacketTracer_*_Ubuntu_64bit.deb packettracer
        end
        if ! $detected_deb
          set detected_deb true
          echo "Found debian file in downloads directory, waiting for download to complete..."
        end
      end
      if ls packettracer | grep -q $deb_file
        echo "Debian file is in place"
        break
      end
      sleep 0.1
    end
    cd packettracer
    # packet tracer version in the deb and AUR PKBUILD may differ, put deb version to PKGBUILD
    echo "Patching PKGBUILD"
    set deb_file (exa | grep *.deb)
    echo "source=('local://$deb_file' 'packettracer.sh')" | tee -a PKGBUILD
    makepkg -src --skipchecksums
    paru -U --noconfirm *.pkg.*
    cd ..
    rm -rf packettracer
  else
    echo "Packet tracer is installed"
  end
end

function anydesk
  queue aur/anydesk-bin
end

function realvnc
  queue aur/realvnc-vnc-viewer
end

function tailscale
  paci aur/tailscale-git
  sudo systemctl start tailscaled
  sudo tailscale up
end

function virtualbox
  queue community/virtualbox
end

function nvim
  queue community/neovim
  queue extra/xclip
  queue community/ueberzug # image support for terminals
  queue aur/nvim-packer-git
  link .config/nvim
  link_su .config/nvim
  nerdfonts
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

function kdenlive
  queue extra/kdenlive
end

function vlc
  queue extra/vlc
end

function gimp
  queue extra/gimp
end

function sshfs
  queue community/sshfs
end

function htop
  queue extra/htop
end

function xampp
  queue aur/xampp
end

function startup
  link .bashrc
  link .bash_profile
  link .xinitrc
end

function suckless
  link .dwm
  sudo make install --directory ~/.dwm
  link .dwmblocks
  sudo make install --directory ~/.dwmblocks
  link .dmenu
  sudo make install --directory ~/.dmenu
  link .st
  sudo make install --directory ~/.st
  queue ttf-symbola # emoji font so st won't crash
  queue community/sxiv
end

function dunst
  queue community/dunst
end

function calc
  queue community/calc
end

function lf
  queue chaotic-aur/lf
  link .config/lf
end

function utilities
  queue community/xdotool
  queue extra/xorg-xev
end

## Call the install functions

if ! test -n "$argv"
  ################################################################
  ################################################################
  ################## CHOOSE YOUR TOOLS BELOW #####################
  ################################################################
  ################################################################
  firefox
  chromium
  sublime_text
  discord
  redshift
  nerdfonts
  fish
  python
  postman
  flameshot
  gitconfig
  vscode
  java
  dotnet
  sqlite
  dbeaver
  onlyoffice
  wine
  steam
  heroic
  lutris
  minecraft
  osu
  filezilla
  teams
  packet_tracer
  anydesk
  realvnc
  tailscale
  nvim
  fman
  obs
  kdenlive
  gimp
  sshfs
  htop
  xampp
  startup
  suckless
  dunst
  calc
  lf
  utilities
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
