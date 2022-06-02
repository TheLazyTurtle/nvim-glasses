local project_list = require("projects.list")
local M = {}

M.display_run_app = function(project)
    if project == nil then
        return project_list.select_project(M.display_run_app)
    end

    local cmd = string.format("vsplit term://dotnet run --project %s", project)
    vim.api.nvim_command(cmd)
end


return M
