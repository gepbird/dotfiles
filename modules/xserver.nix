self:
{
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
  };

  console.useXkbConfig = true;
}
