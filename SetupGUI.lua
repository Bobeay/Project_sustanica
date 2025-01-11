-- Variables
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
script.Parent.Adornee = character:WaitForChild("Head")