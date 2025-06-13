-- dragon_spawner.lua

local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
local root = player.Character:WaitForChild("HumanoidRootPart")

-- Remove existing dragon
if workspace:FindFirstChild("HugeRedDragon") then
    workspace.HugeRedDragon:Destroy()
end

-- Create dragon part
local dragon = Instance.new("Part")
dragon.Name = "HugeRedDragon"
dragon.Size = Vector3.new(8, 8, 12)
dragon.Color = Color3.fromRGB(255, 0, 0)
dragon.Material = Enum.Material.Neon
dragon.Anchored = true
dragon.CFrame = root.CFrame * CFrame.new(5, 0, -10)
dragon.Transparency = 1
dragon.Parent = workspace

-- Glow effect
local glow = Instance.new("PointLight", dragon)
glow.Brightness = 10
glow.Range = 20
glow.Color = Color3.fromRGB(255, 60, 0)

-- Fire particles
local fire = Instance.new("ParticleEmitter")
fire.Texture = "rbxassetid://243660564"
fire.Color = ColorSequence.new(Color3.fromRGB(255,150,0), Color3.fromRGB(255,0,0))
fire.Rate = 100
fire.Lifetime = NumberRange.new(1, 1.5)
fire.Speed = NumberRange.new(2, 4)
fire.Parent = dragon

-- Fade-in and rise
local tweenIn = TweenService:Create(
    dragon,
    TweenInfo.new(1.5, Enum.EasingStyle.Bounce),
    { Transparency = 0, CFrame = dragon.CFrame * CFrame.new(0, 5, 0) }
)
tweenIn:Play()

-- Flying animation loop
tweenIn.Completed:Connect(function()
    spawn(function()
        while dragon and dragon.Parent do
            local t1 = TweenService:Create(
                dragon,
                TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                { CFrame = dragon.CFrame * CFrame.Angles(0, math.rad(20), 0) * CFrame.new(0, 2, 0) }
            )
            t1:Play()
            t1.Completed:Wait()

            local t2 = TweenService:Create(
                dragon,
                TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                { CFrame = dragon.CFrame * CFrame.Angles(0, math.rad(-20), 0) * CFrame.new(0, -2, 0) }
            )
            t2:Play()
            t2.Completed:Wait()
        end
    end)
end)
