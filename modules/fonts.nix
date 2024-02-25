{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    corefonts
    minecraftia
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];
}
