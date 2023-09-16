{ pkgs, home-manager, ... }:

{
  programs.zsh.enable = true; # necessary for zsh default shell
  environment.shells = [ pkgs.zsh ];
  users.users.gep.shell = pkgs.zsh;

  home-manager.users.gep = {
    programs.zsh = {
      enable = true;
      autocd = true;
      dotDir = ".config/zsh";
      enableAutosuggestions = true;
      enableCompletion = true;
      completionInit = "autoload -U compinit && compinit -C"; # add caching to save ~50ms load time
      history.path = "$ZDOTDIR/.zsh_history";

      sessionVariables = {
        JAVA_8_HOME = "${pkgs.jdk8}";
        JAVA_20_HOME = "${pkgs.jdk20}";
        ZSH_AUTOSUGGEST_MANUAL_REBIND = true; # faster prompt
      };

      shellAliases = {
        ls = "${pkgs.eza}/bin/eza --color=always --group-directories-first --icons";
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
        pickcolor = "${pkgs.colorpicker}/bin/colorpicker --one-shot --preview --short";
        sk = "${pkgs.screenkey}/bin/screenkey --timeout 2 --font-size small --key-mode raw --mouse";
        zshreload = "source $ZDOTDIR/.zshrc";
        update = "sudo nixos-rebuild switch -I nixos-config=$HOME/dotfiles/configuration.nix";
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

        umask 002 # allow write for group

        zstyle ':completion:*' menu select
        # enable case insensitive and partial completion
        zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
        # inclue hidden files
        _comp_options+=(globdots)
        zmodload zsh/complist

        # completion menu navigation
        bindkey -M menuselect '^h' vi-backward-char
        bindkey -M menuselect '^k' vi-up-line-or-history
        bindkey -M menuselect '^l' vi-forward-char
        bindkey -M menuselect '^j' vi-down-line-or-history
        bindkey -M menuselect '^[[Z' vi-up-line-or-history # <s-tab> for previous completion

        source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh

        source ${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh

        autoload edit-command-line; zle -N edit-command-line
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
        ZVM_VI_HIGHLIGHT_BACKGROUND=#264F78 # light blue color for visual mode

        zvm_bindkey viins 'ú' autosuggest-accept
        zvm_bindkey vicmd 'e' _atuin_search_widget
        zvm_bindkey vicmd 'w' edit-command-line

        zvm_bindkey viins '^h' beginning-of-line
        zvm_bindkey vicmd '^h' beginning-of-line
        zvm_bindkey viins '^l' end-of-line
        zvm_bindkey vicmd '^l' end-of-line
        zvm_bindkey vicmd 'H' vi-backward-word
        zvm_bindkey vicmd 'L' vi-forward-word

        # fix end and home key
        zvm_bindkey viins '^[OF' end-of-line
        zvm_bindkey vicmd '^[OF' end-of-line
        zvm_bindkey viins '^[OH' beginning-of-line
        zvm_bindkey vicmd '^[OH' beginning-of-line
      '';
    };
  };
}
