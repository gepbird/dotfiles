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

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # services.xserver.windowManager.dwm.enable = true;
  services.xserver.desktopManager.xfce.enable = true; # TODO: remove

  services.xserver.layout = "hu";

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

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
  };

  programs.steam = {
    enable = true;
  };

  # Don't forget to set a password with ‘passwd’.
  users.users.gep = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
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
    glib # for gio trash
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
    # TODO: remove override when merged: https://github.com/NixOS/nixpkgs/pull/250636
    (colorpicker.overrideAttrs (_: {
      src = fetchFromGitHub {
        owner = "Jack12816";
        repo = "colorpicker";
        rev = "a4455b92fde1dfbac81e7852f171093932154a30";
        sha256 = "z2asxTIP8WcsWcePmIg0k4bOF2JwkqOxNqSpQv4/a40=";
      };
    }))
    neofetch # TODO: switch to fastfetch when released
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
    flameshot
    gimp
    kdenlive
    obs-studio
    mpv
    zathura
    nsxiv
    onlyoffice-bin
    cinnamon.nemo
    qdirstat
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
