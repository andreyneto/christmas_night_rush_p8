-- config
time_limit=30
heart_count=50

-- globals
gravity=5
friction=0.5
speed=0.9
music_speed=16

function increase_speed()
	speed += 0.1
	speed = mid(0, speed, 2.5)
	if(speed > 2.4) then setmusicspeed(11)
	elseif(speed > 2.1) then setmusicspeed(12)
	elseif(speed > 1.8) then setmusicspeed(13)
	elseif(speed > 1.5) then setmusicspeed(14)
	elseif(speed > 1.2) then setmusicspeed(15) end
end

function setmusicspeed(value)
	music_speed = value
	poke(0x3200 + 68*0 + 65, music_speed)
	poke(0x3200 + 68*1 + 65, music_speed)
	poke(0x3200 + 68*2 + 65, music_speed)
	poke(0x3200 + 68*3 + 65, music_speed)
	poke(0x3200 + 68*4 + 65, music_speed)
end

--score
score={
	distance=0,
    points=0,
    coins=0,
	steps=0,
	reset=function()
		score.distance=0
		score.points=0
		score.coins=0
		score.steps=0
	end,
	addcoin=function()
		if score.coins < 32767 then
        	score.coins += 1
		end
		if(score.coins % 100 == 0 ) then
			increase_speed()
		end
    end,
	addpoints=function(value)
		if score.points < 32767 then
        	score.points += value or 0
		end
		if(score.points % 100 == 0 ) then
			increase_speed()
		end
    end,
    adddistance=function()
		if score.distance < 32767 then
			score.steps+=speed
			if score.steps >= 8 then
				score.steps = 0
				score.distance += speed
				if(score.distance % 100 == 0 ) then
					increase_speed()
				end
			end
		end
    end,
    getcoins=function ()
        return fill_number(flr(score.coins))
    end,
    getdistance=function ()
        return fill_number(flr(score.distance))
    end,
    getpoints=function ()
        return fill_number(flr(score.points))
    end,
    gethcoins=function ()
        return fill_number(flr(high_coins()))
    end,
    gethdistance=function ()
        return fill_number(flr(high_distance()))
    end,
    gethpoints=function ()
        return fill_number(flr(high_score()))
    end,
    gettcoins=function ()
        return fill_number(flr(total_coins()[1]),3)..fill_number(flr(total_coins()[2]),4)
    end,
}
-- game loop
function _init()
	background:init()
	scene:load(title_scene)
	log("_init", true)
	foreground:init()
	achievement_manager:init()
end

function _update()
	background:update()
	scene.current:update()
	foreground:update()
	achievement_badge:each("update")
	achievement_manager:update()
end

function _draw()
	-- background
	cls(0)
	-- scene
	background:draw()
	scene.current:draw()
	foreground:draw()
	achievement_badge:draw_first()
end