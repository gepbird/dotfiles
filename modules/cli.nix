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
        url = "https://github.com/JakWai01/lurk/commit/cd570da4ece3da2539e963c2579896a0fb6313bd.patch";
        hash = "sha256-xfSDa2tMu+Jy2M+s2yofzh86748ZcZxYF4Ge+jRiTpw=";
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
    procs
    progress
    ripgrep
    sd
    sshfs
    sysstat
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
