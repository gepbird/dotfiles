self:
{
  pkgs,
  ...
}:

let
  pkgs' = import self.inputs.nixpkgs-rustdesk {
    inherit (pkgs) system;
  };
in
{
  nixpkgs.overlays = [
    (final: prev: {
      inherit (pkgs') rustdesk-flutter;
    })
  ];
}
