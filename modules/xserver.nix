self: { ... }:

{
  #services.xserver = {
  #  enable = true;
  #  xkb.layout = "hu";
  #  xkb.options = "caps:escape";
  #  autoRepeatDelay = 250;
  #  autoRepeatInterval = 30;
  #  # disable black screen after 10 minutes
  #  serverLayoutSection = ''
  #    Option "BlankTime" "0"
  #  '';
  #};
  #
  #console.useXkbConfig = true;
}
