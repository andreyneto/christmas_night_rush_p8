hs_scene=scene:extend({
	init=noop,

	update=function(_ENV)
		if btnp(🅾️) then
			scene:load(title_scene)
			sfx(8)
		end
	end,

	draw=function(_ENV)
		printc(strings.high_scores[language()],16,7, true)
		counterv(84,strings.DISTANCE,score.gethdistance())
		counterv(58,strings.COINS,score.gethcoins(),1)
		counterv(32,strings.SCORE,score.gethpoints(),49,50,51)
		printc("🅾️ "..strings.back[language()],112,7)
	end,
})