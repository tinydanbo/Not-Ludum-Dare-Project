Class = require "lib.hump.class"
Vector = require "lib.hump.vector"

Entity = Class{
	init = function(self, x, y)
		self.position = Vector(x, y)
		self.components = {}
	end
}

function Entity:move(movement)
	local moved_indirect = false
	for k,v in pairs(self.components) do
		if v.tryMove then
			moved_indirect = true
			local actual_x, actual_y = v:tryMove(movement)
			self.position.x = actual_x
			self.position.y = actual_y
		end
	end

	if not moved_indirect then
		self.position = self.position + movement
	end
end

function Entity:broadcastEvent(event, ...)
	for k,v in pairs(self.components) do
		if v.receiveEvent then
			v:receiveEvent(event, ...)
		end
	end
end

function Entity:addComponent(key, component)
	self.components[key] = component
end

function Entity:getComponent(key)
	if self.components[key] then
		return self.components[key]
	end
end

function Entity:destroy()
	for k,v in pairs(self.components) do
		if v.onDestroy then
			v:onDestroy()
		end
	end
	
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
		if v.beforeDraw then
			v:beforeDraw()
		end
	end

	for k,v in pairs(self.components) do
		if v.draw then
			v:draw()
		end
	end

	for k,v in pairs(self.components) do
		if v.drawAfter then
			v:drawAfter()
		end
	end
end

function Entity:onCollide(collision)
	for k,v in pairs(self.components) do
		if v.onCollide then
			v:onCollide(collision)
		end
	end
end

function Entity:onAction(action)
	for k,v in pairs(self.components) do
		if v.onAction then
			v:onAction(action)
		end
	end
end

return Entity