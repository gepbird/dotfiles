{ pkgs, ... }:

{
  hm.home.packages = with pkgs; [ gnome.file-roller ];

  hm.xdg.mimeApps.defaultApplications = {
    "application/zip" = [ "org.gnome.FileRoller.desktop" ];
  };
}
