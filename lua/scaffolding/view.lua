local project_list = require("projects.list")
local db_context_list = require("scaffolding.list")
local M = {}

local create_view = function(project, model, name, template)
    local opts = { prompt = "Choose db context" }

    vim.ui.select(db_context_list.find_db_context(project), opts, function(db_context)
        local model_name = model:gsub("(.*)/", ""):gsub(".cs", "")
        db_context = db_context:gsub("(.*)/", ""):gsub(".cs", "")

        local cmd = string.format("~/.dotnet/tools/dotnet-aspnet-codegenerator view -p %s %s %s -m %s -dc %s -outDir Views/%ss", project, name, template, model_name, db_context, model_name)
        local res = vim.fn.systemlist(cmd)
        print(vim.inspect(res))
    end)
end

local get_page_name = function(project, model, template)
    local opts = { prompt = "Page name:", default = template }

    vim.ui.input(opts, function(name)
        create_view(project, model, name, template)
    end)
end

local get_template_type = function(project, model)
    local templates = { "Empty", "Create", "Edit", "Delete", "Details", "List" }
    local opts = { prompt = "Select template:" }

    vim.ui.select(templates, opts, function(template)
        get_page_name(project, model, template)
    end)
end

M.display_scaffold_view = function(project)
    if project == nil then
        return project_list.select_project(M.display_scaffold_view)
    end

    local models = project_list.list_models(project)
    local opts = { prompt = "Select model:" }
    vim.ui.select(models, opts, function(model)
        get_template_type(project, model)
    end)
end

return M
