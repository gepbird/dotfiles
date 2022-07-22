local ls = require 'luasnip'

ls.config.set_config({
  enable_autosnippets = true,
})

ls.add_snippets('lua', require 'user.snippets.lua', { type = 'autosnippets', })
ls.add_snippets('cs', require 'user.snippets.cs', { type = 'autosnippets', })

require('luasnip.loaders.from_vscode').lazy_load()

