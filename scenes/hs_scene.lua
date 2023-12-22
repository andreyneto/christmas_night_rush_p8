hs_scene=scene:extend({
	gui={},
	init=function(_ENV)
		gui = {
			{strings.distance,score.getdistance(),0,0},
			{strings.score,score.getpoints(),82,48},
			{strings.coins,score.getcoins(),40,1},
		}
	end,

	update=function(_ENV)
		if btnp(🅾️) then
			scene:load(title_scene)
		end
	end,

	draw=function(_ENV)
		printc(strings.high_scores[language],16,7, true)
		counterv(84,strings.DISTANCE,score.gethdistance())
		counterv(58,strings.COINS,score.gethcoins(),1)
		counterv(32,strings.SCORE,score.gethpoints(),49,50,51)
		printc("🅾️ "..strings.back[language],112,7)
	end,
})