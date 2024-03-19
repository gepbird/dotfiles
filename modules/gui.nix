self: { pkgs, ... }:

{
  hm-gep.home.packages = with pkgs; [
    anydesk
    blender
    bruno
    cinnamon.nemo
    dbeaver
    element-desktop
    gimp
    gparted
    kdenlive
    obs-studio
    pavucontrol
    qbittorrent
    qdirstat
    rnote
    rustdesk-flutter
    screenkey
    tenacity
    ungoogled-chromium
    xclicker
    xzoom
  ];
}
