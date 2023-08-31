{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./home.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 4 * 1024;
  }];

  networking.hostName = "geptop";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Budapest";

  console.useXkbConfig = true;

  services.xserver = {
    enable = true;
    layout = "hu";
    xkbOptions = "caps:escape";
    autoRepeatDelay = 250;
    autoRepeatInterval = 30;
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs (_: {
        src = ./home/.local/share/dwm;
      });
    };
  };

  services.dwm-status = {
    enable = true;
    order = [
      "battery"
      "time"
    ];
    extraConfig = ''
      [time]
      format = "%F %a %r"
      update_seconds = true
    '';
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

  location.provider = "geoclue2";
  services.redshift = {
    enable = true;
    temperature = {
      day = 4000;
      night = 2700;
    };
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # necessary for zsh default shell
  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.slock.enable = true;

  programs.light.enable = true; # backlight controller

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
  };

  # necessary for xfce4-terminal configurations
  programs.xfconf.enable = true;

  # necessary for gtk4 dark theme
  programs.dconf.enable = true;

  programs.steam = {
    enable = true;
  };

  virtualisation.libvirtd.enable = true;

  systemd.user.services = {
    polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  users.users.gep = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video" # necessary for controlling backlight with `light`
    ];
    shell = pkgs.zsh;
  };

  # qt dark theme
  # TODO: try to move this to home manager once it's fixed: https://github.com/nix-community/home-manager/pull/4306
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  environment.systemPackages = with pkgs; [
    wget
    zip
    unzip
    unrar
    p7zip
    fzf
    file
    ripgrep
    hck
    fd
    exa
    bat
    clac
    glib # for gio trash
    pulseaudio # pactl is a dependency of dwm change volume script
    sshfs
    exiftool
    perl536Packages.FileMimeInfo
    killall
    xorg.xkill
    xorg.xev
    xdotool
    xsel
    xzoom
    xdragon
    colorpicker
    freshfetch
    btop
    w3m
    gcc
    gnumake
    rustc
    cargo
    php
    php83Packages.composer
    python3
    python311Packages.pip
    nodejs
    openjdk8
    openjdk19
    gradle
    dotnet-sdk
    flutter
    sqlite
    xfce.xfce4-terminal
    pavucontrol
    gparted
    dbeaver
    postman
    ungoogled-chromium
    screenkey
    # TODO: remove override when fixed: https://github.com/flameshot-org/flameshot/issues/2768
    (flameshot.overrideAttrs (o: {
      patches = o.patches ++ [
        (pkgs.fetchpatch {
          url = "https://github.com/gepbird/flameshot/commit/d48d1860244b7a1b9b0c7970c96441a08054a526.patch";
          hash = "sha256-jfy8vkPiPVhqfOpDOTnOco+hFNyfXv4An5kJZhM7BuU=";
        })
      ];
    }))
    gimp
    kdenlive
    obs-studio
    mpv
    zathura
    feh
    onlyoffice-bin
    teams-for-linux
    cinnamon.nemo
    qdirstat
    virt-manager
    anydesk
    rustdesk
    (discord.override { withOpenASAR = true; })
    prismlauncher
    osu-lazer
    wineWowPackages.staging
    winetricks
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  system.stateVersion = "23.05";
}
