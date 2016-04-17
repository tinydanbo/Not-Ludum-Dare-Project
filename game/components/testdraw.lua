Class = require "lib.hump.class"

TestDraw = Class{
	init = function(self, entity, colors, width, height)
		self.entity = entity
		self.colors = colors
		self.width = width
		self.height = height
	end
}

function TestDraw:draw()
	local x,y = self.entity.position:unpack()

	if not self.colors then
		love.graphics.setColor(80, 80, 80)
	else
		love.graphics.setColor(unpack(self.colors))
	end

	love.graphics.rectangle("fill", math.floor(x-self.width/2), math.floor(y-self.height/2), self.width, self.height)
end

return TestDraw