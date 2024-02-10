{ pkgs, ... }:

{
  hm.programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
  };

  hm.xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox-devedition.desktop" ];
    "x-scheme-handler/http" = [ "firefox-devedition.desktop" ];
    "x-scheme-handler/https" = [ "firefox-devedition.desktop" ];
  };
}
