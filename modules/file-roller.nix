self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages = with pkgs; [ file-roller ];

  hm-gep.xdg.mimeApps.defaultApplications = {
    "application/zip" = [ "org.gnome.FileRoller.desktop" ];
  };
}
