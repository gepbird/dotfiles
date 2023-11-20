{ pkgs, home-manager, ... }:

{
  imports = [
    ./matlab.nix
  ];

  programs.steam.enable = true;

  # virt-manager
  virtualisation.libvirtd.enable = true;
  users.users.gep.extraGroups = [ "libvirtd" ];
  programs.dconf.enable = true;
  home-manager.users.gep = {
    dconf = {
      enable = true;
      settings."org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
  };

  home-manager.users.gep = {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-devedition;
    };

    programs.zathura = {
      enable = true;
      options = {
        selection-clipboard = "clipboard";
      };
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = [ "lf.desktop" ];
        "application/zip" = [ "org.gnome.FileRoller.desktop" ];
        "text/plain" = [ "nvim.desktop" ];
        "text/html" = [ "firefox.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [ "onlyoffice-desktopeditors.desktop" ];
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = [ "onlyoffice-desktopeditors.desktop" ];
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [ "onlyoffice-desktopeditors.desktop" ];
        "image/png" = [ "feh.desktop" ];
        "image/jpeg" = [ "feh.desktop" ];
        "video/mp4" = [ "mpv.desktop" ];
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
      kdenlive
      obs-studio
      mpv
      xzoom
      gnome.file-roller
      # manual fix required for fonts to work: https://nixos.wiki/wiki/Onlyoffice#Install_and_use_missing_corefonts
      onlyoffice-bin
      libreoffice
      cinnamon.nemo
      qdirstat
      anydesk
      rustdesk
      virt-manager
      rnote
      blender
      (discord.override { withOpenASAR = true; })
      prismlauncher
      osu-lazer-bin
      wineWowPackages.staging
      winetricks
    ];
  };
}
