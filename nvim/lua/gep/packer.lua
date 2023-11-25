local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[ packadd packer.nvim ]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local packer = require 'packer'
packer.startup(function(use)
  use { 'wbthomason/packer.nvim' }

  use { 'lewis6991/impatient.nvim', config = function() require 'impatient' end }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'nvim-lua/popup.nvim' }
  use { 'Joakker/lua-json5', run = 'OSTYPE="linux-gnu" ./install.sh' }

  use { 'gutyina70/darkplus.nvim', config = function() require 'gep.colorscheme' end }
  use { 'nvim-lualine/lualine.nvim', config = function() require 'gep.lualine' end }
  use { 'akinsho/bufferline.nvim', config = function() require 'gep.bufferline' end }
  use { 'kyazdani42/nvim-tree.lua', config = function() require 'gep.tree' end }
  use { 'akinsho/toggleterm.nvim', config = function() require 'gep.toggleterm' end }
  use { 'kevinhwang91/nvim-bqf', config = function() require 'gep.bqf' end }
  use { 'mbbill/undotree', config = function() require 'gep.undotree' end }

  use { 'tpope/vim-repeat' }
  use { 'machakann/vim-sandwich' }
  use { 'phaazon/hop.nvim', config = function() require 'gep.hop' end }
  use { 'numToStr/Comment.nvim', config = function() require 'gep.comment' end }
  use { 'windwp/nvim-autopairs', config = function() require 'gep.autopairs' end }
  use { 'ethanholz/nvim-lastplace', config = function() require 'gep.lastplace' end }

  use { 'nvim-treesitter/nvim-treesitter', config = function() require 'gep.treesitter' end,
    run = function() require 'nvim-treesitter.install'.update { with_sync = true } end }
  use { 'p00f/nvim-ts-rainbow' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects' }
  use { 'nvim-treesitter/playground' }

  use { 'nvim-telescope/telescope.nvim', config = function() require 'gep.telescope' end }
  use { 'nvim-telescope/telescope-file-browser.nvim' }
  use { 'nvim-telescope/telescope-media-files.nvim' }
  use { 'nvim-telescope/telescope-ui-select.nvim' }

  use { 'tpope/vim-fugitive', config = function() require 'gep.fugitive' end }
  use { 'tpope/vim-rhubarb' }
  use { 'lewis6991/gitsigns.nvim', config = function() require 'gep.gitsigns' end }

  use { 'hrsh7th/nvim-cmp', config = function() require 'gep.cmp' end }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 'hrsh7th/cmp-nvim-lua' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'L3MON4D3/LuaSnip', config = function() require 'gep.snippets' end }
  use { 'rafamadriz/friendly-snippets' }

  use { 'neovim/nvim-lspconfig', config = function() require 'gep.lsp' end }
  use { 'nvimdev/guard-collection' }
  use { 'nvimdev/guard.nvim', config = function() require 'gep.lsp.guard' end }
  use { 'nvimdev/lspsaga.nvim', config = function() require 'gep.lsp.lspsaga' end }
  use { 'folke/trouble.nvim', config = function() require 'gep.lsp.trouble' end }
  use { 'j-hui/fidget.nvim', tag = 'legacy', config = function() require 'gep.lsp.fidget' end }

  use { 'mfussenegger/nvim-dap', config = function() require 'gep.dap' end }
  use { 'rcarriga/nvim-dap-ui' }
  use { 'theHamsta/nvim-dap-virtual-text' }
  use { 'nvim-telescope/telescope-dap.nvim' }

  use { 'simrat39/rust-tools.nvim', config = function() require 'gep.rusttools' end }
  use { 'akinsho/flutter-tools.nvim', config = function() require 'gep.fluttertools' end }
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && npm install',
    setup = function() vim.g.mkdp_filetypes = { 'markdown' } end, ft = { 'markdown' } }
  use { 'Hoffs/omnisharp-extended-lsp.nvim' }
  use { 'lervag/vimtex' }

  use { 'ThePrimeagen/vim-be-good' }
  use { 'moll/vim-bbye' }
  use { 'zbirenbaum/copilot.lua' }
  use { 'zbirenbaum/copilot-cmp', config = function() require 'gep.copilot' end }
end)

if packer_bootstrap then
  packer.sync()
end

require 'gep.utils'.register_maps {
  { 'n', '<space>pi', function()
    packer.sync()
    local ok, treesitter_install = pcall(require, 'nvim-treesitter.install')
    if ok then
      treesitter_install.update()
    end
  end,
  },
  { 'n', '<space>ps', packer.status },
}
