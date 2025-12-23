self:
{
  ...
}:

{
  nixpkgs.overlays = [
    (final: prev: {
      nix = prev.lixPackageSets.lix_2_93.lix.overrideAttrs (o: {
        patches = (o.patches or [ ]) ++ [
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
