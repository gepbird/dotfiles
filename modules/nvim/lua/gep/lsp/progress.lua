require 'lsp-progress'.setup {
  client_format = function(client_name, _, series_messages)
    return #series_messages > 0
      and ("[" .. client_name .. "] " .. table.concat(series_messages, ", "))
      or nil
  end,
  format = function(client_messages)
    return #client_messages > 0
      and table.concat(client_messages, " ")
      or ""
  end
}
