-- config
time_limit=30
heart_count=50

-- globals
gravity=5
friction=0.5
speed=0.9

--score
score={
	distance={0,0},
    points={0,0},
    coins={0,0},
	steps=0,
	reset=function()
		score.distance={0,0}
		score.points={0,0}
		score.coins={0,0}
		score.steps=0
	end,
	addcoin=function()
        score.coins[1] += 1
		if(score.coins[1]>=9999) then
			score.coins[1] = 0
			score.coins[2] += 1
		end
		if(score.coins[1] % 100 == 0 ) then
			speed += 0.1
			speed = mid(0, speed, 2.5)
		end
    end,
	addpoints=function(value)
        score.points[1] += value or 0
		if(score.points[1]>=9999) then
			score.points[1] = 0
			score.points[2] += 1
		end
		if(score.points[1] % 100 == 0 ) then
			speed += 0.1
			speed = mid(0, speed, 2.5)
		end
    end,
    adddistance=function()
		score.steps+=speed
		if score.steps >= 8 then
			score.steps = 0
			score.distance[1] += speed
			if(score.distance[1]>=9999) then
				score.distance[1] = 0
				score.distance[2] += 1
			end
			if(score.distance[1] % 100 == 0 ) then
				speed += 0.1
				speed = mid(0, speed, 2.5)
			end
		end
    end,
    getcoins=function ()
        return fill_number(flr(score.coins[2]),3)..fill_number(flr(score.coins[1]))
    end,
    getdistance=function ()
        return fill_number(flr(score.distance[2]),3)..fill_number(flr(score.distance[1]))
    end,
    getpoints=function ()
        return fill_number(flr(score.points[2]),3)..fill_number(flr(score.points[1]))
    end,
    gethcoins=function ()
        return fill_number(flr(high_coins[2]),3)..fill_number(flr(high_coins[1]))
    end,
    gethdistance=function ()
        return fill_number(flr(high_distance[2]),3)..fill_number(flr(high_distance[1]))
    end,
    gethpoints=function ()
        return fill_number(flr(high_score[2]),3)..fill_number(flr(high_score[1]))
    end,
    gettcoins=function ()
        return fill_number(flr(total_coins[2]),3)..fill_number(flr(total_coins[1]))
    end,
}
-- game loop
function _init()
	background:init()
	scene:load(title_scene)
	log("_init", true)
	foreground:init()
end

function _update()
	background:update()
	scene.current:update()
	foreground:update()
end

function _draw()
	-- background
	cls(0)
	-- scene
	background:draw()
	scene.current:draw()
	foreground:draw()
end