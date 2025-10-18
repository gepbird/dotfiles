self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      lemminx
      prettierd # yaml, markdown (unused: js+ts, css, html, json, graphql)
      taplo
      vscode-langservers-extracted # json (unused: html, css, eslint)
      yaml-language-server
    ];
}
