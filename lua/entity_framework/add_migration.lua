local project_list = require("projects.list")
local db_context_list = require("scaffolding.list")
local M = {}

local add_migration = function(project, name, db_context)
    local cmd = string.format("~/.dotnet/tools/dotnet-ef migrations add %s -p %s -c %s", name, project, db_context)
    vim.fn.systemlist(cmd)

    print("Successfully created migration")
end

local select_db_context = function(project, name)
    local context_list = db_context_list.find_db_context(project)
    local opts = { prompt = "Select db context" }

    vim.ui.select(context_list, opts, function(db_context)
        db_context = db_context:gsub("(.*)/", ""):gsub(".cs", "")
        add_migration(project, name, db_context)
    end)
end

M.display_add_migration = function(project)
    if project == nil then
        return project_list.select_project(M.display_add_migration)
    end

    local opts = {
        prompt = "Migration name:"
    }

    vim.ui.input(opts, function(name)
        select_db_context(project, name)
    end)
end

return M
