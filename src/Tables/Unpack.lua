local Unpacking = {}

--[[
    Merge Tables

    example
        Unpack({hi="123",d},{test=3},{d=2}) -> {hi="123",[1]=d,test=3,d=2}
--]]
function Unpacking.Unpack(...)
    local PackedTable = {...}
	local UnpackedTable = {}

	for i,v in ipairs(PackedTable) do
        for index,value in pairs(v) do
            UnpackedTable[index] = value
        end
	end
	
	return UnpackedTable
end

return Unpacking.Unpack