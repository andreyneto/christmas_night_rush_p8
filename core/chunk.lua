chunk=class:extend({
	celx=0,
	cely=0,
	sx=0,
	sy=0,
	-- class
	pool={},
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
		local cw = rnd(16)
		local factor = 1
		for i = 2, 16 do
		  if (cw * i) >= 16 then
			factor = i
			break
		  end
		end
		coin.block(_ENV, cw, factor, rnd(127),rnd(127))
	end,
	update=function(_ENV)
		while #pool < 2 do
			local rx = flr(rnd(7)) * 16
			local ry = flr(rnd(2)) * 16
			chunk({celx=rx, cely = ry,sx = pool[#pool].sx+128})
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