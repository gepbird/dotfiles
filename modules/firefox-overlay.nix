self:
{
  pkgs,
  ...
}:

let
  pkgs-firefox = import self.inputs.nixpkgs-firefox {
    inherit (pkgs) system;
  };
in
{
  nixpkgs.overlays = [
    (final: prev: {
      firefox-devedition = pkgs-firefox.firefox-devedition;
    })
  ];
}
