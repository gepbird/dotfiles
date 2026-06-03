self:
{
  pkgs,
  ...
}:

{
  # TODO: remove after https://github.com/NixOS/nixpkgs/issues/526914
  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];

  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      bitwarden-desktop
      bitwarden-cli
    ];
}
