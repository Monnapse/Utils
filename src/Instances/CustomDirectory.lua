--[[
    Made by Monnapse

    Example
    STRING1 -> "PlayerScript/Folder/Script"
    STRING2 -> "/Workspace"

    Compile(STRING1) -> Script
    Compile(STRING2) -> Workspace
--]]

local Directory = {}

function Directory.BuildDirectory(...): string
    local Directorys = {...}
    local String = ""

    for i,v in pairs(Directorys) do
        if i == #Directorys then
            String = String..v
        else
            String = String..v.."/"
        end
    end

    return String
end

function Directory.FindDirectory(Start, RootEnd)
    local Last = Start
    local Build = ""
    local BuildTable = {}

    repeat
        table.insert(BuildTable, Last.Name)
        --Build = Build..Last.Name.."/"
        Last = Last.Parent
    until Last == RootEnd

    table.insert(BuildTable, Last.Name)

    -- Sort the table from highest value to low lowest value so the directory is going the correct way
    table.sort(BuildTable,
	    function(Value1, Value2)
	    	return Value1 < Value2
	    end
    )

    -- Build the string
    for i,v in ipairs(BuildTable) do
        if i == #BuildTable then
            Build = Build..v
        else
            Build = Build..v.."/"
        end
    end

    --Build = string.sub(Build, #Build-1)

    return Build
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