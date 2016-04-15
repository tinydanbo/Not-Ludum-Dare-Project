io.stdout:setvbuf("no")

canvas = love.graphics.newCanvas(400, 240)
canvas:setFilter("nearest", "nearest")

fonts = {
	main = love.graphics.newFont("data/fonts/04B_03__.TTF", 8)
}

function getScaling()
	local width_scale = love.graphics.getWidth() / 400
	local height_scale = love.graphics.getHeight() / 240

	return math.min(width_scale, height_scale)
end

function resizeWindow(factor)
	love.window.setMode(400 * factor, 240 * factor)
end

function love.draw()
	love.graphics.setCanvas(canvas)
		love.graphics.clear()
		love.graphics.setColor(
			(math.sin(love.timer.getTime()*0.4) * 120) + 120, 
			(math.cos(love.timer.getTime()*1.8) * 120) + 120,
			(math.sin(love.timer.getTime()*1.2) * 120) + 120
		)
		love.graphics.rectangle("fill", 0, 0, 400, 240)
		love.graphics.setColor(255, 255, 255)
		love.graphics.setFont(fonts.main)
		love.graphics.print("\"Our frothing demand for this game increases\" - IGN", 20, 20)
		love.graphics.printf("1-4 changes window size...", 0, 228, 396, "right")
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
	end
end