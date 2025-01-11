local Tool = script.Parent
local Plr = game.Players.LocalPlayer
local HungerVal = Plr:WaitForChild("HungerVal")
local Used = false

Tool.Activated:Connect(function()
	if not Used then
		Used = true
		HungerVal.Value = HungerVal.Value +10
		if HungerVal.Value > 100 then
			HungerVal.Value = 100
		end
		Tool:Destroy()
	end
end)
