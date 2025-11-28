self:
{
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) getExe;

  inherit (lib)
    mapAttrs'
    nameValuePair
    ;

  format = pkgs.formats.yaml { };

  sessions = {
    nixpkgs = {
      name = "nixpkgs";
      root = "~/nixpkgs";
      windows = [
        { editor = "nvim"; }
        { shell = null; }
      ];
    };
  };
in
{
  hm-gep.programs.tmux = {
    enable = true;
    escapeTime = 0;
    historyLimit = 100 * 1000;
    keyMode = "vi";
    mouse = true;
    prefix = "m-w";
    tmuxinator = {
      enable = true;
    };
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

      # display hostname
      set-option -g status-right "#H"

      # make colors inside tmux look the same as outside of tmux
      # see https://github.com/tmux/tmux/issues/696
      # see https://stackoverflow.com/a/41786092
      set-option -ga terminal-overrides ",$TERM:Tc"

      # terminal color 8 is different in tmux, change it from default screen
      set-option -g default-terminal "screen-256color"
    '';
  };

  hm-gep.home.shellAliases = {
    t = "tmux new-session -s $(basename $PWD)";
    td = "tmux detach";
  };

  hm-gep.home.packages = with pkgs; [
    (writeShellScriptBin "ta" ''
      set -euo pipefail
      sessions=$(tmux ls 2>/dev/null)
      if [[ -z "$sessions" ]]; then
        t
      else
        selected_session=$(echo "$sessions" | ${getExe fzf} --select-1 | ${getExe hck} -f1)
        tmux a -t "$selected_session"
      fi
    '')
  ];

  # TODO: upstream to home-manager
  hm-gep = {
    xdg.configFile = mapAttrs' (
      name: value:
      nameValuePair "tmuxinator/${name}.yml" {
        source = format.generate "tmuxinator-${name}.yml" value;
      }
    ) sessions;
  };
}
