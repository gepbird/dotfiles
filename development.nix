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
        in
        with pkgs.vimPlugins; [
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
          comment-nvim
          nvim-autopairs
          nvim-lastplace

          nvim-treesitter.withAllGrammars
          nvim-treesitter-textobjects
          rainbow-delimiters-nvim

          telescope-nvim
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

    home.packages = with pkgs;
      let
        latex = (texlive.withPackages (ps: with ps; [
          scheme-basic

          latexmk

          #collection-mathscience
          naive-ebnf # fixes tikz.sty not found
          siunitx
          steinmetz # required for \phasor

          xstring
          soul
          environ
          circuitikz
          pict2e # required for \phasor
        ]));
      in
      [
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
        #texlive.combined.scheme-full
        latex
        nixpkgs-review
        nix-prefetch-git

        clang-tools
        lldb
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
