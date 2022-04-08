local popup = require("plenary.popup")
local commands = require("commands")
local M = {}

Glasses_win_id = nil
Glasses_bufh = nil
Secton = nil
Command = nil

-- Close the window
function M.close_menu()
    vim.api.nvim_win_close(Glasses_win_id, true)
end

-- Create a new window
local function create_window(difWidth)
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

local function get_section_commands(section)
    local x
    if section == "project" then
        x = commands.project
    elseif section == "solution" then
        x = commands.solution
    elseif section == "scaffolding" then
        x = commands.scaffolding
    else
        x = commands.sections
    end

    local indicies = {}

    for key, _ in pairs(x) do
        table.insert(indicies, key)
    end

    return indicies
end

-- Handles a select action
function M.select_menu_item()
    local value = vim.api.nvim_get_current_line()
    M.close_menu()

    -- If the value is a section then open the correct section screen, else run the callback
    if commands.sections[value] ~= nil then
        M.open_window(value)
    else
        if Command ~= nil then
            -- If there is a selection screen then open that first
            if (commands[Section][Command]["callback"] ~= nil) then
                commands[Section][Command]["callback"](value)
            end
            Command = nil
        else
            Command = value
            local data = commands[Section][value]["data_selection"]()
            M.open_window(Section, data)
        end
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

