self: { config, pkgs, lib, ... }:

let
  finalPackage = lib.getExe config.hm-gep.programs.neovim.finalPackage;
in
{
  # https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/461
  # https://github.com/tree-sitter/tree-sitter/issues/973
  nixpkgs.overlays = [
    (final: prev: {
      tree-sitter = prev.tree-sitter.overrideAttrs {
        patches = [
          (prev.fetchpatch {
            url = "https://github.com/gepbird/tree-sitter/commit/4b93751ee7fe92b3063baf0cd4d80e7991c6e5e8.patch";
            hash = "sha256-bMFrPozoWUbSNdKyPVsFQLhSf+MYb3aiWlybI2/J6Zg=";
          })
        ];
      };
    })
  ];

  hm-gep.programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraLuaConfig = "require 'gep'";
    package = self.inputs.neovim-nightly.packages.${pkgs.system}.default;
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
