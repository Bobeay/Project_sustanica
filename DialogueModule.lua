-- [[Services]] --
local TS = game:GetService("TweenService")

local info = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local info2 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

-- Variables and stuff
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local HRP = character:FindFirstChild("HumanoidRootPart")

local npcFolder = workspace.Map.NPCs

local buttonHolder = player.PlayerGui:WaitForChild("PlayerDialogue"):WaitForChild("Background")

local option1 = buttonHolder:WaitForChild("Option1")
local option2 = buttonHolder:WaitForChild("Option2")
local option3 = buttonHolder:WaitForChild("Option3")

local dingSFX = script:WaitForChild("Ding")
local textSFX = script:WaitForChild("TextSFX")
local windSFX = script:WaitForChild("WindSFX")

for _, element in pairs(buttonHolder:GetDescendants()) do
	if element:IsA("ImageButton") or element:IsA("TextButton") then
		-- When hovering
		element.MouseEnter:Connect(function()
			element.Position = UDim2.new(0.2, 0, element.Position.Y.Scale, 0)
			script:WaitForChild("ButtonHover"):Play()
		end)

		element.MouseLeave:Connect(function()
			element.Position = UDim2.new(0.15, 0, element.Position.Y.Scale, 0)
			script:WaitForChild("ButtonHover"):Play()
		end)

		-- When clicking
		element.MouseButton1Down:Connect(function()
			script:WaitForChild("ButtonHover"):Play()
		end)
		
		element.MouseButton1Up:Connect(function()
			script:WaitForChild("ButtonClick"):Play()
		end)
	end
end

local DialogueModule = {}

local function startDialogue(NPC)
	local NPCHRP = NPC:WaitForChild("HumanoidRootPart")
	local dialogueGUI = NPCHRP:FindFirstChild("DialogueGUI")
	local dialogueText = dialogueGUI.Speech
	
	dialogueText.Text = "..."
	dialogueGUI.Enabled = true
	dialogueText.Visible = true
	dingSFX:Play()
	local tween = TS:Create(dialogueGUI.GlowBG, info2, {ImageTransparency = 0.5})
	tween:Play()
	
	task.wait(0.3)
end

local function stopDialogue(NPC)
	local NPCHRP = NPC:WaitForChild("HumanoidRootPart")
	local dialogueGUI = NPCHRP:FindFirstChild("DialogueGUI")
	local dialogueText = dialogueGUI.Speech
	
	dialogueText.Visible = false
	
	local tween = TS:Create(dialogueGUI.GlowBG, info2, {ImageTransparency = 1})
	tween:Play()
	
	task.wait(0.3)
	dialogueGUI.Enabled = false
end

local function showOptions(dialogueInfo, currentTime)
	local holderTween = TS:Create(buttonHolder, info, {Position = UDim2.new(0,0,0,0)})
	holderTween:Play()
	
	if currentTime == 1 then
		option1.Text = "[1] "..dialogueInfo.Introduction1.Value
		option2.Text = "[2] "..dialogueInfo.Introduction2.Value
		option3.Text = "[3] "..dialogueInfo.Introduction3.Value
	elseif currentTime == 10 then
		option1.Text = "[1] "..dialogueInfo.Introduction1.Response1.Value
		option2.Text = "[2] "..dialogueInfo.Introduction1.Response2.Value
		option3.Text = "[3] "..dialogueInfo.Introduction1.Response3.Value
	elseif currentTime == 20 then
		option1.Text = "[1] "..dialogueInfo.Introduction2.Response1.Value
		option2.Text = "[2] "..dialogueInfo.Introduction2.Response2.Value
		option3.Text = "[3] "..dialogueInfo.Introduction2.Response3.Value
	elseif currentTime == 30 then
		option1.Text = "[1] "..dialogueInfo.Introduction3.Response1.Value
		option2.Text = "[2] "..dialogueInfo.Introduction3.Response2.Value
		option3.Text = "[3] "..dialogueInfo.Introduction3.Response3.Value
	end
end

local function hideOptions()
	local holderTween = TS:Create(buttonHolder, info2, {Position = UDim2.new(-1.5, 0, 0, 0)})
	holderTween:Play()
	task.wait(0.3)
	option1.Text = ""
	option2.Text = ""
	option3.Text = ""
end

local function loadDialogue(text, interval, NPC)
	local NPCHRP = NPC:WaitForChild("HumanoidRootPart")
	local dialogueGUI = NPCHRP:FindFirstChild("DialogueGUI")
	local dialogueText = dialogueGUI.Speech
	
	dialogueText.Text = ""
	dialogueText.Visible = true
	for i, letter in pairs(string.split(text, "")) do
		dialogueText.Text ..= letter
		textSFX:Play()
		if letter == "." or letter == "?" or letter == "!" or letter == "," then
			task.wait(interval * 10)
		else
			task.wait(interval)
		end
	end
	task.wait(0.25)
end

function DialogueModule:Activate(dialogueInfo, prompt)
	startDialogue(prompt.Parent.Parent)
	showOptions(dialogueInfo, 1)
	
	-- Connections
	local connection1
	local connection2
	local connection3
	
	local clicked = false
	connection1 = option1.MouseButton1Click:Connect(function()
		if clicked then return end
		clicked = true
		
		hideOptions()
		loadDialogue(dialogueInfo.Introduction1.Speech.Value, dialogueInfo.Interval, prompt.Parent.Parent)
		showOptions(dialogueInfo, 10)	
		
		-- Connections
		local connection11
		local connection22
		local connection33

		local clicked = false
		connection11 = option1.MouseButton1Click:Connect(function()
			if clicked then return end
			clicked = true

			hideOptions()
			loadDialogue(dialogueInfo.Introduction1.Response1.Speech.Value, dialogueInfo.Interval, prompt.Parent.Parent)
			stopDialogue(prompt.Parent.Parent)
			
			prompt.Enabled = true
			HRP.Anchored = false
			connection1:Disconnect()
			connection11:Disconnect()
		end)

		connection22 = option2.MouseButton1Click:Connect(function()
			if clicked then return end
			clicked = true

			hideOptions()
			loadDialogue(dialogueInfo.Introduction1.Response2.Speech.Value, dialogueInfo.Interval, prompt.Parent.Parent)
			stopDialogue(prompt.Parent.Parent)
			
			prompt.Enabled = true
			HRP.Anchored = false
			connection1:Disconnect()
			connection22:Disconnect()
		end)

		connection33 = option3.MouseButton1Click:Connect(function()
			if clicked then return end
			clicked = true

			hideOptions()
			loadDialogue(dialogueInfo.Introduction1.Response3.Speech.Value, dialogueInfo.Interval, prompt.Parent.Parent)
			stopDialogue(prompt.Parent.Parent)
			
			prompt.Enabled = true
			HRP.Anchored = false
			connection1:Disconnect()
			connection33:Disconnect()
		end)
	end)
	
	connection2 = option2.MouseButton1Click:Connect(function()
		if clicked then return end
		clicked = true
		
		hideOptions()
		loadDialogue(dialogueInfo.Introduction2.Speech.Value, dialogueInfo.Interval, prompt.Parent.Parent)
		showOptions(dialogueInfo, 20)
		
		-- Connections
		local connection11
		local connection22
		local connection33

		local clicked = false
		connection11 = option1.MouseButton1Click:Connect(function()
			if clicked then return end
			clicked = true

			hideOptions()
			loadDialogue(dialogueInfo.Introduction2.Response1.Speech.Value, dialogueInfo.Interval, prompt.Parent.Parent)
			stopDialogue(prompt.Parent.Parent)

			prompt.Enabled = true
			HRP.Anchored = false
			connection2:Disconnect()
			connection11:Disconnect()
		end)

		connection22 = option2.MouseButton1Click:Connect(function()
			if clicked then return end
			clicked = true

			hideOptions()
			loadDialogue(dialogueInfo.Introduction2.Response2.Speech.Value, dialogueInfo.Interval, prompt.Parent.Parent)
			stopDialogue(prompt.Parent.Parent)

			prompt.Enabled = true
			HRP.Anchored = false
			connection2:Disconnect()
			connection22:Disconnect()
		end)

		connection33 = option3.MouseButton1Click:Connect(function()
			if clicked then return end
			clicked = true

			hideOptions()
			loadDialogue(dialogueInfo.Introduction2.Response3.Speech.Value, dialogueInfo.Interval, prompt.Parent.Parent)
			stopDialogue(prompt.Parent.Parent)

			prompt.Enabled = true
			HRP.Anchored = false
			connection2:Disconnect()
			connection33:Disconnect()
		end)
	end)
	
	connection3 = option3.MouseButton1Click:Connect(function()
		if clicked then return end
		clicked = true
		
		hideOptions()
		loadDialogue(dialogueInfo.Introduction3.Speech.Value, dialogueInfo.Interval, prompt.Parent.Parent)
		
		if dialogueInfo.ExtendedGoodbye then
			showOptions(dialogueInfo, 30)

			-- Connections
			local connection11
			local connection22
			local connection33

			local clicked = false
			connection11 = option1.MouseButton1Click:Connect(function()
				if clicked then return end
				clicked = true

				hideOptions()
				loadDialogue(dialogueInfo.Introduction3.Response1.Speech.Value, dialogueInfo.Interval, prompt.Parent.Parent)
				stopDialogue(prompt.Parent.Parent)

				prompt.Enabled = true
				HRP.Anchored = false
				connection3:Disconnect()
				connection11:Disconnect()
			end)

			connection22 = option2.MouseButton1Click:Connect(function()
				if clicked then return end
				clicked = true

				hideOptions()
				loadDialogue(dialogueInfo.Introduction3.Response2.Speech.Value, dialogueInfo.Interval, prompt.Parent.Parent)
				stopDialogue(prompt.Parent.Parent)

				prompt.Enabled = true
				HRP.Anchored = false
				connection3:Disconnect()
				connection22:Disconnect()
			end)

			connection33 = option3.MouseButton1Click:Connect(function()
				if clicked then return end
				clicked = true

				hideOptions()
				loadDialogue(dialogueInfo.Introduction3.Response3.Speech.Value, dialogueInfo.Interval, prompt.Parent.Parent)
				stopDialogue(prompt.Parent.Parent)

				prompt.Enabled = true
				HRP.Anchored = false
				connection3:Disconnect()
				connection33:Disconnect()
			end)
		else
			stopDialogue(prompt.Parent.Parent)

			prompt.Enabled = true
			HRP.Anchored = false
			connection3:Disconnect()
		end
	end)
end

return DialogueModule