#!/bin/zsh

## Since there are user specific settings, force the user to run without sudo
if test $USER = "root"; then
  echo "Run this script without sudo!"
  exit
fi

## Aliases
alias paci='paru -S --noconfirm --needed'
alias pacu='paru -Syy --noconfirm'

link() {
  ./link.zsh $1
}

link_su() {
  ./link.zsh $1 1
}

packages=()
queue() {
  packages+=$1
}

## Define an install process for every application

firefox() {
  queue community/firefox-developer-edition
}

chromium() {
 queue extra/chromium
}

sublime_text() {
  queue aur/sublime-text-4
}

discord() {
  paci aur/dvm-git
  dvm install stable
  dvm update stable
}

redshift() {
  queue aur/redshift-git
  link .config/redshift.conf
}

pipewire() {
  queue extra/pipewire
  queue extra/pipewire-pulse
  queue extra/pavucontrol
  queue aur/autojump-git
}

nerdfonts() {
  paci ttf-iosevka-nerd
  mkdir -p ~/.local/share/fonts
  ln -vsf "/usr/share/fonts/TTF/Iosevka Nerd Font Complete.ttf" \
    "$HOME/.local/share/fonts/Iosevka Nerd Font Complete.ttf"
}

emojifont() {
  queue extra/noto-fonts-emoji
}

starship() {
  link .config/starship.toml
  link_su .config/starship.toml
}

dash() {
  queue core/dash
  queue aur/dashbinsh
}

fish() {
  link .config/fish/config.fish
  link_su .config/fish/config.fish
}

zsh() {
  queue aur/zsh-autosuggestions-git
  queue aur/zsh-syntax-highlighting-git
  queue aur/zsh-vi-mode-git
  link .config/zsh
  link .zshenv
}

python() {
  queue extra/python-pip
}

postman() {
  queue aur/postman-bin
}

flameshot() {
  paci community/flameshot
}

screenkey() {
  queue community/screenkey
}

gitconfig() {
  link .config/git
}

vscode() {
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
}

flutter_install() {
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
}

java() {
  queue extra/jdk8-openjdk
  queue aur/jdk18-openj9-bin
  queue extra/jdk19-openjdk
}

nodejs() {
  queue community/nodejs
  queue community/npm
}

yarn() {
  queue community/yarn
}

dotnet() {
  queue community/dotnet-sdk
  link .omnisharp
}

rust() {
  queue extra/rust
}

sqlite() {
  queue core/sqlite
}

dbeaver() {
  queue community/dbeaver
}

onlyoffice() {
  queue aur/onlyoffice-bin
}

wine() {
  paci multilib/wine
  paci multilib/winetricks
  paci community/wine-mono
}

steam() {
  queue multilib/steam
}

heroic() {
  queue aur/heroic-games-launcher-bin
  link .config/heroic/config.json
  link .config/heroic/GamesConfig/CrabEA.json
}

lutris() {
  queue community/lutris
}

roblox() {
  wine
  paci aur/grapejuice-git
  paci multilib/lib32-nvidia-utils
  paci extra/vulkan-icd-loader
  paci multilib/lib32-vulkan-icd-loader
  grapejuice first-time-setup
}

minecraft() {
  queue aur/prismlauncher-git
  queue aur/mcrcon
}

osu() {
  queue aur/osu-lazer-git
  queue aur/opentabletdriver-git
}

filezilla() {
  queue community/filezilla
  link .config/filezilla/sitemanager.xml
}

teams() {
  queue aur/teams
}

packet_tracer() {
  if ! paru -Q | grep -q packettracer; then
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
  fi
}

anydesk() {
  queue aur/anydesk-bin
}

realvnc() {
  queue aur/realvnc-vnc-viewer
}

tailscale() {
  paci aur/tailscale-git
  sudo systemctl start tailscaled
  sudo tailscale up
}

virtualbox() {
  queue community/virtualbox
}

nvim() {
  queue aur/neovim-nightly-bin
  queue extra/xclip
  queue community/ueberzug # image support for terminals
  queue aur/nvim-packer-git
  link .config/nvim
  link_su .config/nvim
  nerdfonts
}

fman() {
  if ! grep -Fq '[fman]' /etc/pacman.conf; then
    sudo pacman-key --keyserver hkp://keyserver.ubuntu.com:80 -r 9CFAF7EB
    sudo pacman-key --lsign-key 9CFAF7EB
    echo -e '\n[fman]\nServer = https://fman.io/updates/arch' | sudo tee -a /etc/pacman.conf
    pacu
  fi
  queue fman/fman
}

obs() {
  queue community/obs-studio
}

kdenlive() {
  queue extra/kdenlive
}

vlc() {
  queue extra/vlc
}

youtube_dl() {
  queue community/youtube-dl
}

gimp() {
  queue extra/gimp
}

sshfs() {
  queue community/sshfs
}

htop() {
  queue extra/htop
}

xampp() {
  queue aur/xampp
}

startup() {
  link .config/zsh
  link .config/X11
}

suckless() {
  link .local/share/dwm
  sudo make install --directory ~/.local/share/dwm
  link .local/share/dwmblocks
  sudo make install --directory ~/.local/share/dwmblocks
  link .local/share/dmenu
  sudo make install --directory ~/.local/share/dmenu
  link .local/share/st
  sudo make install --directory ~/.local/share/st
  queue ttf-symbola # emoji font so st won't crash
  queue community/sxiv
}

dunst() {
  queue community/dunst
}

clac() {
  queue aur/clac
  link .config/clac
}

lf() {
  queue community/lf
  link .config/lf
  link .local/bin/lfrun
}

nemo() {
  queue community/nemo
}

baobab() {
  queue extra/baobab
}

gparted() {
  queue extra/gparted
}

downgrade() {
  queue aur/downgrade
}

utilities() {
  queue community/xdotool
  queue extra/xorg-xkill
  queue extra/xorg-xev
  queue community/iotop
  queue community/btop
  queue extra/wget
  queue extra/unrar
  queue core/man-db
  queue extra/perl-file-mimeinfo
  queue community/expac
  queue aur/colorpicker
}

theming() {
  queue aur/qt5-styleplugins
  queue qt6gtk2
  link .config/Xresources
  link .config/gtk-2.0
}

dragon_drop() {
  queue aur/dragon-drop
}

mimeapps() {
  link .config/mimeapps.list
}

## Call the install functions

if test $# -eq 0; then
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
  pipewire
  nerdfonts
  emojifont
  starship
  dash
  fish
  zsh
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
  virtualbox
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
  for tool in $@; do
    $tool
  done
fi

# Install
if test -n "$packages"; then
  paci $packages
fi
