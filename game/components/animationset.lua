Class = require "lib.hump.class"
json = require "lib.json.json"

AnimationSet = Class{
	init = function(self, entity, x, y, folder, file, starting_animation)
		self.entity = entity
		self.x_offset = x
		self.y_offset = y
		self.flip_x = false

		local file_contents = love.filesystem.read(folder .. "/" .. file)

		local file_decoded = json.decode(file_contents)

		self:loadImageFiles(file_decoded, folder)
		self:loadAnimations(file_decoded)

		self:switchAnimation(starting_animation)
	end
}

function AnimationSet:getCurrentAnimationName()
	for k,v in pairs(self.animations) do
		if v == self.currentAnimation then
			return k
		end
	end
end

function AnimationSet:switchAnimation(name)
	self.currentAnimation = self.animations[name]
	-- self.currentAnimation.time = 0
end

function AnimationSet:update()
	local interval = math.floor(1000/60)

	self.currentAnimation.time = self.currentAnimation.time + interval
	if self.currentAnimation.time > self.currentAnimation.total_time then
		self.currentAnimation.time = self.currentAnimation.time - self.currentAnimation.total_time
	end
end

function AnimationSet:loadAnimations(contents)
	local spriter_animations = contents.entity[1].animation

	self.animations = {}

	for i,v in ipairs(spriter_animations) do
		local animation_name = v.name
		local animation = {
			time = 0,
			total_time = v.length,
			frames = {}
		}
		for _,v2 in ipairs(v.timeline) do
			local new_frame = {
				file_id = v2.key[1].object.file,
				time = v2.key[1].time,
				x_offset = v2.key[1].object.x or 0,
				y_offset = v2.key[1].object.y or 0
			}
			table.insert(animation.frames, new_frame)
		end
		self.animations[animation_name] = animation
	end
end

function AnimationSet:loadImageFiles(contents, folderPath)
	local spriter_files = contents.folder[1].file

	self.files = {}

	for i,v in ipairs(spriter_files) do
		self.files[v.id] = {
			height = v.height,
			width = v.width,
			pivot_x = math.floor(v.pivot_x * v.width),
			pivot_y = math.floor(v.pivot_y * v.height),
			image = love.graphics.newImage(folderPath .. "/" .. v.name)
		}
	end
end

function AnimationSet:setFlip(flip)
	self.flip_x = flip
end

function AnimationSet:getFrame()
	local time = self.currentAnimation.time
	local frames = self.currentAnimation.frames

	for i,v in ipairs(frames) do
		if v.time and (v.time > time) then
			return i-1
		end
	end

	return #frames
end

function AnimationSet:draw()
	local x,y = self.entity.position:unpack()

	local animation_frame = self.currentAnimation.frames[self:getFrame()]
	local sprite = self.files[animation_frame.file_id]

	local scale_x = 1
	if self.flip_x then
		scale_x = scale_x * -1
	end

	love.graphics.draw(sprite.image, math.floor(x + self.x_offset), math.floor(y + self.y_offset + animation_frame.y_offset), 0, scale_x, 1, sprite.pivot_x, sprite.pivot_y)
end

return AnimationSet