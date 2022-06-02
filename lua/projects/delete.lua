local projects_list = require("projects.list")
local helpers       = require("helpers")

local M = {}

M.display_delete_project = function()
    projects_list.select_project(M.delete_project)
end

M.delete_project = function(project)
    local project_dir = string.gsub(project, "/(.*)", "")
    local remove_project_cmd = string.format("dotnet sln remove %s", project)
    local delete_files_cmd = string.format("rm -rf %s", project_dir)

    vim.fn.system(remove_project_cmd)
    vim.fn.system(delete_files_cmd)

    helpers.refresh_file_tree()

    print("Removed project")
end

return M
