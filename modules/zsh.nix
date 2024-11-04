self: { pkgs, lib, ... }:

with pkgs;
let
  inherit (lib) getExe;
in
{
  programs.zsh.enable = true; # necessary for zsh default shell
  environment.shells = [ zsh ];
  users.users.gep.shell = zsh;

  hm-gep.programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    autosuggestion.enable = true;
    enableCompletion = true;
    completionInit = "autoload -U compinit && compinit -C"; # add caching to save ~50ms load time
    history.path = "$ZDOTDIR/.zsh_history";

    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = 1;
      ZSH_AUTOSUGGEST_MANUAL_REBIND = true; # faster prompt
    };

    shellAliases = {
      ls = "${getExe eza} --color=always --group-directories-first --icons";
      cat = "${getExe bat} --style rule --style snip --style changes --style header";
      cut = getExe hck;
      grep = "${getExe ripgrep} -i --color=auto";

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
      pickcolor = "${getExe xcolor} -s";
      sk = "${getExe screenkey} --timeout 2 --font-size small --key-mode raw --mouse";
      zshreload = "source $ZDOTDIR/.zshrc";

      syst = "systemctl list-units --all | grep";
      sysi = "systemctl status";
      sysr = "sudo systemctl restart";
      sysl = "sudo systemctl start";
      syss = "sudo systemctl stop";
      jour = "journalctl -xeu";
      sysut = "systemctl --user list-units --all | grep";
      sysui = "systemctl --user status";
      sysur = "systemctl --user restart";
      sysul = "systemctl --user start";
      sysus = "systemctl --user stop";
      jouru = "journalctl --user -xeu";
    };

    initExtra = ''
      mvbak() { mv $1 $1.bak }
      cpbak() { cp $1 $1.bak -r }

      wordcount() { echo $1 | wc -w }

      extract() {
        case $1 in
          *.tar.gz); directoryName="''${1%.*.*}";;
          *.zip|*.rar|*.7z); echo $1; directoryName="''${1%.*}";;
          *); echo 'This format is not supported'; return 1;;
        esac

        mkdir $directoryName
        mv $1 $directoryName
        cd $directoryName

        case $1 in
          *.tar.gz); tar xvf $1;;
          *.zip); ${getExe unzip} $1;;
          *.rar); ${getExe unrar} x $1;;
          *.7z); ${getExe p7zip} x $1;;
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

      # edit a home manager generated file then restore it
      nixedit() {
        temp_link=$(mktemp -u)
        mv $1 $temp_link
        cat $temp_link > $1
        $EDITOR $1
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

      autoload edit-command-line; zle -N edit-command-line
      bindkey '^w' edit-command-line

      bindkey '^l' autosuggest-accept

      source ${zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh

      source ${zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh
    '';
  };
}
