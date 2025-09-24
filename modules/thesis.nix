self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages = with pkgs; [
    zotero
  ];
}
