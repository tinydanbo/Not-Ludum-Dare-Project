Class = require "lib.hump.class"
Vector = require "lib.hump.vector"
Timer = require "lib.hump.timer"

SpinnerController = Class{
	init = function(self, entity, min_x, max_x)
		self.entity = entity
		self.velocity = Vector(0, 2)
		self.mode = "left"
		self.min_x = min_x
		self.max_x = max_x

		self.timer = Timer.new()

		if math.random(0, 10) > 5 then
			self.mode = "left"
			self.velocity.x = -2
		else
			self.mode = "right"
			self.velocity.x = 2
		end
	end
}

function SpinnerController:update()
	self.timer.update(1)
	self.entity:move(self.velocity)

	if self.mode == "left" and self.entity.position.x < self.min_x + 16 then
		self.mode = "right"
		self.timer.tween(30, self.velocity, {x = 2}, "linear")
	elseif self.mode == "right" and self.entity.position.x > self.max_x - 16 then
		self.mode = "left"
		self.timer.tween(30, self.velocity, {x = -2}, "linear")
	end
end

function SpinnerController:onCollide(entity, hitbox, collision)
	if hitbox.tag == "playerattack" then
		self.entity:destroy()
	end
end

return SpinnerController