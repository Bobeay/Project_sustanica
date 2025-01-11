local CS = game:GetService("CollectionService")

local Hunger = script.Parent:WaitForChild("Hunger")
local Bar = script.Parent:WaitForChild("Bar")

local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")


local function Update()
	Bar.Size = UDim2.new(Hunger.Value / 100, 0, 1, 0)
end


coroutine.wrap(function()
	while task.wait(2) do
		if Hunger.Value > 0 then
			Hunger.Value -= 1
			
			if Hunger.Value == 0 then
				hum.Health = 0
			end
		end
	end
end)()


for tools, tool in pairs(CS:GetTagged("Food")) do
	tool.Activated:Connect(function()
		local newVal = math.clamp(Hunger.Value + tool.Gain.Value, 0, 100)
		
		tool.Enabled = false
		tool:Destroy()
		
		Hunger.Value = newVal
	end)
end


Hunger:GetPropertyChangedSignal("Value"):Connect(Update)