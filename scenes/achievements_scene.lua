achievements_scene=scene:extend({
	init=function (_ENV)
		
	end,

	update=function(_ENV)
		if btnp(🅾️) then
			scene:load(title_scene)
			sfx(8)
		end
	end,

	draw=function(_ENV)
		printc("🅾️ "..strings.back[language()],112,7)
	end,
})

achievement_manager=class:extend({
	init=function ()
	end,
	update=noop
})

achievement_badge=class:extend({
	y=-16,
	w=16,
	label="",
	show_time=0,
	pool={},
	sound_played=false,
	init=function (_ENV)
		add(pool, _ENV)
	end,
	draw=function (_ENV)
		local locky = scene.current.player != nil and scene.current.player.y_offset or 0
		local x = (127-w)/2
		local ly = y+locky
		rectfill(x,ly,w+x,ly+12,7)
		rectfill(x+1,ly+1,12+x,ly+11,1)
		spr(120,x+3,ly+2)
		if(w>16) print(sub(strings.achievement_unlocked[language()],1,flr((w-16)/4)), x + 16, ly+1, 5)
		if(w>16) print(sub(label,1,flr((w-16)/4)), x + 16, ly+7, 0)
	end,
	update=function (_ENV)
		if _ENV == pool[1] then
			if(show_time == 0) then
				if not sound_played then
					sfx(11)
					sound_played = true
				end
				if y<2 then
					y+=5
					y=mid(-16,y,2)
				elseif w<105 then
					w+=8
					w=mid(0,w,105)
				else
					show_time=time()
				end
			elseif(show_time+3 <= time()) then
				if w>16 then
					w-=16
					w=mid(16,w,105)
				elseif y>-16 then
					y-=5
				else
					del(pool, _ENV)
				end
			end
		end
	end,
	draw_first=function (_ENV)
		if(#pool > 0) then draw(pool[1]) end
	end,
	each=function(_ENV,method,...)
		for e in all(pool) do
			if (e[method]) e[method](e,...)
		end
	end,
})