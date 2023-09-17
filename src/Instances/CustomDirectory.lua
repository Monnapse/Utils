--[[
    Made by Monnapse

    Example
    STRING1 -> "PlayerScript/Folder/Script"
    STRING2 -> "/Workspace"

    Compile(STRING1) -> Script
    Compile(STRING2) -> Workspace
--]]

local Directory = {}

function Directory.BuildDirectory(Start, ...): string
    local Directorys = {...}
    local String = Start.Name or Start

    for i,v in ipairs(Directorys) do
        if i == #Directorys then
            String = String..v
        else
            String = String..v.."/"
        end
    end

    return String
end

function Directory.Compile(Start, Directory: string)
    local Table = string.split(Directory, "/")
    local Build = Start


    for i,v in pairs(Table) do
        Build = Build:FindFirstChild(v)
    end
    return Build
end

return Directory