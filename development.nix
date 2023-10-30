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
      # TODO: remove when luals includes commit https://github.com/CppCXY/EmmyLuaCodeStyle/commit/aa767977707dc36a2558765c7111910fbe937f1e
      (lua-language-server.overrideAttrs (_: {
        version = "3.7.0-unstable-2023-10-30";
        src = pkgs.fetchFromGitHub {
          owner = "gepbird";
          repo = "lua-language-server";
          rev = "449b43ce7e5b217baa020dc737250841fed529e4";
          hash = "sha256-JeoBkiet4EkMgx1FHGn/BWXc0NgHbOOB97kJVWXms0U=";
          fetchSubmodules = true;
        };
      }))
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
