local window = require("utils.window")
local api = vim.api
local fn = vim.fn
local M = {}

-- This is the action that will run on the specified key press
function M.open_file(win)
    local str = api.nvim_get_current_line()
    api.nvim_win_close(win, true)
    api.nvim_command('edit '..str)
end

-- List all project references of the selected project
function M.list_project_reference(win)
    local project = api.nvim_get_current_line()
    api.nvim_win_close(win, true)

    -- Get references of a project
    local cmd = string.format("dotnet list %s reference", project)
    local results = fn.systemlist(cmd)
    window('open_file', results)
end

-- Delete a project from the solution
function M.delete_project(win)
    local str = api.nvim_get_current_line()
    api.nvim_win_close(win, true)

    -- Remove project from solution
    fn.system("dotnet sln remove ".. str)

    -- Delete actual files
    local folder = string.match(str, "/.*$")
    folder = folder:gsub(".csproj", ""):gsub("/", "")
    os.execute("rm -rf ".. folder)
end

-- This runs any of the commands selected from the menu
function M.run_command(win)
    local command = api.nvim_get_current_line()
    api.nvim_win_close(win, true)
end
return M
