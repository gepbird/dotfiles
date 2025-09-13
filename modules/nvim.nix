self:
{
  pkgs,
  ...
}:

let
  package = self.inputs.nvim.packages.${pkgs.system}.default;
in
{
  hm-gep.home.packages = [
    package
  ];

  hm-gep.xdg.mimeApps.defaultApplications = {
    "text/plain" = [ "nvim.desktop" ];
  };

  hm-gep.home.shellAliases = {
    v = "nvim";
  };

  hm-gep.home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
  };
}
