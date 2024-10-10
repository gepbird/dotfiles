self: { pkgs, ... }:

{
  imports = [
    self.inputs.lix-module.nixosModules.lixFromNixpkgs
  ];
}
