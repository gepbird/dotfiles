{ pkgs, lib, home-manager, ... }:

{
  services.xserver = {
    enable = true;
    layout = "hu";
    xkbOptions = "caps:escape";
    autoRepeatDelay = 250;
    autoRepeatInterval = 30;
    # disable black screen after 10 minutes
    serverLayoutSection = ''
      Option "BlankTime" "0"
    '';
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs (_: {
        src = ./home/.local/share/dwm;
        postPatch = with lib; with pkgs; ''
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

  services.geoclue2.enable = true;

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

  services.ratbagd.enable = true;

  environment.sessionVariables.PATH = [
    "$HOME/.local/bin"
  ];

  home-manager.users.gep = {
    home.file = with lib; with pkgs; {
      ".local/bin/java-8".source = getExe' jdk8 "java";
      ".local/bin/java-21".source = getExe' jdk21 "java";
    };

    home.packages = with pkgs; [
      piper
    ];

    services.dunst = {
      enable = true;
    };

    services.gammastep = {
      provider = "geoclue2";
      enable = true;
      temperature = {
        day = 4000;
        night = 2700;
      };
    };

    services.gromit-mpx = {
      enable = true;
      hotKey = null;
      tools = map
        (x: with lib; {
          device = mkDefault "default";
          type = mkDefault "pen";
          size = mkDefault 3;
        } // x) [
        {
          color = "red";
        }
        {
          color = "green";
          modifiers = [ "SHIFT" ];
        }
        {
          color = "blue";
          modifiers = [ "CONTROL" ];
        }
        {
          color = "red";
          arrowSize = 2;
          modifiers = [ "ALT" ];
        }
        {
          type = "eraser";
          size = 75;
          modifiers = [ "3" ];
        }
      ];
    };

    services.flameshot = {
      enable = true;
      # TODO: remove override when fixed: https://github.com/flameshot-org/flameshot/issues/2768
      package = pkgs.flameshot.overrideAttrs (o: {
        patches = o.patches ++ [
          (pkgs.fetchpatch {
            url = "https://github.com/gepbird/flameshot/commit/d48d1860244b7a1b9b0c7970c96441a08054a526.patch";
            hash = "sha256-jfy8vkPiPVhqfOpDOTnOco+hFNyfXv4An5kJZhM7BuU=";
          })
        ];
      });
      settings = {
        Shortcuts = {
          TYPE_ARROW = "a";
          TYPE_MARKER = "ctrl+m";
          TYPE_PIXELATE = "b";
          TYPE_CIRCLE = "c";
          TYPE_CIRCLECOUNT = "x"; # incrmenting number bubble
          TYPE_SELECTION = "r"; # hollow rectangle
          TYPE_RECTANGLE = "shift+r"; # filled rectangle
          TYPE_MOVESELECTION = "m";
          TYPE_MOVE_LEFT = "h";
          TYPE_MOVE_DOWN = "j";
          TYPE_MOVE_UP = "k";
          TYPE_MOVE_RIGHT = "l";
          TYPE_RESIZE_LEFT = "ctrl+h";
          TYPE_RESIZE_DOWN = "ctrl+j";
          TYPE_RESIZE_UP = "ctrl+k";
          TYPE_RESIZE_RIGHT = "ctrl+l";
          TYPE_UNDO = "u";
          TYPE_REDO = "shift+u";
          TYPE_COPY = "y";
          TYPE_PIN = "return";
        };
      };
    };

    programs.rofi = {
      enable = true;
      theme = "gruvbox-dark-hard";
      terminal = lib.getExe pkgs.xfce.xfce4-terminal;
      extraConfig = {
        matching = "fuzzy";
        sort = true;

        kb-clear-line = "Control+c";
        kb-move-front = "Control+h,Home,KP_Home";
        kb-move-end = "Control+l,End,KP_End";
        kb-move-word-back = "Control+b,Control+Left";
        kb-move-word-forward = "Control+w,Control+Right";
        kb-move-char-back = "Alt+h,Left";
        kb-move-char-forward = "Alt+l,Right";
        kb-accept-entry = "Return";
        kb-accept-custom = "Control+Return"; # accept the exact command typed
        kb-accept-custom-alt = "Control+Shift+Return"; # accept the exact command typed and open in termin
        kb-accept-alt = "Shift+Return"; # open in terminal
        kb-mode-next = "Tab";
        kb-mode-previous = "ISO_Left_Tab"; # Shift+Tab
        kb-row-up = "Control+k,Control+p,Up";
        kb-row-down = "Control+j,Control+n,Down";
        kb-page-prev = "Control+u,Page_Up,KP_Page_Up";
        kb-page-next = "Control+d,Page_Down,KP_Page_Down";
        kb-row-first = "Control+g,Shift+Home,Shift+KP_Home";
        kb-row-last = "Control+G,Shift+End,Shift+KP_End";
        kb-cancel = "Escape";

        # remove some keys from default binds due to conflict
        kb-remove-char-forward = "Delete"; # remove Control+d
        kb-remove-char-back = "BackSpace,Shift+BackSpace"; # remove Control+h
        kb-remove-to-eol = ""; # remove Control+k
        kb-remove-to-sol = ""; # remove Control+u
        kb-mode-complete = ""; # remove Control+l
        kb-element-next = ""; # remove Tab
        kb-element-prev = ""; # remove Shift+Tab
      };
    };
  };
}
