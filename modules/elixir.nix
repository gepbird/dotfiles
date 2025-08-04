self:
{
  pkgs,
...
}:

{
  hm-gep.home.packages = with pkgs; [
    beam28Packages.elixir
  ];
}
