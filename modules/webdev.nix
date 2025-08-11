self:
{
  pkgs,
  ...
}:

let
  prettier = self.lib.removeLicense pkgs pkgs.prettier;
in
{
  hm-gep.home.packages =
    with pkgs;
    self.lib.cachePackages self [
      emmet-language-server
      nodePackages.typescript-language-server
      nodejs
      prettier
      stylelint-lsp
      vscode-langservers-extracted # html, css, json, eslint
    ];
}
