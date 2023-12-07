title_scene=scene:extend({
	init=function(_ENV)
	end,

	update=function(_ENV)
		entity:each("update")
	
		if btnp(❎) then
			scene:load(game_scene)
		end
	end,

	draw=function()
		-- map(0,0)
		-- entity:each("draw")
		for j=0, 2 do
			for i=0, 12 do
				spr(192+i+(j*16), 16+(i*8), 12+32+(j*8))
			end
		end
		for j=0, 1 do
			for i=0, 14 do
				spr(128+i+(j*16), 8+(i*8), 12+56+(j*8))
			end
		end
		
		-- instructions
		-- printc("collect all the hearts",60,6)
		-- printc("before time runs out!",68,6)
		
		-- prompt
		printc("❎ start game",96,7)
	end,
})