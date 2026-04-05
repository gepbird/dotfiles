self:
{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
    open = false; # "The NVIDIA GPU 0000:01:00.0 (PCI ID: 10de:1b80) installed in this system is not supported by open"
    nvidiaSettings = true;
    forceFullCompositionPipeline = false; # when enabled fixes screen tearing, but disables other monitors
  };

  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      nvtopPackages.full
    ];

  systemd.user.services.nvidia-settings = {
    description = "nvidia-settings";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig =
      let
        nvidiaSettings = lib.getExe config.hardware.nvidia.package.settings;
        settingsFile = pkgs.writeText ".nvidia-settings-rc" ''
          # fix colors being too dark
          [DPY:DVI-D-0]/ColorRange=1
          [DPY:HDMI-0]/ColorRange=1
          [DPY:DP-1]/ColorRange=1
        '';
      in
      {
        Type = "oneshot";
        ExecStart = "${nvidiaSettings} --config=${settingsFile} --load-config-only";
      };
  };
}
