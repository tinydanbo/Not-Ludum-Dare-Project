Manager = require "core.manager"
TestEntity = require "game.entities.testentity"

local test = {}

function test:enter()
	self.manager = Manager()
	self.manager:add(TestEntity(100, 100))
end

function test:update()
	self.manager:update()
end

function test:draw()
	love.graphics.setColor(
		(math.sin(love.timer.getTime()*0.4) * 120) + 120, 
		(math.cos(love.timer.getTime()*1.8) * 120) + 120,
		(math.sin(love.timer.getTime()*1.2) * 120) + 120
	)
	love.graphics.rectangle("fill", 0, 0, 400, 240)
	love.graphics.setColor(255, 255, 255)
	love.graphics.setFont(fonts.main)
	love.graphics.print("\"Our frothing demand for this game increases\" - IGN", 20, 20)

	self.manager:draw()

	love.graphics.setColor(255, 255, 255)
	love.graphics.printf("1-4 changes window size...", 0, 228, 396, "right")
end

return test