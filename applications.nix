{ config, pkgs, ... }:

{
  home-manager.users.gep = {
    xdg.mimeApps = {
      enable = true;
    };

    home.packages =
      if (config.networking.hostName != "gepvm") then with pkgs; [
        pavucontrol
        gparted
        jd-gui
        bruno
        ungoogled-chromium
        screenkey
        gimp
        tenacity
        kdenlive
        obs-studio
        xzoom
        libreoffice
        cinnamon.nemo
        qdirstat
        qbittorrent
        anydesk
        rustdesk-flutter
        rnote
        blender
        element-desktop
      ]
      else [ ];
  };
}
