local api = vim.api
local buf
local M = {}
M.win = 0

-- This makes the complete window
function M.window(cb, data)
	buf = api.nvim_create_buf(false, true)
	api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

	-- Get window size
	local width = api.nvim_get_option("columns")
	local height = api.nvim_get_option("lines")

	-- Calculate floating window size
	local win_width = math.ceil(width * 0.8)
	local win_height = math.ceil(height * 0.8 - 4)

	-- Its starting position
	local col = math.ceil((width - win_width) / 2)
	local row = math.ceil((height - win_height) / 2 - 1)

	-- Set some options
	local opts = {
		style = "minimal",
		relative = "editor",
		width = win_width,
		height = win_height,
		row = row,
		col = col,
	}

	-- Write ALL the lines to the buffer
	api.nvim_buf_set_lines(buf, 0, -1, false, data)

	-- Lookup table to check what key bindings run what function
	local mappings = {
		['<CR>'] = cb
	}

	-- Bind all bindings to the buffer
	for k, v in pairs(mappings) do
		api.nvim_buf_set_keymap(buf, 'n', k, ':lua '..v..'<CR>', {
			nowait = true, noremap = true, silent = true
		})
	end

	-- Create it with buffer attached
	M.win = api.nvim_open_win(buf, true, opts)
end

return M
