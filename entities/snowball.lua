snowball=entity:extend({
    x=64,
    y=64,
    w=8,
    h=8,
    st=0,
    sht=false,
    wrn=false,
    sprite=107,
    spd=speed*5,
	pool={},
    anim=0,
    pl=false,
    ud=false,
    wrnsnd=false,
    init=function (_ENV)
		add(entity.pool,_ENV)
		if pool != entity.pool then
			add(pool,_ENV)
		end
        st=time()
        ud=rnd({true,false})
        -- sfx(12)
    end,
    update=function (_ENV)
        sht=st<time()-4
        wrn=st<time()-3
        if not wrn then
            if (ud) then
                y-=0.1
            else y+=0.1 end
        end
        if wrn and not wrnsnd then
            sfx(13)
            wrnsnd=true
        end
        if sht then
            x-=spd
        end
        if x+w+32 < 0 then destroy(_ENV) end
    end,
    draw=function (_ENV)
        if(not sht) then
        if wrn then
            if(time()-anim>1/6) then
                anim = time()
                pl = not pl
            end
        end
        if (pl) pal(8, 9, 0)
        spr(107,128-16,y,2,2)
        pal()
        else
            dust({
                x=x+4,
                y=y+4,
                rad=5,
                sy=0,
                clr=13,
                frames=2+rnd(4),
            })
            dust({
                x=x+4,
                y=y+4,
                rad=4,
                sy=0,
                clr=6,
                frames=2+rnd(4),
            })
            dust({
                x=x+4,
                y=y+4,
                rad=3,
                sy=0,
                frames=2+rnd(4),
            })
        end
    end,
})