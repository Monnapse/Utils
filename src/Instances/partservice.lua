--[[
    Made by Monnapse
    Monnapse's Part Service
--]]

--// Services
local Workspace = game:GetService("Workspace")

--// Properties
local FolderName = "PartsContainer"

local partService = {}
partService.__index = partService

--// Hidden Types
type partAvailablility = {
    part: Instance, 
    isAvailable: boolean
}

--// Hidden functions
function applyProperties(part: Instance, partProperties: {{propertyName: string, value: any}}): nil
    for property,value in pairs(partProperties) do
        part[property] = value
    end
end
function getPartsFolder(): Folder
    local Folder = Workspace:FindFirstChild(FolderName)
    if not Folder then Folder = Workspace:WaitForChild(FolderName, 1) end
    if not Folder then Folder = Instance.new("Folder", Workspace) Folder.Name = FolderName end
    return Folder
end
function hidePart(part: Instance)
    if part:IsA("BasePart") then
        part.CFrame = CFrame.new(0, 10e7, 0)
    elseif part:IsA("Model") then
        part.PrimaryPart.CFrame = CFrame.new(0, 10e7, 0)
    end
end
function getNextAvailablePart(availableTable: {partAvailablility}): partAvailablility | boolean
    for i, part: partAvailablility in pairs(availableTable) do
        if part.isAvailable then
            return part --// Return the available part
        end
    end

    return false --// No Available Part
end
function getPartInAvailability(part: Instance, availableTable: {partAvailablility}): partAvailablility | boolean
    for i, Part: partAvailablility in pairs(availableTable) do
        if part == Part.part then
            return Part --// Return the matching part
        end
    end

    return false --// Part doesnt exists in the table
end

--// Class Types
export type partService = {
    partProperties: {{propertyName: string, value: any}}?,
    part: Instance,
    partClass: string?,
    parts: {partAvailablility},

    replicateParts: (amount: number) -> nil,
    retrievePart: () -> Instance,
    returnPart: (part: Instance) -> nil
}

--// Classes
--[[
    Part Servicer
    part: Instace | string "The actual instance or the instance class"
    amount: number "The amount of parts to be created"
    replicateIfOut: boolean "When getting a part and service is out of parts then if true then create new part"
    partProperties: {{propertyName: string = value: any}}? "Modify the properties of the part, should only be used if specified part class"
--]]
function partService.new(part: Instance | string, amount: number, replicateIfOut: boolean, partProperties: {{propertyName: string, value: any}}?): partService
    amount = amount or 0
    if replicateIfOut == nil then replicateIfOut = true end

    local self: partService = setmetatable({}, partService)
    self.parts = {}
    self.partProperties = partProperties

    if type(part) == "string" then
        self.partClass = part
    elseif part:IsA("Instance") then
        self.part = part:Clone()
    else
        print("Error creating parts, please specify the part.")
        return
    end

    
    self:replicateParts(amount)

    return self
end

--// Objects
--[[
    Create Parts from service

    amount: number "The amount of parts to be replicated"
--]]
function partService:replicateParts(amount: number)
    local Folder = getPartsFolder()

    for index = 1, amount do
        local part

        if self.partClass then
            part = Instance.new(self.partClass)
        elseif self.part then
            part = self.part:Clone()
        else
            print("Error creating parts, please specify the part.")
            return
        end

        if self.partProperties then
            applyProperties(part, self.partProperties)
        end

        hidePart(part)
        table.insert(self.parts, {part = part, isAvailable = true})
        part.Parent = Folder
    end
end

--[[
    Retieve a part from the service
--]]
function partService:retrievePart()
    local part = getNextAvailablePart(self.parts)

    part.isAvailable = false
    return part.part
end

--[[
    Returns a part from the service

    part: Instance "The part to return"
--]]
function partService:returnPart(part: Instance)
    if getPartInAvailability(part, self.parts) then
        getPartInAvailability(part, self.parts).isAvailable = true
        hidePart(part)
    else
        print("Part does not exist in this service")
    end
end

return partService