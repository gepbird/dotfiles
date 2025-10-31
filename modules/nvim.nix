self:
{
  ...
}:

{
  hm-gep.xdg.mimeApps.defaultApplications = {
    "text/plain" = [ "nvim.desktop" ];
    "application/xml" = [ "nvim.desktop" ];
  };

  hm-gep.home.shellAliases = {
    v = "nvim";
  };

  hm-gep.home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
  };
}
