name="Humanoid"

robo=script.Parent:clone()

while true do
	wait(210)
	if script.Parent.Humanoid.Health<2 then
		robot=robo:clone()
		robot.Parent=script.Parent.Parent
		robot:makeJoints()
		script.Parent:remove()
	end
end
		


