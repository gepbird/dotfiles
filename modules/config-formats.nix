{
  pkgs,
  self,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      prettierd # yaml, markdown (unused: js+ts, css, html, json, graphql)
    ];
}
