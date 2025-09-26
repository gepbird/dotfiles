self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages = with pkgs; [
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

  environment.systemPackages = with pkgs; [
    gparted
  ];
}
