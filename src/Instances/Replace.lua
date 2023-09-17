--[[
    Made by Monnapse
--]]

return function(Instance: Instance, ReplaceWith: Instance)
    for i,v in pairs(Instance:GetChildren()) do
        v.Parent = ReplaceWith
    end
    ReplaceWith.Parent = Instance.Parent
    Instance:Destroy()
end