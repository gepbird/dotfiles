self:
{
  config,
  pkgs,
  lib,
  ...
}:

let
  finalPackage = lib.getExe config.hm-gep.programs.neovim.finalPackage;

  # https://github.com/nvimdev/lspsaga.nvim/pull/1538 but was reverted
  lspsaga-nvim = pkgs.vimPlugins.lspsaga-nvim.overrideAttrs (o: {
    patches = (o.patches or [ ]) ++ [
      (toString (
        pkgs.fetchpatch2 {
          name = "deprecation-warning-fix.patch";
          url = "https://github.com/nvimdev/lspsaga.nvim/commit/ff6b5be0ca32e7b8b34d9415084aa353dc52277f.patch";
          hash = "sha256-u6KFa0j+4kpAr3VltVLsY7d/dBxieXoQ/4W1tPo/1T0=";
        }
      ))
    ];
  });
in
{
  nixpkgs.overlays = [
    self.inputs.neovim-nightly.overlays.default

    # DISABLED: try to reproduce the slowdown without this patch
    # https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/461
    # https://github.com/tree-sitter/tree-sitter/issues/973
    #(final: prev: {
    #  neovim = prev.neovim.override (prev: {
    #    tree-sitter = prev.tree-sitter.overrideAttrs {
    #      patches = [
    #        (pkgs.fetchpatch {
    #          url = "https://github.com/gepbird/tree-sitter/commit/4eb2ab69ce4c1ab399e282369ca04c94a1b34c6f.patch";
    #          hash = "sha256-mPW04JwPYq94uZUhx6CH7Ii+dE2+kavG6TsyrpWoNf0=";
    #        })
    #      ];
    #    };
    #  });
    #})

    # faster build, useful for debugging
    #(final: prev: {
    #  neovim = prev.neovim.overrideAttrs (prev: {
    #    cmakeFlags = [
    #      "-DENABLE_LTO=OFF"
    #    ];
    #  });
    #})
  ];

  hm-gep.programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraLuaConfig = "require 'gep'";
    package = pkgs.neovim;
    plugins = with pkgs.vimPlugins; [
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
      (nvim-treesitter-textobjects.overrideAttrs {
        src = self.inputs.nvim-treesitter-textobjects;
      })
      rainbow-delimiters-nvim
      nvim-colorizer-lua

      telescope-nvim
      telescope-ui-select-nvim
      telescope-fzf-native-nvim

      vim-fugitive
      vim-rhubarb
      gitsigns-nvim

      blink-cmp
      blink-cmp-copilot
      copilot-lua
      friendly-snippets

      nvim-lspconfig
      guard-nvim
      guard-collection
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
      typst-preview-nvim
      GPTModels-nvim
    ];
  };

  hm-gep.xdg.configFile."nvim/lua".source = self.lib.mkDotfilesSymlink config "modules/nvim/lua";
  hm-gep.xdg.configFile."nvim/after".source = self.lib.mkDotfilesSymlink config "modules/nvim/after";

  hm-gep.xdg.mimeApps.defaultApplications = {
    "text/plain" = [ "nvim.desktop" ];
  };

  hm-gep.home.shellAliases = {
    v = finalPackage;
  };

  hm-gep.home.sessionVariables = {
    MANPAGER = "${finalPackage} +Man!";
  };

  hm-gep.home.packages = with pkgs; [
    lua-language-server
  ];
}
