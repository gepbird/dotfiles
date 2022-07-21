require('nvim-autopairs').setup {
  disable_filetype = { },
  fast_wrap = {
    map = '<c-e>',
  },
}

require('cmp').event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done {
  map_char = { tex = '' }
})

