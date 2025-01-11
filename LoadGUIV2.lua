local TweenService = game:GetService("TweenService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ContentProvider = game:GetService("ContentProvider")
local doloadedsound = true

local Assets = game:GetDescendants()

local UI = script.LoadUIV2:Clone()

local Player = game.Players.LocalPlayer 
local PlayerGui = Player:WaitForChild("PlayerGui")

ReplicatedFirst:RemoveDefaultLoadingScreen() 

local loaded = false
local cancelled = false

UI.Parent = PlayerGui 

local function createTween(object, properties, duration, easingStyle, easingDirection, delaY)
	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle[easingStyle], Enum.EasingDirection[easingDirection], 0, false, delaY)
	local tween = TweenService:Create(object, tweenInfo, properties)
	return tween
end

spawn(function()
	for i = 1, #Assets do
		if not cancelled then
			local asset = Assets[i]

			ContentProvider:PreloadAsync({asset})
			UI.Background.StatsLabel.Text = "Loading Assets: " .. "[" .. i .. "/" .. #Assets .. "]"
			UI.Background.AssetsLabel.Text = "(" .. asset.Name .. ")"
		end
	end

	loaded = true

	if doloadedsound then
		UI.Background.loadedSound:Play()
	end

	if not cancelled then
		UI.Background.StatsLabel.Text = "Finished!"
	else
		UI.Background.StatsLabel.Text = "Skipped!"
	end

	task.wait(2)

	local skipButtonTween = createTween(UI.Background.SkipButton, {Position = UDim2.new(0.434, 0,1.1, 0)}, 0.7, "Quad", "InOut", 0)
	skipButtonTween:Play()

	task.wait(0.3)

	local assetsLabelTween = createTween(UI.Background.AssetsLabel, {Position = UDim2.new(0.402, 0,1.2, 0)}, 0.7, "Quad", "InOut", 0)
	assetsLabelTween:Play()

	task.wait(0.3)

	local statsLabelTween = createTween(UI.Background.StatsLabel, {Position = UDim2.new(0.402, 0,1.2, 0)}, 0.7, "Quad", "InOut", 0)
	statsLabelTween:Play()

	task.wait(0.3)

	local backgroundTween = createTween(UI.Background, {Transparency = 1, ImageTransparency = 1}, 0.7, "Quad", "InOut", 0)
	backgroundTween:Play()

	task.wait(0.3)

	local gameImageTween = createTween(UI.Background.GameImage, {Size = UDim2.new(0.248, 0,0.42, 0), ImageTransparency = 1}, 1, "Quad", "InOut", 0)
	gameImageTween:Play()

	task.wait(1)
	UI:Destroy()

end)

wait(6.5)

if not loaded then
	local skipButtonTween = createTween(UI.Background.SkipButton, {Position = UDim2.new(0.434, 0,0.812, 0)}, 1, "Quad", "InOut", 0)
	skipButtonTween:Play()
end

UI.Background.SkipButton.Activated:Connect(function()
	cancelled = true
end)