local helpers = require("helpers")
local M = {}

local choose_db_context = function(project)
    local db_context_list = require("scaffolding.list").find_db_context(project)

    if helpers.get_table_length(db_context_list) == 5 then
        local text = string.format("Found db context: %s. Press <enter> to use, or type a name to make a new one (<name>Context): ", db_context_list[1])
        return vim.fn.input(text, "Context")
    elseif db_context_list == 0 then
        return vim.fn.input("Found no db context. Type a name to make a new one (<name>Context): ", "Context")
    else
        local options = "\n"
        for key, value in pairs(db_context_list) do
            local text = string.format("%s %s\n", key, value)
            options = options .. text
        end

        -- TODO: Error handling when emtpy
        -- TODO: Allow option for a new one
        local text = string.format("Found multiple context. Please choose: %s", options)
        -- local option = vim.fn.input(text, "")
        local option = vim.ui.select(db_context_list, {
            prompt = "Select db context: "
        },
        function(choice)
                print(choice)
            end)

        return db_context_list[option]
    end
end

M.scaffold_controller = function(project, model)
    local name = vim.fn.input("Controller name (<name>Controller): ", "Controller")
    local db_context = choose_db_context(project)
    local layout = vim.fn.input("Layout file (leave empty for default): ", "")

    if layout == "" then
        layout = "-udl"
    else
        layout = string.format("-l %s", layout)
    end

    local cmd = string.format("dotnet-aspnet-codegenerator controller -name %s -m %s -dc %s %s", name, model, db_context, layout)
    print(cmd)
end

return M
