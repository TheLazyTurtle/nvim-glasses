# Nvim-Glasses

## Support
This plugin has been tested for asp-dotnet 5.0, but should work fine on asp-dotnet 6.0 as well.
If you encounter any problems on any dotnet version, feel free to open an issue!

## Recommended to use
Omnisharp-vim (not sure if this is needed for the plugin)
`dotnet tool install -g dotnet-aspnet-codegenerator --verson 5.0.2` (This is needed for the plugin) make sure to use the EXACT SAME VERSION as your SDK 
Use plenary
Its recommended to use something like dressing.nvim because most actions take a lot of menu's and the default menu can sometimes get a bit confusing

## TODO:
### options
    -> Implement settings / options
    -> Make a option what allows the plugin to automatically select a project when there is only one available
### Code base
    -> Make system commands async or something to prevent vim from freezing

### Code generation
    -> For things like controllers
        -> Options like async should that be a different option in the scaffolding menu or should it be asked during the making of a controller
	-> Add template things (entity framework files, scaffolding)
        -> Need to install aspnet-codegenerator
        -> Ask use to install the code-generator if it is not installed

### Actions
    -> Make something to jump to the view matching the controller
	-> Run tests
	-> Run package manager console (ex. add-migration, update-database)
	-> Add formatting
    -> Add running the program
        -> In a side console
        -> In a new tmux window
        -> These options need to be configurable
    -> Publish a project/solution

	-> Add files (ex: class, interface, etc) (Delayed until further notice)
        -> This is mildly scuffed.
            -> There is no api to do this so i could build it myself
            -> The problem with this is that the namespace won't be auto generated
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
