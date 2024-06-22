self: { pkgs, lib, ... }:

{
  services.xserver.windowManager.dwm = {
    enable = builtins.trace "foo1" true;
    package = self.inputs.dwm-gep.packages.${pkgs.system}.default;
  };
}
