-- disable chaning tabstop by ftplugin
vim.cmd 'let g:rust_recommended_style = 0'
vim.cmd 'let g:python_recommended_style = 0'

local o = vim.opt
local g = vim.g

o.backup = false -- creates a backup file
o.clipboard = 'unnamedplus' -- allows neovim to access the system clipboard
o.cmdheight = 1 -- more space in the neovim command line for displaying messages
o.completeopt = { 'menuone', 'noselect' } -- mostly just for cmp
o.conceallevel = 0 -- so that `` is visible in markdown files
o.fileencoding = 'utf-8' -- the encoding written to a file
o.hlsearch = true -- highlight all matches on previous search pattern
o.ignorecase = true -- ignore case in search patterns
o.mouse = 'a' -- allow the mouse to be used in neovim
o.pumheight = 10 -- pop up menu height
o.showmode = false -- we don't need to see things like -- INSERT -- anymore
o.showtabline = 2 -- always show tabs
o.smartcase = true -- smart case
o.smartindent = true -- make indenting smarter again
o.splitbelow = true -- force all horizontal splits to go below current window
o.splitright = true -- force all vertical splits to go to the right of current window
o.swapfile = false -- creates a swapfile
o.termguicolors = true -- set term gui colors (most terminals support this)
o.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
o.undofile = true -- enable persistent undo
o.updatetime = 300 -- faster completion (4000ms default)
o.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
o.expandtab = true -- convert tabs to spaces
o.shiftwidth = 2 -- the number of spaces inserted for each indentation
o.tabstop = 2 -- insert 2 spaces for a tab
o.cursorline = false -- highlight the current line
o.number = true -- set numbered lines
o.relativenumber = false -- set relative numbered lines
o.numberwidth = 4 -- set number column width to 2 {default 4}
o.signcolumn = 'yes' -- always show the sign column, otherwise it would shift the text each time
o.wrap = false -- display lines as one long line
o.scrolloff = 8 -- always see the last x lines
o.sidescrolloff = 8
--o.guifont = 'monospace:h17'               -- the font used in graphical neovim applications
o.shortmess:append 'c' -- turn off common vim messages
o.listchars = 'space:·,tab:  󰌒,eol:󰌑' -- define whitespace rendering
o.list = true -- show whitespace
--o.whichwrap:append '<,>,[,],h,l'          -- can move to next line when pressing these keys
o.iskeyword:append '-' -- what characters count as a word movement
g.markdown_recommended_style = 0
o.spelllang = 'hu'

-- disable bad indent for comments by disabling smartindent and re-enabling most of its features
o.smartindent = false
o.cindent = true
o.cinkeys:remove '0#'
o.indentkeys:remove '0#'
