{ pkgs, home-manager, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
  };

  programs.steam.enable = true;

  # virt-manager
  virtualisation.libvirtd.enable = true;
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
    home.packages = with pkgs; [
      pavucontrol
      gparted
      postman
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
      zathura
      onlyoffice-bin
      teams-for-linux
      cinnamon.nemo
      qdirstat
      anydesk
      rustdesk
      virt-manager
      (discord.override { withOpenASAR = true; })
      prismlauncher
      osu-lazer
      wineWowPackages.staging
      winetricks
    ];
  };
}
