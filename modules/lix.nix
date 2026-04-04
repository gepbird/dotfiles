self:
{
  ...
}:

{
  nixpkgs.overlays = [
    (final: prev: {
      nix = prev.lixPackageSets.lix_2_95.lix.overrideAttrs (o: {
        patches = (o.patches or [ ]) ++ [
          (prev.fetchurl {
            name = "trace-cache.patch";
            url = "https://git.lix.systems/gepbird/lix/compare/2.95.1...2.95.1-trace-cache-4.0.2.patch";
            hash = "sha256-oheoHYC8SlfOo2ltymnKnGb5YOamE8nWUq73UaU7x2o=";
          })
        ];
      });
    })
  ];
}
