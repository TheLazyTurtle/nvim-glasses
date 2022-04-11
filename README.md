# Nvim-Glasses

## Support
This plugin has been tested for asp-dotnet 5.0, but should work fine on asp-dotnet 6.0 as well.
If you encounter any problems on any dotnet version, feel free to open an issue!

## Recommeded to use
Omnisharp-vim

## TODO:
	-> Install packages
		-> browse packages
        -> Save a list of packages you have installed before so you can scroll through those and chose from there
	-> Unistall packages
    -> Add tests
	-> Add template things (entity framework files, scaffolding)
        -> Need to install aspnet-codegenerator
        -> Ask use to install the code-generator if it is not installed
	-> Run tests
	-> Run package manager console (ex. add-migration, update-database)
	-> Add formatting
    -> Make system commands async or something to prevent vim from freezing
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
