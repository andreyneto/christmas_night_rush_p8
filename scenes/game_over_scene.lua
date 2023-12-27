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
		new_highscore = score.points[2] >= high_score[2] and score.points[1] > high_score[1]
		new_highcoins = score.coins[2] >= high_coins[2] and score.coins[1] > high_coins[1]
		new_highdistance = score.distance[2] >= high_distance[2] and score.distance[1] > high_distance[1]
		if new_highscore then dset(1, score.points[1]) dset(2, score.points[2]) end
		if new_highcoins then dset(5, score.coins[1]) dset(6, score.coins[2]) end
		if new_highdistance then dset(3, score.distance[1]) dset(4, score.distance[2]) end
		local total = total_coins()
		for i=0,score.coins[2] do
			total[2] += i
			if(total[2] == 10000) then
				total[1]+=1
				total[2]=0
			end
		end
		total[1] += score.coins[1]
		dset(7,total[1]) dset(8, total[2])
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