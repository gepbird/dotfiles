self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages = [
    (self.lib.maybeCacheDerivation
      "nixpkgs-package-discord-with-openasar-with-vencord-${self.lib.nixpkgsHash self}"
      (
        pkgs.discord.override {
          withOpenASAR = true;
          withVencord = true;
        }
      )
    )
  ];
}
