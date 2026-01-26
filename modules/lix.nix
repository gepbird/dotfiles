self:
{
  ...
}:

{
  nixpkgs.overlays = [
    (final: prev: {
      nix = prev.lixPackageSets.lix_2_94.lix.overrideAttrs (o: {
        patches = (o.patches or [ ]) ++ [
          (prev.fetchurl {
            name = "trace-cache.patch";
            url = "https://git.lix.systems/gepbird/lix/compare/2.94.0...2.94.0-trace-cache-4.0.0.patch";
            hash = "sha256-fC9TOpUplcIPNXOHXliWaKFK1Tap/+OWVRmfKgBEqXw=";
          })
        ];
      });
    })
  ];
}
