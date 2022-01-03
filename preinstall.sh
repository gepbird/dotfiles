#!/bin/bash

if ! grep -Fq '[chaotic-aur]' /etc/pacman.conf; then
  sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
  sudo pacman-key --lsign-key FBA220DFC880C036
  sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
  echo -e '\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist' | sudo tee -a /etc/pacman.conf
fi
if ! grep -Fq '[blackarch]' /etc/pacman.conf; then
  wget https://blackarch.org/strap.sh | sudo bash
  echo -e '\n[blackarch]\nServer=https://mirrors.tuna.tsinghua.edu.cn/blackarch/blackarch/os/$arch\nServer=https://mirrors.ustc.edu.cn/blackarch/blackarch/os/$arch\n' | sudo tee -a /etc/pacman.conf
fi

sudo pacman -Syy
sudo pacman -S --noconfirm --needed community/ttf-iosevka-nerd # starship dependency
sudo pacman -S --noconfirm --needed community/starship         # custom prompt
sudo pacman -S --noconfirm --needed community/fish             # bash alt
sudo pacman -S --noconfirm --needed community/exa              # ls alt
sudo pacman -S --noconfirm --needed community/ripgrep          # grip alt
sudo pacman -S --noconfirm --needed community/bat              # cat alt
sudo pacman -S --noconfirm --needed chaotic-aur/paru           # pacman alt
