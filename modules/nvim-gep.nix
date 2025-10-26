self:
{
  pkgs,
  ...
}:

# for eval performance (unless using trace-cache), this module can be excluded and installed standalone using:
# `nix profile install` in the nvim directory
{
  nixpkgs.overlays = [ self.inputs.nvim-gep.overlays.default ];

  hm-gep.home.packages = with pkgs; [
    (self.lib.maybeCacheDerivation "nvim-package-nvim-${self.inputs.nvim-gep.narHash}-nixpkgs-overlayed-${self.inputs.nixpkgs.narHash}" nvim-gep)
  ];
}
