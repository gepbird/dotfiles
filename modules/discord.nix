{ pkgs, hm, ... }:

{
  hm.home.packages = [
    (pkgs.discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
  ];
}
