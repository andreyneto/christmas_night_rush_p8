game_scene=scene:extend({
	steps=0,
	score=0,
	coins=0,
	distance=0,
	init=function(_ENV)
		player=santa()
		chunk()
	end,

	update=function(_ENV)
		chunk:each("update")
		entity:each("update")
		entity:each("animate")
		coin:each("detect",player,function(obj)
			obj:destroy()
			coins+=1
			for i=1,4 do
				obj:create_spark()
			end
		end)
		steps+=speed
		if(steps>=80) then
			distance +=1
			steps=0
		end
	end,

	draw=function(_ENV)
		add(entity.pool,del(entity.pool,player))
		chunk:each("draw")
		local gui = {
			{strings.distance,fill_number(flr(distance), 6).."0",0,0},
			{strings.score,fill_number(flr(score)).."00",84,48},
			{strings.coins,fill_number(flr(coins), 7),40,1},
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
