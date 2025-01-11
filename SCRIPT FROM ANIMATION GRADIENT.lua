--//VARIABLES:
local button = script.Parent
local gradient = button.UIGradient
local ts = game:GetService("TweenService") 
local ti = TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
local offset1 = {Offset = Vector2.new(1, 0)}
local create = ts:Create(gradient, ti, offset1)
local startingPos = Vector2.new(-1, 0) 
local addWait = 0


--//ANIMATIONS:
local function animate()
	create:Play()
	create.Completed:Wait() --wait for the tween to stop
	gradient.Offset = startingPos --resets offset
	create:Play() -- repeats anim
	create.Completed:Wait()-- waits for the tween to stop
	gradient.Offset = startingPos
	wait(addWait) --waits some time for the tween to stop
	animate() -- calls itself (for looping)
end
animate() -- calls the all funcions!!