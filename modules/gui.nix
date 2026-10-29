self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      anydesk
      arandr
      blender
      bruno
      dbeaver-bin
      element-desktop
      gimp3
      grayjay
      kdePackages.kdenlive
      nemo
      pwvucontrol
      qbittorrent
      qdirstat
      rnote
      rustdesk-flutter
      scrcpy
      screenkey
      signal-desktop
      teams-for-linux
      tenacity
      ungoogled-chromium
      xclicker
      xzoom
    ];

  # if installed as a home-manager package, the popup for entering the password doesn't come up and must be ran with sudo
  environment.systemPackages =
    with pkgs;
    self.lib.maybeCachePackages self [
      gparted
    ];

  nixpkgs.overlays = [
    (final: prev: {
      # TODO: remove after fixed: https://github.com/NixOS/nixpkgs/issues/577387
      anydesk =
        let
          patchelf = prev.patchelf.overrideAttrs (o: {
            patches = (o.patches or [ ]) ++ [
              (prev.fetchpatch2 {
                name = "fix-overlapping-load-mappings.patch";
                url = "https://github.com/NixOS/patchelf/commit/59acc3d98b4961cfddf02090d9426ac735603218.patch?full_index=1";
                hash = "sha256-a09yQMW1AF48dAnivD0mrhgw1q2JfCiMEeflpjIlhBI=";
              })
            ];
            nativeBuildInputs = (o.nativeBuildInputs or [ ]) ++ [ prev.autoreconfHook ];
            postPatch = (o.postPatch or "") + ''
              chmod +x tests/executable-header-rewrite.sh
            '';
          });
        in
        prev.anydesk.overrideAttrs (o: {
          postFixup =
            builtins.replaceStrings [ "patchelf \\" ] [ "${prev.lib.getExe patchelf} \\" ]
              o.postFixup;
        });
    })
  ];
}
