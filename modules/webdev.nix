self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages = with pkgs; [
    emmet-language-server
    nodePackages.typescript-language-server
    nodejs
    prettier
    stylelint-lsp
    vscode-langservers-extracted # html, css, json, eslint
  ];
}
