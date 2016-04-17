Class = require "lib.hump.class"
Entity = require "core.entity"
TestDraw = require "game.components.testdraw"
AfterImage = require "game.components.effects.afterimage"
AnimationView = require "game.components.animationview"
PlayerController = require "game.components.playercontroller"
SimpleCollision = require "game.components.simplecollision"

Player = Class{__includes = Entity,
	init = function(self, x, y, world)
		Entity.init(self, x, y)

		self:addComponent("AnimationView", AnimationView(self, 0, 10, "data/graphics/player", "player.scon", "Idle"))
		self:addComponent("AfterImage", AfterImage(self))
		self:addComponent("PlayerController", PlayerController(self, world))
		self:addComponent("SimpleCollision", SimpleCollision(self, "player", world, 12, 20))
	end
}

return Player