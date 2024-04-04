self: { config, pkgs, ... }:

{
  hm-gep.programs.neovim = {
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
        # TODO: when merged: https://github.com/NixOS/nixpkgs/pull/301478
        (pkgs.vimUtils.buildVimPlugin {
          pname = "nvim-nio";
          version = "2024-04-02";
          src = pkgs.fetchFromGitHub {
            owner = "nvim-neotest";
            repo = "nvim-nio";
            rev = "173f285eebb410199273fa178aa517fd2d7edd80";
            sha256 = "0favgnfpsak44lzyzyhfavazr2i64l7ysk370xm4wbrb51kjsdkf";
          };
          meta.homepage = "https://github.com/nvim-neotest/nvim-nio/";
        })
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

  hm-gep.xdg.configFile."nvim/lua".source =
    self.lib.mkDotfilesSymlink config "modules/nvim/lua";

  hm-gep.xdg.mimeApps.defaultApplications = {
    "text/plain" = [ "nvim.desktop" ];
  };
}
