game_scene=scene:extend({
	init=function(_ENV)
		player=santa()
		chunk()
		chunk({celx=16, sx=128})
	end,

	update=function(_ENV)
		chunk:each("update")
		entity:each("update")
		entity:each("animate")
	end,

	draw=function(_ENV)
		add(entity.pool,del(entity.pool,player))
		chunk:each("draw")
		prints("speed: "..speed,4,4,7)
		-- prints("score: "..pad(score.."00",7),4,4,7)
		-- prints("time: "..pad(ceil(timer/30),2),93,4,7)
		entity:each("draw")
	end,
})
