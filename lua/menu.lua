local commands = require("commands")
local M = {}
local Section = nil

local call_callback = function(value)
    for _, v in pairs(commands.section_options[Section]) do
        if v.display_name == value then
            Section = nil
            return v.callback()
        end
    end
end

local get_section_commands = function(value)
    local opts = { prompt = "Select options:" }
    local section_options_list = {}

    -- Extract the name of the options out of the list
    for _, v in pairs(commands.section_options[value]) do
        table.insert(section_options_list, v.display_name)
    end

    Section = value
    vim.ui.select(section_options_list, opts, call_callback)
end

M.glasses_menu = function()
    local opts = { prompt = "Select section:" }
    vim.ui.select(commands.sections, opts, get_section_commands)
end

return M
