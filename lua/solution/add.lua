local projects_list = require("projects.list")
local M = {}

M.display_add_project = function()
    projects_list.select_project(M.add_project_to_solution)
end

-- This will add a project to a solution
M.add_project_to_solution = function(project_name)
    local cmd = string.format("dotnet sln add %s", project_name)
    vim.fn.system(cmd)
end

return M
