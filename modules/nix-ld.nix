self:
{
  pkgs,
  ...
}:

{
  programs.nix-ld = {
    enable = true;
    libraries =
      with pkgs;
      let
        electron-deps = [
          glib
          nss
          nspr
          atk
          cups
          dbus
          xorg_sys_opengl
          gtk3
          pango
          cairo
          xorg.libX11
          xorg.libXcomposite
          xorg.libXdamage
          xorg.libXfixes
          xorg.libXrandr
          mesa
          xorg.libxcb
          libxkbcommon
          alsa-lib
        ];
      in
      electron-deps;
  };
}
