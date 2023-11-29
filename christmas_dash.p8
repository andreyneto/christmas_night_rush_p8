pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

function _init()
	START_SCREEN = 0
	GAME_SCREEN = 1
	GAME_OVER_SCREEN = 2

	game_state = START_SCREEN

	gravity = 6
	jump_time = 7
	jump_strenght_pulse = -10
	jump_strenght_long = -1
	ground = {}
	ground.y = 96

	roofs = {}
	roof1 = {x = 0, y = 76, w = 127}
	roof2 = {x = 0, y = 44, w = 127}
	add(roofs, roof1)
	add(roofs, roof2)

	player = {}
	player.x = 24
	player.y = ground.y
	player.vertical_speed = 0
	player.jump_strenght = 0
	player.jump_time = jump_time
	player.is_jumping = false
	player.is_running = false
	player.on_ground = true
	player.on_roof = false

	player.update = function()
		parse_jump(player)
	end
	player.draw = function()
		rectfill(player.x-8, player.y-8, player.x + 8, player.y + 8, 8)
	--   spr(0, player.x, player.y, 1,1)
	end
end

function _update()
	if game_state == START_SCREEN then
		update_start_screen()
	elseif game_state == GAME_SCREEN then
		update_game_screen()
	elseif game_state == GAME_OVER_SCREEN then
		update_game_over_screen()
	end
end

function _draw()
	cls()  -- Clear the screen

	if game_state == START_SCREEN then
		draw_start_screen()
	elseif game_state == GAME_SCREEN then
		draw_game_screen()
	elseif game_state == GAME_OVER_SCREEN then
		draw_game_over_screen()
	end
end

function draw_start_screen()
	-- Draw start screen graphics
	print("Press Z to start", 48, 60, 7)
end

function update_start_screen()
	-- Handle input to start the game
	if btnp(4) then  -- 'Z' key is pressed
	reset()
		game_state = GAME_SCREEN
	end
end

function draw_roofs()
	for _, roof in pairs(roofs) do
		rectfill(roof.x,roof.y,roof.w,roof.y+1,4)
	end
end

function parse_jump(actor)
	if (btn(3)) then actor.y += 2 end
	if (btn(2) and actor.on_ground and not player.is_jumping)
	then
		sfx(0)
		actor.jump_strenght = jump_strenght_pulse
		actor.on_ground = false
		actor.on_roof = false  -- Reinicia o estado ao pular
	elseif (actor.is_jumping and actor.jump_time > 0 and not actor.on_ground)
	then
		actor.jump_strenght += jump_strenght_long
		actor.jump_time -= 1
	end

	if (actor.is_jumping and not btn(2))
	then
		actor.jump_time = 0
	end

	actor.jump_strenght *= 0.9
	actor.vertical_speed = gravity + actor.jump_strenght
	actor.y += actor.vertical_speed

	if (actor.y >= ground.y)
	then
		if (not actor.on_ground)
		then
			sfx(1)
		end
		actor.y = ground.y
		actor.on_ground = true
		actor.jump_time = jump_time
		actor.on_roof = false  -- Reseta o estado ao aterrissar
	end
	for _, roof in pairs(roofs) do
        check_roof_collision(actor, roof)
    end

	-- Adiciona a verificação para estar em um telhado
	if (actor.on_roof and actor.vertical_speed < 0) then
		actor.vertical_speed = 0
		actor.y = actor.y + 1
	end

	if (actor.jump_strenght > -2)
	then
		actor.jump_strenght = 0
	end

	actor.is_jumping = btn(2)
	if (not actor.on_ground)
	then
		if (actor.vertical_speed > 0)
		then
			actor.sprite = 5
		else
			actor.sprite = 4

		end
	end
end

function check_roof_collision(actor, roof)
    if actor.x < roof.x + roof.w and actor.x + 8 > roof.x and actor.y + 8 > roof.y and actor.y < roof.y then
        actor.y = roof.y - 8
        actor.vertical_speed = 0
        actor.on_ground = true
        actor.jump_time = jump_time
        sfx(1)  -- Play a sound when landing on the roof
    end
end

function update_game_screen()
	player.update()
end

function draw_game_screen()
	cls(1)
	rectfill(0,ground.y+9, 127,127,5)
	rectfill(0,0, 127,24,5)
	draw_roofs()
	player.draw()
	print('speed')
end

function update_game_over_screen()
	if btnp(4) then  -- 'Z' key is pressed
		reset()
		-- Reset game variables for a new game
	end
end

function draw_game_over_screen()
	-- Draw game over screen graphics
	print("Game Over", 56, 60, 8)
	print("Press Z to restart", 40, 70, 7)
end
  
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
