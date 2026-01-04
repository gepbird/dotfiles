self:
{
  pkgs,
  lib,
  ...
}:

let
  inherit (lib)
    getExe
    getExe'
    mapAttrs
    ;

  packages = mapAttrs (pname: package: self.lib.maybeCachePackage self package) {
    inherit (pkgs)
      dragon-drop
      glib
      lf
      pistol
      xfce4-terminal
      zoxide
      ;
    inherit (pkgs.perlPackages)
      FileMimeInfo
      ;
  };

  # already cached
  inherit (pkgs)
    ouch
    ;
in
with packages;
{
  hm-gep.xdg.configFile."lf/icons".source = ./icons;

  hm-gep.xdg.mimeApps.defaultApplications = {
    "inode/directory" = [ "lf.desktop" ];
  };

  hm-gep.programs.lf = {
    enable = true;
    package = lf;
    previewer = {
      source = pkgs.writeShellScript "pv.sh" "${getExe pistol} \"$1\"";
      keybinding = "i";
    };
    settings = {
      ratios = "1:2:3";
      scrolloff = 10;
      hidden = true;
      drawbox = true;
      icons = true;
      shell = "sh"; # zsh shell breaks dragon-drop and $fx
      # set '-eu' options for shell commands
      # These options are used to have safer shell commands. Option '-e' is used to
      # exit on error and option '-u' is used to give error for unset variables.
      # Option '-f' disables pathname expansion which can be useful when $f, $fs, and
      # $fx variables contain names with '*' or '?' characters. However, this option
      # is used selectively within individual commands as it can be limiting at
      # times.
      shellopts = "-eu";
      ifs = "\n"; # makes command line tools work with multiple files
    };
    # $ has to be escaped: ''$
    extraConfig = ''
      cmd mimeopen $set -f; ${getExe' FileMimeInfo "mimeopen"} --ask $f

      cmd trash %set -f; ${getExe' glib "gio"} trash $fx

      cmd decompress ''${{
        ${getExe ouch} decompress $f
      }}

      cmd compress ''${{
        ${getExe ouch} compress $fx $1
      }}

      cmd edit $set -f; nvim $f

      cmd term %${getExe xfce4-terminal}

      cmd dragon %set -f; ${getExe dragon-drop} --and-exit --all $fx

      cmd j %{{
        result="$(${getExe zoxide} query --exclude $PWD $@ | sed 's/\\/\\\\/g;s/"/\\"/g')"
        lf -remote "send $id cd \"$result\""
      }}

      cmd ji ''${{
        result="$(${getExe zoxide} query -i $@ | sed 's/\\/\\\\/g;s/"/\\"/g')"
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
      "u" = ":decompress";
      "c" = "push :compress<space>";
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
  };
}
