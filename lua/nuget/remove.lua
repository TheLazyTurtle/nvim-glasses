local helpers = require("helpers")
local M = {}

M.remove_package = function(project, package)
    local package_data = helpers.extract_package_name_and_version(package)
    local cmd = string.format("dotnet remove %s package %s", project, package_data.name)
    local results = vim.fn.systemlist(cmd)
    vim.fn.system("dotnet restore")

    return results
end

return M
