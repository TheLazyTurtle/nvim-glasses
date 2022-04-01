local fn = vim.fn
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

-- This should find all the projects that are not connected to the solution
M.find_all_disconnected_projects = function()
	local data = scandir.scan_dir('.', {depth = 2})
	local projects = {}
	local linked_projects = M.find_linked_projects()

	for _, v in pairs(data) do
		if string.find(v, ".csproj") then
			table.insert(projects, v)
		end
	end

	return M.get_difference_between_tables(projects, linked_projects)
end

-- This will get all the projects linked to a project
M.find_linked_projects = function()
	local solution = M.get_solution_path()
	return fn.systemlist(string.format("dotnet sln %s list", solution))
end

-- This will link a project to a solution
M.add_project_to_solution = function(project_name)
	local cmd = string.format("dotnet sln add %s", project_name)
	fn.system(cmd)
end

-- This will create the project
M.create_project = function(project_template, name)
	local cmd = string.format("dotnet new %s --name %s", project_template, name)
	local result = fn.system(cmd)

	if string.find(result, "Restore succeeded.") then
		M.add_project_to_solution(name)
	end
end

-- This will return a list of all available project templates
M.list_project_templates = function()
	return fn.systemlist("dotnet new --list")
end

-- this will take the full project template string and extract the short name out of it
M.extract_project_short_name = function(line)
	--line = line.gsub("%s%s+", "")
	local result = M.string_split(line, "  +")
	return result[2]
end

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
