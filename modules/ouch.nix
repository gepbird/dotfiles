self:
{
  pkgs,
  ...
}:

{
  nixpkgs.overlays = [
    (final: prev: {
      ouch =
        self.lib.maybeCacheDerivation "nixpkgs-package-ouch-with-unfree-${self.lib.nixpkgsHash self}"
          (
            prev.ouch.override {
              enableUnfree = true; # for RAR support
            }
          );
    })
  ];

  hm-gep.home.packages = with pkgs; [
    ouch
  ];
}
