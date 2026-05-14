{
  pkgs,
  self,
  ...
}:

{
  # a declerative version of https://wiki.nixos.org/wiki/ONLYOFFICE#Install_and_use_missing_corefonts
  hm-gep.xdg.dataFile."fonts" = {
    source = "${pkgs.corefonts}/share/fonts/truetype";
    target = "fonts";
  };

  hm-gep.programs.onlyoffice = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.onlyoffice-desktopeditors;
    settings = {
      UITheme = "theme-contrast-dark";
    };
  };

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
