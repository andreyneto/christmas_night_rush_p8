game_scene=scene:extend({
	init=function(_ENV)
		player=santa()
	end,

	update=function(_ENV)
		entity:each("update")
		if btnp(❎) then
			scene:load(title_scene)
		end
	end,

	draw=function(_ENV)
		add(entity.pool,del(entity.pool,player))
		map(0,0)
		prints("score: "..pad(score.."00",7),4,4,7)
		prints("time: "..pad(ceil(timer/30),2),93,4,7)
		entity:each("draw")
	end,
})