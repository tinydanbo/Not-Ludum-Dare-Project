Manager = require "core.manager"
Player = require "game.entities.player"
Camera = require "lib.hump.camera"
Timer = require "lib.hump.timer"
TestTarget = require "game.entities.testtarget"
Spinner = require "game.entities.enemies.spinner"
Lantern = require "game.entities.enemies.lantern"
JunkBlock = require "game.entities.enemies.junkblock"

bump = require "lib.bump"
sti = require "lib.sti"

local game = {}

function game:enter()
	math.randomseed(1231522345)

	self.world = bump.newWorld(32)
	self.camera = Camera(400, 240)

	self.map = sti.new("data/maps/test_map.lua", {'bump'})
	self.map:bump_init(self.world)

	self.timer = Timer.new()

	self.manager = Manager()
	self.player = Player(180, 180, self.world)
	self.manager:add(self.player)

	self:spawnEnemies()
end

function game:spawnEnemies()
	local entities_layer = self.map.layers["Entities"]

	for i,entity in ipairs(entities_layer.objects) do
		local entity_x = entity.x + (entity.width / 2)
		local entity_y = entity.y + (entity.height / 2)

		if entity.type == "spinner" then
			self:spawnSpinner(entity_x, entity_y, entity.x, entity.x + entity.width)
		elseif entity.type == "lantern" then
			self:spawnLantern(entity_x, entity_y)
		elseif entity.type == "junk" then
			self:spawnJunkBlock(entity_x, entity_y)
		end
	end

	-- print_r(entities_layer)

	entities_layer.visible = false
end

function game:spawnSpinner(x, y, min_x, max_x)
	self.manager:add(Spinner(x, y, self.world, min_x, max_x))
end

function game:spawnLantern(x, y)
	self.manager:add(Lantern(x, y, self.world))
end

function game:spawnJunkBlock(x, y)
	self.manager:add(JunkBlock(x, y, self.world))
end

function game:update()
	self.timer.update(1)
	local player_x_look = math.floor(self.player.position.x) + ((GAME_SCALE - 1)*200)
	local clamped_x_look = math.min(math.max(GAME_SCALE*200, player_x_look), 600 + ((GAME_SCALE-1)*200))
	self.camera:lookAt(clamped_x_look, (GAME_SCALE * 120))
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