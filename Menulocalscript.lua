local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui") 

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

local MenuGUIs = StarterGui.Menu

local Credits = MenuGUIs.Credits:Clone()
local MainMenu = MenuGUIs.MainMenu:Clone()

Credits.Parent = PlayerGui
MainMenu.Parent = PlayerGui

local Camera = workspace.CurrentCamera
Camera.CameraType = Enum.CameraType.Scriptable

local GoTo = Instance.new("StringValue")
GoTo.Value = "MainMenu"
GoTo.Name = "GoTo"
GoTo.Parent = Camera

local Menu = workspace.Menu	
local CameraParts = Menu.CameraParts

local Remotes = ReplicatedStorage.Remotes

Camera.CFrame = CameraParts[GoTo.Value].CFrame
RunService.RenderStepped:Connect(function()
	local GoToPosition = CameraParts[GoTo.Value].CFrame
	GoToPosition += Vector3.new( math.cos(tick() * 5 ) * .1, math.sin(tick() * 5 ) * .1, math.cos(tick() * 5 ) * .1 )

	Camera.CFrame = Camera.CFrame:Lerp(GoToPosition, .1)
end)	


--// buttons \\--

local StartBtn = MainMenu.Start
local CreditsBtn = MainMenu.Credits
local BackBtn =  Credits.MainMenu

local function regButton(Button: TextButton)
	Button.MouseButton1Click:Connect(function()
		GoTo.Value = Button.Name 
	end)
end


StartBtn.MouseButton1Click:Connect(function()
	Remotes.SpawnPlayer:FireServer()
end)

regButton(CreditsBtn)
regButton(BackBtn)
