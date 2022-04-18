local scandir = require("plenary.scandir")
local helpers = require('helpers')
local M = {}

-- This will get all the projects linked to a project
local find_linked_projects = function()
    local solution = helpers.get_solution_path()
    return vim.fn.systemlist(string.format("dotnet sln %s list", solution))
end

-- This will list all the project files/folders in your current solution
M.list_projects = function()
    local projects = find_linked_projects()

    table.remove(projects, 1)
    table.remove(projects, 1)
    return projects
end

-- Display all projects in solution
M.display_project_list = function()
    M.select_project(helpers.open_file)
end

M.select_project = function(callback)
    local projects = M.list_projects()
    local opts = { prompt = "Select a project:" }

    return vim.ui.select(projects, opts, callback)
end

-- This should find all the projects that are not connected to the solution
M.find_all_disconnected_projects = function()
    local data = scandir.scan_dir('.', {depth = 2})
    local projects = {}
    local linked_projects = find_linked_projects()

    for _, value in pairs(data) do
        if string.find(value, ".csproj") then
            -- value = string.gsub(value, "./", "")
            value = string.sub(value, 3)
            table.insert(projects, value)
        end
    end

    return helpers.get_difference_between_tables(projects, linked_projects)
end

-- Find all the models
M.list_models = function(project)
    local project_dir = helpers.get_project_dir(project)
    -- TODO: Maybe make a thing where it will only look in folders that meets conventions to prevent getting files that can't be scaffolded anyway
    local data = scandir.scan_dir(project_dir, {respect_gitignore = true, depth = 5})
    local models = {}

    for _, value in pairs(data) do
        -- Exclude bs folders
        if string.match(value, "/obj/") == nil then
            if value:sub(-#".cs") == ".cs" then
                table.insert(models, value)
            end
        end
    end

    return models
end

return M
