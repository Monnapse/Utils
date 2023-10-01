--[[

	Spring Module
	
	Made by Monnapse#7578

--]]

local SPRING = {}

export type Spring = {
    Position: {
        DAMPING_RATIO: number,
        ANGULAR_FREQUENCY: number,
        Mass: number,
        Target: Vector3,
        Current: Vector3,
        Velocity: Vector3,
    },
    Rotation: {
        DAMPING_RATIO: number,
        ANGULAR_FREQUENCY: number,
        Mass: number,
        Target: Vector3,
        Current: Vector3,
        Velocity: Vector3,
    },

    update: (dt: number) -> CFrame,
    shove: (cframe: CFrame) -> nil
}

--// Functions
function SPRING.new(damping_ratio, angular_frequency, mass, rotation_damping_ratio, rotation_angular_frequency, rotation_mass)
	local Spring = SPRING
    Spring.Position = {
        --// Constants
        DAMPING_RATIO     = damping_ratio or 1,
        ANGULAR_FREQUENCY = angular_frequency or 15,
        Mass              = mass or 1,

        Target    = Vector3.new(0,0,0),
        Current   = Vector3.new(0,0,0),
        Velocity  = Vector3.new(0,0,0),
    }
    Spring.Rotation = {
        --// Constants
        DAMPING_RATIO     = rotation_damping_ratio or damping_ratio or 1,
        ANGULAR_FREQUENCY = rotation_angular_frequency or angular_frequency or 15,
        Mass              = rotation_mass or mass or 1,
        
        Target    = Vector3.new(0,0,0),
        Current   = Vector3.new(0,0,0),
        Velocity  = Vector3.new(0,0,0),
    }
	
	return Spring
end

function SPRING:update(dt)
    local PositionDisplacement = self.Position.Target - self.Position.Current
    local PositionSpringForce = self.Position.ANGULAR_FREQUENCY ^ 2 * self.Position.Mass * PositionDisplacement
    local PositionDampingForce = -2 * math.sqrt(self.Position.Mass * self.Position.ANGULAR_FREQUENCY) * self.Position.Velocity * self.Position.DAMPING_RATIO
    local PositionAcceleration = (PositionSpringForce + PositionDampingForce) / self.Position.Mass
    
    self.Position.Velocity += PositionAcceleration * dt
    self.Position.Current += self.Position.Velocity * dt
    
    local RotationDisplacement = self.Rotation.Target - self.Rotation.Current
    local RotationSpringForce = self.Rotation.ANGULAR_FREQUENCY ^ 2 * self.Rotation.Mass * RotationDisplacement
    local RotationDampingForce = -2 * math.sqrt(self.Rotation.Mass * self.Rotation.ANGULAR_FREQUENCY) * self.Rotation.Velocity * self.Rotation.DAMPING_RATIO
    local RotationAcceleration = (RotationSpringForce + RotationDampingForce) / self.Rotation.Mass

    self.Rotation.Velocity += RotationAcceleration * dt
    self.Rotation.Current += self.Rotation.Velocity * dt
    
    return CFrame.new(self.Position.Current.X,self.Position.Current.Y,self.Position.Current.Z) * CFrame.Angles(self.Rotation.Current.X,self.Rotation.Current.Y,self.Rotation.Current.Z)
end

function SPRING:shove(cframe:CFrame)
    self.Position.Target = cframe.Position or Vector3.new(0,0,0)
    local x,y,z = cframe:ToOrientation()
    if x ~= nil then
        self.Rotation.Target = Vector3.new(x,y,z)
    else
        self.Rotation.Target = Vector3.new(0,0,0)
    end
end

return SPRING
