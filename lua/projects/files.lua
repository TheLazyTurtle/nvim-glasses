local M = {}

M.display_create_file = function()
    local opts = { prompt = 'File name:' }

    vim.ui.input(opts, function(file_name)
    end)
end

return M
