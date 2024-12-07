self:
{
  pkgs,
  ...
}:

{
  fonts.packages = with pkgs; [
    corefonts
    minecraftia
    nerd-fonts.symbols-only
  ];
}
