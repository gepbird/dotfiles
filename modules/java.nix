self:
{
  pkgs,
  ...
}:

{
  environment.sessionVariables = {
    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
  };

  # home-manager doesn't like packages with conflicting fiels
  environment.systemPackages =
    with pkgs;
    self.lib.maybeCachePackages self [
      jdk8
      jdk17
      jdk21
    ];

  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      bytecode-viewer
    ];
}
