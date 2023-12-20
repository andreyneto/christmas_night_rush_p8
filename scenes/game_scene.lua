game_scene=scene:extend({
	init=function(_ENV)
		player=santa()
		chunk()
		local def = chunk.def[2]
		def.sx=128
		chunk(def)
		speed=1
	end,

	update=function(_ENV)
		chunk:each("update")
		entity:each("update")
		entity:each("animate")
		coin:each("detect",player,function(obj)
			obj:destroy()
			score.addcoin()
			for i=1,4 do
				obj:create_spark()
			end
		end)
		score.adddistance()

	end,

	draw=function(_ENV)
		add(entity.pool,del(entity.pool,player))
		chunk:each("draw")
		local gui = {
			{strings.distance,score.getdistance(),0,0},
			{strings.score,score.getpoints(),82,48},
			{strings.coins,score.getcoins(),40,1},
		}
		foreach(gui, function (i)
			local label = i[1]
			local value = i[2]
			local posit = i[3] +4
			local sprit = i[4]
			if(sprit != 0) then
				spr(sprit, posit, 5)
				posit+=10
			end 
			prints(value,posit,4,7)
			prints(label[language],posit,9,6)
		end)
		entity:each("draw")
	end,
})
