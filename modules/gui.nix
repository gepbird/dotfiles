self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      anydesk
      arandr
      blender
      bruno
      dbeaver-bin
      element-desktop
      fractal
      gimp3
      grayjay
      kdePackages.kdenlive
      nemo
      pavucontrol
      qbittorrent
      qdirstat
      rnote
      rustdesk-flutter
      scrcpy
      screenkey
      signal-desktop
      teams-for-linux
      tenacity
      ungoogled-chromium
      xclicker
      xzoom
    ];

  # if installed as a home-manager package, the popup for entering the password doesn't come up and must be ran with sudo
  environment.systemPackages =
    with pkgs;
    self.lib.maybeCachePackages self [
      gparted
    ];
}
