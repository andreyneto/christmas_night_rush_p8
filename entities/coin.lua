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
	end
})