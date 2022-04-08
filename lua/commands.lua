local M = {}

M.sections = {
    project = "",
    solution = "",
    scaffolding = ""
}

M.project = {
    list =  {
        display_name = "List",
        data_selection = require('projects.list').list_projects,
    },
    add_project_reference = {
        display_name = "Add project reference",
        callback = "",
        data_selection = "",
    },
    list_project_references = {
        display_name = "List project references",
    },
    delete = {
        display_name = "Delete",
    },
    create = {
        display_name = "Create",
        callback = require('projects.create').create_project_callback,
        data_selection = require('projects.create').list_project_templates,
    },
}

M.solution = {
    add = {
        display_name = "Add project to solution",
        data_selection = require("projects.list").find_all_disconnected_projects,
        callback = require("solution.add").add_project_to_solution
    },
}

M.scaffolding = {

}

return M
