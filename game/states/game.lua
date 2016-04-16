Manager = require "core.manager"
Player = require "game.entities.player"
Camera = require "lib.hump.camera"

bump = require "lib.bump"
sti = require "lib.sti"

local game = {}

function game:enter()
	self.world = bump.newWorld(32)
	self.camera = Camera(400, 240)

	self.map = sti.new("data/maps/test_map.lua", {'bump'})
	self.map:bump_init(self.world)

	self.manager = Manager()
	self.player = Player(180, 180, self.world)
	self.manager:add(self.player)
end

function game:update()
	local player_x_look = math.floor(self.player.position.x) + 200
	local clamped_x_look = math.min(math.max(400, player_x_look), 800)
	self.camera:lookAt(clamped_x_look, 240)
	self.manager:update()
end

function game:draw()
	self.camera:attach()

		love.graphics.setColor(200, 200, 200)

		self.map:draw()

		love.graphics.setColor(255, 255, 255)
		self.manager:draw()
	self.camera:detach()
end

function game:onAction(action)
	self.player:onAction(action)
end

return game