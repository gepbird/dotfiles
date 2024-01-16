{ config, pkgs, ... }:

{
  home-manager.users.gep = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      extraLuaConfig = "require 'gep'";
      plugins = with pkgs; with vimUtils;
        let
          vscode-nvim = buildVimPlugin {
            pname = "vscode-nvim";
            version = "2023-11-06";
            src = fetchFromGitHub {
              owner = "Mofiqul";
              repo = "vscode.nvim";
              rev = "master";
              hash = "sha256-DnVDm0m3cvdPKZuCSRzBdHKgPXGB4X3nBsykFJjfzvY=";
            };
            meta.homepage = "https://github.com/gepbird/darkplus.nvim/";
          };
        in
        with pkgs.vimPlugins; [
          nvim-web-devicons

          vscode-nvim
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
        lua-language-server
        omnisharp-roslyn
        netcoredbg
        nodePackages.typescript-language-server
        emmet-ls
        vscode-langservers-extracted # html, css, json (unused: eslint)
        nodePackages.prettier # css, yaml, markdown (unused: js+ts, html, json, graphql)
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
