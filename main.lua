-- config
time_limit=30
heart_count=50

-- globals
score=0
timer=0
gravity=5
friction=0.9

-- game loop
function _init()
	scene:load(title_scene)
	log("_init", true)
end

function _update()
	if btn() == 48 then stop() end
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