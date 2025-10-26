self:
{
  lib,
  pkgs,
  ...
}:

{
  programs.obs-studio = {
    enable = true;
    package = lib.mkDefault (self.lib.maybeCachePackage self pkgs.obs-studio);
    enableVirtualCamera = true;
    plugins = with pkgs; [
      obs-studio-plugins.droidcam-obs
    ];
  };
}
