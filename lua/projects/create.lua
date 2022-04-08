local helpers = require("helpers")
-- local window = require("utils.window")
local fn = vim.fn

local M = {}

M.create_project_callback = function(project_template)
    -- Parse project to extract the short name out of it
    local project_short_name = helpers.extract_project_short_name(project_template)

    local project_name = fn.input("Project name: ", "")
    M.create_project(project_short_name, project_name)
end

-- This will create the project
M.create_project = function(project_template, name)
    local cmd = string.format("dotnet new %s --name %s", project_template, name)
    local result = fn.system(cmd)

    if string.find(result, "Restore succeeded.") then
        helpers.add_project_to_solution(name)
    end
end

-- This will return a list of all available project templates
M.list_project_templates = function()
    return fn.systemlist("dotnet new --list")
end
return M

