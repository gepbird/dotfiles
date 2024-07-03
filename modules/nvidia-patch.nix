self: { lib, ... }:

let
  pkgs-nvidia = import self.inputs.nixpkgs-nvidia { };
in
{
  hardware.nvidia.package = pkgs-nvidia.linuxPackages.nvidiaPackages.latest;

  boot.kernelPackages = lib.mkForce pkgs-nvidia.linuxPackages_6_6;
}
