-- config
time_limit=30
heart_count=50

-- globals
score=0
timer=0
speed=1
gravity=0.1
friction=0.99

-- game loop
function _init()
	scene:load(title_scene)
	log("_init", true)
end

function _update()
	scene.current:update()
	background:update()
end

function _draw()
	-- background
	cls(0)

	-- scene
	background:draw()
	scene.current:draw()
end