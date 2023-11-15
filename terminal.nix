{ pkgs, home-manager, lib, ... }:

{
  imports = [
    ./zsh.nix
    ./lf.nix
    ./git.nix
  ];

  # xfce4-terminal
  programs.xfconf.enable = true;
  home-manager.users.gep = {
    xfconf = {
      enable = true;
      settings = {
        xfce4-terminal = {
          color-background = "#202020";
          color-foreground = "#dcdcdc";
          # dark gruvbox color scheme
          color-palette = "rgb(40,40,40);rgb(204,36,29);rgb(152,151,26);rgb(215,153,33);rgb(69,133,136);rgb(177,98,134);rgb(104,157,106);rgb(168,153,132);rgb(112,144,128);rgb(251,73,52);rgb(184,187,38);rgb(250,189,47);rgb(131,165,152);rgb(211,134,155);rgb(142,192,124);rgb(235,219,178)";
          misc-confirm-close = false;
          misc-highlight-urls = true;
          misc-middle-click-opens-uri = true;
          misc-menubar-default = false;
          misc-show-unsafe-paste-dialog = false;
          misc-use-shift-arrow-to-scroll = true;
          scrolling-unlimited = true;
        };
      };
    };
  };

  home-manager.users.gep = {
    home.file = {
      ".config/clac/words".source = ./home/.config/clac/words;
    };

    home.packages = with pkgs; [
      xfce.xfce4-terminal
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
      dos2unix
      eza
      bat
      progress
      clac
      glib # for gio trash
      sshfs
      exiftool
      perl536Packages.FileMimeInfo
      xorg.xkill
      xorg.xev
      xdotool
      xsel
      xdragon
      colorpicker
      freshfetch
      w3m
    ];

    programs.bottom = {
      enable = true;
      settings = {
        flags = {
          color = "gruvbox";
        };
      };
    };

    programs.starship = {
      enable = true;
      settings = {
        add_newline = false;
        format = lib.concatStrings [
          "$username"
          "$hostname"
          "$directory"
          "$character"
        ];
        username = {
          format = "[$user]($style)";
          style_user = "yellow";
        };
        hostname = {
          ssh_only = true;
          format = "@[$hostname]($style) ";
          style = "yellow";
        };
        directory.style = "blue";
        character = {
          success_symbol = "[❯](purple)";
          error_symbol = "[❯](red)";
          vicmd_symbol = "[❮](green)";
        };
      };
    };

    programs.zoxide = {
      enable = true;
      options = [ "--cmd j" ];
    };

    programs.atuin = {
      enable = true;
      flags = [ "--disable-up-arrow" ];
      settings = {
        auto_sync = false;
        update_check = false;
        search_mode = "skim";
        inline_height = 10;
        show_preview = true;
        show_help = false;
        exit_mode = "return-query";
      };
    };

    programs.direnv = {
      enable = true;
      stdlib = ''
        : "''${XDG_CACHE_HOME:="''${HOME}/.cache"}"
        declare -A direnv_layout_dirs
        direnv_layout_dir() {
          local hash path
          echo "''${direnv_layout_dirs[$PWD]:=$(
            hash="$(sha1sum - <<< "$PWD" | head -c40)"
            path="''${PWD//[^a-zA-Z0-9]/-}"
            echo "''${XDG_CACHE_HOME}/direnv/layouts/''${hash}''${path}"
          )}"
        }
      '';
      nix-direnv.enable = true;
    };
  };
}
