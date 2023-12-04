-- config
time_limit=30
heart_count=50

-- globals
score=0
timer=0

-- game loop
function _init()
	scene:load(title_scene)
end

function _update()
	scene.current:update()
end

function _draw()
	-- background
	cls(1)
	rect(4,12,123,123,13)

	-- scene
	scene.current:draw()

	-- ui
	prints("score: "..pad(score.."00",7),4,4,7)
	prints("time: "..pad(ceil(timer/30),2),93,4,7)
end