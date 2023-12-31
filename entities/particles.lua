-- particle
particle=entity:extend({
	frame=0,
	frames=10,
	rad=1,
	clr=5,
	sx=0,
	sy=0,
	
	update=function(_ENV)
		x+=sx
		y+=sy
		frame+=1
		x-=speed
		
		if frame>=frames then
			destroy(_ENV)
		end
	end,

	draw=function(_ENV)
		local r=(1-frame/frames)*rad
		circfill(x,y,r,clr)
	end
})

dust=particle:extend({
	rad=2,
	sy=-.25,
	clr=7
})

spark=particle:extend({
	clr=10,
	sy=-.5,
})

-- clouds
cloud=class:extend({
	x=0,
	y=0,
	spd=0,
	w=0,
	clr=0,
	-- class
	pool={},
	init=function (_ENV)
		add(pool, _ENV)
	end,
	update=function(_ENV)
		x -= spd*(speed>0 and speed or 1*0.1)
		if x+w < 0 then
			x = 128+w
			y=rnd(clr == 0 and 32 or 128-8)
		end
	end,
	draw=function(_ENV)
		rectfill(x,y,x+w,y+4+(1-w/64)*12,clr)
	end,
	each=function(_ENV,method,...)
		for e in all(pool) do
			if (e[method]) e[method](e,...)
		end
	end,
})

-- snow
snow=class:extend({
	x=0,
	y=0,
	s=0,
	spd=0,
	off=0,
	c=0,
	pool={},
	init=function (_ENV)
		add(pool, _ENV)
	end,
	update=function(_ENV)
		local ps = speed == 0 and 1 or speed
		if scene.current == game_scene then ps *= spd end
		y += ps
		x += sin(off)
		off+= 0.05
		if y>128+4 then 
			y=-4
			x=rnd(256)
		end

		x-=speed
	end,
	draw=function(_ENV)
		rectfill(x,y,x+s,y+s,c)
	end,
	each=function(_ENV,method,...)
		for e in all(pool) do
			if (e[method]) e[method](e,...)
		end
	end,
})