self: { pkgs, ... }:

{
  hm-gep.home.packages = [
    (pkgs.discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
  ];
}
