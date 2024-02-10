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
    windowManager.dwm = {
      enable = true;
      package = with lib; with pkgs; dwm.overrideAttrs (_: {
        src = ./home/.local/share/dwm;
        postPatch = ''
          substituteInPlace chbright.sh \
            --replace '@hck@' '${getExe hck}' \
            --replace '@dunstify@' '${getExe' dunst "dunstify"}' \
            --replace '@light@' '${getExe light}'
          substituteInPlace chvol.sh \
            --replace '@sed@' '${getExe gnused}' \
            --replace '@rg@' '${getExe ripgrep}' \
            --replace '@dunstify@' '${getExe' dunst "dunstify"}' \
            --replace '@pactl@' '${getExe' pulseaudio "pactl"}'
          substituteInPlace config.def.h \
            --replace '@zsh@' '${getExe zsh}' \
            --replace '@clac@' '${getExe clac}' \
            --replace '@lf@' '${getExe lf}' \
            --replace '@xkill@' '${getExe xorg.xkill}' \
            --replace '@rofi@' '${getExe rofi}' \
            --replace '@flameshot@' '${getExe flameshot}' \
            --replace '@gromit-mpx@' '${getExe gromit-mpx}' \
            --replace '@xfce4-terminal@' '${getExe xfce.xfce4-terminal}'
        '';
        buildInputs = [ wrapGAppsHook ];
      });
    };
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

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  # make less audio stutters when high gpu+cpu usage by buffering and delaying audio by ~30ms 
  environment.etc = {
    "pipewire/pipewire.conf.d/90-bigger-buffer.conf".text = ''
      context.properties = {
        default.clock.rate = 48000
        default.clock.min-quantum = 1500
        default.clock.max-quantum = 1500
      }
    '';
  };

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

  fonts.packages = with pkgs; [
    corefonts
    minecraftia
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

  programs.dconf.enable = true;

  environment.sessionVariables = {
    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
    PATH = [ "$HOME/.local/bin" ];
  };

  home-manager.users.gep = {
    home.file = with lib; with pkgs; {
      ".local/bin/java-8".source = getExe' jdk8 "java";
      ".local/bin/java-21".source = getExe' jdk21 "java";
    };

    services.dunst = {
      enable = true;
    };
  };
}
