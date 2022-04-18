local project_list = require("projects.list")
local M = {}

local create_area = function(project, area_name)
    local cmd = string.format("~/.dotnet/tools/dotnet-aspnet-codegenerator area -p %s %s", project, area_name)
    vim.fn.system(cmd);

    print("Successfully generated new area. Please read ScaffoldingReadMe.txt in the root of your project.")
end

M.display_scaffold_area = function(project)
    if project == nil then
        return project_list.select_project(M.display_scaffold_area)
    end

    local opts = { prompt = "Give area a name:" }

    vim.ui.input(opts, function(area_name)
        create_area(project, area_name)
    end)
end

return M
