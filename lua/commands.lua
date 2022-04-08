local M = {}

M.sections = {
    project = "",
    solution = "",
    scaffolding = ""
}

M.project = {
    list =  {
        data_selection = require('projects.list').list_projects,
    },
    link = "",
    delete = "",
        callback = require('projects.create').create_project_callback,
        data_selection = require("helpers").list_project_templates,
    create = {
    },
}

M.solution = {
}

M.scaffolding = {

}

return M
