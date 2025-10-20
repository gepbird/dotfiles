self:
{
  pkgs,
  ...
}:

{
  services.picom = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.picom;
  };

  hm-gep.services.dunst = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.dunst;
  };

  hm-gep.xdg.mimeApps.enable = true;
}
