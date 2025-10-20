self:
{
  pkgs,
  ...
}:

{
  services.xserver.windowManager.dwm = {
    enable = true;
    package =
      self.lib.maybeCacheDerivation "dwm-gep-package-dwm-${self.inputs.dwm-gep.narHash}"
        self.inputs.dwm-gep.packages.${pkgs.system}.default;
  };
}
