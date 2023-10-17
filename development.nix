{ pkgs, ... }:

{
  home-manager.users.gep = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };

    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
    };

    home.file = {
      # use manual symlinking for nvim, configuring it with slow rebuild time is pain
      #".config/nvim/ftplugin".source = ./home/.config/nvim/ftplugin;
      #".config/nvim/lua".source = ./home/.config/nvim/lua;
      #".config/nvim/init.lua".source = ./home/.config/nvim/init.lua;
      #".config/nvim/.luarc.json".source = ./home/.config/nvim/.luarc.json;
      ".omnisharp".source = ./home/.omnisharp;
    };

    home.packages = with pkgs; [
      gcc
      gnumake
      rustc
      cargo
      cargo-watch
      php
      php83Packages.composer
      (python3.withPackages (ps: with ps; [
        pip
        debugpy
      ]))
      nodejs
      #openjdk8
      openjdk19
      gradle
      dotnet-sdk
      flutter
      sqlite
      dbeaver
      texlive.combined.scheme-full
      nixpkgs-review

      clang-tools
      rust-analyzer
      rustfmt
      phpactor
      lua-language-server
      omnisharp-roslyn
      netcoredbg
      nodePackages.typescript-language-server
      emmet-ls
      vscode-langservers-extracted # html, css, json (unused: eslint)
      prettierd # js+ts, css, json, yaml, markdown (unused: html, graphql)
      nodePackages.pyright
      texlab
      yapf
      rnix-lsp
      lemminx
      taplo
      yaml-language-server
    ];
  };
}
