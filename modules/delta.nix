self:
{
  pkgs,
  ...
}:

{
  hm-gep.programs.delta = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.delta;
    enableGitIntegration = true;
    options = {
      hunk-header-decoration-style = "ul";
    };
  };
}
