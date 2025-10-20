self:
{
  pkgs,
  ...
}:

{
  # NOTE: MANUAL INSTALL REQUIRED FOR PACKET TRACER:
  # log into netacad and download packet tracer for ubuntu: https://www.netacad.com/resources/lab-downloads
  # rename downloaded file to old schema: mv Packet_Tracer822_amd64_signed.deb CiscoPacketTracer822_amd64_signed.deb
  # add it to the nix store: nix-store --add-fixed sha256 CiscoPacketTracer822_amd64_signed.deb
  hm-gep.home.packages = with pkgs; [
    ciscoPacketTracer8
  ];

  nixpkgs.overlays = [
    # fix text being unreadable and ugly due to half applied dark theme
    (final: prev: {
      ciscoPacketTracer8 =
        self.lib.maybeCacheDerivation
          "nixpkgs-package-ciscoPacketTracer8-fix-theming-${self.inputs.nixpkgs.narHash}"
          (
            prev.ciscoPacketTracer8.overrideAttrs (o: {
              nativeBuildInputs = (o.nativeBuildInputs or [ ]) ++ [
                prev.makeWrapper
              ];
              postInstall = (o.postInstall or "") + ''
                wrapProgram $out/bin/packettracer8 \
                  --unset QT_QPA_PLATFORMTHEME \
                  --unset QT_STYLE_OVERRIDE
              '';
            })
          );
    })
  ];
}
