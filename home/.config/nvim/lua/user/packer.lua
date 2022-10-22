local packer = require 'packer'
packer.startup(function(use)
  local darkplus = { 'gutyina70/darkplus.nvim', config = function() require 'user.colorscheme' end }

  use { 'wbthomason/packer.nvim' }
  use { 'lewis6991/impatient.nvim', config = function() require 'impatient'.enable_profile() end }
  use { 'antoinemadec/FixCursorHold.nvim', config = function() vim.cmd 'let g:cursorhold_updatetime = 50' end }

  use { 'phaazon/hop.nvim', config = function() require 'user.hop' end }
  use { 'numToStr/Comment.nvim', config = function() require 'user.comment' end }
  use { 'tpope/vim-repeat' }
  use { 'machakann/vim-sandwich', config = function() require 'user.sandwich' end }
  use { 'windwp/nvim-autopairs', config = function() require 'user.autopairs' end,
    requires = {
      { 'hrsh7th/nvim-cmp' },
    },
  }
  use { 'rcarriga/nvim-notify', config = function() require 'user.notify' end,
    requires = {
      { 'nvim-telescope/telescope.nvim' },
    },
  }
  use { 'nvim-lualine/lualine.nvim', config = function() require 'user.lualine' end,
    requires = {
      { 'kyazdani42/nvim-web-devicons' },
      { 'mfussenegger/nvim-dap' },
      darkplus,
    },
  }
  use { 'ethanholz/nvim-lastplace', config = function() require 'user.lastplace' end }

  --use { 'github/copilot.vim', config = function() require 'user.copilot' end }
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
  use { 'williamboman/mason.nvim', config = function() require 'user.mason' end,
    requires = {
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    },
  }
  use { 'mfussenegger/nvim-dap', config = function() require 'user.dap' end,
    requires = {
      { 'rcarriga/nvim-dap-ui' },
      { 'williamboman/mason.nvim' },
      { 'theHamsta/nvim-dap-virtual-text' },
      { 'nvim-telescope/telescope-dap.nvim',
        requires = {
          'nvim-telescope/telescope.nvim',
        },
      },
      { 'jbyuki/one-small-step-for-vimkind' },
      { 'Joakker/lua-json5', run = './install.sh' },
    },
  }

  use { 'neovim/nvim-lspconfig', config = function() require 'user.lsp' end,
    requires = {
      { 'williamboman/mason-lspconfig.nvim',
        requires = {
          'williamboman/mason.nvim',
        },
      },
      { 'glepnir/lspsaga.nvim', config = function() require 'user.lsp.lspsaga' end },
      { 'folke/trouble.nvim', config = function() require 'user.lsp.trouble' end,
        requires = {
          'kyazdani42/nvim-web-devicons',
        },
      },
      { 'Hoffs/omnisharp-extended-lsp.nvim' },
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
      { 'ahmedkhalf/project.nvim', config = function() require 'user.project' end },
    },
  }

  use { 'kyazdani42/nvim-tree.lua', config = function() require 'user.tree' end,
    requires = {
      { 'kyazdani42/nvim-web-devicons' },
    },
  }
  use { 'kevinhwang91/nvim-bqf', config = function() require 'user.bqf' end }
  use { 'akinsho/toggleterm.nvim', config = function() require 'user.toggleterm' end }

  use { 'lewis6991/gitsigns.nvim', config = function() require 'user.gitsigns' end }
  use { 'https://github.com/tpope/vim-fugitive', config = function() require 'user.fugitive' end,
    requires = {
      { 'tpope/vim-rhubarb' },
    },
  }
  use(darkplus)
  use { 'akinsho/bufferline.nvim', config = function() require 'user.bufferline' end,
    requires = {
      { 'kyazdani42/nvim-web-devicons' },
      darkplus,
      { 'moll/vim-bbye' },
    },
  }

  use { 'akinsho/flutter-tools.nvim', config = function() require 'user.fluttertools' end,
    requires = {
      'nvim-lua/plenary.nvim',
    },
  }
end)

require 'user.utils'.register_maps {
  { 'n', '<space>ps', function()
    packer.sync()
    local ok, treesitter_install = pcall(require, 'nvim-treesitter.install')
    if ok then
      treesitter_install.update()
    end
  end,
  },
  { 'n', '<space>pS', packer.status },
}
