self:
{
  pkgs,
  lib,
  ...
}:

let
  package = self.inputs.nvim.packages.${pkgs.system}.default;
  binary = lib.getExe package;
in
{
  hm-gep.home.packages = [
    package
  ];

  hm-gep.home.sessionVariables.EDITOR = binary;

  hm-gep.xdg.mimeApps.defaultApplications = {
    "text/plain" = [ "nvim.desktop" ];
  };

  hm-gep.home.shellAliases = {
    v = binary;
  };

  hm-gep.home.sessionVariables = {
    MANPAGER = "${binary} +Man!";
  };
}
