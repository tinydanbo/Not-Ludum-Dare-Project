Class = require "lib.hump.class"

Hitbox = Class{
	init = function(self, entity, world, w, h, ox, oy)
		self.entity = entity
		self.world = world

		self.l = entity.position.x - (w/2) + ox
		self.t = entity.position.y - (h/2) + oy
		self.w = w
		self.h = h
		self.ox = ox
		self.oy = oy

		world:add(self, self.l, self.t, self.w, self.h)
	end
}

-- returns actualx and actualy of entity
function Hitbox:move(movement)
	local actualX, actualY, cols, len = self.world:move(self, self.l + movement.x, self.t + movement.y)

	for i,v in ipairs(cols) do
		self.entity:onCollide(v)
	end

	self.l = actualX
	self.t = actualY

	local entityX = actualX + (self.w / 2) - self.ox
	local entityY = actualY + (self.h / 2) - self.oy

	return entityX, entityY
end

function Hitbox:draw()
	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.rectangle("line", math.floor(self.l), math.floor(self.t), self.w, self.h)
end

return Hitbox