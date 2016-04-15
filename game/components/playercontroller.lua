Class = require "lib.hump.class"
Vector = require "lib.hump.vector"

PlayerController = Class{
	init = function(self, entity)
		self.entity = entity
		self.speed = 2
	end
}

function PlayerController:update()
	local desiredMovement = Vector(0, 0)

	if love.keyboard.isDown(unpack(bindings.up)) then
		desiredMovement.y = -1
	elseif love.keyboard.isDown(unpack(bindings.down)) then
		desiredMovement.y = 1
	end

	if love.keyboard.isDown(unpack(bindings.left)) then
		desiredMovement.x = -1
	elseif love.keyboard.isDown(unpack(bindings.right)) then
		desiredMovement.x = 1
	end

	self.entity:move(desiredMovement:normalized() * self.speed)
end

return PlayerController