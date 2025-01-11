local UIS = game:GetService('UserInputService')
local Player = game.Players.LocalPlayer
local Character = Player.Character

UIS.InputBegan:connect(function(input)
	if input.KeyCode == Enum.KeyCode.Q then
		Character.Humanoid.WalkSpeed = 35
		local Anim = Instance.new('Animation')
		Anim.AnimationId = 'rbxassetid://113694594471377'
		PlayAnim = Character.Humanoid:LoadAnimation(Anim)
		PlayAnim:Play()
	end
end)

UIS.InputEnded:connect(function(input)
	if input.KeyCode == Enum.KeyCode.Q then
		Character.Humanoid.WalkSpeed = 16
		PlayAnim:Stop()
	end
end)
