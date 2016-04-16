Manager = require "core.manager"
AnimationSet = require "core.animationset"

local test = {}

function test:enter()
	self.animationSet = AnimationSet("data/graphics/player", "player.scon")

	self.animations = {"Idle", "Walk", "Dash", "Jump", "Flinch", "Attack1", "Attack2", "Attack3"}
	self.animation_no = 1

	self.animationSet:switchAnimation("Idle", true)
end

function test:update()
	self.animationSet:update()
end

function test:draw()
	love.graphics.setColor(100, 100, 100, 255)
	love.graphics.line(50, 0, 50, 240)
	love.graphics.line(0, 50, 400, 50)
	love.graphics.setColor(255, 255, 255)
	self.animationSet:draw(50, 50)
	love.graphics.print(self.animations[self.animation_no], 10, 10)
end

function test:onAction()
	self.animation_no = self.animation_no + 1
	if self.animation_no > #self.animations then
		self.animation_no = 1
	end
	self.animationSet:switchAnimation(self.animations[self.animation_no], true)
end

return test