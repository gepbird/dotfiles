self:
{
  pkgs,
  ...
}:

{
  nixpkgs.overlays = [ self.inputs.dwm-gep.overlays.default ];

  services.xserver.windowManager.dwm = {
    enable = true;
    package = self.lib.maybeCacheDerivation "dwm-gep-package-dwm-${self.inputs.dwm-gep.narHash}-nixpkgs-overlayed-${self.lib.nixpkgsHash self}" pkgs.dwm-gep;
    # the module's session script runs `dwm &`, this function takes precedence over the binary
    # killing dwm essentially restarts it without losing the session
    extraSessionCommands = ''
      dwm() {
        while true; do
          command dwm
        done
      }
    '';
  };
}
