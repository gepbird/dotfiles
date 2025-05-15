self:
{
  config,
  pkgs,
  lib,
  ...
}:

let
  finalPackage = lib.getExe config.hm-gep.programs.neovim.finalPackage;

  # https://github.com/zbirenbaum/copilot-cmp/pull/126
  copilot-cmp = pkgs.vimPlugins.copilot-cmp.overrideAttrs (o: {
    patches = (o.patches or [ ]) ++ [
      (toString (
        pkgs.fetchpatch2 {
          name = "deprecation-varning-fix.patch";
          url = "https://github.com/zbirenbaum/copilot-cmp/commit/80891f552bb3f02a768e2d86ac3f9786c3fbb753.patch";
          hash = "sha256-XVsfnb2+E8OnVGMZjCW5rrp18P/x84b7iHH597VcjQQ=";
        }
      ))
    ];
  });

  gptmodels-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "gptmodels-nvim";
    version = "0-unstable-2025-04-19";
    src = pkgs.fetchFromGitHub {
      owner = "Aaronik";
      repo = "GPTModels.nvim";
      rev = "8807b55af2d81370a258eeecf84ab926e2e43826";
      hash = "sha256-rEqWFR/5ZukHNB+04ZpRVlHF913ofHCJWDxOB7zdjS4=";
    };
    dependencies = with pkgs.vimPlugins; [
      nui-nvim
      telescope-nvim
    ];
  };
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
      gptmodels-nvim
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
