self:
{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.xserver = {
    enable = true;
    excludePackages = with pkgs; [
      xterm
    ];
    xkb.layout = "hu";
    xkb.options = "caps:escape";
    autoRepeatDelay = 250;
    autoRepeatInterval = 30;
    # disable black screen after 10 minutes
    serverLayoutSection = ''
      Option "BlankTime" "0"
    '';
    updateDbusEnvironment = true;

    # `services.xserver.xkb.layout` only applies for real devices, but rustdesk uses the
    # "Virtual core XTEST keyboard" device that has hardcoded the US layout, this applies globally:
    displayManager.sessionCommands = "${lib.getExe pkgs.setxkbmap} -layout ${config.services.xserver.xkb.layout}";
  };

  console.useXkbConfig = true;
}
