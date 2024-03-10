{ pkgs, ... }:

let
  jsonFormat = pkgs.formats.json { };
in
{
  hm.home.packages = with pkgs; [
    clang-tools
    emmet-ls
    lemminx
    lldb
    lua-language-server
    netcoredbg
    nil
    nixpkgs-fmt
    nodePackages.prettier # css, yaml, markdown (unused: js+ts, html, json, graphql)
    nodePackages.pyright
    nodePackages.typescript-language-server
    omnisharp-roslyn
    phpactor
    rust-analyzer
    rustfmt
    taplo
    texlab
    vscode-langservers-extracted # html, css, json, eslint
    yaml-language-server
    yapf
  ];

  hm.home.file.".omnisharp/omnisharp.json".source = jsonFormat.generate "omnisharp.json" {
    RoslynExtensionsOptions = {
      EnableDecompilationSupport = true;
    };
  };
}
