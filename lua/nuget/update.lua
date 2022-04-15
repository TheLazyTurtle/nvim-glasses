local project_list = require("projects.list")
local package_list = require("nuget.list")
local helpers = require("helpers")
local M = {}

M.display_update_package = function(project)
    if project == nil then
        return project_list.select_project(M.display_update_package)
    end

    local opts = { prompt = "Select package" }
    vim.ui.select(package_list.list_installed_packages(project), opts, function(package)
        M.update_package(project, package)
    end)
end

M.update_package = function(project, package)
    local package_data = helpers.extract_package_name_and_version(package)
    local version = package_data.version

    local opts = { prompt = "Give version (leave empty for latest)" }
    vim.ui.input(opts, function(value)
        local new_version = value

        if new_version ~= nil then
            version = new_version
        end

        local cmd = string.format("dotnet add %s package %s -v %s", project, package_data.name, version)
        local result = vim.fn.systemlist(cmd);
        print("Updated")
    end)


end

return M
