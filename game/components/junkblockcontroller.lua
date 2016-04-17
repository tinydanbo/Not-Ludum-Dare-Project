Class = require "lib.hump.class"
Vector = require "lib.hump.vector"
Timer = require "lib.hump.timer"

JunkBlockController = Class{
	init = function(self, entity)
		self.entity = entity
	end
}

function JunkBlockController:onCollide(entity, hitbox, collision)
	if hitbox.tag == "playerattack" then
		self.entity:destroy()
	end
end

return JunkBlockController