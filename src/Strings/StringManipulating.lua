--[[
    Made by Monnapse
--]]

--// Services

local Manipulating = {}

--[[
    Made by FSMaxB on stackoverflow
    Add escape pattern to string automatically
--]]
function Manipulating.EscapePattern(String: string)
    return String:gsub("([^%w])", "%%%1")
end

--[[
    Replace lets you to replace a string inside a string without using patterns
--]]
function Manipulating.Replace(Source: string, Find: string, Replacement: string)
    return string.gsub(Source, Manipulating.EscapePattern(Find), Replacement)
end

return Manipulating