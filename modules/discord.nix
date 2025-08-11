self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.cachePackages self [
      (pkgs.discord.override {
        withOpenASAR = true;
        withVencord = true;
      })
    ];
}
