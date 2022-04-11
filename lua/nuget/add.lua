local M = {}

M.add_new_package = function(project)
    local package_name = vim.fn.input('Package name: ', "")
    local version = vim.fn.input('Package version (leave empty for latest): ', "")

    -- If a version is specified format it to be addable to the command
    if string.len(version) > 0 then
        version = string.format("-v %s", version)
    end

    local cmd = string.format("dotnet add %s package %s %s", project, package_name, version)

    -- TODO: should show the full output on a screen
    vim.fn.systemlist(cmd)
    -- print(cmd)
    print("Package has been added")
end

return M
