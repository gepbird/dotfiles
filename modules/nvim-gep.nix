self:
{
  pkgs,
  ...
}:

# for eval performance (unless using trace-cache), this module can be excluded and installed standalone using:
# `nix profile install` in the nvim directory
{
  hm-gep.home.packages = [
    (self.lib.maybeCacheDerivation "nvim-package-nvim-${self.inputs.nvim.narHash}"
      self.inputs.nvim.packages.${pkgs.system}.default
    )
  ];
}
