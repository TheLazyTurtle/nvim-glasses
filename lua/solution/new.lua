local helpers = require "helpers"
local M = {}

local values = {
    'Use current folder as project root',
    'Make new folder for project root'
}

M.display_new_solution = function()
    -- TODO: Ask if user wants it in current folder or make new folder
    --      If new folder ask for folder name and make that folder
    --      Ask for solution file name (auto fill with folder name)
    --      If no new folder has to be made then just ask for solution file name and make it

    local opts = { prompt = 'Choose a option' }

    return vim.ui.select(values, opts, M.create_solution_callback)
end

M.create_solution_callback = function(folder_option)
    if folder_option == values[1] then
        -- This is current folder as root
        return M.ask_solution_file_name()
    else
        -- This is new folder as root
        return M.ask_solution_folder()
    end
end

M.make_solution_file = function(name, folder_name)
    if folder_name == nil then
        -- Current folder
        local cmd = string.format('dotnet new sln --name %s', name)
        vim.fn.system(cmd)

        helpers.refresh_file_tree()
    else
        local cmd = string.format('mkdir %s && dotnet new sln --name %s --output %s', folder_name, name, folder_name)

        -- Make new folder and put solution file in there
        vim.fn.system(cmd)

        helpers.refresh_file_tree()
    end
end

M.ask_solution_file_name = function(folder_name)
    local opts = { prompt = 'Solution name' }

    if folder_name ~= nil then
        opts.default = folder_name
    end

    vim.ui.input(opts, function(solution_name)
        M.make_solution_file(solution_name, folder_name)
    end)
end

M.ask_solution_folder = function()
    local opts = { prompt = 'Folder name' }

    vim.ui.input(opts, function(folder_name)
        return M.ask_solution_file_name(folder_name)
    end)
end

return M
