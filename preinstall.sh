#!/bin/bash

sudo pacman -Syy
sudo pacman -S --noconfirm --needed community/ttf-iosevka-nerd # starship dependency
sudo pacman -S --noconfirm --needed community/starship         # custom prompt
sudo pacman -S --noconfirm --needed extra/zsh                  # bash alt
sudo pacman -S --noconfirm --needed community/exa              # ls alt
sudo pacman -S --noconfirm --needed community/ripgrep          # grip alt
sudo pacman -S --noconfirm --needed community/bat              # cat alt

sudo pacman -S --noconfirm --needed base-devel extra/rust
git clone --depth 1 https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru
