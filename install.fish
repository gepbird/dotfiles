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
  paci aur/dvm-git
  dvm install stable
  dvm update stable
end

function redshift
  queue aur/redshift-git
  link .config/redshift.conf
end

function nerdfonts
  paci ttf-iosevka-nerd
  mkdir -p ~/.local/share/fonts
  ln -vsf "/usr/share/fonts/TTF/Iosevka Nerd Font Complete.ttf" \
    "$HOME/.local/share/fonts/Iosevka Nerd Font Complete.ttf"
end

function emojifont
  queue extra/noto-fonts-emoji
end

function pipewire
  queue extra/pipewire
  queue extra/pipewire-pulse
  queue extra/pavucontrol
  queue aur/autojump
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

function screenkey
  queue community/screenkey
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

function flutter_install
  queue community/android-tools
  paci aur/flutter-git
  paci aur/android-sdk
  paci aur/android-sdk-platform-tools
  paci aur/android-sdk-build-tools
  paci aur/android-platform
  paci aur/sdkmanager
  sudo chown -R $USER /opt/flutter
  sudo chown -R $USER /opt/android-sdk
  sdkmanager --install 'cmdline-tools;latest'
  flutter doctor --android-licenses
end

function java
  queue extra/jdk8-openjdk
  queue aur/jdk18-openj9-bin
  queue extra/jdk19-openjdk
end

function nodejs
  queue community/nodejs
  queue community/npm
end

function yarn
  queue community/yarn
end

function dotnet
  queue community/dotnet-sdk
  link .omnisharp
end

function rust
  queue extra/rust
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
  paci multilib/wine
  paci multilib/winetricks
  paci community/wine-mono
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

function roblox
  wine
  paci aur/grapejuice-git
  paci multilib/lib32-nvidia-utils
  paci extra/vulkan-icd-loader
  paci multilib/lib32-vulkan-icd-loader
  grapejuice first-time-setup
end

function minecraft
  queue aur/prismlauncher-git
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
    set deb_link 'https://www.netacad.com/portal/resources/file/36b7afbe-2109-40d3-aa8e-d57a18531687'
    set downloads_link 'https://www.netacad.com/portal/node/488'
    echo "------------------packet-tracer------------------"
    echo "Log in to netacad and"
    echo " - download packet tracer version 8.2.0 from $deb_link"
    echo " - or choose another version from $downloads_link "
    echo "Wait for the download to complete"
    echo "If the script doesnt continue, try manually moving the downloaded deb file to "(pwd)"/packettracer"
    echo "-------------------------------------------------"
    xdg-open $deb_link 2>/dev/null
    read -P 'Press enter when the deb file is downloaded'

    mv ~/Downloads/CiscoPacketTracer_*_Ubuntu_64bit.deb packettracer
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
  queue aur/neovim-nightly-bin
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

function youtube_dl
  queue community/youtube-dl
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

function clac
  queue aur/clac
  link .config/clac
end

function lf
  queue community/lf
  link .config/lf
  link .local/bin/lfrun
end

function nemo
  queue community/nemo
end

function baobab
  queue extra/baobab
end

function gparted
  queue extra/gparted
end

function downgrade
  queue aur/downgrade
end

function utilities
  queue community/xdotool
  queue extra/xorg-xkill
  queue extra/xorg-xev
  queue community/iotop
  queue community/btop
  queue extra/wget
  queue extra/unrar
  queue core/man-db
  queue extra/perl-file-mimeinfo
end

function theming
  queue aur/qt5-styleplugins
  queue qt6gtk2
  link .config/Xresources
end

function dragon_drop
  queue aur/dragon-drop
end

function mimeapps
  link .config/mimeapps.list
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
  emojifont
  pipewire
  fish
  python
  postman
  flameshot
  screenkey
  gitconfig
  vscode
  #flutter_install
  java
  dotnet
  rust
  sqlite
  dbeaver
  onlyoffice
  wine
  steam
  heroic
  lutris
  #roblox
  minecraft
  osu
  filezilla
  teams
  #packet_tracer
  anydesk
  realvnc
  #tailscale
  nvim
  fman
  obs
  kdenlive
  vlc
  youtube_dl
  gimp
  sshfs
  htop
  xampp
  startup
  suckless
  dunst
  clac
  lf
  nemo
  baobab
  gparted
  downgrade
  utilities
  theming
  dragon_drop
  mimeapps
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
