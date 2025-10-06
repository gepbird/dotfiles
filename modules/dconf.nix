self:
{
  pkgs,
  ...
}:

{
  programs.dconf.enable = true;
  hm-gep.dconf.enable = true;

  hm-gep.home.packages = with pkgs; [
    dconf-editor
  ];

  # use `dconf watch /` to monitor dconf changes
}
