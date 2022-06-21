local projects_list = require("projects.list")
local helpers       = require("helpers")
local M             = {}

-- Show all project references in project
M.display_list_project_references = function(project)
    if project == nil then
        return projects_list.select_project(M.display_list_project_references)
    end

    local opts = { prompt = "Select project:" }
    local list = M.list_project_references(project)
    vim.ui.select(list, opts, function() end)
end

M.display_add_project_reference = function(base_project)
    if base_project == nil then
        return projects_list.select_project(M.display_add_project_reference)
    end

    local opts = { prompt = "Select project to add:" }
    vim.ui.select(projects_list.list_projects(), opts,
        function(project_to_add)
            M.add_project_reference(base_project, project_to_add)
        end
    )
end

M.display_remove_project_reference = function(base_project)
    if base_project == nil then
        return projects_list.select_project(M.display_remove_project_reference)
    end

    local opts = { prompt = "Select project to remove:" }
    vim.ui.select(M.list_project_references(base_project), opts,
        function(project_to_add)
            M.remove_project_reference(base_project, project_to_add)
        end
    )
end

-- Return list of all project references
M.list_project_references = function(project)
    local cmd = string.format("dotnet list %s reference", project)
    local results = vim.fn.systemlist(cmd)

    return results
end

-- Add a new reference to a project
M.add_project_reference = function(base_project, project_to_add)
    local cmd = string.format("dotnet add %s reference %s", base_project, project_to_add)
    local results = vim.fn.systemlist(cmd)
    print(vim.inspect(results))
    print(string.format("Added %s to %s", project_to_add, base_project))

    helpers.restart_lang_server()
    return results
end

-- Remove a refernece to a project
M.remove_project_reference = function(base_project, project_to_remove)
    project_to_remove = string.gsub(project_to_remove, "\\", "/")
    local cmd = string.format("dotnet remove %s reference %s", base_project, project_to_remove)
    local result = vim.fn.systemlist(cmd)

    print(string.format("Removed %s from %s", project_to_remove, base_project))
    helpers.restart_lang_server()
    return result
end

return M
