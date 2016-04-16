Class = require "lib.hump.class"
Entity = require "core.entity"
TestDraw = require "game.components.testdraw"
AfterImage = require "game.components.effects.afterimage"
AnimationSet = require "game.components.animationset"
PlayerController = require "game.components.playercontroller"

Player = Class{__includes = Entity,
	init = function(self, x, y, world)
		Entity.init(self, x, y)

		-- self:addComponent("AfterImage", AfterImage(self))
		self:addComponent("AnimationSet", AnimationSet(self, 0, -17, "data/graphics/player", "player.scon", "Walk"))
		self:addComponent("PlayerController", PlayerController(self, world))
	end
}

return Player