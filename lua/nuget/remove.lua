local project_list = require("projects.list")
local package_list = require("nuget.list")
local helpers = require("helpers")
local M = {}

M.display_remove_package = function(project)
    if project == nil then
        return project_list.select_project(M.display_remove_package)
    end

    local opts = { prompt = "Select package" }
    vim.ui.select(package_list.list_installed_packages(project), opts, function(package)
        if package == nil then
            return
        end

        M.remove_package(project, package)
    end)
end

M.remove_package = function(project, package)
    local package_data = helpers.extract_package_name_and_version(package)
    local cmd = string.format("dotnet remove %s package %s", project, package_data.name)
    local results = vim.fn.systemlist(cmd)
    vim.fn.system("dotnet restore")

    return results
end

return M
