self:
{
  pkgs,
  ...
}:

{
  programs.obs-studio = {
    enableVirtualCamera = true;
    plugins = with pkgs; [
      obs-studio-plugins.droidcam-obs
    ];
  };
}
