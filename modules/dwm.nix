self:
{
  pkgs,
  ...
}:

{
  nixpkgs.overlays = [ self.inputs.dwm-gep.overlays.default ];

  services.xserver.windowManager.dwm = {
    enable = true;
    package = self.lib.maybeCacheDerivation "dwm-gep-package-dwm-${self.inputs.dwm-gep.narHash}-nixpkgs-overlayed-${self.inputs.nixpkgs.narHash}" pkgs.dwm-gep;
  };
}
