local M = {}

M.list_installed_packages = function(project)
    local cmd = string.format("dotnet list %s package", project)
    return vim.fn.systemlist(cmd)
end

return M
