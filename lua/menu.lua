local M = {}
local sections = {
    'project',
    'solution',
    'scaffolding',
    'nuget',
}

local projects = {
    'List projects',
    'Add project reference',
    'List project reference',
    'Remove project reference',
    'Delete project',
    'Create project'
}

local get_section_commands = function(value)
    print(value)
end

M.glasses_menu = function()
    local opts = {
        prompt = "Select section:"
    }
    vim.ui.select(sections, opts, get_section_commands)
end

return M
