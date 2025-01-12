local Part = script.Parent.Parent
local Prompt = script.Parent

Prompt.Triggered:Connect(function(player)
	if player then
		local objfolder = player:WaitForChild("ObjectiveFolder")
		local thingrequired = objfolder:WaitForChild("Thing Required")
		local amtcollected = thingrequired:WaitForChild("Amount Collected")
		
		if objfolder and thingrequired and amtcollected then
			amtcollected.Value = amtcollected.Value + 1
			
			Part:Destroy()
		end
	end
end)