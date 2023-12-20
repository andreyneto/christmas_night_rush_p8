point_label=entity:extend({
    x=64,
    y=64,
    w=8,
    h=8,
    anim=0,
    value=0,
    offset=0,
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
                _ENV:destroy()
            end
        end
    end,
    draw=function (_ENV)
        print("\f7\#1"..value, x, y-offset)
    end,
})