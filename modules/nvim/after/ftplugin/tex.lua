local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
--local f = ls.function_node
--local c = ls.choice_node
local d = ls.dynamic_node
--local r = ls.restore_node
--local l = require('luasnip.extras').lambda
--local rep = require('luasnip.extras').rep
--local p = require('luasnip.extras').partial
--local m = require('luasnip.extras').match
--local n = require('luasnip.extras').nonempty
--local dl = require('luasnip.extras').dynamic_lambda
--local fmt = require('luasnip.extras.fmt').fmt
--local fmta = require('luasnip.extras.fmt').fmta
--local types = require('luasnip.util.types')
--local conds = require('luasnip.extras.expand_conditions')

-- reference node
local ref = function(jump_index, node_reference)
  return d(
    jump_index,
    function(args)
      return sn(nil, { t(args[1]) })
    end,
    node_reference
  )
end

return {
  s('\\begin', {
    t '\\begin{', i(1), t '}',
    t { '', '\\end{' }, ref(2, 1), t '}',
  }),
}
