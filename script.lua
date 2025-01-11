local ss = game:GetService("ServerStorage")
local healthBarGui = ss.HealthBar

local char = script.Parent
local human = char:WaitForChild("Humanoid")
local healthBarClone = healthBarGui:Clone()

healthBarClone.Parent = char
healthBarClone.Adornee = char:WaitForChild("Head")

human.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
human.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff

healthBarClone.MainHealth.healthChnged.Disabled = false