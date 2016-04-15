Class = require "lib.hump.class"
Vector = require "lib.hump.vector"

Entity = Class{
	init = function(self, x, y)
		self.position = Vector(x, y)
		self.components = {}
	end
}

function Entity:move(movement)
	self.position = self.position + movement
end

function Entity:addComponent(key, component)
	self.components[key] = component
end

function Entity:destroy()
	self.isDestroyed = true
end

function Entity:update()
	for k,v in pairs(self.components) do
		if v.update then
			v:update()
		end
	end
end

function Entity:draw()
	for k,v in pairs(self.components) do
		if v.draw then
			v:draw()
		end
	end
end

return Entity