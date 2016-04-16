Class = require "lib.hump.class"
Timer = require "lib.hump.timer"

function lerp(a,b,t) return (1-t)*a + t*b end

AfterImages = Class{
	init = function(self, entity)
		self.positions = {}
		self.entity = entity
		self.frameCount = 0
		self.hidden = true
		self.positionVariation = 0
		self.timer = Timer.new()

		self.drawConfig = {
			{frame_no = 58, opacity = 1},
			{frame_no = 56, opacity = 1},
			{frame_no = 54, opacity = 1}
		}

		-- prepopulate the known images table
		for i=1,60,1 do
			self:update()
		end
	end
}

function AfterImages:update()
	self.timer.update(1)
	while self.frameCount > 59 do
		table.remove(self.positions, 1)
		self.frameCount = self.frameCount - 1
	end

	local entityDrawComponent = self.entity:getComponent("AnimationView")

	self.frameCount = self.frameCount + 1
	table.insert(self.positions, {
		x = self.entity.position.x, 
		y = self.entity.position.y, 
		animation = entityDrawComponent:getAnimationName(),
		frame = entityDrawComponent:getFrame()
	})
end

function AfterImages:show()
	self.timer.clear()
	self.hidden = false
	self.positionVariation = 0
	self.timer.tween(15, self, {positionVariation = 1}, "in-quad")
end

function AfterImages:hide()
	self.timer.clear()
	self.positionVariation = 1
	self.timer.tween(15, self, {positionVariation = 0}, "out-quad", function()
		self.hidden = true
	end)
end

function AfterImages:beforeDraw()
	if self.hidden then return end

	local entityDrawComponent = self.entity:getComponent("AnimationView")
	for i,v in ipairs(self.drawConfig) do
		local frame = self.positions[v.frame_no]
		entityDrawComponent:draw(
			lerp(self.entity.position.x, frame.x, self.positionVariation), 
			lerp(self.entity.position.y, frame.y, self.positionVariation), 
			{0, 0, 200, v.opacity * 255}, frame.animation, frame.frame
		)
	end
	print("--")
end

return AfterImages