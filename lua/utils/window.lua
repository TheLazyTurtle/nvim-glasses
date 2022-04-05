local popup = require("plenary.popup")
local M = {}

Glasses_win_id = nil
Glasses_bufh = nil

function M.close_menu()
  vim.api.nvim_win_close(Glasses_win_id, true)
end

local function create_window()
  local width = 60
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

-- Gotta find a way to make this fill stuff dynamically
local function get_menu_items()
  local x = {}
  local indicies = {"test", "test2"}

  for _, line in pairs(x) do
    table.insert(indicies, line)
  end

  return indicies
end

function M.open_window()
  local opts = {silent = true}

  if Glasses_win_id ~= nil and vim.api.nvim_win_is_valid(Glasses_win_id) then
    M.close_menu()
    return
  end

  local win_info = create_window()
  local contents = get_menu_items()

  Glasses_win_id = win_info.win_id
  Glasses_bufh = win_info.bufnr

  vim.api.nvim_win_set_option(Glasses_win_id, "number", true)
  vim.api.nvim_buf_set_name(0, "Test")
  vim.api.nvim_buf_set_lines(0, 0, #contents, false, contents)
  vim.api.nvim_buf_set_option(0, "filetype", "test")
  vim.api.nvim_buf_set_option(0, "buftype", "acwrite")
  vim.api.nvim_buf_set_option(0, "bufhidden", "delete")
  vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>lua require('utils.window').close_menu()<cr>", opts)
  vim.api.nvim_buf_set_keymap(0, "n", "<esc>", "<cmd>lua require('utils.window').close_menu()<cr>", opts)
  vim.api.nvim_buf_set_keymap(0, "n", "key", "Command", opts)
end

return M

