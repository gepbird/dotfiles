self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages = with pkgs; [
    bitwarden
    bitwarden-cli
  ];
}
