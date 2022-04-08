local callbacks = require('callbacks')
local window = require('hello.window')

local M = {}

-- This will call the correct callbacks
function M.callback(cb)
    local callbacks_list = {
        ['open_file'] = function()
            callbacks.open_file(window.win)
        end,
        ['list_project_reference'] = function()
            callbacks.list_project_reference(window.win)
        end,
        ['delete_project'] = function()
            callbacks.delete_project(window.win)
        end,
        ['run_command'] = function()
            callbacks.run_command(window.win)
        end,
        ['create_project'] = function()
            callbacks.create_project(window.win)
        end
    }

    if(callbacks_list[cb]) then
        callbacks_list[cb]()
    end
end

return M
