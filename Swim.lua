local Player= 	game:GetService("Players").LocalPlayer
if not game:IsLoaded() then
	game.Loaded:Wait() 
end
wait(10)
local Char = 	Player.Character
local Torso = 	Char:WaitForChild("LowerTorso")
local Head = 	Char:WaitForChild("Head")
local Root= 	Char:WaitForChild("HumanoidRootPart")
local Human= 	Char:WaitForChild("Humanoid")
local Mouse= 	Player:GetMouse()
local Camera=	game.Workspace.CurrentCamera
local Input= 	game:GetService("UserInputService")
local Swim = Instance.new("BodyPosition")
Swim.maxForce = Vector3.new(0,500000,0)
Swim.P = 2000
Swim.D = 250
local Dir = Instance.new("BodyGyro")
Dir.maxTorque = Vector3.new(4000000,40000000,4000000)
local speed = 0
local SwimInput=script:WaitForChild("Changed")
local Swimmer = require(script:WaitForChild("Swimmer"))
local Has = false
local SwimmingNow = false
local Dive = false
local No = false
function Swims()
	if SwimmingNow == false then
	SwimmingNow = true
	repeat
	if Swimmer.DoDive() == true then
   Dive = true
end
local Start = Root.Position-Vector3.new(2.2,2.2,2.2)
local End = Root.Position+Vector3.new(2.2,2.2,2.2)
local reg = Region3.new(Start,End)
local yay = false
local part = nil
	for _,hit in pairs(game.Workspace:FindPartsInRegion3(reg,Char,100)) do
		if hit:findFirstChild("EnableSwiming") and hit:findFirstChild("EnableSwiming").Value then		
			yay = true
			part = hit
		end
	end			
		if yay == true and part ~= nil then	
			if 	Root.Position.Y < (part.Position.Y+(part.Size.Y)/2)-3 then
				Dive = true
			end
			Swimmer.Swimy(part,Swim,Dir,Dive)
		else
			Swimmer.Out(Swim,Dir)
			Dive = false
			No = true
		end
		if SwimInput.Jump.Value == true then
			if Dive == true then
			--Swimmer.Surface(Swim,Dir,part)
			--Dive = false
			else
			Swimmer.Out(Swim,Dir)
			Dive = false
			No = true
			end
		end
			wait()
		until No == true
		SwimmingNow = false
		No = false
		Dive = false
	end
end
SwimInput.Changed:connect(Swims)
function OBJUp(OBJ,busy)
		if OBJ.KeyCode==Enum.KeyCode.W then
			SwimInput.W.Value = 0
		elseif OBJ.KeyCode==Enum.KeyCode.S then
			SwimInput.S.Value = 0
		end
		if OBJ.KeyCode==Enum.KeyCode.A then
			SwimInput.A.Value = 0
		elseif OBJ.KeyCode==Enum.KeyCode.D then
			SwimInput.D.Value = 0
		end
		if OBJ.KeyCode==Enum.KeyCode.Q then
			SwimInput.Up.Value = 0
		elseif OBJ.KeyCode==Enum.KeyCode.E then
			SwimInput.Down.Value = 0
		end
		if SwimmingNow == true then
		SwimInput.Value = not SwimInput.Value
		end
end
function OBJDown(OBJ,busy)
		if OBJ.KeyCode==Enum.KeyCode.W then
			SwimInput.W.Value = 1
		elseif OBJ.KeyCode==Enum.KeyCode.S then
			SwimInput.S.Value = 1
		end
		if OBJ.KeyCode==Enum.KeyCode.A then
			SwimInput.A.Value = 1
		elseif OBJ.KeyCode==Enum.KeyCode.D then
			SwimInput.D.Value = 1
		end
		if OBJ.KeyCode==Enum.KeyCode.Q then
			SwimInput.Up.Value = 1
		elseif OBJ.KeyCode==Enum.KeyCode.E then
			SwimInput.Down.Value = 1
		end
		if OBJ.KeyCode == Enum.KeyCode.Space then
			if SwimmingNow == true then
			SwimInput.Jump.Value = true
			end
		end
	if SwimmingNow == true then
	SwimInput.Value = not SwimInput.Value
	end
end
Input.InputEnded:connect(OBJUp)
Input.InputBegan:connect(OBJDown)
Root.Touched:connect(function(hit)
	if hit:findFirstChild("EnableSwiming") then
		SwimInput.Value = not SwimInput.Value
	end
end)