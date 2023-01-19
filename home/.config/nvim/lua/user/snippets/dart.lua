local ls = require 'luasnip'
local s = ls.snippet
--local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
--local f = ls.function_node
--local c = ls.choice_node
--local d = ls.dynamic_node
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

return {
  s('iő', {
    t 'if (',
    i(1, 'true'),
    t ') {',
    t { '', '\t' },
    i(2),
    t { '', '}' },
  }),
  s('wő', {
    t 'while (',
    i(1, 'true'),
    t ') {',
    t { '', '\t' },
    i(2),
    t { '', '}' },
  }),
  s('fő', {
    t 'for (',
    i(1, 'var i = 0'),
    t '; ',
    i(2, 'i < collection.length'),
    t '; ',
    i(3, 'i++'),
    t ') {',
    t { '', '\t' },
    i(4),
    t { '', '}' },
  }),
  s('Fő', {
    t 'for (',
    i(1, 'var element'),
    t ' in ',
    i(2, 'collection'),
    t ') {',
    t { '', '\t' },
    i(3),
    t { '', '}' },
  }),
  s('mő', {
    i(1, 'void'),
    t ' ',
    i(2, 'Method'),
    t '(',
    i(3, ''),
    t ') {',
    t { '', '\t' },
    i(4),
    t { '', '}' },
  }),
  s('Mő', {
    t '(',
    i(1),
    t ') => ',
    i(2),
  }),
  s('rő', {
    t 'return',
  }),
  s('bő', {
    t '{',
    t { '', '\t' },
    i(1),
    t { '', '}' },
  }),
  s('pő', {
    t 'debugPrint(',
    i(1),
    t ');',
  }),
}
