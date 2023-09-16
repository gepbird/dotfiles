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
      php
      php83Packages.composer
      python3
      python311Packages.pip
      nodejs
      #openjdk8
      openjdk19
      gradle
      dotnet-sdk
      flutter
      sqlite
      dbeaver

      clang-tools
      rust-analyzer
      phpactor
      lua-language-server
      omnisharp-roslyn
      netcoredbg
      nodePackages.typescript-language-server
      emmet-ls
      vscode-langservers-extracted # html, css, json (unused: eslint)
      prettierd # js+ts, css, json, yaml, markdown (unused: html, graphql)
      nodePackages.pyright
      yapf
      # TODO: use latest debugpy when fixed: https://github.com/NixOS/nixpkgs/pull/255379
      python310Packages.debugpy
      rnix-lsp
    ];
  };
}
