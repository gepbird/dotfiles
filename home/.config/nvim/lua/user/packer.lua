require 'user.utils'

require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }

  use { 'easymotion/vim-easymotion', config = function() require 'user.easymotion' end }
  use { 'numToStr/Comment.nvim', config = function() require 'user.comment' end }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-surround', config = function() require 'user.surround' end }
  use { 'windwp/nvim-autopairs', config = function() require 'user.autopairs' end }
  use { 'rcarriga/nvim-notify', config = function() require 'user.notify' end }

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
    }
  }
  use { 'github/copilot.vim', config = function() require 'user.copilot' end }

  use { 'neovim/nvim-lspconfig', config = function() require 'user.lsp' end,
    requires = {
      { 'williamboman/nvim-lsp-installer' },
    }
  }
  use { 'nvim-treesitter/nvim-treesitter', config = function() require 'user.treesitter' end,
    run = function() require('nvim-treesitter.install').update { with_sync = true } end,
    requires = {
      { 'p00f/nvim-ts-rainbow' },
    }
  }
  use { 'folke/trouble.nvim', config = function() require 'user.lsp.trouble' end,
    requires ={
      { 'kyazdani42/nvim-web-devicons' },
    }
  }

  use { 'nvim-telescope/telescope.nvim', config = function() require 'user.telescope' end,
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-file-browser.nvim' },
      { 'nvim-telescope/telescope-media-files.nvim',
        requires = {
          'nvim-lua/plenary.nvim',
          'nvim-lua/popup.nvim',
        }
      },
    }
  }

  use { 'kyazdani42/nvim-tree.lua', config = function() require 'user.tree' end,
    requires ={
      { 'kyazdani42/nvim-web-devicons' },
    }
  }

  use { 'lewis6991/gitsigns.nvim', config = function() require 'user.gitsigns' end }
  use { 'LunarVim/darkplus.nvim', config = function() require 'user.colorscheme' end }
  use { 'akinsho/bufferline.nvim', config = function() require 'user.bufferline' end,
    requires = {
      { 'kyazdani42/nvim-web-devicons' },
      { 'LunarVim/darkplus.nvim' },
      { 'moll/vim-bbye' },
    }
  }
end)

register_maps {
  { 'n', '<space>ps', ':PackerSync<cr>' },
  { 'n', '<space>pS', ':PackerStatus<cr>' },
}

