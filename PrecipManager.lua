wait(1)
print("[Redon Tech Weather System]: Loading PrecipManager, if anything errors please contact support.")
math.randomseed(tick())

local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera
local TweenService = game:GetService("TweenService")

local Weather = game.ReplicatedStorage.WeatherResources
local WeatherFolder = Weather.Weather
local Current = WeatherFolder.Current
local Parts = Weather.Parts

local Close = { 167060276, 236328564, 236328548, 236328533 }
local Medium = { 167060296, 236328809, 236328781, 236328758 }
local Far = { 167060342, 167060366, 236328734, 236328715, 236328701, 236328669, 236328595 }


local Clouds
if workspace.Terrain:FindFirstChild("Clouds") then
	Clouds = workspace.Terrain.Clouds
else
	Clouds = Instance.new("Clouds")
end

local RainModule = require(Weather.Modules.PrecipitationHandlers.Rain)
local SnowModule = require(Weather.Modules.PrecipitationHandlers.Snow)
local HailModule = require(Weather.Modules.PrecipitationHandlers.Hail)


Clouds.Cover = 0.3
Clouds.Density = 0.5
Clouds.Parent = workspace.Terrain



function SetPrecip()
	local succes, message = pcall(function()
		if Current.Weather.Value == "Drizzle" then
			
			RainModule:SetIntensityRatio(0.100)
			RainModule:Enable()
			HailModule:Disable()
			SnowModule:Disable()
		elseif Current.Weather.Value == "Showers" then
			RainModule:SetIntensityRatio(0.200)
			RainModule:Enable()
			HailModule:Disable()
			SnowModule:Disable()
		elseif Current.Weather.Value == "Rain" then
			RainModule:SetIntensityRatio(0.300)
			RainModule:Enable()
			HailModule:Disable()
			SnowModule:Disable()
		elseif Current.Weather.Value == "Heavy Rain" or Current.Weather.Value == "Thunderstorms" then
			RainModule:SetIntensityRatio(0.400)
			RainModule:Enable()
			HailModule:Disable()
			SnowModule:Disable()
		elseif Current.Weather.Value == "Strong Thunderstorms" then
			RainModule:SetIntensityRatio(0.500)
			RainModule:Enable()
			HailModule:SetIntensityRatio(0.250)
			HailModule:Enable()
			SnowModule:Disable()
		elseif Current.Weather.Value == "Flurries" then
			RainModule:Disable()
			HailModule:Disable()
			SnowModule:SetIntensityRatio(0.100)
			SnowModule:Enable()
		elseif Current.Weather.Value == "Snow Showers" then
			RainModule:Disable()
			HailModule:Disable()
			SnowModule:SetIntensityRatio(0.200)
			SnowModule:Enable()
		elseif Current.Weather.Value == "Snow" then
			RainModule:Disable()
			HailModule:Disable()
			SnowModule:SetIntensityRatio(0.300)
			SnowModule:Enable()
		elseif Current.Weather.Value == "Heavy Snow" then
			RainModule:Disable()
			HailModule:Disable()
			SnowModule:SetIntensityRatio(0.400)
			SnowModule:Enable()
		elseif Current.Weather.Value == "Freezing Drizzle" then
			RainModule:SetIntensityRatio(0.100)
			RainModule:Enable()
			HailModule:Disable()
			SnowModule:SetIntensityRatio(0.100)
			SnowModule:Enable()
		elseif Current.Weather.Value == "Rain / Snow Showers" then
			RainModule:SetIntensityRatio(0.200)
			RainModule:Enable()
			HailModule:Disable()
			SnowModule:SetIntensityRatio(0.200)
			SnowModule:Enable()
		elseif Current.Weather.Value == "Rain / Snow" then
			RainModule:SetIntensityRatio(0.300)
			RainModule:Enable()
			HailModule:Disable()
			SnowModule:SetIntensityRatio(0.300)
			SnowModule:Enable()
		elseif Current.Weather.Value == "Heavy Rain / Snow" then
			RainModule:SetIntensityRatio(0.400)
			RainModule:Enable()
			HailModule:Disable()
			SnowModule:SetIntensityRatio(0.400)
			SnowModule:Enable()
		else
			RainModule:Disable()
			HailModule:Disable()
			SnowModule:Disable()
		end
	end)

	if not succes then -- Reload modulese because of ACS (most likely cause)
		warn(
			"REDON TECH WEATHER SYSTEM HAS RELOADED ITS RAIN MODULES THIS MAY CAUSE LAG PLEASE **REMOVE ACS** TO PREVENT THIS ISSUE | Error: ",
			message
		)
		local original = Weather.Modules.PrecipitationHandlers
		local clone = original:Clone()
		original:Destroy()
		clone.Parent = Weather.Modules

		RainModule = require(clone.Rain)
		SnowModule = require(clone.Snow)
		HailModule = require(clone.Hail)
	end
end

function Precipitate()
	if not Clouds then 
		Clouds = Instance.new("Clouds")
		Clouds.Parent = workspace.Terrain
	end
	wait(1)
	if
		Current.Weather.Value == "Drizzle"
		or Current.Weather.Value == "Showers"
		or Current.Weather.Value == "Rain"
		or Current.Weather.Value == "Heavy Rain"
		or Current.Weather.Value == "Thunderstorms"
		or Current.Weather.Value == "Strong Thunderstorms"
		or Current.Weather.Value == "Flurries"
		or Current.Weather.Value == "Snow Showers"
		or Current.Weather.Value == "Snow"
		or Current.Weather.Value == "Heavy Snow"
		or Current.Weather.Value == "Freezing Drizzle"
		or Current.Weather.Value == "Rain / Snow Showers"
		or Current.Weather.Value == "Rain / Snow"
		or Current.Weather.Value == "Heavy Rain / Snow"
		or Current.Weather.Value == "Cloudy"
	then
		local TI = TweenInfo.new(5)
		local Tween = TweenService:Create(Clouds, TI, { Cover = 1, Density = 1 })
		Tween:Play()
	elseif Current.Weather.Value == "Partly Cloudy" then
		local TI = TweenInfo.new(5)
		local Tween = TweenService:Create(Clouds, TI, { Cover = 0.3, Density = 0.5 })
		Tween:Play()
	elseif Current.Weather.Value == "Mostly Cloudy" then
		local TI = TweenInfo.new(5)
		local Tween = TweenService:Create(Clouds, TI, { Cover = 0.5, Density = 0.5 })
		Tween:Play()
	else
		local TI = TweenInfo.new(5)
		local Tween = TweenService:Create(Clouds, TI, { Cover = 0, Density = 0 })
		Tween:Play()
	end

	SetPrecip()
end

RainModule:SetCollisionMode(RainModule.CollisionMode.Function, function(p)
	return p.Transparency <= 0.97
end)
SnowModule:SetCollisionMode(RainModule.CollisionMode.Function, function(p)
	return p.Transparency <= 0.97
end)
HailModule:SetCollisionMode(RainModule.CollisionMode.Function, function(p)
	return p.Transparency <= 0.97
end)

SetPrecip()

Precipitate()

Current.Weather.Changed:Connect(Precipitate)

game.Workspace.ChildAdded:Connect(function(child)
	if child.Name == "Lightning" then
		local Id
		if player.Character:FindFirstChild("Torso") then
			if (player.Character.Torso.Position - child:WaitForChild("Lightning").Position).magnitude < 1000 then
				Id = Close[math.random(1, #Close)]
			elseif (player.Character.Torso.Position - child:WaitForChild("Lightning").Position).magnitude < 3000 then
				Id = Medium[math.random(1, #Medium)]
			else
				Id = Far[math.random(1, #Far)]
			end
			local sound = Instance.new("Sound")
			sound.Parent = script
			sound.SoundId = "rbxassetid://" .. Id
			sound.Volume = 1
			local pc = math.random(-2, 2) / 10
			sound.PlaybackSpeed = 1 + pc
			sound:Play()
			wait(20)
			sound:remove()
		end
	end
end)

game.Workspace.Terrain.ChildRemoved:Connect(function(child)
	if child == Clouds then
		if player.Character.Humanoid.Health > 0 then
			repeat
				wait(1)
			until player.Character.Humanoid.Health < 0
		end
		Clouds = Instance.new(Clouds)
		Clouds.Parent = workspace.Terrain
		-- Just incase
		SetPrecip()
		Precipitate()
	end
end)



SetPrecip()