api = vim.api
fn = vim.fn
test = nil
local mark_sign = '$' .. '$'
local mark_sign_escaped = '\\$\\$'
local goto_mark = '/' .. mark_sign_escaped .. '<cr>diw'

local function load_options()
  require 'user.options'

  vim.g.EasyMotion_do_mapping = 0
  vim.g.EasyMotion_startofline = 0
  vim.g.EasyMotion_smartcase = 1

  vim.g.NERDCreateDefaultMappings = 0
  vim.g.NERDCommentEmptyLines = 1
end

local function load_maps()
  vim.g.mapleader = ' '

  local maps = {
    -- { mode, key, action, { option = value } },
    { 'nvo', '<s-h>', '5h' },
    { 'nvo', '<s-j>', '5j' },
    { 'nvo', '<s-k>', '5k' },
    { 'nvo', '<s-l>', '5l' },

    { 'nvo', '<c-h>', '_', { unmap = true } },
    { 'nvo', '<c-j>', '}', { unmap = true } },
    { 'nvo', '<c-k>', '{', { unmap = true } },
    { 'nvo', '<c-l>', '$', { unmap = true } },

    { 'nvi', '<a-h>', '<c-w>h', { unmap = true, insert_to_normal = true } },
    { 'nvi', '<a-j>', '<c-w>j', { unmap = true, insert_to_normal = true } },
    { 'nvi', '<a-k>', '<c-w>k', { unmap = true, insert_to_normal = true } },
    { 'nvi', '<a-l>', '<c-w>l', { unmap = true, insert_to_normal = true } },

    { 't', '<a-h>', '<c-\\><c-s-n><c-w>h', { unmap = true, insert_to_normal = true } },
    { 't', '<a-j>', '<c-\\><c-s-n><c-w>j', { unmap = true, insert_to_normal = true } },
    { 't', '<a-k>', '<c-\\><c-s-n><c-w>k', { unmap = true, insert_to_normal = true } },
    { 't', '<a-l>', '<c-\\><c-s-n><c-w>l', { unmap = true, insert_to_normal = true } },

    { 'nv', 'y', '"+y' },
    { 'n', '<s-y>', '"+yy', { unmap = 'yy' } },
    { 'nv', 'p', '"+p' },
    { 'nv', '<s-p>', '"+<s-p>' },
    { 'nv', '<c-p>', 'p' },
    { 'nv', '<c-s-p>', '<s-p>' },
    { 'n', '<s-c>', 'cc', { unmap = true } },
    { 'n', '<s-d>', 'dd', { unmap = true } },

    { 'ni', '<a-q>', ':q<cr>', { insert_to_normal = true } },
    { 'ni', '<a-w>', ':w<cr>', { insert_to_normal = true } },

    --{ 'c', 'é', '<cr>', { unmap = true } },
    { 'n', '<s-u>', '<c-r>', { unmap = true } },
    { 'n', 'z', 'i<cr><esc>' },
    { 'n', '<s-z>', '<s-j>' },
    { 'nvi', '<a-f>', 'mfgg=G`f', { insert_to_normal = true } },

    { 'ni', '<c-r>', ':lua reload_config()<cr>', { insert_to_normal = true } },
    { 'ni', '<a-r>', ':e $MYVIMRC<cr>', { insert_to_normal = true } },
    { 'n', '<leader>ps', ':PackerSync<cr>' },

    { 'n', 'e', '<Plug>(easymotion-sn)', { unmap = '/' } },
    { 'n', '<s-e>', ':nohlsearch<cr>' },
    { 'o', 'e', '<Plug>(easymotion-tn)', { unmap = '?' } },
    { 'nvo', 'n', '<Plug>(easymotion-next)', },
    { 'nvo', 'N', '<Plug>(easymotion-prev)', },
    { 'nvo', 'qh', '<Plug>(easymotion-linebackward)', },
    { 'nvo', 'qj', '<Plug>(easymotion-j)', },
    { 'nvo', 'qk', '<Plug>(easymotion-k)', },
    { 'nvo', 'ql', '<Plug>(easymotion-lineforward)', },
    { 'nvo', 'qf', '<Plug>(easymotion-bd-f)', },
    { 'n', 'qf', '<Plug>(easymotion-overwin-f)', },
    { 'nvo', 's', '<Plug>(easymotion-bd-f2)', },
    { 'n', 's', '<Plug>(easymotion-overwin-f2)', },
    { 'nvo', 'qw', '<Plug>(easymotion-bd-w)', },
    { 'n', 'qw', '<Plug>(easymotion-overwin-w)', },
    { 'nv', 'bi', '<Plug>NERDCommenterToggle', },
    { 'nv', 'b<s-i>', '<Plug>NERDCommenterSexy', },

    { 'v', '"', '<Plug>VSurround"' },
    { 'v', "'", "<Plug>VSurround'" },
    { 'v', '`', '<Plug>VSurround`' },
    { 'v', '(', '<Plug>VSurround)' },
    { 'v', '[', '<Plug>VSurround]' },
    { 'v', '{', '<Plug>VSurround{' },
    { 'n', 'ds', '<Plug>Dsurround' },
    { 'n', '<s-s>', '<Plug>Ysurround' },

    { 'n', '-', ':lua print(test)<cr>' },

    { 'ni', 'ö', goto_mark, { insert_to_normal = '<esc>' .. goto_mark .. 'i' } },

    { 'n', '<leader>e', ':Lex 20<cr>' },

    { 'n', '<c-up>', ':resize +2<cr>' },
    { 'n', '<c-down>', ':resize -2<cr>' },
    { 'n', '<c-left>', ':vertical resize -2<cr>' },
    { 'n', '<c-right>', ':vertical resize +2<cr>' },

    { 'n', '<s-l>', ':bnext<cr>' },
    { 'n', '<s-h>', ':bprevious<cr>' },

    { 'v', '<', '<gv' },
    { 'v', '>', '>gv' },
    { 'n', '>', '>>' },
    { 'n', '<', '<<' },
  }

  local default_options = function() return { noremap = true, silent = true } end
  for _, map in pairs(maps) do
    local modes = map[1]
    local key = map[2]
    local options = map[4]
    local opts = default_options()
    for mode in modes:gmatch'.' do
      local action = map[3]
      if options then
        for option_name, option_value in pairs(options) do
          if option_name == 'unmap' and option_value == true then
            option_value = action
            api.nvim_set_keymap(mode, option_value, '', { }) 
          end
          if option_name == 'insert_to_normal' and mode == 'i' then
            if option_value == true then
              action = '<esc>' .. action .. 'a'
            else 
              action = option_value
            end
          end
        end
      end
      api.nvim_set_keymap(mode, key, action, opts)
    end
  end
end

function reload_config()
  for name,_ in pairs(package.loaded) do
    if name:match('^cnull') then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
  --packer.sync()
end

local function load_abbreviations()
  local abbreviations_per_filetype = {
    ['lua'] = {
      { 'iő', 'if ' .. mark_sign .. ' then<cr>' .. mark_sign .. ' <cr>end<esc>' .. goto_mark .. 'i' },
      { 'fő', 'for ' .. mark_sign .. ' in ' .. mark_sign .. ' do<cr>' .. mark_sign .. ' <cr>end<esc>' .. goto_mark .. 'i' },
    }
  }
  api.nvim_create_augroup('abbreviations_pre_filetype', { })
  api.nvim_create_autocmd({ 'FileType' },
  {
    group = 'abbreviations_pre_filetype',
    callback = function()
      abbreviations = abbreviations_per_filetype[vim.bo.filetype]
      if abbreviations then
        for _, abbreviation in pairs(abbreviations) do
          local from = abbreviation[1]
          local to = abbreviation[2]
          api.nvim_set_keymap('i', from, to, { noremap = true })
          --vim.cmd('inoreabbrev ' .. from .. ' ' .. to)
        end
      end
    end,
  })
end

local function load_autocommands()
  local autocommands = {
    {
      'BufWritePost',
      function()
        reload_config()
      end,
      { pattern = os.getenv('MYVIMRC') }
    },
    {
      'BufReadPost',
      function()
        --vim.cmd('g`0')
      end
    },
    {
      'TextYankPost',
      function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 700 })
      end
    },
    {
      'FileType',
      function()
        vim.cmd('set formatoptions-=cro')
      end
    },
  }

  api.nvim_create_augroup('main', { })

  local default_options = function() return { group = 'main' } end
  for _, autocommand in pairs(autocommands) do
    local opts = default_options()
    local event = autocommand[1]
    opts['callback'] = autocommand[2]
    local options = autocommand[3]
    if options then
      for option_name, option_value in pairs(options) do
        opts[option_name] = option_value
      end
    end
    api.nvim_create_autocmd({ event }, opts) 
  end
end

local function load_plugins()
  packer = require('packer')
  packer.startup(function()
    use 'wbthomason/packer.nvim'
    use 'easymotion/vim-easymotion'
    use 'preservim/nerdcommenter'
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use 'ghifarit53/tokyonight-vim'
    --use 'windwp/nvim-autopairs'

    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    use 'rafamadriz/friendly-snippets'

    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'

    --use 'nvim-lua/popup.nvim'
    --use 'nvim-lua/plenary.nvim'
  end)
end

load_options()
load_maps()
load_abbreviations()
load_autocommands()
load_plugins()

--require('user.cmp')


require("nvim-lsp-installer").setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>,', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  test=1
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  --vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<leader>.', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>k', function()
    vim.lsp.buf.hover()
    vim.lsp.buf.signature_help()
  end, bufopts)
  --vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>:', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>-', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
--require('lspconfig').pyright.setup{
  --on_attach = on_attach,
  --flags = lsp_flags,
  --capabilities = capabilities
--}



require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
vim.cmd([[
" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
]])
--require('luasnip').add_snippets('all', {
--s('ternary', {
---- equivalent to '${1:cond} ? ${2:then} : ${3:else}'
--i(1, 'cond'), t(' ? '), i(2, 'then'), t(' : '), i(3, 'else')
--})
--})


vim.cmd(':colorscheme tokyonight')




--vim.cmd([[
--set completeopt=menu,noselect
--]])
--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = '',
  Method = 'm',
  Function = '',
  Constructor = '',
  Field = '',
  Variable = '',
  Class = '',
  Interface = '',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
  Event = '',
  Operator = '',
  TypeParameter = '',
}

local cmp = require'cmp'

local check_backspace = function()
  local col = vim.fn.col '.' - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s'
end

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<a-j>'] = cmp.mapping.select_next_item(),
    ['<a-k>'] = cmp.mapping.select_prev_item(),
    ['<a-h>'] = cmp.mapping.scroll_docs(-4),
    ['<a-l>'] = cmp.mapping.scroll_docs(4),
    ['<c-space>'] = cmp.mapping.complete(),
    ['<a-esc>'] = cmp.mapping.abort(),
    ['<cr>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
    'i',
    's',
  }),
  ['<S-Tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, {
  'i',
  's',
}),
  }),
  formatting = {
    fields = { 'kind', 'abbr' },
    format = function(entry, vim_item)
      vim_item.kind = kind_icons[vim_item.kind]
      return vim_item
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
--local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
--require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--capabilities = capabilities
--}























