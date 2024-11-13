self:
{
  pkgs,
  ...
}:

{
  services.xserver.windowManager.dwm = {
    enable = true;
    package = self.inputs.dwm-gep.packages.${pkgs.system}.default;
  };
}
