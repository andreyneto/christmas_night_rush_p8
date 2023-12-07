scene=class:extend({
	current=nil,

	update=noop,
	draw=noop,

	destroy=function(_ENV)
		entity:each("destroy")
	end,

	load=function(_ENV,scn)
		if current != scn then
			if (current) current:destroy()
			current=scn()
		end
	end
})