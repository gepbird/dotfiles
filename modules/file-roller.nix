self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.cachePackages self [
      file-roller
    ];

  hm-gep.xdg.mimeApps.defaultApplications = {
    "application/zip" = [ "org.gnome.FileRoller.desktop" ];
  };
}
