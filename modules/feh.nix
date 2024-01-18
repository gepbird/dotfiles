{ pkgs, hm, ... }:

{
  hm.programs.feh = {
    enable = true;
    keybindings = {
      zoom_in = "z";
      zoom_out = "u";
      scroll_left = "h";
      scroll_right = "l";
      scroll_down = "j";
      scroll_up = "k";
      next_img = "L";
      prev_img = "H";
      orient_1 = "r";
      orient_3 = "R";
      reload_image = "C-r";
      render = null; # fix conflict with orient_3
    };
  };

  hm.home.file = {
    # --scale-down and --auto-zoom, for 100% image scale
    # --edit for saving rotation and mirroring edits
    ".config/feh/themes".text = ''
      feh --scale-down --auto-zoom --edit
    '';
  };

  hm.xdg.mimeApps.defaultApplications = {
    "image/png" = [ "feh.desktop" ];
    "image/jpeg" = [ "feh.desktop" ];
  };
}
