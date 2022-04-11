local M = {}

M.delete_project = function(project)
    local project_dir = string.gsub(project, "/(.*)", "")
    local remove_project_cmd = string.format("dotnet sln remove %s", project)
    local delete_files_cmd = string.format("rm -rf %s", project_dir)

    vim.fn.system(remove_project_cmd)
    vim.fn.system(delete_files_cmd)

    print("Removed project")
end

return M
