local module = {}
local Camera = game.Workspace.CurrentCamera
local Player = game.Players.LocalPlayer
local Char = Player.Character
local Human = Char:WaitForChild("Humanoid")
local Root = Char:WaitForChild("HumanoidRootPart")
local SwimInput=script.Parent:WaitForChild("Changed")
local Anim = require(script.Parent:WaitForChild("Animate"))
local Bubbles = script:WaitForChild("Bubbles")
Bubbles.Parent = Root
Bubbles.Enabled = false
function module.Calc(Dived)
	local Vert= SwimInput.W.Value-SwimInput.S.Value
	local Dia =	SwimInput.A.Value-SwimInput.D.Value
	if Vert == 0 and Dia == 0 then
		Anim.PlayNAnim("Swimming","Idle",.5)
	else
		if Dived == false then
		Anim.PlayNAnim("Swimming","Surface",.5)
		else
		Anim.PlayNAnim("Swimming","Under",.5)
		end
	end
end
function module.Surface(Swim,Dir,Water)
	Swim.position = Vector3.new(0,Water.Position.Y+(Water.Size.Y)/2,0)
	Dir.Parent = nil
	SwimInput.Jump.Value = false
end
function module.Out(Swim,Dir)
	Dir.Parent = nil
	if SwimInput.Jump.Value == true then
		Root.Velocity = Root.Velocity + Vector3.new(0,60,0)
	end
	Human.PlatformStand = false
	Swim.maxForce = Vector3.new(0,500000,0)
	Swim.Parent = nil
	SwimInput.Jump.Value = false
	Anim.Stop()
	local k = Instance.new("BodyGyro")
	k.Parent = Root
	k.maxTorque = Vector3.new(0,400000,0)
	k.cframe = Root.CFrame
	game:GetService("Debris"):AddItem(k,.5)
	Bubbles.Enabled = false
end

function module.Swimy(Water,Swim,Dir,IsUnder)
	Swim.Parent = Root
	if IsUnder == true then
	Human.PlatformStand = true
	local CamLook = Camera.CoordinateFrame.lookVector*2
	local Rot = Camera.CoordinateFrame-Camera.CoordinateFrame.p
	local Vert = SwimInput.W.Value-SwimInput.S.Value
	local Dia=SwimInput.A.Value-SwimInput.D.Value
	Swim.maxForce = Vector3.new(500000,500000,500000)
	Swim.position = (Root.CFrame*CFrame.new(-(Dia)*2,0,-(Vert)*2)).p+Vector3.new(0,CamLook.Y,0)
	--Swim.position = Root.Position+Vector3.new(0,CamLook.Y,0)
	Dir.Parent = Root
	Dir.cframe = Rot+Root.Position
	Bubbles.Enabled = true
	else
	Swim.maxForce = Vector3.new(0,500000,0)
	Human.PlatformStand = false
	Dir.Parent = nil
	Swim.position = Vector3.new(0,Water.Position.Y+(Water.Size.Y)/2,0)
	Bubbles.Enabled = false
	end
	module.Calc(IsUnder)
end
function module.DoDive()
	local CamLook = Camera.CoordinateFrame.lookVector*2
	if CamLook.Y <=-1.6 then
		return true
	else
		return false
	end
end
return module
