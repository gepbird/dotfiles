self: { pkgs, ... }:

{
  hm-gep.home.packages = with pkgs; [ gnome.file-roller ];

  hm-gep.xdg.mimeApps.defaultApplications = {
    "application/zip" = [ "org.gnome.FileRoller.desktop" ];
  };
}
