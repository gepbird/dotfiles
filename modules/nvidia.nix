self: { pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = false; # when enabled lightdm is not visible
    nvidiaSettings = true;
    forceFullCompositionPipeline = false; # when enabled fixes screen tearing, but disables other monitors
  };

  hm-gep.home.packages = with pkgs; [
    nvtopPackages.full
  ];
}
