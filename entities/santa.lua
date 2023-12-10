santa=entity:extend({
	x=16,
	y=64,
	w=12,
	h=16,
	f=false,

	anim=0,
	sprite=0,
	offset=0,
	idle_sprite={160,174},
	idle_offset={0,0},
	run_sprite={162,164,166,160,168,170,172,160},
	run_offset={1,2,0,0,1,2,0,0},

	running=false,
	jumping=false,
	falling=false,
	sliding=false,
	landed=true,

	jump_time = 7,
	jump_strenght=0,
	jump_strenght_pulse=-10,
	jump_strenght_long=-1,
	horizontal_speed=0,
	horizontal_speed_max=2,
	vertical_speed = 0,

	dx=0,
	dy=0,

	parse_jump=function(_ENV)
		local jump_pressed = btn(2)

		if jump_pressed and landed and not jumping then
			jump_strenght = jump_strenght_pulse - abs(horizontal_speed) + horizontal_speed_max
			landed = false
			jumping = true
		elseif jumping and jump_time> 0 and not landed then
			jump_strenght = jump_strenght + jump_strenght_long
			jump_time = jump_time - 1
		end

		if jumping and not jump_pressed then
			jump_time = 0
		end

		jump_strenght = jump_strenght * 0.9
		vertical_speed = gravity + jump_strenght
		y = y + vertical_speed

		if collide_map(_ENV, "down", 0) then
			y=y-(y%8)
			landed=true
			jumping=false
			jump_strenght=0
			jump_time=7
		end
		jumping = jump_pressed

	end,

	update=function(_ENV)
		parse_jump(_ENV)
		-----
		if true then return 0 end
		--check collision left and right
		if dx<0 then
			if collide_map(_ENV,"left",0) then
			  dx=0
			end
		  elseif dx>0 then
			if collide_map(_ENV,"right",0) then
			  dx=0
			end
		  end


		if dx!=0 or dy !=0 then
			-- normalize movement
			local a=atan2(dx,dy)
			x+=cos(a)
			y+=sin(a)

			-- spawn dust each 3/10 sec
			-- if (t()*10)\1%3==0 and on_ground then
			-- 	dust({
			-- 		x=x+rnd(3),
			-- 		y=y+4,
			-- 		frames=18+rnd(4),
			-- 	})
			-- end
		end
		
		-- restrict movement
		-- x=mid(7,x,114)
		-- y=mid(15,y,116)
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
			if(time()-anim>6/8) then
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
		if(running) then
			s = run_sprite[sprite+1]
			o = run_offset[sprite+1]
		else
			s = idle_sprite[sprite+1]
			o = idle_offset[sprite+1]
		end
		if(s == nil) s=idle_sprite[1]
		if(o == nil) o=idle_offset[1]
		rectfill(x,y,x+15,y+15,9)
		spr(s,x,y-o,2,2,f)
	end,

	collide_map=function(_ENV,aim, flag)
		local x1=0    local y1=0
		local x2=0    local y2=0
		if aim=="left" then
			x1=x-1  y1=y
			x2=x    y2=y+h-1
		 
		 elseif aim=="right" then
			x1=x+w    y1=y
			x2=x+w+1  y2=y+h-1
		 
		 elseif aim=="up" then
			x1=x+1    y1=y-1
			x2=x+w-1  y2=y
		 
		 elseif aim=="down" then
			x1=x      y1=y+h
			x2=x+w    y2=y+h
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