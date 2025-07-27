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
    stylelint-lsp
    vscode-langservers-extracted # html, css, json, eslint
  ];
}
