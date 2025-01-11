
----------VARIEBLES----------

local HG = script.Parent 
local Text = HG:WaitForChild("Hunger"):WaitForChild("OrangeStripe") -- find the exact name
local Plr = game.Players.LocalPlayer -- plr will refer to an individual player, not everyone

repeat wait() until Plr.Character -- get and repeat the expectation of the player's characteristics 

local Hum = Plr.Character:WaitForChild("Humanoid") -- find a humanoid
local MaxHunger = 100 -- maximum hunger value
local DecreaseRate = 25 -- every 25 seconds = -1 food
local HungerValue -- in the future we will use it for various actions with food and values

------------------------------



----------CODE----------

if Plr:FindFirstChild("HungerVal") then -- if the value of hunger is found then
	HungerValue = Plr.HungerVal -- assign hungervalue to the player's characteristic
	HungerValue.Value = MaxHunger -- Max Value Hunger
else -- ?????
	Instance.new("IntValue", Plr).Name = "HungerVal" -- create a new value for the player 
	Plr.HungerVal.Value = MaxHunger -- Max Value Hunger
	HungerValue = Plr.HungerVal  -- assign hungervalue to the player's characteristic
end

HungerValue.Changed:connect(function() -- create an animation function when the hunger value changes
	Text:TweenSize(UDim2.new(HungerValue.Value/MaxHunger,0, 1,0), "Out", "Linear", .2, true) -- displacement animation
end)

while wait(DecreaseRate) do -- wait 25 seconds
	if HungerValue.Value - 1 >= 0 then -- if the hunger value is still greater than zero then
		HungerValue.Value = HungerValue.Value - 1 -- subtract one from hunger
	end
	
	if HungerValue.Value == 0 then 	-- if hunger value is zero then
		repeat wait(1) 	--repeat every second
			Hum.Health = Hum.Health - 5 -- subtract 5 units from health
		until HungerValue.Value > 0 or Hum.Health <= 0 -- until hunger is greater than zero or the player's health is less than or equal to zero
	end
end

------------------------