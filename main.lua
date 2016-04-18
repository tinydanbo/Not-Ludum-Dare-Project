io.stdout:setvbuf("no")

canvas = love.graphics.newCanvas(400, 240)
canvas:setFilter("nearest", "nearest")

StateManager = require "lib.hump.gamestate"

tick = require "lib.tick"

fonts = {
	main = love.graphics.newFont("data/fonts/04B_03__.TTF", 8)
}

states = {
	test = require "game.states.test",
	game = require "game.states.game"
}

bindings = {
	up = {"w", "up"},
	down = {"s", "down"},
	left = {"a", "left"},
	right = {"d", "right"},
	fire = {"j", "z"},
	cancel = {"k", "x"},
	special = {"l", "c"}
}

function getScaling()
	local width_scale = love.graphics.getWidth() / 400
	local height_scale = love.graphics.getHeight() / 240

	return math.min(width_scale, height_scale)
end

function resizeWindow(factor)
	local display = love.window.getDisplayCount()
	love.window.setMode(400 * factor, 240 * factor, {
		vsync = true,
		display = display
	})
end

function addEntity(entity)
	if StateManager.current().addEntity then
		StateManager.current():addEntity(entity)
	end
end

function love.load(arg)
	tick.framerate = 60
	tick.rate = 1/60
	tick.timescale = 1

	resizeWindow(2)

	StateManager.registerEvents{'update', 'quit'}
	StateManager.switch(states.game)
end

function love.draw()
	love.graphics.setCanvas(canvas)
		love.graphics.clear()
		StateManager.draw()

		love.graphics.setColor(255, 255, 255)
		love.graphics.setFont(fonts.main)
		love.graphics.printf(tostring(love.timer.getFPS()), 0, 2, 398, "right")
	love.graphics.setCanvas()

	love.graphics.setColor(255, 255, 255)
	local scaling = getScaling()
	love.graphics.draw(
		canvas,
		math.floor(love.graphics.getWidth() / 2),
		math.floor(love.graphics.getHeight() / 2),
		0,
		scaling,
		scaling,
		200,
		120
	)
end

function love.keyreleased(key)
	if key == "1" or key == "2" or key == "3" or key == "4" then
		resizeWindow(tonumber(key))
	else
		StateManager.keyreleased(key)
	end

	if key == "tab" then
		tick.timescale = 0.1
	end
end

function keyToAction(key)
	for k,v in pairs(bindings) do
		for _,v2 in ipairs(v) do
			if key == v2 then
				return k
			end
		end
	end

	return nil
end

function love.keypressed(key)
	local action = keyToAction(key)

	if action and StateManager.current().onAction then
		StateManager.current():onAction(action)
	end
end