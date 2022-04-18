local package_list = require("nuget.list")
local package_installer = require("nuget.add")
local project_list = require("projects.list")
local helpers = require("helpers")
local M = {}

local required_packages = {
    "Microsoft.Visualstudio.Web.Codegeneration.Design",
    "Microsoft.EntityFrameworkCore.SqlServer",
    "Microsoft.EntityFrameworkCore.Tools",
}

local has_uninstalled_packages = function(project)
    local installed_packages = package_list.list_installed_packages(project)
    return helpers.get_difference_between_tables(required_packages, installed_packages)
end

local scaffold_controller = function(project, model, name, db_context)
    local opts = { prompt = "Select custom layout file (leave empty for default): " }

    vim.ui.input(opts, function(layout)
        if layout == "" or layout == nil then
            layout = "-udl"
        else
            layout = string.format("-l %s", layout)
        end

        local uninstalled_packages = has_uninstalled_packages(project)
        if helpers.get_table_length(uninstalled_packages) > 0 then
            local dotnet_verion = helpers.get_dotnet_version()
            for _, value in pairs(uninstalled_packages) do
                package_installer.add_new_package(project, value, dotnet_verion)
                print("Installed "..value)
            end
        end

        -- local cmd = string.format("dotnet-aspnet-codegenerator controller -name %s -m %s -dc %s %s", name, model, db_context, layout)
        local cmd = string.format("~/.dotnet/tools/dotnet-aspnet-codegenerator controller -p %s -name %s -m %s -dc %s %s -outDir Controllers", project, name, model, db_context, layout)
        -- print(cmd)
        local res = vim.fn.systemlist(cmd)
        print(vim.inspect(res))
    end)
end

local get_db_context = function(project, model, name)
    local db_context_list = require("scaffolding.list").find_db_context(project)

    if helpers.get_table_length(db_context_list) then
        local solution_path = helpers.get_solution_path()
        local db_context_name = solution_path:gsub("(.*)/", ""):gsub(".sln", "").."Context"

        local opts = {
            prompt = "No db context found, please give name for new: ",
            default = db_context_name
        }
        vim.ui.input(opts, function(db_context)
            scaffold_controller(project, model, name, db_context)
        end)
    else
        local opts = { prompt = "Select db context" }
        vim.ui.select(db_context_list, opts, function(db_context)
            scaffold_controller(project, model, name, db_context)
        end)
    end
end

local get_controller_name = function(project, model)
    local controller_name = model:gsub("(.*)/", ""):gsub(".cs", ""):gsub("^%l", string.upper).."sController"

    local opts = {
        prompt = "Controller name: ",
        default = controller_name
    }

    vim.ui.input(opts, function(name)
        get_db_context(project, model, name)
    end)
end

M.display_scaffold_controller = function(project)
    if project == nil then
        return project_list.select_project(M.display_scaffold_controller)
    end

    local models = project_list.list_models(project)
    local opts = { prompt = "Select model:" }
    vim.ui.select(models, opts, function(model)
        model = model:gsub("(.*)/", ""):gsub(".cs", "")
        get_controller_name(project, model)
    end)
end

return M
