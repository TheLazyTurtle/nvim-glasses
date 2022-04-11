local M = {}

-- Give a project selection screen where a user can select the project they want to view the references of
-- Show all the references a project has
M.list_project_references = function(project)
    local cmd = string.format("dotnet list %s reference", project)
    local results = vim.fn.systemlist(cmd)

    return results
end

M.add_project_reference = function(base_project, project_to_add)
    local cmd = string.format("dotnet add %s reference %s", base_project, project_to_add)
    local results = vim.fn.systemlist(cmd)
    print(string.format("Added %s to %s", project_to_add, base_project))

    return results
end

M.remove_project_reference = function(base_project, project_to_remove)
    project_to_remove = string.gsub(project_to_remove, "\\", "/")
    local cmd = string.format("dotnet remove %s reference %s", base_project, project_to_remove)
    local result = vim.fn.systemlist(cmd)

    print(string.format("Removed %s from %s", project_to_remove, base_project))

    return result
end

return M
