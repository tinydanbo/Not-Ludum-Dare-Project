Class = require "lib.hump.class"
Entity = require "core.entity"
SimpleCollision = require "game.components.simplecollision"

PlayerMeleeAttack = Class{__includes = Entity,
	init = function(self, parent, world, x, y, width, height, duration)
		Entity.init(self, parent.position.x + x, parent.position.y + y)
		self.parent = parent
		self.ox = x
		self.oy = y
		self.duration = duration

		self:addComponent("SimpleCollision", SimpleCollision(self, "playerattack", world, width, height))
	end
}

function PlayerMeleeAttack:update()
	local playerController = self.parent:getComponent("PlayerController")
	local desiredPosition = self.parent.position + Vector(self.ox * playerController:getOrientation().x, self.oy)
	local difference = desiredPosition - self.position

	self:move(difference)

	self.duration = self.duration - 1
	if self.duration <= 0 then
		self:destroy()
	end
end

return PlayerMeleeAttack