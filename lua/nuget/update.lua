local helpers = require("helpers")
local M = {}

M.update_package = function(project, package)
    local package_data = helpers.extract_package_name_and_version(package)
    local version= package_data.version

    local new_version = vim.fn.input("New version (leave empty for latest): ", "")
    if string.len(new_version) > 0 then
        version = new_version
    end

    local cmd = string.format("dotnet add %s package %s -v %s", project, package_data.name, version)
    local result = vim.fn.systemlist(cmd);
    print(result)
end

return M
