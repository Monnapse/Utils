--[[
    Made by Monnapse
    Monnapse's Random Library
--]]

local RANDOM = {}

--[[
    Generates a string length given of random strings
    string(5) -> "J6LPw"
--]]
function RANDOM.string(length: number, upperCases: boolean, numbers: boolean, customList: string?)
    local alphabet = "abcdefghijklmnopqrstuvwxyz"
    local numbers = "0123456789"
    local list = alphabet
    local stringBuild = ""

    --// Build List
    if upperCases or upperCases == nil then list = list..string.upper(alphabet) end
    if numbers or numbers == nil then list = list..numbers end
    if customList then list = customList end

    --//
    for i=1, length do
        local randomNumber = math.random(1, string.len(list))
        stringBuild = stringBuild..string.sub(list, randomNumber,randomNumber)
    end

    return stringBuild
end

return RANDOM