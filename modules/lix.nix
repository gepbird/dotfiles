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
            # https://git.lix.systems/gepbird/lix/commits/branch/trace-cache-2.93.3
            name = "cache-with-trace.patch";
            url = "https://git.lix.systems/gepbird/lix/compare/e101400359558ec89f0a3afa29631ca1b6546fd3...fb8a6a8685bc1b5c859eb0c4d28ffbaafddae258.diff";
            hash = "sha256-7ILsQ0b0A7lzdE5SoydosWVS5WVnIOOLs+j1P7i1R48=";
          })
        ];
        doCheck = false;
        doInstallCheck = false;
      });
    })
  ];
}
