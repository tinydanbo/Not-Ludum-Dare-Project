Manager = require "core.manager"
Player = require "game.entities.player"
Camera = require "lib.hump.camera"
Timer = require "lib.hump.timer"
TestTarget = require "game.entities.testtarget"

bump = require "lib.bump"
sti = require "lib.sti"

local game = {}

function game:enter()
	self.world = bump.newWorld(32)
	self.camera = Camera(400, 240)

	self.map = sti.new("data/maps/test_map.lua", {'bump'})
	self.map:bump_init(self.world)

	self.timer = Timer.new()
	self.timer.every(60, function()
		local x = math.random(24, 800-24)
		local y = math.random(24, 240-24)

		self.manager:add(TestTarget(self.world, x, y))
	end)

	self.manager = Manager()
	self.player = Player(180, 180, self.world)
	self.manager:add(self.player)
end

function game:update()
	self.timer.update(1)
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

function game:addEntity(entity)
	self.manager:add(entity)
end

function game:onAction(action)
	self.player:onAction(action)
end

return game