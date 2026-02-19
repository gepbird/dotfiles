self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      emmet-language-server
      nodePackages.typescript-language-server
      nodejs
      pnpm
      prettier
      stylelint-lsp
      vscode-langservers-extracted # html, css, json, eslint
    ];
}
