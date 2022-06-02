local project_list = require('projects.list')
local M = {}

M.display_list_test = function()
    local cmd = 'vsplit term://dotnet test -t'
    vim.api.nvim_command(cmd)
end

M.display_run_all_test = function()
    local cmd = 'vsplit term://dotnet test'
    vim.api.nvim_command(cmd)
end

M.display_run_test = function(project)
    if project == nil then
        return project_list.select_project(M.display_run_test)
    end

    local cmd = string.format('vsplit term://dotnet test %s', project)
    vim.api.nvim_command(cmd)
end

return M
