santa=entity:extend({
	x=32,
	y=-16,
	w=12,
	h=16,
	f=false,
	y_offset=0,

	anim=0, 
	sprite=0,
	offset=0,
	idle_sprite={64,78},
	idle_offset={0,0},
	run_sprite={66,68,70,64,72,74,76,64},
	run_offset={1,2,0,0,1,2,0,0},
	dead_sprite=105,

	running=false,
	jumping=true,
	falling=false,
	sliding=false,
	landed=true,
	just_landed=true,

	is_dead=false,

	jump_time = 7,
	jump_strenght=0,
	jump_strenght_pulse=-10,
	jump_strenght_long=-1,
	horizontal_accel = 0.1,
	horizontal_speed=0,
	horizontal_speed_max=2.5,
	vertical_speed = 0,

	left_limit = 0,

	dx=0,
	dy=0,

	parse_jump=function(_ENV)
		local jump_pressed = btn(❎)

		if jump_pressed and landed and not jumping then
			if collide_map(_ENV,"down",flags.ceiling) then
				for i=1, 8 do dust({
					x=x+rnd(i),
					y=y+4+12,
					frames=18+rnd(4),
				}) end
			end

			sfx(6)
			jump_strenght = jump_strenght_pulse - abs(horizontal_speed + mid(0,speed,3)) + horizontal_speed_max
			landed = false
			just_landed = false
			jumping = true
		elseif (jumping and jump_time> 0 and not landed) then
			jump_strenght = jump_strenght + jump_strenght_long
			jump_time = jump_time - 1
		end

		if jumping and not jump_pressed then
			jump_time = 0
		end

		jump_strenght = jump_strenght * 0.9
		vertical_speed = gravity + jump_strenght
		y = y + vertical_speed
		
		if vertical_speed > 0 and collide_map(_ENV, "down", flags.floor) then
			y=y-(y%8)
			landed=true
			jumping=false
			jump_strenght=0
			jump_time=7
			if not just_landed and collide_map(_ENV,"down",flags.snow) then
				just_landed = true
				for i=1, 16 do dust({
					x=x+rnd(i),
					y=y+4+12,
					frames=18+rnd(4),
				}) end
			end
		end
		if vertical_speed < 0 and collide_map(_ENV, "up", flags.ceiling) then
			jump_time = 0
			jump_strenght=0
		end
		jumping = jump_pressed

	end,

	parse_run=function(_ENV)
		local dir_modifier = 0
		if btn(⬅️) then
			f = true
			dir_modifier = -1
		elseif btn(➡️) then
			f = false
			dir_modifier = 1
		end
		running = btn(0) or btn(1)
		if running then
			horizontal_speed = horizontal_speed + (horizontal_accel * dir_modifier)
			horizontal_speed = mid(-horizontal_speed_max, horizontal_speed, horizontal_speed_max)
		else
			horizontal_speed = horizontal_speed * friction
			if abs(horizontal_speed) < 0.1 then
				horizontal_speed = 0
			end
		end
		if (collide_map(_ENV,"left",flags.ceiling) and horizontal_speed<0)
		or (collide_map(_ENV,"right",flags.ceiling) and horizontal_speed>0) then
			horizontal_speed = 0
		end
		if(vertical_speed == 0) then
			if (collide_map(_ENV,"left",flags.floor) and horizontal_speed<0)
			or (collide_map(_ENV,"right",flags.floor) and horizontal_speed>0) then
				horizontal_speed = 0
			end
		end
		x = x + horizontal_speed
		if x<left_limit+4 and not f then running = true end
	end,

	update=function(_ENV)
		if(is_dead) then
			y+=2
			return
		end
		if collide_map(_ENV,"down",flags.snow) then
			global.friction = 0.5
		elseif collide_map(_ENV,"down",flags.slip) then
			global.friction = 0.9
		end
		parse_jump(_ENV)
		parse_run(_ENV)
		y_offset = (y-88)*0.1
		y_offset = y_offset > 0 and 0 or y_offset
		camera(0,y_offset)
		x-=speed
		-- restrict movement
		if(speed >= horizontal_speed_max and left_limit<16) then
			left_limit+=0.1
		end
		x=mid(left_limit,x,116)
		-- y=mid(12,y,127)
		if (t()*10)\1%3==0 and running and collide_map(_ENV,"down",flags.snow) then
			dust({
				x=x+rnd(3),
				y=y+4+12,
				frames=18+rnd(4),
			})
		end
		if y >= 128
		or collide_map(_ENV,"right",flags.ceiling) and x <= left_limit and not jumping
		then
			is_dead = true
			global.speed = 0
		end
	end,

	animate=function(_ENV)
		if(running) then
			if(time()-anim>1/8) then
				anim = time()
				sprite+=2
				if (sprite>7) then
					sprite=0
				end
			end
		else
			if(time()-anim>1/2) then
				anim = time()
				sprite+=1
				if (sprite>1) then
					sprite=0
				end
			end
		end
	end,

	draw=function(_ENV)
		local s
		local o
		if(is_dead) then
			s = dead_sprite
			o = 0
		elseif(running) then
			s = run_sprite[sprite+1]
			o = run_offset[sprite+1]
		else
			s = idle_sprite[sprite+1]
			o = idle_offset[sprite+1]
		end
		if(s == nil) s=idle_sprite[1]
		if(o == nil) o=idle_offset[1]
		spr(s,f and x-2 or x-1,y-o,2,2,f)
	end,

	collide_map=function(_ENV,aim, flag)
		local rp = chunk.real_pos(chunk, _ENV)
		local x = rp.x
		local y = rp.y
		local x1=0    local y1=0
		local x2=0    local y2=0
		if aim=="left" then
			x1=x+6  y1=y
			x2=x    y2=y+h-1
		 
		 elseif aim=="right" then
			x1=x+w    y1=y
			x2=x+w-6  y2=y+h-1
		 
		 elseif aim=="up" then
			x1=x+4    y1=y-1
			x2=x+w-4  y2=y
		 
		 elseif aim=="down" then
			x1=x+4      y1=y+h
			x2=x+w-4    y2=y+h
		 end
		 --pixels to tiles
		 x1/=8    y1/=8
		 x2/=8    y2/=8
		 
		 if fget(mget(x1,y1), flag)
		or fget(mget(x1,y2), flag)
		or fget(mget(x2,y1), flag)
		or fget(mget(x2,y2), flag) then
			return true
		else
			return false
		end
	end,
})