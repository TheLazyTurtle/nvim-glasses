# Nvim-Glasses

## Support
This plugin has been tested for asp-dotnet 5.0, but should work fine on asp-dotnet 6.0 as well.
If you encounter any problems on any dotnet version, feel free to open an issue!

## Recommended to use
Omnisharp-vim (not sure if this is needed for the plugin)
`dotnet tool install -g dotnet-aspnet-codegenerator --version 5.0.2` (This is needed for the plugin) make sure to use the EXACT SAME VERSION as your SDK 
`dotnet tool install --global dotnet-ef`
Use plenary
Its recommended to use something like dressing.nvim because most actions take a lot of menu's and the default menu can sometimes get a bit confusing
For Linux users:
    - localDB doesn't work so use this `https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-overview?view=sql-server-ver15`

## Todo:
### options
    -> Implement settings / options
    -> Make a option what allows the plugin to automatically select a project when there is only one available when a project needs to be selected
    -> Make it possible to always make a new db context when a context has to be selected
    -> Make a option for a user to select their file tree refresh function so it file tree will be updated when making project or solution
    -> Make a user choose how projects are ran
        -> using a side split
        -> using tmux
        -> maybe even a open the option for something custom

### Entity Framework
    -> Where is it???
    -> How does it work???
    -> Is it even REAL??
    -> Are any of us even REAL???

### Notes
    -> Tests
        -> when selecting a test project to run tests on make sure to only show test projects

### Code base
    -> Make system commands async or something to prevent vim from freezing
    -> Error checking and error messages

### Actions
    -> Publish a project/solution
    -> Make something to jump to the view matching the controller

	-> Add files (ex: class, interface, etc) (Delayed until further notice)
        -> This is mildly scuffed.
            -> There is no api to do this so i could build it myself
            -> The problem with this is that the namespace won't be auto generated
                -> But this can be solved by taking the dir the file is placed in and replacing / with .
            -> And then a would have to do this for all the things like test projects and interfaces etc

### Package manager
	-> Install packages
		-> browse packages
            -> MIGTH be possible (but am not sure) to query "https://nuget.org/packages?q=<package_name>" and show the results in a vim window and download based on the one selected
                -> IF that works then we might also be able to make a user select a version
            -> Could also use "https://github.com/billpratt/dotnet-search" but does not seem to work as wel as the documentations shows ...
                -> When running a command like dotnet tool search json.net we do not get a package like newtonsoft.json but we do get a lot of low download packages
        -> Save a list of packages you have installed before so you can scroll through those and chose from there
	-> Unistall packages
