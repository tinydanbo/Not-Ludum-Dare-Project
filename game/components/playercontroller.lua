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

	if love.keyboard.isDown("w") then
		desiredMovement.y = -1
	elseif love.keyboard.isDown("s") then
		desiredMovement.y = 1
	end

	if love.keyboard.isDown("a") then
		desiredMovement.x = -1
	elseif love.keyboard.isDown("d") then
		desiredMovement.x = 1
	end

	self.entity:move(desiredMovement:normalized() * self.speed)
end

return PlayerController