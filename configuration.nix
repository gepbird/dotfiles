# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
  [
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

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };
  console.useXkbConfig = true;

  # Enable the X11 windowing system.
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

  # Sound.
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

  # Don't forget to set a password with ‘passwd’.
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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
    (flameshot.overrideAttrs(o: {
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

  #nixpkgs.overlays =
  #  let
  #    myOverlay = self: super: {
  #      discord = super.discord.override { withOpenASAR = true; };
  #    };
  #  in
  #  [ myOverlay ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
