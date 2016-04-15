Class = require "lib.hump.class"

Manager = Class{
	init = function(self)
		self.entities = {}
		self.count = 0
	end
}

function Manager:add(entity)
	table.insert(self.entities, entity)
	self.count = self.count + 1
end

function Manager:update()
	for i,v in ipairs(self.entities) do
		v:update()
	end
end

function Manager:draw()
	for i,v in ipairs(self.entities) do
		v:draw()
	end
end

function Manager:update(dt)
	local i = 1
	local entityTable = self.entities
	while i <= #entityTable do
		entityTable[i]:update(dt)
		if entityTable[i] and entityTable[i].isDestroyed then
			table.remove(self.entities, i)
			self.count = self.count - 1
		else
			i = i + 1
		end
	end
end

return Manager