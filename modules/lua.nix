self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages = with pkgs; [
    lua-language-server
  ];
}
