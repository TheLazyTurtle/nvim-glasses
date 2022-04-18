local project_list = require("projects.list")
local db_context_list = require("scaffolding.list")
local M = {}

local create_razorpage = function(project, model, name, template)
    local opts = { prompt = "Select db_context" }

    vim.ui.select(db_context_list.find_db_context(project), opts, function(db_context)
        local model_name = model:gsub("(.*)/", ""):gsub(".cs", "")
        db_context = db_context:gsub("(.*)/", ""):gsub(".cs", "")
        if name == nil then
            local cmd = string.format("~/.dotnet/tools/dotnet-aspnet-codegenerator razorpage -p %s -m %s -dc %s -outDir Pages/%ss", project, model_name, db_context, model_name)
            local results = vim.fn.systemlist(cmd)
            print(vim.inspect(results))
        else
            local cmd = string.format("~/.dotnet/tools/dotnet-aspnet-codegenerator razorpage -p %s %s %s -m %s -dc %s -outDir Pages/%ss", project, name, template, model_name, db_context, model_name)
            local results = vim.fn.systemlist(cmd)
            print(vim.inspect(results))
        end
    end)
end

local get_page_name = function(project, model, template)
    local opts = { prompt = "Page name:", default = template}
    vim.ui.input(opts, function(name)
        create_razorpage(project, model, name, template)
    end)
end

local get_template_type = function(project, model)
    local templates = { "Empty", "Create", "Edit", "Delete", "Details", "List" }
    local opts = { prompt = "Select template:" }

    vim.ui.select(templates, opts, function(template)
        get_page_name(project, model, template)
    end)
end

local one_or_all = function(project, model)
    local types = { "Specific template", "Generate all templates" }
    local opts = { prompt = "Select templating options:" }

    vim.ui.select(types, opts, function(template)
        if template == "Specific template" then
            get_template_type(project, model)
        else
            create_razorpage(project, model)
        end
    end)
end

M.display_scaffold_razorpage = function(project)
    if project == nil then
        return project_list.select_project(M.display_scaffold_razorpage)
    end

    local models = project_list.list_models(project)
    local opts = { prompt = "Select model:" }
    vim.ui.select(models, opts, function(model)
        one_or_all(project, model)
    end)
end

return M
