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

  home-manager.users.gep.home.packages = with pkgs; [
    pavucontrol
    gparted
    postman
    ungoogled-chromium
    screenkey
    feh
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
}
