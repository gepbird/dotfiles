self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.cachePackages self [
      anydesk
      blender
      bruno
      dbeaver-bin
      element-desktop
      fractal
      gimp3
      kdePackages.kdenlive
      nemo
      pavucontrol
      grayjay
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

  # if declared in home.packages, it can only be used with sudo
  environment.systemPackages =
    with pkgs;
    self.lib.cachePackages self [
      gparted
    ];
}
