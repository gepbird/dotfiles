self:
{
  config,
  pkgs,
  lib,
  ...
}:

let
  pkgs-nvidia = import self.inputs.nixpkgs-nvidia {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };
in
{
  boot.kernelPackages = lib.mkForce pkgs-nvidia.linuxPackages_zen;

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = false; # when enabled lightdm is not visible
    nvidiaSettings = true;
    forceFullCompositionPipeline = false; # when enabled fixes screen tearing, but disables other monitors
  };

  hm-gep.home.packages = with pkgs; [
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
