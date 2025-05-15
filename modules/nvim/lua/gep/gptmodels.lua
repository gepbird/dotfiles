-- depends on OPENAI_API_KEY environment variable

-- remove ollama not found dependency warning
local function wrap_command(command)
  return function()
    local notify_once = vim.notify_once
    vim.notify_once = function(msg, level, opts)
      if msg == 'GPTModels.nvim is missing optional dependency `ollama`. Local ollama models will be unavailable. ' then
        return
      end
      notify_once(msg, level, opts)
    end
    vim.cmd(command)
    vim.notify_once = notify_once
  end
end

require 'gep.utils'.register_maps {
  { 'nv', '<space>ő', wrap_command ':GPTModelsChat<cr>' },
  { 'nv', '<space>Ő', wrap_command ':GPTModelsCode<cr>' },
}
