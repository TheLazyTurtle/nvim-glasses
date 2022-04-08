local M = {}

M.sections = {
  project = "",
  solution = "",
  scaffolding = ""
}

M.project = {
  list = "",
  link = "",
  delete = "",
  create = {
    callback = require('projects.create').create_project_callback,
    data_selection = require("helpers").list_project_templates,
  },
}

M.solution = {
}

M.scaffolding = {

}

return M
