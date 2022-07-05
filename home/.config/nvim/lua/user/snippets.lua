
local ls = require('luasnip')
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require('luasnip.extras').lambda
local rep = require('luasnip.extras').rep
local p = require('luasnip.extras').partial
local m = require('luasnip.extras').match
local n = require('luasnip.extras').nonempty
local dl = require('luasnip.extras').dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local types = require('luasnip.util.types')
local conds = require('luasnip.extras.expand_conditions')
local newline = { '', '' }

ls.config.set_config({
  enable_autosnippets = true,
})

ls.add_snippets('lua', {
  s('iő', {
    t('if '),
    i(1, 'true'),
    t(' then'),
    t(newline),
    t({ '\t' }),
    i(2),
    t(newline),
    t('end')
  }),
  s('wő', {
    t('while '),
    i(1, 'true'),
    t(' do'),
    t(newline),
    t('\t'),
    i(2),
    t(newline),
    t('end')
  }),
  s('fő', {
    t('for '),
    i(1, 'value'),
    t(' in '),
    i(2, 'iterator'),
    t(' do'),
    t(newline),
    t('\t'),
    i(3),
    t(newline),
    t('end')
  }),
  s('Fő', {
    t('for '),
    i(1, 'key'),
    t(', '),
    i(2, 'value'),
    t(' in '),
    i(3, 'iterator'),
    t(' do'),
    t(newline),
    t('\t'),
    i(4),
    t(newline),
    t('end')
  }),
  s('mő', {
    t('function '),
    i(1, 'f'),
    t('('),
    i(2),
    t(')'),
    t(newline),
    t('\t'),
    i(3),
    t(newline),
    t('end')
  }),
  s('Mő', {
    t('function'),
    t('('),
    i(1),
    t(') '),
    i(2),
    t(' end')
  }),
  s('rő', {
    t('return '),
  }),
  s('bő', {
    t('{'),
    t(newline),
    t('\t'),
    i(1),
    t(newline),
    t('}'),
  }),
}, { type = 'autosnippets', })
