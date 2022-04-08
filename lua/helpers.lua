local scandir = require("plenary.scandir")
local M = {}

-- This gets the solution path
M.get_solution_path = function()
    local data = scandir.scan_dir('.', {depth = 2})
    for _, v in pairs(data) do
        if string.find(v, ".sln") then
            return v
        end
    end
end

-- this will take the full project template string and extract the short name out of it
M.extract_project_short_name = function(line)
    local result = M.string_split(line, "  +")
    return result[2]
end

-- Split strings
M.string_split = function(inputstr, sep)
    local result = {}
    for match in (inputstr..sep):gmatch("(.-)"..sep) do
        table.insert(result, match);
    end
    return result;
end

-- This will find the difference between two tables
M.get_difference_between_tables = function(a, b)
    local aa = {}

    for _,v in pairs(a) do
        aa[v]=true
    end

    for _,v in pairs(b) do
        aa[v]=nil
    end

    local ret = {}
    local n = 0
    for _,v in pairs(a) do
        if aa[v] then n=n+1 ret[n]=v end
    end
    return ret
end

return M
