{
  pkgs,
  self,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      emmet-language-server
      nodejs
      pnpm
      prettier
      stylelint-lsp
      typescript-language-server
      vscode-langservers-extracted # html, css, json, eslint
    ];
}
