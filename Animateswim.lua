local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character
local Torso = Character.LowerTorso
local Root = Character.HumanoidRootPart
local Head = Character.Head
local Human = Character.Humanoid
local NormAnim = {["CAT"]=nil;["CAN"]="";["CA"]=nil;["CAS"]=1;["CKF"]=nil}
local Animations={}
function SortAnims()
	local Anims = script:GetChildren()
	for i =1,#Anims do
			local Kids = Anims[i]:GetChildren()
			local Folder = {}
			for y=1,#Kids do
				Folder[Kids[y].Name]=Kids[y]
				wait()
			end
			Animations[Anims[i].Name]=Folder
	end
end
SortAnims()
local module = 		{}

function module.NReachFrame(Frame)
	local Repeat = NormAnim.CAN
	if Frame == "End" then
		
	end
	if Frame == "Sound" then
	end
end

function module.Stop()
	local Folder = NormAnim
		if Folder.CAT ~= nil then
			Folder.CAT:Stop(0)
			Folder.CAT:Destroy()
		end
	if Folder.CKF ~= nil then
		Folder.CKF:disconnect()
		Folder.CKF=nil
	end
end
	
function module.NAnimSpeed(speed)
	if speed ~= NormAnim.CAS then
		NormAnim.CAS = speed
		NormAnim.CAT:AdjustSpeed(NormAnim.CAS)
	end
end
if Character:FindFirstChild("Animate") then
	local CharAnim = Character:FindFirstChild("Animate")
	if CharAnim:FindFirstChild("swim") and CharAnim:FindFirstChild("swim"):FindFirstChild("Swim") then
		script:WaitForChild("Swimming").Under.AnimationId = CharAnim:FindFirstChild("swim"):FindFirstChild("Swim").AnimationId
	end
	if CharAnim:FindFirstChild("swim") and CharAnim:FindFirstChild("swim"):FindFirstChild("Swim") then
		script:WaitForChild("Swimming").Idle.AnimationId = CharAnim:FindFirstChild("swim"):FindFirstChild("Swim").AnimationId
	end
	if CharAnim:FindFirstChild("swimidle") and CharAnim:FindFirstChild("swimidle"):FindFirstChild("Swimidle") then
		script:WaitForChild("Swimming").Idle.AnimationId = CharAnim:FindFirstChild("swimidle"):FindFirstChild("Swimidle").AnimationId
	end
end
function module.PlayNAnim(Anim,Type,Trans)
	local Folder = NormAnim
	if Animations[Anim][Type] then 
	local A = Animations[Anim][Type]
		if Folder.CA ~= A then
			if Folder.CAT ~= nil then
				Folder.CAT:Stop(Trans)
				Folder.CAT:Destroy()
			end
			Folder.CAS = 1
			Folder.CAT = Human:LoadAnimation(A)
			Folder.CAT:Play()
			Folder.CA = A
			if Folder.CKF ~= nil then
				Folder.CKF:disconnect()
				Folder.CKF=nil
			end
			Folder.CKF = Folder.CAT.KeyframeReached:connect(module.NReachFrame)
		end
	else
		print('Requested animation '..Anim..'/'..Type..' Is not available')
	end	
end

function module.Ready()
	return true
end

return module