self:
{
  ...
}:

{
  nixpkgs.overlays = [
    (final: prev: {
      nix = prev.lixPackageSets.lix_2_96.lix.overrideAttrs (o: {
        doCheck = false;
        doInstallCheck = false;
        patches = (o.patches or [ ]) ++ [
          (prev.fetchurl {
            name = "derivation-memoization.patch";
            url = "https://git.lix.systems/gepbird/lix/compare/2.96.0...2.96.0-derivation-memoization-6.0.0.patch";
            hash = "sha256-AnQLUwTSNYUl/9ayZ7XpoVJo9m/H8F0QV9OBhqmyp5U=";
          })
        ];
      });
    })
  ];

  nix.settings.experimental-features = [
    "derivation-memoization"
  ];
}
