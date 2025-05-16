local omnisharp = require 'omnisharp_extended'
local ivy = require 'telescope.themes'.get_ivy()
require 'gep.utils'.register_maps {
  { 'n', '<space>-', function() omnisharp.telescope_lsp_references(ivy) end, filetype = 'cs' },
  { 'n', '<space>.', function() omnisharp.telescope_lsp_definition(ivy) end, filetype = 'cs' },
  { 'n', '<space>:', function() omnisharp.telescope_lsp_type_definition(ivy) end, filetype = 'cs' },
}

-- see ~/.omnisharp/omnisharp.json
return {
  analyze_open_documents_only = true,
  enable_editorconfig_support = true,
  enable_import_completion = true,
  enable_ms_build_load_projects_on_demand = true,
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
}
