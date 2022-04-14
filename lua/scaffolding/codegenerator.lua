-- We have to install dotnet add package Microsoft.VisualStudio.Web.CodeGeneration.Design in EVERY project that we want to scaffold in (also have to specifiy dotnet version)
local M = {}

M.is_codegenerator_installed = function()
    local cmd = "dotnet"
end

M.install_codegenerator = function()
end

return M
