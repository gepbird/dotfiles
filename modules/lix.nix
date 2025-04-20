self:
{
  ...
}:

{
  imports = [
    self.inputs.lix-module.nixosModules.lixFromNixpkgs
  ];

  nixpkgs.overlays = [
    (final: prev: {
      lix = prev.lixPackageSets.latest.lix;
    })
  ];
}
