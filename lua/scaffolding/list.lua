local scandir = require("plenary.scandir")
local helpers = require("helpers")
local M = {}

M.find_db_context = function(project)
    local project_dir = helpers.get_project_dir(project)
    local data = scandir.scan_dir(project_dir)
    local db_contexts = {}

    for _, value in pairs(data) do
        local ending = "Context.cs"
        if value:sub(-#ending) == ending then
            table.insert(db_contexts, value)
        end
    end

    return db_contexts
end

return M
