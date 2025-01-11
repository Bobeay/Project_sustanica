
local ProximityPrompt = workspace.Tree.MAIN.Trunk.CutWood -- Need to put every tree in there
local ProximityPrompt2 = workspace.Tree2.MAIN.Trunk.CutWood
local Tool = script.Parent

Tool.Equipped:Connect(function()
	ProximityPrompt.Enabled = true -- Need to put every tree in there too
	ProximityPrompt2.Enabled = true
end)
Tool.Unequipped:Connect(function()
	ProximityPrompt.Enabled = false -- Need to put every tree in there too too
	ProximityPrompt2.Enabled = false
end)