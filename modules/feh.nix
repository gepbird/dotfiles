self:
{
  ...
}:

{
  hm-gep.programs.feh = {
    enable = true;
    keybindings = {
      zoom_in = "z";
      zoom_out = "u";
      scroll_left = "h";
      scroll_right = "l";
      scroll_down = "j";
      scroll_up = "k";
      next_img = [
        "L"
        "J"
      ];
      prev_img = [
        "H"
        "K"
      ];
      orient_1 = "r";
      orient_3 = "R";
      delete = "d";
      reload_image = "C-r";
      render = null; # fix conflict with orient_3
    };
  };

  # --scale-down and --auto-zoom, for 100% image scale
  # --edit for saving rotation and mirroring edits
  hm-gep.xdg.configFile."feh/themes".text = ''
    feh --scale-down --auto-zoom --edit
  '';

  hm-gep.xdg.mimeApps.defaultApplications = {
    "image/png" = [ "feh.desktop" ];
    "image/jpeg" = [ "feh.desktop" ];
  };
}
