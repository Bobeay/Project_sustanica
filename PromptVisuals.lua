local PPS = game:GetService("ProximityPromptService")
local players = game:GetService("Players")

local highlightLookupDictionary = {}
PPS.PromptShown:Connect(function(promptInstance)
	if not highlightLookupDictionary[promptInstance] then
		local highlightAdornee =  promptInstance:FindFirstAncestorWhichIsA("Model") or promptInstance:FindFirstAncestorWhichIsA("BasePart") or promptInstance:FindFirstAncestorWhichIsA("MeshPart")

		local newHighlight = Instance.new("Highlight")
		highlightLookupDictionary[promptInstance] = newHighlight
		newHighlight.DepthMode = Enum.HighlightDepthMode.Occluded
		newHighlight.FillColor = Color3.fromRGB(230,230,230)
		newHighlight.FillTransparency = 0.75
		if highlightAdornee ~= true or highlightAdornee ~= false then
			newHighlight.Adornee = highlightAdornee
		end
		newHighlight.Parent = players.LocalPlayer:WaitForChild("PlayerGui")
	end
end)

PPS.PromptHidden:Connect(function(promptInstance)
	local proximityPromptHighlight = highlightLookupDictionary[promptInstance]
	if proximityPromptHighlight then
		highlightLookupDictionary[promptInstance] = nil
		proximityPromptHighlight:Destroy()
	end
end)