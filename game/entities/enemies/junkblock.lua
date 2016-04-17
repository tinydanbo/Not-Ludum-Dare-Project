Class = require "lib.hump.class"
AnimationView = require "game.components.animationview"
SimpleCollision = require "game.components.simplecollision"
JunkBlockController = require "game.components.junkblockcontroller"

JunkBlock = Class{__includes = Entity,
	init = function(self, x, y, world)
		Entity.init(self, x, y)

		self:addComponent("AnimationView", AnimationView(self, 0, 16, "data/graphics/enemies/e3", "e3.scon", "Idle"))
		self:addComponent("SimpleCollision", SimpleCollision(self, "enemy", world, 30, 30))
		self:addComponent("JunkBlockController", JunkBlockController(self))

		self:getComponent("AnimationView"):goToRandomTime()
	end
}

return JunkBlock