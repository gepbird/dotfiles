self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages = with pkgs; [
    phpactor
    php
    php84Packages.composer
  ];
}
