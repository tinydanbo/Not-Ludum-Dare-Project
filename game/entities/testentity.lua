Class = require "lib.hump.class"
Entity = require "core.entity"
TestDraw = require "game.components.testdraw"
PlayerController = require "game.components.playercontroller"

TestEntity = Class{__includes = Entity,
	init = function(self, x, y)
		Entity.init(self, x, y)

		self:addComponent("TestDraw", TestDraw(self))
		self:addComponent("PlayerController", PlayerController(self))
	end
}

return TestEntity