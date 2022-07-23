vim.cmd 'colorscheme darkplus'

local C = require 'darkplus.palette'

require 'darkplus.util'.initialise {
  Whitespace = { fg = C.dark_gray },
  NonText = { fg = C.dark_gray },
}
