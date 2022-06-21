# Nvim-Glasses
This plugin is still in VERY early stages of development and a lot of things will be broken!

## What does it do
This plugin makes it easier to work with the C# language and the Dotnet framework. This plugin gives the user visual menus and feedback about options and values that need to be filled in.

## Support
This plugin has been tested for Dotnet 5.0.
If you encounter any problems on any other Dotnet version, feel free to open an issue!
This plugin will most likely only work on Linux.

## Recommended to use
For this plugin to work you need to install multiple things:
- A Dotnet version
- The following Dotnet extensions if you want to use entity framework or make use of the scaffolding. (When a version is specified make sure to install the version that matches your installed Dotnet version)
`dotnet tool install -g dotnet-aspnet-codegenerator --version 5.0.X`
`dotnet tool install -g dotnet-ef`
- Nvim plenary: `nvim-lua/plenary.nvim`
- Its recommended to use something like `dressing.nvim` because most actions take a lot of menu's and the default menu can sometimes get a bit confusing


## Todo:
### options
- Implement settings / options
- Make a option what allows the plugin to automatically select a project when there is only one available when a project needs to be selected
- Make it possible to always make a new db context when a context has to be selected
- Make a option for a user to select their file tree refresh function so it file tree will be updated when making project or solution
- Make a user choose how projects are ran
    * using a side split
    * using tmux
    * maybe even a open the option for something custom

### Entity Framework
- Where is it???
- How does it work???
- Is it even REAL??
- Are any of us even REAL???

### Tests
- When selecting a test project to run tests on make sure to only show test projects

### Random things
- Make system commands async or something to prevent vim from freezing
- Error checking and error messages
- Make a list / keybind that shows all commands without all the sub menus

### Actions
- Publish a project/solution
- Make something to jump to the view matching the controller

- Add files (ex: class, interface, etc) (Delayed until further notice)
    - This is mildly scuffed.
        - There is no api to do this so i could build it myself
        - The problem with this is that the namespace won't be auto generated
            - But this can be solved by taking the dir the file is placed in and replacing / with .
        - And then a would have to do this for all the things like test projects and interfaces etc

### Package manager
- Install packages
    - browse packages
        - MIGTH be possible (but am not sure) to query "https://nuget.org/packages?q=<package_name>" and show the results in a vim window and download based on the one selected
            - IF that works then we might also be able to make a user select a version
        - Could also use "https://github.com/billpratt/dotnet-search" but does not seem to work as wel as the documentations shows ...
            - When running a command like dotnet tool search json.net we do not get a package like newtonsoft.json but we do get a lot of low download packages
    - Save a list of packages you have installed before so you can scroll through those and chose from there
- Uninstall packages
