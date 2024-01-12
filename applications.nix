{ pkgs, home-manager, ... }:

{
  programs.steam.enable = true;

  home-manager.users.gep = {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/zip" = [ "org.gnome.FileRoller.desktop" ];
        "text/plain" = [ "nvim.desktop" ];
        "image/png" = [ "feh.desktop" ];
        "image/jpeg" = [ "feh.desktop" ];
      };
    };

    home.packages = with pkgs; [
      pavucontrol
      gparted
      bruno
      ungoogled-chromium
      screenkey
      # add --scale-down and --auto-zoom, for 100% image scale
      # add --edit for saving rotation and mirroring edits
      (feh.overrideAttrs (_: {
        postInstall = ''
          wrapProgram "$out/bin/feh" --prefix PATH : "${lib.makeBinPath [ libjpeg jpegexiforient ]}" \
                                     --add-flags '--theme=feh --scale-down --auto-zoom --edit'
        '';
      }))
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
