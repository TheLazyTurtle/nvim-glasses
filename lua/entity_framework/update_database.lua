local project_list = require("projects.list")
local db_context_list = require("scaffolding.list")
local M = {}

M.display_update_database = function(project)
    if project == nil then
        return project_list.select_project(M.display_update_database)
    end

    local context_list = db_context_list.find_db_context(project)
    local opts = { prompt = "Select db context" }

    vim.ui.select(context_list, opts, function(db_context)
        db_context = db_context:gsub("(.*)/", ""):gsub(".cs", "")

        local cmd = string.format("~/.dotnet/tools/dotnet-ef database update -p %s -c %s", project, db_context)

        vim.fn.system(cmd)
        print("Successfully updated database")
    end)
end

return M
