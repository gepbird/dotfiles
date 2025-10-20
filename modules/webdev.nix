self:
{
  pkgs,
  ...
}:

let
  prettier = self.lib.maybeCacheDerivation "nixpkgs-package-prettier-without-license-${self.inputs.nixpkgs.narHash}" (
    self.lib.removeLicense pkgs pkgs.prettier
  );
in
{
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      emmet-language-server
      nodePackages.typescript-language-server
      nodejs
      stylelint-lsp
      vscode-langservers-extracted # html, css, json, eslint
    ]
    ++ [
      prettier
    ];
}
