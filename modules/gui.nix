self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages = with pkgs; [
    anydesk
    blender
    bruno
    dbeaver-bin
    element-desktop
    fractal
    gimp
    kdenlive
    nemo
    obs-studio
    pavucontrol
    qbittorrent
    qdirstat
    rnote
    rustdesk-flutter
    scrcpy
    screenkey
    teams-for-linux
    tenacity
    ungoogled-chromium
    xclicker
    xzoom
  ];

  environment.systemPackages = with pkgs; [
    gparted
  ];
}
