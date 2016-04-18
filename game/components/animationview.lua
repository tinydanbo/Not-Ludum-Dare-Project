Class = require "lib.hump.class"
AnimationSet = require "core.animationset"

AnimationView = Class{
	init = function(self, entity, ox, oy, folder, filename, initial_animation)
		self.entity = entity
		self.ox = ox
		self.oy = oy
		self.animationSet = AnimationSet(folder, filename)
		self.animationSet:switchAnimation(initial_animation, true)
		self.flip = false

		self.animationOffsets = {}

		self.animationSet.onLoop = function(animationName)
			self.entity:broadcastEvent("animation loop", animationName)
		end
	end
}

function AnimationView:setAnimationOffset(name, x, y)
	self.animationOffsets[name] = {x = x, y = y}
end

function AnimationView:getAnimationName()
	return self.animationSet:getCurrentAnimationName()
end

function AnimationView:getFrame()
	return self.animationSet:getFrame()
end

function AnimationView:goToRandomTime()
	return self.animationSet:goToRandomTime()
end

function AnimationView:setOffset(x, y)
	self.ox = x
	self.oy = y
end

function AnimationView:switchAnimation(name, reset)
	self.animationSet:switchAnimation(name, reset)
end

function AnimationView:update()
	self.animationSet:update()
end

function AnimationView:setFlip(flip)
	self.flip = flip
	self.animationSet:setFlip(flip)
end

function AnimationView:draw(x, y, colors, animation_name, frame)
	if not x and not y then
		x,y = self.entity.position:unpack()
	end

	x = x + self.ox
	y = y + self.oy

	local currentAnimation = self:getAnimationName()

	if self.animationOffsets[currentAnimation] then
		local currentAnimationOffset = self.animationOffsets[currentAnimation]
		if self.flip then
			x = x - currentAnimationOffset.x
		else
			x = x + currentAnimationOffset.x
		end
		y = y + currentAnimationOffset.y
	end

	if colors then
		love.graphics.setColor(unpack(colors))
	else
		love.graphics.setColor(255, 255, 255)
	end

	self.animationSet:draw(x, y, animation_name, frame)
end

return AnimationView