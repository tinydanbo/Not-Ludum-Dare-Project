Class = require "lib.hump.class"
AnimationView = require "game.components.animationview"
SimpleCollision = require "game.components.simplecollision"
LanternController = require "game.components.lanterncontroller"
HoverSway = require "game.components.hoversway"

Lantern = Class{__includes = Entity,
	init = function(self, x, y, world)
		Entity.init(self, x, y)

		self:addComponent("AnimationView", AnimationView(self, 0, 11, "data/graphics/enemies/e2", "e2.scon", "Normal"))
		self:addComponent("HoverSway", HoverSway(self, 3))
		self:addComponent("LanternController", LanternController(self))
		self:addComponent("SimpleCollision", SimpleCollision(self, "enemy", world, 24, 22))
	end
}

return Lantern