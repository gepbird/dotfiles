self:
{
  pkgs,
  ...
}:

let
  lurk = pkgs.lurk.overrideAttrs(o:{
    patches = (o.patches or []) ++ [
      (pkgs.fetchpatch2 {
        name = "unknown-syscall-workaround.patch";
        url = "https://github.com/JakWai01/lurk/commit/4b793bd1d6c27f68be0d8862c2100c9dc7f260c6.patch";
        hash = "sha256-ap7QVwWcli6euEJIYGpX2oPF+Sxzv+ytWQ4aPlz17B0=";
      })
    ];
  });
in
{
  hm-gep.home.packages = with pkgs; [
    bat
    cntr
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
    lurk
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
