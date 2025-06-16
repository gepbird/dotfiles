self:
{
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) getExe;
in
{
  hm-gep.programs.tmux = {
    enable = true;
    escapeTime = 0;
    historyLimit = 100 * 1000;
    keyMode = "vi";
    mouse = true;
    prefix = "m-w";
    plugins = with pkgs.tmuxPlugins; [
      yank
      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-plugins " "
          set -g @dracula-show-left-icon session
        '';
      }
    ];
    extraConfig = ''
      bind m-h select-pane -L
      bind m-j select-pane -D
      bind m-k select-pane -U
      bind m-l select-pane -R

      bind h split-window -h
      bind v split-window -v

      bind m-q kill-pane

      bind space copy-mode

      # make colors inside tmux look the same as outside of tmux
      # see https://github.com/tmux/tmux/issues/696
      # see https://stackoverflow.com/a/41786092
      set-option -ga terminal-overrides ",$TERM:Tc"
    '';
  };

  hm-gep.home.shellAliases = {
    t = "tmux";
    td = "tmux detach";
  };

  hm-gep.home.packages = with pkgs; [
    (writeShellScriptBin "ta" ''
      set -uo pipefail
      sessions=$(tmux ls 2>/dev/null)
      if [ -z "$sessions" ]; then
        tmux
      else
        selected_session=$(echo $sessions | ${getExe gum} choose --select-if-one | ${getExe hck} -f1)
        tmux a -t "$selected_session"
      fi
    '')
  ];
}
