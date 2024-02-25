{ config, pkgs, lib, ... }:

{
  services.xserver = {
    enable = true;
    xkb.layout = "hu";
    xkb.options = "caps:escape";
    autoRepeatDelay = 250;
    autoRepeatInterval = 30;
    # disable black screen after 10 minutes
    serverLayoutSection = ''
      Option "BlankTime" "0"
    '';
  };

  services.dwm-status = {
    enable = true;
    order = lib.optional (config.networking.hostName == "geptop") "battery" ++ [
      "time"
    ];
    extraConfig = ''
      [time]
      format = "%F %a %r"
      update_seconds = true
    '';
  };

  services.picom.enable = true;

  programs.slock.enable = true;

  # backlight control
  programs.light.enable = true;
  users.users.gep.extraGroups = [ "video" ];

  fonts.packages = with pkgs; [
    corefonts
    minecraftia
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

  programs.dconf.enable = true;

  home-manager.users.gep = {
    xdg.mimeApps.enable = true;

    services.dunst = {
      enable = true;
    };
  };
}
