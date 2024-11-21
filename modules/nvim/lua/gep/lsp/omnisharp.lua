local omnisharp = require 'omnisharp_extended'
require 'gep.utils'.register_maps {
  { 'n', '<space>.', omnisharp.telescope_lsp_definition, filetype = 'cs' },
}

-- see ~/.omnisharp/omnisharp.json
return {
  cmd = { 'OmniSharp' },
  analyze_open_documents_only = true,
  enable_editorconfig_support = true,
  enable_import_completion = true,
  enable_ms_build_load_projects_on_demand = true,
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
}
