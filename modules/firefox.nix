self:
{
  pkgs,
  ...
}:

{
  hm-gep.programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
  };

  hm-gep.xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox-devedition.desktop" ];
    "x-scheme-handler/http" = [ "firefox-devedition.desktop" ];
    "x-scheme-handler/https" = [ "firefox-devedition.desktop" ];
  };
}
