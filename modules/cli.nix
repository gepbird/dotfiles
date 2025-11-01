self:
{
  pkgs,
  ...
}:

let
  lurk = pkgs.lurk.overrideAttrs (o: {
    patches = (o.patches or [ ]) ++ [
      (pkgs.fetchpatch2 {
        name = "unknown-syscall-workaround.patch";
        url = "https://github.com/gepbird/lurk/commit/41ec25cda933fb9f3a8e55f8b3683b8f628e938c.patch";
        hash = "sha256-7jWTv/OA5B2trK6sBx/PXPy2fmDwSguup8vVxt/ZXEU=";
      })
    ];
  });
in
{
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      bat
      cntr
      diffoscopeMinimal
      dig
      dos2unix
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
      inotify-tools
      jq
      libnotify
      lsof
      lurk
      ncdu
      nmap
      ouch
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
      dragon-drop
      xorg.xev
      xorg.xkill
      xsel
      yaml2nix
    ];
}
