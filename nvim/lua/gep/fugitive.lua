require 'gep.utils'.register_maps {
  { 'n',  '<space>g<s-d>', ':G diff<cr>' },
  { 'n',  '<space>g<c-d>', ':G diff --staged<cr>' },
  { 'nx', '<space>go',     ':GBrowse<cr>' },
  { 'n',  '<space>gi',     ':G<cr>' },
  { 'n',  '<space>gl',     ':G log<cr>' },
  { 'nx', '<s-j>',         ')',                   { remap = true, filetype = 'fugitive' } },
  { 'nx', '<s-k>',         '(',                   { remap = true, filetype = 'fugitive' } },
  { 'n',  '<space>gc',     ':G commit -S<cr>' },
}
