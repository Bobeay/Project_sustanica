game.Players.PlayerAdded:connect(function(player)
	player.CharacterAdded:connect(function(character)
		player.Character+.Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=121459965269614" -- Insert ID here or leave this one--
	end)
end)

