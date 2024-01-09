{ hm, ... }:

{
  hm.programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      guioptions = "hvs"; # horizontal+vertical scroolbar, statusline
      incremental-search = true;
      recolor = true; # dark theme
      statusbar-page-percent = true;
      statusbar-home-tilde = true;
    };
    mappings = {
      z = "zoom in";
      u = "zoom out";
      d = "recolor";
      e = "feedkeys /";
      "<s-e>" = "feedkeys ?";
    };
  };

  hm.xdg.mimeApps.defaultApplications = {
    "application/pdf" = [ "org.pwmt.zathura.desktop" ];
  };
}
