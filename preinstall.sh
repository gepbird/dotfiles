#!/bin/bash

sudo pacman -Syy --noconfirm --needed \
  extra/zsh \
  community/exa \
  community/ripgrep \
  community/bat \
  base-devel \
  community/rustup
rustup install nightly
git clone --depth 1 https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru
