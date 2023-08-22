{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
    sha256 = "0dfshsgj93ikfkcihf4c5z876h4dwjds998kvgv7sqbfv0z6a4bc";
  };
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.sharedModules = [
    {
      programs.git = {
        enable = true;
        aliases = {
          c = "commit -S";
          ca = "commit -S --amend";
          s = "status -uno";
          b = "branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate";
          d = "diff";
          co = "checkout";
          cl = "clone";
          p = "!git pull && git push";
          l = "!git log --pretty=format:'%C(magenta)%h%Creset -%C(red)%d%Creset %s %C(dim green)(%cr) [%an]' --abbrev-commit -30";
        };
        extraConfig = {
          user = {
            name = "Gutyina Gergő";
            email = "gutyina.gergo.2@gmail.com";
            signingKey = "~/.ssh/id_ed25519.pub";
          };
          init = {
            defaultBranch = "main";
          };
          core = {
            editor = "nvim";
          };
          gpg = {
            format = "ssh";
          };
          push = {
            autoSetupRemote = true;
          };
        };
      };
    }
    {
      programs.lf = {
        enable = true;
        settings = {
          ratios = "1:2:3";
          scrolloff = 10;
          hidden = true;
          drawbox = true;
          icons = true;
          shell = "sh"; # zsh shell breaks xdragon and $fx
          # set '-eu' options for shell commands
          # These options are used to have safer shell commands. Option '-e' is used to
          # exit on error and option '-u' is used to give error for unset variables.
          # Option '-f' disables pathname expansion which can be useful when $f, $fs, and
          # $fx variables contain names with '*' or '?' characters. However, this option
          # is used selectively within individual commands as it can be limiting at
          # times.
          shellopts = "-eu";
          ifs = "\n"; # makes command line tools wirk with multiple files
        };
        # $ has to be escaped: ''$
        extraConfig = ''
          cmd mimeopen $set -f; ${pkgs.perl536Packages.FileMimeInfo}/bin/mimeopen --ask $f

          cmd trash %set -f; ${pkgs.glib}/bin/gio trash $fx

          cmd uncompress ''${{
            set -f
            case $f in
              *.tar.bz|*.tar.bz2|*.tbz|*.tbz2) tar xjvf $f;;
              *.tar.gz|*.tgz) tar xzvf $f;;
              *.tar.xz|*.txz) tar xJvf $f;;
              *.zip) ${pkgs.unzip}/bin/unzip $f;;
              *.rar) ${pkgs.unrar}/bin/unrar x $f;;
              *.7z) ${pkgs.p7zip}/bin/7z x $f;;
            esac
          }}

          cmd tar ''${{
            set -f
            mkdir $1
            cp -r $fx $1
            tar czf $1.tar.gz $1
            rm -rf $1
          }}

          cmd zip ''${{
            set -f
            mkdir $1
            cp -r $fx $1
            zip -r $1.zip $1
            rm -rf $1
          }}

          cmd edit $set -f; nvim $f

          cmd term %${pkgs.xfce.xfce4-terminal}/bin/xfce4-terminal

          cmd dragon %set -f; ${pkgs.xdragon}/bin/xdragon --and-exit --all $fx

          cmd j %{{
            result="$(${pkgs.zoxide}/bin/zoxide query --exclude $PWD $@ | sed 's/\\/\\\\/g;s/"/\\"/g')"
            lf -remote "send $id cd \"$result\""
          }}

          cmd ji ''${{
            result="$(${pkgs.zoxide}/bin/zoxide query -i $@ | sed 's/\\/\\\\/g;s/"/\\"/g')"
            lf -remote "send $id cd \"$result\""
          }}
        '';
        keybindings = {
          # $ = execute shell command
          # ! = execute shell command and wait for keypress
          # % = execute shell command and pipe it into lf
          # $f = selected file
          # $fx = all the selected files
          # push = press keys in lf
          "<enter>" = "shell";
          "é" = "$$f"; # execute current file
          "É" = "!$f"; # execute current file and wait for keypress
          "L" = ":mimeopen";
          "d" = ":trash";
          "D" = ":delete";
          "x" = ":cut";
          "y" = ":copy";
          "p" = ":paste";
          "u" = ":uncompress";
          "c" = "push :tar<space>";
          "C" = "push :zip<space>";
          "a" = "push %touch<space>";
          "A" = "push %mkdir<space>";
          "J" = "push 5j";
          "K" = "push 5k";
          "<c-d>" = ":half-down";
          "<c-u>" = ":half-up";
          "e" = ":search";
          "E" = ":search-back";
          "w" = ":edit";
          "V" = ":unselect";
          "R" = ":reload";
          "t" = ":term";
          "ő" = ":dragon";
          "o" = "push :j<space>";
          "O" = ":ji";
        };
        previewer = {
          source = pkgs.writeShellScript "pv.sh" "${pkgs.pistol}/bin/pistol \"$1\"";
          keybinding = "i";
        };
      };
    }
    {
      programs.zsh = {
        enable = true;
        autocd = true;
        dotDir = ".config/zsh";
        enableAutosuggestions = true;
        enableCompletion = true;
        syntaxHighlighting = {
          enable = true;
          # TODO: remove override when merged: https://github.com/NixOS/nixpkgs/pull/250009
          package = pkgs.zsh-syntax-highlighting.overrideAttrs (_: {
            src = pkgs.fetchFromGitHub {
              owner = "zsh-users";
              repo = "zsh-syntax-highlighting";
              rev = "1386f1213eb0b0589d73cd3cf7c56e6a972a9bfd";
              sha256 = "iKx7lsQCoSAbpANYFkNVCZlTFdwOEI34rx/h1rnraSg=";
            };
          });
          # highlighters = "brackets"; # TODO: uncomment when merged: https://github.com/nix-community/home-manager/pull/4360
        };
        completionInit = "autoload -U compinit && compinit -C"; # add caching to save ~50ms load time
        history.path = "$ZDOTDIR/.zsh_history";
        sessionVariables = {
          JAVA_8_HOME = "${pkgs.jdk8}";
          JAVA_20_HOME = "${pkgs.jdk20}";
          # TODO: remove when merged: https://github.com/NixOS/nixpkgs/pull/250761
          _JAVA_AWT_WM_NONREPARENTING = 1; # fix java apps blank screen
        };
        shellAliases = {
          ls = "${pkgs.exa}/bin/exa --color=always --group-directories-first --icons";
          cat = "${pkgs.bat}/bin/bat --style rule --style snip --style changes --style header";
          cut = "${pkgs.hck}/bin/hck";
          grep = "${pkgs.ripgrep}/bin/rg -i --color=auto";

          v = "${pkgs.neovim}/bin/nvim";
          g = "${pkgs.git}/bin/git";
          la = "ls -la";
          lff = "ls -la | grep";
          ff = "${pkgs.fd}/bin/fd | grep";
          cf = "cd $(find . -type d | fzf)";
          rmf = "sudo rm -rf";
          clip = "${pkgs.xsel}/bin/xsel -b";
          dnd = "${pkgs.xdragon}/bin/xdragon --and-exit --all";
          getpid = "${pkgs.xdotool}/bin/xdotool getwindowpid $(${pkgs.xdotool}/bin/xdotool selectwindow)";
          whatsmyip = "${pkgs.curl}/bin/curl ifconfig.me";
          # TODO: use pkgs.colorpicker when merged: https://github.com/NixOS/nixpkgs/pull/250636
          pickcolor = "colorpicker --one-shot --preview --short";
          sk = "${pkgs.screenkey}/bin/screenkey --timeout 2 --font-size small --key-mode raw --mouse";
          zshreload = "source $ZDOTDIR/.zshrc";
          update = "sudo nixos-rebuild switch -I nixos-config=$HOME/Linux-setup/configuration.nix";
          cleanup = "sudo nix-collect-garbage --delete-older-than";
          try = "nix-shell -p";

          sysi = "systemctl status";
          sysr = "sudo systemctl restart";
          sysl = "sudo systemctl start";
          syss = "sudo systemctl stop";
          syse = "sudo systemctl enable --now";
          sysE = "sudo systemctl enable";
          sysd = "sudo systemctl disable --now";
          sysD = "sudo systemctl disable";
          sysdr = "sudo systemctl daemon-reload";
        };
        initExtra = ''
          mvbak() { mv $1 $1.bak }
          cpbak() { cp $1 $1.bak -r }

          wordcount() { echo $1 | wc -w }

          extract() {
            case $1 in
              *.zip); echo $1; directoryName="''${1%.*}";;
              *.tar.gz); directoryName="''${1%.*.*}";;
              *.rar); directoryName="''${1%.*}";;
              *); echo 'This format is not supported'; return 1;;
            esac

            mkdir $directoryName
            mv $1 $directoryName
            cd $directoryName

            case $1 in
              *.zip); ${pkgs.unzip}/bin/unzip $1;;
              *.tar.gz); tar xvf $1;;
              *.rar); ${pkgs.unrar}/bin/unrar x $1;;
            esac
          }

          cl() {
            tmp="$(mktemp)"
            ${pkgs.lf}/bin/lf -last-dir-path="$tmp" "$@"
            if test -f "$tmp"; then
              dir="$(cat "$tmp")"
              rm -f "$tmp"
              if test -d "$dir" && test "$dir" != "$(pwd)"; then
                cd "$dir"
              fi
            fi
          }

          github-ssh() {
            private_key="$HOME/.ssh/id_ed25519"
            public_key="$private_key.pub"
            github_link='https://github.com/settings/ssh/new'

            echo "Generating ssh key to $key_file"
            ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -f $private_key

            echo "Add the ssh key below to github as an Authentication and a Signing key: $github_link"
            echo '----BEGIN SSH PUBLIC KEY BLOCK----'
            ${pkgs.bat}/bin/bat --style snip $public_key
            echo '-----END SSH PUBLIC KEY BLOCK-----'

            ${pkgs.xdg-utils}/bin/xdg-open $github_link
            cat $public_key | ${pkgs.xsel}/bin/xsel -b
            echo 'Opened github in browser and copied ssh key to clipboard'
          }

          # used to make home manager generated config files editable
          unnix() {
            temp_file=$(mktemp)
            cat $1 > $temp_file
            mv $temp_file $1
          }

          # edit a home manager generated file then restore it
          nixedit() {
            temp_link=$(mktemp -u)
            mv $1 $temp_link
            cat $temp_link > $1
            ${pkgs.neovim}/bin/nvim $1
            mv $temp_link $1
          }

          nixwhere() { realpath $(which $1) }
        '';
      };
    }
    {
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
          directory = {
            style = "blue";
          };
          character = {
            success_symbol = "[❯](purple)";
            error_symbol = "[❯](red)";
            vicmd_symbol = "[❮](green)";
          };
          hostname = {
            ssh_only = true;
            format = "@[$hostname]($style) ";
            style = "bold dimmed white";
          };
        };
      };
    }
    {
      programs.zoxide = {
        enable = true;
        options = [ "--cmd j" ];
      };
    }
    {
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
    }
  ];

  home-manager.users.gep = {
    home.stateVersion = "23.05";
    home.file = {
      ".config/nvim/ftplugin".source = ./home/.config/nvim/ftplugin;
      ".config/nvim/lua".source = ./home/.config/nvim/lua;
      ".config/nvim/init.lua".source = ./home/.config/nvim/init.lua;
      ".config/nvim/.luarc.json".source = ./home/.config/nvim/.luarc.json;
      ".omnisharp".source = ./home/.omnisharp;
      ".config/lf/icons".source = ./home/.config/lf/icons;
      ".config/xfce4/terminal/terminalrc".source = ./home/.config/xfce4/terminal/terminalrc;
    };
  };
}
