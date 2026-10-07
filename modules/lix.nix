self:
{
  ...
}:

{
  nixpkgs.overlays = [
    (final: prev: {
      nix = prev.lixPackageSets.lix_2_95.lix.overrideAttrs (o: {
        doCheck = false;
        doInstallCheck = false;
        patches = (o.patches or [ ]) ++ [
          (prev.fetchurl {
            name = "derivation-memoization.patch";
            url = "https://git.lix.systems/gepbird/lix/compare/2.95.3...2.95.3-derivation-memoization-6.0.0.patch";
            hash = "sha256-sfb9ieCUGb/bC2G5R0M2uJ8PrQ3byvlQOkPDM1vWjIY=";
          })
        ];
      });
    })
  ];

  nix.settings.experimental-features = [
    "derivation-memoization"
  ];
}
