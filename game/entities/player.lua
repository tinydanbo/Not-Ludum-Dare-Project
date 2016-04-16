Class = require "lib.hump.class"
Entity = require "core.entity"
TestDraw = require "game.components.testdraw"
AfterImage = require "game.components.effects.afterimage"
AnimationView = require "game.components.animationview"
PlayerController = require "game.components.playercontroller"

Player = Class{__includes = Entity,
	init = function(self, x, y, world)
		Entity.init(self, x, y)

		self:addComponent("AfterImage", AfterImage(self))
		self:addComponent("AnimationView", AnimationView(self, 0, 10, "data/graphics/player", "player.scon", "Idle"))
		self:addComponent("PlayerController", PlayerController(self, world))
	end
}

return Player