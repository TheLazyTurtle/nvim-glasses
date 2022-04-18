local project_list = require("projects.list")
local db_context_list = require("scaffolding.list")
local M = {}

local export_db = function(project, output_dir, db_context)
    local cmd = string.format("~/.dotnet/tools/dotnet-ef migration script -p %s -c %s -o %s -i", project, db_context, output_dir)
    vim.fn.system(cmd)

    print(string.format("Successfully exported database to %s", output_dir))
end

local select_db_context = function(project, output_dir)
    local context_list = db_context_list.find_db_context(project)
    local opts = { prompt = "Select context:" }

    vim.ui.select(context_list, opts, function(db_context)
        db_context = db_context:gsub("(.*)/", ""):gsub(".cs", "")
        export_db(project, output_dir, db_context)
    end)
end

M.display_export_database = function(project)
    if project == nil then
        return project_list.select_project(M.display_export_database)
    end

    local project_dir = project:gsub("/(.*)", "") .. "/export.sql"
    local opts = { prompt = "Give output dir (relative to project file):", default = project_dir }
    vim.ui.input(opts, function(dir)
        select_db_context(project, dir)
    end)
end

return M
