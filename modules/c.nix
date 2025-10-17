self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages = with pkgs; [
    clang-tools
    gcc
    gnumake
  ];
}
