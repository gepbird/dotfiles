{
  pkgs,
  self,
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
      iotop
      jq
      jqp
      just
      libnotify
      lsof
      lurk
      moreutils # for ts
      ncdu
      nmap
      openssl
      pastel
      pciutils
      perlPackages.FileMimeInfo
      procs
      progress
      python3Packages.py-cpuinfo
      ripgrep
      s-tui
      screen
      sd
      smartmontools
      sqlite-interactive
      sshfs
      stress
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
