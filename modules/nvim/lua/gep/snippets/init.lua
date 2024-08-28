local luasnip = require 'luasnip'

luasnip.config.set_config {
  enable_autosnippets = true,
}

luasnip.add_snippets('tex', require 'gep.snippets.tex', { type = 'autosnippets' })
