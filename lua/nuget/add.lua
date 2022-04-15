local projects_list = require("projects.list")
local M = {}

M.display_add_package = function(project, package_name, package_version)
    if project == nil then
        return projects_list.select_project(M.display_add_package)
    end

    if package_name == nil then
        local opts = { prompt = "Package name" }
        vim.ui.input(opts, function(name)
            M.display_add_package(project, name)
        end)
    end

    if package_version == nil then
        local opts = { prompt = "Package version" }
        vim.ui.input(opts, function(version)
            M.add_new_package(project, package_name, version)
        end)
    end
end

M.add_new_package = function(project, package_name, version)
    -- If a version is specified format it to be addable to the command
    if string.len(version) > 0 then
        version = string.format("-v %s", version)
    end

    local cmd = string.format("dotnet add %s package %s %s", project, package_name, version)

    -- TODO: should show the full output on a screen
    vim.fn.systemlist(cmd)
    print("Package has been added")
end

return M
