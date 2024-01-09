{ pkgs, lib, hm, ... }:

with pkgs;
let
  inherit (lib) getExe getExe';
in
{
  programs.zsh.enable = true; # necessary for zsh default shell
  environment.shells = [ zsh ];
  users.users.gep.shell = zsh;

  hm.programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableCompletion = true;
    completionInit = "autoload -U compinit && compinit -C"; # add caching to save ~50ms load time
    history.path = "$ZDOTDIR/.zsh_history";

    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = 1;
      DOTNET_ROOT = dotnet-sdk;
      ZSH_AUTOSUGGEST_MANUAL_REBIND = true; # faster prompt
    };

    shellAliases = {
      ls = "${getExe eza} --color=always --group-directories-first --icons";
      cat = "${getExe bat} --style rule --style snip --style changes --style header";
      cut = getExe hck;
      grep = "${getExe ripgrep} -i --color=auto";

      v = "nvim";
      g = getExe git;
      la = "ls -la";
      lff = "ls -la | grep";
      ff = "${getExe fd} | grep";
      cf = "cd $(find . -type d | fzf)";
      rmf = "sudo rm -rf";
      clip = "${getExe xsel} -b";
      dnd = "${getExe xdragon} --and-exit --all";
      getpid = "${getExe xdotool} getwindowpid $(${getExe xdotool} selectwindow)";
      whatsmyip = "${getExe curl} -4 icanhazip.com";
      pickcolor = "${getExe colorpicker} --one-shot --preview --short";
      sk = "${getExe screenkey} --timeout 2 --font-size small --key-mode raw --mouse";
      zshreload = "source $ZDOTDIR/.zshrc";
      rebuild = "sudo nixos-rebuild switch --flake $HOME/dotfiles";
      cleanup = "sudo nix-collect-garbage -d";

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
          *.zip); ${getExe unzip} $1;;
          *.tar.gz); tar xvf $1;;
          *.rar); ${getExe unrar} x $1;;
        esac
      }

      cl() {
        tmp="$(mktemp)"
        ${getExe lf} -last-dir-path="$tmp" "$@"
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

        ${getExe' openssh "ssh-keygen"} -f $private_key

        echo "Add the ssh key below to github as an Authentication and a Signing key: $github_link"
        echo '----BEGIN SSH PUBLIC KEY BLOCK----'
        ${getExe bat} --style snip $public_key
        echo '-----END SSH PUBLIC KEY BLOCK-----'

        cat $public_key | ${getExe xsel} -b
        ${getExe' xdg-utils "xdg-open"} $github_link
        echo 'Copied ssh key to clipboard and opened github in browser'
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
        nvim $1
        mv $temp_link $1
      }

      nixwhere() { realpath $(which $1) }

      try() { NIXPKGS_ALLOW_UNFREE=1 nix shell --impure nixpkgs/nixos-unstable#$1 ''${@:2} }

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

      source ${zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh

      source ${zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh

      autoload edit-command-line; zle -N edit-command-line
      source ${zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
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
      zvm_bindkey vicmd '^[OF' end-of-line
      zvm_bindkey vicmd '^[OH' beginning-of-line
    '';
  };
}
