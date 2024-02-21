{ config, pkgs, ... }:

{
  home-manager.users.gep = {
    xdg.mimeApps.defaultApplications = {
      "text/plain" = [ "nvim.desktop" ];
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      extraLuaConfig = "require 'gep'";
      plugins = with pkgs; with vimUtils;
        with pkgs.vimPlugins; [
          nvim-web-devicons

          vscode-nvim
          lualine-nvim
          bufferline-nvim
          nvim-window-picker
          neo-tree-nvim
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
          nvim-colorizer-lua

          telescope-nvim
          telescope-ui-select-nvim
          telescope-fzf-native-nvim

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
        dotnet-sdk
        flutter
        sqlite
        dbeaver

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
        nil
        nixpkgs-fmt
        lemminx
        taplo
        yaml-language-server
      ];
  };
}
