self: { config, pkgs, lib, ... }:

let
  finalPackage = lib.getExe config.hm-gep.programs.neovim.finalPackage;
in
{
  hm-gep.programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraLuaConfig = "require 'gep'";
    package = self.inputs.neovim-nightly.packages.${pkgs.system}.default.override (prev: {
      # https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/461
      # https://github.com/tree-sitter/tree-sitter/issues/973
      tree-sitter = prev.tree-sitter.overrideAttrs {
        patches = [
          (pkgs.fetchpatch {
            url = "https://github.com/gepbird/tree-sitter/commit/4eb2ab69ce4c1ab399e282369ca04c94a1b34c6f.patch";
            hash = "sha256-mPW04JwPYq94uZUhx6CH7Ii+dE2+kavG6TsyrpWoNf0=";
          })
        ];
      };
    });
    plugins = with pkgs; with vimUtils;
      with pkgs.vimPlugins; [
        nvim-web-devicons

        vscode-nvim
        lualine-nvim
        lsp-progress-nvim
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
        remember-nvim

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
        cmp_luasnip
        copilot-lua
        copilot-cmp
        luasnip
        friendly-snippets

        nvim-lspconfig
        guard-nvim
        lspsaga-nvim
        trouble-nvim

        nvim-dap
        nvim-dap-ui
        nvim-dap-virtual-text
        telescope-dap-nvim

        rustaceanvim
        flutter-tools-nvim
        markdown-preview-nvim
        omnisharp-extended-lsp-nvim
        vimtex
        ChatGPT-nvim
      ];
  };

  hm-gep.xdg.configFile."nvim/lua".source =
    self.lib.mkDotfilesSymlink config "modules/nvim/lua";
  hm-gep.xdg.configFile."nvim/after".source =
    self.lib.mkDotfilesSymlink config "modules/nvim/after";

  hm-gep.xdg.mimeApps.defaultApplications = {
    "text/plain" = [ "nvim.desktop" ];
  };

  hm-gep.home.shellAliases = {
    v = finalPackage;
  };

  hm-gep.home.sessionVariables = {
    MANPAGER = "${finalPackage} +Man!";
  };
}
