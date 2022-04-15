local project_list = require("projects.list")
local M = {}

M.display_installed_packages = function(project)
    if project == nil then
        return project_list.select_project(M.display_installed_packages)
    end

    local opts = { prompt = "Installed packages" }

    vim.ui.select(M.list_installed_packages(project), opts, function() end)
end

M.list_installed_packages = function(project)
    local cmd = string.format("dotnet list %s package", project)
    return vim.fn.systemlist(cmd)
end

return M
