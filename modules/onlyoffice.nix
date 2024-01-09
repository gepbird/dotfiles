{ pkgs, hm, ... }:

{
  # manual fix required for fonts to work: https://nixos.wiki/wiki/Onlyoffice#Install_and_use_missing_corefonts
  hm.home.packages = [ pkgs.onlyoffice-bin ];

  hm.xdg.mimeApps.defaultApplications = {
    "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [ "onlyoffice-desktopeditors.desktop" ];
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = [ "onlyoffice-desktopeditors.desktop" ];
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [ "onlyoffice-desktopeditors.desktop" ];
  };
}
