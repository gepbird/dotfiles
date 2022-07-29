require 'user.utils'

require 'packer'.startup(function(use)
  use { 'wbthomason/packer.nvim' }

  use { 'phaazon/hop.nvim', config = function() require 'user.hop' end }
  use { 'numToStr/Comment.nvim', config = function() require 'user.comment' end }
  use { 'tpope/vim-repeat' }
  use { 'machakann/vim-sandwich', config = function() require 'user.sandwich' end }
  use { 'windwp/nvim-autopairs', config = function() require 'user.autopairs' end,
    requires = {
      { 'hrsh7th/nvim-cmp' },
    },
  }
  use { 'rcarriga/nvim-notify', config = function() require 'user.notify' end }
  use { 'nvim-lualine/lualine.nvim', config = function() require 'user.lualine' end,
    requires = {
      { 'kyazdani42/nvim-web-devicons' },
      { 'LunarVim/darkplus.nvim' },
    },
  }
  use { 'ethanholz/nvim-lastplace', config = function() require 'user.lastplace' end }

  use { 'hrsh7th/nvim-cmp', config = function() require 'user.cmp' end,
    requires = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'L3MON4D3/LuaSnip', config = function() require 'user.snippets' end },
      { 'rafamadriz/friendly-snippets' },
    },
  }
  use { 'github/copilot.vim', config = function() require 'user.copilot' end }

  use { 'neovim/nvim-lspconfig', config = function() require 'user.lsp' end,
    requires = {
      { 'williamboman/nvim-lsp-installer' },
      { 'glepnir/lspsaga.nvim', config = function() require 'user.lsp.lspsaga' end },
      { 'folke/trouble.nvim', config = function() require 'user.lsp.trouble' end,
        requires = {
          { 'kyazdani42/nvim-web-devicons' },
        },
      }
    },
  }
  use { 'nvim-treesitter/nvim-treesitter', config = function() require 'user.treesitter' end,
    run = function() require 'nvim-treesitter.install'.update { with_sync = true } end,
    requires = {
      { 'p00f/nvim-ts-rainbow' },
    },
  }

  use { 'nvim-telescope/telescope.nvim', config = function() require 'user.telescope' end,
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-file-browser.nvim' },
      { 'nvim-telescope/telescope-media-files.nvim',
        requires = {
          'nvim-lua/plenary.nvim',
          'nvim-lua/popup.nvim',
        },
      },
    },
  }

  use { 'kyazdani42/nvim-tree.lua', config = function() require 'user.tree' end,
    requires = {
      { 'kyazdani42/nvim-web-devicons' },
    },
  }
  use { 'akinsho/toggleterm.nvim', config = function() require 'user.toggleterm' end }

  use { 'lewis6991/gitsigns.nvim', config = function() require 'user.gitsigns' end }
  use { 'gutyina70/darkplus.nvim', config = function() require 'user.colorscheme' end }
  use { 'akinsho/bufferline.nvim', config = function() require 'user.bufferline' end,
    requires = {
      { 'kyazdani42/nvim-web-devicons' },
      { 'LunarVim/darkplus.nvim' },
      { 'moll/vim-bbye' },
    },
  }
end)

register_maps {
  { 'n', '<space>ps', ':PackerSync<cr>' },
  { 'n', '<space>pS', ':PackerStatus<cr>' },
}
