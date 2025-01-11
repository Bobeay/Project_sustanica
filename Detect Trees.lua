local Tool = script.Parent


local trees = workspace:GetDescendants()
for _, tree in ipairs(trees) do
	if tree.Name == "Tree" then
		local ProximityPrompt = tree:FindFirstChild("MAIN"):FindFirstChild("Trunk"):FindFirstChild("CutWood")
		if ProximityPrompt then
			
			Tool.Equipped:Connect(function()
				ProximityPrompt.Enabled = true
			end)
			Tool.Unequipped:Connect(function()
				ProximityPrompt.Enabled = false
			end)
		end
	end
end
