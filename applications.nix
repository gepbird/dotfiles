{ pkgs, home-manager, ... }:

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

    home.packages = with pkgs; [
      pavucontrol
      gparted
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
      rustdesk
      rnote
      blender
      element-desktop
      prismlauncher
      osu-lazer-bin
      wineWowPackages.staging
      winetricks
    ];
  };
}
