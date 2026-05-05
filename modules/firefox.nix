self:
{
  config,
  pkgs,
  ...
}:

{
  hm-gep.programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
    # TODO: remove when updating stateVersion: https://github.com/nix-community/home-manager/pull/8899
    configPath = "${config.hm-gep.xdg.configHome}/mozilla/firefox";
  };

  hm-gep.xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox-devedition.desktop" ];
    "x-scheme-handler/http" = [ "firefox-devedition.desktop" ];
    "x-scheme-handler/https" = [ "firefox-devedition.desktop" ];
  };
}
