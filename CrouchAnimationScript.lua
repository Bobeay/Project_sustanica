local UIS = game:GetService("UserInputService")

local Crouching = false
local Character = script.Parent

local Humanoid = Character:WaitForChild("Humanoid")

local Animation = script.CrouchAnimation


UIS.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.C then
		if Crouching == false then
			Crouching = true
			LoadedAnimation = Humanoid:LoadAnimation(Animation)
			LoadedAnimation:Play()

			Humanoid.HipHeight -= 1.2
			Humanoid.WalkSpeed = 8
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
		else
			Crouching = false
			LoadedAnimation:Stop()

			Humanoid.HipHeight += 1.2
			Humanoid.WalkSpeed = 16
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
		end
	end
end)