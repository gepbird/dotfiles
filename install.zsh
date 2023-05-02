#!/bin/zsh

## Since there are user specific settings, force the user to run without sudo
if test $USER = 'root'; then
  echo 'Run this script without sudo!'
  exit
fi

## Aliases
alias paci='paru -S --noconfirm --needed'
alias pacu='paru -Syy --noconfirm'

## Link script
read_confirm() {
  while true; do
    echo "$1 [y/N]"
    read confirm
    case $confirm in
      Y) return 0;;
      y) return 0;;
      *) return 1;;
    esac
  done
}

link() {
  SCRIPT_DIR=${0:a:h}
  source_path="$SCRIPT_DIR/home/$1"

  if test -n "$2"; then # root

    target_path="/root/$1"
    if sudo test -L $target_path; then # is symlink
      sudo rm -v $target_path
    fi
    if sudo test -e $target_path; then # exists
      if read_confirm "Do you want to delete $target_path?"; then
        sudo rm -vrf $target_path
      else
        return 1
      fi
    fi
    sudo mkdir -vp $(dirname $target_path)
    sudo ln -vsf $source_path $target_path

  else # normal user

    target_path="$HOME/$1"
    if test -L $target_path; then # is symlink
      rm -v $target_path
    fi
    if test -e $target_path; then # exists
      if read_confirm "Do you want to delete $target_path?"; then
        rm -vrf $target_path
      else
        return 1
      fi
    fi
    mkdir -vp $(dirname $target_path)
    ln -vsf $source_path $target_path

  fi
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
  paci core/openssl-1.1
  paci aur/dvm
  dvm install stable
}

redshift() {
  queue aur/redshift-git
  link .config/redshift.conf
}

pipewire() {
  queue extra/pipewire
  queue extra/pipewire-pulse
  queue extra/pavucontrol
}

nerdfonts() {
  paci ttf-iosevka-nerd
  mkdir -p ~/.local/share/fonts
  ln -vsf "/usr/share/fonts/TTF/IosevkaNerdFont-Regular.ttf" \
    "$HOME/.local/share/fonts/IosevkaNerdFont-Regular.ttf"
}

emojifont() {
  queue extra/noto-fonts-emoji
}

starship() {
  nerdfonts
  queue community/starship
  link .config/starship.toml
  link .config/starship.toml 'root'
}

dash() {
  queue core/dash
  queue aur/dashbinsh
}

zsh() {
  queue extra/zsh
  queue aur/zsh-autosuggestions-git
  queue aur/zsh-syntax-highlighting-git
  queue aur/zsh-vi-mode-git
  queue aur/autojump-git
  coreutils_replacements
  link .config/zsh
  link .config/zsh 'root'
  link .zshenv
  link .zshenv 'root'
  if ! test $SHELL = '/bin/zsh'; then
    chsh -s /bin/zsh
  fi
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
  link .local/share/vscode/extensions/extension-manager.c#-profile-1.0.0
  link .local/share/vscode/extensions/extension-manager.cpp-profile-1.0.0
  link .local/share/vscode/extensions/extension-manager.flutter-profile-1.0.0
  link .local/share/vscode/extensions/extension-manager.java-profile-1.0.0
  link .local/share/vscode/extensions/extension-manager.laravel-profile-1.0.0
  link .local/share/vscode/extensions/extension-manager.php-profile-1.0.0
  link .local/share/vscode/extensions/extension-manager.python-profile-1.0.0
  link .local/share/vscode/extensions/extension-manager.quality-of-life-1.0.0
  link .local/share/vscode/extensions/extension-manager.scripting-profile-1.0.0
  link .local/share/vscode/extensions/extension-manager.viewers,-syntax-highlighters-1.0.0
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
  queue extra/jdk19-openjdk
}

nodejs() {
  queue community/nodejs
  queue community/npm
}

yarn() {
  queue community/yarn
}

php() {
  queue extra/php
  queue extra/composer
}

dotnet() {
  queue community/dotnet-sdk
  link .omnisharp
}

rust() {
  queue community/rustup
  rustup install nightly
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
  paci multilib/wine-staging
  paci multilib/winetricks
  paci community/wine-mono
  rm -vf ~/.local/share/mime/packages/x-wine*
  rm -vf ~/.local/share/applications/wine-extension*
  rm -vf ~/.local/share/icons/hicolor/*/*/application-x-wine-extension*
  rm -vf ~/.local/share/mime/application/x-wine-extension*
}

steam() {
  queue multilib/steam
}

heroic() {
  queue aur/heroic-games-launcher-bin
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
  queue aur/prismlauncher-bin
  queue aur/mcrcon
}

osu() {
  queue aur/osu-lazer-git
  queue aur/opentabletdriver-git
}

filezilla() {
  queue community/filezilla
}

teams() {
  queue aur/teams
}

packet_tracer() {
  if ! paru -Q | grep -q packettracer; then
    git clone https://aur.archlinux.org/packettracer.git
    deb_link='https://www.netacad.com/portal/resources/file/f40aaa18-2b25-4337-81a3-8f989232abf6'
    downloads_link='https://www.netacad.com/portal/resources/packet-tracer'
    echo "------------------packet-tracer------------------"
    echo "Log in to netacad and"
    echo " - download packet tracer from $deb_link"
    echo " - or choose another version from $downloads_link "
    echo "Wait for the download to complete"
    echo "If the script doesnt continue, try manually moving the downloaded deb file to "$(pwd)"/packettracer"
    echo "-------------------------------------------------"
    xdg-open $deb_link 2>/dev/null
    echo 'Press enter when the deb file is downloaded'
    read

    mv ~/Downloads/CiscoPacketTracer_*_Ubuntu_64bit.deb packettracer
    cd packettracer
    # packet tracer version in the deb and AUR PKBUILD may differ, put deb version to PKGBUILD
    echo "Patching PKGBUILD"
    deb_file=$(exa | grep *.deb)
    echo "source=('local://$deb_file' 'packettracer.sh' 'cisco-pt.desktop' 'cisco-ptsa.desktop')" | \
      tee -a PKGBUILD
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

rustdesk() {
  queue aur/rustdesk-bin
  queue aur/rustdesk-server-bin
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
  queue community/tree-sitter
  queue community/ueberzug # image support for terminals
  queue aur/nvim-packer-git
  link .config/nvim
  link .config/nvim 'root'
  nerdfonts
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

xampp() {
  queue aur/xampp
}

startup() {
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
  link .config/lf 'root'
  link .local/bin/lfrun
  link .local/bin/lfrun 'root'
}

nemo() {
  queue community/nemo
}

qdirstat() {
  queue aur/qdirstat
}

gparted() {
  queue extra/gparted
}

downgrade() {
  queue aur/downgrade
}

system_monitor() {
  queue community/iotop
  queue community/btop
}

xutilities() {
  queue community/xdotool
  queue extra/xorg-xkill
  queue extra/xorg-xev
  queue extra/xorg-xhost
  queue extra/xorg-xinput
}

utilities() {
  queue extra/wget
  queue extra/unrar
  queue community/expac
  queue core/man-db
  queue aur/colorpicker
  if test $(ls /sys/class/backlight | wc -l) -gt 0; then
    queue aur/backlight_control
  fi
}

coreutils_replacements() {
  queue community/exa
  queue community/ripgrep
  queue community/bat
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
  queue extra/perl-file-mimeinfo
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
  #sublime_text
  discord
  redshift
  pipewire
  nerdfonts
  emojifont
  starship
  dash
  zsh
  python
  postman
  flameshot
  screenkey
  gitconfig
  vscode
  #flutter_install
  java
  yarn
  php
  nodejs
  dotnet
  rust
  sqlite
  dbeaver
  onlyoffice
  wine
  steam
  #heroic
  #lutris
  #roblox
  minecraft
  osu
  filezilla
  teams
  #packet_tracer
  anydesk
  #realvnc
  rustdesk
  #tailscale
  virtualbox
  nvim
  obs
  kdenlive
  vlc
  youtube_dl
  gimp
  sshfs
  xampp
  startup
  suckless
  dunst
  clac
  lf
  nemo
  qdirstat
  gparted
  downgrade
  system_monitor
  xutilities
  utilities
  coreutils_replacements
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
