local helpers = require("helpers")
local window = require("utils.window")
local api = vim.api
local fn = vim.fn

local M = {}

-- This will acctuallt make a new project
-- This will also directly link the project to the solution
-- Give a user the option to select different types of project (ex. class library, NUnit test project)
M.create_project = function()
  -- Show templates
	local templates = helpers.list_project_templates()
	window.window("projects.create", "create_project_callback", templates)
end

M.create_project_callback = function()
	local project_template = api.nvim_get_current_line()
	api.nvim_win_close(window.win, true)

	-- Parse project to extract the short name out of it
	local project_short_name = helpers.extract_project_short_name(project_template)

	local project_name = fn.input("Project name: ", "")
	helpers.create_project(project_short_name, project_name)
end

return M

