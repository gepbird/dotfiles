require 'bqf'.setup {
  auto_enable = true,
  magic_window = true,
  auto_resize_height = true,
  preview = {
    auto_preview = true,
    delay_syntax = 50,
    win_height = 20,
    wrap = false,
  },
  func_map = {
    open = 'l',
    prevhist = '<left>',
    nexthist = '<right>',
    ptoggleauto = 'p',
    filter = 'q',
    filterr = '<s-q>',
    fzffilter = 'f',
  },
}

require 'gep.utils'.register_maps {
  { 'n', '<space>c', function()
    for _, win in pairs(vim.fn.getwininfo()) do
      if win.quickfix == 1 then
        vim.cmd ':cclose'
        return
      end
    end
    vim.cmd ':copen'
  end },
}
