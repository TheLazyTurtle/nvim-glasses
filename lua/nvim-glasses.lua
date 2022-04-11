local window = require("utils.window")
local helpers = require("helpers")
local callbacks = require("callbacks")
local fn = vim.fn

local M = {}
M.solution = helpers.get_solution_path()

M.setup = function()
    print(M.solution)
end

-- This gives the user the option to remove a project from their solution
-- Gives the user a selection screen with all their projects which they can select to remove
M.remove_project = function()
    window.window("delete_project", "dotnet sln <SLN> list")
end


-- Allow a user to add a project reference
-- The user gets a screen with all their projects and when they select a project they get a screen that shows all the projects they can add
-- They should be able to add multiple projects add the same time
M.add_project_reference = function()
    print("New project reference")
end

-- Allow the user to remove a project reference
-- The user gets a screen with all their projects and when they select a project they get a screen that shows all the projects they can remove
-- They should be able to remove multiple projects add the same time
M.remove_project_reference = function()
    print("Removed project reference")
end

-- Gives a user the option to add template files (ex: class file, interface)
M.add_file = function()
    print("file added")
end

-- Gives the user a screen where they can select packages to install
-- It would be nice if it would show a list of all plugins based on the name you type
M.install_package = function()
    print("package added")
end

-- Gives the user a screen where they can select a package they want to remove
M.remove_package = function()
    print("package removed")
end

-- Just give the user a screen with all their installed packages
M.list_installed_packages = function()
    print("packages")
end

return M
