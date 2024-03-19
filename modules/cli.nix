self: { pkgs, ... }:

{
  hm-gep.home.packages = with pkgs; [
    bat
    colorpicker
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
    lsof
    nmap
    p7zip
    perl536Packages.FileMimeInfo
    progress
    ripgrep
    sshfs
    unrar
    unzip
    w3m
    wget
    xdotool
    xdragon
    xorg.xev
    xorg.xkill
    xsel
    zip
  ];
}
