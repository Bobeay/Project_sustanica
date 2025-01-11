local image = script.Parent
local gradient = image.UIGradient
local ts = game:GetService("TweenService") 
local ti = TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
local offset1 = {Offset = Vector2.new(1, 0)}
local create = ts:Create(gradient, ti, offset1)
local startingPos = Vector2.new(-1, 0)
local addWait = 2.5


local function animate()

	create:Play()
	create.Completed:Wait()
	gradient.Offset = startingPos
	create:Play()
	create.Completed:Wait()
	gradient.Offset = startingPos
	wait(addWait)
	animate()

end

animate()