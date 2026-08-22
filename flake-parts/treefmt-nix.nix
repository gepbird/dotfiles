{ inputs, lib, ... }:
let
  hasTreefmtNix = inputs.treefmt-nix.flakeModule or null != null;
in
lib.optionalAttrs hasTreefmtNix {
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem.treefmt = {
    programs.nixfmt.enable = true;
  };
}
