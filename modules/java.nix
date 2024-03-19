self: { pkgs, lib, ... }:

{
  environment.sessionVariables = {
    PATH = [ "$HOME/.local/bin" ];
    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
  };

  hm.home.file = with lib; with pkgs; {
    ".local/bin/java-8".source = getExe' jdk8 "java";
    ".local/bin/java-21".source = getExe' jdk21 "java";
  };

  hm.home.packages = with pkgs; [
    jdk21
    gradle
    jd-gui
  ];
}
