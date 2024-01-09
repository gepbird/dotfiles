{ pkgs, home-manager, lib, ... }:

{
  home-manager.users.gep = {
    home.packages = with pkgs; [
      wget
      zip
      unzip
      unrar
      p7zip
      fzf
      file
      lsof
      ripgrep
      hck
      fd
      dos2unix
      eza
      bat
      progress
      glib # for gio trash
      nmap
      sshfs
      exiftool
      perl536Packages.FileMimeInfo
      xorg.xkill
      xorg.xev
      xdotool
      xsel
      xdragon
      colorpicker
      freshfetch
      w3m
    ];
  };
}
