Class = require "lib.hump.class"
Vector = require "lib.hump.vector"

HoverSway = Class{
	init = function(self, entity, amplitude)
		self.entity = entity
		self.amplitude = amplitude
		self.transform = Vector(0, 0)
		self.time = math.random(0, 360)
	end
}

function HoverSway:update()
	self.time = self.time + 2

	local desiredTransform = Vector(0, math.sin(math.rad(self.time))*self.amplitude)
	local difference = desiredTransform - self.transform

	self.entity:move(difference)
	self.transform = desiredTransform
end 

return HoverSway