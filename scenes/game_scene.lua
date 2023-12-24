game_scene=scene:extend({
	logo_x=16,
	go_time=0,
	latest_speed=16,
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
		music(1)
	end,

	update=function(_ENV)
		logo_x-=speed
		chunk:each("update")
		entity:each("update")
		entity:each("animate")
		coin:each("detect",player,function(obj)
			obj:destroy()
			sfx(5)
			score.addcoin()
			for i=1,4 do
				obj:create_spark()
			end
		end)
		gift:each("detect",player,function(obj)
			point_label({value=obj.value,x=obj.x,y=obj.y-8})
			score.addpoints(obj.value)
			obj:destroy()
			sfx(9)
		end)
		score.adddistance()
		if player.is_dead and go_time == 0 then
			go_time = time()
			music(-1)
			sfx(10)
		end
		if go_time > 0 and time()-go_time>=3 then
			log("game over")
			music_speed=16
			scene:load(game_over_scene)
		end
	end,

	draw=function(_ENV)
		local locky = player.y_offset
		add(entity.pool,del(entity.pool,player))
		chunk:each("draw")
		local gui = {
			{strings.DISTANCE,score.getdistance(),5},
			{strings.SCORE,score.getpoints(),86,48},
			{strings.COINS,score.getcoins(),42,1},
		}
		foreach(gui, function (i)
			counterh(i[3],4+locky,i[1],i[2],i[4])
		end)
		entity:each("draw")
		if(logo_x > -128) then
			spr(128,logo_x,32+locky,12,3)
			spr(16,logo_x-8,56+locky,14,2)
		end
	end,
})
