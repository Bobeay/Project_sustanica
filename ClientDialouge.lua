-- Services
local TS = game:GetService("TweenService")
local info = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

-- Variables and stuff
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local HRP = character:WaitForChild("HumanoidRootPart")

local dialogueModule = require(script:WaitForChild("DialogueModule"))
local npcFolder = workspace.Map.NPCs.Dialogue
for i, NPC in pairs(npcFolder:GetChildren()) do
	if NPC:FindFirstChildOfClass("Humanoid") then
		local proximityPrompt = NPC:WaitForChild("HumanoidRootPart"):FindFirstChild("ProximityPrompt")
		proximityPrompt.Triggered:Connect(function()
			local NPCInfo = NPC:FindFirstChild("DialogueInfo")
			local dialogueInfo = {
				["Interval"] = NPCInfo:FindFirstChild("Interval").Value,
				["Introduction1"] = NPCInfo:FindFirstChild("Introduction1"),
				["Introduction2"] = NPCInfo:FindFirstChild("Introduction2"),
				["Introduction3"] = NPCInfo:FindFirstChild("Introduction3"),
				["Response1"] = NPCInfo:FindFirstChild("Response1"),
				["Response2"] = NPCInfo:FindFirstChild("Response2"),
				["Response3"] = NPCInfo:FindFirstChild("Response3"),
				["ExtendedGoodbye"] = NPCInfo:FindFirstChild("ExtendedGoodbye").Value
			}
			proximityPrompt.Enabled = false
			HRP.Anchored = true
			dialogueModule:Activate(dialogueInfo, proximityPrompt)
		end)
	end
end