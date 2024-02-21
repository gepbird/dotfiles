{ pkgs, ... }:

{
  hm.home.packages = with pkgs; [
    anydesk
    blender
    bruno
    cinnamon.nemo
    element-desktop
    gimp
    gparted
    kdenlive
    libreoffice
    obs-studio
    pavucontrol
    qbittorrent
    qdirstat
    rnote
    rustdesk-flutter
    screenkey
    tenacity
    ungoogled-chromium
    xzoom
  ];
}
