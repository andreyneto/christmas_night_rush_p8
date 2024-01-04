game_over_scene=scene:extend({
	gui={},
	new_highscore=false,
	new_highcoins=false,
	new_highdistance=false,
	init=function(_ENV)
		gui = {
			{strings.distance,score.getdistance(),0,0},
			{strings.score,score.getpoints(),82,48},
			{strings.coins,score.getcoins(),40,1},
		}
		high_score = high_score()
		high_distance = high_distance()
		high_coins = high_coins()
		new_highscore = score.points > high_score
		new_highcoins = score.coins > high_coins
		new_highdistance = score.distance > high_distance
		if new_highscore then dset(1, score.points) end
		if new_highcoins then dset(3, score.coins) end
		if new_highdistance then dset(2, score.distance) end
		local total = total_coins()
		for i=1,score.coins do
			total[2] += 1
			if(total[2] == 10000) then
				total[1]+=1
				total[2]=0
			end
		end
		dset(4,total[1]) dset(5, total[2])
	end,
-- 5050 73 30
	update=function(_ENV)
		if btnp(❎) then
			scene:load(game_scene)
			sfx(8)
		end
		if btnp(🅾️) then
			scene:load(title_scene)
			sfx(8)
		end
	end,

	draw=function(_ENV)
		if new_highscore or new_highcoins or new_highdistance then
			printc(strings.new_high_score[language()],32,10, true)
		else
			printc(strings.game_over[language()],32,7, true)
		end
		printc(pad(strings.score[language()], 15)..score.getpoints(),56,new_highscore and 10 or 7, true)
		printc(pad(strings.distance[language()], 15)..score.getdistance(),64,new_highdistance and 10 or 7, true)
		printc(pad(strings.coins[language()], 15)..score.getcoins(),72,new_highcoins and 10 or 7, true)
		printc("🅾️ "..strings.menu[language()].."   ".."❎ "..strings.play_again[language()],112,7)
	end,
})