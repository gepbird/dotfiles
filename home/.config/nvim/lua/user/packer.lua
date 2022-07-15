require 'user.utils'

require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }

  use { 'easymotion/vim-easymotion', config = function() require 'user.easymotion' end }
  use { 'preservim/nerdcommenter', config = function() require 'user.nerdcommenter' end }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-surround', config = function() require 'user.surround' end }
  use { 'windwp/nvim-autopairs', config = function() require 'user.autopairs' end }

  use {
    'hrsh7th/nvim-cmp', config = function() require 'user.cmp' end,
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      { 'L3MON4D3/LuaSnip', config = function() require 'user.snippets' end },
      'rafamadriz/friendly-snippets',
    }
  }

  use {
    'neovim/nvim-lspconfig', config = function() require 'user.lsp' end,
    requires = 'williamboman/nvim-lsp-installer',
  }
  use {
    'folke/trouble.nvim', config = function() require 'user.lsp.trouble' end,
    requires = 'kyazdani42/nvim-web-devicons',
  }

  use {
    'nvim-telescope/telescope.nvim', config = function() require 'user.telescope' end,
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
    }
  }

  use { 'ghifarit53/tokyonight-vim', config = function() require 'user.colorscheme' end }
  --use  { 'lunarvim/darkplus.nvim', config = function() vim.cmd ':colorscheme darkplus' end }

  --use 'nvim-lua/popup.nvim'
  --use { 'tpope/vim-scriptease' }

  use { 'github/copilot.vim', config = function() require 'user.copilot' end }
end)

register_maps {
  { 'n', '<space>ps', ':PackerSync<cr>' },
  { 'n', '<space>pS', ':PackerStatus<cr>' },
}

