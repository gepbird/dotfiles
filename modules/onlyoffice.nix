self:
{
  pkgs,
  ...
}:

{
  # manual fix required for fonts to work: https://nixos.wiki/wiki/Onlyoffice#Install_and_use_missing_corefonts
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      onlyoffice-desktopeditors
    ];

  hm-gep.xdg.mimeApps.defaultApplications = {
    "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [
      "onlyoffice-desktopeditors.desktop"
    ];
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = [
      "onlyoffice-desktopeditors.desktop"
    ];
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [
      "onlyoffice-desktopeditors.desktop"
    ];
  };
}
