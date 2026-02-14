self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      bat
      cntr
      colorized-logs # for ansi2txt
      diffoscopeMinimal
      dig
      dos2unix
      dragon-drop
      dust
      exiftool
      eza
      fd
      ffmpeg
      file
      freshfetch
      fzf
      gh
      glib # for gio trash
      hck
      inetutils
      inotify-tools
      jq
      libnotify
      lsof
      lurk
      moreutils # for ts
      ncdu
      nmap
      pciutils
      perlPackages.FileMimeInfo
      procs
      progress
      ripgrep
      screen
      sd
      sqlite-interactive
      sshfs
      sysstat
      sysz
      termdown
      w3m
      watchexec
      wavemon
      wget
      xcolor
      xdotool
      xev
      xkill
      xsel
      yaml2nix
    ];
}
