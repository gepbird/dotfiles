self: { pkgs, ... }:

{
  programs.steam.enable = true;

  hm-gep.home.packages = with pkgs; [
    prismlauncher
    osu-lazer-bin
    r2modman
    wineWowPackages.staging
    winetricks
  ];
}
