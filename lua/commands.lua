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
        data_selection = require('projects.list').list_projects,
        callback = {
            -- TODO: This might have to change to something that does not show the selected project
            data_selection = require('projects.list').list_projects,
            callback = require('projects.references').add_project_reference
        },
    },
    list_project_references = {
        display_name = "List project references",
        data_selection = require('projects.list').list_projects,
        callback = {
            data_selection = require('projects.references').list_project_references,
        },
    },
    remove_project_reference = {
        display_name = "Remove reference to project",
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
