{ pkgs, home-manager, ... }:

{
  home-manager.users.gep = {
    home.file.".config/lf/icons".source = ./home/.config/lf/icons;

    programs.lf = {
      enable = true;
      previewer = {
        source = pkgs.writeShellScript "pv.sh" "${pkgs.pistol}/bin/pistol \"$1\"";
        keybinding = "i";
      };
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
    };
  };
}