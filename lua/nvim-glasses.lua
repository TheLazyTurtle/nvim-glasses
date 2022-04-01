local window = require("window")
local helpers = require("helpers")
local callbacks = require("callbacks")
local fn = vim.fn

local M = {}
M.solution = helpers.get_solution_path()

M.setup = function()
	print(M.solution)
end

-- List all the available commands
M.list_options = function()
	-- This should also allow you to have an input the select the option you want
	local options = {
		"list_project",
		"add_project",
		"remove_project",
		"list_project_reference",
	}

	window.window("run_command", options)
end

-- This will list all the project files/folders in your current solution
M.list_projects = function()
	-- Find a way to show all disconnected projects and ask to add those
	local results = helpers.find_linked_projects()
	window.window(callbacks.open_file(window.win), results)
end

-- This gives you the option to add a project to their solution
-- Keep in mind this does NOT make a project. This will only link to the solution
M.add_project = function()
	vim.fn.system("dotnet new console --output TestConsole")
	window.window('', "dotnet sln add TestConsole")
end

-- This will acctuallt make a new project
-- This will also directly link the project to the solution
-- Give a user the option to select different types of project (ex. class library, NUnit test project)
M.create_project = function()
	-- Then we make the project
	-- Then we link the project
	local templates = helpers.list_project_templates()
	window.window('create_project', templates)
end

-- This gives the user the option to remove a project from their solution
-- Gives the user a selection screen with all their projects which they can select to remove
M.remove_project = function()
	window.window("delete_project", "dotnet sln <SLN> list")
end

-- Show all the references a project has
-- Give a project selection screen where a user can select the project they want to view the references of
M.list_project_reference = function()
	local cmd = string.format("dotnet sln %s list", M.solution)
	local results = fn.systemlist(cmd)
	window.window("list_project_reference", results)
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
