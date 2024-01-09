{ pkgs, home-manager, lib, ... }:

{
  home-manager.users.gep = {
    home.file = {
      ".config/clac/words".source = ./home/.config/clac/words;
    };

    home.packages = with pkgs; [
      wget
      zip
      unzip
      unrar
      p7zip
      fzf
      file
      lsof
      ripgrep
      hck
      fd
      dos2unix
      eza
      bat
      progress
      clac
      glib # for gio trash
      nmap
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

    programs.ssh = {
      enable = true;
      matchBlocks."*".extraOptions.StrictHostKeyChecking = "no";
    };

    programs.bottom = {
      enable = true;
      settings = {
        flags = {
          color = "gruvbox";
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
