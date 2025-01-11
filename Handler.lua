local UIS = game:GetService('UserInputService')



local Bar = script.Parent:WaitForChild('Background'):WaitForChild('Bar')



local player = game.Players.LocalPlayer



local NormalWalkSpeed = 16

local NewWalkSpeed = 30



local power = 10



local sprinting = false



repeat wait() until game.Players.LocalPlayer.Character



local character = player.Character



UIS.InputBegan:connect(function(key, gameProcessed)

	if key.KeyCode == Enum.KeyCode.Q and gameProcessed == false then

		character.Humanoid.WalkSpeed = NewWalkSpeed

		sprinting = true

		while power > 0 and sprinting do

			power = power - .1

			Bar:TweenSize(UDim2.new(power / 10, 0, 1, 0), 'Out', 'Quint', .1, true)

			--Bar.BackgroundColor3 = Bar.BackgroundColor3:lerp(Color3.fromRGB(255, 42, 42), 0.001)

			wait()

			if power <= 0 then

				character.Humanoid.WalkSpeed = NormalWalkSpeed

			end

		end

	end

end)



UIS.InputEnded:connect(function(key, gameProcessed)

	if key.KeyCode == Enum.KeyCode.Q and gameProcessed == false then

		character.Humanoid.WalkSpeed = NormalWalkSpeed

		sprinting = false

		while power < 10 and not sprinting do

			power = power + .03

			Bar:TweenSize(UDim2.new(power / 10, 0, 1, 0), 'Out', 'Quint', .1, true)

			--Bar.BackgroundColor3 = Bar.BackgroundColor3:lerp(Color3.fromRGB(255, 166, 11), 0.001)

			wait()

			if power <= 0 then

				character.Humanoid.WalkSpeed = NormalWalkSpeed

			end

		end

	end

end)