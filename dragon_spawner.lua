-- Red Dragon Spawner Script for Grow a Garden
-- By YourSenpaiii

-- Settings
local dragonColor = Color3.fromRGB(255, 0, 0)

-- Create Dragon model
local dragon = Instance.new("Model")
dragon.Name = "RedDragon"

-- Body
local body = Instance.new("Part")
body.Size = Vector3.new(6, 4, 10)
body.Position = Vector3.new(0, 10, 0)
body.BrickColor = BrickColor.new("Bright red")
body.Anchored = false
body.Name = "Body"
body.Parent = dragon

-- Wings
local wingLeft = Instance.new("Part")
wingLeft.Size = Vector3.new(1, 8, 16)
wingLeft.Position = Vector3.new(-4, 10, 0)
wingLeft.BrickColor = BrickColor.new("Bright red")
wingLeft.Anchored = false
wingLeft.Name = "LeftWing"
wingLeft.Parent = dragon

local wingRight = wingLeft:Clone()
wingRight.Position = Vector3.new(4, 10, 0)
wingRight.Name = "RightWing"
wingRight.Parent = dragon

-- Fire Particle
local fire = Instance.new("ParticleEmitter")
fire.Texture = "rbxasset://textures/particles/fire_main.dds"
fire.Rate = 25
fire.Lifetime = NumberRange.new(0.5, 1)
fire.Speed = NumberRange.new(2, 5)
fire.Parent = body

-- Animation simulation
local RunService = game:GetService("RunService")
RunService.Heartbeat:Connect(function()
    local t = tick()
    wingLeft.CFrame = CFrame.new(wingLeft.Position) * CFrame.Angles(0, 0, math.sin(t * 5) * 0.5)
    wingRight.CFrame = CFrame.new(wingRight.Position) * CFrame.Angles(0, 0, -math.sin(t * 5) * 0.5)
    body.Position = body.Position + Vector3.new(0, math.sin(t * 2) * 0.03, 0)
end)

-- Parent to Workspace
dragon.Parent = workspace
