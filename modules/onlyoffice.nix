self:
{
  pkgs,
  ...
}:

{
  # pass all system fonts to onlyoffice
  programs.onlyoffice.enable = true;

  hm-gep.programs.onlyoffice = {
    enable = true;
    # use the NixOS module's package
    package = null;
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
