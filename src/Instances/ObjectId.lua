--[[
    Made by Monnapse

    Add Id's to your objects
--]]

local ObjectId = {}
local LastId = 0

function ObjectId.AddId(Instance: Instance)
    if Instance:GetAttribute("Id") then
        error(Instance,"already has an Id")
    end

    Instance:SetAttribute("Id", LastId)
    LastId += 1
end

function ObjectId.GetId(Instance: Instance): number
    if Instance:GetAttribute("Id") then
        return Instance:GetAttribute("Id")
    else
        error(Instance,"does not have an id")

        --ObjectId.AddId(Instance)

        return -1--ObjectId.CheckId(Instance)
    end
end

function ObjectId.CheckId(Instance: Instance, Id: number): boolean
    if ObjectId.GetId(Instance) == Id then return true end
    return false
end

return ObjectId