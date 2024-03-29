local ls = require 'luasnip'

ls.config.set_config {
  enable_autosnippets = true,
}

local languages = {
  'lua',
  'cs',
  'dart',
  'java',
  'tex',
}
for _, language in ipairs(languages) do
  ls.add_snippets(language, require('gep.snippets.' .. language), { type = 'autosnippets' })
end

require 'luasnip.loaders.from_vscode'.lazy_load()
