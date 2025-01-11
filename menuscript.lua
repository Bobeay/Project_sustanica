local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")

Remotes.SpawnPlayer.OnServerEvent:Connect(function(Player)
	local targetPlaceId = 139684140992797-- Updated Place ID
	local success, errorMessage = pcall(function()
		TeleportService:Teleport(targetPlaceId, Player)
	end)
	if not success then
		warn("Teleport failed: " .. errorMessage)
	end
end)
