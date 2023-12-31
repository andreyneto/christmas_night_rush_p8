title_scene=scene:extend({

	options={
		{
			label=strings.start_game,
			call=function()
				scene:load(game_scene)
			end
		},
		{
			label=strings.achievements,
			call=function()
				scene:load(achievements_scene)
			end
		},
		{
			label=strings.high_scores,
			call=function()
				scene:load(hs_scene)
			end
		},
		{
			label=strings.language,
			call=function()
				local l = 1
				if(language()==1) then l = 2 end
				dset(0, l)
			end
		},
	},
	selected=1,

	init=function(_ENV)
		music(0)
	end,

	update=function(_ENV)
		entity:each("update")
		if btnp(⬇️) then
			selected += 1
			sfx(7)
		end
		if btnp(⬆️) then
			selected -= 1
			sfx(7)
		end
		selected=mid(1,selected,#options)
		if btnp(❎) then
			options[selected]:call()
			sfx(8)
		end
	end,

	draw=function(_ENV)
		spr(16,8,56,14,2)
		spr(128,16,32,12,3)
		local p = 64+((64-(#options*8))/2)-8
		for i=1, #options do
			local is_selected = i==selected
			printc((is_selected and "> " or "")..options[i].label[language()]..(is_selected and " <" or ""), p+(8*i), options[i].call == noop and 6 or is_selected and 10 or 7, is_selected)
			if(i == #options) then
			end
		end
		spr(languages[language()][2], 8, 8, 2, 1)
		counterh(83,8,strings.COINS,score.gettcoins(),1)
	end,
})