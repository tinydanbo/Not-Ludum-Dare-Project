Class = require "lib.hump.class"

TestDraw = Class{
	init = function(self, entity)
		self.entity = entity
	end
}

function TestDraw:draw()
	local x,y = self.entity.position:unpack()

	love.graphics.setColor(80, 80, 80)
	love.graphics.rectangle("fill", x-8, y-8, 16, 16)
end

return TestDraw