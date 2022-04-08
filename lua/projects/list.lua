local helpers = require('helpers')
local M = {}

-- This will get all the projects linked to a project
local find_linked_projects = function()
    local solution = helpers.get_solution_path()
    return vim.fn.systemlist(string.format("dotnet sln %s list", solution))
end

-- This will list all the project files/folders in your current solution
M.list_projects = function()
    -- Find a way to show all disconnected projects and ask to add those
    return find_linked_projects()
end

return M
