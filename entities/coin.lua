coin=entity:extend({
    x=64,
    y=64,
    w=8,
    h=8,
    anim=0,
    sprite=1,
	pool={},
    update=function (_ENV)
        x-=speed
        if x+w < 0 then destroy(_ENV) end
    end,
    animate=function(_ENV)
        if(time()-anim>1/8) then
            anim = time()
            sprite+=1
            if(sprite>8) then
                sprite=1
            end
        end
    end,
    draw=function (_ENV)
        spr(sprite, x, y)
    end,
	create_spark=function(_ENV)
		spark({
			x=x-2+rnd(9),
			y=y-2+rnd(4),
			frames=4+rnd(4),
		})
	end,
    randon=function(chunk)
        local sy = chunk.sy
        local sx = chunk.sx
		for r=1,16 do
			local cx = rndb(1,16)*8
			local cy = rndb(2,12)*8
			coin({x=cx+sx,y=cy+sy})
		end
    end,
    block=function(chunk, w, h, bx, by)
        local sy = chunk.sy
        local sx = chunk.sx
        for i=0, w-1 do
            for j=0, h-1 do
                local cx = i*8
                local cy = j*8
                if bx+cx < 120
                and bx+cx >= 4
                and by+cy <= 96
                and by+cy >= 16
                then
                    coin({x=bx+cx+sx, y=by+cy+sy})
                end
            end
        end
    end
})