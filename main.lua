io.stdout:setvbuf("no")

canvas = love.graphics.newCanvas(400, 240)
canvas:setFilter("nearest", "nearest")

StateManager = require "lib.hump.gamestate"

tick = require "lib.tick"

fonts = {
	main = love.graphics.newFont("data/fonts/04B_03__.TTF", 8)
}

states = {
	test = require "game.states.test"
}

function getScaling()
	local width_scale = love.graphics.getWidth() / 400
	local height_scale = love.graphics.getHeight() / 240

	return math.min(width_scale, height_scale)
end

function resizeWindow(factor)
	love.window.setMode(400 * factor, 240 * factor)
end

function love.load(arg)
	tick.framerate = 60
	tick.rate = 1/60

	StateManager.registerEvents{'update', 'quit'}
	StateManager.switch(states.test)
end

function love.draw()
	love.graphics.setCanvas(canvas)
		love.graphics.clear()
		StateManager.draw()
		love.graphics.setFont(fonts.main)
		love.graphics.printf(tostring(love.timer.getFPS()), 0, 2, 398, "right")
	love.graphics.setCanvas()

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
end