{ inputs, lib, ... }:
let
  hasNixpkgsPatcher = inputs.nixpkgs-patcher.lib.patchNixpkgs or null != null;
in
lib.optionalAttrs hasNixpkgsPatcher {
  perSystem =
    { system, pkgs, ... }:
    let
      nixpkgs-patched = inputs.nixpkgs-patcher.lib.patchNixpkgs {
        inherit system inputs;
      };
    in
    {
      _module.args.pkgs = import nixpkgs-patched {
        inherit system;
        config.allowUnfree = true;
      };
    };
}
