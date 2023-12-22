game_scene=scene:extend({
	logo_x=16,
	go_time=0,
	init=function(_ENV)
		log("_init Game")
		score.reset()
		player=santa()
		chunk()
		local def = chunk.def[2]
		def.sx=128
		chunk(def)
		global.speed=1
		go_time=0
		logo_x=16
	end,

	update=function(_ENV)
		logo_x-=speed
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
		gift:each("detect",player,function(obj)
			point_label({value=obj.value,x=obj.x,y=obj.y-8})
			score.addpoints(obj.value)
			obj:destroy()
		end)
		score.adddistance()
		if player.is_dead and go_time == 0 then
			go_time = time()
		end
		if go_time > 0 and time()-go_time>=3 then
			log("game over")
			scene:load(game_over_scene)
		end
	end,

	draw=function(_ENV)
		local locky = player.y_offset
		add(entity.pool,del(entity.pool,player))
		chunk:each("draw")
		local gui = {
			{strings.DISTANCE,score.getdistance(),0,0},
			{strings.SCORE,score.getpoints(),82,48},
			{strings.COINS,score.getcoins(),40,1},
		}
		foreach(gui, function (i)
			local label = i[1]
			local value = i[2]
			local posit = i[3] +4
			local sprit = i[4]
			if(sprit != 0) then
				spr(sprit, posit, 4 + locky)
				posit+=10
			end
			prints(value,posit,3+locky,7)
			prints(label[language],posit,8+locky,6)
		end)
		entity:each("draw")
		if(logo_x > -128) then
			spr(128,logo_x,32+locky,12,3)
			spr(16,logo_x-8,56+locky,14,2)
		end
	end,
})
