local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

-- Clean old dragons
for _,v in pairs(workspace:GetChildren()) do
    if v.Name:match("HugeRedDragon") then v:Destroy() end
end

-- Build dragon model
local dragon = Instance.new("Model", workspace)
dragon.Name = "HugeRedDragon"

local body = Instance.new("Part")
body.Name = "Body"
body.Size = Vector3.new(8,5,12)
body.Anchored = true
body.Material = Enum.Material.Neon
body.Color = Color3.fromRGB(255,0,0)
body.CFrame = root.CFrame * CFrame.new(0,10,-5)
body.Parent = dragon

-- Fire & glow
local fire = Instance.new("ParticleEmitter", body)
fire.Texture = "rbxassetid://243660564"
fire.Color = ColorSequence.new(Color3.new(1,0.6,0), Color3.new(1,0,0))
fire.Rate = 200
fire.Lifetime = NumberRange.new(0.5,1)
fire.Speed = NumberRange.new(2,4)

local glow = Instance.new("PointLight", body)
glow.Color = Color3.fromRGB(255,80,0)
glow.Brightness = 6
glow.Range = 15

-- Roar sound
local sound = Instance.new("Sound", body)
sound.SoundId = "rbxassetid://1837635124"  -- Dragon roar sound
sound.Volume = 2
sound.Looped = false
sound:Play()

-- Fade-in animation
body.Transparency = 1
local tweenInfo = TweenInfo.new(1.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
TweenService:Create(body, tweenInfo, {
    Transparency = 0,
    CFrame = body.CFrame * CFrame.new(0,3,0)
}):Play()

-- Flying loop
spawn(function()
    while dragon.Parent do
        TweenService:Create(body, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            CFrame = body.CFrame * CFrame.Angles(0, math.rad(45), 0) * CFrame.new(0,3,0)
        }):Play()
        wait(2)
    end
end)

-- Spawn/despawn button
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local btn = Instance.new("TextButton", gui)
btn.Size = UDim2.new(0,150,0,50)
btn.Position = UDim2.new(0.05,0,0.8,0)
btn.Text = "Toggle Dragon"

btn.MouseButton1Click:Connect(function()
    if dragon.Parent then
        dragon:Destroy()
    else
        dragon.Parent = workspace
    end
end)

print("🔥 HugeRedDragon script loaded.")
