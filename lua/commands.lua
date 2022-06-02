local M = {}

M.sections = {
    'project',
    'solution',
    'scaffolding',
    'nuget',
    'entity_framework',
    'actions'
}

M.section_options = {
    project = {
        make_file = {
            display_name = 'Make new file',
            callback = require('projects.files').display_create_file
        },
        list = {
            display_name = 'List projects',
            callback = require('projects.list').display_project_list
        },
        delete = {
            display_name = 'Delete project',
            callback = require('projects.delete').display_delete_project
        },
        create = {
            display_name = 'Create project',
            callback = require('projects.create').display_create_project
        },
        add_project_reference = {
            display_name = 'Add project reference',
            callback = require('projects.references').display_add_project_reference
        },
        list_project_references = {
            display_name = 'List project references',
            callback = require('projects.references').display_list_project_references
        },
        remove_project_reference = {
            display_name = 'Remove project reference',
            callback = require('projects.references').display_remove_project_reference
        },
    },
    solution = {
        new = {
            display_name = 'Make new solution',
            callback = require('solution.new').display_new_solution
        },
        add = {
            display_name = 'Add project to solution',
            callback = require('solution.add').display_add_project
        },
    },
    nuget = {
        list = {
            display_name = 'List installed packages',
            callback = require('nuget.list').display_installed_packages
        },
        add = {
            -- TODO: Does not yet work very nicely. Really should add the package selection thing
            display_name = 'Add new package',
            callback = require('nuget.add').display_add_package
        },
        remove = {
            display_name = 'Remove package',
            callback = require('nuget.remove').display_remove_package
        },
        update = {
            display_name = 'Update package',
            callback = require('nuget.update').display_update_package
        },
    },
    scaffolding = {
        controller = {
            display_name = 'Controller',
            callback = require('scaffolding.controllers').display_scaffold_controller
        },
        area = {
            display_name = 'Area',
            callback = require('scaffolding.area').display_scaffold_area
        },
        identity = {
            display_name = 'Identity',
        },
        razorpage = {
            display_name = 'Razorpage',
            callback = require('scaffolding.razorpage').display_scaffold_razorpage
        },
        view = {
            display_name = 'View',
            callback = require('scaffolding.view').display_scaffold_view
        },
    },
    entity_framework = {
        add_migration = {
            display_name = 'Add migration',
            callback = require('entity_framework.add_migration').display_add_migration
        },
        remove_migration = {
            display_name = 'Remove migration',
            callback = require('entity_framework.remove_migration').display_remove_migration
        },
        update_database = {
            display_name = 'Update database',
            callback = require('entity_framework.update_database').display_update_database
        },
        drop_database = {
            display_name = 'Drop database',
            callback = require('entity_framework.drop_database').display_drop_database
        },
        export = {
            display_name = 'Export to .sql',
            callback = require('entity_framework.export').display_export_database
        }
    },
    actions = {
        run = {
            display_name = 'Run app',
            callback = require('actions.run').display_run_app
        },
        list_test = {
            display_name = 'List tests',
            callback = require('actions.tests').display_list_test
        },
        all_tests = {
            display_name = 'Run all tests',
            callback = require('actions.tests').display_run_all_test
        },
        test = {
            display_name = 'Run test project',
            callback = require('actions.tests').display_run_test
        }
    }
}
return M
