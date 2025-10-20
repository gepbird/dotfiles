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
      lix = prev.lixPackageSets.latest.lix.overrideAttrs (o: {
        patches = (o.patches or [ ]) ++ [
          (prev.fetchpatch2 {
            name = "add-inputs-self-submodules-flake-attribute.patch";
            url = "https://git.lix.systems/lix-project/lix/commit/15a42d21a125ac58dc49b56c39497731344613e9.patch";
            hash = "sha256-kNNBM1MnppWfP6TBzNzv4/sRinl9uK/dVU/aFxQV0iQ=";
          })
          (prev.fetchurl {
            name = "trace-cache.patch";
            url = "https://git.lix.systems/gepbird/lix/compare/2.93.3...2.93.3-trace-cache-4.0.0.patch";
            hash = "sha256-V09eSBv55rTmDIeVND1ZYF9SJShHIc3cryvvqtfC+4k=";
          })
        ];
      });
    })
  ];
}
