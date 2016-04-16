Class = require "lib.hump.class"
AnimationSet = require "core.animationset"

AnimationView = Class{
	init = function(self, entity, ox, oy, folder, filename, initial_animation)
		self.entity = entity
		self.ox = ox
		self.oy = oy
		self.animationSet = AnimationSet(folder, filename)
		self.animationSet:switchAnimation(initial_animation, true)
	end
}

function AnimationView:switchAnimation(name, reset)
	self.animationSet:switchAnimation(name, reset)
end

function AnimationView:update()
	self.animationSet:update()
end

function AnimationView:setFlip(flip)
	self.animationSet:setFlip(flip)
end

function AnimationView:draw(x, y)
	if not x and not y then
		x,y = self.entity.position:unpack()
	end

	x = x + self.ox
	y = y + self.oy

	self.animationSet:draw(x, y)
end

return AnimationView