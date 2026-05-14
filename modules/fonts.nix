{
  pkgs,
  self,
  ...
}:

{
  fonts.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      corefonts
      minecraftia
      nerd-fonts.symbols-only
    ];
}
