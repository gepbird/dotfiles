local cmp = require 'cmp'
local luasnip = require 'luasnip'

vim.cmd [[
  set completeopt=menu,noselect
]]

local kind_icons = {
  Text = '',
  Method = '',
  Function = '',
  Constructor = '',
  Field = '',
  Variable = '',
  Class = '',
  Interface = '',
  Module = '',
  Property = '',
  Unit = '󰑭',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
  Event = '',
  Operator = '',
  TypeParameter = '',
  Copilot = '',
}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<c-j>'] = cmp.mapping.select_next_item(),
    ['<c-k>'] = cmp.mapping.select_prev_item(),
    ['<a-k>'] = cmp.mapping.scroll_docs(4),
    ['<a-j>'] = cmp.mapping.scroll_docs(-4),
    ['<c-space>'] = cmp.mapping.complete(),
    ['<a-esc>'] = cmp.mapping.abort(),
    ['<c-l>'] = cmp.mapping.confirm { select = true },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
    ['<S-Tab>'] = cmp.mapping(function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, {
      'i',
      's',
    }),
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      vim_item.kind = kind_icons[vim_item.kind]
      vim_item.menu = '[' .. entry.source.name .. ']'
      return vim_item
    end,
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
}

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
    { { name = 'path' } },
    { { name = 'cmdline' } }
  ),
})

-- set up cmp sources for current buffer
local default_cmp_sources = cmp.config.sources {
  { name = 'nvim_lsp' },
  { name = 'nvim_lua' },
  { name = 'luasnip' },
  { name = 'path' },
  { name = 'copilot' },
}
require 'gep.utils'.register_autocmd {
  'BufReadPre',
  function(t)
    if not require 'gep.utils'.is_file_big(t.buf) then
      local sources = {}
      for k, v in pairs(default_cmp_sources) do
        sources[k] = v
      end
      -- add buffer source for small files
      sources[#sources + 1] = { name = 'buffer', group_index = 4 }
      cmp.setup.buffer {
        sources = sources,
      }
    else
      -- only use default sources for big files
      cmp.setup.buffer {
        sources = default_cmp_sources,
      }
    end
  end,
}
