{ pkgs, hm, ... }:

{
  hm.programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
  };

  hm.xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };
}
