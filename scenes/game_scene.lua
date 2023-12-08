game_scene=scene:extend({
	init=function(_ENV)
		player=santa()
	end,

	update=function(_ENV)
		entity:each("update")
	end,

	draw=function(_ENV)
		add(entity.pool,del(entity.pool,player))
		map(0,0)

		prints("x: "..player.x,4,4,7)
		prints("y: "..player.y,4,12,7)
		-- prints("score: "..pad(score.."00",7),4,4,7)
		-- prints("time: "..pad(ceil(timer/30),2),93,4,7)
		entity:each("draw")
	end,
})