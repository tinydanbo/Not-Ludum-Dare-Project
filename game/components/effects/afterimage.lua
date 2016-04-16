Class = require "lib.hump.class"

AfterImages = Class{
	init = function(self, entity)
		self.positions = {}
		self.entity = entity
		self.frameCount = 0
		self.hidden = true

		self.drawConfig = {
			{frame_no = 59, opacity = 0.5},
			{frame_no = 57, opacity = 0.5},
			{frame_no = 55, opacity = 0.5}
		}

		-- prepopulate the known images table
		for i=1,60,1 do
			self:update()
		end
	end
}

function AfterImages:update()
	while self.frameCount > 59 do
		table.remove(self.positions, 1)
		self.frameCount = self.frameCount - 1
	end

	self.frameCount = self.frameCount + 1
	table.insert(self.positions, {x = self.entity.position.x, y = self.entity.position.y})
end

function AfterImages:show()
	self.hidden = false
end

function AfterImages:hide()
	self.hidden = true
end

function AfterImages:draw()
	if self.hidden then return end

	local entityDrawComponent = self.entity:getComponent("TestDraw")
	for i,v in ipairs(self.drawConfig) do
		local frame = self.positions[v.frame_no]
		entityDrawComponent:draw(frame.x, frame.y, {0, 0, 200, v.opacity * 255})
	end
end

return AfterImages