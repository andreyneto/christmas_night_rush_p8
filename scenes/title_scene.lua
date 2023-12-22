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
			call=noop
		},
		{
			label=strings.high_scores,
			call=function()
				scene:load(game_over_scene)
			end
		},
		{
			label=strings.language,
			call=function()
				if(language==1) then language = 2
				else language = 1 end
				dset(0, language)
			end
		},
	},
	selected=1,

	init=function(_ENV)
	end,

	update=function(_ENV)
		entity:each("update")
		if btnp(⬇️) then
			selected += 1
		end
		if btnp(⬆️) then
			selected -= 1
		end
		selected=mid(1,selected,#options)
		if btnp(❎) then
			options[selected]:call()
		end
	end,

	draw=function(_ENV)
		spr(16,8,56,14,2)
		spr(128,16,32,12,3)
		local p = 64+((64-(#options*8))/2)-8
		for i=1, #options do
			local is_selected = i==selected
			printc((is_selected and "> " or "")..options[i].label[language]..(is_selected and " <" or ""), p+(8*i), options[i].call == noop and 6 or is_selected and 10 or 7, is_selected)
			if(i == #options) then
			end
		end
		spr(languages[language][2], 4, 4, 2, 1)
	end,
})