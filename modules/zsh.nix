self:
{
  config,
  pkgs,
  lib,
  ...
}:

let
  inherit (lib)
    getExe
    mapAttrs
    ;

  packages = mapAttrs (pname: package: self.lib.maybeCachePackage self package) {
    inherit (pkgs)
      bat
      curl
      dragon-drop
      eza
      fd
      git
      hck
      lf
      ripgrep
      screenkey
      xcolor
      xdotool
      xsel
      zsh
      zsh-fast-syntax-highlighting
      zsh-you-should-use
      ;
  };
in
with packages;
{
  programs.zsh.enable = true; # necessary for zsh default shell
  environment.shells = [ pkgs.zsh ];
  users.users.gep.shell = pkgs.zsh;

  hm-gep.programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = "${config.hm-gep.xdg.configHome}/zsh";
    autosuggestion.enable = true;
    enableCompletion = true;
    completionInit = "autoload -U compinit && compinit -C"; # add caching to save ~50ms load time

    history = {
      size = 9999999;
      extended = true;
    };

    sessionVariables = {
      ZSH_AUTOSUGGEST_MANUAL_REBIND = true; # faster prompt
    };

    shellAliases = {
      ls = "${getExe eza} --color=always --group-directories-first --icons=auto";
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
      dnd = "${getExe dragon-drop} --and-exit --all";
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

    initContent = ''
      mvbak() { mv $1 $1.bak }
      cpbak() { cp $1 $1.bak -r }

      wordcount() { echo $1 | wc -w }

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

      umask 002 # allow write for group

      ulimit -c 0 # prevent creating core dumps (with systemd-coredump disabled)

      set -o ignoreeof # disable ctrl+d to exit, useful when scrolling with it in tmux

      bindkey -M vicmd '^h' beginning-of-line
      bindkey -M vicmd '^l' end-of-line
      forward-5-chars() { for _ in {1..5}; do zle forward-char; done }
      zle -N forward-5-chars
      bindkey -M vicmd 'L' forward-5-chars
      backward-5-chars() { for _ in {1..5}; do zle backward-char; done }
      zle -N backward-5-chars
      bindkey -M vicmd 'H' backward-5-chars

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

      source ${zsh-fast-syntax-highlighting}/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

      source ${zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh
    '';
  };
}
