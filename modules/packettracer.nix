self:
{
  pkgs,
  ...
}:

{
  # NOTE: MANUAL INSTALL REQUIRED FOR PACKET TRACER:
  # log into netacad and download packet tracer for ubuntu: https://www.netacad.com/resources/lab-downloads
  # add it to the nix store: `nix-store --add-fixed sha256 CiscoPacketTracer_900_Ubuntu_64bit.deb`
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      ciscoPacketTracer9
    ];
}
