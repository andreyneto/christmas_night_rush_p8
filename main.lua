-- config
time_limit=30
heart_count=50

-- globals
score=0
timer=0
gravity=5
friction=0.8
speed=0.5

-- game loop
function _init()
	background:init()
	scene:load(title_scene)
	log("_init", true)
end

function _update()
	background:update()
	scene.current:update()
	if(btnp(2)) then speed += 1 end
	if(btnp(3)) then speed -= 1 end
end

function _draw()
	-- background
	cls(0)
	-- scene
	background:draw()
	scene.current:draw()
end