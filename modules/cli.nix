self: { pkgs, ... }:

{
  hm-gep.home.packages = with pkgs; [
    bat
    dos2unix
    exiftool
    eza
    fd
    ffmpeg
    file
    freshfetch
    fzf
    glib # for gio trash
    hck
    inotify-tools
    jq
    libnotify
    lsof
    ncdu
    nmap
    p7zip
    perlPackages.FileMimeInfo
    progress
    ripgrep
    sshfs
    unrar
    unzip
    w3m
    wget
    xcolor
    xdotool
    xdragon
    xorg.xev
    xorg.xkill
    xsel
    zip
  ];
}
