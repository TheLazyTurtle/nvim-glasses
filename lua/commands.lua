local M = {}

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
        add = {
            display_name = "Add project to solution",
            callback = require("solution.add").display_add_project
        },
    },
    nuget = {
        list = {
            display_name = "List installed packages",
            callback = require("nuget.list").display_installed_packages
        },
        add = {
            -- TODO: Does not yet work very nicely. Really should add the package selection thing
            display_name = "Add new package",
            callback = require("nuget.add").display_add_package
        },
        remove = {
            display_name = "Remove package",
            callback = require("nuget.remove").display_remove_package
        },
        update = {
            display_name = "Update package",
            callback = require("nuget.update").display_update_package
        },
    },
    scaffolding = {
        controller = {
            display_name = "Controller",
            callback = require("scaffolding.controllers").display_scaffold_controller
        },
        area = {
            display_name = "Area",
        },
        identity = {
            display_name = "Identity",
        },
        razorpage = {
            display_name = "Razorpage",
        },
        view = {
            display_name = "View",
        },
    }
}

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
return M
