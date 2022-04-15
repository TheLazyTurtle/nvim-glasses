local list_projects = require('projects.list').list_projects
local M = {}

-- M.sections = {
--     project = "",
--     solution = "",
--     scaffolding = "",
--     nuget = "",
-- }
--
-- M.project = {
--     add_project_reference = {
--         display_name = "Add project reference",
--         data_selection = list_projects,
--         callback = {
--             -- TODO: This might have to change to something that does not show the selected project
--             data_selection = list_projects,
--             callback = require('projects.references').add_project_reference
--         },
--     },
--     list_project_references = {
--         display_name = "List project references",
--         data_selection = list_projects,
--         callback = {
--             data_selection = require('projects.references').list_project_references,
--         },
--     },
--     remove_project_reference = {
--         display_name = "Remove reference to project",
--         data_selection = list_projects,
--         callback = {
--             data_selection = require('projects.references').list_project_references,
--             callback = require('projects.references').remove_project_reference
--         }
--     },
--     delete = {
--         display_name = "Delete",
--         data_selection = list_projects,
--         callback = require('projects.delete').delete_project
--     },
--     create = {
--         display_name = "Create",
--         callback = require('projects.create').create_project_callback,
--         data_selection = require('projects.create').list_project_templates,
--     },
-- }
--
-- M.solution = {
--     add = {
--         display_name = "Add project to solution",
--         data_selection = require("projects.list").find_all_disconnected_projects,
--         callback = require("solution.add").add_project_to_solution
--     },
-- }
--
-- M.nuget = {
--     list_installed = {
--         display_name = "List installed packages",
--         data_selection = require("projects.list").list_projects,
--         callback = {
--             data_selection = require("nuget.list").list_installed_packages
--         }
--     },
--     add_new = {
--         display_name = "Install a package",
--         data_selection = require("projects.list").list_projects,
--         callback = require("nuget.add").add_new_package,
--     },
--     remove_package = {
--         display_name = "Uninstall a package",
--         data_selection = require("projects.list").list_projects,
--         callback = {
--             data_selection = require("nuget.list").list_installed_packages,
--             callback = require("nuget.remove").remove_package
--         }
--     },
--     update_package = {
--         display_name = "Update a package",
--         data_selection = require("projects.list").list_projects,
--         callback = {
--             data_selection = require("nuget.list").list_installed_packages,
--             callback = require("nuget.update").update_package
--         }
--     }
-- }
--
-- M.scaffolding = {
--     controller = {
--         display_name = "Controller",
--         data_selection = require("projects.list").list_projects,
--         callback = {
--             data_selection = require("projects.list").list_models,
--             callback = require("scaffolding.controllers").scaffold_controller
--         }
--     },
--     area = {
--         display_name = "Area",
--     },
--     identity = {
--         display_name = "Identity",
--     },
--     razorpage = {
--         display_name = "Razorpage",
--     },
--     view = {
--         display_name = "View",
--     }
-- }

M.sections = {
    'project',
    'solution',
    'scaffolding',
    'nuget',
}

M.section_options = {
    project = {
        list = {
            display_name = "List projects",
            callback = require("projects.list").display_project_list
        },
        delete = {
            display_name = "Delete project",
            callback = require("projects.delete").display_delete_project
        },
        create = {
            display_name = "Create project",
            callback = require("projects.create").display_create_project
        },
        add_project_reference = {
            display_name = "Add project reference",
            callback = require("projects.references").display_add_project_reference
        },
        list_project_references = {
            display_name = "List project references",
            callback = require("projects.references").display_list_project_references
        },
        remove_project_reference = {
            display_name = "Remove project reference",
            callback = require("projects.references").display_remove_project_reference
        },
    },
    solution = {
        'Add project to solution'
    },
    nuget = {
        'List installed packages',
        'Add new package',
        'Remove package',
        'Update Package'
    },
    scaffolding = {
        'Controller',
        'Area',
        'Identity',
        'Razorpage',
        'View'
    }
}
return M
