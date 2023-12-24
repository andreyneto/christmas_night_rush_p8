gift=entity:extend({
    x=64,
    y=64,
    w=8,
    h=8,
    anim=0,
    offset=1,
    oa={0,1,2,3,4,3,2,1},
    value=0,
    sprite=0,
	pool={},
    update=function (_ENV)
        x-=speed
        if x+w < 0 then destroy(_ENV) end
    end,
    animate=function(_ENV)
        if(time()-anim>1/8) then
            anim = time()
            offset+=1
            if(offset>8) then
                offset=1
            end
        end
    end,
    draw=function (_ENV)
        spr(sprite, x, y-oa[offset])
		if value == 1000 and (t()*10)\1%8==0 then
            create_spark(_ENV)
        end
    end,
	create_spark=function(_ENV)
		spark({
			x=x-2+rnd(9),
			y=y-2+rnd(4),
			frames=4+rnd(4),
		})
	end,
})