{ config, pkgs, ... }:

{
  programs.steam.enable = true;

  home-manager.users.gep = {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/zip" = [ "org.gnome.FileRoller.desktop" ];
        "text/plain" = [ "nvim.desktop" ];
      };
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
        gnome.file-roller
        libreoffice
        cinnamon.nemo
        qdirstat
        qbittorrent
        anydesk
        rustdesk-flutter
        rnote
        blender
        element-desktop
        prismlauncher
        osu-lazer-bin
        r2modman
        wineWowPackages.staging
        winetricks
      ]
      else [ ];
  };
}
