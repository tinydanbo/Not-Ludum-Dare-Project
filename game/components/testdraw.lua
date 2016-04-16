Class = require "lib.hump.class"

TestDraw = Class{
	init = function(self, entity)
		self.entity = entity
	end
}

function TestDraw:draw(x, y, colors)
	if not x and not y then
		x,y = self.entity.position:unpack()
	end

	if not colors then
		love.graphics.setColor(80, 80, 80)
	else
		love.graphics.setColor(unpack(colors))
	end

	love.graphics.rectangle("fill", math.floor(x-8), math.floor(y-8), 16, 16)
end

return TestDraw