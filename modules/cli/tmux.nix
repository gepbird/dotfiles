{ pkgs, lib, hm, ... }:

{
  hm.programs.tmux = {
    enable = true;
    escapeTime = 0;
    historyLimit = 100 * 1000;
    keyMode = "vi";
    mouse = true;
    prefix = "m-w";
    plugins = with pkgs.tmuxPlugins; [
      yank
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
    '';
  };
}
