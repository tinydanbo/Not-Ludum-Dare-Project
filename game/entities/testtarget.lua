Class = require "lib.hump.class"
Entity = require "core.entity"
SimpleCollision = require "game.components.simplecollision"
TestDraw = require "game.components.testdraw"

TestTarget = Class{__includes = Entity,
	init = function(self, world, x, y)
		Entity.init(self, x, y)

		self:addComponent("SimpleCollision", SimpleCollision(self, "enemy", world, 12, 12))
		self:addComponent("TestDraw", TestDraw(self, {240, 0, 0}, 12, 12))
	end
}

function TestTarget:onCollide(other, hitbox, collision)
	if hitbox.tag == "playerattack" then
		self:destroy()
	end
end

return TestTarget