self:
{
  pkgs,
  ...
}:

let
  jsonFormat = pkgs.formats.json { };
in
{
  hm-gep.home.packages = with pkgs; [
    clang-tools
    emmet-ls
    lemminx
    lldb
    lua-language-server
    netcoredbg
    nixd
    nixfmt-rfc-style
    prettierd # yaml, markdown (unused: js+ts, css, html, json, graphql)
    nodePackages.typescript-language-server
    omnisharp-roslyn
    phpactor
    pyright
    rust-analyzer
    rustfmt
    stylelint-lsp
    taplo
    texlab
    vscode-langservers-extracted # html, css, json, eslint
    yaml-language-server
  ];

  hm-gep.home.file.".omnisharp/omnisharp.json".source = jsonFormat.generate "omnisharp.json" {
    RoslynExtensionsOptions = {
      EnableDecompilationSupport = true;
    };
  };
}
