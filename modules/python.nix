{ pkgs, ... }:

{
  hm.home.packages = with pkgs; [
    (python3.withPackages (ps: with ps; [
      pip
      debugpy
    ]))
  ];
}
