Class = require "lib.hump.class"
AnimationView = require "game.components.animationview"
SpinnerController = require "game.components.spinnercontroller"
SimpleCollision = require "game.components.simplecollision"

Spinner = Class{__includes = Entity,
	init = function(self, x, y, world, min_x, max_x)
		Entity.init(self, x, y)

		self:addComponent("AnimationView", AnimationView(self, 0, 5, "data/graphics/enemies/e1", "e1.scon", "default"))
		self:addComponent("SpinnerController", SpinnerController(self, min_x, max_x))
		self:addComponent("SimpleCollision", SimpleCollision(self, "enemy", world, 18, 10))
	end
}

return Spinner