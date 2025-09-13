self:
{
  pkgs,
  ...
}:

# for eval performance, this module can be excluded and installed standalone using:
# `nix profile install` in the nvim directory
{
  hm-gep.home.packages = [
    self.inputs.nvim.packages.${pkgs.system}.default
  ];
}
