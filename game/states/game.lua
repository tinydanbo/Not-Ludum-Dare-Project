Manager = require "core.manager"
Player = require "game.entities.player"
Camera = require "lib.hump.camera"

bump = require "lib.bump"

local game = {}

function game:enter()
	self.world = bump.newWorld(32)
	self.camera = Camera(400, 240)

	self.platforms = {
		{0, 220, 400, 20},
		{0, 140, 200, 20},
		{380, 40, 20, 180}
	}

	for i,v in ipairs(self.platforms) do
		self.world:add({}, unpack(v))
	end

	self.manager = Manager()
	self.player = Player(180, 180, self.world)
	self.manager:add(self.player)
end

function game:update()
	self.camera:lookAt(math.floor(self.player.position.x) + 200, 240)
	self.manager:update()
end

function game:draw()
	self.camera:attach()

		love.graphics.setColor(200, 200, 200)

		for i,v in ipairs(self.platforms) do
			love.graphics.rectangle("fill", unpack(v))
		end

		love.graphics.setColor(255, 255, 255)
		self.manager:draw()
	self.camera:detach()
end

function game:onAction(action)
	self.player:onAction(action)
end

return game