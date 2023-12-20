chunk=class:extend({
	celx=0,
	cely=0,
	sx=0,
	sy=0,
    coins={},
    gifts={},
	rnd_cb=true,
	-- class
	pool={},
	def={
		{celx=0,cely=0},
		{celx=16,cely=0,coins={{w=4,h=1,x=32,y=88},{w=3,h=1,x=80,y=80},{w=1,h=1,x=72,y=72},{w=1,h=1,x=64,y=80},{w=1,h=1,x=104,y=88},}, rnd_cb=false, gifts={{x=24, y=64}}},
		-- {celx=32,cely=0,coins={{w=7,h=1,x=8,y=16},{w=3,h=2,x=40,y=56},{w=3,h=2,x=80,y=72},{w=16,h=1,x=0,y=96},}, rnd_cb=true},
		-- {celx=48,cely=0,coins={{w=6,h=1,x=72,y=16},{w=6,h=1,x=72,y=56},{w=4,h=3,x=80,y=72},{w=3,h=2,x=24,y=32},}, rnd_cb=true },
		-- {celx=64,cely=0,coins={{w=5,h=2,x=16,y=16},{w=3,h=1,x=0,y=96},{w=6,h=1,x=24,y=80},{w=4,h=1,x=72,y=64},},rnd_cb=true},
		-- {celx=80,cely=0,coins={{w=16,h=2,x=0,y=88},{w=16,h=2,x=0,y=56},{w=16,h=2,x=0,y=32},{w=16,h=1,x=0,y=16}},rnd_cb=true},
		-- {celx=96,cely=0,coins={{w=1,h=6,x=32,y=40},{w=2,h=2,x=72,y=56},{w=2,h=2,x=104,y=56}},rnd_cb=true},
		-- {celx=112,cely=0,coins={{w=3,h=2,x=8,y=16},{w=3,h=2,x=56,y=16},{w=3,h=2,x=104,y=16},{w=4,h=2,x=0,y=88},{w=3,h=2,x=32,y=80},{w=3,h=2,x=56,y=72},{w=3,h=2,x=80,y=80},{w=3,h=2,x=104,y=88},},rnd_cb=true},
	},
	real_pos=function(_ENV, entity)
		local i = #pool >1 and entity.x >= pool[2].sx-8 and 2 or 1
		local c = pool[i]
		
		local rx = c.celx*8
		rx -= c.sx
		rx += entity.x

		local ry = c.cely*8
		ry -=c.sy
		ry +=entity.y
		return {chunk=i,x=rx,y=ry}
	end,

	each=function(_ENV,method,...)
		for e in all(pool) do
			if (e[method]) e[method](e,...)
		end
	end,
	-- instance
	init=function(_ENV)
		add(pool,_ENV)
		foreach(gifts, function (g)
			local value
			local sprite
			local odds = rnd()
			if odds > 0.99 then
				sprite = 51
				value = 1000
			elseif odds > 0.95 then
				sprite = 50
				value = 500
			elseif odds > 0.75 then
				sprite = 49
				value = 250
			elseif odds > 0.5 then
				sprite = 48
				value = 100
			end
			if sprite != nil and value != nil and color != nil then
				gift({x=sx+g.x,y=sy+g.y,value=value,sprite=sprite})
			end
		end)
		foreach(coins, function (b)
			if not rnd_cb or rnd() > 0.50 then
				coin.block(b.w, b.h, sx+b.x,sy+b.y)
			end
		end)
	end,
	update=function(_ENV)
		while #pool < 2 do
			local d
			repeat
				d = rnd(def)
			until d != def[1]
			chunk({
				sx = pool[#pool].sx+128,
				celx=d.celx,
				cely=d.cely,
				coins=d.coins,
				rnd_cb=d.rnd_cb,
				gifts=d.gifts
			})
		end
		sx-=speed
		if sx < -128 then
			destroy(_ENV)
		end
	end,
	draw=function(_ENV)
		map(celx,cely,sx,sy,16,16)
	end,
	destroy=function(_ENV)
		del(pool,_ENV)
	end
})