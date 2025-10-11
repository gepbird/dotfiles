self:
{
  pkgs,
  ...
}:

{
  services.xserver.windowManager.dwm = {
    enable = true;
    # TODO: remove override in next nixos-unstable
    # this pulls packages from the current, patched nixpkgs to fix gromit-mpx build failure
    package = self.inputs.dwm-gep.packages.${pkgs.system}.default.overrideAttrs {
      buildInputs =
        pkgs.dwm.buildInputs
        ++ (with pkgs; [
          bottom
          clac
          ente-auth
          flameshot
          gnused
          gromit-mpx
          lf
          rofi
          wrapGAppsHook
          xfce.xfce4-terminal
          xorg.xkill
          zsh
        ]);
    };
  };
}
