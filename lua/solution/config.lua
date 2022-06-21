local helpers = require("helpers")
local M = {}

-- TODO: Check if this will place it in the root of the solution
local make_global_config_file = function()
    local dotnet_version = helpers.get_dotnet_version()
    local cmd = string.format('\'{\n\t"sdk": {\n\t\t"version": "%s"\n\t}\n}\'', dotnet_version)
    local formated_cmd = string.format("printf %s >> global.json", cmd)

    vim.fn.system(formated_cmd)
    helpers.refresh_file_tree()
    helpers.open_file("global.json");
end

M.display_make_global_config = function()
    if vim.fn.filereadable("global.json") == 1 then
        helpers.open_file("global.json");
    else
        local opts = { prompt = "Do you want to make a global config file?" }
        local items = { "yes", "no" }
        vim.ui.select(items, opts, function(result)
            if result == "yes" then
                return make_global_config_file()
            end
        end)
    end
end

return M
