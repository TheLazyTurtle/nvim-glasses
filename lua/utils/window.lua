local helpers = require("helpers")
local popup = require("plenary.popup")
local commands = require("commands")
local M = {}

Glasses_win_id = nil
Glasses_bufh = nil
Secton = nil
Command = nil
Callback_has_callback = false
Prev_value = nil

-- Close the window
function M.close_menu()
    vim.api.nvim_win_close(Glasses_win_id, true)
end

-- Create a new window
local function create_window(difWidth)
    local solution = helpers.get_solution_path()
    if solution == nil then
        print("Not a C# solution. Please open vim in the root of your solution")
        return
    end

    local width = (difWidth ~= nil and difWidth or 60)
    local height = 10
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    local bufnr = vim.api.nvim_create_buf(false, false)

    local Glasses_win_id, win = popup.create(bufnr, {
        title = "Nvim-Glasses menu",
        highlight = "Glasses",
        line = math.floor(((vim.o.lines - height) / 2) -1),
        col = math.floor((vim.o.columns - width) /2),
        minwidth = width,
        minheight = height,
        borderchars = borderchars
    })

    vim.api.nvim_win_set_option(
        win.border.win_id,
        "winhl",
        "Normal:GlassesBorder"
    )

    return {
        bufnr = bufnr,
        win_id = Glasses_win_id
    }
end

-- Get the section items
local function get_section_items()
    local x = commands.sections
    local indicies = {}

    for key, _ in pairs(x) do
        table.insert(indicies, key)
    end

    return indicies
end

-- Gets all the commands per section
local function get_section_commands(section)
    local x = commands[section]

    -- Cool error handling
    if x == nil then
        print("Not a valid section")
        Secton = nil
        -- Command = nil
        Callback_has_callback = false
        Prev_value = nil
        return
    end

    local indicies = {}

    for _, value in pairs(x) do
        table.insert(indicies, value.display_name)
    end

    return indicies
end

-- Find the callable name of a command based on the name from the selection menu
local function find_command_by_name(name)
    for key, value in pairs(commands[Section]) do
        if value.display_name == name then
            return key
        end
    end

    Secton = nil
    Command = nil
    Callback_has_callback = false
    Prev_value = nil
    print("Invalid command")
end

-- Handles a select action
function M.select_menu_item()
    local value = vim.api.nvim_get_current_line()
    M.close_menu()

    -- If the command is a section open the section selection window
    if commands.sections[value] ~= nil then
        M.open_window(value)
        return
    end

    -- If there is no command set then get the command by its name and show the next data selection screen
    if Command == nil then
        Command = find_command_by_name(value)

        local data = commands[Section][Command]["data_selection"]()
        M.open_window(Section, data)
        return
    end

    -- If it is not a command and not a data selection then run the callback
    local callback = commands[Section][Command]["callback"]
    if callback == nil then
        return
    end

    -- If the callback contains a table first run the data selection from that end then the callback
    if type(callback) == "table" then
        if Callback_has_callback then
            callback.callback(Prev_value, value)

            Callback_has_callback = false
            Prev_value = nil
            Section = nil
            Command = nil
            return
        else
            Prev_value = value
            M.open_window(Section, callback["data_selection"](value))
        end

        -- If the callback has a callback then set the value true
        if callback["callback"] ~= nil then
            Callback_has_callback = true
        else
            Callback_has_callback = false
            Prev_value = nil
            Section = nil
            Command = nil
        end
    else
        Command = nil
        Section = nil
        Callback_has_callback = false
        Prev_value = nil
        callback(value)
    end
end

-- Opens a window
function M.open_window(section, data)
    local contents = {}
    local win_info = nil

    -- Check if there is already a window open and close it if it is open
    if Glasses_win_id ~= nil and vim.api.nvim_win_is_valid(Glasses_win_id) then
        M.close_menu()
        return
    end

    -- Create a new window and give it a size if there is data supplied
    if data ~= nil then
        -- TODO: Make this thing be the with of the max lenght of an item
        win_info = create_window(vim.api.nvim_get_option("columns") / 2)
    else
        win_info = create_window()
    end

    -- Check if there is a section chosen. If there is then show those commands else show the section options
    if section == nil then
        contents = get_section_items()
    elseif data ~= nil then
        for _, value in pairs(data) do
            table.insert(contents, value)
        end
    else
        Section = section
        contents = get_section_commands(section)
    end

    -- Options
    Glasses_win_id = win_info.win_id
    Glasses_bufh = win_info.bufnr

    vim.api.nvim_win_set_option(Glasses_win_id, "number", true)
    vim.api.nvim_buf_set_name(0, "Glasses")
    vim.api.nvim_buf_set_lines(0, 0, #contents, false, contents)
    vim.api.nvim_buf_set_option(0, "filetype", "Glasses")
    vim.api.nvim_buf_set_option(0, "buftype", "acwrite")
    vim.api.nvim_buf_set_option(0, "bufhidden", "wipe")

    -- Key maps
    local opts = {silent = true}
    vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<cmd>lua require('utils.window').select_menu_item()<cr>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>lua require('utils.window').close_menu()<cr>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "<esc>", "<cmd>lua require('utils.window').close_menu()<cr>", opts)
end

return M

