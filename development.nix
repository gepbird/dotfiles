{ config, pkgs, ... }:

{
  home-manager.users.gep = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      extraLuaConfig = "require 'gep'";
      plugins = with pkgs; with vimUtils;
        let
          darkplus-nvim = buildVimPlugin {
            pname = "darkplus-nvim";
            version = "2023-11-06";
            src = fetchFromGitHub {
              owner = "gepbird";
              repo = "darkplus.nvim";
              rev = "276e1f2794af13a90bae1df08f7e72c2a5badd53";
              hash = "sha256-j+z+K/T3eyS6oJUGtd6J77JD7DXEFSZocR8BWlOVznM=";
            };
            meta.homepage = "https://github.com/gepbird/darkplus.nvim/";
          };
          # TODO: remove when merged https://github.com/NixOS/nixpkgs/pull/270510
          guard-collection = buildVimPlugin {
            pname = "guard-collection";
            version = "2023-11-13";
            src = fetchFromGitHub {
              owner = "nvimdev";
              repo = "guard-collection";
              rev = "13e00d19f418d68977c6bc803f0d23d09dce580d";
              sha256 = "1zhq99hf722m5m842ghadj9akmb0y1sqkpmbhhk15jynnvv16ab6";
            };
            meta.homepage = "https://github.com/nvimdev/guard-collection/";
          };
          guard-nvim = buildVimPlugin {
            pname = "guard.nvim";
            version = "2023-11-27";
            src = fetchFromGitHub {
              owner = "nvimdev";
              repo = "guard.nvim";
              rev = "394317c25a6b0f0e064aebcfcf902e46fb0a04ba";
              sha256 = "sha256-Yva/mSn5RdvHLK5cVGHUCEHRauYrwy7wR2uDzyBM9sw=";
            };
            meta.homepage = "https://github.com/nvimdev/guard.nvim/";
            dependencies = [ guard-collection ];
          };
        in
        with pkgs.vimPlugins; [
          impatient-nvim
          nvim-web-devicons

          darkplus-nvim
          lualine-nvim
          bufferline-nvim
          nvim-tree-lua
          toggleterm-nvim
          nvim-bqf
          undotree
          vim-bbye

          vim-repeat
          vim-sandwich
          hop-nvim
          comment-nvim
          nvim-autopairs
          nvim-lastplace

          nvim-treesitter.withAllGrammars
          nvim-treesitter-textobjects
          nvim-ts-rainbow

          telescope-nvim
          telescope-file-browser-nvim
          telescope-media-files-nvim
          telescope-ui-select-nvim

          vim-fugitive
          vim-rhubarb
          gitsigns-nvim

          nvim-cmp
          cmp-nvim-lsp
          cmp-buffer
          cmp-path
          cmp-cmdline
          cmp-nvim-lua
          cmp_luasnip
          copilot-lua
          copilot-cmp
          luasnip
          friendly-snippets

          nvim-lspconfig
          guard-nvim
          lspsaga-nvim
          trouble-nvim
          fidget-nvim

          nvim-dap
          nvim-dap-ui
          nvim-dap-virtual-text
          telescope-dap-nvim

          rust-tools-nvim
          flutter-tools-nvim
          markdown-preview-nvim
          omnisharp-extended-lsp-nvim
          vimtex
        ];
    };

    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
    };

    home.file =
      let
        mkOutOfStoreSymlink = config.home-manager.users.gep.lib.file.mkOutOfStoreSymlink;
        homeDirectory = config.home-manager.users.gep.home.homeDirectory;
      in
      {
        ".omnisharp".source = ./home/.omnisharp;
        ".config/nvim/lua".source = mkOutOfStoreSymlink "${homeDirectory}/dotfiles/nvim/lua";
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
      nix-prefetch-git

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
