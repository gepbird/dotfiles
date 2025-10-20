self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages = [
    (self.lib.maybeCacheDerivation
      "nixpkgs-package-discord-with-openasar-with-vencord-${self.inputs.nixpkgs.narHash}"
      (
        pkgs.discord.override {
          withOpenASAR = true;
          withVencord = true;
        }
      )
    )
  ];
}
