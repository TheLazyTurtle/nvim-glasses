local helpers = require("helpers")
local solution = require("solution.add")

local M = {}

M.display_create_project = function()
    local opts = { prompt = "Select a template" }
    return vim.ui.select(M.list_project_templates(), opts, M.create_project_callback)
end

M.create_project_callback = function(project_template)
    -- Parse project to extract the short name out of it
    local project_short_name = helpers.extract_project_short_name(project_template)

    local opts = { prompt = "Project name" }
    vim.ui.input(opts, function(project_name)
        M.create_project(project_short_name, project_name)
    end)
end

-- This will create the project
M.create_project = function(project_template, name)
    local cmd = string.format("dotnet new %s --name %s", project_template, name)
    local result = vim.fn.system(cmd)

    if string.find(result, "Restore succeeded.") then
        solution.add_project_to_solution(name)
    end
end

-- This will return a list of all available project templates
M.list_project_templates = function()
    return vim.fn.systemlist("dotnet new --list")
end
return M

