--Made by TheNexusAvenger

local TextureObjectValue = script:WaitForChild("WaterTexture")
local Texture = TextureObjectValue.Value
while not Texture do wait() Texture = TextureObjectValue.Value end
TextureObjectValue:Destroy()

script.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerScripts")

local WaterTextures = {
	"http://www.roblox.com/asset/?id=521579191",
	"http://www.roblox.com/asset/?id=521579242",
	"http://www.roblox.com/asset/?id=521579279",
	"http://www.roblox.com/asset/?id=521579406",
	"http://www.roblox.com/asset/?id=521579439",
	"http://www.roblox.com/asset/?id=521580472",
	"http://www.roblox.com/asset/?id=521580540",
	"http://www.roblox.com/asset/?id=521580580",
	"http://www.roblox.com/asset/?id=521580617",
	"http://www.roblox.com/asset/?id=521580693",
	"http://www.roblox.com/asset/?id=521580759",
	"http://www.roblox.com/asset/?id=521580803",
	"http://www.roblox.com/asset/?id=521580875",
	"http://www.roblox.com/asset/?id=521580931",
	"http://www.roblox.com/asset/?id=521580995",
	"http://www.roblox.com/asset/?id=521582355",
	"http://www.roblox.com/asset/?id=521582409",
	"http://www.roblox.com/asset/?id=521582440",
	"http://www.roblox.com/asset/?id=521582474",
	"http://www.roblox.com/asset/?id=521582518",
	"http://www.roblox.com/asset/?id=521582618",
	"http://www.roblox.com/asset/?id=521582669",
	"http://www.roblox.com/asset/?id=521582722",
	"http://www.roblox.com/asset/?id=521582808",
	"http://www.roblox.com/asset/?id=521582883",
}

while true do
	for _,TextureId in pairs(WaterTextures) do
		Texture.Texture = TextureId
		wait(0.05)
	end
end