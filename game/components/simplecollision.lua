Class = require "lib.hump.class"
Vector = require "lib.hump.vector"

SimpleCollision = Class{
	init = function(self, entity, tag, world, width, height, ox, oy)
		self.entity = entity
		self.tag = tag
		self.world = world
		
		self.l = entity.position.x - (width/2) + (ox or 0)
		self.t = entity.position.y - (height/2) + (oy or 0)
		self.w = width
		self.h = height
		self.ox = ox or 0
		self.oy = oy or 0

		world:add(self, self.l, self.t, self.w, self.h)
	end
}

function SimpleCollision:onDestroy()
	self.world:remove(self)
end

function SimpleCollision:tryMove(movement)
	local actualX, actualY, cols, len = self.world:move(self, self.l + movement.x, self.t + movement.y, function(item, other)
		if not item.tag or not other.tag then
			return "slide"
		end

		if (item.tag == "player" and other.tag == "playerattack") or
			(item.tag == "playerattack" and other.tag == "player") then
			return "cross"
		end

		if (item.tag == "playerattack" and other.tag == "playerattack") then
			return "cross"
		end

		return "slide"
	end)

	for i,v in ipairs(cols) do
		self.entity:onCollide(v)
	end

	self.l = actualX
	self.t = actualY

	local entityX = actualX + (self.w / 2) - self.ox
	local entityY = actualY + (self.h / 2) - self.oy

	return entityX, entityY
end

function SimpleCollision:draw()
	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.rectangle("line", math.floor(self.l), math.floor(self.t), self.w, self.h)
end

return SimpleCollision